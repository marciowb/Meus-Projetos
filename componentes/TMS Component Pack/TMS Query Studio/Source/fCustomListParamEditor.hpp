// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'fCustomListParamEditor.pas' rev: 22.00

#ifndef FcustomlistparameditorHPP
#define FcustomlistparameditorHPP

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
#include <ComCtrls.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <fCustomParamEditor.hpp>	// Pascal unit
#include <atVisualQuery.hpp>	// Pascal unit
#include <fCustomEditor.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Fcustomlistparameditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfmCustomListParamEditor;
class PASCALIMPLEMENTATION TfmCustomListParamEditor : public Fcustomparameditor::TfmCustomParamEditor
{
	typedef Fcustomparameditor::TfmCustomParamEditor inherited;
	
__published:
	Extctrls::TPanel* pnItems;
	Stdctrls::TLabel* lbParamValues;
	Comctrls::TListView* edParamValues;
	Stdctrls::TLabel* Label2;
	Comctrls::TListView* edListItems;
	HIDESBASE void __fastcall btOkClick(System::TObject* Sender);
	void __fastcall edParamValuesKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall edListItemsClick(System::TObject* Sender);
	void __fastcall edParamValuesEnter(System::TObject* Sender);
	void __fastcall edListItemsChange(System::TObject* Sender, Comctrls::TListItem* Item, Comctrls::TItemChange Change);
	void __fastcall edParamValuesEdited(System::TObject* Sender, Comctrls::TListItem* Item, System::UnicodeString &S);
	void __fastcall edListItemsKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall edParamValuesCompare(System::TObject* Sender, Comctrls::TListItem* Item1, Comctrls::TListItem* Item2, int Data, int &Compare);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	
private:
	Classes::TStringList* FDefaultParams;
	void __fastcall EditNewItem(void);
	void __fastcall LoadParamValues(void);
	void __fastcall ClearParamValuesLists(void);
	void __fastcall CreateIncludeItem(void);
	Classes::TStringList* __fastcall GetCurrentParams(void);
	void __fastcall AssignParamValues(Classes::TStrings* ASource, Atvisualquery::TatParamValues* ATarget);
	HIDESBASE void __fastcall Localize(void);
	
protected:
	virtual void __fastcall Loaded(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfmCustomListParamEditor(Classes::TComponent* AOwner) : Fcustomparameditor::TfmCustomParamEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfmCustomListParamEditor(Classes::TComponent* AOwner, int Dummy) : Fcustomparameditor::TfmCustomParamEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfmCustomListParamEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmCustomListParamEditor(HWND ParentWindow) : Fcustomparameditor::TfmCustomParamEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TfmCustomListParamEditor* fmCustomListParamEditor;

}	/* namespace Fcustomlistparameditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Fcustomlistparameditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FcustomlistparameditorHPP
