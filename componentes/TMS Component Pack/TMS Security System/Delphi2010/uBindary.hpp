// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Ubindary.pas' rev: 21.00

#ifndef UbindaryHPP
#define UbindaryHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Ubindary
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TuilEncryptEvent)(System::TObject* Sender, System::UnicodeString PlainText, System::UnicodeString &EncryptedText);

class DELPHICLASS TuilBindary;
class PASCALIMPLEMENTATION TuilBindary : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Db::TDataSource* FDataSource;
	System::UnicodeString FKeyField;
	System::UnicodeString FPassword;
	Classes::TComponent* FSecurityManager;
	TuilEncryptEvent FOnEncrypt;
	
protected:
	void __fastcall SetDataSource(Db::TDataSource* newValue);
	__property Classes::TComponent* SecurityManager = {read=FSecurityManager, write=FSecurityManager};
	
public:
	__fastcall virtual TuilBindary(Classes::TComponent* ASecurityManager);
	__fastcall virtual ~TuilBindary(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual Db::TField* __fastcall FieldByName(System::UnicodeString FieldName);
	virtual bool __fastcall Locate(const System::Variant &KeyValues);
	virtual System::UnicodeString __fastcall Encrypt(const System::UnicodeString S);
	__property System::UnicodeString KeyField = {read=FKeyField, write=FKeyField};
	
__published:
	__property Db::TDataSource* DataSource = {read=FDataSource, write=SetDataSource};
	__property System::UnicodeString Password = {read=FPassword, write=FPassword};
	__property TuilEncryptEvent OnEncrypt = {read=FOnEncrypt, write=FOnEncrypt};
};


class DELPHICLASS TuilAccessBindary;
class PASCALIMPLEMENTATION TuilAccessBindary : public TuilBindary
{
	typedef TuilBindary inherited;
	
protected:
	System::UnicodeString __fastcall GetPermissionField(void);
	void __fastcall SetPermissionField(System::UnicodeString newValue);
	
public:
	__fastcall virtual TuilAccessBindary(Classes::TComponent* ASecurityManager);
	virtual bool __fastcall HasAccess(System::UnicodeString Permission);
	virtual bool __fastcall AddAccess(System::UnicodeString Permission);
	virtual bool __fastcall RemoveAccess(System::UnicodeString Permission);
	
__published:
	__property System::UnicodeString PermissionField = {read=GetPermissionField, write=SetPermissionField};
public:
	/* TuilBindary.Destroy */ inline __fastcall virtual ~TuilAccessBindary(void) { }
	
};


#pragma option push -b-
enum TuilPermissionStorage { psForm, psTable };
#pragma option pop

class DELPHICLASS TuilPermissionBindary;
class PASCALIMPLEMENTATION TuilPermissionBindary : public TuilAccessBindary
{
	typedef TuilAccessBindary inherited;
	
private:
	System::UnicodeString FItemField;
	System::UnicodeString FActionField;
	TuilPermissionStorage FStorage;
	System::UnicodeString FFormName;
	System::UnicodeString FFormNameField;
	
public:
	virtual bool __fastcall HasAccess(System::UnicodeString Permission);
	virtual bool __fastcall AddPermission(System::UnicodeString Permission, System::UnicodeString Items, System::UnicodeString FormName, int Action);
	virtual bool __fastcall UpdatePermission(System::UnicodeString Permission, System::UnicodeString Items, System::UnicodeString FormName, int Action);
	__property System::UnicodeString FormName = {read=FFormName, write=FFormName};
	
__published:
	__property System::UnicodeString ActionField = {read=FActionField, write=FActionField};
	__property System::UnicodeString ItemField = {read=FItemField, write=FItemField};
	__property System::UnicodeString FormNameField = {read=FFormNameField, write=FFormNameField};
	__property TuilPermissionStorage Storage = {read=FStorage, write=FStorage, nodefault};
public:
	/* TuilAccessBindary.Create */ inline __fastcall virtual TuilPermissionBindary(Classes::TComponent* ASecurityManager) : TuilAccessBindary(ASecurityManager) { }
	
public:
	/* TuilBindary.Destroy */ inline __fastcall virtual ~TuilPermissionBindary(void) { }
	
};


class DELPHICLASS TuilUserAccessBindary;
class PASCALIMPLEMENTATION TuilUserAccessBindary : public TuilAccessBindary
{
	typedef TuilAccessBindary inherited;
	
private:
	System::UnicodeString FUserNameField;
	
public:
	__fastcall virtual TuilUserAccessBindary(Classes::TComponent* ASecurityManager);
	virtual bool __fastcall AddAccess(System::UnicodeString Permission);
	virtual bool __fastcall AddUserAccess(System::UnicodeString UserName, System::UnicodeString Permission);
	virtual bool __fastcall RemoveUserAccess(System::UnicodeString UserName, System::UnicodeString Permission);
	virtual bool __fastcall HasUserAccess(System::UnicodeString UserName, System::UnicodeString Permission);
	
__published:
	__property System::UnicodeString UserNameField = {read=FUserNameField, write=FUserNameField};
public:
	/* TuilBindary.Destroy */ inline __fastcall virtual ~TuilUserAccessBindary(void) { }
	
};


class DELPHICLASS TuilGroupAccessBindary;
class PASCALIMPLEMENTATION TuilGroupAccessBindary : public TuilAccessBindary
{
	typedef TuilAccessBindary inherited;
	
private:
	System::UnicodeString FGroupNameField;
	
public:
	__fastcall virtual TuilGroupAccessBindary(Classes::TComponent* ASecurityManager);
	virtual bool __fastcall AddAccess(System::UnicodeString Permission);
	virtual bool __fastcall AddGroupAccess(System::UnicodeString Group, System::UnicodeString Permission);
	virtual bool __fastcall RemoveGroupAccess(System::UnicodeString Group, System::UnicodeString Permission);
	virtual bool __fastcall HasGroupAccess(System::UnicodeString Group, System::UnicodeString Permission);
	
__published:
	__property System::UnicodeString GroupNameField = {read=FGroupNameField, write=FGroupNameField};
public:
	/* TuilBindary.Destroy */ inline __fastcall virtual ~TuilGroupAccessBindary(void) { }
	
};


class DELPHICLASS TuilGroupMembershipBindary;
class PASCALIMPLEMENTATION TuilGroupMembershipBindary : public TuilBindary
{
	typedef TuilBindary inherited;
	
private:
	System::UnicodeString FUserNameField;
	
protected:
	System::UnicodeString __fastcall GetGroupNameField(void);
	void __fastcall SetGroupNameField(System::UnicodeString newValue);
	
public:
	__fastcall virtual TuilGroupMembershipBindary(Classes::TComponent* ASecurityManager);
	virtual bool __fastcall Locate(const System::Variant &KeyValues);
	virtual bool __fastcall AddUserToGroup(System::UnicodeString Username, System::UnicodeString GroupName);
	virtual bool __fastcall RemoveUserFromGroup(System::UnicodeString Username, System::UnicodeString GroupName);
	
__published:
	__property System::UnicodeString GroupNameField = {read=GetGroupNameField, write=SetGroupNameField};
	__property System::UnicodeString UserNameField = {read=FUserNameField, write=FUserNameField};
public:
	/* TuilBindary.Destroy */ inline __fastcall virtual ~TuilGroupMembershipBindary(void) { }
	
};


class DELPHICLASS TuilUserBindary;
class PASCALIMPLEMENTATION TuilUserBindary : public TuilBindary
{
	typedef TuilBindary inherited;
	
private:
	bool FCaseSensUsername;
	bool FCaseSensPassword;
	System::UnicodeString FFullNameField;
	System::UnicodeString FPasswordField;
	System::UnicodeString FAccessCountField;
	System::UnicodeString FCreatedDateField;
	System::UnicodeString FCreatedTimeField;
	System::UnicodeString FEnabledField;
	System::UnicodeString FLastAccessField;
	System::UnicodeString FLastAccessTimeField;
	TuilUserAccessBindary* FUserPermissions;
	
protected:
	System::UnicodeString __fastcall GetUserNameField(void);
	void __fastcall SetUserNameField(System::UnicodeString newValue);
	
public:
	virtual void __fastcall AddUser(void);
	virtual void __fastcall UpdateLogin(void);
	__fastcall virtual TuilUserBindary(Classes::TComponent* ASecurityManager);
	__fastcall virtual ~TuilUserBindary(void);
	void __fastcall ChangePassword(System::UnicodeString NewPassword);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual bool __fastcall Locate(const System::Variant &KeyValues);
	
__published:
	__property bool CaseSensitiveUsername = {read=FCaseSensUsername, write=FCaseSensUsername, default=0};
	__property bool CaseSensitivePassword = {read=FCaseSensPassword, write=FCaseSensPassword, default=1};
	__property System::UnicodeString UserNameField = {read=GetUserNameField, write=SetUserNameField};
	__property System::UnicodeString FullNameField = {read=FFullNameField, write=FFullNameField};
	__property System::UnicodeString PasswordField = {read=FPasswordField, write=FPasswordField};
	__property System::UnicodeString AccessCountField = {read=FAccessCountField, write=FAccessCountField};
	__property System::UnicodeString CreatedDateField = {read=FCreatedDateField, write=FCreatedDateField};
	__property System::UnicodeString CreatedTimeField = {read=FCreatedTimeField, write=FCreatedTimeField};
	__property System::UnicodeString EnabledField = {read=FEnabledField, write=FEnabledField};
	__property System::UnicodeString LastAccessField = {read=FLastAccessField, write=FLastAccessField};
	__property System::UnicodeString LastAccessTimeField = {read=FLastAccessTimeField, write=FLastAccessTimeField};
	__property TuilUserAccessBindary* UserPermissions = {read=FUserPermissions, write=FUserPermissions};
};


class DELPHICLASS TuilGroupBindary;
class PASCALIMPLEMENTATION TuilGroupBindary : public TuilBindary
{
	typedef TuilBindary inherited;
	
private:
	System::UnicodeString FGroupDescriptionField;
	TuilGroupAccessBindary* FGroupPermissions;
	TuilGroupMembershipBindary* FGroupMemBindary;
	
protected:
	System::UnicodeString __fastcall GetGroupNameField(void);
	void __fastcall SetGroupNameField(System::UnicodeString newValue);
	
public:
	__fastcall virtual TuilGroupBindary(Classes::TComponent* ASecurityManager);
	__fastcall virtual ~TuilGroupBindary(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
__published:
	__property System::UnicodeString GroupNameField = {read=GetGroupNameField, write=SetGroupNameField};
	__property System::UnicodeString GroupDescriptionField = {read=FGroupDescriptionField, write=FGroupDescriptionField};
	__property TuilGroupAccessBindary* GroupPermissions = {read=FGroupPermissions, write=FGroupPermissions};
	__property TuilGroupMembershipBindary* GroupMembershipBindary = {read=FGroupMemBindary, write=FGroupMemBindary};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Ubindary */
using namespace Ubindary;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UbindaryHPP
