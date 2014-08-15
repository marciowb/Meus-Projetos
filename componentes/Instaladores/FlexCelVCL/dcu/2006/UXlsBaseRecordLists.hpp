// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uxlsbaserecordlists.pas' rev: 10.00

#ifndef UxlsbaserecordlistsHPP
#define UxlsbaserecordlistsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Xlsmessages.hpp>	// Pascal unit
#include <Uxlsbaserecords.hpp>	// Pascal unit
#include <Uxlsotherrecords.hpp>	// Pascal unit
#include <Uxlsformula.hpp>	// Pascal unit
#include <Uxlsbaselist.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit
#include <Uole2impl.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uxlsbaserecordlists
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TBaseRecordList;
class PASCALIMPLEMENTATION TBaseRecordList : public Uxlsbaselist::TBaseList 
{
	typedef Uxlsbaselist::TBaseList inherited;
	
public:
	HIDESBASE int __fastcall Add(Uxlsbaserecords::TBaseRecord* aRecord);
	HIDESBASE void __fastcall Insert(int Index, Uxlsbaserecords::TBaseRecord* aRecord);
	
private:
	__int64 FTotalSize;
	
protected:
	virtual void __fastcall Notify(void * Ptr, Classes::TListNotification Action);
	virtual __int64 __fastcall GetTotalSize(void);
	
public:
	void __fastcall AdaptSize(int Delta);
	void __fastcall CopyFrom(const TBaseRecordList* aBaseRecordList);
	__property __int64 TotalSize = {read=GetTotalSize};
	virtual void __fastcall SaveToStream(const Uole2impl::TOle2File* DataStream);
public:
	#pragma option push -w-inl
	/* TObjectList.Create */ inline __fastcall TBaseRecordList(void)/* overload */ : Uxlsbaselist::TBaseList() { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TList.Destroy */ inline __fastcall virtual ~TBaseRecordList(void) { }
	#pragma option pop
	
};


class DELPHICLASS TBaseRowColRecordList;
class PASCALIMPLEMENTATION TBaseRowColRecordList : public TBaseRecordList 
{
	typedef TBaseRecordList inherited;
	
public:
	Uxlsbaserecords::TBaseRowColRecord* operator[](int index) { return Items[index]; }
	
private:
	Uxlsbaserecords::TBaseRowColRecord* __fastcall GetItems(int index);
	void __fastcall SetItems(int index, const Uxlsbaserecords::TBaseRowColRecord* Value);
	
public:
	__property Uxlsbaserecords::TBaseRowColRecord* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(Uxlsbaserecords::TBaseRowColRecord* aRecord);
	HIDESBASE void __fastcall Insert(int Index, Uxlsbaserecords::TBaseRowColRecord* aRecord);
	
private:
	bool Sorted;
	
public:
	bool __fastcall Find(const int aItem, int &Index);
	HIDESBASE void __fastcall Sort(void);
	void __fastcall ArrangeCopyRowsAndCols(const int RowOffset, const int ColOffset);
	void __fastcall ArrangeInsertRowsAndCols(const int aRowPos, const int aRowCount, const int aColPos, const int aColCount, const Xlsmessages::TSheetInfo &SheetInfo);
	virtual void __fastcall SaveRangeToStream(const Uole2impl::TOle2File* DataStream, const Uflxmessages::TXlsCellRange &CellRange);
	virtual __int64 __fastcall TotalRangeSize(const Uflxmessages::TXlsCellRange &CellRange, const bool NeedsRecalc);
public:
	#pragma option push -w-inl
	/* TObjectList.Create */ inline __fastcall TBaseRowColRecordList(void)/* overload */ : TBaseRecordList() { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TList.Destroy */ inline __fastcall virtual ~TBaseRowColRecordList(void) { }
	#pragma option pop
	
};


class DELPHICLASS TNameRecordList;
class PASCALIMPLEMENTATION TNameRecordList : public TBaseRecordList 
{
	typedef TBaseRecordList inherited;
	
public:
	Uxlsformula::TNameRecord* operator[](int index) { return Items[index]; }
	
private:
	Uxlsformula::TNameRecord* __fastcall GetItems(int index);
	void __fastcall SetItems(int index, const Uxlsformula::TNameRecord* Value);
	
public:
	__property Uxlsformula::TNameRecord* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(Uxlsformula::TNameRecord* aRecord);
	HIDESBASE void __fastcall Insert(int Index, Uxlsformula::TNameRecord* aRecord);
	void __fastcall ArrangeInsertRowsAndCols(const int InsRow, const int aRowCount, const int InsCol, const int aColCount, const Xlsmessages::TSheetInfo &SheetInfo);
	void __fastcall InsertSheets(const int CopyFrom, const int BeforeSheet, int SheetCount, const Xlsmessages::TSheetInfo &SheetInfo);
	void __fastcall DeleteSheets(const int SheetIndex, const int SheetCount);
public:
	#pragma option push -w-inl
	/* TObjectList.Create */ inline __fastcall TNameRecordList(void)/* overload */ : TBaseRecordList() { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TList.Destroy */ inline __fastcall virtual ~TNameRecordList(void) { }
	#pragma option pop
	
};


class DELPHICLASS TBoundSheetRecordList;
class PASCALIMPLEMENTATION TBoundSheetRecordList : public TBaseRecordList 
{
	typedef TBaseRecordList inherited;
	
public:
	Uxlsotherrecords::TBoundSheetRecord* operator[](int index) { return Items[index]; }
	
private:
	WideString __fastcall GetSheetName(int index);
	void __fastcall SetSheetName(int index, const WideString Value);
	Uflxmessages::TXlsSheetVisible __fastcall GetSheetVisible(int index);
	void __fastcall SetSheetVisible(int index, const Uflxmessages::TXlsSheetVisible Value);
	Uxlsotherrecords::TBoundSheetRecord* __fastcall GetItems(int index);
	void __fastcall SetItems(int index, const Uxlsotherrecords::TBoundSheetRecord* Value);
	
public:
	__property Uxlsotherrecords::TBoundSheetRecord* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(Uxlsotherrecords::TBoundSheetRecord* aRecord);
	HIDESBASE void __fastcall Insert(int Index, Uxlsotherrecords::TBoundSheetRecord* aRecord);
	__property WideString SheetName[int index] = {read=GetSheetName, write=SetSheetName};
	__property Uflxmessages::TXlsSheetVisible SheetVisible[int index] = {read=GetSheetVisible, write=SetSheetVisible};
public:
	#pragma option push -w-inl
	/* TObjectList.Create */ inline __fastcall TBoundSheetRecordList(void)/* overload */ : TBaseRecordList() { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TList.Destroy */ inline __fastcall virtual ~TBoundSheetRecordList(void) { }
	#pragma option pop
	
};


class DELPHICLASS TCellRecordList;
class PASCALIMPLEMENTATION TCellRecordList : public TBaseRowColRecordList 
{
	typedef TBaseRowColRecordList inherited;
	
public:
	Uxlsbaserecords::TCellRecord* operator[](int index) { return Items[index]; }
	
private:
	HIDESBASE Uxlsbaserecords::TCellRecord* __fastcall GetItems(int index);
	HIDESBASE void __fastcall SetItems(int index, const Uxlsbaserecords::TCellRecord* Value);
	
public:
	__property Uxlsbaserecords::TCellRecord* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(Uxlsbaserecords::TCellRecord* aRecord);
	HIDESBASE void __fastcall Insert(int Index, Uxlsbaserecords::TCellRecord* aRecord);
	
private:
	void __fastcall GoNext(int &i, const int aCount, Uxlsbaserecords::TCellRecord* &it, Uxlsbaserecords::TCellRecord* &NextRec);
	__int64 __fastcall SaveAndCalcRange(const Uole2impl::TOle2File* DataStream, const Uflxmessages::TXlsCellRange &CellRange, const bool NeedsRecalc);
	
public:
	virtual void __fastcall SaveRangeToStream(const Uole2impl::TOle2File* DataStream, const Uflxmessages::TXlsCellRange &CellRange);
	virtual __int64 __fastcall TotalRangeSize(const Uflxmessages::TXlsCellRange &CellRange, const bool NeedsRecalc);
	virtual void __fastcall SaveToStream(const Uole2impl::TOle2File* DataStream);
	virtual __int64 __fastcall GetTotalSize(void);
	__int64 __fastcall FixTotalSize(const bool NeedsRecalc);
public:
	#pragma option push -w-inl
	/* TObjectList.Create */ inline __fastcall TCellRecordList(void)/* overload */ : TBaseRowColRecordList() { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TList.Destroy */ inline __fastcall virtual ~TCellRecordList(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRowRecordList;
class PASCALIMPLEMENTATION TRowRecordList : public TBaseRowColRecordList 
{
	typedef TBaseRowColRecordList inherited;
	
public:
	Uxlsbaserecords::TRowRecord* operator[](int index) { return Items[index]; }
	
private:
	HIDESBASE Uxlsbaserecords::TRowRecord* __fastcall GetItems(int index);
	HIDESBASE void __fastcall SetItems(int index, const Uxlsbaserecords::TRowRecord* Value);
	
public:
	int __fastcall AddRecord(Uxlsbaserecords::TRowRecord* aRecord);
	__property Uxlsbaserecords::TRowRecord* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	bool __fastcall HasRow(const int Index);
	void __fastcall AddRow(const Word Index);
	void __fastcall InsertAndCopyRows(const int FirstRow, const int LastRow, const int DestRow, const int aCount, const Xlsmessages::TSheetInfo &SheetInfo);
	void __fastcall DeleteRows(const Word aRow, const Word aRowCount, const Xlsmessages::TSheetInfo &SheetInfo);
	int __fastcall RowHeight(const int aRow);
	void __fastcall SetRowHeight(const int aRow, const Word Height);
	void __fastcall AutoRowHeight(const int aRow, const bool Value);
	bool __fastcall IsAutoRowHeight(const int aRow);
	virtual __int64 __fastcall TotalRangeSize(const Uflxmessages::TXlsCellRange &CellRange, const bool NeedsRecalc);
	void __fastcall CalcGuts(const Uxlsotherrecords::TGutsRecord* Guts);
public:
	#pragma option push -w-inl
	/* TObjectList.Create */ inline __fastcall TRowRecordList(void)/* overload */ : TBaseRowColRecordList() { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TList.Destroy */ inline __fastcall virtual ~TRowRecordList(void) { }
	#pragma option pop
	
};


class DELPHICLASS TShrFmlaRecordList;
class PASCALIMPLEMENTATION TShrFmlaRecordList : public TBaseRecordList 
{
	typedef TBaseRecordList inherited;
	
public:
	Uxlsformula::TShrFmlaRecord* operator[](int index) { return Items[index]; }
	
private:
	Uxlsformula::TShrFmlaRecord* __fastcall GetItems(int index);
	void __fastcall SetItems(int index, const Uxlsformula::TShrFmlaRecord* Value);
	
public:
	__property Uxlsformula::TShrFmlaRecord* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(Uxlsformula::TShrFmlaRecord* aRecord);
	HIDESBASE void __fastcall Insert(int Index, Uxlsformula::TShrFmlaRecord* aRecord);
	
private:
	bool Sorted;
	
public:
	bool __fastcall Find(const unsigned aItem, int &Index);
	HIDESBASE void __fastcall Sort(void);
public:
	#pragma option push -w-inl
	/* TObjectList.Create */ inline __fastcall TShrFmlaRecordList(void)/* overload */ : TBaseRecordList() { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TList.Destroy */ inline __fastcall virtual ~TShrFmlaRecordList(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uxlsbaserecordlists */
using namespace Uxlsbaserecordlists;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Uxlsbaserecordlists
