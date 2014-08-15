// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsmoothdatepicker.pas' rev: 21.00

#ifndef AdvsmoothdatepickerHPP
#define AdvsmoothdatepickerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Advsmootheditbutton.hpp>	// Pascal unit
#include <Advsmoothcalendar.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Advsmoothedit.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsmoothdatepicker
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvSmoothDatePickerCalendar;
class DELPHICLASS TAdvSmoothDatePicker;
class PASCALIMPLEMENTATION TAdvSmoothDatePickerCalendar : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothDatePicker* FOwner;
	Advsmoothcalendar::TAdvSmoothCalendarHeader* FHeader;
	Advsmoothcalendar::TAdvSmoothCalendarDateAppearance* FDateAppearance;
	Advsmoothcalendar::TAdvSmoothCalendarFooter* FFooter;
	Gdipfill::TGDIPFill* FFill;
	int FWidth;
	int FHeight;
	System::TDate FMaxDate;
	bool FAnimation;
	System::TDate FMinDate;
	bool FShowCurrentDate;
	Gdipfill::TGDIPStatus* FStatusAppearance;
	bool FShowHint;
	
protected:
	void __fastcall DateAppearanceChanged(System::TObject* Sender);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall FooterChanged(System::TObject* Sender);
	void __fastcall HeaderChanged(System::TObject* Sender);
	void __fastcall WidthChanged(System::TObject* Sender);
	void __fastcall HeightChanged(System::TObject* Sender);
	void __fastcall ShowCurrentDateChanged(System::TObject* Sender);
	void __fastcall StatusAppearanceChanged(System::TObject* Sender);
	void __fastcall AnimationChanged(System::TObject* Sender);
	void __fastcall MaxDateChanged(System::TObject* Sender);
	void __fastcall MinDateChanged(System::TObject* Sender);
	void __fastcall ShowHintChanged(System::TObject* Sender);
	void __fastcall Update(void);
	
public:
	__fastcall TAdvSmoothDatePickerCalendar(TAdvSmoothDatePicker* AOwner);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__fastcall virtual ~TAdvSmoothDatePickerCalendar(void);
	
__published:
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=FFill};
	__property System::TDate MinDate = {read=FMinDate, write=FMinDate};
	__property System::TDate MaxDate = {read=FMaxDate, write=FMaxDate};
	__property bool Animation = {read=FAnimation, write=FAnimation, nodefault};
	__property bool ShowCurrentDate = {read=FShowCurrentDate, write=FShowCurrentDate, nodefault};
	__property Advsmoothcalendar::TAdvSmoothCalendarDateAppearance* DateAppearance = {read=FDateAppearance, write=FDateAppearance};
	__property Gdipfill::TGDIPStatus* StatusAppearance = {read=FStatusAppearance, write=FStatusAppearance};
	__property Advsmoothcalendar::TAdvSmoothCalendarFooter* Footer = {read=FFooter, write=FFooter};
	__property Advsmoothcalendar::TAdvSmoothCalendarHeader* Header = {read=FHeader, write=FHeader};
	__property int Width = {read=FWidth, write=FWidth, nodefault};
	__property int Height = {read=FHeight, write=FHeight, nodefault};
	__property bool ShowHint = {read=FShowHint, write=FShowHint, nodefault};
};


class DELPHICLASS TDropDownForm;
class PASCALIMPLEMENTATION TDropDownForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TDropDownForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TDropDownForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TDropDownForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TDropDownForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TAdvSmoothDatePicker : public Advsmootheditbutton::TAdvSmoothEditBtn
{
	typedef Advsmootheditbutton::TAdvSmoothEditBtn inherited;
	
private:
	Extctrls::TTimer* FTimer;
	bool FDesignTime;
	Advsmoothcalendar::TAdvSmoothCalendar* FCal;
	bool FDeactivating;
	bool FIgnoreSelect;
	TDropDownForm* CalParent;
	bool CancelThisBtnClick;
	bool FHideCalendarAfterSelection;
	Advsmoothcalendar::TAdvSmoothCalendarDateSelectedEvent FOnDaySelect;
	TAdvSmoothDatePickerCalendar* FCalendar;
	Advsmoothcalendar::TAdvSmoothCalendarDateFillEvent FOnDateFill;
	Advsmoothcalendar::TAdvSmoothCalendarGetDateStatusEvent FOnDateStatus;
	Advsmoothcalendar::TAdvSmoothCalendarDateHintEvent FOnDateHint;
	Advsmoothcalendar::TAdvSmoothCalendarYearRangeChangedEvent FOnYearRangeChanged;
	Advsmoothcalendar::TAdvSmoothCalendarYearChangedEvent FOnYearChanged;
	Advsmoothcalendar::TAdvSmoothCalendarCurrentDayClickEvent FOnCurrentDayClick;
	Advsmoothcalendar::TAdvSmoothCalendarDateModeChangedEvent FOnDateModeChanged;
	Advsmoothcalendar::TAdvSmoothCalendarMonthChangedEvent FOnMonthChanged;
	System::UnicodeString FFormat;
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Message);
	void __fastcall HideParent(void);
	void __fastcall InitEvents(void);
	Controls::TWinControl* __fastcall GetParentEx(void);
	void __fastcall SetParentEx(const Controls::TWinControl* Value);
	System::TDateTime __fastcall GetDate(void);
	void __fastcall SetDate(const System::TDateTime Value);
	void __fastcall SetCalendar(const TAdvSmoothDatePickerCalendar* Value);
	void __fastcall SetFormat(const System::UnicodeString Value);
	
protected:
	virtual bool __fastcall IsDropDownVisible(void);
	virtual int __fastcall GetVersionNr(void);
	virtual void __fastcall BtnClick(System::TObject* Sender);
	void __fastcall CalParentDeactivate(System::TObject* Sender);
	void __fastcall CalendarDateFill(System::TObject* Sender, Gdipfill::TGDIPFill* AFill, Graphics::TFont* AFont, System::TDateTime Date, Advsmoothcalendar::TAdvSmoothCalendarDateKind DateKind);
	void __fastcall CalendarDateHint(System::TObject* Sender, System::TDateTime Date, System::UnicodeString &hint);
	void __fastcall CalendarDateStatus(System::TObject* Sender, System::TDateTime Date, System::UnicodeString &StatusMessage, Gdipfill::TGDIPStatus* Fill, int &OffsetX, int &OffsetY);
	void __fastcall CalendarCurrentDateClick(System::TObject* Sender, bool &allow);
	void __fastcall CalendarChangeMonth(System::TObject* Sender, int Month);
	void __fastcall CalendarChangeYear(System::TObject* Sender, int Year);
	void __fastcall CalendarChangeYearRange(System::TObject* Sender, int YearFrom, int YearTo);
	void __fastcall CalendarChangeMode(System::TObject* Sender, Advsmoothcalendar::TAdvSmoothCalendarDateMode Mode, Advsmoothcalendar::TAdvSmoothCalendarDateMode ModeTo, bool &allow);
	virtual void __fastcall CalendarDaySelect(System::TObject* Sender, Advsmoothcalendar::TAdvSmoothCalendarDateMode Mode, System::TDateTime Date);
	void __fastcall CalendarKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall CalendarKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall CalendarKeyUp(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall CreateWnd(void);
	void __fastcall TimerEvent(System::TObject* Sender);
	__property Advsmoothcalendar::TAdvSmoothCalendar* Cal = {read=FCal, write=FCal};
	
public:
	__fastcall virtual TAdvSmoothDatePicker(Classes::TComponent* AOwner);
	void __fastcall CancelBtnClick(void);
	__fastcall virtual ~TAdvSmoothDatePicker(void);
	virtual void __fastcall DropDown(void);
	__property Controls::TWinControl* Parent = {read=GetParentEx, write=SetParentEx};
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	void __fastcall SaveToTheme(System::UnicodeString FileName);
	void __fastcall LoadFromTheme(System::UnicodeString FileName);
	System::UnicodeString __fastcall GetThemeID(void);
	
__published:
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property bool HideCalendarAfterSelection = {read=FHideCalendarAfterSelection, write=FHideCalendarAfterSelection, nodefault};
	__property Advsmoothcalendar::TAdvSmoothCalendarDateSelectedEvent OnSelectDate = {read=FOnDaySelect, write=FOnDaySelect};
	__property Advsmoothcalendar::TAdvSmoothCalendarDateFillEvent OnDateFill = {read=FOnDateFill, write=FOnDateFill};
	__property Advsmoothcalendar::TAdvSmoothCalendarGetDateStatusEvent OnDateStatus = {read=FOnDateStatus, write=FOnDateStatus};
	__property Advsmoothcalendar::TAdvSmoothCalendarDateHintEvent OnDateHint = {read=FOnDateHint, write=FOnDateHint};
	__property Advsmoothcalendar::TAdvSmoothCalendarDateModeChangedEvent OnDateModeChanged = {read=FOnDateModeChanged, write=FOnDateModeChanged};
	__property Advsmoothcalendar::TAdvSmoothCalendarMonthChangedEvent OnMonthChanged = {read=FOnMonthChanged, write=FOnMonthChanged};
	__property Advsmoothcalendar::TAdvSmoothCalendarYearChangedEvent OnYearChanged = {read=FOnYearChanged, write=FOnYearChanged};
	__property Advsmoothcalendar::TAdvSmoothCalendarYearRangeChangedEvent OnYearRangeChanged = {read=FOnYearRangeChanged, write=FOnYearRangeChanged};
	__property Advsmoothcalendar::TAdvSmoothCalendarCurrentDayClickEvent OnCurrentDayClick = {read=FOnCurrentDayClick, write=FOnCurrentDayClick};
	__property System::UnicodeString Format = {read=FFormat, write=SetFormat};
	__property TAdvSmoothDatePickerCalendar* Calendar = {read=FCalendar, write=SetCalendar};
	__property System::TDateTime Date = {read=GetDate, write=SetDate};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothDatePicker(HWND ParentWindow) : Advsmootheditbutton::TAdvSmoothEditBtn(ParentWindow) { }
	
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
static const ShortInt REL_VER = 0x1;
static const ShortInt BLD_VER = 0x4;

}	/* namespace Advsmoothdatepicker */
using namespace Advsmoothdatepicker;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsmoothdatepickerHPP
