// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'atParHTML.pas' rev: 22.00

#ifndef AtparhtmlHPP
#define AtparhtmlHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <atPictureContainer.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <ImgList.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <AtParXPVS.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Atparhtml
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TParamUpdateEvent)(System::TObject* Sender, System::UnicodeString Param, System::UnicodeString Text);

class DELPHICLASS TPopupMaskEdit;
class PASCALIMPLEMENTATION TPopupMaskEdit : public Mask::TMaskEdit
{
	typedef Mask::TMaskEdit inherited;
	
private:
	bool FCancelled;
	System::UnicodeString FParam;
	TParamUpdateEvent FOnUpdate;
	Classes::TNotifyEvent FOnReturn;
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	MESSAGE void __fastcall WMActivate(Messages::TWMActivate &Message);
	
protected:
	DYNAMIC void __fastcall DoExit(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	
public:
	__property bool Cancelled = {read=FCancelled, write=FCancelled, nodefault};
	__property System::UnicodeString Param = {read=FParam, write=FParam};
	__property TParamUpdateEvent OnUpdate = {read=FOnUpdate, write=FOnUpdate};
	__property Classes::TNotifyEvent OnReturn = {read=FOnReturn, write=FOnReturn};
public:
	/* TCustomMaskEdit.Create */ inline __fastcall virtual TPopupMaskEdit(Classes::TComponent* AOwner) : Mask::TMaskEdit(AOwner) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TPopupMaskEdit(HWND ParentWindow) : Mask::TMaskEdit(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TPopupMaskEdit(void) { }
	
};


class DELPHICLASS TPopupEdit;
class PASCALIMPLEMENTATION TPopupEdit : public Stdctrls::TEdit
{
	typedef Stdctrls::TEdit inherited;
	
private:
	bool FCancelled;
	System::UnicodeString FParam;
	TParamUpdateEvent FOnUpdate;
	bool FAutoSize;
	Classes::TNotifyEvent FOnReturn;
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMChar(Messages::TWMKey &Msg);
	MESSAGE void __fastcall WMActivate(Messages::TWMActivate &Message);
	
protected:
	DYNAMIC void __fastcall DoExit(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall Change(void);
	
public:
	__property bool AutoSize = {read=FAutoSize, write=FAutoSize, nodefault};
	__property bool Cancelled = {read=FCancelled, write=FCancelled, nodefault};
	__property System::UnicodeString Param = {read=FParam, write=FParam};
	__property TParamUpdateEvent OnUpdate = {read=FOnUpdate, write=FOnUpdate};
	__property Classes::TNotifyEvent OnReturn = {read=FOnReturn, write=FOnReturn};
public:
	/* TCustomEdit.Create */ inline __fastcall virtual TPopupEdit(Classes::TComponent* AOwner) : Stdctrls::TEdit(AOwner) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TPopupEdit(HWND ParentWindow) : Stdctrls::TEdit(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TPopupEdit(void) { }
	
};


#pragma option push -b-
enum Atparhtml__3 { tbFocusRect, tbAllowTimer };
#pragma option pop

typedef System::Set<Atparhtml__3, Atparhtml__3::tbFocusRect, Atparhtml__3::tbAllowTimer>  TatTimeBtnState;

class DELPHICLASS TatTimerSpeedButton;
class PASCALIMPLEMENTATION TatTimerSpeedButton : public Buttons::TSpeedButton
{
	typedef Buttons::TSpeedButton inherited;
	
private:
	Extctrls::TTimer* FRepeatTimer;
	TatTimeBtnState FTimeBtnState;
	void __fastcall TimerExpired(System::TObject* Sender);
	
protected:
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	
public:
	__fastcall virtual ~TatTimerSpeedButton(void);
	__property TatTimeBtnState TimeBtnState = {read=FTimeBtnState, write=FTimeBtnState, nodefault};
public:
	/* TSpeedButton.Create */ inline __fastcall virtual TatTimerSpeedButton(Classes::TComponent* AOwner) : Buttons::TSpeedButton(AOwner) { }
	
};


class DELPHICLASS TatSpinButton;
class PASCALIMPLEMENTATION TatSpinButton : public Controls::TWinControl
{
	typedef Controls::TWinControl inherited;
	
private:
	TatTimerSpeedButton* FUpButton;
	TatTimerSpeedButton* FDownButton;
	TatTimerSpeedButton* FFocusedButton;
	Controls::TWinControl* FFocusControl;
	Classes::TNotifyEvent FOnUpClick;
	Classes::TNotifyEvent FOnDownClick;
	TatTimerSpeedButton* __fastcall CreateButton(void);
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
	void __fastcall SetFocusBtn(TatTimerSpeedButton* Btn);
	HIDESBASE void __fastcall AdjustSize(int &W, int &H);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Message);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Message);
	
protected:
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual TatSpinButton(Classes::TComponent* AOwner);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	
__published:
	__property Align = {default=0};
	__property Ctl3D;
	__property Graphics::TBitmap* DownGlyph = {read=GetDownGlyph, write=SetDownGlyph};
	__property Buttons::TNumGlyphs DownNumGlyphs = {read=GetDownNumGlyphs, write=SetDownNumGlyphs, default=1};
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
	__property Graphics::TBitmap* UpGlyph = {read=GetUpGlyph, write=SetUpGlyph};
	__property Buttons::TNumGlyphs UpNumGlyphs = {read=GetUpNumGlyphs, write=SetUpNumGlyphs, default=1};
	__property Visible = {default=1};
	__property Classes::TNotifyEvent OnDownClick = {read=FOnDownClick, write=FOnDownClick};
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEnter;
	__property OnExit;
	__property Classes::TNotifyEvent OnUpClick = {read=FOnUpClick, write=FOnUpClick};
public:
	/* TWinControl.CreateParented */ inline __fastcall TatSpinButton(HWND ParentWindow) : Controls::TWinControl(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TatSpinButton(void) { }
	
};


class DELPHICLASS TatSpinEdit;
class PASCALIMPLEMENTATION TatSpinEdit : public Stdctrls::TCustomEdit
{
	typedef Stdctrls::TCustomEdit inherited;
	
private:
	int FMinValue;
	int FMaxValue;
	int FIncrement;
	TatSpinButton* FButton;
	bool FEditorEnabled;
	int __fastcall GetMinHeight(void);
	int __fastcall GetValue(void);
	int __fastcall CheckValue(int NewValue);
	void __fastcall SetValue(int NewValue);
	void __fastcall SetEditRect(void);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	MESSAGE void __fastcall WMPaste(Messages::TWMNoParams &Message);
	MESSAGE void __fastcall WMCut(Messages::TWMNoParams &Message);
	
protected:
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	virtual bool __fastcall IsValidChar(System::WideChar Key);
	virtual void __fastcall UpClick(System::TObject* Sender);
	virtual void __fastcall DownClick(System::TObject* Sender);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	
public:
	__fastcall virtual TatSpinEdit(Classes::TComponent* AOwner);
	__fastcall virtual ~TatSpinEdit(void);
	__property TatSpinButton* Button = {read=FButton};
	
__published:
	__property AutoSelect = {default=1};
	__property AutoSize = {default=1};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property bool EditorEnabled = {read=FEditorEnabled, write=FEditorEnabled, default=1};
	__property Enabled = {default=1};
	__property Font;
	__property int Increment = {read=FIncrement, write=FIncrement, default=1};
	__property MaxLength = {default=0};
	__property int MaxValue = {read=FMaxValue, write=FMaxValue, nodefault};
	__property int MinValue = {read=FMinValue, write=FMinValue, nodefault};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ReadOnly = {default=0};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property int Value = {read=GetValue, write=SetValue, nodefault};
	__property Visible = {default=1};
	__property OnChange;
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
public:
	/* TWinControl.CreateParented */ inline __fastcall TatSpinEdit(HWND ParentWindow) : Stdctrls::TCustomEdit(ParentWindow) { }
	
};


class DELPHICLASS TPopupSpinEdit;
class PASCALIMPLEMENTATION TPopupSpinEdit : public TatSpinEdit
{
	typedef TatSpinEdit inherited;
	
private:
	bool FCancelled;
	System::UnicodeString FParam;
	TParamUpdateEvent FOnUpdate;
	Classes::TNotifyEvent FOnReturn;
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMChar(Messages::TWMKey &Msg);
	MESSAGE void __fastcall WMActivate(Messages::TWMActivate &Message);
	
protected:
	DYNAMIC void __fastcall DoExit(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	
public:
	__property bool Cancelled = {read=FCancelled, write=FCancelled, nodefault};
	__property System::UnicodeString Param = {read=FParam, write=FParam};
	__property TParamUpdateEvent OnUpdate = {read=FOnUpdate, write=FOnUpdate};
	__property Classes::TNotifyEvent OnReturn = {read=FOnReturn, write=FOnReturn};
public:
	/* TatSpinEdit.Create */ inline __fastcall virtual TPopupSpinEdit(Classes::TComponent* AOwner) : TatSpinEdit(AOwner) { }
	/* TatSpinEdit.Destroy */ inline __fastcall virtual ~TPopupSpinEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TPopupSpinEdit(HWND ParentWindow) : TatSpinEdit(ParentWindow) { }
	
};


class DELPHICLASS TPopupListBox;
class PASCALIMPLEMENTATION TPopupListBox : public Stdctrls::TListBox
{
	typedef Stdctrls::TListBox inherited;
	
private:
	System::UnicodeString FParam;
	TParamUpdateEvent FOnUpdate;
	Classes::TNotifyEvent FOnReturn;
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Message);
	MESSAGE void __fastcall WMActivate(Messages::TWMActivate &Message);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	
public:
	void __fastcall SizeDropDownWidth(void);
	__property System::UnicodeString Param = {read=FParam, write=FParam};
	__property TParamUpdateEvent OnUpdate = {read=FOnUpdate, write=FOnUpdate};
	__property Classes::TNotifyEvent OnReturn = {read=FOnReturn, write=FOnReturn};
public:
	/* TCustomListBox.Create */ inline __fastcall virtual TPopupListBox(Classes::TComponent* AOwner) : Stdctrls::TListBox(AOwner) { }
	/* TCustomListBox.Destroy */ inline __fastcall virtual ~TPopupListBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TPopupListBox(HWND ParentWindow) : Stdctrls::TListBox(ParentWindow) { }
	
};


class DELPHICLASS TPopupDatePicker;
class PASCALIMPLEMENTATION TPopupDatePicker : public Comctrls::TDateTimePicker
{
	typedef Comctrls::TDateTimePicker inherited;
	
private:
	bool FCancelled;
	System::UnicodeString FParam;
	TParamUpdateEvent FOnUpdate;
	Classes::TNotifyEvent FOnReturn;
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	MESSAGE void __fastcall WMActivate(Messages::TWMActivate &Message);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall DoExit(void);
	
public:
	void __fastcall ReInit(void);
	__property bool Cancelled = {read=FCancelled, write=FCancelled, nodefault};
	__property System::UnicodeString Param = {read=FParam, write=FParam};
	__property TParamUpdateEvent OnUpdate = {read=FOnUpdate, write=FOnUpdate};
	__property Classes::TNotifyEvent OnReturn = {read=FOnReturn, write=FOnReturn};
public:
	/* TDateTimePicker.Create */ inline __fastcall virtual TPopupDatePicker(Classes::TComponent* AOwner) : Comctrls::TDateTimePicker(AOwner) { }
	
public:
	/* TCommonCalendar.Destroy */ inline __fastcall virtual ~TPopupDatePicker(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TPopupDatePicker(HWND ParentWindow) : Comctrls::TDateTimePicker(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE bool IsWinXP;
extern PACKAGE void __fastcall PrintBitmap(Graphics::TCanvas* Canvas, const Types::TRect &DestRect, Graphics::TBitmap* Bitmap);
extern PACKAGE bool __fastcall GetControlValue(System::UnicodeString HTML, System::UnicodeString ControlID, System::UnicodeString &ControlValue);
extern PACKAGE bool __fastcall SetControlValue(System::UnicodeString &HTML, System::UnicodeString ControlID, System::UnicodeString ControlValue);
extern PACKAGE bool __fastcall HTMLDrawEx(Graphics::TCanvas* Canvas, System::UnicodeString s, const Types::TRect &fr, Controls::TImageList* FImages, int XPos, int YPos, int FocusLink, int HoverLink, int ShadowOffset, bool CheckHotSpot, bool CheckHeight, bool Print, bool Selected, bool Blink, bool HoverStyle, bool WordWrap, bool Down, bool GetFocusRect, double ResFactor, Graphics::TColor URLColor, Graphics::TColor HoverColor, Graphics::TColor HoverFontColor, Graphics::TColor ShadowColor, System::UnicodeString &AnchorVal, System::UnicodeString &StripVal, System::UnicodeString &FocusAnchor, int &XSize, int &YSize, int &HyperLinks, int &MouseLink, Types::TRect &HoverRect, Types::TRect &ControlRect, System::UnicodeString &CID, System::UnicodeString &CV, System::UnicodeString &CT, Atpicturecontainer::THTMLPictureCache* ic,
	Atpicturecontainer::TatPictureContainer* pc, unsigned WinHandle, int LineSpacing);
extern PACKAGE System::UnicodeString __fastcall HTMLStrip(System::UnicodeString s);
extern PACKAGE System::UnicodeString __fastcall HiLight(System::UnicodeString s, System::UnicodeString h, System::UnicodeString tag, bool DoCase);
extern PACKAGE System::UnicodeString __fastcall UnHiLight(System::UnicodeString s, System::UnicodeString tag);
extern PACKAGE bool __fastcall GetHREFValue(System::UnicodeString html, System::UnicodeString href, System::UnicodeString &value);
extern PACKAGE bool __fastcall SetHREFValue(System::UnicodeString &html, System::UnicodeString href, System::UnicodeString value);
extern PACKAGE System::UnicodeString __fastcall HTMLPrep(System::UnicodeString s);
extern PACKAGE System::UnicodeString __fastcall InvHTMLPrep(System::UnicodeString s);
extern PACKAGE void __fastcall PropToList(System::UnicodeString s, Classes::TStringList* sl);
extern PACKAGE bool __fastcall ExtractParamInfo(System::UnicodeString html, System::UnicodeString href, System::UnicodeString &AClass, System::UnicodeString &AValue, System::UnicodeString &AProps, System::UnicodeString &AHint);

}	/* namespace Atparhtml */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Atparhtml;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AtparhtmlHPP
