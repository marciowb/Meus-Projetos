// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Formdesigner.pas' rev: 21.00

#ifndef FormdesignerHPP
#define FormdesignerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Inifiles.hpp>	// Pascal unit
#include <Axctrls.hpp>	// Pascal unit
#include <Clipbrd.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Commctrl.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Formdesigner
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TGrabPosition { gpNone, gpLeftTop, gpLeftMiddle, gpLeftBottom, gpMiddleTop, gpMiddleBottom, gpRightTop, gpRightMiddle, gpRightBottom };
#pragma option pop

typedef Set<TGrabPosition, gpNone, gpRightBottom>  TGrabPositions;

#pragma option push -b-
enum TGrabMode { gmMiddle, gmInside, gmOutside };
#pragma option pop

class DELPHICLASS TComponentContainer;
class DELPHICLASS TAdvCustomFormDesigner;
class PASCALIMPLEMENTATION TComponentContainer : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	TAdvCustomFormDesigner* FDesigner;
	Classes::TComponent* FComponent;
	Graphics::TBitmap* FBitmap;
	Stdctrls::TStaticText* FCaption;
	void __fastcall HideControl(void);
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall WndProc(Messages::TMessage &Msg);
	
public:
	__fastcall TComponentContainer(Classes::TComponent* AOwner, Classes::TComponent* AComponent, TAdvCustomFormDesigner* ADesigner, bool AVisible);
	__fastcall virtual ~TComponentContainer(void);
	void __fastcall UpdateContainer(void);
	__property Classes::TComponent* Component = {read=FComponent, write=FComponent};
public:
	/* TCustomControl.Create */ inline __fastcall virtual TComponentContainer(Classes::TComponent* AOwner) : Controls::TCustomControl(AOwner) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TComponentContainer(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


class DELPHICLASS TFDReader;
class PASCALIMPLEMENTATION TFDReader : public Classes::TReader
{
	typedef Classes::TReader inherited;
	
private:
	TAdvCustomFormDesigner* Designer;
	
protected:
	virtual bool __fastcall Error(const System::UnicodeString Message);
	virtual void __fastcall SetName(Classes::TComponent* Component, System::UnicodeString &Name);
	
public:
	__fastcall TFDReader(Classes::TStream* AStream, TAdvCustomFormDesigner* ADesigner);
public:
	/* TReader.Destroy */ inline __fastcall virtual ~TFDReader(void) { }
	
};


class DELPHICLASS TGrabHandle;
class PASCALIMPLEMENTATION TGrabHandle : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	TGrabPosition FPosition;
	Types::TRect FRect;
	bool FLocked;
	void __fastcall SetPosition(TGrabPosition Value);
	void __fastcall SetRect(const Types::TRect &Value);
	void __fastcall SetLocked(bool Value);
	void __fastcall UpdateCoords(void);
	void __fastcall SetArrowCursor(void);
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall WndProc(Messages::TMessage &Msg);
	
public:
	__fastcall virtual TGrabHandle(Classes::TComponent* AOwner);
	__property TGrabPosition Position = {read=FPosition, write=SetPosition, nodefault};
	__property Types::TRect Rect = {read=FRect, write=SetRect};
	__property bool Locked = {read=FLocked, write=SetLocked, nodefault};
public:
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TGrabHandle(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TGrabHandle(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


class DELPHICLASS TGrabHandles;
class PASCALIMPLEMENTATION TGrabHandles : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	StaticArray<TGrabHandle*, 9> FItems;
	Controls::TControl* FControl;
	bool FVisible;
	bool FEnabled;
	void __fastcall SetControl(Controls::TControl* Value);
	void __fastcall SetVisible(bool Value);
	void __fastcall SetEnabled(bool Value);
	Forms::TCustomForm* __fastcall GetParentForm(void);
	TAdvCustomFormDesigner* __fastcall GetDesigner(void);
	
public:
	__fastcall virtual TGrabHandles(Classes::TComponent* AOwner);
	void __fastcall Update(bool MustHide);
	void __fastcall BringToFront(void);
	TGrabPosition __fastcall FindHandle(HWND AHandle);
	TGrabHandle* __fastcall FindHandleControl(HWND AHandle);
	bool __fastcall IsGrabHandle(Controls::TControl* AControl);
	__property Controls::TControl* Control = {read=FControl, write=SetControl};
	__property bool Visible = {read=FVisible, write=SetVisible, nodefault};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, nodefault};
	__property Forms::TCustomForm* ParentForm = {read=GetParentForm};
	__property TAdvCustomFormDesigner* Designer = {read=GetDesigner};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TGrabHandles(void) { }
	
};


#pragma option push -b-
enum TListType { ltLocked, ltProtected, ltTransparent };
#pragma option pop

#pragma option push -b-
enum TChildrenMode { cmNone, cmNormal, cmRecurse };
#pragma option pop

#pragma option push -b-
enum TProtectMode { pmUnselect, pmLockKeyboard };
#pragma option pop

#pragma option push -b-
enum TMessageProcessor { mpEvent, mpHook };
#pragma option pop

#pragma option push -b-
enum TMouseAction { maNone, maDragging, maSelecting, maPlacing };
#pragma option pop

#pragma option push -b-
enum THintMode { hmCustom, hmMove, hmSize };
#pragma option pop

#pragma option push -b-
enum TGrabType { gtNormal, gtMulti, gtLocked };
#pragma option pop

#pragma option push -b-
enum TAlignMode { amNoChange, amLeftTop, amCenters, amRightBottom, amSpace, amWindowCenter };
#pragma option pop

#pragma option push -b-
enum TSizeMode { smNoChange, smToSmallest, smToLargest, smValue };
#pragma option pop

#pragma option push -b-
enum TAlignmentPaletteOption { apAutoShow, apStayOnTop, apShowHints, apFlatButtons };
#pragma option pop

typedef Set<TAlignmentPaletteOption, apAutoShow, apFlatButtons>  TAlignmentPaletteOptions;

#pragma option push -b-
enum TDFMFormat { dfmBinary, dfmText };
#pragma option pop

#pragma option push -b-
enum TEditBehaviour { ebDefault, ebTransparent, ebLocked, ebProtected, ebDefaultRuntime, ebTransparentRuntime, ebLockedRuntime };
#pragma option pop

#pragma option push -b-
enum TLinePosition { lpLeft, lpTop, lpRight, lpBottom };
#pragma option pop

typedef Set<TLinePosition, lpLeft, lpBottom>  TLinePositions;

#pragma option push -b-
enum TMoveLimitMode { lmCursor, lmControls };
#pragma option pop

typedef void __fastcall (__closure *TControlNotifyEvent)(System::TObject* Sender, Controls::TControl* TheControl);

typedef void __fastcall (__closure *TComponentNotifyEvent)(System::TObject* Sender, Classes::TComponent* TheComponent);

typedef void __fastcall (__closure *TLoadSaveEvent)(System::TObject* Sender, Controls::TControl* TheControl, Inifiles::TIniFile* IniFile);

typedef void __fastcall (__closure *TDesignerMessageEvent)(System::TObject* Sender, tagMSG &Msg);

typedef void __fastcall (__closure *TMoveLimitEvent)(System::TObject* Sender, Controls::TControl* TheControl, Types::TRect &LimitRect);

typedef void __fastcall (__closure *TSizeLimitEvent)(System::TObject* Sender, Controls::TControl* TheControl, Types::TPoint &MinSize, Types::TPoint &MaxSize);

typedef void __fastcall (__closure *TCustomizeGrabsEvent)(System::TObject* Sender, TGrabPositions &VisibleGrabs, TGrabPositions &EnabledGrabs);

typedef void __fastcall (__closure *TComponentTextEvent)(System::TObject* Sender, Classes::TComponent* TheComponent, System::UnicodeString &Text);

typedef void __fastcall (__closure *TComponentBitmapEvent)(System::TObject* Sender, Classes::TComponent* TheComponent, const Graphics::TBitmap* Bitmap);

typedef void __fastcall (__closure *TComponentEditableEvent)(System::TObject* Sender, Classes::TComponent* TheComponent, bool &Editable);

typedef void __fastcall (__closure *TComponentClipboardEvent)(System::TObject* Sender, Classes::TComponent* TheComponent);

typedef void __fastcall (__closure *TComponentPopupEvent)(System::TObject* Sender, bool &Handled);

typedef void __fastcall (__closure *TComponentBehaviourEvent)(System::TObject* Sender, Classes::TComponent* TheComponent, TEditBehaviour &Behaviour);

typedef void __fastcall (__closure *TRectEvent)(System::TObject* Sender, Types::TRect &R);

typedef void __fastcall (__closure *TFormEvent)(System::TObject* Sender, Forms::TForm* Form);

class DELPHICLASS TIDEComponentEditor;
class PASCALIMPLEMENTATION TAdvCustomFormDesigner : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	void *FDefaultProc;
	void *FWinProc;
	Graphics::TBitmap* FBkgBitmap;
	Forms::TCustomForm* FForm;
	Forms::TForm* FAPForm;
	Controls::TControl* FHintControl;
	Extctrls::TTimer* FHintTimer;
	bool FIgnoreMouseMove;
	bool FKeySelect;
	bool FKeyMove;
	bool FClearBeforeLoad;
	bool FMustClear;
	int FGrabSize;
	Graphics::TColor FNormalGrabBorder;
	Graphics::TColor FNormalGrabFill;
	Graphics::TColor FMultiGrabBorder;
	Graphics::TColor FMultiGrabFill;
	Graphics::TColor FLockedGrabBorder;
	Graphics::TColor FLockedGrabFill;
	Graphics::TBitmap* FNormalGrab;
	Graphics::TBitmap* FNormalGrabGlyph;
	Graphics::TBitmap* FMultiGrab;
	Graphics::TBitmap* FMultiGrabGlyph;
	Graphics::TBitmap* FLockedGrab;
	Graphics::TBitmap* FLockedGrabGlyph;
	Controls::THintWindow* FHintWindow;
	Graphics::TCanvas* FCanvas;
	Types::TPoint FClickPos;
	bool FActive;
	TMessageProcessor FMessageProcessor;
	int FLockCounter;
	int FSynchroLockCounter;
	bool FWaiting;
	Controls::TWinControl* FPlacingParent;
	Classes::TComponentClass FPlacedComponentClass;
	Classes::TList* FControls;
	Controls::TWinControl* FDesignControl;
	Controls::TWinControl* FSelectControl;
	Controls::TControl* FMenuControl;
	TGrabHandles* FGrabHandles;
	int FGridStep;
	bool FSnapToGrid;
	bool FSnapToGridKey;
	bool FDisplayGrid;
	Graphics::TColor FDesignerColor;
	Graphics::TColor FGridColor;
	Menus::TPopupMenu* FPopupMenu;
	Contnrs::TObjectList* FPopupItems;
	Classes::TStrings* FLockedControls;
	bool FLockedInverse;
	TChildrenMode FLockChildren;
	Classes::TStrings* FProtectedControls;
	bool FProtectedInverse;
	TChildrenMode FProtectChildren;
	TProtectMode FProtectMode;
	Classes::TStrings* FTransparentControls;
	bool FTransparentInverse;
	TChildrenMode FTransparentChildren;
	bool FShowMoveSizeHint;
	bool FShowComponentHint;
	TAlignmentPaletteOptions FAlignmentPalette;
	TMouseAction FMouseAction;
	Types::TPoint FDragPoint;
	Types::TRect FDragRect;
	Types::TRect FSelectRect;
	Types::TRect FPlacingRect;
	int FSelectCounter;
	TGrabPosition FDragHandle;
	bool FShowNonVisual;
	bool FShowComponentCaptions;
	bool FMultiSelect;
	bool FModified;
	bool FEnableAxisDrag;
	TGrabMode FGrabMode;
	bool FUseGrabGlyphs;
	Graphics::TColor FGrabsTransparentColor;
	bool FAlignmentEntireForm;
	TLinePositions FAlignmentLines;
	Graphics::TColor FAlignmentColorLeft;
	Graphics::TColor FAlignmentColorTop;
	Graphics::TColor FAlignmentColorRight;
	Graphics::TColor FAlignmentColorBottom;
	TMoveLimitMode FMoveLimitMode;
	Classes::TComponent* FAncestor;
	TControlNotifyEvent FOnMoveSizeControl;
	Classes::TNotifyEvent FOnChange;
	TLoadSaveEvent FOnLoadControl;
	TLoadSaveEvent FOnSaveControl;
	TControlNotifyEvent FOnSelectControl;
	Classes::TNotifyEvent FOnSelectionChange;
	TControlNotifyEvent FOnControlDblClick;
	TControlNotifyEvent FOnAddControl;
	TControlNotifyEvent FOnDeleteControl;
	Classes::TNotifyEvent FOnActivate;
	Classes::TNotifyEvent FOnDeactivate;
	Controls::TKeyEvent FOnKeyDown;
	Controls::TKeyEvent FOnKeyUp;
	TDesignerMessageEvent FOnMessage;
	TMoveLimitEvent FOnMoveLimit;
	TSizeLimitEvent FOnSizeLimit;
	Classes::TReaderError FOnReadError;
	TCustomizeGrabsEvent FOnCustomizeGrabs;
	TComponentTextEvent FOnComponentHint;
	TComponentTextEvent FOnComponentCaption;
	TComponentBitmapEvent FOnComponentBitmap;
	TComponentEditableEvent FOnComponentEditable;
	TComponentClipboardEvent FOnCopyComponent;
	TComponentClipboardEvent FOnPasteComponent;
	TComponentPopupEvent FOnContextPopup;
	TComponentBehaviourEvent FOnEditBehaviour;
	TComponentNotifyEvent FOnPlaceComponent;
	TRectEvent FOnEndPlacing;
	TRectEvent FOnEndSelecting;
	TFormEvent FOnShowAlignmentPalette;
	int FUpdatingSelection;
	bool FAvoidFormMoving;
	int __fastcall GetControlCount(void);
	bool __fastcall GetLocked(void);
	bool __fastcall GetSynchroLocked(void);
	Forms::TCustomForm* __fastcall GetParentForm(void);
	void __fastcall SetParentForm(const Forms::TCustomForm* Value);
	System::UnicodeString __fastcall GetFormData(void);
	void __fastcall SetFormData(const System::UnicodeString Value);
	void __fastcall SetActive(bool Value);
	void __fastcall SetMessageProcessor(TMessageProcessor Value);
	Controls::TControl* __fastcall GetControl(void);
	void __fastcall SetControl(Controls::TControl* Value);
	Controls::TControl* __fastcall GetControlByIndex(int Index);
	HIDESBASE Classes::TComponent* __fastcall GetComponent(void);
	void __fastcall SetComponent(Classes::TComponent* Value);
	Classes::TComponent* __fastcall GetComponentByIndex(int Index);
	void __fastcall SetGridStep(int Value);
	void __fastcall SetDisplayGrid(bool Value);
	void __fastcall SetDesignerColor(Graphics::TColor Value);
	void __fastcall SetGridColor(Graphics::TColor Value);
	void __fastcall SetLockedControls(Classes::TStrings* Value);
	void __fastcall SetLockedInverse(bool Value);
	void __fastcall SetLockChildren(TChildrenMode Value);
	void __fastcall SetProtectedControls(Classes::TStrings* Value);
	void __fastcall SetProtectedInverse(bool Value);
	void __fastcall SetProtectChildren(TChildrenMode Value);
	void __fastcall SetProtectMode(TProtectMode Value);
	void __fastcall SetTransparentControls(Classes::TStrings* Value);
	void __fastcall SetTransparentInverse(bool Value);
	void __fastcall SetTransparentChildren(TChildrenMode Value);
	void __fastcall SetMoveSizeHint(bool Value);
	void __fastcall SetComponentHint(bool Value);
	void __fastcall SetGrabSize(int Value);
	void __fastcall SetAlignmentPalette(TAlignmentPaletteOptions Value);
	void __fastcall SetNormalGrabBorder(Graphics::TColor Value);
	void __fastcall SetNormalGrabFill(Graphics::TColor Value);
	void __fastcall SetNormalGrabGlyph(Graphics::TBitmap* Value);
	void __fastcall SetMultiGrabBorder(Graphics::TColor Value);
	void __fastcall SetMultiGrabFill(Graphics::TColor Value);
	void __fastcall SetMultiGrabGlyph(Graphics::TBitmap* Value);
	void __fastcall SetLockedGrabBorder(Graphics::TColor Value);
	void __fastcall SetLockedGrabFill(Graphics::TColor Value);
	void __fastcall SetLockedGrabGlyph(Graphics::TBitmap* Value);
	void __fastcall SetShowNonVisual(const bool Value);
	void __fastcall SetShowComponentCaptions(const bool Value);
	void __fastcall SetMultiSelect(const bool Value);
	void __fastcall SetDesignControl(const Controls::TWinControl* Value);
	void __fastcall SetGrabMode(const TGrabMode Value);
	void __fastcall SetUseGrabGlyphs(const bool Value);
	void __fastcall SetGrabsTransparentColor(const Graphics::TColor Value);
	void __fastcall ApplicationIdle(System::TObject* Sender, bool &Done);
	void __fastcall ApplicationMessage(tagMSG &Msg, bool &Handled);
	void __fastcall TimerEvent(System::TObject* Sender);
	void __fastcall StartTimer(int AInterval);
	void __fastcall StopTimer(void);
	void __fastcall DrawPlacingRect(void);
	void __fastcall DrawSelectRect(void);
	void __fastcall DrawDragRects(void);
	void __fastcall DrawMultiSelect(Controls::TControl* AControl);
	bool __fastcall InTheList(Classes::TStrings* List, Controls::TControl* AControl);
	void __fastcall ShowHint(System::UnicodeString AHint, THintMode Mode);
	void __fastcall HideHint(void);
	Types::TPoint __fastcall GetControlsOrigin(void);
	bool __fastcall CheckParent(Controls::TControl* AControl, bool DisableLocked);
	void __fastcall SetArrowCursor(void);
	bool __fastcall ValidControl(Controls::TControl* AControl);
	void __fastcall CreateContainers(void);
	void __fastcall DestroyContainers(void);
	void __fastcall ContainersToDesignInfo(void);
	void __fastcall DesignInfoToContainers(void);
	void __fastcall UpdateContainers(void);
	bool __fastcall InParentForm(HWND WND);
	void __fastcall ListChange(System::TObject* Sender);
	void __fastcall WinProc(Messages::TMessage &Message);
	void __fastcall BuildContextItems(Classes::TComponent* AComp, Menus::TPopupMenu* APopup);
	void __fastcall ContextPopupItemClick(System::TObject* Sender);
	void __fastcall PerformComponentPlacing(Controls::TWinControl* AParentControl, const Types::TRect &APlacingRect);
	
protected:
	TIDEComponentEditor* __fastcall GetIDEComponentEditor(Classes::TComponent* AComp);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall MessageProc(tagMSG &Msg);
	virtual void __fastcall DoMoveSizeControl(void);
	virtual void __fastcall DoChange(void);
	virtual void __fastcall DoSelectControl(Controls::TControl* AControl);
	virtual void __fastcall DoSelectionChange(void);
	virtual void __fastcall DoAddControl(Controls::TControl* AControl);
	virtual void __fastcall DoDeleteControl(Controls::TControl* AControl);
	virtual void __fastcall DoControlDblClick(Controls::TControl* AControl);
	virtual void __fastcall DoBeforePlaceComponent(Classes::TComponent* AComponent);
	virtual void __fastcall DoPlaceComponent(Classes::TComponent* AComponent);
	virtual TEditBehaviour __fastcall GetEditBehaviour(Controls::TControl* AControl);
	__property TControlNotifyEvent OnMoveSizeControl = {read=FOnMoveSizeControl, write=FOnMoveSizeControl};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TLoadSaveEvent OnLoadControl = {read=FOnLoadControl, write=FOnLoadControl};
	__property TLoadSaveEvent OnSaveControl = {read=FOnSaveControl, write=FOnSaveControl};
	__property TControlNotifyEvent OnSelectControl = {read=FOnSelectControl, write=FOnSelectControl};
	__property Classes::TNotifyEvent OnSelectionChange = {read=FOnSelectionChange, write=FOnSelectionChange};
	__property TControlNotifyEvent OnControlDblClick = {read=FOnControlDblClick, write=FOnControlDblClick};
	__property TControlNotifyEvent OnAddControl = {read=FOnAddControl, write=FOnAddControl};
	__property TControlNotifyEvent OnDeleteControl = {read=FOnDeleteControl, write=FOnDeleteControl};
	__property Classes::TNotifyEvent OnActivate = {read=FOnActivate, write=FOnActivate};
	__property Classes::TNotifyEvent OnDeactivate = {read=FOnDeactivate, write=FOnDeactivate};
	__property Controls::TKeyEvent OnKeyDown = {read=FOnKeyDown, write=FOnKeyDown};
	__property Controls::TKeyEvent OnKeyUp = {read=FOnKeyUp, write=FOnKeyUp};
	__property TDesignerMessageEvent OnMessage = {read=FOnMessage, write=FOnMessage};
	__property TMoveLimitEvent OnMoveLimit = {read=FOnMoveLimit, write=FOnMoveLimit};
	__property TSizeLimitEvent OnSizeLimit = {read=FOnSizeLimit, write=FOnSizeLimit};
	__property Classes::TReaderError OnReadError = {read=FOnReadError, write=FOnReadError};
	__property TCustomizeGrabsEvent OnCustomizeGrabs = {read=FOnCustomizeGrabs, write=FOnCustomizeGrabs};
	__property TComponentTextEvent OnComponentHint = {read=FOnComponentHint, write=FOnComponentHint};
	__property TComponentTextEvent OnComponentCaption = {read=FOnComponentCaption, write=FOnComponentCaption};
	__property TComponentBitmapEvent OnComponentBitmap = {read=FOnComponentBitmap, write=FOnComponentBitmap};
	__property TComponentEditableEvent OnComponentEditable = {read=FOnComponentEditable, write=FOnComponentEditable};
	__property TComponentClipboardEvent OnCopyComponent = {read=FOnCopyComponent, write=FOnCopyComponent};
	__property TComponentClipboardEvent OnPasteComponent = {read=FOnPasteComponent, write=FOnPasteComponent};
	__property TComponentPopupEvent OnContextPopup = {read=FOnContextPopup, write=FOnContextPopup};
	__property TComponentBehaviourEvent OnEditBehaviour = {read=FOnEditBehaviour, write=FOnEditBehaviour};
	__property TComponentNotifyEvent OnPlaceComponent = {read=FOnPlaceComponent, write=FOnPlaceComponent};
	__property TRectEvent OnEndPlacing = {read=FOnEndPlacing, write=FOnEndPlacing};
	__property TRectEvent OnEndSelecting = {read=FOnEndSelecting, write=FOnEndSelecting};
	__property TFormEvent OnShowAlignmentPalette = {read=FOnShowAlignmentPalette, write=FOnShowAlignmentPalette};
	__property int UpdatingSelection = {read=FUpdatingSelection, nodefault};
	
public:
	void __fastcall ClearForm(void);
	__fastcall virtual TAdvCustomFormDesigner(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvCustomFormDesigner(void);
	virtual void __fastcall Update(void);
	void __fastcall UpdateGrid(void);
	void __fastcall CreateObjects(void);
	void __fastcall DestroyObjects(void);
	bool __fastcall IsLocked(Controls::TControl* AControl);
	bool __fastcall IsProtected(Controls::TControl* AControl);
	bool __fastcall IsTransparent(Controls::TControl* AControl);
	Controls::TControl* __fastcall FindNextControl(bool GoForward);
	Controls::TControl* __fastcall ControlAtPos(Controls::TWinControl* AParent, const Types::TPoint &P);
	Controls::TWinControl* __fastcall FindWinControl(unsigned Wnd);
	TComponentContainer* __fastcall FindComponentContainer(Classes::TComponent* AComponent);
	void __fastcall SaveToFile(System::UnicodeString FileName);
	void __fastcall LoadFromFile(System::UnicodeString FileName);
	void __fastcall SaveToDFM(System::UnicodeString FileName, TDFMFormat DFMFormat);
	void __fastcall LoadFromDFM(System::UnicodeString FileName, TDFMFormat DFMFormat);
	void __fastcall SaveComponentToStream(Classes::TStream* Stream, Classes::TComponent* Component, TDFMFormat DFMFormat);
	Classes::TComponent* __fastcall LoadComponentFromStream(Classes::TStream* Stream, Classes::TComponent* Component, TDFMFormat DFMFormat);
	void __fastcall SaveToStream(Classes::TStream* Stream, TDFMFormat DFMFormat);
	void __fastcall LoadFromStream(Classes::TStream* Stream, TDFMFormat DFMFormat);
	bool __fastcall CanCopy(void);
	bool __fastcall CanPaste(void);
	void __fastcall CopyToClipboard(void);
	void __fastcall CutToClipboard(void);
	void __fastcall PasteFromClipboard(void);
	System::UnicodeString __fastcall GetComponentProperties(Classes::TComponent* AComponent);
	void __fastcall SetComponentProperties(Classes::TComponent* AComponent, System::UnicodeString Props);
	void __fastcall AlignToGrid(Controls::TControl* TheControl);
	bool __fastcall EditControlLists(TListType DefaultList);
	bool __fastcall AlignDialog(void);
	bool __fastcall SizeDialog(void);
	bool __fastcall TabOrderDialog(void);
	bool __fastcall OptionsDialog(void);
	void __fastcall ShowAlignmentPalette(void);
	void __fastcall HideAlignmentPalette(void);
	void __fastcall AlignControls(TAlignMode Hor, TAlignMode Ver);
	void __fastcall SizeControls(TSizeMode WMode, int WValue, TSizeMode HMode, int HValue);
	void __fastcall Lock(void);
	void __fastcall Unlock(void);
	void __fastcall SynchroLock(void);
	void __fastcall SynchroUnlock(void);
	void __fastcall LeaveMouseAction(void);
	void __fastcall AddControl(Controls::TControl* AControl);
	void __fastcall DeleteControl(Controls::TControl* AControl);
	void __fastcall AddComponent(Classes::TComponent* AComponent);
	void __fastcall DeleteComponent(Classes::TComponent* AComponent);
	void __fastcall SelectAll(void);
	void __fastcall UnselectAll(void);
	void __fastcall ClearControls(void);
	int __fastcall ControlIndex(Controls::TControl* AControl);
	virtual void __fastcall DrawGrab(Graphics::TCanvas* Canvas, const Types::TRect &R, TGrabType GrabType);
	void __fastcall UpdateGrabs(void);
	Classes::TComponent* __fastcall CreateComponentClass(Classes::TComponentClass AComponentClass);
	Classes::TComponent* __fastcall CreateComponentClassName(Classes::TComponentName AClassName);
	void __fastcall PlaceComponentClass(Classes::TComponentClass AComponentClass);
	void __fastcall PlaceComponentClassName(Classes::TComponentName AClassName);
	void __fastcall AutoPlaceComponent(void);
	void __fastcall CancelPlacing(void);
	virtual System::UnicodeString __fastcall GetComponentHint(Classes::TComponent* AComponent);
	System::UnicodeString __fastcall GetComponentCaption(Classes::TComponent* AComponent);
	void __fastcall BringControlsToFront(void);
	void __fastcall SendControlsToBack(void);
	void __fastcall AlignControlsToGrid(void);
	void __fastcall RemoveSelectedControls(void);
	__property bool Modified = {read=FModified, write=FModified, nodefault};
	__property int ControlCount = {read=GetControlCount, nodefault};
	__property bool Locked = {read=GetLocked, nodefault};
	__property bool SynchroLocked = {read=GetSynchroLocked, nodefault};
	__property TMouseAction MouseAction = {read=FMouseAction, nodefault};
	__property bool Active = {read=FActive, write=SetActive, nodefault};
	__property TMessageProcessor MessageProcessor = {read=FMessageProcessor, write=SetMessageProcessor, default=0};
	__property Controls::TControl* Control = {read=GetControl, write=SetControl};
	__property Controls::TControl* Controls[int Index] = {read=GetControlByIndex};
	__property Classes::TComponent* Component = {read=GetComponent, write=SetComponent};
	__property Classes::TComponent* Components[int Index] = {read=GetComponentByIndex};
	__property Forms::TCustomForm* ParentForm = {read=GetParentForm, write=SetParentForm};
	__property Forms::TForm* AlignmentPaletteForm = {read=FAPForm};
	__property Controls::TControl* MenuControl = {read=FMenuControl};
	__property System::UnicodeString FormData = {read=GetFormData, write=SetFormData};
	__property bool ClearBeforeLoad = {read=FClearBeforeLoad, write=FClearBeforeLoad, default=1};
	__property Classes::TStrings* LockedControls = {read=FLockedControls, write=SetLockedControls};
	__property bool LockedInverse = {read=FLockedInverse, write=SetLockedInverse, default=0};
	__property TChildrenMode LockChildren = {read=FLockChildren, write=SetLockChildren, default=0};
	__property Classes::TStrings* ProtectedControls = {read=FProtectedControls, write=SetProtectedControls};
	__property bool ProtectedInverse = {read=FProtectedInverse, write=SetProtectedInverse, default=0};
	__property TChildrenMode ProtectChildren = {read=FProtectChildren, write=SetProtectChildren, default=0};
	__property TProtectMode ProtectMode = {read=FProtectMode, write=SetProtectMode, default=0};
	__property Classes::TStrings* TransparentControls = {read=FTransparentControls, write=SetTransparentControls};
	__property bool TransparentInverse = {read=FTransparentInverse, write=SetTransparentInverse, default=0};
	__property TChildrenMode TransparentChildren = {read=FTransparentChildren, write=SetTransparentChildren, default=0};
	__property Menus::TPopupMenu* PopupMenu = {read=FPopupMenu, write=FPopupMenu, default=0};
	__property int GridStep = {read=FGridStep, write=SetGridStep, default=8};
	__property bool SnapToGrid = {read=FSnapToGrid, write=FSnapToGrid, default=0};
	__property bool SnapToGridKey = {read=FSnapToGridKey, write=FSnapToGridKey, default=0};
	__property bool DisplayGrid = {read=FDisplayGrid, write=SetDisplayGrid, default=0};
	__property Graphics::TColor DesignerColor = {read=FDesignerColor, write=SetDesignerColor, default=536870911};
	__property Graphics::TColor GridColor = {read=FGridColor, write=SetGridColor, default=536870911};
	__property bool ShowMoveSizeHint = {read=FShowMoveSizeHint, write=SetMoveSizeHint, default=1};
	__property bool ShowComponentHint = {read=FShowComponentHint, write=SetComponentHint, default=0};
	__property int GrabSize = {read=FGrabSize, write=SetGrabSize, default=5};
	__property TAlignmentPaletteOptions AlignmentPalette = {read=FAlignmentPalette, write=SetAlignmentPalette, default=6};
	__property Graphics::TColor NormalGrabBorder = {read=FNormalGrabBorder, write=SetNormalGrabBorder, default=0};
	__property Graphics::TColor NormalGrabFill = {read=FNormalGrabFill, write=SetNormalGrabFill, default=0};
	__property Graphics::TBitmap* NormalGrabGlyph = {read=FNormalGrabGlyph, write=SetNormalGrabGlyph};
	__property Graphics::TColor MultiGrabBorder = {read=FMultiGrabBorder, write=SetMultiGrabBorder, default=8421504};
	__property Graphics::TColor MultiGrabFill = {read=FMultiGrabFill, write=SetMultiGrabFill, default=8421504};
	__property Graphics::TBitmap* MultiGrabGlyph = {read=FMultiGrabGlyph, write=SetMultiGrabGlyph};
	__property Graphics::TColor LockedGrabBorder = {read=FLockedGrabBorder, write=SetLockedGrabBorder, default=0};
	__property Graphics::TColor LockedGrabFill = {read=FLockedGrabFill, write=SetLockedGrabFill, default=8421504};
	__property Graphics::TBitmap* LockedGrabGlyph = {read=FLockedGrabGlyph, write=SetLockedGrabGlyph};
	__property bool KeySelect = {read=FKeySelect, write=FKeySelect, default=1};
	__property bool KeyMove = {read=FKeyMove, write=FKeyMove, default=1};
	__property bool ShowNonVisual = {read=FShowNonVisual, write=SetShowNonVisual, default=1};
	__property bool ShowComponentCaptions = {read=FShowComponentCaptions, write=SetShowComponentCaptions, default=0};
	__property bool MultiSelect = {read=FMultiSelect, write=SetMultiSelect, default=1};
	__property Controls::TWinControl* DesignControl = {read=FDesignControl, write=SetDesignControl};
	__property bool EnableAxisDrag = {read=FEnableAxisDrag, write=FEnableAxisDrag, default=0};
	__property TGrabMode GrabMode = {read=FGrabMode, write=SetGrabMode, default=0};
	__property bool UseGrabGlyphs = {read=FUseGrabGlyphs, write=SetUseGrabGlyphs, default=0};
	__property Graphics::TColor GrabsTransparentColor = {read=FGrabsTransparentColor, write=SetGrabsTransparentColor, default=0};
	__property bool AlignmentEntireForm = {read=FAlignmentEntireForm, write=FAlignmentEntireForm, default=0};
	__property TLinePositions AlignmentLines = {read=FAlignmentLines, write=FAlignmentLines, default=0};
	__property Graphics::TColor AlignmentColorLeft = {read=FAlignmentColorLeft, write=FAlignmentColorLeft, default=8421504};
	__property Graphics::TColor AlignmentColorTop = {read=FAlignmentColorTop, write=FAlignmentColorTop, default=8421504};
	__property Graphics::TColor AlignmentColorRight = {read=FAlignmentColorRight, write=FAlignmentColorRight, default=8421504};
	__property Graphics::TColor AlignmentColorBottom = {read=FAlignmentColorBottom, write=FAlignmentColorBottom, default=8421504};
	__property TMoveLimitMode MoveLimitMode = {read=FMoveLimitMode, write=FMoveLimitMode, default=0};
	__property Classes::TComponent* Ancestor = {read=FAncestor, write=FAncestor};
	__property bool AvoidFormMoving = {read=FAvoidFormMoving, write=FAvoidFormMoving, nodefault};
	__property Classes::TComponentClass PlacedComponentClass = {read=FPlacedComponentClass};
};


class DELPHICLASS TAdvFormDesigner;
class PASCALIMPLEMENTATION TAdvFormDesigner : public TAdvCustomFormDesigner
{
	typedef TAdvCustomFormDesigner inherited;
	
__published:
	__property ClearBeforeLoad = {default=1};
	__property MessageProcessor = {default=0};
	__property LockedControls;
	__property LockedInverse = {default=0};
	__property LockChildren = {default=0};
	__property ProtectedControls;
	__property ProtectedInverse = {default=0};
	__property ProtectChildren = {default=0};
	__property ProtectMode = {default=0};
	__property TransparentControls;
	__property TransparentInverse = {default=0};
	__property TransparentChildren = {default=0};
	__property PopupMenu = {default=0};
	__property GridStep = {default=8};
	__property SnapToGrid = {default=0};
	__property SnapToGridKey = {default=0};
	__property DisplayGrid = {default=0};
	__property DesignerColor = {default=536870911};
	__property GridColor = {default=536870911};
	__property ShowMoveSizeHint = {default=1};
	__property ShowComponentHint = {default=0};
	__property GrabSize = {default=5};
	__property AlignmentPalette = {default=6};
	__property NormalGrabBorder = {default=0};
	__property NormalGrabFill = {default=0};
	__property NormalGrabGlyph;
	__property MultiGrabBorder = {default=8421504};
	__property MultiGrabFill = {default=8421504};
	__property MultiGrabGlyph;
	__property LockedGrabBorder = {default=0};
	__property LockedGrabFill = {default=8421504};
	__property LockedGrabGlyph;
	__property KeySelect = {default=1};
	__property KeyMove = {default=1};
	__property ShowNonVisual = {default=1};
	__property ShowComponentCaptions = {default=0};
	__property MultiSelect = {default=1};
	__property DesignControl;
	__property EnableAxisDrag = {default=0};
	__property GrabMode = {default=0};
	__property UseGrabGlyphs = {default=0};
	__property GrabsTransparentColor = {default=0};
	__property AlignmentEntireForm = {default=0};
	__property AlignmentLines = {default=0};
	__property AlignmentColorLeft = {default=8421504};
	__property AlignmentColorTop = {default=8421504};
	__property AlignmentColorRight = {default=8421504};
	__property AlignmentColorBottom = {default=8421504};
	__property MoveLimitMode = {default=0};
	__property OnMoveSizeControl;
	__property OnChange;
	__property OnLoadControl;
	__property OnSaveControl;
	__property OnSelectControl;
	__property OnSelectionChange;
	__property OnAddControl;
	__property OnDeleteControl;
	__property OnControlDblClick;
	__property OnActivate;
	__property OnDeactivate;
	__property OnKeyDown;
	__property OnKeyUp;
	__property OnMessage;
	__property OnMoveLimit;
	__property OnSizeLimit;
	__property OnReadError;
	__property OnCustomizeGrabs;
	__property OnComponentHint;
	__property OnComponentCaption;
	__property OnComponentBitmap;
	__property OnComponentEditable;
	__property OnCopyComponent;
	__property OnPasteComponent;
	__property OnContextPopup;
	__property OnEditBehaviour;
	__property OnPlaceComponent;
	__property OnEndPlacing;
	__property OnEndSelecting;
	__property OnShowAlignmentPalette;
public:
	/* TAdvCustomFormDesigner.Create */ inline __fastcall virtual TAdvFormDesigner(Classes::TComponent* AOwner) : TAdvCustomFormDesigner(AOwner) { }
	/* TAdvCustomFormDesigner.Destroy */ inline __fastcall virtual ~TAdvFormDesigner(void) { }
	
};


class DELPHICLASS EFormDesigner;
class PASCALIMPLEMENTATION EFormDesigner : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EFormDesigner(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EFormDesigner(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EFormDesigner(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EFormDesigner(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EFormDesigner(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EFormDesigner(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EFormDesigner(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EFormDesigner(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EFormDesigner(void) { }
	
};


class PASCALIMPLEMENTATION TIDEComponentEditor : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	Classes::TComponent* FComponent;
	TAdvCustomFormDesigner* FDesigner;
	
protected:
	virtual void __fastcall Edit(void);
	virtual void __fastcall ExecuteVerb(int Index);
	virtual System::UnicodeString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
	HIDESBASE Classes::TComponent* __fastcall GetComponent(void);
	TAdvCustomFormDesigner* __fastcall GetDesigner(void);
	
public:
	virtual bool __fastcall HasEditor(void);
public:
	/* TComponent.Create */ inline __fastcall virtual TIDEComponentEditor(Classes::TComponent* AOwner) : Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TIDEComponentEditor(void) { }
	
};


typedef TMetaClass* TIDEComponentEditorClass;

//-- var, const, procedure ---------------------------------------------------
static const Word WM_SECONDARYPAINT = 0x7e8;
static const Word WM_DESIGNERMDOWN = 0x7e9;
extern PACKAGE void __fastcall RegisterIDEComponentEditor(Classes::TComponentClass ComponentClass, TIDEComponentEditorClass ComponentEditor);
extern PACKAGE bool __fastcall Designing(void);

}	/* namespace Formdesigner */
using namespace Formdesigner;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FormdesignerHPP
