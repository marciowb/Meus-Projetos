// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'UXlsSheet.pas' rev: 22.00

#ifndef UxlssheetHPP
#define UxlssheetHPP

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
#include <UXlsBaseRecordLists.hpp>	// Pascal unit
#include <UXlsOtherRecords.hpp>	// Pascal unit
#include <UXlsChart.hpp>	// Pascal unit
#include <UXlsSST.hpp>	// Pascal unit
#include <XlsMessages.hpp>	// Pascal unit
#include <UXlsSections.hpp>	// Pascal unit
#include <UXlsCondFmt.hpp>	// Pascal unit
#include <UXlsRowColEntries.hpp>	// Pascal unit
#include <UXlsEscher.hpp>	// Pascal unit
#include <UXlsRangeRecords.hpp>	// Pascal unit
#include <UEscherRecords.hpp>	// Pascal unit
#include <UXlsWorkbookGlobals.hpp>	// Pascal unit
#include <UXlsNotes.hpp>	// Pascal unit
#include <UXlsBaseList.hpp>	// Pascal unit
#include <UFlxMessages.hpp>	// Pascal unit
#include <UXlsCellRecords.hpp>	// Pascal unit
#include <UXlsFormula.hpp>	// Pascal unit
#include <UXlsPageBreaks.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <UXlsColInfo.hpp>	// Pascal unit
#include <UXlsHyperLink.hpp>	// Pascal unit
#include <UOle2Impl.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uxlssheet
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TSheet;
class PASCALIMPLEMENTATION TSheet : public Uxlssections::TBaseSection
{
	typedef Uxlssections::TBaseSection inherited;
	
private:
	bool __fastcall GetShowGridLines(void);
	void __fastcall SetShowGridLines(const bool Value);
	bool __fastcall GetShowGridHeaders(void);
	void __fastcall SetShowGridHeaders(const bool Value);
	bool __fastcall GetPrintGridLines(void);
	void __fastcall SetPrintGridLines(const bool Value);
	System::UnicodeString __fastcall GetPageFooter(void);
	System::UnicodeString __fastcall GetPageHeader(void);
	void __fastcall SetPageFooter(const System::UnicodeString Value);
	void __fastcall SetPageHeader(const System::UnicodeString Value);
	Uflxmessages::TXlsMargins __fastcall GetMargins(void);
	void __fastcall SetMargins(const Uflxmessages::TXlsMargins &Value);
	void __fastcall AddMargin(Uxlsbaserecords::TMarginRecord* &Margin, const int aId, const System::Extended Value);
	int __fastcall GetSheetZoom(void);
	void __fastcall SetSheetZoom(const int Value);
	System::UnicodeString __fastcall GetCodeName(void);
	void __fastcall SetCodeName(const System::UnicodeString Value);
	bool __fastcall GetIsR1C1(void);
	void __fastcall SetIsR1C1(const bool Value);
	bool __fastcall GetWindow2Frozen(void);
	void __fastcall SetWindow2Frozen(const bool value);
	
protected:
	Uxlsworkbookglobals::TWorkbookGlobals* FWorkbookGlobals;
	Uxlsbaserecords::TWindow2Record* FWindow2;
	Uxlsbaserecords::TPageHeaderRecord* FPageHeader;
	Uxlsbaserecords::TPageFooterRecord* FPageFooter;
	Uxlsbaserecords::TPrintGridLinesRecord* FPrintGridLines;
	Uxlsbaserecords::TMarginRecord* FLeftMargin;
	Uxlsbaserecords::TMarginRecord* FRightMargin;
	Uxlsbaserecords::TMarginRecord* FTopMargin;
	Uxlsbaserecords::TMarginRecord* FBottomMargin;
	Uxlsbaserecords::TSetupRecord* FSetup;
	Uxlsbaserecords::TPlsRecord* FPrinterDriverSettings;
	Uxlsbaserecords::TWsBoolRecord* FWSBool;
	Uxlsbaserecords::TPrintCenteredRecord* FHCenter;
	Uxlsbaserecords::TPrintCenteredRecord* FVCenter;
	Uxlsbaserecords::TSCLRecord* FZoom;
	Uxlsotherrecords::TGutsRecord* FGuts;
	Uxlsotherrecords::TPaneRecord* FPane;
	Uxlsbaserecords::TAutoFilterInfoRecord* FAutoFilterInfo;
	Uxlsbaserecords::TRefModeRecord* FRefMode;
	Uxlsbaserecordlists::TBaseRecordList* FPrintRecords;
	Uxlsotherrecords::TCodeNameRecord* FCodeName;
	void __fastcall LoadCachePointers(const Uxlsbaserecords::TBaseRecord* R);
	virtual void __fastcall FixCachePointers(void);
	bool __fastcall GetSelected(void);
	void __fastcall SetSelected(const bool Value);
	virtual void __fastcall SetPageHeaderFooter(const Uxlsbaserecords::TPageHeaderFooterRecord* P, const System::UnicodeString s) = 0 ;
	virtual void __fastcall AddZoomRecord(void) = 0 ;
	virtual void __fastcall AddOrRemovePane(const bool Add);
	__property bool Window2Frozen = {read=GetWindow2Frozen, write=SetWindow2Frozen, nodefault};
	
public:
	Uxlsbaserecords::TDimensionsRec OriginalDimensions;
	TSheet* __fastcall CopyTo(void);
	virtual TSheet* __fastcall DoCopyTo(void);
	virtual void __fastcall InsertAndCopyRowsAndCols(const int FirstRow, const int LastRow, const int DestRow, const int aRowCount, const int FirstCol, const int LastCol, const int DestCol, const int aColCount, const Xlsmessages::TSheetInfo &SheetInfo, const bool OnlyFormulas) = 0 ;
	virtual void __fastcall DeleteRowsAndCols(const System::Word aRow, const System::Word aRowCount, const System::Word aCol, const System::Word aColCount, const Xlsmessages::TSheetInfo &SheetInfo) = 0 ;
	virtual void __fastcall ArrangeInsertRowsAndCols(const int InsRowPos, const int InsRowCount, const int InsColPos, const int InsColCount, const Xlsmessages::TSheetInfo &SheetInfo) = 0 ;
	virtual void __fastcall ArrangeCopySheet(const Xlsmessages::TSheetInfo &SheetInfo);
	virtual void __fastcall Clear(void);
	virtual void __fastcall DeleteHPageBreak(const System::Word aRow);
	virtual void __fastcall DeleteVPageBreak(const System::Word aCol);
	virtual void __fastcall InsertHPageBreak(const System::Word aRow);
	virtual void __fastcall InsertVPageBreak(const System::Word aCol);
	__fastcall virtual TSheet(const Uxlsworkbookglobals::TWorkbookGlobals* aWorkbookGlobals);
	__property bool Selected = {read=GetSelected, write=SetSelected, nodefault};
	__property bool ShowGridLines = {read=GetShowGridLines, write=SetShowGridLines, nodefault};
	__property bool ShowGridHeaders = {read=GetShowGridHeaders, write=SetShowGridHeaders, nodefault};
	__property bool PrintGridLines = {read=GetPrintGridLines, write=SetPrintGridLines, nodefault};
	__property System::UnicodeString PageHeader = {read=GetPageHeader, write=SetPageHeader};
	__property System::UnicodeString PageFooter = {read=GetPageFooter, write=SetPageFooter};
	__property Uflxmessages::TXlsMargins Margins = {read=GetMargins, write=SetMargins};
	__property int SheetZoom = {read=GetSheetZoom, write=SetSheetZoom, nodefault};
	__property bool IsR1C1 = {read=GetIsR1C1, write=SetIsR1C1, nodefault};
	void __fastcall FreezePanes(const int row, const int col);
	void __fastcall GetFrozenPanes(/* out */ int &row, /* out */ int &col);
	void __fastcall GetSplitWindow(/* out */ int &xOffset, /* out */ int &yOffset);
	void __fastcall SplitWindow(const int xOffset, const int yOffset);
	__property System::UnicodeString CodeName = {read=GetCodeName, write=SetCodeName};
	virtual __int64 __fastcall TotalSize(void);
	virtual __int64 __fastcall FixTotalSize(const bool NeedsRecalc);
	virtual __int64 __fastcall TotalRangeSize(const int SheetIndex, const Uflxmessages::TXlsCellRange &CellRange);
	virtual void __fastcall RestoreObjectCoords(void);
	virtual void __fastcall FixRows(void);
public:
	/* TBaseSection.Destroy */ inline __fastcall virtual ~TSheet(void) { }
	
};


typedef TMetaClass* ClassOfTSheet;

class DELPHICLASS TFlxChart;
class PASCALIMPLEMENTATION TFlxChart : public TSheet
{
	typedef TSheet inherited;
	
private:
	Uxlschart::TChartRecordList* FChartRecords;
	void __fastcall LoadSubChart(const Uole2impl::TOle2File* DataStream, Xlsmessages::TRecordHeader &RecordHeader, const Uxlssst::TSST* SST, const int Level);
	
protected:
	virtual void __fastcall SetPageHeaderFooter(const Uxlsbaserecords::TPageHeaderFooterRecord* P, const System::UnicodeString s);
	virtual void __fastcall AddZoomRecord(void);
	virtual void __fastcall FixCachePointers(void);
	
public:
	Uxlsbaserecords::TBaseRecord* RemainingData;
	__fastcall virtual TFlxChart(const Uxlsworkbookglobals::TWorkbookGlobals* aWorkbookGlobals);
	__fastcall virtual ~TFlxChart(void);
	virtual TSheet* __fastcall DoCopyTo(void);
	virtual __int64 __fastcall TotalSize(void);
	virtual __int64 __fastcall TotalRangeSize(const int SheetIndex, const Uflxmessages::TXlsCellRange &CellRange);
	virtual void __fastcall LoadFromStream(const Uole2impl::TOle2File* DataStream, Xlsmessages::TRecordHeader &RecordHeader, const Uxlsotherrecords::TBOFRecord* First, const Uxlssst::TSST* SST);
	virtual void __fastcall SaveToStream(const Uole2impl::TOle2File* DataStream);
	virtual void __fastcall SaveRangeToStream(const Uole2impl::TOle2File* DataStream, const int SheetIndex, const Uflxmessages::TXlsCellRange &CellRange);
	virtual void __fastcall Clear(void);
	void __fastcall ArrangeCopyRowsAndCols(const int RowOffset, const int ColOffset);
	virtual void __fastcall ArrangeCopySheet(const Xlsmessages::TSheetInfo &SheetInfo);
	virtual void __fastcall ArrangeInsertRowsAndCols(const int InsRowPos, const int InsRowCount, const int InsColPos, const int InsColCount, const Xlsmessages::TSheetInfo &SheetInfo);
	virtual void __fastcall InsertAndCopyRowsAndCols(const int FirstRow, const int LastRow, const int DestRow, const int aRowCount, const int FirstCol, const int LastCol, const int DestCol, const int aColCount, const Xlsmessages::TSheetInfo &SheetInfo, const bool OnlyFormulas);
	virtual void __fastcall DeleteRowsAndCols(const System::Word aRow, const System::Word aRowCount, const System::Word aCol, const System::Word aColCount, const Xlsmessages::TSheetInfo &SheetInfo);
};


class DELPHICLASS TSheetRecordList;
class PASCALIMPLEMENTATION TSheetRecordList : public Uxlsbaserecordlists::TBaseRecordList
{
	typedef Uxlsbaserecordlists::TBaseRecordList inherited;
	
public:
	/* TObjectList.Create */ inline __fastcall TSheetRecordList(void)/* overload */ : Uxlsbaserecordlists::TBaseRecordList() { }
	
public:
	/* TList.Destroy */ inline __fastcall virtual ~TSheetRecordList(void) { }
	
};


class DELPHICLASS TChartList;
class PASCALIMPLEMENTATION TChartList : public Uxlsbaselist::TBaseList
{
	typedef Uxlsbaselist::TBaseList inherited;
	
public:
	TFlxChart* operator[](int index) { return Items[index]; }
	
private:
	TFlxChart* __fastcall GetItems(int index);
	void __fastcall SetItems(int index, const TFlxChart* Value);
	
public:
	__property TFlxChart* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(TFlxChart* aRecord);
	HIDESBASE void __fastcall Insert(int Index, TFlxChart* aRecord);
	void __fastcall SaveToStream(const Uole2impl::TOle2File* DataStream);
	void __fastcall ArrangeInsertRowsAndCols(const int InsRowPos, const int InsRowCount, const int InsColPos, const int InsColCount, const Xlsmessages::TSheetInfo &SheetInfo);
public:
	/* TObjectList.Create */ inline __fastcall TChartList(void)/* overload */ : Uxlsbaselist::TBaseList() { }
	
public:
	/* TList.Destroy */ inline __fastcall virtual ~TChartList(void) { }
	
};


class DELPHICLASS TFlxUnsupportedSheet;
class PASCALIMPLEMENTATION TFlxUnsupportedSheet : public TSheet
{
	typedef TSheet inherited;
	
private:
	TSheetRecordList* FSheetRecords;
	
protected:
	virtual void __fastcall SetPageHeaderFooter(const Uxlsbaserecords::TPageHeaderFooterRecord* P, const System::UnicodeString s);
	virtual void __fastcall AddZoomRecord(void);
	virtual void __fastcall FixCachePointers(void);
	
public:
	__fastcall virtual TFlxUnsupportedSheet(const Uxlsworkbookglobals::TWorkbookGlobals* aWorkbookGlobals);
	__fastcall virtual ~TFlxUnsupportedSheet(void);
	virtual TSheet* __fastcall DoCopyTo(void);
	virtual __int64 __fastcall TotalSize(void);
	virtual __int64 __fastcall TotalRangeSize(const int SheetIndex, const Uflxmessages::TXlsCellRange &CellRange);
	virtual void __fastcall LoadFromStream(const Uole2impl::TOle2File* DataStream, Xlsmessages::TRecordHeader &RecordHeader, const Uxlsotherrecords::TBOFRecord* First, const Uxlssst::TSST* SST);
	virtual void __fastcall SaveToStream(const Uole2impl::TOle2File* DataStream);
	virtual void __fastcall SaveRangeToStream(const Uole2impl::TOle2File* DataStream, const int SheetIndex, const Uflxmessages::TXlsCellRange &CellRange);
	virtual void __fastcall Clear(void);
	virtual void __fastcall ArrangeCopySheet(const Xlsmessages::TSheetInfo &SheetInfo);
	virtual void __fastcall ArrangeInsertRowsAndCols(const int InsRowPos, const int InsRowCount, const int InsColPos, const int InsColCount, const Xlsmessages::TSheetInfo &SheetInfo);
	virtual void __fastcall InsertAndCopyRowsAndCols(const int FirstRow, const int LastRow, const int DestRow, const int aRowCount, const int FirstCol, const int LastCol, const int DestCol, const int aColCount, const Xlsmessages::TSheetInfo &SheetInfo, const bool OnlyFormulas);
	virtual void __fastcall DeleteRowsAndCols(const System::Word aRow, const System::Word aRowCount, const System::Word aCol, const System::Word aColCount, const Xlsmessages::TSheetInfo &SheetInfo);
};


class DELPHICLASS TWorkSheet;
class PASCALIMPLEMENTATION TWorkSheet : public TSheet
{
	typedef TSheet inherited;
	
private:
	Uxlsbaserecordlists::TBaseRecordList* FMiscRecords1;
	Uxlsbaserecordlists::TBaseRecordList* FMiscRecords2;
	Uxlspagebreaks::THPageBreakList* FHPageBreaks;
	Uxlspagebreaks::TVPageBreakList* FVPageBreaks;
	Uxlsescher::TDrawing* FDrawing;
	Uxlsrowcolentries::TCells* FCells;
	Uxlsrowcolentries::TRangeList* FRanges;
	Uxlsnotes::TNoteList* FNotes;
	Uxlscolinfo::TColInfoList* FColumns;
	Uxlshyperlink::THLinkList* FHLinks;
	int FDefRowHeight;
	int FDefColWidth;
	int __fastcall GetDrawingRow(int index);
	System::UnicodeString __fastcall GetDrawingName(int index);
	System::Word __fastcall GetPrintNumberOfHorizontalPages(void);
	System::Word __fastcall GetPrintNumberOfVerticalPages(void);
	int __fastcall GetPrintScale(void);
	bool __fastcall GetPrintToFit(void);
	void __fastcall SetPrintNumberOfHorizontalPages(const System::Word Value);
	void __fastcall SetPrintNumberOfVerticalPages(const System::Word Value);
	void __fastcall SetPrintScale(const int Value);
	void __fastcall SetPrintToFit(const bool Value);
	System::Word __fastcall GetPrintOptions(void);
	void __fastcall SetPrintOptions(const System::Word Value);
	int __fastcall GetPrintCopies(void);
	Uflxmessages::TPrinterDriverSettings __fastcall GetPrinterDriverSettings(void);
	int __fastcall GetPrintPaperSize(void);
	int __fastcall GetPrintXResolution(void);
	int __fastcall GetPrintYResolution(void);
	void __fastcall SetPrintCopies(const int Value);
	void __fastcall SetPrinterDriverSettings(const Uflxmessages::TPrinterDriverSettings &Value);
	void __fastcall SetPrintPaperSize(const int Value);
	void __fastcall SetPrintXResolution(const int Value);
	void __fastcall SetPrintYResolution(const int Value);
	int __fastcall GetColOutlineLevel(int col);
	int __fastcall GetRowOutlineLevel(int row);
	void __fastcall SetColOulineLevel(int col, const int Value);
	void __fastcall SetRowOulineLevel(int row, const int Value);
	void __fastcall EnsureGuts(void);
	void __fastcall AddPrinterDriverRecord(const Uxlsbaserecords::TPlsRecord* aPlsRecord, const Uxlsbaserecordlists::TBaseRecordList* FRecords);
	void __fastcall RemovePrinterDriverRecord(void)/* overload */;
	void __fastcall RemovePrinterDriverRecord(const Uxlsbaserecordlists::TBaseRecordList* FRecords)/* overload */;
	bool __fastcall GetOutlineSummaryColsRightOfDetail(void);
	bool __fastcall GetOutlineSummaryRowsBelowDetail(void);
	bool __fastcall GetOutlineAutomaticStyles(void);
	void __fastcall SetOutlineSummaryColsRightOfDetail(const bool value);
	void __fastcall SetOutlineSummaryRowsBelowDetail(const bool value);
	void __fastcall SetOutlineAutomaticStyles(const bool value);
	bool __fastcall GetPrintHCentered(void);
	bool __fastcall GetPrintVCentered(void);
	void __fastcall SetPrintHCentered(const bool Value);
	void __fastcall SetPrintVCentered(const bool Value);
	
protected:
	virtual void __fastcall AddZoomRecord(void);
	virtual void __fastcall SetPageHeaderFooter(const Uxlsbaserecords::TPageHeaderFooterRecord* P, const System::UnicodeString s);
	virtual void __fastcall FixCachePointers(void);
	virtual void __fastcall AddOrRemovePane(const bool Add);
	
public:
	__fastcall virtual TWorkSheet(const Uxlsworkbookglobals::TWorkbookGlobals* aWorkbookGlobals);
	__fastcall TWorkSheet(const Uxlsworkbookglobals::TWorkbookGlobals* aWorkbookGlobals, const Uxlssst::TSST* SST);
	__fastcall virtual ~TWorkSheet(void);
	virtual TSheet* __fastcall DoCopyTo(void);
	virtual __int64 __fastcall TotalSize(void);
	virtual __int64 __fastcall TotalRangeSize(const int SheetIndex, const Uflxmessages::TXlsCellRange &CellRange);
	virtual void __fastcall LoadFromStream(const Uole2impl::TOle2File* DataStream, Xlsmessages::TRecordHeader &RecordHeader, const Uxlsotherrecords::TBOFRecord* First, const Uxlssst::TSST* SST);
	virtual void __fastcall SaveToStream(const Uole2impl::TOle2File* DataStream);
	virtual void __fastcall SaveRangeToStream(const Uole2impl::TOle2File* DataStream, const int SheetIndex, const Uflxmessages::TXlsCellRange &CellRange);
	virtual void __fastcall Clear(void);
	virtual void __fastcall InsertAndCopyRowsAndCols(const int FirstRow, const int LastRow, const int DestRow, const int aRowCount, const int FirstCol, const int LastCol, const int DestCol, const int aColCount, const Xlsmessages::TSheetInfo &SheetInfo, const bool OnlyFormulas);
	virtual void __fastcall DeleteRowsAndCols(const System::Word aRow, const System::Word aRowCount, const System::Word aCol, const System::Word aColCount, const Xlsmessages::TSheetInfo &SheetInfo);
	virtual void __fastcall ArrangeInsertRowsAndCols(const int InsRowPos, const int InsRowCount, const int InsColPos, const int InsColCount, const Xlsmessages::TSheetInfo &SheetInfo);
	virtual void __fastcall ArrangeCopySheet(const Xlsmessages::TSheetInfo &SheetInfo);
	void __fastcall ClearValues(void);
	__property Uxlsnotes::TNoteList* Notes = {read=FNotes};
	__property Uxlsrowcolentries::TCells* Cells = {read=FCells};
	__property Uxlshyperlink::THLinkList* HLinks = {read=FHLinks};
	int __fastcall DrawingCount(void);
	void __fastcall AssignDrawing(const int Index, const Uflxmessages::ByteArray Data, const Uflxmessages::TXlsImgTypes DataType);
	void __fastcall GetDrawingFromStream(const int Index, const Classes::TStream* Data, Uflxmessages::TXlsImgTypes &DataType);
	__property int DrawingRow[int index] = {read=GetDrawingRow};
	__property System::UnicodeString DrawingName[int index] = {read=GetDrawingName};
	Uflxmessages::TClientAnchor __fastcall GetAnchor(const int Index);
	void __fastcall SetAnchor(const int Index, const Uflxmessages::TClientAnchor &aAnchor);
	void __fastcall DeleteImage(const int Index);
	void __fastcall ClearImage(const int Index);
	void __fastcall AddImage(const Uflxmessages::ByteArray Data, const Uflxmessages::TXlsImgTypes DataType, const Uflxmessages::TImageProperties &Properties, const Uflxmessages::TFlxAnchorType Anchor);
	void __fastcall AddNewComment(const int Row, const int Col, const System::UnicodeString Txt, const Uflxmessages::TImageProperties &Properties);
	virtual void __fastcall DeleteHPageBreak(const System::Word aRow);
	virtual void __fastcall DeleteVPageBreak(const System::Word aCol);
	virtual void __fastcall InsertHPageBreak(const System::Word aRow);
	virtual void __fastcall InsertVPageBreak(const System::Word aCol);
	int __fastcall GetRowHeight(const int aRow)/* overload */;
	int __fastcall GetRowHeight(const int aRow, const bool HiddenIsZero)/* overload */;
	int __fastcall GetColWidth(const System::Word aCol)/* overload */;
	int __fastcall GetColWidth(const System::Word aCol, const bool HiddenIsZero)/* overload */;
	void __fastcall SetRowHeight(const int aRow, const int Value);
	void __fastcall SetColWidth(const System::Word aCol, const int Value);
	bool __fastcall GetRowHidden(const int aRow);
	bool __fastcall GetColHidden(const System::Word aCol);
	void __fastcall SetRowHidden(const int aRow, const bool Value);
	void __fastcall SetColHidden(const System::Word aCol, const bool Value);
	__property int DefRowHeight = {read=FDefRowHeight, nodefault};
	__property int DefColWidth = {read=FDefColWidth, nodefault};
	int __fastcall GetRowFormat(const int aRow);
	int __fastcall GetColFormat(const int aCol);
	void __fastcall SetRowFormat(const int aRow, const int Value);
	void __fastcall SetColFormat(const int aCol, const int Value);
	Uflxmessages::TXlsCellRange __fastcall CellMergedBounds(const int aRow, const int aCol);
	Uflxmessages::TXlsCellRange __fastcall CellMergedList(const int index);
	int __fastcall CellMergedListCount(void);
	void __fastcall MergeCells(int aRow1, int aCol1, int aRow2, int aCol2);
	void __fastcall UnMergeCells(int aRow1, int aCol1, int aRow2, int aCol2);
	bool __fastcall HasHPageBreak(const int Row);
	bool __fastcall HasVPageBreak(const int Col);
	__property bool PrintToFit = {read=GetPrintToFit, write=SetPrintToFit, nodefault};
	__property bool PrintHCentered = {read=GetPrintHCentered, write=SetPrintHCentered, nodefault};
	__property bool PrintVCentered = {read=GetPrintVCentered, write=SetPrintVCentered, nodefault};
	__property int PrintScale = {read=GetPrintScale, write=SetPrintScale, nodefault};
	__property System::Word PrintNumberOfHorizontalPages = {read=GetPrintNumberOfHorizontalPages, write=SetPrintNumberOfHorizontalPages, nodefault};
	__property System::Word PrintNumberOfVerticalPages = {read=GetPrintNumberOfVerticalPages, write=SetPrintNumberOfVerticalPages, nodefault};
	__property System::Word PrintOptions = {read=GetPrintOptions, write=SetPrintOptions, nodefault};
	__property int PrintPaperSize = {read=GetPrintPaperSize, write=SetPrintPaperSize, nodefault};
	__property int PrintCopies = {read=GetPrintCopies, write=SetPrintCopies, nodefault};
	__property int PrintXResolution = {read=GetPrintXResolution, write=SetPrintXResolution, nodefault};
	__property int PrintYResolution = {read=GetPrintYResolution, write=SetPrintYResolution, nodefault};
	__property Uflxmessages::TPrinterDriverSettings PrinterDriverSettings = {read=GetPrinterDriverSettings, write=SetPrinterDriverSettings};
	__fastcall TWorkSheet(const Uxlssst::TSST* SST);
	__property int RowOutlineLevel[int row] = {read=GetRowOutlineLevel, write=SetRowOulineLevel};
	__property int ColOutlineLevel[int col] = {read=GetColOutlineLevel, write=SetColOulineLevel};
	__property bool OutlineSummaryRowsBelowDetail = {read=GetOutlineSummaryRowsBelowDetail, write=SetOutlineSummaryRowsBelowDetail, nodefault};
	__property bool OutlineSummaryColsRightOfDetail = {read=GetOutlineSummaryColsRightOfDetail, write=SetOutlineSummaryColsRightOfDetail, nodefault};
	__property bool OutlineAutomaticStyles = {read=GetOutlineAutomaticStyles, write=SetOutlineAutomaticStyles, nodefault};
	virtual void __fastcall RestoreObjectCoords(void);
	void __fastcall RecalcRowHeights(const void * Workbook, const int Row1, const int Row2, const bool Forced, const bool KeepAutoFit, const System::Extended Adjustment);
	void __fastcall RecalcColWidths(const void * Workbook, const int Col1, const int Col2, const bool IgnoreStrings, const System::Extended Adjustment);
	void __fastcall SetAutoFilter(const int SheetIndex, const int Row, const int Col1, const int Col2);
	void __fastcall RemoveAutoFilter(void);
	bool __fastcall HasAutoFilter(void)/* overload */;
	bool __fastcall HasAutoFilter(const int sheet, const int row, const int col)/* overload */;
	Uflxmessages::TXlsCellRange __fastcall GetAutoFilterRange(const int Sheet);
	virtual void __fastcall FixRows(void);
	virtual __int64 __fastcall FixTotalSize(const bool NeedsRecalc);
};


//-- var, const, procedure ---------------------------------------------------
#define RESOURCE_EMPTYSHEET L"FLXEMPTYSHEET"

}	/* namespace Uxlssheet */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Uxlssheet;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UxlssheetHPP
