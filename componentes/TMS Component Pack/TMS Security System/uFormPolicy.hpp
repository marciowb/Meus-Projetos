// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uformpolicy.pas' rev: 21.00

#ifndef UformpolicyHPP
#define UformpolicyHPP

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
#include <Typinfo.hpp>	// Pascal unit
#include <Useccontrol.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Ubindary.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uformpolicy
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TPolicyAction { paDisable, paHide, paCustom, paReadOnly };
#pragma option pop

typedef void __fastcall (__closure *TCustomSecureEvent)(System::TObject* Sender, Classes::TComponent* AComponent, bool Secure);

class DELPHICLASS TuilFormPolicy;
class DELPHICLASS TuilPolicy;
class PASCALIMPLEMENTATION TuilFormPolicy : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	TuilPolicy* FPolicies;
	Useccontrol::TuilSecurityManager* FSecurityManager;
	TCustomSecureEvent FOnCustomSecure;
	bool FActive;
	
protected:
	Useccontrol::TuilSecurityManager* __fastcall GetSecurityManager(void);
	void __fastcall SetSecurityManager(Useccontrol::TuilSecurityManager* newValue);
	virtual System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(System::UnicodeString NewValue);
	virtual TuilPolicy* __fastcall GetPolicies(void);
	void __fastcall SetPolicies(TuilPolicy* NewValue);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation operation);
	virtual void __fastcall CustomSecure(Classes::TComponent* AComponent, bool Secure);
	
public:
	__fastcall virtual TuilFormPolicy(Classes::TComponent* AOwner);
	__fastcall virtual ~TuilFormPolicy(void);
	virtual void __fastcall Apply(void);
	virtual void __fastcall LoadFromDataBase(System::UnicodeString AFormName);
	virtual void __fastcall RemoveFromDataBase(System::UnicodeString AFormName, System::UnicodeString APermission);
	
__published:
	__property bool Active = {read=FActive, write=FActive, default=1};
	__property TuilPolicy* Policies = {read=GetPolicies, write=SetPolicies};
	__property Useccontrol::TuilSecurityManager* SecurityManager = {read=GetSecurityManager, write=SetSecurityManager};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property TCustomSecureEvent OnCustomSecure = {read=FOnCustomSecure, write=FOnCustomSecure};
};


class DELPHICLASS TuilPolicyItem;
class PASCALIMPLEMENTATION TuilPolicy : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
private:
	TuilFormPolicy* FFormPolicy;
	HIDESBASE TuilPolicyItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TuilPolicyItem* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TuilPolicy(TuilFormPolicy* FormPolicy);
	__fastcall virtual ~TuilPolicy(void);
	__property TuilFormPolicy* FormPolicy = {read=FFormPolicy, write=FFormPolicy};
	HIDESBASE TuilPolicyItem* __fastcall Add(void);
	HIDESBASE TuilPolicyItem* __fastcall Insert(int Index);
	__property TuilPolicyItem* Items[int Index] = {read=GetItem, write=SetItem};
};


class PASCALIMPLEMENTATION TuilPolicyItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Classes::TStrings* FItems;
	System::UnicodeString FPolicyName;
	TPolicyAction FPolicyAction;
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	virtual System::UnicodeString __fastcall GetName(void);
	virtual void __fastcall SetName(System::UnicodeString newValue);
	void __fastcall SetItems(const Classes::TStrings* Value);
	virtual void __fastcall SecureItems(bool Value);
	void __fastcall RemoveItem(System::UnicodeString AItem);
	
public:
	void __fastcall Activate(void);
	void __fastcall Deactivate(void);
	
__published:
	__fastcall virtual TuilPolicyItem(Classes::TCollection* Collection);
	__fastcall virtual ~TuilPolicyItem(void);
	__property Classes::TStrings* Items = {read=FItems, write=SetItems};
	__property System::UnicodeString PolicyName = {read=GetName, write=SetName};
	__property TPolicyAction PolicyAction = {read=FPolicyAction, write=FPolicyAction, nodefault};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uformpolicy */
using namespace Uformpolicy;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UformpolicyHPP
