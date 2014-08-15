// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Listviewinspeditor.pas' rev: 21.00

#ifndef ListviewinspeditorHPP
#define ListviewinspeditorHPP

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
#include <Comctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Inspectorcontrols.hpp>	// Pascal unit
#include <Componentinspector.hpp>	// Pascal unit
#include <Typinfo.hpp>	// Pascal unit
#include <Propertylist.hpp>	// Pascal unit
#include <Propertyinspeditors.hpp>	// Pascal unit
#include <Idemain.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Listviewinspeditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TListViewPropertyEditor;
class PASCALIMPLEMENTATION TListViewPropertyEditor : public Propertyinspeditors::TPropertyEditor
{
	typedef Propertyinspeditors::TPropertyEditor inherited;
	
private:
	Comctrls::TListItems* __fastcall GetListItems(void);
	
public:
	virtual bool __fastcall Execute(void);
	__property Comctrls::TListItems* ListItems = {read=GetListItems};
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TListViewPropertyEditor(Propertylist::TProperty* AProp) : Propertyinspeditors::TPropertyEditor(AProp) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TListViewPropertyEditor(void) { }
	
};


#pragma option push -b-
enum TTargetPosition { tpNone, tpTop, tpItem, tpBottom };
#pragma option pop

class DELPHICLASS TInspectorData;
class PASCALIMPLEMENTATION TInspectorData : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	System::UnicodeString FCaption;
	int FImageIndex;
	int FStateIndex;
	Classes::TStrings* FSubitems;
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=FCaption};
	__property int ImageIndex = {read=FImageIndex, write=FImageIndex, nodefault};
	__property int StateIndex = {read=FStateIndex, write=FStateIndex, nodefault};
	__property Classes::TStrings* Subitems = {read=FSubitems, write=FSubitems};
	
public:
	__fastcall TInspectorData(void);
	__fastcall virtual ~TInspectorData(void);
};


class DELPHICLASS TfrmListViewEditor;
class PASCALIMPLEMENTATION TfrmListViewEditor : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Extctrls::TSplitter* splMain;
	Extctrls::TPanel* pnlButtons;
	Stdctrls::TButton* btnAdd;
	Stdctrls::TButton* btnDelete;
	Extctrls::TPanel* pnlSysButtons;
	Stdctrls::TButton* btnOK;
	Stdctrls::TButton* btnCancel;
	Comctrls::TListView* lsvItems;
	Stdctrls::TButton* btnUp;
	Stdctrls::TButton* btnDown;
	Idemain::TIDEInspector* cinItemProperties;
	void __fastcall lsvItemsDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall lsvItemsDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall trvItemsStartDrag(System::TObject* Sender, Controls::TDragObject* &DragObject);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall btnDeleteClick(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, Forms::TCloseAction &Action);
	void __fastcall cinItemPropertiesExit(System::TObject* Sender);
	void __fastcall cinItemPropertiesChange(System::TObject* Sender, int TheIndex);
	void __fastcall lsvItemsChange(System::TObject* Sender, Comctrls::TListItem* Item, Comctrls::TItemChange Change);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall btnAddClick(System::TObject* Sender);
	void __fastcall btnUpClick(System::TObject* Sender);
	void __fastcall btnDownClick(System::TObject* Sender);
	
private:
	TListViewPropertyEditor* FEditor;
	Comctrls::TListItem* DragItem;
	TInspectorData* FInspectorData;
	void __fastcall ItemToData(Comctrls::TListItem* Item, TInspectorData* Data);
	void __fastcall DataToItem(TInspectorData* Data, Comctrls::TListItem* Item);
	HIDESBASE MESSAGE void __fastcall WMGetMinMaxInfo(Messages::TMessage &Msg);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrmListViewEditor(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmListViewEditor(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmListViewEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmListViewEditor(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Listviewinspeditor */
using namespace Listviewinspeditor;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ListviewinspeditorHPP
