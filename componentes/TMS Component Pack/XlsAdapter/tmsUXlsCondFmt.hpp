// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Tmsuxlscondfmt.pas' rev: 21.00

#ifndef TmsuxlscondfmtHPP
#define TmsuxlscondfmtHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Tmsuxlsbaserecords.hpp>	// Pascal unit
#include <Tmsuxlsbaserecordlists.hpp>	// Pascal unit
#include <Tmsuxlsotherrecords.hpp>	// Pascal unit
#include <Tmsxlsmessages.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Tmsuxlsrangerecords.hpp>	// Pascal unit
#include <Tmsuxlstokenarray.hpp>	// Pascal unit
#include <Tmsuflxmessages.hpp>	// Pascal unit
#include <Tmsuole2impl.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Tmsuxlscondfmt
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TCondFmtRecord;
class PASCALIMPLEMENTATION TCondFmtRecord : public Tmsuxlsotherrecords::TRangeRecord
{
	typedef Tmsuxlsotherrecords::TRangeRecord inherited;
	
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TCondFmtRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : Tmsuxlsotherrecords::TRangeRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TCondFmtRecord(void) { }
	
};


class DELPHICLASS TCFRecord;
class PASCALIMPLEMENTATION TCFRecord : public Tmsuxlsbaserecords::TBaseRecord
{
	typedef Tmsuxlsbaserecords::TBaseRecord inherited;
	
private:
	System::Byte CfType;
	System::Byte Op;
	System::Word Cce1;
	System::Word Cce2;
	void __fastcall ArrangeTokensInsertRowsAndCols(const int atPos, const int fPos, const int InsRowPos, const int InsRowOffset, const int CopyRowOffset, const int InsColPos, const int InsColOffset, const int CopyColOffset, const Tmsxlsmessages::TSheetInfo &SheetInfo);
	
public:
	__fastcall virtual TCFRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize);
	void __fastcall ArrangeInsertRowsAndCols(const int aRowPos, const int aRowCount, const int aColPos, const int aColCount, const Tmsxlsmessages::TSheetInfo &SheetInfo);
	void __fastcall ArrangeCopyRowsAndCols(const int RowOffset, const int ColOffset);
public:
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TCFRecord(void) { }
	
};


class DELPHICLASS TCFRecordList;
class PASCALIMPLEMENTATION TCFRecordList : public Tmsuxlsbaserecordlists::TBaseRecordList
{
	typedef Tmsuxlsbaserecordlists::TBaseRecordList inherited;
	
public:
	TCFRecord* operator[](int index) { return Items[index]; }
	
private:
	TCFRecord* __fastcall GetItems(int index);
	void __fastcall SetItems(int index, const TCFRecord* Value);
	
public:
	__property TCFRecord* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(TCFRecord* aRecord);
	HIDESBASE void __fastcall Insert(int Index, TCFRecord* aRecord);
	void __fastcall ArrangeInsertRowsAndCols(const int aRowPos, const int aRowCount, const int aColPos, const int aColCount, const Tmsxlsmessages::TSheetInfo &SheetInfo);
public:
	/* TObjectList.Create */ inline __fastcall TCFRecordList(void)/* overload */ : Tmsuxlsbaserecordlists::TBaseRecordList() { }
	
public:
	/* TList.Destroy */ inline __fastcall virtual ~TCFRecordList(void) { }
	
};


class DELPHICLASS TCondFmt;
class PASCALIMPLEMENTATION TCondFmt : public Tmsuxlsrangerecords::TRangeEntry
{
	typedef Tmsuxlsrangerecords::TRangeEntry inherited;
	
private:
	System::Word Flag;
	Tmsuxlsrangerecords::TExcelRange AllRange;
	TCFRecordList* CFs;
	
protected:
	virtual Tmsuxlsrangerecords::TRangeEntry* __fastcall DoCopyTo(void);
	
public:
	__fastcall virtual TCondFmt(void);
	__fastcall virtual ~TCondFmt(void);
	void __fastcall Clear(void);
	virtual void __fastcall LoadFromStream(const Tmsuole2impl::TOle2File* DataStream, Tmsxlsmessages::TRecordHeader &RecordHeader, const Tmsuxlsotherrecords::TRangeRecord* First);
	virtual void __fastcall SaveToStream(const Tmsuole2impl::TOle2File* DataStream);
	virtual void __fastcall SaveRangeToStream(const Tmsuole2impl::TOle2File* DataStream, const Tmsuflxmessages::TXlsCellRange &CellRange);
	virtual __int64 __fastcall TotalSize(void);
	virtual __int64 __fastcall TotalRangeSize(const Tmsuflxmessages::TXlsCellRange &CellRange);
	virtual void __fastcall ArrangeInsertRowsAndCols(const int aRowPos, const int aRowCount, const int aColPos, const int aColCount, const Tmsxlsmessages::TSheetInfo &SheetInfo);
	virtual void __fastcall InsertAndCopyRowsOrCols(const int FirstRow, const int LastRow, const int DestRow, const int aCount, const Tmsxlsmessages::TSheetInfo &SheetInfo, const bool UseCols);
	virtual void __fastcall DeleteRowsOrCols(const System::Word aRow, const System::Word aCount, const Tmsxlsmessages::TSheetInfo &SheetInfo, const bool UseCols);
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Tmsuxlscondfmt */
using namespace Tmsuxlscondfmt;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TmsuxlscondfmtHPP
