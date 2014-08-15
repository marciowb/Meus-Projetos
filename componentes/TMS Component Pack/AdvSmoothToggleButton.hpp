// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsmoothtogglebutton.pas' rev: 21.00

#ifndef AdvsmoothtogglebuttonHPP
#define AdvsmoothtogglebuttonHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Actnlist.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsmoothtogglebutton
{
//-- type declarations -------------------------------------------------------
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


class DELPHICLASS TAdvSmoothToggleButtonActionLink;
class DELPHICLASS TAdvSmoothToggleButton;
class PASCALIMPLEMENTATION TAdvSmoothToggleButtonActionLink : public Controls::TControlActionLink
{
	typedef Controls::TControlActionLink inherited;
	
protected:
	TAdvSmoothToggleButton* FClient;
	virtual void __fastcall AssignClient(System::TObject* AClient);
	virtual bool __fastcall IsGroupIndexLinked(void);
	virtual void __fastcall SetGroupIndex(int Value);
public:
	/* TBasicActionLink.Create */ inline __fastcall virtual TAdvSmoothToggleButtonActionLink(System::TObject* AClient) : Controls::TControlActionLink(AClient) { }
	/* TBasicActionLink.Destroy */ inline __fastcall virtual ~TAdvSmoothToggleButtonActionLink(void) { }
	
};


class DELPHICLASS TAdvSmoothToggleButtonDropDownWindow;
class PASCALIMPLEMENTATION TAdvSmoothToggleButtonDropDownWindow : public Controls::THintWindow
{
	typedef Controls::THintWindow inherited;
	
private:
	Controls::TWinControl* FControl;
	bool FHideOnDeActivate;
	MESSAGE void __fastcall WMNCButtonDown(Messages::TMessage &Message);
	MESSAGE void __fastcall WMActivate(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Message);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	__property bool HideOnDeActivate = {read=FHideOnDeActivate, write=FHideOnDeActivate, nodefault};
	
public:
	__fastcall virtual TAdvSmoothToggleButtonDropDownWindow(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSmoothToggleButtonDropDownWindow(void);
	
__published:
	__property BorderWidth = {default=0};
	__property Controls::TWinControl* Control = {read=FControl, write=FControl};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothToggleButtonDropDownWindow(HWND ParentWindow) : Controls::THintWindow(ParentWindow) { }
	
};


class DELPHICLASS TAdvSmoothToggleButtonStatus;
class PASCALIMPLEMENTATION TAdvSmoothToggleButtonStatus : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothToggleButton* FOwner;
	int FOffsetTop;
	int FOffsetLeft;
	bool FVisible;
	System::UnicodeString FCaption;
	Gdipfill::TGDIPStatus* FAppearance;
	Classes::TNotifyEvent FOnChange;
	void __fastcall SetAppearance(const Gdipfill::TGDIPStatus* Value);
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetOffsetLeft(const int Value);
	void __fastcall SetOffsetTop(const int Value);
	void __fastcall SetVisible(const bool Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall AppearanceChanged(System::TObject* Sender);
	
public:
	__fastcall TAdvSmoothToggleButtonStatus(TAdvSmoothToggleButton* AOwner);
	__fastcall virtual ~TAdvSmoothToggleButtonStatus(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool Visible = {read=FVisible, write=SetVisible, default=0};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property int OffsetLeft = {read=FOffsetLeft, write=SetOffsetLeft, default=0};
	__property int OffsetTop = {read=FOffsetTop, write=SetOffsetTop, default=0};
	__property Gdipfill::TGDIPStatus* Appearance = {read=FAppearance, write=SetAppearance};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


#pragma option push -b-
enum TAdvSmoothToggleButtonState { bsDown, bsUp };
#pragma option pop

class PASCALIMPLEMENTATION TAdvSmoothToggleButton : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	bool FMouseDown;
	bool FMouseInside;
	bool FFocused;
	bool FDesignTime;
	bool FDroppedDown;
	TAdvSmoothToggleButtonState FState;
	Graphics::TColor FColor;
	Graphics::TColor FColorDown;
	Graphics::TColor FColorDisabled;
	Graphics::TColor FBorderColor;
	Advgdip::TAdvGDIPPicture* FPicture;
	Graphics::TColor FBevelColorDisabled;
	int FBevelWidth;
	Graphics::TColor FBevelColor;
	bool FDown;
	Advgdip::TAdvGDIPPicture* FPictureDown;
	bool FAutoToggle;
	bool FDropDownButton;
	Advgdip::TAdvGDIPPicture* FPictureDisabled;
	Gdipfill::TGDIPButton* FAppearance;
	Graphics::TColor FBevelColorDown;
	Graphics::TColor FBorderInnerColor;
	Menus::TPopupMenu* FDropDownMenu;
	Classes::TNotifyEvent FOnDropDown;
	Graphics::TColor FDropDownArrowColor;
	int FVerticalSpacing;
	int FHorizontalSpacing;
	TAdvSmoothToggleButtonStatus* FStatus;
	Controls::TWinControl* FDropDownControl;
	TAdvSmoothToggleButtonDropDownWindow* FDropDownForm;
	int FDropDownRounding;
	int FGroupIndex;
	bool FShowFocus;
	HIDESBASE void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorDown(const Graphics::TColor Value);
	void __fastcall SetColorDisabled(const Graphics::TColor Value);
	void __fastcall SetAutoToggle(const bool Value);
	void __fastcall SetBevelColor(const Graphics::TColor Value);
	void __fastcall SetBevelColorDisabled(const Graphics::TColor Value);
	void __fastcall SetBevelColorDown(const Graphics::TColor Value);
	HIDESBASE void __fastcall SetBevelWidth(const int Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetDown(const bool Value);
	void __fastcall SetDropDownButton(const bool Value);
	void __fastcall SetPicture(const Advgdip::TAdvGDIPPicture* Value);
	void __fastcall SetPictureDisabled(const Advgdip::TAdvGDIPPicture* Value);
	void __fastcall SetPictureDown(const Advgdip::TAdvGDIPPicture* Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetAppearance(const Gdipfill::TGDIPButton* Value);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetBorderInnerColor(const Graphics::TColor Value);
	void __fastcall SetDropDownArrowColor(const Graphics::TColor Value);
	void __fastcall SetHorizontalSpacing(const int Value);
	void __fastcall SetVerticalSpacing(const int Value);
	void __fastcall SetStatus(const TAdvSmoothToggleButtonStatus* Value);
	bool __fastcall GetDropDown(void);
	void __fastcall SetDropDown(const bool Value);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	MESSAGE void __fastcall CMCancelMode(Messages::TMessage &Message);
	MESSAGE void __fastcall CMButtonPressed(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMParentFontChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	void __fastcall SetDropDownControl(const Controls::TWinControl* Value);
	void __fastcall SetDropDownRounding(const int Value);
	void __fastcall SetGroupIndex(const int Value);
	void __fastcall SetShowFocus(const bool Value);
	
protected:
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	HIDESBASE void __fastcall Changed(void);
	void __fastcall PictureChanged(System::TObject* Sender);
	void __fastcall AppearanceChanged(System::TObject* Sender);
	void __fastcall AppearanceFontChanged(System::TObject* Sender);
	void __fastcall AppearanceFontStored(System::TObject* Sender, bool &IsStored);
	void __fastcall StatusChanged(System::TObject* Sender);
	int __fastcall GetVersionNr(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	void __fastcall ShowDropDown(void);
	void __fastcall HideDropDown(void);
	Types::TRect __fastcall GetButtonRect(void);
	virtual void __fastcall DoClick(void);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC Controls::TControlActionLinkClass __fastcall GetActionLinkClass(void);
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	
public:
	__fastcall virtual TAdvSmoothToggleButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSmoothToggleButton(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall Resize(void);
	__property bool DroppedDown = {read=GetDropDown, write=SetDropDown, nodefault};
	__property int DropDownRounding = {read=FDropDownRounding, write=SetDropDownRounding, default=0};
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	void __fastcall SaveToTheme(System::UnicodeString FileName);
	void __fastcall LoadFromTheme(System::UnicodeString FileName);
	System::UnicodeString __fastcall GetThemeID(void);
	DYNAMIC void __fastcall Click(void);
	
__published:
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=12632256};
	__property Graphics::TColor ColorDisabled = {read=FColorDisabled, write=SetColorDisabled, default=8421504};
	__property Graphics::TColor ColorDown = {read=FColorDown, write=SetColorDown, default=536870911};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=12632256};
	__property Graphics::TColor BorderInnerColor = {read=FBorderInnerColor, write=SetBorderInnerColor, default=12632256};
	__property int BevelWidth = {read=FBevelWidth, write=SetBevelWidth, default=6};
	__property Graphics::TColor BevelColor = {read=FBevelColor, write=SetBevelColor, default=16777215};
	__property Graphics::TColor BevelColorDisabled = {read=FBevelColorDisabled, write=SetBevelColorDisabled, default=8421504};
	__property Graphics::TColor BevelColorDown = {read=FBevelColorDown, write=SetBevelColorDown, default=16777215};
	__property bool DropDownButton = {read=FDropDownButton, write=SetDropDownButton, default=0};
	__property Graphics::TColor DropDownArrowColor = {read=FDropDownArrowColor, write=SetDropDownArrowColor, default=0};
	__property Menus::TPopupMenu* DropDownMenu = {read=FDropDownMenu, write=FDropDownMenu};
	__property Controls::TWinControl* DropDownControl = {read=FDropDownControl, write=SetDropDownControl};
	__property Classes::TNotifyEvent OnDropDown = {read=FOnDropDown, write=FOnDropDown};
	__property bool Down = {read=FDown, write=SetDown, default=0};
	__property bool AutoToggle = {read=FAutoToggle, write=SetAutoToggle, default=1};
	__property Advgdip::TAdvGDIPPicture* Picture = {read=FPicture, write=SetPicture};
	__property Advgdip::TAdvGDIPPicture* PictureDisabled = {read=FPictureDisabled, write=SetPictureDisabled};
	__property Advgdip::TAdvGDIPPicture* PictureDown = {read=FPictureDown, write=SetPictureDown};
	__property Enabled = {default=1};
	__property Gdipfill::TGDIPButton* Appearance = {read=FAppearance, write=SetAppearance};
	__property int VerticalSpacing = {read=FVerticalSpacing, write=SetVerticalSpacing, default=5};
	__property int HorizontalSpacing = {read=FHorizontalSpacing, write=SetHorizontalSpacing, default=5};
	__property Caption;
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property TAdvSmoothToggleButtonStatus* Status = {read=FStatus, write=SetStatus};
	__property int GroupIndex = {read=FGroupIndex, write=SetGroupIndex, default=0};
	__property bool ShowFocus = {read=FShowFocus, write=SetShowFocus, default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property Action;
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property OnMouseDown;
	__property OnMouseUp;
	__property OnMouseMove;
	__property OnDblClick;
	__property OnContextPopup;
	__property OnClick;
	__property OnMouseActivate;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnExit;
	__property OnEnter;
	__property OnKeyDown;
	__property OnKeyUp;
	__property OnKeyPress;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothToggleButton(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
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


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x1;
static const ShortInt REL_VER = 0x8;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Advsmoothtogglebutton */
using namespace Advsmoothtogglebutton;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsmoothtogglebuttonHPP
