// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Tmsuxlsrowcolentries.pas' rev: 21.00

#ifndef TmsuxlsrowcolentriesHPP
#define TmsuxlsrowcolentriesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Tmsuxlsbaserecords.hpp>	// Pascal unit
#include <Tmsuxlsbaserecordlists.hpp>	// Pascal unit
#include <Tmsuxlsotherrecords.hpp>	// Pascal unit
#include <Tmsxlsmessages.hpp>	// Pascal unit
#include <Tmsuxlsrangerecords.hpp>	// Pascal unit
#include <Tmsuxlsbaselist.hpp>	// Pascal unit
#include <Tmsuxlscellrecords.hpp>	// Pascal unit
#include <Tmsuxlsformula.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Tmsuxlssst.hpp>	// Pascal unit
#include <Tmsuflxmessages.hpp>	// Pascal unit
#include <Tmsuxlscolinfo.hpp>	// Pascal unit
#include <Tmsuxlsreferences.hpp>	// Pascal unit
#include <Tmsuxlsworkbookglobals.hpp>	// Pascal unit
#include <Tmsuxlstokenarray.hpp>	// Pascal unit
#include <Tmsxlsformulamessages.hpp>	// Pascal unit
#include <Tmsuflxnumberformat.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Tmsuflxformats.hpp>	// Pascal unit
#include <Tmsuole2impl.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Tmsuxlsrowcolentries
{
//-- type declarations -------------------------------------------------------
typedef TMetaClass* TListClass;

typedef DynamicArray<Tmsuflxformats::TFlxFont> TFlxFontArray;

typedef DynamicArray<int> TIntegerArray;

class DELPHICLASS TColWidthCalc;
class PASCALIMPLEMENTATION TColWidthCalc : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TFlxFontArray XFFonts;
	Tmsuxlsworkbookglobals::TWorkbookGlobals* Wg;
	Graphics::TBitmap* bmp;
	Graphics::TCanvas* Canvas;
	void __fastcall InitXF(void);
	
public:
	__fastcall TColWidthCalc(const Tmsuxlsworkbookglobals::TWorkbookGlobals* aWg);
	int __fastcall CalcCellWidth(const int Row, const int Col, const Tmsuflxmessages::TRichString &val, const int XF, const void * Workbook, const System::Extended RowMultDisplay, const System::Extended ColMultDisplay);
	__fastcall virtual ~TColWidthCalc(void);
};


class DELPHICLASS TBaseRowColList;
class PASCALIMPLEMENTATION TBaseRowColList : public Tmsuxlsbaselist::TBaseList
{
	typedef Tmsuxlsbaselist::TBaseList inherited;
	
public:
	Tmsuxlsbaserecordlists::TBaseRowColRecordList* operator[](int index) { return Items[index]; }
	
private:
	Tmsuxlsbaserecordlists::TBaseRowColRecordList* __fastcall GetItems(int index);
	void __fastcall SetItems(int index, const Tmsuxlsbaserecordlists::TBaseRowColRecordList* Value);
	
public:
	__property Tmsuxlsbaserecordlists::TBaseRowColRecordList* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(Tmsuxlsbaserecordlists::TBaseRowColRecordList* aRecord);
	HIDESBASE void __fastcall Insert(int Index, Tmsuxlsbaserecordlists::TBaseRowColRecordList* aRecord);
	
protected:
	TListClass ListClass;
	
public:
	void __fastcall AddRecord(const Tmsuxlsbaserecords::TBaseRowColRecord* aRecord, const int aRow);
	void __fastcall CopyFrom(const TBaseRowColList* aList);
	void __fastcall SaveToStream(const Tmsuole2impl::TOle2File* DataStream);
	void __fastcall SaveRangeToStream(const Tmsuole2impl::TOle2File* DataStream, const Tmsuflxmessages::TXlsCellRange &CellRange);
	__int64 __fastcall TotalSize(void);
	__int64 __fastcall TotalRangeSize(const Tmsuflxmessages::TXlsCellRange &CellRange);
	void __fastcall InsertAndCopyRows(const int FirstRow, const int LastRow, const int DestRow, const int aCount, const Tmsxlsmessages::TSheetInfo &SheetInfo, const bool OnlyFormulas);
	virtual void __fastcall InsertAndCopyCols(const int FirstCol, const int LastCol, const int DestCol, const int aCount, const Tmsxlsmessages::TSheetInfo &SheetInfo, const bool OnlyFormulas);
	void __fastcall DeleteRows(const System::Word aRow, const System::Word aCount, const Tmsxlsmessages::TSheetInfo &SheetInfo);
	void __fastcall DeleteCols(const System::Word aCol, const System::Word aCount, const Tmsxlsmessages::TSheetInfo &SheetInfo);
	virtual void __fastcall ArrangeInsertRowsAndCols(const int InsRowPos, const int InsRowCount, const int InsColPos, const int InsColCount, const Tmsxlsmessages::TSheetInfo &SheetInfo);
	__fastcall TBaseRowColList(const TListClass aListClass);
public:
	/* TList.Destroy */ inline __fastcall virtual ~TBaseRowColList(void) { }
	
};


class DELPHICLASS TCellList;
class PASCALIMPLEMENTATION TCellList : public TBaseRowColList
{
	typedef TBaseRowColList inherited;
	
public:
	Tmsuxlsbaserecordlists::TCellRecordList* operator[](int index) { return Items[index]; }
	
private:
	Tmsuxlsworkbookglobals::TWorkbookGlobals* FGlobals;
	Tmsuxlsbaserecordlists::TRowRecordList* FRowRecordList;
	Tmsuxlscolinfo::TColInfoList* FColInfoList;
	Tmsuflxmessages::TXlsCellValue __fastcall GetValue(int Row, int Col);
	void __fastcall FixFormulaTokens(const Tmsuxlsformula::TFormulaRecord* Formula, const Tmsuxlsbaserecordlists::TShrFmlaRecordList* ShrFmlas);
	System::UnicodeString __fastcall GetFormula(int Row, int Col);
	void __fastcall SetFormula(int Row, int Col, const System::UnicodeString Value);
	void __fastcall AutofitColumn(const void * Workbook, const int Column, const TColWidthCalc* ColCalc, const System::Extended RowMultDisplay, const System::Extended ColMultDisplay, const bool IgnoreStrings, const System::Extended Adjustment);
	HIDESBASE Tmsuxlsbaserecordlists::TCellRecordList* __fastcall GetItems(int index);
	HIDESBASE void __fastcall SetItems(int index, const Tmsuxlsbaserecordlists::TCellRecordList* Value);
	
public:
	__property Tmsuxlsbaserecordlists::TCellRecordList* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(Tmsuxlsbaserecordlists::TCellRecordList* aRecord);
	HIDESBASE void __fastcall Insert(int Index, Tmsuxlsbaserecordlists::TCellRecordList* aRecord);
	__fastcall TCellList(const Tmsuxlsworkbookglobals::TWorkbookGlobals* aGlobals, const Tmsuxlsbaserecordlists::TRowRecordList* aRowRecordList, const Tmsuxlscolinfo::TColInfoList* aColInfoList);
	__property Tmsuflxmessages::TXlsCellValue Value[int Row][int Col] = {read=GetValue};
	void __fastcall SetValueX2(const int Row, const int Col, const Tmsuflxmessages::TXlsCellValue &Value, const Tmsuflxmessages::TRTFRunList RTFRuns, const bool Options1904);
	void __fastcall GetValueX2(const int Row, const int Col, /* out */ Tmsuflxmessages::TXlsCellValue &V, /* out */ Tmsuflxmessages::TRTFRunList &RTFRuns);
	void __fastcall SetFormat(const int Row, const int Col, const int XF);
	__property System::UnicodeString Formula[int Row][int Col] = {read=GetFormula, write=SetFormula};
	void __fastcall AssignFormulaX(const int Row, const int Col, const System::UnicodeString Formula, const System::Variant &Value, const bool Options1904);
	Tmsxlsmessages::PArrayOfByte __fastcall ArrayFormula(const int Row, const int Col);
	Tmsxlsmessages::PArrayOfByte __fastcall TableFormula(const int Row, const int Col);
	void __fastcall FixFormulas(const Tmsuxlsbaserecordlists::TShrFmlaRecordList* ShrFmlas);
	System::UnicodeString __fastcall GetSheetName(const int SheetNumber);
	int __fastcall AddExternSheet(const int FirstSheet, const int LastSheet);
	bool __fastcall FindSheet(System::UnicodeString SheetName, /* out */ int &SheetIndex);
	virtual void __fastcall InsertAndCopyCols(const int FirstCol, const int LastCol, const int DestCol, const int aCount, const Tmsxlsmessages::TSheetInfo &SheetInfo, const bool OnlyFormulas);
	virtual void __fastcall ArrangeInsertRowsAndCols(const int InsRowPos, const int InsRowCount, const int InsColPos, const int InsColCount, const Tmsxlsmessages::TSheetInfo &SheetInfo);
	void __fastcall ArrangeInsertSheet(const Tmsxlsmessages::TSheetInfo &SheetInfo);
	System::UnicodeString __fastcall GetName(const int ExternSheet, const int NameId);
	void __fastcall RecalcColWidths(const void * Workbook, const int Col1, const int Col2, const bool IgnoreStrings, const System::Extended Adjustment);
	void __fastcall RecalcRowHeights(const void * Workbook, const int Row1, const int Row2, const bool Forced, const bool KeepAutofit, const System::Extended Adjustment);
	__int64 __fastcall FixTotalSize(const bool NeedsRecalc);
public:
	/* TList.Destroy */ inline __fastcall virtual ~TCellList(void) { }
	
};


class DELPHICLASS TCells;
class PASCALIMPLEMENTATION TCells : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Tmsuxlsbaserecordlists::TRowRecordList* FRowList;
	TCellList* FCellList;
	void __fastcall WriteDimensions(const Tmsuole2impl::TOle2File* DataStream, const Tmsuflxmessages::TXlsCellRange &CellRange);
	int __fastcall DimensionsSize(void);
	void __fastcall CalcUsedRange(Tmsuflxmessages::TXlsCellRange &CellRange);
	void __fastcall ArrangeCols(void);
	
public:
	__fastcall TCells(const Tmsuxlsworkbookglobals::TWorkbookGlobals* aGlobals, const Tmsuxlscolinfo::TColInfoList* aColInfoList);
	__fastcall virtual ~TCells(void);
	void __fastcall Clear(void);
	void __fastcall CopyFrom(const TCells* aList);
	void __fastcall SaveToStream(const Tmsuole2impl::TOle2File* DataStream);
	void __fastcall SaveRangeToStream(const Tmsuole2impl::TOle2File* DataStream, const Tmsuflxmessages::TXlsCellRange &CellRange);
	__int64 __fastcall TotalSize(void);
	__int64 __fastcall FixTotalSize(const bool NeedsRecalc);
	__int64 __fastcall TotalRangeSize(const Tmsuflxmessages::TXlsCellRange &CellRange);
	void __fastcall FixRows(void);
	void __fastcall InsertAndCopyRows(const int FirstRow, const int LastRow, const int DestRow, const int aCount, const Tmsxlsmessages::TSheetInfo &SheetInfo, const bool OnlyFormulas);
	void __fastcall InsertAndCopyCols(const int FirstCol, const int LastCol, const int DestCol, const int aCount, const Tmsxlsmessages::TSheetInfo &SheetInfo, const bool OnlyFormulas);
	void __fastcall DeleteRows(const System::Word aRow, const System::Word aCount, const Tmsxlsmessages::TSheetInfo &SheetInfo);
	void __fastcall DeleteCols(const System::Word aCol, const System::Word aCount, const Tmsxlsmessages::TSheetInfo &SheetInfo);
	void __fastcall ArrangeInsertRowsAndCols(const int InsRowPos, const int InsRowCount, const int InsColPos, const int InsColCount, const Tmsxlsmessages::TSheetInfo &SheetInfo);
	void __fastcall ArrangeInsertSheet(const Tmsxlsmessages::TSheetInfo &SheetInfo);
	void __fastcall AddRow(const Tmsuxlsbaserecords::TRowRecord* aRecord);
	void __fastcall AddCell(const Tmsuxlsbaserecords::TCellRecord* aRecord, const int aRow);
	void __fastcall AddMultipleCells(const Tmsuxlscellrecords::TMultipleValueRecord* aRecord);
	__property TCellList* CellList = {read=FCellList};
	__property Tmsuxlsbaserecordlists::TRowRecordList* RowList = {read=FRowList};
};


class DELPHICLASS TRangeList;
class PASCALIMPLEMENTATION TRangeList : public Tmsuxlsbaselist::TBaseList
{
	typedef Tmsuxlsbaselist::TBaseList inherited;
	
public:
	Tmsuxlsrangerecords::TRangeEntry* operator[](int index) { return Items[index]; }
	
private:
	Tmsuxlsrangerecords::TRangeEntry* __fastcall GetItems(int index);
	void __fastcall SetItems(int index, const Tmsuxlsrangerecords::TRangeEntry* Value);
	
public:
	__property Tmsuxlsrangerecords::TRangeEntry* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(Tmsuxlsrangerecords::TRangeEntry* aRecord);
	HIDESBASE void __fastcall Insert(int Index, Tmsuxlsrangerecords::TRangeEntry* aRecord);
	void __fastcall CopyFrom(const TRangeList* aRangeList);
	void __fastcall SaveToStream(const Tmsuole2impl::TOle2File* DataStream);
	void __fastcall SaveRangeToStream(const Tmsuole2impl::TOle2File* DataStream, const Tmsuflxmessages::TXlsCellRange &CellRange);
	__int64 __fastcall TotalSize(void);
	__int64 __fastcall TotalRangeSize(const Tmsuflxmessages::TXlsCellRange &CellRange);
	void __fastcall InsertAndCopyRowsOrCols(const int FirstRow, const int LastRow, const int DestRow, const int aCount, const Tmsxlsmessages::TSheetInfo &SheetInfo, const bool UseCols);
	void __fastcall DeleteRowsOrCols(const System::Word aRow, const System::Word aCount, const Tmsxlsmessages::TSheetInfo &SheetInfo, const bool UseCols);
public:
	/* TObjectList.Create */ inline __fastcall TRangeList(void)/* overload */ : Tmsuxlsbaselist::TBaseList() { }
	
public:
	/* TList.Destroy */ inline __fastcall virtual ~TRangeList(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Tmsuxlsrowcolentries */
using namespace Tmsuxlsrowcolentries;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TmsuxlsrowcolentriesHPP
