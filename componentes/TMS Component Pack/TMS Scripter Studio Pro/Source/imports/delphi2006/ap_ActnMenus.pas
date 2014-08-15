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
unit ap_ActnMenus;

interface

uses
  Windows,
  Messages,
  Classes,
  Forms,
  Controls,
  Contnrs,
  Graphics,
  ActnList,
  ToolWin,
  ExtCtrls,
  ActnMan,
  ActnCtrls,
  Menus,
  StdCtrls,
  ShadowWnd,
  Buttons,
  StdActns,
  ActnMenus,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatActnMenusLibrary = class(TatScripterLibrary)
    procedure __TMenuStackCreate(AMachine: TatVirtualMachine);
    procedure __TMenuStackPush(AMachine: TatVirtualMachine);
    procedure __TMenuStackPop(AMachine: TatVirtualMachine);
    procedure __TMenuStackPeek(AMachine: TatVirtualMachine);
    procedure __TCustomActionMenuBarCreate(AMachine: TatVirtualMachine);
    procedure __TCustomActionMenuBarDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomActionMenuBarCloseMenu(AMachine: TatVirtualMachine);
    procedure __TCustomActionMenuBarRecreateControls(AMachine: TatVirtualMachine);
    procedure __TCustomActionMenuBarStyle(AMachine: TatVirtualMachine);
    procedure __TCustomActionMenuBarTrackMenu(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionMenuBarAnimationStyle(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionMenuBarAnimationStyle(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionMenuBarAutoFocus(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionMenuBarAutoFocus(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionMenuBarExpandDelay(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionMenuBarExpandDelay(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionMenuBarInMenuLoop(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionMenuBarInMenuLoop(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionMenuBarParentControl(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionMenuBarParentControl(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionMenuBarRootMenu(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionMenuBarRootMenu(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionMenuBarUseSystemFont(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionMenuBarUseSystemFont(AMachine: TatVirtualMachine);
    procedure __TCustomMenuExpandBtnCreate(AMachine: TatVirtualMachine);
    procedure __TCustomActionPopupMenuCreate(AMachine: TatVirtualMachine);
    procedure __TCustomActionPopupMenuDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomActionPopupMenuCloseMenu(AMachine: TatVirtualMachine);
    procedure __TCustomActionPopupMenuExpand(AMachine: TatVirtualMachine);
    procedure __TCustomActionPopupMenuPopup(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionPopupMenuExpandBtn(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionPopupMenuExpandBtn(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionPopupMenuShadow(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionPopupMenuShadow(AMachine: TatVirtualMachine);
    procedure __TCustomizeActionToolBarCreate(AMachine: TatVirtualMachine);
    procedure __TCustomizeActionToolBarItemCount(AMachine: TatVirtualMachine);
    procedure __TCustomizeActionToolBarDestroy(AMachine: TatVirtualMachine);
    procedure __GetTCustomizeActionToolBarAdditionalItem(AMachine: TatVirtualMachine);
    procedure __GetTCustomMDIMenuButtonButtonStyle(AMachine: TatVirtualMachine);
    procedure __SetTCustomMDIMenuButtonButtonStyle(AMachine: TatVirtualMachine);
    procedure __TCustomActionMainMenuBarCreate(AMachine: TatVirtualMachine);
    procedure __TCustomActionMainMenuBarDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomActionMainMenuBarCanFocus(AMachine: TatVirtualMachine);
    procedure __TCustomActionMainMenuBarCloseMenu(AMachine: TatVirtualMachine);
    procedure __TCustomActionMainMenuBarTrackMenu(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionMainMenuBarInactive(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionMainMenuBarInactive(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionMainMenuBarShadows(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionMainMenuBarShadows(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionMainMenuBarWindowMenu(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionMainMenuBarWindowMenu(AMachine: TatVirtualMachine);
    procedure __TCustomMenuItemCreate(AMachine: TatVirtualMachine);
    procedure __TCustomMenuItemCalcBounds(AMachine: TatVirtualMachine);
    procedure __TCustomMenuItemClick(AMachine: TatVirtualMachine);
    procedure __TCustomMenuItemDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomMenuItemKeyed(AMachine: TatVirtualMachine);
    procedure __TCustomMenuItemDragDrop(AMachine: TatVirtualMachine);
    procedure __GetTCustomMenuItemEdges(AMachine: TatVirtualMachine);
    procedure __SetTCustomMenuItemEdges(AMachine: TatVirtualMachine);
    procedure __TCustomMenuButtonCreate(AMachine: TatVirtualMachine);
    procedure __TCustomMenuButtonDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomMenuButtonClick(AMachine: TatVirtualMachine);
    procedure __TCustomMenuButtonKeyed(AMachine: TatVirtualMachine);
    procedure __TCustomAddRemoveItemCalcBounds(AMachine: TatVirtualMachine);
    procedure __RegisterActnBarStyle(AMachine: TatVirtualMachine);
    procedure __UnRegisterActnBarStyle(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TMenuStackClass = class of TMenuStack;
  TActionBarStyleExClass = class of TActionBarStyleEx;
  TCustomActionMenuBarClass = class of TCustomActionMenuBar;
  TCustomMenuExpandBtnClass = class of TCustomMenuExpandBtn;
  TCustomActionPopupMenuClass = class of TCustomActionPopupMenu;
  TCustomizeActionToolBarClass = class of TCustomizeActionToolBar;
  TCustomizeActionLinkClass = class of TCustomizeActionLink;
  TCustomizeActionClientItemClass = class of TCustomizeActionClientItem;
  TCustomMDIMenuButtonClass = class of TCustomMDIMenuButton;
  TCustomActionMainMenuBarClass = class of TCustomActionMainMenuBar;
  TActionMainMenuBarClass = class of TActionMainMenuBar;
  TCustomMenuItemClass = class of TCustomMenuItem;
  TCustomMenuButtonClass = class of TCustomMenuButton;
  TCustomAddRemoveItemClass = class of TCustomAddRemoveItem;

  TatActnMenusDispatcher = class(TatEventDispatcher)
  private
    procedure __TMenuPopupEvent( Sender: TObject;  Item: TCustomActionControl);
    procedure __TExitMenuEvent( Sender: TCustomActionMenuBar;  Cancelled: Boolean);
  end;


implementation



procedure TatActnMenusLibrary.__TMenuStackCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TMenuStackClass(CurrentClass.ClassRef).Create(TCustomActionMenuBar(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnMenusLibrary.__TMenuStackPush(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMenuStack(CurrentObject).Push(TCustomActionMenuBar(Integer(GetInputArg(0))));
  end;
end;

procedure TatActnMenusLibrary.__TMenuStackPop(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TMenuStack(CurrentObject).Pop);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnMenusLibrary.__TMenuStackPeek(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TMenuStack(CurrentObject).Peek);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnMenusLibrary.__TCustomActionMenuBarCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomActionMenuBarClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnMenusLibrary.__TCustomActionMenuBarDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionMenuBar(CurrentObject).Destroy;
  end;
end;

procedure TatActnMenusLibrary.__TCustomActionMenuBarCloseMenu(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionMenuBar(CurrentObject).CloseMenu;
  end;
end;

procedure TatActnMenusLibrary.__TCustomActionMenuBarRecreateControls(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionMenuBar(CurrentObject).RecreateControls;
  end;
end;

procedure TatActnMenusLibrary.__TCustomActionMenuBarStyle(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomActionMenuBar(CurrentObject).Style);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnMenusLibrary.__TCustomActionMenuBarTrackMenu(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionMenuBar(CurrentObject).TrackMenu;
  end;
end;

procedure TatActnMenusLibrary.__GetTCustomActionMenuBarAnimationStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionMenuBar(CurrentObject).AnimationStyle);
  end;
end;

procedure TatActnMenusLibrary.__SetTCustomActionMenuBarAnimationStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionMenuBar(CurrentObject).AnimationStyle:=GetInputArg(0);
  end;
end;

procedure TatActnMenusLibrary.__GetTCustomActionMenuBarAutoFocus(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionMenuBar(CurrentObject).AutoFocus);
  end;
end;

procedure TatActnMenusLibrary.__SetTCustomActionMenuBarAutoFocus(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionMenuBar(CurrentObject).AutoFocus:=GetInputArg(0);
  end;
end;

procedure TatActnMenusLibrary.__GetTCustomActionMenuBarExpandDelay(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomActionMenuBar(CurrentObject).ExpandDelay));
  end;
end;

procedure TatActnMenusLibrary.__SetTCustomActionMenuBarExpandDelay(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionMenuBar(CurrentObject).ExpandDelay:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatActnMenusLibrary.__GetTCustomActionMenuBarInMenuLoop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionMenuBar(CurrentObject).InMenuLoop);
  end;
end;

procedure TatActnMenusLibrary.__SetTCustomActionMenuBarInMenuLoop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionMenuBar(CurrentObject).InMenuLoop:=GetInputArg(0);
  end;
end;

procedure TatActnMenusLibrary.__GetTCustomActionMenuBarParentControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomActionMenuBar(CurrentObject).ParentControl));
  end;
end;

procedure TatActnMenusLibrary.__SetTCustomActionMenuBarParentControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionMenuBar(CurrentObject).ParentControl:=TCustomActionControl(Integer(GetInputArg(0)));
  end;
end;

procedure TatActnMenusLibrary.__GetTCustomActionMenuBarRootMenu(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomActionMenuBar(CurrentObject).RootMenu));
  end;
end;

procedure TatActnMenusLibrary.__SetTCustomActionMenuBarRootMenu(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionMenuBar(CurrentObject).RootMenu:=TCustomActionMenuBar(Integer(GetInputArg(0)));
  end;
end;

procedure TatActnMenusLibrary.__GetTCustomActionMenuBarUseSystemFont(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionMenuBar(CurrentObject).UseSystemFont);
  end;
end;

procedure TatActnMenusLibrary.__SetTCustomActionMenuBarUseSystemFont(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionMenuBar(CurrentObject).UseSystemFont:=GetInputArg(0);
  end;
end;

procedure TatActnMenusLibrary.__TCustomMenuExpandBtnCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomMenuExpandBtnClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnMenusLibrary.__TCustomActionPopupMenuCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomActionPopupMenuClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnMenusLibrary.__TCustomActionPopupMenuDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionPopupMenu(CurrentObject).Destroy;
  end;
end;

procedure TatActnMenusLibrary.__TCustomActionPopupMenuCloseMenu(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionPopupMenu(CurrentObject).CloseMenu;
  end;
end;

procedure TatActnMenusLibrary.__TCustomActionPopupMenuExpand(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionPopupMenu(CurrentObject).Expand(GetInputArg(0));
  end;
end;

procedure TatActnMenusLibrary.__TCustomActionPopupMenuPopup(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionPopupMenu(CurrentObject).Popup(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatActnMenusLibrary.__GetTCustomActionPopupMenuExpandBtn(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomActionPopupMenu(CurrentObject).ExpandBtn));
  end;
end;

procedure TatActnMenusLibrary.__SetTCustomActionPopupMenuExpandBtn(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionPopupMenu(CurrentObject).ExpandBtn:=TCustomMenuExpandBtn(Integer(GetInputArg(0)));
  end;
end;

procedure TatActnMenusLibrary.__GetTCustomActionPopupMenuShadow(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionPopupMenu(CurrentObject).Shadow);
  end;
end;

procedure TatActnMenusLibrary.__SetTCustomActionPopupMenuShadow(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionPopupMenu(CurrentObject).Shadow:=GetInputArg(0);
  end;
end;

procedure TatActnMenusLibrary.__TCustomizeActionToolBarCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomizeActionToolBarClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnMenusLibrary.__TCustomizeActionToolBarItemCount(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomizeActionToolBar(CurrentObject).ItemCount);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnMenusLibrary.__TCustomizeActionToolBarDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomizeActionToolBar(CurrentObject).Destroy;
  end;
end;

procedure TatActnMenusLibrary.__GetTCustomizeActionToolBarAdditionalItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomizeActionToolBar(CurrentObject).AdditionalItem));
  end;
end;

procedure TatActnMenusLibrary.__GetTCustomMDIMenuButtonButtonStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomMDIMenuButton(CurrentObject).ButtonStyle);
  end;
end;

procedure TatActnMenusLibrary.__SetTCustomMDIMenuButtonButtonStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomMDIMenuButton(CurrentObject).ButtonStyle:=GetInputArg(0);
  end;
end;

procedure TatActnMenusLibrary.__TCustomActionMainMenuBarCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomActionMainMenuBarClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnMenusLibrary.__TCustomActionMainMenuBarDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionMainMenuBar(CurrentObject).Destroy;
  end;
end;

procedure TatActnMenusLibrary.__TCustomActionMainMenuBarCanFocus(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomActionMainMenuBar(CurrentObject).CanFocus;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnMenusLibrary.__TCustomActionMainMenuBarCloseMenu(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionMainMenuBar(CurrentObject).CloseMenu;
  end;
end;

procedure TatActnMenusLibrary.__TCustomActionMainMenuBarTrackMenu(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionMainMenuBar(CurrentObject).TrackMenu;
  end;
end;

procedure TatActnMenusLibrary.__GetTCustomActionMainMenuBarInactive(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionMainMenuBar(CurrentObject).Inactive);
  end;
end;

procedure TatActnMenusLibrary.__SetTCustomActionMainMenuBarInactive(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionMainMenuBar(CurrentObject).Inactive:=GetInputArg(0);
  end;
end;

procedure TatActnMenusLibrary.__GetTCustomActionMainMenuBarShadows(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionMainMenuBar(CurrentObject).Shadows);
  end;
end;

procedure TatActnMenusLibrary.__SetTCustomActionMainMenuBarShadows(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionMainMenuBar(CurrentObject).Shadows:=GetInputArg(0);
  end;
end;

procedure TatActnMenusLibrary.__GetTCustomActionMainMenuBarWindowMenu(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionMainMenuBar(CurrentObject).WindowMenu);
  end;
end;

procedure TatActnMenusLibrary.__SetTCustomActionMainMenuBarWindowMenu(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionMainMenuBar(CurrentObject).WindowMenu:=GetInputArg(0);
  end;
end;

procedure TatActnMenusLibrary.__TCustomMenuItemCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomMenuItemClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnMenusLibrary.__TCustomMenuItemCalcBounds(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomMenuItem(CurrentObject).CalcBounds;
  end;
end;

procedure TatActnMenusLibrary.__TCustomMenuItemClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomMenuItem(CurrentObject).Click;
  end;
end;

procedure TatActnMenusLibrary.__TCustomMenuItemDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomMenuItem(CurrentObject).Destroy;
  end;
end;

procedure TatActnMenusLibrary.__TCustomMenuItemKeyed(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomMenuItem(CurrentObject).Keyed;
  end;
end;

procedure TatActnMenusLibrary.__TCustomMenuItemDragDrop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomMenuItem(CurrentObject).DragDrop(TObject(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatActnMenusLibrary.__GetTCustomMenuItemEdges(AMachine: TatVirtualMachine);
var
PropValueSet: TMenuEdges;
begin
  with AMachine do
  begin
    PropValueSet := TCustomMenuItem(CurrentObject).Edges;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatActnMenusLibrary.__SetTCustomMenuItemEdges(AMachine: TatVirtualMachine);
  var
  TempVar: TMenuEdges;
begin
  with AMachine do
  begin
    IntToSet(TempVar, VarToInteger(GetInputArg(0)), SizeOf(TempVar));
    TCustomMenuItem(CurrentObject).Edges:=TempVar;
  end;
end;

procedure TatActnMenusLibrary.__TCustomMenuButtonCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomMenuButtonClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnMenusLibrary.__TCustomMenuButtonDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomMenuButton(CurrentObject).Destroy;
  end;
end;

procedure TatActnMenusLibrary.__TCustomMenuButtonClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomMenuButton(CurrentObject).Click;
  end;
end;

procedure TatActnMenusLibrary.__TCustomMenuButtonKeyed(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomMenuButton(CurrentObject).Keyed;
  end;
end;

procedure TatActnMenusLibrary.__TCustomAddRemoveItemCalcBounds(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomAddRemoveItem(CurrentObject).CalcBounds;
  end;
end;

procedure TatActnMenusDispatcher.__TMenuPopupEvent( Sender: TObject;  Item: TCustomActionControl);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TMenuPopupEvent(BeforeCall)(Sender,Item);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Item]);
    if AssignedMethod(AfterCall) then
      TMenuPopupEvent(AfterCall)(Sender,Item);
  end;
end;

procedure TatActnMenusDispatcher.__TExitMenuEvent( Sender: TCustomActionMenuBar;  Cancelled: Boolean);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TExitMenuEvent(BeforeCall)(Sender,Cancelled);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Cancelled]);
    if AssignedMethod(AfterCall) then
      TExitMenuEvent(AfterCall)(Sender,Cancelled);
  end;
end;

procedure TatActnMenusLibrary.__RegisterActnBarStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ActnMenus.RegisterActnBarStyle(TActionBarStyleEx(Integer(GetInputArg(0))));
  end;
end;

procedure TatActnMenusLibrary.__UnRegisterActnBarStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ActnMenus.UnRegisterActnBarStyle(TActionBarStyleEx(Integer(GetInputArg(0))));
  end;
end;

procedure TatActnMenusLibrary.Init;
begin
  With Scripter.DefineClass(TMenuStack) do
  begin
    DefineMethod('Create',1,tkClass,TMenuStack,__TMenuStackCreate,true,0);
    DefineMethod('Push',1,tkNone,nil,__TMenuStackPush,false,0);
    DefineMethod('Pop',0,tkClass,TCustomActionMenuBar,__TMenuStackPop,false,0);
    DefineMethod('Peek',0,tkClass,TCustomActionMenuBar,__TMenuStackPeek,false,0);
  end;
  With Scripter.DefineClass(TActionBarStyleEx) do
  begin
  end;
  With Scripter.DefineClass(TCustomActionMenuBar) do
  begin
    DefineMethod('Create',1,tkClass,TCustomActionMenuBar,__TCustomActionMenuBarCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomActionMenuBarDestroy,false,0);
    DefineMethod('CloseMenu',0,tkNone,nil,__TCustomActionMenuBarCloseMenu,false,0);
    DefineMethod('RecreateControls',0,tkNone,nil,__TCustomActionMenuBarRecreateControls,false,0);
    DefineMethod('Style',0,tkClass,TActionBarStyle,__TCustomActionMenuBarStyle,false,0);
    DefineMethod('TrackMenu',0,tkNone,nil,__TCustomActionMenuBarTrackMenu,false,0);
    DefineProp('AnimationStyle',tkEnumeration,__GetTCustomActionMenuBarAnimationStyle,__SetTCustomActionMenuBarAnimationStyle,nil,false,0);
    DefineProp('AutoFocus',tkVariant,__GetTCustomActionMenuBarAutoFocus,__SetTCustomActionMenuBarAutoFocus,nil,false,0);
    DefineProp('ExpandDelay',tkInteger,__GetTCustomActionMenuBarExpandDelay,__SetTCustomActionMenuBarExpandDelay,nil,false,0);
    DefineProp('InMenuLoop',tkVariant,__GetTCustomActionMenuBarInMenuLoop,__SetTCustomActionMenuBarInMenuLoop,nil,false,0);
    DefineProp('ParentControl',tkClass,__GetTCustomActionMenuBarParentControl,__SetTCustomActionMenuBarParentControl,TCustomActionControl,false,0);
    DefineProp('RootMenu',tkClass,__GetTCustomActionMenuBarRootMenu,__SetTCustomActionMenuBarRootMenu,TCustomActionMenuBar,false,0);
    DefineProp('UseSystemFont',tkVariant,__GetTCustomActionMenuBarUseSystemFont,__SetTCustomActionMenuBarUseSystemFont,nil,false,0);
  end;
  With Scripter.DefineClass(TCustomMenuExpandBtn) do
  begin
    DefineMethod('Create',1,tkClass,TCustomMenuExpandBtn,__TCustomMenuExpandBtnCreate,true,0);
  end;
  With Scripter.DefineClass(TCustomActionPopupMenu) do
  begin
    DefineMethod('Create',1,tkClass,TCustomActionPopupMenu,__TCustomActionPopupMenuCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomActionPopupMenuDestroy,false,0);
    DefineMethod('CloseMenu',0,tkNone,nil,__TCustomActionPopupMenuCloseMenu,false,0);
    DefineMethod('Expand',1,tkNone,nil,__TCustomActionPopupMenuExpand,false,0);
    DefineMethod('Popup',2,tkNone,nil,__TCustomActionPopupMenuPopup,false,0);
    DefineProp('ExpandBtn',tkClass,__GetTCustomActionPopupMenuExpandBtn,__SetTCustomActionPopupMenuExpandBtn,TCustomMenuExpandBtn,false,0);
    DefineProp('Shadow',tkVariant,__GetTCustomActionPopupMenuShadow,__SetTCustomActionPopupMenuShadow,nil,false,0);
  end;
  With Scripter.DefineClass(TCustomizeActionToolBar) do
  begin
    DefineMethod('Create',1,tkClass,TCustomizeActionToolBar,__TCustomizeActionToolBarCreate,true,0);
    DefineMethod('ItemCount',0,tkInteger,nil,__TCustomizeActionToolBarItemCount,false,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomizeActionToolBarDestroy,false,0);
    DefineProp('AdditionalItem',tkClass,__GetTCustomizeActionToolBarAdditionalItem,nil,TActionClientItem,false,0);
  end;
  With Scripter.DefineClass(TCustomizeActionLink) do
  begin
  end;
  With Scripter.DefineClass(TCustomizeActionClientItem) do
  begin
  end;
  With Scripter.DefineClass(TCustomMDIMenuButton) do
  begin
    DefineProp('ButtonStyle',tkEnumeration,__GetTCustomMDIMenuButtonButtonStyle,__SetTCustomMDIMenuButtonButtonStyle,nil,false,0);
  end;
  With Scripter.DefineClass(TCustomActionMainMenuBar) do
  begin
    DefineMethod('Create',1,tkClass,TCustomActionMainMenuBar,__TCustomActionMainMenuBarCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomActionMainMenuBarDestroy,false,0);
    DefineMethod('CanFocus',0,tkVariant,nil,__TCustomActionMainMenuBarCanFocus,false,0);
    DefineMethod('CloseMenu',0,tkNone,nil,__TCustomActionMainMenuBarCloseMenu,false,0);
    DefineMethod('TrackMenu',0,tkNone,nil,__TCustomActionMainMenuBarTrackMenu,false,0);
    DefineProp('Inactive',tkVariant,__GetTCustomActionMainMenuBarInactive,__SetTCustomActionMainMenuBarInactive,nil,false,0);
    DefineProp('PersistentHotKeys',tkVariant,nil,nil,nil,false,0);
    DefineProp('Shadows',tkVariant,__GetTCustomActionMainMenuBarShadows,__SetTCustomActionMainMenuBarShadows,nil,false,0);
    DefineProp('WindowMenu',tkVariant,__GetTCustomActionMainMenuBarWindowMenu,__SetTCustomActionMainMenuBarWindowMenu,nil,false,0);
  end;
  With Scripter.DefineClass(TActionMainMenuBar) do
  begin
    DefineProp('Canvas',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TCustomMenuItem) do
  begin
    DefineMethod('Create',1,tkClass,TCustomMenuItem,__TCustomMenuItemCreate,true,0);
    DefineMethod('CalcBounds',0,tkNone,nil,__TCustomMenuItemCalcBounds,false,0);
    DefineMethod('Click',0,tkNone,nil,__TCustomMenuItemClick,false,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomMenuItemDestroy,false,0);
    DefineMethod('Keyed',0,tkNone,nil,__TCustomMenuItemKeyed,false,0);
    DefineMethod('DragDrop',3,tkNone,nil,__TCustomMenuItemDragDrop,false,0);
    DefineProp('Edges',tkInteger,__GetTCustomMenuItemEdges,__SetTCustomMenuItemEdges,nil,false,0);
  end;
  With Scripter.DefineClass(TCustomMenuButton) do
  begin
    DefineMethod('Create',1,tkClass,TCustomMenuButton,__TCustomMenuButtonCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomMenuButtonDestroy,false,0);
    DefineMethod('Click',0,tkNone,nil,__TCustomMenuButtonClick,false,0);
    DefineMethod('Keyed',0,tkNone,nil,__TCustomMenuButtonKeyed,false,0);
  end;
  With Scripter.DefineClass(TCustomAddRemoveItem) do
  begin
    DefineMethod('CalcBounds',0,tkNone,nil,__TCustomAddRemoveItemCalcBounds,false,0);
  end;
  DefineEventAdapter(TypeInfo(TMenuPopupEvent), TatActnMenusDispatcher, @TatActnMenusDispatcher.__TMenuPopupEvent);
  DefineEventAdapter(TypeInfo(TExitMenuEvent), TatActnMenusDispatcher, @TatActnMenusDispatcher.__TExitMenuEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('RegisterActnBarStyle',1,tkNone,nil,__RegisterActnBarStyle,false,0);
    DefineMethod('UnRegisterActnBarStyle',1,tkNone,nil,__UnRegisterActnBarStyle,false,0);
    AddConstant('asNone',asNone);
    AddConstant('asDefault',asDefault);
    AddConstant('asUnFold',asUnFold);
    AddConstant('asSlide',asSlide);
    AddConstant('asFade',asFade);
    AddConstant('mbMinimize',mbMinimize);
    AddConstant('mbRestore',mbRestore);
    AddConstant('mbClose',mbClose);
  end;
end;

class function TatActnMenusLibrary.LibraryName: string;
begin
  result := 'ActnMenus';
end;

initialization
  RegisterScripterLibrary(TatActnMenusLibrary, True);

{$WARNINGS ON}

end.

