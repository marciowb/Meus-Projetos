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
unit ap_Variants;

interface

uses
  Types,
  SysUtils,
  Variants,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatVariantsLibrary = class(TatScripterLibrary)
    procedure __TCustomVariantTypeCreate(AMachine: TatVirtualMachine);
    procedure __TCustomVariantTypeDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomVariantTypeIsClear(AMachine: TatVirtualMachine);
    procedure __TCustomVariantTypeCast(AMachine: TatVirtualMachine);
    procedure __TCustomVariantTypeCastTo(AMachine: TatVirtualMachine);
    procedure __TCustomVariantTypeCastToOle(AMachine: TatVirtualMachine);
    procedure __TCustomVariantTypeClear(AMachine: TatVirtualMachine);
    procedure __TCustomVariantTypeCopy(AMachine: TatVirtualMachine);
    procedure __TCustomVariantTypeBinaryOp(AMachine: TatVirtualMachine);
    procedure __TCustomVariantTypeUnaryOp(AMachine: TatVirtualMachine);
    procedure __TCustomVariantTypeCompareOp(AMachine: TatVirtualMachine);
    procedure __TCustomVariantTypeCompare(AMachine: TatVirtualMachine);
    procedure __GetTCustomVariantTypeVarType(AMachine: TatVirtualMachine);
    procedure __TInvokeableVariantTypeGetProperty(AMachine: TatVirtualMachine);
    procedure __TInvokeableVariantTypeSetProperty(AMachine: TatVirtualMachine);
    procedure __VarType(AMachine: TatVirtualMachine);
    procedure __VarAsType(AMachine: TatVirtualMachine);
    procedure __VarIsType(AMachine: TatVirtualMachine);
    procedure __VarIsByRef(AMachine: TatVirtualMachine);
    procedure __VarIsEmpty(AMachine: TatVirtualMachine);
    procedure __VarCheckEmpty(AMachine: TatVirtualMachine);
    procedure __VarIsNull(AMachine: TatVirtualMachine);
    procedure __VarIsClear(AMachine: TatVirtualMachine);
    procedure __VarIsCustom(AMachine: TatVirtualMachine);
    procedure __VarIsOrdinal(AMachine: TatVirtualMachine);
    procedure __VarIsFloat(AMachine: TatVirtualMachine);
    procedure __VarIsNumeric(AMachine: TatVirtualMachine);
    procedure __VarIsStr(AMachine: TatVirtualMachine);
    procedure __VarToStr(AMachine: TatVirtualMachine);
    procedure __VarToStrDef(AMachine: TatVirtualMachine);
    procedure __VarToWideStr(AMachine: TatVirtualMachine);
    procedure __VarToWideStrDef(AMachine: TatVirtualMachine);
    procedure __VarToDateTime(AMachine: TatVirtualMachine);
    procedure __VarFromDateTime(AMachine: TatVirtualMachine);
    procedure __VarInRange(AMachine: TatVirtualMachine);
    procedure __VarEnsureRange(AMachine: TatVirtualMachine);
    procedure __VarSameValue(AMachine: TatVirtualMachine);
    procedure __VarCompareValue(AMachine: TatVirtualMachine);
    procedure __VarIsEmptyParam(AMachine: TatVirtualMachine);
    procedure __VarIsError(AMachine: TatVirtualMachine);
    procedure __VarAsError(AMachine: TatVirtualMachine);
    procedure __VarSupports(AMachine: TatVirtualMachine);
    procedure __VarCopyNoInd(AMachine: TatVirtualMachine);
    procedure __VarIsArray(AMachine: TatVirtualMachine);
    procedure __VarArrayRef(AMachine: TatVirtualMachine);
    procedure __VarTypeIsValidArrayType(AMachine: TatVirtualMachine);
    procedure __VarTypeIsValidElementType(AMachine: TatVirtualMachine);
    procedure __VarArrayDimCount(AMachine: TatVirtualMachine);
    procedure __VarArrayLowBound(AMachine: TatVirtualMachine);
    procedure __VarArrayHighBound(AMachine: TatVirtualMachine);
    procedure __VarArrayUnlock(AMachine: TatVirtualMachine);
    procedure __Unassigned(AMachine: TatVirtualMachine);
    procedure __Null(AMachine: TatVirtualMachine);
    procedure __FindCustomVariantType(AMachine: TatVirtualMachine);
    procedure __VarCastError(AMachine: TatVirtualMachine);
    procedure __VarInvalidOp(AMachine: TatVirtualMachine);
    procedure __VarInvalidNullOp(AMachine: TatVirtualMachine);
    procedure __VarOverflowError(AMachine: TatVirtualMachine);
    procedure __VarRangeCheckError(AMachine: TatVirtualMachine);
    procedure __VarArrayCreateError(AMachine: TatVirtualMachine);
    procedure __VarResultCheck(AMachine: TatVirtualMachine);
    procedure __HandleConversionException(AMachine: TatVirtualMachine);
    procedure __VarTypeAsText(AMachine: TatVirtualMachine);
    procedure __GetEmptyParam(AMachine: TatVirtualMachine);
    procedure __SetEmptyParam(AMachine: TatVirtualMachine);
    procedure __GetNullEqualityRule(AMachine: TatVirtualMachine);
    procedure __SetNullEqualityRule(AMachine: TatVirtualMachine);
    procedure __GetNullMagnitudeRule(AMachine: TatVirtualMachine);
    procedure __SetNullMagnitudeRule(AMachine: TatVirtualMachine);
    procedure __GetNullStrictConvert(AMachine: TatVirtualMachine);
    procedure __SetNullStrictConvert(AMachine: TatVirtualMachine);
    procedure __GetNullAsStringValue(AMachine: TatVirtualMachine);
    procedure __SetNullAsStringValue(AMachine: TatVirtualMachine);
    procedure __GetPackVarCreation(AMachine: TatVirtualMachine);
    procedure __SetPackVarCreation(AMachine: TatVirtualMachine);
    procedure __GetBooleanToStringRule(AMachine: TatVirtualMachine);
    procedure __SetBooleanToStringRule(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TCustomVariantTypeClass = class of TCustomVariantType;
  TInvokeableVariantTypeClass = class of TInvokeableVariantType;
  EVariantInvalidOpErrorClass = class of EVariantInvalidOpError;
  EVariantTypeCastErrorClass = class of EVariantTypeCastError;
  EVariantOverflowErrorClass = class of EVariantOverflowError;
  EVariantInvalidArgErrorClass = class of EVariantInvalidArgError;
  EVariantBadVarTypeErrorClass = class of EVariantBadVarTypeError;
  EVariantBadIndexErrorClass = class of EVariantBadIndexError;
  EVariantArrayLockedErrorClass = class of EVariantArrayLockedError;
  EVariantNotAnArrayErrorClass = class of EVariantNotAnArrayError;
  EVariantArrayCreateErrorClass = class of EVariantArrayCreateError;
  EVariantNotImplErrorClass = class of EVariantNotImplError;
  EVariantOutOfMemoryErrorClass = class of EVariantOutOfMemoryError;
  EVariantUnexpectedErrorClass = class of EVariantUnexpectedError;
  EVariantDispatchErrorClass = class of EVariantDispatchError;
  EVariantRangeCheckErrorClass = class of EVariantRangeCheckError;
  EVariantInvalidNullOpErrorClass = class of EVariantInvalidNullOpError;



implementation



procedure TatVariantsLibrary.__TCustomVariantTypeCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomVariantTypeClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__TCustomVariantTypeDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomVariantType(CurrentObject).Destroy;
  end;
end;

procedure TatVariantsLibrary.__TCustomVariantTypeIsClear(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomVariantType(CurrentObject).IsClear(TVarDataWrapper(integer(GetInputArg(0))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__TCustomVariantTypeCast(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TVarData;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TVarDataWrapper) then 
  Param0Rec := TVarDataWrapper.Create(Param0);
Param0 := TVarDataWrapper(Param0Rec).ObjToRec;
    TCustomVariantType(CurrentObject).Cast(Param0,TVarDataWrapper(integer(GetInputArg(1))).ObjToRec);
    SetInputArg(0,integer(TVarDataWrapper.Create(Param0)));
  end;
end;

procedure TatVariantsLibrary.__TCustomVariantTypeCastTo(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TVarData;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TVarDataWrapper) then 
  Param0Rec := TVarDataWrapper.Create(Param0);
Param0 := TVarDataWrapper(Param0Rec).ObjToRec;
    TCustomVariantType(CurrentObject).CastTo(Param0,TVarDataWrapper(integer(GetInputArg(1))).ObjToRec,VarToInteger(GetInputArg(2)));
    SetInputArg(0,integer(TVarDataWrapper.Create(Param0)));
  end;
end;

procedure TatVariantsLibrary.__TCustomVariantTypeCastToOle(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TVarData;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TVarDataWrapper) then 
  Param0Rec := TVarDataWrapper.Create(Param0);
Param0 := TVarDataWrapper(Param0Rec).ObjToRec;
    TCustomVariantType(CurrentObject).CastToOle(Param0,TVarDataWrapper(integer(GetInputArg(1))).ObjToRec);
    SetInputArg(0,integer(TVarDataWrapper.Create(Param0)));
  end;
end;

procedure TatVariantsLibrary.__TCustomVariantTypeClear(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TVarData;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TVarDataWrapper) then 
  Param0Rec := TVarDataWrapper.Create(Param0);
Param0 := TVarDataWrapper(Param0Rec).ObjToRec;
    TCustomVariantType(CurrentObject).Clear(Param0);
    SetInputArg(0,integer(TVarDataWrapper.Create(Param0)));
  end;
end;

procedure TatVariantsLibrary.__TCustomVariantTypeCopy(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TVarData;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TVarDataWrapper) then 
  Param0Rec := TVarDataWrapper.Create(Param0);
Param0 := TVarDataWrapper(Param0Rec).ObjToRec;
    TCustomVariantType(CurrentObject).Copy(Param0,TVarDataWrapper(integer(GetInputArg(1))).ObjToRec,GetInputArg(2));
    SetInputArg(0,integer(TVarDataWrapper.Create(Param0)));
  end;
end;

procedure TatVariantsLibrary.__TCustomVariantTypeBinaryOp(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TVarData;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TVarDataWrapper) then 
  Param0Rec := TVarDataWrapper.Create(Param0);
Param0 := TVarDataWrapper(Param0Rec).ObjToRec;
    TCustomVariantType(CurrentObject).BinaryOp(Param0,TVarDataWrapper(integer(GetInputArg(1))).ObjToRec,VarToInteger(GetInputArg(2)));
    SetInputArg(0,integer(TVarDataWrapper.Create(Param0)));
  end;
end;

procedure TatVariantsLibrary.__TCustomVariantTypeUnaryOp(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TVarData;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TVarDataWrapper) then 
  Param0Rec := TVarDataWrapper.Create(Param0);
Param0 := TVarDataWrapper(Param0Rec).ObjToRec;
    TCustomVariantType(CurrentObject).UnaryOp(Param0,VarToInteger(GetInputArg(1)));
    SetInputArg(0,integer(TVarDataWrapper.Create(Param0)));
  end;
end;

procedure TatVariantsLibrary.__TCustomVariantTypeCompareOp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomVariantType(CurrentObject).CompareOp(TVarDataWrapper(integer(GetInputArg(0))).ObjToRec,TVarDataWrapper(integer(GetInputArg(1))).ObjToRec,VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__TCustomVariantTypeCompare(AMachine: TatVirtualMachine);
  var
  Param2: TVarCompareResult;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
    TCustomVariantType(CurrentObject).Compare(TVarDataWrapper(integer(GetInputArg(0))).ObjToRec,TVarDataWrapper(integer(GetInputArg(1))).ObjToRec,Param2);
    SetInputArg(2,Param2);
  end;
end;

procedure TatVariantsLibrary.__GetTCustomVariantTypeVarType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomVariantType(CurrentObject).VarType));
  end;
end;

procedure TatVariantsLibrary.__TInvokeableVariantTypeGetProperty(AMachine: TatVirtualMachine);
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
AResult := TInvokeableVariantType(CurrentObject).GetProperty(Param0,TVarDataWrapper(integer(GetInputArg(1))).ObjToRec,GetInputArg(2));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TVarDataWrapper.Create(Param0)));
  end;
end;

procedure TatVariantsLibrary.__TInvokeableVariantTypeSetProperty(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TInvokeableVariantType(CurrentObject).SetProperty(TVarDataWrapper(integer(GetInputArg(0))).ObjToRec,GetInputArg(1),TVarDataWrapper(integer(GetInputArg(2))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__VarType(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Variants.VarType(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__VarAsType(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Variants.VarAsType(GetInputArg(0),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__VarIsType(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Variants.VarIsType(GetInputArg(0),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__VarIsByRef(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Variants.VarIsByRef(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__VarIsEmpty(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Variants.VarIsEmpty(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__VarCheckEmpty(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Variants.VarCheckEmpty(GetInputArg(0));
  end;
end;

procedure TatVariantsLibrary.__VarIsNull(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Variants.VarIsNull(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__VarIsClear(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Variants.VarIsClear(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__VarIsCustom(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Variants.VarIsCustom(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__VarIsOrdinal(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Variants.VarIsOrdinal(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__VarIsFloat(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Variants.VarIsFloat(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__VarIsNumeric(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Variants.VarIsNumeric(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__VarIsStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Variants.VarIsStr(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__VarToStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Variants.VarToStr(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__VarToStrDef(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Variants.VarToStrDef(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__VarToWideStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Variants.VarToWideStr(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__VarToWideStrDef(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Variants.VarToWideStrDef(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__VarToDateTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Variants.VarToDateTime(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__VarFromDateTime(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Variants.VarFromDateTime(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__VarInRange(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Variants.VarInRange(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__VarEnsureRange(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Variants.VarEnsureRange(GetInputArg(0),GetInputArg(1),GetInputArg(2));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__VarSameValue(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Variants.VarSameValue(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__VarCompareValue(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Variants.VarCompareValue(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__VarIsEmptyParam(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Variants.VarIsEmptyParam(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__VarIsError(AMachine: TatVirtualMachine);
  var
  Param1: HRESULT;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Variants.VarIsError(GetInputArg(0),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatVariantsLibrary.__VarAsError(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Variants.VarAsError(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__VarSupports(AMachine: TatVirtualMachine);
  var
  Param2: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
AResult := Variants.VarSupports(GetInputArg(0),TGUIDWrapper(integer(GetInputArg(1))).ObjToRec,Param2);
    ReturnOutputArg(AResult);
    SetInputArg(2,Param2);
  end;
end;

procedure TatVariantsLibrary.__VarCopyNoInd(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    Variants.VarCopyNoInd(Param0,GetInputArg(1));
    SetInputArg(0,Param0);
  end;
end;

procedure TatVariantsLibrary.__VarIsArray(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Variants.VarIsArray(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__VarArrayRef(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Variants.VarArrayRef(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__VarTypeIsValidArrayType(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Variants.VarTypeIsValidArrayType(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__VarTypeIsValidElementType(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Variants.VarTypeIsValidElementType(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__VarArrayDimCount(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Variants.VarArrayDimCount(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__VarArrayLowBound(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Variants.VarArrayLowBound(GetInputArg(0),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__VarArrayHighBound(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Variants.VarArrayHighBound(GetInputArg(0),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__VarArrayUnlock(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Variants.VarArrayUnlock(GetInputArg(0));
  end;
end;

procedure TatVariantsLibrary.__Unassigned(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Variants.Unassigned;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__Null(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Variants.Null;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__FindCustomVariantType(AMachine: TatVirtualMachine);
  var
  Param1: TCustomVariantType;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := TCustomVariantType(Integer(GetInputArg(1)));
AResult := Variants.FindCustomVariantType(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatVariantsLibrary.__VarCastError(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Variants.VarCastError;
  end;
end;

procedure TatVariantsLibrary.__VarInvalidOp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Variants.VarInvalidOp;
  end;
end;

procedure TatVariantsLibrary.__VarInvalidNullOp(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Variants.VarInvalidNullOp;
  end;
end;

procedure TatVariantsLibrary.__VarOverflowError(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Variants.VarOverflowError(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatVariantsLibrary.__VarRangeCheckError(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Variants.VarRangeCheckError(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatVariantsLibrary.__VarArrayCreateError(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Variants.VarArrayCreateError;
  end;
end;

procedure TatVariantsLibrary.__VarResultCheck(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Variants.VarResultCheck(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatVariantsLibrary.__HandleConversionException(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Variants.HandleConversionException(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatVariantsLibrary.__VarTypeAsText(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Variants.VarTypeAsText(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVariantsLibrary.__GetEmptyParam(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Variants.EmptyParam);
  end;
end;

procedure TatVariantsLibrary.__SetEmptyParam(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Variants.EmptyParam:=GetInputArg(0);
  end;
end;

procedure TatVariantsLibrary.__GetNullEqualityRule(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Variants.NullEqualityRule);
  end;
end;

procedure TatVariantsLibrary.__SetNullEqualityRule(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Variants.NullEqualityRule:=GetInputArg(0);
  end;
end;

procedure TatVariantsLibrary.__GetNullMagnitudeRule(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Variants.NullMagnitudeRule);
  end;
end;

procedure TatVariantsLibrary.__SetNullMagnitudeRule(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Variants.NullMagnitudeRule:=GetInputArg(0);
  end;
end;

procedure TatVariantsLibrary.__GetNullStrictConvert(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Variants.NullStrictConvert);
  end;
end;

procedure TatVariantsLibrary.__SetNullStrictConvert(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Variants.NullStrictConvert:=GetInputArg(0);
  end;
end;

procedure TatVariantsLibrary.__GetNullAsStringValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Variants.NullAsStringValue);
  end;
end;

procedure TatVariantsLibrary.__SetNullAsStringValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Variants.NullAsStringValue:=GetInputArg(0);
  end;
end;

procedure TatVariantsLibrary.__GetPackVarCreation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Variants.PackVarCreation);
  end;
end;

procedure TatVariantsLibrary.__SetPackVarCreation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Variants.PackVarCreation:=GetInputArg(0);
  end;
end;

procedure TatVariantsLibrary.__GetBooleanToStringRule(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Variants.BooleanToStringRule);
  end;
end;

procedure TatVariantsLibrary.__SetBooleanToStringRule(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Variants.BooleanToStringRule:=GetInputArg(0);
  end;
end;

procedure TatVariantsLibrary.Init;
begin
  With Scripter.DefineClass(TCustomVariantType) do
  begin
    DefineMethod('Create',0,tkClass,TCustomVariantType,__TCustomVariantTypeCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomVariantTypeDestroy,false,0);
    DefineMethod('IsClear',1,tkVariant,nil,__TCustomVariantTypeIsClear,false,0);
    DefineMethod('Cast',2,tkNone,nil,__TCustomVariantTypeCast,false,0).SetVarArgs([0]);
    DefineMethod('CastTo',3,tkNone,nil,__TCustomVariantTypeCastTo,false,0).SetVarArgs([0]);
    DefineMethod('CastToOle',2,tkNone,nil,__TCustomVariantTypeCastToOle,false,0).SetVarArgs([0]);
    DefineMethod('Clear',1,tkNone,nil,__TCustomVariantTypeClear,false,0).SetVarArgs([0]);
    DefineMethod('Copy',3,tkNone,nil,__TCustomVariantTypeCopy,false,0).SetVarArgs([0]);
    DefineMethod('BinaryOp',3,tkNone,nil,__TCustomVariantTypeBinaryOp,false,0).SetVarArgs([0]);
    DefineMethod('UnaryOp',2,tkNone,nil,__TCustomVariantTypeUnaryOp,false,0).SetVarArgs([0]);
    DefineMethod('CompareOp',3,tkVariant,nil,__TCustomVariantTypeCompareOp,false,0);
    DefineMethod('Compare',3,tkNone,nil,__TCustomVariantTypeCompare,false,0).SetVarArgs([2]);
    DefineProp('VarType',tkInteger,__GetTCustomVariantTypeVarType,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TInvokeableVariantType) do
  begin
    DefineMethod('GetProperty',3,tkVariant,nil,__TInvokeableVariantTypeGetProperty,false,0).SetVarArgs([0]);
    DefineMethod('SetProperty',3,tkVariant,nil,__TInvokeableVariantTypeSetProperty,false,0);
  end;
  With Scripter.DefineClass(EVariantInvalidOpError) do
  begin
  end;
  With Scripter.DefineClass(EVariantTypeCastError) do
  begin
  end;
  With Scripter.DefineClass(EVariantOverflowError) do
  begin
  end;
  With Scripter.DefineClass(EVariantInvalidArgError) do
  begin
  end;
  With Scripter.DefineClass(EVariantBadVarTypeError) do
  begin
  end;
  With Scripter.DefineClass(EVariantBadIndexError) do
  begin
  end;
  With Scripter.DefineClass(EVariantArrayLockedError) do
  begin
  end;
  With Scripter.DefineClass(EVariantNotAnArrayError) do
  begin
  end;
  With Scripter.DefineClass(EVariantArrayCreateError) do
  begin
  end;
  With Scripter.DefineClass(EVariantNotImplError) do
  begin
  end;
  With Scripter.DefineClass(EVariantOutOfMemoryError) do
  begin
  end;
  With Scripter.DefineClass(EVariantUnexpectedError) do
  begin
  end;
  With Scripter.DefineClass(EVariantDispatchError) do
  begin
  end;
  With Scripter.DefineClass(EVariantRangeCheckError) do
  begin
  end;
  With Scripter.DefineClass(EVariantInvalidNullOpError) do
  begin
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('VarType',1,tkInteger,nil,__VarType,false,0);
    DefineMethod('VarAsType',2,tkVariant,nil,__VarAsType,false,0);
    DefineMethod('VarIsType',2,tkVariant,nil,__VarIsType,false,0);
    DefineMethod('VarIsByRef',1,tkVariant,nil,__VarIsByRef,false,0);
    DefineMethod('VarIsEmpty',1,tkVariant,nil,__VarIsEmpty,false,0);
    DefineMethod('VarCheckEmpty',1,tkNone,nil,__VarCheckEmpty,false,0);
    DefineMethod('VarIsNull',1,tkVariant,nil,__VarIsNull,false,0);
    DefineMethod('VarIsClear',1,tkVariant,nil,__VarIsClear,false,0);
    DefineMethod('VarIsCustom',1,tkVariant,nil,__VarIsCustom,false,0);
    DefineMethod('VarIsOrdinal',1,tkVariant,nil,__VarIsOrdinal,false,0);
    DefineMethod('VarIsFloat',1,tkVariant,nil,__VarIsFloat,false,0);
    DefineMethod('VarIsNumeric',1,tkVariant,nil,__VarIsNumeric,false,0);
    DefineMethod('VarIsStr',1,tkVariant,nil,__VarIsStr,false,0);
    DefineMethod('VarToStr',1,tkVariant,nil,__VarToStr,false,0);
    DefineMethod('VarToStrDef',2,tkVariant,nil,__VarToStrDef,false,0);
    DefineMethod('VarToWideStr',1,tkVariant,nil,__VarToWideStr,false,0);
    DefineMethod('VarToWideStrDef',2,tkVariant,nil,__VarToWideStrDef,false,0);
    DefineMethod('VarToDateTime',1,tkVariant,nil,__VarToDateTime,false,0);
    DefineMethod('VarFromDateTime',1,tkVariant,nil,__VarFromDateTime,false,0);
    DefineMethod('VarInRange',3,tkVariant,nil,__VarInRange,false,0);
    DefineMethod('VarEnsureRange',3,tkVariant,nil,__VarEnsureRange,false,0);
    DefineMethod('VarSameValue',2,tkVariant,nil,__VarSameValue,false,0);
    DefineMethod('VarCompareValue',2,tkEnumeration,nil,__VarCompareValue,false,0);
    DefineMethod('VarIsEmptyParam',1,tkVariant,nil,__VarIsEmptyParam,false,0);
    DefineMethod('VarIsError',2,tkVariant,nil,__VarIsError,false,0).SetVarArgs([1]);
    DefineMethod('VarAsError',1,tkVariant,nil,__VarAsError,false,0);
    DefineMethod('VarSupports',3,tkVariant,nil,__VarSupports,false,0).SetVarArgs([2]);
    DefineMethod('VarCopyNoInd',2,tkNone,nil,__VarCopyNoInd,false,0).SetVarArgs([0]);
    DefineMethod('VarIsArray',1,tkVariant,nil,__VarIsArray,false,0);
    DefineMethod('VarArrayRef',1,tkVariant,nil,__VarArrayRef,false,0);
    DefineMethod('VarTypeIsValidArrayType',1,tkVariant,nil,__VarTypeIsValidArrayType,false,0);
    DefineMethod('VarTypeIsValidElementType',1,tkVariant,nil,__VarTypeIsValidElementType,false,0);
    DefineMethod('VarArrayDimCount',1,tkInteger,nil,__VarArrayDimCount,false,0);
    DefineMethod('VarArrayLowBound',2,tkInteger,nil,__VarArrayLowBound,false,0);
    DefineMethod('VarArrayHighBound',2,tkInteger,nil,__VarArrayHighBound,false,0);
    DefineMethod('VarArrayUnlock',1,tkNone,nil,__VarArrayUnlock,false,0);
    DefineMethod('Unassigned',0,tkVariant,nil,__Unassigned,false,0);
    DefineMethod('Null',0,tkVariant,nil,__Null,false,0);
    DefineMethod('FindCustomVariantType',2,tkVariant,nil,__FindCustomVariantType,false,0).SetVarArgs([1]);
    DefineMethod('VarCastError',0,tkNone,nil,__VarCastError,false,0);
    DefineMethod('VarInvalidOp',0,tkNone,nil,__VarInvalidOp,false,0);
    DefineMethod('VarInvalidNullOp',0,tkNone,nil,__VarInvalidNullOp,false,0);
    DefineMethod('VarOverflowError',2,tkNone,nil,__VarOverflowError,false,0);
    DefineMethod('VarRangeCheckError',2,tkNone,nil,__VarRangeCheckError,false,0);
    DefineMethod('VarArrayCreateError',0,tkNone,nil,__VarArrayCreateError,false,0);
    DefineMethod('VarResultCheck',1,tkNone,nil,__VarResultCheck,false,0);
    DefineMethod('HandleConversionException',2,tkNone,nil,__HandleConversionException,false,0);
    DefineMethod('VarTypeAsText',1,tkVariant,nil,__VarTypeAsText,false,0);
    DefineProp('EmptyParam',tkVariant,__GetEmptyParam,__SetEmptyParam,nil,false,0);
    DefineProp('NullEqualityRule',tkEnumeration,__GetNullEqualityRule,__SetNullEqualityRule,nil,false,0);
    DefineProp('NullMagnitudeRule',tkEnumeration,__GetNullMagnitudeRule,__SetNullMagnitudeRule,nil,false,0);
    DefineProp('NullStrictConvert',tkVariant,__GetNullStrictConvert,__SetNullStrictConvert,nil,false,0);
    DefineProp('NullAsStringValue',tkVariant,__GetNullAsStringValue,__SetNullAsStringValue,nil,false,0);
    DefineProp('PackVarCreation',tkVariant,__GetPackVarCreation,__SetPackVarCreation,nil,false,0);
    DefineProp('BooleanToStringRule',tkEnumeration,__GetBooleanToStringRule,__SetBooleanToStringRule,nil,false,0);
    AddConstant('vrEqual',vrEqual);
    AddConstant('vrLessThan',vrLessThan);
    AddConstant('vrGreaterThan',vrGreaterThan);
    AddConstant('vrNotEqual',vrNotEqual);
    AddConstant('crLessThan',crLessThan);
    AddConstant('crEqual',crEqual);
    AddConstant('crGreaterThan',crGreaterThan);
    AddConstant('ncrError',ncrError);
    AddConstant('ncrStrict',ncrStrict);
    AddConstant('ncrLoose',ncrLoose);
    AddConstant('bsrAsIs',bsrAsIs);
    AddConstant('bsrLower',bsrLower);
    AddConstant('bsrUpper',bsrUpper);
  end;
end;

class function TatVariantsLibrary.LibraryName: string;
begin
  result := 'Variants';
end;

initialization
  RegisterScripterLibrary(TatVariantsLibrary, True);

{$WARNINGS ON}

end.

