// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Plannerdbmaskdatepicker.pas' rev: 21.00

#ifndef PlannerdbmaskdatepickerHPP
#define PlannerdbmaskdatepickerHPP

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
#include <Db.hpp>	// Pascal unit
#include <Dbctrls.hpp>	// Pascal unit
#include <Plannermaskdatepicker.hpp>	// Pascal unit
#include <Advmedbtn.hpp>	// Pascal unit
#include <Advedit.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Plannerdbmaskdatepicker
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TPlannerDBMaskDatePicker;
class PASCALIMPLEMENTATION TPlannerDBMaskDatePicker : public Plannermaskdatepicker::TPlannerMaskDatePicker
{
	typedef Plannermaskdatepicker::TPlannerMaskDatePicker inherited;
	
private:
	Dbctrls::TFieldDataLink* FDataLink;
	Db::TDataSetState FOldState;
	bool FIsEditing;
	bool FInternalCall;
	System::TDateTime FNewDate;
	bool FNullDate;
	bool FDonNotCallChange;
	System::UnicodeString __fastcall GetDataField(void);
	Db::TDataSource* __fastcall GetDataSource(void);
	bool __fastcall GetReadOnly(void);
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall SetDataSource(const Db::TDataSource* Value);
	HIDESBASE void __fastcall SetReadOnly(bool Value);
	void __fastcall DataUpdate(System::TObject* Sender);
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall ActiveChange(System::TObject* Sender);
	MESSAGE void __fastcall CMGetDataLink(Messages::TMessage &Message);
	
protected:
	DYNAMIC void __fastcall Change(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual bool __fastcall CanModify(void);
	virtual void __fastcall DaySelect(void);
	
public:
	__fastcall virtual TPlannerDBMaskDatePicker(Classes::TComponent* aOwner);
	__fastcall virtual ~TPlannerDBMaskDatePicker(void);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC bool __fastcall ExecuteAction(Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(Classes::TBasicAction* Action);
	
__published:
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TPlannerDBMaskDatePicker(HWND ParentWindow) : Plannermaskdatepicker::TPlannerMaskDatePicker(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Plannerdbmaskdatepicker */
using namespace Plannerdbmaskdatepicker;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlannerdbmaskdatepickerHPP
