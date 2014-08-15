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
unit ap_Menus;

interface

uses
  Windows,
  SysUtils,
  Classes,
  Contnrs,
  Messages,
  Graphics,
  ImgList,
  ActnList,
  Menus,
  Variants,
  ap_Messages,
  ap_Types,
  atScript;

{$WARNINGS OFF}

type
  TatMenusLibrary = class(TatScripterLibrary)
    procedure __TMenuItemEnumeratorCreate(AMachine: TatVirtualMachine);
    procedure __TMenuItemEnumeratorGetCurrent(AMachine: TatVirtualMachine);
    procedure __TMenuItemEnumeratorMoveNext(AMachine: TatVirtualMachine);
    procedure __GetTMenuItemEnumeratorCurrent(AMachine: TatVirtualMachine);
    procedure __TMenuItemCreate(AMachine: TatVirtualMachine);
    procedure __TMenuItemDestroy(AMachine: TatVirtualMachine);
    procedure __TMenuItemInitiateAction(AMachine: TatVirtualMachine);
    procedure __TMenuItemInsert(AMachine: TatVirtualMachine);
    procedure __TMenuItemDelete(AMachine: TatVirtualMachine);
    procedure __TMenuItemClear(AMachine: TatVirtualMachine);
    procedure __TMenuItemClick(AMachine: TatVirtualMachine);
    procedure __TMenuItemFind(AMachine: TatVirtualMachine);
    procedure __TMenuItemIndexOf(AMachine: TatVirtualMachine);
    procedure __TMenuItemIsLine(AMachine: TatVirtualMachine);
    procedure __TMenuItemGetEnumerator(AMachine: TatVirtualMachine);
    procedure __TMenuItemGetImageList(AMachine: TatVirtualMachine);
    procedure __TMenuItemGetParentComponent(AMachine: TatVirtualMachine);
    procedure __TMenuItemGetParentMenu(AMachine: TatVirtualMachine);
    procedure __TMenuItemHasParent(AMachine: TatVirtualMachine);
    procedure __TMenuItemNewTopLine(AMachine: TatVirtualMachine);
    procedure __TMenuItemNewBottomLine(AMachine: TatVirtualMachine);
    procedure __TMenuItemInsertNewLineBefore(AMachine: TatVirtualMachine);
    procedure __TMenuItemInsertNewLineAfter(AMachine: TatVirtualMachine);
    procedure __TMenuItemAdd(AMachine: TatVirtualMachine);
    procedure __TMenuItemRemove(AMachine: TatVirtualMachine);
    procedure __TMenuItemRethinkHotkeys(AMachine: TatVirtualMachine);
    procedure __TMenuItemRethinkLines(AMachine: TatVirtualMachine);
    procedure __TMenuItemSetParentComponent(AMachine: TatVirtualMachine);
    procedure __GetTMenuItemCommand(AMachine: TatVirtualMachine);
    procedure __GetTMenuItemHandle(AMachine: TatVirtualMachine);
    procedure __GetTMenuItemCount(AMachine: TatVirtualMachine);
    procedure __GetTMenuItemItems(AMachine: TatVirtualMachine);
    procedure __GetTMenuItemMenuIndex(AMachine: TatVirtualMachine);
    procedure __SetTMenuItemMenuIndex(AMachine: TatVirtualMachine);
    procedure __GetTMenuItemParent(AMachine: TatVirtualMachine);
    procedure __TMenuCreate(AMachine: TatVirtualMachine);
    procedure __TMenuCreateMenuItem(AMachine: TatVirtualMachine);
    procedure __TMenuDestroy(AMachine: TatVirtualMachine);
    procedure __TMenuDispatchCommand(AMachine: TatVirtualMachine);
    procedure __TMenuDispatchPopup(AMachine: TatVirtualMachine);
    procedure __TMenuFindItem(AMachine: TatVirtualMachine);
    procedure __TMenuGetHelpContext(AMachine: TatVirtualMachine);
    procedure __TMenuIsRightToLeft(AMachine: TatVirtualMachine);
    procedure __TMenuIsShortCut(AMachine: TatVirtualMachine);
    procedure __TMenuParentBiDiModeChanged(AMachine: TatVirtualMachine);
    procedure __TMenuProcessMenuChar(AMachine: TatVirtualMachine);
    procedure __GetTMenuImages(AMachine: TatVirtualMachine);
    procedure __SetTMenuImages(AMachine: TatVirtualMachine);
    procedure __GetTMenuAutoHotkeys(AMachine: TatVirtualMachine);
    procedure __SetTMenuAutoHotkeys(AMachine: TatVirtualMachine);
    procedure __GetTMenuAutoLineReduction(AMachine: TatVirtualMachine);
    procedure __SetTMenuAutoLineReduction(AMachine: TatVirtualMachine);
    procedure __GetTMenuBiDiMode(AMachine: TatVirtualMachine);
    procedure __SetTMenuBiDiMode(AMachine: TatVirtualMachine);
    procedure __GetTMenuHandle(AMachine: TatVirtualMachine);
    procedure __GetTMenuOwnerDraw(AMachine: TatVirtualMachine);
    procedure __SetTMenuOwnerDraw(AMachine: TatVirtualMachine);
    procedure __GetTMenuParentBiDiMode(AMachine: TatVirtualMachine);
    procedure __SetTMenuParentBiDiMode(AMachine: TatVirtualMachine);
    procedure __GetTMenuWindowHandle(AMachine: TatVirtualMachine);
    procedure __SetTMenuWindowHandle(AMachine: TatVirtualMachine);
    procedure __TMainMenuMerge(AMachine: TatVirtualMachine);
    procedure __TMainMenuUnmerge(AMachine: TatVirtualMachine);
    procedure __TMainMenuSetOle2MenuHandle(AMachine: TatVirtualMachine);
    procedure __TPopupMenuCreate(AMachine: TatVirtualMachine);
    procedure __TPopupMenuDestroy(AMachine: TatVirtualMachine);
    procedure __TPopupMenuCloseMenu(AMachine: TatVirtualMachine);
    procedure __TPopupMenuPopup(AMachine: TatVirtualMachine);
    procedure __GetTPopupMenuPopupComponent(AMachine: TatVirtualMachine);
    procedure __SetTPopupMenuPopupComponent(AMachine: TatVirtualMachine);
    procedure __GetTPopupMenuPopupPoint(AMachine: TatVirtualMachine);
    procedure __TPopupListAdd(AMachine: TatVirtualMachine);
    procedure __TPopupListRemove(AMachine: TatVirtualMachine);
    procedure __GetTPopupListWindow(AMachine: TatVirtualMachine);
    procedure __TMenuItemStackClearItem(AMachine: TatVirtualMachine);
    procedure __ShortCut(AMachine: TatVirtualMachine);
    procedure __ShortCutToKey(AMachine: TatVirtualMachine);
    procedure __ShortCutToText(AMachine: TatVirtualMachine);
    procedure __TextToShortCut(AMachine: TatVirtualMachine);
    procedure __ShortCutFromMessage(AMachine: TatVirtualMachine);
    procedure __NewLine(AMachine: TatVirtualMachine);
    procedure __DrawMenuItem(AMachine: TatVirtualMachine);
    procedure __StripHotkey(AMachine: TatVirtualMachine);
    procedure __GetHotkey(AMachine: TatVirtualMachine);
    procedure __SameCaption(AMachine: TatVirtualMachine);
    procedure __GetPopupList(AMachine: TatVirtualMachine);
    procedure __SetPopupList(AMachine: TatVirtualMachine);
    procedure __GetShortCutItems(AMachine: TatVirtualMachine);
    procedure __SetShortCutItems(AMachine: TatVirtualMachine);
    procedure __GetValidMenuHotkeys(AMachine: TatVirtualMachine);
    procedure __SetValidMenuHotkeys(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  EMenuErrorClass = class of EMenuError;
  TMenuActionLinkClass = class of TMenuActionLink;
  TMenuItemEnumeratorClass = class of TMenuItemEnumerator;
  TMenuItemClass = class of TMenuItem;
  TMenuClass = class of TMenu;
  TMainMenuClass = class of TMainMenu;
  TPopupMenuClass = class of TPopupMenu;
  TPopupListClass = class of TPopupList;
  TMenuItemStackClass = class of TMenuItemStack;

  TatMenusDispatcher = class(TatEventDispatcher)
  private
    procedure __TMenuChangeEvent( Sender: TObject;  Source: TMenuItem;  Rebuild: Boolean);
    procedure __TMenuMeasureItemEvent( Sender: TObject;  ACanvas: TCanvas; var Width: Integer; var Height: Integer);
  end;


implementation



procedure TatMenusLibrary.__TMenuItemEnumeratorCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TMenuItemEnumeratorClass(CurrentClass.ClassRef).Create(TMenuItem(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMenusLibrary.__TMenuItemEnumeratorGetCurrent(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TMenuItemEnumerator(CurrentObject).GetCurrent);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMenusLibrary.__TMenuItemEnumeratorMoveNext(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TMenuItemEnumerator(CurrentObject).MoveNext;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMenusLibrary.__GetTMenuItemEnumeratorCurrent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TMenuItemEnumerator(CurrentObject).Current));
  end;
end;

procedure TatMenusLibrary.__TMenuItemCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TMenuItemClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMenusLibrary.__TMenuItemDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMenuItem(CurrentObject).Destroy;
  end;
end;

procedure TatMenusLibrary.__TMenuItemInitiateAction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMenuItem(CurrentObject).InitiateAction;
  end;
end;

procedure TatMenusLibrary.__TMenuItemInsert(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMenuItem(CurrentObject).Insert(VarToInteger(GetInputArg(0)),TMenuItem(Integer(GetInputArg(1))));
  end;
end;

procedure TatMenusLibrary.__TMenuItemDelete(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMenuItem(CurrentObject).Delete(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatMenusLibrary.__TMenuItemClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMenuItem(CurrentObject).Clear;
  end;
end;

procedure TatMenusLibrary.__TMenuItemClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMenuItem(CurrentObject).Click;
  end;
end;

procedure TatMenusLibrary.__TMenuItemFind(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TMenuItem(CurrentObject).Find(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMenusLibrary.__TMenuItemIndexOf(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TMenuItem(CurrentObject).IndexOf(TMenuItem(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMenusLibrary.__TMenuItemIsLine(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TMenuItem(CurrentObject).IsLine;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMenusLibrary.__TMenuItemGetEnumerator(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TMenuItem(CurrentObject).GetEnumerator);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMenusLibrary.__TMenuItemGetImageList(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TMenuItem(CurrentObject).GetImageList);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMenusLibrary.__TMenuItemGetParentComponent(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TMenuItem(CurrentObject).GetParentComponent);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMenusLibrary.__TMenuItemGetParentMenu(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TMenuItem(CurrentObject).GetParentMenu);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMenusLibrary.__TMenuItemHasParent(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TMenuItem(CurrentObject).HasParent;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMenusLibrary.__TMenuItemNewTopLine(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TMenuItem(CurrentObject).NewTopLine);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMenusLibrary.__TMenuItemNewBottomLine(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TMenuItem(CurrentObject).NewBottomLine);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMenusLibrary.__TMenuItemInsertNewLineBefore(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TMenuItem(CurrentObject).InsertNewLineBefore(TMenuItem(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMenusLibrary.__TMenuItemInsertNewLineAfter(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TMenuItem(CurrentObject).InsertNewLineAfter(TMenuItem(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMenusLibrary.__TMenuItemAdd(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMenuItem(CurrentObject).Add(TMenuItem(Integer(GetInputArg(0))));
  end;
end;

procedure TatMenusLibrary.__TMenuItemRemove(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMenuItem(CurrentObject).Remove(TMenuItem(Integer(GetInputArg(0))));
  end;
end;

procedure TatMenusLibrary.__TMenuItemRethinkHotkeys(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TMenuItem(CurrentObject).RethinkHotkeys;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMenusLibrary.__TMenuItemRethinkLines(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TMenuItem(CurrentObject).RethinkLines;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMenusLibrary.__TMenuItemSetParentComponent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMenuItem(CurrentObject).SetParentComponent(TComponent(Integer(GetInputArg(0))));
  end;
end;

procedure TatMenusLibrary.__GetTMenuItemCommand(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TMenuItem(CurrentObject).Command));
  end;
end;

procedure TatMenusLibrary.__GetTMenuItemHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TMenuItem(CurrentObject).Handle));
  end;
end;

procedure TatMenusLibrary.__GetTMenuItemCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TMenuItem(CurrentObject).Count));
  end;
end;

procedure TatMenusLibrary.__GetTMenuItemItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TMenuItem(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatMenusLibrary.__GetTMenuItemMenuIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TMenuItem(CurrentObject).MenuIndex));
  end;
end;

procedure TatMenusLibrary.__SetTMenuItemMenuIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMenuItem(CurrentObject).MenuIndex:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatMenusLibrary.__GetTMenuItemParent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TMenuItem(CurrentObject).Parent));
  end;
end;

procedure TatMenusLibrary.__TMenuCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TMenuClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMenusLibrary.__TMenuCreateMenuItem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TMenu(CurrentObject).CreateMenuItem);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMenusLibrary.__TMenuDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMenu(CurrentObject).Destroy;
  end;
end;

procedure TatMenusLibrary.__TMenuDispatchCommand(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TMenu(CurrentObject).DispatchCommand(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMenusLibrary.__TMenuDispatchPopup(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TMenu(CurrentObject).DispatchPopup(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMenusLibrary.__TMenuFindItem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TMenu(CurrentObject).FindItem(VarToInteger(GetInputArg(0)),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMenusLibrary.__TMenuGetHelpContext(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TMenu(CurrentObject).GetHelpContext(VarToInteger(GetInputArg(0)),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMenusLibrary.__TMenuIsRightToLeft(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TMenu(CurrentObject).IsRightToLeft;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMenusLibrary.__TMenuIsShortCut(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TWMKey;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TWMKeyWrapper) then 
  Param0Rec := TWMKeyWrapper.Create(Param0);
Param0 := TWMKeyWrapper(Param0Rec).ObjToRec;
AResult := TMenu(CurrentObject).IsShortCut(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TWMKeyWrapper.Create(Param0)));
  end;
end;

procedure TatMenusLibrary.__TMenuParentBiDiModeChanged(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMenu(CurrentObject).ParentBiDiModeChanged;
  end;
end;

procedure TatMenusLibrary.__TMenuProcessMenuChar(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TWMMenuChar;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TWMMenuCharWrapper) then 
  Param0Rec := TWMMenuCharWrapper.Create(Param0);
Param0 := TWMMenuCharWrapper(Param0Rec).ObjToRec;
    TMenu(CurrentObject).ProcessMenuChar(Param0);
    SetInputArg(0,integer(TWMMenuCharWrapper.Create(Param0)));
  end;
end;

procedure TatMenusLibrary.__GetTMenuImages(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TMenu(CurrentObject).Images));
  end;
end;

procedure TatMenusLibrary.__SetTMenuImages(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMenu(CurrentObject).Images:=TCustomImageList(Integer(GetInputArg(0)));
  end;
end;

procedure TatMenusLibrary.__GetTMenuAutoHotkeys(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TMenu(CurrentObject).AutoHotkeys);
  end;
end;

procedure TatMenusLibrary.__SetTMenuAutoHotkeys(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMenu(CurrentObject).AutoHotkeys:=GetInputArg(0);
  end;
end;

procedure TatMenusLibrary.__GetTMenuAutoLineReduction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TMenu(CurrentObject).AutoLineReduction);
  end;
end;

procedure TatMenusLibrary.__SetTMenuAutoLineReduction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMenu(CurrentObject).AutoLineReduction:=GetInputArg(0);
  end;
end;

procedure TatMenusLibrary.__GetTMenuBiDiMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TMenu(CurrentObject).BiDiMode);
  end;
end;

procedure TatMenusLibrary.__SetTMenuBiDiMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMenu(CurrentObject).BiDiMode:=GetInputArg(0);
  end;
end;

procedure TatMenusLibrary.__GetTMenuHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TMenu(CurrentObject).Handle));
  end;
end;

procedure TatMenusLibrary.__GetTMenuOwnerDraw(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TMenu(CurrentObject).OwnerDraw);
  end;
end;

procedure TatMenusLibrary.__SetTMenuOwnerDraw(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMenu(CurrentObject).OwnerDraw:=GetInputArg(0);
  end;
end;

procedure TatMenusLibrary.__GetTMenuParentBiDiMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TMenu(CurrentObject).ParentBiDiMode);
  end;
end;

procedure TatMenusLibrary.__SetTMenuParentBiDiMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMenu(CurrentObject).ParentBiDiMode:=GetInputArg(0);
  end;
end;

procedure TatMenusLibrary.__GetTMenuWindowHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TMenu(CurrentObject).WindowHandle));
  end;
end;

procedure TatMenusLibrary.__SetTMenuWindowHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMenu(CurrentObject).WindowHandle:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatMenusLibrary.__TMainMenuMerge(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMainMenu(CurrentObject).Merge(TMainMenu(Integer(GetInputArg(0))));
  end;
end;

procedure TatMenusLibrary.__TMainMenuUnmerge(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMainMenu(CurrentObject).Unmerge(TMainMenu(Integer(GetInputArg(0))));
  end;
end;

procedure TatMenusLibrary.__TMainMenuSetOle2MenuHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMainMenu(CurrentObject).SetOle2MenuHandle(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatMenusLibrary.__TPopupMenuCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TPopupMenuClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMenusLibrary.__TPopupMenuDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPopupMenu(CurrentObject).Destroy;
  end;
end;

procedure TatMenusLibrary.__TPopupMenuCloseMenu(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPopupMenu(CurrentObject).CloseMenu;
  end;
end;

procedure TatMenusLibrary.__TPopupMenuPopup(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPopupMenu(CurrentObject).Popup(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatMenusLibrary.__GetTPopupMenuPopupComponent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TPopupMenu(CurrentObject).PopupComponent));
  end;
end;

procedure TatMenusLibrary.__SetTPopupMenuPopupComponent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPopupMenu(CurrentObject).PopupComponent:=TComponent(Integer(GetInputArg(0)));
  end;
end;

procedure TatMenusLibrary.__GetTPopupMenuPopupPoint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TPointWrapper.Create(TPopupMenu(CurrentObject).PopupPoint)));
  end;
end;

procedure TatMenusLibrary.__TPopupListAdd(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPopupList(CurrentObject).Add(TPopupMenu(Integer(GetInputArg(0))));
  end;
end;

procedure TatMenusLibrary.__TPopupListRemove(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPopupList(CurrentObject).Remove(TPopupMenu(Integer(GetInputArg(0))));
  end;
end;

procedure TatMenusLibrary.__GetTPopupListWindow(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TPopupList(CurrentObject).Window));
  end;
end;

procedure TatMenusLibrary.__TMenuItemStackClearItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMenuItemStack(CurrentObject).ClearItem(TMenuItem(Integer(GetInputArg(0))));
  end;
end;

procedure TatMenusDispatcher.__TMenuChangeEvent( Sender: TObject;  Source: TMenuItem;  Rebuild: Boolean);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TMenuChangeEvent(BeforeCall)(Sender,Source,Rebuild);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Source,Rebuild]);
    if AssignedMethod(AfterCall) then
      TMenuChangeEvent(AfterCall)(Sender,Source,Rebuild);
  end;
end;

procedure TatMenusDispatcher.__TMenuMeasureItemEvent( Sender: TObject;  ACanvas: TCanvas; var Width: Integer; var Height: Integer);
var
  WidthTemp: variant;
  HeightTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TMenuMeasureItemEvent(BeforeCall)(Sender,ACanvas,Width,Height);
    WidthTemp := Integer(Width);
    HeightTemp := Integer(Height);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,ACanvas,WidthTemp,HeightTemp]);
    Width := VarToInteger(WidthTemp);
    Height := VarToInteger(HeightTemp);
    if AssignedMethod(AfterCall) then
      TMenuMeasureItemEvent(AfterCall)(Sender,ACanvas,Width,Height);
  end;
end;

procedure TatMenusLibrary.__ShortCut(AMachine: TatVirtualMachine);
  var
  Param1: TShiftState;
  AResult: variant;
begin
  with AMachine do
  begin
IntToSet(Param1, VarToInteger(GetInputArg(1)), SizeOf(Param1));
AResult := Menus.ShortCut(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMenusLibrary.__ShortCutToKey(AMachine: TatVirtualMachine);
  var
  Param1: Word;
  Param2: TShiftState;
  VarParam2Set: TShiftState;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
IntToSet(Param2, VarToInteger(GetInputArg(2)), SizeOf(Param2));
VarParam2Set := Param2;
    Menus.ShortCutToKey(GetInputArg(0),Param1,Param2);
    SetInputArg(1,Integer(Param1));
    SetInputArg(2,IntFromSet(VarParam2Set, SizeOf(VarParam2Set)));
  end;
end;

procedure TatMenusLibrary.__ShortCutToText(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Menus.ShortCutToText(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMenusLibrary.__TextToShortCut(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Menus.TextToShortCut(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMenusLibrary.__ShortCutFromMessage(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Menus.ShortCutFromMessage(TWMKeyWrapper(integer(GetInputArg(0))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMenusLibrary.__NewLine(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Menus.NewLine);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMenusLibrary.__DrawMenuItem(AMachine: TatVirtualMachine);
  var
  Param3: TOwnerDrawState;
begin
  with AMachine do
  begin
IntToSet(Param3, VarToInteger(GetInputArg(3)), SizeOf(Param3));
    Menus.DrawMenuItem(TMenuItem(Integer(GetInputArg(0))),TCanvas(Integer(GetInputArg(1))),TRectWrapper(integer(GetInputArg(2))).ObjToRec,Param3);
  end;
end;

procedure TatMenusLibrary.__StripHotkey(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Menus.StripHotkey(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMenusLibrary.__GetHotkey(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Menus.GetHotkey(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMenusLibrary.__SameCaption(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Menus.SameCaption(GetInputArg(0),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatMenusLibrary.__GetPopupList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(Menus.PopupList));
  end;
end;

procedure TatMenusLibrary.__SetPopupList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Menus.PopupList:=TPopupList(Integer(GetInputArg(0)));
  end;
end;

procedure TatMenusLibrary.__GetShortCutItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(Menus.ShortCutItems));
  end;
end;

procedure TatMenusLibrary.__SetShortCutItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Menus.ShortCutItems:=TMenuItemStack(Integer(GetInputArg(0)));
  end;
end;

procedure TatMenusLibrary.__GetValidMenuHotkeys(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Menus.ValidMenuHotkeys);
  end;
end;

procedure TatMenusLibrary.__SetValidMenuHotkeys(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Menus.ValidMenuHotkeys:=GetInputArg(0);
  end;
end;

procedure TatMenusLibrary.Init;
begin
  With Scripter.DefineClass(EMenuError) do
  begin
  end;
  With Scripter.DefineClass(TMenuActionLink) do
  begin
  end;
  With Scripter.DefineClass(TMenuItemEnumerator) do
  begin
    DefineMethod('Create',1,tkClass,TMenuItemEnumerator,__TMenuItemEnumeratorCreate,true,0);
    DefineMethod('GetCurrent',0,tkClass,TMenuItem,__TMenuItemEnumeratorGetCurrent,false,0);
    DefineMethod('MoveNext',0,tkVariant,nil,__TMenuItemEnumeratorMoveNext,false,0);
    DefineProp('Current',tkClass,__GetTMenuItemEnumeratorCurrent,nil,TMenuItem,false,0);
  end;
  With Scripter.DefineClass(TMenuItem) do
  begin
    DefineMethod('Create',1,tkClass,TMenuItem,__TMenuItemCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TMenuItemDestroy,false,0);
    DefineMethod('InitiateAction',0,tkNone,nil,__TMenuItemInitiateAction,false,0);
    DefineMethod('Insert',2,tkNone,nil,__TMenuItemInsert,false,0);
    DefineMethod('Delete',1,tkNone,nil,__TMenuItemDelete,false,0);
    DefineMethod('Clear',0,tkNone,nil,__TMenuItemClear,false,0);
    DefineMethod('Click',0,tkNone,nil,__TMenuItemClick,false,0);
    DefineMethod('Find',1,tkClass,TMenuItem,__TMenuItemFind,false,0);
    DefineMethod('IndexOf',1,tkInteger,nil,__TMenuItemIndexOf,false,0);
    DefineMethod('IsLine',0,tkVariant,nil,__TMenuItemIsLine,false,0);
    DefineMethod('GetEnumerator',0,tkClass,TMenuItemEnumerator,__TMenuItemGetEnumerator,false,0);
    DefineMethod('GetImageList',0,tkClass,TCustomImageList,__TMenuItemGetImageList,false,0);
    DefineMethod('GetParentComponent',0,tkClass,TComponent,__TMenuItemGetParentComponent,false,0);
    DefineMethod('GetParentMenu',0,tkClass,TMenu,__TMenuItemGetParentMenu,false,0);
    DefineMethod('HasParent',0,tkVariant,nil,__TMenuItemHasParent,false,0);
    DefineMethod('NewTopLine',0,tkInteger,nil,__TMenuItemNewTopLine,false,0);
    DefineMethod('NewBottomLine',0,tkInteger,nil,__TMenuItemNewBottomLine,false,0);
    DefineMethod('InsertNewLineBefore',1,tkInteger,nil,__TMenuItemInsertNewLineBefore,false,0);
    DefineMethod('InsertNewLineAfter',1,tkInteger,nil,__TMenuItemInsertNewLineAfter,false,0);
    DefineMethod('Add',1,tkNone,nil,__TMenuItemAdd,false,0);
    DefineMethod('Remove',1,tkNone,nil,__TMenuItemRemove,false,0);
    DefineMethod('RethinkHotkeys',0,tkVariant,nil,__TMenuItemRethinkHotkeys,false,0);
    DefineMethod('RethinkLines',0,tkVariant,nil,__TMenuItemRethinkLines,false,0);
    DefineMethod('SetParentComponent',1,tkNone,nil,__TMenuItemSetParentComponent,false,0);
    DefineProp('Command',tkInteger,__GetTMenuItemCommand,nil,nil,false,0);
    DefineProp('Handle',tkInteger,__GetTMenuItemHandle,nil,nil,false,0);
    DefineProp('Count',tkInteger,__GetTMenuItemCount,nil,nil,false,0);
    DefaultProperty := DefineProp('Items',tkClass,__GetTMenuItemItems,nil,TMenuItem,false,1);
    DefineProp('MenuIndex',tkInteger,__GetTMenuItemMenuIndex,__SetTMenuItemMenuIndex,nil,false,0);
    DefineProp('Parent',tkClass,__GetTMenuItemParent,nil,TMenuItem,false,0);
  end;
  With Scripter.DefineClass(TMenu) do
  begin
    DefineMethod('Create',1,tkClass,TMenu,__TMenuCreate,true,0);
    DefineMethod('CreateMenuItem',0,tkClass,TMenuItem,__TMenuCreateMenuItem,false,0);
    DefineMethod('Destroy',0,tkNone,nil,__TMenuDestroy,false,0);
    DefineMethod('DispatchCommand',1,tkVariant,nil,__TMenuDispatchCommand,false,0);
    DefineMethod('DispatchPopup',1,tkVariant,nil,__TMenuDispatchPopup,false,0);
    DefineMethod('FindItem',2,tkClass,TMenuItem,__TMenuFindItem,false,0);
    DefineMethod('GetHelpContext',2,tkEnumeration,nil,__TMenuGetHelpContext,false,0);
    DefineMethod('IsRightToLeft',0,tkVariant,nil,__TMenuIsRightToLeft,false,0);
    DefineMethod('IsShortCut',1,tkVariant,nil,__TMenuIsShortCut,false,0).SetVarArgs([0]);
    DefineMethod('ParentBiDiModeChanged',0,tkNone,nil,__TMenuParentBiDiModeChanged,false,0);
    DefineMethod('ProcessMenuChar',1,tkNone,nil,__TMenuProcessMenuChar,false,0).SetVarArgs([0]);
    DefineProp('Images',tkClass,__GetTMenuImages,__SetTMenuImages,TCustomImageList,false,0);
    DefineProp('AutoHotkeys',tkEnumeration,__GetTMenuAutoHotkeys,__SetTMenuAutoHotkeys,nil,false,0);
    DefineProp('AutoLineReduction',tkEnumeration,__GetTMenuAutoLineReduction,__SetTMenuAutoLineReduction,nil,false,0);
    DefineProp('BiDiMode',tkEnumeration,__GetTMenuBiDiMode,__SetTMenuBiDiMode,nil,false,0);
    DefineProp('Handle',tkInteger,__GetTMenuHandle,nil,nil,false,0);
    DefineProp('OwnerDraw',tkVariant,__GetTMenuOwnerDraw,__SetTMenuOwnerDraw,nil,false,0);
    DefineProp('ParentBiDiMode',tkVariant,__GetTMenuParentBiDiMode,__SetTMenuParentBiDiMode,nil,false,0);
    DefineProp('WindowHandle',tkInteger,__GetTMenuWindowHandle,__SetTMenuWindowHandle,nil,false,0);
  end;
  With Scripter.DefineClass(TMainMenu) do
  begin
    DefineMethod('Merge',1,tkNone,nil,__TMainMenuMerge,false,0);
    DefineMethod('Unmerge',1,tkNone,nil,__TMainMenuUnmerge,false,0);
    DefineMethod('SetOle2MenuHandle',1,tkNone,nil,__TMainMenuSetOle2MenuHandle,false,0);
  end;
  With Scripter.DefineClass(TPopupMenu) do
  begin
    DefineMethod('Create',1,tkClass,TPopupMenu,__TPopupMenuCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TPopupMenuDestroy,false,0);
    DefineMethod('CloseMenu',0,tkNone,nil,__TPopupMenuCloseMenu,false,0);
    DefineMethod('Popup',2,tkNone,nil,__TPopupMenuPopup,false,0);
    DefineProp('PopupComponent',tkClass,__GetTPopupMenuPopupComponent,__SetTPopupMenuPopupComponent,TComponent,false,0);
    DefineProp('PopupPoint',tkVariant,__GetTPopupMenuPopupPoint,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TPopupList) do
  begin
    DefineMethod('Add',1,tkNone,nil,__TPopupListAdd,false,0);
    DefineMethod('Remove',1,tkNone,nil,__TPopupListRemove,false,0);
    DefineProp('Window',tkInteger,__GetTPopupListWindow,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TMenuItemStack) do
  begin
    DefineMethod('ClearItem',1,tkNone,nil,__TMenuItemStackClearItem,false,0);
  end;
  DefineEventAdapter(TypeInfo(TMenuChangeEvent), TatMenusDispatcher, @TatMenusDispatcher.__TMenuChangeEvent);
  DefineEventAdapter(TypeInfo(TMenuMeasureItemEvent), TatMenusDispatcher, @TatMenusDispatcher.__TMenuMeasureItemEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('ShortCut',2,tkEnumeration,nil,__ShortCut,false,0);
    DefineMethod('ShortCutToKey',3,tkNone,nil,__ShortCutToKey,false,0).SetVarArgs([1,2]);
    DefineMethod('ShortCutToText',1,tkVariant,nil,__ShortCutToText,false,0);
    DefineMethod('TextToShortCut',1,tkEnumeration,nil,__TextToShortCut,false,0);
    DefineMethod('ShortCutFromMessage',1,tkEnumeration,nil,__ShortCutFromMessage,false,0);
    DefineMethod('NewLine',0,tkClass,TMenuItem,__NewLine,false,0);
    DefineMethod('DrawMenuItem',4,tkNone,nil,__DrawMenuItem,false,0);
    DefineMethod('StripHotkey',1,tkVariant,nil,__StripHotkey,false,0);
    DefineMethod('GetHotkey',1,tkVariant,nil,__GetHotkey,false,0);
    DefineMethod('SameCaption',2,tkVariant,nil,__SameCaption,false,0);
    DefineProp('PopupList',tkClass,__GetPopupList,__SetPopupList,TPopupList,false,0);
    DefineProp('ShortCutItems',tkClass,__GetShortCutItems,__SetShortCutItems,TMenuItemStack,false,0);
    DefineProp('ValidMenuHotkeys',tkVariant,__GetValidMenuHotkeys,__SetValidMenuHotkeys,nil,false,0);
    AddConstant('mbNone',mbNone);
    AddConstant('mbBreak',mbBreak);
    AddConstant('mbBarBreak',mbBarBreak);
    AddConstant('maAutomatic',maAutomatic);
    AddConstant('maManual',maManual);
    AddConstant('maParent',maParent);
    AddConstant('fkCommand',fkCommand);
    AddConstant('fkHandle',fkHandle);
    AddConstant('fkShortCut',fkShortCut);
    AddConstant('paLeft',paLeft);
    AddConstant('paRight',paRight);
    AddConstant('paCenter',paCenter);
    AddConstant('tbRightButton',tbRightButton);
    AddConstant('tbLeftButton',tbLeftButton);
    AddConstant('maLeftToRight',maLeftToRight);
    AddConstant('maRightToLeft',maRightToLeft);
    AddConstant('maTopToBottom',maTopToBottom);
    AddConstant('maBottomToTop',maBottomToTop);
    AddConstant('maNone',maNone);
    AddConstant('cHotkeyPrefix',cHotkeyPrefix);
    AddConstant('cLineCaption',cLineCaption);
    AddConstant('cDialogSuffix',cDialogSuffix);
  end;
end;

class function TatMenusLibrary.LibraryName: string;
begin
  result := 'Menus';
end;

initialization
  RegisterScripterLibrary(TatMenusLibrary, True);

{$WARNINGS ON}

end.

