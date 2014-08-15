{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressPrinting System COMPONENT SUITE                      }
{                                                                   }
{       Copyright (C) 1998-2010 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSPRINTINGSYSTEM AND            }
{   ALL ACCOMPANYING VCL CONTROLS AS PART OF AN                     }
{   EXECUTABLE PROGRAM ONLY.                                        }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxPScxSSLnk;

interface

{$I cxVer.inc}

(*$HPPEMIT '#define HRGN unsigned'*)

uses
  Windows, Classes, Graphics, Controls, StdCtrls, ExtCtrls, ComCtrls, Dialogs,
  cxSSTypes, cxSSData, cxSSStyles, cxSSheet, cxExcelConst, dxPSCore, dxPSForm, 
  dxPSGlbl, dxPSBaseGridLnk, dxPSExcelEdgePatterns, dxPSExcelFillPatterns,
  dxPSEdgePatterns, dxPSFillPatterns, cxDrawTextUtils;   

type
  PdxPSCellBorder = ^TdxPSCellBorder;
  TdxPSCellBorder = record
    Color: TColor;
    Pattern: TdxPSEdgePatternClass;
  end;

  PdxPSCellBorders = ^TdxPSCellBorders;
  TdxPSCellBorders = array[TdxCellSide] of TdxPSCellBorder;

  TdxPSCellBorderCorner = (cbcTopLeft, cbcTopRight, cbcBottomRight, cbcBottomLeft);
  TdxPSCellBorderCorners = set of TdxPSCellBorderCorner;
  
  TdxPSCellBorderEnd = (cbsTopLeft, cbsBottomRight);
  TdxPSCellBorderEnds = set of TdxPSCellBorderEnd;

  TdxPSCellBorderSub = 0..3;
  
  TdxPSCellCorner = (ccTopLeft, ccTopRight, ccBottomRight, ccBottomLeft);

  TdxPSCellPatternsBorderPainter = class;
  TdxPSGridCellsAdapter = class;

  TdxReportCellSSString = class(TdxReportCellString)
  private
    FBorders: TdxPSCellBorders;
    FBorderSlants: DWORD;
    FBorderSubs: DWORD;
    FContentBkColor: TColor;
    FContentPattern: TdxPSFillPatternClass;
    FRealCol: Integer;
    FRealRow: Integer;
    FTextExtentLeft: Integer;
    FTextExtentRight: Integer;
    function GetBorder(ASide: TdxCellSide): TdxPSCellBorder;
    function GetBordersBkColor: TColor;
    function GetBorderSlant(ASide: TdxCellSide; ACorner: TdxPSCellBorderCorner): Integer;
    function GetBorderSlantOffset(ASide: TdxCellSide; ACorner: TdxPSCellBorderCorner): TDWORDBits;
    function GetBorderSub(ASide: TdxCellSide; AEnd: TdxPSCellBorderEnd): TdxPSCellBorderSub;
    function GetBorderSubMask(ASide: TdxCellSide; AEnd: TdxPSCellBorderEnd): DWORD;
    function GetBorderSubOffset(ASide: TdxCellSide; AEnd: TdxPSCellBorderEnd): TDWORDBits;
    function GetClipContent: Boolean;
    function GetCol: Integer;
    function GetFill: Boolean;
    function GetIsFixed: Boolean;  
    function GetIsMerged: Boolean;
    function GetIsNearMostLeft: Boolean;
    function GetIsNearMostTop: Boolean;
    function GetIsNearMostTopOrLeft: Boolean;
    function GetIsVirtual: Boolean;
    function GetRow: Integer;    
    procedure SetBorder(ASide: TdxCellSide; Value: TdxPSCellBorder);
    procedure SetBorderSlant(ASide: TdxCellSide; ACorner: TdxPSCellBorderCorner; Value: Integer);
    procedure SetBorderSub(ASide: TdxCellSide; AEnd: TdxPSCellBorderEnd; Value: TdxPSCellBorderSub);
    procedure SetClipConent(Value: Boolean);
    procedure SetFill(Value: Boolean);
    procedure SetIsFixed(Value: Boolean);
    procedure SetIsMerged(Value: Boolean);
    procedure SetIsNearMostLeft(Value: Boolean);
    procedure SetIsNearMostTop(Value: Boolean);
    procedure SetIsVirtual(Value: Boolean);
  protected
    procedure CalcBorderSubs(AnAdapter: TdxPSGridCellsAdapter);
    procedure CalcDoubleBorderSlants(AnAdapter: TdxPSGridCellsAdapter);
    
    procedure ConvertCoords(APixelsNumerator, APixelsDenominator: Integer); override;
    function GetBackgroundBounds(DC: HDC): TRect; override;
    function GetBorderEdgeBounds(ASide: TdxCellSide; const AOuterRect: TRect): TRect; override;
    function GetBorderBrush(ASide: TdxCellSide): HBRUSH;
    function GetBorderEdgeClass(ASide: TdxCellSide): TdxPSCellBorderClass; override;
    function GetEffectiveBounds(DC: HDC; AStage: TdxPSRenderStages): TRect; override;
    function GetTextBounds(DC: HDC): TRect; override;
    function IsDrawn(DC: HDC; AStage: TdxPSRenderStages; const ARect: TRect): Boolean; override;
    
    function GetBorderPainterClass: TdxPSCellBorderPainterClass; override;
    procedure InitBorderPainter(ABordersPainter: TdxPSCellBorderPainter); override;
    
    function GetContentBkColor: TColor; override;    
    function GetContentPattern: TdxPSFillPatternClass; override;
    procedure SetContentBkColor(Value: TColor); override;        
    procedure SetContentPattern(Value: TdxPSFillPatternClass); override;

    procedure ReadBorders(AReader: TdxPSDataReader);
    procedure ReadData(AReader: TdxPSDataReader); override;
    procedure WriteBorders(AWriter: TdxPSDataWriter);
    procedure WriteData(AWriter: TdxPSDataWriter); override;
    
    function GetAbsoluteInnerBounds(DC: HDC): TRect;
    function GetDoubleBorderRgn(ASide: TdxCellSide; const R: TRect): HRGN;
    function IsDoubleLineBorderPattern(ABorder: TdxPSCellBorder): Boolean; overload;
    function IsDoubleLineBorderPattern(ASide: TdxCellSide): Boolean; overload;
    function NullBorder: TdxPSCellBorder;
  public
    constructor Create(AParent: TdxReportCell); override;
    procedure Assign(Source: TPersistent); override;
     
    procedure SetBorders(AColor: TColor; APattern: TdxPSEdgePatternClass);

    procedure DrawContent(DC: HDC; AStage: TdxPSRenderStages); override;

    property Borders[ASide: TdxCellSide]: TdxPSCellBorder read GetBorder write SetBorder;
    property BordersBkColor: TColor read GetBordersBkColor;
    property BorderSlants[ASide: TdxCellSide; ACorner: TdxPSCellBorderCorner]: Integer read GetBorderSlant write SetBorderSlant;
    property BorderSubs[ASide: TdxCellSide; AEnd: TdxPSCellBorderEnd]: TdxPSCellBorderSub read GetBorderSub write SetBorderSub;
    property ClipContent: Boolean read GetClipContent write SetClipConent;
    property Col: Integer read GetCol;
    property Fill: Boolean read GetFill write SetFill;
    property IsFixed: Boolean read GetIsFixed write SetIsFixed;
    property IsMerged: Boolean read GetIsMerged write SetIsMerged;
    property IsNearMostLeft: Boolean read GetIsNearMostLeft write SetIsNearMostLeft;
    property IsNearMostTop: Boolean read GetIsNearMostTop write SetIsNearMostTop;
    property IsNearMostTopOrLeft: Boolean read GetIsNearMostTopOrLeft;
    property IsVirtual: Boolean read GetIsVirtual write SetIsVirtual;
    property RealCol: Integer read FRealCol write FRealCol;
    property RealRow: Integer read FRealRow write FRealRow;
    property Row: Integer read GetRow;
    property TextExtentLeft: Integer read FTextExtentLeft write FTextExtentLeft;
    property TextExtentRight: Integer read FTextExtentRight write FTextExtentRight;
  end;

  TdxPSCellPatternsBorderPainter = class(TdxPSCellBorderPainter)
  private
    FGridAdapter: TdxPSGridCellsAdapter;
  protected
    function ClipItemBounds(DC: HDC; AOuterRect: TRect): HRGN;
    procedure DrawBorder(DC: HDC; const R: TRect; AForeColor, ABkColor: TColor; ABrush: HBRUSH); overload;
    procedure DrawBorder(DC: HDC; ABorderRgn: HRGN; AForeColor, ABkColor: TColor; ABrush: HBRUSH); overload;
  public
    function Item: TdxReportCellSSString; reintroduce; overload;
    procedure Paint(DC: HDC); override;
    
    property GridAdapter: TdxPSGridCellsAdapter read FGridAdapter;
  end;

  TdxPSGridCellsAdapter = class
  private
    FReportCells: TdxReportCells;
    function GetCell(Col, Row: Integer): TdxReportCellSSString;
    function GetColCount: Integer;
    function GetColOffset(Index: Integer): Integer;    
    function GetColWidth(Index: Integer): Integer;
    function GetRow(Index: Integer): TdxReportCell;
    function GetRowCount: Integer;
    function GetRowHeight(Index: Integer): Integer;    
    function GetRowIndex(Index: Integer): Integer;
    function GetRowOffset(Index: Integer): Integer;        
  public
    constructor Create(AReportCells: TdxReportCells);
    function GetNeighborCell(AItem: TdxReportCellSSString; ASide: TdxCellSide): TdxReportCellSSString;
    
    property Cells[Col, Row: Integer]: TdxReportCellSSString read GetCell; default;
    property ColCount: Integer read GetColCount;
    property ColOffsets[Index: Integer]: Integer read GetColOffset;
    property ColWidths[Index: Integer]: Integer read GetColWidth;
    property RowCount: Integer read GetRowCount;
    property RowHeights[Index: Integer]: Integer read GetRowHeight;
    property RowIndexes[Index: Integer]: Integer read GetRowIndex;
    property RowOffsets[Index: Integer]: Integer read GetRowOffset;
    property Rows[Index: Integer]: TdxReportCell read GetRow;
  end;

  TdxPSSSStringGridCellDataMap = class(TdxPSTextGridCellDataMap)
  protected
    class procedure InitializeCellData(ACol, ARow: Integer; ADataItem: TAbstractdxReportCellData; 
      AReportLink: TAbstractdxGridReportLink); override;
    class function DataClass: TdxReportCellDataClass; override;
  end;
  
  TdxPSSpreadSheetReportLinkOptionView = (ssovRowAndColumnHeadings, ssovGridLines, ssovSuppressSourceFormats);
  TdxPSSpreadSheetReportLinkOptionsView = set of TdxPSSpreadSheetReportLinkOptionView;
  
  TCustomdxSpreadSheetReportLink = class(TAbstractdxGridReportLink)
  private
    FAppendingExtraColumns: Boolean;
    FColCount: Integer;  
    FCellObjects: TList;
    FExtraColumnCount: Integer;
    FGridAdapter: TdxPSGridCellsAdapter;
    FOptionsView: TdxPSSpreadSheetReportLinkOptionsView;
    FPrintArea: TRect;
    FProcessingMerges: Boolean;
    FRowCount: Integer;
    FTempFont: TFont;
    function GetBookSheet: TcxSSBookSheet;
    function GetCustomSpreadSheetBook: TcxCustomSpreadSheetBook;
    function GetMeaningColCount: Integer;
    function GetMeaningRowCount: Integer;    
    function GetMergedCells: TcxSSMergedCellsStorage;
    procedure SetOptionsView(Value: TdxPSSpreadSheetReportLinkOptionsView);
    procedure SetPrintArea(Value: TRect);
    function GetSSCellObject(ACol, ARow: Integer): TcxSSCellObject;
    function GetSSCellStyle(ACol, ARow: Integer): TcxSSCellStyle;
    function GetSSColorPalette: PcxExcelPalette;
    function GetSSDataStorage: TcxSSDataStorage;
    function GetSSDefaultCellSideColor(ASide: TdxCellSide): TColor;
    function GetSSDefaultStyle: TcxSSCellStyle;
    function GetFlatIndex(ACol, ARow: Integer): Integer;
    function GetRealColor(AColorIndex: Integer; ADefaultColor: TColor): TColor;
    function IsSSDefaultStyle(AStyle: TcxSSCellStyle): Boolean;
  protected
    FSourceHeaderFontIndex: Integer;
    
    function CannotActivateReportErrorString: string; override;  
    procedure DoChangeComponent; override;  
    procedure InternalRestoreDefaults; override;
    procedure InternalRestoreFromOriginal; override;
    function IsScaleGridLines: Boolean; override;
    function NeedTwoPassRendering: Boolean; override;

    function GetDataItemClass(ACol: Integer; ARow: Integer = 0): TdxReportCellDataClass; override;

    function GetColCount: Integer; override;
    function GetFixedColCount: Integer; override;
    function GetFixedRowCount: Integer; override;
    function GetRowCount: Integer; override;
        
    function GetCellSides(ACol, ARow: Integer): TdxCellSides; override;
    function GetCellText(ACol, ARow: Integer): string; override;
    function GetCellTextAlignY(ACol, ARow: Integer): TcxTextAlignY; override;
    function GetMinRowHeight(DC: HDC; AFont: TFont): Integer; override;
    function GetSelectionRect: TRect; override;
    function GetSourceCellColor(ACol, ARow: Integer): TColor; override;      
    function GetSourceCellContentBkColor(ACol, ARow: Integer): TColor; override;
    function GetSourceCellContentPattern(ACol, ARow: Integer): TdxPSFillPatternClass; override;
    function GetSourceCellEdge3DSoft(ACol, ARow: Integer): Boolean; override;
    function GetSourceCellEdgeMode(ACol, ARow: Integer): TdxCellEdgeMode; override;    
    function GetSourceCellFontIndex(ACol, ARow: Integer): Integer; override;
    function GetSourceCellMultiline(ACol, ARow: Integer): Boolean; override;
    function GetSourceCellTextAlignX(ACol, ARow: Integer): TcxTextAlignX; override;
    function GetSourceCellTextAlignY(ACol, ARow: Integer): TcxTextAlignY; override;
    function GetSourceCellTransparent(ACol, ARow: Integer): Boolean; override;
    function GetSourceColWidth(ACol: Integer): Integer; override;
    function GetSourceRowHeight(ARow: Integer): Integer; override;
    function HasSelection: Boolean; override;
    function IsDrawBorder: Boolean; override;    
    function IsDrawHorzLines: Boolean; override;
    function IsDrawVertLines: Boolean; override;
    function IsProcessedCol(ACol: Integer): Boolean; override;
    function IsProcessedRow(ARow: Integer): Boolean; override;

    procedure AfterConstruct(AReportCells: TdxReportCells); override;
    procedure PrepareConstruct(AReportCells: TdxReportCells); override;
    procedure UnprepareConstruct(AReportCells: TdxReportCells); override;
    
    procedure AddMerges(AReportCells: TdxReportCells);
    procedure AppendAdditionalColumns(AnAdapter: TdxPSGridCellsAdapter);
    procedure CalcTextExtents(AnAdapter: TdxPSGridCellsAdapter);
    procedure DeleteCellObjects;
    procedure DeleteUnneededCellSides(AnAdapter: TdxPSGridCellsAdapter);
    procedure FixupRowWidths(AnAdapter: TdxPSGridCellsAdapter);
    function HasMerges: Boolean;
    function IsEmptyCell(const ACell: TcxSSCellRec): Boolean;
    function OnlyEdgeIsAssigned(const ACell: TcxSSCellRec; AEdge: TcxSSEdgeBorder): Boolean;
    function OnlyLeftEdgeIsAssigned(ACell: TcxSSCellRec): Boolean;
    function OnlyTopEdgeIsAssigned(ACell: TcxSSCellRec): Boolean;
    procedure PostProcessItems(AnAdapter: TdxPSGridCellsAdapter);    
    procedure SetupCellBorders(ACol, ARow: Integer; ADataItem: TAbstractdxReportCellData); virtual;
    
    procedure CheckPrintAreaBounds(var R: TRect);
    function GetColumnOffset(ACol: Integer): Integer;
    function GetRowOffset(ARow: Integer): Integer;
    function IsMergedBorder(ACol, ARow: Integer; ASide: TdxCellSide): Boolean;
    function IsMergedCell(ACol, ARow: Integer): Boolean; virtual;
    function IsNearMostLeftCell(ACol, ARow: Integer): Boolean; virtual;
    function IsNearMostTopCell(ACol, ARow: Integer): Boolean; virtual;
    function IsShowGridLines: Boolean;
    function IsShowRowAndColumnHeadings: Boolean;
    function IsSuppressSourceFormats: Boolean;    
    
    property ColCount: Integer read GetColCount;
    property ExtraColumnCount: Integer read FExtraColumnCount;
    property MeaningColCount: Integer read GetMeaningColCount;
    property MeaningRowCount: Integer read GetMeaningRowCount;
    property MergedCells: TcxSSMergedCellsStorage read GetMergedCells;
    property RowCount: Integer read GetRowCount;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    
    procedure ClearPrintArea;
    function DataProviderPresent: Boolean; override;  
    function DataToPrintExist: Boolean; virtual;
    function PrintAreaExists: Boolean; virtual;
    
    property BookSheet: TcxSSBookSheet read GetBookSheet;
    property CustomSpreadSheetBook: TcxCustomSpreadSheetBook read GetCustomSpreadSheetBook;
    property PrintArea: TRect read FPrintArea write SetPrintArea;
  published
    property Color;
    property Effects3D;
    property FixedColor;
    property FixedFont;
    property FixedTransparent;
    property Font;
    property GridLineColor;
    property HeadersOnEveryPage;
    property OnlySelected;
    property OptionsView: TdxPSSpreadSheetReportLinkOptionsView read FOptionsView write SetOptionsView 
      default [ssovRowAndColumnHeadings];
    property RowAutoHeight;
    property ScaleFonts;
    property Soft3D;
    property Transparent;
    property UseCustomPageBreaks;
    property UseHorzDelimiters;
    property UseVertDelimiters;
    
    property OnGetCustomPageBreaks;
    property OnInitializeItem;
  end;
  
  TdxSpreadSheetBookReportLink = class(TCustomdxSpreadSheetReportLink)
  private
    function GetSpreadSheetBook: TcxSpreadSheetBook;
  public  
    property SpreadSheetBook: TcxSpreadSheetBook read GetSpreadSheetBook;
  end;

  TdxSpreadSheetReportLink = class(TCustomdxSpreadSheetReportLink)
  private
    function GetSpreadSheet: TcxSpreadSheet;
  public  
    property SpreadSheet: TcxSpreadSheet read GetSpreadSheet;
  end;

  TfmdxSpreadSheetDesignWindow = class(TStandarddxReportLinkDesignWindow)
    pnlPreview: TPanel;
    pgctrlMain: TPageControl;
    tshOptions: TTabSheet;
    pnlOptions: TPanel;
    lblShow: TLabel;
    Bevel11: TBevel;
    lblMiscellaneous: TLabel;
    Bevel4: TBevel;
    Image5: TImage;
    imgGrid: TImage;
    chbxRowAutoHeight: TCheckBox;
    tshColor: TTabSheet;
    pnlColor: TPanel;
    lblGridLinesColor: TLabel;
    bvlLineColorHolder: TBevel;
    gbxFixedTransparent: TGroupBox;
    lblFixedColor: TLabel;
    bvlFixedColorHolder: TBevel;
    gbxTransparent: TGroupBox;
    lblColor: TLabel;
    bvlColorHolder: TBevel;
    chbxTransparent: TCheckBox;
    chbxFixedTransparent: TCheckBox;
    tshFont: TTabSheet;
    pnlFont: TPanel;
    btnFont: TButton;
    edFont: TEdit;
    btnFixedFont: TButton;
    edFixedFont: TEdit;
    tshBehaviors: TTabSheet;
    Panel1: TPanel;
    Image3: TImage;
    lblSelection: TLabel;
    Bevel3: TBevel;
    lblOnEveryPage: TLabel;
    Image1: TImage;
    Bevel10: TBevel;
    chbxOnlySelected: TCheckBox;
    chbxFixedRowsOnEveryPage: TCheckBox;
    chbxShowRowAndColumnHeadings: TCheckBox;
    chbxShowGridLines: TCheckBox;
    chbxSuppressSourceFormats: TCheckBox;
    lblPreview: TStaticText;
    stTransparent: TStaticText;
    stFixedTransparent: TStaticText;
    procedure chbxFixedRowsOnEveryPageClick(Sender: TObject);
    procedure chbxOnlySelectedClick(Sender: TObject);
    procedure btnFixedFontClick(Sender: TObject);
    procedure chbxRowAutoHeightClick(Sender: TObject);
    procedure chbxSuppressSourceFormatsClick(Sender: TObject);
    procedure chbxShowRowAndColumnHeadingsClick(Sender: TObject);
    procedure chbxShowGridLinesClick(Sender: TObject);
    procedure chbxFixedTransparentClick(Sender: TObject);
    procedure ccbxColorChange(Sender: TObject);
    procedure pbxPreviewPaint(Sender: TObject);
    procedure lblColorClick(Sender: TObject);
    procedure pgctrlMainChange(Sender: TObject);
    procedure stTransparentClick(Sender: TObject);
    procedure stFixedTransparentClick(Sender: TObject);
  private
    FccbxColor: TCustomComboBox;
    FccbxFixedColor: TCustomComboBox;
    FccbxGridLineColor: TCustomComboBox;
    FPreviewBox: TCustomControl;
    function GetReportLink: TCustomdxSpreadSheetReportLink;
    procedure SetReportLink(Value: TCustomdxSpreadSheetReportLink);
    procedure CreateControls;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
  protected
    procedure DoInitialize; override;
   {$IFDEF DELPHI7}
    function GetPreviewHost: TCustomPanel; override;
   {$ENDIF}
    procedure LoadStrings; override;
    procedure PaintPreview(ACanvas: TCanvas; R: TRect); override;
    procedure UpdateControlsState; override;
    procedure UpdatePreview; override;   
  public
    constructor Create(AOwner: TComponent); override;   
    property ReportLink: TCustomdxSpreadSheetReportLink read GetReportLink write SetReportLink;
  end;
  
const
  dxPSEmptySSPrintArea: TRect = (Left: -1; Top: -1; Right: -1; Bottom: -1);

  dxPSCellSideMap: array[TcxSSEdgeBorder] of TdxCellSide = (csLeft, csTop, csRight, csBottom);
  cxSSEdgeBorderMap: array[TdxCellSide] of TcxSSEdgeBorder = (eLeft, eTop, eRight, eBottom);

  dxCellEdgeSideOrientation: array[TdxCellSide] of TdxPSCellEdgePatternOrientation = 
    (cepoVertical, cepoHorizontal, cepoVertical, cepoHorizontal);

  dxPSEdgePatternClassMap: array[TcxSSEdgeLineStyle] of TdxPSEdgePatternClass = 
   (TdxPSSolidEdgePattern, TdxPSSolidEdgePattern, TdxPSMediumSolidEdgePattern,
    TdxPSDashedEdgePattern, TdxPSDottedEdgePattern, TdxPSThickSolidEdgePattern,
    TdxPSDoubleLineSolidEdgePattern, TdxPSHairEdgePattern, TdxPSMediumDashedEdgePattern, 
    TdxPSDashDotEdgePattern, TdxPSMediumDashDotEdgePattern, TdxPSDashDotDotEdgePattern, 
    TdxPSMediumDashDotDotEdgePattern, TdxPSSlantedDashDotEdgePattern, TdxPSSolidEdgePattern);

  dxPSFillPatternClassMap: array[TcxSSFillStyle] of TdxPSFillPatternClass = 
   (TdxPSSolidFillPattern, TdxPSGray75FillPattern, TdxPSGray50FillPattern, 
    TdxPSGray25FillPattern, TdxPSGray125FillPattern, TdxPSGray625FillPattern,
    TdxPSHorizontalStripeFillPattern, TdxPSVerticalStripeFillPattern, 
    TdxPSDiagonalStripeFillPattern, TdxPSReverseDiagonalStripeFillPattern,
    TdxPSDiagonalCrossHatchFillPattern, TdxPSThickCrossHatchFillPattern,
    TdxPSThinHorizontalStripeFillPattern, TdxPSThinVerticalStripeFillPattern, 
    TdxPSThinDiagonalStripeFillPattern, TdxPSThinReverseDiagonalStripeFillPattern,
    TdxPSThinHorizontalCrossHatchFillPattern, TdxPSThinDiagonalCrossHatchFillPattern);
    
  dxPSTextAlignXMap: array[TcxDisplayTextAlignment] of TcxTextAlignX =
    (taLeft, taCenterX, taRight, taLeft, taDistributeX);
  dxPSTextAlignYMap: array[TcxVertTextAlign] of TcxTextAlignY =
    (taTop, taCenterY, taBottom, taDistributeY);
  
implementation

{$R *.DFM}

uses                             
  SysUtils, Forms, cxSSUtils, cxClasses, dxPSRes, dxPSUtl, dxExtCtrls, dxPrnDev;

const
  { Since we don't use following Format Bits in TdxReportCellSSString we are allowed to safely override them }
  dxFormatClipContent  = dxPSGlbl.dxFormatMakeSpaceForEmptyImage;
  dxFormatFill         = dxPSGlbl.dxFormatCheckEnabled;
  dxFormatFixed        = dxPSGlbl.dxFormatCheckBold;
  dxFormatMerged       = dxPSGlbl.dxFormatImageTransparent;
  dxFormatNearMostLeft = dxPSGlbl.dxFormatCheckFlat;
  dxFormatNearMostTop  = dxPSGlbl.dxFormatCheckChecked;
  dxFormatVirtual      = dxPSGlbl.dxFormatImageTransparent;
  
  SubEndMask = $00000003;
  SubBitsPerEnd = 2;
  SubBitsPerSide = SubBitsPerEnd * (Integer(High(TdxPSCellBorderEnd)) + 1);
  SlantBitsPerSide = 4;
  SlantMask = $00000001;

  { from SS }
  SystemColorStart = 55;

type
  TcxCustomSpreadSheetBookAccess = class(TcxCustomSpreadSheetBook);
  TcxSSBookSheetAccess = class(TcxSSBookSheet);
  TcxSSDataStorageAccess = class(TcxSSDataStorage);
  TcxSSCellStyleAccess = class(TcxSSCellStyle);
    
function AreBackgroundsEqual(AStyle1, AStyle2: TcxSSCellStyleRec): Boolean;
begin
  Result := 
    (AStyle1.BrushStyle = AStyle2.BrushStyle) and
    (AStyle1.BrushBkColor = AStyle2.BrushBkColor) and
    (AStyle1.BrushFgColor = AStyle2.BrushFgColor);
end;

function AreEdgesEqual(AEdge1, AEdge2: TcxSSEdgeStyleRec): Boolean;
begin
  Result := (AEdge1.Color = AEdge2.Color) and (AEdge1.Style = AEdge2.Style);
end;

function AreBordersEqual(ABorders1, ABorders2: TcxSSBordersStyle; 
  AExclusion: TcxSSEdgeBorders = []): Boolean;
var
  Edge: TcxSSEdgeBorder;
begin
  for Edge := eLeft to eBottom do 
  begin
    if Edge in AExclusion then
      Result := not AreEdgesEqual(ABorders1[Edge], ABorders2[Edge])
    else
      Result := AreEdgesEqual(ABorders1[Edge], ABorders2[Edge]);
    if not Result then Break;
  end;    
end;

function AreStylesEqual(AStyle1, AStyle2: TcxSSCellStyleRec; 
  AExclusion: TcxSSEdgeBorders = []): Boolean;
begin
  Result := AreBackgroundsEqual(AStyle1, AStyle2) and 
    AreBordersEqual(AStyle1.Borders, AStyle2.Borders, AExclusion);
end;

function IsCellDataEmpty(const ACell: TcxSSCellRec): Boolean;
begin
  Result := (ACell.Text = '') and (ACell.DateTime = 0);
end;
  
function ExposeBookSheet(ASpreadSheet: TcxSSBookSheet): TcxSSBookSheetAccess;
begin
  Result := TcxSSBookSheetAccess(ASpreadSheet);
end;

function ExposeDataStorage(ADataStorage: TcxSSDataStorage): TcxSSDataStorageAccess;
begin
  Result := TcxSSDataStorageAccess(ADataStorage);
end;

function ExposeSpreadSheetBook(ASpreadSheetBook: TcxCustomSpreadSheetBook): TcxCustomSpreadSheetBookAccess;
begin
  Result := TcxCustomSpreadSheetBookAccess(ASpreadSheetBook);
end;

function ExposeActiveSpreadSheet(ASpreadSheetBook: TcxCustomSpreadSheetBook): TcxSSBookSheetAccess;
begin
  Result := ExposeBookSheet(ExposeSpreadSheetBook(ASpreadSheetBook).ActiveSheet);
end;

function ExposeStyle(AStyle: TcxSSCellStyle): TcxSSCellStyleAccess;
begin
  Result := TcxSSCellStyleAccess(AStyle);
end;

function GetTextWidth(DC: HDC; AFont: HFONT; const S: string): Integer;
var
  Size: TSize;
begin
  AFont := SelectObject(DC, AFont);
  GetTextExtentPoint32(DC, PChar(S), Length(S), Size);
  SelectObject(DC, AFont);  
  Result := Size.cx;
end;
  
{ TdxReportCellSSString }  

constructor TdxReportCellSSString.Create(AParent: TdxReportCell);
begin
  inherited Create(AParent);
  PreventLeftTextExceed := False;
  TextAlignY := taBottom;
end;

procedure TdxReportCellSSString.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TdxReportCellSSString then
  begin
    FBorders := TdxReportCellSSString(Source).FBorders;
    FBorderSlants  := TdxReportCellSSString(Source).FBorderSlants;
    FBorderSubs := TdxReportCellSSString(Source).FBorderSubs;
    FContentBkColor := TdxReportCellSSString(Source).FContentBkColor;
    FContentPattern := TdxReportCellSSString(Source).FContentPattern;
    FRealCol := TdxReportCellSSString(Source).FRealCol;
    FRealRow := TdxReportCellSSString(Source).FRealRow;
    FTextExtentLeft := TdxReportCellSSString(Source).FTextExtentLeft;
    FTextExtentRight := TdxReportCellSSString(Source).FTextExtentRight;
  end;
end;

procedure TdxReportCellSSString.SetBorders(AColor: TColor; APattern: TdxPSEdgePatternClass);
var 
  Side: TdxCellSide;
  ABorder: TdxPSCellBorder;
begin
  for Side := csLeft to csBottom do
  begin
    ABorder := Borders[Side];
    ABorder.Color := AColor;
    ABorder.Pattern := APattern;
    Borders[Side] := ABorder;
  end;
end;

procedure TdxReportCellSSString.DrawContent(DC: HDC; AStage: TdxPSRenderStages);
begin
  if rsFirstPass in AStage then
    if IsBackgroundDrawn then DrawBackground(DC);
  if rsSecondPass in AStage then 
  begin
    if IsTextDrawn then DrawText(DC);
    if IsBordersDrawn then DrawBorders(DC);
  end;  
end;

procedure TdxReportCellSSString.CalcBorderSubs(AnAdapter: TdxPSGridCellsAdapter);
    
  function GetNeighborCell(ASide: TdxCellSide): TdxReportCellSSString;
  begin
    Result := AnAdapter.GetNeighborCell(Self, ASide);
  end;

  function GetNeighborCellBorder(ASide, ABorderSide: TdxCellSide): TdxPSCellBorder;
  var
    Neighbor: TdxReportCellSSString;
  begin
    Neighbor := GetNeighborCell(ASide);
    if Neighbor <> nil then 
      Result := Neighbor.Borders[ABorderSide]
    else      
      Result := NullBorder;
  end;

  function GetNeighborCellBorderSalient(ASide, ABorderSide: TdxCellSide; 
    ASalient: TdxPSCellBorderSalientType): Integer;
  var
    Neighbor: TdxReportCellSSString;
  begin
    Neighbor := GetNeighborCell(ASide);
    if Neighbor <> nil then 
      Result := Neighbor.BorderEdgeSalients[ABorderSide, ASalient]
    else      
      Result := 0;
  end;
    
  procedure GetBordersAtCorner(ACorner: TdxPSCellCorner; out ABorders: TdxPSCellBorders);
  begin
    case ACorner of
      ccTopLeft:
        begin
          ABorders[csLeft] := GetNeighborCellBorder(csLeft, csTop);
          ABorders[csTop] := GetNeighborCellBorder(csTop, csLeft);
          ABorders[csRight] := Borders[csTop];
          ABorders[csBottom] := Borders[csLeft];
        end;
      ccTopRight:
        begin
          ABorders[csLeft] := Borders[csTop]; 
          ABorders[csTop] := GetNeighborCellBorder(csTop, csRight);
          ABorders[csRight] := GetNeighborCellBorder(csRight, csTop);
          ABorders[csBottom] := Borders[csRight];
        end;
      ccBottomRight:
        begin
          ABorders[csLeft] := Borders[csBottom]; 
          ABorders[csTop] := Borders[csRight];
          ABorders[csRight] := GetNeighborCellBorder(csRight, csBottom);
          ABorders[csBottom] :=  GetNeighborCellBorder(csBottom, csRight);
        end;
      ccBottomLeft:
        begin
          ABorders[csLeft] := GetNeighborCellBorder(csLeft, csBottom);
          ABorders[csTop] := Borders[csLeft];
          ABorders[csRight] := Borders[csBottom];
          ABorders[csBottom] := GetNeighborCellBorder(csBottom, csLeft);
        end;
    end;
  end;

  function DontNeedCornerSubsCalculation(ACorner: TdxPSCellCorner; ABorders: TdxPSCellBorders): Boolean;
  var
    BorderCount, DblCount: Integer;
    Color: TColor;
    Side: TdxCellSide;
    Border: TdxPSCellBorder;
  begin
    BorderCount := 0;
    DblCount := 0;
    Color := clBlack;
  
    Result := False;
    for Side := csLeft to csBottom do
    begin
      Border := ABorders[Side];
      if Border.Pattern = nil then Continue;
    
      Inc(BorderCount);
      if IsDoubleLineBorderPattern(Border) then 
        Inc(DblCount);

      if (DblCount <> 0) and (DblCount <> BorderCount) then 
        Exit;
      
      if BorderCount = 1 then 
        Color := Border.Color
      else
        if Color <> Border.Color then
          Exit;
    end;
    Result := True;
  end;
    
  function GetFavoriteSides(ACorner: TdxPSCellCorner; const ABorders: TdxPSCellBorders): TdxCellSides;
  const
    CornerSideMaps: array[TdxPSCellCorner, TdxCellSide] of TdxCellSides = 
      (([],         [],        [csTop],    [csLeft]), 
       ([csTop],    [],        [],         [csRight]), 
       ([csBottom], [csRight], [],         []), 
       ([],         [csLeft],  [csBottom], []));
  var
    StartSide, FavoriteSide, Side: TdxCellSide;
    DblCount: Integer;
    DblCandidates: TdxCellSides;
    Border, FavoriteBorder: TdxPSCellBorder;
  begin 
    StartSide := csLeft;
    while (StartSide < csBottom) and (ABorders[StartSide].Pattern = nil) do 
      Inc(StartSide);
    FavoriteSide := StartSide;
    FavoriteBorder := ABorders[FavoriteSide];
    
    DblCount := 0;
    DblCandidates := [];
    for Side := StartSide to csBottom do
    begin
       Border := ABorders[Side];
       if Border.Pattern = nil then Continue;

       if IsDoubleLineBorderPattern(Border) then
       begin
         Inc(DblCount);
         DblCandidates := DblCandidates + CornerSideMaps[ACorner, Side];
       end;  
       
       if Side > StartSide then
         if not IsDoubleLineBorderPattern(Border) and 
           (IsDoubleLineBorderPattern(FavoriteBorder) or 
           (Border.Pattern.Thickness > FavoriteBorder.Pattern.Thickness) or
           ((Border.Pattern.Thickness = FavoriteBorder.Pattern.Thickness) and 
           (Border.Color < FavoriteBorder.Color))) then
         begin 
           FavoriteBorder := Border;
           FavoriteSide := Side;
         end;  
    end;
    
    if DblCount > 1 then 
      Result := DblCandidates
    else
      Result := CornerSideMaps[ACorner, FavoriteSide];
  end;

  function CalcBorderSub(ASide: TdxCellSide; AEnd: TdxPSCellBorderEnd): Integer;
  const
    ConcurSides: array[TdxCellSide, TdxPSCellBorderEnd] of TdxCellSide = 
      ((csTop, csBottom), 
       (csLeft, csRight), 
       (csTop, csBottom), 
       (csLeft, csRight));
  var
    ConcurSide: TdxCellSide;
  begin
    ConcurSide := ConcurSides[ASide, AEnd];
    Result := BorderEdgeSalients[ConcurSide, bstOuter] + 
      Max(BorderEdgeSalients[ConcurSide, bstInner], GetNeighborCellBorderSalient(ASide, ConcurSide, bstInner));
  end;

const
  BorderEnds: array[TdxPSCellCorner, TdxCellSide] of TdxPSCellBorderEnd = 
   ((cbsTopLeft, cbsTopLeft, cbsTopLeft, cbsTopLeft), 
    (cbsTopLeft, cbsBottomRight, cbsTopLeft, cbsTopLeft), 
    (cbsBottomRight, cbsBottomRight, cbsBottomRight, cbsBottomRight), 
    (cbsBottomRight, cbsTopLeft, cbsTopLeft, cbsTopLeft));
  CornerSides: array[TdxPSCellCorner] of TdxCellSides = 
    ([csLeft, csTop], 
     [csTop, csRight], 
     [csRight, csBottom], 
     [csBottom, csLeft]);
var
  Corner: TdxPSCellCorner;
  Borders: TdxPSCellBorders;
  UnfavorableSides: TdxCellSides;
  Side: TdxCellSide;
  BorderEnd: TdxPSCellBorderEnd;
begin
  for Corner := ccTopLeft to ccBottomLeft do
  begin
    GetBordersAtCorner(Corner, Borders);
    if DontNeedCornerSubsCalculation(Corner, Borders) then
      Continue;
      
    UnfavorableSides := CornerSides[Corner] - GetFavoriteSides(Corner, Borders);
    for Side := csLeft to csBottom do 
      if Side in UnfavorableSides then
      begin
        BorderEnd := BorderEnds[Corner, Side];
        BorderSubs[Side, BorderEnd] := CalcBorderSub(Side, BorderEnd);
      end;  
  end;  
end;

procedure TdxReportCellSSString.CalcDoubleBorderSlants(AnAdapter: TdxPSGridCellsAdapter);
var
  Neighbor: TdxReportCellSSString;
begin
  if IsDoubleLineBorderPattern(csLeft) then
  begin
    Neighbor := AnAdapter.GetNeighborCell(Self, csLeft);
    BorderSlants[csLeft, cbcTopLeft] := Ord((Neighbor <> nil) and Neighbor.IsDoubleLineBorderPattern(csTop));
    BorderSlants[csLeft, cbcTopRight] := Ord(IsDoubleLineBorderPattern(csTop));    
    BorderSlants[csLeft, cbcBottomRight] := Ord(IsDoubleLineBorderPattern(csBottom));    
    BorderSlants[csLeft, cbcBottomLeft] := Ord((Neighbor <> nil) and Neighbor.IsDoubleLineBorderPattern(csBottom));
  end;

  if IsDoubleLineBorderPattern(csTop) then
  begin
    Neighbor := AnAdapter.GetNeighborCell(Self, csTop);    
    BorderSlants[csTop, cbcTopLeft] := Ord((Neighbor <> nil) and Neighbor.IsDoubleLineBorderPattern(csLeft));
    BorderSlants[csTop, cbcTopRight] := Ord((Neighbor <> nil) and Neighbor.IsDoubleLineBorderPattern(csRight));    
    BorderSlants[csTop, cbcBottomRight] := Ord(IsDoubleLineBorderPattern(csRight));    
    BorderSlants[csTop, cbcBottomLeft] := Ord(IsDoubleLineBorderPattern(csLeft));
  end;

  if IsDoubleLineBorderPattern(csRight) then
  begin
    Neighbor := AnAdapter.GetNeighborCell(Self, csRight);
    BorderSlants[csRight, cbcTopLeft] := Ord(IsDoubleLineBorderPattern(csTop));
    BorderSlants[csRight, cbcTopRight] := Ord((Neighbor <> nil) and Neighbor.IsDoubleLineBorderPattern(csTop));
    BorderSlants[csRight, cbcBottomRight] := Ord((Neighbor <> nil) and Neighbor.IsDoubleLineBorderPattern(csBottom));
    BorderSlants[csRight, cbcBottomLeft] := Ord(IsDoubleLineBorderPattern(csBottom));
  end;

  if IsDoubleLineBorderPattern(csBottom) then
  begin
    Neighbor := AnAdapter.GetNeighborCell(Self, csBottom);
    BorderSlants[csBottom, cbcTopLeft] := Ord(IsDoubleLineBorderPattern(csLeft));
    BorderSlants[csBottom, cbcTopRight] := Ord(IsDoubleLineBorderPattern(csRight));
    BorderSlants[csBottom, cbcBottomRight] := Ord((Neighbor <> nil) and Neighbor.IsDoubleLineBorderPattern(csRight));
    BorderSlants[csBottom, cbcBottomLeft] := Ord((Neighbor <> nil) and Neighbor.IsDoubleLineBorderPattern(csLeft));
  end;  
end;

procedure TdxReportCellSSString.ConvertCoords(APixelsNumerator, APixelsDenominator: Integer);
begin
  inherited ConvertCoords(APixelsNumerator, APixelsDenominator);
  TextExtentLeft := MulDiv(TextExtentLeft, APixelsNumerator, APixelsDenominator);
  TextExtentRight := MulDiv(TextExtentRight, APixelsNumerator, APixelsDenominator);
end;

function TdxReportCellSSString.GetBackgroundBounds(DC: HDC): TRect;
var
  LineThickness: Integer;
begin
  Result := inherited GetBackgroundBounds(DC);
  if not IsFixed then 
  begin
    LineThickness := Self.LineThickness;
    if BorderEdgeSalients[csLeft, bstOuter] > 0 then Dec(Result.Left, LineThickness);
    if BorderEdgeSalients[csTop, bstOuter] > 0 then Dec(Result.Top, LineThickness);
    if BorderEdgeSalients[csRight, bstOuter] > 0 then Inc(Result.Right, LineThickness);
    if BorderEdgeSalients[csBottom, bstOuter] > 0 then Inc(Result.Bottom, LineThickness);
    FixupRect(DC, Result);
  end;  
end;

function TdxReportCellSSString.GetBorderEdgeBounds(ASide: TdxCellSide; const AOuterRect: TRect): TRect;
begin  
  Result := inherited GetBorderEdgeBounds(ASide, AOuterRect);
  with Result do 
    if ASide in csLeftRight then
    begin
      Inc(Top, LineThickness * BorderSubs[ASide, cbsTopLeft]);
      Dec(Bottom, LineThickness * BorderSubs[ASide, cbsBottomRight]);
    end
    else
    begin
      Inc(Left, LineThickness * BorderSubs[ASide, cbsTopLeft]);
      Dec(Right, LineThickness * BorderSubs[ASide, cbsBottomRight]);
    end;
end;

function TdxReportCellSSString.GetBorderBrush(ASide: TdxCellSide): HBRUSH;
begin
  Result := dxPSEdgePatternFactory.Items[TdxPSEdgePatternClass(BorderEdgeClasses[ASide]), IsPrinting].Brushes[dxCellEdgeSideOrientation[ASide]].Handle;
end;

function TdxReportCellSSString.GetBorderEdgeClass(ASide: TdxCellSide): TdxPSCellBorderClass;
begin
  Result := Borders[ASide].Pattern;
  if Result = nil then 
    Result := TdxPSSolidEdgePattern;
end;

function TdxReportCellSSString.GetEffectiveBounds(DC: HDC; AStage: TdxPSRenderStages): TRect;
begin
  if rsFirstPass in AStage then 
    Result := inherited GetEffectiveBounds(DC, AStage)
  else
    UnionRect(Result, GetOuterBounds(DC), GetTextBounds(DC));
end;

function TdxReportCellSSString.GetTextBounds(DC: HDC): TRect;
begin
  Result := inherited GetTextBounds(DC);
  if TextExtentLeft <> 0 then 
    Result.Left := TextExtentLeft;
  if TextExtentRight <> 0 then 
    Result.Right := TextExtentRight;
end;

function TdxReportCellSSString.IsDrawn(DC: HDC; AStage: TdxPSRenderStages; const ARect: TRect): Boolean;
var
  R: TRect;
begin
  Result := IntersectRect(R, GetAbsoluteInnerBounds(DC), ARect);
end;

function TdxReportCellSSString.GetBorderPainterClass: TdxPSCellBorderPainterClass;
begin
  if IsFixed then 
    Result := inherited GetBorderPainterClass
  else
    Result := TdxPSCellPatternsBorderPainter;
end;

procedure TdxReportCellSSString.InitBorderPainter(ABordersPainter: TdxPSCellBorderPainter);
begin
  inherited InitBorderPainter(ABordersPainter);
  if not IsFixed then 
    TdxPSCellPatternsBorderPainter(ABordersPainter).FGridAdapter := 
      TCustomdxSpreadSheetReportLink(ReportCells.ReportLink).FGridAdapter;
end;

function TdxReportCellSSString.GetContentBkColor: TColor;
begin
  Result := FContentBkColor;
end;

function TdxReportCellSSString.GetContentPattern: TdxPSFillPatternClass;
begin
  Result := FContentPattern;
end;

procedure TdxReportCellSSString.SetContentBkColor(Value: TColor);
begin
  FContentBkColor := Value;
end;

procedure TdxReportCellSSString.SetContentPattern(Value: TdxPSFillPatternClass);
begin
  FContentPattern := Value;
end;

procedure TdxReportCellSSString.ReadBorders(AReader: TdxPSDataReader);
var
  Side: TdxCellSide;
  Border: TdxPSCellBorder;
begin
  for Side := csLeft to csBottom do 
  begin
    Border.Color := AReader.ReadInteger;
    Border.Pattern := TdxPSEdgePatternClass(AReader.ReadCellBorderClass);

    Borders[Side] := Border;
  end;  
end;

procedure TdxReportCellSSString.ReadData(AReader: TdxPSDataReader);
begin
  inherited ReadData(AReader);
  with AReader do
  begin
    ReadBorders(AReader);
    FBorderSlants := ReadInteger;
    FBorderSubs := ReadInteger;
    RealCol := ReadInteger;
    RealRow := ReadInteger;
    TextExtentLeft := ReadInteger;
    TextExtentRight := ReadInteger;    
  end;
end;

procedure TdxReportCellSSString.WriteBorders(AWriter: TdxPSDataWriter);
var
  Side: TdxCellSide;
begin
  for Side := csLeft to csBottom do 
  begin
    AWriter.WriteInteger(Borders[Side].Color);
    AWriter.WriteClassName(Borders[Side].Pattern);
  end;
end;

procedure TdxReportCellSSString.WriteData(AWriter: TdxPSDataWriter);
begin
  inherited WriteData(AWriter);
  with AWriter do
  begin
    WriteBorders(AWriter);
    WriteInteger(FBorderSlants);
    WriteInteger(FBorderSubs);
    WriteInteger(RealCol);
    WriteInteger(RealRow);
    WriteInteger(TextExtentLeft);
    WriteInteger(TextExtentRight);
  end;
end;

function TdxReportCellSSString.GetAbsoluteInnerBounds(DC: HDC): TRect;
begin
  Result := GetInnerBounds(DC);
  if Parent <> nil then     
    with Parent.AbsoluteOrigin do
      OffsetRect(Result, X, Y);
end;

function TdxReportCellSSString.GetDoubleBorderRgn(ASide: TdxCellSide; const R: TRect): HRGN;
const
  VertexCount = 4;
type
  PdxPSCellEdgeCoords = ^TdxPSCellEdgeCoords;
  TdxPSCellEdgeCoords = record
    case Byte of 
      0: (TopLeft, TopRight, BottomRight, BottomLeft: TPoint);            
      1: (Points: array[0..VertexCount - 1] of TPoint);
  end;
var
  EdgeCoords: TdxPSCellEdgeCoords;
  Thickness: Integer;
begin
  with EdgeCoords do
  begin
    TopLeft := R.TopLeft;
    TopRight := Point(R.Right, R.Top);
    BottomRight := R.BottomRight;
    BottomLeft := Point(R.Left, R.Bottom);
  end;  

  Thickness := LineThickness * (TdxPSDoubleLineSolidEdgePattern.Thickness - 1);
    
  with EdgeCoords do 
    case ASide of
      csLeft:
        begin
          Inc(TopLeft.Y, Thickness * BorderSlants[ASide, cbcTopLeft]);
          Inc(TopRight.Y, Thickness * BorderSlants[ASide, cbcTopRight]);
          Dec(BottomRight.Y, Thickness * BorderSlants[ASide, cbcBottomRight]);
          Dec(BottomLeft.Y, Thickness * BorderSlants[ASide, cbcBottomLeft]);
        end;
      csTop:
        begin
          Inc(TopLeft.X, Thickness * BorderSlants[ASide, cbcTopLeft]);
          Dec(TopRight.X, Thickness * BorderSlants[ASide, cbcTopRight]);
          Dec(BottomRight.X, Thickness * BorderSlants[ASide, cbcBottomRight]);
          Inc(BottomLeft.X, Thickness * BorderSlants[ASide, cbcBottomLeft]);
        end;
      csRight:
        begin
          Inc(TopLeft.Y, Thickness * BorderSlants[ASide, cbcTopLeft]);
          Inc(TopRight.Y, Thickness * BorderSlants[ASide, cbcTopRight]);
          Dec(BottomRight.Y, Thickness * BorderSlants[ASide, cbcBottomRight]);
          Dec(BottomLeft.Y, Thickness * BorderSlants[ASide, cbcBottomLeft]);
        end;
      csBottom:
        begin
          Inc(TopLeft.X, Thickness * BorderSlants[ASide, cbcTopLeft]);
          Dec(TopRight.X, Thickness * BorderSlants[ASide, cbcTopRight]);
          Dec(BottomRight.X, Thickness * BorderSlants[ASide, cbcBottomRight]);
          Inc(BottomLeft.X, Thickness * BorderSlants[ASide, cbcBottomLeft]);
        end;
    end;
   
  Result := CreatePolygonRgn(EdgeCoords.Points, SizeOf(TdxPSCellEdgeCoords) div SizeOf(TPoint), Windows.WINDING);
end;

function TdxReportCellSSString.IsDoubleLineBorderPattern(ABorder: TdxPSCellBorder): Boolean;
begin
  with ABorder do
    Result := (Pattern <> nil) and Pattern.InheritsFrom(TdxPSDoubleLineSolidEdgePattern);
end;

function TdxReportCellSSString.IsDoubleLineBorderPattern(ASide: TdxCellSide): Boolean;
begin
  Result := (ASide in CellSides) and IsDoubleLineBorderPattern(Self.Borders[ASide]);
end;
  
function TdxReportCellSSString.NullBorder: TdxPSCellBorder;
begin
  FillChar(Result, SizeOf(TdxPSCellBorder), 0);
end;

function TdxReportCellSSString.GetBorder(ASide: TdxCellSide): TdxPSCellBorder;
begin
  Result := FBorders[ASide];
end;

function TdxReportCellSSString.GetBordersBkColor: TColor;
begin
  if Transparent then
    Result := ColorToRGB(clWindow)
  else
    Result := Color;
end;
  
function TdxReportCellSSString.GetBorderSlant(ASide: TdxCellSide; ACorner: TdxPSCellBorderCorner): Integer;
begin
  Result := (FBorderSlants shr GetBorderSlantOffset(ASide, ACorner)) and SlantMask;
end;

function TdxReportCellSSString.GetBorderSlantOffset(ASide: TdxCellSide; ACorner: TdxPSCellBorderCorner): TDWORDBits;
begin
  Result := Integer(ASide) * SlantBitsPerSide + Integer(ACorner);
end;

function TdxReportCellSSString.GetBorderSub(ASide: TdxCellSide; AEnd: TdxPSCellBorderEnd): TdxPSCellBorderSub;
begin
  Result := (FBorderSubs shr GetBorderSubOffset(ASide, AEnd)) and SubEndMask;
end;

function TdxReportCellSSString.GetBorderSubMask(ASide: TdxCellSide; AEnd: TdxPSCellBorderEnd): DWORD;
begin
  Result := 0 or (SubEndMask shl GetBorderSubOffset(ASide, AEnd));
end;

function TdxReportCellSSString.GetBorderSubOffset(ASide: TdxCellSide; AEnd: TdxPSCellBorderEnd): TDWORDBits;
begin
  Result := Integer(ASide) * SubBitsPerSide + SubBitsPerEnd * Integer(AEnd);
end;

function TdxReportCellSSString.GetClipContent: Boolean;
begin
  Result := (Format and dxFormatClipContent) = dxFormatClipContent;
end;                    

function TdxReportCellSSString.GetCol: Integer;
begin
  Result := Index;
end;

function TdxReportCellSSString.GetFill: Boolean;
begin
  Result := (Format and dxFormatFill) = dxFormatFill;
end;                    

function TdxReportCellSSString.GetIsFixed: Boolean;  
begin
  Result := (Format and dxFormatFixed) = dxFormatFixed;
end;                    

function TdxReportCellSSString.GetIsMerged: Boolean;
begin
  Result := (Format and dxFormatMerged) = dxFormatMerged;
end;

function TdxReportCellSSString.GetIsNearMostLeft: Boolean;
begin
  Result := (Format and dxFormatNearMostLeft) = dxFormatNearMostLeft;
end;

function TdxReportCellSSString.GetIsNearMostTop: Boolean;
begin
  Result := (Format and dxFormatNearMostTop) = dxFormatNearMostTop;
end;

function TdxReportCellSSString.GetIsNearMostTopOrLeft: Boolean;
begin
  Result := GetIsNearMostLeft or GetIsNearMostTop;
end;

function TdxReportCellSSString.GetIsVirtual: Boolean;
begin
  Result := GetFormatBit(dxFormatVirtual);
end;

function TdxReportCellSSString.GetRow: Integer;
begin
  Result := Parent.Index;
end;

procedure TdxReportCellSSString.SetBorder(ASide: TdxCellSide; Value: TdxPSCellBorder);
begin
  FBorders[ASide] := Value;
end;

procedure TdxReportCellSSString.SetBorderSlant(ASide: TdxCellSide;
  ACorner: TdxPSCellBorderCorner; Value: Integer);
var
  Mask: DWORD;
begin
  Mask := 1 shl GetBorderSlantOffset(ASide, ACorner);
  FBorderSlants := FBorderSlants and not Mask;
  if Value <> 0 then 
    FBorderSlants := FBorderSlants or Mask;
end;

procedure TdxReportCellSSString.SetBorderSub(ASide: TdxCellSide; AEnd: TdxPSCellBorderEnd; 
  Value: TdxPSCellBorderSub);
begin
  FBorderSubs := FBorderSubs and not GetBorderSubMask(ASide, AEnd) or 
    (Value shl GetBorderSubOffset(ASide, AEnd));
end;

procedure TdxReportCellSSString.SetClipConent(Value: Boolean);
const
  dxClipContent: array[Boolean] of DWORD = (0, dxFormatClipContent);
begin
  Format := Format and not dxFormatClipContent or dxClipContent[Value];
end;

procedure TdxReportCellSSString.SetFill(Value: Boolean);
const
  dxFill: array[Boolean] of DWORD = (0, dxFormatFill);
begin
  Format := Format and not dxFormatFill or dxFill[Value];
end;

procedure TdxReportCellSSString.SetIsFixed(Value: Boolean);
const
  dxFixed: array[Boolean] of DWORD = (0, dxFormatFixed);
begin
  Format := Format and not dxFormatFixed or dxFixed[Value];
end;

procedure TdxReportCellSSString.SetIsMerged(Value: Boolean);
const
  dxMerged: array[Boolean] of DWORD = (0, dxFormatMerged);
begin
  Format := Format and not dxFormatMerged or dxMerged[Value];
end;

procedure TdxReportCellSSString.SetIsNearMostLeft(Value: Boolean);
const
  dxIsNearMostLeft: array[Boolean] of DWORD = (0, dxFormatNearMostLeft);
begin
  Format := Format and not dxFormatNearMostLeft or dxIsNearMostLeft[Value];
end;

procedure TdxReportCellSSString.SetIsNearMostTop(Value: Boolean);
const
  dxIsNearMostTop: array[Boolean] of DWORD = (0, dxFormatNearMostTop);
begin
  Format := Format and not dxFormatNearMostTop or dxIsNearMostTop[Value];
end;

procedure TdxReportCellSSString.SetIsVirtual(Value: Boolean);
begin
  SetFormatBit(dxFormatVirtual, Value);
end;

{ TdxPSCellPatternsBorderPainter }

function TdxPSCellPatternsBorderPainter.Item: TdxReportCellSSString;
begin
  Result := inherited Item as TdxReportCellSSString;
end;

function TdxPSCellPatternsBorderPainter.ClipItemBounds(DC: HDC; AOuterRect: TRect): HRGN;
begin
  with Item do 
  begin
    if IsNearMostTop then
      Inc(AOuterRect.Top, LineThickness * BorderEdgeSalients[csTop, bstOuter]);
    if IsNearMostLeft then
      Inc(AOuterRect.Left, LineThickness * BorderEdgeSalients[csLeft, bstOuter]);
  end;    
  Result := Renderer.IntersectClipRect(AOuterRect);
end;

procedure TdxPSCellPatternsBorderPainter.DrawBorder(DC: HDC; const R: TRect;
  AForeColor, ABkColor: TColor; ABrush: HBRUSH);
begin
  ABkColor := SetBkColor(DC, ABkColor);
  AForeColor := SetTextColor(DC, AForeColor);
  FillRect(DC, R, ABrush);
  SetTextColor(DC, AForeColor);
  SetBkColor(DC, ABkColor);
end;

procedure TdxPSCellPatternsBorderPainter.DrawBorder(DC: HDC; ABorderRgn: HRGN;
  AForeColor, ABkColor: TColor; ABrush: HBRUSH);
begin
  ABkColor := SetBkColor(DC, ABkColor);
  AForeColor := SetTextColor(DC, AForeColor);
  FillRgn(DC, ABorderRgn, ABrush);
  SetTextColor(DC, AForeColor);
  SetBkColor(DC, ABkColor);
end;

procedure TdxPSCellPatternsBorderPainter.Paint(DC: HDC);
var
  R: TRect;
  Rgn: HRGN;
  Side: TdxCellSide;
  BorderRect: TRect;
  BorderBr: HBRUSH;      
  BrushOrg: TPoint;
  BorderRgn: HRGN;
  Border: TdxPSCellBorder;
begin
  with Item do
  begin
    R := GetOuterBounds(DC);
    Rgn := 0;
    if IsNearMostTopOrLeft then Rgn := ClipItemBounds(DC, R);

    for Side := csLeft to csBottom do 
      if Side in CellSides then 
      begin
        BorderRect := GetBorderEdgeBounds(Side, R);
        if RectVisible(DC, BorderRect) then
        begin
          BorderBr := GetBorderBrush(Side);
          Border := Borders[Side];
          GetBrushOrgEx(DC, BrushOrg);
          if (Border.Pattern <> nil) and Border.Pattern.RequiredBrushOrigin then
          begin
            UnrealizeObject(BorderBrush);
            BrushOrg := BorderRect.TopLeft;
            LPToDP(DC, BrushOrg, 1);
            SetBrushOrgEx(DC, BrushOrg.X mod 2{Border.Pattern.Thickness}, BrushOrg.Y mod 2{Border.Pattern.Thickness}, nil);
          end;
          
          FixupRect(DC, BorderRect);
          if IsDoubleLineBorderPattern(Side) then
          begin
            BorderRgn := GetDoubleBorderRgn(Side, BorderRect);
            DrawBorder(DC, BorderRgn, Border.Color, BordersBkColor, BorderBr);
            DeleteObject(BorderRgn);
          end  
          else
            DrawBorder(DC, BorderRect, Border.Color, BordersBkColor, BorderBr);
            
          if (Border.Pattern <> nil) and Border.Pattern.RequiredBrushOrigin then
            SetBrushOrgEx(DC, BrushOrg.X, BrushOrg.Y, nil);
        end;  
      end;  
      
     if IsNearMostTopOrLeft then Renderer.RestoreClipRgn(Rgn);
  end;    
end;

{ TdxPSGridCellsAdapter }

constructor TdxPSGridCellsAdapter.Create(AReportCells: TdxReportCells);
begin
  inherited Create;
  FReportCells := AReportCells;
end;

function TdxPSGridCellsAdapter.GetNeighborCell(AItem: TdxReportCellSSString; 
  ASide: TdxCellSide): TdxReportCellSSString;
begin
  Result := nil;
  case ASide of 
    csLeft:
      if AItem.Col > 0 then
        Result := Cells[AItem.Col - 1, AItem.Row];
    csTop:
      if AItem.Row > 0 then
        Result := Cells[AItem.Col, AItem.Row - 1];
    csRight:
      if AItem.Col + 1 < ColCount then
        Result := Cells[AItem.Col + 1, AItem.Row];
    csBottom:
      if AItem.Row + 1 < RowCount then
        Result := Cells[AItem.Col, AItem.Row + 1];
  end;
end;

function TdxPSGridCellsAdapter.GetCell(Col, Row: Integer): TdxReportCellSSString;
begin                                                 
  Result := FReportCells.Cells[Row].DataItems[Col] as TdxReportCellSSString;
end;

function TdxPSGridCellsAdapter.GetColCount: Integer;
begin
  with FReportCells do 
    if Cells.CellCount > 0 then
      Result := Cells[0].DataItemCount
    else
      Result := 0;  
end;

function TdxPSGridCellsAdapter.GetColOffset(Index: Integer): Integer;
begin
  if Index < ColCount then 
    Result := Cells[Index, 0].Left
  else
    Result := Cells[ColCount - 1, 0].Left + Cells[ColCount - 1, 0].Width;
end;

function TdxPSGridCellsAdapter.GetColWidth(Index: Integer): Integer;
begin
  Result := Cells[Index, 0].Width;
end;

function TdxPSGridCellsAdapter.GetRow(Index: Integer): TdxReportCell;
begin
  Result := FReportCells.Cells[Index];
end;

function TdxPSGridCellsAdapter.GetRowCount: Integer;
begin
  Result := FReportCells.Cells.CellCount;
end;

function TdxPSGridCellsAdapter.GetRowHeight(Index: Integer): Integer;    
begin
  Result := Cells[0, Index].Height;
end;

function TdxPSGridCellsAdapter.GetRowIndex(Index: Integer): Integer;
begin
  Result := Rows[Index].Data;
end;

function TdxPSGridCellsAdapter.GetRowOffset(Index: Integer): Integer;
begin
  if Index < RowCount then
    Result := Cells[0, Index].Top
  else
    Result := Cells[0, RowCount - 1].Top + Cells[0, RowCount - 1].Height;
end;

{ TdxPSSSStringGridCellDataMap }

class procedure TdxPSSSStringGridCellDataMap.InitializeCellData(ACol, ARow: Integer; 
  ADataItem: TAbstractdxReportCellData; AReportLink: TAbstractdxGridReportLink);
begin
  inherited;
  with TCustomdxSpreadSheetReportLink(AReportLink) do 
  begin
    TdxReportCellSSString(ADataItem).Fill := not IsFixedCell(ACol, ARow) and 
      (GetSSCellObject(ACol, ARow).DisplayTextAlignment = dtaFILL);
    TdxReportCellSSString(ADataItem).IsFixed := IsFixedCell(ACol, ARow);
    TdxReportCellSSString(ADataItem).IsMerged := IsMergedCell(ACol, ARow);
    TdxReportCellSSString(ADataItem).IsNearMostLeft := IsNearMostLeftCell(ACol, ARow);
    TdxReportCellSSString(ADataItem).IsNearMostTop := IsNearMostTopCell(ACol, ARow);
    TdxReportCellSSString(ADataItem).RealCol := ACol;
    TdxReportCellSSString(ADataItem).RealRow := ARow;

    SetupCellBorders(ACol, ARow, ADataItem);
  end;  
end;

class function TdxPSSSStringGridCellDataMap.DataClass: TdxReportCellDataClass;
begin
  Result := TdxReportCellSSString;
end;

{ TCustomdxSpreadSheetReportLink }

constructor TCustomdxSpreadSheetReportLink.Create(AOwner: TComponent);
begin
  inherited;
  FColCount := -1;
  FRowCount := -1;  
  FCellObjects := TList.Create;
  FGridAdapter := TdxPSGridCellsAdapter.Create(nil);
  FTempFont := TFont.Create;
end;

destructor TCustomdxSpreadSheetReportLink.Destroy;
begin
  FTempFont.Free;
  FGridAdapter.Free;
  DeleteCellObjects;
  FCellObjects.Free;
  inherited;
end;  

procedure TCustomdxSpreadSheetReportLink.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TCustomdxSpreadSheetReportLink then
    with TCustomdxSpreadSheetReportLink(Source) do 
    begin
      Self.OptionsView := OptionsView;
      Self.PrintArea := PrintArea;
    end;  
end;

procedure TCustomdxSpreadSheetReportLink.ClearPrintArea;
begin
  PrintArea := dxPSEmptySSPrintArea;
end;

function TCustomdxSpreadSheetReportLink.DataProviderPresent: Boolean;
begin
  Result := inherited DataProviderPresent and DataToPrintExist;
end;

function TCustomdxSpreadSheetReportLink.DataToPrintExist: Boolean;
begin
  Result := (MeaningColCount > 0) and (MeaningRowCount > 0);
end;

function TCustomdxSpreadSheetReportLink.PrintAreaExists: Boolean; 
begin
  Result := not EqualRect(PrintArea, dxPSEmptySSPrintArea);
end;

function TCustomdxSpreadSheetReportLink.CannotActivateReportErrorString: string;
begin
  if not inherited DataProviderPresent then
    Result := inherited CannotActivateReportErrorString
  else
    Result := cxGetResourceString(@sdxDataToPrintDoesNotExist);
end;

procedure TCustomdxSpreadSheetReportLink.DoChangeComponent;
begin
  ClearPrintArea;
  inherited;
end;

procedure TCustomdxSpreadSheetReportLink.InternalRestoreDefaults;
begin
  inherited;
  EndEllipsis := False;
  Soft3D := True;
  FPrintArea := dxPSEmptySSPrintArea;
  OptionsView := [ssovRowAndColumnHeadings];
end;

procedure TCustomdxSpreadSheetReportLink.InternalRestoreFromOriginal;
begin
  inherited;
  FixedFont := ExposeSpreadSheetBook(CustomSpreadSheetBook).HeaderFont;
end;

function TCustomdxSpreadSheetReportLink.IsScaleGridLines: Boolean;
begin
  Result := False;
end;

function TCustomdxSpreadSheetReportLink.NeedTwoPassRendering: Boolean;
begin
  Result := True;
end;

function TCustomdxSpreadSheetReportLink.GetDataItemClass(ACol: Integer; ARow: Integer = 0): TdxReportCellDataClass;
begin
  Result := TdxReportCellSSString;
end;

function TCustomdxSpreadSheetReportLink.GetColCount: Integer;
var
  BeginCol, BeginRow, EndRow: Integer;
begin
  if FColCount <= 0 then
    if HasSelection then 
    begin
      GetSelectedRange(BeginCol, FColCount, BeginRow, EndRow);
      Inc(FColCount);
    end
    else
      FColCount := MeaningColCount + 1;
  Result := FColCount;
end;

function TCustomdxSpreadSheetReportLink.GetFixedColCount: Integer;
begin
  Result := 1;
end;

function TCustomdxSpreadSheetReportLink.GetFixedRowCount: Integer;
begin
  Result := 1;
end;

function TCustomdxSpreadSheetReportLink.GetRowCount: Integer;
var
  BeginCol, EndCol, BeginRow: Integer;
begin
  if FRowCount <= 0 then
    if HasSelection then 
    begin
      GetSelectedRange(BeginCol, EndCol, BeginRow, FRowCount);
      Inc(FRowCount);
    end  
    else
      FRowCount := MeaningRowCount + 1;
  Result := FRowCount;
end;

function TCustomdxSpreadSheetReportLink.GetCellSides(ACol, ARow: Integer): TdxCellSides;

  function AreNeigborhoodsTransparent(ASide: TdxCellSide): Boolean;
  begin
    case ASide of
      csLeft: 
        Result := IsNearMostLeftCell(ACol, ARow) or 
          (GetCellTransparent(ACol - 1, ARow) and GetCellTransparent(ACol, ARow));
      csTop:  
        Result := IsNearMostTopCell(ACol, ARow) or 
          (GetCellTransparent(ACol, ARow - 1) and GetCellTransparent(ACol, ARow));    
      csRight:
        Result := ((ACol = GetColCount - 1) {and not FAppendingExtraColumns}) or
          (GetCellTransparent(ACol + 1, ARow) and GetCellTransparent(ACol, ARow));          
      else // csBottom    
        Result := ((ARow = GetRowCount - 1) {and not FAppendingExtraColumns}) or
          (GetCellTransparent(ACol, ARow + 1) and GetCellTransparent(ACol, ARow)); 
    end;    
  end;
  
var
  Style: TcxSSCellStyle;
  Side: TdxCellSide;
  BorderStyle: TcxSSEdgeLineStyle;
begin
  if IsFixedCell(ACol, ARow) or IsSuppressSourceFormats then
    Result := inherited GetCellSides(ACol, ARow)
  else
  begin
    Result := csAll;
    Style := GetSSCellStyle(ACol, ARow);

    for Side := Low(TdxCellSide) to High(TdxCellSide) do
    begin
      if Style <> nil then 
        BorderStyle := Style.Borders.Edges[cxSSEdgeBorderMap[Side]].Style
      else
        BorderStyle := lsDefault;

      if (BorderStyle in [lsNone, lsDefault]) and 
        (not IsShowGridLines or not AreNeigborhoodsTransparent(Side) or
        (IsMergedCell(ACol, ARow) and not IsMergedBorder(ACol, ARow, Side))) then 
        Exclude(Result, Side);
    end;    
  end;
end;

function TCustomdxSpreadSheetReportLink.GetCellText(ACol, ARow: Integer): string;
begin
  if IsFixedCell(ACol, ARow) then
  begin
    if (ACol = 0) and (ARow <> 0) then 
      Result := TcxSSUtils.RowNameByIndex(ARow - 1, CustomSpreadSheetBook.R1C1ReferenceStyle);
    if (ARow = 0) and (ACol <> 0) then 
      Result := TcxSSUtils.ColumnNameByIndex(ACol - 1, CustomSpreadSheetBook.R1C1ReferenceStyle);
  end    
  else  
    if (FProcessingMerges or not IsMergedCell(ACol, ARow)) and not FAppendingExtraColumns then 
      Result := GetSSCellObject(ACol, ARow).DisplayText
    else
      Result := '';
end;

function TCustomdxSpreadSheetReportLink.GetCellTextAlignY(ACol, ARow: Integer): TcxTextAlignY;
begin
  if (DrawMode <> gdmBorrowSource) and not IsFixedCell(ACol, ARow) then 
    Result := taBottom
  else
    Result := inherited GetCellTextAlignY(ACol, ARow);
end;

function TCustomdxSpreadSheetReportLink.GetMinRowHeight(DC: HDC; AFont: TFont): Integer;
begin
  Result := 1;
end;

function TCustomdxSpreadSheetReportLink.GetSelectionRect: TRect;
begin
  if OnlySelected then 
    Result := ExposeBookSheet(BookSheet).SelectionRect
  else
    Result := PrintArea;
  OffsetRect(Result, 1, 1);
end;

function TCustomdxSpreadSheetReportLink.GetSourceCellColor(ACol, ARow: Integer): TColor;
begin
  if IsFixedCell(ACol, ARow) then 
    Result := ColorToRGB(ExposeSpreadSheetBook(CustomSpreadSheetBook).HeaderColor)
  else  
    if GetSourceCellContentPattern(ACol, ARow).InheritsFrom(TdxPSSolidFillPattern) then 
      Result := GetRealColor(GetSSCellStyle(ACol, ARow).Brush.BackgroundColor, clWindow)
    else  
      Result := GetRealColor(GetSSCellStyle(ACol, ARow).Brush.ForegroundColor, clWindow);
end;

function TCustomdxSpreadSheetReportLink.GetSourceCellContentBkColor(ACol, ARow: Integer): TColor;
begin
  if IsFixedCell(ACol, ARow) then 
    Result := ColorToRGB(ExposeSpreadSheetBook(CustomSpreadSheetBook).HeaderColor)
  else  
    Result := GetRealColor(GetSSCellStyle(ACol, ARow).Brush.BackgroundColor, clWindow);
end;

function TCustomdxSpreadSheetReportLink.GetSourceCellContentPattern(ACol, ARow: Integer): TdxPSFillPatternClass;
begin
  if IsFixedCell(ACol, ARow) then
    Result := TdxPSSolidFillPattern
  else
    Result := dxPSFillPatternClassMap[GetSSCellStyle(ACol, ARow).Brush.Style];
end;

function TCustomdxSpreadSheetReportLink.GetSourceCellEdge3DSoft(ACol, ARow: Integer): Boolean;
begin
  Result := True;
end;
 
function TCustomdxSpreadSheetReportLink.GetSourceCellEdgeMode(ACol, ARow: Integer): TdxCellEdgeMode;
const
  FixedEdgeModes: array[Boolean] of TdxCellEdgeMode = (cem3DEffects, cemPattern); 
begin
  if IsFixedCell(ACol, ARow) then
    Result := FixedEdgeModes[ExposeSpreadSheetBook(CustomSpreadSheetBook).PainterType = ptOfficeXPStyle]
  else
    Result := cemPattern;
end;

function TCustomdxSpreadSheetReportLink.GetSourceCellFontIndex(ACol, ARow: Integer): Integer;

  procedure SetupFont(AFontRec: PcxSSFontRec; AFont: TFont);
  begin
    with AFont do
    begin
      Name := AFontRec.Name;
      Color := GetRealColor(AFontRec.FontColor, Self.Font.Color);
      Style := AFontRec.Style;
      Charset := AFontRec.Charset;
      Size := AFontRec.Size;
    end;  
    
    if not dxIsTrueTypeFont(AFont) then AFont.Name := Self.Font.Name;      
  end;

begin
  if not IsFixedCell(ACol, ARow) then 
  begin
    SetupFont(ExposeStyle(GetSSCellStyle(ACol, ARow)).StylePtr^.FontPtr, FTempFont);
    Result := AddFontToPool(FTempFont);
  end
  else
    Result := FSourceHeaderFontIndex;
end;

function TCustomdxSpreadSheetReportLink.GetSourceCellMultiline(ACol, ARow: Integer): Boolean;
begin
  Result := not IsFixedCell(ACol, ARow) and GetSSCellStyle(ACol, ARow).WordBreak;
end;

function TCustomdxSpreadSheetReportLink.GetSourceCellTextAlignX(ACol, ARow: Integer): TcxTextAlignX;
begin
  if IsFixedCell(ACol, ARow) then
    Result := taCenterX
  else
    Result := dxPSTextAlignXMap[GetSSCellObject(ACol, ARow).DisplayTextAlignment];
end;

function TCustomdxSpreadSheetReportLink.GetSourceCellTextAlignY(ACol, ARow: Integer): TcxTextAlignY;
begin
  if IsFixedCell(ACol, ARow) then
    Result := taBottom
  else
    Result := dxPSTextAlignYMap[GetSSCellStyle(ACol, ARow).VertTextAlign];
end;

function TCustomdxSpreadSheetReportLink.GetSourceCellTransparent(ACol, ARow: Integer): Boolean;
begin
  if not IsFixedCell(ACol, ARow) then
  begin
    Result := inherited GetSourceCellTransparent(ACol, ARow);
    if Result then 
      Result := (GetSSCellStyle(ACol, ARow).Brush.Style = fsSolid) and (GetSourceCellColor(ACol, ARow) = ColorToRGB(clWindow));
  end
  else
    Result := FixedTransparent;
end;

function TCustomdxSpreadSheetReportLink.GetSourceColWidth(ACol: Integer): Integer;
begin
  with ExposeSpreadSheetBook(CustomSpreadSheetBook) do
    if IsFixedCol(ACol) then
      Result := RowHeaderWidth
    else
      Result := ActiveSheet.Cols.Size[ACol - 1];
  Result := MulDiv(Result, Screen.PixelsPerInch, 96);
end;

function TCustomdxSpreadSheetReportLink.GetSourceRowHeight(ARow: Integer): Integer;
begin
  with ExposeSpreadSheetBook(CustomSpreadSheetBook) do
    if IsFixedRow(ARow) then
      Result := ColHeaderHeight
    else
    begin
      Result := ActiveSheet.Rows.Size[ARow - 1];
      Result := MulDiv(Result, 96, Screen.PixelsPerInch);
    end;
  if Result > 3 then Inc(Result, 3);
  Result := MulDiv(Result, Screen.PixelsPerInch, 96);
end;

function TCustomdxSpreadSheetReportLink.HasSelection: Boolean;
begin
  Result := inherited HasSelection or PrintAreaExists;
end;

function TCustomdxSpreadSheetReportLink.IsDrawBorder: Boolean;
begin
  Result := True;//ssovGridLines in OptionsView;
end;

function TCustomdxSpreadSheetReportLink.IsDrawHorzLines: Boolean;
begin
  Result := ssovGridLines in OptionsView;
end;

function TCustomdxSpreadSheetReportLink.IsDrawVertLines: Boolean;
begin
  Result := ssovGridLines in OptionsView;
end;

function TCustomdxSpreadSheetReportLink.IsProcessedCol(ACol: Integer): Boolean;
begin
  Result := inherited IsProcessedCol(ACol);
  if Result then 
    if IsFixedCol(ACol) then 
      Result := IsShowRowAndColumnHeadings
    else
      Result := ExposeSpreadSheetBook(CustomSpreadSheetBook).ActiveSheet.Cols.Visible[ACol - 1];
end;

function TCustomdxSpreadSheetReportLink.IsProcessedRow(ARow: Integer): Boolean;
begin
  Result := inherited IsProcessedRow(ARow);
  if Result then 
    if IsFixedRow(ARow) then 
      Result := IsShowRowAndColumnHeadings
    else
      with ExposeSpreadSheetBook(CustomSpreadSheetBook) do      
        Result := ActiveSheet.Rows.Visible[ARow - 1];
end;

procedure TCustomdxSpreadSheetReportLink.AfterConstruct(AReportCells: TdxReportCells);
begin
  FColCount := -1;
  FRowCount := -1;
  FGridAdapter.FReportCells := nil;
  DeleteCellObjects;  
  inherited;
end;

procedure TCustomdxSpreadSheetReportLink.PrepareConstruct(AReportCells: TdxReportCells);
begin
  FExtraColumnCount := 0;
  FCellObjects.Count := ColCount * RowCount - 1;
  FGridAdapter.FReportCells := AReportCells;
  FSourceHeaderFontIndex := AddFontToPool(ExposeSpreadSheetBook(CustomSpreadSheetBook).HeaderFont);
  inherited;
end;

procedure TCustomdxSpreadSheetReportLink.UnprepareConstruct(AReportCells: TdxReportCells);
begin
  if not AbortBuilding then
  begin
    if HasMerges then AddMerges(AReportCells);
    CalcTextExtents(FGridAdapter);
    if not HasSelection then   
      AppendAdditionalColumns(FGridAdapter);
    DeleteUnneededCellSides(FGridAdapter);
    PostProcessItems(FGridAdapter);
    FixupRowWidths(FGridAdapter);
  end;
  inherited;
end;

procedure TCustomdxSpreadSheetReportLink.AddMerges(AReportCells: TdxReportCells);

  function IntersectRect(R1, R2: TRect): Boolean;
  begin
    Inc(R1.Right);
    Inc(R1.Bottom);
    Inc(R2.Right);
    Inc(R2.Bottom);
    Result := Windows.IntersectRect(R1, R1, R2);
  end;

var
  SelRect, R: TRect;
  LeftOffset, TopOffset, I, ACol, ARow: Integer;
  Overlay, Cell: TdxReportCell;
  DataClass: TdxReportCellDataClass;
  DataItem: TAbstractdxReportCellData;
begin
  FProcessingMerges := True;
  try
    SelRect := Rect(0, 0, 0, 0);
    LeftOffset := 0;
    TopOffset := 0;
    
    if HasSelection then    
    begin
      SelRect := GetSelectionRect;
      LeftOffset := GetColumnOffset(SelRect.Left);
      TopOffset := GetRowOffset(SelRect.Top);
      if IsShowRowAndColumnHeadings then 
      begin
        Dec(LeftOffset, ColumnWidths[0]);
        if not HeadersOnEveryPage then Dec(TopOffset, RowHeights[0]);
      end;
    end
    else
      if not IsShowRowAndColumnHeadings then 
      begin
        Inc(LeftOffset, ColumnWidths[0]);
        Inc(TopOffset, RowHeights[0]);
      end  
      else
        if HeadersOnEveryPage then Inc(TopOffset, RowHeights[0]);

    Overlay := AReportCells.AddOverlay;
    
    for I := 0 to MergedCells.Count - 1 do 
    begin
      R := MergedCells.MergedAsRect[I];
      OffsetRect(R, 1, 1);

      if HasSelection and not IntersectRect(R, SelRect) then 
        Continue;
          
      ACol := R.Left;
      ARow := R.Top; 
        
      R.Left := GetColumnOffset(R.Left);
      R.Top := GetRowOffset(R.Top);
      R.Right := GetColumnOffset(R.Right + 1); 
      R.Bottom := GetRowOffset(R.Bottom + 1);         

      OffsetRect(R, -LeftOffset, -TopOffset);
      
      Cell := TdxReportCell.Create(Overlay);
      Cell.BoundsRect := R;
      Cell.Transparent := True;
      Cell.CellSides := [];
      
      DataClass := GetDataItemClass(ACol);
      if DataClass <> nil then
      begin
        DataItem := DataClass.Create(Cell);
        OffsetRect(R, -R.Left, -R.Top);
        DataItem.BoundsRect := R;
        AssignData(ACol, ARow, DataItem);
        DataItem.CellSides := [];
        //DataItem.Transparent := False;//True;
      end;
    end;  
  finally
    FProcessingMerges := False;
  end;    
end;

procedure TCustomdxSpreadSheetReportLink.CheckPrintAreaBounds(var R: TRect);
begin
  if not EqualRect(R, dxPSEmptySSPrintArea) then 
    with R do 
    begin
      if Left < 0 then Left :=0;
      if Top < 0 then Top := 0;  
      if Right < Left then Right := Left;
      if Bottom < Top then Bottom := Top;
    end;  
end;

function TCustomdxSpreadSheetReportLink.GetColumnOffset(ACol: Integer): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to ACol - 1 do 
    Inc(Result, ColumnWidths[I]);
end;

function TCustomdxSpreadSheetReportLink.GetRowOffset(ARow: Integer): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to ARow - 1 do 
    Inc(Result, RowHeights[I]);
end;

function TCustomdxSpreadSheetReportLink.IsMergedBorder(ACol, ARow: Integer; 
  ASide: TdxCellSide): Boolean;
  
  function CellInRect(const R: TRect; X, Y: Integer): Boolean;
  begin
    Result := (X >= R.Left) and (X <= R.Right) and (Y >= R.Top) and (Y <= R.Bottom);
  end;
  
var
  I: Integer;
  R: TRect;
begin
  Result := IsMergedCell(ACol, ARow);
  if Result then 
    for I := 0 to MergedCells.Count - 1 do 
    begin
      R := MergedCells.MergedAsRect[I];
      OffsetRect(R, 1, 1);
      if CellInRect(R, ACol, ARow) then 
      begin
        case ASide of 
          csLeft:
            Result := ACol = R.Left;
          csTop:
            Result := ARow = R.Top;
          csRight:
            Result := ACol = R.Right;
          csBottom:
            Result := ARow = R.Bottom;
        end;
        if Result then Exit;
      end;  
      //Result := (ACol = R.Left) or (ACol = R.Right) or (ARow = R.Top) or (ARow = R.Bottom);
    end;
end;

function TCustomdxSpreadSheetReportLink.IsMergedCell(ACol, ARow: Integer): Boolean;
begin
  Result := not IsFixedCell(ACol, ARow) and ExposeStyle(GetSSCellStyle(ACol, ARow)).Merge;
end;

function TCustomdxSpreadSheetReportLink.IsNearMostLeftCell(ACol, ARow: Integer): Boolean;
var
  R: TRect;
begin
  if IsShowRowAndColumnHeadings then 
  begin
    if HasSelection then 
    begin
      R := GetSelectionRect;
      Dec(R.Left);
      Dec(ACol, R.Left);
    end;
    Result := ACol = 1
  end
  else
    Result := False;//ACol = 0;
end;

function TCustomdxSpreadSheetReportLink.IsNearMostTopCell(ACol, ARow: Integer): Boolean;
var
  R: TRect;
begin
  if IsShowRowAndColumnHeadings then 
  begin
    if HasSelection then 
    begin
      R := GetSelectionRect;
      Dec(R.Top);
      Dec(ARow, R.Top);
    end;
    Result := ARow = 1
  end  
  else
    Result := False;//ARow = 0;
end;

function TCustomdxSpreadSheetReportLink.IsShowGridLines: Boolean;
begin
  Result := ssovGridLines in OptionsView;
end;

function TCustomdxSpreadSheetReportLink.IsShowRowAndColumnHeadings: Boolean;  
begin
  Result := ssovRowAndColumnHeadings in OptionsView;
end;

function TCustomdxSpreadSheetReportLink.IsSuppressSourceFormats: Boolean;  
begin
  Result := ssovSuppressSourceFormats in OptionsView;
end;

procedure TCustomdxSpreadSheetReportLink.AppendAdditionalColumns(AnAdapter: TdxPSGridCellsAdapter);

  function DoCalcExtraColumnCount(AnAdapter: TdxPSGridCellsAdapter; 
    ADefaultColumnWidth: Integer): Integer;
  var
    Col, Row, Index, CurrentColumnOffset: Integer;
    Item: TdxReportCellSSString;
  begin
    Result := AnAdapter.ColCount;

    for Row := 0 to AnAdapter.RowCount - 1 do 
      for Col := 0 to AnAdapter.ColCount - 1 do 
      begin
        Item := AnAdapter[Col, Row];
        if Item.TextExtentRight <> 0 then 
        begin
          Index := Col;
          CurrentColumnOffset := AnAdapter.ColOffsets[Index];
          while Item.TextExtentRight > CurrentColumnOffset do  
          begin
            Inc(Index);
            if Index <= AnAdapter.ColCount then 
              CurrentColumnOffset := AnAdapter.ColOffsets[Index]
            else
              Inc(CurrentColumnOffset, ADefaultColumnWidth);
          end;
          if Index > Result then Result := Index;
        end;
      end;  
    Dec(Result, AnAdapter.ColCount);
  end;

  function FindNearestVisibleColIndex(AStartIndex: Integer): Integer;
  begin
    Result := AStartIndex;
    with ExposeSpreadSheetBook(CustomSpreadSheetBook).ActiveSheet.Cols do
      while not Visible[Result - 1] do 
        Inc(Result);
  end;
  
  procedure DoAppendExtraColumns(AnAdapter: TdxPSGridCellsAdapter; 
    AExtraColumnCount, ADefaultColumnWidth: Integer);
  var
    L, Row, Col, StartRealCol, RealCol: Integer;
    Item: TdxReportCellSSString;
    Cell: TdxReportCell;
    R: TRect;
  begin
    L := AnAdapter.ColOffsets[AnAdapter.ColCount];
    StartRealCol := AnAdapter.Cells[AnAdapter.ColCount - 1, 0].RealCol;
    
    for Row := 0 to AnAdapter.RowCount - 1 do
    begin
      Item := nil;
      Cell := AnAdapter.Rows[Row];
      R := Bounds(L, 0, 0, Cell.Height);
      RealCol := StartRealCol;
      for Col := 0 to AExtraColumnCount - 1 do
      begin
        R.Left := R.Right;
        R.Right := R.Left + ADefaultColumnWidth;
          
        Item := TdxReportCellSSString.Create(Cell);
        Item.BoundsRect := R;
        Item.IsVirtual := True;
        
        RealCol := FindNearestVisibleColIndex(RealCol + 1);
        AssignData(RealCol, AnAdapter.RowIndexes[Row], Item);
        if Item.IsFixed then 
          Item.Text := TcxSSUtils.ColumnNameByIndex(RealCol - 1, CustomSpreadSheetBook.R1C1ReferenceStyle);
      end;
      Cell.Width := Item.BoundsRect.Right;
    end;
  end;

var
  DefaultColumnWidth: Integer;
begin
  FAppendingExtraColumns := True;
  try
    DefaultColumnWidth := ExposeSpreadSheetBook(CustomSpreadSheetBook).DefaultColWidth;
    FExtraColumnCount := DoCalcExtraColumnCount(FGridAdapter, DefaultColumnWidth);
    if ExtraColumnCount <> 0 then 
      DoAppendExtraColumns(FGridAdapter, ExtraColumnCount, DefaultColumnWidth);
  finally
    FAppendingExtraColumns := False;
  end;    
end;

procedure TCustomdxSpreadSheetReportLink.PostProcessItems(AnAdapter: TdxPSGridCellsAdapter);
var
  Col, Row: Integer;
begin
  for Col := 0 to AnAdapter.ColCount - 1 do
    for Row := 0 to AnAdapter.RowCount - 1 do
      with AnAdapter.Cells[Col, Row] do 
        if not IsFixed and not IsVirtual then 
        begin
          CalcBorderSubs(AnAdapter);
          CalcDoubleBorderSlants(AnAdapter);
        end;  
end;

procedure TCustomdxSpreadSheetReportLink.CalcTextExtents(AnAdapter: TdxPSGridCellsAdapter);

  function NeedCalcItemTextExtents(AItem: TdxReportCellSSString): Boolean;
  begin
    with AItem do
      Result := not IsMerged and not IsFixed and not Multiline and not Fill and 
        (Text <> '') and (TextAlignX in [taLeft, taCenterX, taRight]);
  end;

  procedure DoCalcItemTextExtents(AItem: TdxReportCellSSString; Col, Row: Integer);

    function CalcTextRightExtent(ATextWidth, ACol, ARow: Integer): Integer;
    var
      OriginalColumnOffset, CurrentColumnOffset, EndOfTextOffset, I: Integer;  
      Item: TdxReportCellSSString;
    begin
      OriginalColumnOffset := AnAdapter.ColOffsets[ACol];
      EndOfTextOffset := OriginalColumnOffset + ATextWidth;      
      Result := 0;
    
      CurrentColumnOffset := AnAdapter.ColOffsets[ACol + 1];
      
      for I := ACol + 1 to AnAdapter.ColCount do 
      begin
        CurrentColumnOffset := AnAdapter.ColOffsets[I];
        if CurrentColumnOffset > EndOfTextOffset then       
          Break;
          
        if I < AnAdapter.ColCount then 
          Item := AnAdapter[I, ARow]
        else
          Item := nil;  
          
        if (Item <> nil) and (Item.IsMerged or (Item.Text <> '')) then 
        begin
          Result := CurrentColumnOffset;
          Break;
        end  
      end;
      
      if Result = 0 then 
      begin
        Result := EndOfTextOffset;
        if (Result > CurrentColumnOffset) and HasSelection then        
          Result := CurrentColumnOffset + dxTextSpace;
        if Result < AnAdapter.ColOffsets[ACol + 1] then Result := 0;
      end;  
    end;

    function CalcTextLeftExtent(ATextWidth, ACol, ARow: Integer): Integer;
    var
      TextLeftEdge, I, CurrentColumnOffset: Integer;
      Item: TdxReportCellSSString;
    begin
      TextLeftEdge := AnAdapter.ColOffsets[ACol + 1] - ATextWidth;
      if TextLeftEdge < 0 then TextLeftEdge := 0;
      
      Result := 0;

      for I := ACol downto 0 do
      begin
        if I > 0 then 
          Item := AnAdapter[I - 1, ARow]
        else
          Item := nil;
        CurrentColumnOffset := AnAdapter.ColOffsets[I];
        if CurrentColumnOffset < TextLeftEdge then       
          Break;
        if (Item = nil) or Item.IsFixed or Item.IsMerged or (Item.Text <> '') then 
        begin
          Result := CurrentColumnOffset;
          Break;
        end  
      end; 
      
      if Result = 0 then 
      begin 
        Result := TextLeftEdge;
        if Result > AnAdapter.ColOffsets[ACol] then Result := 0;
      end;  
    end;

  var
    TextWidth: Integer;
  begin
    TextWidth := GetTextWidth(ScreenDC, AItem.Font.Handle, AItem.Text);    
  
    case AItem.TextAlignX of
      taLeft:
        AItem.TextExtentRight := CalcTextRightExtent(TextWidth + 3 * dxTextSpace, Col, Row);
      taCenterX:
        begin
          Dec(TextWidth, (TextWidth - AItem.Width) div 2);
          AItem.TextExtentRight := CalcTextRightExtent(TextWidth + 1 * dxTextSpace, Col, Row);
          AItem.TextExtentLeft := CalcTextLeftExtent(TextWidth + 1 * dxTextSpace, Col, Row);
        end;  
      taRight:                          
        AItem.TextExtentLeft := CalcTextLeftExtent(TextWidth + 3 * dxTextSpace, Col, Row);
    end;               
  end;
  
var
  Font: HFONT;
  Col, Row: Integer;
  Item: TdxReportCellSSString;
begin 
  Font := GetCurrentObject(ScreenDC, OBJ_FONT);
  for Col := 0 to AnAdapter.ColCount - 1 do
    for Row := 0 to AnAdapter.RowCount - 1 do
    begin
      Item := AnAdapter[Col, Row];
      if NeedCalcItemTextExtents(Item) then DoCalcItemTextExtents(Item, Col, Row);
    end;  
  SelectObject(ScreenDC, Font);
end;

procedure TCustomdxSpreadSheetReportLink.DeleteCellObjects;
var
  I: Integer;
begin                  
  for I := 0 to FCellObjects.Count - 1 do 
    TObject(FCellObjects[I]).Free;
  FCellObjects.Clear;
end;
      
procedure TCustomdxSpreadSheetReportLink.DeleteUnneededCellSides(AnAdapter: TdxPSGridCellsAdapter);
  
  procedure DoDeleteUnneededCellSidesFromRightSide(AItem: TdxReportCellSSString; ACol: Integer);
  var
    TextRightExtent, Col, CurrentColumnOffset: Integer;
  begin
    TextRightExtent := AItem.TextExtentRight;
    for Col := ACol + 1 to AnAdapter.ColCount - 1 do
    begin
      CurrentColumnOffset := AnAdapter.ColOffsets[Col];
      if CurrentColumnOffset < TextRightExtent then 
      begin
        AItem.CellSides := AItem.CellSides - [csRight];
        AItem := TdxReportCellSSString(AItem.GetNextSibling);
        if AItem = nil then
          Break;
        AItem.CellSides := AItem.CellSides - [csLeft];
      end;  
    end;
  end;

  procedure DoDeleteUnneededCellSidesFromLeftSide(AItem: TdxReportCellSSString; ACol: Integer);
  var
    TextLeftExtent, Col, CurrentColumnOffset: Integer;
  begin
    TextLeftExtent := AItem.TextExtentLeft;
    for Col := ACol downto 0 do
    begin
      CurrentColumnOffset := AnAdapter.ColOffsets[Col];
      if CurrentColumnOffset > TextLeftExtent then 
      begin
        AItem.CellSides := AItem.CellSides - [csLeft];
        AItem := TdxReportCellSSString(AItem.GetPrevSibling);
        if (AItem = nil) or AItem.IsFixed then 
          Break;
        AItem.CellSides := AItem.CellSides - [csRight];
      end;  
    end;
  end;

var
  Col, Row: Integer;
  Item: TdxReportCellSSString;
begin
  for Row := 0 to AnAdapter.RowCount - 1 do
    for Col := 0 to AnAdapter.ColCount - 1 do
    begin
      Item := AnAdapter[Col, Row];
      if Item.TextExtentRight <> 0 then 
        DoDeleteUnneededCellSidesFromRightSide(Item, Col);
      if Item.TextExtentLeft <> 0 then 
        DoDeleteUnneededCellSidesFromLeftSide(Item, Col);
    end;
end;

procedure TCustomdxSpreadSheetReportLink.FixupRowWidths(AnAdapter: TdxPSGridCellsAdapter);
var
  MaxWidth, I: Integer;
begin
  with AnAdapter do 
  begin
    MaxWidth := 0;
    for I := 0 to ColCount - 1 do 
      Inc(MaxWidth, ColWidths[I]);
      
    for I := 0 to RowCount - 1 do 
      Rows[I].Width := MaxWidth;
  end;  
end;

function TCustomdxSpreadSheetReportLink.HasMerges: Boolean;
begin
  Result := MergedCells.Count <> 0;
end;

function TCustomdxSpreadSheetReportLink.IsEmptyCell(const ACell: TcxSSCellRec): Boolean;
var
  DefaultStyle: TcxSSCellStyleRec;
begin
  DefaultStyle := ExposeDataStorage(GetSSDataStorage).DefaultCellRec.StylePtr^;
  Result := IsCellDataEmpty(ACell) and AreStylesEqual(DefaultStyle, ACell.StylePtr^);    
end;

function TCustomdxSpreadSheetReportLink.OnlyEdgeIsAssigned(const ACell: TcxSSCellRec; 
  AEdge: TcxSSEdgeBorder): Boolean;
var
  DefaultStyle: TcxSSCellStyleRec;
begin
  DefaultStyle := ExposeDataStorage(GetSSDataStorage).DefaultCellRec.StylePtr^;
  Result := IsCellDataEmpty(ACell) and AreStylesEqual(DefaultStyle, ACell.StylePtr^, [AEdge]);
end;

function TCustomdxSpreadSheetReportLink.OnlyLeftEdgeIsAssigned(ACell: TcxSSCellRec): Boolean;
begin
  Result := OnlyEdgeIsAssigned(ACell, eLeft);
end;

function TCustomdxSpreadSheetReportLink.OnlyTopEdgeIsAssigned(ACell: TcxSSCellRec): Boolean;
begin
  Result := OnlyEdgeIsAssigned(ACell, eTop);
end;

procedure TCustomdxSpreadSheetReportLink.SetupCellBorders(ACol, ARow: Integer;
  ADataItem: TAbstractdxReportCellData);
var
  DefaultAutoColor, DefaultColor: TColor;
  Style: TcxSSCellStyle;
  Side: TdxCellSide;
  Border: TdxPSCellBorder;
begin
  if not IsFixedCell(ACol, ARow) then 
  begin
    DefaultAutoColor := ColorToRGB(clWindowText);
    DefaultColor := ColorToRGB(ExposeSpreadSheetBook(CustomSpreadSheetBook).GridColor);
        
    if IsSuppressSourceFormats then
      Style := nil
    else  
      Style := GetSSCellStyle(ACol, ARow);

    for Side := csLeft to csBottom do
      if Side in ADataItem.CellSides then
      begin
        if Style <> nil then
        begin
          with Style.Borders.Edges[cxSSEdgeBorderMap[Side]] do 
          begin
            Border.Pattern := dxPSEdgePatternClassMap[Style];
            if Style = lsDefault then 
              Border.Color := GetRealColor(Color, DefaultColor)
            else  
              Border.Color := GetRealColor(Color, DefaultAutoColor);            
          end;
          if IsSSDefaultStyle(Style) then 
            Border.Color := GetRealColor(GetSSDefaultCellSideColor(Side), DefaultColor);
        end
        else
          if not IsMergedCell(ACol, ARow) then 
          begin
            Border.Color := GetRealColor(GetSSDefaultCellSideColor(Side), ColorToRGB(GridLineColor));
            Border.Pattern := TdxPSSolidEdgePattern; 
          end
          else
            Border.Pattern := nil;

        TdxReportCellSSString(ADataItem).Borders[Side] := Border;
      end;
  end
end;
 
function TCustomdxSpreadSheetReportLink.GetBookSheet: TcxSSBookSheet;
begin
  if CustomSpreadSheetBook = nil then 
    Result := nil
  else
    Result := ExposeSpreadSheetBook(CustomSpreadSheetBook).ActiveSheet;
end;

function TCustomdxSpreadSheetReportLink.GetCustomSpreadSheetBook: TcxCustomSpreadSheetBook;
begin
  Result := TcxCustomSpreadSheetBook(Component);
end;

function TCustomdxSpreadSheetReportLink.GetMeaningColCount: Integer;
var
  Storage: TcxSSDataStorageAccess;
  Col, Row, CandidateCol: Integer;
  Cell: TcxSSCellRec;
  R: TRect;
begin
  Result := -1;
  CandidateCol := 0;
  Storage := ExposeDataStorage(GetSSDataStorage);
  for Row := 0 to Storage.Capacity.cY - 1 do 
  begin
    for Col := Storage.Capacity.cX - 1 downto 0 do
    begin
      Cell := Storage.Cells[Col, Row];
      if not IsEmptyCell(Cell) then 
      begin
        CandidateCol := Col;
        if (CandidateCol > 0) and OnlyLeftEdgeIsAssigned(Cell) then Dec(CandidateCol);
        Break;
      end;
    end;
    if CandidateCol > Result then Result := CandidateCol;
  end;  

  for Col := 0 to MergedCells.Count - 1 do 
  begin
    R := Storage.MergedCells.MergedAsRect[Col];
    if R.Right > Result then Result := R.Right;
  end;
  
  if Result > -1 then Inc(Result);
end;

function TCustomdxSpreadSheetReportLink.GetMeaningRowCount: Integer;    
var
  Storage: TcxSSDataStorageAccess;
  CandidateRow, Col, Row: Integer;
  Cell: TcxSSCellRec;
  IsBreaked: Boolean;
  R: TRect;
begin
  Storage := ExposeDataStorage(GetSSDataStorage);
  CandidateRow := -1;
  
  for Row := Storage.Capacity.cY - 1 downto 0 do 
  begin
    IsBreaked := False;
    for Col := 0 to Storage.Capacity.cX - 1 do
    begin
      Cell := Storage.Cells[Col, Row];
      if not IsEmptyCell(Cell) then 
      begin
        CandidateRow := Row;
        if (CandidateRow = 0) or not OnlyTopEdgeIsAssigned(Cell) then 
        begin
          IsBreaked := True;
          Break;
        end;
      end;
    end;
    if CandidateRow <> -1 then 
    begin 
      if not IsBreaked then Dec(CandidateRow);
      Break;
    end;  
  end;  
  Result := CandidateRow;
  
  for Col := 0 to Storage.MergedCells.Count - 1 do 
  begin
    R := Storage.MergedCells.MergedAsRect[Col];
    if R.Bottom > Result then Result := R.Bottom;
  end;
  Result := Min(Result, Storage.MaxRow + 1);
  if Result > -1 then Inc(Result);
end;

function TCustomdxSpreadSheetReportLink.GetMergedCells: TcxSSMergedCellsStorage;
begin
  Result := ExposeDataStorage(ExposeBookSheet(BookSheet).DataStorage).MergedCells;
end;

procedure TCustomdxSpreadSheetReportLink.SetOptionsView(Value: TdxPSSpreadSheetReportLinkOptionsView);
begin
  if FOptionsView <> Value then
  begin
    FOptionsView := Value;
    if ssovSuppressSourceFormats in FOptionsView then 
      DrawMode := gdmStrict
    else  
      DrawMode := gdmBorrowSource;
    LinkModified(True);
  end;
end;

procedure TCustomdxSpreadSheetReportLink.SetPrintArea(Value: TRect);
begin
  CheckPrintAreaBounds(Value);
  if not EqualRect(Value, FPrintArea) then
  begin
    FPrintArea := Value;
    LinkModified(True);
  end;                             
end;

function TCustomdxSpreadSheetReportLink.GetSSCellObject(ACol, ARow: Integer): TcxSSCellObject;
var
  Index: Integer;
begin
  Index := GetFlatIndex(ACol - 1, ARow - 1);
  if Index > FCellObjects.Count - 1 then // ExtraColumns
    Result := nil
  else
    Result := FCellObjects.List^[Index];
    
  if Result = nil then
  begin                                                     
    Result := ExposeActiveSpreadSheet(CustomSpreadSheetBook).GetCellObject(ACol - 1, ARow - 1);
    if Index > FCellObjects.Count - 1 then 
      FCellObjects.Count := Index + 1;
    FCellObjects.List^[Index] := Result;
  end;
end;

function TCustomdxSpreadSheetReportLink.GetSSCellStyle(ACol, ARow: Integer): TcxSSCellStyle;
var
  CellObject: TcxSSCellObject;
begin
  if not FAppendingExtraColumns then
  begin
    CellObject := GetSSCellObject(ACol, ARow);
    if (CellObject <> nil) and CellObject.StyleExist then 
      Result := CellObject.Style
    else
      Result := GetSSDefaultStyle;
  end    
  else
    Result := GetSSDefaultStyle;
end;

function TCustomdxSpreadSheetReportLink.GetSSColorPalette: PcxExcelPalette;
begin
  Result := ExposeSpreadSheetBook(CustomSpreadSheetBook).Palette;
end;

function TCustomdxSpreadSheetReportLink.GetSSDataStorage: TcxSSDataStorage;
begin
  Result := ExposeBookSheet(BookSheet).DataStorage;
end;

function TCustomdxSpreadSheetReportLink.GetSSDefaultCellSideColor(ASide: TdxCellSide): TColor;
begin
  with ExposeSpreadSheetBook(CustomSpreadSheetBook), DefaultStyle.Borders do 
    if ASide in csLeftRight then
      if VerticalBorders.Style <> lsDefault then
        Result := VerticalBorders.Color
      else
        Result := ColorToRGB(GridColor)
    else
      if HorizontalBorders.Style <> lsDefault then
        Result := HorizontalBorders.Color
      else
        Result := ColorToRGB(GridColor);
end;

function TCustomdxSpreadSheetReportLink.GetSSDefaultStyle: TcxSSCellStyle;
begin
  Result := ExposeSpreadSheetBook(CustomSpreadSheetBook).StyleCache.DefaultStyle;
end;
  
function TCustomdxSpreadSheetReportLink.GetFlatIndex(ACol, ARow: Integer): Integer;
begin
  Result := ARow * (ColCount - 1) + ACol;
end;

function TCustomdxSpreadSheetReportLink.GetRealColor(AColorIndex: Integer; ADefaultColor: TColor): TColor;
begin
  if AColorIndex > SystemColorStart then
    Result := ADefaultColor
  else
    Result := GetSSColorPalette^[AColorIndex];
  Result := ColorToRGB(Result);
end;

function TCustomdxSpreadSheetReportLink.IsSSDefaultStyle(AStyle: TcxSSCellStyle): Boolean;
begin
  Result := AStyle = GetSSDefaultStyle;
end;

{ TdxSpreadSheetBookReportLink }

function TdxSpreadSheetBookReportLink.GetSpreadSheetBook: TcxSpreadSheetBook;
begin
  Result := TcxSpreadSheetBook(Component);
end;

{ TdxSpreadSheetReportLink }

function TdxSpreadSheetReportLink.GetSpreadSheet: TcxSpreadSheet;
begin
  Result := TcxSpreadSheet(Component);
end;

{ TfmdxSpreadSheetDesignWindow }

constructor TfmdxSpreadSheetDesignWindow.Create(AOwner: TComponent);
begin
  HelpContext := dxhccxSpreadSheetReportLinkDesigner;
  inherited;
  CreateControls;
  pgctrlMain.ActivePage := pgctrlMain.Pages[0];
end;

procedure TfmdxSpreadSheetDesignWindow.DoInitialize;
begin
  inherited;
  chbxShowRowAndColumnHeadings.Checked := ssovRowAndColumnHeadings in ReportLink.OptionsView;
  chbxShowGridLines.Checked := ssovGridLines in ReportLink.OptionsView;

//  chbxAutoWidth.Checked := ReportLink.AutoWidth;
  chbxRowAutoHeight.Checked := ReportLink.RowAutoHeight;
  chbxSuppressSourceFormats.Checked := ssovSuppressSourceFormats in ReportLink.OptionsView;
  
  chbxTransparent.Checked := ReportLink.Transparent;
  TdxPSColorCombo(FccbxColor).ColorValue := ReportLink.Color;
  chbxFixedTransparent.Checked := ReportLink.FixedTransparent;
  TdxPSColorCombo(FccbxFixedColor).ColorValue := ReportLink.FixedColor;
  TdxPSColorCombo(FccbxGridLineColor).ColorValue := ReportLink.GridLineColor;

  FontInfoToText(ReportLink.Font, edFont);
  FontInfoToText(ReportLink.FixedFont, edFixedFont);          
  
  chbxFixedRowsOnEveryPage.Checked := ReportLink.HeadersOnEveryPage;
  chbxOnlySelected.Checked := ReportLink.OnlySelected;
end;

{$IFDEF DELPHI7}
function TfmdxSpreadSheetDesignWindow.GetPreviewHost: TCustomPanel;
begin
  Result := pnlPreview;
end;
{$ENDIF}

procedure TfmdxSpreadSheetDesignWindow.LoadStrings;
begin
  inherited;
  
  tshOptions.Caption := cxGetResourceString(@sdxOptions);
  tshFont.Caption := cxGetResourceString(@sdxFonts);
  tshColor.Caption := cxGetResourceString(@sdxColors);
  tshBehaviors.Caption := cxGetResourceString(@sdxBehaviors);
  lblPreview.Caption := DropAmpersand(cxGetResourceString(@sdxPreview));

  lblShow.Caption := cxGetResourceString(@sdxShow);
  chbxShowRowAndColumnHeadings.Caption := cxGetResourceString(@sdxShowRowAndColumnHeadings);
  chbxShowGridLines.Caption := cxGetResourceString(@sdxShowGridLines);
  
  lblMiscellaneous.Caption := cxGetResourceString(@sdxMiscellaneous);
  //chbxAutoWidth.Caption := cxGetResourceString(@sdxAutoWidth);
  chbxRowAutoHeight.Caption := cxGetResourceString(@sdxRowAutoHeight);
  chbxSuppressSourceFormats.Caption := cxGetResourceString(@sdxSuppressSourceFormats);

  stTransparent.Caption := ' ' + cxGetResourceString(@sdxTransparent) + ' ';
  lblColor.Caption := cxGetResourceString(@sdxColor);
  stFixedTransparent.Caption := ' ' + cxGetResourceString(@sdxFixedTransparent) + ' ';
  lblFixedColor.Caption := cxGetResourceString(@sdxFixedColor);
  lblGridLinesColor.Caption := cxGetResourceString(@sdxGridLinesColor);

  btnFont.Caption := cxGetResourceString(@sdxBtnFont);
  btnFixedFont.Caption := cxGetResourceString(@sdxBtnFixedFont);

  lblOnEveryPage.Caption := cxGetResourceString(@sdxOnEveryPage);
  chbxFixedRowsOnEveryPage.Caption := cxGetResourceString(@sdxRepeatHeaderRowAtTop);

  lblSelection.Caption := cxGetResourceString(@sdxSelection);
  chbxOnlySelected.Caption := cxGetResourceString(@sdxOnlySelected);
end;

procedure TfmdxSpreadSheetDesignWindow.PaintPreview(ACanvas: TCanvas; R: TRect);
begin
  inherited;
  dxPSBaseGridLnk.dxPSDrawGridPreview(ACanvas, R, ReportLink, 
    ReportLink.IsShowRowAndColumnHeadings, ReportLink.IsShowRowAndColumnHeadings);
end;

procedure TfmdxSpreadSheetDesignWindow.UpdateControlsState;
begin
  inherited;
  FccbxColor.Enabled := not chbxTransparent.Checked;
  lblColor.Enabled := FccbxColor.Enabled;
  FccbxFixedColor.Enabled := not chbxFixedTransparent.Checked;
  lblFixedColor.Enabled := FccbxFixedColor.Enabled;
  chbxFixedRowsOnEveryPage.Enabled := not ReportLink.IsAggregated;
end;

procedure TfmdxSpreadSheetDesignWindow.UpdatePreview;
begin
  FPreviewBox.Invalidate;
end;

function TfmdxSpreadSheetDesignWindow.GetReportLink: TCustomdxSpreadSheetReportLink;
begin
  Result := inherited ReportLink as TCustomdxSpreadSheetReportLink;
end;

procedure TfmdxSpreadSheetDesignWindow.SetReportLink(Value: TCustomdxSpreadSheetReportLink);
begin
  inherited ReportLink := Value;
end;

procedure TfmdxSpreadSheetDesignWindow.CreateControls;

  function CreateColorCombo(AHost: TBevel; ALabel: TLabel; ATag: Integer; AnAutoColor: TColor): TdxPSColorCombo;
  begin
    Result := TdxPSColorCombo.Create(Self);
    with Result do
    begin
      BoundsRect := AHost.BoundsRect;
      Tag := ATag;
      Parent := AHost.Parent;
      ColorTypes := [ctPure];
      ShowColorName := True;
      ShowAutoColor := True;
      AutoColor := AnAutoColor;
      OnChange := ccbxColorChange;
    end;
    ALabel.FocusControl := Result;
  end;

  function CreatePreviewBox(AParent: TWinControl) : TdxPSPaintPanel;
  begin
    Result := TdxPSPaintPanel.Create(Self);
    with Result do
    begin
      Parent := AParent;
      Align := alClient;
      EdgeInner := esNone;
      EdgeOuter := esNone;
      OnPaint := pbxPreviewPaint;
    end;
  end;
  
begin
  FccbxColor := CreateColorCombo(bvlColorHolder, lblColor, 0, dxDefaultColor);
  FccbxFixedColor := CreateColorCombo(bvlFixedColorHolder, lblFixedColor, 1, dxDefaultFixedColor);
  FccbxGridLineColor := CreateColorCombo(bvlLineColorHolder, lblGridLinesColor, 2, dxDefaultGridLineColor);

  FPreviewBox := CreatePreviewBox(pnlPreview);
end;

procedure TfmdxSpreadSheetDesignWindow.CMDialogChar(var Message: TCMDialogChar);
var
  I: Integer;
begin
  inherited;
  with pgctrlMain do
    for I := 0 to PageCount - 1 do
      if IsAccel(Message.CharCode, Pages[I].Caption) then
      begin
        Message.Result := 1;
        ActivePage := Pages[I];
        Exit;
      end;
end;

procedure TfmdxSpreadSheetDesignWindow.pbxPreviewPaint(Sender: TObject);
begin
  with TdxPSPaintPanel(Sender) do
    PaintPreview(Canvas, ClientRect);
end;

procedure TfmdxSpreadSheetDesignWindow.chbxFixedRowsOnEveryPageClick(Sender: TObject);                              
begin
  if LockControlsUpdate then Exit;
  ReportLink.HeadersOnEveryPage := TCheckBox(Sender).Checked;
  Modified := True;
end;

procedure TfmdxSpreadSheetDesignWindow.chbxOnlySelectedClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.OnlySelected := TCheckBox(Sender).checked;
  Modified := True;
end;

procedure TfmdxSpreadSheetDesignWindow.ccbxColorChange(Sender: TObject);
var
  Color: TColor;
begin
  if LockControlsUpdate then Exit;
  Color := TdxPSColorCombo(Sender).ColorValue;
  case TdxPSColorCombo(Sender).Tag of
    0: ReportLink.Color := Color;
    1: ReportLink.FixedColor := Color;
    2: ReportLink.GridLineColor := Color;
  end;
  Modified := True;
  UpdatePreview;
end;

procedure TfmdxSpreadSheetDesignWindow.btnFixedFontClick(Sender: TObject);

  function GetEdit: TEdit;
  begin
    if TButton(Sender).Tag = 0 then
      Result := edFont
    else
      Result := edFixedFont;  
  end;
  
begin
  if LockControlsUpdate then Exit;
  
  with dxPSGlbl.FontDialog do 
  begin
    case TButton(Sender).Tag of
      0: Font := ReportLink.Font;
      1: Font := ReportLink.FixedFont;
    end;
  
    if Execute then
    begin
      case TButton(Sender).Tag of
        0: ReportLink.Font := Font;
        1: ReportLink.FixedFont := Font;
      end;
      FontInfoToText(Font, GetEdit);
      Modified := True;
      UpdatePreview;
    end;
  end;  
end;

procedure TfmdxSpreadSheetDesignWindow.chbxRowAutoHeightClick(
  Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.RowAutoHeight := TCheckBox(Sender).Checked;
  Modified := True;
end;

procedure TfmdxSpreadSheetDesignWindow.chbxSuppressSourceFormatsClick(
  Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  with ReportLink do
    if TCheckBox(Sender).Checked then 
      OptionsView := OptionsView + [ssovSuppressSourceFormats]
    else  
      OptionsView := OptionsView - [ssovSuppressSourceFormats];
  Modified := True;
  UpdatePreview;
end;

procedure TfmdxSpreadSheetDesignWindow.chbxShowRowAndColumnHeadingsClick(
  Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  with ReportLink do
    if TCheckBox(Sender).Checked then 
      OptionsView := OptionsView + [ssovRowAndColumnHeadings]
    else  
      OptionsView := OptionsView - [ssovRowAndColumnHeadings];
  Modified := True;
  UpdatePreview;
end;

procedure TfmdxSpreadSheetDesignWindow.chbxShowGridLinesClick(
  Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  with ReportLink do
    if TCheckBox(Sender).Checked then 
      OptionsView := OptionsView + [ssovGridLines]
    else  
      OptionsView := OptionsView - [ssovGridLines];
  Modified := True;
  UpdatePreview;
end;

procedure TfmdxSpreadSheetDesignWindow.chbxFixedTransparentClick(
  Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  case TCheckBox(Sender).Tag of
    0: ReportLink.Transparent := TCheckBox(Sender).checked;
    1: ReportLink.FixedTransparent := TCheckBox(Sender).checked;
  end;
  Modified := True;
  UpdatePreview;
end;

procedure TfmdxSpreadSheetDesignWindow.stTransparentClick(Sender: TObject);
begin
  if chbxTransparent.CanFocus then ActiveControl := chbxTransparent;
  chbxTransparent.Checked := not chbxTransparent.Checked;
end;

procedure TfmdxSpreadSheetDesignWindow.stFixedTransparentClick(Sender: TObject);
begin
  if chbxFixedTransparent.CanFocus then ActiveControl := chbxFixedTransparent;
  chbxFixedTransparent.Checked := not chbxFixedTransparent.Checked;
end;

procedure TfmdxSpreadSheetDesignWindow.lblColorClick(Sender: TObject);
begin
  ActiveControl := TLabel(Sender).FocusControl;
  TCustomComboBox(ActiveControl).DroppedDown := True;
end;

procedure TfmdxSpreadSheetDesignWindow.pgctrlMainChange(Sender: TObject);
begin
  lblPreview.Parent := TPageControl(Sender).ActivePage;
end;

procedure RegisterItems;
begin
  TdxReportCellSSString.Register;
end;

procedure UnregisterItems;
begin
  TdxReportCellSSString.Unregister;
end;

procedure RegisterAssistants;
begin
  TdxPSSSStringGridCellDataMap.Register;
end;

procedure UnregisterAssistants;
begin
  TdxPSSSStringGridCellDataMap.Unregister;
end;

initialization
  RegisterAssistants;
  RegisterItems;
  
  dxPSRegisterReportLink(TdxSpreadSheetBookReportLink, TcxSpreadSheetBook, TfmdxSpreadSheetDesignWindow);
  dxPSRegisterReportLink(TdxSpreadSheetReportLink, TcxSpreadSheet, TfmdxSpreadSheetDesignWindow);
  
finalization
  dxPSUnregisterReportLink(TdxSpreadSheetReportLink, TcxSpreadSheet, TfmdxSpreadSheetDesignWindow);
  dxPSUnregisterReportLink(TdxSpreadSheetBookReportLink, TcxSpreadSheetBook, TfmdxSpreadSheetDesignWindow);

  UnregisterItems;
  UnregisterAssistants;
  
end.
 
