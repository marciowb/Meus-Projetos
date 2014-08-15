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
unit ap_SvcMgr;

interface

uses
  Windows,
  Messages,
  WinSvc,
  SysUtils,
  Classes,
  SvcMgr,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatSvcMgrLibrary = class(TatScripterLibrary)
    procedure __TEventLoggerCreate(AMachine: TatVirtualMachine);
    procedure __TEventLoggerDestroy(AMachine: TatVirtualMachine);
    procedure __TEventLoggerLogMessage(AMachine: TatVirtualMachine);
    procedure __TDependenciesCreate(AMachine: TatVirtualMachine);
    procedure __GetTDependenciesItems(AMachine: TatVirtualMachine);
    procedure __SetTDependenciesItems(AMachine: TatVirtualMachine);
    procedure __TServiceThreadCreate(AMachine: TatVirtualMachine);
    procedure __TServiceThreadProcessRequests(AMachine: TatVirtualMachine);
    procedure __TServiceCreateNew(AMachine: TatVirtualMachine);
    procedure __TServiceDestroy(AMachine: TatVirtualMachine);
    procedure __TServiceReportStatus(AMachine: TatVirtualMachine);
    procedure __TServiceLogMessage(AMachine: TatVirtualMachine);
    procedure __GetTServiceErrCode(AMachine: TatVirtualMachine);
    procedure __SetTServiceErrCode(AMachine: TatVirtualMachine);
    procedure __GetTServiceParamCount(AMachine: TatVirtualMachine);
    procedure __GetTServiceParam(AMachine: TatVirtualMachine);
    procedure __GetTServiceServiceThread(AMachine: TatVirtualMachine);
    procedure __GetTServiceStatus(AMachine: TatVirtualMachine);
    procedure __SetTServiceStatus(AMachine: TatVirtualMachine);
    procedure __GetTServiceTerminated(AMachine: TatVirtualMachine);
    procedure __GetTServiceWin32ErrCode(AMachine: TatVirtualMachine);
    procedure __SetTServiceWin32ErrCode(AMachine: TatVirtualMachine);
    procedure __TServiceApplicationCreate(AMachine: TatVirtualMachine);
    procedure __TServiceApplicationDestroy(AMachine: TatVirtualMachine);
    procedure __TServiceApplicationInitialize(AMachine: TatVirtualMachine);
    procedure __TServiceApplicationInstalling(AMachine: TatVirtualMachine);
    procedure __TServiceApplicationRun(AMachine: TatVirtualMachine);
    procedure __GetTServiceApplicationDelayInitialize(AMachine: TatVirtualMachine);
    procedure __SetTServiceApplicationDelayInitialize(AMachine: TatVirtualMachine);
    procedure __GetTServiceApplicationServiceCount(AMachine: TatVirtualMachine);
    procedure __GetTServiceApplicationTitle(AMachine: TatVirtualMachine);
    procedure __SetTServiceApplicationTitle(AMachine: TatVirtualMachine);
    procedure __GetApplication(AMachine: TatVirtualMachine);
    procedure __SetApplication(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TEventLoggerClass = class of TEventLogger;
  TDependencyClass = class of TDependency;
  TDependenciesClass = class of TDependencies;
  TServiceThreadClass = class of TServiceThread;
  TServiceClass = class of TService;
  TServiceApplicationClass = class of TServiceApplication;

  TatSvcMgrDispatcher = class(TatEventDispatcher)
  private
    procedure __TServiceEvent( Sender: TService);
    procedure __TContinueEvent( Sender: TService; var Continued: Boolean);
    procedure __TPauseEvent( Sender: TService; var Paused: Boolean);
    procedure __TStartEvent( Sender: TService; var Started: Boolean);
    procedure __TStopEvent( Sender: TService; var Stopped: Boolean);
  end;


implementation



procedure TatSvcMgrLibrary.__TEventLoggerCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TEventLoggerClass(CurrentClass.ClassRef).Create(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSvcMgrLibrary.__TEventLoggerDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TEventLogger(CurrentObject).Destroy;
  end;
end;

procedure TatSvcMgrLibrary.__TEventLoggerLogMessage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      1: TEventLogger(CurrentObject).LogMessage(GetInputArg(0));
      2: TEventLogger(CurrentObject).LogMessage(GetInputArg(0),VarToInteger(GetInputArg(1)));
      3: TEventLogger(CurrentObject).LogMessage(GetInputArg(0),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
      4: TEventLogger(CurrentObject).LogMessage(GetInputArg(0),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
    end;
  end;
end;

procedure TatSvcMgrLibrary.__TDependenciesCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDependenciesClass(CurrentClass.ClassRef).Create(TPersistent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSvcMgrLibrary.__GetTDependenciesItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDependencies(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatSvcMgrLibrary.__SetTDependenciesItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDependencies(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]:=TDependency(Integer(GetInputArg(0)));
  end;
end;

procedure TatSvcMgrLibrary.__TServiceThreadCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TServiceThreadClass(CurrentClass.ClassRef).Create(TService(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSvcMgrLibrary.__TServiceThreadProcessRequests(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TServiceThread(CurrentObject).ProcessRequests(GetInputArg(0));
  end;
end;

procedure TatSvcMgrLibrary.__TServiceCreateNew(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := Integer(TServiceClass(CurrentClass.ClassRef).CreateNew(TComponent(Integer(GetInputArg(0)))));
2: AResult := Integer(TServiceClass(CurrentClass.ClassRef).CreateNew(TComponent(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1))));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSvcMgrLibrary.__TServiceDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TService(CurrentObject).Destroy;
  end;
end;

procedure TatSvcMgrLibrary.__TServiceReportStatus(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TService(CurrentObject).ReportStatus;
  end;
end;

procedure TatSvcMgrLibrary.__TServiceLogMessage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      1: TService(CurrentObject).LogMessage(GetInputArg(0));
      2: TService(CurrentObject).LogMessage(GetInputArg(0),VarToInteger(GetInputArg(1)));
      3: TService(CurrentObject).LogMessage(GetInputArg(0),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
      4: TService(CurrentObject).LogMessage(GetInputArg(0),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
    end;
  end;
end;

procedure TatSvcMgrLibrary.__GetTServiceErrCode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TService(CurrentObject).ErrCode));
  end;
end;

procedure TatSvcMgrLibrary.__SetTServiceErrCode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TService(CurrentObject).ErrCode:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatSvcMgrLibrary.__GetTServiceParamCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TService(CurrentObject).ParamCount));
  end;
end;

procedure TatSvcMgrLibrary.__GetTServiceParam(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TService(CurrentObject).Param[VarToInteger(GetArrayIndex(0))]);
  end;
end;

procedure TatSvcMgrLibrary.__GetTServiceServiceThread(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TService(CurrentObject).ServiceThread));
  end;
end;

procedure TatSvcMgrLibrary.__GetTServiceStatus(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TService(CurrentObject).Status);
  end;
end;

procedure TatSvcMgrLibrary.__SetTServiceStatus(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TService(CurrentObject).Status:=GetInputArg(0);
  end;
end;

procedure TatSvcMgrLibrary.__GetTServiceTerminated(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TService(CurrentObject).Terminated);
  end;
end;

procedure TatSvcMgrLibrary.__GetTServiceWin32ErrCode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TService(CurrentObject).Win32ErrCode));
  end;
end;

procedure TatSvcMgrLibrary.__SetTServiceWin32ErrCode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TService(CurrentObject).Win32ErrCode:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatSvcMgrLibrary.__TServiceApplicationCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TServiceApplicationClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSvcMgrLibrary.__TServiceApplicationDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TServiceApplication(CurrentObject).Destroy;
  end;
end;

procedure TatSvcMgrLibrary.__TServiceApplicationInitialize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TServiceApplication(CurrentObject).Initialize;
  end;
end;

procedure TatSvcMgrLibrary.__TServiceApplicationInstalling(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TServiceApplication(CurrentObject).Installing;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSvcMgrLibrary.__TServiceApplicationRun(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TServiceApplication(CurrentObject).Run;
  end;
end;

procedure TatSvcMgrLibrary.__GetTServiceApplicationDelayInitialize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TServiceApplication(CurrentObject).DelayInitialize);
  end;
end;

procedure TatSvcMgrLibrary.__SetTServiceApplicationDelayInitialize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TServiceApplication(CurrentObject).DelayInitialize:=GetInputArg(0);
  end;
end;

procedure TatSvcMgrLibrary.__GetTServiceApplicationServiceCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TServiceApplication(CurrentObject).ServiceCount));
  end;
end;

procedure TatSvcMgrLibrary.__GetTServiceApplicationTitle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TServiceApplication(CurrentObject).Title);
  end;
end;

procedure TatSvcMgrLibrary.__SetTServiceApplicationTitle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TServiceApplication(CurrentObject).Title:=GetInputArg(0);
  end;
end;

procedure TatSvcMgrDispatcher.__TServiceEvent( Sender: TService);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TServiceEvent(BeforeCall)(Sender);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender]);
    if AssignedMethod(AfterCall) then
      TServiceEvent(AfterCall)(Sender);
  end;
end;

procedure TatSvcMgrDispatcher.__TContinueEvent( Sender: TService; var Continued: Boolean);
var
  ContinuedTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TContinueEvent(BeforeCall)(Sender,Continued);
    ContinuedTemp := Continued;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,ContinuedTemp]);
    Continued := ContinuedTemp;
    if AssignedMethod(AfterCall) then
      TContinueEvent(AfterCall)(Sender,Continued);
  end;
end;

procedure TatSvcMgrDispatcher.__TPauseEvent( Sender: TService; var Paused: Boolean);
var
  PausedTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TPauseEvent(BeforeCall)(Sender,Paused);
    PausedTemp := Paused;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,PausedTemp]);
    Paused := PausedTemp;
    if AssignedMethod(AfterCall) then
      TPauseEvent(AfterCall)(Sender,Paused);
  end;
end;

procedure TatSvcMgrDispatcher.__TStartEvent( Sender: TService; var Started: Boolean);
var
  StartedTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TStartEvent(BeforeCall)(Sender,Started);
    StartedTemp := Started;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,StartedTemp]);
    Started := StartedTemp;
    if AssignedMethod(AfterCall) then
      TStartEvent(AfterCall)(Sender,Started);
  end;
end;

procedure TatSvcMgrDispatcher.__TStopEvent( Sender: TService; var Stopped: Boolean);
var
  StoppedTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TStopEvent(BeforeCall)(Sender,Stopped);
    StoppedTemp := Stopped;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,StoppedTemp]);
    Stopped := StoppedTemp;
    if AssignedMethod(AfterCall) then
      TStopEvent(AfterCall)(Sender,Stopped);
  end;
end;

procedure TatSvcMgrLibrary.__GetApplication(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(SvcMgr.Application));
  end;
end;

procedure TatSvcMgrLibrary.__SetApplication(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SvcMgr.Application:=TServiceApplication(Integer(GetInputArg(0)));
  end;
end;

procedure TatSvcMgrLibrary.Init;
begin
  With Scripter.DefineClass(TEventLogger) do
  begin
    DefineMethod('Create',1,tkClass,TEventLogger,__TEventLoggerCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TEventLoggerDestroy,false,0);
    DefineMethod('LogMessage',4,tkNone,nil,__TEventLoggerLogMessage,false,3);
  end;
  With Scripter.DefineClass(TDependency) do
  begin
  end;
  With Scripter.DefineClass(TDependencies) do
  begin
    DefineMethod('Create',1,tkClass,TDependencies,__TDependenciesCreate,true,0);
    DefaultProperty := DefineProp('Items',tkClass,__GetTDependenciesItems,__SetTDependenciesItems,TDependency,false,1);
  end;
  With Scripter.DefineClass(TServiceThread) do
  begin
    DefineMethod('Create',1,tkClass,TServiceThread,__TServiceThreadCreate,true,0);
    DefineMethod('ProcessRequests',1,tkNone,nil,__TServiceThreadProcessRequests,false,0);
  end;
  With Scripter.DefineClass(TService) do
  begin
    DefineMethod('CreateNew',2,tkClass,TService,__TServiceCreateNew,true,1);
    DefineMethod('Destroy',0,tkNone,nil,__TServiceDestroy,false,0);
    DefineMethod('ReportStatus',0,tkNone,nil,__TServiceReportStatus,false,0);
    DefineMethod('LogMessage',4,tkNone,nil,__TServiceLogMessage,false,3);
    DefineProp('ErrCode',tkInteger,__GetTServiceErrCode,__SetTServiceErrCode,nil,false,0);
    DefineProp('ParamCount',tkInteger,__GetTServiceParamCount,nil,nil,false,0);
    DefineProp('Param',tkVariant,__GetTServiceParam,nil,nil,false,1);
    DefineProp('ServiceThread',tkClass,__GetTServiceServiceThread,nil,TServiceThread,false,0);
    DefineProp('Status',tkEnumeration,__GetTServiceStatus,__SetTServiceStatus,nil,false,0);
    DefineProp('Terminated',tkVariant,__GetTServiceTerminated,nil,nil,false,0);
    DefineProp('Win32ErrCode',tkInteger,__GetTServiceWin32ErrCode,__SetTServiceWin32ErrCode,nil,false,0);
  end;
  With Scripter.DefineClass(TServiceApplication) do
  begin
    DefineMethod('Create',1,tkClass,TServiceApplication,__TServiceApplicationCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TServiceApplicationDestroy,false,0);
    DefineMethod('Initialize',0,tkNone,nil,__TServiceApplicationInitialize,false,0);
    DefineMethod('Installing',0,tkVariant,nil,__TServiceApplicationInstalling,false,0);
    DefineMethod('Run',0,tkNone,nil,__TServiceApplicationRun,false,0);
    DefineProp('DelayInitialize',tkVariant,__GetTServiceApplicationDelayInitialize,__SetTServiceApplicationDelayInitialize,nil,false,0);
    DefineProp('ServiceCount',tkInteger,__GetTServiceApplicationServiceCount,nil,nil,false,0);
    DefineProp('Title',tkVariant,__GetTServiceApplicationTitle,__SetTServiceApplicationTitle,nil,false,0);
  end;
  DefineEventAdapter(TypeInfo(TServiceEvent), TatSvcMgrDispatcher, @TatSvcMgrDispatcher.__TServiceEvent);
  DefineEventAdapter(TypeInfo(TContinueEvent), TatSvcMgrDispatcher, @TatSvcMgrDispatcher.__TContinueEvent);
  DefineEventAdapter(TypeInfo(TPauseEvent), TatSvcMgrDispatcher, @TatSvcMgrDispatcher.__TPauseEvent);
  DefineEventAdapter(TypeInfo(TStartEvent), TatSvcMgrDispatcher, @TatSvcMgrDispatcher.__TStartEvent);
  DefineEventAdapter(TypeInfo(TStopEvent), TatSvcMgrDispatcher, @TatSvcMgrDispatcher.__TStopEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    DefineProp('Application',tkClass,__GetApplication,__SetApplication,TServiceApplication,false,0);
    AddConstant('stWin32',stWin32);
    AddConstant('stDevice',stDevice);
    AddConstant('stFileSystem',stFileSystem);
    AddConstant('csStopped',csStopped);
    AddConstant('csStartPending',csStartPending);
    AddConstant('csStopPending',csStopPending);
    AddConstant('csRunning',csRunning);
    AddConstant('csContinuePending',csContinuePending);
    AddConstant('csPausePending',csPausePending);
    AddConstant('csPaused',csPaused);
    AddConstant('esIgnore',esIgnore);
    AddConstant('esNormal',esNormal);
    AddConstant('esSevere',esSevere);
    AddConstant('esCritical',esCritical);
    AddConstant('stBoot',stBoot);
    AddConstant('stSystem',stSystem);
    AddConstant('stAuto',stAuto);
    AddConstant('stManual',stManual);
    AddConstant('stDisabled',stDisabled);
    AddConstant('CM_SERVICE_CONTROL_CODE',CM_SERVICE_CONTROL_CODE);
  end;
end;

class function TatSvcMgrLibrary.LibraryName: string;
begin
  result := 'SvcMgr';
end;

initialization
  RegisterScripterLibrary(TatSvcMgrLibrary, True);

{$WARNINGS ON}

end.

