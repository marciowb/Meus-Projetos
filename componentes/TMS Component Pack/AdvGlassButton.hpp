// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advglassbutton.pas' rev: 21.00

#ifndef AdvglassbuttonHPP
#define AdvglassbuttonHPP

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
#include <Advglowbutton.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advglassbutton
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TAdvToolButtonStyle { tasButton, tasCheck };
#pragma option pop

#pragma option push -b-
enum TBackGroundSymbol { bsArrowLeft, bsArrowRight, bsArrowUp, bsArrowDown, bsPlay, bsPause, bsStop, bsFastForward, bsForward, bsBackward, bsFastBackward, bsSpeaker, bsNoSpeaker, bsNone, bsRecord };
#pragma option pop

#pragma option push -b-
enum TButtonShape { btsRectangle, btsCurvedRectangle };
#pragma option pop

#pragma option push -b-
enum TButtonDirection { bdLeft, bdRight };
#pragma option pop

class DELPHICLASS TAdvGlassButtonActionLink;
class DELPHICLASS TAdvCustomGlassButton;
class PASCALIMPLEMENTATION TAdvGlassButtonActionLink : public Controls::TControlActionLink
{
	typedef Controls::TControlActionLink inherited;
	
protected:
	TAdvCustomGlassButton* FClient;
	virtual void __fastcall AssignClient(System::TObject* AClient);
	virtual bool __fastcall IsCheckedLinked(void);
	virtual bool __fastcall IsGroupIndexLinked(void);
	virtual void __fastcall SetGroupIndex(int Value);
	virtual void __fastcall SetChecked(bool Value);
public:
	/* TBasicActionLink.Create */ inline __fastcall virtual TAdvGlassButtonActionLink(System::TObject* AClient) : Controls::TControlActionLink(AClient) { }
	/* TBasicActionLink.Destroy */ inline __fastcall virtual ~TAdvGlassButtonActionLink(void) { }
	
};


class PASCALIMPLEMENTATION TAdvCustomGlassButton : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	int FGroupIndex;
	bool FDown;
	bool FAllowAllUp;
	int FOffSet;
	bool FMouseInControl;
	bool FHot;
	Classes::TNotifyEvent FOnMouseLeave;
	Classes::TNotifyEvent FOnMouseEnter;
	TAdvToolButtonStyle FStyle;
	Advglowbutton::TAdvButtonState FState;
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
	Advglowbutton::TShortCutHintWindow* FShortCutHint;
	Advglowbutton::TShortCutHintPos FShortCutHintPos;
	System::UnicodeString FShortCutHintText;
	Graphics::TColor FBackColor;
	Graphics::TColor FForeColor;
	Graphics::TColor FInnerBorderColor;
	Graphics::TColor FOuterBorderColor;
	Graphics::TColor FShineColor;
	Graphics::TColor FGlowColor;
	Advglowbutton::TButtonLayout FLayout;
	Advgdip::TAntiAlias FAntiAlias;
	bool FShowCaption;
	bool FShowFocusRect;
	bool FActive;
	int FCornerRadius;
	TBackGroundSymbol FBackGroundSymbol;
	Graphics::TColor FBackGroundSymbolColor;
	TButtonShape FButtonShape;
	TButtonDirection FButtonDirection;
	bool FForceTransparent;
	Graphics::TColor FBackgroundColor;
	void __fastcall UnHotTimerOnTime(System::TObject* Sender);
	void __fastcall UpdateExclusive(void);
	void __fastcall UpdateTracking(void);
	void __fastcall ButtonDown(void);
	void __fastcall OnPictureChanged(System::TObject* Sender);
	MESSAGE void __fastcall CNCommand(Messages::TWMCommand &Message);
	HIDESBASE MESSAGE void __fastcall CMFocusChanged(Controls::TCMFocusChanged &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogKey(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Message);
	MESSAGE void __fastcall WMSetText(Messages::TWMSetText &Message);
	HIDESBASE MESSAGE void __fastcall CMSysColorChange(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	MESSAGE void __fastcall CMButtonPressed(Messages::TMessage &Message);
	void __fastcall SetDown(bool Value);
	void __fastcall SetAllowAllUp(bool Value);
	void __fastcall SetGroupIndex(int Value);
	void __fastcall SetStyle(const TAdvToolButtonStyle Value);
	void __fastcall SetState(const Advglowbutton::TAdvButtonState Value);
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
	void __fastcall SetBackColor(const Graphics::TColor Value);
	void __fastcall SetForeColor(const Graphics::TColor Value);
	void __fastcall SetInnerBorderColor(const Graphics::TColor Value);
	void __fastcall SetOuterBorderColor(const Graphics::TColor Value);
	void __fastcall SetShineColor(const Graphics::TColor Value);
	void __fastcall SetGlowColor(const Graphics::TColor Value);
	void __fastcall SetLayout(const Advglowbutton::TButtonLayout Value);
	void __fastcall SetAntiAlias(const Advgdip::TAntiAlias Value);
	void __fastcall SetShowCaption(const bool Value);
	void __fastcall SetShowFocusRect(const bool Value);
	void __fastcall SetCornerRadius(int Value);
	void __fastcall SetBackGroundSymbol(const TBackGroundSymbol Value);
	void __fastcall SetBackGroundSymbolColor(const Graphics::TColor Value);
	void __fastcall SetButtonShape(const TButtonShape Value);
	void __fastcall SetButtonDirection(const TButtonDirection Value);
	void __fastcall SetForceTransparent(const bool Value);
	void __fastcall SetBackgroundColor(const Graphics::TColor Value);
	
protected:
	virtual void __fastcall SetParent(Controls::TWinControl* AParent);
	DYNAMIC Controls::TControlActionLinkClass __fastcall GetActionLinkClass(void);
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall DrawButton(Graphics::TCanvas* ACanvas);
	void __fastcall DrawButtonBackground(Advgdip::TGPGraphics* graphic);
	void __fastcall DrawTransparentBackGround(Graphics::TCanvas* Canvas);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall Paint(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	void __fastcall InvalidateMe(void);
	__property bool MouseInControl = {read=FMouseInControl, nodefault};
	__property Advglowbutton::TAdvButtonState State = {read=FState, write=SetState, nodefault};
	__property Action;
	__property bool AllowAllUp = {read=FAllowAllUp, write=SetAllowAllUp, default=0};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Advgdip::TAntiAlias AntiAlias = {read=FAntiAlias, write=SetAntiAlias, default=1};
	__property Graphics::TColor BackgroundColor = {read=FBackgroundColor, write=SetBackgroundColor, default=536870911};
	__property Graphics::TColor BackColor = {read=FBackColor, write=SetBackColor, nodefault};
	__property Graphics::TColor ForeColor = {read=FForeColor, write=SetForeColor, nodefault};
	__property Graphics::TColor InnerBorderColor = {read=FInnerBorderColor, write=SetInnerBorderColor, nodefault};
	__property Graphics::TColor OuterBorderColor = {read=FOuterBorderColor, write=SetOuterBorderColor, nodefault};
	__property Graphics::TColor ShineColor = {read=FShineColor, write=SetShineColor, nodefault};
	__property Graphics::TColor GlowColor = {read=FGlowColor, write=SetGlowColor, nodefault};
	__property Advglowbutton::TButtonLayout Layout = {read=FLayout, write=SetLayout, default=0};
	__property bool ShowCaption = {read=FShowCaption, write=SetShowCaption, default=1};
	__property bool ShowFocusRect = {read=FShowFocusRect, write=SetShowFocusRect, default=0};
	__property int CornerRadius = {read=FCornerRadius, write=SetCornerRadius, default=4};
	__property TBackGroundSymbol BackGroundSymbol = {read=FBackGroundSymbol, write=SetBackGroundSymbol, default=13};
	__property Graphics::TColor BackGroundSymbolColor = {read=FBackGroundSymbolColor, write=SetBackGroundSymbolColor, default=16777215};
	__property TButtonShape ButtonShape = {read=FButtonShape, write=SetButtonShape, default=0};
	__property TButtonDirection ButtonDirection = {read=FButtonDirection, write=SetButtonDirection, default=1};
	__property bool ForceTransparent = {read=FForceTransparent, write=SetForceTransparent, default=0};
	__property Constraints;
	__property bool Grouped = {read=FGrouped, write=SetGrouped, default=0};
	__property int GroupIndex = {read=FGroupIndex, write=SetGroupIndex, default=0};
	__property bool Down = {read=FDown, write=SetDown, default=0};
	__property Enabled = {default=1};
	__property Font;
	__property bool Hot = {read=GetHot, write=SetHot, default=0};
	__property Gdipicture::TGDIPPicture* Picture = {read=FIPicture, write=SetIPicture};
	__property Gdipicture::TGDIPPicture* PictureHot = {read=FIPictureHot, write=SetIPictureHot};
	__property Gdipicture::TGDIPPicture* PictureDown = {read=FIPictureDown, write=SetIPictureDown};
	__property Gdipicture::TGDIPPicture* PictureDisabled = {read=FIPictureDisabled, write=SetIPictureDisabled};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property ParentBiDiMode = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Advhintinfo::TAdvHintInfo* OfficeHint = {read=FOfficeHint, write=SetOfficeHint};
	__property TAdvToolButtonStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property System::UnicodeString ShortCutHint = {read=FShortCutHintText, write=FShortCutHintText};
	__property Advglowbutton::TShortCutHintPos ShortCutHintPos = {read=FShortCutHintPos, write=FShortCutHintPos, default=1};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnKeyDown;
	__property OnKeyUp;
	__property OnKeyPress;
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	
public:
	__fastcall virtual TAdvCustomGlassButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvCustomGlassButton(void);
	DYNAMIC void __fastcall Click(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	virtual int __fastcall GetVersionNr(void);
	void __fastcall ShowShortCutHint(void);
	void __fastcall HideShortCutHint(void);
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvCustomGlassButton(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


class DELPHICLASS TAdvGlassButton;
class PASCALIMPLEMENTATION TAdvGlassButton : public TAdvCustomGlassButton
{
	typedef TAdvCustomGlassButton inherited;
	
public:
	__property BackgroundColor = {default=536870911};
	
__published:
	__property Action;
	__property AllowAllUp = {default=0};
	__property Anchors = {default=3};
	__property AntiAlias = {default=1};
	__property BackColor;
	__property BackGroundSymbol = {default=13};
	__property BackGroundSymbolColor = {default=16777215};
	__property ButtonDirection = {default=1};
	__property ButtonShape = {default=0};
	__property Caption;
	__property Constraints;
	__property CornerRadius = {default=4};
	__property Down = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ForeColor;
	__property ForceTransparent = {default=0};
	__property GlowColor;
	__property GroupIndex = {default=0};
	__property InnerBorderColor;
	__property Layout = {default=0};
	__property OfficeHint;
	__property OuterBorderColor;
	__property Picture;
	__property PictureDown;
	__property PictureDisabled;
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property ParentBiDiMode = {default=1};
	__property PopupMenu;
	__property ShineColor;
	__property ShortCutHint;
	__property ShortCutHintPos = {default=1};
	__property ShowCaption = {default=1};
	__property ShowFocusRect = {default=0};
	__property ShowHint;
	__property Style = {default=0};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Version;
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMouseEnter;
	__property OnMouseLeave;
public:
	/* TAdvCustomGlassButton.Create */ inline __fastcall virtual TAdvGlassButton(Classes::TComponent* AOwner) : TAdvCustomGlassButton(AOwner) { }
	/* TAdvCustomGlassButton.Destroy */ inline __fastcall virtual ~TAdvGlassButton(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvGlassButton(HWND ParentWindow) : TAdvCustomGlassButton(ParentWindow) { }
	
};


class DELPHICLASS TProWinCtrl;
class PASCALIMPLEMENTATION TProWinCtrl : public Controls::TWinControl
{
	typedef Controls::TWinControl inherited;
	
public:
	/* TWinControl.Create */ inline __fastcall virtual TProWinCtrl(Classes::TComponent* AOwner) : Controls::TWinControl(AOwner) { }
	/* TWinControl.CreateParented */ inline __fastcall TProWinCtrl(HWND ParentWindow) : Controls::TWinControl(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TProWinCtrl(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x2;
static const ShortInt REL_VER = 0x3;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Advglassbutton */
using namespace Advglassbutton;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvglassbuttonHPP
