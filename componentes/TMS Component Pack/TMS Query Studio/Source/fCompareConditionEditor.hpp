// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'fCompareConditionEditor.pas' rev: 22.00

#ifndef FcompareconditioneditorHPP
#define FcompareconditioneditorHPP

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
#include <atMetaSQL.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <fCustomConditionEditor.hpp>	// Pascal unit
#include <fCustomEditor.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Fcompareconditioneditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfmCompareConditionEditor;
class PASCALIMPLEMENTATION TfmCompareConditionEditor : public Fcustomconditioneditor::TfmCustomConditionEditor
{
	typedef Fcustomconditioneditor::TfmCustomConditionEditor inherited;
	
__published:
	Extctrls::TPanel* pnExpression;
	Stdctrls::TLabel* Label1;
	Stdctrls::TComboBox* edField;
	Stdctrls::TComboBox* edOperator;
	Stdctrls::TComboBox* edValue;
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	HIDESBASE void __fastcall btOkClick(System::TObject* Sender);
	
private:
	System::UnicodeString FPreSelectedField;
	System::UnicodeString FPreSelectedValue;
	System::UnicodeString FPreSelectedOper;
	void __fastcall SetPreSelectedField(const System::UnicodeString Value);
	void __fastcall SetPreSelectedOper(const System::UnicodeString Value);
	void __fastcall SetPreSelectedValue(const System::UnicodeString Value);
	HIDESBASE void __fastcall Localize(void);
	
protected:
	virtual void __fastcall Loaded(void);
	
public:
	__property System::UnicodeString PreSelectedField = {read=FPreSelectedField, write=SetPreSelectedField};
	__property System::UnicodeString PreSelectedValue = {read=FPreSelectedValue, write=SetPreSelectedValue};
	__property System::UnicodeString PreSelectedOper = {read=FPreSelectedOper, write=SetPreSelectedOper};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfmCompareConditionEditor(Classes::TComponent* AOwner) : Fcustomconditioneditor::TfmCustomConditionEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfmCompareConditionEditor(Classes::TComponent* AOwner, int Dummy) : Fcustomconditioneditor::TfmCustomConditionEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfmCompareConditionEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmCompareConditionEditor(HWND ParentWindow) : Fcustomconditioneditor::TfmCustomConditionEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TfmCompareConditionEditor* fmCompareConditionEditor;

}	/* namespace Fcompareconditioneditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Fcompareconditioneditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FcompareconditioneditorHPP
