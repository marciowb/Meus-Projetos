// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Plannermaskdatepicker.pas' rev: 21.00

#ifndef PlannermaskdatepickerHPP
#define PlannermaskdatepickerHPP

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
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Advmedbtn.hpp>	// Pascal unit
#include <Plannercal.hpp>	// Pascal unit
#include <Maskutils.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Advedit.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Plannermaskdatepicker
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TPlannerMaskDatePicker;
class PASCALIMPLEMENTATION TPlannerMaskDatePicker : public Advmedbtn::TAdvMaskEditBtn
{
	typedef Advmedbtn::TAdvMaskEditBtn inherited;
	
private:
	Plannercal::TPlannerCalendar* FPlannerCalendar;
	Plannercal::TPlannerCalendar* APlannerCalendar;
	Forms::TForm* PlannerParent;
	bool CancelThisBtnClick;
	bool FHideCalendarAfterSelection;
	Plannercal::TDaySelectEvent FOnDaySelect;
	Classes::TNotifyEvent FOnInvalidDate;
	Plannercal::TGetDateEvent __fastcall GetOnGetDateHint(void);
	Plannercal::TGetDateEventHint __fastcall GetOnGetDateHintString(void);
	void __fastcall SetOnGetDateHint(const Plannercal::TGetDateEvent Value);
	void __fastcall SetOnGetDateHintString(const Plannercal::TGetDateEventHint Value);
	void __fastcall HideParent(void);
	Controls::TWinControl* __fastcall GetParentEx(void);
	void __fastcall SetParentEx(const Controls::TWinControl* Value);
	Plannercal::TEventPropEvent __fastcall GetOnGetEventProp(void);
	void __fastcall SetOnGetEventProp(const Plannercal::TEventPropEvent Value);
	Classes::TNotifyEvent __fastcall GetOnWeekSelect(void);
	void __fastcall SetOnWeekSelect(const Classes::TNotifyEvent Value);
	Classes::TNotifyEvent __fastcall GetOnAllDaySelect(void);
	void __fastcall SetOnAllDaySelect(const Classes::TNotifyEvent Value);
	System::TDateTime __fastcall GetDate(void);
	void __fastcall SetDate(const System::TDateTime Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	virtual void __fastcall InitEvents(void);
	virtual void __fastcall BtnClick(System::TObject* Sender);
	void __fastcall PlannerParentDeactivate(System::TObject* Sender);
	void __fastcall PlannerCalendarDaySelect(System::TObject* Sender, System::TDateTime SelDate);
	void __fastcall PlannerCalendarKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall PlannerCalendarKeyDown(System::TObject* Sender, int &Key, Classes::TShiftState Shift);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	DYNAMIC Classes::TComponent* __fastcall GetChildParent(void);
	DYNAMIC Classes::TComponent* __fastcall GetChildOwner(void);
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall DaySelect(void);
	virtual void __fastcall ValidateError(void);
	
public:
	__fastcall virtual TPlannerMaskDatePicker(Classes::TComponent* AOwner);
	void __fastcall CancelBtnClick(void);
	__fastcall virtual ~TPlannerMaskDatePicker(void);
	DYNAMIC void __fastcall DoExit(void);
	virtual void __fastcall DropDown(void);
	virtual void __fastcall CreateWnd(void);
	__property System::TDateTime Date = {read=GetDate, write=SetDate};
	__property Controls::TWinControl* Parent = {read=GetParentEx, write=SetParentEx};
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	
__published:
	__property Plannercal::TPlannerCalendar* Calendar = {read=FPlannerCalendar, write=FPlannerCalendar};
	__property bool HideCalendarAfterSelection = {read=FHideCalendarAfterSelection, write=FHideCalendarAfterSelection, nodefault};
	__property Plannercal::TGetDateEvent OnGetDateHint = {read=GetOnGetDateHint, write=SetOnGetDateHint};
	__property Plannercal::TGetDateEventHint OnGetDateHintString = {read=GetOnGetDateHintString, write=SetOnGetDateHintString};
	__property Plannercal::TEventPropEvent OnGetEventProp = {read=GetOnGetEventProp, write=SetOnGetEventProp};
	__property Classes::TNotifyEvent OnWeekSelect = {read=GetOnWeekSelect, write=SetOnWeekSelect};
	__property Classes::TNotifyEvent OnAllDaySelect = {read=GetOnAllDaySelect, write=SetOnAllDaySelect};
	__property Plannercal::TDaySelectEvent OnDaySelect = {read=FOnDaySelect, write=FOnDaySelect};
	__property Classes::TNotifyEvent OnInvalidDate = {read=FOnInvalidDate, write=FOnInvalidDate};
public:
	/* TWinControl.CreateParented */ inline __fastcall TPlannerMaskDatePicker(HWND ParentWindow) : Advmedbtn::TAdvMaskEditBtn(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x5;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x6;

}	/* namespace Plannermaskdatepicker */
using namespace Plannermaskdatepicker;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlannermaskdatepickerHPP
