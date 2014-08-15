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
unit ap_BDE;

interface

uses
  Windows,
  DBCommonTypes,
  BDE,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatBDELibrary = class(TatScripterLibrary)
    procedure __ErrCat(AMachine: TatVirtualMachine);
    procedure __ErrCode(AMachine: TatVirtualMachine);
    procedure __DbiExit(AMachine: TatVirtualMachine);
    procedure __DbiDLLExit(AMachine: TatVirtualMachine);
    procedure __DbiGetSysVersion(AMachine: TatVirtualMachine);
    procedure __DbiGetSysConfig(AMachine: TatVirtualMachine);
    procedure __DbiGetClientInfo(AMachine: TatVirtualMachine);
    procedure __DbiGetSysInfo(AMachine: TatVirtualMachine);
    procedure __DbiLoadDriver(AMachine: TatVirtualMachine);
    procedure __DbiGetSesInfo(AMachine: TatVirtualMachine);
    procedure __DbiSetPrivateDir(AMachine: TatVirtualMachine);
    procedure __DbiGetDriverDesc(AMachine: TatVirtualMachine);
    procedure __DbiGetTableTypeDesc(AMachine: TatVirtualMachine);
    procedure __DbiGetFieldTypeDesc(AMachine: TatVirtualMachine);
    procedure __DbiGetIndexTypeDesc(AMachine: TatVirtualMachine);
    procedure __DbiCheckRefresh(AMachine: TatVirtualMachine);
    procedure __DbiSetLockRetry(AMachine: TatVirtualMachine);
    procedure __DbiGetErrorEntry(AMachine: TatVirtualMachine);
    procedure __DbiGetErrorInfo(AMachine: TatVirtualMachine);
    procedure __DbiGetErrorString(AMachine: TatVirtualMachine);
    procedure __DbiGetErrorContext(AMachine: TatVirtualMachine);
    procedure __DbiDateEncode(AMachine: TatVirtualMachine);
    procedure __DbiDateDecode(AMachine: TatVirtualMachine);
    procedure __DbiTimeEncode(AMachine: TatVirtualMachine);
    procedure __DbiTimeDecode(AMachine: TatVirtualMachine);
    procedure __DbiTimeStampEncode(AMachine: TatVirtualMachine);
    procedure __DbiTimeStampDecode(AMachine: TatVirtualMachine);
    procedure __DbiBcdFromFloat(AMachine: TatVirtualMachine);
    procedure __DbiBcdToFloat(AMachine: TatVirtualMachine);
    procedure __DbiGetDateFormat(AMachine: TatVirtualMachine);
    procedure __DbiSetDateFormat(AMachine: TatVirtualMachine);
    procedure __DbiGetTimeFormat(AMachine: TatVirtualMachine);
    procedure __DbiSetTimeFormat(AMachine: TatVirtualMachine);
    procedure __DbiGetNumberFormat(AMachine: TatVirtualMachine);
    procedure __DbiSetNumberFormat(AMachine: TatVirtualMachine);
    procedure __DbiUseIdleTime(AMachine: TatVirtualMachine);
    procedure __DbiGetLdName(AMachine: TatVirtualMachine);
    procedure __DbiAddPassword(AMachine: TatVirtualMachine);
    procedure __DbiDropPassword(AMachine: TatVirtualMachine);
    procedure __DbiGetNetUserName(AMachine: TatVirtualMachine);
    procedure __DbiDebugLayerOptions(AMachine: TatVirtualMachine);
    procedure __OsLdInit(AMachine: TatVirtualMachine);
    procedure __OsLdExit(AMachine: TatVirtualMachine);
    procedure __OsLdSetConvChars(AMachine: TatVirtualMachine);
    procedure __DbiDRDelete(AMachine: TatVirtualMachine);
    procedure __DbiDRDrop(AMachine: TatVirtualMachine);
    procedure __DbiSetDefaultRepository(AMachine: TatVirtualMachine);
    procedure __DbiGetDefaultRepository(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  _hDBIObjWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: _hDBIObj);
    function ObjToRec: _hDBIObj;
  published
  end;
  
  DBIEnvWrapper = class(TatRecordWrapper)
  private
    FbForceLocalInit: WordBool;
  public
    constructor Create(ARecord: DBIEnv);
    function ObjToRec: DBIEnv;
  published
    property bForceLocalInit: WordBool read FbForceLocalInit write FbForceLocalInit;
  end;
  
  SYSVersionWrapper = class(TatRecordWrapper)
  private
    FiVersion: Word;
    FiIntfLevel: Word;
    FdateVer: DBIDATE;
    FtimeVer: Time;
  public
    constructor Create(ARecord: SYSVersion);
    function ObjToRec: SYSVersion;
  published
    property iVersion: Word read FiVersion write FiVersion;
    property iIntfLevel: Word read FiIntfLevel write FiIntfLevel;
    property dateVer: DBIDATE read FdateVer write FdateVer;
    property timeVer: Time read FtimeVer write FtimeVer;
  end;
  
  SYSConfigWrapper = class(TatRecordWrapper)
  private
    FbLocalShare: WordBool;
    FiNetProtocol: Word;
    FbNetShare: WordBool;
  public
    constructor Create(ARecord: SYSConfig);
    function ObjToRec: SYSConfig;
  published
    property bLocalShare: WordBool read FbLocalShare write FbLocalShare;
    property iNetProtocol: Word read FiNetProtocol write FiNetProtocol;
    property bNetShare: WordBool read FbNetShare write FbNetShare;
  end;
  
  SYSInfoWrapper = class(TatRecordWrapper)
  private
    FiBufferSpace: Word;
    FiHeapSpace: Word;
    FiDrivers: Word;
    FiClients: Word;
    FiSessions: Word;
    FiDatabases: Word;
    FiCursors: Word;
  public
    constructor Create(ARecord: SYSInfo);
    function ObjToRec: SYSInfo;
  published
    property iBufferSpace: Word read FiBufferSpace write FiBufferSpace;
    property iHeapSpace: Word read FiHeapSpace write FiHeapSpace;
    property iDrivers: Word read FiDrivers write FiDrivers;
    property iClients: Word read FiClients write FiClients;
    property iSessions: Word read FiSessions write FiSessions;
    property iDatabases: Word read FiDatabases write FiDatabases;
    property iCursors: Word read FiCursors write FiCursors;
  end;
  
  CLIENTInfoWrapper = class(TatRecordWrapper)
  private
    FiSessions: Word;
  public
    constructor Create(ARecord: CLIENTInfo);
    function ObjToRec: CLIENTInfo;
  published
    property iSessions: Word read FiSessions write FiSessions;
  end;
  
  SESInfoWrapper = class(TatRecordWrapper)
  private
    FiSession: Word;
    FiDatabases: Word;
    FiCursors: Word;
    FiLockWait: SmallInt;
  public
    constructor Create(ARecord: SESInfo);
    function ObjToRec: SESInfo;
  published
    property iSession: Word read FiSession write FiSession;
    property iDatabases: Word read FiDatabases write FiDatabases;
    property iCursors: Word read FiCursors write FiCursors;
    property iLockWait: SmallInt read FiLockWait write FiLockWait;
  end;
  
  FLDDescWrapper = class(TatRecordWrapper)
  private
    FiFldNum: Word;
    FiFldType: Word;
    FiSubType: Word;
    FiUnits1: SmallInt;
    FiUnits2: SmallInt;
    FiOffset: Word;
    FiLen: Word;
    FiNullOffset: Word;
    FefldvVchk: FLDVchk;
    FefldrRights: FLDRights;
    FbCalcField: WordBool;
  public
    constructor Create(ARecord: FLDDesc);
    function ObjToRec: FLDDesc;
  published
    property iFldNum: Word read FiFldNum write FiFldNum;
    property iFldType: Word read FiFldType write FiFldType;
    property iSubType: Word read FiSubType write FiSubType;
    property iUnits1: SmallInt read FiUnits1 write FiUnits1;
    property iUnits2: SmallInt read FiUnits2 write FiUnits2;
    property iOffset: Word read FiOffset write FiOffset;
    property iLen: Word read FiLen write FiLen;
    property iNullOffset: Word read FiNullOffset write FiNullOffset;
    property efldvVchk: FLDVchk read FefldvVchk write FefldvVchk;
    property efldrRights: FLDRights read FefldrRights write FefldrRights;
    property bCalcField: WordBool read FbCalcField write FbCalcField;
  end;
  
  BLOBParamDescWrapper = class(TatRecordWrapper)
  private
    FulBlobLen: Integer;
  public
    constructor Create(ARecord: BLOBParamDesc);
    function ObjToRec: BLOBParamDesc;
  published
    property ulBlobLen: Integer read FulBlobLen write FulBlobLen;
  end;
  
  IDXDescWrapper = class(TatRecordWrapper)
  private
    FiIndexId: Word;
    FbPrimary: WordBool;
    FbUnique: WordBool;
    FbDescending: WordBool;
    FbMaintained: WordBool;
    FbSubset: WordBool;
    FbExpIdx: WordBool;
    FiCost: Word;
    FiFldsInKey: Word;
    FiKeyLen: Word;
    FbOutofDate: WordBool;
    FiKeyExpType: Word;
    FbCaseInsensitive: WordBool;
    FiBlockSize: Word;
    FiRestrNum: Word;
  public
    constructor Create(ARecord: IDXDesc);
    function ObjToRec: IDXDesc;
  published
    property iIndexId: Word read FiIndexId write FiIndexId;
    property bPrimary: WordBool read FbPrimary write FbPrimary;
    property bUnique: WordBool read FbUnique write FbUnique;
    property bDescending: WordBool read FbDescending write FbDescending;
    property bMaintained: WordBool read FbMaintained write FbMaintained;
    property bSubset: WordBool read FbSubset write FbSubset;
    property bExpIdx: WordBool read FbExpIdx write FbExpIdx;
    property iCost: Word read FiCost write FiCost;
    property iFldsInKey: Word read FiFldsInKey write FiFldsInKey;
    property iKeyLen: Word read FiKeyLen write FiKeyLen;
    property bOutofDate: WordBool read FbOutofDate write FbOutofDate;
    property iKeyExpType: Word read FiKeyExpType write FiKeyExpType;
    property bCaseInsensitive: WordBool read FbCaseInsensitive write FbCaseInsensitive;
    property iBlockSize: Word read FiBlockSize write FiBlockSize;
    property iRestrNum: Word read FiRestrNum write FiRestrNum;
  end;
  
  VCHKDescWrapper = class(TatRecordWrapper)
  private
    FiFldNum: Word;
    FbRequired: WordBool;
    FbHasMinVal: WordBool;
    FbHasMaxVal: WordBool;
    FbHasDefVal: WordBool;
    FelkupType: LKUPType;
  public
    constructor Create(ARecord: VCHKDesc);
    function ObjToRec: VCHKDesc;
  published
    property iFldNum: Word read FiFldNum write FiFldNum;
    property bRequired: WordBool read FbRequired write FbRequired;
    property bHasMinVal: WordBool read FbHasMinVal write FbHasMinVal;
    property bHasMaxVal: WordBool read FbHasMaxVal write FbHasMaxVal;
    property bHasDefVal: WordBool read FbHasDefVal write FbHasDefVal;
    property elkupType: LKUPType read FelkupType write FelkupType;
  end;
  
  RINTDescWrapper = class(TatRecordWrapper)
  private
    FiRintNum: Word;
    FeType: RINTType;
    FeModOp: RINTQual;
    FeDelOp: RINTQual;
    FiFldCount: Word;
  public
    constructor Create(ARecord: RINTDesc);
    function ObjToRec: RINTDesc;
  published
    property iRintNum: Word read FiRintNum write FiRintNum;
    property eType: RINTType read FeType write FeType;
    property eModOp: RINTQual read FeModOp write FeModOp;
    property eDelOp: RINTQual read FeDelOp write FeDelOp;
    property iFldCount: Word read FiFldCount write FiFldCount;
  end;
  
  SECDescWrapper = class(TatRecordWrapper)
  private
    FiSecNum: Word;
    FeprvTable: PrvType;
    FiFamRights: Word;
  public
    constructor Create(ARecord: SECDesc);
    function ObjToRec: SECDesc;
  published
    property iSecNum: Word read FiSecNum write FiSecNum;
    property eprvTable: PrvType read FeprvTable write FeprvTable;
    property iFamRights: Word read FiFamRights write FiFamRights;
  end;
  
  ObjAttrDescWrapper = class(TatRecordWrapper)
  private
    FiFldNum: Word;
  public
    constructor Create(ARecord: ObjAttrDesc);
    function ObjToRec: ObjAttrDesc;
  published
    property iFldNum: Word read FiFldNum write FiFldNum;
  end;
  
  ObjTypeDescWrapper = class(TatRecordWrapper)
  private
    FiFldNum: Word;
  public
    constructor Create(ARecord: ObjTypeDesc);
    function ObjToRec: ObjTypeDesc;
  published
    property iFldNum: Word read FiFldNum write FiFldNum;
  end;
  
  ObjParentDescWrapper = class(TatRecordWrapper)
  private
    FiFldNum: Word;
    FiParentFldNum: Word;
  public
    constructor Create(ARecord: ObjParentDesc);
    function ObjToRec: ObjParentDesc;
  published
    property iFldNum: Word read FiFldNum write FiFldNum;
    property iParentFldNum: Word read FiParentFldNum write FiParentFldNum;
  end;
  
  ServerColDescWrapper = class(TatRecordWrapper)
  private
    FiFldNum: Word;
    FbServerCol: WordBool;
  public
    constructor Create(ARecord: ServerColDesc);
    function ObjToRec: ServerColDesc;
  published
    property iFldNum: Word read FiFldNum write FiFldNum;
    property bServerCol: WordBool read FbServerCol write FbServerCol;
  end;
  
  CURPropsWrapper = class(TatRecordWrapper)
  private
    FiFNameSize: Word;
    FiFields: Word;
    FiRecSize: Word;
    FiRecBufSize: Word;
    FiKeySize: Word;
    FiIndexes: Word;
    FiValChecks: Word;
    FiRefIntChecks: Word;
    FiBookMarkSize: Word;
    FbBookMarkStable: WordBool;
    FeOpenMode: DBIOpenMode;
    FeShareMode: DBIShareMode;
    FbIndexed: WordBool;
    FiSeqNums: SmallInt;
    FbSoftDeletes: WordBool;
    FbDeletedOn: WordBool;
    FiRefRange: Word;
    FexltMode: XLTMode;
    FiRestrVersion: Word;
    FbUniDirectional: WordBool;
    FeprvRights: Word;
    FDummy4: Word;
    FiFmlRights: Word;
    FiPasswords: Word;
    FiCodePage: Word;
    FbProtected: WordBool;
    FiTblLevel: Word;
    FbFieldMap: WordBool;
    FiBlockSize: Word;
    FbStrictRefInt: WordBool;
    FiFilters: Word;
    FbTempTable: WordBool;
  public
    constructor Create(ARecord: CURProps);
    function ObjToRec: CURProps;
  published
    property iFNameSize: Word read FiFNameSize write FiFNameSize;
    property iFields: Word read FiFields write FiFields;
    property iRecSize: Word read FiRecSize write FiRecSize;
    property iRecBufSize: Word read FiRecBufSize write FiRecBufSize;
    property iKeySize: Word read FiKeySize write FiKeySize;
    property iIndexes: Word read FiIndexes write FiIndexes;
    property iValChecks: Word read FiValChecks write FiValChecks;
    property iRefIntChecks: Word read FiRefIntChecks write FiRefIntChecks;
    property iBookMarkSize: Word read FiBookMarkSize write FiBookMarkSize;
    property bBookMarkStable: WordBool read FbBookMarkStable write FbBookMarkStable;
    property eOpenMode: DBIOpenMode read FeOpenMode write FeOpenMode;
    property eShareMode: DBIShareMode read FeShareMode write FeShareMode;
    property bIndexed: WordBool read FbIndexed write FbIndexed;
    property iSeqNums: SmallInt read FiSeqNums write FiSeqNums;
    property bSoftDeletes: WordBool read FbSoftDeletes write FbSoftDeletes;
    property bDeletedOn: WordBool read FbDeletedOn write FbDeletedOn;
    property iRefRange: Word read FiRefRange write FiRefRange;
    property exltMode: XLTMode read FexltMode write FexltMode;
    property iRestrVersion: Word read FiRestrVersion write FiRestrVersion;
    property bUniDirectional: WordBool read FbUniDirectional write FbUniDirectional;
    property eprvRights: Word read FeprvRights write FeprvRights;
    property Dummy4: Word read FDummy4 write FDummy4;
    property iFmlRights: Word read FiFmlRights write FiFmlRights;
    property iPasswords: Word read FiPasswords write FiPasswords;
    property iCodePage: Word read FiCodePage write FiCodePage;
    property bProtected: WordBool read FbProtected write FbProtected;
    property iTblLevel: Word read FiTblLevel write FiTblLevel;
    property bFieldMap: WordBool read FbFieldMap write FbFieldMap;
    property iBlockSize: Word read FiBlockSize write FiBlockSize;
    property bStrictRefInt: WordBool read FbStrictRefInt write FbStrictRefInt;
    property iFilters: Word read FiFilters write FiFilters;
    property bTempTable: WordBool read FbTempTable write FbTempTable;
  end;
  
  RECPropsWrapper = class(TatRecordWrapper)
  private
    FiSeqNum: Longint;
    FiPhyRecNum: Longint;
    FiRecStatus: Word;
    FbSeqNumChanged: WordBool;
    FbDeleteFlag: WordBool;
  public
    constructor Create(ARecord: RECProps);
    function ObjToRec: RECProps;
  published
    property iSeqNum: Longint read FiSeqNum write FiSeqNum;
    property iPhyRecNum: Longint read FiPhyRecNum write FiPhyRecNum;
    property iRecStatus: Word read FiRecStatus write FiRecStatus;
    property bSeqNumChanged: WordBool read FbSeqNumChanged write FbSeqNumChanged;
    property bDeleteFlag: WordBool read FbDeleteFlag write FbDeleteFlag;
  end;
  
  XInfoWrapper = class(TatRecordWrapper)
  private
    FexState: eXState;
    FeXIL: eXILType;
    FuNests: Word;
  public
    constructor Create(ARecord: XInfo);
    function ObjToRec: XInfo;
  published
    property exState: eXState read FexState write FexState;
    property eXIL: eXILType read FeXIL write FeXIL;
    property uNests: Word read FuNests write FuNests;
  end;
  
  CRTblDescWrapper = class(TatRecordWrapper)
  private
    FbProtected: WordBool;
    FbPack: WordBool;
    FiFldCount: Word;
    FiIdxCount: Word;
    FiSecRecCount: Word;
    FiValChkCount: Word;
    FiRintCount: Word;
    FiOptParams: Word;
  public
    constructor Create(ARecord: CRTblDesc);
    function ObjToRec: CRTblDesc;
  published
    property bProtected: WordBool read FbProtected write FbProtected;
    property bPack: WordBool read FbPack write FbPack;
    property iFldCount: Word read FiFldCount write FiFldCount;
    property iIdxCount: Word read FiIdxCount write FiIdxCount;
    property iSecRecCount: Word read FiSecRecCount write FiSecRecCount;
    property iValChkCount: Word read FiValChkCount write FiValChkCount;
    property iRintCount: Word read FiRintCount write FiRintCount;
    property iOptParams: Word read FiOptParams write FiOptParams;
  end;
  
  BATTblDescWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: BATTblDesc);
    function ObjToRec: BATTblDesc;
  published
  end;
  
  DRVTypeWrapper = class(TatRecordWrapper)
  private
    FedrvCat: DRVCat;
    FbTrueDb: WordBool;
    FbMultiUser: WordBool;
    FbReadWrite: WordBool;
    FbTrans: WordBool;
    FbPassThruSQL: WordBool;
    FbLogIn: WordBool;
    FbCreateDb: WordBool;
    FbDeleteDb: WordBool;
    FbCreateTable: WordBool;
    FbDeleteTable: WordBool;
    FbMultiplePWs: WordBool;
    FiDriverVersion: Word;
    FbSQLRowid: WordBool;
  public
    constructor Create(ARecord: DRVType);
    function ObjToRec: DRVType;
  published
    property edrvCat: DRVCat read FedrvCat write FedrvCat;
    property bTrueDb: WordBool read FbTrueDb write FbTrueDb;
    property bMultiUser: WordBool read FbMultiUser write FbMultiUser;
    property bReadWrite: WordBool read FbReadWrite write FbReadWrite;
    property bTrans: WordBool read FbTrans write FbTrans;
    property bPassThruSQL: WordBool read FbPassThruSQL write FbPassThruSQL;
    property bLogIn: WordBool read FbLogIn write FbLogIn;
    property bCreateDb: WordBool read FbCreateDb write FbCreateDb;
    property bDeleteDb: WordBool read FbDeleteDb write FbDeleteDb;
    property bCreateTable: WordBool read FbCreateTable write FbCreateTable;
    property bDeleteTable: WordBool read FbDeleteTable write FbDeleteTable;
    property bMultiplePWs: WordBool read FbMultiplePWs write FbMultiplePWs;
    property iDriverVersion: Word read FiDriverVersion write FiDriverVersion;
    property bSQLRowid: WordBool read FbSQLRowid write FbSQLRowid;
  end;
  
  TBLTypeWrapper = class(TatRecordWrapper)
  private
    FiId: Word;
    FbReadWrite: WordBool;
    FbCreate: WordBool;
    FbRestructure: WordBool;
    FbValChecks: WordBool;
    FbSecurity: WordBool;
    FbRefIntegrity: WordBool;
    FbPrimaryKey: WordBool;
    FbIndexing: WordBool;
    FiFldTypes: Word;
    FiMaxRecSize: Word;
    FiMaxFldsInTable: Word;
    FiMaxFldNameLen: Word;
    FiTblLevel: Word;
  public
    constructor Create(ARecord: TBLType);
    function ObjToRec: TBLType;
  published
    property iId: Word read FiId write FiId;
    property bReadWrite: WordBool read FbReadWrite write FbReadWrite;
    property bCreate: WordBool read FbCreate write FbCreate;
    property bRestructure: WordBool read FbRestructure write FbRestructure;
    property bValChecks: WordBool read FbValChecks write FbValChecks;
    property bSecurity: WordBool read FbSecurity write FbSecurity;
    property bRefIntegrity: WordBool read FbRefIntegrity write FbRefIntegrity;
    property bPrimaryKey: WordBool read FbPrimaryKey write FbPrimaryKey;
    property bIndexing: WordBool read FbIndexing write FbIndexing;
    property iFldTypes: Word read FiFldTypes write FiFldTypes;
    property iMaxRecSize: Word read FiMaxRecSize write FiMaxRecSize;
    property iMaxFldsInTable: Word read FiMaxFldsInTable write FiMaxFldsInTable;
    property iMaxFldNameLen: Word read FiMaxFldNameLen write FiMaxFldNameLen;
    property iTblLevel: Word read FiTblLevel write FiTblLevel;
  end;
  
  IDXTypeWrapper = class(TatRecordWrapper)
  private
    FiId: Word;
    FbComposite: WordBool;
    FbPrimary: WordBool;
    FbUnique: WordBool;
    FbKeyDescending: WordBool;
    FbFldDescending: WordBool;
    FbMaintained: WordBool;
    FbSubset: WordBool;
    FbKeyExpr: WordBool;
    FbCaseInsensitive: WordBool;
  public
    constructor Create(ARecord: IDXType);
    function ObjToRec: IDXType;
  published
    property iId: Word read FiId write FiId;
    property bComposite: WordBool read FbComposite write FbComposite;
    property bPrimary: WordBool read FbPrimary write FbPrimary;
    property bUnique: WordBool read FbUnique write FbUnique;
    property bKeyDescending: WordBool read FbKeyDescending write FbKeyDescending;
    property bFldDescending: WordBool read FbFldDescending write FbFldDescending;
    property bMaintained: WordBool read FbMaintained write FbMaintained;
    property bSubset: WordBool read FbSubset write FbSubset;
    property bKeyExpr: WordBool read FbKeyExpr write FbKeyExpr;
    property bCaseInsensitive: WordBool read FbCaseInsensitive write FbCaseInsensitive;
  end;
  
  FLDTypeWrapper = class(TatRecordWrapper)
  private
    FiId: Word;
    FiPhyType: Word;
    FiXltType: Word;
    FiXltSubType: Word;
    FiMaxUnits1: Word;
    FiMaxUnits2: Word;
    FiPhySize: Word;
    FbRequired: WordBool;
    FbDefaultVal: WordBool;
    FbMinVal: WordBool;
    FbMaxVal: WordBool;
    FbRefIntegrity: WordBool;
    FbOtherChecks: WordBool;
    FbKeyed: WordBool;
    FbMultiplePerTable: WordBool;
    FiMinUnits1: Word;
    FiMinUnits2: Word;
    FbCreateable: WordBool;
  public
    constructor Create(ARecord: FLDType);
    function ObjToRec: FLDType;
  published
    property iId: Word read FiId write FiId;
    property iPhyType: Word read FiPhyType write FiPhyType;
    property iXltType: Word read FiXltType write FiXltType;
    property iXltSubType: Word read FiXltSubType write FiXltSubType;
    property iMaxUnits1: Word read FiMaxUnits1 write FiMaxUnits1;
    property iMaxUnits2: Word read FiMaxUnits2 write FiMaxUnits2;
    property iPhySize: Word read FiPhySize write FiPhySize;
    property bRequired: WordBool read FbRequired write FbRequired;
    property bDefaultVal: WordBool read FbDefaultVal write FbDefaultVal;
    property bMinVal: WordBool read FbMinVal write FbMinVal;
    property bMaxVal: WordBool read FbMaxVal write FbMaxVal;
    property bRefIntegrity: WordBool read FbRefIntegrity write FbRefIntegrity;
    property bOtherChecks: WordBool read FbOtherChecks write FbOtherChecks;
    property bKeyed: WordBool read FbKeyed write FbKeyed;
    property bMultiplePerTable: WordBool read FbMultiplePerTable write FbMultiplePerTable;
    property iMinUnits1: Word read FiMinUnits1 write FiMinUnits1;
    property iMinUnits2: Word read FiMinUnits2 write FiMinUnits2;
    property bCreateable: WordBool read FbCreateable write FbCreateable;
  end;
  
  CBPROGRESSDescWrapper = class(TatRecordWrapper)
  private
    FiPercentDone: SmallInt;
  public
    constructor Create(ARecord: CBPROGRESSDesc);
    function ObjToRec: CBPROGRESSDesc;
  published
    property iPercentDone: SmallInt read FiPercentDone write FiPercentDone;
  end;
  
  DELAYUPDCbDescWrapper = class(TatRecordWrapper)
  private
    FiErrCode: DBIResult;
    FeDelayUpdOpType: DelayUpdErrOpType;
    FiRecBufSize: Word;
  public
    constructor Create(ARecord: DELAYUPDCbDesc);
    function ObjToRec: DELAYUPDCbDesc;
  published
    property iErrCode: DBIResult read FiErrCode write FiErrCode;
    property eDelayUpdOpType: DelayUpdErrOpType read FeDelayUpdOpType write FeDelayUpdOpType;
    property iRecBufSize: Word read FiRecBufSize write FiRecBufSize;
  end;
  
  TCBDBLoginWrapper = class(TatRecordWrapper)
  private
    FeOpenMode: DBIOpenMode;
    FeShareMode: DBIShareMode;
    FbCallbackToClose: Bool;
  public
    constructor Create(ARecord: TCBDBLogin);
    function ObjToRec: TCBDBLogin;
  published
    property eOpenMode: DBIOpenMode read FeOpenMode write FeOpenMode;
    property eShareMode: DBIShareMode read FeShareMode write FeShareMode;
    property bCallbackToClose: Bool read FbCallbackToClose write FbCallbackToClose;
  end;
  
  TRACEDescWrapper = class(TatRecordWrapper)
  private
    FeTraceCat: TRACECat;
    FuTotalMsgLen: Word;
  public
    constructor Create(ARecord: TRACEDesc);
    function ObjToRec: TRACEDesc;
  published
    property eTraceCat: TRACECat read FeTraceCat write FeTraceCat;
    property uTotalMsgLen: Word read FuTotalMsgLen write FuTotalMsgLen;
  end;
  
  TuObjDescWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: TuObjDesc);
    function ObjToRec: TuObjDesc;
  published
  end;
  
  RESTCbDescWrapper = class(TatRecordWrapper)
  private
    FiErrCode: DBIResult;
    FiTblNum: Word;
    FiObjNum: Word;
    FeRestrObjType: RESTErrObjType;
  public
    constructor Create(ARecord: RESTCbDesc);
    function ObjToRec: RESTCbDesc;
  published
    property iErrCode: DBIResult read FiErrCode write FiErrCode;
    property iTblNum: Word read FiTblNum write FiTblNum;
    property iObjNum: Word read FiObjNum write FiObjNum;
    property eRestrObjType: RESTErrObjType read FeRestrObjType write FeRestrObjType;
  end;
  
  CBEntryWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: CBEntry);
    function ObjToRec: CBEntry;
  published
  end;
  
  CBInputDescWrapper = class(TatRecordWrapper)
  private
    FeCbInputId: CBInputId;
    FiCount: SmallInt;
    FiSelection: SmallInt;
    FbSave: WordBool;
  public
    constructor Create(ARecord: CBInputDesc);
    function ObjToRec: CBInputDesc;
  published
    property eCbInputId: CBInputId read FeCbInputId write FeCbInputId;
    property iCount: SmallInt read FiCount write FiCount;
    property iSelection: SmallInt read FiSelection write FiSelection;
    property bSave: WordBool read FbSave write FbSave;
  end;
  
  CBLoginDescWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: CBLoginDesc);
    function ObjToRec: CBLoginDesc;
  published
  end;
  
  FMTNumberWrapper = class(TatRecordWrapper)
  private
    FcDecimalSeparator: AnsiChar;
    FcThousandSeparator: AnsiChar;
    FiDecimalDigits: Byte;
    FbLeadingZero: Boolean;
  public
    constructor Create(ARecord: FMTNumber);
    function ObjToRec: FMTNumber;
  published
    property cDecimalSeparator: AnsiChar read FcDecimalSeparator write FcDecimalSeparator;
    property cThousandSeparator: AnsiChar read FcThousandSeparator write FcThousandSeparator;
    property iDecimalDigits: Byte read FiDecimalDigits write FiDecimalDigits;
    property bLeadingZero: Boolean read FbLeadingZero write FbLeadingZero;
  end;
  
  FMTDateWrapper = class(TatRecordWrapper)
  private
    FiDateMode: Byte;
    FbFourDigitYear: Boolean;
    FbYearBiased: Boolean;
    FbMonthLeadingZero: Boolean;
    FbDayLeadingZero: Boolean;
  public
    constructor Create(ARecord: FMTDate);
    function ObjToRec: FMTDate;
  published
    property iDateMode: Byte read FiDateMode write FiDateMode;
    property bFourDigitYear: Boolean read FbFourDigitYear write FbFourDigitYear;
    property bYearBiased: Boolean read FbYearBiased write FbYearBiased;
    property bMonthLeadingZero: Boolean read FbMonthLeadingZero write FbMonthLeadingZero;
    property bDayLeadingZero: Boolean read FbDayLeadingZero write FbDayLeadingZero;
  end;
  
  FMTTimeWrapper = class(TatRecordWrapper)
  private
    FcTimeSeparator: AnsiChar;
    FbTwelveHour: Boolean;
    FbSeconds: Boolean;
    FbMilSeconds: Boolean;
  public
    constructor Create(ARecord: FMTTime);
    function ObjToRec: FMTTime;
  published
    property cTimeSeparator: AnsiChar read FcTimeSeparator write FcTimeSeparator;
    property bTwelveHour: Boolean read FbTwelveHour write FbTwelveHour;
    property bSeconds: Boolean read FbSeconds write FbSeconds;
    property bMilSeconds: Boolean read FbMilSeconds write FbMilSeconds;
  end;
  
  FMTBcdWrapper = class(TatRecordWrapper)
  private
    FiPrecision: Byte;
    FiSignSpecialPlaces: Byte;
  public
    constructor Create(ARecord: FMTBcd);
    function ObjToRec: FMTBcd;
  published
    property iPrecision: Byte read FiPrecision write FiPrecision;
    property iSignSpecialPlaces: Byte read FiSignSpecialPlaces write FiSignSpecialPlaces;
  end;
  
  DBIErrInfoWrapper = class(TatRecordWrapper)
  private
    FiError: DBIResult;
  public
    constructor Create(ARecord: DBIErrInfo);
    function ObjToRec: DBIErrInfo;
  published
    property iError: DBIResult read FiError write FiError;
  end;
  
  DBDescWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: DBDesc);
    function ObjToRec: DBDesc;
  published
  end;
  
  USERDescWrapper = class(TatRecordWrapper)
  private
    FiNetSession: Word;
    FiProductClass: Word;
  public
    constructor Create(ARecord: USERDesc);
    function ObjToRec: USERDesc;
  published
    property iNetSession: Word read FiNetSession write FiNetSession;
    property iProductClass: Word read FiProductClass write FiProductClass;
  end;
  
  TBLBaseDescWrapper = class(TatRecordWrapper)
  private
    FdtDate: DBIDATE;
    FtmTime: Time;
    FiSize: Longint;
    FbView: WordBool;
    FbSynonym: WordBool;
  public
    constructor Create(ARecord: TBLBaseDesc);
    function ObjToRec: TBLBaseDesc;
  published
    property dtDate: DBIDATE read FdtDate write FdtDate;
    property tmTime: Time read FtmTime write FtmTime;
    property iSize: Longint read FiSize write FiSize;
    property bView: WordBool read FbView write FbView;
    property bSynonym: WordBool read FbSynonym write FbSynonym;
  end;
  
  TBLExtDescWrapper = class(TatRecordWrapper)
  private
    FiRestrVersion: Word;
    FiRecSize: Word;
    FiFields: Word;
    FiIndexes: Word;
    FiValChecks: Word;
    FiRintChecks: Word;
    FiRecords: Longint;
    FbProtected: WordBool;
    FbValidInfo: WordBool;
  public
    constructor Create(ARecord: TBLExtDesc);
    function ObjToRec: TBLExtDesc;
  published
    property iRestrVersion: Word read FiRestrVersion write FiRestrVersion;
    property iRecSize: Word read FiRecSize write FiRecSize;
    property iFields: Word read FiFields write FiFields;
    property iIndexes: Word read FiIndexes write FiIndexes;
    property iValChecks: Word read FiValChecks write FiValChecks;
    property iRintChecks: Word read FiRintChecks write FiRintChecks;
    property iRecords: Longint read FiRecords write FiRecords;
    property bProtected: WordBool read FbProtected write FbProtected;
    property bValidInfo: WordBool read FbValidInfo write FbValidInfo;
  end;
  
  TBLFullDescWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: TBLFullDesc);
    function ObjToRec: TBLFullDesc;
  published
  end;
  
  FILEDescWrapper = class(TatRecordWrapper)
  private
    FbDir: WordBool;
    FiSize: Longint;
    FdtDate: DBIDATE;
    FtmTime: Time;
  public
    constructor Create(ARecord: FILEDesc);
    function ObjToRec: FILEDesc;
  published
    property bDir: WordBool read FbDir write FbDir;
    property iSize: Longint read FiSize write FiSize;
    property dtDate: DBIDATE read FdtDate write FdtDate;
    property tmTime: Time read FtmTime write FtmTime;
  end;
  
  SPDescWrapper = class(TatRecordWrapper)
  private
    FdtDate: DBIDATE;
    FtmTime: Time;
  public
    constructor Create(ARecord: SPDesc);
    function ObjToRec: SPDesc;
  published
    property dtDate: DBIDATE read FdtDate write FdtDate;
    property tmTime: Time read FtmTime write FtmTime;
  end;
  
  SPParamDescWrapper = class(TatRecordWrapper)
  private
    FuParamNum: Word;
    FeParamType: STMTParamType;
    FuFldType: Word;
    FuSubType: Word;
    FiUnits1: SmallInt;
    FiUnits2: SmallInt;
    FuOffset: Word;
    FuLen: Word;
    FuNullOffset: Word;
  public
    constructor Create(ARecord: SPParamDesc);
    function ObjToRec: SPParamDesc;
  published
    property uParamNum: Word read FuParamNum write FuParamNum;
    property eParamType: STMTParamType read FeParamType write FeParamType;
    property uFldType: Word read FuFldType write FuFldType;
    property uSubType: Word read FuSubType write FuSubType;
    property iUnits1: SmallInt read FiUnits1 write FiUnits1;
    property iUnits2: SmallInt read FiUnits2 write FiUnits2;
    property uOffset: Word read FuOffset write FuOffset;
    property uLen: Word read FuLen write FuLen;
    property uNullOffset: Word read FuNullOffset write FuNullOffset;
  end;
  
  DBIFUNCDescWrapper = class(TatRecordWrapper)
  private
    FuOverload: Word;
    FeStdFn: DBISTDFuncs;
  public
    constructor Create(ARecord: DBIFUNCDesc);
    function ObjToRec: DBIFUNCDesc;
  published
    property uOverload: Word read FuOverload write FuOverload;
    property eStdFn: DBISTDFuncs read FeStdFn write FeStdFn;
  end;
  
  DBIFUNCArgDescWrapper = class(TatRecordWrapper)
  private
    FuArgNum: Word;
    FuFldType: Word;
    FuSubType: Word;
    FufuncFlags: Word;
  public
    constructor Create(ARecord: DBIFUNCArgDesc);
    function ObjToRec: DBIFUNCArgDesc;
  published
    property uArgNum: Word read FuArgNum write FuArgNum;
    property uFldType: Word read FuFldType write FuFldType;
    property uSubType: Word read FuSubType write FuSubType;
    property ufuncFlags: Word read FufuncFlags write FufuncFlags;
  end;
  
  CFGDescWrapper = class(TatRecordWrapper)
  private
    FiDataType: Word;
    FbHasSubnodes: WordBool;
  public
    constructor Create(ARecord: CFGDesc);
    function ObjToRec: CFGDesc;
  published
    property iDataType: Word read FiDataType write FiDataType;
    property bHasSubnodes: WordBool read FbHasSubnodes write FbHasSubnodes;
  end;
  
  FMLDescWrapper = class(TatRecordWrapper)
  private
    FiId: Word;
    FeType: FMLType;
  public
    constructor Create(ARecord: FMLDesc);
    function ObjToRec: FMLDesc;
  published
    property iId: Word read FiId write FiId;
    property eType: FMLType read FeType write FeType;
  end;
  
  LDDescWrapper = class(TatRecordWrapper)
  private
    FiCodePage: Word;
    FPrimaryCpPlatform: Word;
    FAlternateCpPlatform: Word;
  public
    constructor Create(ARecord: LDDesc);
    function ObjToRec: LDDesc;
  published
    property iCodePage: Word read FiCodePage write FiCodePage;
    property PrimaryCpPlatform: Word read FPrimaryCpPlatform write FPrimaryCpPlatform;
    property AlternateCpPlatform: Word read FAlternateCpPlatform write FAlternateCpPlatform;
  end;
  
  LOCKDescWrapper = class(TatRecordWrapper)
  private
    FiType: Word;
    FiNetSession: Word;
    FiSession: Word;
    FiRecNum: Longint;
    FiInfo: Word;
  public
    constructor Create(ARecord: LOCKDesc);
    function ObjToRec: LOCKDesc;
  published
    property iType: Word read FiType write FiType;
    property iNetSession: Word read FiNetSession write FiNetSession;
    property iSession: Word read FiSession write FiSession;
    property iRecNum: Longint read FiRecNum write FiRecNum;
    property iInfo: Word read FiInfo write FiInfo;
  end;
  
  CANHdrWrapper = class(TatRecordWrapper)
  private
    FnodeClass: NODEClass;
    FcanOp: CANOp;
  public
    constructor Create(ARecord: CANHdr);
    function ObjToRec: CANHdr;
  published
    property nodeClass: NODEClass read FnodeClass write FnodeClass;
    property canOp: CANOp read FcanOp write FcanOp;
  end;
  
  CANUnaryWrapper = class(TatRecordWrapper)
  private
    FnodeClass: NODEClass;
    FcanOp: CANOp;
    FiOperand1: Word;
  public
    constructor Create(ARecord: CANUnary);
    function ObjToRec: CANUnary;
  published
    property nodeClass: NODEClass read FnodeClass write FnodeClass;
    property canOp: CANOp read FcanOp write FcanOp;
    property iOperand1: Word read FiOperand1 write FiOperand1;
  end;
  
  CANBinaryWrapper = class(TatRecordWrapper)
  private
    FnodeClass: NODEClass;
    FcanOp: CANOp;
    FiOperand1: Word;
    FiOperand2: Word;
  public
    constructor Create(ARecord: CANBinary);
    function ObjToRec: CANBinary;
  published
    property nodeClass: NODEClass read FnodeClass write FnodeClass;
    property canOp: CANOp read FcanOp write FcanOp;
    property iOperand1: Word read FiOperand1 write FiOperand1;
    property iOperand2: Word read FiOperand2 write FiOperand2;
  end;
  
  CANFieldWrapper = class(TatRecordWrapper)
  private
    FnodeClass: NODEClass;
    FcanOp: CANOp;
    FiFieldNum: Word;
    FiNameOffset: Word;
  public
    constructor Create(ARecord: CANField);
    function ObjToRec: CANField;
  published
    property nodeClass: NODEClass read FnodeClass write FnodeClass;
    property canOp: CANOp read FcanOp write FcanOp;
    property iFieldNum: Word read FiFieldNum write FiFieldNum;
    property iNameOffset: Word read FiNameOffset write FiNameOffset;
  end;
  
  CANConstWrapper = class(TatRecordWrapper)
  private
    FnodeClass: NODEClass;
    FcanOp: CANOp;
    FiType: Word;
    FiSize: Word;
    FiOffset: Word;
  public
    constructor Create(ARecord: CANConst);
    function ObjToRec: CANConst;
  published
    property nodeClass: NODEClass read FnodeClass write FnodeClass;
    property canOp: CANOp read FcanOp write FcanOp;
    property iType: Word read FiType write FiType;
    property iSize: Word read FiSize write FiSize;
    property iOffset: Word read FiOffset write FiOffset;
  end;
  
  CANTupleWrapper = class(TatRecordWrapper)
  private
    FnodeClass: NODEClass;
    FcanOp: CANOp;
    FiSize: Word;
  public
    constructor Create(ARecord: CANTuple);
    function ObjToRec: CANTuple;
  published
    property nodeClass: NODEClass read FnodeClass write FnodeClass;
    property canOp: CANOp read FcanOp write FcanOp;
    property iSize: Word read FiSize write FiSize;
  end;
  
  CANContinueWrapper = class(TatRecordWrapper)
  private
    FnodeClass: NODEClass;
    FcanOp: CANOp;
    FiContOperand: Word;
  public
    constructor Create(ARecord: CANContinue);
    function ObjToRec: CANContinue;
  published
    property nodeClass: NODEClass read FnodeClass write FnodeClass;
    property canOp: CANOp read FcanOp write FcanOp;
    property iContOperand: Word read FiContOperand write FiContOperand;
  end;
  
  CANCompareWrapper = class(TatRecordWrapper)
  private
    FnodeClass: NODEClass;
    FcanOp: CANOp;
    FbCaseInsensitive: WordBool;
    FiPartialLen: Word;
    FiOperand1: Word;
    FiOperand2: Word;
  public
    constructor Create(ARecord: CANCompare);
    function ObjToRec: CANCompare;
  published
    property nodeClass: NODEClass read FnodeClass write FnodeClass;
    property canOp: CANOp read FcanOp write FcanOp;
    property bCaseInsensitive: WordBool read FbCaseInsensitive write FbCaseInsensitive;
    property iPartialLen: Word read FiPartialLen write FiPartialLen;
    property iOperand1: Word read FiOperand1 write FiOperand1;
    property iOperand2: Word read FiOperand2 write FiOperand2;
  end;
  
  CANFuncWrapper = class(TatRecordWrapper)
  private
    FnodeClass: NODEClass;
    FcanOp: CANOp;
    FiNameOffset: Word;
    FiElemOffset: Word;
  public
    constructor Create(ARecord: CANFunc);
    function ObjToRec: CANFunc;
  published
    property nodeClass: NODEClass read FnodeClass write FnodeClass;
    property canOp: CANOp read FcanOp write FcanOp;
    property iNameOffset: Word read FiNameOffset write FiNameOffset;
    property iElemOffset: Word read FiElemOffset write FiElemOffset;
  end;
  
  CANListElemWrapper = class(TatRecordWrapper)
  private
    FnodeClass: NODEClass;
    FcanOp: CANOp;
    FiOffset: Word;
    FiNextOffset: Word;
  public
    constructor Create(ARecord: CANListElem);
    function ObjToRec: CANListElem;
  published
    property nodeClass: NODEClass read FnodeClass write FnodeClass;
    property canOp: CANOp read FcanOp write FcanOp;
    property iOffset: Word read FiOffset write FiOffset;
    property iNextOffset: Word read FiNextOffset write FiNextOffset;
  end;
  
  CANUdfWrapper = class(TatRecordWrapper)
  private
    FnodeClass: NODEClass;
    FcanOp: CANOp;
    FiOffSzFuncName: Word;
    FiOperands: Word;
    FiDrvDialect: Word;
    FiOffSzUDF: Word;
  public
    constructor Create(ARecord: CANUdf);
    function ObjToRec: CANUdf;
  published
    property nodeClass: NODEClass read FnodeClass write FnodeClass;
    property canOp: CANOp read FcanOp write FcanOp;
    property iOffSzFuncName: Word read FiOffSzFuncName write FiOffSzFuncName;
    property iOperands: Word read FiOperands write FiOperands;
    property iDrvDialect: Word read FiDrvDialect write FiDrvDialect;
    property iOffSzUDF: Word read FiOffSzUDF write FiOffSzUDF;
  end;
  
  CANListWrapper = class(TatRecordWrapper)
  private
    FnodeClass: NODEClass;
    FcanOp: CANOp;
    FiType: Word;
    FiTotalSize: Word;
    FiElemSize: Word;
    FiElems: Word;
    FiOffset: Word;
  public
    constructor Create(ARecord: CANList);
    function ObjToRec: CANList;
  published
    property nodeClass: NODEClass read FnodeClass write FnodeClass;
    property canOp: CANOp read FcanOp write FcanOp;
    property iType: Word read FiType write FiType;
    property iTotalSize: Word read FiTotalSize write FiTotalSize;
    property iElemSize: Word read FiElemSize write FiElemSize;
    property iElems: Word read FiElems write FiElems;
    property iOffset: Word read FiOffset write FiOffset;
  end;
  
  CANNodeWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: CANNode);
    function ObjToRec: CANNode;
  published
  end;
  
  CANExprWrapper = class(TatRecordWrapper)
  private
    FiVer: Word;
    FiTotalSize: Word;
    FiNodes: Word;
    FiNodeStart: Word;
    FiLiteralStart: Word;
  public
    constructor Create(ARecord: CANExpr);
    function ObjToRec: CANExpr;
  published
    property iVer: Word read FiVer write FiVer;
    property iTotalSize: Word read FiTotalSize write FiTotalSize;
    property iNodes: Word read FiNodes write FiNodes;
    property iNodeStart: Word read FiNodeStart write FiNodeStart;
    property iLiteralStart: Word read FiLiteralStart write FiLiteralStart;
  end;
  
  FILTERInfoWrapper = class(TatRecordWrapper)
  private
    FiFilterId: Word;
    FiClientData: Longint;
    FiPriority: Word;
    FbCanAbort: WordBool;
    FbActive: WordBool;
  public
    constructor Create(ARecord: FILTERInfo);
    function ObjToRec: FILTERInfo;
  published
    property iFilterId: Word read FiFilterId write FiFilterId;
    property iClientData: Longint read FiClientData write FiClientData;
    property iPriority: Word read FiPriority write FiPriority;
    property bCanAbort: WordBool read FbCanAbort write FbCanAbort;
    property bActive: WordBool read FbActive write FbActive;
  end;
  
  DBIQryPropWrapper = class(TatRecordWrapper)
  private
    FeLang: DBIQryLang;
    FiQryPrice: SmallInt;
    FiNumTables: SmallInt;
    FbHasAnswer: WordBool;
    FbInsert: WordBool;
    FbDelete: WordBool;
    FbChange: WordBool;
  public
    constructor Create(ARecord: DBIQryProp);
    function ObjToRec: DBIQryProp;
  published
    property eLang: DBIQryLang read FeLang write FeLang;
    property iQryPrice: SmallInt read FiQryPrice write FiQryPrice;
    property iNumTables: SmallInt read FiNumTables write FiNumTables;
    property bHasAnswer: WordBool read FbHasAnswer write FbHasAnswer;
    property bInsert: WordBool read FbInsert write FbInsert;
    property bDelete: WordBool read FbDelete write FbDelete;
    property bChange: WordBool read FbChange write FbChange;
  end;
  
  DBIQryProgressWrapper = class(TatRecordWrapper)
  private
    FstepsInQry: Word;
    FstepsCompleted: Word;
    FtotElemInStep: Longint;
    FelemCompleted: Longint;
  public
    constructor Create(ARecord: DBIQryProgress);
    function ObjToRec: DBIQryProgress;
  published
    property stepsInQry: Word read FstepsInQry write FstepsInQry;
    property stepsCompleted: Word read FstepsCompleted write FstepsCompleted;
    property totElemInStep: Longint read FtotElemInStep write FtotElemInStep;
    property elemCompleted: Longint read FelemCompleted write FelemCompleted;
  end;
  
  QueryLowPropsWrapper = class(TatRecordWrapper)
  private
    Flength: SmallInt;
    Fblankzeroes: WordBool;
    FbNeedAuxTbls: WordBool;
    FqryMode: QryEvalMode;
    FperQrySqlMode: WordBool;
    FlivenessDesired: LIVENESS;
  public
    constructor Create(ARecord: QueryLowProps);
    function ObjToRec: QueryLowProps;
  published
    property length: SmallInt read Flength write Flength;
    property blankzeroes: WordBool read Fblankzeroes write Fblankzeroes;
    property bNeedAuxTbls: WordBool read FbNeedAuxTbls write FbNeedAuxTbls;
    property qryMode: QryEvalMode read FqryMode write FqryMode;
    property perQrySqlMode: WordBool read FperQrySqlMode write FperQrySqlMode;
    property livenessDesired: LIVENESS read FlivenessDesired write FlivenessDesired;
  end;
  
  LISTWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: LIST);
    function ObjToRec: LIST;
  published
  end;
  
  SQLRelationWrapper = class(TatRecordWrapper)
  private
    FesType: SQLType;
    FerType: REQType;
    FbRelQuote: Bool;
    FiRowId: Smallint;
    FiRowNo: Smallint;
  public
    constructor Create(ARecord: SQLRelation);
    function ObjToRec: SQLRelation;
  published
    property esType: SQLType read FesType write FesType;
    property erType: REQType read FerType write FerType;
    property bRelQuote: Bool read FbRelQuote write FbRelQuote;
    property iRowId: Smallint read FiRowId write FiRowId;
    property iRowNo: Smallint read FiRowNo write FiRowNo;
  end;
  
  SQLColumnWrapper = class(TatRecordWrapper)
  private
    FesType: SQLType;
    FbColQuote: Bool;
    FbColAlQuote: Bool;
    FeCheck: CHECKType;
    FiColAggr: Smallint;
    FiColExmpl: Integer;
  public
    constructor Create(ARecord: SQLColumn);
    function ObjToRec: SQLColumn;
  published
    property esType: SQLType read FesType write FesType;
    property bColQuote: Bool read FbColQuote write FbColQuote;
    property bColAlQuote: Bool read FbColAlQuote write FbColAlQuote;
    property eCheck: CHECKType read FeCheck write FeCheck;
    property iColAggr: Smallint read FiColAggr write FiColAggr;
    property iColExmpl: Integer read FiColExmpl write FiColExmpl;
  end;
  
  SQLConstantWrapper = class(TatRecordWrapper)
  private
    FesType: SQLType;
  public
    constructor Create(ARecord: SQLConstant);
    function ObjToRec: SQLConstant;
  published
    property esType: SQLType read FesType write FesType;
  end;
  
  SQLExprWrapper = class(TatRecordWrapper)
  private
    FesType: SQLType;
    FeOp: SQLOp;
  public
    constructor Create(ARecord: SQLExpr);
    function ObjToRec: SQLExpr;
  published
    property esType: SQLType read FesType write FesType;
    property eOp: SQLOp read FeOp write FeOp;
  end;
  
  SQLAggrWrapper = class(TatRecordWrapper)
  private
    FesType: SQLType;
    FiAggr: Smallint;
    FbProjAggr: Bool;
  public
    constructor Create(ARecord: SQLAggr);
    function ObjToRec: SQLAggr;
  published
    property esType: SQLType read FesType write FesType;
    property iAggr: Smallint read FiAggr write FiAggr;
    property bProjAggr: Bool read FbProjAggr write FbProjAggr;
  end;
  
  SQLCellWrapper = class(TatRecordWrapper)
  private
    FesType: SQLType;
    FiRow: Integer;
  public
    constructor Create(ARecord: SQLCell);
    function ObjToRec: SQLCell;
  published
    property esType: SQLType read FesType write FesType;
    property iRow: Integer read FiRow write FiRow;
  end;
  
  SQLObjectWrapper = class(TatRecordWrapper)
  private
    FesType: SQLType;
  public
    constructor Create(ARecord: SQLObject);
    function ObjToRec: SQLObject;
  published
    property esType: SQLType read FesType write FesType;
  end;
  
  TSQLRequestWrapper = class(TatRecordWrapper)
  private
    FiVersion: Word;
    FiMemMark: Integer;
    FerType: REQType;
    FiParams: Integer;
    FiOptions: Integer;
    FiDistinct: Integer;
  public
    constructor Create(ARecord: TSQLRequest);
    function ObjToRec: TSQLRequest;
  published
    property iVersion: Word read FiVersion write FiVersion;
    property iMemMark: Integer read FiMemMark write FiMemMark;
    property erType: REQType read FerType write FerType;
    property iParams: Integer read FiParams write FiParams;
    property iOptions: Integer read FiOptions write FiOptions;
    property iDistinct: Integer read FiDistinct write FiDistinct;
  end;
  
  STMTBaseDescWrapper = class(TatRecordWrapper)
  private
    FbExpression: Bool;
    FbAggregate: Bool;
    FbConstant: Bool;
  public
    constructor Create(ARecord: STMTBaseDesc);
    function ObjToRec: STMTBaseDesc;
  published
    property bExpression: Bool read FbExpression write FbExpression;
    property bAggregate: Bool read FbAggregate write FbAggregate;
    property bConstant: Bool read FbConstant write FbConstant;
  end;
  
  TOSBLObjWrapper = class(TatRecordWrapper)
  private
    FLangId: SmallInt;
    FCodeSet: SmallInt;
    FLocaleType: SmallInt;
    FLanguageSortType: SmallInt;
    FLocaleCount: SmallInt;
    FPrimaryCpPlatform: SmallInt;
    FPrimaryCodePageID: Word;
    FAlternateCodePageID: Word;
    FProductID: Word;
    FNoConversions: Bool;
    FLdLCID: Integer;
  public
    constructor Create(ARecord: TOSBLObj);
    function ObjToRec: TOSBLObj;
  published
    property LangId: SmallInt read FLangId write FLangId;
    property CodeSet: SmallInt read FCodeSet write FCodeSet;
    property LocaleType: SmallInt read FLocaleType write FLocaleType;
    property LanguageSortType: SmallInt read FLanguageSortType write FLanguageSortType;
    property LocaleCount: SmallInt read FLocaleCount write FLocaleCount;
    property PrimaryCpPlatform: SmallInt read FPrimaryCpPlatform write FPrimaryCpPlatform;
    property PrimaryCodePageID: Word read FPrimaryCodePageID write FPrimaryCodePageID;
    property AlternateCodePageID: Word read FAlternateCodePageID write FAlternateCodePageID;
    property ProductID: Word read FProductID write FProductID;
    property NoConversions: Bool read FNoConversions write FNoConversions;
    property LdLCID: Integer read FLdLCID write FLdLCID;
  end;
  
  DRDescWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: DRDesc);
    function ObjToRec: DRDesc;
  published
  end;
  
  DROBJDescWrapper = class(TatRecordWrapper)
  private
    FulObjId: Longint;
    FiVersion: Word;
  public
    constructor Create(ARecord: DROBJDesc);
    function ObjToRec: DROBJDesc;
  published
    property ulObjId: Longint read FulObjId write FulObjId;
    property iVersion: Word read FiVersion write FiVersion;
  end;
  
  DRExportDescWrapper = class(TatRecordWrapper)
  private
    FbInclRelated: Bool;
  public
    constructor Create(ARecord: DRExportDesc);
    function ObjToRec: DRExportDesc;
  published
    property bInclRelated: Bool read FbInclRelated write FbInclRelated;
  end;
  
  DROBJTypeWrapper = class(TatRecordWrapper)
  private
    FiNumAttr: Word;
    FiNumRel: Word;
    FulObjFlag: Longint;
  public
    constructor Create(ARecord: DROBJType);
    function ObjToRec: DROBJType;
  published
    property iNumAttr: Word read FiNumAttr write FiNumAttr;
    property iNumRel: Word read FiNumRel write FiNumRel;
    property ulObjFlag: Longint read FulObjFlag write FulObjFlag;
  end;
  
  DBIEnumFldWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: DBIEnumFld);
    function ObjToRec: DBIEnumFld;
  published
  end;
  
  DREnumAttrDomainWrapper = class(TatRecordWrapper)
  private
    FulEDProp: Longint;
    FiNumVals: Word;
  public
    constructor Create(ARecord: DREnumAttrDomain);
    function ObjToRec: DREnumAttrDomain;
  published
    property ulEDProp: Longint read FulEDProp write FulEDProp;
    property iNumVals: Word read FiNumVals write FiNumVals;
  end;
  
  DRATTRDescWrapper = class(TatRecordWrapper)
  private
    FiAttrType: Word;
    FiUnits1: Word;
    FiUnits2: Word;
    FbReqd: WordBool;
    FulAttrFlag: Longint;
    FiDisplayProp: Word;
    FiExtendedFlag: Word;
    FbReadOnly: WordBool;
    FiEditProp: Word;
    FulTag: Longint;
  public
    constructor Create(ARecord: DRATTRDesc);
    function ObjToRec: DRATTRDesc;
  published
    property iAttrType: Word read FiAttrType write FiAttrType;
    property iUnits1: Word read FiUnits1 write FiUnits1;
    property iUnits2: Word read FiUnits2 write FiUnits2;
    property bReqd: WordBool read FbReqd write FbReqd;
    property ulAttrFlag: Longint read FulAttrFlag write FulAttrFlag;
    property iDisplayProp: Word read FiDisplayProp write FiDisplayProp;
    property iExtendedFlag: Word read FiExtendedFlag write FiExtendedFlag;
    property bReadOnly: WordBool read FbReadOnly write FbReadOnly;
    property iEditProp: Word read FiEditProp write FiEditProp;
    property ulTag: Longint read FulTag write FulTag;
  end;
  
  DRRELTypeWrapper = class(TatRecordWrapper)
  private
    FiNumAttr: Word;
    FeRelConstraint: eRELConstraint;
    FeRelCategory: eRELCategory;
    FulRelFlag: Longint;
  public
    constructor Create(ARecord: DRRELType);
    function ObjToRec: DRRELType;
  published
    property iNumAttr: Word read FiNumAttr write FiNumAttr;
    property eRelConstraint: eRELConstraint read FeRelConstraint write FeRelConstraint;
    property eRelCategory: eRELCategory read FeRelCategory write FeRelCategory;
    property ulRelFlag: Longint read FulRelFlag write FulRelFlag;
  end;
  
  DRObjectWrapper = class(TatRecordWrapper)
  private
    FulObjId: Longint;
    FiVersion: Word;
  public
    constructor Create(ARecord: DRObject);
    function ObjToRec: DRObject;
  published
    property ulObjId: Longint read FulObjId write FulObjId;
    property iVersion: Word read FiVersion write FiVersion;
  end;
  
  DataSourcesWrapper = class(TatRecordWrapper)
  private
    FiNumElem: Word;
    FbRequired: BOOL;
  public
    constructor Create(ARecord: DataSources);
    function ObjToRec: DataSources;
  published
    property iNumElem: Word read FiNumElem write FiNumElem;
    property bRequired: BOOL read FbRequired write FbRequired;
  end;
  

implementation

constructor _hDBIObjWrapper.Create(ARecord: _hDBIObj);
begin
  inherited Create;
end;

function _hDBIObjWrapper.ObjToRec: _hDBIObj;
begin
end;

constructor DBIEnvWrapper.Create(ARecord: DBIEnv);
begin
  inherited Create;
  FbForceLocalInit := ARecord.bForceLocalInit;
end;

function DBIEnvWrapper.ObjToRec: DBIEnv;
begin
  result.bForceLocalInit := FbForceLocalInit;
end;

constructor SYSVersionWrapper.Create(ARecord: SYSVersion);
begin
  inherited Create;
  FiVersion := ARecord.iVersion;
  FiIntfLevel := ARecord.iIntfLevel;
  FdateVer := ARecord.dateVer;
  FtimeVer := ARecord.timeVer;
end;

function SYSVersionWrapper.ObjToRec: SYSVersion;
begin
  result.iVersion := FiVersion;
  result.iIntfLevel := FiIntfLevel;
  result.dateVer := FdateVer;
  result.timeVer := FtimeVer;
end;

constructor SYSConfigWrapper.Create(ARecord: SYSConfig);
begin
  inherited Create;
  FbLocalShare := ARecord.bLocalShare;
  FiNetProtocol := ARecord.iNetProtocol;
  FbNetShare := ARecord.bNetShare;
end;

function SYSConfigWrapper.ObjToRec: SYSConfig;
begin
  result.bLocalShare := FbLocalShare;
  result.iNetProtocol := FiNetProtocol;
  result.bNetShare := FbNetShare;
end;

constructor SYSInfoWrapper.Create(ARecord: SYSInfo);
begin
  inherited Create;
  FiBufferSpace := ARecord.iBufferSpace;
  FiHeapSpace := ARecord.iHeapSpace;
  FiDrivers := ARecord.iDrivers;
  FiClients := ARecord.iClients;
  FiSessions := ARecord.iSessions;
  FiDatabases := ARecord.iDatabases;
  FiCursors := ARecord.iCursors;
end;

function SYSInfoWrapper.ObjToRec: SYSInfo;
begin
  result.iBufferSpace := FiBufferSpace;
  result.iHeapSpace := FiHeapSpace;
  result.iDrivers := FiDrivers;
  result.iClients := FiClients;
  result.iSessions := FiSessions;
  result.iDatabases := FiDatabases;
  result.iCursors := FiCursors;
end;

constructor CLIENTInfoWrapper.Create(ARecord: CLIENTInfo);
begin
  inherited Create;
  FiSessions := ARecord.iSessions;
end;

function CLIENTInfoWrapper.ObjToRec: CLIENTInfo;
begin
  result.iSessions := FiSessions;
end;

constructor SESInfoWrapper.Create(ARecord: SESInfo);
begin
  inherited Create;
  FiSession := ARecord.iSession;
  FiDatabases := ARecord.iDatabases;
  FiCursors := ARecord.iCursors;
  FiLockWait := ARecord.iLockWait;
end;

function SESInfoWrapper.ObjToRec: SESInfo;
begin
  result.iSession := FiSession;
  result.iDatabases := FiDatabases;
  result.iCursors := FiCursors;
  result.iLockWait := FiLockWait;
end;

constructor FLDDescWrapper.Create(ARecord: FLDDesc);
begin
  inherited Create;
  FiFldNum := ARecord.iFldNum;
  FiFldType := ARecord.iFldType;
  FiSubType := ARecord.iSubType;
  FiUnits1 := ARecord.iUnits1;
  FiUnits2 := ARecord.iUnits2;
  FiOffset := ARecord.iOffset;
  FiLen := ARecord.iLen;
  FiNullOffset := ARecord.iNullOffset;
  FefldvVchk := ARecord.efldvVchk;
  FefldrRights := ARecord.efldrRights;
  FbCalcField := ARecord.bCalcField;
end;

function FLDDescWrapper.ObjToRec: FLDDesc;
begin
  result.iFldNum := FiFldNum;
  result.iFldType := FiFldType;
  result.iSubType := FiSubType;
  result.iUnits1 := FiUnits1;
  result.iUnits2 := FiUnits2;
  result.iOffset := FiOffset;
  result.iLen := FiLen;
  result.iNullOffset := FiNullOffset;
  result.efldvVchk := FefldvVchk;
  result.efldrRights := FefldrRights;
  result.bCalcField := FbCalcField;
end;

constructor BLOBParamDescWrapper.Create(ARecord: BLOBParamDesc);
begin
  inherited Create;
  FulBlobLen := ARecord.ulBlobLen;
end;

function BLOBParamDescWrapper.ObjToRec: BLOBParamDesc;
begin
  result.ulBlobLen := FulBlobLen;
end;

constructor IDXDescWrapper.Create(ARecord: IDXDesc);
begin
  inherited Create;
  FiIndexId := ARecord.iIndexId;
  FbPrimary := ARecord.bPrimary;
  FbUnique := ARecord.bUnique;
  FbDescending := ARecord.bDescending;
  FbMaintained := ARecord.bMaintained;
  FbSubset := ARecord.bSubset;
  FbExpIdx := ARecord.bExpIdx;
  FiCost := ARecord.iCost;
  FiFldsInKey := ARecord.iFldsInKey;
  FiKeyLen := ARecord.iKeyLen;
  FbOutofDate := ARecord.bOutofDate;
  FiKeyExpType := ARecord.iKeyExpType;
  FbCaseInsensitive := ARecord.bCaseInsensitive;
  FiBlockSize := ARecord.iBlockSize;
  FiRestrNum := ARecord.iRestrNum;
end;

function IDXDescWrapper.ObjToRec: IDXDesc;
begin
  result.iIndexId := FiIndexId;
  result.bPrimary := FbPrimary;
  result.bUnique := FbUnique;
  result.bDescending := FbDescending;
  result.bMaintained := FbMaintained;
  result.bSubset := FbSubset;
  result.bExpIdx := FbExpIdx;
  result.iCost := FiCost;
  result.iFldsInKey := FiFldsInKey;
  result.iKeyLen := FiKeyLen;
  result.bOutofDate := FbOutofDate;
  result.iKeyExpType := FiKeyExpType;
  result.bCaseInsensitive := FbCaseInsensitive;
  result.iBlockSize := FiBlockSize;
  result.iRestrNum := FiRestrNum;
end;

constructor VCHKDescWrapper.Create(ARecord: VCHKDesc);
begin
  inherited Create;
  FiFldNum := ARecord.iFldNum;
  FbRequired := ARecord.bRequired;
  FbHasMinVal := ARecord.bHasMinVal;
  FbHasMaxVal := ARecord.bHasMaxVal;
  FbHasDefVal := ARecord.bHasDefVal;
  FelkupType := ARecord.elkupType;
end;

function VCHKDescWrapper.ObjToRec: VCHKDesc;
begin
  result.iFldNum := FiFldNum;
  result.bRequired := FbRequired;
  result.bHasMinVal := FbHasMinVal;
  result.bHasMaxVal := FbHasMaxVal;
  result.bHasDefVal := FbHasDefVal;
  result.elkupType := FelkupType;
end;

constructor RINTDescWrapper.Create(ARecord: RINTDesc);
begin
  inherited Create;
  FiRintNum := ARecord.iRintNum;
  FeType := ARecord.eType;
  FeModOp := ARecord.eModOp;
  FeDelOp := ARecord.eDelOp;
  FiFldCount := ARecord.iFldCount;
end;

function RINTDescWrapper.ObjToRec: RINTDesc;
begin
  result.iRintNum := FiRintNum;
  result.eType := FeType;
  result.eModOp := FeModOp;
  result.eDelOp := FeDelOp;
  result.iFldCount := FiFldCount;
end;

constructor SECDescWrapper.Create(ARecord: SECDesc);
begin
  inherited Create;
  FiSecNum := ARecord.iSecNum;
  FeprvTable := ARecord.eprvTable;
  FiFamRights := ARecord.iFamRights;
end;

function SECDescWrapper.ObjToRec: SECDesc;
begin
  result.iSecNum := FiSecNum;
  result.eprvTable := FeprvTable;
  result.iFamRights := FiFamRights;
end;

constructor ObjAttrDescWrapper.Create(ARecord: ObjAttrDesc);
begin
  inherited Create;
  FiFldNum := ARecord.iFldNum;
end;

function ObjAttrDescWrapper.ObjToRec: ObjAttrDesc;
begin
  result.iFldNum := FiFldNum;
end;

constructor ObjTypeDescWrapper.Create(ARecord: ObjTypeDesc);
begin
  inherited Create;
  FiFldNum := ARecord.iFldNum;
end;

function ObjTypeDescWrapper.ObjToRec: ObjTypeDesc;
begin
  result.iFldNum := FiFldNum;
end;

constructor ObjParentDescWrapper.Create(ARecord: ObjParentDesc);
begin
  inherited Create;
  FiFldNum := ARecord.iFldNum;
  FiParentFldNum := ARecord.iParentFldNum;
end;

function ObjParentDescWrapper.ObjToRec: ObjParentDesc;
begin
  result.iFldNum := FiFldNum;
  result.iParentFldNum := FiParentFldNum;
end;

constructor ServerColDescWrapper.Create(ARecord: ServerColDesc);
begin
  inherited Create;
  FiFldNum := ARecord.iFldNum;
  FbServerCol := ARecord.bServerCol;
end;

function ServerColDescWrapper.ObjToRec: ServerColDesc;
begin
  result.iFldNum := FiFldNum;
  result.bServerCol := FbServerCol;
end;

constructor CURPropsWrapper.Create(ARecord: CURProps);
begin
  inherited Create;
  FiFNameSize := ARecord.iFNameSize;
  FiFields := ARecord.iFields;
  FiRecSize := ARecord.iRecSize;
  FiRecBufSize := ARecord.iRecBufSize;
  FiKeySize := ARecord.iKeySize;
  FiIndexes := ARecord.iIndexes;
  FiValChecks := ARecord.iValChecks;
  FiRefIntChecks := ARecord.iRefIntChecks;
  FiBookMarkSize := ARecord.iBookMarkSize;
  FbBookMarkStable := ARecord.bBookMarkStable;
  FeOpenMode := ARecord.eOpenMode;
  FeShareMode := ARecord.eShareMode;
  FbIndexed := ARecord.bIndexed;
  FiSeqNums := ARecord.iSeqNums;
  FbSoftDeletes := ARecord.bSoftDeletes;
  FbDeletedOn := ARecord.bDeletedOn;
  FiRefRange := ARecord.iRefRange;
  FexltMode := ARecord.exltMode;
  FiRestrVersion := ARecord.iRestrVersion;
  FbUniDirectional := ARecord.bUniDirectional;
  FeprvRights := ARecord.eprvRights;
  FDummy4 := ARecord.Dummy4;
  FiFmlRights := ARecord.iFmlRights;
  FiPasswords := ARecord.iPasswords;
  FiCodePage := ARecord.iCodePage;
  FbProtected := ARecord.bProtected;
  FiTblLevel := ARecord.iTblLevel;
  FbFieldMap := ARecord.bFieldMap;
  FiBlockSize := ARecord.iBlockSize;
  FbStrictRefInt := ARecord.bStrictRefInt;
  FiFilters := ARecord.iFilters;
  FbTempTable := ARecord.bTempTable;
end;

function CURPropsWrapper.ObjToRec: CURProps;
begin
  result.iFNameSize := FiFNameSize;
  result.iFields := FiFields;
  result.iRecSize := FiRecSize;
  result.iRecBufSize := FiRecBufSize;
  result.iKeySize := FiKeySize;
  result.iIndexes := FiIndexes;
  result.iValChecks := FiValChecks;
  result.iRefIntChecks := FiRefIntChecks;
  result.iBookMarkSize := FiBookMarkSize;
  result.bBookMarkStable := FbBookMarkStable;
  result.eOpenMode := FeOpenMode;
  result.eShareMode := FeShareMode;
  result.bIndexed := FbIndexed;
  result.iSeqNums := FiSeqNums;
  result.bSoftDeletes := FbSoftDeletes;
  result.bDeletedOn := FbDeletedOn;
  result.iRefRange := FiRefRange;
  result.exltMode := FexltMode;
  result.iRestrVersion := FiRestrVersion;
  result.bUniDirectional := FbUniDirectional;
  result.eprvRights := FeprvRights;
  result.Dummy4 := FDummy4;
  result.iFmlRights := FiFmlRights;
  result.iPasswords := FiPasswords;
  result.iCodePage := FiCodePage;
  result.bProtected := FbProtected;
  result.iTblLevel := FiTblLevel;
  result.bFieldMap := FbFieldMap;
  result.iBlockSize := FiBlockSize;
  result.bStrictRefInt := FbStrictRefInt;
  result.iFilters := FiFilters;
  result.bTempTable := FbTempTable;
end;

constructor RECPropsWrapper.Create(ARecord: RECProps);
begin
  inherited Create;
  FiSeqNum := ARecord.iSeqNum;
  FiPhyRecNum := ARecord.iPhyRecNum;
  FiRecStatus := ARecord.iRecStatus;
  FbSeqNumChanged := ARecord.bSeqNumChanged;
  FbDeleteFlag := ARecord.bDeleteFlag;
end;

function RECPropsWrapper.ObjToRec: RECProps;
begin
  result.iSeqNum := FiSeqNum;
  result.iPhyRecNum := FiPhyRecNum;
  result.iRecStatus := FiRecStatus;
  result.bSeqNumChanged := FbSeqNumChanged;
  result.bDeleteFlag := FbDeleteFlag;
end;

constructor XInfoWrapper.Create(ARecord: XInfo);
begin
  inherited Create;
  FexState := ARecord.exState;
  FeXIL := ARecord.eXIL;
  FuNests := ARecord.uNests;
end;

function XInfoWrapper.ObjToRec: XInfo;
begin
  result.exState := FexState;
  result.eXIL := FeXIL;
  result.uNests := FuNests;
end;

constructor CRTblDescWrapper.Create(ARecord: CRTblDesc);
begin
  inherited Create;
  FbProtected := ARecord.bProtected;
  FbPack := ARecord.bPack;
  FiFldCount := ARecord.iFldCount;
  FiIdxCount := ARecord.iIdxCount;
  FiSecRecCount := ARecord.iSecRecCount;
  FiValChkCount := ARecord.iValChkCount;
  FiRintCount := ARecord.iRintCount;
  FiOptParams := ARecord.iOptParams;
end;

function CRTblDescWrapper.ObjToRec: CRTblDesc;
begin
  result.bProtected := FbProtected;
  result.bPack := FbPack;
  result.iFldCount := FiFldCount;
  result.iIdxCount := FiIdxCount;
  result.iSecRecCount := FiSecRecCount;
  result.iValChkCount := FiValChkCount;
  result.iRintCount := FiRintCount;
  result.iOptParams := FiOptParams;
end;

constructor BATTblDescWrapper.Create(ARecord: BATTblDesc);
begin
  inherited Create;
end;

function BATTblDescWrapper.ObjToRec: BATTblDesc;
begin
end;

constructor DRVTypeWrapper.Create(ARecord: DRVType);
begin
  inherited Create;
  FedrvCat := ARecord.edrvCat;
  FbTrueDb := ARecord.bTrueDb;
  FbMultiUser := ARecord.bMultiUser;
  FbReadWrite := ARecord.bReadWrite;
  FbTrans := ARecord.bTrans;
  FbPassThruSQL := ARecord.bPassThruSQL;
  FbLogIn := ARecord.bLogIn;
  FbCreateDb := ARecord.bCreateDb;
  FbDeleteDb := ARecord.bDeleteDb;
  FbCreateTable := ARecord.bCreateTable;
  FbDeleteTable := ARecord.bDeleteTable;
  FbMultiplePWs := ARecord.bMultiplePWs;
  FiDriverVersion := ARecord.iDriverVersion;
  FbSQLRowid := ARecord.bSQLRowid;
end;

function DRVTypeWrapper.ObjToRec: DRVType;
begin
  result.edrvCat := FedrvCat;
  result.bTrueDb := FbTrueDb;
  result.bMultiUser := FbMultiUser;
  result.bReadWrite := FbReadWrite;
  result.bTrans := FbTrans;
  result.bPassThruSQL := FbPassThruSQL;
  result.bLogIn := FbLogIn;
  result.bCreateDb := FbCreateDb;
  result.bDeleteDb := FbDeleteDb;
  result.bCreateTable := FbCreateTable;
  result.bDeleteTable := FbDeleteTable;
  result.bMultiplePWs := FbMultiplePWs;
  result.iDriverVersion := FiDriverVersion;
  result.bSQLRowid := FbSQLRowid;
end;

constructor TBLTypeWrapper.Create(ARecord: TBLType);
begin
  inherited Create;
  FiId := ARecord.iId;
  FbReadWrite := ARecord.bReadWrite;
  FbCreate := ARecord.bCreate;
  FbRestructure := ARecord.bRestructure;
  FbValChecks := ARecord.bValChecks;
  FbSecurity := ARecord.bSecurity;
  FbRefIntegrity := ARecord.bRefIntegrity;
  FbPrimaryKey := ARecord.bPrimaryKey;
  FbIndexing := ARecord.bIndexing;
  FiFldTypes := ARecord.iFldTypes;
  FiMaxRecSize := ARecord.iMaxRecSize;
  FiMaxFldsInTable := ARecord.iMaxFldsInTable;
  FiMaxFldNameLen := ARecord.iMaxFldNameLen;
  FiTblLevel := ARecord.iTblLevel;
end;

function TBLTypeWrapper.ObjToRec: TBLType;
begin
  result.iId := FiId;
  result.bReadWrite := FbReadWrite;
  result.bCreate := FbCreate;
  result.bRestructure := FbRestructure;
  result.bValChecks := FbValChecks;
  result.bSecurity := FbSecurity;
  result.bRefIntegrity := FbRefIntegrity;
  result.bPrimaryKey := FbPrimaryKey;
  result.bIndexing := FbIndexing;
  result.iFldTypes := FiFldTypes;
  result.iMaxRecSize := FiMaxRecSize;
  result.iMaxFldsInTable := FiMaxFldsInTable;
  result.iMaxFldNameLen := FiMaxFldNameLen;
  result.iTblLevel := FiTblLevel;
end;

constructor IDXTypeWrapper.Create(ARecord: IDXType);
begin
  inherited Create;
  FiId := ARecord.iId;
  FbComposite := ARecord.bComposite;
  FbPrimary := ARecord.bPrimary;
  FbUnique := ARecord.bUnique;
  FbKeyDescending := ARecord.bKeyDescending;
  FbFldDescending := ARecord.bFldDescending;
  FbMaintained := ARecord.bMaintained;
  FbSubset := ARecord.bSubset;
  FbKeyExpr := ARecord.bKeyExpr;
  FbCaseInsensitive := ARecord.bCaseInsensitive;
end;

function IDXTypeWrapper.ObjToRec: IDXType;
begin
  result.iId := FiId;
  result.bComposite := FbComposite;
  result.bPrimary := FbPrimary;
  result.bUnique := FbUnique;
  result.bKeyDescending := FbKeyDescending;
  result.bFldDescending := FbFldDescending;
  result.bMaintained := FbMaintained;
  result.bSubset := FbSubset;
  result.bKeyExpr := FbKeyExpr;
  result.bCaseInsensitive := FbCaseInsensitive;
end;

constructor FLDTypeWrapper.Create(ARecord: FLDType);
begin
  inherited Create;
  FiId := ARecord.iId;
  FiPhyType := ARecord.iPhyType;
  FiXltType := ARecord.iXltType;
  FiXltSubType := ARecord.iXltSubType;
  FiMaxUnits1 := ARecord.iMaxUnits1;
  FiMaxUnits2 := ARecord.iMaxUnits2;
  FiPhySize := ARecord.iPhySize;
  FbRequired := ARecord.bRequired;
  FbDefaultVal := ARecord.bDefaultVal;
  FbMinVal := ARecord.bMinVal;
  FbMaxVal := ARecord.bMaxVal;
  FbRefIntegrity := ARecord.bRefIntegrity;
  FbOtherChecks := ARecord.bOtherChecks;
  FbKeyed := ARecord.bKeyed;
  FbMultiplePerTable := ARecord.bMultiplePerTable;
  FiMinUnits1 := ARecord.iMinUnits1;
  FiMinUnits2 := ARecord.iMinUnits2;
  FbCreateable := ARecord.bCreateable;
end;

function FLDTypeWrapper.ObjToRec: FLDType;
begin
  result.iId := FiId;
  result.iPhyType := FiPhyType;
  result.iXltType := FiXltType;
  result.iXltSubType := FiXltSubType;
  result.iMaxUnits1 := FiMaxUnits1;
  result.iMaxUnits2 := FiMaxUnits2;
  result.iPhySize := FiPhySize;
  result.bRequired := FbRequired;
  result.bDefaultVal := FbDefaultVal;
  result.bMinVal := FbMinVal;
  result.bMaxVal := FbMaxVal;
  result.bRefIntegrity := FbRefIntegrity;
  result.bOtherChecks := FbOtherChecks;
  result.bKeyed := FbKeyed;
  result.bMultiplePerTable := FbMultiplePerTable;
  result.iMinUnits1 := FiMinUnits1;
  result.iMinUnits2 := FiMinUnits2;
  result.bCreateable := FbCreateable;
end;

constructor CBPROGRESSDescWrapper.Create(ARecord: CBPROGRESSDesc);
begin
  inherited Create;
  FiPercentDone := ARecord.iPercentDone;
end;

function CBPROGRESSDescWrapper.ObjToRec: CBPROGRESSDesc;
begin
  result.iPercentDone := FiPercentDone;
end;

constructor DELAYUPDCbDescWrapper.Create(ARecord: DELAYUPDCbDesc);
begin
  inherited Create;
  FiErrCode := ARecord.iErrCode;
  FeDelayUpdOpType := ARecord.eDelayUpdOpType;
  FiRecBufSize := ARecord.iRecBufSize;
end;

function DELAYUPDCbDescWrapper.ObjToRec: DELAYUPDCbDesc;
begin
  result.iErrCode := FiErrCode;
  result.eDelayUpdOpType := FeDelayUpdOpType;
  result.iRecBufSize := FiRecBufSize;
end;

constructor TCBDBLoginWrapper.Create(ARecord: TCBDBLogin);
begin
  inherited Create;
  FeOpenMode := ARecord.eOpenMode;
  FeShareMode := ARecord.eShareMode;
  FbCallbackToClose := ARecord.bCallbackToClose;
end;

function TCBDBLoginWrapper.ObjToRec: TCBDBLogin;
begin
  result.eOpenMode := FeOpenMode;
  result.eShareMode := FeShareMode;
  result.bCallbackToClose := FbCallbackToClose;
end;

constructor TRACEDescWrapper.Create(ARecord: TRACEDesc);
begin
  inherited Create;
  FeTraceCat := ARecord.eTraceCat;
  FuTotalMsgLen := ARecord.uTotalMsgLen;
end;

function TRACEDescWrapper.ObjToRec: TRACEDesc;
begin
  result.eTraceCat := FeTraceCat;
  result.uTotalMsgLen := FuTotalMsgLen;
end;

constructor TuObjDescWrapper.Create(ARecord: TuObjDesc);
begin
  inherited Create;
end;

function TuObjDescWrapper.ObjToRec: TuObjDesc;
begin
end;

constructor RESTCbDescWrapper.Create(ARecord: RESTCbDesc);
begin
  inherited Create;
  FiErrCode := ARecord.iErrCode;
  FiTblNum := ARecord.iTblNum;
  FiObjNum := ARecord.iObjNum;
  FeRestrObjType := ARecord.eRestrObjType;
end;

function RESTCbDescWrapper.ObjToRec: RESTCbDesc;
begin
  result.iErrCode := FiErrCode;
  result.iTblNum := FiTblNum;
  result.iObjNum := FiObjNum;
  result.eRestrObjType := FeRestrObjType;
end;

constructor CBEntryWrapper.Create(ARecord: CBEntry);
begin
  inherited Create;
end;

function CBEntryWrapper.ObjToRec: CBEntry;
begin
end;

constructor CBInputDescWrapper.Create(ARecord: CBInputDesc);
begin
  inherited Create;
  FeCbInputId := ARecord.eCbInputId;
  FiCount := ARecord.iCount;
  FiSelection := ARecord.iSelection;
  FbSave := ARecord.bSave;
end;

function CBInputDescWrapper.ObjToRec: CBInputDesc;
begin
  result.eCbInputId := FeCbInputId;
  result.iCount := FiCount;
  result.iSelection := FiSelection;
  result.bSave := FbSave;
end;

constructor CBLoginDescWrapper.Create(ARecord: CBLoginDesc);
begin
  inherited Create;
end;

function CBLoginDescWrapper.ObjToRec: CBLoginDesc;
begin
end;

constructor FMTNumberWrapper.Create(ARecord: FMTNumber);
begin
  inherited Create;
  FcDecimalSeparator := ARecord.cDecimalSeparator;
  FcThousandSeparator := ARecord.cThousandSeparator;
  FiDecimalDigits := ARecord.iDecimalDigits;
  FbLeadingZero := ARecord.bLeadingZero;
end;

function FMTNumberWrapper.ObjToRec: FMTNumber;
begin
  result.cDecimalSeparator := FcDecimalSeparator;
  result.cThousandSeparator := FcThousandSeparator;
  result.iDecimalDigits := FiDecimalDigits;
  result.bLeadingZero := FbLeadingZero;
end;

constructor FMTDateWrapper.Create(ARecord: FMTDate);
begin
  inherited Create;
  FiDateMode := ARecord.iDateMode;
  FbFourDigitYear := ARecord.bFourDigitYear;
  FbYearBiased := ARecord.bYearBiased;
  FbMonthLeadingZero := ARecord.bMonthLeadingZero;
  FbDayLeadingZero := ARecord.bDayLeadingZero;
end;

function FMTDateWrapper.ObjToRec: FMTDate;
begin
  result.iDateMode := FiDateMode;
  result.bFourDigitYear := FbFourDigitYear;
  result.bYearBiased := FbYearBiased;
  result.bMonthLeadingZero := FbMonthLeadingZero;
  result.bDayLeadingZero := FbDayLeadingZero;
end;

constructor FMTTimeWrapper.Create(ARecord: FMTTime);
begin
  inherited Create;
  FcTimeSeparator := ARecord.cTimeSeparator;
  FbTwelveHour := ARecord.bTwelveHour;
  FbSeconds := ARecord.bSeconds;
  FbMilSeconds := ARecord.bMilSeconds;
end;

function FMTTimeWrapper.ObjToRec: FMTTime;
begin
  result.cTimeSeparator := FcTimeSeparator;
  result.bTwelveHour := FbTwelveHour;
  result.bSeconds := FbSeconds;
  result.bMilSeconds := FbMilSeconds;
end;

constructor FMTBcdWrapper.Create(ARecord: FMTBcd);
begin
  inherited Create;
  FiPrecision := ARecord.iPrecision;
  FiSignSpecialPlaces := ARecord.iSignSpecialPlaces;
end;

function FMTBcdWrapper.ObjToRec: FMTBcd;
begin
  result.iPrecision := FiPrecision;
  result.iSignSpecialPlaces := FiSignSpecialPlaces;
end;

constructor DBIErrInfoWrapper.Create(ARecord: DBIErrInfo);
begin
  inherited Create;
  FiError := ARecord.iError;
end;

function DBIErrInfoWrapper.ObjToRec: DBIErrInfo;
begin
  result.iError := FiError;
end;

constructor DBDescWrapper.Create(ARecord: DBDesc);
begin
  inherited Create;
end;

function DBDescWrapper.ObjToRec: DBDesc;
begin
end;

constructor USERDescWrapper.Create(ARecord: USERDesc);
begin
  inherited Create;
  FiNetSession := ARecord.iNetSession;
  FiProductClass := ARecord.iProductClass;
end;

function USERDescWrapper.ObjToRec: USERDesc;
begin
  result.iNetSession := FiNetSession;
  result.iProductClass := FiProductClass;
end;

constructor TBLBaseDescWrapper.Create(ARecord: TBLBaseDesc);
begin
  inherited Create;
  FdtDate := ARecord.dtDate;
  FtmTime := ARecord.tmTime;
  FiSize := ARecord.iSize;
  FbView := ARecord.bView;
  FbSynonym := ARecord.bSynonym;
end;

function TBLBaseDescWrapper.ObjToRec: TBLBaseDesc;
begin
  result.dtDate := FdtDate;
  result.tmTime := FtmTime;
  result.iSize := FiSize;
  result.bView := FbView;
  result.bSynonym := FbSynonym;
end;

constructor TBLExtDescWrapper.Create(ARecord: TBLExtDesc);
begin
  inherited Create;
  FiRestrVersion := ARecord.iRestrVersion;
  FiRecSize := ARecord.iRecSize;
  FiFields := ARecord.iFields;
  FiIndexes := ARecord.iIndexes;
  FiValChecks := ARecord.iValChecks;
  FiRintChecks := ARecord.iRintChecks;
  FiRecords := ARecord.iRecords;
  FbProtected := ARecord.bProtected;
  FbValidInfo := ARecord.bValidInfo;
end;

function TBLExtDescWrapper.ObjToRec: TBLExtDesc;
begin
  result.iRestrVersion := FiRestrVersion;
  result.iRecSize := FiRecSize;
  result.iFields := FiFields;
  result.iIndexes := FiIndexes;
  result.iValChecks := FiValChecks;
  result.iRintChecks := FiRintChecks;
  result.iRecords := FiRecords;
  result.bProtected := FbProtected;
  result.bValidInfo := FbValidInfo;
end;

constructor TBLFullDescWrapper.Create(ARecord: TBLFullDesc);
begin
  inherited Create;
end;

function TBLFullDescWrapper.ObjToRec: TBLFullDesc;
begin
end;

constructor FILEDescWrapper.Create(ARecord: FILEDesc);
begin
  inherited Create;
  FbDir := ARecord.bDir;
  FiSize := ARecord.iSize;
  FdtDate := ARecord.dtDate;
  FtmTime := ARecord.tmTime;
end;

function FILEDescWrapper.ObjToRec: FILEDesc;
begin
  result.bDir := FbDir;
  result.iSize := FiSize;
  result.dtDate := FdtDate;
  result.tmTime := FtmTime;
end;

constructor SPDescWrapper.Create(ARecord: SPDesc);
begin
  inherited Create;
  FdtDate := ARecord.dtDate;
  FtmTime := ARecord.tmTime;
end;

function SPDescWrapper.ObjToRec: SPDesc;
begin
  result.dtDate := FdtDate;
  result.tmTime := FtmTime;
end;

constructor SPParamDescWrapper.Create(ARecord: SPParamDesc);
begin
  inherited Create;
  FuParamNum := ARecord.uParamNum;
  FeParamType := ARecord.eParamType;
  FuFldType := ARecord.uFldType;
  FuSubType := ARecord.uSubType;
  FiUnits1 := ARecord.iUnits1;
  FiUnits2 := ARecord.iUnits2;
  FuOffset := ARecord.uOffset;
  FuLen := ARecord.uLen;
  FuNullOffset := ARecord.uNullOffset;
end;

function SPParamDescWrapper.ObjToRec: SPParamDesc;
begin
  result.uParamNum := FuParamNum;
  result.eParamType := FeParamType;
  result.uFldType := FuFldType;
  result.uSubType := FuSubType;
  result.iUnits1 := FiUnits1;
  result.iUnits2 := FiUnits2;
  result.uOffset := FuOffset;
  result.uLen := FuLen;
  result.uNullOffset := FuNullOffset;
end;

constructor DBIFUNCDescWrapper.Create(ARecord: DBIFUNCDesc);
begin
  inherited Create;
  FuOverload := ARecord.uOverload;
  FeStdFn := ARecord.eStdFn;
end;

function DBIFUNCDescWrapper.ObjToRec: DBIFUNCDesc;
begin
  result.uOverload := FuOverload;
  result.eStdFn := FeStdFn;
end;

constructor DBIFUNCArgDescWrapper.Create(ARecord: DBIFUNCArgDesc);
begin
  inherited Create;
  FuArgNum := ARecord.uArgNum;
  FuFldType := ARecord.uFldType;
  FuSubType := ARecord.uSubType;
  FufuncFlags := ARecord.ufuncFlags;
end;

function DBIFUNCArgDescWrapper.ObjToRec: DBIFUNCArgDesc;
begin
  result.uArgNum := FuArgNum;
  result.uFldType := FuFldType;
  result.uSubType := FuSubType;
  result.ufuncFlags := FufuncFlags;
end;

constructor CFGDescWrapper.Create(ARecord: CFGDesc);
begin
  inherited Create;
  FiDataType := ARecord.iDataType;
  FbHasSubnodes := ARecord.bHasSubnodes;
end;

function CFGDescWrapper.ObjToRec: CFGDesc;
begin
  result.iDataType := FiDataType;
  result.bHasSubnodes := FbHasSubnodes;
end;

constructor FMLDescWrapper.Create(ARecord: FMLDesc);
begin
  inherited Create;
  FiId := ARecord.iId;
  FeType := ARecord.eType;
end;

function FMLDescWrapper.ObjToRec: FMLDesc;
begin
  result.iId := FiId;
  result.eType := FeType;
end;

constructor LDDescWrapper.Create(ARecord: LDDesc);
begin
  inherited Create;
  FiCodePage := ARecord.iCodePage;
  FPrimaryCpPlatform := ARecord.PrimaryCpPlatform;
  FAlternateCpPlatform := ARecord.AlternateCpPlatform;
end;

function LDDescWrapper.ObjToRec: LDDesc;
begin
  result.iCodePage := FiCodePage;
  result.PrimaryCpPlatform := FPrimaryCpPlatform;
  result.AlternateCpPlatform := FAlternateCpPlatform;
end;

constructor LOCKDescWrapper.Create(ARecord: LOCKDesc);
begin
  inherited Create;
  FiType := ARecord.iType;
  FiNetSession := ARecord.iNetSession;
  FiSession := ARecord.iSession;
  FiRecNum := ARecord.iRecNum;
  FiInfo := ARecord.iInfo;
end;

function LOCKDescWrapper.ObjToRec: LOCKDesc;
begin
  result.iType := FiType;
  result.iNetSession := FiNetSession;
  result.iSession := FiSession;
  result.iRecNum := FiRecNum;
  result.iInfo := FiInfo;
end;

constructor CANHdrWrapper.Create(ARecord: CANHdr);
begin
  inherited Create;
  FnodeClass := ARecord.nodeClass;
  FcanOp := ARecord.canOp;
end;

function CANHdrWrapper.ObjToRec: CANHdr;
begin
  result.nodeClass := FnodeClass;
  result.canOp := FcanOp;
end;

constructor CANUnaryWrapper.Create(ARecord: CANUnary);
begin
  inherited Create;
  FnodeClass := ARecord.nodeClass;
  FcanOp := ARecord.canOp;
  FiOperand1 := ARecord.iOperand1;
end;

function CANUnaryWrapper.ObjToRec: CANUnary;
begin
  result.nodeClass := FnodeClass;
  result.canOp := FcanOp;
  result.iOperand1 := FiOperand1;
end;

constructor CANBinaryWrapper.Create(ARecord: CANBinary);
begin
  inherited Create;
  FnodeClass := ARecord.nodeClass;
  FcanOp := ARecord.canOp;
  FiOperand1 := ARecord.iOperand1;
  FiOperand2 := ARecord.iOperand2;
end;

function CANBinaryWrapper.ObjToRec: CANBinary;
begin
  result.nodeClass := FnodeClass;
  result.canOp := FcanOp;
  result.iOperand1 := FiOperand1;
  result.iOperand2 := FiOperand2;
end;

constructor CANFieldWrapper.Create(ARecord: CANField);
begin
  inherited Create;
  FnodeClass := ARecord.nodeClass;
  FcanOp := ARecord.canOp;
  FiFieldNum := ARecord.iFieldNum;
  FiNameOffset := ARecord.iNameOffset;
end;

function CANFieldWrapper.ObjToRec: CANField;
begin
  result.nodeClass := FnodeClass;
  result.canOp := FcanOp;
  result.iFieldNum := FiFieldNum;
  result.iNameOffset := FiNameOffset;
end;

constructor CANConstWrapper.Create(ARecord: CANConst);
begin
  inherited Create;
  FnodeClass := ARecord.nodeClass;
  FcanOp := ARecord.canOp;
  FiType := ARecord.iType;
  FiSize := ARecord.iSize;
  FiOffset := ARecord.iOffset;
end;

function CANConstWrapper.ObjToRec: CANConst;
begin
  result.nodeClass := FnodeClass;
  result.canOp := FcanOp;
  result.iType := FiType;
  result.iSize := FiSize;
  result.iOffset := FiOffset;
end;

constructor CANTupleWrapper.Create(ARecord: CANTuple);
begin
  inherited Create;
  FnodeClass := ARecord.nodeClass;
  FcanOp := ARecord.canOp;
  FiSize := ARecord.iSize;
end;

function CANTupleWrapper.ObjToRec: CANTuple;
begin
  result.nodeClass := FnodeClass;
  result.canOp := FcanOp;
  result.iSize := FiSize;
end;

constructor CANContinueWrapper.Create(ARecord: CANContinue);
begin
  inherited Create;
  FnodeClass := ARecord.nodeClass;
  FcanOp := ARecord.canOp;
  FiContOperand := ARecord.iContOperand;
end;

function CANContinueWrapper.ObjToRec: CANContinue;
begin
  result.nodeClass := FnodeClass;
  result.canOp := FcanOp;
  result.iContOperand := FiContOperand;
end;

constructor CANCompareWrapper.Create(ARecord: CANCompare);
begin
  inherited Create;
  FnodeClass := ARecord.nodeClass;
  FcanOp := ARecord.canOp;
  FbCaseInsensitive := ARecord.bCaseInsensitive;
  FiPartialLen := ARecord.iPartialLen;
  FiOperand1 := ARecord.iOperand1;
  FiOperand2 := ARecord.iOperand2;
end;

function CANCompareWrapper.ObjToRec: CANCompare;
begin
  result.nodeClass := FnodeClass;
  result.canOp := FcanOp;
  result.bCaseInsensitive := FbCaseInsensitive;
  result.iPartialLen := FiPartialLen;
  result.iOperand1 := FiOperand1;
  result.iOperand2 := FiOperand2;
end;

constructor CANFuncWrapper.Create(ARecord: CANFunc);
begin
  inherited Create;
  FnodeClass := ARecord.nodeClass;
  FcanOp := ARecord.canOp;
  FiNameOffset := ARecord.iNameOffset;
  FiElemOffset := ARecord.iElemOffset;
end;

function CANFuncWrapper.ObjToRec: CANFunc;
begin
  result.nodeClass := FnodeClass;
  result.canOp := FcanOp;
  result.iNameOffset := FiNameOffset;
  result.iElemOffset := FiElemOffset;
end;

constructor CANListElemWrapper.Create(ARecord: CANListElem);
begin
  inherited Create;
  FnodeClass := ARecord.nodeClass;
  FcanOp := ARecord.canOp;
  FiOffset := ARecord.iOffset;
  FiNextOffset := ARecord.iNextOffset;
end;

function CANListElemWrapper.ObjToRec: CANListElem;
begin
  result.nodeClass := FnodeClass;
  result.canOp := FcanOp;
  result.iOffset := FiOffset;
  result.iNextOffset := FiNextOffset;
end;

constructor CANUdfWrapper.Create(ARecord: CANUdf);
begin
  inherited Create;
  FnodeClass := ARecord.nodeClass;
  FcanOp := ARecord.canOp;
  FiOffSzFuncName := ARecord.iOffSzFuncName;
  FiOperands := ARecord.iOperands;
  FiDrvDialect := ARecord.iDrvDialect;
  FiOffSzUDF := ARecord.iOffSzUDF;
end;

function CANUdfWrapper.ObjToRec: CANUdf;
begin
  result.nodeClass := FnodeClass;
  result.canOp := FcanOp;
  result.iOffSzFuncName := FiOffSzFuncName;
  result.iOperands := FiOperands;
  result.iDrvDialect := FiDrvDialect;
  result.iOffSzUDF := FiOffSzUDF;
end;

constructor CANListWrapper.Create(ARecord: CANList);
begin
  inherited Create;
  FnodeClass := ARecord.nodeClass;
  FcanOp := ARecord.canOp;
  FiType := ARecord.iType;
  FiTotalSize := ARecord.iTotalSize;
  FiElemSize := ARecord.iElemSize;
  FiElems := ARecord.iElems;
  FiOffset := ARecord.iOffset;
end;

function CANListWrapper.ObjToRec: CANList;
begin
  result.nodeClass := FnodeClass;
  result.canOp := FcanOp;
  result.iType := FiType;
  result.iTotalSize := FiTotalSize;
  result.iElemSize := FiElemSize;
  result.iElems := FiElems;
  result.iOffset := FiOffset;
end;

constructor CANNodeWrapper.Create(ARecord: CANNode);
begin
  inherited Create;
end;

function CANNodeWrapper.ObjToRec: CANNode;
begin
end;

constructor CANExprWrapper.Create(ARecord: CANExpr);
begin
  inherited Create;
  FiVer := ARecord.iVer;
  FiTotalSize := ARecord.iTotalSize;
  FiNodes := ARecord.iNodes;
  FiNodeStart := ARecord.iNodeStart;
  FiLiteralStart := ARecord.iLiteralStart;
end;

function CANExprWrapper.ObjToRec: CANExpr;
begin
  result.iVer := FiVer;
  result.iTotalSize := FiTotalSize;
  result.iNodes := FiNodes;
  result.iNodeStart := FiNodeStart;
  result.iLiteralStart := FiLiteralStart;
end;

constructor FILTERInfoWrapper.Create(ARecord: FILTERInfo);
begin
  inherited Create;
  FiFilterId := ARecord.iFilterId;
  FiClientData := ARecord.iClientData;
  FiPriority := ARecord.iPriority;
  FbCanAbort := ARecord.bCanAbort;
  FbActive := ARecord.bActive;
end;

function FILTERInfoWrapper.ObjToRec: FILTERInfo;
begin
  result.iFilterId := FiFilterId;
  result.iClientData := FiClientData;
  result.iPriority := FiPriority;
  result.bCanAbort := FbCanAbort;
  result.bActive := FbActive;
end;

constructor DBIQryPropWrapper.Create(ARecord: DBIQryProp);
begin
  inherited Create;
  FeLang := ARecord.eLang;
  FiQryPrice := ARecord.iQryPrice;
  FiNumTables := ARecord.iNumTables;
  FbHasAnswer := ARecord.bHasAnswer;
  FbInsert := ARecord.bInsert;
  FbDelete := ARecord.bDelete;
  FbChange := ARecord.bChange;
end;

function DBIQryPropWrapper.ObjToRec: DBIQryProp;
begin
  result.eLang := FeLang;
  result.iQryPrice := FiQryPrice;
  result.iNumTables := FiNumTables;
  result.bHasAnswer := FbHasAnswer;
  result.bInsert := FbInsert;
  result.bDelete := FbDelete;
  result.bChange := FbChange;
end;

constructor DBIQryProgressWrapper.Create(ARecord: DBIQryProgress);
begin
  inherited Create;
  FstepsInQry := ARecord.stepsInQry;
  FstepsCompleted := ARecord.stepsCompleted;
  FtotElemInStep := ARecord.totElemInStep;
  FelemCompleted := ARecord.elemCompleted;
end;

function DBIQryProgressWrapper.ObjToRec: DBIQryProgress;
begin
  result.stepsInQry := FstepsInQry;
  result.stepsCompleted := FstepsCompleted;
  result.totElemInStep := FtotElemInStep;
  result.elemCompleted := FelemCompleted;
end;

constructor QueryLowPropsWrapper.Create(ARecord: QueryLowProps);
begin
  inherited Create;
  Flength := ARecord.length;
  Fblankzeroes := ARecord.blankzeroes;
  FbNeedAuxTbls := ARecord.bNeedAuxTbls;
  FqryMode := ARecord.qryMode;
  FperQrySqlMode := ARecord.perQrySqlMode;
  FlivenessDesired := ARecord.livenessDesired;
end;

function QueryLowPropsWrapper.ObjToRec: QueryLowProps;
begin
  result.length := Flength;
  result.blankzeroes := Fblankzeroes;
  result.bNeedAuxTbls := FbNeedAuxTbls;
  result.qryMode := FqryMode;
  result.perQrySqlMode := FperQrySqlMode;
  result.livenessDesired := FlivenessDesired;
end;

constructor LISTWrapper.Create(ARecord: LIST);
begin
  inherited Create;
end;

function LISTWrapper.ObjToRec: LIST;
begin
end;

constructor SQLRelationWrapper.Create(ARecord: SQLRelation);
begin
  inherited Create;
  FesType := ARecord.esType;
  FerType := ARecord.erType;
  FbRelQuote := ARecord.bRelQuote;
  FiRowId := ARecord.iRowId;
  FiRowNo := ARecord.iRowNo;
end;

function SQLRelationWrapper.ObjToRec: SQLRelation;
begin
  result.esType := FesType;
  result.erType := FerType;
  result.bRelQuote := FbRelQuote;
  result.iRowId := FiRowId;
  result.iRowNo := FiRowNo;
end;

constructor SQLColumnWrapper.Create(ARecord: SQLColumn);
begin
  inherited Create;
  FesType := ARecord.esType;
  FbColQuote := ARecord.bColQuote;
  FbColAlQuote := ARecord.bColAlQuote;
  FeCheck := ARecord.eCheck;
  FiColAggr := ARecord.iColAggr;
  FiColExmpl := ARecord.iColExmpl;
end;

function SQLColumnWrapper.ObjToRec: SQLColumn;
begin
  result.esType := FesType;
  result.bColQuote := FbColQuote;
  result.bColAlQuote := FbColAlQuote;
  result.eCheck := FeCheck;
  result.iColAggr := FiColAggr;
  result.iColExmpl := FiColExmpl;
end;

constructor SQLConstantWrapper.Create(ARecord: SQLConstant);
begin
  inherited Create;
  FesType := ARecord.esType;
end;

function SQLConstantWrapper.ObjToRec: SQLConstant;
begin
  result.esType := FesType;
end;

constructor SQLExprWrapper.Create(ARecord: SQLExpr);
begin
  inherited Create;
  FesType := ARecord.esType;
  FeOp := ARecord.eOp;
end;

function SQLExprWrapper.ObjToRec: SQLExpr;
begin
  result.esType := FesType;
  result.eOp := FeOp;
end;

constructor SQLAggrWrapper.Create(ARecord: SQLAggr);
begin
  inherited Create;
  FesType := ARecord.esType;
  FiAggr := ARecord.iAggr;
  FbProjAggr := ARecord.bProjAggr;
end;

function SQLAggrWrapper.ObjToRec: SQLAggr;
begin
  result.esType := FesType;
  result.iAggr := FiAggr;
  result.bProjAggr := FbProjAggr;
end;

constructor SQLCellWrapper.Create(ARecord: SQLCell);
begin
  inherited Create;
  FesType := ARecord.esType;
  FiRow := ARecord.iRow;
end;

function SQLCellWrapper.ObjToRec: SQLCell;
begin
  result.esType := FesType;
  result.iRow := FiRow;
end;

constructor SQLObjectWrapper.Create(ARecord: SQLObject);
begin
  inherited Create;
  FesType := ARecord.esType;
end;

function SQLObjectWrapper.ObjToRec: SQLObject;
begin
  result.esType := FesType;
end;

constructor TSQLRequestWrapper.Create(ARecord: TSQLRequest);
begin
  inherited Create;
  FiVersion := ARecord.iVersion;
  FiMemMark := ARecord.iMemMark;
  FerType := ARecord.erType;
  FiParams := ARecord.iParams;
  FiOptions := ARecord.iOptions;
  FiDistinct := ARecord.iDistinct;
end;

function TSQLRequestWrapper.ObjToRec: TSQLRequest;
begin
  result.iVersion := FiVersion;
  result.iMemMark := FiMemMark;
  result.erType := FerType;
  result.iParams := FiParams;
  result.iOptions := FiOptions;
  result.iDistinct := FiDistinct;
end;

constructor STMTBaseDescWrapper.Create(ARecord: STMTBaseDesc);
begin
  inherited Create;
  FbExpression := ARecord.bExpression;
  FbAggregate := ARecord.bAggregate;
  FbConstant := ARecord.bConstant;
end;

function STMTBaseDescWrapper.ObjToRec: STMTBaseDesc;
begin
  result.bExpression := FbExpression;
  result.bAggregate := FbAggregate;
  result.bConstant := FbConstant;
end;

constructor TOSBLObjWrapper.Create(ARecord: TOSBLObj);
begin
  inherited Create;
  FLangId := ARecord.LangId;
  FCodeSet := ARecord.CodeSet;
  FLocaleType := ARecord.LocaleType;
  FLanguageSortType := ARecord.LanguageSortType;
  FLocaleCount := ARecord.LocaleCount;
  FPrimaryCpPlatform := ARecord.PrimaryCpPlatform;
  FPrimaryCodePageID := ARecord.PrimaryCodePageID;
  FAlternateCodePageID := ARecord.AlternateCodePageID;
  FProductID := ARecord.ProductID;
  FNoConversions := ARecord.NoConversions;
  FLdLCID := ARecord.LdLCID;
end;

function TOSBLObjWrapper.ObjToRec: TOSBLObj;
begin
  result.LangId := FLangId;
  result.CodeSet := FCodeSet;
  result.LocaleType := FLocaleType;
  result.LanguageSortType := FLanguageSortType;
  result.LocaleCount := FLocaleCount;
  result.PrimaryCpPlatform := FPrimaryCpPlatform;
  result.PrimaryCodePageID := FPrimaryCodePageID;
  result.AlternateCodePageID := FAlternateCodePageID;
  result.ProductID := FProductID;
  result.NoConversions := FNoConversions;
  result.LdLCID := FLdLCID;
end;

constructor DRDescWrapper.Create(ARecord: DRDesc);
begin
  inherited Create;
end;

function DRDescWrapper.ObjToRec: DRDesc;
begin
end;

constructor DROBJDescWrapper.Create(ARecord: DROBJDesc);
begin
  inherited Create;
  FulObjId := ARecord.ulObjId;
  FiVersion := ARecord.iVersion;
end;

function DROBJDescWrapper.ObjToRec: DROBJDesc;
begin
  result.ulObjId := FulObjId;
  result.iVersion := FiVersion;
end;

constructor DRExportDescWrapper.Create(ARecord: DRExportDesc);
begin
  inherited Create;
  FbInclRelated := ARecord.bInclRelated;
end;

function DRExportDescWrapper.ObjToRec: DRExportDesc;
begin
  result.bInclRelated := FbInclRelated;
end;

constructor DROBJTypeWrapper.Create(ARecord: DROBJType);
begin
  inherited Create;
  FiNumAttr := ARecord.iNumAttr;
  FiNumRel := ARecord.iNumRel;
  FulObjFlag := ARecord.ulObjFlag;
end;

function DROBJTypeWrapper.ObjToRec: DROBJType;
begin
  result.iNumAttr := FiNumAttr;
  result.iNumRel := FiNumRel;
  result.ulObjFlag := FulObjFlag;
end;

constructor DBIEnumFldWrapper.Create(ARecord: DBIEnumFld);
begin
  inherited Create;
end;

function DBIEnumFldWrapper.ObjToRec: DBIEnumFld;
begin
end;

constructor DREnumAttrDomainWrapper.Create(ARecord: DREnumAttrDomain);
begin
  inherited Create;
  FulEDProp := ARecord.ulEDProp;
  FiNumVals := ARecord.iNumVals;
end;

function DREnumAttrDomainWrapper.ObjToRec: DREnumAttrDomain;
begin
  result.ulEDProp := FulEDProp;
  result.iNumVals := FiNumVals;
end;

constructor DRATTRDescWrapper.Create(ARecord: DRATTRDesc);
begin
  inherited Create;
  FiAttrType := ARecord.iAttrType;
  FiUnits1 := ARecord.iUnits1;
  FiUnits2 := ARecord.iUnits2;
  FbReqd := ARecord.bReqd;
  FulAttrFlag := ARecord.ulAttrFlag;
  FiDisplayProp := ARecord.iDisplayProp;
  FiExtendedFlag := ARecord.iExtendedFlag;
  FbReadOnly := ARecord.bReadOnly;
  FiEditProp := ARecord.iEditProp;
  FulTag := ARecord.ulTag;
end;

function DRATTRDescWrapper.ObjToRec: DRATTRDesc;
begin
  result.iAttrType := FiAttrType;
  result.iUnits1 := FiUnits1;
  result.iUnits2 := FiUnits2;
  result.bReqd := FbReqd;
  result.ulAttrFlag := FulAttrFlag;
  result.iDisplayProp := FiDisplayProp;
  result.iExtendedFlag := FiExtendedFlag;
  result.bReadOnly := FbReadOnly;
  result.iEditProp := FiEditProp;
  result.ulTag := FulTag;
end;

constructor DRRELTypeWrapper.Create(ARecord: DRRELType);
begin
  inherited Create;
  FiNumAttr := ARecord.iNumAttr;
  FeRelConstraint := ARecord.eRelConstraint;
  FeRelCategory := ARecord.eRelCategory;
  FulRelFlag := ARecord.ulRelFlag;
end;

function DRRELTypeWrapper.ObjToRec: DRRELType;
begin
  result.iNumAttr := FiNumAttr;
  result.eRelConstraint := FeRelConstraint;
  result.eRelCategory := FeRelCategory;
  result.ulRelFlag := FulRelFlag;
end;

constructor DRObjectWrapper.Create(ARecord: DRObject);
begin
  inherited Create;
  FulObjId := ARecord.ulObjId;
  FiVersion := ARecord.iVersion;
end;

function DRObjectWrapper.ObjToRec: DRObject;
begin
  result.ulObjId := FulObjId;
  result.iVersion := FiVersion;
end;

constructor DataSourcesWrapper.Create(ARecord: DataSources);
begin
  inherited Create;
  FiNumElem := ARecord.iNumElem;
  FbRequired := ARecord.bRequired;
end;

function DataSourcesWrapper.ObjToRec: DataSources;
begin
  result.iNumElem := FiNumElem;
  result.bRequired := FbRequired;
end;



procedure TatBDELibrary.__ErrCat(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(BDE.ErrCat(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDELibrary.__ErrCode(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(BDE.ErrCode(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDELibrary.__DbiExit(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(BDE.DbiExit);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDELibrary.__DbiDLLExit(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(BDE.DbiDLLExit);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDELibrary.__DbiGetSysVersion(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: SYSVersion;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is SYSVersionWrapper) then 
  Param0Rec := SYSVersionWrapper.Create(Param0);
Param0 := SYSVersionWrapper(Param0Rec).ObjToRec;
AResult := Integer(BDE.DbiGetSysVersion(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(SYSVersionWrapper.Create(Param0)));
  end;
end;

procedure TatBDELibrary.__DbiGetSysConfig(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: SYSConfig;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is SYSConfigWrapper) then 
  Param0Rec := SYSConfigWrapper.Create(Param0);
Param0 := SYSConfigWrapper(Param0Rec).ObjToRec;
AResult := Integer(BDE.DbiGetSysConfig(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(SYSConfigWrapper.Create(Param0)));
  end;
end;

procedure TatBDELibrary.__DbiGetClientInfo(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: CLIENTInfo;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is CLIENTInfoWrapper) then 
  Param0Rec := CLIENTInfoWrapper.Create(Param0);
Param0 := CLIENTInfoWrapper(Param0Rec).ObjToRec;
AResult := Integer(BDE.DbiGetClientInfo(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(CLIENTInfoWrapper.Create(Param0)));
  end;
end;

procedure TatBDELibrary.__DbiGetSysInfo(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: SYSInfo;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is SYSInfoWrapper) then 
  Param0Rec := SYSInfoWrapper.Create(Param0);
Param0 := SYSInfoWrapper(Param0Rec).ObjToRec;
AResult := Integer(BDE.DbiGetSysInfo(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(SYSInfoWrapper.Create(Param0)));
  end;
end;

procedure TatBDELibrary.__DbiLoadDriver(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(BDE.DbiLoadDriver(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDELibrary.__DbiGetSesInfo(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: SESInfo;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is SESInfoWrapper) then 
  Param0Rec := SESInfoWrapper.Create(Param0);
Param0 := SESInfoWrapper(Param0Rec).ObjToRec;
AResult := Integer(BDE.DbiGetSesInfo(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(SESInfoWrapper.Create(Param0)));
  end;
end;

procedure TatBDELibrary.__DbiSetPrivateDir(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(BDE.DbiSetPrivateDir(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDELibrary.__DbiGetDriverDesc(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: DRVType;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is DRVTypeWrapper) then 
  Param1Rec := DRVTypeWrapper.Create(Param1);
Param1 := DRVTypeWrapper(Param1Rec).ObjToRec;
AResult := Integer(BDE.DbiGetDriverDesc(PAnsiChar(VarToStr(GetInputArg(0))),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(DRVTypeWrapper.Create(Param1)));
  end;
end;

procedure TatBDELibrary.__DbiGetTableTypeDesc(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: TBLType;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is TBLTypeWrapper) then 
  Param2Rec := TBLTypeWrapper.Create(Param2);
Param2 := TBLTypeWrapper(Param2Rec).ObjToRec;
AResult := Integer(BDE.DbiGetTableTypeDesc(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(TBLTypeWrapper.Create(Param2)));
  end;
end;

procedure TatBDELibrary.__DbiGetFieldTypeDesc(AMachine: TatVirtualMachine);
  var
  Param3Rec: TObject;
  Param3: FLDType;
  AResult: variant;
begin
  with AMachine do
  begin
Param3Rec := TObject(integer(GetInputArg(3)));
if not Assigned(Param3Rec) or not (Param3Rec is FLDTypeWrapper) then 
  Param3Rec := FLDTypeWrapper.Create(Param3);
Param3 := FLDTypeWrapper(Param3Rec).ObjToRec;
AResult := Integer(BDE.DbiGetFieldTypeDesc(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),PAnsiChar(VarToStr(GetInputArg(2))),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,integer(FLDTypeWrapper.Create(Param3)));
  end;
end;

procedure TatBDELibrary.__DbiGetIndexTypeDesc(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: IDXType;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is IDXTypeWrapper) then 
  Param2Rec := IDXTypeWrapper.Create(Param2);
Param2 := IDXTypeWrapper(Param2Rec).ObjToRec;
AResult := Integer(BDE.DbiGetIndexTypeDesc(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(IDXTypeWrapper.Create(Param2)));
  end;
end;

procedure TatBDELibrary.__DbiCheckRefresh(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(BDE.DbiCheckRefresh);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDELibrary.__DbiSetLockRetry(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(BDE.DbiSetLockRetry(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDELibrary.__DbiGetErrorEntry(AMachine: TatVirtualMachine);
  var
  Param1: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Integer(BDE.DbiGetErrorEntry(VarToInteger(GetInputArg(0)),Param1,PAnsiChar(VarToStr(GetInputArg(2)))));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatBDELibrary.__DbiGetErrorInfo(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: DBIErrInfo;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is DBIErrInfoWrapper) then 
  Param1Rec := DBIErrInfoWrapper.Create(Param1);
Param1 := DBIErrInfoWrapper(Param1Rec).ObjToRec;
AResult := Integer(BDE.DbiGetErrorInfo(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(DBIErrInfoWrapper.Create(Param1)));
  end;
end;

procedure TatBDELibrary.__DbiGetErrorString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(BDE.DbiGetErrorString(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDELibrary.__DbiGetErrorContext(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(BDE.DbiGetErrorContext(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDELibrary.__DbiDateEncode(AMachine: TatVirtualMachine);
  var
  Param3: DBIDATE;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
AResult := Integer(BDE.DbiDateEncode(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatBDELibrary.__DbiDateDecode(AMachine: TatVirtualMachine);
  var
  Param1: Word;
  Param2: Word;
  Param3: SmallInt;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
Param2 := VarToInteger(GetInputArg(2));
Param3 := VarToInteger(GetInputArg(3));
AResult := Integer(BDE.DbiDateDecode(VarToInteger(GetInputArg(0)),Param1,Param2,Param3));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
    SetInputArg(2,Integer(Param2));
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatBDELibrary.__DbiTimeEncode(AMachine: TatVirtualMachine);
  var
  Param3: Time;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
AResult := Integer(BDE.DbiTimeEncode(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatBDELibrary.__DbiTimeDecode(AMachine: TatVirtualMachine);
  var
  Param1: Word;
  Param2: Word;
  Param3: Word;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
Param2 := VarToInteger(GetInputArg(2));
Param3 := VarToInteger(GetInputArg(3));
AResult := Integer(BDE.DbiTimeDecode(VarToInteger(GetInputArg(0)),Param1,Param2,Param3));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
    SetInputArg(2,Integer(Param2));
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatBDELibrary.__DbiTimeStampEncode(AMachine: TatVirtualMachine);
  var
  Param2: TimeStamp;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
AResult := Integer(BDE.DbiTimeStampEncode(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Param2);
  end;
end;

procedure TatBDELibrary.__DbiTimeStampDecode(AMachine: TatVirtualMachine);
  var
  Param1: DBIDATE;
  Param2: Time;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(BDE.DbiTimeStampDecode(GetInputArg(0),Param1,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatBDELibrary.__DbiBcdFromFloat(AMachine: TatVirtualMachine);
  var
  Param0: Double;
  Param3Rec: TObject;
  Param3: FMTBcd;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
Param3Rec := TObject(integer(GetInputArg(3)));
if not Assigned(Param3Rec) or not (Param3Rec is FMTBcdWrapper) then 
  Param3Rec := FMTBcdWrapper.Create(Param3);
Param3 := FMTBcdWrapper(Param3Rec).ObjToRec;
AResult := Integer(BDE.DbiBcdFromFloat(Param0,VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
    SetInputArg(3,integer(FMTBcdWrapper.Create(Param3)));
  end;
end;

procedure TatBDELibrary.__DbiBcdToFloat(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: FMTBcd;
  Param1: Double;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is FMTBcdWrapper) then 
  Param0Rec := FMTBcdWrapper.Create(Param0);
Param0 := FMTBcdWrapper(Param0Rec).ObjToRec;
Param1 := GetInputArg(1);
AResult := Integer(BDE.DbiBcdToFloat(Param0,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(FMTBcdWrapper.Create(Param0)));
    SetInputArg(1,Param1);
  end;
end;

procedure TatBDELibrary.__DbiGetDateFormat(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: FMTDate;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is FMTDateWrapper) then 
  Param0Rec := FMTDateWrapper.Create(Param0);
Param0 := FMTDateWrapper(Param0Rec).ObjToRec;
AResult := Integer(BDE.DbiGetDateFormat(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(FMTDateWrapper.Create(Param0)));
  end;
end;

procedure TatBDELibrary.__DbiSetDateFormat(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: FMTDate;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is FMTDateWrapper) then 
  Param0Rec := FMTDateWrapper.Create(Param0);
Param0 := FMTDateWrapper(Param0Rec).ObjToRec;
AResult := Integer(BDE.DbiSetDateFormat(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(FMTDateWrapper.Create(Param0)));
  end;
end;

procedure TatBDELibrary.__DbiGetTimeFormat(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: FMTTime;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is FMTTimeWrapper) then 
  Param0Rec := FMTTimeWrapper.Create(Param0);
Param0 := FMTTimeWrapper(Param0Rec).ObjToRec;
AResult := Integer(BDE.DbiGetTimeFormat(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(FMTTimeWrapper.Create(Param0)));
  end;
end;

procedure TatBDELibrary.__DbiSetTimeFormat(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: FMTTime;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is FMTTimeWrapper) then 
  Param0Rec := FMTTimeWrapper.Create(Param0);
Param0 := FMTTimeWrapper(Param0Rec).ObjToRec;
AResult := Integer(BDE.DbiSetTimeFormat(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(FMTTimeWrapper.Create(Param0)));
  end;
end;

procedure TatBDELibrary.__DbiGetNumberFormat(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: FMTNumber;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is FMTNumberWrapper) then 
  Param0Rec := FMTNumberWrapper.Create(Param0);
Param0 := FMTNumberWrapper(Param0Rec).ObjToRec;
AResult := Integer(BDE.DbiGetNumberFormat(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(FMTNumberWrapper.Create(Param0)));
  end;
end;

procedure TatBDELibrary.__DbiSetNumberFormat(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: FMTNumber;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is FMTNumberWrapper) then 
  Param0Rec := FMTNumberWrapper.Create(Param0);
Param0 := FMTNumberWrapper(Param0Rec).ObjToRec;
AResult := Integer(BDE.DbiSetNumberFormat(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(FMTNumberWrapper.Create(Param0)));
  end;
end;

procedure TatBDELibrary.__DbiUseIdleTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(BDE.DbiUseIdleTime);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDELibrary.__DbiGetLdName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(BDE.DbiGetLdName(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1))),PAnsiChar(VarToStr(GetInputArg(2)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDELibrary.__DbiAddPassword(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(BDE.DbiAddPassword(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDELibrary.__DbiDropPassword(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(BDE.DbiDropPassword(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDELibrary.__DbiGetNetUserName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(BDE.DbiGetNetUserName(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDELibrary.__DbiDebugLayerOptions(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(BDE.DbiDebugLayerOptions(VarToInteger(GetInputArg(0)),PAnsiChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDELibrary.__OsLdInit(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(BDE.OsLdInit(PAnsiChar(VarToStr(GetInputArg(0))),PAnsiChar(VarToStr(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDELibrary.__OsLdExit(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(BDE.OsLdExit);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDELibrary.__OsLdSetConvChars(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(BDE.OsLdSetConvChars(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDELibrary.__DbiDRDelete(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(BDE.DbiDRDelete(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDELibrary.__DbiDRDrop(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(BDE.DbiDRDrop(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDELibrary.__DbiSetDefaultRepository(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(BDE.DbiSetDefaultRepository(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDELibrary.__DbiGetDefaultRepository(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(BDE.DbiGetDefaultRepository(PAnsiChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatBDELibrary.Init;

  procedure AddConsts1;
  begin
    with Scripter.DefineClass(ClassType) do
    begin
      AddConstant('lkupNONE',lkupNONE);
      AddConstant('lkupPRIVATE',lkupPRIVATE);
      AddConstant('lkupALLCORRESP',lkupALLCORRESP);
      AddConstant('lkupHELP',lkupHELP);
      AddConstant('lkupALLCORRESPHELP',lkupALLCORRESPHELP);
      AddConstant('rintMASTER',rintMASTER);
      AddConstant('rintDEPENDENT',rintDEPENDENT);
      AddConstant('rintRESTRICT',rintRESTRICT);
      AddConstant('rintCASCADE',rintCASCADE);
      AddConstant('objFILLER',objFILLER);
      AddConstant('objSYSTEM',objSYSTEM);
      AddConstant('objSESSION',objSESSION);
      AddConstant('objDRIVER',objDRIVER);
      AddConstant('objDATABASE',objDATABASE);
      AddConstant('objCURSOR',objCURSOR);
      AddConstant('objSTATEMENT',objSTATEMENT);
      AddConstant('objCLIENT',objCLIENT);
      AddConstant('objDBSEC',objDBSEC);
      AddConstant('objREPOSITORY',objREPOSITORY);
      AddConstant('dbiOPENSHARED',dbiOPENSHARED);
      AddConstant('dbiOPENEXCL',dbiOPENEXCL);
      AddConstant('dbiREADWRITE',dbiREADWRITE);
      AddConstant('dbiREADONLY',dbiREADONLY);
      AddConstant('dbiNOLOCK',dbiNOLOCK);
      AddConstant('dbiWRITELOCK',dbiWRITELOCK);
      AddConstant('dbiREADLOCK',dbiREADLOCK);
      AddConstant('xltNONE',xltNONE);
      AddConstant('xltRECORD',xltRECORD);
      AddConstant('xltFIELD',xltFIELD);
      AddConstant('updWHEREALL',updWHEREALL);
      AddConstant('updWHEREKEYCHG',updWHEREKEYCHG);
      AddConstant('updWHEREKEY',updWHEREKEY);
      AddConstant('exactRecCntINEXPENSIVE',exactRecCntINEXPENSIVE);
      AddConstant('exactRecCntEXPENSIVE',exactRecCntEXPENSIVE);
      AddConstant('exactRecCntUNKNOWN',exactRecCntUNKNOWN);
      AddConstant('dbiDelayedUpdCommit',dbiDelayedUpdCommit);
      AddConstant('dbiDelayedUpdCancel',dbiDelayedUpdCancel);
      AddConstant('dbiDelayedUpdCancelCurrent',dbiDelayedUpdCancelCurrent);
      AddConstant('dbiDelayedUpdPrepare',dbiDelayedUpdPrepare);
      AddConstant('xilDIRTYREAD',xilDIRTYREAD);
      AddConstant('xilREADCOMMITTED',xilREADCOMMITTED);
      AddConstant('xilREPEATABLEREAD',xilREPEATABLEREAD);
      AddConstant('xendCOMMIT',xendCOMMIT);
      AddConstant('xendCOMMITKEEP',xendCOMMITKEEP);
      AddConstant('xendABORT',xendABORT);
      AddConstant('xsINACTIVE',xsINACTIVE);
      AddConstant('xsACTIVE',xsACTIVE);
      AddConstant('keySEARCHEQ',keySEARCHEQ);
      AddConstant('keySEARCHGT',keySEARCHGT);
      AddConstant('keySEARCHGEQ',keySEARCHGEQ);
      AddConstant('crNOOP',crNOOP);
      AddConstant('crADD',crADD);
      AddConstant('crCOPY',crCOPY);
      AddConstant('crMODIFY',crMODIFY);
      AddConstant('crDROP',crDROP);
      AddConstant('crREDO',crREDO);
      AddConstant('crTABLE',crTABLE);
      AddConstant('crGROUP',crGROUP);
      AddConstant('crFAMILY',crFAMILY);
      AddConstant('crDONE',crDONE);
      AddConstant('crDROPADD',crDROPADD);
      AddConstant('batchAPPEND',batchAPPEND);
      AddConstant('batchUPDATE',batchUPDATE);
      AddConstant('batchAPPENDUPDATE',batchAPPENDUPDATE);
      AddConstant('batchSUBTRACT',batchSUBTRACT);
      AddConstant('batchCOPY',batchCOPY);
      AddConstant('sortASCEND',sortASCEND);
      AddConstant('sortDESCEND',sortDESCEND);
      AddConstant('drvFILLER',drvFILLER);
      AddConstant('drvFILE',drvFILE);
      AddConstant('drvOTHERSERVER',drvOTHERSERVER);
      AddConstant('drvSQLBASEDSERVER',drvSQLBASEDSERVER);
      AddConstant('drvOLEDBPROVIDER',drvOLEDBPROVIDER);
      AddConstant('opFILLER0',opFILLER0);
      AddConstant('opFILLER1',opFILLER1);
      AddConstant('opFILLER2',opFILLER2);
      AddConstant('opDBCREATE',opDBCREATE);
      AddConstant('opDBOPEN',opDBOPEN);
      AddConstant('opTBLCREATE',opTBLCREATE);
      AddConstant('opTBLOPEN',opTBLOPEN);
      AddConstant('epropINVALID',epropINVALID);
      AddConstant('epropCANGET',epropCANGET);
      AddConstant('epropCANSET',epropCANSET);
      AddConstant('delayupdNONE',delayupdNONE);
      AddConstant('delayupdMODIFY',delayupdMODIFY);
      AddConstant('delayupdINSERT',delayupdINSERT);
      AddConstant('delayupdDELETE',delayupdDELETE);
      AddConstant('restrNONE',restrNONE);
      AddConstant('restrNEWFLD',restrNEWFLD);
      AddConstant('restrOLDFLD',restrOLDFLD);
      AddConstant('restrNEWINDEX',restrNEWINDEX);
      AddConstant('restrOLDINDEX',restrOLDINDEX);
      AddConstant('restrNEWVCHK',restrNEWVCHK);
      AddConstant('restrOLDVCHK',restrOLDVCHK);
      AddConstant('restrNEWRINT',restrNEWRINT);
      AddConstant('restrOLDRINT',restrOLDRINT);
      AddConstant('restrNEWSEC',restrNEWSEC);
      AddConstant('restrOLDSEC',restrOLDSEC);
      AddConstant('restrNEWTABLE',restrNEWTABLE);
      AddConstant('cbiFILLER',cbiFILLER);
      AddConstant('cbiMDXMISSING',cbiMDXMISSING);
      AddConstant('cbiPDXLOOKUP',cbiPDXLOOKUP);
      AddConstant('cbiPDXBLOB',cbiPDXBLOB);
      AddConstant('cbiDBTMISSING',cbiDBTMISSING);
      AddConstant('cbiDRINPUT',cbiDRINPUT);
      AddConstant('cbiRINTMISSING',cbiRINTMISSING);
      AddConstant('cbscRETURN',cbscRETURN);
      AddConstant('cbscSQL',cbscSQL);
      AddConstant('cbYieldFirst',cbYieldFirst);
      AddConstant('cbYieldContinue',cbYieldContinue);
      AddConstant('cbYieldLast',cbYieldLast);
      AddConstant('qrylangUNKNOWN',qrylangUNKNOWN);
      AddConstant('qrylangQBE',qrylangQBE);
      AddConstant('qrylangSQL',qrylangSQL);
      AddConstant('paramUNKNOWN',paramUNKNOWN);
      AddConstant('paramIN',paramIN);
      AddConstant('paramOUT',paramOUT);
      AddConstant('paramINOUT',paramINOUT);
      AddConstant('paramRET',paramRET);
      AddConstant('paramfmtUNKNOWN',paramfmtUNKNOWN);
      AddConstant('paramfmtNUMBER',paramfmtNUMBER);
      AddConstant('paramfmtNAME',paramfmtNAME);
      AddConstant('fnAVG',fnAVG);
      AddConstant('fnCOUNT',fnCOUNT);
      AddConstant('fnMIN',fnMIN);
      AddConstant('fnMAX',fnMAX);
      AddConstant('fnSUM',fnSUM);
      AddConstant('fnSTDDEV',fnSTDDEV);
      AddConstant('fnVARIANCE',fnVARIANCE);
      AddConstant('fnABS',fnABS);
      AddConstant('fnCEIL',fnCEIL);
      AddConstant('fnCOS',fnCOS);
      AddConstant('fnCOSH',fnCOSH);
      AddConstant('fnEXP',fnEXP);
      AddConstant('fnFLOOR',fnFLOOR);
      AddConstant('fnLN',fnLN);
      AddConstant('fnLOG',fnLOG);
      AddConstant('fnMOD',fnMOD);
      AddConstant('fnPOWER',fnPOWER);
      AddConstant('fnROUND',fnROUND);
      AddConstant('fnSIGN',fnSIGN);
      AddConstant('fnSIN',fnSIN);
      AddConstant('fnSINH',fnSINH);
      AddConstant('fnSQRT',fnSQRT);
      AddConstant('fnTAN',fnTAN);
      AddConstant('fnTANH',fnTANH);
      AddConstant('fnTRUNC',fnTRUNC);
      AddConstant('fnCHR',fnCHR);
      AddConstant('fnCONCAT',fnCONCAT);
      AddConstant('fnINITCAP',fnINITCAP);
      AddConstant('fnLOWER',fnLOWER);
      AddConstant('fnLPAD',fnLPAD);
      AddConstant('fnLTRIM',fnLTRIM);
      AddConstant('fnNLS_INITCAP',fnNLS_INITCAP);
      AddConstant('fnNLS_LOWER',fnNLS_LOWER);
      AddConstant('fnNLS_UPPER',fnNLS_UPPER);
      AddConstant('fnREPLACE',fnREPLACE);
      AddConstant('fnRPAD',fnRPAD);
      AddConstant('fnRTRIM',fnRTRIM);
      AddConstant('fnSOUNDEX',fnSOUNDEX);
      AddConstant('fnSUBSTR',fnSUBSTR);
      AddConstant('fnSUBSTRB',fnSUBSTRB);
      AddConstant('fnTRANSLATE',fnTRANSLATE);
      AddConstant('fnUPPER',fnUPPER);
      AddConstant('fnASCII',fnASCII);
      AddConstant('fnINSTR',fnINSTR);
      AddConstant('fnINSTRB',fnINSTRB);
      AddConstant('fnLENGTH',fnLENGTH);
      AddConstant('fnLENGTHB',fnLENGTHB);
      AddConstant('fnNLSSORT',fnNLSSORT);
      AddConstant('fnADD_MONTHS',fnADD_MONTHS);
      AddConstant('fnLAST_DAY',fnLAST_DAY);
      AddConstant('fnMONTHS_BETWEEN',fnMONTHS_BETWEEN);
      AddConstant('fnNEW_TIME',fnNEW_TIME);
      AddConstant('fnNEXT_DAY',fnNEXT_DAY);
      AddConstant('fnSYSDATE',fnSYSDATE);
      AddConstant('fnCONVERT',fnCONVERT);
      AddConstant('fnTO_CHAR',fnTO_CHAR);
      AddConstant('fnTO_DATE',fnTO_DATE);
      AddConstant('fnTO_MULTI_BYTE',fnTO_MULTI_BYTE);
      AddConstant('fnTO_NUMBER',fnTO_NUMBER);
      AddConstant('fnTO_SINGLE_BYTE',fnTO_SINGLE_BYTE);
      AddConstant('fnUID',fnUID);
      AddConstant('fnUSER',fnUSER);
      AddConstant('fnORACLEMISC',fnORACLEMISC);
      AddConstant('fnACOS',fnACOS);
      AddConstant('fnASIN',fnASIN);
      AddConstant('fnATAN',fnATAN);
      AddConstant('fnATN2',fnATN2);
      AddConstant('fnCOT',fnCOT);
      AddConstant('fnDEGREES',fnDEGREES);
      AddConstant('fnLOG10',fnLOG10);
      AddConstant('fnPI',fnPI);
      AddConstant('fnRADIANS',fnRADIANS);
      AddConstant('fnRAND',fnRAND);
      AddConstant('fnTEXTPTR',fnTEXTPTR);
      AddConstant('fnTEXTVALID',fnTEXTVALID);
      AddConstant('fnCHARINDEX',fnCHARINDEX);
      AddConstant('fnDIFFERENCE',fnDIFFERENCE);
      AddConstant('fnPATINDEX',fnPATINDEX);
      AddConstant('fnREPLICATE',fnREPLICATE);
      AddConstant('fnREVERSE',fnREVERSE);
      AddConstant('fnRIGHT',fnRIGHT);
      AddConstant('fnSPACE',fnSPACE);
      AddConstant('fnSTR',fnSTR);
      AddConstant('fnSTUFF',fnSTUFF);
      AddConstant('fnCOL_NAME',fnCOL_NAME);
      AddConstant('fnCOL_LENGTH',fnCOL_LENGTH);
      AddConstant('fnDATALENGTH',fnDATALENGTH);
      AddConstant('fnDB_ID',fnDB_ID);
      AddConstant('fnDB_NAME',fnDB_NAME);
      AddConstant('fnHOST_ID',fnHOST_ID);
      AddConstant('fnHOST_NAME',fnHOST_NAME);
      AddConstant('fnINDEX_COL',fnINDEX_COL);
      AddConstant('fnOBJECT_ID',fnOBJECT_ID);
      AddConstant('fnOBJECT_NAME',fnOBJECT_NAME);
      AddConstant('fnUSER_ID',fnUSER_ID);
      AddConstant('fnUSER_NAME',fnUSER_NAME);
      AddConstant('fnLEFT',fnLEFT);
      AddConstant('fnLOCATE',fnLOCATE);
      AddConstant('fnTRUNCATE',fnTRUNCATE);
      AddConstant('fnCURTIME',fnCURTIME);
      AddConstant('fnDAYNAME',fnDAYNAME);
      AddConstant('fnDAYOFMONTH',fnDAYOFMONTH);
      AddConstant('fnDAYOFWEEK',fnDAYOFWEEK);
      AddConstant('fnDAYOFYEAR',fnDAYOFYEAR);
      AddConstant('fnHOUR',fnHOUR);
      AddConstant('fnMINUTE',fnMINUTE);
      AddConstant('fnMONTH',fnMONTH);
      AddConstant('fnMONTHNAME',fnMONTHNAME);
      AddConstant('fnNOW',fnNOW);
      AddConstant('fnQUARTER',fnQUARTER);
      AddConstant('fnSECOND',fnSECOND);
      AddConstant('fnWEEK',fnWEEK);
      AddConstant('fnYEAR',fnYEAR);
      AddConstant('fnDAY',fnDAY);
      AddConstant('fnWEEKDAY',fnWEEKDAY);
      AddConstant('fnTODAY',fnTODAY);
      AddConstant('fnDATE',fnDATE);
      AddConstant('fnINFMISC',fnINFMISC);
      AddConstant('fnDummy',fnDummy);
      AddConstant('fnListINCL_USER_DEF',fnListINCL_USER_DEF);
      AddConstant('cfgPersistent',cfgPersistent);
      AddConstant('cfgSession',cfgSession);
      AddConstant('cfgAll',cfgAll);
      AddConstant('cfgUpdateOn',cfgUpdateOn);
      AddConstant('cfgUpdateOff',cfgUpdateOff);
      AddConstant('fmlUNKNOWN',fmlUNKNOWN);
      AddConstant('fmlTABLE',fmlTABLE);
      AddConstant('fmlINDEX',fmlINDEX);
      AddConstant('fmlFORM',fmlFORM);
      AddConstant('fmlREPORT',fmlREPORT);
      AddConstant('fmlVALCHECK',fmlVALCHECK);
      AddConstant('fmlSECINDEX',fmlSECINDEX);
      AddConstant('fmlSECINDEX2',fmlSECINDEX2);
      AddConstant('fmlBLOBFILE',fmlBLOBFILE);
      AddConstant('canNOTDEFINED',canNOTDEFINED);
      AddConstant('canISBLANK',canISBLANK);
      AddConstant('canNOTBLANK',canNOTBLANK);
      AddConstant('canEQ',canEQ);
      AddConstant('canNE',canNE);
      AddConstant('canGT',canGT);
      AddConstant('canLT',canLT);
      AddConstant('canGE',canGE);
      AddConstant('canLE',canLE);
      AddConstant('canNOT',canNOT);
      AddConstant('canAND',canAND);
      AddConstant('canOR',canOR);
      AddConstant('canTUPLE2',canTUPLE2);
      AddConstant('canFIELD2',canFIELD2);
      AddConstant('canCONST2',canCONST2);
      AddConstant('canMINUS',canMINUS);
      AddConstant('canADD',canADD);
      AddConstant('canSUB',canSUB);
      AddConstant('canMUL',canMUL);
      AddConstant('canDIV',canDIV);
      AddConstant('canMOD',canMOD);
      AddConstant('canREM',canREM);
      AddConstant('canSUM',canSUM);
      AddConstant('canCOUNT',canCOUNT);
      AddConstant('canMIN',canMIN);
      AddConstant('canMAX',canMAX);
      AddConstant('canAVG',canAVG);
      AddConstant('canCONT',canCONT);
      AddConstant('canUDF2',canUDF2);
      AddConstant('canCONTINUE2',canCONTINUE2);
      AddConstant('canLIKE',canLIKE);
      AddConstant('canIN',canIN);
      AddConstant('canLIST2',canLIST2);
      AddConstant('canUPPER',canUPPER);
      AddConstant('canLOWER',canLOWER);
      AddConstant('canFUNC2',canFUNC2);
      AddConstant('canLISTELEM2',canLISTELEM2);
      AddConstant('canASSIGN',canASSIGN);
      AddConstant('nodeNULL',nodeNULL);
      AddConstant('nodeUNARY',nodeUNARY);
      AddConstant('nodeBINARY',nodeBINARY);
      AddConstant('nodeCOMPARE',nodeCOMPARE);
      AddConstant('nodeFIELD',nodeFIELD);
      AddConstant('nodeCONST',nodeCONST);
      AddConstant('nodeTUPLE',nodeTUPLE);
      AddConstant('nodeCONTINUE',nodeCONTINUE);
      AddConstant('nodeUDF',nodeUDF);
      AddConstant('nodeLIST',nodeLIST);
      AddConstant('nodeFUNC',nodeFUNC);
      AddConstant('nodeLISTELEM',nodeLISTELEM);
      AddConstant('dbiqryDEFAULT',dbiqryDEFAULT);
      AddConstant('dbiqryDIRTY',dbiqryDIRTY);
      AddConstant('dbiqryCLEAN',dbiqryCLEAN);
      AddConstant('dbiqryRESTART',dbiqryRESTART);
      AddConstant('qryModeNONE',qryModeNONE);
      AddConstant('qryModeLOCAL',qryModeLOCAL);
      AddConstant('qryModeSERVER',qryModeSERVER);
      AddConstant('qryModeEITHER',qryModeEITHER);
      AddConstant('qryModeNOWLOCAL',qryModeNOWLOCAL);
      AddConstant('wantDEFAULT',wantDEFAULT);
      AddConstant('wantLIVE',wantLIVE);
      AddConstant('wantCANNED',wantCANNED);
      AddConstant('wantSPEED',wantSPEED);
      AddConstant('NOCHECK',NOCHECK);
      AddConstant('chkCHECK',chkCHECK);
      AddConstant('chkCHECKPLUS',chkCHECKPLUS);
      AddConstant('chkCHECKDESC',chkCHECKDESC);
      AddConstant('opUNKNOWNOP',opUNKNOWNOP);
      AddConstant('opEQUAL',opEQUAL);
      AddConstant('opNOTEQ',opNOTEQ);
      AddConstant('opLESSEQUAL',opLESSEQUAL);
      AddConstant('opGREQUAL',opGREQUAL);
      AddConstant('opLESS',opLESS);
      AddConstant('opGREATER',opGREATER);
      AddConstant('opLIKE',opLIKE);
      AddConstant('opNOT',opNOT);
      AddConstant('opPLUSX',opPLUSX);
      AddConstant('opMINUSX',opMINUSX);
      AddConstant('opTIMESX',opTIMESX);
      AddConstant('opDIVX',opDIVX);
      AddConstant('opAND',opAND);
      AddConstant('opOR',opOR);
      AddConstant('opBLANK',opBLANK);
      AddConstant('opAS',opAS);
      AddConstant('opOUTERJOIN',opOUTERJOIN);
      AddConstant('opNOTLIKE',opNOTLIKE);
      AddConstant('opCHANGETO',opCHANGETO);
      AddConstant('opUPPER',opUPPER);
      AddConstant('opLOWER',opLOWER);
      AddConstant('opTRIM',opTRIM);
      AddConstant('opSUBSTRING',opSUBSTRING);
      AddConstant('opPAND',opPAND);
      AddConstant('opPOR',opPOR);
      AddConstant('opPNOT',opPNOT);
      AddConstant('opEXTRACT',opEXTRACT);
      AddConstant('opFULLOTRJOIN',opFULLOTRJOIN);
      AddConstant('eRelManyMany',eRelManyMany);
      AddConstant('eRelManyOne',eRelManyOne);
      AddConstant('eRelOneMany',eRelOneMany);
      AddConstant('eRelOneOne',eRelOneOne);
      AddConstant('eRelGENERAL',eRelGENERAL);
      AddConstant('eRelCONTAINS',eRelCONTAINS);
      AddConstant('eRelREFERS',eRelREFERS);
      AddConstant('eRelBASEDON',eRelBASEDON);
      AddConstant('dsNumSources',dsNumSources);
      AddConstant('dsDefSources',dsDefSources);
      AddConstant('dsSource',dsSource);
      AddConstant('dsFieldSource',dsFieldSource);
      AddConstant('dsFieldDefault',dsFieldDefault);
      AddConstant('dsFieldDomainExpr',dsFieldDomainExpr);
      AddConstant('dsTblConstraint',dsTblConstraint);
      AddConstant('dsNumTblConstraint',dsNumTblConstraint);
      AddConstant('expDomain',expDomain);
      AddConstant('expRecConstr',expRecConstr);
      AddConstant('expDefault',expDefault);
      AddConstant('DBIINTFVER',DBIINTFVER);
      AddConstant('DBIENGVERSION',DBIENGVERSION);
      AddConstant('DEBUGON',DEBUGON);
      AddConstant('OUTPUTTOFILE',OUTPUTTOFILE);
      AddConstant('FLUSHEVERYOP',FLUSHEVERYOP);
      AddConstant('APPENDTOLOG',APPENDTOLOG);
      AddConstant('DBIMAXNAMELEN',DBIMAXNAMELEN);
      AddConstant('DBIMAXSPNAMELEN',DBIMAXSPNAMELEN);
      AddConstant('DBIMAXFUNCNAMELEN',DBIMAXFUNCNAMELEN);
      AddConstant('DBIMAXFLDSINKEY',DBIMAXFLDSINKEY);
      AddConstant('DBIMAXKEYEXPLEN',DBIMAXKEYEXPLEN);
      AddConstant('DBIMAXEXTLEN',DBIMAXEXTLEN);
      AddConstant('DBIMAXTBLNAMELEN',DBIMAXTBLNAMELEN);
      AddConstant('DBIMAXDRIVELEN',DBIMAXDRIVELEN);
      AddConstant('DBIMAXPATHLEN',DBIMAXPATHLEN);
      AddConstant('DBIMAXMSGLEN',DBIMAXMSGLEN);
      AddConstant('DBIMAXVCHKLEN',DBIMAXVCHKLEN);
      AddConstant('DBIMAXPICTLEN',DBIMAXPICTLEN);
      AddConstant('DBIMAXFLDSINSEC',DBIMAXFLDSINSEC);
      AddConstant('DBIMAXSCFIELDS',DBIMAXSCFIELDS);
      AddConstant('DBIMAXSCFLDLEN',DBIMAXSCFLDLEN);
      AddConstant('DBIMAXSCRECSIZE',DBIMAXSCRECSIZE);
      AddConstant('DBIMAXUSERNAMELEN',DBIMAXUSERNAMELEN);
      AddConstant('DBIMAXXBUSERNAMELEN',DBIMAXXBUSERNAMELEN);
      AddConstant('DBIMAXBOOKMARKLEN',DBIMAXBOOKMARKLEN);
      AddConstant('DBIMAXTRACELEN',DBIMAXTRACELEN);
      AddConstant('DBIMAXTYPEDESC',DBIMAXTYPEDESC);
      AddConstant('DBIMAXDRSQLSTR',DBIMAXDRSQLSTR);
      AddConstant('DBIMAXOLEDBNAMELEN',DBIMAXOLEDBNAMELEN);
      AddConstant('szPARADOX',szPARADOX);
      AddConstant('szDBASE',szDBASE);
      AddConstant('szFOXPRO',szFOXPRO);
      AddConstant('szASCII',szASCII);
      AddConstant('szOLEDB',szOLEDB);
      AddConstant('szMSACCESS',szMSACCESS);
      AddConstant('fldUNKNOWN',fldUNKNOWN);
      AddConstant('fldZSTRING',fldZSTRING);
      AddConstant('fldDATE',fldDATE);
      AddConstant('fldBLOB',fldBLOB);
      AddConstant('fldBOOL',fldBOOL);
      AddConstant('fldINT16',fldINT16);
      AddConstant('fldINT32',fldINT32);
      AddConstant('fldFLOAT',fldFLOAT);
      AddConstant('fldBCD',fldBCD);
      AddConstant('fldBYTES',fldBYTES);
      AddConstant('fldTIME',fldTIME);
      AddConstant('fldTIMESTAMP',fldTIMESTAMP);
      AddConstant('fldUINT16',fldUINT16);
      AddConstant('fldUINT32',fldUINT32);
      AddConstant('fldFLOATIEEE',fldFLOATIEEE);
      AddConstant('fldVARBYTES',fldVARBYTES);
      AddConstant('fldLOCKINFO',fldLOCKINFO);
      AddConstant('fldCURSOR',fldCURSOR);
      AddConstant('fldINT64',fldINT64);
      AddConstant('fldUINT64',fldUINT64);
      AddConstant('fldADT',fldADT);
      AddConstant('fldARRAY',fldARRAY);
      AddConstant('fldREF',fldREF);
      AddConstant('fldTABLE',fldTABLE);
      AddConstant('fldDATETIME',fldDATETIME);
      AddConstant('MAXLOGFLDTYPES',MAXLOGFLDTYPES);
      AddConstant('fldstMONEY',fldstMONEY);
      AddConstant('fldstMEMO',fldstMEMO);
      AddConstant('fldstBINARY',fldstBINARY);
      AddConstant('fldstFMTMEMO',fldstFMTMEMO);
      AddConstant('fldstOLEOBJ',fldstOLEOBJ);
      AddConstant('fldstGRAPHIC',fldstGRAPHIC);
      AddConstant('fldstDBSOLEOBJ',fldstDBSOLEOBJ);
      AddConstant('fldstTYPEDBINARY',fldstTYPEDBINARY);
      AddConstant('fldstACCOLEOBJ',fldstACCOLEOBJ);
      AddConstant('fldstHMEMO',fldstHMEMO);
      AddConstant('fldstHBINARY',fldstHBINARY);
      AddConstant('fldstBFILE',fldstBFILE);
      AddConstant('fldstPASSWORD',fldstPASSWORD);
      AddConstant('fldstFIXED',fldstFIXED);
      AddConstant('fldstUNICODE',fldstUNICODE);
      AddConstant('fldstAUTOINC',fldstAUTOINC);
      AddConstant('fldstADTNestedTable',fldstADTNestedTable);
      AddConstant('fldstADTDATE',fldstADTDATE);
      AddConstant('fldstGUID',fldstGUID);
      AddConstant('fldstINT64',fldstINT64);
      AddConstant('fldPDXCHAR',fldPDXCHAR);
      AddConstant('fldPDXNUM',fldPDXNUM);
      AddConstant('fldPDXMONEY',fldPDXMONEY);
      AddConstant('fldPDXDATE',fldPDXDATE);
      AddConstant('fldPDXSHORT',fldPDXSHORT);
      AddConstant('fldPDXMEMO',fldPDXMEMO);
      AddConstant('fldPDXBINARYBLOB',fldPDXBINARYBLOB);
      AddConstant('fldPDXFMTMEMO',fldPDXFMTMEMO);
      AddConstant('fldPDXOLEBLOB',fldPDXOLEBLOB);
      AddConstant('fldPDXGRAPHIC',fldPDXGRAPHIC);
      AddConstant('fldPDXBLOB',fldPDXBLOB);
      AddConstant('fldPDXLONG',fldPDXLONG);
      AddConstant('fldPDXTIME',fldPDXTIME);
      AddConstant('fldPDXDATETIME',fldPDXDATETIME);
      AddConstant('fldPDXBOOL',fldPDXBOOL);
      AddConstant('fldPDXAUTOINC',fldPDXAUTOINC);
      AddConstant('fldPDXBYTES',fldPDXBYTES);
      AddConstant('fldPDXBCD',fldPDXBCD);
      AddConstant('fldPDXUNICHAR',fldPDXUNICHAR);
      AddConstant('fldDBCHAR',fldDBCHAR);
      AddConstant('fldDBNUM',fldDBNUM);
      AddConstant('fldDBMEMO',fldDBMEMO);
      AddConstant('fldDBBOOL',fldDBBOOL);
      AddConstant('fldDBDATE',fldDBDATE);
      AddConstant('fldDBFLOAT',fldDBFLOAT);
      AddConstant('fldDBLOCK',fldDBLOCK);
      AddConstant('fldDBOLEBLOB',fldDBOLEBLOB);
      AddConstant('fldDBBINARY',fldDBBINARY);
      AddConstant('fldDBBYTES',fldDBBYTES);
      AddConstant('fldDBLONG',fldDBLONG);
      AddConstant('fldDBDATETIME',fldDBDATETIME);
      AddConstant('fldDBDOUBLE',fldDBDOUBLE);
      AddConstant('fldDBAUTOINC',fldDBAUTOINC);
      AddConstant('fldDBKEYNUM',fldDBKEYNUM);
      AddConstant('fldDBKEYBCD',fldDBKEYBCD);
      AddConstant('fldASCCHAR',fldASCCHAR);
      AddConstant('fldASCNUM',fldASCNUM);
      AddConstant('fldASCBOOL',fldASCBOOL);
      AddConstant('fldASCDATE',fldASCDATE);
      AddConstant('fldASCFLOAT',fldASCFLOAT);
      AddConstant('fldASCLOCK',fldASCLOCK);
      AddConstant('fldASCTIMESTAMP',fldASCTIMESTAMP);
      AddConstant('fldASCTIME',fldASCTIME);
      AddConstant('fldASCLONG',fldASCLONG);
      AddConstant('fldASCMONEY',fldASCMONEY);
      AddConstant('fldACCCHAR',fldACCCHAR);
      AddConstant('fldACCVARCHAR',fldACCVARCHAR);
      AddConstant('fldACCDATETIME',fldACCDATETIME);
      AddConstant('fldACCBIT',fldACCBIT);
      AddConstant('fldACCMONEY',fldACCMONEY);
      AddConstant('fldACCSHORT',fldACCSHORT);
      AddConstant('fldACCLONG',fldACCLONG);
      AddConstant('fldACCFLOAT',fldACCFLOAT);
      AddConstant('fldACCLONGTEXT',fldACCLONGTEXT);
      AddConstant('fldACCLONGBINARY',fldACCLONGBINARY);
      AddConstant('fldACCAUTOINC',fldACCAUTOINC);
      AddConstant('fldACCBYTE',fldACCBYTE);
      AddConstant('fldACCDOUBLE',fldACCDOUBLE);
      AddConstant('fldACCBINARY',fldACCBINARY);
      AddConstant('fldACCGUID',fldACCGUID);
      AddConstant('mdxDISTINCT',mdxDISTINCT);
      AddConstant('TODAYVAL',TODAYVAL);
      AddConstant('NOWVAL',NOWVAL);
      AddConstant('NOFAMRIGHTS',NOFAMRIGHTS);
      AddConstant('FORMRIGHTS',FORMRIGHTS);
      AddConstant('RPTRIGHTS',RPTRIGHTS);
      AddConstant('VALRIGHTS',VALRIGHTS);
      AddConstant('SETRIGHTS',SETRIGHTS);
      AddConstant('ALLFAMRIGHTS',ALLFAMRIGHTS);
      AddConstant('prvNONE',prvNONE);
      AddConstant('prvREADONLY',prvREADONLY);
      AddConstant('prvMODIFY',prvMODIFY);
      AddConstant('prvINSERT',prvINSERT);
      AddConstant('prvINSDEL',prvINSDEL);
      AddConstant('prvFULL',prvFULL);
      AddConstant('prvUNKNOWN',prvUNKNOWN);
      AddConstant('NODEFAULTINDEX',NODEFAULTINDEX);
      AddConstant('TBLLEVEL3',TBLLEVEL3);
      AddConstant('TBLLEVEL4',TBLLEVEL4);
      AddConstant('TBLLEVEL5',TBLLEVEL5);
      AddConstant('TBLLEVEL7',TBLLEVEL7);
      AddConstant('FOXLEVEL25',FOXLEVEL25);
      AddConstant('DBIDELAYUPD_SHOWMODIFYBIT',DBIDELAYUPD_SHOWMODIFYBIT);
      AddConstant('DBIDELAYUPD_SHOWINSERTBIT',DBIDELAYUPD_SHOWINSERTBIT);
      AddConstant('DBIDELAYUPD_SHOWDELETEBIT',DBIDELAYUPD_SHOWDELETEBIT);
      AddConstant('DBIDELAYUPD_SHOWNONMODIFYBIT',DBIDELAYUPD_SHOWNONMODIFYBIT);
      AddConstant('curMAXPROPS',curMAXPROPS);
      AddConstant('curTABLENAME',curTABLENAME);
      AddConstant('curTABLETYPE',curTABLETYPE);
      AddConstant('curTABLELEVEL',curTABLELEVEL);
      AddConstant('curFILENAME',curFILENAME);
      AddConstant('curXLTMODE',curXLTMODE);
      AddConstant('curSEQREADON',curSEQREADON);
      AddConstant('curONEPASSON',curONEPASSON);
      AddConstant('curUPDATETS',curUPDATETS);
      AddConstant('curSOFTDELETEON',curSOFTDELETEON);
      AddConstant('curLANGDRVNAME',curLANGDRVNAME);
      AddConstant('curCURSORNAME',curCURSORNAME);
      AddConstant('curPESSIMISTICLOCKS',curPESSIMISTICLOCKS);
      AddConstant('curEXACTRECCNTEXPENSIVE',curEXACTRECCNTEXPENSIVE);
      AddConstant('curCOMPRESSARRAYFLDDESC',curCOMPRESSARRAYFLDDESC);
      AddConstant('curMAXFIELDID',curMAXFIELDID);
      AddConstant('curFIELDFULLNAME',curFIELDFULLNAME);
      AddConstant('curFIELDTYPENAME',curFIELDTYPENAME);
      AddConstant('curFIELDIDFORNAME',curFIELDIDFORNAME);
      AddConstant('curFIELDIDFORPARENT',curFIELDIDFORPARENT);
      AddConstant('curMAKECRACK',curMAKECRACK);
      AddConstant('curFIELDISAUTOINCR',curFIELDISAUTOINCR);
      AddConstant('curFIELDISDEFAULT',curFIELDISDEFAULT);
      AddConstant('curAUTOREFETCH',curAUTOREFETCH);
      AddConstant('maxcurPROPS',maxcurPROPS);
      AddConstant('curPDXMAXPROPS',curPDXMAXPROPS);
      AddConstant('maxcurPDXPROPS',maxcurPDXPROPS);
      AddConstant('curDBMAXPROPS',curDBMAXPROPS);
      AddConstant('curINEXACTON',curINEXACTON);
      AddConstant('curSHAREMODE',curSHAREMODE);
      AddConstant('maxcurDBPROPS',maxcurDBPROPS);
      AddConstant('curDELIMITALLFLDS',curDELIMITALLFLDS);
      AddConstant('curUSESCHEMAFILE',curUSESCHEMAFILE);
      AddConstant('curUPDLOCKMODE',curUPDLOCKMODE);
      AddConstant('curNATIVEHNDL',curNATIVEHNDL);
      AddConstant('curMAXROWS',curMAXROWS);
      AddConstant('curGETEXTENDEDINFO',curGETEXTENDEDINFO);
      AddConstant('curGETHIDDENCOLUMNS',curGETHIDDENCOLUMNS);
      AddConstant('curAUTOFLUSHREF',curAUTOFLUSHREF);
      AddConstant('curREFINSERTTABLENAME',curREFINSERTTABLENAME);
      AddConstant('curGETREF',curGETREF);
      AddConstant('curCONSTSTATE',curCONSTSTATE);
      AddConstant('curDELAYUPDRECSTATE',curDELAYUPDRECSTATE);
      AddConstant('curDELAYUPDABORTRESTORE',curDELAYUPDABORTRESTORE);
      AddConstant('curDELAYUPDDISPLAYOPT',curDELAYUPDDISPLAYOPT);
      AddConstant('curDELAYUPDGETOLDRECORD',curDELAYUPDGETOLDRECORD);
      AddConstant('curDELAYUPDNUMUPDATES',curDELAYUPDNUMUPDATES);
      AddConstant('curDELAYUPDUSECALLBACK',curDELAYUPDUSECALLBACK);
      AddConstant('drvMAXPROPS',drvMAXPROPS);
      AddConstant('drvDRIVERTYPE',drvDRIVERTYPE);
      AddConstant('drvDRIVERVERSION',drvDRIVERVERSION);
      AddConstant('maxdrvPROPS',maxdrvPROPS);
      AddConstant('drvPSEUDOINDEX',drvPSEUDOINDEX);
      AddConstant('drvNATIVESQLCA',drvNATIVESQLCA);
      AddConstant('dbMAXPROPS',dbMAXPROPS);
      AddConstant('dbDATABASENAME',dbDATABASENAME);
      AddConstant('dbDATABASETYPE',dbDATABASETYPE);
      AddConstant('dbDEFAULTDRIVER',dbDEFAULTDRIVER);
      AddConstant('dbPARAMFMTQMARK',dbPARAMFMTQMARK);
      AddConstant('dbUSESCHEMAFILE',dbUSESCHEMAFILE);
      AddConstant('maxdbPROPS',maxdbPROPS);
      AddConstant('dbASYNCSUPPORT',dbASYNCSUPPORT);
      AddConstant('dbPROCEDURES',dbPROCEDURES);
      AddConstant('dbDEFAULTTXNISO',dbDEFAULTTXNISO);
      AddConstant('dbNATIVEHNDL',dbNATIVEHNDL);
      AddConstant('dbNATIVEPASSTHRUHNDL',dbNATIVEPASSTHRUHNDL);
      AddConstant('dbSERVERVERSION',dbSERVERVERSION);
      AddConstant('dbBATCHCOUNT',dbBATCHCOUNT);
      AddConstant('dbTRACEMODE',dbTRACEMODE);
      AddConstant('dbCURRENTUSERNAME',dbCURRENTUSERNAME);
      AddConstant('dbOWNERQUALIFIED',dbOWNERQUALIFIED);
      AddConstant('dbQUOTECHAR',dbQUOTECHAR);
      AddConstant('dbONLINE',dbONLINE);
      AddConstant('dbTRANALLOWED',dbTRANALLOWED);
      AddConstant('dbANSI',dbANSI);
      AddConstant('dbDBMSNAME',dbDBMSNAME);
      AddConstant('dbBLOBCOUNT',dbBLOBCOUNT);
      AddConstant('dbBLOBSIZE',dbBLOBSIZE);
      AddConstant('dbCOMPRESSARRAYFLDDESC',dbCOMPRESSARRAYFLDDESC);
      AddConstant('dbWAITONLOCK',dbWAITONLOCK);
      AddConstant('dbCOMMITRETAIN',dbCOMMITRETAIN);
      AddConstant('dbSCHEMACACHEENABLED',dbSCHEMACACHEENABLED);
      AddConstant('dbBCDENABLED',dbBCDENABLED);
      AddConstant('sesMAXPROPS',sesMAXPROPS);
      AddConstant('sesSESSIONNAME',sesSESSIONNAME);
      AddConstant('sesNETFILE',sesNETFILE);
      AddConstant('sesCFGMODE',sesCFGMODE);
      AddConstant('sesDEFAULTDRIVER',sesDEFAULTDRIVER);
      AddConstant('sesGROUPNAME',sesGROUPNAME);
      AddConstant('sesUSERNAME',sesUSERNAME);
      AddConstant('sesUSERPASSWORD',sesUSERPASSWORD);
      AddConstant('sesSECFILENAME',sesSECFILENAME);
      AddConstant('sesDRNAME',sesDRNAME);
      AddConstant('sesCFGUPDATE',sesCFGUPDATE);
      AddConstant('sesCFGNAME',sesCFGNAME);
      AddConstant('sesCFGMODE2',sesCFGMODE2);
      AddConstant('sesCFGRefresh',sesCFGRefresh);
      AddConstant('maxsesPROPS',maxsesPROPS);
      AddConstant('sysMAXPROPS',sysMAXPROPS);
      AddConstant('sysLOWMEMUSAGE',sysLOWMEMUSAGE);
      AddConstant('maxsysPROPS',maxsysPROPS);
      AddConstant('stmtMAXPROPS',stmtMAXPROPS);
      AddConstant('stmtPARAMETERCOUNT',stmtPARAMETERCOUNT);
      AddConstant('stmtPARAMETERDESCS',stmtPARAMETERDESCS);
      AddConstant('stmtLANGDRVNAME',stmtLANGDRVNAME);
      AddConstant('stmtUNIDIRECTIONAL',stmtUNIDIRECTIONAL);
      AddConstant('stmtCURSORNAME',stmtCURSORNAME);
      AddConstant('stmtNEWCONNECT',stmtNEWCONNECT);
      AddConstant('stmtNATIVEHNDL',stmtNATIVEHNDL);
      AddConstant('stmtROWCOUNT',stmtROWCOUNT);
      AddConstant('stmtEXECASCURSOR',stmtEXECASCURSOR);
      AddConstant('maxstmtPROPS',maxstmtPROPS);
      AddConstant('stmtANSTYPE',stmtANSTYPE);
      AddConstant('stmtLIVENESS',stmtLIVENESS);
      AddConstant('stmtQRYMODE',stmtQRYMODE);
      AddConstant('stmtBLANKS',stmtBLANKS);
      AddConstant('stmtDATEFORMAT',stmtDATEFORMAT);
      AddConstant('stmtNUMBERFORMAT',stmtNUMBERFORMAT);
      AddConstant('stmtAUXTBLS',stmtAUXTBLS);
      AddConstant('stmtTBLVECTOR',stmtTBLVECTOR);
      AddConstant('stmtALLPROPS',stmtALLPROPS);
      AddConstant('stmtALLPROPSSIZE',stmtALLPROPSSIZE);
      AddConstant('stmtANSNAME',stmtANSNAME);
      AddConstant('stmtCONSTRAINED',stmtCONSTRAINED);
      AddConstant('stmtFIELDDESCS',stmtFIELDDESCS);
      AddConstant('stmtCURPROPS',stmtCURPROPS);
      AddConstant('stmtDEFDBNAME',stmtDEFDBNAME);
      AddConstant('stmtXLTMODE',stmtXLTMODE);
      AddConstant('stmtINSTBLNAME',stmtINSTBLNAME);
      AddConstant('stmtINSERRTBLNAME',stmtINSERRTBLNAME);
      AddConstant('stmtUPDTBLNAME',stmtUPDTBLNAME);
      AddConstant('stmtUPDERRTBLNAME',stmtUPDERRTBLNAME);
      AddConstant('stmtDELTBLNAME',stmtDELTBLNAME);
      AddConstant('stmtDELERRTBLNAME',stmtDELERRTBLNAME);
      AddConstant('stmtCANNEDREADONLY',stmtCANNEDREADONLY);
      AddConstant('CMPLess',CMPLess);
      AddConstant('CMPEql',CMPEql);
      AddConstant('CMPGtr',CMPGtr);
      AddConstant('CMPKeyEql',CMPKeyEql);
      AddConstant('cbYIELDCLIENT',cbYIELDCLIENT);
      AddConstant('traceUNKNOWN',traceUNKNOWN);
      AddConstant('traceQPREPARE',traceQPREPARE);
      AddConstant('traceQEXECUTE',traceQEXECUTE);
      AddConstant('traceERROR',traceERROR);
      AddConstant('traceSTMT',traceSTMT);
      AddConstant('traceCONNECT',traceCONNECT);
      AddConstant('traceTRANSACT',traceTRANSACT);
      AddConstant('traceBLOB',traceBLOB);
      AddConstant('traceMISC',traceMISC);
      AddConstant('traceVENDOR',traceVENDOR);
      AddConstant('traceDATAIN',traceDATAIN);
      AddConstant('traceDATAOUT',traceDATAOUT);
    end;
  end;

  procedure AddConsts2;
  begin
    with Scripter.DefineClass(ClassType) do
    begin
      AddConstant('MAXCBENTRIES',MAXCBENTRIES);
      AddConstant('indTRUNC',indTRUNC);
      AddConstant('indNULL',indNULL);
      AddConstant('indVALUE',indVALUE);
      AddConstant('INDLEN',INDLEN);
      AddConstant('qprepNONE',qprepNONE);
      AddConstant('qprepFORUPDATE',qprepFORUPDATE);
      AddConstant('ecTOKEN',ecTOKEN);
      AddConstant('ecTABLENAME',ecTABLENAME);
      AddConstant('ecFIELDNAME',ecFIELDNAME);
      AddConstant('ecIMAGEROW',ecIMAGEROW);
      AddConstant('ecUSERNAME',ecUSERNAME);
      AddConstant('ecFILENAME',ecFILENAME);
      AddConstant('ecINDEXNAME',ecINDEXNAME);
      AddConstant('ecDIRNAME',ecDIRNAME);
      AddConstant('ecKEYNAME',ecKEYNAME);
      AddConstant('ecALIAS',ecALIAS);
      AddConstant('ecDRIVENAME',ecDRIVENAME);
      AddConstant('ecNATIVECODE',ecNATIVECODE);
      AddConstant('ecNATIVEMSG',ecNATIVEMSG);
      AddConstant('ecLINENUMBER',ecLINENUMBER);
      AddConstant('ecCAPABILITY',ecCAPABILITY);
      AddConstant('ecCDRNAME',ecCDRNAME);
      AddConstant('ecUSERERRMSG',ecUSERERRMSG);
      AddConstant('ecDROBJNAME',ecDROBJNAME);
      AddConstant('ecINTERNALLIMIT',ecINTERNALLIMIT);
      AddConstant('ecEXPRESSION',ecEXPRESSION);
      AddConstant('fnSCALARS_ALLOW_CONSTANTS',fnSCALARS_ALLOW_CONSTANTS);
      AddConstant('fnSCALARS_ALLOW_COLUMNS',fnSCALARS_ALLOW_COLUMNS);
      AddConstant('fnSCALARS_ALLOW_PARAMETERS',fnSCALARS_ALLOW_PARAMETERS);
      AddConstant('fnSCALARS_ALLOW_FUNCTIONS',fnSCALARS_ALLOW_FUNCTIONS);
      AddConstant('fnSCALARS_ALLOW_USER_DEFINED_FUNCS',fnSCALARS_ALLOW_USER_DEFINED_FUNCS);
      AddConstant('fnSCALARS_ALLOW_SUBQUERIES',fnSCALARS_ALLOW_SUBQUERIES);
      AddConstant('fnSCALARS_ALLOW_CORRELATION',fnSCALARS_ALLOW_CORRELATION);
      AddConstant('cfgmNone',cfgmNone);
      AddConstant('cfgmVirtual',cfgmVirtual);
      AddConstant('cfgmPersistent',cfgmPersistent);
      AddConstant('cfgmSession',cfgmSession);
      AddConstant('cfgmAll',cfgmAll);
      AddConstant('DBIOEM_CP',DBIOEM_CP);
      AddConstant('DBIANSI_CP',DBIANSI_CP);
      AddConstant('DBIOS2_CP',DBIOS2_CP);
      AddConstant('DBISUNOS_CP',DBISUNOS_CP);
      AddConstant('DBIVMS_CP',DBIVMS_CP);
      AddConstant('DBIHPUX_CP',DBIHPUX_CP);
      AddConstant('DBIULTRIX_CP',DBIULTRIX_CP);
      AddConstant('DBIAIX_CP',DBIAIX_CP);
      AddConstant('DBIAUX_CP',DBIAUX_CP);
      AddConstant('DBIXENIX_CP',DBIXENIX_CP);
      AddConstant('DBIMAC_CP',DBIMAC_CP);
      AddConstant('DBINEXT_CP',DBINEXT_CP);
      AddConstant('DBIUNICODE_CP',DBIUNICODE_CP);
      AddConstant('DBIROMEN8_CP',DBIROMEN8_CP);
      AddConstant('DBIISO_CP',DBIISO_CP);
      AddConstant('lckRECLOCK',lckRECLOCK);
      AddConstant('lckRRECLOCK',lckRRECLOCK);
      AddConstant('lckGROUPLOCK',lckGROUPLOCK);
      AddConstant('lckIMGAREA',lckIMGAREA);
      AddConstant('lckTABLEREG',lckTABLEREG);
      AddConstant('lckTABLEREAD',lckTABLEREAD);
      AddConstant('lckTABLEWRITE',lckTABLEWRITE);
      AddConstant('lckTABLEEXCL',lckTABLEEXCL);
      AddConstant('lckUNKNOWN',lckUNKNOWN);
      AddConstant('iLangSQL',iLangSQL);
      AddConstant('iDbaseExpr',iDbaseExpr);
      AddConstant('CANEXPRVERSION',CANEXPRVERSION);
      AddConstant('ABORT',ABORT);
      AddConstant('MAXQBEEXPRSIZE',MAXQBEEXPRSIZE);
      AddConstant('DBIQBE_ANSWERBIT',DBIQBE_ANSWERBIT);
      AddConstant('DBIQBE_INSERTEDBIT',DBIQBE_INSERTEDBIT);
      AddConstant('DBIQBE_DELETEDBIT',DBIQBE_DELETEDBIT);
      AddConstant('DBIQBE_CHANGEDBIT',DBIQBE_CHANGEDBIT);
      AddConstant('DBIQBE_ERRORINSBIT',DBIQBE_ERRORINSBIT);
      AddConstant('DBIQBE_ERRORDELBIT',DBIQBE_ERRORDELBIT);
      AddConstant('DBIQBE_ERRORCHGBIT',DBIQBE_ERRORCHGBIT);
      AddConstant('bAnsHasLiveFields',bAnsHasLiveFields);
      AddConstant('bAnsHasFilter',bAnsHasFilter);
      AddConstant('bAnsHasFieldMap',bAnsHasFieldMap);
      AddConstant('bAnsHasCalcField',bAnsHasCalcField);
      AddConstant('bAnsHasLiveBlob',bAnsHasLiveBlob);
      AddConstant('bIsAnsFieldLive',bIsAnsFieldLive);
      AddConstant('DBIMOD_BEGIN',DBIMOD_BEGIN);
      AddConstant('DBIMOD_QBE',DBIMOD_QBE);
      AddConstant('DBIMOD_SQLG',DBIMOD_SQLG);
      AddConstant('DBIMOD_LEGO',DBIMOD_LEGO);
      AddConstant('DBIMOD_LOCKMNGR',DBIMOD_LOCKMNGR);
      AddConstant('DBIMOD_SQLDRIVER',DBIMOD_SQLDRIVER);
      AddConstant('DBIMOD_OS',DBIMOD_OS);
      AddConstant('DBIMOD_DBASEDRV',DBIMOD_DBASEDRV);
      AddConstant('DBIMOD_CDR',DBIMOD_CDR);
      AddConstant('DBIMOD_END',DBIMOD_END);
      AddConstant('DBISYM_BEGIN',DBISYM_BEGIN);
      AddConstant('DBISYM_TOKEN',DBISYM_TOKEN);
      AddConstant('DBISYM_TABLENAME',DBISYM_TABLENAME);
      AddConstant('DBISYM_FIELDNAME',DBISYM_FIELDNAME);
      AddConstant('DBISYM_IMAGEROW',DBISYM_IMAGEROW);
      AddConstant('DBISYM_USERNAME',DBISYM_USERNAME);
      AddConstant('DBISYM_FILENAME',DBISYM_FILENAME);
      AddConstant('DBISYM_INDEXNAME',DBISYM_INDEXNAME);
      AddConstant('DBISYM_DIRNAME',DBISYM_DIRNAME);
      AddConstant('DBISYM_KEYNAME',DBISYM_KEYNAME);
      AddConstant('DBISYM_ALIAS',DBISYM_ALIAS);
      AddConstant('DBISYM_DRIVENAME',DBISYM_DRIVENAME);
      AddConstant('DBISYM_NATIVECODE',DBISYM_NATIVECODE);
      AddConstant('DBISYM_NATIVEMSG',DBISYM_NATIVEMSG);
      AddConstant('DBISYM_LINENUMBER',DBISYM_LINENUMBER);
      AddConstant('DBISYM_CAPABILITY',DBISYM_CAPABILITY);
      AddConstant('DBISYM_CDRNAME',DBISYM_CDRNAME);
      AddConstant('DBISYM_USERERRMSG',DBISYM_USERERRMSG);
      AddConstant('DBISYM_DROBJNAME',DBISYM_DROBJNAME);
      AddConstant('DBISYM_INTERNALLIMIT',DBISYM_INTERNALLIMIT);
      AddConstant('DBISYM_EXPRESSION',DBISYM_EXPRESSION);
      AddConstant('DBISYM_BASEEND',DBISYM_BASEEND);
      AddConstant('DBISYM_MISC',DBISYM_MISC);
      AddConstant('DBISYM_WORK',DBISYM_WORK);
      AddConstant('DBISYM_PRIV',DBISYM_PRIV);
      AddConstant('DBISYM_COPY',DBISYM_COPY);
      AddConstant('DBISYM_APPEND',DBISYM_APPEND);
      AddConstant('DBISYM_TXTPROBFLD1',DBISYM_TXTPROBFLD1);
      AddConstant('DBISYM_TXTPROBFLD2',DBISYM_TXTPROBFLD2);
      AddConstant('DBISYM_TXTPROBFLD3',DBISYM_TXTPROBFLD3);
      AddConstant('DBISYM_END',DBISYM_END);
      AddConstant('RELTYPE',RELTYPE);
      AddConstant('COLTYPE',COLTYPE);
      AddConstant('CONSTYPE',CONSTYPE);
      AddConstant('EXPRTYPE',EXPRTYPE);
      AddConstant('AGGRTYPE',AGGRTYPE);
      AddConstant('CELLTYPE',CELLTYPE);
      AddConstant('REQSELECT',REQSELECT);
      AddConstant('REQSELECTALL',REQSELECTALL);
      AddConstant('REQSELECTDIS',REQSELECTDIS);
      AddConstant('REQSELECTDEC',REQSELECTDEC);
      AddConstant('REQSELECTCOUNT',REQSELECTCOUNT);
      AddConstant('REQDDL',REQDDL);
      AddConstant('REQINSERT',REQINSERT);
      AddConstant('REQUPDATE',REQUPDATE);
      AddConstant('REQDELETE',REQDELETE);
      AddConstant('NAMELENGTH',NAMELENGTH);
      AddConstant('REQVERSION',REQVERSION);
      AddConstant('szCFGSYSTEM',szCFGSYSTEM);
      AddConstant('szCFGDRIVER',szCFGDRIVER);
      AddConstant('szCFGDATABASE',szCFGDATABASE);
      AddConstant('szCFGREPOSITORY',szCFGREPOSITORY);
      AddConstant('szCFGSYSVERSION',szCFGSYSVERSION);
      AddConstant('szCFGSYSNETTYPE',szCFGSYSNETTYPE);
      AddConstant('szCFGSYSNETDIR',szCFGSYSNETDIR);
      AddConstant('szCFGSYSLOCALSHARE',szCFGSYSLOCALSHARE);
      AddConstant('szCFGSYSLANGDRV',szCFGSYSLANGDRV);
      AddConstant('szCFGSYSLANGDRVDIR',szCFGSYSLANGDRVDIR);
      AddConstant('szCFGSYSMINBUF',szCFGSYSMINBUF);
      AddConstant('szCFGSYSMAXBUF',szCFGSYSMAXBUF);
      AddConstant('szCFGSYSLOCKRETRY',szCFGSYSLOCKRETRY);
      AddConstant('szCFGSYSFLAGS',szCFGSYSFLAGS);
      AddConstant('szCFGMAXFILEHANDLES',szCFGMAXFILEHANDLES);
      AddConstant('szCFGSQLQRYMODE',szCFGSQLQRYMODE);
      AddConstant('szCFGLOWMEMLIMIT',szCFGLOWMEMLIMIT);
      AddConstant('szCFGSYSODBCCFGIMPORT',szCFGSYSODBCCFGIMPORT);
      AddConstant('szCFGAUTOODBC',szCFGAUTOODBC);
      AddConstant('szCFGDEFDRV',szCFGDEFDRV);
      AddConstant('szCFGSYSLOCALREPOSITORY',szCFGSYSLOCALREPOSITORY);
      AddConstant('szCFGSYSMEMSIZE',szCFGSYSMEMSIZE);
      AddConstant('szCFGSYSSHAREDMEMSIZE',szCFGSYSSHAREDMEMSIZE);
      AddConstant('szCFGSYSSHAREDMEMLOCATION',szCFGSYSSHAREDMEMLOCATION);
      AddConstant('szCFGSYSMTSPOOLING',szCFGSYSMTSPOOLING);
      AddConstant('szCFGDRVVERSION',szCFGDRVVERSION);
      AddConstant('szCFGDRVTYPE',szCFGDRVTYPE);
      AddConstant('szCFGDRVDLL',szCFGDRVDLL);
      AddConstant('szCFGDRVDLL32',szCFGDRVDLL32);
      AddConstant('szCFGDRVFLAGS',szCFGDRVFLAGS);
      AddConstant('szCFGDRVLANGDRIVER',szCFGDRVLANGDRIVER);
      AddConstant('szCFGDRVFILLFACTOR',szCFGDRVFILLFACTOR);
      AddConstant('szCFGDRVBLOCKSIZE',szCFGDRVBLOCKSIZE);
      AddConstant('szCFGDRVLOCKPROTOCOL',szCFGDRVLOCKPROTOCOL);
      AddConstant('szCFGDRVLEVEL',szCFGDRVLEVEL);
      AddConstant('szCFGDRVVENDINIT',szCFGDRVVENDINIT);
      AddConstant('szCFGDRVTRACEMODE',szCFGDRVTRACEMODE);
      AddConstant('szCFGDRVMEMOBLOCKSIZE',szCFGDRVMEMOBLOCKSIZE);
      AddConstant('szCFGDRVMDXBLOCKSIZE',szCFGDRVMDXBLOCKSIZE);
      AddConstant('szCFGDRVINIT',szCFGDRVINIT);
      AddConstant('szCFGDBCREATE',szCFGDBCREATE);
      AddConstant('szCFGDBOPEN',szCFGDBOPEN);
      AddConstant('szCFGTBLCREATE',szCFGTBLCREATE);
      AddConstant('szCFGTBLOPEN',szCFGTBLOPEN);
      AddConstant('szCFGDBINFO',szCFGDBINFO);
      AddConstant('szCFGDBTYPE',szCFGDBTYPE);
      AddConstant('szCFGDBPATH',szCFGDBPATH);
      AddConstant('szCFGDBDEFAULTDRIVER',szCFGDBDEFAULTDRIVER);
      AddConstant('szCFGDBENABLEBCD',szCFGDBENABLEBCD);
      AddConstant('szCFGINIT',szCFGINIT);
      AddConstant('szTYPe',szTYPe);
      AddConstant('szCFGDBSTANDARD',szCFGDBSTANDARD);
      AddConstant('szCFGTRUE',szCFGTRUE);
      AddConstant('szCFGFALSE',szCFGFALSE);
      AddConstant('szOPENMODE',szOPENMODE);
      AddConstant('szREADWRITE',szREADWRITE);
      AddConstant('szREADONLy',szREADONLy);
      AddConstant('szSHAREMODE',szSHAREMODE);
      AddConstant('szEXCLUSIVE',szEXCLUSIVE);
      AddConstant('szSHARED',szSHARED);
      AddConstant('szUSERNAME',szUSERNAME);
      AddConstant('szPASSWORD',szPASSWORD);
      AddConstant('szSERVERNAME',szSERVERNAME);
      AddConstant('szDATABASENAME',szDATABASENAME);
      AddConstant('szSCHEMASIZE',szSCHEMASIZE);
      AddConstant('szCFGSTRICTINTEGRITY',szCFGSTRICTINTEGRITY);
      AddConstant('szSQLPASSMODE',szSQLPASSMODE);
      AddConstant('szNOTSHARED',szNOTSHARED);
      AddConstant('szSHAREDAUTOCOMMIT',szSHAREDAUTOCOMMIT);
      AddConstant('szSHAREDNOAUTOCOMMIT',szSHAREDNOAUTOCOMMIT);
      AddConstant('szSCHEMATIME',szSCHEMATIME);
      AddConstant('szMAXQUERYTIME',szMAXQUERYTIME);
      AddConstant('szMAXROWS',szMAXROWS);
      AddConstant('szLISTSYNONYMS',szLISTSYNONYMS);
      AddConstant('szSYNNONE',szSYNNONE);
      AddConstant('szSYNALL',szSYNALL);
      AddConstant('szSYNPRIVATE',szSYNPRIVATE);
      AddConstant('szBATCHCOUNT',szBATCHCOUNT);
      AddConstant('szBLOBCOUNT',szBLOBCOUNT);
      AddConstant('szBLOBSIZE',szBLOBSIZE);
      AddConstant('szOBJECTMODE',szOBJECTMODE);
      AddConstant('szENABLESCHEMACACHE',szENABLESCHEMACACHE);
      AddConstant('szSCHEMACACHEDIR',szSCHEMACACHEDIR);
      AddConstant('szSYBLHOST',szSYBLHOST);
      AddConstant('szSYBLAPP',szSYBLAPP);
      AddConstant('szSYBLNATLANG',szSYBLNATLANG);
      AddConstant('szTDSPACKETSIZE',szTDSPACKETSIZE);
      AddConstant('szORAINTEGER',szORAINTEGER);
      AddConstant('szDBNLS',szDBNLS);
      AddConstant('szCOLLCHAR',szCOLLCHAR);
      AddConstant('szROWSETSIZE',szROWSETSIZE);
      AddConstant('szCFG30',szCFG30);
      AddConstant('szCFGSERVER',szCFGSERVER);
      AddConstant('szCFGIDODBC01',szCFGIDODBC01);
      AddConstant('szCFGIDODBC32',szCFGIDODBC32);
      AddConstant('szCFGODBCDRIVER',szCFGODBCDRIVER);
      AddConstant('szCFGNULL',szCFGNULL);
      AddConstant('szCFGZERO',szCFGZERO);
      AddConstant('szCFG20',szCFG20);
      AddConstant('szCFG64',szCFG64);
      AddConstant('szCFG32',szCFG32);
      AddConstant('szCFGODBCDSN',szCFGODBCDSN);
      AddConstant('szCFGTWOHUNDRED',szCFGTWOHUNDRED);
      AddConstant('szCFGNEGONE',szCFGNEGONE);
      AddConstant('szCFGEIGHT',szCFGEIGHT);
      AddConstant('szCLSID',szCLSID);
      AddConstant('szCFGSYSTEMDB',szCFGSYSTEMDB);
      AddConstant('szCFGOLEDBPROVIDER',szCFGOLEDBPROVIDER);
      AddConstant('szCFGPERSISTFILE',szCFGPERSISTFILE);
      AddConstant('szCFGOBJECTMODE',szCFGOBJECTMODE);
      AddConstant('szCFGDRDBNAME',szCFGDRDBNAME);
      AddConstant('szCFGDRTBLNAME',szCFGDRTBLNAME);
      AddConstant('szCFGDRLANGDRIVER',szCFGDRLANGDRIVER);
      AddConstant('szCFGDRDESC',szCFGDRDESC);
      AddConstant('szCFGFORMAT',szCFGFORMAT);
      AddConstant('szCFGDATE',szCFGDATE);
      AddConstant('szCFGTIME',szCFGTIME);
      AddConstant('szCFGNUMBER',szCFGNUMBER);
      AddConstant('szCFGSEPARATOR',szCFGSEPARATOR);
      AddConstant('szCFGMODE',szCFGMODE);
      AddConstant('szCFGFOURDIGITYEAR',szCFGFOURDIGITYEAR);
      AddConstant('szCFGYEARBIASED',szCFGYEARBIASED);
      AddConstant('szCFGLEADINGZEROM',szCFGLEADINGZEROM);
      AddConstant('szCFGLEADINGZEROD',szCFGLEADINGZEROD);
      AddConstant('szCFGTWELVEHOUR',szCFGTWELVEHOUR);
      AddConstant('szCFGAMSTRING',szCFGAMSTRING);
      AddConstant('szCFGPMSTRING',szCFGPMSTRING);
      AddConstant('szCFGSECONDS',szCFGSECONDS);
      AddConstant('szCFGMILSECONDS',szCFGMILSECONDS);
      AddConstant('szCFGDECIMALSEPARATOR',szCFGDECIMALSEPARATOR);
      AddConstant('szCFGTHOUSANDSEPARATOR',szCFGTHOUSANDSEPARATOR);
      AddConstant('szCFGDECIMALDIGITS',szCFGDECIMALDIGITS);
      AddConstant('szCFGLEADINGZERON',szCFGLEADINGZERON);
      AddConstant('DBICFG_BASE',DBICFG_BASE);
      AddConstant('iCFGSYSTEM',iCFGSYSTEM);
      AddConstant('iCFGDRIVER',iCFGDRIVER);
      AddConstant('iCFGDATABASE',iCFGDATABASE);
      AddConstant('iCFGREPOSITORY',iCFGREPOSITORY);
      AddConstant('iCFGSYSVERSION',iCFGSYSVERSION);
      AddConstant('iCFGSYSNETTYPE',iCFGSYSNETTYPE);
      AddConstant('iCFGSYSNETDIR',iCFGSYSNETDIR);
      AddConstant('iCFGSYSLOCALSHARE',iCFGSYSLOCALSHARE);
      AddConstant('iCFGSYSLANGDRV',iCFGSYSLANGDRV);
      AddConstant('iCFGSYSLANGDRVDIR',iCFGSYSLANGDRVDIR);
      AddConstant('iCFGSYSMINBUF',iCFGSYSMINBUF);
      AddConstant('iCFGSYSMAXBUF',iCFGSYSMAXBUF);
      AddConstant('iCFGSYSLOCKRETRY',iCFGSYSLOCKRETRY);
      AddConstant('iCFGSYSFLAGS',iCFGSYSFLAGS);
      AddConstant('iCFGMAXFILEHANDLES',iCFGMAXFILEHANDLES);
      AddConstant('iCFGSQLQRYMODE',iCFGSQLQRYMODE);
      AddConstant('iCFGLOWMEMLIMIT',iCFGLOWMEMLIMIT);
      AddConstant('iCFGSYSODBCCFGIMPORT',iCFGSYSODBCCFGIMPORT);
      AddConstant('iCFGSYSLOCALREPOSITORY',iCFGSYSLOCALREPOSITORY);
      AddConstant('iCFGSYSSHAREDMEMSIZE',iCFGSYSSHAREDMEMSIZE);
      AddConstant('iCFGSYSSHAREDMEMLOCATION',iCFGSYSSHAREDMEMLOCATION);
      AddConstant('iCFGSYSMEMSIZE',iCFGSYSMEMSIZE);
      AddConstant('iCFGDRVVERSION',iCFGDRVVERSION);
      AddConstant('iCFGDRVTYPE',iCFGDRVTYPE);
      AddConstant('iCFGDRVLANGDRIVER',iCFGDRVLANGDRIVER);
      AddConstant('iCFGDRVFILLFACTOR',iCFGDRVFILLFACTOR);
      AddConstant('iCFGDRVBLOCKSIZE',iCFGDRVBLOCKSIZE);
      AddConstant('iCFGDRVLOCKPROTOCOL',iCFGDRVLOCKPROTOCOL);
      AddConstant('iCFGDRVLEVEL',iCFGDRVLEVEL);
      AddConstant('iCFGDRVFLAGS',iCFGDRVFLAGS);
      AddConstant('iCFGDRVTRACEMODE',iCFGDRVTRACEMODE);
      AddConstant('iCFGDRVDLL32',iCFGDRVDLL32);
      AddConstant('iCFGDRVMEMOBLOCKSIZE',iCFGDRVMEMOBLOCKSIZE);
      AddConstant('iCFGDRVMDXBLOCKSIZE',iCFGDRVMDXBLOCKSIZE);
      AddConstant('iCFGDRVINIT',iCFGDRVINIT);
      AddConstant('iCFGDBCREATE',iCFGDBCREATE);
      AddConstant('iCFGDBOPEN',iCFGDBOPEN);
      AddConstant('iCFGTBLCREATE',iCFGTBLCREATE);
      AddConstant('iCFGTBLOPEN',iCFGTBLOPEN);
      AddConstant('iCFGDBINFO',iCFGDBINFO);
      AddConstant('iCFGDBTYPE',iCFGDBTYPE);
      AddConstant('iCFGDBPATH',iCFGDBPATH);
      AddConstant('iCFGDBDEFAULTDRIVER',iCFGDBDEFAULTDRIVER);
      AddConstant('iCFGDBENABLEBCD',iCFGDBENABLEBCD);
      AddConstant('iCFGINIT',iCFGINIT);
      AddConstant('iTYPE',iTYPE);
      AddConstant('iCFGDBSTANDARD',iCFGDBSTANDARD);
      AddConstant('iCFGTRUE',iCFGTRUE);
      AddConstant('iCFGFALSE',iCFGFALSE);
      AddConstant('iOPENMODE',iOPENMODE);
      AddConstant('iREADWRITE',iREADWRITE);
      AddConstant('iREADONLY',iREADONLY);
      AddConstant('iSHAREMODE',iSHAREMODE);
      AddConstant('iEXCLUSIVE',iEXCLUSIVE);
      AddConstant('iSHARED',iSHARED);
      AddConstant('iUSERNAME',iUSERNAME);
      AddConstant('iSERVERNAME',iSERVERNAME);
      AddConstant('iDATABASENAME',iDATABASENAME);
      AddConstant('iSCHEMASIZE',iSCHEMASIZE);
      AddConstant('iCFGSTRICTINTEGRITY',iCFGSTRICTINTEGRITY);
      AddConstant('iTDSPACKETSIZE',iTDSPACKETSIZE);
      AddConstant('iORAINTEGER',iORAINTEGER);
      AddConstant('iDBNLS',iDBNLS);
      AddConstant('iCOLLCHAR',iCOLLCHAR);
      AddConstant('iROWSETSIZE',iROWSETSIZE);
      AddConstant('iCFGOBJECTMODE',iCFGOBJECTMODE);
      AddConstant('iCFGDRDBNAME',iCFGDRDBNAME);
      AddConstant('iCFGDRTBLNAME',iCFGDRTBLNAME);
      AddConstant('iCFGDRDESC',iCFGDRDESC);
      AddConstant('iCFGDRLANGDRIVER',iCFGDRLANGDRIVER);
      AddConstant('iCFGFORMAT',iCFGFORMAT);
      AddConstant('iCFGDATE',iCFGDATE);
      AddConstant('iCFGTIME',iCFGTIME);
      AddConstant('iCFGNUMBER',iCFGNUMBER);
      AddConstant('iCFGSEPARATOR',iCFGSEPARATOR);
      AddConstant('iCFGMODE',iCFGMODE);
      AddConstant('iCFGFOURDIGITYEAR',iCFGFOURDIGITYEAR);
      AddConstant('iCFGYEARBIASED',iCFGYEARBIASED);
      AddConstant('iCFGLEADINGZEROM',iCFGLEADINGZEROM);
      AddConstant('iCFGLEADINGZEROD',iCFGLEADINGZEROD);
      AddConstant('iCFGTWELVEHOUR',iCFGTWELVEHOUR);
      AddConstant('iCFGAMSTRING',iCFGAMSTRING);
      AddConstant('iCFGPMSTRING',iCFGPMSTRING);
      AddConstant('iCFGSECONDS',iCFGSECONDS);
      AddConstant('iCFGMILSECONDS',iCFGMILSECONDS);
      AddConstant('iCFGDECIMALSEPARATOR',iCFGDECIMALSEPARATOR);
      AddConstant('iCFGTHOUSANDSEPARATOR',iCFGTHOUSANDSEPARATOR);
      AddConstant('iCFGDECIMALDIGITS',iCFGDECIMALDIGITS);
      AddConstant('iCFGLEADINGZERON',iCFGLEADINGZERON);
      AddConstant('iCFGDEFLANGDRV',iCFGDEFLANGDRV);
      AddConstant('iCFGDBASEDEFLANGDRV',iCFGDBASEDEFLANGDRV);
      AddConstant('iCFGDEFSEPARATOR',iCFGDEFSEPARATOR);
      AddConstant('iCFGDEFMODE',iCFGDEFMODE);
      AddConstant('iCFGDEFFOURDIGITYEAR',iCFGDEFFOURDIGITYEAR);
      AddConstant('iCFGDEFYEARBIASED',iCFGDEFYEARBIASED);
      AddConstant('iCFGDEFLEADINGZEROM',iCFGDEFLEADINGZEROM);
      AddConstant('iCFGDEFLEADINGZEROD',iCFGDEFLEADINGZEROD);
      AddConstant('iCFGDEFTWELVEHOUR',iCFGDEFTWELVEHOUR);
      AddConstant('iCFGDEFAMSTRING',iCFGDEFAMSTRING);
      AddConstant('iCFGDEFPMSTRING',iCFGDEFPMSTRING);
      AddConstant('iCFGDEFSECONDS',iCFGDEFSECONDS);
      AddConstant('iCFGDEFMILSECONDS',iCFGDEFMILSECONDS);
      AddConstant('iCFGDEFDECIMALSEPARATOR',iCFGDEFDECIMALSEPARATOR);
      AddConstant('iCFGDEFTHOUSANDSEPARATOR',iCFGDEFTHOUSANDSEPARATOR);
      AddConstant('iCFGDEFLEADINGZERO',iCFGDEFLEADINGZERO);
      AddConstant('iCFGDEFVERSION',iCFGDEFVERSION);
      AddConstant('iCFGDEFLOCALSHARE',iCFGDEFLOCALSHARE);
      AddConstant('iCFGDEFMINBUFSIZE',iCFGDEFMINBUFSIZE);
      AddConstant('iCFGDEFMAXBUFSIZE',iCFGDEFMAXBUFSIZE);
      AddConstant('iCFGDEFMAXFILEHANDLES',iCFGDEFMAXFILEHANDLES);
      AddConstant('iCFGDEFSYSFLAGS',iCFGDEFSYSFLAGS);
      AddConstant('iCFGDEFLOWMEM',iCFGDEFLOWMEM);
      AddConstant('iCFGDEFAUTOODBC',iCFGDEFAUTOODBC);
      AddConstant('iCFGDEFDEFDRV',iCFGDEFDEFDRV);
      AddConstant('iCFGDEFDECIMALDIGITS',iCFGDEFDECIMALDIGITS);
      AddConstant('iCFGDEFLEADINGZERON',iCFGDEFLEADINGZERON);
      AddConstant('iCFGDEFPDXTYPE',iCFGDEFPDXTYPE);
      AddConstant('iCFGDEFPDXNETDIR',iCFGDEFPDXNETDIR);
      AddConstant('iCFGDEFPDXLANGDRV',iCFGDEFPDXLANGDRV);
      AddConstant('iCFGDEFPDXLEVEL',iCFGDEFPDXLEVEL);
      AddConstant('iCFGDEFPDXBLOCKSIZE',iCFGDEFPDXBLOCKSIZE);
      AddConstant('iCFGDEFPDXFILLFACTOR',iCFGDEFPDXFILLFACTOR);
      AddConstant('iCFGDEFPDXSTRICTINTEGRTY',iCFGDEFPDXSTRICTINTEGRTY);
      AddConstant('iCFGDEFDBASETYPE',iCFGDEFDBASETYPE);
      AddConstant('iCFGDEFDBASELANGDRV',iCFGDEFDBASELANGDRV);
      AddConstant('iCFGDEFDBASELEVEL',iCFGDEFDBASELEVEL);
      AddConstant('iCFGDEFDBASEMDXBLOCKSIZE',iCFGDEFDBASEMDXBLOCKSIZE);
      AddConstant('iCFGDEFDBASEMEMOBLOCKSIZE',iCFGDEFDBASEMEMOBLOCKSIZE);
      AddConstant('iCFGAUTOODBC',iCFGAUTOODBC);
      AddConstant('iCFGDEFDRV',iCFGDEFDRV);
      AddConstant('iCFGENABLEBCD',iCFGENABLEBCD);
      AddConstant('iCFGDEFSHAREDMEMSIZE',iCFGDEFSHAREDMEMSIZE);
      AddConstant('iCFGDEFSHAREDMEMLOCATION',iCFGDEFSHAREDMEMLOCATION);
      AddConstant('iCFGDEFREPOSITORY',iCFGDEFREPOSITORY);
      AddConstant('iCFGDEFSQLQRYMODE',iCFGDEFSQLQRYMODE);
      AddConstant('iCFGDEFMEMSIZE',iCFGDEFMEMSIZE);
      AddConstant('iCFGDEFMSACCESSVER',iCFGDEFMSACCESSVER);
      AddConstant('iCFGDEFMSACCESSTYPE',iCFGDEFMSACCESSTYPE);
      AddConstant('iCFGDEFMSACCESSDLL32',iCFGDEFMSACCESSDLL32);
      AddConstant('iCFGDEFMSACCESSLANGDRV',iCFGDEFMSACCESSLANGDRV);
      AddConstant('iCFGDEFDATABASENAME',iCFGDEFDATABASENAME);
      AddConstant('iCFGDEFUSERNAME',iCFGDEFUSERNAME);
      AddConstant('iCFGDEFTRACEMODE',iCFGDEFTRACEMODE);
      AddConstant('iCFGDEFDRVFLAGS',iCFGDEFDRVFLAGS);
      AddConstant('iCFGCFGSYSTEMDB',iCFGCFGSYSTEMDB);
      AddConstant('iCFGDEFFOXPROTYPE',iCFGDEFFOXPROTYPE);
      AddConstant('iCFGDEFFOXPROLANGDRV',iCFGDEFFOXPROLANGDRV);
      AddConstant('iCFGDEFFOXPROLEVEL',iCFGDEFFOXPROLEVEL);
      AddConstant('CFGHLP_BASE',CFGHLP_BASE);
      AddConstant('iCFGHLP_SYSNODE',iCFGHLP_SYSNODE);
      AddConstant('iCFGHLP_SYSINITNODE',iCFGHLP_SYSINITNODE);
      AddConstant('iCFGHLP_SYSVERSION',iCFGHLP_SYSVERSION);
      AddConstant('iCFGHLP_SYSLOCALSHARE',iCFGHLP_SYSLOCALSHARE);
      AddConstant('iCFGHLP_SYSMINBUFSIZE',iCFGHLP_SYSMINBUFSIZE);
      AddConstant('iCFGHLP_SYSMAXBUFSIZE',iCFGHLP_SYSMAXBUFSIZE);
      AddConstant('iCFGHLP_SYSLANGDRIVER',iCFGHLP_SYSLANGDRIVER);
      AddConstant('iCFGHLP_SYSNETTYPE',iCFGHLP_SYSNETTYPE);
      AddConstant('iCFGHLP_SYSFLAGS',iCFGHLP_SYSFLAGS);
      AddConstant('iCFGHLP_SYSMAXFILE',iCFGHLP_SYSMAXFILE);
      AddConstant('iCFGHLP_SYSLOWMEM',iCFGHLP_SYSLOWMEM);
      AddConstant('iCFGHLP_SYSAUTOODBC',iCFGHLP_SYSAUTOODBC);
      AddConstant('iCFGHLP_SYSDEFDRV',iCFGHLP_SYSDEFDRV);
      AddConstant('iCFGHLP_SYSSQLQRYMODE',iCFGHLP_SYSSQLQRYMODE);
      AddConstant('iCFGHLP_SYSSQLPASSTHRU',iCFGHLP_SYSSQLPASSTHRU);
      AddConstant('iCFGHLP_SYSFORMATNODE',iCFGHLP_SYSFORMATNODE);
      AddConstant('iCFGHLP_DATENODE',iCFGHLP_DATENODE);
      AddConstant('iCFGHLP_DATESEPARATOR',iCFGHLP_DATESEPARATOR);
      AddConstant('iCFGHLP_DATEMODE',iCFGHLP_DATEMODE);
      AddConstant('iCFGHLP_DATEFOURDIGIT',iCFGHLP_DATEFOURDIGIT);
      AddConstant('iCFGHLP_DATEYEARBIASED',iCFGHLP_DATEYEARBIASED);
      AddConstant('iCFGHLP_DATEZEROM',iCFGHLP_DATEZEROM);
      AddConstant('iCFGHLP_DATEZEROD',iCFGHLP_DATEZEROD);
      AddConstant('iCFGHLP_TIMENODE',iCFGHLP_TIMENODE);
      AddConstant('iCFGHLP_TIMETWELVEHOUR',iCFGHLP_TIMETWELVEHOUR);
      AddConstant('iCFGHLP_TIMEAMSTRING',iCFGHLP_TIMEAMSTRING);
      AddConstant('iCFGHLP_TIMEPMSTRING',iCFGHLP_TIMEPMSTRING);
      AddConstant('iCFGHLP_TIMESECONDS',iCFGHLP_TIMESECONDS);
      AddConstant('iCFGHLP_TIMEMILSEC',iCFGHLP_TIMEMILSEC);
      AddConstant('iCFGHLP_NUMNODE',iCFGHLP_NUMNODE);
      AddConstant('iCFGHLP_NUMDECIMALSEPARATOR',iCFGHLP_NUMDECIMALSEPARATOR);
      AddConstant('iCFGHLP_NUMTHOUSANDSEPARATOR',iCFGHLP_NUMTHOUSANDSEPARATOR);
      AddConstant('iCFGHLP_NUMDECIMALDIGITS',iCFGHLP_NUMDECIMALDIGITS);
      AddConstant('iCFGHLP_NUMZERON',iCFGHLP_NUMZERON);
      AddConstant('iCFGHLP_DRVNODE',iCFGHLP_DRVNODE);
      AddConstant('iCFGHLP_PDXNODE',iCFGHLP_PDXNODE);
      AddConstant('iCFGHLP_PDXINITNODE',iCFGHLP_PDXINITNODE);
      AddConstant('iCFGHLP_DRVTYPE',iCFGHLP_DRVTYPE);
      AddConstant('iCFGHLP_PDXNETDIR',iCFGHLP_PDXNETDIR);
      AddConstant('iCFGHLP_PDXTBLNODE',iCFGHLP_PDXTBLNODE);
      AddConstant('iCFGHLP_PDXLEVEL',iCFGHLP_PDXLEVEL);
      AddConstant('iCFGHLP_PDXBLOCKSIZE',iCFGHLP_PDXBLOCKSIZE);
      AddConstant('iCFGHLP_PDXFILLFACTOR',iCFGHLP_PDXFILLFACTOR);
      AddConstant('iCFGHLP_PDXSTRICT',iCFGHLP_PDXSTRICT);
      AddConstant('iCFGHLP_DBNODE',iCFGHLP_DBNODE);
      AddConstant('iCFGHLP_DBINITNODE',iCFGHLP_DBINITNODE);
      AddConstant('iCFGHLP_DBVERSION',iCFGHLP_DBVERSION);
      AddConstant('iCFGHLP_DBTBLNODE',iCFGHLP_DBTBLNODE);
      AddConstant('iCFGHLP_DBLEVEL',iCFGHLP_DBLEVEL);
      AddConstant('iCFGHLP_DBMDXBLOCKSIZE',iCFGHLP_DBMDXBLOCKSIZE);
      AddConstant('iCFGHLP_DBMEMOFILEBLOCKSIZE',iCFGHLP_DBMEMOFILEBLOCKSIZE);
      AddConstant('iCFGHLP_INTNODE',iCFGHLP_INTNODE);
      AddConstant('iCFGHLP_INTINITNODE',iCFGHLP_INTINITNODE);
      AddConstant('iCFGHLP_INTVERSION',iCFGHLP_INTVERSION);
      AddConstant('iCFGHLP_SQLDLL',iCFGHLP_SQLDLL);
      AddConstant('iCFGHLP_SQLDLL32',iCFGHLP_SQLDLL32);
      AddConstant('iCFGHLP_SQLDRIVERFLAGS',iCFGHLP_SQLDRIVERFLAGS);
      AddConstant('iCFGHLP_INTDBNODE',iCFGHLP_INTDBNODE);
      AddConstant('iCFGHLP_SQLSERVER',iCFGHLP_SQLSERVER);
      AddConstant('iCFGHLP_SQLUSER',iCFGHLP_SQLUSER);
      AddConstant('iCFGHLP_SQLOPENMODE',iCFGHLP_SQLOPENMODE);
      AddConstant('iCFGHLP_SQLSCHEMASIZE',iCFGHLP_SQLSCHEMASIZE);
      AddConstant('iCFGHLP_SQLSCHEMATIME',iCFGHLP_SQLSCHEMATIME);
      AddConstant('iCFGHLP_SYBNODE',iCFGHLP_SYBNODE);
      AddConstant('iCFGHLP_SYBINITNODE',iCFGHLP_SYBINITNODE);
      AddConstant('iCFGHLP_SYBVERSION',iCFGHLP_SYBVERSION);
      AddConstant('iCFGHLP_SQLCONNECT',iCFGHLP_SQLCONNECT);
      AddConstant('iCFGHLP_SQLTIMEOUT',iCFGHLP_SQLTIMEOUT);
      AddConstant('iCFGHLP_SYBDBNODE',iCFGHLP_SYBDBNODE);
      AddConstant('iCFGHLP_SQLDATABASE',iCFGHLP_SQLDATABASE);
      AddConstant('iCFGHLP_SQLBLOBEDIT',iCFGHLP_SQLBLOBEDIT);
      AddConstant('iCFGHLP_SQLMAXQUERY',iCFGHLP_SQLMAXQUERY);
      AddConstant('iCFGHLP_ORANODE',iCFGHLP_ORANODE);
      AddConstant('iCFGHLP_ORAINITNODE',iCFGHLP_ORAINITNODE);
      AddConstant('iCFGHLP_ORAVERSION',iCFGHLP_ORAVERSION);
      AddConstant('iCFGHLP_SQLVENDOR',iCFGHLP_SQLVENDOR);
      AddConstant('iCFGHLP_ORADBNODE',iCFGHLP_ORADBNODE);
      AddConstant('iCFGHLP_SQLNETPROTOCOL',iCFGHLP_SQLNETPROTOCOL);
      AddConstant('iCFGHLP_MSSNODE',iCFGHLP_MSSNODE);
      AddConstant('iCFGHLP_MSSINITNODE',iCFGHLP_MSSINITNODE);
      AddConstant('iCFGHLP_MSSVERSION',iCFGHLP_MSSVERSION);
      AddConstant('iCFGHLP_MSSDBNODE',iCFGHLP_MSSDBNODE);
      AddConstant('iCFGHLP_INFNODE',iCFGHLP_INFNODE);
      AddConstant('iCFGHLP_INFINITNODE',iCFGHLP_INFINITNODE);
      AddConstant('iCFGHLP_INFVERSION',iCFGHLP_INFVERSION);
      AddConstant('iCFGHLP_INFDBNODE',iCFGHLP_INFDBNODE);
      AddConstant('iCFGHLP_SQLLOCKMODE',iCFGHLP_SQLLOCKMODE);
      AddConstant('iCFGHLP_SQLTRACEMODE',iCFGHLP_SQLTRACEMODE);
      AddConstant('iCFGHLP_SQLMAXROWS',iCFGHLP_SQLMAXROWS);
      AddConstant('iCFGHLP_SQLBATCHCOUNT',iCFGHLP_SQLBATCHCOUNT);
      AddConstant('iCFGHLP_SYSSHAREDMEMSIZ',iCFGHLP_SYSSHAREDMEMSIZ);
      AddConstant('iCFGHLP_SYSSHAREDMEMLOC',iCFGHLP_SYSSHAREDMEMLOC);
      AddConstant('iCFGHLP_SYSDATAREP',iCFGHLP_SYSDATAREP);
      AddConstant('iCFGHLP_ALIASTYPE',iCFGHLP_ALIASTYPE);
      AddConstant('iCFGHLP_ALIASPATH',iCFGHLP_ALIASPATH);
      AddConstant('iCFGHLP_ALIASDEFDRV',iCFGHLP_ALIASDEFDRV);
      AddConstant('iCFGHLP_ENABLESCHEMACACHE',iCFGHLP_ENABLESCHEMACACHE);
      AddConstant('iCFGHLP_SCHEMACACHEDIR',iCFGHLP_SCHEMACACHEDIR);
      AddConstant('iCFGHLP_HOSTNAME',iCFGHLP_HOSTNAME);
      AddConstant('iCFGHLP_APPLICATIONNAME',iCFGHLP_APPLICATIONNAME);
      AddConstant('iCFGHLP_NATIONALLANGNAME',iCFGHLP_NATIONALLANGNAME);
      AddConstant('iCFGHLP_ALIASENABLEBCD',iCFGHLP_ALIASENABLEBCD);
      AddConstant('iCFGHLP_TDSPACKETSIZE',iCFGHLP_TDSPACKETSIZE);
      AddConstant('iCFGHLP_ORAINTEGER',iCFGHLP_ORAINTEGER);
      AddConstant('iCFGHLP_ORALISTSYNONYMS',iCFGHLP_ORALISTSYNONYMS);
      AddConstant('iCFGHLP_ROWSETSIZE',iCFGHLP_ROWSETSIZE);
      AddConstant('iCFGHLP_DB2DRIVER',iCFGHLP_DB2DRIVER);
      AddConstant('iCFGHLP_DB2DSN',iCFGHLP_DB2DSN);
      AddConstant('iCFGHLP_DB2NODE',iCFGHLP_DB2NODE);
      AddConstant('iCFGHLP_DB2INITNODE',iCFGHLP_DB2INITNODE);
      AddConstant('iCFGHLP_DB2VERSION',iCFGHLP_DB2VERSION);
      AddConstant('iCFGHLP_DB2DBNODE',iCFGHLP_DB2DBNODE);
      AddConstant('iCFGHLP_COLLCHAR',iCFGHLP_COLLCHAR);
      AddConstant('iCFGHLP_DBNLS',iCFGHLP_DBNLS);
      AddConstant('iCFGHLP_MSACCNODE',iCFGHLP_MSACCNODE);
      AddConstant('iCFGHLP_MSACCINITNODE',iCFGHLP_MSACCINITNODE);
      AddConstant('iCFGHLP_MSACCVERSION',iCFGHLP_MSACCVERSION);
      AddConstant('iCFGHLP_MSACCDBNODE',iCFGHLP_MSACCDBNODE);
      AddConstant('iCFGHLP_ODBCDRIVER',iCFGHLP_ODBCDRIVER);
      AddConstant('iCFGHLP_ODBCVERSION',iCFGHLP_ODBCVERSION);
      AddConstant('iCFGHLP_ODBCDSN',iCFGHLP_ODBCDSN);
      AddConstant('iCFGHLP_OLEVERSION',iCFGHLP_OLEVERSION);
      AddConstant('iCFGHLP_OLECLSID',iCFGHLP_OLECLSID);
      AddConstant('iCFGHLP_BLOBSTOCACHE',iCFGHLP_BLOBSTOCACHE);
      AddConstant('iCFGHLP_BLOBSIZE',iCFGHLP_BLOBSIZE);
      AddConstant('iCFGHLP_SYSMEMSIZE',iCFGHLP_SYSMEMSIZE);
      AddConstant('iCFGHLP_MAXDBPROCS',iCFGHLP_MAXDBPROCS);
      AddConstant('iCFGHLP_FPNODE',iCFGHLP_FPNODE);
      AddConstant('iCFGHLP_FPINITNODE',iCFGHLP_FPINITNODE);
      AddConstant('iCFGHLP_FPVERSION',iCFGHLP_FPVERSION);
      AddConstant('iCFGHLP_FPTBLNODE',iCFGHLP_FPTBLNODE);
      AddConstant('iCFGHLP_FPLEVEL',iCFGHLP_FPLEVEL);
      AddConstant('iCFGHLP_FPMEMOFILEBLOCKSIZE',iCFGHLP_FPMEMOFILEBLOCKSIZE);
      AddConstant('iCFGHLP_CFGSYSTEMDB',iCFGHLP_CFGSYSTEMDB);
      AddConstant('iCFGHLP_OBJECTMODE',iCFGHLP_OBJECTMODE);
      AddConstant('ERRCAT_NONE',ERRCAT_NONE);
      AddConstant('ERRCAT_SYSTEM',ERRCAT_SYSTEM);
      AddConstant('ERRCAT_NOTFOUND',ERRCAT_NOTFOUND);
      AddConstant('ERRCAT_DATACORRUPT',ERRCAT_DATACORRUPT);
      AddConstant('ERRCAT_IO',ERRCAT_IO);
      AddConstant('ERRCAT_LIMIT',ERRCAT_LIMIT);
      AddConstant('ERRCAT_INTEGRITY',ERRCAT_INTEGRITY);
      AddConstant('ERRCAT_INVALIDREQ',ERRCAT_INVALIDREQ);
      AddConstant('ERRCAT_LOCKCONFLICT',ERRCAT_LOCKCONFLICT);
      AddConstant('ERRCAT_SECURITY',ERRCAT_SECURITY);
      AddConstant('ERRCAT_INVALIDCONTEXT',ERRCAT_INVALIDCONTEXT);
      AddConstant('ERRCAT_OS',ERRCAT_OS);
      AddConstant('ERRCAT_NETWORK',ERRCAT_NETWORK);
      AddConstant('ERRCAT_OPTPARAM',ERRCAT_OPTPARAM);
      AddConstant('ERRCAT_QUERY',ERRCAT_QUERY);
      AddConstant('ERRCAT_VERSION',ERRCAT_VERSION);
      AddConstant('ERRCAT_CAPABILITY',ERRCAT_CAPABILITY);
      AddConstant('ERRCAT_CONFIG',ERRCAT_CONFIG);
      AddConstant('ERRCAT_WARNING',ERRCAT_WARNING);
      AddConstant('ERRCAT_OTHER',ERRCAT_OTHER);
      AddConstant('ERRCAT_COMPATIBILITY',ERRCAT_COMPATIBILITY);
      AddConstant('ERRCAT_REPOSITORY',ERRCAT_REPOSITORY);
      AddConstant('ERRCAT_DRIVER',ERRCAT_DRIVER);
      AddConstant('ERRCAT_RC',ERRCAT_RC);
      AddConstant('ERRBASE_NONE',ERRBASE_NONE);
      AddConstant('ERRBASE_SYSTEM',ERRBASE_SYSTEM);
      AddConstant('ERRBASE_NOTFOUND',ERRBASE_NOTFOUND);
      AddConstant('ERRBASE_DATACORRUPT',ERRBASE_DATACORRUPT);
      AddConstant('ERRBASE_IO',ERRBASE_IO);
      AddConstant('ERRBASE_LIMIT',ERRBASE_LIMIT);
      AddConstant('ERRBASE_INTEGRITY',ERRBASE_INTEGRITY);
      AddConstant('ERRBASE_INVALIDREQ',ERRBASE_INVALIDREQ);
      AddConstant('ERRBASE_LOCKCONFLICT',ERRBASE_LOCKCONFLICT);
      AddConstant('ERRBASE_SEC',ERRBASE_SEC);
      AddConstant('ERRBASE_IC',ERRBASE_IC);
      AddConstant('ERRBASE_OS',ERRBASE_OS);
      AddConstant('ERRBASE_NETWORK',ERRBASE_NETWORK);
      AddConstant('ERRBASE_OPTPARAM',ERRBASE_OPTPARAM);
      AddConstant('ERRBASE_QUERY',ERRBASE_QUERY);
      AddConstant('ERRBASE_VERSION',ERRBASE_VERSION);
      AddConstant('ERRBASE_CAPABILITY',ERRBASE_CAPABILITY);
      AddConstant('ERRBASE_CONFIG',ERRBASE_CONFIG);
      AddConstant('ERRBASE_WARNING',ERRBASE_WARNING);
      AddConstant('ERRBASE_OTHER',ERRBASE_OTHER);
      AddConstant('ERRBASE_COMPATIBILITY',ERRBASE_COMPATIBILITY);
      AddConstant('ERRBASE_REPOSITORY',ERRBASE_REPOSITORY);
      AddConstant('ERRBASE_DRIVER',ERRBASE_DRIVER);
      AddConstant('ERRBASE_RC',ERRBASE_RC);
      AddConstant('ERRCODE_NONE',ERRCODE_NONE);
      AddConstant('DBIERR_NONE',DBIERR_NONE);
      AddConstant('ERRCODE_SYSFILEOPEN',ERRCODE_SYSFILEOPEN);
      AddConstant('ERRCODE_SYSFILEIO',ERRCODE_SYSFILEIO);
      AddConstant('ERRCODE_SYSCORRUPT',ERRCODE_SYSCORRUPT);
      AddConstant('ERRCODE_NOCONFIGFILE',ERRCODE_NOCONFIGFILE);
      AddConstant('ERRCODE_CFGCANNOTWRITE',ERRCODE_CFGCANNOTWRITE);
      AddConstant('ERRCODE_CFGMULTIFILE',ERRCODE_CFGMULTIFILE);
      AddConstant('ERRCODE_REENTERED',ERRCODE_REENTERED);
      AddConstant('ERRCODE_CANTFINDIDAPI',ERRCODE_CANTFINDIDAPI);
      AddConstant('ERRCODE_CANTLOADIDAPI',ERRCODE_CANTLOADIDAPI);
      AddConstant('ERRCODE_CANTLOADLIBRARY',ERRCODE_CANTLOADLIBRARY);
      AddConstant('ERRCODE_TEMPFILEERR',ERRCODE_TEMPFILEERR);
      AddConstant('ERRCODE_MULTIPLEIDAPI',ERRCODE_MULTIPLEIDAPI);
      AddConstant('ERRCODE_SHAREDMEMCONFLICT',ERRCODE_SHAREDMEMCONFLICT);
      AddConstant('DBIERR_SYSFILEOPEN',DBIERR_SYSFILEOPEN);
      AddConstant('DBIERR_SYSFILEIO',DBIERR_SYSFILEIO);
      AddConstant('DBIERR_SYSCORRUPT',DBIERR_SYSCORRUPT);
      AddConstant('DBIERR_NOCONFIGFILE',DBIERR_NOCONFIGFILE);
      AddConstant('DBIERR_CFGCANNOTWRITE',DBIERR_CFGCANNOTWRITE);
      AddConstant('DBIERR_CFGMULTIFILE',DBIERR_CFGMULTIFILE);
      AddConstant('DBIERR_REENTERED',DBIERR_REENTERED);
      AddConstant('DBIERR_CANTFINDIDAPI',DBIERR_CANTFINDIDAPI);
      AddConstant('DBIERR_CANTLOADIDAPI',DBIERR_CANTLOADIDAPI);
      AddConstant('DBIERR_CANTLOADLIBRARY',DBIERR_CANTLOADLIBRARY);
      AddConstant('DBIERR_TEMPFILEERR',DBIERR_TEMPFILEERR);
      AddConstant('DBIERR_MULTIPLEIDAPI',DBIERR_MULTIPLEIDAPI);
      AddConstant('DBIERR_SHAREDMEMCONFLICT',DBIERR_SHAREDMEMCONFLICT);
      AddConstant('DBIERR_CANTFINDODAPI',DBIERR_CANTFINDODAPI);
      AddConstant('DBIERR_CANTLOADODAPI',DBIERR_CANTLOADODAPI);
      AddConstant('ERRCODE_BOF',ERRCODE_BOF);
      AddConstant('ERRCODE_EOF',ERRCODE_EOF);
      AddConstant('ERRCODE_RECMOVED',ERRCODE_RECMOVED);
      AddConstant('ERRCODE_KEYORRECDELETED',ERRCODE_KEYORRECDELETED);
      AddConstant('ERRCODE_NOCURRREC',ERRCODE_NOCURRREC);
      AddConstant('ERRCODE_RECNOTFOUND',ERRCODE_RECNOTFOUND);
      AddConstant('ERRCODE_ENDOFBLOB',ERRCODE_ENDOFBLOB);
      AddConstant('ERRCODE_OBJNOTFOUND',ERRCODE_OBJNOTFOUND);
      AddConstant('ERRCODE_FMLMEMBERNOTFOUND',ERRCODE_FMLMEMBERNOTFOUND);
      AddConstant('ERRCODE_BLOBFILEMISSING',ERRCODE_BLOBFILEMISSING);
      AddConstant('ERRCODE_LDNOTFOUND',ERRCODE_LDNOTFOUND);
      AddConstant('DBIERR_BOF',DBIERR_BOF);
      AddConstant('DBIERR_EOF',DBIERR_EOF);
      AddConstant('DBIERR_RECMOVED',DBIERR_RECMOVED);
      AddConstant('DBIERR_RECDELETED',DBIERR_RECDELETED);
      AddConstant('DBIERR_KEYORRECDELETED',DBIERR_KEYORRECDELETED);
      AddConstant('DBIERR_NOCURRREC',DBIERR_NOCURRREC);
      AddConstant('DBIERR_RECNOTFOUND',DBIERR_RECNOTFOUND);
      AddConstant('DBIERR_ENDOFBLOB',DBIERR_ENDOFBLOB);
      AddConstant('DBIERR_OBJNOTFOUND',DBIERR_OBJNOTFOUND);
      AddConstant('DBIERR_FMLMEMBERNOTFOUND',DBIERR_FMLMEMBERNOTFOUND);
      AddConstant('DBIERR_BLOBFILEMISSING',DBIERR_BLOBFILEMISSING);
      AddConstant('DBIERR_LDNOTFOUND',DBIERR_LDNOTFOUND);
      AddConstant('ERRCODE_HEADERCORRUPT',ERRCODE_HEADERCORRUPT);
      AddConstant('ERRCODE_FILECORRUPT',ERRCODE_FILECORRUPT);
      AddConstant('ERRCODE_MEMOCORRUPT',ERRCODE_MEMOCORRUPT);
      AddConstant('ERRCODE_BMPCORRUPT',ERRCODE_BMPCORRUPT);
      AddConstant('ERRCODE_INDEXCORRUPT',ERRCODE_INDEXCORRUPT);
      AddConstant('ERRCODE_CORRUPTLOCKFILE',ERRCODE_CORRUPTLOCKFILE);
      AddConstant('ERRCODE_FAMFILEINVALID',ERRCODE_FAMFILEINVALID);
      AddConstant('ERRCODE_VALFILECORRUPT',ERRCODE_VALFILECORRUPT);
      AddConstant('ERRCODE_FOREIGNINDEX',ERRCODE_FOREIGNINDEX);
      AddConstant('DBIERR_HEADERCORRUPT',DBIERR_HEADERCORRUPT);
      AddConstant('DBIERR_FILECORRUPT',DBIERR_FILECORRUPT);
      AddConstant('DBIERR_MEMOCORRUPT',DBIERR_MEMOCORRUPT);
      AddConstant('DBIERR_BMPCORRUPT',DBIERR_BMPCORRUPT);
      AddConstant('DBIERR_INDEXCORRUPT',DBIERR_INDEXCORRUPT);
      AddConstant('DBIERR_CORRUPTLOCKFILE',DBIERR_CORRUPTLOCKFILE);
      AddConstant('DBIERR_FAMFILEINVALID',DBIERR_FAMFILEINVALID);
      AddConstant('DBIERR_VALFILECORRUPT',DBIERR_VALFILECORRUPT);
      AddConstant('DBIERR_FOREIGNINDEX',DBIERR_FOREIGNINDEX);
      AddConstant('ERRCODE_READERR',ERRCODE_READERR);
      AddConstant('ERRCODE_WRITEERR',ERRCODE_WRITEERR);
      AddConstant('ERRCODE_DIRNOACCESS',ERRCODE_DIRNOACCESS);
      AddConstant('ERRCODE_FILEDELETEFAIL',ERRCODE_FILEDELETEFAIL);
      AddConstant('ERRCODE_FILENOACCESS',ERRCODE_FILENOACCESS);
      AddConstant('ERRCODE_ACCESSDISABLED',ERRCODE_ACCESSDISABLED);
      AddConstant('DBIERR_READERR',DBIERR_READERR);
      AddConstant('DBIERR_WRITEERR',DBIERR_WRITEERR);
      AddConstant('DBIERR_DIRNOACCESS',DBIERR_DIRNOACCESS);
      AddConstant('DBIERR_FILEDELETEFAIL',DBIERR_FILEDELETEFAIL);
      AddConstant('DBIERR_FILENOACCESS',DBIERR_FILENOACCESS);
      AddConstant('DBIERR_ACCESSDISABLED',DBIERR_ACCESSDISABLED);
      AddConstant('ERRCODE_NOMEMORY',ERRCODE_NOMEMORY);
      AddConstant('ERRCODE_NOFILEHANDLES',ERRCODE_NOFILEHANDLES);
    end;
  end;

  procedure AddConsts3;
  begin
    with Scripter.DefineClass(ClassType) do
    begin
      AddConstant('ERRCODE_NODISKSPACE',ERRCODE_NODISKSPACE);
      AddConstant('ERRCODE_NOTEMPTBLSPACE',ERRCODE_NOTEMPTBLSPACE);
      AddConstant('ERRCODE_RECTOOBIG',ERRCODE_RECTOOBIG);
      AddConstant('ERRCODE_CURSORLIMIT',ERRCODE_CURSORLIMIT);
      AddConstant('ERRCODE_TABLEFULL',ERRCODE_TABLEFULL);
      AddConstant('ERRCODE_WSSESLIMIT',ERRCODE_WSSESLIMIT);
      AddConstant('ERRCODE_SERNUMLIMIT',ERRCODE_SERNUMLIMIT);
      AddConstant('ERRCODE_INTERNALLIMIT',ERRCODE_INTERNALLIMIT);
      AddConstant('ERRCODE_OPENTBLLIMIT',ERRCODE_OPENTBLLIMIT);
      AddConstant('ERRCODE_TBLCURSORLIMIT',ERRCODE_TBLCURSORLIMIT);
      AddConstant('ERRCODE_RECLOCKLIMIT',ERRCODE_RECLOCKLIMIT);
      AddConstant('ERRCODE_CLIENTSLIMIT',ERRCODE_CLIENTSLIMIT);
      AddConstant('ERRCODE_INDEXLIMIT',ERRCODE_INDEXLIMIT);
      AddConstant('ERRCODE_SESSIONSLIMIT',ERRCODE_SESSIONSLIMIT);
      AddConstant('ERRCODE_DBLIMIT',ERRCODE_DBLIMIT);
      AddConstant('ERRCODE_PASSWORDLIMIT',ERRCODE_PASSWORDLIMIT);
      AddConstant('ERRCODE_DRIVERLIMIT',ERRCODE_DRIVERLIMIT);
      AddConstant('ERRCODE_FLDLIMIT',ERRCODE_FLDLIMIT);
      AddConstant('ERRCODE_TBLLOCKLIMIT',ERRCODE_TBLLOCKLIMIT);
      AddConstant('ERRCODE_OPENBLOBLIMIT',ERRCODE_OPENBLOBLIMIT);
      AddConstant('ERRCODE_LOCKFILELIMIT',ERRCODE_LOCKFILELIMIT);
      AddConstant('ERRCODE_OPENQRYLIMIT',ERRCODE_OPENQRYLIMIT);
      AddConstant('ERRCODE_THREADLIMIT',ERRCODE_THREADLIMIT);
      AddConstant('ERRCODE_BLOBLIMIT',ERRCODE_BLOBLIMIT);
      AddConstant('ERRCODE_PDX50NAMELIMIT',ERRCODE_PDX50NAMELIMIT);
      AddConstant('ERRCODE_ROWFETCHLIMIT',ERRCODE_ROWFETCHLIMIT);
      AddConstant('ERRCODE_LONGNAMENOTALLOWED',ERRCODE_LONGNAMENOTALLOWED);
      AddConstant('ERRCODE_NOSHAREDMEMORY',ERRCODE_NOSHAREDMEMORY);
      AddConstant('DBIERR_NOMEMORY',DBIERR_NOMEMORY);
      AddConstant('DBIERR_NOFILEHANDLES',DBIERR_NOFILEHANDLES);
      AddConstant('DBIERR_NODISKSPACE',DBIERR_NODISKSPACE);
      AddConstant('DBIERR_NOTEMPTBLSPACE',DBIERR_NOTEMPTBLSPACE);
      AddConstant('DBIERR_RECTOOBIG',DBIERR_RECTOOBIG);
      AddConstant('DBIERR_CURSORLIMIT',DBIERR_CURSORLIMIT);
      AddConstant('DBIERR_TABLEFULL',DBIERR_TABLEFULL);
      AddConstant('DBIERR_WSSESLIMIT',DBIERR_WSSESLIMIT);
      AddConstant('DBIERR_SERNUMLIMIT',DBIERR_SERNUMLIMIT);
      AddConstant('DBIERR_INTERNALLIMIT',DBIERR_INTERNALLIMIT);
      AddConstant('DBIERR_OPENTBLLIMIT',DBIERR_OPENTBLLIMIT);
      AddConstant('DBIERR_TBLCURSORLIMIT',DBIERR_TBLCURSORLIMIT);
      AddConstant('DBIERR_RECLOCKLIMIT',DBIERR_RECLOCKLIMIT);
      AddConstant('DBIERR_CLIENTSLIMIT',DBIERR_CLIENTSLIMIT);
      AddConstant('DBIERR_INDEXLIMIT',DBIERR_INDEXLIMIT);
      AddConstant('DBIERR_SESSIONSLIMIT',DBIERR_SESSIONSLIMIT);
      AddConstant('DBIERR_DBLIMIT',DBIERR_DBLIMIT);
      AddConstant('DBIERR_PASSWORDLIMIT',DBIERR_PASSWORDLIMIT);
      AddConstant('DBIERR_DRIVERLIMIT',DBIERR_DRIVERLIMIT);
      AddConstant('DBIERR_FLDLIMIT',DBIERR_FLDLIMIT);
      AddConstant('DBIERR_TBLLOCKLIMIT',DBIERR_TBLLOCKLIMIT);
      AddConstant('DBIERR_OPENBLOBLIMIT',DBIERR_OPENBLOBLIMIT);
      AddConstant('DBIERR_LOCKFILELIMIT',DBIERR_LOCKFILELIMIT);
      AddConstant('DBIERR_OPENQRYLIMIT',DBIERR_OPENQRYLIMIT);
      AddConstant('DBIERR_THREADLIMIT',DBIERR_THREADLIMIT);
      AddConstant('DBIERR_BLOBLIMIT',DBIERR_BLOBLIMIT);
      AddConstant('DBIERR_PDX50NAMELIMIT',DBIERR_PDX50NAMELIMIT);
      AddConstant('DBIERR_ROWFETCHLIMIT',DBIERR_ROWFETCHLIMIT);
      AddConstant('DBIERR_LONGNAMENOTALLOWED',DBIERR_LONGNAMENOTALLOWED);
      AddConstant('DBIERR_NOSHAREDMEMORY',DBIERR_NOSHAREDMEMORY);
      AddConstant('ERRCODE_KEYVIOL',ERRCODE_KEYVIOL);
      AddConstant('ERRCODE_MINVALERR',ERRCODE_MINVALERR);
      AddConstant('ERRCODE_MAXVALERR',ERRCODE_MAXVALERR);
      AddConstant('ERRCODE_REQDERR',ERRCODE_REQDERR);
      AddConstant('ERRCODE_FORIEGNKEYERR',ERRCODE_FORIEGNKEYERR);
      AddConstant('ERRCODE_DETAILRECORDSEXIST',ERRCODE_DETAILRECORDSEXIST);
      AddConstant('ERRCODE_MASTERTBLLEVEL',ERRCODE_MASTERTBLLEVEL);
      AddConstant('ERRCODE_LOOKUPTABLEERR',ERRCODE_LOOKUPTABLEERR);
      AddConstant('ERRCODE_LOOKUPTBLOPENERR',ERRCODE_LOOKUPTBLOPENERR);
      AddConstant('ERRCODE_DETAILTBLOPENERR',ERRCODE_DETAILTBLOPENERR);
      AddConstant('ERRCODE_MASTERTBLOPENERR',ERRCODE_MASTERTBLOPENERR);
      AddConstant('ERRCODE_FIELDISBLANK',ERRCODE_FIELDISBLANK);
      AddConstant('ERRCODE_MASTEREXISTS',ERRCODE_MASTEREXISTS);
      AddConstant('ERRCODE_MASTERTBLOPEN',ERRCODE_MASTERTBLOPEN);
      AddConstant('ERRCODE_DETAILTABLESEXIST',ERRCODE_DETAILTABLESEXIST);
      AddConstant('ERRCODE_DETAILRECEXISTEMPTY',ERRCODE_DETAILRECEXISTEMPTY);
      AddConstant('ERRCODE_MASTERREFERENCEERR',ERRCODE_MASTERREFERENCEERR);
      AddConstant('ERRCODE_DETAILTBLOPEN',ERRCODE_DETAILTBLOPEN);
      AddConstant('ERRCODE_DEPENDENTSMUSTBEEMPTY',ERRCODE_DEPENDENTSMUSTBEEMPTY);
      AddConstant('ERRCODE_RINTREQINDEX',ERRCODE_RINTREQINDEX);
      AddConstant('ERRCODE_LINKEDTBLPROTECTED',ERRCODE_LINKEDTBLPROTECTED);
      AddConstant('ERRCODE_FIELDMULTILINKED',ERRCODE_FIELDMULTILINKED);
      AddConstant('ERRCODE_EXPRVALERR',ERRCODE_EXPRVALERR);
      AddConstant('DBIERR_KEYVIOL',DBIERR_KEYVIOL);
      AddConstant('DBIERR_MINVALERR',DBIERR_MINVALERR);
      AddConstant('DBIERR_MAXVALERR',DBIERR_MAXVALERR);
      AddConstant('DBIERR_REQDERR',DBIERR_REQDERR);
      AddConstant('DBIERR_FORIEGNKEYERR',DBIERR_FORIEGNKEYERR);
      AddConstant('DBIERR_DETAILRECORDSEXIST',DBIERR_DETAILRECORDSEXIST);
      AddConstant('DBIERR_MASTERTBLLEVEL',DBIERR_MASTERTBLLEVEL);
      AddConstant('DBIERR_LOOKUPTABLEERR',DBIERR_LOOKUPTABLEERR);
      AddConstant('DBIERR_LOOKUPTBLOPENERR',DBIERR_LOOKUPTBLOPENERR);
      AddConstant('DBIERR_DETAILTBLOPENERR',DBIERR_DETAILTBLOPENERR);
      AddConstant('DBIERR_MASTERTBLOPENERR',DBIERR_MASTERTBLOPENERR);
      AddConstant('DBIERR_FIELDISBLANK',DBIERR_FIELDISBLANK);
      AddConstant('DBIERR_MASTEREXISTS',DBIERR_MASTEREXISTS);
      AddConstant('DBIERR_MASTERTBLOPEN',DBIERR_MASTERTBLOPEN);
      AddConstant('DBIERR_DETAILTABLESEXIST',DBIERR_DETAILTABLESEXIST);
      AddConstant('DBIERR_DETAILRECEXISTEMPTY',DBIERR_DETAILRECEXISTEMPTY);
      AddConstant('DBIERR_MASTERREFERENCEERR',DBIERR_MASTERREFERENCEERR);
      AddConstant('DBIERR_DETAILTBLOPEN',DBIERR_DETAILTBLOPEN);
      AddConstant('DBIERR_DEPENDENTSMUSTBEEMPTY',DBIERR_DEPENDENTSMUSTBEEMPTY);
      AddConstant('DBIERR_RINTREQINDEX',DBIERR_RINTREQINDEX);
      AddConstant('DBIERR_LINKEDTBLPROTECTED',DBIERR_LINKEDTBLPROTECTED);
      AddConstant('DBIERR_FIELDMULTILINKED',DBIERR_FIELDMULTILINKED);
      AddConstant('DBIERR_EXPRVALERR',DBIERR_EXPRVALERR);
      AddConstant('ERRCODE_OUTOFRANGE',ERRCODE_OUTOFRANGE);
      AddConstant('ERRCODE_INVALIDPARAM',ERRCODE_INVALIDPARAM);
      AddConstant('ERRCODE_INVALIDFILENAME',ERRCODE_INVALIDFILENAME);
      AddConstant('ERRCODE_NOSUCHFILE',ERRCODE_NOSUCHFILE);
      AddConstant('ERRCODE_INVALIDOPTION',ERRCODE_INVALIDOPTION);
      AddConstant('ERRCODE_INVALIDHNDL',ERRCODE_INVALIDHNDL);
      AddConstant('ERRCODE_UNKNOWNTBLTYPE',ERRCODE_UNKNOWNTBLTYPE);
      AddConstant('ERRCODE_UNKNOWNFILE',ERRCODE_UNKNOWNFILE);
      AddConstant('ERRCODE_PRIMARYKEYREDEFINE',ERRCODE_PRIMARYKEYREDEFINE);
      AddConstant('ERRCODE_INVALIDRINTDESCNUM',ERRCODE_INVALIDRINTDESCNUM);
      AddConstant('ERRCODE_KEYFLDTYPEMISMATCH',ERRCODE_KEYFLDTYPEMISMATCH);
      AddConstant('ERRCODE_INVALIDMODIFYREQUEST',ERRCODE_INVALIDMODIFYREQUEST);
      AddConstant('ERRCODE_NOSUCHINDEX',ERRCODE_NOSUCHINDEX);
      AddConstant('ERRCODE_INVALIDBLOBOFFSET',ERRCODE_INVALIDBLOBOFFSET);
      AddConstant('ERRCODE_INVALIDDESCNUM',ERRCODE_INVALIDDESCNUM);
      AddConstant('ERRCODE_INVALIDFLDTYPE',ERRCODE_INVALIDFLDTYPE);
      AddConstant('ERRCODE_INVALIDFLDDESC',ERRCODE_INVALIDFLDDESC);
      AddConstant('ERRCODE_INVALIDFLDXFORM',ERRCODE_INVALIDFLDXFORM);
      AddConstant('ERRCODE_INVALIDRECSTRUCT',ERRCODE_INVALIDRECSTRUCT);
      AddConstant('ERRCODE_INVALIDDESC',ERRCODE_INVALIDDESC);
      AddConstant('ERRCODE_INVALIDINDEXSTRUCT',ERRCODE_INVALIDINDEXSTRUCT);
      AddConstant('ERRCODE_INVALIDVCHKSTRUCT',ERRCODE_INVALIDVCHKSTRUCT);
      AddConstant('ERRCODE_INVALIDRINTSTRUCT',ERRCODE_INVALIDRINTSTRUCT);
      AddConstant('ERRCODE_INVALIDRESTRTBLORDER',ERRCODE_INVALIDRESTRTBLORDER);
      AddConstant('ERRCODE_NAMENOTUNIQUE',ERRCODE_NAMENOTUNIQUE);
      AddConstant('ERRCODE_INDEXNAMEREQUIRED',ERRCODE_INDEXNAMEREQUIRED);
      AddConstant('ERRCODE_INVALIDSESHANDLE',ERRCODE_INVALIDSESHANDLE);
      AddConstant('ERRCODE_INVALIDRESTROP',ERRCODE_INVALIDRESTROP);
      AddConstant('ERRCODE_UNKNOWNDRIVER',ERRCODE_UNKNOWNDRIVER);
      AddConstant('ERRCODE_UNKNOWNDB',ERRCODE_UNKNOWNDB);
      AddConstant('ERRCODE_INVALIDPASSWORD',ERRCODE_INVALIDPASSWORD);
      AddConstant('ERRCODE_NOCALLBACK',ERRCODE_NOCALLBACK);
      AddConstant('ERRCODE_INVALIDCALLBACKBUFLEN',ERRCODE_INVALIDCALLBACKBUFLEN);
      AddConstant('ERRCODE_INVALIDDIR',ERRCODE_INVALIDDIR);
      AddConstant('ERRCODE_INVALIDXLATION',ERRCODE_INVALIDXLATION);
      AddConstant('ERRCODE_DIFFERENTTABLES',ERRCODE_DIFFERENTTABLES);
      AddConstant('ERRCODE_INVALIDBOOKMARK',ERRCODE_INVALIDBOOKMARK);
      AddConstant('ERRCODE_INVALIDINDEXNAME',ERRCODE_INVALIDINDEXNAME);
      AddConstant('ERRCODE_INVALIDIDXDESC',ERRCODE_INVALIDIDXDESC);
      AddConstant('ERRCODE_NOSUCHTABLE',ERRCODE_NOSUCHTABLE);
      AddConstant('ERRCODE_USECOUNT',ERRCODE_USECOUNT);
      AddConstant('ERRCODE_INVALIDKEY',ERRCODE_INVALIDKEY);
      AddConstant('ERRCODE_INDEXEXISTS',ERRCODE_INDEXEXISTS);
      AddConstant('ERRCODE_INDEXOPEN',ERRCODE_INDEXOPEN);
      AddConstant('ERRCODE_INVALIDBLOBLEN',ERRCODE_INVALIDBLOBLEN);
      AddConstant('ERRCODE_INVALIDBLOBHANDLE',ERRCODE_INVALIDBLOBHANDLE);
      AddConstant('ERRCODE_TABLEOPEN',ERRCODE_TABLEOPEN);
      AddConstant('ERRCODE_NEEDRESTRUCTURE',ERRCODE_NEEDRESTRUCTURE);
      AddConstant('ERRCODE_INVALIDMODE',ERRCODE_INVALIDMODE);
      AddConstant('ERRCODE_CANNOTCLOSE',ERRCODE_CANNOTCLOSE);
      AddConstant('ERRCODE_ACTIVEINDEX',ERRCODE_ACTIVEINDEX);
      AddConstant('ERRCODE_INVALIDUSRPASS',ERRCODE_INVALIDUSRPASS);
      AddConstant('ERRCODE_MULTILEVELCASCADE',ERRCODE_MULTILEVELCASCADE);
      AddConstant('ERRCODE_INVALIDFIELDNAME',ERRCODE_INVALIDFIELDNAME);
      AddConstant('ERRCODE_INVALIDTABLENAME',ERRCODE_INVALIDTABLENAME);
      AddConstant('ERRCODE_INVALIDLINKEXPR',ERRCODE_INVALIDLINKEXPR);
      AddConstant('ERRCODE_NAMERESERVED',ERRCODE_NAMERESERVED);
      AddConstant('ERRCODE_INVALIDFILEEXTN',ERRCODE_INVALIDFILEEXTN);
      AddConstant('ERRCODE_INVALIDLANGDRV',ERRCODE_INVALIDLANGDRV);
      AddConstant('ERRCODE_ALIASNOTOPEN',ERRCODE_ALIASNOTOPEN);
      AddConstant('ERRCODE_INCOMPATRECSTRUCTS',ERRCODE_INCOMPATRECSTRUCTS);
      AddConstant('ERRCODE_RESERVEDDOSNAME',ERRCODE_RESERVEDDOSNAME);
      AddConstant('ERRCODE_DESTMUSTBEINDEXED',ERRCODE_DESTMUSTBEINDEXED);
      AddConstant('ERRCODE_INVALIDINDEXTYPE',ERRCODE_INVALIDINDEXTYPE);
      AddConstant('ERRCODE_LANGDRVMISMATCH',ERRCODE_LANGDRVMISMATCH);
      AddConstant('ERRCODE_NOSUCHFILTER',ERRCODE_NOSUCHFILTER);
      AddConstant('ERRCODE_INVALIDFILTER',ERRCODE_INVALIDFILTER);
      AddConstant('ERRCODE_INVALIDTABLECREATE',ERRCODE_INVALIDTABLECREATE);
      AddConstant('ERRCODE_INVALIDTABLEDELETE',ERRCODE_INVALIDTABLEDELETE);
      AddConstant('ERRCODE_INVALIDINDEXCREATE',ERRCODE_INVALIDINDEXCREATE);
      AddConstant('ERRCODE_INVALIDINDEXDELETE',ERRCODE_INVALIDINDEXDELETE);
      AddConstant('ERRCODE_INVALIDTABLE',ERRCODE_INVALIDTABLE);
      AddConstant('ERRCODE_MULTIRESULTS',ERRCODE_MULTIRESULTS);
      AddConstant('ERRCODE_INVALIDTIME',ERRCODE_INVALIDTIME);
      AddConstant('ERRCODE_INVALIDDATE',ERRCODE_INVALIDDATE);
      AddConstant('ERRCODE_INVALIDTIMESTAMP',ERRCODE_INVALIDTIMESTAMP);
      AddConstant('ERRCODE_DIFFERENTPATH',ERRCODE_DIFFERENTPATH);
      AddConstant('ERRCODE_MISMATCHARGS',ERRCODE_MISMATCHARGS);
      AddConstant('ERRCODE_FUNCTIONNOTFOUND',ERRCODE_FUNCTIONNOTFOUND);
      AddConstant('ERRCODE_MUSTUSEBASEORDER',ERRCODE_MUSTUSEBASEORDER);
      AddConstant('ERRCODE_INVALIDPROCEDURENAME',ERRCODE_INVALIDPROCEDURENAME);
      AddConstant('ERRCODE_INVALIDFLDMAP',ERRCODE_INVALIDFLDMAP);
      AddConstant('DBIERR_OUTOFRANGE',DBIERR_OUTOFRANGE);
      AddConstant('DBIERR_INVALIDPARAM',DBIERR_INVALIDPARAM);
      AddConstant('DBIERR_INVALIDFILENAME',DBIERR_INVALIDFILENAME);
      AddConstant('DBIERR_NOSUCHFILE',DBIERR_NOSUCHFILE);
      AddConstant('DBIERR_INVALIDOPTION',DBIERR_INVALIDOPTION);
      AddConstant('DBIERR_INVALIDHNDL',DBIERR_INVALIDHNDL);
      AddConstant('DBIERR_UNKNOWNTBLTYPE',DBIERR_UNKNOWNTBLTYPE);
      AddConstant('DBIERR_UNKNOWNFILE',DBIERR_UNKNOWNFILE);
      AddConstant('DBIERR_PRIMARYKEYREDEFINE',DBIERR_PRIMARYKEYREDEFINE);
      AddConstant('DBIERR_INVALIDRINTDESCNUM',DBIERR_INVALIDRINTDESCNUM);
      AddConstant('DBIERR_KEYFLDTYPEMISMATCH',DBIERR_KEYFLDTYPEMISMATCH);
      AddConstant('DBIERR_INVALIDMODIFYREQUEST',DBIERR_INVALIDMODIFYREQUEST);
      AddConstant('DBIERR_NOSUCHINDEX',DBIERR_NOSUCHINDEX);
      AddConstant('DBIERR_INVALIDBLOBOFFSET',DBIERR_INVALIDBLOBOFFSET);
      AddConstant('DBIERR_INVALIDDESCNUM',DBIERR_INVALIDDESCNUM);
      AddConstant('DBIERR_INVALIDFLDTYPE',DBIERR_INVALIDFLDTYPE);
      AddConstant('DBIERR_INVALIDFLDDESC',DBIERR_INVALIDFLDDESC);
      AddConstant('DBIERR_INVALIDFLDXFORM',DBIERR_INVALIDFLDXFORM);
      AddConstant('DBIERR_INVALIDRECSTRUCT',DBIERR_INVALIDRECSTRUCT);
      AddConstant('DBIERR_INVALIDDESC',DBIERR_INVALIDDESC);
      AddConstant('DBIERR_INVALIDINDEXSTRUCT',DBIERR_INVALIDINDEXSTRUCT);
      AddConstant('DBIERR_INVALIDVCHKSTRUCT',DBIERR_INVALIDVCHKSTRUCT);
      AddConstant('DBIERR_INVALIDRINTSTRUCT',DBIERR_INVALIDRINTSTRUCT);
      AddConstant('DBIERR_INVALIDRESTRTBLORDER',DBIERR_INVALIDRESTRTBLORDER);
      AddConstant('DBIERR_NAMENOTUNIQUE',DBIERR_NAMENOTUNIQUE);
      AddConstant('DBIERR_INDEXNAMEREQUIRED',DBIERR_INDEXNAMEREQUIRED);
      AddConstant('DBIERR_INVALIDSESHANDLE',DBIERR_INVALIDSESHANDLE);
      AddConstant('DBIERR_INVALIDRESTROP',DBIERR_INVALIDRESTROP);
      AddConstant('DBIERR_UNKNOWNDRIVER',DBIERR_UNKNOWNDRIVER);
      AddConstant('DBIERR_UNKNOWNDB',DBIERR_UNKNOWNDB);
      AddConstant('DBIERR_INVALIDPASSWORD',DBIERR_INVALIDPASSWORD);
      AddConstant('DBIERR_NOCALLBACK',DBIERR_NOCALLBACK);
      AddConstant('DBIERR_INVALIDCALLBACKBUFLEN',DBIERR_INVALIDCALLBACKBUFLEN);
      AddConstant('DBIERR_INVALIDDIR',DBIERR_INVALIDDIR);
      AddConstant('DBIERR_INVALIDXLATION',DBIERR_INVALIDXLATION);
      AddConstant('DBIERR_DIFFERENTTABLES',DBIERR_DIFFERENTTABLES);
      AddConstant('DBIERR_INVALIDBOOKMARK',DBIERR_INVALIDBOOKMARK);
      AddConstant('DBIERR_INVALIDINDEXNAME',DBIERR_INVALIDINDEXNAME);
      AddConstant('DBIERR_INVALIDIDXDESC',DBIERR_INVALIDIDXDESC);
      AddConstant('DBIERR_NOSUCHTABLE',DBIERR_NOSUCHTABLE);
      AddConstant('DBIERR_USECOUNT',DBIERR_USECOUNT);
      AddConstant('DBIERR_INVALIDKEY',DBIERR_INVALIDKEY);
      AddConstant('DBIERR_INDEXEXISTS',DBIERR_INDEXEXISTS);
      AddConstant('DBIERR_INDEXOPEN',DBIERR_INDEXOPEN);
      AddConstant('DBIERR_INVALIDBLOBLEN',DBIERR_INVALIDBLOBLEN);
      AddConstant('DBIERR_INVALIDBLOBHANDLE',DBIERR_INVALIDBLOBHANDLE);
      AddConstant('DBIERR_TABLEOPEN',DBIERR_TABLEOPEN);
      AddConstant('DBIERR_NEEDRESTRUCTURE',DBIERR_NEEDRESTRUCTURE);
      AddConstant('DBIERR_INVALIDMODE',DBIERR_INVALIDMODE);
      AddConstant('DBIERR_CANNOTCLOSE',DBIERR_CANNOTCLOSE);
      AddConstant('DBIERR_ACTIVEINDEX',DBIERR_ACTIVEINDEX);
      AddConstant('DBIERR_INVALIDUSRPASS',DBIERR_INVALIDUSRPASS);
      AddConstant('DBIERR_MULTILEVELCASCADE',DBIERR_MULTILEVELCASCADE);
      AddConstant('DBIERR_INVALIDFIELDNAME',DBIERR_INVALIDFIELDNAME);
      AddConstant('DBIERR_INVALIDTABLENAME',DBIERR_INVALIDTABLENAME);
      AddConstant('DBIERR_INVALIDLINKEXPR',DBIERR_INVALIDLINKEXPR);
      AddConstant('DBIERR_NAMERESERVED',DBIERR_NAMERESERVED);
      AddConstant('DBIERR_INVALIDFILEEXTN',DBIERR_INVALIDFILEEXTN);
      AddConstant('DBIERR_INVALIDLANGDRV',DBIERR_INVALIDLANGDRV);
      AddConstant('DBIERR_ALIASNOTOPEN',DBIERR_ALIASNOTOPEN);
      AddConstant('DBIERR_INCOMPATRECSTRUCTS',DBIERR_INCOMPATRECSTRUCTS);
      AddConstant('DBIERR_RESERVEDOSNAME',DBIERR_RESERVEDOSNAME);
      AddConstant('DBIERR_DESTMUSTBEINDEXED',DBIERR_DESTMUSTBEINDEXED);
      AddConstant('DBIERR_INVALIDINDEXTYPE',DBIERR_INVALIDINDEXTYPE);
      AddConstant('DBIERR_LANGDRVMISMATCH',DBIERR_LANGDRVMISMATCH);
      AddConstant('DBIERR_NOSUCHFILTER',DBIERR_NOSUCHFILTER);
      AddConstant('DBIERR_INVALIDFILTER',DBIERR_INVALIDFILTER);
      AddConstant('DBIERR_INVALIDTABLECREATE',DBIERR_INVALIDTABLECREATE);
      AddConstant('DBIERR_INVALIDTABLEDELETE',DBIERR_INVALIDTABLEDELETE);
      AddConstant('DBIERR_INVALIDINDEXCREATE',DBIERR_INVALIDINDEXCREATE);
      AddConstant('DBIERR_INVALIDINDEXDELETE',DBIERR_INVALIDINDEXDELETE);
      AddConstant('DBIERR_INVALIDTABLE',DBIERR_INVALIDTABLE);
      AddConstant('DBIERR_MULTIRESULTS',DBIERR_MULTIRESULTS);
      AddConstant('DBIERR_INVALIDTIME',DBIERR_INVALIDTIME);
      AddConstant('DBIERR_INVALIDDATE',DBIERR_INVALIDDATE);
      AddConstant('DBIERR_INVALIDTIMESTAMP',DBIERR_INVALIDTIMESTAMP);
      AddConstant('DBIERR_DIFFERENTPATH',DBIERR_DIFFERENTPATH);
      AddConstant('DBIERR_MISMATCHARGS',DBIERR_MISMATCHARGS);
      AddConstant('DBIERR_FUNCTIONNOTFOUND',DBIERR_FUNCTIONNOTFOUND);
      AddConstant('DBIERR_MUSTUSEBASEORDER',DBIERR_MUSTUSEBASEORDER);
      AddConstant('DBIERR_INVALIDPROCEDURENAME',DBIERR_INVALIDPROCEDURENAME);
      AddConstant('DBIERR_INVALIDFLDMAP',DBIERR_INVALIDFLDMAP);
      AddConstant('ERRCODE_LOCKED',ERRCODE_LOCKED);
      AddConstant('ERRCODE_UNLOCKFAILED',ERRCODE_UNLOCKFAILED);
      AddConstant('ERRCODE_FILEBUSY',ERRCODE_FILEBUSY);
      AddConstant('ERRCODE_DIRBUSY',ERRCODE_DIRBUSY);
      AddConstant('ERRCODE_FILELOCKED',ERRCODE_FILELOCKED);
      AddConstant('ERRCODE_DIRLOCKED',ERRCODE_DIRLOCKED);
      AddConstant('ERRCODE_ALREADYLOCKED',ERRCODE_ALREADYLOCKED);
      AddConstant('ERRCODE_NOTLOCKED',ERRCODE_NOTLOCKED);
      AddConstant('ERRCODE_LOCKTIMEOUT',ERRCODE_LOCKTIMEOUT);
      AddConstant('ERRCODE_GROUPLOCKED',ERRCODE_GROUPLOCKED);
      AddConstant('ERRCODE_LOSTTBLLOCK',ERRCODE_LOSTTBLLOCK);
      AddConstant('ERRCODE_LOSTEXCLACCESS',ERRCODE_LOSTEXCLACCESS);
      AddConstant('ERRCODE_NEEDEXCLACCESS',ERRCODE_NEEDEXCLACCESS);
      AddConstant('ERRCODE_RECGROUPCONFLICT',ERRCODE_RECGROUPCONFLICT);
      AddConstant('ERRCODE_DEADLOCK',ERRCODE_DEADLOCK);
      AddConstant('ERRCODE_ACTIVETRAN',ERRCODE_ACTIVETRAN);
      AddConstant('ERRCODE_NOACTIVETRAN',ERRCODE_NOACTIVETRAN);
      AddConstant('ERRCODE_RECLOCKFAILED',ERRCODE_RECLOCKFAILED);
      AddConstant('ERRCODE_OPTRECLOCKFAILED',ERRCODE_OPTRECLOCKFAILED);
      AddConstant('ERRCODE_OPTRECLOCKRECDEL',ERRCODE_OPTRECLOCKRECDEL);
      AddConstant('ERRCODE_LOCKEDRECS',ERRCODE_LOCKEDRECS);
      AddConstant('ERRCODE_NEEDWRITELOCK',ERRCODE_NEEDWRITELOCK);
      AddConstant('ERRCODE_ENLISTFAILED',ERRCODE_ENLISTFAILED);
      AddConstant('DBIERR_LOCKED',DBIERR_LOCKED);
      AddConstant('DBIERR_UNLOCKFAILED',DBIERR_UNLOCKFAILED);
      AddConstant('DBIERR_FILEBUSY',DBIERR_FILEBUSY);
      AddConstant('DBIERR_DIRBUSY',DBIERR_DIRBUSY);
      AddConstant('DBIERR_FILELOCKED',DBIERR_FILELOCKED);
      AddConstant('DBIERR_DIRLOCKED',DBIERR_DIRLOCKED);
      AddConstant('DBIERR_ALREADYLOCKED',DBIERR_ALREADYLOCKED);
      AddConstant('DBIERR_NOTLOCKED',DBIERR_NOTLOCKED);
      AddConstant('DBIERR_LOCKTIMEOUT',DBIERR_LOCKTIMEOUT);
      AddConstant('DBIERR_GROUPLOCKED',DBIERR_GROUPLOCKED);
      AddConstant('DBIERR_LOSTTBLLOCK',DBIERR_LOSTTBLLOCK);
      AddConstant('DBIERR_LOSTEXCLACCESS',DBIERR_LOSTEXCLACCESS);
      AddConstant('DBIERR_NEEDEXCLACCESS',DBIERR_NEEDEXCLACCESS);
      AddConstant('DBIERR_RECGROUPCONFLICT',DBIERR_RECGROUPCONFLICT);
      AddConstant('DBIERR_DEADLOCK',DBIERR_DEADLOCK);
      AddConstant('DBIERR_ACTIVETRAN',DBIERR_ACTIVETRAN);
      AddConstant('DBIERR_NOACTIVETRAN',DBIERR_NOACTIVETRAN);
      AddConstant('DBIERR_RECLOCKFAILED',DBIERR_RECLOCKFAILED);
      AddConstant('DBIERR_OPTRECLOCKFAILED',DBIERR_OPTRECLOCKFAILED);
      AddConstant('DBIERR_OPTRECLOCKRECDEL',DBIERR_OPTRECLOCKRECDEL);
      AddConstant('DBIERR_ENLISTFAILED',DBIERR_ENLISTFAILED);
      AddConstant('ERRCODE_NOTSUFFFIELDRIGHTS',ERRCODE_NOTSUFFFIELDRIGHTS);
      AddConstant('ERRCODE_NOTSUFFTABLERIGHTS',ERRCODE_NOTSUFFTABLERIGHTS);
      AddConstant('ERRCODE_NOTSUFFFAMILYRIGHTS',ERRCODE_NOTSUFFFAMILYRIGHTS);
      AddConstant('ERRCODE_READONLYDIR',ERRCODE_READONLYDIR);
      AddConstant('ERRCODE_READONLYDB',ERRCODE_READONLYDB);
      AddConstant('ERRCODE_READONLYFLD',ERRCODE_READONLYFLD);
      AddConstant('ERRCODE_TBLENCRYPTED',ERRCODE_TBLENCRYPTED);
      AddConstant('ERRCODE_NOTSUFFSQLRIGHTS',ERRCODE_NOTSUFFSQLRIGHTS);
      AddConstant('DBIERR_NOTSUFFFIELDRIGHTS',DBIERR_NOTSUFFFIELDRIGHTS);
      AddConstant('DBIERR_NOTSUFFTABLERIGHTS',DBIERR_NOTSUFFTABLERIGHTS);
      AddConstant('DBIERR_NOTSUFFFAMILYRIGHTS',DBIERR_NOTSUFFFAMILYRIGHTS);
      AddConstant('DBIERR_READONLYDIR',DBIERR_READONLYDIR);
      AddConstant('DBIERR_READONLYDB',DBIERR_READONLYDB);
      AddConstant('DBIERR_READONLYFLD',DBIERR_READONLYFLD);
      AddConstant('DBIERR_TBLENCRYPTED',DBIERR_TBLENCRYPTED);
      AddConstant('DBIERR_NOTSUFFSQLRIGHTS',DBIERR_NOTSUFFSQLRIGHTS);
      AddConstant('ERRCODE_NOTABLOB',ERRCODE_NOTABLOB);
      AddConstant('ERRCODE_BLOBOPENED',ERRCODE_BLOBOPENED);
      AddConstant('ERRCODE_BLOBNOTOPENED',ERRCODE_BLOBNOTOPENED);
      AddConstant('ERRCODE_NA',ERRCODE_NA);
      AddConstant('ERRCODE_NOTINDEXED',ERRCODE_NOTINDEXED);
      AddConstant('ERRCODE_NOTINITIALIZED',ERRCODE_NOTINITIALIZED);
      AddConstant('ERRCODE_MULTIPLEINIT',ERRCODE_MULTIPLEINIT);
      AddConstant('ERRCODE_NOTSAMESESSION',ERRCODE_NOTSAMESESSION);
      AddConstant('ERRCODE_PDXDRIVERNOTACTIVE',ERRCODE_PDXDRIVERNOTACTIVE);
      AddConstant('ERRCODE_DRIVERNOTLOADED',ERRCODE_DRIVERNOTLOADED);
      AddConstant('ERRCODE_TABLEREADONLY',ERRCODE_TABLEREADONLY);
      AddConstant('ERRCODE_NOASSOCINDEX',ERRCODE_NOASSOCINDEX);
      AddConstant('ERRCODE_HASOPENCURSORS',ERRCODE_HASOPENCURSORS);
      AddConstant('ERRCODE_NOTABLESUPPORT',ERRCODE_NOTABLESUPPORT);
      AddConstant('ERRCODE_INDEXREADONLY',ERRCODE_INDEXREADONLY);
      AddConstant('ERRCODE_NOUNIQUERECS',ERRCODE_NOUNIQUERECS);
      AddConstant('ERRCODE_NOTCURSESSION',ERRCODE_NOTCURSESSION);
      AddConstant('ERRCODE_INVALIDKEYWORD',ERRCODE_INVALIDKEYWORD);
      AddConstant('ERRCODE_CONNECTINUSE',ERRCODE_CONNECTINUSE);
      AddConstant('ERRCODE_CONNECTNOTSHARED',ERRCODE_CONNECTNOTSHARED);
      AddConstant('DBIERR_NOTABLOB',DBIERR_NOTABLOB);
      AddConstant('DBIERR_BLOBOPENED',DBIERR_BLOBOPENED);
      AddConstant('DBIERR_BLOBNOTOPENED',DBIERR_BLOBNOTOPENED);
      AddConstant('DBIERR_NA',DBIERR_NA);
      AddConstant('DBIERR_NOTINDEXED',DBIERR_NOTINDEXED);
      AddConstant('DBIERR_NOTINITIALIZED',DBIERR_NOTINITIALIZED);
      AddConstant('DBIERR_MULTIPLEINIT',DBIERR_MULTIPLEINIT);
      AddConstant('DBIERR_NOTSAMESESSION',DBIERR_NOTSAMESESSION);
      AddConstant('DBIERR_PDXDRIVERNOTACTIVE',DBIERR_PDXDRIVERNOTACTIVE);
      AddConstant('DBIERR_DRIVERNOTLOADED',DBIERR_DRIVERNOTLOADED);
      AddConstant('DBIERR_TABLEREADONLY',DBIERR_TABLEREADONLY);
      AddConstant('DBIERR_NOASSOCINDEX',DBIERR_NOASSOCINDEX);
      AddConstant('DBIERR_HASOPENCURSORS',DBIERR_HASOPENCURSORS);
      AddConstant('DBIERR_NOTABLESUPPORT',DBIERR_NOTABLESUPPORT);
      AddConstant('DBIERR_INDEXREADONLY',DBIERR_INDEXREADONLY);
      AddConstant('DBIERR_NOUNIQUERECS',DBIERR_NOUNIQUERECS);
      AddConstant('DBIERR_NOTCURSESSION',DBIERR_NOTCURSESSION);
      AddConstant('DBIERR_INVALIDKEYWORD',DBIERR_INVALIDKEYWORD);
      AddConstant('DBIERR_CONNECTINUSE',DBIERR_CONNECTINUSE);
      AddConstant('DBIERR_CONNECTNOTSHARED',DBIERR_CONNECTNOTSHARED);
      AddConstant('ERRCODE_OSEINVFNC',ERRCODE_OSEINVFNC);
      AddConstant('ERRCODE_OSENOENT',ERRCODE_OSENOENT);
      AddConstant('ERRCODE_OSENOPATH',ERRCODE_OSENOPATH);
      AddConstant('ERRCODE_OSEMFILE',ERRCODE_OSEMFILE);
      AddConstant('ERRCODE_OSEACCES',ERRCODE_OSEACCES);
      AddConstant('ERRCODE_OSEBADF',ERRCODE_OSEBADF);
      AddConstant('ERRCODE_OSECONTR',ERRCODE_OSECONTR);
      AddConstant('ERRCODE_OSENOMEM',ERRCODE_OSENOMEM);
      AddConstant('ERRCODE_OSEINVMEM',ERRCODE_OSEINVMEM);
      AddConstant('ERRCODE_OSEINVENV',ERRCODE_OSEINVENV);
      AddConstant('ERRCODE_OSEINVFMT',ERRCODE_OSEINVFMT);
      AddConstant('ERRCODE_OSEINVACC',ERRCODE_OSEINVACC);
      AddConstant('ERRCODE_OSEINVDAT',ERRCODE_OSEINVDAT);
      AddConstant('ERRCODE_OSENODEV',ERRCODE_OSENODEV);
      AddConstant('ERRCODE_OSECURDIR',ERRCODE_OSECURDIR);
      AddConstant('ERRCODE_OSENOTSAM',ERRCODE_OSENOTSAM);
      AddConstant('ERRCODE_OSENMFILE',ERRCODE_OSENMFILE);
      AddConstant('ERRCODE_OSEINVAL',ERRCODE_OSEINVAL);
      AddConstant('ERRCODE_OSE2BIG',ERRCODE_OSE2BIG);
      AddConstant('ERRCODE_OSENOEXEC',ERRCODE_OSENOEXEC);
      AddConstant('ERRCODE_OSEXDEV',ERRCODE_OSEXDEV);
      AddConstant('ERRCODE_OSEDOM',ERRCODE_OSEDOM);
      AddConstant('ERRCODE_OSERANGE',ERRCODE_OSERANGE);
      AddConstant('ERRCODE_OSEEXIST',ERRCODE_OSEEXIST);
      AddConstant('ERRCODE_OSUNKNOWN',ERRCODE_OSUNKNOWN);
      AddConstant('ERRCODE_OSSHAREVIOL',ERRCODE_OSSHAREVIOL);
      AddConstant('ERRCODE_OSLOCKVIOL',ERRCODE_OSLOCKVIOL);
      AddConstant('ERRCODE_OSINT24FAIL',ERRCODE_OSINT24FAIL);
      AddConstant('ERRCODE_OSDRIVENOTREADY',ERRCODE_OSDRIVENOTREADY);
      AddConstant('ERRCODE_NOTEXACT',ERRCODE_NOTEXACT);
      AddConstant('ERRCODE_OSNETERR',ERRCODE_OSNETERR);
      AddConstant('ERRCODE_OSUNKNOWNSRVERR',ERRCODE_OSUNKNOWNSRVERR);
      AddConstant('ERRCODE_SERVERNOMEMORY',ERRCODE_SERVERNOMEMORY);
      AddConstant('ERRCODE_OSALREADYLOCKED',ERRCODE_OSALREADYLOCKED);
      AddConstant('ERRCODE_OSNOTLOCKED',ERRCODE_OSNOTLOCKED);
      AddConstant('ERRCODE_NOSERVERSW',ERRCODE_NOSERVERSW);
      AddConstant('DBIERR_OSEINVFNC',DBIERR_OSEINVFNC);
      AddConstant('DBIERR_OSENOENT',DBIERR_OSENOENT);
      AddConstant('DBIERR_OSENOPATH',DBIERR_OSENOPATH);
      AddConstant('DBIERR_OSEMFILE',DBIERR_OSEMFILE);
      AddConstant('DBIERR_OSEACCES',DBIERR_OSEACCES);
      AddConstant('DBIERR_OSEBADF',DBIERR_OSEBADF);
      AddConstant('DBIERR_OSECONTR',DBIERR_OSECONTR);
      AddConstant('DBIERR_OSENOMEM',DBIERR_OSENOMEM);
      AddConstant('DBIERR_OSEINVMEM',DBIERR_OSEINVMEM);
      AddConstant('DBIERR_OSEINVENV',DBIERR_OSEINVENV);
      AddConstant('DBIERR_OSEINVFMT',DBIERR_OSEINVFMT);
      AddConstant('DBIERR_OSEINVACC',DBIERR_OSEINVACC);
      AddConstant('DBIERR_OSEINVDAT',DBIERR_OSEINVDAT);
      AddConstant('DBIERR_OSENODEV',DBIERR_OSENODEV);
      AddConstant('DBIERR_OSECURDIR',DBIERR_OSECURDIR);
      AddConstant('DBIERR_OSENOTSAM',DBIERR_OSENOTSAM);
      AddConstant('DBIERR_OSENMFILE',DBIERR_OSENMFILE);
      AddConstant('DBIERR_OSEINVAL',DBIERR_OSEINVAL);
      AddConstant('DBIERR_OSE2BIG',DBIERR_OSE2BIG);
      AddConstant('DBIERR_OSENOEXEC',DBIERR_OSENOEXEC);
      AddConstant('DBIERR_OSEXDEV',DBIERR_OSEXDEV);
      AddConstant('DBIERR_OSEDOM',DBIERR_OSEDOM);
      AddConstant('DBIERR_OSERANGE',DBIERR_OSERANGE);
      AddConstant('DBIERR_OSEEXIST',DBIERR_OSEEXIST);
      AddConstant('DBIERR_OSUNKNOWN',DBIERR_OSUNKNOWN);
      AddConstant('DBIERR_OSSHAREVIOL',DBIERR_OSSHAREVIOL);
      AddConstant('DBIERR_OSLOCKVIOL',DBIERR_OSLOCKVIOL);
      AddConstant('DBIERR_OSNETERR',DBIERR_OSNETERR);
      AddConstant('DBIERR_OSINT24FAIL',DBIERR_OSINT24FAIL);
      AddConstant('DBIERR_OSDRIVENOTREADY',DBIERR_OSDRIVENOTREADY);
      AddConstant('DBIERR_NOTEXACT',DBIERR_NOTEXACT);
      AddConstant('DBIERR_OSUNKNOWNSRVERR',DBIERR_OSUNKNOWNSRVERR);
      AddConstant('DBIERR_SERVERNOMEMORY',DBIERR_SERVERNOMEMORY);
      AddConstant('DBIERR_OSALREADYLOCKED',DBIERR_OSALREADYLOCKED);
      AddConstant('DBIERR_OSNOTLOCKED',DBIERR_OSNOTLOCKED);
      AddConstant('DBIERR_NOSERVERSW',DBIERR_NOSERVERSW);
      AddConstant('ERRCODE_NETINITERR',ERRCODE_NETINITERR);
      AddConstant('ERRCODE_NETUSERLIMIT',ERRCODE_NETUSERLIMIT);
      AddConstant('ERRCODE_NETFILEVERSION',ERRCODE_NETFILEVERSION);
      AddConstant('ERRCODE_NETFILELOCKED',ERRCODE_NETFILELOCKED);
      AddConstant('ERRCODE_DIRNOTPRIVATE',ERRCODE_DIRNOTPRIVATE);
      AddConstant('ERRCODE_NETMULTIPLE',ERRCODE_NETMULTIPLE);
      AddConstant('ERRCODE_NETUNKNOWN',ERRCODE_NETUNKNOWN);
      AddConstant('ERRCODE_SHAREDFILE',ERRCODE_SHAREDFILE);
      AddConstant('ERRCODE_SHARENOTLOADED',ERRCODE_SHARENOTLOADED);
      AddConstant('ERRCODE_NOTONANETWORK',ERRCODE_NOTONANETWORK);
      AddConstant('ERRCODE_SQLCOMMLOST',ERRCODE_SQLCOMMLOST);
      AddConstant('ERRCODE_SERVERCOMMLOST',ERRCODE_SERVERCOMMLOST);
      AddConstant('ERRCODE_SQLSERVERNOTFOUND',ERRCODE_SQLSERVERNOTFOUND);
      AddConstant('ERRCODE_SERVERNOTFOUND',ERRCODE_SERVERNOTFOUND);
      AddConstant('DBIERR_NETINITERR',DBIERR_NETINITERR);
      AddConstant('DBIERR_NETUSERLIMIT',DBIERR_NETUSERLIMIT);
      AddConstant('DBIERR_NETFILEVERSION',DBIERR_NETFILEVERSION);
      AddConstant('DBIERR_NETFILELOCKED',DBIERR_NETFILELOCKED);
      AddConstant('DBIERR_DIRNOTPRIVATE',DBIERR_DIRNOTPRIVATE);
      AddConstant('DBIERR_NETMULTIPLE',DBIERR_NETMULTIPLE);
      AddConstant('DBIERR_NETUNKNOWN',DBIERR_NETUNKNOWN);
      AddConstant('DBIERR_SHAREDFILE',DBIERR_SHAREDFILE);
      AddConstant('DBIERR_SHARENOTLOADED',DBIERR_SHARENOTLOADED);
      AddConstant('DBIERR_NOTONANETWORK',DBIERR_NOTONANETWORK);
      AddConstant('DBIERR_SQLCOMMLOST',DBIERR_SQLCOMMLOST);
      AddConstant('DBIERR_SERVERCOMMLOST',DBIERR_SERVERCOMMLOST);
      AddConstant('DBIERR_SQLSERVERNOTFOUND',DBIERR_SQLSERVERNOTFOUND);
      AddConstant('DBIERR_SERVERNOTFOUND',DBIERR_SERVERNOTFOUND);
      AddConstant('ERRCODE_WRONGDRVNAME',ERRCODE_WRONGDRVNAME);
      AddConstant('ERRCODE_WRONGSYSVER',ERRCODE_WRONGSYSVER);
      AddConstant('ERRCODE_WRONGDRVVER',ERRCODE_WRONGDRVVER);
      AddConstant('ERRCODE_WRONGDRVTYPE',ERRCODE_WRONGDRVTYPE);
      AddConstant('ERRCODE_CANNOTLOADDRV',ERRCODE_CANNOTLOADDRV);
      AddConstant('ERRCODE_CANNOTLOADLDDRV',ERRCODE_CANNOTLOADLDDRV);
      AddConstant('ERRCODE_VENDINITFAIL',ERRCODE_VENDINITFAIL);
      AddConstant('ERRCODE_DRIVERRESTRICTED',ERRCODE_DRIVERRESTRICTED);
      AddConstant('DBIERR_WRONGDRVNAME',DBIERR_WRONGDRVNAME);
      AddConstant('DBIERR_WRONGSYSVER',DBIERR_WRONGSYSVER);
      AddConstant('DBIERR_WRONGDRVVER',DBIERR_WRONGDRVVER);
      AddConstant('DBIERR_WRONGDRVTYPE',DBIERR_WRONGDRVTYPE);
      AddConstant('DBIERR_CANNOTLOADDRV',DBIERR_CANNOTLOADDRV);
      AddConstant('DBIERR_CANNOTLOADLDDRV',DBIERR_CANNOTLOADLDDRV);
      AddConstant('DBIERR_VENDINITFAIL',DBIERR_VENDINITFAIL);
      AddConstant('DBIERR_DRIVERRESTRICTED',DBIERR_DRIVERRESTRICTED);
      AddConstant('DBICODE_AMBJOASY',DBICODE_AMBJOASY);
      AddConstant('DBICODE_AMBJOSYM',DBICODE_AMBJOSYM);
      AddConstant('DBICODE_AMBOUTEX',DBICODE_AMBOUTEX);
      AddConstant('DBICODE_AMBOUTPR',DBICODE_AMBOUTPR);
      AddConstant('DBICODE_AMBSYMAS',DBICODE_AMBSYMAS);
      AddConstant('DBICODE_ASETOPER',DBICODE_ASETOPER);
      AddConstant('DBICODE_AVENUMDA',DBICODE_AVENUMDA);
      AddConstant('DBICODE_BADEXPR1',DBICODE_BADEXPR1);
      AddConstant('DBICODE_BADFLDOR',DBICODE_BADFLDOR);
      AddConstant('DBICODE_BADVNAME',DBICODE_BADVNAME);
      AddConstant('DBICODE_BITMAPER',DBICODE_BITMAPER);
      AddConstant('DBICODE_CALCBADR',DBICODE_CALCBADR);
      AddConstant('DBICODE_CALCTYPE',DBICODE_CALCTYPE);
      AddConstant('DBICODE_CHGTO1TI',DBICODE_CHGTO1TI);
      AddConstant('DBICODE_CHGTOCHG',DBICODE_CHGTOCHG);
      AddConstant('DBICODE_CHGTOEXP',DBICODE_CHGTOEXP);
      AddConstant('DBICODE_CHGTOINS',DBICODE_CHGTOINS);
      AddConstant('DBICODE_CHGTONEW',DBICODE_CHGTONEW);
      AddConstant('DBICODE_CHGTOVAL',DBICODE_CHGTOVAL);
      AddConstant('DBICODE_CHKMRKFI',DBICODE_CHKMRKFI);
      AddConstant('DBICODE_CHNAMBIG',DBICODE_CHNAMBIG);
      AddConstant('DBICODE_CHUNKERR',DBICODE_CHUNKERR);
      AddConstant('DBICODE_COLUM255',DBICODE_COLUM255);
      AddConstant('DBICODE_CONAFTAS',DBICODE_CONAFTAS);
      AddConstant('DBICODE_DEL1TIME',DBICODE_DEL1TIME);
      AddConstant('DBICODE_DELAMBIG',DBICODE_DELAMBIG);
      AddConstant('DBICODE_DELFRDEL',DBICODE_DELFRDEL);
      AddConstant('DBICODE_EGFLDTYP',DBICODE_EGFLDTYP);
      AddConstant('DBICODE_EXAMINOR',DBICODE_EXAMINOR);
      AddConstant('DBICODE_EXPRTYPS',DBICODE_EXPRTYPS);
      AddConstant('DBICODE_EXTRACOM',DBICODE_EXTRACOM);
      AddConstant('DBICODE_EXTRAORO',DBICODE_EXTRAORO);
      AddConstant('DBICODE_EXTRAQRO',DBICODE_EXTRAQRO);
      AddConstant('DBICODE_FIND1ATT',DBICODE_FIND1ATT);
      AddConstant('DBICODE_FINDANST',DBICODE_FINDANST);
      AddConstant('DBICODE_GRPNOSET',DBICODE_GRPNOSET);
      AddConstant('DBICODE_GRPSTROW',DBICODE_GRPSTROW);
      AddConstant('DBICODE_IDFINLCO',DBICODE_IDFINLCO);
      AddConstant('DBICODE_IDFPERLI',DBICODE_IDFPERLI);
      AddConstant('DBICODE_INANEXPR',DBICODE_INANEXPR);
      AddConstant('DBICODE_INS1TIME',DBICODE_INS1TIME);
      AddConstant('DBICODE_INSAMBIG',DBICODE_INSAMBIG);
      AddConstant('DBICODE_INSDELCH',DBICODE_INSDELCH);
      AddConstant('DBICODE_INSEXPRR',DBICODE_INSEXPRR);
      AddConstant('DBICODE_INSTOINS',DBICODE_INSTOINS);
      AddConstant('DBICODE_ISARRAY',DBICODE_ISARRAY);
      AddConstant('DBICODE_LABELERR',DBICODE_LABELERR);
      AddConstant('DBICODE_LINKCALC',DBICODE_LINKCALC);
      AddConstant('DBICODE_LNGVNAME',DBICODE_LNGVNAME);
      AddConstant('DBICODE_LONGQURY',DBICODE_LONGQURY);
      AddConstant('DBICODE_MEMVPROC',DBICODE_MEMVPROC);
      AddConstant('DBICODE_MISNGCOM',DBICODE_MISNGCOM);
      AddConstant('DBICODE_MISNGRPA',DBICODE_MISNGRPA);
      AddConstant('DBICODE_MISSRTQU',DBICODE_MISSRTQU);
      AddConstant('DBICODE_NAMTWICE',DBICODE_NAMTWICE);
      AddConstant('DBICODE_NOCHKMAR',DBICODE_NOCHKMAR);
      AddConstant('DBICODE_NODEFOCC',DBICODE_NODEFOCC);
      AddConstant('DBICODE_NOGROUPS',DBICODE_NOGROUPS);
      AddConstant('DBICODE_NONSENSE',DBICODE_NONSENSE);
      AddConstant('DBICODE_NOPATTER',DBICODE_NOPATTER);
      AddConstant('DBICODE_NOSUCHDA',DBICODE_NOSUCHDA);
      AddConstant('DBICODE_NOVALUE',DBICODE_NOVALUE);
      AddConstant('DBICODE_ONLYCONS',DBICODE_ONLYCONS);
      AddConstant('DBICODE_ONLYSETR',DBICODE_ONLYSETR);
      AddConstant('DBICODE_OUTSENS1',DBICODE_OUTSENS1);
      AddConstant('DBICODE_OUTTWIC1',DBICODE_OUTTWIC1);
      AddConstant('DBICODE_PAROWCNT',DBICODE_PAROWCNT);
      AddConstant('DBICODE_PERSEPAR',DBICODE_PERSEPAR);
      AddConstant('DBICODE_PROCPLSW',DBICODE_PROCPLSW);
      AddConstant('DBICODE_PWINSRTS',DBICODE_PWINSRTS);
      AddConstant('DBICODE_PWMODRTS',DBICODE_PWMODRTS);
      AddConstant('DBICODE_QBEFLDFOUND',DBICODE_QBEFLDFOUND);
      AddConstant('DBICODE_QBENOFENCE',DBICODE_QBENOFENCE);
      AddConstant('DBICODE_QBENOFENCET',DBICODE_QBENOFENCET);
      AddConstant('DBICODE_QBENOHEADERT',DBICODE_QBENOHEADERT);
      AddConstant('DBICODE_QBENOTAB',DBICODE_QBENOTAB);
      AddConstant('DBICODE_QBENUMCOLS',DBICODE_QBENUMCOLS);
      AddConstant('DBICODE_QBEOPENTAB',DBICODE_QBEOPENTAB);
      AddConstant('DBICODE_QBETWICE',DBICODE_QBETWICE);
      AddConstant('DBICODE_QRYNOANSWER',DBICODE_QRYNOANSWER);
      AddConstant('DBICODE_QRYNOTPREP',DBICODE_QRYNOTPREP);
      AddConstant('DBICODE_QUAINDEL',DBICODE_QUAINDEL);
      AddConstant('DBICODE_QUAININS',DBICODE_QUAININS);
      AddConstant('DBICODE_RAGININS',DBICODE_RAGININS);
      AddConstant('DBICODE_RAGINSET',DBICODE_RAGINSET);
      AddConstant('DBICODE_ROWUSERR',DBICODE_ROWUSERR);
      AddConstant('DBICODE_SETEXPEC',DBICODE_SETEXPEC);
      AddConstant('DBICODE_SETVAMB1',DBICODE_SETVAMB1);
      AddConstant('DBICODE_SETVBAD1',DBICODE_SETVBAD1);
      AddConstant('DBICODE_SETVDEF1',DBICODE_SETVDEF1);
      AddConstant('DBICODE_SUMNUMBE',DBICODE_SUMNUMBE);
      AddConstant('DBICODE_TBLISWP3',DBICODE_TBLISWP3);
      AddConstant('DBICODE_TOKENNOT',DBICODE_TOKENNOT);
      AddConstant('DBICODE_TWOOUTR1',DBICODE_TWOOUTR1);
      AddConstant('DBICODE_TYPEMISM',DBICODE_TYPEMISM);
      AddConstant('DBICODE_UNRELQ1',DBICODE_UNRELQ1);
      AddConstant('DBICODE_UNUSEDST',DBICODE_UNUSEDST);
      AddConstant('DBICODE_USEINSDE',DBICODE_USEINSDE);
      AddConstant('DBICODE_USEOFCHG',DBICODE_USEOFCHG);
      AddConstant('DBICODE_VARMUSTF',DBICODE_VARMUSTF);
      AddConstant('DBICODE_REGISTER',DBICODE_REGISTER);
      AddConstant('DBICODE_LONGEXPR',DBICODE_LONGEXPR);
      AddConstant('DBICODE_REFRESH',DBICODE_REFRESH);
      AddConstant('DBICODE_CANCEXCEPT',DBICODE_CANCEXCEPT);
      AddConstant('DBICODE_DBEXCEPT',DBICODE_DBEXCEPT);
      AddConstant('DBICODE_MEMEXCEPT',DBICODE_MEMEXCEPT);
      AddConstant('DBICODE_FATALEXCEPT',DBICODE_FATALEXCEPT);
      AddConstant('DBICODE_QRYNIY',DBICODE_QRYNIY);
      AddConstant('DBICODE_BADFORMAT',DBICODE_BADFORMAT);
      AddConstant('DBICODE_QRYEMPTY',DBICODE_QRYEMPTY);
      AddConstant('DBICODE_NOQRYTOPREP',DBICODE_NOQRYTOPREP);
      AddConstant('DBICODE_BUFFTOOSMALL',DBICODE_BUFFTOOSMALL);
      AddConstant('DBICODE_QRYNOTPARSE',DBICODE_QRYNOTPARSE);
      AddConstant('DBICODE_NOTHANDLE',DBICODE_NOTHANDLE);
      AddConstant('DBICODE_QRYSYNTERR',DBICODE_QRYSYNTERR);
      AddConstant('DBICODE_QXFLDCOUNT',DBICODE_QXFLDCOUNT);
      AddConstant('DBICODE_QXFLDSYMNOTFOUND',DBICODE_QXFLDSYMNOTFOUND);
      AddConstant('DBICODE_QXTBLSYMNOTFOUND',DBICODE_QXTBLSYMNOTFOUND);
      AddConstant('DBICODE_BLOBTERM',DBICODE_BLOBTERM);
      AddConstant('DBICODE_BLOBERR',DBICODE_BLOBERR);
      AddConstant('DBICODE_RESTARTQRY',DBICODE_RESTARTQRY);
      AddConstant('DBICODE_UNKNOWNANSTYPE',DBICODE_UNKNOWNANSTYPE);
      AddConstant('DBICODE_SQLG_MDIST',DBICODE_SQLG_MDIST);
      AddConstant('DBICODE_SQLG_NOARI',DBICODE_SQLG_NOARI);
      AddConstant('DBICODE_SQLG_LIKEN',DBICODE_SQLG_LIKEN);
      AddConstant('DBICODE_SQLG_ALPHO',DBICODE_SQLG_ALPHO);
      AddConstant('DBICODE_SQLG_DATEO',DBICODE_SQLG_DATEO);
      AddConstant('DBICODE_SQLG_RELOP',DBICODE_SQLG_RELOP);
      AddConstant('DBICODE_SQLG_ONLYC',DBICODE_SQLG_ONLYC);
      AddConstant('DBICODE_SQLG_CNTLN',DBICODE_SQLG_CNTLN);
      AddConstant('DBICODE_SQLG_CHINI',DBICODE_SQLG_CHINI);
      AddConstant('DBICODE_SQLG_UNION',DBICODE_SQLG_UNION);
      AddConstant('DBICODE_SQLG_SLFIN',DBICODE_SQLG_SLFIN);
      AddConstant('DBICODE_SQLG_OTJVR',DBICODE_SQLG_OTJVR);
      AddConstant('DBICODE_SQLG_STROW',DBICODE_SQLG_STROW);
      AddConstant('DBICODE_SQLG_QUANT',DBICODE_SQLG_QUANT);
      AddConstant('DBICODE_SQLG_REGSO',DBICODE_SQLG_REGSO);
      AddConstant('DBICODE_SQLG_COUNT',DBICODE_SQLG_COUNT);
      AddConstant('DBICODE_SQLG_AVERA',DBICODE_SQLG_AVERA);
      AddConstant('DBICODE_SQLG_DATEA',DBICODE_SQLG_DATEA);
      AddConstant('DBICODE_SQLG_BADPT',DBICODE_SQLG_BADPT);
      AddConstant('DBICODE_SQLG_RELPA',DBICODE_SQLG_RELPA);
      AddConstant('DBICODE_SQLG_PATRN',DBICODE_SQLG_PATRN);
      AddConstant('DBICODE_SQLG_FNDSU',DBICODE_SQLG_FNDSU);
      AddConstant('DBICODE_SQLG_IFDCS',DBICODE_SQLG_IFDCS);
      AddConstant('DBICODE_SQLG_IDCCO',DBICODE_SQLG_IDCCO);
      AddConstant('DBICODE_SQLG_ONLYI',DBICODE_SQLG_ONLYI);
      AddConstant('DBICODE_SQLG_SQLDIALECT',DBICODE_SQLG_SQLDIALECT);
      AddConstant('DBICODE_SQLG_NOQUERY',DBICODE_SQLG_NOQUERY);
      AddConstant('DBICODE_BLOBGROUP',DBICODE_BLOBGROUP);
      AddConstant('DBICODE_QRYNOPROP',DBICODE_QRYNOPROP);
      AddConstant('DBICODE_ANSTYPNOTSUP',DBICODE_ANSTYPNOTSUP);
      AddConstant('DBICODE_ANSALIASNOTSUP',DBICODE_ANSALIASNOTSUP);
      AddConstant('DBICODE_INSBLOBREQ',DBICODE_INSBLOBREQ);
      AddConstant('DBICODE_CHGUNIQUENDXREQ',DBICODE_CHGUNIQUENDXREQ);
      AddConstant('DBICODE_DELUNIQUENDXREQ',DBICODE_DELUNIQUENDXREQ);
      AddConstant('DBICODE_SQLNOFULLUPDATE',DBICODE_SQLNOFULLUPDATE);
      AddConstant('DBICODE_CANTEXECREMOTE',DBICODE_CANTEXECREMOTE);
      AddConstant('DBICODE_UNEXPECTEDEOC',DBICODE_UNEXPECTEDEOC);
      AddConstant('DBICODE_SQLPARAMNOTSET',DBICODE_SQLPARAMNOTSET);
      AddConstant('DBICODE_QUERYTOOLONG',DBICODE_QUERYTOOLONG);
      AddConstant('DBICODE_NOSUCHRELORALIAS',DBICODE_NOSUCHRELORALIAS);
      AddConstant('DBICODE_TYPEAMBIGUITY',DBICODE_TYPEAMBIGUITY);
      AddConstant('DBICODE_ORDERBYNOTAPROJ',DBICODE_ORDERBYNOTAPROJ);
      AddConstant('DBICODE_SQLPARSE',DBICODE_SQLPARSE);
      AddConstant('DBICODE_CONSTRAINTFAILED',DBICODE_CONSTRAINTFAILED);
      AddConstant('DBICODE_NOTGROUPINGFIELD',DBICODE_NOTGROUPINGFIELD);
      AddConstant('DBICODE_UDFNOTDEFINED',DBICODE_UDFNOTDEFINED);
      AddConstant('DBICODE_UDFERROR',DBICODE_UDFERROR);
      AddConstant('DBICODE_SINGLEROWERROR',DBICODE_SINGLEROWERROR);
      AddConstant('DBICODE_GROUPEXPR',DBICODE_GROUPEXPR);
      AddConstant('DBICODE_QUERYTEXT',DBICODE_QUERYTEXT);
      AddConstant('DBICODE_ANSIJOINSUP',DBICODE_ANSIJOINSUP);
      AddConstant('DBICODE_DISTUNION',DBICODE_DISTUNION);
      AddConstant('DBICODE_GROUPBYREQ',DBICODE_GROUPBYREQ);
      AddConstant('DBICODE_INSUPDAUTOIC',DBICODE_INSUPDAUTOIC);
      AddConstant('DBICODE_UPDREFINTSINGLE',DBICODE_UPDREFINTSINGLE);
      AddConstant('DBICODE_NOMSACCESS',DBICODE_NOMSACCESS);
      AddConstant('DBICODE_FIELDCONSTPREP',DBICODE_FIELDCONSTPREP);
      AddConstant('DBICODE_FIELDDEFPREP',DBICODE_FIELDDEFPREP);
      AddConstant('DBICODE_RECCONSTPREP',DBICODE_RECCONSTPREP);
      AddConstant('DBICODE_TOOFEWSUBEXPR',DBICODE_TOOFEWSUBEXPR);
      AddConstant('DBICODE_TOOMANYSUBEXPR',DBICODE_TOOMANYSUBEXPR);
      AddConstant('DBICODE_INVALIDNODETYPE',DBICODE_INVALIDNODETYPE);
      AddConstant('DBICODE_BOOLEXPR',DBICODE_BOOLEXPR);
      AddConstant('DBICODE_NONBOOLEXPR',DBICODE_NONBOOLEXPR);
      AddConstant('DBICODE_NOOUTERJOIN',DBICODE_NOOUTERJOIN);
      AddConstant('DBICODE_USERCONSTRERR',DBICODE_USERCONSTRERR);
      AddConstant('DBIERR_AMBJOASY',DBIERR_AMBJOASY);
      AddConstant('DBIERR_AMBJOSYM',DBIERR_AMBJOSYM);
      AddConstant('DBIERR_AMBOUTEX',DBIERR_AMBOUTEX);
      AddConstant('DBIERR_AMBOUTPR',DBIERR_AMBOUTPR);
      AddConstant('DBIERR_AMBSYMAS',DBIERR_AMBSYMAS);
      AddConstant('DBIERR_ASETOPER',DBIERR_ASETOPER);
      AddConstant('DBIERR_AVENUMDA',DBIERR_AVENUMDA);
      AddConstant('DBIERR_BADEXPR1',DBIERR_BADEXPR1);
      AddConstant('DBIERR_BADFLDOR',DBIERR_BADFLDOR);
      AddConstant('DBIERR_BADVNAME',DBIERR_BADVNAME);
      AddConstant('DBIERR_BITMAPER',DBIERR_BITMAPER);
      AddConstant('DBIERR_CALCBADR',DBIERR_CALCBADR);
      AddConstant('DBIERR_CALCTYPE',DBIERR_CALCTYPE);
      AddConstant('DBIERR_CHGTO1TI',DBIERR_CHGTO1TI);
      AddConstant('DBIERR_CHGTOCHG',DBIERR_CHGTOCHG);
      AddConstant('DBIERR_CHGTOEXP',DBIERR_CHGTOEXP);
      AddConstant('DBIERR_CHGTOINS',DBIERR_CHGTOINS);
      AddConstant('DBIERR_CHGTONEW',DBIERR_CHGTONEW);
    end;
  end;

begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('ErrCat',1,tkInteger,nil,__ErrCat,false,0);
    DefineMethod('ErrCode',1,tkInteger,nil,__ErrCode,false,0);
    DefineMethod('DbiExit',0,tkInteger,nil,__DbiExit,false,0);
    DefineMethod('DbiDLLExit',0,tkInteger,nil,__DbiDLLExit,false,0);
    DefineMethod('DbiGetSysVersion',1,tkInteger,nil,__DbiGetSysVersion,false,0).SetVarArgs([0]);
    DefineMethod('DbiGetSysConfig',1,tkInteger,nil,__DbiGetSysConfig,false,0).SetVarArgs([0]);
    DefineMethod('DbiGetClientInfo',1,tkInteger,nil,__DbiGetClientInfo,false,0).SetVarArgs([0]);
    DefineMethod('DbiGetSysInfo',1,tkInteger,nil,__DbiGetSysInfo,false,0).SetVarArgs([0]);
    DefineMethod('DbiLoadDriver',1,tkInteger,nil,__DbiLoadDriver,false,0);
    DefineMethod('DbiGetSesInfo',1,tkInteger,nil,__DbiGetSesInfo,false,0).SetVarArgs([0]);
    DefineMethod('DbiSetPrivateDir',1,tkInteger,nil,__DbiSetPrivateDir,false,0);
    DefineMethod('DbiGetDriverDesc',2,tkInteger,nil,__DbiGetDriverDesc,false,0).SetVarArgs([1]);
    DefineMethod('DbiGetTableTypeDesc',3,tkInteger,nil,__DbiGetTableTypeDesc,false,0).SetVarArgs([2]);
    DefineMethod('DbiGetFieldTypeDesc',4,tkInteger,nil,__DbiGetFieldTypeDesc,false,0).SetVarArgs([3]);
    DefineMethod('DbiGetIndexTypeDesc',3,tkInteger,nil,__DbiGetIndexTypeDesc,false,0).SetVarArgs([2]);
    DefineMethod('DbiCheckRefresh',0,tkInteger,nil,__DbiCheckRefresh,false,0);
    DefineMethod('DbiSetLockRetry',1,tkInteger,nil,__DbiSetLockRetry,false,0);
    DefineMethod('DbiGetErrorEntry',3,tkInteger,nil,__DbiGetErrorEntry,false,0).SetVarArgs([1]);
    DefineMethod('DbiGetErrorInfo',2,tkInteger,nil,__DbiGetErrorInfo,false,0).SetVarArgs([1]);
    DefineMethod('DbiGetErrorString',2,tkInteger,nil,__DbiGetErrorString,false,0);
    DefineMethod('DbiGetErrorContext',2,tkInteger,nil,__DbiGetErrorContext,false,0);
    DefineMethod('DbiDateEncode',4,tkInteger,nil,__DbiDateEncode,false,0).SetVarArgs([3]);
    DefineMethod('DbiDateDecode',4,tkInteger,nil,__DbiDateDecode,false,0).SetVarArgs([1,2,3]);
    DefineMethod('DbiTimeEncode',4,tkInteger,nil,__DbiTimeEncode,false,0).SetVarArgs([3]);
    DefineMethod('DbiTimeDecode',4,tkInteger,nil,__DbiTimeDecode,false,0).SetVarArgs([1,2,3]);
    DefineMethod('DbiTimeStampEncode',3,tkInteger,nil,__DbiTimeStampEncode,false,0).SetVarArgs([2]);
    DefineMethod('DbiTimeStampDecode',3,tkInteger,nil,__DbiTimeStampDecode,false,0).SetVarArgs([1,2]);
    DefineMethod('DbiBcdFromFloat',4,tkInteger,nil,__DbiBcdFromFloat,false,0).SetVarArgs([0,3]);
    DefineMethod('DbiBcdToFloat',2,tkInteger,nil,__DbiBcdToFloat,false,0).SetVarArgs([0,1]);
    DefineMethod('DbiGetDateFormat',1,tkInteger,nil,__DbiGetDateFormat,false,0).SetVarArgs([0]);
    DefineMethod('DbiSetDateFormat',1,tkInteger,nil,__DbiSetDateFormat,false,0).SetVarArgs([0]);
    DefineMethod('DbiGetTimeFormat',1,tkInteger,nil,__DbiGetTimeFormat,false,0).SetVarArgs([0]);
    DefineMethod('DbiSetTimeFormat',1,tkInteger,nil,__DbiSetTimeFormat,false,0).SetVarArgs([0]);
    DefineMethod('DbiGetNumberFormat',1,tkInteger,nil,__DbiGetNumberFormat,false,0).SetVarArgs([0]);
    DefineMethod('DbiSetNumberFormat',1,tkInteger,nil,__DbiSetNumberFormat,false,0).SetVarArgs([0]);
    DefineMethod('DbiUseIdleTime',0,tkInteger,nil,__DbiUseIdleTime,false,0);
    DefineMethod('DbiGetLdName',3,tkInteger,nil,__DbiGetLdName,false,0);
    DefineMethod('DbiAddPassword',1,tkInteger,nil,__DbiAddPassword,false,0);
    DefineMethod('DbiDropPassword',1,tkInteger,nil,__DbiDropPassword,false,0);
    DefineMethod('DbiGetNetUserName',1,tkInteger,nil,__DbiGetNetUserName,false,0);
    DefineMethod('DbiDebugLayerOptions',2,tkInteger,nil,__DbiDebugLayerOptions,false,0);
    DefineMethod('OsLdInit',2,tkInteger,nil,__OsLdInit,false,0);
    DefineMethod('OsLdExit',0,tkInteger,nil,__OsLdExit,false,0);
    DefineMethod('OsLdSetConvChars',2,tkInteger,nil,__OsLdSetConvChars,false,0);
    DefineMethod('DbiDRDelete',1,tkInteger,nil,__DbiDRDelete,false,0);
    DefineMethod('DbiDRDrop',1,tkInteger,nil,__DbiDRDrop,false,0);
    DefineMethod('DbiSetDefaultRepository',1,tkInteger,nil,__DbiSetDefaultRepository,false,0);
    DefineMethod('DbiGetDefaultRepository',1,tkInteger,nil,__DbiGetDefaultRepository,false,0);
    AddConsts1;
    AddConsts2;
    AddConsts3;
    AddConstant('DBIERR_CHGTOVAL',DBIERR_CHGTOVAL);
    AddConstant('DBIERR_CHKMRKFI',DBIERR_CHKMRKFI);
    AddConstant('DBIERR_CHNAMBIG',DBIERR_CHNAMBIG);
    AddConstant('DBIERR_CHUNKERR',DBIERR_CHUNKERR);
    AddConstant('DBIERR_COLUM255',DBIERR_COLUM255);
    AddConstant('DBIERR_CONAFTAS',DBIERR_CONAFTAS);
    AddConstant('DBIERR_DEL1TIME',DBIERR_DEL1TIME);
    AddConstant('DBIERR_DELAMBIG',DBIERR_DELAMBIG);
    AddConstant('DBIERR_DELFRDEL',DBIERR_DELFRDEL);
    AddConstant('DBIERR_EGFLDTYP',DBIERR_EGFLDTYP);
    AddConstant('DBIERR_EXAMINOR',DBIERR_EXAMINOR);
    AddConstant('DBIERR_EXPRTYPS',DBIERR_EXPRTYPS);
    AddConstant('DBIERR_EXTRACOM',DBIERR_EXTRACOM);
    AddConstant('DBIERR_EXTRAORO',DBIERR_EXTRAORO);
    AddConstant('DBIERR_EXTRAQRO',DBIERR_EXTRAQRO);
    AddConstant('DBIERR_FIND1ATT',DBIERR_FIND1ATT);
    AddConstant('DBIERR_FINDANST',DBIERR_FINDANST);
    AddConstant('DBIERR_GRPNOSET',DBIERR_GRPNOSET);
    AddConstant('DBIERR_GRPSTROW',DBIERR_GRPSTROW);
    AddConstant('DBIERR_IDFINLCO',DBIERR_IDFINLCO);
    AddConstant('DBIERR_IDFPERLI',DBIERR_IDFPERLI);
    AddConstant('DBIERR_INANEXPR',DBIERR_INANEXPR);
    AddConstant('DBIERR_INS1TIME',DBIERR_INS1TIME);
    AddConstant('DBIERR_INSAMBIG',DBIERR_INSAMBIG);
    AddConstant('DBIERR_INSDELCH',DBIERR_INSDELCH);
    AddConstant('DBIERR_INSEXPRR',DBIERR_INSEXPRR);
    AddConstant('DBIERR_INSTOINS',DBIERR_INSTOINS);
    AddConstant('DBIERR_ISARRAY',DBIERR_ISARRAY);
    AddConstant('DBIERR_LABELERR',DBIERR_LABELERR);
    AddConstant('DBIERR_LINKCALC',DBIERR_LINKCALC);
    AddConstant('DBIERR_LNGVNAME',DBIERR_LNGVNAME);
    AddConstant('DBIERR_LONGQURY',DBIERR_LONGQURY);
    AddConstant('DBIERR_MEMVPROC',DBIERR_MEMVPROC);
    AddConstant('DBIERR_MISNGCOM',DBIERR_MISNGCOM);
    AddConstant('DBIERR_MISNGRPA',DBIERR_MISNGRPA);
    AddConstant('DBIERR_MISSRTQU',DBIERR_MISSRTQU);
    AddConstant('DBIERR_NAMTWICE',DBIERR_NAMTWICE);
    AddConstant('DBIERR_NOCHKMAR',DBIERR_NOCHKMAR);
    AddConstant('DBIERR_NODEFOCC',DBIERR_NODEFOCC);
    AddConstant('DBIERR_NOGROUPS',DBIERR_NOGROUPS);
    AddConstant('DBIERR_NONSENSE',DBIERR_NONSENSE);
    AddConstant('DBIERR_NOPATTER',DBIERR_NOPATTER);
    AddConstant('DBIERR_NOSUCHDA',DBIERR_NOSUCHDA);
    AddConstant('DBIERR_NOVALUE',DBIERR_NOVALUE);
    AddConstant('DBIERR_ONLYCONS',DBIERR_ONLYCONS);
    AddConstant('DBIERR_ONLYSETR',DBIERR_ONLYSETR);
    AddConstant('DBIERR_OUTSENS1',DBIERR_OUTSENS1);
    AddConstant('DBIERR_OUTTWIC1',DBIERR_OUTTWIC1);
    AddConstant('DBIERR_PAROWCNT',DBIERR_PAROWCNT);
    AddConstant('DBIERR_PERSEPAR',DBIERR_PERSEPAR);
    AddConstant('DBIERR_PROCPLSW',DBIERR_PROCPLSW);
    AddConstant('DBIERR_PWINSRTS',DBIERR_PWINSRTS);
    AddConstant('DBIERR_PWMODRTS',DBIERR_PWMODRTS);
    AddConstant('DBIERR_QBEFLDFOUND',DBIERR_QBEFLDFOUND);
    AddConstant('DBIERR_QBENOFENCE',DBIERR_QBENOFENCE);
    AddConstant('DBIERR_QBENOFENCET',DBIERR_QBENOFENCET);
    AddConstant('DBIERR_QBENOHEADERT',DBIERR_QBENOHEADERT);
    AddConstant('DBIERR_QBENOTAB',DBIERR_QBENOTAB);
    AddConstant('DBIERR_QBENUMCOLS',DBIERR_QBENUMCOLS);
    AddConstant('DBIERR_QBEOPENTAB',DBIERR_QBEOPENTAB);
    AddConstant('DBIERR_QBETWICE',DBIERR_QBETWICE);
    AddConstant('DBIERR_QRYNOANSWER',DBIERR_QRYNOANSWER);
    AddConstant('DBIERR_QRYNOTPREP',DBIERR_QRYNOTPREP);
    AddConstant('DBIERR_QUAINDEL',DBIERR_QUAINDEL);
    AddConstant('DBIERR_QUAININS',DBIERR_QUAININS);
    AddConstant('DBIERR_RAGININS',DBIERR_RAGININS);
    AddConstant('DBIERR_RAGINSET',DBIERR_RAGINSET);
    AddConstant('DBIERR_ROWUSERR',DBIERR_ROWUSERR);
    AddConstant('DBIERR_SETEXPEC',DBIERR_SETEXPEC);
    AddConstant('DBIERR_SETVAMB1',DBIERR_SETVAMB1);
    AddConstant('DBIERR_SETVBAD1',DBIERR_SETVBAD1);
    AddConstant('DBIERR_SETVDEF1',DBIERR_SETVDEF1);
    AddConstant('DBIERR_SUMNUMBE',DBIERR_SUMNUMBE);
    AddConstant('DBIERR_TBLISWP3',DBIERR_TBLISWP3);
    AddConstant('DBIERR_TOKENNOT',DBIERR_TOKENNOT);
    AddConstant('DBIERR_TWOOUTR1',DBIERR_TWOOUTR1);
    AddConstant('DBIERR_TYPEMISM',DBIERR_TYPEMISM);
    AddConstant('DBIERR_UNRELQ1',DBIERR_UNRELQ1);
    AddConstant('DBIERR_UNUSEDST',DBIERR_UNUSEDST);
    AddConstant('DBIERR_USEINSDE',DBIERR_USEINSDE);
    AddConstant('DBIERR_USEOFCHG',DBIERR_USEOFCHG);
    AddConstant('DBIERR_VARMUSTF',DBIERR_VARMUSTF);
    AddConstant('DBIERR_REGISTER',DBIERR_REGISTER);
    AddConstant('DBIERR_LONGEXPR',DBIERR_LONGEXPR);
    AddConstant('DBIERR_REFRESH',DBIERR_REFRESH);
    AddConstant('DBIERR_CANCEXCEPT',DBIERR_CANCEXCEPT);
    AddConstant('DBIERR_DBEXCEPT',DBIERR_DBEXCEPT);
    AddConstant('DBIERR_MEMEXCEPT',DBIERR_MEMEXCEPT);
    AddConstant('DBIERR_FATALEXCEPT',DBIERR_FATALEXCEPT);
    AddConstant('DBIERR_QRYNIY',DBIERR_QRYNIY);
    AddConstant('DBIERR_BADFORMAT',DBIERR_BADFORMAT);
    AddConstant('DBIERR_QRYEMPTY',DBIERR_QRYEMPTY);
    AddConstant('DBIERR_NOQRYTOPREP',DBIERR_NOQRYTOPREP);
    AddConstant('DBIERR_BUFFTOOSMALL',DBIERR_BUFFTOOSMALL);
    AddConstant('DBIERR_QRYNOTPARSE',DBIERR_QRYNOTPARSE);
    AddConstant('DBIERR_NOTHANDLE',DBIERR_NOTHANDLE);
    AddConstant('DBIERR_QRYSYNTERR',DBIERR_QRYSYNTERR);
    AddConstant('DBIERR_QXFLDCOUNT',DBIERR_QXFLDCOUNT);
    AddConstant('DBIERR_QXFLDSYMNOTFOUND',DBIERR_QXFLDSYMNOTFOUND);
    AddConstant('DBIERR_QXTBLSYMNOTFOUND',DBIERR_QXTBLSYMNOTFOUND);
    AddConstant('DBIERR_BLOBTERM',DBIERR_BLOBTERM);
    AddConstant('DBIERR_BLOBERR',DBIERR_BLOBERR);
    AddConstant('DBIERR_RESTARTQRY',DBIERR_RESTARTQRY);
    AddConstant('DBIERR_UNKNOWNANSTYPE',DBIERR_UNKNOWNANSTYPE);
    AddConstant('DBIERR_SQLG_MDIST',DBIERR_SQLG_MDIST);
    AddConstant('DBIERR_SQLG_NOARI',DBIERR_SQLG_NOARI);
    AddConstant('DBIERR_SQLG_LIKEN',DBIERR_SQLG_LIKEN);
    AddConstant('DBIERR_SQLG_ALPHO',DBIERR_SQLG_ALPHO);
    AddConstant('DBIERR_SQLG_DATEO',DBIERR_SQLG_DATEO);
    AddConstant('DBIERR_SQLG_RELOP',DBIERR_SQLG_RELOP);
    AddConstant('DBIERR_SQLG_ONLYC',DBIERR_SQLG_ONLYC);
    AddConstant('DBIERR_SQLG_CNTLN',DBIERR_SQLG_CNTLN);
    AddConstant('DBIERR_SQLG_CHINI',DBIERR_SQLG_CHINI);
    AddConstant('DBIERR_SQLG_UNION',DBIERR_SQLG_UNION);
    AddConstant('DBIERR_SQLG_SLFIN',DBIERR_SQLG_SLFIN);
    AddConstant('DBIERR_SQLG_OTJVR',DBIERR_SQLG_OTJVR);
    AddConstant('DBIERR_SQLG_STROW',DBIERR_SQLG_STROW);
    AddConstant('DBIERR_SQLG_QUANT',DBIERR_SQLG_QUANT);
    AddConstant('DBIERR_SQLG_REGSO',DBIERR_SQLG_REGSO);
    AddConstant('DBIERR_SQLG_COUNT',DBIERR_SQLG_COUNT);
    AddConstant('DBIERR_SQLG_AVERA',DBIERR_SQLG_AVERA);
    AddConstant('DBIERR_SQLG_DATEA',DBIERR_SQLG_DATEA);
    AddConstant('DBIERR_SQLG_BADPT',DBIERR_SQLG_BADPT);
    AddConstant('DBIERR_SQLG_RELPA',DBIERR_SQLG_RELPA);
    AddConstant('DBIERR_SQLG_PATRN',DBIERR_SQLG_PATRN);
    AddConstant('DBIERR_SQLG_FNDSU',DBIERR_SQLG_FNDSU);
    AddConstant('DBIERR_SQLG_IFDCS',DBIERR_SQLG_IFDCS);
    AddConstant('DBIERR_SQLG_IDCCO',DBIERR_SQLG_IDCCO);
    AddConstant('DBIERR_SQLG_ONLYI',DBIERR_SQLG_ONLYI);
    AddConstant('DBIERR_SQLG_SQLDIALECT',DBIERR_SQLG_SQLDIALECT);
    AddConstant('DBIERR_SQLG_NOQUERY',DBIERR_SQLG_NOQUERY);
    AddConstant('DBIERR_BLOBGROUP',DBIERR_BLOBGROUP);
    AddConstant('DBIERR_QRYNOPROP',DBIERR_QRYNOPROP);
    AddConstant('DBIERR_ANSTYPNOTSUP',DBIERR_ANSTYPNOTSUP);
    AddConstant('DBIERR_ANSALIASNOTSUP',DBIERR_ANSALIASNOTSUP);
    AddConstant('DBIERR_INSBLOBREQ',DBIERR_INSBLOBREQ);
    AddConstant('DBIERR_CHGUNIQUENDXREQ',DBIERR_CHGUNIQUENDXREQ);
    AddConstant('DBIERR_DELUNIQUENDXREQ',DBIERR_DELUNIQUENDXREQ);
    AddConstant('DBIERR_SQLNOFULLUPDATE',DBIERR_SQLNOFULLUPDATE);
    AddConstant('DBIERR_CANTEXECREMOTE',DBIERR_CANTEXECREMOTE);
    AddConstant('DBIERR_UNEXPECTEDEOC',DBIERR_UNEXPECTEDEOC);
    AddConstant('DBIERR_SQLPARAMNOTSET',DBIERR_SQLPARAMNOTSET);
    AddConstant('DBIERR_QUERYTOOLONG',DBIERR_QUERYTOOLONG);
    AddConstant('DBIERR_NOSUCHRELORALIAS',DBIERR_NOSUCHRELORALIAS);
    AddConstant('DBIERR_TYPEAMBIGUITY',DBIERR_TYPEAMBIGUITY);
    AddConstant('DBIERR_ORDERBYNOTAPROJ',DBIERR_ORDERBYNOTAPROJ);
    AddConstant('DBIERR_SQLPARSE',DBIERR_SQLPARSE);
    AddConstant('DBIERR_CONSTRAINTFAILED',DBIERR_CONSTRAINTFAILED);
    AddConstant('DBIERR_NOTGROUPINGFIELD',DBIERR_NOTGROUPINGFIELD);
    AddConstant('DBIERR_UDFNOTDEFINED',DBIERR_UDFNOTDEFINED);
    AddConstant('DBIERR_UDFERROR',DBIERR_UDFERROR);
    AddConstant('DBIERR_SINGLEROWERROR',DBIERR_SINGLEROWERROR);
    AddConstant('DBIERR_GROUPEXPR',DBIERR_GROUPEXPR);
    AddConstant('DBIERR_QUERYTEXT',DBIERR_QUERYTEXT);
    AddConstant('DBIERR_ANSIJOINSUP',DBIERR_ANSIJOINSUP);
    AddConstant('DBIERR_DISTUNION',DBIERR_DISTUNION);
    AddConstant('DBIERR_GROUPBYREQ',DBIERR_GROUPBYREQ);
    AddConstant('DBIERR_INSUPDAUTOINC',DBIERR_INSUPDAUTOINC);
    AddConstant('DBIERR_UPDREFINTSINGLE',DBIERR_UPDREFINTSINGLE);
    AddConstant('DBIERR_NOMSACCESS',DBIERR_NOMSACCESS);
    AddConstant('DBIERR_FIELDCONSTPREP',DBIERR_FIELDCONSTPREP);
    AddConstant('DBIERR_FIELDDEFPREP',DBIERR_FIELDDEFPREP);
    AddConstant('DBIERR_RECCONSTPREP',DBIERR_RECCONSTPREP);
    AddConstant('DBIERR_TOOFEWSUBEXPR',DBIERR_TOOFEWSUBEXPR);
    AddConstant('DBIERR_TOOMANYSUBEXPR',DBIERR_TOOMANYSUBEXPR);
    AddConstant('DBIERR_INVALIDNODETYPE',DBIERR_INVALIDNODETYPE);
    AddConstant('DBIERR_BOOLEXPR',DBIERR_BOOLEXPR);
    AddConstant('DBIERR_NONBOOLEXPR',DBIERR_NONBOOLEXPR);
    AddConstant('DBIERR_NOOUTERJOIN',DBIERR_NOOUTERJOIN);
    AddConstant('DBIERR_USERCONSTRERR',DBIERR_USERCONSTRERR);
    AddConstant('ERRCODE_INTERFACEVER',ERRCODE_INTERFACEVER);
    AddConstant('ERRCODE_INDEXOUTOFDATE',ERRCODE_INDEXOUTOFDATE);
    AddConstant('ERRCODE_OLDVERSION',ERRCODE_OLDVERSION);
    AddConstant('ERRCODE_VALFILEINVALID',ERRCODE_VALFILEINVALID);
    AddConstant('ERRCODE_BLOBVERSION',ERRCODE_BLOBVERSION);
    AddConstant('ERRCODE_ENGQRYMISMATCH',ERRCODE_ENGQRYMISMATCH);
    AddConstant('ERRCODE_SERVERVERSION',ERRCODE_SERVERVERSION);
    AddConstant('ERRCODE_TABLELEVEL',ERRCODE_TABLELEVEL);
    AddConstant('DBIERR_INTERFACEVER',DBIERR_INTERFACEVER);
    AddConstant('DBIERR_INDEXOUTOFDATE',DBIERR_INDEXOUTOFDATE);
    AddConstant('DBIERR_OLDVERSION',DBIERR_OLDVERSION);
    AddConstant('DBIERR_VALFILEINVALID',DBIERR_VALFILEINVALID);
    AddConstant('DBIERR_BLOBVERSION',DBIERR_BLOBVERSION);
    AddConstant('DBIERR_ENGQRYMISMATCH',DBIERR_ENGQRYMISMATCH);
    AddConstant('DBIERR_SERVERVERSION',DBIERR_SERVERVERSION);
    AddConstant('DBIERR_TABLELEVEL',DBIERR_TABLELEVEL);
    AddConstant('ERRCODE_NOTSUPPORTED',ERRCODE_NOTSUPPORTED);
    AddConstant('ERRCODE_NIY',ERRCODE_NIY);
    AddConstant('ERRCODE_TABLESQL',ERRCODE_TABLESQL);
    AddConstant('ERRCODE_SEARCHCOLREQD',ERRCODE_SEARCHCOLREQD);
    AddConstant('ERRCODE_NOMULTCONNECT',ERRCODE_NOMULTCONNECT);
    AddConstant('ERRCODE_NODBASEEXPR',ERRCODE_NODBASEEXPR);
    AddConstant('ERRCODE_NONESTEDTRAN',ERRCODE_NONESTEDTRAN);
    AddConstant('DBIERR_NOTSUPPORTED',DBIERR_NOTSUPPORTED);
    AddConstant('DBIERR_NIY',DBIERR_NIY);
    AddConstant('DBIERR_TABLESQL',DBIERR_TABLESQL);
    AddConstant('DBIERR_SEARCHCOLREQD',DBIERR_SEARCHCOLREQD);
    AddConstant('DBIERR_NOMULTCONNECT',DBIERR_NOMULTCONNECT);
    AddConstant('DBIERR_NODBASEEXPR',DBIERR_NODBASEEXPR);
    AddConstant('DBIERR_NONESTEDTRAN',DBIERR_NONESTEDTRAN);
    AddConstant('ERRCODE_INVALIDDBSPEC',ERRCODE_INVALIDDBSPEC);
    AddConstant('ERRCODE_UNKNOWNDBTYPE',ERRCODE_UNKNOWNDBTYPE);
    AddConstant('ERRCODE_INVALIDSYSDATA',ERRCODE_INVALIDSYSDATA);
    AddConstant('ERRCODE_UNKNOWNNETTYPE',ERRCODE_UNKNOWNNETTYPE);
    AddConstant('ERRCODE_NOTONTHATNET',ERRCODE_NOTONTHATNET);
    AddConstant('ERRCODE_INVALIDCFGPARAM',ERRCODE_INVALIDCFGPARAM);
    AddConstant('DBIERR_INVALIDDBSPEC',DBIERR_INVALIDDBSPEC);
    AddConstant('DBIERR_UNKNOWNDBTYPE',DBIERR_UNKNOWNDBTYPE);
    AddConstant('DBIERR_INVALIDSYSDATA',DBIERR_INVALIDSYSDATA);
    AddConstant('DBIERR_UNKNOWNNETTYPE',DBIERR_UNKNOWNNETTYPE);
    AddConstant('DBIERR_NOTONTHATNET',DBIERR_NOTONTHATNET);
    AddConstant('DBIERR_INVALIDCFGPARAM',DBIERR_INVALIDCFGPARAM);
    AddConstant('ERRCODE_OBJIMPLICITLYDROPPED',ERRCODE_OBJIMPLICITLYDROPPED);
    AddConstant('ERRCODE_OBJMAYBETRUNCATED',ERRCODE_OBJMAYBETRUNCATED);
    AddConstant('ERRCODE_OBJIMPLICITLYMODIFIED',ERRCODE_OBJIMPLICITLYMODIFIED);
    AddConstant('ERRCODE_VALIDATEDATA',ERRCODE_VALIDATEDATA);
    AddConstant('ERRCODE_VALFIELDMODIFIED',ERRCODE_VALFIELDMODIFIED);
    AddConstant('ERRCODE_TABLELEVELCHANGED',ERRCODE_TABLELEVELCHANGED);
    AddConstant('ERRCODE_COPYLINKEDTABLES',ERRCODE_COPYLINKEDTABLES);
    AddConstant('ERRCODE_OTHERSERVERLOADED',ERRCODE_OTHERSERVERLOADED);
    AddConstant('ERRCODE_OBJIMPLICITLYTRUNCATED',ERRCODE_OBJIMPLICITLYTRUNCATED);
    AddConstant('ERRCODE_VCHKMAYNOTBEENFORCED',ERRCODE_VCHKMAYNOTBEENFORCED);
    AddConstant('ERRCODE_MULTIPLEUNIQRECS',ERRCODE_MULTIPLEUNIQRECS);
    AddConstant('ERRCODE_FIELDMUSTBETRIMMED',ERRCODE_FIELDMUSTBETRIMMED);
    AddConstant('DBIERR_OBJIMPLICITLYDROPPED',DBIERR_OBJIMPLICITLYDROPPED);
    AddConstant('DBIERR_OBJMAYBETRUNCATED',DBIERR_OBJMAYBETRUNCATED);
    AddConstant('DBIERR_OBJIMPLICITLYMODIFIED',DBIERR_OBJIMPLICITLYMODIFIED);
    AddConstant('DBIERR_VALIDATEDATA',DBIERR_VALIDATEDATA);
    AddConstant('DBIERR_VALFIELDMODIFIED',DBIERR_VALFIELDMODIFIED);
    AddConstant('DBIERR_TABLELEVELCHANGED',DBIERR_TABLELEVELCHANGED);
    AddConstant('DBIERR_COPYLINKEDTABLES',DBIERR_COPYLINKEDTABLES);
    AddConstant('DBIERR_OTHERSERVERLOADED',DBIERR_OTHERSERVERLOADED);
    AddConstant('DBIERR_OBJIMPLICITLYTRUNCATED',DBIERR_OBJIMPLICITLYTRUNCATED);
    AddConstant('DBIERR_VCHKMAYNOTBEENFORCED',DBIERR_VCHKMAYNOTBEENFORCED);
    AddConstant('DBIERR_MULTIPLEUNIQRECS',DBIERR_MULTIPLEUNIQRECS);
    AddConstant('DBIERR_FIELDMUSTBETRIMMED',DBIERR_FIELDMUSTBETRIMMED);
    AddConstant('ERRCODE_FILEEXISTS',ERRCODE_FILEEXISTS);
    AddConstant('ERRCODE_BLOBMODIFIED',ERRCODE_BLOBMODIFIED);
    AddConstant('ERRCODE_UNKNOWNSQL',ERRCODE_UNKNOWNSQL);
    AddConstant('ERRCODE_TABLEEXISTS',ERRCODE_TABLEEXISTS);
    AddConstant('ERRCODE_PDX10TABLE',ERRCODE_PDX10TABLE);
    AddConstant('ERRCODE_UPDATEABORT',ERRCODE_UPDATEABORT);
    AddConstant('DBIERR_FILEEXISTS',DBIERR_FILEEXISTS);
    AddConstant('DBIERR_BLOBMODIFIED',DBIERR_BLOBMODIFIED);
    AddConstant('DBIERR_UNKNOWNSQL',DBIERR_UNKNOWNSQL);
    AddConstant('DBIERR_TABLEEXISTS',DBIERR_TABLEEXISTS);
    AddConstant('DBIERR_PDX10TABLE',DBIERR_PDX10TABLE);
    AddConstant('DBIERR_UPDATEABORT',DBIERR_UPDATEABORT);
    AddConstant('ERRCODE_DIFFSORTORDER',ERRCODE_DIFFSORTORDER);
    AddConstant('ERRCODE_DIRINUSEBYOLDVER',ERRCODE_DIRINUSEBYOLDVER);
    AddConstant('ERRCODE_PDX35LDDRIVER',ERRCODE_PDX35LDDRIVER);
    AddConstant('DBIERR_DIFFSORTORDER',DBIERR_DIFFSORTORDER);
    AddConstant('DBIERR_DIRINUSEBYOLDVER',DBIERR_DIRINUSEBYOLDVER);
    AddConstant('DBIERR_PDX35LDDRIVER',DBIERR_PDX35LDDRIVER);
    AddConstant('ERRCODE_REQOPTPARAM',ERRCODE_REQOPTPARAM);
    AddConstant('ERRCODE_INVALIDOPTPARAM',ERRCODE_INVALIDOPTPARAM);
    AddConstant('DBIERR_REQOPTPARAM',DBIERR_REQOPTPARAM);
    AddConstant('DBIERR_INVALIDOPTPARAM',DBIERR_INVALIDOPTPARAM);
    AddConstant('ERRCODE_REPOSITORYCORRUPT',ERRCODE_REPOSITORYCORRUPT);
    AddConstant('ERRCODE_INFOBLOBCORRUPT',ERRCODE_INFOBLOBCORRUPT);
    AddConstant('ERRCODE_SCHEMACORRUPT',ERRCODE_SCHEMACORRUPT);
    AddConstant('ERRCODE_ATTRTYPEEXISTS',ERRCODE_ATTRTYPEEXISTS);
    AddConstant('ERRCODE_INVALIDOBJTYPE',ERRCODE_INVALIDOBJTYPE);
    AddConstant('ERRCODE_INVALIDRELATIONTYPE',ERRCODE_INVALIDRELATIONTYPE);
    AddConstant('ERRCODE_VIEWEXISTS',ERRCODE_VIEWEXISTS);
    AddConstant('ERRCODE_NOSUCHVIEW',ERRCODE_NOSUCHVIEW);
    AddConstant('ERRCODE_INVALIDRECCONSTRAINT',ERRCODE_INVALIDRECCONSTRAINT);
    AddConstant('ERRCODE_LDBCONNECTION',ERRCODE_LDBCONNECTION);
    AddConstant('ERRCODE_REPOSITORYEXISTS',ERRCODE_REPOSITORYEXISTS);
    AddConstant('ERRCODE_NOSUCHREPOSITORY',ERRCODE_NOSUCHREPOSITORY);
    AddConstant('ERRCODE_REPOSITORYDBMISSING',ERRCODE_REPOSITORYDBMISSING);
    AddConstant('ERRCODE_REPOSITORYOUTOFDATE',ERRCODE_REPOSITORYOUTOFDATE);
    AddConstant('ERRCODE_REPOSITORYVERSION',ERRCODE_REPOSITORYVERSION);
    AddConstant('ERRCODE_REPOSITORYNAME',ERRCODE_REPOSITORYNAME);
    AddConstant('ERRCODE_DEPENDENTOBJECTS',ERRCODE_DEPENDENTOBJECTS);
    AddConstant('ERRCODE_RELATIONLIMIT',ERRCODE_RELATIONLIMIT);
    AddConstant('ERRCODE_RELATIONSHIPSEXIST',ERRCODE_RELATIONSHIPSEXIST);
    AddConstant('ERRCODE_EXCHANGEFILECORRUPT',ERRCODE_EXCHANGEFILECORRUPT);
    AddConstant('ERRCODE_EXCHANGEFILEVERSION',ERRCODE_EXCHANGEFILEVERSION);
    AddConstant('ERRCODE_TYPEMISMATCH',ERRCODE_TYPEMISMATCH);
    AddConstant('ERRCODE_OBJECTEXISTS',ERRCODE_OBJECTEXISTS);
    AddConstant('ERRCODE_REPOSITORYACCESS',ERRCODE_REPOSITORYACCESS);
    AddConstant('ERRCODE_REPOSITORYCREATE',ERRCODE_REPOSITORYCREATE);
    AddConstant('ERRCODE_DATABASEOPENFAILED',ERRCODE_DATABASEOPENFAILED);
    AddConstant('DBIERR_REPOSITORYCORRUPT',DBIERR_REPOSITORYCORRUPT);
    AddConstant('DBIERR_INFOBLOBCORRUPT',DBIERR_INFOBLOBCORRUPT);
    AddConstant('DBIERR_SCHEMACORRUPT',DBIERR_SCHEMACORRUPT);
    AddConstant('DBIERR_ATTRTYPEEXISTS',DBIERR_ATTRTYPEEXISTS);
    AddConstant('DBIERR_INVALIDOBJTYPE',DBIERR_INVALIDOBJTYPE);
    AddConstant('DBIERR_INVALIDRELATIONTYPE',DBIERR_INVALIDRELATIONTYPE);
    AddConstant('DBIERR_VIEWEXISTS',DBIERR_VIEWEXISTS);
    AddConstant('DBIERR_NOSUCHVIEW',DBIERR_NOSUCHVIEW);
    AddConstant('DBIERR_INVALIDRECCONSTRAINT',DBIERR_INVALIDRECCONSTRAINT);
    AddConstant('DBIERR_LDBCONNECTION',DBIERR_LDBCONNECTION);
    AddConstant('DBIERR_REPOSITORYEXISTS',DBIERR_REPOSITORYEXISTS);
    AddConstant('DBIERR_NOSUCHREPOSITORY',DBIERR_NOSUCHREPOSITORY);
    AddConstant('DBIERR_REPOSITORYDBMISSING',DBIERR_REPOSITORYDBMISSING);
    AddConstant('DBIERR_REPOSITORYOUTOFDATE',DBIERR_REPOSITORYOUTOFDATE);
    AddConstant('DBIERR_REPOSITORYVERSION',DBIERR_REPOSITORYVERSION);
    AddConstant('DBIERR_REPOSITORYNAME',DBIERR_REPOSITORYNAME);
    AddConstant('DBIERR_DEPENDENTOBJECTS',DBIERR_DEPENDENTOBJECTS);
    AddConstant('DBIERR_RELATIONLIMIT',DBIERR_RELATIONLIMIT);
    AddConstant('DBIERR_RELATIONSHIPSEXIST',DBIERR_RELATIONSHIPSEXIST);
    AddConstant('DBIERR_EXCHANGEFILECORRUPT',DBIERR_EXCHANGEFILECORRUPT);
    AddConstant('DBIERR_EXCHANGEFILEVERSION',DBIERR_EXCHANGEFILEVERSION);
    AddConstant('DBIERR_TYPEMISMATCH',DBIERR_TYPEMISMATCH);
    AddConstant('DBIERR_OBJECTEXISTS',DBIERR_OBJECTEXISTS);
    AddConstant('DBIERR_REPOSITORYACCESS',DBIERR_REPOSITORYACCESS);
    AddConstant('DBIERR_REPOSITORYCREATE',DBIERR_REPOSITORYCREATE);
    AddConstant('DBIERR_DATABASEOPENFAILED',DBIERR_DATABASEOPENFAILED);
    AddConstant('MAXLDNAME',MAXLDNAME);
    AddConstant('MAX_LCNAME_LEN',MAX_LCNAME_LEN);
    AddConstant('DOS_CP',DOS_CP);
    AddConstant('WIN_CP',WIN_CP);
    AddConstant('UC_CP',UC_CP);
    AddConstant('SCHEMATYPE',SCHEMATYPE);
    AddConstant('CORETYPE',CORETYPE);
    AddConstant('LOGICALMODELTYPE',LOGICALMODELTYPE);
    AddConstant('PHYSICALMODELTYPE',PHYSICALMODELTYPE);
    AddConstant('NONDISPLAYTYPE',NONDISPLAYTYPE);
    AddConstant('INTERNALTYPE',INTERNALTYPE);
    AddConstant('DBIMAXENUMFLDLEN',DBIMAXENUMFLDLEN);
    AddConstant('DOMCLOSED',DOMCLOSED);
    AddConstant('NODISPLAY',NODISPLAY);
    AddConstant('SUMMARYDISPLAY',SUMMARYDISPLAY);
    AddConstant('DETAILDISPLAY',DETAILDISPLAY);
    AddConstant('INDIVIDUALDISPLAY',INDIVIDUALDISPLAY);
    AddConstant('iCOMMONATTR',iCOMMONATTR);
    AddConstant('iCOMMONUSERATTR',iCOMMONUSERATTR);
    AddConstant('iEXTATTR',iEXTATTR);
    AddConstant('EDITNEW',EDITNEW);
    AddConstant('EDITUNCHANGED',EDITUNCHANGED);
    AddConstant('EDITMODIFIED',EDITMODIFIED);
    AddConstant('SCHEMAATTR',SCHEMAATTR);
    AddConstant('EXTENDEDATTR',EXTENDEDATTR);
    AddConstant('UIATTR',UIATTR);
    AddConstant('LOGICALMODELATTR',LOGICALMODELATTR);
    AddConstant('PHYSICALMODELATTR',PHYSICALMODELATTR);
    AddConstant('INTERNALATTR',INTERNALATTR);
    AddConstant('szOBJID',szOBJID);
    AddConstant('szOBJVER',szOBJVER);
    AddConstant('szALIASNAME',szALIASNAME);
    AddConstant('szREALNAME',szREALNAME);
    AddConstant('szOUTOFDATE',szOUTOFDATE);
    AddConstant('szCREATEDATE',szCREATEDATE);
    AddConstant('szLASTUPDATE',szLASTUPDATE);
    AddConstant('szDATABLOB',szDATABLOB);
    AddConstant('szDATAREP',szDATAREP);
    AddConstant('szVERSIONNUM',szVERSIONNUM);
    AddConstant('szDB',szDB);
    AddConstant('szDBPATH',szDBPATH);
    AddConstant('szDBTYPE',szDBTYPE);
    AddConstant('szTABLE',szTABLE);
    AddConstant('szPATH',szPATH);
    AddConstant('szTBLTYPE',szTBLTYPE);
    AddConstant('szISFILE',szISFILE);
    AddConstant('szISVIEW',szISVIEW);
    AddConstant('szISSYNONYM',szISSYNONYM);
    AddConstant('szFIELD',szFIELD);
    AddConstant('szPHYTYPE',szPHYTYPE);
    AddConstant('szPHYSUBTYPE',szPHYSUBTYPE);
    AddConstant('szLOGTYPE',szLOGTYPE);
    AddConstant('szLOGSUBTYPE',szLOGSUBTYPE);
    AddConstant('szUNITS1',szUNITS1);
    AddConstant('szUNITS2',szUNITS2);
    AddConstant('szPOSITION',szPOSITION);
    AddConstant('szDEFVAL',szDEFVAL);
    AddConstant('szMINVAL',szMINVAL);
    AddConstant('szMAXVAL',szMAXVAL);
    AddConstant('szREQUIRED',szREQUIRED);
    AddConstant('szFREADONLY',szFREADONLY);
    AddConstant('szCASTTYPE',szCASTTYPE);
    AddConstant('szCASTSUBTYPE',szCASTSUBTYPE);
    AddConstant('szDOMCONSTRAINT',szDOMCONSTRAINT);
    AddConstant('szRECCONSTR',szRECCONSTR);
    AddConstant('szSQLCONSTRAINT',szSQLCONSTRAINT);
    AddConstant('szSRVCONSTRAINT',szSRVCONSTRAINT);
    AddConstant('szLOCCONSTRAINT',szLOCCONSTRAINT);
    AddConstant('szSRVDEFAULT',szSRVDEFAULT);
    AddConstant('szUSERERROR',szUSERERROR);
    AddConstant('szEXTFIELD',szEXTFIELD);
    AddConstant('szFIELDCLASS',szFIELDCLASS);
    AddConstant('szCONTROLCLASS',szCONTROLCLASS);
    AddConstant('szALIGNMENT',szALIGNMENT);
    AddConstant('szDISPLABEL',szDISPLABEL);
    AddConstant('szDISPWIDTH',szDISPWIDTH);
    AddConstant('szVISIBLE',szVISIBLE);
    AddConstant('szTRANSLITERATE',szTRANSLITERATE);
    AddConstant('szEDITMASK',szEDITMASK);
    AddConstant('szDISPFORMAT',szDISPFORMAT);
    AddConstant('szEDITFORMAT',szEDITFORMAT);
    AddConstant('szCURRENCY',szCURRENCY);
    AddConstant('szPRECISION',szPRECISION);
    AddConstant('szDISPLAYVALUES',szDISPLAYVALUES);
    AddConstant('szBLOBTYPE',szBLOBTYPE);
    AddConstant('szSRCOBJID',szSRCOBJID);
    AddConstant('szSRCOBJVER',szSRCOBJVER);
    AddConstant('szDESTOBJID',szDESTOBJID);
    AddConstant('szDESTOBJVER',szDESTOBJVER);
    AddConstant('szRIPOS',szRIPOS);
    AddConstant('szRDRDATABASE',szRDRDATABASE);
    AddConstant('szIRDBDR',szIRDBDR);
    AddConstant('szRDREXTFIELD',szRDREXTFIELD);
    AddConstant('szIREXTFIELDDR',szIREXTFIELDDR);
    AddConstant('szRDBTABLES',szRDBTABLES);
    AddConstant('szIRTABLEDB',szIRTABLEDB);
    AddConstant('szRTABLEFLDS',szRTABLEFLDS);
    AddConstant('szIRFLDTABLE',szIRFLDTABLE);
    AddConstant('szRDBVIEWS',szRDBVIEWS);
    AddConstant('szIRVIEWDB',szIRVIEWDB);
    AddConstant('szRTABLECONSTR',szRTABLECONSTR);
    AddConstant('szIRCONSTRTABLE',szIRCONSTRTABLE);
    AddConstant('szTABLETRIG',szTABLETRIG);
    AddConstant('szTRIGTABLE',szTRIGTABLE);
    AddConstant('szRFLDEXTFIELD',szRFLDEXTFIELD);
    AddConstant('szIREXTFIELDFLDS',szIREXTFIELDFLDS);
    AddConstant('szRPARENTEXTFIELD',szRPARENTEXTFIELD);
    AddConstant('szIRCHILDEXTFIELD',szIRCHILDEXTFIELD);
    AddConstant('clSQLRESTRICT',clSQLRESTRICT);
    AddConstant('MaxDS',MaxDS);
    AddConstant('szMTXCONTEXTOBJ',szMTXCONTEXTOBJ);
    AddConstant('OPENMODEFLAG_DIRTYREAD',OPENMODEFLAG_DIRTYREAD);
    AddConstant('OPENMODEFLAG_READCOMMITTED',OPENMODEFLAG_READCOMMITTED);
    AddConstant('OPENMODEFLAG_REPEATABLEREAD',OPENMODEFLAG_REPEATABLEREAD);
  end;
end;

class function TatBDELibrary.LibraryName: string;
begin
  result := 'BDE';
end;

initialization
  RegisterScripterLibrary(TatBDELibrary, True);

{$WARNINGS ON}

end.

