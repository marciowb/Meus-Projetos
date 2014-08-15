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
unit ap_Math;

interface

uses
  SysUtils,
  Math,
  atScript;

{$WARNINGS OFF}

type
  TatMathLibrary = class(TatScripterLibrary)
    procedure __ArcCos(AMachine: TatVirtualMachine);
    procedure __ArcSin(AMachine: TatVirtualMachine);
    procedure __ArcTan2(AMachine: TatVirtualMachine);
    procedure __SinCos(AMachine: TatVirtualMachine);
    procedure __Tan(AMachine: TatVirtualMachine);
    procedure __Cotan(AMachine: TatVirtualMachine);
    procedure __Hypot(AMachine: TatVirtualMachine);
    procedure __DegToRad(AMachine: TatVirtualMachine);
    procedure __RadToDeg(AMachine: TatVirtualMachine);
    procedure __GradToRad(AMachine: TatVirtualMachine);
    procedure __RadToGrad(AMachine: TatVirtualMachine);
    procedure __CycleToRad(AMachine: TatVirtualMachine);
    procedure __RadToCycle(AMachine: TatVirtualMachine);
    procedure __Cosh(AMachine: TatVirtualMachine);
    procedure __Sinh(AMachine: TatVirtualMachine);
    procedure __Tanh(AMachine: TatVirtualMachine);
    procedure __ArcCosh(AMachine: TatVirtualMachine);
    procedure __ArcSinh(AMachine: TatVirtualMachine);
    procedure __ArcTanh(AMachine: TatVirtualMachine);
    procedure __LnXP1(AMachine: TatVirtualMachine);
    procedure __Log10(AMachine: TatVirtualMachine);
    procedure __Log2(AMachine: TatVirtualMachine);
    procedure __LogN(AMachine: TatVirtualMachine);
    procedure __IntPower(AMachine: TatVirtualMachine);
    procedure __Power(AMachine: TatVirtualMachine);
    procedure __Frexp(AMachine: TatVirtualMachine);
    procedure __Ldexp(AMachine: TatVirtualMachine);
    procedure __Ceil(AMachine: TatVirtualMachine);
    procedure __Floor(AMachine: TatVirtualMachine);
    procedure __Min(AMachine: TatVirtualMachine);
    procedure __Max(AMachine: TatVirtualMachine);
    procedure __RandG(AMachine: TatVirtualMachine);
    procedure __DoubleDecliningBalance(AMachine: TatVirtualMachine);
    procedure __FutureValue(AMachine: TatVirtualMachine);
    procedure __InterestPayment(AMachine: TatVirtualMachine);
    procedure __InterestRate(AMachine: TatVirtualMachine);
    procedure __NumberOfPeriods(AMachine: TatVirtualMachine);
    procedure __Payment(AMachine: TatVirtualMachine);
    procedure __PeriodPayment(AMachine: TatVirtualMachine);
    procedure __PresentValue(AMachine: TatVirtualMachine);
    procedure __SLNDepreciation(AMachine: TatVirtualMachine);
    procedure __SYDDepreciation(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  EInvalidArgumentClass = class of EInvalidArgument;



implementation



procedure TatMathLibrary.__ArcCos(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Math.ArcCos(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__ArcSin(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Math.ArcSin(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__ArcTan2(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Math.ArcTan2(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__SinCos(AMachine: TatVirtualMachine);
  var
  Param1: Extended;
  Param2: Extended;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
Param2 := GetInputArg(2);
    Math.SinCos(GetInputArg(0),Param1,Param2);
    SetInputArg(1,Param1);
    SetInputArg(2,Param2);
  end;
end;

procedure TatMathLibrary.__Tan(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Math.Tan(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__Cotan(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Math.Cotan(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__Hypot(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Math.Hypot(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__DegToRad(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Math.DegToRad(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__RadToDeg(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Math.RadToDeg(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__GradToRad(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Math.GradToRad(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__RadToGrad(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Math.RadToGrad(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__CycleToRad(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Math.CycleToRad(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__RadToCycle(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Math.RadToCycle(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__Cosh(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Math.Cosh(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__Sinh(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Math.Sinh(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__Tanh(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Math.Tanh(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__ArcCosh(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Math.ArcCosh(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__ArcSinh(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Math.ArcSinh(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__ArcTanh(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Math.ArcTanh(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__LnXP1(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Math.LnXP1(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__Log10(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Math.Log10(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__Log2(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Math.Log2(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__LogN(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Math.LogN(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__IntPower(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Math.IntPower(GetInputArg(0),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__Power(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Math.Power(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__Frexp(AMachine: TatVirtualMachine);
  var
  Param1: Extended;
  Param2: Integer;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
Param2 := VarToInteger(GetInputArg(2));
    Math.Frexp(GetInputArg(0),Param1,Param2);
    SetInputArg(1,Param1);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatMathLibrary.__Ldexp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Math.Ldexp(GetInputArg(0),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__Ceil(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Math.Ceil(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__Floor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Math.Floor(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__Min(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Math.Min(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__Max(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Math.Max(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__RandG(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Math.RandG(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__DoubleDecliningBalance(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Math.DoubleDecliningBalance(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__FutureValue(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Math.FutureValue(GetInputArg(0),VarToInteger(GetInputArg(1)),GetInputArg(2),GetInputArg(3),GetInputArg(4));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__InterestPayment(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Math.InterestPayment(GetInputArg(0),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),GetInputArg(3),GetInputArg(4),GetInputArg(5));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__InterestRate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Math.InterestRate(VarToInteger(GetInputArg(0)),GetInputArg(1),GetInputArg(2),GetInputArg(3),GetInputArg(4));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__NumberOfPeriods(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Math.NumberOfPeriods(GetInputArg(0),GetInputArg(1),GetInputArg(2),GetInputArg(3),GetInputArg(4));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__Payment(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Math.Payment(GetInputArg(0),VarToInteger(GetInputArg(1)),GetInputArg(2),GetInputArg(3),GetInputArg(4));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__PeriodPayment(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Math.PeriodPayment(GetInputArg(0),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),GetInputArg(3),GetInputArg(4),GetInputArg(5));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__PresentValue(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Math.PresentValue(GetInputArg(0),VarToInteger(GetInputArg(1)),GetInputArg(2),GetInputArg(3),GetInputArg(4));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__SLNDepreciation(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Math.SLNDepreciation(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.__SYDDepreciation(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Math.SYDDepreciation(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMathLibrary.Init;
begin
  With Scripter.DefineClass(EInvalidArgument) do
  begin
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('ArcCos',1,tkVariant,nil,__ArcCos,false,0);
    DefineMethod('ArcSin',1,tkVariant,nil,__ArcSin,false,0);
    DefineMethod('ArcTan2',2,tkVariant,nil,__ArcTan2,false,0);
    DefineMethod('SinCos',3,tkNone,nil,__SinCos,false,0).SetVarArgs([1,2]);
    DefineMethod('Tan',1,tkVariant,nil,__Tan,false,0);
    DefineMethod('Cotan',1,tkVariant,nil,__Cotan,false,0);
    DefineMethod('Hypot',2,tkVariant,nil,__Hypot,false,0);
    DefineMethod('DegToRad',1,tkVariant,nil,__DegToRad,false,0);
    DefineMethod('RadToDeg',1,tkVariant,nil,__RadToDeg,false,0);
    DefineMethod('GradToRad',1,tkVariant,nil,__GradToRad,false,0);
    DefineMethod('RadToGrad',1,tkVariant,nil,__RadToGrad,false,0);
    DefineMethod('CycleToRad',1,tkVariant,nil,__CycleToRad,false,0);
    DefineMethod('RadToCycle',1,tkVariant,nil,__RadToCycle,false,0);
    DefineMethod('Cosh',1,tkVariant,nil,__Cosh,false,0);
    DefineMethod('Sinh',1,tkVariant,nil,__Sinh,false,0);
    DefineMethod('Tanh',1,tkVariant,nil,__Tanh,false,0);
    DefineMethod('ArcCosh',1,tkVariant,nil,__ArcCosh,false,0);
    DefineMethod('ArcSinh',1,tkVariant,nil,__ArcSinh,false,0);
    DefineMethod('ArcTanh',1,tkVariant,nil,__ArcTanh,false,0);
    DefineMethod('LnXP1',1,tkVariant,nil,__LnXP1,false,0);
    DefineMethod('Log10',1,tkVariant,nil,__Log10,false,0);
    DefineMethod('Log2',1,tkVariant,nil,__Log2,false,0);
    DefineMethod('LogN',2,tkVariant,nil,__LogN,false,0);
    DefineMethod('IntPower',2,tkVariant,nil,__IntPower,false,0);
    DefineMethod('Power',2,tkVariant,nil,__Power,false,0);
    DefineMethod('Frexp',3,tkNone,nil,__Frexp,false,0).SetVarArgs([1,2]);
    DefineMethod('Ldexp',2,tkVariant,nil,__Ldexp,false,0);
    DefineMethod('Ceil',1,tkInteger,nil,__Ceil,false,0);
    DefineMethod('Floor',1,tkInteger,nil,__Floor,false,0);
    DefineMethod('Min',2,tkInteger,nil,__Min,false,0);
    DefineMethod('Max',2,tkInteger,nil,__Max,false,0);
    DefineMethod('RandG',2,tkVariant,nil,__RandG,false,0);
    DefineMethod('DoubleDecliningBalance',4,tkVariant,nil,__DoubleDecliningBalance,false,0);
    DefineMethod('FutureValue',5,tkVariant,nil,__FutureValue,false,0);
    DefineMethod('InterestPayment',6,tkVariant,nil,__InterestPayment,false,0);
    DefineMethod('InterestRate',5,tkVariant,nil,__InterestRate,false,0);
    DefineMethod('NumberOfPeriods',5,tkVariant,nil,__NumberOfPeriods,false,0);
    DefineMethod('Payment',5,tkVariant,nil,__Payment,false,0);
    DefineMethod('PeriodPayment',6,tkVariant,nil,__PeriodPayment,false,0);
    DefineMethod('PresentValue',5,tkVariant,nil,__PresentValue,false,0);
    DefineMethod('SLNDepreciation',3,tkVariant,nil,__SLNDepreciation,false,0);
    DefineMethod('SYDDepreciation',4,tkVariant,nil,__SYDDepreciation,false,0);
    AddConstant('ptEndOfPeriod',ptEndOfPeriod);
    AddConstant('ptStartOfPeriod',ptStartOfPeriod);
    AddConstant('MinSingle',MinSingle);
    AddConstant('MaxSingle',MaxSingle);
    AddConstant('MinDouble',MinDouble);
    AddConstant('MaxDouble',MaxDouble);
  end;
end;

class function TatMathLibrary.LibraryName: string;
begin
  result := 'Math';
end;

initialization
  RegisterScripterLibrary(TatMathLibrary, True);

{$WARNINGS ON}

end.

