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
unit ap_ScreenTips;

interface

uses
  Classes,
  ActnMan,
  ActnList,
  Windows,
  Graphics,
  ExtCtrls,
  AppEvnts,
  Forms,
  Types,
  SysUtils,
  Controls,
  Contnrs,
  Messages,
  ScreenTips,
  Variants,
  ap_Types,
  atScript;

{$WARNINGS OFF}

type
  TatScreenTipsLibrary = class(TatScripterLibrary)
    procedure __TScreenTipsWindowCreate(AMachine: TatVirtualMachine);
    procedure __TScreenTipsWindowDestroy(AMachine: TatVirtualMachine);
    procedure __TScreenTipsWindowActivateToolTip(AMachine: TatVirtualMachine);
    procedure __TScreenTipsWindowHideHint(AMachine: TatVirtualMachine);
    procedure __GetTScreenTipsWindowHintControl(AMachine: TatVirtualMachine);
    procedure __SetTScreenTipsWindowHintControl(AMachine: TatVirtualMachine);
    procedure __GetTScreenTipsWindowImage(AMachine: TatVirtualMachine);
    procedure __SetTScreenTipsWindowImage(AMachine: TatVirtualMachine);
    procedure __GetTScreenTipsWindowGradientStartColor(AMachine: TatVirtualMachine);
    procedure __SetTScreenTipsWindowGradientStartColor(AMachine: TatVirtualMachine);
    procedure __GetTScreenTipsWindowGradientEndColor(AMachine: TatVirtualMachine);
    procedure __SetTScreenTipsWindowGradientEndColor(AMachine: TatVirtualMachine);
    procedure __GetTScreenTipsWindowBody(AMachine: TatVirtualMachine);
    procedure __SetTScreenTipsWindowBody(AMachine: TatVirtualMachine);
    procedure __GetTScreenTipsWindowFooter(AMachine: TatVirtualMachine);
    procedure __SetTScreenTipsWindowFooter(AMachine: TatVirtualMachine);
    procedure __GetTScreenTipsWindowFooterImage(AMachine: TatVirtualMachine);
    procedure __SetTScreenTipsWindowFooterImage(AMachine: TatVirtualMachine);
    procedure __GetTScreenTipsWindowActiveItem(AMachine: TatVirtualMachine);
    procedure __GetTScreenTipsWindowTipBorderStyle(AMachine: TatVirtualMachine);
    procedure __SetTScreenTipsWindowTipBorderStyle(AMachine: TatVirtualMachine);
    procedure __GetTScreenTipsWindowCornerSize(AMachine: TatVirtualMachine);
    procedure __SetTScreenTipsWindowCornerSize(AMachine: TatVirtualMachine);
    procedure __TScreenTipItemCreate(AMachine: TatVirtualMachine);
    procedure __TScreenTipItemDestroy(AMachine: TatVirtualMachine);
    procedure __TScreenTipItemAssign(AMachine: TatVirtualMachine);
    procedure __TScreenTipItemSetManager(AMachine: TatVirtualMachine);
    procedure __TScreenTipItemIsEnabled(AMachine: TatVirtualMachine);
    procedure __GetTScreenTipItemHeight(AMachine: TatVirtualMachine);
    procedure __SetTScreenTipItemHeight(AMachine: TatVirtualMachine);
    procedure __GetTScreenTipItemWidth(AMachine: TatVirtualMachine);
    procedure __SetTScreenTipItemWidth(AMachine: TatVirtualMachine);
    procedure __TScreenTipsCollectionCreate(AMachine: TatVirtualMachine);
    procedure __TScreenTipsCollectionAdd(AMachine: TatVirtualMachine);
    procedure __TScreenTipsCollectionInsert(AMachine: TatVirtualMachine);
    procedure __GetTScreenTipsCollectionItems(AMachine: TatVirtualMachine);
    procedure __SetTScreenTipsCollectionItems(AMachine: TatVirtualMachine);
    procedure __TScreenTipBorderStyleCreate(AMachine: TatVirtualMachine);
    procedure __TDisplayOffsetCreate(AMachine: TatVirtualMachine);
    procedure __TAllocatedActionsCreate(AMachine: TatVirtualMachine);
    procedure __TAllocatedActionsDestroy(AMachine: TatVirtualMachine);
    procedure __TAllocatedActionsAddAction(AMachine: TatVirtualMachine);
    procedure __TAllocatedActionsClear(AMachine: TatVirtualMachine);
    procedure __TAllocatedActionsDelete(AMachine: TatVirtualMachine);
    procedure __TAllocatedActionsExists(AMachine: TatVirtualMachine);
    procedure __TAllocatedActionsFind(AMachine: TatVirtualMachine);
    procedure __TAllocatedActionsGetItem(AMachine: TatVirtualMachine);
    procedure __GetTAllocatedActionsCount(AMachine: TatVirtualMachine);
    procedure __TAssociateItemCreate(AMachine: TatVirtualMachine);
    procedure __TAssociateItemDestroy(AMachine: TatVirtualMachine);
    procedure __GetTAssociateItemPopupTip(AMachine: TatVirtualMachine);
    procedure __SetTAssociateItemPopupTip(AMachine: TatVirtualMachine);
    procedure __GetTAssociateItemAssociate(AMachine: TatVirtualMachine);
    procedure __SetTAssociateItemAssociate(AMachine: TatVirtualMachine);
    procedure __TAssociateItemListCreate(AMachine: TatVirtualMachine);
    procedure __TAssociateItemListDestroy(AMachine: TatVirtualMachine);
    procedure __TAssociateItemListAdd(AMachine: TatVirtualMachine);
    procedure __TAssociateItemListRemove(AMachine: TatVirtualMachine);
    procedure __TAssociateItemListFind(AMachine: TatVirtualMachine);
    procedure __TAssociateItemListGet(AMachine: TatVirtualMachine);
    procedure __TCustomScreenTipsManagerCreate(AMachine: TatVirtualMachine);
    procedure __TCustomScreenTipsManagerDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomScreenTipsManagerAddPopup(AMachine: TatVirtualMachine);
    procedure __TCustomScreenTipsManagerClearScreenTips(AMachine: TatVirtualMachine);
    procedure __TCustomScreenTipsManagerCreateScreenTip(AMachine: TatVirtualMachine);
    procedure __TCustomScreenTipsManagerGenerateScreenTips(AMachine: TatVirtualMachine);
    procedure __TCustomScreenTipsManagerGetScreenTip(AMachine: TatVirtualMachine);
    procedure __TCustomScreenTipsManagerRemovePopup(AMachine: TatVirtualMachine);
    procedure __TCustomScreenTipsManagerRemoveScreenTip(AMachine: TatVirtualMachine);
    procedure __TCustomScreenTipsManagerUpdateOptions(AMachine: TatVirtualMachine);
    procedure __GetTCustomScreenTipsManagerBorderStyle(AMachine: TatVirtualMachine);
    procedure __SetTCustomScreenTipsManagerBorderStyle(AMachine: TatVirtualMachine);
    procedure __GetTCustomScreenTipsManagerDisplayOffset(AMachine: TatVirtualMachine);
    procedure __SetTCustomScreenTipsManagerDisplayOffset(AMachine: TatVirtualMachine);
    procedure __GetTCustomScreenTipsManagerFont(AMachine: TatVirtualMachine);
    procedure __SetTCustomScreenTipsManagerFont(AMachine: TatVirtualMachine);
    procedure __GetTCustomScreenTipsManagerFooter(AMachine: TatVirtualMachine);
    procedure __SetTCustomScreenTipsManagerFooter(AMachine: TatVirtualMachine);
    procedure __GetTCustomScreenTipsManagerFooterImage(AMachine: TatVirtualMachine);
    procedure __SetTCustomScreenTipsManagerFooterImage(AMachine: TatVirtualMachine);
    procedure __GetTCustomScreenTipsManagerGradientEndColor(AMachine: TatVirtualMachine);
    procedure __SetTCustomScreenTipsManagerGradientEndColor(AMachine: TatVirtualMachine);
    procedure __GetTCustomScreenTipsManagerGradientStartColor(AMachine: TatVirtualMachine);
    procedure __SetTCustomScreenTipsManagerGradientStartColor(AMachine: TatVirtualMachine);
    procedure __GetTCustomScreenTipsManagerLinkedActionLists(AMachine: TatVirtualMachine);
    procedure __SetTCustomScreenTipsManagerLinkedActionLists(AMachine: TatVirtualMachine);
    procedure __GetTCustomScreenTipsManagerOptions(AMachine: TatVirtualMachine);
    procedure __SetTCustomScreenTipsManagerOptions(AMachine: TatVirtualMachine);
    procedure __GetTCustomScreenTipsManagerScreenTips(AMachine: TatVirtualMachine);
    procedure __SetTCustomScreenTipsManagerScreenTips(AMachine: TatVirtualMachine);
    procedure __TCustomScreenTipsPopupCreate(AMachine: TatVirtualMachine);
    procedure __TCustomScreenTipsPopupDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomScreenTipsPopupGetScreenTipItem(AMachine: TatVirtualMachine);
    procedure __GetTCustomScreenTipsPopupAssociate(AMachine: TatVirtualMachine);
    procedure __SetTCustomScreenTipsPopupAssociate(AMachine: TatVirtualMachine);
    procedure __GetTCustomScreenTipsPopupGlyph(AMachine: TatVirtualMachine);
    procedure __SetTCustomScreenTipsPopupGlyph(AMachine: TatVirtualMachine);
    procedure __GetTCustomScreenTipsPopupPopupType(AMachine: TatVirtualMachine);
    procedure __SetTCustomScreenTipsPopupPopupType(AMachine: TatVirtualMachine);
    procedure __GetTCustomScreenTipsPopupScreenTip(AMachine: TatVirtualMachine);
    procedure __SetTCustomScreenTipsPopupScreenTip(AMachine: TatVirtualMachine);
    procedure __GetTCustomScreenTipsPopupScreenTipManager(AMachine: TatVirtualMachine);
    procedure __SetTCustomScreenTipsPopupScreenTipManager(AMachine: TatVirtualMachine);
    procedure __GetTCustomScreenTipsPopupTransparent(AMachine: TatVirtualMachine);
    procedure __SetTCustomScreenTipsPopupTransparent(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TScreenTipsWindowClass = class of TScreenTipsWindow;
  TScreenTipItemClass = class of TScreenTipItem;
  TScreenTipsCollectionClass = class of TScreenTipsCollection;
  TScreenTipBorderStyleClass = class of TScreenTipBorderStyle;
  TDisplayOffsetClass = class of TDisplayOffset;
  EAllocatedActionsExceptionClass = class of EAllocatedActionsException;
  TAllocatedActionsClass = class of TAllocatedActions;
  TAssociateItemClass = class of TAssociateItem;
  TAssociateItemListClass = class of TAssociateItemList;
  TCustomScreenTipsManagerClass = class of TCustomScreenTipsManager;
  TScreenTipsManagerClass = class of TScreenTipsManager;
  TCustomScreenTipsPopupClass = class of TCustomScreenTipsPopup;
  TScreenTipsPopupClass = class of TScreenTipsPopup;

  TatScreenTipsDispatcher = class(TatEventDispatcher)
  private
    procedure __TShowScreenTipEvent( Manager: TObject;  Action: TBasicAction; var ShowScreenTip: Boolean);
    procedure __TCreateScreenTipEvent( Manager: TObject;  Item: TScreenTipItem);
    procedure __TDuplicateCreateErrorEvent( Manager: TObject;  Action: TBasicAction);
  end;


implementation



procedure TatScreenTipsLibrary.__TScreenTipsWindowCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TScreenTipsWindowClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScreenTipsLibrary.__TScreenTipsWindowDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScreenTipsWindow(CurrentObject).Destroy;
  end;
end;

procedure TatScreenTipsLibrary.__TScreenTipsWindowActivateToolTip(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScreenTipsWindow(CurrentObject).ActivateToolTip(TRectWrapper(integer(GetInputArg(0))).ObjToRec,TScreenTipItem(Integer(GetInputArg(1))));
  end;
end;

procedure TatScreenTipsLibrary.__TScreenTipsWindowHideHint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScreenTipsWindow(CurrentObject).HideHint;
  end;
end;

procedure TatScreenTipsLibrary.__GetTScreenTipsWindowHintControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreenTipsWindow(CurrentObject).HintControl));
  end;
end;

procedure TatScreenTipsLibrary.__SetTScreenTipsWindowHintControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScreenTipsWindow(CurrentObject).HintControl:=TControl(Integer(GetInputArg(0)));
  end;
end;

procedure TatScreenTipsLibrary.__GetTScreenTipsWindowImage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreenTipsWindow(CurrentObject).Image));
  end;
end;

procedure TatScreenTipsLibrary.__SetTScreenTipsWindowImage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScreenTipsWindow(CurrentObject).Image:=TPicture(Integer(GetInputArg(0)));
  end;
end;

procedure TatScreenTipsLibrary.__GetTScreenTipsWindowGradientStartColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TScreenTipsWindow(CurrentObject).GradientStartColor);
  end;
end;

procedure TatScreenTipsLibrary.__SetTScreenTipsWindowGradientStartColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScreenTipsWindow(CurrentObject).GradientStartColor:=GetInputArg(0);
  end;
end;

procedure TatScreenTipsLibrary.__GetTScreenTipsWindowGradientEndColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TScreenTipsWindow(CurrentObject).GradientEndColor);
  end;
end;

procedure TatScreenTipsLibrary.__SetTScreenTipsWindowGradientEndColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScreenTipsWindow(CurrentObject).GradientEndColor:=GetInputArg(0);
  end;
end;

procedure TatScreenTipsLibrary.__GetTScreenTipsWindowBody(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TScreenTipsWindow(CurrentObject).Body);
  end;
end;

procedure TatScreenTipsLibrary.__SetTScreenTipsWindowBody(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScreenTipsWindow(CurrentObject).Body:=GetInputArg(0);
  end;
end;

procedure TatScreenTipsLibrary.__GetTScreenTipsWindowFooter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TScreenTipsWindow(CurrentObject).Footer);
  end;
end;

procedure TatScreenTipsLibrary.__SetTScreenTipsWindowFooter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScreenTipsWindow(CurrentObject).Footer:=GetInputArg(0);
  end;
end;

procedure TatScreenTipsLibrary.__GetTScreenTipsWindowFooterImage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreenTipsWindow(CurrentObject).FooterImage));
  end;
end;

procedure TatScreenTipsLibrary.__SetTScreenTipsWindowFooterImage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScreenTipsWindow(CurrentObject).FooterImage:=TBitmap(Integer(GetInputArg(0)));
  end;
end;

procedure TatScreenTipsLibrary.__GetTScreenTipsWindowActiveItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreenTipsWindow(CurrentObject).ActiveItem));
  end;
end;

procedure TatScreenTipsLibrary.__GetTScreenTipsWindowTipBorderStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TScreenTipsWindow(CurrentObject).TipBorderStyle);
  end;
end;

procedure TatScreenTipsLibrary.__SetTScreenTipsWindowTipBorderStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScreenTipsWindow(CurrentObject).TipBorderStyle:=GetInputArg(0);
  end;
end;

procedure TatScreenTipsLibrary.__GetTScreenTipsWindowCornerSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreenTipsWindow(CurrentObject).CornerSize));
  end;
end;

procedure TatScreenTipsLibrary.__SetTScreenTipsWindowCornerSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScreenTipsWindow(CurrentObject).CornerSize:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatScreenTipsLibrary.__TScreenTipItemCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TScreenTipItemClass(CurrentClass.ClassRef).Create(TCollection(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScreenTipsLibrary.__TScreenTipItemDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScreenTipItem(CurrentObject).Destroy;
  end;
end;

procedure TatScreenTipsLibrary.__TScreenTipItemAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScreenTipItem(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatScreenTipsLibrary.__TScreenTipItemSetManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScreenTipItem(CurrentObject).SetManager(TCustomScreenTipsManager(Integer(GetInputArg(0))));
  end;
end;

procedure TatScreenTipsLibrary.__TScreenTipItemIsEnabled(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TScreenTipItem(CurrentObject).IsEnabled;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScreenTipsLibrary.__GetTScreenTipItemHeight(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreenTipItem(CurrentObject).Height));
  end;
end;

procedure TatScreenTipsLibrary.__SetTScreenTipItemHeight(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScreenTipItem(CurrentObject).Height:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatScreenTipsLibrary.__GetTScreenTipItemWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreenTipItem(CurrentObject).Width));
  end;
end;

procedure TatScreenTipsLibrary.__SetTScreenTipItemWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScreenTipItem(CurrentObject).Width:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatScreenTipsLibrary.__TScreenTipsCollectionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TScreenTipsCollectionClass(CurrentClass.ClassRef).Create(TCustomScreenTipsManager(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScreenTipsLibrary.__TScreenTipsCollectionAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TScreenTipsCollection(CurrentObject).Add);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScreenTipsLibrary.__TScreenTipsCollectionInsert(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TScreenTipsCollection(CurrentObject).Insert(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScreenTipsLibrary.__GetTScreenTipsCollectionItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TScreenTipsCollection(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatScreenTipsLibrary.__SetTScreenTipsCollectionItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TScreenTipsCollection(CurrentObject).Items[VarToInteger(GetArrayIndex(0))]:=TScreenTipItem(Integer(GetInputArg(0)));
  end;
end;

procedure TatScreenTipsLibrary.__TScreenTipBorderStyleCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TScreenTipBorderStyleClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScreenTipsLibrary.__TDisplayOffsetCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDisplayOffsetClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScreenTipsLibrary.__TAllocatedActionsCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TAllocatedActionsClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScreenTipsLibrary.__TAllocatedActionsDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAllocatedActions(CurrentObject).Destroy;
  end;
end;

procedure TatScreenTipsLibrary.__TAllocatedActionsAddAction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAllocatedActions(CurrentObject).AddAction(GetInputArg(0),TObject(integer(GetInputArg(1))));
  end;
end;

procedure TatScreenTipsLibrary.__TAllocatedActionsClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAllocatedActions(CurrentObject).Clear;
  end;
end;

procedure TatScreenTipsLibrary.__TAllocatedActionsDelete(AMachine: TatVirtualMachine);
  var
  Param1: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := TAllocatedActions(CurrentObject).Delete(GetInputArg(0),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatScreenTipsLibrary.__TAllocatedActionsExists(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TAllocatedActions(CurrentObject).Exists(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScreenTipsLibrary.__TAllocatedActionsFind(AMachine: TatVirtualMachine);
  var
  Param1: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := TAllocatedActions(CurrentObject).Find(GetInputArg(0),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatScreenTipsLibrary.__TAllocatedActionsGetItem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TAllocatedActions(CurrentObject).GetItem(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScreenTipsLibrary.__GetTAllocatedActionsCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TAllocatedActions(CurrentObject).Count));
  end;
end;

procedure TatScreenTipsLibrary.__TAssociateItemCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TAssociateItemClass(CurrentClass.ClassRef).Create(TControl(Integer(GetInputArg(0))),TControl(Integer(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScreenTipsLibrary.__TAssociateItemDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAssociateItem(CurrentObject).Destroy;
  end;
end;

procedure TatScreenTipsLibrary.__GetTAssociateItemPopupTip(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TAssociateItem(CurrentObject).PopupTip));
  end;
end;

procedure TatScreenTipsLibrary.__SetTAssociateItemPopupTip(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAssociateItem(CurrentObject).PopupTip:=TControl(Integer(GetInputArg(0)));
  end;
end;

procedure TatScreenTipsLibrary.__GetTAssociateItemAssociate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TAssociateItem(CurrentObject).Associate));
  end;
end;

procedure TatScreenTipsLibrary.__SetTAssociateItemAssociate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAssociateItem(CurrentObject).Associate:=TControl(Integer(GetInputArg(0)));
  end;
end;

procedure TatScreenTipsLibrary.__TAssociateItemListCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TAssociateItemListClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScreenTipsLibrary.__TAssociateItemListDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAssociateItemList(CurrentObject).Destroy;
  end;
end;

procedure TatScreenTipsLibrary.__TAssociateItemListAdd(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAssociateItemList(CurrentObject).Add(TControl(Integer(GetInputArg(0))),TControl(Integer(GetInputArg(1))));
  end;
end;

procedure TatScreenTipsLibrary.__TAssociateItemListRemove(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAssociateItemList(CurrentObject).Remove(TControl(Integer(GetInputArg(0))));
  end;
end;

procedure TatScreenTipsLibrary.__TAssociateItemListFind(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TAssociateItemList(CurrentObject).Find(TControl(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScreenTipsLibrary.__TAssociateItemListGet(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TAssociateItemList(CurrentObject).Get(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScreenTipsLibrary.__TCustomScreenTipsManagerCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomScreenTipsManagerClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScreenTipsLibrary.__TCustomScreenTipsManagerDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomScreenTipsManager(CurrentObject).Destroy;
  end;
end;

procedure TatScreenTipsLibrary.__TCustomScreenTipsManagerAddPopup(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomScreenTipsManager(CurrentObject).AddPopup(TCustomControl(Integer(GetInputArg(0))));
  end;
end;

procedure TatScreenTipsLibrary.__TCustomScreenTipsManagerClearScreenTips(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomScreenTipsManager(CurrentObject).ClearScreenTips;
  end;
end;

procedure TatScreenTipsLibrary.__TCustomScreenTipsManagerCreateScreenTip(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomScreenTipsManager(CurrentObject).CreateScreenTip(TBasicAction(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScreenTipsLibrary.__TCustomScreenTipsManagerGenerateScreenTips(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomScreenTipsManager(CurrentObject).GenerateScreenTips;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScreenTipsLibrary.__TCustomScreenTipsManagerGetScreenTip(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomScreenTipsManager(CurrentObject).GetScreenTip(TBasicAction(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScreenTipsLibrary.__TCustomScreenTipsManagerRemovePopup(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomScreenTipsManager(CurrentObject).RemovePopup(TCustomControl(Integer(GetInputArg(0))));
  end;
end;

procedure TatScreenTipsLibrary.__TCustomScreenTipsManagerRemoveScreenTip(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TCustomScreenTipsManager(CurrentObject).RemoveScreenTip(TScreenTipItem(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScreenTipsLibrary.__TCustomScreenTipsManagerUpdateOptions(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomScreenTipsManager(CurrentObject).UpdateOptions;
  end;
end;

procedure TatScreenTipsLibrary.__GetTCustomScreenTipsManagerBorderStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomScreenTipsManager(CurrentObject).BorderStyle));
  end;
end;

procedure TatScreenTipsLibrary.__SetTCustomScreenTipsManagerBorderStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomScreenTipsManager(CurrentObject).BorderStyle:=TScreenTipBorderStyle(Integer(GetInputArg(0)));
  end;
end;

procedure TatScreenTipsLibrary.__GetTCustomScreenTipsManagerDisplayOffset(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomScreenTipsManager(CurrentObject).DisplayOffset));
  end;
end;

procedure TatScreenTipsLibrary.__SetTCustomScreenTipsManagerDisplayOffset(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomScreenTipsManager(CurrentObject).DisplayOffset:=TDisplayOffset(Integer(GetInputArg(0)));
  end;
end;

procedure TatScreenTipsLibrary.__GetTCustomScreenTipsManagerFont(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomScreenTipsManager(CurrentObject).Font));
  end;
end;

procedure TatScreenTipsLibrary.__SetTCustomScreenTipsManagerFont(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomScreenTipsManager(CurrentObject).Font:=TFont(Integer(GetInputArg(0)));
  end;
end;

procedure TatScreenTipsLibrary.__GetTCustomScreenTipsManagerFooter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomScreenTipsManager(CurrentObject).Footer);
  end;
end;

procedure TatScreenTipsLibrary.__SetTCustomScreenTipsManagerFooter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomScreenTipsManager(CurrentObject).Footer:=GetInputArg(0);
  end;
end;

procedure TatScreenTipsLibrary.__GetTCustomScreenTipsManagerFooterImage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomScreenTipsManager(CurrentObject).FooterImage));
  end;
end;

procedure TatScreenTipsLibrary.__SetTCustomScreenTipsManagerFooterImage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomScreenTipsManager(CurrentObject).FooterImage:=TPicture(Integer(GetInputArg(0)));
  end;
end;

procedure TatScreenTipsLibrary.__GetTCustomScreenTipsManagerGradientEndColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomScreenTipsManager(CurrentObject).GradientEndColor);
  end;
end;

procedure TatScreenTipsLibrary.__SetTCustomScreenTipsManagerGradientEndColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomScreenTipsManager(CurrentObject).GradientEndColor:=GetInputArg(0);
  end;
end;

procedure TatScreenTipsLibrary.__GetTCustomScreenTipsManagerGradientStartColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomScreenTipsManager(CurrentObject).GradientStartColor);
  end;
end;

procedure TatScreenTipsLibrary.__SetTCustomScreenTipsManagerGradientStartColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomScreenTipsManager(CurrentObject).GradientStartColor:=GetInputArg(0);
  end;
end;

procedure TatScreenTipsLibrary.__GetTCustomScreenTipsManagerLinkedActionLists(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomScreenTipsManager(CurrentObject).LinkedActionLists));
  end;
end;

procedure TatScreenTipsLibrary.__SetTCustomScreenTipsManagerLinkedActionLists(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomScreenTipsManager(CurrentObject).LinkedActionLists:=TActionListCollection(Integer(GetInputArg(0)));
  end;
end;

procedure TatScreenTipsLibrary.__GetTCustomScreenTipsManagerOptions(AMachine: TatVirtualMachine);
var
PropValueSet: TScreenTipOptions;
begin
  with AMachine do
  begin
    PropValueSet := TCustomScreenTipsManager(CurrentObject).Options;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatScreenTipsLibrary.__SetTCustomScreenTipsManagerOptions(AMachine: TatVirtualMachine);
  var
  TempVar: TScreenTipOptions;
begin
  with AMachine do
  begin
    IntToSet(TempVar, VarToInteger(GetInputArg(0)), SizeOf(TempVar));
    TCustomScreenTipsManager(CurrentObject).Options:=TempVar;
  end;
end;

procedure TatScreenTipsLibrary.__GetTCustomScreenTipsManagerScreenTips(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomScreenTipsManager(CurrentObject).ScreenTips));
  end;
end;

procedure TatScreenTipsLibrary.__SetTCustomScreenTipsManagerScreenTips(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomScreenTipsManager(CurrentObject).ScreenTips:=TScreenTipsCollection(Integer(GetInputArg(0)));
  end;
end;

procedure TatScreenTipsLibrary.__TCustomScreenTipsPopupCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomScreenTipsPopupClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScreenTipsLibrary.__TCustomScreenTipsPopupDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomScreenTipsPopup(CurrentObject).Destroy;
  end;
end;

procedure TatScreenTipsLibrary.__TCustomScreenTipsPopupGetScreenTipItem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomScreenTipsPopup(CurrentObject).GetScreenTipItem);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatScreenTipsLibrary.__GetTCustomScreenTipsPopupAssociate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomScreenTipsPopup(CurrentObject).Associate));
  end;
end;

procedure TatScreenTipsLibrary.__SetTCustomScreenTipsPopupAssociate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomScreenTipsPopup(CurrentObject).Associate:=TControl(Integer(GetInputArg(0)));
  end;
end;

procedure TatScreenTipsLibrary.__GetTCustomScreenTipsPopupGlyph(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomScreenTipsPopup(CurrentObject).Glyph));
  end;
end;

procedure TatScreenTipsLibrary.__SetTCustomScreenTipsPopupGlyph(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomScreenTipsPopup(CurrentObject).Glyph:=TPicture(Integer(GetInputArg(0)));
  end;
end;

procedure TatScreenTipsLibrary.__GetTCustomScreenTipsPopupPopupType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomScreenTipsPopup(CurrentObject).PopupType);
  end;
end;

procedure TatScreenTipsLibrary.__SetTCustomScreenTipsPopupPopupType(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomScreenTipsPopup(CurrentObject).PopupType:=GetInputArg(0);
  end;
end;

procedure TatScreenTipsLibrary.__GetTCustomScreenTipsPopupScreenTip(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomScreenTipsPopup(CurrentObject).ScreenTip));
  end;
end;

procedure TatScreenTipsLibrary.__SetTCustomScreenTipsPopupScreenTip(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomScreenTipsPopup(CurrentObject).ScreenTip:=TScreenTipItem(Integer(GetInputArg(0)));
  end;
end;

procedure TatScreenTipsLibrary.__GetTCustomScreenTipsPopupScreenTipManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomScreenTipsPopup(CurrentObject).ScreenTipManager));
  end;
end;

procedure TatScreenTipsLibrary.__SetTCustomScreenTipsPopupScreenTipManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomScreenTipsPopup(CurrentObject).ScreenTipManager:=TCustomScreenTipsManager(Integer(GetInputArg(0)));
  end;
end;

procedure TatScreenTipsLibrary.__GetTCustomScreenTipsPopupTransparent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomScreenTipsPopup(CurrentObject).Transparent);
  end;
end;

procedure TatScreenTipsLibrary.__SetTCustomScreenTipsPopupTransparent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomScreenTipsPopup(CurrentObject).Transparent:=GetInputArg(0);
  end;
end;

procedure TatScreenTipsDispatcher.__TShowScreenTipEvent( Manager: TObject;  Action: TBasicAction; var ShowScreenTip: Boolean);
var
  ShowScreenTipTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TShowScreenTipEvent(BeforeCall)(Manager,Action,ShowScreenTip);
    ShowScreenTipTemp := ShowScreenTip;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Manager,Action,ShowScreenTipTemp]);
    ShowScreenTip := ShowScreenTipTemp;
    if AssignedMethod(AfterCall) then
      TShowScreenTipEvent(AfterCall)(Manager,Action,ShowScreenTip);
  end;
end;

procedure TatScreenTipsDispatcher.__TCreateScreenTipEvent( Manager: TObject;  Item: TScreenTipItem);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TCreateScreenTipEvent(BeforeCall)(Manager,Item);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Manager,Item]);
    if AssignedMethod(AfterCall) then
      TCreateScreenTipEvent(AfterCall)(Manager,Item);
  end;
end;

procedure TatScreenTipsDispatcher.__TDuplicateCreateErrorEvent( Manager: TObject;  Action: TBasicAction);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TDuplicateCreateErrorEvent(BeforeCall)(Manager,Action);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Manager,Action]);
    if AssignedMethod(AfterCall) then
      TDuplicateCreateErrorEvent(AfterCall)(Manager,Action);
  end;
end;

procedure TatScreenTipsLibrary.Init;
begin
  With Scripter.DefineClass(TScreenTipsWindow) do
  begin
    DefineMethod('Create',1,tkClass,TScreenTipsWindow,__TScreenTipsWindowCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TScreenTipsWindowDestroy,false,0);
    DefineMethod('ActivateToolTip',2,tkNone,nil,__TScreenTipsWindowActivateToolTip,false,0);
    DefineMethod('HideHint',0,tkNone,nil,__TScreenTipsWindowHideHint,false,0);
    DefineProp('HintControl',tkClass,__GetTScreenTipsWindowHintControl,__SetTScreenTipsWindowHintControl,TControl,false,0);
    DefineProp('Image',tkClass,__GetTScreenTipsWindowImage,__SetTScreenTipsWindowImage,TPicture,false,0);
    DefineProp('GradientStartColor',tkEnumeration,__GetTScreenTipsWindowGradientStartColor,__SetTScreenTipsWindowGradientStartColor,nil,false,0);
    DefineProp('GradientEndColor',tkEnumeration,__GetTScreenTipsWindowGradientEndColor,__SetTScreenTipsWindowGradientEndColor,nil,false,0);
    DefineProp('Body',tkVariant,__GetTScreenTipsWindowBody,__SetTScreenTipsWindowBody,nil,false,0);
    DefineProp('Footer',tkVariant,__GetTScreenTipsWindowFooter,__SetTScreenTipsWindowFooter,nil,false,0);
    DefineProp('FooterImage',tkClass,__GetTScreenTipsWindowFooterImage,__SetTScreenTipsWindowFooterImage,TBitmap,false,0);
    DefineProp('ActiveItem',tkClass,__GetTScreenTipsWindowActiveItem,nil,TScreenTipItem,false,0);
    DefineProp('TipBorderStyle',tkEnumeration,__GetTScreenTipsWindowTipBorderStyle,__SetTScreenTipsWindowTipBorderStyle,nil,false,0);
    DefineProp('CornerSize',tkInteger,__GetTScreenTipsWindowCornerSize,__SetTScreenTipsWindowCornerSize,nil,false,0);
  end;
  With Scripter.DefineClass(TScreenTipItem) do
  begin
    DefineMethod('Create',1,tkClass,TScreenTipItem,__TScreenTipItemCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TScreenTipItemDestroy,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TScreenTipItemAssign,false,0);
    DefineMethod('SetManager',1,tkNone,nil,__TScreenTipItemSetManager,false,0);
    DefineMethod('IsEnabled',0,tkVariant,nil,__TScreenTipItemIsEnabled,false,0);
    DefineProp('Height',tkInteger,__GetTScreenTipItemHeight,__SetTScreenTipItemHeight,nil,false,0);
    DefineProp('Width',tkInteger,__GetTScreenTipItemWidth,__SetTScreenTipItemWidth,nil,false,0);
  end;
  With Scripter.DefineClass(TScreenTipsCollection) do
  begin
    DefineMethod('Create',1,tkClass,TScreenTipsCollection,__TScreenTipsCollectionCreate,true,0);
    DefineMethod('Add',0,tkClass,TScreenTipItem,__TScreenTipsCollectionAdd,false,0);
    DefineMethod('Insert',1,tkClass,TScreenTipItem,__TScreenTipsCollectionInsert,false,0);
    DefaultProperty := DefineProp('Items',tkClass,__GetTScreenTipsCollectionItems,__SetTScreenTipsCollectionItems,TScreenTipItem,false,1);
  end;
  With Scripter.DefineClass(TScreenTipBorderStyle) do
  begin
    DefineMethod('Create',0,tkClass,TScreenTipBorderStyle,__TScreenTipBorderStyleCreate,true,0);
  end;
  With Scripter.DefineClass(TDisplayOffset) do
  begin
    DefineMethod('Create',0,tkClass,TDisplayOffset,__TDisplayOffsetCreate,true,0);
  end;
  With Scripter.DefineClass(EAllocatedActionsException) do
  begin
  end;
  With Scripter.DefineClass(TAllocatedActions) do
  begin
    DefineMethod('Create',0,tkClass,TAllocatedActions,__TAllocatedActionsCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TAllocatedActionsDestroy,false,0);
    DefineMethod('AddAction',2,tkNone,nil,__TAllocatedActionsAddAction,false,0);
    DefineMethod('Clear',0,tkNone,nil,__TAllocatedActionsClear,false,0);
    DefineMethod('Delete',2,tkVariant,nil,__TAllocatedActionsDelete,false,0).SetVarArgs([1]);
    DefineMethod('Exists',1,tkVariant,nil,__TAllocatedActionsExists,false,0);
    DefineMethod('Find',2,tkVariant,nil,__TAllocatedActionsFind,false,0).SetVarArgs([1]);
    DefineMethod('GetItem',1,tkClass,TScreenTipItem,__TAllocatedActionsGetItem,false,0);
    DefineProp('Count',tkInteger,__GetTAllocatedActionsCount,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TAssociateItem) do
  begin
    DefineMethod('Create',2,tkClass,TAssociateItem,__TAssociateItemCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TAssociateItemDestroy,false,0);
    DefineProp('PopupTip',tkClass,__GetTAssociateItemPopupTip,__SetTAssociateItemPopupTip,TControl,false,0);
    DefineProp('Associate',tkClass,__GetTAssociateItemAssociate,__SetTAssociateItemAssociate,TControl,false,0);
  end;
  With Scripter.DefineClass(TAssociateItemList) do
  begin
    DefineMethod('Create',0,tkClass,TAssociateItemList,__TAssociateItemListCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TAssociateItemListDestroy,false,0);
    DefineMethod('Add',2,tkNone,nil,__TAssociateItemListAdd,false,0);
    DefineMethod('Remove',1,tkNone,nil,__TAssociateItemListRemove,false,0);
    DefineMethod('Find',1,tkInteger,nil,__TAssociateItemListFind,false,0);
    DefineMethod('Get',1,tkClass,TAssociateItem,__TAssociateItemListGet,false,0);
  end;
  With Scripter.DefineClass(TCustomScreenTipsManager) do
  begin
    DefineMethod('Create',1,tkClass,TCustomScreenTipsManager,__TCustomScreenTipsManagerCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomScreenTipsManagerDestroy,false,0);
    DefineMethod('AddPopup',1,tkNone,nil,__TCustomScreenTipsManagerAddPopup,false,0);
    DefineMethod('ClearScreenTips',0,tkNone,nil,__TCustomScreenTipsManagerClearScreenTips,false,0);
    DefineMethod('CreateScreenTip',1,tkClass,TScreenTipItem,__TCustomScreenTipsManagerCreateScreenTip,false,0);
    DefineMethod('GenerateScreenTips',0,tkVariant,nil,__TCustomScreenTipsManagerGenerateScreenTips,false,0);
    DefineMethod('GetScreenTip',1,tkClass,TScreenTipItem,__TCustomScreenTipsManagerGetScreenTip,false,0);
    DefineMethod('RemovePopup',1,tkNone,nil,__TCustomScreenTipsManagerRemovePopup,false,0);
    DefineMethod('RemoveScreenTip',1,tkVariant,nil,__TCustomScreenTipsManagerRemoveScreenTip,false,0);
    DefineMethod('UpdateOptions',0,tkNone,nil,__TCustomScreenTipsManagerUpdateOptions,false,0);
    DefineProp('BorderStyle',tkClass,__GetTCustomScreenTipsManagerBorderStyle,__SetTCustomScreenTipsManagerBorderStyle,TScreenTipBorderStyle,false,0);
    DefineProp('DisplayOffset',tkClass,__GetTCustomScreenTipsManagerDisplayOffset,__SetTCustomScreenTipsManagerDisplayOffset,TDisplayOffset,false,0);
    DefineProp('Font',tkClass,__GetTCustomScreenTipsManagerFont,__SetTCustomScreenTipsManagerFont,TFont,false,0);
    DefineProp('Footer',tkVariant,__GetTCustomScreenTipsManagerFooter,__SetTCustomScreenTipsManagerFooter,nil,false,0);
    DefineProp('FooterImage',tkClass,__GetTCustomScreenTipsManagerFooterImage,__SetTCustomScreenTipsManagerFooterImage,TPicture,false,0);
    DefineProp('GradientEndColor',tkEnumeration,__GetTCustomScreenTipsManagerGradientEndColor,__SetTCustomScreenTipsManagerGradientEndColor,nil,false,0);
    DefineProp('GradientStartColor',tkEnumeration,__GetTCustomScreenTipsManagerGradientStartColor,__SetTCustomScreenTipsManagerGradientStartColor,nil,false,0);
    DefineProp('LinkedActionLists',tkClass,__GetTCustomScreenTipsManagerLinkedActionLists,__SetTCustomScreenTipsManagerLinkedActionLists,TActionListCollection,false,0);
    DefineProp('Options',tkInteger,__GetTCustomScreenTipsManagerOptions,__SetTCustomScreenTipsManagerOptions,nil,false,0);
    DefineProp('ScreenTips',tkClass,__GetTCustomScreenTipsManagerScreenTips,__SetTCustomScreenTipsManagerScreenTips,TScreenTipsCollection,false,0);
  end;
  With Scripter.DefineClass(TScreenTipsManager) do
  begin
  end;
  With Scripter.DefineClass(TCustomScreenTipsPopup) do
  begin
    DefineMethod('Create',1,tkClass,TCustomScreenTipsPopup,__TCustomScreenTipsPopupCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomScreenTipsPopupDestroy,false,0);
    DefineMethod('GetScreenTipItem',0,tkClass,TScreenTipItem,__TCustomScreenTipsPopupGetScreenTipItem,false,0);
    DefineProp('Associate',tkClass,__GetTCustomScreenTipsPopupAssociate,__SetTCustomScreenTipsPopupAssociate,TControl,false,0);
    DefineProp('Glyph',tkClass,__GetTCustomScreenTipsPopupGlyph,__SetTCustomScreenTipsPopupGlyph,TPicture,false,0);
    DefineProp('PopupType',tkEnumeration,__GetTCustomScreenTipsPopupPopupType,__SetTCustomScreenTipsPopupPopupType,nil,false,0);
    DefineProp('ScreenTip',tkClass,__GetTCustomScreenTipsPopupScreenTip,__SetTCustomScreenTipsPopupScreenTip,TScreenTipItem,false,0);
    DefineProp('ScreenTipManager',tkClass,__GetTCustomScreenTipsPopupScreenTipManager,__SetTCustomScreenTipsPopupScreenTipManager,TCustomScreenTipsManager,false,0);
    DefineProp('Transparent',tkVariant,__GetTCustomScreenTipsPopupTransparent,__SetTCustomScreenTipsPopupTransparent,nil,false,0);
  end;
  With Scripter.DefineClass(TScreenTipsPopup) do
  begin
  end;
  DefineEventAdapter(TypeInfo(TShowScreenTipEvent), TatScreenTipsDispatcher, @TatScreenTipsDispatcher.__TShowScreenTipEvent);
  DefineEventAdapter(TypeInfo(TCreateScreenTipEvent), TatScreenTipsDispatcher, @TatScreenTipsDispatcher.__TCreateScreenTipEvent);
  DefineEventAdapter(TypeInfo(TDuplicateCreateErrorEvent), TatScreenTipsDispatcher, @TatScreenTipsDispatcher.__TDuplicateCreateErrorEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('hbsNormal',hbsNormal);
    AddConstant('hbsRounded',hbsRounded);
    AddConstant('soShowHeader',soShowHeader);
    AddConstant('soShowShortCut',soShowShortCut);
    AddConstant('iaLeft',iaLeft);
    AddConstant('iaRight',iaRight);
    AddConstant('iiaLeft',iiaLeft);
    AddConstant('iiaCenter',iiaCenter);
    AddConstant('iiaRight',iiaRight);
    AddConstant('dtManual',dtManual);
    AddConstant('dtHelp',dtHelp);
    AddConstant('dtResource',dtResource);
    AddConstant('ptCustom',ptCustom);
    AddConstant('ptHelp',ptHelp);
    AddConstant('ptInfo',ptInfo);
    AddConstant('cDefaultStartColor',cDefaultStartColor);
    AddConstant('cDefaultEndColor',cDefaultEndColor);
    AddConstant('cDefaultBorderColor',cDefaultBorderColor);
    AddConstant('cScreenTipHeaderSpacing',cScreenTipHeaderSpacing);
    AddConstant('cScreenTipTextOnlyWidth',cScreenTipTextOnlyWidth);
    AddConstant('cScreenTipTextAndImageWidth',cScreenTipTextAndImageWidth);
    AddConstant('cScreenTipMinimumHeight',cScreenTipMinimumHeight);
  end;
end;

class function TatScreenTipsLibrary.LibraryName: string;
begin
  result := 'ScreenTips';
end;

initialization
  RegisterScripterLibrary(TatScreenTipsLibrary, True);

{$WARNINGS ON}

end.

