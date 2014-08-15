// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'MenuInspIDEEditor.pas' rev: 22.00

#ifndef MenuinspideeditorHPP
#define MenuinspideeditorHPP

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
#include <ComCtrls.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <InspectorControls.hpp>	// Pascal unit
#include <ComponentInspector.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <TypInfo.hpp>	// Pascal unit
#include <PropertyList.hpp>	// Pascal unit
#include <PropertyInspEditors.hpp>	// Pascal unit
#include <IDEMain.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Menuinspideeditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TMenuIDEPropertyEditor;
class PASCALIMPLEMENTATION TMenuIDEPropertyEditor : public Propertyinspeditors::TPropertyEditor
{
	typedef Propertyinspeditors::TPropertyEditor inherited;
	
private:
	Componentinspector::TAdvCustomComponentInspector* __fastcall GetInspector(void);
	
public:
	virtual bool __fastcall Execute(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TMenuIDEPropertyEditor(Propertylist::TProperty* AProp) : Propertyinspeditors::TPropertyEditor(AProp) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TMenuIDEPropertyEditor(void) { }
	
};


#pragma option push -b-
enum TTargetPosition { tpNone, tpTop, tpItem, tpBottom };
#pragma option pop

class DELPHICLASS TfrmMenuIDEEditor;
class DELPHICLASS TMenuIDENotifier;
class PASCALIMPLEMENTATION TfrmMenuIDEEditor : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Comctrls::TTreeView* trvItems;
	Extctrls::TPanel* Panel1;
	Stdctrls::TButton* btnNewItem;
	Stdctrls::TButton* btnNewSubitem;
	Stdctrls::TButton* btnDeleteItem;
	void __fastcall btnAddItemClick(System::TObject* Sender);
	void __fastcall trvItemsDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall trvItemsDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall trvItemsChange(System::TObject* Sender, Comctrls::TTreeNode* Node);
	void __fastcall trvItemsStartDrag(System::TObject* Sender, Controls::TDragObject* &DragObject);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall btnDeleteItemClick(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, Forms::TCloseAction &Action);
	
private:
	Graphics::TCanvas* ListViewCanvas;
	TTargetPosition TargetPosition;
	Comctrls::TTreeNode* DragNode;
	Idemain::TIDEEngine* FEngine;
	Menus::TMenu* FMenu;
	int FUpdating;
	TMenuIDENotifier* FNotifier;
	void __fastcall DrawTargetIndicator(void);
	HIDESBASE MESSAGE void __fastcall WMGetMinMaxInfo(Messages::TMessage &Msg);
	void __fastcall MenuToTreeView(void);
	Menus::TMenuItem* __fastcall MenuFromNode(Comctrls::TTreeNode* ANode);
	void __fastcall SelectItemInTreeView(Menus::TMenuItem* AItem);
	void __fastcall UpdateEditor(void);
	void __fastcall UpdateCaptions(void);
	void __fastcall BeginUpdateTree(void);
	void __fastcall EndUpdateTree(void);
	void __fastcall SetEngine(const Idemain::TIDEEngine* Value);
	__property Idemain::TIDEEngine* Engine = {read=FEngine, write=SetEngine};
	
public:
	__fastcall virtual TfrmMenuIDEEditor(Classes::TComponent* AOwner);
	__fastcall virtual ~TfrmMenuIDEEditor(void);
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmMenuIDEEditor(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmMenuIDEEditor(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TMenuIDENotifier : public Idemain::TIDEEngineNotifier
{
	typedef Idemain::TIDEEngineNotifier inherited;
	
private:
	TfrmMenuIDEEditor* FEditor;
	
public:
	virtual void __fastcall Notification(Idemain::TIDENotificationType AOperation);
public:
	/* TObject.Create */ inline __fastcall TMenuIDENotifier(void) : Idemain::TIDEEngineNotifier() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TMenuIDENotifier(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Menuinspideeditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Menuinspideeditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// MenuinspideeditorHPP
