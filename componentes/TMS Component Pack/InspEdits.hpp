// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Inspedits.pas' rev: 21.00

#ifndef InspeditsHPP
#define InspeditsHPP

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
#include <Inspxpvs.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Character.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Maskutils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Inspedits
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
	bool __fastcall DoVisualStyles(void);
	
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


class DELPHICLASS TInspCustomCombo;
class PASCALIMPLEMENTATION TInspCustomCombo : public Stdctrls::TCustomComboBox
{
	typedef Stdctrls::TCustomComboBox inherited;
	
private:
	bool FAutoFocus;
	bool FFlat;
	bool FEtched;
	Graphics::TColor FOldColor;
	bool FOldParentColor;
	int FButtonWidth;
	bool FFocusBorder;
	bool FMouseInControl;
	int FDropWidth;
	bool FIsWinXP;
	Graphics::TColor FBkColor;
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
	void __fastcall SetDropWidth(const int Value);
	bool __fastcall DoVisualStyles(void);
	
protected:
	__property Graphics::TColor BkColor = {read=FBkColor, write=FBkColor, nodefault};
	__property int ButtonWidth = {read=FButtonWidth, write=SetButtonWidth, nodefault};
	__property bool Flat = {read=FFlat, write=SetFlat, nodefault};
	__property bool Etched = {read=FEtched, write=SetEtched, nodefault};
	__property bool FocusBorder = {read=FFocusBorder, write=FFocusBorder, nodefault};
	__property bool AutoFocus = {read=FAutoFocus, write=FAutoFocus, nodefault};
	__property int DropWidth = {read=FDropWidth, write=SetDropWidth, nodefault};
	__property bool IsWinXP = {read=FIsWinXP, write=FIsWinXP, nodefault};
	
public:
	__fastcall virtual TInspCustomCombo(Classes::TComponent* AOwner);
public:
	/* TCustomComboBox.Destroy */ inline __fastcall virtual ~TInspCustomCombo(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TInspCustomCombo(HWND ParentWindow) : Stdctrls::TCustomComboBox(ParentWindow) { }
	
};


class DELPHICLASS TInspComboBox;
class PASCALIMPLEMENTATION TInspComboBox : public TInspCustomCombo
{
	typedef TInspCustomCombo inherited;
	
__published:
	__property AutoFocus;
	__property ButtonWidth;
	__property Style = {default=0};
	__property Flat;
	__property Etched;
	__property FocusBorder;
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property DropDownCount = {default=8};
	__property DropWidth;
	__property Enabled = {default=1};
	__property Font;
	__property ItemHeight;
	__property Items;
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
	__property Visible = {default=1};
	__property OnChange;
	__property OnClick;
	__property OnCloseUp;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnDrawItem;
	__property OnDropDown;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMeasureItem;
	__property OnStartDrag;
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Constraints;
	__property DragKind = {default=0};
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
public:
	/* TInspCustomCombo.Create */ inline __fastcall virtual TInspComboBox(Classes::TComponent* AOwner) : TInspCustomCombo(AOwner) { }
	
public:
	/* TCustomComboBox.Destroy */ inline __fastcall virtual ~TInspComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TInspComboBox(HWND ParentWindow) : TInspCustomCombo(ParentWindow) { }
	
};


typedef Buttons::TNumGlyphs TNumGlyphs;

#pragma option push -b-
enum TSpinDirection { spVertical, spHorizontal };
#pragma option pop

class DELPHICLASS TInspSpinButton;
class DELPHICLASS TAdvTimerSpeedButton;
class PASCALIMPLEMENTATION TInspSpinButton : public Controls::TWinControl
{
	typedef Controls::TWinControl inherited;
	
private:
	TAdvTimerSpeedButton* FUpButton;
	TAdvTimerSpeedButton* FDownButton;
	TAdvTimerSpeedButton* FFocusedButton;
	Controls::TWinControl* FFocusControl;
	Classes::TNotifyEvent FOnUpClick;
	Classes::TNotifyEvent FOnDownClick;
	TSpinDirection FDirection;
	bool FIsWinXP;
	TAdvTimerSpeedButton* __fastcall CreateButton(void);
	Graphics::TBitmap* __fastcall GetUpGlyph(void);
	Graphics::TBitmap* __fastcall GetDownGlyph(void);
	void __fastcall SetUpGlyph(Graphics::TBitmap* Value);
	void __fastcall SetDownGlyph(Graphics::TBitmap* Value);
	Buttons::TNumGlyphs __fastcall GetUpNumGlyphs(void);
	Buttons::TNumGlyphs __fastcall GetDownNumGlyphs(void);
	void __fastcall SetUpNumGlyphs(Buttons::TNumGlyphs Value);
	void __fastcall SetDownNumGlyphs(Buttons::TNumGlyphs Value);
	void __fastcall BtnClick(System::TObject* Sender);
	void __fastcall BtnMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall SetFocusBtn(TAdvTimerSpeedButton* Btn);
	void __fastcall SetDirection(const TSpinDirection Value);
	HIDESBASE void __fastcall AdjustSize(int &W, int &H);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Message);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Message);
	void __fastcall SetIsWinXP(const bool Value);
	
protected:
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	__property bool IsWinXP = {read=FIsWinXP, write=SetIsWinXP, nodefault};
	
public:
	__fastcall virtual TInspSpinButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TInspSpinButton(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property Ctl3D;
	__property TSpinDirection Direction = {read=FDirection, write=SetDirection, nodefault};
	__property Graphics::TBitmap* DownGlyph = {read=GetDownGlyph, write=SetDownGlyph};
	__property Buttons::TNumGlyphs DownNumGlyphs = {read=GetDownNumGlyphs, write=SetDownNumGlyphs, default=1};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Controls::TWinControl* FocusControl = {read=FFocusControl, write=FFocusControl};
	__property ParentCtl3D = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Graphics::TBitmap* UpGlyph = {read=GetUpGlyph, write=SetUpGlyph};
	__property Buttons::TNumGlyphs UpNumGlyphs = {read=GetUpNumGlyphs, write=SetUpNumGlyphs, default=1};
	__property Visible = {default=1};
	__property Classes::TNotifyEvent OnDownClick = {read=FOnDownClick, write=FOnDownClick};
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnStartDock;
	__property OnStartDrag;
	__property Classes::TNotifyEvent OnUpClick = {read=FOnUpClick, write=FOnUpClick};
public:
	/* TWinControl.CreateParented */ inline __fastcall TInspSpinButton(HWND ParentWindow) : Controls::TWinControl(ParentWindow) { }
	
};


#pragma option push -b-
enum TInspSpinType { sptNormal, sptFloat, sptDate, sptTime };
#pragma option pop

class DELPHICLASS TInspSpinEdit;
class PASCALIMPLEMENTATION TInspSpinEdit : public Mask::TCustomMaskEdit
{
	typedef Mask::TCustomMaskEdit inherited;
	
private:
	int FMinValue;
	int FMaxValue;
	double FMinFloatValue;
	double FMaxFloatValue;
	System::TDateTime FMinDateValue;
	System::TDateTime FMaxDateValue;
	System::TDateTime FDateValue;
	System::TDateTime FTimeValue;
	int FIncrement;
	double FIncrementFloat;
	TInspSpinButton* FButton;
	bool FEditorEnabled;
	TSpinDirection FDirection;
	TInspSpinType FSpinType;
	int FPrecision;
	bool FReturnIsTab;
	bool FIsWinXP;
	Classes::TNotifyEvent FOnSpinUp;
	Classes::TNotifyEvent FOnSpinDown;
	Classes::TNotifyEvent FOnSpinChange;
	bool FSpinFlat;
	bool FSpinTransparent;
	int __fastcall GetMinHeight(void);
	int __fastcall GetValue(void);
	int __fastcall CheckValue(int NewValue);
	void __fastcall SetValue(int NewValue);
	double __fastcall GetFloatValue(void);
	double __fastcall CheckFloatValue(double NewValue);
	System::TDateTime __fastcall CheckDateValue(System::TDateTime NewValue);
	void __fastcall SetFloatValue(double NewValue);
	void __fastcall SetEditorEnabled(bool NewValue);
	void __fastcall SetDirection(const TSpinDirection Value);
	void __fastcall SetPrecision(const int Value);
	void __fastcall SetSpinType(const TInspSpinType Value);
	System::TDateTime __fastcall GetTimeValue(void);
	void __fastcall SetTimeValue(const System::TDateTime Value);
	System::TDateTime __fastcall GetDateValue(void);
	void __fastcall SetDateValue(const System::TDateTime Value);
	void __fastcall SetSpinFlat(const bool Value);
	void __fastcall SetSpinTransparent(const bool value);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMPaste(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMCut(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Message);
	void __fastcall SetIsWinXP(const bool Value);
	
protected:
	virtual bool __fastcall IsValidChar(System::WideChar &Key);
	virtual void __fastcall UpClick(System::TObject* Sender);
	virtual void __fastcall DownClick(System::TObject* Sender);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall Loaded(void);
	__property bool IsWinXP = {read=FIsWinXP, write=SetIsWinXP, nodefault};
	
public:
	__fastcall virtual TInspSpinEdit(Classes::TComponent* AOwner);
	__fastcall virtual ~TInspSpinEdit(void);
	__property TInspSpinButton* Button = {read=FButton};
	void __fastcall SetEditRect(void);
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	
__published:
	__property TSpinDirection Direction = {read=FDirection, write=SetDirection, nodefault};
	__property bool ReturnIsTab = {read=FReturnIsTab, write=FReturnIsTab, nodefault};
	__property int Precision = {read=FPrecision, write=SetPrecision, nodefault};
	__property TInspSpinType SpinType = {read=FSpinType, write=SetSpinType, nodefault};
	__property int Value = {read=GetValue, write=SetValue, nodefault};
	__property double FloatValue = {read=GetFloatValue, write=SetFloatValue};
	__property System::TDateTime TimeValue = {read=GetTimeValue, write=SetTimeValue};
	__property System::TDateTime DateValue = {read=GetDateValue, write=SetDateValue};
	__property bool SpinFlat = {read=FSpinFlat, write=SetSpinFlat, nodefault};
	__property bool SpinTransparent = {read=FSpinTransparent, write=SetSpinTransparent, nodefault};
	__property Anchors = {default=3};
	__property AutoSelect = {default=1};
	__property AutoSize = {default=1};
	__property BorderStyle = {default=1};
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property bool EditorEnabled = {read=FEditorEnabled, write=SetEditorEnabled, default=1};
	__property Enabled = {default=1};
	__property Font;
	__property int Increment = {read=FIncrement, write=FIncrement, default=1};
	__property double IncrementFloat = {read=FIncrementFloat, write=FIncrementFloat};
	__property MaxLength = {default=0};
	__property int MaxValue = {read=FMaxValue, write=FMaxValue, nodefault};
	__property int MinValue = {read=FMinValue, write=FMinValue, nodefault};
	__property double MinFloatValue = {read=FMinFloatValue, write=FMinFloatValue};
	__property double MaxFloatValue = {read=FMaxFloatValue, write=FMaxFloatValue};
	__property System::TDateTime MinDateValue = {read=FMinDateValue, write=FMinDateValue};
	__property System::TDateTime MaxDateValue = {read=FMaxDateValue, write=FMaxDateValue};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ReadOnly = {default=0};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
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
	__property Classes::TNotifyEvent OnSpinUp = {read=FOnSpinUp, write=FOnSpinUp};
	__property Classes::TNotifyEvent OnSpinDown = {read=FOnSpinDown, write=FOnSpinDown};
	__property Classes::TNotifyEvent OnSpinChange = {read=FOnSpinChange, write=FOnSpinChange};
public:
	/* TWinControl.CreateParented */ inline __fastcall TInspSpinEdit(HWND ParentWindow) : Mask::TCustomMaskEdit(ParentWindow) { }
	
};


class DELPHICLASS TAdvMaskSpinEdit;
class PASCALIMPLEMENTATION TAdvMaskSpinEdit : public TInspSpinEdit
{
	typedef TInspSpinEdit inherited;
	
__published:
	__property EditMask;
public:
	/* TInspSpinEdit.Create */ inline __fastcall virtual TAdvMaskSpinEdit(Classes::TComponent* AOwner) : TInspSpinEdit(AOwner) { }
	/* TInspSpinEdit.Destroy */ inline __fastcall virtual ~TAdvMaskSpinEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvMaskSpinEdit(HWND ParentWindow) : TInspSpinEdit(ParentWindow) { }
	
};


#pragma option push -b-
enum Inspedits__8 { tbFocusRect, tbAllowTimer };
#pragma option pop

typedef Set<Inspedits__8, tbFocusRect, tbAllowTimer>  TTimeBtnState;

#pragma option push -b-
enum TButtonDirection { bdLeft, bdRight, bdUp, bdDown };
#pragma option pop

class PASCALIMPLEMENTATION TAdvTimerSpeedButton : public Buttons::TSpeedButton
{
	typedef Buttons::TSpeedButton inherited;
	
private:
	Extctrls::TTimer* FRepeatTimer;
	TTimeBtnState FTimeBtnState;
	TButtonDirection FButtonDirection;
	bool FIsWinXP;
	void __fastcall TimerExpired(System::TObject* Sender);
	bool __fastcall DoVisualStyles(void);
	
protected:
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	__property bool IsWinXP = {read=FIsWinXP, write=FIsWinXP, nodefault};
	
public:
	__fastcall virtual ~TAdvTimerSpeedButton(void);
	__property TTimeBtnState TimeBtnState = {read=FTimeBtnState, write=FTimeBtnState, nodefault};
	__property TButtonDirection ButtonDirection = {read=FButtonDirection, write=FButtonDirection, nodefault};
public:
	/* TSpeedButton.Create */ inline __fastcall virtual TAdvTimerSpeedButton(Classes::TComponent* AOwner) : Buttons::TSpeedButton(AOwner) { }
	
};


class DELPHICLASS TInspEditButton;
class PASCALIMPLEMENTATION TInspEditButton : public Controls::TWinControl
{
	typedef Controls::TWinControl inherited;
	
private:
	TAdvSpeedButton* FButton;
	Controls::TWinControl* FFocusControl;
	Classes::TNotifyEvent FOnClick;
	bool FFlat;
	bool FIsWinXP;
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
	void __fastcall SetIsWinXP(const bool Value);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual TInspEditButton(Classes::TComponent* AOwner);
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
	__property bool IsWinXP = {read=FIsWinXP, write=SetIsWinXP, nodefault};
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
	/* TWinControl.CreateParented */ inline __fastcall TInspEditButton(HWND ParentWindow) : Controls::TWinControl(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TInspEditButton(void) { }
	
};


class DELPHICLASS TInspEditBtn;
class PASCALIMPLEMENTATION TInspEditBtn : public Stdctrls::TCustomEdit
{
	typedef Stdctrls::TCustomEdit inherited;
	
private:
	int FUnitSize;
	bool FRightAlign;
	TInspEditButton* FButton;
	bool FEditorEnabled;
	Classes::TNotifyEvent FOnClickBtn;
	int FButtonWidth;
	bool FIsWinXP;
	int __fastcall GetMinHeight(void);
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
	virtual void __fastcall BtnExit(System::TObject* Sender);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall DoEnter(void);
	void __fastcall ResizeControl(void);
	
public:
	__fastcall virtual TInspEditBtn(Classes::TComponent* AOwner);
	__fastcall virtual ~TInspEditBtn(void);
	__property TInspEditButton* Button = {read=FButton};
	void __fastcall SetEditRect(void);
	
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
	/* TWinControl.CreateParented */ inline __fastcall TInspEditBtn(HWND ParentWindow) : Stdctrls::TCustomEdit(ParentWindow) { }
	
};


class DELPHICLASS TInspDateTimePicker;
class PASCALIMPLEMENTATION TInspDateTimePicker : public Comctrls::TDateTimePicker
{
	typedef Comctrls::TDateTimePicker inherited;
	
private:
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TMessage &Message);
public:
	/* TDateTimePicker.Create */ inline __fastcall virtual TInspDateTimePicker(Classes::TComponent* AOwner) : Comctrls::TDateTimePicker(AOwner) { }
	
public:
	/* TCommonCalendar.Destroy */ inline __fastcall virtual ~TInspDateTimePicker(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TInspDateTimePicker(HWND ParentWindow) : Comctrls::TDateTimePicker(ParentWindow) { }
	
};


class DELPHICLASS TInspColorComboBox;
class PASCALIMPLEMENTATION TInspColorComboBox : public TInspComboBox
{
	typedef TInspComboBox inherited;
	
private:
	Graphics::TColor FCustomColor;
	Graphics::TColor __fastcall GetColorValue(void);
	void __fastcall SetColorValue(const Graphics::TColor Value);
	
protected:
	virtual void __fastcall DrawItem(int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	
__published:
	__property IsWinXP;
	__property BkColor;
	__property Graphics::TColor ColorValue = {read=GetColorValue, write=SetColorValue, nodefault};
	__property Graphics::TColor CustomColor = {read=FCustomColor, write=FCustomColor, nodefault};
public:
	/* TInspCustomCombo.Create */ inline __fastcall virtual TInspColorComboBox(Classes::TComponent* AOwner) : TInspComboBox(AOwner) { }
	
public:
	/* TCustomComboBox.Destroy */ inline __fastcall virtual ~TInspColorComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TInspColorComboBox(HWND ParentWindow) : TInspComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Inspedits */
using namespace Inspedits;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// InspeditsHPP
