// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advshapebutton.pas' rev: 21.00

#ifndef AdvshapebuttonHPP
#define AdvshapebuttonHPP

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
#include <Gdipicture.hpp>	// Pascal unit
#include <Actnlist.hpp>	// Pascal unit
#include <Advhintinfo.hpp>	// Pascal unit
#include <Advpreviewmenu.hpp>	// Pascal unit
#include <Advglowbutton.hpp>	// Pascal unit
#include <Advtoolbar.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Advdwm.hpp>	// Pascal unit
#include <Advtbxpvs.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advshapebutton
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TInternalAdvPreviewMenu;
class PASCALIMPLEMENTATION TInternalAdvPreviewMenu : public Advpreviewmenu::TAdvPreviewMenu
{
	typedef Advpreviewmenu::TAdvPreviewMenu inherited;
	
public:
	/* TAdvPreviewMenu.Create */ inline __fastcall virtual TInternalAdvPreviewMenu(Classes::TComponent* AOwner) : Advpreviewmenu::TAdvPreviewMenu(AOwner) { }
	/* TAdvPreviewMenu.Destroy */ inline __fastcall virtual ~TInternalAdvPreviewMenu(void) { }
	
};


#pragma option push -b-
enum TAdvToolButtonStyle { tasButton, tasCheck };
#pragma option pop

#pragma option push -b-
enum TAdvButtonState { absUp, absDisabled, absDown, absDropDown, absExclusive };
#pragma option pop

#pragma option push -b-
enum TShapeButtonLayout { plPictureCenter, plPictureOnTop, plPictureAtBottom };
#pragma option pop

class DELPHICLASS TAdvShapeButtonActionLink;
class DELPHICLASS TAdvCustomShapeButton;
class PASCALIMPLEMENTATION TAdvShapeButtonActionLink : public Controls::TControlActionLink
{
	typedef Controls::TControlActionLink inherited;
	
protected:
	TAdvCustomShapeButton* FClient;
	virtual void __fastcall AssignClient(System::TObject* AClient);
	virtual bool __fastcall IsCheckedLinked(void);
	virtual bool __fastcall IsGroupIndexLinked(void);
	virtual void __fastcall SetGroupIndex(int Value);
	virtual void __fastcall SetChecked(bool Value);
public:
	/* TBasicActionLink.Create */ inline __fastcall virtual TAdvShapeButtonActionLink(System::TObject* AClient) : Controls::TControlActionLink(AClient) { }
	/* TBasicActionLink.Destroy */ inline __fastcall virtual ~TAdvShapeButtonActionLink(void) { }
	
};


#pragma option push -b-
enum TAdvButtonShape { bsCustom, bsRectangle, bsOrb };
#pragma option pop

#pragma option push -b-
enum TShapeRoundingType { srtNone, srtTop, srtBottom, srtBoth, srtLeft, srtRight };
#pragma option pop

class DELPHICLASS TAdvShapeButtonAppearance;
class PASCALIMPLEMENTATION TAdvShapeButtonAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvCustomShapeButton* FOwner;
	Graphics::TColor FColorHotMirrorTo;
	Graphics::TColor FBorderColor;
	Graphics::TColor FBorderColorHot;
	TAdvButtonShape FShape;
	Graphics::TColor FColor;
	Graphics::TColor FColorDownMirror;
	Graphics::TColor FColorTo;
	Graphics::TColor FInnerBorderColor;
	Graphics::TColor FColorDownMirrorTo;
	Graphics::TColor FColorHot;
	Graphics::TColor FColorHotTo;
	Graphics::TColor FInnerBorderColorHot;
	Graphics::TColor FBorderColorDown;
	Graphics::TColor FColorDown;
	Graphics::TColor FColorDownTo;
	Graphics::TColor FColorMirror;
	Graphics::TColor FInnerBorderColorDown;
	Graphics::TColor FColorMirrorTo;
	Graphics::TColor FColorHotMirror;
	Graphics::TColor FColorDisabled;
	Graphics::TColor FColorDisabledTo;
	Graphics::TColor FInnerBorderColorDisabled;
	Graphics::TColor FColorDisabledMirror;
	Graphics::TColor FColorDisabledMirrorTo;
	Graphics::TColor FBorderColorDisabled;
	bool FShowMenuShape;
	Graphics::TColor FMenuShapeColorDisabled;
	Graphics::TColor FMenuShapeColor;
	Graphics::TColor FMenuShapeColorHot;
	Graphics::TColor FMenuShapeColorDown;
	bool FShowPicture;
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetBorderColorDown(const Graphics::TColor Value);
	void __fastcall SetBorderColorHot(const Graphics::TColor Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorDown(const Graphics::TColor Value);
	void __fastcall SetColorDownMirror(const Graphics::TColor Value);
	void __fastcall SetColorDownMirrorTo(const Graphics::TColor Value);
	void __fastcall SetColorDownTo(const Graphics::TColor Value);
	void __fastcall SetColorHot(const Graphics::TColor Value);
	void __fastcall SetColorHotMirror(const Graphics::TColor Value);
	void __fastcall SetColorHotMirrorTo(const Graphics::TColor Value);
	void __fastcall SetColorHotTo(const Graphics::TColor Value);
	void __fastcall SetColorMirror(const Graphics::TColor Value);
	void __fastcall SetColorMirrorTo(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetInnerBorderColor(const Graphics::TColor Value);
	void __fastcall SetInnerBorderColorDown(const Graphics::TColor Value);
	void __fastcall SetInnerBorderColorHot(const Graphics::TColor Value);
	void __fastcall SetShape(const TAdvButtonShape Value);
	void __fastcall SetBorderColorDisabled(const Graphics::TColor Value);
	void __fastcall SetColorDisabled(const Graphics::TColor Value);
	void __fastcall SetColorDisabledMirror(const Graphics::TColor Value);
	void __fastcall SetColorDisabledMirrorTo(const Graphics::TColor Value);
	void __fastcall SetColorDisabledTo(const Graphics::TColor Value);
	void __fastcall SetInnerBorderColorDisabled(const Graphics::TColor Value);
	void __fastcall SetShowMenuShape(const bool Value);
	void __fastcall SetMenuShapeColor(const Graphics::TColor Value);
	void __fastcall SetMenuShapeColorDisabled(const Graphics::TColor Value);
	void __fastcall SetMenuShapeColorDown(const Graphics::TColor Value);
	void __fastcall SetMenuShapeColorHot(const Graphics::TColor Value);
	void __fastcall SetShowPicture(const bool Value);
	
protected:
	void __fastcall Changed(void);
	
public:
	void __fastcall AssignColors(Classes::TPersistent* Source);
	__fastcall TAdvShapeButtonAppearance(TAdvCustomShapeButton* AOwner);
	__fastcall virtual ~TAdvShapeButtonAppearance(void);
	void __fastcall UpdateButtonColor(Graphics::TColor AColor);
	
__published:
	__property TAdvButtonShape Shape = {read=FShape, write=SetShape, default=0};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=12413505};
	__property Graphics::TColor BorderColorHot = {read=FBorderColorHot, write=SetBorderColorHot, default=13993796};
	__property Graphics::TColor BorderColorDown = {read=FBorderColorDown, write=SetBorderColorDown, default=12413505};
	__property Graphics::TColor BorderColorDisabled = {read=FBorderColorDisabled, write=SetBorderColorDisabled, default=8421504};
	__property Graphics::TColor InnerBorderColor = {read=FInnerBorderColor, write=SetInnerBorderColor, default=13607033};
	__property Graphics::TColor InnerBorderColorHot = {read=FInnerBorderColorHot, write=SetInnerBorderColorHot, default=15978143};
	__property Graphics::TColor InnerBorderColorDown = {read=FInnerBorderColorDown, write=SetInnerBorderColorDown, default=13607033};
	__property Graphics::TColor InnerBorderColorDisabled = {read=FInnerBorderColorDisabled, write=SetInnerBorderColorDisabled, default=12632256};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=13011785};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, default=11757871};
	__property Graphics::TColor ColorMirror = {read=FColorMirror, write=SetColorMirror, default=8929562};
	__property Graphics::TColor ColorMirrorTo = {read=FColorMirrorTo, write=SetColorMirrorTo, default=13540160};
	__property Graphics::TColor ColorHot = {read=FColorHot, write=SetColorHot, default=15710584};
	__property Graphics::TColor ColorHotTo = {read=FColorHotTo, write=SetColorHotTo, default=13796424};
	__property Graphics::TColor ColorHotMirror = {read=FColorHotMirror, write=SetColorHotMirror, default=11488785};
	__property Graphics::TColor ColorHotMirrorTo = {read=FColorHotMirrorTo, write=SetColorHotMirrorTo, default=16777110};
	__property Graphics::TColor ColorDown = {read=FColorDown, write=SetColorDown, default=13011785};
	__property Graphics::TColor ColorDownTo = {read=FColorDownTo, write=SetColorDownTo, default=11757871};
	__property Graphics::TColor ColorDownMirror = {read=FColorDownMirror, write=SetColorDownMirror, default=8929562};
	__property Graphics::TColor ColorDownMirrorTo = {read=FColorDownMirrorTo, write=SetColorDownMirrorTo, default=13540160};
	__property Graphics::TColor ColorDisabled = {read=FColorDisabled, write=SetColorDisabled, default=14408667};
	__property Graphics::TColor ColorDisabledTo = {read=FColorDisabledTo, write=SetColorDisabledTo, default=12895428};
	__property Graphics::TColor ColorDisabledMirror = {read=FColorDisabledMirror, write=SetColorDisabledMirror, default=11184810};
	__property Graphics::TColor ColorDisabledMirrorTo = {read=FColorDisabledMirrorTo, write=SetColorDisabledMirrorTo, default=12632256};
	__property bool ShowMenuShape = {read=FShowMenuShape, write=SetShowMenuShape, default=0};
	__property Graphics::TColor MenuShapeColor = {read=FMenuShapeColor, write=SetMenuShapeColor, default=16777215};
	__property Graphics::TColor MenuShapeColorHot = {read=FMenuShapeColorHot, write=SetMenuShapeColorHot, default=16777215};
	__property Graphics::TColor MenuShapeColorDown = {read=FMenuShapeColorDown, write=SetMenuShapeColorDown, default=16777215};
	__property Graphics::TColor MenuShapeColorDisabled = {read=FMenuShapeColorDisabled, write=SetMenuShapeColorDisabled, default=16777215};
	__property bool ShowPicture = {read=FShowPicture, write=SetShowPicture, default=1};
};


class DELPHICLASS TFrameWindow;
class PASCALIMPLEMENTATION TFrameWindow : public Forms::TCustomForm
{
	typedef Forms::TCustomForm inherited;
	
private:
	bool FHideOnDeActivate;
	Classes::TComponent* FOwner;
	bool FShowBorder;
	Extctrls::TTimer* FHideTimer;
	Graphics::TColor FBorderColor;
	HIDESBASE MESSAGE void __fastcall WMActivate(Messages::TWMActivate &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseActivate(Messages::TWMMouseActivate &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Message);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TMessage &Msg);
	void __fastcall HideTimerOnTime(System::TObject* Sender);
	
protected:
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall Paint(void);
	HWND __fastcall GetParentWnd(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	void __fastcall SetRegion(void);
	__property bool HideOnDeActivate = {read=FHideOnDeActivate, write=FHideOnDeActivate, nodefault};
	__property bool ShowBorder = {read=FShowBorder, write=FShowBorder, nodefault};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=FBorderColor, nodefault};
	
public:
	__fastcall virtual TFrameWindow(Classes::TComponent* AOwner);
	__fastcall virtual TFrameWindow(Classes::TComponent* AOwner, int Dummy);
	__fastcall virtual ~TFrameWindow(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
public:
	/* TWinControl.CreateParented */ inline __fastcall TFrameWindow(HWND ParentWindow) : Forms::TCustomForm(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TAdvCustomShapeButton : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	TFrameWindow* FMenuFrame;
	int FGroupIndex;
	bool FDown;
	bool FAllowAllUp;
	int FOffSet;
	bool FMouseInControl;
	bool FHot;
	Classes::TNotifyEvent FOnMouseLeave;
	Classes::TNotifyEvent FOnMouseEnter;
	TAdvToolButtonStyle FStyle;
	TAdvButtonState FState;
	bool FMouseDownInControl;
	bool FGrouped;
	bool FDragging;
	bool FPropHot;
	Extctrls::TTimer* FUnHotTimer;
	bool FInitialDown;
	Advhintinfo::TAdvHintInfo* FOfficeHint;
	Gdipicture::TGDIPPicture* FIPictureDown;
	Gdipicture::TGDIPPicture* FIPictureDisabled;
	Gdipicture::TGDIPPicture* FIPicture;
	Gdipicture::TGDIPPicture* FIPictureHot;
	Advpreviewmenu::TAdvPreviewMenu* FAdvPreviewMenu;
	Advglowbutton::TShortCutHintWindow* FShortCutHint;
	Advglowbutton::TShortCutHintPos FShortCutHintPos;
	System::UnicodeString FShortCutHintText;
	int FPreviewMenuOffSet;
	bool FInternalClick;
	bool FIsAeroVista;
	bool FRef;
	Advglowbutton::TAdvGlowButton* FRefGlowButton;
	Extctrls::TTimer* FShowMenuTimer;
	bool FCanShowMenu;
	bool FMenuBeingShown;
	bool FDoShowMenuHint;
	TAdvShapeButtonAppearance* FAppearance;
	TShapeButtonLayout FLayout;
	Advgdip::TAntiAlias FAntiAlias;
	Forms::TFrame* FFrame;
	bool FUseGlobalColor;
	void __fastcall OnShowMenuTime(System::TObject* Sender);
	void __fastcall UnHotTimerOnTime(System::TObject* Sender);
	void __fastcall UpdateExclusive(void);
	void __fastcall UpdateTracking(void);
	void __fastcall ButtonDown(void);
	void __fastcall InitializeFrame(void);
	void __fastcall ShowMenu(void);
	void __fastcall OnPictureChanged(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMSysColorChange(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall CMFocusChanged(Controls::TCMFocusChanged &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Message);
	MESSAGE void __fastcall CMButtonPressed(Messages::TMessage &Message);
	void __fastcall ShapePaint(System::TObject* Sender, Graphics::TCanvas* Canvas, const Types::TRect &R);
	void __fastcall OnPreviewMenuHide(System::TObject* Sender);
	void __fastcall SetDown(bool Value);
	void __fastcall SetAllowAllUp(bool Value);
	void __fastcall SetGroupIndex(int Value);
	void __fastcall SetStyle(const TAdvToolButtonStyle Value);
	void __fastcall SetState(const TAdvButtonState Value);
	void __fastcall SetGrouped(const bool Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	bool __fastcall GetHot(void);
	void __fastcall SetHot(const bool Value);
	void __fastcall SetOfficeHint(const Advhintinfo::TAdvHintInfo* Value);
	void __fastcall SetIPicture(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetIPictureDisabled(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetIPictureDown(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetIPictureHot(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetAdvPreviewMenu(const Advpreviewmenu::TAdvPreviewMenu* Value);
	void __fastcall SetAppearance(const TAdvShapeButtonAppearance* Value);
	void __fastcall SetLayout(const TShapeButtonLayout Value);
	void __fastcall SetAntiAlias(const Advgdip::TAntiAlias Value);
	void __fastcall SetFrame(const Forms::TFrame* Value);
	void __fastcall SetUseGlobalColor(const bool Value);
	void __fastcall HideMenuFrame(System::TObject* Sender);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	virtual void __fastcall SetParent(Controls::TWinControl* AParent);
	DYNAMIC Controls::TControlActionLinkClass __fastcall GetActionLinkClass(void);
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall DrawButton(Graphics::TCanvas* ACanvas);
	virtual void __fastcall DrawImage(Graphics::TCanvas* ACanvas);
	void __fastcall DrawShape(Graphics::TCanvas* ACanvas, const Types::TRect &R);
	void __fastcall ChangeStyle(bool AWin7, int AStyle);
	void __fastcall ChangeMenu(Graphics::TColor AColor);
	void __fastcall UpdateMenu(void);
	void __fastcall HideMenu(void);
	void __fastcall ShowMenuShortCuts(void);
	void __fastcall HideMenuShortCuts(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	DYNAMIC void __fastcall DblClick(void);
	void __fastcall SetAeroVista(bool Value);
	void __fastcall InvalidateMe(void);
	__property bool MouseInControl = {read=FMouseInControl, nodefault};
	__property TAdvButtonState State = {read=FState, write=SetState, nodefault};
	__property Action;
	__property bool AllowAllUp = {read=FAllowAllUp, write=SetAllowAllUp, default=0};
	__property Anchors = {default=3};
	__property Advgdip::TAntiAlias AntiAlias = {read=FAntiAlias, write=SetAntiAlias, default=1};
	__property BiDiMode;
	__property Constraints;
	__property bool Grouped = {read=FGrouped, write=SetGrouped, default=0};
	__property int GroupIndex = {read=FGroupIndex, write=SetGroupIndex, default=0};
	__property bool Down = {read=FDown, write=SetDown, default=0};
	__property Enabled = {default=1};
	__property Font;
	__property bool Hot = {read=GetHot, write=SetHot, default=0};
	__property TAdvShapeButtonAppearance* Appearance = {read=FAppearance, write=SetAppearance};
	__property TShapeButtonLayout Layout = {read=FLayout, write=SetLayout, default=0};
	__property Gdipicture::TGDIPPicture* Picture = {read=FIPicture, write=SetIPicture};
	__property Gdipicture::TGDIPPicture* PictureHot = {read=FIPictureHot, write=SetIPictureHot};
	__property Gdipicture::TGDIPPicture* PictureDown = {read=FIPictureDown, write=SetIPictureDown};
	__property Gdipicture::TGDIPPicture* PictureDisabled = {read=FIPictureDisabled, write=SetIPictureDisabled};
	__property Advpreviewmenu::TAdvPreviewMenu* AdvPreviewMenu = {read=FAdvPreviewMenu, write=SetAdvPreviewMenu};
	__property Forms::TFrame* Frame = {read=FFrame, write=SetFrame};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property ParentBiDiMode = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Advhintinfo::TAdvHintInfo* OfficeHint = {read=FOfficeHint, write=SetOfficeHint};
	__property TAdvToolButtonStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property System::UnicodeString ShortCutHint = {read=FShortCutHintText, write=FShortCutHintText};
	__property Advglowbutton::TShortCutHintPos ShortCutHintPos = {read=FShortCutHintPos, write=FShortCutHintPos, default=4};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	
public:
	__fastcall virtual TAdvCustomShapeButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvCustomShapeButton(void);
	DYNAMIC void __fastcall Click(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	virtual int __fastcall GetVersionNr(void);
	void __fastcall ShowShortCutHint(void);
	void __fastcall HideShortCutHint(void);
	void __fastcall InitializeStyle(void);
	void __fastcall InitializeColors(void);
	__property bool UseGlobalColor = {read=FUseGlobalColor, write=SetUseGlobalColor, default=0};
	void __fastcall HideFrame(void);
	int __fastcall GetFrameHeight(void);
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvCustomShapeButton(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
private:
	void *__IWinStyle;	/* Advgdip::IWinStyle */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Advgdip::_di_IWinStyle()
	{
		Advgdip::_di_IWinStyle intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IWinStyle*(void) { return (IWinStyle*)&__IWinStyle; }
	#endif
	
};


class DELPHICLASS TAdvShapeButton;
class PASCALIMPLEMENTATION TAdvShapeButton : public TAdvCustomShapeButton
{
	typedef TAdvCustomShapeButton inherited;
	
__published:
	__property Appearance;
	__property Action;
	__property AdvPreviewMenu;
	__property AllowAllUp = {default=0};
	__property AntiAlias = {default=1};
	__property Constraints;
	__property GroupIndex = {default=0};
	__property Down = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property Layout = {default=0};
	__property Picture;
	__property PictureHot;
	__property PictureDown;
	__property PictureDisabled;
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property ParentBiDiMode = {default=1};
	__property PopupMenu;
	__property OfficeHint;
	__property ShowHint;
	__property ShortCutHint;
	__property ShortCutHintPos = {default=4};
	__property TabStop = {default=0};
	__property TabOrder = {default=-1};
	__property Text;
	__property Style = {default=0};
	__property Version;
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property Frame;
public:
	/* TAdvCustomShapeButton.Create */ inline __fastcall virtual TAdvShapeButton(Classes::TComponent* AOwner) : TAdvCustomShapeButton(AOwner) { }
	/* TAdvCustomShapeButton.Destroy */ inline __fastcall virtual ~TAdvShapeButton(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvShapeButton(HWND ParentWindow) : TAdvCustomShapeButton(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x5;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Advshapebutton */
using namespace Advshapebutton;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvshapebuttonHPP
