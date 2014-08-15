// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ap_Controls.pas' rev: 22.00

#ifndef Ap_controlsHPP
#define Ap_controlsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <MultiMon.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <CommCtrl.hpp>	// Pascal unit
#include <Imm.hpp>	// Pascal unit
#include <ImgList.hpp>	// Pascal unit
#include <ActnList.hpp>	// Pascal unit
#include <SyncObjs.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <ap_Types.hpp>	// Pascal unit
#include <ap_Messages.hpp>	// Pascal unit
#include <ap_Windows.hpp>	// Pascal unit
#include <atScript.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ap_controls
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TatControlsLibrary;
class PASCALIMPLEMENTATION TatControlsLibrary : public Atscript::TatScripterLibrary
{
	typedef Atscript::TatScripterLibrary inherited;
	
public:
	void __fastcall __TDragObjectAssign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TDragObjectGetName(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TDragObjectHideDragImage(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TDragObjectInstance(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TDragObjectShowDragImage(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTDragObjectAlwaysShowDragImages(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTDragObjectAlwaysShowDragImages(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTDragObjectCancelling(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTDragObjectCancelling(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTDragObjectDragHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTDragObjectDragHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTDragObjectDragPos(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTDragObjectDragPos(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTDragObjectDragTargetPos(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTDragObjectDragTargetPos(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTDragObjectDropped(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTDragObjectMouseDeltaX(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTDragObjectMouseDeltaY(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTDragObjectRightClickCancels(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTDragObjectRightClickCancels(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBaseDragControlObjectCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBaseDragControlObjectAssign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTBaseDragControlObjectControl(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTBaseDragControlObjectControl(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TDragControlObjectHideDragImage(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TDragControlObjectShowDragImage(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TDragDockObjectCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TDragDockObjectDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TDragDockObjectAssign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTDragDockObjectBrush(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTDragDockObjectBrush(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTDragDockObjectDockRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTDragDockObjectDockRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTDragDockObjectDropAlign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTDragDockObjectDropOnControl(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTDragDockObjectEraseDockRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTDragDockObjectEraseDockRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTDragDockObjectEraseWhenMoving(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTDragDockObjectFloating(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTDragDockObjectFloating(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTDragDockObjectFrameWidth(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlCanvasDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlCanvasFreeHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlCanvasUpdateTextFlags(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTControlCanvasControl(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTControlCanvasControl(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomControlActionDropdownMenu(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomControlActionDropdownMenu(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomControlActionEnableDropdown(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomControlActionEnableDropdown(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomControlActionPopupMenu(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomControlActionPopupMenu(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TSizeConstraintsCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMarginsCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMarginsSetControlBounds(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMarginsSetBounds(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMarginsControlLeft(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMarginsControlTop(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMarginsControlWidth(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMarginsControlHeight(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMarginsExplicitLeft(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMarginsExplicitTop(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMarginsExplicitWidth(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMarginsExplicitHeight(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomGestureCollectionItemDeviation(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomGestureCollectionItemDeviation(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomGestureCollectionItemErrorMargin(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomGestureCollectionItemErrorMargin(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomGestureCollectionItemGestureID(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomGestureCollectionItemGestureID(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomGestureCollectionItemGestureType(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomGestureCollectionItemOptions(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomGestureCollectionItemOptions(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomGestureCollectionItemName(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomGestureCollectionItemName(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomGestureCollectionItemAction(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomGestureCollectionItemAction(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomGestureCollectionAddGesture(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomGestureCollectionFindGesture(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomGestureCollectionGetUniqueGestureID(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomGestureCollectionRemoveGesture(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomGestureCollectionGestureManager(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomGestureCollectionItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomGestureCollectionItems(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomGestureManagerAddRecordedGesture(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomGestureManagerFindCustomGesture(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomGestureManagerFindGesture(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomGestureManagerRegisterControl(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomGestureManagerRemoveRecordedGesture(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomGestureManagerSelectGesture(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomGestureManagerUnregisterControl(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomGestureManagerUnselectGesture(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomGestureManagerStandardGestures(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomGestureManagerStandardGestures(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTouchManagerCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTouchManagerDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTouchManagerChangeNotification(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTouchManagerFindGesture(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTouchManagerRemoveChangeNotification(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTouchManagerSelectGesture(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTouchManagerUnselectGesture(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTouchManagerGestureEngine(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTouchManagerGestureEngine(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTouchManagerGestureManager(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTouchManagerGestureManager(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTouchManagerInteractiveGestures(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTouchManagerInteractiveGestures(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTouchManagerInteractiveGestureOptions(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTouchManagerInteractiveGestureOptions(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTouchManagerParentTabletOptions(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTouchManagerParentTabletOptions(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTouchManagerStandardGestures(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTouchManagerStandardGestures(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTouchManagerTabletOptions(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTouchManagerTabletOptions(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlBeginDrag(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlBringToFront(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlClientToScreen(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlClientToParent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlDock(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlDragging(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlDragDrop(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlDrawTextBiDiModeFlags(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlDrawTextBiDiModeFlagsReadingOnly(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlEndDrag(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlGetControlsAlignment(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlGetParentComponent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlHasParent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlHide(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlInitiateAction(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlInvalidate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlMouseWheelHandler(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlIsRightToLeft(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlManualDock(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlManualFloat(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlPerform(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlRefresh(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlRepaint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlReplaceDockedControl(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlScreenToClient(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlParentToClient(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlSendToBack(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlSetBounds(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlSetDesignVisible(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlSetParentComponent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlShow(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlUpdate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlUseRightToLeftAlignment(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlUseRightToLeftReading(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlUseRightToLeftScrollBar(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlDefaultHandler(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlGetTextBuf(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlGetTextLen(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlSetTextBuf(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTControlEnabled(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTControlEnabled(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTControlAction(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTControlAction(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTControlAlign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTControlAlign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTControlAnchors(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTControlAnchors(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTControlBiDiMode(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTControlBiDiMode(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTControlBoundsRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTControlBoundsRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTControlClientHeight(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTControlClientHeight(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTControlClientOrigin(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTControlClientRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTControlClientWidth(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTControlClientWidth(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTControlConstraints(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTControlConstraints(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTControlControlState(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTControlControlState(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTControlControlStyle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTControlControlStyle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTControlDockOrientation(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTControlDockOrientation(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTControlExplicitLeft(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTControlExplicitTop(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTControlExplicitWidth(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTControlExplicitHeight(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTControlFloating(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTControlHostDockSite(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTControlHostDockSite(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTControlLRDockWidth(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTControlLRDockWidth(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTControlShowHint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTControlShowHint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTControlTBDockHeight(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTControlTBDockHeight(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTControlTouch(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTControlTouch(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTControlUndockHeight(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTControlUndockHeight(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTControlUndockWidth(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTControlUndockWidth(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTControlVisible(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTControlVisible(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTControlParent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTControlParent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWinControlGetTextLen(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWinControlCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWinControlCreateParented(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWinControlCreateParentedControl(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWinControlDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWinControlBroadcast(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWinControlCanFocus(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWinControlContainsControl(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWinControlControlAtPos(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWinControlDefaultHandler(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWinControlDisableAlign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWinControlDockDrop(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWinControlEnableAlign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWinControlFindChildControl(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWinControlFlipChildren(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWinControlFocused(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWinControlGetTabControlList(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWinControlGetTabOrderList(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWinControlHandleAllocated(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWinControlHandleNeeded(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWinControlInsertControl(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWinControlInvalidate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWinControlPaintTo(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWinControlPreProcessMessage(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWinControlRemoveControl(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWinControlRealign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWinControlRepaint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWinControlScaleBy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWinControlScrollBy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWinControlSetBounds(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWinControlSetDesignVisible(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWinControlSetFocus(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWinControlUpdate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TWinControlUpdateControlState(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTWinControlDockClientCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTWinControlDockClients(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTWinControlDockSite(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTWinControlDockSite(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTWinControlDoubleBuffered(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTWinControlDoubleBuffered(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTWinControlAlignDisabled(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTWinControlMouseInClient(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTWinControlVisibleDockClientCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTWinControlBrush(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTWinControlControls(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTWinControlControlCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTWinControlHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTWinControlPadding(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTWinControlPadding(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTWinControlParentDoubleBuffered(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTWinControlParentDoubleBuffered(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTWinControlParentWindow(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTWinControlParentWindow(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTWinControlShowing(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTWinControlTabOrder(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTWinControlTabOrder(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTWinControlTabStop(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTWinControlTabStop(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTWinControlUseDockManager(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTWinControlUseDockManager(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TGraphicControlCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TGraphicControlDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomControlCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomControlDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTransparentControlCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomTransparentControlInvalidate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomTransparentControlInterceptMouse(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomTransparentControlInterceptMouse(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __THintWindowCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __THintWindowActivateHint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __THintWindowIsHintMsg(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __THintWindowShouldHideHint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __THintWindowReleaseHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TDragImageListBeginDrag(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TDragImageListDragLock(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TDragImageListDragMove(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TDragImageListDragUnlock(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TDragImageListEndDrag(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TDragImageListGetHotSpot(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TDragImageListHideDragImage(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TDragImageListSetDragImage(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TDragImageListShowDragImage(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTDragImageListDragCursor(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTDragImageListDragCursor(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTDragImageListDragHotspot(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTDragImageListDragHotspot(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTDragImageListDragging(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TDockZoneCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TDockZoneExpandZoneLimit(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TDockZoneFirstVisibleChild(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TDockZoneNextVisible(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TDockZonePrevVisible(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TDockZoneResetChildren(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TDockZoneResetZoneLimits(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TDockZoneUpdate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTDockZoneChildCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTDockZoneChildControl(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTDockZoneHeight(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTDockZoneLeft(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTDockZoneLimitBegin(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTDockZoneLimitSize(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTDockZoneTop(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTDockZoneVisible(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTDockZoneVisibleChildCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTDockZoneWidth(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTDockZoneZoneLimit(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTDockZoneZoneLimit(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TDockTreeCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TDockTreeDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TDockTreePaintSite(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomPanningWindowGetIsPanning(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomPanningWindowStartPanning(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomPanningWindowStopPanning(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMouseCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMouseDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMouseSettingChanged(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TMouseCreatePanningWindow(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMouseCapture(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTMouseCapture(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMouseCursorPos(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTMouseCursorPos(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMouseDragImmediate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTMouseDragImmediate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMouseDragThreshold(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTMouseDragThreshold(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMouseMousePresent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMouseIsDragging(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMouseIsPanning(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMousePanningWindow(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTMousePanningWindow(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMouseRegWheelMessage(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMouseWheelPresent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMouseWheelScrollLines(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListControlCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListControlAddItem(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListControlClear(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListControlClearSelection(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListControlCopySelection(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListControlDeleteSelected(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListControlGetCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListControlMoveSelection(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomListControlSelectAll(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomListControlItemIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomListControlItemIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomMultiSelectListControlMultiSelect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomMultiSelectListControlMultiSelect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomMultiSelectListControlSelCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomHintWindowCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomHintWindowAutoSize(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomHintWindowPositionAt(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomHintWindowPositionAtCursor(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomHintWindowHintParent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomHintWindowHintParent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomHintWindowPopAbove(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomHintWindowTitle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomHintWindowDescription(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomHintWindowImageIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomHintShowHideThreadCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomHintShowHideThreadDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomHintShowHideThreadResumeWork(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomHintShowHideThreadExecute(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomHintShowHideThreadHideHint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomHintCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomHintDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomHintShowHint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomHintHideHint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomHintPaintHint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomHintNCPaintHint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomHintSetHintSize(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomHintShowingHint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomHintTitle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomHintTitle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomHintDescription(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomHintDescription(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomHintImageIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomHintImageIndex(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBalloonHintPaintHint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TBalloonHintSetHintSize(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __IsPositiveResult(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __IsNegativeResult(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __IsAbortResult(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __IsAnAllResult(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __StripAllFromResult(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __IsDragObject(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __IsVCLControl(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __FindControl(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __FindVCLWindow(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __FindDragTarget(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetCaptureControl(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetCaptureControl(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CancelDrag(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CursorToString(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __StringToCursor(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __CursorToIdent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __IdentToCursor(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetShortHint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetLongHint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __PerformEraseBackground(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __PerformBufferedPrintClient(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __MouseOriginToShiftState(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __InitWndProc(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ChangeBiDiModeAlignment(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SendAppMessage(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __MoveWindowOrg(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetImeMode(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetImeName(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Win32NLSEnableIME(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Imm32GetContext(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Imm32ReleaseContext(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Imm32GetConversionStatus(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Imm32SetConversionStatus(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Imm32SetOpenStatus(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Imm32SetCompositionFont(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Imm32IsIME(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __Imm32NotifyIME(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __DragDone(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetMouse(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetMouse(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetCreationControl(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetCreationControl(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetNewStyleControls(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetNewStyleControls(Atscript::TatVirtualMachine* AMachine);
	virtual void __fastcall Init(void);
	__classmethod virtual System::UnicodeString __fastcall LibraryName();
public:
	/* TatScripterLibrary.Create */ inline __fastcall virtual TatControlsLibrary(Atscript::TatCustomScripter* AScripter) : Atscript::TatScripterLibrary(AScripter) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TatControlsLibrary(void) { }
	
};


typedef TMetaClass* TDragObjectClass;

typedef TMetaClass* TBaseDragControlObjectClass;

typedef TMetaClass* TDragControlObjectClass;

typedef TMetaClass* TDragDockObjectClass;

typedef TMetaClass* TControlCanvasClass;

typedef TMetaClass* TCustomControlActionClass;

typedef TMetaClass* TControlActionClass;

typedef TMetaClass* TControlActionLinkClass;

typedef TMetaClass* TSizeConstraintsClass;

typedef TMetaClass* TMarginsClass;

typedef TMetaClass* TPaddingClass;

typedef TMetaClass* EGestureExceptionClass;

typedef TMetaClass* TCustomGestureCollectionItemClass;

typedef TMetaClass* TCustomGestureCollectionClass;

typedef TMetaClass* TCustomGestureManagerClass;

typedef TMetaClass* TCustomGestureEngineClass;

typedef TMetaClass* TCustomTouchManagerClass;

typedef TMetaClass* TTouchManagerClass;

typedef TMetaClass* TControlClass;

typedef TMetaClass* TWinControlActionLinkClass;

typedef TMetaClass* TWinControlClass;

typedef TMetaClass* TGraphicControlClass;

typedef TMetaClass* TCustomControlClass;

typedef TMetaClass* TCustomTransparentControlClass;

typedef TMetaClass* THintWindowClass;

typedef TMetaClass* TDragImageListClass;

typedef TMetaClass* TImageListClass;

typedef TMetaClass* TDockZoneClass;

typedef TMetaClass* TDockTreeClass;

typedef TMetaClass* TCustomPanningWindowClass;

typedef TMetaClass* TMouseClass;

typedef TMetaClass* TCustomListControlClass;

typedef TMetaClass* TCustomMultiSelectListControlClass;

typedef TMetaClass* TCustomHintWindowClass;

typedef TMetaClass* TCustomHintShowHideThreadClass;

typedef TMetaClass* TCustomHintClass;

typedef TMetaClass* TBalloonHintClass;

class DELPHICLASS TatControlsDispatcher;
class PASCALIMPLEMENTATION TatControlsDispatcher : public Atscript::TatEventDispatcher
{
	typedef Atscript::TatEventDispatcher inherited;
	
private:
	void __fastcall __TMouseEvent(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall __TMouseMoveEvent(System::TObject* Sender, Classes::TShiftState Shift, int X, int Y);
	void __fastcall __TMouseActivateEvent(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y, int HitTest, Controls::TMouseActivate &MouseActivate);
	void __fastcall __TKeyEvent(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall __TKeyPressEvent(System::TObject* Sender, System::WideChar &Key);
	void __fastcall __TDragOverEvent(System::TObject* Sender, System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall __TDragDropEvent(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall __TStartDragEvent(System::TObject* Sender, Controls::TDragObject* &DragObject);
	void __fastcall __TEndDragEvent(System::TObject* Sender, System::TObject* Target, int X, int Y);
	void __fastcall __TDockDropEvent(System::TObject* Sender, Controls::TDragDockObject* Source, int X, int Y);
	void __fastcall __TDockOverEvent(System::TObject* Sender, Controls::TDragDockObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall __TUnDockEvent(System::TObject* Sender, Controls::TControl* Client, Controls::TWinControl* NewTarget, bool &Allow);
	void __fastcall __TStartDockEvent(System::TObject* Sender, Controls::TDragDockObject* &DragObject);
	void __fastcall __TCanResizeEvent(System::TObject* Sender, int &NewWidth, int &NewHeight, bool &Resize);
	void __fastcall __TConstrainedResizeEvent(System::TObject* Sender, int &MinWidth, int &MinHeight, int &MaxWidth, int &MaxHeight);
	bool __fastcall __TAlignInsertBeforeEvent(Controls::TWinControl* Sender, Controls::TControl* C1, Controls::TControl* C2);
	void __fastcall __TForEachZoneProc(Controls::TDockZone* Zone);
public:
	/* TatEventDispatcher.Create */ inline __fastcall virtual TatControlsDispatcher(Classes::TCollection* ACollection) : Atscript::TatEventDispatcher(ACollection) { }
	/* TatEventDispatcher.Destroy */ inline __fastcall virtual ~TatControlsDispatcher(void) { }
	
};


class DELPHICLASS TCMMouseWheelWrapper;
class PASCALIMPLEMENTATION TCMMouseWheelWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	Classes::TShiftState FShiftState;
	short FWheelDelta;
	short FXPos;
	short FYPos;
	int FResult;
	
public:
	__fastcall TCMMouseWheelWrapper(const Controls::TCMMouseWheel &ARecord);
	Controls::TCMMouseWheel __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property Classes::TShiftState ShiftState = {read=FShiftState, write=FShiftState, nodefault};
	__property short WheelDelta = {read=FWheelDelta, write=FWheelDelta, nodefault};
	__property short XPos = {read=FXPos, write=FXPos, nodefault};
	__property short YPos = {read=FYPos, write=FYPos, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TCMMouseWheelWrapper(void) { }
	
};


class DELPHICLASS TCMCancelModeWrapper;
class PASCALIMPLEMENTATION TCMCancelModeWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FUnused;
	Controls::TControl* FSender;
	int FResult;
	
public:
	__fastcall TCMCancelModeWrapper(const Controls::TCMCancelMode &ARecord);
	Controls::TCMCancelMode __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property Controls::TControl* Sender = {read=FSender, write=FSender};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TCMCancelModeWrapper(void) { }
	
};


class DELPHICLASS TCMFocusChangedWrapper;
class PASCALIMPLEMENTATION TCMFocusChangedWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FUnused;
	Controls::TWinControl* FSender;
	int FResult;
	
public:
	__fastcall TCMFocusChangedWrapper(const Controls::TCMFocusChanged &ARecord);
	Controls::TCMFocusChanged __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property Controls::TWinControl* Sender = {read=FSender, write=FSender};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TCMFocusChangedWrapper(void) { }
	
};


class DELPHICLASS TCMControlListChangeWrapper;
class PASCALIMPLEMENTATION TCMControlListChangeWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	Controls::TControl* FControl;
	BOOL FInserting;
	int FResult;
	
public:
	__fastcall TCMControlListChangeWrapper(const Controls::TCMControlListChange &ARecord);
	Controls::TCMControlListChange __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property Controls::TControl* Control = {read=FControl, write=FControl};
	__property BOOL Inserting = {read=FInserting, write=FInserting, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TCMControlListChangeWrapper(void) { }
	
};


class DELPHICLASS TControlListItemWrapper;
class PASCALIMPLEMENTATION TControlListItemWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	Controls::TControl* FControl;
	Controls::TWinControl* FParent;
	
public:
	__fastcall TControlListItemWrapper(const Controls::TControlListItem &ARecord);
	Controls::TControlListItem __fastcall ObjToRec(void);
	
__published:
	__property Controls::TControl* Control = {read=FControl, write=FControl};
	__property Controls::TWinControl* Parent = {read=FParent, write=FParent};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TControlListItemWrapper(void) { }
	
};


class DELPHICLASS TCMControlListChangingWrapper;
class PASCALIMPLEMENTATION TCMControlListChangingWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	BOOL FInserting;
	int FResult;
	
public:
	__fastcall TCMControlListChangingWrapper(const Controls::TCMControlListChanging &ARecord);
	Controls::TCMControlListChanging __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property BOOL Inserting = {read=FInserting, write=FInserting, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TCMControlListChangingWrapper(void) { }
	
};


class DELPHICLASS TCMChildKeyWrapper;
class PASCALIMPLEMENTATION TCMChildKeyWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	System::Word FCharCode;
	System::Word FUnused;
	Controls::TWinControl* FSender;
	int FResult;
	
public:
	__fastcall TCMChildKeyWrapper(const Controls::TCMChildKey &ARecord);
	Controls::TCMChildKey __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property System::Word CharCode = {read=FCharCode, write=FCharCode, nodefault};
	__property System::Word Unused = {read=FUnused, write=FUnused, nodefault};
	__property Controls::TWinControl* Sender = {read=FSender, write=FSender};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TCMChildKeyWrapper(void) { }
	
};


class DELPHICLASS TCMControlChangeWrapper;
class PASCALIMPLEMENTATION TCMControlChangeWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	Controls::TControl* FControl;
	BOOL FInserting;
	int FResult;
	
public:
	__fastcall TCMControlChangeWrapper(const Controls::TCMControlChange &ARecord);
	Controls::TCMControlChange __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property Controls::TControl* Control = {read=FControl, write=FControl};
	__property BOOL Inserting = {read=FInserting, write=FInserting, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TCMControlChangeWrapper(void) { }
	
};


class DELPHICLASS TCMChangedWrapper;
class PASCALIMPLEMENTATION TCMChangedWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FUnused;
	Controls::TControl* FChild;
	int FResult;
	
public:
	__fastcall TCMChangedWrapper(const Controls::TCMChanged &ARecord);
	Controls::TCMChanged __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int Unused = {read=FUnused, write=FUnused, nodefault};
	__property Controls::TControl* Child = {read=FChild, write=FChild};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TCMChangedWrapper(void) { }
	
};


class DELPHICLASS THintInfoWrapper;
class PASCALIMPLEMENTATION THintInfoWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	Controls::TControl* FHintControl;
	int FHintMaxWidth;
	Graphics::TColor FHintColor;
	int FReshowTimeout;
	int FHideTimeout;
	System::UnicodeString FHintStr;
	
public:
	__fastcall THintInfoWrapper(const Controls::THintInfo &ARecord);
	Controls::THintInfo __fastcall ObjToRec(void);
	
__published:
	__property Controls::TControl* HintControl = {read=FHintControl, write=FHintControl};
	__property int HintMaxWidth = {read=FHintMaxWidth, write=FHintMaxWidth, nodefault};
	__property Graphics::TColor HintColor = {read=FHintColor, write=FHintColor, nodefault};
	__property int ReshowTimeout = {read=FReshowTimeout, write=FReshowTimeout, nodefault};
	__property int HideTimeout = {read=FHideTimeout, write=FHideTimeout, nodefault};
	__property System::UnicodeString HintStr = {read=FHintStr, write=FHintStr};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~THintInfoWrapper(void) { }
	
};


class DELPHICLASS TCMParentFontChangedWrapper;
class PASCALIMPLEMENTATION TCMParentFontChangedWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FWParam;
	int FLParam;
	Graphics::TFont* FFont;
	int FResult;
	
public:
	__fastcall TCMParentFontChangedWrapper(const Controls::TCMParentFontChanged &ARecord);
	Controls::TCMParentFontChanged __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int WParam = {read=FWParam, write=FWParam, nodefault};
	__property int LParam = {read=FLParam, write=FLParam, nodefault};
	__property Graphics::TFont* Font = {read=FFont, write=FFont};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TCMParentFontChangedWrapper(void) { }
	
};


class DELPHICLASS TDragRecWrapper;
class PASCALIMPLEMENTATION TDragRecWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	Controls::TDragObject* FSource;
	bool FDocking;
	
public:
	__fastcall TDragRecWrapper(const Controls::TDragRec &ARecord);
	Controls::TDragRec __fastcall ObjToRec(void);
	
__published:
	__property Controls::TDragObject* Source = {read=FSource, write=FSource};
	__property bool Docking = {read=FDocking, write=FDocking, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TDragRecWrapper(void) { }
	
};


class DELPHICLASS TCMDragWrapper;
class PASCALIMPLEMENTATION TCMDragWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	Controls::TDragMessage FDragMessage;
	System::Byte FReserved1;
	System::Word FReserved2;
	int FResult;
	
public:
	__fastcall TCMDragWrapper(const Controls::TCMDrag &ARecord);
	Controls::TCMDrag __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property Controls::TDragMessage DragMessage = {read=FDragMessage, write=FDragMessage, nodefault};
	__property System::Byte Reserved1 = {read=FReserved1, write=FReserved1, nodefault};
	__property System::Word Reserved2 = {read=FReserved2, write=FReserved2, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TCMDragWrapper(void) { }
	
};


class DELPHICLASS TDockNotifyRecWrapper;
class PASCALIMPLEMENTATION TDockNotifyRecWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FClientMsg;
	int FMsgWParam;
	int FMsgLParam;
	
public:
	__fastcall TDockNotifyRecWrapper(const Controls::TDockNotifyRec &ARecord);
	Controls::TDockNotifyRec __fastcall ObjToRec(void);
	
__published:
	__property unsigned ClientMsg = {read=FClientMsg, write=FClientMsg, nodefault};
	__property int MsgWParam = {read=FMsgWParam, write=FMsgWParam, nodefault};
	__property int MsgLParam = {read=FMsgLParam, write=FMsgLParam, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TDockNotifyRecWrapper(void) { }
	
};


class DELPHICLASS TPopupFormInfoWrapper;
class PASCALIMPLEMENTATION TPopupFormInfoWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FPopupID;
	HWND FPopupWnd;
	bool FIsPopup;
	
public:
	__fastcall TPopupFormInfoWrapper(const Controls::TPopupFormInfo &ARecord);
	Controls::TPopupFormInfo __fastcall ObjToRec(void);
	
__published:
	__property int PopupID = {read=FPopupID, write=FPopupID, nodefault};
	__property HWND PopupWnd = {read=FPopupWnd, write=FPopupWnd, nodefault};
	__property bool IsPopup = {read=FIsPopup, write=FIsPopup, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TPopupFormInfoWrapper(void) { }
	
};


class DELPHICLASS TMouseActivateRecWrapper;
class PASCALIMPLEMENTATION TMouseActivateRecWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FHitTest;
	Controls::TMouseButton FButton;
	Classes::TShiftState FShiftState;
	HWND FTopLevel;
	
public:
	__fastcall TMouseActivateRecWrapper(const Controls::TMouseActivateRec &ARecord);
	Controls::TMouseActivateRec __fastcall ObjToRec(void);
	
__published:
	__property int HitTest = {read=FHitTest, write=FHitTest, nodefault};
	__property Controls::TMouseButton Button = {read=FButton, write=FButton, nodefault};
	__property Classes::TShiftState ShiftState = {read=FShiftState, write=FShiftState, nodefault};
	__property HWND TopLevel = {read=FTopLevel, write=FTopLevel, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TMouseActivateRecWrapper(void) { }
	
};


class DELPHICLASS TGestureEventInfoWrapper;
class PASCALIMPLEMENTATION TGestureEventInfoWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	Controls::TGestureID FGestureID;
	Controls::TInteractiveGestureFlags FFlags;
	double FAngle;
	int FDistance;
	
public:
	__fastcall TGestureEventInfoWrapper(const Controls::TGestureEventInfo &ARecord);
	Controls::TGestureEventInfo __fastcall ObjToRec(void);
	
__published:
	__property Controls::TGestureID GestureID = {read=FGestureID, write=FGestureID, nodefault};
	__property Controls::TInteractiveGestureFlags Flags = {read=FFlags, write=FFlags, nodefault};
	__property double Angle = {read=FAngle, write=FAngle};
	__property int Distance = {read=FDistance, write=FDistance, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TGestureEventInfoWrapper(void) { }
	
};


class DELPHICLASS TCMGestureWrapper;
class PASCALIMPLEMENTATION TCMGestureWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FReserved;
	int FResult;
	
public:
	__fastcall TCMGestureWrapper(const Controls::TCMGesture &ARecord);
	Controls::TCMGesture __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int Reserved = {read=FReserved, write=FReserved, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TCMGestureWrapper(void) { }
	
};


class DELPHICLASS TCreateParamsWrapper;
class PASCALIMPLEMENTATION TCreateParamsWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FStyle;
	unsigned FExStyle;
	int FX;
	int FY;
	int FWidth;
	int FHeight;
	HWND FWndParent;
	
public:
	__fastcall TCreateParamsWrapper(const Controls::TCreateParams &ARecord);
	Controls::TCreateParams __fastcall ObjToRec(void);
	
__published:
	__property unsigned Style = {read=FStyle, write=FStyle, nodefault};
	__property unsigned ExStyle = {read=FExStyle, write=FExStyle, nodefault};
	__property int X = {read=FX, write=FX, nodefault};
	__property int Y = {read=FY, write=FY, nodefault};
	__property int Width = {read=FWidth, write=FWidth, nodefault};
	__property int Height = {read=FHeight, write=FHeight, nodefault};
	__property HWND WndParent = {read=FWndParent, write=FWndParent, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TCreateParamsWrapper(void) { }
	
};


class DELPHICLASS TAlignInfoWrapper;
class PASCALIMPLEMENTATION TAlignInfoWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	Classes::TList* FAlignList;
	int FControlIndex;
	Controls::TAlign FAlign;
	int FScratch;
	
public:
	__fastcall TAlignInfoWrapper(const Controls::TAlignInfo &ARecord);
	Controls::TAlignInfo __fastcall ObjToRec(void);
	
__published:
	__property Classes::TList* AlignList = {read=FAlignList, write=FAlignList};
	__property int ControlIndex = {read=FControlIndex, write=FControlIndex, nodefault};
	__property Controls::TAlign Align = {read=FAlign, write=FAlign, nodefault};
	__property int Scratch = {read=FScratch, write=FScratch, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TAlignInfoWrapper(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Ap_controls */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Ap_controls;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Ap_controlsHPP
