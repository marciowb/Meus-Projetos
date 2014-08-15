// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'uChangePasswordForm.pas' rev: 22.00

#ifndef UchangepasswordformHPP
#define UchangepasswordformHPP

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

//-- user supplied -----------------------------------------------------------

namespace Uchangepasswordform
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TuilChangePasswordForm;
class PASCALIMPLEMENTATION TuilChangePasswordForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TLabel* labCurrPwd;
	Stdctrls::TLabel* labNewPwd;
	Stdctrls::TEdit* txtCurrentPassword;
	Stdctrls::TButton* btnOK;
	Stdctrls::TEdit* txtNewPassword;
	Stdctrls::TButton* btnCancel;
	Extctrls::TImage* Image1;
	Stdctrls::TLabel* labConfirmPwd;
	Stdctrls::TEdit* txtConfirmPassword;
	void __fastcall txtNewPasswordChange(System::TObject* Sender);
	
public:
	System::UnicodeString CurPassword;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TuilChangePasswordForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TuilChangePasswordForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TuilChangePasswordForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TuilChangePasswordForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TuilChangePasswordForm* uilChangePasswordForm;

}	/* namespace Uchangepasswordform */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Uchangepasswordform;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UchangepasswordformHPP
