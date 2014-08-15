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
unit ap_ValEdit;

interface

uses
  Windows,
  SysUtils,
  Classes,
  Messages,
  Controls,
  Grids,
  StdCtrls,
  ValEdit,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatValEditLibrary = class(TatScripterLibrary)
    procedure __TValueListEditorCreate(AMachine: TatVirtualMachine);
    procedure __TValueListEditorDestroy(AMachine: TatVirtualMachine);
    procedure __TValueListEditorDeleteRow(AMachine: TatVirtualMachine);
    procedure __TValueListEditorFindRow(AMachine: TatVirtualMachine);
    procedure __TValueListEditorInsertRow(AMachine: TatVirtualMachine);
    procedure __TValueListEditorRefresh(AMachine: TatVirtualMachine);
    procedure __TValueListEditorRestoreCurrentRow(AMachine: TatVirtualMachine);
    procedure __GetTValueListEditorCells(AMachine: TatVirtualMachine);
    procedure __SetTValueListEditorCells(AMachine: TatVirtualMachine);
    procedure __GetTValueListEditorColCount(AMachine: TatVirtualMachine);
    procedure __GetTValueListEditorItemProps(AMachine: TatVirtualMachine);
    procedure __SetTValueListEditorItemProps(AMachine: TatVirtualMachine);
    procedure __GetTValueListEditorKeys(AMachine: TatVirtualMachine);
    procedure __SetTValueListEditorKeys(AMachine: TatVirtualMachine);
    procedure __GetTValueListEditorRowCount(AMachine: TatVirtualMachine);
    procedure __GetTValueListEditorValues(AMachine: TatVirtualMachine);
    procedure __SetTValueListEditorValues(AMachine: TatVirtualMachine);
    procedure __TValueListStringsCreate(AMachine: TatVirtualMachine);
    procedure __TValueListStringsDestroy(AMachine: TatVirtualMachine);
    procedure __TValueListStringsAssign(AMachine: TatVirtualMachine);
    procedure __TValueListStringsKeyIsValid(AMachine: TatVirtualMachine);
    procedure __TValueListStringsClear(AMachine: TatVirtualMachine);
    procedure __TValueListStringsDelete(AMachine: TatVirtualMachine);
    procedure __TValueListStringsExchange(AMachine: TatVirtualMachine);
    procedure __GetTValueListStringsItemProps(AMachine: TatVirtualMachine);
    procedure __SetTValueListStringsItemProps(AMachine: TatVirtualMachine);
    procedure __TItemPropCreate(AMachine: TatVirtualMachine);
    procedure __TItemPropDestroy(AMachine: TatVirtualMachine);
    procedure __TItemPropHasPickList(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TValueListEditorClass = class of TValueListEditor;
  TValueListStringsClass = class of TValueListStrings;
  TItemPropClass = class of TItemProp;

  TatValEditDispatcher = class(TatEventDispatcher)
  private
    procedure __TGetPickListEvent( Sender: TObject; const KeyName: string;  Values: TStrings);
    procedure __TOnValidateEvent( Sender: TObject;  ACol: Longint;  ARow: Longint; const KeyName: string; const KeyValue: string);
  end;


implementation



procedure TatValEditLibrary.__TValueListEditorCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TValueListEditorClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatValEditLibrary.__TValueListEditorDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TValueListEditor(CurrentObject).Destroy;
  end;
end;

procedure TatValEditLibrary.__TValueListEditorDeleteRow(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TValueListEditor(CurrentObject).DeleteRow(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatValEditLibrary.__TValueListEditorFindRow(AMachine: TatVirtualMachine);
  var
  Param1: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := TValueListEditor(CurrentObject).FindRow(GetInputArg(0),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatValEditLibrary.__TValueListEditorInsertRow(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TValueListEditor(CurrentObject).InsertRow(GetInputArg(0),GetInputArg(1),GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatValEditLibrary.__TValueListEditorRefresh(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TValueListEditor(CurrentObject).Refresh;
  end;
end;

procedure TatValEditLibrary.__TValueListEditorRestoreCurrentRow(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TValueListEditor(CurrentObject).RestoreCurrentRow;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatValEditLibrary.__GetTValueListEditorCells(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TValueListEditor(CurrentObject).Cells[VarToInteger(GetArrayIndex(0)),VarToInteger(GetArrayIndex(1))]);
  end;
end;

procedure TatValEditLibrary.__SetTValueListEditorCells(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TValueListEditor(CurrentObject).Cells[VarToInteger(GetArrayIndex(0)),VarToInteger(GetArrayIndex(1))]:=GetInputArg(0);
  end;
end;

procedure TatValEditLibrary.__GetTValueListEditorColCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TValueListEditor(CurrentObject).ColCount);
  end;
end;

procedure TatValEditLibrary.__GetTValueListEditorItemProps(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TValueListEditor(CurrentObject).ItemProps[GetArrayIndex(0)]));
  end;
end;

procedure TatValEditLibrary.__SetTValueListEditorItemProps(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TValueListEditor(CurrentObject).ItemProps[GetArrayIndex(0)]:=TItemProp(Integer(GetInputArg(0)));
  end;
end;

procedure TatValEditLibrary.__GetTValueListEditorKeys(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TValueListEditor(CurrentObject).Keys[VarToInteger(GetArrayIndex(0))]);
  end;
end;

procedure TatValEditLibrary.__SetTValueListEditorKeys(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TValueListEditor(CurrentObject).Keys[VarToInteger(GetArrayIndex(0))]:=GetInputArg(0);
  end;
end;

procedure TatValEditLibrary.__GetTValueListEditorRowCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TValueListEditor(CurrentObject).RowCount));
  end;
end;

procedure TatValEditLibrary.__GetTValueListEditorValues(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TValueListEditor(CurrentObject).Values[GetArrayIndex(0)]);
  end;
end;

procedure TatValEditLibrary.__SetTValueListEditorValues(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TValueListEditor(CurrentObject).Values[GetArrayIndex(0)]:=GetInputArg(0);
  end;
end;

procedure TatValEditLibrary.__TValueListStringsCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TValueListStringsClass(CurrentClass.ClassRef).Create(TValueListEditor(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatValEditLibrary.__TValueListStringsDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TValueListStrings(CurrentObject).Destroy;
  end;
end;

procedure TatValEditLibrary.__TValueListStringsAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TValueListStrings(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatValEditLibrary.__TValueListStringsKeyIsValid(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := TValueListStrings(CurrentObject).KeyIsValid(GetInputArg(0));
2: AResult := TValueListStrings(CurrentObject).KeyIsValid(GetInputArg(0),GetInputArg(1));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatValEditLibrary.__TValueListStringsClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TValueListStrings(CurrentObject).Clear;
  end;
end;

procedure TatValEditLibrary.__TValueListStringsDelete(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TValueListStrings(CurrentObject).Delete(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatValEditLibrary.__TValueListStringsExchange(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TValueListStrings(CurrentObject).Exchange(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatValEditLibrary.__GetTValueListStringsItemProps(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TValueListStrings(CurrentObject).ItemProps[GetArrayIndex(0)]));
  end;
end;

procedure TatValEditLibrary.__SetTValueListStringsItemProps(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TValueListStrings(CurrentObject).ItemProps[GetArrayIndex(0)]:=TItemProp(Integer(GetInputArg(0)));
  end;
end;

procedure TatValEditLibrary.__TItemPropCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TItemPropClass(CurrentClass.ClassRef).Create(TValueListEditor(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatValEditLibrary.__TItemPropDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TItemProp(CurrentObject).Destroy;
  end;
end;

procedure TatValEditLibrary.__TItemPropHasPickList(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TItemProp(CurrentObject).HasPickList;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatValEditDispatcher.__TGetPickListEvent( Sender: TObject; const KeyName: string;  Values: TStrings);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TGetPickListEvent(BeforeCall)(Sender,KeyName,Values);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,KeyName,Values]);
    if AssignedMethod(AfterCall) then
      TGetPickListEvent(AfterCall)(Sender,KeyName,Values);
  end;
end;

procedure TatValEditDispatcher.__TOnValidateEvent( Sender: TObject;  ACol: Longint;  ARow: Longint; const KeyName: string; const KeyValue: string);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TOnValidateEvent(BeforeCall)(Sender,ACol,ARow,KeyName,KeyValue);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,ACol,ARow,KeyName,KeyValue]);
    if AssignedMethod(AfterCall) then
      TOnValidateEvent(AfterCall)(Sender,ACol,ARow,KeyName,KeyValue);
  end;
end;

procedure TatValEditLibrary.Init;
begin
  With Scripter.DefineClass(TValueListEditor) do
  begin
    DefineMethod('Create',1,tkClass,TValueListEditor,__TValueListEditorCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TValueListEditorDestroy,false,0);
    DefineMethod('DeleteRow',1,tkNone,nil,__TValueListEditorDeleteRow,false,0);
    DefineMethod('FindRow',2,tkVariant,nil,__TValueListEditorFindRow,false,0).SetVarArgs([1]);
    DefineMethod('InsertRow',3,tkInteger,nil,__TValueListEditorInsertRow,false,0);
    DefineMethod('Refresh',0,tkNone,nil,__TValueListEditorRefresh,false,0);
    DefineMethod('RestoreCurrentRow',0,tkVariant,nil,__TValueListEditorRestoreCurrentRow,false,0);
    DefineProp('Cells',tkVariant,__GetTValueListEditorCells,__SetTValueListEditorCells,nil,false,2);
    DefineProp('ColCount',tkVariant,__GetTValueListEditorColCount,nil,nil,false,0);
    DefineProp('ItemProps',tkClass,__GetTValueListEditorItemProps,__SetTValueListEditorItemProps,TItemProp,false,1);
    DefineProp('Keys',tkVariant,__GetTValueListEditorKeys,__SetTValueListEditorKeys,nil,false,1);
    DefineProp('RowCount',tkInteger,__GetTValueListEditorRowCount,nil,nil,false,0);
    DefineProp('Values',tkVariant,__GetTValueListEditorValues,__SetTValueListEditorValues,nil,false,1);
    DefineProp('VisibleColCount',tkVariant,nil,nil,nil,false,0);
    DefineProp('VisibleRowCount',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TValueListStrings) do
  begin
    DefineMethod('Create',1,tkClass,TValueListStrings,__TValueListStringsCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TValueListStringsDestroy,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TValueListStringsAssign,false,0);
    DefineMethod('KeyIsValid',2,tkVariant,nil,__TValueListStringsKeyIsValid,false,1);
    DefineMethod('Clear',0,tkNone,nil,__TValueListStringsClear,false,0);
    DefineMethod('Delete',1,tkNone,nil,__TValueListStringsDelete,false,0);
    DefineMethod('Exchange',2,tkNone,nil,__TValueListStringsExchange,false,0);
    DefineProp('ItemProps',tkClass,__GetTValueListStringsItemProps,__SetTValueListStringsItemProps,TItemProp,false,1);
  end;
  With Scripter.DefineClass(TItemProp) do
  begin
    DefineMethod('Create',1,tkClass,TItemProp,__TItemPropCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TItemPropDestroy,false,0);
    DefineMethod('HasPickList',0,tkVariant,nil,__TItemPropHasPickList,false,0);
  end;
  DefineEventAdapter(TypeInfo(TGetPickListEvent), TatValEditDispatcher, @TatValEditDispatcher.__TGetPickListEvent);
  DefineEventAdapter(TypeInfo(TOnValidateEvent), TatValEditDispatcher, @TatValEditDispatcher.__TOnValidateEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('doColumnTitles',doColumnTitles);
    AddConstant('doAutoColResize',doAutoColResize);
    AddConstant('doKeyColFixed',doKeyColFixed);
    AddConstant('keyEdit',keyEdit);
    AddConstant('keyAdd',keyAdd);
    AddConstant('keyDelete',keyDelete);
    AddConstant('keyUnique',keyUnique);
  end;
end;

class function TatValEditLibrary.LibraryName: string;
begin
  result := 'ValEdit';
end;

initialization
  RegisterScripterLibrary(TatValEditLibrary, True);

{$WARNINGS ON}

end.

