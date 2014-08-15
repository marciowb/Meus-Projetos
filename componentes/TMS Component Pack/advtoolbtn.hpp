// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advtoolbtn.pas' rev: 21.00

#ifndef AdvtoolbtnHPP
#define AdvtoolbtnHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Actnlist.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advtoolbtn
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TAdvToolButtonStyle { tasButton, tasCheck };
#pragma option pop

class DELPHICLASS TAdvToolButtonActionLink;
class DELPHICLASS TAdvToolButton;
class PASCALIMPLEMENTATION TAdvToolButtonActionLink : public Controls::TControlActionLink
{
	typedef Controls::TControlActionLink inherited;
	
protected:
	TAdvToolButton* FClient;
	virtual void __fastcall AssignClient(System::TObject* AClient);
	virtual bool __fastcall IsCaptionLinked(void);
	virtual bool __fastcall IsCheckedLinked(void);
	virtual bool __fastcall IsGroupIndexLinked(void);
	virtual void __fastcall SetGroupIndex(int Value);
	virtual void __fastcall SetChecked(bool Value);
	virtual void __fastcall SetCaption(const System::UnicodeString Value);
public:
	/* TBasicActionLink.Create */ inline __fastcall virtual TAdvToolButtonActionLink(System::TObject* AClient) : Controls::TControlActionLink(AClient) { }
	/* TBasicActionLink.Destroy */ inline __fastcall virtual ~TAdvToolButtonActionLink(void) { }
	
};


class PASCALIMPLEMENTATION TAdvToolButton : public Controls::TGraphicControl
{
	typedef Controls::TGraphicControl inherited;
	
private:
	int FGroupIndex;
	Graphics::TBitmap* FGlyph;
	bool FDown;
	bool FDragging;
	bool FAllowAllUp;
	Buttons::TButtonLayout FLayout;
	int FSpacing;
	bool FTransparent;
	int FMargin;
	bool FFlat;
	bool FMouseInControl;
	Graphics::TColor FColorTo;
	Graphics::TColor FColorHot;
	Graphics::TColor FColorHotTo;
	Graphics::TColor FColorDown;
	Graphics::TColor FColorDownTo;
	Graphics::TColor FBorderColor;
	Graphics::TColor FBorderDownColor;
	Graphics::TColor FBorderHotColor;
	Graphics::TBitmap* FGlyphDisabled;
	Graphics::TBitmap* FGlyphHot;
	Graphics::TBitmap* FGlyphDown;
	Graphics::TBitmap* FGlyphShade;
	bool FShaded;
	Classes::TNotifyEvent FOnMouseLeave;
	Classes::TNotifyEvent FOnMouseEnter;
	Graphics::TColor FColorChecked;
	Graphics::TColor FColorCheckedTo;
	TAdvToolButtonStyle FStyle;
	int FLook;
	bool FRounded;
	bool FDropDownButton;
	bool FDropDownSplit;
	bool FAutoThemeAdapt;
	Classes::TNotifyEvent FOnDropDown;
	Menus::TPopupMenu* FDropDownMenu;
	bool FShowCaption;
	Imglist::TCustomImageList* FImages;
	int FImageIndex;
	void __fastcall GlyphChanged(System::TObject* Sender);
	void __fastcall UpdateExclusive(void);
	void __fastcall SetGlyph(Graphics::TBitmap* Value);
	void __fastcall SetDown(bool Value);
	void __fastcall SetFlat(bool Value);
	void __fastcall SetAllowAllUp(bool Value);
	void __fastcall SetGroupIndex(int Value);
	void __fastcall SetLayout(Buttons::TButtonLayout Value);
	void __fastcall SetSpacing(int Value);
	void __fastcall SetMargin(int Value);
	void __fastcall UpdateTracking(void);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	MESSAGE void __fastcall CMButtonPressed(Messages::TMessage &Message);
	MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Message);
	MESSAGE void __fastcall CMSysColorChange(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	void __fastcall SetGlyphDisabled(const Graphics::TBitmap* Value);
	void __fastcall SetGlyphDown(const Graphics::TBitmap* Value);
	void __fastcall SetGlyphHot(const Graphics::TBitmap* Value);
	void __fastcall GenerateShade(void);
	void __fastcall SetShaded(const bool Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetColorChecked(const Graphics::TColor Value);
	void __fastcall SetColorCheckedTo(const Graphics::TColor Value);
	void __fastcall SetStyle(const TAdvToolButtonStyle Value);
	void __fastcall SetRounded(const bool Value);
	void __fastcall SetDropDownButton(const bool Value);
	void __fastcall SetShowCaption(const bool Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetLook(const int Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	Graphics::TColor __fastcall GetColor(void);
	HIDESBASE void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetImageList(const Imglist::TCustomImageList* Value);
	void __fastcall SetImageIndex(const int Value);
	
protected:
	Buttons::TButtonState FState;
	DYNAMIC Controls::TControlActionLinkClass __fastcall GetActionLinkClass(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall DrawButtonGlyph(Graphics::TCanvas* Canvas, const Types::TPoint &GlyphPos, Buttons::TButtonState State, bool Transparent);
	void __fastcall DrawButtonText(Graphics::TCanvas* Canvas, const System::UnicodeString Caption, const Types::TRect &TextBounds, Buttons::TButtonState State, int BiDiFlags);
	Types::TRect __fastcall DrawButton(Graphics::TCanvas* Canvas, const Types::TRect &Client, const Types::TPoint &Offset, const System::UnicodeString Caption, Buttons::TButtonLayout Layout, int Margin, int Spacing, Buttons::TButtonState State, bool Transparent, int BiDiFlags);
	void __fastcall CalcButtonLayout(Graphics::TCanvas* Canvas, const Types::TRect &Client, const Types::TPoint &Offset, const System::UnicodeString Caption, Buttons::TButtonLayout Layout, int Margin, int Spacing, Types::TPoint &GlyphPos, Types::TRect &TextBounds, int BiDiFlags);
	virtual void __fastcall Paint(void);
	__property bool MouseInControl = {read=FMouseInControl, nodefault};
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	void __fastcall ThemeAdapt(void);
	void __fastcall SetAutoThemeAdapt(const bool Value);
	
public:
	__fastcall virtual TAdvToolButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvToolButton(void);
	DYNAMIC void __fastcall Click(void);
	__property int Look = {read=FLook, write=SetLook, nodefault};
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	void __fastcall ShowDropDownMenu(void);
	
__published:
	__property Action;
	__property Align = {default=0};
	__property bool AllowAllUp = {read=FAllowAllUp, write=SetAllowAllUp, default=0};
	__property Anchors = {default=3};
	__property bool AutoThemeAdapt = {read=FAutoThemeAdapt, write=SetAutoThemeAdapt, nodefault};
	__property BiDiMode;
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=536870911};
	__property Graphics::TColor BorderDownColor = {read=FBorderDownColor, write=FBorderDownColor, default=536870911};
	__property Graphics::TColor BorderHotColor = {read=FBorderHotColor, write=FBorderHotColor, default=536870911};
	__property Graphics::TColor Color = {read=GetColor, write=SetColor, default=-16777201};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, default=536870911};
	__property Graphics::TColor ColorDown = {read=FColorDown, write=FColorDown, nodefault};
	__property Graphics::TColor ColorDownTo = {read=FColorDownTo, write=FColorDownTo, default=536870911};
	__property Graphics::TColor ColorHot = {read=FColorHot, write=FColorHot, nodefault};
	__property Graphics::TColor ColorHotTo = {read=FColorHotTo, write=FColorHotTo, default=536870911};
	__property Graphics::TColor ColorChecked = {read=FColorChecked, write=SetColorChecked, default=8421504};
	__property Graphics::TColor ColorCheckedTo = {read=FColorCheckedTo, write=SetColorCheckedTo, default=536870911};
	__property Constraints;
	__property int GroupIndex = {read=FGroupIndex, write=SetGroupIndex, default=0};
	__property bool Down = {read=FDown, write=SetDown, default=0};
	__property bool DropDownButton = {read=FDropDownButton, write=SetDropDownButton, default=0};
	__property Menus::TPopupMenu* DropDownMenu = {read=FDropDownMenu, write=FDropDownMenu};
	__property bool DropDownSplit = {read=FDropDownSplit, write=FDropDownSplit, default=1};
	__property Caption;
	__property Enabled = {default=1};
	__property bool Flat = {read=FFlat, write=SetFlat, default=1};
	__property Font;
	__property Graphics::TBitmap* Glyph = {read=FGlyph, write=SetGlyph};
	__property Graphics::TBitmap* GlyphHot = {read=FGlyphHot, write=SetGlyphHot};
	__property Graphics::TBitmap* GlyphDown = {read=FGlyphDown, write=SetGlyphDown};
	__property Graphics::TBitmap* GlyphDisabled = {read=FGlyphDisabled, write=SetGlyphDisabled};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=SetImageList};
	__property Buttons::TButtonLayout Layout = {read=FLayout, write=SetLayout, default=0};
	__property int Margin = {read=FMargin, write=SetMargin, default=-1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property ParentBiDiMode = {default=1};
	__property PopupMenu;
	__property bool Rounded = {read=FRounded, write=SetRounded, default=0};
	__property bool Shaded = {read=FShaded, write=SetShaded, default=1};
	__property bool ShowCaption = {read=FShowCaption, write=SetShowCaption, default=1};
	__property ShowHint;
	__property int Spacing = {read=FSpacing, write=SetSpacing, default=4};
	__property TAdvToolButtonStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property Classes::TNotifyEvent OnDropDown = {read=FOnDropDown, write=FOnDropDown};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
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


class DELPHICLASS TAdvRepeatButton;
class PASCALIMPLEMENTATION TAdvRepeatButton : public TAdvToolButton
{
	typedef TAdvToolButton inherited;
	
private:
	Extctrls::TTimer* FRepeatTimer;
	int FInitRepeatPause;
	int FRepeatPause;
	void __fastcall TimerExpired(System::TObject* Sender);
	
protected:
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	
public:
	__fastcall virtual TAdvRepeatButton(Classes::TComponent* AOwner);
	
__published:
	__property int InitRepeatPause = {read=FInitRepeatPause, write=FInitRepeatPause, default=400};
	__property int RepeatPause = {read=FRepeatPause, write=FRepeatPause, default=100};
public:
	/* TAdvToolButton.Destroy */ inline __fastcall virtual ~TAdvRepeatButton(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x6;
static const ShortInt REL_VER = 0x1;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Advtoolbtn */
using namespace Advtoolbtn;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvtoolbtnHPP
