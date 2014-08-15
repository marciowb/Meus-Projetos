// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Tmsadvgridexcel.pas' rev: 21.00

#ifndef TmsadvgridexcelHPP
#define TmsadvgridexcelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Tmsxlsadapter.hpp>	// Pascal unit
#include <Tmsuexceladapter.hpp>	// Pascal unit
#include <Tmsuflxutils.hpp>	// Pascal unit
#include <Advgrid.hpp>	// Pascal unit
#include <Advgridworkbook.hpp>	// Pascal unit
#include <Tmsuflxformats.hpp>	// Pascal unit
#include <Tmsuflxmessages.hpp>	// Pascal unit
#include <Basegrid.hpp>	// Pascal unit
#include <Advobj.hpp>	// Pascal unit
#include <Tmsuxlspictures.hpp>	// Pascal unit
#include <Shellapi.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Printers.hpp>	// Pascal unit
#include <Tmsxlsmessages.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Pngimage.hpp>	// Pascal unit
#include <Zlib.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Asghtmle.hpp>	// Pascal unit
#include <Jpeg.hpp>	// Pascal unit
#include <Tmsuflxnumberformat.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Tmsadvgridexcel
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TFlxFormatCellEvent)(Advgrid::TAdvStringGrid* Sender, const int GridCol, const int GridRow, const int XlsCol, const int XlsRow, const System::WideString Value, System::WideString &DateFormat, System::WideString &TimeFormat);

typedef void __fastcall (__closure *TFlxFormatCellGenericEvent)(Advgrid::TAdvStringGrid* Sender, const int GridCol, const int GridRow, const int XlsCol, const int XlsRow, const System::WideString Value, Tmsuflxformats::TFlxFormat &Format);

typedef void __fastcall (__closure *TFlxGetCellFormulaEvent)(Advgrid::TAdvStringGrid* Sender, const int GridCol, const int GridRow, const System::WideString Value, System::WideString &Formula);

typedef void __fastcall (__closure *TASGIOProgressEvent)(System::TObject* Sender, int SheetNum, int SheetTot, int RowNum, int RowTot);

typedef void __fastcall (__closure *TExportColumnFormatEvent)(System::TObject* Sender, int GridCol, int GridRow, int XlsCol, int XlsRow, const System::WideString Value, bool &ExportCellAsString);

typedef void __fastcall (__closure *TGetCommentBoxSizeEvent)(System::TObject* Sender, const System::WideString Comment, int &Height, int &Width);

#pragma option push -b-
enum TOverwriteMode { omNever, omAlways, omWarn };
#pragma option pop

#pragma option push -b-
enum TInsertInSheet { InsertInSheet_Clear, InsertInSheet_OverwriteCells, InsertInSheet_InsertRows, InsertInSheet_InsertCols, InsertInSheet_InsertRowsExceptFirstAndSecond, InsertInSheet_InsertColsExceptFirstAndSecond };
#pragma option pop

class DELPHICLASS TASGIOOptions;
class PASCALIMPLEMENTATION TASGIOOptions : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FImportCellProperties;
	bool FImportCellSizes;
	bool FImportCellFormats;
	bool FImportFormulas;
	bool FImportImages;
	bool FImportPrintOptions;
	bool FImportActiveSheet;
	bool FExportCellSizes;
	bool FExportCellFormats;
	bool FExportFormulas;
	bool FExportCellProperties;
	bool FExportWordWrapped;
	bool FExportHTMLTags;
	bool FExportRawRTF;
	bool FExportHiddenColumns;
	bool FExportHiddenRows;
	bool FExportShowInExcel;
	System::UnicodeString FExportOverwriteMessage;
	TOverwriteMode FExportOverwrite;
	bool FExportHardBorders;
	bool FUseExcelStandardColorPalette;
	bool FExportShowGridLines;
	bool FImportLockedCellsAsReadonly;
	bool FExportReadonlyCellsAsLocked;
	bool FExportPrintOptions;
	bool FExportSummaryRowsBelowDetail;
	bool FExportCellMargins;
	
public:
	__fastcall TASGIOOptions(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool ImportFormulas = {read=FImportFormulas, write=FImportFormulas, default=1};
	__property bool ImportImages = {read=FImportImages, write=FImportImages, default=1};
	__property bool ImportCellFormats = {read=FImportCellFormats, write=FImportCellFormats, default=1};
	__property bool ImportCellProperties = {read=FImportCellProperties, write=FImportCellProperties, default=0};
	__property bool ImportCellSizes = {read=FImportCellSizes, write=FImportCellSizes, default=1};
	__property bool ImportLockedCellsAsReadonly = {read=FImportLockedCellsAsReadonly, write=FImportLockedCellsAsReadonly, default=0};
	__property TOverwriteMode ExportOverwrite = {read=FExportOverwrite, write=FExportOverwrite, default=0};
	__property System::UnicodeString ExportOverwriteMessage = {read=FExportOverwriteMessage, write=FExportOverwriteMessage};
	__property bool ExportFormulas = {read=FExportFormulas, write=FExportFormulas, default=1};
	__property bool ExportCellFormats = {read=FExportCellFormats, write=FExportCellFormats, default=1};
	__property bool ExportCellProperties = {read=FExportCellProperties, write=FExportCellProperties, default=1};
	__property bool ExportCellSizes = {read=FExportCellSizes, write=FExportCellSizes, default=1};
	__property bool ExportHiddenColumns = {read=FExportHiddenColumns, write=FExportHiddenColumns, default=0};
	__property bool ExportReadonlyCellsAsLocked = {read=FExportReadonlyCellsAsLocked, write=FExportReadonlyCellsAsLocked, default=0};
	__property bool ExportWordWrapped = {read=FExportWordWrapped, write=FExportWordWrapped, default=0};
	__property bool ExportHTMLTags = {read=FExportHTMLTags, write=FExportHTMLTags, default=1};
	__property bool ExportRawRTF = {read=FExportRawRTF, write=FExportRawRTF, default=1};
	__property bool ExportShowInExcel = {read=FExportShowInExcel, write=FExportShowInExcel, default=0};
	__property bool ExportHardBorders = {read=FExportHardBorders, write=FExportHardBorders, default=0};
	__property bool ExportShowGridLines = {read=FExportShowGridLines, write=FExportShowGridLines, default=1};
	__property bool ExportPrintOptions = {read=FExportPrintOptions, write=FExportPrintOptions, default=1};
	__property bool ImportPrintOptions = {read=FImportPrintOptions, write=FImportPrintOptions, default=1};
	__property bool ImportActiveSheet = {read=FImportActiveSheet, write=FImportActiveSheet, default=0};
	__property bool ExportSummaryRowsBelowDetail = {read=FExportSummaryRowsBelowDetail, write=FExportSummaryRowsBelowDetail, default=0};
	__property bool ExportCellMargins = {read=FExportCellMargins, write=FExportCellMargins, default=0};
	__property bool UseExcelStandardColorPalette = {read=FUseExcelStandardColorPalette, write=FUseExcelStandardColorPalette, default=1};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TASGIOOptions(void) { }
	
};


class DELPHICLASS TAGrid;
class PASCALIMPLEMENTATION TAGrid : public Advgrid::TAdvStringGrid
{
	typedef Advgrid::TAdvStringGrid inherited;
	
public:
	/* TAdvStringGrid.Create */ inline __fastcall virtual TAGrid(Classes::TComponent* AOwner) : Advgrid::TAdvStringGrid(AOwner) { }
	/* TAdvStringGrid.Destroy */ inline __fastcall virtual ~TAGrid(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAGrid(HWND ParentWindow) : Advgrid::TAdvStringGrid(ParentWindow) { }
	
};


struct TOneRowBorder
{
	
public:
	bool HasBottom;
	bool HasRight;
	int BottomColor;
	int RightColor;
};


typedef DynamicArray<TOneRowBorder> TRowBorderArray;

class DELPHICLASS TAdvGridExcelIO;
class PASCALIMPLEMENTATION TAdvGridExcelIO : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	typedef DynamicArray<System::UnicodeString> _TAdvGridExcelIO__1;
	
	
private:
	Advgrid::TAdvStringGrid* FAdvStringGrid;
	Advgridworkbook::TAdvGridWorkbook* FAdvGridWorkbook;
	Tmsuexceladapter::TExcelAdapter* FAdapter;
	bool FAutoResizeGrid;
	bool FUseUnicode;
	_TAdvGridExcelIO__1 FSheetNames;
	int FGridStartCol;
	int FGridStartRow;
	int FXlsStartRow;
	int FXlsStartCol;
	bool FZoomSaved;
	int FZoom;
	int FWorkSheet;
	int FWorkSheetNum;
	System::UnicodeString FDateFormat;
	System::UnicodeString FTimeFormat;
	TASGIOOptions* FOptions;
	TFlxFormatCellEvent FOnDateTimeFormat;
	TFlxFormatCellGenericEvent FOnCellFormat;
	TASGIOProgressEvent FOnProgress;
	TExportColumnFormatEvent FOnExportColumnFormat;
	TGetCommentBoxSizeEvent FOnGetCommentBoxSize;
	TFlxGetCellFormulaEvent FOnGetCellFormula;
	void __fastcall SetAdvStringGrid(const Advgrid::TAdvStringGrid* Value);
	void __fastcall SetAdvGridWorkbook(const Advgridworkbook::TAdvGridWorkbook* Value);
	TAGrid* __fastcall CurrentGrid(void);
	void __fastcall ImportData(const Tmsuexceladapter::TExcelFile* Workbook);
	void __fastcall ExportData(const Tmsuexceladapter::TExcelFile* Workbook);
	void __fastcall CloseFile(Tmsuexceladapter::TExcelFile* &Workbook);
	Tmsuflxformats::TFlxFormat __fastcall CellFormatDef(const Tmsuexceladapter::TExcelFile* Workbook, const int aRow, const int aCol);
	Graphics::TColor __fastcall GetColor(const Tmsuexceladapter::TExcelFile* Workbook, const Tmsuflxformats::TFlxFormat &Fm);
	System::UnicodeString __fastcall GetSheetNames(int index);
	int __fastcall GetSheetNamesCount(void);
	void __fastcall SetGridStartCol(const int Value);
	void __fastcall SetGridStartRow(const int Value);
	void __fastcall SetXlsStartCol(const int Value);
	void __fastcall SetXlsStartRow(const int Value);
	void __fastcall OpenText(const Tmsuexceladapter::TExcelFile* Workbook, const Sysutils::TFileName FileName, const System::WideChar Delimiter);
	void __fastcall SetZoom(const int Value);
	void __fastcall ImportImages(const Tmsuexceladapter::TExcelFile* Workbook, const System::Extended Zoom100);
	void __fastcall ExportImage(const Tmsuexceladapter::TExcelFile* Workbook, const Graphics::TGraphic* Pic, const int rx, const int cx, const int cg, const int rg);
	void __fastcall InternalXLSImport(const Sysutils::TFileName FileName, const int SheetNumber, const System::UnicodeString SheetName);
	System::UnicodeString __fastcall SupressCR(System::UnicodeString s);
	bool __fastcall IsRtf(const System::UnicodeString Value);
	bool __fastcall FindSheet(const Tmsuexceladapter::TExcelFile* Workbook, const System::UnicodeString SheetName, /* out */ int &index);
	void __fastcall SetOptions(const TASGIOOptions* Value);
	void __fastcall SetBorders(const int cg, const int rg, TRowBorderArray &LastRowBorders, int SpanRow, int SpanCol, Tmsuflxformats::TFlxFormat &Fm, const Tmsuexceladapter::TExcelFile* Workbook, const Tmsuflxmessages::BooleanArray UsedColors);
	void __fastcall CopyFmToMerged(const Tmsuexceladapter::TExcelFile* Workbook, const Basegrid::TCellProperties* cp, const int rx, const int cx, const Tmsuflxformats::TFlxFormat &Fm);
	void __fastcall ImportNodes(const Tmsuexceladapter::TExcelFile* Workbook, const int first, const int last, const int level);
	void __fastcall ImportAllNodes(const Tmsuexceladapter::TExcelFile* Workbook, const int first, const int last);
	System::UnicodeString __fastcall WideAdjustLineBreaks(const System::UnicodeString w);
	int __fastcall NearestColorIndex(const Tmsuexceladapter::TExcelFile* Workbook, const Graphics::TColor aColor, const Tmsuflxmessages::BooleanArray UsedColors);
	Tmsuflxmessages::BooleanArray __fastcall GetUsedPaletteColors(const Tmsuexceladapter::TExcelFile* Workbook);
	void __fastcall OpenFile(const Tmsuexceladapter::TExcelFile* Workbook, const System::UnicodeString FileName);
	void __fastcall ResizeCommentBox(const Tmsuexceladapter::TExcelFile* Workbook, const System::UnicodeString Comment, int &h, int &w);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	System::UnicodeString __fastcall RichToText(const System::UnicodeString RTFText);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	void __fastcall XLSImport(const Sysutils::TFileName FileName)/* overload */;
	void __fastcall XLSImport(const Sysutils::TFileName FileName, const int SheetNumber)/* overload */;
	void __fastcall XLSImport(const Sysutils::TFileName FileName, const System::UnicodeString SheetName)/* overload */;
	void __fastcall XLSExport(const Sysutils::TFileName FileName, const System::UnicodeString SheetName = L"", const int SheetPos = 0xffffffff, const int SelectSheet = 0x1, const TInsertInSheet InsertInSheet = (TInsertInSheet)(0x0));
	void __fastcall LoadSheetNames(const System::UnicodeString FileName);
	__property System::UnicodeString SheetNames[int index] = {read=GetSheetNames};
	__property int SheetNamesCount = {read=GetSheetNamesCount, nodefault};
	__fastcall virtual TAdvGridExcelIO(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvGridExcelIO(void);
	
__published:
	__property Advgrid::TAdvStringGrid* AdvStringGrid = {read=FAdvStringGrid, write=SetAdvStringGrid};
	__property Advgridworkbook::TAdvGridWorkbook* AdvGridWorkbook = {read=FAdvGridWorkbook, write=SetAdvGridWorkbook};
	__property bool AutoResizeGrid = {read=FAutoResizeGrid, write=FAutoResizeGrid, default=1};
	__property TASGIOOptions* Options = {read=FOptions, write=SetOptions};
	__property bool UseUnicode = {read=FUseUnicode, write=FUseUnicode, nodefault};
	__property int GridStartRow = {read=FGridStartRow, write=SetGridStartRow, default=1};
	__property int GridStartCol = {read=FGridStartCol, write=SetGridStartCol, default=1};
	__property int XlsStartRow = {read=FXlsStartRow, write=SetXlsStartRow, default=1};
	__property int XlsStartCol = {read=FXlsStartCol, write=SetXlsStartCol, default=1};
	__property bool ZoomSaved = {read=FZoomSaved, write=FZoomSaved, default=1};
	__property int Zoom = {read=FZoom, write=SetZoom, default=100};
	__property System::UnicodeString DateFormat = {read=FDateFormat, write=FDateFormat};
	__property System::UnicodeString TimeFormat = {read=FTimeFormat, write=FTimeFormat};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property TFlxFormatCellEvent OnDateTimeFormat = {read=FOnDateTimeFormat, write=FOnDateTimeFormat};
	__property TFlxFormatCellGenericEvent OnCellFormat = {read=FOnCellFormat, write=FOnCellFormat};
	__property TASGIOProgressEvent OnProgress = {read=FOnProgress, write=FOnProgress};
	__property TExportColumnFormatEvent OnExportColumnFormat = {read=FOnExportColumnFormat, write=FOnExportColumnFormat};
	__property TGetCommentBoxSizeEvent OnGetCommentBoxSize = {read=FOnGetCommentBoxSize, write=FOnGetCommentBoxSize};
	__property TFlxGetCellFormulaEvent OnGetCellFormula = {read=FOnGetCellFormula, write=FOnGetCellFormula};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt CellOfs = 0x0;

}	/* namespace Tmsadvgridexcel */
using namespace Tmsadvgridexcel;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TmsadvgridexcelHPP
