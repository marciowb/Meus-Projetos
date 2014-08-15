// CodeGear C++Builder
// Copyright (c) 1995, 2008 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uxlsrangerecords.pas' rev: 20.00

#ifndef UxlsrangerecordsHPP
#define UxlsrangerecordsHPP

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
#include <Uflxmessages.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Uole2impl.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uxlsrangerecords
{
//-- type declarations -------------------------------------------------------
#pragma pack(push,1)
struct TExcelRange
{
	
public:
	System::Word R1;
	System::Word R2;
	System::Word C1;
	System::Word C2;
};
#pragma pack(pop)


typedef TExcelRange *PExcelRange;

class DELPHICLASS TRangeValuesList;
class PASCALIMPLEMENTATION TRangeValuesList : public Classes::TList
{
	typedef Classes::TList inherited;
	
private:
	System::Word FOtherDataLen;
	int MaxRangesPerRecord;
	void __fastcall CopyIntersectRange(const PExcelRange R, const PExcelRange Rx, const int NewFirstRow, const int NewLastRow, const int DestRow, const int aCount, System::Word &MinR1, System::Word &MaxR2);
	int __fastcall NextInRange(const Uflxmessages::TXlsCellRange &Range, const int k);
	
protected:
	virtual void __fastcall Notify(void * Ptr, Classes::TListNotification Action);
	
public:
	__fastcall TRangeValuesList(const int aMaxRangesPerRecord, const System::Word aOtherDataLen);
	void __fastcall Load(const Uxlsbaserecords::TBaseRecord* aRecord, const int aPos);
	void __fastcall SaveToStreamR(const Uole2impl::TOle2File* DataStream, const int Line);
	void __fastcall SaveRangeToStreamR(const Uole2impl::TOle2File* DataStream, const int Line, const int aCount, const Uflxmessages::TXlsCellRange &Range);
	__int64 __fastcall TotalSizeR(const int aCount);
	int __fastcall RepeatCountR(const int aCount);
	int __fastcall RecordSizeR(const int Line, const int aCount);
	int __fastcall CountRangeRecords(const Uflxmessages::TXlsCellRange &Range);
	void __fastcall CopyFrom(const TRangeValuesList* RVL);
	void __fastcall ArrangeInsertRowsAndCols(const int aRowPos, const int aRowCount, const int aColPos, const int aColCount);
	void __fastcall CopyRowsInclusive(const int FirstRow, const int LastRow, const int DestRow, const int aCount, System::Word &MinR1, System::Word &MaxR2, const bool UseCols);
	void __fastcall CopyRowsExclusive(const int FirstRow, const int LastRow, const int DestRow, const int aCount, const bool UseCols);
	void __fastcall DeleteRows(const int aRow, const int aCount, const bool Allow1Cell, const bool UseCols);
	void __fastcall PreAddNewRange(int &R1, int &C1, int &R2, int &C2);
	void __fastcall AddNewRange(const int FirstRow, const int FirstCol, const int LastRow, const int LastCol);
public:
	/* TList.Destroy */ inline __fastcall virtual ~TRangeValuesList(void) { }
	
};


class DELPHICLASS TRangeEntry;
class PASCALIMPLEMENTATION TRangeEntry : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	TRangeValuesList* RangeValuesList;
	virtual TRangeEntry* __fastcall DoCopyTo(void);
	
public:
	__fastcall virtual TRangeEntry(void);
	__fastcall virtual ~TRangeEntry(void);
	TRangeEntry* __fastcall CopyTo(void);
	virtual void __fastcall LoadFromStream(const Uole2impl::TOle2File* DataStream, Xlsmessages::TRecordHeader &RecordHeader, const Uxlsotherrecords::TRangeRecord* First) = 0 ;
	virtual void __fastcall SaveToStream(const Uole2impl::TOle2File* DataStream) = 0 ;
	virtual void __fastcall SaveRangeToStream(const Uole2impl::TOle2File* DataStream, const Uflxmessages::TXlsCellRange &CellRange) = 0 ;
	virtual __int64 __fastcall TotalSize(void) = 0 ;
	virtual __int64 __fastcall TotalRangeSize(const Uflxmessages::TXlsCellRange &CellRange) = 0 ;
	virtual void __fastcall ArrangeInsertRowsAndCols(const int aRowPos, const int aRowCount, const int aColPos, const int aColCount, const Xlsmessages::TSheetInfo &SheetInfo);
	virtual void __fastcall InsertAndCopyRowsOrCols(const int FirstRow, const int LastRow, const int DestRow, const int aCount, const Xlsmessages::TSheetInfo &SheetInfo, const bool UseCols);
	virtual void __fastcall DeleteRowsOrCols(const System::Word aRow, const System::Word aCount, const Xlsmessages::TSheetInfo &SheetInfo, const bool UseCols);
};


class DELPHICLASS TMergedCells;
class PASCALIMPLEMENTATION TMergedCells : public TRangeEntry
{
	typedef TRangeEntry inherited;
	
public:
	__fastcall virtual TMergedCells(void);
	void __fastcall Clear(void);
	virtual void __fastcall LoadFromStream(const Uole2impl::TOle2File* DataStream, Xlsmessages::TRecordHeader &RecordHeader, const Uxlsotherrecords::TRangeRecord* First);
	virtual void __fastcall SaveToStream(const Uole2impl::TOle2File* DataStream);
	virtual void __fastcall SaveRangeToStream(const Uole2impl::TOle2File* DataStream, const Uflxmessages::TXlsCellRange &CellRange);
	virtual __int64 __fastcall TotalSize(void);
	virtual __int64 __fastcall TotalRangeSize(const Uflxmessages::TXlsCellRange &CellRange);
	virtual void __fastcall InsertAndCopyRowsOrCols(const int FirstRow, const int LastRow, const int DestRow, const int aCount, const Xlsmessages::TSheetInfo &SheetInfo, const bool UseCols);
	virtual void __fastcall DeleteRowsOrCols(const System::Word aRow, const System::Word aCount, const Xlsmessages::TSheetInfo &SheetInfo, const bool UseCols);
	bool __fastcall CheckCell(const int aRow, const int aCol, Uflxmessages::TXlsCellRange &CellBounds);
	int __fastcall MergedCount(void);
	Uflxmessages::TXlsCellRange __fastcall MergedCell(const int i);
	void __fastcall PreMerge(int &R1, int &C1, int &R2, int &C2);
	void __fastcall MergeCells(const int FirstRow, const int FirstCol, const int LastRow, const int LastCol);
	void __fastcall UnMergeCells(const int FirstRow, const int FirstCol, const int LastRow, const int LastCol);
public:
	/* TRangeEntry.Destroy */ inline __fastcall virtual ~TMergedCells(void) { }
	
};


typedef TMetaClass* ClassOfTRangeEntry;

//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uxlsrangerecords */
using namespace Uxlsrangerecords;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UxlsrangerecordsHPP
