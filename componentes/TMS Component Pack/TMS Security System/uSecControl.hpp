// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Useccontrol.pas' rev: 21.00

#ifndef UseccontrolHPP
#define UseccontrolHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Ubindary.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Useccontrol
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TuilDisabledLoginEvent)(System::TObject* Sender, System::UnicodeString UserName);

typedef void __fastcall (__closure *TuilFailedLoginDetailEvent)(System::TObject* Sender, System::UnicodeString UserName, System::UnicodeString Password);

class DELPHICLASS TuilSecurityManager;
class PASCALIMPLEMENTATION TuilSecurityManager : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	Classes::TStrings* FCurrentPermissions;
	System::UnicodeString FCurrentUser;
	System::UnicodeString FCurrentPassword;
	Classes::TList* FPolicies;
	Ubindary::TuilUserBindary* FUserBindary;
	Ubindary::TuilGroupBindary* FGroupBindary;
	Ubindary::TuilPermissionBindary* FPermissionBindary;
	bool FLoggedIn;
	bool FActive;
	Classes::TNotifyEvent FOnBeforeLogin;
	Classes::TNotifyEvent FOnSuccessfulLogin;
	Classes::TNotifyEvent FOnFailedLogin;
	TuilFailedLoginDetailEvent FOnFailedLoginDetail;
	TuilDisabledLoginEvent FOnDisabledLogin;
	int FTryNumber;
	int FTriesRemaining;
	Ubindary::TuilEncryptEvent __fastcall GetOnEncrypt(void);
	void __fastcall SetOnEncrypt(const Ubindary::TuilEncryptEvent Value);
	
protected:
	virtual void __fastcall SetVersion(System::UnicodeString NewValue);
	virtual System::UnicodeString __fastcall GetVersion(void);
	virtual void __fastcall GetPermissions(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall TriggerBeforeLoginEvent(void);
	virtual void __fastcall TriggerSuccessfulLoginEvent(void);
	virtual void __fastcall TriggerFailedLoginEvent(System::UnicodeString UserName, System::UnicodeString Password);
	virtual void __fastcall TriggerDisabledLoginEvent(System::UnicodeString UserName);
	__property int TriesRemaining = {read=FTriesRemaining, write=FTriesRemaining, nodefault};
	__property int CurrentTry = {read=FTryNumber, write=FTryNumber, nodefault};
	
public:
	__fastcall virtual TuilSecurityManager(Classes::TComponent* AOwner);
	__fastcall virtual ~TuilSecurityManager(void);
	virtual void __fastcall Attach(Classes::TComponent* Sender);
	virtual void __fastcall Detach(Classes::TComponent* Sender);
	bool __fastcall Login(System::UnicodeString Username, System::UnicodeString Password);
	void __fastcall Logout(void);
	__property bool LoggedIn = {read=FLoggedIn, nodefault};
	void __fastcall ModifyPassword(System::UnicodeString NewPassword);
	virtual bool __fastcall HasPermission(System::UnicodeString Permission);
	__property System::UnicodeString CurrentUser = {read=FCurrentUser};
	__property System::UnicodeString CurrentPassword = {read=FCurrentPassword};
	__property int LoginTriesRemaining = {read=FTriesRemaining, nodefault};
	__property int LoginTryNumber = {read=FTryNumber, nodefault};
	
__published:
	__property bool Active = {read=FActive, write=FActive, default=1};
	__property Ubindary::TuilUserBindary* UserBindary = {read=FUserBindary, write=FUserBindary};
	__property Ubindary::TuilGroupBindary* GroupBindary = {read=FGroupBindary, write=FGroupBindary};
	__property Ubindary::TuilPermissionBindary* PermissionBindary = {read=FPermissionBindary, write=FPermissionBindary};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property Ubindary::TuilEncryptEvent OnEncrypt = {read=GetOnEncrypt, write=SetOnEncrypt};
	__property Classes::TNotifyEvent OnBeforeLogin = {read=FOnBeforeLogin, write=FOnBeforeLogin};
	__property Classes::TNotifyEvent OnFailedLogin = {read=FOnFailedLogin, write=FOnFailedLogin};
	__property TuilFailedLoginDetailEvent OnFailedLoginDetail = {read=FOnFailedLoginDetail, write=FOnFailedLoginDetail};
	__property Classes::TNotifyEvent OnSuccessfulLogin = {read=FOnSuccessfulLogin, write=FOnSuccessfulLogin};
	__property TuilDisabledLoginEvent OnDisabledLogin = {read=FOnDisabledLogin, write=FOnDisabledLogin};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Useccontrol */
using namespace Useccontrol;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UseccontrolHPP
