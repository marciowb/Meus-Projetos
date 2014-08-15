// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Plannermonthview.pas' rev: 21.00

#ifndef PlannermonthviewHPP
#define PlannermonthviewHPP

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
#include <Menus.hpp>	// Pascal unit
#include <Picturecontainer.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Printers.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Planner.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Planxpvs.hpp>	// Pascal unit
#include <Advimage.hpp>	// Pascal unit
#include <Dateutils.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Plannermonthview
{
//-- type declarations -------------------------------------------------------
typedef Controls::THintInfo THintInfo;

typedef Controls::PHintInfo PHintInfo;

#pragma option push -b-
enum TPlannerMonthViewStyle { pmsWindowsXP, pmsOffice2000, pmsOffice2003Blue, pmsOffice2003Olive, pmsOffice2003Silver, pmsFlat, pmsAvantGarde, pmsWhidbey, pmsOffice2007Luna, pmsOffice2007Obsidian, pmsOffice2003Classic, pmsCustom, pmsOffice2007Silver, pmsWindowsVista, pmsWindows7, pmsTerminal, pmsOffice2010Blue, pmsOffice2010Silver, pmsOffice2010Black };
#pragma option pop

class DELPHICLASS TMonthPlannerItem;
class PASCALIMPLEMENTATION TMonthPlannerItem : public Planner::TPlannerItem
{
	typedef Planner::TPlannerItem inherited;
	
private:
	int FEndCell;
	int FBeginCell;
	Classes::TStringList* FPosSt;
	System::TDateTime FEndTime;
	System::TDateTime FStartTime;
	
protected:
	__property Classes::TStringList* PosSt = {read=FPosSt};
	__property int BeginCell = {read=FBeginCell, write=FBeginCell, nodefault};
	__property int EndCell = {read=FEndCell, write=FEndCell, nodefault};
	virtual void __fastcall SetItemEndTime(const System::TDateTime Value);
	virtual void __fastcall SetItemStartTime(const System::TDateTime Value);
	virtual System::TDateTime __fastcall GetItemEndTime(void);
	virtual System::TDateTime __fastcall GetItemStartTime(void);
	virtual System::UnicodeString __fastcall GetItemEndTimeStr(void);
	virtual System::UnicodeString __fastcall GetItemStartTimeStr(void);
	virtual System::UnicodeString __fastcall GetItemSpanTimeStr(void);
	virtual void __fastcall Repaint(void);
	
public:
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__fastcall virtual TMonthPlannerItem(Classes::TCollection* Collection);
	__fastcall virtual ~TMonthPlannerItem(void);
	virtual void __fastcall Update(void);
	virtual System::UnicodeString __fastcall GetCaptionTimeString(void);
	void __fastcall MoveMonthPlannerItem(System::TDateTime NewStartTime, System::TDateTime NewEndTime, bool Done, bool &Allow);
};


class DELPHICLASS TMonthPlannerRichEdit;
class PASCALIMPLEMENTATION TMonthPlannerRichEdit : public Comctrls::TRichEdit
{
	typedef Comctrls::TRichEdit inherited;
	
private:
	TMonthPlannerItem* FPlannerItem;
	
protected:
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	
__published:
	__property TMonthPlannerItem* PlannerItem = {read=FPlannerItem, write=FPlannerItem};
public:
	/* TCustomRichEdit.Create */ inline __fastcall virtual TMonthPlannerRichEdit(Classes::TComponent* AOwner) : Comctrls::TRichEdit(AOwner) { }
	/* TCustomRichEdit.Destroy */ inline __fastcall virtual ~TMonthPlannerRichEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TMonthPlannerRichEdit(HWND ParentWindow) : Comctrls::TRichEdit(ParentWindow) { }
	
};


class DELPHICLASS TPlannerItemsEx;
class PASCALIMPLEMENTATION TPlannerItemsEx : public Planner::TPlannerItems
{
	typedef Planner::TPlannerItems inherited;
	
public:
	virtual Classes::TCollectionItemClass __fastcall GetItemClass(void);
public:
	/* TPlannerItems.Create */ inline __fastcall TPlannerItemsEx(Planner::TCustomPlanner* AOwner) : Planner::TPlannerItems(AOwner) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TPlannerItemsEx(void) { }
	
};


class DELPHICLASS TPlannerEx;
class PASCALIMPLEMENTATION TPlannerEx : public Planner::TPlanner
{
	typedef Planner::TPlanner inherited;
	
public:
	virtual Planner::TPlannerItems* __fastcall CreateItems(void);
public:
	/* TCustomPlanner.Create */ inline __fastcall virtual TPlannerEx(Classes::TComponent* AOwner) : Planner::TPlanner(AOwner) { }
	/* TCustomPlanner.Destroy */ inline __fastcall virtual ~TPlannerEx(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TPlannerEx(HWND ParentWindow) : Planner::TPlanner(ParentWindow) { }
	
};


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

typedef void __fastcall (__closure *TGetDateEvent)(System::TObject* Sender, System::TDateTime dt, bool &isEvent);

typedef void __fastcall (__closure *TDateBalloonEvent)(System::TObject* Sender, System::TDateTime ADate, System::UnicodeString &ATitle, System::UnicodeString &AText, int &AIcon);

typedef void __fastcall (__closure *TGetDateEventHint)(System::TObject* Sender, System::TDateTime dt, bool &isEvent, System::UnicodeString &EventHint);

#pragma option push -b-
enum TEventShape { evsRectangle, evsCircle, evsSquare, evsTriangle, evsNone };
#pragma option pop

#pragma option push -b-
enum TGradientDirection { gdHorizontal, gdVertical };
#pragma option pop

#pragma option push -b-
enum TTodayStyle { tsSunken, tsRaised, tsFlat, tsCaption };
#pragma option pop

class DELPHICLASS TSelDateItem;
class PASCALIMPLEMENTATION TSelDateItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::TDateTime FDate;
	void __fastcall SetDate(const System::TDateTime Value);
	HIDESBASE void __fastcall Changed(void);
	
public:
	__fastcall virtual ~TSelDateItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property System::TDateTime Date = {read=FDate, write=SetDate};
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
class DELPHICLASS TCustomMonthViewPanel;
class PASCALIMPLEMENTATION TSelDateItems : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TSelDateItem* operator[](int Index) { return Items[Index]; }
	
private:
	TCustomMonthViewPanel* FOwner;
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
	__fastcall TSelDateItems(TCustomMonthViewPanel* AOwner);
	HIDESBASE TSelDateItem* __fastcall Add(void);
	HIDESBASE TSelDateItem* __fastcall Insert(int Index);
	__property TSelDateItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property TSelDateItem* Dates[System::TDateTime dt] = {read=GetDate};
	void __fastcall AddRange(System::TDateTime dt1, System::TDateTime dt2);
	void __fastcall DelRange(System::TDateTime dt1, System::TDateTime dt2);
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
class DELPHICLASS TPlannerMonthView;
class PASCALIMPLEMENTATION TMinMaxDate : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TPlannerMonthView* FOwner;
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
	__fastcall TMinMaxDate(TPlannerMonthView* aOwner);
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
	TCustomMonthViewPanel* FOwner;
	int FStartDay;
	int FStartMonth;
	int FPrevYearStartDay;
	int FPrevYearStartMonth;
	int FNextYearStartDay;
	int FNextYearStartMonth;
	bool FISOWeekNumber;
	void __fastcall SetStartDay(int d);
	void __fastcall SetStartMonth(int m);
	void __fastcall SetPrevYearStartDay(int d);
	void __fastcall SetPrevYearStartMonth(int m);
	void __fastcall SetNextYearStartDay(int d);
	void __fastcall SetNextYearStartMonth(int m);
	bool __fastcall ValidateDay(int d);
	bool __fastcall ValidateMonth(int m);
	void __fastcall SetISOWeekNumber(const bool Value);
	
public:
	__fastcall TYearStartAt(TCustomMonthViewPanel* AOwner);
	__fastcall virtual ~TYearStartAt(void);
	
__published:
	__property bool ISOWeekNumber = {read=FISOWeekNumber, write=SetISOWeekNumber, default=0};
	__property int StartDay = {read=FStartDay, write=SetStartDay, default=1};
	__property int StartMonth = {read=FStartMonth, write=SetStartMonth, default=1};
	__property int PrevYearStartDay = {read=FPrevYearStartDay, write=SetPrevYearStartDay, default=1};
	__property int PrevYearStartMonth = {read=FPrevYearStartMonth, write=SetPrevYearStartMonth, default=1};
	__property int NextYearStartDay = {read=FNextYearStartDay, write=SetNextYearStartDay, default=1};
	__property int NextYearStartMonth = {read=FNextYearStartMonth, write=SetNextYearStartMonth, default=1};
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
	__property bool UseIntlNames = {read=FUseIntlNames, write=SetUseIntlNames, nodefault};
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


class DELPHICLASS TPlannerMonthViewPrintOptions;
class PASCALIMPLEMENTATION TPlannerMonthViewPrintOptions : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	int FFooterSize;
	int FLeftMargin;
	int FRightMargin;
	int FHeaderSize;
	Graphics::TFont* FHeaderFont;
	Graphics::TFont* FFooterFont;
	Printers::TPrinterOrientation FOrientation;
	Classes::TStrings* FFooter;
	Classes::TStrings* FHeader;
	Classes::TAlignment FHeaderAlignment;
	Classes::TAlignment FFooterAlignment;
	System::UnicodeString FJobname;
	void __fastcall SetFooter(const Classes::TStrings* Value);
	void __fastcall SetFooterFont(const Graphics::TFont* Value);
	void __fastcall SetHeader(const Classes::TStrings* Value);
	void __fastcall SetHeaderFont(const Graphics::TFont* Value);
	
public:
	__fastcall TPlannerMonthViewPrintOptions(void);
	__fastcall virtual ~TPlannerMonthViewPrintOptions(void);
	
__published:
	__property Classes::TStrings* Footer = {read=FFooter, write=SetFooter};
	__property Classes::TAlignment FooterAlignment = {read=FFooterAlignment, write=FFooterAlignment, default=0};
	__property Graphics::TFont* FooterFont = {read=FFooterFont, write=SetFooterFont};
	__property int FooterSize = {read=FFooterSize, write=FFooterSize, default=0};
	__property Classes::TStrings* Header = {read=FHeader, write=SetHeader};
	__property Classes::TAlignment HeaderAlignment = {read=FHeaderAlignment, write=FHeaderAlignment, default=0};
	__property Graphics::TFont* HeaderFont = {read=FHeaderFont, write=SetHeaderFont};
	__property int HeaderSize = {read=FHeaderSize, write=FHeaderSize, default=0};
	__property System::UnicodeString JobName = {read=FJobname, write=FJobname};
	__property int LeftMargin = {read=FLeftMargin, write=FLeftMargin, default=0};
	__property Printers::TPrinterOrientation Orientation = {read=FOrientation, write=FOrientation, default=0};
	__property int RightMargin = {read=FRightMargin, write=FRightMargin, default=0};
};


#pragma option push -b-
enum TPlannerMonthViewLook { lookFlat, look3D };
#pragma option pop

class PASCALIMPLEMENTATION TCustomMonthViewPanel : public Extctrls::TCustomPanel
{
	typedef Extctrls::TCustomPanel inherited;
	
protected:
	virtual void __fastcall UpdateYearStart(void);
	virtual void __fastcall DoPaint(void);
	virtual void __fastcall RepaintDate(System::TDateTime dt);
	
__published:
	__property Visible = {default=1};
public:
	/* TCustomPanel.Create */ inline __fastcall virtual TCustomMonthViewPanel(Classes::TComponent* AOwner) : Extctrls::TCustomPanel(AOwner) { }
	
public:
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TCustomMonthViewPanel(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomMonthViewPanel(HWND ParentWindow) : Extctrls::TCustomPanel(ParentWindow) { }
	
};


typedef void __fastcall (__closure *TImageChangeEvent)(System::TObject* Sender);

typedef void __fastcall (__closure *TEditDoneEvent)(System::TObject* Sender, Controls::TModalResult ModalResult);

typedef void __fastcall (__closure *TItemMovedEvent)(System::TObject* Sender, Planner::TPlannerItem* APlannerItem, System::TDateTime FromStartDate, System::TDateTime FromEndDate, System::TDateTime ToStartDate, System::TDateTime ToEndDate);

typedef TItemMovedEvent TItemSizedEvent;

typedef void __fastcall (__closure *TItemAllowMovingEvent)(System::TObject* Sender, Planner::TPlannerItem* APlannerItem, System::TDateTime FromStartDate, System::TDateTime FromEndDate, System::TDateTime ToStartDate, System::TDateTime ToEndDate, bool &Allow);

typedef TItemAllowMovingEvent TItemAllowSizingEvent;

typedef void __fastcall (__closure *TDayCellPaintEvent)(System::TObject* Sender, System::TDateTime Date, System::UnicodeString &Caption, Graphics::TBrush* CaptionBrush, Graphics::TFont* AFont, Graphics::TColor &BKColor, Graphics::TColor &BKColorTo);

typedef void __fastcall (__closure *TDayDrawEvent)(System::TObject* Sender, System::TDateTime Date, Graphics::TCanvas* Canvas, const Types::TRect &ARect, bool Selected);

class DELPHICLASS TPlannerMonthViewItems;
class PASCALIMPLEMENTATION TPlannerMonthViewItems : public Planner::TPlannerItems
{
	typedef Planner::TPlannerItems inherited;
	
private:
	TPlannerMonthView* FPlannerMonthView;
	
protected:
	__property TPlannerMonthView* PlannerMonthView = {read=FPlannerMonthView, write=FPlannerMonthView};
	
public:
	virtual Classes::TCollectionItemClass __fastcall GetItemClass(void);
	virtual void __fastcall SetConflicts(void);
	Planner::TPlannerItem* __fastcall FindItemAtDate(System::TDateTime ADate, int X, int Y);
	int __fastcall NumItemsAtDate(System::TDateTime ADate);
	HIDESBASE void __fastcall FocusItem(Planner::TPlannerItem* APlannerItem);
	bool __fastcall HasMonthPlannerItem(System::TDateTime FromDate, System::TDateTime ToDate);
public:
	/* TPlannerItems.Create */ inline __fastcall TPlannerMonthViewItems(Planner::TCustomPlanner* AOwner) : Planner::TPlannerItems(AOwner) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TPlannerMonthViewItems(void) { }
	
};


class DELPHICLASS TItemScroller;
class PASCALIMPLEMENTATION TItemScroller : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	int FMin;
	int FMax;
	int FPosition;
	bool FVisible;
	void __fastcall SetMax(const int Value);
	void __fastcall SetMin(const int Value);
	void __fastcall SetPosition(const int Value);
	void __fastcall SetVisible(const bool Value);
	
public:
	__fastcall TItemScroller(void);
	bool __fastcall CanGoForward(void);
	bool __fastcall CanGoBack(void);
	__property int Min = {read=FMin, write=SetMin, nodefault};
	__property int Max = {read=FMax, write=SetMax, nodefault};
	__property int Position = {read=FPosition, write=SetPosition, nodefault};
	__property bool Visible = {read=FVisible, write=SetVisible, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TItemScroller(void) { }
	
};


class PASCALIMPLEMENTATION TPlannerMonthView : public TCustomMonthViewPanel
{
	typedef TCustomMonthViewPanel inherited;
	
private:
	double FHTMLFactor;
	Planner::TPlanner* FPlanner;
	TSelDateItems* DateCol;
	int xoffset;
	int yoffset;
	System::TDateTime SelDate;
	System::TDateTime Thedate;
	System::TDateTime Clkdate;
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
	TPlannerMonthViewLook FLook;
	bool FAllowItemEdit;
	TCalendarBrowsers* FBrowsers;
	bool FMonthSelect;
	bool FMultiSelect;
	bool FDisjunctSelect;
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
	Graphics::TColor FInversBkColor;
	Graphics::TColor FInversBkColorTo;
	Graphics::TColor FWeekendColor;
	Graphics::TColor FWeekendTextColor;
	Graphics::TColor FHeaderColor;
	bool FShowWeeks;
	int FStartDay;
	System::Word FDay;
	System::Word FMonth;
	System::Word FYear;
	Graphics::TFont* FDayFont;
	Graphics::TFont* FWeekFont;
	System::UnicodeString FWeekName;
	TDaySelectEvent FOnDaySelect;
	TDaySelectEvent FOnDblClick;
	Classes::TNotifyEvent FOnMonthSelect;
	TGetDateEventHint FOnGetDateEventHint;
	TDateChangeEvent FOnDateChange;
	TDateChangeEvent FOnMonthChange;
	TDateChangeEvent FOnYearChange;
	TDateChangeEvent FOnDayChange;
	TDateChangeEvent FOnMonthChanged;
	TDateChangeEvent FOnYearChanged;
	Advimage::TAdvImage* FImage;
	TBackGroundPosition FBackgroundPosition;
	bool FShowDaysAfter;
	bool FShowDaysBefore;
	bool FShowSelection;
	bool FShowSelectionFull;
	bool FShowMonthPopup;
	bool FShowYearPopup;
	bool FShowFocusRectangle;
	bool FWeekSelect;
	bool FAllDaySelect;
	TCancelledChangeEvent FOnCancelledChange;
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
	Graphics::TCanvas* FCanvas;
	bool FBorderXP;
	Graphics::TColor FCaptionHoverColor;
	int FWeekNameY;
	int FDayNumberHeight;
	bool FShowLines;
	Graphics::TColor FTrackColor;
	Planner::TPlannerItem* FDefaultItem;
	TPlannerMonthViewItems* FDefaultItems;
	Planner::TItemEvent FOnItemExit;
	Planner::TItemEvent FOnItemEnter;
	Planner::TItemEvent FOnItemActivate;
	Planner::TItemEvent FOnItemDeActivate;
	Planner::TItemEvent FOnItemSelect;
	Planner::TItemEvent FOnItemUnSelect;
	Classes::TNotifyEvent FOnItemUpdate;
	Planner::TItemEvent FOnItemStartEdit;
	Planner::TItemEvent FOnItemEndEdit;
	bool FTrackOnly;
	bool FTrackBump;
	bool FTrackProportional;
	int FTrackWidth;
	Graphics::TBitmap* FURLGlyph;
	Graphics::TColor FURLColor;
	Graphics::TBitmap* FDeleteGlyph;
	Graphics::TColor FShadowColor;
	Graphics::TColor FFlashColor;
	Graphics::TColor FFlashFontColor;
	bool FDragItem;
	bool FDirectDrag;
	Planner::TPlannerItemText FOnItemText;
	int FPaintMarginLX;
	int FPaintMarginBY;
	int FPaintMarginRX;
	int FPaintMarginTY;
	Controls::TImageList* FPlannerImages;
	Picturecontainer::TPictureContainer* FContainer;
	Picturecontainer::THTMLPictureCache* FImageCache;
	Planner::TItemBalloonEvent FOnItemBalloon;
	TDateBalloonEvent FOnDateBalloon;
	int FImageOffsetX;
	int FImageOffsetY;
	Graphics::TBitmap* FAttachementGlyph;
	Graphics::TColor FColorCurrent;
	Graphics::TColor FColorCurrentItem;
	int FItemSpace;
	TPlannerMonthViewItems* FPlannerMonthItems;
	Graphics::TFont* FCaptionFont;
	int FCaptionHeight;
	bool FShowCaption;
	int FDayFontHeight;
	Planner::TPlannerMemo* FMemo;
	Planner::TPlannerMaskEdit* FMaskEdit;
	System::TDateTime FToolTipPos;
	TMonthPlannerRichEdit* FRichEdit;
	Planner::TBalloonSettings* FBalloon;
	Planner::TCustomEditEvent FOnCustomEdit;
	bool FDirectMove;
	bool FMouseDownMove;
	Types::TPoint FMouseXY;
	System::TDateTime FStartMovedate;
	bool FOverlap;
	bool FMouseOverTrack;
	bool FMouseOnItemStart;
	bool FMouseOnItemEnd;
	bool FMouseDownResize;
	bool FAutoInsDel;
	Planner::TPlannerItem* FPopupPlannerItem;
	Planner::TPlannerItem* FHintItem;
	Planner::TItemEvent FOnItemCreated;
	Planner::TItemEvent FOnItemDeleted;
	TItemMovedEvent FOnItemMove;
	TItemAllowMovingEvent FOnItemMoving;
	TItemMovedEvent FOnItemSize;
	TItemAllowMovingEvent FOnItemSizing;
	Graphics::TColor FCaptionColorTo;
	TGradientDirection FCaptionGradientDirection;
	TDayCellPaintEvent FOnGetDayProp;
	TDayDrawEvent FOnDayDraw;
	bool FAutoChangeMonth;
	int FWeekWidth;
	Planner::TPlannerSkin* FSkin;
	Menus::TPopupMenu* FItemPopup;
	bool FShowCurrent;
	bool FShowCurrentItem;
	Planner::TItemEvent FOnItemRightClick;
	Planner::TItemEvent FOnItemLeftClick;
	Planner::TItemEvent FOnItemDblClick;
	Planner::TItemLinkEvent FOnItemURLClick;
	Planner::TItemLinkEvent FOnItemAttachementClick;
	Planner::TItemHintEvent FOnItemHint;
	Planner::TItemPopupPrepareEvent FOnItemPopupPrepare;
	Planner::TItemDragEvent FOnItemDrag;
	Planner::TPlannerPrintHFEvent FOnPrintHeader;
	Planner::TPlannerPrintHFEvent FOnPrintFooter;
	Planner::TPlannerPrintEvent FOnPrintStart;
	int FMaxItemsDisplayed;
	bool FShowScrollColumn;
	Graphics::TColor FArrowColor;
	System::TDateTime FOldSelDate;
	System::UnicodeString FDateFormat;
	TPlannerMonthViewPrintOptions* FPrintOptions;
	StaticArray<TItemScroller*, 6> FItemScrollerAry;
	unsigned FHToolTip;
	StaticArray<System::WideChar, 4097> FToolTipBuffer;
	bool FAutoThemeAdapt;
	TPlannerMonthViewStyle FStyle;
	System::TDateTime FMouseDownStartDate;
	System::TDateTime FMouseDownEndDate;
	Classes::TAlignment FDayAlignment;
	Classes::TAlignment FDayCaptionAlignment;
	int FFindIndex;
	Graphics::TColor FTodayColor;
	Graphics::TColor FTodayColorTo;
	bool FIsEditing;
	Planner::TCompletion* FCompletion;
	HIDESBASE MESSAGE void __fastcall WMNotify(Messages::TWMNotify &Message);
	HIDESBASE MESSAGE void __fastcall WMCommand(Messages::TWMCommand &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	void __fastcall BalloonInit(void);
	void __fastcall BalloonDone(void);
	void __fastcall BalloonChange(System::TObject* Sender);
	void __fastcall CreateToolTip(void);
	void __fastcall AddToolTip(int IconType, System::UnicodeString Text, System::UnicodeString Title);
	void __fastcall DestroyToolTip(void);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Msg);
	void __fastcall SetLabel(System::Word mo, System::Word ye);
	void __fastcall ChangeMonth(int dx);
	void __fastcall ChangeYear(int dx);
	void __fastcall DiffCheck(System::TDateTime dt1, System::TDateTime dt2);
	System::TDateTime __fastcall DiffMonth(int dx);
	System::TDateTime __fastcall DiffYear(int dx);
	bool __fastcall CheckDateRange(System::TDateTime dt);
	bool __fastcall CheckMonth(System::TDateTime dt);
	System::Word __fastcall DaysInMonth(System::Word mo, System::Word ye);
	void __fastcall PaintArrowLeft(const Types::TRect &PaintRect);
	void __fastcall PaintArrowRight(const Types::TRect &PaintRect);
	void __fastcall PaintDblArrowLeft(const Types::TRect &PaintRect);
	void __fastcall PaintDblArrowRight(const Types::TRect &PaintRect);
	void __fastcall PaintLabel(const Types::TRect &PaintRect);
	void __fastcall PaintProc(const Types::TRect &PaintRect, bool Print);
	void __fastcall PaintMonthPlannerItem(Graphics::TCanvas* Canvas, const Types::TRect &ARect, Planner::TPlannerItem* APlannerItem, bool ForwardArrow, bool BackArrow, bool Print);
	void __fastcall CheckAndDrawEvent(System::TDateTime d, const Types::TRect &R, int RowNo, int ColNo, bool Print);
	void __fastcall PaintUpScrollBtn(int RowNo);
	void __fastcall PaintDownScrollBtn(int RowNo);
	void __fastcall SetLook(TPlannerMonthViewLook AValue);
	void __fastcall SetShowToday(bool AValue);
	void __fastcall SetDayFont(Graphics::TFont* AValue);
	void __fastcall SetWeekFont(Graphics::TFont* AValue);
	void __fastcall SetTextColor(Graphics::TColor AColor);
	void __fastcall SetFocusColor(Graphics::TColor AColor);
	void __fastcall SetInversColor(Graphics::TColor AColor);
	void __fastcall SetInversBkColor(Graphics::TColor AColor);
	void __fastcall SetInversBkColorTo(Graphics::TColor AColor);
	void __fastcall SetWeekendTextColor(Graphics::TColor AColor);
	void __fastcall SetWeekendColor(Graphics::TColor AColor);
	void __fastcall SetSelectColor(Graphics::TColor AColor);
	void __fastcall SetSelectFontColor(Graphics::TColor AColor);
	void __fastcall SetInactiveColor(Graphics::TColor AColor);
	void __fastcall SetHeaderColor(Graphics::TColor AColor);
	void __fastcall SetWeekName(const System::UnicodeString Value);
	void __fastcall PlanFontChanged(System::TObject* Sender);
	HIDESBASE void __fastcall SetFont(Graphics::TFont* Value);
	void __fastcall SetNameofDays(TNameOfDays* ANameofDays);
	void __fastcall SetNameofMonths(TNameOfMonths* ANameofMonths);
	void __fastcall SetShowWeeks(bool AValue);
	HIDESBASE void __fastcall SetShowCaption(bool AValue);
	void __fastcall SetStartDay(int AValue);
	void __fastcall SetCalDay(System::Word AValue);
	void __fastcall SetCalMonth(System::Word AValue);
	void __fastcall SetCalYear(System::Word AValue);
	void __fastcall SetDayAlignment(const Classes::TAlignment AAlignment);
	void __fastcall SetDayCaptionAlignment(const Classes::TAlignment AAlignment);
	System::Word __fastcall GetCalDay(void);
	System::Word __fastcall GetCalMonth(void);
	System::Word __fastcall GetMonth(System::TDateTime &dt);
	System::Word __fastcall GetCalYear(void);
	int __fastcall GetYear(System::TDateTime dt);
	System::TDateTime __fastcall XYToDate(int X, int Y, bool Change);
	System::TDateTime __fastcall GetDateProc(void);
	void __fastcall SetDateCol(const TSelDateItems* Value);
	TSelDateItems* __fastcall GetDateCol(void);
	void __fastcall DoMonthPopup(void);
	void __fastcall DoYearPopup(void);
	void __fastcall PropsChanged(System::TObject* Sender);
	void __fastcall SetLineColor(Graphics::TColor AValue);
	void __fastcall SetLine3D(bool AValue);
	void __fastcall DrawGradient(Graphics::TCanvas* Canvas, Graphics::TColor FromColor, Graphics::TColor ToColor, int Steps, const Types::TRect &r, bool Direction);
	void __fastcall SetImage(const Advimage::TAdvImage* Value);
	void __fastcall SetBackgroundPosition(const TBackGroundPosition Value);
	void __fastcall BackgroundChanged(System::TObject* Sender);
	System::UnicodeString __fastcall GetDatesAsText(void);
	void __fastcall SetShowDaysAfter(const bool Value);
	void __fastcall SetShowDaysBefore(const bool Value);
	void __fastcall SetShowSelection(const bool Value);
	void __fastcall SetShowSelectionFull(const bool Value);
	void __fastcall SetShowFocusRectangle(const bool Value);
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
	void __fastcall SetTodayColor(const Graphics::TColor Value);
	void __fastcall SetTodayColorTo(const Graphics::TColor Value);
	int __fastcall NumRows(void);
	int __fastcall NumCols(void);
	void __fastcall SetBorderXP(const bool Value);
	void __fastcall SetShowLines(const bool Value);
	void __fastcall SetTrackColor(const Graphics::TColor Value);
	void __fastcall SetDefaultItem(const Planner::TPlannerItem* Value);
	void __fastcall SetTrackBump(const bool Value);
	void __fastcall SetTrackOnly(const bool Value);
	void __fastcall SetTrackProportional(const bool Value);
	void __fastcall SetTrackWidth(const int Value);
	void __fastcall SetURLColor(const Graphics::TColor Value);
	void __fastcall SetURLGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetDeleteGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetShadowColor(const Graphics::TColor Value);
	void __fastcall SetFlashColor(const Graphics::TColor Value);
	void __fastcall SetFlashFontColor(const Graphics::TColor Value);
	void __fastcall SetImages(const Controls::TImageList* Value);
	void __fastcall SetAttachementGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetColorCurrent(const Graphics::TColor Value);
	void __fastcall SetColorCurrentItem(const Graphics::TColor Value);
	void __fastcall SetAutoThemeAdapt(const bool Value);
	void __fastcall SetStyle(const TPlannerMonthViewStyle Value);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	void __fastcall SetItemSpace(const int Value);
	void __fastcall SetCaptionFont(const Graphics::TFont* Value);
	void __fastcall SetCaptionHeight(const int Value);
	int __fastcall GetCaptionHeight(void);
	void __fastcall SetEditDirectSelection(const Types::TRect &ARect, int X, int Y);
	void __fastcall StartEdit(Planner::TPlannerItem* APlannerItem, System::TDateTime aDate, int X, int Y);
	Types::TRect __fastcall ItemRectAtDate(Planner::TPlannerItem* APlannerItem, System::TDateTime aDate);
	Types::TRect __fastcall ItemRectAtRow(Planner::TPlannerItem* APlannerItem, int RowNo);
	void __fastcall SetCaptionColorTo(const Graphics::TColor Value);
	void __fastcall SetCaptionGradientDirection(const TGradientDirection Value);
	void __fastcall SetWeekWidth(const int Value);
	void __fastcall SetShowCurrent(const bool Value);
	void __fastcall SetShowCurrentItem(const bool Value);
	void __fastcall URLGlyphOnChange(System::TObject* Sender);
	void __fastcall AttachementGlyphOnChange(System::TObject* Sender);
	void __fastcall PlannerItemActivate(System::TObject* Sender, Planner::TPlannerItem* Item);
	void __fastcall PlannerItemDeActivate(System::TObject* Sender, Planner::TPlannerItem* Item);
	void __fastcall PlannerItemEnter(System::TObject* Sender, Planner::TPlannerItem* Item);
	void __fastcall PlannerItemExit(System::TObject* Sender, Planner::TPlannerItem* Item);
	void __fastcall PlannerItemText(System::TObject* Sender, Planner::TPlannerItem* Item, System::UnicodeString &Text);
	void __fastcall PlannerItemSelected(System::TObject* Sender, Planner::TPlannerItem* Item);
	void __fastcall SetMaxItemsDisplayed(const int Value);
	void __fastcall SetShowScrollColumn(const bool Value);
	Types::TRect __fastcall GetUpScrollBtnRect(int RowNo);
	Types::TRect __fastcall GetDownScrollBtnRect(int RowNo);
	int __fastcall GetMaxConflict(System::TDateTime FromDate, System::TDateTime ToDate);
	void __fastcall SetVersion(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetCursorEx(const Controls::TCursor Value);
	Controls::TCursor __fastcall GetCursorEx(void);
	Planner::TCompletion* __fastcall GetCompletion(void);
	void __fastcall SetCompletion(const Planner::TCompletion* Value);
	
protected:
	virtual void __fastcall SetDateProc(const System::TDateTime Value);
	void __fastcall InvalidateRectangle(const Types::TRect &ARect, bool Bkg);
	virtual void __fastcall UpdateYearStartAtISO(void);
	virtual void __fastcall DoPaint(void);
	virtual void __fastcall RepaintDate(System::TDateTime dt);
	void __fastcall PaintCalendar(Graphics::TCanvas* ACanvas, const Types::TRect &PaintRect, bool Print);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall WndProc(Messages::TMessage &Msg);
	virtual bool __fastcall CanResize(int &NewWidth, int &NewHeight);
	void __fastcall ThemeAdapt(void);
	void __fastcall DateColChanged(System::TObject* Sender);
	void __fastcall CompletionChanged(System::TObject* Sender);
	void __fastcall SkinChange(System::TObject* Sender);
	virtual void __fastcall DoChangeMonth(System::TDateTime dt1, System::TDateTime dt2);
	virtual void __fastcall DoChangeYear(System::TDateTime dt1, System::TDateTime dt2);
	virtual void __fastcall DoMonthChanged(System::TDateTime dt1, System::TDateTime dt2);
	virtual void __fastcall DoYearChanged(System::TDateTime dt1, System::TDateTime dt2);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	virtual void __fastcall ItemSelected(Planner::TPlannerItem* Item);
	virtual void __fastcall ItemUnSelected(Planner::TPlannerItem* Item);
	virtual void __fastcall ItemUpdated(System::TObject* Sender);
	virtual void __fastcall ItemMoved(Planner::TPlannerItem* APlannerItem, System::TDateTime FromStartDate, System::TDateTime FromEndDate, System::TDateTime ToStartDate, System::TDateTime ToEndDate);
	virtual void __fastcall ItemMoving(Planner::TPlannerItem* APlannerItem, System::TDateTime FromStartDate, System::TDateTime FromEndDate, System::TDateTime ToStartDate, System::TDateTime ToEndDate, bool &Allow);
	virtual void __fastcall ItemSized(Planner::TPlannerItem* APlannerItem, System::TDateTime FromStartDate, System::TDateTime FromEndDate, System::TDateTime ToStartDate, System::TDateTime ToEndDate);
	virtual void __fastcall ItemSizing(Planner::TPlannerItem* APlannerItem, System::TDateTime FromStartDate, System::TDateTime FromEndDate, System::TDateTime ToStartDate, System::TDateTime ToEndDate, bool &Allow);
	virtual void __fastcall ItemEdited(System::TObject* Sender, Planner::TPlannerItem* Item);
	virtual int __fastcall GetVersionNr(void);
	virtual System::UnicodeString __fastcall GetVersionString(void);
	TItemScroller* __fastcall GetItemScroller(int RowNo);
	void __fastcall SetItemScrollerPosition(void);
	__property bool UseTheme = {read=FUseTheme, nodefault};
	__property int PaintMarginTY = {read=FPaintMarginTY, write=FPaintMarginTY, nodefault};
	__property int PaintMarginLX = {read=FPaintMarginLX, write=FPaintMarginLX, nodefault};
	__property int PaintMarginBY = {read=FPaintMarginBY, write=FPaintMarginBY, nodefault};
	__property int PaintMarginRX = {read=FPaintMarginRX, write=FPaintMarginRX, nodefault};
	__property int ImageOffsetX = {read=FImageOffsetX, write=FImageOffsetX, nodefault};
	__property int ImageOffsetY = {read=FImageOffsetY, write=FImageOffsetY, nodefault};
	__property Graphics::TColor FlashColor = {read=FFlashColor, write=SetFlashColor, nodefault};
	__property Graphics::TColor FlashFontColor = {read=FFlashFontColor, write=SetFlashFontColor, nodefault};
	virtual TPlannerMonthViewItems* __fastcall CreateItems(Planner::TCustomPlanner* AOwner);
	void __fastcall DoPrint(Graphics::TCanvas* ACanvas);
	virtual void __fastcall DoItemPopupPrepare(System::TObject* Sender, Menus::TPopupMenu* PopupMenu, Planner::TPlannerItem* Item);
	
public:
	__fastcall virtual TPlannerMonthView(Classes::TComponent* AOwner);
	__fastcall virtual ~TPlannerMonthView(void);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	void __fastcall TextToRich(const System::UnicodeString RtfText);
	System::UnicodeString __fastcall RichToText(void);
	Types::TRect __fastcall DateToRect(System::TDateTime dt);
	void __fastcall SetDate(System::Word da, System::Word mo, System::Word ye);
	void __fastcall GetDate(System::Word &da, System::Word &mo, System::Word &ye);
	void __fastcall GetStartDate(System::Word &da, System::Word &mo, System::Word &ye);
	void __fastcall GetEndDate(System::Word &da, System::Word &mo, System::Word &ye);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	void __fastcall ResetUpdate(void);
	__property bool IsEditing = {read=FIsEditing, write=FIsEditing, nodefault};
	virtual Planner::TPlannerItem* __fastcall CreateItemAtSelection(void);
	virtual Planner::TPlannerItem* __fastcall CreateItem(void);
	virtual void __fastcall FreeItem(Planner::TPlannerItem* APlannerItem);
	virtual void __fastcall UpdateItem(Planner::TPlannerItem* APlannerItem);
	virtual void __fastcall DoDaySelect(System::TDateTime ADay);
	bool __fastcall DateAtXY(int x, int y, System::TDateTime &ADate);
	Types::TPoint __fastcall DateToXY(System::TDateTime dt);
	Planner::TPlannerItem* __fastcall FindFirstItemAtDate(System::TDateTime ADate);
	Planner::TPlannerItem* __fastcall FindNextItemAtDate(System::TDateTime ADate);
	bool __fastcall HasPlannerItem(System::TDateTime FromDate, System::TDateTime ToDate);
	__property System::TDateTime Date = {read=GetDateProc, write=SetDateProc};
	__property TSelDateItems* Dates = {read=GetDateCol, write=SetDateCol};
	__property System::UnicodeString DatesAsText = {read=GetDatesAsText};
	__property Planner::TPlannerItem* PopupPlannerItem = {read=FPopupPlannerItem};
	__property bool DirectDrag = {read=FDirectDrag, write=FDirectDrag, nodefault};
	System::TDateTime __fastcall FirstDate(void);
	System::TDateTime __fastcall LastDate(void);
	void __fastcall Print(void);
	void __fastcall PrintTo(Graphics::TCanvas* Canvas);
	__property bool AllDaySelect = {read=FAllDaySelect, write=FAllDaySelect, default=0};
	__property TPlannerMonthViewStyle Style = {read=FStyle, write=SetStyle, nodefault};
	__property int VersionNr = {read=GetVersionNr, nodefault};
	__property System::UnicodeString VersionString = {read=GetVersionString};
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property bool AllowItemEdit = {read=FAllowItemEdit, write=FAllowItemEdit, default=1};
	__property Graphics::TBitmap* AttachementGlyph = {read=FAttachementGlyph, write=SetAttachementGlyph};
	__property bool AutoInsDel = {read=FAutoInsDel, write=FAutoInsDel, default=0};
	__property bool AutoChangeMonth = {read=FAutoChangeMonth, write=FAutoChangeMonth, default=1};
	__property bool AutoThemeAdapt = {read=FAutoThemeAdapt, write=SetAutoThemeAdapt, default=0};
	__property Advimage::TAdvImage* Background = {read=FImage, write=SetImage};
	__property TBackGroundPosition BackgroundPosition = {read=FBackgroundPosition, write=SetBackgroundPosition, default=4};
	__property Planner::TBalloonSettings* Balloon = {read=FBalloon, write=FBalloon};
	__property BevelInner = {default=0};
	__property BevelOuter = {default=2};
	__property BevelWidth = {default=1};
	__property BorderWidth = {default=0};
	__property BorderStyle = {default=0};
	__property bool BorderXP = {read=FBorderXP, write=SetBorderXP, default=1};
	__property TCalendarBrowsers* Browsers = {read=FBrowsers, write=FBrowsers};
	__property Graphics::TColor CaptionColor = {read=FCaptionColor, write=SetCaptionColor, default=536870911};
	__property Graphics::TColor CaptionColorTo = {read=FCaptionColorTo, write=SetCaptionColorTo, default=536870911};
	__property TGradientDirection CaptionGradientDirection = {read=FCaptionGradientDirection, write=SetCaptionGradientDirection, default=0};
	__property Graphics::TColor CaptionHoverColor = {read=FCaptionHoverColor, write=FCaptionHoverColor, default=-16777203};
	__property Graphics::TFont* CaptionFont = {read=FCaptionFont, write=SetCaptionFont};
	__property int CaptionHeight = {read=GetCaptionHeight, write=SetCaptionHeight, default=13};
	__property Color = {default=-16777201};
	__property Graphics::TColor ColorCurrent = {read=FColorCurrent, write=SetColorCurrent, default=65535};
	__property Graphics::TColor ColorCurrentItem = {read=FColorCurrentItem, write=SetColorCurrentItem, default=65280};
	__property Planner::TCompletion* Completion = {read=GetCompletion, write=SetCompletion};
	__property Controls::TCursor Cursor = {read=GetCursorEx, write=SetCursorEx, nodefault};
	__property System::UnicodeString DateFormat = {read=FDateFormat, write=FDateFormat};
	__property Classes::TAlignment DayAlignment = {read=FDayAlignment, write=SetDayAlignment, default=1};
	__property Classes::TAlignment DayCaptionAlignment = {read=FDayCaptionAlignment, write=SetDayCaptionAlignment, default=0};
	__property Graphics::TFont* DayFont = {read=FDayFont, write=SetDayFont};
	__property Planner::TPlannerItem* DefaultItem = {read=FDefaultItem, write=SetDefaultItem};
	__property Graphics::TBitmap* DeleteGlyph = {read=FDeleteGlyph, write=SetDeleteGlyph};
	__property bool DirectMove = {read=FDirectMove, write=FDirectMove, default=0};
	__property bool DisjunctSelect = {read=FDisjunctSelect, write=FDisjunctSelect, default=0};
	__property bool DragItem = {read=FDragItem, write=FDragItem, default=0};
	__property DragMode = {default=0};
	__property Graphics::TColor FocusColor = {read=FFocusColor, write=SetFocusColor, default=-16777203};
	__property Graphics::TFont* Font = {read=fFont, write=SetFont};
	__property TCalGlyphs* Glyphs = {read=FGlyphs, write=SetGlyphs};
	__property Graphics::TColor GradientStartColor = {read=FGradientStartColor, write=SetGradientStartColor, default=16777215};
	__property Graphics::TColor GradientEndColor = {read=FGradientEndColor, write=SetGradientEndColor, default=-16777201};
	__property TGradientDirection GradientDirection = {read=FGradientDirection, write=SetGradientDirection, default=0};
	__property Graphics::TColor HeaderColor = {read=FHeaderColor, write=SetHeaderColor, default=536870911};
	__property System::UnicodeString HintPrevYear = {read=FHintPrevYear, write=SetHintPrevYear};
	__property System::UnicodeString HintPrevMonth = {read=FHintPrevMonth, write=SetHintPrevMonth};
	__property System::UnicodeString HintNextMonth = {read=FHintNextMonth, write=SetHintNextMonth};
	__property System::UnicodeString HintNextYear = {read=FHintNextYear, write=SetHintNextYear};
	__property Graphics::TColor InActiveColor = {read=FInactiveColor, write=SetInactiveColor, default=8421504};
	__property Graphics::TColor InversColor = {read=FInverscolor, write=SetInversColor, default=8421376};
	__property Graphics::TColor InversBkColor = {read=FInversBkColor, write=SetInversBkColor, default=536870911};
	__property Graphics::TColor InversBkColorTo = {read=FInversBkColorTo, write=SetInversBkColorTo, default=536870911};
	__property TPlannerMonthViewItems* Items = {read=FPlannerMonthItems, write=FPlannerMonthItems};
	__property Menus::TPopupMenu* ItemPopup = {read=FItemPopup, write=FItemPopup};
	__property int ItemSpace = {read=FItemSpace, write=SetItemSpace, default=2};
	__property Graphics::TColor LineColor = {read=FLineColor, write=SetLineColor, default=8421504};
	__property bool Line3D = {read=FLine3D, write=SetLine3D, default=1};
	__property TPlannerMonthViewLook Look = {read=FLook, write=SetLook, default=0};
	__property TMinMaxDate* MaxDate = {read=FMaxDate, write=FMaxDate};
	__property TMinMaxDate* MinDate = {read=FMinDate, write=FMinDate};
	__property int MaxItemsDisplayed = {read=FMaxItemsDisplayed, write=SetMaxItemsDisplayed, default=3};
	__property Graphics::TColor MonthGradientStartColor = {read=FMonthGradientStartColor, write=SetMonthGradientStartColor, default=536870911};
	__property Graphics::TColor MonthGradientEndColor = {read=FMonthGradientEndColor, write=SetMonthGradientEndColor, default=536870911};
	__property TGradientDirection MonthGradientDirection = {read=FMonthGradientDirection, write=SetMonthGradientDirection, default=0};
	__property bool MultiSelect = {read=FMultiSelect, write=FMultiSelect, default=0};
	__property TNameOfDays* NameOfDays = {read=FNameOfDays, write=SetNameofDays};
	__property TNameOfMonths* NameOfMonths = {read=FNameOfMonths, write=SetNameofMonths};
	__property Picturecontainer::TPictureContainer* PictureContainer = {read=FContainer, write=FContainer};
	__property Controls::TImageList* PlannerImages = {read=FPlannerImages, write=SetImages};
	__property PopupMenu;
	__property TPlannerMonthViewPrintOptions* PrintOptions = {read=FPrintOptions, write=FPrintOptions};
	__property bool ReturnIsSelect = {read=FReturnIsSelect, write=FReturnIsSelect, default=0};
	__property Graphics::TColor SelectColor = {read=FSelectColor, write=SetSelectColor, default=8421376};
	__property Graphics::TColor SelectFontColor = {read=FSelectFontColor, write=SetSelectFontColor, default=16777215};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, default=8421504};
	__property bool ShowDaysBefore = {read=FShowDaysBefore, write=SetShowDaysBefore, default=1};
	__property bool ShowDaysAfter = {read=FShowDaysAfter, write=SetShowDaysAfter, default=1};
	__property ShowHint;
	__property Planner::TPlannerSkin* Skin = {read=FSkin, write=FSkin};
	__property bool Overlap = {read=FOverlap, write=FOverlap, default=1};
	__property ParentShowHint = {default=1};
	__property bool ShowCaption = {read=FShowCaption, write=SetShowCaption, default=1};
	__property bool ShowCurrent = {read=FShowCurrent, write=SetShowCurrent, default=0};
	__property bool ShowCurrentItem = {read=FShowCurrentItem, write=SetShowCurrentItem, default=0};
	__property bool ShowLines = {read=FShowLines, write=SetShowLines, default=1};
	__property bool ShowScrollColumn = {read=FShowScrollColumn, write=SetShowScrollColumn, default=0};
	__property bool ShowSelection = {read=FShowSelection, write=SetShowSelection, default=1};
	__property bool ShowSelectionFull = {read=FShowSelectionFull, write=SetShowSelectionFull, default=1};
	__property bool ShowYearPopup = {read=FShowYearPopup, write=FShowYearPopup, default=1};
	__property bool ShowMonthPopup = {read=FShowMonthPopup, write=FShowMonthPopup, default=1};
	__property bool ShowFocusRectangle = {read=FShowFocusRectangle, write=SetShowFocusRectangle, default=1};
	__property bool ShowToday = {read=FShowToday, write=SetShowToday, default=0};
	__property bool ShowWeeks = {read=FShowWeeks, write=SetShowWeeks, default=0};
	__property int StartDay = {read=FStartDay, write=SetStartDay, default=7};
	__property Graphics::TColor TextColor = {read=FTextcolor, write=SetTextColor, default=0};
	__property TabStop = {default=0};
	__property TabOrder = {default=-1};
	__property Graphics::TColor TodayColor = {read=FTodayColor, write=SetTodayColor, default=-16777203};
	__property Graphics::TColor TodayColorTo = {read=FTodayColorTo, write=SetTodayColorTo, default=536870911};
	__property TTodayStyle TodayStyle = {read=FTodayStyle, write=SetTodayStyle, default=0};
	__property Graphics::TColor TrackColor = {read=FTrackColor, write=SetTrackColor, default=16711680};
	__property bool TrackBump = {read=FTrackBump, write=SetTrackBump, default=0};
	__property bool TrackOnly = {read=FTrackOnly, write=SetTrackOnly, default=0};
	__property bool TrackProportional = {read=FTrackProportional, write=SetTrackProportional, default=0};
	__property int TrackWidth = {read=FTrackWidth, write=SetTrackWidth, default=4};
	__property Graphics::TColor URLColor = {read=FURLColor, write=SetURLColor, default=16711680};
	__property Graphics::TBitmap* URLGlyph = {read=FURLGlyph, write=SetURLGlyph};
	__property Graphics::TFont* WeekFont = {read=FWeekFont, write=SetWeekFont};
	__property System::UnicodeString WeekName = {read=FWeekName, write=SetWeekName, stored=true};
	__property bool WeekSelect = {read=FWeekSelect, write=FWeekSelect, default=0};
	__property Graphics::TColor WeekendColor = {read=FWeekendColor, write=SetWeekendColor, default=536870911};
	__property Graphics::TColor WeekendTextColor = {read=FWeekendTextColor, write=SetWeekendTextColor, default=255};
	__property int WeekWidth = {read=FWeekWidth, write=SetWeekWidth, default=30};
	__property TYearStartAt* YearStartAt = {read=FYearStartAt, write=FYearStartAt};
	__property System::Word Day = {read=GetCalDay, write=SetCalDay, default=1};
	__property System::Word Month = {read=GetCalMonth, write=SetCalMonth, default=1};
	__property System::Word Year = {read=GetCalYear, write=SetCalYear, default=1};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property Visible = {default=1};
	__property Planner::TItemEvent OnItemEnter = {read=FOnItemEnter, write=FOnItemEnter};
	__property Planner::TItemEvent OnItemExit = {read=FOnItemExit, write=FOnItemExit};
	__property Planner::TItemEvent OnItemActivate = {read=FOnItemActivate, write=FOnItemActivate};
	__property Planner::TItemEvent OnItemDeActivate = {read=FOnItemDeActivate, write=FOnItemDeActivate};
	__property Planner::TItemDragEvent OnItemDrag = {read=FOnItemDrag, write=FOnItemDrag};
	__property Planner::TItemEvent OnItemLeftClick = {read=FOnItemLeftClick, write=FOnItemLeftClick};
	__property Planner::TItemEvent OnItemRightClick = {read=FOnItemRightClick, write=FOnItemRightClick};
	__property Planner::TItemEvent OnItemDblClick = {read=FOnItemDblClick, write=FOnItemDblClick};
	__property Planner::TItemLinkEvent OnItemURLClick = {read=FOnItemURLClick, write=FOnItemURLClick};
	__property Planner::TItemLinkEvent OnItemAttachementClick = {read=FOnItemAttachementClick, write=FOnItemAttachementClick};
	__property Planner::TItemHintEvent OnItemHint = {read=FOnItemHint, write=FOnItemHint};
	__property Planner::TItemEvent OnItemSelect = {read=FOnItemSelect, write=FOnItemSelect};
	__property Planner::TItemEvent OnItemUnSelect = {read=FOnItemUnSelect, write=FOnItemUnSelect};
	__property Classes::TNotifyEvent OnItemUpdate = {read=FOnItemUpdate, write=FOnItemUpdate};
	__property Planner::TItemEvent OnItemStartEdit = {read=FOnItemStartEdit, write=FOnItemStartEdit};
	__property Planner::TItemEvent OnItemEndEdit = {read=FOnItemEndEdit, write=FOnItemEndEdit};
	__property Planner::TPlannerItemText OnItemText = {read=FOnItemText, write=FOnItemText};
	__property Planner::TItemPopupPrepareEvent OnItemPopupPrepare = {read=FOnItemPopupPrepare, write=FOnItemPopupPrepare};
	__property Planner::TCustomEditEvent OnCustomEdit = {read=FOnCustomEdit, write=FOnCustomEdit};
	__property Planner::TItemBalloonEvent OnItemBalloon = {read=FOnItemBalloon, write=FOnItemBalloon};
	__property TDateBalloonEvent OnDateBalloon = {read=FOnDateBalloon, write=FOnDateBalloon};
	__property Planner::TItemEvent OnItemCreated = {read=FOnItemCreated, write=FOnItemCreated};
	__property Planner::TItemEvent OnItemDeleted = {read=FOnItemDeleted, write=FOnItemDeleted};
	__property TItemMovedEvent OnItemMove = {read=FOnItemMove, write=FOnItemMove};
	__property TItemAllowMovingEvent OnItemMoving = {read=FOnItemMoving, write=FOnItemMoving};
	__property TItemMovedEvent OnItemSize = {read=FOnItemSize, write=FOnItemSize};
	__property TItemAllowMovingEvent OnItemSizing = {read=FOnItemSizing, write=FOnItemSizing};
	__property TDayCellPaintEvent OnGetDayProp = {read=FOnGetDayProp, write=FOnGetDayProp};
	__property TDayDrawEvent OnDayDraw = {read=FOnDayDraw, write=FOnDayDraw};
	__property TDaySelectEvent OnDaySelect = {read=FOnDaySelect, write=FOnDaySelect};
	__property TDaySelectEvent OnDblClick = {read=FOnDblClick, write=FOnDblClick};
	__property Classes::TNotifyEvent OnMonthSelect = {read=FOnMonthSelect, write=FOnMonthSelect};
	__property TGetDateEventHint OnGetDateHintString = {read=FOnGetDateEventHint, write=FOnGetDateEventHint};
	__property TDateChangeEvent OnMonthChange = {read=FOnMonthChange, write=FOnMonthChange};
	__property TDateChangeEvent OnYearChange = {read=FOnYearChange, write=FOnYearChange};
	__property TDateChangeEvent OnMonthChanged = {read=FOnMonthChanged, write=FOnMonthChanged};
	__property TDateChangeEvent OnYearChanged = {read=FOnYearChanged, write=FOnYearChanged};
	__property TDateChangeEvent OnDayChange = {read=FOnDayChange, write=FOnDayChange};
	__property TDateChangeEvent OnDateChange = {read=FOnDateChange, write=FOnDateChange};
	__property TCancelledChangeEvent OnCancelledChange = {read=FOnCancelledChange, write=FOnCancelledChange};
	__property Classes::TNotifyEvent OnWeekSelect = {read=FOnWeekSelect, write=FOnWeekSelect};
	__property Classes::TNotifyEvent OnAllDaySelect = {read=FOnAllDaySelect, write=FOnAllDaySelect};
	__property Planner::TPlannerPrintHFEvent OnPrintHeader = {read=FOnPrintHeader, write=FOnPrintHeader};
	__property Planner::TPlannerPrintHFEvent OnPrintFooter = {read=FOnPrintFooter, write=FOnPrintFooter};
	__property Planner::TPlannerPrintEvent OnPrintStart = {read=FOnPrintStart, write=FOnPrintStart};
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseMove;
	__property OnMouseDown;
	__property OnMouseWheelDown;
	__property OnMouseWheelUp;
	__property OnMouseUp;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnStartDrag;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnResize;
public:
	/* TWinControl.CreateParented */ inline __fastcall TPlannerMonthView(HWND ParentWindow) : TCustomMonthViewPanel(ParentWindow) { }
	
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
static const ShortInt MIN_VER = 0x5;
static const ShortInt REL_VER = 0xa;
static const ShortInt BLD_VER = 0x1;
#define DATE_VER L"Jul, 2010"
extern PACKAGE StaticArray<System::Word, 13> adaysinmonth;
extern PACKAGE StaticArray<SmallString<5> , 12> monames;
#define selstr L"Select month"
static const ShortInt labelx = 0x1e;
static const ShortInt labelw = 0x41;
static const ShortInt CW = 0x10;
static const ShortInt MM = 0x2;
static const ShortInt CORNER_EFFECT = 0xa;
#define RtfStart L"{\\"
#define HtmlEndTagStart L"</"
static const ShortInt EDITOFFSET = 0x4;
static const ShortInt ScrollColumnSize = 0xc;

}	/* namespace Plannermonthview */
using namespace Plannermonthview;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlannermonthviewHPP
