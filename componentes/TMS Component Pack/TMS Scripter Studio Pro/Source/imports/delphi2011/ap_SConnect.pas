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
unit ap_SConnect;

interface

uses
  VarUtils,
  Variants,
  Windows,
  Messages,
  Classes,
  SysUtils,
  MConnect,
  ScktComp,
  WinSock,
  WinInet,
  ComObj,
  SConnect,
  atScript;

{$WARNINGS OFF}

type
  TatSConnectLibrary = class(TatScripterLibrary)
    procedure __TDataBlockCreate(AMachine: TatVirtualMachine);
    procedure __TDataBlockDestroy(AMachine: TatVirtualMachine);
    procedure __TDataBlockInterpreterDestroy(AMachine: TatVirtualMachine);
    procedure __TDataBlockInterpreterCallCreateObject(AMachine: TatVirtualMachine);
    procedure __TDataDispatchCreate(AMachine: TatVirtualMachine);
    procedure __TDataDispatchDestroy(AMachine: TatVirtualMachine);
    procedure __TTransportThreadDestroy(AMachine: TatVirtualMachine);
    procedure __TTransportThreadExecute(AMachine: TatVirtualMachine);
    procedure __GetTTransportThreadSemaphore(AMachine: TatVirtualMachine);
    procedure __TStreamedConnectionGetInterceptorList(AMachine: TatVirtualMachine);
    procedure __TStreamedConnectionGetServerList(AMachine: TatVirtualMachine);
    procedure __TStreamedConnectionCreate(AMachine: TatVirtualMachine);
    procedure __TStreamedConnectionDestroy(AMachine: TatVirtualMachine);
    procedure __TSocketTransportCreate(AMachine: TatVirtualMachine);
    procedure __TSocketTransportDestroy(AMachine: TatVirtualMachine);
    procedure __GetTSocketTransportHost(AMachine: TatVirtualMachine);
    procedure __SetTSocketTransportHost(AMachine: TatVirtualMachine);
    procedure __GetTSocketTransportAddress(AMachine: TatVirtualMachine);
    procedure __SetTSocketTransportAddress(AMachine: TatVirtualMachine);
    procedure __GetTSocketTransportPort(AMachine: TatVirtualMachine);
    procedure __SetTSocketTransportPort(AMachine: TatVirtualMachine);
    procedure __GetTSocketTransportSocket(AMachine: TatVirtualMachine);
    procedure __SetTSocketTransportSocket(AMachine: TatVirtualMachine);
    procedure __GetTSocketTransportInterceptGUID(AMachine: TatVirtualMachine);
    procedure __SetTSocketTransportInterceptGUID(AMachine: TatVirtualMachine);
    procedure __TSocketConnectionCreate(AMachine: TatVirtualMachine);
    procedure __TWebConnectionCreate(AMachine: TatVirtualMachine);
    procedure __TWebConnectionDestroy(AMachine: TatVirtualMachine);
    procedure __TPacketInterceptFactoryUpdateRegistry(AMachine: TatVirtualMachine);
    procedure __LoadWinSock2(AMachine: TatVirtualMachine);
    procedure __GetPacketInterceptorList(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TDataBlockClass = class of TDataBlock;
  EInterpreterErrorClass = class of EInterpreterError;
  TCustomDataBlockInterpreterClass = class of TCustomDataBlockInterpreter;
  TDataBlockInterpreterClass = class of TDataBlockInterpreter;
  TDataDispatchClass = class of TDataDispatch;
  TTransportThreadClass = class of TTransportThread;
  TStreamedConnectionClass = class of TStreamedConnection;
  ESocketConnectionErrorClass = class of ESocketConnectionError;
  TSocketTransportClass = class of TSocketTransport;
  TSocketConnectionClass = class of TSocketConnection;
  TWebConnectionClass = class of TWebConnection;
  TPacketInterceptFactoryClass = class of TPacketInterceptFactory;



implementation



procedure TatSConnectLibrary.__TDataBlockCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDataBlockClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSConnectLibrary.__TDataBlockDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataBlock(CurrentObject).Destroy;
  end;
end;

procedure TatSConnectLibrary.__TDataBlockInterpreterDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataBlockInterpreter(CurrentObject).Destroy;
  end;
end;

procedure TatSConnectLibrary.__TDataBlockInterpreterCallCreateObject(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDataBlockInterpreter(CurrentObject).CallCreateObject(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSConnectLibrary.__TDataDispatchCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDataDispatchClass(CurrentClass.ClassRef).Create(TCustomDataBlockInterpreter(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSConnectLibrary.__TDataDispatchDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDataDispatch(CurrentObject).Destroy;
  end;
end;

procedure TatSConnectLibrary.__TTransportThreadDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTransportThread(CurrentObject).Destroy;
  end;
end;

procedure TatSConnectLibrary.__TTransportThreadExecute(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTransportThread(CurrentObject).Execute;
  end;
end;

procedure TatSConnectLibrary.__GetTTransportThreadSemaphore(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TTransportThread(CurrentObject).Semaphore);
  end;
end;

procedure TatSConnectLibrary.__TStreamedConnectionGetInterceptorList(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TStreamedConnection(CurrentObject).GetInterceptorList;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSConnectLibrary.__TStreamedConnectionGetServerList(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TStreamedConnection(CurrentObject).GetServerList;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSConnectLibrary.__TStreamedConnectionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TStreamedConnectionClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSConnectLibrary.__TStreamedConnectionDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TStreamedConnection(CurrentObject).Destroy;
  end;
end;

procedure TatSConnectLibrary.__TSocketTransportCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TSocketTransportClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSConnectLibrary.__TSocketTransportDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSocketTransport(CurrentObject).Destroy;
  end;
end;

procedure TatSConnectLibrary.__GetTSocketTransportHost(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TSocketTransport(CurrentObject).Host);
  end;
end;

procedure TatSConnectLibrary.__SetTSocketTransportHost(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSocketTransport(CurrentObject).Host:=GetInputArg(0);
  end;
end;

procedure TatSConnectLibrary.__GetTSocketTransportAddress(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TSocketTransport(CurrentObject).Address);
  end;
end;

procedure TatSConnectLibrary.__SetTSocketTransportAddress(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSocketTransport(CurrentObject).Address:=GetInputArg(0);
  end;
end;

procedure TatSConnectLibrary.__GetTSocketTransportPort(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TSocketTransport(CurrentObject).Port));
  end;
end;

procedure TatSConnectLibrary.__SetTSocketTransportPort(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSocketTransport(CurrentObject).Port:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatSConnectLibrary.__GetTSocketTransportSocket(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TSocketTransport(CurrentObject).Socket));
  end;
end;

procedure TatSConnectLibrary.__SetTSocketTransportSocket(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSocketTransport(CurrentObject).Socket:=TCustomWinSocket(Integer(GetInputArg(0)));
  end;
end;

procedure TatSConnectLibrary.__GetTSocketTransportInterceptGUID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TSocketTransport(CurrentObject).InterceptGUID);
  end;
end;

procedure TatSConnectLibrary.__SetTSocketTransportInterceptGUID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TSocketTransport(CurrentObject).InterceptGUID:=GetInputArg(0);
  end;
end;

procedure TatSConnectLibrary.__TSocketConnectionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TSocketConnectionClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSConnectLibrary.__TWebConnectionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TWebConnectionClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSConnectLibrary.__TWebConnectionDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWebConnection(CurrentObject).Destroy;
  end;
end;

procedure TatSConnectLibrary.__TPacketInterceptFactoryUpdateRegistry(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPacketInterceptFactory(CurrentObject).UpdateRegistry(GetInputArg(0));
  end;
end;

procedure TatSConnectLibrary.__LoadWinSock2(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := SConnect.LoadWinSock2;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatSConnectLibrary.__GetPacketInterceptorList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    SConnect.GetPacketInterceptorList(TStringList(Integer(GetInputArg(0))));
  end;
end;

procedure TatSConnectLibrary.Init;
begin
  With Scripter.DefineClass(TDataBlock) do
  begin
    DefineMethod('Create',0,tkClass,TDataBlock,__TDataBlockCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TDataBlockDestroy,false,0);
  end;
  With Scripter.DefineClass(EInterpreterError) do
  begin
  end;
  With Scripter.DefineClass(TCustomDataBlockInterpreter) do
  begin
  end;
  With Scripter.DefineClass(TDataBlockInterpreter) do
  begin
    DefineMethod('Destroy',0,tkNone,nil,__TDataBlockInterpreterDestroy,false,0);
    DefineMethod('CallCreateObject',1,tkVariant,nil,__TDataBlockInterpreterCallCreateObject,false,0);
  end;
  With Scripter.DefineClass(TDataDispatch) do
  begin
    DefineMethod('Create',2,tkClass,TDataDispatch,__TDataDispatchCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TDataDispatchDestroy,false,0);
  end;
  With Scripter.DefineClass(TTransportThread) do
  begin
    DefineMethod('Destroy',0,tkNone,nil,__TTransportThreadDestroy,false,0);
    DefineMethod('Execute',0,tkNone,nil,__TTransportThreadExecute,false,0);
    DefineProp('Semaphore',tkVariant,__GetTTransportThreadSemaphore,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TStreamedConnection) do
  begin
    DefineMethod('GetInterceptorList',0,tkVariant,nil,__TStreamedConnectionGetInterceptorList,false,0);
    DefineMethod('GetServerList',0,tkVariant,nil,__TStreamedConnectionGetServerList,false,0);
    DefineMethod('Create',1,tkClass,TStreamedConnection,__TStreamedConnectionCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TStreamedConnectionDestroy,false,0);
  end;
  With Scripter.DefineClass(ESocketConnectionError) do
  begin
  end;
  With Scripter.DefineClass(TSocketTransport) do
  begin
    DefineMethod('Create',0,tkClass,TSocketTransport,__TSocketTransportCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TSocketTransportDestroy,false,0);
    DefineProp('Host',tkVariant,__GetTSocketTransportHost,__SetTSocketTransportHost,nil,false,0);
    DefineProp('Address',tkVariant,__GetTSocketTransportAddress,__SetTSocketTransportAddress,nil,false,0);
    DefineProp('Port',tkInteger,__GetTSocketTransportPort,__SetTSocketTransportPort,nil,false,0);
    DefineProp('Socket',tkClass,__GetTSocketTransportSocket,__SetTSocketTransportSocket,TCustomWinSocket,false,0);
    DefineProp('InterceptGUID',tkVariant,__GetTSocketTransportInterceptGUID,__SetTSocketTransportInterceptGUID,nil,false,0);
  end;
  With Scripter.DefineClass(TSocketConnection) do
  begin
    DefineMethod('Create',1,tkClass,TSocketConnection,__TSocketConnectionCreate,true,0);
  end;
  With Scripter.DefineClass(TWebConnection) do
  begin
    DefineMethod('Create',1,tkClass,TWebConnection,__TWebConnectionCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TWebConnectionDestroy,false,0);
  end;
  With Scripter.DefineClass(TPacketInterceptFactory) do
  begin
    DefineMethod('UpdateRegistry',1,tkNone,nil,__TPacketInterceptFactoryUpdateRegistry,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('LoadWinSock2',0,tkVariant,nil,__LoadWinSock2,false,0);
    DefineMethod('GetPacketInterceptorList',1,tkNone,nil,__GetPacketInterceptorList,false,0);
    AddConstant('vfByRef',vfByRef);
    AddConstant('vfVariant',vfVariant);
    AddConstant('CallSig',CallSig);
    AddConstant('ResultSig',ResultSig);
    AddConstant('asError',asError);
    AddConstant('asInvoke',asInvoke);
    AddConstant('asGetID',asGetID);
    AddConstant('asCreateObject',asCreateObject);
    AddConstant('asFreeObject',asFreeObject);
    AddConstant('asGetServers',asGetServers);
    AddConstant('asGetGUID',asGetGUID);
    AddConstant('asGetAppServers',asGetAppServers);
    AddConstant('asSoapCommand',asSoapCommand);
    AddConstant('asMask',asMask);
    AddConstant('THREAD_SENDSTREAM',THREAD_SENDSTREAM);
    AddConstant('THREAD_RECEIVEDSTREAM',THREAD_RECEIVEDSTREAM);
    AddConstant('THREAD_EXCEPTION',THREAD_EXCEPTION);
    AddConstant('THREAD_SENDNOTIFY',THREAD_SENDNOTIFY);
    AddConstant('THREAD_REPLACETRANSPORT',THREAD_REPLACETRANSPORT);
  end;
end;

class function TatSConnectLibrary.LibraryName: string;
begin
  result := 'SConnect';
end;

initialization
  RegisterScripterLibrary(TatSConnectLibrary, True);

{$WARNINGS ON}

end.

