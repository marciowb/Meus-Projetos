// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advfontcombo.pas' rev: 21.00

#ifndef AdvfontcomboHPP
#define AdvfontcomboHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advfontcombo
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TAdvFontType { aftBitmap, aftTrueType, aftPostScript, aftPrinter, aftFixedPitch, aftProportional };
#pragma option pop

typedef Set<TAdvFontType, aftBitmap, aftProportional>  TAdvFontTypes;

class DELPHICLASS TWinCtrl;
class PASCALIMPLEMENTATION TWinCtrl : public Controls::TWinControl
{
	typedef Controls::TWinControl inherited;
	
public:
	/* TWinControl.Create */ inline __fastcall virtual TWinCtrl(Classes::TComponent* AOwner) : Controls::TWinControl(AOwner) { }
	/* TWinControl.CreateParented */ inline __fastcall TWinCtrl(HWND ParentWindow) : Controls::TWinControl(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TWinCtrl(void) { }
	
};


class DELPHICLASS TDropDownWindow;
class PASCALIMPLEMENTATION TDropDownWindow : public Controls::THintWindow
{
	typedef Controls::THintWindow inherited;
	
private:
	Stdctrls::TListBox* FListControl;
	bool FHideOnDeActivate;
	MESSAGE void __fastcall WMNCButtonDown(Messages::TMessage &Message);
	MESSAGE void __fastcall WMActivate(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Message);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	__property bool HideOnDeActivate = {read=FHideOnDeActivate, write=FHideOnDeActivate, nodefault};
	
public:
	__fastcall virtual TDropDownWindow(Classes::TComponent* AOwner);
	__fastcall virtual ~TDropDownWindow(void);
	
__published:
	__property BorderWidth = {default=0};
	__property Stdctrls::TListBox* ListControl = {read=FListControl, write=FListControl};
public:
	/* TWinControl.CreateParented */ inline __fastcall TDropDownWindow(HWND ParentWindow) : Controls::THintWindow(ParentWindow) { }
	
};


class DELPHICLASS TAdvComboBtn;
class DELPHICLASS TAdvCustomComboBox;
class PASCALIMPLEMENTATION TAdvComboBtn : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TNotifyEvent FOnChange;
	int FWidth;
	Graphics::TBitmap* FGlyph;
	Graphics::TBitmap* FGlyphDown;
	Graphics::TBitmap* FGlyphHot;
	Graphics::TColor FColorHot;
	Graphics::TColor FColorTo;
	Graphics::TColor FColorDownTo;
	Graphics::TColor FColorDown;
	Graphics::TColor FColorHotTo;
	Graphics::TColor FColor;
	Graphics::TColor FDownArrowColor;
	Graphics::TColor FHotArrowColor;
	Graphics::TColor FArrowColor;
	TAdvCustomComboBox* FCombo;
	bool FDownArrow;
	void __fastcall SetWidth(const int Value);
	void __fastcall Change(void);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetColorDown(const Graphics::TColor Value);
	void __fastcall SetColorDownTo(const Graphics::TColor Value);
	void __fastcall SetGlyphDown(const Graphics::TBitmap* Value);
	void __fastcall SetGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetColorHot(const Graphics::TColor Value);
	void __fastcall SetColorHotTo(const Graphics::TColor Value);
	void __fastcall SetGlyphHot(const Graphics::TBitmap* Value);
	void __fastcall SetArrowColor(const Graphics::TColor Value);
	void __fastcall SetDownArrowColor(const Graphics::TColor Value);
	void __fastcall SetHotArrowColor(const Graphics::TColor Value);
	
protected:
	__property Graphics::TColor ArrowColor = {read=FArrowColor, write=SetArrowColor, nodefault};
	__property Graphics::TColor HotArrowColor = {read=FHotArrowColor, write=SetHotArrowColor, nodefault};
	__property Graphics::TColor DownArrowColor = {read=FDownArrowColor, write=SetDownArrowColor, nodefault};
	__property bool DownArrow = {read=FDownArrow, write=FDownArrow, nodefault};
	__property TAdvCustomComboBox* Combo = {read=FCombo, write=FCombo};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
public:
	__fastcall TAdvComboBtn(void);
	__fastcall virtual ~TAdvComboBtn(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, nodefault};
	__property Graphics::TColor ColorHot = {read=FColorHot, write=SetColorHot, nodefault};
	__property Graphics::TColor ColorHotTo = {read=FColorHotTo, write=SetColorHotTo, nodefault};
	__property Graphics::TColor ColorDown = {read=FColorDown, write=SetColorDown, nodefault};
	__property Graphics::TColor ColorDownTo = {read=FColorDownTo, write=SetColorDownTo, nodefault};
	__property Graphics::TBitmap* Glyph = {read=FGlyph, write=SetGlyph};
	__property Graphics::TBitmap* GlyphHot = {read=FGlyphHot, write=SetGlyphHot};
	__property Graphics::TBitmap* GlyphDown = {read=FGlyphDown, write=SetGlyphDown};
	__property int Width = {read=FWidth, write=SetWidth, nodefault};
};


#pragma option push -b-
enum TAdvComboStyle { esOffice2003Blue, esOffice2003Silver, esOffice2003Olive, esOffice2003Classic, esOffice2007Luna, esOffice2007Obsidian, esWindowsXP, esWhidbey, esCustom, esOffice2007Silver, esWindowsVista, esWindows7, esTerminal, esOffice2010Blue, esOffice2010Silver, esOffice2010Black };
#pragma option pop

#pragma option push -b-
enum TComboStyle { csDropDown, csDropDownList };
#pragma option pop

#pragma option push -b-
enum TSelectionGradient { sgVertical, sgHorizontal, sgVerticalInOut, sgHorizontalInOut };
#pragma option pop

class PASCALIMPLEMENTATION TAdvCustomComboBox : public Stdctrls::TCustomEdit
{
	typedef Stdctrls::TCustomEdit inherited;
	
private:
	bool FAutoFocus;
	bool FMouseInControl;
	Classes::TNotifyEvent FOnMouseEnter;
	bool FButtonDown;
	bool FDroppedDown;
	Classes::TNotifyEvent FOnMouseLeave;
	TAdvComboBtn* FButton;
	bool FFlat;
	Graphics::TColor FBorderHotColor;
	Graphics::TColor FBorderColor;
	bool FAutoThemeAdapt;
	TAdvComboStyle FAppearanceStyle;
	Controls::TCursor FOldCursor;
	TDropDownWindow* FDropDownList;
	Stdctrls::TListBox* FDropDownListBox;
	Classes::TStringList* FItems;
	int FDropDownCount;
	Classes::TNotifyEvent FOnBeforeDropDown;
	int FItemIndex;
	Graphics::TColor FSelectionColor;
	int FFontHeight;
	int FItemHeight;
	bool FLookUp;
	bool FChanged;
	bool FMatchCase;
	bool FWorkMode;
	System::UnicodeString FOldText;
	Graphics::TColor FSelectionColorTo;
	TSelectionGradient FSelectionGradient;
	bool FDisplayRecentSelection;
	Classes::TStringList* FRecentSelection;
	TComboStyle FStyle;
	bool FAutoItemSize;
	bool FInternalChange;
	bool FInternalSelect;
	Graphics::TColor FSelectionTextColor;
	Classes::TNotifyEvent FOnSelect;
	Classes::TNotifyEvent FOnDropDown;
	Classes::TNotifyEvent FOnCloseUp;
	MESSAGE void __fastcall CNCtlColorEdit(Messages::TWMCtlColor &Message);
	MESSAGE void __fastcall CNCtlColorStatic(Messages::TWMCtlColor &Message);
	MESSAGE void __fastcall CMCancelMode(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMChildKey(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMChar(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Msg);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	void __fastcall DrawButton(HDC DC)/* overload */;
	void __fastcall DrawButton(void)/* overload */;
	void __fastcall DrawBorders(HDC DC)/* overload */;
	void __fastcall DrawBorders(void)/* overload */;
	Types::TRect __fastcall GetButtonRect(void);
	int __fastcall GetMinHeight(void);
	int __fastcall GetListItemHeight(void);
	void __fastcall ResizeControl(void);
	void __fastcall ButtonOnChange(System::TObject* Sender);
	void __fastcall ButtonClick(void);
	void __fastcall ListBoxKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall ListBoxMouseUp(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall ListBoxMouseMove(System::TObject* Sender, Classes::TShiftState Shift, int X, int Y);
	void __fastcall ListBoxKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall ListBoxOnEnter(System::TObject* Sender);
	void __fastcall ListBoxChange(System::TObject* Sender);
	void __fastcall LookUpText(void);
	void __fastcall ThemeAdapt(void);
	virtual int __fastcall GetVersionNr(void);
	void __fastcall SetButton(const TAdvComboBtn* Value);
	void __fastcall SetFlat(const bool Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetBorderHotColor(const Graphics::TColor Value);
	void __fastcall SetAppearanceStyle(const TAdvComboStyle Value);
	void __fastcall SetItems(const Classes::TStringList* Value);
	void __fastcall SetItemIndex(const int Value);
	void __fastcall SetSelectionColor(const Graphics::TColor Value);
	void __fastcall SetFontHeight(const int Value);
	void __fastcall SetLookUp(const bool Value);
	int __fastcall GetItemIndex(void);
	void __fastcall SetSelectionColorTo(const Graphics::TColor Value);
	void __fastcall SetSelectionGradient(const TSelectionGradient Value);
	void __fastcall SetDisplayRecentSelection(const bool Value);
	int __fastcall GetItemHeight(void);
	void __fastcall SetItemHeight(const int Value);
	void __fastcall SetStyle(const TComboStyle Value);
	void __fastcall SetAutoItemSize(const bool Value);
	void __fastcall SetTextEx(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetTextEx(void);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	bool __fastcall GetDropDown(void);
	void __fastcall SetDropDown(const bool Value);
	void __fastcall ItemsChanged(System::TObject* Sender);
	
protected:
	void __fastcall SetEditRect(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall DoEnter(void);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	void __fastcall First(void);
	void __fastcall Previous(void);
	void __fastcall Next(void);
	void __fastcall Last(void);
	void __fastcall PageJump(bool GoForward);
	virtual void __fastcall BeforeDropDown(void);
	virtual void __fastcall DoDropDown(void);
	virtual void __fastcall DoCloseUp(void);
	virtual void __fastcall DoSelect(void);
	virtual void __fastcall DropDownOnDrawItem(Controls::TWinControl* Control, int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	virtual void __fastcall ValueChanged(void);
	virtual void __fastcall UpdateIndex(void);
	virtual void __fastcall PopulateListBox(void);
	__property bool Flat = {read=FFlat, write=SetFlat, nodefault};
	__property bool AutoItemSize = {read=FAutoItemSize, write=SetAutoItemSize, default=1};
	__property int ItemHeight = {read=GetItemHeight, write=SetItemHeight, nodefault};
	__property int FontHeight = {read=FFontHeight, write=SetFontHeight, nodefault};
	__property TComboStyle Style = {read=FStyle, write=SetStyle, default=0};
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	
public:
	__fastcall virtual TAdvCustomComboBox(Classes::TComponent* aOwner);
	__fastcall virtual ~TAdvCustomComboBox(void);
	int __fastcall CharFromPos(const Types::TPoint &pt);
	DYNAMIC void __fastcall Change(void);
	void __fastcall ShowDropDown(void);
	void __fastcall HideDropDown(void);
	__property Classes::TStringList* Items = {read=FItems, write=SetItems};
	__property int ItemIndex = {read=GetItemIndex, write=SetItemIndex, nodefault};
	__property Classes::TStringList* RecentSelection = {read=FRecentSelection};
	__property TAdvComboStyle AppearanceStyle = {read=FAppearanceStyle, write=SetAppearanceStyle, nodefault};
	__property bool DroppedDown = {read=GetDropDown, write=SetDropDown, nodefault};
	
__published:
	__property Align = {default=0};
	__property bool AutoFocus = {read=FAutoFocus, write=FAutoFocus, default=0};
	__property bool AutoThemeAdapt = {read=FAutoThemeAdapt, write=FAutoThemeAdapt, default=0};
	__property TAdvComboBtn* Button = {read=FButton, write=SetButton};
	__property bool DisplayRecentSelection = {read=FDisplayRecentSelection, write=SetDisplayRecentSelection, default=1};
	__property int DropDownCount = {read=FDropDownCount, write=FDropDownCount, nodefault};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, nodefault};
	__property Graphics::TColor BorderHotColor = {read=FBorderHotColor, write=SetBorderHotColor, nodefault};
	__property bool LookUp = {read=FLookUp, write=SetLookUp, default=1};
	__property Graphics::TColor SelectionColor = {read=FSelectionColor, write=SetSelectionColor, nodefault};
	__property Graphics::TColor SelectionColorTo = {read=FSelectionColorTo, write=SetSelectionColorTo, default=536870911};
	__property Graphics::TColor SelectionTextColor = {read=FSelectionTextColor, write=FSelectionTextColor, default=-16777202};
	__property TSelectionGradient SelectionGradient = {read=FSelectionGradient, write=SetSelectionGradient, default=2};
	__property System::UnicodeString Text = {read=GetTextEx, write=SetTextEx};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property PopupMenu;
	__property OnExit;
	__property OnEnter;
	__property OnChange;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property Classes::TNotifyEvent OnDropDown = {read=FOnDropDown, write=FOnDropDown};
	__property Classes::TNotifyEvent OnCloseUp = {read=FOnCloseUp, write=FOnCloseUp};
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property Classes::TNotifyEvent OnBeforeDropDown = {read=FOnBeforeDropDown, write=FOnBeforeDropDown};
	__property Classes::TNotifyEvent OnSelect = {read=FOnSelect, write=FOnSelect};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvCustomComboBox(HWND ParentWindow) : Stdctrls::TCustomEdit(ParentWindow) { }
	
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


class DELPHICLASS TAdvOfficeComboBox;
class PASCALIMPLEMENTATION TAdvOfficeComboBox : public TAdvCustomComboBox
{
	typedef TAdvCustomComboBox inherited;
	
public:
	__fastcall virtual TAdvOfficeComboBox(Classes::TComponent* aOwner);
	
__published:
	__property Anchors = {default=3};
	__property Enabled = {default=1};
	__property Items;
	__property ItemIndex;
	__property ItemHeight;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Font;
	__property ShowHint;
	__property Style = {default=0};
	__property Visible = {default=1};
public:
	/* TAdvCustomComboBox.Destroy */ inline __fastcall virtual ~TAdvOfficeComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvOfficeComboBox(HWND ParentWindow) : TAdvCustomComboBox(ParentWindow) { }
	
};


class DELPHICLASS TAdvFontSelector;
class PASCALIMPLEMENTATION TAdvFontSelector : public TAdvCustomComboBox
{
	typedef TAdvCustomComboBox inherited;
	
private:
	Graphics::TBitmap* FFontGlyphTT;
	Graphics::TBitmap* FFontGlyphPS;
	Graphics::TBitmap* FFontGlyphPRN;
	Graphics::TBitmap* FFontGlyphBMP;
	bool FShowFontStyle;
	bool FShowFontGlyph;
	TAdvFontTypes FAllowedFontTypes;
	void __fastcall SetFontGlyphTT(const Graphics::TBitmap* Value);
	void __fastcall SetFontGlyphPS(const Graphics::TBitmap* Value);
	void __fastcall SetFontGlyphPRN(const Graphics::TBitmap* Value);
	void __fastcall SetFontGlyphBMP(const Graphics::TBitmap* Value);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Message);
	TAdvFontTypes __fastcall GetFontType(const System::UnicodeString Fontname);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall BeforeDropDown(void);
	virtual void __fastcall DropDownOnDrawItem(Controls::TWinControl* Control, int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	
public:
	__fastcall virtual TAdvFontSelector(Classes::TComponent* aOwner);
	virtual void __fastcall CreateWnd(void);
	__fastcall virtual ~TAdvFontSelector(void);
	void __fastcall LoadFontNames(void);
	
__published:
	__property TAdvFontTypes AllowedFontTypes = {read=FAllowedFontTypes, write=FAllowedFontTypes, nodefault};
	__property Graphics::TBitmap* FontGlyphTT = {read=FFontGlyphTT, write=SetFontGlyphTT};
	__property Graphics::TBitmap* FontGlyphPS = {read=FFontGlyphPS, write=SetFontGlyphPS};
	__property Graphics::TBitmap* FontGlyphPRN = {read=FFontGlyphPRN, write=SetFontGlyphPRN};
	__property Graphics::TBitmap* FontGlyphBMP = {read=FFontGlyphBMP, write=SetFontGlyphBMP};
	__property bool ShowFontStyle = {read=FShowFontStyle, write=FShowFontStyle, default=1};
	__property bool ShowFontGlyph = {read=FShowFontGlyph, write=FShowFontGlyph, default=1};
	__property FontHeight;
	__property Color = {default=-16777211};
	__property Enabled = {default=1};
	__property Font;
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Constraints;
	__property ParentBiDiMode = {default=1};
	__property ImeMode = {default=3};
	__property ImeName;
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Style = {default=0};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property OnClick;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnStartDrag;
	__property OnEndDock;
	__property OnStartDock;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvFontSelector(HWND ParentWindow) : TAdvCustomComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt LISTITEMHEIGHT = 0xe;
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x5;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x1;
extern PACKAGE void __fastcall DrawGradient(Graphics::TCanvas* Canvas, Graphics::TColor FromColor, Graphics::TColor ToColor, int Steps, const Types::TRect &R, bool Direction);

}	/* namespace Advfontcombo */
using namespace Advfontcombo;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvfontcomboHPP
