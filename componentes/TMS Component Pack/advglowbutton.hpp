// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advglowbutton.pas' rev: 21.00

#ifndef AdvglowbuttonHPP
#define AdvglowbuttonHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Gdipicture.hpp>	// Pascal unit
#include <Actnlist.hpp>	// Pascal unit
#include <Advhintinfo.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Activex.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advglowbutton
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TGlowState { gsHover, gsPush, gsNone };
#pragma option pop

#pragma option push -b-
enum TAdvButtonStyle { bsButton, bsCheck };
#pragma option pop

#pragma option push -b-
enum TAdvButtonState { absUp, absDisabled, absDown, absDropDown, absExclusive };
#pragma option pop

#pragma option push -b-
enum TButtonLayout { blGlyphLeft, blGlyphTop, blGlyphRight, blGlyphBottom, blGlyphLeftAdjusted, blGlyphRightAdjusted, blGlyphTopAdjusted, blGlyphBottomAdjusted };
#pragma option pop

#pragma option push -b-
enum TDropDownPosition { dpRight, dpBottom };
#pragma option pop

#pragma option push -b-
enum TDropDownDirection { ddDown, ddRight };
#pragma option pop

#pragma option push -b-
enum TGDIPGradient { ggRadial, ggVertical, ggDiagonalForward, ggDiagonalBackward };
#pragma option pop

#pragma option push -b-
enum TFocusType { ftBorder, ftHot, ftHotBorder, ftNone };
#pragma option pop

#pragma option push -b-
enum TShortCutHintPos { shpLeft, shpTop, shpRight, shpBottom, shpCenter, shpAuto, shpTopLeft, shpTopRight, shpAboveTop, shpAboveTopLeft, shpAboveTopRight, shpBottomLeft, shpBottomRight, shpBelowBottom, shpBelowBottomLeft, shpBelowBottomRight, shpBelowBottomCenter };
#pragma option pop

#pragma option push -b-
enum TButtonPosition { bpStandalone, bpLeft, bpMiddle, bpRight };
#pragma option pop

#pragma option push -b-
enum TGlowButtonState { gsNormal, gsHot, gsDown };
#pragma option pop

#pragma option push -b-
enum TButtonSizeState { bsGlyph, bsLabel, bsLarge };
#pragma option pop

typedef void __fastcall (__closure *TGlowButtonDrawEvent)(System::TObject* Sender, Graphics::TCanvas* Canvas, const Types::TRect &Rect, TGlowButtonState State);

typedef void __fastcall (__closure *TSetButtonSizeEvent)(System::TObject* Sender, int &W, int &H);

typedef void __fastcall (__closure *TOnGetShortCutHintPos)(System::TObject* Sender, TButtonSizeState ButtonSizeState, TShortCutHintPos &ShortCutHintPosition);

#pragma option push -b-
enum TImageListType { ipActionList, ipOwnLists };
#pragma option pop

class DELPHICLASS TWinCtrl;
class PASCALIMPLEMENTATION TWinCtrl : public Controls::TWinControl
{
	typedef Controls::TWinControl inherited;
	
public:
	void __fastcall PaintCtrls(HDC DC, Controls::TControl* First);
public:
	/* TWinControl.Create */ inline __fastcall virtual TWinCtrl(Classes::TComponent* AOwner) : Controls::TWinControl(AOwner) { }
	/* TWinControl.CreateParented */ inline __fastcall TWinCtrl(HWND ParentWindow) : Controls::TWinControl(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TWinCtrl(void) { }
	
};


class DELPHICLASS TAdvGlowButtonActionLink;
class DELPHICLASS TAdvCustomGlowButton;
class PASCALIMPLEMENTATION TAdvGlowButtonActionLink : public Controls::TControlActionLink
{
	typedef Controls::TControlActionLink inherited;
	
protected:
	int FImageIndex;
	TAdvCustomGlowButton* FClient;
	virtual void __fastcall AssignClient(System::TObject* AClient);
	virtual bool __fastcall IsCheckedLinked(void);
	virtual bool __fastcall IsGroupIndexLinked(void);
	virtual void __fastcall SetGroupIndex(int Value);
	virtual void __fastcall SetChecked(bool Value);
	virtual bool __fastcall IsImageIndexLinked(void);
	virtual void __fastcall SetImageIndex(int Value);
public:
	/* TBasicActionLink.Create */ inline __fastcall virtual TAdvGlowButtonActionLink(System::TObject* AClient) : Controls::TControlActionLink(AClient) { }
	/* TBasicActionLink.Destroy */ inline __fastcall virtual ~TAdvGlowButtonActionLink(void) { }
	
};


class DELPHICLASS TShortCutHintWindow;
class PASCALIMPLEMENTATION TShortCutHintWindow : public Controls::THintWindow
{
	typedef Controls::THintWindow inherited;
	
private:
	Graphics::TColor FColor;
	Graphics::TColor FColorTo;
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &Message);
	
protected:
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	
__published:
	__property Graphics::TColor Color = {read=FColor, write=FColor, nodefault};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=FColorTo, nodefault};
public:
	/* THintWindow.Create */ inline __fastcall virtual TShortCutHintWindow(Classes::TComponent* AOwner) : Controls::THintWindow(AOwner) { }
	
public:
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TShortCutHintWindow(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TShortCutHintWindow(HWND ParentWindow) : Controls::THintWindow(ParentWindow) { }
	
};


class DELPHICLASS TGlowButtonAppearance;
class PASCALIMPLEMENTATION TGlowButtonAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TNotifyEvent FOnChange;
	Graphics::TColor FBorderColor;
	Graphics::TColor FBorderColorHot;
	Graphics::TColor FBorderColorDown;
	Graphics::TColor FColor;
	Graphics::TColor FColorTo;
	Graphics::TColor FColorDown;
	Graphics::TColor FColorDownTo;
	Graphics::TColor FColorHot;
	Graphics::TColor FColorHotTo;
	Graphics::TColor FColorCheckedTo;
	Graphics::TColor FBorderColorDisabled;
	Graphics::TColor FBorderColorChecked;
	Graphics::TColor FColorDisabled;
	Graphics::TColor FColorDisabledTo;
	Graphics::TColor FColorChecked;
	Graphics::TColor FColorMirror;
	Graphics::TColor FColorMirrorTo;
	Graphics::TColor FColorMirrorHot;
	Graphics::TColor FColorMirrorHotTo;
	Graphics::TColor FColorMirrorDown;
	Graphics::TColor FColorMirrorDownTo;
	TGDIPGradient FGradientDown;
	TGDIPGradient FGradientMirror;
	TGDIPGradient FGradientMirrorHot;
	TGDIPGradient FGradient;
	TGDIPGradient FGradientMirrorDown;
	TGDIPGradient FGradientHot;
	Graphics::TColor FColorMirrorDisabledTo;
	Graphics::TColor FColorMirrorDisabled;
	Graphics::TColor FColorMirrorCheckedTo;
	Graphics::TColor FColorMirrorChecked;
	TGDIPGradient FGradientChecked;
	TGDIPGradient FGradientDisabled;
	TGDIPGradient FGradientMirrorChecked;
	TGDIPGradient FGradientMirrorDisabled;
	bool FSystemFont;
	void __fastcall SetSystemFont(const bool Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetBorderColorChecked(const Graphics::TColor Value);
	void __fastcall SetBorderColorDisabled(const Graphics::TColor Value);
	void __fastcall SetBorderColorDown(const Graphics::TColor Value);
	void __fastcall SetBorderColorHot(const Graphics::TColor Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorChecked(const Graphics::TColor Value);
	void __fastcall SetColorCheckedTo(const Graphics::TColor Value);
	void __fastcall SetColorDisabled(const Graphics::TColor Value);
	void __fastcall SetColorDisabledTo(const Graphics::TColor Value);
	void __fastcall SetColorDown(const Graphics::TColor Value);
	void __fastcall SetColorDownTo(const Graphics::TColor Value);
	void __fastcall SetColorHot(const Graphics::TColor Value);
	void __fastcall SetColorHotTo(const Graphics::TColor Value);
	void __fastcall SetColorMirror(const Graphics::TColor Value);
	void __fastcall SetColorMirrorChecked(const Graphics::TColor Value);
	void __fastcall SetColorMirrorCheckedTo(const Graphics::TColor Value);
	void __fastcall SetColorMirrorDisabled(const Graphics::TColor Value);
	void __fastcall SetColorMirrorDisabledTo(const Graphics::TColor Value);
	void __fastcall SetColorMirrorDown(const Graphics::TColor Value);
	void __fastcall SetColorMirrorDownTo(const Graphics::TColor Value);
	void __fastcall SetColorMirrorHot(const Graphics::TColor Value);
	void __fastcall SetColorMirrorHotTo(const Graphics::TColor Value);
	void __fastcall SetColorMirrorTo(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetGradient(const TGDIPGradient Value);
	void __fastcall SetGradientChecked(const TGDIPGradient Value);
	void __fastcall SetGradientDisabled(const TGDIPGradient Value);
	void __fastcall SetGradientDown(const TGDIPGradient Value);
	void __fastcall SetGradientHot(const TGDIPGradient Value);
	void __fastcall SetGradientMirror(const TGDIPGradient Value);
	void __fastcall SetGradientMirrorChecked(const TGDIPGradient Value);
	void __fastcall SetGradientMirrorDisabled(const TGDIPGradient Value);
	void __fastcall SetGradientMirrorDown(const TGDIPGradient Value);
	void __fastcall SetGradientMirrorHot(const TGDIPGradient Value);
	
protected:
	void __fastcall Changed(void);
	
public:
	__fastcall TGlowButtonAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
__published:
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=12632256};
	__property Graphics::TColor BorderColorHot = {read=FBorderColorHot, write=SetBorderColorHot, default=16711680};
	__property Graphics::TColor BorderColorDown = {read=FBorderColorDown, write=SetBorderColorDown, default=8388608};
	__property Graphics::TColor BorderColorChecked = {read=FBorderColorChecked, write=SetBorderColorChecked, default=16711680};
	__property Graphics::TColor BorderColorDisabled = {read=FBorderColorDisabled, write=SetBorderColorDisabled, default=8421504};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=16777215};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, default=16777215};
	__property Graphics::TColor ColorChecked = {read=FColorChecked, write=SetColorChecked, nodefault};
	__property Graphics::TColor ColorCheckedTo = {read=FColorCheckedTo, write=SetColorCheckedTo, nodefault};
	__property Graphics::TColor ColorDisabled = {read=FColorDisabled, write=SetColorDisabled, nodefault};
	__property Graphics::TColor ColorDisabledTo = {read=FColorDisabledTo, write=SetColorDisabledTo, nodefault};
	__property Graphics::TColor ColorDown = {read=FColorDown, write=SetColorDown, nodefault};
	__property Graphics::TColor ColorDownTo = {read=FColorDownTo, write=SetColorDownTo, nodefault};
	__property Graphics::TColor ColorHot = {read=FColorHot, write=SetColorHot, nodefault};
	__property Graphics::TColor ColorHotTo = {read=FColorHotTo, write=SetColorHotTo, nodefault};
	__property Graphics::TColor ColorMirror = {read=FColorMirror, write=SetColorMirror, default=12632256};
	__property Graphics::TColor ColorMirrorTo = {read=FColorMirrorTo, write=SetColorMirrorTo, default=16777215};
	__property Graphics::TColor ColorMirrorHot = {read=FColorMirrorHot, write=SetColorMirrorHot, nodefault};
	__property Graphics::TColor ColorMirrorHotTo = {read=FColorMirrorHotTo, write=SetColorMirrorHotTo, nodefault};
	__property Graphics::TColor ColorMirrorDown = {read=FColorMirrorDown, write=SetColorMirrorDown, nodefault};
	__property Graphics::TColor ColorMirrorDownTo = {read=FColorMirrorDownTo, write=SetColorMirrorDownTo, nodefault};
	__property Graphics::TColor ColorMirrorChecked = {read=FColorMirrorChecked, write=SetColorMirrorChecked, nodefault};
	__property Graphics::TColor ColorMirrorCheckedTo = {read=FColorMirrorCheckedTo, write=SetColorMirrorCheckedTo, nodefault};
	__property Graphics::TColor ColorMirrorDisabled = {read=FColorMirrorDisabled, write=SetColorMirrorDisabled, nodefault};
	__property Graphics::TColor ColorMirrorDisabledTo = {read=FColorMirrorDisabledTo, write=SetColorMirrorDisabledTo, nodefault};
	__property TGDIPGradient Gradient = {read=FGradient, write=SetGradient, default=1};
	__property TGDIPGradient GradientMirror = {read=FGradientMirror, write=SetGradientMirror, default=1};
	__property TGDIPGradient GradientHot = {read=FGradientHot, write=SetGradientHot, default=0};
	__property TGDIPGradient GradientMirrorHot = {read=FGradientMirrorHot, write=SetGradientMirrorHot, default=0};
	__property TGDIPGradient GradientDown = {read=FGradientDown, write=SetGradientDown, default=0};
	__property TGDIPGradient GradientMirrorDown = {read=FGradientMirrorDown, write=SetGradientMirrorDown, default=0};
	__property TGDIPGradient GradientChecked = {read=FGradientChecked, write=SetGradientChecked, default=0};
	__property TGDIPGradient GradientMirrorChecked = {read=FGradientMirrorChecked, write=SetGradientMirrorChecked, default=1};
	__property TGDIPGradient GradientDisabled = {read=FGradientDisabled, write=SetGradientDisabled, default=0};
	__property TGDIPGradient GradientMirrorDisabled = {read=FGradientMirrorDisabled, write=SetGradientMirrorDisabled, default=0};
	__property bool SystemFont = {read=FSystemFont, write=SetSystemFont, default=1};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TGlowButtonAppearance(void) { }
	
};


class PASCALIMPLEMENTATION TAdvCustomGlowButton : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	bool FActive;
	bool FDown;
	bool FLeftDown;
	bool FMouseDown;
	Extctrls::TTimer* FTimer;
	int FStepHover;
	int FStepPush;
	int FTimeInc;
	TGlowState FGlowState;
	Imglist::TCustomImageList* FImages;
	Imglist::TImageIndex FImageIndex;
	TAdvButtonState FState;
	bool FMouseInControl;
	bool FMouseEnter;
	bool FDownChecked;
	bool FInitialDown;
	bool FDragging;
	TAdvButtonStyle FStyle;
	int FGroupIndex;
	bool FAllowAllUp;
	bool FTransparent;
	TButtonLayout FLayout;
	bool FDropDownButton;
	bool FDropDownSplit;
	TDropDownDirection FDropDownDirection;
	Menus::TPopupMenu* FDropDownMenu;
	Classes::TNotifyEvent FOnDropDown;
	TDropDownPosition FDropDownPosition;
	TGlowButtonAppearance* FAppearance;
	Imglist::TCustomImageList* FDisabledImages;
	Imglist::TCustomImageList* FInternalImages;
	Imglist::TCustomImageList* FHotImages;
	Gdipicture::TGDIPPicture* FIPicture;
	Gdipicture::TGDIPPicture* FIDisabledPicture;
	Gdipicture::TGDIPPicture* FIHotPicture;
	bool FShowCaption;
	Advgdip::TAntiAlias FAntiAlias;
	Controls::TModalResult FModalResult;
	bool FDefault;
	bool FCancel;
	bool FInButton;
	Forms::TFormBorderStyle FBorderStyle;
	TButtonPosition FButtonPosition;
	Advhintinfo::TAdvHintInfo* FOfficeHint;
	bool FCheckLinked;
	bool FGroupIndexLinked;
	TFocusType FFocusType;
	TShortCutHintWindow* FShortCutHint;
	TShortCutHintPos FShortCutHintPos;
	System::UnicodeString FShortCutHintText;
	bool FShowDisabled;
	Controls::TKeyEvent FOnInternalKeyDown;
	Classes::TNotifyEvent FOnMouseLeave;
	Classes::TNotifyEvent FOnMouseEnter;
	bool FDroppedDown;
	bool FOverlappedText;
	int FSpacing;
	bool FAutoSize;
	bool FWordWrap;
	bool FDoAutoSize;
	bool FFirstPaint;
	int FMarginVert;
	int FMarginHorz;
	bool FRounded;
	TGlowButtonDrawEvent FOnDrawButton;
	System::WideString FWideCaption;
	Advgdip::StringTrimming FTrimming;
	Extctrls::TTimer* FRepeatTimer;
	int FInitRepeatPause;
	int FRepeatPause;
	bool FRepeatClick;
	bool FPainting;
	Classes::TNotifyEvent FOnInternalClick;
	TButtonSizeState FButtonSizeState;
	TButtonSizeState FMaxButtonSizeState;
	TSetButtonSizeEvent FOnSetButtonSize;
	TButtonLayout FOldLayout;
	TDropDownPosition FOldDropDownPosition;
	TButtonSizeState FMinButtonSizeState;
	Forms::TCustomForm* FParentForm;
	bool FIsVista;
	Classes::TStringList* FNotes;
	Graphics::TFont* FNotesFont;
	bool FGotButtonClick;
	TOnGetShortCutHintPos FOnGetShortCutHintPos;
	bool FHasFocus;
	bool FStaticButton;
	Imglist::TChangeLink* FImageChangeLink;
	Imglist::TChangeLink* FDisabledImageChangeLink;
	Imglist::TChangeLink* FHotImageChangeLink;
	TImageListType FImageListType;
	Classes::TNotifyEvent FOnInternalDropDown;
	static bool FStaticActionImageIndex;
	void __fastcall SetOfficeHint(const Advhintinfo::TAdvHintInfo* Value);
	void __fastcall SetButtonPosition(const TButtonPosition Value);
	void __fastcall SetBorderStyle(const Forms::TBorderStyle Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetDefault(const bool Value);
	void __fastcall SetAntiAlias(const Advgdip::TAntiAlias Value);
	void __fastcall SetShowCaption(const bool Value);
	void __fastcall SetDisabledPicture(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetHotPicture(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetPicture(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetTransparent(const bool Value);
	void __fastcall UpdateExclusive(void);
	void __fastcall UpdateTracking(void);
	void __fastcall SetImageIndex(const Imglist::TImageIndex Value);
	void __fastcall SetImages(const Imglist::TCustomImageList* Value);
	HIDESBASE MESSAGE void __fastcall CMDialogKey(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMFocusChanged(Controls::TCMFocusChanged &Message);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Message);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TMessage &Message);
	MESSAGE void __fastcall CNCommand(Messages::TWMCommand &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	MESSAGE void __fastcall WMSetText(Messages::TWMSetText &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	MESSAGE void __fastcall CMButtonPressed(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TWMMouse &Msg);
	MESSAGE void __fastcall WMLDblClk(Messages::TWMMouse &Msg);
	void __fastcall TimerProc(System::TObject* Sender);
	void __fastcall OnAppearanceChanged(System::TObject* Sender);
	void __fastcall SetDown(bool Value);
	void __fastcall SetStyle(const TAdvButtonStyle Value);
	void __fastcall SetGroupIndex(const int Value);
	void __fastcall SetAllowAllUp(const bool Value);
	void __fastcall SetLayout(const TButtonLayout Value);
	void __fastcall SetDropDownButton(const bool Value);
	void __fastcall PopupBtnDown(void);
	void __fastcall SetDropDownPosition(const TDropDownPosition Value);
	void __fastcall SetDropDownDirection(const TDropDownDirection Value);
	void __fastcall SetAppearance(const TGlowButtonAppearance* Value);
	void __fastcall SetDisabledImages(const Imglist::TCustomImageList* Value);
	void __fastcall ImageListChange(System::TObject* Sender);
	void __fastcall DisabledImageListChange(System::TObject* Sender);
	void __fastcall HotImageListChange(System::TObject* Sender);
	void __fastcall PictureChanged(System::TObject* Sender);
	void __fastcall SetSpacing(const int Value);
	void __fastcall SetAutoSizeEx(const bool Value);
	void __fastcall SetShowDisabled(const bool Value);
	void __fastcall SetWordWrap(const bool Value);
	void __fastcall SetMarginVert(const int Value);
	void __fastcall SetMarginHorz(const int Value);
	void __fastcall SetRounded(const bool Value);
	void __fastcall SetTrimming(const Advgdip::StringTrimming Value);
	void __fastcall PerformResize(void);
	HIDESBASE bool __fastcall IsFontStored(void);
	void __fastcall SetButtonSizeState(const TButtonSizeState Value);
	void __fastcall SetMaxButtonSizeState(const TButtonSizeState Value);
	void __fastcall SetMinButtonSizeState(const TButtonSizeState Value);
	void __fastcall SetNotes(const Classes::TStrings* Value);
	Classes::TStrings* __fastcall GetNotes(void);
	void __fastcall SetNotesFont(const Graphics::TFont* Value);
	void __fastcall SetWideCaption(const System::WideString Value);
	void __fastcall SetHotImages(const Imglist::TCustomImageList* Value);
	void __fastcall SetImageListType(const TImageListType Value);
	bool __fastcall ActionHasImages(void);
	
protected:
	bool FHot;
	bool FDefaultPicDrawing;
	bool FDefaultCaptionDrawing;
	bool FCustomizerCreated;
	int FCommandID;
	virtual void __fastcall TimerExpired(System::TObject* Sender);
	virtual void __fastcall DrawGlyphCaption(void);
	virtual void __fastcall GetToolImage(Graphics::TBitmap* bmp);
	void __fastcall SetDroppedDown(bool Value);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC Controls::TControlActionLinkClass __fastcall GetActionLinkClass(void);
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	__property TGlowState GlowState = {read=FGlowState, write=FGlowState, nodefault};
	__property bool Down = {read=FDownChecked, write=SetDown, default=0};
	__property TAdvButtonStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property TAdvButtonState State = {read=FState, write=FState, nodefault};
	__property int GroupIndex = {read=FGroupIndex, write=SetGroupIndex, default=0};
	__property bool AllowAllUp = {read=FAllowAllUp, write=SetAllowAllUp, default=0};
	__property TButtonLayout Layout = {read=FLayout, write=SetLayout, default=0};
	__property bool DroppedDown = {read=FDroppedDown, nodefault};
	__property bool DropDownButton = {read=FDropDownButton, write=SetDropDownButton, default=0};
	__property TDropDownDirection DropDownDirection = {read=FDropDownDirection, write=SetDropDownDirection, default=0};
	__property TDropDownPosition DropDownPosition = {read=FDropDownPosition, write=SetDropDownPosition, default=0};
	__property bool DropDownSplit = {read=FDropDownSplit, write=FDropDownSplit, default=1};
	__property Menus::TPopupMenu* DropDownMenu = {read=FDropDownMenu, write=FDropDownMenu};
	__property Classes::TNotifyEvent OnDropDown = {read=FOnDropDown, write=FOnDropDown};
	virtual int __fastcall GetVersionNr(void);
	virtual bool __fastcall IsMenuButton(void);
	virtual bool __fastcall CanDrawBorder(void);
	virtual bool __fastcall CanDrawFocused(void);
	void __fastcall InternalClick(void);
	__property bool CheckLinked = {read=FCheckLinked, write=FCheckLinked, nodefault};
	__property bool GroupIndexLinked = {read=FGroupIndexLinked, write=FGroupIndexLinked, nodefault};
	__property Controls::TKeyEvent OnInternalKeyDown = {read=FOnInternalKeyDown, write=FOnInternalKeyDown};
	__property Classes::TNotifyEvent OnInternalClick = {read=FOnInternalClick, write=FOnInternalClick};
	__property Classes::TNotifyEvent OnInternalDropDown = {read=FOnInternalDropDown, write=FOnInternalDropDown};
	__property TOnGetShortCutHintPos OnGetShortCutHintPos = {read=FOnGetShortCutHintPos, write=FOnGetShortCutHintPos};
	__property bool OverlappedText = {read=FOverlappedText, write=FOverlappedText, nodefault};
	__property bool DoAutoSize = {read=FDoAutoSize, write=FDoAutoSize, nodefault};
	__property TButtonSizeState ButtonSizeState = {read=FButtonSizeState, write=SetButtonSizeState, nodefault};
	__property TButtonSizeState MaxButtonSizeState = {read=FMaxButtonSizeState, write=SetMaxButtonSizeState, default=2};
	__property TButtonSizeState MinButtonSizeState = {read=FMinButtonSizeState, write=SetMinButtonSizeState, default=0};
	__property TSetButtonSizeEvent OnSetButtonSize = {read=FOnSetButtonSize, write=FOnSetButtonSize};
	tagSIZE __fastcall GetButtonSize(TButtonSizeState BtnSizeState);
	
public:
	__fastcall virtual TAdvCustomGlowButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvCustomGlowButton(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall CreateWnd(void);
	DYNAMIC void __fastcall Click(void);
	void __fastcall DoDropDown(void);
	__property TGlowButtonAppearance* Appearance = {read=FAppearance, write=SetAppearance};
	void __fastcall ShowShortCutHint(void);
	void __fastcall HideShortCutHint(void);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	__property System::WideString WideCaption = {read=FWideCaption, write=SetWideCaption};
	/* static */ __property bool StaticActionImageIndex = {read=FStaticActionImageIndex, write=FStaticActionImageIndex, nodefault};
	__property bool StaticButton = {read=FStaticButton, write=FStaticButton, default=0};
	
__published:
	__property Align = {default=0};
	__property Action;
	__property Anchors = {default=3};
	__property Advgdip::TAntiAlias AntiAlias = {read=FAntiAlias, write=SetAntiAlias, default=1};
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSizeEx, default=0};
	__property Forms::TBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=1};
	__property bool Cancel = {read=FCancel, write=FCancel, default=0};
	__property Caption;
	__property Constraints;
	__property bool Default = {read=FDefault, write=SetDefault, default=0};
	__property Font = {stored=IsFontStored};
	__property Imglist::TImageIndex ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property Imglist::TCustomImageList* DisabledImages = {read=FDisabledImages, write=SetDisabledImages};
	__property Gdipicture::TGDIPPicture* DisabledPicture = {read=FIDisabledPicture, write=SetDisabledPicture};
	__property DragMode = {default=0};
	__property DragKind = {default=0};
	__property TFocusType FocusType = {read=FFocusType, write=FFocusType, default=0};
	__property Imglist::TCustomImageList* HotImages = {read=FHotImages, write=SetHotImages};
	__property Gdipicture::TGDIPPicture* HotPicture = {read=FIHotPicture, write=SetHotPicture};
	__property TImageListType ImageListType = {read=FImageListType, write=SetImageListType, default=0};
	__property int MarginVert = {read=FMarginVert, write=SetMarginVert, default=1};
	__property int MarginHorz = {read=FMarginHorz, write=SetMarginHorz, default=1};
	__property Controls::TModalResult ModalResult = {read=FModalResult, write=FModalResult, default=0};
	__property Classes::TStrings* Notes = {read=GetNotes, write=SetNotes};
	__property Graphics::TFont* NotesFont = {read=FNotesFont, write=SetNotesFont};
	__property Advhintinfo::TAdvHintInfo* OfficeHint = {read=FOfficeHint, write=SetOfficeHint};
	__property ParentFont = {default=1};
	__property Gdipicture::TGDIPPicture* Picture = {read=FIPicture, write=SetPicture};
	__property PopupMenu;
	__property TButtonPosition Position = {read=FButtonPosition, write=SetButtonPosition, default=0};
	__property int InitRepeatPause = {read=FInitRepeatPause, write=FInitRepeatPause, default=400};
	__property int RepeatPause = {read=FRepeatPause, write=FRepeatPause, default=100};
	__property bool RepeatClick = {read=FRepeatClick, write=FRepeatClick, default=0};
	__property bool Rounded = {read=FRounded, write=SetRounded, default=1};
	__property System::UnicodeString ShortCutHint = {read=FShortCutHintText, write=FShortCutHintText};
	__property TShortCutHintPos ShortCutHintPos = {read=FShortCutHintPos, write=FShortCutHintPos, default=1};
	__property bool ShowCaption = {read=FShowCaption, write=SetShowCaption, default=1};
	__property bool ShowDisabled = {read=FShowDisabled, write=SetShowDisabled, default=1};
	__property int Spacing = {read=FSpacing, write=SetSpacing, default=2};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property Advgdip::StringTrimming Trimming = {read=FTrimming, write=SetTrimming, default=0};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion, stored=false};
	__property bool WordWrap = {read=FWordWrap, write=SetWordWrap, default=1};
	__property ParentShowHint = {default=1};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Visible = {default=1};
	__property OnClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnExit;
	__property OnEnter;
	__property OnStartDock;
	__property OnStartDrag;
	__property OnMouseDown;
	__property OnMouseUp;
	__property OnMouseMove;
	__property OnKeyDown;
	__property OnKeyUp;
	__property OnKeyPress;
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property TGlowButtonDrawEvent OnDrawButton = {read=FOnDrawButton, write=FOnDrawButton};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvCustomGlowButton(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
private:
	void *__ITMSStyle;	/* Advstyleif::ITMSStyle */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Advstyleif::_di_ITMSStyle()
	{
		Advstyleif::_di_ITMSStyle intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator ITMSStyle*(void) { return (ITMSStyle*)&__ITMSStyle; }
	#endif
	
};


class DELPHICLASS TAdvGlowButton;
class PASCALIMPLEMENTATION TAdvGlowButton : public TAdvCustomGlowButton
{
	typedef TAdvCustomGlowButton inherited;
	
public:
	__property State;
	__property DroppedDown;
	
__published:
	__property AllowAllUp = {default=0};
	__property Appearance;
	__property Down = {default=0};
	__property Enabled = {default=1};
	__property GroupIndex = {default=0};
	__property Layout = {default=0};
	__property Style = {default=0};
	__property MaxButtonSizeState = {default=2};
	__property MinButtonSizeState = {default=0};
	__property DropDownButton = {default=0};
	__property DropDownPosition = {default=0};
	__property DropDownDirection = {default=0};
	__property DropDownSplit = {default=1};
	__property DropDownMenu;
	__property OnDropDown;
public:
	/* TAdvCustomGlowButton.Create */ inline __fastcall virtual TAdvGlowButton(Classes::TComponent* AOwner) : TAdvCustomGlowButton(AOwner) { }
	/* TAdvCustomGlowButton.Destroy */ inline __fastcall virtual ~TAdvGlowButton(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvGlowButton(HWND ParentWindow) : TAdvCustomGlowButton(ParentWindow) { }
	
};


#pragma option push -b-
enum TDBGlowButtonType { dbCustom, dbFirst, dbPrior, dbNext, dbLast, dbInsert, dbAppend, dbDelete, dbEdit, dbPost, dbCancel, dbRefresh };
#pragma option pop

#pragma option push -b-
enum TDBBDisableControl { drBOF, drEOF, drReadonly, drNotEditing, drEditing, drEmpty, drEvent };
#pragma option pop

typedef Set<TDBBDisableControl, drBOF, drEvent>  TDBBDisableControls;

typedef void __fastcall (__closure *TBeforeActionEvent)(System::TObject* Sender, bool &DoAction);

typedef void __fastcall (__closure *TAfterActionEvent)(System::TObject* Sender, bool &ShowException);

typedef void __fastcall (__closure *TGetConfirmEvent)(System::TObject* Sender, System::UnicodeString &Question, Dialogs::TMsgDlgButtons &Buttons, int &HelpCtx);

typedef void __fastcall (__closure *TGetEnabledEvent)(System::TObject* Sender, bool &Enabled);

class DELPHICLASS TDBGlowButtonDataLink;
class PASCALIMPLEMENTATION TDBGlowButtonDataLink : public Db::TDataLink
{
	typedef Db::TDataLink inherited;
	
private:
	Classes::TNotifyEvent FOnEditingChanged;
	Classes::TNotifyEvent FOnDataSetChanged;
	Classes::TNotifyEvent FOnActiveChanged;
	
protected:
	virtual void __fastcall EditingChanged(void);
	virtual void __fastcall DataSetChanged(void);
	virtual void __fastcall ActiveChanged(void);
	
public:
	__fastcall TDBGlowButtonDataLink(void);
	__property Classes::TNotifyEvent OnEditingChanged = {read=FOnEditingChanged, write=FOnEditingChanged};
	__property Classes::TNotifyEvent OnDataSetChanged = {read=FOnDataSetChanged, write=FOnDataSetChanged};
	__property Classes::TNotifyEvent OnActiveChanged = {read=FOnActiveChanged, write=FOnActiveChanged};
public:
	/* TDataLink.Destroy */ inline __fastcall virtual ~TDBGlowButtonDataLink(void) { }
	
};


class DELPHICLASS TDBAdvGlowButton;
class PASCALIMPLEMENTATION TDBAdvGlowButton : public TAdvCustomGlowButton
{
	typedef TAdvCustomGlowButton inherited;
	
private:
	TDBGlowButtonDataLink* FDataLink;
	bool FAutoDisable;
	TDBBDisableControls FDisableControls;
	TAfterActionEvent FOnAfterAction;
	TBeforeActionEvent FOnBeforeAction;
	TDBGlowButtonType FDBButtonType;
	TGetConfirmEvent FOnGetConfirm;
	TGetEnabledEvent FOnGetEnabled;
	Classes::TNotifyEvent FOnEnabledChanged;
	bool FConfirmAction;
	System::UnicodeString FConfirmActionString;
	bool FInProcUpdateEnabled;
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	void __fastcall OnDataSetEvents(System::TObject* Sender);
	Db::TDataSource* __fastcall GetDataSource(void);
	void __fastcall SetDataSource(const Db::TDataSource* Value);
	void __fastcall SetDBButtonType(const TDBGlowButtonType Value);
	void __fastcall SetConfirmActionString(const System::UnicodeString Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	virtual void __fastcall Loaded(void);
	void __fastcall CalcDisableReasons(void);
	virtual void __fastcall DoBeforeAction(bool &DoAction);
	virtual void __fastcall DoGetQuestion(System::UnicodeString &Question, Dialogs::TMsgDlgButtons &Buttons, int &HelpCtx);
	virtual bool __fastcall DoConfirmAction(void);
	virtual void __fastcall DoAction(void);
	virtual void __fastcall UpdateEnabled(void);
	virtual void __fastcall LoadGlyph(void);
	
public:
	__fastcall virtual TDBAdvGlowButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBAdvGlowButton(void);
	DYNAMIC void __fastcall Click(void);
	
__published:
	__property Action;
	__property Appearance;
	__property Layout = {default=0};
	__property Constraints;
	__property bool AutoDisable = {read=FAutoDisable, write=FAutoDisable, nodefault};
	__property bool ConfirmAction = {read=FConfirmAction, write=FConfirmAction, nodefault};
	__property System::UnicodeString ConfirmActionString = {read=FConfirmActionString, write=SetConfirmActionString};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property TDBGlowButtonType DBButtonType = {read=FDBButtonType, write=SetDBButtonType, nodefault};
	__property TDBBDisableControls DisableControl = {read=FDisableControls, write=FDisableControls, nodefault};
	__property Enabled = {default=1};
	__property TBeforeActionEvent OnBeforeAction = {read=FOnBeforeAction, write=FOnBeforeAction};
	__property TAfterActionEvent OnAfterAction = {read=FOnAfterAction, write=FOnAfterAction};
	__property TGetConfirmEvent OnGetConfirm = {read=FOnGetConfirm, write=FOnGetConfirm};
	__property TGetEnabledEvent OnGetEnabled = {read=FOnGetEnabled, write=FOnGetEnabled};
	__property Classes::TNotifyEvent OnEnabledChanged = {read=FOnEnabledChanged, write=FOnEnabledChanged};
public:
	/* TWinControl.CreateParented */ inline __fastcall TDBAdvGlowButton(HWND ParentWindow) : TAdvCustomGlowButton(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt DropDownSectWidth = 0xe;
static const ShortInt MAJ_VER = 0x2;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x1;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Advglowbutton */
using namespace Advglowbutton;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvglowbuttonHPP
