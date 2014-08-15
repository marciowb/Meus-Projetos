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
unit ap_DBCGrids;

interface

uses
  SysUtils,
  Windows,
  Messages,
  Classes,
  Controls,
  Forms,
  Graphics,
  Menus,
  DB,
  DBCGrids,
  atScript;

{$WARNINGS OFF}

type
  TatDBCGridsLibrary = class(TatScripterLibrary)
    procedure __TDBCtrlGridLinkCreate(AMachine: TatVirtualMachine);
    procedure __TDBCtrlPanelCreateLinked(AMachine: TatVirtualMachine);
    procedure __TDBCtrlGridCreate(AMachine: TatVirtualMachine);
    procedure __TDBCtrlGridDestroy(AMachine: TatVirtualMachine);
    procedure __TDBCtrlGridDoKey(AMachine: TatVirtualMachine);
    procedure __TDBCtrlGridExecuteAction(AMachine: TatVirtualMachine);
    procedure __TDBCtrlGridGetTabOrderList(AMachine: TatVirtualMachine);
    procedure __TDBCtrlGridKeyDown(AMachine: TatVirtualMachine);
    procedure __TDBCtrlGridSetBounds(AMachine: TatVirtualMachine);
    procedure __TDBCtrlGridUpdateAction(AMachine: TatVirtualMachine);
    procedure __GetTDBCtrlGridCanvas(AMachine: TatVirtualMachine);
    procedure __GetTDBCtrlGridEditMode(AMachine: TatVirtualMachine);
    procedure __SetTDBCtrlGridEditMode(AMachine: TatVirtualMachine);
    procedure __GetTDBCtrlGridPanelCount(AMachine: TatVirtualMachine);
    procedure __GetTDBCtrlGridPanelIndex(AMachine: TatVirtualMachine);
    procedure __SetTDBCtrlGridPanelIndex(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TDBCtrlGridLinkClass = class of TDBCtrlGridLink;
  TDBCtrlPanelClass = class of TDBCtrlPanel;
  TDBCtrlGridClass = class of TDBCtrlGrid;

  TatDBCGridsDispatcher = class(TatEventDispatcher)
  private
    procedure __TPaintPanelEvent( DBCtrlGrid: TDBCtrlGrid;  Index: Integer);
  end;


implementation



procedure TatDBCGridsLibrary.__TDBCtrlGridLinkCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDBCtrlGridLinkClass(CurrentClass.ClassRef).Create(TDBCtrlGrid(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCGridsLibrary.__TDBCtrlPanelCreateLinked(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDBCtrlPanelClass(CurrentClass.ClassRef).CreateLinked(TDBCtrlGrid(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCGridsLibrary.__TDBCtrlGridCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDBCtrlGridClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCGridsLibrary.__TDBCtrlGridDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBCtrlGrid(CurrentObject).Destroy;
  end;
end;

procedure TatDBCGridsLibrary.__TDBCtrlGridDoKey(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBCtrlGrid(CurrentObject).DoKey(GetInputArg(0));
  end;
end;

procedure TatDBCGridsLibrary.__TDBCtrlGridExecuteAction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBCtrlGrid(CurrentObject).ExecuteAction(TBasicAction(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCGridsLibrary.__TDBCtrlGridGetTabOrderList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBCtrlGrid(CurrentObject).GetTabOrderList(TList(Integer(GetInputArg(0))));
  end;
end;

procedure TatDBCGridsLibrary.__TDBCtrlGridKeyDown(AMachine: TatVirtualMachine);
  var
  Param0: Word;
  Param1: TShiftState;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
IntToSet(Param1, VarToInteger(GetInputArg(1)), SizeOf(Param1));
    TDBCtrlGrid(CurrentObject).KeyDown(Param0,Param1);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatDBCGridsLibrary.__TDBCtrlGridSetBounds(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBCtrlGrid(CurrentObject).SetBounds(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatDBCGridsLibrary.__TDBCtrlGridUpdateAction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDBCtrlGrid(CurrentObject).UpdateAction(TBasicAction(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatDBCGridsLibrary.__GetTDBCtrlGridCanvas(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDBCtrlGrid(CurrentObject).Canvas));
  end;
end;

procedure TatDBCGridsLibrary.__GetTDBCtrlGridEditMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDBCtrlGrid(CurrentObject).EditMode);
  end;
end;

procedure TatDBCGridsLibrary.__SetTDBCtrlGridEditMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBCtrlGrid(CurrentObject).EditMode:=GetInputArg(0);
  end;
end;

procedure TatDBCGridsLibrary.__GetTDBCtrlGridPanelCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDBCtrlGrid(CurrentObject).PanelCount));
  end;
end;

procedure TatDBCGridsLibrary.__GetTDBCtrlGridPanelIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDBCtrlGrid(CurrentObject).PanelIndex));
  end;
end;

procedure TatDBCGridsLibrary.__SetTDBCtrlGridPanelIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDBCtrlGrid(CurrentObject).PanelIndex:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatDBCGridsDispatcher.__TPaintPanelEvent( DBCtrlGrid: TDBCtrlGrid;  Index: Integer);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TPaintPanelEvent(BeforeCall)(DBCtrlGrid,Index);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [DBCtrlGrid,Index]);
    if AssignedMethod(AfterCall) then
      TPaintPanelEvent(AfterCall)(DBCtrlGrid,Index);
  end;
end;

procedure TatDBCGridsLibrary.Init;
begin
  With Scripter.DefineClass(TDBCtrlGridLink) do
  begin
    DefineMethod('Create',1,tkClass,TDBCtrlGridLink,__TDBCtrlGridLinkCreate,true,0);
  end;
  With Scripter.DefineClass(TDBCtrlPanel) do
  begin
    DefineMethod('CreateLinked',1,tkClass,TDBCtrlPanel,__TDBCtrlPanelCreateLinked,true,0);
  end;
  With Scripter.DefineClass(TDBCtrlGrid) do
  begin
    DefineMethod('Create',1,tkClass,TDBCtrlGrid,__TDBCtrlGridCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TDBCtrlGridDestroy,false,0);
    DefineMethod('DoKey',1,tkNone,nil,__TDBCtrlGridDoKey,false,0);
    DefineMethod('ExecuteAction',1,tkVariant,nil,__TDBCtrlGridExecuteAction,false,0);
    DefineMethod('GetTabOrderList',1,tkNone,nil,__TDBCtrlGridGetTabOrderList,false,0);
    DefineMethod('KeyDown',2,tkNone,nil,__TDBCtrlGridKeyDown,false,0).SetVarArgs([0]);
    DefineMethod('SetBounds',4,tkNone,nil,__TDBCtrlGridSetBounds,false,0);
    DefineMethod('UpdateAction',1,tkVariant,nil,__TDBCtrlGridUpdateAction,false,0);
    DefineProp('Canvas',tkClass,__GetTDBCtrlGridCanvas,nil,TCanvas,false,0);
    DefineProp('EditMode',tkVariant,__GetTDBCtrlGridEditMode,__SetTDBCtrlGridEditMode,nil,false,0);
    DefineProp('PanelCount',tkInteger,__GetTDBCtrlGridPanelCount,nil,nil,false,0);
    DefineProp('PanelIndex',tkInteger,__GetTDBCtrlGridPanelIndex,__SetTDBCtrlGridPanelIndex,nil,false,0);
  end;
  DefineEventAdapter(TypeInfo(TPaintPanelEvent), TatDBCGridsDispatcher, @TatDBCGridsDispatcher.__TPaintPanelEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('goVertical',goVertical);
    AddConstant('goHorizontal',goHorizontal);
    AddConstant('gbNone',gbNone);
    AddConstant('gbRaised',gbRaised);
    AddConstant('gkNull',gkNull);
    AddConstant('gkEditMode',gkEditMode);
    AddConstant('gkPriorTab',gkPriorTab);
    AddConstant('gkNextTab',gkNextTab);
    AddConstant('gkLeft',gkLeft);
    AddConstant('gkRight',gkRight);
    AddConstant('gkUp',gkUp);
    AddConstant('gkDown',gkDown);
    AddConstant('gkScrollUp',gkScrollUp);
    AddConstant('gkScrollDown',gkScrollDown);
    AddConstant('gkPageUp',gkPageUp);
    AddConstant('gkPageDown',gkPageDown);
    AddConstant('gkHome',gkHome);
    AddConstant('gkEnd',gkEnd);
    AddConstant('gkInsert',gkInsert);
    AddConstant('gkAppend',gkAppend);
    AddConstant('gkDelete',gkDelete);
    AddConstant('gkCancel',gkCancel);
  end;
end;

class function TatDBCGridsLibrary.LibraryName: string;
begin
  result := 'DBCGrids';
end;

initialization
  RegisterScripterLibrary(TatDBCGridsLibrary, True);

{$WARNINGS ON}

end.

