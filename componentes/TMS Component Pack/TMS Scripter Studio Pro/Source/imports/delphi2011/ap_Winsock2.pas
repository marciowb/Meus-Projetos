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
unit ap_Winsock2;

interface

uses
  Windows,
  Qos,
  Winsock2,
  Variants,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatWinsock2Library = class(TatScripterLibrary)
    procedure ____WSAFDIsSet(AMachine: TatVirtualMachine);
    procedure __FD_CLR(AMachine: TatVirtualMachine);
    procedure ___FD_SET(AMachine: TatVirtualMachine);
    procedure __FD_ZERO(AMachine: TatVirtualMachine);
    procedure __FD_ISSET(AMachine: TatVirtualMachine);
    procedure __timerisset(AMachine: TatVirtualMachine);
    procedure __timerclear(AMachine: TatVirtualMachine);
    procedure ___IO(AMachine: TatVirtualMachine);
    procedure ___IOR(AMachine: TatVirtualMachine);
    procedure ___IOW(AMachine: TatVirtualMachine);
    procedure __IN_CLASSA(AMachine: TatVirtualMachine);
    procedure __IN_CLASSB(AMachine: TatVirtualMachine);
    procedure __IN_CLASSC(AMachine: TatVirtualMachine);
    procedure __IN_CLASSD(AMachine: TatVirtualMachine);
    procedure __IN_MULTICAST(AMachine: TatVirtualMachine);
    procedure __h_errno(AMachine: TatVirtualMachine);
    procedure ___WSAIO(AMachine: TatVirtualMachine);
    procedure ___WSAIOR(AMachine: TatVirtualMachine);
    procedure ___WSAIOW(AMachine: TatVirtualMachine);
    procedure ___WSAIORW(AMachine: TatVirtualMachine);
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
    procedure __WSACloseEvent(AMachine: TatVirtualMachine);
    procedure __WSACreateEvent(AMachine: TatVirtualMachine);
    procedure __WSADuplicateSocketA(AMachine: TatVirtualMachine);
    procedure __WSADuplicateSocketW(AMachine: TatVirtualMachine);
    procedure __WSADuplicateSocket(AMachine: TatVirtualMachine);
    procedure __WSAEnumNetworkEvents(AMachine: TatVirtualMachine);
    procedure __WSAEventSelect(AMachine: TatVirtualMachine);
    procedure __WSAHtonl(AMachine: TatVirtualMachine);
    procedure __WSAHtons(AMachine: TatVirtualMachine);
    procedure __WSANtohl(AMachine: TatVirtualMachine);
    procedure __WSANtohs(AMachine: TatVirtualMachine);
    procedure __WSAResetEvent(AMachine: TatVirtualMachine);
    procedure __WSASetEvent(AMachine: TatVirtualMachine);
    procedure __WSALookupServiceEnd(AMachine: TatVirtualMachine);
    procedure __WSARemoveServiceClass(AMachine: TatVirtualMachine);
    procedure __WSAGetServiceClassNameByClassIdA(AMachine: TatVirtualMachine);
    procedure __WSAGetServiceClassNameByClassIdW(AMachine: TatVirtualMachine);
    procedure __WSAGetServiceClassNameByClassId(AMachine: TatVirtualMachine);
    procedure __WSAMAKEASYNCREPLY(AMachine: TatVirtualMachine);
    procedure __WSAMAKESELECTREPLY(AMachine: TatVirtualMachine);
    procedure __WSAGETASYNCBUFLEN(AMachine: TatVirtualMachine);
    procedure __WSAGETASYNCERROR(AMachine: TatVirtualMachine);
    procedure __WSAGETSELECTEVENT(AMachine: TatVirtualMachine);
    procedure __WSAGETSELECTERROR(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  fd_setWrapper = class(TatRecordWrapper)
  private
    Ffd_count: u_int;
  public
    constructor Create(ARecord: fd_set);
    function ObjToRec: fd_set;
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
  
  SunCWrapper = class(TatRecordWrapper)
  private
    Fs_c1: AnsiChar;
    Fs_c2: AnsiChar;
    Fs_c3: AnsiChar;
    Fs_c4: AnsiChar;
  public
    constructor Create(ARecord: SunC);
    function ObjToRec: SunC;
  published
    property s_c1: AnsiChar read Fs_c1 write Fs_c1;
    property s_c2: AnsiChar read Fs_c2 write Fs_c2;
    property s_c3: AnsiChar read Fs_c3 write Fs_c3;
    property s_c4: AnsiChar read Fs_c4 write Fs_c4;
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
    Fsin_family: Smallint;
    Fsin_port: u_short;
  public
    constructor Create(ARecord: sockaddr_in);
    function ObjToRec: sockaddr_in;
  published
    property sin_family: Smallint read Fsin_family write Fsin_family;
    property sin_port: u_short read Fsin_port write Fsin_port;
  end;
  
  WSADataWrapper = class(TatRecordWrapper)
  private
    FwVersion: WORD;
    FwHighVersion: WORD;
    FiMaxSockets: Word;
    FiMaxUdpDg: Word;
  public
    constructor Create(ARecord: WSAData);
    function ObjToRec: WSAData;
  published
    property wVersion: WORD read FwVersion write FwVersion;
    property wHighVersion: WORD read FwHighVersion write FwHighVersion;
    property iMaxSockets: Word read FiMaxSockets write FiMaxSockets;
    property iMaxUdpDg: Word read FiMaxUdpDg write FiMaxUdpDg;
  end;
  
  sockaddrWrapper = class(TatRecordWrapper)
  private
    Fsa_family: u_short;
  public
    constructor Create(ARecord: sockaddr);
    function ObjToRec: sockaddr;
  published
    property sa_family: u_short read Fsa_family write Fsa_family;
  end;
  
  sockaddr_storageWrapper = class(TatRecordWrapper)
  private
    Fss_family: short;
    F__ss_align: Int64;
  public
    constructor Create(ARecord: sockaddr_storage);
    function ObjToRec: sockaddr_storage;
  published
    property ss_family: short read Fss_family write Fss_family;
    property __ss_align: Int64 read F__ss_align write F__ss_align;
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
  
  _WSABUFWrapper = class(TatRecordWrapper)
  private
    Flen: u_long;
  public
    constructor Create(ARecord: _WSABUF);
    function ObjToRec: _WSABUF;
  published
    property len: u_long read Flen write Flen;
  end;
  
  _QualityOfServiceWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _QualityOfService);
    function ObjToRec: _QualityOfService;
  published
  end;
  
  _WSANETWORKEVENTSWrapper = class(TatRecordWrapper)
  private
    FlNetworkEvents: Longint;
  public
    constructor Create(ARecord: _WSANETWORKEVENTS);
    function ObjToRec: _WSANETWORKEVENTS;
  published
    property lNetworkEvents: Longint read FlNetworkEvents write FlNetworkEvents;
  end;
  
  _WSAPROTOCOLCHAINWrapper = class(TatRecordWrapper)
  private
    FChainLen: Integer;
  public
    constructor Create(ARecord: _WSAPROTOCOLCHAIN);
    function ObjToRec: _WSAPROTOCOLCHAIN;
  published
    property ChainLen: Integer read FChainLen write FChainLen;
  end;
  
  _WSAPROTOCOL_INFOAWrapper = class(TatRecordWrapper)
  private
    FdwServiceFlags1: DWORD;
    FdwServiceFlags2: DWORD;
    FdwServiceFlags3: DWORD;
    FdwServiceFlags4: DWORD;
    FdwProviderFlags: DWORD;
    FProviderId: TGUID;
    FdwCatalogEntryId: DWORD;
    FiVersion: Integer;
    FiAddressFamily: Integer;
    FiMaxSockAddr: Integer;
    FiMinSockAddr: Integer;
    FiSocketType: Integer;
    FiProtocol: Integer;
    FiProtocolMaxOffset: Integer;
    FiNetworkByteOrder: Integer;
    FiSecurityScheme: Integer;
    FdwMessageSize: DWORD;
    FdwProviderReserved: DWORD;
  public
    constructor Create(ARecord: _WSAPROTOCOL_INFOA);
    function ObjToRec: _WSAPROTOCOL_INFOA;
  published
    property dwServiceFlags1: DWORD read FdwServiceFlags1 write FdwServiceFlags1;
    property dwServiceFlags2: DWORD read FdwServiceFlags2 write FdwServiceFlags2;
    property dwServiceFlags3: DWORD read FdwServiceFlags3 write FdwServiceFlags3;
    property dwServiceFlags4: DWORD read FdwServiceFlags4 write FdwServiceFlags4;
    property dwProviderFlags: DWORD read FdwProviderFlags write FdwProviderFlags;
    property ProviderId: TGUID read FProviderId write FProviderId;
    property dwCatalogEntryId: DWORD read FdwCatalogEntryId write FdwCatalogEntryId;
    property iVersion: Integer read FiVersion write FiVersion;
    property iAddressFamily: Integer read FiAddressFamily write FiAddressFamily;
    property iMaxSockAddr: Integer read FiMaxSockAddr write FiMaxSockAddr;
    property iMinSockAddr: Integer read FiMinSockAddr write FiMinSockAddr;
    property iSocketType: Integer read FiSocketType write FiSocketType;
    property iProtocol: Integer read FiProtocol write FiProtocol;
    property iProtocolMaxOffset: Integer read FiProtocolMaxOffset write FiProtocolMaxOffset;
    property iNetworkByteOrder: Integer read FiNetworkByteOrder write FiNetworkByteOrder;
    property iSecurityScheme: Integer read FiSecurityScheme write FiSecurityScheme;
    property dwMessageSize: DWORD read FdwMessageSize write FdwMessageSize;
    property dwProviderReserved: DWORD read FdwProviderReserved write FdwProviderReserved;
  end;
  
  _WSAPROTOCOL_INFOWWrapper = class(TatRecordWrapper)
  private
    FdwServiceFlags1: DWORD;
    FdwServiceFlags2: DWORD;
    FdwServiceFlags3: DWORD;
    FdwServiceFlags4: DWORD;
    FdwProviderFlags: DWORD;
    FProviderId: TGUID;
    FdwCatalogEntryId: DWORD;
    FiVersion: Integer;
    FiAddressFamily: Integer;
    FiMaxSockAddr: Integer;
    FiMinSockAddr: Integer;
    FiSocketType: Integer;
    FiProtocol: Integer;
    FiProtocolMaxOffset: Integer;
    FiNetworkByteOrder: Integer;
    FiSecurityScheme: Integer;
    FdwMessageSize: DWORD;
    FdwProviderReserved: DWORD;
  public
    constructor Create(ARecord: _WSAPROTOCOL_INFOW);
    function ObjToRec: _WSAPROTOCOL_INFOW;
  published
    property dwServiceFlags1: DWORD read FdwServiceFlags1 write FdwServiceFlags1;
    property dwServiceFlags2: DWORD read FdwServiceFlags2 write FdwServiceFlags2;
    property dwServiceFlags3: DWORD read FdwServiceFlags3 write FdwServiceFlags3;
    property dwServiceFlags4: DWORD read FdwServiceFlags4 write FdwServiceFlags4;
    property dwProviderFlags: DWORD read FdwProviderFlags write FdwProviderFlags;
    property ProviderId: TGUID read FProviderId write FProviderId;
    property dwCatalogEntryId: DWORD read FdwCatalogEntryId write FdwCatalogEntryId;
    property iVersion: Integer read FiVersion write FiVersion;
    property iAddressFamily: Integer read FiAddressFamily write FiAddressFamily;
    property iMaxSockAddr: Integer read FiMaxSockAddr write FiMaxSockAddr;
    property iMinSockAddr: Integer read FiMinSockAddr write FiMinSockAddr;
    property iSocketType: Integer read FiSocketType write FiSocketType;
    property iProtocol: Integer read FiProtocol write FiProtocol;
    property iProtocolMaxOffset: Integer read FiProtocolMaxOffset write FiProtocolMaxOffset;
    property iNetworkByteOrder: Integer read FiNetworkByteOrder write FiNetworkByteOrder;
    property iSecurityScheme: Integer read FiSecurityScheme write FiSecurityScheme;
    property dwMessageSize: DWORD read FdwMessageSize write FdwMessageSize;
    property dwProviderReserved: DWORD read FdwProviderReserved write FdwProviderReserved;
  end;
  
  _WSACOMPLETIONWrapper = class(TatRecordWrapper)
  private
    FType_: WSACOMPLETIONTYPE;
    FhWnd: HWND;
    FuMsg: UINT;
    Fcontext: WPARAM;
    FhPort: THandle;
    FKey: ULONG_PTR;
  public
    constructor Create(ARecord: _WSACOMPLETION);
    function ObjToRec: _WSACOMPLETION;
  published
    property Type_: WSACOMPLETIONTYPE read FType_ write FType_;
    property hWnd: HWND read FhWnd write FhWnd;
    property uMsg: UINT read FuMsg write FuMsg;
    property context: WPARAM read Fcontext write Fcontext;
    property hPort: THandle read FhPort write FhPort;
    property Key: ULONG_PTR read FKey write FKey;
  end;
  
  _SOCKET_ADDRESSWrapper = class(TatRecordWrapper)
  private
    FiSockaddrLength: Integer;
  public
    constructor Create(ARecord: _SOCKET_ADDRESS);
    function ObjToRec: _SOCKET_ADDRESS;
  published
    property iSockaddrLength: Integer read FiSockaddrLength write FiSockaddrLength;
  end;
  
  _CSADDR_INFOWrapper = class(TatRecordWrapper)
  private
    FiSocketType: Integer;
    FiProtocol: Integer;
  public
    constructor Create(ARecord: _CSADDR_INFO);
    function ObjToRec: _CSADDR_INFO;
  published
    property iSocketType: Integer read FiSocketType write FiSocketType;
    property iProtocol: Integer read FiProtocol write FiProtocol;
  end;
  
  _SOCKET_ADDRESS_LISTWrapper = class(TatRecordWrapper)
  private
    FiAddressCount: Integer;
  public
    constructor Create(ARecord: _SOCKET_ADDRESS_LIST);
    function ObjToRec: _SOCKET_ADDRESS_LIST;
  published
    property iAddressCount: Integer read FiAddressCount write FiAddressCount;
  end;
  
  _AFPROTOCOLSWrapper = class(TatRecordWrapper)
  private
    FiAddressFamily: Integer;
    FiProtocol: Integer;
  public
    constructor Create(ARecord: _AFPROTOCOLS);
    function ObjToRec: _AFPROTOCOLS;
  published
    property iAddressFamily: Integer read FiAddressFamily write FiAddressFamily;
    property iProtocol: Integer read FiProtocol write FiProtocol;
  end;
  
  _WSAVersionWrapper = class(TatRecordWrapper)
  private
    FdwVersion: DWORD;
    FecHow: WSAECOMPARATOR;
  public
    constructor Create(ARecord: _WSAVersion);
    function ObjToRec: _WSAVersion;
  published
    property dwVersion: DWORD read FdwVersion write FdwVersion;
    property ecHow: WSAECOMPARATOR read FecHow write FecHow;
  end;
  
  _WSANSClassInfoAWrapper = class(TatRecordWrapper)
  private
    FdwNameSpace: DWORD;
    FdwValueType: DWORD;
    FdwValueSize: DWORD;
  public
    constructor Create(ARecord: _WSANSClassInfoA);
    function ObjToRec: _WSANSClassInfoA;
  published
    property dwNameSpace: DWORD read FdwNameSpace write FdwNameSpace;
    property dwValueType: DWORD read FdwValueType write FdwValueType;
    property dwValueSize: DWORD read FdwValueSize write FdwValueSize;
  end;
  
  _WSANSClassInfoWWrapper = class(TatRecordWrapper)
  private
    FdwNameSpace: DWORD;
    FdwValueType: DWORD;
    FdwValueSize: DWORD;
  public
    constructor Create(ARecord: _WSANSClassInfoW);
    function ObjToRec: _WSANSClassInfoW;
  published
    property dwNameSpace: DWORD read FdwNameSpace write FdwNameSpace;
    property dwValueType: DWORD read FdwValueType write FdwValueType;
    property dwValueSize: DWORD read FdwValueSize write FdwValueSize;
  end;
  
  _WSANAMESPACE_INFOAWrapper = class(TatRecordWrapper)
  private
    FNSProviderId: TGUID;
    FdwNameSpace: DWORD;
    FfActive: BOOL;
    FdwVersion: DWORD;
  public
    constructor Create(ARecord: _WSANAMESPACE_INFOA);
    function ObjToRec: _WSANAMESPACE_INFOA;
  published
    property NSProviderId: TGUID read FNSProviderId write FNSProviderId;
    property dwNameSpace: DWORD read FdwNameSpace write FdwNameSpace;
    property fActive: BOOL read FfActive write FfActive;
    property dwVersion: DWORD read FdwVersion write FdwVersion;
  end;
  
  _WSANAMESPACE_INFOWWrapper = class(TatRecordWrapper)
  private
    FNSProviderId: TGUID;
    FdwNameSpace: DWORD;
    FfActive: BOOL;
    FdwVersion: DWORD;
  public
    constructor Create(ARecord: _WSANAMESPACE_INFOW);
    function ObjToRec: _WSANAMESPACE_INFOW;
  published
    property NSProviderId: TGUID read FNSProviderId write FNSProviderId;
    property dwNameSpace: DWORD read FdwNameSpace write FdwNameSpace;
    property fActive: BOOL read FfActive write FfActive;
    property dwVersion: DWORD read FdwVersion write FdwVersion;
  end;
  
  _WSANAMESPACE_INFOEXAWrapper = class(TatRecordWrapper)
  private
    FNSProviderId: TGUID;
    FdwNameSpace: DWORD;
    FfActive: BOOL;
    FdwVersion: DWORD;
  public
    constructor Create(ARecord: _WSANAMESPACE_INFOEXA);
    function ObjToRec: _WSANAMESPACE_INFOEXA;
  published
    property NSProviderId: TGUID read FNSProviderId write FNSProviderId;
    property dwNameSpace: DWORD read FdwNameSpace write FdwNameSpace;
    property fActive: BOOL read FfActive write FfActive;
    property dwVersion: DWORD read FdwVersion write FdwVersion;
  end;
  
  _WSANAMESPACE_INFOEXWWrapper = class(TatRecordWrapper)
  private
    FNSProviderId: TGUID;
    FdwNameSpace: DWORD;
    FfActive: BOOL;
    FdwVersion: DWORD;
  public
    constructor Create(ARecord: _WSANAMESPACE_INFOEXW);
    function ObjToRec: _WSANAMESPACE_INFOEXW;
  published
    property NSProviderId: TGUID read FNSProviderId write FNSProviderId;
    property dwNameSpace: DWORD read FdwNameSpace write FdwNameSpace;
    property fActive: BOOL read FfActive write FfActive;
    property dwVersion: DWORD read FdwVersion write FdwVersion;
  end;
  
  WSAMSGWrapper = class(TatRecordWrapper)
  private
    Fnamelen: Integer;
    FdwBufferCount: ULONG;
    FdwFlags: ULONG;
  public
    constructor Create(ARecord: WSAMSG);
    function ObjToRec: WSAMSG;
  published
    property namelen: Integer read Fnamelen write Fnamelen;
    property dwBufferCount: ULONG read FdwBufferCount write FdwBufferCount;
    property dwFlags: ULONG read FdwFlags write FdwFlags;
  end;
  
  WSACMSGHDRWrapper = class(TatRecordWrapper)
  private
    Fcmsg_len: Integer;
    Fcmsg_level: Integer;
    Fcmsg_type: Integer;
  public
    constructor Create(ARecord: WSACMSGHDR);
    function ObjToRec: WSACMSGHDR;
  published
    property cmsg_len: Integer read Fcmsg_len write Fcmsg_len;
    property cmsg_level: Integer read Fcmsg_level write Fcmsg_level;
    property cmsg_type: Integer read Fcmsg_type write Fcmsg_type;
  end;
  
  WSAPOLLFDWrapper = class(TatRecordWrapper)
  private
    Ffd: TSocket;
    Fevents: Shortint;
    Frevents: Shortint;
  public
    constructor Create(ARecord: WSAPOLLFD);
    function ObjToRec: WSAPOLLFD;
  published
    property fd: TSocket read Ffd write Ffd;
    property events: Shortint read Fevents write Fevents;
    property revents: Shortint read Frevents write Frevents;
  end;
  

implementation

constructor fd_setWrapper.Create(ARecord: fd_set);
begin
  inherited Create;
  Ffd_count := ARecord.fd_count;
end;

function fd_setWrapper.ObjToRec: fd_set;
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

constructor SunCWrapper.Create(ARecord: SunC);
begin
  inherited Create;
  Fs_c1 := ARecord.s_c1;
  Fs_c2 := ARecord.s_c2;
  Fs_c3 := ARecord.s_c3;
  Fs_c4 := ARecord.s_c4;
end;

function SunCWrapper.ObjToRec: SunC;
begin
  result.s_c1 := Fs_c1;
  result.s_c2 := Fs_c2;
  result.s_c3 := Fs_c3;
  result.s_c4 := Fs_c4;
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
end;

function sockaddr_inWrapper.ObjToRec: sockaddr_in;
begin
  result.sin_family := Fsin_family;
  result.sin_port := Fsin_port;
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

constructor sockaddrWrapper.Create(ARecord: sockaddr);
begin
  inherited Create;
  Fsa_family := ARecord.sa_family;
end;

function sockaddrWrapper.ObjToRec: sockaddr;
begin
  result.sa_family := Fsa_family;
end;

constructor sockaddr_storageWrapper.Create(ARecord: sockaddr_storage);
begin
  inherited Create;
  Fss_family := ARecord.ss_family;
  F__ss_align := ARecord.__ss_align;
end;

function sockaddr_storageWrapper.ObjToRec: sockaddr_storage;
begin
  result.ss_family := Fss_family;
  result.__ss_align := F__ss_align;
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

constructor _WSABUFWrapper.Create(ARecord: _WSABUF);
begin
  inherited Create;
  Flen := ARecord.len;
end;

function _WSABUFWrapper.ObjToRec: _WSABUF;
begin
  result.len := Flen;
end;

constructor _QualityOfServiceWrapper.Create(ARecord: _QualityOfService);
begin
  inherited Create;
end;

function _QualityOfServiceWrapper.ObjToRec: _QualityOfService;
begin
end;

constructor _WSANETWORKEVENTSWrapper.Create(ARecord: _WSANETWORKEVENTS);
begin
  inherited Create;
  FlNetworkEvents := ARecord.lNetworkEvents;
end;

function _WSANETWORKEVENTSWrapper.ObjToRec: _WSANETWORKEVENTS;
begin
  result.lNetworkEvents := FlNetworkEvents;
end;

constructor _WSAPROTOCOLCHAINWrapper.Create(ARecord: _WSAPROTOCOLCHAIN);
begin
  inherited Create;
  FChainLen := ARecord.ChainLen;
end;

function _WSAPROTOCOLCHAINWrapper.ObjToRec: _WSAPROTOCOLCHAIN;
begin
  result.ChainLen := FChainLen;
end;

constructor _WSAPROTOCOL_INFOAWrapper.Create(ARecord: _WSAPROTOCOL_INFOA);
begin
  inherited Create;
  FdwServiceFlags1 := ARecord.dwServiceFlags1;
  FdwServiceFlags2 := ARecord.dwServiceFlags2;
  FdwServiceFlags3 := ARecord.dwServiceFlags3;
  FdwServiceFlags4 := ARecord.dwServiceFlags4;
  FdwProviderFlags := ARecord.dwProviderFlags;
  FProviderId := ARecord.ProviderId;
  FdwCatalogEntryId := ARecord.dwCatalogEntryId;
  FiVersion := ARecord.iVersion;
  FiAddressFamily := ARecord.iAddressFamily;
  FiMaxSockAddr := ARecord.iMaxSockAddr;
  FiMinSockAddr := ARecord.iMinSockAddr;
  FiSocketType := ARecord.iSocketType;
  FiProtocol := ARecord.iProtocol;
  FiProtocolMaxOffset := ARecord.iProtocolMaxOffset;
  FiNetworkByteOrder := ARecord.iNetworkByteOrder;
  FiSecurityScheme := ARecord.iSecurityScheme;
  FdwMessageSize := ARecord.dwMessageSize;
  FdwProviderReserved := ARecord.dwProviderReserved;
end;

function _WSAPROTOCOL_INFOAWrapper.ObjToRec: _WSAPROTOCOL_INFOA;
begin
  result.dwServiceFlags1 := FdwServiceFlags1;
  result.dwServiceFlags2 := FdwServiceFlags2;
  result.dwServiceFlags3 := FdwServiceFlags3;
  result.dwServiceFlags4 := FdwServiceFlags4;
  result.dwProviderFlags := FdwProviderFlags;
  result.ProviderId := FProviderId;
  result.dwCatalogEntryId := FdwCatalogEntryId;
  result.iVersion := FiVersion;
  result.iAddressFamily := FiAddressFamily;
  result.iMaxSockAddr := FiMaxSockAddr;
  result.iMinSockAddr := FiMinSockAddr;
  result.iSocketType := FiSocketType;
  result.iProtocol := FiProtocol;
  result.iProtocolMaxOffset := FiProtocolMaxOffset;
  result.iNetworkByteOrder := FiNetworkByteOrder;
  result.iSecurityScheme := FiSecurityScheme;
  result.dwMessageSize := FdwMessageSize;
  result.dwProviderReserved := FdwProviderReserved;
end;

constructor _WSAPROTOCOL_INFOWWrapper.Create(ARecord: _WSAPROTOCOL_INFOW);
begin
  inherited Create;
  FdwServiceFlags1 := ARecord.dwServiceFlags1;
  FdwServiceFlags2 := ARecord.dwServiceFlags2;
  FdwServiceFlags3 := ARecord.dwServiceFlags3;
  FdwServiceFlags4 := ARecord.dwServiceFlags4;
  FdwProviderFlags := ARecord.dwProviderFlags;
  FProviderId := ARecord.ProviderId;
  FdwCatalogEntryId := ARecord.dwCatalogEntryId;
  FiVersion := ARecord.iVersion;
  FiAddressFamily := ARecord.iAddressFamily;
  FiMaxSockAddr := ARecord.iMaxSockAddr;
  FiMinSockAddr := ARecord.iMinSockAddr;
  FiSocketType := ARecord.iSocketType;
  FiProtocol := ARecord.iProtocol;
  FiProtocolMaxOffset := ARecord.iProtocolMaxOffset;
  FiNetworkByteOrder := ARecord.iNetworkByteOrder;
  FiSecurityScheme := ARecord.iSecurityScheme;
  FdwMessageSize := ARecord.dwMessageSize;
  FdwProviderReserved := ARecord.dwProviderReserved;
end;

function _WSAPROTOCOL_INFOWWrapper.ObjToRec: _WSAPROTOCOL_INFOW;
begin
  result.dwServiceFlags1 := FdwServiceFlags1;
  result.dwServiceFlags2 := FdwServiceFlags2;
  result.dwServiceFlags3 := FdwServiceFlags3;
  result.dwServiceFlags4 := FdwServiceFlags4;
  result.dwProviderFlags := FdwProviderFlags;
  result.ProviderId := FProviderId;
  result.dwCatalogEntryId := FdwCatalogEntryId;
  result.iVersion := FiVersion;
  result.iAddressFamily := FiAddressFamily;
  result.iMaxSockAddr := FiMaxSockAddr;
  result.iMinSockAddr := FiMinSockAddr;
  result.iSocketType := FiSocketType;
  result.iProtocol := FiProtocol;
  result.iProtocolMaxOffset := FiProtocolMaxOffset;
  result.iNetworkByteOrder := FiNetworkByteOrder;
  result.iSecurityScheme := FiSecurityScheme;
  result.dwMessageSize := FdwMessageSize;
  result.dwProviderReserved := FdwProviderReserved;
end;

constructor _WSACOMPLETIONWrapper.Create(ARecord: _WSACOMPLETION);
begin
  inherited Create;
  FType_ := ARecord.Type_;
  FhWnd := ARecord.hWnd;
  FuMsg := ARecord.uMsg;
  Fcontext := ARecord.context;
  FhPort := ARecord.hPort;
  FKey := ARecord.Key;
end;

function _WSACOMPLETIONWrapper.ObjToRec: _WSACOMPLETION;
begin
  result.Type_ := FType_;
  result.hWnd := FhWnd;
  result.uMsg := FuMsg;
  result.context := Fcontext;
  result.hPort := FhPort;
  result.Key := FKey;
end;

constructor _SOCKET_ADDRESSWrapper.Create(ARecord: _SOCKET_ADDRESS);
begin
  inherited Create;
  FiSockaddrLength := ARecord.iSockaddrLength;
end;

function _SOCKET_ADDRESSWrapper.ObjToRec: _SOCKET_ADDRESS;
begin
  result.iSockaddrLength := FiSockaddrLength;
end;

constructor _CSADDR_INFOWrapper.Create(ARecord: _CSADDR_INFO);
begin
  inherited Create;
  FiSocketType := ARecord.iSocketType;
  FiProtocol := ARecord.iProtocol;
end;

function _CSADDR_INFOWrapper.ObjToRec: _CSADDR_INFO;
begin
  result.iSocketType := FiSocketType;
  result.iProtocol := FiProtocol;
end;

constructor _SOCKET_ADDRESS_LISTWrapper.Create(ARecord: _SOCKET_ADDRESS_LIST);
begin
  inherited Create;
  FiAddressCount := ARecord.iAddressCount;
end;

function _SOCKET_ADDRESS_LISTWrapper.ObjToRec: _SOCKET_ADDRESS_LIST;
begin
  result.iAddressCount := FiAddressCount;
end;

constructor _AFPROTOCOLSWrapper.Create(ARecord: _AFPROTOCOLS);
begin
  inherited Create;
  FiAddressFamily := ARecord.iAddressFamily;
  FiProtocol := ARecord.iProtocol;
end;

function _AFPROTOCOLSWrapper.ObjToRec: _AFPROTOCOLS;
begin
  result.iAddressFamily := FiAddressFamily;
  result.iProtocol := FiProtocol;
end;

constructor _WSAVersionWrapper.Create(ARecord: _WSAVersion);
begin
  inherited Create;
  FdwVersion := ARecord.dwVersion;
  FecHow := ARecord.ecHow;
end;

function _WSAVersionWrapper.ObjToRec: _WSAVersion;
begin
  result.dwVersion := FdwVersion;
  result.ecHow := FecHow;
end;

constructor _WSANSClassInfoAWrapper.Create(ARecord: _WSANSClassInfoA);
begin
  inherited Create;
  FdwNameSpace := ARecord.dwNameSpace;
  FdwValueType := ARecord.dwValueType;
  FdwValueSize := ARecord.dwValueSize;
end;

function _WSANSClassInfoAWrapper.ObjToRec: _WSANSClassInfoA;
begin
  result.dwNameSpace := FdwNameSpace;
  result.dwValueType := FdwValueType;
  result.dwValueSize := FdwValueSize;
end;

constructor _WSANSClassInfoWWrapper.Create(ARecord: _WSANSClassInfoW);
begin
  inherited Create;
  FdwNameSpace := ARecord.dwNameSpace;
  FdwValueType := ARecord.dwValueType;
  FdwValueSize := ARecord.dwValueSize;
end;

function _WSANSClassInfoWWrapper.ObjToRec: _WSANSClassInfoW;
begin
  result.dwNameSpace := FdwNameSpace;
  result.dwValueType := FdwValueType;
  result.dwValueSize := FdwValueSize;
end;

constructor _WSANAMESPACE_INFOAWrapper.Create(ARecord: _WSANAMESPACE_INFOA);
begin
  inherited Create;
  FNSProviderId := ARecord.NSProviderId;
  FdwNameSpace := ARecord.dwNameSpace;
  FfActive := ARecord.fActive;
  FdwVersion := ARecord.dwVersion;
end;

function _WSANAMESPACE_INFOAWrapper.ObjToRec: _WSANAMESPACE_INFOA;
begin
  result.NSProviderId := FNSProviderId;
  result.dwNameSpace := FdwNameSpace;
  result.fActive := FfActive;
  result.dwVersion := FdwVersion;
end;

constructor _WSANAMESPACE_INFOWWrapper.Create(ARecord: _WSANAMESPACE_INFOW);
begin
  inherited Create;
  FNSProviderId := ARecord.NSProviderId;
  FdwNameSpace := ARecord.dwNameSpace;
  FfActive := ARecord.fActive;
  FdwVersion := ARecord.dwVersion;
end;

function _WSANAMESPACE_INFOWWrapper.ObjToRec: _WSANAMESPACE_INFOW;
begin
  result.NSProviderId := FNSProviderId;
  result.dwNameSpace := FdwNameSpace;
  result.fActive := FfActive;
  result.dwVersion := FdwVersion;
end;

constructor _WSANAMESPACE_INFOEXAWrapper.Create(ARecord: _WSANAMESPACE_INFOEXA);
begin
  inherited Create;
  FNSProviderId := ARecord.NSProviderId;
  FdwNameSpace := ARecord.dwNameSpace;
  FfActive := ARecord.fActive;
  FdwVersion := ARecord.dwVersion;
end;

function _WSANAMESPACE_INFOEXAWrapper.ObjToRec: _WSANAMESPACE_INFOEXA;
begin
  result.NSProviderId := FNSProviderId;
  result.dwNameSpace := FdwNameSpace;
  result.fActive := FfActive;
  result.dwVersion := FdwVersion;
end;

constructor _WSANAMESPACE_INFOEXWWrapper.Create(ARecord: _WSANAMESPACE_INFOEXW);
begin
  inherited Create;
  FNSProviderId := ARecord.NSProviderId;
  FdwNameSpace := ARecord.dwNameSpace;
  FfActive := ARecord.fActive;
  FdwVersion := ARecord.dwVersion;
end;

function _WSANAMESPACE_INFOEXWWrapper.ObjToRec: _WSANAMESPACE_INFOEXW;
begin
  result.NSProviderId := FNSProviderId;
  result.dwNameSpace := FdwNameSpace;
  result.fActive := FfActive;
  result.dwVersion := FdwVersion;
end;

constructor WSAMSGWrapper.Create(ARecord: WSAMSG);
begin
  inherited Create;
  Fnamelen := ARecord.namelen;
  FdwBufferCount := ARecord.dwBufferCount;
  FdwFlags := ARecord.dwFlags;
end;

function WSAMSGWrapper.ObjToRec: WSAMSG;
begin
  result.namelen := Fnamelen;
  result.dwBufferCount := FdwBufferCount;
  result.dwFlags := FdwFlags;
end;

constructor WSACMSGHDRWrapper.Create(ARecord: WSACMSGHDR);
begin
  inherited Create;
  Fcmsg_len := ARecord.cmsg_len;
  Fcmsg_level := ARecord.cmsg_level;
  Fcmsg_type := ARecord.cmsg_type;
end;

function WSACMSGHDRWrapper.ObjToRec: WSACMSGHDR;
begin
  result.cmsg_len := Fcmsg_len;
  result.cmsg_level := Fcmsg_level;
  result.cmsg_type := Fcmsg_type;
end;

constructor WSAPOLLFDWrapper.Create(ARecord: WSAPOLLFD);
begin
  inherited Create;
  Ffd := ARecord.fd;
  Fevents := ARecord.events;
  Frevents := ARecord.revents;
end;

function WSAPOLLFDWrapper.ObjToRec: WSAPOLLFD;
begin
  result.fd := Ffd;
  result.events := Fevents;
  result.revents := Frevents;
end;



procedure TatWinsock2Library.____WSAFDIsSet(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TFDSet;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is fd_setWrapper) then 
  Param1Rec := fd_setWrapper.Create(Param1);
Param1 := fd_setWrapper(Param1Rec).ObjToRec;
AResult := Integer(Winsock2.__WSAFDIsSet(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(fd_setWrapper.Create(Param1)));
  end;
end;

procedure TatWinsock2Library.__FD_CLR(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TFdSet;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is fd_setWrapper) then 
  Param1Rec := fd_setWrapper.Create(Param1);
Param1 := fd_setWrapper(Param1Rec).ObjToRec;
    Winsock2.FD_CLR(VarToInteger(GetInputArg(0)),Param1);
    SetInputArg(1,integer(fd_setWrapper.Create(Param1)));
  end;
end;

procedure TatWinsock2Library.___FD_SET(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TFDSet;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is fd_setWrapper) then 
  Param1Rec := fd_setWrapper.Create(Param1);
Param1 := fd_setWrapper(Param1Rec).ObjToRec;
    Winsock2._FD_SET(VarToInteger(GetInputArg(0)),Param1);
    SetInputArg(1,integer(fd_setWrapper.Create(Param1)));
  end;
end;

procedure TatWinsock2Library.__FD_ZERO(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TFdSet;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is fd_setWrapper) then 
  Param0Rec := fd_setWrapper.Create(Param0);
Param0 := fd_setWrapper(Param0Rec).ObjToRec;
    Winsock2.FD_ZERO(Param0);
    SetInputArg(0,integer(fd_setWrapper.Create(Param0)));
  end;
end;

procedure TatWinsock2Library.__FD_ISSET(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TFdSet;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is fd_setWrapper) then 
  Param1Rec := fd_setWrapper.Create(Param1);
Param1 := fd_setWrapper(Param1Rec).ObjToRec;
AResult := Winsock2.FD_ISSET(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(fd_setWrapper.Create(Param1)));
  end;
end;

procedure TatWinsock2Library.__timerisset(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Winsock2.timerisset(timevalWrapper(integer(GetInputArg(0))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__timerclear(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TTimeVal;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is timevalWrapper) then 
  Param0Rec := timevalWrapper.Create(Param0);
Param0 := timevalWrapper(Param0Rec).ObjToRec;
    Winsock2.timerclear(Param0);
    SetInputArg(0,integer(timevalWrapper.Create(Param0)));
  end;
end;

procedure TatWinsock2Library.___IO(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Winsock2._IO(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.___IOR(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Winsock2._IOR(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.___IOW(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Winsock2._IOW(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__IN_CLASSA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Winsock2.IN_CLASSA(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__IN_CLASSB(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Winsock2.IN_CLASSB(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__IN_CLASSC(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Winsock2.IN_CLASSC(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__IN_CLASSD(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Winsock2.IN_CLASSD(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__IN_MULTICAST(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Winsock2.IN_MULTICAST(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__h_errno(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Winsock2.h_errno);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.___WSAIO(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Winsock2._WSAIO(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.___WSAIOR(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Winsock2._WSAIOR(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.___WSAIOW(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Winsock2._WSAIOW(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.___WSAIORW(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Winsock2._WSAIORW(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__bind(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TSockAddr;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is sockaddrWrapper) then 
  Param1Rec := sockaddrWrapper.Create(Param1);
Param1 := sockaddrWrapper(Param1Rec).ObjToRec;
AResult := Integer(Winsock2.bind(VarToInteger(GetInputArg(0)),Param1,VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(sockaddrWrapper.Create(Param1)));
  end;
end;

procedure TatWinsock2Library.__closesocket(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Winsock2.closesocket(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__connect(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TSockAddr;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is sockaddrWrapper) then 
  Param1Rec := sockaddrWrapper.Create(Param1);
Param1 := sockaddrWrapper(Param1Rec).ObjToRec;
AResult := Integer(Winsock2.connect(VarToInteger(GetInputArg(0)),Param1,VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(sockaddrWrapper.Create(Param1)));
  end;
end;

procedure TatWinsock2Library.__ioctlsocket(AMachine: TatVirtualMachine);
  var
  Param2: u_long;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(Winsock2.ioctlsocket(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatWinsock2Library.__getpeername(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TSockAddr;
  Param2: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is sockaddrWrapper) then 
  Param1Rec := sockaddrWrapper.Create(Param1);
Param1 := sockaddrWrapper(Param1Rec).ObjToRec;
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(Winsock2.getpeername(VarToInteger(GetInputArg(0)),Param1,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(sockaddrWrapper.Create(Param1)));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatWinsock2Library.__getsockname(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TSockAddr;
  Param2: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is sockaddrWrapper) then 
  Param1Rec := sockaddrWrapper.Create(Param1);
Param1 := sockaddrWrapper(Param1Rec).ObjToRec;
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(Winsock2.getsockname(VarToInteger(GetInputArg(0)),Param1,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(sockaddrWrapper.Create(Param1)));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatWinsock2Library.__getsockopt(AMachine: TatVirtualMachine);
  var
  Param4: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param4 := VarToInteger(GetInputArg(4));
AResult := Integer(Winsock2.getsockopt(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),PAnsiChar(VarToStr(GetInputArg(3))),Param4));
    ReturnOutputArg(AResult);
    SetInputArg(4,Integer(Param4));
  end;
end;

procedure TatWinsock2Library.__htonl(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Winsock2.htonl(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__htons(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Winsock2.htons(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__inet_addr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Winsock2.inet_addr(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__inet_ntoa(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := string(Winsock2.inet_ntoa(in_addrWrapper(integer(GetInputArg(0))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__listen(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Winsock2.listen(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__ntohl(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Winsock2.ntohl(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__ntohs(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Winsock2.ntohs(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__recv(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Winsock2.recv(VarToInteger(GetInputArg(0)),Param1,VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatWinsock2Library.__recvfrom(AMachine: TatVirtualMachine);
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
if not Assigned(Param4Rec) or not (Param4Rec is sockaddrWrapper) then 
  Param4Rec := sockaddrWrapper.Create(Param4);
Param4 := sockaddrWrapper(Param4Rec).ObjToRec;
Param5 := VarToInteger(GetInputArg(5));
AResult := Integer(Winsock2.recvfrom(VarToInteger(GetInputArg(0)),Param1,VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),Param4,Param5));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
    SetInputArg(4,integer(sockaddrWrapper.Create(Param4)));
    SetInputArg(5,Integer(Param5));
  end;
end;

procedure TatWinsock2Library.__send(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(Winsock2.send(VarToInteger(GetInputArg(0)),Param1,VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__setsockopt(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Winsock2.setsockopt(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),PAnsiChar(VarToStr(GetInputArg(3))),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__shutdown(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Winsock2.shutdown(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__socket(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Winsock2.socket(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__gethostname(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Winsock2.gethostname(PAnsiChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__WSAStartup(AMachine: TatVirtualMachine);
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
AResult := Integer(Winsock2.WSAStartup(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(WSADataWrapper.Create(Param1)));
  end;
end;

procedure TatWinsock2Library.__WSACleanup(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Winsock2.WSACleanup);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__WSASetLastError(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Winsock2.WSASetLastError(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatWinsock2Library.__WSAGetLastError(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Winsock2.WSAGetLastError);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__WSAIsBlocking(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Winsock2.WSAIsBlocking;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__WSAUnhookBlockingHook(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Winsock2.WSAUnhookBlockingHook);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__WSACancelBlockingCall(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Winsock2.WSACancelBlockingCall);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__WSAAsyncGetServByName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Winsock2.WSAAsyncGetServByName(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),PAnsiChar(VarToStr(GetInputArg(2))),PAnsiChar(VarToStr(GetInputArg(3))),PAnsiChar(VarToStr(GetInputArg(4))),VarToInteger(GetInputArg(5)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__WSAAsyncGetServByPort(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Winsock2.WSAAsyncGetServByPort(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),PAnsiChar(VarToStr(GetInputArg(3))),PAnsiChar(VarToStr(GetInputArg(4))),VarToInteger(GetInputArg(5)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__WSAAsyncGetProtoByName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Winsock2.WSAAsyncGetProtoByName(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),PAnsiChar(VarToStr(GetInputArg(2))),PAnsiChar(VarToStr(GetInputArg(3))),VarToInteger(GetInputArg(4)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__WSAAsyncGetProtoByNumber(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Winsock2.WSAAsyncGetProtoByNumber(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),PAnsiChar(VarToStr(GetInputArg(3))),VarToInteger(GetInputArg(4)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__WSAAsyncGetHostByName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Winsock2.WSAAsyncGetHostByName(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),PAnsiChar(VarToStr(GetInputArg(2))),PAnsiChar(VarToStr(GetInputArg(3))),VarToInteger(GetInputArg(4)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__WSAAsyncGetHostByAddr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Winsock2.WSAAsyncGetHostByAddr(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),PAnsiChar(VarToStr(GetInputArg(2))),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)),PAnsiChar(VarToStr(GetInputArg(5))),VarToInteger(GetInputArg(6)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__WSACancelAsyncRequest(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Winsock2.WSACancelAsyncRequest(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__WSAAsyncSelect(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Winsock2.WSAAsyncSelect(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__WSACloseEvent(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Winsock2.WSACloseEvent(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__WSACreateEvent(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Winsock2.WSACreateEvent;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__WSADuplicateSocketA(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: WSAPROTOCOL_INFOA;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is _WSAPROTOCOL_INFOAWrapper) then 
  Param2Rec := _WSAPROTOCOL_INFOAWrapper.Create(Param2);
Param2 := _WSAPROTOCOL_INFOAWrapper(Param2Rec).ObjToRec;
AResult := Integer(Winsock2.WSADuplicateSocketA(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(_WSAPROTOCOL_INFOAWrapper.Create(Param2)));
  end;
end;

procedure TatWinsock2Library.__WSADuplicateSocketW(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: WSAPROTOCOL_INFOW;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is _WSAPROTOCOL_INFOWWrapper) then 
  Param2Rec := _WSAPROTOCOL_INFOWWrapper.Create(Param2);
Param2 := _WSAPROTOCOL_INFOWWrapper(Param2Rec).ObjToRec;
AResult := Integer(Winsock2.WSADuplicateSocketW(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(_WSAPROTOCOL_INFOWWrapper.Create(Param2)));
  end;
end;

procedure TatWinsock2Library.__WSADuplicateSocket(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: WSAPROTOCOL_INFO;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is _WSAPROTOCOL_INFOAWrapper) then 
  Param2Rec := _WSAPROTOCOL_INFOWWrapper.Create(Param2);
Param2 := _WSAPROTOCOL_INFOWWrapper(Param2Rec).ObjToRec;
AResult := Integer(Winsock2.WSADuplicateSocket(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(_WSAPROTOCOL_INFOWWrapper.Create(Param2)));
  end;
end;

procedure TatWinsock2Library.__WSAEnumNetworkEvents(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: WSANETWORKEVENTS;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is _WSANETWORKEVENTSWrapper) then 
  Param2Rec := _WSANETWORKEVENTSWrapper.Create(Param2);
Param2 := _WSANETWORKEVENTSWrapper(Param2Rec).ObjToRec;
AResult := Integer(Winsock2.WSAEnumNetworkEvents(VarToInteger(GetInputArg(0)),GetInputArg(1),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(_WSANETWORKEVENTSWrapper.Create(Param2)));
  end;
end;

procedure TatWinsock2Library.__WSAEventSelect(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Winsock2.WSAEventSelect(VarToInteger(GetInputArg(0)),GetInputArg(1),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__WSAHtonl(AMachine: TatVirtualMachine);
  var
  Param2: u_long;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(Winsock2.WSAHtonl(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatWinsock2Library.__WSAHtons(AMachine: TatVirtualMachine);
  var
  Param2: u_short;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(Winsock2.WSAHtons(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatWinsock2Library.__WSANtohl(AMachine: TatVirtualMachine);
  var
  Param2: u_long;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(Winsock2.WSANtohl(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatWinsock2Library.__WSANtohs(AMachine: TatVirtualMachine);
  var
  Param2: u_short;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(Winsock2.WSANtohs(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatWinsock2Library.__WSAResetEvent(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Winsock2.WSAResetEvent(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__WSASetEvent(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Winsock2.WSASetEvent(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__WSALookupServiceEnd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Winsock2.WSALookupServiceEnd(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__WSARemoveServiceClass(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Winsock2.WSARemoveServiceClass(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__WSAGetServiceClassNameByClassIdA(AMachine: TatVirtualMachine);
  var
  Param2: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(Winsock2.WSAGetServiceClassNameByClassIdA(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,PAnsiChar(VarToStr(GetInputArg(1))),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatWinsock2Library.__WSAGetServiceClassNameByClassIdW(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param2: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(Winsock2.WSAGetServiceClassNameByClassIdW(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatWinsock2Library.__WSAGetServiceClassNameByClassId(AMachine: TatVirtualMachine);
  var
  Param2: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(Winsock2.WSAGetServiceClassNameByClassId(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,PChar(VarToStr(GetInputArg(1))),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatWinsock2Library.__WSAMAKEASYNCREPLY(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Winsock2.WSAMAKEASYNCREPLY(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__WSAMAKESELECTREPLY(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Winsock2.WSAMAKESELECTREPLY(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__WSAGETASYNCBUFLEN(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Winsock2.WSAGETASYNCBUFLEN(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__WSAGETASYNCERROR(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Winsock2.WSAGETASYNCERROR(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__WSAGETSELECTEVENT(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Winsock2.WSAGETSELECTEVENT(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.__WSAGETSELECTERROR(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Winsock2.WSAGETSELECTERROR(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsock2Library.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('__WSAFDIsSet',2,tkInteger,nil,____WSAFDIsSet,false,0).SetVarArgs([1]);
    DefineMethod('FD_CLR',2,tkNone,nil,__FD_CLR,false,0).SetVarArgs([1]);
    DefineMethod('_FD_SET',2,tkNone,nil,___FD_SET,false,0).SetVarArgs([1]);
    DefineMethod('FD_ZERO',1,tkNone,nil,__FD_ZERO,false,0).SetVarArgs([0]);
    DefineMethod('FD_ISSET',2,tkVariant,nil,__FD_ISSET,false,0).SetVarArgs([1]);
    DefineMethod('timerisset',1,tkVariant,nil,__timerisset,false,0);
    DefineMethod('timerclear',1,tkNone,nil,__timerclear,false,0).SetVarArgs([0]);
    DefineMethod('_IO',2,tkInteger,nil,___IO,false,0);
    DefineMethod('_IOR',3,tkInteger,nil,___IOR,false,0);
    DefineMethod('_IOW',3,tkInteger,nil,___IOW,false,0);
    DefineMethod('IN_CLASSA',1,tkVariant,nil,__IN_CLASSA,false,0);
    DefineMethod('IN_CLASSB',1,tkVariant,nil,__IN_CLASSB,false,0);
    DefineMethod('IN_CLASSC',1,tkVariant,nil,__IN_CLASSC,false,0);
    DefineMethod('IN_CLASSD',1,tkVariant,nil,__IN_CLASSD,false,0);
    DefineMethod('IN_MULTICAST',1,tkVariant,nil,__IN_MULTICAST,false,0);
    DefineMethod('h_errno',0,tkInteger,nil,__h_errno,false,0);
    DefineMethod('_WSAIO',2,tkInteger,nil,___WSAIO,false,0);
    DefineMethod('_WSAIOR',2,tkInteger,nil,___WSAIOR,false,0);
    DefineMethod('_WSAIOW',2,tkInteger,nil,___WSAIOW,false,0);
    DefineMethod('_WSAIORW',2,tkInteger,nil,___WSAIORW,false,0);
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
    DefineMethod('send',4,tkInteger,nil,__send,false,0);
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
    DefineMethod('WSAAsyncGetServByName',6,tkVariant,nil,__WSAAsyncGetServByName,false,0);
    DefineMethod('WSAAsyncGetServByPort',6,tkVariant,nil,__WSAAsyncGetServByPort,false,0);
    DefineMethod('WSAAsyncGetProtoByName',5,tkVariant,nil,__WSAAsyncGetProtoByName,false,0);
    DefineMethod('WSAAsyncGetProtoByNumber',5,tkVariant,nil,__WSAAsyncGetProtoByNumber,false,0);
    DefineMethod('WSAAsyncGetHostByName',5,tkVariant,nil,__WSAAsyncGetHostByName,false,0);
    DefineMethod('WSAAsyncGetHostByAddr',7,tkVariant,nil,__WSAAsyncGetHostByAddr,false,0);
    DefineMethod('WSACancelAsyncRequest',1,tkInteger,nil,__WSACancelAsyncRequest,false,0);
    DefineMethod('WSAAsyncSelect',4,tkInteger,nil,__WSAAsyncSelect,false,0);
    DefineMethod('WSACloseEvent',1,tkVariant,nil,__WSACloseEvent,false,0);
    DefineMethod('WSACreateEvent',0,tkVariant,nil,__WSACreateEvent,false,0);
    DefineMethod('WSADuplicateSocketA',3,tkInteger,nil,__WSADuplicateSocketA,false,0).SetVarArgs([2]);
    DefineMethod('WSADuplicateSocketW',3,tkInteger,nil,__WSADuplicateSocketW,false,0).SetVarArgs([2]);
    DefineMethod('WSADuplicateSocket',3,tkInteger,nil,__WSADuplicateSocket,false,0).SetVarArgs([2]);
    DefineMethod('WSAEnumNetworkEvents',3,tkInteger,nil,__WSAEnumNetworkEvents,false,0).SetVarArgs([2]);
    DefineMethod('WSAEventSelect',3,tkInteger,nil,__WSAEventSelect,false,0);
    DefineMethod('WSAHtonl',3,tkInteger,nil,__WSAHtonl,false,0).SetVarArgs([2]);
    DefineMethod('WSAHtons',3,tkInteger,nil,__WSAHtons,false,0).SetVarArgs([2]);
    DefineMethod('WSANtohl',3,tkInteger,nil,__WSANtohl,false,0).SetVarArgs([2]);
    DefineMethod('WSANtohs',3,tkInteger,nil,__WSANtohs,false,0).SetVarArgs([2]);
    DefineMethod('WSAResetEvent',1,tkVariant,nil,__WSAResetEvent,false,0);
    DefineMethod('WSASetEvent',1,tkVariant,nil,__WSASetEvent,false,0);
    DefineMethod('WSALookupServiceEnd',1,tkInteger,nil,__WSALookupServiceEnd,false,0);
    DefineMethod('WSARemoveServiceClass',1,tkInteger,nil,__WSARemoveServiceClass,false,0);
    DefineMethod('WSAGetServiceClassNameByClassIdA',3,tkInteger,nil,__WSAGetServiceClassNameByClassIdA,false,0).SetVarArgs([2]);
    DefineMethod('WSAGetServiceClassNameByClassIdW',3,tkInteger,nil,__WSAGetServiceClassNameByClassIdW,false,0).SetVarArgs([2]);
    DefineMethod('WSAGetServiceClassNameByClassId',3,tkInteger,nil,__WSAGetServiceClassNameByClassId,false,0).SetVarArgs([2]);
    DefineMethod('WSAMAKEASYNCREPLY',2,tkInteger,nil,__WSAMAKEASYNCREPLY,false,0);
    DefineMethod('WSAMAKESELECTREPLY',2,tkInteger,nil,__WSAMAKESELECTREPLY,false,0);
    DefineMethod('WSAGETASYNCBUFLEN',1,tkInteger,nil,__WSAGETASYNCBUFLEN,false,0);
    DefineMethod('WSAGETASYNCERROR',1,tkInteger,nil,__WSAGETASYNCERROR,false,0);
    DefineMethod('WSAGETSELECTEVENT',1,tkInteger,nil,__WSAGETSELECTEVENT,false,0);
    DefineMethod('WSAGETSELECTERROR',1,tkInteger,nil,__WSAGETSELECTERROR,false,0);
    AddConstant('NSP_NOTIFY_IMMEDIATELY',NSP_NOTIFY_IMMEDIATELY);
    AddConstant('NSP_NOTIFY_HWND',NSP_NOTIFY_HWND);
    AddConstant('NSP_NOTIFY_EVENT',NSP_NOTIFY_EVENT);
    AddConstant('NSP_NOTIFY_PORT',NSP_NOTIFY_PORT);
    AddConstant('NSP_NOTIFY_APC',NSP_NOTIFY_APC);
    AddConstant('COMP_EQUAL',COMP_EQUAL);
    AddConstant('COMP_NOTLESS',COMP_NOTLESS);
    AddConstant('RNRSERVICE_REGISTER',RNRSERVICE_REGISTER);
    AddConstant('RNRSERVICE_DEREGISTER',RNRSERVICE_DEREGISTER);
    AddConstant('RNRSERVICE_DELETE',RNRSERVICE_DELETE);
    AddConstant('WINSOCK_VERSION',WINSOCK_VERSION);
    AddConstant('FD_SETSIZE',FD_SETSIZE);
    AddConstant('IOCPARM_MASK',IOCPARM_MASK);
    AddConstant('IOC_VOID',IOC_VOID);
    AddConstant('IOC_OUT',IOC_OUT);
    AddConstant('IOC_IN',IOC_IN);
    AddConstant('IOC_INOUT',IOC_INOUT);
    AddConstant('FIONREAD',FIONREAD);
    AddConstant('FIONBIO',FIONBIO);
    AddConstant('FIOASYNC',FIOASYNC);
    AddConstant('SIOCSHIWAT',SIOCSHIWAT);
    AddConstant('SIOCGHIWAT',SIOCGHIWAT);
    AddConstant('SIOCSLOWAT',SIOCSLOWAT);
    AddConstant('SIOCGLOWAT',SIOCGLOWAT);
    AddConstant('SIOCATMARK',SIOCATMARK);
    AddConstant('IPPROTO_IP',IPPROTO_IP);
    AddConstant('IPPROTO_HOPOPTS',IPPROTO_HOPOPTS);
    AddConstant('IPPROTO_ICMP',IPPROTO_ICMP);
    AddConstant('IPPROTO_IGMP',IPPROTO_IGMP);
    AddConstant('IPPROTO_GGP',IPPROTO_GGP);
    AddConstant('IPPROTO_IPV4',IPPROTO_IPV4);
    AddConstant('IPPROTO_ST',IPPROTO_ST);
    AddConstant('IPPROTO_TCP',IPPROTO_TCP);
    AddConstant('IPPROTO_CBT',IPPROTO_CBT);
    AddConstant('IPPROTO_EGP',IPPROTO_EGP);
    AddConstant('IPPROTO_IGP',IPPROTO_IGP);
    AddConstant('IPPROTO_PUP',IPPROTO_PUP);
    AddConstant('IPPROTO_UDP',IPPROTO_UDP);
    AddConstant('IPPROTO_IDP',IPPROTO_IDP);
    AddConstant('IPPROTO_RDP',IPPROTO_RDP);
    AddConstant('IPPROTO_IPV6',IPPROTO_IPV6);
    AddConstant('IPPROTO_ROUTING',IPPROTO_ROUTING);
    AddConstant('IPPROTO_FRAGMENT',IPPROTO_FRAGMENT);
    AddConstant('IPPROTO_ESP',IPPROTO_ESP);
    AddConstant('IPPROTO_AH',IPPROTO_AH);
    AddConstant('IPPROTO_ICMPV6',IPPROTO_ICMPV6);
    AddConstant('IPPROTO_NONE',IPPROTO_NONE);
    AddConstant('IPPROTO_DSTOPTS',IPPROTO_DSTOPTS);
    AddConstant('IPPROTO_ND',IPPROTO_ND);
    AddConstant('IPPROTO_ICLFXBM',IPPROTO_ICLFXBM);
    AddConstant('IPPROTO_PIM',IPPROTO_PIM);
    AddConstant('IPPROTO_PGM',IPPROTO_PGM);
    AddConstant('IPPROTO_L2TP',IPPROTO_L2TP);
    AddConstant('IPPROTO_SCTP',IPPROTO_SCTP);
    AddConstant('IPPROTO_RAW',IPPROTO_RAW);
    AddConstant('IPPROTO_MAX',IPPROTO_MAX);
    AddConstant('IPPROTO_RESERVED_RAW',IPPROTO_RESERVED_RAW);
    AddConstant('IPPROTO_RESERVED_IPSEC',IPPROTO_RESERVED_IPSEC);
    AddConstant('IPPROTO_RESERVED_IPSECOFFLOAD',IPPROTO_RESERVED_IPSECOFFLOAD);
    AddConstant('IPPROTO_RESERVED_MAX',IPPROTO_RESERVED_MAX);
    AddConstant('IPPORT_TCPMUX',IPPORT_TCPMUX);
    AddConstant('IPPORT_ECHO',IPPORT_ECHO);
    AddConstant('IPPORT_DISCARD',IPPORT_DISCARD);
    AddConstant('IPPORT_SYSTAT',IPPORT_SYSTAT);
    AddConstant('IPPORT_DAYTIME',IPPORT_DAYTIME);
    AddConstant('IPPORT_NETSTAT',IPPORT_NETSTAT);
    AddConstant('IPPORT_QOTD',IPPORT_QOTD);
    AddConstant('IPPORT_MSP',IPPORT_MSP);
    AddConstant('IPPORT_CHARGEN',IPPORT_CHARGEN);
    AddConstant('IPPORT_FTP_DATA',IPPORT_FTP_DATA);
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
    AddConstant('IPPORT_POP3',IPPORT_POP3);
    AddConstant('IPPORT_NTP',IPPORT_NTP);
    AddConstant('IPPORT_EPMAP',IPPORT_EPMAP);
    AddConstant('IPPORT_NETBIOS_NS',IPPORT_NETBIOS_NS);
    AddConstant('IPPORT_NETBIOS_DGM',IPPORT_NETBIOS_DGM);
    AddConstant('IPPORT_NETBIOS_SSN',IPPORT_NETBIOS_SSN);
    AddConstant('IPPORT_IMAP',IPPORT_IMAP);
    AddConstant('IPPORT_SNMP',IPPORT_SNMP);
    AddConstant('IPPORT_SNMP_TRAP',IPPORT_SNMP_TRAP);
    AddConstant('IPPORT_IMAP3',IPPORT_IMAP3);
    AddConstant('IPPORT_LDAP',IPPORT_LDAP);
    AddConstant('IPPORT_HTTPS',IPPORT_HTTPS);
    AddConstant('IPPORT_MICROSOFT_DS',IPPORT_MICROSOFT_DS);
    AddConstant('IPPORT_EXECSERVER',IPPORT_EXECSERVER);
    AddConstant('IPPORT_LOGINSERVER',IPPORT_LOGINSERVER);
    AddConstant('IPPORT_CMDSERVER',IPPORT_CMDSERVER);
    AddConstant('IPPORT_EFSSERVER',IPPORT_EFSSERVER);
    AddConstant('IPPORT_BIFFUDP',IPPORT_BIFFUDP);
    AddConstant('IPPORT_WHOSERVER',IPPORT_WHOSERVER);
    AddConstant('IPPORT_ROUTESERVER',IPPORT_ROUTESERVER);
    AddConstant('IPPORT_RESERVED',IPPORT_RESERVED);
    AddConstant('IPPORT_REGISTERED_MIN',IPPORT_REGISTERED_MIN);
    AddConstant('IPPORT_REGISTERED_MAX',IPPORT_REGISTERED_MAX);
    AddConstant('IPPORT_DYNAMIC_MIN',IPPORT_DYNAMIC_MIN);
    AddConstant('IPPORT_DYNAMIC_MAX',IPPORT_DYNAMIC_MAX);
    AddConstant('IMPLINK_IP',IMPLINK_IP);
    AddConstant('IMPLINK_LOWEXPER',IMPLINK_LOWEXPER);
    AddConstant('IMPLINK_HIGHEXPER',IMPLINK_HIGHEXPER);
    AddConstant('IN_CLASSA_NET',IN_CLASSA_NET);
    AddConstant('IN_CLASSA_NSHIFT',IN_CLASSA_NSHIFT);
    AddConstant('IN_CLASSA_HOST',IN_CLASSA_HOST);
    AddConstant('IN_CLASSA_MAX',IN_CLASSA_MAX);
    AddConstant('IN_CLASSB_NET',IN_CLASSB_NET);
    AddConstant('IN_CLASSB_NSHIFT',IN_CLASSB_NSHIFT);
    AddConstant('IN_CLASSB_HOST',IN_CLASSB_HOST);
    AddConstant('IN_CLASSB_MAX',IN_CLASSB_MAX);
    AddConstant('IN_CLASSC_NET',IN_CLASSC_NET);
    AddConstant('IN_CLASSC_NSHIFT',IN_CLASSC_NSHIFT);
    AddConstant('IN_CLASSC_HOST',IN_CLASSC_HOST);
    AddConstant('IN_CLASSD_NET',IN_CLASSD_NET);
    AddConstant('IN_CLASSD_NSHIFT',IN_CLASSD_NSHIFT);
    AddConstant('IN_CLASSD_HOST',IN_CLASSD_HOST);
    AddConstant('INADDR_ANY',INADDR_ANY);
    AddConstant('INADDR_LOOPBACK',INADDR_LOOPBACK);
    AddConstant('INADDR_BROADCAST',INADDR_BROADCAST);
    AddConstant('INADDR_NONE',INADDR_NONE);
    AddConstant('ADDR_ANY',ADDR_ANY);
    AddConstant('WSADESCRIPTION_LEN',WSADESCRIPTION_LEN);
    AddConstant('WSASYS_STATUS_LEN',WSASYS_STATUS_LEN);
    AddConstant('INVALID_SOCKET',INVALID_SOCKET);
    AddConstant('SOCKET_ERROR',SOCKET_ERROR);
    AddConstant('FROM_PROTOCOL_INFO',FROM_PROTOCOL_INFO);
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
    AddConstant('SO_EXCLUSIVEADDRUSE',SO_EXCLUSIVEADDRUSE);
    AddConstant('SO_SNDBUF',SO_SNDBUF);
    AddConstant('SO_RCVBUF',SO_RCVBUF);
    AddConstant('SO_SNDLOWAT',SO_SNDLOWAT);
    AddConstant('SO_RCVLOWAT',SO_RCVLOWAT);
    AddConstant('SO_SNDTIMEO',SO_SNDTIMEO);
    AddConstant('SO_RCVTIMEO',SO_RCVTIMEO);
    AddConstant('SO_ERROR',SO_ERROR);
    AddConstant('SO_TYPE',SO_TYPE);
    AddConstant('SO_BSP_STATE',SO_BSP_STATE);
    AddConstant('SO_GROUP_ID',SO_GROUP_ID);
    AddConstant('SO_GROUP_PRIORITY',SO_GROUP_PRIORITY);
    AddConstant('SO_MAX_MSG_SIZE',SO_MAX_MSG_SIZE);
    AddConstant('SO_PROTOCOL_INFOA',SO_PROTOCOL_INFOA);
    AddConstant('SO_PROTOCOL_INFOW',SO_PROTOCOL_INFOW);
    AddConstant('SO_PROTOCOL_INFO',SO_PROTOCOL_INFO);
    AddConstant('PVD_CONFIG',PVD_CONFIG);
    AddConstant('SO_CONDITIONAL_ACCEPT',SO_CONDITIONAL_ACCEPT);
    AddConstant('SO_PAUSE_ACCEPT',SO_PAUSE_ACCEPT);
    AddConstant('SO_COMPARTMENT_ID',SO_COMPARTMENT_ID);
    AddConstant('SO_RANDOMIZE_PORT',SO_RANDOMIZE_PORT);
    AddConstant('SO_PORT_SCALABILITY',SO_PORT_SCALABILITY);
    AddConstant('WSK_SO_BASE',WSK_SO_BASE);
    AddConstant('TCP_NODELAY',TCP_NODELAY);
    AddConstant('AF_UNSPEC',AF_UNSPEC);
    AddConstant('AF_UNIX',AF_UNIX);
    AddConstant('AF_INET',AF_INET);
    AddConstant('AF_IMPLINK',AF_IMPLINK);
    AddConstant('AF_PUP',AF_PUP);
    AddConstant('AF_CHAOS',AF_CHAOS);
    AddConstant('AF_NS',AF_NS);
    AddConstant('AF_IPX',AF_IPX);
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
    AddConstant('AF_ATM',AF_ATM);
    AddConstant('AF_INET6',AF_INET6);
    AddConstant('AF_CLUSTER',AF_CLUSTER);
    AddConstant('AF_12844',AF_12844);
    AddConstant('AF_IRDA',AF_IRDA);
    AddConstant('AF_NETDES',AF_NETDES);
    AddConstant('AF_TCNPROCESS',AF_TCNPROCESS);
    AddConstant('AF_TCNMESSAGE',AF_TCNMESSAGE);
    AddConstant('AF_ICLFXBM',AF_ICLFXBM);
    AddConstant('AF_BTH',AF_BTH);
    AddConstant('AF_LINK',AF_LINK);
    AddConstant('AF_MAX',AF_MAX);
    AddConstant('_SS_MAXSIZE',_SS_MAXSIZE);
    AddConstant('_SS_ALIGNSIZE',_SS_ALIGNSIZE);
    AddConstant('_SS_PAD1SIZE',_SS_PAD1SIZE);
    AddConstant('_SS_PAD2SIZE',_SS_PAD2SIZE);
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
    AddConstant('PF_ATM',PF_ATM);
    AddConstant('PF_INET6',PF_INET6);
    AddConstant('PF_BTH',PF_BTH);
    AddConstant('PF_MAX',PF_MAX);
    AddConstant('SOL_SOCKET',SOL_SOCKET);
    AddConstant('SOMAXCONN',SOMAXCONN);
    AddConstant('MSG_OOB',MSG_OOB);
    AddConstant('MSG_PEEK',MSG_PEEK);
    AddConstant('MSG_DONTROUTE',MSG_DONTROUTE);
    AddConstant('MSG_WAITALL',MSG_WAITALL);
    AddConstant('MSG_PARTIAL',MSG_PARTIAL);
    AddConstant('MSG_INTERRUPT',MSG_INTERRUPT);
    AddConstant('MSG_MAXIOVLEN',MSG_MAXIOVLEN);
    AddConstant('MAXGETHOSTSTRUCT',MAXGETHOSTSTRUCT);
    AddConstant('FD_READ_BIT',FD_READ_BIT);
    AddConstant('FD_READ',FD_READ);
    AddConstant('FD_WRITE_BIT',FD_WRITE_BIT);
    AddConstant('FD_WRITE',FD_WRITE);
    AddConstant('FD_OOB_BIT',FD_OOB_BIT);
    AddConstant('FD_OOB',FD_OOB);
    AddConstant('FD_ACCEPT_BIT',FD_ACCEPT_BIT);
    AddConstant('FD_ACCEPT',FD_ACCEPT);
    AddConstant('FD_CONNECT_BIT',FD_CONNECT_BIT);
    AddConstant('FD_CONNECT',FD_CONNECT);
    AddConstant('FD_CLOSE_BIT',FD_CLOSE_BIT);
    AddConstant('FD_CLOSE',FD_CLOSE);
    AddConstant('FD_QOS_BIT',FD_QOS_BIT);
    AddConstant('FD_QOS',FD_QOS);
    AddConstant('FD_GROUP_QOS_BIT',FD_GROUP_QOS_BIT);
    AddConstant('FD_GROUP_QOS',FD_GROUP_QOS);
    AddConstant('FD_ROUTING_INTERFACE_CHANGE_BIT',FD_ROUTING_INTERFACE_CHANGE_BIT);
    AddConstant('FD_ROUTING_INTERFACE_CHANGE',FD_ROUTING_INTERFACE_CHANGE);
    AddConstant('FD_ADDRESS_LIST_CHANGE_BIT',FD_ADDRESS_LIST_CHANGE_BIT);
    AddConstant('FD_ADDRESS_LIST_CHANGE',FD_ADDRESS_LIST_CHANGE);
    AddConstant('FD_MAX_EVENTS',FD_MAX_EVENTS);
    AddConstant('FD_ALL_EVENTS',FD_ALL_EVENTS);
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
    AddConstant('WSASYSNOTREADY',WSASYSNOTREADY);
    AddConstant('WSAVERNOTSUPPORTED',WSAVERNOTSUPPORTED);
    AddConstant('WSANOTINITIALISED',WSANOTINITIALISED);
    AddConstant('WSAEDISCON',WSAEDISCON);
    AddConstant('WSAENOMORE',WSAENOMORE);
    AddConstant('WSAECANCELLED',WSAECANCELLED);
    AddConstant('WSAEINVALIDPROCTABLE',WSAEINVALIDPROCTABLE);
    AddConstant('WSAEINVALIDPROVIDER',WSAEINVALIDPROVIDER);
    AddConstant('WSAEPROVIDERFAILEDINIT',WSAEPROVIDERFAILEDINIT);
    AddConstant('WSASYSCALLFAILURE',WSASYSCALLFAILURE);
    AddConstant('WSASERVICE_NOT_FOUND',WSASERVICE_NOT_FOUND);
    AddConstant('WSATYPE_NOT_FOUND',WSATYPE_NOT_FOUND);
    AddConstant('WSA_E_NO_MORE',WSA_E_NO_MORE);
    AddConstant('WSA_E_CANCELLED',WSA_E_CANCELLED);
    AddConstant('WSAEREFUSED',WSAEREFUSED);
    AddConstant('WSAHOST_NOT_FOUND',WSAHOST_NOT_FOUND);
    AddConstant('WSATRY_AGAIN',WSATRY_AGAIN);
    AddConstant('WSANO_RECOVERY',WSANO_RECOVERY);
    AddConstant('WSANO_DATA',WSANO_DATA);
    AddConstant('WSA_QOS_RECEIVERS',WSA_QOS_RECEIVERS);
    AddConstant('WSA_QOS_SENDERS',WSA_QOS_SENDERS);
    AddConstant('WSA_QOS_NO_SENDERS',WSA_QOS_NO_SENDERS);
    AddConstant('WSA_QOS_NO_RECEIVERS',WSA_QOS_NO_RECEIVERS);
    AddConstant('WSA_QOS_REQUEST_CONFIRMED',WSA_QOS_REQUEST_CONFIRMED);
    AddConstant('WSA_QOS_ADMISSION_FAILURE',WSA_QOS_ADMISSION_FAILURE);
    AddConstant('WSA_QOS_POLICY_FAILURE',WSA_QOS_POLICY_FAILURE);
    AddConstant('WSA_QOS_BAD_STYLE',WSA_QOS_BAD_STYLE);
    AddConstant('WSA_QOS_BAD_OBJECT',WSA_QOS_BAD_OBJECT);
    AddConstant('WSA_QOS_TRAFFIC_CTRL_ERROR',WSA_QOS_TRAFFIC_CTRL_ERROR);
    AddConstant('WSA_QOS_GENERIC_ERROR',WSA_QOS_GENERIC_ERROR);
    AddConstant('WSA_QOS_ESERVICETYPE',WSA_QOS_ESERVICETYPE);
    AddConstant('WSA_QOS_EFLOWSPEC',WSA_QOS_EFLOWSPEC);
    AddConstant('WSA_QOS_EPROVSPECBUF',WSA_QOS_EPROVSPECBUF);
    AddConstant('WSA_QOS_EFILTERSTYLE',WSA_QOS_EFILTERSTYLE);
    AddConstant('WSA_QOS_EFILTERTYPE',WSA_QOS_EFILTERTYPE);
    AddConstant('WSA_QOS_EFILTERCOUNT',WSA_QOS_EFILTERCOUNT);
    AddConstant('WSA_QOS_EOBJLENGTH',WSA_QOS_EOBJLENGTH);
    AddConstant('WSA_QOS_EFLOWCOUNT',WSA_QOS_EFLOWCOUNT);
    AddConstant('WSA_QOS_EUNKOWNPSOBJ',WSA_QOS_EUNKOWNPSOBJ);
    AddConstant('WSA_QOS_EPOLICYOBJ',WSA_QOS_EPOLICYOBJ);
    AddConstant('WSA_QOS_EFLOWDESC',WSA_QOS_EFLOWDESC);
    AddConstant('WSA_QOS_EPSFLOWSPEC',WSA_QOS_EPSFLOWSPEC);
    AddConstant('WSA_QOS_EPSFILTERSPEC',WSA_QOS_EPSFILTERSPEC);
    AddConstant('WSA_QOS_ESDMODEOBJ',WSA_QOS_ESDMODEOBJ);
    AddConstant('WSA_QOS_ESHAPERATEOBJ',WSA_QOS_ESHAPERATEOBJ);
    AddConstant('WSA_QOS_RESERVED_PETYPE',WSA_QOS_RESERVED_PETYPE);
    AddConstant('HOST_NOT_FOUND',HOST_NOT_FOUND);
    AddConstant('TRY_AGAIN',TRY_AGAIN);
    AddConstant('NO_RECOVERY',NO_RECOVERY);
    AddConstant('NO_DATA',NO_DATA);
    AddConstant('WSANO_ADDRESS',WSANO_ADDRESS);
    AddConstant('NO_ADDRESS',NO_ADDRESS);
    AddConstant('WSA_IO_PENDING',WSA_IO_PENDING);
    AddConstant('WSA_IO_INCOMPLETE',WSA_IO_INCOMPLETE);
    AddConstant('WSA_INVALID_HANDLE',WSA_INVALID_HANDLE);
    AddConstant('WSA_INVALID_PARAMETER',WSA_INVALID_PARAMETER);
    AddConstant('WSA_NOT_ENOUGH_MEMORY',WSA_NOT_ENOUGH_MEMORY);
    AddConstant('WSA_OPERATION_ABORTED',WSA_OPERATION_ABORTED);
    AddConstant('WSA_INVALID_EVENT',WSA_INVALID_EVENT);
    AddConstant('WSA_MAXIMUM_WAIT_EVENTS',WSA_MAXIMUM_WAIT_EVENTS);
    AddConstant('WSA_WAIT_FAILED',WSA_WAIT_FAILED);
    AddConstant('WSA_WAIT_EVENT_0',WSA_WAIT_EVENT_0);
    AddConstant('WSA_WAIT_IO_COMPLETION',WSA_WAIT_IO_COMPLETION);
    AddConstant('WSA_WAIT_TIMEOUT',WSA_WAIT_TIMEOUT);
    AddConstant('WSA_INFINITE',WSA_INFINITE);
    AddConstant('CF_ACCEPT',CF_ACCEPT);
    AddConstant('CF_REJECT',CF_REJECT);
    AddConstant('CF_DEFER',CF_DEFER);
    AddConstant('SD_RECEIVE',SD_RECEIVE);
    AddConstant('SD_SEND',SD_SEND);
    AddConstant('SD_BOTH',SD_BOTH);
    AddConstant('SG_UNCONSTRAINED_GROUP',SG_UNCONSTRAINED_GROUP);
    AddConstant('SG_CONSTRAINED_GROUP',SG_CONSTRAINED_GROUP);
    AddConstant('MAX_PROTOCOL_CHAIN',MAX_PROTOCOL_CHAIN);
    AddConstant('BASE_PROTOCOL',BASE_PROTOCOL);
    AddConstant('LAYERED_PROTOCOL',LAYERED_PROTOCOL);
    AddConstant('WSAPROTOCOL_LEN',WSAPROTOCOL_LEN);
    AddConstant('PFL_MULTIPLE_PROTO_ENTRIES',PFL_MULTIPLE_PROTO_ENTRIES);
    AddConstant('PFL_RECOMMENDED_PROTO_ENTRY',PFL_RECOMMENDED_PROTO_ENTRY);
    AddConstant('PFL_HIDDEN',PFL_HIDDEN);
    AddConstant('PFL_MATCHES_PROTOCOL_ZERO',PFL_MATCHES_PROTOCOL_ZERO);
    AddConstant('PFL_NETWORKDIRECT_PROVIDER',PFL_NETWORKDIRECT_PROVIDER);
    AddConstant('XP1_CONNECTIONLESS',XP1_CONNECTIONLESS);
    AddConstant('XP1_GUARANTEED_DELIVERY',XP1_GUARANTEED_DELIVERY);
    AddConstant('XP1_GUARANTEED_ORDER',XP1_GUARANTEED_ORDER);
    AddConstant('XP1_MESSAGE_ORIENTED',XP1_MESSAGE_ORIENTED);
    AddConstant('XP1_PSEUDO_STREAM',XP1_PSEUDO_STREAM);
    AddConstant('XP1_GRACEFUL_CLOSE',XP1_GRACEFUL_CLOSE);
    AddConstant('XP1_EXPEDITED_DATA',XP1_EXPEDITED_DATA);
    AddConstant('XP1_CONNECT_DATA',XP1_CONNECT_DATA);
    AddConstant('XP1_DISCONNECT_DATA',XP1_DISCONNECT_DATA);
    AddConstant('XP1_SUPPORT_BROADCAST',XP1_SUPPORT_BROADCAST);
    AddConstant('XP1_SUPPORT_MULTIPOINT',XP1_SUPPORT_MULTIPOINT);
    AddConstant('XP1_MULTIPOINT_CONTROL_PLANE',XP1_MULTIPOINT_CONTROL_PLANE);
    AddConstant('XP1_MULTIPOINT_DATA_PLANE',XP1_MULTIPOINT_DATA_PLANE);
    AddConstant('XP1_QOS_SUPPORTED',XP1_QOS_SUPPORTED);
    AddConstant('XP1_INTERRUPT',XP1_INTERRUPT);
    AddConstant('XP1_UNI_SEND',XP1_UNI_SEND);
    AddConstant('XP1_UNI_RECV',XP1_UNI_RECV);
    AddConstant('XP1_IFS_HANDLES',XP1_IFS_HANDLES);
    AddConstant('XP1_PARTIAL_MESSAGE',XP1_PARTIAL_MESSAGE);
    AddConstant('XP1_SAN_SUPPORT_SDP',XP1_SAN_SUPPORT_SDP);
    AddConstant('BIGENDIAN',BIGENDIAN);
    AddConstant('LITTLEENDIAN',LITTLEENDIAN);
    AddConstant('SECURITY_PROTOCOL_NONE',SECURITY_PROTOCOL_NONE);
    AddConstant('JL_SENDER_ONLY',JL_SENDER_ONLY);
    AddConstant('JL_RECEIVER_ONLY',JL_RECEIVER_ONLY);
    AddConstant('JL_BOTH',JL_BOTH);
    AddConstant('WSA_FLAG_OVERLAPPED',WSA_FLAG_OVERLAPPED);
    AddConstant('WSA_FLAG_MULTIPOINT_C_ROOT',WSA_FLAG_MULTIPOINT_C_ROOT);
    AddConstant('WSA_FLAG_MULTIPOINT_C_LEAF',WSA_FLAG_MULTIPOINT_C_LEAF);
    AddConstant('WSA_FLAG_MULTIPOINT_D_ROOT',WSA_FLAG_MULTIPOINT_D_ROOT);
    AddConstant('WSA_FLAG_MULTIPOINT_D_LEAF',WSA_FLAG_MULTIPOINT_D_LEAF);
    AddConstant('WSA_FLAG_ACCESS_SYSTEM_SECURITY',WSA_FLAG_ACCESS_SYSTEM_SECURITY);
    AddConstant('IOC_UNIX',IOC_UNIX);
    AddConstant('IOC_WS2',IOC_WS2);
    AddConstant('IOC_PROTOCOL',IOC_PROTOCOL);
    AddConstant('IOC_VENDOR',IOC_VENDOR);
    AddConstant('IOC_WSK',IOC_WSK);
    AddConstant('SIO_ASSOCIATE_HANDLE',SIO_ASSOCIATE_HANDLE);
    AddConstant('SIO_ENABLE_CIRCULAR_QUEUEING',SIO_ENABLE_CIRCULAR_QUEUEING);
    AddConstant('SIO_FIND_ROUTE',SIO_FIND_ROUTE);
    AddConstant('SIO_FLUSH',SIO_FLUSH);
    AddConstant('SIO_GET_BROADCAST_ADDRESS',SIO_GET_BROADCAST_ADDRESS);
    AddConstant('SIO_GET_EXTENSION_FUNCTION_POINTER',SIO_GET_EXTENSION_FUNCTION_POINTER);
    AddConstant('SIO_GET_QOS',SIO_GET_QOS);
    AddConstant('SIO_GET_GROUP_QOS',SIO_GET_GROUP_QOS);
    AddConstant('SIO_MULTIPOINT_LOOPBACK',SIO_MULTIPOINT_LOOPBACK);
    AddConstant('SIO_MULTICAST_SCOPE',SIO_MULTICAST_SCOPE);
    AddConstant('SIO_SET_QOS',SIO_SET_QOS);
    AddConstant('SIO_SET_GROUP_QOS',SIO_SET_GROUP_QOS);
    AddConstant('SIO_TRANSLATE_HANDLE',SIO_TRANSLATE_HANDLE);
    AddConstant('SIO_ROUTING_INTERFACE_QUERY',SIO_ROUTING_INTERFACE_QUERY);
    AddConstant('SIO_ROUTING_INTERFACE_CHANGE',SIO_ROUTING_INTERFACE_CHANGE);
    AddConstant('SIO_ADDRESS_LIST_QUERY',SIO_ADDRESS_LIST_QUERY);
    AddConstant('SIO_ADDRESS_LIST_CHANGE',SIO_ADDRESS_LIST_CHANGE);
    AddConstant('SIO_QUERY_TARGET_PNP_HANDLE',SIO_QUERY_TARGET_PNP_HANDLE);
    AddConstant('SIO_ADDRESS_LIST_SORT',SIO_ADDRESS_LIST_SORT);
    AddConstant('SIO_NSP_NOTIFY_CHANGE',SIO_NSP_NOTIFY_CHANGE);
    AddConstant('TH_NETDEV',TH_NETDEV);
    AddConstant('TH_TAPI',TH_TAPI);
    AddConstant('SERVICE_MULTIPLE',SERVICE_MULTIPLE);
    AddConstant('NS_ALL',NS_ALL);
    AddConstant('NS_SAP',NS_SAP);
    AddConstant('NS_NDS',NS_NDS);
    AddConstant('NS_PEER_BROWSE',NS_PEER_BROWSE);
    AddConstant('NS_SLP',NS_SLP);
    AddConstant('NS_DHCP',NS_DHCP);
    AddConstant('NS_TCPIP_LOCAL',NS_TCPIP_LOCAL);
    AddConstant('NS_TCPIP_HOSTS',NS_TCPIP_HOSTS);
    AddConstant('NS_DNS',NS_DNS);
    AddConstant('NS_NETBT',NS_NETBT);
    AddConstant('NS_WINS',NS_WINS);
    AddConstant('NS_NLA',NS_NLA);
    AddConstant('NS_BTH',NS_BTH);
    AddConstant('NS_NBP',NS_NBP);
    AddConstant('NS_MS',NS_MS);
    AddConstant('NS_STDA',NS_STDA);
    AddConstant('NS_NTDS',NS_NTDS);
    AddConstant('NS_EMAIL',NS_EMAIL);
    AddConstant('NS_PNRPNAME',NS_PNRPNAME);
    AddConstant('NS_PNRPCLOUD',NS_PNRPCLOUD);
    AddConstant('NS_X500',NS_X500);
    AddConstant('NS_NIS',NS_NIS);
    AddConstant('NS_NISPLUS',NS_NISPLUS);
    AddConstant('NS_WRQ',NS_WRQ);
    AddConstant('NS_NETDES',NS_NETDES);
    AddConstant('RES_UNUSED_1',RES_UNUSED_1);
    AddConstant('RES_FLUSH_CACHE',RES_FLUSH_CACHE);
    AddConstant('RES_SERVICE',RES_SERVICE);
    AddConstant('SERVICE_TYPE_VALUE_IPXPORTA',SERVICE_TYPE_VALUE_IPXPORTA);
    AddConstant('SERVICE_TYPE_VALUE_IPXPORTW',SERVICE_TYPE_VALUE_IPXPORTW);
    AddConstant('SERVICE_TYPE_VALUE_SAPIDA',SERVICE_TYPE_VALUE_SAPIDA);
    AddConstant('SERVICE_TYPE_VALUE_SAPIDW',SERVICE_TYPE_VALUE_SAPIDW);
    AddConstant('SERVICE_TYPE_VALUE_TCPPORTA',SERVICE_TYPE_VALUE_TCPPORTA);
    AddConstant('SERVICE_TYPE_VALUE_TCPPORTW',SERVICE_TYPE_VALUE_TCPPORTW);
    AddConstant('SERVICE_TYPE_VALUE_UDPPORTA',SERVICE_TYPE_VALUE_UDPPORTA);
    AddConstant('SERVICE_TYPE_VALUE_UDPPORTW',SERVICE_TYPE_VALUE_UDPPORTW);
    AddConstant('SERVICE_TYPE_VALUE_OBJECTIDA',SERVICE_TYPE_VALUE_OBJECTIDA);
    AddConstant('SERVICE_TYPE_VALUE_OBJECTIDW',SERVICE_TYPE_VALUE_OBJECTIDW);
    AddConstant('SERVICE_TYPE_VALUE_SAPID',SERVICE_TYPE_VALUE_SAPID);
    AddConstant('SERVICE_TYPE_VALUE_TCPPORT',SERVICE_TYPE_VALUE_TCPPORT);
    AddConstant('SERVICE_TYPE_VALUE_UDPPORT',SERVICE_TYPE_VALUE_UDPPORT);
    AddConstant('SERVICE_TYPE_VALUE_OBJECTID',SERVICE_TYPE_VALUE_OBJECTID);
    AddConstant('LUP_DEEP',LUP_DEEP);
    AddConstant('LUP_CONTAINERS',LUP_CONTAINERS);
    AddConstant('LUP_NOCONTAINERS',LUP_NOCONTAINERS);
    AddConstant('LUP_NEAREST',LUP_NEAREST);
    AddConstant('LUP_RETURN_NAME',LUP_RETURN_NAME);
    AddConstant('LUP_RETURN_TYPE',LUP_RETURN_TYPE);
    AddConstant('LUP_RETURN_VERSION',LUP_RETURN_VERSION);
    AddConstant('LUP_RETURN_COMMENT',LUP_RETURN_COMMENT);
    AddConstant('LUP_RETURN_ADDR',LUP_RETURN_ADDR);
    AddConstant('LUP_RETURN_BLOB',LUP_RETURN_BLOB);
    AddConstant('LUP_RETURN_ALIASES',LUP_RETURN_ALIASES);
    AddConstant('LUP_RETURN_QUERY_STRING',LUP_RETURN_QUERY_STRING);
    AddConstant('LUP_RETURN_ALL',LUP_RETURN_ALL);
    AddConstant('LUP_RES_SERVICE',LUP_RES_SERVICE);
    AddConstant('LUP_FLUSHCACHE',LUP_FLUSHCACHE);
    AddConstant('LUP_FLUSHPREVIOUS',LUP_FLUSHPREVIOUS);
    AddConstant('LUP_NON_AUTHORITATIVE',LUP_NON_AUTHORITATIVE);
    AddConstant('LUP_SECURE',LUP_SECURE);
    AddConstant('LUP_RETURN_PREFERRED_NAMES',LUP_RETURN_PREFERRED_NAMES);
    AddConstant('LUP_ADDRCONFIG',LUP_ADDRCONFIG);
    AddConstant('LUP_DUAL_ADDR',LUP_DUAL_ADDR);
    AddConstant('LUP_FILESERVER',LUP_FILESERVER);
    AddConstant('RESULT_IS_ALIAS',RESULT_IS_ALIAS);
    AddConstant('RESULT_IS_ADDED',RESULT_IS_ADDED);
    AddConstant('RESULT_IS_CHANGED',RESULT_IS_CHANGED);
    AddConstant('RESULT_IS_DELETED',RESULT_IS_DELETED);
    AddConstant('POLLRDNORM',POLLRDNORM);
    AddConstant('POLLRDBAND',POLLRDBAND);
    AddConstant('POLLIN',POLLIN);
    AddConstant('POLLPRI',POLLPRI);
    AddConstant('POLLWRNORM',POLLWRNORM);
    AddConstant('POLLOUT',POLLOUT);
    AddConstant('POLLWRBAND',POLLWRBAND);
    AddConstant('POLLERR',POLLERR);
    AddConstant('POLLHUP',POLLHUP);
    AddConstant('POLLNVAL',POLLNVAL);
  end;
end;

class function TatWinsock2Library.LibraryName: string;
begin
  result := 'Winsock2';
end;

initialization
  RegisterScripterLibrary(TatWinsock2Library, True);

{$WARNINGS ON}

end.

