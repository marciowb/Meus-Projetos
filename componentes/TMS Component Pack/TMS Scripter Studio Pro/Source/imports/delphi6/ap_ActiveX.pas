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
unit ap_ActiveX;

interface

uses
  Windows,
  Messages,
  ActiveX,
  Variants,
  ap_System,
  ap_Windows,
  atScript;

{$WARNINGS OFF}

type
  TatActiveXLibrary = class(TatScripterLibrary)
    procedure __Succeeded(AMachine: TatVirtualMachine);
    procedure __Failed(AMachine: TatVirtualMachine);
    procedure __ResultCode(AMachine: TatVirtualMachine);
    procedure __ResultFacility(AMachine: TatVirtualMachine);
    procedure __ResultSeverity(AMachine: TatVirtualMachine);
    procedure __MakeResult(AMachine: TatVirtualMachine);
    procedure __IsEqualGUID(AMachine: TatVirtualMachine);
    procedure __IsEqualIID(AMachine: TatVirtualMachine);
    procedure __IsEqualCLSID(AMachine: TatVirtualMachine);
    procedure __CoBuildVersion(AMachine: TatVirtualMachine);
    procedure __CoUninitialize(AMachine: TatVirtualMachine);
    procedure __CoGetCurrentProcess(AMachine: TatVirtualMachine);
    procedure __CoRevokeMallocSpy(AMachine: TatVirtualMachine);
    procedure __CoRevokeClassObject(AMachine: TatVirtualMachine);
    procedure __CoResumeClassObjects(AMachine: TatVirtualMachine);
    procedure __CoSuspendClassObjects(AMachine: TatVirtualMachine);
    procedure __CoAddRefServerProcess(AMachine: TatVirtualMachine);
    procedure __CoReleaseServerProcess(AMachine: TatVirtualMachine);
    procedure __CoGetPSClsid(AMachine: TatVirtualMachine);
    procedure __CoRegisterPSClsid(AMachine: TatVirtualMachine);
    procedure __CoLoadLibrary(AMachine: TatVirtualMachine);
    procedure __CoFreeLibrary(AMachine: TatVirtualMachine);
    procedure __CoFreeAllLibraries(AMachine: TatVirtualMachine);
    procedure __CoFreeUnusedLibraries(AMachine: TatVirtualMachine);
    procedure __CoImpersonateClient(AMachine: TatVirtualMachine);
    procedure __CoRevertToSelf(AMachine: TatVirtualMachine);
    procedure __StringFromCLSID(AMachine: TatVirtualMachine);
    procedure __CLSIDFromString(AMachine: TatVirtualMachine);
    procedure __StringFromIID(AMachine: TatVirtualMachine);
    procedure __IIDFromString(AMachine: TatVirtualMachine);
    procedure __CoIsOle1Class(AMachine: TatVirtualMachine);
    procedure __ProgIDFromCLSID(AMachine: TatVirtualMachine);
    procedure __CLSIDFromProgID(AMachine: TatVirtualMachine);
    procedure __StringFromGUID2(AMachine: TatVirtualMachine);
    procedure __CoCreateGuid(AMachine: TatVirtualMachine);
    procedure __CoFileTimeToDosDateTime(AMachine: TatVirtualMachine);
    procedure __CoDosDateTimeToFileTime(AMachine: TatVirtualMachine);
    procedure __CoFileTimeNow(AMachine: TatVirtualMachine);
    procedure __CoGetTreatAsClass(AMachine: TatVirtualMachine);
    procedure __CoTreatAsClass(AMachine: TatVirtualMachine);
    procedure __StgIsStorageFile(AMachine: TatVirtualMachine);
    procedure __StgSetTimes(AMachine: TatVirtualMachine);
    procedure __GetClassFile(AMachine: TatVirtualMachine);
    procedure __SysAllocString(AMachine: TatVirtualMachine);
    procedure __SysReAllocString(AMachine: TatVirtualMachine);
    procedure __SysAllocStringLen(AMachine: TatVirtualMachine);
    procedure __SysReAllocStringLen(AMachine: TatVirtualMachine);
    procedure __SysFreeString(AMachine: TatVirtualMachine);
    procedure __SysStringLen(AMachine: TatVirtualMachine);
    procedure __SysStringByteLen(AMachine: TatVirtualMachine);
    procedure __SysAllocStringByteLen(AMachine: TatVirtualMachine);
    procedure __DosDateTimeToVariantTime(AMachine: TatVirtualMachine);
    procedure __VariantTimeToDosDateTime(AMachine: TatVirtualMachine);
    procedure __SystemTimeToVariantTime(AMachine: TatVirtualMachine);
    procedure __VariantTimeToSystemTime(AMachine: TatVirtualMachine);
    procedure __VariantInit(AMachine: TatVirtualMachine);
    procedure __VariantClear(AMachine: TatVirtualMachine);
    procedure __VariantCopy(AMachine: TatVirtualMachine);
    procedure __VariantCopyInd(AMachine: TatVirtualMachine);
    procedure __VariantChangeType(AMachine: TatVirtualMachine);
    procedure __VariantChangeTypeEx(AMachine: TatVirtualMachine);
    procedure __LHashValOfNameSys(AMachine: TatVirtualMachine);
    procedure __LHashValOfNameSysA(AMachine: TatVirtualMachine);
    procedure __LHashValOfName(AMachine: TatVirtualMachine);
    procedure __IsHashValCompatible(AMachine: TatVirtualMachine);
    procedure __QueryPathOfRegTypeLib(AMachine: TatVirtualMachine);
    procedure __UnRegisterTypeLib(AMachine: TatVirtualMachine);
    procedure __DispGetParam(AMachine: TatVirtualMachine);
    procedure __OaBuildVersion(AMachine: TatVirtualMachine);
    procedure __ClearCustData(AMachine: TatVirtualMachine);
    procedure __OleBuildVersion(AMachine: TatVirtualMachine);
    procedure __OleUninitialize(AMachine: TatVirtualMachine);
    procedure __RevokeDragDrop(AMachine: TatVirtualMachine);
    procedure __OleFlushClipboard(AMachine: TatVirtualMachine);
    procedure __OleCreateMenuDescriptor(AMachine: TatVirtualMachine);
    procedure __OleDestroyMenuDescriptor(AMachine: TatVirtualMachine);
    procedure __OleDuplicateData(AMachine: TatVirtualMachine);
    procedure __ReleaseStgMedium(AMachine: TatVirtualMachine);
    procedure __OleGetIconOfFile(AMachine: TatVirtualMachine);
    procedure __OleGetIconOfClass(AMachine: TatVirtualMachine);
    procedure __OleMetafilePictFromIconAndLabel(AMachine: TatVirtualMachine);
    procedure __OleRegGetUserType(AMachine: TatVirtualMachine);
    procedure __OleRegGetMiscStatus(AMachine: TatVirtualMachine);
    procedure __OleGetAutoConvert(AMachine: TatVirtualMachine);
    procedure __OleSetAutoConvert(AMachine: TatVirtualMachine);
    procedure __OleCreatePropertyFrameIndirect(AMachine: TatVirtualMachine);
    procedure __OleTranslateColor(AMachine: TatVirtualMachine);
    procedure __OleCreateFontIndirect(AMachine: TatVirtualMachine);
    procedure __OleCreatePictureIndirect(AMachine: TatVirtualMachine);
    procedure __OleIconToCursor(AMachine: TatVirtualMachine);
    procedure __PROPSETHDR_OSVER_KIND(AMachine: TatVirtualMachine);
    procedure __PROPSETHDR_OSVER_MAJOR(AMachine: TatVirtualMachine);
    procedure __PROPSETHDR_OSVER_MINOR(AMachine: TatVirtualMachine);
    procedure __GetCATID_Designer(AMachine: TatVirtualMachine);
    procedure __GetCATID_WebDesigntimeControl(AMachine: TatVirtualMachine);
    procedure __GetGUID_NULL(AMachine: TatVirtualMachine);
    procedure __GetGUID_OLE_COLOR(AMachine: TatVirtualMachine);
    procedure __GetIID_IRpcChannel(AMachine: TatVirtualMachine);
    procedure __GetIID_IRpcStub(AMachine: TatVirtualMachine);
    procedure __GetIID_IStubManager(AMachine: TatVirtualMachine);
    procedure __GetIID_IRpcProxy(AMachine: TatVirtualMachine);
    procedure __GetIID_IProxyManager(AMachine: TatVirtualMachine);
    procedure __GetIID_IPSFactory(AMachine: TatVirtualMachine);
    procedure __GetIID_IInternalMoniker(AMachine: TatVirtualMachine);
    procedure __GetCLSID_StdMarshal(AMachine: TatVirtualMachine);
    procedure __GetIID_IEnumGeneric(AMachine: TatVirtualMachine);
    procedure __GetIID_IEnumHolder(AMachine: TatVirtualMachine);
    procedure __GetIID_IEnumCallback(AMachine: TatVirtualMachine);
    procedure __GetIID_IOleManager(AMachine: TatVirtualMachine);
    procedure __GetIID_IOlePresObj(AMachine: TatVirtualMachine);
    procedure __GetIID_IDebug(AMachine: TatVirtualMachine);
    procedure __GetIID_IDebugStream(AMachine: TatVirtualMachine);
    procedure __GetCLSID_CFontPropPage(AMachine: TatVirtualMachine);
    procedure __GetCLSID_CColorPropPage(AMachine: TatVirtualMachine);
    procedure __GetCLSID_CPicturePropPage(AMachine: TatVirtualMachine);
    procedure __GetCLSID_PersistPropset(AMachine: TatVirtualMachine);
    procedure __GetCLSID_ConvertVBX(AMachine: TatVirtualMachine);
    procedure __GetCLSID_StdFont(AMachine: TatVirtualMachine);
    procedure __GetCLSID_StdPicture(AMachine: TatVirtualMachine);
    procedure __GetCLSID_StdComponentCategoryMgr(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  _OBJECTIDWrapper = class(TatRecordWrapper)
  private
    FUniquifier: Longint;
  public
    constructor Create(ARecord: _OBJECTID);
    function ObjToRec: _OBJECTID;
  published
    property Uniquifier: Longint read FUniquifier write FUniquifier;
  end;
  
  _COSERVERINFOWrapper = class(TatRecordWrapper)
  private
    FdwReserved1: Longint;
    FdwReserved2: Longint;
  public
    constructor Create(ARecord: _COSERVERINFO);
    function ObjToRec: _COSERVERINFO;
  published
    property dwReserved1: Longint read FdwReserved1 write FdwReserved1;
    property dwReserved2: Longint read FdwReserved2 write FdwReserved2;
  end;
  
  tagMULTI_QIWrapper = class(TatRecordWrapper)
  private
    Fhr: HRESULT;
  public
    constructor Create(ARecord: tagMULTI_QI);
    function ObjToRec: tagMULTI_QI;
  published
    property hr: HRESULT read Fhr write Fhr;
  end;
  
  tagSAFEARRAYBOUNDWrapper = class(TatRecordWrapper)
  private
    FcElements: Longint;
    FlLbound: Longint;
  public
    constructor Create(ARecord: tagSAFEARRAYBOUND);
    function ObjToRec: tagSAFEARRAYBOUND;
  published
    property cElements: Longint read FcElements write FcElements;
    property lLbound: Longint read FlLbound write FlLbound;
  end;
  
  tagSAFEARRAYWrapper = class(TatRecordWrapper)
  private
    FcDims: Word;
    FfFeatures: Word;
    FcbElements: Longint;
    FcLocks: Longint;
  public
    constructor Create(ARecord: tagSAFEARRAY);
    function ObjToRec: tagSAFEARRAY;
  published
    property cDims: Word read FcDims write FcDims;
    property fFeatures: Word read FfFeatures write FfFeatures;
    property cbElements: Longint read FcbElements write FcbElements;
    property cLocks: Longint read FcLocks write FcLocks;
  end;
  
  tagPOINTFWrapper = class(TatRecordWrapper)
  private
    Fx: Single;
    Fy: Single;
  public
    constructor Create(ARecord: tagPOINTF);
    function ObjToRec: tagPOINTF;
  published
    property x: Single read Fx write Fx;
    property y: Single read Fy write Fy;
  end;
  
  tagCONTROLINFOWrapper = class(TatRecordWrapper)
  private
    Fcb: Longint;
    FhAccel: HAccel;
    FcAccel: Word;
    FdwFlags: Longint;
  public
    constructor Create(ARecord: tagCONTROLINFO);
    function ObjToRec: tagCONTROLINFO;
  published
    property cb: Longint read Fcb write Fcb;
    property hAccel: HAccel read FhAccel write FhAccel;
    property cAccel: Word read FcAccel write FcAccel;
    property dwFlags: Longint read FdwFlags write FdwFlags;
  end;
  
  tagBIND_OPTSWrapper = class(TatRecordWrapper)
  private
    FcbStruct: Longint;
    FgrfFlags: Longint;
    FgrfMode: Longint;
    FdwTickCountDeadline: Longint;
  public
    constructor Create(ARecord: tagBIND_OPTS);
    function ObjToRec: tagBIND_OPTS;
  published
    property cbStruct: Longint read FcbStruct write FcbStruct;
    property grfFlags: Longint read FgrfFlags write FgrfFlags;
    property grfMode: Longint read FgrfMode write FgrfMode;
    property dwTickCountDeadline: Longint read FdwTickCountDeadline write FdwTickCountDeadline;
  end;
  
  tagSTATSTGWrapper = class(TatRecordWrapper)
  private
    FdwType: Longint;
    FcbSize: Largeint;
    FgrfMode: Longint;
    FgrfLocksSupported: Longint;
    FgrfStateBits: Longint;
    Freserved: Longint;
  public
    constructor Create(ARecord: tagSTATSTG);
    function ObjToRec: tagSTATSTG;
  published
    property dwType: Longint read FdwType write FdwType;
    property cbSize: Largeint read FcbSize write FcbSize;
    property grfMode: Longint read FgrfMode write FgrfMode;
    property grfLocksSupported: Longint read FgrfLocksSupported write FgrfLocksSupported;
    property grfStateBits: Longint read FgrfStateBits write FgrfStateBits;
    property reserved: Longint read Freserved write Freserved;
  end;
  
  tagDVTARGETDEVICEWrapper = class(TatRecordWrapper)
  private
    FtdSize: Longint;
    FtdDriverNameOffset: Word;
    FtdDeviceNameOffset: Word;
    FtdPortNameOffset: Word;
    FtdExtDevmodeOffset: Word;
  public
    constructor Create(ARecord: tagDVTARGETDEVICE);
    function ObjToRec: tagDVTARGETDEVICE;
  published
    property tdSize: Longint read FtdSize write FtdSize;
    property tdDriverNameOffset: Word read FtdDriverNameOffset write FtdDriverNameOffset;
    property tdDeviceNameOffset: Word read FtdDeviceNameOffset write FtdDeviceNameOffset;
    property tdPortNameOffset: Word read FtdPortNameOffset write FtdPortNameOffset;
    property tdExtDevmodeOffset: Word read FtdExtDevmodeOffset write FtdExtDevmodeOffset;
  end;
  
  tagFORMATETCWrapper = class(TatRecordWrapper)
  private
    FcfFormat: TClipFormat;
    FdwAspect: Longint;
    Flindex: Longint;
    Ftymed: Longint;
  public
    constructor Create(ARecord: tagFORMATETC);
    function ObjToRec: tagFORMATETC;
  published
    property cfFormat: TClipFormat read FcfFormat write FcfFormat;
    property dwAspect: Longint read FdwAspect write FdwAspect;
    property lindex: Longint read Flindex write Flindex;
    property tymed: Longint read Ftymed write Ftymed;
  end;
  
  tagSTATDATAWrapper = class(TatRecordWrapper)
  private
    Fadvf: Longint;
    FdwConnection: Longint;
  public
    constructor Create(ARecord: tagSTATDATA);
    function ObjToRec: tagSTATDATA;
  published
    property advf: Longint read Fadvf write Fadvf;
    property dwConnection: Longint read FdwConnection write FdwConnection;
  end;
  
  tagRemSTGMEDIUMWrapper = class(TatRecordWrapper)
  private
    Ftymed: Longint;
    FdwHandleType: Longint;
    FpData: Longint;
    FpUnkForRelease: Longint;
    FcbData: Longint;
  public
    constructor Create(ARecord: tagRemSTGMEDIUM);
    function ObjToRec: tagRemSTGMEDIUM;
  published
    property tymed: Longint read Ftymed write Ftymed;
    property dwHandleType: Longint read FdwHandleType write FdwHandleType;
    property pData: Longint read FpData write FpData;
    property pUnkForRelease: Longint read FpUnkForRelease write FpUnkForRelease;
    property cbData: Longint read FcbData write FcbData;
  end;
  
  tagSTGMEDIUMWrapper = class(TatRecordWrapper)
  private
    Ftymed: Longint;
    FhBitmap: HBitmap;
    FhMetaFilePict: THandle;
    FhEnhMetaFile: THandle;
    FhGlobal: HGlobal;
  public
    constructor Create(ARecord: tagSTGMEDIUM);
    function ObjToRec: tagSTGMEDIUM;
  published
    property tymed: Longint read Ftymed write Ftymed;
    property hBitmap: HBitmap read FhBitmap write FhBitmap;
    property hMetaFilePict: THandle read FhMetaFilePict write FhMetaFilePict;
    property hEnhMetaFile: THandle read FhEnhMetaFile write FhEnhMetaFile;
    property hGlobal: HGlobal read FhGlobal write FhGlobal;
  end;
  
  tagINTERFACEINFOWrapper = class(TatRecordWrapper)
  private
    FwMethod: Word;
  public
    constructor Create(ARecord: tagINTERFACEINFO);
    function ObjToRec: tagINTERFACEINFO;
  published
    property wMethod: Word read FwMethod write FwMethod;
  end;
  
  tagRPCOLEMESSAGEWrapper = class(TatRecordWrapper)
  private
    FdataRepresentation: TRpcOleDataRep;
    FcbBuffer: Longint;
    FiMethod: Longint;
    FrpcFlags: Longint;
  public
    constructor Create(ARecord: tagRPCOLEMESSAGE);
    function ObjToRec: tagRPCOLEMESSAGE;
  published
    property dataRepresentation: TRpcOleDataRep read FdataRepresentation write FdataRepresentation;
    property cbBuffer: Longint read FcbBuffer write FcbBuffer;
    property iMethod: Longint read FiMethod write FiMethod;
    property rpcFlags: Longint read FrpcFlags write FrpcFlags;
  end;
  
  tagDECWrapper = class(TatRecordWrapper)
  private
    FwReserved: Word;
    Fscale: Byte;
    Fsign: Byte;
    FHi32: Longint;
    FLo32: Longint;
    FMid32: Longint;
    FLo64: LONGLONG;
    Fsignscale: Word;
  public
    constructor Create(ARecord: tagDEC);
    function ObjToRec: tagDEC;
  published
    property wReserved: Word read FwReserved write FwReserved;
    property scale: Byte read Fscale write Fscale;
    property sign: Byte read Fsign write Fsign;
    property Hi32: Longint read FHi32 write FHi32;
    property Lo32: Longint read FLo32 write FLo32;
    property Mid32: Longint read FMid32 write FMid32;
    property Lo64: LONGLONG read FLo64 write FLo64;
    property signscale: Word read Fsignscale write Fsignscale;
  end;
  
  tagBLOBWrapper = class(TatRecordWrapper)
  private
    FcbSize: Longint;
  public
    constructor Create(ARecord: tagBLOB);
    function ObjToRec: tagBLOB;
  published
    property cbSize: Longint read FcbSize write FcbSize;
  end;
  
  tagCLIPDATAWrapper = class(TatRecordWrapper)
  private
    FcbSize: Longint;
    FulClipFmt: Longint;
  public
    constructor Create(ARecord: tagCLIPDATA);
    function ObjToRec: tagCLIPDATA;
  published
    property cbSize: Longint read FcbSize write FcbSize;
    property ulClipFmt: Longint read FulClipFmt write FulClipFmt;
  end;
  
  tagCAUBWrapper = class(TatRecordWrapper)
  private
    FcElems: ULONG;
  public
    constructor Create(ARecord: tagCAUB);
    function ObjToRec: tagCAUB;
  published
    property cElems: ULONG read FcElems write FcElems;
  end;
  
  tagCAIWrapper = class(TatRecordWrapper)
  private
    FcElems: ULONG;
  public
    constructor Create(ARecord: tagCAI);
    function ObjToRec: tagCAI;
  published
    property cElems: ULONG read FcElems write FcElems;
  end;
  
  tagCAUIWrapper = class(TatRecordWrapper)
  private
    FcElems: ULONG;
  public
    constructor Create(ARecord: tagCAUI);
    function ObjToRec: tagCAUI;
  published
    property cElems: ULONG read FcElems write FcElems;
  end;
  
  tagCALWrapper = class(TatRecordWrapper)
  private
    FcElems: ULONG;
  public
    constructor Create(ARecord: tagCAL);
    function ObjToRec: tagCAL;
  published
    property cElems: ULONG read FcElems write FcElems;
  end;
  
  tagCAULWrapper = class(TatRecordWrapper)
  private
    FcElems: ULONG;
  public
    constructor Create(ARecord: tagCAUL);
    function ObjToRec: tagCAUL;
  published
    property cElems: ULONG read FcElems write FcElems;
  end;
  
  tagCAFLTWrapper = class(TatRecordWrapper)
  private
    FcElems: ULONG;
  public
    constructor Create(ARecord: tagCAFLT);
    function ObjToRec: tagCAFLT;
  published
    property cElems: ULONG read FcElems write FcElems;
  end;
  
  tagCADBLWrapper = class(TatRecordWrapper)
  private
    FcElems: ULONG;
  public
    constructor Create(ARecord: tagCADBL);
    function ObjToRec: tagCADBL;
  published
    property cElems: ULONG read FcElems write FcElems;
  end;
  
  tagCACYWrapper = class(TatRecordWrapper)
  private
    FcElems: ULONG;
  public
    constructor Create(ARecord: tagCACY);
    function ObjToRec: tagCACY;
  published
    property cElems: ULONG read FcElems write FcElems;
  end;
  
  tagCADATEWrapper = class(TatRecordWrapper)
  private
    FcElems: ULONG;
  public
    constructor Create(ARecord: tagCADATE);
    function ObjToRec: tagCADATE;
  published
    property cElems: ULONG read FcElems write FcElems;
  end;
  
  tagCABSTRWrapper = class(TatRecordWrapper)
  private
    FcElems: ULONG;
  public
    constructor Create(ARecord: tagCABSTR);
    function ObjToRec: tagCABSTR;
  published
    property cElems: ULONG read FcElems write FcElems;
  end;
  
  tagCABOOLWrapper = class(TatRecordWrapper)
  private
    FcElems: ULONG;
  public
    constructor Create(ARecord: tagCABOOL);
    function ObjToRec: tagCABOOL;
  published
    property cElems: ULONG read FcElems write FcElems;
  end;
  
  tagCASCODEWrapper = class(TatRecordWrapper)
  private
    FcElems: ULONG;
  public
    constructor Create(ARecord: tagCASCODE);
    function ObjToRec: tagCASCODE;
  published
    property cElems: ULONG read FcElems write FcElems;
  end;
  
  tagCAPROPVARIANTWrapper = class(TatRecordWrapper)
  private
    FcElems: ULONG;
  public
    constructor Create(ARecord: tagCAPROPVARIANT);
    function ObjToRec: tagCAPROPVARIANT;
  published
    property cElems: ULONG read FcElems write FcElems;
  end;
  
  tagCAHWrapper = class(TatRecordWrapper)
  private
    FcElems: ULONG;
  public
    constructor Create(ARecord: tagCAH);
    function ObjToRec: tagCAH;
  published
    property cElems: ULONG read FcElems write FcElems;
  end;
  
  tagCAUHWrapper = class(TatRecordWrapper)
  private
    FcElems: ULONG;
  public
    constructor Create(ARecord: tagCAUH);
    function ObjToRec: tagCAUH;
  published
    property cElems: ULONG read FcElems write FcElems;
  end;
  
  tagCALPSTRWrapper = class(TatRecordWrapper)
  private
    FcElems: ULONG;
  public
    constructor Create(ARecord: tagCALPSTR);
    function ObjToRec: tagCALPSTR;
  published
    property cElems: ULONG read FcElems write FcElems;
  end;
  
  tagCALPWSTRWrapper = class(TatRecordWrapper)
  private
    FcElems: ULONG;
  public
    constructor Create(ARecord: tagCALPWSTR);
    function ObjToRec: tagCALPWSTR;
  published
    property cElems: ULONG read FcElems write FcElems;
  end;
  
  tagCAFILETIMEWrapper = class(TatRecordWrapper)
  private
    FcElems: ULONG;
  public
    constructor Create(ARecord: tagCAFILETIME);
    function ObjToRec: tagCAFILETIME;
  published
    property cElems: ULONG read FcElems write FcElems;
  end;
  
  tagCACLIPDATAWrapper = class(TatRecordWrapper)
  private
    FcElems: ULONG;
  public
    constructor Create(ARecord: tagCACLIPDATA);
    function ObjToRec: tagCACLIPDATA;
  published
    property cElems: ULONG read FcElems write FcElems;
  end;
  
  tagCACLSIDWrapper = class(TatRecordWrapper)
  private
    FcElems: ULONG;
  public
    constructor Create(ARecord: tagCACLSID);
    function ObjToRec: tagCACLSID;
  published
    property cElems: ULONG read FcElems write FcElems;
  end;
  
  tagPROPVARIANTWrapper = class(TatRecordWrapper)
  private
    Fvt: TVarType;
    FwReserved1: Word;
    FwReserved2: Word;
    FwReserved3: Word;
    FbVal: Byte;
    FiVal: SmallInt;
    FuiVal: Word;
    FboolVal: TOleBool;
    Fbool: TOleBool;
    FlVal: Longint;
    FulVal: Cardinal;
    FfltVal: Single;
    Fscode: SCODE;
    FdblVal: Double;
    FcyVal: Currency;
    Fdate: TOleDate;
  public
    constructor Create(ARecord: tagPROPVARIANT);
    function ObjToRec: tagPROPVARIANT;
  published
    property vt: TVarType read Fvt write Fvt;
    property wReserved1: Word read FwReserved1 write FwReserved1;
    property wReserved2: Word read FwReserved2 write FwReserved2;
    property wReserved3: Word read FwReserved3 write FwReserved3;
    property bVal: Byte read FbVal write FbVal;
    property iVal: SmallInt read FiVal write FiVal;
    property uiVal: Word read FuiVal write FuiVal;
    property boolVal: TOleBool read FboolVal write FboolVal;
    property bool: TOleBool read Fbool write Fbool;
    property lVal: Longint read FlVal write FlVal;
    property ulVal: Cardinal read FulVal write FulVal;
    property fltVal: Single read FfltVal write FfltVal;
    property scode: SCODE read Fscode write Fscode;
    property dblVal: Double read FdblVal write FdblVal;
    property cyVal: Currency read FcyVal write FcyVal;
    property date: TOleDate read Fdate write Fdate;
  end;
  
  tagPROPSPECWrapper = class(TatRecordWrapper)
  private
    FulKind: ULONG;
    Fpropid: TPropID;
  public
    constructor Create(ARecord: tagPROPSPEC);
    function ObjToRec: tagPROPSPEC;
  published
    property ulKind: ULONG read FulKind write FulKind;
    property propid: TPropID read Fpropid write Fpropid;
  end;
  
  tagSTATPROPSTGWrapper = class(TatRecordWrapper)
  private
    Fpropid: TPropID;
    Fvt: TVarType;
  public
    constructor Create(ARecord: tagSTATPROPSTG);
    function ObjToRec: tagSTATPROPSTG;
  published
    property propid: TPropID read Fpropid write Fpropid;
    property vt: TVarType read Fvt write Fvt;
  end;
  
  tagSTATPROPSETSTGWrapper = class(TatRecordWrapper)
  private
    FgrfFlags: DWORD;
    FdwOSVersion: DWORD;
  public
    constructor Create(ARecord: tagSTATPROPSETSTG);
    function ObjToRec: tagSTATPROPSETSTG;
  published
    property grfFlags: DWORD read FgrfFlags write FgrfFlags;
    property dwOSVersion: DWORD read FdwOSVersion write FdwOSVersion;
  end;
  
  tagVARIANTWrapper = class(TatRecordWrapper)
  private
    Fvt: TVarType;
    FwReserved1: Word;
    FwReserved2: Word;
    FwReserved3: Word;
    FbVal: Byte;
    FiVal: Smallint;
    FlVal: Longint;
    FfltVal: Single;
    FdblVal: Double;
    Fvbool: TOleBool;
    Fscode: HResult;
    FcyVal: Currency;
    Fdate: TOleDate;
    FcVal: Char;
    FuiVal: Word;
    FulVal: LongWord;
    FintVal: Integer;
    FuintVal: LongWord;
  public
    constructor Create(ARecord: tagVARIANT);
    function ObjToRec: tagVARIANT;
  published
    property vt: TVarType read Fvt write Fvt;
    property wReserved1: Word read FwReserved1 write FwReserved1;
    property wReserved2: Word read FwReserved2 write FwReserved2;
    property wReserved3: Word read FwReserved3 write FwReserved3;
    property bVal: Byte read FbVal write FbVal;
    property iVal: Smallint read FiVal write FiVal;
    property lVal: Longint read FlVal write FlVal;
    property fltVal: Single read FfltVal write FfltVal;
    property dblVal: Double read FdblVal write FdblVal;
    property vbool: TOleBool read Fvbool write Fvbool;
    property scode: HResult read Fscode write Fscode;
    property cyVal: Currency read FcyVal write FcyVal;
    property date: TOleDate read Fdate write Fdate;
    property cVal: Char read FcVal write FcVal;
    property uiVal: Word read FuiVal write FuiVal;
    property ulVal: LongWord read FulVal write FulVal;
    property intVal: Integer read FintVal write FintVal;
    property uintVal: LongWord read FuintVal write FuintVal;
  end;
  
  tagTYPEDESCWrapper = class(TatRecordWrapper)
  private
    Fvt: TVarType;
    Fhreftype: HRefType;
  public
    constructor Create(ARecord: tagTYPEDESC);
    function ObjToRec: tagTYPEDESC;
  published
    property vt: TVarType read Fvt write Fvt;
    property hreftype: HRefType read Fhreftype write Fhreftype;
  end;
  
  tagARRAYDESCWrapper = class(TatRecordWrapper)
  private
    FcDims: Word;
  public
    constructor Create(ARecord: tagARRAYDESC);
    function ObjToRec: tagARRAYDESC;
  published
    property cDims: Word read FcDims write FcDims;
  end;
  
  tagIDLDESCWrapper = class(TatRecordWrapper)
  private
    FdwReserved: Longint;
    FwIDLFlags: Word;
  public
    constructor Create(ARecord: tagIDLDESC);
    function ObjToRec: tagIDLDESC;
  published
    property dwReserved: Longint read FdwReserved write FdwReserved;
    property wIDLFlags: Word read FwIDLFlags write FwIDLFlags;
  end;
  
  tagPARAMDESCEXWrapper = class(TatRecordWrapper)
  private
    FcBytes: Longint;
    FFourBytePad: Longint;
  public
    constructor Create(ARecord: tagPARAMDESCEX);
    function ObjToRec: tagPARAMDESCEX;
  published
    property cBytes: Longint read FcBytes write FcBytes;
    property FourBytePad: Longint read FFourBytePad write FFourBytePad;
  end;
  
  tagPARAMDESCWrapper = class(TatRecordWrapper)
  private
    FwParamFlags: Word;
  public
    constructor Create(ARecord: tagPARAMDESC);
    function ObjToRec: tagPARAMDESC;
  published
    property wParamFlags: Word read FwParamFlags write FwParamFlags;
  end;
  
  tagELEMDESCWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagELEMDESC);
    function ObjToRec: tagELEMDESC;
  published
  end;
  
  tagTYPEATTRWrapper = class(TatRecordWrapper)
  private
    Flcid: TLCID;
    FdwReserved: Longint;
    FmemidConstructor: TMemberID;
    FmemidDestructor: TMemberID;
    FcbSizeInstance: Longint;
    Ftypekind: TTypeKind;
    FcFuncs: Word;
    FcVars: Word;
    FcImplTypes: Word;
    FcbSizeVft: Word;
    FcbAlignment: Word;
    FwTypeFlags: Word;
    FwMajorVerNum: Word;
    FwMinorVerNum: Word;
  public
    constructor Create(ARecord: tagTYPEATTR);
    function ObjToRec: tagTYPEATTR;
  published
    property lcid: TLCID read Flcid write Flcid;
    property dwReserved: Longint read FdwReserved write FdwReserved;
    property memidConstructor: TMemberID read FmemidConstructor write FmemidConstructor;
    property memidDestructor: TMemberID read FmemidDestructor write FmemidDestructor;
    property cbSizeInstance: Longint read FcbSizeInstance write FcbSizeInstance;
    property typekind: TTypeKind read Ftypekind write Ftypekind;
    property cFuncs: Word read FcFuncs write FcFuncs;
    property cVars: Word read FcVars write FcVars;
    property cImplTypes: Word read FcImplTypes write FcImplTypes;
    property cbSizeVft: Word read FcbSizeVft write FcbSizeVft;
    property cbAlignment: Word read FcbAlignment write FcbAlignment;
    property wTypeFlags: Word read FwTypeFlags write FwTypeFlags;
    property wMajorVerNum: Word read FwMajorVerNum write FwMajorVerNum;
    property wMinorVerNum: Word read FwMinorVerNum write FwMinorVerNum;
  end;
  
  tagDISPPARAMSWrapper = class(TatRecordWrapper)
  private
    FcArgs: Longint;
    FcNamedArgs: Longint;
  public
    constructor Create(ARecord: tagDISPPARAMS);
    function ObjToRec: tagDISPPARAMS;
  published
    property cArgs: Longint read FcArgs write FcArgs;
    property cNamedArgs: Longint read FcNamedArgs write FcNamedArgs;
  end;
  
  tagEXCEPINFOWrapper = class(TatRecordWrapper)
  private
    FwCode: Word;
    FwReserved: Word;
    FbstrSource: WideString;
    FbstrDescription: WideString;
    FbstrHelpFile: WideString;
    FdwHelpContext: Longint;
    Fscode: HResult;
  public
    constructor Create(ARecord: tagEXCEPINFO);
    function ObjToRec: tagEXCEPINFO;
  published
    property wCode: Word read FwCode write FwCode;
    property wReserved: Word read FwReserved write FwReserved;
    property bstrSource: WideString read FbstrSource write FbstrSource;
    property bstrDescription: WideString read FbstrDescription write FbstrDescription;
    property bstrHelpFile: WideString read FbstrHelpFile write FbstrHelpFile;
    property dwHelpContext: Longint read FdwHelpContext write FdwHelpContext;
    property scode: HResult read Fscode write Fscode;
  end;
  
  tagFUNCDESCWrapper = class(TatRecordWrapper)
  private
    Fmemid: TMemberID;
    Ffunckind: TFuncKind;
    Finvkind: TInvokeKind;
    Fcallconv: TCallConv;
    FcParams: Smallint;
    FcParamsOpt: Smallint;
    FoVft: Smallint;
    FcScodes: Smallint;
    FwFuncFlags: Word;
  public
    constructor Create(ARecord: tagFUNCDESC);
    function ObjToRec: tagFUNCDESC;
  published
    property memid: TMemberID read Fmemid write Fmemid;
    property funckind: TFuncKind read Ffunckind write Ffunckind;
    property invkind: TInvokeKind read Finvkind write Finvkind;
    property callconv: TCallConv read Fcallconv write Fcallconv;
    property cParams: Smallint read FcParams write FcParams;
    property cParamsOpt: Smallint read FcParamsOpt write FcParamsOpt;
    property oVft: Smallint read FoVft write FoVft;
    property cScodes: Smallint read FcScodes write FcScodes;
    property wFuncFlags: Word read FwFuncFlags write FwFuncFlags;
  end;
  
  tagVARDESCWrapper = class(TatRecordWrapper)
  private
    Fmemid: TMemberID;
    FoInst: Longint;
    FwVarFlags: Word;
    Fvarkind: TVarKind;
  public
    constructor Create(ARecord: tagVARDESC);
    function ObjToRec: tagVARDESC;
  published
    property memid: TMemberID read Fmemid write Fmemid;
    property oInst: Longint read FoInst write FoInst;
    property wVarFlags: Word read FwVarFlags write FwVarFlags;
    property varkind: TVarKind read Fvarkind write Fvarkind;
  end;
  
  tagBINDPTRWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagBINDPTR);
    function ObjToRec: tagBINDPTR;
  published
  end;
  
  tagTLIBATTRWrapper = class(TatRecordWrapper)
  private
    Flcid: TLCID;
    Fsyskind: TSysKind;
    FwMajorVerNum: Word;
    FwMinorVerNum: Word;
    FwLibFlags: Word;
  public
    constructor Create(ARecord: tagTLIBATTR);
    function ObjToRec: tagTLIBATTR;
  published
    property lcid: TLCID read Flcid write Flcid;
    property syskind: TSysKind read Fsyskind write Fsyskind;
    property wMajorVerNum: Word read FwMajorVerNum write FwMajorVerNum;
    property wMinorVerNum: Word read FwMinorVerNum write FwMinorVerNum;
    property wLibFlags: Word read FwLibFlags write FwLibFlags;
  end;
  
  tagCUSTDATAITEMWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagCUSTDATAITEM);
    function ObjToRec: tagCUSTDATAITEM;
  published
  end;
  
  tagCUSTDATAWrapper = class(TatRecordWrapper)
  private
    FcCustData: DWORD;
  public
    constructor Create(ARecord: tagCUSTDATA);
    function ObjToRec: tagCUSTDATA;
  published
    property cCustData: DWORD read FcCustData write FcCustData;
  end;
  
  tagPARAMDATAWrapper = class(TatRecordWrapper)
  private
    Fvt: TVarType;
  public
    constructor Create(ARecord: tagPARAMDATA);
    function ObjToRec: tagPARAMDATA;
  published
    property vt: TVarType read Fvt write Fvt;
  end;
  
  tagMETHODDATAWrapper = class(TatRecordWrapper)
  private
    Fdispid: TDispID;
    FiMeth: Integer;
    Fcc: TCallConv;
    FcArgs: Integer;
    FwFlags: Word;
    FvtReturn: TVarType;
  public
    constructor Create(ARecord: tagMETHODDATA);
    function ObjToRec: tagMETHODDATA;
  published
    property dispid: TDispID read Fdispid write Fdispid;
    property iMeth: Integer read FiMeth write FiMeth;
    property cc: TCallConv read Fcc write Fcc;
    property cArgs: Integer read FcArgs write FcArgs;
    property wFlags: Word read FwFlags write FwFlags;
    property vtReturn: TVarType read FvtReturn write FvtReturn;
  end;
  
  tagINTERFACEDATAWrapper = class(TatRecordWrapper)
  private
    FcMembers: Integer;
  public
    constructor Create(ARecord: tagINTERFACEDATA);
    function ObjToRec: tagINTERFACEDATA;
  published
    property cMembers: Integer read FcMembers write FcMembers;
  end;
  
  tagOBJECTDESCRIPTORWrapper = class(TatRecordWrapper)
  private
    FcbSize: Longint;
    FdwDrawAspect: Longint;
    FdwStatus: Longint;
    FdwFullUserTypeName: Longint;
    FdwSrcOfCopy: Longint;
  public
    constructor Create(ARecord: tagOBJECTDESCRIPTOR);
    function ObjToRec: tagOBJECTDESCRIPTOR;
  published
    property cbSize: Longint read FcbSize write FcbSize;
    property dwDrawAspect: Longint read FdwDrawAspect write FdwDrawAspect;
    property dwStatus: Longint read FdwStatus write FdwStatus;
    property dwFullUserTypeName: Longint read FdwFullUserTypeName write FdwFullUserTypeName;
    property dwSrcOfCopy: Longint read FdwSrcOfCopy write FdwSrcOfCopy;
  end;
  
  tagOIFIWrapper = class(TatRecordWrapper)
  private
    Fcb: Integer;
    FfMDIApp: BOOL;
    FhwndFrame: HWND;
    Fhaccel: HAccel;
    FcAccelEntries: Integer;
  public
    constructor Create(ARecord: tagOIFI);
    function ObjToRec: tagOIFI;
  published
    property cb: Integer read Fcb write Fcb;
    property fMDIApp: BOOL read FfMDIApp write FfMDIApp;
    property hwndFrame: HWND read FhwndFrame write FhwndFrame;
    property haccel: HAccel read Fhaccel write Fhaccel;
    property cAccelEntries: Integer read FcAccelEntries write FcAccelEntries;
  end;
  
  tagOleMenuGroupWidthsWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: tagOleMenuGroupWidths);
    function ObjToRec: tagOleMenuGroupWidths;
  published
  end;
  
  tagOLEVERBWrapper = class(TatRecordWrapper)
  private
    FlVerb: Longint;
    FfuFlags: Longint;
    FgrfAttribs: Longint;
  public
    constructor Create(ARecord: tagOLEVERB);
    function ObjToRec: tagOLEVERB;
  published
    property lVerb: Longint read FlVerb write FlVerb;
    property fuFlags: Longint read FfuFlags write FfuFlags;
    property grfAttribs: Longint read FgrfAttribs write FgrfAttribs;
  end;
  
  tagCONNECTDATAWrapper = class(TatRecordWrapper)
  private
    FdwCookie: Longint;
  public
    constructor Create(ARecord: tagCONNECTDATA);
    function ObjToRec: tagCONNECTDATA;
  published
    property dwCookie: Longint read FdwCookie write FdwCookie;
  end;
  
  tagLICINFOWrapper = class(TatRecordWrapper)
  private
    FcbLicInfo: Longint;
    FfRuntimeKeyAvail: BOOL;
    FfLicVerified: BOOL;
  public
    constructor Create(ARecord: tagLICINFO);
    function ObjToRec: tagLICINFO;
  published
    property cbLicInfo: Longint read FcbLicInfo write FcbLicInfo;
    property fRuntimeKeyAvail: BOOL read FfRuntimeKeyAvail write FfRuntimeKeyAvail;
    property fLicVerified: BOOL read FfLicVerified write FfLicVerified;
  end;
  
  tagCAUUIDWrapper = class(TatRecordWrapper)
  private
    FcElems: Longint;
  public
    constructor Create(ARecord: tagCAUUID);
    function ObjToRec: tagCAUUID;
  published
    property cElems: Longint read FcElems write FcElems;
  end;
  
  tagCALPOLESTRWrapper = class(TatRecordWrapper)
  private
    FcElems: Longint;
  public
    constructor Create(ARecord: tagCALPOLESTR);
    function ObjToRec: tagCALPOLESTR;
  published
    property cElems: Longint read FcElems write FcElems;
  end;
  
  tagCADWORDWrapper = class(TatRecordWrapper)
  private
    FcElems: Longint;
  public
    constructor Create(ARecord: tagCADWORD);
    function ObjToRec: tagCADWORD;
  published
    property cElems: Longint read FcElems write FcElems;
  end;
  
  tagOCPFIPARAMSWrapper = class(TatRecordWrapper)
  private
    FcbStructSize: Longint;
    FhWndOwner: HWnd;
    Fx: Integer;
    Fy: Integer;
    FcObjects: Longint;
    FcPages: Longint;
    Flcid: TLCID;
    FdispidInitialProperty: TDispID;
  public
    constructor Create(ARecord: tagOCPFIPARAMS);
    function ObjToRec: tagOCPFIPARAMS;
  published
    property cbStructSize: Longint read FcbStructSize write FcbStructSize;
    property hWndOwner: HWnd read FhWndOwner write FhWndOwner;
    property x: Integer read Fx write Fx;
    property y: Integer read Fy write Fy;
    property cObjects: Longint read FcObjects write FcObjects;
    property cPages: Longint read FcPages write FcPages;
    property lcid: TLCID read Flcid write Flcid;
    property dispidInitialProperty: TDispID read FdispidInitialProperty write FdispidInitialProperty;
  end;
  
  tagPROPPAGEINFOWrapper = class(TatRecordWrapper)
  private
    Fcb: Longint;
    FdwHelpContext: Longint;
  public
    constructor Create(ARecord: tagPROPPAGEINFO);
    function ObjToRec: tagPROPPAGEINFO;
  published
    property cb: Longint read Fcb write Fcb;
    property dwHelpContext: Longint read FdwHelpContext write FdwHelpContext;
  end;
  
  tagSOLE_AUTHENTICATION_SERVICEWrapper = class(TatRecordWrapper)
  private
    FdwAuthnSvc: Longint;
    FdwAuthzSvc: Longint;
    Fhr: HResult;
  public
    constructor Create(ARecord: tagSOLE_AUTHENTICATION_SERVICE);
    function ObjToRec: tagSOLE_AUTHENTICATION_SERVICE;
  published
    property dwAuthnSvc: Longint read FdwAuthnSvc write FdwAuthnSvc;
    property dwAuthzSvc: Longint read FdwAuthzSvc write FdwAuthzSvc;
    property hr: HResult read Fhr write Fhr;
  end;
  
  tagFONTDESCWrapper = class(TatRecordWrapper)
  private
    FcbSizeofstruct: Integer;
    FcySize: Currency;
    FsWeight: Smallint;
    FsCharset: Smallint;
    FfItalic: BOOL;
    FfUnderline: BOOL;
    FfStrikethrough: BOOL;
  public
    constructor Create(ARecord: tagFONTDESC);
    function ObjToRec: tagFONTDESC;
  published
    property cbSizeofstruct: Integer read FcbSizeofstruct write FcbSizeofstruct;
    property cySize: Currency read FcySize write FcySize;
    property sWeight: Smallint read FsWeight write FsWeight;
    property sCharset: Smallint read FsCharset write FsCharset;
    property fItalic: BOOL read FfItalic write FfItalic;
    property fUnderline: BOOL read FfUnderline write FfUnderline;
    property fStrikethrough: BOOL read FfStrikethrough write FfStrikethrough;
  end;
  
  tagPICTDESCWrapper = class(TatRecordWrapper)
  private
    FcbSizeofstruct: Integer;
    FpicType: Integer;
    Fhbitmap: THandle;
    Fhpal: THandle;
    FhMeta: THandle;
    FxExt: Integer;
    FyExt: Integer;
    FhIcon: THandle;
    Fhemf: THandle;
  public
    constructor Create(ARecord: tagPICTDESC);
    function ObjToRec: tagPICTDESC;
  published
    property cbSizeofstruct: Integer read FcbSizeofstruct write FcbSizeofstruct;
    property picType: Integer read FpicType write FpicType;
    property hbitmap: THandle read Fhbitmap write Fhbitmap;
    property hpal: THandle read Fhpal write Fhpal;
    property hMeta: THandle read FhMeta write FhMeta;
    property xExt: Integer read FxExt write FxExt;
    property yExt: Integer read FyExt write FyExt;
    property hIcon: THandle read FhIcon write FhIcon;
    property hemf: THandle read Fhemf write Fhemf;
  end;
  
  tagPAGERANGEWrapper = class(TatRecordWrapper)
  private
    FnFromPage: Longint;
    FnToPage: Longint;
  public
    constructor Create(ARecord: tagPAGERANGE);
    function ObjToRec: tagPAGERANGE;
  published
    property nFromPage: Longint read FnFromPage write FnFromPage;
    property nToPage: Longint read FnToPage write FnToPage;
  end;
  
  tagPAGESETWrapper = class(TatRecordWrapper)
  private
    FcbStruct: Cardinal;
    FfOddPages: BOOL;
    FfEvenPages: BOOL;
    FcPageRange: Cardinal;
  public
    constructor Create(ARecord: tagPAGESET);
    function ObjToRec: tagPAGESET;
  published
    property cbStruct: Cardinal read FcbStruct write FcbStruct;
    property fOddPages: BOOL read FfOddPages write FfOddPages;
    property fEvenPages: BOOL read FfEvenPages write FfEvenPages;
    property cPageRange: Cardinal read FcPageRange write FcPageRange;
  end;
  
  _tagOLECMDWrapper = class(TatRecordWrapper)
  private
    FcmdID: Cardinal;
    Fcmdf: Longint;
  public
    constructor Create(ARecord: _tagOLECMD);
    function ObjToRec: _tagOLECMD;
  published
    property cmdID: Cardinal read FcmdID write FcmdID;
    property cmdf: Longint read Fcmdf write Fcmdf;
  end;
  
  _tagOLECMDTEXTWrapper = class(TatRecordWrapper)
  private
    Fcmdtextf: Longint;
    FcwActual: Cardinal;
    FcwBuf: Cardinal;
  public
    constructor Create(ARecord: _tagOLECMDTEXT);
    function ObjToRec: _tagOLECMDTEXT;
  published
    property cmdtextf: Longint read Fcmdtextf write Fcmdtextf;
    property cwActual: Cardinal read FcwActual write FcwActual;
    property cwBuf: Cardinal read FcwBuf write FcwBuf;
  end;
  
  TCATEGORYINFOWrapper = class(TatRecordWrapper)
  private
    Flcid: UINT;
  public
    constructor Create(ARecord: TCATEGORYINFO);
    function ObjToRec: TCATEGORYINFO;
  published
    property lcid: UINT read Flcid write Flcid;
  end;
  
  tagQACONTAINERWrapper = class(TatRecordWrapper)
  private
    FcbSize: LongInt;
    FdwAmbientFlags: LongInt;
    FcolorFore: OLE_COLOR;
    FcolorBack: OLE_COLOR;
    FdwAppearance: LongInt;
    Flcid: LongInt;
    Fhpal: HPALETTE;
  public
    constructor Create(ARecord: tagQACONTAINER);
    function ObjToRec: tagQACONTAINER;
  published
    property cbSize: LongInt read FcbSize write FcbSize;
    property dwAmbientFlags: LongInt read FdwAmbientFlags write FdwAmbientFlags;
    property colorFore: OLE_COLOR read FcolorFore write FcolorFore;
    property colorBack: OLE_COLOR read FcolorBack write FcolorBack;
    property dwAppearance: LongInt read FdwAppearance write FdwAppearance;
    property lcid: LongInt read Flcid write Flcid;
    property hpal: HPALETTE read Fhpal write Fhpal;
  end;
  
  tagQACONTROLWrapper = class(TatRecordWrapper)
  private
    FcbSize: LongInt;
    FdwMiscStatus: LongInt;
    FdwViewStatus: LongInt;
    FdwEventCookie: LongInt;
    FdwPropNotifyCookie: LongInt;
    FdwPointerActivationPolicy: LongInt;
  public
    constructor Create(ARecord: tagQACONTROL);
    function ObjToRec: tagQACONTROL;
  published
    property cbSize: LongInt read FcbSize write FcbSize;
    property dwMiscStatus: LongInt read FdwMiscStatus write FdwMiscStatus;
    property dwViewStatus: LongInt read FdwViewStatus write FdwViewStatus;
    property dwEventCookie: LongInt read FdwEventCookie write FdwEventCookie;
    property dwPropNotifyCookie: LongInt read FdwPropNotifyCookie write FdwPropNotifyCookie;
    property dwPointerActivationPolicy: LongInt read FdwPointerActivationPolicy write FdwPointerActivationPolicy;
  end;
  

implementation

constructor _OBJECTIDWrapper.Create(ARecord: _OBJECTID);
begin
  inherited Create;
  FUniquifier := ARecord.Uniquifier;
end;

function _OBJECTIDWrapper.ObjToRec: _OBJECTID;
begin
  result.Uniquifier := FUniquifier;
end;

constructor _COSERVERINFOWrapper.Create(ARecord: _COSERVERINFO);
begin
  inherited Create;
  FdwReserved1 := ARecord.dwReserved1;
  FdwReserved2 := ARecord.dwReserved2;
end;

function _COSERVERINFOWrapper.ObjToRec: _COSERVERINFO;
begin
  result.dwReserved1 := FdwReserved1;
  result.dwReserved2 := FdwReserved2;
end;

constructor tagMULTI_QIWrapper.Create(ARecord: tagMULTI_QI);
begin
  inherited Create;
  Fhr := ARecord.hr;
end;

function tagMULTI_QIWrapper.ObjToRec: tagMULTI_QI;
begin
  result.hr := Fhr;
end;

constructor tagSAFEARRAYBOUNDWrapper.Create(ARecord: tagSAFEARRAYBOUND);
begin
  inherited Create;
  FcElements := ARecord.cElements;
  FlLbound := ARecord.lLbound;
end;

function tagSAFEARRAYBOUNDWrapper.ObjToRec: tagSAFEARRAYBOUND;
begin
  result.cElements := FcElements;
  result.lLbound := FlLbound;
end;

constructor tagSAFEARRAYWrapper.Create(ARecord: tagSAFEARRAY);
begin
  inherited Create;
  FcDims := ARecord.cDims;
  FfFeatures := ARecord.fFeatures;
  FcbElements := ARecord.cbElements;
  FcLocks := ARecord.cLocks;
end;

function tagSAFEARRAYWrapper.ObjToRec: tagSAFEARRAY;
begin
  result.cDims := FcDims;
  result.fFeatures := FfFeatures;
  result.cbElements := FcbElements;
  result.cLocks := FcLocks;
end;

constructor tagPOINTFWrapper.Create(ARecord: tagPOINTF);
begin
  inherited Create;
  Fx := ARecord.x;
  Fy := ARecord.y;
end;

function tagPOINTFWrapper.ObjToRec: tagPOINTF;
begin
  result.x := Fx;
  result.y := Fy;
end;

constructor tagCONTROLINFOWrapper.Create(ARecord: tagCONTROLINFO);
begin
  inherited Create;
  Fcb := ARecord.cb;
  FhAccel := ARecord.hAccel;
  FcAccel := ARecord.cAccel;
  FdwFlags := ARecord.dwFlags;
end;

function tagCONTROLINFOWrapper.ObjToRec: tagCONTROLINFO;
begin
  result.cb := Fcb;
  result.hAccel := FhAccel;
  result.cAccel := FcAccel;
  result.dwFlags := FdwFlags;
end;

constructor tagBIND_OPTSWrapper.Create(ARecord: tagBIND_OPTS);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FgrfFlags := ARecord.grfFlags;
  FgrfMode := ARecord.grfMode;
  FdwTickCountDeadline := ARecord.dwTickCountDeadline;
end;

function tagBIND_OPTSWrapper.ObjToRec: tagBIND_OPTS;
begin
  result.cbStruct := FcbStruct;
  result.grfFlags := FgrfFlags;
  result.grfMode := FgrfMode;
  result.dwTickCountDeadline := FdwTickCountDeadline;
end;

constructor tagSTATSTGWrapper.Create(ARecord: tagSTATSTG);
begin
  inherited Create;
  FdwType := ARecord.dwType;
  FcbSize := ARecord.cbSize;
  FgrfMode := ARecord.grfMode;
  FgrfLocksSupported := ARecord.grfLocksSupported;
  FgrfStateBits := ARecord.grfStateBits;
  Freserved := ARecord.reserved;
end;

function tagSTATSTGWrapper.ObjToRec: tagSTATSTG;
begin
  result.dwType := FdwType;
  result.cbSize := FcbSize;
  result.grfMode := FgrfMode;
  result.grfLocksSupported := FgrfLocksSupported;
  result.grfStateBits := FgrfStateBits;
  result.reserved := Freserved;
end;

constructor tagDVTARGETDEVICEWrapper.Create(ARecord: tagDVTARGETDEVICE);
begin
  inherited Create;
  FtdSize := ARecord.tdSize;
  FtdDriverNameOffset := ARecord.tdDriverNameOffset;
  FtdDeviceNameOffset := ARecord.tdDeviceNameOffset;
  FtdPortNameOffset := ARecord.tdPortNameOffset;
  FtdExtDevmodeOffset := ARecord.tdExtDevmodeOffset;
end;

function tagDVTARGETDEVICEWrapper.ObjToRec: tagDVTARGETDEVICE;
begin
  result.tdSize := FtdSize;
  result.tdDriverNameOffset := FtdDriverNameOffset;
  result.tdDeviceNameOffset := FtdDeviceNameOffset;
  result.tdPortNameOffset := FtdPortNameOffset;
  result.tdExtDevmodeOffset := FtdExtDevmodeOffset;
end;

constructor tagFORMATETCWrapper.Create(ARecord: tagFORMATETC);
begin
  inherited Create;
  FcfFormat := ARecord.cfFormat;
  FdwAspect := ARecord.dwAspect;
  Flindex := ARecord.lindex;
  Ftymed := ARecord.tymed;
end;

function tagFORMATETCWrapper.ObjToRec: tagFORMATETC;
begin
  result.cfFormat := FcfFormat;
  result.dwAspect := FdwAspect;
  result.lindex := Flindex;
  result.tymed := Ftymed;
end;

constructor tagSTATDATAWrapper.Create(ARecord: tagSTATDATA);
begin
  inherited Create;
  Fadvf := ARecord.advf;
  FdwConnection := ARecord.dwConnection;
end;

function tagSTATDATAWrapper.ObjToRec: tagSTATDATA;
begin
  result.advf := Fadvf;
  result.dwConnection := FdwConnection;
end;

constructor tagRemSTGMEDIUMWrapper.Create(ARecord: tagRemSTGMEDIUM);
begin
  inherited Create;
  Ftymed := ARecord.tymed;
  FdwHandleType := ARecord.dwHandleType;
  FpData := ARecord.pData;
  FpUnkForRelease := ARecord.pUnkForRelease;
  FcbData := ARecord.cbData;
end;

function tagRemSTGMEDIUMWrapper.ObjToRec: tagRemSTGMEDIUM;
begin
  result.tymed := Ftymed;
  result.dwHandleType := FdwHandleType;
  result.pData := FpData;
  result.pUnkForRelease := FpUnkForRelease;
  result.cbData := FcbData;
end;

constructor tagSTGMEDIUMWrapper.Create(ARecord: tagSTGMEDIUM);
begin
  inherited Create;
  Ftymed := ARecord.tymed;
  FhBitmap := ARecord.hBitmap;
  FhMetaFilePict := ARecord.hMetaFilePict;
  FhEnhMetaFile := ARecord.hEnhMetaFile;
  FhGlobal := ARecord.hGlobal;
end;

function tagSTGMEDIUMWrapper.ObjToRec: tagSTGMEDIUM;
begin
  result.tymed := Ftymed;
  result.hBitmap := FhBitmap;
  result.hMetaFilePict := FhMetaFilePict;
  result.hEnhMetaFile := FhEnhMetaFile;
  result.hGlobal := FhGlobal;
end;

constructor tagINTERFACEINFOWrapper.Create(ARecord: tagINTERFACEINFO);
begin
  inherited Create;
  FwMethod := ARecord.wMethod;
end;

function tagINTERFACEINFOWrapper.ObjToRec: tagINTERFACEINFO;
begin
  result.wMethod := FwMethod;
end;

constructor tagRPCOLEMESSAGEWrapper.Create(ARecord: tagRPCOLEMESSAGE);
begin
  inherited Create;
  FdataRepresentation := ARecord.dataRepresentation;
  FcbBuffer := ARecord.cbBuffer;
  FiMethod := ARecord.iMethod;
  FrpcFlags := ARecord.rpcFlags;
end;

function tagRPCOLEMESSAGEWrapper.ObjToRec: tagRPCOLEMESSAGE;
begin
  result.dataRepresentation := FdataRepresentation;
  result.cbBuffer := FcbBuffer;
  result.iMethod := FiMethod;
  result.rpcFlags := FrpcFlags;
end;

constructor tagDECWrapper.Create(ARecord: tagDEC);
begin
  inherited Create;
  FwReserved := ARecord.wReserved;
  Fscale := ARecord.scale;
  Fsign := ARecord.sign;
  FHi32 := ARecord.Hi32;
  FLo32 := ARecord.Lo32;
  FMid32 := ARecord.Mid32;
  FLo64 := ARecord.Lo64;
  Fsignscale := ARecord.signscale;
end;

function tagDECWrapper.ObjToRec: tagDEC;
begin
  result.wReserved := FwReserved;
  result.scale := Fscale;
  result.sign := Fsign;
  result.Hi32 := FHi32;
  result.Lo32 := FLo32;
  result.Mid32 := FMid32;
  result.Lo64 := FLo64;
  result.signscale := Fsignscale;
end;

constructor tagBLOBWrapper.Create(ARecord: tagBLOB);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
end;

function tagBLOBWrapper.ObjToRec: tagBLOB;
begin
  result.cbSize := FcbSize;
end;

constructor tagCLIPDATAWrapper.Create(ARecord: tagCLIPDATA);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FulClipFmt := ARecord.ulClipFmt;
end;

function tagCLIPDATAWrapper.ObjToRec: tagCLIPDATA;
begin
  result.cbSize := FcbSize;
  result.ulClipFmt := FulClipFmt;
end;

constructor tagCAUBWrapper.Create(ARecord: tagCAUB);
begin
  inherited Create;
  FcElems := ARecord.cElems;
end;

function tagCAUBWrapper.ObjToRec: tagCAUB;
begin
  result.cElems := FcElems;
end;

constructor tagCAIWrapper.Create(ARecord: tagCAI);
begin
  inherited Create;
  FcElems := ARecord.cElems;
end;

function tagCAIWrapper.ObjToRec: tagCAI;
begin
  result.cElems := FcElems;
end;

constructor tagCAUIWrapper.Create(ARecord: tagCAUI);
begin
  inherited Create;
  FcElems := ARecord.cElems;
end;

function tagCAUIWrapper.ObjToRec: tagCAUI;
begin
  result.cElems := FcElems;
end;

constructor tagCALWrapper.Create(ARecord: tagCAL);
begin
  inherited Create;
  FcElems := ARecord.cElems;
end;

function tagCALWrapper.ObjToRec: tagCAL;
begin
  result.cElems := FcElems;
end;

constructor tagCAULWrapper.Create(ARecord: tagCAUL);
begin
  inherited Create;
  FcElems := ARecord.cElems;
end;

function tagCAULWrapper.ObjToRec: tagCAUL;
begin
  result.cElems := FcElems;
end;

constructor tagCAFLTWrapper.Create(ARecord: tagCAFLT);
begin
  inherited Create;
  FcElems := ARecord.cElems;
end;

function tagCAFLTWrapper.ObjToRec: tagCAFLT;
begin
  result.cElems := FcElems;
end;

constructor tagCADBLWrapper.Create(ARecord: tagCADBL);
begin
  inherited Create;
  FcElems := ARecord.cElems;
end;

function tagCADBLWrapper.ObjToRec: tagCADBL;
begin
  result.cElems := FcElems;
end;

constructor tagCACYWrapper.Create(ARecord: tagCACY);
begin
  inherited Create;
  FcElems := ARecord.cElems;
end;

function tagCACYWrapper.ObjToRec: tagCACY;
begin
  result.cElems := FcElems;
end;

constructor tagCADATEWrapper.Create(ARecord: tagCADATE);
begin
  inherited Create;
  FcElems := ARecord.cElems;
end;

function tagCADATEWrapper.ObjToRec: tagCADATE;
begin
  result.cElems := FcElems;
end;

constructor tagCABSTRWrapper.Create(ARecord: tagCABSTR);
begin
  inherited Create;
  FcElems := ARecord.cElems;
end;

function tagCABSTRWrapper.ObjToRec: tagCABSTR;
begin
  result.cElems := FcElems;
end;

constructor tagCABOOLWrapper.Create(ARecord: tagCABOOL);
begin
  inherited Create;
  FcElems := ARecord.cElems;
end;

function tagCABOOLWrapper.ObjToRec: tagCABOOL;
begin
  result.cElems := FcElems;
end;

constructor tagCASCODEWrapper.Create(ARecord: tagCASCODE);
begin
  inherited Create;
  FcElems := ARecord.cElems;
end;

function tagCASCODEWrapper.ObjToRec: tagCASCODE;
begin
  result.cElems := FcElems;
end;

constructor tagCAPROPVARIANTWrapper.Create(ARecord: tagCAPROPVARIANT);
begin
  inherited Create;
  FcElems := ARecord.cElems;
end;

function tagCAPROPVARIANTWrapper.ObjToRec: tagCAPROPVARIANT;
begin
  result.cElems := FcElems;
end;

constructor tagCAHWrapper.Create(ARecord: tagCAH);
begin
  inherited Create;
  FcElems := ARecord.cElems;
end;

function tagCAHWrapper.ObjToRec: tagCAH;
begin
  result.cElems := FcElems;
end;

constructor tagCAUHWrapper.Create(ARecord: tagCAUH);
begin
  inherited Create;
  FcElems := ARecord.cElems;
end;

function tagCAUHWrapper.ObjToRec: tagCAUH;
begin
  result.cElems := FcElems;
end;

constructor tagCALPSTRWrapper.Create(ARecord: tagCALPSTR);
begin
  inherited Create;
  FcElems := ARecord.cElems;
end;

function tagCALPSTRWrapper.ObjToRec: tagCALPSTR;
begin
  result.cElems := FcElems;
end;

constructor tagCALPWSTRWrapper.Create(ARecord: tagCALPWSTR);
begin
  inherited Create;
  FcElems := ARecord.cElems;
end;

function tagCALPWSTRWrapper.ObjToRec: tagCALPWSTR;
begin
  result.cElems := FcElems;
end;

constructor tagCAFILETIMEWrapper.Create(ARecord: tagCAFILETIME);
begin
  inherited Create;
  FcElems := ARecord.cElems;
end;

function tagCAFILETIMEWrapper.ObjToRec: tagCAFILETIME;
begin
  result.cElems := FcElems;
end;

constructor tagCACLIPDATAWrapper.Create(ARecord: tagCACLIPDATA);
begin
  inherited Create;
  FcElems := ARecord.cElems;
end;

function tagCACLIPDATAWrapper.ObjToRec: tagCACLIPDATA;
begin
  result.cElems := FcElems;
end;

constructor tagCACLSIDWrapper.Create(ARecord: tagCACLSID);
begin
  inherited Create;
  FcElems := ARecord.cElems;
end;

function tagCACLSIDWrapper.ObjToRec: tagCACLSID;
begin
  result.cElems := FcElems;
end;

constructor tagPROPVARIANTWrapper.Create(ARecord: tagPROPVARIANT);
begin
  inherited Create;
  Fvt := ARecord.vt;
  FwReserved1 := ARecord.wReserved1;
  FwReserved2 := ARecord.wReserved2;
  FwReserved3 := ARecord.wReserved3;
  FbVal := ARecord.bVal;
  FiVal := ARecord.iVal;
  FuiVal := ARecord.uiVal;
  FboolVal := ARecord.boolVal;
  Fbool := ARecord.bool;
  FlVal := ARecord.lVal;
  FulVal := ARecord.ulVal;
  FfltVal := ARecord.fltVal;
  Fscode := ARecord.scode;
  FdblVal := ARecord.dblVal;
  FcyVal := ARecord.cyVal;
  Fdate := ARecord.date;
end;

function tagPROPVARIANTWrapper.ObjToRec: tagPROPVARIANT;
begin
  result.vt := Fvt;
  result.wReserved1 := FwReserved1;
  result.wReserved2 := FwReserved2;
  result.wReserved3 := FwReserved3;
  result.bVal := FbVal;
  result.iVal := FiVal;
  result.uiVal := FuiVal;
  result.boolVal := FboolVal;
  result.bool := Fbool;
  result.lVal := FlVal;
  result.ulVal := FulVal;
  result.fltVal := FfltVal;
  result.scode := Fscode;
  result.dblVal := FdblVal;
  result.cyVal := FcyVal;
  result.date := Fdate;
end;

constructor tagPROPSPECWrapper.Create(ARecord: tagPROPSPEC);
begin
  inherited Create;
  FulKind := ARecord.ulKind;
  Fpropid := ARecord.propid;
end;

function tagPROPSPECWrapper.ObjToRec: tagPROPSPEC;
begin
  result.ulKind := FulKind;
  result.propid := Fpropid;
end;

constructor tagSTATPROPSTGWrapper.Create(ARecord: tagSTATPROPSTG);
begin
  inherited Create;
  Fpropid := ARecord.propid;
  Fvt := ARecord.vt;
end;

function tagSTATPROPSTGWrapper.ObjToRec: tagSTATPROPSTG;
begin
  result.propid := Fpropid;
  result.vt := Fvt;
end;

constructor tagSTATPROPSETSTGWrapper.Create(ARecord: tagSTATPROPSETSTG);
begin
  inherited Create;
  FgrfFlags := ARecord.grfFlags;
  FdwOSVersion := ARecord.dwOSVersion;
end;

function tagSTATPROPSETSTGWrapper.ObjToRec: tagSTATPROPSETSTG;
begin
  result.grfFlags := FgrfFlags;
  result.dwOSVersion := FdwOSVersion;
end;

constructor tagVARIANTWrapper.Create(ARecord: tagVARIANT);
begin
  inherited Create;
  Fvt := ARecord.vt;
  FwReserved1 := ARecord.wReserved1;
  FwReserved2 := ARecord.wReserved2;
  FwReserved3 := ARecord.wReserved3;
  FbVal := ARecord.bVal;
  FiVal := ARecord.iVal;
  FlVal := ARecord.lVal;
  FfltVal := ARecord.fltVal;
  FdblVal := ARecord.dblVal;
  Fvbool := ARecord.vbool;
  Fscode := ARecord.scode;
  FcyVal := ARecord.cyVal;
  Fdate := ARecord.date;
  FcVal := ARecord.cVal;
  FuiVal := ARecord.uiVal;
  FulVal := ARecord.ulVal;
  FintVal := ARecord.intVal;
  FuintVal := ARecord.uintVal;
end;

function tagVARIANTWrapper.ObjToRec: tagVARIANT;
begin
  result.vt := Fvt;
  result.wReserved1 := FwReserved1;
  result.wReserved2 := FwReserved2;
  result.wReserved3 := FwReserved3;
  result.bVal := FbVal;
  result.iVal := FiVal;
  result.lVal := FlVal;
  result.fltVal := FfltVal;
  result.dblVal := FdblVal;
  result.vbool := Fvbool;
  result.scode := Fscode;
  result.cyVal := FcyVal;
  result.date := Fdate;
  result.cVal := FcVal;
  result.uiVal := FuiVal;
  result.ulVal := FulVal;
  result.intVal := FintVal;
  result.uintVal := FuintVal;
end;

constructor tagTYPEDESCWrapper.Create(ARecord: tagTYPEDESC);
begin
  inherited Create;
  Fvt := ARecord.vt;
  Fhreftype := ARecord.hreftype;
end;

function tagTYPEDESCWrapper.ObjToRec: tagTYPEDESC;
begin
  result.vt := Fvt;
  result.hreftype := Fhreftype;
end;

constructor tagARRAYDESCWrapper.Create(ARecord: tagARRAYDESC);
begin
  inherited Create;
  FcDims := ARecord.cDims;
end;

function tagARRAYDESCWrapper.ObjToRec: tagARRAYDESC;
begin
  result.cDims := FcDims;
end;

constructor tagIDLDESCWrapper.Create(ARecord: tagIDLDESC);
begin
  inherited Create;
  FdwReserved := ARecord.dwReserved;
  FwIDLFlags := ARecord.wIDLFlags;
end;

function tagIDLDESCWrapper.ObjToRec: tagIDLDESC;
begin
  result.dwReserved := FdwReserved;
  result.wIDLFlags := FwIDLFlags;
end;

constructor tagPARAMDESCEXWrapper.Create(ARecord: tagPARAMDESCEX);
begin
  inherited Create;
  FcBytes := ARecord.cBytes;
  FFourBytePad := ARecord.FourBytePad;
end;

function tagPARAMDESCEXWrapper.ObjToRec: tagPARAMDESCEX;
begin
  result.cBytes := FcBytes;
  result.FourBytePad := FFourBytePad;
end;

constructor tagPARAMDESCWrapper.Create(ARecord: tagPARAMDESC);
begin
  inherited Create;
  FwParamFlags := ARecord.wParamFlags;
end;

function tagPARAMDESCWrapper.ObjToRec: tagPARAMDESC;
begin
  result.wParamFlags := FwParamFlags;
end;

constructor tagELEMDESCWrapper.Create(ARecord: tagELEMDESC);
begin
  inherited Create;
end;

function tagELEMDESCWrapper.ObjToRec: tagELEMDESC;
begin
end;

constructor tagTYPEATTRWrapper.Create(ARecord: tagTYPEATTR);
begin
  inherited Create;
  Flcid := ARecord.lcid;
  FdwReserved := ARecord.dwReserved;
  FmemidConstructor := ARecord.memidConstructor;
  FmemidDestructor := ARecord.memidDestructor;
  FcbSizeInstance := ARecord.cbSizeInstance;
  Ftypekind := ARecord.typekind;
  FcFuncs := ARecord.cFuncs;
  FcVars := ARecord.cVars;
  FcImplTypes := ARecord.cImplTypes;
  FcbSizeVft := ARecord.cbSizeVft;
  FcbAlignment := ARecord.cbAlignment;
  FwTypeFlags := ARecord.wTypeFlags;
  FwMajorVerNum := ARecord.wMajorVerNum;
  FwMinorVerNum := ARecord.wMinorVerNum;
end;

function tagTYPEATTRWrapper.ObjToRec: tagTYPEATTR;
begin
  result.lcid := Flcid;
  result.dwReserved := FdwReserved;
  result.memidConstructor := FmemidConstructor;
  result.memidDestructor := FmemidDestructor;
  result.cbSizeInstance := FcbSizeInstance;
  result.typekind := Ftypekind;
  result.cFuncs := FcFuncs;
  result.cVars := FcVars;
  result.cImplTypes := FcImplTypes;
  result.cbSizeVft := FcbSizeVft;
  result.cbAlignment := FcbAlignment;
  result.wTypeFlags := FwTypeFlags;
  result.wMajorVerNum := FwMajorVerNum;
  result.wMinorVerNum := FwMinorVerNum;
end;

constructor tagDISPPARAMSWrapper.Create(ARecord: tagDISPPARAMS);
begin
  inherited Create;
  FcArgs := ARecord.cArgs;
  FcNamedArgs := ARecord.cNamedArgs;
end;

function tagDISPPARAMSWrapper.ObjToRec: tagDISPPARAMS;
begin
  result.cArgs := FcArgs;
  result.cNamedArgs := FcNamedArgs;
end;

constructor tagEXCEPINFOWrapper.Create(ARecord: tagEXCEPINFO);
begin
  inherited Create;
  FwCode := ARecord.wCode;
  FwReserved := ARecord.wReserved;
  FbstrSource := ARecord.bstrSource;
  FbstrDescription := ARecord.bstrDescription;
  FbstrHelpFile := ARecord.bstrHelpFile;
  FdwHelpContext := ARecord.dwHelpContext;
  Fscode := ARecord.scode;
end;

function tagEXCEPINFOWrapper.ObjToRec: tagEXCEPINFO;
begin
  result.wCode := FwCode;
  result.wReserved := FwReserved;
  result.bstrSource := FbstrSource;
  result.bstrDescription := FbstrDescription;
  result.bstrHelpFile := FbstrHelpFile;
  result.dwHelpContext := FdwHelpContext;
  result.scode := Fscode;
end;

constructor tagFUNCDESCWrapper.Create(ARecord: tagFUNCDESC);
begin
  inherited Create;
  Fmemid := ARecord.memid;
  Ffunckind := ARecord.funckind;
  Finvkind := ARecord.invkind;
  Fcallconv := ARecord.callconv;
  FcParams := ARecord.cParams;
  FcParamsOpt := ARecord.cParamsOpt;
  FoVft := ARecord.oVft;
  FcScodes := ARecord.cScodes;
  FwFuncFlags := ARecord.wFuncFlags;
end;

function tagFUNCDESCWrapper.ObjToRec: tagFUNCDESC;
begin
  result.memid := Fmemid;
  result.funckind := Ffunckind;
  result.invkind := Finvkind;
  result.callconv := Fcallconv;
  result.cParams := FcParams;
  result.cParamsOpt := FcParamsOpt;
  result.oVft := FoVft;
  result.cScodes := FcScodes;
  result.wFuncFlags := FwFuncFlags;
end;

constructor tagVARDESCWrapper.Create(ARecord: tagVARDESC);
begin
  inherited Create;
  Fmemid := ARecord.memid;
  FoInst := ARecord.oInst;
  FwVarFlags := ARecord.wVarFlags;
  Fvarkind := ARecord.varkind;
end;

function tagVARDESCWrapper.ObjToRec: tagVARDESC;
begin
  result.memid := Fmemid;
  result.oInst := FoInst;
  result.wVarFlags := FwVarFlags;
  result.varkind := Fvarkind;
end;

constructor tagBINDPTRWrapper.Create(ARecord: tagBINDPTR);
begin
  inherited Create;
end;

function tagBINDPTRWrapper.ObjToRec: tagBINDPTR;
begin
end;

constructor tagTLIBATTRWrapper.Create(ARecord: tagTLIBATTR);
begin
  inherited Create;
  Flcid := ARecord.lcid;
  Fsyskind := ARecord.syskind;
  FwMajorVerNum := ARecord.wMajorVerNum;
  FwMinorVerNum := ARecord.wMinorVerNum;
  FwLibFlags := ARecord.wLibFlags;
end;

function tagTLIBATTRWrapper.ObjToRec: tagTLIBATTR;
begin
  result.lcid := Flcid;
  result.syskind := Fsyskind;
  result.wMajorVerNum := FwMajorVerNum;
  result.wMinorVerNum := FwMinorVerNum;
  result.wLibFlags := FwLibFlags;
end;

constructor tagCUSTDATAITEMWrapper.Create(ARecord: tagCUSTDATAITEM);
begin
  inherited Create;
end;

function tagCUSTDATAITEMWrapper.ObjToRec: tagCUSTDATAITEM;
begin
end;

constructor tagCUSTDATAWrapper.Create(ARecord: tagCUSTDATA);
begin
  inherited Create;
  FcCustData := ARecord.cCustData;
end;

function tagCUSTDATAWrapper.ObjToRec: tagCUSTDATA;
begin
  result.cCustData := FcCustData;
end;

constructor tagPARAMDATAWrapper.Create(ARecord: tagPARAMDATA);
begin
  inherited Create;
  Fvt := ARecord.vt;
end;

function tagPARAMDATAWrapper.ObjToRec: tagPARAMDATA;
begin
  result.vt := Fvt;
end;

constructor tagMETHODDATAWrapper.Create(ARecord: tagMETHODDATA);
begin
  inherited Create;
  Fdispid := ARecord.dispid;
  FiMeth := ARecord.iMeth;
  Fcc := ARecord.cc;
  FcArgs := ARecord.cArgs;
  FwFlags := ARecord.wFlags;
  FvtReturn := ARecord.vtReturn;
end;

function tagMETHODDATAWrapper.ObjToRec: tagMETHODDATA;
begin
  result.dispid := Fdispid;
  result.iMeth := FiMeth;
  result.cc := Fcc;
  result.cArgs := FcArgs;
  result.wFlags := FwFlags;
  result.vtReturn := FvtReturn;
end;

constructor tagINTERFACEDATAWrapper.Create(ARecord: tagINTERFACEDATA);
begin
  inherited Create;
  FcMembers := ARecord.cMembers;
end;

function tagINTERFACEDATAWrapper.ObjToRec: tagINTERFACEDATA;
begin
  result.cMembers := FcMembers;
end;

constructor tagOBJECTDESCRIPTORWrapper.Create(ARecord: tagOBJECTDESCRIPTOR);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwDrawAspect := ARecord.dwDrawAspect;
  FdwStatus := ARecord.dwStatus;
  FdwFullUserTypeName := ARecord.dwFullUserTypeName;
  FdwSrcOfCopy := ARecord.dwSrcOfCopy;
end;

function tagOBJECTDESCRIPTORWrapper.ObjToRec: tagOBJECTDESCRIPTOR;
begin
  result.cbSize := FcbSize;
  result.dwDrawAspect := FdwDrawAspect;
  result.dwStatus := FdwStatus;
  result.dwFullUserTypeName := FdwFullUserTypeName;
  result.dwSrcOfCopy := FdwSrcOfCopy;
end;

constructor tagOIFIWrapper.Create(ARecord: tagOIFI);
begin
  inherited Create;
  Fcb := ARecord.cb;
  FfMDIApp := ARecord.fMDIApp;
  FhwndFrame := ARecord.hwndFrame;
  Fhaccel := ARecord.haccel;
  FcAccelEntries := ARecord.cAccelEntries;
end;

function tagOIFIWrapper.ObjToRec: tagOIFI;
begin
  result.cb := Fcb;
  result.fMDIApp := FfMDIApp;
  result.hwndFrame := FhwndFrame;
  result.haccel := Fhaccel;
  result.cAccelEntries := FcAccelEntries;
end;

constructor tagOleMenuGroupWidthsWrapper.Create(ARecord: tagOleMenuGroupWidths);
begin
  inherited Create;
end;

function tagOleMenuGroupWidthsWrapper.ObjToRec: tagOleMenuGroupWidths;
begin
end;

constructor tagOLEVERBWrapper.Create(ARecord: tagOLEVERB);
begin
  inherited Create;
  FlVerb := ARecord.lVerb;
  FfuFlags := ARecord.fuFlags;
  FgrfAttribs := ARecord.grfAttribs;
end;

function tagOLEVERBWrapper.ObjToRec: tagOLEVERB;
begin
  result.lVerb := FlVerb;
  result.fuFlags := FfuFlags;
  result.grfAttribs := FgrfAttribs;
end;

constructor tagCONNECTDATAWrapper.Create(ARecord: tagCONNECTDATA);
begin
  inherited Create;
  FdwCookie := ARecord.dwCookie;
end;

function tagCONNECTDATAWrapper.ObjToRec: tagCONNECTDATA;
begin
  result.dwCookie := FdwCookie;
end;

constructor tagLICINFOWrapper.Create(ARecord: tagLICINFO);
begin
  inherited Create;
  FcbLicInfo := ARecord.cbLicInfo;
  FfRuntimeKeyAvail := ARecord.fRuntimeKeyAvail;
  FfLicVerified := ARecord.fLicVerified;
end;

function tagLICINFOWrapper.ObjToRec: tagLICINFO;
begin
  result.cbLicInfo := FcbLicInfo;
  result.fRuntimeKeyAvail := FfRuntimeKeyAvail;
  result.fLicVerified := FfLicVerified;
end;

constructor tagCAUUIDWrapper.Create(ARecord: tagCAUUID);
begin
  inherited Create;
  FcElems := ARecord.cElems;
end;

function tagCAUUIDWrapper.ObjToRec: tagCAUUID;
begin
  result.cElems := FcElems;
end;

constructor tagCALPOLESTRWrapper.Create(ARecord: tagCALPOLESTR);
begin
  inherited Create;
  FcElems := ARecord.cElems;
end;

function tagCALPOLESTRWrapper.ObjToRec: tagCALPOLESTR;
begin
  result.cElems := FcElems;
end;

constructor tagCADWORDWrapper.Create(ARecord: tagCADWORD);
begin
  inherited Create;
  FcElems := ARecord.cElems;
end;

function tagCADWORDWrapper.ObjToRec: tagCADWORD;
begin
  result.cElems := FcElems;
end;

constructor tagOCPFIPARAMSWrapper.Create(ARecord: tagOCPFIPARAMS);
begin
  inherited Create;
  FcbStructSize := ARecord.cbStructSize;
  FhWndOwner := ARecord.hWndOwner;
  Fx := ARecord.x;
  Fy := ARecord.y;
  FcObjects := ARecord.cObjects;
  FcPages := ARecord.cPages;
  Flcid := ARecord.lcid;
  FdispidInitialProperty := ARecord.dispidInitialProperty;
end;

function tagOCPFIPARAMSWrapper.ObjToRec: tagOCPFIPARAMS;
begin
  result.cbStructSize := FcbStructSize;
  result.hWndOwner := FhWndOwner;
  result.x := Fx;
  result.y := Fy;
  result.cObjects := FcObjects;
  result.cPages := FcPages;
  result.lcid := Flcid;
  result.dispidInitialProperty := FdispidInitialProperty;
end;

constructor tagPROPPAGEINFOWrapper.Create(ARecord: tagPROPPAGEINFO);
begin
  inherited Create;
  Fcb := ARecord.cb;
  FdwHelpContext := ARecord.dwHelpContext;
end;

function tagPROPPAGEINFOWrapper.ObjToRec: tagPROPPAGEINFO;
begin
  result.cb := Fcb;
  result.dwHelpContext := FdwHelpContext;
end;

constructor tagSOLE_AUTHENTICATION_SERVICEWrapper.Create(ARecord: tagSOLE_AUTHENTICATION_SERVICE);
begin
  inherited Create;
  FdwAuthnSvc := ARecord.dwAuthnSvc;
  FdwAuthzSvc := ARecord.dwAuthzSvc;
  Fhr := ARecord.hr;
end;

function tagSOLE_AUTHENTICATION_SERVICEWrapper.ObjToRec: tagSOLE_AUTHENTICATION_SERVICE;
begin
  result.dwAuthnSvc := FdwAuthnSvc;
  result.dwAuthzSvc := FdwAuthzSvc;
  result.hr := Fhr;
end;

constructor tagFONTDESCWrapper.Create(ARecord: tagFONTDESC);
begin
  inherited Create;
  FcbSizeofstruct := ARecord.cbSizeofstruct;
  FcySize := ARecord.cySize;
  FsWeight := ARecord.sWeight;
  FsCharset := ARecord.sCharset;
  FfItalic := ARecord.fItalic;
  FfUnderline := ARecord.fUnderline;
  FfStrikethrough := ARecord.fStrikethrough;
end;

function tagFONTDESCWrapper.ObjToRec: tagFONTDESC;
begin
  result.cbSizeofstruct := FcbSizeofstruct;
  result.cySize := FcySize;
  result.sWeight := FsWeight;
  result.sCharset := FsCharset;
  result.fItalic := FfItalic;
  result.fUnderline := FfUnderline;
  result.fStrikethrough := FfStrikethrough;
end;

constructor tagPICTDESCWrapper.Create(ARecord: tagPICTDESC);
begin
  inherited Create;
  FcbSizeofstruct := ARecord.cbSizeofstruct;
  FpicType := ARecord.picType;
  Fhbitmap := ARecord.hbitmap;
  Fhpal := ARecord.hpal;
  FhMeta := ARecord.hMeta;
  FxExt := ARecord.xExt;
  FyExt := ARecord.yExt;
  FhIcon := ARecord.hIcon;
  Fhemf := ARecord.hemf;
end;

function tagPICTDESCWrapper.ObjToRec: tagPICTDESC;
begin
  result.cbSizeofstruct := FcbSizeofstruct;
  result.picType := FpicType;
  result.hbitmap := Fhbitmap;
  result.hpal := Fhpal;
  result.hMeta := FhMeta;
  result.xExt := FxExt;
  result.yExt := FyExt;
  result.hIcon := FhIcon;
  result.hemf := Fhemf;
end;

constructor tagPAGERANGEWrapper.Create(ARecord: tagPAGERANGE);
begin
  inherited Create;
  FnFromPage := ARecord.nFromPage;
  FnToPage := ARecord.nToPage;
end;

function tagPAGERANGEWrapper.ObjToRec: tagPAGERANGE;
begin
  result.nFromPage := FnFromPage;
  result.nToPage := FnToPage;
end;

constructor tagPAGESETWrapper.Create(ARecord: tagPAGESET);
begin
  inherited Create;
  FcbStruct := ARecord.cbStruct;
  FfOddPages := ARecord.fOddPages;
  FfEvenPages := ARecord.fEvenPages;
  FcPageRange := ARecord.cPageRange;
end;

function tagPAGESETWrapper.ObjToRec: tagPAGESET;
begin
  result.cbStruct := FcbStruct;
  result.fOddPages := FfOddPages;
  result.fEvenPages := FfEvenPages;
  result.cPageRange := FcPageRange;
end;

constructor _tagOLECMDWrapper.Create(ARecord: _tagOLECMD);
begin
  inherited Create;
  FcmdID := ARecord.cmdID;
  Fcmdf := ARecord.cmdf;
end;

function _tagOLECMDWrapper.ObjToRec: _tagOLECMD;
begin
  result.cmdID := FcmdID;
  result.cmdf := Fcmdf;
end;

constructor _tagOLECMDTEXTWrapper.Create(ARecord: _tagOLECMDTEXT);
begin
  inherited Create;
  Fcmdtextf := ARecord.cmdtextf;
  FcwActual := ARecord.cwActual;
  FcwBuf := ARecord.cwBuf;
end;

function _tagOLECMDTEXTWrapper.ObjToRec: _tagOLECMDTEXT;
begin
  result.cmdtextf := Fcmdtextf;
  result.cwActual := FcwActual;
  result.cwBuf := FcwBuf;
end;

constructor TCATEGORYINFOWrapper.Create(ARecord: TCATEGORYINFO);
begin
  inherited Create;
  Flcid := ARecord.lcid;
end;

function TCATEGORYINFOWrapper.ObjToRec: TCATEGORYINFO;
begin
  result.lcid := Flcid;
end;

constructor tagQACONTAINERWrapper.Create(ARecord: tagQACONTAINER);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwAmbientFlags := ARecord.dwAmbientFlags;
  FcolorFore := ARecord.colorFore;
  FcolorBack := ARecord.colorBack;
  FdwAppearance := ARecord.dwAppearance;
  Flcid := ARecord.lcid;
  Fhpal := ARecord.hpal;
end;

function tagQACONTAINERWrapper.ObjToRec: tagQACONTAINER;
begin
  result.cbSize := FcbSize;
  result.dwAmbientFlags := FdwAmbientFlags;
  result.colorFore := FcolorFore;
  result.colorBack := FcolorBack;
  result.dwAppearance := FdwAppearance;
  result.lcid := Flcid;
  result.hpal := Fhpal;
end;

constructor tagQACONTROLWrapper.Create(ARecord: tagQACONTROL);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwMiscStatus := ARecord.dwMiscStatus;
  FdwViewStatus := ARecord.dwViewStatus;
  FdwEventCookie := ARecord.dwEventCookie;
  FdwPropNotifyCookie := ARecord.dwPropNotifyCookie;
  FdwPointerActivationPolicy := ARecord.dwPointerActivationPolicy;
end;

function tagQACONTROLWrapper.ObjToRec: tagQACONTROL;
begin
  result.cbSize := FcbSize;
  result.dwMiscStatus := FdwMiscStatus;
  result.dwViewStatus := FdwViewStatus;
  result.dwEventCookie := FdwEventCookie;
  result.dwPropNotifyCookie := FdwPropNotifyCookie;
  result.dwPointerActivationPolicy := FdwPointerActivationPolicy;
end;



procedure TatActiveXLibrary.__Succeeded(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ActiveX.Succeeded(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__Failed(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ActiveX.Failed(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__ResultCode(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.ResultCode(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__ResultFacility(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.ResultFacility(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__ResultSeverity(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.ResultSeverity(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__MakeResult(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.MakeResult(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__IsEqualGUID(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ActiveX.IsEqualGUID(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,TGUIDWrapper(integer(GetInputArg(1))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__IsEqualIID(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ActiveX.IsEqualIID(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,TGUIDWrapper(integer(GetInputArg(1))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__IsEqualCLSID(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ActiveX.IsEqualCLSID(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,TGUIDWrapper(integer(GetInputArg(1))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__CoBuildVersion(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.CoBuildVersion);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__CoUninitialize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ActiveX.CoUninitialize;
  end;
end;

procedure TatActiveXLibrary.__CoGetCurrentProcess(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.CoGetCurrentProcess);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__CoRevokeMallocSpy(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.CoRevokeMallocSpy);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__CoRevokeClassObject(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.CoRevokeClassObject(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__CoResumeClassObjects(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.CoResumeClassObjects);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__CoSuspendClassObjects(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.CoSuspendClassObjects);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__CoAddRefServerProcess(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.CoAddRefServerProcess);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__CoReleaseServerProcess(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.CoReleaseServerProcess);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__CoGetPSClsid(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TCLSID;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TGUIDWrapper) then 
  Param1Rec := TGUIDWrapper.Create(Param1);
Param1 := TGUIDWrapper(Param1Rec).ObjToRec;
AResult := Integer(ActiveX.CoGetPSClsid(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TGUIDWrapper.Create(Param1)));
  end;
end;

procedure TatActiveXLibrary.__CoRegisterPSClsid(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.CoRegisterPSClsid(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,TGUIDWrapper(integer(GetInputArg(1))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__CoLoadLibrary(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.CoLoadLibrary(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__CoFreeLibrary(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ActiveX.CoFreeLibrary(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatActiveXLibrary.__CoFreeAllLibraries(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ActiveX.CoFreeAllLibraries;
  end;
end;

procedure TatActiveXLibrary.__CoFreeUnusedLibraries(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ActiveX.CoFreeUnusedLibraries;
  end;
end;

procedure TatActiveXLibrary.__CoImpersonateClient(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.CoImpersonateClient);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__CoRevertToSelf(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.CoRevertToSelf);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__StringFromCLSID(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param1: POleStr;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))));
AResult := Integer(ActiveX.StringFromCLSID(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,WideCharToString(Param1));
  end;
end;

procedure TatActiveXLibrary.__CLSIDFromString(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Rec: TObject;
  Param1: TCLSID;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TGUIDWrapper) then 
  Param1Rec := TGUIDWrapper.Create(Param1);
Param1 := TGUIDWrapper(Param1Rec).ObjToRec;
AResult := Integer(ActiveX.CLSIDFromString(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TGUIDWrapper.Create(Param1)));
  end;
end;

procedure TatActiveXLibrary.__StringFromIID(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param1: POleStr;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))));
AResult := Integer(ActiveX.StringFromIID(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,WideCharToString(Param1));
  end;
end;

procedure TatActiveXLibrary.__IIDFromString(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Rec: TObject;
  Param1: TIID;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TGUIDWrapper) then 
  Param1Rec := TGUIDWrapper.Create(Param1);
Param1 := TGUIDWrapper(Param1Rec).ObjToRec;
AResult := Integer(ActiveX.IIDFromString(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TGUIDWrapper.Create(Param1)));
  end;
end;

procedure TatActiveXLibrary.__CoIsOle1Class(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ActiveX.CoIsOle1Class(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__ProgIDFromCLSID(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param1: POleStr;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))));
AResult := Integer(ActiveX.ProgIDFromCLSID(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,WideCharToString(Param1));
  end;
end;

procedure TatActiveXLibrary.__CLSIDFromProgID(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Rec: TObject;
  Param1: TCLSID;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TGUIDWrapper) then 
  Param1Rec := TGUIDWrapper.Create(Param1);
Param1 := TGUIDWrapper(Param1Rec).ObjToRec;
AResult := Integer(ActiveX.CLSIDFromProgID(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TGUIDWrapper.Create(Param1)));
  end;
end;

procedure TatActiveXLibrary.__StringFromGUID2(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.StringFromGUID2(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__CoCreateGuid(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TGUID;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TGUIDWrapper) then 
  Param0Rec := TGUIDWrapper.Create(Param0);
Param0 := TGUIDWrapper(Param0Rec).ObjToRec;
AResult := Integer(ActiveX.CoCreateGuid(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TGUIDWrapper.Create(Param0)));
  end;
end;

procedure TatActiveXLibrary.__CoFileTimeToDosDateTime(AMachine: TatVirtualMachine);
  var
  Param1: Word;
  Param2: Word;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
Param2 := VarToInteger(GetInputArg(2));
AResult := ActiveX.CoFileTimeToDosDateTime(_FILETIMEWrapper(integer(GetInputArg(0))).ObjToRec,Param1,Param2);
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatActiveXLibrary.__CoDosDateTimeToFileTime(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: TFileTime;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is _FILETIMEWrapper) then 
  Param2Rec := _FILETIMEWrapper.Create(Param2);
Param2 := _FILETIMEWrapper(Param2Rec).ObjToRec;
AResult := ActiveX.CoDosDateTimeToFileTime(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2);
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(_FILETIMEWrapper.Create(Param2)));
  end;
end;

procedure TatActiveXLibrary.__CoFileTimeNow(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TFileTime;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is _FILETIMEWrapper) then 
  Param0Rec := _FILETIMEWrapper.Create(Param0);
Param0 := _FILETIMEWrapper(Param0Rec).ObjToRec;
AResult := Integer(ActiveX.CoFileTimeNow(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(_FILETIMEWrapper.Create(Param0)));
  end;
end;

procedure TatActiveXLibrary.__CoGetTreatAsClass(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TCLSID;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TGUIDWrapper) then 
  Param1Rec := TGUIDWrapper.Create(Param1);
Param1 := TGUIDWrapper(Param1Rec).ObjToRec;
AResult := Integer(ActiveX.CoGetTreatAsClass(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TGUIDWrapper.Create(Param1)));
  end;
end;

procedure TatActiveXLibrary.__CoTreatAsClass(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.CoTreatAsClass(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,TGUIDWrapper(integer(GetInputArg(1))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__StgIsStorageFile(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.StgIsStorageFile(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__StgSetTimes(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.StgSetTimes(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),_FILETIMEWrapper(integer(GetInputArg(1))).ObjToRec,_FILETIMEWrapper(integer(GetInputArg(2))).ObjToRec,_FILETIMEWrapper(integer(GetInputArg(3))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__GetClassFile(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param1Rec: TObject;
  Param1: TCLSID;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TGUIDWrapper) then 
  Param1Rec := TGUIDWrapper.Create(Param1);
Param1 := TGUIDWrapper(Param1Rec).ObjToRec;
AResult := Integer(ActiveX.GetClassFile(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TGUIDWrapper.Create(Param1)));
  end;
end;

procedure TatActiveXLibrary.__SysAllocString(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ActiveX.SysAllocString(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__SysReAllocString(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param0: TBStr;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))));
AResult := Integer(ActiveX.SysReAllocString(Param0,StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
    SetInputArg(0,WideCharToString(Param0));
  end;
end;

procedure TatActiveXLibrary.__SysAllocStringLen(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ActiveX.SysAllocStringLen(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__SysReAllocStringLen(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  Param0: TBStr;
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))));
AResult := Integer(ActiveX.SysReAllocStringLen(Param0,StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
    SetInputArg(0,WideCharToString(Param0));
  end;
end;

procedure TatActiveXLibrary.__SysFreeString(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
begin
  with AMachine do
  begin
    ActiveX.SysFreeString(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))));
  end;
end;

procedure TatActiveXLibrary.__SysStringLen(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.SysStringLen(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__SysStringByteLen(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.SysStringByteLen(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__SysAllocStringByteLen(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ActiveX.SysAllocStringByteLen(PChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__DosDateTimeToVariantTime(AMachine: TatVirtualMachine);
  var
  Param2: TOleDate;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
AResult := Integer(ActiveX.DosDateTimeToVariantTime(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Param2);
  end;
end;

procedure TatActiveXLibrary.__VariantTimeToDosDateTime(AMachine: TatVirtualMachine);
  var
  Param1: Word;
  Param2: Word;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(ActiveX.VariantTimeToDosDateTime(GetInputArg(0),Param1,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatActiveXLibrary.__SystemTimeToVariantTime(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TSystemTime;
  Param1: TOleDate;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is _SYSTEMTIMEWrapper) then 
  Param0Rec := _SYSTEMTIMEWrapper.Create(Param0);
Param0 := _SYSTEMTIMEWrapper(Param0Rec).ObjToRec;
Param1 := GetInputArg(1);
AResult := Integer(ActiveX.SystemTimeToVariantTime(Param0,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(_SYSTEMTIMEWrapper.Create(Param0)));
    SetInputArg(1,Param1);
  end;
end;

procedure TatActiveXLibrary.__VariantTimeToSystemTime(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TSystemTime;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is _SYSTEMTIMEWrapper) then 
  Param1Rec := _SYSTEMTIMEWrapper.Create(Param1);
Param1 := _SYSTEMTIMEWrapper(Param1Rec).ObjToRec;
AResult := Integer(ActiveX.VariantTimeToSystemTime(GetInputArg(0),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(_SYSTEMTIMEWrapper.Create(Param1)));
  end;
end;

procedure TatActiveXLibrary.__VariantInit(AMachine: TatVirtualMachine);
  var
  Param0: OleVariant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    ActiveX.VariantInit(Param0);
    SetInputArg(0,Param0);
  end;
end;

procedure TatActiveXLibrary.__VariantClear(AMachine: TatVirtualMachine);
  var
  Param0: OleVariant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(ActiveX.VariantClear(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatActiveXLibrary.__VariantCopy(AMachine: TatVirtualMachine);
  var
  Param0: OleVariant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(ActiveX.VariantCopy(Param0,GetInputArg(1)));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatActiveXLibrary.__VariantCopyInd(AMachine: TatVirtualMachine);
  var
  Param0: OleVariant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(ActiveX.VariantCopyInd(Param0,GetInputArg(1)));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatActiveXLibrary.__VariantChangeType(AMachine: TatVirtualMachine);
  var
  Param0: OleVariant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(ActiveX.VariantChangeType(Param0,GetInputArg(1),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatActiveXLibrary.__VariantChangeTypeEx(AMachine: TatVirtualMachine);
  var
  Param0: OleVariant;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := Integer(ActiveX.VariantChangeTypeEx(Param0,GetInputArg(1),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatActiveXLibrary.__LHashValOfNameSys(AMachine: TatVirtualMachine);
  var
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.LHashValOfNameSys(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__LHashValOfNameSysA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.LHashValOfNameSysA(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),PChar(VarToStr(GetInputArg(2)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__LHashValOfName(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.LHashValOfName(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__IsHashValCompatible(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ActiveX.IsHashValCompatible(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__QueryPathOfRegTypeLib(AMachine: TatVirtualMachine);
  var
  Param4: WideString;
  AResult: variant;
begin
  with AMachine do
  begin
Param4 := GetInputArg(4);
AResult := Integer(ActiveX.QueryPathOfRegTypeLib(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),Param4));
    ReturnOutputArg(AResult);
    SetInputArg(4,Param4);
  end;
end;

procedure TatActiveXLibrary.__UnRegisterTypeLib(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.UnRegisterTypeLib(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__DispGetParam(AMachine: TatVirtualMachine);
  var
  Param3: OleVariant;
  Param4: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := GetInputArg(3);
Param4 := VarToInteger(GetInputArg(4));
AResult := Integer(ActiveX.DispGetParam(tagDISPPARAMSWrapper(integer(GetInputArg(0))).ObjToRec,VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3,Param4));
    ReturnOutputArg(AResult);
    SetInputArg(3,Param3);
    SetInputArg(4,Integer(Param4));
  end;
end;

procedure TatActiveXLibrary.__OaBuildVersion(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.OaBuildVersion);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__ClearCustData(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TCustData;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagCUSTDATAWrapper) then 
  Param0Rec := tagCUSTDATAWrapper.Create(Param0);
Param0 := tagCUSTDATAWrapper(Param0Rec).ObjToRec;
    ActiveX.ClearCustData(Param0);
    SetInputArg(0,integer(tagCUSTDATAWrapper.Create(Param0)));
  end;
end;

procedure TatActiveXLibrary.__OleBuildVersion(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.OleBuildVersion);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__OleUninitialize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ActiveX.OleUninitialize;
  end;
end;

procedure TatActiveXLibrary.__RevokeDragDrop(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.RevokeDragDrop(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__OleFlushClipboard(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.OleFlushClipboard);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__OleCreateMenuDescriptor(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TOleMenuGroupWidths;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is tagOleMenuGroupWidthsWrapper) then 
  Param1Rec := tagOleMenuGroupWidthsWrapper.Create(Param1);
Param1 := tagOleMenuGroupWidthsWrapper(Param1Rec).ObjToRec;
AResult := Integer(ActiveX.OleCreateMenuDescriptor(VarToInteger(GetInputArg(0)),Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(tagOleMenuGroupWidthsWrapper.Create(Param1)));
  end;
end;

procedure TatActiveXLibrary.__OleDestroyMenuDescriptor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.OleDestroyMenuDescriptor(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__OleDuplicateData(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.OleDuplicateData(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__ReleaseStgMedium(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TStgMedium;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagSTGMEDIUMWrapper) then 
  Param0Rec := tagSTGMEDIUMWrapper.Create(Param0);
Param0 := tagSTGMEDIUMWrapper(Param0Rec).ObjToRec;
    ActiveX.ReleaseStgMedium(Param0);
    SetInputArg(0,integer(tagSTGMEDIUMWrapper.Create(Param0)));
  end;
end;

procedure TatActiveXLibrary.__OleGetIconOfFile(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.OleGetIconOfFile(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__OleGetIconOfClass(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.OleGetIconOfClass(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__OleMetafilePictFromIconAndLabel(AMachine: TatVirtualMachine);
  var
  Param1Buf: array[0..127] of WideChar;
  Param2Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.OleMetafilePictFromIconAndLabel(VarToInteger(GetInputArg(0)),StringToWideChar(VarToStr(GetInputArg(1)),Param1Buf,Length(VarToStr(GetInputArg(1)))),StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2)))),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__OleRegGetUserType(AMachine: TatVirtualMachine);
  var
  Param2Buf: array[0..127] of WideChar;
  Param2: POleStr;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := StringToWideChar(VarToStr(GetInputArg(2)),Param2Buf,Length(VarToStr(GetInputArg(2))));
AResult := Integer(ActiveX.OleRegGetUserType(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,WideCharToString(Param2));
  end;
end;

procedure TatActiveXLibrary.__OleRegGetMiscStatus(AMachine: TatVirtualMachine);
  var
  Param2: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(ActiveX.OleRegGetMiscStatus(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatActiveXLibrary.__OleGetAutoConvert(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TCLSID;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TGUIDWrapper) then 
  Param1Rec := TGUIDWrapper.Create(Param1);
Param1 := TGUIDWrapper(Param1Rec).ObjToRec;
AResult := Integer(ActiveX.OleGetAutoConvert(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TGUIDWrapper.Create(Param1)));
  end;
end;

procedure TatActiveXLibrary.__OleSetAutoConvert(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.OleSetAutoConvert(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,TGUIDWrapper(integer(GetInputArg(1))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__OleCreatePropertyFrameIndirect(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.OleCreatePropertyFrameIndirect(tagOCPFIPARAMSWrapper(integer(GetInputArg(0))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__OleTranslateColor(AMachine: TatVirtualMachine);
  var
  Param2: TColorRef;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(ActiveX.OleTranslateColor(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatActiveXLibrary.__OleCreateFontIndirect(AMachine: TatVirtualMachine);
  var
  Param2: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
AResult := Integer(ActiveX.OleCreateFontIndirect(tagFONTDESCWrapper(integer(GetInputArg(0))).ObjToRec,TGUIDWrapper(integer(GetInputArg(1))).ObjToRec,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,Param2);
  end;
end;

procedure TatActiveXLibrary.__OleCreatePictureIndirect(AMachine: TatVirtualMachine);
  var
  Param3: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := GetInputArg(3);
AResult := Integer(ActiveX.OleCreatePictureIndirect(tagPICTDESCWrapper(integer(GetInputArg(0))).ObjToRec,TGUIDWrapper(integer(GetInputArg(1))).ObjToRec,GetInputArg(2),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Param3);
  end;
end;

procedure TatActiveXLibrary.__OleIconToCursor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.OleIconToCursor(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__PROPSETHDR_OSVER_KIND(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.PROPSETHDR_OSVER_KIND(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__PROPSETHDR_OSVER_MAJOR(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.PROPSETHDR_OSVER_MAJOR(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__PROPSETHDR_OSVER_MINOR(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ActiveX.PROPSETHDR_OSVER_MINOR(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActiveXLibrary.__GetCATID_Designer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ActiveX.CATID_Designer)));
  end;
end;

procedure TatActiveXLibrary.__GetCATID_WebDesigntimeControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ActiveX.CATID_WebDesigntimeControl)));
  end;
end;

procedure TatActiveXLibrary.__GetGUID_NULL(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ActiveX.GUID_NULL)));
  end;
end;

procedure TatActiveXLibrary.__GetGUID_OLE_COLOR(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ActiveX.GUID_OLE_COLOR)));
  end;
end;

procedure TatActiveXLibrary.__GetIID_IRpcChannel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ActiveX.IID_IRpcChannel)));
  end;
end;

procedure TatActiveXLibrary.__GetIID_IRpcStub(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ActiveX.IID_IRpcStub)));
  end;
end;

procedure TatActiveXLibrary.__GetIID_IStubManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ActiveX.IID_IStubManager)));
  end;
end;

procedure TatActiveXLibrary.__GetIID_IRpcProxy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ActiveX.IID_IRpcProxy)));
  end;
end;

procedure TatActiveXLibrary.__GetIID_IProxyManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ActiveX.IID_IProxyManager)));
  end;
end;

procedure TatActiveXLibrary.__GetIID_IPSFactory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ActiveX.IID_IPSFactory)));
  end;
end;

procedure TatActiveXLibrary.__GetIID_IInternalMoniker(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ActiveX.IID_IInternalMoniker)));
  end;
end;

procedure TatActiveXLibrary.__GetCLSID_StdMarshal(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ActiveX.CLSID_StdMarshal)));
  end;
end;

procedure TatActiveXLibrary.__GetIID_IEnumGeneric(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ActiveX.IID_IEnumGeneric)));
  end;
end;

procedure TatActiveXLibrary.__GetIID_IEnumHolder(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ActiveX.IID_IEnumHolder)));
  end;
end;

procedure TatActiveXLibrary.__GetIID_IEnumCallback(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ActiveX.IID_IEnumCallback)));
  end;
end;

procedure TatActiveXLibrary.__GetIID_IOleManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ActiveX.IID_IOleManager)));
  end;
end;

procedure TatActiveXLibrary.__GetIID_IOlePresObj(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ActiveX.IID_IOlePresObj)));
  end;
end;

procedure TatActiveXLibrary.__GetIID_IDebug(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ActiveX.IID_IDebug)));
  end;
end;

procedure TatActiveXLibrary.__GetIID_IDebugStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ActiveX.IID_IDebugStream)));
  end;
end;

procedure TatActiveXLibrary.__GetCLSID_CFontPropPage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ActiveX.CLSID_CFontPropPage)));
  end;
end;

procedure TatActiveXLibrary.__GetCLSID_CColorPropPage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ActiveX.CLSID_CColorPropPage)));
  end;
end;

procedure TatActiveXLibrary.__GetCLSID_CPicturePropPage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ActiveX.CLSID_CPicturePropPage)));
  end;
end;

procedure TatActiveXLibrary.__GetCLSID_PersistPropset(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ActiveX.CLSID_PersistPropset)));
  end;
end;

procedure TatActiveXLibrary.__GetCLSID_ConvertVBX(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ActiveX.CLSID_ConvertVBX)));
  end;
end;

procedure TatActiveXLibrary.__GetCLSID_StdFont(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ActiveX.CLSID_StdFont)));
  end;
end;

procedure TatActiveXLibrary.__GetCLSID_StdPicture(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ActiveX.CLSID_StdPicture)));
  end;
end;

procedure TatActiveXLibrary.__GetCLSID_StdComponentCategoryMgr(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(ActiveX.CLSID_StdComponentCategoryMgr)));
  end;
end;

procedure TatActiveXLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('Succeeded',1,tkVariant,nil,__Succeeded,false,0);
    DefineMethod('Failed',1,tkVariant,nil,__Failed,false,0);
    DefineMethod('ResultCode',1,tkInteger,nil,__ResultCode,false,0);
    DefineMethod('ResultFacility',1,tkInteger,nil,__ResultFacility,false,0);
    DefineMethod('ResultSeverity',1,tkInteger,nil,__ResultSeverity,false,0);
    DefineMethod('MakeResult',3,tkInteger,nil,__MakeResult,false,0);
    DefineMethod('IsEqualGUID',2,tkVariant,nil,__IsEqualGUID,false,0);
    DefineMethod('IsEqualIID',2,tkVariant,nil,__IsEqualIID,false,0);
    DefineMethod('IsEqualCLSID',2,tkVariant,nil,__IsEqualCLSID,false,0);
    DefineMethod('CoBuildVersion',0,tkInteger,nil,__CoBuildVersion,false,0);
    DefineMethod('CoUninitialize',0,tkNone,nil,__CoUninitialize,false,0);
    DefineMethod('CoGetCurrentProcess',0,tkInteger,nil,__CoGetCurrentProcess,false,0);
    DefineMethod('CoRevokeMallocSpy',0,tkInteger,nil,__CoRevokeMallocSpy,false,0);
    DefineMethod('CoRevokeClassObject',1,tkInteger,nil,__CoRevokeClassObject,false,0);
    DefineMethod('CoResumeClassObjects',0,tkInteger,nil,__CoResumeClassObjects,false,0);
    DefineMethod('CoSuspendClassObjects',0,tkInteger,nil,__CoSuspendClassObjects,false,0);
    DefineMethod('CoAddRefServerProcess',0,tkInteger,nil,__CoAddRefServerProcess,false,0);
    DefineMethod('CoReleaseServerProcess',0,tkInteger,nil,__CoReleaseServerProcess,false,0);
    DefineMethod('CoGetPSClsid',2,tkInteger,nil,__CoGetPSClsid,false,0).SetVarArgs([1]);
    DefineMethod('CoRegisterPSClsid',2,tkInteger,nil,__CoRegisterPSClsid,false,0);
    DefineMethod('CoLoadLibrary',2,tkInteger,nil,__CoLoadLibrary,false,0);
    DefineMethod('CoFreeLibrary',1,tkNone,nil,__CoFreeLibrary,false,0);
    DefineMethod('CoFreeAllLibraries',0,tkNone,nil,__CoFreeAllLibraries,false,0);
    DefineMethod('CoFreeUnusedLibraries',0,tkNone,nil,__CoFreeUnusedLibraries,false,0);
    DefineMethod('CoImpersonateClient',0,tkInteger,nil,__CoImpersonateClient,false,0);
    DefineMethod('CoRevertToSelf',0,tkInteger,nil,__CoRevertToSelf,false,0);
    DefineMethod('StringFromCLSID',2,tkInteger,nil,__StringFromCLSID,false,0).SetVarArgs([1]);
    DefineMethod('CLSIDFromString',2,tkInteger,nil,__CLSIDFromString,false,0).SetVarArgs([1]);
    DefineMethod('StringFromIID',2,tkInteger,nil,__StringFromIID,false,0).SetVarArgs([1]);
    DefineMethod('IIDFromString',2,tkInteger,nil,__IIDFromString,false,0).SetVarArgs([1]);
    DefineMethod('CoIsOle1Class',1,tkVariant,nil,__CoIsOle1Class,false,0);
    DefineMethod('ProgIDFromCLSID',2,tkInteger,nil,__ProgIDFromCLSID,false,0).SetVarArgs([1]);
    DefineMethod('CLSIDFromProgID',2,tkInteger,nil,__CLSIDFromProgID,false,0).SetVarArgs([1]);
    DefineMethod('StringFromGUID2',3,tkInteger,nil,__StringFromGUID2,false,0);
    DefineMethod('CoCreateGuid',1,tkInteger,nil,__CoCreateGuid,false,0).SetVarArgs([0]);
    DefineMethod('CoFileTimeToDosDateTime',3,tkVariant,nil,__CoFileTimeToDosDateTime,false,0).SetVarArgs([1,2]);
    DefineMethod('CoDosDateTimeToFileTime',3,tkVariant,nil,__CoDosDateTimeToFileTime,false,0).SetVarArgs([2]);
    DefineMethod('CoFileTimeNow',1,tkInteger,nil,__CoFileTimeNow,false,0).SetVarArgs([0]);
    DefineMethod('CoGetTreatAsClass',2,tkInteger,nil,__CoGetTreatAsClass,false,0).SetVarArgs([1]);
    DefineMethod('CoTreatAsClass',2,tkInteger,nil,__CoTreatAsClass,false,0);
    DefineMethod('StgIsStorageFile',1,tkInteger,nil,__StgIsStorageFile,false,0);
    DefineMethod('StgSetTimes',4,tkInteger,nil,__StgSetTimes,false,0);
    DefineMethod('GetClassFile',2,tkInteger,nil,__GetClassFile,false,0).SetVarArgs([1]);
    DefineMethod('SysAllocString',1,tkVariant,nil,__SysAllocString,false,0);
    DefineMethod('SysReAllocString',2,tkInteger,nil,__SysReAllocString,false,0).SetVarArgs([0]);
    DefineMethod('SysAllocStringLen',2,tkVariant,nil,__SysAllocStringLen,false,0);
    DefineMethod('SysReAllocStringLen',3,tkInteger,nil,__SysReAllocStringLen,false,0).SetVarArgs([0]);
    DefineMethod('SysFreeString',1,tkNone,nil,__SysFreeString,false,0);
    DefineMethod('SysStringLen',1,tkInteger,nil,__SysStringLen,false,0);
    DefineMethod('SysStringByteLen',1,tkInteger,nil,__SysStringByteLen,false,0);
    DefineMethod('SysAllocStringByteLen',2,tkVariant,nil,__SysAllocStringByteLen,false,0);
    DefineMethod('DosDateTimeToVariantTime',3,tkInteger,nil,__DosDateTimeToVariantTime,false,0).SetVarArgs([2]);
    DefineMethod('VariantTimeToDosDateTime',3,tkInteger,nil,__VariantTimeToDosDateTime,false,0).SetVarArgs([1,2]);
    DefineMethod('SystemTimeToVariantTime',2,tkInteger,nil,__SystemTimeToVariantTime,false,0).SetVarArgs([0,1]);
    DefineMethod('VariantTimeToSystemTime',2,tkInteger,nil,__VariantTimeToSystemTime,false,0).SetVarArgs([1]);
    DefineMethod('VariantInit',1,tkNone,nil,__VariantInit,false,0).SetVarArgs([0]);
    DefineMethod('VariantClear',1,tkInteger,nil,__VariantClear,false,0).SetVarArgs([0]);
    DefineMethod('VariantCopy',2,tkInteger,nil,__VariantCopy,false,0).SetVarArgs([0]);
    DefineMethod('VariantCopyInd',2,tkInteger,nil,__VariantCopyInd,false,0).SetVarArgs([0]);
    DefineMethod('VariantChangeType',4,tkInteger,nil,__VariantChangeType,false,0).SetVarArgs([0]);
    DefineMethod('VariantChangeTypeEx',5,tkInteger,nil,__VariantChangeTypeEx,false,0).SetVarArgs([0]);
    DefineMethod('LHashValOfNameSys',3,tkInteger,nil,__LHashValOfNameSys,false,0);
    DefineMethod('LHashValOfNameSysA',3,tkInteger,nil,__LHashValOfNameSysA,false,0);
    DefineMethod('LHashValOfName',2,tkInteger,nil,__LHashValOfName,false,0);
    DefineMethod('IsHashValCompatible',2,tkVariant,nil,__IsHashValCompatible,false,0);
    DefineMethod('QueryPathOfRegTypeLib',5,tkInteger,nil,__QueryPathOfRegTypeLib,false,0).SetVarArgs([4]);
    DefineMethod('UnRegisterTypeLib',5,tkInteger,nil,__UnRegisterTypeLib,false,0);
    DefineMethod('DispGetParam',5,tkInteger,nil,__DispGetParam,false,0).SetVarArgs([3,4]);
    DefineMethod('OaBuildVersion',0,tkInteger,nil,__OaBuildVersion,false,0);
    DefineMethod('ClearCustData',1,tkNone,nil,__ClearCustData,false,0).SetVarArgs([0]);
    DefineMethod('OleBuildVersion',0,tkInteger,nil,__OleBuildVersion,false,0);
    DefineMethod('OleUninitialize',0,tkNone,nil,__OleUninitialize,false,0);
    DefineMethod('RevokeDragDrop',1,tkInteger,nil,__RevokeDragDrop,false,0);
    DefineMethod('OleFlushClipboard',0,tkInteger,nil,__OleFlushClipboard,false,0);
    DefineMethod('OleCreateMenuDescriptor',2,tkInteger,nil,__OleCreateMenuDescriptor,false,0).SetVarArgs([1]);
    DefineMethod('OleDestroyMenuDescriptor',1,tkInteger,nil,__OleDestroyMenuDescriptor,false,0);
    DefineMethod('OleDuplicateData',3,tkInteger,nil,__OleDuplicateData,false,0);
    DefineMethod('ReleaseStgMedium',1,tkNone,nil,__ReleaseStgMedium,false,0).SetVarArgs([0]);
    DefineMethod('OleGetIconOfFile',2,tkInteger,nil,__OleGetIconOfFile,false,0);
    DefineMethod('OleGetIconOfClass',3,tkInteger,nil,__OleGetIconOfClass,false,0);
    DefineMethod('OleMetafilePictFromIconAndLabel',4,tkInteger,nil,__OleMetafilePictFromIconAndLabel,false,0);
    DefineMethod('OleRegGetUserType',3,tkInteger,nil,__OleRegGetUserType,false,0).SetVarArgs([2]);
    DefineMethod('OleRegGetMiscStatus',3,tkInteger,nil,__OleRegGetMiscStatus,false,0).SetVarArgs([2]);
    DefineMethod('OleGetAutoConvert',2,tkInteger,nil,__OleGetAutoConvert,false,0).SetVarArgs([1]);
    DefineMethod('OleSetAutoConvert',2,tkInteger,nil,__OleSetAutoConvert,false,0);
    DefineMethod('OleCreatePropertyFrameIndirect',1,tkInteger,nil,__OleCreatePropertyFrameIndirect,false,0);
    DefineMethod('OleTranslateColor',3,tkInteger,nil,__OleTranslateColor,false,0).SetVarArgs([2]);
    DefineMethod('OleCreateFontIndirect',3,tkInteger,nil,__OleCreateFontIndirect,false,0).SetVarArgs([2]);
    DefineMethod('OleCreatePictureIndirect',4,tkInteger,nil,__OleCreatePictureIndirect,false,0).SetVarArgs([3]);
    DefineMethod('OleIconToCursor',2,tkInteger,nil,__OleIconToCursor,false,0);
    DefineMethod('PROPSETHDR_OSVER_KIND',1,tkInteger,nil,__PROPSETHDR_OSVER_KIND,false,0);
    DefineMethod('PROPSETHDR_OSVER_MAJOR',1,tkInteger,nil,__PROPSETHDR_OSVER_MAJOR,false,0);
    DefineMethod('PROPSETHDR_OSVER_MINOR',1,tkInteger,nil,__PROPSETHDR_OSVER_MINOR,false,0);
    DefineProp('CATID_Designer',tkVariant,__GetCATID_Designer,nil,nil,false,0);
    DefineProp('CATID_WebDesigntimeControl',tkVariant,__GetCATID_WebDesigntimeControl,nil,nil,false,0);
    DefineProp('GUID_NULL',tkVariant,__GetGUID_NULL,nil,nil,false,0);
    DefineProp('GUID_OLE_COLOR',tkVariant,__GetGUID_OLE_COLOR,nil,nil,false,0);
    DefineProp('IID_IRpcChannel',tkVariant,__GetIID_IRpcChannel,nil,nil,false,0);
    DefineProp('IID_IRpcStub',tkVariant,__GetIID_IRpcStub,nil,nil,false,0);
    DefineProp('IID_IStubManager',tkVariant,__GetIID_IStubManager,nil,nil,false,0);
    DefineProp('IID_IRpcProxy',tkVariant,__GetIID_IRpcProxy,nil,nil,false,0);
    DefineProp('IID_IProxyManager',tkVariant,__GetIID_IProxyManager,nil,nil,false,0);
    DefineProp('IID_IPSFactory',tkVariant,__GetIID_IPSFactory,nil,nil,false,0);
    DefineProp('IID_IInternalMoniker',tkVariant,__GetIID_IInternalMoniker,nil,nil,false,0);
    DefineProp('CLSID_StdMarshal',tkVariant,__GetCLSID_StdMarshal,nil,nil,false,0);
    DefineProp('IID_IEnumGeneric',tkVariant,__GetIID_IEnumGeneric,nil,nil,false,0);
    DefineProp('IID_IEnumHolder',tkVariant,__GetIID_IEnumHolder,nil,nil,false,0);
    DefineProp('IID_IEnumCallback',tkVariant,__GetIID_IEnumCallback,nil,nil,false,0);
    DefineProp('IID_IOleManager',tkVariant,__GetIID_IOleManager,nil,nil,false,0);
    DefineProp('IID_IOlePresObj',tkVariant,__GetIID_IOlePresObj,nil,nil,false,0);
    DefineProp('IID_IDebug',tkVariant,__GetIID_IDebug,nil,nil,false,0);
    DefineProp('IID_IDebugStream',tkVariant,__GetIID_IDebugStream,nil,nil,false,0);
    DefineProp('CLSID_CFontPropPage',tkVariant,__GetCLSID_CFontPropPage,nil,nil,false,0);
    DefineProp('CLSID_CColorPropPage',tkVariant,__GetCLSID_CColorPropPage,nil,nil,false,0);
    DefineProp('CLSID_CPicturePropPage',tkVariant,__GetCLSID_CPicturePropPage,nil,nil,false,0);
    DefineProp('CLSID_PersistPropset',tkVariant,__GetCLSID_PersistPropset,nil,nil,false,0);
    DefineProp('CLSID_ConvertVBX',tkVariant,__GetCLSID_ConvertVBX,nil,nil,false,0);
    DefineProp('CLSID_StdFont',tkVariant,__GetCLSID_StdFont,nil,nil,false,0);
    DefineProp('CLSID_StdPicture',tkVariant,__GetCLSID_StdPicture,nil,nil,false,0);
    DefineProp('CLSID_StdComponentCategoryMgr',tkVariant,__GetCLSID_StdComponentCategoryMgr,nil,nil,false,0);
    AddConstant('REGKIND_DEFAULT',REGKIND_DEFAULT);
    AddConstant('REGKIND_REGISTER',REGKIND_REGISTER);
    AddConstant('REGKIND_NONE',REGKIND_NONE);
    AddConstant('MEMCTX_TASK',MEMCTX_TASK);
    AddConstant('MEMCTX_SHARED',MEMCTX_SHARED);
    AddConstant('MEMCTX_MACSYSTEM',MEMCTX_MACSYSTEM);
    AddConstant('MEMCTX_UNKNOWN',MEMCTX_UNKNOWN);
    AddConstant('MEMCTX_SAME',MEMCTX_SAME);
    AddConstant('ROTFLAGS_REGISTRATIONKEEPSALIVE',ROTFLAGS_REGISTRATIONKEEPSALIVE);
    AddConstant('ROTFLAGS_ALLOWANYCLIENT',ROTFLAGS_ALLOWANYCLIENT);
    AddConstant('CLSCTX_INPROC_SERVER',CLSCTX_INPROC_SERVER);
    AddConstant('CLSCTX_INPROC_HANDLER',CLSCTX_INPROC_HANDLER);
    AddConstant('CLSCTX_LOCAL_SERVER',CLSCTX_LOCAL_SERVER);
    AddConstant('CLSCTX_INPROC_SERVER16',CLSCTX_INPROC_SERVER16);
    AddConstant('CLSCTX_REMOTE_SERVER',CLSCTX_REMOTE_SERVER);
    AddConstant('CLSCTX_INPROC_HANDLER16',CLSCTX_INPROC_HANDLER16);
    AddConstant('CLSCTX_INPROC_SERVERX86',CLSCTX_INPROC_SERVERX86);
    AddConstant('CLSCTX_INPROC_HANDLERX86',CLSCTX_INPROC_HANDLERX86);
    AddConstant('CLSCTX_ALL',CLSCTX_ALL);
    AddConstant('CLSCTX_INPROC',CLSCTX_INPROC);
    AddConstant('CLSCTX_SERVER',CLSCTX_SERVER);
    AddConstant('COM_RIGHTS_EXECUTE',COM_RIGHTS_EXECUTE);
    AddConstant('MSHLFLAGS_NORMAL',MSHLFLAGS_NORMAL);
    AddConstant('MSHLFLAGS_TABLESTRONG',MSHLFLAGS_TABLESTRONG);
    AddConstant('MSHLFLAGS_TABLEWEAK',MSHLFLAGS_TABLEWEAK);
    AddConstant('MSHLFLAGS_NOPING',MSHLFLAGS_NOPING);
    AddConstant('MSHCTX_LOCAL',MSHCTX_LOCAL);
    AddConstant('MSHCTX_NOSHAREDMEM',MSHCTX_NOSHAREDMEM);
    AddConstant('MSHCTX_DIFFERENTMACHINE',MSHCTX_DIFFERENTMACHINE);
    AddConstant('MSHCTX_INPROC',MSHCTX_INPROC);
    AddConstant('DVASPECT_CONTENT',DVASPECT_CONTENT);
    AddConstant('DVASPECT_THUMBNAIL',DVASPECT_THUMBNAIL);
    AddConstant('DVASPECT_ICON',DVASPECT_ICON);
    AddConstant('DVASPECT_DOCPRINT',DVASPECT_DOCPRINT);
    AddConstant('STGC_DEFAULT',STGC_DEFAULT);
    AddConstant('STGC_OVERWRITE',STGC_OVERWRITE);
    AddConstant('STGC_ONLYIFCURRENT',STGC_ONLYIFCURRENT);
    AddConstant('STGC_DANGEROUSLYCOMMITMERELYTODISKCACHE',STGC_DANGEROUSLYCOMMITMERELYTODISKCACHE);
    AddConstant('STGMOVE_MOVE',STGMOVE_MOVE);
    AddConstant('STGMOVE_COPY',STGMOVE_COPY);
    AddConstant('STGMOVE_SHALLOWCOPY',STGMOVE_SHALLOWCOPY);
    AddConstant('STATFLAG_DEFAULT',STATFLAG_DEFAULT);
    AddConstant('STATFLAG_NONAME',STATFLAG_NONAME);
    AddConstant('BIND_MAYBOTHERUSER',BIND_MAYBOTHERUSER);
    AddConstant('BIND_JUSTTESTEXISTENCE',BIND_JUSTTESTEXISTENCE);
    AddConstant('MKSYS_NONE',MKSYS_NONE);
    AddConstant('MKSYS_GENERICCOMPOSITE',MKSYS_GENERICCOMPOSITE);
    AddConstant('MKSYS_FILEMONIKER',MKSYS_FILEMONIKER);
    AddConstant('MKSYS_ANTIMONIKER',MKSYS_ANTIMONIKER);
    AddConstant('MKSYS_ITEMMONIKER',MKSYS_ITEMMONIKER);
    AddConstant('MKSYS_POINTERMONIKER',MKSYS_POINTERMONIKER);
    AddConstant('MKRREDUCE_ONE',MKRREDUCE_ONE);
    AddConstant('MKRREDUCE_TOUSER',MKRREDUCE_TOUSER);
    AddConstant('MKRREDUCE_THROUGHUSER',MKRREDUCE_THROUGHUSER);
    AddConstant('MKRREDUCE_ALL',MKRREDUCE_ALL);
    AddConstant('STGTY_STORAGE',STGTY_STORAGE);
    AddConstant('STGTY_STREAM',STGTY_STREAM);
    AddConstant('STGTY_LOCKBYTES',STGTY_LOCKBYTES);
    AddConstant('STGTY_PROPERTY',STGTY_PROPERTY);
    AddConstant('STREAM_SEEK_SET',STREAM_SEEK_SET);
    AddConstant('STREAM_SEEK_CUR',STREAM_SEEK_CUR);
    AddConstant('STREAM_SEEK_END',STREAM_SEEK_END);
    AddConstant('LOCK_WRITE',LOCK_WRITE);
    AddConstant('LOCK_EXCLUSIVE',LOCK_EXCLUSIVE);
    AddConstant('LOCK_ONLYONCE',LOCK_ONLYONCE);
    AddConstant('ADVF_NODATA',ADVF_NODATA);
    AddConstant('ADVF_PRIMEFIRST',ADVF_PRIMEFIRST);
    AddConstant('ADVF_ONLYONCE',ADVF_ONLYONCE);
    AddConstant('ADVF_DATAONSTOP',ADVF_DATAONSTOP);
    AddConstant('ADVFCACHE_NOHANDLER',ADVFCACHE_NOHANDLER);
    AddConstant('ADVFCACHE_FORCEBUILTIN',ADVFCACHE_FORCEBUILTIN);
    AddConstant('ADVFCACHE_ONSAVE',ADVFCACHE_ONSAVE);
    AddConstant('TYMED_HGLOBAL',TYMED_HGLOBAL);
    AddConstant('TYMED_FILE',TYMED_FILE);
    AddConstant('TYMED_ISTREAM',TYMED_ISTREAM);
    AddConstant('TYMED_ISTORAGE',TYMED_ISTORAGE);
    AddConstant('TYMED_GDI',TYMED_GDI);
    AddConstant('TYMED_MFPICT',TYMED_MFPICT);
    AddConstant('TYMED_ENHMF',TYMED_ENHMF);
    AddConstant('TYMED_NULL',TYMED_NULL);
    AddConstant('DATADIR_GET',DATADIR_GET);
    AddConstant('DATADIR_SET',DATADIR_SET);
    AddConstant('CALLTYPE_TOPLEVEL',CALLTYPE_TOPLEVEL);
    AddConstant('CALLTYPE_NESTED',CALLTYPE_NESTED);
    AddConstant('CALLTYPE_ASYNC',CALLTYPE_ASYNC);
    AddConstant('CALLTYPE_TOPLEVEL_CALLPENDING',CALLTYPE_TOPLEVEL_CALLPENDING);
    AddConstant('CALLTYPE_ASYNC_CALLPENDING',CALLTYPE_ASYNC_CALLPENDING);
    AddConstant('SERVERCALL_ISHANDLED',SERVERCALL_ISHANDLED);
    AddConstant('SERVERCALL_REJECTED',SERVERCALL_REJECTED);
    AddConstant('SERVERCALL_RETRYLATER',SERVERCALL_RETRYLATER);
    AddConstant('PENDINGTYPE_TOPLEVEL',PENDINGTYPE_TOPLEVEL);
    AddConstant('PENDINGTYPE_NESTED',PENDINGTYPE_NESTED);
    AddConstant('PENDINGMSG_CANCELCALL',PENDINGMSG_CANCELCALL);
    AddConstant('PENDINGMSG_WAITNOPROCESS',PENDINGMSG_WAITNOPROCESS);
    AddConstant('PENDINGMSG_WAITDEFPROCESS',PENDINGMSG_WAITDEFPROCESS);
    AddConstant('PROPSETFLAG_DEFAULT',PROPSETFLAG_DEFAULT);
    AddConstant('PROPSETFLAG_NONSIMPLE',PROPSETFLAG_NONSIMPLE);
    AddConstant('PROPSETFLAG_ANSI',PROPSETFLAG_ANSI);
    AddConstant('REGCLS_SINGLEUSE',REGCLS_SINGLEUSE);
    AddConstant('REGCLS_MULTIPLEUSE',REGCLS_MULTIPLEUSE);
    AddConstant('REGCLS_MULTI_SEPARATE',REGCLS_MULTI_SEPARATE);
    AddConstant('REGCLS_SUSPENDED',REGCLS_SUSPENDED);
    AddConstant('MARSHALINTERFACE_MIN',MARSHALINTERFACE_MIN);
    AddConstant('CWCSTORAGENAME',CWCSTORAGENAME);
    AddConstant('STGM_DIRECT',STGM_DIRECT);
    AddConstant('STGM_TRANSACTED',STGM_TRANSACTED);
    AddConstant('STGM_SIMPLE',STGM_SIMPLE);
    AddConstant('STGM_READ',STGM_READ);
    AddConstant('STGM_WRITE',STGM_WRITE);
    AddConstant('STGM_READWRITE',STGM_READWRITE);
    AddConstant('STGM_SHARE_DENY_NONE',STGM_SHARE_DENY_NONE);
    AddConstant('STGM_SHARE_DENY_READ',STGM_SHARE_DENY_READ);
    AddConstant('STGM_SHARE_DENY_WRITE',STGM_SHARE_DENY_WRITE);
    AddConstant('STGM_SHARE_EXCLUSIVE',STGM_SHARE_EXCLUSIVE);
    AddConstant('STGM_PRIORITY',STGM_PRIORITY);
    AddConstant('STGM_DELETEONRELEASE',STGM_DELETEONRELEASE);
    AddConstant('STGM_NOSCRATCH',STGM_NOSCRATCH);
    AddConstant('STGM_CREATE',STGM_CREATE);
    AddConstant('STGM_CONVERT',STGM_CONVERT);
    AddConstant('STGM_FAILIFTHERE',STGM_FAILIFTHERE);
    AddConstant('FADF_AUTO',FADF_AUTO);
    AddConstant('FADF_STATIC',FADF_STATIC);
    AddConstant('FADF_EMBEDDED',FADF_EMBEDDED);
    AddConstant('FADF_FIXEDSIZE',FADF_FIXEDSIZE);
    AddConstant('FADF_BSTR',FADF_BSTR);
    AddConstant('FADF_UNKNOWN',FADF_UNKNOWN);
    AddConstant('FADF_DISPATCH',FADF_DISPATCH);
    AddConstant('FADF_VARIANT',FADF_VARIANT);
    AddConstant('FADF_RESERVED',FADF_RESERVED);
    AddConstant('VT_EMPTY',VT_EMPTY);
    AddConstant('VT_NULL',VT_NULL);
    AddConstant('VT_I2',VT_I2);
    AddConstant('VT_I4',VT_I4);
    AddConstant('VT_R4',VT_R4);
    AddConstant('VT_R8',VT_R8);
    AddConstant('VT_CY',VT_CY);
    AddConstant('VT_DATE',VT_DATE);
    AddConstant('VT_BSTR',VT_BSTR);
    AddConstant('VT_DISPATCH',VT_DISPATCH);
    AddConstant('VT_ERROR',VT_ERROR);
    AddConstant('VT_BOOL',VT_BOOL);
    AddConstant('VT_VARIANT',VT_VARIANT);
    AddConstant('VT_UNKNOWN',VT_UNKNOWN);
    AddConstant('VT_DECIMAL',VT_DECIMAL);
    AddConstant('VT_I1',VT_I1);
    AddConstant('VT_UI1',VT_UI1);
    AddConstant('VT_UI2',VT_UI2);
    AddConstant('VT_UI4',VT_UI4);
    AddConstant('VT_I8',VT_I8);
    AddConstant('VT_UI8',VT_UI8);
    AddConstant('VT_INT',VT_INT);
    AddConstant('VT_UINT',VT_UINT);
    AddConstant('VT_VOID',VT_VOID);
    AddConstant('VT_HRESULT',VT_HRESULT);
    AddConstant('VT_PTR',VT_PTR);
    AddConstant('VT_SAFEARRAY',VT_SAFEARRAY);
    AddConstant('VT_CARRAY',VT_CARRAY);
    AddConstant('VT_USERDEFINED',VT_USERDEFINED);
    AddConstant('VT_LPSTR',VT_LPSTR);
    AddConstant('VT_LPWSTR',VT_LPWSTR);
    AddConstant('VT_FILETIME',VT_FILETIME);
    AddConstant('VT_BLOB',VT_BLOB);
    AddConstant('VT_STREAM',VT_STREAM);
    AddConstant('VT_STORAGE',VT_STORAGE);
    AddConstant('VT_STREAMED_OBJECT',VT_STREAMED_OBJECT);
    AddConstant('VT_STORED_OBJECT',VT_STORED_OBJECT);
    AddConstant('VT_BLOB_OBJECT',VT_BLOB_OBJECT);
    AddConstant('VT_CF',VT_CF);
    AddConstant('VT_CLSID',VT_CLSID);
    AddConstant('VT_VECTOR',VT_VECTOR);
    AddConstant('VT_ARRAY',VT_ARRAY);
    AddConstant('VT_BYREF',VT_BYREF);
    AddConstant('VT_RESERVED',VT_RESERVED);
    AddConstant('VT_ILLEGAL',VT_ILLEGAL);
    AddConstant('VT_ILLEGALMASKED',VT_ILLEGALMASKED);
    AddConstant('VT_TYPEMASK',VT_TYPEMASK);
    AddConstant('TKIND_ENUM',TKIND_ENUM);
    AddConstant('TKIND_RECORD',TKIND_RECORD);
    AddConstant('TKIND_MODULE',TKIND_MODULE);
    AddConstant('TKIND_INTERFACE',TKIND_INTERFACE);
    AddConstant('TKIND_DISPATCH',TKIND_DISPATCH);
    AddConstant('TKIND_COCLASS',TKIND_COCLASS);
    AddConstant('TKIND_ALIAS',TKIND_ALIAS);
    AddConstant('TKIND_UNION',TKIND_UNION);
    AddConstant('TKIND_MAX',TKIND_MAX);
    AddConstant('TKIND_TYPELIB',TKIND_TYPELIB);
    AddConstant('TKIND_FUNC',TKIND_FUNC);
    AddConstant('TKIND_VAR',TKIND_VAR);
    AddConstant('CC_SAFECALL',CC_SAFECALL);
    AddConstant('CC_CDECL',CC_CDECL);
    AddConstant('CC_PASCAL',CC_PASCAL);
    AddConstant('CC_MACPASCAL',CC_MACPASCAL);
    AddConstant('CC_STDCALL',CC_STDCALL);
    AddConstant('CC_FPFASTCALL',CC_FPFASTCALL);
    AddConstant('CC_SYSCALL',CC_SYSCALL);
    AddConstant('CC_MPWCDECL',CC_MPWCDECL);
    AddConstant('CC_MPWPASCAL',CC_MPWPASCAL);
    AddConstant('CC_MAX',CC_MAX);
    AddConstant('FUNC_VIRTUAL',FUNC_VIRTUAL);
    AddConstant('FUNC_PUREVIRTUAL',FUNC_PUREVIRTUAL);
    AddConstant('FUNC_NONVIRTUAL',FUNC_NONVIRTUAL);
    AddConstant('FUNC_STATIC',FUNC_STATIC);
    AddConstant('FUNC_DISPATCH',FUNC_DISPATCH);
    AddConstant('INVOKE_FUNC',INVOKE_FUNC);
    AddConstant('INVOKE_PROPERTYGET',INVOKE_PROPERTYGET);
    AddConstant('INVOKE_PROPERTYPUT',INVOKE_PROPERTYPUT);
    AddConstant('INVOKE_PROPERTYPUTREF',INVOKE_PROPERTYPUTREF);
    AddConstant('VAR_PERINSTANCE',VAR_PERINSTANCE);
    AddConstant('VAR_STATIC',VAR_STATIC);
    AddConstant('VAR_CONST',VAR_CONST);
    AddConstant('VAR_DISPATCH',VAR_DISPATCH);
    AddConstant('IMPLTYPEFLAG_FDEFAULT',IMPLTYPEFLAG_FDEFAULT);
    AddConstant('IMPLTYPEFLAG_FSOURCE',IMPLTYPEFLAG_FSOURCE);
    AddConstant('IMPLTYPEFLAG_FRESTRICTED',IMPLTYPEFLAG_FRESTRICTED);
    AddConstant('IMPLTYPEFLAG_FDEFAULTVTABLE',IMPLTYPEFLAG_FDEFAULTVTABLE);
    AddConstant('TYPEFLAG_FAPPOBJECT',TYPEFLAG_FAPPOBJECT);
    AddConstant('TYPEFLAG_FCANCREATE',TYPEFLAG_FCANCREATE);
    AddConstant('TYPEFLAG_FLICENSED',TYPEFLAG_FLICENSED);
    AddConstant('TYPEFLAG_FPREDECLID',TYPEFLAG_FPREDECLID);
    AddConstant('TYPEFLAG_FHIDDEN',TYPEFLAG_FHIDDEN);
    AddConstant('TYPEFLAG_FCONTROL',TYPEFLAG_FCONTROL);
    AddConstant('TYPEFLAG_FDUAL',TYPEFLAG_FDUAL);
    AddConstant('TYPEFLAG_FNONEXTENSIBLE',TYPEFLAG_FNONEXTENSIBLE);
    AddConstant('TYPEFLAG_FOLEAUTOMATION',TYPEFLAG_FOLEAUTOMATION);
    AddConstant('TYPEFLAG_FRESTRICTED',TYPEFLAG_FRESTRICTED);
    AddConstant('TYPEFLAG_FAGGREGATABLE',TYPEFLAG_FAGGREGATABLE);
    AddConstant('TYPEFLAG_FREPLACEABLE',TYPEFLAG_FREPLACEABLE);
    AddConstant('TYPEFLAG_FDISPATCHABLE',TYPEFLAG_FDISPATCHABLE);
    AddConstant('TYPEFLAG_FREVERSEBIND',TYPEFLAG_FREVERSEBIND);
    AddConstant('FUNCFLAG_FRESTRICTED',FUNCFLAG_FRESTRICTED);
    AddConstant('FUNCFLAG_FSOURCE',FUNCFLAG_FSOURCE);
    AddConstant('FUNCFLAG_FBINDABLE',FUNCFLAG_FBINDABLE);
    AddConstant('FUNCFLAG_FREQUESTEDIT',FUNCFLAG_FREQUESTEDIT);
    AddConstant('FUNCFLAG_FDISPLAYBIND',FUNCFLAG_FDISPLAYBIND);
    AddConstant('FUNCFLAG_FDEFAULTBIND',FUNCFLAG_FDEFAULTBIND);
    AddConstant('FUNCFLAG_FHIDDEN',FUNCFLAG_FHIDDEN);
    AddConstant('FUNCFLAG_FUSESGETLASTERROR',FUNCFLAG_FUSESGETLASTERROR);
    AddConstant('FUNCFLAG_FDEFAULTCOLLELEM',FUNCFLAG_FDEFAULTCOLLELEM);
    AddConstant('FUNCFLAG_FUIDEFAULT',FUNCFLAG_FUIDEFAULT);
    AddConstant('FUNCFLAG_FNONBROWSABLE',FUNCFLAG_FNONBROWSABLE);
    AddConstant('FUNCFLAG_FREPLACEABLE',FUNCFLAG_FREPLACEABLE);
    AddConstant('FUNCFLAG_FIMMEDIATEBIND',FUNCFLAG_FIMMEDIATEBIND);
    AddConstant('VARFLAG_FREADONLY',VARFLAG_FREADONLY);
    AddConstant('VARFLAG_FSOURCE',VARFLAG_FSOURCE);
    AddConstant('VARFLAG_FBINDABLE',VARFLAG_FBINDABLE);
    AddConstant('VARFLAG_FREQUESTEDIT',VARFLAG_FREQUESTEDIT);
    AddConstant('VARFLAG_FDISPLAYBIND',VARFLAG_FDISPLAYBIND);
    AddConstant('VARFLAG_FDEFAULTBIND',VARFLAG_FDEFAULTBIND);
    AddConstant('VARFLAG_FHIDDEN',VARFLAG_FHIDDEN);
    AddConstant('VARFLAG_FRESTRICTED',VARFLAG_FRESTRICTED);
    AddConstant('VARFLAG_FDEFAULTCOLLELEM',VARFLAG_FDEFAULTCOLLELEM);
    AddConstant('VARFLAG_FUIDEFAULT',VARFLAG_FUIDEFAULT);
    AddConstant('VARFLAG_FNONBROWSABLE',VARFLAG_FNONBROWSABLE);
    AddConstant('VARFLAG_FREPLACEABLE',VARFLAG_FREPLACEABLE);
    AddConstant('VARFLAG_FIMMEDIATEBIND',VARFLAG_FIMMEDIATEBIND);
    AddConstant('DISPID_VALUE',DISPID_VALUE);
    AddConstant('DISPID_UNKNOWN',DISPID_UNKNOWN);
    AddConstant('DISPID_STARTENUM',DISPID_STARTENUM);
    AddConstant('DISPID_PROPERTYPUT',DISPID_PROPERTYPUT);
    AddConstant('DISPID_NEWENUM',DISPID_NEWENUM);
    AddConstant('DISPID_EVALUATE',DISPID_EVALUATE);
    AddConstant('DISPID_CONSTRUCTOR',DISPID_CONSTRUCTOR);
    AddConstant('DISPID_DESTRUCTOR',DISPID_DESTRUCTOR);
    AddConstant('DISPID_COLLECT',DISPID_COLLECT);
    AddConstant('DESCKIND_NONE',DESCKIND_NONE);
    AddConstant('DESCKIND_FUNCDESC',DESCKIND_FUNCDESC);
    AddConstant('DESCKIND_VARDESC',DESCKIND_VARDESC);
    AddConstant('DESCKIND_TYPECOMP',DESCKIND_TYPECOMP);
    AddConstant('DESCKIND_IMPLICITAPPOBJ',DESCKIND_IMPLICITAPPOBJ);
    AddConstant('DESCKIND_MAX',DESCKIND_MAX);
    AddConstant('SYS_WIN16',SYS_WIN16);
    AddConstant('SYS_WIN32',SYS_WIN32);
    AddConstant('SYS_MAC',SYS_MAC);
    AddConstant('LIBFLAG_FRESTRICTED',LIBFLAG_FRESTRICTED);
    AddConstant('LIBFLAG_FCONTROL',LIBFLAG_FCONTROL);
    AddConstant('LIBFLAG_FHIDDEN',LIBFLAG_FHIDDEN);
    AddConstant('LIBFLAG_FHASDISKIMAGE',LIBFLAG_FHASDISKIMAGE);
    AddConstant('STDOLE_MAJORVERNUM',STDOLE_MAJORVERNUM);
    AddConstant('STDOLE_MINORVERNUM',STDOLE_MINORVERNUM);
    AddConstant('STDOLE_LCID',STDOLE_LCID);
    AddConstant('VARIANT_NOVALUEPROP',VARIANT_NOVALUEPROP);
    AddConstant('VAR_TIMEVALUEONLY',VAR_TIMEVALUEONLY);
    AddConstant('VAR_DATEVALUEONLY',VAR_DATEVALUEONLY);
    AddConstant('MEMBERID_NIL',MEMBERID_NIL);
    AddConstant('ID_DEFAULTINST',ID_DEFAULTINST);
    AddConstant('DISPATCH_METHOD',DISPATCH_METHOD);
    AddConstant('DISPATCH_PROPERTYGET',DISPATCH_PROPERTYGET);
    AddConstant('DISPATCH_PROPERTYPUT',DISPATCH_PROPERTYPUT);
    AddConstant('DISPATCH_PROPERTYPUTREF',DISPATCH_PROPERTYPUTREF);
    AddConstant('DISPATCH_CONSTRUCT',DISPATCH_CONSTRUCT);
    AddConstant('IDLFLAG_NONE',IDLFLAG_NONE);
    AddConstant('IDLFLAG_FIN',IDLFLAG_FIN);
    AddConstant('IDLFLAG_FOUT',IDLFLAG_FOUT);
    AddConstant('IDLFLAG_FLCID',IDLFLAG_FLCID);
    AddConstant('IDLFLAG_FRETVAL',IDLFLAG_FRETVAL);
    AddConstant('PARAMFLAG_NONE',PARAMFLAG_NONE);
    AddConstant('PARAMFLAG_FIN',PARAMFLAG_FIN);
    AddConstant('PARAMFLAG_FOUT',PARAMFLAG_FOUT);
    AddConstant('PARAMFLAG_FLCID',PARAMFLAG_FLCID);
    AddConstant('PARAMFLAG_FRETVAL',PARAMFLAG_FRETVAL);
    AddConstant('PARAMFLAG_FOPT',PARAMFLAG_FOPT);
    AddConstant('PARAMFLAG_FHASDEFAULT',PARAMFLAG_FHASDEFAULT);
    AddConstant('OLEIVERB_PRIMARY',OLEIVERB_PRIMARY);
    AddConstant('OLEIVERB_SHOW',OLEIVERB_SHOW);
    AddConstant('OLEIVERB_OPEN',OLEIVERB_OPEN);
    AddConstant('OLEIVERB_HIDE',OLEIVERB_HIDE);
    AddConstant('OLEIVERB_UIACTIVATE',OLEIVERB_UIACTIVATE);
    AddConstant('OLEIVERB_INPLACEACTIVATE',OLEIVERB_INPLACEACTIVATE);
    AddConstant('OLEIVERB_DISCARDUNDOSTATE',OLEIVERB_DISCARDUNDOSTATE);
    AddConstant('EMBDHLP_INPROC_HANDLER',EMBDHLP_INPROC_HANDLER);
    AddConstant('EMBDHLP_INPROC_SERVER',EMBDHLP_INPROC_SERVER);
    AddConstant('EMBDHLP_CREATENOW',EMBDHLP_CREATENOW);
    AddConstant('EMBDHLP_DELAYCREATE',EMBDHLP_DELAYCREATE);
    AddConstant('OLECREATE_LEAVERUNNING',OLECREATE_LEAVERUNNING);
    AddConstant('UPDFCACHE_NODATACACHE',UPDFCACHE_NODATACACHE);
    AddConstant('UPDFCACHE_ONSAVECACHE',UPDFCACHE_ONSAVECACHE);
    AddConstant('UPDFCACHE_ONSTOPCACHE',UPDFCACHE_ONSTOPCACHE);
    AddConstant('UPDFCACHE_NORMALCACHE',UPDFCACHE_NORMALCACHE);
    AddConstant('UPDFCACHE_IFBLANK',UPDFCACHE_IFBLANK);
    AddConstant('UPDFCACHE_ONLYIFBLANK',UPDFCACHE_ONLYIFBLANK);
    AddConstant('UPDFCACHE_IFBLANKORONSAVECACHE',UPDFCACHE_IFBLANKORONSAVECACHE);
    AddConstant('UPDFCACHE_ALL',UPDFCACHE_ALL);
    AddConstant('UPDFCACHE_ALLBUTNODATACACHE',UPDFCACHE_ALLBUTNODATACACHE);
    AddConstant('DISCARDCACHE_SAVEIFDIRTY',DISCARDCACHE_SAVEIFDIRTY);
    AddConstant('DISCARDCACHE_NOSAVE',DISCARDCACHE_NOSAVE);
    AddConstant('OLEGETMONIKER_ONLYIFTHERE',OLEGETMONIKER_ONLYIFTHERE);
    AddConstant('OLEGETMONIKER_FORCEASSIGN',OLEGETMONIKER_FORCEASSIGN);
    AddConstant('OLEGETMONIKER_UNASSIGN',OLEGETMONIKER_UNASSIGN);
    AddConstant('OLEGETMONIKER_TEMPFORUSER',OLEGETMONIKER_TEMPFORUSER);
    AddConstant('OLEWHICHMK_CONTAINER',OLEWHICHMK_CONTAINER);
    AddConstant('OLEWHICHMK_OBJREL',OLEWHICHMK_OBJREL);
    AddConstant('OLEWHICHMK_OBJFULL',OLEWHICHMK_OBJFULL);
    AddConstant('USERCLASSTYPE_FULL',USERCLASSTYPE_FULL);
    AddConstant('USERCLASSTYPE_SHORT',USERCLASSTYPE_SHORT);
    AddConstant('USERCLASSTYPE_APPNAME',USERCLASSTYPE_APPNAME);
    AddConstant('OLEMISC_RECOMPOSEONRESIZE',OLEMISC_RECOMPOSEONRESIZE);
    AddConstant('OLEMISC_ONLYICONIC',OLEMISC_ONLYICONIC);
    AddConstant('OLEMISC_INSERTNOTREPLACE',OLEMISC_INSERTNOTREPLACE);
    AddConstant('OLEMISC_STATIC',OLEMISC_STATIC);
    AddConstant('OLEMISC_CANTLINKINSIDE',OLEMISC_CANTLINKINSIDE);
    AddConstant('OLEMISC_CANLINKBYOLE1',OLEMISC_CANLINKBYOLE1);
    AddConstant('OLEMISC_ISLINKOBJECT',OLEMISC_ISLINKOBJECT);
    AddConstant('OLEMISC_INSIDEOUT',OLEMISC_INSIDEOUT);
    AddConstant('OLEMISC_ACTIVATEWHENVISIBLE',OLEMISC_ACTIVATEWHENVISIBLE);
    AddConstant('OLEMISC_RENDERINGISDEVICEINDEPENDENT',OLEMISC_RENDERINGISDEVICEINDEPENDENT);
    AddConstant('OLEMISC_INVISIBLEATRUNTIME',OLEMISC_INVISIBLEATRUNTIME);
    AddConstant('OLEMISC_ALWAYSRUN',OLEMISC_ALWAYSRUN);
    AddConstant('OLEMISC_ACTSLIKEBUTTON',OLEMISC_ACTSLIKEBUTTON);
    AddConstant('OLEMISC_ACTSLIKELABEL',OLEMISC_ACTSLIKELABEL);
    AddConstant('OLEMISC_NOUIACTIVATE',OLEMISC_NOUIACTIVATE);
    AddConstant('OLEMISC_ALIGNABLE',OLEMISC_ALIGNABLE);
    AddConstant('OLEMISC_SIMPLEFRAME',OLEMISC_SIMPLEFRAME);
    AddConstant('OLEMISC_SETCLIENTSITEFIRST',OLEMISC_SETCLIENTSITEFIRST);
    AddConstant('OLEMISC_IMEMODE',OLEMISC_IMEMODE);
    AddConstant('OLEMISC_IGNOREACTIVATEWHENVISIBLE',OLEMISC_IGNOREACTIVATEWHENVISIBLE);
    AddConstant('OLEMISC_WANTSTOMENUMERGE',OLEMISC_WANTSTOMENUMERGE);
    AddConstant('OLEMISC_SUPPORTSMULTILEVELUNDO',OLEMISC_SUPPORTSMULTILEVELUNDO);
    AddConstant('OLECLOSE_SAVEIFDIRTY',OLECLOSE_SAVEIFDIRTY);
    AddConstant('OLECLOSE_NOSAVE',OLECLOSE_NOSAVE);
    AddConstant('OLECLOSE_PROMPTSAVE',OLECLOSE_PROMPTSAVE);
    AddConstant('OLERENDER_NONE',OLERENDER_NONE);
    AddConstant('OLERENDER_DRAW',OLERENDER_DRAW);
    AddConstant('OLERENDER_FORMAT',OLERENDER_FORMAT);
    AddConstant('OLERENDER_ASIS',OLERENDER_ASIS);
    AddConstant('OLEUPDATE_ALWAYS',OLEUPDATE_ALWAYS);
    AddConstant('OLEUPDATE_ONCALL',OLEUPDATE_ONCALL);
    AddConstant('OLELINKBIND_EVENIFCLASSDIFF',OLELINKBIND_EVENIFCLASSDIFF);
    AddConstant('BINDSPEED_INDEFINITE',BINDSPEED_INDEFINITE);
    AddConstant('BINDSPEED_MODERATE',BINDSPEED_MODERATE);
    AddConstant('BINDSPEED_IMMEDIATE',BINDSPEED_IMMEDIATE);
    AddConstant('OLECONTF_EMBEDDINGS',OLECONTF_EMBEDDINGS);
    AddConstant('OLECONTF_LINKS',OLECONTF_LINKS);
    AddConstant('OLECONTF_OTHERS',OLECONTF_OTHERS);
    AddConstant('OLECONTF_ONLYUSER',OLECONTF_ONLYUSER);
    AddConstant('OLECONTF_ONLYIFRUNNING',OLECONTF_ONLYIFRUNNING);
    AddConstant('DROPEFFECT_NONE',DROPEFFECT_NONE);
    AddConstant('DROPEFFECT_COPY',DROPEFFECT_COPY);
    AddConstant('DROPEFFECT_MOVE',DROPEFFECT_MOVE);
    AddConstant('DROPEFFECT_LINK',DROPEFFECT_LINK);
    AddConstant('DROPEFFECT_SCROLL',DROPEFFECT_SCROLL);
    AddConstant('MK_ALT',MK_ALT);
    AddConstant('DD_DEFSCROLLINSET',DD_DEFSCROLLINSET);
    AddConstant('DD_DEFSCROLLDELAY',DD_DEFSCROLLDELAY);
    AddConstant('DD_DEFSCROLLINTERVAL',DD_DEFSCROLLINTERVAL);
    AddConstant('DD_DEFDRAGDELAY',DD_DEFDRAGDELAY);
    AddConstant('DD_DEFDRAGMINDIST',DD_DEFDRAGMINDIST);
    AddConstant('OLEVERBATTRIB_NEVERDIRTIES',OLEVERBATTRIB_NEVERDIRTIES);
    AddConstant('OLEVERBATTRIB_ONCONTAINERMENU',OLEVERBATTRIB_ONCONTAINERMENU);
    AddConstant('CTL_E_ILLEGALFUNCTIONCALL',CTL_E_ILLEGALFUNCTIONCALL);
    AddConstant('CTL_E_OVERFLOW',CTL_E_OVERFLOW);
    AddConstant('CTL_E_OUTOFMEMORY',CTL_E_OUTOFMEMORY);
    AddConstant('CTL_E_DIVISIONBYZERO',CTL_E_DIVISIONBYZERO);
    AddConstant('CTL_E_OUTOFSTRINGSPACE',CTL_E_OUTOFSTRINGSPACE);
    AddConstant('CTL_E_OUTOFSTACKSPACE',CTL_E_OUTOFSTACKSPACE);
    AddConstant('CTL_E_BADFILENAMEORNUMBER',CTL_E_BADFILENAMEORNUMBER);
    AddConstant('CTL_E_FILENOTFOUND',CTL_E_FILENOTFOUND);
    AddConstant('CTL_E_BADFILEMODE',CTL_E_BADFILEMODE);
    AddConstant('CTL_E_FILEALREADYOPEN',CTL_E_FILEALREADYOPEN);
    AddConstant('CTL_E_DEVICEIOERROR',CTL_E_DEVICEIOERROR);
    AddConstant('CTL_E_FILEALREADYEXISTS',CTL_E_FILEALREADYEXISTS);
    AddConstant('CTL_E_BADRECORDLENGTH',CTL_E_BADRECORDLENGTH);
    AddConstant('CTL_E_DISKFULL',CTL_E_DISKFULL);
    AddConstant('CTL_E_BADRECORDNUMBER',CTL_E_BADRECORDNUMBER);
    AddConstant('CTL_E_BADFILENAME',CTL_E_BADFILENAME);
    AddConstant('CTL_E_TOOMANYFILES',CTL_E_TOOMANYFILES);
    AddConstant('CTL_E_DEVICEUNAVAILABLE',CTL_E_DEVICEUNAVAILABLE);
    AddConstant('CTL_E_PERMISSIONDENIED',CTL_E_PERMISSIONDENIED);
    AddConstant('CTL_E_DISKNOTREADY',CTL_E_DISKNOTREADY);
    AddConstant('CTL_E_PATHFILEACCESSERROR',CTL_E_PATHFILEACCESSERROR);
    AddConstant('CTL_E_PATHNOTFOUND',CTL_E_PATHNOTFOUND);
    AddConstant('CTL_E_INVALIDPATTERNSTRING',CTL_E_INVALIDPATTERNSTRING);
    AddConstant('CTL_E_INVALIDUSEOFNULL',CTL_E_INVALIDUSEOFNULL);
    AddConstant('CTL_E_INVALIDFILEFORMAT',CTL_E_INVALIDFILEFORMAT);
    AddConstant('CTL_E_INVALIDPROPERTYVALUE',CTL_E_INVALIDPROPERTYVALUE);
    AddConstant('CTL_E_INVALIDPROPERTYARRAYINDEX',CTL_E_INVALIDPROPERTYARRAYINDEX);
    AddConstant('CTL_E_SETNOTSUPPORTEDATRUNTIME',CTL_E_SETNOTSUPPORTEDATRUNTIME);
    AddConstant('CTL_E_SETNOTSUPPORTED',CTL_E_SETNOTSUPPORTED);
    AddConstant('CTL_E_NEEDPROPERTYARRAYINDEX',CTL_E_NEEDPROPERTYARRAYINDEX);
    AddConstant('CTL_E_SETNOTPERMITTED',CTL_E_SETNOTPERMITTED);
    AddConstant('CTL_E_GETNOTSUPPORTEDATRUNTIME',CTL_E_GETNOTSUPPORTEDATRUNTIME);
    AddConstant('CTL_E_GETNOTSUPPORTED',CTL_E_GETNOTSUPPORTED);
    AddConstant('CTL_E_PROPERTYNOTFOUND',CTL_E_PROPERTYNOTFOUND);
    AddConstant('CTL_E_INVALIDCLIPBOARDFORMAT',CTL_E_INVALIDCLIPBOARDFORMAT);
    AddConstant('CTL_E_INVALIDPICTURE',CTL_E_INVALIDPICTURE);
    AddConstant('CTL_E_PRINTERERROR',CTL_E_PRINTERERROR);
    AddConstant('CTL_E_CANTSAVEFILETOTEMP',CTL_E_CANTSAVEFILETOTEMP);
    AddConstant('CTL_E_SEARCHTEXTNOTFOUND',CTL_E_SEARCHTEXTNOTFOUND);
    AddConstant('CTL_E_REPLACEMENTSTOOLONG',CTL_E_REPLACEMENTSTOOLONG);
    AddConstant('CTL_E_CUSTOM_FIRST',CTL_E_CUSTOM_FIRST);
    AddConstant('CLASS_E_NOTLICENSED',CLASS_E_NOTLICENSED);
    AddConstant('CONNECT_E_FIRST',CONNECT_E_FIRST);
    AddConstant('CONNECT_E_LAST',CONNECT_E_LAST);
    AddConstant('CONNECT_S_FIRST',CONNECT_S_FIRST);
    AddConstant('CONNECT_S_LAST',CONNECT_S_LAST);
    AddConstant('CONNECT_E_NOCONNECTION',CONNECT_E_NOCONNECTION);
    AddConstant('CONNECT_E_ADVISELIMIT',CONNECT_E_ADVISELIMIT);
    AddConstant('CONNECT_E_CANNOTCONNECT',CONNECT_E_CANNOTCONNECT);
    AddConstant('CONNECT_E_OVERRIDDEN',CONNECT_E_OVERRIDDEN);
    AddConstant('SELFREG_E_FIRST',SELFREG_E_FIRST);
    AddConstant('SELFREG_E_LAST',SELFREG_E_LAST);
    AddConstant('SELFREG_S_FIRST',SELFREG_S_FIRST);
    AddConstant('SELFREG_S_LAST',SELFREG_S_LAST);
    AddConstant('SELFREG_E_TYPELIB',SELFREG_E_TYPELIB);
    AddConstant('SELFREG_E_CLASS',SELFREG_E_CLASS);
    AddConstant('PERPROP_E_FIRST',PERPROP_E_FIRST);
    AddConstant('PERPROP_E_LAST',PERPROP_E_LAST);
    AddConstant('PERPROP_S_FIRST',PERPROP_S_FIRST);
    AddConstant('PERPROP_S_LAST',PERPROP_S_LAST);
    AddConstant('PERPROP_E_NOPAGEAVAILABLE',PERPROP_E_NOPAGEAVAILABLE);
    AddConstant('OLEIVERB_PROPERTIES',OLEIVERB_PROPERTIES);
    AddConstant('VT_STREAMED_PROPSET',VT_STREAMED_PROPSET);
    AddConstant('VT_STORED_PROPSET',VT_STORED_PROPSET);
    AddConstant('VT_BLOB_PROPSET',VT_BLOB_PROPSET);
    AddConstant('VT_VERBOSE_ENUM',VT_VERBOSE_ENUM);
    AddConstant('VT_COLOR',VT_COLOR);
    AddConstant('VT_XPOS_PIXELS',VT_XPOS_PIXELS);
    AddConstant('VT_YPOS_PIXELS',VT_YPOS_PIXELS);
    AddConstant('VT_XSIZE_PIXELS',VT_XSIZE_PIXELS);
    AddConstant('VT_YSIZE_PIXELS',VT_YSIZE_PIXELS);
    AddConstant('VT_XPOS_HIMETRIC',VT_XPOS_HIMETRIC);
    AddConstant('VT_YPOS_HIMETRIC',VT_YPOS_HIMETRIC);
    AddConstant('VT_XSIZE_HIMETRIC',VT_XSIZE_HIMETRIC);
    AddConstant('VT_YSIZE_HIMETRIC',VT_YSIZE_HIMETRIC);
    AddConstant('VT_TRISTATE',VT_TRISTATE);
    AddConstant('VT_OPTEXCLUSIVE',VT_OPTEXCLUSIVE);
    AddConstant('VT_FONT',VT_FONT);
    AddConstant('VT_PICTURE',VT_PICTURE);
    AddConstant('VT_HANDLE',VT_HANDLE);
    AddConstant('OCM__BASE',OCM__BASE);
    AddConstant('OCM_COMMAND',OCM_COMMAND);
    AddConstant('OCM_CTLCOLORBTN',OCM_CTLCOLORBTN);
    AddConstant('OCM_CTLCOLOREDIT',OCM_CTLCOLOREDIT);
    AddConstant('OCM_CTLCOLORDLG',OCM_CTLCOLORDLG);
    AddConstant('OCM_CTLCOLORLISTBOX',OCM_CTLCOLORLISTBOX);
    AddConstant('OCM_CTLCOLORMSGBOX',OCM_CTLCOLORMSGBOX);
    AddConstant('OCM_CTLCOLORSCROLLBAR',OCM_CTLCOLORSCROLLBAR);
    AddConstant('OCM_CTLCOLORSTATIC',OCM_CTLCOLORSTATIC);
    AddConstant('OCM_DRAWITEM',OCM_DRAWITEM);
    AddConstant('OCM_MEASUREITEM',OCM_MEASUREITEM);
    AddConstant('OCM_DELETEITEM',OCM_DELETEITEM);
    AddConstant('OCM_VKEYTOITEM',OCM_VKEYTOITEM);
    AddConstant('OCM_CHARTOITEM',OCM_CHARTOITEM);
    AddConstant('OCM_COMPAREITEM',OCM_COMPAREITEM);
    AddConstant('OCM_HSCROLL',OCM_HSCROLL);
    AddConstant('OCM_VSCROLL',OCM_VSCROLL);
    AddConstant('OCM_PARENTNOTIFY',OCM_PARENTNOTIFY);
    AddConstant('OCM_NOTIFY',OCM_NOTIFY);
    AddConstant('CTRLINFO_EATS_RETURN',CTRLINFO_EATS_RETURN);
    AddConstant('CTRLINFO_EATS_ESCAPE',CTRLINFO_EATS_ESCAPE);
    AddConstant('XFORMCOORDS_POSITION',XFORMCOORDS_POSITION);
    AddConstant('XFORMCOORDS_SIZE',XFORMCOORDS_SIZE);
    AddConstant('XFORMCOORDS_HIMETRICTOCONTAINER',XFORMCOORDS_HIMETRICTOCONTAINER);
    AddConstant('XFORMCOORDS_CONTAINERTOHIMETRIC',XFORMCOORDS_CONTAINERTOHIMETRIC);
    AddConstant('PROPPAGESTATUS_DIRTY',PROPPAGESTATUS_DIRTY);
    AddConstant('PROPPAGESTATUS_VALIDATE',PROPPAGESTATUS_VALIDATE);
    AddConstant('PROPPAGESTATUS_CLEAN',PROPPAGESTATUS_CLEAN);
    AddConstant('PICTURE_SCALABLE',PICTURE_SCALABLE);
    AddConstant('PICTURE_TRANSPARENT',PICTURE_TRANSPARENT);
    AddConstant('PICTYPE_UNINITIALIZED',PICTYPE_UNINITIALIZED);
    AddConstant('PICTYPE_NONE',PICTYPE_NONE);
    AddConstant('PICTYPE_BITMAP',PICTYPE_BITMAP);
    AddConstant('PICTYPE_METAFILE',PICTYPE_METAFILE);
    AddConstant('PICTYPE_ICON',PICTYPE_ICON);
    AddConstant('PICTYPE_ENHMETAFILE',PICTYPE_ENHMETAFILE);
    AddConstant('DISPID_AUTOSIZE',DISPID_AUTOSIZE);
    AddConstant('DISPID_BACKCOLOR',DISPID_BACKCOLOR);
    AddConstant('DISPID_BACKSTYLE',DISPID_BACKSTYLE);
    AddConstant('DISPID_BORDERCOLOR',DISPID_BORDERCOLOR);
    AddConstant('DISPID_BORDERSTYLE',DISPID_BORDERSTYLE);
    AddConstant('DISPID_BORDERWIDTH',DISPID_BORDERWIDTH);
    AddConstant('DISPID_DRAWMODE',DISPID_DRAWMODE);
    AddConstant('DISPID_DRAWSTYLE',DISPID_DRAWSTYLE);
    AddConstant('DISPID_DRAWWIDTH',DISPID_DRAWWIDTH);
    AddConstant('DISPID_FILLCOLOR',DISPID_FILLCOLOR);
    AddConstant('DISPID_FILLSTYLE',DISPID_FILLSTYLE);
    AddConstant('DISPID_FONT',DISPID_FONT);
    AddConstant('DISPID_FORECOLOR',DISPID_FORECOLOR);
    AddConstant('DISPID_ENABLED',DISPID_ENABLED);
    AddConstant('DISPID_HWND',DISPID_HWND);
    AddConstant('DISPID_TABSTOP',DISPID_TABSTOP);
    AddConstant('DISPID_TEXT',DISPID_TEXT);
    AddConstant('DISPID_CAPTION',DISPID_CAPTION);
    AddConstant('DISPID_BORDERVISIBLE',DISPID_BORDERVISIBLE);
    AddConstant('DISPID_APPEARANCE',DISPID_APPEARANCE);
    AddConstant('DISPID_MOUSEPOINTER',DISPID_MOUSEPOINTER);
    AddConstant('DISPID_MOUSEICON',DISPID_MOUSEICON);
    AddConstant('DISPID_PICTURE',DISPID_PICTURE);
    AddConstant('DISPID_VALID',DISPID_VALID);
    AddConstant('DISPID_READYSTATE',DISPID_READYSTATE);
    AddConstant('DISPID_REFRESH',DISPID_REFRESH);
    AddConstant('DISPID_DOCLICK',DISPID_DOCLICK);
    AddConstant('DISPID_ABOUTBOX',DISPID_ABOUTBOX);
    AddConstant('DISPID_CLICK',DISPID_CLICK);
    AddConstant('DISPID_DBLCLICK',DISPID_DBLCLICK);
    AddConstant('DISPID_KEYDOWN',DISPID_KEYDOWN);
    AddConstant('DISPID_KEYPRESS',DISPID_KEYPRESS);
    AddConstant('DISPID_KEYUP',DISPID_KEYUP);
    AddConstant('DISPID_MOUSEDOWN',DISPID_MOUSEDOWN);
    AddConstant('DISPID_MOUSEMOVE',DISPID_MOUSEMOVE);
    AddConstant('DISPID_MOUSEUP',DISPID_MOUSEUP);
    AddConstant('DISPID_ERROREVENT',DISPID_ERROREVENT);
    AddConstant('DISPID_READYSTATECHANGE',DISPID_READYSTATECHANGE);
    AddConstant('DISPID_THIS',DISPID_THIS);
    AddConstant('DISPID_AMBIENT_BACKCOLOR',DISPID_AMBIENT_BACKCOLOR);
    AddConstant('DISPID_AMBIENT_DISPLAYNAME',DISPID_AMBIENT_DISPLAYNAME);
    AddConstant('DISPID_AMBIENT_FONT',DISPID_AMBIENT_FONT);
    AddConstant('DISPID_AMBIENT_FORECOLOR',DISPID_AMBIENT_FORECOLOR);
    AddConstant('DISPID_AMBIENT_LOCALEID',DISPID_AMBIENT_LOCALEID);
    AddConstant('DISPID_AMBIENT_MESSAGEREFLECT',DISPID_AMBIENT_MESSAGEREFLECT);
    AddConstant('DISPID_AMBIENT_SCALEUNITS',DISPID_AMBIENT_SCALEUNITS);
    AddConstant('DISPID_AMBIENT_TEXTALIGN',DISPID_AMBIENT_TEXTALIGN);
    AddConstant('DISPID_AMBIENT_USERMODE',DISPID_AMBIENT_USERMODE);
    AddConstant('DISPID_AMBIENT_UIDEAD',DISPID_AMBIENT_UIDEAD);
    AddConstant('DISPID_AMBIENT_SHOWGRABHANDLES',DISPID_AMBIENT_SHOWGRABHANDLES);
    AddConstant('DISPID_AMBIENT_SHOWHATCHING',DISPID_AMBIENT_SHOWHATCHING);
    AddConstant('DISPID_AMBIENT_DISPLAYASDEFAULT',DISPID_AMBIENT_DISPLAYASDEFAULT);
    AddConstant('DISPID_AMBIENT_SUPPORTSMNEMONICS',DISPID_AMBIENT_SUPPORTSMNEMONICS);
    AddConstant('DISPID_AMBIENT_AUTOCLIP',DISPID_AMBIENT_AUTOCLIP);
    AddConstant('DISPID_AMBIENT_APPEARANCE',DISPID_AMBIENT_APPEARANCE);
    AddConstant('DISPID_AMBIENT_PALETTE',DISPID_AMBIENT_PALETTE);
    AddConstant('DISPID_AMBIENT_TRANSFERPRIORITY',DISPID_AMBIENT_TRANSFERPRIORITY);
    AddConstant('DISPID_Name',DISPID_Name);
    AddConstant('DISPID_Delete',DISPID_Delete);
    AddConstant('DISPID_Object',DISPID_Object);
    AddConstant('DISPID_Parent',DISPID_Parent);
    AddConstant('DISPID_FONT_NAME',DISPID_FONT_NAME);
    AddConstant('DISPID_FONT_SIZE',DISPID_FONT_SIZE);
    AddConstant('DISPID_FONT_BOLD',DISPID_FONT_BOLD);
    AddConstant('DISPID_FONT_ITALIC',DISPID_FONT_ITALIC);
    AddConstant('DISPID_FONT_UNDER',DISPID_FONT_UNDER);
    AddConstant('DISPID_FONT_STRIKE',DISPID_FONT_STRIKE);
    AddConstant('DISPID_FONT_WEIGHT',DISPID_FONT_WEIGHT);
    AddConstant('DISPID_FONT_CHARSET',DISPID_FONT_CHARSET);
    AddConstant('DISPID_PICT_HANDLE',DISPID_PICT_HANDLE);
    AddConstant('DISPID_PICT_HPAL',DISPID_PICT_HPAL);
    AddConstant('DISPID_PICT_TYPE',DISPID_PICT_TYPE);
    AddConstant('DISPID_PICT_WIDTH',DISPID_PICT_WIDTH);
    AddConstant('DISPID_PICT_HEIGHT',DISPID_PICT_HEIGHT);
    AddConstant('DISPID_PICT_RENDER',DISPID_PICT_RENDER);
    AddConstant('PID_DICTIONARY',PID_DICTIONARY);
    AddConstant('PID_CODEPAGE',PID_CODEPAGE);
    AddConstant('PID_FIRST_USABLE',PID_FIRST_USABLE);
    AddConstant('PID_FIRST_NAME_DEFAULT',PID_FIRST_NAME_DEFAULT);
    AddConstant('PID_LOCALE',PID_LOCALE);
    AddConstant('PID_MODIFY_TIME',PID_MODIFY_TIME);
    AddConstant('PID_SECURITY',PID_SECURITY);
    AddConstant('PID_ILLEGAL',PID_ILLEGAL);
    AddConstant('PIDSI_TITLE',PIDSI_TITLE);
    AddConstant('PIDSI_SUBJECT',PIDSI_SUBJECT);
    AddConstant('PIDSI_AUTHOR',PIDSI_AUTHOR);
    AddConstant('PIDSI_KEYWORDS',PIDSI_KEYWORDS);
    AddConstant('PIDSI_COMMENTS',PIDSI_COMMENTS);
    AddConstant('PIDSI_TEMPLATE',PIDSI_TEMPLATE);
    AddConstant('PIDSI_LASTAUTHOR',PIDSI_LASTAUTHOR);
    AddConstant('PIDSI_REVNUMBER',PIDSI_REVNUMBER);
    AddConstant('PIDSI_EDITTIME',PIDSI_EDITTIME);
    AddConstant('PIDSI_LASTPRINTED',PIDSI_LASTPRINTED);
    AddConstant('PIDSI_CREATE_DTM',PIDSI_CREATE_DTM);
    AddConstant('PIDSI_LASTSAVE_DTM',PIDSI_LASTSAVE_DTM);
    AddConstant('PIDSI_PAGECOUNT',PIDSI_PAGECOUNT);
    AddConstant('PIDSI_WORDCOUNT',PIDSI_WORDCOUNT);
    AddConstant('PIDSI_CHARCOUNT',PIDSI_CHARCOUNT);
    AddConstant('PIDSI_THUMBNAIL',PIDSI_THUMBNAIL);
    AddConstant('PIDSI_APPNAME',PIDSI_APPNAME);
    AddConstant('PIDSI_DOC_SECURITY',PIDSI_DOC_SECURITY);
    AddConstant('PRSPEC_INVALID',PRSPEC_INVALID);
    AddConstant('PRSPEC_LPWSTR',PRSPEC_LPWSTR);
    AddConstant('PRSPEC_PROPID',PRSPEC_PROPID);
    AddConstant('triUnchecked',triUnchecked);
    AddConstant('triChecked',triChecked);
    AddConstant('triGray',triGray);
    AddConstant('PRINTFLAG_MAYBOTHERUSER',PRINTFLAG_MAYBOTHERUSER);
    AddConstant('PRINTFLAG_PROMPTUSER',PRINTFLAG_PROMPTUSER);
    AddConstant('PRINTFLAG_USERMAYCHANGEPRINTER',PRINTFLAG_USERMAYCHANGEPRINTER);
    AddConstant('PRINTFLAG_RECOMPOSETODEVICE',PRINTFLAG_RECOMPOSETODEVICE);
    AddConstant('PRINTFLAG_DONTACTUALLYPRINT',PRINTFLAG_DONTACTUALLYPRINT);
    AddConstant('PRINTFLAG_FORCEPROPERTIES',PRINTFLAG_FORCEPROPERTIES);
    AddConstant('PRINTFLAG_PRINTTOFILE',PRINTFLAG_PRINTTOFILE);
    AddConstant('PAGESET_TOLASTPAGE',PAGESET_TOLASTPAGE);
    AddConstant('OLECMDIDF_REFRESH_NORMAL',OLECMDIDF_REFRESH_NORMAL);
    AddConstant('OLECMDIDF_REFRESH_IFEXPIRED',OLECMDIDF_REFRESH_IFEXPIRED);
    AddConstant('OLECMDIDF_REFRESH_CONTINUE',OLECMDIDF_REFRESH_CONTINUE);
    AddConstant('OLECMDIDF_REFRESH_COMPLETELY',OLECMDIDF_REFRESH_COMPLETELY);
    AddConstant('OLECMDF_SUPPORTED',OLECMDF_SUPPORTED);
    AddConstant('OLECMDF_ENABLED',OLECMDF_ENABLED);
    AddConstant('OLECMDF_LATCHED',OLECMDF_LATCHED);
    AddConstant('OLECMDF_NINCHED',OLECMDF_NINCHED);
    AddConstant('OLECMDTEXTF_NONE',OLECMDTEXTF_NONE);
    AddConstant('OLECMDTEXTF_NAME',OLECMDTEXTF_NAME);
    AddConstant('OLECMDTEXTF_STATUS',OLECMDTEXTF_STATUS);
    AddConstant('OLECMDEXECOPT_DODEFAULT',OLECMDEXECOPT_DODEFAULT);
    AddConstant('OLECMDEXECOPT_PROMPTUSER',OLECMDEXECOPT_PROMPTUSER);
    AddConstant('OLECMDEXECOPT_DONTPROMPTUSER',OLECMDEXECOPT_DONTPROMPTUSER);
    AddConstant('OLECMDEXECOPT_SHOWHELP',OLECMDEXECOPT_SHOWHELP);
    AddConstant('OLECMDID_OPEN',OLECMDID_OPEN);
    AddConstant('OLECMDID_NEW',OLECMDID_NEW);
    AddConstant('OLECMDID_SAVE',OLECMDID_SAVE);
    AddConstant('OLECMDID_SAVEAS',OLECMDID_SAVEAS);
    AddConstant('OLECMDID_SAVECOPYAS',OLECMDID_SAVECOPYAS);
    AddConstant('OLECMDID_PRINT',OLECMDID_PRINT);
    AddConstant('OLECMDID_PRINTPREVIEW',OLECMDID_PRINTPREVIEW);
    AddConstant('OLECMDID_PAGESETUP',OLECMDID_PAGESETUP);
    AddConstant('OLECMDID_SPELL',OLECMDID_SPELL);
    AddConstant('OLECMDID_PROPERTIES',OLECMDID_PROPERTIES);
    AddConstant('OLECMDID_CUT',OLECMDID_CUT);
    AddConstant('OLECMDID_COPY',OLECMDID_COPY);
    AddConstant('OLECMDID_PASTE',OLECMDID_PASTE);
    AddConstant('OLECMDID_PASTESPECIAL',OLECMDID_PASTESPECIAL);
    AddConstant('OLECMDID_UNDO',OLECMDID_UNDO);
    AddConstant('OLECMDID_REDO',OLECMDID_REDO);
    AddConstant('OLECMDID_SELECTALL',OLECMDID_SELECTALL);
    AddConstant('OLECMDID_CLEARSELECTION',OLECMDID_CLEARSELECTION);
    AddConstant('OLECMDID_ZOOM',OLECMDID_ZOOM);
    AddConstant('OLECMDID_GETZOOMRANGE',OLECMDID_GETZOOMRANGE);
    AddConstant('OLECMDID_UPDATECOMMANDS',OLECMDID_UPDATECOMMANDS);
    AddConstant('OLECMDID_REFRESH',OLECMDID_REFRESH);
    AddConstant('OLECMDID_STOP',OLECMDID_STOP);
    AddConstant('OLECMDID_HIDETOOLBARS',OLECMDID_HIDETOOLBARS);
    AddConstant('OLECMDID_SETPROGRESSMAX',OLECMDID_SETPROGRESSMAX);
    AddConstant('OLECMDID_SETPROGRESSPOS',OLECMDID_SETPROGRESSPOS);
    AddConstant('OLECMDID_SETPROGRESSTEXT',OLECMDID_SETPROGRESSTEXT);
    AddConstant('OLECMDID_SETTITLE',OLECMDID_SETTITLE);
    AddConstant('OLECMDID_SETDOWNLOADSTATE',OLECMDID_SETDOWNLOADSTATE);
    AddConstant('OLECMDID_STOPDOWNLOAD',OLECMDID_STOPDOWNLOAD);
    AddConstant('OLECMDERR_E_FIRST',OLECMDERR_E_FIRST);
    AddConstant('OLECMDERR_E_NOTSUPPORTED',OLECMDERR_E_NOTSUPPORTED);
    AddConstant('OLECMDERR_E_DISABLED',OLECMDERR_E_DISABLED);
    AddConstant('OLECMDERR_E_NOHELP',OLECMDERR_E_NOHELP);
    AddConstant('OLECMDERR_E_CANCELED',OLECMDERR_E_CANCELED);
    AddConstant('OLECMDERR_E_UNKNOWNGROUP',OLECMDERR_E_UNKNOWNGROUP);
    AddConstant('MSOCMDERR_E_FIRST',MSOCMDERR_E_FIRST);
    AddConstant('MSOCMDERR_E_NOTSUPPORTED',MSOCMDERR_E_NOTSUPPORTED);
    AddConstant('MSOCMDERR_E_DISABLED',MSOCMDERR_E_DISABLED);
    AddConstant('MSOCMDERR_E_NOHELP',MSOCMDERR_E_NOHELP);
    AddConstant('MSOCMDERR_E_CANCELED',MSOCMDERR_E_CANCELED);
    AddConstant('MSOCMDERR_E_UNKNOWNGROUP',MSOCMDERR_E_UNKNOWNGROUP);
    AddConstant('INTERFACESAFE_FOR_UNTRUSTED_CALLER',INTERFACESAFE_FOR_UNTRUSTED_CALLER);
    AddConstant('INTERFACESAFE_FOR_UNTRUSTED_DATA',INTERFACESAFE_FOR_UNTRUSTED_DATA);
    AddConstant('fdexNameCaseSensitive',fdexNameCaseSensitive);
    AddConstant('fdexNameEnsure',fdexNameEnsure);
    AddConstant('fdexNameImplicit',fdexNameImplicit);
    AddConstant('fdexNameCaseInsensitive',fdexNameCaseInsensitive);
    AddConstant('fdexPropCanGet',fdexPropCanGet);
    AddConstant('fdexPropCannotGet',fdexPropCannotGet);
    AddConstant('fdexPropCanPut',fdexPropCanPut);
    AddConstant('fdexPropCannotPut',fdexPropCannotPut);
    AddConstant('fdexPropCanPutRef',fdexPropCanPutRef);
    AddConstant('fdexPropCannotPutRef',fdexPropCannotPutRef);
    AddConstant('fdexPropNoSideEffects',fdexPropNoSideEffects);
    AddConstant('fdexPropDynamicType',fdexPropDynamicType);
    AddConstant('fdexPropCanCall',fdexPropCanCall);
    AddConstant('fdexPropCannotCall',fdexPropCannotCall);
    AddConstant('fdexPropCanConstruct',fdexPropCanConstruct);
    AddConstant('fdexPropCannotConstruct',fdexPropCannotConstruct);
    AddConstant('fdexPropCanSourceEvents',fdexPropCanSourceEvents);
    AddConstant('fdexPropCannotSourceEvents',fdexPropCannotSourceEvents);
    AddConstant('fdexPropCanAll',fdexPropCanAll);
    AddConstant('fdexPropCannotAll',fdexPropCannotAll);
    AddConstant('fdexPropExtraAll',fdexPropExtraAll);
    AddConstant('fdexPropAll',fdexPropAll);
    AddConstant('fdexEnumDefault',fdexEnumDefault);
    AddConstant('fdexEnumAll',fdexEnumAll);
    AddConstant('COINIT_MULTITHREADED',COINIT_MULTITHREADED);
    AddConstant('COINIT_APARTMENTTHREADED',COINIT_APARTMENTTHREADED);
    AddConstant('COINIT_DISABLE_OLE1DDE',COINIT_DISABLE_OLE1DDE);
    AddConstant('COINIT_SPEED_OVER_MEMORY',COINIT_SPEED_OVER_MEMORY);
    AddConstant('ACTIVEOBJECT_STRONG',ACTIVEOBJECT_STRONG);
    AddConstant('ACTIVEOBJECT_WEAK',ACTIVEOBJECT_WEAK);
    AddConstant('PROPSETHDR_OSVERSION_UNKNOWN',PROPSETHDR_OSVERSION_UNKNOWN);
  end;
end;

class function TatActiveXLibrary.LibraryName: string;
begin
  result := 'ActiveX';
end;

initialization
  RegisterScripterLibrary(TatActiveXLibrary, True);

{$WARNINGS ON}

end.

