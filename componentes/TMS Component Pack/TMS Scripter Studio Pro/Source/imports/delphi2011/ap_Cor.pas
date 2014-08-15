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
unit ap_Cor;

interface

uses
  Windows,
  ActiveX,
  CorError,
  CorHdr,
  Cor,
  Variants,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatCorLibrary = class(TatScripterLibrary)
    procedure __IsRidType(AMachine: TatVirtualMachine);
    procedure __IsCodedTokenType(AMachine: TatVirtualMachine);
    procedure __IsRidOrToken(AMachine: TatVirtualMachine);
    procedure __IsHeapType(AMachine: TatVirtualMachine);
    procedure __IsFixedType(AMachine: TatVirtualMachine);
    procedure ___CorExeMain(AMachine: TatVirtualMachine);
    procedure __CoInitializeEE(AMachine: TatVirtualMachine);
    procedure __CoUninitializeEE(AMachine: TatVirtualMachine);
    procedure __CoEEShutDownCOM(AMachine: TatVirtualMachine);
    procedure __CoInitializeCor(AMachine: TatVirtualMachine);
    procedure __CoUninitializeCor(AMachine: TatVirtualMachine);
    procedure __CorIsPrimitiveType(AMachine: TatVirtualMachine);
    procedure __CorIsModifierElementType(AMachine: TatVirtualMachine);
    procedure __GetLIBID_ComPlusRuntime(AMachine: TatVirtualMachine);
    procedure __GetGUID_ExportedFromComPlus(AMachine: TatVirtualMachine);
    procedure __GetGUID_ManagedName(AMachine: TatVirtualMachine);
    procedure __GetGUID_Function2Getter(AMachine: TatVirtualMachine);
    procedure __GetCLSID_CorMetaDataDispenserRuntime(AMachine: TatVirtualMachine);
    procedure __GetGUID_DispIdOverride(AMachine: TatVirtualMachine);
    procedure __GetGUID_ForceIEnumerable(AMachine: TatVirtualMachine);
    procedure __GetGUID_PropGetCA(AMachine: TatVirtualMachine);
    procedure __GetGUID_PropPutCA(AMachine: TatVirtualMachine);
    procedure __GetCLSID_CLR_v1_MetaData(AMachine: TatVirtualMachine);
    procedure __GetCLSID_CLR_v2_MetaData(AMachine: TatVirtualMachine);
    procedure __GetCLSID_CorMetaDataRuntime(AMachine: TatVirtualMachine);
    procedure __GetMetaDataCheckDuplicatesFor(AMachine: TatVirtualMachine);
    procedure __GetMetaDataRefToDefCheck(AMachine: TatVirtualMachine);
    procedure __GetMetaDataNotificationForTokenMovement(AMachine: TatVirtualMachine);
    procedure __GetMetaDataSetUpdate(AMachine: TatVirtualMachine);
    procedure __GetMetaDataSetENC(AMachine: TatVirtualMachine);
    procedure __GetMetaDataImportOption(AMachine: TatVirtualMachine);
    procedure __GetMetaDataThreadSafetyOptions(AMachine: TatVirtualMachine);
    procedure __GetMetaDataErrorIfEmitOutOfOrder(AMachine: TatVirtualMachine);
    procedure __GetMetaDataGenerateTCEAdapters(AMachine: TatVirtualMachine);
    procedure __GetMetaDataTypeLibImportNamespace(AMachine: TatVirtualMachine);
    procedure __GetMetaDataLinkerOptions(AMachine: TatVirtualMachine);
    procedure __GetMetaDataRuntimeVersion(AMachine: TatVirtualMachine);
    procedure __GetMetaDataMergerOptions(AMachine: TatVirtualMachine);
    procedure __GetCLSID_Cor(AMachine: TatVirtualMachine);
    procedure __GetCLSID_CorMetaDataDispenser(AMachine: TatVirtualMachine);
    procedure __GetCLSID_CorMetaDataDispenserReg(AMachine: TatVirtualMachine);
    procedure __GetCLSID_CorMetaDataReg(AMachine: TatVirtualMachine);
    procedure __GetIID_IMetaDataInternal(AMachine: TatVirtualMachine);
    procedure __GetIID_IMetaDataError(AMachine: TatVirtualMachine);
    procedure __GetIID_IMapToken(AMachine: TatVirtualMachine);
    procedure __GetIID_IMetaDataDispenser(AMachine: TatVirtualMachine);
    procedure __GetIID_IMetaDataEmit(AMachine: TatVirtualMachine);
    procedure __GetIID_IMetaDataEmit2(AMachine: TatVirtualMachine);
    procedure __GetIID_IMetaDataImport(AMachine: TatVirtualMachine);
    procedure __GetIID_IMetaDataImport2(AMachine: TatVirtualMachine);
    procedure __GetIID_IMetaDataFilter(AMachine: TatVirtualMachine);
    procedure __GetIID_IHostFilter(AMachine: TatVirtualMachine);
    procedure __GetIID_IMetaDataConverter(AMachine: TatVirtualMachine);
    procedure __GetIID_IMetaDataAssemblyEmit(AMachine: TatVirtualMachine);
    procedure __GetIID_IMetaDataAssemblyImport(AMachine: TatVirtualMachine);
    procedure __GetIID_IMetaDataValidate(AMachine: TatVirtualMachine);
    procedure __GetIID_IMetaDataDispenserEx(AMachine: TatVirtualMachine);
    procedure __GetIID_ICeeGen(AMachine: TatVirtualMachine);
    procedure __GetIID_ICorModule(AMachine: TatVirtualMachine);
    procedure __GetIID_IMetaDataTables(AMachine: TatVirtualMachine);
    procedure __GetIID_IMetaDataTables2(AMachine: TatVirtualMachine);
    procedure __GetIID_INativeImageDependency(AMachine: TatVirtualMachine);
    procedure __GetIID_INativeImageEvaluate(AMachine: TatVirtualMachine);
    procedure __GetIID_INativeImageInstallInfo(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  OSINFOWrapper = class(TatRecordWrapper)
  private
    FdwOSPlatformId: DWORD;
    FdwOSMajorVersion: DWORD;
    FdwOSMinorVersion: DWORD;
  public
    constructor Create(ARecord: OSINFO);
    function ObjToRec: OSINFO;
  published
    property dwOSPlatformId: DWORD read FdwOSPlatformId write FdwOSPlatformId;
    property dwOSMajorVersion: DWORD read FdwOSMajorVersion write FdwOSMajorVersion;
    property dwOSMinorVersion: DWORD read FdwOSMinorVersion write FdwOSMinorVersion;
  end;
  
  ASSEMBLYMETADATAWrapper = class(TatRecordWrapper)
  private
    FusMajorVersion: USHORT;
    FusMinorVersion: USHORT;
    FusBuildNumber: USHORT;
    FusRevisionNumber: USHORT;
    FcbLocale: ULONG;
    FulProcessor: ULONG;
    FulOS: ULONG;
  public
    constructor Create(ARecord: ASSEMBLYMETADATA);
    function ObjToRec: ASSEMBLYMETADATA;
  published
    property usMajorVersion: USHORT read FusMajorVersion write FusMajorVersion;
    property usMinorVersion: USHORT read FusMinorVersion write FusMinorVersion;
    property usBuildNumber: USHORT read FusBuildNumber write FusBuildNumber;
    property usRevisionNumber: USHORT read FusRevisionNumber write FusRevisionNumber;
    property cbLocale: ULONG read FcbLocale write FcbLocale;
    property ulProcessor: ULONG read FulProcessor write FulProcessor;
    property ulOS: ULONG read FulOS write FulOS;
  end;
  
  CVStructWrapper = class(TatRecordWrapper)
  private
    FMajor: ShortInt;
    FMinor: ShortInt;
    FSub: ShortInt;
    FBuild: ShortInt;
  public
    constructor Create(ARecord: CVStruct);
    function ObjToRec: CVStruct;
  published
    property Major: ShortInt read FMajor write FMajor;
    property Minor: ShortInt read FMinor write FMinor;
    property Sub: ShortInt read FSub write FSub;
    property Build: ShortInt read FBuild write FBuild;
  end;
  
  CeeSectionRelocExtraWrapper = class(TatRecordWrapper)
  private
    FhighAdj: USHORT;
  public
    constructor Create(ARecord: CeeSectionRelocExtra);
    function ObjToRec: CeeSectionRelocExtra;
  published
    property highAdj: USHORT read FhighAdj write FhighAdj;
  end;
  
  CORCOMPILE_ASSEMBLY_SIGNATUREWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: CORCOMPILE_ASSEMBLY_SIGNATURE);
    function ObjToRec: CORCOMPILE_ASSEMBLY_SIGNATURE;
  published
  end;
  
  COR_NATIVE_LINKWrapper = class(TatRecordWrapper)
  private
    Fm_linkType: CorNativeLinkType;
    Fm_flags: CorNativeLinkFlags;
    Fm_entryPoint: mdMemberRef;
  public
    constructor Create(ARecord: COR_NATIVE_LINK);
    function ObjToRec: COR_NATIVE_LINK;
  published
    property m_linkType: CorNativeLinkType read Fm_linkType write Fm_linkType;
    property m_flags: CorNativeLinkFlags read Fm_flags write Fm_flags;
    property m_entryPoint: mdMemberRef read Fm_entryPoint write Fm_entryPoint;
  end;
  

implementation

constructor OSINFOWrapper.Create(ARecord: OSINFO);
begin
  inherited Create;
  FdwOSPlatformId := ARecord.dwOSPlatformId;
  FdwOSMajorVersion := ARecord.dwOSMajorVersion;
  FdwOSMinorVersion := ARecord.dwOSMinorVersion;
end;

function OSINFOWrapper.ObjToRec: OSINFO;
begin
  result.dwOSPlatformId := FdwOSPlatformId;
  result.dwOSMajorVersion := FdwOSMajorVersion;
  result.dwOSMinorVersion := FdwOSMinorVersion;
end;

constructor ASSEMBLYMETADATAWrapper.Create(ARecord: ASSEMBLYMETADATA);
begin
  inherited Create;
  FusMajorVersion := ARecord.usMajorVersion;
  FusMinorVersion := ARecord.usMinorVersion;
  FusBuildNumber := ARecord.usBuildNumber;
  FusRevisionNumber := ARecord.usRevisionNumber;
  FcbLocale := ARecord.cbLocale;
  FulProcessor := ARecord.ulProcessor;
  FulOS := ARecord.ulOS;
end;

function ASSEMBLYMETADATAWrapper.ObjToRec: ASSEMBLYMETADATA;
begin
  result.usMajorVersion := FusMajorVersion;
  result.usMinorVersion := FusMinorVersion;
  result.usBuildNumber := FusBuildNumber;
  result.usRevisionNumber := FusRevisionNumber;
  result.cbLocale := FcbLocale;
  result.ulProcessor := FulProcessor;
  result.ulOS := FulOS;
end;

constructor CVStructWrapper.Create(ARecord: CVStruct);
begin
  inherited Create;
  FMajor := ARecord.Major;
  FMinor := ARecord.Minor;
  FSub := ARecord.Sub;
  FBuild := ARecord.Build;
end;

function CVStructWrapper.ObjToRec: CVStruct;
begin
  result.Major := FMajor;
  result.Minor := FMinor;
  result.Sub := FSub;
  result.Build := FBuild;
end;

constructor CeeSectionRelocExtraWrapper.Create(ARecord: CeeSectionRelocExtra);
begin
  inherited Create;
  FhighAdj := ARecord.highAdj;
end;

function CeeSectionRelocExtraWrapper.ObjToRec: CeeSectionRelocExtra;
begin
  result.highAdj := FhighAdj;
end;

constructor CORCOMPILE_ASSEMBLY_SIGNATUREWrapper.Create(ARecord: CORCOMPILE_ASSEMBLY_SIGNATURE);
begin
  inherited Create;
end;

function CORCOMPILE_ASSEMBLY_SIGNATUREWrapper.ObjToRec: CORCOMPILE_ASSEMBLY_SIGNATURE;
begin
end;

constructor COR_NATIVE_LINKWrapper.Create(ARecord: COR_NATIVE_LINK);
begin
  inherited Create;
  Fm_linkType := ARecord.m_linkType;
  Fm_flags := ARecord.m_flags;
  Fm_entryPoint := ARecord.m_entryPoint;
end;

function COR_NATIVE_LINKWrapper.ObjToRec: COR_NATIVE_LINK;
begin
  result.m_linkType := Fm_linkType;
  result.m_flags := Fm_flags;
  result.m_entryPoint := Fm_entryPoint;
end;



procedure TatCorLibrary.__IsRidType(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Cor.IsRidType(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorLibrary.__IsCodedTokenType(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Cor.IsCodedTokenType(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorLibrary.__IsRidOrToken(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Cor.IsRidOrToken(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorLibrary.__IsHeapType(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Cor.IsHeapType(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorLibrary.__IsFixedType(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Cor.IsFixedType(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorLibrary.___CorExeMain(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Cor._CorExeMain);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorLibrary.__CoInitializeEE(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Cor.CoInitializeEE(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorLibrary.__CoUninitializeEE(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Cor.CoUninitializeEE(GetInputArg(0));
  end;
end;

procedure TatCorLibrary.__CoEEShutDownCOM(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Cor.CoEEShutDownCOM;
  end;
end;

procedure TatCorLibrary.__CoInitializeCor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Cor.CoInitializeCor(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorLibrary.__CoUninitializeCor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Cor.CoUninitializeCor;
  end;
end;

procedure TatCorLibrary.__CorIsPrimitiveType(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Cor.CorIsPrimitiveType(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorLibrary.__CorIsModifierElementType(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Cor.CorIsModifierElementType(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorLibrary.__GetLIBID_ComPlusRuntime(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.LIBID_ComPlusRuntime)));
  end;
end;

procedure TatCorLibrary.__GetGUID_ExportedFromComPlus(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.GUID_ExportedFromComPlus)));
  end;
end;

procedure TatCorLibrary.__GetGUID_ManagedName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.GUID_ManagedName)));
  end;
end;

procedure TatCorLibrary.__GetGUID_Function2Getter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.GUID_Function2Getter)));
  end;
end;

procedure TatCorLibrary.__GetCLSID_CorMetaDataDispenserRuntime(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.CLSID_CorMetaDataDispenserRuntime)));
  end;
end;

procedure TatCorLibrary.__GetGUID_DispIdOverride(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.GUID_DispIdOverride)));
  end;
end;

procedure TatCorLibrary.__GetGUID_ForceIEnumerable(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.GUID_ForceIEnumerable)));
  end;
end;

procedure TatCorLibrary.__GetGUID_PropGetCA(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.GUID_PropGetCA)));
  end;
end;

procedure TatCorLibrary.__GetGUID_PropPutCA(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.GUID_PropPutCA)));
  end;
end;

procedure TatCorLibrary.__GetCLSID_CLR_v1_MetaData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.CLSID_CLR_v1_MetaData)));
  end;
end;

procedure TatCorLibrary.__GetCLSID_CLR_v2_MetaData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.CLSID_CLR_v2_MetaData)));
  end;
end;

procedure TatCorLibrary.__GetCLSID_CorMetaDataRuntime(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.CLSID_CorMetaDataRuntime)));
  end;
end;

procedure TatCorLibrary.__GetMetaDataCheckDuplicatesFor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.MetaDataCheckDuplicatesFor)));
  end;
end;

procedure TatCorLibrary.__GetMetaDataRefToDefCheck(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.MetaDataRefToDefCheck)));
  end;
end;

procedure TatCorLibrary.__GetMetaDataNotificationForTokenMovement(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.MetaDataNotificationForTokenMovement)));
  end;
end;

procedure TatCorLibrary.__GetMetaDataSetUpdate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.MetaDataSetUpdate)));
  end;
end;

procedure TatCorLibrary.__GetMetaDataSetENC(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.MetaDataSetENC)));
  end;
end;

procedure TatCorLibrary.__GetMetaDataImportOption(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.MetaDataImportOption)));
  end;
end;

procedure TatCorLibrary.__GetMetaDataThreadSafetyOptions(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.MetaDataThreadSafetyOptions)));
  end;
end;

procedure TatCorLibrary.__GetMetaDataErrorIfEmitOutOfOrder(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.MetaDataErrorIfEmitOutOfOrder)));
  end;
end;

procedure TatCorLibrary.__GetMetaDataGenerateTCEAdapters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.MetaDataGenerateTCEAdapters)));
  end;
end;

procedure TatCorLibrary.__GetMetaDataTypeLibImportNamespace(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.MetaDataTypeLibImportNamespace)));
  end;
end;

procedure TatCorLibrary.__GetMetaDataLinkerOptions(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.MetaDataLinkerOptions)));
  end;
end;

procedure TatCorLibrary.__GetMetaDataRuntimeVersion(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.MetaDataRuntimeVersion)));
  end;
end;

procedure TatCorLibrary.__GetMetaDataMergerOptions(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.MetaDataMergerOptions)));
  end;
end;

procedure TatCorLibrary.__GetCLSID_Cor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.CLSID_Cor)));
  end;
end;

procedure TatCorLibrary.__GetCLSID_CorMetaDataDispenser(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.CLSID_CorMetaDataDispenser)));
  end;
end;

procedure TatCorLibrary.__GetCLSID_CorMetaDataDispenserReg(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.CLSID_CorMetaDataDispenserReg)));
  end;
end;

procedure TatCorLibrary.__GetCLSID_CorMetaDataReg(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.CLSID_CorMetaDataReg)));
  end;
end;

procedure TatCorLibrary.__GetIID_IMetaDataInternal(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.IID_IMetaDataInternal)));
  end;
end;

procedure TatCorLibrary.__GetIID_IMetaDataError(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.IID_IMetaDataError)));
  end;
end;

procedure TatCorLibrary.__GetIID_IMapToken(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.IID_IMapToken)));
  end;
end;

procedure TatCorLibrary.__GetIID_IMetaDataDispenser(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.IID_IMetaDataDispenser)));
  end;
end;

procedure TatCorLibrary.__GetIID_IMetaDataEmit(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.IID_IMetaDataEmit)));
  end;
end;

procedure TatCorLibrary.__GetIID_IMetaDataEmit2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.IID_IMetaDataEmit2)));
  end;
end;

procedure TatCorLibrary.__GetIID_IMetaDataImport(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.IID_IMetaDataImport)));
  end;
end;

procedure TatCorLibrary.__GetIID_IMetaDataImport2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.IID_IMetaDataImport2)));
  end;
end;

procedure TatCorLibrary.__GetIID_IMetaDataFilter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.IID_IMetaDataFilter)));
  end;
end;

procedure TatCorLibrary.__GetIID_IHostFilter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.IID_IHostFilter)));
  end;
end;

procedure TatCorLibrary.__GetIID_IMetaDataConverter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.IID_IMetaDataConverter)));
  end;
end;

procedure TatCorLibrary.__GetIID_IMetaDataAssemblyEmit(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.IID_IMetaDataAssemblyEmit)));
  end;
end;

procedure TatCorLibrary.__GetIID_IMetaDataAssemblyImport(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.IID_IMetaDataAssemblyImport)));
  end;
end;

procedure TatCorLibrary.__GetIID_IMetaDataValidate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.IID_IMetaDataValidate)));
  end;
end;

procedure TatCorLibrary.__GetIID_IMetaDataDispenserEx(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.IID_IMetaDataDispenserEx)));
  end;
end;

procedure TatCorLibrary.__GetIID_ICeeGen(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.IID_ICeeGen)));
  end;
end;

procedure TatCorLibrary.__GetIID_ICorModule(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.IID_ICorModule)));
  end;
end;

procedure TatCorLibrary.__GetIID_IMetaDataTables(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.IID_IMetaDataTables)));
  end;
end;

procedure TatCorLibrary.__GetIID_IMetaDataTables2(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.IID_IMetaDataTables2)));
  end;
end;

procedure TatCorLibrary.__GetIID_INativeImageDependency(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.IID_INativeImageDependency)));
  end;
end;

procedure TatCorLibrary.__GetIID_INativeImageEvaluate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.IID_INativeImageEvaluate)));
  end;
end;

procedure TatCorLibrary.__GetIID_INativeImageInstallInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(Cor.IID_INativeImageInstallInfo)));
  end;
end;

procedure TatCorLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('IsRidType',1,tkVariant,nil,__IsRidType,false,0);
    DefineMethod('IsCodedTokenType',1,tkVariant,nil,__IsCodedTokenType,false,0);
    DefineMethod('IsRidOrToken',1,tkVariant,nil,__IsRidOrToken,false,0);
    DefineMethod('IsHeapType',1,tkVariant,nil,__IsHeapType,false,0);
    DefineMethod('IsFixedType',1,tkVariant,nil,__IsFixedType,false,0);
    DefineMethod('_CorExeMain',0,tkInteger,nil,___CorExeMain,false,0);
    DefineMethod('CoInitializeEE',1,tkVariant,nil,__CoInitializeEE,false,0);
    DefineMethod('CoUninitializeEE',1,tkNone,nil,__CoUninitializeEE,false,0);
    DefineMethod('CoEEShutDownCOM',0,tkNone,nil,__CoEEShutDownCOM,false,0);
    DefineMethod('CoInitializeCor',1,tkVariant,nil,__CoInitializeCor,false,0);
    DefineMethod('CoUninitializeCor',0,tkNone,nil,__CoUninitializeCor,false,0);
    DefineMethod('CorIsPrimitiveType',1,tkVariant,nil,__CorIsPrimitiveType,false,0);
    DefineMethod('CorIsModifierElementType',1,tkVariant,nil,__CorIsModifierElementType,false,0);
    DefineProp('LIBID_ComPlusRuntime',tkVariant,__GetLIBID_ComPlusRuntime,nil,nil,false,0);
    DefineProp('GUID_ExportedFromComPlus',tkVariant,__GetGUID_ExportedFromComPlus,nil,nil,false,0);
    DefineProp('GUID_ManagedName',tkVariant,__GetGUID_ManagedName,nil,nil,false,0);
    DefineProp('GUID_Function2Getter',tkVariant,__GetGUID_Function2Getter,nil,nil,false,0);
    DefineProp('CLSID_CorMetaDataDispenserRuntime',tkVariant,__GetCLSID_CorMetaDataDispenserRuntime,nil,nil,false,0);
    DefineProp('GUID_DispIdOverride',tkVariant,__GetGUID_DispIdOverride,nil,nil,false,0);
    DefineProp('GUID_ForceIEnumerable',tkVariant,__GetGUID_ForceIEnumerable,nil,nil,false,0);
    DefineProp('GUID_PropGetCA',tkVariant,__GetGUID_PropGetCA,nil,nil,false,0);
    DefineProp('GUID_PropPutCA',tkVariant,__GetGUID_PropPutCA,nil,nil,false,0);
    DefineProp('CLSID_CLR_v1_MetaData',tkVariant,__GetCLSID_CLR_v1_MetaData,nil,nil,false,0);
    DefineProp('CLSID_CLR_v2_MetaData',tkVariant,__GetCLSID_CLR_v2_MetaData,nil,nil,false,0);
    DefineProp('CLSID_CorMetaDataRuntime',tkVariant,__GetCLSID_CorMetaDataRuntime,nil,nil,false,0);
    DefineProp('MetaDataCheckDuplicatesFor',tkVariant,__GetMetaDataCheckDuplicatesFor,nil,nil,false,0);
    DefineProp('MetaDataRefToDefCheck',tkVariant,__GetMetaDataRefToDefCheck,nil,nil,false,0);
    DefineProp('MetaDataNotificationForTokenMovement',tkVariant,__GetMetaDataNotificationForTokenMovement,nil,nil,false,0);
    DefineProp('MetaDataSetUpdate',tkVariant,__GetMetaDataSetUpdate,nil,nil,false,0);
    DefineProp('MetaDataSetENC',tkVariant,__GetMetaDataSetENC,nil,nil,false,0);
    DefineProp('MetaDataImportOption',tkVariant,__GetMetaDataImportOption,nil,nil,false,0);
    DefineProp('MetaDataThreadSafetyOptions',tkVariant,__GetMetaDataThreadSafetyOptions,nil,nil,false,0);
    DefineProp('MetaDataErrorIfEmitOutOfOrder',tkVariant,__GetMetaDataErrorIfEmitOutOfOrder,nil,nil,false,0);
    DefineProp('MetaDataGenerateTCEAdapters',tkVariant,__GetMetaDataGenerateTCEAdapters,nil,nil,false,0);
    DefineProp('MetaDataTypeLibImportNamespace',tkVariant,__GetMetaDataTypeLibImportNamespace,nil,nil,false,0);
    DefineProp('MetaDataLinkerOptions',tkVariant,__GetMetaDataLinkerOptions,nil,nil,false,0);
    DefineProp('MetaDataRuntimeVersion',tkVariant,__GetMetaDataRuntimeVersion,nil,nil,false,0);
    DefineProp('MetaDataMergerOptions',tkVariant,__GetMetaDataMergerOptions,nil,nil,false,0);
    DefineProp('CLSID_Cor',tkVariant,__GetCLSID_Cor,nil,nil,false,0);
    DefineProp('CLSID_CorMetaDataDispenser',tkVariant,__GetCLSID_CorMetaDataDispenser,nil,nil,false,0);
    DefineProp('CLSID_CorMetaDataDispenserReg',tkVariant,__GetCLSID_CorMetaDataDispenserReg,nil,nil,false,0);
    DefineProp('CLSID_CorMetaDataReg',tkVariant,__GetCLSID_CorMetaDataReg,nil,nil,false,0);
    DefineProp('IID_IMetaDataInternal',tkVariant,__GetIID_IMetaDataInternal,nil,nil,false,0);
    DefineProp('IID_IMetaDataError',tkVariant,__GetIID_IMetaDataError,nil,nil,false,0);
    DefineProp('IID_IMapToken',tkVariant,__GetIID_IMapToken,nil,nil,false,0);
    DefineProp('IID_IMetaDataDispenser',tkVariant,__GetIID_IMetaDataDispenser,nil,nil,false,0);
    DefineProp('IID_IMetaDataEmit',tkVariant,__GetIID_IMetaDataEmit,nil,nil,false,0);
    DefineProp('IID_IMetaDataEmit2',tkVariant,__GetIID_IMetaDataEmit2,nil,nil,false,0);
    DefineProp('IID_IMetaDataImport',tkVariant,__GetIID_IMetaDataImport,nil,nil,false,0);
    DefineProp('IID_IMetaDataImport2',tkVariant,__GetIID_IMetaDataImport2,nil,nil,false,0);
    DefineProp('IID_IMetaDataFilter',tkVariant,__GetIID_IMetaDataFilter,nil,nil,false,0);
    DefineProp('IID_IHostFilter',tkVariant,__GetIID_IHostFilter,nil,nil,false,0);
    DefineProp('IID_IMetaDataConverter',tkVariant,__GetIID_IMetaDataConverter,nil,nil,false,0);
    DefineProp('IID_IMetaDataAssemblyEmit',tkVariant,__GetIID_IMetaDataAssemblyEmit,nil,nil,false,0);
    DefineProp('IID_IMetaDataAssemblyImport',tkVariant,__GetIID_IMetaDataAssemblyImport,nil,nil,false,0);
    DefineProp('IID_IMetaDataValidate',tkVariant,__GetIID_IMetaDataValidate,nil,nil,false,0);
    DefineProp('IID_IMetaDataDispenserEx',tkVariant,__GetIID_IMetaDataDispenserEx,nil,nil,false,0);
    DefineProp('IID_ICeeGen',tkVariant,__GetIID_ICeeGen,nil,nil,false,0);
    DefineProp('IID_ICorModule',tkVariant,__GetIID_ICorModule,nil,nil,false,0);
    DefineProp('IID_IMetaDataTables',tkVariant,__GetIID_IMetaDataTables,nil,nil,false,0);
    DefineProp('IID_IMetaDataTables2',tkVariant,__GetIID_IMetaDataTables2,nil,nil,false,0);
    DefineProp('IID_INativeImageDependency',tkVariant,__GetIID_INativeImageDependency,nil,nil,false,0);
    DefineProp('IID_INativeImageEvaluate',tkVariant,__GetIID_INativeImageEvaluate,nil,nil,false,0);
    DefineProp('IID_INativeImageInstallInfo',tkVariant,__GetIID_INativeImageInstallInfo,nil,nil,false,0);
    AddConstant('COINITCOR_DEFAULT',COINITCOR_DEFAULT);
    AddConstant('COINITEE_DEFAULT',COINITEE_DEFAULT);
    AddConstant('COINITEE_DLL',COINITEE_DLL);
    AddConstant('COINITEE_MAIN',COINITEE_MAIN);
    AddConstant('COUNINITEE_DEFAULT',COUNINITEE_DEFAULT);
    AddConstant('COUNINITEE_DLL',COUNINITEE_DLL);
    AddConstant('ValidatorModuleTypeInvalid',ValidatorModuleTypeInvalid);
    AddConstant('ValidatorModuleTypeMin',ValidatorModuleTypeMin);
    AddConstant('ValidatorModuleTypePE',ValidatorModuleTypePE);
    AddConstant('ValidatorModuleTypeObj',ValidatorModuleTypeObj);
    AddConstant('ValidatorModuleTypeEnc',ValidatorModuleTypeEnc);
    AddConstant('ValidatorModuleTypeIncr',ValidatorModuleTypeIncr);
    AddConstant('ValidatorModuleTypeMax',ValidatorModuleTypeMax);
    AddConstant('sdNone',sdNone);
    AddConstant('sdReadOnly',sdReadOnly);
    AddConstant('sdReadWrite',sdReadWrite);
    AddConstant('sdExecute',sdExecute);
    AddConstant('srRelocAbsolute',srRelocAbsolute);
    AddConstant('srRelocHighLow',srRelocHighLow);
    AddConstant('srRelocHighAdj',srRelocHighAdj);
    AddConstant('srRelocMapToken',srRelocMapToken);
    AddConstant('srRelocRelative',srRelocRelative);
    AddConstant('srRelocFilePos',srRelocFilePos);
    AddConstant('srRelocCodeRelative',srRelocCodeRelative);
    AddConstant('srRelocIA64Imm64',srRelocIA64Imm64);
    AddConstant('srRelocDir64',srRelocDir64);
    AddConstant('srRelocIA64PcRel25',srRelocIA64PcRel25);
    AddConstant('srRelocIA64PcRel64',srRelocIA64PcRel64);
    AddConstant('srRelocAbsoluteTagged',srRelocAbsoluteTagged);
    AddConstant('srRelocSentinel',srRelocSentinel);
    AddConstant('srNoBaseReloc',srNoBaseReloc);
    AddConstant('srRelocPtr',srRelocPtr);
    AddConstant('srRelocAbsolutePtr',srRelocAbsolutePtr);
    AddConstant('srRelocHighLowPtr',srRelocHighLowPtr);
    AddConstant('srRelocRelativePtr',srRelocRelativePtr);
    AddConstant('srRelocIA64Imm64Ptr',srRelocIA64Imm64Ptr);
    AddConstant('srRelocDir64Ptr',srRelocDir64Ptr);
    AddConstant('CORMODULE_MATCH',CORMODULE_MATCH);
    AddConstant('CORMODULE_NEW',CORMODULE_NEW);
    AddConstant('nltNone',nltNone);
    AddConstant('nltAnsi',nltAnsi);
    AddConstant('nltUnicode',nltUnicode);
    AddConstant('nltAuto',nltAuto);
    AddConstant('nltOle',nltOle);
    AddConstant('nltMaxValue',nltMaxValue);
    AddConstant('nlfNone',nlfNone);
    AddConstant('nlfLastError',nlfLastError);
    AddConstant('nlfNoMangle',nlfNoMangle);
    AddConstant('nlfMaxValue',nlfMaxValue);
    AddConstant('INVALID_CONNECTION_ID',INVALID_CONNECTION_ID);
    AddConstant('INVALID_TASK_ID',INVALID_TASK_ID);
    AddConstant('MAX_CONNECTION_NAME',MAX_CONNECTION_NAME);
    AddConstant('MSCOREE_SHIM_W',MSCOREE_SHIM_W);
    AddConstant('MSCOREE_SHIM_A',MSCOREE_SHIM_A);
    AddConstant('SWITCHOUT_HANDLE_VALUE',SWITCHOUT_HANDLE_VALUE);
    AddConstant('IMAGE_REL_BASED_REL32',IMAGE_REL_BASED_REL32);
    AddConstant('IMAGE_REL_BASED_IA64_PCREL21',IMAGE_REL_BASED_IA64_PCREL21);
    AddConstant('IMAGE_REL_BASED_IA64_PCREL60',IMAGE_REL_BASED_IA64_PCREL60);
    AddConstant('iRidMax',iRidMax);
    AddConstant('iCodedToken',iCodedToken);
    AddConstant('iCodedTokenMax',iCodedTokenMax);
    AddConstant('iSHORT',iSHORT);
    AddConstant('iUSHORT',iUSHORT);
    AddConstant('iLONG',iLONG);
    AddConstant('iULONG',iULONG);
    AddConstant('iBYTE',iBYTE);
    AddConstant('iSTRING',iSTRING);
    AddConstant('iGUID',iGUID);
    AddConstant('iBLOB',iBLOB);
    AddConstant('COR_NATIVE_LINK_CUSTOM_VALUE',COR_NATIVE_LINK_CUSTOM_VALUE);
    AddConstant('COR_NATIVE_LINK_CUSTOM_VALUE_ANSI',COR_NATIVE_LINK_CUSTOM_VALUE_ANSI);
    AddConstant('COR_NATIVE_LINK_CUSTOM_VALUE_CC',COR_NATIVE_LINK_CUSTOM_VALUE_CC);
    AddConstant('COR_DUAL_CUSTOM_VALUE',COR_DUAL_CUSTOM_VALUE);
    AddConstant('COR_DUAL_CUSTOM_VALUE_ANSI',COR_DUAL_CUSTOM_VALUE_ANSI);
    AddConstant('COR_DISPATCH_CUSTOM_VALUE',COR_DISPATCH_CUSTOM_VALUE);
    AddConstant('COR_DISPATCH_CUSTOM_VALUE_ANSI',COR_DISPATCH_CUSTOM_VALUE_ANSI);
    AddConstant('COR_PERM_REQUEST_REQD_CUSTOM_VALUE',COR_PERM_REQUEST_REQD_CUSTOM_VALUE);
    AddConstant('COR_PERM_REQUEST_REQD_CUSTOM_VALUE_ANSI',COR_PERM_REQUEST_REQD_CUSTOM_VALUE_ANSI);
    AddConstant('COR_PERM_REQUEST_OPT_CUSTOM_VALUE',COR_PERM_REQUEST_OPT_CUSTOM_VALUE);
    AddConstant('COR_PERM_REQUEST_OPT_CUSTOM_VALUE_ANSI',COR_PERM_REQUEST_OPT_CUSTOM_VALUE_ANSI);
    AddConstant('COR_PERM_REQUEST_REFUSE_CUSTOM_VALUE',COR_PERM_REQUEST_REFUSE_CUSTOM_VALUE);
    AddConstant('COR_PERM_REQUEST_REFUSE_CUSTOM_VALUE_ANSI',COR_PERM_REQUEST_REFUSE_CUSTOM_VALUE_ANSI);
    AddConstant('COR_BASE_SECURITY_ATTRIBUTE_CLASS',COR_BASE_SECURITY_ATTRIBUTE_CLASS);
    AddConstant('COR_BASE_SECURITY_ATTRIBUTE_CLASS_ANSI',COR_BASE_SECURITY_ATTRIBUTE_CLASS_ANSI);
    AddConstant('COR_SUPPRESS_UNMANAGED_CODE_CHECK_ATTRIBUTE',COR_SUPPRESS_UNMANAGED_CODE_CHECK_ATTRIBUTE);
    AddConstant('COR_SUPPRESS_UNMANAGED_CODE_CHECK_ATTRIBUTE_ANSI',COR_SUPPRESS_UNMANAGED_CODE_CHECK_ATTRIBUTE_ANSI);
    AddConstant('COR_UNVER_CODE_ATTRIBUTE',COR_UNVER_CODE_ATTRIBUTE);
    AddConstant('COR_UNVER_CODE_ATTRIBUTE_ANSI',COR_UNVER_CODE_ATTRIBUTE_ANSI);
    AddConstant('COR_REQUIRES_SECOBJ_ATTRIBUTE',COR_REQUIRES_SECOBJ_ATTRIBUTE);
    AddConstant('COR_REQUIRES_SECOBJ_ATTRIBUTE_ANSI',COR_REQUIRES_SECOBJ_ATTRIBUTE_ANSI);
    AddConstant('COR_COMPILERSERVICE_DISCARDABLEATTRIBUTE',COR_COMPILERSERVICE_DISCARDABLEATTRIBUTE);
    AddConstant('COR_COMPILERSERVICE_DISCARDABLEATTRIBUTE_ASNI',COR_COMPILERSERVICE_DISCARDABLEATTRIBUTE_ASNI);
    AddConstant('COR_COMPILERSERVICE_DISCARDABLEATTRIBUTE_ANSI',COR_COMPILERSERVICE_DISCARDABLEATTRIBUTE_ANSI);
    AddConstant('regNoCopy',regNoCopy);
    AddConstant('regConfig',regConfig);
    AddConstant('regHasRefs',regHasRefs);
    AddConstant('SIGN_MASK_ONEBYTE',SIGN_MASK_ONEBYTE);
    AddConstant('SIGN_MASK_TWOBYTE',SIGN_MASK_TWOBYTE);
    AddConstant('SIGN_MASK_FOURBYTE',SIGN_MASK_FOURBYTE);
    AddConstant('mscoree',mscoree);
  end;
end;

class function TatCorLibrary.LibraryName: string;
begin
  result := 'Cor';
end;

initialization
  RegisterScripterLibrary(TatCorLibrary, True);

{$WARNINGS ON}

end.

