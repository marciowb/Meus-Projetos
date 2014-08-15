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
unit ap_ButtonGroup;

interface

uses
  Windows,
  SysUtils,
  Classes,
  Controls,
  ImgList,
  Forms,
  Messages,
  Graphics,
  StdCtrls,
  CategoryButtons,
  ButtonGroup,
  Variants,
  ap_Types,
  atScript;

{$WARNINGS OFF}

type
  TatButtonGroupLibrary = class(TatScripterLibrary)
    procedure __TButtonGroupCreate(AMachine: TatVirtualMachine);
    procedure __TButtonGroupDestroy(AMachine: TatVirtualMachine);
    procedure __TButtonGroupAssign(AMachine: TatVirtualMachine);
    procedure __TButtonGroupDragDrop(AMachine: TatVirtualMachine);
    procedure __TButtonGroupGetButtonRect(AMachine: TatVirtualMachine);
    procedure __TButtonGroupGetDragImages(AMachine: TatVirtualMachine);
    procedure __TButtonGroupIndexOfButtonAt(AMachine: TatVirtualMachine);
    procedure __TButtonGroupRemoveInsertionPoints(AMachine: TatVirtualMachine);
    procedure __TButtonGroupScrollIntoView(AMachine: TatVirtualMachine);
    procedure __TButtonGroupSetInsertionPoints(AMachine: TatVirtualMachine);
    procedure __TButtonGroupTargetIndexAt(AMachine: TatVirtualMachine);
    procedure __GetTButtonGroupDragIndex(AMachine: TatVirtualMachine);
    procedure __SetTButtonGroupDragIndex(AMachine: TatVirtualMachine);
    procedure __GetTButtonGroupDragImageList(AMachine: TatVirtualMachine);
    procedure __TGrpButtonItemScrollIntoView(AMachine: TatVirtualMachine);
    procedure __GetTGrpButtonItemCollection(AMachine: TatVirtualMachine);
    procedure __SetTGrpButtonItemCollection(AMachine: TatVirtualMachine);
    procedure __TGrpButtonItemsCreate(AMachine: TatVirtualMachine);
    procedure __TGrpButtonItemsAdd(AMachine: TatVirtualMachine);
    procedure __TGrpButtonItemsAddItem(AMachine: TatVirtualMachine);
    procedure __TGrpButtonItemsBeginUpdate(AMachine: TatVirtualMachine);
    procedure __TGrpButtonItemsInsert(AMachine: TatVirtualMachine);
    procedure __GetTGrpButtonItemsItems(AMachine: TatVirtualMachine);
    procedure __SetTGrpButtonItemsItems(AMachine: TatVirtualMachine);
    procedure __GetTGrpButtonItemsButtonGroup(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TButtonGroupClass = class of TButtonGroup;
  TGrpButtonItemClass = class of TGrpButtonItem;
  TGrpButtonItemsClass = class of TGrpButtonItems;

  TatButtonGroupDispatcher = class(TatEventDispatcher)
  private
    procedure __TGrpButtonEvent( Sender: TObject;  Index: Integer);
    procedure __TGrpButtonReorderEvent( Sender: TObject;  OldIndex: Integer;  NewIndex: Integer);
  end;


implementation



procedure TatButtonGroupLibrary.__TButtonGroupCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TButtonGroupClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatButtonGroupLibrary.__TButtonGroupDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TButtonGroup(CurrentObject).Destroy;
  end;
end;

procedure TatButtonGroupLibrary.__TButtonGroupAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TButtonGroup(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatButtonGroupLibrary.__TButtonGroupDragDrop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TButtonGroup(CurrentObject).DragDrop(TObject(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatButtonGroupLibrary.__TButtonGroupGetButtonRect(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TRectWrapper.Create(TButtonGroup(CurrentObject).GetButtonRect(VarToInteger(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatButtonGroupLibrary.__TButtonGroupGetDragImages(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TButtonGroup(CurrentObject).GetDragImages);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatButtonGroupLibrary.__TButtonGroupIndexOfButtonAt(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TButtonGroup(CurrentObject).IndexOfButtonAt(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatButtonGroupLibrary.__TButtonGroupRemoveInsertionPoints(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TButtonGroup(CurrentObject).RemoveInsertionPoints;
  end;
end;

procedure TatButtonGroupLibrary.__TButtonGroupScrollIntoView(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TButtonGroup(CurrentObject).ScrollIntoView(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatButtonGroupLibrary.__TButtonGroupSetInsertionPoints(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TButtonGroup(CurrentObject).SetInsertionPoints(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatButtonGroupLibrary.__TButtonGroupTargetIndexAt(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TButtonGroup(CurrentObject).TargetIndexAt(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatButtonGroupLibrary.__GetTButtonGroupDragIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TButtonGroup(CurrentObject).DragIndex));
  end;
end;

procedure TatButtonGroupLibrary.__SetTButtonGroupDragIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TButtonGroup(CurrentObject).DragIndex:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatButtonGroupLibrary.__GetTButtonGroupDragImageList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TButtonGroup(CurrentObject).DragImageList));
  end;
end;

procedure TatButtonGroupLibrary.__TGrpButtonItemScrollIntoView(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGrpButtonItem(CurrentObject).ScrollIntoView;
  end;
end;

procedure TatButtonGroupLibrary.__GetTGrpButtonItemCollection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGrpButtonItem(CurrentObject).Collection));
  end;
end;

procedure TatButtonGroupLibrary.__SetTGrpButtonItemCollection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGrpButtonItem(CurrentObject).Collection:=TGrpButtonItems(Integer(GetInputArg(0)));
  end;
end;

procedure TatButtonGroupLibrary.__TGrpButtonItemsCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGrpButtonItemsClass(CurrentClass.ClassRef).Create(TButtonGroup(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatButtonGroupLibrary.__TGrpButtonItemsAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGrpButtonItems(CurrentObject).Add);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatButtonGroupLibrary.__TGrpButtonItemsAddItem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGrpButtonItems(CurrentObject).AddItem(TGrpButtonItem(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatButtonGroupLibrary.__TGrpButtonItemsBeginUpdate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGrpButtonItems(CurrentObject).BeginUpdate;
  end;
end;

procedure TatButtonGroupLibrary.__TGrpButtonItemsInsert(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGrpButtonItems(CurrentObject).Insert(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatButtonGroupLibrary.__GetTGrpButtonItemsItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGrpButtonItems(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatButtonGroupLibrary.__SetTGrpButtonItemsItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGrpButtonItems(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]:=TGrpButtonItem(Integer(GetInputArg(0)));
  end;
end;

procedure TatButtonGroupLibrary.__GetTGrpButtonItemsButtonGroup(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TGrpButtonItems(CurrentObject).ButtonGroup));
  end;
end;

procedure TatButtonGroupDispatcher.__TGrpButtonEvent( Sender: TObject;  Index: Integer);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TGrpButtonEvent(BeforeCall)(Sender,Index);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Index]);
    if AssignedMethod(AfterCall) then
      TGrpButtonEvent(AfterCall)(Sender,Index);
  end;
end;

procedure TatButtonGroupDispatcher.__TGrpButtonReorderEvent( Sender: TObject;  OldIndex: Integer;  NewIndex: Integer);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TGrpButtonReorderEvent(BeforeCall)(Sender,OldIndex,NewIndex);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,OldIndex,NewIndex]);
    if AssignedMethod(AfterCall) then
      TGrpButtonReorderEvent(AfterCall)(Sender,OldIndex,NewIndex);
  end;
end;

procedure TatButtonGroupLibrary.Init;
begin
  With Scripter.DefineClass(TButtonGroup) do
  begin
    DefineMethod('Create',1,tkClass,TButtonGroup,__TButtonGroupCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TButtonGroupDestroy,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TButtonGroupAssign,false,0);
    DefineMethod('DragDrop',3,tkNone,nil,__TButtonGroupDragDrop,false,0);
    DefineMethod('GetButtonRect',1,tkVariant,nil,__TButtonGroupGetButtonRect,false,0);
    DefineMethod('GetDragImages',0,tkClass,TDragImageList,__TButtonGroupGetDragImages,false,0);
    DefineMethod('IndexOfButtonAt',2,tkInteger,nil,__TButtonGroupIndexOfButtonAt,false,0);
    DefineMethod('RemoveInsertionPoints',0,tkNone,nil,__TButtonGroupRemoveInsertionPoints,false,0);
    DefineMethod('ScrollIntoView',1,tkNone,nil,__TButtonGroupScrollIntoView,false,0);
    DefineMethod('SetInsertionPoints',1,tkNone,nil,__TButtonGroupSetInsertionPoints,false,0);
    DefineMethod('TargetIndexAt',2,tkInteger,nil,__TButtonGroupTargetIndexAt,false,0);
    DefineProp('DragIndex',tkInteger,__GetTButtonGroupDragIndex,__SetTButtonGroupDragIndex,nil,false,0);
    DefineProp('DragImageList',tkClass,__GetTButtonGroupDragImageList,nil,TDragImageList,false,0);
    DefineProp('Canvas',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TGrpButtonItem) do
  begin
    DefineMethod('ScrollIntoView',0,tkNone,nil,__TGrpButtonItemScrollIntoView,false,0);
    DefineProp('Collection',tkClass,__GetTGrpButtonItemCollection,__SetTGrpButtonItemCollection,TGrpButtonItems,false,0);
  end;
  With Scripter.DefineClass(TGrpButtonItems) do
  begin
    DefineMethod('Create',1,tkClass,TGrpButtonItems,__TGrpButtonItemsCreate,true,0);
    DefineMethod('Add',0,tkClass,TGrpButtonItem,__TGrpButtonItemsAdd,false,0);
    DefineMethod('AddItem',2,tkClass,TGrpButtonItem,__TGrpButtonItemsAddItem,false,0);
    DefineMethod('BeginUpdate',0,tkNone,nil,__TGrpButtonItemsBeginUpdate,false,0);
    DefineMethod('Insert',1,tkClass,TGrpButtonItem,__TGrpButtonItemsInsert,false,0);
    DefaultProperty := DefineProp('Items',tkClass,__GetTGrpButtonItemsItems,__SetTGrpButtonItemsItems,TGrpButtonItem,false,1);
    DefineProp('ButtonGroup',tkClass,__GetTGrpButtonItemsButtonGroup,nil,TButtonGroup,false,0);
  end;
  DefineEventAdapter(TypeInfo(TGrpButtonEvent), TatButtonGroupDispatcher, @TatButtonGroupDispatcher.__TGrpButtonEvent);
  DefineEventAdapter(TypeInfo(TGrpButtonReorderEvent), TatButtonGroupDispatcher, @TatButtonGroupDispatcher.__TGrpButtonReorderEvent);
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatButtonGroupLibrary.LibraryName: string;
begin
  result := 'ButtonGroup';
end;

initialization
  RegisterScripterLibrary(TatButtonGroupLibrary, True);

{$WARNINGS ON}

end.

