// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Dbplannercal.pas' rev: 21.00

#ifndef DbplannercalHPP
#define DbplannercalHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Plannercal.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dbplannercal
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TEventInsertEvent)(System::TObject* Sender, Plannercal::TSelDateItem* Event);

class DELPHICLASS TDBPlannerCalendarDataLink;
class DELPHICLASS TDBPlannerCalendar;
class PASCALIMPLEMENTATION TDBPlannerCalendarDataLink : public Db::TDataLink
{
	typedef Db::TDataLink inherited;
	
private:
	TDBPlannerCalendar* FDBPlannerCalendar;
	
protected:
	virtual void __fastcall ActiveChanged(void);
	virtual void __fastcall DataSetChanged(void);
	virtual void __fastcall DataSetScrolled(int Distance);
	virtual void __fastcall RecordChanged(Db::TField* Field);
	
public:
	__fastcall TDBPlannerCalendarDataLink(TDBPlannerCalendar* ADBPlannerCalendar);
	__fastcall virtual ~TDBPlannerCalendarDataLink(void);
};


class PASCALIMPLEMENTATION TDBPlannerCalendar : public Plannercal::TPlannerCalendar
{
	typedef Plannercal::TPlannerCalendar inherited;
	
private:
	TDBPlannerCalendarDataLink* FDataLink;
	System::UnicodeString FStartTimeField;
	System::UnicodeString FEndTimeField;
	System::UnicodeString FShapeField;
	System::UnicodeString FColorField;
	System::UnicodeString FSubjectFIeld;
	bool FUpdating;
	bool FActive;
	Classes::TNotifyEvent FOnSetFilter;
	TEventInsertEvent FOnEventInsert;
	bool FAutoUpdate;
	Db::TDataSource* __fastcall GetDataSource(void);
	void __fastcall SetDataSource(const Db::TDataSource* Value);
	void __fastcall SetEndTimeField(const System::UnicodeString Value);
	void __fastcall SetStartTimeField(const System::UnicodeString Value);
	void __fastcall SetShapeField(const System::UnicodeString Value);
	void __fastcall SetColorField(const System::UnicodeString Value);
	bool __fastcall CheckDataSet(void);
	void __fastcall SetActive(const bool Value);
	void __fastcall SetSubjectField(const System::UnicodeString Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	virtual void __fastcall DoChangeMonth(System::TDateTime dt1, System::TDateTime dt2);
	virtual void __fastcall DoChangeYear(System::TDateTime dt1, System::TDateTime dt2);
	
public:
	__fastcall virtual TDBPlannerCalendar(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBPlannerCalendar(void);
	void __fastcall UpdateCalendar(void);
	
__published:
	__property bool Active = {read=FActive, write=SetActive, nodefault};
	__property bool AutoUpdate = {read=FAutoUpdate, write=FAutoUpdate, nodefault};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property System::UnicodeString StartTimeField = {read=FStartTimeField, write=SetStartTimeField};
	__property System::UnicodeString EndTimeField = {read=FEndTimeField, write=SetEndTimeField};
	__property System::UnicodeString SubjectField = {read=FSubjectFIeld, write=SetSubjectField};
	__property System::UnicodeString ShapeField = {read=FShapeField, write=SetShapeField};
	__property System::UnicodeString ColorField = {read=FColorField, write=SetColorField};
	__property Classes::TNotifyEvent OnSetFilter = {read=FOnSetFilter, write=FOnSetFilter};
	__property TEventInsertEvent OnEventInsert = {read=FOnEventInsert, write=FOnEventInsert};
public:
	/* TWinControl.CreateParented */ inline __fastcall TDBPlannerCalendar(HWND ParentWindow) : Plannercal::TPlannerCalendar(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Dbplannercal */
using namespace Dbplannercal;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DbplannercalHPP
