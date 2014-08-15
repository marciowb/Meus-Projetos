// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Dbadvle.pas' rev: 21.00

#ifndef DbadvleHPP
#define DbadvleHPP

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
#include <Advlued.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Dbctrls.hpp>	// Pascal unit
#include <Advedit.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dbadvle
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TDBAdvLUEdit;
class PASCALIMPLEMENTATION TDBAdvLUEdit : public Advlued::TAdvLUEdit
{
	typedef Advlued::TAdvLUEdit inherited;
	
private:
	Dbctrls::TFieldDataLink* FDataLink;
	bool fDataLookup;
	System::UnicodeString __fastcall GetDataField(void);
	Db::TDataSource* __fastcall GetDataSource(void);
	bool __fastcall GetReadOnly(void);
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall SetDataSource(const Db::TDataSource* Value);
	HIDESBASE void __fastcall SetReadOnly(bool Value);
	void __fastcall DataUpdate(System::TObject* Sender);
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall ActiveChange(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMCut(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMPaste(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMChar(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Message);
	MESSAGE void __fastcall WMUndo(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Message);
	MESSAGE void __fastcall CMGetDataLink(Messages::TMessage &Message);
	void __fastcall ResetMaxLength(void);
	void __fastcall SetDataLookup(const bool Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	void __fastcall LoadLookup(void);
	virtual bool __fastcall EditCanModify(void);
	
public:
	__fastcall virtual TDBAdvLUEdit(Classes::TComponent* aOwner);
	__fastcall virtual ~TDBAdvLUEdit(void);
	DYNAMIC bool __fastcall ExecuteAction(Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(Classes::TBasicAction* Action);
	DYNAMIC void __fastcall Change(void);
	virtual void __fastcall Loaded(void);
	
__published:
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property bool DataLookup = {read=fDataLookup, write=SetDataLookup, nodefault};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TDBAdvLUEdit(HWND ParentWindow) : Advlued::TAdvLUEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Dbadvle */
using namespace Dbadvle;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DbadvleHPP
