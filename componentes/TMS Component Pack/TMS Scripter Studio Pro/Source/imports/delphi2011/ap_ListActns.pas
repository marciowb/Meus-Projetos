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
unit ap_ListActns;

interface

uses
  Classes,
  Controls,
  ActnList,
  ImgList,
  ListActns,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatListActnsLibrary = class(TatScripterLibrary)
    procedure __TListControlItemCreate(AMachine: TatVirtualMachine);
    procedure __TListControlItemAssign(AMachine: TatVirtualMachine);
    procedure __TListControlItemsAdd(AMachine: TatVirtualMachine);
    procedure __TListControlItemsSort(AMachine: TatVirtualMachine);
    procedure __GetTListControlItemsItems(AMachine: TatVirtualMachine);
    procedure __TCustomListActionCreate(AMachine: TatVirtualMachine);
    procedure __TCustomListActionExecuteTarget(AMachine: TatVirtualMachine);
    procedure __TCustomListActionHandlesTarget(AMachine: TatVirtualMachine);
    procedure __GetTCustomListActionActive(AMachine: TatVirtualMachine);
    procedure __SetTCustomListActionActive(AMachine: TatVirtualMachine);
    procedure __GetTCustomListActionCount(AMachine: TatVirtualMachine);
    procedure __GetTCustomListActionItemIndex(AMachine: TatVirtualMachine);
    procedure __SetTCustomListActionItemIndex(AMachine: TatVirtualMachine);
    procedure __GetTCustomListActionStrings(AMachine: TatVirtualMachine);
    procedure __SetTCustomListActionStrings(AMachine: TatVirtualMachine);
    procedure __TCustomStaticListActionCreate(AMachine: TatVirtualMachine);
    procedure __TCustomStaticListActionDestroy(AMachine: TatVirtualMachine);
    procedure __GetTCustomStaticListActionItems(AMachine: TatVirtualMachine);
    procedure __SetTCustomStaticListActionItems(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TListControlItemClass = class of TListControlItem;
  TListControlItemsClass = class of TListControlItems;
  TCustomListActionClass = class of TCustomListAction;
  TCustomVirtualListActionClass = class of TCustomVirtualListAction;
  TVirtualListActionClass = class of TVirtualListAction;
  TStaticListItemsClass = class of TStaticListItems;
  TCustomStaticListActionClass = class of TCustomStaticListAction;
  TStaticListActionClass = class of TStaticListAction;
  TListActionLinkClass = class of TListActionLink;

  TatListActnsDispatcher = class(TatEventDispatcher)
  private
    function __TListCompareEvent( List: TListControlItems;  Item1: TListControlItem;  Item2: TListControlItem): Integer;
    procedure __TGetItemCountEvent( Sender: TCustomListAction; var Count: Integer);
    procedure __TItemSelectedEvent( Sender: TCustomListAction;  Control: TControl);
    procedure __TGetItemEvent( Sender: TCustomListAction; const Index: Integer; var Item: TListControlItem);
  end;


implementation



procedure TatListActnsLibrary.__TListControlItemCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TListControlItemClass(CurrentClass.ClassRef).Create(TCollection(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatListActnsLibrary.__TListControlItemAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListControlItem(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatListActnsLibrary.__TListControlItemsAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TListControlItems(CurrentObject).Add);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatListActnsLibrary.__TListControlItemsSort(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TListControlItems(CurrentObject).Sort;
  end;
end;

procedure TatListActnsLibrary.__GetTListControlItemsItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TListControlItems(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatListActnsLibrary.__TCustomListActionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomListActionClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatListActnsLibrary.__TCustomListActionExecuteTarget(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListAction(CurrentObject).ExecuteTarget(TObject(integer(GetInputArg(0))));
  end;
end;

procedure TatListActnsLibrary.__TCustomListActionHandlesTarget(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomListAction(CurrentObject).HandlesTarget(TObject(integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatListActnsLibrary.__GetTCustomListActionActive(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomListAction(CurrentObject).Active);
  end;
end;

procedure TatListActnsLibrary.__SetTCustomListActionActive(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListAction(CurrentObject).Active:=GetInputArg(0);
  end;
end;

procedure TatListActnsLibrary.__GetTCustomListActionCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomListAction(CurrentObject).Count));
  end;
end;

procedure TatListActnsLibrary.__GetTCustomListActionItemIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomListAction(CurrentObject).ItemIndex));
  end;
end;

procedure TatListActnsLibrary.__SetTCustomListActionItemIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListAction(CurrentObject).ItemIndex:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatListActnsLibrary.__GetTCustomListActionStrings(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomListAction(CurrentObject).Strings[VarToInteger(GetArrayIndex(0))]);
  end;
end;

procedure TatListActnsLibrary.__SetTCustomListActionStrings(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListAction(CurrentObject).Strings[VarToInteger(GetArrayIndex(0))]:=GetInputArg(0);
  end;
end;

procedure TatListActnsLibrary.__TCustomStaticListActionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomStaticListActionClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatListActnsLibrary.__TCustomStaticListActionDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomStaticListAction(CurrentObject).Destroy;
  end;
end;

procedure TatListActnsLibrary.__GetTCustomStaticListActionItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomStaticListAction(CurrentObject).Items));
  end;
end;

procedure TatListActnsLibrary.__SetTCustomStaticListActionItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomStaticListAction(CurrentObject).Items:=TStaticListItems(Integer(GetInputArg(0)));
  end;
end;

function TatListActnsDispatcher.__TListCompareEvent( List: TListControlItems;  Item1: TListControlItem;  Item2: TListControlItem): Integer;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TListCompareEvent(BeforeCall)(List,Item1,Item2);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [List,Item1,Item2]);
    if AssignedMethod(AfterCall) then
      TListCompareEvent(AfterCall)(List,Item1,Item2);
  end;
end;

procedure TatListActnsDispatcher.__TGetItemCountEvent( Sender: TCustomListAction; var Count: Integer);
var
  CountTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TGetItemCountEvent(BeforeCall)(Sender,Count);
    CountTemp := Integer(Count);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,CountTemp]);
    Count := VarToInteger(CountTemp);
    if AssignedMethod(AfterCall) then
      TGetItemCountEvent(AfterCall)(Sender,Count);
  end;
end;

procedure TatListActnsDispatcher.__TItemSelectedEvent( Sender: TCustomListAction;  Control: TControl);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TItemSelectedEvent(BeforeCall)(Sender,Control);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Control]);
    if AssignedMethod(AfterCall) then
      TItemSelectedEvent(AfterCall)(Sender,Control);
  end;
end;

procedure TatListActnsDispatcher.__TGetItemEvent( Sender: TCustomListAction; const Index: Integer; var Item: TListControlItem);
var
  ItemTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TGetItemEvent(BeforeCall)(Sender,Index,Item);
    ItemTemp := Integer(Item);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Index,ItemTemp]);
    Item := TListControlItem(Integer(ItemTemp));
    if AssignedMethod(AfterCall) then
      TGetItemEvent(AfterCall)(Sender,Index,Item);
  end;
end;

procedure TatListActnsLibrary.Init;
begin
  With Scripter.DefineClass(TListControlItem) do
  begin
    DefineMethod('Create',1,tkClass,TListControlItem,__TListControlItemCreate,true,0);
    DefineMethod('Assign',1,tkNone,nil,__TListControlItemAssign,false,0);
  end;
  With Scripter.DefineClass(TListControlItems) do
  begin
    DefineMethod('Add',0,tkClass,TListControlItem,__TListControlItemsAdd,false,0);
    DefineMethod('Sort',0,tkNone,nil,__TListControlItemsSort,false,0);
    DefaultProperty := DefineProp('Items',tkClass,__GetTListControlItemsItems,nil,TListControlItem,false,1);
  end;
  With Scripter.DefineClass(TCustomListAction) do
  begin
    DefineMethod('Create',1,tkClass,TCustomListAction,__TCustomListActionCreate,true,0);
    DefineMethod('ExecuteTarget',1,tkNone,nil,__TCustomListActionExecuteTarget,false,0);
    DefineMethod('HandlesTarget',1,tkVariant,nil,__TCustomListActionHandlesTarget,false,0);
    DefineProp('Active',tkVariant,__GetTCustomListActionActive,__SetTCustomListActionActive,nil,false,0);
    DefineProp('Count',tkInteger,__GetTCustomListActionCount,nil,nil,false,0);
    DefineProp('ItemIndex',tkInteger,__GetTCustomListActionItemIndex,__SetTCustomListActionItemIndex,nil,false,0);
    DefaultProperty := DefineProp('Strings',tkVariant,__GetTCustomListActionStrings,__SetTCustomListActionStrings,nil,false,1);
  end;
  With Scripter.DefineClass(TCustomVirtualListAction) do
  begin
    DefineProp('Count',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TVirtualListAction) do
  begin
  end;
  With Scripter.DefineClass(TStaticListItems) do
  begin
  end;
  With Scripter.DefineClass(TCustomStaticListAction) do
  begin
    DefineMethod('Create',1,tkClass,TCustomStaticListAction,__TCustomStaticListActionCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomStaticListActionDestroy,false,0);
    DefineProp('Count',tkVariant,nil,nil,nil,false,0);
    DefineProp('Items',tkClass,__GetTCustomStaticListActionItems,__SetTCustomStaticListActionItems,TStaticListItems,false,0);
  end;
  With Scripter.DefineClass(TStaticListAction) do
  begin
  end;
  With Scripter.DefineClass(TListActionLink) do
  begin
  end;
  DefineEventAdapter(TypeInfo(TListCompareEvent), TatListActnsDispatcher, @TatListActnsDispatcher.__TListCompareEvent);
  DefineEventAdapter(TypeInfo(TGetItemCountEvent), TatListActnsDispatcher, @TatListActnsDispatcher.__TGetItemCountEvent);
  DefineEventAdapter(TypeInfo(TItemSelectedEvent), TatListActnsDispatcher, @TatListActnsDispatcher.__TItemSelectedEvent);
  DefineEventAdapter(TypeInfo(TGetItemEvent), TatListActnsDispatcher, @TatListActnsDispatcher.__TGetItemEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('stNone',stNone);
    AddConstant('stData',stData);
    AddConstant('stText',stText);
    AddConstant('stBoth',stBoth);
  end;
end;

class function TatListActnsLibrary.LibraryName: string;
begin
  result := 'ListActns';
end;

initialization
  RegisterScripterLibrary(TatListActnsLibrary, True);

{$WARNINGS ON}

end.

