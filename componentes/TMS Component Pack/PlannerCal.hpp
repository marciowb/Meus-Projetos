// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Plannercal.pas' rev: 21.00

#ifndef PlannercalHPP
#define PlannercalHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Advimage.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Plannercal
{
//-- type declarations -------------------------------------------------------
typedef Controls::THintInfo THintInfo;

typedef Controls::PHintInfo PHintInfo;

typedef System::UnicodeString TDayStr;

typedef System::UnicodeString TMonthStr;

typedef StaticArray<System::UnicodeString, 14> TDayArray;

typedef StaticArray<System::UnicodeString, 12> TMonthArray;

#pragma option push -b-
enum TBackGroundPosition { bpTopLeft, bpTopRight, bpBottomLeft, bpBottomRight, bpTiled, bpStretched, bpCenter };
#pragma option pop

typedef void __fastcall (__closure *TDaySelectEvent)(System::TObject* Sender, System::TDateTime SelDate);

typedef void __fastcall (__closure *TDateChangeEvent)(System::TObject* Sender, System::TDateTime origDate, System::TDateTime newDate);

typedef void __fastcall (__closure *TCancelledChangeEvent)(System::TObject* Sender, System::TDateTime CancelledDate);

typedef void __fastcall (__closure *TCancelledKeyEvent)(System::TObject* Sender, System::Word Key);

typedef void __fastcall (__closure *TCellDrawEvent)(System::TObject* Sender, Graphics::TCanvas* Canvas, System::TDate Day, bool Selected, bool Marked, bool InMonth, const Types::TRect &Rect);

typedef void __fastcall (__closure *TGetDateEvent)(System::TObject* Sender, System::TDateTime dt, bool &isEvent);

typedef void __fastcall (__closure *TGetDateEventHint)(System::TObject* Sender, System::TDateTime dt, bool &isEvent, System::UnicodeString &EventHint);

#pragma option push -b-
enum TEventShape { evsRectangle, evsCircle, evsSquare, evsTriangle, evsNone };
#pragma option pop

#pragma option push -b-
enum TGradientDirection { gdHorizontal, gdVertical };
#pragma option pop

#pragma option push -b-
enum TTodayStyle { tsSunken, tsRaised, tsFlat };
#pragma option pop

#pragma option push -b-
enum TPlannerCalendarStyle { psWindowsXP, psOffice2000, psOffice2003Blue, psOffice2003Olive, psOffice2003Silver, psOffice2003Classic, psFlat, psAvantGarde, psWhidbey, psOffice2007Luna, psOffice2007Obsidian, psCustom, psOffice2007Silver, psWindowsVista, psWindows7, psTerminal, psOffice2010Blue, psOffice2010Silver, psOffice2010Black };
#pragma option pop

class DELPHICLASS TWeekDays;
class PASCALIMPLEMENTATION TWeekDays : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FSat;
	bool FSun;
	bool FMon;
	bool FTue;
	bool FWed;
	bool FThu;
	bool FFri;
	Classes::TNotifyEvent FChanged;
	void __fastcall SetSat(const bool Value);
	void __fastcall SetSun(const bool Value);
	void __fastcall SetMon(const bool Value);
	void __fastcall SetTue(const bool Value);
	void __fastcall SetWed(const bool Value);
	void __fastcall SetThu(const bool Value);
	void __fastcall SetFri(const bool Value);
	void __fastcall Changed(void);
	
public:
	__fastcall TWeekDays(void);
	
__published:
	__property bool Sat = {read=FSat, write=SetSat, default=1};
	__property bool Sun = {read=FSun, write=SetSun, default=1};
	__property bool Mon = {read=FMon, write=SetMon, default=0};
	__property bool Tue = {read=FTue, write=SetTue, default=0};
	__property bool Wed = {read=FWed, write=SetWed, default=0};
	__property bool Thu = {read=FThu, write=SetThu, default=0};
	__property bool Fri = {read=FFri, write=SetFri, default=0};
	__property Classes::TNotifyEvent OnChanged = {read=FChanged, write=FChanged};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TWeekDays(void) { }
	
};


class DELPHICLASS TSelDateItem;
class PASCALIMPLEMENTATION TSelDateItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::TDateTime FDate;
	System::UnicodeString FHint;
	Graphics::TColor FColor;
	TEventShape FEventShape;
	Graphics::TColor FFontColor;
	System::TObject* FObject;
	int FTag;
	void __fastcall SetDate(const System::TDateTime Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetEventShape(const TEventShape Value);
	HIDESBASE void __fastcall Changed(void);
	void __fastcall SetFontColor(const Graphics::TColor Value);
	void __fastcall SetHint(const System::UnicodeString Value);
	
public:
	__fastcall virtual ~TSelDateItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property System::TDateTime Date = {read=FDate, write=SetDate};
	__property System::UnicodeString Hint = {read=FHint, write=SetHint};
	__property Graphics::TColor FontColor = {read=FFontColor, write=SetFontColor, nodefault};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property TEventShape Shape = {read=FEventShape, write=SetEventShape, nodefault};
	__property System::TObject* ItemObject = {read=FObject, write=FObject};
	__property int Tag = {read=FTag, write=FTag, nodefault};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TSelDateItem(Classes::TCollection* Collection) : Classes::TCollectionItem(Collection) { }
	
};


class DELPHICLASS TEventProp;
class PASCALIMPLEMENTATION TEventProp : public TSelDateItem
{
	typedef TSelDateItem inherited;
	
public:
	/* TSelDateItem.Destroy */ inline __fastcall virtual ~TEventProp(void) { }
	
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TEventProp(Classes::TCollection* Collection) : TSelDateItem(Collection) { }
	
};


class DELPHICLASS TSelDateItems;
class DELPHICLASS TCustomCalendarPanel;
class PASCALIMPLEMENTATION TSelDateItems : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
private:
	TCustomCalendarPanel* FOwner;
	int FUpdateCount;
	Classes::TNotifyEvent FOnChange;
	bool FVisible;
	HIDESBASE TSelDateItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TSelDateItem* Value);
	void __fastcall DoPaint(void);
	TSelDateItem* __fastcall GetDate(System::TDateTime dt);
	
protected:
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	
public:
	int __fastcall IsInList(int da, int mo, int ye);
	int __fastcall IsDateInList(System::TDateTime dt);
	__fastcall TSelDateItems(TCustomCalendarPanel* AOwner);
	HIDESBASE TSelDateItem* __fastcall Add(void);
	HIDESBASE TSelDateItem* __fastcall Insert(int Index);
	__property TSelDateItem* Items[int Index] = {read=GetItem, write=SetItem};
	__property TSelDateItem* Dates[System::TDateTime dt] = {read=GetDate};
	void __fastcall AddRange(System::TDateTime dt1, System::TDateTime dt2);
	void __fastcall AddRangeSC(System::TDateTime dt1, System::TDateTime dt2, TEventShape Shp, Graphics::TColor Clr);
	void __fastcall DelRange(System::TDateTime dt1, System::TDateTime dt2);
	void __fastcall AddRangeHint(System::TDateTime dt1, System::TDateTime dt2, System::UnicodeString Hint);
	void __fastcall AddRangeHintSC(System::TDateTime dt1, System::TDateTime dt2, System::UnicodeString Hint, TEventShape Shp, Graphics::TColor Clr);
	void __fastcall StartUpdate(void);
	void __fastcall StopUpdate(void);
	void __fastcall ResetUpdate(void);
	void __fastcall RepaintDate(System::TDateTime ADate);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property bool Visible = {read=FVisible, write=FVisible, nodefault};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TSelDateItems(void) { }
	
};


typedef void __fastcall (__closure *TEventPropEvent)(System::TObject* Sender, System::TDateTime dt, TEventProp* &Event);

class DELPHICLASS TMinMaxDate;
class DELPHICLASS TPlannerCalendar;
class PASCALIMPLEMENTATION TMinMaxDate : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TPlannerCalendar* FOwner;
	short FDay;
	short FMonth;
	short FYear;
	bool FUse;
	void __fastcall SetDay(short avalue);
	void __fastcall SetMonth(short avalue);
	void __fastcall SetYear(short avalue);
	void __fastcall SetUse(bool avalue);
	System::TDateTime __fastcall GetDate(void);
	void __fastcall SetDate(const System::TDateTime Value);
	
public:
	__fastcall TMinMaxDate(TPlannerCalendar* aOwner);
	__property System::TDateTime Date = {read=GetDate, write=SetDate};
	
__published:
	__property short Day = {read=FDay, write=SetDay, default=0};
	__property short Month = {read=FMonth, write=SetMonth, default=0};
	__property short Year = {read=FYear, write=SetYear, default=0};
	__property bool Use = {read=FUse, write=SetUse, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TMinMaxDate(void) { }
	
};


class DELPHICLASS TCalGlyphs;
class PASCALIMPLEMENTATION TCalGlyphs : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TComponent* FOwner;
	Graphics::TBitmap* FNextYear;
	Graphics::TBitmap* FPrevYear;
	Graphics::TBitmap* FNextMonth;
	Graphics::TBitmap* FPrevMonth;
	Classes::TNotifyEvent FOnChange;
	void __fastcall SetNextYear(const Graphics::TBitmap* Value);
	void __fastcall SetPrevYear(const Graphics::TBitmap* Value);
	void __fastcall SetPrevMonth(const Graphics::TBitmap* Value);
	void __fastcall SetNextMonth(const Graphics::TBitmap* Value);
	void __fastcall Changed(System::TObject* Sender);
	
public:
	__fastcall TCalGlyphs(Classes::TComponent* AOwner);
	__fastcall virtual ~TCalGlyphs(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TBitmap* NextMonth = {read=FNextMonth, write=SetNextMonth};
	__property Graphics::TBitmap* PrevMonth = {read=FPrevMonth, write=SetPrevMonth};
	__property Graphics::TBitmap* NextYear = {read=FNextYear, write=SetNextYear};
	__property Graphics::TBitmap* PrevYear = {read=FPrevYear, write=SetPrevYear};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TYearStartAt;
class PASCALIMPLEMENTATION TYearStartAt : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TCustomCalendarPanel* FOwner;
	int FStartDay;
	int FStartMonth;
	int FPrevYearStartDay;
	int FPrevYearStartMonth;
	int FNextYearStartDay;
	int FNextYearStartMonth;
	Classes::TNotifyEvent FOnChange;
	bool FISOWeekNumber;
	void __fastcall SetStartDay(int d);
	void __fastcall SetStartMonth(int m);
	void __fastcall SetPrevYearStartDay(int d);
	void __fastcall SetPrevYearStartMonth(int m);
	void __fastcall SetNextYearStartDay(int d);
	void __fastcall SetNextYearStartMonth(int m);
	bool __fastcall ValidateDay(int d);
	bool __fastcall ValidateMonth(int m);
	void __fastcall Changed(void);
	void __fastcall SetISOWeekNumber(const bool Value);
	
public:
	__fastcall TYearStartAt(TCustomCalendarPanel* AOwner);
	__fastcall virtual ~TYearStartAt(void);
	
__published:
	__property bool ISOWeekNumber = {read=FISOWeekNumber, write=SetISOWeekNumber, default=0};
	__property int StartDay = {read=FStartDay, write=SetStartDay, default=1};
	__property int StartMonth = {read=FStartMonth, write=SetStartMonth, default=1};
	__property int PrevYearStartDay = {read=FPrevYearStartDay, write=SetPrevYearStartDay, default=1};
	__property int PrevYearStartMonth = {read=FPrevYearStartMonth, write=SetPrevYearStartMonth, default=1};
	__property int NextYearStartDay = {read=FNextYearStartDay, write=SetNextYearStartDay, default=1};
	__property int NextYearStartMonth = {read=FNextYearStartMonth, write=SetNextYearStartMonth, default=1};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TNameOfMonths;
class PASCALIMPLEMENTATION TNameOfMonths : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	System::UnicodeString FJanuary;
	System::UnicodeString FFebruary;
	System::UnicodeString FMarch;
	System::UnicodeString FApril;
	System::UnicodeString FMay;
	System::UnicodeString FJune;
	System::UnicodeString FJuly;
	System::UnicodeString FAugust;
	System::UnicodeString FSeptember;
	System::UnicodeString FOctober;
	System::UnicodeString FNovember;
	System::UnicodeString FDecember;
	Classes::TNotifyEvent FOnChange;
	bool FUseIntlNames;
	void __fastcall SetApril(const System::UnicodeString Value);
	void __fastcall SetAugust(const System::UnicodeString Value);
	void __fastcall SetDecember(const System::UnicodeString Value);
	void __fastcall SetFebruary(const System::UnicodeString Value);
	void __fastcall SetJanuary(const System::UnicodeString Value);
	void __fastcall SetJuly(const System::UnicodeString Value);
	void __fastcall SetJune(const System::UnicodeString Value);
	void __fastcall SetMarch(const System::UnicodeString Value);
	void __fastcall SetMay(const System::UnicodeString Value);
	void __fastcall SetNovember(const System::UnicodeString Value);
	void __fastcall SetOctober(const System::UnicodeString Value);
	void __fastcall SetSeptember(const System::UnicodeString Value);
	void __fastcall SetUseIntlNames(const bool Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall InitIntl(void);
	
public:
	__fastcall TNameOfMonths(void);
	__fastcall virtual ~TNameOfMonths(void);
	System::UnicodeString __fastcall GetMonth(int i);
	
__published:
	__property System::UnicodeString January = {read=FJanuary, write=SetJanuary};
	__property System::UnicodeString February = {read=FFebruary, write=SetFebruary};
	__property System::UnicodeString March = {read=FMarch, write=SetMarch};
	__property System::UnicodeString April = {read=FApril, write=SetApril};
	__property System::UnicodeString May = {read=FMay, write=SetMay};
	__property System::UnicodeString June = {read=FJune, write=SetJune};
	__property System::UnicodeString July = {read=FJuly, write=SetJuly};
	__property System::UnicodeString August = {read=FAugust, write=SetAugust};
	__property System::UnicodeString September = {read=FSeptember, write=SetSeptember};
	__property System::UnicodeString October = {read=FOctober, write=SetOctober};
	__property System::UnicodeString November = {read=FNovember, write=SetNovember};
	__property System::UnicodeString December = {read=FDecember, write=SetDecember};
	__property bool UseIntlNames = {read=FUseIntlNames, write=SetUseIntlNames, nodefault};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TNameOfDays;
class PASCALIMPLEMENTATION TNameOfDays : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	System::UnicodeString FMonday;
	System::UnicodeString FTuesday;
	System::UnicodeString FWednesday;
	System::UnicodeString FThursday;
	System::UnicodeString FFriday;
	System::UnicodeString FSaturday;
	System::UnicodeString FSunday;
	Classes::TNotifyEvent FOnChange;
	bool FUseIntlNames;
	void __fastcall SetFriday(const System::UnicodeString Value);
	void __fastcall SetMonday(const System::UnicodeString Value);
	void __fastcall SetSaturday(const System::UnicodeString Value);
	void __fastcall SetSunday(const System::UnicodeString Value);
	void __fastcall SetThursday(const System::UnicodeString Value);
	void __fastcall SetTuesday(const System::UnicodeString Value);
	void __fastcall SetWednesday(const System::UnicodeString Value);
	void __fastcall SetUseIntlNames(const bool Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall InitIntl(void);
	
public:
	__fastcall TNameOfDays(void);
	__fastcall virtual ~TNameOfDays(void);
	System::UnicodeString __fastcall GetDay(int i);
	
__published:
	__property System::UnicodeString Monday = {read=FMonday, write=SetMonday};
	__property System::UnicodeString Tuesday = {read=FTuesday, write=SetTuesday};
	__property System::UnicodeString Wednesday = {read=FWednesday, write=SetWednesday};
	__property System::UnicodeString Thursday = {read=FThursday, write=SetThursday};
	__property System::UnicodeString Friday = {read=FFriday, write=SetFriday};
	__property System::UnicodeString Saturday = {read=FSaturday, write=SetSaturday};
	__property System::UnicodeString Sunday = {read=FSunday, write=SetSunday};
	__property bool UseIntlNames = {read=FUseIntlNames, write=SetUseIntlNames, default=1};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TCalendarBrowsers;
class PASCALIMPLEMENTATION TCalendarBrowsers : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FPrevMonth;
	bool FNextMonth;
	bool FPrevYear;
	bool FNextYear;
	Classes::TNotifyEvent FOnChange;
	void __fastcall SetNextMonth(const bool Value);
	void __fastcall SetNextYear(const bool Value);
	void __fastcall SetPrevMonth(const bool Value);
	void __fastcall SetPrevYear(const bool Value);
	
public:
	__fastcall TCalendarBrowsers(void);
	void __fastcall Changed(void);
	
__published:
	__property bool PrevMonth = {read=FPrevMonth, write=SetPrevMonth, default=1};
	__property bool PrevYear = {read=FPrevYear, write=SetPrevYear, default=1};
	__property bool NextMonth = {read=FNextMonth, write=SetNextMonth, default=1};
	__property bool NextYear = {read=FNextYear, write=SetNextYear, default=1};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TCalendarBrowsers(void) { }
	
};


#pragma option push -b-
enum TPlannerCalendarLook { lookFlat, look3D };
#pragma option pop

class PASCALIMPLEMENTATION TCustomCalendarPanel : public Extctrls::TCustomPanel
{
	typedef Extctrls::TCustomPanel inherited;
	
private:
	Graphics::TColor FEventMarkerColor;
	TEventShape FEventMarkerShape;
	Graphics::TColor FEventDayColor;
	void __fastcall SetEventMarkerColor(const Graphics::TColor Value);
	void __fastcall SetEventMarkerShape(const TEventShape Value);
	void __fastcall SetEventDayColor(const Graphics::TColor Value);
	
protected:
	virtual void __fastcall UpdateYearStart(void);
	virtual void __fastcall DoPaint(void);
	virtual void __fastcall RepaintDate(System::TDateTime dt);
	
public:
	__property BorderWidth = {default=0};
	__property BevelWidth = {default=1};
	
__published:
	__property Graphics::TColor EventDayColor = {read=FEventDayColor, write=SetEventDayColor, nodefault};
	__property Graphics::TColor EventMarkerColor = {read=FEventMarkerColor, write=SetEventMarkerColor, nodefault};
	__property TEventShape EventMarkerShape = {read=FEventMarkerShape, write=SetEventMarkerShape, nodefault};
public:
	/* TCustomPanel.Create */ inline __fastcall virtual TCustomCalendarPanel(Classes::TComponent* AOwner) : Extctrls::TCustomPanel(AOwner) { }
	
public:
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TCustomCalendarPanel(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomCalendarPanel(HWND ParentWindow) : Extctrls::TCustomPanel(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TPlannerCalendar : public TCustomCalendarPanel
{
	typedef TCustomCalendarPanel inherited;
	
private:
	TSelDateItems* DateCol;
	TSelDateItems* EventCol;
	int xoffset;
	int yoffset;
	System::TDateTime seldate;
	System::TDateTime thedate;
	System::TDateTime clkdate;
	System::TDateTime movdate;
	System::TDateTime initdate;
	bool mousesel;
	bool showhintbusy;
	Types::TPoint fLastHintPos;
	System::Word dx;
	System::Word dy;
	System::Word lblx1;
	System::Word lblx2;
	System::Word lblx3;
	Graphics::TFont* fFont;
	int xposin;
	int yposin;
	bool flgl;
	bool flgr;
	bool flgla;
	bool dflgl;
	bool dflgr;
	bool flgt;
	System::UnicodeString labels;
	System::UnicodeString EventHint;
	System::UnicodeString BrowserHint;
	bool FShowToday;
	TPlannerCalendarLook FLook;
	TCalendarBrowsers* FBrowsers;
	bool FMonthSelect;
	bool FMultiSelect;
	bool FEventHints;
	TYearStartAt* FYearStartAt;
	TNameOfDays* FNameOfDays;
	TNameOfMonths* FNameOfMonths;
	TMinMaxDate* FMaxDate;
	TMinMaxDate* FMinDate;
	Graphics::TColor FTextcolor;
	Graphics::TColor FSelectColor;
	Graphics::TColor FSelectFontColor;
	Graphics::TColor FInactiveColor;
	Graphics::TColor FFocusColor;
	Graphics::TColor FInverscolor;
	Graphics::TColor FWeekendColor;
	Graphics::TColor FHeaderColor;
	bool FShowWeeks;
	int FStartDay;
	System::Word FDay;
	System::Word FMonth;
	System::Word FYear;
	Graphics::TFont* FDayFont;
	Graphics::TFont* FWeekFont;
	System::UnicodeString FWeekName;
	TCellDrawEvent FOnCellDraw;
	TDaySelectEvent FOnDaySelect;
	Classes::TNotifyEvent FOnMonthSelect;
	TGetDateEvent FOnGetDateEvent;
	TGetDateEventHint FOnGetDateEventHint;
	TDateChangeEvent FOnDateChange;
	TDateChangeEvent FOnMonthChange;
	TDateChangeEvent FOnYearChange;
	TDateChangeEvent FOnDayChange;
	Advimage::TAdvImage* FImage;
	TBackGroundPosition FBackgroundPosition;
	bool FShowDaysAfter;
	bool FShowDaysBefore;
	bool FShowSelection;
	bool FWeekSelect;
	bool FAllDaySelect;
	TCancelledChangeEvent FOnCancelledChange;
	TCancelledKeyEvent FOnCancelledKey;
	Classes::TNotifyEvent FOnWeekSelect;
	Classes::TNotifyEvent FOnAllDaySelect;
	int FUpdateCount;
	Graphics::TColor FCaptionColor;
	bool FReturnIsSelect;
	Graphics::TColor FLineColor;
	bool FLine3D;
	Graphics::TColor FGradientStartColor;
	Graphics::TColor FGradientEndColor;
	TGradientDirection FGradientDirection;
	Graphics::TColor FMonthGradientStartColor;
	Graphics::TColor FMonthGradientEndColor;
	TGradientDirection FMonthGradientDirection;
	TCalGlyphs* FGlyphs;
	Controls::TCursor FOldCursor;
	System::UnicodeString FHintPrevYear;
	System::UnicodeString FHintPrevMonth;
	System::UnicodeString FHintNextMonth;
	System::UnicodeString FHintNextYear;
	bool FUseTheme;
	TTodayStyle FTodayStyle;
	Graphics::TColor FTodayLineColor;
	TEventPropEvent FOnGetEventProp;
	bool FShowGotoToday;
	System::UnicodeString FTodayFormat;
	Graphics::TCanvas* FCanvas;
	bool FBorderXP;
	Graphics::TColor FCaptionTextColor;
	bool FCaption3D;
	TWeekDays* FInActiveDays;
	bool FAutoThemeAdapt;
	System::TDateTime FHoverDate;
	TPlannerCalendarStyle FStyle;
	Graphics::TColor FDateSelectColor;
	Graphics::TColor FDateSelectBorderColor;
	Graphics::TColor FDateHoverColor;
	Graphics::TColor FDateDownColor;
	Graphics::TColor FBorderColor;
	bool FCustomDraw;
	bool FShowMonthSelector;
	bool FShowYearSelector;
	bool FEnable;
	bool FMultiSelectCtrlKey;
	bool FBorderFix;
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMCommand(Messages::TWMCommand &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &Message);
	MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Msg);
	void __fastcall UpdateYearStartAtISO(void);
	void __fastcall SetLabel(System::Word mo, System::Word ye);
	void __fastcall DiffCheck(System::TDateTime dt1, System::TDateTime dt2);
	System::TDateTime __fastcall DiffMonth(int dx);
	System::TDateTime __fastcall DiffYear(int dx);
	bool __fastcall CheckDateRange(System::TDateTime dt);
	bool __fastcall CheckMonth(System::TDateTime dt);
	System::Word __fastcall DaysInMonth(System::Word mo, System::Word ye);
	void __fastcall PaintArrowLeft(void);
	void __fastcall PaintArrowRight(void);
	void __fastcall PaintDblArrowLeft(void);
	void __fastcall PaintDblArrowRight(void);
	void __fastcall PaintLabel(void);
	void __fastcall PaintProc(void);
	void __fastcall PaintToday(void);
	void __fastcall PaintEventMarker(const Types::TRect &R, Graphics::TColor AColor, TEventShape AShape);
	void __fastcall SetLook(TPlannerCalendarLook AValue);
	void __fastcall SetShowToday(bool AValue);
	void __fastcall SetMultiSelect(bool AValue);
	void __fastcall SetDayFont(Graphics::TFont* AValue);
	void __fastcall SetWeekFont(Graphics::TFont* AValue);
	void __fastcall SetTextColor(Graphics::TColor AColor);
	void __fastcall SetFocusColor(Graphics::TColor AColor);
	void __fastcall SetInversColor(Graphics::TColor AColor);
	void __fastcall SetWeekendColor(Graphics::TColor AColor);
	void __fastcall SetSelectColor(Graphics::TColor AColor);
	void __fastcall SetSelectFontColor(Graphics::TColor AColor);
	void __fastcall SetInactiveColor(Graphics::TColor AColor);
	void __fastcall SetHeaderColor(Graphics::TColor AColor);
	void __fastcall SetWeekName(const System::UnicodeString Value);
	HIDESBASE void __fastcall FontChanged(System::TObject* Sender);
	HIDESBASE void __fastcall SetFont(Graphics::TFont* Value);
	void __fastcall SetNameofDays(TNameOfDays* ANameofDays);
	void __fastcall SetNameofMonths(TNameOfMonths* ANameofMonths);
	void __fastcall SetShowWeeks(bool AValue);
	void __fastcall SetStartDay(int AValue);
	void __fastcall SetCalDay(System::Word AValue);
	void __fastcall SetCalMonth(System::Word AValue);
	void __fastcall SetCalYear(System::Word AValue);
	System::Word __fastcall GetCalDay(void);
	System::Word __fastcall GetCalMonth(void);
	System::Word __fastcall GetMonth(System::TDateTime &dt);
	System::Word __fastcall GetCalYear(void);
	int __fastcall GetYear(System::TDateTime dt);
	Types::TRect __fastcall DateToRect(System::TDateTime dt);
	System::TDateTime __fastcall XYToDate(int X, int Y, bool Change);
	System::TDateTime __fastcall GetDateProc(void);
	void __fastcall SetDateProc(const System::TDateTime Value);
	void __fastcall SetDateCol(const TSelDateItems* Value);
	TSelDateItems* __fastcall GetDateCol(void);
	void __fastcall DoMonthPopup(void);
	void __fastcall DoYearPopup(void);
	void __fastcall PropsChanged(System::TObject* Sender);
	void __fastcall SetLineColor(Graphics::TColor AValue);
	void __fastcall SetDateSelectColor(Graphics::TColor AColor);
	void __fastcall SetDateSelectBorderColor(Graphics::TColor AColor);
	void __fastcall SetLine3D(bool AValue);
	void __fastcall DrawGradient(Graphics::TCanvas* Canvas, Graphics::TColor FromColor, Graphics::TColor ToColor, int Steps, const Types::TRect &r, bool Direction);
	void __fastcall SetImage(const Advimage::TAdvImage* Value);
	void __fastcall SetBackgroundPosition(const TBackGroundPosition Value);
	void __fastcall SetAutoThemeAdapt(const bool Value);
	void __fastcall SetStyle(const TPlannerCalendarStyle Value);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	void __fastcall BackgroundChanged(System::TObject* Sender);
	TSelDateItems* __fastcall GetEvents(void);
	System::UnicodeString __fastcall GetDatesAsText(void);
	void __fastcall SetEvents(const TSelDateItems* Value);
	void __fastcall SetShowDaysAfter(const bool Value);
	void __fastcall SetShowDaysBefore(const bool Value);
	void __fastcall SetShowSelection(const bool Value);
	void __fastcall SetCaptionColor(const Graphics::TColor Value);
	void __fastcall SetGradientStartColor(Graphics::TColor AValue);
	void __fastcall SetGradientEndColor(Graphics::TColor AValue);
	void __fastcall SetGradientDirection(TGradientDirection AValue);
	void __fastcall SetMonthGradientStartColor(Graphics::TColor AValue);
	void __fastcall SetMonthGradientEndColor(Graphics::TColor AValue);
	void __fastcall SetMonthGradientDirection(TGradientDirection AValue);
	void __fastcall SetGlyphs(const TCalGlyphs* Value);
	void __fastcall SetHintPrevYear(System::UnicodeString AValue);
	void __fastcall SetHintPrevMonth(System::UnicodeString AValue);
	void __fastcall SetHintNextMonth(System::UnicodeString AValue);
	void __fastcall SetHintNextYear(System::UnicodeString AValue);
	void __fastcall SetTodayStyle(const TTodayStyle Value);
	void __fastcall SetTodayLineColor(const Graphics::TColor Value);
	int __fastcall NumRows(void);
	int __fastcall NumCols(void);
	void __fastcall SetShowGotoToday(const bool Value);
	void __fastcall SetTodayFormat(const System::UnicodeString Value);
	void __fastcall SetBorderXP(const bool Value);
	void __fastcall SetCaptionTextColor(const Graphics::TColor Value);
	void __fastcall SetCaption3D(bool Value);
	bool __fastcall IsVisibleDay(System::TDateTime dt);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	
protected:
	virtual void __fastcall DoPaint(void);
	virtual void __fastcall RepaintDate(System::TDateTime dt);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall DoChangeMonth(System::TDateTime dt1, System::TDateTime dt2);
	virtual void __fastcall DoChangeYear(System::TDateTime dt1, System::TDateTime dt2);
	__property bool UseTheme = {read=FUseTheme, nodefault};
	void __fastcall YearStartChanged(System::TObject* Sender);
	virtual bool __fastcall IsInActiveDay(System::TDateTime dt);
	void __fastcall ThemeAdapt(void);
	virtual void __fastcall WndProc(Messages::TMessage &Msg);
	__property bool BorderFix = {read=FBorderFix, write=FBorderFix, default=0};
	
public:
	__fastcall virtual TPlannerCalendar(Classes::TComponent* AOwner);
	__fastcall virtual ~TPlannerCalendar(void);
	void __fastcall ChangeMonth(int dx);
	void __fastcall ChangeYear(int dx);
	void __fastcall SetDate(System::Word da, System::Word mo, System::Word ye);
	void __fastcall GetDate(System::Word &da, System::Word &mo, System::Word &ye);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	void __fastcall ResetUpdate(void);
	virtual bool __fastcall HasEvent(System::TDateTime dt, TSelDateItem* &EventItem);
	bool __fastcall DateAtXY(int x, int y, System::TDateTime &ADate);
	Types::TPoint __fastcall DateToXY(System::TDateTime dt);
	__property System::TDateTime Date = {read=GetDateProc, write=SetDateProc};
	__property TSelDateItems* Dates = {read=GetDateCol, write=SetDateCol};
	__property System::UnicodeString DatesAsText = {read=GetDatesAsText};
	__property TSelDateItems* Events = {read=GetEvents, write=SetEvents};
	__property TPlannerCalendarStyle Style = {read=FStyle, write=SetStyle, nodefault};
	__property bool CustomDraw = {read=FCustomDraw, write=FCustomDraw, nodefault};
	System::TDateTime __fastcall FirstDate(void);
	System::TDateTime __fastcall LastDate(void);
	__property TCancelledKeyEvent OnCancelledKey = {read=FOnCancelledKey, write=FOnCancelledKey};
	
__published:
	__property Align = {default=0};
	__property bool AllDaySelect = {read=FAllDaySelect, write=FAllDaySelect, default=0};
	__property bool AutoThemeAdapt = {read=FAutoThemeAdapt, write=SetAutoThemeAdapt, default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property Advimage::TAdvImage* Background = {read=FImage, write=SetImage};
	__property TBackGroundPosition BackgroundPosition = {read=FBackgroundPosition, write=SetBackgroundPosition, nodefault};
	__property BevelInner = {default=0};
	__property BevelOuter = {default=2};
	__property BevelWidth = {default=1};
	__property BorderWidth = {default=0};
	__property bool BorderXP = {read=FBorderXP, write=SetBorderXP, default=1};
	__property BorderStyle = {default=0};
	__property TCalendarBrowsers* Browsers = {read=FBrowsers, write=FBrowsers};
	__property bool Caption3D = {read=FCaption3D, write=SetCaption3D, default=0};
	__property Color = {default=-16777201};
	__property Cursor = {default=0};
	__property DragMode = {default=0};
	__property bool Enable = {read=FEnable, write=FEnable, default=1};
	__property TWeekDays* InActiveDays = {read=FInActiveDays, write=FInActiveDays};
	__property TPlannerCalendarLook Look = {read=FLook, write=SetLook, nodefault};
	__property Graphics::TColor DateDownColor = {read=FDateDownColor, write=FDateDownColor, nodefault};
	__property Graphics::TColor DateHoverColor = {read=FDateHoverColor, write=FDateHoverColor, nodefault};
	__property Graphics::TColor DateSelectColor = {read=FDateSelectColor, write=SetDateSelectColor, default=8421376};
	__property Graphics::TColor DateSelectBorderColor = {read=FDateSelectBorderColor, write=SetDateSelectBorderColor, default=8421376};
	__property bool MultiSelect = {read=FMultiSelect, write=SetMultiSelect, default=0};
	__property bool MultiSelectCtrlKey = {read=FMultiSelectCtrlKey, write=FMultiSelectCtrlKey, default=0};
	__property Graphics::TFont* DayFont = {read=FDayFont, write=SetDayFont};
	__property Graphics::TFont* WeekFont = {read=FWeekFont, write=SetWeekFont};
	__property System::UnicodeString WeekName = {read=FWeekName, write=SetWeekName, stored=true};
	__property Graphics::TColor TextColor = {read=FTextcolor, write=SetTextColor, nodefault};
	__property Graphics::TColor SelectColor = {read=FSelectColor, write=SetSelectColor, nodefault};
	__property Graphics::TColor SelectFontColor = {read=FSelectFontColor, write=SetSelectFontColor, nodefault};
	__property Graphics::TColor InActiveColor = {read=FInactiveColor, write=SetInactiveColor, nodefault};
	__property Graphics::TColor HeaderColor = {read=FHeaderColor, write=SetHeaderColor, nodefault};
	__property Graphics::TColor FocusColor = {read=FFocusColor, write=SetFocusColor, nodefault};
	__property Graphics::TColor InversColor = {read=FInverscolor, write=SetInversColor, nodefault};
	__property Graphics::TColor WeekendColor = {read=FWeekendColor, write=SetWeekendColor, nodefault};
	__property TNameOfDays* NameOfDays = {read=FNameOfDays, write=SetNameofDays};
	__property TNameOfMonths* NameOfMonths = {read=FNameOfMonths, write=SetNameofMonths};
	__property TMinMaxDate* MaxDate = {read=FMaxDate, write=FMaxDate};
	__property TMinMaxDate* MinDate = {read=FMinDate, write=FMinDate};
	__property PopupMenu;
	__property bool ReturnIsSelect = {read=FReturnIsSelect, write=FReturnIsSelect, default=0};
	__property bool ShowDaysBefore = {read=FShowDaysBefore, write=SetShowDaysBefore, default=1};
	__property bool ShowDaysAfter = {read=FShowDaysAfter, write=SetShowDaysAfter, default=1};
	__property bool ShowGotoToday = {read=FShowGotoToday, write=SetShowGotoToday, default=0};
	__property bool ShowSelection = {read=FShowSelection, write=SetShowSelection, default=1};
	__property bool ShowToday = {read=FShowToday, write=SetShowToday, default=0};
	__property bool ShowWeeks = {read=FShowWeeks, write=SetShowWeeks, default=0};
	__property bool ShowMonthSelector = {read=FShowMonthSelector, write=FShowMonthSelector, default=1};
	__property bool ShowYearSelector = {read=FShowYearSelector, write=FShowYearSelector, default=1};
	__property int StartDay = {read=FStartDay, write=SetStartDay, nodefault};
	__property System::UnicodeString TodayFormat = {read=FTodayFormat, write=SetTodayFormat};
	__property TTodayStyle TodayStyle = {read=FTodayStyle, write=SetTodayStyle, default=0};
	__property Graphics::TColor TodayLineColor = {read=FTodayLineColor, write=SetTodayLineColor, default=0};
	__property TYearStartAt* YearStartAt = {read=FYearStartAt, write=FYearStartAt};
	__property System::Word Day = {read=GetCalDay, write=SetCalDay, default=1};
	__property System::Word Month = {read=GetCalMonth, write=SetCalMonth, default=1};
	__property System::Word Year = {read=GetCalYear, write=SetCalYear, default=1};
	__property ShowHint;
	__property ParentShowHint = {default=1};
	__property TabStop = {default=0};
	__property TabOrder = {default=-1};
	__property bool WeekSelect = {read=FWeekSelect, write=FWeekSelect, default=0};
	__property Graphics::TFont* Font = {read=fFont, write=SetFont};
	__property bool EventHints = {read=FEventHints, write=FEventHints, default=0};
	__property Graphics::TColor CaptionColor = {read=FCaptionColor, write=SetCaptionColor, nodefault};
	__property Graphics::TColor CaptionTextColor = {read=FCaptionTextColor, write=SetCaptionTextColor, nodefault};
	__property TCellDrawEvent OnCellDraw = {read=FOnCellDraw, write=FOnCellDraw};
	__property TDaySelectEvent OnDaySelect = {read=FOnDaySelect, write=FOnDaySelect};
	__property Classes::TNotifyEvent OnMonthSelect = {read=FOnMonthSelect, write=FOnMonthSelect};
	__property TGetDateEvent OnGetDateHint = {read=FOnGetDateEvent, write=FOnGetDateEvent};
	__property TGetDateEventHint OnGetDateHintString = {read=FOnGetDateEventHint, write=FOnGetDateEventHint};
	__property TEventPropEvent OnGetEventProp = {read=FOnGetEventProp, write=FOnGetEventProp};
	__property TDateChangeEvent OnMonthChange = {read=FOnMonthChange, write=FOnMonthChange};
	__property TDateChangeEvent OnYearChange = {read=FOnYearChange, write=FOnYearChange};
	__property TDateChangeEvent OnDayChange = {read=FOnDayChange, write=FOnDayChange};
	__property TDateChangeEvent OnDateChange = {read=FOnDateChange, write=FOnDateChange};
	__property TCancelledChangeEvent OnCancelledChange = {read=FOnCancelledChange, write=FOnCancelledChange};
	__property Classes::TNotifyEvent OnWeekSelect = {read=FOnWeekSelect, write=FOnWeekSelect};
	__property Classes::TNotifyEvent OnAllDaySelect = {read=FOnAllDaySelect, write=FOnAllDaySelect};
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseMove;
	__property OnMouseDown;
	__property OnMouseUp;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnStartDrag;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnResize;
	__property Graphics::TColor LineColor = {read=FLineColor, write=SetLineColor, nodefault};
	__property bool Line3D = {read=FLine3D, write=SetLine3D, nodefault};
	__property Graphics::TColor GradientStartColor = {read=FGradientStartColor, write=SetGradientStartColor, nodefault};
	__property Graphics::TColor GradientEndColor = {read=FGradientEndColor, write=SetGradientEndColor, nodefault};
	__property TGradientDirection GradientDirection = {read=FGradientDirection, write=SetGradientDirection, nodefault};
	__property Graphics::TColor MonthGradientStartColor = {read=FMonthGradientStartColor, write=SetMonthGradientStartColor, nodefault};
	__property Graphics::TColor MonthGradientEndColor = {read=FMonthGradientEndColor, write=SetMonthGradientEndColor, nodefault};
	__property TGradientDirection MonthGradientDirection = {read=FMonthGradientDirection, write=SetMonthGradientDirection, nodefault};
	__property TCalGlyphs* Glyphs = {read=FGlyphs, write=SetGlyphs};
	__property System::UnicodeString HintPrevYear = {read=FHintPrevYear, write=SetHintPrevYear};
	__property System::UnicodeString HintPrevMonth = {read=FHintPrevMonth, write=SetHintPrevMonth};
	__property System::UnicodeString HintNextMonth = {read=FHintNextMonth, write=SetHintNextMonth};
	__property System::UnicodeString HintNextYear = {read=FHintNextYear, write=SetHintNextYear};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TWinControl.CreateParented */ inline __fastcall TPlannerCalendar(HWND ParentWindow) : TCustomCalendarPanel(ParentWindow) { }
	
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


class DELPHICLASS TPlannerCalendarGroup;
class PASCALIMPLEMENTATION TPlannerCalendarGroup : public TCustomCalendarPanel
{
	typedef TCustomCalendarPanel inherited;
	
private:
	Advimage::TAdvImage* FImage;
	TBackGroundPosition FBackgroundPosition;
	Classes::TList* FCalendars;
	int FColCount;
	int FRowCount;
	Extctrls::TPanel* FResizeVertical;
	Extctrls::TPanel* FResizeHorizontal;
	System::Byte fspliterV;
	System::Byte fspliterH;
	bool FLetResize;
	int FCalendarWidth;
	int FCalendarHeight;
	Graphics::TFont* fFont;
	int FStartMonth;
	int FStartYear;
	TDaySelectEvent FOnDaySelect;
	Classes::TNotifyEvent FOnMonthSelect;
	TGetDateEvent FOnGetDateEvent;
	TGetDateEventHint FOnGetDateEventHint;
	TDateChangeEvent FOnDateChange;
	TDateChangeEvent FOnMonthChange;
	TDateChangeEvent FOnYearChange;
	TDateChangeEvent FOnDayChange;
	TCancelledChangeEvent FOnCancelledChange;
	Classes::TNotifyEvent FOnWeekSelect;
	Classes::TNotifyEvent FOnAllDaySelect;
	bool Fctltdown;
	Controls::TKeyEvent FOnKeyDown;
	Controls::TKeyPressEvent FOnKeyPress;
	Controls::TKeyEvent FOnKeyUp;
	Controls::TMouseMoveEvent FOnMouseMove;
	Controls::TMouseEvent FOnMouseDown;
	Controls::TMouseEvent FOnMouseUp;
	Controls::TDragDropEvent FOnDragDrop;
	Controls::TDragOverEvent FOnDragOver;
	Controls::TEndDragEvent FOnEndDrag;
	Controls::TStartDragEvent FOnStartDrag;
	TCellDrawEvent FOnCellDraw;
	System::Word FDay;
	System::Word FMonth;
	System::Word FYear;
	TPlannerCalendarLook FLook;
	Graphics::TFont* FDayFont;
	Graphics::TFont* FWeekFont;
	System::UnicodeString FWeekName;
	Graphics::TColor FTextColor;
	Graphics::TColor FSelectColor;
	Graphics::TColor FSelectFontColor;
	Graphics::TColor FInactiveColor;
	Graphics::TColor FHeaderColor;
	Graphics::TColor FFocusColor;
	Graphics::TColor FInversColor;
	Graphics::TColor FWeekendColor;
	TNameOfDays* FNameOfDays;
	TNameOfMonths* FNameOfMonths;
	bool FShowSelection;
	bool FShowWeeks;
	bool FEventHints;
	bool FSPlitterBevel;
	Graphics::TColor FSplitterColor;
	int FBevelWidth;
	Forms::TFormBorderStyle FBorderStyle;
	int FBorderWidth;
	Controls::TBevelCut FBevelOuter;
	Controls::TBevelCut FBevelInner;
	bool FMultiSelect;
	bool FShowToday;
	TSelDateItems* FEventCol;
	TSelDateItems* FDates;
	bool FAllDaySelect;
	bool FWeekSelect;
	Graphics::TColor FCaptionColor;
	int FStartDay;
	Graphics::TColor FLineColor;
	bool FLine3D;
	TGradientDirection FGradientDirection;
	Graphics::TColor FGradientStartColor;
	Graphics::TColor FGradientEndColor;
	TGradientDirection FMonthGradientDirection;
	Graphics::TColor FMonthGradientStartColor;
	Graphics::TColor FMonthGradientEndColor;
	TCalendarBrowsers* FBrowsers;
	System::UnicodeString FHintNextMonth;
	System::UnicodeString FHintNextYear;
	System::UnicodeString FHintPrevYear;
	System::UnicodeString FHintPrevMonth;
	TCalGlyphs* FGlyphs;
	Graphics::TColor FCaptionTextColor;
	System::TDateTime FLastDay;
	TYearStartAt* FYearStartAt;
	TPlannerCalendarStyle FStyle;
	Graphics::TColor FDateSelectColor;
	Graphics::TColor FDateSelectBorderColor;
	Graphics::TColor FDateHoverColor;
	Graphics::TColor FDateDownColor;
	bool FAutoThemeAdapt;
	bool FShowMonthSelector;
	bool FShowYearSelector;
	TTodayStyle FTodayStyle;
	Graphics::TColor FTodayLineColor;
	bool FEnable;
	void __fastcall SetColCount(const int Value);
	void __fastcall SetRowCount(const int Value);
	void __fastcall SetCalendarWidth(const int Value);
	void __fastcall SetCalendarHeight(const int Value);
	HIDESBASE void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetStartMonth(const int Value);
	void __fastcall SetStartYear(const int Value);
	void __fastcall SetSpliterH(const System::Byte Value);
	void __fastcall SetSpliterV(const System::Byte Value);
	void __fastcall UpdateFields(void);
	void __fastcall UpdateEvents(void);
	TSelDateItems* __fastcall GetDates(void);
	void __fastcall SetDates(const TSelDateItems* Value);
	void __fastcall SetDay(System::Word Value);
	void __fastcall SetMonth(System::Word Value);
	void __fastcall SetYear(System::Word Value);
	System::Word __fastcall GetMonth(void);
	System::Word __fastcall GetYear(void);
	void __fastcall SetLook(TPlannerCalendarLook AValue);
	void __fastcall SetDayFont(Graphics::TFont* AValue);
	void __fastcall SetWeekFont(Graphics::TFont* AValue);
	void __fastcall SetWeekName(const System::UnicodeString Value);
	void __fastcall SetTextColor(Graphics::TColor AColor);
	void __fastcall SetSelectColor(Graphics::TColor AColor);
	void __fastcall SetSelectFontColor(Graphics::TColor AColor);
	void __fastcall SetInactiveColor(Graphics::TColor AColor);
	void __fastcall SetHeaderColor(Graphics::TColor AColor);
	void __fastcall SetFocusColor(Graphics::TColor AColor);
	void __fastcall SetInversColor(Graphics::TColor AColor);
	void __fastcall SetWeekendColor(Graphics::TColor AColor);
	void __fastcall SetTodayLineColor(const Graphics::TColor Value);
	void __fastcall SetTodayStyle(const TTodayStyle Value);
	void __fastcall SetNameOfDays(const TNameOfDays* Value);
	void __fastcall SetNameOfMonths(const TNameOfMonths* Value);
	void __fastcall SetShowSelection(const bool Value);
	void __fastcall SetShowWeeks(bool AValue);
	void __fastcall SetEventHints(bool AValue);
	void __fastcall SetFOnDaySelect(TDaySelectEvent Value);
	void __fastcall SetFOnMonthSelect(Classes::TNotifyEvent Value);
	void __fastcall SetFOnGetDateEvent(TGetDateEvent Value);
	void __fastcall SetFOnGetDateEventHint(TGetDateEventHint Value);
	void __fastcall SetFOnDateChange(TDateChangeEvent Value);
	void __fastcall SetFOnMonthChange(TDateChangeEvent Value);
	void __fastcall SetFOnYearChange(TDateChangeEvent Value);
	void __fastcall SetFOnDayChange(TDateChangeEvent Value);
	void __fastcall SetFOnCancelledChange(TCancelledChangeEvent Value);
	void __fastcall SetFOnWeekSelect(Classes::TNotifyEvent Value);
	void __fastcall SetFOnAllDaySelect(Classes::TNotifyEvent Value);
	void __fastcall SetFOnKeyDown(Controls::TKeyEvent Value);
	void __fastcall SetFOnKeyPress(Controls::TKeyPressEvent Value);
	void __fastcall SetFOnKeyUp(Controls::TKeyEvent Value);
	void __fastcall SetFOnMouseMove(Controls::TMouseMoveEvent Value);
	void __fastcall SetFOnMouseDown(Controls::TMouseEvent Value);
	void __fastcall SetFOnMouseUp(Controls::TMouseEvent Value);
	void __fastcall SetFOnDragOver(Controls::TDragOverEvent Value);
	void __fastcall SetFOnDragDrop(Controls::TDragDropEvent Value);
	void __fastcall SetFOnEndDrag(Controls::TEndDragEvent Value);
	void __fastcall SetFOnStartDrag(Controls::TStartDragEvent Value);
	void __fastcall MouseDownV(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall MouseMoveV(System::TObject* Sender, Classes::TShiftState Shift, int X, int Y);
	void __fastcall MouseUpV(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall MouseDownH(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall MouseMoveH(System::TObject* Sender, Classes::TShiftState Shift, int X, int Y);
	void __fastcall MouseUpH(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall SetImage(const Advimage::TAdvImage* Value);
	void __fastcall BackgroundChanged(System::TObject* Sender);
	void __fastcall SetBackgroundPosition(const TBackGroundPosition Value);
	Graphics::TColor __fastcall GetColorEx(void);
	void __fastcall SetColorEx(const Graphics::TColor Value);
	void __fastcall FitPlanners(void);
	void __fastcall SetPlannersUpdate(const bool State);
	void __fastcall SetSplitterBevel(const bool Value);
	void __fastcall SetSplitterColor(const Graphics::TColor Value);
	void __fastcall SetBebelInnerEx(const Controls::TBevelCut Value);
	void __fastcall SetBevelOuterEx(const Controls::TBevelCut Value);
	void __fastcall SetBevelWidthEx(const int Value);
	void __fastcall SetBorderStyleEx(const Forms::TBorderStyle Value);
	void __fastcall SetBorderWidthEx(const int Value);
	void __fastcall SetMultiSelect(const bool Value);
	void __fastcall SetShowToday(const bool Value);
	TSelDateItems* __fastcall GetEvents(void);
	void __fastcall SetEvents(const TSelDateItems* Value);
	void __fastcall SetAllDaySelect(const bool Value);
	void __fastcall SetWeekSelect(const bool Value);
	void __fastcall SetCaptionColor(const Graphics::TColor Value);
	int __fastcall GetBevelWidth(void);
	int __fastcall GetBorderWidth(void);
	HIDESBASE void __fastcall SetBevelWidth(const int Value);
	HIDESBASE void __fastcall SetBorderWidth(const int Value);
	void __fastcall SetStartDay(const int Value);
	void __fastcall SetLineColor(const Graphics::TColor Value);
	void __fastcall SetLine3D(const bool Value);
	void __fastcall SetGradientDirection(TGradientDirection Value);
	void __fastcall SetGradientStartColor(Graphics::TColor Value);
	void __fastcall SetGradientEndColor(Graphics::TColor Value);
	void __fastcall setMonthGradientDirection(TGradientDirection Value);
	void __fastcall SetMonthGradientStartColor(Graphics::TColor Value);
	void __fastcall SetMonthGradientEndColor(Graphics::TColor Value);
	void __fastcall SetHintPrevMonth(System::UnicodeString Value);
	void __fastcall SetHintPrevYear(System::UnicodeString Value);
	void __fastcall SetHintNextMonth(System::UnicodeString Value);
	void __fastcall SetHintNextYear(System::UnicodeString Value);
	void __fastcall SetGlyphs(const TCalGlyphs* Value);
	void __fastcall GlyphsChanged(System::TObject* Sender);
	void __fastcall SetCaptionTextColor(const Graphics::TColor Value);
	void __fastcall YearStartChanged(System::TObject* Sender);
	System::TDateTime __fastcall GetDate(void);
	void __fastcall SetDate(const System::TDateTime Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	void __fastcall SetStyle(TPlannerCalendarStyle Value);
	void __fastcall SetDateSelectColor(Graphics::TColor Value);
	void __fastcall SetDateSelectBorderColor(Graphics::TColor Value);
	void __fastcall SetAutoThemeAdapt(bool Value);
	void __fastcall DblClickProc(System::TObject* Sender);
	void __fastcall SetShowMonthSelector(const bool Value);
	void __fastcall SetShowYearSelector(const bool Value);
	int __fastcall GetMonthCount(void);
	HIDESBASE void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall SetEnable(const bool Value);
	
protected:
	virtual void __fastcall DoPaint(void);
	virtual void __fastcall RepaintDate(System::TDateTime dt);
	void __fastcall ShowPlanners(void);
	void __fastcall UpdatePlanners(void);
	void __fastcall Updatezero(System::TDateTime &dt);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall DoEnter(void);
	void __fastcall CtrlKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall CtrlKeyUP(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall GetGroupDate(System::TObject* Sender, System::TDateTime origDate, System::TDateTime newDate);
	void __fastcall AnyDaySelect(System::TObject* Sender, System::TDateTime SelDate);
	void __fastcall AnyDayChange(System::TObject* Sender, System::TDateTime OrigDate, System::TDateTime SelDate);
	void __fastcall WeekChange(System::TObject* Sender);
	DYNAMIC void __fastcall Resize(void);
	void __fastcall PropsChanged(System::TObject* Sender);
	void __fastcall EventsChanged(System::TObject* Sender);
	void __fastcall ThemeAdapt(void);
	void __fastcall CancelledKey(System::TObject* Sender, System::Word Key);
	virtual void __fastcall WndProc(Messages::TMessage &Msg);
	virtual void __fastcall DoMouseMove(System::TObject* Sender, Classes::TShiftState Shift, int X, int Y);
	HIDESBASE virtual void __fastcall DoMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	HIDESBASE virtual void __fastcall DoMouseUp(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall DoDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	virtual void __fastcall DoDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	
public:
	__fastcall virtual TPlannerCalendarGroup(Classes::TComponent* AOwner);
	__fastcall virtual ~TPlannerCalendarGroup(void);
	virtual void __fastcall Loaded(void);
	bool __fastcall DateAtXY(int X, int Y, System::TDateTime &ADate);
	void __fastcall ModifyGroup(int Cols, int Rows, int CalendarWidth, int CalendarHeight);
	__property TSelDateItems* Events = {read=GetEvents, write=SetEvents};
	__property TSelDateItems* Dates = {read=GetDates, write=SetDates};
	void __fastcall UpdateDates(void);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	__property System::TDateTime Date = {read=GetDate, write=SetDate};
	__property TPlannerCalendarStyle Style = {read=FStyle, write=SetStyle, nodefault};
	__property int MonthCount = {read=GetMonthCount, nodefault};
	System::TDateTime __fastcall FirstDate(void);
	System::TDateTime __fastcall LastDate(void);
	
__published:
	__property Align = {default=0};
	__property bool AllDaySelect = {read=FAllDaySelect, write=SetAllDaySelect, default=0};
	__property Advimage::TAdvImage* Background = {read=FImage, write=SetImage};
	__property TBackGroundPosition BackgroundPosition = {read=FBackgroundPosition, write=SetBackgroundPosition, nodefault};
	__property Graphics::TColor Color = {read=GetColorEx, write=SetColorEx, nodefault};
	__property int ColCount = {read=FColCount, write=SetColCount, nodefault};
	__property int RowCount = {read=FRowCount, write=SetRowCount, nodefault};
	__property int CalendarWidth = {read=FCalendarWidth, write=SetCalendarWidth, nodefault};
	__property int CalendarHeight = {read=FCalendarHeight, write=SetCalendarHeight, nodefault};
	__property bool Enable = {read=FEnable, write=SetEnable, default=1};
	__property Graphics::TFont* Font = {read=fFont, write=SetFont};
	__property int StartDay = {read=FStartDay, write=SetStartDay, nodefault};
	__property int StartMonth = {read=FStartMonth, write=SetStartMonth, nodefault};
	__property int StartYear = {read=FStartYear, write=SetStartYear, nodefault};
	__property System::Byte SpliterV = {read=fspliterV, write=SetSpliterV, nodefault};
	__property System::Byte SpliterH = {read=fspliterH, write=SetSpliterH, nodefault};
	__property Graphics::TColor SplitterColor = {read=FSplitterColor, write=SetSplitterColor, nodefault};
	__property bool SplitterBevel = {read=FSPlitterBevel, write=SetSplitterBevel, nodefault};
	__property Graphics::TColor LineColor = {read=FLineColor, write=SetLineColor, nodefault};
	__property bool Line3D = {read=FLine3D, write=SetLine3D, nodefault};
	__property TGradientDirection GradientDirection = {read=FGradientDirection, write=SetGradientDirection, nodefault};
	__property Graphics::TColor GradientStartColor = {read=FGradientStartColor, write=SetGradientStartColor, nodefault};
	__property Graphics::TColor GradientEndColor = {read=FGradientEndColor, write=SetGradientEndColor, nodefault};
	__property TGradientDirection MonthGradientDirection = {read=FMonthGradientDirection, write=setMonthGradientDirection, nodefault};
	__property Graphics::TColor MonthGradientStartColor = {read=FMonthGradientStartColor, write=SetMonthGradientStartColor, nodefault};
	__property Graphics::TColor MonthGradientEndColor = {read=FMonthGradientEndColor, write=SetMonthGradientEndColor, nodefault};
	__property TCalendarBrowsers* Browsers = {read=FBrowsers, write=FBrowsers};
	__property System::UnicodeString HintPrevYear = {read=FHintPrevYear, write=SetHintPrevYear};
	__property System::UnicodeString HintPrevMonth = {read=FHintPrevMonth, write=SetHintPrevMonth};
	__property System::UnicodeString HintNextYear = {read=FHintNextYear, write=SetHintNextYear};
	__property System::UnicodeString HintNextMonth = {read=FHintNextMonth, write=SetHintNextMonth};
	__property TCalGlyphs* Glyphs = {read=FGlyphs, write=SetGlyphs};
	__property bool AutoThemeAdapt = {read=FAutoThemeAdapt, write=SetAutoThemeAdapt, nodefault};
	__property BorderStyle = {default=0};
	__property BevelInner = {default=0};
	__property BevelOuter = {default=2};
	__property int BevelWidth = {read=GetBevelWidth, write=SetBevelWidth, nodefault};
	__property int BorderWidth = {read=GetBorderWidth, write=SetBorderWidth, nodefault};
	__property Controls::TBevelCut CalendarBevelInner = {read=FBevelInner, write=SetBebelInnerEx, nodefault};
	__property Controls::TBevelCut CalendarBevelOuter = {read=FBevelOuter, write=SetBevelOuterEx, nodefault};
	__property int CalendarBevelWidth = {read=FBevelWidth, write=SetBevelWidthEx, nodefault};
	__property int CalendarBorderWidth = {read=FBorderWidth, write=SetBorderWidthEx, nodefault};
	__property Forms::TBorderStyle CalendarBorderStyle = {read=FBorderStyle, write=SetBorderStyleEx, nodefault};
	__property Graphics::TColor DateDownColor = {read=FDateDownColor, write=FDateDownColor, nodefault};
	__property Graphics::TColor DateHoverColor = {read=FDateHoverColor, write=FDateHoverColor, nodefault};
	__property Graphics::TColor DateSelectColor = {read=FDateSelectColor, write=SetDateSelectColor, default=8421376};
	__property Graphics::TColor DateSelectBorderColor = {read=FDateSelectBorderColor, write=SetDateSelectBorderColor, default=8421376};
	__property TTodayStyle TodayStyle = {read=FTodayStyle, write=SetTodayStyle, default=0};
	__property Graphics::TColor TodayLineColor = {read=FTodayLineColor, write=SetTodayLineColor, default=0};
	__property Hint;
	__property ShowHint;
	__property ParentShowHint = {default=1};
	__property System::Word Day = {read=FDay, write=SetDay, default=1};
	__property System::Word Month = {read=GetMonth, write=SetMonth, default=1};
	__property System::Word Year = {read=GetYear, write=SetYear, default=1};
	__property TPlannerCalendarLook Look = {read=FLook, write=SetLook, nodefault};
	__property bool MultiSelect = {read=FMultiSelect, write=SetMultiSelect, nodefault};
	__property Graphics::TFont* DayFont = {read=FDayFont, write=SetDayFont};
	__property Graphics::TFont* WeekFont = {read=FWeekFont, write=SetWeekFont};
	__property System::UnicodeString WeekName = {read=FWeekName, write=SetWeekName};
	__property bool WeekSelect = {read=FWeekSelect, write=SetWeekSelect, default=0};
	__property TNameOfDays* NameOfDays = {read=FNameOfDays, write=SetNameOfDays};
	__property TNameOfMonths* NameOfMonths = {read=FNameOfMonths, write=SetNameOfMonths};
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Graphics::TColor TextColor = {read=FTextColor, write=SetTextColor, nodefault};
	__property Graphics::TColor SelectColor = {read=FSelectColor, write=SetSelectColor, nodefault};
	__property Graphics::TColor SelectFontColor = {read=FSelectFontColor, write=SetSelectFontColor, nodefault};
	__property Graphics::TColor InActiveColor = {read=FInactiveColor, write=SetInactiveColor, nodefault};
	__property Graphics::TColor HeaderColor = {read=FHeaderColor, write=SetHeaderColor, nodefault};
	__property Graphics::TColor FocusColor = {read=FFocusColor, write=SetFocusColor, nodefault};
	__property Graphics::TColor InversColor = {read=FInversColor, write=SetInversColor, nodefault};
	__property Graphics::TColor WeekendColor = {read=FWeekendColor, write=SetWeekendColor, nodefault};
	__property bool ShowSelection = {read=FShowSelection, write=SetShowSelection, nodefault};
	__property bool ShowToday = {read=FShowToday, write=SetShowToday, nodefault};
	__property bool ShowWeeks = {read=FShowWeeks, write=SetShowWeeks, nodefault};
	__property bool ShowMonthSelector = {read=FShowMonthSelector, write=SetShowMonthSelector, default=1};
	__property bool ShowYearSelector = {read=FShowYearSelector, write=SetShowYearSelector, default=1};
	__property bool EventHints = {read=FEventHints, write=SetEventHints, nodefault};
	__property Graphics::TColor CaptionColor = {read=FCaptionColor, write=SetCaptionColor, default=536870911};
	__property Graphics::TColor CaptionTextColor = {read=FCaptionTextColor, write=SetCaptionTextColor, default=536870911};
	__property TYearStartAt* YearStartAt = {read=FYearStartAt, write=FYearStartAt};
	__property TDaySelectEvent OnDaySelect = {read=FOnDaySelect, write=SetFOnDaySelect};
	__property Classes::TNotifyEvent OnMonthSelect = {read=FOnMonthSelect, write=SetFOnMonthSelect};
	__property TGetDateEvent OnGetDateHint = {read=FOnGetDateEvent, write=SetFOnGetDateEvent};
	__property TGetDateEventHint OnGetDateHintString = {read=FOnGetDateEventHint, write=SetFOnGetDateEventHint};
	__property TDateChangeEvent OnMonthChange = {read=FOnMonthChange, write=SetFOnMonthChange};
	__property TDateChangeEvent OnYearChange = {read=FOnYearChange, write=SetFOnYearChange};
	__property TDateChangeEvent OnDayChange = {read=FOnDayChange, write=SetFOnDayChange};
	__property TDateChangeEvent OnDateChange = {read=FOnDateChange, write=SetFOnDateChange};
	__property TCancelledChangeEvent OnCancelledChange = {read=FOnCancelledChange, write=SetFOnCancelledChange};
	__property TCellDrawEvent OnCellDraw = {read=FOnCellDraw, write=FOnCellDraw};
	__property Classes::TNotifyEvent OnWeekSelect = {read=FOnWeekSelect, write=SetFOnWeekSelect};
	__property Classes::TNotifyEvent OnAllDaySelect = {read=FOnAllDaySelect, write=SetFOnAllDaySelect};
	__property OnDblClick;
	__property OnKeyDown = {read=FOnKeyDown, write=SetFOnKeyDown};
	__property OnKeyPress = {read=FOnKeyPress, write=SetFOnKeyPress};
	__property OnKeyUp = {read=FOnKeyUp, write=SetFOnKeyUp};
	__property OnMouseMove = {read=FOnMouseMove, write=SetFOnMouseMove};
	__property OnMouseDown = {read=FOnMouseDown, write=SetFOnMouseDown};
	__property OnMouseUp = {read=FOnMouseUp, write=SetFOnMouseUp};
	__property OnDragDrop = {read=FOnDragDrop, write=SetFOnDragDrop};
	__property OnDragOver = {read=FOnDragOver, write=SetFOnDragOver};
	__property OnEndDrag = {read=FOnEndDrag, write=SetFOnEndDrag};
	__property OnStartDrag = {read=FOnStartDrag, write=SetFOnStartDrag};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property Visible = {default=1};
public:
	/* TWinControl.CreateParented */ inline __fastcall TPlannerCalendarGroup(HWND ParentWindow) : TCustomCalendarPanel(ParentWindow) { }
	
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
extern PACKAGE StaticArray<System::Word, 13> adaysinmonth;
extern PACKAGE StaticArray<SmallString<5> , 12> monames;
#define selstr L"Select month"
static const ShortInt labelx = 0x1e;
static const ShortInt labelw = 0x41;
static const ShortInt CW = 0x10;
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x9;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Plannercal */
using namespace Plannercal;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlannercalHPP
