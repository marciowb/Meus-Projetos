// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'fCustomOrderEditor.pas' rev: 22.00

#ifndef FcustomordereditorHPP
#define FcustomordereditorHPP

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
#include <fCustomEditor.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Fcustomordereditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfmCustomOrderEditor;
class PASCALIMPLEMENTATION TfmCustomOrderEditor : public Fcustomeditor::TfmCustomEditor
{
	typedef Fcustomeditor::TfmCustomEditor inherited;
	
__published:
	Extctrls::TPanel* pnFieldName;
	Stdctrls::TLabel* Label2;
	Stdctrls::TComboBox* edFieldExpr;
	Extctrls::TPanel* pnAggregation;
	Stdctrls::TLabel* Label4;
	Stdctrls::TComboBox* edAggregation;
	
private:
	HIDESBASE void __fastcall Localize(void);
	
protected:
	virtual void __fastcall Loaded(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfmCustomOrderEditor(Classes::TComponent* AOwner) : Fcustomeditor::TfmCustomEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfmCustomOrderEditor(Classes::TComponent* AOwner, int Dummy) : Fcustomeditor::TfmCustomEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfmCustomOrderEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmCustomOrderEditor(HWND ParentWindow) : Fcustomeditor::TfmCustomEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TfmCustomOrderEditor* fmCustomOrderEditor;

}	/* namespace Fcustomordereditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Fcustomordereditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FcustomordereditorHPP
