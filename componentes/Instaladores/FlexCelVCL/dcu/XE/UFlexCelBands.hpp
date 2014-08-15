// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'UFlexCelBands.pas' rev: 22.00

#ifndef UflexcelbandsHPP
#define UflexcelbandsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <UFlxMessages.hpp>	// Pascal unit
#include <UXlsDB.hpp>	// Pascal unit
#include <TypInfo.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uflexcelbands
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TFlxValueType { flv_Const, flv_Value, flv_Field, flv_Property, flv_Method, flv_FullDataSet };
#pragma option pop

typedef System::DynamicArray<Uxlsdb::_di_IXlsDataSet> TDataSetArray;

struct DECLSPEC_DRECORD TOneBandValue
{
	
public:
	int ColOffset;
	System::UnicodeString CellValue;
	TFlxValueType ValueType;
	Uflxmessages::TXlsCellValue Value;
	Uflxmessages::TRTFRunList RTFRuns;
	Uxlsdb::_di_IXlsField Field;
	Uxlsdb::_di_IXlsDataSet DataSet;
	Typinfo::TPropInfo *PropInfo;
	System::UnicodeString PropIndex;
	void *MethodInfo;
	System::UnicodeString VarName;
};


typedef System::DynamicArray<TOneBandValue> TBandValue;

struct DECLSPEC_DRECORD TRowBandValue
{
	
private:
	typedef System::DynamicArray<TBandValue> _TRowBandValue__1;
	
	
public:
	int XF;
	int Height;
	bool AutoHeight;
	bool Hidden;
	_TRowBandValue__1 Cols;
};


typedef System::DynamicArray<TRowBandValue> TBandValueList;

typedef System::DynamicArray<System::UnicodeString> WideStringArray;

class DELPHICLASS TExcelBand;
class DELPHICLASS TExcelBandList;
class PASCALIMPLEMENTATION TExcelBand : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	int StartRow;
	int EndRow;
	int RangePos;
	TExcelBandList* SubBands;
	TDataSetArray DataSet;
	__fastcall TExcelBand(void);
	__fastcall virtual ~TExcelBand(void);
};


class PASCALIMPLEMENTATION TExcelBandList : public Contnrs::TObjectList
{
	typedef Contnrs::TObjectList inherited;
	
public:
	TExcelBand* operator[](int index) { return Items[index]; }
	
private:
	TExcelBand* __fastcall GetItems(int index);
	void __fastcall SetItems(int index, const TExcelBand* Value);
	
public:
	__property TExcelBand* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(TExcelBand* aBand);
	HIDESBASE void __fastcall Insert(int Index, TExcelBand* aBand);
public:
	/* TObjectList.Create */ inline __fastcall TExcelBandList(void)/* overload */ : Contnrs::TObjectList() { }
	
public:
	/* TList.Destroy */ inline __fastcall virtual ~TExcelBandList(void) { }
	
};


class DELPHICLASS TExcelDbList;
class PASCALIMPLEMENTATION TExcelDbList : public Classes::TInterfaceList
{
	typedef Classes::TInterfaceList inherited;
	
public:
	Uxlsdb::_di_IXlsDataSet operator[](int index) { return Items[index]; }
	
private:
	Uxlsdb::_di_IXlsDataSet __fastcall GetItems(int index);
	void __fastcall SetItems(int index, const Uxlsdb::_di_IXlsDataSet Value);
	
public:
	__property Uxlsdb::_di_IXlsDataSet Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(Uxlsdb::_di_IXlsDataSet aDataSet);
	HIDESBASE void __fastcall Insert(int Index, Uxlsdb::_di_IXlsDataSet aDataSet);
	void __fastcall Check(const Uxlsdb::_di_IXlsDataSet DataSet);
	__fastcall virtual ~TExcelDbList(void);
public:
	/* TInterfaceList.Create */ inline __fastcall TExcelDbList(void) : Classes::TInterfaceList() { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uflexcelbands */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Uflexcelbands;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UflexcelbandsHPP
