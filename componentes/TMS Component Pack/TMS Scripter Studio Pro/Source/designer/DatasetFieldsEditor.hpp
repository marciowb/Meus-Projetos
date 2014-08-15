// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Datasetfieldseditor.pas' rev: 21.00

#ifndef DatasetfieldseditorHPP
#define DatasetfieldseditorHPP

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
#include <Extctrls.hpp>	// Pascal unit
#include <Dbctrls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Actnlist.hpp>	// Pascal unit
#include <Clipbrd.hpp>	// Pascal unit
#include <Dbclient.hpp>	// Pascal unit
#include <Formdesigner.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Datasetfieldseditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfmDatasetFieldsEditor;
class PASCALIMPLEMENTATION TfmDatasetFieldsEditor : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Dbctrls::TDBNavigator* DBNavigator;
	Stdctrls::TListBox* lsFields;
	Menus::TPopupMenu* popFields;
	Menus::TMenuItem* miAddFields;
	Menus::TMenuItem* miNewField;
	Menus::TMenuItem* miAddAllFields;
	Menus::TMenuItem* N1;
	Menus::TMenuItem* miCut;
	Menus::TMenuItem* miCopy;
	Menus::TMenuItem* miPaste;
	Menus::TMenuItem* miDelete;
	Menus::TMenuItem* miSelectAll;
	Actnlist::TActionList* alFields;
	Actnlist::TAction* acAddFields;
	Actnlist::TAction* acNewField;
	Actnlist::TAction* acAddAllFields;
	Actnlist::TAction* acCut;
	Actnlist::TAction* acCopy;
	Actnlist::TAction* acPaste;
	Actnlist::TAction* acDelete;
	Actnlist::TAction* acSelectAll;
	Db::TDataSource* dsNavigator;
	Stdctrls::TListBox* lsAggregates;
	Extctrls::TSplitter* spAggregates;
	void __fastcall FormClose(System::TObject* Sender, Forms::TCloseAction &Action);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall alFieldsUpdate(Classes::TBasicAction* Action, bool &Handled);
	void __fastcall acAddFieldsExecute(System::TObject* Sender);
	void __fastcall acNewFieldExecute(System::TObject* Sender);
	void __fastcall acAddAllFieldsExecute(System::TObject* Sender);
	void __fastcall acCutExecute(System::TObject* Sender);
	void __fastcall acCopyExecute(System::TObject* Sender);
	void __fastcall acPasteExecute(System::TObject* Sender);
	void __fastcall acDeleteExecute(System::TObject* Sender);
	void __fastcall acSelectAllExecute(System::TObject* Sender);
	void __fastcall lsFieldsDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall lsFieldsDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall lsFieldsClick(System::TObject* Sender);
	
private:
	Db::TDataSet* FEditedDataset;
	Classes::TComponent* FFieldsOwner;
	Formdesigner::TAdvCustomFormDesigner* FFormDesigner;
	bool __fastcall CanPasteFromClipboard(void);
	void __fastcall DeleteSelectedItems(Stdctrls::TListBox* AListBox);
	void __fastcall FieldsToClipboard(void);
	Stdctrls::TListBox* __fastcall GetCurrentListBox(void);
	System::UnicodeString __fastcall GetTitle(void);
	void __fastcall LoadFields(void);
	void __fastcall SelectAllItems(Stdctrls::TListBox* AListBox);
	void __fastcall SetDesignerFields(void);
	void __fastcall SetEditedDataset(const Db::TDataSet* Value);
	void __fastcall ShowAggregates(void);
	
public:
	__property Stdctrls::TListBox* CurrentListBox = {read=GetCurrentListBox};
	__property Db::TDataSet* EditedDataset = {read=FEditedDataset, write=SetEditedDataset};
	__property Classes::TComponent* FieldsOwner = {read=FFieldsOwner, write=FFieldsOwner};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfmDatasetFieldsEditor(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfmDatasetFieldsEditor(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfmDatasetFieldsEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmDatasetFieldsEditor(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall EditDatasetFields(Db::TDataSet* ADataset, Classes::TComponent* AOwner = (Classes::TComponent*)(0x0), Formdesigner::TAdvCustomFormDesigner* AFormDesigner = (Formdesigner::TAdvCustomFormDesigner*)(0x0));

}	/* namespace Datasetfieldseditor */
using namespace Datasetfieldseditor;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DatasetfieldseditorHPP
