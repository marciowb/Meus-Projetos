// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advdbdatetimepicker.pas' rev: 21.00

#ifndef AdvdbdatetimepickerHPP
#define AdvdbdatetimepickerHPP

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
#include <Advdatetimepicker.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advdbdatetimepicker
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvDBDateTimePicker;
class PASCALIMPLEMENTATION TAdvDBDateTimePicker : public Advdatetimepicker::TAdvDateTimePicker
{
	typedef Advdatetimepicker::TAdvDateTimePicker inherited;
	
private:
	Dbctrls::TFieldDataLink* FDataLink;
	Db::TDataSetState FOldState;
	bool FIsEditing;
	bool FInternalCall;
	System::TDateTime FNewDate;
	bool FNullDate;
	bool FInternalChange;
	System::UnicodeString __fastcall GetDataField(void);
	Db::TDataSource* __fastcall GetDataSource(void);
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall SetDataSource(const Db::TDataSource* Value);
	void __fastcall DataUpdate(System::TObject* Sender);
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall ActiveChange(System::TObject* Sender);
	void __fastcall HandleKey(System::Word Key);
	HIDESBASE MESSAGE void __fastcall CNNotify(Messages::TWMNotify &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Message);
	MESSAGE void __fastcall CMGetDataLink(Messages::TMessage &Message);
	
protected:
	DYNAMIC void __fastcall Change(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall Loaded(void);
	virtual bool __fastcall EditCanModify(void);
	DYNAMIC void __fastcall DoExit(void);
	virtual void __fastcall TimePickerChanged(void);
	virtual void __fastcall TimePickerKeyPress(System::TObject* Sender, System::WideChar &Key);
	virtual void __fastcall SetDateTimeEx(const System::TDateTime Value);
	
public:
	__fastcall virtual TAdvDBDateTimePicker(Classes::TComponent* aOwner);
	__fastcall virtual ~TAdvDBDateTimePicker(void);
	DYNAMIC bool __fastcall ExecuteAction(Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(Classes::TBasicAction* Action);
	
__published:
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvDBDateTimePicker(HWND ParentWindow) : Advdatetimepicker::TAdvDateTimePicker(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Advdbdatetimepicker */
using namespace Advdbdatetimepicker;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvdbdatetimepickerHPP
