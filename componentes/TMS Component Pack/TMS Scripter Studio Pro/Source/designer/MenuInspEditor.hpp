// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Menuinspeditor.pas' rev: 21.00

#ifndef MenuinspeditorHPP
#define MenuinspeditorHPP

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
#include <Menus.hpp>	// Pascal unit
#include <Typinfo.hpp>	// Pascal unit
#include <Propertylist.hpp>	// Pascal unit
#include <Propertyinspeditors.hpp>	// Pascal unit
#include <Idemain.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Menuinspeditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TMenuPropertyEditor;
class PASCALIMPLEMENTATION TMenuPropertyEditor : public Propertyinspeditors::TPropertyEditor
{
	typedef Propertyinspeditors::TPropertyEditor inherited;
	
private:
	Menus::TMenuItem* __fastcall GetMenuItems(void);
	
public:
	virtual bool __fastcall Execute(void);
	__property Menus::TMenuItem* MenuItems = {read=GetMenuItems};
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TMenuPropertyEditor(Propertylist::TProperty* AProp) : Propertyinspeditors::TPropertyEditor(AProp) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TMenuPropertyEditor(void) { }
	
};


#pragma option push -b-
enum TTargetPosition { tpNone, tpTop, tpItem, tpBottom };
#pragma option pop

class DELPHICLASS TfrmMenuEditor;
class PASCALIMPLEMENTATION TfrmMenuEditor : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Extctrls::TSplitter* splMain;
	Comctrls::TTreeView* trvItems;
	Extctrls::TPanel* pnlButtons;
	Stdctrls::TButton* btnNewItem;
	Stdctrls::TButton* btnNewSubitem;
	Stdctrls::TButton* btnDeleteItem;
	Extctrls::TPanel* pnlSysButtons;
	Stdctrls::TButton* btnOK;
	Stdctrls::TButton* btnCancel;
	Comctrls::TTabControl* tbcInspector;
	Idemain::TIDEInspector* cinItemProperties;
	void __fastcall btnAddItemClick(System::TObject* Sender);
	void __fastcall trvItemsDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall trvItemsDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall trvItemsChange(System::TObject* Sender, Comctrls::TTreeNode* Node);
	void __fastcall trvItemsStartDrag(System::TObject* Sender, Controls::TDragObject* &DragObject);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall btnDeleteItemClick(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, Forms::TCloseAction &Action);
	void __fastcall cinItemPropertiesGetValuesList(System::TObject* Sender, int TheIndex, const Classes::TStrings* Strings);
	void __fastcall tbcInspectorChange(System::TObject* Sender);
	void __fastcall cinItemPropertiesSetValue(System::TObject* Sender, int TheIndex, System::UnicodeString &Value, bool &EnableDefault);
	void __fastcall cinItemPropertiesExit(System::TObject* Sender);
	
private:
	Graphics::TCanvas* ListViewCanvas;
	TMenuPropertyEditor* FEditor;
	Classes::TComponent* FItemsOwner;
	TTargetPosition TargetPosition;
	Comctrls::TTreeNode* DragNode;
	void __fastcall MenuToNode(void);
	void __fastcall NodeToMenu(void);
	void __fastcall DrawTargetIndicator(void);
	HIDESBASE MESSAGE void __fastcall WMGetMinMaxInfo(Messages::TMessage &Msg);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrmMenuEditor(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmMenuEditor(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmMenuEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmMenuEditor(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Menuinspeditor */
using namespace Menuinspeditor;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// MenuinspeditorHPP
