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
unit ap_FMTBcd;

interface

uses
  SysUtils,
  Variants,
  FMTBcd,
  atScript;

{$WARNINGS OFF}

type
  TatFMTBcdLibrary = class(TatScripterLibrary)
    procedure __BcdPrecision(AMachine: TatVirtualMachine);
    procedure __BcdScale(AMachine: TatVirtualMachine);
    procedure __IsBcdNegative(AMachine: TatVirtualMachine);
    procedure __BcdAdd(AMachine: TatVirtualMachine);
    procedure __BcdSubtract(AMachine: TatVirtualMachine);
    procedure __NormalizeBcd(AMachine: TatVirtualMachine);
    procedure __BcdMultiply(AMachine: TatVirtualMachine);
    procedure __BcdDivide(AMachine: TatVirtualMachine);
    procedure __VarFMTBcdCreate(AMachine: TatVirtualMachine);
    procedure __VarIsFMTBcd(AMachine: TatVirtualMachine);
    procedure __VarFMTBcd(AMachine: TatVirtualMachine);
    procedure __StrToBcd(AMachine: TatVirtualMachine);
    procedure __TryStrToBcd(AMachine: TatVirtualMachine);
    procedure __DoubleToBcd(AMachine: TatVirtualMachine);
    procedure __IntegerToBcd(AMachine: TatVirtualMachine);
    procedure __VarToBcd(AMachine: TatVirtualMachine);
    procedure __CurrToBCD(AMachine: TatVirtualMachine);
    procedure __BcdToStr(AMachine: TatVirtualMachine);
    procedure __BcdToDouble(AMachine: TatVirtualMachine);
    procedure __BcdToInteger(AMachine: TatVirtualMachine);
    procedure __BCDToCurr(AMachine: TatVirtualMachine);
    procedure __BcdToStrF(AMachine: TatVirtualMachine);
    procedure __FormatBcd(AMachine: TatVirtualMachine);
    procedure __BcdCompare(AMachine: TatVirtualMachine);
    procedure __GetNullBcd(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  EBcdExceptionClass = class of EBcdException;
  EBcdOverflowExceptionClass = class of EBcdOverflowException;


  TBcdWrapper = class(TatRecordWrapper)
  private
    FPrecision: Byte;
    FSignSpecialPlaces: Byte;
  public
    constructor Create(ARecord: TBcd);
    function ObjToRec: TBcd;
  published
    property Precision: Byte read FPrecision write FPrecision;
    property SignSpecialPlaces: Byte read FSignSpecialPlaces write FSignSpecialPlaces;
  end;
  

implementation

constructor TBcdWrapper.Create(ARecord: TBcd);
begin
  inherited Create;
  FPrecision := ARecord.Precision;
  FSignSpecialPlaces := ARecord.SignSpecialPlaces;
end;

function TBcdWrapper.ObjToRec: TBcd;
begin
  result.Precision := FPrecision;
  result.SignSpecialPlaces := FSignSpecialPlaces;
end;



procedure TatFMTBcdLibrary.__BcdPrecision(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(FMTBcd.BcdPrecision(TBcdWrapper(integer(GetInputArg(0))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFMTBcdLibrary.__BcdScale(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(FMTBcd.BcdScale(TBcdWrapper(integer(GetInputArg(0))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFMTBcdLibrary.__IsBcdNegative(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := FMTBcd.IsBcdNegative(TBcdWrapper(integer(GetInputArg(0))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFMTBcdLibrary.__BcdAdd(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: TBcd;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is TBcdWrapper) then 
  Param2Rec := TBcdWrapper.Create(Param2);
Param2 := TBcdWrapper(Param2Rec).ObjToRec;
    FMTBcd.BcdAdd(TBcdWrapper(integer(GetInputArg(0))).ObjToRec,TBcdWrapper(integer(GetInputArg(1))).ObjToRec,Param2);
    SetInputArg(2,integer(TBcdWrapper.Create(Param2)));
  end;
end;

procedure TatFMTBcdLibrary.__BcdSubtract(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: TBcd;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is TBcdWrapper) then 
  Param2Rec := TBcdWrapper.Create(Param2);
Param2 := TBcdWrapper(Param2Rec).ObjToRec;
    FMTBcd.BcdSubtract(TBcdWrapper(integer(GetInputArg(0))).ObjToRec,TBcdWrapper(integer(GetInputArg(1))).ObjToRec,Param2);
    SetInputArg(2,integer(TBcdWrapper.Create(Param2)));
  end;
end;

procedure TatFMTBcdLibrary.__NormalizeBcd(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TBcd;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TBcdWrapper) then 
  Param1Rec := TBcdWrapper.Create(Param1);
Param1 := TBcdWrapper(Param1Rec).ObjToRec;
AResult := FMTBcd.NormalizeBcd(TBcdWrapper(integer(GetInputArg(0))).ObjToRec,Param1,VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TBcdWrapper.Create(Param1)));
  end;
end;

procedure TatFMTBcdLibrary.__BcdMultiply(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: TBcd;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is TBcdWrapper) then 
  Param2Rec := TBcdWrapper.Create(Param2);
Param2 := TBcdWrapper(Param2Rec).ObjToRec;
    FMTBcd.BcdMultiply(TBcdWrapper(integer(GetInputArg(0))).ObjToRec,TBcdWrapper(integer(GetInputArg(1))).ObjToRec,Param2);
    SetInputArg(2,integer(TBcdWrapper.Create(Param2)));
  end;
end;

procedure TatFMTBcdLibrary.__BcdDivide(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: TBcd;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is TBcdWrapper) then 
  Param2Rec := TBcdWrapper.Create(Param2);
Param2 := TBcdWrapper(Param2Rec).ObjToRec;
    FMTBcd.BcdDivide(GetInputArg(0),GetInputArg(1),Param2);
    SetInputArg(2,integer(TBcdWrapper.Create(Param2)));
  end;
end;

procedure TatFMTBcdLibrary.__VarFMTBcdCreate(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    FMTBcd.VarFMTBcdCreate(Param0,TBcdWrapper(integer(GetInputArg(1))).ObjToRec);
    SetInputArg(0,Param0);
  end;
end;

procedure TatFMTBcdLibrary.__VarIsFMTBcd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := FMTBcd.VarIsFMTBcd(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFMTBcdLibrary.__VarFMTBcd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(FMTBcd.VarFMTBcd);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFMTBcdLibrary.__StrToBcd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TBcdWrapper.Create(FMTBcd.StrToBcd(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFMTBcdLibrary.__TryStrToBcd(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TBcd;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TBcdWrapper) then 
  Param1Rec := TBcdWrapper.Create(Param1);
Param1 := TBcdWrapper(Param1Rec).ObjToRec;
AResult := FMTBcd.TryStrToBcd(GetInputArg(0),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TBcdWrapper.Create(Param1)));
  end;
end;

procedure TatFMTBcdLibrary.__DoubleToBcd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TBcdWrapper.Create(FMTBcd.DoubleToBcd(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFMTBcdLibrary.__IntegerToBcd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TBcdWrapper.Create(FMTBcd.IntegerToBcd(VarToInteger(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFMTBcdLibrary.__VarToBcd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TBcdWrapper.Create(FMTBcd.VarToBcd(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFMTBcdLibrary.__CurrToBCD(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TBcd;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TBcdWrapper) then 
  Param1Rec := TBcdWrapper.Create(Param1);
Param1 := TBcdWrapper(Param1Rec).ObjToRec;
case InputArgCount of
2: AResult := FMTBcd.CurrToBCD(GetInputArg(0),Param1);
3: AResult := FMTBcd.CurrToBCD(GetInputArg(0),Param1,VarToInteger(GetInputArg(2)));
4: AResult := FMTBcd.CurrToBCD(GetInputArg(0),Param1,VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
end;
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TBcdWrapper.Create(Param1)));
  end;
end;

procedure TatFMTBcdLibrary.__BcdToStr(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := FMTBcd.BcdToStr(TBcdWrapper(integer(GetInputArg(0))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFMTBcdLibrary.__BcdToDouble(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := FMTBcd.BcdToDouble(TBcdWrapper(integer(GetInputArg(0))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFMTBcdLibrary.__BcdToInteger(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := Integer(FMTBcd.BcdToInteger(TBcdWrapper(integer(GetInputArg(0))).ObjToRec));
2: AResult := Integer(FMTBcd.BcdToInteger(TBcdWrapper(integer(GetInputArg(0))).ObjToRec,GetInputArg(1)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFMTBcdLibrary.__BCDToCurr(AMachine: TatVirtualMachine);
  var
  Param1: Currency;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := FMTBcd.BCDToCurr(TBcdWrapper(integer(GetInputArg(0))).ObjToRec,Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatFMTBcdLibrary.__BcdToStrF(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := FMTBcd.BcdToStrF(TBcdWrapper(integer(GetInputArg(0))).ObjToRec,GetInputArg(1),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFMTBcdLibrary.__FormatBcd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := FMTBcd.FormatBcd(GetInputArg(0),TBcdWrapper(integer(GetInputArg(1))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFMTBcdLibrary.__BcdCompare(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(FMTBcd.BcdCompare(TBcdWrapper(integer(GetInputArg(0))).ObjToRec,TBcdWrapper(integer(GetInputArg(1))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatFMTBcdLibrary.__GetNullBcd(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TBcdWrapper.Create(FMTBcd.NullBcd)));
  end;
end;

procedure TatFMTBcdLibrary.Init;
begin
  With Scripter.DefineClass(EBcdException) do
  begin
  end;
  With Scripter.DefineClass(EBcdOverflowException) do
  begin
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('BcdPrecision',1,tkInteger,nil,__BcdPrecision,false,0);
    DefineMethod('BcdScale',1,tkInteger,nil,__BcdScale,false,0);
    DefineMethod('IsBcdNegative',1,tkVariant,nil,__IsBcdNegative,false,0);
    DefineMethod('BcdAdd',3,tkNone,nil,__BcdAdd,false,0).SetVarArgs([2]);
    DefineMethod('BcdSubtract',3,tkNone,nil,__BcdSubtract,false,0).SetVarArgs([2]);
    DefineMethod('NormalizeBcd',4,tkVariant,nil,__NormalizeBcd,false,0).SetVarArgs([1]);
    DefineMethod('BcdMultiply',3,tkNone,nil,__BcdMultiply,false,0).SetVarArgs([2]);
    DefineMethod('BcdDivide',3,tkNone,nil,__BcdDivide,false,0).SetVarArgs([2]);
    DefineMethod('VarFMTBcdCreate',2,tkNone,nil,__VarFMTBcdCreate,false,0).SetVarArgs([0]);
    DefineMethod('VarIsFMTBcd',1,tkVariant,nil,__VarIsFMTBcd,false,0);
    DefineMethod('VarFMTBcd',0,tkInteger,nil,__VarFMTBcd,false,0);
    DefineMethod('StrToBcd',1,tkVariant,nil,__StrToBcd,false,0);
    DefineMethod('TryStrToBcd',2,tkVariant,nil,__TryStrToBcd,false,0).SetVarArgs([1]);
    DefineMethod('DoubleToBcd',1,tkVariant,nil,__DoubleToBcd,false,0);
    DefineMethod('IntegerToBcd',1,tkVariant,nil,__IntegerToBcd,false,0);
    DefineMethod('VarToBcd',1,tkVariant,nil,__VarToBcd,false,0);
    DefineMethod('CurrToBCD',4,tkVariant,nil,__CurrToBCD,false,2).SetVarArgs([1]);
    DefineMethod('BcdToStr',1,tkVariant,nil,__BcdToStr,false,0);
    DefineMethod('BcdToDouble',1,tkVariant,nil,__BcdToDouble,false,0);
    DefineMethod('BcdToInteger',2,tkInteger,nil,__BcdToInteger,false,1);
    DefineMethod('BCDToCurr',2,tkVariant,nil,__BCDToCurr,false,0).SetVarArgs([1]);
    DefineMethod('BcdToStrF',4,tkVariant,nil,__BcdToStrF,false,0);
    DefineMethod('FormatBcd',2,tkVariant,nil,__FormatBcd,false,0);
    DefineMethod('BcdCompare',2,tkInteger,nil,__BcdCompare,false,0);
    DefineProp('NullBcd',tkVariant,__GetNullBcd,nil,nil,false,0);
    AddConstant('MaxStringDigits',MaxStringDigits);
    AddConstant('_NoDecimal',_NoDecimal);
    AddConstant('_DefaultDecimals',_DefaultDecimals);
    AddConstant('MaxFMTBcdFractionSize',MaxFMTBcdFractionSize);
    AddConstant('MaxFMTBcdDigits',MaxFMTBcdDigits);
    AddConstant('DefaultFMTBcdScale',DefaultFMTBcdScale);
    AddConstant('MaxBcdPrecision',MaxBcdPrecision);
    AddConstant('MaxBcdScale',MaxBcdScale);
  end;
end;

class function TatFMTBcdLibrary.LibraryName: string;
begin
  result := 'FMTBcd';
end;

initialization
  RegisterScripterLibrary(TatFMTBcdLibrary, True);

{$WARNINGS ON}

end.

