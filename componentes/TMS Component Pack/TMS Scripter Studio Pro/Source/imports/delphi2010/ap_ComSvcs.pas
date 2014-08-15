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
unit ap_ComSvcs;

interface

uses
  Windows,
  Mtx,
  ActiveX,
  ComSvcs,
  Variants,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatComSvcsLibrary = class(TatScripterLibrary)
    procedure __GetLIBID_COMSVCSLib(AMachine: TatVirtualMachine);
    procedure __GetIID_ISecurityCertificateColl(AMachine: TatVirtualMachine);
    procedure __GetCLASS_SecurityCertificate(AMachine: TatVirtualMachine);
    procedure __GetIID_ISecurityIdentityColl(AMachine: TatVirtualMachine);
    procedure __GetCLASS_SecurityIdentity(AMachine: TatVirtualMachine);
    procedure __GetIID_ISecurityCallersColl(AMachine: TatVirtualMachine);
    procedure __GetCLASS_SecurityCallers(AMachine: TatVirtualMachine);
    procedure __GetIID_ISecurityCallContext(AMachine: TatVirtualMachine);
    procedure __GetCLASS_SecurityCallContext(AMachine: TatVirtualMachine);
    procedure __GetIID_IGetSecurityCallContext(AMachine: TatVirtualMachine);
    procedure __GetCLASS_GetSecurityCallContextAppObject(AMachine: TatVirtualMachine);
    procedure __GetIID_IContextState(AMachine: TatVirtualMachine);
    procedure __GetIID_IObjectContextInfo(AMachine: TatVirtualMachine);
    procedure __GetIID_IObjectConstruct(AMachine: TatVirtualMachine);
    procedure __GetIID_IObjectConstructString(AMachine: TatVirtualMachine);
    procedure __GetIID_IObjectContextTip(AMachine: TatVirtualMachine);
    procedure __GetIID_IPlaybackControl(AMachine: TatVirtualMachine);
    procedure __GetIID_ICrmCompensator(AMachine: TatVirtualMachine);
    procedure __GetIID_ICrmCompensatorVariants(AMachine: TatVirtualMachine);
    procedure __GetIID_ICrmLogControl(AMachine: TatVirtualMachine);
    procedure __GetIID_ICrmFormatLogRecords(AMachine: TatVirtualMachine);
    procedure __GetCLASS_Dummy30040732(AMachine: TatVirtualMachine);
    procedure __GetIID_ObjectControl(AMachine: TatVirtualMachine);
    procedure __GetIID_IMTxAS(AMachine: TatVirtualMachine);
    procedure __GetCLASS_AppServer(AMachine: TatVirtualMachine);
    procedure __GetIID_ObjectContext(AMachine: TatVirtualMachine);
    procedure __GetIID_SecurityProperty(AMachine: TatVirtualMachine);
    procedure __GetIID_ContextInfo(AMachine: TatVirtualMachine);
    procedure __GetIID_ICreateWithTipTransactionEx(AMachine: TatVirtualMachine);
    procedure __GetIID_ICreateWithTransactionEx(AMachine: TatVirtualMachine);
    procedure __GetCLASS_ByotServerEx(AMachine: TatVirtualMachine);
    procedure __GetIID_ITransaction(AMachine: TatVirtualMachine);
    procedure __GetIID_IMtsEvents(AMachine: TatVirtualMachine);
    procedure __GetIID_IMtsEventInfo(AMachine: TatVirtualMachine);
    procedure __GetCLASS_COMEvents(AMachine: TatVirtualMachine);
    procedure __GetIID_IMTSLocator(AMachine: TatVirtualMachine);
    procedure __GetCLASS_CoMTSLocator(AMachine: TatVirtualMachine);
    procedure __GetIID_IMtsGrp(AMachine: TatVirtualMachine);
    procedure __GetCLASS_MtsGrp(AMachine: TatVirtualMachine);
    procedure __GetIID_IComThreadEvents(AMachine: TatVirtualMachine);
    procedure __GetIID_IComUserEvent(AMachine: TatVirtualMachine);
    procedure __GetIID_IComAppEvents(AMachine: TatVirtualMachine);
    procedure __GetIID_IComInstanceEvents(AMachine: TatVirtualMachine);
    procedure __GetIID_IComTransactionEvents(AMachine: TatVirtualMachine);
    procedure __GetIID_IComMethodEvents(AMachine: TatVirtualMachine);
    procedure __GetIID_IComObjectEvents(AMachine: TatVirtualMachine);
    procedure __GetIID_IComResourceEvents(AMachine: TatVirtualMachine);
    procedure __GetIID_IComSecurityEvents(AMachine: TatVirtualMachine);
    procedure __GetIID_IComObjectPoolEvents(AMachine: TatVirtualMachine);
    procedure __GetIID_IComObjectPoolEvents2(AMachine: TatVirtualMachine);
    procedure __GetIID_IComObjectConstructionEvents(AMachine: TatVirtualMachine);
    procedure __GetIID_IComActivityEvents(AMachine: TatVirtualMachine);
    procedure __GetIID_IComIdentityEvents(AMachine: TatVirtualMachine);
    procedure __GetIID_IComQCEvents(AMachine: TatVirtualMachine);
    procedure __GetIID_IComExceptionEvents(AMachine: TatVirtualMachine);
    procedure __GetIID_IComCRMEvents(AMachine: TatVirtualMachine);
    procedure __GetCLASS_ComServiceEvents(AMachine: TatVirtualMachine);
    procedure __GetIID_ICrmMonitorLogRecords(AMachine: TatVirtualMachine);
    procedure __GetCLASS_CRMClerk(AMachine: TatVirtualMachine);
    procedure __GetIID_ICrmMonitor(AMachine: TatVirtualMachine);
    procedure __GetCLASS_CRMRecoveryClerk(AMachine: TatVirtualMachine);
    procedure __GetIID_ICrmMonitorClerks(AMachine: TatVirtualMachine);
    procedure __GetIID_ILBEvents(AMachine: TatVirtualMachine);
    procedure __GetCLASS_LBEvents(AMachine: TatVirtualMachine);
    procedure __GetIID_IMessageMover(AMachine: TatVirtualMachine);
    procedure __GetCLASS_MessageMover(AMachine: TatVirtualMachine);
    procedure __GetIID_IDispenserManager(AMachine: TatVirtualMachine);
    procedure __GetIID_IDispenserManagerShutdownGuarantee(AMachine: TatVirtualMachine);
    procedure __GetIID_IDispenserDriver(AMachine: TatVirtualMachine);
    procedure __GetIID_IHolder(AMachine: TatVirtualMachine);
    procedure __GetCLASS_DispenserManager(AMachine: TatVirtualMachine);
    procedure __GetIID_IReceiveAppData(AMachine: TatVirtualMachine);
    procedure __GetIID_IGetAppData(AMachine: TatVirtualMachine);
    procedure __GetCLASS_TrackerServer(AMachine: TatVirtualMachine);
    procedure __GetIID_IEventServer(AMachine: TatVirtualMachine);
    procedure __GetIID_IProcessTerminateNotify(AMachine: TatVirtualMachine);
    procedure __GetCLASS_EventServer(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  tagBLOBWrapper = class(TatRecordWrapper)
  private
    FcbSize: LongWord;
  public
    constructor Create(ARecord: tagBLOB);
    function ObjToRec: tagBLOB;
  published
    property cbSize: LongWord read FcbSize write FcbSize;
  end;
  
  tagCrmLogRecordReadWrapper = class(TatRecordWrapper)
  private
    FdwCrmFlags: LongWord;
    FdwSequenceNumber: LongWord;
  public
    constructor Create(ARecord: tagCrmLogRecordRead);
    function ObjToRec: tagCrmLogRecordRead;
  published
    property dwCrmFlags: LongWord read FdwCrmFlags write FdwCrmFlags;
    property dwSequenceNumber: LongWord read FdwSequenceNumber write FdwSequenceNumber;
  end;
  
  BOIDWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: BOID);
    function ObjToRec: BOID;
  published
  end;
  
  XACTTRANSINFOWrapper = class(TatRecordWrapper)
  private
    FisoLevel: Integer;
    FisoFlags: LongWord;
    FgrfTCSupported: LongWord;
    FgrfRMSupported: LongWord;
    FgrfTCSupportedRetaining: LongWord;
    FgrfRMSupportedRetaining: LongWord;
  public
    constructor Create(ARecord: XACTTRANSINFO);
    function ObjToRec: XACTTRANSINFO;
  published
    property isoLevel: Integer read FisoLevel write FisoLevel;
    property isoFlags: LongWord read FisoFlags write FisoFlags;
    property grfTCSupported: LongWord read FgrfTCSupported write FgrfTCSupported;
    property grfRMSupported: LongWord read FgrfRMSupported write FgrfRMSupported;
    property grfTCSupportedRetaining: LongWord read FgrfTCSupportedRetaining write FgrfTCSupportedRetaining;
    property grfRMSupportedRetaining: LongWord read FgrfRMSupportedRetaining write FgrfRMSupportedRetaining;
  end;
  
  __MIDL___MIDL_itf_autosvcs_0279_0001Wrapper = class(TatRecordWrapper)
  private
    FcbSize: LongWord;
    FdwPid: LongWord;
    FlTime: Int64;
    FlMicroTime: Integer;
    FperfCount: Int64;
    FguidApp: TGUID;
  public
    constructor Create(ARecord: __MIDL___MIDL_itf_autosvcs_0279_0001);
    function ObjToRec: __MIDL___MIDL_itf_autosvcs_0279_0001;
  published
    property cbSize: LongWord read FcbSize write FcbSize;
    property dwPid: LongWord read FdwPid write FdwPid;
    property lTime: Int64 read FlTime write FlTime;
    property lMicroTime: Integer read FlMicroTime write FlMicroTime;
    property perfCount: Int64 read FperfCount write FperfCount;
    property guidApp: TGUID read FguidApp write FguidApp;
  end;
  
  CAppStatisticsWrapper = class(TatRecordWrapper)
  private
    Fm_cTotalCalls: LongWord;
    Fm_cTotalInstances: LongWord;
    Fm_cTotalClasses: LongWord;
    Fm_cCallsPerSecond: LongWord;
  public
    constructor Create(ARecord: CAppStatistics);
    function ObjToRec: CAppStatistics;
  published
    property m_cTotalCalls: LongWord read Fm_cTotalCalls write Fm_cTotalCalls;
    property m_cTotalInstances: LongWord read Fm_cTotalInstances write Fm_cTotalInstances;
    property m_cTotalClasses: LongWord read Fm_cTotalClasses write Fm_cTotalClasses;
    property m_cCallsPerSecond: LongWord read Fm_cCallsPerSecond write Fm_cCallsPerSecond;
  end;
  
  CCLSIDDataWrapper = class(TatRecordWrapper)
  private
    Fm_clsid: TGUID;
    Fm_cReferences: LongWord;
    Fm_cBound: LongWord;
    Fm_cPooled: LongWord;
    Fm_cInCall: LongWord;
    Fm_dwRespTime: LongWord;
    Fm_cCallsCompleted: LongWord;
    Fm_cCallsFailed: LongWord;
  public
    constructor Create(ARecord: CCLSIDData);
    function ObjToRec: CCLSIDData;
  published
    property m_clsid: TGUID read Fm_clsid write Fm_clsid;
    property m_cReferences: LongWord read Fm_cReferences write Fm_cReferences;
    property m_cBound: LongWord read Fm_cBound write Fm_cBound;
    property m_cPooled: LongWord read Fm_cPooled write Fm_cPooled;
    property m_cInCall: LongWord read Fm_cInCall write Fm_cInCall;
    property m_dwRespTime: LongWord read Fm_dwRespTime write Fm_dwRespTime;
    property m_cCallsCompleted: LongWord read Fm_cCallsCompleted write Fm_cCallsCompleted;
    property m_cCallsFailed: LongWord read Fm_cCallsFailed write Fm_cCallsFailed;
  end;
  
  CAppDataWrapper = class(TatRecordWrapper)
  private
    Fm_idApp: LongWord;
    Fm_dwAppProcessId: LongWord;
  public
    constructor Create(ARecord: CAppData);
    function ObjToRec: CAppData;
  published
    property m_idApp: LongWord read Fm_idApp write Fm_idApp;
    property m_dwAppProcessId: LongWord read Fm_dwAppProcessId write Fm_dwAppProcessId;
  end;
  

implementation

constructor tagBLOBWrapper.Create(ARecord: tagBLOB);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
end;

function tagBLOBWrapper.ObjToRec: tagBLOB;
begin
  result.cbSize := FcbSize;
end;

constructor tagCrmLogRecordReadWrapper.Create(ARecord: tagCrmLogRecordRead);
begin
  inherited Create;
  FdwCrmFlags := ARecord.dwCrmFlags;
  FdwSequenceNumber := ARecord.dwSequenceNumber;
end;

function tagCrmLogRecordReadWrapper.ObjToRec: tagCrmLogRecordRead;
begin
  result.dwCrmFlags := FdwCrmFlags;
  result.dwSequenceNumber := FdwSequenceNumber;
end;

constructor BOIDWrapper.Create(ARecord: BOID);
begin
  inherited Create;
end;

function BOIDWrapper.ObjToRec: BOID;
begin
end;

constructor XACTTRANSINFOWrapper.Create(ARecord: XACTTRANSINFO);
begin
  inherited Create;
  FisoLevel := ARecord.isoLevel;
  FisoFlags := ARecord.isoFlags;
  FgrfTCSupported := ARecord.grfTCSupported;
  FgrfRMSupported := ARecord.grfRMSupported;
  FgrfTCSupportedRetaining := ARecord.grfTCSupportedRetaining;
  FgrfRMSupportedRetaining := ARecord.grfRMSupportedRetaining;
end;

function XACTTRANSINFOWrapper.ObjToRec: XACTTRANSINFO;
begin
  result.isoLevel := FisoLevel;
  result.isoFlags := FisoFlags;
  result.grfTCSupported := FgrfTCSupported;
  result.grfRMSupported := FgrfRMSupported;
  result.grfTCSupportedRetaining := FgrfTCSupportedRetaining;
  result.grfRMSupportedRetaining := FgrfRMSupportedRetaining;
end;

constructor __MIDL___MIDL_itf_autosvcs_0279_0001Wrapper.Create(ARecord: __MIDL___MIDL_itf_autosvcs_0279_0001);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwPid := ARecord.dwPid;
  FlTime := ARecord.lTime;
  FlMicroTime := ARecord.lMicroTime;
  FperfCount := ARecord.perfCount;
  FguidApp := ARecord.guidApp;
end;

function __MIDL___MIDL_itf_autosvcs_0279_0001Wrapper.ObjToRec: __MIDL___MIDL_itf_autosvcs_0279_0001;
begin
  result.cbSize := FcbSize;
  result.dwPid := FdwPid;
  result.lTime := FlTime;
  result.lMicroTime := FlMicroTime;
  result.perfCount := FperfCount;
  result.guidApp := FguidApp;
end;

constructor CAppStatisticsWrapper.Create(ARecord: CAppStatistics);
begin
  inherited Create;
  Fm_cTotalCalls := ARecord.m_cTotalCalls;
  Fm_cTotalInstances := ARecord.m_cTotalInstances;
  Fm_cTotalClasses := ARecord.m_cTotalClasses;
  Fm_cCallsPerSecond := ARecord.m_cCallsPerSecond;
end;

function CAppStatisticsWrapper.ObjToRec: CAppStatistics;
begin
  result.m_cTotalCalls := Fm_cTotalCalls;
  result.m_cTotalInstances := Fm_cTotalInstances;
  result.m_cTotalClasses := Fm_cTotalClasses;
  result.m_cCallsPerSecond := Fm_cCallsPerSecond;
end;

constructor CCLSIDDataWrapper.Create(ARecord: CCLSIDData);
begin
  inherited Create;
  Fm_clsid := ARecord.m_clsid;
  Fm_cReferences := ARecord.m_cReferences;
  Fm_cBound := ARecord.m_cBound;
  Fm_cPooled := ARecord.m_cPooled;
  Fm_cInCall := ARecord.m_cInCall;
  Fm_dwRespTime := ARecord.m_dwRespTime;
  Fm_cCallsCompleted := ARecord.m_cCallsCompleted;
  Fm_cCallsFailed := ARecord.m_cCallsFailed;
end;

function CCLSIDDataWrapper.ObjToRec: CCLSIDData;
begin
  result.m_clsid := Fm_clsid;
  result.m_cReferences := Fm_cReferences;
  result.m_cBound := Fm_cBound;
  result.m_cPooled := Fm_cPooled;
  result.m_cInCall := Fm_cInCall;
  result.m_dwRespTime := Fm_dwRespTime;
  result.m_cCallsCompleted := Fm_cCallsCompleted;
  result.m_cCallsFailed := Fm_cCallsFailed;
end;

constructor CAppDataWrapper.Create(ARecord: CAppData);
begin
  inherited Create;
  Fm_idApp := ARecord.m_idApp;
  Fm_dwAppProcessId := ARecord.m_dwAppProcessId;
end;

function CAppDataWrapper.ObjToRec: CAppData;
begin
  result.m_idApp := Fm_idApp;
  result.m_dwAppProcessId := Fm_dwAppProcessId;
end;



procedure TatComSvcsLibrary.__GetLIBID_COMSVCSLib(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.LIBID_COMSVCSLib)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_ISecurityCertificateColl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_ISecurityCertificateColl)));
  end;
end;

procedure TatComSvcsLibrary.__GetCLASS_SecurityCertificate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.CLASS_SecurityCertificate)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_ISecurityIdentityColl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_ISecurityIdentityColl)));
  end;
end;

procedure TatComSvcsLibrary.__GetCLASS_SecurityIdentity(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.CLASS_SecurityIdentity)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_ISecurityCallersColl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_ISecurityCallersColl)));
  end;
end;

procedure TatComSvcsLibrary.__GetCLASS_SecurityCallers(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.CLASS_SecurityCallers)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_ISecurityCallContext(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_ISecurityCallContext)));
  end;
end;

procedure TatComSvcsLibrary.__GetCLASS_SecurityCallContext(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.CLASS_SecurityCallContext)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IGetSecurityCallContext(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IGetSecurityCallContext)));
  end;
end;

procedure TatComSvcsLibrary.__GetCLASS_GetSecurityCallContextAppObject(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.CLASS_GetSecurityCallContextAppObject)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IContextState(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IContextState)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IObjectContextInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IObjectContextInfo)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IObjectConstruct(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IObjectConstruct)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IObjectConstructString(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IObjectConstructString)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IObjectContextTip(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IObjectContextTip)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IPlaybackControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IPlaybackControl)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_ICrmCompensator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_ICrmCompensator)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_ICrmCompensatorVariants(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_ICrmCompensatorVariants)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_ICrmLogControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_ICrmLogControl)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_ICrmFormatLogRecords(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_ICrmFormatLogRecords)));
  end;
end;

procedure TatComSvcsLibrary.__GetCLASS_Dummy30040732(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.CLASS_Dummy30040732)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_ObjectControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_ObjectControl)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IMTxAS(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IMTxAS)));
  end;
end;

procedure TatComSvcsLibrary.__GetCLASS_AppServer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.CLASS_AppServer)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_ObjectContext(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_ObjectContext)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_SecurityProperty(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_SecurityProperty)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_ContextInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_ContextInfo)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_ICreateWithTipTransactionEx(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_ICreateWithTipTransactionEx)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_ICreateWithTransactionEx(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_ICreateWithTransactionEx)));
  end;
end;

procedure TatComSvcsLibrary.__GetCLASS_ByotServerEx(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.CLASS_ByotServerEx)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_ITransaction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_ITransaction)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IMtsEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IMtsEvents)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IMtsEventInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IMtsEventInfo)));
  end;
end;

procedure TatComSvcsLibrary.__GetCLASS_COMEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.CLASS_COMEvents)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IMTSLocator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IMTSLocator)));
  end;
end;

procedure TatComSvcsLibrary.__GetCLASS_CoMTSLocator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.CLASS_CoMTSLocator)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IMtsGrp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IMtsGrp)));
  end;
end;

procedure TatComSvcsLibrary.__GetCLASS_MtsGrp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.CLASS_MtsGrp)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IComThreadEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IComThreadEvents)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IComUserEvent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IComUserEvent)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IComAppEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IComAppEvents)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IComInstanceEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IComInstanceEvents)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IComTransactionEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IComTransactionEvents)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IComMethodEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IComMethodEvents)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IComObjectEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IComObjectEvents)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IComResourceEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IComResourceEvents)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IComSecurityEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IComSecurityEvents)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IComObjectPoolEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IComObjectPoolEvents)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IComObjectPoolEvents2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IComObjectPoolEvents2)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IComObjectConstructionEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IComObjectConstructionEvents)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IComActivityEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IComActivityEvents)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IComIdentityEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IComIdentityEvents)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IComQCEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IComQCEvents)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IComExceptionEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IComExceptionEvents)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IComCRMEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IComCRMEvents)));
  end;
end;

procedure TatComSvcsLibrary.__GetCLASS_ComServiceEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.CLASS_ComServiceEvents)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_ICrmMonitorLogRecords(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_ICrmMonitorLogRecords)));
  end;
end;

procedure TatComSvcsLibrary.__GetCLASS_CRMClerk(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.CLASS_CRMClerk)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_ICrmMonitor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_ICrmMonitor)));
  end;
end;

procedure TatComSvcsLibrary.__GetCLASS_CRMRecoveryClerk(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.CLASS_CRMRecoveryClerk)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_ICrmMonitorClerks(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_ICrmMonitorClerks)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_ILBEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_ILBEvents)));
  end;
end;

procedure TatComSvcsLibrary.__GetCLASS_LBEvents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.CLASS_LBEvents)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IMessageMover(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IMessageMover)));
  end;
end;

procedure TatComSvcsLibrary.__GetCLASS_MessageMover(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.CLASS_MessageMover)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IDispenserManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IDispenserManager)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IDispenserManagerShutdownGuarantee(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IDispenserManagerShutdownGuarantee)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IDispenserDriver(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IDispenserDriver)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IHolder(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IHolder)));
  end;
end;

procedure TatComSvcsLibrary.__GetCLASS_DispenserManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.CLASS_DispenserManager)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IReceiveAppData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IReceiveAppData)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IGetAppData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IGetAppData)));
  end;
end;

procedure TatComSvcsLibrary.__GetCLASS_TrackerServer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.CLASS_TrackerServer)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IEventServer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IEventServer)));
  end;
end;

procedure TatComSvcsLibrary.__GetIID_IProcessTerminateNotify(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.IID_IProcessTerminateNotify)));
  end;
end;

procedure TatComSvcsLibrary.__GetCLASS_EventServer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ComSvcs.CLASS_EventServer)));
  end;
end;

procedure TatComSvcsLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineProp('LIBID_COMSVCSLib',tkVariant,__GetLIBID_COMSVCSLib,nil,nil,false,0);
    DefineProp('IID_ISecurityCertificateColl',tkVariant,__GetIID_ISecurityCertificateColl,nil,nil,false,0);
    DefineProp('CLASS_SecurityCertificate',tkVariant,__GetCLASS_SecurityCertificate,nil,nil,false,0);
    DefineProp('IID_ISecurityIdentityColl',tkVariant,__GetIID_ISecurityIdentityColl,nil,nil,false,0);
    DefineProp('CLASS_SecurityIdentity',tkVariant,__GetCLASS_SecurityIdentity,nil,nil,false,0);
    DefineProp('IID_ISecurityCallersColl',tkVariant,__GetIID_ISecurityCallersColl,nil,nil,false,0);
    DefineProp('CLASS_SecurityCallers',tkVariant,__GetCLASS_SecurityCallers,nil,nil,false,0);
    DefineProp('IID_ISecurityCallContext',tkVariant,__GetIID_ISecurityCallContext,nil,nil,false,0);
    DefineProp('CLASS_SecurityCallContext',tkVariant,__GetCLASS_SecurityCallContext,nil,nil,false,0);
    DefineProp('IID_IGetSecurityCallContext',tkVariant,__GetIID_IGetSecurityCallContext,nil,nil,false,0);
    DefineProp('CLASS_GetSecurityCallContextAppObject',tkVariant,__GetCLASS_GetSecurityCallContextAppObject,nil,nil,false,0);
    DefineProp('IID_IContextState',tkVariant,__GetIID_IContextState,nil,nil,false,0);
    DefineProp('IID_IObjectContextInfo',tkVariant,__GetIID_IObjectContextInfo,nil,nil,false,0);
    DefineProp('IID_IObjectConstruct',tkVariant,__GetIID_IObjectConstruct,nil,nil,false,0);
    DefineProp('IID_IObjectConstructString',tkVariant,__GetIID_IObjectConstructString,nil,nil,false,0);
    DefineProp('IID_IObjectContextTip',tkVariant,__GetIID_IObjectContextTip,nil,nil,false,0);
    DefineProp('IID_IPlaybackControl',tkVariant,__GetIID_IPlaybackControl,nil,nil,false,0);
    DefineProp('IID_ICrmCompensator',tkVariant,__GetIID_ICrmCompensator,nil,nil,false,0);
    DefineProp('IID_ICrmCompensatorVariants',tkVariant,__GetIID_ICrmCompensatorVariants,nil,nil,false,0);
    DefineProp('IID_ICrmLogControl',tkVariant,__GetIID_ICrmLogControl,nil,nil,false,0);
    DefineProp('IID_ICrmFormatLogRecords',tkVariant,__GetIID_ICrmFormatLogRecords,nil,nil,false,0);
    DefineProp('CLASS_Dummy30040732',tkVariant,__GetCLASS_Dummy30040732,nil,nil,false,0);
    DefineProp('IID_ObjectControl',tkVariant,__GetIID_ObjectControl,nil,nil,false,0);
    DefineProp('IID_IMTxAS',tkVariant,__GetIID_IMTxAS,nil,nil,false,0);
    DefineProp('CLASS_AppServer',tkVariant,__GetCLASS_AppServer,nil,nil,false,0);
    DefineProp('IID_ObjectContext',tkVariant,__GetIID_ObjectContext,nil,nil,false,0);
    DefineProp('IID_SecurityProperty',tkVariant,__GetIID_SecurityProperty,nil,nil,false,0);
    DefineProp('IID_ContextInfo',tkVariant,__GetIID_ContextInfo,nil,nil,false,0);
    DefineProp('IID_ICreateWithTipTransactionEx',tkVariant,__GetIID_ICreateWithTipTransactionEx,nil,nil,false,0);
    DefineProp('IID_ICreateWithTransactionEx',tkVariant,__GetIID_ICreateWithTransactionEx,nil,nil,false,0);
    DefineProp('CLASS_ByotServerEx',tkVariant,__GetCLASS_ByotServerEx,nil,nil,false,0);
    DefineProp('IID_ITransaction',tkVariant,__GetIID_ITransaction,nil,nil,false,0);
    DefineProp('IID_IMtsEvents',tkVariant,__GetIID_IMtsEvents,nil,nil,false,0);
    DefineProp('IID_IMtsEventInfo',tkVariant,__GetIID_IMtsEventInfo,nil,nil,false,0);
    DefineProp('CLASS_COMEvents',tkVariant,__GetCLASS_COMEvents,nil,nil,false,0);
    DefineProp('IID_IMTSLocator',tkVariant,__GetIID_IMTSLocator,nil,nil,false,0);
    DefineProp('CLASS_CoMTSLocator',tkVariant,__GetCLASS_CoMTSLocator,nil,nil,false,0);
    DefineProp('IID_IMtsGrp',tkVariant,__GetIID_IMtsGrp,nil,nil,false,0);
    DefineProp('CLASS_MtsGrp',tkVariant,__GetCLASS_MtsGrp,nil,nil,false,0);
    DefineProp('IID_IComThreadEvents',tkVariant,__GetIID_IComThreadEvents,nil,nil,false,0);
    DefineProp('IID_IComUserEvent',tkVariant,__GetIID_IComUserEvent,nil,nil,false,0);
    DefineProp('IID_IComAppEvents',tkVariant,__GetIID_IComAppEvents,nil,nil,false,0);
    DefineProp('IID_IComInstanceEvents',tkVariant,__GetIID_IComInstanceEvents,nil,nil,false,0);
    DefineProp('IID_IComTransactionEvents',tkVariant,__GetIID_IComTransactionEvents,nil,nil,false,0);
    DefineProp('IID_IComMethodEvents',tkVariant,__GetIID_IComMethodEvents,nil,nil,false,0);
    DefineProp('IID_IComObjectEvents',tkVariant,__GetIID_IComObjectEvents,nil,nil,false,0);
    DefineProp('IID_IComResourceEvents',tkVariant,__GetIID_IComResourceEvents,nil,nil,false,0);
    DefineProp('IID_IComSecurityEvents',tkVariant,__GetIID_IComSecurityEvents,nil,nil,false,0);
    DefineProp('IID_IComObjectPoolEvents',tkVariant,__GetIID_IComObjectPoolEvents,nil,nil,false,0);
    DefineProp('IID_IComObjectPoolEvents2',tkVariant,__GetIID_IComObjectPoolEvents2,nil,nil,false,0);
    DefineProp('IID_IComObjectConstructionEvents',tkVariant,__GetIID_IComObjectConstructionEvents,nil,nil,false,0);
    DefineProp('IID_IComActivityEvents',tkVariant,__GetIID_IComActivityEvents,nil,nil,false,0);
    DefineProp('IID_IComIdentityEvents',tkVariant,__GetIID_IComIdentityEvents,nil,nil,false,0);
    DefineProp('IID_IComQCEvents',tkVariant,__GetIID_IComQCEvents,nil,nil,false,0);
    DefineProp('IID_IComExceptionEvents',tkVariant,__GetIID_IComExceptionEvents,nil,nil,false,0);
    DefineProp('IID_IComCRMEvents',tkVariant,__GetIID_IComCRMEvents,nil,nil,false,0);
    DefineProp('CLASS_ComServiceEvents',tkVariant,__GetCLASS_ComServiceEvents,nil,nil,false,0);
    DefineProp('IID_ICrmMonitorLogRecords',tkVariant,__GetIID_ICrmMonitorLogRecords,nil,nil,false,0);
    DefineProp('CLASS_CRMClerk',tkVariant,__GetCLASS_CRMClerk,nil,nil,false,0);
    DefineProp('IID_ICrmMonitor',tkVariant,__GetIID_ICrmMonitor,nil,nil,false,0);
    DefineProp('CLASS_CRMRecoveryClerk',tkVariant,__GetCLASS_CRMRecoveryClerk,nil,nil,false,0);
    DefineProp('IID_ICrmMonitorClerks',tkVariant,__GetIID_ICrmMonitorClerks,nil,nil,false,0);
    DefineProp('IID_ILBEvents',tkVariant,__GetIID_ILBEvents,nil,nil,false,0);
    DefineProp('CLASS_LBEvents',tkVariant,__GetCLASS_LBEvents,nil,nil,false,0);
    DefineProp('IID_IMessageMover',tkVariant,__GetIID_IMessageMover,nil,nil,false,0);
    DefineProp('CLASS_MessageMover',tkVariant,__GetCLASS_MessageMover,nil,nil,false,0);
    DefineProp('IID_IDispenserManager',tkVariant,__GetIID_IDispenserManager,nil,nil,false,0);
    DefineProp('IID_IDispenserManagerShutdownGuarantee',tkVariant,__GetIID_IDispenserManagerShutdownGuarantee,nil,nil,false,0);
    DefineProp('IID_IDispenserDriver',tkVariant,__GetIID_IDispenserDriver,nil,nil,false,0);
    DefineProp('IID_IHolder',tkVariant,__GetIID_IHolder,nil,nil,false,0);
    DefineProp('CLASS_DispenserManager',tkVariant,__GetCLASS_DispenserManager,nil,nil,false,0);
    DefineProp('IID_IReceiveAppData',tkVariant,__GetIID_IReceiveAppData,nil,nil,false,0);
    DefineProp('IID_IGetAppData',tkVariant,__GetIID_IGetAppData,nil,nil,false,0);
    DefineProp('CLASS_TrackerServer',tkVariant,__GetCLASS_TrackerServer,nil,nil,false,0);
    DefineProp('IID_IEventServer',tkVariant,__GetIID_IEventServer,nil,nil,false,0);
    DefineProp('IID_IProcessTerminateNotify',tkVariant,__GetIID_IProcessTerminateNotify,nil,nil,false,0);
    DefineProp('CLASS_EventServer',tkVariant,__GetCLASS_EventServer,nil,nil,false,0);
    AddConstant('TxCommit',TxCommit);
    AddConstant('TxAbort',TxAbort);
    AddConstant('mtsErrCtxAborted',mtsErrCtxAborted);
    AddConstant('mtsErrCtxAborting',mtsErrCtxAborting);
    AddConstant('mtsErrCtxNoContext',mtsErrCtxNoContext);
    AddConstant('mtsErrCtxNotRegistered',mtsErrCtxNotRegistered);
    AddConstant('mtsErrCtxSynchTimeout',mtsErrCtxSynchTimeout);
    AddConstant('mtsErrCtxOldReference',mtsErrCtxOldReference);
    AddConstant('mtsErrCtxRoleNotFound',mtsErrCtxRoleNotFound);
    AddConstant('mtsErrCtxNoSecurity',mtsErrCtxNoSecurity);
    AddConstant('mtsErrCtxWrongThread',mtsErrCtxWrongThread);
    AddConstant('mtsErrCtxTMNotAvailable',mtsErrCtxTMNotAvailable);
    AddConstant('comQCErrApplicationNotQueued',comQCErrApplicationNotQueued);
    AddConstant('comQCErrNoQueueableInterfaces',comQCErrNoQueueableInterfaces);
    AddConstant('comQCErrQueuingServiceNotAvailable',comQCErrQueuingServiceNotAvailable);
    AddConstant('comQCErrQueueTransactMismatch',comQCErrQueueTransactMismatch);
    AddConstant('comqcErrRecorderMarshalled',comqcErrRecorderMarshalled);
    AddConstant('comqcErrOutParam',comqcErrOutParam);
    AddConstant('comqcErrRecorderNotTrusted',comqcErrRecorderNotTrusted);
    AddConstant('comqcErrPSLoad',comqcErrPSLoad);
    AddConstant('comqcErrMarshaledObjSameTxn',comqcErrMarshaledObjSameTxn);
    AddConstant('comqcErrInvalidMessage',comqcErrInvalidMessage);
    AddConstant('comqcErrMsmqSidUnavailable',comqcErrMsmqSidUnavailable);
    AddConstant('comqcErrWrongMsgExtension',comqcErrWrongMsgExtension);
    AddConstant('comqcErrMsmqServiceUnavailable',comqcErrMsmqServiceUnavailable);
    AddConstant('comqcErrMsgNotAuthenticated',comqcErrMsgNotAuthenticated);
    AddConstant('comqcErrMsmqConnectorUsed',comqcErrMsmqConnectorUsed);
    AddConstant('comqcErrBadMarshaledObject',comqcErrBadMarshaledObject);
    AddConstant('LockSetGet',LockSetGet);
    AddConstant('LockMethod',LockMethod);
    AddConstant('Standard',Standard);
    AddConstant('Process',Process);
    AddConstant('CRMFLAG_FORGETTARGET',CRMFLAG_FORGETTARGET);
    AddConstant('CRMFLAG_WRITTENDURINGPREPARE',CRMFLAG_WRITTENDURINGPREPARE);
    AddConstant('CRMFLAG_WRITTENDURINGCOMMIT',CRMFLAG_WRITTENDURINGCOMMIT);
    AddConstant('CRMFLAG_WRITTENDURINGABORT',CRMFLAG_WRITTENDURINGABORT);
    AddConstant('CRMFLAG_WRITTENDURINGRECOVERY',CRMFLAG_WRITTENDURINGRECOVERY);
    AddConstant('CRMFLAG_WRITTENDURINGREPLAY',CRMFLAG_WRITTENDURINGREPLAY);
    AddConstant('CRMFLAG_REPLAYINPROGRESS',CRMFLAG_REPLAYINPROGRESS);
    AddConstant('CRMREGFLAG_PREPAREPHASE',CRMREGFLAG_PREPAREPHASE);
    AddConstant('CRMREGFLAG_COMMITPHASE',CRMREGFLAG_COMMITPHASE);
    AddConstant('CRMREGFLAG_ABORTPHASE',CRMREGFLAG_ABORTPHASE);
    AddConstant('CRMREGFLAG_ALLPHASES',CRMREGFLAG_ALLPHASES);
    AddConstant('CRMREGFLAG_FAILIFINDOUBTSREMAIN',CRMREGFLAG_FAILIFINDOUBTSREMAIN);
    AddConstant('TxState_Active',TxState_Active);
    AddConstant('TxState_Committed',TxState_Committed);
    AddConstant('TxState_Aborted',TxState_Aborted);
    AddConstant('TxState_Indoubt',TxState_Indoubt);
  end;
end;

class function TatComSvcsLibrary.LibraryName: string;
begin
  result := 'ComSvcs';
end;

initialization
  RegisterScripterLibrary(TatComSvcsLibrary, True);

{$WARNINGS ON}

end.

