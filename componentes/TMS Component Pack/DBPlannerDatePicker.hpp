// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Dbplannerdatepicker.pas' rev: 21.00

#ifndef DbplannerdatepickerHPP
#define DbplannerdatepickerHPP

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
#include <Plannercal.hpp>	// Pascal unit
#include <Dbplannercal.hpp>	// Pascal unit
#include <Advedbtn.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Dbctrls.hpp>	// Pascal unit
#include <Advedit.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dbplannerdatepicker
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TDBPlannerDatePicker;
class PASCALIMPLEMENTATION TDBPlannerDatePicker : public Advedbtn::TAdvEditBtn
{
	typedef Advedbtn::TAdvEditBtn inherited;
	
private:
	Dbplannercal::TDBPlannerCalendar* FPlannerCalendar;
	Dbplannercal::TDBPlannerCalendar* APlannerCalendar;
	Forms::TForm* PlannerParent;
	bool CancelThisBtnClick;
	bool FHideCalendarAfterSelection;
	Plannercal::TDaySelectEvent FOnDaySelect;
	Dbctrls::TFieldDataLink* FDataLink;
	bool FInternalChange;
	Plannercal::TGetDateEvent __fastcall GetOnGetDateHint(void);
	Plannercal::TGetDateEventHint __fastcall GetOnGetDateHintString(void);
	void __fastcall SetOnGetDateHint(const Plannercal::TGetDateEvent Value);
	void __fastcall SetOnGetDateHintString(const Plannercal::TGetDateEventHint Value);
	void __fastcall HideParent(void);
	Plannercal::TEventPropEvent __fastcall GetOnGetEventProp(void);
	void __fastcall SetOnGetEventProp(const Plannercal::TEventPropEvent Value);
	Classes::TNotifyEvent __fastcall GetOnWeekSelect(void);
	void __fastcall SetOnWeekSelect(const Classes::TNotifyEvent Value);
	Classes::TNotifyEvent __fastcall GetOnAllDaySelect(void);
	void __fastcall SetOnAllDaySelect(const Classes::TNotifyEvent Value);
	System::UnicodeString __fastcall GetDataField(void);
	Db::TDataSource* __fastcall GetDataSource(void);
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall SetDataSource(const Db::TDataSource* Value);
	void __fastcall DataUpdate(System::TObject* Sender);
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall ActiveChange(System::TObject* Sender);
	System::TDateTime __fastcall GetDate(void);
	void __fastcall SetDate(const System::TDateTime Value);
	MESSAGE void __fastcall CMGetDataLink(Messages::TMessage &Message);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	virtual void __fastcall BtnClick(System::TObject* Sender);
	void __fastcall PlannerParentDeactivate(System::TObject* Sender);
	void __fastcall PlannerCalendarDaySelect(System::TObject* Sender, System::TDateTime SelDate);
	void __fastcall PlannerCalendarKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall PlannerCalendarKeyDown(System::TObject* Sender, int &Key, Classes::TShiftState Shift);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	DYNAMIC void __fastcall Change(void);
	virtual bool __fastcall EditCanModify(void);
	DYNAMIC Classes::TComponent* __fastcall GetChildParent(void);
	DYNAMIC Classes::TComponent* __fastcall GetChildOwner(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	DYNAMIC void __fastcall DoExit(void);
	
public:
	__fastcall virtual TDBPlannerDatePicker(Classes::TComponent* AOwner);
	void __fastcall CancelBtnClick(void);
	virtual void __fastcall DropDown(void);
	__fastcall virtual ~TDBPlannerDatePicker(void);
	__property System::TDateTime Date = {read=GetDate, write=SetDate};
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	
__published:
	__property Dbplannercal::TDBPlannerCalendar* Calendar = {read=FPlannerCalendar, write=FPlannerCalendar};
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property bool HideCalendarAfterSelection = {read=FHideCalendarAfterSelection, write=FHideCalendarAfterSelection, nodefault};
	__property Plannercal::TGetDateEvent OnGetDateHint = {read=GetOnGetDateHint, write=SetOnGetDateHint};
	__property Plannercal::TGetDateEventHint OnGetDateHintString = {read=GetOnGetDateHintString, write=SetOnGetDateHintString};
	__property Plannercal::TEventPropEvent OnGetEventProp = {read=GetOnGetEventProp, write=SetOnGetEventProp};
	__property Classes::TNotifyEvent OnWeekSelect = {read=GetOnWeekSelect, write=SetOnWeekSelect};
	__property Classes::TNotifyEvent OnAllDaySelect = {read=GetOnAllDaySelect, write=SetOnAllDaySelect};
	__property Plannercal::TDaySelectEvent OnDaySelect = {read=FOnDaySelect, write=FOnDaySelect};
public:
	/* TWinControl.CreateParented */ inline __fastcall TDBPlannerDatePicker(HWND ParentWindow) : Advedbtn::TAdvEditBtn(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x4;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x6;

}	/* namespace Dbplannerdatepicker */
using namespace Dbplannerdatepicker;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DbplannerdatepickerHPP
