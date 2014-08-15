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
unit ap_Tabs;

interface

uses
  Windows,
  Classes,
  Graphics,
  Forms,
  Controls,
  Messages,
  Tabs,
  Variants,
  ap_Types,
  atScript;

{$WARNINGS OFF}

type
  TatTabsLibrary = class(TatScripterLibrary)
    procedure __TScrollerCreate(AMachine: TatVirtualMachine);
    procedure __TScrollerDestroy(AMachine: TatVirtualMachine);
    procedure __TScrollerPaint(AMachine: TatVirtualMachine);
    procedure __TTabListInsert(AMachine: TatVirtualMachine);
    procedure __TTabListDelete(AMachine: TatVirtualMachine);
    procedure __TTabListAdd(AMachine: TatVirtualMachine);
    procedure __TTabListPut(AMachine: TatVirtualMachine);
    procedure __TTabListClear(AMachine: TatVirtualMachine);
    procedure __TTabListAddStrings(AMachine: TatVirtualMachine);
    procedure __TTabSetCreate(AMachine: TatVirtualMachine);
    procedure __TTabSetDestroy(AMachine: TatVirtualMachine);
    procedure __TTabSetItemAtPos(AMachine: TatVirtualMachine);
    procedure __TTabSetItemRect(AMachine: TatVirtualMachine);
    procedure __TTabSetItemWidth(AMachine: TatVirtualMachine);
    procedure __TTabSetMinClientRect(AMachine: TatVirtualMachine);
    procedure __TTabSetSelectNext(AMachine: TatVirtualMachine);
    procedure __GetTTabSetFirstIndex(AMachine: TatVirtualMachine);
    procedure __SetTTabSetFirstIndex(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TScrollerClass = class of TScroller;
  TTabListClass = class of TTabList;
  TTabSetClass = class of TTabSet;

  TatTabsDispatcher = class(TatEventDispatcher)
  private
    procedure __TMeasureTabEvent( Sender: TObject;  Index: Integer; var TabWidth: Integer);
    procedure __TTabChangeEvent( Sender: TObject;  NewTab: Integer; var AllowChange: Boolean);
  end;


implementation



procedure TatTabsLibrary.__TScrollerCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TScrollerClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTabsLibrary.__TScrollerDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScroller(CurrentObject).Destroy;
  end;
end;

procedure TatTabsLibrary.__TScrollerPaint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScroller(CurrentObject).Paint;
  end;
end;

procedure TatTabsLibrary.__TTabListInsert(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTabList(CurrentObject).Insert(VarToInteger(GetInputArg(0)),GetInputArg(1));
  end;
end;

procedure TatTabsLibrary.__TTabListDelete(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTabList(CurrentObject).Delete(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatTabsLibrary.__TTabListAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTabList(CurrentObject).Add(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTabsLibrary.__TTabListPut(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTabList(CurrentObject).Put(VarToInteger(GetInputArg(0)),GetInputArg(1));
  end;
end;

procedure TatTabsLibrary.__TTabListClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTabList(CurrentObject).Clear;
  end;
end;

procedure TatTabsLibrary.__TTabListAddStrings(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTabList(CurrentObject).AddStrings(TStrings(Integer(GetInputArg(0))));
  end;
end;

procedure TatTabsLibrary.__TTabSetCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTabSetClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTabsLibrary.__TTabSetDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTabSet(CurrentObject).Destroy;
  end;
end;

procedure TatTabsLibrary.__TTabSetItemAtPos(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTabSet(CurrentObject).ItemAtPos(TPointWrapper(integer(GetInputArg(0))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTabsLibrary.__TTabSetItemRect(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TRectWrapper.Create(TTabSet(CurrentObject).ItemRect(VarToInteger(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTabsLibrary.__TTabSetItemWidth(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTabSet(CurrentObject).ItemWidth(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTabsLibrary.__TTabSetMinClientRect(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TRectWrapper.Create(TTabSet(CurrentObject).MinClientRect));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatTabsLibrary.__TTabSetSelectNext(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTabSet(CurrentObject).SelectNext(GetInputArg(0));
  end;
end;

procedure TatTabsLibrary.__GetTTabSetFirstIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TTabSet(CurrentObject).FirstIndex));
  end;
end;

procedure TatTabsLibrary.__SetTTabSetFirstIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTabSet(CurrentObject).FirstIndex:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatTabsDispatcher.__TMeasureTabEvent( Sender: TObject;  Index: Integer; var TabWidth: Integer);
var
  TabWidthTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TMeasureTabEvent(BeforeCall)(Sender,Index,TabWidth);
    TabWidthTemp := Integer(TabWidth);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Index,TabWidthTemp]);
    TabWidth := VarToInteger(TabWidthTemp);
    if AssignedMethod(AfterCall) then
      TMeasureTabEvent(AfterCall)(Sender,Index,TabWidth);
  end;
end;

procedure TatTabsDispatcher.__TTabChangeEvent( Sender: TObject;  NewTab: Integer; var AllowChange: Boolean);
var
  AllowChangeTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TTabChangeEvent(BeforeCall)(Sender,NewTab,AllowChange);
    AllowChangeTemp := AllowChange;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,NewTab,AllowChangeTemp]);
    AllowChange := AllowChangeTemp;
    if AssignedMethod(AfterCall) then
      TTabChangeEvent(AfterCall)(Sender,NewTab,AllowChange);
  end;
end;

procedure TatTabsLibrary.Init;
begin
  With Scripter.DefineClass(TScroller) do
  begin
    DefineMethod('Create',1,tkClass,TScroller,__TScrollerCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TScrollerDestroy,false,0);
    DefineMethod('Paint',0,tkNone,nil,__TScrollerPaint,false,0);
  end;
  With Scripter.DefineClass(TTabList) do
  begin
    DefineMethod('Insert',2,tkNone,nil,__TTabListInsert,false,0);
    DefineMethod('Delete',1,tkNone,nil,__TTabListDelete,false,0);
    DefineMethod('Add',1,tkInteger,nil,__TTabListAdd,false,0);
    DefineMethod('Put',2,tkNone,nil,__TTabListPut,false,0);
    DefineMethod('Clear',0,tkNone,nil,__TTabListClear,false,0);
    DefineMethod('AddStrings',1,tkNone,nil,__TTabListAddStrings,false,0);
  end;
  With Scripter.DefineClass(TTabSet) do
  begin
    DefineMethod('Create',1,tkClass,TTabSet,__TTabSetCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TTabSetDestroy,false,0);
    DefineMethod('ItemAtPos',1,tkInteger,nil,__TTabSetItemAtPos,false,0);
    DefineMethod('ItemRect',1,tkVariant,nil,__TTabSetItemRect,false,0);
    DefineMethod('ItemWidth',1,tkInteger,nil,__TTabSetItemWidth,false,0);
    DefineMethod('MinClientRect',0,tkVariant,nil,__TTabSetMinClientRect,false,0);
    DefineMethod('SelectNext',1,tkNone,nil,__TTabSetSelectNext,false,0);
    DefineProp('Canvas',tkVariant,nil,nil,nil,false,0);
    DefineProp('FirstIndex',tkInteger,__GetTTabSetFirstIndex,__SetTTabSetFirstIndex,nil,false,0);
  end;
  DefineEventAdapter(TypeInfo(TMeasureTabEvent), TatTabsDispatcher, @TatTabsDispatcher.__TMeasureTabEvent);
  DefineEventAdapter(TypeInfo(TTabChangeEvent), TatTabsDispatcher, @TatTabsDispatcher.__TTabChangeEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('sbLeft',sbLeft);
    AddConstant('sbRight',sbRight);
    AddConstant('epSelectedLeft',epSelectedLeft);
    AddConstant('epUnselectedLeft',epUnselectedLeft);
    AddConstant('epSelectedRight',epSelectedRight);
    AddConstant('epUnselectedRight',epUnselectedRight);
    AddConstant('etNone',etNone);
    AddConstant('etFirstIsSel',etFirstIsSel);
    AddConstant('etFirstNotSel',etFirstNotSel);
    AddConstant('etLastIsSel',etLastIsSel);
    AddConstant('etLastNotSel',etLastNotSel);
    AddConstant('etNotSelToSel',etNotSelToSel);
    AddConstant('etSelToNotSel',etSelToNotSel);
    AddConstant('etNotSelToNotSel',etNotSelToNotSel);
    AddConstant('tsStandard',tsStandard);
    AddConstant('tsOwnerDraw',tsOwnerDraw);
  end;
end;

class function TatTabsLibrary.LibraryName: string;
begin
  result := 'Tabs';
end;

initialization
  RegisterScripterLibrary(TatTabsLibrary, True);

{$WARNINGS ON}

end.

