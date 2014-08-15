// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'atMetaSQLCustomEditor.pas' rev: 22.00

#ifndef AtmetasqlcustomeditorHPP
#define AtmetasqlcustomeditorHPP

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
#include <StdCtrls.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <atPanel.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <atMetaSQL.hpp>	// Pascal unit
#include <atMetaSQLAbstractEditor.hpp>	// Pascal unit
#include <ActnList.hpp>	// Pascal unit
#include <DBTables.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Atmetasqlcustomeditor
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TatEditState { esNone, esInsert, esEdit };
#pragma option pop

class DELPHICLASS TfmMetaSQLCustomEditor;
class PASCALIMPLEMENTATION TfmMetaSQLCustomEditor : public Atmetasqlabstracteditor::TfmMetaSQLAbstractEditor
{
	typedef Atmetasqlabstracteditor::TfmMetaSQLAbstractEditor inherited;
	
__published:
	Atpanel::TatPanel* atPanel1;
	Atpanel::TatPanel* Panel1;
	Stdctrls::TButton* btNew;
	Stdctrls::TButton* btInsert;
	Stdctrls::TButton* btCancel;
	Extctrls::TPanel* Panel2;
	Comctrls::TListView* lvItems;
	Actnlist::TActionList* ActionList1;
	Actnlist::TAction* acNew;
	Actnlist::TAction* acInsert;
	Actnlist::TAction* acCancel;
	Stdctrls::TButton* btDelete;
	Actnlist::TAction* acEdit;
	Menus::TPopupMenu* pmList;
	Actnlist::TAction* acClearItems;
	Actnlist::TAction* acDelete;
	void __fastcall lvItemsSelectItem(System::TObject* Sender, Comctrls::TListItem* Item, bool Selected);
	void __fastcall acNewUpdate(System::TObject* Sender);
	void __fastcall acInsertUpdate(System::TObject* Sender);
	void __fastcall acCancelUpdate(System::TObject* Sender);
	void __fastcall acNewExecute(System::TObject* Sender);
	void __fastcall acInsertExecute(System::TObject* Sender);
	void __fastcall FrameEnter(System::TObject* Sender);
	void __fastcall acEditUpdate(System::TObject* Sender);
	void __fastcall acEditExecute(System::TObject* Sender);
	void __fastcall acCancelExecute(System::TObject* Sender);
	void __fastcall atPanel1Enter(System::TObject* Sender);
	void __fastcall acClearItemsUpdate(System::TObject* Sender);
	void __fastcall acClearItemsExecute(System::TObject* Sender);
	void __fastcall lvItemsChange(System::TObject* Sender, Comctrls::TListItem* Item, Comctrls::TItemChange Change);
	void __fastcall acDeleteExecute(System::TObject* Sender);
	void __fastcall acDeleteUpdate(System::TObject* Sender);
	void __fastcall lvItemsKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	
private:
	Classes::TCollection* FItems;
	TatEditState FState;
	int FNoCheckUpdate;
	void __fastcall SetItems(Classes::TCollection* Value);
	Comctrls::TListItem* __fastcall CreateListItem(Classes::TCollectionItem* AItem);
	void __fastcall UnselectAllItems(void);
	void __fastcall DeleteCurrentItem(void);
	void __fastcall UpdateItemCaptions(Comctrls::TListItem* AListItem, Classes::TCollectionItem* AItem);
	bool __fastcall CanCheckItems(void);
	bool __fastcall IsItemChecked(Classes::TCollectionItem* AItem);
	void __fastcall CheckItem(Classes::TCollectionItem* AItem, bool ACheck);
	void __fastcall Localize(void);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall FocusFirstEditor(void) = 0 ;
	virtual void __fastcall AssociateItems(void) = 0 ;
	virtual void __fastcall ClearEditors(void) = 0 ;
	virtual void __fastcall SaveEditorsInItem(Classes::TCollectionItem* AItem) = 0 ;
	virtual void __fastcall LoadItemInEditors(Classes::TCollectionItem* AItem) = 0 ;
	virtual System::UnicodeString __fastcall GetMainCaption(Classes::TCollectionItem* AItem);
	virtual System::UnicodeString __fastcall GetSubItems(Classes::TCollectionItem* AItem, Classes::TStrings* ASubItems);
	virtual void __fastcall BeforeItemDeletion(Classes::TCollectionItem* AItem, Comctrls::TListItem* AListItem);
	void __fastcall UpdateSelectedCaption(void);
	virtual void __fastcall SetMetaSQL(Atmetasql::TatMetaSQL* Value);
	void __fastcall UpdateList(void);
	__property Classes::TCollection* Items = {read=FItems, write=SetItems};
	void __fastcall FillTableNames(Classes::TStrings* TableNames);
	void __fastcall FillTableAliasList(Classes::TStrings* AliasList);
	void __fastcall FillFieldAliasList(Classes::TStrings* AliasList);
	void __fastcall FillFieldNameList(const System::UnicodeString ATableName, Classes::TStrings* FieldNames);
	System::UnicodeString __fastcall BuildTableID(const System::UnicodeString AAliasName);
	System::UnicodeString __fastcall AliasFromTableID(const System::UnicodeString ATableID);
	System::UnicodeString __fastcall TableNameFromAlias(const System::UnicodeString AAliasName);
	__property TatEditState State = {read=FState, nodefault};
	
public:
	virtual void __fastcall DeActivateEditor(void);
public:
	/* TCustomFrame.Create */ inline __fastcall virtual TfmMetaSQLCustomEditor(Classes::TComponent* AOwner) : Atmetasqlabstracteditor::TfmMetaSQLAbstractEditor(AOwner) { }
	
public:
	/* TScrollingWinControl.Destroy */ inline __fastcall virtual ~TfmMetaSQLCustomEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmMetaSQLCustomEditor(HWND ParentWindow) : Atmetasqlabstracteditor::TfmMetaSQLAbstractEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Atmetasqlcustomeditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Atmetasqlcustomeditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AtmetasqlcustomeditorHPP
