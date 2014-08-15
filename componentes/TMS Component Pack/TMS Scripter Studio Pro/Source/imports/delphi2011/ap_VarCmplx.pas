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
unit ap_VarCmplx;

interface

uses
  Windows,
  Variants,
  VarCmplx,
  atScript;

{$WARNINGS OFF}

type
  TatVarCmplxLibrary = class(TatScripterLibrary)
    procedure __VarComplexCreate(AMachine: TatVirtualMachine);
    procedure __VarComplex(AMachine: TatVirtualMachine);
    procedure __VarIsComplex(AMachine: TatVirtualMachine);
    procedure __VarAsComplex(AMachine: TatVirtualMachine);
    procedure __VarComplexSimplify(AMachine: TatVirtualMachine);
    procedure __VarComplexAbsSqr(AMachine: TatVirtualMachine);
    procedure __VarComplexAbs(AMachine: TatVirtualMachine);
    procedure __VarComplexAngle(AMachine: TatVirtualMachine);
    procedure __VarComplexSign(AMachine: TatVirtualMachine);
    procedure __VarComplexConjugate(AMachine: TatVirtualMachine);
    procedure __VarComplexInverse(AMachine: TatVirtualMachine);
    procedure __VarComplexExp(AMachine: TatVirtualMachine);
    procedure __VarComplexLn(AMachine: TatVirtualMachine);
    procedure __VarComplexLog2(AMachine: TatVirtualMachine);
    procedure __VarComplexLog10(AMachine: TatVirtualMachine);
    procedure __VarComplexLogN(AMachine: TatVirtualMachine);
    procedure __VarComplexSqr(AMachine: TatVirtualMachine);
    procedure __VarComplexSqrt(AMachine: TatVirtualMachine);
    procedure __VarComplexPower(AMachine: TatVirtualMachine);
    procedure __VarComplexTimesPosI(AMachine: TatVirtualMachine);
    procedure __VarComplexTimesNegI(AMachine: TatVirtualMachine);
    procedure __VarComplexTimesImaginary(AMachine: TatVirtualMachine);
    procedure __VarComplexTimesReal(AMachine: TatVirtualMachine);
    procedure __VarComplexCos(AMachine: TatVirtualMachine);
    procedure __VarComplexSin(AMachine: TatVirtualMachine);
    procedure __VarComplexTan(AMachine: TatVirtualMachine);
    procedure __VarComplexCot(AMachine: TatVirtualMachine);
    procedure __VarComplexSec(AMachine: TatVirtualMachine);
    procedure __VarComplexCsc(AMachine: TatVirtualMachine);
    procedure __VarComplexArcCos(AMachine: TatVirtualMachine);
    procedure __VarComplexArcSin(AMachine: TatVirtualMachine);
    procedure __VarComplexArcTan(AMachine: TatVirtualMachine);
    procedure __VarComplexArcCot(AMachine: TatVirtualMachine);
    procedure __VarComplexArcSec(AMachine: TatVirtualMachine);
    procedure __VarComplexArcCsc(AMachine: TatVirtualMachine);
    procedure __VarComplexCosH(AMachine: TatVirtualMachine);
    procedure __VarComplexSinH(AMachine: TatVirtualMachine);
    procedure __VarComplexTanH(AMachine: TatVirtualMachine);
    procedure __VarComplexCotH(AMachine: TatVirtualMachine);
    procedure __VarComplexSecH(AMachine: TatVirtualMachine);
    procedure __VarComplexCscH(AMachine: TatVirtualMachine);
    procedure __VarComplexArcCosH(AMachine: TatVirtualMachine);
    procedure __VarComplexArcSinH(AMachine: TatVirtualMachine);
    procedure __VarComplexArcTanH(AMachine: TatVirtualMachine);
    procedure __VarComplexArcCotH(AMachine: TatVirtualMachine);
    procedure __VarComplexArcSecH(AMachine: TatVirtualMachine);
    procedure __VarComplexArcCscH(AMachine: TatVirtualMachine);
    procedure __VarComplexToPolar(AMachine: TatVirtualMachine);
    procedure __VarComplexFromPolar(AMachine: TatVirtualMachine);
    procedure __GetComplexNumberSymbol(AMachine: TatVirtualMachine);
    procedure __SetComplexNumberSymbol(AMachine: TatVirtualMachine);
    procedure __GetComplexNumberSymbolBeforeImaginary(AMachine: TatVirtualMachine);
    procedure __SetComplexNumberSymbolBeforeImaginary(AMachine: TatVirtualMachine);
    procedure __GetComplexNumberDefuzzAtZero(AMachine: TatVirtualMachine);
    procedure __SetComplexNumberDefuzzAtZero(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatVarCmplxLibrary.__VarComplexCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexCreate;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplex(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplex;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarIsComplex(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarIsComplex(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarAsComplex(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarAsComplex(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexSimplify(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexSimplify(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexAbsSqr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexAbsSqr(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexAbs(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexAbs(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexAngle(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexAngle(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexSign(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexSign(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexConjugate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexConjugate(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexInverse(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexInverse(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexExp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexExp(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexLn(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexLn(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexLog2(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexLog2(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexLog10(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexLog10(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexLogN(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexLogN(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexSqr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexSqr(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexSqrt(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexSqrt(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexPower(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexPower(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexTimesPosI(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexTimesPosI(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexTimesNegI(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexTimesNegI(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexTimesImaginary(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexTimesImaginary(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexTimesReal(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexTimesReal(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexCos(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexCos(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexSin(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexSin(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexTan(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexTan(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexCot(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexCot(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexSec(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexSec(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexCsc(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexCsc(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexArcCos(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexArcCos(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexArcSin(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexArcSin(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexArcTan(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexArcTan(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexArcCot(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexArcCot(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexArcSec(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexArcSec(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexArcCsc(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexArcCsc(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexCosH(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexCosH(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexSinH(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexSinH(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexTanH(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexTanH(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexCotH(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexCotH(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexSecH(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexSecH(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexCscH(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexCscH(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexArcCosH(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexArcCosH(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexArcSinH(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexArcSinH(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexArcTanH(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexArcTanH(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexArcCotH(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexArcCotH(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexArcSecH(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexArcSecH(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexArcCscH(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexArcCscH(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexToPolar(AMachine: TatVirtualMachine);
  var
  Param1: Double;
  Param2: Double;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
Param2 := GetInputArg(2);
    Case InputArgCount of
      3: VarCmplx.VarComplexToPolar(GetInputArg(0),Param1,Param2);
      4: VarCmplx.VarComplexToPolar(GetInputArg(0),Param1,Param2,GetInputArg(3));
    end;
    SetInputArg(1,Param1);
    SetInputArg(2,Param2);
  end;
end;

procedure TatVarCmplxLibrary.__VarComplexFromPolar(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := VarCmplx.VarComplexFromPolar(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarCmplxLibrary.__GetComplexNumberSymbol(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(VarCmplx.ComplexNumberSymbol);
  end;
end;

procedure TatVarCmplxLibrary.__SetComplexNumberSymbol(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    VarCmplx.ComplexNumberSymbol:=GetInputArg(0);
  end;
end;

procedure TatVarCmplxLibrary.__GetComplexNumberSymbolBeforeImaginary(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(VarCmplx.ComplexNumberSymbolBeforeImaginary);
  end;
end;

procedure TatVarCmplxLibrary.__SetComplexNumberSymbolBeforeImaginary(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    VarCmplx.ComplexNumberSymbolBeforeImaginary:=GetInputArg(0);
  end;
end;

procedure TatVarCmplxLibrary.__GetComplexNumberDefuzzAtZero(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(VarCmplx.ComplexNumberDefuzzAtZero);
  end;
end;

procedure TatVarCmplxLibrary.__SetComplexNumberDefuzzAtZero(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    VarCmplx.ComplexNumberDefuzzAtZero:=GetInputArg(0);
  end;
end;

procedure TatVarCmplxLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('VarComplexCreate',0,tkVariant,nil,__VarComplexCreate,false,0);
    DefineMethod('VarComplex',0,tkVariant,nil,__VarComplex,false,0);
    DefineMethod('VarIsComplex',1,tkVariant,nil,__VarIsComplex,false,0);
    DefineMethod('VarAsComplex',1,tkVariant,nil,__VarAsComplex,false,0);
    DefineMethod('VarComplexSimplify',1,tkVariant,nil,__VarComplexSimplify,false,0);
    DefineMethod('VarComplexAbsSqr',1,tkVariant,nil,__VarComplexAbsSqr,false,0);
    DefineMethod('VarComplexAbs',1,tkVariant,nil,__VarComplexAbs,false,0);
    DefineMethod('VarComplexAngle',1,tkVariant,nil,__VarComplexAngle,false,0);
    DefineMethod('VarComplexSign',1,tkVariant,nil,__VarComplexSign,false,0);
    DefineMethod('VarComplexConjugate',1,tkVariant,nil,__VarComplexConjugate,false,0);
    DefineMethod('VarComplexInverse',1,tkVariant,nil,__VarComplexInverse,false,0);
    DefineMethod('VarComplexExp',1,tkVariant,nil,__VarComplexExp,false,0);
    DefineMethod('VarComplexLn',1,tkVariant,nil,__VarComplexLn,false,0);
    DefineMethod('VarComplexLog2',1,tkVariant,nil,__VarComplexLog2,false,0);
    DefineMethod('VarComplexLog10',1,tkVariant,nil,__VarComplexLog10,false,0);
    DefineMethod('VarComplexLogN',2,tkVariant,nil,__VarComplexLogN,false,0);
    DefineMethod('VarComplexSqr',1,tkVariant,nil,__VarComplexSqr,false,0);
    DefineMethod('VarComplexSqrt',1,tkVariant,nil,__VarComplexSqrt,false,0);
    DefineMethod('VarComplexPower',2,tkVariant,nil,__VarComplexPower,false,0);
    DefineMethod('VarComplexTimesPosI',1,tkVariant,nil,__VarComplexTimesPosI,false,0);
    DefineMethod('VarComplexTimesNegI',1,tkVariant,nil,__VarComplexTimesNegI,false,0);
    DefineMethod('VarComplexTimesImaginary',2,tkVariant,nil,__VarComplexTimesImaginary,false,0);
    DefineMethod('VarComplexTimesReal',2,tkVariant,nil,__VarComplexTimesReal,false,0);
    DefineMethod('VarComplexCos',1,tkVariant,nil,__VarComplexCos,false,0);
    DefineMethod('VarComplexSin',1,tkVariant,nil,__VarComplexSin,false,0);
    DefineMethod('VarComplexTan',1,tkVariant,nil,__VarComplexTan,false,0);
    DefineMethod('VarComplexCot',1,tkVariant,nil,__VarComplexCot,false,0);
    DefineMethod('VarComplexSec',1,tkVariant,nil,__VarComplexSec,false,0);
    DefineMethod('VarComplexCsc',1,tkVariant,nil,__VarComplexCsc,false,0);
    DefineMethod('VarComplexArcCos',1,tkVariant,nil,__VarComplexArcCos,false,0);
    DefineMethod('VarComplexArcSin',1,tkVariant,nil,__VarComplexArcSin,false,0);
    DefineMethod('VarComplexArcTan',1,tkVariant,nil,__VarComplexArcTan,false,0);
    DefineMethod('VarComplexArcCot',1,tkVariant,nil,__VarComplexArcCot,false,0);
    DefineMethod('VarComplexArcSec',1,tkVariant,nil,__VarComplexArcSec,false,0);
    DefineMethod('VarComplexArcCsc',1,tkVariant,nil,__VarComplexArcCsc,false,0);
    DefineMethod('VarComplexCosH',1,tkVariant,nil,__VarComplexCosH,false,0);
    DefineMethod('VarComplexSinH',1,tkVariant,nil,__VarComplexSinH,false,0);
    DefineMethod('VarComplexTanH',1,tkVariant,nil,__VarComplexTanH,false,0);
    DefineMethod('VarComplexCotH',1,tkVariant,nil,__VarComplexCotH,false,0);
    DefineMethod('VarComplexSecH',1,tkVariant,nil,__VarComplexSecH,false,0);
    DefineMethod('VarComplexCscH',1,tkVariant,nil,__VarComplexCscH,false,0);
    DefineMethod('VarComplexArcCosH',1,tkVariant,nil,__VarComplexArcCosH,false,0);
    DefineMethod('VarComplexArcSinH',1,tkVariant,nil,__VarComplexArcSinH,false,0);
    DefineMethod('VarComplexArcTanH',1,tkVariant,nil,__VarComplexArcTanH,false,0);
    DefineMethod('VarComplexArcCotH',1,tkVariant,nil,__VarComplexArcCotH,false,0);
    DefineMethod('VarComplexArcSecH',1,tkVariant,nil,__VarComplexArcSecH,false,0);
    DefineMethod('VarComplexArcCscH',1,tkVariant,nil,__VarComplexArcCscH,false,0);
    DefineMethod('VarComplexToPolar',4,tkNone,nil,__VarComplexToPolar,false,1).SetVarArgs([1,2]);
    DefineMethod('VarComplexFromPolar',2,tkVariant,nil,__VarComplexFromPolar,false,0);
    DefineProp('ComplexNumberSymbol',tkVariant,__GetComplexNumberSymbol,__SetComplexNumberSymbol,nil,false,0);
    DefineProp('ComplexNumberSymbolBeforeImaginary',tkVariant,__GetComplexNumberSymbolBeforeImaginary,__SetComplexNumberSymbolBeforeImaginary,nil,false,0);
    DefineProp('ComplexNumberDefuzzAtZero',tkVariant,__GetComplexNumberDefuzzAtZero,__SetComplexNumberDefuzzAtZero,nil,false,0);
  end;
end;

class function TatVarCmplxLibrary.LibraryName: string;
begin
  result := 'VarCmplx';
end;

initialization
  RegisterScripterLibrary(TatVarCmplxLibrary, True);

{$WARNINGS ON}

end.

