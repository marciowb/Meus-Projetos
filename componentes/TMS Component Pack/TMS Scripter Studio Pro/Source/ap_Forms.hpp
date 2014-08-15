// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ap_Forms.pas' rev: 22.00

#ifndef Ap_formsHPP
#define Ap_formsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Imm.hpp>	// Pascal unit
#include <ActnList.hpp>	// Pascal unit
#include <MultiMon.hpp>	// Pascal unit
#include <HelpIntfs.hpp>	// Pascal unit
#include <Dwmapi.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <ap_Types.hpp>	// Pascal unit
#include <ap_Messages.hpp>	// Pascal unit
#include <atScript.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ap_forms
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TatFormsLibrary;
class PASCALIMPLEMENTATION TatFormsLibrary : public Atscript::TatScripterLibrary
{
	typedef Atscript::TatScripterLibrary inherited;
	
public:
	void __fastcall __TControlScrollBarAssign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlScrollBarChangeBiDiPosition(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TControlScrollBarIsScrollBarVisible(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTControlScrollBarKind(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTControlScrollBarScrollPos(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TScrollingWinControlCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TScrollingWinControlDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TScrollingWinControlDisableAutoRange(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TScrollingWinControlEnableAutoRange(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TScrollingWinControlScrollInView(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TScrollBoxCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomFrameCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TGlassFrameCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TGlassFrameAssign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TGlassFrameFrameExtended(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TGlassFrameIntersectsControl(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomFormCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomFormCreateNew(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomFormDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomFormClose(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomFormCloseQuery(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomFormDefaultHandler(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomFormDefocusControl(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomFormDock(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomFormFocusControl(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomFormGetFormImage(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomFormHide(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomFormIsShortCut(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomFormMakeFullyVisible(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomFormMouseWheelHandler(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomFormPrint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomFormRecreateAsPopup(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomFormRelease(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomFormSendCancelMode(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomFormSetFocus(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomFormSetFocusedControl(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomFormShow(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomFormShowModal(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomFormWantChildKey(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomFormset_PopupParent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomFormAfterConstruction(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomFormBeforeDestruction(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomFormActive(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomFormActiveControl(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomFormActiveControl(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomFormActiveOleControl(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomFormActiveOleControl(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomFormBorderStyle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomFormBorderStyle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomFormCanvas(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomFormDropTarget(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomFormDropTarget(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomFormFormState(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomFormGlassFrame(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomFormGlassFrame(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomFormHelpFile(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomFormHelpFile(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomFormKeyPreview(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomFormKeyPreview(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomFormMenu(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomFormMenu(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomFormModalResult(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomFormModalResult(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomFormMonitor(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomFormPopupMode(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomFormPopupMode(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomFormScreenSnap(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomFormScreenSnap(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomFormSnapBuffer(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomFormSnapBuffer(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomFormWindowState(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomFormWindowState(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTCustomFormPopupParent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTCustomFormPopupParent(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomActiveFormCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomActiveFormWantChildKey(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TFormArrangeIcons(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TFormCascade(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TFormNext(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TFormPrevious(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TFormTile(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TCustomDockFormCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMonitorHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMonitorMonitorNum(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMonitorLeft(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMonitorHeight(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMonitorTop(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMonitorWidth(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMonitorBoundsRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMonitorWorkareaRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTMonitorPrimary(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TScreenCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TScreenDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TScreenDisableAlign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TScreenEnableAlign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TScreenMonitorFromPoint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TScreenMonitorFromRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TScreenMonitorFromWindow(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TScreenRealign(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TScreenResetFonts(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenActiveControl(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenActiveCustomForm(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenActiveForm(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenCustomFormCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenCustomForms(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenCursorCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenCursor(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTScreenCursor(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenCursors(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTScreenCursors(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenDataModules(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenDataModuleCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenFocusedForm(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTScreenFocusedForm(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenSaveFocusedList(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenMonitorCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenMonitors(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenDesktopRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenDesktopHeight(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenDesktopLeft(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenDesktopTop(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenDesktopWidth(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenWorkAreaRect(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenWorkAreaHeight(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenWorkAreaLeft(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenWorkAreaTop(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenWorkAreaWidth(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenHintFont(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTScreenHintFont(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenIconFont(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTScreenIconFont(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenMenuFont(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTScreenMenuFont(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenMessageFont(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTScreenMessageFont(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenCaptionFont(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTScreenCaptionFont(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenFonts(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenFormCount(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenForms(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenImes(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenDefaultIme(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenDefaultKbLayout(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenHeight(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenPixelsPerInch(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenPrimaryMonitor(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTScreenWidth(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationCreate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationDestroy(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationActivateHint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationAddPopupForm(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationBringToFront(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationControlDestroyed(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationCancelHint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationCreateHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationDoApplicationIdle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationExecuteAction(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationHandleException(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationHandleMessage(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationHelpCommand(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationHelpContext(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationHelpJump(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationHelpKeyword(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationHelpShowTableOfContents(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationHideHint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationHintMouseMessage(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationHookSynchronizeWakeup(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationInitialize(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationIsRightToLeft(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationMinimize(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationModalStarted(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationModalFinished(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationNormalizeAllTopMosts(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationNormalizeTopMosts(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationProcessMessages(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationRemovePopupForm(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationRestore(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationRestoreTopMosts(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationRun(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationShowException(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationTerminate(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationUnhookSynchronizeWakeup(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationUpdateAction(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationUseRightToLeftAlignment(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationUseRightToLeftReading(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationUseRightToLeftScrollBar(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __TApplicationMessageBox(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTApplicationActive(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTApplicationActionUpdateDelay(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTApplicationActionUpdateDelay(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTApplicationActiveFormHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTApplicationAllowTesting(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTApplicationAllowTesting(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTApplicationAutoDragDocking(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTApplicationAutoDragDocking(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTApplicationCurrentHelpFile(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTApplicationDefaultFont(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTApplicationDefaultFont(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTApplicationDialogHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTApplicationDialogHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTApplicationEnumAllWindowsOnActivateHint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTApplicationEnumAllWindowsOnActivateHint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTApplicationExeName(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTApplicationHelpFile(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTApplicationHelpFile(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTApplicationHint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTApplicationHint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTApplicationHintColor(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTApplicationHintColor(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTApplicationHintHidePause(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTApplicationHintHidePause(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTApplicationHintPause(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTApplicationHintPause(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTApplicationHintShortCuts(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTApplicationHintShortCuts(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTApplicationHintShortPause(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTApplicationHintShortPause(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTApplicationIcon(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTApplicationIcon(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTApplicationMainForm(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTApplicationMainFormHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTApplicationMainFormOnTaskBar(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTApplicationMainFormOnTaskBar(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTApplicationModalLevel(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTApplicationModalPopupMode(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTApplicationModalPopupMode(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTApplicationBiDiMode(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTApplicationBiDiMode(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTApplicationBiDiKeyboard(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTApplicationBiDiKeyboard(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTApplicationNonBiDiKeyboard(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTApplicationNonBiDiKeyboard(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTApplicationShowHint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTApplicationShowHint(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTApplicationShowMainForm(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTApplicationShowMainForm(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTApplicationTerminated(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTApplicationTitle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTApplicationTitle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTApplicationUpdateFormatSettings(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTApplicationUpdateFormatSettings(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTApplicationUpdateMetricSettings(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTApplicationUpdateMetricSettings(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTApplicationHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetTApplicationHandle(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetTApplicationPopupControlWnd(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetParentForm(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ValidParentForm(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __IsAccel(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __KeysToShiftState(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __KeyDataToShiftState(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __KeyboardStateToShiftState(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __ForegroundTask(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetApplication(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetApplication(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __GetScreen(Atscript::TatVirtualMachine* AMachine);
	void __fastcall __SetScreen(Atscript::TatVirtualMachine* AMachine);
	virtual void __fastcall Init(void);
	__classmethod virtual System::UnicodeString __fastcall LibraryName();
public:
	/* TatScripterLibrary.Create */ inline __fastcall virtual TatFormsLibrary(Atscript::TatCustomScripter* AScripter) : Atscript::TatScripterLibrary(AScripter) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TatFormsLibrary(void) { }
	
};


typedef TMetaClass* TControlScrollBarClass;

typedef TMetaClass* TScrollingWinControlClass;

typedef TMetaClass* TScrollBoxClass;

typedef TMetaClass* TCustomFrameClass;

typedef TMetaClass* TFrameClass;

typedef TMetaClass* TGlassFrameClass;

typedef TMetaClass* TCustomFormClass;

typedef TMetaClass* TCustomActiveFormClass;

typedef TMetaClass* TFormClass;

typedef TMetaClass* TCustomDockFormClass;

typedef TMetaClass* TMonitorClass;

typedef TMetaClass* TScreenClass;

typedef TMetaClass* TApplicationClass;

class DELPHICLASS TatFormsDispatcher;
class PASCALIMPLEMENTATION TatFormsDispatcher : public Atscript::TatEventDispatcher
{
	typedef Atscript::TatEventDispatcher inherited;
	
private:
	void __fastcall __TCloseEvent(System::TObject* Sender, Forms::TCloseAction &Action);
	void __fastcall __TCloseQueryEvent(System::TObject* Sender, bool &CanClose);
	bool __fastcall __THelpEvent(System::Word Command, int Data, bool &CallHelp);
	void __fastcall __TExceptionEvent(System::TObject* Sender, Sysutils::Exception* E);
	void __fastcall __TGetHandleEvent(HWND &Handle);
	void __fastcall __TIdleEvent(System::TObject* Sender, bool &Done);
	void __fastcall __TSettingChangeEvent(System::TObject* Sender, int Flag, const System::UnicodeString Section, int &Result);
public:
	/* TatEventDispatcher.Create */ inline __fastcall virtual TatFormsDispatcher(Classes::TCollection* ACollection) : Atscript::TatEventDispatcher(ACollection) { }
	/* TatEventDispatcher.Destroy */ inline __fastcall virtual ~TatFormsDispatcher(void) { }
	
};


class DELPHICLASS TPopupWndWrapper;
class PASCALIMPLEMENTATION TPopupWndWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FID;
	HWND FControlWnd;
	
public:
	__fastcall TPopupWndWrapper(const Forms::TPopupWnd &ARecord);
	Forms::TPopupWnd __fastcall ObjToRec(void);
	
__published:
	__property int ID = {read=FID, write=FID, nodefault};
	__property HWND ControlWnd = {read=FControlWnd, write=FControlWnd, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TPopupWndWrapper(void) { }
	
};


class DELPHICLASS TCursorRecWrapper;
class PASCALIMPLEMENTATION TCursorRecWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FIndex;
	HICON FHandle;
	
public:
	__fastcall TCursorRecWrapper(const Forms::TCursorRec &ARecord);
	Forms::TCursorRec __fastcall ObjToRec(void);
	
__published:
	__property int Index = {read=FIndex, write=FIndex, nodefault};
	__property HICON Handle = {read=FHandle, write=FHandle, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TCursorRecWrapper(void) { }
	
};


class DELPHICLASS TCMHintShowPauseWrapper;
class PASCALIMPLEMENTATION TCMHintShowPauseWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	unsigned FMsg;
	int FWasActive;
	int FResult;
	
public:
	__fastcall TCMHintShowPauseWrapper(const Forms::TCMHintShowPause &ARecord);
	Forms::TCMHintShowPause __fastcall ObjToRec(void);
	
__published:
	__property unsigned Msg = {read=FMsg, write=FMsg, nodefault};
	__property int WasActive = {read=FWasActive, write=FWasActive, nodefault};
	__property int Result = {read=FResult, write=FResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TCMHintShowPauseWrapper(void) { }
	
};


class DELPHICLASS TPopupFormWrapper;
class PASCALIMPLEMENTATION TPopupFormWrapper : public Atscript::TatRecordWrapper
{
	typedef Atscript::TatRecordWrapper inherited;
	
private:
	int FFormID;
	Forms::TCustomForm* FForm;
	bool FWasPopup;
	
public:
	__fastcall TPopupFormWrapper(const Forms::TPopupForm &ARecord);
	Forms::TPopupForm __fastcall ObjToRec(void);
	
__published:
	__property int FormID = {read=FFormID, write=FFormID, nodefault};
	__property Forms::TCustomForm* Form = {read=FForm, write=FForm};
	__property bool WasPopup = {read=FWasPopup, write=FWasPopup, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TPopupFormWrapper(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Ap_forms */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Ap_forms;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Ap_formsHPP
