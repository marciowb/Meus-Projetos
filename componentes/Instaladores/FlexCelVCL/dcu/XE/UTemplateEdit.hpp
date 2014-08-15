// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'UTemplateEdit.pas' rev: 22.00

#ifndef UtemplateeditHPP
#define UtemplateeditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <ActnList.hpp>	// Pascal unit
#include <ImgList.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <FileCtrl.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <TemplateStore.hpp>	// Pascal unit
#include <UFlxMessages.hpp>	// Pascal unit

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
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Utemplateedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UtemplateeditHPP
