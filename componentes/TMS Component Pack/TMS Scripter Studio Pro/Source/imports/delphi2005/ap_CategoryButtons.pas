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
unit ap_CategoryButtons;

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
  GraphUtil,
  ActnList,
  CategoryButtons,
  Variants,
  ap_Types,
  atScript;

{$WARNINGS OFF}

type
  TatCategoryButtonsLibrary = class(TatScripterLibrary)
    procedure __TCategoryButtonsCreate(AMachine: TatVirtualMachine);
    procedure __TCategoryButtonsDestroy(AMachine: TatVirtualMachine);
    procedure __TCategoryButtonsAssign(AMachine: TatVirtualMachine);
    procedure __TCategoryButtonsDragDrop(AMachine: TatVirtualMachine);
    procedure __TCategoryButtonsGetButtonRect(AMachine: TatVirtualMachine);
    procedure __TCategoryButtonsGetCategoryRect(AMachine: TatVirtualMachine);
    procedure __TCategoryButtonsGetButtonAt(AMachine: TatVirtualMachine);
    procedure __TCategoryButtonsGetCategoryAt(AMachine: TatVirtualMachine);
    procedure __TCategoryButtonsRemoveInsertionPoints(AMachine: TatVirtualMachine);
    procedure __TCategoryButtonsScrollIntoView(AMachine: TatVirtualMachine);
    procedure __TCategoryButtonsSetInsertionButton(AMachine: TatVirtualMachine);
    procedure __TCategoryButtonsGetTargetAt(AMachine: TatVirtualMachine);
    procedure __TCategoryButtonsUpdateButton(AMachine: TatVirtualMachine);
    procedure __TCategoryButtonsUpdateAllButtons(AMachine: TatVirtualMachine);
    procedure __GetTCategoryButtonsDragButton(AMachine: TatVirtualMachine);
    procedure __SetTCategoryButtonsDragButton(AMachine: TatVirtualMachine);
    procedure __GetTCategoryButtonsDragCategory(AMachine: TatVirtualMachine);
    procedure __SetTCategoryButtonsDragCategory(AMachine: TatVirtualMachine);
    procedure __GetTCategoryButtonsDragImageList(AMachine: TatVirtualMachine);
    procedure __GetTCategoryButtonsSelectedItem(AMachine: TatVirtualMachine);
    procedure __SetTCategoryButtonsSelectedItem(AMachine: TatVirtualMachine);
    procedure __GetTCategoryButtonsFocusedItem(AMachine: TatVirtualMachine);
    procedure __SetTCategoryButtonsFocusedItem(AMachine: TatVirtualMachine);
    procedure __TBaseButtonItemCreate(AMachine: TatVirtualMachine);
    procedure __TBaseButtonItemAssign(AMachine: TatVirtualMachine);
    procedure __TBaseButtonItemScrollIntoView(AMachine: TatVirtualMachine);
    procedure __TButtonItemAssign(AMachine: TatVirtualMachine);
    procedure __TButtonItemScrollIntoView(AMachine: TatVirtualMachine);
    procedure __GetTButtonItemCategory(AMachine: TatVirtualMachine);
    procedure __TButtonCollectionCreate(AMachine: TatVirtualMachine);
    procedure __TButtonCollectionAdd(AMachine: TatVirtualMachine);
    procedure __TButtonCollectionAddItem(AMachine: TatVirtualMachine);
    procedure __TButtonCollectionInsert(AMachine: TatVirtualMachine);
    procedure __GetTButtonCollectionItems(AMachine: TatVirtualMachine);
    procedure __SetTButtonCollectionItems(AMachine: TatVirtualMachine);
    procedure __GetTButtonCollectionCategory(AMachine: TatVirtualMachine);
    procedure __TButtonCategoryCreate(AMachine: TatVirtualMachine);
    procedure __TButtonCategoryDestroy(AMachine: TatVirtualMachine);
    procedure __TButtonCategoryScrollIntoView(AMachine: TatVirtualMachine);
    procedure __TButtonCategoryIndexOf(AMachine: TatVirtualMachine);
    procedure __TButtonCategoryAssign(AMachine: TatVirtualMachine);
    procedure __GetTButtonCategoryCategories(AMachine: TatVirtualMachine);
    procedure __TButtonCategoriesCreate(AMachine: TatVirtualMachine);
    procedure __TButtonCategoriesAdd(AMachine: TatVirtualMachine);
    procedure __TButtonCategoriesAddItem(AMachine: TatVirtualMachine);
    procedure __TButtonCategoriesBeginUpdate(AMachine: TatVirtualMachine);
    procedure __TButtonCategoriesInsert(AMachine: TatVirtualMachine);
    procedure __TButtonCategoriesIndexOf(AMachine: TatVirtualMachine);
    procedure __GetTButtonCategoriesItems(AMachine: TatVirtualMachine);
    procedure __SetTButtonCategoriesItems(AMachine: TatVirtualMachine);
    procedure __GetTButtonCategoriesButtonGroup(AMachine: TatVirtualMachine);
    procedure __TButtonItemActionLinkDoShowHint(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TCategoryButtonsClass = class of TCategoryButtons;
  TBaseButtonItemClass = class of TBaseButtonItem;
  TButtonItemClass = class of TButtonItem;
  TButtonCollectionClass = class of TButtonCollection;
  TButtonCategoryClass = class of TButtonCategory;
  TButtonCategoriesClass = class of TButtonCategories;
  TButtonItemActionLinkClass = class of TButtonItemActionLink;

  TatCategoryButtonsDispatcher = class(TatEventDispatcher)
  private
    procedure __TCatButtonEvent( Sender: TObject; const Button: TButtonItem);
    procedure __TCatButtonGetHint( Sender: TObject; const Button: TButtonItem; const Category: TButtonCategory; var HintStr: string; var Handled: Boolean);
    procedure __TCatButtonReorderEvent( Sender: TObject; const Button: TButtonItem; const SourceCategory: TButtonCategory; const TargetCategory: TButtonCategory);
    procedure __TCatButtonCopyEvent( Sender: TObject; const SourceButton: TButtonItem; const CopiedButton: TButtonItem);
    procedure __TCategoryReorderEvent( Sender: TObject; const SourceCategory: TButtonCategory; const TargetCategory: TButtonCategory);
    procedure __TCategoryCollapseEvent( Sender: TObject; const Category: TButtonCategory);
  end;


implementation



procedure TatCategoryButtonsLibrary.__TCategoryButtonsCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCategoryButtonsClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCategoryButtonsLibrary.__TCategoryButtonsDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCategoryButtons(CurrentObject).Destroy;
  end;
end;

procedure TatCategoryButtonsLibrary.__TCategoryButtonsAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCategoryButtons(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatCategoryButtonsLibrary.__TCategoryButtonsDragDrop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCategoryButtons(CurrentObject).DragDrop(TObject(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatCategoryButtonsLibrary.__TCategoryButtonsGetButtonRect(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TRectWrapper.Create(TCategoryButtons(CurrentObject).GetButtonRect(TButtonItem(Integer(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCategoryButtonsLibrary.__TCategoryButtonsGetCategoryRect(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TRectWrapper.Create(TCategoryButtons(CurrentObject).GetCategoryRect(TButtonCategory(Integer(GetInputArg(0))))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCategoryButtonsLibrary.__TCategoryButtonsGetButtonAt(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
2: AResult := Integer(TCategoryButtons(CurrentObject).GetButtonAt(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
3: AResult := Integer(TCategoryButtons(CurrentObject).GetButtonAt(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),TButtonCategory(Integer(GetInputArg(2)))));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCategoryButtonsLibrary.__TCategoryButtonsGetCategoryAt(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCategoryButtons(CurrentObject).GetCategoryAt(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCategoryButtonsLibrary.__TCategoryButtonsRemoveInsertionPoints(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCategoryButtons(CurrentObject).RemoveInsertionPoints;
  end;
end;

procedure TatCategoryButtonsLibrary.__TCategoryButtonsScrollIntoView(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCategoryButtons(CurrentObject).ScrollIntoView(TButtonItem(Integer(GetInputArg(0))));
  end;
end;

procedure TatCategoryButtonsLibrary.__TCategoryButtonsSetInsertionButton(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCategoryButtons(CurrentObject).SetInsertionButton(TButtonItem(Integer(GetInputArg(0))),TButtonCategory(Integer(GetInputArg(1))));
  end;
end;

procedure TatCategoryButtonsLibrary.__TCategoryButtonsGetTargetAt(AMachine: TatVirtualMachine);
  var
  Param2: TButtonItem;
  Param3: TButtonCategory;
begin
  with AMachine do
  begin
Param2 := TButtonItem(Integer(GetInputArg(2)));
Param3 := TButtonCategory(Integer(GetInputArg(3)));
    TCategoryButtons(CurrentObject).GetTargetAt(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2,Param3);
    SetInputArg(2,Integer(Param2));
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatCategoryButtonsLibrary.__TCategoryButtonsUpdateButton(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCategoryButtons(CurrentObject).UpdateButton(TButtonItem(Integer(GetInputArg(0))));
  end;
end;

procedure TatCategoryButtonsLibrary.__TCategoryButtonsUpdateAllButtons(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCategoryButtons(CurrentObject).UpdateAllButtons;
  end;
end;

procedure TatCategoryButtonsLibrary.__GetTCategoryButtonsDragButton(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCategoryButtons(CurrentObject).DragButton));
  end;
end;

procedure TatCategoryButtonsLibrary.__SetTCategoryButtonsDragButton(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCategoryButtons(CurrentObject).DragButton:=TButtonItem(Integer(GetInputArg(0)));
  end;
end;

procedure TatCategoryButtonsLibrary.__GetTCategoryButtonsDragCategory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCategoryButtons(CurrentObject).DragCategory));
  end;
end;

procedure TatCategoryButtonsLibrary.__SetTCategoryButtonsDragCategory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCategoryButtons(CurrentObject).DragCategory:=TButtonCategory(Integer(GetInputArg(0)));
  end;
end;

procedure TatCategoryButtonsLibrary.__GetTCategoryButtonsDragImageList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCategoryButtons(CurrentObject).DragImageList));
  end;
end;

procedure TatCategoryButtonsLibrary.__GetTCategoryButtonsSelectedItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCategoryButtons(CurrentObject).SelectedItem));
  end;
end;

procedure TatCategoryButtonsLibrary.__SetTCategoryButtonsSelectedItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCategoryButtons(CurrentObject).SelectedItem:=TButtonItem(Integer(GetInputArg(0)));
  end;
end;

procedure TatCategoryButtonsLibrary.__GetTCategoryButtonsFocusedItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCategoryButtons(CurrentObject).FocusedItem));
  end;
end;

procedure TatCategoryButtonsLibrary.__SetTCategoryButtonsFocusedItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCategoryButtons(CurrentObject).FocusedItem:=TButtonItem(Integer(GetInputArg(0)));
  end;
end;

procedure TatCategoryButtonsLibrary.__TBaseButtonItemCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TBaseButtonItemClass(CurrentClass.ClassRef).Create(TCollection(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCategoryButtonsLibrary.__TBaseButtonItemAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBaseButtonItem(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatCategoryButtonsLibrary.__TBaseButtonItemScrollIntoView(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBaseButtonItem(CurrentObject).ScrollIntoView;
  end;
end;

procedure TatCategoryButtonsLibrary.__TButtonItemAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TButtonItem(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatCategoryButtonsLibrary.__TButtonItemScrollIntoView(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TButtonItem(CurrentObject).ScrollIntoView;
  end;
end;

procedure TatCategoryButtonsLibrary.__GetTButtonItemCategory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TButtonItem(CurrentObject).Category));
  end;
end;

procedure TatCategoryButtonsLibrary.__TButtonCollectionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TButtonCollectionClass(CurrentClass.ClassRef).Create(TButtonCategory(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCategoryButtonsLibrary.__TButtonCollectionAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TButtonCollection(CurrentObject).Add);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCategoryButtonsLibrary.__TButtonCollectionAddItem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TButtonCollection(CurrentObject).AddItem(TButtonItem(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCategoryButtonsLibrary.__TButtonCollectionInsert(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TButtonCollection(CurrentObject).Insert(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCategoryButtonsLibrary.__GetTButtonCollectionItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TButtonCollection(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatCategoryButtonsLibrary.__SetTButtonCollectionItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TButtonCollection(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]:=TButtonItem(Integer(GetInputArg(0)));
  end;
end;

procedure TatCategoryButtonsLibrary.__GetTButtonCollectionCategory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TButtonCollection(CurrentObject).Category));
  end;
end;

procedure TatCategoryButtonsLibrary.__TButtonCategoryCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TButtonCategoryClass(CurrentClass.ClassRef).Create(TCollection(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCategoryButtonsLibrary.__TButtonCategoryDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TButtonCategory(CurrentObject).Destroy;
  end;
end;

procedure TatCategoryButtonsLibrary.__TButtonCategoryScrollIntoView(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TButtonCategory(CurrentObject).ScrollIntoView;
  end;
end;

procedure TatCategoryButtonsLibrary.__TButtonCategoryIndexOf(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TButtonCategory(CurrentObject).IndexOf(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCategoryButtonsLibrary.__TButtonCategoryAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TButtonCategory(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatCategoryButtonsLibrary.__GetTButtonCategoryCategories(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TButtonCategory(CurrentObject).Categories));
  end;
end;

procedure TatCategoryButtonsLibrary.__TButtonCategoriesCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TButtonCategoriesClass(CurrentClass.ClassRef).Create(TCategoryButtons(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCategoryButtonsLibrary.__TButtonCategoriesAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TButtonCategories(CurrentObject).Add);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCategoryButtonsLibrary.__TButtonCategoriesAddItem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TButtonCategories(CurrentObject).AddItem(TButtonCategory(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCategoryButtonsLibrary.__TButtonCategoriesBeginUpdate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TButtonCategories(CurrentObject).BeginUpdate;
  end;
end;

procedure TatCategoryButtonsLibrary.__TButtonCategoriesInsert(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TButtonCategories(CurrentObject).Insert(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCategoryButtonsLibrary.__TButtonCategoriesIndexOf(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TButtonCategories(CurrentObject).IndexOf(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatCategoryButtonsLibrary.__GetTButtonCategoriesItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TButtonCategories(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatCategoryButtonsLibrary.__SetTButtonCategoriesItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TButtonCategories(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]:=TButtonCategory(Integer(GetInputArg(0)));
  end;
end;

procedure TatCategoryButtonsLibrary.__GetTButtonCategoriesButtonGroup(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TButtonCategories(CurrentObject).ButtonGroup));
  end;
end;

procedure TatCategoryButtonsLibrary.__TButtonItemActionLinkDoShowHint(AMachine: TatVirtualMachine);
  var
  Param0: string;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
AResult := TButtonItemActionLink(CurrentObject).DoShowHint(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,Param0);
  end;
end;

procedure TatCategoryButtonsDispatcher.__TCatButtonEvent( Sender: TObject; const Button: TButtonItem);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TCatButtonEvent(BeforeCall)(Sender,Button);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Button]);
    if AssignedMethod(AfterCall) then
      TCatButtonEvent(AfterCall)(Sender,Button);
  end;
end;

procedure TatCategoryButtonsDispatcher.__TCatButtonGetHint( Sender: TObject; const Button: TButtonItem; const Category: TButtonCategory; var HintStr: string; var Handled: Boolean);
var
  HintStrTemp: variant;
  HandledTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TCatButtonGetHint(BeforeCall)(Sender,Button,Category,HintStr,Handled);
    HintStrTemp := HintStr;
    HandledTemp := Handled;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Button,Category,HintStrTemp,HandledTemp]);
    HintStr := HintStrTemp;
    Handled := HandledTemp;
    if AssignedMethod(AfterCall) then
      TCatButtonGetHint(AfterCall)(Sender,Button,Category,HintStr,Handled);
  end;
end;

procedure TatCategoryButtonsDispatcher.__TCatButtonReorderEvent( Sender: TObject; const Button: TButtonItem; const SourceCategory: TButtonCategory; const TargetCategory: TButtonCategory);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TCatButtonReorderEvent(BeforeCall)(Sender,Button,SourceCategory,TargetCategory);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Button,SourceCategory,TargetCategory]);
    if AssignedMethod(AfterCall) then
      TCatButtonReorderEvent(AfterCall)(Sender,Button,SourceCategory,TargetCategory);
  end;
end;

procedure TatCategoryButtonsDispatcher.__TCatButtonCopyEvent( Sender: TObject; const SourceButton: TButtonItem; const CopiedButton: TButtonItem);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TCatButtonCopyEvent(BeforeCall)(Sender,SourceButton,CopiedButton);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,SourceButton,CopiedButton]);
    if AssignedMethod(AfterCall) then
      TCatButtonCopyEvent(AfterCall)(Sender,SourceButton,CopiedButton);
  end;
end;

procedure TatCategoryButtonsDispatcher.__TCategoryReorderEvent( Sender: TObject; const SourceCategory: TButtonCategory; const TargetCategory: TButtonCategory);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TCategoryReorderEvent(BeforeCall)(Sender,SourceCategory,TargetCategory);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,SourceCategory,TargetCategory]);
    if AssignedMethod(AfterCall) then
      TCategoryReorderEvent(AfterCall)(Sender,SourceCategory,TargetCategory);
  end;
end;

procedure TatCategoryButtonsDispatcher.__TCategoryCollapseEvent( Sender: TObject; const Category: TButtonCategory);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TCategoryCollapseEvent(BeforeCall)(Sender,Category);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Category]);
    if AssignedMethod(AfterCall) then
      TCategoryCollapseEvent(AfterCall)(Sender,Category);
  end;
end;

procedure TatCategoryButtonsLibrary.Init;
begin
  With Scripter.DefineClass(TCategoryButtons) do
  begin
    DefineMethod('Create',1,tkClass,TCategoryButtons,__TCategoryButtonsCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCategoryButtonsDestroy,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TCategoryButtonsAssign,false,0);
    DefineMethod('DragDrop',3,tkNone,nil,__TCategoryButtonsDragDrop,false,0);
    DefineMethod('GetButtonRect',1,tkVariant,nil,__TCategoryButtonsGetButtonRect,false,0);
    DefineMethod('GetCategoryRect',1,tkVariant,nil,__TCategoryButtonsGetCategoryRect,false,0);
    DefineMethod('GetButtonAt',3,tkClass,TButtonItem,__TCategoryButtonsGetButtonAt,false,1);
    DefineMethod('GetCategoryAt',2,tkClass,TButtonCategory,__TCategoryButtonsGetCategoryAt,false,0);
    DefineMethod('RemoveInsertionPoints',0,tkNone,nil,__TCategoryButtonsRemoveInsertionPoints,false,0);
    DefineMethod('ScrollIntoView',1,tkNone,nil,__TCategoryButtonsScrollIntoView,false,0);
    DefineMethod('SetInsertionButton',2,tkNone,nil,__TCategoryButtonsSetInsertionButton,false,0);
    DefineMethod('GetTargetAt',4,tkNone,nil,__TCategoryButtonsGetTargetAt,false,0).SetVarArgs([2,3]);
    DefineMethod('UpdateButton',1,tkNone,nil,__TCategoryButtonsUpdateButton,false,0);
    DefineMethod('UpdateAllButtons',0,tkNone,nil,__TCategoryButtonsUpdateAllButtons,false,0);
    DefineProp('DragButton',tkClass,__GetTCategoryButtonsDragButton,__SetTCategoryButtonsDragButton,TButtonItem,false,0);
    DefineProp('DragCategory',tkClass,__GetTCategoryButtonsDragCategory,__SetTCategoryButtonsDragCategory,TButtonCategory,false,0);
    DefineProp('DragImageList',tkClass,__GetTCategoryButtonsDragImageList,nil,TDragImageList,false,0);
    DefineProp('SelectedItem',tkClass,__GetTCategoryButtonsSelectedItem,__SetTCategoryButtonsSelectedItem,TButtonItem,false,0);
    DefineProp('FocusedItem',tkClass,__GetTCategoryButtonsFocusedItem,__SetTCategoryButtonsFocusedItem,TButtonItem,false,0);
  end;
  With Scripter.DefineClass(TBaseButtonItem) do
  begin
    DefineMethod('Create',1,tkClass,TBaseButtonItem,__TBaseButtonItemCreate,true,0);
    DefineMethod('Assign',1,tkNone,nil,__TBaseButtonItemAssign,false,0);
    DefineMethod('ScrollIntoView',0,tkNone,nil,__TBaseButtonItemScrollIntoView,false,0);
  end;
  With Scripter.DefineClass(TButtonItem) do
  begin
    DefineMethod('Assign',1,tkNone,nil,__TButtonItemAssign,false,0);
    DefineMethod('ScrollIntoView',0,tkNone,nil,__TButtonItemScrollIntoView,false,0);
    DefineProp('Category',tkClass,__GetTButtonItemCategory,nil,TButtonCategory,false,0);
  end;
  With Scripter.DefineClass(TButtonCollection) do
  begin
    DefineMethod('Create',1,tkClass,TButtonCollection,__TButtonCollectionCreate,true,0);
    DefineMethod('Add',0,tkClass,TButtonItem,__TButtonCollectionAdd,false,0);
    DefineMethod('AddItem',2,tkClass,TButtonItem,__TButtonCollectionAddItem,false,0);
    DefineMethod('Insert',1,tkClass,TButtonItem,__TButtonCollectionInsert,false,0);
    DefaultProperty := DefineProp('Items',tkClass,__GetTButtonCollectionItems,__SetTButtonCollectionItems,TButtonItem,false,1);
    DefineProp('Category',tkClass,__GetTButtonCollectionCategory,nil,TButtonCategory,false,0);
  end;
  With Scripter.DefineClass(TButtonCategory) do
  begin
    DefineMethod('Create',1,tkClass,TButtonCategory,__TButtonCategoryCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TButtonCategoryDestroy,false,0);
    DefineMethod('ScrollIntoView',0,tkNone,nil,__TButtonCategoryScrollIntoView,false,0);
    DefineMethod('IndexOf',1,tkInteger,nil,__TButtonCategoryIndexOf,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TButtonCategoryAssign,false,0);
    DefineProp('Categories',tkClass,__GetTButtonCategoryCategories,nil,TButtonCategories,false,0);
  end;
  With Scripter.DefineClass(TButtonCategories) do
  begin
    DefineMethod('Create',1,tkClass,TButtonCategories,__TButtonCategoriesCreate,true,0);
    DefineMethod('Add',0,tkClass,TButtonCategory,__TButtonCategoriesAdd,false,0);
    DefineMethod('AddItem',2,tkClass,TButtonCategory,__TButtonCategoriesAddItem,false,0);
    DefineMethod('BeginUpdate',0,tkNone,nil,__TButtonCategoriesBeginUpdate,false,0);
    DefineMethod('Insert',1,tkClass,TButtonCategory,__TButtonCategoriesInsert,false,0);
    DefineMethod('IndexOf',1,tkInteger,nil,__TButtonCategoriesIndexOf,false,0);
    DefaultProperty := DefineProp('Items',tkClass,__GetTButtonCategoriesItems,__SetTButtonCategoriesItems,TButtonCategory,false,1);
    DefineProp('ButtonGroup',tkClass,__GetTButtonCategoriesButtonGroup,nil,TCategoryButtons,false,0);
  end;
  With Scripter.DefineClass(TButtonItemActionLink) do
  begin
    DefineMethod('DoShowHint',1,tkVariant,nil,__TButtonItemActionLinkDoShowHint,false,0).SetVarArgs([0]);
  end;
  DefineEventAdapter(TypeInfo(TCatButtonEvent), TatCategoryButtonsDispatcher, @TatCategoryButtonsDispatcher.__TCatButtonEvent);
  DefineEventAdapter(TypeInfo(TCatButtonGetHint), TatCategoryButtonsDispatcher, @TatCategoryButtonsDispatcher.__TCatButtonGetHint);
  DefineEventAdapter(TypeInfo(TCatButtonReorderEvent), TatCategoryButtonsDispatcher, @TatCategoryButtonsDispatcher.__TCatButtonReorderEvent);
  DefineEventAdapter(TypeInfo(TCatButtonCopyEvent), TatCategoryButtonsDispatcher, @TatCategoryButtonsDispatcher.__TCatButtonCopyEvent);
  DefineEventAdapter(TypeInfo(TCategoryReorderEvent), TatCategoryButtonsDispatcher, @TatCategoryButtonsDispatcher.__TCategoryReorderEvent);
  DefineEventAdapter(TypeInfo(TCategoryCollapseEvent), TatCategoryButtonsDispatcher, @TatCategoryButtonsDispatcher.__TCategoryCollapseEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('cbfVertical',cbfVertical);
    AddConstant('cbfHorizontal',cbfHorizontal);
    AddConstant('crDragCopy',crDragCopy);
  end;
end;

class function TatCategoryButtonsLibrary.LibraryName: string;
begin
  result := 'CategoryButtons';
end;

initialization
  RegisterScripterLibrary(TatCategoryButtonsLibrary, True);

{$WARNINGS ON}

end.

