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
unit ap_TypInfo;

interface

uses
  Variants,
  SysUtils,
  TypInfo,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatTypInfoLibrary = class(TatScripterLibrary)
    procedure __TPublishableVariantTypeGetProperty(AMachine: TatVirtualMachine);
    procedure __TPublishableVariantTypeSetProperty(AMachine: TatVirtualMachine);
    procedure __PropType(AMachine: TatVirtualMachine);
    procedure __PropIsType(AMachine: TatVirtualMachine);
    procedure __IsStoredProp(AMachine: TatVirtualMachine);
    procedure __IsPublishedProp(AMachine: TatVirtualMachine);
    procedure __GetOrdProp(AMachine: TatVirtualMachine);
    procedure __SetOrdProp(AMachine: TatVirtualMachine);
    procedure __GetEnumProp(AMachine: TatVirtualMachine);
    procedure __SetEnumProp(AMachine: TatVirtualMachine);
    procedure __GetSetProp(AMachine: TatVirtualMachine);
    procedure __SetSetProp(AMachine: TatVirtualMachine);
    procedure __SetObjectProp(AMachine: TatVirtualMachine);
    procedure __GetObjectPropClass(AMachine: TatVirtualMachine);
    procedure __GetStrProp(AMachine: TatVirtualMachine);
    procedure __SetStrProp(AMachine: TatVirtualMachine);
    procedure __GetAnsiStrProp(AMachine: TatVirtualMachine);
    procedure __SetAnsiStrProp(AMachine: TatVirtualMachine);
    procedure __GetWideStrProp(AMachine: TatVirtualMachine);
    procedure __SetWideStrProp(AMachine: TatVirtualMachine);
    procedure __GetUnicodeStrProp(AMachine: TatVirtualMachine);
    procedure __SetUnicodeStrProp(AMachine: TatVirtualMachine);
    procedure __GetFloatProp(AMachine: TatVirtualMachine);
    procedure __SetFloatProp(AMachine: TatVirtualMachine);
    procedure __GetVariantProp(AMachine: TatVirtualMachine);
    procedure __SetVariantProp(AMachine: TatVirtualMachine);
    procedure __GetMethodProp(AMachine: TatVirtualMachine);
    procedure __SetMethodProp(AMachine: TatVirtualMachine);
    procedure __GetInt64Prop(AMachine: TatVirtualMachine);
    procedure __SetInt64Prop(AMachine: TatVirtualMachine);
    procedure __GetInterfaceProp(AMachine: TatVirtualMachine);
    procedure __SetInterfaceProp(AMachine: TatVirtualMachine);
    procedure __GetPropValue(AMachine: TatVirtualMachine);
    procedure __SetPropValue(AMachine: TatVirtualMachine);
    procedure __FreeAndNilProperties(AMachine: TatVirtualMachine);
    procedure __SamePropTypeName(AMachine: TatVirtualMachine);
    procedure __GetDotSep(AMachine: TatVirtualMachine);
    procedure __SetDotSep(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TPublishableVariantTypeClass = class of TPublishableVariantType;
  EPropertyErrorClass = class of EPropertyError;
  EPropertyConvertErrorClass = class of EPropertyConvertError;


  TTypeInfoWrapper = class(TatRecordWrapper)
  private
    FKind: TTypeKind;
    FName: ShortString;
  public
    constructor Create(ARecord: TTypeInfo);
    function ObjToRec: TTypeInfo;
  published
    property Kind: TTypeKind read FKind write FKind;
    property Name: ShortString read FName write FName;
  end;
  
  TAttrEntryWrapper = class(TatRecordWrapper)
  private
    FArgLen: Word;
  public
    constructor Create(ARecord: TAttrEntry);
    function ObjToRec: TAttrEntry;
  published
    property ArgLen: Word read FArgLen write FArgLen;
  end;
  
  TAttrDataWrapper = class(TatRecordWrapper)
  private
    FLen: Word;
  public
    constructor Create(ARecord: TAttrData);
    function ObjToRec: TAttrData;
  published
    property Len: Word read FLen write FLen;
  end;
  
  TFieldExEntryWrapper = class(TatRecordWrapper)
  private
    FFlags: Byte;
    FOffset: Longword;
    FName: ShortString;
  public
    constructor Create(ARecord: TFieldExEntry);
    function ObjToRec: TFieldExEntry;
  published
    property Flags: Byte read FFlags write FFlags;
    property Offset: Longword read FOffset write FOffset;
    property Name: ShortString read FName write FName;
  end;
  
  TVmtFieldEntryWrapper = class(TatRecordWrapper)
  private
    FFieldOffset: Longword;
    FTypeIndex: Word;
    FName: ShortString;
  public
    constructor Create(ARecord: TVmtFieldEntry);
    function ObjToRec: TVmtFieldEntry;
  published
    property FieldOffset: Longword read FFieldOffset write FFieldOffset;
    property TypeIndex: Word read FTypeIndex write FTypeIndex;
    property Name: ShortString read FName write FName;
  end;
  
  TVmtFieldClassTabWrapper = class(TatRecordWrapper)
  private
    FCount: Word;
  public
    constructor Create(ARecord: TVmtFieldClassTab);
    function ObjToRec: TVmtFieldClassTab;
  published
    property Count: Word read FCount write FCount;
  end;
  
  TVmtFieldTableWrapper = class(TatRecordWrapper)
  private
    FCount: Word;
  public
    constructor Create(ARecord: TVmtFieldTable);
    function ObjToRec: TVmtFieldTable;
  published
    property Count: Word read FCount write FCount;
  end;
  
  TVmtMethodParamWrapper = class(TatRecordWrapper)
  private
    FFlags: Byte;
    FParOff: Byte;
  public
    constructor Create(ARecord: TVmtMethodParam);
    function ObjToRec: TVmtMethodParam;
  published
    property Flags: Byte read FFlags write FFlags;
    property ParOff: Byte read FParOff write FParOff;
  end;
  
  TVmtMethodEntryWrapper = class(TatRecordWrapper)
  private
    FLen: Word;
    FName: ShortString;
  public
    constructor Create(ARecord: TVmtMethodEntry);
    function ObjToRec: TVmtMethodEntry;
  published
    property Len: Word read FLen write FLen;
    property Name: ShortString read FName write FName;
  end;
  
  TVmtMethodEntryTailWrapper = class(TatRecordWrapper)
  private
    FVersion: Byte;
    FCC: TCallConv;
    FParOff: Word;
    FParamCount: Byte;
  public
    constructor Create(ARecord: TVmtMethodEntryTail);
    function ObjToRec: TVmtMethodEntryTail;
  published
    property Version: Byte read FVersion write FVersion;
    property CC: TCallConv read FCC write FCC;
    property ParOff: Word read FParOff write FParOff;
    property ParamCount: Byte read FParamCount write FParamCount;
  end;
  
  TVmtMethodExEntryWrapper = class(TatRecordWrapper)
  private
    FFlags: Word;
    FVirtualIndex: Smallint;
  public
    constructor Create(ARecord: TVmtMethodExEntry);
    function ObjToRec: TVmtMethodExEntry;
  published
    property Flags: Word read FFlags write FFlags;
    property VirtualIndex: Smallint read FVirtualIndex write FVirtualIndex;
  end;
  
  TVmtMethodTableWrapper = class(TatRecordWrapper)
  private
    FCount: Word;
  public
    constructor Create(ARecord: TVmtMethodTable);
    function ObjToRec: TVmtMethodTable;
  published
    property Count: Word read FCount write FCount;
  end;
  
  TManagedFieldWrapper = class(TatRecordWrapper)
  private
    FFldOffset: Integer;
  public
    constructor Create(ARecord: TManagedField);
    function ObjToRec: TManagedField;
  published
    property FldOffset: Integer read FFldOffset write FFldOffset;
  end;
  
  TProcedureParamWrapper = class(TatRecordWrapper)
  private
    FFlags: Byte;
  public
    constructor Create(ARecord: TProcedureParam);
    function ObjToRec: TProcedureParam;
  published
    property Flags: Byte read FFlags write FFlags;
  end;
  
  TProcedureSignatureWrapper = class(TatRecordWrapper)
  private
    FFlags: Byte;
    FCC: TCallConv;
    FParamCount: Byte;
  public
    constructor Create(ARecord: TProcedureSignature);
    function ObjToRec: TProcedureSignature;
  published
    property Flags: Byte read FFlags write FFlags;
    property CC: TCallConv read FCC write FCC;
    property ParamCount: Byte read FParamCount write FParamCount;
  end;
  
  TIntfMethodTableWrapper = class(TatRecordWrapper)
  private
    FCount: Word;
    FRttiCount: Word;
  public
    constructor Create(ARecord: TIntfMethodTable);
    function ObjToRec: TIntfMethodTable;
  published
    property Count: Word read FCount write FCount;
    property RttiCount: Word read FRttiCount write FRttiCount;
  end;
  
  TIntfMethodEntryWrapper = class(TatRecordWrapper)
  private
    FName: ShortString;
  public
    constructor Create(ARecord: TIntfMethodEntry);
    function ObjToRec: TIntfMethodEntry;
  published
    property Name: ShortString read FName write FName;
  end;
  
  TIntfMethodEntryTailWrapper = class(TatRecordWrapper)
  private
    FKind: Byte;
    FCC: TCallConv;
    FParamCount: Byte;
  public
    constructor Create(ARecord: TIntfMethodEntryTail);
    function ObjToRec: TIntfMethodEntryTail;
  published
    property Kind: Byte read FKind write FKind;
    property CC: TCallConv read FCC write FCC;
    property ParamCount: Byte read FParamCount write FParamCount;
  end;
  
  TIntfMethodParamWrapper = class(TatRecordWrapper)
  private
    FFlags: Byte;
    FParamName: ShortString;
  public
    constructor Create(ARecord: TIntfMethodParam);
    function ObjToRec: TIntfMethodParam;
  published
    property Flags: Byte read FFlags write FFlags;
    property ParamName: ShortString read FParamName write FParamName;
  end;
  
  TIntfMethodParamTailWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: TIntfMethodParamTail);
    function ObjToRec: TIntfMethodParamTail;
  published
  end;
  
  TArrayTypeDataWrapper = class(TatRecordWrapper)
  private
    FSize: Integer;
    FElCount: Integer;
    FDimCount: Byte;
  public
    constructor Create(ARecord: TArrayTypeData);
    function ObjToRec: TArrayTypeData;
  published
    property Size: Integer read FSize write FSize;
    property ElCount: Integer read FElCount write FElCount;
    property DimCount: Byte read FDimCount write FDimCount;
  end;
  
  TRecordTypeFieldWrapper = class(TatRecordWrapper)
  private
    FFlags: Byte;
    FName: ShortString;
  public
    constructor Create(ARecord: TRecordTypeField);
    function ObjToRec: TRecordTypeField;
  published
    property Flags: Byte read FFlags write FFlags;
    property Name: ShortString read FName write FName;
  end;
  
  TTypeDataWrapper = class(TatRecordWrapper)
  private
    FCodePage: Word;
    FOrdType: TOrdType;
    FMinValue: Longint;
    FMaxValue: Longint;
    FFloatType: TFloatType;
    FMaxLength: Byte;
    FClassType: TClass;
    FPropCount: SmallInt;
    FMethodKind: TMethodKind;
    FParamCount: Byte;
    FIntfFlags: TIntfFlagsBase;
    FGuid: TGUID;
    FMinInt64Value: Int64;
    FMaxInt64Value: Int64;
    FelSize: Longint;
    FvarType: Integer;
    FRecSize: Integer;
    FManagedFldCount: Integer;
  public
    constructor Create(ARecord: TTypeData);
    function ObjToRec: TTypeData;
  published
    property CodePage: Word read FCodePage write FCodePage;
    property OrdType: TOrdType read FOrdType write FOrdType;
    property MinValue: Longint read FMinValue write FMinValue;
    property MaxValue: Longint read FMaxValue write FMaxValue;
    property FloatType: TFloatType read FFloatType write FFloatType;
    property MaxLength: Byte read FMaxLength write FMaxLength;
    property ClassType: TClass read FClassType write FClassType;
    property PropCount: SmallInt read FPropCount write FPropCount;
    property MethodKind: TMethodKind read FMethodKind write FMethodKind;
    property ParamCount: Byte read FParamCount write FParamCount;
    property IntfFlags: TIntfFlagsBase read FIntfFlags write FIntfFlags;
    property Guid: TGUID read FGuid write FGuid;
    property MinInt64Value: Int64 read FMinInt64Value write FMinInt64Value;
    property MaxInt64Value: Int64 read FMaxInt64Value write FMaxInt64Value;
    property elSize: Longint read FelSize write FelSize;
    property varType: Integer read FvarType write FvarType;
    property RecSize: Integer read FRecSize write FRecSize;
    property ManagedFldCount: Integer read FManagedFldCount write FManagedFldCount;
  end;
  
  TPropDataWrapper = class(TatRecordWrapper)
  private
    FPropCount: Word;
  public
    constructor Create(ARecord: TPropData);
    function ObjToRec: TPropData;
  published
    property PropCount: Word read FPropCount write FPropCount;
  end;
  
  TPropInfoWrapper = class(TatRecordWrapper)
  private
    FIndex: Integer;
    FDefault: Longint;
    FNameIndex: SmallInt;
    FName: ShortString;
  public
    constructor Create(ARecord: TPropInfo);
    function ObjToRec: TPropInfo;
  published
    property Index: Integer read FIndex write FIndex;
    property Default: Longint read FDefault write FDefault;
    property NameIndex: SmallInt read FNameIndex write FNameIndex;
    property Name: ShortString read FName write FName;
  end;
  
  TPropDataExWrapper = class(TatRecordWrapper)
  private
    FPropCount: Word;
  public
    constructor Create(ARecord: TPropDataEx);
    function ObjToRec: TPropDataEx;
  published
    property PropCount: Word read FPropCount write FPropCount;
  end;
  
  TPropInfoExWrapper = class(TatRecordWrapper)
  private
    FFlags: Byte;
  public
    constructor Create(ARecord: TPropInfoEx);
    function ObjToRec: TPropInfoEx;
  published
    property Flags: Byte read FFlags write FFlags;
  end;
  

implementation

constructor TTypeInfoWrapper.Create(ARecord: TTypeInfo);
begin
  inherited Create;
  FKind := ARecord.Kind;
  FName := ARecord.Name;
end;

function TTypeInfoWrapper.ObjToRec: TTypeInfo;
begin
  result.Kind := FKind;
  result.Name := FName;
end;

constructor TAttrEntryWrapper.Create(ARecord: TAttrEntry);
begin
  inherited Create;
  FArgLen := ARecord.ArgLen;
end;

function TAttrEntryWrapper.ObjToRec: TAttrEntry;
begin
  result.ArgLen := FArgLen;
end;

constructor TAttrDataWrapper.Create(ARecord: TAttrData);
begin
  inherited Create;
  FLen := ARecord.Len;
end;

function TAttrDataWrapper.ObjToRec: TAttrData;
begin
  result.Len := FLen;
end;

constructor TFieldExEntryWrapper.Create(ARecord: TFieldExEntry);
begin
  inherited Create;
  FFlags := ARecord.Flags;
  FOffset := ARecord.Offset;
  FName := ARecord.Name;
end;

function TFieldExEntryWrapper.ObjToRec: TFieldExEntry;
begin
  result.Flags := FFlags;
  result.Offset := FOffset;
  result.Name := FName;
end;

constructor TVmtFieldEntryWrapper.Create(ARecord: TVmtFieldEntry);
begin
  inherited Create;
  FFieldOffset := ARecord.FieldOffset;
  FTypeIndex := ARecord.TypeIndex;
  FName := ARecord.Name;
end;

function TVmtFieldEntryWrapper.ObjToRec: TVmtFieldEntry;
begin
  result.FieldOffset := FFieldOffset;
  result.TypeIndex := FTypeIndex;
  result.Name := FName;
end;

constructor TVmtFieldClassTabWrapper.Create(ARecord: TVmtFieldClassTab);
begin
  inherited Create;
  FCount := ARecord.Count;
end;

function TVmtFieldClassTabWrapper.ObjToRec: TVmtFieldClassTab;
begin
  result.Count := FCount;
end;

constructor TVmtFieldTableWrapper.Create(ARecord: TVmtFieldTable);
begin
  inherited Create;
  FCount := ARecord.Count;
end;

function TVmtFieldTableWrapper.ObjToRec: TVmtFieldTable;
begin
  result.Count := FCount;
end;

constructor TVmtMethodParamWrapper.Create(ARecord: TVmtMethodParam);
begin
  inherited Create;
  FFlags := ARecord.Flags;
  FParOff := ARecord.ParOff;
end;

function TVmtMethodParamWrapper.ObjToRec: TVmtMethodParam;
begin
  result.Flags := FFlags;
  result.ParOff := FParOff;
end;

constructor TVmtMethodEntryWrapper.Create(ARecord: TVmtMethodEntry);
begin
  inherited Create;
  FLen := ARecord.Len;
  FName := ARecord.Name;
end;

function TVmtMethodEntryWrapper.ObjToRec: TVmtMethodEntry;
begin
  result.Len := FLen;
  result.Name := FName;
end;

constructor TVmtMethodEntryTailWrapper.Create(ARecord: TVmtMethodEntryTail);
begin
  inherited Create;
  FVersion := ARecord.Version;
  FCC := ARecord.CC;
  FParOff := ARecord.ParOff;
  FParamCount := ARecord.ParamCount;
end;

function TVmtMethodEntryTailWrapper.ObjToRec: TVmtMethodEntryTail;
begin
  result.Version := FVersion;
  result.CC := FCC;
  result.ParOff := FParOff;
  result.ParamCount := FParamCount;
end;

constructor TVmtMethodExEntryWrapper.Create(ARecord: TVmtMethodExEntry);
begin
  inherited Create;
  FFlags := ARecord.Flags;
  FVirtualIndex := ARecord.VirtualIndex;
end;

function TVmtMethodExEntryWrapper.ObjToRec: TVmtMethodExEntry;
begin
  result.Flags := FFlags;
  result.VirtualIndex := FVirtualIndex;
end;

constructor TVmtMethodTableWrapper.Create(ARecord: TVmtMethodTable);
begin
  inherited Create;
  FCount := ARecord.Count;
end;

function TVmtMethodTableWrapper.ObjToRec: TVmtMethodTable;
begin
  result.Count := FCount;
end;

constructor TManagedFieldWrapper.Create(ARecord: TManagedField);
begin
  inherited Create;
  FFldOffset := ARecord.FldOffset;
end;

function TManagedFieldWrapper.ObjToRec: TManagedField;
begin
  result.FldOffset := FFldOffset;
end;

constructor TProcedureParamWrapper.Create(ARecord: TProcedureParam);
begin
  inherited Create;
  FFlags := ARecord.Flags;
end;

function TProcedureParamWrapper.ObjToRec: TProcedureParam;
begin
  result.Flags := FFlags;
end;

constructor TProcedureSignatureWrapper.Create(ARecord: TProcedureSignature);
begin
  inherited Create;
  FFlags := ARecord.Flags;
  FCC := ARecord.CC;
  FParamCount := ARecord.ParamCount;
end;

function TProcedureSignatureWrapper.ObjToRec: TProcedureSignature;
begin
  result.Flags := FFlags;
  result.CC := FCC;
  result.ParamCount := FParamCount;
end;

constructor TIntfMethodTableWrapper.Create(ARecord: TIntfMethodTable);
begin
  inherited Create;
  FCount := ARecord.Count;
  FRttiCount := ARecord.RttiCount;
end;

function TIntfMethodTableWrapper.ObjToRec: TIntfMethodTable;
begin
  result.Count := FCount;
  result.RttiCount := FRttiCount;
end;

constructor TIntfMethodEntryWrapper.Create(ARecord: TIntfMethodEntry);
begin
  inherited Create;
  FName := ARecord.Name;
end;

function TIntfMethodEntryWrapper.ObjToRec: TIntfMethodEntry;
begin
  result.Name := FName;
end;

constructor TIntfMethodEntryTailWrapper.Create(ARecord: TIntfMethodEntryTail);
begin
  inherited Create;
  FKind := ARecord.Kind;
  FCC := ARecord.CC;
  FParamCount := ARecord.ParamCount;
end;

function TIntfMethodEntryTailWrapper.ObjToRec: TIntfMethodEntryTail;
begin
  result.Kind := FKind;
  result.CC := FCC;
  result.ParamCount := FParamCount;
end;

constructor TIntfMethodParamWrapper.Create(ARecord: TIntfMethodParam);
begin
  inherited Create;
  FFlags := ARecord.Flags;
  FParamName := ARecord.ParamName;
end;

function TIntfMethodParamWrapper.ObjToRec: TIntfMethodParam;
begin
  result.Flags := FFlags;
  result.ParamName := FParamName;
end;

constructor TIntfMethodParamTailWrapper.Create(ARecord: TIntfMethodParamTail);
begin
  inherited Create;
end;

function TIntfMethodParamTailWrapper.ObjToRec: TIntfMethodParamTail;
begin
end;

constructor TArrayTypeDataWrapper.Create(ARecord: TArrayTypeData);
begin
  inherited Create;
  FSize := ARecord.Size;
  FElCount := ARecord.ElCount;
  FDimCount := ARecord.DimCount;
end;

function TArrayTypeDataWrapper.ObjToRec: TArrayTypeData;
begin
  result.Size := FSize;
  result.ElCount := FElCount;
  result.DimCount := FDimCount;
end;

constructor TRecordTypeFieldWrapper.Create(ARecord: TRecordTypeField);
begin
  inherited Create;
  FFlags := ARecord.Flags;
  FName := ARecord.Name;
end;

function TRecordTypeFieldWrapper.ObjToRec: TRecordTypeField;
begin
  result.Flags := FFlags;
  result.Name := FName;
end;

constructor TTypeDataWrapper.Create(ARecord: TTypeData);
begin
  inherited Create;
  FCodePage := ARecord.CodePage;
  FOrdType := ARecord.OrdType;
  FMinValue := ARecord.MinValue;
  FMaxValue := ARecord.MaxValue;
  FFloatType := ARecord.FloatType;
  FMaxLength := ARecord.MaxLength;
  FClassType := ARecord.ClassType;
  FPropCount := ARecord.PropCount;
  FMethodKind := ARecord.MethodKind;
  FParamCount := ARecord.ParamCount;
  FIntfFlags := ARecord.IntfFlags;
  FGuid := ARecord.Guid;
  FMinInt64Value := ARecord.MinInt64Value;
  FMaxInt64Value := ARecord.MaxInt64Value;
  FelSize := ARecord.elSize;
  FvarType := ARecord.varType;
  FRecSize := ARecord.RecSize;
  FManagedFldCount := ARecord.ManagedFldCount;
end;

function TTypeDataWrapper.ObjToRec: TTypeData;
begin
  result.CodePage := FCodePage;
  result.OrdType := FOrdType;
  result.MinValue := FMinValue;
  result.MaxValue := FMaxValue;
  result.FloatType := FFloatType;
  result.MaxLength := FMaxLength;
  result.ClassType := FClassType;
  result.PropCount := FPropCount;
  result.MethodKind := FMethodKind;
  result.ParamCount := FParamCount;
  result.IntfFlags := FIntfFlags;
  result.Guid := FGuid;
  result.MinInt64Value := FMinInt64Value;
  result.MaxInt64Value := FMaxInt64Value;
  result.elSize := FelSize;
  result.varType := FvarType;
  result.RecSize := FRecSize;
  result.ManagedFldCount := FManagedFldCount;
end;

constructor TPropDataWrapper.Create(ARecord: TPropData);
begin
  inherited Create;
  FPropCount := ARecord.PropCount;
end;

function TPropDataWrapper.ObjToRec: TPropData;
begin
  result.PropCount := FPropCount;
end;

constructor TPropInfoWrapper.Create(ARecord: TPropInfo);
begin
  inherited Create;
  FIndex := ARecord.Index;
  FDefault := ARecord.Default;
  FNameIndex := ARecord.NameIndex;
  FName := ARecord.Name;
end;

function TPropInfoWrapper.ObjToRec: TPropInfo;
begin
  result.Index := FIndex;
  result.Default := FDefault;
  result.NameIndex := FNameIndex;
  result.Name := FName;
end;

constructor TPropDataExWrapper.Create(ARecord: TPropDataEx);
begin
  inherited Create;
  FPropCount := ARecord.PropCount;
end;

function TPropDataExWrapper.ObjToRec: TPropDataEx;
begin
  result.PropCount := FPropCount;
end;

constructor TPropInfoExWrapper.Create(ARecord: TPropInfoEx);
begin
  inherited Create;
  FFlags := ARecord.Flags;
end;

function TPropInfoExWrapper.ObjToRec: TPropInfoEx;
begin
  result.Flags := FFlags;
end;



procedure TatTypInfoLibrary.__TPublishableVariantTypeGetProperty(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TVarData;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TVarDataWrapper) then
  Param0Rec := TVarDataWrapper.Create(Param0);
Param0 := TVarDataWrapper(Param0Rec).ObjToRec;
AResult := TPublishableVariantType(CurrentObject).GetProperty(Param0,TVarDataWrapper(integer(GetInputArg(1))).ObjToRec,GetInputArg(2));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TVarDataWrapper.Create(Param0)));
  end;
end;

procedure TatTypInfoLibrary.__TPublishableVariantTypeSetProperty(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TPublishableVariantType(CurrentObject).SetProperty(TVarDataWrapper(integer(GetInputArg(0))).ObjToRec,GetInputArg(1),TVarDataWrapper(integer(GetInputArg(2))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTypInfoLibrary.__PropType(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TypInfo.PropType(TObject(Integer(GetInputArg(0))),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTypInfoLibrary.__PropIsType(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TypInfo.PropIsType(TObject(Integer(GetInputArg(0))),GetInputArg(1),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTypInfoLibrary.__IsStoredProp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TypInfo.IsStoredProp(TObject(Integer(GetInputArg(0))),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTypInfoLibrary.__IsPublishedProp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TypInfo.IsPublishedProp(TObject(Integer(GetInputArg(0))),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTypInfoLibrary.__GetOrdProp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TypInfo.GetOrdProp(TObject(Integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTypInfoLibrary.__SetOrdProp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TypInfo.SetOrdProp(TObject(Integer(GetInputArg(0))),GetInputArg(1),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatTypInfoLibrary.__GetEnumProp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TypInfo.GetEnumProp(TObject(Integer(GetInputArg(0))),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTypInfoLibrary.__SetEnumProp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TypInfo.SetEnumProp(TObject(Integer(GetInputArg(0))),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatTypInfoLibrary.__GetSetProp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
2: AResult := TypInfo.GetSetProp(TObject(Integer(GetInputArg(0))),GetInputArg(1));
3: AResult := TypInfo.GetSetProp(TObject(Integer(GetInputArg(0))),GetInputArg(1),GetInputArg(2));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTypInfoLibrary.__SetSetProp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TypInfo.SetSetProp(TObject(Integer(GetInputArg(0))),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatTypInfoLibrary.__SetObjectProp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TypInfo.SetObjectProp(TObject(Integer(GetInputArg(0))),GetInputArg(1),TObject(Integer(GetInputArg(2))));
  end;
end;

procedure TatTypInfoLibrary.__GetObjectPropClass(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TypInfo.GetObjectPropClass(TObject(integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTypInfoLibrary.__GetStrProp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TypInfo.GetStrProp(TObject(integer(GetInputArg(0))),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTypInfoLibrary.__SetStrProp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TypInfo.SetStrProp(TObject(integer(GetInputArg(0))),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatTypInfoLibrary.__GetAnsiStrProp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TypInfo.GetAnsiStrProp(TObject(integer(GetInputArg(0))),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTypInfoLibrary.__SetAnsiStrProp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TypInfo.SetAnsiStrProp(TObject(integer(GetInputArg(0))),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatTypInfoLibrary.__GetWideStrProp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TypInfo.GetWideStrProp(TObject(integer(GetInputArg(0))),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTypInfoLibrary.__SetWideStrProp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TypInfo.SetWideStrProp(TObject(integer(GetInputArg(0))),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatTypInfoLibrary.__GetUnicodeStrProp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TypInfo.GetUnicodeStrProp(TObject(integer(GetInputArg(0))),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTypInfoLibrary.__SetUnicodeStrProp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TypInfo.SetUnicodeStrProp(TObject(integer(GetInputArg(0))),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatTypInfoLibrary.__GetFloatProp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TypInfo.GetFloatProp(TObject(integer(GetInputArg(0))),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTypInfoLibrary.__SetFloatProp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TypInfo.SetFloatProp(TObject(integer(GetInputArg(0))),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatTypInfoLibrary.__GetVariantProp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TypInfo.GetVariantProp(TObject(integer(GetInputArg(0))),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTypInfoLibrary.__SetVariantProp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TypInfo.SetVariantProp(TObject(integer(GetInputArg(0))),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatTypInfoLibrary.__GetMethodProp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TMethodWrapper.Create(TypInfo.GetMethodProp(TObject(Integer(GetInputArg(0))),GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTypInfoLibrary.__SetMethodProp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TypInfo.SetMethodProp(TObject(Integer(GetInputArg(0))),GetInputArg(1),TMethodWrapper(integer(GetInputArg(2))).ObjToRec);
  end;
end;

procedure TatTypInfoLibrary.__GetInt64Prop(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TypInfo.GetInt64Prop(TObject(integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTypInfoLibrary.__SetInt64Prop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TypInfo.SetInt64Prop(TObject(integer(GetInputArg(0))),GetInputArg(1),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatTypInfoLibrary.__GetInterfaceProp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TypInfo.GetInterfaceProp(TObject(integer(GetInputArg(0))),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTypInfoLibrary.__SetInterfaceProp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TypInfo.SetInterfaceProp(TObject(integer(GetInputArg(0))),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatTypInfoLibrary.__GetPropValue(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
2: AResult := TypInfo.GetPropValue(TObject(integer(GetInputArg(0))),GetInputArg(1));
3: AResult := TypInfo.GetPropValue(TObject(integer(GetInputArg(0))),GetInputArg(1),GetInputArg(2));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTypInfoLibrary.__SetPropValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TypInfo.SetPropValue(TObject(integer(GetInputArg(0))),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatTypInfoLibrary.__FreeAndNilProperties(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TypInfo.FreeAndNilProperties(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatTypInfoLibrary.__SamePropTypeName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TypInfo.SamePropTypeName(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTypInfoLibrary.__GetDotSep(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TypInfo.DotSep);
  end;
end;

procedure TatTypInfoLibrary.__SetDotSep(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TypInfo.DotSep:=GetInputArg(0);
  end;
end;

procedure TatTypInfoLibrary.Init;
begin
  With Scripter.DefineClass(TPublishableVariantType) do
  begin
    DefineMethod('GetProperty',3,tkVariant,nil,__TPublishableVariantTypeGetProperty,false,0).SetVarArgs([0]);
    DefineMethod('SetProperty',3,tkVariant,nil,__TPublishableVariantTypeSetProperty,false,0);
  end;
  With Scripter.DefineClass(EPropertyError) do
  begin
  end;
  With Scripter.DefineClass(EPropertyConvertError) do
  begin
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('PropType',2,tkEnumeration,nil,__PropType,false,0);
    DefineMethod('PropIsType',3,tkVariant,nil,__PropIsType,false,0);
    DefineMethod('IsStoredProp',2,tkVariant,nil,__IsStoredProp,false,0);
    DefineMethod('IsPublishedProp',2,tkVariant,nil,__IsPublishedProp,false,0);
    DefineMethod('GetOrdProp',2,tkInteger,nil,__GetOrdProp,false,0);
    DefineMethod('SetOrdProp',3,tkNone,nil,__SetOrdProp,false,0);
    DefineMethod('GetEnumProp',2,tkVariant,nil,__GetEnumProp,false,0);
    DefineMethod('SetEnumProp',3,tkNone,nil,__SetEnumProp,false,0);
    DefineMethod('GetSetProp',3,tkVariant,nil,__GetSetProp,false,1);
    DefineMethod('SetSetProp',3,tkNone,nil,__SetSetProp,false,0);
    DefineMethod('SetObjectProp',3,tkNone,nil,__SetObjectProp,false,0);
    DefineMethod('GetObjectPropClass',2,tkVariant,nil,__GetObjectPropClass,false,0);
    DefineMethod('GetStrProp',2,tkVariant,nil,__GetStrProp,false,0);
    DefineMethod('SetStrProp',3,tkNone,nil,__SetStrProp,false,0);
    DefineMethod('GetAnsiStrProp',2,tkVariant,nil,__GetAnsiStrProp,false,0);
    DefineMethod('SetAnsiStrProp',3,tkNone,nil,__SetAnsiStrProp,false,0);
    DefineMethod('GetWideStrProp',2,tkVariant,nil,__GetWideStrProp,false,0);
    DefineMethod('SetWideStrProp',3,tkNone,nil,__SetWideStrProp,false,0);
    DefineMethod('GetUnicodeStrProp',2,tkVariant,nil,__GetUnicodeStrProp,false,0);
    DefineMethod('SetUnicodeStrProp',3,tkNone,nil,__SetUnicodeStrProp,false,0);
    DefineMethod('GetFloatProp',2,tkVariant,nil,__GetFloatProp,false,0);
    DefineMethod('SetFloatProp',3,tkNone,nil,__SetFloatProp,false,0);
    DefineMethod('GetVariantProp',2,tkVariant,nil,__GetVariantProp,false,0);
    DefineMethod('SetVariantProp',3,tkNone,nil,__SetVariantProp,false,0);
    DefineMethod('GetMethodProp',2,tkVariant,nil,__GetMethodProp,false,0);
    DefineMethod('SetMethodProp',3,tkNone,nil,__SetMethodProp,false,0);
    DefineMethod('GetInt64Prop',2,tkVariant,nil,__GetInt64Prop,false,0);
    DefineMethod('SetInt64Prop',3,tkNone,nil,__SetInt64Prop,false,0);
    DefineMethod('GetInterfaceProp',2,tkVariant,nil,__GetInterfaceProp,false,0);
    DefineMethod('SetInterfaceProp',3,tkNone,nil,__SetInterfaceProp,false,0);
    DefineMethod('GetPropValue',3,tkVariant,nil,__GetPropValue,false,1);
    DefineMethod('SetPropValue',3,tkNone,nil,__SetPropValue,false,0);
    DefineMethod('FreeAndNilProperties',1,tkNone,nil,__FreeAndNilProperties,false,0);
    DefineMethod('SamePropTypeName',2,tkVariant,nil,__SamePropTypeName,false,0);
    DefineProp('DotSep',tkVariant,__GetDotSep,__SetDotSep,nil,false,0);
    AddConstant('tkUnknown',tkUnknown);
    AddConstant('tkInteger',tkInteger);
    AddConstant('tkChar',tkChar);
    AddConstant('tkEnumeration',tkEnumeration);
    AddConstant('tkFloat',tkFloat);
    AddConstant('tkString',tkString);
    AddConstant('tkSet',tkSet);
    AddConstant('tkClass',tkClass);
    AddConstant('tkMethod',tkMethod);
    AddConstant('tkWChar',tkWChar);
    AddConstant('tkLString',tkLString);
    AddConstant('tkWString',tkWString);
    AddConstant('tkVariant',tkVariant);
    AddConstant('tkArray',tkArray);
    AddConstant('tkRecord',tkRecord);
    AddConstant('tkInterface',tkInterface);
    AddConstant('tkInt64',tkInt64);
    AddConstant('tkDynArray',tkDynArray);
    AddConstant('tkUString',tkUString);
    AddConstant('tkClassRef',tkClassRef);
    AddConstant('tkPointer',tkPointer);
    AddConstant('tkProcedure',tkProcedure);
    AddConstant('otSByte',otSByte);
    AddConstant('otUByte',otUByte);
    AddConstant('otSWord',otSWord);
    AddConstant('otUWord',otUWord);
    AddConstant('otSLong',otSLong);
    AddConstant('otULong',otULong);
    AddConstant('ftSingle',ftSingle);
    AddConstant('ftDouble',ftDouble);
    AddConstant('ftExtended',ftExtended);
    AddConstant('ftComp',ftComp);
    AddConstant('ftCurr',ftCurr);
    AddConstant('mvPrivate',mvPrivate);
    AddConstant('mvProtected',mvProtected);
    AddConstant('mvPublic',mvPublic);
    AddConstant('mvPublished',mvPublished);
    AddConstant('mkProcedure',mkProcedure);
    AddConstant('mkFunction',mkFunction);
    AddConstant('mkConstructor',mkConstructor);
    AddConstant('mkDestructor',mkDestructor);
    AddConstant('mkClassProcedure',mkClassProcedure);
    AddConstant('mkClassFunction',mkClassFunction);
    AddConstant('mkClassConstructor',mkClassConstructor);
    AddConstant('mkClassDestructor',mkClassDestructor);
    AddConstant('mkOperatorOverload',mkOperatorOverload);
    AddConstant('mkSafeProcedure',mkSafeProcedure);
    AddConstant('mkSafeFunction',mkSafeFunction);
    AddConstant('pfVar',pfVar);
    AddConstant('pfConst',pfConst);
    AddConstant('pfArray',pfArray);
    AddConstant('pfAddress',pfAddress);
    AddConstant('pfReference',pfReference);
    AddConstant('pfOut',pfOut);
    AddConstant('pfResult',pfResult);
    AddConstant('ifHasGuid',ifHasGuid);
    AddConstant('ifDispInterface',ifDispInterface);
    AddConstant('ifDispatch',ifDispatch);
    AddConstant('ccReg',ccReg);
    AddConstant('ccCdecl',ccCdecl);
    AddConstant('ccPascal',ccPascal);
    AddConstant('ccStdCall',ccStdCall);
    AddConstant('ccSafeCall',ccSafeCall);
    AddConstant('tkAny',IntFromConstSet(tkAny));
    AddConstant('tkMethods',IntFromConstSet(tkMethods));
    AddConstant('tkProperties',IntFromConstSet(tkProperties));
  end;
end;

class function TatTypInfoLibrary.LibraryName: string;
begin
  result := 'TypInfo';
end;

initialization
  RegisterScripterLibrary(TatTypInfoLibrary, True);

{$WARNINGS ON}

end.

