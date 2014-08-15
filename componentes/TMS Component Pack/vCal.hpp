// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Vcal.pas' rev: 21.00

#ifndef VcalHPP
#define VcalHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Vcal
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TvEventStatus { esAccepted, esNeedsAction, esSent, esTentative, esConfirmed, esDeclined, esCompleted, esDelegated };
#pragma option pop

#pragma option push -b-
enum TvEventTransp { etFree, etNotFree, etOther };
#pragma option pop

#pragma option push -b-
enum TvEventClass { ecPublic, ecPrivate, ecConfidential };
#pragma option pop

#pragma option push -b-
enum TvEventCategory { caAppointment, caBusiness, caEducation, caHoliday, caMeeting, caMiscellaneous, caPersonal, caPhonecall, caSickDay, caSpecialOccasion, caTravel, caVacation };
#pragma option pop

#pragma option push -b-
enum TEventProperty { epDTStart, epDTEnd, epStatus, epPriority, epSummary, epTransp, epDescription, epURL, epUID, epLocation, epClass, epCategories, epResources, epRecurrency };
#pragma option pop

typedef Set<TvEventCategory, caAppointment, caVacation>  TvEventCategories;

class DELPHICLASS TvEvent;
class PASCALIMPLEMENTATION TvEvent : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::TDateTime FDTEnd;
	System::TDateTime FDTStart;
	int FPriority;
	TvEventStatus FStatus;
	System::UnicodeString FSummary;
	TvEventTransp FTrans;
	Classes::TStrings* FDescription;
	System::UnicodeString FURL;
	System::UnicodeString FUID;
	System::UnicodeString FLocation;
	TvEventClass FClass;
	TvEventCategories FCategories;
	Classes::TStrings* FResources;
	System::UnicodeString FAlarmMessage;
	System::TDateTime FAlarmTime;
	System::UnicodeString FRecurrency;
	void __fastcall SetDTEnd(const System::TDateTime Value);
	void __fastcall SetDTStart(const System::TDateTime Value);
	void __fastcall SetPriority(const int Value);
	void __fastcall SetStatus(const TvEventStatus Value);
	void __fastcall SetSummary(const System::UnicodeString Value);
	void __fastcall SetTransp(const TvEventTransp Value);
	void __fastcall SetDescription(const Classes::TStrings* Value);
	void __fastcall SetUID(const System::UnicodeString Value);
	void __fastcall SetURL(const System::UnicodeString Value);
	void __fastcall SetLocation(const System::UnicodeString Value);
	void __fastcall SetClass(const TvEventClass Value);
	void __fastcall SetCategories(const TvEventCategories Value);
	void __fastcall SetResources(const Classes::TStrings* Value);
	void __fastcall SetRecurrency(const System::UnicodeString Value);
	
public:
	__fastcall virtual TvEvent(Classes::TCollection* Collection);
	__fastcall virtual ~TvEvent(void);
	
__published:
	__property System::UnicodeString AlarmMessage = {read=FAlarmMessage, write=FAlarmMessage};
	__property System::TDateTime AlarmTime = {read=FAlarmTime, write=FAlarmTime};
	__property TvEventCategories Categories = {read=FCategories, write=SetCategories, nodefault};
	__property TvEventClass Classification = {read=FClass, write=SetClass, nodefault};
	__property Classes::TStrings* Description = {read=FDescription, write=SetDescription};
	__property System::TDateTime DTEnd = {read=FDTEnd, write=SetDTEnd};
	__property System::TDateTime DTStart = {read=FDTStart, write=SetDTStart};
	__property System::UnicodeString Location = {read=FLocation, write=SetLocation};
	__property int Priority = {read=FPriority, write=SetPriority, nodefault};
	__property System::UnicodeString Recurrency = {read=FRecurrency, write=SetRecurrency};
	__property Classes::TStrings* Resources = {read=FResources, write=SetResources};
	__property TvEventStatus Status = {read=FStatus, write=SetStatus, nodefault};
	__property System::UnicodeString Summary = {read=FSummary, write=SetSummary};
	__property TvEventTransp Transp = {read=FTrans, write=SetTransp, nodefault};
	__property System::UnicodeString URL = {read=FURL, write=SetURL};
	__property System::UnicodeString UID = {read=FUID, write=SetUID};
};


class DELPHICLASS TvEventCollection;
class DELPHICLASS TvCalendar;
class PASCALIMPLEMENTATION TvEventCollection : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TvEvent* operator[](int Index) { return Items[Index]; }
	
private:
	TvCalendar* FOwner;
	TvEvent* __fastcall GetvEvent(int Index);
	void __fastcall SetvEvent(int Index, const TvEvent* Value);
	
public:
	__fastcall TvEventCollection(TvCalendar* AOwner);
	HIDESBASE TvEvent* __fastcall Add(void);
	HIDESBASE TvEvent* __fastcall Insert(int Index);
	__property TvEvent* Items[int Index] = {read=GetvEvent, write=SetvEvent/*, default*/};
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TvEventCollection(void) { }
	
};


class PASCALIMPLEMENTATION TvCalendar : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	TvEventCollection* FvEvents;
	System::UnicodeString FProdID;
	System::UnicodeString FTimeZone;
	TvEventCollection* __fastcall GetvEvents(void);
	void __fastcall SetvEvents(const TvEventCollection* Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	
public:
	__fastcall virtual TvCalendar(Classes::TComponent* AOwner);
	__fastcall virtual ~TvCalendar(void);
	void __fastcall LoadFromFile(const System::UnicodeString FileName);
	void __fastcall InsertFromFile(const System::UnicodeString FileName);
	void __fastcall SaveToFile(const System::UnicodeString FileName);
	
__published:
	__property TvEventCollection* vEvents = {read=GetvEvents, write=SetvEvents};
	__property System::UnicodeString ProdID = {read=FProdID, write=FProdID};
	__property System::UnicodeString TimeZone = {read=FTimeZone, write=FTimeZone};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;
extern PACKAGE System::UnicodeString __fastcall StatusToStr(TvEventStatus AStatus);

}	/* namespace Vcal */
using namespace Vcal;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// VcalHPP
