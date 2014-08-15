// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Editbtn.pas' rev: 21.00

#ifndef EditbtnHPP
#define EditbtnHPP

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
#include <Dialogs.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Editbtn
{
//-- type declarations -------------------------------------------------------
typedef Buttons::TNumGlyphs TNumGlyphs;

class DELPHICLASS TAdvSpeedButton;
class PASCALIMPLEMENTATION TAdvSpeedButton : public Buttons::TSpeedButton
{
	typedef Buttons::TSpeedButton inherited;
	
private:
	bool FEtched;
	bool FFocused;
	void __fastcall SetEtched(const bool Value);
	void __fastcall SetFocused(const bool Value);
	
protected:
	virtual void __fastcall Paint(void);
	
__published:
	__property bool Etched = {read=FEtched, write=SetEtched, nodefault};
	__property bool Focused = {read=FFocused, write=SetFocused, nodefault};
public:
	/* TSpeedButton.Create */ inline __fastcall virtual TAdvSpeedButton(Classes::TComponent* AOwner) : Buttons::TSpeedButton(AOwner) { }
	/* TSpeedButton.Destroy */ inline __fastcall virtual ~TAdvSpeedButton(void) { }
	
};


class DELPHICLASS TEditButton;
class PASCALIMPLEMENTATION TEditButton : public Controls::TWinControl
{
	typedef Controls::TWinControl inherited;
	
private:
	TAdvSpeedButton* FButton;
	Controls::TWinControl* FFocusControl;
	Classes::TNotifyEvent FOnClick;
	TAdvSpeedButton* __fastcall CreateButton(void);
	Graphics::TBitmap* __fastcall GetGlyph(void);
	void __fastcall SetGlyph(Graphics::TBitmap* Value);
	Buttons::TNumGlyphs __fastcall GetNumGlyphs(void);
	void __fastcall SetNumGlyphs(Buttons::TNumGlyphs Value);
	void __fastcall SetCaption(System::UnicodeString value);
	System::UnicodeString __fastcall GetCaption(void);
	void __fastcall BtnClick(System::TObject* Sender);
	void __fastcall BtnMouseUp(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall AdjustWinSize(int &W, int &H);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual TEditButton(Classes::TComponent* AOwner);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	
__published:
	__property Align = {default=0};
	__property Ctl3D;
	__property Graphics::TBitmap* Glyph = {read=GetGlyph, write=SetGlyph};
	__property System::UnicodeString ButtonCaption = {read=GetCaption, write=SetCaption};
	__property Buttons::TNumGlyphs NumGlyphs = {read=GetNumGlyphs, write=SetNumGlyphs, default=1};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Controls::TWinControl* FocusControl = {read=FFocusControl, write=FFocusControl};
	__property ParentCtl3D = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Visible = {default=1};
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnStartDrag;
	__property Classes::TNotifyEvent OnClick = {read=FOnClick, write=FOnClick};
public:
	/* TWinControl.CreateParented */ inline __fastcall TEditButton(HWND ParentWindow) : Controls::TWinControl(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TEditButton(void) { }
	
};


class DELPHICLASS TEditBtn;
class PASCALIMPLEMENTATION TEditBtn : public Stdctrls::TCustomEdit
{
	typedef Stdctrls::TCustomEdit inherited;
	
private:
	int FUnitSize;
	bool FRightAlign;
	TEditButton* FButton;
	bool FEditorEnabled;
	Classes::TNotifyEvent FOnClickBtn;
	bool FFlat;
	bool FEtched;
	bool FFocusBorder;
	bool FMouseInControl;
	bool FReturnIsTab;
	int __fastcall GetMinHeight(void);
	void __fastcall SetEditRect(void);
	void __fastcall SetGlyph(Graphics::TBitmap* value);
	Graphics::TBitmap* __fastcall GetGlyph(void);
	void __fastcall SetCaption(System::UnicodeString value);
	System::UnicodeString __fastcall GetCaption(void);
	void __fastcall SetRightAlign(const bool Value);
	void __fastcall SetFlat(const bool Value);
	void __fastcall SetEtched(const bool Value);
	void __fastcall DrawControlBorder(HDC DC);
	void __fastcall DrawButtonBorder(void);
	void __fastcall DrawBorders(void);
	bool __fastcall Is3DBorderControl(void);
	bool __fastcall Is3DBorderButton(void);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	MESSAGE void __fastcall WMPaste(Messages::TWMNoParams &Message);
	MESSAGE void __fastcall WMCut(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TMessage &Message);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	virtual void __fastcall BtnClick(System::TObject* Sender);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	
public:
	__fastcall virtual TEditBtn(Classes::TComponent* AOwner);
	__fastcall virtual ~TEditBtn(void);
	__property TEditButton* Button = {read=FButton};
	
__published:
	__property Align = {default=0};
	__property Constraints;
	__property AutoSelect = {default=1};
	__property AutoSize = {default=1};
	__property BorderStyle = {default=1};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property bool EditorEnabled = {read=FEditorEnabled, write=FEditorEnabled, default=1};
	__property bool ReturnIsTab = {read=FReturnIsTab, write=FReturnIsTab, nodefault};
	__property Enabled = {default=1};
	__property Font;
	__property bool Flat = {read=FFlat, write=SetFlat, nodefault};
	__property bool Etched = {read=FEtched, write=SetEtched, nodefault};
	__property bool FocusBorder = {read=FFocusBorder, write=FFocusBorder, nodefault};
	__property Graphics::TBitmap* Glyph = {read=GetGlyph, write=SetGlyph};
	__property System::UnicodeString ButtonCaption = {read=GetCaption, write=SetCaption};
	__property MaxLength = {default=0};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ReadOnly = {default=0};
	__property bool RightAlign = {read=FRightAlign, write=SetRightAlign, nodefault};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Text;
	__property Visible = {default=1};
	__property Height;
	__property Width;
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
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
	__property Classes::TNotifyEvent OnClickBtn = {read=FOnClickBtn, write=FOnClickBtn};
public:
	/* TWinControl.CreateParented */ inline __fastcall TEditBtn(HWND ParentWindow) : Stdctrls::TCustomEdit(ParentWindow) { }
	
};


class DELPHICLASS TUnitEditBtn;
class PASCALIMPLEMENTATION TUnitEditBtn : public TEditBtn
{
	typedef TEditBtn inherited;
	
private:
	System::UnicodeString fUnitID;
	Classes::TStringList* fUnits;
	int __fastcall GetUnitSize(void);
	void __fastcall SetUnitSize(int value);
	void __fastcall SetUnits(Classes::TStringList* value);
	void __fastcall SetUnitID(System::UnicodeString value);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Msg);
	HIDESBASE MESSAGE void __fastcall WMCommand(Messages::TWMCommand &Message);
	
protected:
	virtual void __fastcall BtnClick(System::TObject* Sender);
	
public:
	__fastcall virtual TUnitEditBtn(Classes::TComponent* AOwner);
	__fastcall virtual ~TUnitEditBtn(void);
	
__published:
	__property Classes::TStringList* Units = {read=fUnits, write=SetUnits};
	__property System::UnicodeString UnitID = {read=fUnitID, write=SetUnitID};
	__property int UnitSpace = {read=GetUnitSize, write=SetUnitSize, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TUnitEditBtn(HWND ParentWindow) : TEditBtn(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x5;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;
extern PACKAGE void __fastcall DrawBitmapTransp(Graphics::TCanvas* canvas, Graphics::TBitmap* bmp, Graphics::TColor bkcolor, const Types::TRect &r);

}	/* namespace Editbtn */
using namespace Editbtn;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EditbtnHPP
