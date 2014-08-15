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
unit ap_vclhlpr;

interface

uses
  Windows,
  Messages,
  ActiveX,
  SysUtils,
  ComObj,
  Classes,
  Graphics,
  Controls,
  Forms,
  ExtCtrls,
  StdVCL,
  AxCtrls,
  vclhlpr,
  Variants,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatvclhlprLibrary = class(TatScripterLibrary)
    procedure __TPropertyPageImplHackQueryInterface(AMachine: TatVirtualMachine);
    procedure __TPropertyPageImplHack_AddRef(AMachine: TatVirtualMachine);
    procedure __TPropertyPageImplHack_Release(AMachine: TatVirtualMachine);
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
    procedure __VariantCmpEQ(AMachine: TatVirtualMachine);
    procedure __VariantCmpLT(AMachine: TatVirtualMachine);
    procedure __VariantCmpGT(AMachine: TatVirtualMachine);
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
    procedure __VariantRaiseError(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TPropertyPageImplHackClass = class of TPropertyPageImplHack;



implementation



procedure TatvclhlprLibrary.__TPropertyPageImplHackQueryInterface(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Integer(TPropertyPageImplHack(CurrentObject).QueryInterface(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatvclhlprLibrary.__TPropertyPageImplHack_AddRef(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TPropertyPageImplHack(CurrentObject)._AddRef);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatvclhlprLibrary.__TPropertyPageImplHack_Release(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TPropertyPageImplHack(CurrentObject)._Release);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatvclhlprLibrary.__VariantCpy(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
    vclhlpr.VariantCpy(GetInputArg(0),Param1);
    SetInputArg(1,Param1);
  end;
end;

procedure TatvclhlprLibrary.__VariantAdd(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
    vclhlpr.VariantAdd(GetInputArg(0),Param1);
    SetInputArg(1,Param1);
  end;
end;

procedure TatvclhlprLibrary.__VariantSub(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
    vclhlpr.VariantSub(GetInputArg(0),Param1);
    SetInputArg(1,Param1);
  end;
end;

procedure TatvclhlprLibrary.__VariantMul(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
    vclhlpr.VariantMul(GetInputArg(0),Param1);
    SetInputArg(1,Param1);
  end;
end;

procedure TatvclhlprLibrary.__VariantDiv(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
    vclhlpr.VariantDiv(GetInputArg(0),Param1);
    SetInputArg(1,Param1);
  end;
end;

procedure TatvclhlprLibrary.__VariantMod(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
    vclhlpr.VariantMod(GetInputArg(0),Param1);
    SetInputArg(1,Param1);
  end;
end;

procedure TatvclhlprLibrary.__VariantAnd(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
    vclhlpr.VariantAnd(GetInputArg(0),Param1);
    SetInputArg(1,Param1);
  end;
end;

procedure TatvclhlprLibrary.__VariantOr(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
    vclhlpr.VariantOr(GetInputArg(0),Param1);
    SetInputArg(1,Param1);
  end;
end;

procedure TatvclhlprLibrary.__VariantXor(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
    vclhlpr.VariantXor(GetInputArg(0),Param1);
    SetInputArg(1,Param1);
  end;
end;

procedure TatvclhlprLibrary.__VariantShl(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
    vclhlpr.VariantShl(GetInputArg(0),Param1);
    SetInputArg(1,Param1);
  end;
end;

procedure TatvclhlprLibrary.__VariantShr(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
    vclhlpr.VariantShr(GetInputArg(0),Param1);
    SetInputArg(1,Param1);
  end;
end;

procedure TatvclhlprLibrary.__VariantCmpEQ(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := vclhlpr.VariantCmpEQ(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatvclhlprLibrary.__VariantCmpLT(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := vclhlpr.VariantCmpLT(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatvclhlprLibrary.__VariantCmpGT(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := vclhlpr.VariantCmpGT(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatvclhlprLibrary.__VariantAdd2(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := vclhlpr.VariantAdd2(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatvclhlprLibrary.__VariantSub2(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := vclhlpr.VariantSub2(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatvclhlprLibrary.__VariantMul2(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := vclhlpr.VariantMul2(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatvclhlprLibrary.__VariantDiv2(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := vclhlpr.VariantDiv2(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatvclhlprLibrary.__VariantMod2(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := vclhlpr.VariantMod2(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatvclhlprLibrary.__VariantAnd2(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := vclhlpr.VariantAnd2(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatvclhlprLibrary.__VariantOr2(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := vclhlpr.VariantOr2(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatvclhlprLibrary.__VariantXor2(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := vclhlpr.VariantXor2(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatvclhlprLibrary.__VariantShl2(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := vclhlpr.VariantShl2(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatvclhlprLibrary.__VariantShr2(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := vclhlpr.VariantShr2(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatvclhlprLibrary.__VariantNot(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := vclhlpr.VariantNot(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatvclhlprLibrary.__VariantNeg(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := vclhlpr.VariantNeg(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatvclhlprLibrary.__VariantGetElement(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := vclhlpr.VariantGetElement(GetInputArg(0),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatvclhlprLibrary.__VariantPutElement(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    vclhlpr.VariantPutElement(Param0,GetInputArg(1),VarToInteger(GetInputArg(2)));
    SetInputArg(0,Param0);
  end;
end;

procedure TatvclhlprLibrary.__VariantRaiseError(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    vclhlpr.VariantRaiseError(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatvclhlprLibrary.Init;
begin
  With Scripter.DefineClass(TPropertyPageImplHack) do
  begin
    DefineMethod('QueryInterface',2,tkInteger,nil,__TPropertyPageImplHackQueryInterface,false,0).SetVarArgs([1]);
    DefineMethod('_AddRef',0,tkInteger,nil,__TPropertyPageImplHack_AddRef,false,0);
    DefineMethod('_Release',0,tkInteger,nil,__TPropertyPageImplHack_Release,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
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
    DefineMethod('VariantCmpEQ',2,tkVariant,nil,__VariantCmpEQ,false,0);
    DefineMethod('VariantCmpLT',2,tkVariant,nil,__VariantCmpLT,false,0);
    DefineMethod('VariantCmpGT',2,tkVariant,nil,__VariantCmpGT,false,0);
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
    DefineMethod('VariantRaiseError',1,tkNone,nil,__VariantRaiseError,false,0);
  end;
end;

class function TatvclhlprLibrary.LibraryName: string;
begin
  result := 'vclhlpr';
end;

initialization
  RegisterScripterLibrary(TatvclhlprLibrary, True);

{$WARNINGS ON}

end.

