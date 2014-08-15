// CodeGear C++Builder
// Copyright (c) 1995, 2008 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Utemplateedit.pas' rev: 20.00

#ifndef UtemplateeditHPP
#define UtemplateeditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Actnlist.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Filectrl.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Templatestore.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Utemplateedit
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TTemplateEdit;
class PASCALIMPLEMENTATION TTemplateEdit : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Comctrls::TToolBar* ToolBar1;
	Comctrls::TToolButton* btnOk;
	Comctrls::TToolButton* btnCancel;
	Controls::TImageList* ImageList1;
	Controls::TImageList* ImageList2;
	Controls::TImageList* ImageList3;
	Actnlist::TActionList* ActionList1;
	Actnlist::TAction* ActionOk;
	Actnlist::TAction* ActionSaveAs;
	Actnlist::TAction* ActionRefresh;
	Actnlist::TAction* ActionAdd;
	Actnlist::TAction* ActionDelete;
	Comctrls::TToolButton* ToolButton2;
	Comctrls::TToolButton* ToolButton3;
	Comctrls::TToolButton* ToolButton4;
	Comctrls::TToolButton* ToolButton5;
	Comctrls::TToolButton* ToolButton6;
	Comctrls::TListView* Files;
	Dialogs::TOpenDialog* OpenDialog;
	Dialogs::TSaveDialog* SaveDialog;
	Extctrls::TPanel* FormCaption;
	void __fastcall ActionOkExecute(System::TObject* Sender);
	void __fastcall ActionAddExecute(System::TObject* Sender);
	void __fastcall ActionDeleteExecute(System::TObject* Sender);
	void __fastcall ActionDeleteUpdate(System::TObject* Sender);
	void __fastcall ActionRefreshExecute(System::TObject* Sender);
	void __fastcall ActionSaveAsUpdate(System::TObject* Sender);
	void __fastcall ActionSaveAsExecute(System::TObject* Sender);
	
private:
	Templatestore::TXlsTemplateStore* TStore;
	void __fastcall RefreshList(void);
	
public:
	bool Modified;
	void __fastcall LoadData(const Templatestore::TXlsTemplateStore* aTStore);
	__fastcall virtual TTemplateEdit(Classes::TComponent* AOwner);
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TTemplateEdit(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TTemplateEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TTemplateEdit(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall InvokeTemplateEditor(const Templatestore::TXlsTemplateStore* aTStore, /* out */ bool &Modified);
extern PACKAGE void __fastcall RefreshTemplateStore(const Templatestore::TXlsTemplateStore* aTStore, /* out */ bool &Modified);

}	/* namespace Utemplateedit */
using namespace Utemplateedit;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UtemplateeditHPP
