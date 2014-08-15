// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Dblucomb.pas' rev: 21.00

#ifndef DblucombHPP
#define DblucombHPP

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
#include <Lucombo.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Dbctrls.hpp>	// Pascal unit
#include <Character.hpp>	// Pascal unit
#include <Advcombo.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dblucomb
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TLookupMode { lmEdit, lmGoto };
#pragma option pop

class DELPHICLASS TDBLUCombo;
class PASCALIMPLEMENTATION TDBLUCombo : public Lucombo::TLUCombo
{
	typedef Lucombo::TLUCombo inherited;
	
private:
	Dbctrls::TFieldDataLink* fDataLink;
	bool fDataLookup;
	TLookupMode fLookupMode;
	Classes::TNotifyEvent FOnBeforeLoad;
	Classes::TNotifyEvent FOnAfterLoad;
	System::UnicodeString __fastcall GetDataField(void);
	Db::TDataSource* __fastcall GetDataSource(void);
	bool __fastcall GetReadOnly(void);
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall SetDataSource(const Db::TDataSource* Value);
	void __fastcall SetReadOnly(bool Value);
	void __fastcall DataUpdate(System::TObject* Sender);
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall ActiveChange(System::TObject* Sender);
	MESSAGE void __fastcall WMCut(Messages::TMessage &Message);
	MESSAGE void __fastcall WMPaste(Messages::TMessage &Message);
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
	
public:
	__fastcall virtual TDBLUCombo(Classes::TComponent* aOwner);
	__fastcall virtual ~TDBLUCombo(void);
	DYNAMIC void __fastcall Change(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC bool __fastcall ExecuteAction(Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(Classes::TBasicAction* Action);
	
__published:
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property bool DataLookup = {read=fDataLookup, write=SetDataLookup, nodefault};
	__property TLookupMode LookUpMode = {read=fLookupMode, write=fLookupMode, nodefault};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property Classes::TNotifyEvent OnBeforeLoad = {read=FOnBeforeLoad, write=FOnBeforeLoad};
	__property Classes::TNotifyEvent OnAfterLoad = {read=FOnAfterLoad, write=FOnAfterLoad};
public:
	/* TWinControl.CreateParented */ inline __fastcall TDBLUCombo(HWND ParentWindow) : Lucombo::TLUCombo(ParentWindow) { }
	
};


class DELPHICLASS TDBLUEdit;
class PASCALIMPLEMENTATION TDBLUEdit : public Lucombo::TLUEdit
{
	typedef Lucombo::TLUEdit inherited;
	
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
	MESSAGE void __fastcall WMCut(Messages::TMessage &Message);
	MESSAGE void __fastcall WMPaste(Messages::TMessage &Message);
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
	
public:
	__fastcall virtual TDBLUEdit(Classes::TComponent* aOwner);
	__fastcall virtual ~TDBLUEdit(void);
	DYNAMIC void __fastcall Change(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC bool __fastcall ExecuteAction(Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(Classes::TBasicAction* Action);
	
__published:
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property bool DataLookup = {read=fDataLookup, write=SetDataLookup, nodefault};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TDBLUEdit(HWND ParentWindow) : Lucombo::TLUEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Dblucomb */
using namespace Dblucomb;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DblucombHPP
