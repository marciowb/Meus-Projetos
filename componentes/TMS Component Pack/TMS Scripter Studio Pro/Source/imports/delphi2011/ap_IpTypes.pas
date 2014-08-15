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
unit ap_IpTypes;

interface

uses
  Windows,
  WinSock,
  IpTypes,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatIpTypesLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
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
  
  IP_ADDRESS_STRINGWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: IP_ADDRESS_STRING);
    function ObjToRec: IP_ADDRESS_STRING;
  published
  end;
  
  _IP_ADDR_STRINGWrapper = class(TatRecordWrapper)
  private
    FContext: DWORD;
  public
    constructor Create(ARecord: _IP_ADDR_STRING);
    function ObjToRec: _IP_ADDR_STRING;
  published
    property Context: DWORD read FContext write FContext;
  end;
  
  _IP_ADAPTER_INFOWrapper = class(TatRecordWrapper)
  private
    FComboIndex: DWORD;
    FAddressLength: UINT;
    FIndex: DWORD;
    FType_: UINT;
    FDhcpEnabled: UINT;
    FHaveWins: BOOL;
    FLeaseObtained: time_t;
    FLeaseExpires: time_t;
  public
    constructor Create(ARecord: _IP_ADAPTER_INFO);
    function ObjToRec: _IP_ADAPTER_INFO;
  published
    property ComboIndex: DWORD read FComboIndex write FComboIndex;
    property AddressLength: UINT read FAddressLength write FAddressLength;
    property Index: DWORD read FIndex write FIndex;
    property Type_: UINT read FType_ write FType_;
    property DhcpEnabled: UINT read FDhcpEnabled write FDhcpEnabled;
    property HaveWins: BOOL read FHaveWins write FHaveWins;
    property LeaseObtained: time_t read FLeaseObtained write FLeaseObtained;
    property LeaseExpires: time_t read FLeaseExpires write FLeaseExpires;
  end;
  
  _IP_ADAPTER_UNICAST_ADDRESSWrapper = class(TatRecordWrapper)
  private
    FPrefixOrigin: IP_PREFIX_ORIGIN;
    FSuffixOrigin: IP_SUFFIX_ORIGIN;
    FDadState: IP_DAD_STATE;
    FValidLifetime: ULONG;
    FPreferredLifetime: ULONG;
    FLeaseLifetime: ULONG;
  public
    constructor Create(ARecord: _IP_ADAPTER_UNICAST_ADDRESS);
    function ObjToRec: _IP_ADAPTER_UNICAST_ADDRESS;
  published
    property PrefixOrigin: IP_PREFIX_ORIGIN read FPrefixOrigin write FPrefixOrigin;
    property SuffixOrigin: IP_SUFFIX_ORIGIN read FSuffixOrigin write FSuffixOrigin;
    property DadState: IP_DAD_STATE read FDadState write FDadState;
    property ValidLifetime: ULONG read FValidLifetime write FValidLifetime;
    property PreferredLifetime: ULONG read FPreferredLifetime write FPreferredLifetime;
    property LeaseLifetime: ULONG read FLeaseLifetime write FLeaseLifetime;
  end;
  
  _IP_ADAPTER_ANYCAST_ADDRESSWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _IP_ADAPTER_ANYCAST_ADDRESS);
    function ObjToRec: _IP_ADAPTER_ANYCAST_ADDRESS;
  published
  end;
  
  _IP_ADAPTER_MULTICAST_ADDRESSWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _IP_ADAPTER_MULTICAST_ADDRESS);
    function ObjToRec: _IP_ADAPTER_MULTICAST_ADDRESS;
  published
  end;
  
  _IP_ADAPTER_DNS_SERVER_ADDRESSWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _IP_ADAPTER_DNS_SERVER_ADDRESS);
    function ObjToRec: _IP_ADAPTER_DNS_SERVER_ADDRESS;
  published
  end;
  
  _IP_ADAPTER_PREFIXWrapper = class(TatRecordWrapper)
  private
    FPrefixLength: ULONG;
  public
    constructor Create(ARecord: _IP_ADAPTER_PREFIX);
    function ObjToRec: _IP_ADAPTER_PREFIX;
  published
    property PrefixLength: ULONG read FPrefixLength write FPrefixLength;
  end;
  
  _IP_ADAPTER_ADDRESSESWrapper = class(TatRecordWrapper)
  private
    FPhysicalAddressLength: DWORD;
    FFlags: DWORD;
    FMtu: DWORD;
    FIfType: DWORD;
    FOperStatus: IF_OPER_STATUS;
    FIpv6IfIndex: DWORD;
  public
    constructor Create(ARecord: _IP_ADAPTER_ADDRESSES);
    function ObjToRec: _IP_ADAPTER_ADDRESSES;
  published
    property PhysicalAddressLength: DWORD read FPhysicalAddressLength write FPhysicalAddressLength;
    property Flags: DWORD read FFlags write FFlags;
    property Mtu: DWORD read FMtu write FMtu;
    property IfType: DWORD read FIfType write FIfType;
    property OperStatus: IF_OPER_STATUS read FOperStatus write FOperStatus;
    property Ipv6IfIndex: DWORD read FIpv6IfIndex write FIpv6IfIndex;
  end;
  
  _IP_PER_ADAPTER_INFOWrapper = class(TatRecordWrapper)
  private
    FAutoconfigEnabled: UINT;
    FAutoconfigActive: UINT;
  public
    constructor Create(ARecord: _IP_PER_ADAPTER_INFO);
    function ObjToRec: _IP_PER_ADAPTER_INFO;
  published
    property AutoconfigEnabled: UINT read FAutoconfigEnabled write FAutoconfigEnabled;
    property AutoconfigActive: UINT read FAutoconfigActive write FAutoconfigActive;
  end;
  
  FIXED_INFOWrapper = class(TatRecordWrapper)
  private
    FNodeType: UINT;
    FEnableRouting: UINT;
    FEnableProxy: UINT;
    FEnableDns: UINT;
  public
    constructor Create(ARecord: FIXED_INFO);
    function ObjToRec: FIXED_INFO;
  published
    property NodeType: UINT read FNodeType write FNodeType;
    property EnableRouting: UINT read FEnableRouting write FEnableRouting;
    property EnableProxy: UINT read FEnableProxy write FEnableProxy;
    property EnableDns: UINT read FEnableDns write FEnableDns;
  end;
  
  IP_INTERFACE_NAME_INFOWrapper = class(TatRecordWrapper)
  private
    FIndex: ULONG;
    FMediaType: ULONG;
    FConnectionType: UCHAR;
    FAccessType: UCHAR;
    FDeviceGuid: TGUID;
    FInterfaceGuid: TGUID;
  public
    constructor Create(ARecord: IP_INTERFACE_NAME_INFO);
    function ObjToRec: IP_INTERFACE_NAME_INFO;
  published
    property Index: ULONG read FIndex write FIndex;
    property MediaType: ULONG read FMediaType write FMediaType;
    property ConnectionType: UCHAR read FConnectionType write FConnectionType;
    property AccessType: UCHAR read FAccessType write FAccessType;
    property DeviceGuid: TGUID read FDeviceGuid write FDeviceGuid;
    property InterfaceGuid: TGUID read FInterfaceGuid write FInterfaceGuid;
  end;
  

implementation

constructor _SOCKET_ADDRESSWrapper.Create(ARecord: _SOCKET_ADDRESS);
begin
  inherited Create;
  FiSockaddrLength := ARecord.iSockaddrLength;
end;

function _SOCKET_ADDRESSWrapper.ObjToRec: _SOCKET_ADDRESS;
begin
  result.iSockaddrLength := FiSockaddrLength;
end;

constructor IP_ADDRESS_STRINGWrapper.Create(ARecord: IP_ADDRESS_STRING);
begin
  inherited Create;
end;

function IP_ADDRESS_STRINGWrapper.ObjToRec: IP_ADDRESS_STRING;
begin
end;

constructor _IP_ADDR_STRINGWrapper.Create(ARecord: _IP_ADDR_STRING);
begin
  inherited Create;
  FContext := ARecord.Context;
end;

function _IP_ADDR_STRINGWrapper.ObjToRec: _IP_ADDR_STRING;
begin
  result.Context := FContext;
end;

constructor _IP_ADAPTER_INFOWrapper.Create(ARecord: _IP_ADAPTER_INFO);
begin
  inherited Create;
  FComboIndex := ARecord.ComboIndex;
  FAddressLength := ARecord.AddressLength;
  FIndex := ARecord.Index;
  FType_ := ARecord.Type_;
  FDhcpEnabled := ARecord.DhcpEnabled;
  FHaveWins := ARecord.HaveWins;
  FLeaseObtained := ARecord.LeaseObtained;
  FLeaseExpires := ARecord.LeaseExpires;
end;

function _IP_ADAPTER_INFOWrapper.ObjToRec: _IP_ADAPTER_INFO;
begin
  result.ComboIndex := FComboIndex;
  result.AddressLength := FAddressLength;
  result.Index := FIndex;
  result.Type_ := FType_;
  result.DhcpEnabled := FDhcpEnabled;
  result.HaveWins := FHaveWins;
  result.LeaseObtained := FLeaseObtained;
  result.LeaseExpires := FLeaseExpires;
end;

constructor _IP_ADAPTER_UNICAST_ADDRESSWrapper.Create(ARecord: _IP_ADAPTER_UNICAST_ADDRESS);
begin
  inherited Create;
  FPrefixOrigin := ARecord.PrefixOrigin;
  FSuffixOrigin := ARecord.SuffixOrigin;
  FDadState := ARecord.DadState;
  FValidLifetime := ARecord.ValidLifetime;
  FPreferredLifetime := ARecord.PreferredLifetime;
  FLeaseLifetime := ARecord.LeaseLifetime;
end;

function _IP_ADAPTER_UNICAST_ADDRESSWrapper.ObjToRec: _IP_ADAPTER_UNICAST_ADDRESS;
begin
  result.PrefixOrigin := FPrefixOrigin;
  result.SuffixOrigin := FSuffixOrigin;
  result.DadState := FDadState;
  result.ValidLifetime := FValidLifetime;
  result.PreferredLifetime := FPreferredLifetime;
  result.LeaseLifetime := FLeaseLifetime;
end;

constructor _IP_ADAPTER_ANYCAST_ADDRESSWrapper.Create(ARecord: _IP_ADAPTER_ANYCAST_ADDRESS);
begin
  inherited Create;
end;

function _IP_ADAPTER_ANYCAST_ADDRESSWrapper.ObjToRec: _IP_ADAPTER_ANYCAST_ADDRESS;
begin
end;

constructor _IP_ADAPTER_MULTICAST_ADDRESSWrapper.Create(ARecord: _IP_ADAPTER_MULTICAST_ADDRESS);
begin
  inherited Create;
end;

function _IP_ADAPTER_MULTICAST_ADDRESSWrapper.ObjToRec: _IP_ADAPTER_MULTICAST_ADDRESS;
begin
end;

constructor _IP_ADAPTER_DNS_SERVER_ADDRESSWrapper.Create(ARecord: _IP_ADAPTER_DNS_SERVER_ADDRESS);
begin
  inherited Create;
end;

function _IP_ADAPTER_DNS_SERVER_ADDRESSWrapper.ObjToRec: _IP_ADAPTER_DNS_SERVER_ADDRESS;
begin
end;

constructor _IP_ADAPTER_PREFIXWrapper.Create(ARecord: _IP_ADAPTER_PREFIX);
begin
  inherited Create;
  FPrefixLength := ARecord.PrefixLength;
end;

function _IP_ADAPTER_PREFIXWrapper.ObjToRec: _IP_ADAPTER_PREFIX;
begin
  result.PrefixLength := FPrefixLength;
end;

constructor _IP_ADAPTER_ADDRESSESWrapper.Create(ARecord: _IP_ADAPTER_ADDRESSES);
begin
  inherited Create;
  FPhysicalAddressLength := ARecord.PhysicalAddressLength;
  FFlags := ARecord.Flags;
  FMtu := ARecord.Mtu;
  FIfType := ARecord.IfType;
  FOperStatus := ARecord.OperStatus;
  FIpv6IfIndex := ARecord.Ipv6IfIndex;
end;

function _IP_ADAPTER_ADDRESSESWrapper.ObjToRec: _IP_ADAPTER_ADDRESSES;
begin
  result.PhysicalAddressLength := FPhysicalAddressLength;
  result.Flags := FFlags;
  result.Mtu := FMtu;
  result.IfType := FIfType;
  result.OperStatus := FOperStatus;
  result.Ipv6IfIndex := FIpv6IfIndex;
end;

constructor _IP_PER_ADAPTER_INFOWrapper.Create(ARecord: _IP_PER_ADAPTER_INFO);
begin
  inherited Create;
  FAutoconfigEnabled := ARecord.AutoconfigEnabled;
  FAutoconfigActive := ARecord.AutoconfigActive;
end;

function _IP_PER_ADAPTER_INFOWrapper.ObjToRec: _IP_PER_ADAPTER_INFO;
begin
  result.AutoconfigEnabled := FAutoconfigEnabled;
  result.AutoconfigActive := FAutoconfigActive;
end;

constructor FIXED_INFOWrapper.Create(ARecord: FIXED_INFO);
begin
  inherited Create;
  FNodeType := ARecord.NodeType;
  FEnableRouting := ARecord.EnableRouting;
  FEnableProxy := ARecord.EnableProxy;
  FEnableDns := ARecord.EnableDns;
end;

function FIXED_INFOWrapper.ObjToRec: FIXED_INFO;
begin
  result.NodeType := FNodeType;
  result.EnableRouting := FEnableRouting;
  result.EnableProxy := FEnableProxy;
  result.EnableDns := FEnableDns;
end;

constructor IP_INTERFACE_NAME_INFOWrapper.Create(ARecord: IP_INTERFACE_NAME_INFO);
begin
  inherited Create;
  FIndex := ARecord.Index;
  FMediaType := ARecord.MediaType;
  FConnectionType := ARecord.ConnectionType;
  FAccessType := ARecord.AccessType;
  FDeviceGuid := ARecord.DeviceGuid;
  FInterfaceGuid := ARecord.InterfaceGuid;
end;

function IP_INTERFACE_NAME_INFOWrapper.ObjToRec: IP_INTERFACE_NAME_INFO;
begin
  result.Index := FIndex;
  result.MediaType := FMediaType;
  result.ConnectionType := FConnectionType;
  result.AccessType := FAccessType;
  result.DeviceGuid := FDeviceGuid;
  result.InterfaceGuid := FInterfaceGuid;
end;



procedure TatIpTypesLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('IpPrefixOriginOther',IpPrefixOriginOther);
    AddConstant('IpPrefixOriginManual',IpPrefixOriginManual);
    AddConstant('IpPrefixOriginWellKnown',IpPrefixOriginWellKnown);
    AddConstant('IpPrefixOriginDhcp',IpPrefixOriginDhcp);
    AddConstant('IpPrefixOriginRouterAdvertisement',IpPrefixOriginRouterAdvertisement);
    AddConstant('IpSuffixOriginOther',IpSuffixOriginOther);
    AddConstant('IpSuffixOriginManual',IpSuffixOriginManual);
    AddConstant('IpSuffixOriginWellKnown',IpSuffixOriginWellKnown);
    AddConstant('IpSuffixOriginDhcp',IpSuffixOriginDhcp);
    AddConstant('IpSuffixOriginLinkLayerAddress',IpSuffixOriginLinkLayerAddress);
    AddConstant('IpSuffixOriginRandom',IpSuffixOriginRandom);
    AddConstant('IpDadStateInvalid',IpDadStateInvalid);
    AddConstant('IpDadStateTentative',IpDadStateTentative);
    AddConstant('IpDadStateDuplicate',IpDadStateDuplicate);
    AddConstant('IpDadStateDeprecated',IpDadStateDeprecated);
    AddConstant('IpDadStatePreferred',IpDadStatePreferred);
    AddConstant('IfOperStatusUp',IfOperStatusUp);
    AddConstant('IfOperStatusDown',IfOperStatusDown);
    AddConstant('IfOperStatusTesting',IfOperStatusTesting);
    AddConstant('IfOperStatusUnknown',IfOperStatusUnknown);
    AddConstant('IfOperStatusDormant',IfOperStatusDormant);
    AddConstant('IfOperStatusNotPresent',IfOperStatusNotPresent);
    AddConstant('IfOperStatusLowerLayerDown',IfOperStatusLowerLayerDown);
    AddConstant('MAX_ADAPTER_DESCRIPTION_LENGTH',MAX_ADAPTER_DESCRIPTION_LENGTH);
    AddConstant('MAX_ADAPTER_NAME_LENGTH',MAX_ADAPTER_NAME_LENGTH);
    AddConstant('MAX_ADAPTER_ADDRESS_LENGTH',MAX_ADAPTER_ADDRESS_LENGTH);
    AddConstant('DEFAULT_MINIMUM_ENTITIES',DEFAULT_MINIMUM_ENTITIES);
    AddConstant('MAX_HOSTNAME_LEN',MAX_HOSTNAME_LEN);
    AddConstant('MAX_DOMAIN_NAME_LEN',MAX_DOMAIN_NAME_LEN);
    AddConstant('MAX_SCOPE_ID_LEN',MAX_SCOPE_ID_LEN);
    AddConstant('BROADCAST_NODETYPE',BROADCAST_NODETYPE);
    AddConstant('PEER_TO_PEER_NODETYPE',PEER_TO_PEER_NODETYPE);
    AddConstant('MIXED_NODETYPE',MIXED_NODETYPE);
    AddConstant('HYBRID_NODETYPE',HYBRID_NODETYPE);
    AddConstant('IP_ADAPTER_ADDRESS_DNS_ELIGIBLE',IP_ADAPTER_ADDRESS_DNS_ELIGIBLE);
    AddConstant('IP_ADAPTER_ADDRESS_TRANSIENT',IP_ADAPTER_ADDRESS_TRANSIENT);
    AddConstant('IP_ADAPTER_DDNS_ENABLED',IP_ADAPTER_DDNS_ENABLED);
    AddConstant('IP_ADAPTER_REGISTER_ADAPTER_SUFFIX',IP_ADAPTER_REGISTER_ADAPTER_SUFFIX);
    AddConstant('IP_ADAPTER_DHCP_ENABLED',IP_ADAPTER_DHCP_ENABLED);
    AddConstant('IP_ADAPTER_RECEIVE_ONLY',IP_ADAPTER_RECEIVE_ONLY);
    AddConstant('IP_ADAPTER_NO_MULTICAST',IP_ADAPTER_NO_MULTICAST);
    AddConstant('IP_ADAPTER_IPV6_OTHER_STATEFUL_CONFIG',IP_ADAPTER_IPV6_OTHER_STATEFUL_CONFIG);
    AddConstant('ScopeLevelInterface',ScopeLevelInterface);
    AddConstant('ScopeLevelLink',ScopeLevelLink);
    AddConstant('ScopeLevelSubnet',ScopeLevelSubnet);
    AddConstant('ScopeLevelAdmin',ScopeLevelAdmin);
    AddConstant('ScopeLevelSite',ScopeLevelSite);
    AddConstant('ScopeLevelOrganization',ScopeLevelOrganization);
    AddConstant('ScopeLevelGlobal',ScopeLevelGlobal);
    AddConstant('GAA_FLAG_SKIP_UNICAST',GAA_FLAG_SKIP_UNICAST);
    AddConstant('GAA_FLAG_SKIP_ANYCAST',GAA_FLAG_SKIP_ANYCAST);
    AddConstant('GAA_FLAG_SKIP_MULTICAST',GAA_FLAG_SKIP_MULTICAST);
    AddConstant('GAA_FLAG_SKIP_DNS_SERVER',GAA_FLAG_SKIP_DNS_SERVER);
    AddConstant('GAA_FLAG_INCLUDE_PREFIX',GAA_FLAG_INCLUDE_PREFIX);
    AddConstant('GAA_FLAG_SKIP_FRIENDLY_NAME',GAA_FLAG_SKIP_FRIENDLY_NAME);
  end;
end;

class function TatIpTypesLibrary.LibraryName: string;
begin
  result := 'IpTypes';
end;

initialization
  RegisterScripterLibrary(TatIpTypesLibrary, True);

{$WARNINGS ON}

end.

