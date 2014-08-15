// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Wclogin.pas' rev: 21.00

#ifndef WcloginHPP
#define WcloginHPP

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

namespace Wclogin
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TWcLoginForm;
class PASCALIMPLEMENTATION TWcLoginForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TLabel* Label1;
	Stdctrls::TLabel* Label2;
	Extctrls::TImage* Image1;
	Stdctrls::TEdit* Edit1;
	Stdctrls::TEdit* Edit2;
	Stdctrls::TButton* Button1;
	Stdctrls::TButton* Button2;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TWcLoginForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TWcLoginForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TWcLoginForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TWcLoginForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TWcLoginForm* WcLoginForm;
extern PACKAGE bool __fastcall GetLogin(System::UnicodeString Prompt, System::UnicodeString &UserName, System::UnicodeString &Password);

}	/* namespace Wclogin */
using namespace Wclogin;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// WcloginHPP
