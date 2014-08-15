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
unit ap_CorHdr;

interface

uses
  Windows,
  CorHdr,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatCorHdrLibrary = class(TatScripterLibrary)
    procedure __IsTdNotPublic(AMachine: TatVirtualMachine);
    procedure __IsTdPublic(AMachine: TatVirtualMachine);
    procedure __IsTdNestedPublic(AMachine: TatVirtualMachine);
    procedure __IsTdNestedPrivate(AMachine: TatVirtualMachine);
    procedure __IsTdNestedFamily(AMachine: TatVirtualMachine);
    procedure __IsTdNestedAssembly(AMachine: TatVirtualMachine);
    procedure __IsTdNestedFamANDAssem(AMachine: TatVirtualMachine);
    procedure __IsTdNestedFamORAssem(AMachine: TatVirtualMachine);
    procedure __IsTdNested(AMachine: TatVirtualMachine);
    procedure __IsTdAutoLayout(AMachine: TatVirtualMachine);
    procedure __IsTdSequentialLayout(AMachine: TatVirtualMachine);
    procedure __IsTdExplicitLayout(AMachine: TatVirtualMachine);
    procedure __IsTdClass(AMachine: TatVirtualMachine);
    procedure __IsTdInterface(AMachine: TatVirtualMachine);
    procedure __IsTdAbstract(AMachine: TatVirtualMachine);
    procedure __IsTdSealed(AMachine: TatVirtualMachine);
    procedure __IsTdSpecialName(AMachine: TatVirtualMachine);
    procedure __IsTdImport(AMachine: TatVirtualMachine);
    procedure __IsTdSerializable(AMachine: TatVirtualMachine);
    procedure __IsTdAnsiClass(AMachine: TatVirtualMachine);
    procedure __IsTdUnicodeClass(AMachine: TatVirtualMachine);
    procedure __IsTdAutoClass(AMachine: TatVirtualMachine);
    procedure __IsTdCustomFormatClass(AMachine: TatVirtualMachine);
    procedure __IsTdBeforeFieldInit(AMachine: TatVirtualMachine);
    procedure __IsTdForwarder(AMachine: TatVirtualMachine);
    procedure __IsTdRTSpecialName(AMachine: TatVirtualMachine);
    procedure __IsTdHasSecurity(AMachine: TatVirtualMachine);
    procedure __IsMdPrivateScope(AMachine: TatVirtualMachine);
    procedure __IsMdPrivate(AMachine: TatVirtualMachine);
    procedure __IsMdFamANDAssem(AMachine: TatVirtualMachine);
    procedure __IsMdAssem(AMachine: TatVirtualMachine);
    procedure __IsMdFamily(AMachine: TatVirtualMachine);
    procedure __IsMdFamORAssem(AMachine: TatVirtualMachine);
    procedure __IsMdPublic(AMachine: TatVirtualMachine);
    procedure __IsMdStatic(AMachine: TatVirtualMachine);
    procedure __IsMdFinal(AMachine: TatVirtualMachine);
    procedure __IsMdVirtual(AMachine: TatVirtualMachine);
    procedure __IsMdHideBySig(AMachine: TatVirtualMachine);
    procedure __IsMdReuseSlot(AMachine: TatVirtualMachine);
    procedure __IsMdNewSlot(AMachine: TatVirtualMachine);
    procedure __IsMdCheckAccessOnOverride(AMachine: TatVirtualMachine);
    procedure __IsMdAbstract(AMachine: TatVirtualMachine);
    procedure __IsMdSpecialName(AMachine: TatVirtualMachine);
    procedure __IsMdPinvokeImpl(AMachine: TatVirtualMachine);
    procedure __IsMdUnmanagedExport(AMachine: TatVirtualMachine);
    procedure __IsMdRTSpecialName(AMachine: TatVirtualMachine);
    procedure __IsMdHasSecurity(AMachine: TatVirtualMachine);
    procedure __IsMdRequireSecObject(AMachine: TatVirtualMachine);
    procedure __IsFdPrivateScope(AMachine: TatVirtualMachine);
    procedure __IsFdPrivate(AMachine: TatVirtualMachine);
    procedure __IsFdFamANDAssem(AMachine: TatVirtualMachine);
    procedure __IsFdAssembly(AMachine: TatVirtualMachine);
    procedure __IsFdFamily(AMachine: TatVirtualMachine);
    procedure __IsFdFamORAssem(AMachine: TatVirtualMachine);
    procedure __IsFdPublic(AMachine: TatVirtualMachine);
    procedure __IsFdStatic(AMachine: TatVirtualMachine);
    procedure __IsFdInitOnly(AMachine: TatVirtualMachine);
    procedure __IsFdLiteral(AMachine: TatVirtualMachine);
    procedure __IsFdNotSerialized(AMachine: TatVirtualMachine);
    procedure __IsFdPinvokeImpl(AMachine: TatVirtualMachine);
    procedure __IsFdSpecialName(AMachine: TatVirtualMachine);
    procedure __IsFdHasFieldRVA(AMachine: TatVirtualMachine);
    procedure __IsFdRTSpecialName(AMachine: TatVirtualMachine);
    procedure __IsFdHasFieldMarshal(AMachine: TatVirtualMachine);
    procedure __IsFdHasDefault(AMachine: TatVirtualMachine);
    procedure __IsPdIn(AMachine: TatVirtualMachine);
    procedure __IsPdOut(AMachine: TatVirtualMachine);
    procedure __IsPdOptional(AMachine: TatVirtualMachine);
    procedure __IsPdHasDefault(AMachine: TatVirtualMachine);
    procedure __IsPdHasFieldMarshal(AMachine: TatVirtualMachine);
    procedure __IsPrSpecialName(AMachine: TatVirtualMachine);
    procedure __IsPrRTSpecialName(AMachine: TatVirtualMachine);
    procedure __IsPrHasDefault(AMachine: TatVirtualMachine);
    procedure __IsEvSpecialName(AMachine: TatVirtualMachine);
    procedure __IsEvRTSpecialName(AMachine: TatVirtualMachine);
    procedure __IsMsSetter(AMachine: TatVirtualMachine);
    procedure __IsMsGetter(AMachine: TatVirtualMachine);
    procedure __IsMsOther(AMachine: TatVirtualMachine);
    procedure __IsMsAddOn(AMachine: TatVirtualMachine);
    procedure __IsMsRemoveOn(AMachine: TatVirtualMachine);
    procedure __IsMsFire(AMachine: TatVirtualMachine);
    procedure __IsDclActionNil(AMachine: TatVirtualMachine);
    procedure __IsDclActionAnyStackModifier(AMachine: TatVirtualMachine);
    procedure __IsMiIL(AMachine: TatVirtualMachine);
    procedure __IsMiNative(AMachine: TatVirtualMachine);
    procedure __IsMiOPTIL(AMachine: TatVirtualMachine);
    procedure __IsMiRuntime(AMachine: TatVirtualMachine);
    procedure __IsMiUnmanaged(AMachine: TatVirtualMachine);
    procedure __IsMiManaged(AMachine: TatVirtualMachine);
    procedure __IsMiForwardRef(AMachine: TatVirtualMachine);
    procedure __IsMiPreserveSig(AMachine: TatVirtualMachine);
    procedure __IsMiInternalCall(AMachine: TatVirtualMachine);
    procedure __IsMiSynchronized(AMachine: TatVirtualMachine);
    procedure __IsMiNoInlining(AMachine: TatVirtualMachine);
    procedure __IsPmNoMangle(AMachine: TatVirtualMachine);
    procedure __IsPmCharSetNotSpec(AMachine: TatVirtualMachine);
    procedure __IsPmCharSetAnsi(AMachine: TatVirtualMachine);
    procedure __IsPmCharSetUnicode(AMachine: TatVirtualMachine);
    procedure __IsPmCharSetAuto(AMachine: TatVirtualMachine);
    procedure __IsPmSupportsLastError(AMachine: TatVirtualMachine);
    procedure __IsPmCallConvWinapi(AMachine: TatVirtualMachine);
    procedure __IsPmCallConvCdecl(AMachine: TatVirtualMachine);
    procedure __IsPmCallConvStdcall(AMachine: TatVirtualMachine);
    procedure __IsPmCallConvThiscall(AMachine: TatVirtualMachine);
    procedure __IsPmCallConvFastcall(AMachine: TatVirtualMachine);
    procedure __IsPmBestFitEnabled(AMachine: TatVirtualMachine);
    procedure __IsPmBestFitDisabled(AMachine: TatVirtualMachine);
    procedure __IsPmBestFitUseAssem(AMachine: TatVirtualMachine);
    procedure __IsPmThrowOnUnmappableCharEnabled(AMachine: TatVirtualMachine);
    procedure __IsPmThrowOnUnmappableCharDisabled(AMachine: TatVirtualMachine);
    procedure __IsPmThrowOnUnmappableCharUseAssem(AMachine: TatVirtualMachine);
    procedure __IsAfRetargetable(AMachine: TatVirtualMachine);
    procedure __IsAfPA_MSIL(AMachine: TatVirtualMachine);
    procedure __IsAfPA_x86(AMachine: TatVirtualMachine);
    procedure __IsAfPA_IA64(AMachine: TatVirtualMachine);
    procedure __IsAfPA_AMD64(AMachine: TatVirtualMachine);
    procedure __IsAfPA_Specified(AMachine: TatVirtualMachine);
    procedure __PAIndex(AMachine: TatVirtualMachine);
    procedure __PAFlag(AMachine: TatVirtualMachine);
    procedure __IsAfEnableJITcompileTracking(AMachine: TatVirtualMachine);
    procedure __IsAfDisableJITcompileOptimizer(AMachine: TatVirtualMachine);
    procedure __IsAfPublicKey(AMachine: TatVirtualMachine);
    procedure __IsAfPublicKeyToken(AMachine: TatVirtualMachine);
    procedure __IsMrPublic(AMachine: TatVirtualMachine);
    procedure __IsMrPrivate(AMachine: TatVirtualMachine);
    procedure __IsFfContainsMetaData(AMachine: TatVirtualMachine);
    procedure __IsFfContainsNoMetaData(AMachine: TatVirtualMachine);
    procedure __RidToToken(AMachine: TatVirtualMachine);
    procedure __TokenFromRid(AMachine: TatVirtualMachine);
    procedure __RidFromToken(AMachine: TatVirtualMachine);
    procedure __TypeFromToken(AMachine: TatVirtualMachine);
    procedure __IsNilToken(AMachine: TatVirtualMachine);
    procedure __IsOfRead(AMachine: TatVirtualMachine);
    procedure __IsOfReadWrite(AMachine: TatVirtualMachine);
    procedure __IsOfCopyMemory(AMachine: TatVirtualMachine);
    procedure __IsOfManifestMetadata(AMachine: TatVirtualMachine);
    procedure __IsOfReadOnly(AMachine: TatVirtualMachine);
    procedure __IsOfTakeOwnership(AMachine: TatVirtualMachine);
    procedure __IsOfReserved(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  COR_FIELD_OFFSETWrapper = class(TatRecordWrapper)
  private
    FridOfField: mdFieldDef;
    FulOffset: ULONG;
  public
    constructor Create(ARecord: COR_FIELD_OFFSET);
    function ObjToRec: COR_FIELD_OFFSET;
  published
    property ridOfField: mdFieldDef read FridOfField write FridOfField;
    property ulOffset: ULONG read FulOffset write FulOffset;
  end;
  
  IMAGE_COR_FIXUPENTRYWrapper = class(TatRecordWrapper)
  private
    FulRVA: ULONG;
    FCount: ULONG;
  public
    constructor Create(ARecord: IMAGE_COR_FIXUPENTRY);
    function ObjToRec: IMAGE_COR_FIXUPENTRY;
  published
    property ulRVA: ULONG read FulRVA write FulRVA;
    property Count: ULONG read FCount write FCount;
  end;
  
  COR_SECATTRWrapper = class(TatRecordWrapper)
  private
    FtkCtor: mdMemberRef;
    FcbCustomAttribute: ULONG;
  public
    constructor Create(ARecord: COR_SECATTR);
    function ObjToRec: COR_SECATTR;
  published
    property tkCtor: mdMemberRef read FtkCtor write FtkCtor;
    property cbCustomAttribute: ULONG read FcbCustomAttribute write FcbCustomAttribute;
  end;
  

implementation

constructor COR_FIELD_OFFSETWrapper.Create(ARecord: COR_FIELD_OFFSET);
begin
  inherited Create;
  FridOfField := ARecord.ridOfField;
  FulOffset := ARecord.ulOffset;
end;

function COR_FIELD_OFFSETWrapper.ObjToRec: COR_FIELD_OFFSET;
begin
  result.ridOfField := FridOfField;
  result.ulOffset := FulOffset;
end;

constructor IMAGE_COR_FIXUPENTRYWrapper.Create(ARecord: IMAGE_COR_FIXUPENTRY);
begin
  inherited Create;
  FulRVA := ARecord.ulRVA;
  FCount := ARecord.Count;
end;

function IMAGE_COR_FIXUPENTRYWrapper.ObjToRec: IMAGE_COR_FIXUPENTRY;
begin
  result.ulRVA := FulRVA;
  result.Count := FCount;
end;

constructor COR_SECATTRWrapper.Create(ARecord: COR_SECATTR);
begin
  inherited Create;
  FtkCtor := ARecord.tkCtor;
  FcbCustomAttribute := ARecord.cbCustomAttribute;
end;

function COR_SECATTRWrapper.ObjToRec: COR_SECATTR;
begin
  result.tkCtor := FtkCtor;
  result.cbCustomAttribute := FcbCustomAttribute;
end;



procedure TatCorHdrLibrary.__IsTdNotPublic(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsTdNotPublic(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsTdPublic(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsTdPublic(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsTdNestedPublic(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsTdNestedPublic(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsTdNestedPrivate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsTdNestedPrivate(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsTdNestedFamily(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsTdNestedFamily(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsTdNestedAssembly(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsTdNestedAssembly(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsTdNestedFamANDAssem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsTdNestedFamANDAssem(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsTdNestedFamORAssem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsTdNestedFamORAssem(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsTdNested(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsTdNested(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsTdAutoLayout(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsTdAutoLayout(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsTdSequentialLayout(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsTdSequentialLayout(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsTdExplicitLayout(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsTdExplicitLayout(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsTdClass(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsTdClass(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsTdInterface(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsTdInterface(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsTdAbstract(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsTdAbstract(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsTdSealed(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsTdSealed(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsTdSpecialName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsTdSpecialName(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsTdImport(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsTdImport(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsTdSerializable(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsTdSerializable(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsTdAnsiClass(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsTdAnsiClass(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsTdUnicodeClass(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsTdUnicodeClass(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsTdAutoClass(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsTdAutoClass(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsTdCustomFormatClass(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsTdCustomFormatClass(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsTdBeforeFieldInit(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsTdBeforeFieldInit(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsTdForwarder(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsTdForwarder(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsTdRTSpecialName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsTdRTSpecialName(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsTdHasSecurity(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsTdHasSecurity(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMdPrivateScope(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMdPrivateScope(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMdPrivate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMdPrivate(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMdFamANDAssem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMdFamANDAssem(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMdAssem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMdAssem(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMdFamily(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMdFamily(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMdFamORAssem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMdFamORAssem(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMdPublic(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMdPublic(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMdStatic(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMdStatic(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMdFinal(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMdFinal(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMdVirtual(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMdVirtual(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMdHideBySig(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMdHideBySig(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMdReuseSlot(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMdReuseSlot(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMdNewSlot(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMdNewSlot(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMdCheckAccessOnOverride(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMdCheckAccessOnOverride(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMdAbstract(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMdAbstract(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMdSpecialName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMdSpecialName(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMdPinvokeImpl(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMdPinvokeImpl(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMdUnmanagedExport(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMdUnmanagedExport(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMdRTSpecialName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMdRTSpecialName(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMdHasSecurity(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMdHasSecurity(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMdRequireSecObject(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMdRequireSecObject(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsFdPrivateScope(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsFdPrivateScope(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsFdPrivate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsFdPrivate(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsFdFamANDAssem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsFdFamANDAssem(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsFdAssembly(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsFdAssembly(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsFdFamily(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsFdFamily(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsFdFamORAssem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsFdFamORAssem(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsFdPublic(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsFdPublic(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsFdStatic(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsFdStatic(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsFdInitOnly(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsFdInitOnly(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsFdLiteral(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsFdLiteral(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsFdNotSerialized(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsFdNotSerialized(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsFdPinvokeImpl(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsFdPinvokeImpl(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsFdSpecialName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsFdSpecialName(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsFdHasFieldRVA(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsFdHasFieldRVA(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsFdRTSpecialName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsFdRTSpecialName(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsFdHasFieldMarshal(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsFdHasFieldMarshal(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsFdHasDefault(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsFdHasDefault(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsPdIn(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsPdIn(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsPdOut(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsPdOut(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsPdOptional(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsPdOptional(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsPdHasDefault(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsPdHasDefault(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsPdHasFieldMarshal(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsPdHasFieldMarshal(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsPrSpecialName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsPrSpecialName(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsPrRTSpecialName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsPrRTSpecialName(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsPrHasDefault(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsPrHasDefault(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsEvSpecialName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsEvSpecialName(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsEvRTSpecialName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsEvRTSpecialName(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMsSetter(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMsSetter(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMsGetter(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMsGetter(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMsOther(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMsOther(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMsAddOn(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMsAddOn(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMsRemoveOn(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMsRemoveOn(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMsFire(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMsFire(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsDclActionNil(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsDclActionNil(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsDclActionAnyStackModifier(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsDclActionAnyStackModifier(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMiIL(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMiIL(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMiNative(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMiNative(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMiOPTIL(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMiOPTIL(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMiRuntime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMiRuntime(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMiUnmanaged(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMiUnmanaged(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMiManaged(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMiManaged(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMiForwardRef(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMiForwardRef(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMiPreserveSig(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMiPreserveSig(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMiInternalCall(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMiInternalCall(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMiSynchronized(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMiSynchronized(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMiNoInlining(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMiNoInlining(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsPmNoMangle(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsPmNoMangle(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsPmCharSetNotSpec(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsPmCharSetNotSpec(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsPmCharSetAnsi(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsPmCharSetAnsi(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsPmCharSetUnicode(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsPmCharSetUnicode(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsPmCharSetAuto(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsPmCharSetAuto(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsPmSupportsLastError(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsPmSupportsLastError(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsPmCallConvWinapi(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsPmCallConvWinapi(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsPmCallConvCdecl(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsPmCallConvCdecl(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsPmCallConvStdcall(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsPmCallConvStdcall(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsPmCallConvThiscall(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsPmCallConvThiscall(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsPmCallConvFastcall(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsPmCallConvFastcall(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsPmBestFitEnabled(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsPmBestFitEnabled(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsPmBestFitDisabled(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsPmBestFitDisabled(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsPmBestFitUseAssem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsPmBestFitUseAssem(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsPmThrowOnUnmappableCharEnabled(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsPmThrowOnUnmappableCharEnabled(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsPmThrowOnUnmappableCharDisabled(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsPmThrowOnUnmappableCharDisabled(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsPmThrowOnUnmappableCharUseAssem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsPmThrowOnUnmappableCharUseAssem(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsAfRetargetable(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsAfRetargetable(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsAfPA_MSIL(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsAfPA_MSIL(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsAfPA_x86(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsAfPA_x86(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsAfPA_IA64(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsAfPA_IA64(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsAfPA_AMD64(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsAfPA_AMD64(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsAfPA_Specified(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsAfPA_Specified(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__PAIndex(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(CorHdr.PAIndex(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__PAFlag(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(CorHdr.PAFlag(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsAfEnableJITcompileTracking(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsAfEnableJITcompileTracking(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsAfDisableJITcompileOptimizer(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsAfDisableJITcompileOptimizer(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsAfPublicKey(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsAfPublicKey(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsAfPublicKeyToken(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsAfPublicKeyToken(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMrPublic(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMrPublic(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsMrPrivate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsMrPrivate(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsFfContainsMetaData(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsFfContainsMetaData(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsFfContainsNoMetaData(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsFfContainsNoMetaData(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__RidToToken(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(CorHdr.RidToToken(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__TokenFromRid(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(CorHdr.TokenFromRid(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__RidFromToken(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(CorHdr.RidFromToken(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__TypeFromToken(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(CorHdr.TypeFromToken(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsNilToken(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsNilToken(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsOfRead(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsOfRead(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsOfReadWrite(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsOfReadWrite(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsOfCopyMemory(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsOfCopyMemory(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsOfManifestMetadata(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsOfManifestMetadata(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsOfReadOnly(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsOfReadOnly(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsOfTakeOwnership(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsOfTakeOwnership(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.__IsOfReserved(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := CorHdr.IsOfReserved(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCorHdrLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('IsTdNotPublic',1,tkVariant,nil,__IsTdNotPublic,false,0);
    DefineMethod('IsTdPublic',1,tkVariant,nil,__IsTdPublic,false,0);
    DefineMethod('IsTdNestedPublic',1,tkVariant,nil,__IsTdNestedPublic,false,0);
    DefineMethod('IsTdNestedPrivate',1,tkVariant,nil,__IsTdNestedPrivate,false,0);
    DefineMethod('IsTdNestedFamily',1,tkVariant,nil,__IsTdNestedFamily,false,0);
    DefineMethod('IsTdNestedAssembly',1,tkVariant,nil,__IsTdNestedAssembly,false,0);
    DefineMethod('IsTdNestedFamANDAssem',1,tkVariant,nil,__IsTdNestedFamANDAssem,false,0);
    DefineMethod('IsTdNestedFamORAssem',1,tkVariant,nil,__IsTdNestedFamORAssem,false,0);
    DefineMethod('IsTdNested',1,tkVariant,nil,__IsTdNested,false,0);
    DefineMethod('IsTdAutoLayout',1,tkVariant,nil,__IsTdAutoLayout,false,0);
    DefineMethod('IsTdSequentialLayout',1,tkVariant,nil,__IsTdSequentialLayout,false,0);
    DefineMethod('IsTdExplicitLayout',1,tkVariant,nil,__IsTdExplicitLayout,false,0);
    DefineMethod('IsTdClass',1,tkVariant,nil,__IsTdClass,false,0);
    DefineMethod('IsTdInterface',1,tkVariant,nil,__IsTdInterface,false,0);
    DefineMethod('IsTdAbstract',1,tkVariant,nil,__IsTdAbstract,false,0);
    DefineMethod('IsTdSealed',1,tkVariant,nil,__IsTdSealed,false,0);
    DefineMethod('IsTdSpecialName',1,tkVariant,nil,__IsTdSpecialName,false,0);
    DefineMethod('IsTdImport',1,tkVariant,nil,__IsTdImport,false,0);
    DefineMethod('IsTdSerializable',1,tkVariant,nil,__IsTdSerializable,false,0);
    DefineMethod('IsTdAnsiClass',1,tkVariant,nil,__IsTdAnsiClass,false,0);
    DefineMethod('IsTdUnicodeClass',1,tkVariant,nil,__IsTdUnicodeClass,false,0);
    DefineMethod('IsTdAutoClass',1,tkVariant,nil,__IsTdAutoClass,false,0);
    DefineMethod('IsTdCustomFormatClass',1,tkVariant,nil,__IsTdCustomFormatClass,false,0);
    DefineMethod('IsTdBeforeFieldInit',1,tkVariant,nil,__IsTdBeforeFieldInit,false,0);
    DefineMethod('IsTdForwarder',1,tkVariant,nil,__IsTdForwarder,false,0);
    DefineMethod('IsTdRTSpecialName',1,tkVariant,nil,__IsTdRTSpecialName,false,0);
    DefineMethod('IsTdHasSecurity',1,tkVariant,nil,__IsTdHasSecurity,false,0);
    DefineMethod('IsMdPrivateScope',1,tkVariant,nil,__IsMdPrivateScope,false,0);
    DefineMethod('IsMdPrivate',1,tkVariant,nil,__IsMdPrivate,false,0);
    DefineMethod('IsMdFamANDAssem',1,tkVariant,nil,__IsMdFamANDAssem,false,0);
    DefineMethod('IsMdAssem',1,tkVariant,nil,__IsMdAssem,false,0);
    DefineMethod('IsMdFamily',1,tkVariant,nil,__IsMdFamily,false,0);
    DefineMethod('IsMdFamORAssem',1,tkVariant,nil,__IsMdFamORAssem,false,0);
    DefineMethod('IsMdPublic',1,tkVariant,nil,__IsMdPublic,false,0);
    DefineMethod('IsMdStatic',1,tkVariant,nil,__IsMdStatic,false,0);
    DefineMethod('IsMdFinal',1,tkVariant,nil,__IsMdFinal,false,0);
    DefineMethod('IsMdVirtual',1,tkVariant,nil,__IsMdVirtual,false,0);
    DefineMethod('IsMdHideBySig',1,tkVariant,nil,__IsMdHideBySig,false,0);
    DefineMethod('IsMdReuseSlot',1,tkVariant,nil,__IsMdReuseSlot,false,0);
    DefineMethod('IsMdNewSlot',1,tkVariant,nil,__IsMdNewSlot,false,0);
    DefineMethod('IsMdCheckAccessOnOverride',1,tkVariant,nil,__IsMdCheckAccessOnOverride,false,0);
    DefineMethod('IsMdAbstract',1,tkVariant,nil,__IsMdAbstract,false,0);
    DefineMethod('IsMdSpecialName',1,tkVariant,nil,__IsMdSpecialName,false,0);
    DefineMethod('IsMdPinvokeImpl',1,tkVariant,nil,__IsMdPinvokeImpl,false,0);
    DefineMethod('IsMdUnmanagedExport',1,tkVariant,nil,__IsMdUnmanagedExport,false,0);
    DefineMethod('IsMdRTSpecialName',1,tkVariant,nil,__IsMdRTSpecialName,false,0);
    DefineMethod('IsMdHasSecurity',1,tkVariant,nil,__IsMdHasSecurity,false,0);
    DefineMethod('IsMdRequireSecObject',1,tkVariant,nil,__IsMdRequireSecObject,false,0);
    DefineMethod('IsFdPrivateScope',1,tkVariant,nil,__IsFdPrivateScope,false,0);
    DefineMethod('IsFdPrivate',1,tkVariant,nil,__IsFdPrivate,false,0);
    DefineMethod('IsFdFamANDAssem',1,tkVariant,nil,__IsFdFamANDAssem,false,0);
    DefineMethod('IsFdAssembly',1,tkVariant,nil,__IsFdAssembly,false,0);
    DefineMethod('IsFdFamily',1,tkVariant,nil,__IsFdFamily,false,0);
    DefineMethod('IsFdFamORAssem',1,tkVariant,nil,__IsFdFamORAssem,false,0);
    DefineMethod('IsFdPublic',1,tkVariant,nil,__IsFdPublic,false,0);
    DefineMethod('IsFdStatic',1,tkVariant,nil,__IsFdStatic,false,0);
    DefineMethod('IsFdInitOnly',1,tkVariant,nil,__IsFdInitOnly,false,0);
    DefineMethod('IsFdLiteral',1,tkVariant,nil,__IsFdLiteral,false,0);
    DefineMethod('IsFdNotSerialized',1,tkVariant,nil,__IsFdNotSerialized,false,0);
    DefineMethod('IsFdPinvokeImpl',1,tkVariant,nil,__IsFdPinvokeImpl,false,0);
    DefineMethod('IsFdSpecialName',1,tkVariant,nil,__IsFdSpecialName,false,0);
    DefineMethod('IsFdHasFieldRVA',1,tkVariant,nil,__IsFdHasFieldRVA,false,0);
    DefineMethod('IsFdRTSpecialName',1,tkVariant,nil,__IsFdRTSpecialName,false,0);
    DefineMethod('IsFdHasFieldMarshal',1,tkVariant,nil,__IsFdHasFieldMarshal,false,0);
    DefineMethod('IsFdHasDefault',1,tkVariant,nil,__IsFdHasDefault,false,0);
    DefineMethod('IsPdIn',1,tkVariant,nil,__IsPdIn,false,0);
    DefineMethod('IsPdOut',1,tkVariant,nil,__IsPdOut,false,0);
    DefineMethod('IsPdOptional',1,tkVariant,nil,__IsPdOptional,false,0);
    DefineMethod('IsPdHasDefault',1,tkVariant,nil,__IsPdHasDefault,false,0);
    DefineMethod('IsPdHasFieldMarshal',1,tkVariant,nil,__IsPdHasFieldMarshal,false,0);
    DefineMethod('IsPrSpecialName',1,tkVariant,nil,__IsPrSpecialName,false,0);
    DefineMethod('IsPrRTSpecialName',1,tkVariant,nil,__IsPrRTSpecialName,false,0);
    DefineMethod('IsPrHasDefault',1,tkVariant,nil,__IsPrHasDefault,false,0);
    DefineMethod('IsEvSpecialName',1,tkVariant,nil,__IsEvSpecialName,false,0);
    DefineMethod('IsEvRTSpecialName',1,tkVariant,nil,__IsEvRTSpecialName,false,0);
    DefineMethod('IsMsSetter',1,tkVariant,nil,__IsMsSetter,false,0);
    DefineMethod('IsMsGetter',1,tkVariant,nil,__IsMsGetter,false,0);
    DefineMethod('IsMsOther',1,tkVariant,nil,__IsMsOther,false,0);
    DefineMethod('IsMsAddOn',1,tkVariant,nil,__IsMsAddOn,false,0);
    DefineMethod('IsMsRemoveOn',1,tkVariant,nil,__IsMsRemoveOn,false,0);
    DefineMethod('IsMsFire',1,tkVariant,nil,__IsMsFire,false,0);
    DefineMethod('IsDclActionNil',1,tkVariant,nil,__IsDclActionNil,false,0);
    DefineMethod('IsDclActionAnyStackModifier',1,tkVariant,nil,__IsDclActionAnyStackModifier,false,0);
    DefineMethod('IsMiIL',1,tkVariant,nil,__IsMiIL,false,0);
    DefineMethod('IsMiNative',1,tkVariant,nil,__IsMiNative,false,0);
    DefineMethod('IsMiOPTIL',1,tkVariant,nil,__IsMiOPTIL,false,0);
    DefineMethod('IsMiRuntime',1,tkVariant,nil,__IsMiRuntime,false,0);
    DefineMethod('IsMiUnmanaged',1,tkVariant,nil,__IsMiUnmanaged,false,0);
    DefineMethod('IsMiManaged',1,tkVariant,nil,__IsMiManaged,false,0);
    DefineMethod('IsMiForwardRef',1,tkVariant,nil,__IsMiForwardRef,false,0);
    DefineMethod('IsMiPreserveSig',1,tkVariant,nil,__IsMiPreserveSig,false,0);
    DefineMethod('IsMiInternalCall',1,tkVariant,nil,__IsMiInternalCall,false,0);
    DefineMethod('IsMiSynchronized',1,tkVariant,nil,__IsMiSynchronized,false,0);
    DefineMethod('IsMiNoInlining',1,tkVariant,nil,__IsMiNoInlining,false,0);
    DefineMethod('IsPmNoMangle',1,tkVariant,nil,__IsPmNoMangle,false,0);
    DefineMethod('IsPmCharSetNotSpec',1,tkVariant,nil,__IsPmCharSetNotSpec,false,0);
    DefineMethod('IsPmCharSetAnsi',1,tkVariant,nil,__IsPmCharSetAnsi,false,0);
    DefineMethod('IsPmCharSetUnicode',1,tkVariant,nil,__IsPmCharSetUnicode,false,0);
    DefineMethod('IsPmCharSetAuto',1,tkVariant,nil,__IsPmCharSetAuto,false,0);
    DefineMethod('IsPmSupportsLastError',1,tkVariant,nil,__IsPmSupportsLastError,false,0);
    DefineMethod('IsPmCallConvWinapi',1,tkVariant,nil,__IsPmCallConvWinapi,false,0);
    DefineMethod('IsPmCallConvCdecl',1,tkVariant,nil,__IsPmCallConvCdecl,false,0);
    DefineMethod('IsPmCallConvStdcall',1,tkVariant,nil,__IsPmCallConvStdcall,false,0);
    DefineMethod('IsPmCallConvThiscall',1,tkVariant,nil,__IsPmCallConvThiscall,false,0);
    DefineMethod('IsPmCallConvFastcall',1,tkVariant,nil,__IsPmCallConvFastcall,false,0);
    DefineMethod('IsPmBestFitEnabled',1,tkVariant,nil,__IsPmBestFitEnabled,false,0);
    DefineMethod('IsPmBestFitDisabled',1,tkVariant,nil,__IsPmBestFitDisabled,false,0);
    DefineMethod('IsPmBestFitUseAssem',1,tkVariant,nil,__IsPmBestFitUseAssem,false,0);
    DefineMethod('IsPmThrowOnUnmappableCharEnabled',1,tkVariant,nil,__IsPmThrowOnUnmappableCharEnabled,false,0);
    DefineMethod('IsPmThrowOnUnmappableCharDisabled',1,tkVariant,nil,__IsPmThrowOnUnmappableCharDisabled,false,0);
    DefineMethod('IsPmThrowOnUnmappableCharUseAssem',1,tkVariant,nil,__IsPmThrowOnUnmappableCharUseAssem,false,0);
    DefineMethod('IsAfRetargetable',1,tkVariant,nil,__IsAfRetargetable,false,0);
    DefineMethod('IsAfPA_MSIL',1,tkVariant,nil,__IsAfPA_MSIL,false,0);
    DefineMethod('IsAfPA_x86',1,tkVariant,nil,__IsAfPA_x86,false,0);
    DefineMethod('IsAfPA_IA64',1,tkVariant,nil,__IsAfPA_IA64,false,0);
    DefineMethod('IsAfPA_AMD64',1,tkVariant,nil,__IsAfPA_AMD64,false,0);
    DefineMethod('IsAfPA_Specified',1,tkVariant,nil,__IsAfPA_Specified,false,0);
    DefineMethod('PAIndex',1,tkInteger,nil,__PAIndex,false,0);
    DefineMethod('PAFlag',1,tkInteger,nil,__PAFlag,false,0);
    DefineMethod('IsAfEnableJITcompileTracking',1,tkVariant,nil,__IsAfEnableJITcompileTracking,false,0);
    DefineMethod('IsAfDisableJITcompileOptimizer',1,tkVariant,nil,__IsAfDisableJITcompileOptimizer,false,0);
    DefineMethod('IsAfPublicKey',1,tkVariant,nil,__IsAfPublicKey,false,0);
    DefineMethod('IsAfPublicKeyToken',1,tkVariant,nil,__IsAfPublicKeyToken,false,0);
    DefineMethod('IsMrPublic',1,tkVariant,nil,__IsMrPublic,false,0);
    DefineMethod('IsMrPrivate',1,tkVariant,nil,__IsMrPrivate,false,0);
    DefineMethod('IsFfContainsMetaData',1,tkVariant,nil,__IsFfContainsMetaData,false,0);
    DefineMethod('IsFfContainsNoMetaData',1,tkVariant,nil,__IsFfContainsNoMetaData,false,0);
    DefineMethod('RidToToken',2,tkInteger,nil,__RidToToken,false,0);
    DefineMethod('TokenFromRid',2,tkInteger,nil,__TokenFromRid,false,0);
    DefineMethod('RidFromToken',1,tkInteger,nil,__RidFromToken,false,0);
    DefineMethod('TypeFromToken',1,tkInteger,nil,__TypeFromToken,false,0);
    DefineMethod('IsNilToken',1,tkVariant,nil,__IsNilToken,false,0);
    DefineMethod('IsOfRead',1,tkVariant,nil,__IsOfRead,false,0);
    DefineMethod('IsOfReadWrite',1,tkVariant,nil,__IsOfReadWrite,false,0);
    DefineMethod('IsOfCopyMemory',1,tkVariant,nil,__IsOfCopyMemory,false,0);
    DefineMethod('IsOfManifestMetadata',1,tkVariant,nil,__IsOfManifestMetadata,false,0);
    DefineMethod('IsOfReadOnly',1,tkVariant,nil,__IsOfReadOnly,false,0);
    DefineMethod('IsOfTakeOwnership',1,tkVariant,nil,__IsOfTakeOwnership,false,0);
    DefineMethod('IsOfReserved',1,tkVariant,nil,__IsOfReserved,false,0);
    AddConstant('cssAccurate',cssAccurate);
    AddConstant('cssQuick',cssQuick);
    AddConstant('cssDiscardTransientCAs',cssDiscardTransientCAs);
    AddConstant('FRAMEWORK_REGISTRY_KEY',FRAMEWORK_REGISTRY_KEY);
    AddConstant('FRAMEWORK_REGISTRY_KEY_W',FRAMEWORK_REGISTRY_KEY_W);
    AddConstant('COR_CTOR_METHOD_NAME',COR_CTOR_METHOD_NAME);
    AddConstant('COR_CTOR_METHOD_NAME_W',COR_CTOR_METHOD_NAME_W);
    AddConstant('COR_CCTOR_METHOD_NAME',COR_CCTOR_METHOD_NAME);
    AddConstant('COR_CCTOR_METHOD_NAME_W',COR_CCTOR_METHOD_NAME_W);
    AddConstant('COR_ENUM_FIELD_NAME',COR_ENUM_FIELD_NAME);
    AddConstant('COR_ENUM_FIELD_NAME_W',COR_ENUM_FIELD_NAME_W);
    AddConstant('COR_DELETED_NAME_A',COR_DELETED_NAME_A);
    AddConstant('COR_DELETED_NAME_W',COR_DELETED_NAME_W);
    AddConstant('COR_VTABLEGAP_NAME_A',COR_VTABLEGAP_NAME_A);
    AddConstant('COR_VTABLEGAP_NAME_W',COR_VTABLEGAP_NAME_W);
    AddConstant('tdVisibilityMask',tdVisibilityMask);
    AddConstant('tdNotPublic',tdNotPublic);
    AddConstant('tdPublic',tdPublic);
    AddConstant('tdNestedPublic',tdNestedPublic);
    AddConstant('tdNestedPrivate',tdNestedPrivate);
    AddConstant('tdNestedFamily',tdNestedFamily);
    AddConstant('tdNestedAssembly',tdNestedAssembly);
    AddConstant('tdNestedFamANDAssem',tdNestedFamANDAssem);
    AddConstant('tdNestedFamORAssem',tdNestedFamORAssem);
    AddConstant('tdLayoutMask',tdLayoutMask);
    AddConstant('tdAutoLayout',tdAutoLayout);
    AddConstant('tdSequentialLayout',tdSequentialLayout);
    AddConstant('tdExplicitLayout',tdExplicitLayout);
    AddConstant('tdClassSemanticsMask',tdClassSemanticsMask);
    AddConstant('tdClass',tdClass);
    AddConstant('tdInterface',tdInterface);
    AddConstant('tdAbstract',tdAbstract);
    AddConstant('tdSealed',tdSealed);
    AddConstant('tdSpecialName',tdSpecialName);
    AddConstant('tdImport',tdImport);
    AddConstant('tdSerializable',tdSerializable);
    AddConstant('tdStringFormatMask',tdStringFormatMask);
    AddConstant('tdAnsiClass',tdAnsiClass);
    AddConstant('tdUnicodeClass',tdUnicodeClass);
    AddConstant('tdAutoClass',tdAutoClass);
    AddConstant('tdCustomFormatClass',tdCustomFormatClass);
    AddConstant('tdCustomFormatMask',tdCustomFormatMask);
    AddConstant('tdBeforeFieldInit',tdBeforeFieldInit);
    AddConstant('tdForwarder',tdForwarder);
    AddConstant('tdReservedMask',tdReservedMask);
    AddConstant('tdRTSpecialName',tdRTSpecialName);
    AddConstant('tdHasSecurity',tdHasSecurity);
    AddConstant('mdMemberAccessMask',mdMemberAccessMask);
    AddConstant('mdPrivateScope',mdPrivateScope);
    AddConstant('mdPrivate',mdPrivate);
    AddConstant('mdFamANDAssem',mdFamANDAssem);
    AddConstant('mdAssem',mdAssem);
    AddConstant('mdFamily',mdFamily);
    AddConstant('mdFamORAssem',mdFamORAssem);
    AddConstant('mdPublic',mdPublic);
    AddConstant('mdStatic',mdStatic);
    AddConstant('mdFinal',mdFinal);
    AddConstant('mdVirtual',mdVirtual);
    AddConstant('mdHideBySig',mdHideBySig);
    AddConstant('mdVtableLayoutMask',mdVtableLayoutMask);
    AddConstant('mdReuseSlot',mdReuseSlot);
    AddConstant('mdNewSlot',mdNewSlot);
    AddConstant('mdCheckAccessOnOverride',mdCheckAccessOnOverride);
    AddConstant('mdAbstract',mdAbstract);
    AddConstant('mdSpecialName',mdSpecialName);
    AddConstant('mdPinvokeImpl',mdPinvokeImpl);
    AddConstant('mdUnmanagedExport',mdUnmanagedExport);
    AddConstant('mdReservedMask',mdReservedMask);
    AddConstant('mdRTSpecialName',mdRTSpecialName);
    AddConstant('mdHasSecurity',mdHasSecurity);
    AddConstant('mdRequireSecObject',mdRequireSecObject);
    AddConstant('fdFieldAccessMask',fdFieldAccessMask);
    AddConstant('fdPrivateScope',fdPrivateScope);
    AddConstant('fdPrivate',fdPrivate);
    AddConstant('fdFamANDAssem',fdFamANDAssem);
    AddConstant('fdAssembly',fdAssembly);
    AddConstant('fdFamily',fdFamily);
    AddConstant('fdFamORAssem',fdFamORAssem);
    AddConstant('fdPublic',fdPublic);
    AddConstant('fdStatic',fdStatic);
    AddConstant('fdInitOnly',fdInitOnly);
    AddConstant('fdLiteral',fdLiteral);
    AddConstant('fdNotSerialized',fdNotSerialized);
    AddConstant('fdSpecialName',fdSpecialName);
    AddConstant('fdPinvokeImpl',fdPinvokeImpl);
    AddConstant('fdReservedMask',fdReservedMask);
    AddConstant('fdRTSpecialName',fdRTSpecialName);
    AddConstant('fdHasFieldMarshal',fdHasFieldMarshal);
    AddConstant('fdHasDefault',fdHasDefault);
    AddConstant('fdHasFieldRVA',fdHasFieldRVA);
    AddConstant('pdIn',pdIn);
    AddConstant('pdOut',pdOut);
    AddConstant('pdOptional',pdOptional);
    AddConstant('pdReservedMask',pdReservedMask);
    AddConstant('pdHasDefault',pdHasDefault);
    AddConstant('pdHasFieldMarshal',pdHasFieldMarshal);
    AddConstant('pdUnused',pdUnused);
    AddConstant('prSpecialName',prSpecialName);
    AddConstant('prReservedMask',prReservedMask);
    AddConstant('prRTSpecialName',prRTSpecialName);
    AddConstant('prHasDefault',prHasDefault);
    AddConstant('prUnused',prUnused);
    AddConstant('evSpecialName',evSpecialName);
    AddConstant('evReservedMask',evReservedMask);
    AddConstant('evRTSpecialName',evRTSpecialName);
    AddConstant('msSetter',msSetter);
    AddConstant('msGetter',msGetter);
    AddConstant('msOther',msOther);
    AddConstant('msAddOn',msAddOn);
    AddConstant('msRemoveOn',msRemoveOn);
    AddConstant('msFire',msFire);
    AddConstant('dclActionMask',dclActionMask);
    AddConstant('dclActionNil',dclActionNil);
    AddConstant('dclRequest',dclRequest);
    AddConstant('dclDemand',dclDemand);
    AddConstant('dclAssert',dclAssert);
    AddConstant('dclDeny',dclDeny);
    AddConstant('dclPermitOnly',dclPermitOnly);
    AddConstant('dclLinktimeCheck',dclLinktimeCheck);
    AddConstant('dclInheritanceCheck',dclInheritanceCheck);
    AddConstant('dclRequestMinimum',dclRequestMinimum);
    AddConstant('dclRequestOptional',dclRequestOptional);
    AddConstant('dclRequestRefuse',dclRequestRefuse);
    AddConstant('dclPrejitGrant',dclPrejitGrant);
    AddConstant('dclPrejitDenied',dclPrejitDenied);
    AddConstant('dclNonCasDemand',dclNonCasDemand);
    AddConstant('dclNonCasLinkDemand',dclNonCasLinkDemand);
    AddConstant('dclNonCasInheritance',dclNonCasInheritance);
    AddConstant('dclMaximumValue',dclMaximumValue);
    AddConstant('miCodeTypeMask',miCodeTypeMask);
    AddConstant('miIL',miIL);
    AddConstant('miNative',miNative);
    AddConstant('miOPTIL',miOPTIL);
    AddConstant('miRuntime',miRuntime);
    AddConstant('miManagedMask',miManagedMask);
    AddConstant('miUnmanaged',miUnmanaged);
    AddConstant('miManaged',miManaged);
    AddConstant('miForwardRef',miForwardRef);
    AddConstant('miPreserveSig',miPreserveSig);
    AddConstant('miInternalCall',miInternalCall);
    AddConstant('miSynchronized',miSynchronized);
    AddConstant('miNoInlining',miNoInlining);
    AddConstant('miMaxMethodImplVal',miMaxMethodImplVal);
    AddConstant('pmNoMangle',pmNoMangle);
    AddConstant('pmCharSetMask',pmCharSetMask);
    AddConstant('pmCharSetNotSpec',pmCharSetNotSpec);
    AddConstant('pmCharSetAnsi',pmCharSetAnsi);
    AddConstant('pmCharSetUnicode',pmCharSetUnicode);
    AddConstant('pmCharSetAuto',pmCharSetAuto);
    AddConstant('pmBestFitUseAssem',pmBestFitUseAssem);
    AddConstant('pmBestFitEnabled',pmBestFitEnabled);
    AddConstant('pmBestFitDisabled',pmBestFitDisabled);
    AddConstant('pmBestFitMask',pmBestFitMask);
    AddConstant('pmThrowOnUnmappableCharUseAssem',pmThrowOnUnmappableCharUseAssem);
    AddConstant('pmThrowOnUnmappableCharEnabled',pmThrowOnUnmappableCharEnabled);
    AddConstant('pmThrowOnUnmappableCharDisabled',pmThrowOnUnmappableCharDisabled);
    AddConstant('pmThrowOnUnmappableCharMask',pmThrowOnUnmappableCharMask);
    AddConstant('pmSupportsLastError',pmSupportsLastError);
    AddConstant('pmCallConvMask',pmCallConvMask);
    AddConstant('pmCallConvWinapi',pmCallConvWinapi);
    AddConstant('pmCallConvCdecl',pmCallConvCdecl);
    AddConstant('pmCallConvStdcall',pmCallConvStdcall);
    AddConstant('pmCallConvThiscall',pmCallConvThiscall);
    AddConstant('pmCallConvFastcall',pmCallConvFastcall);
    AddConstant('pmMaxValue',pmMaxValue);
    AddConstant('afPublicKey',afPublicKey);
    AddConstant('afPA_None',afPA_None);
    AddConstant('afPA_MSIL',afPA_MSIL);
    AddConstant('afPA_x86',afPA_x86);
    AddConstant('afPA_IA64',afPA_IA64);
    AddConstant('afPA_AMD64',afPA_AMD64);
    AddConstant('afPA_Specified',afPA_Specified);
    AddConstant('afPA_Mask',afPA_Mask);
    AddConstant('afPA_FullMask',afPA_FullMask);
    AddConstant('afPA_Shift',afPA_Shift);
    AddConstant('afEnableJITcompileTracking',afEnableJITcompileTracking);
    AddConstant('afDisableJITcompileOptimizer',afDisableJITcompileOptimizer);
    AddConstant('afRetargetable',afRetargetable);
    AddConstant('mrVisibilityMask',mrVisibilityMask);
    AddConstant('mrPublic',mrPublic);
    AddConstant('mrPrivate',mrPrivate);
    AddConstant('ffContainsMetaData',ffContainsMetaData);
    AddConstant('ffContainsNoMetaData',ffContainsNoMetaData);
    AddConstant('peNot',peNot);
    AddConstant('peILonly',peILonly);
    AddConstant('pe32BitRequired',pe32BitRequired);
    AddConstant('pe32Plus',pe32Plus);
    AddConstant('pe32Unmanaged',pe32Unmanaged);
    AddConstant('gpVarianceMask',gpVarianceMask);
    AddConstant('gpNonVariant',gpNonVariant);
    AddConstant('gpCovariant',gpCovariant);
    AddConstant('gpContravariant',gpContravariant);
    AddConstant('gpSpecialConstraintMask',gpSpecialConstraintMask);
    AddConstant('gpNoSpecialConstraint',gpNoSpecialConstraint);
    AddConstant('gpReferenceTypeConstraint',gpReferenceTypeConstraint);
    AddConstant('gpNotNullableValueTypeConstraint',gpNotNullableValueTypeConstraint);
    AddConstant('gpDefaultConstructorConstraint',gpDefaultConstructorConstraint);
    AddConstant('ELEMENT_TYPE_END',ELEMENT_TYPE_END);
    AddConstant('ELEMENT_TYPE_VOID',ELEMENT_TYPE_VOID);
    AddConstant('ELEMENT_TYPE_BOOLEAN',ELEMENT_TYPE_BOOLEAN);
    AddConstant('ELEMENT_TYPE_CHAR',ELEMENT_TYPE_CHAR);
    AddConstant('ELEMENT_TYPE_I1',ELEMENT_TYPE_I1);
    AddConstant('ELEMENT_TYPE_U1',ELEMENT_TYPE_U1);
    AddConstant('ELEMENT_TYPE_I2',ELEMENT_TYPE_I2);
    AddConstant('ELEMENT_TYPE_U2',ELEMENT_TYPE_U2);
    AddConstant('ELEMENT_TYPE_I4',ELEMENT_TYPE_I4);
    AddConstant('ELEMENT_TYPE_U4',ELEMENT_TYPE_U4);
    AddConstant('ELEMENT_TYPE_I8',ELEMENT_TYPE_I8);
    AddConstant('ELEMENT_TYPE_U8',ELEMENT_TYPE_U8);
    AddConstant('ELEMENT_TYPE_R4',ELEMENT_TYPE_R4);
    AddConstant('ELEMENT_TYPE_R8',ELEMENT_TYPE_R8);
    AddConstant('ELEMENT_TYPE_STRING',ELEMENT_TYPE_STRING);
    AddConstant('ELEMENT_TYPE_PTR',ELEMENT_TYPE_PTR);
    AddConstant('ELEMENT_TYPE_BYREF',ELEMENT_TYPE_BYREF);
    AddConstant('ELEMENT_TYPE_VALUETYPE',ELEMENT_TYPE_VALUETYPE);
    AddConstant('ELEMENT_TYPE_CLASS',ELEMENT_TYPE_CLASS);
    AddConstant('ELEMENT_TYPE_VAR',ELEMENT_TYPE_VAR);
    AddConstant('ELEMENT_TYPE_ARRAY',ELEMENT_TYPE_ARRAY);
    AddConstant('ELEMENT_TYPE_GENERICINST',ELEMENT_TYPE_GENERICINST);
    AddConstant('ELEMENT_TYPE_TYPEDBYREF',ELEMENT_TYPE_TYPEDBYREF);
    AddConstant('ELEMENT_TYPE_I',ELEMENT_TYPE_I);
    AddConstant('ELEMENT_TYPE_U',ELEMENT_TYPE_U);
    AddConstant('ELEMENT_TYPE_FNPTR',ELEMENT_TYPE_FNPTR);
    AddConstant('ELEMENT_TYPE_OBJECT',ELEMENT_TYPE_OBJECT);
    AddConstant('ELEMENT_TYPE_SZARRAY',ELEMENT_TYPE_SZARRAY);
    AddConstant('ELEMENT_TYPE_MVAR',ELEMENT_TYPE_MVAR);
    AddConstant('ELEMENT_TYPE_CMOD_REQD',ELEMENT_TYPE_CMOD_REQD);
    AddConstant('ELEMENT_TYPE_CMOD_OPT',ELEMENT_TYPE_CMOD_OPT);
    AddConstant('ELEMENT_TYPE_INTERNAL',ELEMENT_TYPE_INTERNAL);
    AddConstant('ELEMENT_TYPE_MAX',ELEMENT_TYPE_MAX);
    AddConstant('ELEMENT_TYPE_MODIFIER',ELEMENT_TYPE_MODIFIER);
    AddConstant('ELEMENT_TYPE_SENTINEL',ELEMENT_TYPE_SENTINEL);
    AddConstant('ELEMENT_TYPE_PINNED',ELEMENT_TYPE_PINNED);
    AddConstant('ELEMENT_TYPE_R4_HFA',ELEMENT_TYPE_R4_HFA);
    AddConstant('ELEMENT_TYPE_R8_HFA',ELEMENT_TYPE_R8_HFA);
    AddConstant('mdtModule',mdtModule);
    AddConstant('mdtTypeRef',mdtTypeRef);
    AddConstant('mdtTypeDef',mdtTypeDef);
    AddConstant('mdtFieldDef',mdtFieldDef);
    AddConstant('mdtMethodDef',mdtMethodDef);
    AddConstant('mdtParamDef',mdtParamDef);
    AddConstant('mdtInterfaceImpl',mdtInterfaceImpl);
    AddConstant('mdtMemberRef',mdtMemberRef);
    AddConstant('mdtCustomAttribute',mdtCustomAttribute);
    AddConstant('mdtPermission',mdtPermission);
    AddConstant('mdtSignature',mdtSignature);
    AddConstant('mdtEvent',mdtEvent);
    AddConstant('mdtProperty',mdtProperty);
    AddConstant('mdtModuleRef',mdtModuleRef);
    AddConstant('mdtTypeSpec',mdtTypeSpec);
    AddConstant('mdtAssembly',mdtAssembly);
    AddConstant('mdtAssemblyRef',mdtAssemblyRef);
    AddConstant('mdtFile',mdtFile);
    AddConstant('mdtExportedType',mdtExportedType);
    AddConstant('mdtManifestResource',mdtManifestResource);
    AddConstant('mdtGenericParam',mdtGenericParam);
    AddConstant('mdtMethodSpec',mdtMethodSpec);
    AddConstant('mdtGenericParamConstraint',mdtGenericParamConstraint);
    AddConstant('mdtString',mdtString);
    AddConstant('mdtName',mdtName);
    AddConstant('mdtBaseType',mdtBaseType);
    AddConstant('mdTokenNil',mdTokenNil);
    AddConstant('mdModuleNil',mdModuleNil);
    AddConstant('mdTypeRefNil',mdTypeRefNil);
    AddConstant('mdTypeDefNil',mdTypeDefNil);
    AddConstant('mdFieldDefNil',mdFieldDefNil);
    AddConstant('mdMethodDefNil',mdMethodDefNil);
    AddConstant('mdParamDefNil',mdParamDefNil);
    AddConstant('mdInterfaceImplNil',mdInterfaceImplNil);
    AddConstant('mdMemberRefNil',mdMemberRefNil);
    AddConstant('mdCustomAttributeNil',mdCustomAttributeNil);
    AddConstant('mdPermissionNil',mdPermissionNil);
    AddConstant('mdSignatureNil',mdSignatureNil);
    AddConstant('mdEventNil',mdEventNil);
    AddConstant('mdPropertyNil',mdPropertyNil);
    AddConstant('mdModuleRefNil',mdModuleRefNil);
    AddConstant('mdTypeSpecNil',mdTypeSpecNil);
    AddConstant('mdAssemblyNil',mdAssemblyNil);
    AddConstant('mdAssemblyRefNil',mdAssemblyRefNil);
    AddConstant('mdFileNil',mdFileNil);
    AddConstant('mdExportedTypeNil',mdExportedTypeNil);
    AddConstant('mdManifestResourceNil',mdManifestResourceNil);
    AddConstant('mdGenericParamNil',mdGenericParamNil);
    AddConstant('mdGenericParamConstraintNil',mdGenericParamConstraintNil);
    AddConstant('mdMethodSpecNil',mdMethodSpecNil);
    AddConstant('mdStringNil',mdStringNil);
    AddConstant('ofRead',ofRead);
    AddConstant('ofWrite',ofWrite);
    AddConstant('ofReadWriteMask',ofReadWriteMask);
    AddConstant('ofCopyMemory',ofCopyMemory);
    AddConstant('ofManifestMetadata',ofManifestMetadata);
    AddConstant('ofReadOnly',ofReadOnly);
    AddConstant('ofTakeOwnership',ofTakeOwnership);
    AddConstant('ofCacheImage',ofCacheImage);
    AddConstant('ofNoTypeLib',ofNoTypeLib);
    AddConstant('ofReserved1',ofReserved1);
    AddConstant('ofReserved2',ofReserved2);
    AddConstant('ofReserved',ofReserved);
  end;
end;

class function TatCorHdrLibrary.LibraryName: string;
begin
  result := 'CorHdr';
end;

initialization
  RegisterScripterLibrary(TatCorHdrLibrary, True);

{$WARNINGS ON}

end.

