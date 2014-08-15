// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Uflexcelgrid.pas' rev: 10.00

#ifndef UflexcelgridHPP
#define UflexcelgridHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Jpeg.hpp>	// Pascal unit
#include <Printers.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Uexceladapter.hpp>	// Pascal unit
#include <Uflexcelimport.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit
#include <Uflxformats.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit
#include <Xlsmessages.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Uflxnumberformat.hpp>	// Pascal unit
#include <Uxlspictures.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Uflexcelgrid
{
//-- type declarations -------------------------------------------------------
typedef DynamicArray<DynamicArray<Uflxmessages::TRTFRun > >  TRTFRunListList;

class DELPHICLASS TFlxInPlaceEdit;
class PASCALIMPLEMENTATION TFlxInPlaceEdit : public Grids::TInplaceEdit 
{
	typedef Grids::TInplaceEdit inherited;
	
public:
	__property Font ;
public:
	#pragma option push -w-inl
	/* TInplaceEdit.Create */ inline __fastcall virtual TFlxInPlaceEdit(Classes::TComponent* AOwner) : Grids::TInplaceEdit(AOwner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TFlxInPlaceEdit(HWND ParentWindow) : Grids::TInplaceEdit(ParentWindow) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TWinControl.Destroy */ inline __fastcall virtual ~TFlxInPlaceEdit(void) { }
	#pragma option pop
	
};


struct TSavedFont
{
	
public:
	AnsiString Name;
	Graphics::TColor Color;
	Graphics::TFontStyles Style;
	int Height;
	int Rotation;
} ;

typedef void __fastcall (__closure *TOnGetFontNameEvent)(System::TObject* Sender, AnsiString &FontName);

typedef void __fastcall (__closure *TOnFormatPictureEvent)(System::TObject* Sender, const Classes::TStream* InData, const Uflxmessages::TXlsImgTypes PicType, const Graphics::TPicture* OutPicture);

typedef void __fastcall (__closure *TWideSetEditEvent)(System::TObject* Sender, int ACol, int ARow, const WideString Value);

typedef void __fastcall (__closure *TOnAllowEditCellEvent)(System::TObject* Sender, int ACol, int ARow, bool &AllowEdit);

typedef void __fastcall (__closure *TOnZoomChangedEvent)(System::TObject* Sender, int Zoom);

class DELPHICLASS TPictureData;
class PASCALIMPLEMENTATION TPictureData : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	int Col1;
	int Row1;
	int Col2;
	int Row2;
	int Dx1;
	int DY1;
	int Width;
	int Height;
	bool IsRectangular;
	Graphics::TPicture* Data;
	__fastcall TPictureData(void);
	__fastcall virtual ~TPictureData(void);
};


class DELPHICLASS TPictureDataList;
class PASCALIMPLEMENTATION TPictureDataList : public Contnrs::TObjectList 
{
	typedef Contnrs::TObjectList inherited;
	
public:
	TPictureData* operator[](int index) { return Items[index]; }
	
private:
	TPictureData* __fastcall GetItems(int index);
	void __fastcall SetItems(int index, const TPictureData* Value);
	
public:
	__property TPictureData* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(TPictureData* aRecord);
	HIDESBASE void __fastcall Insert(int Index, TPictureData* aRecord);
public:
	#pragma option push -w-inl
	/* TObjectList.Create */ inline __fastcall TPictureDataList(void)/* overload */ : Contnrs::TObjectList() { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TList.Destroy */ inline __fastcall virtual ~TPictureDataList(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSpawnedCell;
class PASCALIMPLEMENTATION TSpawnedCell : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	__int64 RowCol;
	__fastcall TSpawnedCell(const int aRow, const int aCol);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TSpawnedCell(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSpawnedCellList;
class PASCALIMPLEMENTATION TSpawnedCellList : public Contnrs::TObjectList 
{
	typedef Contnrs::TObjectList inherited;
	
public:
	TSpawnedCell* operator[](int index) { return Items[index]; }
	
private:
	TSpawnedCell* __fastcall GetItems(int index);
	void __fastcall SetItems(int index, const TSpawnedCell* Value);
	
public:
	__property TSpawnedCell* Items[int index] = {read=GetItems, write=SetItems/*, default*/};
	HIDESBASE int __fastcall Add(TSpawnedCell* aRecord);
	HIDESBASE void __fastcall Insert(int Index, TSpawnedCell* aRecord);
	
private:
	bool Sorted;
	
public:
	bool __fastcall Find(const __int64 aItem, int &Index);
	HIDESBASE void __fastcall Sort(void);
public:
	#pragma option push -w-inl
	/* TObjectList.Create */ inline __fastcall TSpawnedCellList(void)/* overload */ : Contnrs::TObjectList() { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TList.Destroy */ inline __fastcall virtual ~TSpawnedCellList(void) { }
	#pragma option pop
	
};


class DELPHICLASS TFlexCelGrid;
class PASCALIMPLEMENTATION TFlexCelGrid : public Grids::TCustomGrid 
{
	typedef Grids::TCustomGrid inherited;
	
private:
	Uflexcelimport::TFlexCelImport* FFlexCelImport;
	bool FFormulaReadOnly;
	bool FFullWorksheet;
	bool FReadOnly;
	bool FHideCursor;
	bool FDrawGridLines;
	bool SheetLoaded;
	Graphics::TFont* InPlaceFont;
	bool LMouseDown;
	int LastRow;
	int LastCol;
	int LastTopRow;
	int LastLeftCol;
	bool LastBigCursor;
	int FZoom;
	Extended DisplayZoom100;
	bool UpdatingGridSize;
	bool UpdatingGrid;
	TOnGetFontNameEvent FOnGetFontName;
	TOnFormatPictureEvent FOnFormatPicture;
	Grids::TSelectCellEvent FOnSelectCell;
	TPictureDataList* PictureDataList;
	TWideSetEditEvent FOnSetEditText;
	TOnAllowEditCellEvent FOnAllowEditCell;
	int FPrintLineWidth;
	bool FUseFixedCells;
	int FScrollWheelOffset;
	TOnZoomChangedEvent FOnZoomChanged;
	Classes::TNotifyEvent FOnTopLeftChanged;
	Classes::TNotifyEvent FOnColWidthsChanged;
	Classes::TNotifyEvent FOnRowHeightsChanged;
	bool FShowHiddenRows;
	bool FShowHiddenCols;
	Graphics::TColor FBackgroundColor;
	Graphics::TColor FForegroundColor;
	void __fastcall SetFlexCelImport(const Uflexcelimport::TFlexCelImport* Value);
	AnsiString __fastcall ColTitle(const int i);
	Variant __fastcall GetCellValue(const int ARow, const int ACol);
	bool __fastcall IsEmptyCell(const int ARow, const int ACol);
	void __fastcall MyDrawCell(const Graphics::TCanvas* ACanvas, int ACol, int ARow, int OrigCol, const Types::TRect &ClipRect, const Types::TRect &CellRect, Grids::TGridDrawState AState, const bool First, const bool CanSpawnL, const bool CanSpawnR, const int RightCol, const int BottomRow, const Extended XPPI, const Extended YPPI, const Types::TRect &PaintClipRect, const int aZoom, const Extended Zoom100, const bool aDrawGridLines, const bool Printing, const TSpawnedCellList* SpawnedCells, const bool ReallyDraw);
	void __fastcall SetReadOnly(const bool Value);
	void __fastcall SetZoom(const int Value);
	void __fastcall ResizeRowsAndCols(void);
	void __fastcall WriteText(const Graphics::TCanvas* ACanvas, const Types::TRect &Rect, const int X, const int Y, const WideString OutText)/* overload */;
	void __fastcall WriteText(const Graphics::TCanvas* ACanvas, const Types::TRect &Rect, int X, int Y, const WideString OutText, const Uflxmessages::TRTFRunList RTFRun, const Extended Zoom100, const Extended SubOfs)/* overload */;
	tagSIZE __fastcall CalcTextExtent(const Graphics::TCanvas* ACanvas, const WideString OutText, const Uflxmessages::TRTFRunList RTFRuns, /* out */ int &MaxDescent, Extended Zoom100)/* overload */;
	/*         class method */ static tagSIZE __fastcall CalcTextExtent(TMetaClass* vmt, const Uexceladapter::TExcelFile* Workbook, const Graphics::TCanvas* ACanvas, const WideString OutText, const Uflxmessages::TRTFRunList RTFRuns, /* out */ int &MaxDescent, Extended Zoom100)/* overload */;
	int __fastcall CalcAcumRowHeightZoom100(const int R1, const int R2);
	int __fastcall CalcAcumColWidthZoom100(const int C1, const int C2);
	int __fastcall CalcAcumRowHeight(const bool Printing, const int R1, const int R2, const Extended YPPI, const Extended Zoom100);
	int __fastcall CalcAcumColWidth(const bool Printing, const int C1, const int C2, const Extended XPPI, const Extended Zoom100);
	bool __fastcall CalcPictureRect(const int i, const int LastHVisibleCell, const int LastVVisibleCell, /* out */ Types::TRect &R1, const bool All, const Extended XPPI, const Extended YPPI, const Extended Zoom100);
	void __fastcall ResetClipRgn(const Graphics::TCanvas* ACanvas, const Types::TRect &PaintClipRect);
	void __fastcall SetClipRect(const Graphics::TCanvas* ACanvas, const Types::TRect &aRect);
	Uflxmessages::TXlsCellRange __fastcall GetXCellMergedBounds(int aRow, int aCol);
	__property Uflxmessages::TXlsCellRange XCellMergedBounds[int aRow][int aCol] = {read=GetXCellMergedBounds};
	Graphics::TColor __fastcall GetColor(const int index);
	bool __fastcall CellCanSpawnLeft(const int aRow, const int aCol);
	bool __fastcall CellCanSpawnRight(const int aRow, const int aCol);
	void __fastcall PrintImages(const Graphics::TCanvas* ACanvas, const Extended XPPI, const Extended YPPI, const Extended Zoom100, const Types::TRect &PaintClipRect, const Uflxmessages::TXlsCellRange &PagePrintRange, const Extended ZoomPreview);
	int __fastcall RealColWidth(const int Col, const Extended Zoom100, const Extended XPPI);
	int __fastcall RealRowHeight(const int Row, const Extended Zoom100, const Extended YPPI);
	void __fastcall DrawBackground(const Graphics::TCanvas* ACanvas, const Uflxmessages::TXlsCellRange &PagePrintRange, const Extended Zoom100, const Extended XPPI, const Extended YPPI, const Types::TRect &PaintClipRect, const bool aDrawGridLines, const Extended ZoomPreview);
	void __fastcall CalcPrintedPage(const int StartRow, const int StartCol, /* out */ int &EndRow, /* out */ int &EndCol, const Uflxmessages::TXlsCellRange &PrintRange, const Types::TRect &PaintClipRect, const Extended XPPI, const Extended YPPI, const Extended Zoom100);
	void __fastcall CalcPrintParams(const Uflxmessages::TXlsCellRange &PrintRange, /* out */ int &aZoom, /* out */ Types::TRect &PaintClipRect, /* out */ Extended &XPPI, /* out */ Extended &YPPI, /* out */ Extended &Zoom100);
	void __fastcall InternalCalcNumberOfPrintingPages(const Uflxmessages::TXlsCellRange &PrintRange, /* out */ int &HCount, /* out */ int &VCount, const int aZoom, const Types::TRect &PaintClipRect, const Extended XPPI, const Extended YPPI, const Extended Zoom100);
	bool __fastcall CalcPrintPictureRect(const int i, /* out */ Types::TRect &R1, const Extended XPPI, const Extended YPPI, const Extended Zoom100, const Types::TRect &PaintClipRect, const Uflxmessages::TXlsCellRange &PagePrintRange);
	void __fastcall DrawLines(const Graphics::TCanvas* ACanvas, const Uflxmessages::TXlsCellRange &PagePrintRange, const Extended Zoom100, const Extended XPPI, const Extended YPPI, const Types::TRect &PaintClipRect, const bool aDrawGridLines, const TSpawnedCellList* SpawnedCells, const Extended ZoomPreview, const bool doPreview);
	void __fastcall DrawHeaderOrFooter(const WideString Text, const Graphics::TCanvas* ACanvas, const Extended Zoom1001, const Extended XPPI, const Extended YPPI, const Extended ZoomPreview, const int CurrentPage, const int TotalPages, const int Y, const int t);
	void __fastcall DrawHeadersAndFooters(const Graphics::TCanvas* ACanvas, const Extended Zoom1001, const Extended XPPI, const Extended YPPI, const Extended ZoomPreview, const int CurrentPage, const int TotalPages, const Types::TRect &PaintClipRect1, const Types::TRect &PaintClipRect2);
	void __fastcall GenericPrint(const Graphics::TCanvas* ACanvas, const Uflxmessages::TXlsCellRange &PrintRange, const int FirstPage, const int LastPage, const bool doPreview, const Extended ZoomPreview);
	void __fastcall RotateFont(const Graphics::TFont* aFont, const int ExcelRotation);
	void __fastcall DoWriteHeader(const int CurrentPage, const int TotalPages, const WideString Text, const Graphics::TCanvas* ACanvas, const bool ReallyWrite, const int X, const int Y, /* out */ int &dX, /* out */ int &dY, const Types::TRect &ClipRect, const Extended XPPI, const Extended ZoomPreview, const Extended Zoom1001);
	int __fastcall GetMaxVisibleCol(void);
	int __fastcall GetMaxVisibleRow(void);
	void __fastcall SetPrintLineWidth(const int Value);
	Uflxformats::TFlxFormat __fastcall GetCellFormatDef(const int aRow, const int aCol);
	__property Uflxformats::TFlxFormat CellFormatDef[int aRow][int aCol] = {read=GetCellFormatDef};
	int __fastcall RowH(int i);
	int __fastcall ColW(int i);
	void __fastcall LoadFont(const Uflxformats::TFlxFont &Fnt, const Graphics::TCanvas* ACanvas, const Extended Zoom100)/* overload */;
	/*         class method */ static void __fastcall LoadFont(TMetaClass* vmt, const Uflexcelimport::TFlexCelImport* FlexCelImport, const TFlexCelGrid* Grid, const Uflxformats::TFlxFont &Fnt, const Graphics::TCanvas* ACanvas, const Extended Zoom100, const Graphics::TColor ForegroundColor)/* overload */;
	/*         class method */ static Uflxmessages::TRTFRunList __fastcall GetRuns(TMetaClass* vmt, const Uflxmessages::TRTFRunList RTFRuns, const int posi, const int len);
	/*         class method */ static int __fastcall FontDescent(TMetaClass* vmt, const Graphics::TCanvas* ACanvas);
	/*         class method */ static void __fastcall RestoreFont(TMetaClass* vmt, const Graphics::TFont* Fnt, const TSavedFont &SavedFont);
	/*         class method */ static TSavedFont __fastcall SaveFont(TMetaClass* vmt, const Graphics::TFont* Font);
	bool __fastcall PointInGridRange(int Col, int Row, const Grids::TGridRect &Rect);
	void __fastcall DrawCursor(const Uflxmessages::TXlsCellRange &r);
	Uflxmessages::TXlsCellRange __fastcall GetCursorCoords();
	int __fastcall PrintableColCount(const Uflxmessages::BooleanArray VisibleFormatsCache);
	bool __fastcall IsVisibleFormat(const int XF, bool * VisibleFormatsCache, const int VisibleFormatsCache_Size);
	void __fastcall CacheVisibleFormats(/* out */ Uflxmessages::BooleanArray &VisibleFormatsCache);
	bool __fastcall IsPrintingRow(const int r, const Uflxmessages::BooleanArray VisibleFormatsCache);
	void __fastcall LastMerged(int &LastRow, int &LastCol);
	int __fastcall GetMaxPrintableCol(void);
	int __fastcall GetMaxPrintableRow(void);
	int __fastcall GetMaxVCol(const bool Printable);
	int __fastcall GetMaxVRow(const bool Printable);
	/*         class method */ static Extended __fastcall CalcAngle(TMetaClass* vmt, const int ExcelRotation, /* out */ bool &Vertical);
	void __fastcall SplitText(const Graphics::TCanvas* ACanvas, const WideString Text, const int w, /* out */ Uflxmessages::WidestringArray &TextLines, const Uflxmessages::TRTFRunList OutRTFRuns, /* out */ TRTFRunListList &RTFRuns, /* out */ tagSIZE &TextExtent, const bool Vertical, const Extended Zoom100)/* overload */;
	bool __fastcall ColumnHidden(const int i);
	bool __fastcall RowHidden(const int i);
	/*         class method */ static int __fastcall GetFontRotation(TMetaClass* vmt, const Graphics::TFont* aFont);
	/*         class method */ static void __fastcall RotateFontDirect(TMetaClass* vmt, const Graphics::TFont* aFont, const int LogFontRotation);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall DrawCell(int ACol, int ARow, const Types::TRect &ARect, Grids::TGridDrawState AState);
	virtual bool __fastcall SelectCell(int ACol, int ARow);
	DYNAMIC void __fastcall SizeChanged(int OldColCount, int OldRowCount);
	virtual Grids::TInplaceEdit* __fastcall CreateEditor(void);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC bool __fastcall DoMouseWheelDown(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	DYNAMIC AnsiString __fastcall GetEditText(int ACol, int ARow);
	DYNAMIC void __fastcall SetEditText(int ACol, int ARow, const AnsiString Value);
	virtual bool __fastcall CanEditShow(void);
	DYNAMIC void __fastcall ColWidthsChanged(void);
	DYNAMIC void __fastcall RowHeightsChanged(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TFlexCelGrid(Classes::TComponent* AOwner);
	__fastcall virtual ~TFlexCelGrid(void);
	void __fastcall LoadSheet(void);
	void __fastcall ApplySheet(void);
	__property Row ;
	__property Col ;
	__property bool CanEdit = {read=CanEditShow, nodefault};
	__property EditorMode ;
	__property TopRow ;
	__property LeftCol ;
	int __fastcall BorderSize(void);
	void __fastcall CopyToClipboard(void);
	void __fastcall PasteFromClipboard(void);
	void __fastcall Print(const Uflxmessages::TXlsCellRange &PrintRange, const int FirstPage, const int LastPage)/* overload */;
	void __fastcall Print(const int FirstPage = 0x1, const int LastPage = 0xffffffff)/* overload */;
	void __fastcall CalcNumberOfPrintingPages(const Uflxmessages::TXlsCellRange &PrintRange, /* out */ int &PageCount)/* overload */;
	void __fastcall CalcNumberOfPrintingPages(/* out */ int &PageCount)/* overload */;
	void __fastcall PreviewPage(const Uflxmessages::TXlsCellRange &PrintRange, const int PageNumber, const Graphics::TCanvas* ACanvas, const int ZoomPreview);
	void __fastcall SetCell(const int aRow, const int aCol, const WideString Text);
	__property Selection ;
	__property int MaxVisibleRow = {read=GetMaxVisibleRow, nodefault};
	__property int MaxVisibleCol = {read=GetMaxVisibleCol, nodefault};
	__property int MaxPrintableRow = {read=GetMaxPrintableRow, nodefault};
	__property int MaxPrintableCol = {read=GetMaxPrintableCol, nodefault};
	/*         class method */ static void __fastcall SplitText(TMetaClass* vmt, const Uexceladapter::TExcelFile* Workbook, const Graphics::TCanvas* ACanvas, const WideString Text, const int w, /* out */ Uflxmessages::WidestringArray &TextLines, const Uflxmessages::TRTFRunList OutRTFRuns, /* out */ TRTFRunListList &RTFRuns, /* out */ tagSIZE &TextExtent, const bool Vertical, const Extended Zoom100)/* overload */;
	DYNAMIC void __fastcall TopLeftChanged(void);
	
__published:
	__property Uflexcelimport::TFlexCelImport* FlexCelImport = {read=FFlexCelImport, write=SetFlexCelImport};
	__property bool ReadOnly = {read=FReadOnly, write=SetReadOnly, nodefault};
	__property bool HideCursor = {read=FHideCursor, write=FHideCursor, nodefault};
	__property bool FormulaReadOnly = {read=FFormulaReadOnly, write=FFormulaReadOnly, nodefault};
	__property Graphics::TColor BackgroundColor = {read=FBackgroundColor, write=FBackgroundColor, nodefault};
	__property Graphics::TColor ForegroundColor = {read=FForegroundColor, write=FForegroundColor, nodefault};
	__property bool FullWorksheet = {read=FFullWorksheet, write=FFullWorksheet, nodefault};
	__property int Zoom = {read=FZoom, write=SetZoom, default=100};
	__property int PrintLineWidth = {read=FPrintLineWidth, write=SetPrintLineWidth, nodefault};
	__property bool UseFixedCells = {read=FUseFixedCells, write=FUseFixedCells, nodefault};
	__property int ScrollWheelOffset = {read=FScrollWheelOffset, write=FScrollWheelOffset, default=1};
	__property bool ShowHiddenRows = {read=FShowHiddenRows, write=FShowHiddenRows, default=0};
	__property bool ShowHiddenCols = {read=FShowHiddenCols, write=FShowHiddenCols, default=0};
	__property Align  = {default=0};
	__property Anchors  = {default=3};
	__property Enabled  = {default=1};
	__property Font ;
	__property Color  = {default=-16777211};
	__property FixedColor  = {default=-16777201};
	__property ParentFont  = {default=1};
	__property ParentColor  = {default=0};
	__property PopupMenu ;
	__property ShowHint ;
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=1};
	__property Visible  = {default=1};
	__property BorderStyle  = {default=1};
	__property OnClick ;
	__property OnContextPopup ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnMouseWheelDown ;
	__property OnMouseWheelUp ;
	__property OnStartDrag ;
	__property Grids::TSelectCellEvent OnSelectCell = {read=FOnSelectCell, write=FOnSelectCell};
	__property TWideSetEditEvent OnSetEditText = {read=FOnSetEditText, write=FOnSetEditText};
	__property TOnGetFontNameEvent OnGetFontName = {read=FOnGetFontName, write=FOnGetFontName};
	__property TOnFormatPictureEvent OnFormatPicture = {read=FOnFormatPicture, write=FOnFormatPicture};
	__property TOnAllowEditCellEvent OnAllowEditCell = {read=FOnAllowEditCell, write=FOnAllowEditCell};
	__property Classes::TNotifyEvent OnTopLeftChanged = {read=FOnTopLeftChanged, write=FOnTopLeftChanged};
	__property Classes::TNotifyEvent OnRowHeightsChanged = {read=FOnRowHeightsChanged, write=FOnRowHeightsChanged};
	__property Classes::TNotifyEvent OnColWidthsChanged = {read=FOnColWidthsChanged, write=FOnColWidthsChanged};
	__property TOnZoomChangedEvent OnZoomChanged = {read=FOnZoomChanged, write=FOnZoomChanged};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TFlexCelGrid(HWND ParentWindow) : Grids::TCustomGrid(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Uflexcelgrid */
using namespace Uflexcelgrid;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Uflexcelgrid
