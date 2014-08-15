// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'PropertyList.pas' rev: 22.00

#ifndef PropertylistHPP
#define PropertylistHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <TypInfo.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <DBTables.hpp>	// Pascal unit
#include <ADODB.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Propertylist
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS EPropertyException;
class PASCALIMPLEMENTATION EPropertyException : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EPropertyException(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EPropertyException(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EPropertyException(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EPropertyException(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EPropertyException(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EPropertyException(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EPropertyException(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EPropertyException(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EPropertyException(void) { }
	
};


class DELPHICLASS TProperty;
typedef System::UnicodeString __fastcall (*TGetPropertyValue)(Classes::TPersistent* AInstance, TProperty* Prop);

typedef void __fastcall (*TSetPropertyValue)(Classes::TPersistent* AInstance, TProperty* Prop, System::UnicodeString Value);

class DELPHICLASS TCustomPropData;
class PASCALIMPLEMENTATION TCustomPropData : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::TClass InstanceType;
	System::UnicodeString PropName;
	Typinfo::TTypeInfo *PropType;
	bool Descendants;
	TGetPropertyValue GetProc;
	TSetPropertyValue SetProc;
	__fastcall TCustomPropData(System::TClass AInstanceType, System::UnicodeString APropName, Typinfo::PTypeInfo APropType, bool ADescendants, TGetPropertyValue AGetProc, TSetPropertyValue ASetProc);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TCustomPropData(void) { }
	
};


class DELPHICLASS TPropertyList;
class PASCALIMPLEMENTATION TProperty : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TPropertyList* FOwner;
	Classes::TComponent* FRoot;
	Classes::TPersistent* FInstance;
	Typinfo::TPropInfo *FPropInfo;
	Typinfo::TTypeData *FTypeData;
	TPropertyList* FProperties;
	TCustomPropData* FPropData;
	bool __fastcall GetEmulated(void);
	bool __fastcall GetCustom(void);
	TProperty* __fastcall GetOwnerProperty(void);
	int __fastcall GetLevel(void);
	Typinfo::PTypeInfo __fastcall GetPropType(void);
	void * __fastcall GetGetProc(void);
	void * __fastcall GetSetProc(void);
	bool __fastcall GetIsStored(void);
	short __fastcall GetIndex(void);
	int __fastcall GetDefault(void);
	short __fastcall GetNameIndex(void);
	System::UnicodeString __fastcall GetName(void);
	System::UnicodeString __fastcall GetFullName(void);
	System::UnicodeString __fastcall GetTypeName(void);
	Typinfo::TTypeKind __fastcall GetTypeKind(void);
	Typinfo::TOrdType __fastcall GetOrdType(void);
	int __fastcall GetMinValue(void);
	int __fastcall GetMaxValue(void);
	Typinfo::PTypeInfo __fastcall GetCompType(void);
	Typinfo::PTypeInfo __fastcall GetBaseType(void);
	int __fastcall GetEnumCount(void);
	System::UnicodeString __fastcall GetEName(int Value);
	int __fastcall GetEValue(System::UnicodeString Value);
	Typinfo::TFloatType __fastcall GetFloatType(void);
	System::Byte __fastcall GetMaxLength(void);
	System::TClass __fastcall GetClassType(void);
	Typinfo::PTypeInfo __fastcall GetParentInfo(void);
	System::UnicodeString __fastcall GetUnitName(void);
	Typinfo::TMethodKind __fastcall GetMethodKind(void);
	int __fastcall GetParamCount(void);
	Typinfo::TParamFlags __fastcall GetParamFlags(int Index);
	System::UnicodeString __fastcall GetParamName(int Index);
	System::UnicodeString __fastcall GetParamType(int Index);
	System::UnicodeString __fastcall GetParameter(int Index);
	System::UnicodeString __fastcall GetResultType(void);
	System::UnicodeString __fastcall GetMethodDeclaration(void);
	Typinfo::PTypeInfo __fastcall GetIntfParent(void);
	Typinfo::TIntfFlags __fastcall GetIntfFlags(void);
	GUID __fastcall GetGUID(void);
	System::UnicodeString __fastcall GetIntfUnit(void);
	__int64 __fastcall GetMinInt64Value(void);
	__int64 __fastcall GetMaxInt64Value(void);
	System::Extended __fastcall GetAsFloat(void);
	void __fastcall SetAsFloat(const System::Extended Value);
	System::TMethod __fastcall GetAsMethod(void);
	void __fastcall SetAsMethod(const System::TMethod &Value);
	int __fastcall GetAsInteger(void);
	void __fastcall SetAsInteger(const int Value);
	System::WideChar __fastcall GetAsChar(void);
	void __fastcall SetAsChar(const System::WideChar Value);
	bool __fastcall GetAsBoolean(void);
	void __fastcall SetAsBoolean(const bool Value);
	System::TObject* __fastcall GetAsObject(void);
	void __fastcall SetAsObject(const System::TObject* Value);
	System::TDateTime __fastcall GetAsDateTime(void);
	void __fastcall SetAsDateTime(const System::TDateTime Value);
	System::TDate __fastcall GetAsDate(void);
	void __fastcall SetAsDate(const System::TDate Value);
	System::TTime __fastcall GetAsTime(void);
	void __fastcall SetAsTime(const System::TTime Value);
	System::WideString __fastcall GetAsString(void);
	void __fastcall SetAsString(const System::WideString Value);
	System::Variant __fastcall GetAsVariant(void);
	void __fastcall SetAsVariant(const System::Variant &Value);
	System::_di_IInterface __fastcall GetAsInterface(void);
	void __fastcall SetAsInterface(const System::_di_IInterface Value);
	System::UnicodeString __fastcall IntSetToStr(int Value);
	int __fastcall StrToIntSet(System::UnicodeString Value);
	System::UnicodeString __fastcall ObjectToStr(System::TObject* Value);
	System::TObject* __fastcall StrToObject(System::UnicodeString Value);
	System::WideChar __fastcall GetAsWChar(void);
	void __fastcall SetAsWChar(const System::WideChar Value);
	void __fastcall EnumFieldNames(Classes::TStrings* AValues);
	void __fastcall EnumTableNames(Classes::TStrings* AValues);
	void __fastcall EnumDatabaseNames(Classes::TStrings* AValues);
	
public:
	__fastcall virtual TProperty(TPropertyList* AOwner, Classes::TComponent* ARoot, Classes::TComponent* AInstance, Typinfo::PPropInfo APropInfo, TCustomPropData* APropData);
	__fastcall virtual ~TProperty(void);
	void __fastcall SetEmulatedOn(void);
	void __fastcall SetEmulatedOff(void);
	void __fastcall Assign(TProperty* Source);
	virtual TPropertyList* __fastcall CreatePropertyList(void);
	virtual System::UnicodeString __fastcall DisplayValue(void);
	virtual System::WideString __fastcall GetStringValue(void);
	virtual void __fastcall SetStringValue(const System::WideString Value);
	virtual void __fastcall ValuesList(const Classes::TStrings* AValues);
	bool __fastcall IsCompatibleObject(System::TObject* AObject);
	bool __fastcall IsCompatibleType(Typinfo::PTypeInfo ATypeInfo);
	bool __fastcall IsType(Typinfo::PTypeInfo ATypeInfo);
	bool __fastcall IsCompatible(TProperty* P);
	__property bool Emulated = {read=GetEmulated, nodefault};
	__property bool Custom = {read=GetCustom, nodefault};
	__property TPropertyList* Owner = {read=FOwner};
	__property TProperty* OwnerProperty = {read=GetOwnerProperty};
	__property int Level = {read=GetLevel, nodefault};
	__property Classes::TComponent* Root = {read=FRoot, write=FRoot};
	__property Classes::TPersistent* Instance = {read=FInstance, write=FInstance};
	__property Typinfo::PTypeData TypeData = {read=FTypeData};
	__property Typinfo::PTypeInfo PropType = {read=GetPropType};
	__property void * GetProc = {read=GetGetProc};
	__property void * SetProc = {read=GetSetProc};
	__property bool IsStored = {read=GetIsStored, nodefault};
	__property short Index = {read=GetIndex, nodefault};
	__property int Default = {read=GetDefault, nodefault};
	__property short NameIndex = {read=GetNameIndex, nodefault};
	__property System::UnicodeString Name = {read=GetName};
	__property System::UnicodeString FullName = {read=GetFullName};
	__property System::UnicodeString TypeName = {read=GetTypeName};
	__property Typinfo::TTypeKind TypeKind = {read=GetTypeKind, nodefault};
	__property Typinfo::TOrdType OrdType = {read=GetOrdType, nodefault};
	__property int MinValue = {read=GetMinValue, nodefault};
	__property int MaxValue = {read=GetMaxValue, nodefault};
	__property Typinfo::PTypeInfo BaseType = {read=GetBaseType};
	__property int EnumCount = {read=GetEnumCount, nodefault};
	__property System::UnicodeString Names[int Index] = {read=GetEName};
	__property int Values[System::UnicodeString Index] = {read=GetEValue};
	__property Typinfo::PTypeInfo CompType = {read=GetCompType};
	__property Typinfo::TFloatType FloatType = {read=GetFloatType, nodefault};
	__property System::Byte MaxLength = {read=GetMaxLength, nodefault};
	__property System::TClass PropClassType = {read=GetClassType};
	__property Typinfo::PTypeInfo ParentInfo = {read=GetParentInfo};
	__property System::UnicodeString UnitName = {read=GetUnitName};
	__property TPropertyList* Properties = {read=FProperties};
	__property Typinfo::TMethodKind MethodKind = {read=GetMethodKind, nodefault};
	__property int ParamCount = {read=GetParamCount, nodefault};
	__property Typinfo::TParamFlags ParamFlags[int Index] = {read=GetParamFlags};
	__property System::UnicodeString ParamNames[int Index] = {read=GetParamName};
	__property System::UnicodeString ParamTypes[int Index] = {read=GetParamType};
	__property System::UnicodeString Parameters[int Index] = {read=GetParameter};
	__property System::UnicodeString ResultType = {read=GetResultType};
	__property System::UnicodeString MethodDeclaration = {read=GetMethodDeclaration};
	__property Typinfo::PTypeInfo IntfParent = {read=GetIntfParent};
	__property Typinfo::TIntfFlags IntfFlags = {read=GetIntfFlags, nodefault};
	__property GUID GUID = {read=GetGUID};
	__property System::UnicodeString IntfUnit = {read=GetIntfUnit};
	__property __int64 MinInt64Value = {read=GetMinInt64Value};
	__property __int64 MaxInt64Value = {read=GetMaxInt64Value};
	__property System::Extended AsFloat = {read=GetAsFloat, write=SetAsFloat};
	__property System::TMethod AsMethod = {read=GetAsMethod, write=SetAsMethod};
	__property int AsInteger = {read=GetAsInteger, write=SetAsInteger, nodefault};
	__property System::WideChar AsChar = {read=GetAsChar, write=SetAsChar, nodefault};
	__property System::WideChar AsWChar = {read=GetAsWChar, write=SetAsWChar, nodefault};
	__property bool AsBoolean = {read=GetAsBoolean, write=SetAsBoolean, nodefault};
	__property System::TObject* AsObject = {read=GetAsObject, write=SetAsObject};
	__property System::TDateTime AsDateTime = {read=GetAsDateTime, write=SetAsDateTime};
	__property System::TDate AsDate = {read=GetAsDate, write=SetAsDate};
	__property System::TTime AsTime = {read=GetAsTime, write=SetAsTime};
	__property System::WideString AsString = {read=GetAsString, write=SetAsString};
	__property System::Variant AsVariant = {read=GetAsVariant, write=SetAsVariant};
	__property System::_di_IInterface AsInterface = {read=GetAsInterface, write=SetAsInterface};
};


typedef int __fastcall (__closure *TCompareMethod)(TProperty* P1, TProperty* P2);

class PASCALIMPLEMENTATION TPropertyList : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TProperty* operator[](int Index) { return Properties[Index]; }
	
private:
	TProperty* FOwner;
	Classes::TList* FProperties;
	Classes::TComponent* FRoot;
	Classes::TComponent* FInstance;
	TPropertyList* __fastcall GetOwnerList(void);
	int __fastcall GetLevel(void);
	int __fastcall GetCount(void);
	TProperty* __fastcall GetProperty(int AIndex);
	void __fastcall SetRoot(const Classes::TComponent* Value);
	void __fastcall SetInstance(const Classes::TComponent* Value);
	void __fastcall Clear(void);
	void __fastcall Sort(void);
	
public:
	__fastcall virtual TPropertyList(TProperty* AOwner);
	__fastcall virtual ~TPropertyList(void);
	virtual TProperty* __fastcall CreateProperty(Typinfo::PPropInfo APropInfo, TCustomPropData* APropData);
	virtual void __fastcall AddEmulated(TProperty* P);
	virtual void __fastcall Update(void);
	virtual int __fastcall Compare(TProperty* P1, TProperty* P2);
	virtual bool __fastcall Filter(TProperty* P);
	int __fastcall IndexOf(const TProperty* Item);
	int __fastcall IndexOfName(const System::UnicodeString Name);
	TProperty* __fastcall FindProperty(const System::UnicodeString Name);
	__property TPropertyList* OwnerList = {read=GetOwnerList};
	__property int Level = {read=GetLevel, nodefault};
	__property TProperty* Properties[int Index] = {read=GetProperty/*, default*/};
	__property int Count = {read=GetCount, nodefault};
	__property TProperty* Owner = {read=FOwner};
	__property Classes::TComponent* Root = {read=FRoot, write=SetRoot};
	__property Classes::TComponent* Instance = {read=FInstance, write=SetInstance};
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE System::ResourceString _strPropListInvalidValue;
#define Propertylist_strPropListInvalidValue System::LoadResourceString(&Propertylist::_strPropListInvalidValue)
#define tkOrdinals (System::Set<Typinfo::TTypeKind, Typinfo::TTypeKind::tkUnknown, Typinfo::TTypeKind::tkProcedure> () << Typinfo::TTypeKind::tkInteger << Typinfo::TTypeKind::tkChar << Typinfo::TTypeKind::tkEnumeration << Typinfo::TTypeKind::tkSet << Typinfo::TTypeKind::tkClass << Typinfo::TTypeKind::tkWChar )
#define tkChars (System::Set<Typinfo::TTypeKind, Typinfo::TTypeKind::tkUnknown, Typinfo::TTypeKind::tkProcedure> () << Typinfo::TTypeKind::tkChar << Typinfo::TTypeKind::tkWChar )
#define tkStrings (System::Set<Typinfo::TTypeKind, Typinfo::TTypeKind::tkUnknown, Typinfo::TTypeKind::tkProcedure> () << Typinfo::TTypeKind::tkString << Typinfo::TTypeKind::tkLString << Typinfo::TTypeKind::tkWString << Typinfo::TTypeKind::tkUString )
#define PROP_DATAFIELD L"DATAFIELD"
#define PROP_TABLENAME L"TABLENAME"
#define PROP_DATABASENAME L"DATABASENAME"
extern PACKAGE void __fastcall RegisterCustomProperty(System::TClass AInstanceType, System::UnicodeString APropName, Typinfo::PTypeInfo APropType, bool ADescendants, TGetPropertyValue AGetProc, TSetPropertyValue ASetProc);
extern PACKAGE bool __fastcall RegisteredProperty(System::TClass AInstanceType, System::UnicodeString APropName);
extern PACKAGE void __fastcall UnregisterCustomProperty(System::TClass AInstanceType, System::UnicodeString APropName);
extern PACKAGE void __fastcall UnregisterCustomProperties(void);

}	/* namespace Propertylist */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Propertylist;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PropertylistHPP
