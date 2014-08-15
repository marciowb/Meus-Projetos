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
unit ap_ActnMan;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Forms,
  Menus,
  ActnList,
  Graphics,
  ToolWin,
  ImgList,
  Controls,
  Buttons,
  StdCtrls,
  ActnMan,
  Variants,
  ap_Messages,
  ap_Types,
  atScript;

{$WARNINGS OFF}

type
  TatActnManLibrary = class(TatScripterLibrary)
    procedure __TActionBarStyleGetStyleName(AMachine: TatVirtualMachine);
    procedure __TCustomActionManagerCreate(AMachine: TatVirtualMachine);
    procedure __TCustomActionManagerDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomActionManagerAddAction(AMachine: TatVirtualMachine);
    procedure __TCustomActionManagerAddCategory(AMachine: TatVirtualMachine);
    procedure __TCustomActionManagerAddSeparator(AMachine: TatVirtualMachine);
    procedure __TCustomActionManagerAssign(AMachine: TatVirtualMachine);
    procedure __TCustomActionManagerDeleteItem(AMachine: TatVirtualMachine);
    procedure __TCustomActionManagerFindItemByCaption(AMachine: TatVirtualMachine);
    procedure __TCustomActionManagerFindItemByAction(AMachine: TatVirtualMachine);
    procedure __TCustomActionManagerLoadFromFile(AMachine: TatVirtualMachine);
    procedure __TCustomActionManagerLoadFromStream(AMachine: TatVirtualMachine);
    procedure __TCustomActionManagerResetActionBar(AMachine: TatVirtualMachine);
    procedure __TCustomActionManagerResetUsageData(AMachine: TatVirtualMachine);
    procedure __TCustomActionManagerSaveToFile(AMachine: TatVirtualMachine);
    procedure __TCustomActionManagerSaveToStream(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionManagerActionBars(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionManagerActionBars(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionManagerDefaultActionBars(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionManagerDisabledImages(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionManagerDisabledImages(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionManagerLargeDisabledImages(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionManagerLargeDisabledImages(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionManagerLargeImages(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionManagerLargeImages(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionManagerLinkedActionLists(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionManagerLinkedActionLists(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionManagerFileName(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionManagerFileName(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionManagerPrioritySchedule(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionManagerPrioritySchedule(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionManagerStyle(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionManagerStyle(AMachine: TatVirtualMachine);
    procedure __TActionListItemAssign(AMachine: TatVirtualMachine);
    procedure __GetTActionListCollectionActionManager(AMachine: TatVirtualMachine);
    procedure __GetTActionListCollectionListItems(AMachine: TatVirtualMachine);
    procedure __SetTActionListCollectionListItems(AMachine: TatVirtualMachine);
    procedure __GetTActionClientsCollectionActionManager(AMachine: TatVirtualMachine);
    procedure __GetTActionClientsCollectionAutoHotKeys(AMachine: TatVirtualMachine);
    procedure __SetTActionClientsCollectionAutoHotKeys(AMachine: TatVirtualMachine);
    procedure __GetTActionClientsCollectionCustomizable(AMachine: TatVirtualMachine);
    procedure __SetTActionClientsCollectionCustomizable(AMachine: TatVirtualMachine);
    procedure __TActionClientCreate(AMachine: TatVirtualMachine);
    procedure __TActionClientDestroy(AMachine: TatVirtualMachine);
    procedure __TActionClientAssign(AMachine: TatVirtualMachine);
    procedure __TActionClientHasBackground(AMachine: TatVirtualMachine);
    procedure __TActionClientRefresh(AMachine: TatVirtualMachine);
    procedure __GetTActionClientActionBar(AMachine: TatVirtualMachine);
    procedure __SetTActionClientActionBar(AMachine: TatVirtualMachine);
    procedure __GetTActionClientChildActionBar(AMachine: TatVirtualMachine);
    procedure __SetTActionClientChildActionBar(AMachine: TatVirtualMachine);
    procedure __GetTActionClientHasItems(AMachine: TatVirtualMachine);
    procedure __GetTActionClientOwningCollection(AMachine: TatVirtualMachine);
    procedure __TActionBarItemCreate(AMachine: TatVirtualMachine);
    procedure __TActionBarItemRefresh(AMachine: TatVirtualMachine);
    procedure __TActionBarsAdd(AMachine: TatVirtualMachine);
    procedure __GetTActionBarsActionBars(AMachine: TatVirtualMachine);
    procedure __TActionClientsAdd(AMachine: TatVirtualMachine);
    procedure __TActionClientsAssign(AMachine: TatVirtualMachine);
    procedure __TActionClientsVisibleCount(AMachine: TatVirtualMachine);
    procedure __GetTActionClientsActionClients(AMachine: TatVirtualMachine);
    procedure __SetTActionClientsActionClients(AMachine: TatVirtualMachine);
    procedure __GetTActionClientsActionManager(AMachine: TatVirtualMachine);
    procedure __TCheckBoxPropertiesCreate(AMachine: TatVirtualMachine);
    procedure __TCheckBoxPropertiesAssign(AMachine: TatVirtualMachine);
    procedure __TTextPropertiesCreate(AMachine: TatVirtualMachine);
    procedure __TTextPropertiesDestroy(AMachine: TatVirtualMachine);
    procedure __TTextPropertiesAssign(AMachine: TatVirtualMachine);
    procedure __TControlPropertiesCreate(AMachine: TatVirtualMachine);
    procedure __TControlPropertiesAssign(AMachine: TatVirtualMachine);
    procedure __TMenuPropertiesCreate(AMachine: TatVirtualMachine);
    procedure __TMenuPropertiesDestroy(AMachine: TatVirtualMachine);
    procedure __TMenuPropertiesAssign(AMachine: TatVirtualMachine);
    procedure __TComboBoxPropertiesCreate(AMachine: TatVirtualMachine);
    procedure __TActionClientItemResetUsageData(AMachine: TatVirtualMachine);
    procedure __TActionClientItemCreate(AMachine: TatVirtualMachine);
    procedure __TActionClientItemDestroy(AMachine: TatVirtualMachine);
    procedure __TActionClientItemAssign(AMachine: TatVirtualMachine);
    procedure __TActionClientItemHasGlyph(AMachine: TatVirtualMachine);
    procedure __TActionClientItemInitiateAction(AMachine: TatVirtualMachine);
    procedure __TActionClientItemRefresh(AMachine: TatVirtualMachine);
    procedure __TActionClientItemUnused(AMachine: TatVirtualMachine);
    procedure __GetTActionClientItemActionClients(AMachine: TatVirtualMachine);
    procedure __GetTActionClientItemActionLink(AMachine: TatVirtualMachine);
    procedure __SetTActionClientItemActionLink(AMachine: TatVirtualMachine);
    procedure __GetTActionClientItemCheckUnused(AMachine: TatVirtualMachine);
    procedure __SetTActionClientItemCheckUnused(AMachine: TatVirtualMachine);
    procedure __GetTActionClientItemControl(AMachine: TatVirtualMachine);
    procedure __SetTActionClientItemControl(AMachine: TatVirtualMachine);
    procedure __GetTActionClientItemDisplayRow(AMachine: TatVirtualMachine);
    procedure __SetTActionClientItemDisplayRow(AMachine: TatVirtualMachine);
    procedure __GetTActionClientItemParentItem(AMachine: TatVirtualMachine);
    procedure __GetTActionClientItemSeparator(AMachine: TatVirtualMachine);
    procedure __GetTActionClientItemShortCutText(AMachine: TatVirtualMachine);
    procedure __GetTActionDragBaseClassActionManager(AMachine: TatVirtualMachine);
    procedure __SetTActionDragBaseClassActionManager(AMachine: TatVirtualMachine);
    procedure __TActionDragObjectCreate(AMachine: TatVirtualMachine);
    procedure __TActionDragObjectDestroy(AMachine: TatVirtualMachine);
    procedure __TActionDragObjectAddAction(AMachine: TatVirtualMachine);
    procedure __TActionDragObjectAddActionClass(AMachine: TatVirtualMachine);
    procedure __GetTActionDragObjectActionCount(AMachine: TatVirtualMachine);
    procedure __GetTActionDragObjectActions(AMachine: TatVirtualMachine);
    procedure __TCategoryDragObjectCreate(AMachine: TatVirtualMachine);
    procedure __GetTCategoryDragObjectCategory(AMachine: TatVirtualMachine);
    procedure __GetTActionItemDragObjectClientItem(AMachine: TatVirtualMachine);
    procedure __SetTActionItemDragObjectClientItem(AMachine: TatVirtualMachine);
    procedure __TCustomActionBarColorMapCreate(AMachine: TatVirtualMachine);
    procedure __TCustomActionBarColorMapDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomActionBarColorMapAssign(AMachine: TatVirtualMachine);
    procedure __TCustomActionBarColorMapUpdateColors(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarColorMapBtnFrameColor(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionBarColorMapBtnFrameColor(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarColorMapBtnSelectedColor(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionBarColorMapBtnSelectedColor(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarColorMapBtnSelectedFont(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionBarColorMapBtnSelectedFont(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarColorMapColor(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionBarColorMapColor(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarColorMapDesignFocus(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionBarColorMapDesignFocus(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarColorMapDisabledColor(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionBarColorMapDisabledColor(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarColorMapDisabledFontColor(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionBarColorMapDisabledFontColor(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarColorMapDisabledFontShadow(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionBarColorMapDisabledFontShadow(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarColorMapFontColor(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionBarColorMapFontColor(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarColorMapFrameTopLeftInner(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionBarColorMapFrameTopLeftInner(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarColorMapFrameTopLeftOuter(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionBarColorMapFrameTopLeftOuter(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarColorMapFrameBottomRightInner(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionBarColorMapFrameBottomRightInner(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarColorMapFrameBottomRightOuter(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionBarColorMapFrameBottomRightOuter(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarColorMapHighlightColor(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionBarColorMapHighlightColor(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarColorMapHotColor(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionBarColorMapHotColor(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarColorMapHotFontColor(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionBarColorMapHotFontColor(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarColorMapMenuColor(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionBarColorMapMenuColor(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarColorMapSelectedColor(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionBarColorMapSelectedColor(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarColorMapSelectedFontColor(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionBarColorMapSelectedFontColor(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarColorMapShadowColor(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionBarColorMapShadowColor(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarColorMapUnusedColor(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionBarColorMapUnusedColor(AMachine: TatVirtualMachine);
    procedure __TCustomActionBarCreate(AMachine: TatVirtualMachine);
    procedure __TCustomActionBarDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomActionBarCreateControl(AMachine: TatVirtualMachine);
    procedure __TCustomActionBarDesignWndProc(AMachine: TatVirtualMachine);
    procedure __TCustomActionBarDoDropCategory(AMachine: TatVirtualMachine);
    procedure __TCustomActionBarFindAccelItem(AMachine: TatVirtualMachine);
    procedure __TCustomActionBarDragDrop(AMachine: TatVirtualMachine);
    procedure __TCustomActionBarFindFirst(AMachine: TatVirtualMachine);
    procedure __TCustomActionBarFindFirstVisibleItem(AMachine: TatVirtualMachine);
    procedure __TCustomActionBarFindLastVisibleItem(AMachine: TatVirtualMachine);
    procedure __TCustomActionBarRecreateControls(AMachine: TatVirtualMachine);
    procedure __TCustomActionBarSetBounds(AMachine: TatVirtualMachine);
    procedure __TCustomActionBarStyle(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarActionManager(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionBarActionManager(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarActionClient(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionBarActionClient(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarAllowHiding(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionBarAllowHiding(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarAutoSizing(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionBarAutoSizing(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarCanvas(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarColorMap(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionBarColorMap(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarContextBar(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionBarContextBar(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarDesignable(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionBarDesignable(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarDesignMode(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionBarDesignMode(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarHorzMargin(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionBarHorzMargin(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarHorzSeparator(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionBarHorzSeparator(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarOrientation(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionBarOrientation(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarPersistentHotKeys(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionBarPersistentHotKeys(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarActionControls(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarSpacing(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionBarSpacing(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarVertMargin(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionBarVertMargin(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionBarVertSeparator(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionBarVertSeparator(AMachine: TatVirtualMachine);
    procedure __TCustomActionControlCreate(AMachine: TatVirtualMachine);
    procedure __TCustomActionControlDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomActionControlDesignWndProc(AMachine: TatVirtualMachine);
    procedure __TCustomActionControlCalcBounds(AMachine: TatVirtualMachine);
    procedure __TCustomActionControlClick(AMachine: TatVirtualMachine);
    procedure __TCustomActionControlDragDrop(AMachine: TatVirtualMachine);
    procedure __TCustomActionControlInitiateAction(AMachine: TatVirtualMachine);
    procedure __TCustomActionControlKeyed(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionControlActionBar(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionControlActionClient(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionControlActionClient(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionControlDropPoint(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionControlDropPoint(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionControlGlyphLayout(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionControlGlyphLayout(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionControlMargins(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionControlMargins(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionControlSelected(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionControlSelected(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionControlSeparator(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionControlShowCaption(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionControlShowShortCut(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionControlSmallIcon(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionControlSmallIcon(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionControlSpacing(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionControlSpacing(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionControlTextBounds(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionControlTextBounds(AMachine: TatVirtualMachine);
    procedure __GetTCustomActionControlTransparent(AMachine: TatVirtualMachine);
    procedure __SetTCustomActionControlTransparent(AMachine: TatVirtualMachine);
    procedure __GetTActionBarStyleListStyle(AMachine: TatVirtualMachine);
    procedure __NotifyDesigner(AMachine: TatVirtualMachine);
    procedure __GetcDefaultSchedule(AMachine: TatVirtualMachine);
    procedure __GetActionBarStyles(AMachine: TatVirtualMachine);
    procedure __SetActionBarStyles(AMachine: TatVirtualMachine);
    procedure __GetDefaultActnBarStyle(AMachine: TatVirtualMachine);
    procedure __SetDefaultActnBarStyle(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TActionBarStyleClass = class of TActionBarStyle;
  TCustomActionManagerClass = class of TCustomActionManager;
  TActionManagerClass = class of TActionManager;
  TActionListItemClass = class of TActionListItem;
  TActionListCollectionClass = class of TActionListCollection;
  TActionClientsCollectionClass = class of TActionClientsCollection;
  TActionClientClass = class of TActionClient;
  TActionBarItemClass = class of TActionBarItem;
  TActionBarsClass = class of TActionBars;
  TActionClientsClass = class of TActionClients;
  TActionClientLinkClass = class of TActionClientLink;
  TCommandPropertiesClass = class of TCommandProperties;
  TCheckBoxPropertiesClass = class of TCheckBoxProperties;
  TButtonPropertiesClass = class of TButtonProperties;
  TGalleryPropertiesClass = class of TGalleryProperties;
  TTextPropertiesClass = class of TTextProperties;
  TControlPropertiesClass = class of TControlProperties;
  TMenuPropertiesClass = class of TMenuProperties;
  TComboBoxPropertiesClass = class of TComboBoxProperties;
  TActionClientItemClass = class of TActionClientItem;
  TActionDragBaseClassClass = class of TActionDragBaseClass;
  TCustomActionClassClass = class of TCustomActionClass;
  TActionDragObjectClass = class of TActionDragObject;
  TCategoryDragObjectClass = class of TCategoryDragObject;
  TActionItemDragObjectClass = class of TActionItemDragObject;
  TCustomActionBarColorMapClass = class of TCustomActionBarColorMap;
  TCustomActionBarClass = class of TCustomActionBar;
  TCustomActionControlClass = class of TCustomActionControl;
  TXToolDockFormClass = class of TXToolDockForm;
  TActionBarStyleListClass = class of TActionBarStyleList;

  TatActnManDispatcher = class(TatEventDispatcher)
  private
    procedure __TStyleChanged( Sender: TCustomActionManager);
    procedure __TActionProc( AClient: TActionClient);
    procedure __TControlCreatedEvent( Sender: TObject; var Control: TCustomActionControl);
  end;

  TCMItemMsgWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FUnused: Integer;
    FSender: TCustomActionControl;
    FResult: Longint;
  public
    constructor Create(ARecord: TCMItemMsg);
    function ObjToRec: TCMItemMsg;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Unused: Integer read FUnused write FUnused;
    property Sender: TCustomActionControl read FSender write FSender;
    property Result: Longint read FResult write FResult;
  end;
  

implementation

constructor TCMItemMsgWrapper.Create(ARecord: TCMItemMsg);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FUnused := ARecord.Unused;
  FSender := ARecord.Sender;
  FResult := ARecord.Result;
end;

function TCMItemMsgWrapper.ObjToRec: TCMItemMsg;
begin
  result.Msg := FMsg;
  result.Unused := FUnused;
  result.Sender := FSender;
  result.Result := FResult;
end;



procedure TatActnManLibrary.__TActionBarStyleGetStyleName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TActionBarStyle(CurrentObject).GetStyleName;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnManLibrary.__TCustomActionManagerCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomActionManagerClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnManLibrary.__TCustomActionManagerDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionManager(CurrentObject).Destroy;
  end;
end;

procedure TatActnManLibrary.__TCustomActionManagerAddAction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
2: AResult := Integer(TCustomActionManager(CurrentObject).AddAction(TCustomAction(Integer(GetInputArg(0))),TActionClient(Integer(GetInputArg(1)))));
3: AResult := Integer(TCustomActionManager(CurrentObject).AddAction(TCustomAction(Integer(GetInputArg(0))),TActionClient(Integer(GetInputArg(1))),GetInputArg(2)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnManLibrary.__TCustomActionManagerAddCategory(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
2: AResult := Integer(TCustomActionManager(CurrentObject).AddCategory(GetInputArg(0),TActionClient(Integer(GetInputArg(1)))));
3: AResult := Integer(TCustomActionManager(CurrentObject).AddCategory(GetInputArg(0),TActionClient(Integer(GetInputArg(1))),GetInputArg(2)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnManLibrary.__TCustomActionManagerAddSeparator(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := Integer(TCustomActionManager(CurrentObject).AddSeparator(TActionClientItem(Integer(GetInputArg(0)))));
2: AResult := Integer(TCustomActionManager(CurrentObject).AddSeparator(TActionClientItem(Integer(GetInputArg(0))),GetInputArg(1)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnManLibrary.__TCustomActionManagerAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionManager(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatActnManLibrary.__TCustomActionManagerDeleteItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionManager(CurrentObject).DeleteItem(GetInputArg(0));
  end;
end;

procedure TatActnManLibrary.__TCustomActionManagerFindItemByCaption(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomActionManager(CurrentObject).FindItemByCaption(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnManLibrary.__TCustomActionManagerFindItemByAction(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomActionManager(CurrentObject).FindItemByAction(TCustomAction(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnManLibrary.__TCustomActionManagerLoadFromFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionManager(CurrentObject).LoadFromFile(GetInputArg(0));
  end;
end;

procedure TatActnManLibrary.__TCustomActionManagerLoadFromStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionManager(CurrentObject).LoadFromStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatActnManLibrary.__TCustomActionManagerResetActionBar(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionManager(CurrentObject).ResetActionBar(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatActnManLibrary.__TCustomActionManagerResetUsageData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionManager(CurrentObject).ResetUsageData;
  end;
end;

procedure TatActnManLibrary.__TCustomActionManagerSaveToFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionManager(CurrentObject).SaveToFile(GetInputArg(0));
  end;
end;

procedure TatActnManLibrary.__TCustomActionManagerSaveToStream(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionManager(CurrentObject).SaveToStream(TStream(Integer(GetInputArg(0))));
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionManagerActionBars(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomActionManager(CurrentObject).ActionBars));
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionManagerActionBars(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionManager(CurrentObject).ActionBars:=TActionBars(Integer(GetInputArg(0)));
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionManagerDefaultActionBars(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomActionManager(CurrentObject).DefaultActionBars));
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionManagerDisabledImages(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomActionManager(CurrentObject).DisabledImages));
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionManagerDisabledImages(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionManager(CurrentObject).DisabledImages:=TCustomImageList(Integer(GetInputArg(0)));
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionManagerLargeDisabledImages(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomActionManager(CurrentObject).LargeDisabledImages));
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionManagerLargeDisabledImages(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionManager(CurrentObject).LargeDisabledImages:=TCustomImageList(Integer(GetInputArg(0)));
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionManagerLargeImages(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomActionManager(CurrentObject).LargeImages));
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionManagerLargeImages(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionManager(CurrentObject).LargeImages:=TCustomImageList(Integer(GetInputArg(0)));
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionManagerLinkedActionLists(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomActionManager(CurrentObject).LinkedActionLists));
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionManagerLinkedActionLists(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionManager(CurrentObject).LinkedActionLists:=TActionListCollection(Integer(GetInputArg(0)));
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionManagerFileName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionManager(CurrentObject).FileName);
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionManagerFileName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionManager(CurrentObject).FileName:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionManagerPrioritySchedule(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomActionManager(CurrentObject).PrioritySchedule));
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionManagerPrioritySchedule(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionManager(CurrentObject).PrioritySchedule:=TStringList(Integer(GetInputArg(0)));
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionManagerStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomActionManager(CurrentObject).Style));
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionManagerStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionManager(CurrentObject).Style:=TActionBarStyle(Integer(GetInputArg(0)));
  end;
end;

procedure TatActnManLibrary.__TActionListItemAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TActionListItem(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatActnManLibrary.__GetTActionListCollectionActionManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TActionListCollection(CurrentObject).ActionManager));
  end;
end;

procedure TatActnManLibrary.__GetTActionListCollectionListItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TActionListCollection(CurrentObject).ListItems[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatActnManLibrary.__SetTActionListCollectionListItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TActionListCollection(CurrentObject).ListItems[VarToInteger(GetArrayIndex(0))]:=TActionListItem(Integer(GetInputArg(0)));
  end;
end;

procedure TatActnManLibrary.__GetTActionClientsCollectionActionManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TActionClientsCollection(CurrentObject).ActionManager));
  end;
end;

procedure TatActnManLibrary.__GetTActionClientsCollectionAutoHotKeys(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TActionClientsCollection(CurrentObject).AutoHotKeys);
  end;
end;

procedure TatActnManLibrary.__SetTActionClientsCollectionAutoHotKeys(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TActionClientsCollection(CurrentObject).AutoHotKeys:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__GetTActionClientsCollectionCustomizable(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TActionClientsCollection(CurrentObject).Customizable);
  end;
end;

procedure TatActnManLibrary.__SetTActionClientsCollectionCustomizable(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TActionClientsCollection(CurrentObject).Customizable:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__TActionClientCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TActionClientClass(CurrentClass.ClassRef).Create(TCollection(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnManLibrary.__TActionClientDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TActionClient(CurrentObject).Destroy;
  end;
end;

procedure TatActnManLibrary.__TActionClientAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TActionClient(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatActnManLibrary.__TActionClientHasBackground(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TActionClient(CurrentObject).HasBackground;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnManLibrary.__TActionClientRefresh(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TActionClient(CurrentObject).Refresh;
  end;
end;

procedure TatActnManLibrary.__GetTActionClientActionBar(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TActionClient(CurrentObject).ActionBar));
  end;
end;

procedure TatActnManLibrary.__SetTActionClientActionBar(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TActionClient(CurrentObject).ActionBar:=TCustomActionBar(Integer(GetInputArg(0)));
  end;
end;

procedure TatActnManLibrary.__GetTActionClientChildActionBar(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TActionClient(CurrentObject).ChildActionBar));
  end;
end;

procedure TatActnManLibrary.__SetTActionClientChildActionBar(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TActionClient(CurrentObject).ChildActionBar:=TCustomActionBar(Integer(GetInputArg(0)));
  end;
end;

procedure TatActnManLibrary.__GetTActionClientHasItems(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TActionClient(CurrentObject).HasItems);
  end;
end;

procedure TatActnManLibrary.__GetTActionClientOwningCollection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TActionClient(CurrentObject).OwningCollection));
  end;
end;

procedure TatActnManLibrary.__TActionBarItemCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TActionBarItemClass(CurrentClass.ClassRef).Create(TCollection(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnManLibrary.__TActionBarItemRefresh(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TActionBarItem(CurrentObject).Refresh;
  end;
end;

procedure TatActnManLibrary.__TActionBarsAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TActionBars(CurrentObject).Add);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnManLibrary.__GetTActionBarsActionBars(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TActionBars(CurrentObject).ActionBars[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatActnManLibrary.__TActionClientsAdd(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TActionClients(CurrentObject).Add);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnManLibrary.__TActionClientsAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TActionClients(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatActnManLibrary.__TActionClientsVisibleCount(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TActionClients(CurrentObject).VisibleCount);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnManLibrary.__GetTActionClientsActionClients(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TActionClients(CurrentObject).ActionClients[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatActnManLibrary.__SetTActionClientsActionClients(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TActionClients(CurrentObject).ActionClients[VarToInteger(GetArrayIndex(0))]:=TActionClientItem(Integer(GetInputArg(0)));
  end;
end;

procedure TatActnManLibrary.__GetTActionClientsActionManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TActionClients(CurrentObject).ActionManager));
  end;
end;

procedure TatActnManLibrary.__TCheckBoxPropertiesCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCheckBoxPropertiesClass(CurrentClass.ClassRef).Create(TActionClientItem(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnManLibrary.__TCheckBoxPropertiesAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCheckBoxProperties(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatActnManLibrary.__TTextPropertiesCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTextPropertiesClass(CurrentClass.ClassRef).Create(TActionClientItem(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnManLibrary.__TTextPropertiesDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTextProperties(CurrentObject).Destroy;
  end;
end;

procedure TatActnManLibrary.__TTextPropertiesAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTextProperties(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatActnManLibrary.__TControlPropertiesCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TControlPropertiesClass(CurrentClass.ClassRef).Create(TActionClientItem(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnManLibrary.__TControlPropertiesAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControlProperties(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatActnManLibrary.__TMenuPropertiesCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TMenuPropertiesClass(CurrentClass.ClassRef).Create(TActionClientItem(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnManLibrary.__TMenuPropertiesDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMenuProperties(CurrentObject).Destroy;
  end;
end;

procedure TatActnManLibrary.__TMenuPropertiesAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMenuProperties(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatActnManLibrary.__TComboBoxPropertiesCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TComboBoxPropertiesClass(CurrentClass.ClassRef).Create(TActionClientItem(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnManLibrary.__TActionClientItemResetUsageData(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TActionClientItem(CurrentObject).ResetUsageData;
  end;
end;

procedure TatActnManLibrary.__TActionClientItemCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TActionClientItemClass(CurrentClass.ClassRef).Create(TCollection(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnManLibrary.__TActionClientItemDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TActionClientItem(CurrentObject).Destroy;
  end;
end;

procedure TatActnManLibrary.__TActionClientItemAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TActionClientItem(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatActnManLibrary.__TActionClientItemHasGlyph(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TActionClientItem(CurrentObject).HasGlyph;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnManLibrary.__TActionClientItemInitiateAction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TActionClientItem(CurrentObject).InitiateAction;
  end;
end;

procedure TatActnManLibrary.__TActionClientItemRefresh(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TActionClientItem(CurrentObject).Refresh;
  end;
end;

procedure TatActnManLibrary.__TActionClientItemUnused(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TActionClientItem(CurrentObject).Unused;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnManLibrary.__GetTActionClientItemActionClients(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TActionClientItem(CurrentObject).ActionClients));
  end;
end;

procedure TatActnManLibrary.__GetTActionClientItemActionLink(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TActionClientItem(CurrentObject).ActionLink));
  end;
end;

procedure TatActnManLibrary.__SetTActionClientItemActionLink(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TActionClientItem(CurrentObject).ActionLink:=TActionClientLink(Integer(GetInputArg(0)));
  end;
end;

procedure TatActnManLibrary.__GetTActionClientItemCheckUnused(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TActionClientItem(CurrentObject).CheckUnused);
  end;
end;

procedure TatActnManLibrary.__SetTActionClientItemCheckUnused(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TActionClientItem(CurrentObject).CheckUnused:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__GetTActionClientItemControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TActionClientItem(CurrentObject).Control));
  end;
end;

procedure TatActnManLibrary.__SetTActionClientItemControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TActionClientItem(CurrentObject).Control:=TCustomActionControl(Integer(GetInputArg(0)));
  end;
end;

procedure TatActnManLibrary.__GetTActionClientItemDisplayRow(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TActionClientItem(CurrentObject).DisplayRow));
  end;
end;

procedure TatActnManLibrary.__SetTActionClientItemDisplayRow(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TActionClientItem(CurrentObject).DisplayRow:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatActnManLibrary.__GetTActionClientItemParentItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TActionClientItem(CurrentObject).ParentItem));
  end;
end;

procedure TatActnManLibrary.__GetTActionClientItemSeparator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TActionClientItem(CurrentObject).Separator);
  end;
end;

procedure TatActnManLibrary.__GetTActionClientItemShortCutText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TActionClientItem(CurrentObject).ShortCutText);
  end;
end;

procedure TatActnManLibrary.__GetTActionDragBaseClassActionManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TActionDragBaseClass(CurrentObject).ActionManager));
  end;
end;

procedure TatActnManLibrary.__SetTActionDragBaseClassActionManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TActionDragBaseClass(CurrentObject).ActionManager:=TCustomActionManager(Integer(GetInputArg(0)));
  end;
end;

procedure TatActnManLibrary.__TActionDragObjectCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TActionDragObjectClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnManLibrary.__TActionDragObjectDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TActionDragObject(CurrentObject).Destroy;
  end;
end;

procedure TatActnManLibrary.__TActionDragObjectAddAction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TActionDragObject(CurrentObject).AddAction(TContainedAction(Integer(GetInputArg(0))));
  end;
end;

procedure TatActnManLibrary.__TActionDragObjectAddActionClass(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TActionDragObject(CurrentObject).AddActionClass(TCustomActionClass(Integer(GetInputArg(0))));
  end;
end;

procedure TatActnManLibrary.__GetTActionDragObjectActionCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TActionDragObject(CurrentObject).ActionCount));
  end;
end;

procedure TatActnManLibrary.__GetTActionDragObjectActions(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TActionDragObject(CurrentObject).Actions[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatActnManLibrary.__TCategoryDragObjectCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCategoryDragObjectClass(CurrentClass.ClassRef).Create(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnManLibrary.__GetTCategoryDragObjectCategory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCategoryDragObject(CurrentObject).Category);
  end;
end;

procedure TatActnManLibrary.__GetTActionItemDragObjectClientItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TActionItemDragObject(CurrentObject).ClientItem));
  end;
end;

procedure TatActnManLibrary.__SetTActionItemDragObjectClientItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TActionItemDragObject(CurrentObject).ClientItem:=TActionClientItem(Integer(GetInputArg(0)));
  end;
end;

procedure TatActnManLibrary.__TCustomActionBarColorMapCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomActionBarColorMapClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnManLibrary.__TCustomActionBarColorMapDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBarColorMap(CurrentObject).Destroy;
  end;
end;

procedure TatActnManLibrary.__TCustomActionBarColorMapAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBarColorMap(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatActnManLibrary.__TCustomActionBarColorMapUpdateColors(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBarColorMap(CurrentObject).UpdateColors;
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarColorMapBtnFrameColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionBarColorMap(CurrentObject).BtnFrameColor);
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionBarColorMapBtnFrameColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBarColorMap(CurrentObject).BtnFrameColor:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarColorMapBtnSelectedColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionBarColorMap(CurrentObject).BtnSelectedColor);
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionBarColorMapBtnSelectedColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBarColorMap(CurrentObject).BtnSelectedColor:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarColorMapBtnSelectedFont(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionBarColorMap(CurrentObject).BtnSelectedFont);
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionBarColorMapBtnSelectedFont(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBarColorMap(CurrentObject).BtnSelectedFont:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarColorMapColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionBarColorMap(CurrentObject).Color);
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionBarColorMapColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBarColorMap(CurrentObject).Color:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarColorMapDesignFocus(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionBarColorMap(CurrentObject).DesignFocus);
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionBarColorMapDesignFocus(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBarColorMap(CurrentObject).DesignFocus:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarColorMapDisabledColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionBarColorMap(CurrentObject).DisabledColor);
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionBarColorMapDisabledColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBarColorMap(CurrentObject).DisabledColor:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarColorMapDisabledFontColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionBarColorMap(CurrentObject).DisabledFontColor);
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionBarColorMapDisabledFontColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBarColorMap(CurrentObject).DisabledFontColor:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarColorMapDisabledFontShadow(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionBarColorMap(CurrentObject).DisabledFontShadow);
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionBarColorMapDisabledFontShadow(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBarColorMap(CurrentObject).DisabledFontShadow:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarColorMapFontColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionBarColorMap(CurrentObject).FontColor);
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionBarColorMapFontColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBarColorMap(CurrentObject).FontColor:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarColorMapFrameTopLeftInner(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionBarColorMap(CurrentObject).FrameTopLeftInner);
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionBarColorMapFrameTopLeftInner(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBarColorMap(CurrentObject).FrameTopLeftInner:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarColorMapFrameTopLeftOuter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionBarColorMap(CurrentObject).FrameTopLeftOuter);
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionBarColorMapFrameTopLeftOuter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBarColorMap(CurrentObject).FrameTopLeftOuter:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarColorMapFrameBottomRightInner(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionBarColorMap(CurrentObject).FrameBottomRightInner);
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionBarColorMapFrameBottomRightInner(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBarColorMap(CurrentObject).FrameBottomRightInner:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarColorMapFrameBottomRightOuter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionBarColorMap(CurrentObject).FrameBottomRightOuter);
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionBarColorMapFrameBottomRightOuter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBarColorMap(CurrentObject).FrameBottomRightOuter:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarColorMapHighlightColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionBarColorMap(CurrentObject).HighlightColor);
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionBarColorMapHighlightColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBarColorMap(CurrentObject).HighlightColor:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarColorMapHotColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionBarColorMap(CurrentObject).HotColor);
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionBarColorMapHotColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBarColorMap(CurrentObject).HotColor:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarColorMapHotFontColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionBarColorMap(CurrentObject).HotFontColor);
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionBarColorMapHotFontColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBarColorMap(CurrentObject).HotFontColor:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarColorMapMenuColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionBarColorMap(CurrentObject).MenuColor);
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionBarColorMapMenuColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBarColorMap(CurrentObject).MenuColor:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarColorMapSelectedColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionBarColorMap(CurrentObject).SelectedColor);
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionBarColorMapSelectedColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBarColorMap(CurrentObject).SelectedColor:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarColorMapSelectedFontColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionBarColorMap(CurrentObject).SelectedFontColor);
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionBarColorMapSelectedFontColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBarColorMap(CurrentObject).SelectedFontColor:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarColorMapShadowColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionBarColorMap(CurrentObject).ShadowColor);
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionBarColorMapShadowColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBarColorMap(CurrentObject).ShadowColor:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarColorMapUnusedColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionBarColorMap(CurrentObject).UnusedColor);
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionBarColorMapUnusedColor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBarColorMap(CurrentObject).UnusedColor:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__TCustomActionBarCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomActionBarClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnManLibrary.__TCustomActionBarDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBar(CurrentObject).Destroy;
  end;
end;

procedure TatActnManLibrary.__TCustomActionBarCreateControl(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomActionBar(CurrentObject).CreateControl(TActionClientItem(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnManLibrary.__TCustomActionBarDesignWndProc(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TMessage;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TMessageWrapper) then 
  Param0Rec := TMessageWrapper.Create(Param0);
Param0 := TMessageWrapper(Param0Rec).ObjToRec;
AResult := TCustomActionBar(CurrentObject).DesignWndProc(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TMessageWrapper.Create(Param0)));
  end;
end;

procedure TatActnManLibrary.__TCustomActionBarDoDropCategory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBar(CurrentObject).DoDropCategory(TCategoryDragObject(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatActnManLibrary.__TCustomActionBarFindAccelItem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomActionBar(CurrentObject).FindAccelItem(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnManLibrary.__TCustomActionBarDragDrop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBar(CurrentObject).DragDrop(TObject(integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatActnManLibrary.__TCustomActionBarFindFirst(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomActionBar(CurrentObject).FindFirst);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnManLibrary.__TCustomActionBarFindFirstVisibleItem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomActionBar(CurrentObject).FindFirstVisibleItem);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnManLibrary.__TCustomActionBarFindLastVisibleItem(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomActionBar(CurrentObject).FindLastVisibleItem);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnManLibrary.__TCustomActionBarRecreateControls(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBar(CurrentObject).RecreateControls;
  end;
end;

procedure TatActnManLibrary.__TCustomActionBarSetBounds(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBar(CurrentObject).SetBounds(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatActnManLibrary.__TCustomActionBarStyle(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomActionBar(CurrentObject).Style);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarActionManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomActionBar(CurrentObject).ActionManager));
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionBarActionManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBar(CurrentObject).ActionManager:=TCustomActionManager(Integer(GetInputArg(0)));
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarActionClient(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomActionBar(CurrentObject).ActionClient));
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionBarActionClient(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBar(CurrentObject).ActionClient:=TActionClient(Integer(GetInputArg(0)));
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarAllowHiding(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionBar(CurrentObject).AllowHiding);
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionBarAllowHiding(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBar(CurrentObject).AllowHiding:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarAutoSizing(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionBar(CurrentObject).AutoSizing);
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionBarAutoSizing(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBar(CurrentObject).AutoSizing:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarCanvas(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomActionBar(CurrentObject).Canvas));
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarColorMap(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomActionBar(CurrentObject).ColorMap));
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionBarColorMap(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBar(CurrentObject).ColorMap:=TCustomActionBarColorMap(Integer(GetInputArg(0)));
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarContextBar(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionBar(CurrentObject).ContextBar);
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionBarContextBar(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBar(CurrentObject).ContextBar:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarDesignable(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionBar(CurrentObject).Designable);
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionBarDesignable(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBar(CurrentObject).Designable:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarDesignMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionBar(CurrentObject).DesignMode);
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionBarDesignMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBar(CurrentObject).DesignMode:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarHorzMargin(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomActionBar(CurrentObject).HorzMargin));
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionBarHorzMargin(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBar(CurrentObject).HorzMargin:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarHorzSeparator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionBar(CurrentObject).HorzSeparator);
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionBarHorzSeparator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBar(CurrentObject).HorzSeparator:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarOrientation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionBar(CurrentObject).Orientation);
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionBarOrientation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBar(CurrentObject).Orientation:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarPersistentHotKeys(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionBar(CurrentObject).PersistentHotKeys);
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionBarPersistentHotKeys(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBar(CurrentObject).PersistentHotKeys:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarActionControls(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomActionBar(CurrentObject).ActionControls[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarSpacing(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomActionBar(CurrentObject).Spacing));
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionBarSpacing(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBar(CurrentObject).Spacing:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarVertMargin(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomActionBar(CurrentObject).VertMargin));
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionBarVertMargin(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBar(CurrentObject).VertMargin:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionBarVertSeparator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionBar(CurrentObject).VertSeparator);
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionBarVertSeparator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionBar(CurrentObject).VertSeparator:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__TCustomActionControlCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomActionControlClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatActnManLibrary.__TCustomActionControlDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionControl(CurrentObject).Destroy;
  end;
end;

procedure TatActnManLibrary.__TCustomActionControlDesignWndProc(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TMessage;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TMessageWrapper) then 
  Param0Rec := TMessageWrapper.Create(Param0);
Param0 := TMessageWrapper(Param0Rec).ObjToRec;
AResult := TCustomActionControl(CurrentObject).DesignWndProc(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TMessageWrapper.Create(Param0)));
  end;
end;

procedure TatActnManLibrary.__TCustomActionControlCalcBounds(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionControl(CurrentObject).CalcBounds;
  end;
end;

procedure TatActnManLibrary.__TCustomActionControlClick(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionControl(CurrentObject).Click;
  end;
end;

procedure TatActnManLibrary.__TCustomActionControlDragDrop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionControl(CurrentObject).DragDrop(TObject(integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatActnManLibrary.__TCustomActionControlInitiateAction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionControl(CurrentObject).InitiateAction;
  end;
end;

procedure TatActnManLibrary.__TCustomActionControlKeyed(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionControl(CurrentObject).Keyed;
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionControlActionBar(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomActionControl(CurrentObject).ActionBar));
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionControlActionClient(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomActionControl(CurrentObject).ActionClient));
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionControlActionClient(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionControl(CurrentObject).ActionClient:=TActionClientItem(Integer(GetInputArg(0)));
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionControlDropPoint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionControl(CurrentObject).DropPoint);
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionControlDropPoint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionControl(CurrentObject).DropPoint:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionControlGlyphLayout(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionControl(CurrentObject).GlyphLayout);
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionControlGlyphLayout(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionControl(CurrentObject).GlyphLayout:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionControlMargins(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TRectWrapper.Create(TCustomActionControl(CurrentObject).Margins)));
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionControlMargins(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionControl(CurrentObject).Margins:=TRectWrapper(integer(GetInputArg(0))).ObjToRec;
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionControlSelected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionControl(CurrentObject).Selected);
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionControlSelected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionControl(CurrentObject).Selected:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionControlSeparator(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionControl(CurrentObject).Separator);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionControlShowCaption(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionControl(CurrentObject).ShowCaption);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionControlShowShortCut(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionControl(CurrentObject).ShowShortCut);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionControlSmallIcon(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionControl(CurrentObject).SmallIcon);
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionControlSmallIcon(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionControl(CurrentObject).SmallIcon:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionControlSpacing(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomActionControl(CurrentObject).Spacing));
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionControlSpacing(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionControl(CurrentObject).Spacing:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionControlTextBounds(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TRectWrapper.Create(TCustomActionControl(CurrentObject).TextBounds)));
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionControlTextBounds(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionControl(CurrentObject).TextBounds:=TRectWrapper(integer(GetInputArg(0))).ObjToRec;
  end;
end;

procedure TatActnManLibrary.__GetTCustomActionControlTransparent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomActionControl(CurrentObject).Transparent);
  end;
end;

procedure TatActnManLibrary.__SetTCustomActionControlTransparent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomActionControl(CurrentObject).Transparent:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.__GetTActionBarStyleListStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TActionBarStyleList(CurrentObject).Style[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatActnManDispatcher.__TStyleChanged( Sender: TCustomActionManager);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TStyleChanged(BeforeCall)(Sender);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender]);
    if AssignedMethod(AfterCall) then
      TStyleChanged(AfterCall)(Sender);
  end;
end;

procedure TatActnManDispatcher.__TActionProc( AClient: TActionClient);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TActionProc(BeforeCall)(AClient);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [AClient]);
    if AssignedMethod(AfterCall) then
      TActionProc(AfterCall)(AClient);
  end;
end;

procedure TatActnManDispatcher.__TControlCreatedEvent( Sender: TObject; var Control: TCustomActionControl);
var
  ControlTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TControlCreatedEvent(BeforeCall)(Sender,Control);
    ControlTemp := Integer(Control);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,ControlTemp]);
    Control := TCustomActionControl(Integer(ControlTemp));
    if AssignedMethod(AfterCall) then
      TControlCreatedEvent(AfterCall)(Sender,Control);
  end;
end;

procedure TatActnManLibrary.__NotifyDesigner(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ActnMan.NotifyDesigner(TCustomActionBar(Integer(GetInputArg(0))));
  end;
end;

procedure TatActnManLibrary.__GetcDefaultSchedule(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(ActnMan.cDefaultSchedule);
  end;
end;

procedure TatActnManLibrary.__GetActionBarStyles(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(ActnMan.ActionBarStyles));
  end;
end;

procedure TatActnManLibrary.__SetActionBarStyles(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ActnMan.ActionBarStyles:=TActionBarStyleList(Integer(GetInputArg(0)));
  end;
end;

procedure TatActnManLibrary.__GetDefaultActnBarStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(ActnMan.DefaultActnBarStyle);
  end;
end;

procedure TatActnManLibrary.__SetDefaultActnBarStyle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ActnMan.DefaultActnBarStyle:=GetInputArg(0);
  end;
end;

procedure TatActnManLibrary.Init;
begin
  With Scripter.DefineClass(TActionBarStyle) do
  begin
    DefineMethod('GetStyleName',0,tkVariant,nil,__TActionBarStyleGetStyleName,false,0);
  end;
  With Scripter.DefineClass(TCustomActionManager) do
  begin
    DefineMethod('Create',1,tkClass,TCustomActionManager,__TCustomActionManagerCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomActionManagerDestroy,false,0);
    DefineMethod('AddAction',3,tkClass,TActionClientItem,__TCustomActionManagerAddAction,false,1);
    DefineMethod('AddCategory',3,tkClass,TActionClientItem,__TCustomActionManagerAddCategory,false,1);
    DefineMethod('AddSeparator',2,tkClass,TActionClientItem,__TCustomActionManagerAddSeparator,false,1);
    DefineMethod('Assign',1,tkNone,nil,__TCustomActionManagerAssign,false,0);
    DefineMethod('DeleteItem',1,tkNone,nil,__TCustomActionManagerDeleteItem,false,0);
    DefineMethod('FindItemByCaption',1,tkClass,TActionClientItem,__TCustomActionManagerFindItemByCaption,false,0);
    DefineMethod('FindItemByAction',1,tkClass,TActionClientItem,__TCustomActionManagerFindItemByAction,false,0);
    DefineMethod('LoadFromFile',1,tkNone,nil,__TCustomActionManagerLoadFromFile,false,0);
    DefineMethod('LoadFromStream',1,tkNone,nil,__TCustomActionManagerLoadFromStream,false,0);
    DefineMethod('ResetActionBar',1,tkNone,nil,__TCustomActionManagerResetActionBar,false,0);
    DefineMethod('ResetUsageData',0,tkNone,nil,__TCustomActionManagerResetUsageData,false,0);
    DefineMethod('SaveToFile',1,tkNone,nil,__TCustomActionManagerSaveToFile,false,0);
    DefineMethod('SaveToStream',1,tkNone,nil,__TCustomActionManagerSaveToStream,false,0);
    DefineProp('ActionBars',tkClass,__GetTCustomActionManagerActionBars,__SetTCustomActionManagerActionBars,TActionBars,false,0);
    DefineProp('DefaultActionBars',tkClass,__GetTCustomActionManagerDefaultActionBars,nil,TActionBars,false,0);
    DefineProp('DisabledImages',tkClass,__GetTCustomActionManagerDisabledImages,__SetTCustomActionManagerDisabledImages,TCustomImageList,false,0);
    DefineProp('LargeDisabledImages',tkClass,__GetTCustomActionManagerLargeDisabledImages,__SetTCustomActionManagerLargeDisabledImages,TCustomImageList,false,0);
    DefineProp('LargeImages',tkClass,__GetTCustomActionManagerLargeImages,__SetTCustomActionManagerLargeImages,TCustomImageList,false,0);
    DefineProp('LinkedActionLists',tkClass,__GetTCustomActionManagerLinkedActionLists,__SetTCustomActionManagerLinkedActionLists,TActionListCollection,false,0);
    DefineProp('FileName',tkVariant,__GetTCustomActionManagerFileName,__SetTCustomActionManagerFileName,nil,false,0);
    DefineProp('Images',tkVariant,nil,nil,nil,false,0);
    DefineProp('PrioritySchedule',tkClass,__GetTCustomActionManagerPrioritySchedule,__SetTCustomActionManagerPrioritySchedule,TStringList,false,0);
    DefineProp('Style',tkClass,__GetTCustomActionManagerStyle,__SetTCustomActionManagerStyle,TActionBarStyle,false,0);
  end;
  With Scripter.DefineClass(TActionManager) do
  begin
  end;
  With Scripter.DefineClass(TActionListItem) do
  begin
    DefineMethod('Assign',1,tkNone,nil,__TActionListItemAssign,false,0);
  end;
  With Scripter.DefineClass(TActionListCollection) do
  begin
    DefineProp('ActionManager',tkClass,__GetTActionListCollectionActionManager,nil,TCustomActionManager,false,0);
    DefaultProperty := DefineProp('ListItems',tkClass,__GetTActionListCollectionListItems,__SetTActionListCollectionListItems,TActionListItem,false,1);
  end;
  With Scripter.DefineClass(TActionClientsCollection) do
  begin
    DefineProp('ActionManager',tkClass,__GetTActionClientsCollectionActionManager,nil,TCustomActionManager,false,0);
    DefineProp('AutoHotKeys',tkVariant,__GetTActionClientsCollectionAutoHotKeys,__SetTActionClientsCollectionAutoHotKeys,nil,false,0);
    DefineProp('Customizable',tkVariant,__GetTActionClientsCollectionCustomizable,__SetTActionClientsCollectionCustomizable,nil,false,0);
  end;
  With Scripter.DefineClass(TActionClient) do
  begin
    DefineMethod('Create',1,tkClass,TActionClient,__TActionClientCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TActionClientDestroy,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TActionClientAssign,false,0);
    DefineMethod('HasBackground',0,tkVariant,nil,__TActionClientHasBackground,false,0);
    DefineMethod('Refresh',0,tkNone,nil,__TActionClientRefresh,false,0);
    DefineProp('ActionBar',tkClass,__GetTActionClientActionBar,__SetTActionClientActionBar,TCustomActionBar,false,0);
    DefineProp('ChildActionBar',tkClass,__GetTActionClientChildActionBar,__SetTActionClientChildActionBar,TCustomActionBar,false,0);
    DefineProp('HasItems',tkVariant,__GetTActionClientHasItems,nil,nil,false,0);
    DefineProp('OwningCollection',tkClass,__GetTActionClientOwningCollection,nil,TActionClientsCollection,false,0);
  end;
  With Scripter.DefineClass(TActionBarItem) do
  begin
    DefineMethod('Create',1,tkClass,TActionBarItem,__TActionBarItemCreate,true,0);
    DefineMethod('Refresh',0,tkNone,nil,__TActionBarItemRefresh,false,0);
  end;
  With Scripter.DefineClass(TActionBars) do
  begin
    DefineMethod('Add',0,tkClass,TActionBarItem,__TActionBarsAdd,false,0);
    DefaultProperty := DefineProp('ActionBars',tkClass,__GetTActionBarsActionBars,nil,TActionBarItem,false,1);
  end;
  With Scripter.DefineClass(TActionClients) do
  begin
    DefineMethod('Add',0,tkClass,TActionClientItem,__TActionClientsAdd,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TActionClientsAssign,false,0);
    DefineMethod('VisibleCount',0,tkInteger,nil,__TActionClientsVisibleCount,false,0);
    DefaultProperty := DefineProp('ActionClients',tkClass,__GetTActionClientsActionClients,__SetTActionClientsActionClients,TActionClientItem,false,1);
    DefineProp('ActionManager',tkClass,__GetTActionClientsActionManager,nil,TCustomActionManager,false,0);
  end;
  With Scripter.DefineClass(TActionClientLink) do
  begin
  end;
  With Scripter.DefineClass(TCommandProperties) do
  begin
  end;
  With Scripter.DefineClass(TCheckBoxProperties) do
  begin
    DefineMethod('Create',1,tkClass,TCheckBoxProperties,__TCheckBoxPropertiesCreate,true,0);
    DefineMethod('Assign',1,tkNone,nil,__TCheckBoxPropertiesAssign,false,0);
  end;
  With Scripter.DefineClass(TButtonProperties) do
  begin
  end;
  With Scripter.DefineClass(TGalleryProperties) do
  begin
  end;
  With Scripter.DefineClass(TTextProperties) do
  begin
    DefineMethod('Create',1,tkClass,TTextProperties,__TTextPropertiesCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TTextPropertiesDestroy,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TTextPropertiesAssign,false,0);
  end;
  With Scripter.DefineClass(TControlProperties) do
  begin
    DefineMethod('Create',1,tkClass,TControlProperties,__TControlPropertiesCreate,true,0);
    DefineMethod('Assign',1,tkNone,nil,__TControlPropertiesAssign,false,0);
  end;
  With Scripter.DefineClass(TMenuProperties) do
  begin
    DefineMethod('Create',1,tkClass,TMenuProperties,__TMenuPropertiesCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TMenuPropertiesDestroy,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TMenuPropertiesAssign,false,0);
  end;
  With Scripter.DefineClass(TComboBoxProperties) do
  begin
    DefineMethod('Create',1,tkClass,TComboBoxProperties,__TComboBoxPropertiesCreate,true,0);
  end;
  With Scripter.DefineClass(TActionClientItem) do
  begin
    DefineMethod('ResetUsageData',0,tkNone,nil,__TActionClientItemResetUsageData,false,0);
    DefineMethod('Create',1,tkClass,TActionClientItem,__TActionClientItemCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TActionClientItemDestroy,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TActionClientItemAssign,false,0);
    DefineMethod('HasGlyph',0,tkVariant,nil,__TActionClientItemHasGlyph,false,0);
    DefineMethod('InitiateAction',0,tkNone,nil,__TActionClientItemInitiateAction,false,0);
    DefineMethod('Refresh',0,tkNone,nil,__TActionClientItemRefresh,false,0);
    DefineMethod('Unused',0,tkVariant,nil,__TActionClientItemUnused,false,0);
    DefineProp('ActionClients',tkClass,__GetTActionClientItemActionClients,nil,TActionClients,false,0);
    DefineProp('ActionLink',tkClass,__GetTActionClientItemActionLink,__SetTActionClientItemActionLink,TActionClientLink,false,0);
    DefineProp('CheckUnused',tkVariant,__GetTActionClientItemCheckUnused,__SetTActionClientItemCheckUnused,nil,false,0);
    DefineProp('Control',tkClass,__GetTActionClientItemControl,__SetTActionClientItemControl,TCustomActionControl,false,0);
    DefineProp('DisplayRow',tkInteger,__GetTActionClientItemDisplayRow,__SetTActionClientItemDisplayRow,nil,false,0);
    DefineProp('ParentItem',tkClass,__GetTActionClientItemParentItem,nil,TActionClient,false,0);
    DefineProp('Separator',tkVariant,__GetTActionClientItemSeparator,nil,nil,false,0);
    DefineProp('ShortCutText',tkVariant,__GetTActionClientItemShortCutText,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TActionDragBaseClass) do
  begin
    DefineProp('ActionManager',tkClass,__GetTActionDragBaseClassActionManager,__SetTActionDragBaseClassActionManager,TCustomActionManager,false,0);
  end;
  With Scripter.DefineClass(TCustomActionClass) do
  begin
  end;
  With Scripter.DefineClass(TActionDragObject) do
  begin
    DefineMethod('Create',0,tkClass,TActionDragObject,__TActionDragObjectCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TActionDragObjectDestroy,false,0);
    DefineMethod('AddAction',1,tkNone,nil,__TActionDragObjectAddAction,false,0);
    DefineMethod('AddActionClass',1,tkNone,nil,__TActionDragObjectAddActionClass,false,0);
    DefineProp('ActionCount',tkInteger,__GetTActionDragObjectActionCount,nil,nil,false,0);
    DefineProp('Actions',tkClass,__GetTActionDragObjectActions,nil,TContainedAction,false,1);
  end;
  With Scripter.DefineClass(TCategoryDragObject) do
  begin
    DefineMethod('Create',1,tkClass,TCategoryDragObject,__TCategoryDragObjectCreate,true,0);
    DefineProp('Category',tkVariant,__GetTCategoryDragObjectCategory,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TActionItemDragObject) do
  begin
    DefineProp('ClientItem',tkClass,__GetTActionItemDragObjectClientItem,__SetTActionItemDragObjectClientItem,TActionClientItem,false,0);
  end;
  With Scripter.DefineClass(TCustomActionBarColorMap) do
  begin
    DefineMethod('Create',1,tkClass,TCustomActionBarColorMap,__TCustomActionBarColorMapCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomActionBarColorMapDestroy,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TCustomActionBarColorMapAssign,false,0);
    DefineMethod('UpdateColors',0,tkNone,nil,__TCustomActionBarColorMapUpdateColors,false,0);
    DefineProp('BtnFrameColor',tkEnumeration,__GetTCustomActionBarColorMapBtnFrameColor,__SetTCustomActionBarColorMapBtnFrameColor,nil,false,0);
    DefineProp('BtnSelectedColor',tkEnumeration,__GetTCustomActionBarColorMapBtnSelectedColor,__SetTCustomActionBarColorMapBtnSelectedColor,nil,false,0);
    DefineProp('BtnSelectedFont',tkEnumeration,__GetTCustomActionBarColorMapBtnSelectedFont,__SetTCustomActionBarColorMapBtnSelectedFont,nil,false,0);
    DefineProp('Color',tkEnumeration,__GetTCustomActionBarColorMapColor,__SetTCustomActionBarColorMapColor,nil,false,0);
    DefineProp('DesignFocus',tkEnumeration,__GetTCustomActionBarColorMapDesignFocus,__SetTCustomActionBarColorMapDesignFocus,nil,false,0);
    DefineProp('DisabledColor',tkEnumeration,__GetTCustomActionBarColorMapDisabledColor,__SetTCustomActionBarColorMapDisabledColor,nil,false,0);
    DefineProp('DisabledFontColor',tkEnumeration,__GetTCustomActionBarColorMapDisabledFontColor,__SetTCustomActionBarColorMapDisabledFontColor,nil,false,0);
    DefineProp('DisabledFontShadow',tkEnumeration,__GetTCustomActionBarColorMapDisabledFontShadow,__SetTCustomActionBarColorMapDisabledFontShadow,nil,false,0);
    DefineProp('FontColor',tkEnumeration,__GetTCustomActionBarColorMapFontColor,__SetTCustomActionBarColorMapFontColor,nil,false,0);
    DefineProp('FrameTopLeftInner',tkEnumeration,__GetTCustomActionBarColorMapFrameTopLeftInner,__SetTCustomActionBarColorMapFrameTopLeftInner,nil,false,0);
    DefineProp('FrameTopLeftOuter',tkEnumeration,__GetTCustomActionBarColorMapFrameTopLeftOuter,__SetTCustomActionBarColorMapFrameTopLeftOuter,nil,false,0);
    DefineProp('FrameBottomRightInner',tkEnumeration,__GetTCustomActionBarColorMapFrameBottomRightInner,__SetTCustomActionBarColorMapFrameBottomRightInner,nil,false,0);
    DefineProp('FrameBottomRightOuter',tkEnumeration,__GetTCustomActionBarColorMapFrameBottomRightOuter,__SetTCustomActionBarColorMapFrameBottomRightOuter,nil,false,0);
    DefineProp('HighlightColor',tkEnumeration,__GetTCustomActionBarColorMapHighlightColor,__SetTCustomActionBarColorMapHighlightColor,nil,false,0);
    DefineProp('HotColor',tkEnumeration,__GetTCustomActionBarColorMapHotColor,__SetTCustomActionBarColorMapHotColor,nil,false,0);
    DefineProp('HotFontColor',tkEnumeration,__GetTCustomActionBarColorMapHotFontColor,__SetTCustomActionBarColorMapHotFontColor,nil,false,0);
    DefineProp('MenuColor',tkEnumeration,__GetTCustomActionBarColorMapMenuColor,__SetTCustomActionBarColorMapMenuColor,nil,false,0);
    DefineProp('SelectedColor',tkEnumeration,__GetTCustomActionBarColorMapSelectedColor,__SetTCustomActionBarColorMapSelectedColor,nil,false,0);
    DefineProp('SelectedFontColor',tkEnumeration,__GetTCustomActionBarColorMapSelectedFontColor,__SetTCustomActionBarColorMapSelectedFontColor,nil,false,0);
    DefineProp('ShadowColor',tkEnumeration,__GetTCustomActionBarColorMapShadowColor,__SetTCustomActionBarColorMapShadowColor,nil,false,0);
    DefineProp('UnusedColor',tkEnumeration,__GetTCustomActionBarColorMapUnusedColor,__SetTCustomActionBarColorMapUnusedColor,nil,false,0);
  end;
  With Scripter.DefineClass(TCustomActionBar) do
  begin
    DefineMethod('Create',1,tkClass,TCustomActionBar,__TCustomActionBarCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomActionBarDestroy,false,0);
    DefineMethod('CreateControl',1,tkClass,TCustomActionControl,__TCustomActionBarCreateControl,false,0);
    DefineMethod('DesignWndProc',1,tkVariant,nil,__TCustomActionBarDesignWndProc,false,0).SetVarArgs([0]);
    DefineMethod('DoDropCategory',3,tkNone,nil,__TCustomActionBarDoDropCategory,false,0);
    DefineMethod('FindAccelItem',1,tkClass,TActionClientItem,__TCustomActionBarFindAccelItem,false,0);
    DefineMethod('DragDrop',3,tkNone,nil,__TCustomActionBarDragDrop,false,0);
    DefineMethod('FindFirst',0,tkClass,TActionClientItem,__TCustomActionBarFindFirst,false,0);
    DefineMethod('FindFirstVisibleItem',0,tkClass,TActionClientItem,__TCustomActionBarFindFirstVisibleItem,false,0);
    DefineMethod('FindLastVisibleItem',0,tkClass,TActionClientItem,__TCustomActionBarFindLastVisibleItem,false,0);
    DefineMethod('RecreateControls',0,tkNone,nil,__TCustomActionBarRecreateControls,false,0);
    DefineMethod('SetBounds',4,tkNone,nil,__TCustomActionBarSetBounds,false,0);
    DefineMethod('Style',0,tkClass,TActionBarStyle,__TCustomActionBarStyle,false,0);
    DefineProp('ActionManager',tkClass,__GetTCustomActionBarActionManager,__SetTCustomActionBarActionManager,TCustomActionManager,false,0);
    DefineProp('ActionClient',tkClass,__GetTCustomActionBarActionClient,__SetTCustomActionBarActionClient,TActionClient,false,0);
    DefineProp('AllowHiding',tkVariant,__GetTCustomActionBarAllowHiding,__SetTCustomActionBarAllowHiding,nil,false,0);
    DefineProp('AutoSizing',tkVariant,__GetTCustomActionBarAutoSizing,__SetTCustomActionBarAutoSizing,nil,false,0);
    DefineProp('Caption',tkVariant,nil,nil,nil,false,0);
    DefineProp('Canvas',tkClass,__GetTCustomActionBarCanvas,nil,TCanvas,false,0);
    DefineProp('Color',tkVariant,nil,nil,nil,false,0);
    DefineProp('ColorMap',tkClass,__GetTCustomActionBarColorMap,__SetTCustomActionBarColorMap,TCustomActionBarColorMap,false,0);
    DefineProp('ContextBar',tkVariant,__GetTCustomActionBarContextBar,__SetTCustomActionBarContextBar,nil,false,0);
    DefineProp('Designable',tkVariant,__GetTCustomActionBarDesignable,__SetTCustomActionBarDesignable,nil,false,0);
    DefineProp('Font',tkVariant,nil,nil,nil,false,0);
    DefineProp('DesignMode',tkVariant,__GetTCustomActionBarDesignMode,__SetTCustomActionBarDesignMode,nil,false,0);
    DefineProp('HorzMargin',tkInteger,__GetTCustomActionBarHorzMargin,__SetTCustomActionBarHorzMargin,nil,false,0);
    DefineProp('HorzSeparator',tkVariant,__GetTCustomActionBarHorzSeparator,__SetTCustomActionBarHorzSeparator,nil,false,0);
    DefineProp('Orientation',tkEnumeration,__GetTCustomActionBarOrientation,__SetTCustomActionBarOrientation,nil,false,0);
    DefineProp('PersistentHotKeys',tkVariant,__GetTCustomActionBarPersistentHotKeys,__SetTCustomActionBarPersistentHotKeys,nil,false,0);
    DefineProp('ActionControls',tkClass,__GetTCustomActionBarActionControls,nil,TCustomActionControl,false,1);
    DefineProp('Spacing',tkInteger,__GetTCustomActionBarSpacing,__SetTCustomActionBarSpacing,nil,false,0);
    DefineProp('VertMargin',tkInteger,__GetTCustomActionBarVertMargin,__SetTCustomActionBarVertMargin,nil,false,0);
    DefineProp('VertSeparator',tkVariant,__GetTCustomActionBarVertSeparator,__SetTCustomActionBarVertSeparator,nil,false,0);
  end;
  With Scripter.DefineClass(TCustomActionControl) do
  begin
    DefineMethod('Create',1,tkClass,TCustomActionControl,__TCustomActionControlCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomActionControlDestroy,false,0);
    DefineMethod('DesignWndProc',1,tkVariant,nil,__TCustomActionControlDesignWndProc,false,0).SetVarArgs([0]);
    DefineMethod('CalcBounds',0,tkNone,nil,__TCustomActionControlCalcBounds,false,0);
    DefineMethod('Click',0,tkNone,nil,__TCustomActionControlClick,false,0);
    DefineMethod('DragDrop',3,tkNone,nil,__TCustomActionControlDragDrop,false,0);
    DefineMethod('InitiateAction',0,tkNone,nil,__TCustomActionControlInitiateAction,false,0);
    DefineMethod('Keyed',0,tkNone,nil,__TCustomActionControlKeyed,false,0);
    DefineProp('ActionBar',tkClass,__GetTCustomActionControlActionBar,nil,TCustomActionBar,false,0);
    DefineProp('ActionClient',tkClass,__GetTCustomActionControlActionClient,__SetTCustomActionControlActionClient,TActionClientItem,false,0);
    DefineProp('Caption',tkVariant,nil,nil,nil,false,0);
    DefineProp('DropPoint',tkVariant,__GetTCustomActionControlDropPoint,__SetTCustomActionControlDropPoint,nil,false,0);
    DefineProp('GlyphLayout',tkEnumeration,__GetTCustomActionControlGlyphLayout,__SetTCustomActionControlGlyphLayout,nil,false,0);
    DefineProp('Margins',tkVariant,__GetTCustomActionControlMargins,__SetTCustomActionControlMargins,nil,false,0);
    DefineProp('Selected',tkVariant,__GetTCustomActionControlSelected,__SetTCustomActionControlSelected,nil,false,0);
    DefineProp('Separator',tkVariant,__GetTCustomActionControlSeparator,nil,nil,false,0);
    DefineProp('ShowCaption',tkVariant,__GetTCustomActionControlShowCaption,nil,nil,false,0);
    DefineProp('ShowShortCut',tkVariant,__GetTCustomActionControlShowShortCut,nil,nil,false,0);
    DefineProp('SmallIcon',tkVariant,__GetTCustomActionControlSmallIcon,__SetTCustomActionControlSmallIcon,nil,false,0);
    DefineProp('Spacing',tkInteger,__GetTCustomActionControlSpacing,__SetTCustomActionControlSpacing,nil,false,0);
    DefineProp('TextBounds',tkVariant,__GetTCustomActionControlTextBounds,__SetTCustomActionControlTextBounds,nil,false,0);
    DefineProp('Transparent',tkVariant,__GetTCustomActionControlTransparent,__SetTCustomActionControlTransparent,nil,false,0);
    DefineProp('OnClick',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TXToolDockForm) do
  begin
  end;
  With Scripter.DefineClass(TActionBarStyleList) do
  begin
    DefineProp('Style',tkClass,__GetTActionBarStyleListStyle,nil,TActionBarStyle,false,1);
  end;
  DefineEventAdapter(TypeInfo(TStyleChanged), TatActnManDispatcher, @TatActnManDispatcher.__TStyleChanged);
  DefineEventAdapter(TypeInfo(TActionProc), TatActnManDispatcher, @TatActnManDispatcher.__TActionProc);
  DefineEventAdapter(TypeInfo(TControlCreatedEvent), TatActnManDispatcher, @TatActnManDispatcher.__TControlCreatedEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('NotifyDesigner',1,tkNone,nil,__NotifyDesigner,false,0);
    DefineProp('cDefaultSchedule',tkVariant,__GetcDefaultSchedule,nil,nil,false,0);
    DefineProp('ActionBarStyles',tkClass,__GetActionBarStyles,__SetActionBarStyles,TActionBarStyleList,false,0);
    DefineProp('DefaultActnBarStyle',tkVariant,__GetDefaultActnBarStyle,__SetDefaultActnBarStyle,nil,false,0);
    AddConstant('blNormal',blNormal);
    AddConstant('blStretch',blStretch);
    AddConstant('blTile',blTile);
    AddConstant('blLeftBanner',blLeftBanner);
    AddConstant('blRightBanner',blRightBanner);
    AddConstant('caModify',caModify);
    AddConstant('caMove',caMove);
    AddConstant('caDelete',caDelete);
    AddConstant('coNone',coNone);
    AddConstant('coSelective',coSelective);
    AddConstant('coAll',coAll);
    AddConstant('csIgnore',csIgnore);
    AddConstant('csRecreate',csRecreate);
    AddConstant('csRebuild',csRebuild);
    AddConstant('bsSmall',bsSmall);
    AddConstant('bsLarge',bsLarge);
    AddConstant('btNone',btNone);
    AddConstant('btDropDown',btDropDown);
    AddConstant('btSplit',btSplit);
    AddConstant('btGallery',btGallery);
    AddConstant('gpNone',gpNone);
    AddConstant('gpStart',gpStart);
    AddConstant('gpMiddle',gpMiddle);
    AddConstant('gpEnd',gpEnd);
    AddConstant('gpSingle',gpSingle);
    AddConstant('taImage',taImage);
    AddConstant('taDropdown',taDropdown);
    AddConstant('gtDropDown',gtDropDown);
    AddConstant('gtGrid',gtGrid);
    AddConstant('gtRibbon',gtRibbon);
    AddConstant('grNone',grNone);
    AddConstant('grVertical',grVertical);
    AddConstant('grBoth',grBoth);
    AddConstant('csButton',csButton);
    AddConstant('csMenu',csMenu);
    AddConstant('csSeparator',csSeparator);
    AddConstant('csText',csText);
    AddConstant('csGallery',csGallery);
    AddConstant('csComboBox',csComboBox);
    AddConstant('csCheckBox',csCheckBox);
    AddConstant('csRadioButton',csRadioButton);
    AddConstant('csControl',csControl);
    AddConstant('csCustom',csCustom);
    AddConstant('boLeftToRight',boLeftToRight);
    AddConstant('boRightToLeft',boRightToLeft);
    AddConstant('boTopToBottom',boTopToBottom);
    AddConstant('boBottomToTop',boBottomToTop);
    AddConstant('beLeft',beLeft);
    AddConstant('beRight',beRight);
    AddConstant('beEither',beEither);
    AddConstant('CM_ITEMSELECTED',CM_ITEMSELECTED);
    AddConstant('CM_ITEMCLICKED',CM_ITEMCLICKED);
    AddConstant('CM_ITEMKEYED',CM_ITEMKEYED);
    AddConstant('CM_SCROLLCLICKED',CM_SCROLLCLICKED);
    AddConstant('CM_RESETBAR',CM_RESETBAR);
    AddConstant('CM_ENTERMENULOOP',CM_ENTERMENULOOP);
    AddConstant('CM_ITEMDROPPOINT',CM_ITEMDROPPOINT);
    AddConstant('caAllChanges',IntFromConstSet(caAllChanges));
  end;
end;

class function TatActnManLibrary.LibraryName: string;
begin
  result := 'ActnMan';
end;

initialization
  RegisterScripterLibrary(TatActnManLibrary, True);

{$WARNINGS ON}

end.

