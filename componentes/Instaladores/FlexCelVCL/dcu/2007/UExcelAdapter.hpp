// CodeGear C++Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uexceladapter.pas' rev: 11.00

#ifndef UexceladapterHPP
#define UexceladapterHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit
#include <Uflxformats.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uexceladapter
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TExcelFile;
class PASCALIMPLEMENTATION TExcelFile : public System::TObject 
{
	typedef System::TObject inherited;
	
protected:
	virtual Variant __fastcall GetCellValue(int aRow, int aCol) = 0 ;
	virtual void __fastcall SetCellValue(int aRow, int aCol, const Variant &Value) = 0 ;
	virtual Uflxmessages::TXlsCellValue __fastcall GetCellValueX(int aRow, int aCol) = 0 ;
	virtual void __fastcall SetCellValueX(int aRow, int aCol, const Uflxmessages::TXlsCellValue &Value) = 0 ;
	virtual WideString __fastcall GetCellFormula(int aRow, int aCol) = 0 ;
	virtual void __fastcall SetCellFormula(int aRow, int aCol, const WideString Value) = 0 ;
	virtual int __fastcall GetCommentsCount(int Row) = 0 ;
	virtual WideString __fastcall GetCommentText(int Row, int aPos) = 0 ;
	virtual int __fastcall GetCommentColumn(int Row, int aPos) = 0 ;
	virtual WideString __fastcall GetPictureName(int Row, int aPos) = 0 ;
	virtual int __fastcall GetPicturesCount(int Row) = 0 ;
	virtual int __fastcall GetExcelNameCount(void) = 0 ;
	virtual WideString __fastcall GetRangeName(int index) = 0 ;
	virtual int __fastcall GetRangeR1(int index) = 0 ;
	virtual int __fastcall GetRangeR2(int index) = 0 ;
	virtual int __fastcall GetRangeC1(int index) = 0 ;
	virtual int __fastcall GetRangeC2(int index) = 0 ;
	virtual void __fastcall SetRangeR1(int index, int value) = 0 ;
	virtual void __fastcall SetRangeR2(int index, int value) = 0 ;
	virtual void __fastcall SetRangeC1(int index, int value) = 0 ;
	virtual void __fastcall SetRangeC2(int index, int value) = 0 ;
	virtual int __fastcall GetRangeSheet(int index) = 0 ;
	virtual int __fastcall GetActiveSheet(void) = 0 ;
	virtual void __fastcall SetActiveSheet(const int Value) = 0 ;
	virtual WideString __fastcall GetActiveSheetName(void) = 0 ;
	virtual void __fastcall SetActiveSheetName(const WideString Value) = 0 ;
	virtual WideString __fastcall GetActiveSheetCodeName(void) = 0 ;
	virtual void __fastcall SetActiveSheetCodeName(const WideString Value) = 0 ;
	virtual Uflxmessages::TXlsSheetVisible __fastcall GetActiveSheetVisible(void) = 0 ;
	virtual void __fastcall SetActiveSheetVisible(const Uflxmessages::TXlsSheetVisible Value) = 0 ;
	virtual int __fastcall GetColumnWidth(int aCol) = 0 ;
	virtual int __fastcall GetColumnWidthHiddenIsZero(int aCol) = 0 ;
	virtual int __fastcall GetRowHeight(int aRow) = 0 ;
	virtual int __fastcall GetRowHeightHiddenIsZero(int aRow) = 0 ;
	virtual void __fastcall SetColumnWidth(int aCol, const int Value) = 0 ;
	virtual void __fastcall SetRowHeight(int aRow, const int Value) = 0 ;
	virtual bool __fastcall GetRowHidden(const int aRow) = 0 ;
	virtual bool __fastcall GetColumnHidden(const int aCol) = 0 ;
	virtual void __fastcall SetRowHidden(const int aRow, const bool Value) = 0 ;
	virtual void __fastcall SetColumnHidden(const int aCol, const bool Value) = 0 ;
	virtual int __fastcall GetDefaultColWidth(void) = 0 ;
	virtual int __fastcall GetDefaultRowHeight(void) = 0 ;
	virtual bool __fastcall GetAutoRowHeight(int Row) = 0 ;
	virtual void __fastcall SetAutoRowHeight(int Row, const bool Value) = 0 ;
	virtual int __fastcall GetColumnFormat(int aColumn) = 0 ;
	virtual int __fastcall GetRowFormat(int aRow) = 0 ;
	virtual void __fastcall SetColumnFormat(int aColumn, const int Value) = 0 ;
	virtual void __fastcall SetRowFormat(int aRow, const int Value) = 0 ;
	virtual int __fastcall GetCellFormat(int aRow, int aCol) = 0 ;
	virtual void __fastcall SetCellFormat(int aRow, int aCol, const int Value) = 0 ;
	virtual unsigned __fastcall GetColorPalette(Uflxmessages::TColorPaletteRange Index) = 0 ;
	virtual void __fastcall SetColorPalette(Uflxmessages::TColorPaletteRange Index, const unsigned Value) = 0 ;
	virtual Uflxformats::TFlxFont __fastcall GetFontList(int index) = 0 ;
	virtual void __fastcall SetFontList(int index, const Uflxformats::TFlxFont &Value) = 0 ;
	virtual Uflxformats::TFlxFormat __fastcall GetFormatList(int index) = 0 ;
	virtual void __fastcall SetFormatList(int index, const Uflxformats::TFlxFormat &Value) = 0 ;
	virtual WideString __fastcall GetPageFooter(void) = 0 ;
	virtual WideString __fastcall GetPageHeader(void) = 0 ;
	virtual void __fastcall SetPageFooter(const WideString Value) = 0 ;
	virtual void __fastcall SetPageHeader(const WideString Value) = 0 ;
	virtual bool __fastcall GetShowGridLines(void) = 0 ;
	virtual void __fastcall SetShowGridLines(const bool Value) = 0 ;
	virtual bool __fastcall GetShowGridHeaders(void) = 0 ;
	virtual void __fastcall SetShowGridHeaders(const bool Value) = 0 ;
	virtual bool __fastcall GetPrintGridLines(void) = 0 ;
	virtual void __fastcall SetPrintGridLines(const bool Value) = 0 ;
	virtual int __fastcall GetSheetZoom(void) = 0 ;
	virtual void __fastcall SetSheetZoom(const int Value) = 0 ;
	virtual Uflxmessages::TXlsMargins __fastcall GetMargins(void) = 0 ;
	virtual void __fastcall SetMargins(const Uflxmessages::TXlsMargins &Value) = 0 ;
	virtual Word __fastcall GetPrintNumberOfHorizontalPages(void) = 0 ;
	virtual Word __fastcall GetPrintNumberOfVerticalPages(void) = 0 ;
	virtual int __fastcall GetPrintScale(void) = 0 ;
	virtual Byte __fastcall GetPrintOptions(void) = 0 ;
	virtual bool __fastcall GetPrintToFit(void) = 0 ;
	virtual void __fastcall SetPrintNumberOfHorizontalPages(const Word Value) = 0 ;
	virtual void __fastcall SetPrintNumberOfVerticalPages(const Word Value) = 0 ;
	virtual void __fastcall SetPrintScale(const int Value) = 0 ;
	virtual void __fastcall SetPrintOptions(const Byte Value) = 0 ;
	virtual void __fastcall SetPrintToFit(const bool Value) = 0 ;
	virtual bool __fastcall GetPrintHCentered(void) = 0 ;
	virtual bool __fastcall GetPrintVCentered(void) = 0 ;
	virtual void __fastcall SetPrintHCentered(const bool Value) = 0 ;
	virtual void __fastcall SetPrintVCentered(const bool Value) = 0 ;
	virtual int __fastcall GetPrintCopies(void) = 0 ;
	virtual Uflxmessages::TPrinterDriverSettings __fastcall GetPrinterDriverSettings(void) = 0 ;
	virtual int __fastcall GetPrintPaperSize(void) = 0 ;
	virtual int __fastcall GetPrintXResolution(void) = 0 ;
	virtual int __fastcall GetPrintYResolution(void) = 0 ;
	virtual void __fastcall SetPrintCopies(const int Value) = 0 ;
	virtual void __fastcall SetPrinterDriverSettings(const Uflxmessages::TPrinterDriverSettings &Value) = 0 ;
	virtual void __fastcall SetPrintPaperSize(const int Value) = 0 ;
	virtual void __fastcall SetPrintXResolution(const int Value) = 0 ;
	virtual void __fastcall SetPrintYResolution(const int Value) = 0 ;
	virtual bool __fastcall GetInvalidateFormulas(void) = 0 ;
	virtual void __fastcall SetInvalidateFormulas(const bool Value) = 0 ;
	virtual bool __fastcall GetIsXltTemplate(void) = 0 ;
	virtual void __fastcall SetIsXltTemplate(const bool Value) = 0 ;
	virtual Uflxmessages::TXlsCellRange __fastcall GetCellMergedBounds(int aRow, int aCol) = 0 ;
	virtual Uflxmessages::TXlsCellRange __fastcall GetCellMergedList(int index) = 0 ;
	virtual bool __fastcall GetOptions1904Dates(void) = 0 ;
	virtual bool __fastcall GetOptionsR1C1(void) = 0 ;
	virtual bool __fastcall GetOptionsSaveExternalLinkValues(void) = 0 ;
	virtual void __fastcall SetOptions1904Dates(const bool Value) = 0 ;
	virtual void __fastcall SetOptionsR1C1(const bool Value) = 0 ;
	virtual void __fastcall SetOptionsSaveExternalLinkValues(const bool Value) = 0 ;
	virtual bool __fastcall GetOptionsPrecisionAsDisplayed(void) = 0 ;
	virtual void __fastcall SetOptionsPrecisionAsDisplayed(const bool Value) = 0 ;
	virtual bool __fastcall GetOutlineSummaryColsRightOfDetail(void) = 0 ;
	virtual bool __fastcall GetOutlineSummaryRowsBelowDetail(void) = 0 ;
	virtual bool __fastcall GetOutlineAutomaticStyles(void) = 0 ;
	virtual void __fastcall SetOutlineSummaryColsRightOfDetail(const bool Value) = 0 ;
	virtual void __fastcall SetOutlineSummaryRowsBelowDetail(const bool Value) = 0 ;
	virtual void __fastcall SetOutlineAutomaticStyles(const bool Value) = 0 ;
	
public:
	virtual void __fastcall Connect(void) = 0 ;
	virtual void __fastcall Disconnect(void) = 0 ;
	virtual void __fastcall OpenFile(const AnsiString FileName) = 0 ;
	virtual void __fastcall OpenFileAndSearch(const AnsiString FileName) = 0 ;
	virtual void __fastcall NewFile(const int SheetCount = 0x3) = 0 ;
	virtual void __fastcall LoadFromStream(const Classes::TStream* Stream) = 0 ;
	virtual void __fastcall CloseFile(void) = 0 ;
	__property int ActiveSheet = {read=GetActiveSheet, write=SetActiveSheet, nodefault};
	virtual void __fastcall InsertAndCopySheets(const int CopyFrom, const int InsertBefore, const int SheetCount) = 0 ;
	virtual void __fastcall ClearSheet(void) = 0 ;
	virtual void __fastcall DeleteSheet(int aSheetCount) = 0 ;
	virtual int __fastcall SheetCount(void) = 0 ;
	__property WideString ActiveSheetName = {read=GetActiveSheetName, write=SetActiveSheetName};
	__property WideString ActiveSheetCodeName = {read=GetActiveSheetCodeName, write=SetActiveSheetCodeName};
	__property Uflxmessages::TXlsSheetVisible ActiveSheetVisible = {read=GetActiveSheetVisible, write=SetActiveSheetVisible, nodefault};
	virtual void __fastcall SelectSheet(const int SheetNo) = 0 ;
	__property WideString PageHeader = {read=GetPageHeader, write=SetPageHeader};
	__property WideString PageFooter = {read=GetPageFooter, write=SetPageFooter};
	__property bool ShowGridLines = {read=GetShowGridLines, write=SetShowGridLines, nodefault};
	__property bool ShowGridHeaders = {read=GetShowGridHeaders, write=SetShowGridHeaders, nodefault};
	__property bool PrintGridLines = {read=GetPrintGridLines, write=SetPrintGridLines, nodefault};
	__property int SheetZoom = {read=GetSheetZoom, write=SetSheetZoom, nodefault};
	__property Uflxmessages::TXlsMargins Margins = {read=GetMargins, write=SetMargins};
	__property bool PrintToFit = {read=GetPrintToFit, write=SetPrintToFit, nodefault};
	__property Byte PrintOptions = {read=GetPrintOptions, write=SetPrintOptions, nodefault};
	__property int PrintScale = {read=GetPrintScale, write=SetPrintScale, nodefault};
	__property Word PrintNumberOfHorizontalPages = {read=GetPrintNumberOfHorizontalPages, write=SetPrintNumberOfHorizontalPages, nodefault};
	__property Word PrintNumberOfVerticalPages = {read=GetPrintNumberOfVerticalPages, write=SetPrintNumberOfVerticalPages, nodefault};
	__property bool PrintHCentered = {read=GetPrintHCentered, write=SetPrintHCentered, nodefault};
	__property bool PrintVCentered = {read=GetPrintVCentered, write=SetPrintVCentered, nodefault};
	__property int PrintPaperSize = {read=GetPrintPaperSize, write=SetPrintPaperSize, nodefault};
	__property int PrintCopies = {read=GetPrintCopies, write=SetPrintCopies, nodefault};
	__property int PrintXResolution = {read=GetPrintXResolution, write=SetPrintXResolution, nodefault};
	__property int PrintYResolution = {read=GetPrintYResolution, write=SetPrintYResolution, nodefault};
	__property Uflxmessages::TPrinterDriverSettings PrinterDriverSettings = {read=GetPrinterDriverSettings, write=SetPrinterDriverSettings};
	virtual void __fastcall DeleteMarkedRows(const WideString Mark) = 0 ;
	virtual void __fastcall MakePageBreaks(const WideString Mark) = 0 ;
	virtual void __fastcall InsertHPageBreak(const int Row) = 0 ;
	virtual void __fastcall InsertVPageBreak(const int Col) = 0 ;
	virtual void __fastcall DeleteHPageBreak(const int Row) = 0 ;
	virtual void __fastcall DeleteVPageBreak(const int Col) = 0 ;
	virtual bool __fastcall HasHPageBreak(const int Row) = 0 ;
	virtual bool __fastcall HasVPageBreak(const int Col) = 0 ;
	virtual void __fastcall RefreshPivotTables(void) = 0 ;
	virtual void __fastcall RefreshChartRanges(const WideString VarStr) = 0 ;
	virtual void __fastcall Save(const bool AutoClose, const AnsiString FileName, const Uflxmessages::TOnGetFileNameEvent OnGetFileName, const Uflxmessages::TOnGetOutStreamEvent OnGetOutStream = 0x0, const Classes::TStream* DataStream = (Classes::TStream*)(0x0)) = 0 ;
	virtual void __fastcall InsertAndCopyRows(const int FirstRow, const int LastRow, const int DestRow, const int aCount, const bool OnlyFormulas) = 0 ;
	virtual void __fastcall InsertAndCopyCols(const int FirstCol, const int LastCol, const int DestCol, const int aCount, const bool OnlyFormulas) = 0 ;
	virtual void __fastcall DeleteRows(const int aRow, const int aCount) = 0 ;
	virtual void __fastcall DeleteCols(const int aCol, const int aCount) = 0 ;
	virtual void __fastcall BeginSheet(void) = 0 ;
	virtual void __fastcall EndSheet(const int RowOffset) = 0 ;
	virtual bool __fastcall CanOptimizeRead(void) = 0 ;
	__property int RangeCount = {read=GetExcelNameCount, nodefault};
	__property WideString RangeName[int index] = {read=GetRangeName};
	__property int RangeR1[int index] = {read=GetRangeR1, write=SetRangeR1};
	__property int RangeR2[int index] = {read=GetRangeR2, write=SetRangeR2};
	__property int RangeC1[int index] = {read=GetRangeC1, write=SetRangeC1};
	__property int RangeC2[int index] = {read=GetRangeC2, write=SetRangeC2};
	__property int RangeSheet[int index] = {read=GetRangeSheet};
	virtual void __fastcall AddRange(Uflxmessages::TXlsNamedRange &NamedRange) = 0 ;
	__property int PicturesCount[int Row] = {read=GetPicturesCount};
	__property WideString PictureName[int Row][int aPos] = {read=GetPictureName};
	virtual void __fastcall AssignPicture(const int Row, const int aPos, const Uflxmessages::ByteArray Pic, const Uflxmessages::TXlsImgTypes PicType) = 0 /* overload */;
	virtual void __fastcall AssignPicture(const int Row, const int aPos, const Uflxmessages::ByteArray Pic, const Uflxmessages::TXlsImgTypes PicType, const Uflxmessages::TImageProperties &Props, const Uflxmessages::TFlxAnchorType Anchor = (Uflxmessages::TFlxAnchorType)(0x1)) = 0 /* overload */;
	virtual void __fastcall AssignPictureProperties(const int Row, const int aPos, const Uflxmessages::TImageProperties &Props, const Uflxmessages::TFlxAnchorType Anchor = (Uflxmessages::TFlxAnchorType)(0x1)) = 0 ;
	virtual void __fastcall GetPicture(const int Row, const int aPos, const Classes::TStream* Pic, /* out */ Uflxmessages::TXlsImgTypes &PicType, /* out */ Uflxmessages::TClientAnchor &Anchor) = 0 ;
	virtual void __fastcall DeleteImage(const int Index) = 0 ;
	virtual void __fastcall ClearImage(const int Index) = 0 ;
	virtual void __fastcall AddImage(const Uflxmessages::ByteArray Data, const Uflxmessages::TXlsImgTypes DataType, const Uflxmessages::TImageProperties &Properties, const Uflxmessages::TFlxAnchorType Anchor) = 0 ;
	__property int CommentsCount[int Row] = {read=GetCommentsCount};
	__property WideString CommentText[int Row][int aPos] = {read=GetCommentText};
	__property int CommentColumn[int Row][int aPos] = {read=GetCommentColumn};
	virtual void __fastcall AssignComment(const int Row, const int aPos, const WideString Comment) = 0 ;
	virtual void __fastcall SetCellComment(int Row, int Col, const WideString Value, const Uflxmessages::TImageProperties &Properties) = 0 ;
	virtual WideString __fastcall GetCellComment(int Row, int Col) = 0 ;
	virtual int __fastcall CellCount(const int aRow) = 0 ;
	virtual Variant __fastcall GetCellData(const int aRow, const int aColOffset) = 0 ;
	virtual Uflxmessages::TXlsCellValue __fastcall GetCellDataX(const int aRow, const int aColOffset) = 0 ;
	virtual void __fastcall GetCellDataX2(const int aRow, const int aColOffset, /* out */ Uflxmessages::TXlsCellValue &v, /* out */ Uflxmessages::TRTFRunList &RTFRuns) = 0 ;
	virtual void __fastcall AssignCellData(const int aRow, const int aColOffset, const Variant &Value) = 0 ;
	virtual void __fastcall AssignCellDataX(const int aRow, const int aColOffset, const Uflxmessages::TXlsCellValue &Value) = 0 ;
	virtual void __fastcall AssignCellDataX2(const int aRow, const int aColOffset, const Uflxmessages::TXlsCellValue &Value, const Uflxmessages::TRTFRunList RTFRuns) = 0 ;
	virtual void __fastcall GetCellValueX2(int aRow, int aCol, /* out */ Uflxmessages::TXlsCellValue &v, /* out */ Uflxmessages::TRTFRunList &RTFRuns) = 0 ;
	virtual void __fastcall AssignCellValueX2(int aRow, int aCol, const Uflxmessages::TXlsCellValue &Value, const Uflxmessages::TRTFRunList RTFRuns) = 0 ;
	virtual void __fastcall SetCellString(const int aRow, const int aCol, const WideString Text, const WideString DateFormat = L"", const WideString TimeFormat = L"") = 0 /* overload */;
	virtual void __fastcall SetCellString(const int aRow, const int aCol, const WideString Text, const Uflxformats::TFlxFormat &Fm, const WideString DateFormat = L"", const WideString TimeFormat = L"") = 0 /* overload */;
	virtual int __fastcall MaxRow(void) = 0 ;
	virtual int __fastcall MaxCol(void) = 0 ;
	virtual bool __fastcall IsEmptyRow(const int aRow) = 0 ;
	__property Variant CellValue[int aRow][int aCol] = {read=GetCellValue, write=SetCellValue};
	__property Uflxmessages::TXlsCellValue CellValueX[int aRow][int aCol] = {read=GetCellValueX, write=SetCellValueX};
	__property int CellFormat[int aRow][int aCol] = {read=GetCellFormat, write=SetCellFormat};
	__property WideString CellFormula[int aRow][int aCol] = {read=GetCellFormula, write=SetCellFormula};
	virtual void __fastcall SetCellFormulaX(int aRow, int aCol, const WideString Formula, const Variant &Value) = 0 ;
	virtual int __fastcall ColByIndex(const int Row, const int ColIndex) = 0 ;
	virtual int __fastcall ColIndexCount(const int Row) = 0 ;
	virtual int __fastcall ColIndex(const int Row, const int Col) = 0 ;
	__property int ColumnWidth[int aCol] = {read=GetColumnWidth, write=SetColumnWidth};
	__property int ColumnWidthHiddenIsZero[int aCol] = {read=GetColumnWidthHiddenIsZero};
	__property int RowHeight[int aRow] = {read=GetRowHeight, write=SetRowHeight};
	__property int RowHeightHiddenIsZero[int aRow] = {read=GetRowHeight};
	__property bool ColumnHidden[int aCol] = {read=GetColumnHidden, write=SetColumnHidden};
	__property bool RowHidden[int aRow] = {read=GetRowHidden, write=SetRowHidden};
	__property int DefaultColWidth = {read=GetDefaultColWidth, nodefault};
	__property int DefaultRowHeight = {read=GetDefaultRowHeight, nodefault};
	__property int ColumnFormat[int aColumn] = {read=GetColumnFormat, write=SetColumnFormat};
	__property int RowFormat[int aRow] = {read=GetRowFormat, write=SetRowFormat};
	virtual void __fastcall SetBounds(const int aRangePos) = 0 ;
	virtual int __fastcall GetFirstColumn(void) = 0 ;
	virtual void __fastcall PrepareBlockData(const int R1, const int C1, const int R2, const int C2) = 0 ;
	virtual void __fastcall AssignBlockData(const int Row, const int Col, const Variant &v) = 0 ;
	virtual void __fastcall PasteBlockData(void) = 0 ;
	virtual bool __fastcall IsWorksheet(const int index) = 0 ;
	__property bool AutoRowHeight[int Row] = {read=GetAutoRowHeight, write=SetAutoRowHeight};
	__property unsigned ColorPalette[Uflxmessages::TColorPaletteRange Index] = {read=GetColorPalette, write=SetColorPalette};
	virtual Uflxmessages::BooleanArray __fastcall GetUsedPaletteColors(void) = 0 ;
	__property Uflxformats::TFlxFont FontList[int index] = {read=GetFontList, write=SetFontList};
	virtual int __fastcall FontListCount(void) = 0 ;
	__property Uflxformats::TFlxFormat FormatList[int index] = {read=GetFormatList, write=SetFormatList};
	virtual int __fastcall FormatListCount(void) = 0 ;
	virtual int __fastcall AddFormat(const Uflxformats::TFlxFormat &Fmt) = 0 ;
	virtual int __fastcall AddFont(const Uflxformats::TFlxFont &Fmt) = 0 ;
	__property Uflxmessages::TXlsCellRange CellMergedBounds[int aRow][int aCol] = {read=GetCellMergedBounds};
	virtual void __fastcall MergeCells(const int FirstRow, const int FirstCol, const int LastRow, const int LastCol) = 0 ;
	virtual void __fastcall UnMergeCells(const int FirstRow, const int FirstCol, const int LastRow, const int LastCol) = 0 ;
	virtual int __fastcall CellMergedListCount(void) = 0 ;
	__property Uflxmessages::TXlsCellRange CellMergedList[int index] = {read=GetCellMergedList};
	virtual void __fastcall CopyToClipboard(void) = 0 /* overload */;
	virtual void __fastcall CopyToClipboard(const Uflxmessages::TXlsCellRange &Range) = 0 /* overload */;
	virtual void __fastcall PasteFromClipboard(const int Row, const int Col) = 0 ;
	virtual void __fastcall ParseComments(void) = 0 ;
	virtual int __fastcall HyperLinkCount(void) = 0 ;
	virtual Uflxmessages::THyperLink __fastcall GetHyperLink(const int HyperLinkIndex) = 0 ;
	virtual void __fastcall SetHyperLink(const int HyperLinkIndex, const Uflxmessages::THyperLink &value) = 0 ;
	virtual Uflxmessages::TXlsCellRange __fastcall GetHyperLinkCellRange(const int HyperLinkIndex) = 0 ;
	virtual void __fastcall SetHyperLinkCellRange(const int HyperLinkIndex, const Uflxmessages::TXlsCellRange &CellRange) = 0 ;
	virtual void __fastcall AddHyperLink(const Uflxmessages::TXlsCellRange &CellRange, const Uflxmessages::THyperLink &value) = 0 ;
	virtual void __fastcall DeleteHyperLink(const int HyperLinkIndex) = 0 ;
	virtual int __fastcall GetRowOutlineLevel(const int aRow) = 0 ;
	virtual void __fastcall SetRowOutlineLevel(const int FirstRow, const int LastRow, const int Value) = 0 ;
	virtual int __fastcall GetColOutlineLevel(const int aCol) = 0 ;
	virtual void __fastcall SetColOutlineLevel(const int FirstCol, const int LastCol, const int Level) = 0 ;
	__property bool OutlineSummaryRowsBelowDetail = {read=GetOutlineSummaryRowsBelowDetail, write=SetOutlineSummaryRowsBelowDetail, nodefault};
	__property bool OutlineSummaryColsRightOfDetail = {read=GetOutlineSummaryColsRightOfDetail, write=SetOutlineSummaryColsRightOfDetail, nodefault};
	__property bool OutlineAutomaticStyles = {read=GetOutlineAutomaticStyles, write=SetOutlineAutomaticStyles, nodefault};
	__property bool Options1904Dates = {read=GetOptions1904Dates, write=SetOptions1904Dates, nodefault};
	__property bool OptionsR1C1 = {read=GetOptionsR1C1, write=SetOptionsR1C1, nodefault};
	__property bool OptionsSaveExternalLinkValues = {read=GetOptionsSaveExternalLinkValues, write=SetOptionsSaveExternalLinkValues, nodefault};
	__property bool OptionsPrecisionAsDisplayed = {read=GetOptionsPrecisionAsDisplayed, write=SetOptionsPrecisionAsDisplayed, nodefault};
	virtual void __fastcall FreezePanes(const int Row, const int Col) = 0 ;
	virtual void __fastcall GetFrozenPanes(/* out */ int &Row, /* out */ int &Col) = 0 ;
	virtual void __fastcall SplitWindow(const int xOffset, const int yOffset) = 0 ;
	virtual void __fastcall GetSplitWindow(/* out */ int &xOffset, /* out */ int &yOffset) = 0 ;
	__property bool InvalidateFormulas = {read=GetInvalidateFormulas, write=SetInvalidateFormulas, nodefault};
	__property bool IsXltTemplate = {read=GetIsXltTemplate, write=SetIsXltTemplate, nodefault};
	virtual void __fastcall AutofitRow(const int row1, const int row2, const bool AutofitNotAutofittingRows, const bool keepHeightAutomatic, const Extended adjustment) = 0 ;
	virtual void __fastcall AutofitCol(const int Col1, const int Col2, const bool IgnoreStrings, const Extended Adjustment) = 0 ;
	virtual void __fastcall AutofitRowsOnWorkbook(const bool AutofitNotAutofittingRows, const bool KeepSizesAutomatic, const Extended Adjustment) = 0 ;
	virtual void __fastcall SetAutoFilter(const int row, const int col1, const int col2) = 0 /* overload */;
	virtual void __fastcall RemoveAutoFilter(void) = 0 ;
	virtual bool __fastcall HasAutoFilter(void) = 0 /* overload */;
	virtual bool __fastcall HasAutoFilter(const int row, const int col) = 0 /* overload */;
	virtual Uflxmessages::TXlsCellRange __fastcall GetAutoFilterRange(void) = 0 ;
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TExcelFile(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TExcelFile(void) { }
	#pragma option pop
	
};


class DELPHICLASS TExcelAdapter;
class PASCALIMPLEMENTATION TExcelAdapter : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	AnsiString FBasePathToOpen;
	
public:
	virtual TExcelFile* __fastcall GetWorkbook(void) = 0 ;
	
__published:
	__property AnsiString BasePathToOpen = {read=FBasePathToOpen, write=FBasePathToOpen};
public:
	#pragma option push -w-inl
	/* TComponent.Create */ inline __fastcall virtual TExcelAdapter(Classes::TComponent* AOwner) : Classes::TComponent(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TComponent.Destroy */ inline __fastcall virtual ~TExcelAdapter(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uexceladapter */
using namespace Uexceladapter;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Uexceladapter
