// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Planrecurredit.pas' rev: 21.00

#ifndef PlanrecurreditHPP
#define PlanrecurreditHPP

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
#include <Comctrls.hpp>	// Pascal unit
#include <Planrecurr.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Planrecurredit
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TRecurrEdit;
class PASCALIMPLEMENTATION TRecurrEdit : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TButton* Button1;
	Stdctrls::TButton* Button2;
	Comctrls::TPageControl* PageControl1;
	Comctrls::TTabSheet* TabSheet1;
	Comctrls::TTabSheet* TabSheet2;
	Extctrls::TRadioGroup* Freq;
	Stdctrls::TGroupBox* GroupBox1;
	Stdctrls::TLabel* Label1;
	Extctrls::TNotebook* Notebook1;
	Stdctrls::TRadioButton* rDay;
	Stdctrls::TRadioButton* rWeekDay;
	Stdctrls::TCheckBox* cMon;
	Stdctrls::TCheckBox* cTue;
	Stdctrls::TCheckBox* cWed;
	Stdctrls::TCheckBox* cThu;
	Stdctrls::TCheckBox* cFri;
	Stdctrls::TCheckBox* cSat;
	Stdctrls::TCheckBox* cSun;
	Stdctrls::TRadioButton* rMonthDay;
	Stdctrls::TRadioButton* rSpecialDay;
	Stdctrls::TComboBox* cWeekNum;
	Stdctrls::TComboBox* cDay;
	Stdctrls::TLabel* Label3;
	Stdctrls::TLabel* Label4;
	Stdctrls::TLabel* Label5;
	Stdctrls::TLabel* Label6;
	Stdctrls::TLabel* Label7;
	Stdctrls::TLabel* Label8;
	Stdctrls::TLabel* Label9;
	Stdctrls::TLabel* Label10;
	Stdctrls::TLabel* Label11;
	Stdctrls::TLabel* Label12;
	Stdctrls::TLabel* Label13;
	Stdctrls::TLabel* Label14;
	Stdctrls::TRadioButton* rYearDay;
	Stdctrls::TComboBox* cYearDay;
	Stdctrls::TRadioButton* rYearSpecialDay;
	Stdctrls::TComboBox* cYearWeekNum;
	Stdctrls::TCheckBox* yck1;
	Stdctrls::TCheckBox* yck2;
	Stdctrls::TCheckBox* yck3;
	Stdctrls::TCheckBox* yck4;
	Stdctrls::TCheckBox* yck5;
	Stdctrls::TCheckBox* yck6;
	Stdctrls::TCheckBox* yck7;
	Stdctrls::TCheckBox* yck8;
	Stdctrls::TCheckBox* yck9;
	Stdctrls::TCheckBox* yck10;
	Stdctrls::TCheckBox* yck11;
	Stdctrls::TCheckBox* yck12;
	Stdctrls::TEdit* Interval;
	Stdctrls::TGroupBox* GroupBox2;
	Stdctrls::TLabel* Label2;
	Stdctrls::TRadioButton* rInfinite;
	Stdctrls::TRadioButton* rUntil;
	Stdctrls::TRadioButton* rUntilDate;
	Comctrls::TDateTimePicker* cDate;
	Stdctrls::TEdit* cOccur;
	Comctrls::TDateTimePicker* exsd;
	Stdctrls::TListBox* ExList;
	Stdctrls::TButton* Button3;
	Stdctrls::TButton* Button4;
	Comctrls::TDateTimePicker* exst;
	Comctrls::TDateTimePicker* exed;
	Comctrls::TDateTimePicker* exet;
	Stdctrls::TButton* Button5;
	Stdctrls::TLabel* Label15;
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall FreqClick(System::TObject* Sender);
	void __fastcall Button5Click(System::TObject* Sender);
	void __fastcall Button3Click(System::TObject* Sender);
	void __fastcall Button4Click(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	
private:
	System::UnicodeString FRecurrency;
	void __fastcall SetRecurrency(const System::UnicodeString Value);
	
public:
	Planrecurr::TDateItems* ExDates;
	__property System::UnicodeString Recurrency = {read=FRecurrency, write=SetRecurrency};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TRecurrEdit(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TRecurrEdit(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TRecurrEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TRecurrEdit(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


class DELPHICLASS TRecurrencyDialogLanguage;
class PASCALIMPLEMENTATION TRecurrencyDialogLanguage : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	System::UnicodeString FCaption;
	System::UnicodeString FExceptions;
	System::UnicodeString FSettings;
	System::UnicodeString FRange;
	System::UnicodeString FRecurrencyPattern;
	System::UnicodeString FPatternDetails;
	System::UnicodeString FRangeFor;
	System::UnicodeString FRangeOccurences;
	System::UnicodeString FRangeInfinite;
	System::UnicodeString FRangeUntil;
	System::UnicodeString FFreqWeekly;
	System::UnicodeString FFreqDaily;
	System::UnicodeString FFreqHourly;
	System::UnicodeString FFreqYearly;
	System::UnicodeString FFreqNone;
	System::UnicodeString FFreqMonthly;
	System::UnicodeString FButtonRemove;
	System::UnicodeString FButtonAdd;
	System::UnicodeString FButtonClear;
	System::UnicodeString FButtonCancel;
	System::UnicodeString FButtonOK;
	System::UnicodeString FEveryDay;
	System::UnicodeString FEveryWeekDay;
	System::UnicodeString FDayFriday;
	System::UnicodeString FDayThursday;
	System::UnicodeString FDayMonday;
	System::UnicodeString FDayTuesday;
	System::UnicodeString FDaySaturday;
	System::UnicodeString FDaySunday;
	System::UnicodeString FDayWednesday;
	System::UnicodeString FMonthJanuary;
	System::UnicodeString FMonthFebruary;
	System::UnicodeString FMonthMarch;
	System::UnicodeString FMonthApril;
	System::UnicodeString FMonthMay;
	System::UnicodeString FMonthJune;
	System::UnicodeString FMonthJuly;
	System::UnicodeString FMonthAugust;
	System::UnicodeString FMonthSeptember;
	System::UnicodeString FMonthOctober;
	System::UnicodeString FMonthNovember;
	System::UnicodeString FMonthDecember;
	System::UnicodeString FEveryMonthDay;
	System::UnicodeString FEveryYearDay;
	System::UnicodeString FEvery;
	System::UnicodeString FEveryThird;
	System::UnicodeString FEveryFirst;
	System::UnicodeString FEveryFourth;
	System::UnicodeString FEverySecond;
	System::UnicodeString FDayWeekend;
	System::UnicodeString FDayWeekday;
	System::UnicodeString FInterval;
	
public:
	__fastcall TRecurrencyDialogLanguage(void);
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=FCaption};
	__property System::UnicodeString Settings = {read=FSettings, write=FSettings};
	__property System::UnicodeString Exceptions = {read=FExceptions, write=FExceptions};
	__property System::UnicodeString RecurrencyPattern = {read=FRecurrencyPattern, write=FRecurrencyPattern};
	__property System::UnicodeString PatternDetails = {read=FPatternDetails, write=FPatternDetails};
	__property System::UnicodeString Range = {read=FRange, write=FRange};
	__property System::UnicodeString RangeInfinite = {read=FRangeInfinite, write=FRangeInfinite};
	__property System::UnicodeString RangeUntil = {read=FRangeUntil, write=FRangeUntil};
	__property System::UnicodeString RangeFor = {read=FRangeFor, write=FRangeFor};
	__property System::UnicodeString RangeOccurences = {read=FRangeOccurences, write=FRangeOccurences};
	__property System::UnicodeString FreqNone = {read=FFreqNone, write=FFreqNone};
	__property System::UnicodeString FreqHourly = {read=FFreqHourly, write=FFreqHourly};
	__property System::UnicodeString FreqDaily = {read=FFreqDaily, write=FFreqDaily};
	__property System::UnicodeString FreqWeekly = {read=FFreqWeekly, write=FFreqWeekly};
	__property System::UnicodeString FreqMonthly = {read=FFreqMonthly, write=FFreqMonthly};
	__property System::UnicodeString FreqYearly = {read=FFreqYearly, write=FFreqYearly};
	__property System::UnicodeString ButtonAdd = {read=FButtonAdd, write=FButtonAdd};
	__property System::UnicodeString ButtonClear = {read=FButtonClear, write=FButtonClear};
	__property System::UnicodeString ButtonRemove = {read=FButtonRemove, write=FButtonRemove};
	__property System::UnicodeString ButtonOK = {read=FButtonOK, write=FButtonOK};
	__property System::UnicodeString ButtonCancel = {read=FButtonCancel, write=FButtonCancel};
	__property System::UnicodeString Every = {read=FEvery, write=FEvery};
	__property System::UnicodeString EveryDay = {read=FEveryDay, write=FEveryDay};
	__property System::UnicodeString EveryWeekDay = {read=FEveryWeekDay, write=FEveryWeekDay};
	__property System::UnicodeString EveryMonthDay = {read=FEveryMonthDay, write=FEveryMonthDay};
	__property System::UnicodeString EveryYearDay = {read=FEveryYearDay, write=FEveryYearDay};
	__property System::UnicodeString EveryFirst = {read=FEveryFirst, write=FEveryFirst};
	__property System::UnicodeString EverySecond = {read=FEverySecond, write=FEverySecond};
	__property System::UnicodeString EveryThird = {read=FEveryThird, write=FEveryThird};
	__property System::UnicodeString EveryFourth = {read=FEveryFourth, write=FEveryFourth};
	__property System::UnicodeString Interval = {read=FInterval, write=FInterval};
	__property System::UnicodeString DayMonday = {read=FDayMonday, write=FDayMonday};
	__property System::UnicodeString DayTuesday = {read=FDayTuesday, write=FDayTuesday};
	__property System::UnicodeString DayWednesday = {read=FDayWednesday, write=FDayWednesday};
	__property System::UnicodeString DayThursday = {read=FDayThursday, write=FDayThursday};
	__property System::UnicodeString DayFriday = {read=FDayFriday, write=FDayFriday};
	__property System::UnicodeString DaySaturday = {read=FDaySaturday, write=FDaySaturday};
	__property System::UnicodeString DaySunday = {read=FDaySunday, write=FDaySunday};
	__property System::UnicodeString DayWeekday = {read=FDayWeekday, write=FDayWeekday};
	__property System::UnicodeString DayWeekend = {read=FDayWeekend, write=FDayWeekend};
	__property System::UnicodeString MonthJanuary = {read=FMonthJanuary, write=FMonthJanuary};
	__property System::UnicodeString MonthFebruary = {read=FMonthFebruary, write=FMonthFebruary};
	__property System::UnicodeString MonthMarch = {read=FMonthMarch, write=FMonthMarch};
	__property System::UnicodeString MonthApril = {read=FMonthApril, write=FMonthApril};
	__property System::UnicodeString MonthMay = {read=FMonthMay, write=FMonthMay};
	__property System::UnicodeString MonthJune = {read=FMonthJune, write=FMonthJune};
	__property System::UnicodeString MonthJuly = {read=FMonthJuly, write=FMonthJuly};
	__property System::UnicodeString MonthAugust = {read=FMonthAugust, write=FMonthAugust};
	__property System::UnicodeString MonthSeptember = {read=FMonthSeptember, write=FMonthSeptember};
	__property System::UnicodeString MonthOctober = {read=FMonthOctober, write=FMonthOctober};
	__property System::UnicodeString MonthNovember = {read=FMonthNovember, write=FMonthNovember};
	__property System::UnicodeString MonthDecember = {read=FMonthDecember, write=FMonthDecember};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TRecurrencyDialogLanguage(void) { }
	
};


class DELPHICLASS TPlannerRecurrencyEditor;
class PASCALIMPLEMENTATION TPlannerRecurrencyEditor : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	System::UnicodeString FRecurrency;
	TRecurrencyDialogLanguage* FLanguage;
	void __fastcall SetLanguage(const TRecurrencyDialogLanguage* Value);
	
public:
	bool __fastcall Execute(void);
	__fastcall virtual TPlannerRecurrencyEditor(Classes::TComponent* AOwner);
	__fastcall virtual ~TPlannerRecurrencyEditor(void);
	
__published:
	__property System::UnicodeString Recurrency = {read=FRecurrency, write=FRecurrency};
	__property TRecurrencyDialogLanguage* LanguageSettings = {read=FLanguage, write=SetLanguage};
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TRecurrEdit* RecurrEdit;

}	/* namespace Planrecurredit */
using namespace Planrecurredit;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlanrecurreditHPP
