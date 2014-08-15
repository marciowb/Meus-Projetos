// CodeGear C++Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uflexcelbands.pas' rev: 11.00

#ifndef UflexcelbandsHPP
#define UflexcelbandsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit
#include <Uxlsdb.hpp>	// Pascal unit
#include <Typinfo.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uflexcelbands
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TFlxValueType { flv_Const, flv_Value, flv_Field, flv_Property, flv_Method, flv_FullDataSet };
#pragma option pop

typedef DynamicArray<Uxlsdb::_di_IXlsDataSet >  TDataSetArray;

struct TOneBandValue
{
	
public:
	int ColOffset;
	WideString CellValue;
	TFlxValueType ValueType;
	Uflxmessages::TXlsCellValue Value;
	DynamicArray<Uflxmessages::TRTFRun >  RTFRuns;
	Uxlsdb::_di_IXlsField Field;
	Uxlsdb::_di_IXlsDataSet DataSet;
	Typinfo::TPropInfo *PropInfo;
	AnsiString PropIndex;
	void *MethodInfo;
	AnsiString VarName;
} ;

typedef DynamicArray<TOneBandValue >  TBandValue;

typedef DynamicArray<DynamicArray<TOneBandValue > >  UFlexCelBands__1;

#pragma pack(push,4)
struct TRowBandValue
{
	
public:
	int XF;
	int Height;
	bool AutoHeight;
	bool Hidden;
	DynamicArray<DynamicArray<TOneBandValue > >  Cols;
} ;
#pragma pack(pop)

typedef DynamicArray<TRowBandValue >  TBandValueList;

typedef DynamicArray<WideString >  WideStringArray;

class DELPHICLASS TExcelBand;
class DELPHICLASS TExcelBandList;
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
	#pragma option push -w-inl
	/* TObjectList.Create */ inline __fastcall TExcelBandList(void)/* overload */ : Contnrs::TObjectList() { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TList.Destroy */ inline __fastcall virtual ~TExcelBandList(void) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TExcelBand : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	int StartRow;
	int EndRow;
	int RangePos;
	TExcelBandList* SubBands;
	DynamicArray<Uxlsdb::_di_IXlsDataSet >  DataSet;
	__fastcall TExcelBand(void);
	__fastcall virtual ~TExcelBand(void);
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
	#pragma option push -w-inl
	/* TInterfaceList.Create */ inline __fastcall TExcelDbList(void) : Classes::TInterfaceList() { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uflexcelbands */
using namespace Uflexcelbands;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Uflexcelbands
