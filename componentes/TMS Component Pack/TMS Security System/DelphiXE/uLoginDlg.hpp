// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'uLoginDlg.pas' rev: 22.00

#ifndef UlogindlgHPP
#define UlogindlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <uSecControl.hpp>	// Pascal unit
#include <uLoginForm.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ulogindlg
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TuilLoginDlg;
class PASCALIMPLEMENTATION TuilLoginDlg : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	Uloginform::TuilLoginForm* FLoginForm;
	Useccontrol::TuilSecurityManager* FSecurityManager;
	bool FUseWindowsUserName;
	System::UnicodeString FTitleCaption;
	System::UnicodeString FUsernameCaption;
	System::UnicodeString FPasswordCaption;
	System::UnicodeString FLoginButtonCaption;
	System::UnicodeString FCancelButtonCaption;
	int FRetries;
	int FTryNumber;
	System::UnicodeString FUserName;
	Classes::TNotifyEvent FOnBeforeLoginAttempt;
	Classes::TNotifyEvent FOnAfterLoginAttempt;
	int __fastcall GetTriesRemaining(void);
	
protected:
	virtual System::UnicodeString __fastcall GetWindowsUserName(void);
	void __fastcall TriggerBeforeLoginAttempt(void);
	void __fastcall TriggerAfterLoginAttempt(void);
	System::UnicodeString __fastcall GetLoginUserName(void);
	void __fastcall SetLoginUserName(System::UnicodeString newValue);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual TuilLoginDlg(Classes::TComponent* AOwner);
	__fastcall virtual ~TuilLoginDlg(void);
	virtual bool __fastcall Execute(void);
	__property System::UnicodeString UserName = {read=GetLoginUserName, write=SetLoginUserName, stored=false};
	__property int TriesRemaining = {read=GetTriesRemaining, nodefault};
	__property int CurrentTry = {read=FTryNumber, nodefault};
	
__published:
	__property Useccontrol::TuilSecurityManager* SecurityManager = {read=FSecurityManager, write=FSecurityManager};
	__property bool UseWindowsUserName = {read=FUseWindowsUserName, write=FUseWindowsUserName, default=1};
	__property System::UnicodeString TitleCaption = {read=FTitleCaption, write=FTitleCaption};
	__property System::UnicodeString UsernameCaption = {read=FUsernameCaption, write=FUsernameCaption};
	__property System::UnicodeString PasswordCaption = {read=FPasswordCaption, write=FPasswordCaption};
	__property System::UnicodeString LoginButtonCaption = {read=FLoginButtonCaption, write=FLoginButtonCaption};
	__property System::UnicodeString CancelButtonCaption = {read=FCancelButtonCaption, write=FCancelButtonCaption};
	__property int Retries = {read=FRetries, write=FRetries, default=3};
	__property Classes::TNotifyEvent OnBeforeLoginAttempt = {read=FOnBeforeLoginAttempt, write=FOnBeforeLoginAttempt};
	__property Classes::TNotifyEvent OnAfterLoginAttempt = {read=FOnAfterLoginAttempt, write=FOnAfterLoginAttempt};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Ulogindlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Ulogindlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UlogindlgHPP
