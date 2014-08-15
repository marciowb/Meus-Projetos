// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'fCustomGroupEditor.pas' rev: 22.00

#ifndef FcustomgroupeditorHPP
#define FcustomgroupeditorHPP

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

namespace Fcustomgroupeditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfmCustomGroupEditor;
class PASCALIMPLEMENTATION TfmCustomGroupEditor : public Fcustomeditor::TfmCustomEditor
{
	typedef Fcustomeditor::TfmCustomEditor inherited;
	
__published:
	Extctrls::TPanel* pnFieldName;
	Stdctrls::TLabel* Label2;
	Stdctrls::TComboBox* edFieldExpr;
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	HIDESBASE void __fastcall btOkClick(System::TObject* Sender);
	
private:
	HIDESBASE void __fastcall Localize(void);
	
protected:
	virtual void __fastcall Loaded(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfmCustomGroupEditor(Classes::TComponent* AOwner) : Fcustomeditor::TfmCustomEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfmCustomGroupEditor(Classes::TComponent* AOwner, int Dummy) : Fcustomeditor::TfmCustomEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfmCustomGroupEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmCustomGroupEditor(HWND ParentWindow) : Fcustomeditor::TfmCustomEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TfmCustomGroupEditor* fmCustomGroupEditor;

}	/* namespace Fcustomgroupeditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Fcustomgroupeditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FcustomgroupeditorHPP
