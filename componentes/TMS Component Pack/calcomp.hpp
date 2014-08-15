// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Calcomp.pas' rev: 21.00

#ifndef CalcompHPP
#define CalcompHPP

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
#include <Dialogs.hpp>	// Pascal unit
#include <Moneycal.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Calcomp
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TShowMethod { smTop, smBottom, smDependent };
#pragma option pop

#pragma option push -b-
enum TStartDay { sdSunday, sdMonday, sdTuesday, sdWednesday, sdThursday, sdFriday, sdSaturday };
#pragma option pop

class DELPHICLASS TYearStartAt;
class PASCALIMPLEMENTATION TYearStartAt : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	int FStartDay;
	int FStartMonth;
	void __fastcall SetStartDay(int d);
	void __fastcall SetStartMonth(int m);
	
public:
	__fastcall TYearStartAt(void);
	__fastcall virtual ~TYearStartAt(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property int StartDay = {read=FStartDay, write=SetStartDay, nodefault};
	__property int StartMonth = {read=FStartMonth, write=SetStartMonth, nodefault};
};


class DELPHICLASS TNameofDays;
class PASCALIMPLEMENTATION TNameofDays : public Classes::TPersistent
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
	
public:
	__fastcall TNameofDays(void);
	__fastcall virtual ~TNameofDays(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString Monday = {read=FMonday, write=FMonday};
	__property System::UnicodeString Tuesday = {read=FTuesday, write=FTuesday};
	__property System::UnicodeString Wednesday = {read=FWednesday, write=FWednesday};
	__property System::UnicodeString Thursday = {read=FThursday, write=FThursday};
	__property System::UnicodeString Friday = {read=FFriday, write=FFriday};
	__property System::UnicodeString Saturday = {read=FSaturday, write=FSaturday};
	__property System::UnicodeString Sunday = {read=FSunday, write=FSunday};
};


class DELPHICLASS TNameofMonths;
class PASCALIMPLEMENTATION TNameofMonths : public Classes::TPersistent
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
	
public:
	__fastcall TNameofMonths(void);
	__fastcall virtual ~TNameofMonths(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString January = {read=FJanuary, write=FJanuary};
	__property System::UnicodeString February = {read=FFebruary, write=FFebruary};
	__property System::UnicodeString March = {read=FMarch, write=FMarch};
	__property System::UnicodeString April = {read=FApril, write=FApril};
	__property System::UnicodeString May = {read=FMay, write=FMay};
	__property System::UnicodeString June = {read=FJune, write=FJune};
	__property System::UnicodeString July = {read=FJuly, write=FJuly};
	__property System::UnicodeString August = {read=FAugust, write=FAugust};
	__property System::UnicodeString September = {read=FSeptember, write=FSeptember};
	__property System::UnicodeString October = {read=FOctober, write=FOctober};
	__property System::UnicodeString November = {read=FNovember, write=FNovember};
	__property System::UnicodeString December = {read=FDecember, write=FDecember};
};


class DELPHICLASS TCalComp;
class PASCALIMPLEMENTATION TCalComp : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	Moneycal::TCalForm* CalForm;
	System::Word FDay;
	System::Word FMonth;
	System::Word FYear;
	System::Word FTop;
	System::Word FLeft;
	Controls::TWinControl* FAlignControl;
	TShowMethod FShowMethod;
	Graphics::TFont* FFont;
	Graphics::TColor FColor;
	Graphics::TColor FTextColor;
	Graphics::TColor FSelectColor;
	Graphics::TColor FInversColor;
	Graphics::TColor FWeekendColor;
	TNameofDays* FNameofDays;
	TNameofMonths* FNameofMonths;
	bool FShowWeeks;
	TStartDay FFirstday;
	TYearStartAt* FYearStartAt;
	System::TDateTime FSelDateFrom;
	System::TDateTime FSelDateTo;
	System::Word __fastcall GetWeek(void);
	System::TDateTime __fastcall GetSelDate(void);
	void __fastcall SetSelDate(System::TDateTime adate);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	void __fastcall SetNameOfDays(const TNameofDays* ANameOfDays);
	void __fastcall SetNameOfMonths(const TNameofMonths* ANameOfMonths);
	void __fastcall SetYearStartAt(const TYearStartAt* AYearStartAt);
	void __fastcall SetAlignControl(Controls::TWinControl* AControl);
	void __fastcall SetFont(const Graphics::TFont* value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	
public:
	__fastcall virtual TCalComp(Classes::TComponent* AOwner);
	__fastcall virtual ~TCalComp(void);
	bool __fastcall Execute(void);
	__property System::Word Week = {read=GetWeek, nodefault};
	__property System::TDateTime SelDate = {read=GetSelDate, write=SetSelDate};
	__property System::TDateTime SelDateFrom = {read=FSelDateFrom, write=FSelDateFrom};
	__property System::TDateTime SelDateTo = {read=FSelDateTo, write=FSelDateTo};
	
__published:
	__property Controls::TWinControl* AlignControl = {read=FAlignControl, write=SetAlignControl};
	__property System::Word Day = {read=FDay, write=FDay, default=1};
	__property System::Word Month = {read=FMonth, write=FMonth, default=1};
	__property System::Word Year = {read=FYear, write=FYear, default=1};
	__property System::Word CalTop = {read=FTop, write=FTop, nodefault};
	__property System::Word CalLeft = {read=FLeft, write=FLeft, nodefault};
	__property Graphics::TColor Color = {read=FColor, write=FColor, nodefault};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Graphics::TColor TextColor = {read=FTextColor, write=FTextColor, nodefault};
	__property Graphics::TColor SelectColor = {read=FSelectColor, write=FSelectColor, nodefault};
	__property Graphics::TColor InversColor = {read=FInversColor, write=FInversColor, nodefault};
	__property TNameofDays* NameofDays = {read=FNameofDays, write=SetNameOfDays};
	__property TNameofMonths* NameofMonths = {read=FNameofMonths, write=SetNameOfMonths};
	__property Graphics::TColor WeekendColor = {read=FWeekendColor, write=FWeekendColor, nodefault};
	__property TShowMethod ShowMethod = {read=FShowMethod, write=FShowMethod, nodefault};
	__property bool ShowWeeks = {read=FShowWeeks, write=FShowWeeks, nodefault};
	__property TStartDay Firstday = {read=FFirstday, write=FFirstday, nodefault};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property TYearStartAt* YearStartAt = {read=FYearStartAt, write=SetYearStartAt};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x2;
static const ShortInt MIN_VER = 0x1;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x1;

}	/* namespace Calcomp */
using namespace Calcomp;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// CalcompHPP
