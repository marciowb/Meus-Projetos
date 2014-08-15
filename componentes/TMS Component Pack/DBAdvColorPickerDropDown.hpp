// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Dbadvcolorpickerdropdown.pas' rev: 21.00

#ifndef DbadvcolorpickerdropdownHPP
#define DbadvcolorpickerdropdownHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Advcolorpickerdropdown.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Dbctrls.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Advdropdown.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dbadvcolorpickerdropdown
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TDBAdvColorPickerDropDown;
class PASCALIMPLEMENTATION TDBAdvColorPickerDropDown : public Advcolorpickerdropdown::TAdvColorPickerDropDown
{
	typedef Advcolorpickerdropdown::TAdvColorPickerDropDown inherited;
	
private:
	Dbctrls::TFieldDataLink* FDataLink;
	Db::TDataSetState FOldState;
	bool FInternalCall;
	void __fastcall DataUpdate(System::TObject* Sender);
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall ActiveChange(System::TObject* Sender);
	System::UnicodeString __fastcall GetDataField(void);
	Db::TDataSource* __fastcall GetDataSource(void);
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall SetDataSource(const Db::TDataSource* Value);
	MESSAGE void __fastcall CMGetDataLink(Messages::TMessage &Message);
	
protected:
	virtual bool __fastcall EditCanModify(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	void __fastcall DoSelect(System::TObject* Sender);
	
public:
	__fastcall virtual TDBAdvColorPickerDropDown(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBAdvColorPickerDropDown(void);
	DYNAMIC bool __fastcall ExecuteAction(Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(Classes::TBasicAction* Action);
	
__published:
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
public:
	/* TWinControl.CreateParented */ inline __fastcall TDBAdvColorPickerDropDown(HWND ParentWindow) : Advcolorpickerdropdown::TAdvColorPickerDropDown(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Dbadvcolorpickerdropdown */
using namespace Dbadvcolorpickerdropdown;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DbadvcolorpickerdropdownHPP
