// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'uFormPolicyDlg.pas' rev: 22.00

#ifndef UformpolicydlgHPP
#define UformpolicydlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <uFormPolicy.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <ImgList.hpp>	// Pascal unit
#include <uFormPolicyDesigner.hpp>	// Pascal unit
#include <uSecControl.hpp>	// Pascal unit
#include <uSecDlgForm.hpp>	// Pascal unit
#include <TypInfo.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uformpolicydlg
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TControlItem;
class PASCALIMPLEMENTATION TControlItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Classes::TComponent* FComponent;
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	__fastcall virtual TControlItem(Classes::TCollection* Collection);
	__fastcall virtual ~TControlItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Classes::TComponent* Component = {read=FComponent, write=FComponent};
};


class DELPHICLASS TControlCollection;
class PASCALIMPLEMENTATION TControlCollection : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TControlItem* operator[](int Index) { return Items[Index]; }
	
private:
	Classes::TComponent* FOwner;
	HIDESBASE TControlItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TControlItem* Value);
	
public:
	__fastcall TControlCollection(Classes::TComponent* AOwner);
	HIDESBASE TControlItem* __fastcall Add(void);
	HIDESBASE TControlItem* __fastcall Insert(int index);
	__property TControlItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	bool __fastcall IsIgnored(Classes::TComponent* Component);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TControlCollection(void) { }
	
};


typedef void __fastcall (__closure *TuilFilterComponentEvent)(System::TObject* Sender, Classes::TComponent* AComponent, bool &Allow);

class DELPHICLASS TuilFormPolicyDlg;
class PASCALIMPLEMENTATION TuilFormPolicyDlg : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	bool FSaveToRegistry;
	int FWidth;
	int FPanelWidth;
	int FHeight;
	System::UnicodeString FRegistryKey;
	Uformpolicy::TuilFormPolicy* FUilFormPolicy;
	TControlCollection* FIgnoreList;
	System::UnicodeString FFormName;
	TuilFilterComponentEvent FUilFilterComponent;
	
protected:
	DYNAMIC void __fastcall SaveComponentOptionsToRegistry(void);
	DYNAMIC void __fastcall LoadComponentOptionsFromRegistry(void);
	void __fastcall AddToList(Uformpolicydesigner::TfrmFormPolicy* AForm, System::UnicodeString CompName, System::UnicodeString ClassName);
	void __fastcall AddComponents(Forms::TForm* EditForm, Uformpolicydesigner::TfrmFormPolicy* AForm);
	void __fastcall AddPolicies(Forms::TForm* EditForm, Uformpolicydesigner::TfrmFormPolicy* AForm, Uformpolicy::TuilPolicy* APolicy);
	void __fastcall SavePolicies(Uformpolicydesigner::TfrmFormPolicy* AForm, Uformpolicy::TuilPolicy* Policies);
	int __fastcall GetClassImage(System::UnicodeString AClassName);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TuilFormPolicyDlg(Classes::TComponent* AOwner);
	__fastcall virtual ~TuilFormPolicyDlg(void);
	bool __fastcall Execute(void);
	
__published:
	__property Uformpolicy::TuilFormPolicy* FormPolicy = {read=FUilFormPolicy, write=FUilFormPolicy};
	__property System::UnicodeString FormName = {read=FFormName, write=FFormName};
	__property TControlCollection* IgnoreList = {read=FIgnoreList, write=FIgnoreList};
	__property System::UnicodeString RegistryKey = {read=FRegistryKey, write=FRegistryKey};
	__property bool SaveToRegistry = {read=FSaveToRegistry, write=FSaveToRegistry, nodefault};
	__property TuilFilterComponentEvent OnFilterComponent = {read=FUilFilterComponent, write=FUilFilterComponent};
};


//-- var, const, procedure ---------------------------------------------------
#define REG_SettingsSectionName L"Policy Dialog"

}	/* namespace Uformpolicydlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Uformpolicydlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UformpolicydlgHPP
