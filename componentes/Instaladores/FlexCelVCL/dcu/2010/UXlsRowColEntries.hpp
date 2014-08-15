// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uxlsrowcolentries.pas' rev: 21.00

#ifndef UxlsrowcolentriesHPP
#define UxlsrowcolentriesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Uxlsbaserecords.hpp>	// Pascal unit
#include <Uxlsbaserecordlists.hpp>	// Pascal unit
#include <Uxlsotherrecords.hpp>	// Pascal unit
#include <Xlsmessages.hpp>	// Pascal unit
#include <Uxlsrangerecords.hpp>	// Pascal unit
#include <Uxlsbaselist.hpp>	// Pascal unit
#include <Uxlscellrecords.hpp>	// Pascal unit
#include <Uxlsformula.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Uxlssst.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit
#include <Uxlscolinfo.hpp>	// Pascal unit
#include <Uxlsreferences.hpp>	// Pascal unit
#include <Uxlsworkbookglobals.hpp>	// Pascal unit
#include <Uxlstokenarray.hpp>	// Pascal unit
#include <Xlsformulamessages.hpp>	// Pascal unit
#include <Uflxnumberformat.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Uflxformats.hpp>	// Pascal unit
#include <Uole2impl.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uxlsrowcolentries
{
//-- type declarations -------------------------------------------------------
typedef TMetaClass* TListClass;

typedef DynamicArray<Uflxformats::TFlxFont> TFlxFontArray;

typedef DynamicArray<int> TIntegerArray;

class DELPHICLASS TColWidthCalc;
class PASCALIMPLEMENTATION TColWidthCalc : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TFlxFontArray XFFonts;
	Uxlsworkbookglobals::TWorkbookGlobals* Wg;
	Graphics::TBitmap* bmp;
	Graphics::TCanvas* Canvas;
	void __fastcall InitXF(void);
	
public:
	__fastcall TColWidthCalc(const Uxlsworkbookglobals::TWorkbookGlobals* aWg);
	int __fastcall CalcCellWidth(const int Row, const int Col, const Uflxmessages::TRichString &val, const int XF, const void * Workbook, const System::Extended RowMultDisplay, const System::Extended ColMultDisplay);
	__fastcall virtual ~TColWidthCalc(void);
};


class DELPHICLASS TBaseRowColList;
class PASCALIMPLEMENTATION TBaseRowColList : public Uxlsbaselist::TBaseList
{
	typedef Uxlsbaselist::TBaseList inherited;
	
public:
	Uxlsbaserecordlists::TBaseRowColRecordList* operator[](int index) { return Items[index]; }
	
private:
	Uxlsbaserecordlists::TBaseRowColRecordList* __fastcall GetItems(int index);
	void __fastcall SetItems(int index, const Uxlsbaserecordlists::TBaseRowColRecordList* Value);
	
public:
	__property Uxlsbaserecordlists::TBaseRowColRecordList* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(Uxlsbaserecordlists::TBaseRowColRecordList* aRecord);
	HIDESBASE void __fastcall Insert(int Index, Uxlsbaserecordlists::TBaseRowColRecordList* aRecord);
	
protected:
	TListClass ListClass;
	
public:
	void __fastcall AddRecord(const Uxlsbaserecords::TBaseRowColRecord* aRecord, const int aRow);
	void __fastcall CopyFrom(const TBaseRowColList* aList);
	void __fastcall SaveToStream(const Uole2impl::TOle2File* DataStream);
	void __fastcall SaveRangeToStream(const Uole2impl::TOle2File* DataStream, const Uflxmessages::TXlsCellRange &CellRange);
	__int64 __fastcall TotalSize(void);
	__int64 __fastcall TotalRangeSize(const Uflxmessages::TXlsCellRange &CellRange);
	void __fastcall InsertAndCopyRows(const int FirstRow, const int LastRow, const int DestRow, const int aCount, const Xlsmessages::TSheetInfo &SheetInfo, const bool OnlyFormulas);
	virtual void __fastcall InsertAndCopyCols(const int FirstCol, const int LastCol, const int DestCol, const int aCount, const Xlsmessages::TSheetInfo &SheetInfo, const bool OnlyFormulas);
	void __fastcall DeleteRows(const System::Word aRow, const System::Word aCount, const Xlsmessages::TSheetInfo &SheetInfo);
	void __fastcall DeleteCols(const System::Word aCol, const System::Word aCount, const Xlsmessages::TSheetInfo &SheetInfo);
	virtual void __fastcall ArrangeInsertRowsAndCols(const int InsRowPos, const int InsRowCount, const int InsColPos, const int InsColCount, const Xlsmessages::TSheetInfo &SheetInfo);
	__fastcall TBaseRowColList(const TListClass aListClass);
public:
	/* TList.Destroy */ inline __fastcall virtual ~TBaseRowColList(void) { }
	
};


class DELPHICLASS TCellList;
class PASCALIMPLEMENTATION TCellList : public TBaseRowColList
{
	typedef TBaseRowColList inherited;
	
public:
	Uxlsbaserecordlists::TCellRecordList* operator[](int index) { return Items[index]; }
	
private:
	Uxlsworkbookglobals::TWorkbookGlobals* FGlobals;
	Uxlsbaserecordlists::TRowRecordList* FRowRecordList;
	Uxlscolinfo::TColInfoList* FColInfoList;
	Uflxmessages::TXlsCellValue __fastcall GetValue(int Row, int Col);
	void __fastcall FixFormulaTokens(const Uxlsformula::TFormulaRecord* Formula, const Uxlsbaserecordlists::TShrFmlaRecordList* ShrFmlas);
	System::UnicodeString __fastcall GetFormula(int Row, int Col);
	void __fastcall SetFormula(int Row, int Col, const System::UnicodeString Value);
	void __fastcall AutofitColumn(const void * Workbook, const int Column, const TColWidthCalc* ColCalc, const System::Extended RowMultDisplay, const System::Extended ColMultDisplay, const bool IgnoreStrings, const System::Extended Adjustment);
	HIDESBASE Uxlsbaserecordlists::TCellRecordList* __fastcall GetItems(int index);
	HIDESBASE void __fastcall SetItems(int index, const Uxlsbaserecordlists::TCellRecordList* Value);
	
public:
	__property Uxlsbaserecordlists::TCellRecordList* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(Uxlsbaserecordlists::TCellRecordList* aRecord);
	HIDESBASE void __fastcall Insert(int Index, Uxlsbaserecordlists::TCellRecordList* aRecord);
	__fastcall TCellList(const Uxlsworkbookglobals::TWorkbookGlobals* aGlobals, const Uxlsbaserecordlists::TRowRecordList* aRowRecordList, const Uxlscolinfo::TColInfoList* aColInfoList);
	__property Uflxmessages::TXlsCellValue Value[int Row][int Col] = {read=GetValue};
	void __fastcall SetValueX2(const int Row, const int Col, const Uflxmessages::TXlsCellValue &Value, const Uflxmessages::TRTFRunList RTFRuns, const bool Options1904);
	void __fastcall GetValueX2(const int Row, const int Col, /* out */ Uflxmessages::TXlsCellValue &V, /* out */ Uflxmessages::TRTFRunList &RTFRuns);
	void __fastcall SetFormat(const int Row, const int Col, const int XF);
	__property System::UnicodeString Formula[int Row][int Col] = {read=GetFormula, write=SetFormula};
	void __fastcall AssignFormulaX(const int Row, const int Col, const System::UnicodeString Formula, const System::Variant &Value, const bool Options1904);
	Xlsmessages::PArrayOfByte __fastcall ArrayFormula(const int Row, const int Col);
	Xlsmessages::PArrayOfByte __fastcall TableFormula(const int Row, const int Col);
	void __fastcall FixFormulas(const Uxlsbaserecordlists::TShrFmlaRecordList* ShrFmlas);
	System::UnicodeString __fastcall GetSheetName(const int SheetNumber);
	int __fastcall AddExternSheet(const int FirstSheet, const int LastSheet);
	bool __fastcall FindSheet(System::UnicodeString SheetName, /* out */ int &SheetIndex);
	virtual void __fastcall InsertAndCopyCols(const int FirstCol, const int LastCol, const int DestCol, const int aCount, const Xlsmessages::TSheetInfo &SheetInfo, const bool OnlyFormulas);
	virtual void __fastcall ArrangeInsertRowsAndCols(const int InsRowPos, const int InsRowCount, const int InsColPos, const int InsColCount, const Xlsmessages::TSheetInfo &SheetInfo);
	void __fastcall ArrangeInsertSheet(const Xlsmessages::TSheetInfo &SheetInfo);
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
	Uxlsbaserecordlists::TRowRecordList* FRowList;
	TCellList* FCellList;
	void __fastcall WriteDimensions(const Uole2impl::TOle2File* DataStream, const Uflxmessages::TXlsCellRange &CellRange);
	int __fastcall DimensionsSize(void);
	void __fastcall CalcUsedRange(Uflxmessages::TXlsCellRange &CellRange);
	void __fastcall ArrangeCols(void);
	
public:
	__fastcall TCells(const Uxlsworkbookglobals::TWorkbookGlobals* aGlobals, const Uxlscolinfo::TColInfoList* aColInfoList);
	__fastcall virtual ~TCells(void);
	void __fastcall Clear(void);
	void __fastcall CopyFrom(const TCells* aList);
	void __fastcall SaveToStream(const Uole2impl::TOle2File* DataStream);
	void __fastcall SaveRangeToStream(const Uole2impl::TOle2File* DataStream, const Uflxmessages::TXlsCellRange &CellRange);
	__int64 __fastcall TotalSize(void);
	__int64 __fastcall FixTotalSize(const bool NeedsRecalc);
	__int64 __fastcall TotalRangeSize(const Uflxmessages::TXlsCellRange &CellRange);
	void __fastcall FixRows(void);
	void __fastcall InsertAndCopyRows(const int FirstRow, const int LastRow, const int DestRow, const int aCount, const Xlsmessages::TSheetInfo &SheetInfo, const bool OnlyFormulas);
	void __fastcall InsertAndCopyCols(const int FirstCol, const int LastCol, const int DestCol, const int aCount, const Xlsmessages::TSheetInfo &SheetInfo, const bool OnlyFormulas);
	void __fastcall DeleteRows(const System::Word aRow, const System::Word aCount, const Xlsmessages::TSheetInfo &SheetInfo);
	void __fastcall DeleteCols(const System::Word aCol, const System::Word aCount, const Xlsmessages::TSheetInfo &SheetInfo);
	void __fastcall ArrangeInsertRowsAndCols(const int InsRowPos, const int InsRowCount, const int InsColPos, const int InsColCount, const Xlsmessages::TSheetInfo &SheetInfo);
	void __fastcall ArrangeInsertSheet(const Xlsmessages::TSheetInfo &SheetInfo);
	void __fastcall AddRow(const Uxlsbaserecords::TRowRecord* aRecord);
	void __fastcall AddCell(const Uxlsbaserecords::TCellRecord* aRecord, const int aRow);
	void __fastcall AddMultipleCells(const Uxlscellrecords::TMultipleValueRecord* aRecord);
	__property TCellList* CellList = {read=FCellList};
	__property Uxlsbaserecordlists::TRowRecordList* RowList = {read=FRowList};
};


class DELPHICLASS TRangeList;
class PASCALIMPLEMENTATION TRangeList : public Uxlsbaselist::TBaseList
{
	typedef Uxlsbaselist::TBaseList inherited;
	
public:
	Uxlsrangerecords::TRangeEntry* operator[](int index) { return Items[index]; }
	
private:
	Uxlsrangerecords::TRangeEntry* __fastcall GetItems(int index);
	void __fastcall SetItems(int index, const Uxlsrangerecords::TRangeEntry* Value);
	
public:
	__property Uxlsrangerecords::TRangeEntry* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(Uxlsrangerecords::TRangeEntry* aRecord);
	HIDESBASE void __fastcall Insert(int Index, Uxlsrangerecords::TRangeEntry* aRecord);
	void __fastcall CopyFrom(const TRangeList* aRangeList);
	void __fastcall SaveToStream(const Uole2impl::TOle2File* DataStream);
	void __fastcall SaveRangeToStream(const Uole2impl::TOle2File* DataStream, const Uflxmessages::TXlsCellRange &CellRange);
	__int64 __fastcall TotalSize(void);
	__int64 __fastcall TotalRangeSize(const Uflxmessages::TXlsCellRange &CellRange);
	void __fastcall InsertAndCopyRowsOrCols(const int FirstRow, const int LastRow, const int DestRow, const int aCount, const Xlsmessages::TSheetInfo &SheetInfo, const bool UseCols);
	void __fastcall DeleteRowsOrCols(const System::Word aRow, const System::Word aCount, const Xlsmessages::TSheetInfo &SheetInfo, const bool UseCols);
public:
	/* TObjectList.Create */ inline __fastcall TRangeList(void)/* overload */ : Uxlsbaselist::TBaseList() { }
	
public:
	/* TList.Destroy */ inline __fastcall virtual ~TRangeList(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uxlsrowcolentries */
using namespace Uxlsrowcolentries;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UxlsrowcolentriesHPP
