// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uchangepassworddlg.pas' rev: 21.00

#ifndef UchangepassworddlgHPP
#define UchangepassworddlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Useccontrol.hpp>	// Pascal unit
#include <Uchangepasswordform.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uchangepassworddlg
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TuilChangePasswordDlg;
class PASCALIMPLEMENTATION TuilChangePasswordDlg : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	Uchangepasswordform::TuilChangePasswordForm* FChangePasswordForm;
	Useccontrol::TuilSecurityManager* FSecurityManager;
	System::UnicodeString FTitleCaption;
	System::UnicodeString FCurrPasswordCaption;
	System::UnicodeString FNewPasswordCaption;
	System::UnicodeString FConfirmPasswordCaption;
	System::UnicodeString FOkButtonCaption;
	System::UnicodeString FCancelButtonCaption;
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual TuilChangePasswordDlg(Classes::TComponent* AOwner);
	__fastcall virtual ~TuilChangePasswordDlg(void);
	virtual bool __fastcall Execute(void);
	
__published:
	__property Useccontrol::TuilSecurityManager* SecurityManager = {read=FSecurityManager, write=FSecurityManager};
	__property System::UnicodeString TitleCaption = {read=FTitleCaption, write=FTitleCaption};
	__property System::UnicodeString CurrentPasswordCaption = {read=FCurrPasswordCaption, write=FCurrPasswordCaption};
	__property System::UnicodeString NewPasswordCaption = {read=FNewPasswordCaption, write=FNewPasswordCaption};
	__property System::UnicodeString ConfirmPasswordCaption = {read=FConfirmPasswordCaption, write=FConfirmPasswordCaption};
	__property System::UnicodeString OKButtonCaption = {read=FOkButtonCaption, write=FOkButtonCaption};
	__property System::UnicodeString CancelButtonCaption = {read=FCancelButtonCaption, write=FCancelButtonCaption};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uchangepassworddlg */
using namespace Uchangepassworddlg;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UchangepassworddlgHPP
