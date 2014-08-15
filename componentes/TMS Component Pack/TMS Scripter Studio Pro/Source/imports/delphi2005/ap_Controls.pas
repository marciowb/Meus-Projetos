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
unit ap_Controls;

interface

uses
  Messages,
  Types,
  Windows,
  MultiMon,
  Classes,
  SysUtils,
  Graphics,
  Menus,
  CommCtrl,
  Imm,
  ImgList,
  ActnList,
  Controls,
  Variants,
  ap_Types,
  ap_Messages,
  ap_Windows,
  atScript;

{$WARNINGS OFF}

type
  TatControlsLibrary = class(TatScripterLibrary)
    procedure __TDragObjectAfterConstruction(AMachine: TatVirtualMachine);
    procedure __TDragObjectAssign(AMachine: TatVirtualMachine);
    procedure __TDragObjectBeforeDestruction(AMachine: TatVirtualMachine);
    procedure __TDragObjectGetName(AMachine: TatVirtualMachine);
    procedure __TDragObjectHideDragImage(AMachine: TatVirtualMachine);
    procedure __TDragObjectInstance(AMachine: TatVirtualMachine);
    procedure __TDragObjectShowDragImage(AMachine: TatVirtualMachine);
    procedure __GetTDragObjectAlwaysShowDragImages(AMachine: TatVirtualMachine);
    procedure __SetTDragObjectAlwaysShowDragImages(AMachine: TatVirtualMachine);
    procedure __GetTDragObjectCancelling(AMachine: TatVirtualMachine);
    procedure __SetTDragObjectCancelling(AMachine: TatVirtualMachine);
    procedure __GetTDragObjectDragHandle(AMachine: TatVirtualMachine);
    procedure __SetTDragObjectDragHandle(AMachine: TatVirtualMachine);
    procedure __GetTDragObjectDragPos(AMachine: TatVirtualMachine);
    procedure __SetTDragObjectDragPos(AMachine: TatVirtualMachine);
    procedure __GetTDragObjectDragTargetPos(AMachine: TatVirtualMachine);
    procedure __SetTDragObjectDragTargetPos(AMachine: TatVirtualMachine);
    procedure __GetTDragObjectDropped(AMachine: TatVirtualMachine);
    procedure __GetTDragObjectMouseDeltaX(AMachine: TatVirtualMachine);
    procedure __GetTDragObjectMouseDeltaY(AMachine: TatVirtualMachine);
    procedure __GetTDragObjectRightClickCancels(AMachine: TatVirtualMachine);
    procedure __SetTDragObjectRightClickCancels(AMachine: TatVirtualMachine);
    procedure __TDragObjectExBeforeDestruction(AMachine: TatVirtualMachine);
    procedure __TBaseDragControlObjectCreate(AMachine: TatVirtualMachine);
    procedure __TBaseDragControlObjectAssign(AMachine: TatVirtualMachine);
    procedure __GetTBaseDragControlObjectControl(AMachine: TatVirtualMachine);
    procedure __SetTBaseDragControlObjectControl(AMachine: TatVirtualMachine);
    procedure __TDragControlObjectHideDragImage(AMachine: TatVirtualMachine);
    procedure __TDragControlObjectShowDragImage(AMachine: TatVirtualMachine);
    procedure __TDragControlObjectExBeforeDestruction(AMachine: TatVirtualMachine);
    procedure __TDragDockObjectCreate(AMachine: TatVirtualMachine);
    procedure __TDragDockObjectDestroy(AMachine: TatVirtualMachine);
    procedure __TDragDockObjectAssign(AMachine: TatVirtualMachine);
    procedure __GetTDragDockObjectBrush(AMachine: TatVirtualMachine);
    procedure __SetTDragDockObjectBrush(AMachine: TatVirtualMachine);
    procedure __GetTDragDockObjectDockRect(AMachine: TatVirtualMachine);
    procedure __SetTDragDockObjectDockRect(AMachine: TatVirtualMachine);
    procedure __GetTDragDockObjectDropAlign(AMachine: TatVirtualMachine);
    procedure __GetTDragDockObjectDropOnControl(AMachine: TatVirtualMachine);
    procedure __GetTDragDockObjectFloating(AMachine: TatVirtualMachine);
    procedure __SetTDragDockObjectFloating(AMachine: TatVirtualMachine);
    procedure __GetTDragDockObjectFrameWidth(AMachine: TatVirtualMachine);
    procedure __TDragDockObjectExBeforeDestruction(AMachine: TatVirtualMachine);
    procedure __TControlCanvasDestroy(AMachine: TatVirtualMachine);
    procedure __TControlCanvasFreeHandle(AMachine: TatVirtualMachine);
    procedure __TControlCanvasUpdateTextFlags(AMachine: TatVirtualMachine);
    procedure __GetTControlCanvasControl(AMachine: TatVirtualMachine);
    procedure __SetTControlCanvasControl(AMachine: TatVirtualMachine);
    procedure __GetTCustomControlActionDropdownMenu(AMachine: TatVirtualMachine);
    procedure __SetTCustomControlActionDropdownMenu(AMachine: TatVirtualMachine);
    procedure __GetTCustomControlActionEnableDropdown(AMachine: TatVirtualMachine);
    procedure __SetTCustomControlActionEnableDropdown(AMachine: TatVirtualMachine);
    procedure __GetTCustomControlActionPopupMenu(AMachine: TatVirtualMachine);
    procedure __SetTCustomControlActionPopupMenu(AMachine: TatVirtualMachine);
    procedure __TSizeConstraintsCreate(AMachine: TatVirtualMachine);
    procedure __TControlCreate(AMachine: TatVirtualMachine);
    procedure __TControlDestroy(AMachine: TatVirtualMachine);
    procedure __TControlBeginDrag(AMachine: TatVirtualMachine);
    procedure __TControlBringToFront(AMachine: TatVirtualMachine);
    procedure __TControlClientToScreen(AMachine: TatVirtualMachine);
    procedure __TControlClientToParent(AMachine: TatVirtualMachine);
    procedure __TControlDock(AMachine: TatVirtualMachine);
    procedure __TControlDefaultHandler(AMachine: TatVirtualMachine);
    procedure __TControlDragging(AMachine: TatVirtualMachine);
    procedure __TControlDragDrop(AMachine: TatVirtualMachine);
    procedure __TControlDrawTextBiDiModeFlags(AMachine: TatVirtualMachine);
    procedure __TControlDrawTextBiDiModeFlagsReadingOnly(AMachine: TatVirtualMachine);
    procedure __TControlEndDrag(AMachine: TatVirtualMachine);
    procedure __TControlGetControlsAlignment(AMachine: TatVirtualMachine);
    procedure __TControlGetParentComponent(AMachine: TatVirtualMachine);
    procedure __TControlGetTextBuf(AMachine: TatVirtualMachine);
    procedure __TControlGetTextLen(AMachine: TatVirtualMachine);
    procedure __TControlHasParent(AMachine: TatVirtualMachine);
    procedure __TControlHide(AMachine: TatVirtualMachine);
    procedure __TControlInitiateAction(AMachine: TatVirtualMachine);
    procedure __TControlInvalidate(AMachine: TatVirtualMachine);
    procedure __TControlMouseWheelHandler(AMachine: TatVirtualMachine);
    procedure __TControlIsRightToLeft(AMachine: TatVirtualMachine);
    procedure __TControlManualDock(AMachine: TatVirtualMachine);
    procedure __TControlManualFloat(AMachine: TatVirtualMachine);
    procedure __TControlPerform(AMachine: TatVirtualMachine);
    procedure __TControlRefresh(AMachine: TatVirtualMachine);
    procedure __TControlRepaint(AMachine: TatVirtualMachine);
    procedure __TControlReplaceDockedControl(AMachine: TatVirtualMachine);
    procedure __TControlScreenToClient(AMachine: TatVirtualMachine);
    procedure __TControlParentToClient(AMachine: TatVirtualMachine);
    procedure __TControlSendToBack(AMachine: TatVirtualMachine);
    procedure __TControlSetBounds(AMachine: TatVirtualMachine);
    procedure __TControlSetTextBuf(AMachine: TatVirtualMachine);
    procedure __TControlShow(AMachine: TatVirtualMachine);
    procedure __TControlUpdate(AMachine: TatVirtualMachine);
    procedure __TControlUseRightToLeftAlignment(AMachine: TatVirtualMachine);
    procedure __TControlUseRightToLeftReading(AMachine: TatVirtualMachine);
    procedure __TControlUseRightToLeftScrollBar(AMachine: TatVirtualMachine);
    procedure __GetTControlEnabled(AMachine: TatVirtualMachine);
    procedure __SetTControlEnabled(AMachine: TatVirtualMachine);
    procedure __GetTControlAction(AMachine: TatVirtualMachine);
    procedure __SetTControlAction(AMachine: TatVirtualMachine);
    procedure __GetTControlAlign(AMachine: TatVirtualMachine);
    procedure __SetTControlAlign(AMachine: TatVirtualMachine);
    procedure __GetTControlAnchors(AMachine: TatVirtualMachine);
    procedure __SetTControlAnchors(AMachine: TatVirtualMachine);
    procedure __GetTControlBiDiMode(AMachine: TatVirtualMachine);
    procedure __SetTControlBiDiMode(AMachine: TatVirtualMachine);
    procedure __GetTControlBoundsRect(AMachine: TatVirtualMachine);
    procedure __SetTControlBoundsRect(AMachine: TatVirtualMachine);
    procedure __GetTControlClientHeight(AMachine: TatVirtualMachine);
    procedure __SetTControlClientHeight(AMachine: TatVirtualMachine);
    procedure __GetTControlClientOrigin(AMachine: TatVirtualMachine);
    procedure __GetTControlClientRect(AMachine: TatVirtualMachine);
    procedure __GetTControlClientWidth(AMachine: TatVirtualMachine);
    procedure __SetTControlClientWidth(AMachine: TatVirtualMachine);
    procedure __GetTControlConstraints(AMachine: TatVirtualMachine);
    procedure __SetTControlConstraints(AMachine: TatVirtualMachine);
    procedure __GetTControlControlState(AMachine: TatVirtualMachine);
    procedure __SetTControlControlState(AMachine: TatVirtualMachine);
    procedure __GetTControlControlStyle(AMachine: TatVirtualMachine);
    procedure __SetTControlControlStyle(AMachine: TatVirtualMachine);
    procedure __GetTControlDockOrientation(AMachine: TatVirtualMachine);
    procedure __SetTControlDockOrientation(AMachine: TatVirtualMachine);
    procedure __GetTControlFloating(AMachine: TatVirtualMachine);
    procedure __GetTControlHostDockSite(AMachine: TatVirtualMachine);
    procedure __SetTControlHostDockSite(AMachine: TatVirtualMachine);
    procedure __GetTControlLRDockWidth(AMachine: TatVirtualMachine);
    procedure __SetTControlLRDockWidth(AMachine: TatVirtualMachine);
    procedure __GetTControlParent(AMachine: TatVirtualMachine);
    procedure __SetTControlParent(AMachine: TatVirtualMachine);
    procedure __GetTControlShowHint(AMachine: TatVirtualMachine);
    procedure __SetTControlShowHint(AMachine: TatVirtualMachine);
    procedure __GetTControlTBDockHeight(AMachine: TatVirtualMachine);
    procedure __SetTControlTBDockHeight(AMachine: TatVirtualMachine);
    procedure __GetTControlUndockHeight(AMachine: TatVirtualMachine);
    procedure __SetTControlUndockHeight(AMachine: TatVirtualMachine);
    procedure __GetTControlUndockWidth(AMachine: TatVirtualMachine);
    procedure __SetTControlUndockWidth(AMachine: TatVirtualMachine);
    procedure __GetTControlVisible(AMachine: TatVirtualMachine);
    procedure __SetTControlVisible(AMachine: TatVirtualMachine);
    procedure __TWinControlCreate(AMachine: TatVirtualMachine);
    procedure __TWinControlCreateParented(AMachine: TatVirtualMachine);
    procedure __TWinControlCreateParentedControl(AMachine: TatVirtualMachine);
    procedure __TWinControlDestroy(AMachine: TatVirtualMachine);
    procedure __TWinControlBroadcast(AMachine: TatVirtualMachine);
    procedure __TWinControlCanFocus(AMachine: TatVirtualMachine);
    procedure __TWinControlContainsControl(AMachine: TatVirtualMachine);
    procedure __TWinControlControlAtPos(AMachine: TatVirtualMachine);
    procedure __TWinControlDefaultHandler(AMachine: TatVirtualMachine);
    procedure __TWinControlDisableAlign(AMachine: TatVirtualMachine);
    procedure __TWinControlDockDrop(AMachine: TatVirtualMachine);
    procedure __TWinControlEnableAlign(AMachine: TatVirtualMachine);
    procedure __TWinControlFindChildControl(AMachine: TatVirtualMachine);
    procedure __TWinControlFlipChildren(AMachine: TatVirtualMachine);
    procedure __TWinControlFocused(AMachine: TatVirtualMachine);
    procedure __TWinControlGetTabOrderList(AMachine: TatVirtualMachine);
    procedure __TWinControlHandleAllocated(AMachine: TatVirtualMachine);
    procedure __TWinControlHandleNeeded(AMachine: TatVirtualMachine);
    procedure __TWinControlInsertControl(AMachine: TatVirtualMachine);
    procedure __TWinControlInvalidate(AMachine: TatVirtualMachine);
    procedure __TWinControlPaintTo(AMachine: TatVirtualMachine);
    procedure __TWinControlPreProcessMessage(AMachine: TatVirtualMachine);
    procedure __TWinControlRemoveControl(AMachine: TatVirtualMachine);
    procedure __TWinControlRealign(AMachine: TatVirtualMachine);
    procedure __TWinControlRepaint(AMachine: TatVirtualMachine);
    procedure __TWinControlScaleBy(AMachine: TatVirtualMachine);
    procedure __TWinControlScrollBy(AMachine: TatVirtualMachine);
    procedure __TWinControlSetBounds(AMachine: TatVirtualMachine);
    procedure __TWinControlSetFocus(AMachine: TatVirtualMachine);
    procedure __TWinControlUpdate(AMachine: TatVirtualMachine);
    procedure __TWinControlUpdateControlState(AMachine: TatVirtualMachine);
    procedure __GetTWinControlDockClientCount(AMachine: TatVirtualMachine);
    procedure __GetTWinControlDockClients(AMachine: TatVirtualMachine);
    procedure __GetTWinControlDockSite(AMachine: TatVirtualMachine);
    procedure __SetTWinControlDockSite(AMachine: TatVirtualMachine);
    procedure __GetTWinControlDoubleBuffered(AMachine: TatVirtualMachine);
    procedure __SetTWinControlDoubleBuffered(AMachine: TatVirtualMachine);
    procedure __GetTWinControlAlignDisabled(AMachine: TatVirtualMachine);
    procedure __GetTWinControlVisibleDockClientCount(AMachine: TatVirtualMachine);
    procedure __GetTWinControlBrush(AMachine: TatVirtualMachine);
    procedure __GetTWinControlControls(AMachine: TatVirtualMachine);
    procedure __GetTWinControlControlCount(AMachine: TatVirtualMachine);
    procedure __GetTWinControlHandle(AMachine: TatVirtualMachine);
    procedure __GetTWinControlParentWindow(AMachine: TatVirtualMachine);
    procedure __SetTWinControlParentWindow(AMachine: TatVirtualMachine);
    procedure __GetTWinControlShowing(AMachine: TatVirtualMachine);
    procedure __GetTWinControlTabOrder(AMachine: TatVirtualMachine);
    procedure __SetTWinControlTabOrder(AMachine: TatVirtualMachine);
    procedure __GetTWinControlTabStop(AMachine: TatVirtualMachine);
    procedure __SetTWinControlTabStop(AMachine: TatVirtualMachine);
    procedure __GetTWinControlUseDockManager(AMachine: TatVirtualMachine);
    procedure __SetTWinControlUseDockManager(AMachine: TatVirtualMachine);
    procedure __TGraphicControlCreate(AMachine: TatVirtualMachine);
    procedure __TGraphicControlDestroy(AMachine: TatVirtualMachine);
    procedure __TCustomControlCreate(AMachine: TatVirtualMachine);
    procedure __TCustomControlDestroy(AMachine: TatVirtualMachine);
    procedure __THintWindowCreate(AMachine: TatVirtualMachine);
    procedure __THintWindowActivateHint(AMachine: TatVirtualMachine);
    procedure __THintWindowIsHintMsg(AMachine: TatVirtualMachine);
    procedure __THintWindowShouldHideHint(AMachine: TatVirtualMachine);
    procedure __THintWindowReleaseHandle(AMachine: TatVirtualMachine);
    procedure __TDragImageListBeginDrag(AMachine: TatVirtualMachine);
    procedure __TDragImageListDragLock(AMachine: TatVirtualMachine);
    procedure __TDragImageListDragMove(AMachine: TatVirtualMachine);
    procedure __TDragImageListDragUnlock(AMachine: TatVirtualMachine);
    procedure __TDragImageListEndDrag(AMachine: TatVirtualMachine);
    procedure __TDragImageListGetHotSpot(AMachine: TatVirtualMachine);
    procedure __TDragImageListHideDragImage(AMachine: TatVirtualMachine);
    procedure __TDragImageListSetDragImage(AMachine: TatVirtualMachine);
    procedure __TDragImageListShowDragImage(AMachine: TatVirtualMachine);
    procedure __GetTDragImageListDragCursor(AMachine: TatVirtualMachine);
    procedure __SetTDragImageListDragCursor(AMachine: TatVirtualMachine);
    procedure __GetTDragImageListDragHotspot(AMachine: TatVirtualMachine);
    procedure __SetTDragImageListDragHotspot(AMachine: TatVirtualMachine);
    procedure __GetTDragImageListDragging(AMachine: TatVirtualMachine);
    procedure __TDockZoneCreate(AMachine: TatVirtualMachine);
    procedure __TDockZoneExpandZoneLimit(AMachine: TatVirtualMachine);
    procedure __TDockZoneFirstVisibleChild(AMachine: TatVirtualMachine);
    procedure __TDockZoneNextVisible(AMachine: TatVirtualMachine);
    procedure __TDockZonePrevVisible(AMachine: TatVirtualMachine);
    procedure __TDockZoneResetChildren(AMachine: TatVirtualMachine);
    procedure __TDockZoneResetZoneLimits(AMachine: TatVirtualMachine);
    procedure __TDockZoneUpdate(AMachine: TatVirtualMachine);
    procedure __GetTDockZoneChildCount(AMachine: TatVirtualMachine);
    procedure __GetTDockZoneChildControl(AMachine: TatVirtualMachine);
    procedure __GetTDockZoneHeight(AMachine: TatVirtualMachine);
    procedure __GetTDockZoneLeft(AMachine: TatVirtualMachine);
    procedure __GetTDockZoneLimitBegin(AMachine: TatVirtualMachine);
    procedure __GetTDockZoneLimitSize(AMachine: TatVirtualMachine);
    procedure __GetTDockZoneTop(AMachine: TatVirtualMachine);
    procedure __GetTDockZoneVisible(AMachine: TatVirtualMachine);
    procedure __GetTDockZoneVisibleChildCount(AMachine: TatVirtualMachine);
    procedure __GetTDockZoneWidth(AMachine: TatVirtualMachine);
    procedure __GetTDockZoneZoneLimit(AMachine: TatVirtualMachine);
    procedure __SetTDockZoneZoneLimit(AMachine: TatVirtualMachine);
    procedure __TDockTreeCreate(AMachine: TatVirtualMachine);
    procedure __TDockTreeDestroy(AMachine: TatVirtualMachine);
    procedure __TDockTreePaintSite(AMachine: TatVirtualMachine);
    procedure __TMouseCreate(AMachine: TatVirtualMachine);
    procedure __TMouseDestroy(AMachine: TatVirtualMachine);
    procedure __TMouseSettingChanged(AMachine: TatVirtualMachine);
    procedure __GetTMouseCapture(AMachine: TatVirtualMachine);
    procedure __SetTMouseCapture(AMachine: TatVirtualMachine);
    procedure __GetTMouseCursorPos(AMachine: TatVirtualMachine);
    procedure __SetTMouseCursorPos(AMachine: TatVirtualMachine);
    procedure __GetTMouseDragImmediate(AMachine: TatVirtualMachine);
    procedure __SetTMouseDragImmediate(AMachine: TatVirtualMachine);
    procedure __GetTMouseDragThreshold(AMachine: TatVirtualMachine);
    procedure __SetTMouseDragThreshold(AMachine: TatVirtualMachine);
    procedure __GetTMouseMousePresent(AMachine: TatVirtualMachine);
    procedure __GetTMouseIsDragging(AMachine: TatVirtualMachine);
    procedure __GetTMouseRegWheelMessage(AMachine: TatVirtualMachine);
    procedure __GetTMouseWheelPresent(AMachine: TatVirtualMachine);
    procedure __GetTMouseWheelScrollLines(AMachine: TatVirtualMachine);
    procedure __TCustomListControlAddItem(AMachine: TatVirtualMachine);
    procedure __TCustomListControlClear(AMachine: TatVirtualMachine);
    procedure __TCustomListControlClearSelection(AMachine: TatVirtualMachine);
    procedure __TCustomListControlCopySelection(AMachine: TatVirtualMachine);
    procedure __TCustomListControlDeleteSelected(AMachine: TatVirtualMachine);
    procedure __TCustomListControlMoveSelection(AMachine: TatVirtualMachine);
    procedure __TCustomListControlSelectAll(AMachine: TatVirtualMachine);
    procedure __GetTCustomListControlItemIndex(AMachine: TatVirtualMachine);
    procedure __SetTCustomListControlItemIndex(AMachine: TatVirtualMachine);
    procedure __GetTCustomMultiSelectListControlMultiSelect(AMachine: TatVirtualMachine);
    procedure __SetTCustomMultiSelectListControlMultiSelect(AMachine: TatVirtualMachine);
    procedure __GetTCustomMultiSelectListControlSelCount(AMachine: TatVirtualMachine);
    procedure __IsPositiveResult(AMachine: TatVirtualMachine);
    procedure __IsNegativeResult(AMachine: TatVirtualMachine);
    procedure __IsAbortResult(AMachine: TatVirtualMachine);
    procedure __IsAnAllResult(AMachine: TatVirtualMachine);
    procedure __StripAllFromResult(AMachine: TatVirtualMachine);
    procedure __IsDragObject(AMachine: TatVirtualMachine);
    procedure __FindControl(AMachine: TatVirtualMachine);
    procedure __FindVCLWindow(AMachine: TatVirtualMachine);
    procedure __FindDragTarget(AMachine: TatVirtualMachine);
    procedure __GetCaptureControl(AMachine: TatVirtualMachine);
    procedure __SetCaptureControl(AMachine: TatVirtualMachine);
    procedure __CancelDrag(AMachine: TatVirtualMachine);
    procedure __CursorToString(AMachine: TatVirtualMachine);
    procedure __StringToCursor(AMachine: TatVirtualMachine);
    procedure __CursorToIdent(AMachine: TatVirtualMachine);
    procedure __IdentToCursor(AMachine: TatVirtualMachine);
    procedure __GetShortHint(AMachine: TatVirtualMachine);
    procedure __GetLongHint(AMachine: TatVirtualMachine);
    procedure __PerformEraseBackground(AMachine: TatVirtualMachine);
    procedure __InitWndProc(AMachine: TatVirtualMachine);
    procedure __ChangeBiDiModeAlignment(AMachine: TatVirtualMachine);
    procedure __SendAppMessage(AMachine: TatVirtualMachine);
    procedure __MoveWindowOrg(AMachine: TatVirtualMachine);
    procedure __SetImeMode(AMachine: TatVirtualMachine);
    procedure __SetImeName(AMachine: TatVirtualMachine);
    procedure __Win32NLSEnableIME(AMachine: TatVirtualMachine);
    procedure __Imm32GetContext(AMachine: TatVirtualMachine);
    procedure __Imm32ReleaseContext(AMachine: TatVirtualMachine);
    procedure __Imm32GetConversionStatus(AMachine: TatVirtualMachine);
    procedure __Imm32SetConversionStatus(AMachine: TatVirtualMachine);
    procedure __Imm32SetOpenStatus(AMachine: TatVirtualMachine);
    procedure __Imm32IsIME(AMachine: TatVirtualMachine);
    procedure __Imm32NotifyIME(AMachine: TatVirtualMachine);
    procedure __DragDone(AMachine: TatVirtualMachine);
    procedure __GetMouse(AMachine: TatVirtualMachine);
    procedure __SetMouse(AMachine: TatVirtualMachine);
    procedure __GetCreationControl(AMachine: TatVirtualMachine);
    procedure __SetCreationControl(AMachine: TatVirtualMachine);
    procedure __GetNewStyleControls(AMachine: TatVirtualMachine);
    procedure __SetNewStyleControls(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TDragObjectClass = class of TDragObject;
  TDragObjectExClass = class of TDragObjectEx;
  TBaseDragControlObjectClass = class of TBaseDragControlObject;
  TDragControlObjectClass = class of TDragControlObject;
  TDragControlObjectExClass = class of TDragControlObjectEx;
  TDragDockObjectClass = class of TDragDockObject;
  TDragDockObjectExClass = class of TDragDockObjectEx;
  TControlCanvasClass = class of TControlCanvas;
  TCustomControlActionClass = class of TCustomControlAction;
  TControlActionClass = class of TControlAction;
  TControlActionLinkClass = class of TControlActionLink;
  TSizeConstraintsClass = class of TSizeConstraints;
  TControlClass = class of TControl;
  TWinControlActionLinkClass = class of TWinControlActionLink;
  TWinControlClass = class of TWinControl;
  TGraphicControlClass = class of TGraphicControl;
  TCustomControlClass = class of TCustomControl;
  THintWindowClass = class of THintWindow;
  TDragImageListClass = class of TDragImageList;
  TImageListClass = class of TImageList;
  TDockZoneClass = class of TDockZone;
  TDockTreeClass = class of TDockTree;
  TMouseClass = class of TMouse;
  TCustomListControlClass = class of TCustomListControl;
  TCustomMultiSelectListControlClass = class of TCustomMultiSelectListControl;

  TatControlsDispatcher = class(TatEventDispatcher)
  private
    procedure __TMouseEvent( Sender: TObject;  Button: TMouseButton;  Shift: TShiftState;  X: Integer;  Y: Integer);
    procedure __TMouseMoveEvent( Sender: TObject;  Shift: TShiftState;  X: Integer;  Y: Integer);
    procedure __TMouseActivateEvent( Sender: TObject;  Button: TMouseButton;  Shift: TShiftState;  X: Integer;  Y: Integer;  HitTest: Integer; var MouseActivate: TMouseActivate);
    procedure __TKeyEvent( Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure __TKeyPressEvent( Sender: TObject; var Key: Char);
    procedure __TDragOverEvent( Sender: TObject;  Source: TObject;  X: Integer;  Y: Integer;  State: TDragState; var Accept: Boolean);
    procedure __TDragDropEvent( Sender: TObject;  Source: TObject;  X: Integer;  Y: Integer);
    procedure __TStartDragEvent( Sender: TObject; var DragObject: TDragObject);
    procedure __TEndDragEvent( Sender: TObject;  Target: TObject;  X: Integer;  Y: Integer);
    procedure __TDockDropEvent( Sender: TObject;  Source: TDragDockObject;  X: Integer;  Y: Integer);
    procedure __TDockOverEvent( Sender: TObject;  Source: TDragDockObject;  X: Integer;  Y: Integer;  State: TDragState; var Accept: Boolean);
    procedure __TUnDockEvent( Sender: TObject;  Client: TControl;  NewTarget: TWinControl; var Allow: Boolean);
    procedure __TStartDockEvent( Sender: TObject; var DragObject: TDragDockObject);
    procedure __TCanResizeEvent( Sender: TObject; var NewWidth: Integer; var NewHeight: Integer; var Resize: Boolean);
    procedure __TConstrainedResizeEvent( Sender: TObject; var MinWidth: Integer; var MinHeight: Integer; var MaxWidth: Integer; var MaxHeight: Integer);
    function __TAlignInsertBeforeEvent( Sender: TWinControl;  C1: TControl;  C2: TControl): Boolean;
    procedure __TForEachZoneProc( Zone: TDockZone);
  end;

  TCMMouseWheelWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FShiftState: TShiftState;
    FUnused: Byte;
    FWheelDelta: SmallInt;
    FXPos: Smallint;
    FYPos: Smallint;
    FResult: Longint;
  public
    constructor Create(ARecord: TCMMouseWheel);
    function ObjToRec: TCMMouseWheel;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property ShiftState: TShiftState read FShiftState write FShiftState;
    property Unused: Byte read FUnused write FUnused;
    property WheelDelta: SmallInt read FWheelDelta write FWheelDelta;
    property XPos: Smallint read FXPos write FXPos;
    property YPos: Smallint read FYPos write FYPos;
    property Result: Longint read FResult write FResult;
  end;
  
  TCMCancelModeWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FUnused: Integer;
    FSender: TControl;
    FResult: Longint;
  public
    constructor Create(ARecord: TCMCancelMode);
    function ObjToRec: TCMCancelMode;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Unused: Integer read FUnused write FUnused;
    property Sender: TControl read FSender write FSender;
    property Result: Longint read FResult write FResult;
  end;
  
  TCMFocusChangedWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FUnused: Integer;
    FSender: TWinControl;
    FResult: Longint;
  public
    constructor Create(ARecord: TCMFocusChanged);
    function ObjToRec: TCMFocusChanged;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Unused: Integer read FUnused write FUnused;
    property Sender: TWinControl read FSender write FSender;
    property Result: Longint read FResult write FResult;
  end;
  
  TCMControlListChangeWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FControl: TControl;
    FInserting: LongBool;
    FResult: Longint;
  public
    constructor Create(ARecord: TCMControlListChange);
    function ObjToRec: TCMControlListChange;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Control: TControl read FControl write FControl;
    property Inserting: LongBool read FInserting write FInserting;
    property Result: Longint read FResult write FResult;
  end;
  
  TCMChildKeyWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FCharCode: Word;
    FUnused: Word;
    FSender: TWinControl;
    FResult: Longint;
  public
    constructor Create(ARecord: TCMChildKey);
    function ObjToRec: TCMChildKey;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property CharCode: Word read FCharCode write FCharCode;
    property Unused: Word read FUnused write FUnused;
    property Sender: TWinControl read FSender write FSender;
    property Result: Longint read FResult write FResult;
  end;
  
  TCMControlChangeWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FControl: TControl;
    FInserting: LongBool;
    FResult: Longint;
  public
    constructor Create(ARecord: TCMControlChange);
    function ObjToRec: TCMControlChange;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Control: TControl read FControl write FControl;
    property Inserting: LongBool read FInserting write FInserting;
    property Result: Longint read FResult write FResult;
  end;
  
  TCMChangedWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FUnused: Longint;
    FChild: TControl;
    FResult: Longint;
  public
    constructor Create(ARecord: TCMChanged);
    function ObjToRec: TCMChanged;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Unused: Longint read FUnused write FUnused;
    property Child: TControl read FChild write FChild;
    property Result: Longint read FResult write FResult;
  end;
  
  TDragRecWrapper = class(TatRecordWrapper)
  private
    FSource: TDragObject;
    FDocking: Boolean;
  public
    constructor Create(ARecord: TDragRec);
    function ObjToRec: TDragRec;
  published
    property Source: TDragObject read FSource write FSource;
    property Docking: Boolean read FDocking write FDocking;
  end;
  
  TCMDragWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FDragMessage: TDragMessage;
    FReserved1: Byte;
    FReserved2: Word;
    FResult: Longint;
  public
    constructor Create(ARecord: TCMDrag);
    function ObjToRec: TCMDrag;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property DragMessage: TDragMessage read FDragMessage write FDragMessage;
    property Reserved1: Byte read FReserved1 write FReserved1;
    property Reserved2: Word read FReserved2 write FReserved2;
    property Result: Longint read FResult write FResult;
  end;
  
  TCMDockClientWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FDockSource: TDragDockObject;
    FResult: Integer;
  public
    constructor Create(ARecord: TCMDockClient);
    function ObjToRec: TCMDockClient;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property DockSource: TDragDockObject read FDockSource write FDockSource;
    property Result: Integer read FResult write FResult;
  end;
  
  TCMUnDockClientWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FNewTarget: TControl;
    FClient: TControl;
    FResult: Integer;
  public
    constructor Create(ARecord: TCMUnDockClient);
    function ObjToRec: TCMUnDockClient;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property NewTarget: TControl read FNewTarget write FNewTarget;
    property Client: TControl read FClient write FClient;
    property Result: Integer read FResult write FResult;
  end;
  
  TCMFloatWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FReserved: Integer;
    FDockSource: TDragDockObject;
    FResult: Integer;
  public
    constructor Create(ARecord: TCMFloat);
    function ObjToRec: TCMFloat;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Reserved: Integer read FReserved write FReserved;
    property DockSource: TDragDockObject read FDockSource write FDockSource;
    property Result: Integer read FResult write FResult;
  end;
  
  TDockNotifyRecWrapper = class(TatRecordWrapper)
  private
    FClientMsg: Cardinal;
    FMsgWParam: Integer;
    FMsgLParam: Integer;
  public
    constructor Create(ARecord: TDockNotifyRec);
    function ObjToRec: TDockNotifyRec;
  published
    property ClientMsg: Cardinal read FClientMsg write FClientMsg;
    property MsgWParam: Integer read FMsgWParam write FMsgWParam;
    property MsgLParam: Integer read FMsgLParam write FMsgLParam;
  end;
  
  TCMDockNotificationWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FClient: TControl;
    FResult: Integer;
  public
    constructor Create(ARecord: TCMDockNotification);
    function ObjToRec: TCMDockNotification;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Client: TControl read FClient write FClient;
    property Result: Integer read FResult write FResult;
  end;
  
  TPopupFormInfoWrapper = class(TatRecordWrapper)
  private
    FPopupID: Integer;
    FPopupWnd: HWND;
    FIsPopup: Boolean;
  public
    constructor Create(ARecord: TPopupFormInfo);
    function ObjToRec: TPopupFormInfo;
  published
    property PopupID: Integer read FPopupID write FPopupID;
    property PopupWnd: HWND read FPopupWnd write FPopupWnd;
    property IsPopup: Boolean read FIsPopup write FIsPopup;
  end;
  
  TCMPopupHWndDestroyWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FPopupControlWnd: HWND;
    FResult: Integer;
  public
    constructor Create(ARecord: TCMPopupHWndDestroy);
    function ObjToRec: TCMPopupHWndDestroy;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property PopupControlWnd: HWND read FPopupControlWnd write FPopupControlWnd;
    property Result: Integer read FResult write FResult;
  end;
  
  TCMCreatePopupWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FPopupID: Integer;
    FOwnerWnd: HWND;
    FResult: Integer;
  public
    constructor Create(ARecord: TCMCreatePopup);
    function ObjToRec: TCMCreatePopup;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property PopupID: Integer read FPopupID write FPopupID;
    property OwnerWnd: HWND read FOwnerWnd write FOwnerWnd;
    property Result: Integer read FResult write FResult;
  end;
  
  TMouseActivateRecWrapper = class(TatRecordWrapper)
  private
    FHitTest: Integer;
    FButton: TMouseButton;
    FShiftState: TShiftState;
    FTopLevel: HWND;
  public
    constructor Create(ARecord: TMouseActivateRec);
    function ObjToRec: TMouseActivateRec;
  published
    property HitTest: Integer read FHitTest write FHitTest;
    property Button: TMouseButton read FButton write FButton;
    property ShiftState: TShiftState read FShiftState write FShiftState;
    property TopLevel: HWND read FTopLevel write FTopLevel;
  end;
  
  TCMMouseActivateWrapper = class(TatRecordWrapper)
  private
    FMsg: Cardinal;
    FReserved: Integer;
    FResult: Integer;
  public
    constructor Create(ARecord: TCMMouseActivate);
    function ObjToRec: TCMMouseActivate;
  published
    property Msg: Cardinal read FMsg write FMsg;
    property Reserved: Integer read FReserved write FReserved;
    property Result: Integer read FResult write FResult;
  end;
  
  TCreateParamsWrapper = class(TatRecordWrapper)
  private
    FStyle: DWORD;
    FExStyle: DWORD;
    FX: Integer;
    FY: Integer;
    FWidth: Integer;
    FHeight: Integer;
    FWndParent: HWnd;
  public
    constructor Create(ARecord: TCreateParams);
    function ObjToRec: TCreateParams;
  published
    property Style: DWORD read FStyle write FStyle;
    property ExStyle: DWORD read FExStyle write FExStyle;
    property X: Integer read FX write FX;
    property Y: Integer read FY write FY;
    property Width: Integer read FWidth write FWidth;
    property Height: Integer read FHeight write FHeight;
    property WndParent: HWnd read FWndParent write FWndParent;
  end;
  
  TAlignInfoWrapper = class(TatRecordWrapper)
  private
    FAlignList: TList;
    FControlIndex: Integer;
    FAlign: TAlign;
    FScratch: Integer;
  public
    constructor Create(ARecord: TAlignInfo);
    function ObjToRec: TAlignInfo;
  published
    property AlignList: TList read FAlignList write FAlignList;
    property ControlIndex: Integer read FControlIndex write FControlIndex;
    property Align: TAlign read FAlign write FAlign;
    property Scratch: Integer read FScratch write FScratch;
  end;
  

implementation

constructor TCMMouseWheelWrapper.Create(ARecord: TCMMouseWheel);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FShiftState := ARecord.ShiftState;
  FUnused := ARecord.Unused;
  FWheelDelta := ARecord.WheelDelta;
  FXPos := ARecord.XPos;
  FYPos := ARecord.YPos;
  FResult := ARecord.Result;
end;

function TCMMouseWheelWrapper.ObjToRec: TCMMouseWheel;
begin
  result.Msg := FMsg;
  result.ShiftState := FShiftState;
  result.Unused := FUnused;
  result.WheelDelta := FWheelDelta;
  result.XPos := FXPos;
  result.YPos := FYPos;
  result.Result := FResult;
end;

constructor TCMCancelModeWrapper.Create(ARecord: TCMCancelMode);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FUnused := ARecord.Unused;
  FSender := ARecord.Sender;
  FResult := ARecord.Result;
end;

function TCMCancelModeWrapper.ObjToRec: TCMCancelMode;
begin
  result.Msg := FMsg;
  result.Unused := FUnused;
  result.Sender := FSender;
  result.Result := FResult;
end;

constructor TCMFocusChangedWrapper.Create(ARecord: TCMFocusChanged);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FUnused := ARecord.Unused;
  FSender := ARecord.Sender;
  FResult := ARecord.Result;
end;

function TCMFocusChangedWrapper.ObjToRec: TCMFocusChanged;
begin
  result.Msg := FMsg;
  result.Unused := FUnused;
  result.Sender := FSender;
  result.Result := FResult;
end;

constructor TCMControlListChangeWrapper.Create(ARecord: TCMControlListChange);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FControl := ARecord.Control;
  FInserting := ARecord.Inserting;
  FResult := ARecord.Result;
end;

function TCMControlListChangeWrapper.ObjToRec: TCMControlListChange;
begin
  result.Msg := FMsg;
  result.Control := FControl;
  result.Inserting := FInserting;
  result.Result := FResult;
end;

constructor TCMChildKeyWrapper.Create(ARecord: TCMChildKey);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FCharCode := ARecord.CharCode;
  FUnused := ARecord.Unused;
  FSender := ARecord.Sender;
  FResult := ARecord.Result;
end;

function TCMChildKeyWrapper.ObjToRec: TCMChildKey;
begin
  result.Msg := FMsg;
  result.CharCode := FCharCode;
  result.Unused := FUnused;
  result.Sender := FSender;
  result.Result := FResult;
end;

constructor TCMControlChangeWrapper.Create(ARecord: TCMControlChange);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FControl := ARecord.Control;
  FInserting := ARecord.Inserting;
  FResult := ARecord.Result;
end;

function TCMControlChangeWrapper.ObjToRec: TCMControlChange;
begin
  result.Msg := FMsg;
  result.Control := FControl;
  result.Inserting := FInserting;
  result.Result := FResult;
end;

constructor TCMChangedWrapper.Create(ARecord: TCMChanged);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FUnused := ARecord.Unused;
  FChild := ARecord.Child;
  FResult := ARecord.Result;
end;

function TCMChangedWrapper.ObjToRec: TCMChanged;
begin
  result.Msg := FMsg;
  result.Unused := FUnused;
  result.Child := FChild;
  result.Result := FResult;
end;

constructor TDragRecWrapper.Create(ARecord: TDragRec);
begin
  inherited Create;
  FSource := ARecord.Source;
  FDocking := ARecord.Docking;
end;

function TDragRecWrapper.ObjToRec: TDragRec;
begin
  result.Source := FSource;
  result.Docking := FDocking;
end;

constructor TCMDragWrapper.Create(ARecord: TCMDrag);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FDragMessage := ARecord.DragMessage;
  FReserved1 := ARecord.Reserved1;
  FReserved2 := ARecord.Reserved2;
  FResult := ARecord.Result;
end;

function TCMDragWrapper.ObjToRec: TCMDrag;
begin
  result.Msg := FMsg;
  result.DragMessage := FDragMessage;
  result.Reserved1 := FReserved1;
  result.Reserved2 := FReserved2;
  result.Result := FResult;
end;

constructor TCMDockClientWrapper.Create(ARecord: TCMDockClient);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FDockSource := ARecord.DockSource;
  FResult := ARecord.Result;
end;

function TCMDockClientWrapper.ObjToRec: TCMDockClient;
begin
  result.Msg := FMsg;
  result.DockSource := FDockSource;
  result.Result := FResult;
end;

constructor TCMUnDockClientWrapper.Create(ARecord: TCMUnDockClient);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FNewTarget := ARecord.NewTarget;
  FClient := ARecord.Client;
  FResult := ARecord.Result;
end;

function TCMUnDockClientWrapper.ObjToRec: TCMUnDockClient;
begin
  result.Msg := FMsg;
  result.NewTarget := FNewTarget;
  result.Client := FClient;
  result.Result := FResult;
end;

constructor TCMFloatWrapper.Create(ARecord: TCMFloat);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FReserved := ARecord.Reserved;
  FDockSource := ARecord.DockSource;
  FResult := ARecord.Result;
end;

function TCMFloatWrapper.ObjToRec: TCMFloat;
begin
  result.Msg := FMsg;
  result.Reserved := FReserved;
  result.DockSource := FDockSource;
  result.Result := FResult;
end;

constructor TDockNotifyRecWrapper.Create(ARecord: TDockNotifyRec);
begin
  inherited Create;
  FClientMsg := ARecord.ClientMsg;
  FMsgWParam := ARecord.MsgWParam;
  FMsgLParam := ARecord.MsgLParam;
end;

function TDockNotifyRecWrapper.ObjToRec: TDockNotifyRec;
begin
  result.ClientMsg := FClientMsg;
  result.MsgWParam := FMsgWParam;
  result.MsgLParam := FMsgLParam;
end;

constructor TCMDockNotificationWrapper.Create(ARecord: TCMDockNotification);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FClient := ARecord.Client;
  FResult := ARecord.Result;
end;

function TCMDockNotificationWrapper.ObjToRec: TCMDockNotification;
begin
  result.Msg := FMsg;
  result.Client := FClient;
  result.Result := FResult;
end;

constructor TPopupFormInfoWrapper.Create(ARecord: TPopupFormInfo);
begin
  inherited Create;
  FPopupID := ARecord.PopupID;
  FPopupWnd := ARecord.PopupWnd;
  FIsPopup := ARecord.IsPopup;
end;

function TPopupFormInfoWrapper.ObjToRec: TPopupFormInfo;
begin
  result.PopupID := FPopupID;
  result.PopupWnd := FPopupWnd;
  result.IsPopup := FIsPopup;
end;

constructor TCMPopupHWndDestroyWrapper.Create(ARecord: TCMPopupHWndDestroy);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FPopupControlWnd := ARecord.PopupControlWnd;
  FResult := ARecord.Result;
end;

function TCMPopupHWndDestroyWrapper.ObjToRec: TCMPopupHWndDestroy;
begin
  result.Msg := FMsg;
  result.PopupControlWnd := FPopupControlWnd;
  result.Result := FResult;
end;

constructor TCMCreatePopupWrapper.Create(ARecord: TCMCreatePopup);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FPopupID := ARecord.PopupID;
  FOwnerWnd := ARecord.OwnerWnd;
  FResult := ARecord.Result;
end;

function TCMCreatePopupWrapper.ObjToRec: TCMCreatePopup;
begin
  result.Msg := FMsg;
  result.PopupID := FPopupID;
  result.OwnerWnd := FOwnerWnd;
  result.Result := FResult;
end;

constructor TMouseActivateRecWrapper.Create(ARecord: TMouseActivateRec);
begin
  inherited Create;
  FHitTest := ARecord.HitTest;
  FButton := ARecord.Button;
  FShiftState := ARecord.ShiftState;
  FTopLevel := ARecord.TopLevel;
end;

function TMouseActivateRecWrapper.ObjToRec: TMouseActivateRec;
begin
  result.HitTest := FHitTest;
  result.Button := FButton;
  result.ShiftState := FShiftState;
  result.TopLevel := FTopLevel;
end;

constructor TCMMouseActivateWrapper.Create(ARecord: TCMMouseActivate);
begin
  inherited Create;
  FMsg := ARecord.Msg;
  FReserved := ARecord.Reserved;
  FResult := ARecord.Result;
end;

function TCMMouseActivateWrapper.ObjToRec: TCMMouseActivate;
begin
  result.Msg := FMsg;
  result.Reserved := FReserved;
  result.Result := FResult;
end;

constructor TCreateParamsWrapper.Create(ARecord: TCreateParams);
begin
  inherited Create;
  FStyle := ARecord.Style;
  FExStyle := ARecord.ExStyle;
  FX := ARecord.X;
  FY := ARecord.Y;
  FWidth := ARecord.Width;
  FHeight := ARecord.Height;
  FWndParent := ARecord.WndParent;
end;

function TCreateParamsWrapper.ObjToRec: TCreateParams;
begin
  result.Style := FStyle;
  result.ExStyle := FExStyle;
  result.X := FX;
  result.Y := FY;
  result.Width := FWidth;
  result.Height := FHeight;
  result.WndParent := FWndParent;
end;

constructor TAlignInfoWrapper.Create(ARecord: TAlignInfo);
begin
  inherited Create;
  FAlignList := ARecord.AlignList;
  FControlIndex := ARecord.ControlIndex;
  FAlign := ARecord.Align;
  FScratch := ARecord.Scratch;
end;

function TAlignInfoWrapper.ObjToRec: TAlignInfo;
begin
  result.AlignList := FAlignList;
  result.ControlIndex := FControlIndex;
  result.Align := FAlign;
  result.Scratch := FScratch;
end;



procedure TatControlsLibrary.__TDragObjectAfterConstruction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDragObject(CurrentObject).AfterConstruction;
  end;
end;

procedure TatControlsLibrary.__TDragObjectAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDragObject(CurrentObject).Assign(TDragObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatControlsLibrary.__TDragObjectBeforeDestruction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDragObject(CurrentObject).BeforeDestruction;
  end;
end;

procedure TatControlsLibrary.__TDragObjectGetName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDragObject(CurrentObject).GetName;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TDragObjectHideDragImage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDragObject(CurrentObject).HideDragImage;
  end;
end;

procedure TatControlsLibrary.__TDragObjectInstance(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDragObject(CurrentObject).Instance);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TDragObjectShowDragImage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDragObject(CurrentObject).ShowDragImage;
  end;
end;

procedure TatControlsLibrary.__GetTDragObjectAlwaysShowDragImages(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDragObject(CurrentObject).AlwaysShowDragImages);
  end;
end;

procedure TatControlsLibrary.__SetTDragObjectAlwaysShowDragImages(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDragObject(CurrentObject).AlwaysShowDragImages:=GetInputArg(0);
  end;
end;

procedure TatControlsLibrary.__GetTDragObjectCancelling(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDragObject(CurrentObject).Cancelling);
  end;
end;

procedure TatControlsLibrary.__SetTDragObjectCancelling(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDragObject(CurrentObject).Cancelling:=GetInputArg(0);
  end;
end;

procedure TatControlsLibrary.__GetTDragObjectDragHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDragObject(CurrentObject).DragHandle));
  end;
end;

procedure TatControlsLibrary.__SetTDragObjectDragHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDragObject(CurrentObject).DragHandle:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatControlsLibrary.__GetTDragObjectDragPos(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TPointWrapper.Create(TDragObject(CurrentObject).DragPos)));
  end;
end;

procedure TatControlsLibrary.__SetTDragObjectDragPos(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDragObject(CurrentObject).DragPos:=TPointWrapper(integer(GetInputArg(0))).ObjToRec;
  end;
end;

procedure TatControlsLibrary.__GetTDragObjectDragTargetPos(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TPointWrapper.Create(TDragObject(CurrentObject).DragTargetPos)));
  end;
end;

procedure TatControlsLibrary.__SetTDragObjectDragTargetPos(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDragObject(CurrentObject).DragTargetPos:=TPointWrapper(integer(GetInputArg(0))).ObjToRec;
  end;
end;

procedure TatControlsLibrary.__GetTDragObjectDropped(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDragObject(CurrentObject).Dropped);
  end;
end;

procedure TatControlsLibrary.__GetTDragObjectMouseDeltaX(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDragObject(CurrentObject).MouseDeltaX);
  end;
end;

procedure TatControlsLibrary.__GetTDragObjectMouseDeltaY(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDragObject(CurrentObject).MouseDeltaY);
  end;
end;

procedure TatControlsLibrary.__GetTDragObjectRightClickCancels(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDragObject(CurrentObject).RightClickCancels);
  end;
end;

procedure TatControlsLibrary.__SetTDragObjectRightClickCancels(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDragObject(CurrentObject).RightClickCancels:=GetInputArg(0);
  end;
end;

procedure TatControlsLibrary.__TDragObjectExBeforeDestruction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDragObjectEx(CurrentObject).BeforeDestruction;
  end;
end;

procedure TatControlsLibrary.__TBaseDragControlObjectCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TBaseDragControlObjectClass(CurrentClass.ClassRef).Create(TControl(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TBaseDragControlObjectAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBaseDragControlObject(CurrentObject).Assign(TDragObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatControlsLibrary.__GetTBaseDragControlObjectControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TBaseDragControlObject(CurrentObject).Control));
  end;
end;

procedure TatControlsLibrary.__SetTBaseDragControlObjectControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TBaseDragControlObject(CurrentObject).Control:=TControl(Integer(GetInputArg(0)));
  end;
end;

procedure TatControlsLibrary.__TDragControlObjectHideDragImage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDragControlObject(CurrentObject).HideDragImage;
  end;
end;

procedure TatControlsLibrary.__TDragControlObjectShowDragImage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDragControlObject(CurrentObject).ShowDragImage;
  end;
end;

procedure TatControlsLibrary.__TDragControlObjectExBeforeDestruction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDragControlObjectEx(CurrentObject).BeforeDestruction;
  end;
end;

procedure TatControlsLibrary.__TDragDockObjectCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDragDockObjectClass(CurrentClass.ClassRef).Create(TControl(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TDragDockObjectDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDragDockObject(CurrentObject).Destroy;
  end;
end;

procedure TatControlsLibrary.__TDragDockObjectAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDragDockObject(CurrentObject).Assign(TDragObject(Integer(GetInputArg(0))));
  end;
end;

procedure TatControlsLibrary.__GetTDragDockObjectBrush(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDragDockObject(CurrentObject).Brush));
  end;
end;

procedure TatControlsLibrary.__SetTDragDockObjectBrush(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDragDockObject(CurrentObject).Brush:=TBrush(Integer(GetInputArg(0)));
  end;
end;

procedure TatControlsLibrary.__GetTDragDockObjectDockRect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TRectWrapper.Create(TDragDockObject(CurrentObject).DockRect)));
  end;
end;

procedure TatControlsLibrary.__SetTDragDockObjectDockRect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDragDockObject(CurrentObject).DockRect:=TRectWrapper(integer(GetInputArg(0))).ObjToRec;
  end;
end;

procedure TatControlsLibrary.__GetTDragDockObjectDropAlign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDragDockObject(CurrentObject).DropAlign);
  end;
end;

procedure TatControlsLibrary.__GetTDragDockObjectDropOnControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDragDockObject(CurrentObject).DropOnControl));
  end;
end;

procedure TatControlsLibrary.__GetTDragDockObjectFloating(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDragDockObject(CurrentObject).Floating);
  end;
end;

procedure TatControlsLibrary.__SetTDragDockObjectFloating(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDragDockObject(CurrentObject).Floating:=GetInputArg(0);
  end;
end;

procedure TatControlsLibrary.__GetTDragDockObjectFrameWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDragDockObject(CurrentObject).FrameWidth));
  end;
end;

procedure TatControlsLibrary.__TDragDockObjectExBeforeDestruction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDragDockObjectEx(CurrentObject).BeforeDestruction;
  end;
end;

procedure TatControlsLibrary.__TControlCanvasDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControlCanvas(CurrentObject).Destroy;
  end;
end;

procedure TatControlsLibrary.__TControlCanvasFreeHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControlCanvas(CurrentObject).FreeHandle;
  end;
end;

procedure TatControlsLibrary.__TControlCanvasUpdateTextFlags(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControlCanvas(CurrentObject).UpdateTextFlags;
  end;
end;

procedure TatControlsLibrary.__GetTControlCanvasControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TControlCanvas(CurrentObject).Control));
  end;
end;

procedure TatControlsLibrary.__SetTControlCanvasControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControlCanvas(CurrentObject).Control:=TControl(Integer(GetInputArg(0)));
  end;
end;

procedure TatControlsLibrary.__GetTCustomControlActionDropdownMenu(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomControlAction(CurrentObject).DropdownMenu));
  end;
end;

procedure TatControlsLibrary.__SetTCustomControlActionDropdownMenu(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomControlAction(CurrentObject).DropdownMenu:=TPopupMenu(Integer(GetInputArg(0)));
  end;
end;

procedure TatControlsLibrary.__GetTCustomControlActionEnableDropdown(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomControlAction(CurrentObject).EnableDropdown);
  end;
end;

procedure TatControlsLibrary.__SetTCustomControlActionEnableDropdown(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomControlAction(CurrentObject).EnableDropdown:=GetInputArg(0);
  end;
end;

procedure TatControlsLibrary.__GetTCustomControlActionPopupMenu(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomControlAction(CurrentObject).PopupMenu));
  end;
end;

procedure TatControlsLibrary.__SetTCustomControlActionPopupMenu(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomControlAction(CurrentObject).PopupMenu:=TPopupMenu(Integer(GetInputArg(0)));
  end;
end;

procedure TatControlsLibrary.__TSizeConstraintsCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TSizeConstraintsClass(CurrentClass.ClassRef).Create(TControl(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TControlCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TControlClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TControlDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControl(CurrentObject).Destroy;
  end;
end;

procedure TatControlsLibrary.__TControlBeginDrag(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      1: TControl(CurrentObject).BeginDrag(GetInputArg(0));
      2: TControl(CurrentObject).BeginDrag(GetInputArg(0),VarToInteger(GetInputArg(1)));
    end;
  end;
end;

procedure TatControlsLibrary.__TControlBringToFront(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControl(CurrentObject).BringToFront;
  end;
end;

procedure TatControlsLibrary.__TControlClientToScreen(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TPointWrapper.Create(TControl(CurrentObject).ClientToScreen(TPointWrapper(integer(GetInputArg(0))).ObjToRec)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TControlClientToParent(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := integer(TPointWrapper.Create(TControl(CurrentObject).ClientToParent(TPointWrapper(integer(GetInputArg(0))).ObjToRec)));
2: AResult := integer(TPointWrapper.Create(TControl(CurrentObject).ClientToParent(TPointWrapper(integer(GetInputArg(0))).ObjToRec,TWinControl(Integer(GetInputArg(1))))));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TControlDock(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControl(CurrentObject).Dock(TWinControl(Integer(GetInputArg(0))),TRectWrapper(integer(GetInputArg(1))).ObjToRec);
  end;
end;

procedure TatControlsLibrary.__TControlDefaultHandler(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    TControl(CurrentObject).DefaultHandler(Param0);
    SetInputArg(0,Param0);
  end;
end;

procedure TatControlsLibrary.__TControlDragging(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TControl(CurrentObject).Dragging;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TControlDragDrop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControl(CurrentObject).DragDrop(TObject(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatControlsLibrary.__TControlDrawTextBiDiModeFlags(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TControl(CurrentObject).DrawTextBiDiModeFlags(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TControlDrawTextBiDiModeFlagsReadingOnly(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TControl(CurrentObject).DrawTextBiDiModeFlagsReadingOnly);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TControlEndDrag(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControl(CurrentObject).EndDrag(GetInputArg(0));
  end;
end;

procedure TatControlsLibrary.__TControlGetControlsAlignment(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TControl(CurrentObject).GetControlsAlignment;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TControlGetParentComponent(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TControl(CurrentObject).GetParentComponent);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TControlGetTextBuf(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TControl(CurrentObject).GetTextBuf(PChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TControlGetTextLen(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TControl(CurrentObject).GetTextLen);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TControlHasParent(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TControl(CurrentObject).HasParent;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TControlHide(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControl(CurrentObject).Hide;
  end;
end;

procedure TatControlsLibrary.__TControlInitiateAction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControl(CurrentObject).InitiateAction;
  end;
end;

procedure TatControlsLibrary.__TControlInvalidate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControl(CurrentObject).Invalidate;
  end;
end;

procedure TatControlsLibrary.__TControlMouseWheelHandler(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TMessage;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TMessageWrapper) then 
  Param0Rec := TMessageWrapper.Create(Param0);
Param0 := TMessageWrapper(Param0Rec).ObjToRec;
    TControl(CurrentObject).MouseWheelHandler(Param0);
    SetInputArg(0,integer(TMessageWrapper.Create(Param0)));
  end;
end;

procedure TatControlsLibrary.__TControlIsRightToLeft(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TControl(CurrentObject).IsRightToLeft;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TControlManualDock(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := TControl(CurrentObject).ManualDock(TWinControl(Integer(GetInputArg(0))));
2: AResult := TControl(CurrentObject).ManualDock(TWinControl(Integer(GetInputArg(0))),TControl(Integer(GetInputArg(1))));
3: AResult := TControl(CurrentObject).ManualDock(TWinControl(Integer(GetInputArg(0))),TControl(Integer(GetInputArg(1))),GetInputArg(2));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TControlManualFloat(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TControl(CurrentObject).ManualFloat(TRectWrapper(integer(GetInputArg(0))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TControlPerform(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TControl(CurrentObject).Perform(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TControlRefresh(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControl(CurrentObject).Refresh;
  end;
end;

procedure TatControlsLibrary.__TControlRepaint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControl(CurrentObject).Repaint;
  end;
end;

procedure TatControlsLibrary.__TControlReplaceDockedControl(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TControl(CurrentObject).ReplaceDockedControl(TControl(Integer(GetInputArg(0))),TWinControl(Integer(GetInputArg(1))),TControl(Integer(GetInputArg(2))),GetInputArg(3));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TControlScreenToClient(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TPointWrapper.Create(TControl(CurrentObject).ScreenToClient(TPointWrapper(integer(GetInputArg(0))).ObjToRec)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TControlParentToClient(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := integer(TPointWrapper.Create(TControl(CurrentObject).ParentToClient(TPointWrapper(integer(GetInputArg(0))).ObjToRec)));
2: AResult := integer(TPointWrapper.Create(TControl(CurrentObject).ParentToClient(TPointWrapper(integer(GetInputArg(0))).ObjToRec,TWinControl(Integer(GetInputArg(1))))));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TControlSendToBack(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControl(CurrentObject).SendToBack;
  end;
end;

procedure TatControlsLibrary.__TControlSetBounds(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControl(CurrentObject).SetBounds(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatControlsLibrary.__TControlSetTextBuf(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControl(CurrentObject).SetTextBuf(PChar(VarToStr(GetInputArg(0))));
  end;
end;

procedure TatControlsLibrary.__TControlShow(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControl(CurrentObject).Show;
  end;
end;

procedure TatControlsLibrary.__TControlUpdate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControl(CurrentObject).Update;
  end;
end;

procedure TatControlsLibrary.__TControlUseRightToLeftAlignment(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TControl(CurrentObject).UseRightToLeftAlignment;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TControlUseRightToLeftReading(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TControl(CurrentObject).UseRightToLeftReading;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TControlUseRightToLeftScrollBar(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TControl(CurrentObject).UseRightToLeftScrollBar;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__GetTControlEnabled(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TControl(CurrentObject).Enabled);
  end;
end;

procedure TatControlsLibrary.__SetTControlEnabled(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControl(CurrentObject).Enabled:=GetInputArg(0);
  end;
end;

procedure TatControlsLibrary.__GetTControlAction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TControl(CurrentObject).Action));
  end;
end;

procedure TatControlsLibrary.__SetTControlAction(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControl(CurrentObject).Action:=TBasicAction(Integer(GetInputArg(0)));
  end;
end;

procedure TatControlsLibrary.__GetTControlAlign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TControl(CurrentObject).Align);
  end;
end;

procedure TatControlsLibrary.__SetTControlAlign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControl(CurrentObject).Align:=GetInputArg(0);
  end;
end;

procedure TatControlsLibrary.__GetTControlAnchors(AMachine: TatVirtualMachine);
var
PropValueSet: TAnchors;
begin
  with AMachine do
  begin
    PropValueSet := TControl(CurrentObject).Anchors;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatControlsLibrary.__SetTControlAnchors(AMachine: TatVirtualMachine);
  var
  TempVar: TAnchors;
begin
  with AMachine do
  begin
    IntToSet(TempVar, VarToInteger(GetInputArg(0)), SizeOf(TempVar));
    TControl(CurrentObject).Anchors:=TempVar;
  end;
end;

procedure TatControlsLibrary.__GetTControlBiDiMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TControl(CurrentObject).BiDiMode);
  end;
end;

procedure TatControlsLibrary.__SetTControlBiDiMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControl(CurrentObject).BiDiMode:=GetInputArg(0);
  end;
end;

procedure TatControlsLibrary.__GetTControlBoundsRect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TRectWrapper.Create(TControl(CurrentObject).BoundsRect)));
  end;
end;

procedure TatControlsLibrary.__SetTControlBoundsRect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControl(CurrentObject).BoundsRect:=TRectWrapper(integer(GetInputArg(0))).ObjToRec;
  end;
end;

procedure TatControlsLibrary.__GetTControlClientHeight(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TControl(CurrentObject).ClientHeight));
  end;
end;

procedure TatControlsLibrary.__SetTControlClientHeight(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControl(CurrentObject).ClientHeight:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatControlsLibrary.__GetTControlClientOrigin(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TPointWrapper.Create(TControl(CurrentObject).ClientOrigin)));
  end;
end;

procedure TatControlsLibrary.__GetTControlClientRect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TRectWrapper.Create(TControl(CurrentObject).ClientRect)));
  end;
end;

procedure TatControlsLibrary.__GetTControlClientWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TControl(CurrentObject).ClientWidth));
  end;
end;

procedure TatControlsLibrary.__SetTControlClientWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControl(CurrentObject).ClientWidth:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatControlsLibrary.__GetTControlConstraints(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TControl(CurrentObject).Constraints));
  end;
end;

procedure TatControlsLibrary.__SetTControlConstraints(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControl(CurrentObject).Constraints:=TSizeConstraints(Integer(GetInputArg(0)));
  end;
end;

procedure TatControlsLibrary.__GetTControlControlState(AMachine: TatVirtualMachine);
var
PropValueSet: TControlState;
begin
  with AMachine do
  begin
    PropValueSet := TControl(CurrentObject).ControlState;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatControlsLibrary.__SetTControlControlState(AMachine: TatVirtualMachine);
  var
  TempVar: TControlState;
begin
  with AMachine do
  begin
    IntToSet(TempVar, VarToInteger(GetInputArg(0)), SizeOf(TempVar));
    TControl(CurrentObject).ControlState:=TempVar;
  end;
end;

procedure TatControlsLibrary.__GetTControlControlStyle(AMachine: TatVirtualMachine);
var
PropValueSet: TControlStyle;
begin
  with AMachine do
  begin
    PropValueSet := TControl(CurrentObject).ControlStyle;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatControlsLibrary.__SetTControlControlStyle(AMachine: TatVirtualMachine);
  var
  TempVar: TControlStyle;
begin
  with AMachine do
  begin
    IntToSet(TempVar, VarToInteger(GetInputArg(0)), SizeOf(TempVar));
    TControl(CurrentObject).ControlStyle:=TempVar;
  end;
end;

procedure TatControlsLibrary.__GetTControlDockOrientation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TControl(CurrentObject).DockOrientation);
  end;
end;

procedure TatControlsLibrary.__SetTControlDockOrientation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControl(CurrentObject).DockOrientation:=GetInputArg(0);
  end;
end;

procedure TatControlsLibrary.__GetTControlFloating(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TControl(CurrentObject).Floating);
  end;
end;

procedure TatControlsLibrary.__GetTControlHostDockSite(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TControl(CurrentObject).HostDockSite));
  end;
end;

procedure TatControlsLibrary.__SetTControlHostDockSite(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControl(CurrentObject).HostDockSite:=TWinControl(Integer(GetInputArg(0)));
  end;
end;

procedure TatControlsLibrary.__GetTControlLRDockWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TControl(CurrentObject).LRDockWidth));
  end;
end;

procedure TatControlsLibrary.__SetTControlLRDockWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControl(CurrentObject).LRDockWidth:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatControlsLibrary.__GetTControlParent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TControl(CurrentObject).Parent));
  end;
end;

procedure TatControlsLibrary.__SetTControlParent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControl(CurrentObject).Parent:=TWinControl(Integer(GetInputArg(0)));
  end;
end;

procedure TatControlsLibrary.__GetTControlShowHint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TControl(CurrentObject).ShowHint);
  end;
end;

procedure TatControlsLibrary.__SetTControlShowHint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControl(CurrentObject).ShowHint:=GetInputArg(0);
  end;
end;

procedure TatControlsLibrary.__GetTControlTBDockHeight(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TControl(CurrentObject).TBDockHeight));
  end;
end;

procedure TatControlsLibrary.__SetTControlTBDockHeight(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControl(CurrentObject).TBDockHeight:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatControlsLibrary.__GetTControlUndockHeight(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TControl(CurrentObject).UndockHeight));
  end;
end;

procedure TatControlsLibrary.__SetTControlUndockHeight(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControl(CurrentObject).UndockHeight:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatControlsLibrary.__GetTControlUndockWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TControl(CurrentObject).UndockWidth));
  end;
end;

procedure TatControlsLibrary.__SetTControlUndockWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControl(CurrentObject).UndockWidth:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatControlsLibrary.__GetTControlVisible(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TControl(CurrentObject).Visible);
  end;
end;

procedure TatControlsLibrary.__SetTControlVisible(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TControl(CurrentObject).Visible:=GetInputArg(0);
  end;
end;

procedure TatControlsLibrary.__TWinControlCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TWinControlClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TWinControlCreateParented(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TWinControlClass(CurrentClass.ClassRef).CreateParented(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TWinControlCreateParentedControl(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TWinControlClass(CurrentClass.ClassRef).CreateParentedControl(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TWinControlDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWinControl(CurrentObject).Destroy;
  end;
end;

procedure TatControlsLibrary.__TWinControlBroadcast(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    TWinControl(CurrentObject).Broadcast(Param0);
    SetInputArg(0,Param0);
  end;
end;

procedure TatControlsLibrary.__TWinControlCanFocus(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TWinControl(CurrentObject).CanFocus;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TWinControlContainsControl(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TWinControl(CurrentObject).ContainsControl(TControl(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TWinControlControlAtPos(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
2: AResult := Integer(TWinControl(CurrentObject).ControlAtPos(TPointWrapper(integer(GetInputArg(0))).ObjToRec,GetInputArg(1)));
3: AResult := Integer(TWinControl(CurrentObject).ControlAtPos(TPointWrapper(integer(GetInputArg(0))).ObjToRec,GetInputArg(1),GetInputArg(2)));
4: AResult := Integer(TWinControl(CurrentObject).ControlAtPos(TPointWrapper(integer(GetInputArg(0))).ObjToRec,GetInputArg(1),GetInputArg(2),GetInputArg(3)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TWinControlDefaultHandler(AMachine: TatVirtualMachine);
  var
  Param0: Variant;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    TWinControl(CurrentObject).DefaultHandler(Param0);
    SetInputArg(0,Param0);
  end;
end;

procedure TatControlsLibrary.__TWinControlDisableAlign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWinControl(CurrentObject).DisableAlign;
  end;
end;

procedure TatControlsLibrary.__TWinControlDockDrop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWinControl(CurrentObject).DockDrop(TDragDockObject(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatControlsLibrary.__TWinControlEnableAlign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWinControl(CurrentObject).EnableAlign;
  end;
end;

procedure TatControlsLibrary.__TWinControlFindChildControl(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TWinControl(CurrentObject).FindChildControl(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TWinControlFlipChildren(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWinControl(CurrentObject).FlipChildren(GetInputArg(0));
  end;
end;

procedure TatControlsLibrary.__TWinControlFocused(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TWinControl(CurrentObject).Focused;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TWinControlGetTabOrderList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWinControl(CurrentObject).GetTabOrderList(TList(Integer(GetInputArg(0))));
  end;
end;

procedure TatControlsLibrary.__TWinControlHandleAllocated(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TWinControl(CurrentObject).HandleAllocated;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TWinControlHandleNeeded(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWinControl(CurrentObject).HandleNeeded;
  end;
end;

procedure TatControlsLibrary.__TWinControlInsertControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWinControl(CurrentObject).InsertControl(TControl(Integer(GetInputArg(0))));
  end;
end;

procedure TatControlsLibrary.__TWinControlInvalidate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWinControl(CurrentObject).Invalidate;
  end;
end;

procedure TatControlsLibrary.__TWinControlPaintTo(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWinControl(CurrentObject).PaintTo(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatControlsLibrary.__TWinControlPreProcessMessage(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TMsg;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagMSGWrapper) then 
  Param0Rec := tagMSGWrapper.Create(Param0);
Param0 := tagMSGWrapper(Param0Rec).ObjToRec;
AResult := TWinControl(CurrentObject).PreProcessMessage(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagMSGWrapper.Create(Param0)));
  end;
end;

procedure TatControlsLibrary.__TWinControlRemoveControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWinControl(CurrentObject).RemoveControl(TControl(Integer(GetInputArg(0))));
  end;
end;

procedure TatControlsLibrary.__TWinControlRealign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWinControl(CurrentObject).Realign;
  end;
end;

procedure TatControlsLibrary.__TWinControlRepaint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWinControl(CurrentObject).Repaint;
  end;
end;

procedure TatControlsLibrary.__TWinControlScaleBy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWinControl(CurrentObject).ScaleBy(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatControlsLibrary.__TWinControlScrollBy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWinControl(CurrentObject).ScrollBy(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatControlsLibrary.__TWinControlSetBounds(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWinControl(CurrentObject).SetBounds(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
  end;
end;

procedure TatControlsLibrary.__TWinControlSetFocus(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWinControl(CurrentObject).SetFocus;
  end;
end;

procedure TatControlsLibrary.__TWinControlUpdate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWinControl(CurrentObject).Update;
  end;
end;

procedure TatControlsLibrary.__TWinControlUpdateControlState(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWinControl(CurrentObject).UpdateControlState;
  end;
end;

procedure TatControlsLibrary.__GetTWinControlDockClientCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TWinControl(CurrentObject).DockClientCount));
  end;
end;

procedure TatControlsLibrary.__GetTWinControlDockClients(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TWinControl(CurrentObject).DockClients[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatControlsLibrary.__GetTWinControlDockSite(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TWinControl(CurrentObject).DockSite);
  end;
end;

procedure TatControlsLibrary.__SetTWinControlDockSite(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWinControl(CurrentObject).DockSite:=GetInputArg(0);
  end;
end;

procedure TatControlsLibrary.__GetTWinControlDoubleBuffered(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TWinControl(CurrentObject).DoubleBuffered);
  end;
end;

procedure TatControlsLibrary.__SetTWinControlDoubleBuffered(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWinControl(CurrentObject).DoubleBuffered:=GetInputArg(0);
  end;
end;

procedure TatControlsLibrary.__GetTWinControlAlignDisabled(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TWinControl(CurrentObject).AlignDisabled);
  end;
end;

procedure TatControlsLibrary.__GetTWinControlVisibleDockClientCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TWinControl(CurrentObject).VisibleDockClientCount));
  end;
end;

procedure TatControlsLibrary.__GetTWinControlBrush(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TWinControl(CurrentObject).Brush));
  end;
end;

procedure TatControlsLibrary.__GetTWinControlControls(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TWinControl(CurrentObject).Controls[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatControlsLibrary.__GetTWinControlControlCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TWinControl(CurrentObject).ControlCount));
  end;
end;

procedure TatControlsLibrary.__GetTWinControlHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TWinControl(CurrentObject).Handle));
  end;
end;

procedure TatControlsLibrary.__GetTWinControlParentWindow(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TWinControl(CurrentObject).ParentWindow));
  end;
end;

procedure TatControlsLibrary.__SetTWinControlParentWindow(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWinControl(CurrentObject).ParentWindow:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatControlsLibrary.__GetTWinControlShowing(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TWinControl(CurrentObject).Showing);
  end;
end;

procedure TatControlsLibrary.__GetTWinControlTabOrder(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TWinControl(CurrentObject).TabOrder);
  end;
end;

procedure TatControlsLibrary.__SetTWinControlTabOrder(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWinControl(CurrentObject).TabOrder:=GetInputArg(0);
  end;
end;

procedure TatControlsLibrary.__GetTWinControlTabStop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TWinControl(CurrentObject).TabStop);
  end;
end;

procedure TatControlsLibrary.__SetTWinControlTabStop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWinControl(CurrentObject).TabStop:=GetInputArg(0);
  end;
end;

procedure TatControlsLibrary.__GetTWinControlUseDockManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TWinControl(CurrentObject).UseDockManager);
  end;
end;

procedure TatControlsLibrary.__SetTWinControlUseDockManager(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TWinControl(CurrentObject).UseDockManager:=GetInputArg(0);
  end;
end;

procedure TatControlsLibrary.__TGraphicControlCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TGraphicControlClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TGraphicControlDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TGraphicControl(CurrentObject).Destroy;
  end;
end;

procedure TatControlsLibrary.__TCustomControlCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TCustomControlClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TCustomControlDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomControl(CurrentObject).Destroy;
  end;
end;

procedure TatControlsLibrary.__THintWindowCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(THintWindowClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__THintWindowActivateHint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    THintWindow(CurrentObject).ActivateHint(TRectWrapper(integer(GetInputArg(0))).ObjToRec,GetInputArg(1));
  end;
end;

procedure TatControlsLibrary.__THintWindowIsHintMsg(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TMsg;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is tagMSGWrapper) then 
  Param0Rec := tagMSGWrapper.Create(Param0);
Param0 := tagMSGWrapper(Param0Rec).ObjToRec;
AResult := THintWindow(CurrentObject).IsHintMsg(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(tagMSGWrapper.Create(Param0)));
  end;
end;

procedure TatControlsLibrary.__THintWindowShouldHideHint(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := THintWindow(CurrentObject).ShouldHideHint;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__THintWindowReleaseHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    THintWindow(CurrentObject).ReleaseHandle;
  end;
end;

procedure TatControlsLibrary.__TDragImageListBeginDrag(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDragImageList(CurrentObject).BeginDrag(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TDragImageListDragLock(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDragImageList(CurrentObject).DragLock(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TDragImageListDragMove(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDragImageList(CurrentObject).DragMove(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TDragImageListDragUnlock(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDragImageList(CurrentObject).DragUnlock;
  end;
end;

procedure TatControlsLibrary.__TDragImageListEndDrag(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDragImageList(CurrentObject).EndDrag;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TDragImageListGetHotSpot(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TPointWrapper.Create(TDragImageList(CurrentObject).GetHotSpot));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TDragImageListHideDragImage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDragImageList(CurrentObject).HideDragImage;
  end;
end;

procedure TatControlsLibrary.__TDragImageListSetDragImage(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TDragImageList(CurrentObject).SetDragImage(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TDragImageListShowDragImage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDragImageList(CurrentObject).ShowDragImage;
  end;
end;

procedure TatControlsLibrary.__GetTDragImageListDragCursor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDragImageList(CurrentObject).DragCursor);
  end;
end;

procedure TatControlsLibrary.__SetTDragImageListDragCursor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDragImageList(CurrentObject).DragCursor:=GetInputArg(0);
  end;
end;

procedure TatControlsLibrary.__GetTDragImageListDragHotspot(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TPointWrapper.Create(TDragImageList(CurrentObject).DragHotspot)));
  end;
end;

procedure TatControlsLibrary.__SetTDragImageListDragHotspot(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDragImageList(CurrentObject).DragHotspot:=TPointWrapper(integer(GetInputArg(0))).ObjToRec;
  end;
end;

procedure TatControlsLibrary.__GetTDragImageListDragging(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDragImageList(CurrentObject).Dragging);
  end;
end;

procedure TatControlsLibrary.__TDockZoneCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDockZoneClass(CurrentClass.ClassRef).Create(TDockTree(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TDockZoneExpandZoneLimit(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDockZone(CurrentObject).ExpandZoneLimit(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatControlsLibrary.__TDockZoneFirstVisibleChild(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDockZone(CurrentObject).FirstVisibleChild);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TDockZoneNextVisible(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDockZone(CurrentObject).NextVisible);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TDockZonePrevVisible(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDockZone(CurrentObject).PrevVisible);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TDockZoneResetChildren(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDockZone(CurrentObject).ResetChildren;
  end;
end;

procedure TatControlsLibrary.__TDockZoneResetZoneLimits(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDockZone(CurrentObject).ResetZoneLimits;
  end;
end;

procedure TatControlsLibrary.__TDockZoneUpdate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDockZone(CurrentObject).Update;
  end;
end;

procedure TatControlsLibrary.__GetTDockZoneChildCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDockZone(CurrentObject).ChildCount));
  end;
end;

procedure TatControlsLibrary.__GetTDockZoneChildControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDockZone(CurrentObject).ChildControl));
  end;
end;

procedure TatControlsLibrary.__GetTDockZoneHeight(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDockZone(CurrentObject).Height));
  end;
end;

procedure TatControlsLibrary.__GetTDockZoneLeft(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDockZone(CurrentObject).Left));
  end;
end;

procedure TatControlsLibrary.__GetTDockZoneLimitBegin(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDockZone(CurrentObject).LimitBegin));
  end;
end;

procedure TatControlsLibrary.__GetTDockZoneLimitSize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDockZone(CurrentObject).LimitSize));
  end;
end;

procedure TatControlsLibrary.__GetTDockZoneTop(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDockZone(CurrentObject).Top));
  end;
end;

procedure TatControlsLibrary.__GetTDockZoneVisible(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TDockZone(CurrentObject).Visible);
  end;
end;

procedure TatControlsLibrary.__GetTDockZoneVisibleChildCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDockZone(CurrentObject).VisibleChildCount));
  end;
end;

procedure TatControlsLibrary.__GetTDockZoneWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDockZone(CurrentObject).Width));
  end;
end;

procedure TatControlsLibrary.__GetTDockZoneZoneLimit(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TDockZone(CurrentObject).ZoneLimit));
  end;
end;

procedure TatControlsLibrary.__SetTDockZoneZoneLimit(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDockZone(CurrentObject).ZoneLimit:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatControlsLibrary.__TDockTreeCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TDockTreeClass(CurrentClass.ClassRef).Create(TWinControl(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TDockTreeDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDockTree(CurrentObject).Destroy;
  end;
end;

procedure TatControlsLibrary.__TDockTreePaintSite(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TDockTree(CurrentObject).PaintSite(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatControlsLibrary.__TMouseCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TMouseClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__TMouseDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMouse(CurrentObject).Destroy;
  end;
end;

procedure TatControlsLibrary.__TMouseSettingChanged(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMouse(CurrentObject).SettingChanged(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatControlsLibrary.__GetTMouseCapture(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TMouse(CurrentObject).Capture));
  end;
end;

procedure TatControlsLibrary.__SetTMouseCapture(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMouse(CurrentObject).Capture:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatControlsLibrary.__GetTMouseCursorPos(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TPointWrapper.Create(TMouse(CurrentObject).CursorPos)));
  end;
end;

procedure TatControlsLibrary.__SetTMouseCursorPos(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMouse(CurrentObject).CursorPos:=TPointWrapper(integer(GetInputArg(0))).ObjToRec;
  end;
end;

procedure TatControlsLibrary.__GetTMouseDragImmediate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TMouse(CurrentObject).DragImmediate);
  end;
end;

procedure TatControlsLibrary.__SetTMouseDragImmediate(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMouse(CurrentObject).DragImmediate:=GetInputArg(0);
  end;
end;

procedure TatControlsLibrary.__GetTMouseDragThreshold(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TMouse(CurrentObject).DragThreshold));
  end;
end;

procedure TatControlsLibrary.__SetTMouseDragThreshold(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TMouse(CurrentObject).DragThreshold:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatControlsLibrary.__GetTMouseMousePresent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TMouse(CurrentObject).MousePresent);
  end;
end;

procedure TatControlsLibrary.__GetTMouseIsDragging(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TMouse(CurrentObject).IsDragging);
  end;
end;

procedure TatControlsLibrary.__GetTMouseRegWheelMessage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TMouse(CurrentObject).RegWheelMessage));
  end;
end;

procedure TatControlsLibrary.__GetTMouseWheelPresent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TMouse(CurrentObject).WheelPresent);
  end;
end;

procedure TatControlsLibrary.__GetTMouseWheelScrollLines(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TMouse(CurrentObject).WheelScrollLines));
  end;
end;

procedure TatControlsLibrary.__TCustomListControlAddItem(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListControl(CurrentObject).AddItem(GetInputArg(0),TObject(Integer(GetInputArg(1))));
  end;
end;

procedure TatControlsLibrary.__TCustomListControlClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListControl(CurrentObject).Clear;
  end;
end;

procedure TatControlsLibrary.__TCustomListControlClearSelection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListControl(CurrentObject).ClearSelection;
  end;
end;

procedure TatControlsLibrary.__TCustomListControlCopySelection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListControl(CurrentObject).CopySelection(TCustomListControl(Integer(GetInputArg(0))));
  end;
end;

procedure TatControlsLibrary.__TCustomListControlDeleteSelected(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListControl(CurrentObject).DeleteSelected;
  end;
end;

procedure TatControlsLibrary.__TCustomListControlMoveSelection(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListControl(CurrentObject).MoveSelection(TCustomListControl(Integer(GetInputArg(0))));
  end;
end;

procedure TatControlsLibrary.__TCustomListControlSelectAll(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListControl(CurrentObject).SelectAll;
  end;
end;

procedure TatControlsLibrary.__GetTCustomListControlItemIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomListControl(CurrentObject).ItemIndex));
  end;
end;

procedure TatControlsLibrary.__SetTCustomListControlItemIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomListControl(CurrentObject).ItemIndex:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatControlsLibrary.__GetTCustomMultiSelectListControlMultiSelect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TCustomMultiSelectListControl(CurrentObject).MultiSelect);
  end;
end;

procedure TatControlsLibrary.__SetTCustomMultiSelectListControlMultiSelect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TCustomMultiSelectListControl(CurrentObject).MultiSelect:=GetInputArg(0);
  end;
end;

procedure TatControlsLibrary.__GetTCustomMultiSelectListControlSelCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TCustomMultiSelectListControl(CurrentObject).SelCount));
  end;
end;

procedure TatControlsDispatcher.__TMouseEvent( Sender: TObject;  Button: TMouseButton;  Shift: TShiftState;  X: Integer;  Y: Integer);
var
  ButtonTemp: variant;
  ShiftTempSet: TShiftState;
  ShiftTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TMouseEvent(BeforeCall)(Sender,Button,Shift,X,Y);
    ButtonTemp := Button;
    ShiftTempSet := Shift;
    ShiftTemp := IntFromSet(ShiftTempSet, SizeOf(ShiftTempSet));
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,ButtonTemp,ShiftTemp,X,Y]);
    if AssignedMethod(AfterCall) then
      TMouseEvent(AfterCall)(Sender,Button,Shift,X,Y);
  end;
end;

procedure TatControlsDispatcher.__TMouseMoveEvent( Sender: TObject;  Shift: TShiftState;  X: Integer;  Y: Integer);
var
  ShiftTempSet: TShiftState;
  ShiftTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TMouseMoveEvent(BeforeCall)(Sender,Shift,X,Y);
    ShiftTempSet := Shift;
    ShiftTemp := IntFromSet(ShiftTempSet, SizeOf(ShiftTempSet));
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,ShiftTemp,X,Y]);
    if AssignedMethod(AfterCall) then
      TMouseMoveEvent(AfterCall)(Sender,Shift,X,Y);
  end;
end;

procedure TatControlsDispatcher.__TMouseActivateEvent( Sender: TObject;  Button: TMouseButton;  Shift: TShiftState;  X: Integer;  Y: Integer;  HitTest: Integer; var MouseActivate: TMouseActivate);
var
  ButtonTemp: variant;
  ShiftTempSet: TShiftState;
  ShiftTemp: variant;
  MouseActivateTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TMouseActivateEvent(BeforeCall)(Sender,Button,Shift,X,Y,HitTest,MouseActivate);
    ButtonTemp := Button;
    ShiftTempSet := Shift;
    ShiftTemp := IntFromSet(ShiftTempSet, SizeOf(ShiftTempSet));
    MouseActivateTemp := MouseActivate;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,ButtonTemp,ShiftTemp,X,Y,HitTest,MouseActivateTemp]);
    MouseActivate := MouseActivateTemp;
    if AssignedMethod(AfterCall) then
      TMouseActivateEvent(AfterCall)(Sender,Button,Shift,X,Y,HitTest,MouseActivate);
  end;
end;

procedure TatControlsDispatcher.__TKeyEvent( Sender: TObject; var Key: Word;  Shift: TShiftState);
var
  KeyTemp: variant;
  ShiftTempSet: TShiftState;
  ShiftTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TKeyEvent(BeforeCall)(Sender,Key,Shift);
    KeyTemp := Integer(Key);
    ShiftTempSet := Shift;
    ShiftTemp := IntFromSet(ShiftTempSet, SizeOf(ShiftTempSet));
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,KeyTemp,ShiftTemp]);
    Key := VarToInteger(KeyTemp);
    if AssignedMethod(AfterCall) then
      TKeyEvent(AfterCall)(Sender,Key,Shift);
  end;
end;

procedure TatControlsDispatcher.__TKeyPressEvent( Sender: TObject; var Key: Char);
var
  KeyTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TKeyPressEvent(BeforeCall)(Sender,Key);
    KeyTemp := Key;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,KeyTemp]);
    Key := VarToStr(KeyTemp)[1];
    if AssignedMethod(AfterCall) then
      TKeyPressEvent(AfterCall)(Sender,Key);
  end;
end;

procedure TatControlsDispatcher.__TDragOverEvent( Sender: TObject;  Source: TObject;  X: Integer;  Y: Integer;  State: TDragState; var Accept: Boolean);
var
  StateTemp: variant;
  AcceptTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TDragOverEvent(BeforeCall)(Sender,Source,X,Y,State,Accept);
    StateTemp := State;
    AcceptTemp := Accept;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Source,X,Y,StateTemp,AcceptTemp]);
    Accept := AcceptTemp;
    if AssignedMethod(AfterCall) then
      TDragOverEvent(AfterCall)(Sender,Source,X,Y,State,Accept);
  end;
end;

procedure TatControlsDispatcher.__TDragDropEvent( Sender: TObject;  Source: TObject;  X: Integer;  Y: Integer);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TDragDropEvent(BeforeCall)(Sender,Source,X,Y);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Source,X,Y]);
    if AssignedMethod(AfterCall) then
      TDragDropEvent(AfterCall)(Sender,Source,X,Y);
  end;
end;

procedure TatControlsDispatcher.__TStartDragEvent( Sender: TObject; var DragObject: TDragObject);
var
  DragObjectTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TStartDragEvent(BeforeCall)(Sender,DragObject);
    DragObjectTemp := Integer(DragObject);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,DragObjectTemp]);
    DragObject := TDragObject(Integer(DragObjectTemp));
    if AssignedMethod(AfterCall) then
      TStartDragEvent(AfterCall)(Sender,DragObject);
  end;
end;

procedure TatControlsDispatcher.__TEndDragEvent( Sender: TObject;  Target: TObject;  X: Integer;  Y: Integer);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TEndDragEvent(BeforeCall)(Sender,Target,X,Y);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Target,X,Y]);
    if AssignedMethod(AfterCall) then
      TEndDragEvent(AfterCall)(Sender,Target,X,Y);
  end;
end;

procedure TatControlsDispatcher.__TDockDropEvent( Sender: TObject;  Source: TDragDockObject;  X: Integer;  Y: Integer);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TDockDropEvent(BeforeCall)(Sender,Source,X,Y);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Source,X,Y]);
    if AssignedMethod(AfterCall) then
      TDockDropEvent(AfterCall)(Sender,Source,X,Y);
  end;
end;

procedure TatControlsDispatcher.__TDockOverEvent( Sender: TObject;  Source: TDragDockObject;  X: Integer;  Y: Integer;  State: TDragState; var Accept: Boolean);
var
  StateTemp: variant;
  AcceptTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TDockOverEvent(BeforeCall)(Sender,Source,X,Y,State,Accept);
    StateTemp := State;
    AcceptTemp := Accept;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Source,X,Y,StateTemp,AcceptTemp]);
    Accept := AcceptTemp;
    if AssignedMethod(AfterCall) then
      TDockOverEvent(AfterCall)(Sender,Source,X,Y,State,Accept);
  end;
end;

procedure TatControlsDispatcher.__TUnDockEvent( Sender: TObject;  Client: TControl;  NewTarget: TWinControl; var Allow: Boolean);
var
  AllowTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TUnDockEvent(BeforeCall)(Sender,Client,NewTarget,Allow);
    AllowTemp := Allow;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,Client,NewTarget,AllowTemp]);
    Allow := AllowTemp;
    if AssignedMethod(AfterCall) then
      TUnDockEvent(AfterCall)(Sender,Client,NewTarget,Allow);
  end;
end;

procedure TatControlsDispatcher.__TStartDockEvent( Sender: TObject; var DragObject: TDragDockObject);
var
  DragObjectTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TStartDockEvent(BeforeCall)(Sender,DragObject);
    DragObjectTemp := Integer(DragObject);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,DragObjectTemp]);
    DragObject := TDragDockObject(Integer(DragObjectTemp));
    if AssignedMethod(AfterCall) then
      TStartDockEvent(AfterCall)(Sender,DragObject);
  end;
end;

procedure TatControlsDispatcher.__TCanResizeEvent( Sender: TObject; var NewWidth: Integer; var NewHeight: Integer; var Resize: Boolean);
var
  NewWidthTemp: variant;
  NewHeightTemp: variant;
  ResizeTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TCanResizeEvent(BeforeCall)(Sender,NewWidth,NewHeight,Resize);
    NewWidthTemp := Integer(NewWidth);
    NewHeightTemp := Integer(NewHeight);
    ResizeTemp := Resize;
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,NewWidthTemp,NewHeightTemp,ResizeTemp]);
    NewWidth := VarToInteger(NewWidthTemp);
    NewHeight := VarToInteger(NewHeightTemp);
    Resize := ResizeTemp;
    if AssignedMethod(AfterCall) then
      TCanResizeEvent(AfterCall)(Sender,NewWidth,NewHeight,Resize);
  end;
end;

procedure TatControlsDispatcher.__TConstrainedResizeEvent( Sender: TObject; var MinWidth: Integer; var MinHeight: Integer; var MaxWidth: Integer; var MaxHeight: Integer);
var
  MinWidthTemp: variant;
  MinHeightTemp: variant;
  MaxWidthTemp: variant;
  MaxHeightTemp: variant;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TConstrainedResizeEvent(BeforeCall)(Sender,MinWidth,MinHeight,MaxWidth,MaxHeight);
    MinWidthTemp := Integer(MinWidth);
    MinHeightTemp := Integer(MinHeight);
    MaxWidthTemp := Integer(MaxWidth);
    MaxHeightTemp := Integer(MaxHeight);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,MinWidthTemp,MinHeightTemp,MaxWidthTemp,MaxHeightTemp]);
    MinWidth := VarToInteger(MinWidthTemp);
    MinHeight := VarToInteger(MinHeightTemp);
    MaxWidth := VarToInteger(MaxWidthTemp);
    MaxHeight := VarToInteger(MaxHeightTemp);
    if AssignedMethod(AfterCall) then
      TConstrainedResizeEvent(AfterCall)(Sender,MinWidth,MinHeight,MaxWidth,MaxHeight);
  end;
end;

function TatControlsDispatcher.__TAlignInsertBeforeEvent( Sender: TWinControl;  C1: TControl;  C2: TControl): Boolean;
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TAlignInsertBeforeEvent(BeforeCall)(Sender,C1,C2);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sender,C1,C2]);
    if AssignedMethod(AfterCall) then
      TAlignInsertBeforeEvent(AfterCall)(Sender,C1,C2);
  end;
end;

procedure TatControlsDispatcher.__TForEachZoneProc( Zone: TDockZone);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TForEachZoneProc(BeforeCall)(Zone);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Zone]);
    if AssignedMethod(AfterCall) then
      TForEachZoneProc(AfterCall)(Zone);
  end;
end;

procedure TatControlsLibrary.__IsPositiveResult(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Controls.IsPositiveResult(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__IsNegativeResult(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Controls.IsNegativeResult(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__IsAbortResult(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Controls.IsAbortResult(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__IsAnAllResult(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Controls.IsAnAllResult(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__StripAllFromResult(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Controls.StripAllFromResult(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__IsDragObject(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Controls.IsDragObject(TObject(Integer(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__FindControl(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Controls.FindControl(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__FindVCLWindow(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Controls.FindVCLWindow(TPointWrapper(integer(GetInputArg(0))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__FindDragTarget(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Controls.FindDragTarget(TPointWrapper(integer(GetInputArg(0))).ObjToRec,GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__GetCaptureControl(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Controls.GetCaptureControl);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__SetCaptureControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Controls.SetCaptureControl(TControl(Integer(GetInputArg(0))));
  end;
end;

procedure TatControlsLibrary.__CancelDrag(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Controls.CancelDrag;
  end;
end;

procedure TatControlsLibrary.__CursorToString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Controls.CursorToString(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__StringToCursor(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Controls.StringToCursor(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__CursorToIdent(AMachine: TatVirtualMachine);
  var
  Param1: string;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := Controls.CursorToIdent(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatControlsLibrary.__IdentToCursor(AMachine: TatVirtualMachine);
  var
  Param1: Longint;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
AResult := Controls.IdentToCursor(GetInputArg(0),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
  end;
end;

procedure TatControlsLibrary.__GetShortHint(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Controls.GetShortHint(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__GetLongHint(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Controls.GetLongHint(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__PerformEraseBackground(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Controls.PerformEraseBackground(TControl(Integer(GetInputArg(0))),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatControlsLibrary.__InitWndProc(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Controls.InitWndProc(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__ChangeBiDiModeAlignment(AMachine: TatVirtualMachine);
  var
  Param0: TAlignment;
begin
  with AMachine do
  begin
Param0 := GetInputArg(0);
    Controls.ChangeBiDiModeAlignment(Param0);
    SetInputArg(0,Param0);
  end;
end;

procedure TatControlsLibrary.__SendAppMessage(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Controls.SendAppMessage(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__MoveWindowOrg(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Controls.MoveWindowOrg(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
  end;
end;

procedure TatControlsLibrary.__SetImeMode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Controls.SetImeMode(VarToInteger(GetInputArg(0)),GetInputArg(1));
  end;
end;

procedure TatControlsLibrary.__SetImeName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Controls.SetImeName(GetInputArg(0));
  end;
end;

procedure TatControlsLibrary.__Win32NLSEnableIME(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Controls.Win32NLSEnableIME(VarToInteger(GetInputArg(0)),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__Imm32GetContext(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Controls.Imm32GetContext(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__Imm32ReleaseContext(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Controls.Imm32ReleaseContext(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__Imm32GetConversionStatus(AMachine: TatVirtualMachine);
  var
  Param1: DWORD;
  Param2: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := VarToInteger(GetInputArg(1));
Param2 := VarToInteger(GetInputArg(2));
AResult := Controls.Imm32GetConversionStatus(VarToInteger(GetInputArg(0)),Param1,Param2);
    ReturnOutputArg(AResult);
    SetInputArg(1,Integer(Param1));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatControlsLibrary.__Imm32SetConversionStatus(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Controls.Imm32SetConversionStatus(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__Imm32SetOpenStatus(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Controls.Imm32SetOpenStatus(VarToInteger(GetInputArg(0)),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__Imm32IsIME(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Controls.Imm32IsIME(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__Imm32NotifyIME(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Controls.Imm32NotifyIME(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),VarToInteger(GetInputArg(3)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatControlsLibrary.__DragDone(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Controls.DragDone(GetInputArg(0));
  end;
end;

procedure TatControlsLibrary.__GetMouse(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(Controls.Mouse));
  end;
end;

procedure TatControlsLibrary.__SetMouse(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Controls.Mouse:=TMouse(Integer(GetInputArg(0)));
  end;
end;

procedure TatControlsLibrary.__GetCreationControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(Controls.CreationControl));
  end;
end;

procedure TatControlsLibrary.__SetCreationControl(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Controls.CreationControl:=TWinControl(Integer(GetInputArg(0)));
  end;
end;

procedure TatControlsLibrary.__GetNewStyleControls(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Controls.NewStyleControls);
  end;
end;

procedure TatControlsLibrary.__SetNewStyleControls(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Controls.NewStyleControls:=GetInputArg(0);
  end;
end;

procedure TatControlsLibrary.Init;
begin
  With Scripter.DefineClass(TDragObject) do
  begin
    DefineMethod('AfterConstruction',0,tkNone,nil,__TDragObjectAfterConstruction,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TDragObjectAssign,false,0);
    DefineMethod('BeforeDestruction',0,tkNone,nil,__TDragObjectBeforeDestruction,false,0);
    DefineMethod('GetName',0,tkVariant,nil,__TDragObjectGetName,false,0);
    DefineMethod('HideDragImage',0,tkNone,nil,__TDragObjectHideDragImage,false,0);
    DefineMethod('Instance',0,tkInteger,nil,__TDragObjectInstance,false,0);
    DefineMethod('ShowDragImage',0,tkNone,nil,__TDragObjectShowDragImage,false,0);
    DefineProp('AlwaysShowDragImages',tkVariant,__GetTDragObjectAlwaysShowDragImages,__SetTDragObjectAlwaysShowDragImages,nil,false,0);
    DefineProp('Cancelling',tkVariant,__GetTDragObjectCancelling,__SetTDragObjectCancelling,nil,false,0);
    DefineProp('DragHandle',tkInteger,__GetTDragObjectDragHandle,__SetTDragObjectDragHandle,nil,false,0);
    DefineProp('DragPos',tkVariant,__GetTDragObjectDragPos,__SetTDragObjectDragPos,nil,false,0);
    DefineProp('DragTargetPos',tkVariant,__GetTDragObjectDragTargetPos,__SetTDragObjectDragTargetPos,nil,false,0);
    DefineProp('Dropped',tkVariant,__GetTDragObjectDropped,nil,nil,false,0);
    DefineProp('MouseDeltaX',tkVariant,__GetTDragObjectMouseDeltaX,nil,nil,false,0);
    DefineProp('MouseDeltaY',tkVariant,__GetTDragObjectMouseDeltaY,nil,nil,false,0);
    DefineProp('RightClickCancels',tkVariant,__GetTDragObjectRightClickCancels,__SetTDragObjectRightClickCancels,nil,false,0);
  end;
  With Scripter.DefineClass(TDragObjectEx) do
  begin
    DefineMethod('BeforeDestruction',0,tkNone,nil,__TDragObjectExBeforeDestruction,false,0);
  end;
  With Scripter.DefineClass(TBaseDragControlObject) do
  begin
    DefineMethod('Create',1,tkClass,TBaseDragControlObject,__TBaseDragControlObjectCreate,true,0);
    DefineMethod('Assign',1,tkNone,nil,__TBaseDragControlObjectAssign,false,0);
    DefineProp('Control',tkClass,__GetTBaseDragControlObjectControl,__SetTBaseDragControlObjectControl,TControl,false,0);
  end;
  With Scripter.DefineClass(TDragControlObject) do
  begin
    DefineMethod('HideDragImage',0,tkNone,nil,__TDragControlObjectHideDragImage,false,0);
    DefineMethod('ShowDragImage',0,tkNone,nil,__TDragControlObjectShowDragImage,false,0);
  end;
  With Scripter.DefineClass(TDragControlObjectEx) do
  begin
    DefineMethod('BeforeDestruction',0,tkNone,nil,__TDragControlObjectExBeforeDestruction,false,0);
  end;
  With Scripter.DefineClass(TDragDockObject) do
  begin
    DefineMethod('Create',1,tkClass,TDragDockObject,__TDragDockObjectCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TDragDockObjectDestroy,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TDragDockObjectAssign,false,0);
    DefineProp('Brush',tkClass,__GetTDragDockObjectBrush,__SetTDragDockObjectBrush,TBrush,false,0);
    DefineProp('DockRect',tkVariant,__GetTDragDockObjectDockRect,__SetTDragDockObjectDockRect,nil,false,0);
    DefineProp('DropAlign',tkEnumeration,__GetTDragDockObjectDropAlign,nil,nil,false,0);
    DefineProp('DropOnControl',tkClass,__GetTDragDockObjectDropOnControl,nil,TControl,false,0);
    DefineProp('Floating',tkVariant,__GetTDragDockObjectFloating,__SetTDragDockObjectFloating,nil,false,0);
    DefineProp('FrameWidth',tkInteger,__GetTDragDockObjectFrameWidth,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TDragDockObjectEx) do
  begin
    DefineMethod('BeforeDestruction',0,tkNone,nil,__TDragDockObjectExBeforeDestruction,false,0);
  end;
  With Scripter.DefineClass(TControlCanvas) do
  begin
    DefineMethod('Destroy',0,tkNone,nil,__TControlCanvasDestroy,false,0);
    DefineMethod('FreeHandle',0,tkNone,nil,__TControlCanvasFreeHandle,false,0);
    DefineMethod('UpdateTextFlags',0,tkNone,nil,__TControlCanvasUpdateTextFlags,false,0);
    DefineProp('Control',tkClass,__GetTControlCanvasControl,__SetTControlCanvasControl,TControl,false,0);
  end;
  With Scripter.DefineClass(TCustomControlAction) do
  begin
    DefineProp('DropdownMenu',tkClass,__GetTCustomControlActionDropdownMenu,__SetTCustomControlActionDropdownMenu,TPopupMenu,false,0);
    DefineProp('EnableDropdown',tkVariant,__GetTCustomControlActionEnableDropdown,__SetTCustomControlActionEnableDropdown,nil,false,0);
    DefineProp('PopupMenu',tkClass,__GetTCustomControlActionPopupMenu,__SetTCustomControlActionPopupMenu,TPopupMenu,false,0);
  end;
  With Scripter.DefineClass(TControlAction) do
  begin
  end;
  With Scripter.DefineClass(TControlActionLink) do
  begin
  end;
  With Scripter.DefineClass(TSizeConstraints) do
  begin
    DefineMethod('Create',1,tkClass,TSizeConstraints,__TSizeConstraintsCreate,true,0);
  end;
  With Scripter.DefineClass(TControl) do
  begin
    DefineMethod('Create',1,tkClass,TControl,__TControlCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TControlDestroy,false,0);
    DefineMethod('BeginDrag',2,tkNone,nil,__TControlBeginDrag,false,1);
    DefineMethod('BringToFront',0,tkNone,nil,__TControlBringToFront,false,0);
    DefineMethod('ClientToScreen',1,tkVariant,nil,__TControlClientToScreen,false,0);
    DefineMethod('ClientToParent',2,tkVariant,nil,__TControlClientToParent,false,1);
    DefineMethod('Dock',2,tkNone,nil,__TControlDock,false,0);
    DefineMethod('DefaultHandler',1,tkNone,nil,__TControlDefaultHandler,false,0).SetVarArgs([0]);
    DefineMethod('Dragging',0,tkVariant,nil,__TControlDragging,false,0);
    DefineMethod('DragDrop',3,tkNone,nil,__TControlDragDrop,false,0);
    DefineMethod('DrawTextBiDiModeFlags',1,tkInteger,nil,__TControlDrawTextBiDiModeFlags,false,0);
    DefineMethod('DrawTextBiDiModeFlagsReadingOnly',0,tkInteger,nil,__TControlDrawTextBiDiModeFlagsReadingOnly,false,0);
    DefineMethod('EndDrag',1,tkNone,nil,__TControlEndDrag,false,0);
    DefineMethod('GetControlsAlignment',0,tkEnumeration,nil,__TControlGetControlsAlignment,false,0);
    DefineMethod('GetParentComponent',0,tkClass,TComponent,__TControlGetParentComponent,false,0);
    DefineMethod('GetTextBuf',2,tkInteger,nil,__TControlGetTextBuf,false,0);
    DefineMethod('GetTextLen',0,tkInteger,nil,__TControlGetTextLen,false,0);
    DefineMethod('HasParent',0,tkVariant,nil,__TControlHasParent,false,0);
    DefineMethod('Hide',0,tkNone,nil,__TControlHide,false,0);
    DefineMethod('InitiateAction',0,tkNone,nil,__TControlInitiateAction,false,0);
    DefineMethod('Invalidate',0,tkNone,nil,__TControlInvalidate,false,0);
    DefineMethod('MouseWheelHandler',1,tkNone,nil,__TControlMouseWheelHandler,false,0).SetVarArgs([0]);
    DefineMethod('IsRightToLeft',0,tkVariant,nil,__TControlIsRightToLeft,false,0);
    DefineMethod('ManualDock',3,tkVariant,nil,__TControlManualDock,false,2);
    DefineMethod('ManualFloat',1,tkVariant,nil,__TControlManualFloat,false,0);
    DefineMethod('Perform',3,tkInteger,nil,__TControlPerform,false,0);
    DefineMethod('Refresh',0,tkNone,nil,__TControlRefresh,false,0);
    DefineMethod('Repaint',0,tkNone,nil,__TControlRepaint,false,0);
    DefineMethod('ReplaceDockedControl',4,tkVariant,nil,__TControlReplaceDockedControl,false,0);
    DefineMethod('ScreenToClient',1,tkVariant,nil,__TControlScreenToClient,false,0);
    DefineMethod('ParentToClient',2,tkVariant,nil,__TControlParentToClient,false,1);
    DefineMethod('SendToBack',0,tkNone,nil,__TControlSendToBack,false,0);
    DefineMethod('SetBounds',4,tkNone,nil,__TControlSetBounds,false,0);
    DefineMethod('SetTextBuf',1,tkNone,nil,__TControlSetTextBuf,false,0);
    DefineMethod('Show',0,tkNone,nil,__TControlShow,false,0);
    DefineMethod('Update',0,tkNone,nil,__TControlUpdate,false,0);
    DefineMethod('UseRightToLeftAlignment',0,tkVariant,nil,__TControlUseRightToLeftAlignment,false,0);
    DefineMethod('UseRightToLeftReading',0,tkVariant,nil,__TControlUseRightToLeftReading,false,0);
    DefineMethod('UseRightToLeftScrollBar',0,tkVariant,nil,__TControlUseRightToLeftScrollBar,false,0);
    DefineProp('Enabled',tkVariant,__GetTControlEnabled,__SetTControlEnabled,nil,false,0);
    DefineProp('Action',tkClass,__GetTControlAction,__SetTControlAction,TBasicAction,false,0);
    DefineProp('Align',tkEnumeration,__GetTControlAlign,__SetTControlAlign,nil,false,0);
    DefineProp('Anchors',tkInteger,__GetTControlAnchors,__SetTControlAnchors,nil,false,0);
    DefineProp('BiDiMode',tkEnumeration,__GetTControlBiDiMode,__SetTControlBiDiMode,nil,false,0);
    DefineProp('BoundsRect',tkVariant,__GetTControlBoundsRect,__SetTControlBoundsRect,nil,false,0);
    DefineProp('ClientHeight',tkInteger,__GetTControlClientHeight,__SetTControlClientHeight,nil,false,0);
    DefineProp('ClientOrigin',tkVariant,__GetTControlClientOrigin,nil,nil,false,0);
    DefineProp('ClientRect',tkVariant,__GetTControlClientRect,nil,nil,false,0);
    DefineProp('ClientWidth',tkInteger,__GetTControlClientWidth,__SetTControlClientWidth,nil,false,0);
    DefineProp('Constraints',tkClass,__GetTControlConstraints,__SetTControlConstraints,TSizeConstraints,false,0);
    DefineProp('ControlState',tkInteger,__GetTControlControlState,__SetTControlControlState,nil,false,0);
    DefineProp('ControlStyle',tkInteger,__GetTControlControlStyle,__SetTControlControlStyle,nil,false,0);
    DefineProp('DockOrientation',tkEnumeration,__GetTControlDockOrientation,__SetTControlDockOrientation,nil,false,0);
    DefineProp('Floating',tkVariant,__GetTControlFloating,nil,nil,false,0);
    DefineProp('HostDockSite',tkClass,__GetTControlHostDockSite,__SetTControlHostDockSite,TWinControl,false,0);
    DefineProp('LRDockWidth',tkInteger,__GetTControlLRDockWidth,__SetTControlLRDockWidth,nil,false,0);
    DefineProp('Parent',tkClass,__GetTControlParent,__SetTControlParent,TWinControl,false,0);
    DefineProp('ShowHint',tkVariant,__GetTControlShowHint,__SetTControlShowHint,nil,false,0);
    DefineProp('TBDockHeight',tkInteger,__GetTControlTBDockHeight,__SetTControlTBDockHeight,nil,false,0);
    DefineProp('UndockHeight',tkInteger,__GetTControlUndockHeight,__SetTControlUndockHeight,nil,false,0);
    DefineProp('UndockWidth',tkInteger,__GetTControlUndockWidth,__SetTControlUndockWidth,nil,false,0);
    DefineProp('Visible',tkVariant,__GetTControlVisible,__SetTControlVisible,nil,false,0);
  end;
  With Scripter.DefineClass(TWinControlActionLink) do
  begin
  end;
  With Scripter.DefineClass(TWinControl) do
  begin
    DefineMethod('Create',1,tkClass,TWinControl,__TWinControlCreate,true,0);
    DefineMethod('CreateParented',1,tkClass,TWinControl,__TWinControlCreateParented,true,0);
    DefineMethod('CreateParentedControl',1,tkClass,TWinControl,__TWinControlCreateParentedControl,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TWinControlDestroy,false,0);
    DefineMethod('Broadcast',1,tkNone,nil,__TWinControlBroadcast,false,0).SetVarArgs([0]);
    DefineMethod('CanFocus',0,tkVariant,nil,__TWinControlCanFocus,false,0);
    DefineMethod('ContainsControl',1,tkVariant,nil,__TWinControlContainsControl,false,0);
    DefineMethod('ControlAtPos',4,tkClass,TControl,__TWinControlControlAtPos,false,2);
    DefineMethod('DefaultHandler',1,tkNone,nil,__TWinControlDefaultHandler,false,0).SetVarArgs([0]);
    DefineMethod('DisableAlign',0,tkNone,nil,__TWinControlDisableAlign,false,0);
    DefineMethod('DockDrop',3,tkNone,nil,__TWinControlDockDrop,false,0);
    DefineMethod('EnableAlign',0,tkNone,nil,__TWinControlEnableAlign,false,0);
    DefineMethod('FindChildControl',1,tkClass,TControl,__TWinControlFindChildControl,false,0);
    DefineMethod('FlipChildren',1,tkNone,nil,__TWinControlFlipChildren,false,0);
    DefineMethod('Focused',0,tkVariant,nil,__TWinControlFocused,false,0);
    DefineMethod('GetTabOrderList',1,tkNone,nil,__TWinControlGetTabOrderList,false,0);
    DefineMethod('HandleAllocated',0,tkVariant,nil,__TWinControlHandleAllocated,false,0);
    DefineMethod('HandleNeeded',0,tkNone,nil,__TWinControlHandleNeeded,false,0);
    DefineMethod('InsertControl',1,tkNone,nil,__TWinControlInsertControl,false,0);
    DefineMethod('Invalidate',0,tkNone,nil,__TWinControlInvalidate,false,0);
    DefineMethod('PaintTo',3,tkNone,nil,__TWinControlPaintTo,false,0);
    DefineMethod('PreProcessMessage',1,tkVariant,nil,__TWinControlPreProcessMessage,false,0).SetVarArgs([0]);
    DefineMethod('RemoveControl',1,tkNone,nil,__TWinControlRemoveControl,false,0);
    DefineMethod('Realign',0,tkNone,nil,__TWinControlRealign,false,0);
    DefineMethod('Repaint',0,tkNone,nil,__TWinControlRepaint,false,0);
    DefineMethod('ScaleBy',2,tkNone,nil,__TWinControlScaleBy,false,0);
    DefineMethod('ScrollBy',2,tkNone,nil,__TWinControlScrollBy,false,0);
    DefineMethod('SetBounds',4,tkNone,nil,__TWinControlSetBounds,false,0);
    DefineMethod('SetFocus',0,tkNone,nil,__TWinControlSetFocus,false,0);
    DefineMethod('Update',0,tkNone,nil,__TWinControlUpdate,false,0);
    DefineMethod('UpdateControlState',0,tkNone,nil,__TWinControlUpdateControlState,false,0);
    DefineProp('DockClientCount',tkInteger,__GetTWinControlDockClientCount,nil,nil,false,0);
    DefineProp('DockClients',tkClass,__GetTWinControlDockClients,nil,TControl,false,1);
    DefineProp('DockSite',tkVariant,__GetTWinControlDockSite,__SetTWinControlDockSite,nil,false,0);
    DefineProp('DoubleBuffered',tkVariant,__GetTWinControlDoubleBuffered,__SetTWinControlDoubleBuffered,nil,false,0);
    DefineProp('AlignDisabled',tkVariant,__GetTWinControlAlignDisabled,nil,nil,false,0);
    DefineProp('VisibleDockClientCount',tkInteger,__GetTWinControlVisibleDockClientCount,nil,nil,false,0);
    DefineProp('Brush',tkClass,__GetTWinControlBrush,nil,TBrush,false,0);
    DefineProp('Controls',tkClass,__GetTWinControlControls,nil,TControl,false,1);
    DefineProp('ControlCount',tkInteger,__GetTWinControlControlCount,nil,nil,false,0);
    DefineProp('Handle',tkInteger,__GetTWinControlHandle,nil,nil,false,0);
    DefineProp('ParentWindow',tkInteger,__GetTWinControlParentWindow,__SetTWinControlParentWindow,nil,false,0);
    DefineProp('Showing',tkVariant,__GetTWinControlShowing,nil,nil,false,0);
    DefineProp('TabOrder',tkEnumeration,__GetTWinControlTabOrder,__SetTWinControlTabOrder,nil,false,0);
    DefineProp('TabStop',tkVariant,__GetTWinControlTabStop,__SetTWinControlTabStop,nil,false,0);
    DefineProp('UseDockManager',tkVariant,__GetTWinControlUseDockManager,__SetTWinControlUseDockManager,nil,false,0);
  end;
  With Scripter.DefineClass(TGraphicControl) do
  begin
    DefineMethod('Create',1,tkClass,TGraphicControl,__TGraphicControlCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TGraphicControlDestroy,false,0);
  end;
  With Scripter.DefineClass(TCustomControl) do
  begin
    DefineMethod('Create',1,tkClass,TCustomControl,__TCustomControlCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TCustomControlDestroy,false,0);
  end;
  With Scripter.DefineClass(THintWindow) do
  begin
    DefineMethod('Create',1,tkClass,THintWindow,__THintWindowCreate,true,0);
    DefineMethod('ActivateHint',2,tkNone,nil,__THintWindowActivateHint,false,0);
    DefineMethod('IsHintMsg',1,tkVariant,nil,__THintWindowIsHintMsg,false,0).SetVarArgs([0]);
    DefineMethod('ShouldHideHint',0,tkVariant,nil,__THintWindowShouldHideHint,false,0);
    DefineMethod('ReleaseHandle',0,tkNone,nil,__THintWindowReleaseHandle,false,0);
    DefineProp('BiDiMode',tkVariant,nil,nil,nil,false,0);
    DefineProp('Caption',tkVariant,nil,nil,nil,false,0);
    DefineProp('Color',tkVariant,nil,nil,nil,false,0);
    DefineProp('Canvas',tkVariant,nil,nil,nil,false,0);
    DefineProp('Font',tkVariant,nil,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TDragImageList) do
  begin
    DefineMethod('BeginDrag',3,tkVariant,nil,__TDragImageListBeginDrag,false,0);
    DefineMethod('DragLock',3,tkVariant,nil,__TDragImageListDragLock,false,0);
    DefineMethod('DragMove',2,tkVariant,nil,__TDragImageListDragMove,false,0);
    DefineMethod('DragUnlock',0,tkNone,nil,__TDragImageListDragUnlock,false,0);
    DefineMethod('EndDrag',0,tkVariant,nil,__TDragImageListEndDrag,false,0);
    DefineMethod('GetHotSpot',0,tkVariant,nil,__TDragImageListGetHotSpot,false,0);
    DefineMethod('HideDragImage',0,tkNone,nil,__TDragImageListHideDragImage,false,0);
    DefineMethod('SetDragImage',3,tkVariant,nil,__TDragImageListSetDragImage,false,0);
    DefineMethod('ShowDragImage',0,tkNone,nil,__TDragImageListShowDragImage,false,0);
    DefineProp('DragCursor',tkEnumeration,__GetTDragImageListDragCursor,__SetTDragImageListDragCursor,nil,false,0);
    DefineProp('DragHotspot',tkVariant,__GetTDragImageListDragHotspot,__SetTDragImageListDragHotspot,nil,false,0);
    DefineProp('Dragging',tkVariant,__GetTDragImageListDragging,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TImageList) do
  begin
  end;
  With Scripter.DefineClass(TDockZone) do
  begin
    DefineMethod('Create',1,tkClass,TDockZone,__TDockZoneCreate,true,0);
    DefineMethod('ExpandZoneLimit',1,tkNone,nil,__TDockZoneExpandZoneLimit,false,0);
    DefineMethod('FirstVisibleChild',0,tkClass,TDockZone,__TDockZoneFirstVisibleChild,false,0);
    DefineMethod('NextVisible',0,tkClass,TDockZone,__TDockZoneNextVisible,false,0);
    DefineMethod('PrevVisible',0,tkClass,TDockZone,__TDockZonePrevVisible,false,0);
    DefineMethod('ResetChildren',0,tkNone,nil,__TDockZoneResetChildren,false,0);
    DefineMethod('ResetZoneLimits',0,tkNone,nil,__TDockZoneResetZoneLimits,false,0);
    DefineMethod('Update',0,tkNone,nil,__TDockZoneUpdate,false,0);
    DefineProp('ChildCount',tkInteger,__GetTDockZoneChildCount,nil,nil,false,0);
    DefineProp('ChildControl',tkClass,__GetTDockZoneChildControl,nil,TControl,false,0);
    DefineProp('Height',tkInteger,__GetTDockZoneHeight,nil,nil,false,0);
    DefineProp('Left',tkInteger,__GetTDockZoneLeft,nil,nil,false,0);
    DefineProp('LimitBegin',tkInteger,__GetTDockZoneLimitBegin,nil,nil,false,0);
    DefineProp('LimitSize',tkInteger,__GetTDockZoneLimitSize,nil,nil,false,0);
    DefineProp('Top',tkInteger,__GetTDockZoneTop,nil,nil,false,0);
    DefineProp('Visible',tkVariant,__GetTDockZoneVisible,nil,nil,false,0);
    DefineProp('VisibleChildCount',tkInteger,__GetTDockZoneVisibleChildCount,nil,nil,false,0);
    DefineProp('Width',tkInteger,__GetTDockZoneWidth,nil,nil,false,0);
    DefineProp('ZoneLimit',tkInteger,__GetTDockZoneZoneLimit,__SetTDockZoneZoneLimit,nil,false,0);
  end;
  With Scripter.DefineClass(TDockTree) do
  begin
    DefineMethod('Create',1,tkClass,TDockTree,__TDockTreeCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TDockTreeDestroy,false,0);
    DefineMethod('PaintSite',1,tkNone,nil,__TDockTreePaintSite,false,0);
  end;
  With Scripter.DefineClass(TMouse) do
  begin
    DefineMethod('Create',0,tkClass,TMouse,__TMouseCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TMouseDestroy,false,0);
    DefineMethod('SettingChanged',1,tkNone,nil,__TMouseSettingChanged,false,0);
    DefineProp('Capture',tkInteger,__GetTMouseCapture,__SetTMouseCapture,nil,false,0);
    DefineProp('CursorPos',tkVariant,__GetTMouseCursorPos,__SetTMouseCursorPos,nil,false,0);
    DefineProp('DragImmediate',tkVariant,__GetTMouseDragImmediate,__SetTMouseDragImmediate,nil,false,0);
    DefineProp('DragThreshold',tkInteger,__GetTMouseDragThreshold,__SetTMouseDragThreshold,nil,false,0);
    DefineProp('MousePresent',tkVariant,__GetTMouseMousePresent,nil,nil,false,0);
    DefineProp('IsDragging',tkVariant,__GetTMouseIsDragging,nil,nil,false,0);
    DefineProp('RegWheelMessage',tkInteger,__GetTMouseRegWheelMessage,nil,nil,false,0);
    DefineProp('WheelPresent',tkVariant,__GetTMouseWheelPresent,nil,nil,false,0);
    DefineProp('WheelScrollLines',tkInteger,__GetTMouseWheelScrollLines,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TCustomListControl) do
  begin
    DefineMethod('AddItem',2,tkNone,nil,__TCustomListControlAddItem,false,0);
    DefineMethod('Clear',0,tkNone,nil,__TCustomListControlClear,false,0);
    DefineMethod('ClearSelection',0,tkNone,nil,__TCustomListControlClearSelection,false,0);
    DefineMethod('CopySelection',1,tkNone,nil,__TCustomListControlCopySelection,false,0);
    DefineMethod('DeleteSelected',0,tkNone,nil,__TCustomListControlDeleteSelected,false,0);
    DefineMethod('MoveSelection',1,tkNone,nil,__TCustomListControlMoveSelection,false,0);
    DefineMethod('SelectAll',0,tkNone,nil,__TCustomListControlSelectAll,false,0);
    DefineProp('ItemIndex',tkInteger,__GetTCustomListControlItemIndex,__SetTCustomListControlItemIndex,nil,false,0);
  end;
  With Scripter.DefineClass(TCustomMultiSelectListControl) do
  begin
    DefineProp('MultiSelect',tkVariant,__GetTCustomMultiSelectListControlMultiSelect,__SetTCustomMultiSelectListControlMultiSelect,nil,false,0);
    DefineProp('SelCount',tkInteger,__GetTCustomMultiSelectListControlSelCount,nil,nil,false,0);
  end;
  DefineEventAdapter(TypeInfo(TMouseEvent), TatControlsDispatcher, @TatControlsDispatcher.__TMouseEvent);
  DefineEventAdapter(TypeInfo(TMouseMoveEvent), TatControlsDispatcher, @TatControlsDispatcher.__TMouseMoveEvent);
  DefineEventAdapter(TypeInfo(TMouseActivateEvent), TatControlsDispatcher, @TatControlsDispatcher.__TMouseActivateEvent);
  DefineEventAdapter(TypeInfo(TKeyEvent), TatControlsDispatcher, @TatControlsDispatcher.__TKeyEvent);
  DefineEventAdapter(TypeInfo(TKeyPressEvent), TatControlsDispatcher, @TatControlsDispatcher.__TKeyPressEvent);
  DefineEventAdapter(TypeInfo(TDragOverEvent), TatControlsDispatcher, @TatControlsDispatcher.__TDragOverEvent);
  DefineEventAdapter(TypeInfo(TDragDropEvent), TatControlsDispatcher, @TatControlsDispatcher.__TDragDropEvent);
  DefineEventAdapter(TypeInfo(TStartDragEvent), TatControlsDispatcher, @TatControlsDispatcher.__TStartDragEvent);
  DefineEventAdapter(TypeInfo(TEndDragEvent), TatControlsDispatcher, @TatControlsDispatcher.__TEndDragEvent);
  DefineEventAdapter(TypeInfo(TDockDropEvent), TatControlsDispatcher, @TatControlsDispatcher.__TDockDropEvent);
  DefineEventAdapter(TypeInfo(TDockOverEvent), TatControlsDispatcher, @TatControlsDispatcher.__TDockOverEvent);
  DefineEventAdapter(TypeInfo(TUnDockEvent), TatControlsDispatcher, @TatControlsDispatcher.__TUnDockEvent);
  DefineEventAdapter(TypeInfo(TStartDockEvent), TatControlsDispatcher, @TatControlsDispatcher.__TStartDockEvent);
  DefineEventAdapter(TypeInfo(TCanResizeEvent), TatControlsDispatcher, @TatControlsDispatcher.__TCanResizeEvent);
  DefineEventAdapter(TypeInfo(TConstrainedResizeEvent), TatControlsDispatcher, @TatControlsDispatcher.__TConstrainedResizeEvent);
  DefineEventAdapter(TypeInfo(TAlignInsertBeforeEvent), TatControlsDispatcher, @TatControlsDispatcher.__TAlignInsertBeforeEvent);
  DefineEventAdapter(TypeInfo(TForEachZoneProc), TatControlsDispatcher, @TatControlsDispatcher.__TForEachZoneProc);
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('IsPositiveResult',1,tkVariant,nil,__IsPositiveResult,false,0);
    DefineMethod('IsNegativeResult',1,tkVariant,nil,__IsNegativeResult,false,0);
    DefineMethod('IsAbortResult',1,tkVariant,nil,__IsAbortResult,false,0);
    DefineMethod('IsAnAllResult',1,tkVariant,nil,__IsAnAllResult,false,0);
    DefineMethod('StripAllFromResult',1,tkEnumeration,nil,__StripAllFromResult,false,0);
    DefineMethod('IsDragObject',1,tkVariant,nil,__IsDragObject,false,0);
    DefineMethod('FindControl',1,tkClass,TWinControl,__FindControl,false,0);
    DefineMethod('FindVCLWindow',1,tkClass,TWinControl,__FindVCLWindow,false,0);
    DefineMethod('FindDragTarget',2,tkClass,TControl,__FindDragTarget,false,0);
    DefineMethod('GetCaptureControl',0,tkClass,TControl,__GetCaptureControl,false,0);
    DefineMethod('SetCaptureControl',1,tkNone,nil,__SetCaptureControl,false,0);
    DefineMethod('CancelDrag',0,tkNone,nil,__CancelDrag,false,0);
    DefineMethod('CursorToString',1,tkVariant,nil,__CursorToString,false,0);
    DefineMethod('StringToCursor',1,tkEnumeration,nil,__StringToCursor,false,0);
    DefineMethod('CursorToIdent',2,tkVariant,nil,__CursorToIdent,false,0).SetVarArgs([1]);
    DefineMethod('IdentToCursor',2,tkVariant,nil,__IdentToCursor,false,0).SetVarArgs([1]);
    DefineMethod('GetShortHint',1,tkVariant,nil,__GetShortHint,false,0);
    DefineMethod('GetLongHint',1,tkVariant,nil,__GetLongHint,false,0);
    DefineMethod('PerformEraseBackground',2,tkNone,nil,__PerformEraseBackground,false,0);
    DefineMethod('InitWndProc',4,tkInteger,nil,__InitWndProc,false,0);
    DefineMethod('ChangeBiDiModeAlignment',1,tkNone,nil,__ChangeBiDiModeAlignment,false,0).SetVarArgs([0]);
    DefineMethod('SendAppMessage',3,tkInteger,nil,__SendAppMessage,false,0);
    DefineMethod('MoveWindowOrg',3,tkNone,nil,__MoveWindowOrg,false,0);
    DefineMethod('SetImeMode',2,tkNone,nil,__SetImeMode,false,0);
    DefineMethod('SetImeName',1,tkNone,nil,__SetImeName,false,0);
    DefineMethod('Win32NLSEnableIME',2,tkVariant,nil,__Win32NLSEnableIME,false,0);
    DefineMethod('Imm32GetContext',1,tkInteger,nil,__Imm32GetContext,false,0);
    DefineMethod('Imm32ReleaseContext',2,tkVariant,nil,__Imm32ReleaseContext,false,0);
    DefineMethod('Imm32GetConversionStatus',3,tkVariant,nil,__Imm32GetConversionStatus,false,0).SetVarArgs([1,2]);
    DefineMethod('Imm32SetConversionStatus',3,tkVariant,nil,__Imm32SetConversionStatus,false,0);
    DefineMethod('Imm32SetOpenStatus',2,tkVariant,nil,__Imm32SetOpenStatus,false,0);
    DefineMethod('Imm32IsIME',1,tkVariant,nil,__Imm32IsIME,false,0);
    DefineMethod('Imm32NotifyIME',4,tkVariant,nil,__Imm32NotifyIME,false,0);
    DefineMethod('DragDone',1,tkNone,nil,__DragDone,false,0);
    DefineProp('Mouse',tkClass,__GetMouse,__SetMouse,TMouse,false,0);
    DefineProp('CreationControl',tkClass,__GetCreationControl,__SetCreationControl,TWinControl,false,0);
    DefineProp('NewStyleControls',tkVariant,__GetNewStyleControls,__SetNewStyleControls,nil,false,0);
    AddConstant('dmDragEnter',dmDragEnter);
    AddConstant('dmDragLeave',dmDragLeave);
    AddConstant('dmDragMove',dmDragMove);
    AddConstant('dmDragDrop',dmDragDrop);
    AddConstant('dmDragCancel',dmDragCancel);
    AddConstant('dmFindTarget',dmFindTarget);
    AddConstant('alNone',alNone);
    AddConstant('alTop',alTop);
    AddConstant('alBottom',alBottom);
    AddConstant('alLeft',alLeft);
    AddConstant('alRight',alRight);
    AddConstant('alClient',alClient);
    AddConstant('alCustom',alCustom);
    AddConstant('mbLeft',mbLeft);
    AddConstant('mbRight',mbRight);
    AddConstant('mbMiddle',mbMiddle);
    AddConstant('maDefault',maDefault);
    AddConstant('maActivate',maActivate);
    AddConstant('maActivateAndEat',maActivateAndEat);
    AddConstant('maNoActivate',maNoActivate);
    AddConstant('maNoActivateAndEat',maNoActivateAndEat);
    AddConstant('dmManual',dmManual);
    AddConstant('dmAutomatic',dmAutomatic);
    AddConstant('dsDragEnter',dsDragEnter);
    AddConstant('dsDragLeave',dsDragLeave);
    AddConstant('dsDragMove',dsDragMove);
    AddConstant('dkDrag',dkDrag);
    AddConstant('dkDock',dkDock);
    AddConstant('akLeft',akLeft);
    AddConstant('akTop',akTop);
    AddConstant('akRight',akRight);
    AddConstant('akBottom',akBottom);
    AddConstant('doNoOrient',doNoOrient);
    AddConstant('doHorizontal',doHorizontal);
    AddConstant('doVertical',doVertical);
    AddConstant('imDisable',imDisable);
    AddConstant('imClose',imClose);
    AddConstant('imOpen',imOpen);
    AddConstant('imDontCare',imDontCare);
    AddConstant('imSAlpha',imSAlpha);
    AddConstant('imAlpha',imAlpha);
    AddConstant('imHira',imHira);
    AddConstant('imSKata',imSKata);
    AddConstant('imKata',imKata);
    AddConstant('imChinese',imChinese);
    AddConstant('imSHanguel',imSHanguel);
    AddConstant('imHanguel',imHanguel);
    AddConstant('bvNone',bvNone);
    AddConstant('bvLowered',bvLowered);
    AddConstant('bvRaised',bvRaised);
    AddConstant('bvSpace',bvSpace);
    AddConstant('beLeft',beLeft);
    AddConstant('beTop',beTop);
    AddConstant('beRight',beRight);
    AddConstant('beBottom',beBottom);
    AddConstant('bkNone',bkNone);
    AddConstant('bkTile',bkTile);
    AddConstant('bkSoft',bkSoft);
    AddConstant('bkFlat',bkFlat);
    AddConstant('CM_BASE',CM_BASE);
    AddConstant('CM_ACTIVATE',CM_ACTIVATE);
    AddConstant('CM_DEACTIVATE',CM_DEACTIVATE);
    AddConstant('CM_GOTFOCUS',CM_GOTFOCUS);
    AddConstant('CM_LOSTFOCUS',CM_LOSTFOCUS);
    AddConstant('CM_CANCELMODE',CM_CANCELMODE);
    AddConstant('CM_DIALOGKEY',CM_DIALOGKEY);
    AddConstant('CM_DIALOGCHAR',CM_DIALOGCHAR);
    AddConstant('CM_FOCUSCHANGED',CM_FOCUSCHANGED);
    AddConstant('CM_PARENTFONTCHANGED',CM_PARENTFONTCHANGED);
    AddConstant('CM_PARENTCOLORCHANGED',CM_PARENTCOLORCHANGED);
    AddConstant('CM_HITTEST',CM_HITTEST);
    AddConstant('CM_VISIBLECHANGED',CM_VISIBLECHANGED);
    AddConstant('CM_ENABLEDCHANGED',CM_ENABLEDCHANGED);
    AddConstant('CM_COLORCHANGED',CM_COLORCHANGED);
    AddConstant('CM_FONTCHANGED',CM_FONTCHANGED);
    AddConstant('CM_CURSORCHANGED',CM_CURSORCHANGED);
    AddConstant('CM_CTL3DCHANGED',CM_CTL3DCHANGED);
    AddConstant('CM_PARENTCTL3DCHANGED',CM_PARENTCTL3DCHANGED);
    AddConstant('CM_TEXTCHANGED',CM_TEXTCHANGED);
    AddConstant('CM_MOUSEENTER',CM_MOUSEENTER);
    AddConstant('CM_MOUSELEAVE',CM_MOUSELEAVE);
    AddConstant('CM_MENUCHANGED',CM_MENUCHANGED);
    AddConstant('CM_APPKEYDOWN',CM_APPKEYDOWN);
    AddConstant('CM_APPSYSCOMMAND',CM_APPSYSCOMMAND);
    AddConstant('CM_BUTTONPRESSED',CM_BUTTONPRESSED);
    AddConstant('CM_SHOWINGCHANGED',CM_SHOWINGCHANGED);
    AddConstant('CM_ENTER',CM_ENTER);
    AddConstant('CM_EXIT',CM_EXIT);
    AddConstant('CM_DESIGNHITTEST',CM_DESIGNHITTEST);
    AddConstant('CM_ICONCHANGED',CM_ICONCHANGED);
    AddConstant('CM_WANTSPECIALKEY',CM_WANTSPECIALKEY);
    AddConstant('CM_INVOKEHELP',CM_INVOKEHELP);
    AddConstant('CM_WINDOWHOOK',CM_WINDOWHOOK);
    AddConstant('CM_RELEASE',CM_RELEASE);
    AddConstant('CM_SHOWHINTCHANGED',CM_SHOWHINTCHANGED);
    AddConstant('CM_PARENTSHOWHINTCHANGED',CM_PARENTSHOWHINTCHANGED);
    AddConstant('CM_SYSCOLORCHANGE',CM_SYSCOLORCHANGE);
    AddConstant('CM_WININICHANGE',CM_WININICHANGE);
    AddConstant('CM_FONTCHANGE',CM_FONTCHANGE);
    AddConstant('CM_TIMECHANGE',CM_TIMECHANGE);
    AddConstant('CM_TABSTOPCHANGED',CM_TABSTOPCHANGED);
    AddConstant('CM_UIACTIVATE',CM_UIACTIVATE);
    AddConstant('CM_UIDEACTIVATE',CM_UIDEACTIVATE);
    AddConstant('CM_DOCWINDOWACTIVATE',CM_DOCWINDOWACTIVATE);
    AddConstant('CM_CONTROLLISTCHANGE',CM_CONTROLLISTCHANGE);
    AddConstant('CM_GETDATALINK',CM_GETDATALINK);
    AddConstant('CM_CHILDKEY',CM_CHILDKEY);
    AddConstant('CM_DRAG',CM_DRAG);
    AddConstant('CM_HINTSHOW',CM_HINTSHOW);
    AddConstant('CM_DIALOGHANDLE',CM_DIALOGHANDLE);
    AddConstant('CM_ISTOOLCONTROL',CM_ISTOOLCONTROL);
    AddConstant('CM_RECREATEWND',CM_RECREATEWND);
    AddConstant('CM_INVALIDATE',CM_INVALIDATE);
    AddConstant('CM_SYSFONTCHANGED',CM_SYSFONTCHANGED);
    AddConstant('CM_CONTROLCHANGE',CM_CONTROLCHANGE);
    AddConstant('CM_CHANGED',CM_CHANGED);
    AddConstant('CM_DOCKCLIENT',CM_DOCKCLIENT);
    AddConstant('CM_UNDOCKCLIENT',CM_UNDOCKCLIENT);
    AddConstant('CM_FLOAT',CM_FLOAT);
    AddConstant('CM_BORDERCHANGED',CM_BORDERCHANGED);
    AddConstant('CM_BIDIMODECHANGED',CM_BIDIMODECHANGED);
    AddConstant('CM_PARENTBIDIMODECHANGED',CM_PARENTBIDIMODECHANGED);
    AddConstant('CM_ALLCHILDRENFLIPPED',CM_ALLCHILDRENFLIPPED);
    AddConstant('CM_ACTIONUPDATE',CM_ACTIONUPDATE);
    AddConstant('CM_ACTIONEXECUTE',CM_ACTIONEXECUTE);
    AddConstant('CM_HINTSHOWPAUSE',CM_HINTSHOWPAUSE);
    AddConstant('CM_DOCKNOTIFICATION',CM_DOCKNOTIFICATION);
    AddConstant('CM_MOUSEWHEEL',CM_MOUSEWHEEL);
    AddConstant('CM_ISSHORTCUT',CM_ISSHORTCUT);
    AddConstant('CM_INVALIDATEDOCKHOST',CM_INVALIDATEDOCKHOST);
    AddConstant('CM_SETACTIVECONTROL',CM_SETACTIVECONTROL);
    AddConstant('CM_POPUPHWNDDESTROY',CM_POPUPHWNDDESTROY);
    AddConstant('CM_CREATEPOPUP',CM_CREATEPOPUP);
    AddConstant('CM_DESTROYHANDLE',CM_DESTROYHANDLE);
    AddConstant('CM_MOUSEACTIVATE',CM_MOUSEACTIVATE);
    AddConstant('CN_BASE',CN_BASE);
    AddConstant('CN_CHARTOITEM',CN_CHARTOITEM);
    AddConstant('CN_COMMAND',CN_COMMAND);
    AddConstant('CN_COMPAREITEM',CN_COMPAREITEM);
    AddConstant('CN_CTLCOLORBTN',CN_CTLCOLORBTN);
    AddConstant('CN_CTLCOLORDLG',CN_CTLCOLORDLG);
    AddConstant('CN_CTLCOLOREDIT',CN_CTLCOLOREDIT);
    AddConstant('CN_CTLCOLORLISTBOX',CN_CTLCOLORLISTBOX);
    AddConstant('CN_CTLCOLORMSGBOX',CN_CTLCOLORMSGBOX);
    AddConstant('CN_CTLCOLORSCROLLBAR',CN_CTLCOLORSCROLLBAR);
    AddConstant('CN_CTLCOLORSTATIC',CN_CTLCOLORSTATIC);
    AddConstant('CN_DELETEITEM',CN_DELETEITEM);
    AddConstant('CN_DRAWITEM',CN_DRAWITEM);
    AddConstant('CN_HSCROLL',CN_HSCROLL);
    AddConstant('CN_MEASUREITEM',CN_MEASUREITEM);
    AddConstant('CN_PARENTNOTIFY',CN_PARENTNOTIFY);
    AddConstant('CN_VKEYTOITEM',CN_VKEYTOITEM);
    AddConstant('CN_VSCROLL',CN_VSCROLL);
    AddConstant('CN_KEYDOWN',CN_KEYDOWN);
    AddConstant('CN_KEYUP',CN_KEYUP);
    AddConstant('CN_CHAR',CN_CHAR);
    AddConstant('CN_SYSKEYDOWN',CN_SYSKEYDOWN);
    AddConstant('CN_SYSCHAR',CN_SYSCHAR);
    AddConstant('CN_NOTIFY',CN_NOTIFY);
    AddConstant('mrNone',mrNone);
    AddConstant('mrOk',mrOk);
    AddConstant('mrCancel',mrCancel);
    AddConstant('mrAbort',mrAbort);
    AddConstant('mrRetry',mrRetry);
    AddConstant('mrIgnore',mrIgnore);
    AddConstant('mrYes',mrYes);
    AddConstant('mrNo',mrNo);
    AddConstant('mrAll',mrAll);
    AddConstant('mrNoToAll',mrNoToAll);
    AddConstant('mrYesToAll',mrYesToAll);
    AddConstant('crDefault',crDefault);
    AddConstant('crNone',crNone);
    AddConstant('crArrow',crArrow);
    AddConstant('crCross',crCross);
    AddConstant('crIBeam',crIBeam);
    AddConstant('crSize',crSize);
    AddConstant('crSizeNESW',crSizeNESW);
    AddConstant('crSizeNS',crSizeNS);
    AddConstant('crSizeNWSE',crSizeNWSE);
    AddConstant('crSizeWE',crSizeWE);
    AddConstant('crUpArrow',crUpArrow);
    AddConstant('crHourGlass',crHourGlass);
    AddConstant('crDrag',crDrag);
    AddConstant('crNoDrop',crNoDrop);
    AddConstant('crHSplit',crHSplit);
    AddConstant('crVSplit',crVSplit);
    AddConstant('crMultiDrag',crMultiDrag);
    AddConstant('crSQLWait',crSQLWait);
    AddConstant('crNo',crNo);
    AddConstant('crAppStart',crAppStart);
    AddConstant('crHelp',crHelp);
    AddConstant('crHandPoint',crHandPoint);
    AddConstant('crSizeAll',crSizeAll);
    AddConstant('CTL3D_ALL',CTL3D_ALL);
  end;
end;

class function TatControlsLibrary.LibraryName: string;
begin
  result := 'Controls';
end;

initialization
  RegisterScripterLibrary(TatControlsLibrary, True);

{$WARNINGS ON}

end.

