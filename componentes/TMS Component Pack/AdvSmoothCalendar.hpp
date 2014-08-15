// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsmoothcalendar.pas' rev: 21.00

#ifndef AdvsmoothcalendarHPP
#define AdvsmoothcalendarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Dateutils.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsmoothcalendar
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TWinCtrl;
class PASCALIMPLEMENTATION TWinCtrl : public Controls::TWinControl
{
	typedef Controls::TWinControl inherited;
	
public:
	void __fastcall PaintCtrls(HDC DC, Controls::TControl* First);
public:
	/* TWinControl.Create */ inline __fastcall virtual TWinCtrl(Classes::TComponent* AOwner) : Controls::TWinControl(AOwner) { }
	/* TWinControl.CreateParented */ inline __fastcall TWinCtrl(HWND ParentWindow) : Controls::TWinControl(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TWinCtrl(void) { }
	
};


#pragma option push -b-
enum TAdvSmoothCalendarCaptionLocation { cpTopLeft, cpTopRight, cpTopCenter, cpCenterLeft, cpCenterRight, cpCenterCenter, cpBottomLeft, cpBottomRight, cpBottomCenter, cpCustom };
#pragma option pop

class DELPHICLASS TAdvSmoothCalendarHeader;
class DELPHICLASS TAdvSmoothCalendar;
class PASCALIMPLEMENTATION TAdvSmoothCalendarHeader : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothCalendar* FOwner;
	TAdvSmoothCalendarCaptionLocation FCaptionPosition;
	Graphics::TFont* FFont;
	int FHeight;
	Classes::TNotifyEvent FOnChange;
	bool FVisible;
	int FCaptionTop;
	int FCaptionLeft;
	Gdipfill::TGDIPFill* FFill;
	bool FArrowsVisible;
	Graphics::TColor FArrowColor;
	int FArrowSize;
	void __fastcall SetCaptionLeft(const int Value);
	void __fastcall SetCaptionPosition(const TAdvSmoothCalendarCaptionLocation Value);
	void __fastcall SetCaptionTop(const int Value);
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetArrowColor(const Graphics::TColor Value);
	void __fastcall SetArrowsVisible(const bool Value);
	void __fastcall SetArrowSize(const int Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall FillChanged(System::TObject* Sender);
	int __fastcall GetHeight(void);
	
public:
	__fastcall TAdvSmoothCalendarHeader(TAdvSmoothCalendar* AOwner);
	__fastcall virtual ~TAdvSmoothCalendarHeader(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property Graphics::TColor ArrowColor = {read=FArrowColor, write=SetArrowColor, default=16777215};
	__property bool ArrowsVisible = {read=FArrowsVisible, write=SetArrowsVisible, default=1};
	__property int ArrowSize = {read=FArrowSize, write=SetArrowSize, default=10};
	__property int Height = {read=FHeight, write=SetHeight, default=25};
	__property TAdvSmoothCalendarCaptionLocation CaptionPosition = {read=FCaptionPosition, write=SetCaptionPosition, default=5};
	__property int CaptionLeft = {read=FCaptionLeft, write=SetCaptionLeft, default=0};
	__property int CaptionTop = {read=FCaptionTop, write=SetCaptionTop, default=0};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
};


class DELPHICLASS TAdvSmoothCalendarFooter;
class PASCALIMPLEMENTATION TAdvSmoothCalendarFooter : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothCalendar* FOwner;
	int FCaptionTop;
	int FCaptionLeft;
	TAdvSmoothCalendarCaptionLocation FCaptionPosition;
	Graphics::TFont* FFont;
	bool FVisible;
	bool FCurrentDateCaption;
	System::UnicodeString FCurrentDateFormat;
	Gdipfill::TGDIPFill* FFill;
	int FHeight;
	Classes::TNotifyEvent FOnChange;
	System::UnicodeString FCaption;
	void __fastcall SetCaptionLeft(const int Value);
	void __fastcall SetCaptionPosition(const TAdvSmoothCalendarCaptionLocation Value);
	void __fastcall SetCaptionTop(const int Value);
	void __fastcall SetCurrentDateCaption(const bool Value);
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetCurrentDateFormat(const System::UnicodeString Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall FillChanged(System::TObject* Sender);
	int __fastcall GetHeight(void);
	
public:
	__fastcall TAdvSmoothCalendarFooter(TAdvSmoothCalendar* AOwner);
	__fastcall virtual ~TAdvSmoothCalendarFooter(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property int Height = {read=FHeight, write=SetHeight, default=25};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property TAdvSmoothCalendarCaptionLocation CaptionPosition = {read=FCaptionPosition, write=SetCaptionPosition, default=5};
	__property int CaptionLeft = {read=FCaptionLeft, write=SetCaptionLeft, default=0};
	__property int CaptionTop = {read=FCaptionTop, write=SetCaptionTop, default=0};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property bool CurrentDateCaption = {read=FCurrentDateCaption, write=SetCurrentDateCaption, default=1};
	__property System::UnicodeString CurrentDateFormat = {read=FCurrentDateFormat, write=SetCurrentDateFormat};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TAdvSmoothCalendarDateWeekNumbers;
class DELPHICLASS TAdvSmoothCalendarDateAppearance;
class PASCALIMPLEMENTATION TAdvSmoothCalendarDateWeekNumbers : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothCalendarDateAppearance* FOwner;
	Graphics::TFont* FFont;
	bool FVisible;
	Gdipfill::TGDIPFill* FFill;
	Classes::TNotifyEvent FOnChange;
	int FWidth;
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetWidth(const int Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall FillChanged(System::TObject* Sender);
	
public:
	__fastcall TAdvSmoothCalendarDateWeekNumbers(TAdvSmoothCalendarDateAppearance* AOwner);
	__fastcall virtual ~TAdvSmoothCalendarDateWeekNumbers(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall AssignVisuals(Classes::TPersistent* Source);
	int __fastcall GetWidth(void);
	
__published:
	__property bool Visible = {read=FVisible, write=SetVisible, default=0};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property int Width = {read=FWidth, write=SetWidth, default=30};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


#pragma option push -b-
enum TAdvSmoothCalendarStartDay { Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday };
#pragma option pop

class PASCALIMPLEMENTATION TAdvSmoothCalendarDateAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothCalendar* FOwner;
	Gdipfill::TGDIPFill* FDayOfWeekFill;
	Graphics::TFont* FSelectedDateFont;
	Graphics::TFont* FDateFont;
	Gdipfill::TGDIPFill* FSelectedDateFill;
	Graphics::TFont* FCurrentDateFont;
	Graphics::TFont* FHoverDateFont;
	Gdipfill::TGDIPFill* FDateFill;
	Gdipfill::TGDIPFill* FCurrentDateFill;
	Gdipfill::TGDIPFill* FHoverDateFill;
	Graphics::TFont* FDayOfWeekFont;
	Classes::TNotifyEvent FOnChange;
	TAdvSmoothCalendarDateWeekNumbers* FWeekNumbers;
	Graphics::TFont* FMonthFont;
	Graphics::TFont* FYearFont;
	TAdvSmoothCalendarStartDay FStartDay;
	Graphics::TFont* FDisabledDateFont;
	Gdipfill::TGDIPFill* FDisabledDateFill;
	Graphics::TFont* FWeekendFont;
	Gdipfill::TGDIPFill* FWeekendFill;
	bool FShowDaysBefore;
	bool FShowDaysAfter;
	Gdipfill::TGDIPFill* FDateBeforeFill;
	Gdipfill::TGDIPFill* FDateAfterFill;
	Graphics::TFont* FDateAfterFont;
	Graphics::TFont* FDateBeforeFont;
	void __fastcall SetCurrentDateFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetCurrentDateFont(const Graphics::TFont* Value);
	void __fastcall SetDateFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetDateFont(const Graphics::TFont* Value);
	void __fastcall SetDayOfWeekFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetDayOfWeekFont(const Graphics::TFont* Value);
	void __fastcall SetHoverDateFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetHoverDateFont(const Graphics::TFont* Value);
	void __fastcall SetSelectedDateFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetSelectedDateFont(const Graphics::TFont* Value);
	void __fastcall SetWeekNumbers(const TAdvSmoothCalendarDateWeekNumbers* Value);
	void __fastcall SetMonthFont(const Graphics::TFont* Value);
	void __fastcall SetYearFont(const Graphics::TFont* Value);
	void __fastcall SetStartDay(const TAdvSmoothCalendarStartDay Value);
	void __fastcall SetDisabledDateFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetDisabledDateFont(const Graphics::TFont* Value);
	void __fastcall SetWeekendFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetWeekendFont(const Graphics::TFont* Value);
	void __fastcall SetShowDaysAfter(const bool Value);
	void __fastcall SetShowDaysBefore(const bool Value);
	void __fastcall SetDateAfterFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetDateBeforeFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetDateAfterFont(const Graphics::TFont* Value);
	void __fastcall SetDateBeforeFont(const Graphics::TFont* Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall WeekNumbersChanged(System::TObject* Sender);
	
public:
	__fastcall TAdvSmoothCalendarDateAppearance(TAdvSmoothCalendar* AOwner);
	__fastcall virtual ~TAdvSmoothCalendarDateAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall AssignVisuals(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TFont* DateFont = {read=FDateFont, write=SetDateFont};
	__property Gdipfill::TGDIPFill* DateFill = {read=FDateFill, write=SetDateFill};
	__property Graphics::TFont* DayOfWeekFont = {read=FDayOfWeekFont, write=SetDayOfWeekFont};
	__property Gdipfill::TGDIPFill* DayOfWeekFill = {read=FDayOfWeekFill, write=SetDayOfWeekFill};
	__property Graphics::TFont* SelectedDateFont = {read=FSelectedDateFont, write=SetSelectedDateFont};
	__property Gdipfill::TGDIPFill* SelectedDateFill = {read=FSelectedDateFill, write=SetSelectedDateFill};
	__property Graphics::TFont* CurrentDateFont = {read=FCurrentDateFont, write=SetCurrentDateFont};
	__property Gdipfill::TGDIPFill* CurrentDateFill = {read=FCurrentDateFill, write=SetCurrentDateFill};
	__property Gdipfill::TGDIPFill* WeekendFill = {read=FWeekendFill, write=SetWeekendFill};
	__property Graphics::TFont* WeekendFont = {read=FWeekendFont, write=SetWeekendFont};
	__property Graphics::TFont* HoverDateFont = {read=FHoverDateFont, write=SetHoverDateFont};
	__property Gdipfill::TGDIPFill* HoverDateFill = {read=FHoverDateFill, write=SetHoverDateFill};
	__property Graphics::TFont* MonthDateFont = {read=FMonthFont, write=SetMonthFont};
	__property Graphics::TFont* YearDateFont = {read=FYearFont, write=SetYearFont};
	__property TAdvSmoothCalendarDateWeekNumbers* WeekNumbers = {read=FWeekNumbers, write=SetWeekNumbers};
	__property TAdvSmoothCalendarStartDay StartDay = {read=FStartDay, write=SetStartDay, default=0};
	__property Graphics::TFont* DisabledDateFont = {read=FDisabledDateFont, write=SetDisabledDateFont};
	__property Gdipfill::TGDIPFill* DisabledDateFill = {read=FDisabledDateFill, write=SetDisabledDateFill};
	__property bool ShowDaysBefore = {read=FShowDaysBefore, write=SetShowDaysBefore, default=0};
	__property bool ShowDaysAfter = {read=FShowDaysAfter, write=SetShowDaysAfter, default=0};
	__property Gdipfill::TGDIPFill* DateBeforeFill = {read=FDateBeforeFill, write=SetDateBeforeFill};
	__property Gdipfill::TGDIPFill* DateAfterFill = {read=FDateAfterFill, write=SetDateAfterFill};
	__property Graphics::TFont* DateBeforeFont = {read=FDateBeforeFont, write=SetDateBeforeFont};
	__property Graphics::TFont* DateAfterFont = {read=FDateAfterFont, write=SetDateAfterFont};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


typedef DynamicArray<System::TDateTime> TDisjunctDateTimeArray;

#pragma option push -b-
enum TAdvSmoothCalendarDateRange { drSingledate, drMultiDates };
#pragma option pop

#pragma option push -b-
enum TAdvSmoothCalendarDateKind { dkNormal, dkWeekend, dkCurrent, dkDisabled, dkHovered, dkSelected };
#pragma option pop

#pragma option push -b-
enum TAdvSmoothCalendarDateMode { dmDay, dmMonth, dmYear };
#pragma option pop

typedef void __fastcall (__closure *TAdvSmoothCalendarBeforeDateSelectedEvent)(System::TObject* Sender, TAdvSmoothCalendarDateMode Mode, System::TDateTime Date, bool &AllowChange);

typedef void __fastcall (__closure *TAdvSmoothCalendarDateSelectedEvent)(System::TObject* Sender, TAdvSmoothCalendarDateMode Mode, System::TDateTime Date);

typedef void __fastcall (__closure *TAdvSmoothCalendarMultiDateSelectedEvent)(System::TObject* Sender, TAdvSmoothCalendarDateMode Mode, System::TDateTime StartDate, System::TDateTime EndDate);

typedef void __fastcall (__closure *TAdvSmoothCalendarDisjunctDateSelectedEvent)(System::TObject* Sender, TAdvSmoothCalendarDateMode Mode, TDisjunctDateTimeArray DisjunctDates);

typedef void __fastcall (__closure *TAdvSmoothCalendarDateModeChangedEvent)(System::TObject* Sender, TAdvSmoothCalendarDateMode Mode, TAdvSmoothCalendarDateMode ModeTo, bool &allow);

typedef void __fastcall (__closure *TAdvSmoothCalendarMonthChangedEvent)(System::TObject* Sender, int Month);

typedef void __fastcall (__closure *TAdvSmoothCalendarYearChangedEvent)(System::TObject* Sender, int Year);

typedef void __fastcall (__closure *TAdvSmoothCalendarYearRangeChangedEvent)(System::TObject* Sender, int YearFrom, int YearTo);

typedef void __fastcall (__closure *TAdvSmoothCalendarCurrentDayClickEvent)(System::TObject* Sender, bool &Allow);

typedef void __fastcall (__closure *TAdvSmoothCalendarDateHintEvent)(System::TObject* Sender, System::TDateTime Date, System::UnicodeString &hint);

typedef void __fastcall (__closure *TAdvSmoothCalendarDateFillEvent)(System::TObject* Sender, Gdipfill::TGDIPFill* AFill, Graphics::TFont* AFont, System::TDateTime Date, TAdvSmoothCalendarDateKind DateKind);

typedef void __fastcall (__closure *TAdvSmoothCalendarDateTextEvent)(System::TObject* Sender, System::TDateTime Date, Graphics::TFont* AFont, System::UnicodeString &AText);

#pragma option push -b-
enum TAdvSmoothCalendarForceDateMode { fdNone, fdDay, fdMonth, fdYear };
#pragma option pop

typedef void __fastcall (__closure *TAdvSmoothCalendarGetDateStatusEvent)(System::TObject* Sender, System::TDateTime Date, System::UnicodeString &StatusMessage, Gdipfill::TGDIPStatus* Fill, int &OffsetX, int &OffsetY);

typedef void __fastcall (__closure *TAdvSmoothCalendarStatusClickEvent)(System::TObject* Sender, System::UnicodeString StatusMessage, System::TDateTime Date);

typedef void __fastcall (__closure *TAdvSmoothCalendarDrawDayEvent)(System::TObject* Sender, System::TDateTime Date, bool &Allow);

struct TDateStatus
{
	
public:
	System::TDateTime Date;
	System::UnicodeString Text;
	bool Found;
};


class PASCALIMPLEMENTATION TAdvSmoothCalendar : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	typedef DynamicArray<Advgdip::TGPRectF> _TAdvSmoothCalendar__1;
	
	
private:
	TDisjunctDateTimeArray FDisjunctDays;
	Comctrls::TUpDown* FUpDown;
	int FMx;
	int FMy;
	bool FMultiDateSet;
	bool FMouseDown;
	bool FFocused;
	bool FDesignTime;
	_TAdvSmoothCalendar__1 arrMulti;
	int FRows;
	TAdvSmoothCalendarDateMode FTempDateMode;
	TAdvSmoothCalendarDateMode FDateMode;
	bool FAnimateDateMode;
	bool FAnimateDayOpc;
	bool FAnimateOpacity;
	bool FAnimate;
	bool Fanimating;
	float FStartPos;
	float FCurrentPos;
	float FPosTo;
	System::Byte FYearOpc;
	System::Byte FYearOpcTo;
	System::Byte FDayOpc;
	System::Byte FDayOpcTo;
	System::Byte FMonthOpc;
	System::Byte FMonthOpcTo;
	System::Byte FWeekNumberOpc;
	System::Byte FWeekNumberOpcTo;
	Extctrls::TTimer* FAnimateTimer;
	System::TDateTime FStartDate;
	System::TDateTime FEndDate;
	TAdvSmoothCalendarDateRange FSelectedDateRange;
	System::TDateTime FHoverDate;
	System::TDateTime FFocusDate;
	System::TDateTime FSelectedDate;
	System::TDateTime FCurrentDate;
	Gdipfill::TGDIPFill* FFill;
	bool FTransparent;
	TAdvSmoothCalendarHeader* FHeader;
	int FNextYearFrom;
	int FNextYearTo;
	int FCurrentYearFrom;
	int FCurrentYearTo;
	int FNextYear;
	int FCurrentYear;
	int FYear;
	int FNextMonth;
	int FCurrentMonth;
	int FMonth;
	int FCurrentDay;
	TAdvSmoothCalendarDateAppearance* FDateAppearance;
	TAdvSmoothCalendarFooter* FFooter;
	bool FAnimation;
	TAdvSmoothCalendarDateSelectedEvent FOnSelectDate;
	TAdvSmoothCalendarDateModeChangedEvent FOnDateModeChanged;
	TAdvSmoothCalendarYearChangedEvent FOnYearChanged;
	TAdvSmoothCalendarMonthChangedEvent FOnMonthChanged;
	TAdvSmoothCalendarYearRangeChangedEvent FOnYearRangeChanged;
	bool FShowFocus;
	Graphics::TColor FFocusColor;
	bool FMultiSelect;
	TAdvSmoothCalendarMultiDateSelectedEvent FOnSelectMultiDate;
	bool FShowCurrentDate;
	bool FKeyBoardDateModeToggle;
	TAdvSmoothCalendarCurrentDayClickEvent FOnCurrentDayClick;
	System::TDate FMaxDate;
	System::TDate FMinDate;
	TAdvSmoothCalendarDateFillEvent FOnDateFill;
	TAdvSmoothCalendarDateHintEvent FOnDateHint;
	Gdipfill::TGDIPStatus* FStatusAppearance;
	TAdvSmoothCalendarGetDateStatusEvent FOnDateStatus;
	TAdvSmoothCalendarDateTextEvent FOnDateText;
	TAdvSmoothCalendarBeforeDateSelectedEvent FOnBeforeSelectDate;
	Classes::TNotifyEvent FOnChange;
	bool FDisjunctDaySelect;
	TAdvSmoothCalendarDisjunctDateSelectedEvent FOnSelectDisjunctDate;
	TAdvSmoothCalendarStatusClickEvent FOnDateStatusClick;
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Message);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetTransparent(const bool Value);
	void __fastcall SetHeader(const TAdvSmoothCalendarHeader* Value);
	void __fastcall SetMonth(const int Value);
	void __fastcall SetYear(const int Value);
	void __fastcall SetDateAppearance(const TAdvSmoothCalendarDateAppearance* Value);
	void __fastcall SetFooter(const TAdvSmoothCalendarFooter* Value);
	void __fastcall SetAnimation(const bool Value);
	void __fastcall SetShowFocus(const bool Value);
	void __fastcall SetFocusColor(const Graphics::TColor Value);
	void __fastcall SetMultiSelect(const bool Value);
	void __fastcall SetEndDate(const System::TDateTime Value);
	void __fastcall SetSelectedDate(const System::TDateTime Value);
	void __fastcall SetStartDate(const System::TDateTime Value);
	void __fastcall SetHoveredDate(const System::TDateTime Value);
	void __fastcall SetShowCurrentDate(const bool Value);
	void __fastcall SetKeyBoardDateModeToggle(const bool Value);
	bool __fastcall DoStoreMaxDate(void);
	bool __fastcall DoStoreMinDate(void);
	void __fastcall SetMaxDate(const System::TDate Value);
	void __fastcall SetMinDate(const System::TDate Value);
	void __fastcall SetStatusAppearance(const Gdipfill::TGDIPStatus* Value);
	int __fastcall GetMonth(void);
	int __fastcall GetYear(void);
	void __fastcall SetDisjunctDaySelect(const bool Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	void __fastcall UpDownChange(System::TObject* Sender, bool &AllowChange, short NewValue, Comctrls::TUpDownDirection Direction);
	void __fastcall DoGetDayStatus(System::TObject* Sender, System::TDateTime Date, System::UnicodeString &StatusMessage, Gdipfill::TGDIPStatus* Fill, int &OffsetX, int &OffsetY);
	void __fastcall DoChangeMode(System::TObject* Sender, TAdvSmoothCalendarDateMode Mode, TAdvSmoothCalendarDateMode ModeTo, bool &allow);
	void __fastcall DoSelectDate(System::TObject* Sender, TAdvSmoothCalendarDateMode Mode, System::TDateTime Date);
	void __fastcall DoSelectMultiDate(System::TObject* Sender, TAdvSmoothCalendarDateMode Mode, System::TDateTime StartDate, System::TDateTime EndDate);
	void __fastcall DoSelectDisjunctDate(System::TObject* Sender, TAdvSmoothCalendarDateMode Mode, TDisjunctDateTimeArray DisjunctDates);
	void __fastcall DoCurrentDateClick(System::TObject* Sender, bool &allow);
	void __fastcall DoChangeMonth(System::TObject* Sender, int Month);
	void __fastcall DoChangeYear(System::TObject* Sender, int Year);
	void __fastcall DoChangeYearRange(System::TObject* Sender, int YearFrom, int YearTo);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall HeaderChanged(System::TObject* Sender);
	void __fastcall FooterChanged(System::TObject* Sender);
	void __fastcall DateAppearanceChanged(System::TObject* Sender);
	void __fastcall StatusAppearanceChanged(System::TObject* Sender);
	void __fastcall AnimateCal(System::TObject* Sender);
	void __fastcall AnimateMode(System::Byte &opcModeStart, System::Byte opcModeStartTo);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall Resize(void);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Message);
	void __fastcall InitPreview(void);
	Types::TRect __fastcall InsideRect(void);
	Types::TRect __fastcall GetArrowRect(bool left);
	Advgdip::TGPRectF __fastcall GetDateValuesRect(void);
	Types::TRect __fastcall GetFooterCaptionRect(void);
	Advgdip::TGPRectF __fastcall GetWeekDaysRect(void);
	Types::TRect __fastcall GetHeaderCaptionRect(void);
	int __fastcall GetCountRows(void);
	int __fastcall GetVersionNr(void);
	double __fastcall GetCellWidth(void);
	double __fastcall GetCellHeight(void);
	int __fastcall GetShadowOffset(void);
	bool __fastcall IsWeekendDay(System::TDateTime date);
	System::TDateTime __fastcall GetDate(int day, int dim);
	bool __fastcall IsDisjunctDate(System::TDateTime Date);
	bool __fastcall RemoveDateIfSelect(System::TDateTime Date);
	TDateStatus __fastcall IndicatorAtXY(int X, int Y);
	
public:
	__fastcall virtual TAdvSmoothCalendar(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSmoothCalendar(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall Paint(void);
	void __fastcall DrawBackGround(void);
	void __fastcall DrawHeader(void);
	void __fastcall DrawFooter(void);
	void __fastcall DrawDayOfWeek(void);
	void __fastcall DrawWeekNumbers(void);
	void __fastcall DrawArrow(bool left);
	void __fastcall DrawDays(int Month, int Year, float XPos);
	void __fastcall DrawMonths(int Year, float XPos);
	void __fastcall DrawYears(int YearFrom, int YearTo, float XPos);
	void __fastcall PreviousDate(void);
	void __fastcall NextDate(void);
	void __fastcall ToggleMode(void);
	void __fastcall SelectDate(Classes::TShiftState Shift, System::TDateTime Date);
	int __fastcall GetDayOfWeekColumn(System::TDateTime date);
	int __fastcall GetCurrentDay(System::Word year, System::Word month);
	System::TDateTime __fastcall XYToDate(int X, int Y);
	System::TDateTime __fastcall GetStartDate(void);
	System::TDateTime __fastcall GetEndDate(void);
	__property System::TDateTime HoveredDate = {read=FHoverDate, write=SetHoveredDate};
	__property System::TDateTime EndDate = {read=GetEndDate, write=SetEndDate};
	__property System::TDateTime StartDate = {read=GetStartDate, write=SetStartDate};
	__property System::TDateTime SelectedDate = {read=FSelectedDate, write=SetSelectedDate};
	__property bool KeyBoardDateModeToggle = {read=FKeyBoardDateModeToggle, write=SetKeyBoardDateModeToggle, default=1};
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	void __fastcall SaveToTheme(System::UnicodeString FileName);
	void __fastcall LoadFromTheme(System::UnicodeString FileName);
	System::UnicodeString __fastcall GetThemeId(void);
	int __fastcall CurrentDay(void);
	int __fastcall CurrentMonth(void);
	int __fastcall CurrentYear(void);
	__property TDisjunctDateTimeArray DisjunctDates = {read=FDisjunctDays};
	
__published:
	__property bool Animation = {read=FAnimation, write=SetAnimation, default=1};
	__property int Year = {read=GetYear, write=SetYear, nodefault};
	__property int Month = {read=GetMonth, write=SetMonth, nodefault};
	__property System::TDate MaxDate = {read=FMaxDate, write=SetMaxDate, stored=DoStoreMaxDate};
	__property System::TDate MinDate = {read=FMinDate, write=SetMinDate, stored=DoStoreMinDate};
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property TAdvSmoothCalendarDateAppearance* DateAppearance = {read=FDateAppearance, write=SetDateAppearance};
	__property Gdipfill::TGDIPStatus* StatusAppearance = {read=FStatusAppearance, write=SetStatusAppearance};
	__property TAdvSmoothCalendarHeader* Header = {read=FHeader, write=SetHeader};
	__property TAdvSmoothCalendarFooter* Footer = {read=FFooter, write=SetFooter};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property TAdvSmoothCalendarDateHintEvent OnDateHint = {read=FOnDateHint, write=FOnDateHint};
	__property TAdvSmoothCalendarDateFillEvent OnDateFill = {read=FOnDateFill, write=FOnDateFill};
	__property TAdvSmoothCalendarDateTextEvent OnGetDateText = {read=FOnDateText, write=FOnDateText};
	__property TAdvSmoothCalendarBeforeDateSelectedEvent OnBeforeSelectDate = {read=FOnBeforeSelectDate, write=FOnBeforeSelectDate};
	__property TAdvSmoothCalendarDateSelectedEvent OnSelectDate = {read=FOnSelectDate, write=FOnSelectDate};
	__property TAdvSmoothCalendarMultiDateSelectedEvent OnSelectMultiDate = {read=FOnSelectMultiDate, write=FOnSelectMultiDate};
	__property TAdvSmoothCalendarDisjunctDateSelectedEvent OnSelectDisjunctDate = {read=FOnSelectDisjunctDate, write=FOnSelectDisjunctDate};
	__property TAdvSmoothCalendarDateModeChangedEvent OnDateModeChanged = {read=FOnDateModeChanged, write=FOnDateModeChanged};
	__property TAdvSmoothCalendarMonthChangedEvent OnMonthChanged = {read=FOnMonthChanged, write=FOnMonthChanged};
	__property TAdvSmoothCalendarYearChangedEvent OnYearChanged = {read=FOnYearChanged, write=FOnYearChanged};
	__property TAdvSmoothCalendarYearRangeChangedEvent OnYearRangeChanged = {read=FOnYearRangeChanged, write=FOnYearRangeChanged};
	__property TAdvSmoothCalendarCurrentDayClickEvent OnCurrentDayClick = {read=FOnCurrentDayClick, write=FOnCurrentDayClick};
	__property TAdvSmoothCalendarGetDateStatusEvent OnDateStatus = {read=FOnDateStatus, write=FOnDateStatus};
	__property TAdvSmoothCalendarStatusClickEvent OnDateStatusClick = {read=FOnDateStatusClick, write=FOnDateStatusClick};
	__property bool ShowFocus = {read=FShowFocus, write=SetShowFocus, default=1};
	__property bool ShowCurrentDate = {read=FShowCurrentDate, write=SetShowCurrentDate, default=1};
	__property Graphics::TColor FocusColor = {read=FFocusColor, write=SetFocusColor, default=0};
	__property bool MultiSelect = {read=FMultiSelect, write=SetMultiSelect, default=0};
	__property bool DisjunctDaySelect = {read=FDisjunctDaySelect, write=SetDisjunctDaySelect, default=0};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property ShowHint;
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property DragMode = {default=0};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property OnCanResize;
	__property OnConstrainedResize;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDockDrop;
	__property OnDockOver;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnGetSiteInfo;
	__property OnMouseActivate;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnResize;
	__property OnStartDock;
	__property OnStartDrag;
	__property OnUnDock;
	__property PopupMenu;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMouseDown;
	__property OnClick;
	__property OnKeyDown;
	__property OnKeyUp;
	__property OnKeyPress;
	__property OnGesture;
	__property Touch;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothCalendar(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
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


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x2;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Advsmoothcalendar */
using namespace Advsmoothcalendar;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsmoothcalendarHPP
