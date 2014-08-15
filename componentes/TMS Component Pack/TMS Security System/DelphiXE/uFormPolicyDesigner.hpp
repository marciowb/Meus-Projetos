// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'uFormPolicyDesigner.pas' rev: 22.00

#ifndef UformpolicydesignerHPP
#define UformpolicydesignerHPP

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
#include <StdCtrls.hpp>	// Pascal unit
#include <ToolWin.hpp>	// Pascal unit
#include <uFormPolicy.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <TypInfo.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <ImgList.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uformpolicydesigner
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrmFormPolicy;
class PASCALIMPLEMENTATION TfrmFormPolicy : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Comctrls::TToolBar* ToolBar1;
	Comctrls::TToolButton* btnAddItem;
	Comctrls::TToolButton* btnRemoveItem;
	Controls::TImageList* ilToolbar;
	Controls::TImageList* ilPolicies;
	Menus::TPopupMenu* PopupMenu1;
	Menus::TMenuItem* Hide1;
	Menus::TMenuItem* Disable1;
	Menus::TMenuItem* N1;
	Menus::TMenuItem* Delete1;
	Extctrls::TPanel* Panel1;
	Stdctrls::TLabel* Label1;
	Extctrls::TPanel* Panel2;
	Comctrls::TTreeView* tvPolicies;
	Extctrls::TSplitter* Splitter1;
	Extctrls::TPanel* Panel3;
	Comctrls::TTreeView* tvComponents;
	Extctrls::TPanel* Panel4;
	Buttons::TBitBtn* btnCancel;
	Buttons::TBitBtn* btnOK;
	Stdctrls::TLabel* Label2;
	Stdctrls::TLabel* Label3;
	Extctrls::TPanel* Panel5;
	Buttons::TSpeedButton* btnAdd;
	Controls::TImageList* ilComponents;
	Comctrls::TToolButton* ToolButton1;
	Comctrls::TToolButton* ToolButton2;
	Comctrls::TToolButton* ToolButton3;
	Comctrls::TToolButton* ToolButton4;
	Menus::TMenuItem* Customaction1;
	Comctrls::TToolButton* ToolButton7;
	Menus::TMenuItem* Readonly1;
	Menus::TMenuItem* N2;
	Menus::TMenuItem* Expandall1;
	Menus::TMenuItem* Collapsall1;
	Menus::TPopupMenu* PopupMenu2;
	Menus::TMenuItem* Expandall2;
	Menus::TMenuItem* Collapsall2;
	void __fastcall btnAddItemClick(System::TObject* Sender);
	void __fastcall Hide1Click(System::TObject* Sender);
	void __fastcall Disable1Click(System::TObject* Sender);
	void __fastcall btnRemoveItemClick(System::TObject* Sender);
	void __fastcall tvPoliciesDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall tvPoliciesDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall Splitter1Moved(System::TObject* Sender);
	void __fastcall btnAddClick(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall tvPoliciesEditing(System::TObject* Sender, Comctrls::TTreeNode* Node, bool &AllowEdit);
	void __fastcall ToolButton4Click(System::TObject* Sender);
	void __fastcall tvPoliciesChange(System::TObject* Sender, Comctrls::TTreeNode* Node);
	void __fastcall ToolButton7Click(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall Expandall1Click(System::TObject* Sender);
	void __fastcall Collapsall1Click(System::TObject* Sender);
	void __fastcall Expandall2Click(System::TObject* Sender);
	void __fastcall Collapsall2Click(System::TObject* Sender);
	
private:
	Uformpolicy::TuilFormPolicy* FUILFormPolicy;
	System::UnicodeString FFormName;
	
public:
	__property Uformpolicy::TuilFormPolicy* FormPolicy = {read=FUILFormPolicy, write=FUILFormPolicy};
	__property System::UnicodeString FormName = {read=FFormName, write=FFormName};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrmFormPolicy(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmFormPolicy(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmFormPolicy(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmFormPolicy(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::ShortInt LabelImage = 0x1;
static const System::ShortInt EditImage = 0x2;
static const System::ShortInt ButtonImage = 0x3;
static const System::ShortInt CheckImage = 0x4;
static const System::ShortInt RadioImage = 0x5;
static const System::ShortInt MenuImage = 0x6;
static const System::ShortInt ListBoxImage = 0x7;
static const System::ShortInt MemoImage = 0x8;
static const System::ShortInt Unknown = 0x9;

}	/* namespace Uformpolicydesigner */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Uformpolicydesigner;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UformpolicydesignerHPP
