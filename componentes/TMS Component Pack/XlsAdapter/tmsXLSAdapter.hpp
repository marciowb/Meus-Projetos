// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Tmsxlsadapter.pas' rev: 21.00

#ifndef TmsxlsadapterHPP
#define TmsxlsadapterHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Tmsuexceladapter.hpp>	// Pascal unit
#include <Tmsxlsbasetemplatestore.hpp>	// Pascal unit
#include <Tmsuflxmessages.hpp>	// Pascal unit
#include <Tmsuexcelrecords.hpp>	// Pascal unit
#include <Tmsxlsmessages.hpp>	// Pascal unit
#include <Tmsuflxrowcomments.hpp>	// Pascal unit
#include <Tmsuole2impl.hpp>	// Pascal unit
#include <Clipbrd.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Tmsuxlssheet.hpp>	// Pascal unit
#include <Tmsuflxformats.hpp>	// Pascal unit
#include <Tmsuxlsrowcolentries.hpp>	// Pascal unit
#include <Tmsuxlsxf.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Tmsxlsadapter
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TExcelSaveFormatNative { snXLS, snCSVComma, snCSVSemiColon, snTabDelimited };
#pragma option pop

typedef Set<TExcelSaveFormatNative, snXLS, snTabDelimited>  TSetOfExcelSaveFormatNative;

class DELPHICLASS TXLSAdapter;
class PASCALIMPLEMENTATION TXLSAdapter : public Tmsuexceladapter::TExcelAdapter
{
	typedef Tmsuexceladapter::TExcelAdapter inherited;
	
private:
	Tmsxlsbasetemplatestore::TXlsBaseTemplateStore* FTemplateStore;
	TSetOfExcelSaveFormatNative FSaveFormat;
	bool FAllowOverwritingFiles;
	void __fastcall SetTemplateStore(const Tmsxlsbasetemplatestore::TXlsBaseTemplateStore* Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual TXLSAdapter(Classes::TComponent* AOwner);
	virtual Tmsuexceladapter::TExcelFile* __fastcall GetWorkbook(void);
	
__published:
	__property TSetOfExcelSaveFormatNative SaveFormat = {read=FSaveFormat, write=FSaveFormat, default=1};
	__property Tmsxlsbasetemplatestore::TXlsBaseTemplateStore* TemplateStore = {read=FTemplateStore, write=SetTemplateStore};
	__property bool AllowOverwritingFiles = {read=FAllowOverwritingFiles, write=FAllowOverwritingFiles, nodefault};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TXLSAdapter(void) { }
	
};


class DELPHICLASS TXLSFile;
class PASCALIMPLEMENTATION TXLSFile : public Tmsuexceladapter::TExcelFile
{
	typedef Tmsuexceladapter::TExcelFile inherited;
	
private:
	TXLSAdapter* FAdapter;
	int FActiveSheet;
	Tmsuexcelrecords::TWorkbook* FWorkbook;
	Tmsuflxmessages::ByteArray FOtherStreams;
	int FirstColumn;
	int LastColumn;
	bool AllowOverwritingFiles;
	bool IsFileModified;
	Tmsuflxrowcomments::TRowComments* RowPictures;
	void __fastcall ParsePictures(void);
	void __fastcall OpenStream(const Classes::TStream* aStream);
	void __fastcall PasteFromBiff8(const int Row, const int Col);
	void __fastcall PasteFromText(const int Row, const int Col);
	void __fastcall SaveAsXls(const System::UnicodeString aFileName, const Classes::TStream* aStream)/* overload */;
	void __fastcall SaveAsXls(const Classes::TStream* aStream)/* overload */;
	void __fastcall SaveAsTextDelimited(const System::UnicodeString FileName, const Classes::TStream* DataStream, const System::WideChar Delim);
	void __fastcall InternalSetCellString(const int aRow, const int aCol, const System::UnicodeString Text, const Tmsuflxformats::PFlxFormat Fm, const System::UnicodeString DateFormat, const System::UnicodeString TimeFormat);
	void __fastcall SetCellValueAndFmt(const int aRow, const int aCol, const System::Variant &v, const Tmsuflxformats::PFlxFormat Fm);
	System::UnicodeString __fastcall SkipThousands(const System::UnicodeString s);
	void __fastcall RestoreObjectSizes(void);
	void __fastcall GetPercentAndCurrencyFormat(const int aRow, const int aCol, Tmsuflxformats::TFlxFormat &Fmt1, const bool HasExp, const bool HasPercent, const bool HasCurrency, const bool NeedsDecimals);
	
protected:
	virtual int __fastcall GetActiveSheet(void);
	virtual void __fastcall SetActiveSheet(const int Value);
	virtual System::UnicodeString __fastcall GetActiveSheetName(void);
	virtual void __fastcall SetActiveSheetName(const System::UnicodeString Value);
	virtual System::UnicodeString __fastcall GetActiveSheetCodeName(void);
	virtual void __fastcall SetActiveSheetCodeName(const System::UnicodeString Value);
	virtual Tmsuflxmessages::TXlsSheetVisible __fastcall GetActiveSheetVisible(void);
	virtual void __fastcall SetActiveSheetVisible(const Tmsuflxmessages::TXlsSheetVisible Value);
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
	virtual System::UnicodeString __fastcall GetCommentText(int Row, int aPos);
	virtual int __fastcall GetCommentColumn(int Row, int aPos);
	virtual System::UnicodeString __fastcall GetPictureName(int Row, int aPos);
	virtual int __fastcall GetPicturesCount(int Row);
	virtual System::Variant __fastcall GetCellValue(int aRow, int aCol);
	virtual void __fastcall SetCellValue(int aRow, int aCol, const System::Variant &Value);
	virtual Tmsuflxmessages::TXlsCellValue __fastcall GetCellValueX(int aRow, int aCol);
	virtual void __fastcall SetCellValueX(int aRow, int aCol, const Tmsuflxmessages::TXlsCellValue &Value);
	virtual System::UnicodeString __fastcall GetCellFormula(int aRow, int aCol);
	virtual void __fastcall SetCellFormula(int aRow, int aCol, const System::UnicodeString Value);
	virtual bool __fastcall GetAutoRowHeight(int Row);
	virtual void __fastcall SetAutoRowHeight(int Row, const bool Value);
	virtual int __fastcall GetColumnFormat(int aColumn);
	virtual int __fastcall GetRowFormat(int aRow);
	virtual void __fastcall SetColumnFormat(int aColumn, const int Value);
	virtual void __fastcall SetRowFormat(int aRow, const int Value);
	virtual int __fastcall GetCellFormat(int aRow, int aCol);
	virtual void __fastcall SetCellFormat(int aRow, int aCol, const int Value);
	virtual unsigned __fastcall GetColorPalette(Tmsuflxmessages::TColorPaletteRange Index);
	virtual void __fastcall SetColorPalette(Tmsuflxmessages::TColorPaletteRange Index, const unsigned Value);
	virtual Tmsuflxformats::TFlxFont __fastcall GetFontList(int index);
	virtual void __fastcall SetFontList(int index, const Tmsuflxformats::TFlxFont &Value);
	virtual Tmsuflxformats::TFlxFormat __fastcall GetFormatList(int index);
	virtual void __fastcall SetFormatList(int index, const Tmsuflxformats::TFlxFormat &Value);
	virtual System::UnicodeString __fastcall GetPageFooter(void);
	virtual System::UnicodeString __fastcall GetPageHeader(void);
	virtual void __fastcall SetPageFooter(const System::UnicodeString Value);
	virtual void __fastcall SetPageHeader(const System::UnicodeString Value);
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
	virtual Tmsuflxmessages::TXlsMargins __fastcall GetMargins(void);
	virtual void __fastcall SetMargins(const Tmsuflxmessages::TXlsMargins &Value);
	virtual System::Word __fastcall GetPrintNumberOfHorizontalPages(void);
	virtual System::Word __fastcall GetPrintNumberOfVerticalPages(void);
	virtual int __fastcall GetPrintScale(void);
	virtual System::Byte __fastcall GetPrintOptions(void);
	virtual bool __fastcall GetPrintToFit(void);
	virtual void __fastcall SetPrintNumberOfHorizontalPages(const System::Word Value);
	virtual void __fastcall SetPrintNumberOfVerticalPages(const System::Word Value);
	virtual void __fastcall SetPrintScale(const int Value);
	virtual void __fastcall SetPrintToFit(const bool Value);
	virtual void __fastcall SetPrintOptions(const System::Byte Value);
	virtual int __fastcall GetPrintCopies(void);
	virtual Tmsuflxmessages::TPrinterDriverSettings __fastcall GetPrinterDriverSettings(void);
	virtual int __fastcall GetPrintPaperSize(void);
	virtual int __fastcall GetPrintXResolution(void);
	virtual int __fastcall GetPrintYResolution(void);
	virtual void __fastcall SetPrintCopies(const int Value);
	virtual void __fastcall SetPrinterDriverSettings(const Tmsuflxmessages::TPrinterDriverSettings &Value);
	virtual void __fastcall SetPrintPaperSize(const int Value);
	virtual void __fastcall SetPrintXResolution(const int Value);
	virtual void __fastcall SetPrintYResolution(const int Value);
	virtual Tmsuflxmessages::TXlsCellRange __fastcall GetCellMergedBounds(int aRow, int aCol);
	virtual Tmsuflxmessages::TXlsCellRange __fastcall GetCellMergedList(int index);
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
	Tmsuexcelrecords::TWorkbook* __fastcall GetTWorkbook(void);
	virtual void __fastcall NewFile(const int SheetCount = 0x3);
	virtual void __fastcall OpenFile(const Sysutils::TFileName FileName);
	virtual void __fastcall OpenFileAndSearch(const Sysutils::TFileName FileName);
	void __fastcall OpenFileAndOrSearch(const Sysutils::TFileName FileName, const bool Search);
	virtual void __fastcall LoadFromStream(const Classes::TStream* aStream);
	virtual void __fastcall CloseFile(void);
	virtual void __fastcall InsertAndCopySheets(const int CopyFrom, const int InsertBefore, const int SheetCount);
	virtual void __fastcall ClearSheet(void);
	virtual void __fastcall DeleteSheet(int aSheetCount);
	virtual int __fastcall SheetCount(void);
	virtual void __fastcall SelectSheet(const int SheetNo);
	virtual void __fastcall DeleteMarkedRows(const System::UnicodeString Mark);
	virtual void __fastcall RefreshChartRanges(const System::UnicodeString VarStr);
	virtual void __fastcall MakePageBreaks(const System::UnicodeString Mark);
	virtual void __fastcall InsertHPageBreak(const int Row);
	virtual void __fastcall InsertVPageBreak(const int Col);
	virtual void __fastcall DeleteHPageBreak(const int Row);
	virtual void __fastcall DeleteVPageBreak(const int Col);
	virtual bool __fastcall HasHPageBreak(const int Row);
	virtual bool __fastcall HasVPageBreak(const int Col);
	virtual void __fastcall RefreshPivotTables(void);
	virtual void __fastcall Save(const bool AutoClose, const System::UnicodeString FileName, const Tmsuflxmessages::TOnGetFileNameEvent OnGetFileName, const Tmsuflxmessages::TOnGetOutStreamEvent OnGetOutStream = 0x0, const Classes::TStream* DataStream = (Classes::TStream*)(0x0));
	virtual void __fastcall InsertAndCopyRows(const int FirstRow, const int LastRow, const int DestRow, const int aCount, const bool OnlyFormulas);
	virtual void __fastcall InsertAndCopyCols(const int FirstCol, const int LastCol, const int DestCol, const int aCount, const bool OnlyFormulas);
	virtual void __fastcall DeleteRows(const int aRow, const int aCount);
	virtual void __fastcall DeleteCols(const int aCol, const int aCount);
	virtual void __fastcall BeginSheet(void);
	virtual void __fastcall EndSheet(const int RowOffset);
	virtual bool __fastcall CanOptimizeRead(void);
	virtual int __fastcall GetExcelNameCount(void);
	virtual System::UnicodeString __fastcall GetRangeName(int index);
	virtual int __fastcall GetRangeR1(int index);
	virtual int __fastcall GetRangeR2(int index);
	virtual int __fastcall GetRangeC1(int index);
	virtual int __fastcall GetRangeC2(int index);
	virtual void __fastcall SetRangeR1(int index, int value);
	virtual void __fastcall SetRangeR2(int index, int value);
	virtual void __fastcall SetRangeC1(int index, int value);
	virtual void __fastcall SetRangeC2(int index, int value);
	virtual int __fastcall GetRangeSheet(int index);
	virtual void __fastcall AddRange(Tmsuflxmessages::TXlsNamedRange &NamedRange);
	virtual void __fastcall AssignPicture(const int Row, const int aPos, const Tmsuflxmessages::ByteArray Pic, const Tmsuflxmessages::TXlsImgTypes PicType)/* overload */;
	virtual void __fastcall AssignPicture(const int Row, const int aPos, const Tmsuflxmessages::ByteArray Pic, const Tmsuflxmessages::TXlsImgTypes PicType, const Tmsuflxmessages::TImageProperties &Props, const Tmsuflxmessages::TFlxAnchorType Anchor = (Tmsuflxmessages::TFlxAnchorType)(0x1))/* overload */;
	virtual void __fastcall AssignPictureProperties(const int Row, const int aPos, const Tmsuflxmessages::TImageProperties &Props, const Tmsuflxmessages::TFlxAnchorType Anchor = (Tmsuflxmessages::TFlxAnchorType)(0x1));
	virtual void __fastcall GetPicture(const int Row, const int aPos, const Classes::TStream* Pic, /* out */ Tmsuflxmessages::TXlsImgTypes &PicType, /* out */ Tmsuflxmessages::TClientAnchor &Anchor);
	virtual void __fastcall DeleteImage(const int Index);
	virtual void __fastcall ClearImage(const int Index);
	virtual void __fastcall AddImage(const Tmsuflxmessages::ByteArray Data, const Tmsuflxmessages::TXlsImgTypes DataType, const Tmsuflxmessages::TImageProperties &Properties, const Tmsuflxmessages::TFlxAnchorType Anchor);
	virtual void __fastcall AssignComment(const int Row, const int aPos, const System::UnicodeString Comment);
	virtual System::UnicodeString __fastcall GetCellComment(int Row, int Col);
	virtual void __fastcall SetCellComment(int Row, int Col, const System::UnicodeString Value, const Tmsuflxmessages::TImageProperties &Properties);
	virtual int __fastcall CellMergedListCount(void);
	virtual void __fastcall MergeCells(const int FirstRow, const int FirstCol, const int LastRow, const int LastCol);
	virtual void __fastcall UnMergeCells(const int FirstRow, const int FirstCol, const int LastRow, const int LastCol);
	virtual int __fastcall CellCount(const int aRow);
	virtual System::Variant __fastcall GetCellData(const int aRow, const int aColOffset);
	virtual Tmsuflxmessages::TXlsCellValue __fastcall GetCellDataX(const int aRow, const int aColOffset);
	virtual void __fastcall GetCellDataX2(const int aRow, const int aColOffset, /* out */ Tmsuflxmessages::TXlsCellValue &v, /* out */ Tmsuflxmessages::TRTFRunList &RTFRuns);
	virtual void __fastcall AssignCellData(const int aRow, const int aColOffset, const System::Variant &Value);
	virtual void __fastcall AssignCellDataX(const int aRow, const int aColOffset, const Tmsuflxmessages::TXlsCellValue &Value);
	virtual void __fastcall AssignCellDataX2(const int aRow, const int aColOffset, const Tmsuflxmessages::TXlsCellValue &Value, const Tmsuflxmessages::TRTFRunList RTFRuns);
	virtual void __fastcall GetCellValueX2(int aRow, int aCol, /* out */ Tmsuflxmessages::TXlsCellValue &v, /* out */ Tmsuflxmessages::TRTFRunList &RTFRuns);
	virtual void __fastcall AssignCellValueX2(int aRow, int aCol, const Tmsuflxmessages::TXlsCellValue &Value, const Tmsuflxmessages::TRTFRunList RTFRuns);
	virtual void __fastcall SetCellFormulaX(int aRow, int aCol, const System::UnicodeString Formula, const System::Variant &Value);
	virtual void __fastcall SetCellString(const int aRow, const int aCol, const System::UnicodeString Text, const System::UnicodeString DateFormat = L"", const System::UnicodeString TimeFormat = L"")/* overload */;
	virtual void __fastcall SetCellString(const int aRow, const int aCol, const System::UnicodeString Text, const Tmsuflxformats::TFlxFormat &Fm, const System::UnicodeString DateFormat = L"", const System::UnicodeString TimeFormat = L"")/* overload */;
	virtual int __fastcall MaxRow(void);
	virtual int __fastcall MaxCol(void);
	virtual bool __fastcall IsEmptyRow(const int aRow);
	virtual int __fastcall ColByIndex(const int Row, const int ColIndex);
	virtual int __fastcall ColIndexCount(const int Row);
	virtual int __fastcall ColIndex(const int Row, const int Col);
	virtual void __fastcall SetBounds(const int aRangePos);
	virtual int __fastcall GetFirstColumn(void);
	virtual void __fastcall PrepareBlockData(const int R1, const int C1, const int R2, const int C2);
	virtual void __fastcall AssignBlockData(const int Row, const int Col, const System::Variant &v);
	virtual void __fastcall PasteBlockData(void);
	virtual bool __fastcall IsWorksheet(const int index);
	virtual int __fastcall FontListCount(void);
	virtual int __fastcall FormatListCount(void);
	virtual int __fastcall AddFont(const Tmsuflxformats::TFlxFont &Fmt);
	virtual int __fastcall AddFormat(const Tmsuflxformats::TFlxFormat &Fmt);
	void __fastcall CopyToClipboardFormat(const Tmsuflxmessages::TXlsCellRange &Range, /* out */ System::UnicodeString &textString, const Classes::TStream* xlsStream);
	virtual void __fastcall CopyToClipboard(void)/* overload */;
	virtual void __fastcall CopyToClipboard(const Tmsuflxmessages::TXlsCellRange &Range)/* overload */;
	virtual void __fastcall PasteFromClipboard(const int Row, const int Col);
	void __fastcall PasteFromXlsClipboardFormat(const int Row, const int Col, const Classes::TStream* Stream);
	void __fastcall PasteFromTextClipboardFormat(const int Row, const int Col, const System::UnicodeString Data);
	virtual void __fastcall ParseComments(void);
	virtual int __fastcall HyperLinkCount(void);
	virtual Tmsuflxmessages::THyperLink __fastcall GetHyperLink(const int HyperLinkIndex);
	virtual void __fastcall SetHyperLink(const int HyperLinkIndex, const Tmsuflxmessages::THyperLink &value);
	virtual Tmsuflxmessages::TXlsCellRange __fastcall GetHyperLinkCellRange(const int HyperLinkIndex);
	virtual void __fastcall SetHyperLinkCellRange(const int HyperLinkIndex, const Tmsuflxmessages::TXlsCellRange &CellRange);
	virtual void __fastcall AddHyperLink(const Tmsuflxmessages::TXlsCellRange &CellRange, const Tmsuflxmessages::THyperLink &value);
	virtual void __fastcall DeleteHyperLink(const int HyperLinkIndex);
	virtual int __fastcall GetRowOutlineLevel(const int aRow);
	virtual void __fastcall SetRowOutlineLevel(const int FirstRow, const int LastRow, const int Level);
	virtual int __fastcall GetColOutlineLevel(const int aCol);
	virtual void __fastcall SetColOutlineLevel(const int FirstCol, const int LastCol, const int Level);
	virtual Tmsuflxmessages::BooleanArray __fastcall GetUsedPaletteColors(void);
	virtual void __fastcall FreezePanes(const int Row, const int Col);
	virtual void __fastcall GetFrozenPanes(/* out */ int &Row, /* out */ int &Col);
	virtual void __fastcall SplitWindow(const int xOffset, const int yOffset);
	virtual void __fastcall GetSplitWindow(/* out */ int &xOffset, /* out */ int &yOffset);
	virtual void __fastcall AutofitRow(const int row1, const int row2, const bool AutofitNotAutofittingRows, const bool keepHeightAutomatic, const System::Extended adjustment);
	virtual void __fastcall AutofitCol(const int Col1, const int Col2, const bool IgnoreStrings, const System::Extended Adjustment);
	virtual void __fastcall AutofitRowsOnWorkbook(const bool AutofitNotAutofittingRows, const bool KeepSizesAutomatic, const System::Extended Adjustment);
	virtual void __fastcall SetAutoFilter(const int row, const int col1, const int col2)/* overload */;
	virtual void __fastcall RemoveAutoFilter(void);
	virtual bool __fastcall HasAutoFilter(void)/* overload */;
	virtual bool __fastcall HasAutoFilter(const int row, const int col)/* overload */;
	virtual Tmsuflxmessages::TXlsCellRange __fastcall GetAutoFilterRange(void);
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Tmsxlsadapter */
using namespace Tmsxlsadapter;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TmsxlsadapterHPP
