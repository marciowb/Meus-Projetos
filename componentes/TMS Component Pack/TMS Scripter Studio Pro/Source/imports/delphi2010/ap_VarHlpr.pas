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
unit ap_VarHlpr;

interface

uses
  VarHlpr,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatVarHlprLibrary = class(TatScripterLibrary)
    procedure __VariantClear(AMachine: TatVirtualMachine);
    procedure __VariantArrayRedim(AMachine: TatVirtualMachine);
    procedure __VariantCast(AMachine: TatVirtualMachine);
    procedure __VariantCpy(AMachine: TatVirtualMachine);
    procedure __VariantAdd(AMachine: TatVirtualMachine);
    procedure __VariantSub(AMachine: TatVirtualMachine);
    procedure __VariantMul(AMachine: TatVirtualMachine);
    procedure __VariantDiv(AMachine: TatVirtualMachine);
    procedure __VariantMod(AMachine: TatVirtualMachine);
    procedure __VariantAnd(AMachine: TatVirtualMachine);
    procedure __VariantOr(AMachine: TatVirtualMachine);
    procedure __VariantXor(AMachine: TatVirtualMachine);
    procedure __VariantShl(AMachine: TatVirtualMachine);
    procedure __VariantShr(AMachine: TatVirtualMachine);
    procedure __VariantAdd2(AMachine: TatVirtualMachine);
    procedure __VariantSub2(AMachine: TatVirtualMachine);
    procedure __VariantMul2(AMachine: TatVirtualMachine);
    procedure __VariantDiv2(AMachine: TatVirtualMachine);
    procedure __VariantMod2(AMachine: TatVirtualMachine);
    procedure __VariantAnd2(AMachine: TatVirtualMachine);
    procedure __VariantOr2(AMachine: TatVirtualMachine);
    procedure __VariantXor2(AMachine: TatVirtualMachine);
    procedure __VariantShl2(AMachine: TatVirtualMachine);
    procedure __VariantShr2(AMachine: TatVirtualMachine);
    procedure __VariantNot(AMachine: TatVirtualMachine);
    procedure __VariantNeg(AMachine: TatVirtualMachine);
    procedure __VariantGetElement(AMachine: TatVirtualMachine);
    procedure __VariantPutElement(AMachine: TatVirtualMachine);
    procedure __VariantFromUnicodeString(AMachine: TatVirtualMachine);
    procedure __VariantToUnicodeString(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatVarHlprLibrary.__VariantClear(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    VarHlpr.VariantClear(Param0);
    SetInputArg(0,Param0);
  end;
end;

procedure TatVarHlprLibrary.__VariantArrayRedim(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    VarHlpr.VariantArrayRedim(Param0,VarToInteger(GetInputArg(1)));
    SetInputArg(0,Param0);
  end;
end;

procedure TatVarHlprLibrary.__VariantCast(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
    VarHlpr.VariantCast(GetInputArg(0),Param1,VarToInteger(GetInputArg(2)));
    SetInputArg(1,Param1);
  end;
end;

procedure TatVarHlprLibrary.__VariantCpy(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
    VarHlpr.VariantCpy(GetInputArg(0),Param1);
    SetInputArg(1,Param1);
  end;
end;

procedure TatVarHlprLibrary.__VariantAdd(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
    VarHlpr.VariantAdd(GetInputArg(0),Param1);
    SetInputArg(1,Param1);
  end;
end;

procedure TatVarHlprLibrary.__VariantSub(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
    VarHlpr.VariantSub(GetInputArg(0),Param1);
    SetInputArg(1,Param1);
  end;
end;

procedure TatVarHlprLibrary.__VariantMul(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
    VarHlpr.VariantMul(GetInputArg(0),Param1);
    SetInputArg(1,Param1);
  end;
end;

procedure TatVarHlprLibrary.__VariantDiv(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
    VarHlpr.VariantDiv(GetInputArg(0),Param1);
    SetInputArg(1,Param1);
  end;
end;

procedure TatVarHlprLibrary.__VariantMod(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
    VarHlpr.VariantMod(GetInputArg(0),Param1);
    SetInputArg(1,Param1);
  end;
end;

procedure TatVarHlprLibrary.__VariantAnd(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
    VarHlpr.VariantAnd(GetInputArg(0),Param1);
    SetInputArg(1,Param1);
  end;
end;

procedure TatVarHlprLibrary.__VariantOr(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
    VarHlpr.VariantOr(GetInputArg(0),Param1);
    SetInputArg(1,Param1);
  end;
end;

procedure TatVarHlprLibrary.__VariantXor(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
    VarHlpr.VariantXor(GetInputArg(0),Param1);
    SetInputArg(1,Param1);
  end;
end;

procedure TatVarHlprLibrary.__VariantShl(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
    VarHlpr.VariantShl(GetInputArg(0),Param1);
    SetInputArg(1,Param1);
  end;
end;

procedure TatVarHlprLibrary.__VariantShr(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
    VarHlpr.VariantShr(GetInputArg(0),Param1);
    SetInputArg(1,Param1);
  end;
end;

procedure TatVarHlprLibrary.__VariantAdd2(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarHlpr.VariantAdd2(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarHlprLibrary.__VariantSub2(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarHlpr.VariantSub2(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarHlprLibrary.__VariantMul2(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarHlpr.VariantMul2(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarHlprLibrary.__VariantDiv2(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarHlpr.VariantDiv2(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarHlprLibrary.__VariantMod2(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarHlpr.VariantMod2(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarHlprLibrary.__VariantAnd2(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarHlpr.VariantAnd2(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarHlprLibrary.__VariantOr2(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarHlpr.VariantOr2(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarHlprLibrary.__VariantXor2(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarHlpr.VariantXor2(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarHlprLibrary.__VariantShl2(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarHlpr.VariantShl2(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarHlprLibrary.__VariantShr2(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarHlpr.VariantShr2(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarHlprLibrary.__VariantNot(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarHlpr.VariantNot(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarHlprLibrary.__VariantNeg(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarHlpr.VariantNeg(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarHlprLibrary.__VariantGetElement(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarHlpr.VariantGetElement(GetInputArg(0),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarHlprLibrary.__VariantPutElement(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    VarHlpr.VariantPutElement(Param0,GetInputArg(1),VarToInteger(GetInputArg(2)));
    SetInputArg(0,Param0);
  end;
end;

procedure TatVarHlprLibrary.__VariantFromUnicodeString(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    VarHlpr.VariantFromUnicodeString(Param0,GetInputArg(1));
    SetInputArg(0,Param0);
  end;
end;

procedure TatVarHlprLibrary.__VariantToUnicodeString(AMachine: TatVirtualMachine);
  var
  Param1: UnicodeString;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
    VarHlpr.VariantToUnicodeString(GetInputArg(0),Param1);
    SetInputArg(1,Param1);
  end;
end;

procedure TatVarHlprLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('VariantClear',1,tkNone,nil,__VariantClear,false,0).SetVarArgs([0]);
    DefineMethod('VariantArrayRedim',2,tkNone,nil,__VariantArrayRedim,false,0).SetVarArgs([0]);
    DefineMethod('VariantCast',3,tkNone,nil,__VariantCast,false,0).SetVarArgs([1]);
    DefineMethod('VariantCpy',2,tkNone,nil,__VariantCpy,false,0).SetVarArgs([1]);
    DefineMethod('VariantAdd',2,tkNone,nil,__VariantAdd,false,0).SetVarArgs([1]);
    DefineMethod('VariantSub',2,tkNone,nil,__VariantSub,false,0).SetVarArgs([1]);
    DefineMethod('VariantMul',2,tkNone,nil,__VariantMul,false,0).SetVarArgs([1]);
    DefineMethod('VariantDiv',2,tkNone,nil,__VariantDiv,false,0).SetVarArgs([1]);
    DefineMethod('VariantMod',2,tkNone,nil,__VariantMod,false,0).SetVarArgs([1]);
    DefineMethod('VariantAnd',2,tkNone,nil,__VariantAnd,false,0).SetVarArgs([1]);
    DefineMethod('VariantOr',2,tkNone,nil,__VariantOr,false,0).SetVarArgs([1]);
    DefineMethod('VariantXor',2,tkNone,nil,__VariantXor,false,0).SetVarArgs([1]);
    DefineMethod('VariantShl',2,tkNone,nil,__VariantShl,false,0).SetVarArgs([1]);
    DefineMethod('VariantShr',2,tkNone,nil,__VariantShr,false,0).SetVarArgs([1]);
    DefineMethod('VariantAdd2',2,tkVariant,nil,__VariantAdd2,false,0);
    DefineMethod('VariantSub2',2,tkVariant,nil,__VariantSub2,false,0);
    DefineMethod('VariantMul2',2,tkVariant,nil,__VariantMul2,false,0);
    DefineMethod('VariantDiv2',2,tkVariant,nil,__VariantDiv2,false,0);
    DefineMethod('VariantMod2',2,tkVariant,nil,__VariantMod2,false,0);
    DefineMethod('VariantAnd2',2,tkVariant,nil,__VariantAnd2,false,0);
    DefineMethod('VariantOr2',2,tkVariant,nil,__VariantOr2,false,0);
    DefineMethod('VariantXor2',2,tkVariant,nil,__VariantXor2,false,0);
    DefineMethod('VariantShl2',2,tkVariant,nil,__VariantShl2,false,0);
    DefineMethod('VariantShr2',2,tkVariant,nil,__VariantShr2,false,0);
    DefineMethod('VariantNot',1,tkVariant,nil,__VariantNot,false,0);
    DefineMethod('VariantNeg',1,tkVariant,nil,__VariantNeg,false,0);
    DefineMethod('VariantGetElement',2,tkVariant,nil,__VariantGetElement,false,0);
    DefineMethod('VariantPutElement',3,tkNone,nil,__VariantPutElement,false,0).SetVarArgs([0]);
    DefineMethod('VariantFromUnicodeString',2,tkNone,nil,__VariantFromUnicodeString,false,0).SetVarArgs([0]);
    DefineMethod('VariantToUnicodeString',2,tkNone,nil,__VariantToUnicodeString,false,0).SetVarArgs([1]);
  end;
end;

class function TatVarHlprLibrary.LibraryName: string;
begin
  result := 'VarHlpr';
end;

initialization
  RegisterScripterLibrary(TatVarHlprLibrary, True);

{$WARNINGS ON}

end.

