// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Asgedit.pas' rev: 21.00

#ifndef AsgeditHPP
#define AsgeditHPP

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
#include <Graphics.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Advxpvs.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Asgedit
{
//-- type declarations -------------------------------------------------------
typedef Buttons::TNumGlyphs TNumGlyphs;

class DELPHICLASS TAdvSpeedButton;
class PASCALIMPLEMENTATION TAdvSpeedButton : public Buttons::TSpeedButton
{
	typedef Buttons::TSpeedButton inherited;
	
private:
	bool FIsWinXP;
	bool FFlat;
	bool FHot;
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall Paint(void);
	
public:
	__property bool Hot = {read=FHot, write=FHot, nodefault};
	
__published:
	__property bool IsWinXP = {read=FIsWinXP, write=FIsWinXP, nodefault};
	__property bool Flat = {read=FFlat, write=FFlat, nodefault};
public:
	/* TSpeedButton.Create */ inline __fastcall virtual TAdvSpeedButton(Classes::TComponent* AOwner) : Buttons::TSpeedButton(AOwner) { }
	/* TSpeedButton.Destroy */ inline __fastcall virtual ~TAdvSpeedButton(void) { }
	
};


class DELPHICLASS TAsgEditButton;
class PASCALIMPLEMENTATION TAsgEditButton : public Controls::TWinControl
{
	typedef Controls::TWinControl inherited;
	
private:
	TAdvSpeedButton* FButton;
	Controls::TWinControl* FFocusControl;
	Classes::TNotifyEvent FOnClick;
	bool FFlat;
	TAdvSpeedButton* __fastcall CreateButton(void);
	Graphics::TBitmap* __fastcall GetGlyph(void);
	void __fastcall SetGlyph(Graphics::TBitmap* Value);
	Buttons::TNumGlyphs __fastcall GetNumGlyphs(void);
	void __fastcall SetNumGlyphs(Buttons::TNumGlyphs Value);
	void __fastcall SetCaption(System::UnicodeString value);
	System::UnicodeString __fastcall GetCaption(void);
	void __fastcall BtnClick(System::TObject* Sender);
	void __fastcall BtnMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	HIDESBASE void __fastcall AdjustSize(int &W, int &H);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	void __fastcall SetFlat(const bool Value);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__property TAdvSpeedButton* Button = {read=FButton};
	__fastcall virtual TAsgEditButton(Classes::TComponent* AOwner);
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
	__property bool Flat = {read=FFlat, write=SetFlat, nodefault};
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
	/* TWinControl.CreateParented */ inline __fastcall TAsgEditButton(HWND ParentWindow) : Controls::TWinControl(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TAsgEditButton(void) { }
	
};


class DELPHICLASS TAsgEditBtn;
class PASCALIMPLEMENTATION TAsgEditBtn : public Stdctrls::TCustomEdit
{
	typedef Stdctrls::TCustomEdit inherited;
	
private:
	int FUnitSize;
	bool FRightAlign;
	TAsgEditButton* FButton;
	bool FEditorEnabled;
	Classes::TNotifyEvent FOnClickBtn;
	int FButtonWidth;
	bool FIsWinXP;
	int __fastcall GetMinHeight(void);
	void __fastcall SetEditRect(void);
	void __fastcall SetGlyph(Graphics::TBitmap* value);
	Graphics::TBitmap* __fastcall GetGlyph(void);
	void __fastcall SetCaption(System::UnicodeString value);
	System::UnicodeString __fastcall GetCaption(void);
	void __fastcall SetRightAlign(bool value);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	MESSAGE void __fastcall WMPaste(Messages::TWMNoParams &Message);
	MESSAGE void __fastcall WMCut(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Msg);
	HIDESBASE MESSAGE void __fastcall WMChar(Messages::TWMKey &Message);
	void __fastcall SetButtonWidth(const int Value);
	void __fastcall SetIsWinXP(const bool Value);
	
protected:
	virtual void __fastcall BtnClick(System::TObject* Sender);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	
public:
	__fastcall virtual TAsgEditBtn(Classes::TComponent* AOwner);
	__fastcall virtual ~TAsgEditBtn(void);
	__property TAsgEditButton* Button = {read=FButton};
	
__published:
	__property AutoSelect = {default=1};
	__property AutoSize = {default=1};
	__property BorderStyle = {default=1};
	__property int ButtonWidth = {read=FButtonWidth, write=SetButtonWidth, nodefault};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property bool EditorEnabled = {read=FEditorEnabled, write=FEditorEnabled, default=1};
	__property Enabled = {default=1};
	__property Font;
	__property Graphics::TBitmap* Glyph = {read=GetGlyph, write=SetGlyph};
	__property bool IsWinXP = {read=FIsWinXP, write=SetIsWinXP, nodefault};
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
	/* TWinControl.CreateParented */ inline __fastcall TAsgEditBtn(HWND ParentWindow) : Stdctrls::TCustomEdit(ParentWindow) { }
	
};


class DELPHICLASS TAsgUnitEditBtn;
class PASCALIMPLEMENTATION TAsgUnitEditBtn : public TAsgEditBtn
{
	typedef TAsgEditBtn inherited;
	
private:
	System::UnicodeString FUnitID;
	Classes::TStringList* FUnits;
	void __fastcall SetUnitSize(int value);
	int __fastcall GetUnitSize(void);
	void __fastcall SetUnits(Classes::TStringList* value);
	void __fastcall SetUnitID(System::UnicodeString value);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Msg);
	HIDESBASE MESSAGE void __fastcall WMCommand(Messages::TWMCommand &Message);
	
protected:
	virtual void __fastcall BtnClick(System::TObject* Sender);
	
public:
	__fastcall virtual TAsgUnitEditBtn(Classes::TComponent* AOwner);
	__fastcall virtual ~TAsgUnitEditBtn(void);
	
__published:
	__property Classes::TStringList* Units = {read=FUnits, write=SetUnits};
	__property System::UnicodeString UnitID = {read=FUnitID, write=SetUnitID};
	__property int UnitSpace = {read=GetUnitSize, write=SetUnitSize, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAsgUnitEditBtn(HWND ParentWindow) : TAsgEditBtn(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const Word InitRepeatPause = 0x190;
static const ShortInt RepeatPause = 0x64;

}	/* namespace Asgedit */
using namespace Asgedit;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AsgeditHPP
