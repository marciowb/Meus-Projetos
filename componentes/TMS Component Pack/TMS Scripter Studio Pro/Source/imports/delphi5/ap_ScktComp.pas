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
unit ap_ScktComp;

interface

uses
  SysUtils,
  Windows,
  Messages,
  Classes,
  WinSock,
  SyncObjs,
  ScktComp,
  ap_WinSock,
  atScript;

{$WARNINGS OFF}

type
  TatScktCompLibrary = class(TatScripterLibrary)
    procedure __TCustomWinSocketCreate(AMachine: TatVirtualMachine);
    procedure __TCustomWinSocketDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomWinSocketClose(AMachine: TatVirtualMachine);
    procedure __TCustomWinSocketDefaultHandler(AMachine: TatVirtualMachine);
    procedure __TCustomWinSocketLock(AMachine: TatVirtualMachine);
    procedure __TCustomWinSocketUnlock(AMachine: TatVirtualMachine);
    procedure __TCustomWinSocketListen(AMachine: TatVirtualMachine);
    procedure __TCustomWinSocketOpen(AMachine: TatVirtualMachine);
    procedure __TCustomWinSocketAccept(AMachine: TatVirtualMachine);
    procedure __TCustomWinSocketConnect(AMachine: TatVirtualMachine);
    procedure __TCustomWinSocketDisconnect(AMachine: TatVirtualMachine);
    procedure __TCustomWinSocketRead(AMachine: TatVirtualMachine);
    procedure __TCustomWinSocketWrite(AMachine: TatVirtualMachine);
    procedure __TCustomWinSocketLookupName(AMachine: TatVirtualMachine);
    procedure __TCustomWinSocketLookupService(AMachine: TatVirtualMachine);
    procedure __TCustomWinSocketReceiveLength(AMachine: TatVirtualMachine);
    procedure __TCustomWinSocketReceiveBuf(AMachine: TatVirtualMachine);
    procedure __TCustomWinSocketReceiveText(AMachine: TatVirtualMachine);
    procedure __TCustomWinSocketSendBuf(AMachine: TatVirtualMachine);
    procedure __TCustomWinSocketSendStream(AMachine: TatVirtualMachine);
    procedure __TCustomWinSocketSendStreamThenDrop(AMachine: TatVirtualMachine);
    procedure __TCustomWinSocketSendText(AMachine: TatVirtualMachine);
    procedure __GetTCustomWinSocketLocalHost(AMachine: TatVirtualMachine);
    procedure __GetTCustomWinSocketLocalAddress(AMachine: TatVirtualMachine);
    procedure __GetTCustomWinSocketLocalPort(AMachine: TatVirtualMachine);
    procedure __GetTCustomWinSocketRemoteHost(AMachine: TatVirtualMachine);
    procedure __GetTCustomWinSocketRemoteAddress(AMachine: TatVirtualMachine);
    procedure __GetTCustomWinSocketRemotePort(AMachine: TatVirtualMachine);
    procedure __GetTCustomWinSocketRemoteAddr(AMachine: TatVirtualMachine);
    procedure __GetTCustomWinSocketConnected(AMachine: TatVirtualMachine);
    procedure __GetTCustomWinSocketAddr(AMachine: TatVirtualMachine);
    procedure __GetTCustomWinSocketASyncStyles(AMachine: TatVirtualMachine);
    procedure __SetTCustomWinSocketASyncStyles(AMachine: TatVirtualMachine);
    procedure __GetTCustomWinSocketHandle(AMachine: TatVirtualMachine);
    procedure __GetTCustomWinSocketSocketHandle(AMachine: TatVirtualMachine);
    procedure __GetTCustomWinSocketLookupState(AMachine: TatVirtualMachine);
    procedure __TClientWinSocketConnect(AMachine: TatVirtualMachine);
    procedure __GetTClientWinSocketClientType(AMachine: TatVirtualMachine);
    procedure __SetTClientWinSocketClientType(AMachine: TatVirtualMachine);
    procedure __TServerClientWinSocketCreate(AMachine: TatVirtualMachine);
    procedure __TServerClientWinSocketDestroy(AMachine: TatVirtualMachine);
    procedure __GetTServerClientWinSocketServerWinSocket(AMachine: TatVirtualMachine);
    procedure __TServerWinSocketCreate(AMachine: TatVirtualMachine);
    procedure __TServerWinSocketDestroy(AMachine: TatVirtualMachine);
    procedure __TServerWinSocketAccept(AMachine: TatVirtualMachine);
    procedure __TServerWinSocketDisconnect(AMachine: TatVirtualMachine);
    procedure __TServerWinSocketGetClientThread(AMachine: TatVirtualMachine);
    procedure __GetTServerWinSocketActiveConnections(AMachine: TatVirtualMachine);
    procedure __GetTServerWinSocketActiveThreads(AMachine: TatVirtualMachine);
    procedure __GetTServerWinSocketConnections(AMachine: TatVirtualMachine);
    procedure __GetTServerWinSocketIdleThreads(AMachine: TatVirtualMachine);
    procedure __GetTServerWinSocketServerType(AMachine: TatVirtualMachine);
    procedure __SetTServerWinSocketServerType(AMachine: TatVirtualMachine);
    procedure __GetTServerWinSocketThreadCacheSize(AMachine: TatVirtualMachine);
    procedure __SetTServerWinSocketThreadCacheSize(AMachine: TatVirtualMachine);
    procedure __TServerAcceptThreadCreate(AMachine: TatVirtualMachine);
    procedure __TServerAcceptThreadExecute(AMachine: TatVirtualMachine);
    procedure __GetTServerAcceptThreadServerSocket(AMachine: TatVirtualMachine);
    procedure __TServerClientThreadCreate(AMachine: TatVirtualMachine);
    procedure __TServerClientThreadDestroy(AMachine: TatVirtualMachine);
    procedure __GetTServerClientThreadClientSocket(AMachine: TatVirtualMachine);
    procedure __GetTServerClientThreadServerSocket(AMachine: TatVirtualMachine);
    procedure __GetTServerClientThreadKeepInCache(AMachine: TatVirtualMachine);
    procedure __SetTServerClientThreadKeepInCache(AMachine: TatVirtualMachine);
    procedure __TAbstractSocketOpen(AMachine: TatVirtualMachine);
    procedure __TAbstractSocketClose(AMachine: TatVirtualMachine);
    procedure __TWinSocketStreamCreate(AMachine: TatVirtualMachine);
    procedure __TWinSocketStreamDestroy(AMachine: TatVirtualMachine);
    procedure __TWinSocketStreamWaitForData(AMachine: TatVirtualMachine);
    procedure __TWinSocketStreamRead(AMachine: TatVirtualMachine);
    procedure __TWinSocketStreamWrite(AMachine: TatVirtualMachine);
    procedure __TWinSocketStreamSeek(AMachine: TatVirtualMachine);
    procedure __GetTWinSocketStreamTimeOut(AMachine: TatVirtualMachine);
    procedure __SetTWinSocketStreamTimeOut(AMachine: TatVirtualMachine);
    procedure __TClientSocketCreate(AMachine: TatVirtualMachine);
    procedure __TClientSocketDestroy(AMachine: TatVirtualMachine);
    procedure __GetTClientSocketSocket(AMachine: TatVirtualMachine);
    procedure __TCustomServerSocketDestroy(AMachine: TatVirtualMachine);
    procedure __TServerSocketCreate(AMachine: TatVirtualMachine);
    procedure __GetTServerSocketSocket(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  ESocketErrorClass = class of ESocketError;
  TCustomWinSocketClass = class of TCustomWinSocket;
  TClientWinSocketClass = class of TClientWinSocket;
  TServerClientWinSocketClass = class of TServerClientWinSocket;
  TServerWinSocketClass = class of TServerWinSocket;
  TServerAcceptThreadClass = class of TServerAcceptThread;
  TServerClientThreadClass = class of TServerClientThread;
  TAbstractSocketClass = class of TAbstractSocket;
  TCustomSocketClass = class of TCustomSocket;
  TWinSocketStreamClass = class of TWinSocketStream;
  TClientSocketClass = class of TClientSocket;
  TCustomServerSocketClass = class of TCustomServerSocket;
  TServerSocketClass = class of TServerSocket;

  TatScktCompDispatcher = class(TatEventDispatcher)
  private
    procedure __TSocketEventEvent( Sender: TObject;  Socket: TCustomWinSocket;  SocketEvent: TSocketEvent);
    procedure __TSocketErrorEvent( Sender: TObject;  Socket: TCustomWinSocket;  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure __TGetSocketEvent( Sender: TObject;  Socket: TSocket; var ClientSocket: TServerClientWinSocket);
    procedure __TGetThreadEvent( Sender: TObject;  ClientSocket: TServerClientWinSocket; var SocketThread: TServerClientThread);
    procedure __TSocketNotifyEvent( Sender: TObject;  Socket: TCustomWinSocket);
    procedure __TThreadNotifyEvent( Sender: TObject;  Thread: TServerClientThread);
  end;

  TCMSocketMessageWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FSocket: TSocket;
    FSelectEvent: Word;
    FSelectError: Word;
    FResult: Longint;
  public
    constructor Create(ARecord: TCMSocketMessage);
    function ObjToRec: TCMSocketMessage;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Socket: TSocket read FSocket write FSocket;
    property SelectEvent: Word read FSelectEvent write FSelectEvent;
    property SelectError: Word read FSelectError write FSelectError;
    property Result: Longint read FResult write FResult;
  end;
  
  TCMLookupCompleteWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FLookupHandle: THandle;
    FAsyncBufLen: Word;
    FAsyncError: Word;
    FResult: Longint;
  public
    constructor Create(ARecord: TCMLookupComplete);
    function ObjToRec: TCMLookupComplete;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property LookupHandle: THandle read FLookupHandle write FLookupHandle;
    property AsyncBufLen: Word read FAsyncBufLen write FAsyncBufLen;
    property AsyncError: Word read FAsyncError write FAsyncError;
    property Result: Longint read FResult write FResult;
  end;
  

implementation

constructor TCMSocketMessageWrapper.Create(ARecord: TCMSocketMessage);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FSocket := ARecord.Socket;
  FSelectEvent := ARecord.SelectEvent;
  FSelectError := ARecord.SelectError;
  FResult := ARecord.Result;
end;

function TCMSocketMessageWrapper.ObjToRec: TCMSocketMessage;
begin
  result.Msg := FMsg;
  result.Socket := FSocket;
  result.SelectEvent := FSelectEvent;
  result.SelectError := FSelectError;
  result.Result := FResult;
end;

constructor TCMLookupCompleteWrapper.Create(ARecord: TCMLookupComplete);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FLookupHandle := ARecord.LookupHandle;
  FAsyncBufLen := ARecord.AsyncBufLen;
  FAsyncError := ARecord.AsyncError;
  FResult := ARecord.Result;
end;

function TCMLookupCompleteWrapper.ObjToRec: TCMLookupComplete;
begin
  result.Msg := FMsg;
  result.LookupHandle := FLookupHandle;
  result.AsyncBufLen := FAsyncBufLen;
  result.AsyncError := FAsyncError;
  result.Result := FResult;
end;



procedure TatScktCompLibrary.__TCustomWinSocketCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomWinSocketClass(CurrentClass.ClassRef).Create(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScktCompLibrary.__TCustomWinSocketDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomWinSocket(CurrentObject).Destroy;
  end;
end;

procedure TatScktCompLibrary.__TCustomWinSocketClose(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomWinSocket(CurrentObject).Close;
  end;
end;

procedure TatScktCompLibrary.__TCustomWinSocketDefaultHandler(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    TCustomWinSocket(CurrentObject).DefaultHandler(Param0);
    SetInputArg(0,Param0);
  end;
end;

procedure TatScktCompLibrary.__TCustomWinSocketLock(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomWinSocket(CurrentObject).Lock;
  end;
end;

procedure TatScktCompLibrary.__TCustomWinSocketUnlock(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomWinSocket(CurrentObject).Unlock;
  end;
end;

procedure TatScktCompLibrary.__TCustomWinSocketListen(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      5: TCustomWinSocket(CurrentObject).Listen(GetInputArg(0),GetInputArg(1),GetInputArg(2),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)));
      6: TCustomWinSocket(CurrentObject).Listen(GetInputArg(0),GetInputArg(1),GetInputArg(2),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)),GetInputArg(5));
    end;
  end;
end;

procedure TatScktCompLibrary.__TCustomWinSocketOpen(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      4: TCustomWinSocket(CurrentObject).Open(GetInputArg(0),GetInputArg(1),GetInputArg(2),VarToInteger(GetInputArg(3)));
      5: TCustomWinSocket(CurrentObject).Open(GetInputArg(0),GetInputArg(1),GetInputArg(2),VarToInteger(GetInputArg(3)),GetInputArg(4));
    end;
  end;
end;

procedure TatScktCompLibrary.__TCustomWinSocketAccept(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomWinSocket(CurrentObject).Accept(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatScktCompLibrary.__TCustomWinSocketConnect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomWinSocket(CurrentObject).Connect(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatScktCompLibrary.__TCustomWinSocketDisconnect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomWinSocket(CurrentObject).Disconnect(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatScktCompLibrary.__TCustomWinSocketRead(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomWinSocket(CurrentObject).Read(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatScktCompLibrary.__TCustomWinSocketWrite(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomWinSocket(CurrentObject).Write(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatScktCompLibrary.__TCustomWinSocketLookupName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(in_addrWrapper.Create(TCustomWinSocket(CurrentObject).LookupName(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScktCompLibrary.__TCustomWinSocketLookupService(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomWinSocket(CurrentObject).LookupService(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScktCompLibrary.__TCustomWinSocketReceiveLength(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomWinSocket(CurrentObject).ReceiveLength);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScktCompLibrary.__TCustomWinSocketReceiveBuf(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(TCustomWinSocket(CurrentObject).ReceiveBuf(Param0,VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatScktCompLibrary.__TCustomWinSocketReceiveText(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomWinSocket(CurrentObject).ReceiveText;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScktCompLibrary.__TCustomWinSocketSendBuf(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(TCustomWinSocket(CurrentObject).SendBuf(Param0,VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatScktCompLibrary.__TCustomWinSocketSendStream(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomWinSocket(CurrentObject).SendStream(TStream(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScktCompLibrary.__TCustomWinSocketSendStreamThenDrop(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomWinSocket(CurrentObject).SendStreamThenDrop(TStream(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScktCompLibrary.__TCustomWinSocketSendText(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomWinSocket(CurrentObject).SendText(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScktCompLibrary.__GetTCustomWinSocketLocalHost(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomWinSocket(CurrentObject).LocalHost);
  end;
end;

procedure TatScktCompLibrary.__GetTCustomWinSocketLocalAddress(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomWinSocket(CurrentObject).LocalAddress);
  end;
end;

procedure TatScktCompLibrary.__GetTCustomWinSocketLocalPort(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomWinSocket(CurrentObject).LocalPort));
  end;
end;

procedure TatScktCompLibrary.__GetTCustomWinSocketRemoteHost(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomWinSocket(CurrentObject).RemoteHost);
  end;
end;

procedure TatScktCompLibrary.__GetTCustomWinSocketRemoteAddress(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomWinSocket(CurrentObject).RemoteAddress);
  end;
end;

procedure TatScktCompLibrary.__GetTCustomWinSocketRemotePort(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomWinSocket(CurrentObject).RemotePort));
  end;
end;

procedure TatScktCompLibrary.__GetTCustomWinSocketRemoteAddr(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(sockaddr_inWrapper.Create(TCustomWinSocket(CurrentObject).RemoteAddr)));
  end;
end;

procedure TatScktCompLibrary.__GetTCustomWinSocketConnected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomWinSocket(CurrentObject).Connected);
  end;
end;

procedure TatScktCompLibrary.__GetTCustomWinSocketAddr(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(sockaddr_inWrapper.Create(TCustomWinSocket(CurrentObject).Addr)));
  end;
end;

procedure TatScktCompLibrary.__GetTCustomWinSocketASyncStyles(AMachine: TatVirtualMachine);
var
PropValueSet: TAsyncStyles;
begin
  with AMachine do
  begin
    PropValueSet := TCustomWinSocket(CurrentObject).ASyncStyles;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatScktCompLibrary.__SetTCustomWinSocketASyncStyles(AMachine: TatVirtualMachine);
  var
  TempVar: TAsyncStyles;
begin
  with AMachine do
  begin
    IntToSet(TempVar, VarToInteger(GetInputArg(0)), SizeOf(TempVar));
    TCustomWinSocket(CurrentObject).ASyncStyles:=TempVar;
  end;
end;

procedure TatScktCompLibrary.__GetTCustomWinSocketHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomWinSocket(CurrentObject).Handle));
  end;
end;

procedure TatScktCompLibrary.__GetTCustomWinSocketSocketHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomWinSocket(CurrentObject).SocketHandle));
  end;
end;

procedure TatScktCompLibrary.__GetTCustomWinSocketLookupState(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomWinSocket(CurrentObject).LookupState);
  end;
end;

procedure TatScktCompLibrary.__TClientWinSocketConnect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientWinSocket(CurrentObject).Connect(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatScktCompLibrary.__GetTClientWinSocketClientType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TClientWinSocket(CurrentObject).ClientType);
  end;
end;

procedure TatScktCompLibrary.__SetTClientWinSocketClientType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientWinSocket(CurrentObject).ClientType:=GetInputArg(0);
  end;
end;

procedure TatScktCompLibrary.__TServerClientWinSocketCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TServerClientWinSocketClass(CurrentClass.ClassRef).Create(VarToInteger(GetInputArg(0)),TServerWinSocket(Integer(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScktCompLibrary.__TServerClientWinSocketDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TServerClientWinSocket(CurrentObject).Destroy;
  end;
end;

procedure TatScktCompLibrary.__GetTServerClientWinSocketServerWinSocket(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TServerClientWinSocket(CurrentObject).ServerWinSocket));
  end;
end;

procedure TatScktCompLibrary.__TServerWinSocketCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TServerWinSocketClass(CurrentClass.ClassRef).Create(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScktCompLibrary.__TServerWinSocketDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TServerWinSocket(CurrentObject).Destroy;
  end;
end;

procedure TatScktCompLibrary.__TServerWinSocketAccept(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TServerWinSocket(CurrentObject).Accept(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatScktCompLibrary.__TServerWinSocketDisconnect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TServerWinSocket(CurrentObject).Disconnect(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatScktCompLibrary.__TServerWinSocketGetClientThread(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TServerWinSocket(CurrentObject).GetClientThread(TServerClientWinSocket(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScktCompLibrary.__GetTServerWinSocketActiveConnections(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TServerWinSocket(CurrentObject).ActiveConnections));
  end;
end;

procedure TatScktCompLibrary.__GetTServerWinSocketActiveThreads(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TServerWinSocket(CurrentObject).ActiveThreads));
  end;
end;

procedure TatScktCompLibrary.__GetTServerWinSocketConnections(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TServerWinSocket(CurrentObject).Connections[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatScktCompLibrary.__GetTServerWinSocketIdleThreads(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TServerWinSocket(CurrentObject).IdleThreads));
  end;
end;

procedure TatScktCompLibrary.__GetTServerWinSocketServerType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TServerWinSocket(CurrentObject).ServerType);
  end;
end;

procedure TatScktCompLibrary.__SetTServerWinSocketServerType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TServerWinSocket(CurrentObject).ServerType:=GetInputArg(0);
  end;
end;

procedure TatScktCompLibrary.__GetTServerWinSocketThreadCacheSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TServerWinSocket(CurrentObject).ThreadCacheSize));
  end;
end;

procedure TatScktCompLibrary.__SetTServerWinSocketThreadCacheSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TServerWinSocket(CurrentObject).ThreadCacheSize:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatScktCompLibrary.__TServerAcceptThreadCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TServerAcceptThreadClass(CurrentClass.ClassRef).Create(GetInputArg(0),TServerWinSocket(Integer(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScktCompLibrary.__TServerAcceptThreadExecute(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TServerAcceptThread(CurrentObject).Execute;
  end;
end;

procedure TatScktCompLibrary.__GetTServerAcceptThreadServerSocket(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TServerAcceptThread(CurrentObject).ServerSocket));
  end;
end;

procedure TatScktCompLibrary.__TServerClientThreadCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TServerClientThreadClass(CurrentClass.ClassRef).Create(GetInputArg(0),TServerClientWinSocket(Integer(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScktCompLibrary.__TServerClientThreadDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TServerClientThread(CurrentObject).Destroy;
  end;
end;

procedure TatScktCompLibrary.__GetTServerClientThreadClientSocket(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TServerClientThread(CurrentObject).ClientSocket));
  end;
end;

procedure TatScktCompLibrary.__GetTServerClientThreadServerSocket(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TServerClientThread(CurrentObject).ServerSocket));
  end;
end;

procedure TatScktCompLibrary.__GetTServerClientThreadKeepInCache(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TServerClientThread(CurrentObject).KeepInCache);
  end;
end;

procedure TatScktCompLibrary.__SetTServerClientThreadKeepInCache(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TServerClientThread(CurrentObject).KeepInCache:=GetInputArg(0);
  end;
end;

procedure TatScktCompLibrary.__TAbstractSocketOpen(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAbstractSocket(CurrentObject).Open;
  end;
end;

procedure TatScktCompLibrary.__TAbstractSocketClose(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAbstractSocket(CurrentObject).Close;
  end;
end;

procedure TatScktCompLibrary.__TWinSocketStreamCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TWinSocketStreamClass(CurrentClass.ClassRef).Create(TCustomWinSocket(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScktCompLibrary.__TWinSocketStreamDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWinSocketStream(CurrentObject).Destroy;
  end;
end;

procedure TatScktCompLibrary.__TWinSocketStreamWaitForData(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TWinSocketStream(CurrentObject).WaitForData(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScktCompLibrary.__TWinSocketStreamRead(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(TWinSocketStream(CurrentObject).Read(Param0,VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatScktCompLibrary.__TWinSocketStreamWrite(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(TWinSocketStream(CurrentObject).Write(Param0,VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScktCompLibrary.__TWinSocketStreamSeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TWinSocketStream(CurrentObject).Seek(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScktCompLibrary.__GetTWinSocketStreamTimeOut(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TWinSocketStream(CurrentObject).TimeOut));
  end;
end;

procedure TatScktCompLibrary.__SetTWinSocketStreamTimeOut(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWinSocketStream(CurrentObject).TimeOut:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatScktCompLibrary.__TClientSocketCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TClientSocketClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScktCompLibrary.__TClientSocketDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClientSocket(CurrentObject).Destroy;
  end;
end;

procedure TatScktCompLibrary.__GetTClientSocketSocket(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TClientSocket(CurrentObject).Socket));
  end;
end;

procedure TatScktCompLibrary.__TCustomServerSocketDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomServerSocket(CurrentObject).Destroy;
  end;
end;

procedure TatScktCompLibrary.__TServerSocketCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TServerSocketClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScktCompLibrary.__GetTServerSocketSocket(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TServerSocket(CurrentObject).Socket));
  end;
end;

procedure TatScktCompDispatcher.__TSocketEventEvent( Sender: TObject;  Socket: TCustomWinSocket;  SocketEvent: TSocketEvent);
var
  SocketEventTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TSocketEventEvent(BeforeCall)(Sender,Socket,SocketEvent);
    SocketEventTemp := SocketEvent;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Socket,SocketEventTemp]);
    if AssignedMethod(AfterCall) then
      TSocketEventEvent(AfterCall)(Sender,Socket,SocketEvent);
  end;
end;

procedure TatScktCompDispatcher.__TSocketErrorEvent( Sender: TObject;  Socket: TCustomWinSocket;  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
var
  ErrorEventTemp: variant;
  ErrorCodeTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TSocketErrorEvent(BeforeCall)(Sender,Socket,ErrorEvent,ErrorCode);
    ErrorEventTemp := ErrorEvent;
    ErrorCodeTemp := Integer(ErrorCode);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Socket,ErrorEventTemp,ErrorCodeTemp]);
    ErrorCode := VarToInteger(ErrorCodeTemp);
    if AssignedMethod(AfterCall) then
      TSocketErrorEvent(AfterCall)(Sender,Socket,ErrorEvent,ErrorCode);
  end;
end;

procedure TatScktCompDispatcher.__TGetSocketEvent( Sender: TObject;  Socket: TSocket; var ClientSocket: TServerClientWinSocket);
var
  ClientSocketTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TGetSocketEvent(BeforeCall)(Sender,Socket,ClientSocket);
    ClientSocketTemp := Integer(ClientSocket);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Socket,ClientSocketTemp]);
    ClientSocket := TServerClientWinSocket(Integer(ClientSocketTemp));
    if AssignedMethod(AfterCall) then
      TGetSocketEvent(AfterCall)(Sender,Socket,ClientSocket);
  end;
end;

procedure TatScktCompDispatcher.__TGetThreadEvent( Sender: TObject;  ClientSocket: TServerClientWinSocket; var SocketThread: TServerClientThread);
var
  SocketThreadTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TGetThreadEvent(BeforeCall)(Sender,ClientSocket,SocketThread);
    SocketThreadTemp := Integer(SocketThread);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,ClientSocket,SocketThreadTemp]);
    SocketThread := TServerClientThread(Integer(SocketThreadTemp));
    if AssignedMethod(AfterCall) then
      TGetThreadEvent(AfterCall)(Sender,ClientSocket,SocketThread);
  end;
end;

procedure TatScktCompDispatcher.__TSocketNotifyEvent( Sender: TObject;  Socket: TCustomWinSocket);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TSocketNotifyEvent(BeforeCall)(Sender,Socket);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Socket]);
    if AssignedMethod(AfterCall) then
      TSocketNotifyEvent(AfterCall)(Sender,Socket);
  end;
end;

procedure TatScktCompDispatcher.__TThreadNotifyEvent( Sender: TObject;  Thread: TServerClientThread);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TThreadNotifyEvent(BeforeCall)(Sender,Thread);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Thread]);
    if AssignedMethod(AfterCall) then
      TThreadNotifyEvent(AfterCall)(Sender,Thread);
  end;
end;

procedure TatScktCompLibrary.Init;
begin
  With Scripter.DefineClass(ESocketError) do
  begin
  end;
  With Scripter.DefineClass(TCustomWinSocket) do
  begin
    DefineMethod('Create',1,tkClass,TCustomWinSocket,__TCustomWinSocketCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomWinSocketDestroy,false,0);
    DefineMethod('Close',0,tkNone,nil,__TCustomWinSocketClose,false,0);
    DefineMethod('DefaultHandler',1,tkNone,nil,__TCustomWinSocketDefaultHandler,false,0).SetVarArgs([0]);
    DefineMethod('Lock',0,tkNone,nil,__TCustomWinSocketLock,false,0);
    DefineMethod('Unlock',0,tkNone,nil,__TCustomWinSocketUnlock,false,0);
    DefineMethod('Listen',6,tkNone,nil,__TCustomWinSocketListen,false,1);
    DefineMethod('Open',5,tkNone,nil,__TCustomWinSocketOpen,false,1);
    DefineMethod('Accept',1,tkNone,nil,__TCustomWinSocketAccept,false,0);
    DefineMethod('Connect',1,tkNone,nil,__TCustomWinSocketConnect,false,0);
    DefineMethod('Disconnect',1,tkNone,nil,__TCustomWinSocketDisconnect,false,0);
    DefineMethod('Read',1,tkNone,nil,__TCustomWinSocketRead,false,0);
    DefineMethod('Write',1,tkNone,nil,__TCustomWinSocketWrite,false,0);
    DefineMethod('LookupName',1,tkVariant,nil,__TCustomWinSocketLookupName,false,0);
    DefineMethod('LookupService',1,tkInteger,nil,__TCustomWinSocketLookupService,false,0);
    DefineMethod('ReceiveLength',0,tkInteger,nil,__TCustomWinSocketReceiveLength,false,0);
    DefineMethod('ReceiveBuf',2,tkInteger,nil,__TCustomWinSocketReceiveBuf,false,0).SetVarArgs([0]);
    DefineMethod('ReceiveText',0,tkVariant,nil,__TCustomWinSocketReceiveText,false,0);
    DefineMethod('SendBuf',2,tkInteger,nil,__TCustomWinSocketSendBuf,false,0).SetVarArgs([0]);
    DefineMethod('SendStream',1,tkVariant,nil,__TCustomWinSocketSendStream,false,0);
    DefineMethod('SendStreamThenDrop',1,tkVariant,nil,__TCustomWinSocketSendStreamThenDrop,false,0);
    DefineMethod('SendText',1,tkInteger,nil,__TCustomWinSocketSendText,false,0);
    DefineProp('LocalHost',tkVariant,__GetTCustomWinSocketLocalHost,nil,nil,false,0);
    DefineProp('LocalAddress',tkVariant,__GetTCustomWinSocketLocalAddress,nil,nil,false,0);
    DefineProp('LocalPort',tkInteger,__GetTCustomWinSocketLocalPort,nil,nil,false,0);
    DefineProp('RemoteHost',tkVariant,__GetTCustomWinSocketRemoteHost,nil,nil,false,0);
    DefineProp('RemoteAddress',tkVariant,__GetTCustomWinSocketRemoteAddress,nil,nil,false,0);
    DefineProp('RemotePort',tkInteger,__GetTCustomWinSocketRemotePort,nil,nil,false,0);
    DefineProp('RemoteAddr',tkVariant,__GetTCustomWinSocketRemoteAddr,nil,nil,false,0);
    DefineProp('Connected',tkVariant,__GetTCustomWinSocketConnected,nil,nil,false,0);
    DefineProp('Addr',tkVariant,__GetTCustomWinSocketAddr,nil,nil,false,0);
    DefineProp('ASyncStyles',tkInteger,__GetTCustomWinSocketASyncStyles,__SetTCustomWinSocketASyncStyles,nil,false,0);
    DefineProp('Handle',tkInteger,__GetTCustomWinSocketHandle,nil,nil,false,0);
    DefineProp('SocketHandle',tkInteger,__GetTCustomWinSocketSocketHandle,nil,nil,false,0);
    DefineProp('LookupState',tkEnumeration,__GetTCustomWinSocketLookupState,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TClientWinSocket) do
  begin
    DefineMethod('Connect',1,tkNone,nil,__TClientWinSocketConnect,false,0);
    DefineProp('ClientType',tkEnumeration,__GetTClientWinSocketClientType,__SetTClientWinSocketClientType,nil,false,0);
  end;
  With Scripter.DefineClass(TServerClientWinSocket) do
  begin
    DefineMethod('Create',2,tkClass,TServerClientWinSocket,__TServerClientWinSocketCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TServerClientWinSocketDestroy,false,0);
    DefineProp('ServerWinSocket',tkClass,__GetTServerClientWinSocketServerWinSocket,nil,TServerWinSocket,false,0);
  end;
  With Scripter.DefineClass(TServerWinSocket) do
  begin
    DefineMethod('Create',1,tkClass,TServerWinSocket,__TServerWinSocketCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TServerWinSocketDestroy,false,0);
    DefineMethod('Accept',1,tkNone,nil,__TServerWinSocketAccept,false,0);
    DefineMethod('Disconnect',1,tkNone,nil,__TServerWinSocketDisconnect,false,0);
    DefineMethod('GetClientThread',1,tkClass,TServerClientThread,__TServerWinSocketGetClientThread,false,0);
    DefineProp('ActiveConnections',tkInteger,__GetTServerWinSocketActiveConnections,nil,nil,false,0);
    DefineProp('ActiveThreads',tkInteger,__GetTServerWinSocketActiveThreads,nil,nil,false,0);
    DefineProp('Connections',tkClass,__GetTServerWinSocketConnections,nil,TCustomWinSocket,false,1);
    DefineProp('IdleThreads',tkInteger,__GetTServerWinSocketIdleThreads,nil,nil,false,0);
    DefineProp('ServerType',tkEnumeration,__GetTServerWinSocketServerType,__SetTServerWinSocketServerType,nil,false,0);
    DefineProp('ThreadCacheSize',tkInteger,__GetTServerWinSocketThreadCacheSize,__SetTServerWinSocketThreadCacheSize,nil,false,0);
  end;
  With Scripter.DefineClass(TServerAcceptThread) do
  begin
    DefineMethod('Create',2,tkClass,TServerAcceptThread,__TServerAcceptThreadCreate,true,0);
    DefineMethod('Execute',0,tkNone,nil,__TServerAcceptThreadExecute,false,0);
    DefineProp('ServerSocket',tkClass,__GetTServerAcceptThreadServerSocket,nil,TServerWinSocket,false,0);
  end;
  With Scripter.DefineClass(TServerClientThread) do
  begin
    DefineMethod('Create',2,tkClass,TServerClientThread,__TServerClientThreadCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TServerClientThreadDestroy,false,0);
    DefineProp('ClientSocket',tkClass,__GetTServerClientThreadClientSocket,nil,TServerClientWinSocket,false,0);
    DefineProp('ServerSocket',tkClass,__GetTServerClientThreadServerSocket,nil,TServerWinSocket,false,0);
    DefineProp('KeepInCache',tkVariant,__GetTServerClientThreadKeepInCache,__SetTServerClientThreadKeepInCache,nil,false,0);
  end;
  With Scripter.DefineClass(TAbstractSocket) do
  begin
    DefineMethod('Open',0,tkNone,nil,__TAbstractSocketOpen,false,0);
    DefineMethod('Close',0,tkNone,nil,__TAbstractSocketClose,false,0);
  end;
  With Scripter.DefineClass(TCustomSocket) do
  begin
  end;
  With Scripter.DefineClass(TWinSocketStream) do
  begin
    DefineMethod('Create',2,tkClass,TWinSocketStream,__TWinSocketStreamCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TWinSocketStreamDestroy,false,0);
    DefineMethod('WaitForData',1,tkVariant,nil,__TWinSocketStreamWaitForData,false,0);
    DefineMethod('Read',2,tkInteger,nil,__TWinSocketStreamRead,false,0).SetVarArgs([0]);
    DefineMethod('Write',2,tkInteger,nil,__TWinSocketStreamWrite,false,0);
    DefineMethod('Seek',2,tkInteger,nil,__TWinSocketStreamSeek,false,0);
    DefineProp('TimeOut',tkInteger,__GetTWinSocketStreamTimeOut,__SetTWinSocketStreamTimeOut,nil,false,0);
  end;
  With Scripter.DefineClass(TClientSocket) do
  begin
    DefineMethod('Create',1,tkClass,TClientSocket,__TClientSocketCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TClientSocketDestroy,false,0);
    DefineProp('Socket',tkClass,__GetTClientSocketSocket,nil,TClientWinSocket,false,0);
  end;
  With Scripter.DefineClass(TCustomServerSocket) do
  begin
    DefineMethod('Destroy',0,tkNone,nil,__TCustomServerSocketDestroy,false,0);
  end;
  With Scripter.DefineClass(TServerSocket) do
  begin
    DefineMethod('Create',1,tkClass,TServerSocket,__TServerSocketCreate,true,0);
    DefineProp('Socket',tkClass,__GetTServerSocketSocket,nil,TServerWinSocket,false,0);
  end;
  DefineEventAdapter(TypeInfo(TSocketEventEvent), TatScktCompDispatcher, @TatScktCompDispatcher.__TSocketEventEvent);
  DefineEventAdapter(TypeInfo(TSocketErrorEvent), TatScktCompDispatcher, @TatScktCompDispatcher.__TSocketErrorEvent);
  DefineEventAdapter(TypeInfo(TGetSocketEvent), TatScktCompDispatcher, @TatScktCompDispatcher.__TGetSocketEvent);
  DefineEventAdapter(TypeInfo(TGetThreadEvent), TatScktCompDispatcher, @TatScktCompDispatcher.__TGetThreadEvent);
  DefineEventAdapter(TypeInfo(TSocketNotifyEvent), TatScktCompDispatcher, @TatScktCompDispatcher.__TSocketNotifyEvent);
  DefineEventAdapter(TypeInfo(TThreadNotifyEvent), TatScktCompDispatcher, @TatScktCompDispatcher.__TThreadNotifyEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('stNonBlocking',stNonBlocking);
    AddConstant('stThreadBlocking',stThreadBlocking);
    AddConstant('ctNonBlocking',ctNonBlocking);
    AddConstant('ctBlocking',ctBlocking);
    AddConstant('asRead',asRead);
    AddConstant('asWrite',asWrite);
    AddConstant('asOOB',asOOB);
    AddConstant('asAccept',asAccept);
    AddConstant('asConnect',asConnect);
    AddConstant('asClose',asClose);
    AddConstant('seLookup',seLookup);
    AddConstant('seConnecting',seConnecting);
    AddConstant('seConnect',seConnect);
    AddConstant('seDisconnect',seDisconnect);
    AddConstant('seListen',seListen);
    AddConstant('seAccept',seAccept);
    AddConstant('seWrite',seWrite);
    AddConstant('seRead',seRead);
    AddConstant('lsIdle',lsIdle);
    AddConstant('lsLookupAddress',lsLookupAddress);
    AddConstant('lsLookupService',lsLookupService);
    AddConstant('eeGeneral',eeGeneral);
    AddConstant('eeSend',eeSend);
    AddConstant('eeReceive',eeReceive);
    AddConstant('eeConnect',eeConnect);
    AddConstant('eeDisconnect',eeDisconnect);
    AddConstant('eeAccept',eeAccept);
    AddConstant('CM_SOCKETMESSAGE',CM_SOCKETMESSAGE);
    AddConstant('CM_DEFERFREE',CM_DEFERFREE);
    AddConstant('CM_LOOKUPCOMPLETE',CM_LOOKUPCOMPLETE);
  end;
end;

class function TatScktCompLibrary.LibraryName: string;
begin
  result := 'ScktComp';
end;

initialization
  RegisterScripterLibrary(TatScktCompLibrary, True);

{$WARNINGS ON}

end.

