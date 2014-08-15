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
unit ap_IBConnectionBroker;

interface

uses
  Windows,
  SysUtils,
  Classes,
  Db,
  IBDatabase,
  IBHeader,
  IBConnectionBroker,
  atScript;

{$WARNINGS OFF}

type
  TatIBConnectionBrokerLibrary = class(TatScripterLibrary)
    procedure __TIBPooledConnectionCreate(AMachine: TatVirtualMachine);
    procedure __GetTIBPooledConnectionDatabase(AMachine: TatVirtualMachine);
    procedure __GetTIBPooledConnectionConnStatus(AMachine: TatVirtualMachine);
    procedure __SetTIBPooledConnectionConnStatus(AMachine: TatVirtualMachine);
    procedure __GetTIBPooledConnectionConnLockTime(AMachine: TatVirtualMachine);
    procedure __SetTIBPooledConnectionConnLockTime(AMachine: TatVirtualMachine);
    procedure __GetTIBPooledConnectionConnCreateDate(AMachine: TatVirtualMachine);
    procedure __SetTIBPooledConnectionConnCreateDate(AMachine: TatVirtualMachine);
    procedure __TIBConnectionBrokerGetConnection(AMachine: TatVirtualMachine);
    procedure __TIBConnectionBrokerCreate(AMachine: TatVirtualMachine);
    procedure __TIBConnectionBrokerDestroy(AMachine: TatVirtualMachine);
    procedure __TIBConnectionBrokerReleaseConnection(AMachine: TatVirtualMachine);
    procedure __GetTIBConnectionBrokerAllocatedConnections(AMachine: TatVirtualMachine);
    procedure __GetTIBConnectionBrokerAvailableConnections(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TIBPooledConnectionClass = class of TIBPooledConnection;
  TIBConnectionBrokerClass = class of TIBConnectionBroker;

  TatIBConnectionBrokerDispatcher = class(TatEventDispatcher)
  private
    procedure __TIBConnectionBrokerLogEvent( Sender: TObject;  LogMessage: String);
  end;


implementation



procedure TatIBConnectionBrokerLibrary.__TIBPooledConnectionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBPooledConnectionClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBConnectionBrokerLibrary.__GetTIBPooledConnectionDatabase(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBPooledConnection(CurrentObject).Database));
  end;
end;

procedure TatIBConnectionBrokerLibrary.__GetTIBPooledConnectionConnStatus(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBPooledConnection(CurrentObject).ConnStatus));
  end;
end;

procedure TatIBConnectionBrokerLibrary.__SetTIBPooledConnectionConnStatus(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBPooledConnection(CurrentObject).ConnStatus:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatIBConnectionBrokerLibrary.__GetTIBPooledConnectionConnLockTime(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBPooledConnection(CurrentObject).ConnLockTime);
  end;
end;

procedure TatIBConnectionBrokerLibrary.__SetTIBPooledConnectionConnLockTime(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBPooledConnection(CurrentObject).ConnLockTime:=GetInputArg(0);
  end;
end;

procedure TatIBConnectionBrokerLibrary.__GetTIBPooledConnectionConnCreateDate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TIBPooledConnection(CurrentObject).ConnCreateDate);
  end;
end;

procedure TatIBConnectionBrokerLibrary.__SetTIBPooledConnectionConnCreateDate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBPooledConnection(CurrentObject).ConnCreateDate:=GetInputArg(0);
  end;
end;

procedure TatIBConnectionBrokerLibrary.__TIBConnectionBrokerGetConnection(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBConnectionBroker(CurrentObject).GetConnection);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBConnectionBrokerLibrary.__TIBConnectionBrokerCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBConnectionBrokerClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBConnectionBrokerLibrary.__TIBConnectionBrokerDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBConnectionBroker(CurrentObject).Destroy;
  end;
end;

procedure TatIBConnectionBrokerLibrary.__TIBConnectionBrokerReleaseConnection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBConnectionBroker(CurrentObject).ReleaseConnection(TIBDatabase(Integer(GetInputArg(0))));
  end;
end;

procedure TatIBConnectionBrokerLibrary.__GetTIBConnectionBrokerAllocatedConnections(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBConnectionBroker(CurrentObject).AllocatedConnections));
  end;
end;

procedure TatIBConnectionBrokerLibrary.__GetTIBConnectionBrokerAvailableConnections(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBConnectionBroker(CurrentObject).AvailableConnections));
  end;
end;

procedure TatIBConnectionBrokerDispatcher.__TIBConnectionBrokerLogEvent( Sender: TObject;  LogMessage: String);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TIBConnectionBrokerLogEvent(BeforeCall)(Sender,LogMessage);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,LogMessage]);
    if AssignedMethod(AfterCall) then
      TIBConnectionBrokerLogEvent(AfterCall)(Sender,LogMessage);
  end;
end;

procedure TatIBConnectionBrokerLibrary.Init;
begin
  With Scripter.DefineClass(TIBPooledConnection) do
  begin
    DefineMethod('Create',1,tkClass,TIBPooledConnection,__TIBPooledConnectionCreate,true,0);
    DefineProp('Database',tkClass,__GetTIBPooledConnectionDatabase,nil,TIBDatabase,false,0);
    DefineProp('ConnStatus',tkInteger,__GetTIBPooledConnectionConnStatus,__SetTIBPooledConnectionConnStatus,nil,false,0);
    DefineProp('ConnLockTime',tkVariant,__GetTIBPooledConnectionConnLockTime,__SetTIBPooledConnectionConnLockTime,nil,false,0);
    DefineProp('ConnCreateDate',tkVariant,__GetTIBPooledConnectionConnCreateDate,__SetTIBPooledConnectionConnCreateDate,nil,false,0);
  end;
  With Scripter.DefineClass(TIBConnectionBroker) do
  begin
    DefineMethod('GetConnection',0,tkClass,TIBDatabase,__TIBConnectionBrokerGetConnection,false,0);
    DefineMethod('Create',1,tkClass,TIBConnectionBroker,__TIBConnectionBrokerCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TIBConnectionBrokerDestroy,false,0);
    DefineMethod('ReleaseConnection',1,tkNone,nil,__TIBConnectionBrokerReleaseConnection,false,0);
    DefineProp('AllocatedConnections',tkInteger,__GetTIBConnectionBrokerAllocatedConnections,nil,nil,false,0);
    DefineProp('AvailableConnections',tkInteger,__GetTIBConnectionBrokerAvailableConnections,nil,nil,false,0);
  end;
  DefineEventAdapter(TypeInfo(TIBConnectionBrokerLogEvent), TatIBConnectionBrokerDispatcher, @TatIBConnectionBrokerDispatcher.__TIBConnectionBrokerLogEvent);
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatIBConnectionBrokerLibrary.LibraryName: string;
begin
  result := 'IBConnectionBroker';
end;

initialization
  RegisterScripterLibrary(TatIBConnectionBrokerLibrary, True);

{$WARNINGS ON}

end.

