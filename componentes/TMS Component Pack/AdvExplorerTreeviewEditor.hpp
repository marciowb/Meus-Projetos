// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advexplorertreevieweditor.pas' rev: 21.00

#ifndef AdvexplorertreevieweditorHPP
#define AdvexplorertreevieweditorHPP

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
#include <Variants.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Spin.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Advexplorertreeview.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advexplorertreevieweditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TExpTreeviewEditor;
class PASCALIMPLEMENTATION TExpTreeviewEditor : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TGroupBox* GroupBox1;
	Comctrls::TTreeView* Treeview1;
	Stdctrls::TButton* Btn_NewItem;
	Stdctrls::TButton* Btn_NewSubItem;
	Stdctrls::TButton* Btn_Delete;
	Stdctrls::TGroupBox* GroupBox2;
	Stdctrls::TLabel* Label1;
	Stdctrls::TLabel* Label2;
	Stdctrls::TEdit* Ed_Text;
	Spin::TSpinEdit* Sp_ImageIndex;
	Stdctrls::TButton* Btn_Ok;
	Stdctrls::TButton* Btn_Cancel;
	Extctrls::TImage* Image1;
	void __fastcall Btn_OkClick(System::TObject* Sender);
	void __fastcall Btn_NewItemClick(System::TObject* Sender);
	void __fastcall Ed_TextChange(System::TObject* Sender);
	void __fastcall Sp_ImageIndexChange(System::TObject* Sender);
	void __fastcall Btn_NewSubItemClick(System::TObject* Sender);
	void __fastcall Btn_DeleteClick(System::TObject* Sender);
	void __fastcall Treeview1Change(System::TObject* Sender, Comctrls::TTreeNode* Node);
	void __fastcall FormCreate(System::TObject* Sender);
	
private:
	Advexplorertreeview::TAdvExplorerTreeview* FExplorerTreeview;
	bool FInternalChange;
	void __fastcall SetExplorerTreeview(const Advexplorertreeview::TAdvExplorerTreeview* Value);
	void __fastcall UpdateImage(void);
	
protected:
	void __fastcall AddNodeChildren(Advexplorertreeview::TAdvTreeNode* &ExpNode, Comctrls::TTreeNode* &Node);
	void __fastcall CopyItemsFromTvToExpTv(void);
	void __fastcall AddExpNodeChildren(Comctrls::TTreeNode* &Node, Advexplorertreeview::TAdvTreeNode* &ExpNode);
	void __fastcall UpdateButtons(void);
	
public:
	__property Advexplorertreeview::TAdvExplorerTreeview* ExplorerTreeview = {read=FExplorerTreeview, write=SetExplorerTreeview};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TExpTreeviewEditor(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TExpTreeviewEditor(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TExpTreeviewEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TExpTreeviewEditor(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TExpTreeviewEditor* ExpTreeviewEditor;

}	/* namespace Advexplorertreevieweditor */
using namespace Advexplorertreevieweditor;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvexplorertreevieweditorHPP
