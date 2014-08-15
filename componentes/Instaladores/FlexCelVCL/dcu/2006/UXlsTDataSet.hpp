// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uxlstdataset.pas' rev: 10.00

#ifndef UxlstdatasetHPP
#define UxlstdatasetHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Uxlsdb.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uxlstdataset
{
//-- type declarations -------------------------------------------------------
typedef int __fastcall (__closure *TRecordCountProc)(const Db::TDataSet* DB);

typedef DynamicArray<Uxlsdb::_di_IXlsField >  UXlsTDataSet__2;

class DELPHICLASS TXlsTDataSet;
class PASCALIMPLEMENTATION TXlsTDataSet : public System::TInterfacedObject 
{
	typedef System::TInterfacedObject inherited;
	
private:
	Db::TDataSet* FDataSet;
	TRecordCountProc FRecordCount;
	bool FUseDisplayNames;
	bool FUseHiddenFields;
	DynamicArray<Uxlsdb::_di_IXlsField >  CacheFields;
	
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
	AnsiString __fastcall DsName();
	Uxlsdb::_di_IXlsField __fastcall FieldByName(const AnsiString Name);
	int __fastcall FieldCount(void);
	int __fastcall FieldVisibleCount(void);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TXlsTDataSet(void) { }
	#pragma option pop
	
private:
	void *__IXlsDataSet;	/* Uxlsdb::IXlsDataSet */
	
public:
	operator IXlsDataSet*(void) { return (IXlsDataSet*)&__IXlsDataSet; }
	
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
	Variant __fastcall Value();
	bool __fastcall IsTDateTimeField(void);
	bool __fastcall IsTMemoField(void);
	Extended __fastcall AsFloat(void);
	bool __fastcall Visible(void);
	AnsiString __fastcall DisplayName();
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TXlsTField(void) { }
	#pragma option pop
	
private:
	void *__IXlsField;	/* Uxlsdb::IXlsField */
	
public:
	operator IXlsField*(void) { return (IXlsField*)&__IXlsField; }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uxlstdataset */
using namespace Uxlstdataset;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Uxlstdataset
