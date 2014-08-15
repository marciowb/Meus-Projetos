// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'fQueryEditor.pas' rev: 22.00

#ifndef FqueryeditorHPP
#define FqueryeditorHPP

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
#include <ExtCtrls.hpp>	// Pascal unit
#include <atVisualQuery.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Fqueryeditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfmQueryEditor;
class PASCALIMPLEMENTATION TfmQueryEditor : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Atvisualquery::TatVisualQuery* VisualQuery;
	Extctrls::TPanel* pnBottom;
	Stdctrls::TButton* Button1;
	Stdctrls::TButton* Button2;
	Extctrls::TBevel* Bevel1;
	void __fastcall VisualQueryResize(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	
private:
	void __fastcall Localize(void);
	
protected:
	virtual void __fastcall Loaded(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfmQueryEditor(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfmQueryEditor(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfmQueryEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfmQueryEditor(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TfmQueryEditor* fmQueryEditor;

}	/* namespace Fqueryeditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Fqueryeditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FqueryeditorHPP
