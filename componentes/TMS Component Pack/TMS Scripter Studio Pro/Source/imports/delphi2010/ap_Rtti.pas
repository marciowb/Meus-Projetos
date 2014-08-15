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
unit ap_Rtti;

interface

uses
  SysConst,
  ActiveX,
  Variants,
  ObjAuto,
  TypInfo,
  SysUtils,
  Generics.Collections,
  Generics.Defaults,
  SyncObjs,
  Rtti,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatRttiLibrary = class(TatScripterLibrary)
    procedure __TRttiObjectDestroy(AMachine: TatVirtualMachine);
    procedure __GetTRttiObjectRttiDataSize(AMachine: TatVirtualMachine);
    procedure __GetTRttiObjectParent(AMachine: TatVirtualMachine);
    procedure __GetTRttiObjectPackage(AMachine: TatVirtualMachine);
    procedure __GetTRttiNamedObjectName(AMachine: TatVirtualMachine);
    procedure __TRttiTypeToString(AMachine: TatVirtualMachine);
    procedure __TRttiTypeGetMethod(AMachine: TatVirtualMachine);
    procedure __TRttiTypeGetField(AMachine: TatVirtualMachine);
    procedure __TRttiTypeGetProperty(AMachine: TatVirtualMachine);
    procedure __GetTRttiTypeQualifiedName(AMachine: TatVirtualMachine);
    procedure __GetTRttiTypeIsPublicType(AMachine: TatVirtualMachine);
    procedure __GetTRttiTypeTypeKind(AMachine: TatVirtualMachine);
    procedure __GetTRttiTypeTypeSize(AMachine: TatVirtualMachine);
    procedure __GetTRttiTypeIsManaged(AMachine: TatVirtualMachine);
    procedure __GetTRttiTypeBaseType(AMachine: TatVirtualMachine);
    procedure __GetTRttiTypeAsInstance(AMachine: TatVirtualMachine);
    procedure __GetTRttiTypeIsInstance(AMachine: TatVirtualMachine);
    procedure __GetTRttiTypeAsOrdinal(AMachine: TatVirtualMachine);
    procedure __GetTRttiTypeIsOrdinal(AMachine: TatVirtualMachine);
    procedure __GetTRttiTypeAsRecord(AMachine: TatVirtualMachine);
    procedure __GetTRttiTypeIsRecord(AMachine: TatVirtualMachine);
    procedure __GetTRttiTypeIsSet(AMachine: TatVirtualMachine);
    procedure __GetTRttiTypeAsSet(AMachine: TatVirtualMachine);
    procedure __GetTRttiMemberParent(AMachine: TatVirtualMachine);
    procedure __GetTRttiMemberVisibility(AMachine: TatVirtualMachine);
    procedure __TRttiFieldToString(AMachine: TatVirtualMachine);
    procedure __GetTRttiFieldFieldType(AMachine: TatVirtualMachine);
    procedure __GetTRttiFieldOffset(AMachine: TatVirtualMachine);
    procedure __GetTRttiManagedFieldFieldType(AMachine: TatVirtualMachine);
    procedure __GetTRttiManagedFieldFieldOffset(AMachine: TatVirtualMachine);
    procedure __GetTRttiPropertyPropertyType(AMachine: TatVirtualMachine);
    procedure __GetTRttiPropertyIsReadable(AMachine: TatVirtualMachine);
    procedure __GetTRttiPropertyIsWritable(AMachine: TatVirtualMachine);
    procedure __TRttiInstancePropertyToString(AMachine: TatVirtualMachine);
    procedure __GetTRttiInstancePropertyPropertyType(AMachine: TatVirtualMachine);
    procedure __GetTRttiInstancePropertyIndex(AMachine: TatVirtualMachine);
    procedure __GetTRttiInstancePropertyDefault(AMachine: TatVirtualMachine);
    procedure __GetTRttiInstancePropertyNameIndex(AMachine: TatVirtualMachine);
    procedure __TRttiParameterToString(AMachine: TatVirtualMachine);
    procedure __GetTRttiParameterFlags(AMachine: TatVirtualMachine);
    procedure __GetTRttiParameterParamType(AMachine: TatVirtualMachine);
    procedure __TRttiMethodToString(AMachine: TatVirtualMachine);
    procedure __GetTRttiMethodReturnType(AMachine: TatVirtualMachine);
    procedure __GetTRttiMethodHasExtendedInfo(AMachine: TatVirtualMachine);
    procedure __GetTRttiMethodMethodKind(AMachine: TatVirtualMachine);
    procedure __GetTRttiMethodDispatchKind(AMachine: TatVirtualMachine);
    procedure __GetTRttiMethodIsConstructor(AMachine: TatVirtualMachine);
    procedure __GetTRttiMethodIsDestructor(AMachine: TatVirtualMachine);
    procedure __GetTRttiMethodIsClassMethod(AMachine: TatVirtualMachine);
    procedure __GetTRttiMethodIsStatic(AMachine: TatVirtualMachine);
    procedure __GetTRttiMethodVirtualIndex(AMachine: TatVirtualMachine);
    procedure __GetTRttiMethodCallingConvention(AMachine: TatVirtualMachine);
    procedure __GetTRttiInstanceTypeBaseType(AMachine: TatVirtualMachine);
    procedure __GetTRttiInstanceTypeDeclaringUnitName(AMachine: TatVirtualMachine);
    procedure __GetTRttiInstanceTypeMetaclassType(AMachine: TatVirtualMachine);
    procedure __GetTRttiInterfaceTypeBaseType(AMachine: TatVirtualMachine);
    procedure __GetTRttiInterfaceTypeGUID(AMachine: TatVirtualMachine);
    procedure __GetTRttiInterfaceTypeIntfFlags(AMachine: TatVirtualMachine);
    procedure __GetTRttiInterfaceTypeDeclaringUnitName(AMachine: TatVirtualMachine);
    procedure __GetTRttiOrdinalTypeOrdType(AMachine: TatVirtualMachine);
    procedure __GetTRttiOrdinalTypeMinValue(AMachine: TatVirtualMachine);
    procedure __GetTRttiOrdinalTypeMaxValue(AMachine: TatVirtualMachine);
    procedure __GetTRttiInt64TypeMinValue(AMachine: TatVirtualMachine);
    procedure __GetTRttiInt64TypeMaxValue(AMachine: TatVirtualMachine);
    procedure __GetTRttiMethodTypeMethodKind(AMachine: TatVirtualMachine);
    procedure __GetTRttiClassRefTypeInstanceType(AMachine: TatVirtualMachine);
    procedure __GetTRttiClassRefTypeMetaclassType(AMachine: TatVirtualMachine);
    procedure __GetTRttiEnumerationTypeUnderlyingType(AMachine: TatVirtualMachine);
    procedure __GetTRttiSetTypeElementType(AMachine: TatVirtualMachine);
    procedure __GetTRttiStringTypeStringKind(AMachine: TatVirtualMachine);
    procedure __GetTRttiAnsiStringTypeCodePage(AMachine: TatVirtualMachine);
    procedure __GetTRttiFloatTypeFloatType(AMachine: TatVirtualMachine);
    procedure __GetTRttiArrayTypeTotalElementCount(AMachine: TatVirtualMachine);
    procedure __GetTRttiArrayTypeElementType(AMachine: TatVirtualMachine);
    procedure __GetTRttiArrayTypeDimensionCount(AMachine: TatVirtualMachine);
    procedure __GetTRttiArrayTypeDimensions(AMachine: TatVirtualMachine);
    procedure __GetTRttiDynamicArrayTypeElementSize(AMachine: TatVirtualMachine);
    procedure __GetTRttiDynamicArrayTypeElementType(AMachine: TatVirtualMachine);
    procedure __GetTRttiDynamicArrayTypeOleAutoVarType(AMachine: TatVirtualMachine);
    procedure __GetTRttiDynamicArrayTypeDeclaringUnitName(AMachine: TatVirtualMachine);
    procedure __GetTRttiPointerTypeReferredType(AMachine: TatVirtualMachine);
    procedure __TRttiPackageDestroy(AMachine: TatVirtualMachine);
    procedure __TRttiPackageFindType(AMachine: TatVirtualMachine);
    procedure __GetTRttiPackageHandle(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TRttiObjectClass = class of TRttiObject;
  TRttiNamedObjectClass = class of TRttiNamedObject;
  TRttiTypeClass = class of TRttiType;
  TRttiMemberClass = class of TRttiMember;
  TRttiStructuredTypeClass = class of TRttiStructuredType;
  TRttiFieldClass = class of TRttiField;
  TRttiManagedFieldClass = class of TRttiManagedField;
  TRttiRecordTypeClass = class of TRttiRecordType;
  TRttiPropertyClass = class of TRttiProperty;
  TRttiInstancePropertyClass = class of TRttiInstanceProperty;
  TRttiParameterClass = class of TRttiParameter;
  TRttiMethodClass = class of TRttiMethod;
  TRttiInstanceTypeClass = class of TRttiInstanceType;
  TRttiInterfaceTypeClass = class of TRttiInterfaceType;
  TRttiOrdinalTypeClass = class of TRttiOrdinalType;
  TRttiInt64TypeClass = class of TRttiInt64Type;
  TRttiMethodTypeClass = class of TRttiMethodType;
  TRttiClassRefTypeClass = class of TRttiClassRefType;
  TRttiEnumerationTypeClass = class of TRttiEnumerationType;
  TRttiSetTypeClass = class of TRttiSetType;
  TRttiStringTypeClass = class of TRttiStringType;
  TRttiAnsiStringTypeClass = class of TRttiAnsiStringType;
  TRttiFloatTypeClass = class of TRttiFloatType;
  TRttiArrayTypeClass = class of TRttiArrayType;
  TRttiDynamicArrayTypeClass = class of TRttiDynamicArrayType;
  TRttiPointerTypeClass = class of TRttiPointerType;
  TRttiProcedureTypeClass = class of TRttiProcedureType;
  TRttiPackageClass = class of TRttiPackage;
  EInsufficientRttiClass = class of EInsufficientRtti;
  EInvocationErrorClass = class of EInvocationError;
  ENonPublicTypeClass = class of ENonPublicType;


  TValueDataWrapper = class(TatRecordWrapper)
  private
    FFHeapData: IInterface;
    FFAsUByte: Byte;
    FFAsUWord: Word;
    FFAsULong: LongWord;
    FFAsObject: TObject;
    FFAsClass: TClass;
    FFAsSByte: Shortint;
    FFAsSWord: Smallint;
    FFAsSLong: Longint;
    FFAsSingle: Single;
    FFAsDouble: Double;
    FFAsExtended: Extended;
    FFAsComp: Comp;
    FFAsCurr: Currency;
    FFAsUInt64: UInt64;
    FFAsSInt64: Int64;
    FFAsMethod: TMethod;
  public
    constructor Create(ARecord: TValueData);
    function ObjToRec: TValueData;
  published
    property FHeapData: IInterface read FFHeapData write FFHeapData;
    property FAsUByte: Byte read FFAsUByte write FFAsUByte;
    property FAsUWord: Word read FFAsUWord write FFAsUWord;
    property FAsULong: LongWord read FFAsULong write FFAsULong;
    property FAsObject: TObject read FFAsObject write FFAsObject;
    property FAsClass: TClass read FFAsClass write FFAsClass;
    property FAsSByte: Shortint read FFAsSByte write FFAsSByte;
    property FAsSWord: Smallint read FFAsSWord write FFAsSWord;
    property FAsSLong: Longint read FFAsSLong write FFAsSLong;
    property FAsSingle: Single read FFAsSingle write FFAsSingle;
    property FAsDouble: Double read FFAsDouble write FFAsDouble;
    property FAsExtended: Extended read FFAsExtended write FFAsExtended;
    property FAsComp: Comp read FFAsComp write FFAsComp;
    property FAsCurr: Currency read FFAsCurr write FFAsCurr;
    property FAsUInt64: UInt64 read FFAsUInt64 write FFAsUInt64;
    property FAsSInt64: Int64 read FFAsSInt64 write FFAsSInt64;
    property FAsMethod: TMethod read FFAsMethod write FFAsMethod;
  end;
  
  TValueWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: TValue);
    function ObjToRec: TValue;
  published
  end;
  

implementation

constructor TValueDataWrapper.Create(ARecord: TValueData);
begin
  inherited Create;
  FFHeapData := ARecord.FHeapData;
  FFAsUByte := ARecord.FAsUByte;
  FFAsUWord := ARecord.FAsUWord;
  FFAsULong := ARecord.FAsULong;
  FFAsObject := ARecord.FAsObject;
  FFAsClass := ARecord.FAsClass;
  FFAsSByte := ARecord.FAsSByte;
  FFAsSWord := ARecord.FAsSWord;
  FFAsSLong := ARecord.FAsSLong;
  FFAsSingle := ARecord.FAsSingle;
  FFAsDouble := ARecord.FAsDouble;
  FFAsExtended := ARecord.FAsExtended;
  FFAsComp := ARecord.FAsComp;
  FFAsCurr := ARecord.FAsCurr;
  FFAsUInt64 := ARecord.FAsUInt64;
  FFAsSInt64 := ARecord.FAsSInt64;
  FFAsMethod := ARecord.FAsMethod;
end;

function TValueDataWrapper.ObjToRec: TValueData;
begin
  result.FHeapData := FFHeapData;
  result.FAsUByte := FFAsUByte;
  result.FAsUWord := FFAsUWord;
  result.FAsULong := FFAsULong;
  result.FAsObject := FFAsObject;
  result.FAsClass := FFAsClass;
  result.FAsSByte := FFAsSByte;
  result.FAsSWord := FFAsSWord;
  result.FAsSLong := FFAsSLong;
  result.FAsSingle := FFAsSingle;
  result.FAsDouble := FFAsDouble;
  result.FAsExtended := FFAsExtended;
  result.FAsComp := FFAsComp;
  result.FAsCurr := FFAsCurr;
  result.FAsUInt64 := FFAsUInt64;
  result.FAsSInt64 := FFAsSInt64;
  result.FAsMethod := FFAsMethod;
end;

constructor TValueWrapper.Create(ARecord: TValue);
begin
  inherited Create;
end;

function TValueWrapper.ObjToRec: TValue;
begin
end;



procedure TatRttiLibrary.__TRttiObjectDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRttiObject(CurrentObject).Destroy;
  end;
end;

procedure TatRttiLibrary.__GetTRttiObjectRttiDataSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiObject(CurrentObject).RttiDataSize));
  end;
end;

procedure TatRttiLibrary.__GetTRttiObjectParent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiObject(CurrentObject).Parent));
  end;
end;

procedure TatRttiLibrary.__GetTRttiObjectPackage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiObject(CurrentObject).Package));
  end;
end;

procedure TatRttiLibrary.__GetTRttiNamedObjectName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TRttiNamedObject(CurrentObject).Name);
  end;
end;

procedure TatRttiLibrary.__TRttiTypeToString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TRttiType(CurrentObject).ToString;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRttiLibrary.__TRttiTypeGetMethod(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TRttiType(CurrentObject).GetMethod(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRttiLibrary.__TRttiTypeGetField(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TRttiType(CurrentObject).GetField(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRttiLibrary.__TRttiTypeGetProperty(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TRttiType(CurrentObject).GetProperty(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRttiLibrary.__GetTRttiTypeQualifiedName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TRttiType(CurrentObject).QualifiedName);
  end;
end;

procedure TatRttiLibrary.__GetTRttiTypeIsPublicType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TRttiType(CurrentObject).IsPublicType);
  end;
end;

procedure TatRttiLibrary.__GetTRttiTypeTypeKind(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TRttiType(CurrentObject).TypeKind);
  end;
end;

procedure TatRttiLibrary.__GetTRttiTypeTypeSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiType(CurrentObject).TypeSize));
  end;
end;

procedure TatRttiLibrary.__GetTRttiTypeIsManaged(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TRttiType(CurrentObject).IsManaged);
  end;
end;

procedure TatRttiLibrary.__GetTRttiTypeBaseType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiType(CurrentObject).BaseType));
  end;
end;

procedure TatRttiLibrary.__GetTRttiTypeAsInstance(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiType(CurrentObject).AsInstance));
  end;
end;

procedure TatRttiLibrary.__GetTRttiTypeIsInstance(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TRttiType(CurrentObject).IsInstance);
  end;
end;

procedure TatRttiLibrary.__GetTRttiTypeAsOrdinal(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiType(CurrentObject).AsOrdinal));
  end;
end;

procedure TatRttiLibrary.__GetTRttiTypeIsOrdinal(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TRttiType(CurrentObject).IsOrdinal);
  end;
end;

procedure TatRttiLibrary.__GetTRttiTypeAsRecord(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiType(CurrentObject).AsRecord));
  end;
end;

procedure TatRttiLibrary.__GetTRttiTypeIsRecord(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TRttiType(CurrentObject).IsRecord);
  end;
end;

procedure TatRttiLibrary.__GetTRttiTypeIsSet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TRttiType(CurrentObject).IsSet);
  end;
end;

procedure TatRttiLibrary.__GetTRttiTypeAsSet(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiType(CurrentObject).AsSet));
  end;
end;

procedure TatRttiLibrary.__GetTRttiMemberParent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiMember(CurrentObject).Parent));
  end;
end;

procedure TatRttiLibrary.__GetTRttiMemberVisibility(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TRttiMember(CurrentObject).Visibility);
  end;
end;

procedure TatRttiLibrary.__TRttiFieldToString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TRttiField(CurrentObject).ToString;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRttiLibrary.__GetTRttiFieldFieldType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiField(CurrentObject).FieldType));
  end;
end;

procedure TatRttiLibrary.__GetTRttiFieldOffset(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiField(CurrentObject).Offset));
  end;
end;

procedure TatRttiLibrary.__GetTRttiManagedFieldFieldType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiManagedField(CurrentObject).FieldType));
  end;
end;

procedure TatRttiLibrary.__GetTRttiManagedFieldFieldOffset(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiManagedField(CurrentObject).FieldOffset));
  end;
end;

procedure TatRttiLibrary.__GetTRttiPropertyPropertyType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiProperty(CurrentObject).PropertyType));
  end;
end;

procedure TatRttiLibrary.__GetTRttiPropertyIsReadable(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TRttiProperty(CurrentObject).IsReadable);
  end;
end;

procedure TatRttiLibrary.__GetTRttiPropertyIsWritable(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TRttiProperty(CurrentObject).IsWritable);
  end;
end;

procedure TatRttiLibrary.__TRttiInstancePropertyToString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TRttiInstanceProperty(CurrentObject).ToString;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRttiLibrary.__GetTRttiInstancePropertyPropertyType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiInstanceProperty(CurrentObject).PropertyType));
  end;
end;

procedure TatRttiLibrary.__GetTRttiInstancePropertyIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiInstanceProperty(CurrentObject).Index));
  end;
end;

procedure TatRttiLibrary.__GetTRttiInstancePropertyDefault(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiInstanceProperty(CurrentObject).Default));
  end;
end;

procedure TatRttiLibrary.__GetTRttiInstancePropertyNameIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiInstanceProperty(CurrentObject).NameIndex));
  end;
end;

procedure TatRttiLibrary.__TRttiParameterToString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TRttiParameter(CurrentObject).ToString;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRttiLibrary.__GetTRttiParameterFlags(AMachine: TatVirtualMachine);
var
PropValueSet: TParamFlags;
begin
  with AMachine do
  begin
    PropValueSet := TRttiParameter(CurrentObject).Flags;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatRttiLibrary.__GetTRttiParameterParamType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiParameter(CurrentObject).ParamType));
  end;
end;

procedure TatRttiLibrary.__TRttiMethodToString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TRttiMethod(CurrentObject).ToString;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRttiLibrary.__GetTRttiMethodReturnType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiMethod(CurrentObject).ReturnType));
  end;
end;

procedure TatRttiLibrary.__GetTRttiMethodHasExtendedInfo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TRttiMethod(CurrentObject).HasExtendedInfo);
  end;
end;

procedure TatRttiLibrary.__GetTRttiMethodMethodKind(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TRttiMethod(CurrentObject).MethodKind);
  end;
end;

procedure TatRttiLibrary.__GetTRttiMethodDispatchKind(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TRttiMethod(CurrentObject).DispatchKind);
  end;
end;

procedure TatRttiLibrary.__GetTRttiMethodIsConstructor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TRttiMethod(CurrentObject).IsConstructor);
  end;
end;

procedure TatRttiLibrary.__GetTRttiMethodIsDestructor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TRttiMethod(CurrentObject).IsDestructor);
  end;
end;

procedure TatRttiLibrary.__GetTRttiMethodIsClassMethod(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TRttiMethod(CurrentObject).IsClassMethod);
  end;
end;

procedure TatRttiLibrary.__GetTRttiMethodIsStatic(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TRttiMethod(CurrentObject).IsStatic);
  end;
end;

procedure TatRttiLibrary.__GetTRttiMethodVirtualIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiMethod(CurrentObject).VirtualIndex));
  end;
end;

procedure TatRttiLibrary.__GetTRttiMethodCallingConvention(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TRttiMethod(CurrentObject).CallingConvention);
  end;
end;

procedure TatRttiLibrary.__GetTRttiInstanceTypeBaseType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiInstanceType(CurrentObject).BaseType));
  end;
end;

procedure TatRttiLibrary.__GetTRttiInstanceTypeDeclaringUnitName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TRttiInstanceType(CurrentObject).DeclaringUnitName);
  end;
end;

procedure TatRttiLibrary.__GetTRttiInstanceTypeMetaclassType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TRttiInstanceType(CurrentObject).MetaclassType));
  end;
end;

procedure TatRttiLibrary.__GetTRttiInterfaceTypeBaseType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiInterfaceType(CurrentObject).BaseType));
  end;
end;

procedure TatRttiLibrary.__GetTRttiInterfaceTypeGUID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(TRttiInterfaceType(CurrentObject).GUID)));
  end;
end;

procedure TatRttiLibrary.__GetTRttiInterfaceTypeIntfFlags(AMachine: TatVirtualMachine);
var
PropValueSet: TIntfFlags;
begin
  with AMachine do
  begin
    PropValueSet := TRttiInterfaceType(CurrentObject).IntfFlags;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatRttiLibrary.__GetTRttiInterfaceTypeDeclaringUnitName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TRttiInterfaceType(CurrentObject).DeclaringUnitName);
  end;
end;

procedure TatRttiLibrary.__GetTRttiOrdinalTypeOrdType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TRttiOrdinalType(CurrentObject).OrdType);
  end;
end;

procedure TatRttiLibrary.__GetTRttiOrdinalTypeMinValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiOrdinalType(CurrentObject).MinValue));
  end;
end;

procedure TatRttiLibrary.__GetTRttiOrdinalTypeMaxValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiOrdinalType(CurrentObject).MaxValue));
  end;
end;

procedure TatRttiLibrary.__GetTRttiInt64TypeMinValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiInt64Type(CurrentObject).MinValue));
  end;
end;

procedure TatRttiLibrary.__GetTRttiInt64TypeMaxValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiInt64Type(CurrentObject).MaxValue));
  end;
end;

procedure TatRttiLibrary.__GetTRttiMethodTypeMethodKind(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TRttiMethodType(CurrentObject).MethodKind);
  end;
end;

procedure TatRttiLibrary.__GetTRttiClassRefTypeInstanceType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiClassRefType(CurrentObject).InstanceType));
  end;
end;

procedure TatRttiLibrary.__GetTRttiClassRefTypeMetaclassType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TRttiClassRefType(CurrentObject).MetaclassType));
  end;
end;

procedure TatRttiLibrary.__GetTRttiEnumerationTypeUnderlyingType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiEnumerationType(CurrentObject).UnderlyingType));
  end;
end;

procedure TatRttiLibrary.__GetTRttiSetTypeElementType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiSetType(CurrentObject).ElementType));
  end;
end;

procedure TatRttiLibrary.__GetTRttiStringTypeStringKind(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TRttiStringType(CurrentObject).StringKind);
  end;
end;

procedure TatRttiLibrary.__GetTRttiAnsiStringTypeCodePage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiAnsiStringType(CurrentObject).CodePage));
  end;
end;

procedure TatRttiLibrary.__GetTRttiFloatTypeFloatType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TRttiFloatType(CurrentObject).FloatType);
  end;
end;

procedure TatRttiLibrary.__GetTRttiArrayTypeTotalElementCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiArrayType(CurrentObject).TotalElementCount));
  end;
end;

procedure TatRttiLibrary.__GetTRttiArrayTypeElementType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiArrayType(CurrentObject).ElementType));
  end;
end;

procedure TatRttiLibrary.__GetTRttiArrayTypeDimensionCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiArrayType(CurrentObject).DimensionCount));
  end;
end;

procedure TatRttiLibrary.__GetTRttiArrayTypeDimensions(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiArrayType(CurrentObject).Dimensions[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatRttiLibrary.__GetTRttiDynamicArrayTypeElementSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiDynamicArrayType(CurrentObject).ElementSize));
  end;
end;

procedure TatRttiLibrary.__GetTRttiDynamicArrayTypeElementType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiDynamicArrayType(CurrentObject).ElementType));
  end;
end;

procedure TatRttiLibrary.__GetTRttiDynamicArrayTypeOleAutoVarType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiDynamicArrayType(CurrentObject).OleAutoVarType));
  end;
end;

procedure TatRttiLibrary.__GetTRttiDynamicArrayTypeDeclaringUnitName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TRttiDynamicArrayType(CurrentObject).DeclaringUnitName);
  end;
end;

procedure TatRttiLibrary.__GetTRttiPointerTypeReferredType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TRttiPointerType(CurrentObject).ReferredType));
  end;
end;

procedure TatRttiLibrary.__TRttiPackageDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TRttiPackage(CurrentObject).Destroy;
  end;
end;

procedure TatRttiLibrary.__TRttiPackageFindType(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TRttiPackage(CurrentObject).FindType(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatRttiLibrary.__GetTRttiPackageHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TRttiPackage(CurrentObject).Handle);
  end;
end;

procedure TatRttiLibrary.Init;
begin
  With Scripter.DefineClass(TRttiObject) do
  begin
    DefineMethod('Destroy',0,tkNone,nil,__TRttiObjectDestroy,false,0);
    DefineProp('RttiDataSize',tkInteger,__GetTRttiObjectRttiDataSize,nil,nil,false,0);
    DefineProp('Parent',tkClass,__GetTRttiObjectParent,nil,TRttiObject,false,0);
    DefineProp('Package',tkClass,__GetTRttiObjectPackage,nil,TRttiPackage,false,0);
  end;
  With Scripter.DefineClass(TRttiNamedObject) do
  begin
    DefineProp('Name',tkVariant,__GetTRttiNamedObjectName,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TRttiType) do
  begin
    DefineMethod('ToString',0,tkVariant,nil,__TRttiTypeToString,false,0);
    DefineMethod('GetMethod',1,tkClass,TRttiMethod,__TRttiTypeGetMethod,false,0);
    DefineMethod('GetField',1,tkClass,TRttiField,__TRttiTypeGetField,false,0);
    DefineMethod('GetProperty',1,tkClass,TRttiProperty,__TRttiTypeGetProperty,false,0);
    DefineProp('QualifiedName',tkVariant,__GetTRttiTypeQualifiedName,nil,nil,false,0);
    DefineProp('IsPublicType',tkVariant,__GetTRttiTypeIsPublicType,nil,nil,false,0);
    DefineProp('TypeKind',tkEnumeration,__GetTRttiTypeTypeKind,nil,nil,false,0);
    DefineProp('TypeSize',tkInteger,__GetTRttiTypeTypeSize,nil,nil,false,0);
    DefineProp('IsManaged',tkVariant,__GetTRttiTypeIsManaged,nil,nil,false,0);
    DefineProp('BaseType',tkClass,__GetTRttiTypeBaseType,nil,TRttiType,false,0);
    DefineProp('AsInstance',tkClass,__GetTRttiTypeAsInstance,nil,TRttiInstanceType,false,0);
    DefineProp('IsInstance',tkVariant,__GetTRttiTypeIsInstance,nil,nil,false,0);
    DefineProp('AsOrdinal',tkClass,__GetTRttiTypeAsOrdinal,nil,TRttiOrdinalType,false,0);
    DefineProp('IsOrdinal',tkVariant,__GetTRttiTypeIsOrdinal,nil,nil,false,0);
    DefineProp('AsRecord',tkClass,__GetTRttiTypeAsRecord,nil,TRttiRecordType,false,0);
    DefineProp('IsRecord',tkVariant,__GetTRttiTypeIsRecord,nil,nil,false,0);
    DefineProp('IsSet',tkVariant,__GetTRttiTypeIsSet,nil,nil,false,0);
    DefineProp('AsSet',tkClass,__GetTRttiTypeAsSet,nil,TRttiSetType,false,0);
  end;
  With Scripter.DefineClass(TRttiMember) do
  begin
    DefineProp('Parent',tkClass,__GetTRttiMemberParent,nil,TRttiType,false,0);
    DefineProp('Visibility',tkEnumeration,__GetTRttiMemberVisibility,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TRttiStructuredType) do
  begin
  end;
  With Scripter.DefineClass(TRttiField) do
  begin
    DefineMethod('ToString',0,tkVariant,nil,__TRttiFieldToString,false,0);
    DefineProp('FieldType',tkClass,__GetTRttiFieldFieldType,nil,TRttiType,false,0);
    DefineProp('Offset',tkInteger,__GetTRttiFieldOffset,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TRttiManagedField) do
  begin
    DefineProp('FieldType',tkClass,__GetTRttiManagedFieldFieldType,nil,TRttiType,false,0);
    DefineProp('FieldOffset',tkInteger,__GetTRttiManagedFieldFieldOffset,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TRttiRecordType) do
  begin
  end;
  With Scripter.DefineClass(TRttiProperty) do
  begin
    DefineProp('PropertyType',tkClass,__GetTRttiPropertyPropertyType,nil,TRttiType,false,0);
    DefineProp('IsReadable',tkVariant,__GetTRttiPropertyIsReadable,nil,nil,false,0);
    DefineProp('IsWritable',tkVariant,__GetTRttiPropertyIsWritable,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TRttiInstanceProperty) do
  begin
    DefineMethod('ToString',0,tkVariant,nil,__TRttiInstancePropertyToString,false,0);
    DefineProp('PropertyType',tkClass,__GetTRttiInstancePropertyPropertyType,nil,TRttiType,false,0);
    DefineProp('Index',tkInteger,__GetTRttiInstancePropertyIndex,nil,nil,false,0);
    DefineProp('Default',tkInteger,__GetTRttiInstancePropertyDefault,nil,nil,false,0);
    DefineProp('NameIndex',tkInteger,__GetTRttiInstancePropertyNameIndex,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TRttiParameter) do
  begin
    DefineMethod('ToString',0,tkVariant,nil,__TRttiParameterToString,false,0);
    DefineProp('Flags',tkInteger,__GetTRttiParameterFlags,nil,nil,false,0);
    DefineProp('ParamType',tkClass,__GetTRttiParameterParamType,nil,TRttiType,false,0);
  end;
  With Scripter.DefineClass(TRttiMethod) do
  begin
    DefineMethod('ToString',0,tkVariant,nil,__TRttiMethodToString,false,0);
    DefineProp('ReturnType',tkClass,__GetTRttiMethodReturnType,nil,TRttiType,false,0);
    DefineProp('HasExtendedInfo',tkVariant,__GetTRttiMethodHasExtendedInfo,nil,nil,false,0);
    DefineProp('MethodKind',tkEnumeration,__GetTRttiMethodMethodKind,nil,nil,false,0);
    DefineProp('DispatchKind',tkEnumeration,__GetTRttiMethodDispatchKind,nil,nil,false,0);
    DefineProp('IsConstructor',tkVariant,__GetTRttiMethodIsConstructor,nil,nil,false,0);
    DefineProp('IsDestructor',tkVariant,__GetTRttiMethodIsDestructor,nil,nil,false,0);
    DefineProp('IsClassMethod',tkVariant,__GetTRttiMethodIsClassMethod,nil,nil,false,0);
    DefineProp('IsStatic',tkVariant,__GetTRttiMethodIsStatic,nil,nil,false,0);
    DefineProp('VirtualIndex',tkInteger,__GetTRttiMethodVirtualIndex,nil,nil,false,0);
    DefineProp('CallingConvention',tkEnumeration,__GetTRttiMethodCallingConvention,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TRttiInstanceType) do
  begin
    DefineProp('BaseType',tkClass,__GetTRttiInstanceTypeBaseType,nil,TRttiInstanceType,false,0);
    DefineProp('DeclaringUnitName',tkVariant,__GetTRttiInstanceTypeDeclaringUnitName,nil,nil,false,0);
    DefineProp('MetaclassType',tkVariant,__GetTRttiInstanceTypeMetaclassType,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TRttiInterfaceType) do
  begin
    DefineProp('BaseType',tkClass,__GetTRttiInterfaceTypeBaseType,nil,TRttiInterfaceType,false,0);
    DefineProp('GUID',tkVariant,__GetTRttiInterfaceTypeGUID,nil,nil,false,0);
    DefineProp('IntfFlags',tkInteger,__GetTRttiInterfaceTypeIntfFlags,nil,nil,false,0);
    DefineProp('DeclaringUnitName',tkVariant,__GetTRttiInterfaceTypeDeclaringUnitName,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TRttiOrdinalType) do
  begin
    DefineProp('OrdType',tkEnumeration,__GetTRttiOrdinalTypeOrdType,nil,nil,false,0);
    DefineProp('MinValue',tkInteger,__GetTRttiOrdinalTypeMinValue,nil,nil,false,0);
    DefineProp('MaxValue',tkInteger,__GetTRttiOrdinalTypeMaxValue,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TRttiInt64Type) do
  begin
    DefineProp('MinValue',tkVariant,__GetTRttiInt64TypeMinValue,nil,nil,false,0);
    DefineProp('MaxValue',tkVariant,__GetTRttiInt64TypeMaxValue,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TRttiMethodType) do
  begin
    DefineProp('MethodKind',tkEnumeration,__GetTRttiMethodTypeMethodKind,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TRttiClassRefType) do
  begin
    DefineProp('InstanceType',tkClass,__GetTRttiClassRefTypeInstanceType,nil,TRttiInstanceType,false,0);
    DefineProp('MetaclassType',tkVariant,__GetTRttiClassRefTypeMetaclassType,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TRttiEnumerationType) do
  begin
    DefineProp('UnderlyingType',tkClass,__GetTRttiEnumerationTypeUnderlyingType,nil,TRttiType,false,0);
  end;
  With Scripter.DefineClass(TRttiSetType) do
  begin
    DefineProp('ElementType',tkClass,__GetTRttiSetTypeElementType,nil,TRttiType,false,0);
  end;
  With Scripter.DefineClass(TRttiStringType) do
  begin
    DefineProp('StringKind',tkEnumeration,__GetTRttiStringTypeStringKind,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TRttiAnsiStringType) do
  begin
    DefineProp('CodePage',tkInteger,__GetTRttiAnsiStringTypeCodePage,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TRttiFloatType) do
  begin
    DefineProp('FloatType',tkEnumeration,__GetTRttiFloatTypeFloatType,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TRttiArrayType) do
  begin
    DefineProp('TotalElementCount',tkInteger,__GetTRttiArrayTypeTotalElementCount,nil,nil,false,0);
    DefineProp('ElementType',tkClass,__GetTRttiArrayTypeElementType,nil,TRttiType,false,0);
    DefineProp('DimensionCount',tkInteger,__GetTRttiArrayTypeDimensionCount,nil,nil,false,0);
    DefineProp('Dimensions',tkClass,__GetTRttiArrayTypeDimensions,nil,TRttiType,false,1);
  end;
  With Scripter.DefineClass(TRttiDynamicArrayType) do
  begin
    DefineProp('ElementSize',tkInteger,__GetTRttiDynamicArrayTypeElementSize,nil,nil,false,0);
    DefineProp('ElementType',tkClass,__GetTRttiDynamicArrayTypeElementType,nil,TRttiType,false,0);
    DefineProp('OleAutoVarType',tkInteger,__GetTRttiDynamicArrayTypeOleAutoVarType,nil,nil,false,0);
    DefineProp('DeclaringUnitName',tkVariant,__GetTRttiDynamicArrayTypeDeclaringUnitName,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TRttiPointerType) do
  begin
    DefineProp('ReferredType',tkClass,__GetTRttiPointerTypeReferredType,nil,TRttiType,false,0);
  end;
  With Scripter.DefineClass(TRttiProcedureType) do
  begin
  end;
  With Scripter.DefineClass(TRttiPackage) do
  begin
    DefineMethod('Destroy',0,tkNone,nil,__TRttiPackageDestroy,false,0);
    DefineMethod('FindType',1,tkClass,TRttiType,__TRttiPackageFindType,false,0);
    DefineProp('Handle',tkVariant,__GetTRttiPackageHandle,nil,nil,false,0);
  end;
  With Scripter.DefineClass(EInsufficientRtti) do
  begin
  end;
  With Scripter.DefineClass(EInvocationError) do
  begin
  end;
  With Scripter.DefineClass(ENonPublicType) do
  begin
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('dkStatic',dkStatic);
    AddConstant('dkVtable',dkVtable);
    AddConstant('dkDynamic',dkDynamic);
    AddConstant('dkMessage',dkMessage);
    AddConstant('dkInterface',dkInterface);
    AddConstant('skShortString',skShortString);
    AddConstant('skAnsiString',skAnsiString);
    AddConstant('skWideString',skWideString);
    AddConstant('skUnicodeString',skUnicodeString);
  end;
end;

class function TatRttiLibrary.LibraryName: string;
begin
  result := 'Rtti';
end;

initialization
  RegisterScripterLibrary(TatRttiLibrary, True);

{$WARNINGS ON}

end.

