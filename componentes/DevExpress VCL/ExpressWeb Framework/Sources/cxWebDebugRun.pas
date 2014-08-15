{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Runtime debugger                                            }
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

unit cxWebDebugRun;

{$I cxVer.inc}

{$IFDEF DELPHI7}
  {$DEFINE CLXWAD}
{$ENDIF}

{$IFDEF KYLIX3}
  {$DEFINE CLXWAD}
{$ENDIF}

interface

{$IFDEF VCL}
uses
  Windows;
{$ENDIF}

procedure RunTestApplication(AWebApplicationName: string);

{$IFDEF MSWINDOWS}
function IsDebuggerPresent: Boolean; external kernel32;
{$ENDIF}

implementation

uses
  Classes, SysUtils, HTTPProd,
  {$IFDEF VCL}
  Forms,  Messages, Registry, ShellAPI,
  {$ELSE}
  QForms, IniFiles, Libc,
  {$ENDIF}
  cxWebUtils, cxWebStrs, cxWebIntf,
  {$IFDEF CLXWAD}IdSocketHandle, IdTCPServer, IdServerIOHandlerSocket
  {$ELSE}ScktComp{$ENDIF};

const
  {$IFDEF CLXWAD}
  WebDebuggerWindowClass = 'QWidget';
  {$ELSE}
  WebDebuggerWindowClass = 'TWebAppDbgMainForm';
  {$ENDIF}
  WebDebuggerWindowName = 'Web App Debugger';
  WebDebuggerStop = 'Stop';
  LocalHostAddress = 'http://localhost:%d/';
  {$IFDEF MSWINDOWS}
  WebDebuggerFileName = 'webappdbg.exe';
  {$IFDEF DELPHI7}
  DelphiRegistryKey = '\Software\Borland\Delphi\7.0';
  {$ELSE}
  DelphiRegistryKey = '\Software\Borland\Delphi\6.0';
  {$ENDIF}
  WebDebuggerRegistryKey = '\Software\Borland\WebAppDbg';
  {$ENDIF}
  {$IFDEF LINUX}
  WebDebuggerFileName = 'webappdbg';
  DelphiIniFile = '/.borland/delphi69rc';
  WebDebuggerIniFile = '/.borland/webappdbgrc';
  {$ENDIF}
  sActiveAtStartup = 'ActiveAtStartup';
  sWADPort = 'port';
  sWADBrowser = 'Browser';  

function GetServerPort: Integer;
begin
  {$IFDEF MSWINDOWS}
  {$IFDEF DELPHI7}
  Result := 8081;
  {$ELSE}
  Result := 1024;
  {$ENDIF}
  with TRegistry.Create do
    try
      {$IFDEF DELPHI7}
      RootKey := HKEY_CURRENT_USER;
      {$ELSE}
      RootKey := HKEY_LOCAL_MACHINE;
      {$ENDIF}
      if OpenKey(WebDebuggerRegistryKey, False) then
        {$IFDEF DELPHI7}
        Result := ReadInteger(sWADPort);
        {$ELSE}
        Result := StrToInt(ReadString(sWADPort));
        {$ENDIF}
    finally
      Free;
    end;
  {$ENDIF}
  {$IFDEF LINUX}
  with TIniFile.Create(getenv('HOME') + WebDebuggerIniFile) do
    try
      Result := StrToInt(ReadString('', sWADPort, '8081'));
    finally
      Free;
    end;
  {$ENDIF}
end;

function GetURLAddress(AWebApplicationName: string): string;
begin
  Result := Format(LocalHostAddress, [GetServerPort]) + Application.Title + '.' + AWebApplicationName;
  if (Result <> '') and (Result[Length(Result)] <> '/') then
    Result := Result + '/';
end;

{$IFDEF LINUX}
function GetBrowser: string;
begin
  with TIniFile.Create(getenv('HOME') + WebDebuggerIniFile) do
    try
      Result := ReadString('', sWADBrowser, '');
    finally
      Free;
    end;
end;
{$ENDIF}

{$IFDEF CLXWAD}
type
  TIdSocketHandleAccess = class(TIdSocketHandle);
  TIdTCPServerAccess = class(TIdTCPServer);
{$ELSE}
var
  WasError: Boolean = False;

procedure SctErrHandler(ErrorCode: Integer);
begin
  WasError := ErrorCode <> 0;
end;
{$ENDIF}

{$IFDEF LINUX}
procedure WaitForProcessSleep(APID: Integer);
var
  Status: TStrings;
  I: Integer;
begin
  Status := TStringList.Create;
  try
    while (True) do
    begin
      Status.LoadFromFile('/proc/' + IntToStr(APID) + '/status');
      for I := 0 to Status.Count - 1 do
        if (Pos('State:', Status[I]) > 0) and
           (Pos('sleeping', Status[I]) > 0) then
          Exit;
      end;
  finally
    Status.Free;
  end;
end;

{$ENDIF}

procedure RunServer;

  function IsActive: Boolean;
  {$IFDEF CLXWAD}
  var
    TestServer: TIdTCPServerAccess;
    SocketHandle: TIdSocketHandleAccess;
  begin
    TestServer := TIdTCPServerAccess.Create(nil);
    try
      with TestServer do
      begin
        DefaultPort := GetServerPort;
        IOHandler := TIdServerIOHandlerSocket.Create(TestServer);
        SocketHandle := TIdSocketHandleAccess(Bindings.Add);
        SocketHandle.AllocateSocket;
        Result := not SocketHandle.TryBind;
      end;
    finally
      TestServer.Free;
    end;
  {$ELSE}
  var
    TestServer: TServerSocket;
    SaveErrorProc: TSocketErrorProc;
  begin
    TestServer := TServerSocket.Create(nil);
    try
      SaveErrorProc := SetErrorProc(SctErrHandler);
      TestServer.Port := GetServerPort;
      TestServer.Active := True;
      SetErrorProc(SaveErrorProc);
      Result := WasError;
    finally
      TestServer.Free;
    end;
  {$ENDIF}
  end;

  function IsActiveOnStartUp: Boolean;
  begin
    Result := False;
    {$IFDEF MSWINDOWS}
    with TRegistry.Create do
      try
        {$IFDEF DELPHI7}
        RootKey := HKEY_CURRENT_USER;
        {$ELSE}
        RootKey := HKEY_LOCAL_MACHINE;
        {$ENDIF}
        if OpenKey(WebDebuggerRegistryKey, False) then
          Result := StrToBoolDef(ReadString(SActiveAtStartup), False);
      finally
        Free;
      end;
    {$ENDIF}
    {$IFDEF LINUX}
    with TIniFile.Create(getenv('HOME') + WebDebuggerIniFile) do
      try
        Result := StrToBoolDef(ReadString('', SActiveAtStartup, ''), False);
      finally
        Free;
      end;
    {$ENDIF}
  end;

  procedure SetActiveOnStartUp(AValue: string);
  begin
    {$IFDEF MSWINDOWS}
    with TRegistry.Create do
      try
        {$IFDEF DELPHI7}
        RootKey := HKEY_CURRENT_USER;
        {$ELSE}
        RootKey := HKEY_LOCAL_MACHINE;
        {$ENDIF}
        if OpenKey(WebDebuggerRegistryKey, False) then
          WriteString(SActiveAtStartup, AValue);
      finally
        Free;
      end;
    {$ENDIF}
    {$IFDEF LINUX}
    with TIniFile.Create(getenv('HOME') + WebDebuggerIniFile) do
      try
        WriteString('', SActiveAtStartup, AValue);
      finally
        Free;
      end;
    {$ENDIF}
  end;

  function GetWebDebuggerPath: string;
  begin
    Result := '';
    {$IFDEF MSWINDOWS}
    with TRegistry.Create do
      try
        RootKey := HKEY_CURRENT_USER;
        if OpenKey(DelphiRegistryKey, False) then
          Result := ReadString('RootDir') + '\Bin\';
      finally
        Free;
      end;
    {$ENDIF}
    {$IFDEF LINUX}
    with TIniFile.Create(getenv('HOME') + DelphiIniFile) do
      try
        Result := ReadString('Globals', 'DelphiRoot', getenv('HOME') + '/kylix3') + '/bin/';
      finally
        Free;
      end;
    {$ENDIF}
  end;

  function GetDebuggerWindow: Integer;
  {$IFDEF MSWINDOWS}
  begin
    Result := FindWindow(WebDebuggerWindowClass, WebDebuggerWindowName);
  {$ENDIF}
  {$IFDEF LINUX}
    function GetPIDFile: string;
    begin
      Result := getenv('HOME') + '/.borland/wappappdbg.lck';
    end;

    function GetDebuggerPID: Integer;
    begin
      Result := 0;
      if FileExists(GetPIDFile) then
        with TFileStream.Create(GetPIDFile, 0) do
        try
          Read(Result, sizeof(Integer));
        finally
          Free;
        end;
    end;

    procedure DeletePIDFile;
    begin
      if FileExists(GetPIDFile) then
        DeleteFile(GetPIDFile);
    end;

  begin
    Result := GetDebuggerPID;
    if Result <> 0 then
    begin
      DeletePIDFile;
      kill(Result, SIGUSR2);
      Result := GetDebuggerPID;
    end;
  {$ENDIF}
  end;

  procedure DebuggerExecute;
  {$IFDEF MSWINDOWS}
  var
    SI: TStartupInfo;
    PI: TProcessInformation;
  begin
    SI.cb := SizeOf(SI);
    SI.lpReserved := nil;
    SI.lpDesktop := nil;
    SI.lpTitle := nil;
    SI.dwFlags := STARTF_USESHOWWINDOW;
    SI.wShowWindow := SW_SHOWNORMAL;
    SI.lpReserved2 := nil;
    SI.cbReserved2 := 0;

    CreateProcess(nil, PChar(GetWebDebuggerPath + WebDebuggerFileName), nil, nil, True, 0, nil, nil, SI, PI);
    WaitForInputIdle(PI.hProcess, INFINITE);
  {$ENDIF}
  {$IFDEF LINUX}
  var
    PID: Integer;
    FArgv: array of PChar;
  begin
    SetLength(FArgv, 2);
    FArgv[0] := PChar(GetWebDebuggerPath + WebDebuggerFileName);
    FArgv[1] := nil;
    PID := fork;
    if PID = 0 then
    begin
      execv(PChar(FArgv[0]), @FArgv[0]);
      Exit;
    end
{    else
      WaitForProcessSleep(PID);
 } //TODO
  {$ENDIF}
  end;
var
  ActiveSetting: Boolean;
begin
  if GetDebuggerWindow <> 0 then
    if not IsActive then
    begin
      {$IFDEF MSWINDOWS}
      PostMessage(GetDebuggerWindow, WM_CLOSE, 0, 0);
      {$ENDIF}
      {$IFDEF LINUX}
      kill(GetDebuggerWindow, SIGTERM);
      {$ENDIF}
      while GetDebuggerWindow <> 0 do
        Application.ProcessMessages;
    end
    else Exit;
  ActiveSetting := IsActiveOnStartUp;
  if not ActiveSetting then
    SetActiveOnStartUp('1');
  DebuggerExecute;
  if not ActiveSetting then
    SetActiveOnStartUp('0');
end;

procedure RunTestApplication(AWebApplicationName: string);
var
  AHTTPName: string;
  {$IFDEF LINUX}
  PID: Integer;
  FArgv: array of PChar;
  {$ENDIF}
begin
  if DesignerFileManager = nil then exit;
  RunServer;
  AHTTPName := GetURLAddress(AWebApplicationName);
  {$IFDEF MSWINDOWS}
  ShellExecute(0, 'open',  PChar(AHTTPName), nil, nil, 0);
  {$ENDIF}
  {$IFDEF LINUX}
  SetLength(FArgv, 3);
  FArgv[0] := PChar(GetBrowser);
  FArgv[1] := PChar(AHTTPName);
  FArgv[2] := nil; 
  PID := fork;
  if PID = 0 then
  begin
    execv(PChar(FArgv[0]), @FArgv[0]);
    Exit;
  end
  {$ENDIF}
end;

type
TcxWebDebuggerFileItem = class
private
  FFileName: string;
  FText: String;
public
  constructor Create(AFileName: string; AText: string);
end;

constructor TcxWebDebuggerFileItem.Create(AFileName: string; AText: string);
begin
  FFileName := AFileName;
  FText := AText;
end;

type

TcxWebDebuggerFileManager = class(TInterfacedObject, IDesignerFileManager,
        IcxWebDebugDesignerFileManager)
private
  FList: TList;

  procedure CreateItems;
protected
  function QualifyFileName(const AFileName: string): string;
  function GetStream(const AFileName: string; var AOwned: Boolean): TStream;
public
  constructor Create;
  destructor Destroy; override;
end;

{ TcxWebDesignerFileManager }
constructor TcxWebDebuggerFileManager.Create;
begin
  FList := TList.Create;
  CreateItems;
end;

destructor TcxWebDebuggerFileManager.Destroy;
var
  I: Integer;
begin
  for I := 0 to FList.Count - 1 do
    TcxWebDebuggerFileItem(FList[I]).Free;
  FList.Free;
  inherited Destroy;
end;

procedure TcxWebDebuggerFileManager.CreateItems;

  function GetTempDir: string;
  begin
    {$IFDEF MSWINDOWS}
    SetLength(Result, 255);
    SetLength(Result, GetTempPath(255, PChar(Result)));
    {$ENDIF}
    {$IFDEF LINUX}
    Result := '/tmp';
    {$ENDIF}
    if (Result <> '') and (Result[Length(Result)] <> PathDelim) then
      Result := Result + PathDelim;
  end;

var
  AFileStream: TFileStream;
  AReader: TReader;
  AFileName: string;
  AHTMLFileName, AText: string;
  AItem: TcxWebDebuggerFileItem;
begin
  AFileName := GetTempDir + scxDebugHTMLFileName;
  if not FileExists(AFileName) then exit;
  AFileStream := TFileStream.Create(AFileName, fmOpenRead);
  AReader := TReader.Create(AFileStream, 1024);
  try
    while AFileStream.Position < AFileStream.Size do
    begin
      AHTMLFileName := AReader.ReadString;
      AText := AReader.ReadString;
      AItem := TcxWebDebuggerFileItem.Create(AHTMLFileName, AText);
      FList.Add(AItem);
    end;
  finally
    AReader.Free;
    AFileStream.Free;
    DeleteFile(AFileName);
  end;
end;

function TcxWebDebuggerFileManager.GetStream(const AFileName: string; var AOwned: Boolean): TStream;
var
  I: Integer;
  AFullFileName: string;
begin
  Result := nil;
  if FList.Count = 0 then exit;
  AFullFileName := QualifyFileName(AFileName);
  for I := 0 to FList.Count - 1 do
    if CompareText(TcxWebDebuggerFileItem(FList[I]).FFileName, AFullFileName) = 0 then
    begin
      Result := TStringStream.Create(TcxWebDebuggerFileItem(FList[I]).FText);
      break;
    end;
end;

function TcxWebDebuggerFileManager.QualifyFileName(const AFileName: string): string;
var
  ASaveDesignerFileManager: IDesignerFileManager;
begin
  ASaveDesignerFileManager := DesignerFileManager;
  DesignerFileManager := nil;
  Result := cxWebUtils.QualifyFileName(AFileName);
  DesignerFileManager := ASaveDesignerFileManager;
end;

initialization
{$IFDEF MSWINDOWS}
  if IsDebuggerPresent then
{$ENDIF}
//TODO LINUX
    DesignerFileManager := TcxWebDebuggerFileManager.Create;

finalization
  DesignerFileManager := nil;
end.
