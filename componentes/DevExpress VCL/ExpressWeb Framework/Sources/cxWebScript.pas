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
unit cxWebScript;

{$I cxVer.inc}

{$IFDEF DELPHI7}
  {$DEFINE USESCRIPTENGINE}
{$ELSE}
  {$IFNDEF VCL}
    {$DEFINE USESCRIPTENGINE}
  {$ENDIF}
{$ENDIF}

interface

uses Classes, SysUtils, Contnrs, HttpProd, HttpApp, SyncObjs,
  {$IFDEF VCL}
  ComObj, ActiveX, cxScriptDispFactory,
  {$ENDIF}
  cxScript, cxWebScriptParser, cxWebAppSrv, cxWebIntf;

type
  {$IFDEF USESCRIPTENGINE}
  TcxScriptEnginesList = class(TAbstractScriptEnginesList)
  private
    FProdClass: TScriptProducerClass;
  public
    constructor Create(AProdClass: TScriptProducerClass);
    function FindScriptProducerClass(const ALanguageName: string): TScriptProducerClass; override;
  end;
  {$ENDIF}

  TcxWebScriptProducer = class;

  TcxWebScriptError = class(TAbstractScriptError)
  private
    FPosition: Integer;
    FCharPos: Integer;
    FCode: Integer;
    FDescription: string;
    FFileName: string;
    FLine: Integer;
    FSource: string;
    FSourceLine: string;
  protected
    function GetCharPos: Integer;  override;
    function GetCode: Integer; virtual;
    function GetDescription: string; override;
    function GetFileName: string; override;
    function GetLine: Integer; override;
    function GetSourceLine: string; override;
    function GetSource: string; virtual;
    procedure SetDescription(const AValue: string); override;
  public
    constructor Create(E: Exception); overload;
    constructor Create(ParserError: EcxWebScriptParserException); overload;
    constructor Create(AError: TcxWebScriptError); overload;
    constructor Create(AError: TcxScriptError; ALineNumberMap: TcxLineNumberMap); overload;
    property Code: Integer read GetCode write FCode;
    property FileName: string read GetFileName write FFileName;
    property Line: Integer read GetLine write FLine;
    property CharPos: Integer read GetCharPos write FCharPos;
    property Position: Integer read FPosition write FPosition;
    property Source: string read GetSource write FSource;
    property SourceLine: string read GetSourceLine write FSourceLine;
  end;

  TcxWebScriptErrors = class(TAbstractScriptErrors)
  private
    FList: TObjectList;
  protected
    function GetError(I: Integer): TAbstractScriptError; override;
    function GetErrorCount: Integer; override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(const AError: TAbstractScriptError); override;
  end;

  TcxWebScripter = class(TcxCustomScripter, IcxWebScripter)
  private
    FThreadItems: TThreadList;
    procedure ClearThreadItems;
    function GetNamedItems: TStrings;
  protected
    procedure GetNames(AStrings: TStrings); override;
    function GetObjectByName(AName: string): TObject; override;
    { IcxWebScripter }
    procedure AddGlobalObjects(AProducer: TAbstractScriptProducer);
    procedure AddComponents(AProducer: TAbstractScriptProducer);
    procedure ClearAll;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property NamedItems: TStrings read GetNamedItems;
  end;

  TcxWebScriptProducer = class(TAbstractScriptProducer, IScriptProducer, IScriptContext)
  private
    FContent: TStringStream;
    FErrors: TAbstractScriptErrors;
    FScriptEngine: string;
    FHandleTag: THandleTagProc;
    FLocateFileService: ILocateFileService;
    FStripParamQuotes: Boolean;
    FScriptParser: TcxWebScriptParser;
    FWebModuleContext: TWebModuleContext;

    function IsHTMLTag(Index: Integer): Boolean;
  protected
    function GetScripter: IcxWebScripter; virtual;
    procedure GetFileStream(ASender: TObject; const AFileName: string;
      var AStream: TStream; var AOwned: Boolean);
    procedure HandleParserError(AParserError: EcxWebScriptParserException);
    { IScriptContext }
    function GetWebModuleContext: TWebModuleContext;
    { IScriptProducer }
    function Evaluate: string;
    function GetContent: string;
    function GetScripterErrors: TAbstractScriptErrors; virtual;
    function GetErrors: TAbstractScriptErrors;
    function GetHTMLBlock(I: Integer): {$IFDEF USESCRIPTENGINE}string{$ELSE}WideString{$ENDIF};
    function GetHTMLBlockCount: Integer;
    function HandleScriptError(const ScriptError: IUnknown): HRESULT;
    procedure ParseStream(Stream: TStream; Owned: Boolean);
    procedure ParseString(const S: string);
    function ReplaceTags(const AValue: string): string;
    procedure SetContent(const Value: string);
    procedure Write(const AValue: PWideChar; ALength: Integer); overload;
    procedure Write(const Value: string); overload;
    procedure WriteItem(Index: Integer);

    property Scripter: IcxWebScripter read GetScripter;
    property ScriptParser: TcxWebScriptParser read FScriptParser;
  public
    constructor Create(AWebModuleContext: TWebModuleContext;
        AStripParamQuotes: Boolean; AHandleTag: THandleTagProc;
        const AScriptEngine: string; ALocateFileService: ILocateFileService); override;
    destructor Destroy; override;

    property Errors: TAbstractScriptErrors read GetErrors;
    property LocateFileService: ILocateFileService read FLocateFileService;
  end;

  TcxScriptEngines = class
  private
    FList: TThreadList;
  protected
    function GetCount: Integer;
    function GetEngine(Index: Integer): TcxScriptEngine;
    procedure Delete(AIndex: Integer);
  public
    constructor Create;
    destructor Destroy; override;
    function GetEngineName(AEngine: TcxScriptEngine): string;
    function GetEngineUnit(AEngine: TcxScriptEngine): string;
    function GetEngineTemplate(AEngine: TcxScriptEngine): string;
    function GetProducerClass(AName: string): TScriptProducerClass;
    function IndexOf(AEngine: TcxScriptEngine): Integer;
    function IndexOfName(const AName: string): Integer;
    procedure RegisterEngine(AEngine: TcxScriptEngine; const AName: string;
      AProducerClass: TScriptProducerClass; const AUnitName, AHTMLTemplate: string);
    procedure UnregisterEngine(AEngine: TcxScriptEngine);
    property Count: Integer read GetCount;
    property Engine[Index: Integer]: TcxScriptEngine read GetEngine;
  end;

procedure cxInitScriptProducer(AClass: TScriptProducerClass);
procedure cxFinishScriptProducer;
{$IFDEF USESCRIPTENGINE}
function cxGetSaveScriptEnginesList: TAbstractScriptEnginesList;
{$ELSE}
function cxGetSaveScriptProducerClass: TScriptProducerClass;
{$ENDIF}
function AvailableScriptEngines: TcxScriptEngines;

const
  cxsoResponse = 'Response'; // Do not localize
  cxsoRequest = 'Request'; // Do not localize
  cxsoSession = 'Session'; // Do not localize
  cxsoSessions = 'Sessions'; // Do not localize
  cxsoContext = 'Context'; // Do not localize
  cxsoForm = 'Form'; // Do not localize

{$IFDEF VCL}
  JScript = TcxScriptEngine(1);
  VBScript = TcxScriptEngine(2);
{$ENDIF}

implementation

uses RTLConsts, WebCntxt,
  {$IFDEF VCL}
  Windows, cxWebDispImp, cxWebGlobalDispImp,
  {$ELSE}
  Libc,
  {$ENDIF}
  cxWebStrs, cxWebSess, cxWebUtils;

type
  PcxWebScripterRecord = ^TcxWebScripterRecord;
  TcxWebScripterRecord = record
    NamedItems: TStrings;
    ThreadId: Cardinal;
  end;

var
  FGlobalLock: TCriticalSection;
  FScripter: TcxWebScripter = nil;
  FAvailableScriptEngines: TcxScriptEngines;

threadvar
  {$IFDEF USESCRIPTENGINE}
  cxSaveScriptEnginesList: TAbstractScriptEnginesList;
  {$ELSE}
  cxSaveScriptProducerClass: TScriptProducerClass;
  {$ENDIF}

{ TcxWebScriptEnginesList }

{$IFDEF USESCRIPTENGINE}
constructor TcxScriptEnginesList.Create(AProdClass: TScriptProducerClass);
begin
  FProdClass := AProdClass;
end;

function TcxScriptEnginesList.FindScriptProducerClass(const ALanguageName: string): TScriptProducerClass;
begin
  Result := FProdClass;
end;
{$ENDIF}

{ TcxWebScriptError }

constructor TcxWebScriptError.Create(E: Exception);
begin
  FDescription := E.Message;
end;

constructor TcxWebScriptError.Create(ParserError: EcxWebScriptParserException);
begin
  with ParserError.Info do
  begin
    FPosition := Position;
    FSource := scxWebScriptParserError;
    FDescription := Description;
    FCode := ErrorCode;
    FLine := 0;
    FCharPos := 0;
    FSourceLine := '';
    FFileName := FileName;
  end;
end;

constructor TcxWebScriptError.Create(AError: TcxScriptError; ALineNumberMap: TcxLineNumberMap);
begin
  FCode := AError.Code;
  FSource := AError.Source;
  FPosition := 0;
  FLine := AError.Line + 1;
  FCharPos := AError.CharPos + 1;
  ALineNumberMap.Convert(FPosition, FLine, FCharPos, FFileName);
  FDescription := AError.Description;
  FSourceLine := AError.SourceLine;
end;

constructor TcxWebScriptError.Create(AError: TcxWebScriptError);
begin
  FCode := AError.Code;
  FSource := AError.Source;
  FPosition := AError.Position;
  FDescription := AError.Description;
  FFileName := AError.FileName;
  FLine := AError.Line;
  FCharPos := AError.CharPos;
  FSourceLine := AError.SourceLine;
end;

function TcxWebScriptError.GetCharPos: Integer;
begin
  Result := FCharPos;
end;

function TcxWebScriptError.GetCode: Integer;
begin
  Result := FCode;
end;

function TcxWebScriptError.GetDescription: string;
begin
  Result := FDescription;
end;

function TcxWebScriptError.GetFileName: string;
begin
  Result := FFileName;
end;

function TcxWebScriptError.GetLine: Integer;
begin
  Result := FLine;
end;

function TcxWebScriptError.GetSource: string;
begin
  Result := FSource;
end;

function TcxWebScriptError.GetSourceLine: string;
begin
  Result := FSourceLine;
end;

procedure TcxWebScriptError.SetDescription(const AValue: string);
begin
  FDescription := AValue;
end;

{ TcxWebScriptErrors }

procedure TcxWebScriptErrors.Add(const AError: TAbstractScriptError);
begin
  FList.Add(AError);
end;

constructor TcxWebScriptErrors.Create;
begin
  FList := TObjectList.Create(True);
end;

destructor TcxWebScriptErrors.Destroy;
begin
  FList.Free;
  inherited;
end;

function TcxWebScriptErrors.GetError(I: Integer): TAbstractScriptError;
begin
  Result := FList[I] as TAbstractScriptError;
end;

function TcxWebScriptErrors.GetErrorCount: Integer;
begin
  Result := FList.Count;
end;

{ TcxWebScripter }

constructor TcxWebScripter.Create(AOwner: TComponent);
begin
  inherited Create(nil);
  FThreadItems := TThreadList.Create;
end;

destructor TcxWebScripter.Destroy;
begin
  ClearThreadItems;
  FThreadItems.Free;
  inherited;
end;

procedure TcxWebScripter.GetNames(AStrings: TStrings);
begin
  if NamedItems <> nil then
    AStrings.Assign(NamedItems);
end;

function TcxWebScripter.GetObjectByName(AName: string): TObject;
var
  Index: Integer;
begin
  if NamedItems <> nil then
    Index := NamedItems.IndexOf(AName)
  else Index := -1;
  if Index > -1 then
    Result := TObject(NamedItems.Objects[Index])
  else Result := nil;
end;

procedure TcxWebScripter.AddGlobalObjects(AProducer: TAbstractScriptProducer);
begin
  NamedItems.AddObject(cxsoResponse, AProducer);
  if WebContext <> nil then
  begin
    NamedItems.AddObject(cxsoRequest, WebContext.Request);
    NamedItems.AddObject(cxsoSession, WebContext.Session);
    NamedItems.AddObject(cxsoSessions, cxWebSessions);
    NamedItems.AddObject(cxsoContext, WebContext);
  end;
end;

procedure TcxWebScripter.AddComponents(AProducer: TAbstractScriptProducer);
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
      NamedItems.AddObject(cxsoForm, Module);
      NamedItems.AddObject(Module.Name, Module);

      for I := 0 to Module.ComponentCount - 1 do
      begin
        Component := Module.Components[I];
        if Component.Name <> '' then
          NamedItems.AddObject(Component.Name, Component);
      end;
    end;
  end;
end;

procedure TcxWebScripter.ClearAll;
var
  AList: TList;
  I: Integer;
  PRecord: PcxWebScripterRecord;
begin
  AList := FThreadItems.LockList;
  try
    for I := 0 to AList.Count - 1 do
    begin
      PRecord := PcxWebScripterRecord(AList[I]);
      if (PRecord.ThreadId = GetCurrentThreadId) then
      begin
        PRecord.NamedItems.Free;
        Dispose(PRecord);
        AList.Delete(I);
        break;
      end;
    end;
  finally
    FThreadItems.UnlockList;
  end;
end;

procedure TcxWebScripter.ClearThreadItems;
var
  AList: TList;
  I: Integer;
  PRecord: PcxWebScripterRecord;
begin
  AList := FThreadItems.LockList;
  try
    for I := 0 to AList.Count - 1 do
    begin
      PRecord := PcxWebScripterRecord(AList[I]);
      PRecord.NamedItems.Free;
      Dispose(PRecord);
    end;
    AList.Clear;
  finally
    FThreadItems.UnlockList;
  end;
end;

function TcxWebScripter.GetNamedItems: TStrings;
var
  AList: TList;
  I: Integer;
  ACurrrentThreadId: Cardinal;
  PRecord: PcxWebScripterRecord;
begin
  Result := nil;
  AList := FThreadItems.LockList;
  try
    ACurrrentThreadId := GetCurrentThreadId;
    for I := 0 to AList.Count - 1 do
    begin
      PRecord := PcxWebScripterRecord(AList[I]);
      if PRecord.ThreadId = ACurrrentThreadId then
      begin
        Result := PRecord.NamedItems;
        break;
      end;
    end;
    if Result = nil then
    begin
       New(PRecord);
       PRecord.ThreadId := ACurrrentThreadId;
       PRecord.NamedItems := TStringList.Create;
       Result := PRecord.NamedItems;
       AList.Add(PRecord)
    end;
  finally
    FThreadItems.UnlockList;
  end;
end;

{ TcxWebScriptProducer }

constructor TcxWebScriptProducer.Create(AWebModuleContext: TWebModuleContext;
        AStripParamQuotes: Boolean; AHandleTag: THandleTagProc;
        const AScriptEngine: string; ALocateFileService: ILocateFileService);
begin
  inherited Create(AWebModuleContext, AStripParamQuotes, AHandleTag,
   AScriptEngine, ALocateFileService);
  FWebModuleContext := AWebModuleContext;
  FStripParamQuotes := AStripParamQuotes;
  FHandleTag := AHandleTag;
  FLocateFileService := ALocateFileService;
  FScriptEngine := AScriptEngine;
  FScriptParser := TcxWebScriptParser.Create(False);
  FScriptParser.OnError := HandleParserError;
  FScriptParser.OnGetFileStream := GetFileStream;
  FContent := TStringStream.Create('');

  FErrors := TcxWebScriptErrors.Create;
  Scripter.AddGlobalObjects(Self);
  Scripter.AddComponents(Self);
end;

destructor TcxWebScriptProducer.Destroy;
begin
  Scripter.ClearAll;
  FreeAndNil(FErrors);
  FreeAndNil(FContent);
  FreeAndNil(FScriptParser);
  inherited;
end;

function TcxWebScriptProducer.Evaluate: string;
var
  E: Exception;
begin
  Scripter.Run(ScriptParser.Script, FScriptEngine);
  if Errors.Count = 0 then GetScripterErrors;
  if Errors.Count > 0 then
  begin
    E := EScriptError.Create(Errors, GetContent);
    FErrors := nil;
    raise E;
  end;

  Result := GetContent;
end;

function TcxWebScriptProducer.GetContent: string;
begin
  Result := FContent.DataString;
end;

function TcxWebScriptProducer.GetScripterErrors: TAbstractScriptErrors;
var
  I: Integer;
begin
  for I := 0 to FScripter.Errors.Count - 1 do
    FErrors.Add(TcxWebScriptError.Create(FScripter.Errors[I], ScriptParser.LineNumberMap));
  Result := FErrors;
end;

function TcxWebScriptProducer.GetErrors: TAbstractScriptErrors;
begin
  Result := FErrors;
end;

procedure TcxWebScriptProducer.GetFileStream(ASender: TObject;
  const AFileName: string; var AStream: TStream; var AOwned: Boolean);
begin
  if LocateFileService <> nil then
    AStream := LocateFileService.GetTemplateStream(nil, AFileName, AOwned);
end;

function TcxWebScriptProducer.GetHTMLBlock(I: Integer): {$IFDEF USESCRIPTENGINE}string{$ELSE}WideString{$ENDIF};
begin
  Result := FScriptParser.HTMLBlocks[I];
end;

function TcxWebScriptProducer.GetHTMLBlockCount: Integer;
begin
  Result := FScriptParser.HTMLBlocks.Count;
end;

function TcxWebScriptProducer.GetWebModuleContext: TWebModuleContext;
begin
  Result := FWebModuleContext;
end;

procedure TcxWebScriptProducer.HandleParserError(AParserError: EcxWebScriptParserException);
begin
  Errors.Add(TcxWebScriptError.Create(AParserError));
end;

function TcxWebScriptProducer.HandleScriptError(
  const ScriptError: IInterface): HRESULT;
begin
  Result := S_OK;
end;

procedure TcxWebScriptProducer.ParseStream(Stream: TStream; Owned: Boolean);
begin
  try
    FScriptParser.ParseStream(Stream);
  finally
    if Owned then
      Stream.Free;
  end;
end;

procedure TcxWebScriptProducer.ParseString(const S: string);
begin
  FScriptParser.ParseString(S);
end;

function TcxWebScriptProducer.ReplaceTags(const AValue: string): string;
begin
  Result := ContentFromString(AValue, FStripParamQuotes,
    FHandleTag, nil);
end;

procedure TcxWebScriptProducer.SetContent(const Value: string);
begin
  FContent.Size := 0;
  Write(Value);
end;

procedure TcxWebScriptProducer.Write(const Value: string);
begin
  FContent.WriteString(Value);
end;

procedure TcxWebScriptProducer.Write(const AValue: PWideChar;
  ALength: Integer);
begin
  Write(WideCharLenToString(AValue, ALength));
end;

procedure TcxWebScriptProducer.WriteItem(Index: Integer);
var
  HTMLBlock: WideString;
begin
  HTMLBlock := IScriptProducer(Self).HTMLBlocks[Index];
  if IsHTMLTag(Index) then
    Write(ReplaceTags(HTMLBlock))
  else Write(PWideChar(HTMLBlock), Length(HTMLBlock));
end;

function TcxWebScriptProducer.GetScripter: IcxWebScripter;
begin
  FGlobalLock.Acquire;
  Result := nil;
  try
    if FScripter = nil then
       FScripter := TcxWebScripter.Create(nil);
    Supports(FScripter, IcxWebScripter, Result);
  finally
    FGlobalLock.Release;
  end;
end;

function TcxWebScriptProducer.IsHTMLTag(Index: Integer): Boolean;
begin
  Result := Boolean(ScriptParser.HTMLBlocks.Objects[Index]);
end;

{ TcxScriptEngines }

type
  PcxScriptEngineInfo = ^TcxScriptEngineInfo;
  TcxScriptEngineInfo = record
    Engine: TcxScriptEngine;
    Name: string;
    ProducerClass: TScriptProducerClass;
    UnitName: string;
    HTMLTemplate: string;
  end;

function ServerScriptToIdent(ServerScript: Longint; var Ident: string): Boolean;
var
  Name: string;
begin
  Name := AvailableScriptEngines.GetEngineName(TcxScriptEngine(ServerScript));
  Result := Name <> '';
  if Result then
    Ident := Name;
end;

function IdentToServerScript(const Ident: string; var ServerScript: Longint): Boolean;
var
  I: Integer;
begin
  if Ident = '' then
  begin
    Result := True;
    ServerScript := 0;
  end
  else
  begin
    I := AvailableScriptEngines.IndexOfName(Ident);
    Result := I <> -1;
    if Result then
      ServerScript := AvailableScriptEngines.Engine[I];
  end;
end;

constructor TcxScriptEngines.Create;
begin
  inherited;
  FList := TThreadList.Create;
  RegisterIntegerConsts(TypeInfo(TcxScriptEngine), IdentToServerScript, ServerScriptToIdent);
end;

destructor TcxScriptEngines.Destroy;
begin
  UnregisterIntegerConsts(TypeInfo(TcxScriptEngine), IdentToServerScript, ServerScriptToIdent);
  while Count > 0 do
    Delete(0);
  FList.Free;
  inherited;
end;

function TcxScriptEngines.GetEngineName(AEngine: TcxScriptEngine): string;
var
  I: Integer;
  PInfo: PcxScriptEngineInfo;
begin
  Result := '';
  with FList.LockList do
    try
      for I := 0 to Count - 1 do
      begin
        PInfo := PcxScriptEngineInfo(Items[I]);
        if PInfo^.Engine = AEngine then
        begin
          Result := PInfo^.Name;
          break;
        end;
      end;
    finally
      FList.UnlockList;
    end;
end;

function TcxScriptEngines.GetEngineUnit(AEngine: TcxScriptEngine): string;
var
  I: Integer;
  PInfo: PcxScriptEngineInfo;
begin
  Result := '';
  with FList.LockList do
    try
      for I := 0 to Count - 1 do
      begin
        PInfo := PcxScriptEngineInfo(Items[I]);
        if PInfo^.Engine = AEngine then
        begin
          Result := PInfo^.UnitName;
          break;
        end;
      end;
    finally
      FList.UnlockList;
    end;
end;

function TcxScriptEngines.GetEngineTemplate(AEngine: TcxScriptEngine): string;
var
  I: Integer;
  PInfo: PcxScriptEngineInfo;
begin
  Result := '';
  with FList.LockList do
    try
      for I := 0 to Count - 1 do
      begin
        PInfo := PcxScriptEngineInfo(Items[I]);
        if PInfo^.Engine = AEngine then
        begin
          Result := PInfo^.HTMLTemplate;
          break;
        end;
      end;
    finally
      FList.UnlockList;
    end;
end;

function TcxScriptEngines.GetProducerClass(AName: string): TScriptProducerClass;
var
  I: Integer;
  PInfo: PcxScriptEngineInfo;
begin
  Result := nil;
  with FList.LockList do
    try
      for I := 0 to Count - 1 do
      begin
        PInfo := PcxScriptEngineInfo(Items[I]);
        if PInfo^.Name = AName then
        begin
          Result := PInfo^.ProducerClass;
          break;
        end;
      end;
    finally
      FList.UnlockList;
    end;
end;

function TcxScriptEngines.IndexOf(AEngine: TcxScriptEngine): Integer;
var
  I: Integer;
begin
  Result := -1;
  with FList.LockList do
    try
      for I := 0 to Count - 1 do
        if PcxScriptEngineInfo(Items[I])^.Engine = AEngine then
        begin
          Result := I;
          break;
        end;
    finally
      FList.UnlockList;
    end;
end;

function TcxScriptEngines.IndexOfName(const AName: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  with FList.LockList do
    try
      for I := 0 to Count - 1 do
        if SameText(PcxScriptEngineInfo(Items[I])^.Name, AName) then
        begin
          Result := I;
          break;
        end;
    finally
      FList.UnlockList;
    end;
end;

procedure TcxScriptEngines.RegisterEngine(AEngine: TcxScriptEngine; const AName: string;
  AProducerClass: TScriptProducerClass; const AUnitName, AHTMLTemplate: string);
var
  PInfo: PcxScriptEngineInfo;
begin
  if IndexOf(AEngine) <> -1 then
    raise EcxWebException.CreateFmt(scxDuplicateScriptEngineID, [Ord(AEngine)]);
  if IndexOfName(AName) <> -1 then
    raise EcxWebException.CreateFmt(scxDuplicateScriptEngineName, [AName]);
  with FList.LockList do
    try
      New(PInfo);
      PInfo^.Engine := AEngine;
      PInfo^.Name := AName;
      PInfo^.ProducerClass := AProducerClass;
      PInfo^.UnitName := AUnitName;
      PInfo^.HTMLTemplate := AHTMLTemplate;
      Add(Pointer(PInfo));
    finally
      FList.UnlockList;
    end;
end;

procedure TcxScriptEngines.UnregisterEngine(AEngine: TcxScriptEngine);
var
  Idx: Integer;
begin
  Idx := IndexOf(AEngine);
  if Idx <> -1 then
    Delete(Idx);
end;

procedure TcxScriptEngines.Delete(AIndex: Integer);
var
  PInfo: PcxScriptEngineInfo;
begin
  with FList.LockList do
    try
      PInfo := PcxScriptEngineInfo(Items[AIndex]);
      Dispose(PInfo);
      Delete(AIndex);
    finally
      FList.UnlockList;
    end;
end;

function TcxScriptEngines.GetCount: Integer;
begin
  with FList.LockList do
    try
      Result := Count;
    finally
      FList.UnlockList;
    end;
end;

function TcxScriptEngines.GetEngine(Index: Integer): TcxScriptEngine;
begin
  with FList.LockList do
    try
      Result := PcxScriptEngineInfo(Items[Index])^.Engine;
    finally
      FList.UnlockList;
    end;
end;

function AvailableScriptEngines: TcxScriptEngines;
begin
  Result := FAvailableScriptEngines;
end;

{$IFDEF USESCRIPTENGINE}
function cxGetSaveScriptEnginesList: TAbstractScriptEnginesList;
begin
  Result := cxSaveScriptEnginesList;
end;
{$ELSE}
function cxGetSaveScriptProducerClass: TScriptProducerClass;
begin
  Result := cxSaveScriptProducerClass;
end;
{$ENDIF}

procedure cxInitScriptProducer(AClass: TScriptProducerClass);
begin
  FGlobalLock.Acquire;
  try
    {$IFDEF USESCRIPTENGINE}
    cxSaveScriptEnginesList := ScriptEnginesList;
    ScriptEnginesList := TcxScriptEnginesList.Create(AClass);
    {$ELSE}
    cxSaveScriptProducerClass := ScriptProducerClass;
    ScriptProducerClass := AClass;
    {$ENDIF}
  finally
    FGlobalLock.Release;
  end;
end;

procedure cxFinishScriptProducer;
begin
  FGlobalLock.Acquire;
  try
    {$IFDEF USESCRIPTENGINE}
    if (ScriptEnginesList <> nil) and (ScriptEnginesList is TcxScriptEnginesList) then
      FreeAndNil(ScriptEnginesList);
    ScriptEnginesList := cxSaveScriptEnginesList;
    {$ELSE}
    ScriptProducerClass := cxSaveScriptProducerClass;
    {$ENDIF}
  finally
    FGlobalLock.Release;
  end;
end;

initialization
  FGlobalLock := TCriticalSection.Create;
  FGlobalLock.Acquire;
  try
    FAvailableScriptEngines := TcxScriptEngines.Create;
  finally
    FGlobalLock.Release;
  end;
  {$IFDEF VCL}
  AvailableScriptEngines.RegisterEngine(JScript, 'JScript', TcxWebScriptProducer, 'cxWebScript', ''); // Do not localize
  AvailableScriptEngines.RegisterEngine(VBScript, 'VBScript', TcxWebScriptProducer, 'cxWebScript', ''); // Do not localize
  {$ENDIF}

finalization
  {$IFDEF VCL}
  AvailableScriptEngines.UnregisterEngine(JScript);
  AvailableScriptEngines.UnregisterEngine(VBScript);
  {$ENDIF}
  FGlobalLock.Acquire;
  try
    FreeAndNil(FScripter);
    FreeAndNil(FAvailableScriptEngines);
  finally
    FGlobalLock.Release;
  end;
  FreeAndNil(FGlobalLock);

end.
