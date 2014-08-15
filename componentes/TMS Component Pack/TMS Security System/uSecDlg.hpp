// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Usecdlg.pas' rev: 21.00

#ifndef UsecdlgHPP
#define UsecdlgHPP

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
#include <Useccontrol.hpp>	// Pascal unit
#include <Usecdlgform.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Usecdlg
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TuilSecurityDlg;
class PASCALIMPLEMENTATION TuilSecurityDlg : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	bool FSaveToRegistry;
	int FWidth;
	int FHeight;
	int FPanelWidth;
	System::UnicodeString FRegistryKey;
	Useccontrol::TuilSecurityManager* FSecurityManager;
	System::UnicodeString FFormCaption;
	System::UnicodeString FUsersCaption;
	System::UnicodeString FGroupsCaption;
	System::UnicodeString FMembershipCaption;
	bool FShowGroups;
	Usecdlgform::TuilUserEvent FOnUserAdded;
	Usecdlgform::TuilUserEvent FOnUserDeleted;
	Usecdlgform::TuilUserEvent FOnUserEdited;
	Usecdlgform::TuilGroupEvent FOnGroupAdded;
	Usecdlgform::TuilGroupEvent FOnGroupDeleted;
	Usecdlgform::TuilGroupEvent FOnGroupEdited;
	bool FCanAddUser;
	bool FCanDeleteUser;
	bool FCanEditUser;
	bool FCanAddGroup;
	bool FCanEditGroup;
	bool FCanDeleteGroup;
	void __fastcall SetSecurityManager(Useccontrol::TuilSecurityManager* newValue);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation operation);
	DYNAMIC void __fastcall SaveComponentOptionsToRegistry(void);
	DYNAMIC void __fastcall LoadComponentOptionsFromRegistry(void);
	virtual void __fastcall Loaded(void);
	void __fastcall TriggerUserAdded(System::TObject* Sender, System::UnicodeString UserName);
	void __fastcall TriggerUserDeleted(System::TObject* Sender, System::UnicodeString UserName);
	void __fastcall TriggerUserEdited(System::TObject* Sender, System::UnicodeString UserName);
	void __fastcall TriggerGroupAdded(System::TObject* Sender, System::UnicodeString GroupName);
	void __fastcall TriggerGroupDeleted(System::TObject* Sender, System::UnicodeString GroupName);
	void __fastcall TriggerGroupEdited(System::TObject* Sender, System::UnicodeString GroupName);
	
public:
	__fastcall virtual TuilSecurityDlg(Classes::TComponent* AOwner);
	__fastcall virtual ~TuilSecurityDlg(void);
	bool __fastcall Execute(void);
	
__published:
	__property bool CanAddUser = {read=FCanAddUser, write=FCanAddUser, default=1};
	__property bool CanDeleteUser = {read=FCanDeleteUser, write=FCanDeleteUser, default=1};
	__property bool CanEditUser = {read=FCanEditUser, write=FCanEditUser, default=1};
	__property bool CanAddGroup = {read=FCanAddGroup, write=FCanAddGroup, default=1};
	__property bool CanDeleteGroup = {read=FCanDeleteGroup, write=FCanDeleteGroup, default=1};
	__property bool CanEditGroup = {read=FCanEditGroup, write=FCanEditGroup, default=1};
	__property System::UnicodeString FormCaption = {read=FFormCaption, write=FFormCaption};
	__property System::UnicodeString UsersCaption = {read=FUsersCaption, write=FUsersCaption};
	__property System::UnicodeString GroupsCaption = {read=FGroupsCaption, write=FGroupsCaption};
	__property System::UnicodeString MembershipCaption = {read=FMembershipCaption, write=FMembershipCaption};
	__property bool ShowGroups = {read=FShowGroups, write=FShowGroups, default=1};
	__property Useccontrol::TuilSecurityManager* SecurityManager = {read=FSecurityManager, write=SetSecurityManager};
	__property System::UnicodeString RegistryKey = {read=FRegistryKey, write=FRegistryKey};
	__property bool SaveToRegistry = {read=FSaveToRegistry, write=FSaveToRegistry, nodefault};
	__property Usecdlgform::TuilUserEvent OnUserAdded = {read=FOnUserAdded, write=FOnUserAdded};
	__property Usecdlgform::TuilUserEvent OnUserDeleted = {read=FOnUserDeleted, write=FOnUserDeleted};
	__property Usecdlgform::TuilUserEvent OnUserEdited = {read=FOnUserEdited, write=FOnUserEdited};
	__property Usecdlgform::TuilGroupEvent OnGroupAdded = {read=FOnGroupAdded, write=FOnGroupAdded};
	__property Usecdlgform::TuilGroupEvent OnGroupDeleted = {read=FOnGroupDeleted, write=FOnGroupDeleted};
	__property Usecdlgform::TuilGroupEvent OnGroupEdited = {read=FOnGroupEdited, write=FOnGroupEdited};
};


//-- var, const, procedure ---------------------------------------------------
#define REG_SettingsSectionName L"Security Dialog"

}	/* namespace Usecdlg */
using namespace Usecdlg;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UsecdlgHPP
