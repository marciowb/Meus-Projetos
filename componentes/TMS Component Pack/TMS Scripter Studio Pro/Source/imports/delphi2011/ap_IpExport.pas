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
unit ap_IpExport;

interface

uses
  Types,
  Windows,
  IpExport,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatIpExportLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  IN6_ADDRWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: IN6_ADDR);
    function ObjToRec: IN6_ADDR;
  published
  end;
  
  in_addrWrapper = class(TatRecordWrapper)
  private
    Fs_b1: UCHAR;
    Fs_b2: UCHAR;
    Fs_b3: UCHAR;
    Fs_b4: UCHAR;
    Fs_w1: USHORT;
    Fs_w2: USHORT;
    FS_addr: ULONG;
  public
    constructor Create(ARecord: in_addr);
    function ObjToRec: in_addr;
  published
    property s_b1: UCHAR read Fs_b1 write Fs_b1;
    property s_b2: UCHAR read Fs_b2 write Fs_b2;
    property s_b3: UCHAR read Fs_b3 write Fs_b3;
    property s_b4: UCHAR read Fs_b4 write Fs_b4;
    property s_w1: USHORT read Fs_w1 write Fs_w1;
    property s_w2: USHORT read Fs_w2 write Fs_w2;
    property S_addr: ULONG read FS_addr write FS_addr;
  end;
  
  IP_OPTION_INFORMATIONWrapper = class(TatRecordWrapper)
  private
    FTtl: UCHAR;
    FTos: UCHAR;
    FFlags: UCHAR;
    FOptionsSize: UCHAR;
  public
    constructor Create(ARecord: IP_OPTION_INFORMATION);
    function ObjToRec: IP_OPTION_INFORMATION;
  published
    property Ttl: UCHAR read FTtl write FTtl;
    property Tos: UCHAR read FTos write FTos;
    property Flags: UCHAR read FFlags write FFlags;
    property OptionsSize: UCHAR read FOptionsSize write FOptionsSize;
  end;
  
  ICMP_ECHO_REPLYWrapper = class(TatRecordWrapper)
  private
    FAddress: IPAddr;
    FStatus: ULONG;
    FRoundTripTime: ULONG;
    FDataSize: USHORT;
    FReserved: USHORT;
  public
    constructor Create(ARecord: ICMP_ECHO_REPLY);
    function ObjToRec: ICMP_ECHO_REPLY;
  published
    property Address: IPAddr read FAddress write FAddress;
    property Status: ULONG read FStatus write FStatus;
    property RoundTripTime: ULONG read FRoundTripTime write FRoundTripTime;
    property DataSize: USHORT read FDataSize write FDataSize;
    property Reserved: USHORT read FReserved write FReserved;
  end;
  
  ARP_SEND_REPLYWrapper = class(TatRecordWrapper)
  private
    FDestAddress: IPAddr;
    FSrcAddress: IPAddr;
  public
    constructor Create(ARecord: ARP_SEND_REPLY);
    function ObjToRec: ARP_SEND_REPLY;
  published
    property DestAddress: IPAddr read FDestAddress write FDestAddress;
    property SrcAddress: IPAddr read FSrcAddress write FSrcAddress;
  end;
  
  TCP_RESERVE_PORT_RANGEWrapper = class(TatRecordWrapper)
  private
    FUpperRange: USHORT;
    FLowerRange: USHORT;
  public
    constructor Create(ARecord: TCP_RESERVE_PORT_RANGE);
    function ObjToRec: TCP_RESERVE_PORT_RANGE;
  published
    property UpperRange: USHORT read FUpperRange write FUpperRange;
    property LowerRange: USHORT read FLowerRange write FLowerRange;
  end;
  
  _IP_ADAPTER_INDEX_MAPWrapper = class(TatRecordWrapper)
  private
    FIndex: ULONG;
  public
    constructor Create(ARecord: _IP_ADAPTER_INDEX_MAP);
    function ObjToRec: _IP_ADAPTER_INDEX_MAP;
  published
    property Index: ULONG read FIndex write FIndex;
  end;
  
  _IP_INTERFACE_INFOWrapper = class(TatRecordWrapper)
  private
    FNumAdapters: Longint;
  public
    constructor Create(ARecord: _IP_INTERFACE_INFO);
    function ObjToRec: _IP_INTERFACE_INFO;
  published
    property NumAdapters: Longint read FNumAdapters write FNumAdapters;
  end;
  
  _IP_UNIDIRECTIONAL_ADAPTER_ADDRESSWrapper = class(TatRecordWrapper)
  private
    FNumAdapters: ULONG;
  public
    constructor Create(ARecord: _IP_UNIDIRECTIONAL_ADAPTER_ADDRESS);
    function ObjToRec: _IP_UNIDIRECTIONAL_ADAPTER_ADDRESS;
  published
    property NumAdapters: ULONG read FNumAdapters write FNumAdapters;
  end;
  
  _IP_ADAPTER_ORDER_MAPWrapper = class(TatRecordWrapper)
  private
    FNumAdapters: ULONG;
  public
    constructor Create(ARecord: _IP_ADAPTER_ORDER_MAP);
    function ObjToRec: _IP_ADAPTER_ORDER_MAP;
  published
    property NumAdapters: ULONG read FNumAdapters write FNumAdapters;
  end;
  
  _IP_MCAST_COUNTER_INFOWrapper = class(TatRecordWrapper)
  private
    FInMcastOctets: ULONG64;
    FOutMcastOctets: ULONG64;
    FInMcastPkts: ULONG64;
    FOutMcastPkts: ULONG64;
  public
    constructor Create(ARecord: _IP_MCAST_COUNTER_INFO);
    function ObjToRec: _IP_MCAST_COUNTER_INFO;
  published
    property InMcastOctets: ULONG64 read FInMcastOctets write FInMcastOctets;
    property OutMcastOctets: ULONG64 read FOutMcastOctets write FOutMcastOctets;
    property InMcastPkts: ULONG64 read FInMcastPkts write FInMcastPkts;
    property OutMcastPkts: ULONG64 read FOutMcastPkts write FOutMcastPkts;
  end;
  

implementation

constructor IN6_ADDRWrapper.Create(ARecord: IN6_ADDR);
begin
  inherited Create;
end;

function IN6_ADDRWrapper.ObjToRec: IN6_ADDR;
begin
end;

constructor in_addrWrapper.Create(ARecord: in_addr);
begin
  inherited Create;
  Fs_b1 := ARecord.s_b1;
  Fs_b2 := ARecord.s_b2;
  Fs_b3 := ARecord.s_b3;
  Fs_b4 := ARecord.s_b4;
  Fs_w1 := ARecord.s_w1;
  Fs_w2 := ARecord.s_w2;
  FS_addr := ARecord.S_addr;
end;

function in_addrWrapper.ObjToRec: in_addr;
begin
  result.s_b1 := Fs_b1;
  result.s_b2 := Fs_b2;
  result.s_b3 := Fs_b3;
  result.s_b4 := Fs_b4;
  result.s_w1 := Fs_w1;
  result.s_w2 := Fs_w2;
  result.S_addr := FS_addr;
end;

constructor IP_OPTION_INFORMATIONWrapper.Create(ARecord: IP_OPTION_INFORMATION);
begin
  inherited Create;
  FTtl := ARecord.Ttl;
  FTos := ARecord.Tos;
  FFlags := ARecord.Flags;
  FOptionsSize := ARecord.OptionsSize;
end;

function IP_OPTION_INFORMATIONWrapper.ObjToRec: IP_OPTION_INFORMATION;
begin
  result.Ttl := FTtl;
  result.Tos := FTos;
  result.Flags := FFlags;
  result.OptionsSize := FOptionsSize;
end;

constructor ICMP_ECHO_REPLYWrapper.Create(ARecord: ICMP_ECHO_REPLY);
begin
  inherited Create;
  FAddress := ARecord.Address;
  FStatus := ARecord.Status;
  FRoundTripTime := ARecord.RoundTripTime;
  FDataSize := ARecord.DataSize;
  FReserved := ARecord.Reserved;
end;

function ICMP_ECHO_REPLYWrapper.ObjToRec: ICMP_ECHO_REPLY;
begin
  result.Address := FAddress;
  result.Status := FStatus;
  result.RoundTripTime := FRoundTripTime;
  result.DataSize := FDataSize;
  result.Reserved := FReserved;
end;

constructor ARP_SEND_REPLYWrapper.Create(ARecord: ARP_SEND_REPLY);
begin
  inherited Create;
  FDestAddress := ARecord.DestAddress;
  FSrcAddress := ARecord.SrcAddress;
end;

function ARP_SEND_REPLYWrapper.ObjToRec: ARP_SEND_REPLY;
begin
  result.DestAddress := FDestAddress;
  result.SrcAddress := FSrcAddress;
end;

constructor TCP_RESERVE_PORT_RANGEWrapper.Create(ARecord: TCP_RESERVE_PORT_RANGE);
begin
  inherited Create;
  FUpperRange := ARecord.UpperRange;
  FLowerRange := ARecord.LowerRange;
end;

function TCP_RESERVE_PORT_RANGEWrapper.ObjToRec: TCP_RESERVE_PORT_RANGE;
begin
  result.UpperRange := FUpperRange;
  result.LowerRange := FLowerRange;
end;

constructor _IP_ADAPTER_INDEX_MAPWrapper.Create(ARecord: _IP_ADAPTER_INDEX_MAP);
begin
  inherited Create;
  FIndex := ARecord.Index;
end;

function _IP_ADAPTER_INDEX_MAPWrapper.ObjToRec: _IP_ADAPTER_INDEX_MAP;
begin
  result.Index := FIndex;
end;

constructor _IP_INTERFACE_INFOWrapper.Create(ARecord: _IP_INTERFACE_INFO);
begin
  inherited Create;
  FNumAdapters := ARecord.NumAdapters;
end;

function _IP_INTERFACE_INFOWrapper.ObjToRec: _IP_INTERFACE_INFO;
begin
  result.NumAdapters := FNumAdapters;
end;

constructor _IP_UNIDIRECTIONAL_ADAPTER_ADDRESSWrapper.Create(ARecord: _IP_UNIDIRECTIONAL_ADAPTER_ADDRESS);
begin
  inherited Create;
  FNumAdapters := ARecord.NumAdapters;
end;

function _IP_UNIDIRECTIONAL_ADAPTER_ADDRESSWrapper.ObjToRec: _IP_UNIDIRECTIONAL_ADAPTER_ADDRESS;
begin
  result.NumAdapters := FNumAdapters;
end;

constructor _IP_ADAPTER_ORDER_MAPWrapper.Create(ARecord: _IP_ADAPTER_ORDER_MAP);
begin
  inherited Create;
  FNumAdapters := ARecord.NumAdapters;
end;

function _IP_ADAPTER_ORDER_MAPWrapper.ObjToRec: _IP_ADAPTER_ORDER_MAP;
begin
  result.NumAdapters := FNumAdapters;
end;

constructor _IP_MCAST_COUNTER_INFOWrapper.Create(ARecord: _IP_MCAST_COUNTER_INFO);
begin
  inherited Create;
  FInMcastOctets := ARecord.InMcastOctets;
  FOutMcastOctets := ARecord.OutMcastOctets;
  FInMcastPkts := ARecord.InMcastPkts;
  FOutMcastPkts := ARecord.OutMcastPkts;
end;

function _IP_MCAST_COUNTER_INFOWrapper.ObjToRec: _IP_MCAST_COUNTER_INFO;
begin
  result.InMcastOctets := FInMcastOctets;
  result.OutMcastOctets := FOutMcastOctets;
  result.InMcastPkts := FInMcastPkts;
  result.OutMcastPkts := FOutMcastPkts;
end;



procedure TatIpExportLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('MAX_ADAPTER_NAME',MAX_ADAPTER_NAME);
    AddConstant('IP_STATUS_BASE',IP_STATUS_BASE);
    AddConstant('IP_SUCCESS',IP_SUCCESS);
    AddConstant('IP_BUF_TOO_SMALL',IP_BUF_TOO_SMALL);
    AddConstant('IP_DEST_NET_UNREACHABLE',IP_DEST_NET_UNREACHABLE);
    AddConstant('IP_DEST_HOST_UNREACHABLE',IP_DEST_HOST_UNREACHABLE);
    AddConstant('IP_DEST_PROT_UNREACHABLE',IP_DEST_PROT_UNREACHABLE);
    AddConstant('IP_DEST_PORT_UNREACHABLE',IP_DEST_PORT_UNREACHABLE);
    AddConstant('IP_NO_RESOURCES',IP_NO_RESOURCES);
    AddConstant('IP_BAD_OPTION',IP_BAD_OPTION);
    AddConstant('IP_HW_ERROR',IP_HW_ERROR);
    AddConstant('IP_PACKET_TOO_BIG',IP_PACKET_TOO_BIG);
    AddConstant('IP_REQ_TIMED_OUT',IP_REQ_TIMED_OUT);
    AddConstant('IP_BAD_REQ',IP_BAD_REQ);
    AddConstant('IP_BAD_ROUTE',IP_BAD_ROUTE);
    AddConstant('IP_TTL_EXPIRED_TRANSIT',IP_TTL_EXPIRED_TRANSIT);
    AddConstant('IP_TTL_EXPIRED_REASSEM',IP_TTL_EXPIRED_REASSEM);
    AddConstant('IP_PARAM_PROBLEM',IP_PARAM_PROBLEM);
    AddConstant('IP_SOURCE_QUENCH',IP_SOURCE_QUENCH);
    AddConstant('IP_OPTION_TOO_BIG',IP_OPTION_TOO_BIG);
    AddConstant('IP_BAD_DESTINATION',IP_BAD_DESTINATION);
    AddConstant('IP_DEST_NO_ROUTE',IP_DEST_NO_ROUTE);
    AddConstant('IP_DEST_ADDR_UNREACHABLE',IP_DEST_ADDR_UNREACHABLE);
    AddConstant('IP_DEST_PROHIBITED',IP_DEST_PROHIBITED);
    AddConstant('IP_HOP_LIMIT_EXCEEDED',IP_HOP_LIMIT_EXCEEDED);
    AddConstant('IP_REASSEMBLY_TIME_EXCEEDED',IP_REASSEMBLY_TIME_EXCEEDED);
    AddConstant('IP_PARAMETER_PROBLEM',IP_PARAMETER_PROBLEM);
    AddConstant('IP_DEST_UNREACHABLE',IP_DEST_UNREACHABLE);
    AddConstant('IP_TIME_EXCEEDED',IP_TIME_EXCEEDED);
    AddConstant('IP_BAD_HEADER',IP_BAD_HEADER);
    AddConstant('IP_UNRECOGNIZED_NEXT_HEADER',IP_UNRECOGNIZED_NEXT_HEADER);
    AddConstant('IP_ICMP_ERROR',IP_ICMP_ERROR);
    AddConstant('IP_DEST_SCOPE_MISMATCH',IP_DEST_SCOPE_MISMATCH);
    AddConstant('IP_ADDR_DELETED',IP_ADDR_DELETED);
    AddConstant('IP_SPEC_MTU_CHANGE',IP_SPEC_MTU_CHANGE);
    AddConstant('IP_MTU_CHANGE',IP_MTU_CHANGE);
    AddConstant('IP_UNLOAD',IP_UNLOAD);
    AddConstant('IP_ADDR_ADDED',IP_ADDR_ADDED);
    AddConstant('IP_MEDIA_CONNECT',IP_MEDIA_CONNECT);
    AddConstant('IP_MEDIA_DISCONNECT',IP_MEDIA_DISCONNECT);
    AddConstant('IP_BIND_ADAPTER',IP_BIND_ADAPTER);
    AddConstant('IP_UNBIND_ADAPTER',IP_UNBIND_ADAPTER);
    AddConstant('IP_DEVICE_DOES_NOT_EXIST',IP_DEVICE_DOES_NOT_EXIST);
    AddConstant('IP_DUPLICATE_ADDRESS',IP_DUPLICATE_ADDRESS);
    AddConstant('IP_INTERFACE_METRIC_CHANGE',IP_INTERFACE_METRIC_CHANGE);
    AddConstant('IP_RECONFIG_SECFLTR',IP_RECONFIG_SECFLTR);
    AddConstant('IP_NEGOTIATING_IPSEC',IP_NEGOTIATING_IPSEC);
    AddConstant('IP_INTERFACE_WOL_CAPABILITY_CHANGE',IP_INTERFACE_WOL_CAPABILITY_CHANGE);
    AddConstant('IP_DUPLICATE_IPADD',IP_DUPLICATE_IPADD);
    AddConstant('IP_GENERAL_FAILURE',IP_GENERAL_FAILURE);
    AddConstant('MAX_IP_STATUS',MAX_IP_STATUS);
    AddConstant('IP_PENDING',IP_PENDING);
    AddConstant('IP_FLAG_DF',IP_FLAG_DF);
    AddConstant('IP_OPT_EOL',IP_OPT_EOL);
    AddConstant('IP_OPT_NOP',IP_OPT_NOP);
    AddConstant('IP_OPT_SECURITY',IP_OPT_SECURITY);
    AddConstant('IP_OPT_LSRR',IP_OPT_LSRR);
    AddConstant('IP_OPT_SSRR',IP_OPT_SSRR);
    AddConstant('IP_OPT_RR',IP_OPT_RR);
    AddConstant('IP_OPT_TS',IP_OPT_TS);
    AddConstant('IP_OPT_SID',IP_OPT_SID);
    AddConstant('IP_OPT_ROUTER_ALERT',IP_OPT_ROUTER_ALERT);
    AddConstant('MAX_OPT_SIZE',MAX_OPT_SIZE);
    AddConstant('IOCTL_IP_RTCHANGE_NOTIFY_REQUEST',IOCTL_IP_RTCHANGE_NOTIFY_REQUEST);
    AddConstant('IOCTL_IP_ADDCHANGE_NOTIFY_REQUEST',IOCTL_IP_ADDCHANGE_NOTIFY_REQUEST);
    AddConstant('IOCTL_ARP_SEND_REQUEST',IOCTL_ARP_SEND_REQUEST);
    AddConstant('IOCTL_IP_INTERFACE_INFO',IOCTL_IP_INTERFACE_INFO);
    AddConstant('IOCTL_IP_GET_BEST_INTERFACE',IOCTL_IP_GET_BEST_INTERFACE);
    AddConstant('IOCTL_IP_UNIDIRECTIONAL_ADAPTER_ADDRESS',IOCTL_IP_UNIDIRECTIONAL_ADAPTER_ADDRESS);
  end;
end;

class function TatIpExportLibrary.LibraryName: string;
begin
  result := 'IpExport';
end;

initialization
  RegisterScripterLibrary(TatIpExportLibrary, True);

{$WARNINGS ON}

end.

