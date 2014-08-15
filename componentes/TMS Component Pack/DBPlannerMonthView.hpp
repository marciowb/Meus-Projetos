// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Dbplannermonthview.pas' rev: 21.00

#ifndef DbplannermonthviewHPP
#define DbplannermonthviewHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Planrecurr.hpp>	// Pascal unit
#include <Plannermonthview.hpp>	// Pascal unit
#include <Planner.hpp>	// Pascal unit
#include <Dbplanner.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Comobj.hpp>	// Pascal unit
#include <Activex.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dbplannermonthview
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TPlannerDataLink;
class DELPHICLASS TDBPlannerMonthView;
class PASCALIMPLEMENTATION TPlannerDataLink : public Db::TDataLink
{
	typedef Db::TDataLink inherited;
	
private:
	TDBPlannerMonthView* FDBPlannerMonthView;
	
protected:
	virtual void __fastcall ActiveChanged(void);
	virtual void __fastcall DataSetChanged(void);
	virtual void __fastcall DataSetScrolled(int Distance);
	virtual void __fastcall RecordChanged(Db::TField* Field);
	
public:
	__fastcall TPlannerDataLink(TDBPlannerMonthView* ADBPlannerMonthView);
	__fastcall virtual ~TPlannerDataLink(void);
};


class DELPHICLASS TPlannerDataBinding;
class PASCALIMPLEMENTATION TPlannerDataBinding : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TDBPlannerMonthView* FPlannerMonthView;
	bool FAutoIncKey;
	System::UnicodeString FSubjectField;
	System::UnicodeString FStartTimeField;
	System::UnicodeString FNotesField;
	System::UnicodeString FKeyField;
	System::UnicodeString FEndTimeField;
	bool FUpdateByQuery;
	System::UnicodeString FRecurrencyField;
	System::UnicodeString FMinTimeField;
	System::UnicodeString FMaxTimeField;
	void __fastcall SetEndTimeField(const System::UnicodeString Value);
	void __fastcall SetKeyField(const System::UnicodeString Value);
	void __fastcall SetNotesField(const System::UnicodeString Value);
	void __fastcall SetStartTimeField(const System::UnicodeString Value);
	void __fastcall SetSubjectField(const System::UnicodeString Value);
	void __fastcall SetMaxTimeField(const System::UnicodeString Value);
	void __fastcall SetMinTimeField(const System::UnicodeString Value);
	void __fastcall SetRecurrencyField(const System::UnicodeString Value);
	
public:
	__fastcall TPlannerDataBinding(TDBPlannerMonthView* AOwner);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property TDBPlannerMonthView* Owner = {read=FPlannerMonthView};
	
__published:
	__property bool AutoIncKey = {read=FAutoIncKey, write=FAutoIncKey, default=0};
	__property System::UnicodeString StartTimeField = {read=FStartTimeField, write=SetStartTimeField};
	__property System::UnicodeString EndTimeField = {read=FEndTimeField, write=SetEndTimeField};
	__property System::UnicodeString KeyField = {read=FKeyField, write=SetKeyField};
	__property System::UnicodeString MinTimeField = {read=FMinTimeField, write=SetMinTimeField};
	__property System::UnicodeString MaxTimeField = {read=FMaxTimeField, write=SetMaxTimeField};
	__property System::UnicodeString NotesField = {read=FNotesField, write=SetNotesField};
	__property System::UnicodeString RecurrencyField = {read=FRecurrencyField, write=SetRecurrencyField};
	__property System::UnicodeString SubjectField = {read=FSubjectField, write=SetSubjectField};
	__property bool UpdateByQuery = {read=FUpdateByQuery, write=FUpdateByQuery, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TPlannerDataBinding(void) { }
	
};


class PASCALIMPLEMENTATION TDBPlannerMonthView : public Plannermonthview::TPlannerMonthView
{
	typedef Plannermonthview::TPlannerMonthView inherited;
	
private:
	TPlannerDataLink* FDataLink;
	bool FIsUpdating;
	Db::TDataSource* FDataSource;
	Dbplanner::TFieldsItemEvent FOnFieldsToItem;
	Dbplanner::TFieldsItemEvent FOnItemToFields;
	TPlannerDataBinding* FDataBinding;
	Dbplanner::TFieldsToTimeEvent FOnFieldsToTime;
	Dbplanner::TTimeToFieldsEvent FOnTimeToFields;
	Dbplanner::TCreateKeyEvent FOnCreateKey;
	Dbplanner::TDBItemSQLEvent FOnInsertItem;
	Dbplanner::TDBItemSQLEvent FOnDeleteItem;
	Dbplanner::TDBItemSQLEvent FOnUpdateItem;
	Planrecurr::TRecurrencyHandler* FRecurrencyHandler;
	void __fastcall SetDataSource(const Db::TDataSource* Value);
	void __fastcall SetDataBinding(const TPlannerDataBinding* Value);
	
protected:
	virtual void __fastcall SetDateProc(const System::TDateTime Value);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	virtual void __fastcall FieldsToTime(Db::TFields* Fields, System::TDateTime &dtS, System::TDateTime &dtE);
	virtual void __fastcall TimeToFields(Db::TFields* Fields, System::TDateTime dtS, System::TDateTime dtE);
	virtual void __fastcall DoChangeMonth(System::TDateTime dt1, System::TDateTime dt2);
	virtual void __fastcall DoChangeYear(System::TDateTime dt1, System::TDateTime dt2);
	void __fastcall ItemChanged(System::UnicodeString DBKey);
	virtual void __fastcall ItemSelected(Planner::TPlannerItem* Item);
	virtual void __fastcall ItemMoved(Planner::TPlannerItem* APlannerItem, System::TDateTime FromStartDate, System::TDateTime FromEndDate, System::TDateTime ToStartDate, System::TDateTime ToEndDate);
	virtual void __fastcall ItemSized(Planner::TPlannerItem* APlannerItem, System::TDateTime FromStartDate, System::TDateTime FromEndDate, System::TDateTime ToStartDate, System::TDateTime ToEndDate);
	virtual void __fastcall ItemEdited(System::TObject* Sender, Planner::TPlannerItem* Item);
	void __fastcall ClearDBKey(System::UnicodeString Key);
	bool __fastcall CheckDataSet(void);
	
public:
	__fastcall virtual TDBPlannerMonthView(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBPlannerMonthView(void);
	virtual void __fastcall Loaded(void);
	virtual Planner::TPlannerItem* __fastcall CreateItemAtSelection(void);
	Planner::TPlannerItem* __fastcall CreateNonDBItem(void);
	virtual Planner::TPlannerItem* __fastcall CreateItem(void);
	virtual void __fastcall FreeItem(Planner::TPlannerItem* APlannerItem);
	virtual void __fastcall UpdateItem(Planner::TPlannerItem* APlannerItem);
	virtual void __fastcall RefreshItem(Planner::TPlannerItem* APlannerItem);
	__property bool IsUpdating = {read=FIsUpdating, nodefault};
	virtual void __fastcall ClearDBItems(void);
	virtual void __fastcall ReadDBItems(System::UnicodeString UpdateKey);
	virtual void __fastcall ReadDBItem(void);
	virtual void __fastcall WriteDBItem(void);
	virtual void __fastcall AddDBItem(void);
	virtual void __fastcall DeleteDBItem(void);
	virtual void __fastcall SelectDBItem(void);
	HIDESBASE void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall CreateKey(void);
	
__published:
	__property TPlannerDataBinding* DataBinding = {read=FDataBinding, write=SetDataBinding};
	__property Db::TDataSource* DataSource = {read=FDataSource, write=SetDataSource};
	__property Dbplanner::TFieldsItemEvent OnFieldsToItem = {read=FOnFieldsToItem, write=FOnFieldsToItem};
	__property Dbplanner::TFieldsItemEvent OnItemToFields = {read=FOnItemToFields, write=FOnItemToFields};
	__property Dbplanner::TFieldsToTimeEvent OnFieldsToTime = {read=FOnFieldsToTime, write=FOnFieldsToTime};
	__property Dbplanner::TTimeToFieldsEvent OnTimeToFields = {read=FOnTimeToFields, write=FOnTimeToFields};
	__property Dbplanner::TDBItemSQLEvent OnInsertItem = {read=FOnInsertItem, write=FOnInsertItem};
	__property Dbplanner::TDBItemSQLEvent OnDeleteItem = {read=FOnDeleteItem, write=FOnDeleteItem};
	__property Dbplanner::TDBItemSQLEvent OnUpdateItem = {read=FOnUpdateItem, write=FOnUpdateItem};
	__property Dbplanner::TCreateKeyEvent OnCreateKey = {read=FOnCreateKey, write=FOnCreateKey};
public:
	/* TWinControl.CreateParented */ inline __fastcall TDBPlannerMonthView(HWND ParentWindow) : Plannermonthview::TPlannerMonthView(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Dbplannermonthview */
using namespace Dbplannermonthview;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DbplannermonthviewHPP
