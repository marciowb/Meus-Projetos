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
unit ap_VarUtils;

interface

uses
  SysUtils,
  Types,
  VarUtils,
  Variants,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatVarUtilsLibrary = class(TatScripterLibrary)
    procedure __VarExceptionToResult(AMachine: TatVirtualMachine);
    procedure __VariantInit(AMachine: TatVirtualMachine);
    procedure __VariantClear(AMachine: TatVirtualMachine);
    procedure __VariantCopy(AMachine: TatVirtualMachine);
    procedure __VariantCopyInd(AMachine: TatVirtualMachine);
    procedure __VariantChangeType(AMachine: TatVirtualMachine);
    procedure __VariantChangeTypeEx(AMachine: TatVirtualMachine);
    procedure __VarNeg(AMachine: TatVirtualMachine);
    procedure __VarNot(AMachine: TatVirtualMachine);
    procedure __VarCmp(AMachine: TatVirtualMachine);
    procedure __VarAdd(AMachine: TatVirtualMachine);
    procedure __VarSub(AMachine: TatVirtualMachine);
    procedure __VarMul(AMachine: TatVirtualMachine);
    procedure __VarDiv(AMachine: TatVirtualMachine);
    procedure __VarIDiv(AMachine: TatVirtualMachine);
    procedure __VarMod(AMachine: TatVirtualMachine);
    procedure __VarAnd(AMachine: TatVirtualMachine);
    procedure __VarOr(AMachine: TatVirtualMachine);
    procedure __VarXor(AMachine: TatVirtualMachine);
    procedure __VarI4FromStr(AMachine: TatVirtualMachine);
    procedure __VarR4FromStr(AMachine: TatVirtualMachine);
    procedure __VarR8FromStr(AMachine: TatVirtualMachine);
    procedure __VarDateFromStr(AMachine: TatVirtualMachine);
    procedure __VarCyFromStr(AMachine: TatVirtualMachine);
    procedure __VarBoolFromStr(AMachine: TatVirtualMachine);
    procedure __VarBstrFromCy(AMachine: TatVirtualMachine);
    procedure __VarBstrFromDate(AMachine: TatVirtualMachine);
    procedure __VarBstrFromBool(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  TVarTypeToElementInfoWrapper = class(TatRecordWrapper)
  private
    FValidBase: Boolean;
    FValidElement: Boolean;
    FSize: Integer;
    FFlags: Word;
  public
    constructor Create(ARecord: TVarTypeToElementInfo);
    function ObjToRec: TVarTypeToElementInfo;
  published
    property ValidBase: Boolean read FValidBase write FValidBase;
    property ValidElement: Boolean read FValidElement write FValidElement;
    property Size: Integer read FSize write FSize;
    property Flags: Word read FFlags write FFlags;
  end;
  

implementation

constructor TVarTypeToElementInfoWrapper.Create(ARecord: TVarTypeToElementInfo);
begin
  inherited Create;
  FValidBase := ARecord.ValidBase;
  FValidElement := ARecord.ValidElement;
  FSize := ARecord.Size;
  FFlags := ARecord.Flags;
end;

function TVarTypeToElementInfoWrapper.ObjToRec: TVarTypeToElementInfo;
begin
  result.ValidBase := FValidBase;
  result.ValidElement := FValidElement;
  result.Size := FSize;
  result.Flags := FFlags;
end;



procedure TatVarUtilsLibrary.__VarExceptionToResult(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(VarUtils.VarExceptionToResult(Exception(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarUtilsLibrary.__VariantInit(AMachine: TatVirtualMachine);
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
AResult := Integer(VarUtils.VariantInit(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TVarDataWrapper.Create(Param0)));
  end;
end;

procedure TatVarUtilsLibrary.__VariantClear(AMachine: TatVirtualMachine);
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
AResult := Integer(VarUtils.VariantClear(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TVarDataWrapper.Create(Param0)));
  end;
end;

procedure TatVarUtilsLibrary.__VariantCopy(AMachine: TatVirtualMachine);
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
AResult := Integer(VarUtils.VariantCopy(Param0,TVarDataWrapper(integer(GetInputArg(1))).ObjToRec));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TVarDataWrapper.Create(Param0)));
  end;
end;

procedure TatVarUtilsLibrary.__VariantCopyInd(AMachine: TatVirtualMachine);
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
AResult := Integer(VarUtils.VariantCopyInd(Param0,TVarDataWrapper(integer(GetInputArg(1))).ObjToRec));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TVarDataWrapper.Create(Param0)));
  end;
end;

procedure TatVarUtilsLibrary.__VariantChangeType(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TVarData;
  Param3: Word;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TVarDataWrapper) then 
  Param0Rec := TVarDataWrapper.Create(Param0);
Param0 := TVarDataWrapper(Param0Rec).ObjToRec;
Param3 := VarToInteger(GetInputArg(3));
AResult := Integer(VarUtils.VariantChangeType(Param0,TVarDataWrapper(integer(GetInputArg(1))).ObjToRec,VarToInteger(GetInputArg(2)),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TVarDataWrapper.Create(Param0)));
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatVarUtilsLibrary.__VariantChangeTypeEx(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TVarData;
  Param4: Word;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TVarDataWrapper) then 
  Param0Rec := TVarDataWrapper.Create(Param0);
Param0 := TVarDataWrapper(Param0Rec).ObjToRec;
Param4 := VarToInteger(GetInputArg(4));
AResult := Integer(VarUtils.VariantChangeTypeEx(Param0,TVarDataWrapper(integer(GetInputArg(1))).ObjToRec,VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)),Param4));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TVarDataWrapper.Create(Param0)));
    SetInputArg(4,Integer(Param4));
  end;
end;

procedure TatVarUtilsLibrary.__VarNeg(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TVarData;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TVarDataWrapper) then 
  Param1Rec := TVarDataWrapper.Create(Param1);
Param1 := TVarDataWrapper(Param1Rec).ObjToRec;
AResult := Integer(VarUtils.VarNeg(TVarDataWrapper(integer(GetInputArg(0))).ObjToRec,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TVarDataWrapper.Create(Param1)));
  end;
end;

procedure TatVarUtilsLibrary.__VarNot(AMachine: TatVirtualMachine);
  var
  Param1Rec: TObject;
  Param1: TVarData;
  AResult: variant;
begin
  with AMachine do
  begin
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is TVarDataWrapper) then 
  Param1Rec := TVarDataWrapper.Create(Param1);
Param1 := TVarDataWrapper(Param1Rec).ObjToRec;
AResult := Integer(VarUtils.VarNot(TVarDataWrapper(integer(GetInputArg(0))).ObjToRec,Param1));
    ReturnOutputArg(AResult);
    SetInputArg(1,integer(TVarDataWrapper.Create(Param1)));
  end;
end;

procedure TatVarUtilsLibrary.__VarCmp(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(VarUtils.VarCmp(TVarDataWrapper(integer(GetInputArg(0))).ObjToRec,TVarDataWrapper(integer(GetInputArg(1))).ObjToRec,VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarUtilsLibrary.__VarAdd(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: TVarData;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is TVarDataWrapper) then 
  Param2Rec := TVarDataWrapper.Create(Param2);
Param2 := TVarDataWrapper(Param2Rec).ObjToRec;
AResult := Integer(VarUtils.VarAdd(TVarDataWrapper(integer(GetInputArg(0))).ObjToRec,TVarDataWrapper(integer(GetInputArg(1))).ObjToRec,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(TVarDataWrapper.Create(Param2)));
  end;
end;

procedure TatVarUtilsLibrary.__VarSub(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: TVarData;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is TVarDataWrapper) then 
  Param2Rec := TVarDataWrapper.Create(Param2);
Param2 := TVarDataWrapper(Param2Rec).ObjToRec;
AResult := Integer(VarUtils.VarSub(TVarDataWrapper(integer(GetInputArg(0))).ObjToRec,TVarDataWrapper(integer(GetInputArg(1))).ObjToRec,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(TVarDataWrapper.Create(Param2)));
  end;
end;

procedure TatVarUtilsLibrary.__VarMul(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: TVarData;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is TVarDataWrapper) then 
  Param2Rec := TVarDataWrapper.Create(Param2);
Param2 := TVarDataWrapper(Param2Rec).ObjToRec;
AResult := Integer(VarUtils.VarMul(TVarDataWrapper(integer(GetInputArg(0))).ObjToRec,TVarDataWrapper(integer(GetInputArg(1))).ObjToRec,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(TVarDataWrapper.Create(Param2)));
  end;
end;

procedure TatVarUtilsLibrary.__VarDiv(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: TVarData;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is TVarDataWrapper) then 
  Param2Rec := TVarDataWrapper.Create(Param2);
Param2 := TVarDataWrapper(Param2Rec).ObjToRec;
AResult := Integer(VarUtils.VarDiv(TVarDataWrapper(integer(GetInputArg(0))).ObjToRec,TVarDataWrapper(integer(GetInputArg(1))).ObjToRec,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(TVarDataWrapper.Create(Param2)));
  end;
end;

procedure TatVarUtilsLibrary.__VarIDiv(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: TVarData;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is TVarDataWrapper) then 
  Param2Rec := TVarDataWrapper.Create(Param2);
Param2 := TVarDataWrapper(Param2Rec).ObjToRec;
AResult := Integer(VarUtils.VarIDiv(TVarDataWrapper(integer(GetInputArg(0))).ObjToRec,TVarDataWrapper(integer(GetInputArg(1))).ObjToRec,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(TVarDataWrapper.Create(Param2)));
  end;
end;

procedure TatVarUtilsLibrary.__VarMod(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: TVarData;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is TVarDataWrapper) then 
  Param2Rec := TVarDataWrapper.Create(Param2);
Param2 := TVarDataWrapper(Param2Rec).ObjToRec;
AResult := Integer(VarUtils.VarMod(TVarDataWrapper(integer(GetInputArg(0))).ObjToRec,TVarDataWrapper(integer(GetInputArg(1))).ObjToRec,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(TVarDataWrapper.Create(Param2)));
  end;
end;

procedure TatVarUtilsLibrary.__VarAnd(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: TVarData;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is TVarDataWrapper) then 
  Param2Rec := TVarDataWrapper.Create(Param2);
Param2 := TVarDataWrapper(Param2Rec).ObjToRec;
AResult := Integer(VarUtils.VarAnd(TVarDataWrapper(integer(GetInputArg(0))).ObjToRec,TVarDataWrapper(integer(GetInputArg(1))).ObjToRec,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(TVarDataWrapper.Create(Param2)));
  end;
end;

procedure TatVarUtilsLibrary.__VarOr(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: TVarData;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is TVarDataWrapper) then 
  Param2Rec := TVarDataWrapper.Create(Param2);
Param2 := TVarDataWrapper(Param2Rec).ObjToRec;
AResult := Integer(VarUtils.VarOr(TVarDataWrapper(integer(GetInputArg(0))).ObjToRec,TVarDataWrapper(integer(GetInputArg(1))).ObjToRec,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(TVarDataWrapper.Create(Param2)));
  end;
end;

procedure TatVarUtilsLibrary.__VarXor(AMachine: TatVirtualMachine);
  var
  Param2Rec: TObject;
  Param2: TVarData;
  AResult: variant;
begin
  with AMachine do
  begin
Param2Rec := TObject(integer(GetInputArg(2)));
if not Assigned(Param2Rec) or not (Param2Rec is TVarDataWrapper) then 
  Param2Rec := TVarDataWrapper.Create(Param2);
Param2 := TVarDataWrapper(Param2Rec).ObjToRec;
AResult := Integer(VarUtils.VarXor(TVarDataWrapper(integer(GetInputArg(0))).ObjToRec,TVarDataWrapper(integer(GetInputArg(1))).ObjToRec,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(2,integer(TVarDataWrapper.Create(Param2)));
  end;
end;

procedure TatVarUtilsLibrary.__VarI4FromStr(AMachine: TatVirtualMachine);
  var
  Param3: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
AResult := Integer(VarUtils.VarI4FromStr(GetInputArg(0),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatVarUtilsLibrary.__VarR4FromStr(AMachine: TatVirtualMachine);
  var
  Param3: Single;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := GetInputArg(3);
AResult := Integer(VarUtils.VarR4FromStr(GetInputArg(0),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Param3);
  end;
end;

procedure TatVarUtilsLibrary.__VarR8FromStr(AMachine: TatVirtualMachine);
  var
  Param3: Double;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := GetInputArg(3);
AResult := Integer(VarUtils.VarR8FromStr(GetInputArg(0),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Param3);
  end;
end;

procedure TatVarUtilsLibrary.__VarDateFromStr(AMachine: TatVirtualMachine);
  var
  Param3: TDateTime;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := GetInputArg(3);
AResult := Integer(VarUtils.VarDateFromStr(GetInputArg(0),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Param3);
  end;
end;

procedure TatVarUtilsLibrary.__VarCyFromStr(AMachine: TatVirtualMachine);
  var
  Param3: Currency;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := GetInputArg(3);
AResult := Integer(VarUtils.VarCyFromStr(GetInputArg(0),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Param3);
  end;
end;

procedure TatVarUtilsLibrary.__VarBoolFromStr(AMachine: TatVirtualMachine);
  var
  Param3: WordBool;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := GetInputArg(3);
AResult := Integer(VarUtils.VarBoolFromStr(GetInputArg(0),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Param3);
  end;
end;

procedure TatVarUtilsLibrary.__VarBstrFromCy(AMachine: TatVirtualMachine);
  var
  Param3: WideString;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := GetInputArg(3);
AResult := Integer(VarUtils.VarBstrFromCy(GetInputArg(0),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Param3);
  end;
end;

procedure TatVarUtilsLibrary.__VarBstrFromDate(AMachine: TatVirtualMachine);
  var
  Param3: WideString;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := GetInputArg(3);
AResult := Integer(VarUtils.VarBstrFromDate(GetInputArg(0),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Param3);
  end;
end;

procedure TatVarUtilsLibrary.__VarBstrFromBool(AMachine: TatVirtualMachine);
  var
  Param3: WideString;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := GetInputArg(3);
AResult := Integer(VarUtils.VarBstrFromBool(GetInputArg(0),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(3,Param3);
  end;
end;

procedure TatVarUtilsLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('VarExceptionToResult',1,tkInteger,nil,__VarExceptionToResult,false,0);
    DefineMethod('VariantInit',1,tkInteger,nil,__VariantInit,false,0).SetVarArgs([0]);
    DefineMethod('VariantClear',1,tkInteger,nil,__VariantClear,false,0).SetVarArgs([0]);
    DefineMethod('VariantCopy',2,tkInteger,nil,__VariantCopy,false,0).SetVarArgs([0]);
    DefineMethod('VariantCopyInd',2,tkInteger,nil,__VariantCopyInd,false,0).SetVarArgs([0]);
    DefineMethod('VariantChangeType',4,tkInteger,nil,__VariantChangeType,false,0).SetVarArgs([0,3]);
    DefineMethod('VariantChangeTypeEx',5,tkInteger,nil,__VariantChangeTypeEx,false,0).SetVarArgs([0,4]);
    DefineMethod('VarNeg',2,tkInteger,nil,__VarNeg,false,0).SetVarArgs([1]);
    DefineMethod('VarNot',2,tkInteger,nil,__VarNot,false,0).SetVarArgs([1]);
    DefineMethod('VarCmp',4,tkInteger,nil,__VarCmp,false,0);
    DefineMethod('VarAdd',3,tkInteger,nil,__VarAdd,false,0).SetVarArgs([2]);
    DefineMethod('VarSub',3,tkInteger,nil,__VarSub,false,0).SetVarArgs([2]);
    DefineMethod('VarMul',3,tkInteger,nil,__VarMul,false,0).SetVarArgs([2]);
    DefineMethod('VarDiv',3,tkInteger,nil,__VarDiv,false,0).SetVarArgs([2]);
    DefineMethod('VarIDiv',3,tkInteger,nil,__VarIDiv,false,0).SetVarArgs([2]);
    DefineMethod('VarMod',3,tkInteger,nil,__VarMod,false,0).SetVarArgs([2]);
    DefineMethod('VarAnd',3,tkInteger,nil,__VarAnd,false,0).SetVarArgs([2]);
    DefineMethod('VarOr',3,tkInteger,nil,__VarOr,false,0).SetVarArgs([2]);
    DefineMethod('VarXor',3,tkInteger,nil,__VarXor,false,0).SetVarArgs([2]);
    DefineMethod('VarI4FromStr',4,tkInteger,nil,__VarI4FromStr,false,0).SetVarArgs([3]);
    DefineMethod('VarR4FromStr',4,tkInteger,nil,__VarR4FromStr,false,0).SetVarArgs([3]);
    DefineMethod('VarR8FromStr',4,tkInteger,nil,__VarR8FromStr,false,0).SetVarArgs([3]);
    DefineMethod('VarDateFromStr',4,tkInteger,nil,__VarDateFromStr,false,0).SetVarArgs([3]);
    DefineMethod('VarCyFromStr',4,tkInteger,nil,__VarCyFromStr,false,0).SetVarArgs([3]);
    DefineMethod('VarBoolFromStr',4,tkInteger,nil,__VarBoolFromStr,false,0).SetVarArgs([3]);
    DefineMethod('VarBstrFromCy',4,tkInteger,nil,__VarBstrFromCy,false,0).SetVarArgs([3]);
    DefineMethod('VarBstrFromDate',4,tkInteger,nil,__VarBstrFromDate,false,0).SetVarArgs([3]);
    DefineMethod('VarBstrFromBool',4,tkInteger,nil,__VarBstrFromBool,false,0).SetVarArgs([3]);
    AddConstant('GenericVarUtils',GenericVarUtils);
    AddConstant('GenericVariants',GenericVariants);
    AddConstant('GenericOperations',GenericOperations);
    AddConstant('GenericSafeArrays',GenericSafeArrays);
    AddConstant('GenericSafeArrayUsesLibC',GenericSafeArrayUsesLibC);
    AddConstant('VAR_OK',VAR_OK);
    AddConstant('VAR_PARAMNOTFOUND',VAR_PARAMNOTFOUND);
    AddConstant('VAR_TYPEMISMATCH',VAR_TYPEMISMATCH);
    AddConstant('VAR_BADVARTYPE',VAR_BADVARTYPE);
    AddConstant('VAR_EXCEPTION',VAR_EXCEPTION);
    AddConstant('VAR_OVERFLOW',VAR_OVERFLOW);
    AddConstant('VAR_BADINDEX',VAR_BADINDEX);
    AddConstant('VAR_ARRAYISLOCKED',VAR_ARRAYISLOCKED);
    AddConstant('VAR_NOTIMPL',VAR_NOTIMPL);
    AddConstant('VAR_OUTOFMEMORY',VAR_OUTOFMEMORY);
    AddConstant('VAR_INVALIDARG',VAR_INVALIDARG);
    AddConstant('VAR_UNEXPECTED',VAR_UNEXPECTED);
    AddConstant('ARR_NONE',ARR_NONE);
    AddConstant('ARR_FIXEDSIZE',ARR_FIXEDSIZE);
    AddConstant('ARR_OLESTR',ARR_OLESTR);
    AddConstant('ARR_UNKNOWN',ARR_UNKNOWN);
    AddConstant('ARR_DISPATCH',ARR_DISPATCH);
    AddConstant('ARR_VARIANT',ARR_VARIANT);
    AddConstant('VAR_CMP_LT',VAR_CMP_LT);
    AddConstant('VAR_CMP_EQ',VAR_CMP_EQ);
    AddConstant('VAR_CMP_GT',VAR_CMP_GT);
    AddConstant('VAR_CMP_NULL',VAR_CMP_NULL);
    AddConstant('VAR_LOCALE_USER_DEFAULT',VAR_LOCALE_USER_DEFAULT);
    AddConstant('CMinArrayVarType',CMinArrayVarType);
    AddConstant('CMaxArrayVarType',CMaxArrayVarType);
  end;
end;

class function TatVarUtilsLibrary.LibraryName: string;
begin
  result := 'VarUtils';
end;

initialization
  RegisterScripterLibrary(TatVarUtilsLibrary, True);

{$WARNINGS ON}

end.

