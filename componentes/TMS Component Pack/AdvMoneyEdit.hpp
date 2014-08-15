// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advmoneyedit.pas' rev: 21.00

#ifndef AdvmoneyeditHPP
#define AdvmoneyeditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Advedit.hpp>	// Pascal unit
#include <Character.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advmoneyedit
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TTabForm;
class PASCALIMPLEMENTATION TTabForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
private:
	int FButtonWidth;
	int FButtonHeight;
	Graphics::TColor FButtonColor;
	StaticArray<bool, 4> FEx;
	void __fastcall SetEx(int i, bool b);
	bool __fastcall GetEx(int i);
	MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMClose(Messages::TMessage &Msg);
	
protected:
	DYNAMIC void __fastcall Paint(void);
	
public:
	__fastcall virtual TTabForm(Classes::TComponent* aOwner);
	__fastcall virtual ~TTabForm(void);
	__property bool Ex[int i] = {read=GetEx, write=SetEx};
	
__published:
	__property int ButtonWidth = {read=FButtonWidth, write=FButtonWidth, nodefault};
	__property int ButtonHeight = {read=FButtonHeight, write=FButtonHeight, nodefault};
	__property Graphics::TColor ButtonColor = {read=FButtonColor, write=FButtonColor, nodefault};
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TTabForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TTabForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


class DELPHICLASS TDropCalculatorButton;
class PASCALIMPLEMENTATION TDropCalculatorButton : public Buttons::TSpeedButton
{
	typedef Buttons::TSpeedButton inherited;
	
private:
	Controls::TWinControl* FFocusControl;
	
protected:
	virtual void __fastcall Paint(void);
	
public:
	DYNAMIC void __fastcall Click(void);
	__fastcall virtual TDropCalculatorButton(Classes::TComponent* AOwner);
	
__published:
	__property Controls::TWinControl* FocusControl = {read=FFocusControl, write=FFocusControl};
public:
	/* TSpeedButton.Destroy */ inline __fastcall virtual ~TDropCalculatorButton(void) { }
	
};


class DELPHICLASS TCalculatorButton;
class PASCALIMPLEMENTATION TCalculatorButton : public Buttons::TSpeedButton
{
	typedef Buttons::TSpeedButton inherited;
	
protected:
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Paint(void);
public:
	/* TSpeedButton.Create */ inline __fastcall virtual TCalculatorButton(Classes::TComponent* AOwner) : Buttons::TSpeedButton(AOwner) { }
	/* TSpeedButton.Destroy */ inline __fastcall virtual ~TCalculatorButton(void) { }
	
};


class DELPHICLASS TCalculatorLook;
class PASCALIMPLEMENTATION TCalculatorLook : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Graphics::TBitmap* FButtonBkg;
	int FButtonWidth;
	int FButtonHeight;
	Graphics::TColor FButtonColor;
	Graphics::TColor FColor;
	Graphics::TFont* FFont;
	bool FFlat;
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetButtonBkg(const Graphics::TBitmap* Value);
	
public:
	__fastcall TCalculatorLook(void);
	__fastcall virtual ~TCalculatorLook(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property int ButtonWidth = {read=FButtonWidth, write=FButtonWidth, nodefault};
	__property int ButtonHeight = {read=FButtonHeight, write=FButtonHeight, nodefault};
	__property Graphics::TColor ButtonColor = {read=FButtonColor, write=FButtonColor, nodefault};
	__property Graphics::TColor Color = {read=FColor, write=FColor, nodefault};
	__property bool Flat = {read=FFlat, write=FFlat, nodefault};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Graphics::TBitmap* ButtonBkg = {read=FButtonBkg, write=SetButtonBkg};
};


class DELPHICLASS TExtraButtons;
class PASCALIMPLEMENTATION TExtraButtons : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	System::UnicodeString FExtra1;
	System::UnicodeString FExtra4;
	System::UnicodeString FExtra2;
	System::UnicodeString FExtra3;
	
__published:
	__property System::UnicodeString Extra1 = {read=FExtra1, write=FExtra1};
	__property System::UnicodeString Extra2 = {read=FExtra2, write=FExtra2};
	__property System::UnicodeString Extra3 = {read=FExtra3, write=FExtra3};
	__property System::UnicodeString Extra4 = {read=FExtra4, write=FExtra4};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TExtraButtons(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TExtraButtons(void) : Classes::TPersistent() { }
	
};


typedef void __fastcall (__closure *TExtraButtonClickEvent)(System::TObject* Sender, int idx, System::Extended &value);

class DELPHICLASS TAdvMoneyEdit;
class PASCALIMPLEMENTATION TAdvMoneyEdit : public Advedit::TAdvEdit
{
	typedef Advedit::TAdvEdit inherited;
	
private:
	TDropCalculatorButton* FButton;
	bool FEditorEnabled;
	Classes::TNotifyEvent FOnClickBtn;
	TTabForm* FCalcForm;
	bool FCalcClosed;
	bool FCloseClick;
	int FDecim;
	StaticArray<TCalculatorButton*, 23> sp;
	bool newval;
	System::Extended prevval;
	int prevop;
	TCalculatorLook* FCalculatorLook;
	TExtraButtons* FExtraButtons;
	TExtraButtonClickEvent FOnExtraButtonClick;
	int __fastcall GetMinHeight(void);
	void __fastcall SetEditRect(void);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMPaste(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMCut(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	void __fastcall FormDeactivate(System::TObject* Sender);
	void __fastcall NumButtonClick(System::TObject* Sender);
	void __fastcall FormKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall BuildCalculator(Forms::TForm* AForm);
	Graphics::TBitmap* __fastcall GetButtonGlyph(void);
	void __fastcall SetButtonGlyph(const Graphics::TBitmap* Value);
	void __fastcall docalc(void);
	void __fastcall doplus(void);
	void __fastcall domin(void);
	void __fastcall domul(void);
	void __fastcall dodiv(void);
	void __fastcall doeq(void);
	void __fastcall doperc(void);
	void __fastcall SetEditorEnabled(const bool Value);
	void __fastcall SetCalculatorLook(const TCalculatorLook* Value);
	System::Extended __fastcall GetValue(void);
	void __fastcall SetValue(const System::Extended Value);
	virtual void __fastcall BtnClick(System::TObject* Sender);
	void __fastcall SetExtraButtons(const TExtraButtons* Value);
	System::UnicodeString __fastcall GetButtonCaption(void);
	System::UnicodeString __fastcall GetButtonHint(void);
	void __fastcall SetButtonCaption(const System::UnicodeString Value);
	void __fastcall SetButtonHint(const System::UnicodeString Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DestroyWnd(void);
	virtual Forms::TCustomForm* __fastcall GetParentForm(Controls::TControl* Control);
	DYNAMIC void __fastcall KeyPress(System::WideChar &key);
	virtual void __fastcall CalcChange(void);
	
public:
	__fastcall virtual TAdvMoneyEdit(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvMoneyEdit(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall DoEnter(void);
	__property TDropCalculatorButton* Button = {read=FButton};
	__property Text;
	__property System::Extended Value = {read=GetValue, write=SetValue};
	void __fastcall ShowCalculator(void);
	void __fastcall HideCalculator(void);
	
__published:
	__property Anchors = {default=3};
	__property Constraints;
	__property DragKind = {default=0};
	__property AutoSelect = {default=1};
	__property AutoSize = {default=1};
	__property BorderStyle = {default=1};
	__property System::UnicodeString ButtonCaption = {read=GetButtonCaption, write=SetButtonCaption};
	__property System::UnicodeString ButtonHint = {read=GetButtonHint, write=SetButtonHint};
	__property TCalculatorLook* CalculatorLook = {read=FCalculatorLook, write=SetCalculatorLook};
	__property Color;
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property bool EditorEnabled = {read=FEditorEnabled, write=SetEditorEnabled, default=1};
	__property Enabled;
	__property TExtraButtons* ExtraButtons = {read=FExtraButtons, write=SetExtraButtons};
	__property Font;
	__property Graphics::TBitmap* ButtonGlyph = {read=GetButtonGlyph, write=SetButtonGlyph};
	__property MaxLength = {default=0};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ReadOnly = {default=0};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible;
	__property Height;
	__property Width;
	__property OnChange;
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property OnEndDock;
	__property OnStartDock;
	__property Classes::TNotifyEvent OnClickBtn = {read=FOnClickBtn, write=FOnClickBtn};
	__property TExtraButtonClickEvent OnExtraButtonClick = {read=FOnExtraButtonClick, write=FOnExtraButtonClick};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvMoneyEdit(HWND ParentWindow) : Advedit::TAdvEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x1;
static const ShortInt REL_VER = 0x1;
static const ShortInt BLD_VER = 0x1;

}	/* namespace Advmoneyedit */
using namespace Advmoneyedit;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvmoneyeditHPP
