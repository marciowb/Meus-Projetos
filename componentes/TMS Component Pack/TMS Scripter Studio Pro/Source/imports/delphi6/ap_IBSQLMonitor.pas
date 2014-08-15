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
unit ap_IBSQLMonitor;

interface

uses
  SysUtils,
  Windows,
  Messages,
  Classes,
  IB,
  IBUtils,
  IBSQL,
  IBCustomDataSet,
  IBDatabase,
  IBServices,
  IBXConst,
  IBSQLMonitor,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatIBSQLMonitorLibrary = class(TatScripterLibrary)
    procedure __TIBCustomSQLMonitorCreate(AMachine: TatVirtualMachine);
    procedure __TIBCustomSQLMonitorDestroy(AMachine: TatVirtualMachine);
    procedure __TIBCustomSQLMonitorRelease(AMachine: TatVirtualMachine);
    procedure __GetTIBCustomSQLMonitorHandle(AMachine: TatVirtualMachine);
    procedure __EnableMonitoring(AMachine: TatVirtualMachine);
    procedure __DisableMonitoring(AMachine: TatVirtualMachine);
    procedure __MonitoringEnabled(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TIBCustomSQLMonitorClass = class of TIBCustomSQLMonitor;
  TIBSQLMonitorClass = class of TIBSQLMonitor;

  TatIBSQLMonitorDispatcher = class(TatEventDispatcher)
  private
    procedure __TSQLEvent( EventText: String;  EventTime: TDateTime);
  end;


implementation



procedure TatIBSQLMonitorLibrary.__TIBCustomSQLMonitorCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBCustomSQLMonitorClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBSQLMonitorLibrary.__TIBCustomSQLMonitorDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBCustomSQLMonitor(CurrentObject).Destroy;
  end;
end;

procedure TatIBSQLMonitorLibrary.__TIBCustomSQLMonitorRelease(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBCustomSQLMonitor(CurrentObject).Release;
  end;
end;

procedure TatIBSQLMonitorLibrary.__GetTIBCustomSQLMonitorHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBCustomSQLMonitor(CurrentObject).Handle));
  end;
end;

procedure TatIBSQLMonitorDispatcher.__TSQLEvent( EventText: String;  EventTime: TDateTime);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TSQLEvent(BeforeCall)(EventText,EventTime);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [EventText,EventTime]);
    if AssignedMethod(AfterCall) then
      TSQLEvent(AfterCall)(EventText,EventTime);
  end;
end;

procedure TatIBSQLMonitorLibrary.__EnableMonitoring(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    IBSQLMonitor.EnableMonitoring;
  end;
end;

procedure TatIBSQLMonitorLibrary.__DisableMonitoring(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    IBSQLMonitor.DisableMonitoring;
  end;
end;

procedure TatIBSQLMonitorLibrary.__MonitoringEnabled(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := IBSQLMonitor.MonitoringEnabled;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBSQLMonitorLibrary.Init;
begin
  With Scripter.DefineClass(TIBCustomSQLMonitor) do
  begin
    DefineMethod('Create',1,tkClass,TIBCustomSQLMonitor,__TIBCustomSQLMonitorCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TIBCustomSQLMonitorDestroy,false,0);
    DefineMethod('Release',0,tkNone,nil,__TIBCustomSQLMonitorRelease,false,0);
    DefineProp('Handle',tkInteger,__GetTIBCustomSQLMonitorHandle,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TIBSQLMonitor) do
  begin
  end;
  DefineEventAdapter(TypeInfo(TSQLEvent), TatIBSQLMonitorDispatcher, @TatIBSQLMonitorDispatcher.__TSQLEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('EnableMonitoring',0,tkNone,nil,__EnableMonitoring,false,0);
    DefineMethod('DisableMonitoring',0,tkNone,nil,__DisableMonitoring,false,0);
    DefineMethod('MonitoringEnabled',0,tkVariant,nil,__MonitoringEnabled,false,0);
    AddConstant('WM_MIN_IBSQL_MONITOR',WM_MIN_IBSQL_MONITOR);
    AddConstant('WM_MAX_IBSQL_MONITOR',WM_MAX_IBSQL_MONITOR);
    AddConstant('WM_IBSQL_SQL_EVENT',WM_IBSQL_SQL_EVENT);
  end;
end;

class function TatIBSQLMonitorLibrary.LibraryName: string;
begin
  result := 'IBSQLMonitor';
end;

initialization
  RegisterScripterLibrary(TatIBSQLMonitorLibrary, True);

{$WARNINGS ON}

end.

