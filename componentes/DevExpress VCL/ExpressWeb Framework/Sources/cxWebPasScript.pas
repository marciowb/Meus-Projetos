{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Server-side Script Implementor                              }
{                                                                   }
{       Copyright (c) 2000-2010 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSWEB FRAMEWORK AND ALL         }
{   ACCOMPANYING VCL CLASSES AS PART OF AN EXECUTABLE WEB           }
{   APPLICATION ONLY.                                               }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}
unit cxWebPasScript;

interface

uses
  Classes, SysUtils, HttpProd, Contnrs,
  cxWebScript, cxWebIntf,
  ifps3, ifps3debug, ifpscomp, ifpiclass, ifpiclassruntime;

type
  TcxPascalScriptRTEvent = procedure(Exec: TIFPSExec) of object;
  TcxPascalScriptCompRegEvent = procedure(Comp: TIFPSPascalCompiler; Imp: TIFPSCompileTimeClassesImporter) of object;
  TcxPascalScriptExecRegEvent = procedure(Exec: TIFPSExec; Imp: TIFPSRuntimeClassImporter) of object;

  TcxPascalScriptEngine = class
  private
    FComp: TIFPSPascalCompiler;
    FExec: TIFPSDebugExec;
    FCImp: TIFPSCompileTimeClassesImporter;
    FRImp: TIFPSRuntimeClassImporter;
    FIncludedImporterList: TClassList;
    FScript: string;
    FOnAssignScriptVars: TcxPascalScriptRTEvent;
    FOnCompRegistration: TcxPascalScriptCompRegEvent;
    FOnExecRegistration: TcxPascalScriptExecRegEvent;
    function IsCompileError: Boolean;
    function GetCompileErrorCount: Integer;
    function GetCompileError(Index: Integer): PIFPSPascalCompilerMessage;
    function GetErrorCount: Integer;
    procedure ConvertPosition(const APos: Integer; out X, Y: Integer);
    procedure CommonRuntimeRegistration;
    procedure CommonCompileRegistration;
  protected
    function Compile: Boolean;
    function Execute: Boolean;
    function DoOnUses(ASender: TIFPSPascalCompiler; const AName: string): Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    function GetErrorDesc(Index: Integer): string;
    function GetErrorCode(Index: Integer): Integer;
    function GetErrorLine(Index: Integer): Integer;
    function GetErrorPos(Index: Integer): Integer;
    function GetErrorSource(Index: Integer): string;
    function GetErrorSrcLine(Index: Integer): string;
    property Script: string write FScript;
    property ErrorCount: Integer read GetErrorCount;
    property OnAssignScriptVars: TcxPascalScriptRTEvent read FOnAssignScriptVars write FOnAssignScriptVars;
    property OnCompRegistration: TcxPascalScriptCompRegEvent read FOnCompRegistration write FOnCompRegistration;
    property OnExecRegistration: TcxPascalScriptExecRegEvent read FOnExecRegistration write FOnExecRegistration;
  end;

  TcxWebPascalScripter = class(TComponent, IcxWebScripter)
  private
    FNamedItems: TStrings;
    FPascalScript: TcxPascalScriptEngine;
    procedure AssignScriptVariables(Exec: TIFPSExec);
    procedure CompRegisteration(Comp: TIFPSPascalCompiler; Imp: TIFPSCompileTimeClassesImporter);
    procedure ExecRegisteration(Exec: TIFPSExec; Imp: TIFPSRuntimeClassImporter);
  protected
    { IcxWebScripter }
    procedure AddGlobalObjects(AProducer: TAbstractScriptProducer);
    procedure AddComponents(AProducer: TAbstractScriptProducer);
    procedure ClearAll;
    procedure Run(const AText, AScriptEngine: string);

    property PascalScript: TcxPascalScriptEngine read FPascalScript;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TcxWebPascalScriptProducer = class(TcxWebScriptProducer)
  private
    FScripter: TcxWebPascalScripter;
  protected
    function GetScripter: IcxWebScripter; override;
    function GetScripterErrors: TAbstractScriptErrors; override;
    procedure WriteString(const Value: string);
  public
    destructor Destroy; override;
  end;

const
  IfPasScript = TcxScriptEngine(3);

implementation

uses
  WebCntxt,
  cxWebPasScriptStrs, cxWebPasImpFactory, cxWebSess,
  ifps3common, ifps3utl, ifpicall, ifpidll2, ifpidll2runtime, ifpidelphi, ifpidelphiruntime,
  ifpidateutils, ifpidateutilsr, ifps3lib_std, ifps3lib_stdr,
  ifpii_classes, ifpiir_classes, ifpii_std, ifpiir_std, ifpii_DB, ifpiir_DB,
  cxWebPasImp, cxWebPasDBImp, cxWebPasGlobalImp;

{ TcxPascalScriptEngine }

function GlobalOnUses(Sender: TIFPSPascalCompiler; const Name: string): Boolean;
begin
  Result := TcxPascalScriptEngine(Sender.ID).DoOnUses(Sender, Name);
end;

constructor TcxPascalScriptEngine.Create;
begin
  inherited;
  FComp := TIFPSPascalCompiler.Create;
  FComp.ID := Self;
  FComp.OnUses := GlobalOnUses;
  FComp.OnExternalProc := DllExternalProc;
  FComp.Clear;
  FComp.AllowNoBegin := False;
  FComp.AllowUnit := True;
  FComp.AllowNoEnd := False;

  FExec := TIFPSDebugExec.Create;
  FExec.Clear;
  FExec.CleanUp;
  FExec.ClearFunctionList;
  FIncludedImporterList := TClassList.Create;
  FRImp := TIFPSRuntimeClassImporter.Create;
end;

destructor TcxPascalScriptEngine.Destroy;
begin
  FRImp.Free;
  FExec.Free;
  FComp.Free;
  FIncludedImporterList.Free;
  inherited;
end;

function TcxPascalScriptEngine.Compile: Boolean;
begin
  Result := FComp.Compile(FScript);
end;

function TcxPascalScriptEngine.Execute: Boolean;
var
  Data: string;
  I: Integer;
begin
  CommonRuntimeRegistration;
  if Assigned(FOnExecRegistration) then
    FOnExecRegistration(FExec, FRImp);
  for I := 0 to FIncludedImporterList.Count - 1 do
    TcxPascalScriptImporterClass(FIncludedImporterList[I]).RunTimeRegistration(FRImp);
  Data := '';
  FComp.GetOutput(Data);
  FExec.LoadData(Data);
  FComp.GetDebugOutput(Data);
  FExec.LoadDebugData(Data);
  if Assigned(FOnAssignScriptVars) then
    FOnAssignScriptVars(FExec);
  Result := FExec.RunScript and (FExec.ExceptionCode = erNoError);
end;

function TcxPascalScriptEngine.DoOnUses(ASender: TIFPSPascalCompiler;
  const AName: string): Boolean;
var
  AList: TClassList;
  I: Integer;
  Current: TcxPascalScriptImporterClass;
begin
  if FCImp = nil then
    FCImp := TIFPSCompileTimeClassesImporter.Create(FComp, True);
  Result := SameText(AName, 'system');
  if Result then
  begin
    CommonCompileRegistration;
    if Assigned(FOnCompRegistration) then
      FOnCompRegistration(FComp, FCImp);
  end
  else
  begin
    AList := TClassList.Create;
    try
      cxPasScriptImpFactory.GetImporterClassList(AName, AList);
      Result := AList.Count > 0;
      for I := 0 to AList.Count - 1 do
      begin
        Current := TcxPascalScriptImporterClass(AList[I]);
        Current.CompileTimeRegistration(FCImp);
        FIncludedImporterList.Add(Current);
      end;
    finally
      AList.Free;
    end;
  end;
  if not Result then
    ASender.MakeError('', ecUnknownIdentifier, AName);
end;

function TcxPascalScriptEngine.IsCompileError: Boolean;
begin
  Result := GetCompileErrorCount > 0;
end;

function TcxPascalScriptEngine.GetCompileErrorCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to FComp.MsgCount - 1 do
    if FComp.Msg[I]^.MessageType = ptError then
      Inc(Result);
end;

function TcxPascalScriptEngine.GetCompileError(Index: Integer): PIFPSPascalCompilerMessage;
var
  I, Cnt: Integer;
begin
  Result := nil;
  Cnt := -1;
  for I := 0 to FComp.MsgCount - 1 do
    if FComp.Msg[I]^.MessageType = ptError then
    begin
      Inc(Cnt);
      Result := FComp.Msg[I];
      if Cnt = Index then break;
    end;
end;

function TcxPascalScriptEngine.GetErrorCount: Integer;
begin
  Result := GetCompileErrorCount;
  if (Result = 0) and (FExec.ExceptionCode <> erNoError) then
    Result := 1;
end;

procedure TcxPascalScriptEngine.ConvertPosition(const APos: Integer;
  out X, Y: Integer);
var
  LocPos, C: Integer;
begin
  if APos > Length(FScript) then
    LocPos := Length(FScript)
  else
    LocPos := APos;
  X := 1;
  Y := 1;
  C := 1;
  while C <= LocPos do
  begin
    if (FScript[C] = #13) or (FScript[C] = #10) then
    begin
      if ((FScript[C + 1] = #13) or (FScript[C + 1] = #10)) and
        (FScript[C] <> FScript[C + 1]) then
        Inc(C);
      X := 1;
      Inc(Y);
    end
    else
      Inc(X);
    Inc(C);
  end;
end;

function TcxPascalScriptEngine.GetErrorCode(Index: Integer): Integer;
begin
  if IsCompileError then
    Result := Ord(GetCompileError(Index)^.Error)
  else
    Result := Ord(FExec.ExceptionCode);
end;

function TcxPascalScriptEngine.GetErrorSource(Index: Integer): string;
begin
  if IsCompileError then
    Result := scxPascalCompileError
  else
    Result := scxPascalRunError;
end;

function TcxPascalScriptEngine.GetErrorDesc(Index: Integer): string;
begin
  if IsCompileError then
  begin
    Result := IFPSMessageToString(GetCompileError(Index));
    if (Pos('[', Result) > 0) and (Pos(']', Result) > 0) and (Pos(':', Result) > 0) then
      Result := PChar(Result) + Pos(':', Result);
  end
  else
    Result := TIFErrorToString(FExec.ExceptionCode, FExec.ExceptionString);
end;

function TcxPascalScriptEngine.GetErrorLine(Index: Integer): Integer;
var
  X: Integer;
begin
  if IsCompileError then
    Result := GetCompileError(Index)^.Position
  else
    Result := FExec.TranslatePosition(FExec.ExceptionProcNo, FExec.ExceptionPos);
  ConvertPosition(Result, X, Result);
end;

function TcxPascalScriptEngine.GetErrorPos(Index: Integer): Integer;
var
  Y: Integer;
begin
  if IsCompileError then
    Result := GetCompileError(Index)^.Position
  else
    Result := FExec.TranslatePosition(FExec.ExceptionProcNo, FExec.ExceptionPos);
  ConvertPosition(Result, Result, Y);
end;

function TcxPascalScriptEngine.GetErrorSrcLine(Index: Integer): string;
begin
  Result := '';
end;

procedure TcxPascalScriptEngine.CommonCompileRegistration;
begin
  RegisterStandardLibrary_C(FComp);
  RegisterDateTimeLibrary_C(FComp);
  SIRegister_Std(FCImp);
  SIRegister_Classes(FCImp);
  SIRegister_DB(FCImp);
end;

procedure TcxPascalScriptEngine.CommonRuntimeRegistration;
begin
  RegisterDLLRuntime(FExec);
  RegisterStandardLibrary_R(FExec);
  RegisterDateTimeLibrary_R(FExec);
  RIRegister_Std(FRImp);
  RIRegister_Classes(FRImp);
  RIRegister_DB(FRImp);
  RegisterClassLibraryRuntime(FExec, FRImp);
end;

{ TcxWebPascalScripter }

constructor TcxWebPascalScripter.Create(AOwner: TComponent);
begin
  inherited Create(nil);
  FNamedItems := TStringList.Create;
  FPascalScript := TcxPascalScriptEngine.Create;
  FPascalScript.OnAssignScriptVars := AssignScriptVariables;
  FPascalScript.OnCompRegistration := CompRegisteration;
  FPascalScript.OnExecRegistration := ExecRegisteration;
end;

destructor TcxWebPascalScripter.Destroy;
begin
  FNamedItems.Clear;
  FNamedItems.Free;
  FPascalScript.Free;
  inherited;
end;

procedure TcxWebPascalScripter.AssignScriptVariables(Exec: TIFPSExec);
var
  I: Integer;
begin
  for I := 0 to FNamedItems.Count - 1 do
    SetVariantToClass(Exec.GetVar2(FNamedItems[I]), FNamedItems.Objects[I]);
end;

procedure TcxWebPascalScripter.CompRegisteration(Comp: TIFPSPascalCompiler;
  Imp: TIFPSCompileTimeClassesImporter);

  function FindnearestClass(AObject: TObject): TClass;
  begin
    Result := AObject.ClassType;
    while (Imp.FindClass(Result.ClassName) = nil) and (Result <> TObject) do
      Result := Result.ClassParent;
  end;

var
  I: Integer;
  ImporterClass: TcxPascalScriptImporterClass;
  AClass: TClass;
  CTClass: TIFPSCompileTimeClass;
begin
  for I := 0 to FNamedItems.Count - 1 do
  begin
    AClass := FNamedItems.Objects[I].ClassType;
    ImporterClass := cxPasScriptImpFactory.GetImporterClass(AClass);
    if ImporterClass <> nil then
      ImporterClass.CompileTimeRegistration(Imp);
    if (ImporterClass = nil) or (ImporterClass.ObjectClass <> AClass) then
    begin
      CTClass := cxCTRegisterClass(Imp, AClass);
      if CTClass <> nil then
        CTClass.RegisterPublishedProperties;
    end;    
    AddImportedClassVariable(Comp, FNamedItems[I], AClass.ClassName);
  end;
end;

procedure TcxWebPascalScripter.ExecRegisteration(Exec: TIFPSExec;
  Imp: TIFPSRuntimeClassImporter);
var
  I: Integer;
  ImporterClass: TcxPascalScriptImporterClass;
  AClass: TClass;
begin
  for I := 0 to FNamedItems.Count - 1 do
  begin
    AClass := FNamedItems.Objects[I].ClassType;
    ImporterClass := cxPasScriptImpFactory.GetImporterClass(AClass);
    if ImporterClass <> nil then
      ImporterClass.RunTimeRegistration(Imp);
    if (ImporterClass = nil) or (ImporterClass.ObjectClass <> AClass) then
      cxRTRegisterClass(Imp, AClass);
  end;
end;

procedure TcxWebPascalScripter.AddComponents(AProducer: TAbstractScriptProducer);
var
  I: Integer;
  Module, Component: TComponent;
  ScriptProducer: IScriptProducer;
begin
  if Supports(AProducer, IScriptProducer, ScriptProducer) then
  begin
    Module := TComponent(ScriptProducer.WebModuleContext);
    if Module <> nil then
    begin
      FNamedItems.AddObject(UpperCase(cxsoForm), Module);
      FNamedItems.AddObject(UpperCase(Module.Name), Module);

      for I := 0 to Module.ComponentCount - 1 do
      begin
        Component := Module.Components[I];
        if Component.Name <> '' then
          FNamedItems.AddObject(UpperCase(Component.Name), Component);
      end;
    end;
  end;
end;

procedure TcxWebPascalScripter.AddGlobalObjects(AProducer: TAbstractScriptProducer);
begin
  FNamedItems.AddObject(UpperCase(cxsoResponse), AProducer);
  if WebContext <> nil then
  begin
    FNamedItems.AddObject(UpperCase(cxsoRequest), WebContext.Request);
    FNamedItems.AddObject(UpperCase(cxsoSession), WebContext.Session);
    FNamedItems.AddObject(UpperCase(cxsoSessions), cxWebSessions);
    FNamedItems.AddObject(UpperCase(cxsoContext), WebContext);
  end;
end;

procedure TcxWebPascalScripter.ClearAll;
begin
  FNamedItems.Clear;
end;

procedure TcxWebPascalScripter.Run(const AText, AScriptEngine: string);
begin
  FPascalScript.Script := AText;
  if FPascalScript.Compile then
    FPascalScript.Execute;
end;

{ TcxWebPascalScriptProducer }

destructor TcxWebPascalScriptProducer.Destroy;
begin
  FreeAndNil(FScripter);
  inherited;
end;

function TcxWebPascalScriptProducer.GetScripter: IcxWebScripter;
begin
  Result := nil;
  if FScripter = nil then
     FScripter := TcxWebPascalScripter.Create(nil);
  Supports(FScripter, IcxWebScripter, Result);
end;

function TcxWebPascalScriptProducer.GetScripterErrors: TAbstractScriptErrors;
var
  I: Integer;
  Error: TcxWebScriptError;
  LocPosition, LocLine, LocCharPos: Integer;
  LocFileName: string;
begin
  for I := 0 to FScripter.PascalScript.ErrorCount - 1 do
  begin
    Error := TcxWebScriptError.Create;
    LocPosition := 0;
    LocLine := FScripter.PascalScript.GetErrorLine(I);
    LocCharPos := FScripter.PascalScript.GetErrorPos(I);
    LocFileName := '';
    ScriptParser.LineNumberMap.Convert(LocPosition, LocLine, LocCharPos, LocFileName);
    with Error do
    begin
      Code := FScripter.PascalScript.GetErrorCode(I);
      Source := FScripter.PascalScript.GetErrorSource(I);
      Position := LocPosition;
      Line := LocLine;
      CharPos := LocCharPos;
      FileName := LocFileName;
      Description := FScripter.PascalScript.GetErrorDesc(I);
      SourceLine := FScripter.PascalScript.GetErrorSrcLine(I);
    end;
    Errors.Add(Error);
  end;
  Result := Errors;
end;

procedure TcxWebPascalScriptProducer.WriteString(const Value: string);
begin
  Write(Value);
end;

initialization
  AvailableScriptEngines.RegisterEngine(IfPasScript, 'IfPasScript', TcxWebPascalScriptProducer, 'cxWebPasScript', scxPascalHTMLtemplate); // Do not localize

finalization
  AvailableScriptEngines.UnregisterEngine(IfPasScript);

end.
