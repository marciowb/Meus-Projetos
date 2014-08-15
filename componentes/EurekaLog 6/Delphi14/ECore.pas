{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{              Core Unit - ECore                 }
{                                                }
{  Copyright (c) 2001 - 2008 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit ECore;

{$I Exceptions.inc}

interface

uses Windows, Classes, SysUtils, ETypes {$IFDEF GENERATE_ACTIVEX} , Controls {$ENDIF};

{$I VersionStrings.inc}

const
  VCL_Const = 'Forms.TApplication.HandleException';
  VCL_Const2 = 'Forms.TApplication.ShowException';
  CLX_Const = 'QForms.TApplication.HandleException';
  CLX_Const2 = 'QForms.TApplication.ShowException';
{$IFDEF Delphi5Down}
  ISAPI_Const = 'ISAPIApp.HandleServerException';
  CGI_Const = 'CGIApp.HandleServerException';
{$ELSE}
  ISAPI_Const = 'ISAPIApp.TISAPIApplication.ISAPIHandleException';
  CGI_Const = 'CGIApp.TCGIApplication.CGIHandleException';
{$ENDIF}
  IWebSrv_Const = 'IWServerControllerBase.TIWServerControllerBase.Create';
  IWebApp_Const = 'IWApplication.TIWApplication.ShowMessage';
  IWebRes_Const = 'InHTTPWebBrokerBridge.TInHTTPAppResponse.SendResponse';
  NTService_Const = 'SvcMgr.TService.LogMessage';
  IndyThread_Const = 'IdThread.TIdThread.DoException';

  ClassesInit_Const = 'Classes.Classes';
  ClassesFInit_Const = 'Classes.Finalization';
  VariantsFInit_Const = 'Variants.Finalization';
  SysUtilsInit_Const = 'SysUtils.SysUtils';
  SysUtilsFInit_Const = 'SysUtils.Finalization';
  SystemFInit_Const = 'System.Finalization';
  ELeaksFInit_Const = 'ELeaks.Finalization';
  ExceptionLogFInit_Const = 'ExceptionLog.Finalization';
  FastMM4FInit_Const = 'FastMM4.Finalization';

  VCL1_ID = 0;
  VCL2_ID = 1;
  CLX1_ID = 2;
  CLX2_ID = 3;
  ISAPI_ID = 4;
  CGI_ID = 5;
  IWebSrv_ID = 6;
  IWebApp_ID = 7;
  IWebRes_ID = 8;
  NTService_ID = 9;
  IndyThread_ID = 10;

  ClassesInit_ID = 11;
  ClassesFInit_ID = 12;
  VariantsFInit_ID = 13;
  SysUtilsInit_ID = 14;
  SysUtilsFInit_ID = 15;
  SystemFInit_ID = 16;
  ELeaksFInit_ID = 17;
  ExceptionLogFInit_ID = 18;
  FastMM4FInit_ID = 19;

  SymbolsCount = 20;

  RT_RCDATA = PAnsiChar(10);

type	
{$IFDEF Delphi3}
  _STARTUPINFOA = TStartupInfo;
{$ENDIF}

{$IFNDEF UNICODE}
  UnicodeString = WideString;
  RawByteString = AnsiString;
{$ENDIF}

  EIgnoreException = class(Exception);

  TProc = procedure;

  TCharSet = set of AnsiChar;

  // WARNING !!! Max 256 elements (see the TEurekaModuleOptions.SaveToStream method).
  TForegroundType =
    (ftGeneral, ftCallStack, ftModules, ftProcesses, ftAssembler,  ftCPU);

  TLoadType = (ltLoadModuleOptions, ltLoadDefaultOptions);

  TShowOptions = set of TShowOption;

  TCustomizedTexts = array[TMessageType] of AnsiString;

  TLogOption = (loNoDuplicateErrors, loAppendReproduceText,
    loDeleteLogAtVersionChange, loAddComputerNameInLogFileName,
    loSaveModulesAndProcessesSections, loSaveAssemblerAndCPUSections);

  TLogOptions = set of TLogOption;

  TCommonSendOption = (sndShowSendDialog, sndShowSuccessFailureMsg, sndSendEntireLog,
    sndSendXMLLogCopy, sndSendScreenshot, sndUseOnlyActiveWindow, sndSendLastHTMLPage,
    sndSendInSeparatedThread, sndAddDateInFileName, sndAddComputerNameInFileName);

  TCommonSendOptions = set of TCommonSendOption;

  TExceptionDialogType = (edtNone, edtMessageBox, edtMSClassic, edtEurekaLog);

  TExceptionDialogOption = (edoSendErrorReportChecked, edoAttachScreenshotChecked,
    edoShowCopyToClipOption, edoShowDetailsButton, edoShowInDetailedMode,
    edoShowInTopMostMode, edoUseEurekaLogLookAndFeel, edoShowSendErrorReportOption,
    edoShowAttachScreenshotOption, edoShowCustomButton);

  TExceptionDialogOptions = set of TExceptionDialogOption;

  TCallStackOption = (csoShowDLLs, csoShowBPLs, csoShowBorlandThreads,
    csoShowWindowsThreads, csoDoNotStoreProcNames);

  TCallStackOptions = set of TCallStackOption;

  TBehaviourOption = (boPauseBorlandThreads, boDoNotPauseMainThread,
    boPauseWindowsThreads, boUseMainModuleOptions, boCopyLogInCaseOfError,
    boSaveCompressedCopyInCaseOfError, boHandleSafeCallExceptions,
    boCallRTLExceptionEvent, boCatchHandledExceptions);

  TBehaviourOptions = set of TBehaviourOption;

  TLeaksOption = (loCatchLeaks, loGroupsSonLeaks, loHideBorlandLeaks,
    loFreeAllLeaks, loCatchLeaksExceptions);

  TLeaksOptions = set of TLeaksOption;

  TCompiledFileOption = (cfoReduceFileSize, cfoCheckFileCorruption);

  TCompiledFileOptions = set of TCompiledFileOption;

  // WARNING !!! Max 256 elements (see the TEurekaModuleOptions.SaveToStream method).
  TEmailSendMode = (esmNoSend, esmEmailClient, esmSMTPClient, esmSMTPServer);
  TWebSendMode = (wsmNoSend, wsmHTTP, wsmHTTPS, wsmFTP,
    wsmBugZilla, wsmFogBugz, wsmMantis);

  TModuleType = (mtUnknown, mtProgram, mtPackage, mtLibrary);

  TTerminateBtnOperation = (tbNone, tbTerminate, tbRestart);

  TFilterDialogType = (fdtNone, fdtUnchanged, fdtMessageBox, fdtMSClassic, fdtEurekaLog);

{$IFNDEF BUILD_FOR_DOTNET}
  TFilterHandlerType = (fhtNone, fhtRTL, fhtEurekaLog);
{$ELSE}
  TFilterHandlerType = (fhtNone, fhtEurekaLog);
{$ENDIF}

  TFilterActionType = (fatNone, fatTerminate, fatRestart);

  TFilterExceptionType = (fetAll, fetHandled, fetUnhandled);

  TEurekaExceptionFilter = packed record
    Active: Boolean;
    ExceptionClassName, ExceptionMessage: AnsiString;
    ExceptionType: TFilterExceptionType;
    DialogType: TFilterDialogType;
    HandlerType: TFilterHandlerType;
    ActionType: TFilterActionType;
  end;
  PEurekaExceptionFilter = ^TEurekaExceptionFilter;

  TEurekaModuleOptions = class;

  TEurekaExceptionsFilters = class(TList)
  private
    function GetItem(Index: Integer): PEurekaExceptionFilter;
  protected
    FOwner: TEurekaModuleOptions;
  public
    constructor Create(const Owner: TEurekaModuleOptions);
    destructor Destroy; override;
    function Add(Item: Pointer): Integer;
    procedure Insert(Index: Integer; Item: Pointer);
    procedure Assign(const Source: TEurekaExceptionsFilters);
    procedure Delete(Index: Integer);
    procedure Clear;
{$IFDEF Delphi4Up} override;
{$ENDIF}
    property Items[Index: Integer]: PEurekaExceptionFilter read GetItem; default;
  end;

{$IFDEF GENERATE_ACTIVEX}
  TEurekaModuleOptions = class(TWinControl)
{$ELSE}
  TEurekaModuleOptions = class(TObject)
{$ENDIF}
    function GetCustomizedTexts(Index: TMessageType): AnsiString;
    procedure SetCustomizedTexts(Index: TMessageType; Value: AnsiString);
  private
    procedure SetExceptionDialogType(const Value: TExceptionDialogType);
    procedure SetExceptionsFilters(const Value: TEurekaExceptionsFilters);
    procedure SetErrorsNumberToSave(const Value: Integer);
    procedure SetModuleName(const Value: AnsiString);
    procedure SetModuleHandle(const Value: THandle);
    procedure SetActivateHandle(const Value: boolean);
    procedure SetActivateLog(const Value: boolean);
    procedure SetAppendLogs(const Value: boolean);
    procedure SetEMailAddresses(const Value: AnsiString);
    procedure SetEMailMessage(const Value: AnsiString);
    procedure SetEMailSendMode(const Value: TEmailSendMode);
    procedure SetEMailSubject(const Value: AnsiString);
    procedure SetErrorsNumberToShowTerminateBtn(const Value: integer);
    procedure SetForegroundTab(const Value: TForegroundType);
    procedure SetFreezeTimeout(const Value: integer);
    procedure SetLogOptions(const Value: TLogOptions);
    procedure SetOutputPath(const Value: AnsiString);
    procedure SetSaveLogFile(const Value: boolean);
    procedure SetShowOptions(const Value: TShowOptions);
    procedure SetSMTPFrom(const Value: AnsiString);
    procedure SetSMTPHost(const Value: AnsiString);
    procedure SetSMTPPassword(const Value: AnsiString);
    procedure SetSMTPPort(const Value: Word);
    procedure SetSMTPUserID(const Value: AnsiString);
    procedure SetTerminateBtnOperation(const Value: TTerminateBtnOperation);
    procedure SaveToSharedData;
    procedure SetWebSendMode(const Value: TWebSendMode);
    procedure SetWebURL(const Value: AnsiString);
    procedure SetWebPassword(const Value: AnsiString);
    procedure SetWebPort(const Value: Integer);
    procedure SetWebUserID(const Value: AnsiString);
    procedure SetCommonSendOptions(const Value: TCommonSendOptions);
    procedure SetAttachedFiles(const Value: AnsiString);
    procedure SetExceptionDialogOptions(const Value: TExceptionDialogOptions);
    procedure SetAutoCloseDialogSecs(const Value: Integer);
    procedure SetAutoCrashMinutes(const Value: Integer);
    procedure SetAutoCrashNumber(const Value: Integer);
    procedure SetAutoCrashOperation(const Value: TTerminateBtnOperation);
    procedure SetHTMLLayout(const Value: AnsiString);
    procedure SetSupportURL(const Value: AnsiString);
    procedure SetBehaviourOptions(const Value: TBehaviourOptions);
    procedure SetCallStackOptions(const Value: TCallStackOptions);
    procedure SetCompiledFileOptions(const Value: TCompiledFileOptions);
    procedure SetPostFailureBuildEvent(const Value: AnsiString);
    procedure SetPostSuccessfulBuildEvent(const Value: AnsiString);
    procedure SetPreBuildEvent(const Value: AnsiString);
    procedure SetProxyPassword(const Value: AnsiString);
    procedure SetProxyPort(const Value: Word);
    procedure SetProxyURL(const Value: AnsiString);
    procedure SetProxyUserID(const Value: AnsiString);
    procedure SetTrakerAssignTo(const Value: AnsiString);
    procedure SetTrakerCategory(const Value: AnsiString);
    procedure SetTrakerPassword(const Value: AnsiString);
    procedure SetTrakerProject(const Value: AnsiString);
    procedure SetTrakerTrialID(const Value: AnsiString);
    procedure SetTrakerUserID(const Value: AnsiString);
    procedure SetZipPassword(const Value: AnsiString);
    procedure SetTextsCollection(const Value: AnsiString);
    function GetCustomizedExpandedTexts(Index: TMessageType): AnsiString;
    procedure SetReproduceText(const Value: AnsiString);
  protected
    FSharedData: Integer;
    FSMTPFrom, FSMTPHost, FSMTPUserID, FSMTPPassword: AnsiString;
    FSMTPPort: Word;
    // 6.0 start...
    FProxyURL, FProxyUserID, FProxyPassword: AnsiString;
    FProxyPort: Word;
    FTrakerUserID, FTrakerPassword, FTrakerAssignTo, FTrakerProject,
      FTrakerCategory, FTrakerTrialID: AnsiString;
    FZipPassword: AnsiString;
    FPreBuildEvent, FPostSuccessfulBuildEvent, FPostFailureBuildEvent: AnsiString;
    FCompiledFileOptions: TCompiledFileOptions;
    // 6.0 end!
    FTerminateBtnOperation: TTerminateBtnOperation;
    FFreezeActivate: boolean;
    FFreezeTimeout: integer;
    FModuleName: AnsiString;
    FModuleHandle: THandle;
    FShowOptions: TShowOptions;
    FExceptionDialogType: TExceptionDialogType;
    FExceptionsFilters: TEurekaExceptionsFilters;
    FCustomizedTexts: TCustomizedTexts;
    FTextsCollection: AnsiString;
    FActivateLog, FActivateHandle, FAppendLogs, FSaveLogFile: boolean;
    FLogOptions: TLogOptions;
    FCommonSendOptions: TCommonSendOptions;
    FForegroundTab: TForegroundType;
    FErrorsNumberToSave, FErrorsNumberToShowTerminateBtn: Integer;
    FOutputPath: AnsiString;
    FEMailAddresses, FEMailSubject, FEMailMessage: AnsiString;
    FEMailSendMode: TEmailSendMode;
    FWebSendMode: TWebSendMode;
    FAttachedFiles: AnsiString;
    FExceptionDialogOptions: TExceptionDialogOptions;
    FAutoCloseDialogSecs: Integer;
    FSupportURL: AnsiString;
    FHTMLLayout: AnsiString;
    FAutoCrashOperation: TTerminateBtnOperation;
    FAutoCrashNumber: Integer;
    FAutoCrashMinutes: Integer;
    FCallStackOptions: TCallStackOptions;
    FBehaviourOptions: TBehaviourOptions;
    FLeaksOptions: TLeaksOptions;
    FWebURL: AnsiString;
    FWebPort: Integer;
    FWebPassword: AnsiString;
    FWebUserID: AnsiString;
    FReproduceText: AnsiString;
    FActive: Boolean;
    procedure SetActive(const Value: Boolean); virtual;
    procedure SetFreezeActivate(const Value: Boolean); virtual;
    procedure DisableSharedDataWrite;
    procedure EnableSharedDataWrite;

    property PreBuildEvent: AnsiString read FPreBuildEvent write SetPreBuildEvent;
    property PostSuccessfulBuildEvent: AnsiString read FPostSuccessfulBuildEvent
      write SetPostSuccessfulBuildEvent;
    property PostFailureBuildEvent: AnsiString read FPostFailureBuildEvent
      write SetPostFailureBuildEvent;
  public
    // Procedures...
    constructor Create(AModuleName: AnsiString);
      {$IFDEF GENERATE_ACTIVEX} reintroduce; {$ENDIF}
    destructor Destroy; override;
    procedure Assign(Source: TEurekaModuleOptions);
      {$IFDEF GENERATE_ACTIVEX} reintroduce; {$ENDIF} virtual;
    procedure SetToDefaultOptions; virtual;
    procedure SaveToStream(Stream: TStream); virtual;
    procedure SaveToFile(const Filename: AnsiString); virtual;
    procedure LoadFromStream(Stream: TStream); virtual;
    procedure LoadFromFile(const FileName: AnsiString); virtual;
    function OutputFile(FileName: AnsiString): AnsiString;
    function OutputLogFile(BaseFile: AnsiString): AnsiString;
    procedure SaveCustomizedTextsToFile(const FileName: AnsiString);
    procedure LoadCustomizedTextsFromFile(const FileName: AnsiString);

    procedure StoreSharedData; virtual;
    procedure LoadSharedData; virtual;
    // Properties...
    property ModuleName: AnsiString read FModuleName write SetModuleName;
    property ModuleHandle: THandle read FModuleHandle write SetModuleHandle;
    property SMTPFrom: AnsiString read FSMTPFrom write SetSMTPFrom;
    property SMTPHost: AnsiString read FSMTPHost write SetSMTPHost;
    property SMTPPort: Word read FSMTPPort write SetSMTPPort;
    property SMTPUserID: AnsiString read FSMTPUserID write SetSMTPUserID;
    property SMTPPassword: AnsiString read FSMTPPassword write SetSMTPPassword;
    property FreezeActivate: Boolean read FFreezeActivate write
      SetFreezeActivate;
    property FreezeTimeout: integer read FFreezeTimeout write SetFreezeTimeout;
    property ExceptionsFilters: TEurekaExceptionsFilters read FExceptionsFilters
      write SetExceptionsFilters;
    property CustomizedTexts[Index: TMessageType]: AnsiString read GetCustomizedTexts
      write SetCustomizedTexts;
    property TextsCollection: AnsiString read FTextsCollection write SetTextsCollection;
    property ActivateLog: boolean read FActivateLog write SetActivateLog;
    property SaveLogFile: boolean read FSaveLogFile write SetSaveLogFile;
    property ActivateHandle: boolean read FActivateHandle write SetActivateHandle;
    property ForegroundTab: TForegroundType read FForegroundTab write
      SetForegroundTab;
    property AppendLogs: boolean read FAppendLogs write SetAppendLogs;
    property TerminateBtnOperation: TTerminateBtnOperation
      read FTerminateBtnOperation write SetTerminateBtnOperation;
    property LogOptions: TLogOptions read FLogOptions write SetLogOptions;
    property ShowOptions: TShowOptions read FShowOptions write SetShowOptions;
    property ErrorsNumberToSave: Integer read FErrorsNumberToSave write
      SetErrorsNumberToSave;
    property ErrorsNumberToShowTerminateBtn: integer read
      FErrorsNumberToShowTerminateBtn
      write SetErrorsNumberToShowTerminateBtn;
    property OutputPath: AnsiString read FOutputPath write SetOutputPath;
    property EMailAddresses: AnsiString read FEMailAddresses write SetEMailAddresses;
    property EMailSubject: AnsiString read FEMailSubject write SetEMailSubject;
    property EMailMessage: AnsiString read FEMailMessage write SetEMailMessage;
    property EMailSendMode: TEmailSendMode read FEMailSendMode write SetEMailSendMode;
    property WebSendMode: TWebSendMode read FWebSendMode write
      SetWebSendMode;
    property WebURL: AnsiString read FWebURL write SetWebURL;
    property WebUserID: AnsiString read FWebUserID write SetWebUserID;
    property WebPassword: AnsiString read FWebPassword write SetWebPassword;
    property WebPort: Integer read FWebPort write SetWebPort;
    property CommonSendOptions: TCommonSendOptions read FCommonSendOptions
      write SetCommonSendOptions;
    property AttachedFiles: AnsiString read FAttachedFiles write SetAttachedFiles;
    property ExceptionDialogType: TExceptionDialogType
      read FExceptionDialogType write SetExceptionDialogType;
    property ExceptionDialogOptions: TExceptionDialogOptions
      read FExceptionDialogOptions write SetExceptionDialogOptions;
    property AutoCloseDialogSecs: Integer read FAutoCloseDialogSecs
      write SetAutoCloseDialogSecs;
    property SupportURL: AnsiString read FSupportURL write SetSupportURL;
    property HTMLLayout: AnsiString read FHTMLLayout write SetHTMLLayout;
    property AutoCrashOperation: TTerminateBtnOperation read FAutoCrashOperation
      write SetAutoCrashOperation;
    property AutoCrashNumber: Integer read FAutoCrashNumber
      write SetAutoCrashNumber;
    property AutoCrashMinutes: Integer read FAutoCrashMinutes
      write SetAutoCrashMinutes;
    property CallStackOptions: TCallStackOptions read FCallStackOptions
      write SetCallStackOptions;
    property BehaviourOptions: TBehaviourOptions read FBehaviourOptions
      write SetBehaviourOptions;
    // 6.0 start...
    property LeaksOptions: TLeaksOptions read FLeaksOptions;
    property ProxyURL: AnsiString read FProxyURL write SetProxyURL;
    property ProxyUserID: AnsiString read FProxyUserID write SetProxyUserID;
    property ProxyPassword: AnsiString read FProxyPassword write SetProxyPassword;
    property ProxyPort: Word read FProxyPort write SetProxyPort;
    property TrakerUserID: AnsiString read FTrakerUserID write SetTrakerUserID;
    property TrakerPassword: AnsiString read FTrakerPassword write SetTrakerPassword;
    property TrakerAssignTo: AnsiString read FTrakerAssignTo write SetTrakerAssignTo;
    property TrakerProject: AnsiString read FTrakerProject write SetTrakerProject;
    property TrakerCategory: AnsiString read FTrakerCategory write SetTrakerCategory;
    property TrakerTrialID: AnsiString read FTrakerTrialID write SetTrakerTrialID;
    property ZipPassword: AnsiString read FZipPassword write SetZipPassword;
    property CompiledFileOptions: TCompiledFileOptions read FCompiledFileOptions
      write SetCompiledFileOptions;
    property ReproduceText: AnsiString read FReproduceText write SetReproduceText;

    property CustomizedExpandedTexts[Index: TMessageType]: AnsiString read GetCustomizedExpandedTexts;

    // 6.0 end!
    property Active: boolean read FActive write SetActive;
  end;

var
  LastEurekaVersion: Word;
  CriticalError: procedure (const Section: AnsiString) = nil;

function IntoIDE: Boolean;
function ReadKey(Root: HKey; Key, Str: AnsiString): AnsiString;
function CheckKey(Root: HKey; Key: AnsiString): Boolean;
function RADRegistryKey: AnsiString;
function RADDir: AnsiString;
function GetGMT: Integer;
function GetGMTDateTime(DateTime: TDateTime): TDateTime;
function GetEurekaLogLabel: AnsiString;
function QuickStringReplace(const S, OldPattern, NewPattern: AnsiString): AnsiString;
function PosEx(const SubStr, S: AnsiString; Idx: Integer): Integer;
procedure ExtractStringsEx(Separators: TCharSet; Content: AnsiString; Strings: TStrings);
function GetModifiedDate(sFileName: AnsiString): TDateTime;
function GetLongNameFromShort(Path: AnsiString): AnsiString;
function IsValidBlockAddr(Address, Size: DWord): Boolean;
function ConvertAddress(Addr: DWord): DWord;
procedure SafeExec(Proc: TProc; Section: AnsiString);
function IncludeLastBackslash(Source: AnsiString): AnsiString;
function ExcludeLastBackslash(const S: AnsiString): AnsiString;
function ForceDirectoriesEx(Dir: AnsiString): Boolean;
function IsWritableFile(const FileName: AnsiString): Boolean;
function IsReadableFile(const FileName: AnsiString): Boolean;
function GetWorkingFile(var FileName: AnsiString; ProjectDir, ReadOnly: Boolean): Boolean;
function GetWorkingDir(var DirName: AnsiString; ProjectDir, ReadOnly: Boolean): Boolean;
function SupportsEx(const Instance: IUnknown; const Intf: TGUID; out Inst): Boolean;
function OneString(const s: AnsiString): AnsiString;

function ReadString(FileName: AnsiString; const Section, Ident, Default: AnsiString): AnsiString;
function ReadInteger(FileName: AnsiString; const Section, Ident: AnsiString; Default: Integer): Integer;
function ReadBool(FileName: AnsiString; const Section, Ident: AnsiString; Default: Boolean): Boolean;
procedure WriteString(FileName: AnsiString; const Section, Ident, Value: AnsiString);
procedure WriteInteger(FileName: AnsiString; const Section, Ident: AnsiString; Value: Integer);
procedure WriteBool(FileName: AnsiString; const Section, Ident: AnsiString; Value: Boolean);

procedure ReadRawStrings(const Cnf: AnsiString; Section, CountName, Prefix, Default: AnsiString;
  var Value: AnsiString);
procedure WriteRawStrings(Cnf: AnsiString; Section, CountName, Prefix: AnsiString; Value: AnsiString);
function GetEnvVariable(const Name: AnsiString): AnsiString;
function ExpandEnvVars(const Source: AnsiString): AnsiString;
function DotNetHostedFile(const FileName: AnsiString): AnsiString;
function StringToUtf8(const S: AnsiString): AnsiString;

procedure ExtractList(Source: AnsiString; List: TStrings; Separators: TCharSet;
  IncludeEmpty, IncludeSeparator: Boolean);

function Real_GetMainModuleFileName: AnsiString;

function IsGreaterVersion(MinorVer, MajorVer: AnsiString): Boolean;

{$IFDEF BUILD_FOR_DOTNET}
var
  VisualStudioVer: AnsiString = '';
  DOTNET_GetCurrentProcess: THandle;
  DOTNET_GetCommandLine: AnsiString;
{$ENDIF}

implementation

uses EConsts, TypInfo {$IFDEF DUNITPROJECT} {$IFDEF Delphi9Down} ,MemCheck {$ENDIF} {$ENDIF};

var
  InternalIntoIDE: Boolean;

//------------------------------------------------------------------------------

function IsGreaterVersion(MinorVer, MajorVer: AnsiString): Boolean;

  function CompleteVersion(const Ver: AnsiString): AnsiString;
  var
    Idx, OldIdx, Count, n: Integer;
    S: AnsiString;

    function ZeroComplete(const Src: AnsiString): AnsiString;
    var
      n: Integer;
    begin
      Result := Src;
      for n := Length(Src) to 4 do Result := ('0' + Result);
    end;

  begin
    Count := 0;
    OldIdx := 1;
    repeat
      Idx := PosEx('.', Ver, OldIdx);
      if (Idx > 0) then S := Copy(Ver, OldIdx, (Idx - OldIdx))
      else
      begin
        n := PosEx(' ', Ver, OldIdx);
        if (n = 0) then S := Copy(Ver, OldIdx, MaxInt)
        else S := ZeroComplete(Copy(Ver, OldIdx, n - OldIdx)) +
          Copy(Ver, n, MaxInt);
      end;
      S := ZeroComplete(S);
      if (Count = 0) then Result := S
      else Result := (Result + '.' + S);
      OldIdx := (Idx + 1);
      Inc(Count);
    until (Idx = 0);
    for n := Count to 3 do Result := (Result + '.00000');
  end;

begin
  Result := False;
  MinorVer := CompleteVersion(MinorVer);
  MajorVer := CompleteVersion(MajorVer);
  if (MajorVer = '') or (MinorVer = '') then Exit;
  Result := (MajorVer > MinorVer);
end;

//------------------------------------------------------------------------------

{$IFDEF BUILD_FOR_DOTNET}
function GetDOTNETProcessFileName: AnsiString;
var
  n: Integer;
begin
  Result := DOTNET_GetCommandLine;

  if (Copy(Result, 1, 1) = '"') then
  begin
    Delete(Result, 1, 1);
    for n := 1 to Length(Result) do
      if (Result[n] = '"') then
      begin
        Delete(Result, n, MaxInt);
        Break;
      end;
  end
  else
  begin
    for n := 1 to Length(Result) do
      if (Result[n] = ' ') then
      begin
        Delete(Result, n, MaxInt);
        Break;
      end;
  end;
end;
{$ENDIF}

function Real_GetMainModuleFileName: AnsiString;
begin
{$IFNDEF BUILD_FOR_DOTNET}
  Result := AnsiString(ParamStr(0));
{$ELSE}
  Result := GetDOTNETProcessFileName;
{$ENDIF}
end;

//------------------------------------------------------------------------------

procedure ExtractList(Source: AnsiString; List: TStrings; Separators: TCharSet;
  IncludeEmpty, IncludeSeparator: Boolean);
var
  i, old: integer;
  s: AnsiString;
begin
  old := 1;
  if (not IncludeSeparator) then Source := Trim(Source);
  for i := 1 to Length(Source) do
  begin
    if (Source[i] in Separators) then
    begin
      if (IncludeSeparator) then s := Copy(Source, old, i - old + 1)
      else s := Trim(Copy(Source, old, i - old));
      if ((s <> '') or (IncludeEmpty)) then List.Add(s);
      old := i + 1;
    end;
  end;
  s := Copy(Source, old, Length(Source) - old + 1);
  if (not IncludeSeparator) then s := Trim(s);
  if (s <> '') then List.Add(s);
end;

function StringToUtf8(const S: AnsiString): AnsiString;
var
  L: Integer;
  Temp: AnsiString;
  WS: WideString;

  function WideStringToUtf8(
    Dest: PAnsiChar; MaxSize: DWord; Source: PWideChar; SourceSize: DWord): DWord;
  var
    n, count, ch: DWord;
  begin
    Result := 0;
    if (Source = nil) then Exit;

    count := 0;
    n := 0;
    if (Dest <> nil) then
    begin
      while ((n < SourceSize) and (count < MaxSize)) do
      begin
        ch := DWord(Source[n]);
        Inc(n);
        if (ch <= $7F) then
        begin
          Dest[count] := AnsiChar(ch);
          Inc(count);
        end
        else
          if (ch > $7FF) then
          begin
            if (count + 3 > MaxSize) then break;

            Dest[count]   := (AnsiChar($E0 or (ch shr 12)));
            Dest[count+1] := (AnsiChar($80 or ((ch shr 6) and $3F)));
            Dest[count+2] := (AnsiChar($80 or (ch and $3F)));
            Inc(count, 3);
          end
          else //  $7F < Source[n] <= $7FF
          begin
            if (count + 2 > MaxSize) then break;

            Dest[count]   := (AnsiChar($C0 or (ch shr 6)));
            Dest[count+1] := (AnsiChar($80 or (ch and $3F)));
            Inc(count, 2);
          end;
      end;
      if (count >= MaxSize) then count := (MaxSize - 1);
      Dest[count] := #0;
    end
    else
    begin
      while (n < SourceSize) do
      begin
        ch := Integer(Source[n]);
        Inc(n);
        if (ch > $7F) then
        begin
          if (ch > $7FF) then Inc(count);
          Inc(count);
        end;
        Inc(count);
      end;
    end;
    Result := (count + 1);  // convert zero based index to byte count
  end;


begin
  WS := S;
  Result := '';
  if (WS = '') then Exit;

  SetLength(Temp, Length(WS) * 3); // SetLength includes space for null terminator

  L := WideStringToUtf8(PAnsiChar(Temp), Length(Temp)+1, PWideChar(WS), Length(WS));
  if (L > 0) then SetLength(Temp, L-1)
  else Temp := '';

  Result := Temp;
end;

function GetEnvVariable(const Name: AnsiString): AnsiString;
const
  BufSize = 1024;
var
  Len: Integer;
  Buffer: array[0..BufSize - 1] of AnsiChar;
  S: String;
begin
  Result := '';
  Len := GetEnvironmentVariableA(PAnsiChar(Name), @Buffer, BufSize);
  if (Len < BufSize) then
    SetString(Result, PAnsiChar(@Buffer), Len)
  else
  begin
    SetLength(Result, Len - 1);
    GetEnvironmentVariableA(PAnsiChar(Name), PAnsiChar(Result), Len);
  end;
  // "special" variables
  if Len = 0 then
  begin
    S := AnsiLowerCase(Name);
    if S = 'date' then
      Result := DateToStr(Date)
    else
    if S = 'time' then
      Result := TimeToStr(Time)
    else
    if S = 'cd' then
      Result := GetCurrentDir;
  end; 
end;

function ExpandEnvVars(const Source: AnsiString): AnsiString;
const
  Digits: set of AnsiChar = ['a'..'z', 'A'..'Z', '_', '0'..'9'];
var
  n, Idx: Integer;
  OldVar, NewVar: AnsiString;
begin
  Result := Source;

  n := 1;
  while (n <= Length(Result)) do
  begin
    if (Result[n] = '%') then
    begin
      Idx := n;
      Inc(n);
      while (n < Length(Result)) and (Result[n] in Digits) do Inc(n);
      if (Result[n] = '%') then
      begin
        OldVar := Copy(Result, Idx + 1, n - Idx - 1);
        NewVar := GetEnvVariable(OldVar);
        Delete(Result, Idx, Length(OldVar) + 2);
        Insert(NewVar, Result, Idx);
        n := (Idx + Length(NewVar) - 1);
      end;
    end;
    Inc(n);
  end;
end;

function DotNetHostedFile(const FileName: AnsiString): AnsiString;
begin
  Result := QuickStringReplace(FileName, '.vshost', '');
end;

function GetUserApplicationsPath: AnsiString;

  function GetProfileFolder: AnsiString;
  var
    SHGetFolderPath: function (hwnd: HWND; csidl: Integer; hToken: THandle;
      dwFlags: DWORD; pszPath: PAnsiChar): HResult; stdcall;
    Lib: THandle;
    Buffer: array[0..MAX_PATH] of AnsiChar;
  begin
    Result := '';

    Lib := LoadLibrary('shfolder.dll');
    if (Lib <> 0) then
    try
      @SHGetFolderPath := GetProcAddress(Lib, 'SHGetFolderPathA');
      if (Assigned(SHGetFolderPath)) then
      begin
        if (SHGetFolderPath(0, $001A {CSIDL_APPDATA}, 0, 0, Buffer) = S_OK) then
          Result := Buffer;
      end;
    finally
      FreeLibrary(Lib);
    end;
  end;

begin
  Result := GetProfileFolder;
  if (Result = '') then Result := GetEnvVariable('AppData');
  if (Result = '') then Result := '\'; // On Win9x, %AppData% is not defined
end;

function WindowsDir: AnsiString;
var
  Buff: array[0..255] of AnsiChar;
  I: DWord;
begin
  I := SizeOf(Buff);
  GetWindowsDirectoryA(Buff, I);
  Result := Buff;
end;

function GetEurekaLogDir: AnsiString;
begin
  Result := (GetUserApplicationsPath + '\EurekaLog');
end;

function IniDir: AnsiString;
begin
  if (Win32Platform = VER_PLATFORM_WIN32_WINDOWS) then Result := WindowsDir
  else Result := GetEurekaLogDir;
end;

function ReadString(FileName: AnsiString; const Section, Ident, Default: AnsiString): AnsiString;
var
  Buffer: array[0..2047] of AnsiChar;
begin
  Result := Default;
  if (ExtractFilePath(FileName) = '') then FileName := (IniDir + '\' + FileName);
  if (not GetWorkingFile(FileName, False, False)) then Exit;

  SetString(Result, Buffer, GetPrivateProfileStringA(PAnsiChar(Section),
    PAnsiChar(Ident), PAnsiChar(Default), Buffer, SizeOf(Buffer), PAnsiChar(FileName)));
end;

function ReadInteger(FileName: AnsiString; const Section, Ident: AnsiString; Default: Integer): Integer;
begin
  Result := StrToIntDef(ReadString(FileName, Section, Ident, IntToStr(Default)), Default);
end;

function ReadBool(FileName: AnsiString; const Section, Ident: AnsiString; Default: Boolean): Boolean;
begin
  Result := (ReadInteger(FileName, Section, Ident, Integer(Default)) = 1);
end;

procedure WriteString(FileName: AnsiString; const Section, Ident, Value: AnsiString);
begin
  if (ExtractFilePath(FileName) = '') then FileName := (IniDir + '\' + FileName);
  if (not GetWorkingFile(FileName, False, False)) then Exit;

  WritePrivateProfileStringA(PAnsiChar(Section), PAnsiChar(Ident), PAnsiChar(Value), PAnsiChar(FileName));
end;

procedure WriteInteger(FileName: AnsiString; const Section, Ident: AnsiString; Value: Integer);
begin
  WriteString(FileName, Section, Ident, IntToStr(Value));
end;

procedure WriteBool(FileName: AnsiString; const Section, Ident: AnsiString; Value: Boolean);
begin
  WriteInteger(FileName, Section, Ident, Integer(Value));
end;

function OneString(const s: AnsiString): AnsiString;
var
  i: integer;
  LastSpace: Boolean;
begin
  Result := '';
  if (s <> '') then
  begin
    LastSpace := False;
    for i := 1 to Length(s) do
      if (s[i] >= #32) then
      begin
        Result := (Result + s[i]);
        LastSpace := False;
      end
      else
        if (not LastSpace) then
        begin
          Result := (Result + ' ');
          LastSpace := True;
        end;
  end;
end;

function SupportsEx(const Instance: IUnknown; const Intf: TGUID; out Inst): Boolean;
begin
  Result := (Instance <> nil) and (Instance.QueryInterface(Intf, Inst) = 0) and (Pointer(Inst) <> nil);
end;

function GetReadableSize(Address, Size: DWord): DWord;
const
  ReadAttributes = [PAGE_READONLY, PAGE_READWRITE, PAGE_WRITECOPY, PAGE_EXECUTE,
    PAGE_EXECUTE_READ, PAGE_EXECUTE_READWRITE, PAGE_EXECUTE_WRITECOPY];
var
  MemInfo: TMemoryBasicInformation;
  Tmp: DWord;
begin
  Result := 0;
  if (VirtualQuery(Pointer(Address), MemInfo, SizeOf(MemInfo)) = SizeOf(MemInfo)) and
    (MemInfo.State = MEM_COMMIT) and (MemInfo.Protect in ReadAttributes) then
  begin
    Result := (MemInfo.RegionSize - (Address - DWord(MemInfo.BaseAddress)));
    if (Result < Size) then
    begin
      repeat
        Tmp := GetReadableSize((DWord(MemInfo.BaseAddress) + MemInfo.RegionSize), (Size - Result));
        if (Tmp > 0) then Inc(Result, Tmp)
        else Result := 0;
      until (Result >= Size) or (Tmp = 0);
    end;
  end;
end;

function IsValidBlockAddr(Address, Size: DWord): Boolean;
begin
  Result := (GetReadableSize(Address, Size) >= Size);
end;

function ConvertAddress(Addr: DWord): DWord;
type
  TJMPCode = packed record
    JMPOpCode: Word;
    JMPPtr: PDWord;
    MOVOpCode: Word;
  end;
  PJMPCode = ^TJMPCode;
var
  JMP: PJMPCode;
begin
  Result := Addr;
  if (IsValidBlockAddr(Addr, 8)) then
  begin
    JMP := PJMPCode(Addr);
    if (JMP^.JMPOpCode = $25FF) and (IsValidBlockAddr(DWord(JMP^.JMPPtr), 4)) then
      Result := JMP^.JMPPtr^;
  end;
end;

function GetModifiedDate(sFileName: AnsiString): TDateTime;
var
  ffd: TWin32FindDataA;
  dft: DWord;
  lft: TFileTime;
  h: THandle;
begin
  Result := 0;
  // Get file information
  h := Windows.FindFirstFileA(PAnsiChar(sFileName), ffd);
  if (h <> INVALID_HANDLE_VALUE) then
  begin
    // We're looking for just one file, so close our "find"
    Windows.FindClose(h);
    // Convert the FILETIME to local FILETIME
    if FileTimeToLocalFileTime(ffd.ftLastWriteTime, lft) then
    begin
      // Convert FILETIME to DOS time
      if FileTimeToDosDateTime(lft, LongRec(dft).Hi, LongRec(dft).Lo) then
        Result := FileDateToDateTime(dft);
    end;
  end;
end;

function GetLongNameFromShort(Path: AnsiString): AnsiString;
var
  I: Integer;
  SearchHandle: THandle;
  FindData: TWin32FindDataA;
  IsBackSlash: Boolean;
begin
  Result := Path;
  if (Pos('~', Path) = 0) then Exit;

  Path := ExpandFileName(Path);
  Result := ExtractFileDrive(Path);
  I := Length(Result);
  if (Length(Path) <= I) then Exit; // only drive

  if (Path[I + 1] = '\') then
  begin
    Result := (Result + '\');
    Inc(I);
  end;
  Delete(Path, 1, I);
  repeat
    I := Pos('\', Path);
    IsBackSlash := (I > 0);
    if (not IsBackSlash) then I := (Length(Path) + 1);
    SearchHandle := FindFirstFileA(PAnsiChar(Result + Copy(Path, 1, I - 1)), FindData);
    if (SearchHandle <> INVALID_HANDLE_VALUE) then
    begin
      try
        Result := (Result + FindData.cFileName);
        if IsBackSlash then Result := (Result + '\');
      finally
        Windows.FindClose(SearchHandle);
      end;
    end
    else
    begin
      Result := (Result + Path);
      Break;
    end;
    Delete(Path, 1, I);
  until (Length(Path) = 0);
end;

function PosEx(const SubStr, S: AnsiString; Idx: Integer): Integer;
var
  n, len1, len2: Integer;
begin
  Result := 0;
  len1 := Length(SubStr);
  len2 := Length(S);
  n := Idx;
  while (n <= (len2 - len1 + 1)) and (Copy(S, n, len1) <> SubStr) do inc(n);
  if (n <= (len2 - len1 + 1)) then Result := n;
end;

function QuickStringReplace(const S, OldPattern, NewPattern: AnsiString): AnsiString;
var
  ResultLen, CopyLen, TextLen, OldLen, NewLen: Integer;
  PSource, POld, PNew, Index, PLastS, PLastR: PAnsiChar;
begin
  TextLen := Length(S);
  OldLen := Length(OldPattern);
  NewLen := Length(NewPattern);
  if (OldLen < NewLen) then
    ResultLen := (((TextLen div OldLen) * NewLen) + (TextLen mod OldLen))
  else
    ResultLen := Length(S);
  SetLength(Result, ResultLen);
  PSource := PAnsiChar(S);
  POld := PAnsiChar(OldPattern);
  PNew := PAnsiChar(NewPattern);
  PLastS := PSource;
  PLastR := PAnsiChar(Result);
  Index := PSource;
  repeat
    Index := StrPos(Index, POld);
    if (Index <> nil) then
    begin // Found...
      CopyLen := (Index - PLastS);
      Move(PLastS^, PLastR^, CopyLen);
      PLastS := (Index + OldLen);
      Inc (PLastR, CopyLen);
      Move(PNew^, PLastR^, NewLen);
      Inc(PLastR, NewLen);
      Inc(Index, OldLen);
    end
    else
    begin // Not found...
      CopyLen := (PAnsiChar(S) + TextLen - PLastS);
      Move(PLastS^, PLastR^, CopyLen);
      Inc (PLastR, CopyLen);
    end;
  until (Index = nil);
  SetLength(Result, (PLastR - PAnsiChar(Result)));
end;

procedure ExtractStringsEx(Separators: TCharSet; Content: AnsiString; Strings: TStrings);
var
  i, old: integer;
  s: AnsiString;
begin
  i := 1;
  if (Content = '') then Exit;
  while (i <= length(Content)) and (Content[i] in Separators) do
    inc(i);
  old := i;
  while (i <= length(Content)) do
  begin
    if (Content[i] in Separators) then
    begin
      s := Trim(Copy(content, old, i - old));
      Strings.Add(s);
      old := i + 1;
    end;
    inc(i);
  end;
  s := Trim(copy(content, old, i - old + 1));
  if s <> '' then Strings.Add(s);
end;

// This function read from the system's registry...
// -----------------------------------------------------------------------------
// WARNING !!!                                                                 -
// Don't use TRegistry.OpenKey before it open a key for Read/Write access,     -
// and in a machine when the user haven't the registry write permission failed -
// -----------------------------------------------------------------------------

function ReadKey(Root: HKey; Key, Str: AnsiString): AnsiString;
var
  Reg: HKey;
  Size: Integer;
  DataType: Integer;
begin
  Result := '';
  if (Key <> '') and (Key[1] = '\') then Delete(Key, 1, 1);
  if (RegOpenKeyExA(Root, PAnsiChar(Key), 0, KEY_READ, Reg) = ERROR_SUCCESS) then
  begin
    if RegQueryValueExA(Reg, PAnsiChar(Str), nil,
      @DataType, nil, @Size) = ERROR_SUCCESS then
    begin
      SetLength(Result, Size);
      RegQueryValueExA(Reg, PAnsiChar(Str), nil, @DataType, PByte(PAnsiChar(Result)), @Size);
      // Cut the last #0 AnsiChar...
      Result := Copy(Result, 1, Length(Result) - 1);
    end
    else
      Result := '';
    RegCloseKey(Reg);
  end;
end;

function CheckKey(Root: HKey; Key: AnsiString): Boolean;
var
  Reg: HKey;
begin
  Result := False;
  if (Key <> '') and (Key[1] = '\') then Delete(Key, 1, 1);
  if (RegOpenKeyExA(Root, PAnsiChar(Key), 0, KEY_READ, Reg) = ERROR_SUCCESS) then
  begin
    Result := True;
    RegCloseKey(Reg);
  end;
end;

function RADRegistryKey: AnsiString;

  function GetMultiConfigurationString: AnsiString;
  var
    n: Integer;
  begin
    Result := RADRegKeyName;
    if (not IntoIDE) then Exit;

    for n := 1 to ParamCount do
    begin
      if (UpperCase(Copy(ParamStr(n), 1, 2)) = '-R') then
      begin
        Result := Copy(ParamStr(n), 3, Length(ParamStr(n)));
        Break;
      end;
    end;
  end;

begin
  Result := ('SOFTWARE\' + _CompanyName + '\' + GetMultiConfigurationString + '\' + RADVersionString);
end;

// Delphi/BCB installed dir...
function RADDir: AnsiString;
begin
{$IFNDEF BUILD_FOR_DOTNET}
  Result := ReadKey(HKEY_LOCAL_MACHINE, RADRegistryKey, 'RootDir');

  if Result = '' then // Check for an installation as single user...
    Result := ReadKey(HKEY_CURRENT_USER, RADRegistryKey, 'RootDir');

  if (Result <> '') and (Result[Length(Result)] = '\') then
    Delete(Result, Length(Result), 1);
{$ELSE}
  Result := ExpandEnvVars(ReadKey(HKEY_CURRENT_USER, 'Software\Microsoft\VisualStudio\' +
    VisualStudioVer, 'VisualStudioLocation'));
{$ENDIF}
end;

function GetGMT: Integer;
var
  GMTTime, LocalTime: TSystemTime;
begin
  GetSystemTime(GMTTime);
  GetLocalTime(LocalTime);
  Result := Round((SystemTimeToDateTime(LocalTime) - SystemTimeToDateTime(GMTTime)) * 24);
end;

function GetGMTDateTime(DateTime: TDateTime): TDateTime;
begin
  Result := (DateTime - (GetGMT / 24));
end;

function GetEurekaLogLabel: AnsiString;

  function EurekaLogType: AnsiString;
  begin
{$IFNDEF BUILD_FOR_DOTNET}
    Result := ReadKey(HKEY_CURRENT_USER, '\Software\EurekaLog', 'AppType');
{$ELSE}
    Result := ReadKey(HKEY_CURRENT_USER, '\Software\EurekaLog for Visual Studio', 'AppType');
{$ENDIF}
{$IFDEF EUREKALOG_DEMO}
    if Result = 'TRL' then Result := EurekaTypeTRL
    else
{$ENDIF}
{$IFNDEF PROFESSIONAL}
      if Result = 'STD' then Result := EurekaTypeSTD;
{$ELSE}
      if Result = 'PRO' then Result := EurekaTypePRO
      else
        if Result = 'ENT' then Result := EurekaTypeENT;
{$ENDIF}
  end;

begin
  Result := 'EurekaLog ' + EurekaLogVersion + ' ' + EurekaLogType;
end;

function IntoIDE: Boolean;
begin
  Result := InternalIntoIDE;
end;

function CheckIntoIDE: boolean;
var
  Buff: array[0..MAX_PATH - 1] of AnsiChar;
  FileName: AnsiString;
begin
  if (GetModuleFileNameA(MainInstance, Buff, SizeOf(Buff)) > 0) then
    FileName := Buff
  else
    FileName := '';
  Result := UpperCase(ExtractFileName(FileName)) = RADExeName;
end;

function IncludeLastBackslash(Source: AnsiString): AnsiString;
begin
  if Source = '' then Result := '\'
  else
  begin
    Result := Source;
    if Copy(Source, length(Source), 1) <> '\' then Result := (Result + '\');
  end;
end;

function ExcludeLastBackslash(const S: AnsiString): AnsiString;
begin
  Result := S;

  if (Copy(Result, Length(Result), 1) = '\') then
    SetLength(Result, Length(Result) - 1);
end;

function CheckDirectoryExists(const Directory: AnsiString): Boolean;
var
  Code: Integer;
begin
  Code := GetFileAttributesA(PAnsiChar(Directory));
  Result := (Code <> -1) and (FILE_ATTRIBUTE_DIRECTORY and Code <> 0);
end;

function ForceDirectoriesEx(Dir: AnsiString): Boolean;
begin
  Result := True;
  if (Dir = '') then
  begin
    Result := False;
    Exit;
  end;

  Dir := ExpandEnvVars(ExcludeLastBackslash(Dir));
  if (Length(Dir) < 3) or CheckDirectoryExists(Dir)
    or (ExtractFilePath(Dir) = Dir) then Exit; // avoid 'xyz:\' problem.

  Result := ForceDirectoriesEx(ExtractFilePath(Dir)) and CreateDir(Dir);
end;

function IsWritableFile(const FileName: AnsiString): Boolean;
var
  HFile: THandle;
  FExists: Boolean;
begin
  Result := False;
  FExists := FileExists(FileName);

  HFile := CreateFileA(PAnsiChar(FileName), GENERIC_WRITE or GENERIC_READ,
    FILE_SHARE_READ or FILE_SHARE_WRITE, nil,
    OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
  if (HFile <> INVALID_HANDLE_VALUE) then
  begin
    Result := True;
    CloseHandle(HFile);
    if (not FExists) then DeleteFile(PAnsiChar(FileName));
  end;
end;

function IsReadableFile(const FileName: AnsiString): Boolean;
var
  HFile: THandle;
begin
  Result := False;

  HFile := CreateFileA(PAnsiChar(FileName), GENERIC_READ,
    FILE_SHARE_READ or FILE_SHARE_WRITE, nil,
    OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  if (HFile <> INVALID_HANDLE_VALUE) then
  begin
    Result := True;
    CloseHandle(HFile);
  end;
end;

function GetWorkingFile(var FileName: AnsiString; ProjectDir, ReadOnly: Boolean): Boolean;
var
  NewFile, NewDir: AnsiString;

  function IsFileOK(const FileName: AnsiString; ReadOnly: Boolean): Boolean;
  begin
    if (not ReadOnly) then Result := IsWritableFile(FileName)
    else Result := IsReadableFile(FileName);
  end;

begin
  Result := True;

  FileName := ExpandEnvVars(FileName);
  if (IsFileOK(FileName, ReadOnly)) then Exit;

  Result := False;
  NewDir := GetEurekaLogDir;
  if (not CheckDirectoryExists(NewDir)) and (not CreateDir(NewDir)) then Exit;

  if (ProjectDir) then
  begin
    NewDir := (NewDir + '\' + ChangeFileExt(ExtractFileName(Real_GetMainModuleFileName), ''));
    if (not CheckDirectoryExists(NewDir)) and (not CreateDir(NewDir)) then Exit;
  end;

  NewFile := (NewDir + '\' + ExtractFileName(FileName));
  if (not IsFileOK(NewFile, ReadOnly)) then Exit;
  FileName := NewFile;
  Result := True;
end;

function GetWorkingDir(var DirName: AnsiString; ProjectDir, ReadOnly: Boolean): Boolean;
var
  FileName: AnsiString;
begin
  // "GetWorkingFile" works only with files (not dir)...
  FileName := (IncludeLastBackslash(DirName) + 'X');
  Result := GetWorkingFile(FileName, ProjectDir, ReadOnly);

  if (Result) then
  begin
    Delete(FileName, Length(FileName), 1); // Removed "X" AnsiChar.
    DirName := FileName;
  end;
end;

{ TEurekaExceptionsFilters }

function TEurekaExceptionsFilters.Add(Item: Pointer): Integer;
begin
  Result := inherited Add(Item);
  FOwner.SaveToSharedData;
end;

procedure TEurekaExceptionsFilters.Assign(const Source: TEurekaExceptionsFilters);
var
  n: Integer;
  Filter: PEurekaExceptionFilter;
begin
  Clear;
  for n := 0 to (Source.Count - 1) do
  begin
    New(Filter);
    Filter^.Active := Source[n]^.Active;
    Filter^.ExceptionClassName := Source[n]^.ExceptionClassName;
    Filter^.ExceptionMessage := Source[n]^.ExceptionMessage;
    Filter^.ExceptionType := Source[n]^.ExceptionType;
    Filter^.DialogType := Source[n]^.DialogType;
    Filter^.HandlerType := Source[n]^.HandlerType;
    Filter^.ActionType := Source[n]^.ActionType;
    Add(Filter);
  end;
end;

procedure TEurekaExceptionsFilters.Clear;
var
  i: integer;
begin
  for i := 0 to Count - 1 do Delete(0);
  inherited;
  FOwner.SaveToSharedData;
end;

constructor TEurekaExceptionsFilters.Create(const Owner: TEurekaModuleOptions);
begin
  FOwner := Owner;
  inherited Create;
end;

procedure TEurekaExceptionsFilters.Delete(Index: Integer);
begin
  Dispose(Items[Index]);
  inherited;
  FOwner.SaveToSharedData;
end;

destructor TEurekaExceptionsFilters.Destroy;
begin
  Clear;
  inherited;
end;

function TEurekaExceptionsFilters.GetItem(Index: Integer): PEurekaExceptionFilter;
begin
  Result := PEurekaExceptionFilter(TList(Self).Items[Index]);
end;

procedure TEurekaExceptionsFilters.Insert(Index: Integer; Item: Pointer);
begin
  inherited;
  FOwner.SaveToSharedData;
end;

{ TEurekaModuleOptions }

constructor TEurekaModuleOptions.Create(AModuleName: AnsiString);
begin
{$IFDEF GENERATE_ACTIVEX}
  inherited Create(nil);
{$ELSE}
  inherited Create;
{$ENDIF}
  FModuleName := AModuleName;
  if (AModuleName <> '') then
    FModuleHandle := GetModuleHandleA(PAnsiChar(AModuleName))
  else
    FModuleHandle := 0;
  FExceptionsFilters := TEurekaExceptionsFilters.Create(Self);
  SetToDefaultOptions;
  FSharedData := 0;
end;

destructor TEurekaModuleOptions.Destroy;
begin
  DisableSharedDataWrite;
  FExceptionsFilters.Free;
  inherited;
end;

procedure TEurekaModuleOptions.Assign(Source: TEurekaModuleOptions);
var
  i: TMessageType;
begin
  if (Source <> nil) then
  begin
    if (Source <> Self) then
    begin
      DisableSharedDataWrite;
      try
        ExceptionsFilters.Assign(Source.FExceptionsFilters);
        for i := low(TMessageType) to high(TMessageType) do
          FCustomizedTexts[i] := Source.FCustomizedTexts[i];
        TextsCollection := Source.FTextsCollection;
        ActivateLog := Source.FActivateLog;
        SaveLogFile := Source.FSaveLogFile;
        FreezeActivate := Source.FFreezeActivate;
        FreezeTimeout := Source.FFreezeTimeout;
        SMTPFrom := Source.FSMTPFrom;
        SMTPHost := Source.FSMTPHost;
        SMTPPort := Source.FSMTPPort;
        SMTPUserID := Source.FSMTPUserID;
        SMTPPassword := Source.FSMTPPassword;
        ForegroundTab := Source.FForegroundTab;
        ActivateHandle := Source.FActivateHandle;
        AppendLogs := Source.FAppendLogs;
        TerminateBtnOperation := Source.FTerminateBtnOperation;
        LogOptions := Source.FLogOptions;
        ErrorsNumberToSave := Source.FErrorsNumberToSave;
        ErrorsNumberToShowTerminateBtn := Source.FErrorsNumberToShowTerminateBtn;
        OutputPath := Source.FOutputPath;
        EMailAddresses := Source.FEMailAddresses;
        EMailSubject := Source.FEMailSubject;
        EMailMessage := Source.FEMailMessage;
        EMailSendMode := Source.FEMailSendMode;
        ShowOptions := Source.FShowOptions;

        WebSendMode := Source.WebSendMode;
        WebURL := Source.WebURL;
        WebUserID := Source.WebUserID;
        WebPassword := Source.WebPassword;
        WebPort := Source.WebPort;
        CommonSendOptions := Source.CommonSendOptions;
        AttachedFiles := Source.AttachedFiles;

        ExceptionDialogOptions := Source.ExceptionDialogOptions;
        AutoCloseDialogSecs := Source.AutoCloseDialogSecs;
        SupportURL := Source.SupportURL;
        HTMLLayout := Source.HTMLLayout;

        CallStackOptions := Source.CallStackOptions;
        BehaviourOptions := Source.BehaviourOptions;
        AutoCrashOperation := Source.AutoCrashOperation;
        AutoCrashNumber := Source.AutoCrashNumber;
        AutoCrashMinutes := Source.AutoCrashMinutes;

        ProxyURL := Source.ProxyURL;
        ProxyUserID := Source.ProxyUserID;
        ProxyPassword := Source.ProxyPassword;
        ProxyPort := Source.ProxyPort;
        TrakerUserID := Source.TrakerUserID;
        TrakerPassword := Source.TrakerPassword;
        TrakerAssignTo := Source.TrakerAssignTo;
        TrakerProject := Source.TrakerProject;
        TrakerCategory := Source.TrakerCategory;
        TrakerTrialID := Source.TrakerTrialID;
        ZipPassword := Source.ZipPassword;
        PreBuildEvent := Source.PreBuildEvent;
        PostSuccessfulBuildEvent := Source.PostSuccessfulBuildEvent;
        PostFailureBuildEvent := Source.PostFailureBuildEvent;
        CompiledFileOptions := Source.CompiledFileOptions;
        ExceptionDialogType := Source.ExceptionDialogType;
        FLeaksOptions := Source.FLeaksOptions;
        FReproduceText := Source.FReproduceText;

      finally
        EnableSharedDataWrite;
        SaveToSharedData;
      end;
    end;
  end
  else
    raise
      EConvertError.Create('Impossible to assign nil as TEurekaModuleOptions.');
end;

function TEurekaModuleOptions.GetCustomizedTexts(Index: TMessageType): AnsiString;
begin
  Result := FCustomizedTexts[Index];
end;

function TEurekaModuleOptions.GetCustomizedExpandedTexts(Index: TMessageType): AnsiString;
begin
  Result := ExpandEnvVars(FCustomizedTexts[Index]);
end;

procedure TEurekaModuleOptions.SaveToFile(const FileName: AnsiString);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TEurekaModuleOptions.SaveToStream(Stream: TStream);
var
  d, i: integer;
  t: TMessageType;

  procedure WriteString(St: TStream; s: AnsiString);
  var
    i: integer;
  begin
    // If "s" is a single line, then delete the last #13#10 chars...
    if (length(s) > 1) and (pos(#13#10, s) = length(s) - 1) then
      s := copy(s, 1, length(s) - 2);

    // $62 increase the compression rate (~2.5%)
    for i := 1 to length(s) do
      s[i] := AnsiChar(Integer(s[i]) xor $62);

    i := length(s);
    St.write(i, 4);
    if (i > 0) then
      St.write(s[1], i);
  end;

begin
  with Stream do
  begin
    write(FActivateLog, 1);
    write(FActivateHandle, 1);
    write(FLogOptions, 1);
    write(FAppendLogs, 1);
    write(FSaveLogFile, 1);
    write(FForegroundTab, 1);
    write(FFreezeActivate, 1);
    write(FFreezeTimeout, 4);
    WriteString(Stream, FSMTPFrom);
    WriteString(Stream, FSMTPHost);
    write(FSMTPPort, 2);
    WriteString(Stream, FSMTPUserID);
    WriteString(Stream, FSMTPPassword);
    write(FTerminateBtnOperation, 1);
    write(FErrorsNumberToSave, 4);
    write(FErrorsNumberToShowTerminateBtn, 4);
    WriteString(Stream, FEMailAddresses);
    WriteString(Stream, FEMailSubject);
    write(FEMailSendMode, 1);
    write(FShowOptions, 6);
    WriteString(Stream, FOutputPath);

    write(FWebSendMode, 1);
    WriteString(Stream, FWebURL);
    WriteString(Stream, FWebUserID);
    WriteString(Stream, FWebPassword);
    write(FWebPort, 4);
    WriteString(Stream, FAttachedFiles);
    write(FCommonSendOptions, 2);

    write(FExceptionDialogOptions, 2); // Size 1 -> 2 in EurekaLog 6.0
    write(FAutoCloseDialogSecs, 4);
    WriteString(Stream, FSupportURL);
    WriteString(Stream, FHTMLLayout);

    write(FCallStackOptions, 1);
    write(FBehaviourOptions, 2); // Size 1 -> 2 in EurekaLog 6.0
    write(FLeaksOptions, 1);
    write(FAutoCrashOperation, 1);
    write(FAutoCrashNumber, 4);
    write(FAutoCrashMinutes, 4);
    write(FCompiledFileOptions, 1);
    write(FExceptionDialogType, 1);
    WriteString(Stream, FProxyURL);
    WriteString(Stream, FProxyUserID);
    WriteString(Stream, FProxyPassword);
    write(FProxyPort, 2);
    WriteString(Stream, FTrakerUserID);
    WriteString(Stream, FTrakerPassword);
    WriteString(Stream, FTrakerAssignTo);
    WriteString(Stream, FTrakerProject);
    WriteString(Stream, FTrakerCategory);
    WriteString(Stream, FTrakerTrialID);
    WriteString(Stream, FZipPassword);

    d := FExceptionsFilters.Count;
    write(d, 4);
    for i := 0 to d - 1 do
    begin
      Write(FExceptionsFilters[i]^.Active, 1);
      WriteString(Stream, FExceptionsFilters[i]^.ExceptionClassName);
      WriteString(Stream, FExceptionsFilters[i]^.ExceptionMessage);
      Write(FExceptionsFilters[i]^.ExceptionType, 1);
      Write(FExceptionsFilters[i]^.DialogType, 1);
      Write(FExceptionsFilters[i]^.HandlerType, 1);
      Write(FExceptionsFilters[i]^.ActionType, 1);
    end;
    WriteString(Stream, FEMailMessage);
    for t := low(TMessageType) to high(TMessageType) do
      WriteString(Stream, FCustomizedTexts[t]);
    WriteString(Stream, FTextsCollection);
  end;
end;

procedure ReadRawStrings(const Cnf: AnsiString; Section, CountName, Prefix, Default: AnsiString;
  var Value: AnsiString);
var
  I, C: Integer;
  Tmp: TStringList;
  s: AnsiString;
begin
  Tmp := TStringList.Create;
  C := StrToIntDef(ReadString(Cnf, Section, CountName, '0'), 0);
  if (C > 0) then
    for I := 0 to (C - 1) do
    begin
      s := ReadString(Cnf, Section, Prefix + IntToStr(I), Default);
      if (Length(s) > 1) and (s[1] = '"') and (s[Length(s)] = '"') then
        s := Copy(s, 2, Length(s) - 2);
      Tmp.Add(s);
    end
  else
    Tmp.Add(Default);
  Value := Tmp.Text;
  if (Length(Value) > 1) and (Copy(Value, length(Value) - 1, 2) = #13#10) then
    Delete(Value, Length(Value) - 1, 2);
  Tmp.Free;
end;

procedure WriteRawStrings(Cnf: AnsiString; Section, CountName, Prefix: AnsiString; Value: AnsiString);
var
  I: Integer;
  Tmp: TStringList;
begin
  Tmp := TStringList.Create;
  Tmp.Text := Value;
  WriteString(Cnf, Section, CountName, IntToStr(Tmp.Count));
  for I := 0 to Tmp.Count - 1 do
    WriteString(Cnf, Section, Prefix + IntToStr(I), '"' + Tmp[I] + '"');
  Tmp.Free;
end;

procedure TEurekaModuleOptions.LoadCustomizedTextsFromFile(const FileName: AnsiString);
var
  t: TMessageType;
  EnumName: AnsiString;
begin
  for t := low(TMessageType) to high(TMessageType) do
  begin
    EnumName := GetEnumName(TypeInfo(TMessageType), Ord(t));
    ReadRawStrings(FileName, EurekaLogSection, 'Count ' + EnumName, EnumName,
      CustomizedTexts[t], FCustomizedTexts[t]);
  end;
  FTextsCollection := ChangeFileExt(FileName, '');
end;

procedure TEurekaModuleOptions.LoadFromFile(const FileName: AnsiString);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TEurekaModuleOptions.LoadFromStream(Stream: TStream);
type
  TSetArray = array[0..5] of Byte;
var
  d, i: integer;
  t: TMessageType;
  s: AnsiString;
  Filter: PEurekaExceptionFilter;
  tmp: Byte;
  BoolTmp: Boolean;
  StrTmp, FreezeMessage: AnsiString;

  function BinToStr(bin: TSetArray): AnsiString;
  var
    n, b: DWord;
  begin
    Result := '';
    b := 1;
    for n := 0 to (SizeOf(bin) * 8 - 1) do
    begin
      Result := Result + IntToStr(Integer(bin[n div 8] and b <> 0));
      b := (b shl 1);
      if (b = 256) then b := 1;
    end;
  end;

  function StrToBin(const st: AnsiString): TSetArray;
  var
    n, b, idx: DWord;
  begin
    FillChar(Result, SizeOf(Result), #0);
    b := 1;
    for n := 1 to (SizeOf(TSetArray) * 8) do
    begin
      idx := ((n - 1) div 8);
      Result[idx] := (Result[idx] or (Byte(StrToInt(st[n])) * b));
      b := (b shl 1);
      if (b = 256) then b := 1;
    end;
  end;

  function ReadString(St: TStream): AnsiString;
  var
    i: integer;
  begin
    St.read(i, 4);
    SetLength(Result, i);
    if (i > 0) then
      St.read(Result[1], i);

    // $62 increase the compression rate (~2.5%)
    for i := 1 to length(Result) do
      Result[i] := AnsiChar(Integer(Result[i]) xor $62);
  end;

begin
  FreezeMessage := '';

  DisableSharedDataWrite;
  try
    with Stream do
    begin
      read(FActivateLog, 1);
      read(FActivateHandle, 1);
      read(FLogOptions, 1);

      if (LastEurekaVersion < 500) then
      begin
        read(BoolTmp, 1);
        if (LastEurekaVersion < 450) then BoolTmp := not BoolTmp;
        if (not BoolTmp) then ExceptionDialogType := edtNone;
      end;

      read(FAppendLogs, 1);

      // From EurekaLog 4.5.0 to <5.0.0
      if (LastEurekaVersion >= 450) and (LastEurekaVersion < 500) then
      begin
        read(BoolTmp, 1);
        if (BoolTmp) then CommonSendOptions := CommonSendOptions + [sndSendEntireLog]
        else CommonSendOptions := CommonSendOptions - [sndSendEntireLog];
        read(BoolTmp, 1);
        if (BoolTmp) then CommonSendOptions := CommonSendOptions + [sndSendScreenshot]
        else CommonSendOptions := CommonSendOptions - [sndSendScreenshot];
        read(BoolTmp, 1);
        if (BoolTmp) then CommonSendOptions := CommonSendOptions + [sndShowSendDialog]
        else CommonSendOptions := CommonSendOptions - [sndShowSendDialog];
      end;

      // From EurekaLog 4.0.1
      if (LastEurekaVersion >= 401) then
      begin
        read(FSaveLogFile, 1);
        read(FForegroundTab, 1);
        if (LastEurekaVersion < 6000) then
        begin
          if (FForegroundTab = ftProcesses) then FForegroundTab := ftCPU;
        end;
      end;

      // From EurekaLog 4.0.3 to <5.0.0
      if (LastEurekaVersion >= 403) and (LastEurekaVersion < 500) then
      begin
        read(BoolTmp, 1);
        if (BoolTmp) then ExceptionDialogOptions := ExceptionDialogOptions + [edoUseEurekaLogLookAndFeel]
        else ExceptionDialogOptions := ExceptionDialogOptions - [edoUseEurekaLogLookAndFeel];
      end;

      // From EurekaLog 4.2
      if (LastEurekaVersion >= 420) then
      begin
        read(FFreezeActivate, 1);
        read(FFreezeTimeout, 4);
        if (LastEurekaVersion < 422) then
          FFreezeTimeout := FFreezeTimeout div 1000;
        if (LastEurekaVersion < 6000) then
          FreezeMessage := ReadString(Stream);
        // From EurekaLog 4.5.0
        if (LastEurekaVersion >= 450) then FSMTPFrom := ReadString(Stream);
        FSMTPHost := ReadString(Stream);
      end;

      // From EurekaLog 4.5.0
      if (LastEurekaVersion >= 450) then read(FSMTPPort, 2);

      // From EurekaLog 4.2.1
      if (LastEurekaVersion >= 421) then
      begin
        FSMTPUserID := ReadString(Stream);
        FSMTPPassword := ReadString(Stream);
        read(FTerminateBtnOperation, 1);
      end;

      if (LastEurekaVersion < 6000) then
      begin
        read(BoolTmp, 1);
        if (not BoolTmp) then TerminateBtnOperation := tbNone;
      end;

      read(FErrorsNumberToSave, 4);
      read(FErrorsNumberToShowTerminateBtn, 4);
      FEMailAddresses := ReadString(Stream);
      FEMailSubject := ReadString(Stream);
      read(FEMailSendMode, 1);
      if (LastEurekaVersion < 450) and (FEMailSendMode <> esmNoSend) then
      begin
        if (FSMTPHost <> '') then
          FEMailSendMode := esmSMTPClient
        else
          FEMailSendMode := esmEmailClient;
      end;

      FShowOptions := [];
      if (LastEurekaVersion < 500) then
      begin
        read(FShowOptions, 4);
        StrTmp := BinToStr(TSetArray(FShowOptions));
        Insert('11', StrTmp, 5);  //  Insert: AppCompilationDate, AppUpTime
        Insert('1', StrTmp, 10); // Insert: ExcModuleVersion
        Insert('1111', StrTmp, 13); // Insert: ExcID, ExcCount, ExcStatus, ExcNote
        Insert('1111', StrTmp, 23); // Insert: CmpUserName, CmpUserEmail, CmpUserPrivileges, CmpCompanyName
        Insert('111111', StrTmp, 31); // Insert: soCmpSysUpTime, soCmpProcessor, soCmpDisplayMode, soCmpDisplayDPI, soCmpVideoCard, soCmpPrinter
        Insert('1111111', StrTmp, 42); // Insert: soNetIP, soNetSubmask, soNetGateway, soNetDNS1, soNetDNS2, soNetDHCP, soCustomData
        FShowOptions := TShowOptions(StrToBin(StrTmp));
      end
      else
        if (LastEurekaVersion < 6000) then
        begin
          read(FShowOptions, 5);
          StrTmp := BinToStr(TSetArray(FShowOptions));
          Insert('1', StrTmp, 6);  //  Insert: AppUpTime
          Insert('1', StrTmp, 10); // Insert: ExcModuleVersion
          Insert('1111', StrTmp, 13); // Insert: ExcID, ExcCount, ExcStatus, ExcNote
          Insert('1111', StrTmp, 23); // Insert: CmpUserName, CmpUserEmail, CmpUserPrivileges, CmpCompanyName
          Insert('111', StrTmp, 34); // Insert: CmpDisplayDPI, CmpVideoCard, CmpPrinter
          Insert('1', StrTmp, 41); // Insert: OSCharset
          Insert('1', StrTmp, 48); // Insert: CustomData
          FShowOptions := TShowOptions(StrToBin(StrTmp));
        end
        else read(FShowOptions, 6);

      if (LastEurekaVersion < 450) then read(tmp, 1); // Old EmailSendConfirm prop.

      FOutputPath := ReadString(Stream);

      if (LastEurekaVersion >= 500) then
      begin
        read(FWebSendMode, 1);
        FWebURL := ReadString(Stream);
        FWebUserID := ReadString(Stream);
        FWebPassword := ReadString(Stream);
        read(FWebPort, 4);
        FAttachedFiles := ReadString(Stream);
        read(FCommonSendOptions, 2);
        if (LastEurekaVersion < 6000) then
          FCommonSendOptions := (FCommonSendOptions - [sndAddComputerNameInFileName]);

        if (LastEurekaVersion >= 6000) then read(FExceptionDialogOptions, 2)
        else
        begin
          FExceptionDialogOptions := [];
          read(FExceptionDialogOptions, 1);
        end;
        read(FAutoCloseDialogSecs, 4);
        FSupportURL := ReadString(Stream);
        FHTMLLayout := ReadString(Stream);

        read(FCallStackOptions, 1);
        if (LastEurekaVersion < 6000) then
          FCallStackOptions := (FCallStackOptions + [csoDoNotStoreProcNames]);

        if (LastEurekaVersion >= 6000) then
        begin
          read(FBehaviourOptions, 2);
          read(FLeaksOptions, 1);
        end
        else
        begin
          FBehaviourOptions := [];
          read(FBehaviourOptions, 1);
        end;
        read(FAutoCrashOperation, 1);
        read(FAutoCrashNumber, 4);
        read(FAutoCrashMinutes, 4);
        if (LastEurekaVersion >= 6000) then
        begin
          read(FCompiledFileOptions, 1);
          read(FExceptionDialogType, 1);
          FProxyURL := ReadString(Stream);
          FProxyUserID := ReadString(Stream);
          FProxyPassword := ReadString(Stream);
          read(FProxyPort, 2);
          FTrakerUserID := ReadString(Stream);
          FTrakerPassword := ReadString(Stream);
          FTrakerAssignTo := ReadString(Stream);
          FTrakerProject := ReadString(Stream);
          FTrakerCategory := ReadString(Stream);
          FTrakerTrialID := ReadString(Stream);
          FZipPassword := ReadString(Stream);
        end;
      end;

      FExceptionsFilters.Clear;
      read(d, 4);
      for i := 0 to d - 1 do
      begin
        New(Filter);
        if (LastEurekaVersion >= 6000) then Read(Filter^.Active, 1)
        else Filter^.Active := True;

        s := ReadString(Stream);
        Filter^.ExceptionClassName := s;
        s := ReadString(Stream);
        Filter^.ExceptionMessage := s;
        if (LastEurekaVersion >= 6000) then
        begin
          Read(Filter^.ExceptionType, 1);
          Read(Filter^.DialogType, 1);
          Read(Filter^.HandlerType, 1);
          Read(Filter^.ActionType, 1);
        end
        else
        begin
          if (Filter.ExceptionMessage = '') then
          begin
            Filter^.ExceptionType := fetUnhandled;
            Filter^.DialogType := fdtNone;
            Filter^.HandlerType := fhtNone;
            Filter^.ActionType := fatNone;
          end
          else
          begin
            Filter^.ExceptionType := fetUnhandled;
            Filter^.DialogType := fdtMessageBox;
            Filter^.HandlerType := fhtNone;
            Filter^.ActionType := fatNone;
          end;
        end;
        FExceptionsFilters.Add(Filter);
      end;

      FEMailMessage := ReadString(Stream);
      for t := low(TMessageType) to high(TMessageType) do
      begin
        // Convert old mtLog_CmpUser in the new mtLog_UserName...
        if ((Integer(t) in [68] {moved option}) and (LastEurekaVersion < 6000)) then
          s := ReadString(Stream);

        if not (((t = mtDialog_DetailsButtonCaption) and (LastEurekaVersion < 420)) or
          ((t = mtDialog_RestartButtonCaption) and (LastEurekaVersion < 421)) or
          ((t in [mtDialog_ModulesCaption, mtDialog_ModulesHeader,
          mtDialog_CPUCaption, mtDialog_CPUHeader, mtDialog_SendMessage,
            mtDialog_ScreenshotMessage, mtDialog_CopyMessage, mtLog_AppParameters,
            mtLog_CmpTotalMemory, mtLog_OSUpdate]) and (LastEurekaVersion < 450)) or
            ((t >= mtSendDialog_Caption) and (LastEurekaVersion < 450)) or
          ((Integer(t) in [47, 48] {removed opt}) and (LastEurekaVersion < 450)) or
          ((t in [mtDialog_SupportMessage, mtLog_AppCompilationDate, mtLog_CmpSystemUpTime,
          mtLog_CmpProcessor, mtLog_CmpDisplayMode, mtLog_NetHeader..mtLog_NetDHCP,
          mtLog_CustInfoHeader, mtModules_LastModified, mtSend_SuccessMsg,
          mtSend_FailureMsg, mtCallStack_MainThread..mtCallStack_ThreadClass,
          mtLog_CmpDisplayDPI..mtLog_CmpPrinter]) and (LastEurekaVersion < 500)) or
          ((Integer(t) in [41] {removed opt}) and (LastEurekaVersion < 6000)) or
          ((t in [mtDialog_OKButtonCaption, mtDialog_TerminateButtonCaption]) and
          (LastEurekaVersion >= 500) and (LastEurekaVersion < 6000)) or
          ((t in [mtErrorMsgCaption, mtDialog_CustomButtonCaption, mtSendDialog_Login,
          mtSendDialog_Sent..mtSendDialog_Disconnected,
          mtMSDialog_ErrorMsgCaption..mtMSDialog_NoSendButtonCaption,
          mtSend_BugClosedMsg..mtSend_InvalidModifyMsg, mtFileCrackedMsg,
          mtCallStack_LeakCaption..mtCallStack_LeakCount,
          mtException_LeakMultiFree..mtException_AntiFreeze, mtInvalidEmailMsg,
          mtLog_AppUpTime, mtLog_ExcID..mtLog_ExcNote,
          mtLog_UserHeader..mtLog_UserPrivileges, mtLog_OSCharset,
          mtLog_UserID..mtLog_UserCompany, mtDialog_ProcessesCaption,
          mtDialog_ProcessesHeader, mtProcesses_ID..mtProcesses_Path,
          mtDialog_AsmCaption, mtDialog_AsmHeader]) and
          (LastEurekaVersion < 6000)))
          then FCustomizedTexts[t] := ReadString(Stream);
      end;
      if (LastEurekaVersion >= 6000) then FTextsCollection := ReadString(Stream);
      if (FreezeMessage <> '') then
        CustomizedTexts[mtException_AntiFreeze] := FreezeMessage;
    end;
  finally
    EnableSharedDataWrite;
    SaveToSharedData;
  end;
end;

// Shared data...
// -----------------------------------------------------------------------------

procedure TEurekaModuleOptions.StoreSharedData;
begin
  // ...
end;

procedure TEurekaModuleOptions.LoadSharedData;
begin
  // ...
end;

procedure TEurekaModuleOptions.DisableSharedDataWrite;
begin
  inc(FSharedData);
end;

procedure TEurekaModuleOptions.EnableSharedDataWrite;
begin
  dec(FSharedData);
end;

procedure TEurekaModuleOptions.SaveCustomizedTextsToFile(const FileName: AnsiString);
var
  t: TMessageType;
begin
  for t := low(TMessageType) to high(TMessageType) do
  begin
    WriteRawStrings(FileName, EurekaLogSection, 'Count ' +
      GetEnumName(TypeInfo(TMessageType), Ord(t)),
      GetEnumName(TypeInfo(TMessageType), Ord(t)), FCustomizedTexts[t]);
  end;
  FTextsCollection := ChangeFileExt(FileName, '');
end;

procedure TEurekaModuleOptions.SaveToSharedData;
begin
  if ((FSharedData <= 0) and (ModuleHandle = HInstance)) then StoreSharedData;
end;

procedure TEurekaModuleOptions.SetToDefaultOptions;
var
  Msg: TMessageType;
begin
  DisableSharedDataWrite;
  try
    for Msg := low(TMessageType) to high(TMessageType) do
      FCustomizedTexts[Msg] := EVals[Msg];
    FTextsCollection := 'English';
    FFreezeActivate := False;
    FFreezeTimeout := 60;
    FSMTPFrom := 'eurekalog@email.com';
    FSMTPHost := '';
    FSMTPPort := 25;
    FSMTPUserID := '';
    FSMTPPassword := '';
    FActivateLog := False; // Set EurekaLog disabled by default on all projects.
    FSaveLogFile := True;
    FForegroundTab := ftGeneral;
    FActivateHandle := True;
    FAppendLogs := False;
    FTerminateBtnOperation := tbRestart;
    FLogOptions := [loSaveModulesAndProcessesSections, loSaveAssemblerAndCPUSections];
    FillChar(FShowOptions, SizeOf(FShowOptions), #255);
    FErrorsNumberToSave := 32;
    FErrorsNumberToShowTerminateBtn := 3;
    FOutputPath := '';
    FEMailAddresses := '';
    FEMailSubject := '';
    FEMailMessage := '';
    FEMailSendMode := esmNoSend;

    FWebSendMode := wsmNoSend;
    FWebURL := '';
    FWebUserID := '';
    FWebPassword := '';
    FWebPort := 0;
    FAttachedFiles := '';
    FCommonSendOptions := [sndShowSendDialog, sndSendScreenshot, sndSendLastHTMLPage];

    FExceptionDialogOptions := [edoShowDetailsButton, edoSendErrorReportChecked,
      edoAttachScreenshotChecked, edoShowCopyToClipOption,
      edoShowSendErrorReportOption, edoShowAttachScreenshotOption];
    FAutoCloseDialogSecs := 0;
    FSupportURL := '';
    FHTMLLayout := '<html>'#13#10'  <head>'#13#10'  </head>'#13#10 +
      '  <body TopMargin=10 LeftMargin=10>'#13#10'    <table width="100%" border="0">'#13#10 +
      '      <tr>'#13#10'        <td nowrap>'#13#10 +
      '          <font face="Lucida Console, Courier" size="2">'#13#10'            <%HTML_TAG%>'#13#10 +
      '          </font>'#13#10'        </td>'#13#10'      </tr>'#13#10'    </table>'#13#10 +
      '  </body>'#13#10'</html>';

    FCallStackOptions := [csoShowDLLs, csoShowBPLs, csoShowBorlandThreads,
      csoShowWindowsThreads];
    FBehaviourOptions := [boCopyLogInCaseOfError, boUseMainModuleOptions,
      boHandleSafeCallExceptions];
    FLeaksOptions := [loGroupsSonLeaks, loHideBorlandLeaks, loHideBorlandLeaks,
      loFreeAllLeaks, loCatchLeaksExceptions];
    FAutoCrashOperation := tbRestart;
    FAutoCrashNumber := 10;
    FAutoCrashMinutes := 1;

    FProxyURL := '';
    FProxyUserID := '';
    FProxyPassword := '';
    FProxyPort := 8080;
    FTrakerUserID := '';
    FTrakerPassword := '';
    FTrakerAssignTo := '';
    FTrakerProject := '';
    FTrakerCategory := '';
    FTrakerTrialID := '';
    FZipPassword := '';
    FPreBuildEvent := '';
    FPostSuccessfulBuildEvent := '';
    FPostFailureBuildEvent := '';
    FCompiledFileOptions := [cfoReduceFileSize];
    FExceptionDialogType := edtMSCLassic;
    FExceptionsFilters.Clear;
    FReproduceText := '';

    FActive := True;
  finally
    EnableSharedDataWrite;
    SaveToSharedData;
  end;
end;

procedure TEurekaModuleOptions.SetTrakerAssignTo(const Value: AnsiString);
begin
  FTrakerAssignTo := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetTrakerCategory(const Value: AnsiString);
begin
  FTrakerCategory := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetTrakerPassword(const Value: AnsiString);
begin
  FTrakerPassword := Value;
  SaveToSharedData;  
end;

procedure TEurekaModuleOptions.SetTrakerProject(const Value: AnsiString);
begin
  FTrakerProject := Value;
  SaveToSharedData;  
end;

procedure TEurekaModuleOptions.SetTrakerTrialID(const Value: AnsiString);
begin
  FTrakerTrialID := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetTrakerUserID(const Value: AnsiString);
begin
  FTrakerUserID := Value;
  SaveToSharedData;  
end;

procedure TEurekaModuleOptions.SetCustomizedTexts(Index: TMessageType; Value: AnsiString);
begin
  FCustomizedTexts[Index] := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetActive(const Value: Boolean);
begin
  FActive := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetFreezeActivate(const Value: Boolean);
begin
  FFreezeActivate := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetErrorsNumberToSave(const Value: Integer);
begin
  if (Value = 0) then
    FErrorsNumberToSave := 1
  else
    FErrorsNumberToSave := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetModuleName(const Value: AnsiString);
begin
  FModuleName := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetModuleHandle(const Value: THandle);
begin
  FModuleHandle := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetActivateHandle(const Value: boolean);
begin
  FActivateHandle := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetActivateLog(const Value: boolean);
begin
  FActivateLog := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetAppendLogs(const Value: boolean);
begin
  FAppendLogs := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetEMailAddresses(const Value: AnsiString);
begin
  FEMailAddresses := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetEMailMessage(const Value: AnsiString);
begin
  FEMailMessage := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetEMailSendMode(const Value: TEmailSendMode);
begin
  FEMailSendMode := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetEMailSubject(const Value: AnsiString);
begin
  FEMailSubject := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetErrorsNumberToShowTerminateBtn(const Value: integer);
begin
  FErrorsNumberToShowTerminateBtn := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetExceptionsFilters(const Value: TEurekaExceptionsFilters);
begin
  FExceptionsFilters := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetForegroundTab(const Value: TForegroundType);
begin
  FForegroundTab := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetFreezeTimeout(const Value: integer);
begin
  FFreezeTimeout := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetLogOptions(const Value: TLogOptions);
begin
  FLogOptions := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetOutputPath(const Value: AnsiString);
begin
  FOutputPath := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetPostFailureBuildEvent(const Value: AnsiString);
begin
  FPostFailureBuildEvent := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetPostSuccessfulBuildEvent(const Value: AnsiString);
begin
  FPostSuccessfulBuildEvent := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetPreBuildEvent(const Value: AnsiString);
begin
  FPreBuildEvent := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetProxyPassword(const Value: AnsiString);
begin
  FProxyPassword := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetProxyPort(const Value: Word);
begin
  FProxyPort := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetProxyURL(const Value: AnsiString);
begin
  FProxyURL := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetProxyUserID(const Value: AnsiString);
begin
  FProxyUserID := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetReproduceText(const Value: AnsiString);
begin
  FReproduceText := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetSaveLogFile(const Value: boolean);
begin
  FSaveLogFile := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetShowOptions(const Value: TShowOptions);
begin
  FShowOptions := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetSMTPFrom(const Value: AnsiString);
begin
  FSMTPFrom := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetSMTPHost(const Value: AnsiString);
begin
  FSMTPHost := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetSMTPPassword(const Value: AnsiString);
begin
  FSMTPPassword := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetSMTPPort(const Value: Word);
begin
  FSMTPPort := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetSMTPUserID(const Value: AnsiString);
begin
  FSMTPUserID := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetTerminateBtnOperation(
  const Value: TTerminateBtnOperation);
begin
  FTerminateBtnOperation := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetTextsCollection(const Value: AnsiString);
begin
  FTextsCollection := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetWebSendMode(const Value: TWebSendMode);
begin
  FWebSendMode := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetWebURL(const Value: AnsiString);
begin
  FWebURL := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetWebPassword(const Value: AnsiString);
begin
  FWebPassword := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetWebPort(const Value: Integer);
begin
  FWebPort := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetWebUserID(const Value: AnsiString);
begin
  FWebUserID := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetZipPassword(const Value: AnsiString);
begin
  FZipPassword := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetCommonSendOptions(const Value: TCommonSendOptions);
begin
  FCommonSendOptions := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetCompiledFileOptions(const Value: TCompiledFileOptions);
begin
  FCompiledFileOptions := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetAttachedFiles(const Value: AnsiString);
begin
  FAttachedFiles := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetExceptionDialogOptions(const Value: TExceptionDialogOptions);
begin
  FExceptionDialogOptions := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetExceptionDialogType(const Value: TExceptionDialogType);
begin
  FExceptionDialogType := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetAutoCloseDialogSecs(
  const Value: Integer);
begin
  FAutoCloseDialogSecs := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetAutoCrashMinutes(const Value: Integer);
begin
  FAutoCrashMinutes := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetAutoCrashNumber(const Value: Integer);
begin
  FAutoCrashNumber := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetAutoCrashOperation(const Value: TTerminateBtnOperation);
begin
  FAutoCrashOperation := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetHTMLLayout(const Value: AnsiString);
begin
  FHTMLLayout := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetSupportURL(const Value: AnsiString);
begin
  FSupportURL := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetBehaviourOptions(const Value: TBehaviourOptions);
begin
  FBehaviourOptions := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetCallStackOptions(const Value: TCallStackOptions);
begin
  FCallStackOptions := Value;
  SaveToSharedData;
end;

// -----------------------------------------------------------------------------

function TEurekaModuleOptions.OutputFile(FileName: AnsiString): AnsiString;
begin
  if (LowerCase(ExtractFileExt(FOutputPath)) = '.elf') then Result := FOutputPath
  else
  begin
    if (FOutputPath <> '') then
      Result := IncludeLastBackslash(FOutputPath)
    else
      Result := IncludeLastBackslash(ExtractFilePath(FileName));

    Result := (Result + ExtractFileName(FileName))
  end;

  ForceDirectoriesEx(ExtractFilePath(Result));
  GetWorkingFile(Result, True, False);
end;

function TEurekaModuleOptions.OutputLogFile(BaseFile: AnsiString): AnsiString;

  function ComputerName: AnsiString;
  const
    NoChars: set of AnsiChar = ['\', '/', '*', '<', '>', '?', '|', ':', '"'];
  var
    Comp: array[0..255] of AnsiChar;
    I: DWord;
  begin
    I := (MAX_COMPUTERNAME_LENGTH + 1);
    GetComputerNameA(Comp, I);
    Result := Comp;
    for I := 1 to Length(Result) do
      if (Result[I] in NoChars) then Result[I] := '_';
  end;

begin
  if (BaseFile = '') then BaseFile := DotNetHostedFile(ModuleName);
  Result := OutputFile(ChangeFileExt(BaseFile, '.elf'));
  if (loAddComputerNameInLogFileName in LogOptions) then
  begin
    Result := (ChangeFileExt(Result, '') + '_' +
      ComputerName + ExtractFileExt(Result));
  end;
end;

procedure SafeExec(Proc: TProc; Section: AnsiString);
var
  Error: AnsiString;
begin
  try
    Proc;
  except
    on Err: TObject do
    begin
      if (Err is EIgnoreException) then raise;

      if (@CriticalError <> nil) then
      begin
        CriticalError(Format('%s (Address: %s)', [Section, IntToHex(DWord(@Proc), 8)]));
        Abort;
      end
      else
      begin
        if (ExceptObject is Exception) then Error := Exception(ExceptObject).Message
        else Error := 'General internal error.';
        raise Exception.CreateFmt('Critical error at: "%s"'#13#10'Error: "%s".', [Section, Error]);
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure Init;
{$IFDEF DUNITPROJECT}
const
  MsgBoxFlags = (MB_YESNO or MB_DEFBUTTON1 or MB_ICONQUESTION or MB_TASKMODAL);
{$ENDIF}
begin
  InternalIntoIDE := CheckIntoIDE;
{$IFDEF DUNITPROJECT}
{$IFDEF Delphi9Down}
  if ((not IntoIDE) and
    (MessageBoxA(0, 'Do you want to load the MemCheck memory leaks detector?',
    'Question.', MsgBoxFlags) = ID_YES)) then MemChk;
{$ELSE}
  if ((not IntoIDE) and
    (MessageBoxA(0, 'Do you want to activate the memory leaks detector?',
    'Question.', MsgBoxFlags) = ID_YES)) then ReportMemoryLeaksOnShutdown := True;
{$ENDIF}
{$ENDIF}
end;

procedure Done;
begin
end;

//------------------------------------------------------------------------------

initialization
  SafeExec(Init, 'ECore.Init');

finalization
  SafeExec(Done, 'ECore.Done');

end.

