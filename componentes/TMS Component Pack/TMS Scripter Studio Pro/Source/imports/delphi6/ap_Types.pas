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
unit ap_Types;

interface

uses
  Types,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatTypesLibrary = class(TatScripterLibrary)
    procedure __EqualRect(AMachine: TatVirtualMachine);
    procedure __Rect(AMachine: TatVirtualMachine);
    procedure __Bounds(AMachine: TatVirtualMachine);
    procedure __Point(AMachine: TatVirtualMachine);
    procedure __PtInRect(AMachine: TatVirtualMachine);
    procedure __IntersectRect(AMachine: TatVirtualMachine);
    procedure __UnionRect(AMachine: TatVirtualMachine);
    procedure __IsRectEmpty(AMachine: TatVirtualMachine);
    procedure __OffsetRect(AMachine: TatVirtualMachine);
    procedure __CenterPoint(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  TPointWrapper = class(TatRecordWrapper)
  private
    FX: Longint;
    FY: Longint;
  public
    constructor Create(ARecord: TPoint);
    function ObjToRec: TPoint;
  published
    property X: Longint read FX write FX;
    property Y: Longint read FY write FY;
  end;
  
  TRectWrapper = class(TatRecordWrapper)
  private
    FLeft: Longint;
    FTop: Longint;
    FRight: Longint;
    FBottom: Longint;
  public
    constructor Create(ARecord: TRect);
    function ObjToRec: TRect;
  published
    property Left: Longint read FLeft write FLeft;
    property Top: Longint read FTop write FTop;
    property Right: Longint read FRight write FRight;
    property Bottom: Longint read FBottom write FBottom;
  end;
  
  tagSIZEWrapper = class(TatRecordWrapper)
  private
    Fcx: Longint;
    Fcy: Longint;
  public
    constructor Create(ARecord: tagSIZE);
    function ObjToRec: tagSIZE;
  published
    property cx: Longint read Fcx write Fcx;
    property cy: Longint read Fcy write Fcy;
  end;
  
  TSmallPointWrapper = class(TatRecordWrapper)
  private
    Fx: SmallInt;
    Fy: SmallInt;
  public
    constructor Create(ARecord: TSmallPoint);
    function ObjToRec: TSmallPoint;
  published
    property x: SmallInt read Fx write Fx;
    property y: SmallInt read Fy write Fy;
  end;
  

implementation

constructor TPointWrapper.Create(ARecord: TPoint);
begin
  inherited Create;
  FX := ARecord.X;
  FY := ARecord.Y;
end;

function TPointWrapper.ObjToRec: TPoint;
begin
  result.X := FX;
  result.Y := FY;
end;

constructor TRectWrapper.Create(ARecord: TRect);
begin
  inherited Create;
  FLeft := ARecord.Left;
  FTop := ARecord.Top;
  FRight := ARecord.Right;
  FBottom := ARecord.Bottom;
end;

function TRectWrapper.ObjToRec: TRect;
begin
  result.Left := FLeft;
  result.Top := FTop;
  result.Right := FRight;
  result.Bottom := FBottom;
end;

constructor tagSIZEWrapper.Create(ARecord: tagSIZE);
begin
  inherited Create;
  Fcx := ARecord.cx;
  Fcy := ARecord.cy;
end;

function tagSIZEWrapper.ObjToRec: tagSIZE;
begin
  result.cx := Fcx;
  result.cy := Fcy;
end;

constructor TSmallPointWrapper.Create(ARecord: TSmallPoint);
begin
  inherited Create;
  Fx := ARecord.x;
  Fy := ARecord.y;
end;

function TSmallPointWrapper.ObjToRec: TSmallPoint;
begin
  result.x := Fx;
  result.y := Fy;
end;



procedure TatTypesLibrary.__EqualRect(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Types.EqualRect(TRectWrapper(integer(GetInputArg(0))).ObjToRec,TRectWrapper(integer(GetInputArg(1))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTypesLibrary.__Rect(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TRectWrapper.Create(Types.Rect(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTypesLibrary.__Bounds(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TRectWrapper.Create(Types.Bounds(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTypesLibrary.__Point(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TPointWrapper.Create(Types.Point(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTypesLibrary.__PtInRect(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Types.PtInRect(TRectWrapper(integer(GetInputArg(0))).ObjToRec,TPointWrapper(integer(GetInputArg(1))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTypesLibrary.__IntersectRect(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TRect;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TRectWrapper) then 
  Param0Rec := TRectWrapper.Create(Param0);
Param0 := TRectWrapper(Param0Rec).ObjToRec;
AResult := Types.IntersectRect(Param0,TRectWrapper(integer(GetInputArg(1))).ObjToRec,TRectWrapper(integer(GetInputArg(2))).ObjToRec);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TRectWrapper.Create(Param0)));
  end;
end;

procedure TatTypesLibrary.__UnionRect(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TRect;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TRectWrapper) then 
  Param0Rec := TRectWrapper.Create(Param0);
Param0 := TRectWrapper(Param0Rec).ObjToRec;
AResult := Types.UnionRect(Param0,TRectWrapper(integer(GetInputArg(1))).ObjToRec,TRectWrapper(integer(GetInputArg(2))).ObjToRec);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TRectWrapper.Create(Param0)));
  end;
end;

procedure TatTypesLibrary.__IsRectEmpty(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Types.IsRectEmpty(TRectWrapper(integer(GetInputArg(0))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTypesLibrary.__OffsetRect(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TRect;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TRectWrapper) then 
  Param0Rec := TRectWrapper.Create(Param0);
Param0 := TRectWrapper(Param0Rec).ObjToRec;
AResult := Types.OffsetRect(Param0,VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TRectWrapper.Create(Param0)));
  end;
end;

procedure TatTypesLibrary.__CenterPoint(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TPointWrapper.Create(Types.CenterPoint(TRectWrapper(integer(GetInputArg(0))).ObjToRec)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTypesLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('EqualRect',2,tkVariant,nil,__EqualRect,false,0);
    DefineMethod('Rect',4,tkVariant,nil,__Rect,false,0);
    DefineMethod('Bounds',4,tkVariant,nil,__Bounds,false,0);
    DefineMethod('Point',2,tkVariant,nil,__Point,false,0);
    DefineMethod('PtInRect',2,tkVariant,nil,__PtInRect,false,0);
    DefineMethod('IntersectRect',3,tkVariant,nil,__IntersectRect,false,0).SetVarArgs([0]);
    DefineMethod('UnionRect',3,tkVariant,nil,__UnionRect,false,0).SetVarArgs([0]);
    DefineMethod('IsRectEmpty',1,tkVariant,nil,__IsRectEmpty,false,0);
    DefineMethod('OffsetRect',3,tkVariant,nil,__OffsetRect,false,0).SetVarArgs([0]);
    DefineMethod('CenterPoint',1,tkVariant,nil,__CenterPoint,false,0);
    AddConstant('LessThanValue',LessThanValue);
    AddConstant('EqualsValue',EqualsValue);
    AddConstant('GreaterThanValue',GreaterThanValue);
  end;
end;

class function TatTypesLibrary.LibraryName: string;
begin
  result := 'Types';
end;

initialization
  RegisterScripterLibrary(TatTypesLibrary, True);

{$WARNINGS ON}

end.

