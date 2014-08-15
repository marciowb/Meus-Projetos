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
unit ap_ConvUtils;

interface

uses
  Windows,
  SysUtils,
  Math,
  Types,
  ConvUtils,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatConvUtilsLibrary = class(TatScripterLibrary)
    procedure __TConvTypeInfoCreate(AMachine: TatVirtualMachine);
    procedure __TConvTypeInfoToCommon(AMachine: TatVirtualMachine);
    procedure __TConvTypeInfoFromCommon(AMachine: TatVirtualMachine);
    procedure __GetTConvTypeInfoConvFamily(AMachine: TatVirtualMachine);
    procedure __GetTConvTypeInfoConvType(AMachine: TatVirtualMachine);
    procedure __GetTConvTypeInfoDescription(AMachine: TatVirtualMachine);
    procedure __TConvTypeFactorCreate(AMachine: TatVirtualMachine);
    procedure __TConvTypeFactorToCommon(AMachine: TatVirtualMachine);
    procedure __TConvTypeFactorFromCommon(AMachine: TatVirtualMachine);
    procedure __TConvTypeProcsToCommon(AMachine: TatVirtualMachine);
    procedure __TConvTypeProcsFromCommon(AMachine: TatVirtualMachine);
    procedure __Convert(AMachine: TatVirtualMachine);
    procedure __ConvertFrom(AMachine: TatVirtualMachine);
    procedure __ConvertTo(AMachine: TatVirtualMachine);
    procedure __ConvUnitAdd(AMachine: TatVirtualMachine);
    procedure __ConvUnitDiff(AMachine: TatVirtualMachine);
    procedure __ConvUnitInc(AMachine: TatVirtualMachine);
    procedure __ConvUnitDec(AMachine: TatVirtualMachine);
    procedure __ConvUnitWithinPrevious(AMachine: TatVirtualMachine);
    procedure __ConvUnitWithinNext(AMachine: TatVirtualMachine);
    procedure __ConvUnitCompareValue(AMachine: TatVirtualMachine);
    procedure __ConvUnitSameValue(AMachine: TatVirtualMachine);
    procedure __RegisterConversionType(AMachine: TatVirtualMachine);
    procedure __UnregisterConversionType(AMachine: TatVirtualMachine);
    procedure __RegisterConversionFamily(AMachine: TatVirtualMachine);
    procedure __UnregisterConversionFamily(AMachine: TatVirtualMachine);
    procedure __CompatibleConversionTypes(AMachine: TatVirtualMachine);
    procedure __CompatibleConversionType(AMachine: TatVirtualMachine);
    procedure __StrToConvUnit(AMachine: TatVirtualMachine);
    procedure __TryStrToConvUnit(AMachine: TatVirtualMachine);
    procedure __ConvUnitToStr(AMachine: TatVirtualMachine);
    procedure __ConvTypeToDescription(AMachine: TatVirtualMachine);
    procedure __ConvFamilyToDescription(AMachine: TatVirtualMachine);
    procedure __DescriptionToConvType(AMachine: TatVirtualMachine);
    procedure __DescriptionToConvFamily(AMachine: TatVirtualMachine);
    procedure __ConvTypeToFamily(AMachine: TatVirtualMachine);
    procedure __TryConvTypeToFamily(AMachine: TatVirtualMachine);
    procedure __RaiseConversionError(AMachine: TatVirtualMachine);
    procedure __RaiseConversionRegError(AMachine: TatVirtualMachine);
    procedure __GetCIllegalConvFamily(AMachine: TatVirtualMachine);
    procedure __GetCIllegalConvType(AMachine: TatVirtualMachine);
    procedure __GetGConvUnitToStrFmt(AMachine: TatVirtualMachine);
    procedure __SetGConvUnitToStrFmt(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  EConversionErrorClass = class of EConversionError;
  TConvTypeInfoClass = class of TConvTypeInfo;
  TConvTypeFactorClass = class of TConvTypeFactor;
  TConvTypeProcsClass = class of TConvTypeProcs;



implementation



procedure TatConvUtilsLibrary.__TConvTypeInfoCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TConvTypeInfoClass(CurrentClass.ClassRef).Create(VarToInteger(GetInputArg(0)),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatConvUtilsLibrary.__TConvTypeInfoToCommon(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TConvTypeInfo(CurrentObject).ToCommon(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatConvUtilsLibrary.__TConvTypeInfoFromCommon(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TConvTypeInfo(CurrentObject).FromCommon(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatConvUtilsLibrary.__GetTConvTypeInfoConvFamily(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TConvTypeInfo(CurrentObject).ConvFamily));
  end;
end;

procedure TatConvUtilsLibrary.__GetTConvTypeInfoConvType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TConvTypeInfo(CurrentObject).ConvType));
  end;
end;

procedure TatConvUtilsLibrary.__GetTConvTypeInfoDescription(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TConvTypeInfo(CurrentObject).Description);
  end;
end;

procedure TatConvUtilsLibrary.__TConvTypeFactorCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TConvTypeFactorClass(CurrentClass.ClassRef).Create(VarToInteger(GetInputArg(0)),GetInputArg(1),GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatConvUtilsLibrary.__TConvTypeFactorToCommon(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TConvTypeFactor(CurrentObject).ToCommon(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatConvUtilsLibrary.__TConvTypeFactorFromCommon(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TConvTypeFactor(CurrentObject).FromCommon(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatConvUtilsLibrary.__TConvTypeProcsToCommon(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TConvTypeProcs(CurrentObject).ToCommon(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatConvUtilsLibrary.__TConvTypeProcsFromCommon(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TConvTypeProcs(CurrentObject).FromCommon(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatConvUtilsLibrary.__Convert(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ConvUtils.Convert(GetInputArg(0),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatConvUtilsLibrary.__ConvertFrom(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ConvUtils.ConvertFrom(VarToInteger(GetInputArg(0)),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatConvUtilsLibrary.__ConvertTo(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ConvUtils.ConvertTo(GetInputArg(0),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatConvUtilsLibrary.__ConvUnitAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ConvUtils.ConvUnitAdd(GetInputArg(0),VarToInteger(GetInputArg(1)),GetInputArg(2),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatConvUtilsLibrary.__ConvUnitDiff(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ConvUtils.ConvUnitDiff(GetInputArg(0),VarToInteger(GetInputArg(1)),GetInputArg(2),VarToInteger(GetInputArg(3)),VarToInteger(GetInputArg(4)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatConvUtilsLibrary.__ConvUnitInc(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ConvUtils.ConvUnitInc(GetInputArg(0),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatConvUtilsLibrary.__ConvUnitDec(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ConvUtils.ConvUnitDec(GetInputArg(0),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatConvUtilsLibrary.__ConvUnitWithinPrevious(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ConvUtils.ConvUnitWithinPrevious(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2)),GetInputArg(3),VarToInteger(GetInputArg(4)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatConvUtilsLibrary.__ConvUnitWithinNext(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ConvUtils.ConvUnitWithinNext(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2)),GetInputArg(3),VarToInteger(GetInputArg(4)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatConvUtilsLibrary.__ConvUnitCompareValue(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ConvUtils.ConvUnitCompareValue(GetInputArg(0),VarToInteger(GetInputArg(1)),GetInputArg(2),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatConvUtilsLibrary.__ConvUnitSameValue(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ConvUtils.ConvUnitSameValue(GetInputArg(0),VarToInteger(GetInputArg(1)),GetInputArg(2),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatConvUtilsLibrary.__RegisterConversionType(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ConvUtils.RegisterConversionType(VarToInteger(GetInputArg(0)),GetInputArg(1),GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatConvUtilsLibrary.__UnregisterConversionType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ConvUtils.UnregisterConversionType(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatConvUtilsLibrary.__RegisterConversionFamily(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ConvUtils.RegisterConversionFamily(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatConvUtilsLibrary.__UnregisterConversionFamily(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ConvUtils.UnregisterConversionFamily(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatConvUtilsLibrary.__CompatibleConversionTypes(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ConvUtils.CompatibleConversionTypes(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatConvUtilsLibrary.__CompatibleConversionType(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ConvUtils.CompatibleConversionType(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatConvUtilsLibrary.__StrToConvUnit(AMachine: TatVirtualMachine);
  var
  Param1: TConvType;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := ConvUtils.StrToConvUnit(GetInputArg(0),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatConvUtilsLibrary.__TryStrToConvUnit(AMachine: TatVirtualMachine);
  var
  Param1: Double;
  Param2: TConvType;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
Param2 := VarToInteger(GetInputArg(2));
AResult := ConvUtils.TryStrToConvUnit(GetInputArg(0),Param1,Param2);
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatConvUtilsLibrary.__ConvUnitToStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ConvUtils.ConvUnitToStr(GetInputArg(0),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatConvUtilsLibrary.__ConvTypeToDescription(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ConvUtils.ConvTypeToDescription(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatConvUtilsLibrary.__ConvFamilyToDescription(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ConvUtils.ConvFamilyToDescription(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatConvUtilsLibrary.__DescriptionToConvType(AMachine: TatVirtualMachine);
  var
  Param1: TConvType;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := ConvUtils.DescriptionToConvType(GetInputArg(0),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatConvUtilsLibrary.__DescriptionToConvFamily(AMachine: TatVirtualMachine);
  var
  Param1: TConvFamily;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := ConvUtils.DescriptionToConvFamily(GetInputArg(0),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatConvUtilsLibrary.__ConvTypeToFamily(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ConvUtils.ConvTypeToFamily(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatConvUtilsLibrary.__TryConvTypeToFamily(AMachine: TatVirtualMachine);
  var
  Param1: TConvFamily;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := ConvUtils.TryConvTypeToFamily(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatConvUtilsLibrary.__RaiseConversionError(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ConvUtils.RaiseConversionError(GetInputArg(0));
  end;
end;

procedure TatConvUtilsLibrary.__RaiseConversionRegError(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ConvUtils.RaiseConversionRegError(VarToInteger(GetInputArg(0)),GetInputArg(1));
  end;
end;

procedure TatConvUtilsLibrary.__GetCIllegalConvFamily(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(ConvUtils.CIllegalConvFamily));
  end;
end;

procedure TatConvUtilsLibrary.__GetCIllegalConvType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(ConvUtils.CIllegalConvType));
  end;
end;

procedure TatConvUtilsLibrary.__GetGConvUnitToStrFmt(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(ConvUtils.GConvUnitToStrFmt);
  end;
end;

procedure TatConvUtilsLibrary.__SetGConvUnitToStrFmt(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ConvUtils.GConvUnitToStrFmt:=GetInputArg(0);
  end;
end;

procedure TatConvUtilsLibrary.Init;
begin
  With Scripter.DefineClass(EConversionError) do
  begin
  end;
  With Scripter.DefineClass(TConvTypeInfo) do
  begin
    DefineMethod('Create',2,tkClass,TConvTypeInfo,__TConvTypeInfoCreate,true,0);
    DefineMethod('ToCommon',1,tkVariant,nil,__TConvTypeInfoToCommon,false,0);
    DefineMethod('FromCommon',1,tkVariant,nil,__TConvTypeInfoFromCommon,false,0);
    DefineProp('ConvFamily',tkInteger,__GetTConvTypeInfoConvFamily,nil,nil,false,0);
    DefineProp('ConvType',tkInteger,__GetTConvTypeInfoConvType,nil,nil,false,0);
    DefineProp('Description',tkVariant,__GetTConvTypeInfoDescription,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TConvTypeFactor) do
  begin
    DefineMethod('Create',3,tkClass,TConvTypeFactor,__TConvTypeFactorCreate,true,0);
    DefineMethod('ToCommon',1,tkVariant,nil,__TConvTypeFactorToCommon,false,0);
    DefineMethod('FromCommon',1,tkVariant,nil,__TConvTypeFactorFromCommon,false,0);
  end;
  With Scripter.DefineClass(TConvTypeProcs) do
  begin
    DefineMethod('ToCommon',1,tkVariant,nil,__TConvTypeProcsToCommon,false,0);
    DefineMethod('FromCommon',1,tkVariant,nil,__TConvTypeProcsFromCommon,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('Convert',3,tkVariant,nil,__Convert,false,0);
    DefineMethod('ConvertFrom',2,tkVariant,nil,__ConvertFrom,false,0);
    DefineMethod('ConvertTo',2,tkVariant,nil,__ConvertTo,false,0);
    DefineMethod('ConvUnitAdd',5,tkVariant,nil,__ConvUnitAdd,false,0);
    DefineMethod('ConvUnitDiff',5,tkVariant,nil,__ConvUnitDiff,false,0);
    DefineMethod('ConvUnitInc',3,tkVariant,nil,__ConvUnitInc,false,0);
    DefineMethod('ConvUnitDec',3,tkVariant,nil,__ConvUnitDec,false,0);
    DefineMethod('ConvUnitWithinPrevious',5,tkVariant,nil,__ConvUnitWithinPrevious,false,0);
    DefineMethod('ConvUnitWithinNext',5,tkVariant,nil,__ConvUnitWithinNext,false,0);
    DefineMethod('ConvUnitCompareValue',4,tkEnumeration,nil,__ConvUnitCompareValue,false,0);
    DefineMethod('ConvUnitSameValue',4,tkVariant,nil,__ConvUnitSameValue,false,0);
    DefineMethod('RegisterConversionType',3,tkInteger,nil,__RegisterConversionType,false,0);
    DefineMethod('UnregisterConversionType',1,tkNone,nil,__UnregisterConversionType,false,0);
    DefineMethod('RegisterConversionFamily',1,tkInteger,nil,__RegisterConversionFamily,false,0);
    DefineMethod('UnregisterConversionFamily',1,tkNone,nil,__UnregisterConversionFamily,false,0);
    DefineMethod('CompatibleConversionTypes',2,tkVariant,nil,__CompatibleConversionTypes,false,0);
    DefineMethod('CompatibleConversionType',2,tkVariant,nil,__CompatibleConversionType,false,0);
    DefineMethod('StrToConvUnit',2,tkVariant,nil,__StrToConvUnit,false,0).SetVarArgs([1]);
    DefineMethod('TryStrToConvUnit',3,tkVariant,nil,__TryStrToConvUnit,false,0).SetVarArgs([1,2]);
    DefineMethod('ConvUnitToStr',2,tkVariant,nil,__ConvUnitToStr,false,0);
    DefineMethod('ConvTypeToDescription',1,tkVariant,nil,__ConvTypeToDescription,false,0);
    DefineMethod('ConvFamilyToDescription',1,tkVariant,nil,__ConvFamilyToDescription,false,0);
    DefineMethod('DescriptionToConvType',2,tkVariant,nil,__DescriptionToConvType,false,0).SetVarArgs([1]);
    DefineMethod('DescriptionToConvFamily',2,tkVariant,nil,__DescriptionToConvFamily,false,0).SetVarArgs([1]);
    DefineMethod('ConvTypeToFamily',1,tkInteger,nil,__ConvTypeToFamily,false,0);
    DefineMethod('TryConvTypeToFamily',2,tkVariant,nil,__TryConvTypeToFamily,false,0).SetVarArgs([1]);
    DefineMethod('RaiseConversionError',1,tkNone,nil,__RaiseConversionError,false,0);
    DefineMethod('RaiseConversionRegError',2,tkNone,nil,__RaiseConversionRegError,false,0);
    DefineProp('CIllegalConvFamily',tkInteger,__GetCIllegalConvFamily,nil,nil,false,0);
    DefineProp('CIllegalConvType',tkInteger,__GetCIllegalConvType,nil,nil,false,0);
    DefineProp('GConvUnitToStrFmt',tkVariant,__GetGConvUnitToStrFmt,__SetGConvUnitToStrFmt,nil,false,0);
  end;
end;

class function TatConvUtilsLibrary.LibraryName: string;
begin
  result := 'ConvUtils';
end;

initialization
  RegisterScripterLibrary(TatConvUtilsLibrary, True);

{$WARNINGS ON}

end.

