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
unit ap_IpRtrMib;

interface

uses
  Windows,
  IpRtrMib,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatIpRtrMibLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  _MIB_OPAQUE_QUERYWrapper = class(TatRecordWrapper)
  private
    FdwVarId: DWORD;
  public
    constructor Create(ARecord: _MIB_OPAQUE_QUERY);
    function ObjToRec: _MIB_OPAQUE_QUERY;
  published
    property dwVarId: DWORD read FdwVarId write FdwVarId;
  end;
  
  _MIB_IFNUMBERWrapper = class(TatRecordWrapper)
  private
    FdwValue: DWORD;
  public
    constructor Create(ARecord: _MIB_IFNUMBER);
    function ObjToRec: _MIB_IFNUMBER;
  published
    property dwValue: DWORD read FdwValue write FdwValue;
  end;
  
  _MIB_IFROWWrapper = class(TatRecordWrapper)
  private
    FdwIndex: DWORD;
    FdwType: DWORD;
    FdwMtu: DWORD;
    FdwSpeed: DWORD;
    FdwPhysAddrLen: DWORD;
    FdwAdminStatus: DWORD;
    FdwOperStatus: DWORD;
    FdwLastChange: DWORD;
    FdwInOctets: DWORD;
    FdwInUcastPkts: DWORD;
    FdwInNUcastPkts: DWORD;
    FdwInDiscards: DWORD;
    FdwInErrors: DWORD;
    FdwInUnknownProtos: DWORD;
    FdwOutOctets: DWORD;
    FdwOutUcastPkts: DWORD;
    FdwOutNUcastPkts: DWORD;
    FdwOutDiscards: DWORD;
    FdwOutErrors: DWORD;
    FdwOutQLen: DWORD;
    FdwDescrLen: DWORD;
  public
    constructor Create(ARecord: _MIB_IFROW);
    function ObjToRec: _MIB_IFROW;
  published
    property dwIndex: DWORD read FdwIndex write FdwIndex;
    property dwType: DWORD read FdwType write FdwType;
    property dwMtu: DWORD read FdwMtu write FdwMtu;
    property dwSpeed: DWORD read FdwSpeed write FdwSpeed;
    property dwPhysAddrLen: DWORD read FdwPhysAddrLen write FdwPhysAddrLen;
    property dwAdminStatus: DWORD read FdwAdminStatus write FdwAdminStatus;
    property dwOperStatus: DWORD read FdwOperStatus write FdwOperStatus;
    property dwLastChange: DWORD read FdwLastChange write FdwLastChange;
    property dwInOctets: DWORD read FdwInOctets write FdwInOctets;
    property dwInUcastPkts: DWORD read FdwInUcastPkts write FdwInUcastPkts;
    property dwInNUcastPkts: DWORD read FdwInNUcastPkts write FdwInNUcastPkts;
    property dwInDiscards: DWORD read FdwInDiscards write FdwInDiscards;
    property dwInErrors: DWORD read FdwInErrors write FdwInErrors;
    property dwInUnknownProtos: DWORD read FdwInUnknownProtos write FdwInUnknownProtos;
    property dwOutOctets: DWORD read FdwOutOctets write FdwOutOctets;
    property dwOutUcastPkts: DWORD read FdwOutUcastPkts write FdwOutUcastPkts;
    property dwOutNUcastPkts: DWORD read FdwOutNUcastPkts write FdwOutNUcastPkts;
    property dwOutDiscards: DWORD read FdwOutDiscards write FdwOutDiscards;
    property dwOutErrors: DWORD read FdwOutErrors write FdwOutErrors;
    property dwOutQLen: DWORD read FdwOutQLen write FdwOutQLen;
    property dwDescrLen: DWORD read FdwDescrLen write FdwDescrLen;
  end;
  
  _MIB_IFTABLEWrapper = class(TatRecordWrapper)
  private
    FdwNumEntries: DWORD;
  public
    constructor Create(ARecord: _MIB_IFTABLE);
    function ObjToRec: _MIB_IFTABLE;
  published
    property dwNumEntries: DWORD read FdwNumEntries write FdwNumEntries;
  end;
  
  _MIBICMPSTATSWrapper = class(TatRecordWrapper)
  private
    FdwMsgs: DWORD;
    FdwErrors: DWORD;
    FdwDestUnreachs: DWORD;
    FdwTimeExcds: DWORD;
    FdwParmProbs: DWORD;
    FdwSrcQuenchs: DWORD;
    FdwRedirects: DWORD;
    FdwEchos: DWORD;
    FdwEchoReps: DWORD;
    FdwTimestamps: DWORD;
    FdwTimestampReps: DWORD;
    FdwAddrMasks: DWORD;
    FdwAddrMaskReps: DWORD;
  public
    constructor Create(ARecord: _MIBICMPSTATS);
    function ObjToRec: _MIBICMPSTATS;
  published
    property dwMsgs: DWORD read FdwMsgs write FdwMsgs;
    property dwErrors: DWORD read FdwErrors write FdwErrors;
    property dwDestUnreachs: DWORD read FdwDestUnreachs write FdwDestUnreachs;
    property dwTimeExcds: DWORD read FdwTimeExcds write FdwTimeExcds;
    property dwParmProbs: DWORD read FdwParmProbs write FdwParmProbs;
    property dwSrcQuenchs: DWORD read FdwSrcQuenchs write FdwSrcQuenchs;
    property dwRedirects: DWORD read FdwRedirects write FdwRedirects;
    property dwEchos: DWORD read FdwEchos write FdwEchos;
    property dwEchoReps: DWORD read FdwEchoReps write FdwEchoReps;
    property dwTimestamps: DWORD read FdwTimestamps write FdwTimestamps;
    property dwTimestampReps: DWORD read FdwTimestampReps write FdwTimestampReps;
    property dwAddrMasks: DWORD read FdwAddrMasks write FdwAddrMasks;
    property dwAddrMaskReps: DWORD read FdwAddrMaskReps write FdwAddrMaskReps;
  end;
  
  _MIBICMPINFOWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _MIBICMPINFO);
    function ObjToRec: _MIBICMPINFO;
  published
  end;
  
  _MIB_ICMPWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _MIB_ICMP);
    function ObjToRec: _MIB_ICMP;
  published
  end;
  
  _MIBICMPSTATS_EXWrapper = class(TatRecordWrapper)
  private
    FdwMsgs: DWORD;
    FdwErrors: DWORD;
  public
    constructor Create(ARecord: _MIBICMPSTATS_EX);
    function ObjToRec: _MIBICMPSTATS_EX;
  published
    property dwMsgs: DWORD read FdwMsgs write FdwMsgs;
    property dwErrors: DWORD read FdwErrors write FdwErrors;
  end;
  
  _MIB_ICMP_EXWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _MIB_ICMP_EX);
    function ObjToRec: _MIB_ICMP_EX;
  published
  end;
  
  _MIB_UDPSTATSWrapper = class(TatRecordWrapper)
  private
    FdwInDatagrams: DWORD;
    FdwNoPorts: DWORD;
    FdwInErrors: DWORD;
    FdwOutDatagrams: DWORD;
    FdwNumAddrs: DWORD;
  public
    constructor Create(ARecord: _MIB_UDPSTATS);
    function ObjToRec: _MIB_UDPSTATS;
  published
    property dwInDatagrams: DWORD read FdwInDatagrams write FdwInDatagrams;
    property dwNoPorts: DWORD read FdwNoPorts write FdwNoPorts;
    property dwInErrors: DWORD read FdwInErrors write FdwInErrors;
    property dwOutDatagrams: DWORD read FdwOutDatagrams write FdwOutDatagrams;
    property dwNumAddrs: DWORD read FdwNumAddrs write FdwNumAddrs;
  end;
  
  _MIB_UDPROWWrapper = class(TatRecordWrapper)
  private
    FdwLocalAddr: DWORD;
    FdwLocalPort: DWORD;
  public
    constructor Create(ARecord: _MIB_UDPROW);
    function ObjToRec: _MIB_UDPROW;
  published
    property dwLocalAddr: DWORD read FdwLocalAddr write FdwLocalAddr;
    property dwLocalPort: DWORD read FdwLocalPort write FdwLocalPort;
  end;
  
  _MIB_UDPTABLEWrapper = class(TatRecordWrapper)
  private
    FdwNumEntries: DWORD;
  public
    constructor Create(ARecord: _MIB_UDPTABLE);
    function ObjToRec: _MIB_UDPTABLE;
  published
    property dwNumEntries: DWORD read FdwNumEntries write FdwNumEntries;
  end;
  
  _MIB_TCPSTATSWrapper = class(TatRecordWrapper)
  private
    FdwRtoAlgorithm: DWORD;
    FdwRtoMin: DWORD;
    FdwRtoMax: DWORD;
    FdwMaxConn: DWORD;
    FdwActiveOpens: DWORD;
    FdwPassiveOpens: DWORD;
    FdwAttemptFails: DWORD;
    FdwEstabResets: DWORD;
    FdwCurrEstab: DWORD;
    FdwInSegs: DWORD;
    FdwOutSegs: DWORD;
    FdwRetransSegs: DWORD;
    FdwInErrs: DWORD;
    FdwOutRsts: DWORD;
    FdwNumConns: DWORD;
  public
    constructor Create(ARecord: _MIB_TCPSTATS);
    function ObjToRec: _MIB_TCPSTATS;
  published
    property dwRtoAlgorithm: DWORD read FdwRtoAlgorithm write FdwRtoAlgorithm;
    property dwRtoMin: DWORD read FdwRtoMin write FdwRtoMin;
    property dwRtoMax: DWORD read FdwRtoMax write FdwRtoMax;
    property dwMaxConn: DWORD read FdwMaxConn write FdwMaxConn;
    property dwActiveOpens: DWORD read FdwActiveOpens write FdwActiveOpens;
    property dwPassiveOpens: DWORD read FdwPassiveOpens write FdwPassiveOpens;
    property dwAttemptFails: DWORD read FdwAttemptFails write FdwAttemptFails;
    property dwEstabResets: DWORD read FdwEstabResets write FdwEstabResets;
    property dwCurrEstab: DWORD read FdwCurrEstab write FdwCurrEstab;
    property dwInSegs: DWORD read FdwInSegs write FdwInSegs;
    property dwOutSegs: DWORD read FdwOutSegs write FdwOutSegs;
    property dwRetransSegs: DWORD read FdwRetransSegs write FdwRetransSegs;
    property dwInErrs: DWORD read FdwInErrs write FdwInErrs;
    property dwOutRsts: DWORD read FdwOutRsts write FdwOutRsts;
    property dwNumConns: DWORD read FdwNumConns write FdwNumConns;
  end;
  
  _MIB_TCPROWWrapper = class(TatRecordWrapper)
  private
    FdwState: DWORD;
    FdwLocalAddr: DWORD;
    FdwLocalPort: DWORD;
    FdwRemoteAddr: DWORD;
    FdwRemotePort: DWORD;
  public
    constructor Create(ARecord: _MIB_TCPROW);
    function ObjToRec: _MIB_TCPROW;
  published
    property dwState: DWORD read FdwState write FdwState;
    property dwLocalAddr: DWORD read FdwLocalAddr write FdwLocalAddr;
    property dwLocalPort: DWORD read FdwLocalPort write FdwLocalPort;
    property dwRemoteAddr: DWORD read FdwRemoteAddr write FdwRemoteAddr;
    property dwRemotePort: DWORD read FdwRemotePort write FdwRemotePort;
  end;
  
  _MIB_TCPTABLEWrapper = class(TatRecordWrapper)
  private
    FdwNumEntries: DWORD;
  public
    constructor Create(ARecord: _MIB_TCPTABLE);
    function ObjToRec: _MIB_TCPTABLE;
  published
    property dwNumEntries: DWORD read FdwNumEntries write FdwNumEntries;
  end;
  
  _MIB_IPSTATSWrapper = class(TatRecordWrapper)
  private
    FdwForwarding: DWORD;
    FdwDefaultTTL: DWORD;
    FdwInReceives: DWORD;
    FdwInHdrErrors: DWORD;
    FdwInAddrErrors: DWORD;
    FdwForwDatagrams: DWORD;
    FdwInUnknownProtos: DWORD;
    FdwInDiscards: DWORD;
    FdwInDelivers: DWORD;
    FdwOutRequests: DWORD;
    FdwRoutingDiscards: DWORD;
    FdwOutDiscards: DWORD;
    FdwOutNoRoutes: DWORD;
    FdwReasmTimeout: DWORD;
    FdwReasmReqds: DWORD;
    FdwReasmOks: DWORD;
    FdwReasmFails: DWORD;
    FdwFragOks: DWORD;
    FdwFragFails: DWORD;
    FdwFragCreates: DWORD;
    FdwNumIf: DWORD;
    FdwNumAddr: DWORD;
    FdwNumRoutes: DWORD;
  public
    constructor Create(ARecord: _MIB_IPSTATS);
    function ObjToRec: _MIB_IPSTATS;
  published
    property dwForwarding: DWORD read FdwForwarding write FdwForwarding;
    property dwDefaultTTL: DWORD read FdwDefaultTTL write FdwDefaultTTL;
    property dwInReceives: DWORD read FdwInReceives write FdwInReceives;
    property dwInHdrErrors: DWORD read FdwInHdrErrors write FdwInHdrErrors;
    property dwInAddrErrors: DWORD read FdwInAddrErrors write FdwInAddrErrors;
    property dwForwDatagrams: DWORD read FdwForwDatagrams write FdwForwDatagrams;
    property dwInUnknownProtos: DWORD read FdwInUnknownProtos write FdwInUnknownProtos;
    property dwInDiscards: DWORD read FdwInDiscards write FdwInDiscards;
    property dwInDelivers: DWORD read FdwInDelivers write FdwInDelivers;
    property dwOutRequests: DWORD read FdwOutRequests write FdwOutRequests;
    property dwRoutingDiscards: DWORD read FdwRoutingDiscards write FdwRoutingDiscards;
    property dwOutDiscards: DWORD read FdwOutDiscards write FdwOutDiscards;
    property dwOutNoRoutes: DWORD read FdwOutNoRoutes write FdwOutNoRoutes;
    property dwReasmTimeout: DWORD read FdwReasmTimeout write FdwReasmTimeout;
    property dwReasmReqds: DWORD read FdwReasmReqds write FdwReasmReqds;
    property dwReasmOks: DWORD read FdwReasmOks write FdwReasmOks;
    property dwReasmFails: DWORD read FdwReasmFails write FdwReasmFails;
    property dwFragOks: DWORD read FdwFragOks write FdwFragOks;
    property dwFragFails: DWORD read FdwFragFails write FdwFragFails;
    property dwFragCreates: DWORD read FdwFragCreates write FdwFragCreates;
    property dwNumIf: DWORD read FdwNumIf write FdwNumIf;
    property dwNumAddr: DWORD read FdwNumAddr write FdwNumAddr;
    property dwNumRoutes: DWORD read FdwNumRoutes write FdwNumRoutes;
  end;
  
  _MIB_IPADDRROWWrapper = class(TatRecordWrapper)
  private
    FdwAddr: DWORD;
    FdwIndex: DWORD;
    FdwMask: DWORD;
    FdwBCastAddr: DWORD;
    FdwReasmSize: DWORD;
    Funused1: Word;
    FwType: Word;
  public
    constructor Create(ARecord: _MIB_IPADDRROW);
    function ObjToRec: _MIB_IPADDRROW;
  published
    property dwAddr: DWORD read FdwAddr write FdwAddr;
    property dwIndex: DWORD read FdwIndex write FdwIndex;
    property dwMask: DWORD read FdwMask write FdwMask;
    property dwBCastAddr: DWORD read FdwBCastAddr write FdwBCastAddr;
    property dwReasmSize: DWORD read FdwReasmSize write FdwReasmSize;
    property unused1: Word read Funused1 write Funused1;
    property wType: Word read FwType write FwType;
  end;
  
  _MIB_IPADDRTABLEWrapper = class(TatRecordWrapper)
  private
    FdwNumEntries: DWORD;
  public
    constructor Create(ARecord: _MIB_IPADDRTABLE);
    function ObjToRec: _MIB_IPADDRTABLE;
  published
    property dwNumEntries: DWORD read FdwNumEntries write FdwNumEntries;
  end;
  
  _MIB_IPFORWARDNUMBERWrapper = class(TatRecordWrapper)
  private
    FdwValue: DWORD;
  public
    constructor Create(ARecord: _MIB_IPFORWARDNUMBER);
    function ObjToRec: _MIB_IPFORWARDNUMBER;
  published
    property dwValue: DWORD read FdwValue write FdwValue;
  end;
  
  _MIB_IPFORWARDROWWrapper = class(TatRecordWrapper)
  private
    FdwForwardDest: DWORD;
    FdwForwardMask: DWORD;
    FdwForwardPolicy: DWORD;
    FdwForwardNextHop: DWORD;
    FdwForwardIfIndex: DWORD;
    FdwForwardType: DWORD;
    FdwForwardProto: DWORD;
    FdwForwardAge: DWORD;
    FdwForwardNextHopAS: DWORD;
    FdwForwardMetric1: DWORD;
    FdwForwardMetric2: DWORD;
    FdwForwardMetric3: DWORD;
    FdwForwardMetric4: DWORD;
    FdwForwardMetric5: DWORD;
  public
    constructor Create(ARecord: _MIB_IPFORWARDROW);
    function ObjToRec: _MIB_IPFORWARDROW;
  published
    property dwForwardDest: DWORD read FdwForwardDest write FdwForwardDest;
    property dwForwardMask: DWORD read FdwForwardMask write FdwForwardMask;
    property dwForwardPolicy: DWORD read FdwForwardPolicy write FdwForwardPolicy;
    property dwForwardNextHop: DWORD read FdwForwardNextHop write FdwForwardNextHop;
    property dwForwardIfIndex: DWORD read FdwForwardIfIndex write FdwForwardIfIndex;
    property dwForwardType: DWORD read FdwForwardType write FdwForwardType;
    property dwForwardProto: DWORD read FdwForwardProto write FdwForwardProto;
    property dwForwardAge: DWORD read FdwForwardAge write FdwForwardAge;
    property dwForwardNextHopAS: DWORD read FdwForwardNextHopAS write FdwForwardNextHopAS;
    property dwForwardMetric1: DWORD read FdwForwardMetric1 write FdwForwardMetric1;
    property dwForwardMetric2: DWORD read FdwForwardMetric2 write FdwForwardMetric2;
    property dwForwardMetric3: DWORD read FdwForwardMetric3 write FdwForwardMetric3;
    property dwForwardMetric4: DWORD read FdwForwardMetric4 write FdwForwardMetric4;
    property dwForwardMetric5: DWORD read FdwForwardMetric5 write FdwForwardMetric5;
  end;
  
  _MIB_IPFORWARDTABLEWrapper = class(TatRecordWrapper)
  private
    FdwNumEntries: DWORD;
  public
    constructor Create(ARecord: _MIB_IPFORWARDTABLE);
    function ObjToRec: _MIB_IPFORWARDTABLE;
  published
    property dwNumEntries: DWORD read FdwNumEntries write FdwNumEntries;
  end;
  
  _MIB_IPNETROWWrapper = class(TatRecordWrapper)
  private
    FdwIndex: DWORD;
    FdwPhysAddrLen: DWORD;
    FdwAddr: DWORD;
    FdwType: DWORD;
  public
    constructor Create(ARecord: _MIB_IPNETROW);
    function ObjToRec: _MIB_IPNETROW;
  published
    property dwIndex: DWORD read FdwIndex write FdwIndex;
    property dwPhysAddrLen: DWORD read FdwPhysAddrLen write FdwPhysAddrLen;
    property dwAddr: DWORD read FdwAddr write FdwAddr;
    property dwType: DWORD read FdwType write FdwType;
  end;
  
  _MIB_IPNETTABLEWrapper = class(TatRecordWrapper)
  private
    FdwNumEntries: DWORD;
  public
    constructor Create(ARecord: _MIB_IPNETTABLE);
    function ObjToRec: _MIB_IPNETTABLE;
  published
    property dwNumEntries: DWORD read FdwNumEntries write FdwNumEntries;
  end;
  
  _MIB_IPMCAST_OIFWrapper = class(TatRecordWrapper)
  private
    FdwOutIfIndex: DWORD;
    FdwNextHopAddr: DWORD;
    FdwReserved: DWORD;
    FdwReserved1: DWORD;
  public
    constructor Create(ARecord: _MIB_IPMCAST_OIF);
    function ObjToRec: _MIB_IPMCAST_OIF;
  published
    property dwOutIfIndex: DWORD read FdwOutIfIndex write FdwOutIfIndex;
    property dwNextHopAddr: DWORD read FdwNextHopAddr write FdwNextHopAddr;
    property dwReserved: DWORD read FdwReserved write FdwReserved;
    property dwReserved1: DWORD read FdwReserved1 write FdwReserved1;
  end;
  
  _MIB_IPMCAST_MFEWrapper = class(TatRecordWrapper)
  private
    FdwGroup: DWORD;
    FdwSource: DWORD;
    FdwSrcMask: DWORD;
    FdwUpStrmNgbr: DWORD;
    FdwInIfIndex: DWORD;
    FdwInIfProtocol: DWORD;
    FdwRouteProtocol: DWORD;
    FdwRouteNetwork: DWORD;
    FdwRouteMask: DWORD;
    FulUpTime: ULONG;
    FulExpiryTime: ULONG;
    FulTimeOut: ULONG;
    FulNumOutIf: ULONG;
    FfFlags: DWORD;
    FdwReserved: DWORD;
  public
    constructor Create(ARecord: _MIB_IPMCAST_MFE);
    function ObjToRec: _MIB_IPMCAST_MFE;
  published
    property dwGroup: DWORD read FdwGroup write FdwGroup;
    property dwSource: DWORD read FdwSource write FdwSource;
    property dwSrcMask: DWORD read FdwSrcMask write FdwSrcMask;
    property dwUpStrmNgbr: DWORD read FdwUpStrmNgbr write FdwUpStrmNgbr;
    property dwInIfIndex: DWORD read FdwInIfIndex write FdwInIfIndex;
    property dwInIfProtocol: DWORD read FdwInIfProtocol write FdwInIfProtocol;
    property dwRouteProtocol: DWORD read FdwRouteProtocol write FdwRouteProtocol;
    property dwRouteNetwork: DWORD read FdwRouteNetwork write FdwRouteNetwork;
    property dwRouteMask: DWORD read FdwRouteMask write FdwRouteMask;
    property ulUpTime: ULONG read FulUpTime write FulUpTime;
    property ulExpiryTime: ULONG read FulExpiryTime write FulExpiryTime;
    property ulTimeOut: ULONG read FulTimeOut write FulTimeOut;
    property ulNumOutIf: ULONG read FulNumOutIf write FulNumOutIf;
    property fFlags: DWORD read FfFlags write FfFlags;
    property dwReserved: DWORD read FdwReserved write FdwReserved;
  end;
  
  _MIB_MFE_TABLEWrapper = class(TatRecordWrapper)
  private
    FdwNumEntries: DWORD;
  public
    constructor Create(ARecord: _MIB_MFE_TABLE);
    function ObjToRec: _MIB_MFE_TABLE;
  published
    property dwNumEntries: DWORD read FdwNumEntries write FdwNumEntries;
  end;
  
  _MIB_IPMCAST_OIF_STATSWrapper = class(TatRecordWrapper)
  private
    FdwOutIfIndex: DWORD;
    FdwNextHopAddr: DWORD;
    FdwDialContext: DWORD;
    FulTtlTooLow: ULONG;
    FulFragNeeded: ULONG;
    FulOutPackets: ULONG;
    FulOutDiscards: ULONG;
  public
    constructor Create(ARecord: _MIB_IPMCAST_OIF_STATS);
    function ObjToRec: _MIB_IPMCAST_OIF_STATS;
  published
    property dwOutIfIndex: DWORD read FdwOutIfIndex write FdwOutIfIndex;
    property dwNextHopAddr: DWORD read FdwNextHopAddr write FdwNextHopAddr;
    property dwDialContext: DWORD read FdwDialContext write FdwDialContext;
    property ulTtlTooLow: ULONG read FulTtlTooLow write FulTtlTooLow;
    property ulFragNeeded: ULONG read FulFragNeeded write FulFragNeeded;
    property ulOutPackets: ULONG read FulOutPackets write FulOutPackets;
    property ulOutDiscards: ULONG read FulOutDiscards write FulOutDiscards;
  end;
  
  _MIB_IPMCAST_MFE_STATSWrapper = class(TatRecordWrapper)
  private
    FdwGroup: DWORD;
    FdwSource: DWORD;
    FdwSrcMask: DWORD;
    FdwUpStrmNgbr: DWORD;
    FdwInIfIndex: DWORD;
    FdwInIfProtocol: DWORD;
    FdwRouteProtocol: DWORD;
    FdwRouteNetwork: DWORD;
    FdwRouteMask: DWORD;
    FulUpTime: ULONG;
    FulExpiryTime: ULONG;
    FulNumOutIf: ULONG;
    FulInPkts: ULONG;
    FulInOctets: ULONG;
    FulPktsDifferentIf: ULONG;
    FulQueueOverflow: ULONG;
  public
    constructor Create(ARecord: _MIB_IPMCAST_MFE_STATS);
    function ObjToRec: _MIB_IPMCAST_MFE_STATS;
  published
    property dwGroup: DWORD read FdwGroup write FdwGroup;
    property dwSource: DWORD read FdwSource write FdwSource;
    property dwSrcMask: DWORD read FdwSrcMask write FdwSrcMask;
    property dwUpStrmNgbr: DWORD read FdwUpStrmNgbr write FdwUpStrmNgbr;
    property dwInIfIndex: DWORD read FdwInIfIndex write FdwInIfIndex;
    property dwInIfProtocol: DWORD read FdwInIfProtocol write FdwInIfProtocol;
    property dwRouteProtocol: DWORD read FdwRouteProtocol write FdwRouteProtocol;
    property dwRouteNetwork: DWORD read FdwRouteNetwork write FdwRouteNetwork;
    property dwRouteMask: DWORD read FdwRouteMask write FdwRouteMask;
    property ulUpTime: ULONG read FulUpTime write FulUpTime;
    property ulExpiryTime: ULONG read FulExpiryTime write FulExpiryTime;
    property ulNumOutIf: ULONG read FulNumOutIf write FulNumOutIf;
    property ulInPkts: ULONG read FulInPkts write FulInPkts;
    property ulInOctets: ULONG read FulInOctets write FulInOctets;
    property ulPktsDifferentIf: ULONG read FulPktsDifferentIf write FulPktsDifferentIf;
    property ulQueueOverflow: ULONG read FulQueueOverflow write FulQueueOverflow;
  end;
  
  _MIB_MFE_STATS_TABLEWrapper = class(TatRecordWrapper)
  private
    FdwNumEntries: DWORD;
  public
    constructor Create(ARecord: _MIB_MFE_STATS_TABLE);
    function ObjToRec: _MIB_MFE_STATS_TABLE;
  published
    property dwNumEntries: DWORD read FdwNumEntries write FdwNumEntries;
  end;
  
  _MIB_IPMCAST_MFE_STATS_EXWrapper = class(TatRecordWrapper)
  private
    FdwGroup: DWORD;
    FdwSource: DWORD;
    FdwSrcMask: DWORD;
    FdwUpStrmNgbr: DWORD;
    FdwInIfIndex: DWORD;
    FdwInIfProtocol: DWORD;
    FdwRouteProtocol: DWORD;
    FdwRouteNetwork: DWORD;
    FdwRouteMask: DWORD;
    FulUpTime: ULONG;
    FulExpiryTime: ULONG;
    FulNumOutIf: ULONG;
    FulInPkts: ULONG;
    FulInOctets: ULONG;
    FulPktsDifferentIf: ULONG;
    FulQueueOverflow: ULONG;
    FulUninitMfe: ULONG;
    FulNegativeMfe: ULONG;
    FulInDiscards: ULONG;
    FulInHdrErrors: ULONG;
    FulTotalOutPackets: ULONG;
  public
    constructor Create(ARecord: _MIB_IPMCAST_MFE_STATS_EX);
    function ObjToRec: _MIB_IPMCAST_MFE_STATS_EX;
  published
    property dwGroup: DWORD read FdwGroup write FdwGroup;
    property dwSource: DWORD read FdwSource write FdwSource;
    property dwSrcMask: DWORD read FdwSrcMask write FdwSrcMask;
    property dwUpStrmNgbr: DWORD read FdwUpStrmNgbr write FdwUpStrmNgbr;
    property dwInIfIndex: DWORD read FdwInIfIndex write FdwInIfIndex;
    property dwInIfProtocol: DWORD read FdwInIfProtocol write FdwInIfProtocol;
    property dwRouteProtocol: DWORD read FdwRouteProtocol write FdwRouteProtocol;
    property dwRouteNetwork: DWORD read FdwRouteNetwork write FdwRouteNetwork;
    property dwRouteMask: DWORD read FdwRouteMask write FdwRouteMask;
    property ulUpTime: ULONG read FulUpTime write FulUpTime;
    property ulExpiryTime: ULONG read FulExpiryTime write FulExpiryTime;
    property ulNumOutIf: ULONG read FulNumOutIf write FulNumOutIf;
    property ulInPkts: ULONG read FulInPkts write FulInPkts;
    property ulInOctets: ULONG read FulInOctets write FulInOctets;
    property ulPktsDifferentIf: ULONG read FulPktsDifferentIf write FulPktsDifferentIf;
    property ulQueueOverflow: ULONG read FulQueueOverflow write FulQueueOverflow;
    property ulUninitMfe: ULONG read FulUninitMfe write FulUninitMfe;
    property ulNegativeMfe: ULONG read FulNegativeMfe write FulNegativeMfe;
    property ulInDiscards: ULONG read FulInDiscards write FulInDiscards;
    property ulInHdrErrors: ULONG read FulInHdrErrors write FulInHdrErrors;
    property ulTotalOutPackets: ULONG read FulTotalOutPackets write FulTotalOutPackets;
  end;
  
  _MIB_MFE_STATS_TABLE_EXWrapper = class(TatRecordWrapper)
  private
    FdwNumEntries: DWORD;
  public
    constructor Create(ARecord: _MIB_MFE_STATS_TABLE_EX);
    function ObjToRec: _MIB_MFE_STATS_TABLE_EX;
  published
    property dwNumEntries: DWORD read FdwNumEntries write FdwNumEntries;
  end;
  
  _MIB_IPMCAST_GLOBALWrapper = class(TatRecordWrapper)
  private
    FdwEnable: DWORD;
  public
    constructor Create(ARecord: _MIB_IPMCAST_GLOBAL);
    function ObjToRec: _MIB_IPMCAST_GLOBAL;
  published
    property dwEnable: DWORD read FdwEnable write FdwEnable;
  end;
  
  _MIB_IPMCAST_IF_ENTRYWrapper = class(TatRecordWrapper)
  private
    FdwIfIndex: DWORD;
    FdwTtl: DWORD;
    FdwProtocol: DWORD;
    FdwRateLimit: DWORD;
    FulInMcastOctets: ULONG;
    FulOutMcastOctets: ULONG;
  public
    constructor Create(ARecord: _MIB_IPMCAST_IF_ENTRY);
    function ObjToRec: _MIB_IPMCAST_IF_ENTRY;
  published
    property dwIfIndex: DWORD read FdwIfIndex write FdwIfIndex;
    property dwTtl: DWORD read FdwTtl write FdwTtl;
    property dwProtocol: DWORD read FdwProtocol write FdwProtocol;
    property dwRateLimit: DWORD read FdwRateLimit write FdwRateLimit;
    property ulInMcastOctets: ULONG read FulInMcastOctets write FulInMcastOctets;
    property ulOutMcastOctets: ULONG read FulOutMcastOctets write FulOutMcastOctets;
  end;
  
  _MIB_IPMCAST_IF_TABLEWrapper = class(TatRecordWrapper)
  private
    FdwNumEntries: DWORD;
  public
    constructor Create(ARecord: _MIB_IPMCAST_IF_TABLE);
    function ObjToRec: _MIB_IPMCAST_IF_TABLE;
  published
    property dwNumEntries: DWORD read FdwNumEntries write FdwNumEntries;
  end;
  
  _MIB_IPMCAST_BOUNDARYWrapper = class(TatRecordWrapper)
  private
    FdwIfIndex: DWORD;
    FdwGroupAddress: DWORD;
    FdwGroupMask: DWORD;
    FdwStatus: DWORD;
  public
    constructor Create(ARecord: _MIB_IPMCAST_BOUNDARY);
    function ObjToRec: _MIB_IPMCAST_BOUNDARY;
  published
    property dwIfIndex: DWORD read FdwIfIndex write FdwIfIndex;
    property dwGroupAddress: DWORD read FdwGroupAddress write FdwGroupAddress;
    property dwGroupMask: DWORD read FdwGroupMask write FdwGroupMask;
    property dwStatus: DWORD read FdwStatus write FdwStatus;
  end;
  
  _MIB_IPMCAST_BOUNDARY_TABLEWrapper = class(TatRecordWrapper)
  private
    FdwNumEntries: DWORD;
  public
    constructor Create(ARecord: _MIB_IPMCAST_BOUNDARY_TABLE);
    function ObjToRec: _MIB_IPMCAST_BOUNDARY_TABLE;
  published
    property dwNumEntries: DWORD read FdwNumEntries write FdwNumEntries;
  end;
  
  MIB_BOUNDARYROWWrapper = class(TatRecordWrapper)
  private
    FdwGroupAddress: DWORD;
    FdwGroupMask: DWORD;
  public
    constructor Create(ARecord: MIB_BOUNDARYROW);
    function ObjToRec: MIB_BOUNDARYROW;
  published
    property dwGroupAddress: DWORD read FdwGroupAddress write FdwGroupAddress;
    property dwGroupMask: DWORD read FdwGroupMask write FdwGroupMask;
  end;
  
  MIB_MCAST_LIMIT_ROWWrapper = class(TatRecordWrapper)
  private
    FdwTtl: DWORD;
    FdwRateLimit: DWORD;
  public
    constructor Create(ARecord: MIB_MCAST_LIMIT_ROW);
    function ObjToRec: MIB_MCAST_LIMIT_ROW;
  published
    property dwTtl: DWORD read FdwTtl write FdwTtl;
    property dwRateLimit: DWORD read FdwRateLimit write FdwRateLimit;
  end;
  
  _MIB_IPMCAST_SCOPEWrapper = class(TatRecordWrapper)
  private
    FdwGroupAddress: DWORD;
    FdwGroupMask: DWORD;
    FdwStatus: DWORD;
  public
    constructor Create(ARecord: _MIB_IPMCAST_SCOPE);
    function ObjToRec: _MIB_IPMCAST_SCOPE;
  published
    property dwGroupAddress: DWORD read FdwGroupAddress write FdwGroupAddress;
    property dwGroupMask: DWORD read FdwGroupMask write FdwGroupMask;
    property dwStatus: DWORD read FdwStatus write FdwStatus;
  end;
  
  _MIB_IPDESTROWWrapper = class(TatRecordWrapper)
  private
    FdwForwardPreference: DWORD;
    FdwForwardViewSet: DWORD;
  public
    constructor Create(ARecord: _MIB_IPDESTROW);
    function ObjToRec: _MIB_IPDESTROW;
  published
    property dwForwardPreference: DWORD read FdwForwardPreference write FdwForwardPreference;
    property dwForwardViewSet: DWORD read FdwForwardViewSet write FdwForwardViewSet;
  end;
  
  _MIB_IPDESTTABLEWrapper = class(TatRecordWrapper)
  private
    FdwNumEntries: DWORD;
  public
    constructor Create(ARecord: _MIB_IPDESTTABLE);
    function ObjToRec: _MIB_IPDESTTABLE;
  published
    property dwNumEntries: DWORD read FdwNumEntries write FdwNumEntries;
  end;
  
  _MIB_BEST_IFWrapper = class(TatRecordWrapper)
  private
    FdwDestAddr: DWORD;
    FdwIfIndex: DWORD;
  public
    constructor Create(ARecord: _MIB_BEST_IF);
    function ObjToRec: _MIB_BEST_IF;
  published
    property dwDestAddr: DWORD read FdwDestAddr write FdwDestAddr;
    property dwIfIndex: DWORD read FdwIfIndex write FdwIfIndex;
  end;
  
  _MIB_PROXYARPWrapper = class(TatRecordWrapper)
  private
    FdwAddress: DWORD;
    FdwMask: DWORD;
    FdwIfIndex: DWORD;
  public
    constructor Create(ARecord: _MIB_PROXYARP);
    function ObjToRec: _MIB_PROXYARP;
  published
    property dwAddress: DWORD read FdwAddress write FdwAddress;
    property dwMask: DWORD read FdwMask write FdwMask;
    property dwIfIndex: DWORD read FdwIfIndex write FdwIfIndex;
  end;
  
  _MIB_IFSTATUSWrapper = class(TatRecordWrapper)
  private
    FdwIfIndex: DWORD;
    FdwAdminStatus: DWORD;
    FdwOperationalStatus: DWORD;
    FbMHbeatActive: BOOL;
    FbMHbeatAlive: BOOL;
  public
    constructor Create(ARecord: _MIB_IFSTATUS);
    function ObjToRec: _MIB_IFSTATUS;
  published
    property dwIfIndex: DWORD read FdwIfIndex write FdwIfIndex;
    property dwAdminStatus: DWORD read FdwAdminStatus write FdwAdminStatus;
    property dwOperationalStatus: DWORD read FdwOperationalStatus write FdwOperationalStatus;
    property bMHbeatActive: BOOL read FbMHbeatActive write FbMHbeatActive;
    property bMHbeatAlive: BOOL read FbMHbeatAlive write FbMHbeatAlive;
  end;
  
  _MIB_ROUTESTATEWrapper = class(TatRecordWrapper)
  private
    FbRoutesSetToStack: BOOL;
  public
    constructor Create(ARecord: _MIB_ROUTESTATE);
    function ObjToRec: _MIB_ROUTESTATE;
  published
    property bRoutesSetToStack: BOOL read FbRoutesSetToStack write FbRoutesSetToStack;
  end;
  
  _MIB_OPAQUE_INFOWrapper = class(TatRecordWrapper)
  private
    FdwId: DWORD;
    FullAlign: Int64;
  public
    constructor Create(ARecord: _MIB_OPAQUE_INFO);
    function ObjToRec: _MIB_OPAQUE_INFO;
  published
    property dwId: DWORD read FdwId write FdwId;
    property ullAlign: Int64 read FullAlign write FullAlign;
  end;
  

implementation

constructor _MIB_OPAQUE_QUERYWrapper.Create(ARecord: _MIB_OPAQUE_QUERY);
begin
  inherited Create;
  FdwVarId := ARecord.dwVarId;
end;

function _MIB_OPAQUE_QUERYWrapper.ObjToRec: _MIB_OPAQUE_QUERY;
begin
  result.dwVarId := FdwVarId;
end;

constructor _MIB_IFNUMBERWrapper.Create(ARecord: _MIB_IFNUMBER);
begin
  inherited Create;
  FdwValue := ARecord.dwValue;
end;

function _MIB_IFNUMBERWrapper.ObjToRec: _MIB_IFNUMBER;
begin
  result.dwValue := FdwValue;
end;

constructor _MIB_IFROWWrapper.Create(ARecord: _MIB_IFROW);
begin
  inherited Create;
  FdwIndex := ARecord.dwIndex;
  FdwType := ARecord.dwType;
  FdwMtu := ARecord.dwMtu;
  FdwSpeed := ARecord.dwSpeed;
  FdwPhysAddrLen := ARecord.dwPhysAddrLen;
  FdwAdminStatus := ARecord.dwAdminStatus;
  FdwOperStatus := ARecord.dwOperStatus;
  FdwLastChange := ARecord.dwLastChange;
  FdwInOctets := ARecord.dwInOctets;
  FdwInUcastPkts := ARecord.dwInUcastPkts;
  FdwInNUcastPkts := ARecord.dwInNUcastPkts;
  FdwInDiscards := ARecord.dwInDiscards;
  FdwInErrors := ARecord.dwInErrors;
  FdwInUnknownProtos := ARecord.dwInUnknownProtos;
  FdwOutOctets := ARecord.dwOutOctets;
  FdwOutUcastPkts := ARecord.dwOutUcastPkts;
  FdwOutNUcastPkts := ARecord.dwOutNUcastPkts;
  FdwOutDiscards := ARecord.dwOutDiscards;
  FdwOutErrors := ARecord.dwOutErrors;
  FdwOutQLen := ARecord.dwOutQLen;
  FdwDescrLen := ARecord.dwDescrLen;
end;

function _MIB_IFROWWrapper.ObjToRec: _MIB_IFROW;
begin
  result.dwIndex := FdwIndex;
  result.dwType := FdwType;
  result.dwMtu := FdwMtu;
  result.dwSpeed := FdwSpeed;
  result.dwPhysAddrLen := FdwPhysAddrLen;
  result.dwAdminStatus := FdwAdminStatus;
  result.dwOperStatus := FdwOperStatus;
  result.dwLastChange := FdwLastChange;
  result.dwInOctets := FdwInOctets;
  result.dwInUcastPkts := FdwInUcastPkts;
  result.dwInNUcastPkts := FdwInNUcastPkts;
  result.dwInDiscards := FdwInDiscards;
  result.dwInErrors := FdwInErrors;
  result.dwInUnknownProtos := FdwInUnknownProtos;
  result.dwOutOctets := FdwOutOctets;
  result.dwOutUcastPkts := FdwOutUcastPkts;
  result.dwOutNUcastPkts := FdwOutNUcastPkts;
  result.dwOutDiscards := FdwOutDiscards;
  result.dwOutErrors := FdwOutErrors;
  result.dwOutQLen := FdwOutQLen;
  result.dwDescrLen := FdwDescrLen;
end;

constructor _MIB_IFTABLEWrapper.Create(ARecord: _MIB_IFTABLE);
begin
  inherited Create;
  FdwNumEntries := ARecord.dwNumEntries;
end;

function _MIB_IFTABLEWrapper.ObjToRec: _MIB_IFTABLE;
begin
  result.dwNumEntries := FdwNumEntries;
end;

constructor _MIBICMPSTATSWrapper.Create(ARecord: _MIBICMPSTATS);
begin
  inherited Create;
  FdwMsgs := ARecord.dwMsgs;
  FdwErrors := ARecord.dwErrors;
  FdwDestUnreachs := ARecord.dwDestUnreachs;
  FdwTimeExcds := ARecord.dwTimeExcds;
  FdwParmProbs := ARecord.dwParmProbs;
  FdwSrcQuenchs := ARecord.dwSrcQuenchs;
  FdwRedirects := ARecord.dwRedirects;
  FdwEchos := ARecord.dwEchos;
  FdwEchoReps := ARecord.dwEchoReps;
  FdwTimestamps := ARecord.dwTimestamps;
  FdwTimestampReps := ARecord.dwTimestampReps;
  FdwAddrMasks := ARecord.dwAddrMasks;
  FdwAddrMaskReps := ARecord.dwAddrMaskReps;
end;

function _MIBICMPSTATSWrapper.ObjToRec: _MIBICMPSTATS;
begin
  result.dwMsgs := FdwMsgs;
  result.dwErrors := FdwErrors;
  result.dwDestUnreachs := FdwDestUnreachs;
  result.dwTimeExcds := FdwTimeExcds;
  result.dwParmProbs := FdwParmProbs;
  result.dwSrcQuenchs := FdwSrcQuenchs;
  result.dwRedirects := FdwRedirects;
  result.dwEchos := FdwEchos;
  result.dwEchoReps := FdwEchoReps;
  result.dwTimestamps := FdwTimestamps;
  result.dwTimestampReps := FdwTimestampReps;
  result.dwAddrMasks := FdwAddrMasks;
  result.dwAddrMaskReps := FdwAddrMaskReps;
end;

constructor _MIBICMPINFOWrapper.Create(ARecord: _MIBICMPINFO);
begin
  inherited Create;
end;

function _MIBICMPINFOWrapper.ObjToRec: _MIBICMPINFO;
begin
end;

constructor _MIB_ICMPWrapper.Create(ARecord: _MIB_ICMP);
begin
  inherited Create;
end;

function _MIB_ICMPWrapper.ObjToRec: _MIB_ICMP;
begin
end;

constructor _MIBICMPSTATS_EXWrapper.Create(ARecord: _MIBICMPSTATS_EX);
begin
  inherited Create;
  FdwMsgs := ARecord.dwMsgs;
  FdwErrors := ARecord.dwErrors;
end;

function _MIBICMPSTATS_EXWrapper.ObjToRec: _MIBICMPSTATS_EX;
begin
  result.dwMsgs := FdwMsgs;
  result.dwErrors := FdwErrors;
end;

constructor _MIB_ICMP_EXWrapper.Create(ARecord: _MIB_ICMP_EX);
begin
  inherited Create;
end;

function _MIB_ICMP_EXWrapper.ObjToRec: _MIB_ICMP_EX;
begin
end;

constructor _MIB_UDPSTATSWrapper.Create(ARecord: _MIB_UDPSTATS);
begin
  inherited Create;
  FdwInDatagrams := ARecord.dwInDatagrams;
  FdwNoPorts := ARecord.dwNoPorts;
  FdwInErrors := ARecord.dwInErrors;
  FdwOutDatagrams := ARecord.dwOutDatagrams;
  FdwNumAddrs := ARecord.dwNumAddrs;
end;

function _MIB_UDPSTATSWrapper.ObjToRec: _MIB_UDPSTATS;
begin
  result.dwInDatagrams := FdwInDatagrams;
  result.dwNoPorts := FdwNoPorts;
  result.dwInErrors := FdwInErrors;
  result.dwOutDatagrams := FdwOutDatagrams;
  result.dwNumAddrs := FdwNumAddrs;
end;

constructor _MIB_UDPROWWrapper.Create(ARecord: _MIB_UDPROW);
begin
  inherited Create;
  FdwLocalAddr := ARecord.dwLocalAddr;
  FdwLocalPort := ARecord.dwLocalPort;
end;

function _MIB_UDPROWWrapper.ObjToRec: _MIB_UDPROW;
begin
  result.dwLocalAddr := FdwLocalAddr;
  result.dwLocalPort := FdwLocalPort;
end;

constructor _MIB_UDPTABLEWrapper.Create(ARecord: _MIB_UDPTABLE);
begin
  inherited Create;
  FdwNumEntries := ARecord.dwNumEntries;
end;

function _MIB_UDPTABLEWrapper.ObjToRec: _MIB_UDPTABLE;
begin
  result.dwNumEntries := FdwNumEntries;
end;

constructor _MIB_TCPSTATSWrapper.Create(ARecord: _MIB_TCPSTATS);
begin
  inherited Create;
  FdwRtoAlgorithm := ARecord.dwRtoAlgorithm;
  FdwRtoMin := ARecord.dwRtoMin;
  FdwRtoMax := ARecord.dwRtoMax;
  FdwMaxConn := ARecord.dwMaxConn;
  FdwActiveOpens := ARecord.dwActiveOpens;
  FdwPassiveOpens := ARecord.dwPassiveOpens;
  FdwAttemptFails := ARecord.dwAttemptFails;
  FdwEstabResets := ARecord.dwEstabResets;
  FdwCurrEstab := ARecord.dwCurrEstab;
  FdwInSegs := ARecord.dwInSegs;
  FdwOutSegs := ARecord.dwOutSegs;
  FdwRetransSegs := ARecord.dwRetransSegs;
  FdwInErrs := ARecord.dwInErrs;
  FdwOutRsts := ARecord.dwOutRsts;
  FdwNumConns := ARecord.dwNumConns;
end;

function _MIB_TCPSTATSWrapper.ObjToRec: _MIB_TCPSTATS;
begin
  result.dwRtoAlgorithm := FdwRtoAlgorithm;
  result.dwRtoMin := FdwRtoMin;
  result.dwRtoMax := FdwRtoMax;
  result.dwMaxConn := FdwMaxConn;
  result.dwActiveOpens := FdwActiveOpens;
  result.dwPassiveOpens := FdwPassiveOpens;
  result.dwAttemptFails := FdwAttemptFails;
  result.dwEstabResets := FdwEstabResets;
  result.dwCurrEstab := FdwCurrEstab;
  result.dwInSegs := FdwInSegs;
  result.dwOutSegs := FdwOutSegs;
  result.dwRetransSegs := FdwRetransSegs;
  result.dwInErrs := FdwInErrs;
  result.dwOutRsts := FdwOutRsts;
  result.dwNumConns := FdwNumConns;
end;

constructor _MIB_TCPROWWrapper.Create(ARecord: _MIB_TCPROW);
begin
  inherited Create;
  FdwState := ARecord.dwState;
  FdwLocalAddr := ARecord.dwLocalAddr;
  FdwLocalPort := ARecord.dwLocalPort;
  FdwRemoteAddr := ARecord.dwRemoteAddr;
  FdwRemotePort := ARecord.dwRemotePort;
end;

function _MIB_TCPROWWrapper.ObjToRec: _MIB_TCPROW;
begin
  result.dwState := FdwState;
  result.dwLocalAddr := FdwLocalAddr;
  result.dwLocalPort := FdwLocalPort;
  result.dwRemoteAddr := FdwRemoteAddr;
  result.dwRemotePort := FdwRemotePort;
end;

constructor _MIB_TCPTABLEWrapper.Create(ARecord: _MIB_TCPTABLE);
begin
  inherited Create;
  FdwNumEntries := ARecord.dwNumEntries;
end;

function _MIB_TCPTABLEWrapper.ObjToRec: _MIB_TCPTABLE;
begin
  result.dwNumEntries := FdwNumEntries;
end;

constructor _MIB_IPSTATSWrapper.Create(ARecord: _MIB_IPSTATS);
begin
  inherited Create;
  FdwForwarding := ARecord.dwForwarding;
  FdwDefaultTTL := ARecord.dwDefaultTTL;
  FdwInReceives := ARecord.dwInReceives;
  FdwInHdrErrors := ARecord.dwInHdrErrors;
  FdwInAddrErrors := ARecord.dwInAddrErrors;
  FdwForwDatagrams := ARecord.dwForwDatagrams;
  FdwInUnknownProtos := ARecord.dwInUnknownProtos;
  FdwInDiscards := ARecord.dwInDiscards;
  FdwInDelivers := ARecord.dwInDelivers;
  FdwOutRequests := ARecord.dwOutRequests;
  FdwRoutingDiscards := ARecord.dwRoutingDiscards;
  FdwOutDiscards := ARecord.dwOutDiscards;
  FdwOutNoRoutes := ARecord.dwOutNoRoutes;
  FdwReasmTimeout := ARecord.dwReasmTimeout;
  FdwReasmReqds := ARecord.dwReasmReqds;
  FdwReasmOks := ARecord.dwReasmOks;
  FdwReasmFails := ARecord.dwReasmFails;
  FdwFragOks := ARecord.dwFragOks;
  FdwFragFails := ARecord.dwFragFails;
  FdwFragCreates := ARecord.dwFragCreates;
  FdwNumIf := ARecord.dwNumIf;
  FdwNumAddr := ARecord.dwNumAddr;
  FdwNumRoutes := ARecord.dwNumRoutes;
end;

function _MIB_IPSTATSWrapper.ObjToRec: _MIB_IPSTATS;
begin
  result.dwForwarding := FdwForwarding;
  result.dwDefaultTTL := FdwDefaultTTL;
  result.dwInReceives := FdwInReceives;
  result.dwInHdrErrors := FdwInHdrErrors;
  result.dwInAddrErrors := FdwInAddrErrors;
  result.dwForwDatagrams := FdwForwDatagrams;
  result.dwInUnknownProtos := FdwInUnknownProtos;
  result.dwInDiscards := FdwInDiscards;
  result.dwInDelivers := FdwInDelivers;
  result.dwOutRequests := FdwOutRequests;
  result.dwRoutingDiscards := FdwRoutingDiscards;
  result.dwOutDiscards := FdwOutDiscards;
  result.dwOutNoRoutes := FdwOutNoRoutes;
  result.dwReasmTimeout := FdwReasmTimeout;
  result.dwReasmReqds := FdwReasmReqds;
  result.dwReasmOks := FdwReasmOks;
  result.dwReasmFails := FdwReasmFails;
  result.dwFragOks := FdwFragOks;
  result.dwFragFails := FdwFragFails;
  result.dwFragCreates := FdwFragCreates;
  result.dwNumIf := FdwNumIf;
  result.dwNumAddr := FdwNumAddr;
  result.dwNumRoutes := FdwNumRoutes;
end;

constructor _MIB_IPADDRROWWrapper.Create(ARecord: _MIB_IPADDRROW);
begin
  inherited Create;
  FdwAddr := ARecord.dwAddr;
  FdwIndex := ARecord.dwIndex;
  FdwMask := ARecord.dwMask;
  FdwBCastAddr := ARecord.dwBCastAddr;
  FdwReasmSize := ARecord.dwReasmSize;
  Funused1 := ARecord.unused1;
  FwType := ARecord.wType;
end;

function _MIB_IPADDRROWWrapper.ObjToRec: _MIB_IPADDRROW;
begin
  result.dwAddr := FdwAddr;
  result.dwIndex := FdwIndex;
  result.dwMask := FdwMask;
  result.dwBCastAddr := FdwBCastAddr;
  result.dwReasmSize := FdwReasmSize;
  result.unused1 := Funused1;
  result.wType := FwType;
end;

constructor _MIB_IPADDRTABLEWrapper.Create(ARecord: _MIB_IPADDRTABLE);
begin
  inherited Create;
  FdwNumEntries := ARecord.dwNumEntries;
end;

function _MIB_IPADDRTABLEWrapper.ObjToRec: _MIB_IPADDRTABLE;
begin
  result.dwNumEntries := FdwNumEntries;
end;

constructor _MIB_IPFORWARDNUMBERWrapper.Create(ARecord: _MIB_IPFORWARDNUMBER);
begin
  inherited Create;
  FdwValue := ARecord.dwValue;
end;

function _MIB_IPFORWARDNUMBERWrapper.ObjToRec: _MIB_IPFORWARDNUMBER;
begin
  result.dwValue := FdwValue;
end;

constructor _MIB_IPFORWARDROWWrapper.Create(ARecord: _MIB_IPFORWARDROW);
begin
  inherited Create;
  FdwForwardDest := ARecord.dwForwardDest;
  FdwForwardMask := ARecord.dwForwardMask;
  FdwForwardPolicy := ARecord.dwForwardPolicy;
  FdwForwardNextHop := ARecord.dwForwardNextHop;
  FdwForwardIfIndex := ARecord.dwForwardIfIndex;
  FdwForwardType := ARecord.dwForwardType;
  FdwForwardProto := ARecord.dwForwardProto;
  FdwForwardAge := ARecord.dwForwardAge;
  FdwForwardNextHopAS := ARecord.dwForwardNextHopAS;
  FdwForwardMetric1 := ARecord.dwForwardMetric1;
  FdwForwardMetric2 := ARecord.dwForwardMetric2;
  FdwForwardMetric3 := ARecord.dwForwardMetric3;
  FdwForwardMetric4 := ARecord.dwForwardMetric4;
  FdwForwardMetric5 := ARecord.dwForwardMetric5;
end;

function _MIB_IPFORWARDROWWrapper.ObjToRec: _MIB_IPFORWARDROW;
begin
  result.dwForwardDest := FdwForwardDest;
  result.dwForwardMask := FdwForwardMask;
  result.dwForwardPolicy := FdwForwardPolicy;
  result.dwForwardNextHop := FdwForwardNextHop;
  result.dwForwardIfIndex := FdwForwardIfIndex;
  result.dwForwardType := FdwForwardType;
  result.dwForwardProto := FdwForwardProto;
  result.dwForwardAge := FdwForwardAge;
  result.dwForwardNextHopAS := FdwForwardNextHopAS;
  result.dwForwardMetric1 := FdwForwardMetric1;
  result.dwForwardMetric2 := FdwForwardMetric2;
  result.dwForwardMetric3 := FdwForwardMetric3;
  result.dwForwardMetric4 := FdwForwardMetric4;
  result.dwForwardMetric5 := FdwForwardMetric5;
end;

constructor _MIB_IPFORWARDTABLEWrapper.Create(ARecord: _MIB_IPFORWARDTABLE);
begin
  inherited Create;
  FdwNumEntries := ARecord.dwNumEntries;
end;

function _MIB_IPFORWARDTABLEWrapper.ObjToRec: _MIB_IPFORWARDTABLE;
begin
  result.dwNumEntries := FdwNumEntries;
end;

constructor _MIB_IPNETROWWrapper.Create(ARecord: _MIB_IPNETROW);
begin
  inherited Create;
  FdwIndex := ARecord.dwIndex;
  FdwPhysAddrLen := ARecord.dwPhysAddrLen;
  FdwAddr := ARecord.dwAddr;
  FdwType := ARecord.dwType;
end;

function _MIB_IPNETROWWrapper.ObjToRec: _MIB_IPNETROW;
begin
  result.dwIndex := FdwIndex;
  result.dwPhysAddrLen := FdwPhysAddrLen;
  result.dwAddr := FdwAddr;
  result.dwType := FdwType;
end;

constructor _MIB_IPNETTABLEWrapper.Create(ARecord: _MIB_IPNETTABLE);
begin
  inherited Create;
  FdwNumEntries := ARecord.dwNumEntries;
end;

function _MIB_IPNETTABLEWrapper.ObjToRec: _MIB_IPNETTABLE;
begin
  result.dwNumEntries := FdwNumEntries;
end;

constructor _MIB_IPMCAST_OIFWrapper.Create(ARecord: _MIB_IPMCAST_OIF);
begin
  inherited Create;
  FdwOutIfIndex := ARecord.dwOutIfIndex;
  FdwNextHopAddr := ARecord.dwNextHopAddr;
  FdwReserved := ARecord.dwReserved;
  FdwReserved1 := ARecord.dwReserved1;
end;

function _MIB_IPMCAST_OIFWrapper.ObjToRec: _MIB_IPMCAST_OIF;
begin
  result.dwOutIfIndex := FdwOutIfIndex;
  result.dwNextHopAddr := FdwNextHopAddr;
  result.dwReserved := FdwReserved;
  result.dwReserved1 := FdwReserved1;
end;

constructor _MIB_IPMCAST_MFEWrapper.Create(ARecord: _MIB_IPMCAST_MFE);
begin
  inherited Create;
  FdwGroup := ARecord.dwGroup;
  FdwSource := ARecord.dwSource;
  FdwSrcMask := ARecord.dwSrcMask;
  FdwUpStrmNgbr := ARecord.dwUpStrmNgbr;
  FdwInIfIndex := ARecord.dwInIfIndex;
  FdwInIfProtocol := ARecord.dwInIfProtocol;
  FdwRouteProtocol := ARecord.dwRouteProtocol;
  FdwRouteNetwork := ARecord.dwRouteNetwork;
  FdwRouteMask := ARecord.dwRouteMask;
  FulUpTime := ARecord.ulUpTime;
  FulExpiryTime := ARecord.ulExpiryTime;
  FulTimeOut := ARecord.ulTimeOut;
  FulNumOutIf := ARecord.ulNumOutIf;
  FfFlags := ARecord.fFlags;
  FdwReserved := ARecord.dwReserved;
end;

function _MIB_IPMCAST_MFEWrapper.ObjToRec: _MIB_IPMCAST_MFE;
begin
  result.dwGroup := FdwGroup;
  result.dwSource := FdwSource;
  result.dwSrcMask := FdwSrcMask;
  result.dwUpStrmNgbr := FdwUpStrmNgbr;
  result.dwInIfIndex := FdwInIfIndex;
  result.dwInIfProtocol := FdwInIfProtocol;
  result.dwRouteProtocol := FdwRouteProtocol;
  result.dwRouteNetwork := FdwRouteNetwork;
  result.dwRouteMask := FdwRouteMask;
  result.ulUpTime := FulUpTime;
  result.ulExpiryTime := FulExpiryTime;
  result.ulTimeOut := FulTimeOut;
  result.ulNumOutIf := FulNumOutIf;
  result.fFlags := FfFlags;
  result.dwReserved := FdwReserved;
end;

constructor _MIB_MFE_TABLEWrapper.Create(ARecord: _MIB_MFE_TABLE);
begin
  inherited Create;
  FdwNumEntries := ARecord.dwNumEntries;
end;

function _MIB_MFE_TABLEWrapper.ObjToRec: _MIB_MFE_TABLE;
begin
  result.dwNumEntries := FdwNumEntries;
end;

constructor _MIB_IPMCAST_OIF_STATSWrapper.Create(ARecord: _MIB_IPMCAST_OIF_STATS);
begin
  inherited Create;
  FdwOutIfIndex := ARecord.dwOutIfIndex;
  FdwNextHopAddr := ARecord.dwNextHopAddr;
  FdwDialContext := ARecord.dwDialContext;
  FulTtlTooLow := ARecord.ulTtlTooLow;
  FulFragNeeded := ARecord.ulFragNeeded;
  FulOutPackets := ARecord.ulOutPackets;
  FulOutDiscards := ARecord.ulOutDiscards;
end;

function _MIB_IPMCAST_OIF_STATSWrapper.ObjToRec: _MIB_IPMCAST_OIF_STATS;
begin
  result.dwOutIfIndex := FdwOutIfIndex;
  result.dwNextHopAddr := FdwNextHopAddr;
  result.dwDialContext := FdwDialContext;
  result.ulTtlTooLow := FulTtlTooLow;
  result.ulFragNeeded := FulFragNeeded;
  result.ulOutPackets := FulOutPackets;
  result.ulOutDiscards := FulOutDiscards;
end;

constructor _MIB_IPMCAST_MFE_STATSWrapper.Create(ARecord: _MIB_IPMCAST_MFE_STATS);
begin
  inherited Create;
  FdwGroup := ARecord.dwGroup;
  FdwSource := ARecord.dwSource;
  FdwSrcMask := ARecord.dwSrcMask;
  FdwUpStrmNgbr := ARecord.dwUpStrmNgbr;
  FdwInIfIndex := ARecord.dwInIfIndex;
  FdwInIfProtocol := ARecord.dwInIfProtocol;
  FdwRouteProtocol := ARecord.dwRouteProtocol;
  FdwRouteNetwork := ARecord.dwRouteNetwork;
  FdwRouteMask := ARecord.dwRouteMask;
  FulUpTime := ARecord.ulUpTime;
  FulExpiryTime := ARecord.ulExpiryTime;
  FulNumOutIf := ARecord.ulNumOutIf;
  FulInPkts := ARecord.ulInPkts;
  FulInOctets := ARecord.ulInOctets;
  FulPktsDifferentIf := ARecord.ulPktsDifferentIf;
  FulQueueOverflow := ARecord.ulQueueOverflow;
end;

function _MIB_IPMCAST_MFE_STATSWrapper.ObjToRec: _MIB_IPMCAST_MFE_STATS;
begin
  result.dwGroup := FdwGroup;
  result.dwSource := FdwSource;
  result.dwSrcMask := FdwSrcMask;
  result.dwUpStrmNgbr := FdwUpStrmNgbr;
  result.dwInIfIndex := FdwInIfIndex;
  result.dwInIfProtocol := FdwInIfProtocol;
  result.dwRouteProtocol := FdwRouteProtocol;
  result.dwRouteNetwork := FdwRouteNetwork;
  result.dwRouteMask := FdwRouteMask;
  result.ulUpTime := FulUpTime;
  result.ulExpiryTime := FulExpiryTime;
  result.ulNumOutIf := FulNumOutIf;
  result.ulInPkts := FulInPkts;
  result.ulInOctets := FulInOctets;
  result.ulPktsDifferentIf := FulPktsDifferentIf;
  result.ulQueueOverflow := FulQueueOverflow;
end;

constructor _MIB_MFE_STATS_TABLEWrapper.Create(ARecord: _MIB_MFE_STATS_TABLE);
begin
  inherited Create;
  FdwNumEntries := ARecord.dwNumEntries;
end;

function _MIB_MFE_STATS_TABLEWrapper.ObjToRec: _MIB_MFE_STATS_TABLE;
begin
  result.dwNumEntries := FdwNumEntries;
end;

constructor _MIB_IPMCAST_MFE_STATS_EXWrapper.Create(ARecord: _MIB_IPMCAST_MFE_STATS_EX);
begin
  inherited Create;
  FdwGroup := ARecord.dwGroup;
  FdwSource := ARecord.dwSource;
  FdwSrcMask := ARecord.dwSrcMask;
  FdwUpStrmNgbr := ARecord.dwUpStrmNgbr;
  FdwInIfIndex := ARecord.dwInIfIndex;
  FdwInIfProtocol := ARecord.dwInIfProtocol;
  FdwRouteProtocol := ARecord.dwRouteProtocol;
  FdwRouteNetwork := ARecord.dwRouteNetwork;
  FdwRouteMask := ARecord.dwRouteMask;
  FulUpTime := ARecord.ulUpTime;
  FulExpiryTime := ARecord.ulExpiryTime;
  FulNumOutIf := ARecord.ulNumOutIf;
  FulInPkts := ARecord.ulInPkts;
  FulInOctets := ARecord.ulInOctets;
  FulPktsDifferentIf := ARecord.ulPktsDifferentIf;
  FulQueueOverflow := ARecord.ulQueueOverflow;
  FulUninitMfe := ARecord.ulUninitMfe;
  FulNegativeMfe := ARecord.ulNegativeMfe;
  FulInDiscards := ARecord.ulInDiscards;
  FulInHdrErrors := ARecord.ulInHdrErrors;
  FulTotalOutPackets := ARecord.ulTotalOutPackets;
end;

function _MIB_IPMCAST_MFE_STATS_EXWrapper.ObjToRec: _MIB_IPMCAST_MFE_STATS_EX;
begin
  result.dwGroup := FdwGroup;
  result.dwSource := FdwSource;
  result.dwSrcMask := FdwSrcMask;
  result.dwUpStrmNgbr := FdwUpStrmNgbr;
  result.dwInIfIndex := FdwInIfIndex;
  result.dwInIfProtocol := FdwInIfProtocol;
  result.dwRouteProtocol := FdwRouteProtocol;
  result.dwRouteNetwork := FdwRouteNetwork;
  result.dwRouteMask := FdwRouteMask;
  result.ulUpTime := FulUpTime;
  result.ulExpiryTime := FulExpiryTime;
  result.ulNumOutIf := FulNumOutIf;
  result.ulInPkts := FulInPkts;
  result.ulInOctets := FulInOctets;
  result.ulPktsDifferentIf := FulPktsDifferentIf;
  result.ulQueueOverflow := FulQueueOverflow;
  result.ulUninitMfe := FulUninitMfe;
  result.ulNegativeMfe := FulNegativeMfe;
  result.ulInDiscards := FulInDiscards;
  result.ulInHdrErrors := FulInHdrErrors;
  result.ulTotalOutPackets := FulTotalOutPackets;
end;

constructor _MIB_MFE_STATS_TABLE_EXWrapper.Create(ARecord: _MIB_MFE_STATS_TABLE_EX);
begin
  inherited Create;
  FdwNumEntries := ARecord.dwNumEntries;
end;

function _MIB_MFE_STATS_TABLE_EXWrapper.ObjToRec: _MIB_MFE_STATS_TABLE_EX;
begin
  result.dwNumEntries := FdwNumEntries;
end;

constructor _MIB_IPMCAST_GLOBALWrapper.Create(ARecord: _MIB_IPMCAST_GLOBAL);
begin
  inherited Create;
  FdwEnable := ARecord.dwEnable;
end;

function _MIB_IPMCAST_GLOBALWrapper.ObjToRec: _MIB_IPMCAST_GLOBAL;
begin
  result.dwEnable := FdwEnable;
end;

constructor _MIB_IPMCAST_IF_ENTRYWrapper.Create(ARecord: _MIB_IPMCAST_IF_ENTRY);
begin
  inherited Create;
  FdwIfIndex := ARecord.dwIfIndex;
  FdwTtl := ARecord.dwTtl;
  FdwProtocol := ARecord.dwProtocol;
  FdwRateLimit := ARecord.dwRateLimit;
  FulInMcastOctets := ARecord.ulInMcastOctets;
  FulOutMcastOctets := ARecord.ulOutMcastOctets;
end;

function _MIB_IPMCAST_IF_ENTRYWrapper.ObjToRec: _MIB_IPMCAST_IF_ENTRY;
begin
  result.dwIfIndex := FdwIfIndex;
  result.dwTtl := FdwTtl;
  result.dwProtocol := FdwProtocol;
  result.dwRateLimit := FdwRateLimit;
  result.ulInMcastOctets := FulInMcastOctets;
  result.ulOutMcastOctets := FulOutMcastOctets;
end;

constructor _MIB_IPMCAST_IF_TABLEWrapper.Create(ARecord: _MIB_IPMCAST_IF_TABLE);
begin
  inherited Create;
  FdwNumEntries := ARecord.dwNumEntries;
end;

function _MIB_IPMCAST_IF_TABLEWrapper.ObjToRec: _MIB_IPMCAST_IF_TABLE;
begin
  result.dwNumEntries := FdwNumEntries;
end;

constructor _MIB_IPMCAST_BOUNDARYWrapper.Create(ARecord: _MIB_IPMCAST_BOUNDARY);
begin
  inherited Create;
  FdwIfIndex := ARecord.dwIfIndex;
  FdwGroupAddress := ARecord.dwGroupAddress;
  FdwGroupMask := ARecord.dwGroupMask;
  FdwStatus := ARecord.dwStatus;
end;

function _MIB_IPMCAST_BOUNDARYWrapper.ObjToRec: _MIB_IPMCAST_BOUNDARY;
begin
  result.dwIfIndex := FdwIfIndex;
  result.dwGroupAddress := FdwGroupAddress;
  result.dwGroupMask := FdwGroupMask;
  result.dwStatus := FdwStatus;
end;

constructor _MIB_IPMCAST_BOUNDARY_TABLEWrapper.Create(ARecord: _MIB_IPMCAST_BOUNDARY_TABLE);
begin
  inherited Create;
  FdwNumEntries := ARecord.dwNumEntries;
end;

function _MIB_IPMCAST_BOUNDARY_TABLEWrapper.ObjToRec: _MIB_IPMCAST_BOUNDARY_TABLE;
begin
  result.dwNumEntries := FdwNumEntries;
end;

constructor MIB_BOUNDARYROWWrapper.Create(ARecord: MIB_BOUNDARYROW);
begin
  inherited Create;
  FdwGroupAddress := ARecord.dwGroupAddress;
  FdwGroupMask := ARecord.dwGroupMask;
end;

function MIB_BOUNDARYROWWrapper.ObjToRec: MIB_BOUNDARYROW;
begin
  result.dwGroupAddress := FdwGroupAddress;
  result.dwGroupMask := FdwGroupMask;
end;

constructor MIB_MCAST_LIMIT_ROWWrapper.Create(ARecord: MIB_MCAST_LIMIT_ROW);
begin
  inherited Create;
  FdwTtl := ARecord.dwTtl;
  FdwRateLimit := ARecord.dwRateLimit;
end;

function MIB_MCAST_LIMIT_ROWWrapper.ObjToRec: MIB_MCAST_LIMIT_ROW;
begin
  result.dwTtl := FdwTtl;
  result.dwRateLimit := FdwRateLimit;
end;

constructor _MIB_IPMCAST_SCOPEWrapper.Create(ARecord: _MIB_IPMCAST_SCOPE);
begin
  inherited Create;
  FdwGroupAddress := ARecord.dwGroupAddress;
  FdwGroupMask := ARecord.dwGroupMask;
  FdwStatus := ARecord.dwStatus;
end;

function _MIB_IPMCAST_SCOPEWrapper.ObjToRec: _MIB_IPMCAST_SCOPE;
begin
  result.dwGroupAddress := FdwGroupAddress;
  result.dwGroupMask := FdwGroupMask;
  result.dwStatus := FdwStatus;
end;

constructor _MIB_IPDESTROWWrapper.Create(ARecord: _MIB_IPDESTROW);
begin
  inherited Create;
  FdwForwardPreference := ARecord.dwForwardPreference;
  FdwForwardViewSet := ARecord.dwForwardViewSet;
end;

function _MIB_IPDESTROWWrapper.ObjToRec: _MIB_IPDESTROW;
begin
  result.dwForwardPreference := FdwForwardPreference;
  result.dwForwardViewSet := FdwForwardViewSet;
end;

constructor _MIB_IPDESTTABLEWrapper.Create(ARecord: _MIB_IPDESTTABLE);
begin
  inherited Create;
  FdwNumEntries := ARecord.dwNumEntries;
end;

function _MIB_IPDESTTABLEWrapper.ObjToRec: _MIB_IPDESTTABLE;
begin
  result.dwNumEntries := FdwNumEntries;
end;

constructor _MIB_BEST_IFWrapper.Create(ARecord: _MIB_BEST_IF);
begin
  inherited Create;
  FdwDestAddr := ARecord.dwDestAddr;
  FdwIfIndex := ARecord.dwIfIndex;
end;

function _MIB_BEST_IFWrapper.ObjToRec: _MIB_BEST_IF;
begin
  result.dwDestAddr := FdwDestAddr;
  result.dwIfIndex := FdwIfIndex;
end;

constructor _MIB_PROXYARPWrapper.Create(ARecord: _MIB_PROXYARP);
begin
  inherited Create;
  FdwAddress := ARecord.dwAddress;
  FdwMask := ARecord.dwMask;
  FdwIfIndex := ARecord.dwIfIndex;
end;

function _MIB_PROXYARPWrapper.ObjToRec: _MIB_PROXYARP;
begin
  result.dwAddress := FdwAddress;
  result.dwMask := FdwMask;
  result.dwIfIndex := FdwIfIndex;
end;

constructor _MIB_IFSTATUSWrapper.Create(ARecord: _MIB_IFSTATUS);
begin
  inherited Create;
  FdwIfIndex := ARecord.dwIfIndex;
  FdwAdminStatus := ARecord.dwAdminStatus;
  FdwOperationalStatus := ARecord.dwOperationalStatus;
  FbMHbeatActive := ARecord.bMHbeatActive;
  FbMHbeatAlive := ARecord.bMHbeatAlive;
end;

function _MIB_IFSTATUSWrapper.ObjToRec: _MIB_IFSTATUS;
begin
  result.dwIfIndex := FdwIfIndex;
  result.dwAdminStatus := FdwAdminStatus;
  result.dwOperationalStatus := FdwOperationalStatus;
  result.bMHbeatActive := FbMHbeatActive;
  result.bMHbeatAlive := FbMHbeatAlive;
end;

constructor _MIB_ROUTESTATEWrapper.Create(ARecord: _MIB_ROUTESTATE);
begin
  inherited Create;
  FbRoutesSetToStack := ARecord.bRoutesSetToStack;
end;

function _MIB_ROUTESTATEWrapper.ObjToRec: _MIB_ROUTESTATE;
begin
  result.bRoutesSetToStack := FbRoutesSetToStack;
end;

constructor _MIB_OPAQUE_INFOWrapper.Create(ARecord: _MIB_OPAQUE_INFO);
begin
  inherited Create;
  FdwId := ARecord.dwId;
  FullAlign := ARecord.ullAlign;
end;

function _MIB_OPAQUE_INFOWrapper.ObjToRec: _MIB_OPAQUE_INFO;
begin
  result.dwId := FdwId;
  result.ullAlign := FullAlign;
end;



procedure TatIpRtrMibLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('MAX_INTERFACE_NAME_LEN',MAX_INTERFACE_NAME_LEN);
    AddConstant('IPRTRMGR_PID',IPRTRMGR_PID);
    AddConstant('ANY_SIZE',ANY_SIZE);
    AddConstant('IF_NUMBER',IF_NUMBER);
    AddConstant('IF_TABLE',IF_TABLE);
    AddConstant('IF_ROW',IF_ROW);
    AddConstant('IP_STATS',IP_STATS);
    AddConstant('IP_ADDRTABLE',IP_ADDRTABLE);
    AddConstant('IP_ADDRROW',IP_ADDRROW);
    AddConstant('IP_FORWARDNUMBER',IP_FORWARDNUMBER);
    AddConstant('IP_FORWARDTABLE',IP_FORWARDTABLE);
    AddConstant('IP_FORWARDROW',IP_FORWARDROW);
    AddConstant('IP_NETTABLE',IP_NETTABLE);
    AddConstant('IP_NETROW',IP_NETROW);
    AddConstant('ICMP_STATS',ICMP_STATS);
    AddConstant('TCP_STATS',TCP_STATS);
    AddConstant('TCP_TABLE',TCP_TABLE);
    AddConstant('TCP_ROW',TCP_ROW);
    AddConstant('UDP_STATS',UDP_STATS);
    AddConstant('UDP_TABLE',UDP_TABLE);
    AddConstant('UDP_ROW',UDP_ROW);
    AddConstant('MCAST_MFE',MCAST_MFE);
    AddConstant('MCAST_MFE_STATS',MCAST_MFE_STATS);
    AddConstant('BEST_IF',BEST_IF);
    AddConstant('BEST_ROUTE',BEST_ROUTE);
    AddConstant('PROXY_ARP',PROXY_ARP);
    AddConstant('MCAST_IF_ENTRY',MCAST_IF_ENTRY);
    AddConstant('MCAST_GLOBAL',MCAST_GLOBAL);
    AddConstant('IF_STATUS',IF_STATUS);
    AddConstant('MCAST_BOUNDARY',MCAST_BOUNDARY);
    AddConstant('MCAST_SCOPE',MCAST_SCOPE);
    AddConstant('DEST_MATCHING',DEST_MATCHING);
    AddConstant('DEST_LONGER',DEST_LONGER);
    AddConstant('DEST_SHORTER',DEST_SHORTER);
    AddConstant('ROUTE_MATCHING',ROUTE_MATCHING);
    AddConstant('ROUTE_LONGER',ROUTE_LONGER);
    AddConstant('ROUTE_SHORTER',ROUTE_SHORTER);
    AddConstant('ROUTE_STATE',ROUTE_STATE);
    AddConstant('MCAST_MFE_STATS_EX',MCAST_MFE_STATS_EX);
    AddConstant('IP6_STATS',IP6_STATS);
    AddConstant('UDP6_STATS',UDP6_STATS);
    AddConstant('TCP6_STATS',TCP6_STATS);
    AddConstant('NUMBER_OF_EXPORTED_VARIABLES',NUMBER_OF_EXPORTED_VARIABLES);
    AddConstant('MAXLEN_IFDESCR',MAXLEN_IFDESCR);
    AddConstant('MAXLEN_PHYSADDR',MAXLEN_PHYSADDR);
    AddConstant('ICMP6_DST_UNREACH',ICMP6_DST_UNREACH);
    AddConstant('ICMP6_PACKET_TOO_BIG',ICMP6_PACKET_TOO_BIG);
    AddConstant('ICMP6_TIME_EXCEEDED',ICMP6_TIME_EXCEEDED);
    AddConstant('ICMP6_PARAM_PROB',ICMP6_PARAM_PROB);
    AddConstant('ICMP6_ECHO_REQUEST',ICMP6_ECHO_REQUEST);
    AddConstant('ICMP6_ECHO_REPLY',ICMP6_ECHO_REPLY);
    AddConstant('ICMP6_MEMBERSHIP_QUERY',ICMP6_MEMBERSHIP_QUERY);
    AddConstant('ICMP6_MEMBERSHIP_REPORT',ICMP6_MEMBERSHIP_REPORT);
    AddConstant('ICMP6_MEMBERSHIP_REDUCTION',ICMP6_MEMBERSHIP_REDUCTION);
    AddConstant('ND_ROUTER_SOLICIT',ND_ROUTER_SOLICIT);
    AddConstant('ND_ROUTER_ADVERT',ND_ROUTER_ADVERT);
    AddConstant('ND_NEIGHBOR_SOLICIT',ND_NEIGHBOR_SOLICIT);
    AddConstant('ND_NEIGHBOR_ADVERT',ND_NEIGHBOR_ADVERT);
    AddConstant('ND_REDIRECT',ND_REDIRECT);
    AddConstant('ICMP4_ECHO_REPLY',ICMP4_ECHO_REPLY);
    AddConstant('ICMP4_DST_UNREACH',ICMP4_DST_UNREACH);
    AddConstant('ICMP4_SOURCE_QUENCH',ICMP4_SOURCE_QUENCH);
    AddConstant('ICMP4_REDIRECT',ICMP4_REDIRECT);
    AddConstant('ICMP4_ECHO_REQUEST',ICMP4_ECHO_REQUEST);
    AddConstant('ICMP4_ROUTER_ADVERT',ICMP4_ROUTER_ADVERT);
    AddConstant('ICMP4_ROUTER_SOLICIT',ICMP4_ROUTER_SOLICIT);
    AddConstant('ICMP4_TIME_EXCEEDED',ICMP4_TIME_EXCEEDED);
    AddConstant('ICMP4_PARAM_PROB',ICMP4_PARAM_PROB);
    AddConstant('ICMP4_TIMESTAMP_REQUEST',ICMP4_TIMESTAMP_REQUEST);
    AddConstant('ICMP4_TIMESTAMP_REPLY',ICMP4_TIMESTAMP_REPLY);
    AddConstant('ICMP4_MASK_REQUEST',ICMP4_MASK_REQUEST);
    AddConstant('ICMP4_MASK_REPLY',ICMP4_MASK_REPLY);
    AddConstant('MIB_TCP_RTO_OTHER',MIB_TCP_RTO_OTHER);
    AddConstant('MIB_TCP_RTO_CONSTANT',MIB_TCP_RTO_CONSTANT);
    AddConstant('MIB_TCP_RTO_RSRE',MIB_TCP_RTO_RSRE);
    AddConstant('MIB_TCP_RTO_VANJ',MIB_TCP_RTO_VANJ);
    AddConstant('MIB_TCP_MAXCONN_DYNAMIC',MIB_TCP_MAXCONN_DYNAMIC);
    AddConstant('MIB_TCP_STATE_CLOSED',MIB_TCP_STATE_CLOSED);
    AddConstant('MIB_TCP_STATE_LISTEN',MIB_TCP_STATE_LISTEN);
    AddConstant('MIB_TCP_STATE_SYN_SENT',MIB_TCP_STATE_SYN_SENT);
    AddConstant('MIB_TCP_STATE_SYN_RCVD',MIB_TCP_STATE_SYN_RCVD);
    AddConstant('MIB_TCP_STATE_ESTAB',MIB_TCP_STATE_ESTAB);
    AddConstant('MIB_TCP_STATE_FIN_WAIT1',MIB_TCP_STATE_FIN_WAIT1);
    AddConstant('MIB_TCP_STATE_FIN_WAIT2',MIB_TCP_STATE_FIN_WAIT2);
    AddConstant('MIB_TCP_STATE_CLOSE_WAIT',MIB_TCP_STATE_CLOSE_WAIT);
    AddConstant('MIB_TCP_STATE_CLOSING',MIB_TCP_STATE_CLOSING);
    AddConstant('MIB_TCP_STATE_LAST_ACK',MIB_TCP_STATE_LAST_ACK);
    AddConstant('MIB_TCP_STATE_TIME_WAIT',MIB_TCP_STATE_TIME_WAIT);
    AddConstant('MIB_TCP_STATE_DELETE_TCB',MIB_TCP_STATE_DELETE_TCB);
    AddConstant('MIB_USE_CURRENT_TTL',MIB_USE_CURRENT_TTL);
    AddConstant('MIB_USE_CURRENT_FORWARDING',MIB_USE_CURRENT_FORWARDING);
    AddConstant('MIB_IP_FORWARDING',MIB_IP_FORWARDING);
    AddConstant('MIB_IP_NOT_FORWARDING',MIB_IP_NOT_FORWARDING);
    AddConstant('MIB_IPADDR_PRIMARY',MIB_IPADDR_PRIMARY);
    AddConstant('MIB_IPADDR_DYNAMIC',MIB_IPADDR_DYNAMIC);
    AddConstant('MIB_IPADDR_DISCONNECTED',MIB_IPADDR_DISCONNECTED);
    AddConstant('MIB_IPADDR_DELETED',MIB_IPADDR_DELETED);
    AddConstant('MIB_IPADDR_TRANSIENT',MIB_IPADDR_TRANSIENT);
    AddConstant('MIB_IPROUTE_TYPE_OTHER',MIB_IPROUTE_TYPE_OTHER);
    AddConstant('MIB_IPROUTE_TYPE_INVALID',MIB_IPROUTE_TYPE_INVALID);
    AddConstant('MIB_IPROUTE_TYPE_DIRECT',MIB_IPROUTE_TYPE_DIRECT);
    AddConstant('MIB_IPROUTE_TYPE_INDIRECT',MIB_IPROUTE_TYPE_INDIRECT);
    AddConstant('MIB_IPROUTE_METRIC_UNUSED',MIB_IPROUTE_METRIC_UNUSED);
    AddConstant('MIB_IPPROTO_OTHER',MIB_IPPROTO_OTHER);
    AddConstant('MIB_IPPROTO_LOCAL',MIB_IPPROTO_LOCAL);
    AddConstant('MIB_IPPROTO_NETMGMT',MIB_IPPROTO_NETMGMT);
    AddConstant('MIB_IPPROTO_ICMP',MIB_IPPROTO_ICMP);
    AddConstant('MIB_IPPROTO_EGP',MIB_IPPROTO_EGP);
    AddConstant('MIB_IPPROTO_GGP',MIB_IPPROTO_GGP);
    AddConstant('MIB_IPPROTO_HELLO',MIB_IPPROTO_HELLO);
    AddConstant('MIB_IPPROTO_RIP',MIB_IPPROTO_RIP);
    AddConstant('MIB_IPPROTO_IS_IS',MIB_IPPROTO_IS_IS);
    AddConstant('MIB_IPPROTO_ES_IS',MIB_IPPROTO_ES_IS);
    AddConstant('MIB_IPPROTO_CISCO',MIB_IPPROTO_CISCO);
    AddConstant('MIB_IPPROTO_BBN',MIB_IPPROTO_BBN);
    AddConstant('MIB_IPPROTO_OSPF',MIB_IPPROTO_OSPF);
    AddConstant('MIB_IPPROTO_BGP',MIB_IPPROTO_BGP);
    AddConstant('MIB_IPPROTO_NT_AUTOSTATIC',MIB_IPPROTO_NT_AUTOSTATIC);
    AddConstant('MIB_IPPROTO_NT_STATIC',MIB_IPPROTO_NT_STATIC);
    AddConstant('MIB_IPPROTO_NT_STATIC_NON_DOD',MIB_IPPROTO_NT_STATIC_NON_DOD);
    AddConstant('MIB_IPNET_TYPE_OTHER',MIB_IPNET_TYPE_OTHER);
    AddConstant('MIB_IPNET_TYPE_INVALID',MIB_IPNET_TYPE_INVALID);
    AddConstant('MIB_IPNET_TYPE_DYNAMIC',MIB_IPNET_TYPE_DYNAMIC);
    AddConstant('MIB_IPNET_TYPE_STATIC',MIB_IPNET_TYPE_STATIC);
    AddConstant('MAX_SCOPE_NAME_LEN',MAX_SCOPE_NAME_LEN);
    AddConstant('MAX_MIB_OFFSET',MAX_MIB_OFFSET);
  end;
end;

class function TatIpRtrMibLibrary.LibraryName: string;
begin
  result := 'IpRtrMib';
end;

initialization
  RegisterScripterLibrary(TatIpRtrMibLibrary, True);

{$WARNINGS ON}

end.

