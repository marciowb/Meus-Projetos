// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'fExpressionConditionEditor.pas' rev: 22.00

#ifndef FexpressionconditioneditorHPP
#define FexpressionconditioneditorHPP

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
#include <fCustomConditionEditor.hpp>	// Pascal unit
#include <fCustomEditor.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Fexpressionconditioneditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfmExpressionConditionEditor;
class PASCALIMPLEMENTATION TfmExpressionConditionEditor : public Fcustomconditioneditor::TfmCustomConditionEditor
{
	typedef Fcustomconditioneditor::TfmCustomConditionEditor inherited;
	
__published:
	Extctrls::TPanel* pnCustomExpr;
	Stdctrls::TLabel* Label5;
	Stdctrls::TEdit* edExpression;
	HIDESBASE void __fastcall btOkClick(System::TObject* Sender);
	
private:
	HIDESBASE void __fastcall Localize(void);
	
protected:
	virtual void __fastcall Loaded(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfmExpressionConditionEditor(Classes::TComponent* AOwner) : Fcustomconditioneditor::TfmCustomConditionEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfmExpressionConditionEditor(Classes::TComponent* AOwner, int Dummy) : Fcustomconditioneditor::TfmCustomConditionEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfmExpressionConditionEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmExpressionConditionEditor(HWND ParentWindow) : Fcustomconditioneditor::TfmCustomConditionEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TfmExpressionConditionEditor* fmExpressionConditionEditor;

}	/* namespace Fexpressionconditioneditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Fexpressionconditioneditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FexpressionconditioneditorHPP
