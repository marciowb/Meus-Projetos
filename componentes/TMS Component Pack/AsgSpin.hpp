// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Asgspin.pas' rev: 21.00

#ifndef AsgspinHPP
#define AsgspinHPP

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
#include <Menus.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Advxpvs.hpp>	// Pascal unit
#include <Character.hpp>	// Pascal unit
#include <Maskutils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Asgspin
{
//-- type declarations -------------------------------------------------------
typedef Buttons::TNumGlyphs TNumGlyphs;

#pragma option push -b-
enum TEditAlign { eaLeft, eaRight, eaCenter };
#pragma option pop

#pragma option push -b-
enum TSpinDirection { spVertical, spHorizontal };
#pragma option pop

class DELPHICLASS TAsgSpinButton;
class DELPHICLASS TAdvTimerSpeedButton;
class PASCALIMPLEMENTATION TAsgSpinButton : public Controls::TWinControl
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
	__fastcall virtual TAsgSpinButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TAsgSpinButton(void);
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
	/* TWinControl.CreateParented */ inline __fastcall TAsgSpinButton(HWND ParentWindow) : Controls::TWinControl(ParentWindow) { }
	
};


#pragma option push -b-
enum TAsgSpinType { sptNormal, sptFloat, sptDate, sptTime };
#pragma option pop

class DELPHICLASS TAsgSpinEdit;
class PASCALIMPLEMENTATION TAsgSpinEdit : public Mask::TCustomMaskEdit
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
	TAsgSpinButton* FButton;
	bool FEditorEnabled;
	TSpinDirection FDirection;
	TAsgSpinType FSpinType;
	int FPrecision;
	bool FReturnIsTab;
	bool FIsWinXP;
	bool FExcelStyleDecimalSeparator;
	bool FUsDates;
	bool FShowSeconds;
	int FIncrementSeconds;
	int FIncrementMinutes;
	int FIncrementHours;
	TEditAlign FEditAlign;
	bool FSpinFlat;
	bool FSpinTransparent;
	bool FAllowEmptyValue;
	int __fastcall GetMinHeight(void);
	int __fastcall GetValue(void);
	int __fastcall CheckValue(int NewValue);
	void __fastcall SetValue(int NewValue);
	double __fastcall GetFloatValue(void);
	double __fastcall CheckFloatValue(double NewValue);
	System::TDateTime __fastcall CheckDateValue(System::TDateTime NewValue);
	void __fastcall SetFloatValue(double NewValue);
	void __fastcall SetEditRect(void);
	void __fastcall SetEditorEnabled(bool NewValue);
	void __fastcall SetDirection(const TSpinDirection Value);
	void __fastcall SetPrecision(const int Value);
	void __fastcall SetSpinType(const TAsgSpinType Value);
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
	HIDESBASE MESSAGE void __fastcall WMChar(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Message);
	void __fastcall SetIsWinXP(const bool Value);
	void __fastcall SetEditAlign(const TEditAlign Value);
	
protected:
	virtual void __fastcall DoInc(bool Page);
	virtual void __fastcall DoDec(bool Page);
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
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	__fastcall virtual TAsgSpinEdit(Classes::TComponent* AOwner);
	__fastcall virtual ~TAsgSpinEdit(void);
	__property TAsgSpinButton* Button = {read=FButton};
	
__published:
	__property bool ExcelStyleDecimalSeparator = {read=FExcelStyleDecimalSeparator, write=FExcelStyleDecimalSeparator, nodefault};
	__property TSpinDirection Direction = {read=FDirection, write=SetDirection, nodefault};
	__property bool ReturnIsTab = {read=FReturnIsTab, write=FReturnIsTab, nodefault};
	__property int Precision = {read=FPrecision, write=SetPrecision, nodefault};
	__property TAsgSpinType SpinType = {read=FSpinType, write=SetSpinType, nodefault};
	__property int Value = {read=GetValue, write=SetValue, nodefault};
	__property double FloatValue = {read=GetFloatValue, write=SetFloatValue};
	__property System::TDateTime TimeValue = {read=GetTimeValue, write=SetTimeValue};
	__property System::TDateTime DateValue = {read=GetDateValue, write=SetDateValue};
	__property bool ShowSeconds = {read=FShowSeconds, write=FShowSeconds, nodefault};
	__property bool SpinFlat = {read=FSpinFlat, write=SetSpinFlat, nodefault};
	__property bool SpinTransparent = {read=FSpinTransparent, write=SetSpinTransparent, nodefault};
	__property Anchors = {default=3};
	__property AutoSelect = {default=1};
	__property bool AllowEmptyValue = {read=FAllowEmptyValue, write=FAllowEmptyValue, nodefault};
	__property AutoSize = {default=1};
	__property BorderStyle = {default=1};
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property TEditAlign EditAlign = {read=FEditAlign, write=SetEditAlign, nodefault};
	__property bool EditorEnabled = {read=FEditorEnabled, write=SetEditorEnabled, default=1};
	__property Enabled = {default=1};
	__property Font;
	__property int Increment = {read=FIncrement, write=FIncrement, default=1};
	__property double IncrementFloat = {read=FIncrementFloat, write=FIncrementFloat};
	__property int IncrementMinutes = {read=FIncrementMinutes, write=FIncrementMinutes, default=1};
	__property int IncrementSeconds = {read=FIncrementSeconds, write=FIncrementSeconds, default=1};
	__property int IncrementHours = {read=FIncrementHours, write=FIncrementHours, default=1};
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
public:
	/* TWinControl.CreateParented */ inline __fastcall TAsgSpinEdit(HWND ParentWindow) : Mask::TCustomMaskEdit(ParentWindow) { }
	
};


class DELPHICLASS TAdvMaskSpinEdit;
class PASCALIMPLEMENTATION TAdvMaskSpinEdit : public TAsgSpinEdit
{
	typedef TAsgSpinEdit inherited;
	
__published:
	__property EditMask;
public:
	/* TAsgSpinEdit.Create */ inline __fastcall virtual TAdvMaskSpinEdit(Classes::TComponent* AOwner) : TAsgSpinEdit(AOwner) { }
	/* TAsgSpinEdit.Destroy */ inline __fastcall virtual ~TAdvMaskSpinEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvMaskSpinEdit(HWND ParentWindow) : TAsgSpinEdit(ParentWindow) { }
	
};


#pragma option push -b-
enum Asgspin__4 { tbFocusRect, tbAllowTimer };
#pragma option pop

typedef Set<Asgspin__4, tbFocusRect, tbAllowTimer>  TTimeBtnState;

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
	bool FHasMouse;
	void __fastcall TimerExpired(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	
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


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Asgspin */
using namespace Asgspin;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AsgspinHPP
