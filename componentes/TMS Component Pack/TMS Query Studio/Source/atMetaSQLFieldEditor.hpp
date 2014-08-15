// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'atMetaSQLFieldEditor.pas' rev: 22.00

#ifndef AtmetasqlfieldeditorHPP
#define AtmetasqlfieldeditorHPP

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
#include <atMetaSQLCustomEditor.hpp>	// Pascal unit
#include <ActnList.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <atPanel.hpp>	// Pascal unit
#include <atMetaSQL.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <atListBoxDlg.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <atCheckListEdit.hpp>	// Pascal unit
#include <atMetaSQLAbstractEditor.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Atmetasqlfieldeditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfmMetaSQLFieldEditor;
class PASCALIMPLEMENTATION TfmMetaSQLFieldEditor : public Atmetasqlcustomeditor::TfmMetaSQLCustomEditor
{
	typedef Atmetasqlcustomeditor::TfmMetaSQLCustomEditor inherited;
	
__published:
	Stdctrls::TEdit* edDisplayLabel;
	Stdctrls::TLabel* Label1;
	Stdctrls::TComboBox* cbTableAlias;
	Stdctrls::TLabel* Label2;
	Stdctrls::TLabel* Label3;
	Stdctrls::TComboBox* cbFieldName;
	Stdctrls::TLabel* Label4;
	Stdctrls::TComboBox* cbGroupFunction;
	Stdctrls::TLabel* Label5;
	Stdctrls::TComboBox* cbDataType;
	Stdctrls::TEdit* edFieldAlias;
	Stdctrls::TLabel* Label6;
	Stdctrls::TButton* btLoad;
	Atlistboxdlg::TatListBoxDlg* ldPickDataset;
	Actnlist::TAction* acAppendDataset;
	Stdctrls::TButton* Button1;
	Actnlist::TAction* acAppendTable;
	Actnlist::TAction* acTableAlias;
	Menus::TMenuItem* Settablealias1;
	Stdctrls::TLabel* Label7;
	Stdctrls::TEdit* edFieldExpression;
	Stdctrls::TLabel* Label8;
	Stdctrls::TComboBox* cbExpressionType;
	Stdctrls::TLabel* Label10;
	Stdctrls::TComboBox* cbVisible;
	Atchecklistedit::TatCheckListEdit* ceOptions;
	Stdctrls::TLabel* lbOptions;
	void __fastcall cbTableAliasEnter(System::TObject* Sender);
	void __fastcall cbTableAliasExit(System::TObject* Sender);
	void __fastcall cbFieldNameExit(System::TObject* Sender);
	void __fastcall cbFieldNameEnter(System::TObject* Sender);
	void __fastcall edFieldAliasEnter(System::TObject* Sender);
	void __fastcall acAppendDatasetExecute(System::TObject* Sender);
	void __fastcall acAppendDatasetUpdate(System::TObject* Sender);
	void __fastcall acAppendTableUpdate(System::TObject* Sender);
	void __fastcall acAppendTableExecute(System::TObject* Sender);
	void __fastcall acTableAliasUpdate(System::TObject* Sender);
	void __fastcall acTableAliasExecute(System::TObject* Sender);
	void __fastcall cbExpressionTypeClick(System::TObject* Sender);
	void __fastcall edFieldAliasExit(System::TObject* Sender);
	
private:
	System::UnicodeString FOldTableName;
	System::UnicodeString FOldFieldName;
	System::UnicodeString FOldFieldAlias;
	void __fastcall UpdateFieldExpressionEditor(void);
	void __fastcall FillItemOptions(void);
	void __fastcall LoadOptionsInEditor(Atmetasql::TatSqlField* AField);
	void __fastcall SaveEditorInOptions(Atmetasql::TatSqlField* AField);
	HIDESBASE void __fastcall Localize(void);
	
protected:
	virtual void __fastcall FocusFirstEditor(void);
	virtual void __fastcall AssociateItems(void);
	virtual void __fastcall ClearEditors(void);
	virtual System::UnicodeString __fastcall GetMainCaption(Classes::TCollectionItem* AItem);
	virtual System::UnicodeString __fastcall GetSubItems(Classes::TCollectionItem* AItem, Classes::TStrings* ASubItems);
	virtual void __fastcall SaveEditorsInItem(Classes::TCollectionItem* AItem);
	virtual void __fastcall LoadItemInEditors(Classes::TCollectionItem* AItem);
	virtual void __fastcall Loaded(void);
	
public:
	virtual void __fastcall ActivateEditor(void);
public:
	/* TCustomFrame.Create */ inline __fastcall virtual TfmMetaSQLFieldEditor(Classes::TComponent* AOwner) : Atmetasqlcustomeditor::TfmMetaSQLCustomEditor(AOwner) { }
	
public:
	/* TScrollingWinControl.Destroy */ inline __fastcall virtual ~TfmMetaSQLFieldEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmMetaSQLFieldEditor(HWND ParentWindow) : Atmetasqlcustomeditor::TfmMetaSQLCustomEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Atmetasqlfieldeditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Atmetasqlfieldeditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AtmetasqlfieldeditorHPP
