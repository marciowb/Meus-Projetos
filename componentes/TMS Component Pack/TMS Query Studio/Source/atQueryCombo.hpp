// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'atQueryCombo.pas' rev: 22.00

#ifndef AtquerycomboHPP
#define AtquerycomboHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <DBTables.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Atquerycombo
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TatComboBox;
typedef void __fastcall (__closure *TKeyValueNotFoundEvent)(TatComboBox* Sender, int AKeyValue, System::UnicodeString &s);

#pragma option push -b-
enum TQuickSearchMode { qsNone, qsInitial, qsFull };
#pragma option pop

class PASCALIMPLEMENTATION TatComboBox : public Stdctrls::TComboBox
{
	typedef Stdctrls::TComboBox inherited;
	
private:
	System::Variant FKeyValue;
	Classes::TNotifyEvent FOnLoadItems;
	TKeyValueNotFoundEvent FOnKeyValueNotFound;
	Classes::TNotifyEvent FOnSetKeyValue;
	TQuickSearchMode FQuickSearchMode;
	int FQuickSearchDelay;
	bool FAutosize;
	Classes::TNotifyEvent FOnChangeItems;
	Extctrls::TTimer* FQuickSearchTimer;
	bool FKeyValueSearch;
	bool FUpdating;
	void __fastcall SmartComboQuickSearchTimer(System::TObject* Sender);
	void __fastcall DoQuickSearch(void);
	System::Variant __fastcall GetKeyValue(void);
	void __fastcall SetKeyValue(const System::Variant &Value);
	void __fastcall CheckPendingQuickSearch(void);
	void __fastcall UpdateKeyValue(void);
	void __fastcall SetQuickSearchDelay(const int Value);
	void __fastcall StartTimerToQuickSearch(void);
	HIDESBASE MESSAGE void __fastcall CNCommand(Messages::TWMCommand &Message);
	MESSAGE void __fastcall CBSetCurSel(Messages::TMessage &Message);
	MESSAGE void __fastcall WMSetText(Messages::TMessage &Message);
	MESSAGE void __fastcall CBResetContent(Messages::TMessage &Message);
	MESSAGE void __fastcall CBAddString(Messages::TMessage &Message);
	MESSAGE void __fastcall CBDeleteString(Messages::TMessage &Message);
	MESSAGE void __fastcall CBInsertString(Messages::TMessage &Message);
	MESSAGE void __fastcall WMSetReDraw(Messages::TWMSetRedraw &Message);
	void __fastcall DoChangeKeyValue(const System::Variant &Value);
	void __fastcall SetInternalAutosize(const bool Value);
	void __fastcall StringsChange(void);
	int __fastcall ItemsWidth(void);
	
protected:
	DYNAMIC void __fastcall DropDown(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall Change(void);
	virtual void __fastcall LoadItems(void);
	virtual void __fastcall AutoAdjustSize(int w);
	
public:
	__fastcall virtual TatComboBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TatComboBox(void);
	void __fastcall DoLoadItems(void);
	
__published:
	__property System::Variant KeyValue = {read=GetKeyValue, write=SetKeyValue};
	__property TQuickSearchMode QuickSearchMode = {read=FQuickSearchMode, write=FQuickSearchMode, default=2};
	__property bool KeyValueSearch = {read=FKeyValueSearch, write=FKeyValueSearch, default=0};
	__property int QuickSearchDelay = {read=FQuickSearchDelay, write=SetQuickSearchDelay, default=0};
	__property Classes::TNotifyEvent OnLoadItems = {read=FOnLoadItems, write=FOnLoadItems};
	__property TKeyValueNotFoundEvent OnKeyValueNotFound = {read=FOnKeyValueNotFound, write=FOnKeyValueNotFound};
	__property Classes::TNotifyEvent OnSetKeyValue = {read=FOnSetKeyValue, write=FOnSetKeyValue};
	__property bool Autosize = {read=FAutosize, write=SetInternalAutosize, nodefault};
	__property Classes::TNotifyEvent OnChangeItems = {read=FOnChangeItems, write=FOnChangeItems};
public:
	/* TWinControl.CreateParented */ inline __fastcall TatComboBox(HWND ParentWindow) : Stdctrls::TComboBox(ParentWindow) { }
	
};


class DELPHICLASS TatQueryCombo;
class PASCALIMPLEMENTATION TatQueryCombo : public TatComboBox
{
	typedef TatComboBox inherited;
	
private:
	System::UnicodeString FDatabaseName;
	Classes::TStringList* FSql;
	Dbtables::TQuery* FQuery;
	void __fastcall SetDatabaseName(const System::UnicodeString Value);
	void __fastcall SetSQL(const Classes::TStringList* Value);
	void __fastcall LoadItemsFromQuery(void);
	
protected:
	virtual void __fastcall LoadItems(void);
	
public:
	__fastcall virtual TatQueryCombo(Classes::TComponent* AOwner);
	__fastcall virtual ~TatQueryCombo(void);
	
__published:
	__property System::UnicodeString DatabaseName = {read=FDatabaseName, write=SetDatabaseName};
	__property Classes::TStringList* SQL = {read=FSql, write=SetSQL};
public:
	/* TWinControl.CreateParented */ inline __fastcall TatQueryCombo(HWND ParentWindow) : TatComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Atquerycombo */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Atquerycombo;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AtquerycomboHPP
