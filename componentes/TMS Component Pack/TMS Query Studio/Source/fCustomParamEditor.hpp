// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'fCustomParamEditor.pas' rev: 22.00

#ifndef FcustomparameditorHPP
#define FcustomparameditorHPP

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
#include <atVisualQuery.hpp>	// Pascal unit
#include <atMetaSQL.hpp>	// Pascal unit
#include <fCustomEditor.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Fcustomparameditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfmCustomParamEditor;
class PASCALIMPLEMENTATION TfmCustomParamEditor : public Fcustomeditor::TfmCustomEditor
{
	typedef Fcustomeditor::TfmCustomEditor inherited;
	
__published:
	Extctrls::TPanel* pnCaption;
	Stdctrls::TLabel* Label5;
	Stdctrls::TEdit* edCaption;
	HIDESBASE void __fastcall btOkClick(System::TObject* Sender);
	
private:
	Atvisualquery::TatParamType FParamType;
	HIDESBASE void __fastcall Localize(void);
	
protected:
	virtual void __fastcall Loaded(void);
	void __fastcall DefaultCaptionFromParamName(Stdctrls::TComboBox* AParamName);
	bool __fastcall ValidateParamName(Stdctrls::TComboBox* combo);
	__property Atvisualquery::TatParamType ParamType = {read=FParamType, write=FParamType, nodefault};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfmCustomParamEditor(Classes::TComponent* AOwner) : Fcustomeditor::TfmCustomEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfmCustomParamEditor(Classes::TComponent* AOwner, int Dummy) : Fcustomeditor::TfmCustomEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfmCustomParamEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmCustomParamEditor(HWND ParentWindow) : Fcustomeditor::TfmCustomEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TfmCustomParamEditor* fmCustomParamEditor;

}	/* namespace Fcustomparameditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Fcustomparameditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FcustomparameditorHPP
