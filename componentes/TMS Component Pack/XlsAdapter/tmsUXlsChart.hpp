// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Tmsuxlschart.pas' rev: 21.00

#ifndef TmsuxlschartHPP
#define TmsuxlschartHPP

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
#include <Tmsuxlstokenarray.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Tmsuxlsbaselist.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Tmsuxlschart
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TChartRecord;
class PASCALIMPLEMENTATION TChartRecord : public Tmsuxlsbaserecords::TBaseRecord
{
	typedef Tmsuxlsbaserecords::TBaseRecord inherited;
	
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TChartRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : Tmsuxlsbaserecords::TBaseRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TChartRecord(void) { }
	
};


class DELPHICLASS TBeginRecord;
class PASCALIMPLEMENTATION TBeginRecord : public TChartRecord
{
	typedef TChartRecord inherited;
	
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TBeginRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : TChartRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TBeginRecord(void) { }
	
};


class DELPHICLASS TEndRecord;
class PASCALIMPLEMENTATION TEndRecord : public TChartRecord
{
	typedef TChartRecord inherited;
	
public:
	/* TBaseRecord.Create */ inline __fastcall virtual TEndRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize) : TChartRecord(aId, aData, aDataSize) { }
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TEndRecord(void) { }
	
};


class DELPHICLASS TChartAIRecord;
class PASCALIMPLEMENTATION TChartAIRecord : public TChartRecord
{
	typedef TChartRecord inherited;
	
private:
	System::Word Flags;
	System::Word FLen;
	void __fastcall ArrangeTokensInsertRowsAndCols(const int InsRowPos, const int InsRowOffset, const int CopyRowOffset, const int InsColPos, const int InsColOffset, const int CopyColOffset, const Tmsxlsmessages::TSheetInfo &SheetInfo);
	
public:
	__fastcall virtual TChartAIRecord(const System::Word aId, const Tmsxlsmessages::PArrayOfByte aData, const int aDataSize);
	void __fastcall ArrangeInsertRowsAndCols(const int aRowPos, const int aRowCount, const int aColPos, const int aColCount, const Tmsxlsmessages::TSheetInfo &SheetInfo);
	void __fastcall ArrangeCopySheet(const Tmsxlsmessages::TSheetInfo &SheetInfo);
	void __fastcall ArrangeCopyRowsAndCols(const int RowOffset, const int ColOffset);
public:
	/* TBaseRecord.Destroy */ inline __fastcall virtual ~TChartAIRecord(void) { }
	
};


class DELPHICLASS TChartAIRecordCache;
class PASCALIMPLEMENTATION TChartAIRecordCache : public Tmsuxlsbaselist::TBaseList
{
	typedef Tmsuxlsbaselist::TBaseList inherited;
	
public:
	TChartAIRecord* operator[](int index) { return Items[index]; }
	
private:
	TChartAIRecord* __fastcall GetItems(int index);
	void __fastcall SetItems(int index, const TChartAIRecord* Value);
	
public:
	__property TChartAIRecord* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(TChartAIRecord* aRecord);
	HIDESBASE void __fastcall Insert(int Index, TChartAIRecord* aRecord);
	__fastcall TChartAIRecordCache(void);
	void __fastcall ArrangeCopyRowsAndCols(const int RowOffset, const int ColOffset);
	void __fastcall ArrangeInsertRowsAndCols(const int aRowPos, const int aRowCount, const int aColPos, const int aColCount, const Tmsxlsmessages::TSheetInfo &SheetInfo);
	void __fastcall ArrangeCopySheet(const Tmsxlsmessages::TSheetInfo &SheetInfo);
public:
	/* TList.Destroy */ inline __fastcall virtual ~TChartAIRecordCache(void) { }
	
};


class DELPHICLASS TChartRecordList;
class PASCALIMPLEMENTATION TChartRecordList : public Tmsuxlsbaserecordlists::TBaseRecordList
{
	typedef Tmsuxlsbaserecordlists::TBaseRecordList inherited;
	
private:
	TChartAIRecordCache* AICache;
	
protected:
	virtual void __fastcall Notify(void * Ptr, Classes::TListNotification Action);
	
public:
	__fastcall TChartRecordList(void);
	__fastcall virtual ~TChartRecordList(void);
	void __fastcall ArrangeCopyRowsAndCols(const int RowOffset, const int ColOffset);
	void __fastcall ArrangeInsertRowsAndCols(const int aRowPos, const int aRowCount, const int aColPos, const int aColCount, const Tmsxlsmessages::TSheetInfo &SheetInfo);
	void __fastcall ArrangeCopySheet(const Tmsxlsmessages::TSheetInfo &SheetInfo);
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Tmsuxlschart */
using namespace Tmsuxlschart;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TmsuxlschartHPP
