// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'fExpressionFieldEditor.pas' rev: 22.00

#ifndef FexpressionfieldeditorHPP
#define FexpressionfieldeditorHPP

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
#include <Menus.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <TypInfo.hpp>	// Pascal unit
#include <atMetaSQL.hpp>	// Pascal unit
#include <fCustomFieldEditor.hpp>	// Pascal unit
#include <fCustomEditor.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Fexpressionfieldeditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfmExpressionFieldEditor;
class PASCALIMPLEMENTATION TfmExpressionFieldEditor : public Fcustomfieldeditor::TfmCustomFieldEditor
{
	typedef Fcustomfieldeditor::TfmCustomFieldEditor inherited;
	
__published:
	Extctrls::TPanel* pnAggregation;
	Stdctrls::TLabel* Label4;
	Stdctrls::TComboBox* edAggregation;
	Extctrls::TPanel* pnExpression;
	Stdctrls::TLabel* Label6;
	Stdctrls::TEdit* edExpression;
	Extctrls::TPanel* pnFieldAlias;
	Stdctrls::TLabel* Label3;
	Stdctrls::TEdit* edFieldAlias;
	Extctrls::TPanel* pnDisplayLabel;
	Stdctrls::TLabel* Label5;
	Stdctrls::TEdit* edDisplayLabel;
	Extctrls::TPanel* pnDataType;
	Stdctrls::TLabel* Label7;
	Stdctrls::TComboBox* edDataType;
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall edFieldAliasExit(System::TObject* Sender);
	HIDESBASE void __fastcall btOkClick(System::TObject* Sender);
	
private:
	HIDESBASE void __fastcall Localize(void);
	
protected:
	virtual void __fastcall Loaded(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfmExpressionFieldEditor(Classes::TComponent* AOwner) : Fcustomfieldeditor::TfmCustomFieldEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfmExpressionFieldEditor(Classes::TComponent* AOwner, int Dummy) : Fcustomfieldeditor::TfmCustomFieldEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfmExpressionFieldEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmExpressionFieldEditor(HWND ParentWindow) : Fcustomfieldeditor::TfmCustomFieldEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TfmExpressionFieldEditor* fmExpressionFieldEditor;

}	/* namespace Fexpressionfieldeditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Fexpressionfieldeditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FexpressionfieldeditorHPP
