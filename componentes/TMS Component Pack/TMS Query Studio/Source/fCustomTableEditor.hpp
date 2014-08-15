// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'fCustomTableEditor.pas' rev: 22.00

#ifndef FcustomtableeditorHPP
#define FcustomtableeditorHPP

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
#include <Buttons.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <atMetaSQL.hpp>	// Pascal unit
#include <uDBUtil.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <fCustomEditor.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Fcustomtableeditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfmCustomTableEditor;
class PASCALIMPLEMENTATION TfmCustomTableEditor : public Fcustomeditor::TfmCustomEditor
{
	typedef Fcustomeditor::TfmCustomEditor inherited;
	
__published:
	Extctrls::TPanel* pnTableName;
	Stdctrls::TLabel* Label1;
	Stdctrls::TComboBox* edTableName;
	Extctrls::TPanel* pnTableAlias;
	Stdctrls::TLabel* Label2;
	Stdctrls::TEdit* edTableAlias;
	Extctrls::TPanel* pnJoinType;
	Stdctrls::TLabel* Label4;
	Stdctrls::TComboBox* edJoinType;
	Extctrls::TPanel* pnJoinCondition;
	Stdctrls::TLabel* Label3;
	Stdctrls::TEdit* edJoinCondition;
	void __fastcall edTableNameExit(System::TObject* Sender);
	HIDESBASE void __fastcall btOkClick(System::TObject* Sender);
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	
private:
	void __fastcall ValidateConditionFields(Atmetasql::TatSQLConditions* ACond);
	HIDESBASE void __fastcall Localize(void);
	
protected:
	virtual void __fastcall Loaded(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfmCustomTableEditor(Classes::TComponent* AOwner) : Fcustomeditor::TfmCustomEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfmCustomTableEditor(Classes::TComponent* AOwner, int Dummy) : Fcustomeditor::TfmCustomEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfmCustomTableEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmCustomTableEditor(HWND ParentWindow) : Fcustomeditor::TfmCustomEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TfmCustomTableEditor* fmCustomTableEditor;

}	/* namespace Fcustomtableeditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Fcustomtableeditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FcustomtableeditorHPP
