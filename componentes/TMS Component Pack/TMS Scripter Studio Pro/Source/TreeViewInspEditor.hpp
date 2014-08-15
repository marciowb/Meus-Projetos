// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TreeViewInspEditor.pas' rev: 22.00

#ifndef TreeviewinspeditorHPP
#define TreeviewinspeditorHPP

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
#include <TypInfo.hpp>	// Pascal unit
#include <PropertyList.hpp>	// Pascal unit
#include <PropertyInspEditors.hpp>	// Pascal unit
#include <IDEMain.hpp>	// Pascal unit
#include <ImgList.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Treeviewinspeditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TTreePropertyEditor;
class PASCALIMPLEMENTATION TTreePropertyEditor : public Propertyinspeditors::TPropertyEditor
{
	typedef Propertyinspeditors::TPropertyEditor inherited;
	
private:
	Comctrls::TTreeNodes* __fastcall GetTreeNodes(void);
	
public:
	virtual bool __fastcall Execute(void);
	__property Comctrls::TTreeNodes* TreeNodes = {read=GetTreeNodes};
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TTreePropertyEditor(Propertylist::TProperty* AProp) : Propertyinspeditors::TPropertyEditor(AProp) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TTreePropertyEditor(void) { }
	
};


#pragma option push -b-
enum TTargetPosition { tpNone, tpTop, tpItem, tpBottom };
#pragma option pop

class DELPHICLASS TPublishedTreeNode;
class PASCALIMPLEMENTATION TPublishedTreeNode : public Comctrls::TTreeNode
{
	typedef Comctrls::TTreeNode inherited;
	
__published:
	__property Text;
	__property ImageIndex;
	__property StateIndex;
	__property SelectedIndex;
public:
	/* TTreeNode.Create */ inline __fastcall virtual TPublishedTreeNode(Comctrls::TTreeNodes* AOwner) : Comctrls::TTreeNode(AOwner) { }
	/* TTreeNode.Destroy */ inline __fastcall virtual ~TPublishedTreeNode(void) { }
	
};


class DELPHICLASS TfrmTreeEditor;
class PASCALIMPLEMENTATION TfrmTreeEditor : public Forms::TForm
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
	void __fastcall cinItemPropertiesExit(System::TObject* Sender);
	void __fastcall cinItemPropertiesChange(System::TObject* Sender, int TheIndex);
	
private:
	Graphics::TCanvas* ListViewCanvas;
	TTreePropertyEditor* FEditor;
	TTargetPosition TargetPosition;
	Comctrls::TTreeNode* DragNode;
	TPublishedTreeNode* FPublishedTreeNode;
	void __fastcall DrawTargetIndicator(void);
	void __fastcall CopyProps(Comctrls::TTreeNode* Src, Comctrls::TTreeNode* Trg);
	HIDESBASE MESSAGE void __fastcall WMGetMinMaxInfo(Messages::TMessage &Msg);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrmTreeEditor(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmTreeEditor(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmTreeEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmTreeEditor(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Treeviewinspeditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Treeviewinspeditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TreeviewinspeditorHPP
