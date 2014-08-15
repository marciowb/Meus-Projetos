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
unit ap_WinSock;

interface

uses
  Windows,
  WinSock,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatWinSockLibrary = class(TatScripterLibrary)
    procedure __bind(AMachine: TatVirtualMachine);
    procedure __closesocket(AMachine: TatVirtualMachine);
    procedure __connect(AMachine: TatVirtualMachine);
    procedure __ioctlsocket(AMachine: TatVirtualMachine);
    procedure __getpeername(AMachine: TatVirtualMachine);
    procedure __getsockname(AMachine: TatVirtualMachine);
    procedure __getsockopt(AMachine: TatVirtualMachine);
    procedure __htonl(AMachine: TatVirtualMachine);
    procedure __htons(AMachine: TatVirtualMachine);
    procedure __inet_addr(AMachine: TatVirtualMachine);
    procedure __inet_ntoa(AMachine: TatVirtualMachine);
    procedure __listen(AMachine: TatVirtualMachine);
    procedure __ntohl(AMachine: TatVirtualMachine);
    procedure __ntohs(AMachine: TatVirtualMachine);
    procedure __recv(AMachine: TatVirtualMachine);
    procedure __recvfrom(AMachine: TatVirtualMachine);
    procedure __send(AMachine: TatVirtualMachine);
    procedure __sendto(AMachine: TatVirtualMachine);
    procedure __setsockopt(AMachine: TatVirtualMachine);
    procedure __shutdown(AMachine: TatVirtualMachine);
    procedure __socket(AMachine: TatVirtualMachine);
    procedure __gethostname(AMachine: TatVirtualMachine);
    procedure __WSAStartup(AMachine: TatVirtualMachine);
    procedure __WSACleanup(AMachine: TatVirtualMachine);
    procedure __WSASetLastError(AMachine: TatVirtualMachine);
    procedure __WSAGetLastError(AMachine: TatVirtualMachine);
    procedure __WSAIsBlocking(AMachine: TatVirtualMachine);
    procedure __WSAUnhookBlockingHook(AMachine: TatVirtualMachine);
    procedure __WSACancelBlockingCall(AMachine: TatVirtualMachine);
    procedure __WSAAsyncGetServByName(AMachine: TatVirtualMachine);
    procedure __WSAAsyncGetServByPort(AMachine: TatVirtualMachine);
    procedure __WSAAsyncGetProtoByName(AMachine: TatVirtualMachine);
    procedure __WSAAsyncGetProtoByNumber(AMachine: TatVirtualMachine);
    procedure __WSAAsyncGetHostByName(AMachine: TatVirtualMachine);
    procedure __WSAAsyncGetHostByAddr(AMachine: TatVirtualMachine);
    procedure __WSACancelAsyncRequest(AMachine: TatVirtualMachine);
    procedure __WSAAsyncSelect(AMachine: TatVirtualMachine);
    procedure __WSARecvEx(AMachine: TatVirtualMachine);
    procedure ____WSAFDIsSet(AMachine: TatVirtualMachine);
    procedure __WSAMakeSyncReply(AMachine: TatVirtualMachine);
    procedure __WSAMakeSelectReply(AMachine: TatVirtualMachine);
    procedure __WSAGetAsyncBuflen(AMachine: TatVirtualMachine);
    procedure __WSAGetAsyncError(AMachine: TatVirtualMachine);
    procedure __WSAGetSelectEvent(AMachine: TatVirtualMachine);
    procedure __WSAGetSelectError(AMachine: TatVirtualMachine);
    procedure __FD_CLR(AMachine: TatVirtualMachine);
    procedure __FD_ISSET(AMachine: TatVirtualMachine);
    procedure __FD_SET(AMachine: TatVirtualMachine);
    procedure __FD_ZERO(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  TFDSetWrapper = class(TatRecordWrapper)
  private
    Ffd_count: u_int;
  public
    constructor Create(ARecord: TFDSet);
    function ObjToRec: TFDSet;
  published
    property fd_count: u_int read Ffd_count write Ffd_count;
  end;
  
  timevalWrapper = class(TatRecordWrapper)
  private
    Ftv_sec: Longint;
    Ftv_usec: Longint;
  public
    constructor Create(ARecord: timeval);
    function ObjToRec: timeval;
  published
    property tv_sec: Longint read Ftv_sec write Ftv_sec;
    property tv_usec: Longint read Ftv_usec write Ftv_usec;
  end;
  
  hostentWrapper = class(TatRecordWrapper)
  private
    Fh_addrtype: Smallint;
    Fh_length: Smallint;
  public
    constructor Create(ARecord: hostent);
    function ObjToRec: hostent;
  published
    property h_addrtype: Smallint read Fh_addrtype write Fh_addrtype;
    property h_length: Smallint read Fh_length write Fh_length;
  end;
  
  netentWrapper = class(TatRecordWrapper)
  private
    Fn_addrtype: Smallint;
    Fn_net: u_long;
  public
    constructor Create(ARecord: netent);
    function ObjToRec: netent;
  published
    property n_addrtype: Smallint read Fn_addrtype write Fn_addrtype;
    property n_net: u_long read Fn_net write Fn_net;
  end;
  
  serventWrapper = class(TatRecordWrapper)
  private
    Fs_port: Word;
  public
    constructor Create(ARecord: servent);
    function ObjToRec: servent;
  published
    property s_port: Word read Fs_port write Fs_port;
  end;
  
  protoentWrapper = class(TatRecordWrapper)
  private
    Fp_proto: Smallint;
  public
    constructor Create(ARecord: protoent);
    function ObjToRec: protoent;
  published
    property p_proto: Smallint read Fp_proto write Fp_proto;
  end;
  
  SunBWrapper = class(TatRecordWrapper)
  private
    Fs_b1: u_char;
    Fs_b2: u_char;
    Fs_b3: u_char;
    Fs_b4: u_char;
  public
    constructor Create(ARecord: SunB);
    function ObjToRec: SunB;
  published
    property s_b1: u_char read Fs_b1 write Fs_b1;
    property s_b2: u_char read Fs_b2 write Fs_b2;
    property s_b3: u_char read Fs_b3 write Fs_b3;
    property s_b4: u_char read Fs_b4 write Fs_b4;
  end;
  
  SunWWrapper = class(TatRecordWrapper)
  private
    Fs_w1: u_short;
    Fs_w2: u_short;
  public
    constructor Create(ARecord: SunW);
    function ObjToRec: SunW;
  published
    property s_w1: u_short read Fs_w1 write Fs_w1;
    property s_w2: u_short read Fs_w2 write Fs_w2;
  end;
  
  in_addrWrapper = class(TatRecordWrapper)
  private
    FS_addr: u_long;
  public
    constructor Create(ARecord: in_addr);
    function ObjToRec: in_addr;
  published
    property S_addr: u_long read FS_addr write FS_addr;
  end;
  
  sockaddr_inWrapper = class(TatRecordWrapper)
  private
    Fsin_family: u_short;
    Fsin_port: u_short;
    Fsa_family: u_short;
  public
    constructor Create(ARecord: sockaddr_in);
    function ObjToRec: sockaddr_in;
  published
    property sin_family: u_short read Fsin_family write Fsin_family;
    property sin_port: u_short read Fsin_port write Fsin_port;
    property sa_family: u_short read Fsa_family write Fsa_family;
  end;
  
  WSADataWrapper = class(TatRecordWrapper)
  private
    FwVersion: Word;
    FwHighVersion: Word;
    FiMaxSockets: Word;
    FiMaxUdpDg: Word;
  public
    constructor Create(ARecord: WSAData);
    function ObjToRec: WSAData;
  published
    property wVersion: Word read FwVersion write FwVersion;
    property wHighVersion: Word read FwHighVersion write FwHighVersion;
    property iMaxSockets: Word read FiMaxSockets write FiMaxSockets;
    property iMaxUdpDg: Word read FiMaxUdpDg write FiMaxUdpDg;
  end;
  
  _TRANSMIT_FILE_BUFFERSWrapper = class(TatRecordWrapper)
  private
    FHeadLength: DWORD;
    FTailLength: DWORD;
  public
    constructor Create(ARecord: _TRANSMIT_FILE_BUFFERS);
    function ObjToRec: _TRANSMIT_FILE_BUFFERS;
  published
    property HeadLength: DWORD read FHeadLength write FHeadLength;
    property TailLength: DWORD read FTailLength write FTailLength;
  end;
  
  sockprotoWrapper = class(TatRecordWrapper)
  private
    Fsp_family: u_short;
    Fsp_protocol: u_short;
  public
    constructor Create(ARecord: sockproto);
    function ObjToRec: sockproto;
  published
    property sp_family: u_short read Fsp_family write Fsp_family;
    property sp_protocol: u_short read Fsp_protocol write Fsp_protocol;
  end;
  
  lingerWrapper = class(TatRecordWrapper)
  private
    Fl_onoff: u_short;
    Fl_linger: u_short;
  public
    constructor Create(ARecord: linger);
    function ObjToRec: linger;
  published
    property l_onoff: u_short read Fl_onoff write Fl_onoff;
    property l_linger: u_short read Fl_linger write Fl_linger;
  end;
  

implementation

constructor TFDSetWrapper.Create(ARecord: TFDSet);
begin
  inherited Create;
  Ffd_count := ARecord.fd_count;
end;

function TFDSetWrapper.ObjToRec: TFDSet;
begin
  result.fd_count := Ffd_count;
end;

constructor timevalWrapper.Create(ARecord: timeval);
begin
  inherited Create;
  Ftv_sec := ARecord.tv_sec;
  Ftv_usec := ARecord.tv_usec;
end;

function timevalWrapper.ObjToRec: timeval;
begin
  result.tv_sec := Ftv_sec;
  result.tv_usec := Ftv_usec;
end;

constructor hostentWrapper.Create(ARecord: hostent);
begin
  inherited Create;
  Fh_addrtype := ARecord.h_addrtype;
  Fh_length := ARecord.h_length;
end;

function hostentWrapper.ObjToRec: hostent;
begin
  result.h_addrtype := Fh_addrtype;
  result.h_length := Fh_length;
end;

constructor netentWrapper.Create(ARecord: netent);
begin
  inherited Create;
  Fn_addrtype := ARecord.n_addrtype;
  Fn_net := ARecord.n_net;
end;

function netentWrapper.ObjToRec: netent;
begin
  result.n_addrtype := Fn_addrtype;
  result.n_net := Fn_net;
end;

constructor serventWrapper.Create(ARecord: servent);
begin
  inherited Create;
  Fs_port := ARecord.s_port;
end;

function serventWrapper.ObjToRec: servent;
begin
  result.s_port := Fs_port;
end;

constructor protoentWrapper.Create(ARecord: protoent);
begin
  inherited Create;
  Fp_proto := ARecord.p_proto;
end;

function protoentWrapper.ObjToRec: protoent;
begin
  result.p_proto := Fp_proto;
end;

constructor SunBWrapper.Create(ARecord: SunB);
begin
  inherited Create;
  Fs_b1 := ARecord.s_b1;
  Fs_b2 := ARecord.s_b2;
  Fs_b3 := ARecord.s_b3;
  Fs_b4 := ARecord.s_b4;
end;

function SunBWrapper.ObjToRec: SunB;
begin
  result.s_b1 := Fs_b1;
  result.s_b2 := Fs_b2;
  result.s_b3 := Fs_b3;
  result.s_b4 := Fs_b4;
end;

constructor SunWWrapper.Create(ARecord: SunW);
begin
  inherited Create;
  Fs_w1 := ARecord.s_w1;
  Fs_w2 := ARecord.s_w2;
end;

function SunWWrapper.ObjToRec: SunW;
begin
  result.s_w1 := Fs_w1;
  result.s_w2 := Fs_w2;
end;

constructor in_addrWrapper.Create(ARecord: in_addr);
begin
  inherited Create;
  FS_addr := ARecord.S_addr;
end;

function in_addrWrapper.ObjToRec: in_addr;
begin
  result.S_addr := FS_addr;
end;

constructor sockaddr_inWrapper.Create(ARecord: sockaddr_in);
begin
  inherited Create;
  Fsin_family := ARecord.sin_family;
  Fsin_port := ARecord.sin_port;
  Fsa_family := ARecord.sa_family;
end;

function sockaddr_inWrapper.ObjToRec: sockaddr_in;
begin
  result.sin_family := Fsin_family;
  result.sin_port := Fsin_port;
  result.sa_family := Fsa_family;
end;

constructor WSADataWrapper.Create(ARecord: WSAData);
begin
  inherited Create;
  FwVersion := ARecord.wVersion;
  FwHighVersion := ARecord.wHighVersion;
  FiMaxSockets := ARecord.iMaxSockets;
  FiMaxUdpDg := ARecord.iMaxUdpDg;
end;

function WSADataWrapper.ObjToRec: WSAData;
begin
  result.wVersion := FwVersion;
  result.wHighVersion := FwHighVersion;
  result.iMaxSockets := FiMaxSockets;
  result.iMaxUdpDg := FiMaxUdpDg;
end;

constructor _TRANSMIT_FILE_BUFFERSWrapper.Create(ARecord: _TRANSMIT_FILE_BUFFERS);
begin
  inherited Create;
  FHeadLength := ARecord.HeadLength;
  FTailLength := ARecord.TailLength;
end;

function _TRANSMIT_FILE_BUFFERSWrapper.ObjToRec: _TRANSMIT_FILE_BUFFERS;
begin
  result.HeadLength := FHeadLength;
  result.TailLength := FTailLength;
end;

constructor sockprotoWrapper.Create(ARecord: sockproto);
begin
  inherited Create;
  Fsp_family := ARecord.sp_family;
  Fsp_protocol := ARecord.sp_protocol;
end;

function sockprotoWrapper.ObjToRec: sockproto;
begin
  result.sp_family := Fsp_family;
  result.sp_protocol := Fsp_protocol;
end;

constructor lingerWrapper.Create(ARecord: linger);
begin
  inherited Create;
  Fl_onoff := ARecord.l_onoff;
  Fl_linger := ARecord.l_linger;
end;

function lingerWrapper.ObjToRec: linger;
begin
  result.l_onoff := Fl_onoff;
  result.l_linger := Fl_linger;
end;



procedure TatWinSockLibrary.__bind(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TSockAddr;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is sockaddr_inWrapper) then 
  Param1Rec := sockaddr_inWrapper.Create(Param1);
Param1 := sockaddr_inWrapper(Param1Rec).ObjToRec;
AResult := Integer(WinSock.bind(VarToInteger(GetInputArg(0)),Param1,VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(sockaddr_inWrapper.Create(Param1)));
  end;
end;

procedure TatWinSockLibrary.__closesocket(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSock.closesocket(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSockLibrary.__connect(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TSockAddr;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is sockaddr_inWrapper) then 
  Param1Rec := sockaddr_inWrapper.Create(Param1);
Param1 := sockaddr_inWrapper(Param1Rec).ObjToRec;
AResult := Integer(WinSock.connect(VarToInteger(GetInputArg(0)),Param1,VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(sockaddr_inWrapper.Create(Param1)));
  end;
end;

procedure TatWinSockLibrary.__ioctlsocket(AMachine: TatVirtualMachine);
  var
  Param2: u_long;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(WinSock.ioctlsocket(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatWinSockLibrary.__getpeername(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TSockAddr;
  Param2: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is sockaddr_inWrapper) then 
  Param1Rec := sockaddr_inWrapper.Create(Param1);
Param1 := sockaddr_inWrapper(Param1Rec).ObjToRec;
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(WinSock.getpeername(VarToInteger(GetInputArg(0)),Param1,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(sockaddr_inWrapper.Create(Param1)));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatWinSockLibrary.__getsockname(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TSockAddr;
  Param2: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is sockaddr_inWrapper) then 
  Param1Rec := sockaddr_inWrapper.Create(Param1);
Param1 := sockaddr_inWrapper(Param1Rec).ObjToRec;
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(WinSock.getsockname(VarToInteger(GetInputArg(0)),Param1,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(sockaddr_inWrapper.Create(Param1)));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatWinSockLibrary.__getsockopt(AMachine: TatVirtualMachine);
  var
  Param4: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param4 := VarToInteger(GetInputArg(4));
AResult := Integer(WinSock.getsockopt(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),PChar(VarToStr(GetInputArg(3))),Param4));
    ReturnOutputArg(AResult);
    SetInputArg(4,Integer(Param4));
  end;
end;

procedure TatWinSockLibrary.__htonl(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSock.htonl(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSockLibrary.__htons(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSock.htons(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSockLibrary.__inet_addr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSock.inet_addr(PChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSockLibrary.__inet_ntoa(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(WinSock.inet_ntoa(in_addrWrapper(integer(GetInputArg(0))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSockLibrary.__listen(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSock.listen(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSockLibrary.__ntohl(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSock.ntohl(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSockLibrary.__ntohs(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSock.ntohs(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSockLibrary.__recv(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(WinSock.recv(VarToInteger(GetInputArg(0)),Param1,VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatWinSockLibrary.__recvfrom(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
  Param4Rec: TObject;
  Param4: TSockAddr;
  Param5: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
Param4Rec := TObject(integer(GetInputArg(4)));
if not Assigned(Param4Rec) or not (Param4Rec is sockaddr_inWrapper) then 
  Param4Rec := sockaddr_inWrapper.Create(Param4);
Param4 := sockaddr_inWrapper(Param4Rec).ObjToRec;
Param5 := VarToInteger(GetInputArg(5));
AResult := Integer(WinSock.recvfrom(VarToInteger(GetInputArg(0)),Param1,VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),Param4,Param5));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
    SetInputArg(4,integer(sockaddr_inWrapper.Create(Param4)));
    SetInputArg(5,Integer(Param5));
  end;
end;

procedure TatWinSockLibrary.__send(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(WinSock.send(VarToInteger(GetInputArg(0)),Param1,VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatWinSockLibrary.__sendto(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
  Param4Rec: TObject;
  Param4: TSockAddr;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
Param4Rec := TObject(integer(GetInputArg(4)));
if not Assigned(Param4Rec) or not (Param4Rec is sockaddr_inWrapper) then 
  Param4Rec := sockaddr_inWrapper.Create(Param4);
Param4 := sockaddr_inWrapper(Param4Rec).ObjToRec;
AResult := Integer(WinSock.sendto(VarToInteger(GetInputArg(0)),Param1,VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),Param4,VarToInteger(GetInputArg(5))));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
    SetInputArg(4,integer(sockaddr_inWrapper.Create(Param4)));
  end;
end;

procedure TatWinSockLibrary.__setsockopt(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSock.setsockopt(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),PChar(VarToStr(GetInputArg(3))),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSockLibrary.__shutdown(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSock.shutdown(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSockLibrary.__socket(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSock.socket(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSockLibrary.__gethostname(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSock.gethostname(PChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSockLibrary.__WSAStartup(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TWSAData;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is WSADataWrapper) then 
  Param1Rec := WSADataWrapper.Create(Param1);
Param1 := WSADataWrapper(Param1Rec).ObjToRec;
AResult := Integer(WinSock.WSAStartup(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(WSADataWrapper.Create(Param1)));
  end;
end;

procedure TatWinSockLibrary.__WSACleanup(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSock.WSACleanup);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSockLibrary.__WSASetLastError(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    WinSock.WSASetLastError(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatWinSockLibrary.__WSAGetLastError(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSock.WSAGetLastError);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSockLibrary.__WSAIsBlocking(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WinSock.WSAIsBlocking;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSockLibrary.__WSAUnhookBlockingHook(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSock.WSAUnhookBlockingHook);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSockLibrary.__WSACancelBlockingCall(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSock.WSACancelBlockingCall);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSockLibrary.__WSAAsyncGetServByName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSock.WSAAsyncGetServByName(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),PChar(VarToStr(GetInputArg(2))),PChar(VarToStr(GetInputArg(3))),PChar(VarToStr(GetInputArg(4))),VarToInteger(GetInputArg(5))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSockLibrary.__WSAAsyncGetServByPort(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSock.WSAAsyncGetServByPort(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),PChar(VarToStr(GetInputArg(3))),PChar(VarToStr(GetInputArg(4))),VarToInteger(GetInputArg(5))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSockLibrary.__WSAAsyncGetProtoByName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSock.WSAAsyncGetProtoByName(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),PChar(VarToStr(GetInputArg(2))),PChar(VarToStr(GetInputArg(3))),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSockLibrary.__WSAAsyncGetProtoByNumber(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSock.WSAAsyncGetProtoByNumber(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),PChar(VarToStr(GetInputArg(3))),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSockLibrary.__WSAAsyncGetHostByName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSock.WSAAsyncGetHostByName(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),PChar(VarToStr(GetInputArg(2))),PChar(VarToStr(GetInputArg(3))),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSockLibrary.__WSAAsyncGetHostByAddr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSock.WSAAsyncGetHostByAddr(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),PChar(VarToStr(GetInputArg(2))),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)),PChar(VarToStr(GetInputArg(5))),VarToInteger(GetInputArg(6))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSockLibrary.__WSACancelAsyncRequest(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSock.WSACancelAsyncRequest(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSockLibrary.__WSAAsyncSelect(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSock.WSAAsyncSelect(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSockLibrary.__WSARecvEx(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
  Param3: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
Param3 := VarToInteger(GetInputArg(3));
AResult := Integer(WinSock.WSARecvEx(VarToInteger(GetInputArg(0)),Param1,VarToInteger(GetInputArg(2)),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatWinSockLibrary.____WSAFDIsSet(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TFDSet;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TFDSetWrapper) then 
  Param1Rec := TFDSetWrapper.Create(Param1);
Param1 := TFDSetWrapper(Param1Rec).ObjToRec;
AResult := WinSock.__WSAFDIsSet(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TFDSetWrapper.Create(Param1)));
  end;
end;

procedure TatWinSockLibrary.__WSAMakeSyncReply(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSock.WSAMakeSyncReply(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSockLibrary.__WSAMakeSelectReply(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSock.WSAMakeSelectReply(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSockLibrary.__WSAGetAsyncBuflen(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSock.WSAGetAsyncBuflen(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSockLibrary.__WSAGetAsyncError(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSock.WSAGetAsyncError(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSockLibrary.__WSAGetSelectEvent(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSock.WSAGetSelectEvent(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSockLibrary.__WSAGetSelectError(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(WinSock.WSAGetSelectError(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinSockLibrary.__FD_CLR(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TFDSet;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TFDSetWrapper) then 
  Param1Rec := TFDSetWrapper.Create(Param1);
Param1 := TFDSetWrapper(Param1Rec).ObjToRec;
    WinSock.FD_CLR(VarToInteger(GetInputArg(0)),Param1);
    SetInputArg(1,integer(TFDSetWrapper.Create(Param1)));
  end;
end;

procedure TatWinSockLibrary.__FD_ISSET(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TFDSet;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TFDSetWrapper) then 
  Param1Rec := TFDSetWrapper.Create(Param1);
Param1 := TFDSetWrapper(Param1Rec).ObjToRec;
AResult := WinSock.FD_ISSET(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TFDSetWrapper.Create(Param1)));
  end;
end;

procedure TatWinSockLibrary.__FD_SET(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TFDSet;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TFDSetWrapper) then 
  Param1Rec := TFDSetWrapper.Create(Param1);
Param1 := TFDSetWrapper(Param1Rec).ObjToRec;
    WinSock.FD_SET(VarToInteger(GetInputArg(0)),Param1);
    SetInputArg(1,integer(TFDSetWrapper.Create(Param1)));
  end;
end;

procedure TatWinSockLibrary.__FD_ZERO(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TFDSet;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TFDSetWrapper) then 
  Param0Rec := TFDSetWrapper.Create(Param0);
Param0 := TFDSetWrapper(Param0Rec).ObjToRec;
    WinSock.FD_ZERO(Param0);
    SetInputArg(0,integer(TFDSetWrapper.Create(Param0)));
  end;
end;

procedure TatWinSockLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('bind',3,tkInteger,nil,__bind,false,0).SetVarArgs([1]);
    DefineMethod('closesocket',1,tkInteger,nil,__closesocket,false,0);
    DefineMethod('connect',3,tkInteger,nil,__connect,false,0).SetVarArgs([1]);
    DefineMethod('ioctlsocket',3,tkInteger,nil,__ioctlsocket,false,0).SetVarArgs([2]);
    DefineMethod('getpeername',3,tkInteger,nil,__getpeername,false,0).SetVarArgs([1,2]);
    DefineMethod('getsockname',3,tkInteger,nil,__getsockname,false,0).SetVarArgs([1,2]);
    DefineMethod('getsockopt',5,tkInteger,nil,__getsockopt,false,0).SetVarArgs([4]);
    DefineMethod('htonl',1,tkInteger,nil,__htonl,false,0);
    DefineMethod('htons',1,tkInteger,nil,__htons,false,0);
    DefineMethod('inet_addr',1,tkInteger,nil,__inet_addr,false,0);
    DefineMethod('inet_ntoa',1,tkVariant,nil,__inet_ntoa,false,0);
    DefineMethod('listen',2,tkInteger,nil,__listen,false,0);
    DefineMethod('ntohl',1,tkInteger,nil,__ntohl,false,0);
    DefineMethod('ntohs',1,tkInteger,nil,__ntohs,false,0);
    DefineMethod('recv',4,tkInteger,nil,__recv,false,0).SetVarArgs([1]);
    DefineMethod('recvfrom',6,tkInteger,nil,__recvfrom,false,0).SetVarArgs([1,4,5]);
    DefineMethod('send',4,tkInteger,nil,__send,false,0).SetVarArgs([1]);
    DefineMethod('sendto',6,tkInteger,nil,__sendto,false,0).SetVarArgs([1,4]);
    DefineMethod('setsockopt',5,tkInteger,nil,__setsockopt,false,0);
    DefineMethod('shutdown',2,tkInteger,nil,__shutdown,false,0);
    DefineMethod('socket',3,tkInteger,nil,__socket,false,0);
    DefineMethod('gethostname',2,tkInteger,nil,__gethostname,false,0);
    DefineMethod('WSAStartup',2,tkInteger,nil,__WSAStartup,false,0).SetVarArgs([1]);
    DefineMethod('WSACleanup',0,tkInteger,nil,__WSACleanup,false,0);
    DefineMethod('WSASetLastError',1,tkNone,nil,__WSASetLastError,false,0);
    DefineMethod('WSAGetLastError',0,tkInteger,nil,__WSAGetLastError,false,0);
    DefineMethod('WSAIsBlocking',0,tkVariant,nil,__WSAIsBlocking,false,0);
    DefineMethod('WSAUnhookBlockingHook',0,tkInteger,nil,__WSAUnhookBlockingHook,false,0);
    DefineMethod('WSACancelBlockingCall',0,tkInteger,nil,__WSACancelBlockingCall,false,0);
    DefineMethod('WSAAsyncGetServByName',6,tkInteger,nil,__WSAAsyncGetServByName,false,0);
    DefineMethod('WSAAsyncGetServByPort',6,tkInteger,nil,__WSAAsyncGetServByPort,false,0);
    DefineMethod('WSAAsyncGetProtoByName',5,tkInteger,nil,__WSAAsyncGetProtoByName,false,0);
    DefineMethod('WSAAsyncGetProtoByNumber',5,tkInteger,nil,__WSAAsyncGetProtoByNumber,false,0);
    DefineMethod('WSAAsyncGetHostByName',5,tkInteger,nil,__WSAAsyncGetHostByName,false,0);
    DefineMethod('WSAAsyncGetHostByAddr',7,tkInteger,nil,__WSAAsyncGetHostByAddr,false,0);
    DefineMethod('WSACancelAsyncRequest',1,tkInteger,nil,__WSACancelAsyncRequest,false,0);
    DefineMethod('WSAAsyncSelect',4,tkInteger,nil,__WSAAsyncSelect,false,0);
    DefineMethod('WSARecvEx',4,tkInteger,nil,__WSARecvEx,false,0).SetVarArgs([1,3]);
    DefineMethod('__WSAFDIsSet',2,tkVariant,nil,____WSAFDIsSet,false,0).SetVarArgs([1]);
    DefineMethod('WSAMakeSyncReply',2,tkInteger,nil,__WSAMakeSyncReply,false,0);
    DefineMethod('WSAMakeSelectReply',2,tkInteger,nil,__WSAMakeSelectReply,false,0);
    DefineMethod('WSAGetAsyncBuflen',1,tkInteger,nil,__WSAGetAsyncBuflen,false,0);
    DefineMethod('WSAGetAsyncError',1,tkInteger,nil,__WSAGetAsyncError,false,0);
    DefineMethod('WSAGetSelectEvent',1,tkInteger,nil,__WSAGetSelectEvent,false,0);
    DefineMethod('WSAGetSelectError',1,tkInteger,nil,__WSAGetSelectError,false,0);
    DefineMethod('FD_CLR',2,tkNone,nil,__FD_CLR,false,0).SetVarArgs([1]);
    DefineMethod('FD_ISSET',2,tkVariant,nil,__FD_ISSET,false,0).SetVarArgs([1]);
    DefineMethod('FD_SET',2,tkNone,nil,__FD_SET,false,0).SetVarArgs([1]);
    DefineMethod('FD_ZERO',1,tkNone,nil,__FD_ZERO,false,0).SetVarArgs([0]);
    AddConstant('FD_SETSIZE',FD_SETSIZE);
    AddConstant('SD_RECEIVE',SD_RECEIVE);
    AddConstant('SD_SEND',SD_SEND);
    AddConstant('SD_BOTH',SD_BOTH);
    AddConstant('IOCPARM_MASK',IOCPARM_MASK);
    AddConstant('IOC_VOID',IOC_VOID);
    AddConstant('IOC_OUT',IOC_OUT);
    AddConstant('IOC_IN',IOC_IN);
    AddConstant('IOC_INOUT',IOC_INOUT);
    AddConstant('FIONREAD',FIONREAD);
    AddConstant('FIONBIO',FIONBIO);
    AddConstant('FIOASYNC',FIOASYNC);
    AddConstant('IPPROTO_IP',IPPROTO_IP);
    AddConstant('IPPROTO_ICMP',IPPROTO_ICMP);
    AddConstant('IPPROTO_IGMP',IPPROTO_IGMP);
    AddConstant('IPPROTO_GGP',IPPROTO_GGP);
    AddConstant('IPPROTO_TCP',IPPROTO_TCP);
    AddConstant('IPPROTO_PUP',IPPROTO_PUP);
    AddConstant('IPPROTO_UDP',IPPROTO_UDP);
    AddConstant('IPPROTO_IDP',IPPROTO_IDP);
    AddConstant('IPPROTO_ND',IPPROTO_ND);
    AddConstant('IPPROTO_RAW',IPPROTO_RAW);
    AddConstant('IPPROTO_MAX',IPPROTO_MAX);
    AddConstant('IPPORT_ECHO',IPPORT_ECHO);
    AddConstant('IPPORT_DISCARD',IPPORT_DISCARD);
    AddConstant('IPPORT_SYSTAT',IPPORT_SYSTAT);
    AddConstant('IPPORT_DAYTIME',IPPORT_DAYTIME);
    AddConstant('IPPORT_NETSTAT',IPPORT_NETSTAT);
    AddConstant('IPPORT_FTP',IPPORT_FTP);
    AddConstant('IPPORT_TELNET',IPPORT_TELNET);
    AddConstant('IPPORT_SMTP',IPPORT_SMTP);
    AddConstant('IPPORT_TIMESERVER',IPPORT_TIMESERVER);
    AddConstant('IPPORT_NAMESERVER',IPPORT_NAMESERVER);
    AddConstant('IPPORT_WHOIS',IPPORT_WHOIS);
    AddConstant('IPPORT_MTP',IPPORT_MTP);
    AddConstant('IPPORT_TFTP',IPPORT_TFTP);
    AddConstant('IPPORT_RJE',IPPORT_RJE);
    AddConstant('IPPORT_FINGER',IPPORT_FINGER);
    AddConstant('IPPORT_TTYLINK',IPPORT_TTYLINK);
    AddConstant('IPPORT_SUPDUP',IPPORT_SUPDUP);
    AddConstant('IPPORT_EXECSERVER',IPPORT_EXECSERVER);
    AddConstant('IPPORT_LOGINSERVER',IPPORT_LOGINSERVER);
    AddConstant('IPPORT_CMDSERVER',IPPORT_CMDSERVER);
    AddConstant('IPPORT_EFSSERVER',IPPORT_EFSSERVER);
    AddConstant('IPPORT_BIFFUDP',IPPORT_BIFFUDP);
    AddConstant('IPPORT_WHOSERVER',IPPORT_WHOSERVER);
    AddConstant('IPPORT_ROUTESERVER',IPPORT_ROUTESERVER);
    AddConstant('IPPORT_RESERVED',IPPORT_RESERVED);
    AddConstant('IMPLINK_IP',IMPLINK_IP);
    AddConstant('IMPLINK_LOWEXPER',IMPLINK_LOWEXPER);
    AddConstant('IMPLINK_HIGHEXPER',IMPLINK_HIGHEXPER);
    AddConstant('INADDR_ANY',INADDR_ANY);
    AddConstant('INADDR_LOOPBACK',INADDR_LOOPBACK);
    AddConstant('INADDR_BROADCAST',INADDR_BROADCAST);
    AddConstant('INADDR_NONE',INADDR_NONE);
    AddConstant('WSADESCRIPTION_LEN',WSADESCRIPTION_LEN);
    AddConstant('WSASYS_STATUS_LEN',WSASYS_STATUS_LEN);
    AddConstant('TF_DISCONNECT',TF_DISCONNECT);
    AddConstant('TF_REUSE_SOCKET',TF_REUSE_SOCKET);
    AddConstant('TF_WRITE_BEHIND',TF_WRITE_BEHIND);
    AddConstant('IP_OPTIONS',IP_OPTIONS);
    AddConstant('IP_MULTICAST_IF',IP_MULTICAST_IF);
    AddConstant('IP_MULTICAST_TTL',IP_MULTICAST_TTL);
    AddConstant('IP_MULTICAST_LOOP',IP_MULTICAST_LOOP);
    AddConstant('IP_ADD_MEMBERSHIP',IP_ADD_MEMBERSHIP);
    AddConstant('IP_DROP_MEMBERSHIP',IP_DROP_MEMBERSHIP);
    AddConstant('IP_TTL',IP_TTL);
    AddConstant('IP_TOS',IP_TOS);
    AddConstant('IP_DONTFRAGMENT',IP_DONTFRAGMENT);
    AddConstant('IP_DEFAULT_MULTICAST_TTL',IP_DEFAULT_MULTICAST_TTL);
    AddConstant('IP_DEFAULT_MULTICAST_LOOP',IP_DEFAULT_MULTICAST_LOOP);
    AddConstant('IP_MAX_MEMBERSHIPS',IP_MAX_MEMBERSHIPS);
    AddConstant('INVALID_SOCKET',INVALID_SOCKET);
    AddConstant('SOCKET_ERROR',SOCKET_ERROR);
    AddConstant('SOCK_STREAM',SOCK_STREAM);
    AddConstant('SOCK_DGRAM',SOCK_DGRAM);
    AddConstant('SOCK_RAW',SOCK_RAW);
    AddConstant('SOCK_RDM',SOCK_RDM);
    AddConstant('SOCK_SEQPACKET',SOCK_SEQPACKET);
    AddConstant('SO_DEBUG',SO_DEBUG);
    AddConstant('SO_ACCEPTCONN',SO_ACCEPTCONN);
    AddConstant('SO_REUSEADDR',SO_REUSEADDR);
    AddConstant('SO_KEEPALIVE',SO_KEEPALIVE);
    AddConstant('SO_DONTROUTE',SO_DONTROUTE);
    AddConstant('SO_BROADCAST',SO_BROADCAST);
    AddConstant('SO_USELOOPBACK',SO_USELOOPBACK);
    AddConstant('SO_LINGER',SO_LINGER);
    AddConstant('SO_OOBINLINE',SO_OOBINLINE);
    AddConstant('SO_DONTLINGER',SO_DONTLINGER);
    AddConstant('SO_SNDBUF',SO_SNDBUF);
    AddConstant('SO_RCVBUF',SO_RCVBUF);
    AddConstant('SO_SNDLOWAT',SO_SNDLOWAT);
    AddConstant('SO_RCVLOWAT',SO_RCVLOWAT);
    AddConstant('SO_SNDTIMEO',SO_SNDTIMEO);
    AddConstant('SO_RCVTIMEO',SO_RCVTIMEO);
    AddConstant('SO_ERROR',SO_ERROR);
    AddConstant('SO_TYPE',SO_TYPE);
    AddConstant('SO_CONNDATA',SO_CONNDATA);
    AddConstant('SO_CONNOPT',SO_CONNOPT);
    AddConstant('SO_DISCDATA',SO_DISCDATA);
    AddConstant('SO_DISCOPT',SO_DISCOPT);
    AddConstant('SO_CONNDATALEN',SO_CONNDATALEN);
    AddConstant('SO_CONNOPTLEN',SO_CONNOPTLEN);
    AddConstant('SO_DISCDATALEN',SO_DISCDATALEN);
    AddConstant('SO_DISCOPTLEN',SO_DISCOPTLEN);
    AddConstant('SO_OPENTYPE',SO_OPENTYPE);
    AddConstant('SO_SYNCHRONOUS_ALERT',SO_SYNCHRONOUS_ALERT);
    AddConstant('SO_SYNCHRONOUS_NONALERT',SO_SYNCHRONOUS_NONALERT);
    AddConstant('SO_MAXDG',SO_MAXDG);
    AddConstant('SO_MAXPATHDG',SO_MAXPATHDG);
    AddConstant('SO_UPDATE_ACCEPT_CONTEXT',SO_UPDATE_ACCEPT_CONTEXT);
    AddConstant('SO_CONNECT_TIME',SO_CONNECT_TIME);
    AddConstant('TCP_NODELAY',TCP_NODELAY);
    AddConstant('TCP_BSDURGENT',TCP_BSDURGENT);
    AddConstant('AF_UNSPEC',AF_UNSPEC);
    AddConstant('AF_UNIX',AF_UNIX);
    AddConstant('AF_INET',AF_INET);
    AddConstant('AF_IMPLINK',AF_IMPLINK);
    AddConstant('AF_PUP',AF_PUP);
    AddConstant('AF_CHAOS',AF_CHAOS);
    AddConstant('AF_IPX',AF_IPX);
    AddConstant('AF_NS',AF_NS);
    AddConstant('AF_ISO',AF_ISO);
    AddConstant('AF_OSI',AF_OSI);
    AddConstant('AF_ECMA',AF_ECMA);
    AddConstant('AF_DATAKIT',AF_DATAKIT);
    AddConstant('AF_CCITT',AF_CCITT);
    AddConstant('AF_SNA',AF_SNA);
    AddConstant('AF_DECnet',AF_DECnet);
    AddConstant('AF_DLI',AF_DLI);
    AddConstant('AF_LAT',AF_LAT);
    AddConstant('AF_HYLINK',AF_HYLINK);
    AddConstant('AF_APPLETALK',AF_APPLETALK);
    AddConstant('AF_NETBIOS',AF_NETBIOS);
    AddConstant('AF_VOICEVIEW',AF_VOICEVIEW);
    AddConstant('AF_FIREFOX',AF_FIREFOX);
    AddConstant('AF_UNKNOWN1',AF_UNKNOWN1);
    AddConstant('AF_BAN',AF_BAN);
    AddConstant('AF_MAX',AF_MAX);
    AddConstant('PF_UNSPEC',PF_UNSPEC);
    AddConstant('PF_UNIX',PF_UNIX);
    AddConstant('PF_INET',PF_INET);
    AddConstant('PF_IMPLINK',PF_IMPLINK);
    AddConstant('PF_PUP',PF_PUP);
    AddConstant('PF_CHAOS',PF_CHAOS);
    AddConstant('PF_NS',PF_NS);
    AddConstant('PF_IPX',PF_IPX);
    AddConstant('PF_ISO',PF_ISO);
    AddConstant('PF_OSI',PF_OSI);
    AddConstant('PF_ECMA',PF_ECMA);
    AddConstant('PF_DATAKIT',PF_DATAKIT);
    AddConstant('PF_CCITT',PF_CCITT);
    AddConstant('PF_SNA',PF_SNA);
    AddConstant('PF_DECnet',PF_DECnet);
    AddConstant('PF_DLI',PF_DLI);
    AddConstant('PF_LAT',PF_LAT);
    AddConstant('PF_HYLINK',PF_HYLINK);
    AddConstant('PF_APPLETALK',PF_APPLETALK);
    AddConstant('PF_VOICEVIEW',PF_VOICEVIEW);
    AddConstant('PF_FIREFOX',PF_FIREFOX);
    AddConstant('PF_UNKNOWN1',PF_UNKNOWN1);
    AddConstant('PF_BAN',PF_BAN);
    AddConstant('PF_MAX',PF_MAX);
    AddConstant('SOL_SOCKET',SOL_SOCKET);
    AddConstant('SOMAXCONN',SOMAXCONN);
    AddConstant('MSG_OOB',MSG_OOB);
    AddConstant('MSG_PEEK',MSG_PEEK);
    AddConstant('MSG_DONTROUTE',MSG_DONTROUTE);
    AddConstant('MSG_MAXIOVLEN',MSG_MAXIOVLEN);
    AddConstant('MSG_PARTIAL',MSG_PARTIAL);
    AddConstant('MAXGETHOSTSTRUCT',MAXGETHOSTSTRUCT);
    AddConstant('FD_READ',FD_READ);
    AddConstant('FD_WRITE',FD_WRITE);
    AddConstant('FD_OOB',FD_OOB);
    AddConstant('FD_ACCEPT',FD_ACCEPT);
    AddConstant('FD_CONNECT',FD_CONNECT);
    AddConstant('FD_CLOSE',FD_CLOSE);
    AddConstant('WSABASEERR',WSABASEERR);
    AddConstant('WSAEINTR',WSAEINTR);
    AddConstant('WSAEBADF',WSAEBADF);
    AddConstant('WSAEACCES',WSAEACCES);
    AddConstant('WSAEFAULT',WSAEFAULT);
    AddConstant('WSAEINVAL',WSAEINVAL);
    AddConstant('WSAEMFILE',WSAEMFILE);
    AddConstant('WSAEWOULDBLOCK',WSAEWOULDBLOCK);
    AddConstant('WSAEINPROGRESS',WSAEINPROGRESS);
    AddConstant('WSAEALREADY',WSAEALREADY);
    AddConstant('WSAENOTSOCK',WSAENOTSOCK);
    AddConstant('WSAEDESTADDRREQ',WSAEDESTADDRREQ);
    AddConstant('WSAEMSGSIZE',WSAEMSGSIZE);
    AddConstant('WSAEPROTOTYPE',WSAEPROTOTYPE);
    AddConstant('WSAENOPROTOOPT',WSAENOPROTOOPT);
    AddConstant('WSAEPROTONOSUPPORT',WSAEPROTONOSUPPORT);
    AddConstant('WSAESOCKTNOSUPPORT',WSAESOCKTNOSUPPORT);
    AddConstant('WSAEOPNOTSUPP',WSAEOPNOTSUPP);
    AddConstant('WSAEPFNOSUPPORT',WSAEPFNOSUPPORT);
    AddConstant('WSAEAFNOSUPPORT',WSAEAFNOSUPPORT);
    AddConstant('WSAEADDRINUSE',WSAEADDRINUSE);
    AddConstant('WSAEADDRNOTAVAIL',WSAEADDRNOTAVAIL);
    AddConstant('WSAENETDOWN',WSAENETDOWN);
    AddConstant('WSAENETUNREACH',WSAENETUNREACH);
    AddConstant('WSAENETRESET',WSAENETRESET);
    AddConstant('WSAECONNABORTED',WSAECONNABORTED);
    AddConstant('WSAECONNRESET',WSAECONNRESET);
    AddConstant('WSAENOBUFS',WSAENOBUFS);
    AddConstant('WSAEISCONN',WSAEISCONN);
    AddConstant('WSAENOTCONN',WSAENOTCONN);
    AddConstant('WSAESHUTDOWN',WSAESHUTDOWN);
    AddConstant('WSAETOOMANYREFS',WSAETOOMANYREFS);
    AddConstant('WSAETIMEDOUT',WSAETIMEDOUT);
    AddConstant('WSAECONNREFUSED',WSAECONNREFUSED);
    AddConstant('WSAELOOP',WSAELOOP);
    AddConstant('WSAENAMETOOLONG',WSAENAMETOOLONG);
    AddConstant('WSAEHOSTDOWN',WSAEHOSTDOWN);
    AddConstant('WSAEHOSTUNREACH',WSAEHOSTUNREACH);
    AddConstant('WSAENOTEMPTY',WSAENOTEMPTY);
    AddConstant('WSAEPROCLIM',WSAEPROCLIM);
    AddConstant('WSAEUSERS',WSAEUSERS);
    AddConstant('WSAEDQUOT',WSAEDQUOT);
    AddConstant('WSAESTALE',WSAESTALE);
    AddConstant('WSAEREMOTE',WSAEREMOTE);
    AddConstant('WSAEDISCON',WSAEDISCON);
    AddConstant('WSASYSNOTREADY',WSASYSNOTREADY);
    AddConstant('WSAVERNOTSUPPORTED',WSAVERNOTSUPPORTED);
    AddConstant('WSANOTINITIALISED',WSANOTINITIALISED);
    AddConstant('WSAHOST_NOT_FOUND',WSAHOST_NOT_FOUND);
    AddConstant('HOST_NOT_FOUND',HOST_NOT_FOUND);
    AddConstant('WSATRY_AGAIN',WSATRY_AGAIN);
    AddConstant('TRY_AGAIN',TRY_AGAIN);
    AddConstant('WSANO_RECOVERY',WSANO_RECOVERY);
    AddConstant('NO_RECOVERY',NO_RECOVERY);
    AddConstant('WSANO_DATA',WSANO_DATA);
    AddConstant('NO_DATA',NO_DATA);
    AddConstant('WSANO_ADDRESS',WSANO_ADDRESS);
    AddConstant('NO_ADDRESS',NO_ADDRESS);
    AddConstant('EWOULDBLOCK',EWOULDBLOCK);
    AddConstant('EINPROGRESS',EINPROGRESS);
    AddConstant('EALREADY',EALREADY);
    AddConstant('ENOTSOCK',ENOTSOCK);
    AddConstant('EDESTADDRREQ',EDESTADDRREQ);
    AddConstant('EMSGSIZE',EMSGSIZE);
    AddConstant('EPROTOTYPE',EPROTOTYPE);
    AddConstant('ENOPROTOOPT',ENOPROTOOPT);
    AddConstant('EPROTONOSUPPORT',EPROTONOSUPPORT);
    AddConstant('ESOCKTNOSUPPORT',ESOCKTNOSUPPORT);
    AddConstant('EOPNOTSUPP',EOPNOTSUPP);
    AddConstant('EPFNOSUPPORT',EPFNOSUPPORT);
    AddConstant('EAFNOSUPPORT',EAFNOSUPPORT);
    AddConstant('EADDRINUSE',EADDRINUSE);
    AddConstant('EADDRNOTAVAIL',EADDRNOTAVAIL);
    AddConstant('ENETDOWN',ENETDOWN);
    AddConstant('ENETUNREACH',ENETUNREACH);
    AddConstant('ENETRESET',ENETRESET);
    AddConstant('ECONNABORTED',ECONNABORTED);
    AddConstant('ECONNRESET',ECONNRESET);
    AddConstant('ENOBUFS',ENOBUFS);
    AddConstant('EISCONN',EISCONN);
    AddConstant('ENOTCONN',ENOTCONN);
    AddConstant('ESHUTDOWN',ESHUTDOWN);
    AddConstant('ETOOMANYREFS',ETOOMANYREFS);
    AddConstant('ETIMEDOUT',ETIMEDOUT);
    AddConstant('ECONNREFUSED',ECONNREFUSED);
    AddConstant('ELOOP',ELOOP);
    AddConstant('ENAMETOOLONG',ENAMETOOLONG);
    AddConstant('EHOSTDOWN',EHOSTDOWN);
    AddConstant('EHOSTUNREACH',EHOSTUNREACH);
    AddConstant('ENOTEMPTY',ENOTEMPTY);
    AddConstant('EPROCLIM',EPROCLIM);
    AddConstant('EUSERS',EUSERS);
    AddConstant('EDQUOT',EDQUOT);
    AddConstant('ESTALE',ESTALE);
    AddConstant('EREMOTE',EREMOTE);
  end;
end;

class function TatWinSockLibrary.LibraryName: string;
begin
  result := 'WinSock';
end;

initialization
  RegisterScripterLibrary(TatWinSockLibrary, True);

{$WARNINGS ON}

end.

