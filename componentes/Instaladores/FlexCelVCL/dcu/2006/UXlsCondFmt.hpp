// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uxlscondfmt.pas' rev: 10.00

#ifndef UxlscondfmtHPP
#define UxlscondfmtHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Uxlsbaserecords.hpp>	// Pascal unit
#include <Uxlsbaserecordlists.hpp>	// Pascal unit
#include <Uxlsotherrecords.hpp>	// Pascal unit
#include <Xlsmessages.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Uxlsrangerecords.hpp>	// Pascal unit
#include <Uxlstokenarray.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit
#include <Uole2impl.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uxlscondfmt
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TCondFmtRecord;
class PASCALIMPLEMENTATION TCondFmtRecord : public Uxlsotherrecords::TRangeRecord 
{
	typedef Uxlsotherrecords::TRangeRecord inherited;
	
public:
	#pragma option push -w-inl
	/* TBaseRecord.Create */ inline __fastcall virtual TCondFmtRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize) : Uxlsotherrecords::TRangeRecord(aId, aData, aDataSize) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TCondFmtRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TCFRecord;
class PASCALIMPLEMENTATION TCFRecord : public Uxlsbaserecords::TBaseRecord 
{
	typedef Uxlsbaserecords::TBaseRecord inherited;
	
private:
	Byte CfType;
	Byte Op;
	Word Cce1;
	Word Cce2;
	void __fastcall ArrangeTokensInsertRowsAndCols(const int atPos, const int fPos, const int InsRowPos, const int InsRowOffset, const int CopyRowOffset, const int InsColPos, const int InsColOffset, const int CopyColOffset, const Xlsmessages::TSheetInfo &SheetInfo);
	
public:
	__fastcall virtual TCFRecord(const Word aId, const Xlsmessages::PArrayOfByte aData, const int aDataSize);
	void __fastcall ArrangeInsertRowsAndCols(const int aRowPos, const int aRowCount, const int aColPos, const int aColCount, const Xlsmessages::TSheetInfo &SheetInfo);
	void __fastcall ArrangeCopyRowsAndCols(const int RowOffset, const int ColOffset);
public:
	#pragma option push -w-inl
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TCFRecord(void) { }
	#pragma option pop
	
};


class DELPHICLASS TCFRecordList;
class PASCALIMPLEMENTATION TCFRecordList : public Uxlsbaserecordlists::TBaseRecordList 
{
	typedef Uxlsbaserecordlists::TBaseRecordList inherited;
	
public:
	TCFRecord* operator[](int index) { return Items[index]; }
	
private:
	TCFRecord* __fastcall GetItems(int index);
	void __fastcall SetItems(int index, const TCFRecord* Value);
	
public:
	__property TCFRecord* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(TCFRecord* aRecord);
	HIDESBASE void __fastcall Insert(int Index, TCFRecord* aRecord);
	void __fastcall ArrangeInsertRowsAndCols(const int aRowPos, const int aRowCount, const int aColPos, const int aColCount, const Xlsmessages::TSheetInfo &SheetInfo);
public:
	#pragma option push -w-inl
	/* TObjectList.Create */ inline __fastcall TCFRecordList(void)/* overload */ : Uxlsbaserecordlists::TBaseRecordList() { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TList.Destroy */ inline __fastcall virtual ~TCFRecordList(void) { }
	#pragma option pop
	
};


class DELPHICLASS TCondFmt;
class PASCALIMPLEMENTATION TCondFmt : public Uxlsrangerecords::TRangeEntry 
{
	typedef Uxlsrangerecords::TRangeEntry inherited;
	
private:
	Word Flag;
	#pragma pack(push,1)
	Uxlsrangerecords::TExcelRange AllRange;
	#pragma pack(pop)
	TCFRecordList* CFs;
	
protected:
	virtual Uxlsrangerecords::TRangeEntry* __fastcall DoCopyTo(void);
	
public:
	__fastcall virtual TCondFmt(void);
	__fastcall virtual ~TCondFmt(void);
	void __fastcall Clear(void);
	virtual void __fastcall LoadFromStream(const Uole2impl::TOle2File* DataStream, Xlsmessages::TRecordHeader &RecordHeader, const Uxlsotherrecords::TRangeRecord* First);
	virtual void __fastcall SaveToStream(const Uole2impl::TOle2File* DataStream);
	virtual void __fastcall SaveRangeToStream(const Uole2impl::TOle2File* DataStream, const Uflxmessages::TXlsCellRange &CellRange);
	virtual __int64 __fastcall TotalSize(void);
	virtual __int64 __fastcall TotalRangeSize(const Uflxmessages::TXlsCellRange &CellRange);
	virtual void __fastcall ArrangeInsertRowsAndCols(const int aRowPos, const int aRowCount, const int aColPos, const int aColCount, const Xlsmessages::TSheetInfo &SheetInfo);
	virtual void __fastcall InsertAndCopyRowsOrCols(const int FirstRow, const int LastRow, const int DestRow, const int aCount, const Xlsmessages::TSheetInfo &SheetInfo, const bool UseCols);
	virtual void __fastcall DeleteRowsOrCols(const Word aRow, const Word aCount, const Xlsmessages::TSheetInfo &SheetInfo, const bool UseCols);
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uxlscondfmt */
using namespace Uxlscondfmt;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Uxlscondfmt
