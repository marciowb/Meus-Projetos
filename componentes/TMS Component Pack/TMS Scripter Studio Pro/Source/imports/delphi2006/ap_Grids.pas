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
unit ap_Grids;

interface

uses
  Messages,
  Windows,
  SysUtils,
  Classes,
  Variants,
  Graphics,
  Menus,
  Controls,
  Forms,
  StdCtrls,
  Mask,
  Grids,
  ap_Types,
  atScript;

{$WARNINGS OFF}

type
  TatGridsLibrary = class(TatScripterLibrary)
    procedure __TInplaceEditCreate(AMachine: TatVirtualMachine);
    procedure __TInplaceEditDeselect(AMachine: TatVirtualMachine);
    procedure __TInplaceEditHide(AMachine: TatVirtualMachine);
    procedure __TInplaceEditInvalidate(AMachine: TatVirtualMachine);
    procedure __TInplaceEditMove(AMachine: TatVirtualMachine);
    procedure __TInplaceEditPosEqual(AMachine: TatVirtualMachine);
    procedure __TInplaceEditSetFocus(AMachine: TatVirtualMachine);
    procedure __TInplaceEditUpdateLoc(AMachine: TatVirtualMachine);
    procedure __TInplaceEditVisible(AMachine: TatVirtualMachine);
    procedure __TCustomGridCreate(AMachine: TatVirtualMachine);
    procedure __TCustomGridDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomGridMouseCoord(AMachine: TatVirtualMachine);
    procedure __TCustomDrawGridCellRect(AMachine: TatVirtualMachine);
    procedure __TCustomDrawGridMouseToCell(AMachine: TatVirtualMachine);
    procedure __TStringGridStringsCreate(AMachine: TatVirtualMachine);
    procedure __TStringGridStringsAdd(AMachine: TatVirtualMachine);
    procedure __TStringGridStringsAssign(AMachine: TatVirtualMachine);
    procedure __TStringGridStringsClear(AMachine: TatVirtualMachine);
    procedure __TStringGridStringsDelete(AMachine: TatVirtualMachine);
    procedure __TStringGridStringsInsert(AMachine: TatVirtualMachine);
    procedure __TStringGridCreate(AMachine: TatVirtualMachine);
    procedure __TStringGridDestroy(AMachine: TatVirtualMachine);
    procedure __GetTStringGridCells(AMachine: TatVirtualMachine);
    procedure __SetTStringGridCells(AMachine: TatVirtualMachine);
    procedure __GetTStringGridCols(AMachine: TatVirtualMachine);
    procedure __SetTStringGridCols(AMachine: TatVirtualMachine);
    procedure __GetTStringGridObjects(AMachine: TatVirtualMachine);
    procedure __SetTStringGridObjects(AMachine: TatVirtualMachine);
    procedure __GetTStringGridRows(AMachine: TatVirtualMachine);
    procedure __SetTStringGridRows(AMachine: TatVirtualMachine);
    procedure __TInplaceEditListCreate(AMachine: TatVirtualMachine);
    procedure __TInplaceEditListRestoreContents(AMachine: TatVirtualMachine);
    procedure __GetTInplaceEditListActiveList(AMachine: TatVirtualMachine);
    procedure __SetTInplaceEditListActiveList(AMachine: TatVirtualMachine);
    procedure __GetTInplaceEditListButtonWidth(AMachine: TatVirtualMachine);
    procedure __SetTInplaceEditListButtonWidth(AMachine: TatVirtualMachine);
    procedure __GetTInplaceEditListDropDownRows(AMachine: TatVirtualMachine);
    procedure __SetTInplaceEditListDropDownRows(AMachine: TatVirtualMachine);
    procedure __GetTInplaceEditListEditStyle(AMachine: TatVirtualMachine);
    procedure __GetTInplaceEditListListVisible(AMachine: TatVirtualMachine);
    procedure __SetTInplaceEditListListVisible(AMachine: TatVirtualMachine);
    procedure __GetTInplaceEditListPickList(AMachine: TatVirtualMachine);
    procedure __GetTInplaceEditListPickListLoaded(AMachine: TatVirtualMachine);
    procedure __SetTInplaceEditListPickListLoaded(AMachine: TatVirtualMachine);
    procedure __GetTInplaceEditListPressed(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  EInvalidGridOperationClass = class of EInvalidGridOperation;
  TInplaceEditClass = class of TInplaceEdit;
  TCustomGridClass = class of TCustomGrid;
  TCustomDrawGridClass = class of TCustomDrawGrid;
  TDrawGridClass = class of TDrawGrid;
  TStringGridStringsClass = class of TStringGridStrings;
  TStringGridClass = class of TStringGrid;
  TInplaceEditListClass = class of TInplaceEditList;

  TatGridsDispatcher = class(TatEventDispatcher)
  private
    function __TGetExtentsFunc( Index: Longint): Integer;
    procedure __TSelectCellEvent( Sender: TObject;  ACol: Longint;  ARow: Longint; var CanSelect: Boolean);
    procedure __TGetEditEvent( Sender: TObject;  ACol: Longint;  ARow: Longint; var Value: string);
    procedure __TSetEditEvent( Sender: TObject;  ACol: Longint;  ARow: Longint; const Value: string);
    procedure __TMovedEvent( Sender: TObject;  FromIndex: Longint;  ToIndex: Longint);
    procedure __TOnGetPickListItems( ACol: Integer;  ARow: Integer;  Items: TStrings);
  end;

  TGridAxisDrawInfoWrapper = class(TatRecordWrapper)
  private
    FEffectiveLineWidth: Integer;
    FFixedBoundary: Integer;
    FGridBoundary: Integer;
    FGridExtent: Integer;
    FLastFullVisibleCell: Longint;
    FFullVisBoundary: Integer;
    FFixedCellCount: Integer;
    FFirstGridCell: Integer;
    FGridCellCount: Integer;
  public
    constructor Create(ARecord: TGridAxisDrawInfo);
    function ObjToRec: TGridAxisDrawInfo;
  published
    property EffectiveLineWidth: Integer read FEffectiveLineWidth write FEffectiveLineWidth;
    property FixedBoundary: Integer read FFixedBoundary write FFixedBoundary;
    property GridBoundary: Integer read FGridBoundary write FGridBoundary;
    property GridExtent: Integer read FGridExtent write FGridExtent;
    property LastFullVisibleCell: Longint read FLastFullVisibleCell write FLastFullVisibleCell;
    property FullVisBoundary: Integer read FFullVisBoundary write FFullVisBoundary;
    property FixedCellCount: Integer read FFixedCellCount write FFixedCellCount;
    property FirstGridCell: Integer read FFirstGridCell write FFirstGridCell;
    property GridCellCount: Integer read FGridCellCount write FGridCellCount;
  end;
  
  TGridDrawInfoWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: TGridDrawInfo);
    function ObjToRec: TGridDrawInfo;
  published
  end;
  
  TGridCoordWrapper = class(TatRecordWrapper)
  private
    FX: Longint;
    FY: Longint;
  public
    constructor Create(ARecord: TGridCoord);
    function ObjToRec: TGridCoord;
  published
    property X: Longint read FX write FX;
    property Y: Longint read FY write FY;
  end;
  
  TGridRectWrapper = class(TatRecordWrapper)
  private
    FLeft: Longint;
    FTop: Longint;
    FRight: Longint;
    FBottom: Longint;
  public
    constructor Create(ARecord: TGridRect);
    function ObjToRec: TGridRect;
  published
    property Left: Longint read FLeft write FLeft;
    property Top: Longint read FTop write FTop;
    property Right: Longint read FRight write FRight;
    property Bottom: Longint read FBottom write FBottom;
  end;
  

implementation

constructor TGridAxisDrawInfoWrapper.Create(ARecord: TGridAxisDrawInfo);
begin
  inherited Create;
  FEffectiveLineWidth := ARecord.EffectiveLineWidth;
  FFixedBoundary := ARecord.FixedBoundary;
  FGridBoundary := ARecord.GridBoundary;
  FGridExtent := ARecord.GridExtent;
  FLastFullVisibleCell := ARecord.LastFullVisibleCell;
  FFullVisBoundary := ARecord.FullVisBoundary;
  FFixedCellCount := ARecord.FixedCellCount;
  FFirstGridCell := ARecord.FirstGridCell;
  FGridCellCount := ARecord.GridCellCount;
end;

function TGridAxisDrawInfoWrapper.ObjToRec: TGridAxisDrawInfo;
begin
  result.EffectiveLineWidth := FEffectiveLineWidth;
  result.FixedBoundary := FFixedBoundary;
  result.GridBoundary := FGridBoundary;
  result.GridExtent := FGridExtent;
  result.LastFullVisibleCell := FLastFullVisibleCell;
  result.FullVisBoundary := FFullVisBoundary;
  result.FixedCellCount := FFixedCellCount;
  result.FirstGridCell := FFirstGridCell;
  result.GridCellCount := FGridCellCount;
end;

constructor TGridDrawInfoWrapper.Create(ARecord: TGridDrawInfo);
begin
  inherited Create;
end;

function TGridDrawInfoWrapper.ObjToRec: TGridDrawInfo;
begin
end;

constructor TGridCoordWrapper.Create(ARecord: TGridCoord);
begin
  inherited Create;
  FX := ARecord.X;
  FY := ARecord.Y;
end;

function TGridCoordWrapper.ObjToRec: TGridCoord;
begin
  result.X := FX;
  result.Y := FY;
end;

constructor TGridRectWrapper.Create(ARecord: TGridRect);
begin
  inherited Create;
  FLeft := ARecord.Left;
  FTop := ARecord.Top;
  FRight := ARecord.Right;
  FBottom := ARecord.Bottom;
end;

function TGridRectWrapper.ObjToRec: TGridRect;
begin
  result.Left := FLeft;
  result.Top := FTop;
  result.Right := FRight;
  result.Bottom := FBottom;
end;



procedure TatGridsLibrary.__TInplaceEditCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TInplaceEditClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGridsLibrary.__TInplaceEditDeselect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TInplaceEdit(CurrentObject).Deselect;
  end;
end;

procedure TatGridsLibrary.__TInplaceEditHide(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TInplaceEdit(CurrentObject).Hide;
  end;
end;

procedure TatGridsLibrary.__TInplaceEditInvalidate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TInplaceEdit(CurrentObject).Invalidate;
  end;
end;

procedure TatGridsLibrary.__TInplaceEditMove(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TInplaceEdit(CurrentObject).Move(TRectWrapper(integer(GetInputArg(0))).ObjToRec);
  end;
end;

procedure TatGridsLibrary.__TInplaceEditPosEqual(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TInplaceEdit(CurrentObject).PosEqual(TRectWrapper(integer(GetInputArg(0))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGridsLibrary.__TInplaceEditSetFocus(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TInplaceEdit(CurrentObject).SetFocus;
  end;
end;

procedure TatGridsLibrary.__TInplaceEditUpdateLoc(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TInplaceEdit(CurrentObject).UpdateLoc(TRectWrapper(integer(GetInputArg(0))).ObjToRec);
  end;
end;

procedure TatGridsLibrary.__TInplaceEditVisible(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TInplaceEdit(CurrentObject).Visible;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGridsLibrary.__TCustomGridCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomGridClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGridsLibrary.__TCustomGridDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomGrid(CurrentObject).Destroy;
  end;
end;

procedure TatGridsLibrary.__TCustomGridMouseCoord(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TGridCoordWrapper.Create(TCustomGrid(CurrentObject).MouseCoord(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGridsLibrary.__TCustomDrawGridCellRect(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TRectWrapper.Create(TCustomDrawGrid(CurrentObject).CellRect(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGridsLibrary.__TCustomDrawGridMouseToCell(AMachine: TatVirtualMachine);
  var
  Param2: Longint;
  Param3: Longint;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
Param3 := VarToInteger(GetInputArg(3));
    TCustomDrawGrid(CurrentObject).MouseToCell(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2,Param3);
    SetInputArg(2,Integer(Param2));
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatGridsLibrary.__TStringGridStringsCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TStringGridStringsClass(CurrentClass.ClassRef).Create(TStringGrid(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGridsLibrary.__TStringGridStringsAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TStringGridStrings(CurrentObject).Add(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGridsLibrary.__TStringGridStringsAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TStringGridStrings(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatGridsLibrary.__TStringGridStringsClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TStringGridStrings(CurrentObject).Clear;
  end;
end;

procedure TatGridsLibrary.__TStringGridStringsDelete(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TStringGridStrings(CurrentObject).Delete(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatGridsLibrary.__TStringGridStringsInsert(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TStringGridStrings(CurrentObject).Insert(VarToInteger(GetInputArg(0)),GetInputArg(1));
  end;
end;

procedure TatGridsLibrary.__TStringGridCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TStringGridClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGridsLibrary.__TStringGridDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TStringGrid(CurrentObject).Destroy;
  end;
end;

procedure TatGridsLibrary.__GetTStringGridCells(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TStringGrid(CurrentObject).Cells[VarToInteger(GetArrayIndex(0)),VarToInteger(GetArrayIndex(1))]);
  end;
end;

procedure TatGridsLibrary.__SetTStringGridCells(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TStringGrid(CurrentObject).Cells[VarToInteger(GetArrayIndex(0)),VarToInteger(GetArrayIndex(1))]:=GetInputArg(0);
  end;
end;

procedure TatGridsLibrary.__GetTStringGridCols(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TStringGrid(CurrentObject).Cols[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatGridsLibrary.__SetTStringGridCols(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TStringGrid(CurrentObject).Cols[VarToInteger(GetArrayIndex(0))]:=TStrings(Integer(GetInputArg(0)));
  end;
end;

procedure TatGridsLibrary.__GetTStringGridObjects(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TStringGrid(CurrentObject).Objects[VarToInteger(GetArrayIndex(0)),VarToInteger(GetArrayIndex(1))]));
  end;
end;

procedure TatGridsLibrary.__SetTStringGridObjects(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TStringGrid(CurrentObject).Objects[VarToInteger(GetArrayIndex(0)),VarToInteger(GetArrayIndex(1))]:=TObject(Integer(GetInputArg(0)));
  end;
end;

procedure TatGridsLibrary.__GetTStringGridRows(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TStringGrid(CurrentObject).Rows[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatGridsLibrary.__SetTStringGridRows(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TStringGrid(CurrentObject).Rows[VarToInteger(GetArrayIndex(0))]:=TStrings(Integer(GetInputArg(0)));
  end;
end;

procedure TatGridsLibrary.__TInplaceEditListCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TInplaceEditListClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatGridsLibrary.__TInplaceEditListRestoreContents(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TInplaceEditList(CurrentObject).RestoreContents;
  end;
end;

procedure TatGridsLibrary.__GetTInplaceEditListActiveList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TInplaceEditList(CurrentObject).ActiveList));
  end;
end;

procedure TatGridsLibrary.__SetTInplaceEditListActiveList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TInplaceEditList(CurrentObject).ActiveList:=TWinControl(Integer(GetInputArg(0)));
  end;
end;

procedure TatGridsLibrary.__GetTInplaceEditListButtonWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TInplaceEditList(CurrentObject).ButtonWidth));
  end;
end;

procedure TatGridsLibrary.__SetTInplaceEditListButtonWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TInplaceEditList(CurrentObject).ButtonWidth:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGridsLibrary.__GetTInplaceEditListDropDownRows(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TInplaceEditList(CurrentObject).DropDownRows));
  end;
end;

procedure TatGridsLibrary.__SetTInplaceEditListDropDownRows(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TInplaceEditList(CurrentObject).DropDownRows:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatGridsLibrary.__GetTInplaceEditListEditStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TInplaceEditList(CurrentObject).EditStyle);
  end;
end;

procedure TatGridsLibrary.__GetTInplaceEditListListVisible(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TInplaceEditList(CurrentObject).ListVisible);
  end;
end;

procedure TatGridsLibrary.__SetTInplaceEditListListVisible(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TInplaceEditList(CurrentObject).ListVisible:=GetInputArg(0);
  end;
end;

procedure TatGridsLibrary.__GetTInplaceEditListPickList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TInplaceEditList(CurrentObject).PickList));
  end;
end;

procedure TatGridsLibrary.__GetTInplaceEditListPickListLoaded(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TInplaceEditList(CurrentObject).PickListLoaded);
  end;
end;

procedure TatGridsLibrary.__SetTInplaceEditListPickListLoaded(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TInplaceEditList(CurrentObject).PickListLoaded:=GetInputArg(0);
  end;
end;

procedure TatGridsLibrary.__GetTInplaceEditListPressed(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TInplaceEditList(CurrentObject).Pressed);
  end;
end;

function TatGridsDispatcher.__TGetExtentsFunc( Index: Longint): Integer;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TGetExtentsFunc(BeforeCall)(Index);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Index]);
    if AssignedMethod(AfterCall) then
      TGetExtentsFunc(AfterCall)(Index);
  end;
end;

procedure TatGridsDispatcher.__TSelectCellEvent( Sender: TObject;  ACol: Longint;  ARow: Longint; var CanSelect: Boolean);
var
  CanSelectTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TSelectCellEvent(BeforeCall)(Sender,ACol,ARow,CanSelect);
    CanSelectTemp := CanSelect;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,ACol,ARow,CanSelectTemp]);
    CanSelect := CanSelectTemp;
    if AssignedMethod(AfterCall) then
      TSelectCellEvent(AfterCall)(Sender,ACol,ARow,CanSelect);
  end;
end;

procedure TatGridsDispatcher.__TGetEditEvent( Sender: TObject;  ACol: Longint;  ARow: Longint; var Value: string);
var
  ValueTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TGetEditEvent(BeforeCall)(Sender,ACol,ARow,Value);
    ValueTemp := Value;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,ACol,ARow,ValueTemp]);
    Value := ValueTemp;
    if AssignedMethod(AfterCall) then
      TGetEditEvent(AfterCall)(Sender,ACol,ARow,Value);
  end;
end;

procedure TatGridsDispatcher.__TSetEditEvent( Sender: TObject;  ACol: Longint;  ARow: Longint; const Value: string);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TSetEditEvent(BeforeCall)(Sender,ACol,ARow,Value);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,ACol,ARow,Value]);
    if AssignedMethod(AfterCall) then
      TSetEditEvent(AfterCall)(Sender,ACol,ARow,Value);
  end;
end;

procedure TatGridsDispatcher.__TMovedEvent( Sender: TObject;  FromIndex: Longint;  ToIndex: Longint);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TMovedEvent(BeforeCall)(Sender,FromIndex,ToIndex);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,FromIndex,ToIndex]);
    if AssignedMethod(AfterCall) then
      TMovedEvent(AfterCall)(Sender,FromIndex,ToIndex);
  end;
end;

procedure TatGridsDispatcher.__TOnGetPickListItems( ACol: Integer;  ARow: Integer;  Items: TStrings);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TOnGetPickListItems(BeforeCall)(ACol,ARow,Items);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [ACol,ARow,Items]);
    if AssignedMethod(AfterCall) then
      TOnGetPickListItems(AfterCall)(ACol,ARow,Items);
  end;
end;

procedure TatGridsLibrary.Init;
begin
  With Scripter.DefineClass(EInvalidGridOperation) do
  begin
  end;
  With Scripter.DefineClass(TInplaceEdit) do
  begin
    DefineMethod('Create',1,tkClass,TInplaceEdit,__TInplaceEditCreate,true,0);
    DefineMethod('Deselect',0,tkNone,nil,__TInplaceEditDeselect,false,0);
    DefineMethod('Hide',0,tkNone,nil,__TInplaceEditHide,false,0);
    DefineMethod('Invalidate',0,tkNone,nil,__TInplaceEditInvalidate,false,0);
    DefineMethod('Move',1,tkNone,nil,__TInplaceEditMove,false,0);
    DefineMethod('PosEqual',1,tkVariant,nil,__TInplaceEditPosEqual,false,0);
    DefineMethod('SetFocus',0,tkNone,nil,__TInplaceEditSetFocus,false,0);
    DefineMethod('UpdateLoc',1,tkNone,nil,__TInplaceEditUpdateLoc,false,0);
    DefineMethod('Visible',0,tkVariant,nil,__TInplaceEditVisible,false,0);
  end;
  With Scripter.DefineClass(TCustomGrid) do
  begin
    DefineMethod('Create',1,tkClass,TCustomGrid,__TCustomGridCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomGridDestroy,false,0);
    DefineMethod('MouseCoord',2,tkVariant,nil,__TCustomGridMouseCoord,false,0);
  end;
  With Scripter.DefineClass(TCustomDrawGrid) do
  begin
    DefineMethod('CellRect',2,tkVariant,nil,__TCustomDrawGridCellRect,false,0);
    DefineMethod('MouseToCell',4,tkNone,nil,__TCustomDrawGridMouseToCell,false,0).SetVarArgs([2,3]);
    DefineProp('Canvas',tkVariant,nil,nil,nil,false,0);
    DefineProp('Col',tkVariant,nil,nil,nil,false,0);
    DefineProp('ColWidths',tkVariant,nil,nil,nil,false,0);
    DefineProp('EditorMode',tkVariant,nil,nil,nil,false,0);
    DefineProp('GridHeight',tkVariant,nil,nil,nil,false,0);
    DefineProp('GridWidth',tkVariant,nil,nil,nil,false,0);
    DefineProp('LeftCol',tkVariant,nil,nil,nil,false,0);
    DefineProp('Selection',tkVariant,nil,nil,nil,false,0);
    DefineProp('Row',tkVariant,nil,nil,nil,false,0);
    DefineProp('RowHeights',tkVariant,nil,nil,nil,false,0);
    DefineProp('TabStops',tkVariant,nil,nil,nil,false,0);
    DefineProp('TopRow',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TDrawGrid) do
  begin
  end;
  With Scripter.DefineClass(TStringGridStrings) do
  begin
    DefineMethod('Create',2,tkClass,TStringGridStrings,__TStringGridStringsCreate,true,0);
    DefineMethod('Add',1,tkInteger,nil,__TStringGridStringsAdd,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TStringGridStringsAssign,false,0);
    DefineMethod('Clear',0,tkNone,nil,__TStringGridStringsClear,false,0);
    DefineMethod('Delete',1,tkNone,nil,__TStringGridStringsDelete,false,0);
    DefineMethod('Insert',2,tkNone,nil,__TStringGridStringsInsert,false,0);
  end;
  With Scripter.DefineClass(TStringGrid) do
  begin
    DefineMethod('Create',1,tkClass,TStringGrid,__TStringGridCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TStringGridDestroy,false,0);
    DefineProp('Cells',tkVariant,__GetTStringGridCells,__SetTStringGridCells,nil,false,2);
    DefineProp('Cols',tkClass,__GetTStringGridCols,__SetTStringGridCols,TStrings,false,1);
    DefineProp('Objects',tkClass,__GetTStringGridObjects,__SetTStringGridObjects,TObject,false,2);
    DefineProp('Rows',tkClass,__GetTStringGridRows,__SetTStringGridRows,TStrings,false,1);
  end;
  With Scripter.DefineClass(TInplaceEditList) do
  begin
    DefineMethod('Create',1,tkClass,TInplaceEditList,__TInplaceEditListCreate,true,0);
    DefineMethod('RestoreContents',0,tkNone,nil,__TInplaceEditListRestoreContents,false,0);
    DefineProp('ActiveList',tkClass,__GetTInplaceEditListActiveList,__SetTInplaceEditListActiveList,TWinControl,false,0);
    DefineProp('ButtonWidth',tkInteger,__GetTInplaceEditListButtonWidth,__SetTInplaceEditListButtonWidth,nil,false,0);
    DefineProp('DropDownRows',tkInteger,__GetTInplaceEditListDropDownRows,__SetTInplaceEditListDropDownRows,nil,false,0);
    DefineProp('EditStyle',tkEnumeration,__GetTInplaceEditListEditStyle,nil,nil,false,0);
    DefineProp('ListVisible',tkVariant,__GetTInplaceEditListListVisible,__SetTInplaceEditListListVisible,nil,false,0);
    DefineProp('PickList',tkClass,__GetTInplaceEditListPickList,nil,TCustomListBox,false,0);
    DefineProp('PickListLoaded',tkVariant,__GetTInplaceEditListPickListLoaded,__SetTInplaceEditListPickListLoaded,nil,false,0);
    DefineProp('Pressed',tkVariant,__GetTInplaceEditListPressed,nil,nil,false,0);
  end;
  DefineEventAdapter(TypeInfo(TGetExtentsFunc), TatGridsDispatcher, @TatGridsDispatcher.__TGetExtentsFunc);
  DefineEventAdapter(TypeInfo(TSelectCellEvent), TatGridsDispatcher, @TatGridsDispatcher.__TSelectCellEvent);
  DefineEventAdapter(TypeInfo(TGetEditEvent), TatGridsDispatcher, @TatGridsDispatcher.__TGetEditEvent);
  DefineEventAdapter(TypeInfo(TSetEditEvent), TatGridsDispatcher, @TatGridsDispatcher.__TSetEditEvent);
  DefineEventAdapter(TypeInfo(TMovedEvent), TatGridsDispatcher, @TatGridsDispatcher.__TMovedEvent);
  DefineEventAdapter(TypeInfo(TOnGetPickListItems), TatGridsDispatcher, @TatGridsDispatcher.__TOnGetPickListItems);
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('gsNormal',gsNormal);
    AddConstant('gsSelecting',gsSelecting);
    AddConstant('gsRowSizing',gsRowSizing);
    AddConstant('gsColSizing',gsColSizing);
    AddConstant('gsRowMoving',gsRowMoving);
    AddConstant('gsColMoving',gsColMoving);
    AddConstant('goFixedVertLine',goFixedVertLine);
    AddConstant('goFixedHorzLine',goFixedHorzLine);
    AddConstant('goVertLine',goVertLine);
    AddConstant('goHorzLine',goHorzLine);
    AddConstant('goRangeSelect',goRangeSelect);
    AddConstant('goDrawFocusSelected',goDrawFocusSelected);
    AddConstant('goRowSizing',goRowSizing);
    AddConstant('goColSizing',goColSizing);
    AddConstant('goRowMoving',goRowMoving);
    AddConstant('goColMoving',goColMoving);
    AddConstant('goEditing',goEditing);
    AddConstant('goTabs',goTabs);
    AddConstant('goRowSelect',goRowSelect);
    AddConstant('goAlwaysShowEditor',goAlwaysShowEditor);
    AddConstant('goThumbTracking',goThumbTracking);
    AddConstant('esSimple',esSimple);
    AddConstant('esEllipsis',esEllipsis);
    AddConstant('esPickList',esPickList);
    AddConstant('MaxCustomExtents',MaxCustomExtents);
    AddConstant('MaxShortInt',MaxShortInt);
  end;
end;

class function TatGridsLibrary.LibraryName: string;
begin
  result := 'Grids';
end;

initialization
  RegisterScripterLibrary(TatGridsLibrary, True);

{$WARNINGS ON}

end.

