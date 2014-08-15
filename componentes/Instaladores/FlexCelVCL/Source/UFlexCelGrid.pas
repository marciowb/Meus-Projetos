/// This file contains TFlexCelGrid, the component used to display Excel files.
unit UFlexCelGrid;

{$IFDEF LINUX}{$INCLUDE ../FLXCOMPILER.INC}{$ELSE}{$INCLUDE ..\FLXCOMPILER.INC}{$ENDIF}
{$IFDEF LINUX}{$INCLUDE ../FLXCONFIG.INC}{$ELSE}{$INCLUDE ..\FLXCONFIG.INC}{$ENDIF}
interface
uses
  {$IFDEF FLX_VCL}
    {$IFNDEF FLX_FPC}Windows,{$ENDIF} Graphics, Controls, Grids, Messages,
    {$IFDEF FLX_NEEDSJPEG} JPEG, {$ENDIF}
  {$IFNDEF TESTPRINTER}
    Printers,
  {$ELSE}
    UTestPrinter,
  {$ENDIF}
  {$ENDIF}
  {$IFDEF FLX_CLX}
    Qt, QGraphics, QGrids, Types, QControls, QPrinters,
  {$ENDIF}
  {$IFDEF FLX_NEEDSVARIANTS} variants, {$ENDIF}

  {$IFDEF FLX_FPC}types, LCLType, LCLIntf, {$ENDIF}

  SysUtils, Classes, UExcelAdapter, UFlexCelImport, Contnrs,
  UFlxFormats, UFlxMessages, XlsMessages, Math, UFlxNumberFormat, UXlsPictures;

type
  TFlexCelGrid=class;
  /// <summary>
  /// An array of TRTFRunList structures.
  /// </summary>                         
  TRTFRunListList = array of TRTFRunList;

  {$IFDEF FLX_FPC}
  /// Inplace editor for the grid. Internal use.
  TFlxInPlaceEdit=class(TStringCellEditor);
  TSelectCellEvent = TOnSelectCellEvent;
  {$ELSE}
  TFlxInPlaceEdit=class(TInPlaceEdit)
  public
    /// <summary>
    /// Font the InPlace editor will use.
    /// </summary>
    /// <remarks>
    /// This property is set by FlexCel to the font in the cell.
    /// </remarks>                                              
    property Font;
  end;
  {$ENDIF}

  /// <summary>
  /// This record is for internal use. It stores font characteristics so they can be restored later.
  /// </summary>                                                                                   
  TSavedFont = record
    /// <summary>Name of the font. </summary>
    Name: string;

    /// <summary>Color of the font. </summary>
    Color: TColor;

    /// <summary>Style of the font. </summary>
    Style: TFontStyles;

    /// <summary>Height of the font. </summary>
    Height: integer;

    /// <summary>Rotation of the font. </summary>
    Rotation: integer;
  end;

  /// <summary>
  /// Event associated with <see cref="TFlexCelGrid.OnGetFontName" />.
  /// </summary>                                                      
  TOnGetFontNameEvent=procedure(Sender: TObject; var FontName: TFontName) of object;
  /// <summary>
  /// Event associated with <see cref="TFlexCelGrid.OnFormatPicture" />.
  /// </summary>                                                        
  TOnFormatPictureEvent=procedure(Sender: TObject; const InData: TStream;const PicType: TXlsImgTypes; const OutPicture: TPicture) of object;
  /// <summary>
  /// Event associated with <see cref="TFlexCelGrid.OnSetEditText" />.
  /// </summary>
  /// <remarks>
  /// \ \ 
  /// </remarks>                                                      
  TWideSetEditEvent = procedure (Sender: TObject; ACol, ARow: Longint; const Value: WideString) of object;
  /// <summary>
  /// Event associated with <see cref="TFlexCelGrid.OnAllowEditCell" />.
  /// </summary>                                                        
  TOnAllowEditCellEvent = procedure (Sender: TObject; ACol, ARow: Longint; var AllowEdit: boolean) of object;
  /// <summary>
  /// Event associated with <see cref="TFlexCelGrid.OnZoomChanged" />.
  /// </summary>                                                      
  TOnZoomChangedEvent = procedure (Sender: TObject; Zoom: integer) of object;

  TPictureData= class
    Col1,Row1,Col2,Row2,Dx1, DY1, Width, Height: integer;
    IsRectangular: boolean;
    Data: TPicture;
    constructor Create;
    destructor Destroy; override;
  end;

  TPictureDataList= class(TObjectList)
    {$INCLUDE TPictureDataListHdr.inc}
  end;

  /// <summary>
  /// This class is for internal use.
  /// </summary>                     
  TSpawnedCell= class
  public
    RowCol: int64;
    constructor Create(const aRow, aCol: integer);
  end;

  /// <summary>
  /// A list of TSpawnedCell objects. This class is for internal use.<para></para>
  /// 
  /// </summary>                                                                  
  TSpawnedCellList=class(TObjectList)
    {$INCLUDE TSpawnedCellListHdr.inc}
  end;

  /// <summary>
  /// Implements a grid that can display and edit Excel spreadsheets.
  /// </summary>
  TFlexCelGrid = class(TCustomGrid)
  private
    FFlexCelImport: TFlexCelImport;
    FFormulaReadOnly: boolean;
    FFullWorksheet: boolean;
    FReadOnly: boolean;
    FHideCursor: boolean;

    FDrawGridLines: boolean;
    SheetLoaded: boolean;

    {$IFNDEF FLX_FPC}
    InPlaceFont: TFont;
    {$ENDIF}
    LMouseDown: boolean;

    LastRow, LastCol: integer;
    LastTopRow, LastLeftCol: integer;
    LastBigCursor: boolean;

    FZoom: integer;
    DisplayZoom100: extended;
    UpdatingGridSize: boolean;
    UpdatingGrid: boolean;

    FOnGetFontName: TOnGetFontNameEvent;
    FOnFormatPicture: TOnFormatPictureEvent;
    FOnSelectCell: TSelectCellEvent;

    PictureDataList:TPictureDataList;
    FOnSetEditText: TWideSetEditEvent;
    FOnAllowEditCell: TOnAllowEditCellEvent;
    FPrintLineWidth: integer;
    FUseFixedCells: boolean;
    FScrollWheelOffset: integer;
    FOnZoomChanged: TOnZoomChangedEvent;
    FOnTopLeftChanged: TNotifyEvent;
    FOnColWidthsChanged: TNotifyEvent;
    FOnRowHeightsChanged: TNotifyEvent;
    FShowHiddenRows: boolean;
    FShowHiddenCols: boolean;
    FBackgroundColor: TColor;
    FForegroundColor: TColor;

    procedure SetFlexCelImport(const Value: TFlexCelImport);
    function ColTitle(const i:integer):string;
    function GetCellValue(const ARow, ACol: integer): variant;
    function IsEmptyCell(const ARow, ACol: integer): boolean;
    procedure MyDrawCell(const ACanvas: TCanvas; ACol, ARow, OrigCol: Integer; ClipRect, CellRect: TRect; AState: TGridDrawState; const First: boolean; const CanSpawnL, CanSpawnR: boolean; const RightCol, BottomRow: integer; const XPPI, YPPI: extended; const PaintClipRect: TRect; const aZoom: integer; const Zoom100: extended; const aDrawGridLines, Printing: boolean; const SpawnedCells: TSpawnedCellList; const ReallyDraw: boolean);
    procedure SetReadOnly(const Value: boolean);
    procedure SetZoom(const Value: integer);
    procedure ResizeRowsAndCols;

    procedure WriteText(const ACanvas: TCanvas; const Rect: TRect; const X, Y: integer; const OutText: UTF16String); overload;
    procedure WriteText(const ACanvas: TCanvas; const Rect: TRect; X,Y: integer; const OutText: UTF16String; const RTFRun: TRTFRunList; const Zoom100: extended; const SubOfs: extended); overload;
    function CalcTextExtent(const ACanvas: TCanvas; const OutText: UTF16String; const RTFRuns: TRTFRunList; out MaxDescent: integer; Zoom100: extended): TSize; overload;
    class function CalcTextExtent(const Workbook: TExcelFile; const ACanvas: TCanvas; const OutText: UTF16String; const RTFRuns: TRTFRunList; out MaxDescent: integer; Zoom100: extended): TSize; overload;

    function CalcAcumRowHeightZoom100(const R1, R2: integer): integer;
    function CalcAcumColWidthZoom100(const C1, C2: integer): integer;
    function CalcAcumRowHeight(const Printing: boolean; const R1, R2: integer; const YPPI, Zoom100: extended): integer;
    function CalcAcumColWidth(const Printing: boolean; const C1, C2: integer; const XPPI, Zoom100: extended): integer;

    function CalcPictureRect(const i: integer; const LastHVisibleCell, LastVVisibleCell: integer; out R1: TRect; const All: boolean; const XPPI, YPPI, Zoom100: extended): boolean;
    procedure ResetClipRgn(const ACanvas: TCanvas; const PaintClipRect:TRect);
    procedure SetClipRect(const ACanvas: TCanvas; const aRect: TRect);

    function GetXCellMergedBounds(aRow, aCol: integer): TXlsCellRange;
    property XCellMergedBounds[aRow, aCol: integer]: TXlsCellRange read GetXCellMergedBounds;

    function GetColor(const index: integer): TColor;
    function CellCanSpawnLeft(const aRow, aCol: integer): boolean;
    function CellCanSpawnRight(const aRow, aCol: integer): boolean;
    procedure PrintImages(const ACanvas: TCanvas; const XPPI, YPPI, Zoom100: extended; const PaintClipRect:TRect; const PagePrintRange: TXlsCellRange; const ZoomPreview: extended);
    function RealColWidth(const Col: integer; const Zoom100, XPPI: extended): integer;
    function RealRowHeight(const Row: integer; const Zoom100, YPPI: extended): integer;
    procedure DrawBackground(const ACanvas: TCanvas; const PagePrintRange: TXlsCellRange ; const Zoom100, XPPI, YPPI: extended; const PaintClipRect: TRect; const aDrawGridLines: boolean; const ZoomPreview: extended);
    procedure CalcPrintedPage(const StartRow, StartCol: integer; out EndRow, EndCol: integer; const PrintRange: TXlsCellRange; const PaintClipRect: TRect; const XPPI, YPPI, Zoom100: extended);
    procedure CalcPrintParams(const PrintRange: TXlsCellRange; out aZoom: integer; out PaintClipRect: TRect; out XPPI, YPPI, Zoom100: extended);
    procedure InternalCalcNumberOfPrintingPages(const PrintRange: TXlsCellRange; out HCount, VCount: integer; const aZoom: integer; const PaintClipRect: TRect; const XPPI, YPPI, Zoom100: extended);
    function CalcPrintPictureRect(const i: integer; out R1: TRect; const XPPI, YPPI, Zoom100: extended; const PaintClipRect:TRect; const PagePrintRange: TXlsCellRange): boolean;
    procedure DrawLines(const ACanvas: TCanvas; const PagePrintRange: TXlsCellRange; const Zoom100, XPPI, YPPI: extended; const PaintClipRect: TRect; const aDrawGridLines: boolean; const SpawnedCells: TSpawnedCellList; const ZoomPreview: extended; const doPreview: boolean);
    procedure DrawHeaderOrFooter(const Text: UTF16String; const ACanvas: TCanvas; const Zoom1001, XPPI, YPPI, ZoomPreview: extended; const CurrentPage, TotalPages:integer; const Y: integer;const t:integer);
    procedure DrawHeadersAndFooters(const ACanvas: TCanvas; const Zoom1001, XPPI, YPPI, ZoomPreview: extended; const CurrentPage, TotalPages: integer; const PaintClipRect1, PaintClipRect2: TRect);
    procedure GenericPrint(const ACanvas: TCanvas; const PrintRange: TXlsCellRange; const FirstPage, LastPage: integer; const doPreview: boolean; const ZoomPreview: extended);
    procedure RotateFont(const aFont: TFont; const ExcelRotation: integer);
    procedure DoWriteHeader(const CurrentPage, TotalPages:integer; const Text: UTF16String; const ACanvas: TCanvas; const ReallyWrite: boolean; const X, Y: integer; out dX, dY: integer; const ClipRect: TRect; const XPPI, ZoomPreview, Zoom1001: extended);
    function GetMaxVisibleCol: integer;
    function GetMaxVisibleRow: integer;
    procedure SetPrintLineWidth(const Value: integer);

    function GetCellFormatDef(const aRow, aCol: integer): TFlxFormat;
    property CellFormatDef[const aRow, aCol: integer]: TFlxFormat read GetCellFormatDef;
    function RowH(i: integer): integer;
    function ColW(i: integer): integer;
    procedure LoadFont(const Fnt: TFlxFont; const ACanvas: TCanvas; const Zoom100: extended);overload;
    class procedure LoadFont(const FlexCelImport: TFlexCelImport; const Grid: TFlexCelGrid; const Fnt: TFlxFont; const ACanvas: TCanvas; const Zoom100: extended; const ForegroundColor: TColor);overload;
    class function GetRuns(const RTFRuns: TRTFRunList; const posi,
      len: integer): TRTFRunList;
    class function FontDescent(const ACanvas: TCanvas): integer;
    class procedure RestoreFont(const Fnt: TFont; const SavedFont: TSavedFont);
    class function SaveFont(const Font: TFont): TSavedFont;
    function PointInGridRange(Col, Row: Integer;
      const Rect: TGridRect): Boolean;
    procedure DrawCursor(const r: TXlsCellRange);
    function GetCursorCoords: TXlsCellRange;
    function PrintableColCount(const VisibleFormatsCache: BooleanArray): integer;
    function IsVisibleFormat(const XF: integer; VisibleFormatsCache: array of boolean): Boolean;
    procedure CacheVisibleFormats(out VisibleFormatsCache: BooleanArray);
    function IsPrintingRow(const r: integer;
      const VisibleFormatsCache: BooleanArray): Boolean;
    procedure LastMerged(var LastRow, LastCol: integer);
    function GetMaxPrintableCol: integer;
    function GetMaxPrintableRow: integer;
    function GetMaxVCol(const Printable: boolean): integer;
    function GetMaxVRow(const Printable: boolean): integer;
    class function CalcAngle(const ExcelRotation: integer; out Vertical: boolean): extended;
    procedure SplitText(const ACanvas: TCanvas; const Text: UTF16String; const w: integer; out TextLines: WidestringArray;const OutRTFRuns: TRTFRunList; out RTFRuns: TRTFRunListList; out TextExtent: TSize; const Vertical: boolean; const Zoom100: extended); overload;
    function ColumnHidden(const i: integer): boolean;
    function RowHidden(const i: integer): boolean;
    class function GetFontRotation(const aFont: TFont): integer;
    class procedure RotateFontDirect(const aFont: TFont;  const LogFontRotation: integer);
    { Private declarations }
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
    function SelectCell(ACol, ARow: Longint): Boolean; override;

    procedure SizeChanged(OldColCount, OldRowCount: Longint); override;

    {$IFNDEF FLX_FPC}
    /// <summary>
    /// Override this method to provide your own inplace editor for the grid.
    /// </summary>                                                           
    function CreateEditor: TInplaceEdit; override;
    {$ENDIF}
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    function DoMouseWheelDown(Shift: TShiftState; {$IFDEF FLX_CLX}const {$endif} MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; {$IFDEF FLX_CLX}const {$endif} MousePos: TPoint): Boolean; override;

    {$IFDEF FLX_VCL}
      procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;

      function GetEditText(ACol, ARow: Longint): string; override;
      procedure SetEditText(ACol, ARow: Longint; const Value: string); override;
    {$ENDIF}
    {$IFDEF FLX_CLX}
      function GetEditText(ACol, ARow: Longint): UTF16String; override;
      procedure SetEditText(ACol, ARow: Longint; const Value: UTF16String); override;
    {$ENDIF}

    function CanEditShow: Boolean; override;

    procedure ColWidthsChanged; override;
    procedure RowHeightsChanged; override;

    procedure KeyDown(var Key: Word; Shift: TShiftState); override;

    procedure Paint; override;
    procedure Loaded; override;
   { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    /// <summary>
    /// Loads a sheet into the grid.
    /// </summary>
    /// <remarks>
    /// You need to call this method any time you make changes to the attached FlexCelImport component, or
    /// when you want to change the sheet the control is displaying, in order to update the contents of the
    /// grid.
    /// </remarks>
    /// <example>
    /// This is the OnChange event of the tab control on the XLSViewer demo. To gain a deeper undestanding of
    /// the whole picture, you should look at its code.<para></para>
    /// <para></para>
    /// FlexCelGrid only displays a sheet at a time. For this reason, the XLSViewer demo has a TFlexCelGrid
    /// inside an PageControl, and each time the user changes the tab it applies back the changes made on the
    /// current sheet and loads the new.
    ///
    /// <code lang="delphi">
    /// procedure TMain.TabControlChange(Sender: TObject);
    /// begin
    ///   if DisableTabs then exit;
    ///   Data.ApplySheet;
    ///   FlexCelImport.ActiveSheet:= TabControl.TabIndex+1;
    ///   Data.LoadSheet;
    /// end;
    /// </code>
    ///
    /// </example>
    procedure LoadSheet;

    /// <summary>
    /// Applies the changes back to the attached FlexCelImport component.
    /// </summary>
    /// <remarks>
    /// \Note that this method sometimes is called automatically, so don't trust that the data at
    /// FlexCelImport remains unchanged because you didn't call ApplySheet.<para></para>
    /// <para></para>
    /// Use ApplySheet each time you change something in the grid and want to update the attached
    /// FlexcelImportComponent, and use LoadSheet when you change something in FlexCelImport and want to
    /// upgrade the grid.
    /// </remarks>                                                                                      
    procedure ApplySheet;

    property Row;
    property Col;

    /// <summary>
    /// Indicates whether the inplace edit control can be created to allow editing.
    /// </summary>
    /// <remarks>
    /// This property is useful if you are implementing a not in-place editor, and you want to know if the
    /// user can change the current cell or not.<para></para>
    /// 
    /// </remarks>                                                                                        
    property CanEdit: boolean read CanEditShow;
    property EditorMode;
    property TopRow;
    property LeftCol;

    {$IFDEF FLX_VCL}
    /// <summary>
    /// BorderSize indicates the width, in pixels, of the border specified by the BorderStyle property.
    /// </summary>
    /// <remarks>
    /// This function is available on the CLX implementation of TCustomGrid, but not in the VCL one. To be
    /// consistent and have TFlexCelGrid as much compatible between CLX and VCL as we could, we defined the
    /// BorderSize function on VCL, and make it return 0. On CLX it returns the inherited value.<para></para>
    /// <para></para>
    /// As CLX has been discontinued, this property has no use today and will always return 0. 
    /// </remarks>                                                                                           
    function BorderSize: integer;
    {$ENDIF}

    /// <summary>
    /// Copies the selected range of cells to the clipboard, in native Excel format and as Tab-Delimited
    /// text.
    /// </summary>                                                                                      
    procedure CopyToClipboard;

    /// <summary>
    /// Pastes data from the clipboard to the selected cell.
    /// </summary>
    /// <remarks>
    /// If the clipboard has native Excel format (you copied the info using Excel or FlexCel), the data will
    /// be pasted on native format. If not, the data will be pasted as tabbed text.
    /// </remarks>                                                                                          
    procedure PasteFromClipboard;

    /// <summary>
    /// Prints the loaded sheet to the default printer.
    /// </summary>
    /// <param name="PrintRange">Range of cells to print. If you don't know the range, use the other
    ///                          \version of this method.</param>
    /// <param name="FirstPage">First page to print.</param>
    /// <param name="LastPage">Last page to print. Set this value to \-1 to print all the pages.</param>
    procedure Print(const PrintRange: TXlsCellRange; const FirstPage, LastPage: integer);overload;

    /// <summary>
    /// Prints the loaded sheet to the default printer. All the cells from the first to (MaxPrintableRow,
    /// MaxPrintableCol) will be printed.
    /// </summary>
    /// <param name="FirstPage">First page to print.</param>
    /// <param name="LastPage">Last page to print. Set this value to \-1 to print all the pages.</param> 
    procedure Print(const FirstPage: integer=1; const LastPage: integer=-1);overload;

    /// <summary>
    /// Calculates the number of pages that will be printed.
    /// </summary>
    /// <remarks>
    /// Use this method for showing the amount of pages to print to the user. As it can take some time to
    /// calculate, if you are going to use this value more than once it is good to call this function at the
    /// beginning and assign it to a variable.<para></para>
    ///
    /// </remarks>
    /// <param name="PrintRange">Range of cells you want to print. There is other overloaded version of this
    ///                          method that doesn't need this parameter, and it will use the full range.</param>
    /// <param name="PageCount">\Returns the number of pages that will be printed, taking in account page
    ///                         breaks, margins, printer settings, etc.</param>
    procedure CalcNumberOfPrintingPages(const PrintRange: TXlsCellRange; out PageCount: integer); overload;

    /// <summary>
    /// Calculates the number of pages that will be printed.
    /// </summary>
    /// <remarks>
    /// Use this method for showing the amount of pages to print to the user. As it can take some time to
    /// calculate, if you are going to use this value more than once it is good to call this function at the
    /// beginning and assign it to a variable.<para></para>
    /// </remarks>
    /// <param name="PageCount">\Returns the number of pages that will be printed, taking in account page
    ///                         breaks, margins, printer settings, etc.</param>
    procedure CalcNumberOfPrintingPages(out PageCount: integer);overload;

    /// <summary>
    /// Draws a preview for an specific page on a given TCanvas
    /// </summary>
    /// <remarks>
    /// You can use this method to render a page into a custom canvas. However you will probably want to use
    /// TFlexCelPreview component for this. TFlexCelPreview is a wrapper around this method and takes care of
    /// all the details for you. If you want an example of how to use this method, take a look at
    /// TFlexCelPreview code.
    /// </remarks>
    /// <param name="PrintRange">Range you want to print. Use MaxPrintableRow and MaxPrintableCol to
    ///                          know what is the maximum used range.</param>
    /// <param name="PageNumber">Page you want to preview.</param>
    /// <param name="ACanvas">TCanvas where to draw the results.</param>
    /// <param name="ZoomPreview">Zoom for the preview.</param>                                              
    procedure PreviewPage(const PrintRange:TXlsCellRange; const PageNumber: integer; const ACanvas: TCanvas; const ZoomPreview: integer);

    /// <summary>
    /// Sets the value on a cell based on a string.
    /// </summary>
    /// <remarks>
    /// This procedure sets the cell value to the Text parameter. It will try to convert the text to a date,
    /// to a number or a boolean, and if it can it will enter the correct datatype. If it can't make a
    /// conversion, it will enter the string into the cell.<para></para>
    /// <para></para>
    /// This is equivalent to calling SetCellString on the FlexCelImport attached to the grid, but will also
    /// convert any string starting with &quot;=&quot; to a formula.<para></para>
    /// 
    /// </remarks>
    /// <param name="aRow">Row for the cell (1 based)</param>
    /// <param name="aCol">Column for the cell (1 based)</param>
    /// <param name="Text">Text you want to enter. If you write &quot;=&quot; as first character and the
    ///                    text is a valid Excel formula, it will enter the formula.</param>                
    procedure SetCell(const aRow, aCol: integer; const Text: UTF16String);

    property Selection;

    /// <summary>
    /// \Returns the last visible row of the spreadsheet.
    /// </summary>
    /// <remarks>
    /// This is the last row you should show/print to include the whole spreadsheet.<para></para>
    /// Different from TFlexCelImport.MaxRow , this property includes images.<para></para>
    /// Different from MaxPrintableRow, this property includes unused but formatted rows at the bottom.<para></para>
    /// <para></para>
    /// For example, suppose that you have an spreadsheet with one cell, A1=&quot;This is a test&quot;, and
    /// an image on cell B2:<para></para>
    /// TFlexCelImport.MaxRow is 1, as this is the last row used.<para></para>
    /// MaxVisibleRow will be 2, as there is an image on B2, even when B2 is empty. 
    /// </remarks>                                                                                                  
    property MaxVisibleRow: integer read GetMaxVisibleRow;

    /// <summary>
    /// \Returns the last visible column of the spreadsheet.
    /// </summary>
    /// <remarks>
    /// This is the last row you should show/print to include the whole spreadsheet.<para></para>
    /// But for most uses, you might want to use MaxPrintableCol.<para></para>
    /// <para></para>
    /// Different from TFlexCelImport.MaxCol , this property includes images.<para></para>
    /// Different from MaxPrintableCol, this property includes unused but formatted columns at the right.<para></para>
    /// <para></para>
    /// For example, suppose that you have an spreadsheet with one cell, A1=&quot;This is a test&quot;, and
    /// an image on cell B2:<para></para>
    /// TFlexCelImport.MaxCol is 1, as this is the last column used.<para></para>
    /// MaxVisibleCol will be 2, as there is an image on B2, even when B2 is empty. 
    /// </remarks>                                                                                                    
    property MaxVisibleCol: integer read GetMaxVisibleCol;

    /// <summary>
    /// This is the maximum row that should be displayed. If there are images on a sheet, it can be bigger
    /// than MaxRow. If a row or cell has format but the format is not visible (for example a different
    /// height) it will not show.
    /// </summary>
    /// <remarks>
    /// Different from TFlexCelImport.MaxRow , this property includes images.<para></para>
    /// Different from MaxVisibleRow, this property will not include formatted rows at the bottom.<para></para>
    /// <para></para>
    /// If for example you have row 500 set to red, but you only have data in the first 100 rows, this
    /// property will return 100, MaxVisibleRow will return 500.<para></para>
    /// <para></para>
    /// For printing, you normally need to use this property, as it will avoid printing garbage at the end.<para></para>
    /// The algorithm used is also the same as Excel itself uses to calculate the printing area for a sheet. 
    /// </remarks>                                                                                                      
    property MaxPrintableRow: integer read GetMaxPrintableRow;

    /// <summary>
    /// This is the maximum column that should be displayed. If there are images on a sheet or a cell spans
    /// to the right, it can be bigger than MaxCol. If a column has format but the format is not visible (for
    /// \example a different width)it will not show.
    /// </summary>
    /// <remarks>
    /// Different from TFlexCelImport.MaxCol , this property includes images.<para></para>
    /// Different from MaxVisibleCol, this property will not include formatted columns at the right.<para></para>
    /// <para></para>
    /// If for example you have column IV set to red, and no data after column D, this property will return
    /// D, MaxVisibleCol will return IV.<para></para>
    /// <para></para>
    /// For printing, you normally need to use this property, as it will avoid printing garbage at the end.<para></para>
    /// The algorithm used is also the same as Excel itself uses to calculate the printing area for a sheet.
    /// </remarks>                                                                                                       
    property MaxPrintableCol: integer read GetMaxPrintableCol;

    /// <summary>
    /// This method will take a line of text, and return a list of strings with the text word-wrapped fit
    /// inside a given cell.
    /// </summary>
    /// <remarks>
    /// This method is normally for internal use, but you could have an use for it. This is what FlexCelGrid
    /// uses itself to show text when the format in the cell is &quot;word wrap&quot;. Given the full text of
    /// the cell and the width of it, you get a list of lines as they would be once formatted.
    /// </remarks>
    /// <param name="Workbook">The TXlsAdapter component linked to FlexCelImport.</param>
    /// <param name="ACanvas">TCanvas where you would like to display the string.</param>
    /// <param name="Text">Text you want to word\-wrap.</param>
    /// <param name="w">Width (in pixels) of the cell.</param>
    /// <param name="TextLines">Return the word\-wrapped text.</param>
    /// <param name="OutRTFRuns">Rich text information for the original text.</param>
    /// <param name="RTFRuns">\Returns the Rich text information for the wrapped text.</param>
    /// <param name="TextExtent">\Returns a box with the dimensions of the word\-wrapped text.</param>
    /// <param name="Vertical">If true, text is in vertical mode, and will be fitted one character per
    ///                        line.</param>
    /// <param name="Zoom100">Zoom you are using to fit in percent. Normally this will be 100.</param>       
    class procedure SplitText(const Workbook: TExcelFile; const ACanvas: TCanvas; const Text: UTF16String; const w: integer; out TextLines: WidestringArray;const OutRTFRuns: TRTFRunList; out RTFRuns: TRTFRunListList; out TextExtent: TSize; const Vertical: boolean; const Zoom100: extended); overload;

    /// <summary>
    /// This method calls the OnTopLeftChanged event. Override it in a descendant grid if you want to change
    /// the behavior.
    /// </summary>
    procedure TopLeftChanged; override;


    { Public declarations }
  published

    /// <summary>
    /// This is the TFlexCelImport component from where this grid will read and write the data.
    /// </summary>
    /// <remarks>
    /// TFlexCelGrid is a grid front end for a TFlexCelImport component, it doesn't store any data on its
    /// own.<para></para>
    /// To change for example a value in a cell, or the format of a row, you change it in the TFlexCelImport
    /// component and then use LoadSheet to reflect the changes in the grid.
    /// </remarks>                                                                                          
    property FlexCelImport: TFlexCelImport read FFlexCelImport write SetFlexCelImport;

    /// <summary>
    /// Specifies if the grid can be modified.
    /// </summary>
    /// <remarks>
    /// It is a limitation of TCustomGrid, but when the grid is read-write, the user can't select multiple
    /// cells with the mouse. He can do it with the keyboard, though.
    /// </remarks>                                                                                        
    property ReadOnly: boolean read FReadOnly write SetReadOnly;

    /// <summary>
    /// Hides the cursor when showing the data.
    /// </summary>
    /// <remarks>
    /// Normally you will want to use this setting together with ReadOnly = true
    /// </remarks>
    property HideCursor: boolean read FHideCursor write FHideCursor;

    /// <summary>
    /// Allows/Disallows the user to change cells with formulas.
    /// </summary>
    /// <remarks>
    /// You can set this property to true to allow the user to change the data, but not the formulas in the
    /// sheet.
    /// </remarks>
    property FormulaReadOnly: boolean read FFormulaReadOnly write FFormulaReadOnly;

    /// <summary>
    /// Specifies a color for all cells whose color is automatic. Normally this is white.
    /// </summary>
    property BackgroundColor: TColor read FBackgroundColor write FBackgroundColor;

    /// <summary>
    /// Specifies a color for all fonts whose color is automatic. Normally this is black.
    /// </summary>
    property ForegroundColor: TColor read FForegroundColor write FForegroundColor;

    /// <summary>
    /// When true (the default) only the used range of the sheet will be displayed. You can change values,
    /// but not add new rows/columns. When false, you get a full 256x65536 spreadsheet, and you can change
    /// any cell.
    /// </summary>
    property FullWorksheet: boolean read FFullWorksheet write FFullWorksheet;

    /// <summary>
    /// Zoom magnification in percent. This value can be between 10 and 400.
    /// </summary>
    property Zoom: integer read FZoom write SetZoom default 100;
    
    /// <summary>
    /// Width in pixels for the grid lines.
    /// </summary>
    /// <remarks>
    /// When this value is 0 (the default) FlexCel will adjust the width depending on where you are drawing
    /// the grid. If to the screen it will be 1 pixel, if to a printer it will be more (so lines in printers
    /// are visible, a 1-pixel line in a 600dpi printer will not show).<para></para>
    /// <para></para>
    /// Normally the default is fine, but if you need to manually adjust it, you can with this property.
    /// </remarks>                                                                                          
    property PrintLineWidth: integer read FPrintLineWidth write SetPrintLineWidth;

    /// <summary>
    /// If true, the grid will fix all the &quot;fixed cells&quot; in the Excel sheet. (If the Excel file has
    /// frozen panes)
    /// </summary>
    /// <remarks>
    /// When this property is true, different from Excel, the user can't change the fixed cells.
    /// </remarks>
    property UseFixedCells: boolean read FUseFixedCells write FUseFixedCells;

    /// <summary>
    /// How many rows should the ScrollWeel scroll the grid.
    /// </summary>
    /// <remarks>
    /// Set this property to a negative value to have standard TStringGrid behavior.
    /// </remarks>
    property ScrollWheelOffset: integer read FScrollWheelOffset write FScrollWheelOffset default 1;

    /// <summary>
    /// If true, hidden rows will be shown in the sheet, else they will be hidden.
    /// </summary>
    /// <remarks>
    /// You can add a toggle button to your user interface that hides or shows all hidden rows by changing
    /// this property.<para></para>
    /// If you used a loop by setting all rows to visible in the file, then when the user presses the button
    /// again, all rows will be shown.<para></para>
    /// <para></para>
    /// With this property you can hide again only the rows that were hidden in first place.
    /// </remarks>
    property ShowHiddenRows: boolean read FShowHiddenRows write FShowHiddenRows default false;

    /// <summary>
    /// If true, hidden columns will be shown in the sheet, else they will be hidden.
    /// </summary>
    /// <remarks>
    /// You can add a toggle button to your user interface that hides or shows all hidden columns by changing
    /// this property.<para></para>
    /// If you used a loop by setting all columns to visible in the file, then when the user presses the
    /// button again, all columns will be shown.<para></para>
    /// <para></para>
    /// With this property you can hide again only the columns that were hidden in first place.
    /// </remarks>
    property ShowHiddenCols: boolean read FShowHiddenCols write FShowHiddenCols default false;

    property Align;
    property Anchors;
    property Enabled;
    property Font;
    property Color;
    property FixedColor;
    property ParentFont;
    property ParentColor;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;

    property BorderStyle;

    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnStartDrag;

    //EVENTS
    /// <summary>
    /// Occurs when the user selects a cell.
    /// </summary>
    /// <param name="Sender">Object sending the event.</param>
    /// <param name="ACol">Cell column</param>
    /// <param name="ARow">Cell Row</param>
    /// <param name="CanSelect">Set it too true if the user can select the cell, false
    ///                         otherwise.</param>                                    
    property OnSelectCell: TSelectCellEvent read FOnSelectCell write FOnSelectCell;

    /// <summary>
    /// Occurs when the user edits the value of a cell.
    /// </summary>
    /// <remarks>
    /// Write an OnSetEditText event handler to perform any special processing of the text edited by the user
    /// in an in-place editor. For example, use the OnSetEditText event to retrieve and store the value of a
    /// cell so that it can be displayed in an OnDrawCell event handler. OnSetEditText occurs every time the
    /// user changes the text.<para></para>
    /// <para></para>
    /// OnSetEditText does not occur unless the Options property includes goEditing.
    /// </remarks>
    /// <param name="ACol">Column of the grid where the cell is being edited.</param>
    /// <param name="ARow">Row of the grid with the cell being edited.</param>
    /// <param name="Value">Use it to return the new value for the cell.</param>                             
    property OnSetEditText: TWideSetEditEvent read FOnSetEditText write FOnSetEditText;

    /// <summary>
    /// Occurs each time FlexCelGrid needs to select a font..
    /// </summary>
    /// <remarks>
    /// Using this event you can control the fonts used for displaying. For example, change all fonts to
    /// Courier New.
    /// </remarks>
    property OnGetFontName: TOnGetFontNameEvent read FOnGetFontName write FOnGetFontName;

    /// <summary>
    /// Occurs each time an the grid needs to get an image.
    /// </summary>
    /// <remarks>
    /// You can use this event to replace the images in the file with your own.
    /// </remarks>
    property OnFormatPicture: TOnFormatPictureEvent read FOnFormatPicture write FOnFormatPicture;

    /// <summary>
    /// Occurs each time the user wants to edit a cell.
    /// </summary>
    /// <remarks>
    /// Set AllowEdit to false to disable editing a cell. This is useful if you want to limit the cells where
    /// the user can enter data.
    /// </remarks>
    property OnAllowEditCell: TOnAllowEditCellEvent read FOnAllowEditCell write FOnAllowEditCell;

    /// <summary>
    /// Occurs when the grid scrolls.
    /// </summary>
    /// <remarks>
    /// Use this event to be notified when the user scrolls in the grid.
    /// </remarks>
    property OnTopLeftChanged: TNotifyEvent read FOnTopLeftChanged write FOnTopLeftChanged;

    /// <summary>
    /// Occurs when a row height changes in the grid.
    /// </summary>
    property OnRowHeightsChanged: TNotifyEvent read FOnRowHeightsChanged write FOnRowHeightsChanged;

    /// <summary>
    /// Occurs when a column width changes in the grid.
    /// </summary>                                     
    property OnColWidthsChanged: TNotifyEvent read FOnColWidthsChanged write FOnColWidthsChanged;

    /// <summary>
    /// Use this event to know when zoom has changed in the sheet.
    /// </summary>
    /// <remarks>
    /// The user might change the zoom by doing ctrl- scroll wheel, so this event gives you a way to be
    /// notified of that and update your UI accordingly.
    /// </remarks>
    /// <example>
    /// In the XlsViewer demo, we use this event to update the zoom trackbar:
    /// 
    /// <code lang="delphi">
    /// procedure TMain.DataZoomChanged(Sender: TObject; Zoom: Integer);
    /// begin
    ///   TrackBarZoom.Position := Zoom
    /// end;
    /// </code>
    /// 
    /// </example>                                                                                     
    property OnZoomChanged: TOnZoomChangedEvent read FOnZoomChanged write FOnZoomChanged;
    { Published declarations }
  end;

implementation
{$INCLUDE TPictureDataListImp.inc}
{$INCLUDE TSpawnedCellListImp.inc}

const
{$IFDEF FLX_FPC}
    AL_LEFT=0;
    AL_BOTTOM=1;
    AL_CENTER=2;
    AL_RIGHT=3;
    AL_TOP=4;
    AL_VCENTER=5;
{$ELSE}
  {$IFDEF FLX_VCL}
    AL_LEFT=DT_LEFT;
    AL_BOTTOM=DT_BOTTOM;
    AL_CENTER=DT_CENTER;
    AL_RIGHT=DT_RIGHT;
    AL_TOP=DT_TOP;
    AL_VCENTER=DT_VCENTER;
  {$ENDIF}
  {$IFDEF FLX_CLX}
    AL_LEFT=integer(AlignmentFlags_AlignLeft);
    AL_BOTTOM=integer(AlignmentFlags_AlignBottom);
    AL_CENTER=integer(AlignmentFlags_AlignHCenter);
    AL_RIGHT=integer(AlignmentFlags_AlignRight);
    AL_TOP=integer(AlignmentFlags_AlignTop);
    AL_VCENTER=integer(AlignmentFlags_AlignVCenter);
  {$ENDIF}
{$ENDIF}


function MeasureString(const ACanvas: TCanvas; const OutText: UTF16String): TSize;
begin
{$IFDEF FLX_FPC_OR_UNICODE}
  Result:=ACanvas.TextExtent(OutText);
{$ELSE} //If we use Canvas.textrect we lose widestrings
    GetTextExtentPoint32W(ACanvas.Handle, PWideChar(OutText), Length(OutText), Result);
{$ENDIF}
end;

type
TSubscriptData = record
  Factor: Extended;
  FOffset: Extended;
end;

procedure TSubscriptData_Create(out SValue: TSubscriptData; const aStyle: SetOfTFlxFontStyle);
begin
  if (flsSubscript in aStyle) then
  begin
    SValue.Factor := 2 / 3;
    SValue.FOffset := -8;
  end
  else
    if (flsSuperscript in aStyle) then
    begin
      SValue.Factor := 2 / 3;
      SValue.FOffset := 1.5;
    end
    else
    begin
      SValue.Factor := 1;
      SValue.FOffset := 0;
    end;
end;

function TSubscriptData_Offset(SValue: TSubscriptData; const ACanvas: TCanvas): extended;
var
  Sz: TSize;
begin
  if SValue.FOffset <> 0 then
  begin
    Sz := MeasureString(ACanvas, 'Mg');
    Result := Sz.cy / SValue.FOffset;
    exit;
  end;

  Result := 0;
end;


{ TFlexCelGrid }

function TFlexCelGrid.RowHidden(const i: integer): boolean;
begin
  Result := (not FShowHiddenRows) and FlexCelImport.RowHidden[i];
end;

function TFlexCelGrid.ColumnHidden(const i: integer):boolean;
begin
  Result := (not FShowHiddenCols) and FlexCelImport.ColumnHidden[i];
end;

function TFlexCelGrid.RowH(i: integer): integer;
begin
  if RowHidden(i) then Result:=0 else
    Result:=FlexCelImport.RowHeight[i];
end;

function TFlexCelGrid.ColW(i: integer): integer;
begin
  if ColumnHidden(i) then Result:=0 else
    Result:=FlexCelImport.ColumnWidth[i];
end;

procedure TFlexCelGrid.ApplySheet;
var
  i: integer;
begin
  //Cancel editor
   DoExit;
  //We only modify rows wich have changed size, so we don't lose autofit.
  //Rows in excel by default adapt to the font size. If you manually set the row height to a value, you loose that behaviour
  //We should call AutoRowHeight to restore it.
  if Assigned(FlexCelImport)and(FlexCelImport.IsLoaded)and(SheetLoaded)  then
  begin
    for i:=1 to RowCount-1 do if (not FlexCelImport.RowHidden[i]) and (RowHeights[i]<> Round(FlexCelImport.RowHeight[i]/RowMult*DisplayZoom100)) then
      FlexCelImport.RowHeight[i]:=Round(RowHeights[i]*RowMult/DisplayZoom100);

    for i:=1 to ColCount-1 do if (not FlexCelImport.ColumnHidden[i]) and (ColWidths[i]<> Round(FlexCelImport.ColumnWidth[i]/ColMult*DisplayZoom100)) then
      FlexCelImport.ColumnWidth[i]:=Round(ColWidths[i]*ColMult/DisplayZoom100);
  end;
end;

function TFlexCelGrid.CanEditShow: Boolean;
begin
  if not Assigned(FFlexCelImport) or not FFlexCelImport.IsLoaded or FReadOnly
  or (FFormulaReadOnly and FlexCelImport.IsFormula[Row, Col])
  or (FlexCelImport.CellMergedBounds[Row, Col].Top<>Row)
  or (FlexCelImport.CellMergedBounds[Row, Col].Left<>Col) then
    Result:=False
  else
  begin
    Result:= inherited CanEditShow;
    if Assigned(OnAllowEditCell) then OnAllowEditCell(Self, Col, Row, Result);
  end;

end;

function TFlexCelGrid.ColTitle(const i: integer): string;
const
  Z=ord('Z');
  A=ord('A');
begin
if i<=Z-A+1 then Result:= chr(A+i-1) else
  Result:= chr(A+(i-1) div (Z-A+1)-1)+chr(A+ (i-1) mod (Z-A+1));
end;

function TFlexCelGrid.CalcAcumRowHeight(const Printing: boolean; const R1, R2: integer; const YPPI, Zoom100: extended): integer;
var
  i: integer;
begin
  Result:=0;
  if not Printing then
  begin
    for i:=R1 to R2-1 do Inc(Result, RowHeights[i]);
    for i:=R1-1 downto R2 do Dec(Result, RowHeights[i]);
  end else
  begin
    for i:=R1 to R2-1 do Inc(Result, Round(YPPI*RowH(i)/RowMult*Zoom100));
    for i:=R1-1 downto R2 do Dec(Result, Round(YPPI*RowH(i)/RowMult*Zoom100));
  end;

end;

function TFlexCelGrid.CalcAcumRowHeightZoom100(const R1, R2: integer): integer;
var
  i: integer;
begin
  Result:=0;
  for i:=R1 to R2-1 do Inc(Result, RowH(i));
  for i:=R1-1 downto R2 do Dec(Result, RowH(i));
  Result:=Round(Result/RowMult);
end;

function TFlexCelGrid.CalcAcumColWidth(const Printing: boolean; const C1, C2: integer; const XPPI, Zoom100: extended): integer;
var
  i: integer;
begin
  Result:=0;
  if not Printing then
  begin
    for i:=C1 to C2-1 do Inc(Result, ColWidths[i]);
    for i:=C1-1 downto C2 do Dec(Result, ColWidths[i]);
  end else
  begin
    for i:=C1 to C2-1 do Inc(Result, Round(XPPI*ColW(i)/ColMult*Zoom100));
    for i:=C1-1 downto C2 do Dec(Result, Round(XPPI*ColW(i)/ColMult*Zoom100));
  end;
end;

function TFlexCelGrid.CalcAcumColWidthZoom100(const C1, C2: integer): integer;
var
  i: integer;
begin
  Result:=0;
  for i:=C1 to C2-1 do Inc(Result, ColW(i));
  for i:=C1-1 downto C2 do Dec(Result, ColW(i));
  Result:=Round(Result/ColMult);
end;

procedure TFlexCelGrid.ColWidthsChanged;
begin
  if UpdatingGridsize then exit;
  inherited;
  ApplySheet;
  if Assigned(FOnColWidthsChanged) then FOnColWidthsChanged(Self);
end;

constructor TFlexCelGrid.Create(AOwner: TComponent);
begin
  inherited;
  Font.Name:='Arial';
  DefaultDrawing:=False;
  Options := [goRowSizing, goColSizing, goEditing, goThumbTracking, goRangeSelect];
  LastRow:=-1;
  LastCol:=-1;
  LastTopRow:=-1;
  LastLeftCol:=-1;
  LastBigCursor:=false;
  FScrollWheelOffset := 1;
  FShowHiddenRows := false;
  FShowHiddenCols := false;

  FBackgroundColor := clWhite;
  FForegroundColor := clBlack;
  
  FZoom:=100;
  DisplayZoom100:=1;
  UpdatingGridsize:=false;
  FDrawGridLines:=true;
  PictureDataList:=TPictureDataList.Create;
  SheetLoaded:=false;
  LMouseDown:=false;
  DoubleBuffered := true;
end;

destructor TFlexCelGrid.Destroy;
begin
  FreeAndNil(PictureDataList);
  inherited;
end;

function TFlexCelGrid.GetCellValue(const ARow, ACol: integer): variant;
begin
  if ColumnHidden(aCol) then Result:='' else
    Result:=FFlexCelImport.CellValue[aRow, aCol];
end;

function TFlexCelGrid.IsEmptyCell(const ARow, ACol: integer): boolean;
var
  v: variant;
begin
  if (aRow<=0) or (aCol<=0) or (ARow>$FFFF)or (ACol>$FF) then Result:=false
  else if not FlexCelImport.IsLoaded then Result:= true
  else
  begin
    v:=GetCellValue(aRow, aCol);
    Result:=VarIsEmpty(v)or VarIsNull(v) or ((VarType(v)=vtString) and (v=''));
  end;
end;

function Intersect(const Rect1, Rect2: TRect; out OutRect: TRect): boolean;
begin
  OutRect.Left:=Max(Rect1.Left, Rect2.Left);
  OutRect.Top:=Max(Rect1.Top, Rect2.Top);
  OutRect.Right:=Min(Rect1.Right, Rect2.Right);
  OutRect.Bottom:=Min(Rect1.Bottom, Rect2.Bottom);
  Result:=(OutRect.Left<OutRect.Right)and(OutRect.Top<OutRect.Bottom);
end;

class function TFlexCelGrid.CalcAngle(const ExcelRotation: integer; out Vertical: boolean): extended;
begin
  Vertical:=ExcelRotation=255;
  if ExcelRotation<0 then Result:=0
  else if ExcelRotation<=90 then Result:=ExcelRotation*2*pi/360
  else if ExcelRotation<=180 then Result:=(90-ExcelRotation)*2*pi/360
  else Result:=0;
end;

{$IFNDEF FLX_CLX}
procedure TFlexCelGrid.RotateFont(const aFont: TFont; const ExcelRotation: integer);
var
  lf: LOGFONT; // Windows native font structure
  r: integer;
begin
  if ExcelRotation<=0 then exit else
  if ExcelRotation<=90 then r:=ExcelRotation*10 else
  if ExcelRotation<=180 then r:=(90-ExcelRotation)*10 else exit;
  if GetObject(aFont.Handle, SizeOf(lf), @lf) = 0 then exit;

  lf.lfEscapement := r; // degrees to rotate
  lf.lfOrientation := r;

  aFont.Handle := CreateFontIndirect(lf);
end;

class function TFlexCelGrid.GetFontRotation(const aFont: TFont): integer;
var
  lf: LOGFONT; // Windows native font structure
begin
  Result := 0;
  if GetObject(aFont.Handle, SizeOf(lf), @lf) = 0 then exit;

  Result := lf.lfEscapement; // degrees to rotate
end;

class procedure TFlexCelGrid.RotateFontDirect(const aFont: TFont; const LogFontRotation: integer);
var
  lf: LOGFONT; // Windows native font structure
begin
  if GetObject(aFont.Handle, SizeOf(lf), @lf) = 0 then exit;

  lf.lfEscapement := LogFontRotation; // degrees to rotate
  lf.lfOrientation := LogFontRotation;

  aFont.Handle := CreateFontIndirect(lf);
end;

{$IFNDEF FLX_FPC}
procedure AssignFontNotRotated(const OldFont, NewFont: TFont);
var
  lf: LOGFONT; // Windows native font structure
begin
  if GetObject(OldFont.Handle, SizeOf(lf), @lf) = 0 then exit;

  lf.lfEscapement := 0; // degrees to rotate
  lf.lfOrientation := 0;

  NewFont.Handle := CreateFontIndirect(lf);
end;
{$ENDIF}

class function TFlexCelGrid.FontDescent(const ACanvas: TCanvas): integer;
var
  {$IFDEF NOWIDESTRINGGRAPHICS}
  TM: TEXTMETRIC;
  {$ELSE}
  TM: TEXTMETRICW;
  {$ENDIF}
begin
  {$IFDEF NOWIDESTRINGGRAPHICS}
  GetTextMetrics(ACanvas.Handle, TM);
  {$ELSE}
  GetTextMetricsW(ACanvas.Handle, TM);
  {$ENDIF}
  Result:= TM.tmAscent; //Here y coords are reversed with .net, so we use the ascent.
end;

{$ELSE}
procedure TFlexCelGrid.RotateFont(const aFont: TFont; const ExcelRotation: integer);
begin
end;
procedure AssignFontNotRotated(const OldFont, NewFont: TFont);
begin
  NewFont.Assign(OldFont);
end;

class function TFlexCelGrid.GetFontRotation(const aFont: TFont): integer;
begin
  Result := 0;
end;

class procedure TFlexCelGrid.RotateFontDirect(const aFont: TFont; const LogFontRotation: integer);
begin
end;


class function TFlexCelGrid.FontDescent(const ACanvas: TCanvas): integer;
var
  FM: QFontMetricsH;
begin
  FM := QFontMetrics_create(ACanvas.Font.Handle);
  try
    Result:=  QFontMetrics_ascent(FM); //Here y coords are reversed with .net, so we use the ascent.
  finally
    QFontMetrics_destroy(FM);
  end; //finally
end;

{$ENDIF}

procedure TFlexCelGrid.WriteText(const ACanvas: TCanvas; const Rect: TRect; const X, Y: integer; const OutText: UTF16String);
var
{$IFDEF FLX_FPC}
  TextStyle : TTextStyle;
{$ELSE}
  Options: Longint;
{$ENDIF}
begin
{$IFDEF FLX_FPC}
  TextStyle := ACanvas.TextStyle;
  TextStyle.Opaque := false;
  ACanvas.TextRect(Rect, X, Y, OutText, TextStyle);
{$ELSE}
  Options := ETO_CLIPPED or ACanvas.TextFlags and not ETO_OPAQUE;
  Windows.ExtTextOutW(ACanvas.Handle, X, Y, Options, @Rect, PWideChar(OutText), Length(OutText), nil);
{$ENDIF}
end;

procedure TFlexCelGrid.WriteText(const ACanvas: TCanvas; const Rect: TRect; X,Y: integer; const OutText: UTF16String; const RTFRun: TRTFRunList; const Zoom100: extended; const SubOfs: extended);
var
  s1, s2: UTF16String;
  Result: TSize;
  i, NextPos: integer;
  Fx: TFlxFont;
  MaxDescent: integer;
  Sub: TSubscriptData;

begin
  if ACanvas.Brush.Bitmap<>nil then ACanvas.Brush.Style:=bsClear;

    if length(RTFRun)=0 then
    begin
      WriteText(ACanvas, Rect, X, Y, OutText);
    end else
    begin
      s1 := copy(OutText, 1, RTFRun[0].FirstChar - 1);
      Result := CalcTextExtent(ACanvas, s1, RTFRun, MaxDescent, Zoom100);
      WriteText(ACanvas, Rect, X, (Y - Round(SubOfs)) + (MaxDescent - FontDescent(ACanvas)), s1);
      //ACanvas.DrawString(s1, AFont, TextBrush, x, (y + SubOfs) - (MaxDescent - ACanvas.FontDescent(AFont)));

      x:= x + Result.cx;
      for i := 0 to Length(RTFRun) - 1 do
      begin
        FlexCelImport.GetFontList(RTFRun[i].FontIndex, Fx);
        TSubscriptData_Create(Sub, Fx.Style);
        LoadFont(Fx, ACanvas, Zoom100 * Sub.Factor);

          begin
            if i < Length(RTFRun) -1 then NextPos := RTFRun[i + 1].FirstChar else NextPos := Length(OutText) + 1;
            s2 := copy(OutText, RTFRun[i].FirstChar, NextPos - RTFRun[i].FirstChar);
            Result := MeasureString(ACanvas, s2);
            WriteText(ACanvas, Rect, X, Y - Round(TSubscriptData_Offset(Sub, ACanvas))+ (MaxDescent - FontDescent(ACanvas)), s2);
            //ACanvas.DrawString(s2, MyFont, MyBrush, x, (y + TSubscriptData_Offset(Sub, ACanvas, MyFont)) - (MaxDescent - ACanvas.FontDescent(MyFont)));
            x:= x + Result.cx;
          end;
      end;
    end;

  if ACanvas.Brush.Bitmap<>nil then ACanvas.Brush.Style:=bssolid;

end;

class function TFlexCelGrid.GetRuns(const RTFRuns: TRTFRunList; const posi, len: integer): TRTFRunList;
var
  i,k: integer;
  Count: integer;
begin
  Count:=0;
  for i:=0 to Length(RTFRuns) -1 do
  begin
    if (RTFRuns[i].FirstChar >= posi) and (RTFRuns[i].FirstChar < posi + len) then inc (Count);
  end;

  SetLength(Result, Count);
  k:=0;
  for i:=0 to Length(RTFRuns) -1 do
  begin
    if (RTFRuns[i].FirstChar >= posi) and (RTFRuns[i].FirstChar < posi + len) then
    begin
      Result[k] := RTFRuns[i];
      Result[k].FirstChar := Result[k].FirstChar - posi + 1;
      inc(k);
    end;
  end;
end;

procedure TFlexCelGrid.SplitText(const ACanvas: TCanvas; const Text: UTF16String; const w: integer;
                                        out TextLines: WidestringArray;
                                        const OutRTFRuns: TRTFRunList; out RTFRuns: TRTFRunListList;
                                        out TextExtent: TSize; const Vertical: boolean; const Zoom100: extended);
begin
  SplitText(FlexCelImport.GetWorkbook, ACanvas, Text, w, TextLines, OutRTFRuns, RTFRuns, TextExtent, Vertical, Zoom100);
end;

class procedure TFlexCelGrid.SplitText(const Workbook: TExcelFile; const ACanvas: TCanvas; const Text: UTF16String; const w: integer;
                                        out TextLines: WidestringArray;
                                        const OutRTFRuns: TRTFRunList; out RTFRuns: TRTFRunListList;
                                        out TextExtent: TSize; const Vertical: boolean; const Zoom100: extended);
var
  idx: integer;
  Fit: longint;
  aSize: TSize;
  Enter: integer;
  MaxDescent: integer;
  {$IFDEF FLX_VCL}
  st:string;
  {$ENDIF}
begin
  idx:=1;
  SetLength(TextLines,0);
  SetLength(RTFRuns,0);

  TextExtent.cx:=0;
  TextExtent.cy:=0;

  while idx<=Length(Text) do
  begin
    if Vertical then fit:=1 else
    begin
      {$IFDEF FLX_VCL}
      if Length(OutRTFRuns) = 0 then
      begin
        {$IFDEF NOWIDESTRINGGRAPHICS}
        if not GetTextExtentExPoint(ACanvas.Handle, PChar(copy(Text,idx,length(Text))), Length(Text)-idx+1, w, @Fit, nil, aSize ) then
        {$ELSE}
        if not GetTextExtentExPointW(ACanvas.Handle, PWideChar(copy(Text,idx,length(Text))), Length(Text)-idx+1, w, @Fit, nil, aSize ) then
        {$ENDIF}
        begin;
          //win98/95/me?
          st:=copy(Text,idx,Length(Text));
          if not GetTextExtentExPoint(ACanvas.Handle, PChar(st), Length(Text)-idx+1, w, @Fit, nil, aSize ) then
          begin
            //give up

            exit;
          end;
        end;
      end
      else
      begin
         aSize:=MeasureString(ACanvas,'M');
         if aSize.cx=0 then Fit:=1 else
         begin
           Fit:=Round(w/aSize.cx);
           while (Fit>1) and (CalcTextExtent(Workbook, ACanvas, copy(Text,idx,Fit), GetRuns(OutRTFRuns,idx, Fit),MaxDescent, Zoom100).cx>w) do dec(Fit);
           while (idx+Fit<=Length(Text)) and (CalcTextExtent(Workbook, ACanvas, copy(Text,idx,Fit), GetRuns(OutRTFRuns,idx, Fit),MaxDescent, Zoom100).cx<w) do inc(Fit);
         end;
      end;
      {$ENDIF}
      {$IFDEF FLX_FPC_OR_CLX}
         //Not a really efficient way, but I couldn't get a QT API for this
         //First Guess
         aSize:=ACanvas.TextExtent('M');
         if aSize.cx=0 then Fit:=1 else
         begin
           Fit:=Round(w/aSize.cx);
           while (Fit>1) and (ACanvas.TextExtent(copy(Text,idx,Fit)).cx>w) do dec(Fit);
           while (idx+Fit<=Length(Text)) and (ACanvas.TextExtent(copy(Text,idx,Fit+1)).cx<w) do inc(Fit);
         end;
      {$ENDIF}

      if Fit<=0 then Fit:=1; //avoid infinite loop

      if pos(' ', copy(Text, idx, Fit))>0 then
        while (Fit>1)and (Idx+Fit<=Length(Text)) and (Text[idx+Fit]<>' ') do dec(Fit);
      while (idx+Fit<=Length(Text)) and (Text[idx+Fit]=' ') do inc (Fit);
    end;

    SetLength(TextLines, Length(TextLines)+1);
    SetLength(RTFRuns, Length(RTFRuns)+1);

    Enter:=pos(#$A,copy(Text, idx, Fit));
    if Enter>0 then Fit:=Enter-1;
    TextLines[Length(TextLines)-1]:=copy(Text, idx, Fit);
    RTFRuns[Length(RTFRuns)-1]:=GetRuns(OutRTFRuns, idx, Fit);
    if Enter>0 then
    begin
      idx:=idx+Enter;
    end else idx:=idx+Fit;

    //Recalculate dx
    aSize:=CalcTextExtent(Workbook, ACanvas, TextLines[Length(TextLines)-1], RTFRuns[Length(RTFRuns)-1],MaxDescent, Zoom100);
    if TextExtent.cx<aSize.cx then TextExtent.cx:=aSize.cx;
    if TextExtent.cy<aSize.cy then TextExtent.cy:=aSize.cy;
  end; //while
end;

procedure AlignText(const ACanvas: TCanvas; const alBottom: boolean);
begin
{$IFDEF FLX_FPC}
{$ELSE}
  {$IFDEF FLX_CLX}
    if alBottom then ACanvas.TextAlign:=taBottom else ACanvas.TextAlign:=taTop;
  {$ENDIF}
  {$IFDEF FLX_VCL}
    if alBottom then
      SetTextAlign(ACanvas.Handle, GetTextAlign(ACanvas.Handle) and not 24 or TA_BASELINE) else
      SetTextAlign(ACanvas.Handle, GetTextAlign(ACanvas.Handle) and not 24);
  {$ENDIF}
{$ENDIF}
end;

function MaxInt(const i1, i2: integer): integer;
begin
  if (i1 > i2)then Result:=i1 else Result:= i2;
end;

function TFlexCelGrid.CalcTextExtent(const ACanvas: TCanvas; const OutText: UTF16String; const RTFRuns: TRTFRunList; out MaxDescent: integer; Zoom100: extended): TSize;
begin
  Result := CalcTextExtent(FlexCelImport.GetWorkbook, ACanvas, OutText, RTFRuns, MaxDescent, Zoom100);
end;

class function TFlexCelGrid.CalcTextExtent(const Workbook: TExcelFile; const ACanvas: TCanvas; const OutText: UTF16String; const RTFRuns: TRTFRunList; out MaxDescent: integer; Zoom100: extended): TSize;
var
  x,y, NextPos: integer;
  Fx: TFlxFont;
  i: integer;
  Sub: TSubscriptData;
  s2: string;
  SavedFont: TSavedFont;
begin
  SavedFont:=SaveFont(ACanvas.Font);
  try
    MaxDescent := FontDescent(ACanvas);
    if Length(RTFRuns) = 0 then
    begin
      Result := MeasureString(ACanvas, OutText);
      exit;
    end;

    Result := MeasureString(ACanvas, copy(OutText, 0, RTFRuns[0].FirstChar-1));
    x := Result.cx;
    y := Result.cy;

    for i := 0 to Length(RTFRuns) - 1 do
    begin
        Fx:=Workbook.FontList[RTFRuns[i].FontIndex];
        TSubscriptData_Create(Sub, Fx.Style);
        LoadFont(nil, nil, Fx, ACanvas, Zoom100 * Sub.Factor, clBlack); //color really doesn't matter here

          begin
            if i < Length(RTFRuns) -1 then NextPos := RTFRuns[i + 1].FirstChar else NextPos := Length(OutText) + 1;
            s2 := copy(OutText, RTFRuns[i].FirstChar, NextPos - RTFRuns[i].FirstChar);
            Result := MeasureString(ACanvas, s2);
            x:= x + Result.cx;
            y := MaxInt(y + Round(TSubscriptData_Offset(Sub, ACanvas)), Result.cy);
            MaxDescent := MaxInt(MaxDescent, FontDescent(ACanvas) + Round(TSubscriptData_Offset(Sub, ACanvas)));
          end;
    end;

    Result.cx := x;
    Result.cy := y;
  finally
    RestoreFont(ACanvas.Font, SavedFont);
  end; //finally
end;

function TFlexCelGrid.GetColor(const index: integer): TColor;
begin
  if (Index>0) and (Index<=FlexCelImport.ColorPaletteCount) then
  Result:=FlexCelImport.ColorPalette[Index]
  else Result:=ForegroundColor;
end;

function TFlexCelGrid.CellCanSpawnRight(const aRow, aCol: integer): boolean;
var
  Fm: TFlxFormat;
  Mb: TXlsCellRange;
begin
  Result:=False;
  Fm:=CellFormatDef[aRow, aCol];
  if (Fm.HAlignment= fha_Right) or (Fm.WrapText) then exit;
  Mb:=XCellMergedBounds[aRow, aCol];
  Result:= (Mb.Left=aCol) and (Mb.Right= aCol) and (Mb.Top=aRow) and (Mb.Bottom=aRow);
end;

function TFlexCelGrid.CellCanSpawnLeft(const aRow, aCol: integer): boolean;
var
  Fm: TFlxFormat;
  Mb: TXlsCellRange;
begin
  Result:=False;
  Fm:=CellFormatDef[aRow, aCol];
  if (Fm.HAlignment= fha_Left) or (Fm.WrapText) then exit;
  Mb:=XCellMergedBounds[aRow, aCol];
  Result:= (Mb.Left=aCol) and (Mb.Right= aCol) and (Mb.Top=aRow) and (Mb.Bottom=aRow);
end;

function TFlexCelGrid.PointInGridRange(Col, Row: Longint; const Rect: TGridRect): Boolean;
var
  FinalRect: TGridRect;
  r: TXlsCellRange;
begin
  FinalRect := Rect;
  if   Assigned(FlexCelImport) and (FlexCelImport.IsLoaded) and
      (Rect.Top = Rect.Bottom) and (Rect.Left = Rect.Right) then
  begin
    r := XCellMergedBounds[Rect.Top, Rect.Left];
    FinalRect.Left := r.Left;
    FinalRect.Right := r.Right;
    FinalRect.Top := r.Top;
    FinalRect.Bottom := r.Bottom;
  end;

  Result := ((Col >= FinalRect.Left) and (Col <= FinalRect.Right)) or ((Row >= FinalRect.Top)
    and (Row <= FinalRect.Bottom));
end;


procedure TFlexCelGrid.DrawBackground(const ACanvas: TCanvas; const PagePrintRange: TXlsCellRange; const Zoom100, XPPI, YPPI: extended; const PaintClipRect: TRect; const aDrawGridLines: boolean; const ZoomPreview: extended);
var
  Row, Col: integer;
  ColorIndexFg, ColorIndexBg: integer;
  ABrushFg, ABrushBg: TColor;
  Cw, Ch: integer;
  Mb: TXlsCellRange;
  Fm: TFlxFormat;
  Bmp: TBitmap;
begin
  //Fill the cells
  //We do this first, so lines are drawn on the background
  Row:= PagePrintRange.Top;
  Ch:=PaintClipRect.Top;
  while Row<= PagePrintRange.Bottom do
  begin
    Col:=PagePrintRange.Left;
    Cw:=PaintClipRect.Left;
    while Col<= PagePrintRange.Right do
    begin
      Mb:=XCellMergedBounds[Row, Col];
      Fm:=CellFormatDef[Mb.Top, Mb.Left];
      ColorIndexBg:=Fm.FillPattern.bgColorIndex;
      ColorIndexFg:=Fm.FillPattern.fgColorIndex;

      if (ColorIndexFg>0)and(ColorIndexFg<=56) then
        ABrushFg:= FlexCelImport.ColorPalette[ColorIndexFg]
        else ABrushFg:=ForegroundColor;

      if (ColorIndexBg>0)and(ColorIndexBg<=56) then
        ABrushBg:= FlexCelImport.ColorPalette[ColorIndexBg]
        else ABrushBg:= BackgroundColor;

      Bmp:=nil;
      try
        if Fm.FillPattern.Pattern=1 then
        begin
          if (ACanvas.Brush.Color<>BackgroundColor) then
            ACanvas.Brush.Color:=BackgroundColor;
        end else
        if Fm.FillPattern.Pattern=2 then
        begin
          if (ACanvas.Brush.Color<>ABrushFg) then
            ACanvas.Brush.Color:=ABrushFg;
        end else
        begin
          Bmp:=CreateBmpPattern(Fm.FillPattern.Pattern, ABrushFg, ABrushBg);
          Acanvas.Brush.Bitmap:=Bmp;
        end;

        ACanvas.FillRect(Rect(Round(Cw*ZoomPreview), Round(Ch*ZoomPreview), Round((Cw+RealColWidth(Col,Zoom100,XPpi))*ZoomPreview), Round((Ch+RealRowHeight(Row,Zoom100,YPpi))*ZoomPreview)));

      finally
        ACanvas.Brush.Bitmap:=nil;
        FreeAndNil(Bmp);
      end; //finally


      Cw:=Cw+Round(RealColWidth(Col,Zoom100,XPpi));
      inc(Col);
    end;
    Ch:=Ch+RealRowHeight(Row,Zoom100,YPpi);
    inc(Row);
  end;
end;

procedure TFlexCelGrid.DrawLines(const ACanvas: TCanvas; const PagePrintRange: TXlsCellRange; const Zoom100, XPPI, YPPI: extended; const PaintClipRect: TRect; const aDrawGridLines: boolean; const SpawnedCells: TSpawnedCellList; const ZoomPreview: extended; const doPreview: boolean);
var
  Row, Col: integer;
  ColorIndex: integer;
  ABrush: TColor;
  Cw, Ch, TopCw, BottomCw, LeftCh, RightCh: integer;
  Fm1: TFlxFormat;
  LeftColor0, TopColor0, BottomColor0, RightColor0: TColor;
  DLeft0, DTop0, DBottom0, DRight0: boolean;
  LeftColor, TopColor, BottomColor, RightColor: TColor;
  DLeft, DTop, DBottom, DRight, RealDBottom, RealDRight: boolean;
  OldLines: array of boolean;
  Mb: TxlsCellRange;
  Index: integer;
  CellGridLines: boolean;

begin
  //For showing lines on laser printers
  if not doPreview then
  begin
    if PrintLineWidth=0 then ACanvas.Pen.Width:=Round(XPPI/150*96)
    else ACanvas.Pen.Width:=PrintLineWidth;
  end
  else ACanvas.Pen.Width:=1;


  //Draw Horizontal Lines
  SetLength(OldLines, PagePrintRange.Right-PagePrintRange.Left+2);
  for Col:=0 to High(OldLines) do OldLines[Col]:=false;
  Row:= PagePrintRange.Top;
  Ch:=PaintClipRect.Top;
  while Row<= PagePrintRange.Bottom do
  begin
    Col:=PagePrintRange.Left;
    Cw:=PaintClipRect.Left;
    TopCw:=Cw; BottomCw:=Cw;
    DTop0:=false; DBottom0:=false; TopColor0:=BackgroundColor; BottomColor0:=BackgroundColor;
    while Col<= PagePrintRange.Right+1 do
    begin
      //Calc Borders

      TopColor:=clLtGray;BottomColor:=TopColor;
      if Col<=PagePrintRange.Right then
      begin
        Mb:=XCellMergedBounds[Row, Col];
        Fm1:=CellFormatDef[Row, Col];
        if Fm1.FillPattern.Pattern>1 then CellGridLines:=false else CellGridLines:=aDrawGridLines;
        DTop:=CellGridLines and (Row=PagePrintRange.Top);DBottom:=CellGridLines; RealDBottom:=false;
        if Fm1.Borders.Top.Style <> fbs_None then
        begin
          TopColor:=GetColor(Fm1.Borders.Top.ColorIndex);
          DTop:=true;
        end;
        if Fm1.Borders.Bottom.Style <> fbs_None then
        begin
          BottomColor:=GetColor(Fm1.Borders.Bottom.ColorIndex);
          DBottom:=true;
          RealDBottom:=true;
        end;
      end else
      begin
        DTop:=false; DBottom:=false;
        RealDBottom:=false;
      end;

      if (Mb.Top<Row) then DTop:=False;
      if (Mb.Bottom>Row) then begin;DBottom:=False;RealDBottom:=false;end;


      if OldLines[Col-PagePrintRange.Left] then DTop:=false;
      OldLines[Col-PagePrintRange.Left]:=RealDBottom;

      if DTop0 and (not DTop or(TopColor<>TopColor0)) then
      begin
        if (ACanvas.Pen.Color<>TopColor0) then ACanvas.Pen.Color:=TopColor0;
        ACanvas.Polyline([Point(Round(TopCw*ZoomPreview), Round(Ch*ZoomPreview)),Point(Round(Cw*ZoomPreview), Round(Ch*ZoomPreview))]);
      end;

      if DBottom0 and (not DBottom or(BottomColor<>BottomColor0)) then
      begin
        if (ACanvas.Pen.Color<>BottomColor0) then ACanvas.Pen.Color:=BottomColor0;
        ACanvas.Polyline([Point(Round(BottomCw*ZoomPreview),Round((Ch+RealRowHeight(Row,Zoom100,YPpi))*ZoomPreview)),Point(Round(Cw*ZoomPreview), Round((Ch+RealRowHeight(Row,Zoom100,YPpi))*ZoomPreview))]);
      end;

      if DTop and (not DTop0 or (TopColor<>TopColor0)) then TopCw:=Cw;
      if DBottom and (not DBottom0 or (BottomColor<>BottomColor0)) then BottomCw:=Cw;

      DTop0:=DTop; DBottom0:=DBottom;
      TopColor0:=TopColor; BottomColor0:=BottomColor;

      if (Col<=PagePrintRange.Right) then Cw:=Cw+RealColWidth(Col,Zoom100,XPpi);
      inc(Col);
    end;
    Ch:=Ch+RealRowHeight(Row,Zoom100,YPpi);
    inc(Row);
  end;

  //Draw Vertical Lines
  SetLength(OldLines, PagePrintRange.Bottom-PagePrintRange.Top+2);
  for Row:=0 to High(OldLines) do OldLines[Row]:=false;
  Col:= PagePrintRange.Left;
  Cw:=PaintClipRect.Left;
  while Col<= PagePrintRange.Right do
  begin
    Row:=PagePrintRange.Top;
    Ch:=PaintClipRect.Top;
    LeftCh:=Ch; RightCh:=Ch;
    DLeft0:=false; DRight0:=false; LeftColor0:=BackgroundColor; RightColor0:=BackgroundColor;
    while Row<= PagePrintRange.Bottom+1 do
    begin
      //Calc Borders
      Mb:=XCellMergedBounds[Row, Col];
      LeftColor:=clLtGray;RightColor:=LeftColor;
      if Row<=PagePrintRange.Bottom then
      begin
        Fm1:=CellFormatDef[Row, Col];
        if Fm1.FillPattern.Pattern>1 then  CellGridLines:=false else CellGridLines:=aDrawGridLines; 
        DLeft:=CellGridLines and (Col=PagePrintRange.Left);DRight:=CellGridLines; RealDRight:=False;
        if Fm1.Borders.Left.Style <> fbs_None then
        begin
          LeftColor:=GetColor(Fm1.Borders.Left.ColorIndex);
          DLeft:=true;
        end;
        if Fm1.Borders.Right.Style <> fbs_None then
        begin
          RightColor:=GetColor(Fm1.Borders.Right.ColorIndex);
          DRight:=true;
          RealDRight:=true;
        end;
      end else
      begin
        DLeft:=false; DRight:=false;
        RealDRight:=false;
      end;

      if (Mb.Left<Col) then DLeft:=False;
      if (Mb.Right>Col) then begin;DRight:=False; RealDRight:=False;end;
      if (Col>1)and DLeft and SpawnedCells.Find(Row+int64(Col-1) shl 32, Index) then DLeft:=False;
      if DRight and SpawnedCells.Find(Row+int64(Col) shl 32, Index) then begin;DRight:=False; RealDRight:=False;end;

      if OldLines[Row-PagePrintRange.Top] then DLeft:=false;
      OldLines[Row-PagePrintRange.Top]:=RealDRight;

      if DLeft0 and (not DLeft or(LeftColor<>LeftColor0)) then
      begin
        if (ACanvas.Pen.Color<>LeftColor0) then ACanvas.Pen.Color:=LeftColor0;
        ACanvas.Polyline([Point(Round(Cw*ZoomPreview), Round(LeftCh*ZoomPreview)),Point(Round(Cw*ZoomPreview), Round(Ch*ZoomPreview))]);
      end;

      if DRight0 and (not DRight or(RightColor<>RightColor0)) then
      begin
        if (ACanvas.Pen.Color<>RightColor0) then ACanvas.Pen.Color:=RightColor0;
        ACanvas.Polyline([Point(Round((Cw+RealColWidth(Col, Zoom100, XPPI))*ZoomPreview),Round(RightCh*ZoomPreview)),Point(Round((Cw+RealColWidth(Col, Zoom100, XPPI))*ZoomPreview), Round(Ch*ZoomPreview))]);
      end;

      if DLeft and (not DLeft0 or (LeftColor<>LeftColor0)) then LeftCh:=Ch;
      if DRight and (not DRight0 or (RightColor<>RightColor0)) then RightCh:=Ch;

      DLeft0:=DLeft; DRight0:=DRight;
      LeftColor0:=LeftColor; RightColor0:=RightColor;

      if (Row<=PagePrintRange.Bottom) then Ch:=Ch+RealRowHeight(Row,Zoom100,YPpi);
      inc(Row);
    end;
    Cw:=Cw+RealColWidth(Col,Zoom100,XPpi);
    inc(Col);
  end;
end;

procedure TFlexCelGrid.DoWriteHeader(const CurrentPage, TotalPages:integer; const Text: UTF16String; const ACanvas: TCanvas; const ReallyWrite: boolean; const X, Y: integer; out dX, dY: integer; const ClipRect: TRect; const XPPI, ZoomPreview, Zoom1001: extended);
var
  aText: UTF16String;
  p,q,r,o: integer;
  FSize: integer;
  Sz: TSize;
  U, dU: boolean;
  TagValue: UTF16String;
  RTFRun: TRTFRunList;
  MaxDescent: integer;
  FontSize: integer;
begin
  SetLength(RTFRun,0);
  ACanvas.Font:=Font;
  ACanvas.Font.Name:='Arial';
  ACanvas.Font.Size:=10;
  ACanvas.Font.Style:=[];
  ACanvas.Brush.Color := BackgroundColor;
  FontSize:=Round(ACanvas.Font.Size*Zoom1001);
  if FontSize < 1 then ACanvas.Font.Size := 1 else ACanvas.Font.Size := FontSize;

  aText:=Text+'&';
  p:=1;
  TagValue:='';
  U:=false;
  dU:=False;
  dx:=0; dy:=0; o:=0;
  repeat
    q:=Pos('&', copy(aText,p+o,Length(aText)))+o;
    o:=0;
    Sz:=CalcTextExtent(ACanvas, TagValue+copy(aText,p,q-1), RTFRun, MaxDescent, 1);
    if ReallyWrite then
    begin
      WriteText(ACanvas, ClipRect, X+dx, Y, TagValue+copy(aText,p,q-1), RTFRun, 1, 0);
    end;
    TagValue:='';
    inc(dX,Sz.cx);
    if Sz.cy>dy then dy:=Sz.cy;
    p:=p+q;
    if p<=Length(aText) then
    begin
      if (aText[p]='U') then
      begin
        if U then
          ACanvas.Font.Style:=ACanvas.Font.Style-[fsUnderline] else ACanvas.Font.Style:=ACanvas.Font.Style+[fsUnderline];
        dU:=False;
        U:=not U;
        inc(p);
      end else
      if (aText[p]='E') then
      begin
        if dU and not U then
          ACanvas.Font.Style:=ACanvas.Font.Style-[fsUnderline] else ACanvas.Font.Style:=ACanvas.Font.Style+[fsUnderline];
        U:=False;
        dU:=not dU;
        inc(p);
      end else
      if (aText[p]='S') then
      begin
        if fsStrikeOut in ACanvas.Font.Style then
          ACanvas.Font.Style:=ACanvas.Font.Style-[fsStrikeOut] else ACanvas.Font.Style:=ACanvas.Font.Style+[fsStrikeOut];
        inc(p);
      end else
      if (aText[p]='"') then
      begin
        inc(p);
        q:=Pos('"', copy(aText,p,Length(aText)));
        if q>0 then
        begin
          r:=Pos(',', copy(aText,p,q-1));
          if r>0 then
          begin
            ACanvas.Font.Name:=copy(aText,p,r-1);
          end else
            ACanvas.Font.Name:=copy(aText,p,q-1);
          inc(p,q);
        end;
      end else
      if (ord(AText[p])>=Ord('0')) and (ord(AText[p])<=Ord('9'))then
      begin
        FSize:=0;
        repeat
          FSize:=FSize*10+ord(AText[p])-Ord('0');
          inc(p);
        until (p>Length(aText))or (ord(AText[p])<Ord('0')) or (ord(AText[p])>Ord('9'));
        ACanvas.Font.Size:=Round(FSize*Zoom1001);

      end else
      if (aText[p]='&') then   //double & means a simple one.
      begin
        o:=1; //to skip next & from search
      end
      else
        if (aText[p]='A') then //SheetName
        begin
          inc(p); //to skip next from search
          TagValue:=FlexCelImport.ActiveSheetName;
        end
      else
        if (aText[p]='D') then //Date
        begin
          inc(p); //to skip next from search
          TagValue:=DateToStr(Now);
        end
      else
        if (aText[p]='T') then //Time
        begin
          inc(p); //to skip next from search
          TagValue:=TimetoStr(Now);
        end
      else
        if (aText[p]='P') then //Page Number
        begin
          inc(p); //to skip next from search
          TagValue:=IntToStr(CurrentPage);
        end
      else
        if (aText[p]='N') then //PageCount
        begin
          inc(p); //to skip next from search
          TagValue:=IntToStr(TotalPages);
        end
      else
        if (aText[p]='F') then //FileName
        begin
          inc(p); //to skip next from search
          TagValue:=ExtractFileName(FlexCelImport.ActiveFileName);
        end
      else
        if (aText[p]='Z') then //FullFileName
        begin
          inc(p); //to skip next from search
          TagValue:=ExtractFilePath(FlexCelImport.ActiveFileName);
        end
      else //unknown code
        inc(p);
    end;
  until p>Length(aText);
end;

procedure TFlexCelGrid.DrawHeaderOrFooter(const Text: UTF16String; const ACanvas: TCanvas; const Zoom1001, XPPI, YPPI, ZoomPreview: extended; const CurrentPage, TotalPages:integer; const Y: integer;const t:integer);
var
  dX, dY, X: integer;
  ClipRect: TRect;
  Left, Center, Right: UTF16String;
begin
  with ClipRect do
  begin
    Left:=0;
    Top:=0;
    Right:=Round(Printer.PageWidth*ZoomPreview);
    Bottom:=Round(Printer.PageHeight*ZoomPreview);
  end;
  FlexCelImport.FillPageHeaderFooter(Text,  Left, Center, Right);
  X:=Round(0.8*XPPI*96*ZoomPreview);
  DoWriteHeader(CurrentPage, TotalPages, Left, ACanvas, False, 0, 0, dX, dY, ClipRect, XPPI, ZoomPreview, Zoom1001);
  DoWriteHeader(CurrentPage, TotalPages, Left, ACanvas, True, X, Y+dY*t, dX, dY, ClipRect, XPPI, ZoomPreview, Zoom1001);

  DoWriteHeader(CurrentPage, TotalPages, Center, ACanvas, False, 0, 0, dX, dY, ClipRect, XPPI, ZoomPreview, Zoom1001);
  DoWriteHeader(CurrentPage, TotalPages, Center, ACanvas, True, (ClipRect.Right+ClipRect.Left-dX)div 2, Y+dY*t, dX, dY, ClipRect, XPPI, ZoomPreview, Zoom1001);

  DoWriteHeader(CurrentPage, TotalPages, Right, ACanvas, False, 0, 0, dX, dY, ClipRect, XPPI, ZoomPreview, Zoom1001);
  DoWriteHeader(CurrentPage, TotalPages, Right, ACanvas, True, ClipRect.Right-X-dX, Y+dY*t, dX, dY, ClipRect, XPPI, ZoomPreview, Zoom1001);

end;

procedure TFlexCelGrid.DrawHeadersAndFooters(const ACanvas: TCanvas; const Zoom1001, XPPI, YPPI, ZoomPreview: extended; const CurrentPage, TotalPages:integer; const PaintClipRect1, PaintClipRect2: TRect);
var
  Margins: TXlsMargins;
begin
  ResetClipRgn(ACanvas, PaintClipRect2);
  try
    AlignText(ACanvas, true);
    try
      Margins:=FlexCelImport.PrintMargins;
      DrawHeaderOrFooter(FlexCelImport.PageHeader, ACanvas, Zoom1001, XPPI, YPPI, ZoomPreview, CurrentPage, TotalPages, Round(Margins.Header*YPPI*96*ZoomPreview), 1);
      DrawHeaderOrFooter(FlexCelImport.PageFooter, ACanvas, Zoom1001, XPPI, YPPI, ZoomPreview, CurrentPage, TotalPages, Round((Printer.PageHeight-(Margins.Footer+0.05)*YPPI*96) *ZoomPreview), 0);
    finally
      AlignText(ACanvas,false);
    end; //finally
  finally
    ResetClipRgn(ACanvas, PaintClipRect1);
  end; //finally
end;

procedure CalcTextCoords(out X, Y: integer;var ContainingRect: TRect; const VAlign, HAlign: LongWord; const Alpha: extended; const CellRect:TRect; const Clp: integer; const TextExtent: TSize; const fmtGeneral, Vertical: boolean; const Lines: integer; const SinAlpha, CosAlpha: extended);
var
  RHAlign: LongWord;
begin
  if Alpha=0 then  //optimize the most common case
  begin
    case VAlign of
      AL_TOP: Y:=CellRect.Top+Clp;
      AL_VCENTER: Y:=(CellRect.Top+CellRect.Bottom-TextExtent.cy*Lines) div 2;
      else Y:=CellRect.Bottom-Clp-TextExtent.cy*Lines;
    end; //case

    if fmtGeneral and Vertical then RHalign:=AL_CENTER else RHalign:=HAlign;
    case RHAlign of
      AL_RIGHT: X:=CellRect.Right-Clp-TextExtent.cx;
      AL_CENTER: X:=(CellRect.Left+CellRect.Right-TextExtent.cx) div 2;
      else X:=CellRect.Left+Clp;
    end; //case
    ContainingRect:=Rect(X,Y,X+TextExtent.cx,Y+TextExtent.cy*Lines);
  end else
  // There is rotation
  begin
    case VAlign of
      AL_TOP:
        if Alpha>0 then Y:=Round(CellRect.Top+Clp+TextExtent.Cx*SinAlpha) else Y:=CellRect.Top+Clp;
      AL_VCENTER:
          Y:=Round(
             (CellRect.Top+CellRect.Bottom-
              (-TextExtent.Cx*SinAlpha+TextExtent.Cy*CosAlpha)
             ) / 2)
      else //case
        if Alpha>0 then
          Y:=Round(CellRect.Bottom-Clp-TextExtent.Cy*CosAlpha)
        else
          Y:=Round(CellRect.Bottom-Clp-TextExtent.Cy*CosAlpha+TextExtent.Cx*SinAlpha);
    end; //case

    //General horiz align depends on the rotation
    RHAlign:=HAlign;
    if FmtGeneral then
      if (Alpha=Pi/2) then  RHAlign:=AL_RIGHT
      else if Alpha>0 then RHAlign:=AL_LEFT
      else if Alpha<>-Pi/2 then RHAlign:=AL_RIGHT
      else RHAlign:=AL_LEFT;

    case RHAlign of
      AL_RIGHT:
        if Alpha>0 then
          X:=Round(CellRect.Right-Clp-(TextExtent.Cx*CosAlpha+TextExtent.Cy*SinAlpha*Lines))
        else
          X:=Round(CellRect.Right-Clp-(TextExtent.Cx*CosAlpha));

      AL_CENTER:
             X:=Round(
                (CellRect.Left+CellRect.Right-
                 (TextExtent.Cx*CosAlpha+TextExtent.Cy*SinAlpha*Lines)
                ) / 2);
      else
        if Alpha>0 then
          X:=CellRect.Left+Clp
        else
          X:=Round(CellRect.Left+Clp-TextExtent.Cy*SinAlpha*Lines);
    end; //case

    with ContainingRect do
    begin
      if Alpha>0 then
      begin
        Left:=X;
        Right:=Round(X+TextExtent.Cx*CosAlpha+TextExtent.Cy*SinAlpha*Lines);
        Top:=Round(Y-TextExtent.Cx*SinAlpha);
        Bottom:=Round(Y+TextExtent.Cy*CosAlpha);
      end else
      begin
        Left:=Round(X+TextExtent.Cy*SinAlpha*Lines);
        Right:=Round(X+TextExtent.Cx*CosAlpha);
        Top:=Y;
        Bottom:=Round(Y+TextExtent.Cy*CosAlpha-TextExtent.Cx*SinAlpha);
      end;
    end;
  end;
end;

procedure TFlexCelGrid.LoadFont(const Fnt: TFlxFont; const ACanvas: TCanvas; const Zoom100: extended);
begin
  LoadFont(FlexCelImport, Self, Fnt, ACanvas, Zoom100, ForegroundColor);
end;

class procedure TFlexCelGrid.LoadFont(const FlexCelImport: TFlexCelImport; const Grid: TFlexCelGrid; const Fnt: TFlxFont; const ACanvas: TCanvas; const Zoom100: extended; const ForegroundColor: TColor);
var
  FontName: TFontName;
begin
  if (FlexCelImport <> nil) then
  begin
    if (Fnt.ColorIndex>0)and (integer(Fnt.ColorIndex)< FlexCelImport.ColorPaletteCount) then
      ACanvas.Font.Color:=FlexCelImport.ColorPalette[Fnt.ColorIndex]
    else ACanvas.Font.Color:=ForegroundColor;
  end
  else
  begin
    ACanvas.Font.Color:=ForegroundColor; //color does not matter.
  end;

    FontName:=Fnt.Name;
    if (grid <> nil) and Assigned(Grid.OnGetFontName) then Grid.OnGetFontName(Grid, FontName);
    ACanvas.Font.Name:=FontName;
    {$IFDEF FLX_VCL}
     ACanvas.Font.Height:= -Round((Fnt.Size20 / 20.0 * Zoom100)* ACanvas.Font.PixelsPerInch / 72.0); //Height can move in smaller ammounts than size.

    {$ENDIF}
    {$IFDEF FLX_CLX}
    //Don't know why Font.Height doesn't work ok with clx and printers
     ACanvas.Font.Size:=Round((Fnt.Size20 / 20 * Zoom100));
     {$ENDIF}

    ACanvas.Font.Style:=[];
    if Fnt.Underline <> fu_None then
      ACanvas.Font.Style:=ACanvas.Font.Style+[fsUnderline];

    if flsBold in Fnt.Style then ACanvas.Font.Style:=ACanvas.Font.Style+[fsBold];
    if flsItalic in Fnt.Style then ACanvas.Font.Style:=ACanvas.Font.Style+[fsItalic];
    if flsStrikeOut in Fnt.Style then ACanvas.Font.Style:=ACanvas.Font.Style+[fsStrikeOut];
end;

class function TFlexCelGrid.SaveFont(const Font: TFont): TSavedFont;
begin
  Result.Style:= Font.Style;
  Result.Height := Font.Height;
  Result.Name := Font.Name;
  Result.Color:= Font.Color;
  Result.Rotation:= GetFontRotation(Font);
end;

class procedure TFlexCelGrid.RestoreFont(const Fnt: TFont;const SavedFont: TSavedFont);
begin
  Fnt.Style:= SavedFont.Style;
  Fnt.Height := SavedFont.Height;
  Fnt.Name := SavedFont.Name;
  Fnt.Color:= SavedFont.Color;
  RotateFontDirect(Fnt, SavedFont.Rotation);
end;


procedure TFlexCelGrid.MyDrawCell(const ACanvas: TCanvas; ACol, ARow, OrigCol: Integer; ClipRect, CellRect: TRect;
                       AState: TGridDrawState; const First: boolean; const CanSpawnL, CanSpawnR: boolean;
                       const RightCol, BottomRow: integer; const XPPI, YPPI: extended; const PaintClipRect: TRect;
                       const aZoom: integer; const Zoom100: extended; const aDrawGridLines: boolean;
                       const Printing: boolean; const SpawnedCells: TSpawnedCellList;
                       const ReallyDraw: boolean);
var
  ColorIndex, ColorIndexBg, ColorIndexFg: integer;
  Fm, Fm1: TFlxFormat;
  HAlign, VAlign: LongWord;
  Alpha, CosAlpha, SinAlpha: extended;
  TextRect, FinalRect, ContainingRect: TRect;
  OutValue: variant;
  OutText: UTF16String;
  i, k: integer;
  X, Y, Clp: integer;
  TextExtent: TSize;
  BottomColor, RightColor: TColor;
  Dg, DBottom, DRight: boolean;
  Corner: byte;
  FontColor: integer;
  MergedBounds: TXlsCellRange;
  MultiLine: boolean;
  R,G,B: integer;
  ABrush, ABrushFg, ABrushBg: TColor;
  PatternBmp: TBitmap;
  HAlignGeneral: boolean;

  CellHasPattern: boolean;

  Wr: integer;
  TextLines: WidestringArray;
  Vertical: boolean;
  RTFRuns: TRTFRunListList;
  OutRTFRuns: TRTFRunList;
  MaxDescent: integer;
  SubData: TSubscriptData;
begin
  SetLength(OutRTFRuns, 0);
  TSubscriptData_Create(SubData, []);

  if aZoom<=50 then Clp:=0 else if aZoom<=90 then Clp:=Round(1*XPPi) else Clp:=Round(1*XPpi); //Do not use margins around the cell if zoom is small
  CellHasPattern:=false;
  MultiLine:=false;
  HAlignGeneral:=false;
  //Reset Style
  ACanvas.Font:=Font;
  ACanvas.Font.Height:=Round(Font.Height*Zoom100);
  BottomColor:=clLtGray;
  RightColor:=clLtGray;
  DBottom:=false; DRight:=false;
  Alpha:=0;
  CosAlpha:=1; SinAlpha:=0;
  Vertical:=false;

  PatternBmp:=nil;
  try
    if First then
    begin
      ABrush:=Color;
      ACanvas.Pen.Width:=1;
    end else
    begin
      ABrush:=ACanvas.Brush.Color;
    end;


    HAlign:=AL_LEFT;
    VAlign:=AL_BOTTOM;
    OutText:='';

    if not Assigned(FlexCelImport) then exit;

    if FlexCelImport.IsLoaded and (aRow>0) and (aCol>0) then
    begin
      //MERGED CELLS
      //We see this before anything else, because if it's merged, we have to exit
      MergedBounds:= XCellMergedBounds[aRow, aCol];
      if aCol < MergedBounds.Right then CellRect.Right:=CellRect.Left+CalcAcumColWidth(Printing, aCol, MergedBounds.Right+1, XPPI, Zoom100);
      if aRow < MergedBounds.Bottom then CellRect.Bottom:=CellRect.Top+CalcAcumRowHeight(Printing, aRow, MergedBounds.Bottom+1, YPPI, Zoom100);

      if (aCol > MergedBounds.Left) or (aRow > MergedBounds.Top) then
      begin
        MyDrawCell(ACanvas, MergedBounds.Left, MergedBounds.Top, OrigCol, ClipRect,
                   Rect(ClipRect.Left+CalcAcumColWidth(Printing, aCol, MergedBounds.Left, XPPI, Zoom100),
                        ClipRect.Top+CalcAcumRowHeight(Printing, aRow, MergedBounds.Top, YPPI, Zoom100),
                        ClipRect.Left+CalcAcumColWidth(Printing, aCol, MergedBounds.Left+1, XPPI, Zoom100), //This is TopLeft cell
                        ClipRect.Top+CalcAcumRowHeight(Printing, aRow, MergedBounds.Top+1, YPPI, Zoom100)),
                   AState, True, False, False, MergedBounds.Right, MergedBounds.Bottom, XPPI, YPPI,
                   PaintClipRect, aZoom, Zoom100, aDrawGridLines, Printing, SpawnedCells, ReallyDraw);
        exit;
      end;

      //Value
      OutValue:=GetCellValue(aRow, aCol);
      OutRTFRuns := FlexCelImport.RTFRuns[aRow, aCol];
      if VarType(OutValue)=VarBoolean then HAlign:=AL_CENTER else
        if (VarType(OutValue)<>VarOleStr)and(VarType(OutValue)<>VarString)
        {$IFDEF DELPHI2008UP} and(VarType(OutValue)<>varUString) {$ENDIF}
            then HAlign:=AL_RIGHT;

      Fm:=CellFormatDef[aRow, aCol];
      //MULTILINE
      MultiLine:=Fm.WrapText or (Fm.HAlignment=fha_justify) or (Fm.VAlignment=fva_justify) or (Fm.VAlignment=fva_distributed);
      //PATTERN
      if First then
      begin
        ColorIndexBg:=Fm.FillPattern.bgColorIndex;
        ColorIndexFg:=Fm.FillPattern.fgColorIndex;
        if (ColorIndexFg>0)and(ColorIndexFg<=56) then
          ABrushFg:= FlexCelImport.ColorPalette[ColorIndexFg]
        else ABrushFg:=ForegroundColor;

        if (ColorIndexBg>0)and(ColorIndexBg<=56) then
          ABrushBg:= FlexCelImport.ColorPalette[ColorIndexBg]
        else ABrushBg:=BackgroundColor;

        if Fm.FillPattern.Pattern=1 then
          ABrush:=BackgroundColor
        else
        if Fm.FillPattern.Pattern=2 then
          ABrush:=ABrushFg
        else
          PatternBmp:=CreateBmpPattern(Fm.FillPattern.Pattern, ABrushFg, ABrushBg);

        CellHasPattern:=Fm.FillPattern.Pattern>1;
      end;
      //FONT
      TSubscriptData_Create(SubData, Fm.Font.Style);
      LoadFont(Fm.Font, ACanvas, Zoom100 * SubData.Factor);


      Alpha:=CalcAngle(fm.Rotation, Vertical);
      SinAlpha:=Sin(Alpha); CosAlpha:=Cos(Alpha);

      if fm.Rotation<>0 then RotateFont(aCanvas.Font, fm.Rotation);
      //BORDERS
      if (RightCol<>ACol)or (BottomRow<>aRow) then
        Fm1:=CellFormatDef[BottomRow, RightCol]
      else
        Fm1:=Fm;

      if Fm1.Borders.Bottom.Style <> fbs_None then
      begin
        BottomColor:=GetColor(Fm1.Borders.Bottom.ColorIndex);
        DBottom:=true;
      end;
      if Fm1.Borders.Right.Style <> fbs_None then
      begin
        RightColor:=GetColor(Fm1.Borders.Right.ColorIndex);
        DRight:=true;
      end;
      //Search for the other 2 borders
      if RightCol<ColCount-1 then
      begin
        Fm1:=CellFormatDef[BottomRow, RightCol+1];
        if Fm1.Borders.Left.Style <> fbs_None then
        begin
          RightColor:=GetColor(Fm1.Borders.Left.ColorIndex);
          DRight:=true;
        end;
      end;
      if BottomRow<RowCount-1 then
      begin
        Fm1:=CellFormatDef[BottomRow+1, RightCol];

        if Fm1.Borders.Top.Style <> fbs_None then
        begin
          BottomColor:=GetColor(Fm1.Borders.Top.ColorIndex);
          DBottom:=true;
        end;
      end;

      //ALIGN
      case Fm.HAlignment of
        fha_left: HAlign:=AL_LEFT;
        fha_center, fha_center_across_selection :HAlign:=AL_CENTER;
        fha_right: HAlign:=AL_RIGHT;
        fha_general: HAlignGeneral:=true;
      end;//case

      case Fm.VAlignment of
        fva_top: VAlign:=AL_TOP;
        fva_center: VAlign:=AL_VCENTER;
        fva_bottom: VAlign:=AL_BOTTOM ;
      end; //case

      //FORMULA
      if FFormulaReadOnly and FlexCelImport.IsFormula[aRow, aCol] then
        ABrush := clsilver;

      //INPLACE EDITOR
      {$IFDEF FLX_FPC}
      if (aRow=Row)and(aCol=Col) then
      begin
        if (InPlaceEditor<>nil) then InPlaceEditor.Font := ACanvas.Font;
      end;
      {$ELSE}
      if (aRow=Row)and(aCol=Col) then
      begin
        if (InPlaceEditor<>nil) then AssignFontNotRotated(ACanvas.Font,(InplaceEditor as TFlxInPlaceEdit).Font)
        else InPlaceFont:=ACanvas.Font;
      end;
      {$ENDIF}

      //NUMERIC FORMAT
      FontColor:=ACanvas.Font.Color;
      OutText:=XlsFormatValue1904(OutValue, Fm.Format, FlexCelImport.Options1904Dates, FontColor);
      ACanvas.Font.Color:=FontColor;
    end;

    if FlexCelImport.IsLoaded and (ACol=0)and(ARow>0) and not FlexCelImport.AutoRowHeight[aRow] then
    begin
      ACanvas.Font.Style:=ACanvas.Font.Style+[fsBold];
      ACanvas.Font.Color:=clNavy;
    end;

    if (ACol=0)or(ARow=0)  then
    begin
      HAlign:=AL_CENTER;
      ABrush := FixedColor;
      BottomColor:=clGray;
      RightColor:=BottomColor;
      if not HideCursor then
        if (aRow=Row)or (aCol=Col) then ABrush:= $00F2BEAA
        else if PointInGridRange(aCol, aRow, Selection) then ABrush:= $00F2BEAA;

        if (aRow=0) and (aCol<>0) then OutText:=ColTitle(aCol)
          else if aRow<>0 then OutText:=IntToStr(aRow);
    end else
    if not HideCursor then
    begin
      if (gdSelected in AState) and First and ((Selection.Top<>Selection.Bottom)or(Selection.Right<>Selection.Left)) then
      begin
        ABrush:=ColorToRGB(ABrush);
        if (ABrush and $FFFFFF)=0 then ABrush:=$5A4942 else
        begin
         R:= ABrush and $ff;
         G:= ABrush and $ff00 shr 8;
         B:= ABrush and $ff0000 shr 16;
         ABrush:=Round(33+B*0.68)shl 16+Round(12+G*0.65) shl 8+ Round(R*0.68) ;
        end;
      end;
    end;

    if ACanvas.Brush.Color<>ABrush then ACanvas.Brush.Color:=ABrush;
    if PatternBmp<>nil then ACanvas.Brush.Bitmap:=PatternBmp;

    if First then
    begin
      //Draw Grid lines and clear cell
      //When printing, this has already been done.
      if not Printing and ReallyDraw then
      begin
        ACanvas.FillRect(ClipRect);
        Dg:=(ARow=0) or (ACol=0) or ((aZoom>=50) and (aDrawGridLines) and not CellHasPattern);
        ACanvas.Pen.Color:=BottomColor;
        if (BottomColor=RightColor)and (Dg or (DBottom and DRight)) then
            ACanvas.Polyline([Point(CellRect.Left,CellRect.Bottom-1),
                             Point(CellRect.Right-1,CellRect.Bottom-1),
                             Point(CellRect.Right-1,CellRect.Top-1)])
        else
        begin
          if DBottom then Corner:=0 else Corner:=1;
          if Dg or DBottom then
            ACanvas.Polyline([Point(CellRect.Left-1+Corner,CellRect.Bottom-1),
                             Point(CellRect.Right-Corner,CellRect.Bottom-1)]);
          ACanvas.Pen.Color:=RightColor;
          if DRight then Corner:=0 else Corner:=1;
          if Dg or DRight then
            ACanvas.Polyline([Point(CellRect.Right-1,CellRect.Bottom-1-Corner),
                             Point(CellRect.Right-1,CellRect.Top-1+Corner)]);
        end;
      end;
    end;
    //Support for drawing a continued cell on an empty one
    if IsEmptyCell(ARow, ACol) and FFlexCelImport.IsLoaded and not (EditorMode)then
    begin
      if (aZoom<=25) and not Printing then exit; //Optimize for small zoom
      //Search for the previous non empty cell
      i:=FFlexCelImport.ColIndex[aRow,aCol]-1;
      while (i>0)and(IsEmptyCell(aRow,FlexCelImport.ColByIndex[aRow,i])) do dec(i);
      if i>0 then
      begin
        k:=FFlexCelImport.ColByIndex[aRow, i];
        if CellCanSpawnRight(aRow, k) then
          MyDrawCell(ACanvas, k, ARow, OrigCol, ClipRect, Rect(CellRect.Left+CalcAcumColWidth(Printing, aCol,k, XPPI, Zoom100), CellRect.Top, CellRect.Left+CalcAcumColWidth(Printing, aCol,k+1, XPPI, Zoom100), CellRect.Bottom),  AState, False, True, IsEmptyCell(aRow, aCol+1), k, ARow, XPPI, YPPI, PaintClipRect, aZoom, Zoom100, aDrawGridLines, Printing, SpawnedCells, ReallyDraw);
      end;
      //Search for next non empty cell
      i:=FFlexCelImport.ColIndex[aRow,aCol];
      while (i>0) and(i<=FFlexCelImport.ColIndexCount[aRow])and(IsEmptyCell(aRow,FlexCelImport.ColByIndex[aRow,i])) do inc(i);
      if (i>0)and(i<=FFlexCelImport.ColIndexCount[aRow]) then
      begin
        k:=FFlexCelImport.ColByIndex[aRow, i];
        if CellCanSpawnLeft(aRow, k) then
          MyDrawCell(ACanvas, k, ARow, OrigCol, ClipRect, Rect(CellRect.Left+CalcAcumColWidth(Printing, aCol,k, XPPI, Zoom100), CellRect.Top, CellRect.Left+CalcAcumColWidth(Printing, aCol,k+1, XPPI, Zoom100), CellRect.Bottom), AState,False, IsEmptyCell(aRow, aCol-1), True, k, ARow, XPPI, YPPI, PaintClipRect, aZoom, Zoom100, aDrawGridLines, Printing, SpawnedCells, ReallyDraw);
      end;

      exit; //nothing to draw
    end;

    TextRect:=Classes.Rect(ClipRect.Left+Clp, ClipRect.Top+Clp, ClipRect.Right-Clp, ClipRect.Bottom-Clp);

    TextExtent:=CalcTextExtent(ACanvas, OutText, OutRTFRuns, MaxDescent, Zoom100);
    if Multiline or Vertical then
    begin
      if Alpha=0 then Wr:=CellRect.Right-CellRect.Left-2*Clp else
        Wr:=Trunc((CellRect.Bottom-CellRect.Top-2*Clp-TextExtent.cy*CosAlpha)/Abs(SinAlpha));
      SplitText(ACanvas, OutText, Wr, TextLines, OutRTFRuns, RTFRuns, TextExtent, Vertical, Zoom100);
    end else
    begin
      SetLength(TextLines, 1);
      TextLines[0]:=OutText;
      SetLength(RTFRuns, 1);
      RTFRuns[0]:= OutRTFRuns;
    end;

    CalcTextCoords(X,Y,ContainingRect, VAlign, HAlign, Alpha, CellRect, Clp, TextExtent, HAlignGeneral, Vertical, Length(TextLines), SinAlpha, CosAlpha);

    FinalRect:=ClipRect;
    if (ACanvas=Canvas) and (FinalRect.Right>ClientWidth+BorderSize) then FinalRect.Right:=ClientWidth+BorderSize; //This is for kylix not writing past the scrollbar
    SetClipRect(ACanvas, FinalRect);

      //Clear grid lines if spawning the cell
      if First then
      begin
        //If it's a merged cell, draw on all the cell
        if (CellRect.Top<>ClipRect.Top) or (CellRect.Left<>ClipRect.Left)
        or (CellRect.Bottom<>ClipRect.Bottom) or (CellRect.Right<>ClipRect.Right) then
        begin
          if (CellRect.Right<>ClipRect.Right) then inc(TextRect.Right,Clp);
          if (CellRect.Left<>ClipRect.Left) then dec(TextRect.Left,Clp);
        end
        else
        if not MultiLine then
        begin
          if IsEmptyCell(aRow, aCol+1) then
          begin
            inc(TextRect.Right,Clp);
            if (ContainingRect.Right>= TextRect.Right) and (ContainingRect.Left<TextRect.Right) then  //Clear right grid line
            begin
              if (SpawnedCells<>nil) then SpawnedCells.Add(TSpawnedCell.Create(aRow,aCol))
              else if ReallyDraw then ACanvas.FillRect(Rect(ClipRect.Right-1,ClipRect.Top, ClipRect.Right+1, ClipRect.Bottom-1))
            end else dec(TextRect.Right, Clp);
          end;
          if IsEmptyCell(aRow, aCol-1)then
          begin
            dec(TextRect.Left,Clp);
          end;
        end;
      end else
      begin
        if CanSpawnL then dec(TextRect.Left,Clp);
        if CanSpawnR then inc(TextRect.Right,Clp);

        if CanSpawnR and (ContainingRect.Right>= TextRect.Right) and (ContainingRect.Left<TextRect.Right) then  //Clear right grid line
              if (SpawnedCells<>nil) then SpawnedCells.Add(TSpawnedCell.Create(aRow,OrigCol))
              else if ReallyDraw then ACanvas.FillRect(Rect(ClipRect.Right-1,ClipRect.Top, ClipRect.Right+1, ClipRect.Bottom-1))
      end;
      if Intersect(TextRect, ContainingRect, FinalRect) then
      begin
       FinalRect:=TextRect;  //To avoid rendering issues with printers.

        if (CellRect.Top<>ClipRect.Top) then dec(FinalRect.Top,clp); //For merged cells.
        if (CellRect.Bottom<>ClipRect.Bottom) then inc(FinalRect.Bottom,clp); //For merged cells.

        if ReallyDraw then
          for i:=0 to Length(TextLines)-1 do
          begin
            WriteText(ACanvas, FinalRect, X, Y, TextLines[i], RTFRuns[i], Zoom100, TSubscriptData_Offset(SubData, ACanvas));
            if Alpha=0 then inc(Y, TextExtent.cy) else
                            inc(X, Round(TextExtent.cy/SinAlpha));
          end;
      end;

    ResetClipRgn(ACanvas, PaintClipRect);
  finally
    ACanvas.Brush.Bitmap:=Nil;
    FreeAndNil(PatternBmp);
  end; //finally
end;

{$IFDEF FLX_VCL}
function TFlexCelGrid.GetEditText(ACol, ARow: Integer): string;
var
  Color: integer;
  Fmt: TFlxFormat;
begin
  if not Assigned(FFlexCelImport) or not FFlexCelImport.IsLoaded then Result:='' else
  begin
    FFlexCelImport.GetCellFormatDef(ARow, ACol, Fmt);
    if FlexCelImport.IsFormula[ARow, ACol] then Result:= FlexCelImport.CellFormula[ARow, ACol]
    else Result:=XlsFormatValue1904(FlexCelImport.CellValue[ARow, ACol], Fmt.Format, FlexCelImport.Options1904Dates, Color);
  end;
end;
{$ENDIF}
{$IFDEF FLX_CLX}
function TFlexCelGrid.GetEditText(ACol, ARow: Integer): UTF16String;
var
  Color: integer;
  Fmt: TFlxFormat;
begin
  if not Assigned(FFlexCelImport) or not FFlexCelImport.IsLoaded then Result:='' else
  begin
    FFlexCelImport.GetCellFormatDef(ARow, ACol, Fmt);
    if FlexCelImport.IsFormula[ARow, ACol] then Result:= FlexCelImport.CellFormula[ARow, ACol]
    else Result:=XlsFormatValue1904(FlexCelImport.CellValue[ARow, ACol], Fmt.Format, FlexCelImport.Options1904Dates, Color);
  end;
end;
{$ENDIF}

procedure TFlexCelGrid.Loaded;
begin
  inherited;
  DefaultColWidth:=220;
  DefaultRowHeight:=16;
  ColWidths[0]:=48;
end;

procedure TFlexCelGrid.ResizeRowsAndCols;
var
  i:integer;
begin
  UpdatingGridsize:=true;
  try
    DefaultRowHeight:=Round(FlexCelImport.DefaultRowHeight/RowMult*DisplayZoom100);
    for i:=1 to Min(RowCount-1, FlexCelImport.MaxRow) do
      RowHeights[i]:= Round(RowH(i)/RowMult*DisplayZoom100);

    DefaultColWidth:=Round(FlexCelImport.DefaultColWidth/ColMult*DisplayZoom100);
    for i:=1 to ColCount-1 do
      ColWidths[i]:= Round(ColW(i)/ColMult*DisplayZoom100);

    if FlexCelImport.ShowGridHeaders then
    begin
      ColWidths[0]:=Round(48*DisplayZoom100);
      RowHeights[0]:=DefaultRowHeight;
    end
    else
    begin
      ColWidths[0]:=0;
      RowHeights[0]:=0;
     end;
  finally
    UpdatingGridsize:=false;
    ColWidthsChanged;
    RowHeightsChanged;
  end; //finally
end;


procedure TFlexCelGrid.LoadSheet;
var
  i: integer;
  r, c: integer;
  Pic: TStream;
  PicType: TXlsImgTypes;
  Anchor: TClientAnchor;
  PicDat: TPictureData;
  Mc, Mr: integer;
  Handled: boolean;
begin
  DoExit;
  if not Assigned(FFlexcelImport)or not FFlexCelImport.IsLoaded then exit;
  if not FFlexCelImport.CanOptimizeRead then Raise Exception.Create(ErrUseFasterAdapter);

  //Load Images
  PictureDataList.Clear;
  for i:=0 to FlexCelImport.PicturesCount-1 do
  begin
    Pic:=TMemoryStream.Create;
    try
      FlexCelImport.GetPicture(i, Pic, PicType, Anchor);
      PicDat:= TPictureData.Create;
      try
        //We save it this way so image does not get resized when resizing cols or rows
        PicDat.Col1:= Anchor.Col1;
        PicDat.Row1:= Anchor.Row1;
        PicDat.Col2:= Anchor.Col2;
        PicDat.Row2:= Anchor.Row2;
        PicDat.Dx1:=Round(Anchor.Dx1*ColW(Anchor.Col1)/ColMult/1024);
        PicDat.Dy1:=Round(Anchor.Dy1*RowH(Anchor.Row1)/RowMult/255);
        PicDat.Width:= CalcAcumColWidthZoom100(Anchor.Col1, Anchor.Col2)+Round(Anchor.Dx2*ColW(Anchor.Col2)/ColMult/1024)-PicDat.Dx1;
        PicDat.Height:= CalcAcumRowHeightZoom100(Anchor.Row1, Anchor.Row2)+Round(Anchor.Dy2*RowH(Anchor.Row2)/RowMult/255)-PicDat.Dy1;

        PicDat.IsRectangular:= PicType in [xli_Bmp, xli_Jpeg, xli_Png];

        Pic.Position:=0;
        SaveImgStreamToGraphic(Pic, PicType, PicDat.Data, Handled);
        if not Handled and Assigned (OnFormatPicture) then OnFormatPicture(Self, Pic, PicType, PicDat.Data);

        PictureDataList.Add(PicDat);
      except
        FreeAndNil(PicDat);
        //Dont raise... is not a major error;
      end;    //finally
    finally
      FreeAndNil(Pic);
    end; //Finally
  end;


  if FFullWorksheet then
  begin
    RowCount:= 65536+1;
    ColCount:= 256+1;
  end else
  begin
    Mr:=MaxVisibleRow;
    if Mr+1 >2 then RowCount:=Mr+1 else RowCount:=2;
    Mc:=MaxVisibleCol;
    if Mc+1 >2 then ColCount:=Mc+1 else ColCount:=2;
  end;

  if FUseFixedCells then
  begin
    FlexCelImport.GetFrozenPanes(r, c);
    FixedRows:= r;
    FixedCols:= c;
  end else
  begin
    FixedRows:=1;
    FixedCols:=1;
  end;
  Row:=FixedRows;
  Col:=FixedCols;
  FDrawGridLines:=FlexCelImport.ShowGridLines;

  SheetLoaded:=true;
  ResizeRowsAndCols;

  Invalidate;
end;

procedure TFlexCelGrid.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = FFlexCelImport then
        FFlexCelImport:= nil;
  end;
end;

function TFlexCelGrid.CalcPictureRect(const i: integer; const LastHVisibleCell, LastVVisibleCell: integer; out R1: TRect;const All: boolean; const XPPI, YPPI, Zoom100: extended): boolean;
var
  Row1,Col1, w, h: integer;
begin
  Result:=false;
  FillChar(R1, SizeOf(R1), 0);
  Col1:=PictureDataList[i].Col1; Row1:=PictureDataList[i].Row1;
  if Col1> LastHVisibleCell then exit;
  if Row1> LastVVisibleCell then exit;
  w:=Round(PictureDataList[i].Width*Zoom100*XPPI)+Round(PictureDataList[i].Dx1*Zoom100*XPPI); //Separated rounds so we don't have rouding errors
  while (Col1<LeftCol - FixedCols + 1)and (w>0) do
  begin
    dec(w, Round(ColW(Col1)/ColMult*Zoom100));
    inc(Col1);
  end;
  if w<=0 then exit;

  h:=Round(PictureDataList[i].Height*Zoom100*YPPI)+Round(PictureDataList[i].Dy1*Zoom100*YPPI);
  while (Row1<TopRow- FixedRows + 1)and (h>0) do
  begin
    dec(h, Round(RowH(Row1)/RowMult*Zoom100));
    inc(Row1);
  end;
  if h<=0 then exit;

  if All then
  begin
    R1.Left:=Round(BorderSize+CalcAcumColWidth(false, 0, FixedCols , XPPI, Zoom100) +CalcAcumColWidth(False, LeftCol, PictureDataList[i].Col1, XPPI, Zoom100)+PictureDataList[i].Dx1*Zoom100*XPPI);
    R1.Top:=Round(BorderSize+CalcAcumRowHeight(false, 0, FixedRows , XPPI, Zoom100)+CalcAcumRowHeight(False, TopRow, PictureDataList[i].Row1, YPPI, Zoom100)+PictureDataList[i].Dy1*Zoom100*YPPI);
    R1.Right:=R1.Left+Round(PictureDataList[i].Width*Zoom100*XPPI);
    R1.Bottom:=R1.Top+Round(PictureDataList[i].Height*Zoom100*YPPI);
  end else
  begin
    R1.Left:=Round(BorderSize+CalcAcumColWidth(false, 0, FixedCols , XPPI, Zoom100) +CalcAcumColWidth(False, LeftCol, Col1, XPPI, Zoom100));
    R1.Top:=Round(BorderSize+CalcAcumRowHeight(false, 0, FixedRows , XPPI, Zoom100)+CalcAcumRowHeight(False, TopRow, Row1, YPPI, Zoom100));
    R1.Right:=R1.Left+w;
    R1.Bottom:=R1.Top+h;
    if PictureDataList[i].Col1>= LeftCol then inc(R1.Left, Round(PictureDataList[i].Dx1*Zoom100*XPPI));
    if PictureDataList[i].Row1>= TopRow then inc(R1.Top, Round(PictureDataList[i].Dy1*Zoom100*YPPI));
  end;
  Result:=true;
end;

function TFlexCelGrid.CalcPrintPictureRect(const i: integer; out R1: TRect; const XPPI, YPPI, Zoom100: extended; const PaintClipRect:TRect; const PagePrintRange: TXlsCellRange): boolean;
var
  Row1,Col1: integer;
begin
  Result:=false;
  FillChar(R1, SizeOf(R1), 0);
  Col1:=PictureDataList[i].Col1; Row1:=PictureDataList[i].Row1;

  if (Col1>PagePrintRange.Right) or (Row1>PagePrintRange.Bottom) then exit;

    R1.Left:=PaintClipRect.Left+Round(CalcAcumColWidth(True, PagePrintRange.Left, Col1, XPPI, Zoom100))+Round(PictureDataList[i].Dx1*Zoom100*XPPI); //Separated rounds so we don't have rouding errors
    R1.Top:=PaintClipRect.Top+Round(CalcAcumRowHeight(True, PagePrintRange.Top, Row1, YPPI, Zoom100))+Round(PictureDataList[i].Dy1*Zoom100*YPPI);
    R1.Right:=R1.Left+Round(PictureDataList[i].Width*Zoom100*XPPI);
    R1.Bottom:=R1.Top+Round(PictureDataList[i].Height*Zoom100*YPPI);

  if (R1.Bottom< PaintClipRect.Top) or (R1.Right<PaintClipRect.Left) then exit;
  Result:=true;
end;

procedure TFlexCelGrid.ResetClipRgn(const ACanvas: TCanvas;const PaintClipRect:TRect);
begin
{$IFDEF FLX_VCL}
  SelectClipRgn(ACanvas.Handle,0);
  IntersectClipRect(ACanvas.Handle, PaintClipRect.Left, PaintClipRect.Top, PaintClipRect.Right, PaintClipRect.Bottom);
{$ENDIF}
{$IFDEF FLX_CLX}
  ACanvas.SetClipRect(PaintClipRect);
{$ENDIF}
end;

procedure TFlexCelGrid.SetClipRect(const ACanvas: TCanvas; const aRect: TRect);
begin
  {$IFDEF FLX_VCL}
    IntersectClipRect(ACanvas.Handle, aRect.Left, aRect.Top, aRect.Right, aRect.Bottom);
  {$ENDIF}
  {$IFDEF FLX_CLX}
    ACanvas.SetClipRect(aRect);
  {$ENDIF}
end;

function TFlexCelGrid.GetCursorCoords: TXlsCellRange;
begin
  if Assigned(FlexCelImport) and FlexCelImport.IsLoaded then
  begin
    Result := XCellMergedBounds[Row, Col];
  end else
  begin
    Result.Left := Col;
    Result.Right := Col;
    Result.Top := Row;
    Result.Bottom := Row;
  end;
end;

procedure TFlexCelGrid.DrawCursor(const r: TXlsCellRange);
var
  FocRect: TRect;
  {$IFDEF FLX_FPC}
  FocRect2: TRect;
  {$ENDIF}
  i: integer;
begin
  if (csDesigning in ComponentState) or HideCursor then exit;

  Canvas.Pen.Width:=1;
  Canvas.Pen.Color:=ForegroundColor;

  {$IFDEF FLX_FPC}
  FocRect := CellRect(r.Left, r.Top);
  FocRect2 := CellRect(r.Right, r.Bottom);
  FocRect.BottomRight := FocRect2.BottomRight;
  {$ELSE}
  FocRect:=BoxRect(r.Left, r.Top, r.Right, r.Bottom);
  {$ENDIF}
  for i:=0 to 1 do
     Canvas.Polyline([Point(FocRect.Left+i, FocRect.Top+i), Point(FocRect.Right-i-1, FocRect.Top+i), Point(FocRect.Right-i-1, FocRect.Bottom-i-1), Point(FocRect.Left+i, FocRect.Bottom-i-1),Point(FocRect.Left+i, FocRect.Top+i)]);
end;


procedure TFlexCelGrid.Paint;
var
  R1: TRect;
  i: integer;
  {$IFNDEF FLX_FPC} DrawInfo: TGridDrawInfo; {$ENDIF}
  PaintClipRect:TRect;
  rCursor: TXlsCellRange;
  BigCursor: boolean;
  LastVisibleRow, LastVisibleCol: integer;
begin
  try
    {$IFDEF FLX_VCL}
    PaintClipRect:=Canvas.ClipRect;
    {$ENDIF}
    {$IFDEF FLX_CLX}
    PaintClipRect:=Rect(BorderSize, BorderSize, BorderSize+ClientWidth, BorderSize+ClientHeight);  //QT bug?
    {$ENDIF}

    if not Assigned(FFlexCelImport) then
    begin;
      inherited;
      Canvas.Brush.Color := clSilver;
      Canvas.Brush.Style := bsSolid;
      Canvas.FillRect(PaintClipRect);
      WriteText(Canvas, PaintClipRect, 10, 10, 'Please connect a FlexCelImport component to the grid.');
      exit;
    end;


    {$IFNDEF FLX_FPC}
    CalcDrawInfo(DrawInfo);
    LastVisibleCol := DrawInfo.Horz.LastFullVisibleCell;
    LastVisibleRow := DrawInfo.Vert.LastFullVisibleCell;
    {$ELSE}
    LastVisibleCol := LeftCol + VisibleColCount;
    LastVisibleRow := TopRow + VisibleRowCount;
    {$ENDIF}

    {$IFDEF FLX_VCL}
    //This is to avoid flicker drawing the image.
      for i:=0 to PictureDataList.Count-1 do
        if CalcPictureRect(i, LastVisibleCol + 1, LastVisibleRow+1, R1, False, 1, 1, DisplayZoom100) and PictureDataList[i].IsRectangular then
          ExcludeClipRect(Canvas.Handle, R1.Left, R1.Top, R1.Right, R1.Bottom);
    {$ENDIF}

    if (not HideCursor) then
    begin
      rCursor:= GetCursorCoords;
      BigCursor:= (rCursor.Left <> rCursor.Right) or (rCursor.Top <> rCursor.Bottom);
      if LastBigCursor or BigCursor then
        if (LastCol<>Col)or (LastRow<>Row) or (TopRow <> LastTopRow) or (LeftCol <> LastLeftCol) then
        begin
          Invalidate;
          LastRow:=Row;
          LastCol:=Col;
          LastTopRow := TopRow;
          LastLeftCol := LeftCol;
          LastBigCursor := BigCursor;
          //exit;   //would break doublebuffered.
        end;
      LastBigCursor := BigCursor;
    end;

    inherited;
    if not HideCursor then DrawCursor(rCursor);

    ResetClipRgn(Canvas, PaintClipRect);
    SetClipRect(Canvas, Rect(BorderSize+ColWidths[0], BorderSize+RowHeights[0], BorderSize+ClientWidth, BorderSize+ClientHeight));

    Canvas.Brush.Color:=BackgroundColor; Canvas.Pen.Color:=ForegroundColor;

    //Draw images
    for i:=0 to PictureDataList.Count-1 do
      if CalcPictureRect(i, LastVisibleCol+1, LastVisibleRow+1, R1, True, 1, 1, DisplayZoom100) then
      begin
        if (PictureDataList[i].Data.Graphic=nil) then Canvas.Rectangle(R1) else
          Canvas.StretchDraw(R1, PictureDataList[i].Data.Graphic);
      end;

    ResetClipRgn(Canvas, PaintClipRect);
  except
    //No exceptions on paint...
  end;
end;

procedure TFlexCelGrid.RowHeightsChanged;
begin
  if not UpdatingGridSize then
  begin
    inherited;
    ApplySheet;
    if Assigned(FOnRowHeightsChanged) then FOnRowHeightsChanged(Self);
  end;
end;

function TFlexCelGrid.SelectCell(ACol, ARow: Integer): Boolean;
var
  i: integer;
  r: TXlsCellRange;
begin
    if UpdatingGrid then
  begin
    Result:=true;
    exit;
  end;
  UpdatingGrid := true;
  try
    for i:= TopRow to TopRow+VisibleRowCount do if (i < RowCount) then InvalidateCell(0, i);
    for i:= LeftCol to LeftCol+VisibleColCount do if (i < ColCount) then InvalidateCell(i, 0);

    if (Selection.Left = Selection.Right) and (Selection.Top = Selection.Bottom) then
    begin

      if Assigned(FlexCelImport) and FlexCelImport.IsLoaded then
      begin
        r := XCellMergedBounds[ARow, ACol];
        if (ARow <> r.Top)or (ACol <> r.Left)then
        begin
          {$IFDEF FLX_VCL}
          {$IFDEF ConditionalExpressions}
            FocusCell(r.Left, r.Top, true);
          {$ELSE}
            Row := r.Top;
            Col := r.Left;
          {$ENDIF}
          {$ENDIF}
          {$IFDEF FLX_CLX}
          Row := r.Top;
          Col := r.Left;
          {$ENDIF}

          ARow := Row;
          ACol := Col;

          //Result := false;
          //exit;
        end;
      end;
    end
    else
    begin

    end;
    Result := true;
    if Assigned(FFlexCelImport) and (FFlexCelImport.IsLoaded) and  Assigned(FOnSelectCell) then
      FOnSelectCell(Self, ACol, ARow, Result);
  finally
    UpdatingGrid := false;
  end;
end;

{$IFDEF FLX_VCL}
  procedure TFlexCelGrid.SetEditText(ACol, ARow: Longint; const Value: string);
  var
    w: UTF16String;
  begin
    SetCell(ARow, ACol, Value);
    w:=Value;
    if Assigned(FOnSetEditText) then FOnSetEditText(Self, ACol, ARow, w);
  end;
{$ENDIF}
{$IFDEF FLX_CLX}
  procedure TFlexCelGrid.SetEditText(ACol, ARow: Longint; const Value: UTF16String);
  begin
    SetCell(ARow, ACol, Value);
    if Assigned(FOnSetEditText) then FOnSetEditText(Self, ACol, ARow, Value);
  end;
{$ENDIF}

procedure TFlexCelGrid.SetFlexCelImport(const Value: TFlexCelImport);
begin
  FFlexCelImport := Value;
  Invalidate;
end;

procedure TFlexCelGrid.SizeChanged(OldColCount, OldRowCount: Integer);
begin
end;

procedure TFlexCelGrid.DrawCell(ACol, ARow: Integer; ARect: TRect; AState: TGridDrawState);
var
  PaintClipRect:TRect;
begin
  {$IFDEF FLX_VCL}
  PaintClipRect:=Canvas.ClipRect;
  {$ENDIF}
  {$IFDEF FLX_CLX}
  PaintClipRect:=Rect(BorderSize, BorderSize, BorderSize+ClientWidth, BorderSize+ClientHeight);  //QT bug?
  {$ENDIF}
   MyDrawCell(Canvas, ACol, ARow, ACol, ARect, ARect, AState, True, False, False, ACol, ARow, 1, 1, PaintClipRect, FZoom, DisplayZoom100, FDrawGridLines, false, nil, true);
end;

procedure TFlexCelGrid.SetReadOnly(const Value: boolean);
begin
  FReadOnly := Value;
  if FReadOnly then Options:=Options - [goEditing] else Options:= Options + [goEditing];
end;

procedure TFlexCelGrid.KeyDown(var Key: Word; Shift: TShiftState);
var
  i,k: integer;
begin
if (Assigned(FlexCelImport)) and (FlexCelImport.IsLoaded) and(Selection.Left = Selection.Right) and (Selection.Top = Selection.Bottom) then
begin
  {$IFDEF FLX_VCL}
    if (Key = VK_RIGHT) then
  {$ENDIF}
  {$IFDEF FLX_CLX}
    if (Key = KEY_RIGHT) then
  {$ENDIF}
  begin
      i := XCellMergedBounds[Row, Col].Right + 1;
      inherited;
      if (i < ColCount)then Col := i;
      exit;
  end;

  {$IFDEF FLX_VCL}
    if (Key = VK_DOWN) then
  {$ENDIF}
  {$IFDEF FLX_CLX}
    if (Key = KEY_DOWN) then
  {$ENDIF}
  begin
      i := XCellMergedBounds[Row, Col].Bottom + 1;
      inherited;
      if (i < RowCount) then Row := i;
      exit;
  end;
end;

  {$IFDEF FLX_VCL}
    if (Key = VK_LEFT) then
  {$ENDIF}
  {$IFDEF FLX_CLX}
    if (Key = KEY_LEFT) then
  {$ENDIF}
  begin
      i := XCellMergedBounds[Row, Col].Left - 1;
      inherited;
      if (i >= FixedCols) then Col := i;
      exit;
  end;

  {$IFDEF FLX_VCL}
    if (Key = VK_UP) then
  {$ENDIF}
  {$IFDEF FLX_CLX}
    if (Key = KEY_UP) then
  {$ENDIF}
  begin
      i := XCellMergedBounds[Row, Col].Top - 1;
      inherited;
      if (i >= FIxedRows) then Row := i;
      exit;
  end;

  inherited;


{$IFDEF FLX_VCL}
  if ((Key = ord('C')) and (Shift=[ssCtrl]))
  or ((Key = VK_INSERT) and (Shift=[ssCtrl]))
  or ((Key = VK_DELETE) and (Shift=[ssShift]))
  or ((Key = ord('X')) and (Shift=[ssCtrl]))then
{$ENDIF}
{$IFDEF FLX_CLX}
  if ((Key = KEY_C) and (Shift=[ssCtrl]))
  or ((Key = KEY_INSERT) and (Shift=[ssCtrl]))
  or ((Key = KEY_DELETE) and (Shift=[ssShift]))
  or ((Key = KEY_X) and (Shift=[ssCtrl]))then
{$ENDIF}
    CopyToClipboard;

{$IFDEF FLX_VCL}
  if ((Key = ord('V')) and (Shift=[ssCtrl]))
  or ((Key = VK_INSERT) and (Shift=[ssShift])) then
{$ENDIF}
{$IFDEF FLX_CLX}
  if ((Key = KEY_V) and (Shift=[ssCtrl]))
  or ((Key = KEY_INSERT) and (Shift=[ssShift]))then
{$ENDIF}
    PasteFromClipboard;

{$IFDEF FLX_VCL}
  if (Key = VK_DELETE)
  or ((Key = ord('X')) and (Shift=[ssCtrl]))then
{$ENDIF}
{$IFDEF FLX_CLX}
  if (Key = KEY_DELETE)
  or ((Key = KEY_X) and (Shift=[ssCtrl]))then
{$ENDIF}

  begin
    if Assigned(FlexCelImport)and FlexCelImport.IsLoaded and not ReadOnly then
      for i:=Selection.Left to Selection.Right do
        for k:=Selection.Top to Selection.Bottom do
          FlexCelImport.CellValue[k,i]:=unassigned;
    //InvalidateRow(aRow) doesnt work if the grid is scrolled horizontally... on D5 at least;
    Invalidate;
    Key := 0;
  end;

{$IFDEF FLX_VCL}
  if (Key = VK_ESCAPE) then
{$ENDIF}
{$IFDEF FLX_CLX}
  if (Key = KEY_ESCAPE) then
{$ENDIF}
    DoExit;

end;

procedure TFlexCelGrid.SetZoom(const Value: integer);
begin
  ApplySheet;
  if Value>400 then FZoom := 400
  else if Value<10 then FZoom:=10
  else FZoom:=Value;
  DisplayZoom100:=FZoom/100;
  ResizeRowsAndCols;
  if Assigned(FOnZoomChanged) then FOnZoomChanged(Self, Value);
end;

{$IFNDEF FLX_FPC}
function TFlexCelGrid.CreateEditor: TInplaceEdit;
begin
  Result := TFlxInplaceEdit.Create(Self);
  if InPlaceFont<>nil then AssignFontNotRotated(InPlaceFont, (Result as TFlxInplaceEdit).Font);
end;
{$ENDIF}

procedure TFlexCelGrid.SetCell(const aRow, aCol: integer; const Text: UTF16String);

begin
  if not Assigned(FFlexCelImport) or not FFlexCelImport.IsLoaded then exit;
  if (Length(Text)>0) and (Text[1] = '=') then
  begin
    try
      FFlexCelImport.AssignCellFormulaX(aRow, aCol, Text, null);
      Invalidate;
      exit;
    except
      //    nothing, is not a valid formula.
    end;
  end;
  FFlexCelImport.SetCellString(aRow, aCol, Text);

  //InvalidateRow(aRow) doesnt work if the grid is scrolled horizontally... on D5 at least;
  Invalidate;
end;

{$IFDEF FLX_VCL}
procedure TFlexCelGrid.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  //This is to avoid flicker when we scroll
  Message.Result := 1;
end;

function TFlexCelGrid.BorderSize: integer;
begin
  BorderSize:=0;
end;
{$ENDIF}

procedure TFlexCelGrid.CopyToClipboard;
var
  Range: TXlsCellRange;
begin
  if Assigned(FFlexCelImport) and FFlexCelImport.IsLoaded then
  begin
    Range.Left:=Selection.Left;
    Range.Top:=Selection.Top;
    Range.Right:=Selection.Right;
    Range.Bottom:=Selection.Bottom;
    FFlexCelImport.CopyToClipboard(Range);
  end;
end;

procedure TFlexCelGrid.PasteFromClipboard;
begin
  if Assigned(FlexCelImport)and FlexCelImport.IsLoaded and not ReadOnly then
  begin
    //PENDING: Verify ranges are same size
    FFlexCelImport.PasteFromClipboard(Selection.Top, Selection.Left);
    invalidate;
  end;
end;

procedure TFlexCelGrid.PrintImages(const ACanvas: TCanvas; const XPPI, YPPI, Zoom100:extended; const PaintClipRect:TRect; const PagePrintRange: TXlsCellRange; const ZoomPreview: extended);
var
  i: integer;
  R1: TRect;
begin
  //Draw images
  for i:=0 to PictureDataList.Count-1 do
    if CalcPrintPictureRect(i, R1, XPPI, YPPI, Zoom100, PaintClipRect, PagePrintRange) then
    begin
      if ZoomPreview<>1 then
      begin
        R1.Left:=Round(R1.Left*ZoomPreview);
        R1.Top:=Round(R1.Top*ZoomPreview);
        R1.Right:=Round(R1.Right*ZoomPreview);
        R1.Bottom:=Round(R1.Bottom*ZoomPreview);
      end;
      if (PictureDataList[i].Data.Graphic=nil) then ACanvas.Rectangle(R1) else
        ACanvas.StretchDraw(R1, PictureDataList[i].Data.Graphic);
    end;
end;

function TFlexCelGrid.RealRowHeight(const Row: integer; const Zoom100, YPPI: extended): integer;
begin
  Result:=Round(RowH(Row)/RowMult*Zoom100*YPPI);
end;

function TFlexCelGrid.RealColWidth(const Col: integer; const Zoom100, XPPI: extended): integer;
begin
  Result:=Round(ColW(Col)/ColMult*Zoom100*XPPI);
end;

procedure TFlexCelGrid.CalcPrintedPage(const StartRow, StartCol: integer; out EndRow, EndCol: integer; const PrintRange: TXlsCellRange; const PaintClipRect:TRect; const XPPI, YPPI, Zoom100: extended);
var
  Col, Row: integer;
  Cw, Ch: extended;
begin
  Cw:=PaintClipRect.Left;
  EndCol:=PrintRange.Right;
  for Col:=StartCol to PrintRange.Right do
  begin
    Cw:=Cw+ RealColWidth(Col, Zoom100, XPpi);
    if (Cw>PaintClipRect.Right) or
      ((not FlexCelImport.PrintToFit) and (Col>StartCol) and (FlexCelImport.HasVPageBreak(Col-1))) then
    begin
      EndCol:= Col-1;
      break;
    end;
  end;
  if EndCol<StartCol then EndCol:=StartCol; //A cell wider than one page...

  /// Calc rows
  Ch:=PaintClipRect.Top;
  EndRow:=PrintRange.Bottom;
  for Row:=StartRow to PrintRange.Bottom do
  begin
    Ch:=Ch+ RealRowHeight(Row, Zoom100, YPpi);
    if (Ch>PaintClipRect.Bottom) or
      ((not FlexCelImport.PrintToFit) and (Row>StartRow) and (FlexCelImport.HasHPageBreak(Row-1))) then
    begin
      EndRow:= Row-1;
      break;
    end;
  end;
  if EndRow<StartRow then EndRow:=StartRow; //A cell taller than one page...
end;

procedure TFlexCelGrid.CalcPrintParams(const PrintRange: TXlsCellRange; out aZoom: integer; out PaintClipRect: TRect; out XPPI, YPPI, Zoom100: extended);
var
  RealXPpi, RealYPpi: integer;
  XPageCount, YPageCount: integer;
  Margins: TXlsMargins;
  Cp, Rp, XZoom, YZoom: int64;
  PagesOk: boolean;
begin
  {$IFNDEF FLX_FPC}
    {$IFDEF TESTPRINTER}
      RealXPpi:=600;
      RealYPpi:=600;
    {$ELSE}
      RealXPpi:=GetDeviceCaps(Printer.handle, LOGPIXELSX);
      RealYPpi:=GetDeviceCaps(Printer.handle, LOGPIXELSY);
    {$ENDIF}
  {$ENDIF}
  {$IFDEF FLX_FPC}
    RealXppi:=Printer.XDPI;
    RealYppi:=Printer.YDPI;
  {$ENDIF}

  XPPI:=RealXppi/96;
  YPPI:=RealYppi/96;
  Margins:= FlexCelImport.PrintMargins;
  PaintClipRect:=Rect(Round(Margins.Left* RealXppi), Round(Margins.Top*RealYppi), Round(Printer.PageWidth-Margins.Right*RealXppi), Round(Printer.PageHeight-Margins.Bottom*RealYppi));

  if FlexCelImport.PrintToFit and (PaintClipRect.Right>PaintClipRect.Left) and (PaintClipRect.Bottom>PaintClipRect.Top) then
  begin
    Cp:=CalcAcumColWidth(True, PrintRange.Left, PrintRange.Right, XPPI, 1);
    Rp:=CalcAcumRowHeight(True, PrintRange.Top, PrintRange.Bottom, YPPI, 1);
    //First try
    if (Cp = 0) or (FlexCelImport.PrintNumberOfHorizontalPages = 0) then XZoom := 100 else XZoom:= Round(100.0 * FlexCelImport.PrintNumberOfHorizontalPages * (PaintClipRect.Right-PaintClipRect.Left) / Cp);
    if (Rp = 0) or (FlexCelImport.PrintNumberOfVerticalPages = 0) then YZoom := 100 else YZoom:= Round(100.0 * FlexCelImport.PrintNumberOfVerticalPages * (PaintClipRect.Bottom-PaintClipRect.Top) / Rp);
    aZoom:=min(XZoom, YZoom);
    if aZoom>100 then aZoom:=100;
    //Iterative try until is ok;
    if aZoom>10 then
      repeat
        InternalCalcNumberOfPrintingPages(PrintRange, XPageCount, YPageCount, aZoom, PaintClipRect, XPPI, YPPI, AZoom/100);
        PagesOk:=((FlexCelImport.PrintNumberOfHorizontalPages = 0) or (XPageCount<=FlexCelImport.PrintNumberOfHorizontalPages))
        and
        ((FlexCelImport.PrintNumberOfVerticalPages = 0) or (YPageCount<=FlexCelImport.PrintNumberOfVerticalPages));
        if not PagesOk then Dec(AZoom,5);
      until (aZoom<=10) or PagesOk;
  end else
    aZoom:=FlexCelImport.PrintScale;

  if aZoom<10 then aZoom:=10;
  if aZoom>400 then aZoom:=400;
  Zoom100:=aZoom/100;

end;


procedure TFlexCelGrid.GenericPrint(const ACanvas:TCanvas; const PrintRange: TXlsCellRange; const FirstPage, LastPage: integer; const doPreview: boolean; const ZoomPreview: extended);
var
  Row, Col: integer;
  Cw, Ch: extended;
  ARect: TRect;
  XPPI, YPPI: extended;
  XPPI1, YPPI1: extended;
  PagePrintRange: TXlsCellRange;
  PaintClipRect, PaintClipRect1, PaintClipRect2:TRect;
  aZoom: integer;
  Zoom100, Zoom1001: extended;
  aDrawGridLines: boolean;
  SpawnedCells: TSpawnedCellList;
  CurrentPage: integer;
  TotalPages: integer;
begin
  aDrawGridLines:= FlexCelImport.PrintGridLines;

  SpawnedCells:=TSpawnedCellList.Create;
  try
    if not doPreview then Printer.BeginDoc;
    try
      CalcPrintParams(PrintRange, aZoom, PaintClipRect, XPPI, YPPI, Zoom100);
      CalcNumberOfPrintingPages(TotalPages);
      PaintClipRect1.Left:=Round(PaintClipRect.Left*ZoomPreview);
      PaintClipRect1.Top:=Round(PaintClipRect.Top*ZoomPreview);
      PaintClipRect1.Right:=Round(PaintClipRect.Right*ZoomPreview);
      PaintClipRect1.Bottom:=Round(PaintClipRect.Bottom*ZoomPreview);
      PaintClipRect2:=Rect(0,0,Round(Printer.PageWidth*ZoomPreview), Round(Printer.PageHeight*ZoomPreview));
      ResetClipRgn(ACanvas, PaintClipRect1);
      PagePrintRange.Right:=PrintRange.Left-1;
      if doPreview then begin; XPPI1:=1; YPPI1:=1; Zoom1001:=Zoom100*ZoomPreview*YPPI; end else begin XPPI1:=XPPI; YPPI1:=YPPI; Zoom1001:=Zoom100;end;
      CurrentPage:=1;
      repeat
        //Calc how many columns in one page
        PagePrintRange.Top:=PrintRange.Top;
        PagePrintRange.Left:=PagePrintRange.Right+1;
        CalcPrintedPage(PagePrintRange.Top, PagePrintRange.Left, PagePrintRange.Bottom, PagePrintRange.Right, PrintRange, PaintClipRect, XPPI, YPPI, Zoom100);
        Ch:=PaintClipRect.Top;

        if (CurrentPage>=FirstPage) and ((LastPage<0) or (CurrentPage<=LastPage)) then
          DrawBackground(ACanvas, PagePrintRange, Zoom100, XPPI, YPPI, PaintClipRect, aDrawGridLines, ZoomPreview);


        Row:=PrintRange.Top;
        while Row<= PrintRange.Bottom do
        begin
          if (LastPage>=0) and (CurrentPage>LastPage) then exit;
          if (CurrentPage<FirstPage)and (Row<PagePrintRange.Bottom) then Row:=PagePrintRange.Bottom; //skip it

          if Row> PagePrintRange.Bottom then
          begin
            //Before Changing pages, draw the images
            if (CurrentPage>=FirstPage) and ((LastPage<0) or (CurrentPage<=LastPage)) then
            begin
              DrawLines(ACanvas, PagePrintRange, Zoom100, XPPI, YPPI, PaintClipRect, aDrawGridLines, SpawnedCells, ZoomPreview, doPreview);
              DrawHeadersAndFooters(ACanvas, Zoom1001, XPPI, YPPI, ZoomPreview, CurrentPage, TotalPages, PaintClipRect1, PaintClipRect2);
              PrintImages(ACanvas, XPPI, YPPI, Zoom100, PaintClipRect, PagePrintRange, ZoomPreview);
              if (LastPage<0) or (CurrentPage<LastPage) then
                if not doPreview then Printer.NewPage;
            end;
            Ch:=PaintClipRect.Top;
            SpawnedCells.Clear;
            Inc(CurrentPage);

            PagePrintRange.Top:=PagePrintRange.Bottom+1;
            CalcPrintedPage(PagePrintRange.Top, PagePrintRange.Left, PagePrintRange.Bottom, PagePrintRange.Right, PrintRange, PaintClipRect, XPPI, YPPI, Zoom100);
            if (CurrentPage>=FirstPage) and ((LastPage<0) or (CurrentPage<=LastPage)) then
              DrawBackground(ACanvas, PagePrintRange, Zoom100, XPPI, YPPI, PaintClipRect, aDrawGridLines, ZoomPreview);
          end;
          Cw:=PaintClipRect.Left;
          if (CurrentPage>=FirstPage) and ((LastPage<0) or (CurrentPage<=LastPage)) then
            for Col:=PagePrintRange.Left to PagePrintRange.Right do
            begin
              ARect:= Rect(Round(Cw*ZoomPreview), Round(Ch*ZoomPreview), Round((Cw+RealColWidth(Col,Zoom100,XPpi))*ZoomPreview), Round((Ch+RealRowHeight(Row,Zoom100,YPpi))*ZoomPreview));
              MyDrawCell(ACanvas, Col, Row, Col, ARect, ARect, [], True, False, False, Col, Row, XPPI1, YPPI1, PaintClipRect1, aZoom, Zoom1001, aDrawGridLines, true, SpawnedCells, true);
              Cw:=Cw+RealColWidth(Col, Zoom100, XPpi);
            end;
          Ch:=Ch+RealRowHeight(Row,Zoom100, YPpi);
          inc(Row);
        end;

      if PagePrintRange.Right<PrintRange.Right then
      begin
        //Before Changing pages, draw the images
        if (CurrentPage>=FirstPage) and ((LastPage<0) or (CurrentPage<=LastPage)) then
        begin
          DrawLines(ACanvas, PagePrintRange, Zoom100, XPPI, YPPI, PaintClipRect, aDrawGridLines, SpawnedCells, ZoomPreview, doPreview);
          DrawHeadersAndFooters(ACanvas, Zoom100, XPPI, YPPI, ZoomPreview, CurrentPage, TotalPages, PaintClipRect1, PaintClipRect2);
          PrintImages(ACanvas, XPPI, YPPI, Zoom100, PaintClipRect, PagePrintRange, ZoomPreview);
          if (LastPage<0) or (CurrentPage<LastPage) then
                if not doPreview then Printer.NewPage;

        end;
        inc(CurrentPage);
        SpawnedCells.Clear;
      end;
      until PagePrintRange.Right>=PrintRange.Right;
      //draw the images on the last page
      if (CurrentPage>=FirstPage) and ((LastPage<0) or (CurrentPage<=LastPage)) then
      begin
        DrawLines(ACanvas, PagePrintRange, Zoom100, XPPI, YPPI, PaintClipRect, aDrawGridLines, SpawnedCells, ZoomPreview, doPreview);
        DrawHeadersAndFooters(ACanvas, Zoom1001, XPPI, YPPI, ZoomPreview, CurrentPage, TotalPages, PaintClipRect1, PaintClipRect2);
        PrintImages(ACanvas, XPPI, YPPI, Zoom100, PaintClipRect, PagePrintRange, ZoomPreview);
      end;

    finally
      if not doPreview then Printer.EndDoc;
    end;//finally
  finally
    FreeAndNil(SpawnedCells);
  end; //finally
end;

procedure TFlexCelGrid.Print(const FirstPage, LastPage: integer);
var
  Range:TXlsCellRange;
begin
  Range.Left:=1;
  Range.Top:=1;
  Range.Right:=MaxPrintableCol;
  Range.Bottom:=MaxPrintableRow;
  Print(Range, FirstPage, LastPage);
end;

procedure TFlexCelGrid.CalcNumberOfPrintingPages(const PrintRange: TXlsCellRange; out PageCount: integer);
var
  HCount, VCount: integer;
  XPPI, YPPI: extended;
  PaintClipRect:TRect;
  aZoom: integer;
  Zoom100: extended;
begin
  CalcPrintParams(PrintRange, aZoom, PaintClipRect, XPPI, YPPI, Zoom100);
  InternalCalcNumberOfPrintingPages(PrintRange, HCount, VCount, aZoom, PaintClipRect, XPPI, YPPI, Zoom100);
  PageCount:=HCount*VCount;
end;

procedure TFlexCelGrid.CalcNumberOfPrintingPages(out PageCount: integer);
var
  Range:TXlsCellRange;
begin
  Range.Left:=1;
  Range.Top:=1;
  Range.Right:=MaxPrintableCol;
  Range.Bottom:=MaxPrintableRow;
  CalcNumberOfPrintingPages(Range, PageCount);
end;

procedure TFlexCelGrid.PreviewPage(const PrintRange:TXlsCellRange; const PageNumber: integer; const ACanvas: TCanvas; const ZoomPreview: integer);
var
  RealXPpi: integer;
begin
  {$IFNDEF FLX_FPC}
    {$IFDEF TESTPRINTER}
      RealXPpi:= 600;
    {$ELSE}
      RealXPpi:=GetDeviceCaps(Printer.handle, LOGPIXELSX);
    {$ENDIF}
  {$ENDIF}
  {$IFDEF FLX_FPC}
    RealXppi:=Printer.XDPI;
  {$ENDIF}
  GenericPrint(ACanvas, PrintRange, PageNumber, PageNumber, true, ZoomPreview/100*96/RealXPPI);
end;

procedure TFlexCelGrid.InternalCalcNumberOfPrintingPages(
  const PrintRange: TXlsCellRange; out HCount, VCount: integer;
  const aZoom: integer; const PaintClipRect: TRect; const XPPI, YPPI,
  Zoom100: extended);
var
  Sr, Sc, Er, Ec: integer;
begin
  VCount:=0;
  Sr:=PrintRange.Top;
  Sc:=PrintRange.Left;
  repeat
    CalcPrintedPage(Sr, Sc, Er, Ec, PrintRange, PaintClipRect, XPPI, YPPI, Zoom100);
    inc(VCount);
    Sr:=Er+1;
  until Er>=PrintRange.Bottom;

  HCount:=0;
  Sr:=PrintRange.Top;
  Sc:=PrintRange.Left;
  repeat
    CalcPrintedPage(Sr, Sc, Er, Ec, PrintRange, PaintClipRect, XPPI, YPPI, Zoom100);
    inc(HCount);
    Sc:=Ec+1;
  until Ec>=PrintRange.Right;

end;


procedure TFlexCelGrid.Print(const PrintRange: TXlsCellRange;
  const FirstPage, LastPage: integer);
begin
  GenericPrint(Printer.Canvas, PrintRange, FirstPage, LastPage, false, 1);
end;


procedure TFlexCelGrid.CacheVisibleFormats(out VisibleFormatsCache: BooleanArray);
var
  i: integer;
  fmt: TFlxFormat;
begin
  SetLength (VisibleFormatsCache, FlexCelImport.FormatListCount);
  for i := Length(VisibleFormatsCache) - 1 downto 0 do
  begin
    FlexCelImport.GetFormatList(i, fmt);
    VisibleFormatsCache[i] :=
                                (fmt.FillPattern.Pattern <> 1)
                             or (fmt.Borders.Top.Style <> fbs_None)
                             or (fmt.Borders.Left.Style <> fbs_None)
                             or (fmt.Borders.Right.Style <> fbs_None)
                             or (fmt.Borders.Bottom.Style <> fbs_None)
                             or (fmt.Borders.DiagonalStyle <> fdb_None);
  end;

end;

function TFlexCelGrid.IsVisibleFormat(const XF: integer; VisibleFormatsCache: array of boolean): Boolean;
begin
  if (XF < 0) or (XF >= Length(VisibleFormatsCache)) then
    begin Result := false; exit; end;

  Result := VisibleFormatsCache[XF];
end;


procedure TFlexCelGrid.LastMerged(var LastRow: integer; var LastCol: integer);
var
  aCount: integer;
  i: integer;
  cr: TXlsCellRange;
begin
  aCount := FlexCelImport.CellMergedListCount;
  for i := 1 to aCount do
  begin
    cr := FlexCelImport.CellMergedList[i - 1];
    if LastCol < cr.Right then
      LastCol := cr.Right;

    if LastRow < cr.Bottom then
      LastRow := cr.Bottom;
  end;
end;

function TFlexCelGrid.PrintableColCount(const VisibleFormatsCache: BooleanArray): integer;
var
  r: integer;
  ci: integer;
  XF: integer;
  col: integer;
begin
  Result := 0;
  {for c := Max_Columns + 1 downto 1 do
    if not ColumnHidden(c) and IsVisibleFormat(FlexCelImport.ColumnFormat[c], VisibleFormatsCache) then
    begin
      Result := c;
      break;
    end;
    }


  for r := FlexCelImport.MaxRow downto 1 do
  begin
    if RowHidden(r) then continue;

    ci := FlexCelImport.ColIndexCount[r];
    while ci > 0 do
    begin
      col := FlexCelImport.ColByIndex[r, ci];
      XF := FlexCelImport.CellFormat[r, col];
      if (not IsEmptyCell(r, col)) or IsVisibleFormat(XF, VisibleFormatsCache) then
      begin
        if not ColumnHidden(col) and (col > Result) then
        begin
          Result := col;
          break;
        end;

      end;

      Dec(ci);
    end;
  end;
end;

function TFlexCelGrid.GetMaxVisibleCol: integer;
begin
  Result := GetMaxVCol(false);
end;

function TFlexCelGrid.GetMaxPrintableCol: integer;
begin
  Result := GetMaxVCol(true);
end;

function TFlexCelGrid.GetMaxVisibleRow: integer;
begin
  Result := GetMaxVRow(false);
end;

function TFlexCelGrid.GetMaxPrintableRow: integer;
begin
  Result := GetMaxVRow(true);
end;


function TFlexCelGrid.GetMaxVCol(const Printable: boolean): integer;
var
  r,c, index, i: integer;
  SpawnedCells: TSpawnedCellList;
  PaintClipRect:TRect;
  GetOut: boolean;
  ARect: TRect;
  VisibleFormatsCache: BooleanArray;
begin
  {$IFDEF FLX_VCL}
  PaintClipRect:=Canvas.ClipRect;
  {$ENDIF}
  {$IFDEF FLX_CLX}
  PaintClipRect:=Rect(BorderSize, BorderSize, BorderSize+ClientWidth, BorderSize+ClientHeight);  //QT bug?
  {$ENDIF}

  if (Printable) then
  begin
    CacheVisibleFormats(VisibleFormatsCache);
    c:=PrintableColCount(VisibleFormatsCache);
    r := Max_Rows;
    LastMerged(r, c);
  end
  else c:= FlexCelImport.MaxCol;

  ARect.Left:=0;
  for i:=0 to c-1 do inc(ARect.Left, Round(ColW(i)/ColMult));
  ARect.Right:=ARect.Left+Round(ColW(c)/ColMult);
  ARect.Top:=0;
  for i:=0 to FlexCelImport.MaxRow-1 do inc(ARect.Top, Round(RowH(i)/RowMult));
  ARect.Bottom:=ARect.Top+Round(RowH(FlexCelImport.MaxRow)/RowMult);

  SpawnedCells:=TSpawnedCellList.Create;
  try
    for r:=1 to FlexCelImport.MaxRow do
    begin
      if FlexCelImport.IsEmptyRow(r) then continue;
      repeat
        MyDrawCell(Canvas, c, r, c, ARect, ARect, [], True, False, False, c, r, 1, 1, PaintClipRect, 100, 1, true, true {not really printing, but--}, SpawnedCells, false);
        GetOut:=true;
        if SpawnedCells.Find(r+int64(c) shl 32, Index) then
        begin
          inc(c);
          ARect.Left:=ARect.Right;
          inc(ARect.Right, Round(ColW(c)/ColMult));
          GetOut:=false;
        end;
      until GetOut;

      ARect.Top:=ARect.Bottom;
      inc(ARect.Bottom, Round(RowH(r+1)/RowMult));
    end;
  finally
    FreeAndNil(SpawnedCells);
  end; //finally

  for i:=0 to PictureDataList.Count-1 do
    if PictureDataList[i].Col2>c then c:=PictureDataList[i].Col2;
  Result:=c;

end;

function TFlexCelGrid.IsPrintingRow(const r: integer; const VisibleFormatsCache: BooleanArray): Boolean;
var
  i: integer;
  XF: integer;
  col: integer;
begin
  if RowHidden(r) then
    begin Result := false; exit; end;

  if IsVisibleFormat(FlexCelImport.RowFormat[r], VisibleFormatsCache) then
    begin Result := true; exit; end;

  for i := FlexCelImport.ColIndexCount[r] downto 1 do
  begin
    col := FlexCelImport.ColByIndex[r, i];
    XF := FlexCelImport.CellFormat[r, col];
    if (not IsEmptyCell(r, col)) or IsVisibleFormat(XF, VisibleFormatsCache) then
    begin
      if not ColumnHidden(col) then
        begin Result := true; exit; end;

    end;

  end;

  Result := false;
end;


function TFlexCelGrid.GetMaxVRow(const Printable: boolean): integer;
var
  i, c: integer;
  VisibleFormatsCache: BooleanArray;
begin
  Result:=FlexCelImport.MaxRow;
  if (Printable) then
  begin
    CacheVisibleFormats(VisibleFormatsCache);
    while (Result > 0) and not IsPrintingRow(Result, VisibleFormatsCache) do dec(Result);
    c := Max_Columns;
    LastMerged(Result, c);
  end;

  for i:=0 to PictureDataList.Count-1 do
    if PictureDataList[i].Row2>Result then Result:=PictureDataList[i].Row2;
end;

procedure TFlexCelGrid.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  LMouseDown:=true;
  inherited;
end;

procedure TFlexCelGrid.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  //if LMouseDown then Options:=Options - [goEditing];
  inherited;
end;

procedure TFlexCelGrid.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  //if not ReadOnly then Options:=Options + [goEditing];
  LMouseDown:=false;
end;


function TFlexCelGrid.GetXCellMergedBounds(aRow, aCol: integer): TXlsCellRange;
begin
  Result:=FlexCelImport.CellMergedBounds[aRow, aCol];
  if CellFormatDef[aRow, aCol].HAlignment=fha_center_across_selection then
  begin
    while (Result.Left>1) and (CellFormatDef[aRow, Result.Left-1].HAlignment=fha_center_across_selection) do dec(Result.Left);
    while (Result.Right<256) and (CellFormatDef[aRow, Result.Right+1].HAlignment=fha_center_across_selection) do inc(Result.Right);
  end;
end;

procedure TFlexCelGrid.SetPrintLineWidth(const Value: integer);
begin
  if (Value>=0) then FPrintLineWidth := Value;
end;

function TFlexCelGrid.GetCellFormatDef(const aRow, aCol: integer): TFlxFormat;
begin
  FFlexCelImport.GetCellFormatDef(aRow, aCol, Result);
end;

function TFlexCelGrid.DoMouseWheelDown(Shift: TShiftState;
  {$IFDEF FLX_CLX}const {$endif} MousePos: TPoint): Boolean;
var
  {$IFNDEF FLX_FPC}DrawInfo: TGridDrawInfo;{$ENDIF}
  VisibleCols, VisibleRows: integer;
begin
  if (ScrollWheelOffset < 0) then
  begin
    Result:= inherited DoMouseWheelDown(Shift, MousePos);
    exit;
  end;

  Result := False;
  if Assigned(OnMouseWheelDown) then
    OnMouseWheelDown(Self, Shift, MousePos, Result);

  if not Result then
  begin
    {$IFNDEF FLX_FPC}
    CalcDrawInfo(DrawInfo);
    VisibleCols:=DrawInfo.Horz.LastFullVisibleCell - DrawInfo.Horz.FirstGridCell + 1;
    VisibleRows:=DrawInfo.Vert.LastFullVisibleCell - DrawInfo.Vert.FirstGridCell + 1;
    {$ELSE}
    VisibleCols:= VisibleColCount;
    VisibleRows:= VisibleRowCount;
    {$ENDIF}

    if (ssShift in Shift) then
    begin
      if (LeftCol + ScrollWheelOffset< ColCount - VisibleCols) then LeftCol := LeftCol + ScrollWheelOffset else LeftCol := ColCount - VisibleCols;
    end else
    if (ssCtrl in Shift) then
    begin
      if Zoom > 20 then Zoom := Zoom - 5;
    end else
    begin
      if (TopRow + ScrollWheelOffset < RowCount - VisibleRows) then TopRow := TopRow + ScrollWheelOffset else TopRow := RowCount - VisibleRows;
    end;
    Result:= true;
  end;
end;

function TFlexCelGrid.DoMouseWheelUp(Shift: TShiftState;
  {$IFDEF FLX_CLX}const {$endif} MousePos: TPoint): Boolean;
begin
  if (ScrollWheelOffset < 0) then
  begin
    Result:= inherited DoMouseWheelUp(Shift, MousePos);
    exit;
  end;

  Result := False;
  if Assigned(OnMouseWheelUp) then
    OnMouseWheelUp(Self, Shift, MousePos, Result);

  if not Result then
  begin
    if (ssShift in Shift) then
    begin
      if (LeftCol - ScrollWheelOffset >= FixedCols) then LeftCol := LeftCol - ScrollWheelOffset else LeftCol := FixedCols;
    end else
    if (ssCtrl in Shift) then
    begin
      if Zoom <200 then Zoom := Zoom + 5;
    end else
    begin
      if (TopRow - ScrollWheelOffset >= FixedRows) then TopRow := TopRow - ScrollWheelOffset else TopRow := FixedRows;
    end;
    Result:=true;
  end;
end;

procedure TFlexCelGrid.TopLeftChanged;
begin
  inherited TopLeftChanged;
  if Assigned(FOnTopLeftChanged) then FOnTopLeftChanged(Self);
end;

{ TPictureData }

constructor TPictureData.Create;
begin
  inherited Create;
  Data:=TPicture.Create;
end;

destructor TPictureData.Destroy;
begin
  FreeAndNil(Data);
  inherited;
end;

{ TSpawnedCell }

constructor TSpawnedCell.Create(const aRow, aCol: integer);
begin
  inherited Create;
  RowCol:=aRow+int64(aCol) shl 32;
end;


end.

