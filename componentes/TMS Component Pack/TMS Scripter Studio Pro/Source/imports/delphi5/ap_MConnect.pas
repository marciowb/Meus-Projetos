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
unit ap_MConnect;

interface

uses
  Messages,
  Windows,
  SysUtils,
  Classes,
  Midas,
  DBClient,
  ActiveX,
  ComObj,
  MConnect,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatMConnectLibrary = class(TatScripterLibrary)
    procedure __TCustomObjectBrokerSetConnectStatus(AMachine: TatVirtualMachine);
    procedure __TCustomObjectBrokerGetComputerForGUID(AMachine: TatVirtualMachine);
    procedure __TCustomObjectBrokerGetComputerForProgID(AMachine: TatVirtualMachine);
    procedure __TCustomObjectBrokerGetPortForComputer(AMachine: TatVirtualMachine);
    procedure __TDispatchConnectionCreate(AMachine: TatVirtualMachine);
    procedure __GetTDispatchConnectionAppServer(AMachine: TatVirtualMachine);
    procedure __TDCOMConnectionCreate(AMachine: TatVirtualMachine);
    procedure __GetMIDASAppServerList(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TCustomObjectBrokerClass = class of TCustomObjectBroker;
  TDispatchAppServerClass = class of TDispatchAppServer;
  TDispatchConnectionClass = class of TDispatchConnection;
  TCOMConnectionClass = class of TCOMConnection;
  TDCOMConnectionClass = class of TDCOMConnection;
  TOLEnterpriseConnectionClass = class of TOLEnterpriseConnection;

  TatMConnectDispatcher = class(TatEventDispatcher)
  private
    procedure __TGetUsernameEvent( Sender: TObject; var Username: string);
  end;


implementation



procedure TatMConnectLibrary.__TCustomObjectBrokerSetConnectStatus(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomObjectBroker(CurrentObject).SetConnectStatus(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatMConnectLibrary.__TCustomObjectBrokerGetComputerForGUID(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomObjectBroker(CurrentObject).GetComputerForGUID(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMConnectLibrary.__TCustomObjectBrokerGetComputerForProgID(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := TCustomObjectBroker(CurrentObject).GetComputerForProgID(Param0);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMConnectLibrary.__TCustomObjectBrokerGetPortForComputer(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomObjectBroker(CurrentObject).GetPortForComputer(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMConnectLibrary.__TDispatchConnectionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDispatchConnectionClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMConnectLibrary.__GetTDispatchConnectionAppServer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDispatchConnection(CurrentObject).AppServer);
  end;
end;

procedure TatMConnectLibrary.__TDCOMConnectionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDCOMConnectionClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMConnectDispatcher.__TGetUsernameEvent( Sender: TObject; var Username: string);
var
  UsernameTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TGetUsernameEvent(BeforeCall)(Sender,Username);
    UsernameTemp := Username;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,UsernameTemp]);
    Username := UsernameTemp;
    if AssignedMethod(AfterCall) then
      TGetUsernameEvent(AfterCall)(Sender,Username);
  end;
end;

procedure TatMConnectLibrary.__GetMIDASAppServerList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    MConnect.GetMIDASAppServerList(TStringList(Integer(GetInputArg(0))),GetInputArg(1));
  end;
end;

procedure TatMConnectLibrary.Init;
begin
  With Scripter.DefineClass(TCustomObjectBroker) do
  begin
    DefineMethod('SetConnectStatus',2,tkNone,nil,__TCustomObjectBrokerSetConnectStatus,false,0);
    DefineMethod('GetComputerForGUID',1,tkVariant,nil,__TCustomObjectBrokerGetComputerForGUID,false,0);
    DefineMethod('GetComputerForProgID',1,tkVariant,nil,__TCustomObjectBrokerGetComputerForProgID,false,0);
    DefineMethod('GetPortForComputer',1,tkInteger,nil,__TCustomObjectBrokerGetPortForComputer,false,0);
  end;
  With Scripter.DefineClass(TDispatchAppServer) do
  begin
  end;
  With Scripter.DefineClass(TDispatchConnection) do
  begin
    DefineMethod('Create',1,tkClass,TDispatchConnection,__TDispatchConnectionCreate,true,0);
    DefineProp('AppServer',tkVariant,__GetTDispatchConnectionAppServer,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TCOMConnection) do
  begin
  end;
  With Scripter.DefineClass(TDCOMConnection) do
  begin
    DefineMethod('Create',1,tkClass,TDCOMConnection,__TDCOMConnectionCreate,true,0);
  end;
  With Scripter.DefineClass(TOLEnterpriseConnection) do
  begin
  end;
  DefineEventAdapter(TypeInfo(TGetUsernameEvent), TatMConnectDispatcher, @TatMConnectDispatcher.__TGetUsernameEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('GetMIDASAppServerList',2,tkNone,nil,__GetMIDASAppServerList,false,0);
  end;
end;

class function TatMConnectLibrary.LibraryName: string;
begin
  result := 'MConnect';
end;

initialization
  RegisterScripterLibrary(TatMConnectLibrary, True);

{$WARNINGS ON}

end.

