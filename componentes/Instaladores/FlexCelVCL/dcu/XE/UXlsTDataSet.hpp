// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'UXlsTDataSet.pas' rev: 22.00

#ifndef UxlstdatasetHPP
#define UxlstdatasetHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <UXlsDB.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <UFlxMessages.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uxlstdataset
{
//-- type declarations -------------------------------------------------------
typedef int __fastcall (__closure *TRecordCountProc)(const Db::TDataSet* DB);

class DELPHICLASS TXlsTDataSet;
class PASCALIMPLEMENTATION TXlsTDataSet : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
private:
	typedef System::DynamicArray<Uxlsdb::_di_IXlsField> _TXlsTDataSet__1;
	
	
private:
	Db::TDataSet* FDataSet;
	TRecordCountProc FRecordCount;
	bool FUseDisplayNames;
	bool FUseHiddenFields;
	_TXlsTDataSet__1 CacheFields;
	
public:
	__fastcall TXlsTDataSet(const Db::TDataSet* aDataSet, const TRecordCountProc aRecordCount, const bool aUseDisplayNames, const bool aUseHiddenFields);
	Uxlsdb::_di_IXlsField __fastcall GetFields(int index);
	bool __fastcall GetActive(void);
	void __fastcall Open(void);
	void __fastcall Close(void);
	__property bool Active = {read=GetActive, nodefault};
	int __fastcall RecordCount(void);
	void __fastcall First(void);
	void __fastcall Next(void);
	void __fastcall Last(void);
	bool __fastcall Eof(void);
	System::UnicodeString __fastcall DsName(void);
	Uxlsdb::_di_IXlsField __fastcall FieldByName(const System::UnicodeString Name);
	int __fastcall FieldCount(void);
	int __fastcall FieldVisibleCount(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TXlsTDataSet(void) { }
	
private:
	void *__IXlsDataSet;	/* Uxlsdb::IXlsDataSet */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Uxlsdb::_di_IXlsDataSet()
	{
		Uxlsdb::_di_IXlsDataSet intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IXlsDataSet*(void) { return (IXlsDataSet*)&__IXlsDataSet; }
	#endif
	
};


class DELPHICLASS TXlsTField;
class PASCALIMPLEMENTATION TXlsTField : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
private:
	int FFieldIndex;
	Db::TDataSet* FRealDataSet;
	
public:
	__fastcall TXlsTField(const Db::TField* aField);
	System::Variant __fastcall Value(void);
	bool __fastcall IsTDateTimeField(void);
	bool __fastcall IsTMemoField(void);
	System::Extended __fastcall AsFloat(void);
	bool __fastcall Visible(void);
	System::UnicodeString __fastcall DisplayName(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TXlsTField(void) { }
	
private:
	void *__IXlsField;	/* Uxlsdb::IXlsField */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Uxlsdb::_di_IXlsField()
	{
		Uxlsdb::_di_IXlsField intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IXlsField*(void) { return (IXlsField*)&__IXlsField; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uxlstdataset */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Uxlstdataset;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UxlstdatasetHPP
