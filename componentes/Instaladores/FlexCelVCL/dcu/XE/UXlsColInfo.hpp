// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'UXlsColInfo.pas' rev: 22.00

#ifndef UxlscolinfoHPP
#define UxlscolinfoHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <UXlsBaseRecords.hpp>	// Pascal unit
#include <UXlsBaseList.hpp>	// Pascal unit
#include <XlsMessages.hpp>	// Pascal unit
#include <UFlxMessages.hpp>	// Pascal unit
#include <UXlsOtherRecords.hpp>	// Pascal unit
#include <UOle2Impl.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uxlscolinfo
{
//-- type declarations -------------------------------------------------------
#pragma pack(push,1)
struct DECLSPEC_DRECORD TColInfoDat
{
	
public:
	System::Word FirstColumn;
	System::Word LastColumn;
	System::Word Width;
	System::Word XF;
	System::Word Options;
	System::Word Reserved;
};
#pragma pack(pop)


typedef TColInfoDat *PColInfoDat;

class DELPHICLASS TColInfo;
class PASCALIMPLEMENTATION TColInfo : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::Word Column;
	System::Word Width;
	System::Word XF;
	System::Word Options;
	__fastcall TColInfo(const System::Word aColumn, const System::Word aWidth, const System::Word aXF, const System::Word aOptions);
	bool __fastcall IsEqual(const TColInfo* aColInfo);
	void __fastcall SetColOutlineLevel(int Level);
	int __fastcall GetColOutlineLevel(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TColInfo(void) { }
	
};


class DELPHICLASS TColInfoRecord;
class PASCALIMPLEMENTATION TColInfoRecord : public Uxlsbaserecords::TBaseRecord
{
	typedef Uxlsbaserecords::TBaseRecord inherited;
	
public:
	TColInfoDat __fastcall D(void);
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TColInfoRecord(const System::Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsbaserecords::TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TColInfoRecord(void) { }
	
};


class DELPHICLASS TColInfoList;
class PASCALIMPLEMENTATION TColInfoList : public Uxlsbaselist::TBaseList
{
	typedef Uxlsbaselist::TBaseList inherited;
	
public:
	TColInfo* operator[](int index) { return Items[index]; }
	
private:
	TColInfo* __fastcall GetItems(int index);
	void __fastcall SetItems(int index, const TColInfo* Value);
	
public:
	__property TColInfo* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(TColInfo* aRecord);
	HIDESBASE void __fastcall Insert(int Index, TColInfo* aRecord);
	
private:
	bool Sorted;
	
public:
	bool __fastcall Find(const int aItem, int &Index);
	HIDESBASE void __fastcall Sort(void);
	
private:
	void __fastcall SaveOneRecord(const int i, const int k, const Uole2impl::TOle2File* DataStream);
	void __fastcall SaveToStreamExt(const Uole2impl::TOle2File* DataStream, const int FirstRecord, const int RecordCount);
	void __fastcall CalcIncludedRangeRecords(const Uflxmessages::TXlsCellRange &CellRange, int &FirstRecord, int &RecordCount);
	__int64 __fastcall TotalSizeExt(const int FirstRecord, const int RecordCount);
	
public:
	void __fastcall CopyFrom(const TColInfoList* aColInfoList);
	void __fastcall AddRecord(const TColInfoRecord* R);
	void __fastcall SaveToStream(const Uole2impl::TOle2File* DataStream);
	void __fastcall SaveRangeToStream(const Uole2impl::TOle2File* DataStream, const Uflxmessages::TXlsCellRange &CellRange);
	__int64 __fastcall TotalSize(void);
	__int64 __fastcall TotalRangeSize(const Uflxmessages::TXlsCellRange &CellRange);
	void __fastcall ArrangeInsertCols(const int DestCol, const int aColCount, const Xlsmessages::TSheetInfo &SheetInfo);
	void __fastcall CopyCols(const int FirstCol, const int LastCol, const int DestCol, const int aColCount, const Xlsmessages::TSheetInfo &SheetInfo);
	void __fastcall CalcGuts(const Uxlsotherrecords::TGutsRecord* Guts);
public:
	/* TObjectList.Create */ inline __fastcall TColInfoList(void)/* overload */ : Uxlsbaselist::TBaseList() { }
	
public:
	/* TList.Destroy */ inline __fastcall virtual ~TColInfoList(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uxlscolinfo */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Uxlscolinfo;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UxlscolinfoHPP
