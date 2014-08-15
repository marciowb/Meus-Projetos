// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'atMetaSQLForm.pas' rev: 22.00

#ifndef AtmetasqlformHPP
#define AtmetasqlformHPP

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
#include <atMetaSQL.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <atMetaSQLAbstractEditor.hpp>	// Pascal unit
#include <atMetaSQLTableEditor.hpp>	// Pascal unit
#include <atMetaSQLFieldEditor.hpp>	// Pascal unit
#include <atMetaSQLOrderEditor.hpp>	// Pascal unit
#include <atMetaSQLGroupEditor.hpp>	// Pascal unit
#include <atMetaSQLConditionEditor.hpp>	// Pascal unit
#include <atMetaSQLJoinEditor.hpp>	// Pascal unit
#include <atMetaSQLMemo.hpp>	// Pascal unit
#include <atMetaSQLDataResult.hpp>	// Pascal unit
#include <ActnList.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <DBTables.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Atmetasqlform
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfmMetaSQLEditor;
class PASCALIMPLEMENTATION TfmMetaSQLEditor : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Comctrls::TTabControl* TabControl1;
	Extctrls::TPanel* pnEditor;
	Actnlist::TActionList* ActionList1;
	Actnlist::TAction* acNextTab;
	Actnlist::TAction* acPreviousTab;
	Extctrls::TPanel* Panel1;
	Stdctrls::TComboBox* cbDatabases;
	Stdctrls::TLabel* Label1;
	Stdctrls::TCheckBox* cbSaveDB;
	Actnlist::TAction* acImportFromSQL;
	Stdctrls::TButton* Button1;
	void __fastcall TabControl1Change(System::TObject* Sender);
	void __fastcall acNextTabExecute(System::TObject* Sender);
	void __fastcall acPreviousTabExecute(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall cbDatabasesClick(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, Forms::TCloseAction &Action);
	void __fastcall acImportFromSQLExecute(System::TObject* Sender);
	
private:
	Atmetasql::TatMetaSQL* FMetaSQL;
	Classes::TComponent* FMetaSQLOwner;
	Atmetasqlfieldeditor::TfmMetaSQLFieldEditor* FFieldEditor;
	Atmetasqltableeditor::TfmMetaSQLTableEditor* FTableEditor;
	Atmetasqljoineditor::TfmMetaSQLJoinEditor* FJoinEditor;
	Atmetasqlordereditor::TfmMetaSQLOrderEditor* FOrderEditor;
	Atmetasqlgroupeditor::TfmMetaSQLGroupEditor* FGroupEditor;
	Atmetasqlconditioneditor::TfmMetaSQLConditionEditor* FConditionEditor;
	Atmetasqlmemo::TfmMetaSQLMemo* FSQLResult;
	Atmetasqldataresult::TfmMetaSQLDataResult* FDataResult;
	Atmetasqlabstracteditor::TfmMetaSQLAbstractEditor* FCurrentEditor;
	void __fastcall CreateFrames(void);
	System::UnicodeString __fastcall GetDatabaseName(void);
	void __fastcall LoadStateFromRegistry(void);
	void __fastcall SaveStateInRegistry(void);
	void __fastcall Localize(void);
	
protected:
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TfmMetaSQLEditor(Classes::TComponent* AOwner);
	__property Classes::TComponent* MetaSQLOwner = {read=FMetaSQLOwner};
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfmMetaSQLEditor(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfmMetaSQLEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmMetaSQLEditor(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall EditMetaSQL(Atmetasql::TatMetaSQL* AMetaSQL);

}	/* namespace Atmetasqlform */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Atmetasqlform;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AtmetasqlformHPP
