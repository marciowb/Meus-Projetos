// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Xlsadapter.pas' rev: 10.00

#ifndef XlsadapterHPP
#define XlsadapterHPP

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
#include <Xlsbasetemplatestore.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit
#include <Uexcelrecords.hpp>	// Pascal unit
#include <Xlsmessages.hpp>	// Pascal unit
#include <Uflxrowcomments.hpp>	// Pascal unit
#include <Uole2impl.hpp>	// Pascal unit
#include <Clipbrd.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Uxlssheet.hpp>	// Pascal unit
#include <Uflxformats.hpp>	// Pascal unit
#include <Uxlsrowcolentries.hpp>	// Pascal unit
#include <Utextdelim.hpp>	// Pascal unit
#include <Uxlsxf.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Xlsadapter
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TExcelSaveFormatNative { snXLS, snCSVComma, snCSVSemiColon, snTabDelimited };
#pragma option pop

typedef Set<TExcelSaveFormatNative, snXLS, snTabDelimited>  TSetOfExcelSaveFormatNative;

class DELPHICLASS TXLSAdapter;
class PASCALIMPLEMENTATION TXLSAdapter : public Uexceladapter::TExcelAdapter 
{
	typedef Uexceladapter::TExcelAdapter inherited;
	
private:
	Xlsbasetemplatestore::TXlsBaseTemplateStore* FTemplateStore;
	TSetOfExcelSaveFormatNative FSaveFormat;
	bool FAllowOverwritingFiles;
	void __fastcall SetTemplateStore(const Xlsbasetemplatestore::TXlsBaseTemplateStore* Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual TXLSAdapter(Classes::TComponent* AOwner);
	virtual Uexceladapter::TExcelFile* __fastcall GetWorkbook(void);
	
__published:
	__property TSetOfExcelSaveFormatNative SaveFormat = {read=FSaveFormat, write=FSaveFormat, default=1};
	__property Xlsbasetemplatestore::TXlsBaseTemplateStore* TemplateStore = {read=FTemplateStore, write=SetTemplateStore};
	__property bool AllowOverwritingFiles = {read=FAllowOverwritingFiles, write=FAllowOverwritingFiles, nodefault};
public:
	#pragma option push -w-inl
	/* TComponent.Destroy */ inline __fastcall virtual ~TXLSAdapter(void) { }
	#pragma option pop
	
};


class DELPHICLASS TXLSFile;
class PASCALIMPLEMENTATION TXLSFile : public Uexceladapter::TExcelFile 
{
	typedef Uexceladapter::TExcelFile inherited;
	
private:
	TXLSAdapter* FAdapter;
	int FActiveSheet;
	Uexcelrecords::TWorkbook* FWorkbook;
	DynamicArray<Byte >  FOtherStreams;
	int FirstColumn;
	int LastColumn;
	bool AllowOverwritingFiles;
	bool IsFileModified;
	Uflxrowcomments::TRowComments* RowPictures;
	void __fastcall ParsePictures(void);
	void __fastcall OpenStream(const Classes::TStream* aStream);
	void __fastcall PasteFromBiff8(const int Row, const int Col);
	void __fastcall PasteFromText(const int Row, const int Col);
	void __fastcall SaveAsXls(const AnsiString aFileName, const Classes::TStream* aStream)/* overload */;
	void __fastcall SaveAsXls(const Classes::TStream* aStream)/* overload */;
	void __fastcall SaveAsTextDelimited(const AnsiString FileName, const Classes::TStream* DataStream, const char Delim);
	void __fastcall InternalSetCellString(const int aRow, const int aCol, const WideString Text, const Uflxformats::PFlxFormat Fm, const WideString DateFormat, const WideString TimeFormat, const Uflxmessages::PFormatSettings FormatSettings);
	void __fastcall SetCellValueAndFmt(const int aRow, const int aCol, const Variant &v, const Uflxformats::PFlxFormat Fm);
	AnsiString __fastcall SkipThousands(const AnsiString s, const Uflxmessages::PFormatSettings FormatSettings);
	void __fastcall RestoreObjectSizes(void);
	void __fastcall GetPercentAndCurrencyFormat(const int aRow, const int aCol, Uflxformats::TFlxFormat &Fmt1, const bool HasExp, const bool HasPercent, const bool HasCurrency, const bool NeedsDecimals, const Uflxmessages::PFormatSettings FormatSettings);
	
protected:
	virtual int __fastcall GetActiveSheet(void);
	virtual void __fastcall SetActiveSheet(const int Value);
	virtual WideString __fastcall GetActiveSheetName();
	virtual void __fastcall SetActiveSheetName(const WideString Value);
	virtual WideString __fastcall GetActiveSheetCodeName();
	virtual void __fastcall SetActiveSheetCodeName(const WideString Value);
	virtual Uflxmessages::TXlsSheetVisible __fastcall GetActiveSheetVisible(void);
	virtual void __fastcall SetActiveSheetVisible(const Uflxmessages::TXlsSheetVisible Value);
	virtual int __fastcall GetColumnWidth(int aCol);
	virtual int __fastcall GetColumnWidthHiddenIsZero(int aCol);
	virtual int __fastcall GetRowHeight(int aRow);
	virtual int __fastcall GetRowHeightHiddenIsZero(int aRow);
	virtual void __fastcall SetColumnWidth(int aCol, const int Value);
	virtual void __fastcall SetRowHeight(int aRow, const int Value);
	virtual bool __fastcall GetRowHidden(const int aRow);
	virtual bool __fastcall GetColumnHidden(const int aCol);
	virtual void __fastcall SetRowHidden(const int aRow, const bool Value);
	virtual void __fastcall SetColumnHidden(const int aCol, const bool Value);
	virtual int __fastcall GetDefaultColWidth(void);
	virtual int __fastcall GetDefaultRowHeight(void);
	virtual int __fastcall GetCommentsCount(int Row);
	virtual WideString __fastcall GetCommentText(int Row, int aPos);
	virtual int __fastcall GetCommentColumn(int Row, int aPos);
	virtual WideString __fastcall GetPictureName(int Row, int aPos);
	virtual int __fastcall GetPicturesCount(int Row);
	virtual Variant __fastcall GetCellValue(int aRow, int aCol);
	virtual void __fastcall SetCellValue(int aRow, int aCol, const Variant &Value);
	virtual Uflxmessages::TXlsCellValue __fastcall GetCellValueX(int aRow, int aCol);
	virtual void __fastcall SetCellValueX(int aRow, int aCol, const Uflxmessages::TXlsCellValue &Value);
	virtual WideString __fastcall GetCellFormula(int aRow, int aCol);
	virtual void __fastcall SetCellFormula(int aRow, int aCol, const WideString Value);
	virtual bool __fastcall GetAutoRowHeight(int Row);
	virtual void __fastcall SetAutoRowHeight(int Row, const bool Value);
	virtual int __fastcall GetColumnFormat(int aColumn);
	virtual int __fastcall GetRowFormat(int aRow);
	virtual void __fastcall SetColumnFormat(int aColumn, const int Value);
	virtual void __fastcall SetRowFormat(int aRow, const int Value);
	virtual int __fastcall GetCellFormat(int aRow, int aCol);
	virtual void __fastcall SetCellFormat(int aRow, int aCol, const int Value);
	virtual unsigned __fastcall GetColorPalette(Uflxmessages::TColorPaletteRange Index);
	virtual void __fastcall SetColorPalette(Uflxmessages::TColorPaletteRange Index, const unsigned Value);
	virtual Uflxformats::TFlxFont __fastcall GetFontList(int index);
	virtual void __fastcall SetFontList(int index, const Uflxformats::TFlxFont &Value);
	virtual Uflxformats::TFlxFormat __fastcall GetFormatList(int index);
	virtual void __fastcall SetFormatList(int index, const Uflxformats::TFlxFormat &Value);
	virtual WideString __fastcall GetPageFooter();
	virtual WideString __fastcall GetPageHeader();
	virtual void __fastcall SetPageFooter(const WideString Value);
	virtual void __fastcall SetPageHeader(const WideString Value);
	virtual bool __fastcall GetShowGridLines(void);
	virtual void __fastcall SetShowGridLines(const bool Value);
	virtual bool __fastcall GetShowGridHeaders(void);
	virtual void __fastcall SetShowGridHeaders(const bool Value);
	virtual bool __fastcall GetPrintGridLines(void);
	virtual void __fastcall SetPrintGridLines(const bool Value);
	virtual bool __fastcall GetPrintHCentered(void);
	virtual bool __fastcall GetPrintVCentered(void);
	virtual void __fastcall SetPrintHCentered(const bool Value);
	virtual void __fastcall SetPrintVCentered(const bool Value);
	virtual int __fastcall GetSheetZoom(void);
	virtual void __fastcall SetSheetZoom(const int Value);
	virtual Uflxmessages::TXlsMargins __fastcall GetMargins();
	virtual void __fastcall SetMargins(const Uflxmessages::TXlsMargins &Value);
	virtual Word __fastcall GetPrintNumberOfHorizontalPages(void);
	virtual Word __fastcall GetPrintNumberOfVerticalPages(void);
	virtual int __fastcall GetPrintScale(void);
	virtual Byte __fastcall GetPrintOptions(void);
	virtual bool __fastcall GetPrintToFit(void);
	virtual void __fastcall SetPrintNumberOfHorizontalPages(const Word Value);
	virtual void __fastcall SetPrintNumberOfVerticalPages(const Word Value);
	virtual void __fastcall SetPrintScale(const int Value);
	virtual void __fastcall SetPrintToFit(const bool Value);
	virtual void __fastcall SetPrintOptions(const Byte Value);
	virtual int __fastcall GetPrintCopies(void);
	virtual Uflxmessages::TPrinterDriverSettings __fastcall GetPrinterDriverSettings();
	virtual int __fastcall GetPrintPaperSize(void);
	virtual int __fastcall GetPrintXResolution(void);
	virtual int __fastcall GetPrintYResolution(void);
	virtual void __fastcall SetPrintCopies(const int Value);
	virtual void __fastcall SetPrinterDriverSettings(const Uflxmessages::TPrinterDriverSettings &Value);
	virtual void __fastcall SetPrintPaperSize(const int Value);
	virtual void __fastcall SetPrintXResolution(const int Value);
	virtual void __fastcall SetPrintYResolution(const int Value);
	virtual Uflxmessages::TXlsCellRange __fastcall GetCellMergedBounds(int aRow, int aCol);
	virtual Uflxmessages::TXlsCellRange __fastcall GetCellMergedList(int index);
	virtual bool __fastcall GetOptions1904Dates(void);
	virtual bool __fastcall GetOptionsR1C1(void);
	virtual bool __fastcall GetOptionsSaveExternalLinkValues(void);
	virtual void __fastcall SetOptions1904Dates(const bool Value);
	virtual void __fastcall SetOptionsR1C1(const bool Value);
	virtual void __fastcall SetOptionsSaveExternalLinkValues(const bool Value);
	virtual bool __fastcall GetOptionsPrecisionAsDisplayed(void);
	virtual void __fastcall SetOptionsPrecisionAsDisplayed(const bool Value);
	virtual bool __fastcall GetOutlineSummaryColsRightOfDetail(void);
	virtual bool __fastcall GetOutlineSummaryRowsBelowDetail(void);
	virtual bool __fastcall GetOutlineAutomaticStyles(void);
	virtual void __fastcall SetOutlineSummaryColsRightOfDetail(const bool Value);
	virtual void __fastcall SetOutlineSummaryRowsBelowDetail(const bool Value);
	virtual void __fastcall SetOutlineAutomaticStyles(const bool Value);
	virtual bool __fastcall GetInvalidateFormulas(void);
	virtual void __fastcall SetInvalidateFormulas(const bool Value);
	virtual bool __fastcall GetIsXltTemplate(void);
	virtual void __fastcall SetIsXltTemplate(const bool Value);
	
public:
	__fastcall TXLSFile(const TXLSAdapter* aAdapter)/* overload */;
	__fastcall TXLSFile(const TXLSAdapter* aAdapter, const bool aAllowOverwritingFiles)/* overload */;
	__fastcall virtual ~TXLSFile(void);
	virtual void __fastcall Connect(void);
	virtual void __fastcall Disconnect(void);
	Uexcelrecords::TWorkbook* __fastcall GetTWorkbook(void);
	virtual void __fastcall NewFile(const int SheetCount = 0x3);
	virtual void __fastcall OpenFile(const AnsiString FileName);
	virtual void __fastcall OpenFileAndSearch(const AnsiString FileName);
	void __fastcall OpenFileAndOrSearch(const AnsiString FileName, const bool Search);
	virtual void __fastcall LoadFromStream(const Classes::TStream* aStream);
	virtual void __fastcall CloseFile(void);
	virtual void __fastcall InsertAndCopySheets(const int CopyFrom, const int InsertBefore, const int SheetCount);
	virtual void __fastcall ClearSheet(void);
	virtual void __fastcall DeleteSheet(int aSheetCount);
	virtual int __fastcall SheetCount(void);
	virtual void __fastcall SelectSheet(const int SheetNo);
	virtual void __fastcall DeleteMarkedRows(const WideString Mark);
	virtual void __fastcall RefreshChartRanges(const WideString VarStr);
	virtual void __fastcall MakePageBreaks(const WideString Mark);
	virtual void __fastcall InsertHPageBreak(const int Row);
	virtual void __fastcall InsertVPageBreak(const int Col);
	virtual void __fastcall DeleteHPageBreak(const int Row);
	virtual void __fastcall DeleteVPageBreak(const int Col);
	virtual bool __fastcall HasHPageBreak(const int Row);
	virtual bool __fastcall HasVPageBreak(const int Col);
	virtual void __fastcall RefreshPivotTables(void);
	virtual void __fastcall Save(const bool AutoClose, const AnsiString FileName, const Uflxmessages::TOnGetFileNameEvent OnGetFileName, const Uflxmessages::TOnGetOutStreamEvent OnGetOutStream = 0x0, const Classes::TStream* DataStream = (Classes::TStream*)(0x0));
	virtual void __fastcall InsertAndCopyRows(const int FirstRow, const int LastRow, const int DestRow, const int aCount, const bool OnlyFormulas);
	virtual void __fastcall InsertAndCopyCols(const int FirstCol, const int LastCol, const int DestCol, const int aCount, const bool OnlyFormulas);
	virtual void __fastcall DeleteRows(const int aRow, const int aCount);
	virtual void __fastcall DeleteCols(const int aCol, const int aCount);
	virtual void __fastcall BeginSheet(void);
	virtual void __fastcall EndSheet(const int RowOffset);
	virtual bool __fastcall CanOptimizeRead(void);
	virtual int __fastcall GetExcelNameCount(void);
	virtual WideString __fastcall GetRangeName(int index);
	virtual int __fastcall GetRangeR1(int index);
	virtual int __fastcall GetRangeR2(int index);
	virtual int __fastcall GetRangeC1(int index);
	virtual int __fastcall GetRangeC2(int index);
	virtual void __fastcall SetRangeR1(int index, int value);
	virtual void __fastcall SetRangeR2(int index, int value);
	virtual void __fastcall SetRangeC1(int index, int value);
	virtual void __fastcall SetRangeC2(int index, int value);
	virtual int __fastcall GetRangeSheet(int index);
	virtual void __fastcall AddRange(Uflxmessages::TXlsNamedRange &NamedRange);
	virtual void __fastcall AssignPicture(const int Row, const int aPos, const Uflxmessages::ByteArray Pic, const Uflxmessages::TXlsImgTypes PicType)/* overload */;
	virtual void __fastcall AssignPicture(const int Row, const int aPos, const Uflxmessages::ByteArray Pic, const Uflxmessages::TXlsImgTypes PicType, const Uflxmessages::TImageProperties &Props, const Uflxmessages::TFlxAnchorType Anchor = (Uflxmessages::TFlxAnchorType)(0x1))/* overload */;
	virtual void __fastcall AssignPictureProperties(const int Row, const int aPos, const Uflxmessages::TImageProperties &Props, const Uflxmessages::TFlxAnchorType Anchor = (Uflxmessages::TFlxAnchorType)(0x1));
	virtual void __fastcall GetPicture(const int Row, const int aPos, const Classes::TStream* Pic, /* out */ Uflxmessages::TXlsImgTypes &PicType, /* out */ Uflxmessages::TClientAnchor &Anchor);
	virtual void __fastcall DeleteImage(const int Index);
	virtual void __fastcall ClearImage(const int Index);
	virtual void __fastcall AddImage(const Uflxmessages::ByteArray Data, const Uflxmessages::TXlsImgTypes DataType, const Uflxmessages::TImageProperties &Properties, const Uflxmessages::TFlxAnchorType Anchor);
	virtual void __fastcall AssignComment(const int Row, const int aPos, const WideString Comment);
	virtual WideString __fastcall GetCellComment(int Row, int Col);
	virtual void __fastcall SetCellComment(int Row, int Col, const WideString Value, const Uflxmessages::TImageProperties &Properties);
	virtual int __fastcall CellMergedListCount(void);
	virtual void __fastcall MergeCells(const int FirstRow, const int FirstCol, const int LastRow, const int LastCol);
	virtual void __fastcall UnMergeCells(const int FirstRow, const int FirstCol, const int LastRow, const int LastCol);
	virtual int __fastcall CellCount(const int aRow);
	virtual Variant __fastcall GetCellData(const int aRow, const int aColOffset);
	virtual Uflxmessages::TXlsCellValue __fastcall GetCellDataX(const int aRow, const int aColOffset);
	virtual void __fastcall GetCellDataX2(const int aRow, const int aColOffset, /* out */ Uflxmessages::TXlsCellValue &v, /* out */ Uflxmessages::TRTFRunList &RTFRuns);
	virtual void __fastcall AssignCellData(const int aRow, const int aColOffset, const Variant &Value);
	virtual void __fastcall AssignCellDataX(const int aRow, const int aColOffset, const Uflxmessages::TXlsCellValue &Value);
	virtual void __fastcall AssignCellDataX2(const int aRow, const int aColOffset, const Uflxmessages::TXlsCellValue &Value, const Uflxmessages::TRTFRunList RTFRuns);
	virtual void __fastcall GetCellValueX2(int aRow, int aCol, /* out */ Uflxmessages::TXlsCellValue &v, /* out */ Uflxmessages::TRTFRunList &RTFRuns);
	virtual void __fastcall AssignCellValueX2(int aRow, int aCol, const Uflxmessages::TXlsCellValue &Value, const Uflxmessages::TRTFRunList RTFRuns);
	virtual void __fastcall SetCellFormulaX(int aRow, int aCol, const WideString Formula, const Variant &Value);
	virtual void __fastcall SetCellString(const int aRow, const int aCol, const WideString Text, const WideString DateFormat = L"", const WideString TimeFormat = L"")/* overload */;
	virtual void __fastcall SetCellString(const int aRow, const int aCol, const WideString Text, const Uflxformats::TFlxFormat &Fm, const WideString DateFormat = L"", const WideString TimeFormat = L"")/* overload */;
	virtual int __fastcall MaxRow(void);
	virtual int __fastcall MaxCol(void);
	virtual bool __fastcall IsEmptyRow(const int aRow);
	virtual int __fastcall ColByIndex(const int Row, const int ColIndex);
	virtual int __fastcall ColIndexCount(const int Row);
	virtual int __fastcall ColIndex(const int Row, const int Col);
	virtual void __fastcall SetBounds(const int aRangePos);
	virtual int __fastcall GetFirstColumn(void);
	virtual void __fastcall PrepareBlockData(const int R1, const int C1, const int R2, const int C2);
	virtual void __fastcall AssignBlockData(const int Row, const int Col, const Variant &v);
	virtual void __fastcall PasteBlockData(void);
	virtual bool __fastcall IsWorksheet(const int index);
	virtual int __fastcall FontListCount(void);
	virtual int __fastcall FormatListCount(void);
	virtual int __fastcall AddFont(const Uflxformats::TFlxFont &Fmt);
	virtual int __fastcall AddFormat(const Uflxformats::TFlxFormat &Fmt);
	void __fastcall CopyToClipboardFormat(const Uflxmessages::TXlsCellRange &Range, /* out */ AnsiString &textString, const Classes::TStream* xlsStream);
	virtual void __fastcall CopyToClipboard(void)/* overload */;
	virtual void __fastcall CopyToClipboard(const Uflxmessages::TXlsCellRange &Range)/* overload */;
	virtual void __fastcall PasteFromClipboard(const int Row, const int Col);
	void __fastcall PasteFromXlsClipboardFormat(const int Row, const int Col, const Classes::TStream* Stream);
	void __fastcall PasteFromTextClipboardFormat(const int Row, const int Col, const AnsiString Data);
	virtual void __fastcall ParseComments(void);
	virtual int __fastcall HyperLinkCount(void);
	virtual Uflxmessages::THyperLink __fastcall GetHyperLink(const int HyperLinkIndex);
	virtual void __fastcall SetHyperLink(const int HyperLinkIndex, const Uflxmessages::THyperLink &value);
	virtual Uflxmessages::TXlsCellRange __fastcall GetHyperLinkCellRange(const int HyperLinkIndex);
	virtual void __fastcall SetHyperLinkCellRange(const int HyperLinkIndex, const Uflxmessages::TXlsCellRange &CellRange);
	virtual void __fastcall AddHyperLink(const Uflxmessages::TXlsCellRange &CellRange, const Uflxmessages::THyperLink &value);
	virtual void __fastcall DeleteHyperLink(const int HyperLinkIndex);
	virtual int __fastcall GetRowOutlineLevel(const int aRow);
	virtual void __fastcall SetRowOutlineLevel(const int FirstRow, const int LastRow, const int Level);
	virtual int __fastcall GetColOutlineLevel(const int aCol);
	virtual void __fastcall SetColOutlineLevel(const int FirstCol, const int LastCol, const int Level);
	virtual Uflxmessages::BooleanArray __fastcall GetUsedPaletteColors();
	virtual void __fastcall FreezePanes(const int Row, const int Col);
	virtual void __fastcall GetFrozenPanes(/* out */ int &Row, /* out */ int &Col);
	virtual void __fastcall SplitWindow(const int xOffset, const int yOffset);
	virtual void __fastcall GetSplitWindow(/* out */ int &xOffset, /* out */ int &yOffset);
	virtual void __fastcall AutofitRow(const int row1, const int row2, const bool AutofitNotAutofittingRows, const bool keepHeightAutomatic, const Extended adjustment);
	virtual void __fastcall AutofitCol(const int Col1, const int Col2, const bool IgnoreStrings, const Extended Adjustment);
	virtual void __fastcall AutofitRowsOnWorkbook(const bool AutofitNotAutofittingRows, const bool KeepSizesAutomatic, const Extended Adjustment);
	virtual void __fastcall SetAutoFilter(const int row, const int col1, const int col2)/* overload */;
	virtual void __fastcall RemoveAutoFilter(void);
	virtual bool __fastcall HasAutoFilter(void)/* overload */;
	virtual bool __fastcall HasAutoFilter(const int row, const int col)/* overload */;
	virtual Uflxmessages::TXlsCellRange __fastcall GetAutoFilterRange();
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Xlsadapter */
using namespace Xlsadapter;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Xlsadapter
