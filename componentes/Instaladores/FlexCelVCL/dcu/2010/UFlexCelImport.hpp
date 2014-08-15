// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uflexcelimport.pas' rev: 21.00

#ifndef UflexcelimportHPP
#define UflexcelimportHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Uexceladapter.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit
#include <Uflxformats.hpp>	// Pascal unit
#include <Utextdelim.hpp>	// Pascal unit
#include <Uflxutils.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uflexcelimport
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TFlexCelImport;
class PASCALIMPLEMENTATION TFlexCelImport : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	Sysutils::TFileName FActiveFileName;
	bool __fastcall GetIsFormula(int Row, int Column);
	bool __fastcall GetAutoRowHeight(int Row);
	void __fastcall SetAutoRowHeight(int Row, const bool Value);
	int __fastcall GetCellFormat(int Row, int Col);
	void __fastcall SetCellFormat(int Row, int Col, const int Value);
	Uflxmessages::TXlsCellValue __fastcall GetCell(int Row, int Col);
	void __fastcall SetCell(int Row, int Col, const Uflxmessages::TXlsCellValue &Value);
	unsigned __fastcall GetColorPalette(Uflxmessages::TColorPaletteRange index);
	void __fastcall SetColorPalette(Uflxmessages::TColorPaletteRange index, const unsigned Value);
	int __fastcall GetColorPaletteCount(void);
	int __fastcall GetColumnFormat(int aColumn);
	int __fastcall GetRowFormat(int aRow);
	void __fastcall SetColumnFormat(int aColumn, const int Value);
	void __fastcall SetRowFormat(int aRow, const int Value);
	int __fastcall GetFontListCount(void);
	int __fastcall GetFormatListCount(void);
	Uflxformats::TFlxFont __fastcall GetFlxFontList(int index);
	Uflxformats::TFlxFormat __fastcall GetFlxFormatList(int index);
	void __fastcall SetFlxFormatList(int index, const Uflxformats::TFlxFormat &Value);
	void __fastcall SetFlxFontList(int index, const Uflxformats::TFlxFont &Value);
	Uflxformats::TFlxFormat __fastcall GetCellFormatDef1(int aRow, int aCol);
	int __fastcall GetColByIndex(int Row, int ColIndex);
	int __fastcall GetColIndexCount(int Row);
	int __fastcall GetColIndex(int Row, int Col);
	int __fastcall GetDefaultColWidth(void);
	int __fastcall GetDefaultRowHeight(void);
	bool __fastcall GetShowGridLines(void);
	void __fastcall SetShowGridLines(const bool Value);
	bool __fastcall GetShowGridHeaders(void);
	void __fastcall SetShowGridHeaders(const bool Value);
	bool __fastcall GetPrintGridLines(void);
	void __fastcall SetPrintGridLines(const bool Value);
	System::UnicodeString __fastcall GetPictureName(int aPos);
	int __fastcall GetPicturesCount(void);
	Uflxmessages::TXlsCellRange __fastcall GetCellMergedBounds(int aRow, int aCol);
	Uflxmessages::TXlsMargins __fastcall GetPrintMargins(void);
	void __fastcall SetPrintMargins(const Uflxmessages::TXlsMargins &Value);
	System::UnicodeString __fastcall GetPageFooter(void);
	System::UnicodeString __fastcall GetPageHeader(void);
	System::Word __fastcall GetPrintNumberOfHorizontalPages(void);
	System::Word __fastcall GetPrintNumberOfVerticalPages(void);
	int __fastcall GetPrintScale(void);
	System::Byte __fastcall GetPrintOptions(void);
	bool __fastcall GetPrintToFit(void);
	void __fastcall SetPageFooter(const System::UnicodeString Value);
	void __fastcall SetPageHeader(const System::UnicodeString Value);
	void __fastcall SetPrintNumberOfHorizontalPages(const System::Word Value);
	void __fastcall SetPrintNumberOfVerticalPages(const System::Word Value);
	void __fastcall SetPrintScale(const int Value);
	void __fastcall SetPrintToFit(const bool Value);
	void __fastcall SetPrintOptions(const System::Byte Value);
	System::UnicodeString __fastcall GetCellFormula(int aRow, int aCol);
	void __fastcall SetCellFormula(int aRow, int aCol, const System::UnicodeString Value);
	void __fastcall FindOnePart(const System::UnicodeString Text, const int P1, const int P2, const int P3, /* out */ System::UnicodeString &Part);
	int __fastcall GetSheetZoom(void);
	void __fastcall SetSheetZoom(const int Value);
	Uflxmessages::TXlsSheetVisible __fastcall GetActiveSheetVisible(void);
	void __fastcall SetActiveSheetVisible(const Uflxmessages::TXlsSheetVisible Value);
	int __fastcall GetExcelNameCount(void);
	int __fastcall GetRangeC1(int index);
	int __fastcall GetRangeC2(int index);
	System::UnicodeString __fastcall GetRangeName(int index);
	int __fastcall GetRangeR1(int index);
	int __fastcall GetRangeR2(int index);
	int __fastcall GetRangeSheet(int index);
	Uflxmessages::TXlsCellRange __fastcall GetCellMergedList(int index);
	Uflxmessages::TRTFRunList __fastcall GetRTFRuns(int Row, int Col);
	void __fastcall SetRTFRuns(int Row, int Col, const Uflxmessages::TRTFRunList Value);
	void __fastcall SetRangeC1(int index, const int Value);
	void __fastcall SetRangeC2(int index, const int Value);
	void __fastcall SetRangeR1(int index, const int Value);
	void __fastcall SetRangeR2(int index, const int Value);
	bool __fastcall GetOptions1904Dates(void);
	bool __fastcall GetOptionsPrecisionAsDisplayed(void);
	bool __fastcall GetOptionsR1C1(void);
	bool __fastcall GetOptionsSaveExternalLinkValues(void);
	void __fastcall SetOptions1904Dates(const bool Value);
	void __fastcall SetOptionsPrecisionAsDisplayed(const bool Value);
	void __fastcall SetOptionsR1C1(const bool Value);
	void __fastcall SetOptionsSaveExternalLinkValues(const bool Value);
	int __fastcall GetPrintCopies(void);
	int __fastcall GetPrintPaperSize(void);
	int __fastcall GetPrintXResolution(void);
	int __fastcall GetPrintYResolution(void);
	void __fastcall SetPrintCopies(const int Value);
	void __fastcall SetPrinterDriverSettings(const Uflxmessages::TPrinterDriverSettings &Value);
	void __fastcall SetPrintPaperSize(const int Value);
	void __fastcall SetPrintXResolution(const int Value);
	void __fastcall SetPrintYResolution(const int Value);
	Uflxmessages::TPrinterDriverSettings __fastcall GetPrinterDriverSettings(void);
	bool __fastcall GetOutlineSummaryColsRightOfDetail(void);
	bool __fastcall GetOutlineSummaryRowsBelowDetail(void);
	bool __fastcall GetOutlineAutomaticStyles(void);
	void __fastcall SetOutlineSummaryColsRightOfDetail(const bool Value);
	void __fastcall SetOutlineSummaryRowsBelowDetail(const bool Value);
	void __fastcall SetOutlineAutomaticStyles(const bool Value);
	bool __fastcall GetInvalidateFormulas(void);
	void __fastcall SetInvalidateFormulas(const bool Value);
	Uexceladapter::TExcelFile* Workbook;
	Uexceladapter::TExcelAdapter* FAdapter;
	void __fastcall SetAdapter(const Uexceladapter::TExcelAdapter* Value);
	System::Variant __fastcall GetCellValue(int Row, int Col);
	void __fastcall SetCellValue(int Row, int Col, const System::Variant &Value);
	int __fastcall GetActiveSheet(void);
	void __fastcall SetActiveSheet(const int Value);
	int __fastcall GetSheetCount(void);
	int __fastcall GetMaxRow(void);
	int __fastcall GetMaxCol(void);
	System::Variant __fastcall GetComments(int Row, int Pos);
	void __fastcall SetComments(int Row, int Pos, const System::Variant &Value);
	int __fastcall GetCommentsCount(int Row);
	System::UnicodeString __fastcall GetActiveSheetName(void);
	void __fastcall SetActiveSheetName(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetActiveSheetCodeName(void);
	void __fastcall SetActiveSheetCodeName(const System::UnicodeString Value);
	int __fastcall GetColumnWidth(int aCol);
	int __fastcall GetRowHeight(int aRow);
	void __fastcall SetColumnWidth(int aCol, int Value);
	void __fastcall SetRowHeight(int aRow, int Value);
	bool __fastcall GetRowHidden(const int aRow);
	bool __fastcall GetColumnHidden(const int aCol);
	void __fastcall SetRowHidden(const int aRow, const bool Value);
	void __fastcall SetColumnHidden(const int aCol, const bool Value);
	bool __fastcall GetIsXltTemplate(void);
	void __fastcall SetIsXltTemplate(const bool Value);
	bool __fastcall GetPrintHCentered(void);
	bool __fastcall GetPrintVCentered(void);
	void __fastcall SetPrintHCentered(const bool Value);
	void __fastcall SetPrintVCentered(const bool Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	Uexceladapter::TExcelFile* __fastcall GetWorkbook(void);
	__fastcall virtual ~TFlexCelImport(void);
	void __fastcall NewFile(const int SheetCount = 0x3);
	void __fastcall OpenFile(const Sysutils::TFileName FileName);
	void __fastcall OpenText(const Sysutils::TFileName FileName, const System::WideChar Delimiter)/* overload */;
	void __fastcall OpenText(const Sysutils::TFileName FileName, const System::WideChar Delimiter, Utextdelim::XLSColumnImportTypes const *ColumnFormats, const int ColumnFormats_Size)/* overload */;
	void __fastcall LoadFromStream(const Classes::TStream* DataStream);
	void __fastcall LoadFromTextStream(const Classes::TStream* DataStream, const System::WideChar Delimiter)/* overload */;
	void __fastcall LoadFromTextStream(const Classes::TStream* DataStream, const System::WideChar Delimiter, Utextdelim::XLSColumnImportTypes const *ColumnFormats, const int ColumnFormats_Size)/* overload */;
	void __fastcall LoadFromTextStream(const Classes::TStream* DataStream, const System::WideChar Delimiter, Utextdelim::XLSColumnImportTypes const *ColumnFormats, const int ColumnFormats_Size, const Sysutils::TEncoding* Encoding, const bool DetectBOM)/* overload */;
	void __fastcall Save(const Sysutils::TFileName FileName);
	void __fastcall SaveToStream(const Classes::TStream* DataStream);
	void __fastcall SaveAsText(const Sysutils::TFileName FileName, const System::WideChar Delimiter)/* overload */;
	void __fastcall SaveAsText(const Sysutils::TFileName FileName, const System::WideChar Delimiter, const Sysutils::TEncoding* Encoding, const bool IncludeBOM)/* overload */;
	void __fastcall SaveToStreamAsText(const Classes::TStream* DataStream, const System::WideChar Delimiter)/* overload */;
	void __fastcall SaveToStreamAsText(const Classes::TStream* DataStream, const System::WideChar Delimiter, const Sysutils::TEncoding* Encoding, const bool IncludeBOM)/* overload */;
	void __fastcall CloseFile(void);
	__property int SheetCount = {read=GetSheetCount, nodefault};
	__property int ActiveSheet = {read=GetActiveSheet, write=SetActiveSheet, nodefault};
	__property System::UnicodeString ActiveSheetName = {read=GetActiveSheetName, write=SetActiveSheetName};
	__property System::UnicodeString ActiveSheetCodeName = {read=GetActiveSheetCodeName, write=SetActiveSheetCodeName};
	__property Uflxmessages::TXlsSheetVisible ActiveSheetVisible = {read=GetActiveSheetVisible, write=SetActiveSheetVisible, nodefault};
	void __fastcall InsertAndCopySheets(const int CopyFromSheet, const int InsertBeforeSheet, const int SheetCount);
	void __fastcall InsertEmptySheets(const int InsertBeforeSheet, const int SheetCount);
	void __fastcall ClearSheet(void);
	void __fastcall DeleteSheet(int aSheetCount);
	__property int MaxRow = {read=GetMaxRow, nodefault};
	__property int MaxCol = {read=GetMaxCol, nodefault};
	bool __fastcall IsEmptyRow(const int aRow);
	__property System::Variant CellValue[int Row][int Col] = {read=GetCellValue, write=SetCellValue};
	__property Uflxmessages::TRTFRunList RTFRuns[int Row][int Col] = {read=GetRTFRuns, write=SetRTFRuns};
	__property int CellFormat[int Row][int Col] = {read=GetCellFormat, write=SetCellFormat};
	void __fastcall SetCellString(int Row, int Col, const System::UnicodeString Text)/* overload */;
	void __fastcall SetCellString(int Row, int Col, const System::UnicodeString Text, const Uflxformats::TFlxFormat &Fm)/* overload */;
	__property bool IsFormula[int Row][int Column] = {read=GetIsFormula};
	__property Uflxmessages::TXlsCellValue Cell[int Row][int Col] = {read=GetCell, write=SetCell};
	__property System::UnicodeString CellFormula[int aRow][int aCol] = {read=GetCellFormula, write=SetCellFormula};
	void __fastcall AssignCellFormulaX(const int aRow, const int aCol, const System::UnicodeString Formula, const System::Variant &FormulaResult);
	__property bool InvalidateFormulas = {read=GetInvalidateFormulas, write=SetInvalidateFormulas, nodefault};
	__property int ColByIndex[int Row][int ColIndex] = {read=GetColByIndex};
	__property int ColIndex[int Row][int Col] = {read=GetColIndex};
	__property int ColIndexCount[int Row] = {read=GetColIndexCount};
	__property unsigned ColorPalette[Uflxmessages::TColorPaletteRange index] = {read=GetColorPalette, write=SetColorPalette};
	__property int ColorPaletteCount = {read=GetColorPaletteCount, nodefault};
	Uflxmessages::BooleanArray __fastcall GetUsedPaletteColors(void);
	int __fastcall NearestColorIndex(const Graphics::TColor aColor)/* overload */;
	int __fastcall NearestColorIndex(const Graphics::TColor aColor, const Uflxmessages::BooleanArray UsedColors)/* overload */;
	int __fastcall AddFormat(const Uflxformats::TFlxFormat &Fmt);
	int __fastcall AddFont(const Uflxformats::TFlxFont &Fmt);
	void __fastcall GetCellFormatDef(const int aRow, const int aCol, /* out */ Uflxformats::TFlxFormat &F);
	void __fastcall GetFormatList(const int index, /* out */ Uflxformats::TFlxFormat &F);
	void __fastcall GetFontList(const int index, /* out */ Uflxformats::TFlxFont &F);
	void __fastcall SetFormatList(int index, const Uflxformats::TFlxFormat &Value);
	void __fastcall SetFontList(int index, const Uflxformats::TFlxFont &Value);
	void __fastcall GetDefaultFormat(/* out */ Uflxformats::TFlxFormat &F);
	__property int FormatListCount = {read=GetFormatListCount, nodefault};
	__property int FontListCount = {read=GetFontListCount, nodefault};
	__property int ColumnWidth[int aCol] = {read=GetColumnWidth, write=SetColumnWidth};
	__property int RowHeight[int aRow] = {read=GetRowHeight, write=SetRowHeight};
	__property bool ColumnHidden[const int aCol] = {read=GetColumnHidden, write=SetColumnHidden};
	__property bool RowHidden[const int aRow] = {read=GetRowHidden, write=SetRowHidden};
	__property bool AutoRowHeight[int Row] = {read=GetAutoRowHeight, write=SetAutoRowHeight};
	__property int DefaultRowHeight = {read=GetDefaultRowHeight, nodefault};
	__property int DefaultColWidth = {read=GetDefaultColWidth, nodefault};
	__property int ColumnFormat[int aColumn] = {read=GetColumnFormat, write=SetColumnFormat};
	__property int RowFormat[int aRow] = {read=GetRowFormat, write=SetRowFormat};
	__property Uflxmessages::TXlsCellRange CellMergedBounds[int aRow][int aCol] = {read=GetCellMergedBounds};
	void __fastcall MergeCells(const int FirstRow, const int FirstCol, const int LastRow, const int LastCol);
	void __fastcall UnMergeCells(const int FirstRow, const int FirstCol, const int LastRow, const int LastCol);
	int __fastcall CellMergedListCount(void);
	__property Uflxmessages::TXlsCellRange CellMergedList[int index] = {read=GetCellMergedList};
	void __fastcall InsertAndCopyRows(const int FirstRow, const int LastRow, const int DestRow, const int aCount);
	void __fastcall InsertAndCopyCols(const int FirstCol, const int LastCol, const int DestCol, const int aCount);
	void __fastcall DeleteRows(const int aRow, const int aCount);
	void __fastcall DeleteCols(const int aCol, const int aCount);
	__property int RangeCount = {read=GetExcelNameCount, nodefault};
	__property System::UnicodeString RangeName[int index] = {read=GetRangeName};
	__property int RangeR1[int index] = {read=GetRangeR1, write=SetRangeR1};
	__property int RangeR2[int index] = {read=GetRangeR2, write=SetRangeR2};
	__property int RangeC1[int index] = {read=GetRangeC1, write=SetRangeC1};
	__property int RangeC2[int index] = {read=GetRangeC2, write=SetRangeC2};
	__property int RangeSheet[int index] = {read=GetRangeSheet};
	void __fastcall SetNamedRange(Uflxmessages::TXlsNamedRange &NamedRange);
	__property int CommentsCount[int Row] = {read=GetCommentsCount};
	__property System::Variant Comments[int Row][int Pos] = {read=GetComments, write=SetComments};
	System::UnicodeString __fastcall GetCellComment(int Row, int Col);
	void __fastcall SetCellComment(int Row, int Col, const System::UnicodeString Value)/* overload */;
	void __fastcall SetCellComment(int Row, int Col, const System::UnicodeString Value, const Uflxmessages::TImageProperties &Properties)/* overload */;
	__property int PicturesCount = {read=GetPicturesCount, nodefault};
	__property System::UnicodeString PictureName[int aPos] = {read=GetPictureName};
	void __fastcall AssignPicture(const int aPos, const Uflxmessages::ByteArray Pic, const Uflxmessages::TXlsImgTypes PicType)/* overload */;
	void __fastcall AssignPicture(const int aPos, const Uflxmessages::ByteArray Pic, const Uflxmessages::TXlsImgTypes PicType, const int Row, const int Col, const int dh, const int dw, const int ImgHeight, const int ImgWidth, const Uflxmessages::TFlxAnchorType Anchor = (Uflxmessages::TFlxAnchorType)(0x1))/* overload */;
	void __fastcall AssignPictureProperties(const int aPos, const int Row, const int Col, const int dh, const int dw, const int ImgHeight, const int ImgWidth, const Uflxmessages::TFlxAnchorType Anchor = (Uflxmessages::TFlxAnchorType)(0x1));
	void __fastcall GetPicture(const int aPos, const Classes::TStream* Pic, /* out */ Uflxmessages::TXlsImgTypes &PicType, /* out */ Uflxmessages::TClientAnchor &ClientAnchor);
	void __fastcall DeletePicture(const int Index);
	void __fastcall ClearPicture(const int Index);
	void __fastcall AddPicture(const Uflxmessages::ByteArray Pic, const Uflxmessages::TXlsImgTypes PicType, const Uflxmessages::TImageProperties &Properties, const Uflxmessages::TFlxAnchorType Anchor = (Uflxmessages::TFlxAnchorType)(0x1))/* overload */;
	void __fastcall AddPicture(const Classes::TStream* Pic, const Uflxmessages::TXlsImgTypes PicType, const Uflxmessages::TImageProperties &Properties, const Uflxmessages::TFlxAnchorType Anchor = (Uflxmessages::TFlxAnchorType)(0x1))/* overload */;
	void __fastcall AddPicture(const Uflxmessages::ByteArray Pic, const Uflxmessages::TXlsImgTypes PicType, const int Row, const int Col, const int dh, const int dw, const int ImgHeight, const int ImgWidth, const Uflxmessages::TFlxAnchorType Anchor = (Uflxmessages::TFlxAnchorType)(0x1))/* overload */;
	void __fastcall AddPicture(const Classes::TStream* Pic, const Uflxmessages::TXlsImgTypes PicType, const int Row, const int Col, const int dh, const int dw, const int ImgHeight, const int ImgWidth, const Uflxmessages::TFlxAnchorType Anchor = (Uflxmessages::TFlxAnchorType)(0x1))/* overload */;
	__property System::UnicodeString PageHeader = {read=GetPageHeader, write=SetPageHeader};
	__property System::UnicodeString PageFooter = {read=GetPageFooter, write=SetPageFooter};
	void __fastcall FillPageHeaderFooter(const System::UnicodeString Text, /* out */ System::UnicodeString &Left, /* out */ System::UnicodeString &Center, /* out */ System::UnicodeString &Right);
	__property bool ShowGridLines = {read=GetShowGridLines, write=SetShowGridLines, nodefault};
	__property bool PrintGridLines = {read=GetPrintGridLines, write=SetPrintGridLines, nodefault};
	__property bool ShowGridHeaders = {read=GetShowGridHeaders, write=SetShowGridHeaders, nodefault};
	__property int SheetZoom = {read=GetSheetZoom, write=SetSheetZoom, nodefault};
	bool __fastcall CanOptimizeRead(void);
	bool __fastcall IsLoaded(void);
	__property Sysutils::TFileName ActiveFileName = {read=FActiveFileName};
	void __fastcall CopyToClipboard(void)/* overload */;
	void __fastcall CopyToClipboard(const Uflxmessages::TXlsCellRange &Range)/* overload */;
	void __fastcall PasteFromClipboard(const int Row, const int Col);
	void __fastcall DeleteHPageBreak(const System::Word aRow);
	void __fastcall DeleteVPageBreak(const System::Word aCol);
	void __fastcall InsertHPageBreak(const System::Word aRow);
	void __fastcall InsertVPageBreak(const System::Word aCol);
	bool __fastcall HasHPageBreak(const int Row);
	bool __fastcall HasVPageBreak(const int Col);
	__property Uflxmessages::TXlsMargins PrintMargins = {read=GetPrintMargins, write=SetPrintMargins};
	__property bool PrintHCentered = {read=GetPrintHCentered, write=SetPrintHCentered, nodefault};
	__property bool PrintVCentered = {read=GetPrintVCentered, write=SetPrintVCentered, nodefault};
	__property bool PrintToFit = {read=GetPrintToFit, write=SetPrintToFit, nodefault};
	__property System::Byte PrintOptions = {read=GetPrintOptions, write=SetPrintOptions, nodefault};
	__property int PrintScale = {read=GetPrintScale, write=SetPrintScale, nodefault};
	__property System::Word PrintNumberOfHorizontalPages = {read=GetPrintNumberOfHorizontalPages, write=SetPrintNumberOfHorizontalPages, nodefault};
	__property System::Word PrintNumberOfVerticalPages = {read=GetPrintNumberOfVerticalPages, write=SetPrintNumberOfVerticalPages, nodefault};
	__property int PrintPaperSize = {read=GetPrintPaperSize, write=SetPrintPaperSize, nodefault};
	__property int PrintCopies = {read=GetPrintCopies, write=SetPrintCopies, nodefault};
	__property int PrintXResolution = {read=GetPrintXResolution, write=SetPrintXResolution, nodefault};
	__property int PrintYResolution = {read=GetPrintYResolution, write=SetPrintYResolution, nodefault};
	__property Uflxmessages::TPrinterDriverSettings PrinterDriverSettings = {read=GetPrinterDriverSettings, write=SetPrinterDriverSettings};
	int __fastcall HyperLinkCount(void);
	Uflxmessages::THyperLink __fastcall GetHyperLink(const int HyperLinkIndex);
	void __fastcall SetHyperLink(const int HyperLinkIndex, const Uflxmessages::THyperLink &value);
	Uflxmessages::TXlsCellRange __fastcall GetHyperLinkCellRange(const int HyperLinkIndex);
	void __fastcall SetHyperLinkCellRange(const int HyperLinkIndex, const Uflxmessages::TXlsCellRange &CellRange);
	void __fastcall AddHyperLink(const Uflxmessages::TXlsCellRange &CellRange, const Uflxmessages::THyperLink &value);
	void __fastcall DeleteHyperLink(const int HyperLinkIndex);
	int __fastcall GetRowOutlineLevel(const int aRow);
	void __fastcall SetRowOutlineLevel(const int FirstRow, const int LastRow, const int Level);
	int __fastcall GetColOutlineLevel(const int aCol);
	void __fastcall SetColOutlineLevel(const int FirstCol, const int LastCol, const int Level);
	__property bool OutlineSummaryRowsBelowDetail = {read=GetOutlineSummaryRowsBelowDetail, write=SetOutlineSummaryRowsBelowDetail, nodefault};
	__property bool OutlineSummaryColsRightOfDetail = {read=GetOutlineSummaryColsRightOfDetail, write=SetOutlineSummaryColsRightOfDetail, nodefault};
	__property bool OutlineAutomaticStyles = {read=GetOutlineAutomaticStyles, write=SetOutlineAutomaticStyles, nodefault};
	__property bool Options1904Dates = {read=GetOptions1904Dates, write=SetOptions1904Dates, nodefault};
	__property bool OptionsR1C1 = {read=GetOptionsR1C1, write=SetOptionsR1C1, nodefault};
	__property bool OptionsSaveExternalLinkValues = {read=GetOptionsSaveExternalLinkValues, write=SetOptionsSaveExternalLinkValues, nodefault};
	__property bool OptionsPrecisionAsDisplayed = {read=GetOptionsPrecisionAsDisplayed, write=SetOptionsPrecisionAsDisplayed, nodefault};
	__property bool IsXltTemplate = {read=GetIsXltTemplate, write=SetIsXltTemplate, nodefault};
	void __fastcall FreezePanes(const int Row, const int Col);
	void __fastcall GetFrozenPanes(/* out */ int &Row, /* out */ int &Col);
	void __fastcall SplitWindow(const int xOffset, const int yOffset);
	void __fastcall GetSplitWindow(/* out */ int &xOffset, /* out */ int &yOffset);
	void __fastcall AutofitRow(const int row1, const int row2, const bool AutofitNotAutofittingRows, const bool keepHeightAutomatic, const System::Extended adjustment)/* overload */;
	void __fastcall AutofitRow(const int row, const bool keepHeightAutomatic, const System::Extended adjustment)/* overload */;
	void __fastcall AutofitCol(const int Col, const bool IgnoreStrings, const System::Extended Adjustment)/* overload */;
	void __fastcall AutofitCol(const int Col1, const int Col2, const bool IgnoreStrings, const System::Extended Adjustment)/* overload */;
	void __fastcall AutofitRowsOnWorkbook(const bool AutofitNotAutofittingRows, const bool KeepSizesAutomatic, const System::Extended Adjustment);
	System::TDateTime __fastcall FromOADate(const double Date);
	double __fastcall ToOADate(const System::TDateTime Date);
	void __fastcall SetAutoFilter(const int row, const int col1, const int col2)/* overload */;
	void __fastcall SetAutoFilter(const Uflxmessages::TXlsCellRange &range)/* overload */;
	void __fastcall RemoveAutoFilter(void);
	bool __fastcall HasAutoFilter(void)/* overload */;
	bool __fastcall HasAutoFilter(const int row, const int col)/* overload */;
	Uflxmessages::TXlsCellRange __fastcall GetAutoFilterRange(void);
	
__published:
	__property Uexceladapter::TExcelAdapter* Adapter = {read=FAdapter, write=SetAdapter};
public:
	/* TComponent.Create */ inline __fastcall virtual TFlexCelImport(Classes::TComponent* AOwner) : Classes::TComponent(AOwner) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uflexcelimport */
using namespace Uflexcelimport;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// UflexcelimportHPP
