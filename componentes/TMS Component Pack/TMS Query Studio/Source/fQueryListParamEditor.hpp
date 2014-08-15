// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'fQueryListParamEditor.pas' rev: 22.00

#ifndef FquerylistparameditorHPP
#define FquerylistparameditorHPP

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
#include <Menus.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <fCustomParamEditor.hpp>	// Pascal unit
#include <fCustomEditor.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Fquerylistparameditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfmQueryListParamEditor;
class PASCALIMPLEMENTATION TfmQueryListParamEditor : public Fcustomparameditor::TfmCustomParamEditor
{
	typedef Fcustomparameditor::TfmCustomParamEditor inherited;
	
__published:
	Extctrls::TPanel* pnParamName;
	Stdctrls::TLabel* Label2;
	Stdctrls::TComboBox* edParamName;
	Extctrls::TPanel* pnMetaSql;
	Stdctrls::TLabel* Label1;
	Comctrls::TRichEdit* edMetaSql;
	Buttons::TBitBtn* btMetaSql;
	Extctrls::TBevel* Bevel1;
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	HIDESBASE void __fastcall btOkClick(System::TObject* Sender);
	void __fastcall edCaptionEnter(System::TObject* Sender);
	
private:
	HIDESBASE void __fastcall Localize(void);
	
protected:
	virtual void __fastcall Loaded(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfmQueryListParamEditor(Classes::TComponent* AOwner) : Fcustomparameditor::TfmCustomParamEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfmQueryListParamEditor(Classes::TComponent* AOwner, int Dummy) : Fcustomparameditor::TfmCustomParamEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfmQueryListParamEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmQueryListParamEditor(HWND ParentWindow) : Fcustomparameditor::TfmCustomParamEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TfmQueryListParamEditor* fmQueryListParamEditor;

}	/* namespace Fquerylistparameditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Fquerylistparameditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FquerylistparameditorHPP
