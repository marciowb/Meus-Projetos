{*******************************************************************}
{                                                                   }
{       ExpressScript Engine by Developer Express                   }
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
unit cxScript;

{$I cxVer.inc}
 
interface

uses Classes, SysUtils, Contnrs{$IFDEF VCL}, ComObj, ActiveX, cxASIntf{$ENDIF};

type
  TcxCustomScripter = class;

  {$IFDEF VCL}
  TcxScriptActiveScriptSite = class(TInterfacedObject, IActiveScriptSite)
  private
    FScripter: TcxCustomScripter;
  protected
    { IActiveScriptSite }
    function GetDocVersionString(out pbstrVersion: WideString): HResult; stdcall;
    function GetItemInfo(pstrName: PWideChar; dwReturnMask: LongWord; out ppiunkItem: IUnknown;
      out ppti: IUnknown): HResult; stdcall;
    function GetLCID(out plcid: LongWord): HResult; stdcall;
    function OnEnterScript: HResult; stdcall;
    function OnLeaveScript: HResult; stdcall;
    function OnScriptError(const pscripterror: IActiveScriptError): HResult; stdcall;
    function OnScriptTerminate(var pvarResult: OleVariant; var pexcepinfo: EXCEPINFO): HResult; stdcall;
    function OnStateChange(ssScriptState: tagSCRIPTSTATE): HResult; stdcall;
  public
    constructor Create(AScripter: TcxCustomScripter);
    destructor Destroy; override;
  end;
  {$ENDIF}
  TcxScriptErrors = class;

  TcxCustomScripter = class(TComponent)
  private
    FErrors: TcxScriptErrors;
    FActiveScripts: TThreadList;
    {$IFDEF VCL}
    FScriptSite: IActiveScriptSite;
    FNeedUninit: Boolean;
    procedure SetNamesToScriptSite(ActiveScript: IActiveScript);
    {$ENDIF}
  protected
    {$IFDEF VCL}
    procedure ClearActiveScripts;
    function CreateNewEngine(const AScriptEngine: string): IActiveScript;
    function GetActiveScript(const AScriptEngine: string): IActiveScript;
    {$ENDIF}

    procedure GetNames(AStrings: TStrings); virtual; abstract;
    function GetObjectByName(AName: string): TObject; virtual; abstract;
    procedure GetCorrectErrorPosition(var ALinePos, ACharPos: Integer;
        var AFileName: string); virtual;

    {$IFDEF VCL}
    function HandleScriptError(const AScriptError: IActiveScriptError): HRESULT;
    {$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Run(const AText, AScriptEngine: string); virtual;
    property Errors: TcxScriptErrors read FErrors;
  end;

  EcxScriptError = class(Exception)
  private
    FErrors: TcxScriptErrors;
    FContent: string;
  public
    constructor Create(const AErrors: TcxScriptErrors; const AContent: string);
    destructor Destroy; override;
    property Errors: TcxScriptErrors read FErrors;
    property Content: string read FContent;
  end;

  TcxScriptError = class
  private
    FCharPos: Integer;
    FCode: Integer;
    FDescription: WideString;
    FFileName: string;
    FLine: Integer;
    FSource: WideString;
    FSourceLine: WideString;
  public
    {$IFDEF VCL}
    constructor Create(AScripter: TcxCustomScripter; const ScriptError: IActiveScriptError); overload;
    {$ENDIF}
    constructor Create(AException: Exception); overload;

    property Code: Integer read FCode;
    property Source: WideString read FSource;
    property Line: Integer read FLine;
    property CharPos: Integer read FCharPos;
    property Description: WideString read FDescription write FDescription;
    property SourceLine: WideString read FSourceLine;
    property FileName: string read FFileName;
  end;

  TcxScriptErrors = class
  private
    FList: TThreadList;
  protected
    function GetItem(Index: Integer): TcxScriptError; virtual;
    function GetCount: Integer; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(const AError: TcxScriptError); virtual;
    procedure Clear;
    procedure ClearAll;

    property Items[I: Integer]: TcxScriptError read GetItem; default;
    property Count: Integer read GetCount;
  end;

implementation

uses
  {$IFDEF VCL}
  Windows, RTLConsts, cxScriptDispFactory;
  {$ELSE}
  Libc;
  {$ENDIF}

{$IFDEF VCL}
const
  scxCannotCreateScriptEngine = 'Cannot create script engine: %s.'#13#10'Error code: %x';
  scxDefaultScriptName = 'JScript'; //do not localize
{$ENDIF}

type
  PcxScriptNamedItem = ^TcxScriptNamedItem;
  TcxScriptNamedItem = record
    Name: string;
    Instance: TObject;
  end;

{$IFDEF VCL}
  PcxCustomScripterRecord = ^TcxCustomScripterRecord;
  TcxCustomScripterRecord = record
    ScriptEngine: string;
    ActiveScript: IActiveScript;
  end;
{$ENDIF}

  PcxScriptErrorsRecord = ^TcxScriptErrorsRecord;
  TcxScriptErrorsRecord = record
    Error: TcxScriptError;
    ThreadId: Cardinal;
  end;

{$IFDEF VCL}
{ TcxScriptActiveScriptSite }

constructor TcxScriptActiveScriptSite.Create(AScripter: TcxCustomScripter);
begin
  inherited Create;
  FScripter := AScripter;
end;

destructor TcxScriptActiveScriptSite.Destroy;
begin
  inherited;
end;

function TcxScriptActiveScriptSite.GetDocVersionString(out pbstrVersion: WideString): HResult;
begin
  Result := E_NOTIMPL; // This method is not supported
end;

function TcxScriptActiveScriptSite.GetItemInfo(pstrName: PWideChar; dwReturnMask: LongWord; out ppiunkItem: IUnknown;
  out ppti: IUnknown): HResult;
var
  AObject: TObject;
begin
  if pstrName <> nil then
  begin
    Result := S_OK;
    if (dwReturnMask and SCRIPTINFO_IUNKNOWN) <> 0 then
    begin
      AObject := FScripter.GetObjectByName(pstrName);
      if AObject <> nil then
        ppiunkItem := ScriptDispFactory.GetDispatch(AObject)
      else  ppiunkItem := nil;
      if ppiunkItem = nil then
        Result := TYPE_E_ELEMENTNOTFOUND;
    end
    else
      ppiunkItem := nil;
  end
  else
    Result := E_POINTER;
end;

function TcxScriptActiveScriptSite.GetLCID(out plcid: LongWord): HResult;
begin
  Result := E_NOTIMPL; // Use the system-defined locale
end;


function TcxScriptActiveScriptSite.OnEnterScript: HResult;
begin
  Result := S_OK; // This event is not handled
end;

function TcxScriptActiveScriptSite.OnLeaveScript: HResult;
begin
  Result := S_OK; // This event is not handled
end;

function TcxScriptActiveScriptSite.OnScriptError(const pscripterror: IActiveScriptError): HResult;
begin
  Result := FScripter.HandleScriptError(pscripterror);
end;

function TcxScriptActiveScriptSite.OnScriptTerminate(var pvarResult: OleVariant; var pexcepinfo: EXCEPINFO): HResult;
begin
  Result := S_OK; // This event is not handled
end;

function TcxScriptActiveScriptSite.OnStateChange(ssScriptState: tagSCRIPTSTATE): HResult;
begin
  Result := S_OK; // This event is not handled
end;
{$ENDIF}

{ TcxScriptError }

{$IFDEF VCL}
constructor TcxScriptError.Create(AScripter: TcxCustomScripter; const ScriptError: IActiveScriptError);
var
  EInfo: ExcepInfo;
  Cookie, LineNum: Cardinal;
  CharPos: Integer;
  SrcLineText: WideString;
begin
  if ScriptError.GetExceptionInfo(EInfo) = S_OK then
  begin
    FCode := EInfo.wCode;
    if FCode = 0 then
      FCode := EInfo.scode;
    FSource := EInfo.bstrSource;
    FDescription := EInfo.bstrDescription;
  end;
  if ScriptError.GetSourcePosition(Cookie, LineNum, CharPos) = S_OK then
  begin
    FLine := LineNum;
    FCharPos := CharPos;
    AScripter.GetCorrectErrorPosition(FLine, FCharPos, FFileName);
  end;
  if ScriptError.GetSourceLineText(SrcLineText) = S_OK then
    FSourceLine := SrcLineText;
end;
{$ENDIF}

constructor TcxScriptError.Create(AException: Exception);
begin
  Description := AException.Message;
end;

{ TcxScriptErrors }

constructor TcxScriptErrors.Create;
begin
  FList := TThreadList.Create;
end;

destructor TcxScriptErrors.Destroy;
begin
  ClearAll;
  FList.Free;
  inherited;
end;

procedure TcxScriptErrors.Add(const AError: TcxScriptError);
var
  PRecord: PcxScriptErrorsRecord;
begin
  with FList.LockList do
  try
    New(PRecord);
    PRecord.ThreadId := GetCurrentThreadId;
    PRecord.Error := AError;
    Add(PRecord);
  finally
    FList.UnlockList;
  end;
end;

procedure TcxScriptErrors.Clear;
var
  I: Integer;
  PRecord: PcxScriptErrorsRecord;
begin
  with FList.LockList do
  try
    for I := Count - 1 downto 0 do
    begin
      PRecord := PcxScriptErrorsRecord(Items[I]);
      if PRecord.ThreadId = GetCurrentThreadId then
      begin
        PRecord.Error.Free;
        Dispose(PRecord);
        Delete(I);
      end;
    end;
  finally
    FList.UnlockList;
  end;
end;

procedure TcxScriptErrors.ClearAll;
var
  I: Integer;
  PRecord: PcxScriptErrorsRecord;
begin
  with FList.LockList do
  try
    for I := 0 to Count - 1 do
    begin
      PRecord := PcxScriptErrorsRecord(Items[I]);
      PRecord.Error.Free;
      Dispose(PRecord);
    end;
    FList.Clear;
  finally
    FList.UnlockList;
  end;
end;

function TcxScriptErrors.GetItem(Index: Integer): TcxScriptError;
var
  I, Cnt: Integer;
begin
  Result := nil;
  Cnt := 0;
  with FList.LockList do
  try
    for I := 0 to Count - 1 do
      if PcxScriptErrorsRecord(Items[I]).ThreadId = GetCurrentThreadId then
        if Cnt = Index then
        begin
          Result := PcxScriptErrorsRecord(Items[I]).Error;
          break;
        end
        else
          Inc(Cnt);
  finally
    FList.UnlockList;
  end;
end;

function TcxScriptErrors.GetCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  with FList.LockList do
  try
    for I := 0 to Count - 1 do
      if PcxScriptErrorsRecord(Items[I]).ThreadId = GetCurrentThreadId then
        Inc(Result);
  finally
    FList.UnlockList;
  end;
end;

{ TcxCustomScripter }
constructor TcxCustomScripter.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FActiveScripts := TThreadList.Create;
  FErrors := TcxScriptErrors.Create;
  {$IFDEF VCL}
  FScriptSite := TcxScriptActiveScriptSite.Create(self);
  {$ENDIF}
end;

destructor TcxCustomScripter.Destroy;
//var
//  NeedUninitLoc: Boolean;
begin
  FErrors.Free;
  {$IFDEF VCL}
  ClearActiveScripts;
  FActiveScripts.Free;
  {$ENDIF}
//  NeedUninitLoc := FNeedUninit;
  inherited Destroy;
  {$IFDEF VCL}
  ScriptDispFactory.ReleaseInstance;
  {$ENDIF}
//  if NeedUninitLoc then
//    CoUninitialize;
end;

{$IFDEF VCL}
procedure TcxCustomScripter.ClearActiveScripts;
var
  I: Integer;
  AList: TList;
begin
  AList := FActiveScripts.LockList;
  try
    for I := 0 to AList.Count - 1 do
    begin
      PcxCustomScripterRecord(AList[I]).ActiveScript := nil;
      Dispose(PcxCustomScripterRecord(AList[I]));
    end;
    FActiveScripts.Clear;
  finally
    FActiveScripts.UnlockList;
  end;
end;

function TcxCustomScripter.CreateNewEngine(const AScriptEngine: string): IActiveScript;
var
  ProgID: array[0..127] of WideChar;
  CLSID: TGUID;
  hr: HRESULT;
begin
  StringToWideChar(AScriptEngine, ProgID, Length(AScriptEngine) + 1);
  CLSIDFromProgID(ProgID, CLSID);
  if (CoInitFlags = -1) and (IsMultiThread) then
    CoInitFlags := COINIT_MULTITHREADED;
  if Assigned(ComObj.CoInitializeEx) and (CoInitFlags <> -1) then
    FNeedUninit := Succeeded(ComObj.CoInitializeEx(nil, CoInitFlags))
  else
    FNeedUninit := Succeeded(CoInitialize(nil));
  hr := CoCreateInstance(CLSID, nil, CLSCTX_INPROC_SERVER, IActiveScript, Result);
  if FAILED(hr) then
    raise Exception.CreateFmt(scxCannotCreateScriptEngine, [AScriptEngine, hr]);
end;

function TcxCustomScripter.GetActiveScript(const AScriptEngine: string): IActiveScript;
var
  I: Integer;
  AList: TList;
  ARecord: PcxCustomScripterRecord;
begin
  Result := nil;
  AList := FActiveScripts.LockList;
  try
    for I := 0 to AList.Count - 1 do
    begin
      if SameText(PcxCustomScripterRecord(AList[I]).ScriptEngine, AScriptEngine) then
      begin
        Result := PcxCustomScripterRecord(AList[I]).ActiveScript;
        break;
      end;
    end;
    if Result = nil then
    begin
      Result := CreateNewEngine(AScriptEngine);
      if Result <> nil then
      begin
        New(ARecord);
        ARecord.ScriptEngine := AScriptEngine;
        ARecord.ActiveScript := Result;
        AList.Add(ARecord);
      end;
    end;
  finally
    FActiveScripts.UnlockList;
  end;
end;

procedure TcxCustomScripter.SetNamesToScriptSite(ActiveScript: IActiveScript);
var
  I: Integer;
  ANamedItems: TStringList;
begin
  ANamedItems := TStringList.Create;
  try
    GetNames(ANamedItems);
    for I := 0 to ANamedItems.Count - 1 do
      ActiveScript.AddNamedItem(PWideChar(WideString(ANamedItems[I])), SCRIPTITEM_ISVISIBLE);
  finally
    ANamedItems.Free;
  end;
end;
{$ENDIF}

procedure TcxCustomScripter.GetCorrectErrorPosition(var ALinePos, ACharPos: Integer;
        var AFileName: string);
begin
end;

{$IFDEF VCL}
function TcxCustomScripter.HandleScriptError(const AScriptError: IActiveScriptError): HRESULT;
var
  AError: TcxScriptError;
begin
  AError := TcxScriptError.Create(self, AScriptError);
  FErrors.Add(AError);
  Result := S_OK;
end;

procedure TcxCustomScripter.Run(const AText, AScriptEngine: string);
var
  hr: HRESULT;
  ActiveScript, ACloneActiveScript: IActiveScript;
  AParser: IActiveScriptParse;
  ExcepInfo: TExcepInfo;
  NeedUninitLoc: Boolean;
begin
  Errors.Clear;
  ActiveScript := GetActiveScript(AScriptEngine);
  if ActiveScript <> nil then
  begin
    if Assigned(ComObj.CoInitializeEx) then
      NeedUninitLoc := Succeeded(ComObj.CoInitializeEx(nil, CoInitFlags))
    else
      NeedUninitLoc := Succeeded(CoInitialize(nil));
    try
      hr := ActiveScript.Clone(ACloneActiveScript);
      OLECHECK(hr);
      hr := ACloneActiveScript.QueryInterface(IActiveScriptParse, AParser);
      OLECHECK(hr);
      hr := ACloneActiveScript.SetScriptSite(FScriptSite);
      OLECHECK(hr);
      hr := AParser.InitNew;
      OLECHECK(hr);
      SetNamesToScriptSite(ACloneActiveScript);
      hr := AParser.ParseScriptText(PWideChar(WideString(AText)), nil, nil, nil, 0, 0, 0, nil, ExcepInfo);
      if hr = S_OK then
        ACloneActiveScript.SetScriptState(SCRIPTSTATE_CONNECTED);
      hr := ACloneActiveScript.Close();
      OLECHECK(hr);
    finally
      ActiveScript := nil;
      ACloneActiveScript := nil;
      AParser := nil;
      if NeedUninitLoc then
        CoUninitialize;
    end;
  end else raise Exception.Create('The active script is not available'); //TODO
end;
{$ELSE}
procedure TcxCustomScripter.Run(const AText, AScriptEngine: string);
begin
  // abstract
end;
{$ENDIF}

{ EcxScriptError }

constructor EcxScriptError.Create(const AErrors: TcxScriptErrors;
  const AContent: string);
begin
  inherited Create(AErrors[0].Description);
  FErrors := AErrors;
  FContent := AContent;
end;

destructor EcxScriptError.Destroy;
begin
  FErrors.Free;
  inherited Destroy;
end;

end.
