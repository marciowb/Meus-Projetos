// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'atMetaSQLConditionEditor.pas' rev: 22.00

#ifndef AtmetasqlconditioneditorHPP
#define AtmetasqlconditioneditorHPP

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
#include <atMetaSQL.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <ActnList.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <atPanel.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <atMetaSQLAbstractEditor.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Atmetasqlconditioneditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfmMetaSQLConditionEditor;
class PASCALIMPLEMENTATION TfmMetaSQLConditionEditor : public Atmetasqlcustomeditor::TfmMetaSQLCustomEditor
{
	typedef Atmetasqlcustomeditor::TfmMetaSQLCustomEditor inherited;
	
__published:
	Stdctrls::TLabel* Label2;
	Stdctrls::TLabel* lbLinkType;
	Stdctrls::TLabel* Label1;
	Stdctrls::TComboBox* cbOperator;
	Stdctrls::TComboBox* cbFieldAlias;
	Stdctrls::TLabel* Label3;
	Stdctrls::TEdit* edName;
	Extctrls::TSplitter* Splitter1;
	Comctrls::TTreeView* TreeView;
	Stdctrls::TLabel* Label8;
	Stdctrls::TComboBox* cbConditionType;
	Stdctrls::TEdit* edExpression;
	Stdctrls::TLabel* Label7;
	Stdctrls::TLabel* Label4;
	Stdctrls::TComboBox* cbSubLogicalOper;
	Stdctrls::TComboBox* cbValue;
	void __fastcall cbFieldAliasEnter(System::TObject* Sender);
	void __fastcall TreeViewChange(System::TObject* Sender, Comctrls::TTreeNode* Node);
	HIDESBASE void __fastcall acNewExecute(System::TObject* Sender);
	void __fastcall cbConditionTypeClick(System::TObject* Sender);
	void __fastcall cbValueEnter(System::TObject* Sender);
	
private:
	System::UnicodeString FOldFIeldAlias;
	Atmetasql::TatSQLConditions* FRootConditions;
	void __fastcall LoadTreeView(void);
	void __fastcall UpdateExpressionEditor(void);
	Comctrls::TTreeNode* __fastcall CreateTreeNode(Comctrls::TTreeNode* ANode, Atmetasql::TatSQLCondition* ACondition);
	System::UnicodeString __fastcall BuildNodeCaption(Atmetasql::TatSQLCondition* ACOnd);
	void __fastcall SetRootConditions(const Atmetasql::TatSQLConditions* Value);
	HIDESBASE void __fastcall Localize(void);
	
protected:
	virtual void __fastcall FocusFirstEditor(void);
	virtual void __fastcall AssociateItems(void);
	virtual void __fastcall ClearEditors(void);
	virtual System::UnicodeString __fastcall GetMainCaption(Classes::TCollectionItem* AItem);
	virtual System::UnicodeString __fastcall GetSubItems(Classes::TCollectionItem* AItem, Classes::TStrings* ASubItems);
	virtual void __fastcall SaveEditorsInItem(Classes::TCollectionItem* AItem);
	virtual void __fastcall LoadItemInEditors(Classes::TCollectionItem* AItem);
	virtual void __fastcall BeforeItemDeletion(Classes::TCollectionItem* AItem, Comctrls::TListItem* AListItem);
	virtual void __fastcall Loaded(void);
	
public:
	virtual void __fastcall ActivateEditor(void);
	__property Atmetasql::TatSQLConditions* RootConditions = {read=FRootConditions, write=SetRootConditions};
public:
	/* TCustomFrame.Create */ inline __fastcall virtual TfmMetaSQLConditionEditor(Classes::TComponent* AOwner) : Atmetasqlcustomeditor::TfmMetaSQLCustomEditor(AOwner) { }
	
public:
	/* TScrollingWinControl.Destroy */ inline __fastcall virtual ~TfmMetaSQLConditionEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmMetaSQLConditionEditor(HWND ParentWindow) : Atmetasqlcustomeditor::TfmMetaSQLCustomEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Atmetasqlconditioneditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Atmetasqlconditioneditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AtmetasqlconditioneditorHPP
