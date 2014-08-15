// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uloginform.pas' rev: 21.00

#ifndef UloginformHPP
#define UloginformHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uloginform
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TuilLoginForm;
class PASCALIMPLEMENTATION TuilLoginForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TLabel* labUsername;
	Stdctrls::TLabel* labPassword;
	Stdctrls::TEdit* txtUsername;
	Stdctrls::TButton* btnLogin;
	Stdctrls::TEdit* txtPassword;
	Stdctrls::TButton* btnCancel;
	Extctrls::TImage* Image1;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TuilLoginForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TuilLoginForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TuilLoginForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TuilLoginForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TuilLoginForm* uilLoginForm;

}	/* namespace Uloginform */
using namespace Uloginform;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UloginformHPP
