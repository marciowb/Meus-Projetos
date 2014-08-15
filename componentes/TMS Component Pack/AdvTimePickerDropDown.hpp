// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advtimepickerdropdown.pas' rev: 21.00

#ifndef AdvtimepickerdropdownHPP
#define AdvtimepickerdropdownHPP

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
#include <Controls.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Advdropdown.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Activex.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advtimepickerdropdown
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TWatchShape { wsCircle, wsRect, wsRoundRect };
#pragma option pop

#pragma option push -b-
enum TWatchBorderStyle { wbLine, wbDoubleLine, wbNone };
#pragma option pop

#pragma option push -b-
enum THourMarkStyle { hmsLine, hmsQuartDblLine };
#pragma option pop

#pragma option push -b-
enum TTickMarks { tmAll, tmHours, tmQuartHours, tmNone };
#pragma option pop

#pragma option push -b-
enum TPointerStyle { psLine, psShortLine, psPointer, psLineArrow };
#pragma option pop

#pragma option push -b-
enum TAMPMFrame { apRect, apRoundRect };
#pragma option pop

#pragma option push -b-
enum TWatchGradient { wgRadial, wgVertical, wgDiagonalForward, wgDiagonalBackward };
#pragma option pop

class DELPHICLASS TWatchAppearance;
class PASCALIMPLEMENTATION TWatchAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	int FSize;
	Graphics::TColor FHourPointer;
	Graphics::TColor FBackgroundColor;
	Graphics::TColor FMinutePointerShadow;
	Graphics::TColor FBackgroundColorTo;
	Graphics::TColor FHourPointerShadow;
	Graphics::TColor FSecondPointerShadow;
	Graphics::TColor FSecondPointer;
	Graphics::TColor FBorderColor;
	Graphics::TColor FMinutePointer;
	Graphics::TFont* FHourFont;
	Graphics::TFont* FAMPMFont;
	Classes::TNotifyEvent FOnChange;
	Graphics::TPicture* FPicture;
	TAMPMFrame FAMPMFrame;
	TWatchShape FWatchShape;
	TPointerStyle FPointerStyle;
	TWatchBorderStyle FBorderStyle;
	System::Byte FHourPointerSize;
	System::Byte FSecondPointerSize;
	System::Byte FMinutePointerSize;
	Graphics::TColor FHourColor;
	Graphics::TColor FMinuteColor;
	System::Byte FCenterPointSize;
	Graphics::TColor FCenterPointColor;
	Graphics::TColor FCenterPointBorderColor;
	TWatchGradient FBackgroundGradient;
	int FRounding;
	System::Byte FHourMarkLength;
	System::Byte FHourMarkWidth;
	System::Byte FMinuteMarkLength;
	System::Byte FMinuteMarkWidth;
	int FBorderWidth;
	Graphics::TColor FAMPMColor;
	Graphics::TColor FAMPMBorderColor;
	Graphics::TColor FCenterPointOuterBorderColor;
	TTickMarks FTickMarks;
	THourMarkStyle FHourMarkStyle;
	void __fastcall PictureChanged(System::TObject* Sender);
	void __fastcall SetAMPMFont(const Graphics::TFont* Value);
	void __fastcall SetBackgroundColor(const Graphics::TColor Value);
	void __fastcall SetBackgroundColorTo(const Graphics::TColor Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetHourFont(const Graphics::TFont* Value);
	void __fastcall SetHourPointer(const Graphics::TColor Value);
	void __fastcall SetHourPointerShadow(const Graphics::TColor Value);
	void __fastcall SetMinutePointer(const Graphics::TColor Value);
	void __fastcall SetMinutePointerShadow(const Graphics::TColor Value);
	void __fastcall SetPicture(const Graphics::TPicture* Value);
	void __fastcall SetSecondPointer(const Graphics::TColor Value);
	void __fastcall SetSecondPointerShadow(const Graphics::TColor Value);
	void __fastcall SetSize(const int Value);
	void __fastcall SetAMPMFrame(const TAMPMFrame Value);
	void __fastcall SetWatchShape(const TWatchShape Value);
	void __fastcall SetBorderStyle(const TWatchBorderStyle Value);
	void __fastcall SetPointerStyle(const TPointerStyle Value);
	void __fastcall SetHourPointerSize(const System::Byte Value);
	void __fastcall SetMinutePointerSize(const System::Byte Value);
	void __fastcall SetSecondPointerSize(const System::Byte Value);
	void __fastcall SetHourColor(const Graphics::TColor Value);
	void __fastcall SetMinuteColor(const Graphics::TColor Value);
	void __fastcall SetCenterPointColor(const Graphics::TColor Value);
	void __fastcall SetCenterPointSize(const System::Byte Value);
	void __fastcall SetCenterPointBorderColor(const Graphics::TColor Value);
	void __fastcall SetBackgroundGradient(const TWatchGradient Value);
	void __fastcall SetRounding(const int Value);
	void __fastcall SetHourMarkLength(const System::Byte Value);
	void __fastcall SetMinuteMarkLength(const System::Byte Value);
	void __fastcall SetHourMarkWidth(const System::Byte Value);
	void __fastcall SetMinuteMarkWidth(const System::Byte Value);
	void __fastcall SetBorderWidth(const int Value);
	void __fastcall SetCenterPointOuterBorderColor(const Graphics::TColor Value);
	void __fastcall SetTickMarks(const TTickMarks Value);
	void __fastcall SetHourMarkStyle(const THourMarkStyle Value);
	
protected:
	void __fastcall Changed(void);
	__property int Rounding = {read=FRounding, write=SetRounding, default=5};
	__property TWatchBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, nodefault};
	__property Graphics::TColor SecondPointerShadow = {read=FSecondPointerShadow, write=SetSecondPointerShadow, nodefault};
	
public:
	__fastcall TWatchAppearance(void);
	__fastcall virtual ~TWatchAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
__published:
	__property Graphics::TFont* AMPMFont = {read=FAMPMFont, write=SetAMPMFont};
	__property Graphics::TColor AMPMBorderColor = {read=FAMPMBorderColor, write=FAMPMBorderColor, default=0};
	__property Graphics::TColor AMPMColor = {read=FAMPMColor, write=FAMPMColor, default=16777215};
	__property TAMPMFrame AMPMFrame = {read=FAMPMFrame, write=SetAMPMFrame, default=0};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=0};
	__property int BorderWidth = {read=FBorderWidth, write=SetBorderWidth, default=4};
	__property Graphics::TColor BackgroundColor = {read=FBackgroundColor, write=SetBackgroundColor, default=16777215};
	__property Graphics::TColor BackgroundColorTo = {read=FBackgroundColorTo, write=SetBackgroundColorTo, default=536870911};
	__property TWatchGradient BackgroundGradient = {read=FBackgroundGradient, write=SetBackgroundGradient, default=1};
	__property Graphics::TColor CenterPointBorderColor = {read=FCenterPointBorderColor, write=SetCenterPointBorderColor, default=536870911};
	__property Graphics::TColor CenterPointOuterBorderColor = {read=FCenterPointOuterBorderColor, write=SetCenterPointOuterBorderColor, default=536870911};
	__property Graphics::TColor CenterPointColor = {read=FCenterPointColor, write=SetCenterPointColor, default=0};
	__property System::Byte CenterPointSize = {read=FCenterPointSize, write=SetCenterPointSize, default=4};
	__property Graphics::TFont* HourFont = {read=FHourFont, write=SetHourFont};
	__property Graphics::TColor HourColor = {read=FHourColor, write=SetHourColor, default=0};
	__property System::Byte HourMarkLength = {read=FHourMarkLength, write=SetHourMarkLength, default=0};
	__property System::Byte HourMarkWidth = {read=FHourMarkWidth, write=SetHourMarkWidth, default=1};
	__property THourMarkStyle HourMarkStyle = {read=FHourMarkStyle, write=SetHourMarkStyle, default=0};
	__property Graphics::TColor HourPointer = {read=FHourPointer, write=SetHourPointer, nodefault};
	__property Graphics::TColor HourPointerShadow = {read=FHourPointerShadow, write=SetHourPointerShadow, nodefault};
	__property System::Byte HourPointerSize = {read=FHourPointerSize, write=SetHourPointerSize, default=4};
	__property Graphics::TColor MinuteColor = {read=FMinuteColor, write=SetMinuteColor, default=8421504};
	__property Graphics::TColor MinutePointer = {read=FMinutePointer, write=SetMinutePointer, default=0};
	__property Graphics::TColor MinutePointerShadow = {read=FMinutePointerShadow, write=SetMinutePointerShadow, nodefault};
	__property System::Byte MinutePointerSize = {read=FMinutePointerSize, write=SetMinutePointerSize, default=3};
	__property System::Byte MinuteMarkLength = {read=FMinuteMarkLength, write=SetMinuteMarkLength, default=0};
	__property System::Byte MinuteMarkWidth = {read=FMinuteMarkWidth, write=SetMinuteMarkWidth, default=1};
	__property Graphics::TPicture* Picture = {read=FPicture, write=SetPicture};
	__property TPointerStyle PointerStyle = {read=FPointerStyle, write=SetPointerStyle, default=0};
	__property Graphics::TColor SecondPointer = {read=FSecondPointer, write=SetSecondPointer, default=255};
	__property System::Byte SecondPointerSize = {read=FSecondPointerSize, write=SetSecondPointerSize, default=1};
	__property TWatchShape Shape = {read=FWatchShape, write=SetWatchShape, default=0};
	__property int Size = {read=FSize, write=SetSize, default=0};
	__property TTickMarks TickMarks = {read=FTickMarks, write=SetTickMarks, default=0};
};


class DELPHICLASS TWatchSettings;
class PASCALIMPLEMENTATION TWatchSettings : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FAuto;
	bool FSeconds;
	int FTimeOffset;
	Classes::TNotifyEvent FOnChange;
	void __fastcall SetAuto(const bool Value);
	void __fastcall SetTimeOffset(const int Value);
	void __fastcall SetSeconds(const bool Value);
	
protected:
	void __fastcall Changed(void);
	
public:
	__fastcall TWatchSettings(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
__published:
	__property bool Auto = {read=FAuto, write=SetAuto, default=0};
	__property int TimeOffset = {read=FTimeOffset, write=SetTimeOffset, default=0};
	__property bool Second = {read=FSeconds, write=SetSeconds, default=1};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TWatchSettings(void) { }
	
};


class DELPHICLASS TAdvWatch;
class PASCALIMPLEMENTATION TAdvWatch : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	TWatchAppearance* FAppearance;
	TWatchSettings* FSettings;
	System::TDateTime FTime;
	Graphics::TBitmap* FBKGCache;
	System::Word FOldHour;
	System::Word FOldMinute;
	System::Word FOldSecond;
	Extctrls::TTimer* FWatchTimer;
	bool FAnimation;
	int FAnimationFactor;
	Extctrls::TTimer* FAnimationTimer;
	System::Byte FCurrentHourTo;
	System::Byte FCurrentMinuteTo;
	System::Byte FMinuteFrom;
	bool FHourAnimating;
	bool FInternalCall;
	bool FAM;
	bool FShowAMPM;
	bool FShowNumbers;
	Classes::TNotifyEvent FOnChange;
	bool FInternalSet;
	MESSAGE void __fastcall WMTimer(Messages::TWMTimer &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Message);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMSetCursor(Messages::TWMSetCursor &Message);
	void __fastcall OnAppearanceChanged(System::TObject* Sender);
	void __fastcall OnSettingsChanged(System::TObject* Sender);
	void __fastcall OnWatchTimerTime(System::TObject* Sender);
	void __fastcall OnAnimationTimerTime(System::TObject* Sender);
	void __fastcall SetAppearance(const TWatchAppearance* Value);
	void __fastcall SetSettings(const TWatchSettings* Value);
	void __fastcall SetTime(const System::TDateTime Value);
	void __fastcall SetTimeDirect(System::TDateTime Value);
	void __fastcall SetAnimation(const bool Value);
	void __fastcall SetAnimationFactor(const int Value);
	void __fastcall SetAM(bool Value);
	void __fastcall SetShowAMPM(bool Value);
	void __fastcall SetShowNumbers(bool Value);
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	void __fastcall UpdateCache(void);
	void __fastcall DrawBackground(Advgdip::TGPGraphics* g, Graphics::TCanvas* aCanvas, const Types::TRect &R);
	void __fastcall DrawTickMarks(Advgdip::TGPGraphics* g, Graphics::TCanvas* aCanvas);
	void __fastcall DrawNumbers(Advgdip::TGPGraphics* g, Graphics::TCanvas* aCanvas);
	void __fastcall DrawContent(Advgdip::TGPGraphics* g, Graphics::TCanvas* aCanvas);
	void __fastcall DrawAMPM(Advgdip::TGPGraphics* g, Graphics::TCanvas* aCanvas);
	void __fastcall DrawNeedles(Advgdip::TGPGraphics* g, Graphics::TCanvas* aCanvas);
	void __fastcall RepaintTime(void);
	double __fastcall GetRadius(void);
	Types::TRect __fastcall GetWatchRect(void);
	int __fastcall GetWatchBorderWidth(void);
	Types::TRect __fastcall GetInnerRect(void);
	Types::TRect __fastcall GetAMPMRect(void);
	Types::TPoint __fastcall GetCenterPoint(void);
	int __fastcall GetXYToHour(int X, int Y);
	int __fastcall GetXYToMinute(int X, int Y);
	System::TDateTime __fastcall GetDisplayTime(void);
	void __fastcall InvalidateWatch(void);
	void __fastcall HandleKey(System::WideChar Key);
	__property bool AM = {read=FAM, write=SetAM, nodefault};
	
public:
	__fastcall virtual TAdvWatch(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvWatch(void);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	void __fastcall SetMinute(System::Byte Value);
	void __fastcall SetHour(System::Byte Value);
	
__published:
	__property bool Animation = {read=FAnimation, write=SetAnimation, default=1};
	__property int AnimationFactor = {read=FAnimationFactor, write=SetAnimationFactor, default=10};
	__property TWatchAppearance* Appearance = {read=FAppearance, write=SetAppearance};
	__property TWatchSettings* Settings = {read=FSettings, write=SetSettings};
	__property System::TDateTime Time = {read=FTime, write=SetTime};
	__property bool ShowAMPM = {read=FShowAMPM, write=SetShowAMPM, default=1};
	__property bool ShowNumbers = {read=FShowNumbers, write=SetShowNumbers, default=1};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvWatch(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
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


typedef void __fastcall (__closure *TTimeChangeEvent)(System::TObject* Sender, int Hour, int Min, int Sec);

class DELPHICLASS TAdvTimePickerDropDown;
class PASCALIMPLEMENTATION TAdvTimePickerDropDown : public Advdropdown::TAdvCustomDropDown
{
	typedef Advdropdown::TAdvCustomDropDown inherited;
	
private:
	bool FShowTimePicker;
	TAdvWatch* FAdvWatch;
	Comctrls::TDateTimePicker* FDateTimePicker;
	Extctrls::TPanel* FPanelCtrl;
	TWatchAppearance* FWatchAppearance;
	bool FShowWatchAMPM;
	bool FShowWatchNumbers;
	bool FAnimation;
	int FAnimationFactor;
	System::TDateTime FTime;
	TWatchSettings* FWatchSettings;
	Classes::TNotifyEvent FOnTimeChange;
	bool FInternalCall;
	bool FShowSeconds;
	void __fastcall OnWatchAppearanceChange(System::TObject* Sender);
	void __fastcall SetWatchAppearance(const TWatchAppearance* Value);
	void __fastcall OnAdvWatchChange(System::TObject* Sender);
	void __fastcall OnDateTimePickerChange(System::TObject* Sender);
	void __fastcall SetTime(const System::TDateTime Value);
	void __fastcall SetWatchSettings(const TWatchSettings* Value);
	void __fastcall OnDateTimePickerKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall OnDateTimePickerKeyUp(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall OnDateTimePickerKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall SetMinute(System::Byte Value);
	void __fastcall SetHour(System::Byte Value);
	void __fastcall SetSecond(System::Byte Value);
	System::UnicodeString __fastcall GetFormattedTimeString(System::Word h, System::Word m, System::Word s);
	void __fastcall SetShowSeconds(const bool Value);
	
protected:
	virtual void __fastcall CreateDropDownForm(void);
	virtual void __fastcall BeforeDropDown(void);
	virtual void __fastcall OnHideDropDown(void);
	virtual void __fastcall UpdateDropDownSize(void);
	virtual void __fastcall OnDropDownFormKeyPress(System::WideChar &Key);
	virtual void __fastcall OnDropDownFormKeyDown(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall OnDropDownFormKeyUp(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall DoHideDropDown(bool Canceled);
	virtual void __fastcall SetText(System::UnicodeString Value);
	DYNAMIC void __fastcall Change(void);
	virtual void __fastcall OnDropDownControlKeyDown(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall OnDropDownControlKeyUp(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall OnDropDownControlKeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	
public:
	__fastcall virtual TAdvTimePickerDropDown(Classes::TComponent* AOwner);
	virtual void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	__fastcall virtual ~TAdvTimePickerDropDown(void);
	
__published:
	__property bool Animation = {read=FAnimation, write=FAnimation, default=1};
	__property int AnimationFactor = {read=FAnimationFactor, write=FAnimationFactor, default=10};
	__property TWatchSettings* WatchSettings = {read=FWatchSettings, write=SetWatchSettings};
	__property System::TDateTime Time = {read=FTime, write=SetTime};
	__property bool ShowWatchAMPM = {read=FShowWatchAMPM, write=FShowWatchAMPM, default=1};
	__property bool ShowWatchNumbers = {read=FShowWatchNumbers, write=FShowWatchNumbers, default=1};
	__property bool ShowTimePicker = {read=FShowTimePicker, write=FShowTimePicker, default=0};
	__property TWatchAppearance* WatchAppearance = {read=FWatchAppearance, write=SetWatchAppearance};
	__property bool ShowSeconds = {read=FShowSeconds, write=SetShowSeconds, default=1};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BevelEdges = {default=15};
	__property BevelInner = {index=0, default=2};
	__property BevelKind = {default=0};
	__property BevelOuter = {index=1, default=1};
	__property BevelWidth = {default=1};
	__property BiDiMode;
	__property BorderStyle = {default=1};
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D;
	__property ImeMode = {default=3};
	__property ImeName;
	__property MaxLength = {default=0};
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Visible = {default=1};
	__property DropDownColor = {default=16777215};
	__property DropDownBorderColor = {default=0};
	__property DropDownBorderWidth = {default=1};
	__property DropDownShadow = {default=1};
	__property DropDownWidth = {default=0};
	__property DropDownHeight = {default=0};
	__property DropPosition = {default=0};
	__property DropDownButtonWidth = {default=17};
	__property DropDownButtonHint;
	__property DropDownButtonGlyph;
	__property DropDownSizeable = {default=1};
	__property EditorEnabled = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property Images;
	__property Version;
	__property ButtonAppearance;
	__property DropDownHeader;
	__property DropDownFooter;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property TabStop = {default=1};
	__property TabOrder = {default=-1};
	__property Classes::TNotifyEvent OnTimeChange = {read=FOnTimeChange, write=FOnTimeChange};
	__property OnEnter;
	__property OnExit;
	__property OnChange;
	__property OnClick;
	__property OnDblClick;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnBeforeDropDown;
	__property OnDropDown;
	__property OnDropUp;
	__property OnDropDownHeaderButtonClick;
	__property OnDropDownFooterButtonClick;
	__property OnDrawHeader;
	__property OnDrawFooter;
	__property OnGetHeaderText;
	__property OnGetFooterText;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvTimePickerDropDown(HWND ParentWindow) : Advdropdown::TAdvCustomDropDown(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Advtimepickerdropdown */
using namespace Advtimepickerdropdown;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvtimepickerdropdownHPP
