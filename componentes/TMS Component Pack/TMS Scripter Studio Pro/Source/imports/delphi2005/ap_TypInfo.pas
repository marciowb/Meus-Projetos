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
    procedure __GetStrProp(AMachine: TatVirtualMachine);
    procedure __SetStrProp(AMachine: TatVirtualMachine);
    procedure __GetWideStrProp(AMachine: TatVirtualMachine);
    procedure __SetWideStrProp(AMachine: TatVirtualMachine);
    procedure __GetFloatProp(AMachine: TatVirtualMachine);
    procedure __SetFloatProp(AMachine: TatVirtualMachine);
    procedure __GetVariantProp(AMachine: TatVirtualMachine);
    procedure __SetVariantProp(AMachine: TatVirtualMachine);
    procedure __GetMethodProp(AMachine: TatVirtualMachine);
    procedure __SetMethodProp(AMachine: TatVirtualMachine);
    procedure __GetInt64Prop(AMachine: TatVirtualMachine);
    procedure __SetInt64Prop(AMachine: TatVirtualMachine);
    procedure __GetPropValue(AMachine: TatVirtualMachine);
    procedure __SetPropValue(AMachine: TatVirtualMachine);
    procedure __FreeAndNilProperties(AMachine: TatVirtualMachine);
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
  
  TTypeDataWrapper = class(TatRecordWrapper)
  private
    FOrdType: TOrdType;
    FMinValue: Longint;
    FMaxValue: Longint;
    FFloatType: TFloatType;
    FMaxLength: Byte;
    FPropCount: SmallInt;
    FMethodKind: TMethodKind;
    FParamCount: Byte;
    FIntfFlags: TIntfFlagsBase;
    FMinInt64Value: Int64;
    FMaxInt64Value: Int64;
    FelSize: Longint;
    FvarType: Integer;
  public
    constructor Create(ARecord: TTypeData);
    function ObjToRec: TTypeData;
  published
    property OrdType: TOrdType read FOrdType write FOrdType;
    property MinValue: Longint read FMinValue write FMinValue;
    property MaxValue: Longint read FMaxValue write FMaxValue;
    property FloatType: TFloatType read FFloatType write FFloatType;
    property MaxLength: Byte read FMaxLength write FMaxLength;
    property PropCount: SmallInt read FPropCount write FPropCount;
    property MethodKind: TMethodKind read FMethodKind write FMethodKind;
    property ParamCount: Byte read FParamCount write FParamCount;
    property IntfFlags: TIntfFlagsBase read FIntfFlags write FIntfFlags;
    property MinInt64Value: Int64 read FMinInt64Value write FMinInt64Value;
    property MaxInt64Value: Int64 read FMaxInt64Value write FMaxInt64Value;
    property elSize: Longint read FelSize write FelSize;
    property varType: Integer read FvarType write FvarType;
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

constructor TTypeDataWrapper.Create(ARecord: TTypeData);
begin
  inherited Create;
  FOrdType := ARecord.OrdType;
  FMinValue := ARecord.MinValue;
  FMaxValue := ARecord.MaxValue;
  FFloatType := ARecord.FloatType;
  FMaxLength := ARecord.MaxLength;
  FPropCount := ARecord.PropCount;
  FMethodKind := ARecord.MethodKind;
  FParamCount := ARecord.ParamCount;
  FIntfFlags := ARecord.IntfFlags;
  FMinInt64Value := ARecord.MinInt64Value;
  FMaxInt64Value := ARecord.MaxInt64Value;
  FelSize := ARecord.elSize;
  FvarType := ARecord.varType;
end;

function TTypeDataWrapper.ObjToRec: TTypeData;
begin
  result.OrdType := FOrdType;
  result.MinValue := FMinValue;
  result.MaxValue := FMaxValue;
  result.FloatType := FFloatType;
  result.MaxLength := FMaxLength;
  result.PropCount := FPropCount;
  result.MethodKind := FMethodKind;
  result.ParamCount := FParamCount;
  result.IntfFlags := FIntfFlags;
  result.MinInt64Value := FMinInt64Value;
  result.MaxInt64Value := FMaxInt64Value;
  result.elSize := FelSize;
  result.varType := FvarType;
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

procedure TatTypInfoLibrary.__GetStrProp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TypInfo.GetStrProp(TObject(Integer(GetInputArg(0))),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTypInfoLibrary.__SetStrProp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TypInfo.SetStrProp(TObject(Integer(GetInputArg(0))),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatTypInfoLibrary.__GetWideStrProp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TypInfo.GetWideStrProp(TObject(Integer(GetInputArg(0))),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTypInfoLibrary.__SetWideStrProp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TypInfo.SetWideStrProp(TObject(Integer(GetInputArg(0))),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatTypInfoLibrary.__GetFloatProp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TypInfo.GetFloatProp(TObject(Integer(GetInputArg(0))),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTypInfoLibrary.__SetFloatProp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TypInfo.SetFloatProp(TObject(Integer(GetInputArg(0))),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatTypInfoLibrary.__GetVariantProp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TypInfo.GetVariantProp(TObject(Integer(GetInputArg(0))),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTypInfoLibrary.__SetVariantProp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TypInfo.SetVariantProp(TObject(Integer(GetInputArg(0))),GetInputArg(1),GetInputArg(2));
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
AResult := Integer(TypInfo.GetInt64Prop(TObject(Integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTypInfoLibrary.__SetInt64Prop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TypInfo.SetInt64Prop(TObject(Integer(GetInputArg(0))),GetInputArg(1),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatTypInfoLibrary.__GetPropValue(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
2: AResult := TypInfo.GetPropValue(TObject(Integer(GetInputArg(0))),GetInputArg(1));
3: AResult := TypInfo.GetPropValue(TObject(Integer(GetInputArg(0))),GetInputArg(1),GetInputArg(2));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTypInfoLibrary.__SetPropValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TypInfo.SetPropValue(TObject(Integer(GetInputArg(0))),GetInputArg(1),GetInputArg(2));
  end;
end;

procedure TatTypInfoLibrary.__FreeAndNilProperties(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TypInfo.FreeAndNilProperties(TObject(Integer(GetInputArg(0))));
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
    DefineMethod('GetStrProp',2,tkVariant,nil,__GetStrProp,false,0);
    DefineMethod('SetStrProp',3,tkNone,nil,__SetStrProp,false,0);
    DefineMethod('GetWideStrProp',2,tkVariant,nil,__GetWideStrProp,false,0);
    DefineMethod('SetWideStrProp',3,tkNone,nil,__SetWideStrProp,false,0);
    DefineMethod('GetFloatProp',2,tkVariant,nil,__GetFloatProp,false,0);
    DefineMethod('SetFloatProp',3,tkNone,nil,__SetFloatProp,false,0);
    DefineMethod('GetVariantProp',2,tkVariant,nil,__GetVariantProp,false,0);
    DefineMethod('SetVariantProp',3,tkNone,nil,__SetVariantProp,false,0);
    DefineMethod('GetMethodProp',2,tkVariant,nil,__GetMethodProp,false,0);
    DefineMethod('SetMethodProp',3,tkNone,nil,__SetMethodProp,false,0);
    DefineMethod('GetInt64Prop',2,tkVariant,nil,__GetInt64Prop,false,0);
    DefineMethod('SetInt64Prop',3,tkNone,nil,__SetInt64Prop,false,0);
    DefineMethod('GetPropValue',3,tkVariant,nil,__GetPropValue,false,1);
    DefineMethod('SetPropValue',3,tkNone,nil,__SetPropValue,false,0);
    DefineMethod('FreeAndNilProperties',1,tkNone,nil,__FreeAndNilProperties,false,0);
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
    AddConstant('mkProcedure',mkProcedure);
    AddConstant('mkFunction',mkFunction);
    AddConstant('mkConstructor',mkConstructor);
    AddConstant('mkDestructor',mkDestructor);
    AddConstant('mkClassProcedure',mkClassProcedure);
    AddConstant('mkClassFunction',mkClassFunction);
    AddConstant('mkClassConstructor',mkClassConstructor);
    AddConstant('mkOperatorOverload',mkOperatorOverload);
    AddConstant('mkSafeProcedure',mkSafeProcedure);
    AddConstant('mkSafeFunction',mkSafeFunction);
    AddConstant('pfVar',pfVar);
    AddConstant('pfConst',pfConst);
    AddConstant('pfArray',pfArray);
    AddConstant('pfAddress',pfAddress);
    AddConstant('pfReference',pfReference);
    AddConstant('pfOut',pfOut);
    AddConstant('ifHasGuid',ifHasGuid);
    AddConstant('ifDispInterface',ifDispInterface);
    AddConstant('ifDispatch',ifDispatch);
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

