// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'DesignerControlsEditor.pas' rev: 22.00

#ifndef DesignercontrolseditorHPP
#define DesignercontrolseditorHPP

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
#include <FormDesigner.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Designercontrolseditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrmDesignerControlsEditor;
class PASCALIMPLEMENTATION TfrmDesignerControlsEditor : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TButton* btnDelete;
	Stdctrls::TButton* btnAdd;
	Stdctrls::TButton* btnOk;
	Stdctrls::TButton* btnCancel;
	Stdctrls::TButton* btnClear;
	Stdctrls::TListBox* lsbLocked;
	Extctrls::TRadioGroup* rgrControls;
	Stdctrls::TListBox* lsbProtected;
	Stdctrls::TListBox* lsbTransparent;
	void __fastcall btnAddClick(System::TObject* Sender);
	void __fastcall btnDeleteClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall btnClearClick(System::TObject* Sender);
	void __fastcall rgrControlsClick(System::TObject* Sender);
	void __fastcall lsbProtectedClick(System::TObject* Sender);
	
private:
	void __fastcall UpdateButtons(void);
	void __fastcall UpdateLists(void);
	Stdctrls::TListBox* __fastcall ActiveList(void);
	void __fastcall FillList(Classes::TComponent* AOwner, Formdesigner::TListType ListType, Classes::TStrings* Target, Classes::TStrings* Exclude, System::UnicodeString AName);
	
public:
	Formdesigner::TAdvCustomFormDesigner* FormDesigner;
	__fastcall virtual TfrmDesignerControlsEditor(Classes::TComponent* AOwner);
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmDesignerControlsEditor(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmDesignerControlsEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmDesignerControlsEditor(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE bool __fastcall EditLists(Formdesigner::TAdvCustomFormDesigner* AFormDesigner, Formdesigner::TListType DefaultList);

}	/* namespace Designercontrolseditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Designercontrolseditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DesignercontrolseditorHPP
