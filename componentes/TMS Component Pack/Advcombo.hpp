// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advcombo.pas' rev: 21.00

#ifndef AdvcomboHPP
#define AdvcomboHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Acxpvs.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advcombo
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TWinCtrl;
class PASCALIMPLEMENTATION TWinCtrl : public Controls::TWinControl
{
	typedef Controls::TWinControl inherited;
	
public:
	/* TWinControl.Create */ inline __fastcall virtual TWinCtrl(Classes::TComponent* AOwner) : Controls::TWinControl(AOwner) { }
	/* TWinControl.CreateParented */ inline __fastcall TWinCtrl(HWND ParentWindow) : Controls::TWinControl(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TWinCtrl(void) { }
	
};


#pragma option push -b-
enum TLabelPosition { lpLeftTop, lpLeftCenter, lpLeftBottom, lpTopLeft, lpBottomLeft, lpLeftTopLeft, lpLeftCenterLeft, lpLeftBottomLeft, lpTopCenter, lpBottomCenter, lpRightTop, lpRightCenter, lpRighBottom };
#pragma option pop

class DELPHICLASS TAdvCustomCombo;
class PASCALIMPLEMENTATION TAdvCustomCombo : public Stdctrls::TCustomComboBox
{
	typedef Stdctrls::TCustomComboBox inherited;
	
private:
	bool FAutoFocus;
	bool FFlat;
	bool FEtched;
	Graphics::TColor FOldColor;
	Graphics::TColor FLoadedColor;
	bool FOldParentColor;
	int FButtonWidth;
	bool FFocusBorder;
	bool FMouseInControl;
	int FDropWidth;
	bool FIsWinXP;
	bool FIsThemed;
	bool FButtonHover;
	bool FLabelAlwaysEnabled;
	bool FLabelTransparent;
	int FLabelMargin;
	Graphics::TFont* FLabelFont;
	TLabelPosition FLabelPosition;
	Stdctrls::TLabel* FLabel;
	Graphics::TColor FFlatLineColor;
	bool FFlatParentColor;
	Classes::TNotifyEvent FOnDropUp;
	Graphics::TColor FFocusColor;
	Graphics::TColor FFocusBorderColor;
	bool FDisabledBorder;
	Graphics::TColor FNormalColor;
	bool FHasFocus;
	bool FFocusLabel;
	void __fastcall SetEtched(const bool Value);
	void __fastcall SetFlat(const bool Value);
	void __fastcall SetButtonWidth(const int Value);
	void __fastcall DrawButtonBorder(HDC DC);
	void __fastcall DrawControlBorder(HDC DC);
	void __fastcall DrawBorders(void);
	bool __fastcall Is3DBorderControl(void);
	bool __fastcall Is3DBorderButton(void);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CNCommand(Messages::TWMCommand &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMParentFontChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Message);
	void __fastcall SetDropWidth(const int Value);
	System::UnicodeString __fastcall GetLabelCaption(void);
	void __fastcall SetLabelAlwaysEnabled(const bool Value);
	void __fastcall SetLabelCaption(const System::UnicodeString Value);
	void __fastcall SetLabelFont(const Graphics::TFont* Value);
	void __fastcall SetLabelMargin(const int Value);
	void __fastcall SetLabelPosition(const TLabelPosition Value);
	void __fastcall SetLabelTransparent(const bool Value);
	void __fastcall UpdateLabel(void);
	void __fastcall LabelFontChange(System::TObject* Sender);
	void __fastcall SetFlatLineColor(const Graphics::TColor Value);
	void __fastcall SetFlatParentColor(const bool Value);
	Graphics::TColor __fastcall GetColorEx(void);
	void __fastcall SetColorEx(const Graphics::TColor Value);
	bool __fastcall GetEnabledEx(void);
	void __fastcall SetEnabledEx(const bool Value);
	System::UnicodeString __fastcall GetVersionEx(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	bool __fastcall GetVisibleEx(void);
	void __fastcall SetVisibleEx(const bool Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	bool __fastcall DoVisualStyles(void);
	Stdctrls::TLabel* __fastcall CreateLabel(void);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	__property int ButtonWidth = {read=FButtonWidth, write=SetButtonWidth, default=19};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property Graphics::TColor FlatLineColor = {read=FFlatLineColor, write=SetFlatLineColor, default=0};
	__property bool FlatParentColor = {read=FFlatParentColor, write=SetFlatParentColor, default=1};
	__property bool Etched = {read=FEtched, write=SetEtched, default=0};
	__property bool FocusBorder = {read=FFocusBorder, write=FFocusBorder, default=0};
	__property Graphics::TColor FocusBorderColor = {read=FFocusBorderColor, write=FFocusBorderColor, default=536870911};
	__property Graphics::TColor FocusColor = {read=FFocusColor, write=FFocusColor, default=536870911};
	__property bool FocusLabel = {read=FFocusLabel, write=FFocusLabel, default=0};
	__property bool AutoFocus = {read=FAutoFocus, write=FAutoFocus, default=0};
	__property int DropWidth = {read=FDropWidth, write=SetDropWidth, nodefault};
	
public:
	__fastcall virtual TAdvCustomCombo(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvCustomCombo(void);
	virtual void __fastcall Loaded(void);
	void __fastcall Init(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	__property Stdctrls::TLabel* ComboLabel = {read=FLabel};
	__property bool DisabledBorder = {read=FDisabledBorder, write=FDisabledBorder, default=1};
	__property System::UnicodeString LabelCaption = {read=GetLabelCaption, write=SetLabelCaption};
	__property TLabelPosition LabelPosition = {read=FLabelPosition, write=SetLabelPosition, default=0};
	__property int LabelMargin = {read=FLabelMargin, write=SetLabelMargin, default=4};
	__property bool LabelTransparent = {read=FLabelTransparent, write=SetLabelTransparent, default=0};
	__property bool LabelAlwaysEnabled = {read=FLabelAlwaysEnabled, write=SetLabelAlwaysEnabled, default=0};
	__property Graphics::TFont* LabelFont = {read=FLabelFont, write=SetLabelFont};
	__property bool Enabled = {read=GetEnabledEx, write=SetEnabledEx, nodefault};
	HIDESBASE void __fastcall SelectItem(System::UnicodeString AString);
	
__published:
	__property AutoComplete = {default=1};
	__property Graphics::TColor Color = {read=GetColorEx, write=SetColorEx, nodefault};
	__property Classes::TNotifyEvent OnDropUp = {read=FOnDropUp, write=FOnDropUp};
	__property System::UnicodeString Version = {read=GetVersionEx, write=SetVersion};
	__property bool Visible = {read=GetVisibleEx, write=SetVisibleEx, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvCustomCombo(HWND ParentWindow) : Stdctrls::TCustomComboBox(ParentWindow) { }
	
};


class DELPHICLASS TAdvComboBox;
class PASCALIMPLEMENTATION TAdvComboBox : public TAdvCustomCombo
{
	typedef TAdvCustomCombo inherited;
	
__published:
	__property Align = {default=0};
	__property AutoFocus = {default=0};
	__property ButtonWidth = {default=19};
	__property DisabledBorder = {default=1};
	__property Style = {default=0};
	__property Flat = {default=0};
	__property FlatLineColor = {default=0};
	__property FlatParentColor = {default=1};
	__property Etched = {default=0};
	__property FocusBorder = {default=0};
	__property FocusBorderColor = {default=536870911};
	__property FocusColor = {default=536870911};
	__property FocusLabel = {default=0};
	__property CharCase = {default=0};
	__property Color;
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property DropDownCount = {default=8};
	__property DropWidth;
	__property Enabled;
	__property Font;
	__property ImeMode = {default=3};
	__property ImeName;
	__property ItemIndex;
	__property ItemHeight;
	__property Items;
	__property LabelCaption;
	__property LabelPosition = {default=0};
	__property LabelMargin = {default=4};
	__property LabelTransparent = {default=0};
	__property LabelAlwaysEnabled = {default=0};
	__property LabelFont;
	__property MaxLength = {default=0};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Sorted = {default=0};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Text;
	__property Visible;
	__property OnChange;
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnDrawItem;
	__property OnDropDown;
	__property OnDropUp;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMeasureItem;
	__property OnStartDrag;
	__property OnSelect;
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Constraints;
	__property DragKind = {default=0};
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
	__property BevelKind = {default=0};
	__property BevelInner = {index=0, default=2};
	__property BevelOuter = {index=1, default=1};
	__property BevelEdges = {default=15};
public:
	/* TAdvCustomCombo.Create */ inline __fastcall virtual TAdvComboBox(Classes::TComponent* AOwner) : TAdvCustomCombo(AOwner) { }
	/* TAdvCustomCombo.Destroy */ inline __fastcall virtual ~TAdvComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvComboBox(HWND ParentWindow) : TAdvCustomCombo(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x3;
static const ShortInt REL_VER = 0x1;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Advcombo */
using namespace Advcombo;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvcomboHPP
