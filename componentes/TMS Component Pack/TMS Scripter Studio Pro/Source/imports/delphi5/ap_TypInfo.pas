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
  SysUtils,
  TypInfo,
  ap_SysUtils,
  atScript;

{$WARNINGS OFF}

type
  TatTypInfoLibrary = class(TatScripterLibrary)
    procedure __GetPropValue(AMachine: TatVirtualMachine);
    procedure __SetPropValue(AMachine: TatVirtualMachine);
    procedure __GetDotSep(AMachine: TatVirtualMachine);
    procedure __SetDotSep(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

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
  With Scripter.DefineClass(EPropertyError) do
  begin
  end;
  With Scripter.DefineClass(EPropertyConvertError) do
  begin
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('GetPropValue',3,tkVariant,nil,__GetPropValue,false,1);
    DefineMethod('SetPropValue',3,tkNone,nil,__SetPropValue,false,0);
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

