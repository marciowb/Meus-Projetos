{***************************************************************************}
{ This source code was generated automatically by                           }
{ Pas file import tool for Scripter Studio (Pro)                            }
{                                                                           }
{ Scripter Studio and Pas file import tool for Scripter Studio              }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{***************************************************************************}
unit ap_IBInstall;

interface

uses
  TypInfo,
  SysUtils,
  Classes,
  IB,
  IBInstallHeader,
  IBIntf,
  IBXConst,
  IBInstall,
  atScript;

{$WARNINGS OFF}

type
  TatIBInstallLibrary = class(TatScripterLibrary)
    procedure __GetEIBInstallInstallError(AMachine: TatVirtualMachine);
    procedure __GetEIBInstallInstallerError(AMachine: TatVirtualMachine);
    procedure __TIBSetupCreate(AMachine: TatVirtualMachine);
    procedure __GetTIBSetupRebootToComplete(AMachine: TatVirtualMachine);
    procedure __GetTIBSetupProgress(AMachine: TatVirtualMachine);
    procedure __GetTIBSetupMsgFilePath(AMachine: TatVirtualMachine);
    procedure __SetTIBSetupMsgFilePath(AMachine: TatVirtualMachine);
    procedure __TIBInstallCreate(AMachine: TatVirtualMachine);
    procedure __TIBInstallDestroy(AMachine: TatVirtualMachine);
    procedure __TIBInstallInstallCheck(AMachine: TatVirtualMachine);
    procedure __TIBInstallInstallExecute(AMachine: TatVirtualMachine);
    procedure __GetTIBInstallUnInstallFile(AMachine: TatVirtualMachine);
    procedure __GetTIBInstallSuggestedDestination(AMachine: TatVirtualMachine);
    procedure __TIBUnInstallUnInstallCheck(AMachine: TatVirtualMachine);
    procedure __TIBUnInstallUnInstallExecute(AMachine: TatVirtualMachine);
    procedure __GetTIBUnInstallUnInstallFile(AMachine: TatVirtualMachine);
    procedure __SetTIBUnInstallUnInstallFile(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  EIBInstallClass = class of EIBInstall;
  EIBInstallErrorClass = class of EIBInstallError;
  EIBInstallerErrorClass = class of EIBInstallerError;
  TInstallOptionsClass = class of TInstallOptions;
  TIBSetupClass = class of TIBSetup;
  TIBInstallClass = class of TIBInstall;
  TIBUnInstallClass = class of TIBUnInstall;

  TatIBInstallDispatcher = class(TatEventDispatcher)
  private
    function __TIBSetupOnStatus( Sender: TObject;  StatusComment: string): TStatusResult;
    function __TIBSetupOnWarning( Sender: TObject;  WarningCode: TIscError;  WarningMessage: string): TWarningResult;
    function __TIBSetupOnError( Sender: TObject;  IscCode: TIscError;  ErrorMessage: string;  ErrorComment: string): TErrorResult;
  end;


implementation



procedure TatIBInstallLibrary.__GetEIBInstallInstallError(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(EIBInstall(CurrentObject).InstallError));
  end;
end;

procedure TatIBInstallLibrary.__GetEIBInstallInstallerError(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(EIBInstall(CurrentObject).InstallerError);
  end;
end;

procedure TatIBInstallLibrary.__TIBSetupCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBSetupClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBInstallLibrary.__GetTIBSetupRebootToComplete(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBSetup(CurrentObject).RebootToComplete);
  end;
end;

procedure TatIBInstallLibrary.__GetTIBSetupProgress(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBSetup(CurrentObject).Progress));
  end;
end;

procedure TatIBInstallLibrary.__GetTIBSetupMsgFilePath(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBSetup(CurrentObject).MsgFilePath);
  end;
end;

procedure TatIBInstallLibrary.__SetTIBSetupMsgFilePath(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBSetup(CurrentObject).MsgFilePath:=GetInputArg(0);
  end;
end;

procedure TatIBInstallLibrary.__TIBInstallCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBInstallClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBInstallLibrary.__TIBInstallDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBInstall(CurrentObject).Destroy;
  end;
end;

procedure TatIBInstallLibrary.__TIBInstallInstallCheck(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBInstall(CurrentObject).InstallCheck;
  end;
end;

procedure TatIBInstallLibrary.__TIBInstallInstallExecute(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBInstall(CurrentObject).InstallExecute;
  end;
end;

procedure TatIBInstallLibrary.__GetTIBInstallUnInstallFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBInstall(CurrentObject).UnInstallFile);
  end;
end;

procedure TatIBInstallLibrary.__GetTIBInstallSuggestedDestination(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBInstall(CurrentObject).SuggestedDestination);
  end;
end;

procedure TatIBInstallLibrary.__TIBUnInstallUnInstallCheck(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBUnInstall(CurrentObject).UnInstallCheck;
  end;
end;

procedure TatIBInstallLibrary.__TIBUnInstallUnInstallExecute(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBUnInstall(CurrentObject).UnInstallExecute;
  end;
end;

procedure TatIBInstallLibrary.__GetTIBUnInstallUnInstallFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBUnInstall(CurrentObject).UnInstallFile);
  end;
end;

procedure TatIBInstallLibrary.__SetTIBUnInstallUnInstallFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBUnInstall(CurrentObject).UnInstallFile:=GetInputArg(0);
  end;
end;

function TatIBInstallDispatcher.__TIBSetupOnStatus( Sender: TObject;  StatusComment: string): TStatusResult;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TIBSetupOnStatus(BeforeCall)(Sender,StatusComment);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,StatusComment]);
    if AssignedMethod(AfterCall) then
      TIBSetupOnStatus(AfterCall)(Sender,StatusComment);
  end;
end;

function TatIBInstallDispatcher.__TIBSetupOnWarning( Sender: TObject;  WarningCode: TIscError;  WarningMessage: string): TWarningResult;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TIBSetupOnWarning(BeforeCall)(Sender,WarningCode,WarningMessage);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,WarningCode,WarningMessage]);
    if AssignedMethod(AfterCall) then
      TIBSetupOnWarning(AfterCall)(Sender,WarningCode,WarningMessage);
  end;
end;

function TatIBInstallDispatcher.__TIBSetupOnError( Sender: TObject;  IscCode: TIscError;  ErrorMessage: string;  ErrorComment: string): TErrorResult;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TIBSetupOnError(BeforeCall)(Sender,IscCode,ErrorMessage,ErrorComment);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,IscCode,ErrorMessage,ErrorComment]);
    if AssignedMethod(AfterCall) then
      TIBSetupOnError(AfterCall)(Sender,IscCode,ErrorMessage,ErrorComment);
  end;
end;

procedure TatIBInstallLibrary.Init;
begin
  With Scripter.DefineClass(EIBInstall) do
  begin
    DefineProp('InstallError',tkInteger,__GetEIBInstallInstallError,nil,nil,false,0);
    DefineProp('InstallerError',tkEnumeration,__GetEIBInstallInstallerError,nil,nil,false,0);
  end;
  With Scripter.DefineClass(EIBInstallError) do
  begin
  end;
  With Scripter.DefineClass(EIBInstallerError) do
  begin
  end;
  With Scripter.DefineClass(TInstallOptions) do
  begin
  end;
  With Scripter.DefineClass(TIBSetup) do
  begin
    DefineMethod('Create',1,tkClass,TIBSetup,__TIBSetupCreate,true,0);
    DefineProp('RebootToComplete',tkVariant,__GetTIBSetupRebootToComplete,nil,nil,false,0);
    DefineProp('Progress',tkInteger,__GetTIBSetupProgress,nil,nil,false,0);
    DefineProp('MsgFilePath',tkVariant,__GetTIBSetupMsgFilePath,__SetTIBSetupMsgFilePath,nil,false,0);
  end;
  With Scripter.DefineClass(TIBInstall) do
  begin
    DefineMethod('Create',1,tkClass,TIBInstall,__TIBInstallCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TIBInstallDestroy,false,0);
    DefineMethod('InstallCheck',0,tkNone,nil,__TIBInstallInstallCheck,false,0);
    DefineMethod('InstallExecute',0,tkNone,nil,__TIBInstallInstallExecute,false,0);
    DefineProp('UnInstallFile',tkVariant,__GetTIBInstallUnInstallFile,nil,nil,false,0);
    DefineProp('SuggestedDestination',tkVariant,__GetTIBInstallSuggestedDestination,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TIBUnInstall) do
  begin
    DefineMethod('UnInstallCheck',0,tkNone,nil,__TIBUnInstallUnInstallCheck,false,0);
    DefineMethod('UnInstallExecute',0,tkNone,nil,__TIBUnInstallUnInstallExecute,false,0);
    DefineProp('UnInstallFile',tkVariant,__GetTIBUnInstallUnInstallFile,__SetTIBUnInstallUnInstallFile,nil,false,0);
  end;
  DefineEventAdapter(TypeInfo(TIBSetupOnStatus), TatIBInstallDispatcher, @TatIBInstallDispatcher.__TIBSetupOnStatus);
  DefineEventAdapter(TypeInfo(TIBSetupOnWarning), TatIBInstallDispatcher, @TatIBInstallDispatcher.__TIBSetupOnWarning);
  DefineEventAdapter(TypeInfo(TIBSetupOnError), TatIBInstallDispatcher, @TatIBInstallDispatcher.__TIBSetupOnError);
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('ieSuccess',ieSuccess);
    AddConstant('ieDelphiException',ieDelphiException);
    AddConstant('ieNoOptionsSet',ieNoOptionsSet);
    AddConstant('ieNoDestinationDirectory',ieNoDestinationDirectory);
    AddConstant('ieNosourceDirectory',ieNosourceDirectory);
    AddConstant('ieNoUninstallFile',ieNoUninstallFile);
    AddConstant('ieOptionNeedsClient',ieOptionNeedsClient);
    AddConstant('ieOptionNeedsServer',ieOptionNeedsServer);
    AddConstant('ieInvalidOption',ieInvalidOption);
    AddConstant('ieInvalidOnErrorResult',ieInvalidOnErrorResult);
    AddConstant('ieInvalidOnStatusResult',ieInvalidOnStatusResult);
    AddConstant('moServer',moServer);
    AddConstant('moClient',moClient);
    AddConstant('moConServer',moConServer);
    AddConstant('moGuiTools',moGuiTools);
    AddConstant('moDocumentation',moDocumentation);
    AddConstant('moDevelopment',moDevelopment);
    AddConstant('exDB',exDB);
    AddConstant('exAPI',exAPI);
    AddConstant('cmDBMgmt',cmDBMgmt);
    AddConstant('cmDBQuery',cmDBQuery);
    AddConstant('cmUsrMgmt',cmUsrMgmt);
    AddConstant('cnODBC',cnODBC);
    AddConstant('cnOLEDB',cnOLEDB);
    AddConstant('cnJDBC',cnJDBC);
    AddConstant('erAbort',erAbort);
    AddConstant('erContinue',erContinue);
    AddConstant('erRetry',erRetry);
    AddConstant('srAbort',srAbort);
    AddConstant('srContinue',srContinue);
    AddConstant('wrAbort',wrAbort);
    AddConstant('wrContinue',wrContinue);
  end;
end;

class function TatIBInstallLibrary.LibraryName: string;
begin
  result := 'IBInstall';
end;

initialization
  RegisterScripterLibrary(TatIBInstallLibrary, True);

{$WARNINGS ON}

end.

