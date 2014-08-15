// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'fCustomConditionEditor.pas' rev: 22.00

#ifndef FcustomconditioneditorHPP
#define FcustomconditioneditorHPP

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
#include <fCustomEditor.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Fcustomconditioneditor
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TLogicalOper { loNone, loNot, loAnd, loAndNot, loOr, loOrNot };
#pragma option pop

class DELPHICLASS TfmCustomConditionEditor;
class PASCALIMPLEMENTATION TfmCustomConditionEditor : public Fcustomeditor::TfmCustomEditor
{
	typedef Fcustomeditor::TfmCustomEditor inherited;
	
__published:
	Extctrls::TPanel* pnOperator;
	Stdctrls::TLabel* Label3;
	Stdctrls::TComboBox* edLogicOper;
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	
private:
	Atmetasql::TatSQLConditions* FConditions;
	void __fastcall SetConditions(const Atmetasql::TatSQLConditions* Value);
	HIDESBASE void __fastcall Localize(void);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall SetEditedObject(const System::TObject* Value);
	void __fastcall AdjustConditionOperator(Atmetasql::TatSQLCondition* ACond, TLogicalOper lo);
	
public:
	__property Atmetasql::TatSQLConditions* Conditions = {read=FConditions, write=SetConditions};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfmCustomConditionEditor(Classes::TComponent* AOwner) : Fcustomeditor::TfmCustomEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfmCustomConditionEditor(Classes::TComponent* AOwner, int Dummy) : Fcustomeditor::TfmCustomEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfmCustomConditionEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmCustomConditionEditor(HWND ParentWindow) : Fcustomeditor::TfmCustomEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TfmCustomConditionEditor* fmCustomConditionEditor;

}	/* namespace Fcustomconditioneditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Fcustomconditioneditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FcustomconditioneditorHPP
