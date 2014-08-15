{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressQuantumGrid                                           }
{                                                                    }
{       Copyright (c) 1998-2010 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSQUANTUMGRID AND ALL            }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit cxGridBandedTableView;

{$I cxGridVer.inc}

interface

uses
  Windows,
  Classes, Graphics, Controls, ComCtrls,
  cxClasses, cxControls, cxGraphics, cxLookAndFeelPainters, cxStyles, cxStorage,
  cxGridCommon, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridRows;

const
  cxGridDefaultFixedBandSeparatorWidth = 2;
  cxGridDefaultEmptyBandWidth = 50;

  htBandedGridBase = htGridBase + 50;
  htColumnHeaderVertSizingEdge = htBandedGridBase + 1;
  htBand = htBandedGridBase + 2;
  htBandHeader = htBandedGridBase + 3;
  htBandHeaderSizingEdge = htBandedGridBase + 4;

  bbBandedTableFirst = bbTableLast + 1;
  bbBandBackground = bbBandedTableFirst;
  bbBandHeader = bbBandedTableFirst + 1;
  bbBandedTableLast = bbBandHeader;

  bsFirst = 0;
  bsBackground = bsFirst;
  bsContent = bsFirst + 1;
  bsHeader = bsFirst + 2;
  bsLast = bsHeader;

  vsBandedTableFirst = vsTableLast + 1;
  vsBandBackground = vsBandedTableFirst;
  vsBandHeader = vsBandedTableFirst + 1;
  vsBandedTableLast = vsBandHeader;

type
  TcxGridBandedTableCustomizationForm = class;
  TcxGridBandedTableController = class;
  TcxGridBandedColumnContainerZone = class;
  TcxGridBandHeaderViewInfo = class;
  TcxGridBandRowViewInfo = class;
  TcxGridBandRowsViewInfo = class;
  TcxGridBandViewInfo = class;
  TcxGridBandsViewInfo = class;
  TcxGridBandedHeaderViewInfo = class;
  TcxGridBandedDataRowCellsAreaItemViewInfo = class;
  TcxGridBandedDataRowCellsAreaViewInfo = class;
  TcxGridBandedRowsViewInfo = class;
  TcxGridBandedTableViewInfo = class;
  TcxGridBandedColumnPosition = class;
  TcxGridBandedColumn = class;
  TcxGridBandRow = class;
  TcxGridBandRows = class;
  TcxGridBand = class;
  TcxGridBands = class;
  TcxGridBandedTableView = class;

  TcxGridBandFixedKind = (fkNone, fkLeft, fkRight);

  { hit tests }

  TcxGridColumnHeaderVertSizingEdgeHitTest = class(TcxCustomGridColumnHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  public
    class function Cursor: TCursor; override;
    function DragAndDropObjectClass: TcxCustomGridDragAndDropObjectClass; override;
  end;

  TcxGridBandContainerKind = (bcHeader, bcCustomizationForm);

  TcxGridBandHitTest = class(TcxCustomGridViewHitTest)
  private
    FBand: TcxGridBand;
    FBandContainerKind: TcxGridBandContainerKind;
    FVisibleRowIndex: Integer;
  protected
    class function GetHitTestCode: Integer; override;
  public
    property Band: TcxGridBand read FBand write FBand;
    property BandContainerKind: TcxGridBandContainerKind read FBandContainerKind
      write FBandContainerKind;
    property VisibleRowIndex: Integer read FVisibleRowIndex write FVisibleRowIndex;
  end;

  TcxGridBandHeaderHitTest = class(TcxGridBandHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  public
    function DragAndDropObjectClass: TcxCustomGridDragAndDropObjectClass; override;
  end;

  TcxGridBandHeaderSizingEdgeHitTest = class(TcxGridBandHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  public
    class function Cursor: TCursor; override;
    function DragAndDropObjectClass: TcxCustomGridDragAndDropObjectClass; override;
  end;

  { controller }

  TcxGridBandedColumnHeaderMovingObject = class(TcxGridColumnHeaderMovingObject)
  private
    function GetDestZone: TcxGridBandedColumnContainerZone;
    function GetSourceColumn: TcxGridBandedColumn;
    function GetSourcePosition: TcxGridBandedColumnPosition;
    function GetViewInfo: TcxGridBandedTableViewInfo;
    procedure SetSourceColumn(Value: TcxGridBandedColumn);
  protected
    function AreArrowsVertical: Boolean; override;
    procedure DoColumnMoving; override;
    function GetArrowAreaBoundsForHeader(APlace: TcxGridArrowPlace): TRect; override;
    function GetArrowsClientRect: TRect; override;
    function IsValidDestination: Boolean; override;
    function IsValidDestinationForVisibleSource: Boolean; override;
    property DestZone: TcxGridBandedColumnContainerZone read GetDestZone;
    property SourceColumn: TcxGridBandedColumn read GetSourceColumn write SetSourceColumn;
    property SourcePosition: TcxGridBandedColumnPosition read GetSourcePosition;
    property ViewInfo: TcxGridBandedTableViewInfo read GetViewInfo;
  end;

  TcxGridBandHeaderMovingObject = class(TcxCustomGridMovingObject)
  private
    FDestBandContainerKind: TcxGridBandContainerKind;
    FDestBandIndex: Integer;
    FSourceBand: TcxGridBand;
    FSourceBandContainerKind: TcxGridBandContainerKind;
    function GetController: TcxGridBandedTableController;
    function GetCustomizationForm: TcxGridBandedTableCustomizationForm;
    function GetGridView: TcxGridBandedTableView;
    function GetViewInfo: TcxGridBandedTableViewInfo;
    procedure SetDestBandContainerKind(Value: TcxGridBandContainerKind);
    procedure SetDestBandIndex(Value: Integer);
  protected
    function CanRemove: Boolean; override;
    function GetArrowAreaBounds(APlace: TcxGridArrowPlace): TRect; override;
    function GetArrowsClientRect: TRect; override;
    function GetCustomizationFormListBox: TcxCustomGridTableItemsListBox; override;
    function GetSourceItem: TObject; override;
    function GetSourceItemViewInfo: TcxCustomGridCellViewInfo; override;
    function IsSourceCustomizationForm: Boolean; override;
    function IsValidDestination: Boolean; override;

    property Controller: TcxGridBandedTableController read GetController;
    property CustomizationForm: TcxGridBandedTableCustomizationForm read GetCustomizationForm;
    property DestBandContainerKind: TcxGridBandContainerKind read FDestBandContainerKind
      write SetDestBandContainerKind;
    property DestBandIndex: Integer read FDestBandIndex write SetDestBandIndex;
    property GridView: TcxGridBandedTableView read GetGridView;
    property SourceBand: TcxGridBand read FSourceBand write FSourceBand;
    property SourceBandContainerKind: TcxGridBandContainerKind read FSourceBandContainerKind
      write FSourceBandContainerKind;
    property ViewInfo: TcxGridBandedTableViewInfo read GetViewInfo;
  public
    constructor Create(AControl: TcxControl); override;
    procedure BeginDragAndDrop; override;
    procedure DragAndDrop(const P: TPoint; var Accepted: Boolean); override;
    procedure EndDragAndDrop(Accepted: Boolean); override;
    procedure Init(const P: TPoint; AParams: TcxCustomGridHitTest); override;
  end;

  TcxGridColumnVertSizingObject = class(TcxCustomGridColumnSizingObject)
  private
    function GetColumn: TcxGridBandedColumn;
    function GetController: TcxGridBandedTableController;
    function GetLineHeight: Integer;
  protected
    function GetCurrentSize: Integer; override;
    function GetIsHorizontalSizing: Boolean; override;
    property Column: TcxGridBandedColumn read GetColumn;
    property Controller: TcxGridBandedTableController read GetController;
    property LineHeight: Integer read GetLineHeight;
  public
    procedure BeginDragAndDrop; override;
    procedure EndDragAndDrop(Accepted: Boolean); override;
  end;

  TcxGridBandSizingObject = class(TcxCustomGridSizingObject)
  private
    FBand: TcxGridBand;
    function GetBandViewInfo: TcxGridBandViewInfo;
    function GetController: TcxGridBandedTableController;
    function GetGridView: TcxGridBandedTableView;
  protected
    function GetCurrentSize: Integer; override;
    function GetSizingItemBounds: TRect; override;
    function GetSizingMarkWidth: Integer; override;

    property Band: TcxGridBand read FBand write FBand;
    property BandViewInfo: TcxGridBandViewInfo read GetBandViewInfo;
    property Controller: TcxGridBandedTableController read GetController;
    property GridView: TcxGridBandedTableView read GetGridView;
  public
    procedure BeginDragAndDrop; override;
    procedure EndDragAndDrop(Accepted: Boolean); override;
    procedure Init(const P: TPoint; AParams: TcxCustomGridHitTest); override;
  end;

  TcxGridBandedTableBandsListBoxClass = class of TcxGridBandedTableBandsListBox;

  TcxGridBandedTableBandsListBox = class(TcxCustomGridTableItemsListBox)
  private
    function GetGridView: TcxGridBandedTableView;
  protected
    function GetDragAndDropParams: TcxCustomGridHitTest; override;
    property GridView: TcxGridBandedTableView read GetGridView;
  public
    procedure RefreshItems; override;
  end;

  TcxGridBandedTableCustomizationForm = class(TcxGridTableCustomizationForm)
  private
    FBandsListBox: TcxGridBandedTableBandsListBox;
    FBandsPage: TTabSheet;
    function GetGridView: TcxGridBandedTableView;
  protected
    procedure CreateControls; override;
    procedure InitPageControl; override;

    function GetBandsListBoxClass: TcxGridBandedTableBandsListBoxClass; virtual;

    property BandsListBox: TcxGridBandedTableBandsListBox read FBandsListBox;
    property GridView: TcxGridBandedTableView read GetGridView;
  public
    procedure RefreshData; override;
    property BandsPage: TTabSheet read FBandsPage;
  end;

  TcxGridBandedTableController = class(TcxGridTableController)
  private
    FMovingBand: TcxGridBand;
    FPressedBand: TcxGridBand;
    FSizingBand: TcxGridBand;
    FVertSizingColumn: TcxGridBandedColumn;
    function GetGridView: TcxGridBandedTableView;
    function GetIsBandMoving: Boolean;
    function GetIsBandSizing: Boolean;
    function GetIsColumnVertSizing: Boolean;
    function GetViewInfo: TcxGridBandedTableViewInfo;
    procedure SetPressedBand(Value: TcxGridBand);
  protected
    function GetColumnHeaderDragAndDropObjectClass: TcxGridColumnHeaderMovingObjectClass; override;
    procedure GetColumnNeighbors(AColumn: TcxGridBandedColumn; AGoForward: Boolean;
      AList: TList); virtual;
    function GetCustomizationFormClass: TcxGridTableCustomizationFormClass; override;
    function IsBandFixedDuringSizing(ABand: TcxGridBand): Boolean; virtual;
    function IsColumnFixedDuringHorzSizing(AColumn: TcxGridColumn): Boolean; override;
    procedure LeftPosChanged; override;

    property ViewInfo: TcxGridBandedTableViewInfo read GetViewInfo;
  public
    procedure DoCancelMode; override;
    procedure EndDragAndDrop(Accepted: Boolean); override;

    function FindNextColumnVertically(AFocusedItemIndex: Integer;
      AGoForward, AGoOnCycle: Boolean): Integer; virtual;
    function FindNextItem(AFocusedItemIndex: Integer;
      AGoForward, AGoOnCycle: Boolean; out ACycleChanged: Boolean): Integer; override;
    function FocusNextColumnVertically(AFocusedColumnIndex: Integer;
      AGoForward, AGoOnCycle: Boolean): Boolean;

    procedure KeyDown(var Key: Word; Shift: TShiftState); override;

    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    property GridView: TcxGridBandedTableView read GetGridView;
    property IsBandMoving: Boolean read GetIsBandMoving;
    property IsBandSizing: Boolean read GetIsBandSizing;
    property IsColumnVertSizing: Boolean read GetIsColumnVertSizing;
    property MovingBand: TcxGridBand read FMovingBand;
    property PressedBand: TcxGridBand read FPressedBand write SetPressedBand;
    property SizingBand: TcxGridBand read FSizingBand;
    property VertSizingColumn: TcxGridBandedColumn read FVertSizingColumn;
  end;

  { painters }

  TcxGridBandHeaderPainter = class(TcxCustomGridCellPainter)
  private
    function GetViewInfo: TcxGridBandHeaderViewInfo;
  protected
    procedure DrawBorders; override;
    procedure DrawContent; override;
    procedure DrawPressed; virtual;
    function ExcludeFromClipRect: Boolean; override;
    procedure Paint; override;
    property ViewInfo: TcxGridBandHeaderViewInfo read GetViewInfo;
  end;

  TcxGridBandPainter = class(TcxCustomGridCellPainter)
  private
    function GetViewInfo: TcxGridBandViewInfo;
  protected
    procedure DrawColumnHeaders; virtual;
    procedure DrawContent; override;
    procedure DrawHeader; virtual;
    function ExcludeFromClipRect: Boolean; override;
    property ViewInfo: TcxGridBandViewInfo read GetViewInfo;
  end;

  TcxGridBandedHeaderPainter = class(TcxGridHeaderPainter)
  private
    function GetViewInfo: TcxGridBandedHeaderViewInfo;
  protected
    procedure DrawBands; virtual;
    procedure DrawItems; override;
    property ViewInfo: TcxGridBandedHeaderViewInfo read GetViewInfo;
  end;

  TcxGridBandedFooterPainter = class(TcxGridFooterPainter)
  protected
    procedure DrawItems; override;
  end;

  TcxGridBandedDataRowCellsAreaItemPainter = class(TcxCustomGridCellPainter)
  private
    function GetViewInfo: TcxGridBandedDataRowCellsAreaItemViewInfo;
  protected
    procedure DrawFixedBandsSeparator; virtual;
    procedure DrawContent; override;
    procedure DrawLines; virtual;
    function ExcludeFromClipRect: Boolean; override;
    procedure Paint; override;
    property ViewInfo: TcxGridBandedDataRowCellsAreaItemViewInfo read GetViewInfo;
  end;

  TcxGridBandedRowsPainter = class(TcxGridRowsPainter)
  public
    class procedure DrawDataRowCells(ARowViewInfo: TcxCustomGridRowViewInfo); override;
  end;

  TcxGridBandedTablePainter = class(TcxGridTablePainter)
  private
    function GetViewInfo: TcxGridBandedTableViewInfo;
  protected
    function CanOffset(AItemsOffset, DX, DY: Integer): Boolean; override;
  public
    property ViewInfo: TcxGridBandedTableViewInfo read GetViewInfo;
  end;

  { view infos }

  // column container

  TcxGridBandedColumnContainerZone = class(TcxGridColumnContainerZone)
  public
    Band: TcxGridBand;
    ColIndex: Integer;
    RowIndex: Integer;
    constructor Create(AColumnIndex: Integer;
      ABand: TcxGridBand; AColIndex, ARowIndex: Integer);
    function IsEqual(Value: TcxGridColumnContainerZone): Boolean; override;
    function IsInsertion: Boolean;
  end;

  // column header

  TcxGridBandedColumnHeaderVertSizingEdgeViewInfo = class(TcxGridColumnHeaderAreaViewInfo)
  protected
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function GetAlignmentVert: TcxAlignmentVert; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetIsOccupyingSpace: Boolean; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetTransparent: Boolean; override;
  public
    procedure Calculate(const ABounds: TRect; var ATextAreaBounds: TRect); override;
  end;

  TcxGridBandedColumnHeaderViewInfo = class(TcxGridColumnHeaderViewInfo)
  private
    function GetBandViewInfo: TcxGridBandViewInfo;
    function GetColumn: TcxGridBandedColumn;
    function GetContainer: TcxGridBandedHeaderViewInfo;
    function GetRowViewInfo: TcxGridBandRowViewInfo;
  protected
    function CanVertSize: Boolean; virtual;
    procedure GetAreaViewInfoClasses(AProc: TcxGridClassEnumeratorProc); override;
    function GetMaxWidth: Integer; override;
    function GetMultiLinePainting: Boolean; override;
    property BandViewInfo: TcxGridBandViewInfo read GetBandViewInfo;
    property Container: TcxGridBandedHeaderViewInfo read GetContainer;
    property RowViewInfo: TcxGridBandRowViewInfo read GetRowViewInfo;
  public
    property Column: TcxGridBandedColumn read GetColumn;
  end;

  // bands

  TcxGridBandHeaderViewInfoClass = class of TcxGridBandHeaderViewInfo;

  TcxGridBandHeaderViewInfo = class(TcxCustomGridViewCellViewInfo)
  private
    FBandViewInfo: TcxGridBandViewInfo;
    function GetBand: TcxGridBand;
    function GetGridView: TcxGridBandedTableView;
    function GetGridViewInfo: TcxGridBandedTableViewInfo;
  protected
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function CustomDraw(ACanvas: TcxCanvas): Boolean; override;
    function GetAlignmentHorz: TAlignment; override;
    function GetAlignmentVert: TcxAlignmentVert; override;
    function GetBackgroundBitmap: TBitmap; override;
    function GetBorders: TcxBorders; override;
    function GetBorderWidth(AIndex: TcxBorder): Integer; override;
    function GetCanvas: TcxCanvas; override;
    class function GetCellHeight(ATextHeight: Integer;
      ALookAndFeelPainter: TcxCustomLookAndFeelPainterClass): Integer; override;
    function GetHeight: Integer; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetHotTrack: Boolean; override;
    function GetIsPressed: Boolean; virtual;
    function GetMultiLinePainting: Boolean; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetShowEndEllipsis: Boolean; override;
    function GetSizingEdgeBounds: TRect; virtual;
    function GetText: string; override;
    function GetVisible: Boolean; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function HasCustomDraw: Boolean; override;
    procedure InitHitTest(AHitTest: TcxCustomGridHitTest); override;
    procedure StateChanged; override;
    property SizingEdgeBounds: TRect read GetSizingEdgeBounds;
  public
    constructor Create(ABandViewInfo: TcxGridBandViewInfo); virtual;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; override;
    function MouseDown(AHitTest: TcxCustomGridHitTest; AButton: TMouseButton;
      AShift: TShiftState): Boolean; override;
    property Band: TcxGridBand read GetBand;
    property BandViewInfo: TcxGridBandViewInfo read FBandViewInfo;
    property GridView: TcxGridBandedTableView read GetGridView;
    property GridViewInfo: TcxGridBandedTableViewInfo read GetGridViewInfo;
    property IsPressed: Boolean read GetIsPressed;
  end;

  TcxGridBandRowViewInfoClass = class of TcxGridBandRowViewInfo;

  TcxGridBandRowViewInfo = class
  private
    FColumnViewInfos: TList;
    FHeight: Integer;
    FIndex: Integer;
    FLineCount: Integer;
    FRowsViewInfo: TcxGridBandRowsViewInfo;
    function GetBandRow: TcxGridBandRow;
    function GetBandViewInfo: TcxGridBandViewInfo;
    function GetColumnViewInfo(Index: Integer): TcxGridBandedColumnHeaderViewInfo;
    function GetColumnViewInfoCount: Integer;
    function GetGridView: TcxGridBandedTableView;
    function GetHeight: Integer;
    function GetLineCount: Integer;
    function GetLineHeight: Integer;
    function GetLineOffset: Integer;
    function GetMinWidth: Integer;
    function GetWidth: Integer;
  protected
    procedure AddColumnViewInfos; virtual;
    procedure Calculate(const ABounds: TRect); virtual;
    procedure CalculateColumnWidths; virtual;
    function CalculateHeight: Integer; virtual;
    function CalculateLineCount: Integer; virtual;
    function CalculateLineHeight: Integer; virtual;
    function CalculateWidth: Integer; virtual;
    property GridView: TcxGridBandedTableView read GetGridView;
    property LineHeight: Integer read GetLineHeight;
  public
    Bounds: TRect;
    constructor Create(ARowsViewInfo: TcxGridBandRowsViewInfo; AIndex: Integer); virtual;
    destructor Destroy; override;
    procedure AssignColumnWidths;
    procedure Offset(DX, DY: Integer); virtual;
    property BandRow: TcxGridBandRow read GetBandRow;
    property BandViewInfo: TcxGridBandViewInfo read GetBandViewInfo;
    property ColumnViewInfoCount: Integer read GetColumnViewInfoCount;
    property ColumnViewInfos[Index: Integer]: TcxGridBandedColumnHeaderViewInfo read GetColumnViewInfo; default;
    property Index: Integer read FIndex;
    property LineCount: Integer read GetLineCount;
    property LineOffset: Integer read GetLineOffset;
    property MinWidth: Integer read GetMinWidth;
    property RowsViewInfo: TcxGridBandRowsViewInfo read FRowsViewInfo;
    property Height: Integer read GetHeight;
    property Width: Integer read GetWidth;
  end;

  TcxGridBandRowsViewInfoClass = class of TcxGridBandRowsViewInfo;

  TcxGridBandRowsViewInfo = class
  private
    FBandViewInfo: TcxGridBandViewInfo;
    FItems: TList;
    FWidth: Integer;
    function GetBandRows: TcxGridBandRows;
    function GetCount: Integer;
    function GetItem(Index: Integer): TcxGridBandRowViewInfo;
    function GetLineCount: Integer;
    function GetMinWidth: Integer;
    function GetWidth: Integer;
    procedure CreateItems;
    procedure DestroyItems;
  protected
    procedure Calculate(const ABounds: TRect); virtual;
    procedure CalculateColumnWidths; virtual;
    function CalculateWidth: Integer; virtual;
    function GetBandRowViewInfoClass: TcxGridBandRowViewInfoClass; virtual;
  public
    Bounds: TRect;
    constructor Create(ABandViewInfo: TcxGridBandViewInfo); virtual;
    destructor Destroy; override;
    function IndexAtPos(const P: TPoint): Integer;
    procedure Offset(DX, DY: Integer); virtual;
    property BandRows: TcxGridBandRows read GetBandRows;
    property BandViewInfo: TcxGridBandViewInfo read FBandViewInfo;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TcxGridBandRowViewInfo read GetItem; default;
    property LineCount: Integer read GetLineCount;
    property MinWidth: Integer read GetMinWidth;
    property Width: Integer read GetWidth;
  end;

  TcxGridBandViewInfoClass = class of TcxGridBandViewInfo;

  TcxGridBandViewInfo = class(TcxCustomGridCellViewInfo)
  private
    FBandsViewInfo: TcxGridBandsViewInfo;
    FColumnViewInfos: TList;
    FHeaderViewInfo: TcxGridBandHeaderViewInfo;
    FIndex: Integer;
    FRowsViewInfo: TcxGridBandRowsViewInfo;
    FWidth: Integer;
    function GetBand: TcxGridBand;
    function GetColumnViewInfo(Index: Integer): TcxGridBandedColumnHeaderViewInfo;
    function GetColumnViewInfoCount: Integer;
    function GetContainerViewInfo: TcxGridBandedHeaderViewInfo;
    function GetFixedKind: TcxGridBandFixedKind;
    function GetGridView: TcxGridBandedTableView;
    function GetGridViewInfo: TcxGridBandedTableViewInfo;
    function GetIsFixed: Boolean;
    function GetIsRight: Boolean;
    function GetLineCount: Integer;
    function GetRowCount: Integer;
  protected
    procedure AddColumnViewInfos; virtual;
    procedure CalculateColumnWidths; virtual;
    function CalculateHeaderBounds: TRect; virtual;
    function CalculateRowsBounds: TRect; virtual;
    function CalculateWidth: Integer; override;
    function CanSize: Boolean; virtual;
    procedure CheckWidth(var Value: Integer); virtual;
    function CustomDrawBackground(ACanvas: TcxCanvas): Boolean; override;
    function GetAreAllColumnsFixed: Boolean; virtual;
    function GetBackgroundBitmap: TBitmap; override;
    function GetBorderColor(AIndex: TcxBorder): TColor; override;
    function GetBorders: TcxBorders; override;
    function GetBorderWidth(AIndex: TcxBorder): Integer; override;
    function GetCanvas: TcxCanvas; override;
    function GetContentWidth: Integer; override;
    function GetHeaderViewInfoClass: TcxGridBandHeaderViewInfoClass; virtual;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetMaxWidth: Integer; virtual;
    function GetMinWidth: Integer; virtual;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetRowsViewInfoClass: TcxGridBandRowsViewInfoClass; virtual;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function GetWidth: Integer; override;
    procedure InitHitTest(AHitTest: TcxCustomGridHitTest); override;
    procedure Offset(DX, DY: Integer); override;
    procedure SetWidth(Value: Integer); override;
  public
    constructor Create(ABandsViewInfo: TcxGridBandsViewInfo; AIndex: Integer); virtual;
    destructor Destroy; override;
    procedure Calculate(const ABounds: TRect); override;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; override;
    procedure InitAutoWidthItem(AAutoWidthItem: TcxAutoWidthItem);
    property AreAllColumnsFixed: Boolean read GetAreAllColumnsFixed;
    property Band: TcxGridBand read GetBand;
    property BandsViewInfo: TcxGridBandsViewInfo read FBandsViewInfo;
    property ColumnViewInfoCount: Integer read GetColumnViewInfoCount;
    property ColumnViewInfos[Index: Integer]: TcxGridBandedColumnHeaderViewInfo read GetColumnViewInfo; default;
    property ContainerViewInfo: TcxGridBandedHeaderViewInfo read GetContainerViewInfo;
    property FixedKind: TcxGridBandFixedKind read GetFixedKind;
    property GridView: TcxGridBandedTableView read GetGridView;
    property GridViewInfo: TcxGridBandedTableViewInfo read GetGridViewInfo;
    property HeaderViewInfo: TcxGridBandHeaderViewInfo read FHeaderViewInfo;
    property Index: Integer read FIndex;
    property IsFixed: Boolean read GetIsFixed;
    property IsRight: Boolean read GetIsRight;
    property LineCount: Integer read GetLineCount;
    property MaxWidth: Integer read GetMaxWidth;
    property MinWidth: Integer read GetMinWidth;
    property RowCount: Integer read GetRowCount;
    property RowsViewInfo: TcxGridBandRowsViewInfo read FRowsViewInfo;
  end;

  TcxGridBandsViewInfoClass = class of TcxGridBandsViewInfo;

  TcxGridBandsViewInfo = class
  private
    FContainerViewInfo: TcxGridBandedHeaderViewInfo;
    FBandHeadersAreaHeight: Integer;
    FItems: TList;
    FLineCount: Integer;
    FRowCount: Integer;
    function GetBandHeadersAreaHeight: Integer;
    function GetBands: TcxGridBands;
    function GetColumnHeadersAreaHeight: Integer;
    function GetCount: Integer;
    function GetGridView: TcxGridBandedTableView;
    function GetGridViewInfo: TcxGridBandedTableViewInfo;
    function GetInternalItem(Index: Integer): TcxGridBandViewInfo;
    function GetItem(Index: Integer): TcxGridBandViewInfo;
    function GetLastFixedItem(AFixedKind: TcxGridBandFixedKind): TcxGridBandViewInfo;
    function GetLineCount: Integer;
    function GetRowCount: Integer;
    procedure CreateItems;
    procedure DestroyItems;
  protected
    procedure Calculate; virtual;
    function CalculateBandHeadersAreaHeight: Integer; virtual;
    procedure CalculateColumnWidths; virtual;
    function CalculateHeight: Integer; virtual;
    function CalculateWidth: Integer; virtual;
    function GetBandBackgroundBitmap: TBitmap; virtual;
    function GetBandHeaderBackgroundBitmap: TBitmap; virtual;
    function GetItemClass: TcxGridBandViewInfoClass; virtual;
    function IsBandHeaderHeightAssigned: Boolean; virtual;
    function ShowBandHeaders: Boolean; virtual;
    function ShowColumnHeaders: Boolean; virtual;

    property BandHeadersAreaHeight: Integer read GetBandHeadersAreaHeight;
    property ColumnHeadersAreaHeight: Integer read GetColumnHeadersAreaHeight;
    property GridViewInfo: TcxGridBandedTableViewInfo read GetGridViewInfo;
    property InternalItems[Index: Integer]: TcxGridBandViewInfo read GetInternalItem;
  public
    constructor Create(AContainerViewInfo: TcxGridBandedHeaderViewInfo); virtual;
    destructor Destroy; override;
    procedure AssignItemWidths;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; virtual;
    function IndexAtPos(const P: TPoint): Integer;
    procedure Offset(DX, DY: Integer); virtual;
    property BandBackgroundBitmap: TBitmap read GetBandBackgroundBitmap;
    property BandHeaderBackgroundBitmap: TBitmap read GetBandHeaderBackgroundBitmap;
    property Bands: TcxGridBands read GetBands;
    property ContainerViewInfo: TcxGridBandedHeaderViewInfo read FContainerViewInfo;
    property Count: Integer read GetCount;
    property GridView: TcxGridBandedTableView read GetGridView;
    property Items[Index: Integer]: TcxGridBandViewInfo read GetItem; default;
    property LastFixedItems[AFixedKind: TcxGridBandFixedKind]: TcxGridBandViewInfo read GetLastFixedItem;
    property LineCount: Integer read GetLineCount;
    property RowCount: Integer read GetRowCount;
  end;

  // header

  TcxGridBandedHeaderViewInfoSpecific = class(TcxGridHeaderViewInfoSpecific)
  private
    function GetGridViewInfo: TcxGridBandedTableViewInfo;
  protected  
    function CalculateHeight: Integer; override;
  public
    property GridViewInfo: TcxGridBandedTableViewInfo read GetGridViewInfo;
  end;

  TcxGridBandedHeaderViewInfo = class(TcxGridHeaderViewInfo)
  private
    FBandsViewInfo: TcxGridBandsViewInfo;
    function GetGridView: TcxGridBandedTableView;
    function GetGridViewInfo: TcxGridBandedTableViewInfo;
    function GetItem(Index: Integer): TcxGridBandedColumnHeaderViewInfo;
    function GetLineCount: Integer;
    function GetRowCount: Integer;
    function GetSpecific: TcxGridBandedHeaderViewInfoSpecific;
  protected
    procedure CalculateColumnAutoWidths; override;
    procedure CalculateColumnWidths; override;
    function CalculateHeight: Integer; override;
    procedure CalculateItems; override;
    function GetAutoHeight: Boolean; override;
    function GetBandsViewInfoClass: TcxGridBandsViewInfoClass; virtual;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetIsScrollable: Boolean; override;
    function GetItemClass: TcxGridColumnHeaderViewInfoClass; override;
    function GetItemsAreaBounds: TRect; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetVisible: Boolean; override;
    function GetWidth: Integer; override;
    function IsHeightAssigned: Boolean; override;
    procedure Offset(DX, DY: Integer); override;
  public
    constructor Create(AGridViewInfo: TcxGridTableViewInfo); override;
    destructor Destroy; override;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; override;
    function GetZone(const P: TPoint): TcxGridColumnContainerZone; override;
    property BandsViewInfo: TcxGridBandsViewInfo read FBandsViewInfo;
    property GridView: TcxGridBandedTableView read GetGridView;
    property GridViewInfo: TcxGridBandedTableViewInfo read GetGridViewInfo;
    property Items[Index: Integer]: TcxGridBandedColumnHeaderViewInfo read GetItem; default;
    property LineCount: Integer read GetLineCount;
    property RowCount: Integer read GetRowCount;
    property Specific: TcxGridBandedHeaderViewInfoSpecific read GetSpecific;
  end;

  // rows

  TcxGridFixedBandsSeparatorLocation = (slNone, slLeft, slRight);

  TcxGridBandedDataRowCellsAreaItemViewInfoClass = class of TcxGridBandedDataRowCellsAreaItemViewInfo;

  TcxGridBandedDataRowCellsAreaItemViewInfo = class(TcxGridCellViewInfo)
  private
    FBandViewInfo: TcxGridBandViewInfo;
    FCellsAreaViewInfo: TcxGridBandedDataRowCellsAreaViewInfo;
    FLineBounds: TList;
    function GetFixedBandsSeparatorLocation: TcxGridFixedBandsSeparatorLocation;
    function GetGridViewInfo: TcxGridBandedTableViewInfo;
    function GetLineBounds(Index: Integer): TRect;
    function GetLineCount: Integer;
    function GetRecordsViewInfo: TcxGridBandedRowsViewInfo;
    function GetRecordViewInfo: TcxGridDataRowViewInfo;
    procedure ClearLines;
    procedure CreateLineBounds;
    procedure DestroyLineBounds;
  protected
    procedure AddLine(const ABounds: TRect);
    procedure AddLines; virtual;
    function CalculateWidth: Integer; override;
    function GetBorders: TcxBorders; override;
    function GetFixedBandsSeparatorBounds: TRect; virtual;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    procedure Offset(DX, DY: Integer); override;

    property BandViewInfo: TcxGridBandViewInfo read FBandViewInfo;
    property CellsAreaViewInfo: TcxGridBandedDataRowCellsAreaViewInfo read FCellsAreaViewInfo;
    property GridViewInfo: TcxGridBandedTableViewInfo read GetGridViewInfo;
    property RecordViewInfo: TcxGridDataRowViewInfo read GetRecordViewInfo;
    property RecordsViewInfo: TcxGridBandedRowsViewInfo read GetRecordsViewInfo;
  public
    constructor Create(ACellsAreaViewInfo: TcxGridBandedDataRowCellsAreaViewInfo;
      ABandViewInfo: TcxGridBandViewInfo); reintroduce; virtual;
    destructor Destroy; override;
    procedure BeforeRecalculation; override;
    procedure Calculate(ALeftBound, ATopBound: Integer; AWidth: Integer = -1;
      AHeight: Integer = -1); override;
    function CanDrawSelected: Boolean; override;
    property FixedBandsSeparatorBounds: TRect read GetFixedBandsSeparatorBounds;
    property FixedBandsSeparatorLocation: TcxGridFixedBandsSeparatorLocation read
      GetFixedBandsSeparatorLocation;
    property LineBounds[Index: Integer]: TRect read GetLineBounds;
    property LineCount: Integer read GetLineCount;
  end;

  TcxGridBandedDataRowCellsAreaViewInfo = class(TcxGridDataRowCellsAreaViewInfo)
  private
    FItems: TList;
    function GetBandsViewInfo: TcxGridBandsViewInfo;
    function GetCount: Integer;
    function GetGridViewInfo: TcxGridBandedTableViewInfo;
    function GetItem(Index: Integer): TcxGridBandedDataRowCellsAreaItemViewInfo;
    procedure CreateItems;
    procedure DestroyItems;
  protected
    function CalculateVisible: Boolean; override;
    function GetItemClass: TcxGridBandedDataRowCellsAreaItemViewInfoClass; virtual;
    procedure Offset(DX, DY: Integer); override;
    property BandsViewInfo: TcxGridBandsViewInfo read GetBandsViewInfo;
    property GridViewInfo: TcxGridBandedTableViewInfo read GetGridViewInfo;
  public
    constructor Create(ARecordViewInfo: TcxCustomGridRecordViewInfo); override;
    destructor Destroy; override;
    procedure BeforeRecalculation; override;
    procedure Calculate(ALeftBound, ATopBound: Integer; AWidth: Integer = -1;
      AHeight: Integer = -1); override;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TcxGridBandedDataRowCellsAreaItemViewInfo read GetItem; default;
  end;

  TcxGridBandedRowsViewInfo = class(TcxGridRowsViewInfo)
  private
    FRowCellsAreaVisible: Boolean;
    function GetHeaderViewInfo: TcxGridBandedHeaderViewInfo;
    function GetLineCount: Integer;
    function GetRowCount: Integer;
  protected
    function CalculateDataRowHeight: Integer; override;
    function CalculateRowCellsAreaVisible: Boolean; virtual;
    function GetAutoDataRecordHeight: Boolean; override;
    function GetPainterClass: TcxCustomGridRecordsPainterClass; override;
    function GetRowWidth: Integer; override;
    function GetShowBandSeparators: Boolean; virtual;
    function GetShowCellLeftLines: Boolean; virtual;
    function GetShowCellTopLines: Boolean; virtual;

    property HeaderViewInfo: TcxGridBandedHeaderViewInfo read GetHeaderViewInfo;
    property LineCount: Integer read GetLineCount;
    property RowCount: Integer read GetRowCount;
    property ShowBandSeparators: Boolean read GetShowBandSeparators;
    property ShowCellLeftLines: Boolean read GetShowCellLeftLines;
    property ShowCellTopLines: Boolean read GetShowCellTopLines;
  public
    procedure AfterConstruction; override;
    function CanDataRowSize: Boolean; override;
    function GetDataRowCellsAreaViewInfoClass: TClass; override;
    function IsDataRowHeightAssigned: Boolean; override;
    property RowCellsAreaVisible: Boolean read FRowCellsAreaVisible;
  end;

  // table

  TcxGridBandedTableViewInfo = class(TcxGridTableViewInfo)
  private
    function GetController: TcxGridBandedTableController;
    function GetFixedBandSeparatorColor: TColor;
    function GetFixedBandSeparatorWidth: Integer;
    function GetGridView: TcxGridBandedTableView;
    function GetHeaderViewInfo: TcxGridBandedHeaderViewInfo;
  protected
    function GetFooterPainterClass: TcxGridFooterPainterClass; override;
    function GetHeaderViewInfoClass: TcxGridHeaderViewInfoClass; override;
    function GetHeaderViewInfoSpecificClass: TcxGridHeaderViewInfoSpecificClass; override;
    function GetRecordsViewInfoClass: TcxCustomGridRecordsViewInfoClass; override;
    function GetScrollableAreaBoundsForEdit: TRect; override;
    function GetScrollableAreaBoundsHorz: TRect; override;
    property Controller: TcxGridBandedTableController read GetController;
  public
    function CanOffset(ARecordCountDelta, DX, DY: Integer): Boolean; override;
    function GetCellHeight(AIndex, ACellHeight: Integer): Integer; override;
    function GetCellTopOffset(AIndex, ACellHeight: Integer): Integer; override;
    property FixedBandSeparatorColor: TColor read GetFixedBandSeparatorColor;
    property FixedBandSeparatorWidth: Integer read GetFixedBandSeparatorWidth;
    property GridView: TcxGridBandedTableView read GetGridView;
    property HeaderViewInfo: TcxGridBandedHeaderViewInfo read GetHeaderViewInfo;
  end;

  { column }

  TcxGridBandedColumnOptions = class(TcxGridColumnOptions)
  private
    FVertSizing: Boolean;
    procedure SetVertSizing(Value: Boolean);
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(AItem: TcxCustomGridTableItem); override;
  published
    property VertSizing: Boolean read FVertSizing write SetVertSizing default True;
  end;

  TcxGridBandedColumnStyles = class(TcxGridColumnStyles)
  private
    function GetItem: TcxGridBandedColumn;
  protected
    procedure GetDefaultViewParams(Index: Integer; AData: TObject; out AParams: TcxViewParams); override;
  public
    property Item: TcxGridBandedColumn read GetItem;
  end;

  TcxGridBandedColumnPosition = class(TcxCustomGridTableItemCustomOptions)
  private
    FBand: TcxGridBand;
    FBandIndex: Integer;
    FColIndex: Integer;
    FLineCount: Integer;
    FRowIndex: Integer;
    function GetBandIndex: Integer;
    function GetColIndex: Integer;
    function GetGridView: TcxGridBandedTableView;
    function GetItem: TcxGridBandedColumn;
    function GetRow: TcxGridBandRow;
    function GetRowIndex: Integer;
    function GetVisibleBandIndex: Integer;
    function GetVisibleColIndex: Integer;
    function GetVisibleRowIndex: Integer;
    procedure SetBandIndex(Value: Integer);
    procedure SetColIndex(Value: Integer);
    procedure SetLineCount(Value: Integer);
    procedure SetRowIndex(Value: Integer);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure CheckLineCount(var Value: Integer);
    procedure SaveParams;
    property GridView: TcxGridBandedTableView read GetGridView;
    property Item: TcxGridBandedColumn read GetItem;
  public
    constructor Create(AItem: TcxCustomGridTableItem); override;
    procedure Assign(Source: TPersistent); override;
    property Band: TcxGridBand read FBand;
    property Row: TcxGridBandRow read GetRow;
    property VisibleBandIndex: Integer read GetVisibleBandIndex;
    property VisibleColIndex: Integer read GetVisibleColIndex;
    property VisibleRowIndex: Integer read GetVisibleRowIndex;
  published
    property BandIndex: Integer read GetBandIndex write SetBandIndex;
    property ColIndex: Integer read GetColIndex write SetColIndex;
    property LineCount: Integer read FLineCount write SetLineCount default 1;
    property RowIndex: Integer read GetRowIndex write SetRowIndex;
  end;

  TcxGridBandedColumn = class(TcxGridColumn)
  private
    FPosition: TcxGridBandedColumnPosition;
    function GetGridView: TcxGridBandedTableView;
    function GetOptions: TcxGridBandedColumnOptions;
    function GetStyles: TcxGridBandedColumnStyles;
    procedure SetOptions(Value: TcxGridBandedColumnOptions);
    procedure SetPosition(Value: TcxGridBandedColumnPosition);
    procedure SetStyles(Value: TcxGridBandedColumnStyles);
  protected
    // IcxStoredObject
    function GetStoredProperties(AProperties: TStrings): Boolean; override;
    procedure GetPropertyValue(const AName: string; var AValue: Variant); override;
    procedure SetPropertyValue(const AName: string; const AValue: Variant); override;

    procedure CreateSubClasses; override;
    procedure DestroySubClasses; override;
    procedure AssignColumnWidths; override;
    function CanScroll: Boolean; override;
    function CanVertSize: Boolean; virtual;
    function GetActuallyVisible: Boolean; override;
    function GetEditPartVisible: Boolean; override;
    function GetIsBottom: Boolean; override;
    function GetIsLeft: Boolean; override;
    function GetIsMostBottom: Boolean; override;
    function GetIsMostLeft: Boolean; override;
    function GetIsMostRight: Boolean; override;
    function GetIsRight: Boolean; override;
    function GetOptionsClass: TcxCustomGridTableItemOptionsClass; override;
    function GetStylesClass: TcxCustomGridTableItemStylesClass; override;
  public
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property GridView: TcxGridBandedTableView read GetGridView;
  published
    property Options: TcxGridBandedColumnOptions read GetOptions write SetOptions;
    property Position: TcxGridBandedColumnPosition read FPosition write SetPosition;
    property Styles: TcxGridBandedColumnStyles read GetStyles write SetStyles;
  end;

  { view }

  // row, rows, band, bands

  TcxGridBandRow = class
  private
    FBandRows: TcxGridBandRows;
    FItems: TList;
    FVisibleItems: TList;
    function GetCount: Integer;
    function GetIndex: Integer;
    function GetIsFirst: Boolean;
    function GetIsLast: Boolean;
    function GetItem(Index: Integer): TcxGridBandedColumn;
    function GetLineCount: Integer;
    function GetLineOffset: Integer;
    function GetVisible: Boolean;
    function GetVisibleCount: Integer;
    function GetVisibleIndex: Integer;
    function GetVisibleItem(Index: Integer): TcxGridBandedColumn;
  protected
    procedure CheckIndexForInsert(var AIndex: Integer; AExistingItem: Boolean);
    procedure RefreshVisibleItemsList;
  public
    constructor Create(ABandRows: TcxGridBandRows);
    destructor Destroy; override;
    procedure ApplyBestFit;
    procedure Delete(AIndex: Integer);
    function IndexOf(AColumn: TcxGridBandedColumn): Integer;
    procedure Insert(AIndex: Integer; AColumn: TcxGridBandedColumn);
    procedure Move(ACurIndex, ANewIndex: Integer);
    function VisibleIndexOf(AColumn: TcxGridBandedColumn): Integer;

    property BandRows: TcxGridBandRows read FBandRows;
    property Count: Integer read GetCount;
    property Index: Integer read GetIndex;
    property IsFirst: Boolean read GetIsFirst;
    property IsLast: Boolean read GetIsLast;
    property Items[Index: Integer]: TcxGridBandedColumn read GetItem; default;
    property LineCount: Integer read GetLineCount;
    property LineOffset: Integer read GetLineOffset;
    property Visible: Boolean read GetVisible;
    property VisibleCount: Integer read GetVisibleCount;
    property VisibleIndex: Integer read GetVisibleIndex;
    property VisibleItems[Index: Integer]: TcxGridBandedColumn read GetVisibleItem;
  end;

  TcxGridBandRows = class
  private
    FBand: TcxGridBand;
    FItems: TList;
    FVisibleItems: TList;
    function GetCount: Integer;
    function GetFirstVisible: TcxGridBandRow;
    function GetGridView: TcxGridBandedTableView;
    function GetItem(Index: Integer): TcxGridBandRow;
    function GetLastVisible: TcxGridBandRow;
    function GetVisibleCount: Integer;
    function GetVisibleItem(Index: Integer): TcxGridBandRow;
    procedure SetCount(Value: Integer);
    procedure RemoveItem(ARow: TcxGridBandRow);
  protected
    procedure ColumnVisibilityChanged(AColumn: TcxGridBandedColumn);
    procedure RefreshVisibleItemsList;
    property GridView: TcxGridBandedTableView read GetGridView;
  public
    constructor Create(ABand: TcxGridBand); virtual;
    destructor Destroy; override;
    procedure ApplyBestFit;
    function GetLineIndex(ARowIndex: Integer): Integer;
    function GetRowIndex(ALineIndex: Integer): Integer;
    function IndexOf(AColumn: TcxGridBandedColumn): Integer;
    function Insert(AIndex: Integer): TcxGridBandRow;
    procedure MoveColumn(AColumn: TcxGridBandedColumn; ARowIndex, AColIndex: Integer);

    property Band: TcxGridBand read FBand;
    property Count: Integer read GetCount write SetCount;
    property FirstVisible: TcxGridBandRow read GetFirstVisible;
    property Items[Index: Integer]: TcxGridBandRow read GetItem; default;
    property LastVisible: TcxGridBandRow read GetLastVisible;
    property VisibleCount: Integer read GetVisibleCount;
    property VisibleItems[Index: Integer]: TcxGridBandRow read GetVisibleItem;
  end;

  TcxGridBandOptionsClass = class of TcxGridBandOptions;

  TcxGridBandOptions = class(TPersistent)
  private
    FBand: TcxGridBand;
    FHoldOwnColumnsOnly: Boolean;
    FMoving: Boolean;
    FSizing: Boolean;
  protected
    property Band: TcxGridBand read FBand;
  public
    constructor Create(ABand: TcxGridBand); virtual;
    procedure Assign(Source: TPersistent); override;
  published
    property HoldOwnColumnsOnly: Boolean read FHoldOwnColumnsOnly write FHoldOwnColumnsOnly default False;
    property Moving: Boolean read FMoving write FMoving default True;
    property Sizing: Boolean read FSizing write FSizing default True;
  end;

  TcxGridBandGetHeaderStyle = procedure(Sender: TcxGridBandedTableView; ABand: TcxGridBand;
    {$IFDEF BCB}var{$ELSE}out{$ENDIF} AStyle: TcxStyle) of object;

  TcxGridBandStylesClass = class of TcxGridBandStyles;

  TcxGridBandStyles = class(TcxCustomGridStyles)
  private
    FOnGetHeaderStyle: TcxGridBandGetHeaderStyle;
    function GetBand: TcxGridBand;
    function GetGridViewValue: TcxGridBandedTableView;
  protected
    procedure GetDefaultViewParams(Index: Integer; AData: TObject; out AParams: TcxViewParams); override;
    function GetGridView: TcxCustomGridView; override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure GetHeaderParams(out AParams: TcxViewParams); virtual;
    property Band: TcxGridBand read GetBand;
    property GridView: TcxGridBandedTableView read GetGridViewValue;
  published
    property Background: TcxStyle index bsBackground read GetValue write SetValue;
    property Content: TcxStyle index bsContent read GetValue write SetValue;
    property Header: TcxStyle index bsHeader read GetValue write SetValue;
    property OnGetHeaderStyle: TcxGridBandGetHeaderStyle read FOnGetHeaderStyle
      write FOnGetHeaderStyle;
  end;

  TcxGridBandClass = class of TcxGridBand;

  TcxGridBand = class(TcxInterfacedCollectionItem, IcxStoredObject)
  private
    FCaption: string;
    FColumns: TList;
    FFixedKind: TcxGridBandFixedKind;
    FHeaderAlignmentHorz: TAlignment;
    FHeaderAlignmentVert: TcxAlignmentVert;
    FHidden: Boolean;
    FOptions: TcxGridBandOptions;
    FRows: TcxGridBandRows;
    FStyles: TcxGridBandStyles;
    FVisible: Boolean;
    FWidth: Integer;
    FSubClassEvents: TNotifyEvent;
    FOnHeaderClick: TNotifyEvent;
    function GetBands: TcxGridBands;
    function GetColumnCount: Integer;
    function GetColumn(Index: Integer): TcxGridBandedColumn;
    function GetGridView: TcxGridBandedTableView;
    function GetIsFirst: Boolean;
    function GetIsFirstNonEmpty: Boolean;
    function GetIsLast: Boolean;
    function GetIsLastNonEmpty: Boolean;
    function GetVisibleIndex: Integer;
    procedure SetCaption(const Value: string);
    procedure SetFixedKind(Value: TcxGridBandFixedKind);
    procedure SetHeaderAlignmentHorz(Value: TAlignment);
    procedure SetHeaderAlignmentVert(Value: TcxAlignmentVert);
    procedure SetHidden(Value: Boolean);
    procedure SetOptions(Value: TcxGridBandOptions);
    procedure SetStyles(Value: TcxGridBandStyles);
    procedure SetVisible(Value: Boolean);
    procedure SetWidth(Value: Integer);
    procedure AddColumn(AColumn: TcxGridBandedColumn);
    procedure RemoveColumn(AColumn: TcxGridBandedColumn);
  protected
    // IcxStoredObject
    function GetObjectName: string; virtual;
    function GetProperties(AProperties: TStrings): Boolean; virtual;
    procedure GetPropertyValue(const AName: string; var AValue: Variant); virtual;
    procedure SetPropertyValue(const AName: string; const AValue: Variant); virtual;

    function CanHide: Boolean; virtual;
    function CanMove: Boolean; virtual;
    function CanSize: Boolean; virtual;
    procedure ColumnVisibilityChanged(AColumn: TcxGridBandedColumn);
    procedure ForceWidth(Value: Integer); virtual;
    procedure HiddenChanged; virtual;
    function ColIndexOf(AColumn: TcxGridBandedColumn): Integer;
    function RowIndexOf(AColumn: TcxGridBandedColumn): Integer;
    procedure SetIndex(Value: Integer); override;

    function GetOptionsClass: TcxGridBandOptionsClass; virtual;
    function GetStylesClass: TcxGridBandStylesClass; virtual;

    procedure DoHeaderClick; virtual;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    procedure ApplyBestFit; virtual;
    procedure MoveColumn(AColumn: TcxGridBandedColumn; ARowIndex, AColIndex: Integer);

    property Bands: TcxGridBands read GetBands;
    property ColumnCount: Integer read GetColumnCount;
    property Columns[Index: Integer]: TcxGridBandedColumn read GetColumn;
    property GridView: TcxGridBandedTableView read GetGridView;
    property IsFirst: Boolean read GetIsFirst;
    property IsFirstNonEmpty: Boolean read GetIsFirstNonEmpty;
    property IsLast: Boolean read GetIsLast;
    property IsLastNonEmpty: Boolean read GetIsLastNonEmpty;
    property Rows: TcxGridBandRows read FRows;
    property VisibleIndex: Integer read GetVisibleIndex;
  published
    property Alignment: TAlignment read FHeaderAlignmentHorz write SetHeaderAlignmentHorz stored False;  // for compatibility
    property HeaderAlignmentHorz: TAlignment read FHeaderAlignmentHorz write SetHeaderAlignmentHorz default taCenter;
    property HeaderAlignmentVert: TcxAlignmentVert read FHeaderAlignmentVert write SetHeaderAlignmentVert default vaCenter;
    property Caption: string read FCaption write SetCaption;
    property FixedKind: TcxGridBandFixedKind read FFixedKind write SetFixedKind default fkNone;
    property Hidden: Boolean read FHidden write SetHidden default False;
    property Options: TcxGridBandOptions read FOptions write SetOptions;
    property Styles: TcxGridBandStyles read FStyles write SetStyles;
    property Visible: Boolean read FVisible write SetVisible default True;
    property Width: Integer read FWidth write SetWidth default 0;
    property StylesEvents: TNotifyEvent read FSubClassEvents write FSubClassEvents;
    property OnHeaderClick: TNotifyEvent read FOnHeaderClick write FOnHeaderClick;
  end;

  TcxGridBandsLayout = (blNonFixed, blLeftFixed, blRightFixed, blLeftRightFixed);

  TcxGridBandsClass = class of TcxGridBands;

  TcxGridBands = class(TcxOwnedInterfacedCollection, IcxStoredObject, IcxStoredParent)
  private
    FGridView: TcxGridBandedTableView;
    FVisibleItems: TList;
    FVisibleLeftFixedCount: Integer;
    FVisibleRightFixedCount: Integer;
    function GetFirstVisibleNonEmpty: TcxGridBand;
    function GetItem(Index: Integer): TcxGridBand;
    function GetLastVisibleNonEmpty: TcxGridBand;
    function GetLayout: TcxGridBandsLayout;
    function GetVisibleCount: Integer;
    function GetVisibleItem(Index: Integer): TcxGridBand;
    function GetVisibleRowCount: Integer;
    procedure SetItem(Index: Integer; Value: TcxGridBand);
    procedure AddItem(AItem: TcxGridBand);
    procedure RemoveItem(AItem: TcxGridBand);
    procedure RefreshVisibleItemsList;
  protected
    // IcxStoredObject
    function GetObjectName: string; virtual;
    function GetProperties(AProperties: TStrings): Boolean; virtual;
    procedure GetPropertyValue(const AName: string; var AValue: Variant); virtual;
    procedure SetPropertyValue(const AName: string; const AValue: Variant); virtual;
    // IcxStoredParent
    function CreateChild(const AObjectName, AClassName: string): TObject; virtual;
    procedure DeleteChild(const AObjectName: string; AObject: TObject); virtual;
    procedure GetChildren(AChildren: TStringList); virtual;

    function GetBandClass: TcxGridBandClass; virtual;
  public
    constructor Create(AGridView: TcxGridBandedTableView); virtual;
    destructor Destroy; override;
    function Add: TcxGridBand;
    function GetFirstVisibleIndex(AFixedKind: TcxGridBandFixedKind): Integer;
    function GetLastVisibleIndex(AFixedKind: TcxGridBandFixedKind): Integer;

    property FirstVisibleNonEmpty: TcxGridBand read GetFirstVisibleNonEmpty;
    property GridView: TcxGridBandedTableView read FGridView;
    property Items[Index: Integer]: TcxGridBand read GetItem write SetItem; default;
    property Layout: TcxGridBandsLayout read GetLayout;
    property LastVisibleNonEmpty: TcxGridBand read GetLastVisibleNonEmpty;
    property VisibleCount: Integer read GetVisibleCount;
    property VisibleItems[Index: Integer]: TcxGridBand read GetVisibleItem;
    property VisibleLeftFixedCount: Integer read FVisibleLeftFixedCount;
    property VisibleRightFixedCount: Integer read FVisibleRightFixedCount;
    property VisibleRowCount: Integer read GetVisibleRowCount;
  end;

  // options

  TcxGridBandedTableBackgroundBitmaps = class(TcxGridTableBackgroundBitmaps)
  protected
    function GetBitmapStyleIndex(Index: Integer): Integer; override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property BandBackground: TBitmap index bbBandBackground read GetValue write SetValue;
    property BandHeader: TBitmap index bbBandHeader read GetValue write SetValue;
  end;

  TcxGridBandedTableOptionsCustomize = class(TcxGridTableOptionsCustomize)
  private
    FBandHiding: Boolean;
    FBandMoving: Boolean;
    FBandSizing: Boolean;
    FColumnVertSizing: Boolean;
    procedure SetColumnVertSizing(Value: Boolean);
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    procedure Assign(Source: TPersistent); override;
  published
    property BandHiding: Boolean read FBandHiding write FBandHiding default False;
    property BandMoving: Boolean read FBandMoving write FBandMoving default True;
    property BandSizing: Boolean read FBandSizing write FBandSizing default True;
    property ColumnVertSizing: Boolean read FColumnVertSizing write SetColumnVertSizing default True;
  end;

  TcxGridBandedTableOptionsView = class(TcxGridTableOptionsView)
  private
    FBandHeaderEndEllipsis: Boolean;
    FBandHeaderHeight: Integer;
    FBandHeaderLineCount: Integer;
    FBandHeaders: Boolean;
    FFixedBandSeparatorColor: TColor;
    FFixedBandSeparatorWidth: Integer;
    procedure SetBandHeaderEndEllipsis(Value: Boolean);
    procedure SetBandHeaderHeight(Value: Integer);
    procedure SetBandHeaderLineCount(Value: Integer);
    procedure SetBandHeaders(Value: Boolean);
    procedure SetFixedBandSeparatorColor(Value: TColor);
    procedure SetFixedBandSeparatorWidth(Value: Integer);
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    procedure Assign(Source: TPersistent); override;
    function GetFixedBandSeparatorColor: TColor;
  published
    property BandHeaderEndEllipsis: Boolean read FBandHeaderEndEllipsis
      write SetBandHeaderEndEllipsis default False;
    property BandHeaderHeight: Integer read FBandHeaderHeight write SetBandHeaderHeight default 0;
    property BandHeaderLineCount: Integer read FBandHeaderLineCount write SetBandHeaderLineCount default 1;
    property BandHeaders: Boolean read FBandHeaders write SetBandHeaders default True;
    property FixedBandSeparatorColor: TColor read FFixedBandSeparatorColor
      write SetFixedBandSeparatorColor default clDefault;
    property FixedBandSeparatorWidth: Integer read FFixedBandSeparatorWidth
      write SetFixedBandSeparatorWidth default cxGridDefaultFixedBandSeparatorWidth;
  end;

  // styles

  TcxGridBandedTableViewStyles = class(TcxGridTableViewStyles)
  private
    FOnGetBandHeaderStyle: TcxGridBandGetHeaderStyle;
    function GetGridViewValue: TcxGridBandedTableView;
  protected
    procedure GetDefaultViewParams(Index: Integer; AData: TObject; out AParams: TcxViewParams); override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure GetBandHeaderParams(ABand: TcxGridBand; out AParams: TcxViewParams); virtual;
    property GridView: TcxGridBandedTableView read GetGridViewValue;
  published
    property BandBackground: TcxStyle index vsBandBackground read GetValue write SetValue;
    property BandHeader: TcxStyle index vsBandHeader read GetValue write SetValue;
    property OnGetBandHeaderStyle: TcxGridBandGetHeaderStyle read FOnGetBandHeaderStyle
      write FOnGetBandHeaderStyle;
  end;

  TcxGridBandedTableViewStyleSheet = class(TcxCustomStyleSheet)
  private
    function GetStylesValue: TcxGridBandedTableViewStyles;
    procedure SetStylesValue(Value: TcxGridBandedTableViewStyles);
  public
    class function GetStylesClass: TcxCustomStylesClass; override;
  published
    property Styles: TcxGridBandedTableViewStyles read GetStylesValue write SetStylesValue;
  end;

  // grid view

  TcxGridBandCustomDrawHeaderEvent = procedure(Sender: TcxGridBandedTableView;
    ACanvas: TcxCanvas; AViewInfo: TcxGridBandHeaderViewInfo; var ADone: Boolean) of object;
  TcxGridBandEvent = procedure(Sender: TcxGridBandedTableView; ABand: TcxGridBand) of object;

  TcxGridBandedTableView = class(TcxGridTableView)
  private
    FBands: TcxGridBands;
    FOnBandPosChanged: TcxGridBandEvent;
    FOnBandSizeChanged: TcxGridBandEvent;
    FOnCustomDrawBandHeader: TcxGridBandCustomDrawHeaderEvent;
    function GetBackgroundBitmaps: TcxGridBandedTableBackgroundBitmaps;
    function GetColumn(Index: Integer): TcxGridBandedColumn;
    function GetController: TcxGridBandedTableController;
    function GetGroupedColumn(Index: Integer): TcxGridBandedColumn;
    function GetOptionsCustomize: TcxGridBandedTableOptionsCustomize;
    function GetOptionsView: TcxGridBandedTableOptionsView;
    function GetStyles: TcxGridBandedTableViewStyles;
    function GetViewInfo: TcxGridBandedTableViewInfo;
    function GetVisibleColumn(Index: Integer): TcxGridBandedColumn;
    procedure SetBackgroundBitmaps(Value: TcxGridBandedTableBackgroundBitmaps);
    procedure SetBands(Value: TcxGridBands);
    procedure SetColumn(Index: Integer; Value: TcxGridBandedColumn);
    procedure SetOptionsCustomize(Value: TcxGridBandedTableOptionsCustomize);
    procedure SetOptionsView(Value: TcxGridBandedTableOptionsView);
    procedure SetStyles(Value: TcxGridBandedTableViewStyles);
  protected
    // IcxStoredParent
    procedure GetStoredChildren(AChildren: TStringList); override;

    procedure ReadState(Reader: TReader); override;
    procedure Updated; override;
    procedure Updating; override;

    procedure DoAssign(ASource: TcxCustomGridView); override;
    procedure GetFakeComponentLinks(AList: TList); override;
    function HasCustomDrawBandHeader: Boolean;

    procedure CreateOptions; override;
    procedure DestroyOptions; override;

    procedure AddItem(AItem: TcxCustomGridTableItem); override;
    procedure AssignColumnParams;
    procedure ItemVisibilityChanged(AItem: TcxCustomGridTableItem; Value: Boolean); override;
    procedure LoadingComplete; override;
    procedure RefreshVisibleItemsList; override;
    procedure RestoringComplete; override;

    function GetBackgroundBitmapsClass: TcxCustomGridBackgroundBitmapsClass; override;
    function GetBandsClass: TcxGridBandsClass; virtual;
    function GetControllerClass: TcxCustomGridControllerClass; override;
    function GetItemClass: TcxCustomGridTableItemClass; override;
    function GetOptionsCustomizeClass: TcxCustomGridTableOptionsCustomizeClass; override;
    function GetOptionsViewClass: TcxCustomGridOptionsViewClass; override;
    function GetPainterClass: TcxCustomGridPainterClass; override;
    function GetStylesClass: TcxCustomGridViewStylesClass; override;
    function GetViewInfoClass: TcxCustomGridViewInfoClass; override;

    procedure DoBandPosChanged(ABand: TcxGridBand); virtual;
    procedure DoBandSizeChanged(ABand: TcxGridBand); virtual;
    procedure DoCustomDrawBandHeader(ACanvas: TcxCanvas; AViewInfo: TcxGridBandHeaderViewInfo;
      var ADone: Boolean); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    function CreateColumn: TcxGridBandedColumn;
    
    property Columns[Index: Integer]: TcxGridBandedColumn read GetColumn write SetColumn;
    property Controller: TcxGridBandedTableController read GetController;
    property GroupedColumns[Index: Integer]: TcxGridBandedColumn read GetGroupedColumn;
    property ViewInfo: TcxGridBandedTableViewInfo read GetViewInfo;
    property VisibleColumns[Index: Integer]: TcxGridBandedColumn read GetVisibleColumn;
  published
    property BackgroundBitmaps: TcxGridBandedTableBackgroundBitmaps read GetBackgroundBitmaps
      write SetBackgroundBitmaps;
    property Bands: TcxGridBands read FBands write SetBands;
    property OptionsCustomize: TcxGridBandedTableOptionsCustomize read GetOptionsCustomize write SetOptionsCustomize;
    property OptionsView: TcxGridBandedTableOptionsView read GetOptionsView write SetOptionsView;
    property Styles: TcxGridBandedTableViewStyles read GetStyles write SetStyles;
    property OnBandPosChanged: TcxGridBandEvent read FOnBandPosChanged write FOnBandPosChanged;
    property OnBandSizeChanged: TcxGridBandEvent read FOnBandSizeChanged write FOnBandSizeChanged;
    property OnCustomDrawBandHeader: TcxGridBandCustomDrawHeaderEvent read FOnCustomDrawBandHeader write FOnCustomDrawBandHeader;
  end;

implementation

uses
{$IFDEF DELPHI6}
  Variants,
{$ENDIF}
  SysUtils, Math, cxGridStrs, cxGridViewData, cxCustomData, cxLibraryConsts;

const
  ColumnHeaderInsertZoneSize = 20;
  BandHeaderMovingZoneSize = 20;
  BandSizingMarkWidth = 2;

  BandHeaderHitTests = [htBandHeader, htBandHeaderSizingEdge];

type
  TcxCustomGridCellViewInfoAccess = class(TcxCustomGridCellViewInfo);

function CompareVisibleColumnPositions(Item1, Item2: Pointer): Integer;
var
  APosition1, APosition2: TcxGridBandedColumnPosition;
begin
  APosition1 := TcxGridBandedColumnPosition(Item1);
  APosition2 := TcxGridBandedColumnPosition(Item2);
  Result := APosition1.Band.VisibleIndex - APosition2.Band.VisibleIndex;
  if Result = 0 then
  begin
    Result := APosition1.VisibleRowIndex - APosition2.VisibleRowIndex;
    if Result = 0 then
    begin
      Result := APosition1.VisibleColIndex - APosition2.VisibleColIndex;
      if Result = 0 then
        Result := APosition1.Item.VisibleIndex - APosition2.Item.VisibleIndex;
    end;
  end;
end;

{ TcxGridColumnHeaderVertSizingEdgeHitTest }

class function TcxGridColumnHeaderVertSizingEdgeHitTest.GetHitTestCode: Integer;
begin
  Result := htColumnHeaderVertSizingEdge;
end;

class function TcxGridColumnHeaderVertSizingEdgeHitTest.Cursor: TCursor;
begin
  Result := crcxGridVertSize;
end;

function TcxGridColumnHeaderVertSizingEdgeHitTest.DragAndDropObjectClass: TcxCustomGridDragAndDropObjectClass;
begin
  Result := TcxGridColumnVertSizingObject;
end;

{ TcxGridBandHitTest }

class function TcxGridBandHitTest.GetHitTestCode: Integer;
begin
  Result := htBand;
end;

{ TcxGridBandHeaderHitTest }

class function TcxGridBandHeaderHitTest.GetHitTestCode: Integer;
begin
  Result := htBandHeader;
end;

function TcxGridBandHeaderHitTest.DragAndDropObjectClass: TcxCustomGridDragAndDropObjectClass;
begin
  if Band.CanMove then
    Result := TcxGridBandHeaderMovingObject
  else
    Result := nil;
end;

{ TcxGridBandHeaderSizingEdgeHitTest }

class function TcxGridBandHeaderSizingEdgeHitTest.GetHitTestCode: Integer;
begin
  Result := htBandHeaderSizingEdge;
end;

class function TcxGridBandHeaderSizingEdgeHitTest.Cursor: TCursor;
begin
  Result := crcxGridHorzSize;
end;

function TcxGridBandHeaderSizingEdgeHitTest.DragAndDropObjectClass: TcxCustomGridDragAndDropObjectClass;
begin
  Result := TcxGridBandSizingObject;
end;

{ TcxGridBandedColumnHeaderMovingObject }

function TcxGridBandedColumnHeaderMovingObject.GetDestZone: TcxGridBandedColumnContainerZone;
begin
  Result := TcxGridBandedColumnContainerZone(inherited DestZone);
end;

function TcxGridBandedColumnHeaderMovingObject.GetSourceColumn: TcxGridBandedColumn;
begin
  Result := TcxGridBandedColumn(inherited SourceColumn);
end;

function TcxGridBandedColumnHeaderMovingObject.GetSourcePosition: TcxGridBandedColumnPosition;
begin
  Result := TcxGridBandedColumn(SourceColumn).Position;
end;

function TcxGridBandedColumnHeaderMovingObject.GetViewInfo: TcxGridBandedTableViewInfo;
begin
  Result := TcxGridBandedTableViewInfo(inherited ViewInfo);
end;

procedure TcxGridBandedColumnHeaderMovingObject.SetSourceColumn(Value: TcxGridBandedColumn);
begin
  inherited SourceColumn := Value;
end;

function TcxGridBandedColumnHeaderMovingObject.AreArrowsVertical: Boolean;
begin
  if (DestColumnContainerKind = ccHeader) and (DestZone.ColumnIndex = -1) then
    Result := False
  else
    Result := inherited AreArrowsVertical;
end;

procedure TcxGridBandedColumnHeaderMovingObject.DoColumnMoving;

  function GetRowIndex: Integer;
  var
    ABand: TcxGridBand;
  begin
    ABand := DestZone.Band;
    if DestZone.RowIndex = ABand.Rows.VisibleCount then
      Result := ABand.Rows.Count
    else
      Result := ABand.Rows.VisibleItems[DestZone.RowIndex].Index;
  end;

  function GetColIndex: Integer;
  var
    ARow: TcxGridBandRow;
  begin
    ARow := SourcePosition.Row;
    if DestZone.ColIndex = ARow.VisibleCount then
      Result := ARow.Count
    else
      Result := ARow.VisibleItems[DestZone.ColIndex].Position.ColIndex;
  end;

begin
  with TcxGridBandedColumn(SourceColumn) do
  begin
    Position.BandIndex := DestZone.Band.Index;
    if DestZone.IsInsertion then
      Position.Band.Rows.Insert(GetRowIndex);
    Position.RowIndex := GetRowIndex;
    Position.ColIndex := GetColIndex;
  end;
end;

function TcxGridBandedColumnHeaderMovingObject.GetArrowAreaBoundsForHeader(APlace: TcxGridArrowPlace): TRect;
var
  ARowsViewInfo: TcxGridBandRowsViewInfo;
  AColumn: TcxGridBandedColumn;
begin
  if DestZone.IsInsertion then
  begin
    ARowsViewInfo := ViewInfo.HeaderViewInfo.BandsViewInfo[DestZone.Band.VisibleIndex].RowsViewInfo;
    Result := ARowsViewInfo.Bounds;
    if DestZone.RowIndex > 0 then
      Result.Top := ARowsViewInfo[DestZone.RowIndex - 1].Bounds.Bottom;
  end
  else
  begin
    Result := inherited GetArrowAreaBoundsForHeader(APlace);
    AColumn := TcxGridBandedColumn(GridView.VisibleColumns[DestZone.ColumnIndex]);
    if DestZone.ColIndex <> AColumn.Position.VisibleColIndex then
      Result.Left := Result.Right;
  end;
end;

function TcxGridBandedColumnHeaderMovingObject.GetArrowsClientRect: TRect;
begin
  Result := inherited GetArrowsClientRect;
  if (DestColumnContainerKind = ccHeader) and (DestZone.Band.FixedKind = fkNone) then
    Result := ViewInfo.ScrollableAreaBoundsHorz;
end;

function TcxGridBandedColumnHeaderMovingObject.IsValidDestination: Boolean;
begin
  Result := inherited IsValidDestination;
  if Result and (DestColumnContainerKind = ccHeader) and
    (DestZone.Band.Options.HoldOwnColumnsOnly or
     (SourceColumn.Position.Band <> nil) and SourceColumn.Position.Band.Options.HoldOwnColumnsOnly) then
    Result := SourceColumn.Position.Band = DestZone.Band;
end;

function TcxGridBandedColumnHeaderMovingObject.IsValidDestinationForVisibleSource: Boolean;

  function IsValidForInsertion: Boolean;
  begin
    Result :=
      (SourcePosition.Row.VisibleCount <> 1) or
      (DestZone.RowIndex < SourcePosition.VisibleRowIndex) or
      (SourcePosition.VisibleRowIndex + 1 < DestZone.RowIndex);
  end;

  function IsValidForMoving: Boolean;
  begin
    Result :=
      (DestZone.RowIndex <> SourcePosition.VisibleRowIndex) or
      (DestZone.ColIndex < SourcePosition.VisibleColIndex) or
      (SourcePosition.VisibleColIndex + 1 < DestZone.ColIndex);
  end;

begin
  if DestColumnContainerKind = ccHeader then
    Result :=
      (DestZone.Band <> SourcePosition.Band) or
      DestZone.IsInsertion and IsValidForInsertion or
      not DestZone.IsInsertion and IsValidForMoving
  else
    Result := inherited IsValidDestinationForVisibleSource;
end;

{ TcxGridBandHeaderMovingObject }

constructor TcxGridBandHeaderMovingObject.Create(AControl: TcxControl);
begin
  inherited;
  FDestBandIndex := -1;
end;

function TcxGridBandHeaderMovingObject.GetController: TcxGridBandedTableController;
begin
  Result := TcxGridBandedTableController(inherited Controller);
end;

function TcxGridBandHeaderMovingObject.GetCustomizationForm: TcxGridBandedTableCustomizationForm;
begin
  Result := TcxGridBandedTableCustomizationForm(inherited CustomizationForm);
end;

function TcxGridBandHeaderMovingObject.GetGridView: TcxGridBandedTableView;
begin
  Result := TcxGridBandedTableView(inherited GridView);
end;

function TcxGridBandHeaderMovingObject.GetViewInfo: TcxGridBandedTableViewInfo;
begin
  Result := TcxGridBandedTableViewInfo(inherited ViewInfo);
end;

procedure TcxGridBandHeaderMovingObject.SetDestBandContainerKind(Value: TcxGridBandContainerKind);
begin
  if FDestBandContainerKind <> Value then
  begin
    Dirty := True;
    FDestBandContainerKind := Value;
  end;
end;

procedure TcxGridBandHeaderMovingObject.SetDestBandIndex(Value: Integer);
begin
  if FDestBandIndex <> Value then
  begin
    Dirty := True;
    FDestBandIndex := Value;
  end;
end;

function TcxGridBandHeaderMovingObject.CanRemove: Boolean;
begin
  Result := (SourceBandContainerKind = bcHeader) and SourceBand.CanHide and
    (GridView.OptionsCustomize.BandHiding or GridView.Controller.Customization);
end;

function TcxGridBandHeaderMovingObject.GetArrowAreaBounds(APlace: TcxGridArrowPlace): TRect;

  function GetBandIndex: Integer;
  begin
    Result := DestBandIndex;
    if (Result <> 0) and
      (Result = GridView.Bands.GetLastVisibleIndex(SourceBand.FixedKind) + 1) then
      Dec(Result);
  end;

begin
  Result := ViewInfo.HeaderViewInfo.BandsViewInfo[GetBandIndex].HeaderViewInfo.Bounds;
  if DestBandIndex <> GetBandIndex then
    Result.Left := Result.Right;
end;

function TcxGridBandHeaderMovingObject.GetArrowsClientRect: TRect;
begin
  Result := inherited GetArrowsClientRect;
  if (DestBandContainerKind = bcHeader) and (SourceBand.FixedKind = fkNone) then
    Result := ViewInfo.ScrollableAreaBoundsHorz;
end;

function TcxGridBandHeaderMovingObject.GetCustomizationFormListBox: TcxCustomGridTableItemsListBox;
begin
  Result := CustomizationForm.BandsListBox;
end;

function TcxGridBandHeaderMovingObject.GetSourceItem: TObject;
begin
  Result := SourceBand;
end;

function TcxGridBandHeaderMovingObject.GetSourceItemViewInfo: TcxCustomGridCellViewInfo;
begin
  if SourceBandContainerKind = bcHeader then
    Result := ViewInfo.HeaderViewInfo.BandsViewInfo[SourceBand.VisibleIndex].HeaderViewInfo
  else
    Result := inherited GetSourceItemViewInfo;
end;

function TcxGridBandHeaderMovingObject.IsSourceCustomizationForm: Boolean;
begin
  Result := SourceBandContainerKind = bcCustomizationForm;
end;

function TcxGridBandHeaderMovingObject.IsValidDestination: Boolean;
begin
  Result :=
    (DestBandIndex <> -1) and
    (GridView.Bands.GetFirstVisibleIndex(SourceBand.FixedKind) <= DestBandIndex) and
    (DestBandIndex <= GridView.Bands.GetLastVisibleIndex(SourceBand.FixedKind) + 1) and
    (not SourceBand.Visible or
     (DestBandIndex < SourceBand.VisibleIndex) or (SourceBand.VisibleIndex + 1 < DestBandIndex));
end;

procedure TcxGridBandHeaderMovingObject.BeginDragAndDrop;
begin
  if CustomizationForm <> nil then
    with CustomizationForm do
      ActivatePage(BandsPage);
  Controller.FMovingBand := SourceBand;
  inherited;
end;

procedure TcxGridBandHeaderMovingObject.DragAndDrop(const P: TPoint; var Accepted: Boolean);
var
  AHitTest: TcxCustomGridHitTest;
begin
  AHitTest := ViewInfo.GetHitTest(P);
  if AHitTest.HitTestCode = htCustomizationForm then
  begin
    DestBandContainerKind := bcCustomizationForm;
    DestBandIndex := -1;
  end
  else
  begin
    DestBandContainerKind := bcHeader;
    DestBandIndex := ViewInfo.HeaderViewInfo.BandsViewInfo.IndexAtPos(P);
  end;
  Accepted := (DestBandIndex <> -1) or (DestBandContainerKind = bcCustomizationForm);
  inherited;
end;

procedure TcxGridBandHeaderMovingObject.EndDragAndDrop(Accepted: Boolean);
var
  ABandPosChanged: Boolean;

  function GetBandIndex: Integer;
  begin
    with GridView.Bands do
      if DestBandIndex = 0 then
        Result := 0
      else
        if DestBandIndex = VisibleCount then
          Result := Count
        else
          if VisibleItems[DestBandIndex].FixedKind = SourceBand.FixedKind then
            Result := VisibleItems[DestBandIndex].Index
          else
            Result := VisibleItems[DestBandIndex - 1].Index + 1;
    if SourceBand.Index < Result then Dec(Result);
  end;

begin
  inherited;
  Controller.FMovingBand := nil;
  if Accepted then
  begin
    ABandPosChanged := False;
    if DestBandIndex = -1 then
      if CanRemove then
      begin
        SourceBand.Visible := False;
        ABandPosChanged := True;
      end
      else
    else
      if IsValidDestination then
      begin
        SourceBand.Index := GetBandIndex;
        SourceBand.Visible := True;
        ABandPosChanged := True;
      end;
    if ABandPosChanged then
      GridView.DoBandPosChanged(SourceBand);  
  end;
end;

procedure TcxGridBandHeaderMovingObject.Init(const P: TPoint; AParams: TcxCustomGridHitTest);
begin
  inherited;
  with AParams as TcxGridBandHeaderHitTest do
  begin
    SourceBand := Band;
    SourceBandContainerKind := BandContainerKind;
  end;  
end;

{ TcxGridColumnVertSizingObject }

function TcxGridColumnVertSizingObject.GetColumn: TcxGridBandedColumn;
begin
  Result := TcxGridBandedColumn(inherited Column);
end;

function TcxGridColumnVertSizingObject.GetController: TcxGridBandedTableController;
begin
  Result := TcxGridBandedTableController(inherited Controller);
end;

function TcxGridColumnVertSizingObject.GetLineHeight: Integer;
begin
  Result := ViewInfo.HeaderViewInfo.ItemHeight;
end;

function TcxGridColumnVertSizingObject.GetCurrentSize: Integer;
begin
  Result := MulDiv(inherited GetCurrentSize, 1, LineHeight);
  Column.Position.CheckLineCount(Result);
  Result := Result * LineHeight;
end;

function TcxGridColumnVertSizingObject.GetIsHorizontalSizing: Boolean;
begin
  Result := False;
end;

procedure TcxGridColumnVertSizingObject.BeginDragAndDrop;
begin
  OriginalSize := ColumnHeaderViewInfo.Height;
  Controller.FVertSizingColumn := Column;
  inherited;
end;

procedure TcxGridColumnVertSizingObject.EndDragAndDrop(Accepted: Boolean);
begin
  inherited;
  if Accepted then
  begin
    Column.Position.LineCount := CurrentSize div LineHeight;
    TcxGridBandedTableView(GridView).DoColumnSizeChanged(Column);
  end;
  Controller.FVertSizingColumn := nil;
end;

{ TcxGridBandSizingObject }

function TcxGridBandSizingObject.GetBandViewInfo: TcxGridBandViewInfo;
begin
  Result := TcxGridBandedTableViewInfo(ViewInfo).HeaderViewInfo.BandsViewInfo[Band.VisibleIndex];
end;

function TcxGridBandSizingObject.GetController: TcxGridBandedTableController;
begin
  Result := TcxGridBandedTableController(inherited Controller);
end;

function TcxGridBandSizingObject.GetGridView: TcxGridBandedTableView;
begin
  Result := TcxGridBandedTableView(inherited GridView);
end;

function TcxGridBandSizingObject.GetCurrentSize: Integer;
begin
  Result := inherited GetCurrentSize;
  BandViewInfo.CheckWidth(Result);
end;

function TcxGridBandSizingObject.GetSizingItemBounds: TRect;
begin
  Result := BandViewInfo.ContentBounds;
end;

function TcxGridBandSizingObject.GetSizingMarkWidth: Integer;
begin
  Result := BandSizingMarkWidth;
end;

procedure TcxGridBandSizingObject.BeginDragAndDrop;
begin
  OriginalSize := BandViewInfo.ContentWidth;
  Controller.FSizingBand := Band;
  inherited;
end;

procedure TcxGridBandSizingObject.EndDragAndDrop(Accepted: Boolean);
begin
  inherited;
  if Accepted and (CurrentSize <> OriginalSize) then
  begin
    Band.ForceWidth(CurrentSize);
    GridView.DoBandSizeChanged(Band);
  end;  
  Controller.FSizingBand := nil;
end;

procedure TcxGridBandSizingObject.Init(const P: TPoint; AParams: TcxCustomGridHitTest);
begin
  inherited;
  Band := (AParams as TcxGridBandHeaderSizingEdgeHitTest).Band;
end;

{ TcxGridBandedTableBandsListBox }

function TcxGridBandedTableBandsListBox.GetGridView: TcxGridBandedTableView;
begin
  Result := TcxGridBandedTableView(inherited GridView);
end;

function TcxGridBandedTableBandsListBox.GetDragAndDropParams: TcxCustomGridHitTest;
begin
  Result := TcxGridBandHeaderHitTest.Instance(Point(-1, -1));
  with TcxGridBandHeaderHitTest(Result) do
  begin
    GridView := Self.GridView;
    Band := TcxGridBand(DragAndDropItem);
    BandContainerKind := bcCustomizationForm;
  end;
end;

procedure TcxGridBandedTableBandsListBox.RefreshItems;
var
  I: Integer;
  ABand: TcxGridBand;
begin
  with Items do
  begin
    BeginUpdate;
    try
      Clear;
      for I := 0 to GridView.Bands.Count - 1 do
      begin
        ABand := GridView.Bands[I];
        if not ABand.Hidden and not ABand.Visible then
          AddObject(ABand.Caption, ABand);
      end;
    finally
      EndUpdate;
    end;
  end;
end;

{ TcxGridBandedTableCustomizationForm }

function TcxGridBandedTableCustomizationForm.GetGridView: TcxGridBandedTableView;
begin
  Result := TcxGridBandedTableView(inherited GridView);
end;

procedure TcxGridBandedTableCustomizationForm.CreateControls;

  procedure CreateBandsListBox;
  begin
    FBandsListBox := GetBandsListBoxClass.Create(Self);
    with FBandsListBox do
    begin
      Align := alClient;
      Parent := FBandsPage;
      RefreshItems;
    end;
  end;

begin
  inherited;
  CreateBandsListBox;
end;

procedure TcxGridBandedTableCustomizationForm.InitPageControl;
begin
  inherited;
  FBandsPage := CreatePage(cxGetResourceString(@scxGridCustomizationFormBandsPageCaption),
    GridView.OptionsCustomize.BandMoving);
  FBandsPage.PageIndex := 0;
  ActivatePage(FBandsPage);
end;

function TcxGridBandedTableCustomizationForm.GetBandsListBoxClass: TcxGridBandedTableBandsListBoxClass;
begin
  Result := TcxGridBandedTableBandsListBox;
end;

procedure TcxGridBandedTableCustomizationForm.RefreshData;
begin
  inherited;
  FBandsListBox.RefreshItems;
end;

{ TcxGridBandedTableController }

function TcxGridBandedTableController.GetGridView: TcxGridBandedTableView;
begin
  Result := TcxGridBandedTableView(inherited GridView);
end;

function TcxGridBandedTableController.GetIsBandMoving: Boolean;
begin
  Result := FMovingBand <> nil;
end;

function TcxGridBandedTableController.GetIsBandSizing: Boolean;
begin
  Result := FSizingBand <> nil;
end;

function TcxGridBandedTableController.GetIsColumnVertSizing: Boolean;
begin
  Result := FVertSizingColumn <> nil;
end;

function TcxGridBandedTableController.GetViewInfo: TcxGridBandedTableViewInfo;
begin
  Result := TcxGridBandedTableViewInfo(inherited ViewInfo);
end;

procedure TcxGridBandedTableController.SetPressedBand(Value: TcxGridBand);
var
  R: TRect;

  function GetUpdateRect: TRect;
  begin
    Result := ViewInfo.HeaderViewInfo.BandsViewInfo[FPressedBand.VisibleIndex].HeaderViewInfo.Bounds;
  end;

begin
  if FPressedBand <> Value then
  begin
    if Value = nil then
      R := GetUpdateRect;
    FPressedBand := Value;
    if Value <> nil then
      R := GetUpdateRect;
    GridView.ViewChanged(R);
  end;
end;

function TcxGridBandedTableController.GetCustomizationFormClass: TcxGridTableCustomizationFormClass;
begin
  Result := TcxGridBandedTableCustomizationForm;
end;

function TcxGridBandedTableController.GetColumnHeaderDragAndDropObjectClass: TcxGridColumnHeaderMovingObjectClass;
begin
  Result := TcxGridBandedColumnHeaderMovingObject;
end;

procedure TcxGridBandedTableController.GetColumnNeighbors(AColumn: TcxGridBandedColumn;
  AGoForward: Boolean; AList: TList);
var
  ABands: TcxGridBands;
  ANeighborColumn: TcxGridBandedColumn;

  function GetNextColumn(AColumn: TcxGridBandedColumn): TcxGridBandedColumn;
  var
    ABand: TcxGridBand;
    ARow: TcxGridBandRow;
    ARowIndex, AColIndex: Integer;

    function InitializeValues: Boolean;
    begin
      Result := False;
      if AColumn = nil then
        if AGoForward then
        begin
          ABand := ABands.FirstVisibleNonEmpty;
          if ABand = nil then Exit;
          ARow := ABand.Rows.FirstVisible;
          AColIndex := -1;
        end
        else
        begin
          ABand := ABands.LastVisibleNonEmpty;
          if ABand = nil then Exit;
          ARow := ABand.Rows.LastVisible;
          AColIndex := ARow.VisibleCount;
        end
      else
        with AColumn.Position do
        begin
          ABand := Band;
          ARow := Row;
          ARowIndex := VisibleRowIndex;
          AColIndex := VisibleColIndex;
        end;
      Result := True;  
    end;

    function ProcessRow: Boolean;
    begin
      Result :=
        (AColumn <> nil) and
          (AGoForward and not AColumn.IsRight or
           not AGoForward and not AColumn.IsLeft) or
        (AColumn = nil) and (ARow.VisibleCount <> 0);
      if Result then
        GetNextColumn := ARow.VisibleItems[AColIndex + 2 * Ord(AGoForward) - 1];
    end;

    function ProcessBand: Boolean;
    var
      ALineIndex, AOriginalRowIndex: Integer;
      ARowChanged: Boolean;

      procedure FindNextBand;
      begin
        if AGoForward and ABand.IsLast then
        begin
          ABand := ABands.FirstVisibleNonEmpty;
          ARowIndex := AOriginalRowIndex + 1;
          ARowChanged := True;
        end
        else
          if not AGoForward and ABand.IsFirst then
          begin
            ABand := ABands.LastVisibleNonEmpty;
            ARowIndex := AOriginalRowIndex - 1;
            ARowChanged := True;
          end
          else
          begin
            ABand := ABands.VisibleItems[ABand.VisibleIndex + 2 * Ord(AGoForward) - 1];
            if not ARowChanged then
              ARowIndex := ABand.Rows.GetRowIndex(ALineIndex);
          end;
      end;

    begin
      if ARowIndex = -1 then
        ALineIndex := 0
      else
        ALineIndex := ABand.Rows.GetLineIndex(ARowIndex);
      AOriginalRowIndex := ARowIndex;
      ARowChanged := False;
      repeat
        FindNextBand;
        Result := (0 <= ARowIndex) and (ARowIndex < ABand.Rows.VisibleCount);
      until Result or
        AGoForward and ABand.IsFirstNonEmpty and (ARowIndex = ABands.VisibleRowCount) or
        not AGoForward and ABand.IsLastNonEmpty and (ARowIndex = -1);
      if Result then
      begin
        AColumn := nil;
        ARow := ABand.Rows.VisibleItems[ARowIndex];
        if AGoForward then
          AColIndex := -1
        else
          AColIndex := ARow.VisibleCount;
      end;
    end;

  begin
    Result := nil;
    if not InitializeValues then Exit;
    while not ProcessRow do
      if not ProcessBand then Break;
  end;

begin
  AList.Clear;
  if (AColumn <> nil) and not AColumn.ActuallyVisible then Exit;
  ABands := GridView.Bands;
  ANeighborColumn := AColumn;
  repeat
    ANeighborColumn := GetNextColumn(ANeighborColumn);
    if (ANeighborColumn = nil) or (AList.IndexOf(ANeighborColumn) <> -1) then
      Break
    else
      AList.Add(ANeighborColumn);
  until False;
end;

function TcxGridBandedTableController.IsBandFixedDuringSizing(ABand: TcxGridBand): Boolean;
begin
  Result := (ABand = FSizingBand) or
    not FSizingBand.IsLast and (ABand.VisibleIndex < FSizingBand.VisibleIndex);
end;

function TcxGridBandedTableController.IsColumnFixedDuringHorzSizing(AColumn: TcxGridColumn): Boolean;
var
  APosition1, APosition2: TcxGridBandedColumnPosition;
begin
  APosition1 := TcxGridBandedColumn(AColumn).Position;
  APosition2 := TcxGridBandedColumn(ForcingWidthItem).Position;
  Result :=
    (APosition1 = APosition2) or
    not APosition2.Item.IsRight and (APosition1.Row = APosition2.Row) and
    (APosition1.VisibleColIndex < APosition2.VisibleColIndex);
end;

procedure TcxGridBandedTableController.LeftPosChanged;
begin
  with GridView do
    if Preview.Active and Preview.AutoHeight and
      ((Bands.VisibleLeftFixedCount <> 0) or (Bands.VisibleRightFixedCount <> 0)) then
      SizeChanged
    else
      inherited;
end;

procedure TcxGridBandedTableController.DoCancelMode;
begin
  inherited;
  PressedBand := nil;
end;

procedure TcxGridBandedTableController.EndDragAndDrop(Accepted: Boolean);
begin
  PressedBand := nil;
  inherited;
end;

function TcxGridBandedTableController.FindNextColumnVertically(AFocusedItemIndex: Integer;
  AGoForward, AGoOnCycle: Boolean): Integer;
var
  AColumn: TcxGridBandedColumn;
  AColumns: TList;
  ACycleChanged: Boolean;

  procedure InitializeColumns;
  var
    AColIndex, I, AIndex: Integer;
  begin
    AColIndex := AColumn.Position.VisibleColIndex;
    with AColumn.Position.Band.Rows do
      for I := 0 to VisibleCount - 1 do
        with VisibleItems[I] do
        begin
          AIndex := AColIndex;
          if AIndex > VisibleCount - 1 then
            AIndex := VisibleCount - 1;
          AColumns.Add(VisibleItems[AIndex]);
        end;
  end;

  function CanFocusColumn(AOwner: TcxCustomGridTableView; AItemIndex: Integer;
    AData: Pointer): Boolean;
  begin
    Result := TcxGridBandedColumn(TList(AData)[AItemIndex]).CanFocus;
  end;

begin
  if AFocusedItemIndex = -1 then
    Result := -1
  else
  begin
    AColumn := GridView.VisibleColumns[AFocusedItemIndex];
    AColumns := TList.Create;
    try
      InitializeColumns;
      if FindNextCustomItem(AColumns.IndexOf(AColumn), AColumns.Count,
        AGoForward, AGoOnCycle, @CanFocusColumn, AColumns, Result, ACycleChanged) then
        Result := TcxGridBandedColumn(AColumns[Result]).VisibleIndex
      else
        Result := -1;
    finally
      AColumns.Free;
    end;
  end;  
end;

function TcxGridBandedTableController.FindNextItem(AFocusedItemIndex: Integer;
  AGoForward, AGoOnCycle: Boolean; out ACycleChanged: Boolean): Integer;
var
  AColumns: TList;
  AColumn: TcxGridBandedColumn;

  function CanFocusColumn(AOwner: TcxCustomGridTableView; AItemIndex: Integer;
    AData: Pointer): Boolean;
  begin
    Result := TcxGridBandedColumn(TList(AData)[AItemIndex]).CanFocus;
  end;

begin
  ACycleChanged := False;
  AColumns := TList.Create;
  try
    if AFocusedItemIndex = -1 then
      AColumn := nil
    else
      AColumn := GridView.VisibleColumns[AFocusedItemIndex];
    GetColumnNeighbors(AColumn, AGoForward, AColumns);
    if FindNextCustomItem(-1, AColumns.Count, True, False, @CanFocusColumn, AColumns,
      Result, ACycleChanged) then
      Result := TcxGridBandedColumn(AColumns[Result]).VisibleIndex
    else
      if AGoOnCycle then
      begin
        Result := FindNextItem(-1, AGoForward, False, ACycleChanged);
        ACycleChanged := True;
      end
      else
        Result := -1;
  finally
    AColumns.Free;
  end;
end;

function TcxGridBandedTableController.FocusNextColumnVertically(AFocusedColumnIndex: Integer;
  AGoForward, AGoOnCycle: Boolean): Boolean;
var
  ANextItemIndex: Integer;
begin
  ANextItemIndex := FindNextColumnVertically(AFocusedColumnIndex, AGoForward, AGoOnCycle);
  Result := ANextItemIndex <> -1;
  if Result then
    GridView.VisibleItems[ANextItemIndex].Focused := True;
end;

procedure TcxGridBandedTableController.KeyDown(var Key: Word; Shift: TShiftState);
var
  APrevFocusedRowIndex: Integer;
  APrevFocusedRowHasColumns: Boolean;

  function IsFocusedRecordChanged: Boolean;
  begin
    Result := (FocusedRowIndex <> APrevFocusedRowIndex) or
      DataController.IsGridMode and
        ((Key = VK_UP) and not DataController.IsBOF or (Key = VK_DOWN) and not DataController.IsEOF);
  end;

begin
  APrevFocusedRowIndex := FocusedRowIndex;
  APrevFocusedRowHasColumns := (FocusedRow <> nil) and
    FocusedRow.HasCells and GridView.OptionsSelection.CellSelect;
  if APrevFocusedRowHasColumns then
    case Key of
      VK_UP:
        if FocusNextColumnVertically(FocusedColumnIndex, False, False) then
          Key := 0;
      VK_DOWN:
        if FocusNextColumnVertically(FocusedColumnIndex, True, False) then
          Key := 0;
    end;
  inherited;
  if APrevFocusedRowHasColumns and IsFocusedRecordChanged and
    (FocusedRow <> nil) and FocusedRow.HasCells then
    case Key of
      VK_UP:
        FocusNextColumnVertically(FocusedColumnIndex, False, True);
      VK_DOWN:
        FocusNextColumnVertically(FocusedColumnIndex, True, True);
    end;
end;

procedure TcxGridBandedTableController.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  PressedBand := nil;
end;

{ TcxGridBandHeaderPainter }

function TcxGridBandHeaderPainter.GetViewInfo: TcxGridBandHeaderViewInfo;
begin
  Result := TcxGridBandHeaderViewInfo(inherited ViewInfo);
end;

procedure TcxGridBandHeaderPainter.DrawBorders;
begin
  // inherited;
end;

procedure TcxGridBandHeaderPainter.DrawContent;
const
  States: array[TcxGridCellState] of TcxButtonState = (cxbsNormal, cxbsHot, cxbsPressed);
var
  AState: TcxButtonState;
begin
  with ViewInfo do
  begin
    if IsMainCanvasInUse then
    begin
      AState := States[State];
      if IsPressed then AState := cxbsPressed;
    end
    else
      AState := cxbsNormal;
    LookAndFeelPainter.DrawHeader(Self.Canvas, Bounds, TextAreaBounds, [],
      Borders, AState, AlignmentHorz, AlignmentVert, MultiLinePainting, ShowEndEllipsis,
      Text, Params.Font, Params.TextColor, Params.Color, DrawBackgroundHandler);
  end;
end;

procedure TcxGridBandHeaderPainter.DrawPressed;
begin
  with ViewInfo do
    LookAndFeelPainter.DrawHeaderPressed(Self.Canvas, Bounds);
end;

function TcxGridBandHeaderPainter.ExcludeFromClipRect: Boolean;
begin
  Result := True;
end;

procedure TcxGridBandHeaderPainter.Paint;
begin
  inherited;
  if ViewInfo.IsPressed and IsMainCanvasInUse then DrawPressed;
end;

{ TcxGridBandPainter }

function TcxGridBandPainter.GetViewInfo: TcxGridBandViewInfo;
begin
  Result := TcxGridBandViewInfo(inherited ViewInfo);
end;

procedure TcxGridBandPainter.DrawColumnHeaders;
var
  I, J: Integer;
begin
  with ViewInfo do
    for I := 0 to RowCount - 1 do
      with RowsViewInfo[I] do
        for J := 0 to ColumnViewInfoCount - 1 do
          ColumnViewInfos[J].Paint;
end;

procedure TcxGridBandPainter.DrawContent;
begin
  DrawHeader;
  DrawColumnHeaders;
  inherited;
end;

procedure TcxGridBandPainter.DrawHeader;
begin
  ViewInfo.HeaderViewInfo.Paint;
end;

function TcxGridBandPainter.ExcludeFromClipRect: Boolean;
begin
  Result := True;
end;

{ TcxGridBandedHeaderPainter }

function TcxGridBandedHeaderPainter.GetViewInfo: TcxGridBandedHeaderViewInfo;
begin
  Result := TcxGridBandedHeaderViewInfo(inherited ViewInfo);
end;

procedure TcxGridBandedHeaderPainter.DrawBands;

  procedure ProcessItems(AFixedKind: TcxGridBandFixedKind);
  var
    I: Integer;
  begin
    with ViewInfo.BandsViewInfo do
      for I := 0 to Count - 1 do
        if Items[I].FixedKind = AFixedKind then
          Items[I].Paint;
  end;

begin
  ProcessItems(fkLeft);
  ProcessItems(fkRight);
  ProcessItems(fkNone);
end;

procedure TcxGridBandedHeaderPainter.DrawItems;
begin
  DrawBands;
end;

{ TcxGridBandedFooterPainter }

procedure TcxGridBandedFooterPainter.DrawItems;
var
  AFixedKind: TcxGridBandFixedKind;
  I: Integer;
  AViewInfo: TcxGridColumnHeaderViewInfo;
  ABand: TcxGridBand;
  AClipRegion: TcxRegion;

  function GetFixedPartBounds(AFixedKind: TcxGridBandFixedKind): TRect;
  var
    ABandViewInfo: TcxGridBandViewInfo;
  begin
    Result := ViewInfo.Bounds;
    with TcxGridBandedHeaderViewInfo(ViewInfo.GridViewInfo.HeaderViewInfo).BandsViewInfo do
    begin
      ABandViewInfo := LastFixedItems[AFixedKind];
      if ABandViewInfo <> nil then
        case AFixedKind of
          fkLeft:
            Result.Right := ABandViewInfo.Bounds.Right;
          fkRight:
            Result.Left := ABandViewInfo.Bounds.Left;
        end
      else
        Result := Rect(0, 0, 0, 0);
    end;
  end;

  procedure ExcludeFixedPart(AFixedKind: TcxGridBandFixedKind);
  begin
    Canvas.ExcludeClipRect(GetFixedPartBounds(AFixedKind));
  end;

  procedure IncludeFixedPart(AFixedKind: TcxGridBandFixedKind);
  var
    ARegion: TcxRegion;
  begin
    ARegion := TcxRegion.Create(GetFixedPartBounds(AFixedKind));
    Canvas.SetClipRegion(ARegion, roAdd);
  end;

  procedure ChangeFixedKind(Value: TcxGridBandFixedKind);
  begin
    case AFixedKind of
      fkLeft:
        begin
          AClipRegion := Canvas.GetClipRegion;
          ExcludeFixedPart(fkLeft);
          ExcludeFixedPart(fkRight);
        end;
      fkRight:
        begin
          IncludeFixedPart(fkLeft);
          Canvas.SetClipRegion(AClipRegion, roIntersect);
          AClipRegion := Canvas.GetClipRegion;
          ExcludeFixedPart(fkLeft);
          ExcludeFixedPart(fkRight);
        end;
    else
      IncludeFixedPart(fkRight);
    end;
    AFixedKind := Value;
  end;

  procedure RestoreClipRegion;
  begin
    if AClipRegion <> nil then
    begin
      IncludeFixedPart(fkLeft);
      IncludeFixedPart(fkRight);
      Canvas.SetClipRegion(AClipRegion, roIntersect);
      AClipRegion := nil;
    end;
  end;

begin            
  AClipRegion := nil;
  AFixedKind := fkLeft;
  for I := 0 to ViewInfo.Count - 1 do
  begin
    AViewInfo := ViewInfo.InternalItems[I];
    if AViewInfo <> nil then
    begin
      ABand := TcxGridBandedColumn(AViewInfo.Column).Position.Band;
      if ABand.FixedKind <> AFixedKind then
        ChangeFixedKind(ABand.FixedKind);
      AViewInfo.Paint;
    end;
  end;
  RestoreClipRegion;
end;

{ TcxGridBandedDataRowCellsAreaItemPainter }

function TcxGridBandedDataRowCellsAreaItemPainter.GetViewInfo: TcxGridBandedDataRowCellsAreaItemViewInfo;
begin
  Result := TcxGridBandedDataRowCellsAreaItemViewInfo(inherited ViewInfo);
end;

procedure TcxGridBandedDataRowCellsAreaItemPainter.DrawFixedBandsSeparator;
var
  R: TRect;
begin
  with Canvas do
  begin
    R := ViewInfo.FixedBandsSeparatorBounds;
    Brush.Color := ViewInfo.GridViewInfo.FixedBandSeparatorColor;
    FillRect(R);
    ExcludeClipRect(R);
  end;
end;

procedure TcxGridBandedDataRowCellsAreaItemPainter.DrawContent;
begin
  DrawLines;
  inherited;
end;

procedure TcxGridBandedDataRowCellsAreaItemPainter.DrawLines;
var
  I: Integer;
  R: TRect;
begin
  Canvas.Brush.Color := ViewInfo.GridViewInfo.GridLineColor;
  for I := 0 to ViewInfo.LineCount - 1 do
  begin
    R := ViewInfo.LineBounds[I];
    Canvas.FillRect(R);
    Canvas.ExcludeClipRect(R);
  end;
end;

function TcxGridBandedDataRowCellsAreaItemPainter.ExcludeFromClipRect: Boolean;
begin
  Result := True;
end;

procedure TcxGridBandedDataRowCellsAreaItemPainter.Paint;
begin
  if ViewInfo.FixedBandsSeparatorLocation <> slNone then
    DrawFixedBandsSeparator;
  inherited;
end;

{ TcxGridBandedRowsPainter }

class procedure TcxGridBandedRowsPainter.DrawDataRowCells(ARowViewInfo: TcxCustomGridRowViewInfo);
var
  ADataRowViewInfo: TcxGridDataRowViewInfo;
  ACellsAreaViewInfo: TcxGridBandedDataRowCellsAreaViewInfo;
  ACanvas: TcxCanvas;
  AClipRegion: TcxRegion;

  procedure DrawBandCells(ABandViewInfo: TcxGridBandViewInfo);
  var
    I: Integer;
  begin
    for I := 0 to ABandViewInfo.ColumnViewInfoCount - 1 do
      ADataRowViewInfo.CellViewInfos[ABandViewInfo[I].Index].Paint;
    if ACellsAreaViewInfo.Visible then
      ACellsAreaViewInfo[ABandViewInfo.Index].Paint;
  end;

  procedure DrawBands(AFixedKind: TcxGridBandFixedKind);
  var
    I: Integer;
  begin
    with TcxGridBandedTableViewInfo(ARowViewInfo.GridViewInfo).HeaderViewInfo.BandsViewInfo do
      for I := 0 to Count - 1 do
        if Items[I].FixedKind = AFixedKind then
          DrawBandCells(Items[I]);
  end;

begin
  ADataRowViewInfo := TcxGridDataRowViewInfo(ARowViewInfo);
  ACellsAreaViewInfo := TcxGridBandedDataRowCellsAreaViewInfo(ADataRowViewInfo.CellsAreaViewInfo);
  ACanvas := ARowViewInfo.GridViewInfo.Canvas;
  AClipRegion := ACanvas.GetClipRegion;
  try
    if ACellsAreaViewInfo.Visible then
      ACanvas.IntersectClipRect(ACellsAreaViewInfo.Bounds);
    DrawBands(fkLeft);
    DrawBands(fkRight);
    DrawBands(fkNone);
  finally
    ACanvas.SetClipRegion(AClipRegion, roSet);
  end;
end;

{ TcxGridBandedTablePainter }

function TcxGridBandedTablePainter.GetViewInfo: TcxGridBandedTableViewInfo;
begin
  Result := TcxGridBandedTableViewInfo(inherited ViewInfo);
end;

function TcxGridBandedTablePainter.CanOffset(AItemsOffset, DX, DY: Integer): Boolean;
begin
  with ViewInfo.HeaderViewInfo.BandsViewInfo do
    Result := inherited CanOffset(AItemsOffset, DX, DY) and
      ((AItemsOffset <> 0) or (BandBackgroundBitmap = nil) and (BandHeaderBackgroundBitmap = nil) and
       ((GridView.Bands.Layout = blNonFixed) or
        (GridView.GroupedColumnCount = 0) and not GridView.Preview.Active));
end;

{ TcxGridBandedColumnContainerZone }

constructor TcxGridBandedColumnContainerZone.Create(AColumnIndex: Integer;
  ABand: TcxGridBand; AColIndex, ARowIndex: Integer);
begin
  inherited Create(AColumnIndex);
  Band := ABand;
  ColIndex := AColIndex;
  RowIndex := ARowIndex;
end;

function TcxGridBandedColumnContainerZone.IsEqual(Value: TcxGridColumnContainerZone): Boolean;
var
  AValue: TcxGridBandedColumnContainerZone;
begin
  AValue := TcxGridBandedColumnContainerZone(Value);
  Result := inherited IsEqual(Value) and (ClassType = Value.ClassType) and
    (Band = AValue.Band) and (ColIndex = AValue.ColIndex) and (RowIndex = AValue.RowIndex);
end;

function TcxGridBandedColumnContainerZone.IsInsertion: Boolean;
begin
  Result := ColumnIndex = -1;
end;

{ TcxGridBandedColumnHeaderVertSizingEdgeViewInfo }

function TcxGridBandedColumnHeaderVertSizingEdgeViewInfo.CalculateHeight: Integer;
begin
  Result := cxGridHeaderSizingEdgeSize;
end;

function TcxGridBandedColumnHeaderVertSizingEdgeViewInfo.CalculateWidth: Integer;
begin
  Result := 0;
end;

function TcxGridBandedColumnHeaderVertSizingEdgeViewInfo.GetAlignmentVert: TcxAlignmentVert;
begin
  Result := vaBottom;
end;

function TcxGridBandedColumnHeaderVertSizingEdgeViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridColumnHeaderVertSizingEdgeHitTest;
end;

function TcxGridBandedColumnHeaderVertSizingEdgeViewInfo.GetIsOccupyingSpace: Boolean;
begin
  Result := False;
end;

function TcxGridBandedColumnHeaderVertSizingEdgeViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := nil;
end;

function TcxGridBandedColumnHeaderVertSizingEdgeViewInfo.GetTransparent: Boolean;
begin
  Result := True;
end;

procedure TcxGridBandedColumnHeaderVertSizingEdgeViewInfo.Calculate(const ABounds: TRect;
  var ATextAreaBounds: TRect);
begin
  inherited;
  OffsetRect(Bounds, 0, Height div 2);
end;

{ TcxGridBandedColumnHeaderViewInfo }

function TcxGridBandedColumnHeaderViewInfo.GetBandViewInfo: TcxGridBandViewInfo;
begin
  Result := Container.BandsViewInfo[Column.Position.VisibleBandIndex];
end;

function TcxGridBandedColumnHeaderViewInfo.GetColumn: TcxGridBandedColumn;
begin
  Result := TcxGridBandedColumn(inherited Column);
end;

function TcxGridBandedColumnHeaderViewInfo.GetContainer: TcxGridBandedHeaderViewInfo;
begin
  Result := TcxGridBandedHeaderViewInfo(inherited Container);
end;

function TcxGridBandedColumnHeaderViewInfo.GetRowViewInfo: TcxGridBandRowViewInfo;
begin
  Result := BandViewInfo.RowsViewInfo[Column.Position.VisibleRowIndex];
end;

function TcxGridBandedColumnHeaderViewInfo.CanVertSize: Boolean;
begin
  Result := Column.CanVertSize and (Container.Kind = ccHeader);
end;

procedure TcxGridBandedColumnHeaderViewInfo.GetAreaViewInfoClasses(AProc: TcxGridClassEnumeratorProc);
begin
  inherited;
  if CanVertSize then AProc(TcxGridBandedColumnHeaderVertSizingEdgeViewInfo);
end;

function TcxGridBandedColumnHeaderViewInfo.GetMaxWidth: Integer;
var
  AColIndex, I: Integer;
begin
  if BandViewInfo.Band.Width <> 0 then
  begin
    Result := RowViewInfo.Width;
    AColIndex := Column.Position.VisibleColIndex;
    if AColIndex = RowViewInfo.ColumnViewInfoCount - 1 then
      for I := 0 to AColIndex - 1 do
        Dec(Result, RowViewInfo[I].MinWidth)
    else
      for I := 0 to RowViewInfo.ColumnViewInfoCount - 1 do
      begin
        if I < AColIndex then
          Dec(Result, RowViewInfo[I].Width);
        if I > AColIndex then
          Dec(Result, RowViewInfo[I].MinWidth);
      end;
    if Result < MinWidth then Result := MinWidth;
  end
  else
    Result := MaxInt;
end;

function TcxGridBandedColumnHeaderViewInfo.GetMultiLinePainting: Boolean;
begin
  Result := inherited GetMultiLinePainting or (Column.Position.LineCount > 1);
end;

{ TcxGridBandHeaderViewInfo }

constructor TcxGridBandHeaderViewInfo.Create(ABandViewInfo: TcxGridBandViewInfo);
begin
  inherited Create(ABandViewInfo.GridViewInfo);
  FBandViewInfo := ABandViewInfo;
end;

function TcxGridBandHeaderViewInfo.GetBand: TcxGridBand;
begin
  Result := FBandViewInfo.Band;
end;

function TcxGridBandHeaderViewInfo.GetGridView: TcxGridBandedTableView;
begin
  Result := TcxGridBandedTableView(inherited GridView);
end;

function TcxGridBandHeaderViewInfo.GetGridViewInfo: TcxGridBandedTableViewInfo;
begin
  Result := FBandViewInfo.GridViewInfo;
end;

function TcxGridBandHeaderViewInfo.CalculateHeight: Integer;
begin
  Result := GetTextCellHeight(GridViewInfo, LookAndFeelPainter);
end;

function TcxGridBandHeaderViewInfo.CalculateWidth: Integer;
begin
  with Bounds do
    Result := Right - Left;
end;

function TcxGridBandHeaderViewInfo.CustomDraw(ACanvas: TcxCanvas): Boolean;
begin
  Result := inherited CustomDraw(ACanvas);
  GridViewInfo.GridView.DoCustomDrawBandHeader(ACanvas, Self, Result);
end;

function TcxGridBandHeaderViewInfo.GetAlignmentHorz: TAlignment;
begin
  Result := Band.HeaderAlignmentHorz;
end;

function TcxGridBandHeaderViewInfo.GetAlignmentVert: TcxAlignmentVert;
begin
  Result := Band.HeaderAlignmentVert;
end;

function TcxGridBandHeaderViewInfo.GetBackgroundBitmap: TBitmap;
begin   {4}
  Result := BandViewInfo.BandsViewInfo.BandHeaderBackgroundBitmap;
end;

function TcxGridBandHeaderViewInfo.GetBorders: TcxBorders;
begin
  Result := cxBordersAll;
end;

function TcxGridBandHeaderViewInfo.GetBorderWidth(AIndex: TcxBorder): Integer;
begin
  Result := LookAndFeelPainter.HeaderBorderSize;
end;

function TcxGridBandHeaderViewInfo.GetCanvas: TcxCanvas;
begin
  Result := FBandViewInfo.Canvas;
end;

class function TcxGridBandHeaderViewInfo.GetCellHeight(ATextHeight: Integer;
  ALookAndFeelPainter: TcxCustomLookAndFeelPainterClass): Integer;
begin
  Result := inherited GetCellHeight(ATextHeight, ALookAndFeelPainter) +
    2 * ALookAndFeelPainter.HeaderBorderSize;
end;

function TcxGridBandHeaderViewInfo.GetHeight: Integer;
begin
  Result := FBandViewInfo.BandsViewInfo.BandHeadersAreaHeight;
end;

function TcxGridBandHeaderViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridBandHeaderHitTest;
end;

function TcxGridBandHeaderViewInfo.GetHotTrack: Boolean;
begin
  Result := LookAndFeelPainter.IsHeaderHotTrack;
end;

function TcxGridBandHeaderViewInfo.GetIsPressed: Boolean;
begin
  Result := (State = gcsPressed) or (GridViewInfo.Controller.PressedBand = Band);
end;

function TcxGridBandHeaderViewInfo.GetMultiLinePainting: Boolean;
begin
  Result := inherited GetMultiLinePainting or
    FBandViewInfo.BandsViewInfo.IsBandHeaderHeightAssigned;
end;

function TcxGridBandHeaderViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridBandHeaderPainter;
end;

function TcxGridBandHeaderViewInfo.GetShowEndEllipsis: Boolean;
begin
  Result := GridView.OptionsView.BandHeaderEndEllipsis;
end;

function TcxGridBandHeaderViewInfo.GetSizingEdgeBounds: TRect;
begin
  Result := Bounds;
  with Result do
  begin
    Left := Right - cxGridHeaderSizingEdgeSize div 2;
    Right := Left + cxGridHeaderSizingEdgeSize;
  end;
end;

function TcxGridBandHeaderViewInfo.GetText: string;
begin
  Result := Band.Caption;
end;

function TcxGridBandHeaderViewInfo.GetVisible: Boolean;
begin
  Result := FBandViewInfo.BandsViewInfo.ShowBandHeaders;
end;

procedure TcxGridBandHeaderViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  Band.Styles.GetHeaderParams(AParams);
end;

function TcxGridBandHeaderViewInfo.HasCustomDraw: Boolean;
begin
  Result := GridView.HasCustomDrawBandHeader;
end;

procedure TcxGridBandHeaderViewInfo.InitHitTest(AHitTest: TcxCustomGridHitTest);
begin
  FBandViewInfo.InitHitTest(AHitTest);
  inherited;
end;

procedure TcxGridBandHeaderViewInfo.StateChanged;
begin
  inherited;
  case State of
    gcsPressed:
      MouseCapture := True;
    gcsNone:
      MouseCapture := False;
  end;
end;

function TcxGridBandHeaderViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
begin
  if FBandViewInfo.CanSize and PtInRect(SizingEdgeBounds, P) then
  begin
    Result := TcxGridBandHeaderSizingEdgeHitTest.Instance(P);
    InitHitTest(Result);
  end
  else
    Result := inherited GetHitTest(P);
end;

function TcxGridBandHeaderViewInfo.MouseDown(AHitTest: TcxCustomGridHitTest;
  AButton: TMouseButton; AShift: TShiftState): Boolean;
begin
  Result := inherited MouseDown(AHitTest, AButton, AShift);
  if (AButton = mbLeft) and not (ssDouble in AShift) then
    case AHitTest.HitTestCode of
      htBandHeader:
        begin
          GridView.Controller.PressedBand := Band;
          Band.DoHeaderClick;
          Result := True;
        end;
      htBandHeaderSizingEdge:
        if ssDouble in AShift then
        begin
          Band.ApplyBestFit;
          Result := True;
        end;
    end;    
end;

{ TcxGridBandRowViewInfo }

constructor TcxGridBandRowViewInfo.Create(ARowsViewInfo: TcxGridBandRowsViewInfo;
  AIndex: Integer);
begin
  inherited Create;
  FRowsViewInfo := ARowsViewInfo;
  FIndex := AIndex;
  FColumnViewInfos := TList.Create;
  FHeight := -1;
  FLineCount := -1;
  AddColumnViewInfos;
end;

destructor TcxGridBandRowViewInfo.Destroy;
begin
  FColumnViewInfos.Free;
  inherited;
end;

function TcxGridBandRowViewInfo.GetBandRow: TcxGridBandRow;
begin
  Result := FRowsViewInfo.BandRows.VisibleItems[FIndex];
end;

function TcxGridBandRowViewInfo.GetBandViewInfo: TcxGridBandViewInfo;
begin
  Result := FRowsViewInfo.BandViewInfo;
end;

function TcxGridBandRowViewInfo.GetColumnViewInfo(Index: Integer): TcxGridBandedColumnHeaderViewInfo;
begin
  Result := FColumnViewInfos[Index];
end;

function TcxGridBandRowViewInfo.GetColumnViewInfoCount: Integer;
begin
  Result := FColumnViewInfos.Count;
end;

function TcxGridBandRowViewInfo.GetGridView: TcxGridBandedTableView;
begin
  Result := FRowsViewInfo.BandViewInfo.GridView;
end;

function TcxGridBandRowViewInfo.GetHeight: Integer;
begin
  if FHeight = -1 then
    FHeight := CalculateHeight;
  Result := FHeight;
end;

function TcxGridBandRowViewInfo.GetLineCount: Integer;
begin
  if FLineCount = -1 then
    FLineCount := CalculateLineCount;
  Result := FLineCount;
end;

function TcxGridBandRowViewInfo.GetLineHeight: Integer;
begin
  Result := BandViewInfo.GridViewInfo.HeaderViewInfo.ItemHeight;
end;

function TcxGridBandRowViewInfo.GetLineOffset: Integer;
begin
  Result := BandRow.LineOffset;
end;

function TcxGridBandRowViewInfo.GetMinWidth: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to ColumnViewInfoCount - 1 do
    Inc(Result, ColumnViewInfos[I].MinWidth);
end;

function TcxGridBandRowViewInfo.GetWidth: Integer;
begin
  with Bounds do
    Result := Right - Left;
end;

procedure TcxGridBandRowViewInfo.AddColumnViewInfos;
var
  AHeaderViewInfo: TcxGridBandedHeaderViewInfo;
  I: Integer;
  AColumnViewInfo: TcxGridBandedColumnHeaderViewInfo;
begin
  AHeaderViewInfo := BandViewInfo.GridViewInfo.HeaderViewInfo;
  for I := 0 to BandRow.VisibleCount - 1 do
  begin
    AColumnViewInfo := AHeaderViewInfo[BandRow.VisibleItems[I].VisibleIndex];
    FColumnViewInfos.Add(AColumnViewInfo);
  end;
end;

procedure TcxGridBandRowViewInfo.Calculate(const ABounds: TRect);
var
  ALeftBound, ATopBound, ALineHeight, I, AWidth: Integer;
  AColumnViewInfo: TcxGridBandedColumnHeaderViewInfo;

  function GetColumnHeight: Integer;
  begin
    Result := AColumnViewInfo.Column.Position.LineCount * ALineHeight;
  end;

begin
  Bounds := ABounds;
  CalculateColumnWidths;
  ALeftBound := Bounds.Left;
  ATopBound := Bounds.Top;
  ALineHeight := LineHeight;
  for I := 0 to ColumnViewInfoCount - 1 do
  begin
    AColumnViewInfo := ColumnViewInfos[I];
    AWidth := AColumnViewInfo.CalculateWidth;
    AColumnViewInfo.Calculate(ALeftBound, ATopBound, AWidth, GetColumnHeight);
    Inc(ALeftBound, AWidth);
  end;
end;

procedure TcxGridBandRowViewInfo.CalculateColumnWidths;
var
  AAutoWidthObject: TcxAutoWidthObject;
  I: Integer;
begin
  AAutoWidthObject := TcxAutoWidthObject.Create(ColumnViewInfoCount);
  try
    for I := 0 to ColumnViewInfoCount - 1 do
      ColumnViewInfos[I].InitAutoWidthItem(AAutoWidthObject.AddItem);
    AAutoWidthObject.AvailableWidth := FRowsViewInfo.Width;
    AAutoWidthObject.Calculate;
    for I := 0 to ColumnViewInfoCount - 1 do
      ColumnViewInfos[I].Width := AAutoWidthObject[I].AutoWidth;
  finally
    AAutoWidthObject.Free;
  end;
end;

function TcxGridBandRowViewInfo.CalculateHeight: Integer;
begin
  Result := LineCount * LineHeight;
end;

function TcxGridBandRowViewInfo.CalculateLineCount: Integer;
begin
  Result := BandRow.LineCount;
end;

function TcxGridBandRowViewInfo.CalculateLineHeight: Integer;
var
  I, AColumnHeaderHeight: Integer;
begin
  Result := 0;
  for I := 0 to ColumnViewInfoCount - 1 do
  begin
    AColumnHeaderHeight := ColumnViewInfos[I].CalculateHeight;
    if AColumnHeaderHeight > Result then
      Result := AColumnHeaderHeight;
  end;
end;

function TcxGridBandRowViewInfo.CalculateWidth: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to ColumnViewInfoCount - 1 do
    Inc(Result, ColumnViewInfos[I].CalculateWidth);
end;

procedure TcxGridBandRowViewInfo.AssignColumnWidths;
var
  I: Integer;
begin
  GridView.BeginUpdate;
  try
    for I := 0 to ColumnViewInfoCount - 1 do
      with ColumnViewInfos[I] do
        Column.Width := RealWidth;
  finally
    GridView.EndUpdate;
  end;
end;

procedure TcxGridBandRowViewInfo.Offset(DX, DY: Integer);
begin  {2}
  OffsetRect(Bounds, DX, DY);
end;

{ TcxGridBandRowsViewInfo }

constructor TcxGridBandRowsViewInfo.Create(ABandViewInfo: TcxGridBandViewInfo);
begin
  inherited Create;
  FBandViewInfo := ABandViewInfo;
  FWidth := -1;
  CreateItems;
end;

destructor TcxGridBandRowsViewInfo.Destroy;
begin
  DestroyItems;
  inherited;
end;

function TcxGridBandRowsViewInfo.GetBandRows: TcxGridBandRows;
begin
  Result := FBandViewInfo.Band.Rows;
end;

function TcxGridBandRowsViewInfo.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxGridBandRowsViewInfo.GetItem(Index: Integer): TcxGridBandRowViewInfo;
begin
  Result := FItems[Index];
end;

function TcxGridBandRowsViewInfo.GetLineCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do
    Inc(Result, Items[I].LineCount);
end;

function TcxGridBandRowsViewInfo.GetMinWidth: Integer;
var
  I, AMinWidth: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do
  begin
    AMinWidth := Items[I].MinWidth;
    if AMinWidth > Result then Result := AMinWidth;
  end;
end;

function TcxGridBandRowsViewInfo.GetWidth: Integer;
begin
  {with Bounds do
    Result := Right - Left;}
  Result := FBandViewInfo.ContentWidth;
end;

procedure TcxGridBandRowsViewInfo.CreateItems;
var
  I: Integer;
begin
  FItems := TList.Create;
  for I := 0 to BandRows.VisibleCount - 1 do
    FItems.Add(GetBandRowViewInfoClass.Create(Self, I));
end;

procedure TcxGridBandRowsViewInfo.DestroyItems;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do Items[I].Free;
  FItems.Free;
end;

procedure TcxGridBandRowsViewInfo.Calculate(const ABounds: TRect);
var
  ARowBounds: TRect;
  I: Integer;
begin
  Bounds := ABounds;
  ARowBounds := Bounds;
  for I := 0 to Count - 1 do
  begin
    ARowBounds.Bottom := ARowBounds.Top + Items[I].Height;
    Items[I].Calculate(ARowBounds);
    ARowBounds.Top := ARowBounds.Bottom;
  end;
end;

procedure TcxGridBandRowsViewInfo.CalculateColumnWidths;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].CalculateColumnWidths;
end;

function TcxGridBandRowsViewInfo.CalculateWidth: Integer;
var
  I, ARowWidth: Integer;
begin
  if Count = 0 then
    Result := cxGridDefaultEmptyBandWidth
  else
  begin
    Result := 0;
    for I := 0 to Count - 1 do
    begin
      ARowWidth := Items[I].CalculateWidth;
      if ARowWidth > Result then Result := ARowWidth;
    end;
  end;  
end;

function TcxGridBandRowsViewInfo.GetBandRowViewInfoClass: TcxGridBandRowViewInfoClass;
begin
  Result := TcxGridBandRowViewInfo;
end;

function TcxGridBandRowsViewInfo.IndexAtPos(const P: TPoint): Integer;
var
  R: TRect;
begin
  R := Bounds;
  if FBandViewInfo.GridView.Controller.IsColumnMoving then
    Inc(R.Bottom, ColumnHeaderInsertZoneSize);
  if PtInRect(R, P) then
  begin
    for Result := 0 to Count - 1 do
      if PtInRect(Items[Result].Bounds, P) then Exit;
    Result := Count;
  end
  else
    Result := -1;
end;

procedure TcxGridBandRowsViewInfo.Offset(DX, DY: Integer);
var
  I: Integer;
begin
  OffsetRect(Bounds, DX, 0);
  for I := 0 to Count - 1 do
    Items[I].Offset(DX, DY);
end;

{ TcxGridBandViewInfo }

constructor TcxGridBandViewInfo.Create(ABandsViewInfo: TcxGridBandsViewInfo; AIndex: Integer);
begin
  inherited Create;
  FBandsViewInfo := ABandsViewInfo;
  FColumnViewInfos := TList.Create;
  FIndex := AIndex;
  AddColumnViewInfos;
  FHeaderViewInfo := GetHeaderViewInfoClass.Create(Self);
  FRowsViewInfo := GetRowsViewInfoClass.Create(Self);
  FWidth := -1;
end;

destructor TcxGridBandViewInfo.Destroy;
begin
  FHeaderViewInfo.Free;
  FRowsViewInfo.Free;
  FColumnViewInfos.Free;
  inherited;
end;

function TcxGridBandViewInfo.GetBand: TcxGridBand;
begin
  Result := GridView.Bands.VisibleItems[FIndex];
end;

function TcxGridBandViewInfo.GetColumnViewInfo(Index: Integer): TcxGridBandedColumnHeaderViewInfo;
begin
  Result := FColumnViewInfos[Index];
end;

function TcxGridBandViewInfo.GetColumnViewInfoCount: Integer;
begin
  Result := FColumnViewInfos.Count;
end;

function TcxGridBandViewInfo.GetContainerViewInfo: TcxGridBandedHeaderViewInfo;
begin
  Result := FBandsViewInfo.ContainerViewInfo;
end;

function TcxGridBandViewInfo.GetFixedKind: TcxGridBandFixedKind;
begin
  Result := Band.FixedKind;
end;

function TcxGridBandViewInfo.GetGridView: TcxGridBandedTableView;
begin
  Result := FBandsViewInfo.GridView;
end;

function TcxGridBandViewInfo.GetGridViewInfo: TcxGridBandedTableViewInfo;
begin
  Result := ContainerViewInfo.GridViewInfo;
end;

function TcxGridBandViewInfo.GetIsFixed: Boolean;
begin
  Result := not Band.Options.Sizing or
    GridView.Controller.IsBandSizing and
    GridView.Controller.IsBandFixedDuringSizing(Band);
end;

function TcxGridBandViewInfo.GetIsRight: Boolean;
begin
  Result := Index = FBandsViewInfo.Count - 1;
end;

function TcxGridBandViewInfo.GetLineCount: Integer;
begin
  Result := FRowsViewInfo.LineCount;
end;

function TcxGridBandViewInfo.GetRowCount: Integer;
begin
  Result := FRowsViewInfo.Count;
end;

function CompareColumnViewInfos(Item1, Item2: Pointer): Integer;
begin
  Result := CompareVisibleColumnPositions(
    TcxGridBandedColumnHeaderViewInfo(Item1).Column.Position,
    TcxGridBandedColumnHeaderViewInfo(Item2).Column.Position);
end;

procedure TcxGridBandViewInfo.AddColumnViewInfos;
var
  I: Integer;
  AColumnHeaderViewInfo: TcxGridBandedColumnHeaderViewInfo;
begin
  for I := 0 to ContainerViewInfo.Count - 1 do
  begin
    AColumnHeaderViewInfo := ContainerViewInfo[I];
    if AColumnHeaderViewInfo.Column.Position.Band = Band then
      FColumnViewInfos.Add(AColumnHeaderViewInfo);
  end;
  FColumnViewInfos.Sort(CompareColumnViewInfos);
end;

procedure TcxGridBandViewInfo.CalculateColumnWidths;
begin
  FRowsViewInfo.CalculateColumnWidths;
end;

function TcxGridBandViewInfo.CalculateHeaderBounds: TRect;
begin
  Result := ContentBounds;
  Result.Bottom := Result.Top + HeaderViewInfo.Height;
end;

function TcxGridBandViewInfo.CalculateRowsBounds: TRect;
begin
  Result := ContentBounds;
  Result.Top := CalculateHeaderBounds.Bottom;
end;

function TcxGridBandViewInfo.CalculateWidth: Integer;
var
  AMinWidth: Integer;
begin
  if FWidth = -1 then
  begin
    FWidth := Band.Width;
    if FWidth = 0 then
      FWidth := FRowsViewInfo.CalculateWidth;
    CalculateParams;
    Inc(FWidth, BorderSize[bLeft] + BorderSize[bRight]);
    AMinWidth := MinWidth;
    if FWidth < AMinWidth then FWidth := AMinWidth;
  end;
  Result := FWidth;
end;

function TcxGridBandViewInfo.CanSize: Boolean;
begin
  Result := Band.CanSize;
end;

procedure TcxGridBandViewInfo.CheckWidth(var Value: Integer);
begin
  if Value < MinWidth then Value := MinWidth;
  if Value > MaxWidth then Value := MaxWidth;
end;

function TcxGridBandViewInfo.CustomDrawBackground(ACanvas: TcxCanvas): Boolean;
begin
  Result := inherited CustomDrawBackground(ACanvas);
  GridView.DoCustomDrawPartBackground(ACanvas, Self, Result);
end;

function TcxGridBandViewInfo.GetAreAllColumnsFixed: Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to ColumnViewInfoCount - 1 do
  begin
    Result := ColumnViewInfos[I].IsFixed;
    if not Result then Exit;
  end;
end;

function TcxGridBandViewInfo.GetBackgroundBitmap: TBitmap;
begin   {4}
  Result := BandsViewInfo.BandBackgroundBitmap;
end;

function TcxGridBandViewInfo.GetBorderColor(AIndex: TcxBorder): TColor;
begin
  Result := GridViewInfo.FixedBandSeparatorColor;
end;

function TcxGridBandViewInfo.GetBorders: TcxBorders;
begin
  Result := [];
  if (FixedKind <> fkNone) and (BandsViewInfo.LastFixedItems[FixedKind] = Self) then
    case FixedKind of
      fkLeft:
        Include(Result, bRight);
      fkRight:
        Include(Result, bLeft);
    end;
end;

function TcxGridBandViewInfo.GetBorderWidth(AIndex: TcxBorder): Integer;
begin
  Result := GridViewInfo.FixedBandSeparatorWidth;
end;

function TcxGridBandViewInfo.GetCanvas: TcxCanvas;
begin
  Result := ContainerViewInfo.Canvas;
end;

function TcxGridBandViewInfo.GetContentWidth: Integer;
begin
  CalculateParams;
  Result := Width - (BorderSize[bLeft] + BorderSize[bRight]);
end;

function TcxGridBandViewInfo.GetHeaderViewInfoClass: TcxGridBandHeaderViewInfoClass;
begin
  Result := TcxGridBandHeaderViewInfo;
end;

function TcxGridBandViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridBandHitTest;
end;

function TcxGridBandViewInfo.GetMaxWidth: Integer;
var
  AIndex, I: Integer;
begin
  if GridView.OptionsView.ColumnAutoWidth then
  begin
    Result := GridViewInfo.ClientWidth;
    AIndex := Band.VisibleIndex;
    if AIndex = FBandsViewInfo.Count - 1 then
      for I := 0 to AIndex - 1 do
        Dec(Result, FBandsViewInfo[I].MinWidth)
    else
      for I := 0 to FBandsViewInfo.Count - 1 do
      begin
        if I < AIndex then
          Dec(Result, FBandsViewInfo[I].Width);
        if I > AIndex then
          Dec(Result, FBandsViewInfo[I].MinWidth);
      end;
    if Result < MinWidth then Result := MinWidth;
  end
  else
    Result := MaxInt;
end;

function TcxGridBandViewInfo.GetMinWidth: Integer;
begin
  CalculateParams;
  Result := BorderSize[bLeft] + FRowsViewInfo.MinWidth + BorderSize[bRight];
  if Band.IsFirst then
    Result := Max(Result, GridViewInfo.FirstItemAdditionalWidth);
end;

function TcxGridBandViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridBandPainter;
end;

function TcxGridBandViewInfo.GetRowsViewInfoClass: TcxGridBandRowsViewInfoClass;
begin
  Result := TcxGridBandRowsViewInfo;
end;

procedure TcxGridBandViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  Band.Styles.GetViewParams(bsBackground, Band, nil, AParams);
end;

function TcxGridBandViewInfo.GetWidth: Integer;
begin
  if FWidth = -1 then
    Result := CalculateWidth
  else
    Result := FWidth;
end;

procedure TcxGridBandViewInfo.InitHitTest(AHitTest: TcxCustomGridHitTest);
begin
  inherited;
  with AHitTest as TcxGridBandHitTest do
  begin
    GridView := Self.GridView;
    Band := Self.Band;
    BandContainerKind := bcHeader;
    VisibleRowIndex := -1;
  end;
end;

procedure TcxGridBandViewInfo.Offset(DX, DY: Integer);
begin
  inherited;
  FHeaderViewInfo.DoOffset(DX, DY);
  FRowsViewInfo.Offset(DX, DY);
end;

procedure TcxGridBandViewInfo.SetWidth(Value: Integer);
begin
  inherited;
  FWidth := Value;
end;

procedure TcxGridBandViewInfo.Calculate(const ABounds: TRect);
begin
  inherited;
  FHeaderViewInfo.Calculate(CalculateHeaderBounds);
  FRowsViewInfo.Calculate(CalculateRowsBounds);
end;

function TcxGridBandViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
var
  ARowIndex: Integer;
begin
  Result := FHeaderViewInfo.GetHitTest(P);
  if Result = nil then
  begin
    Result := inherited GetHitTest(P);
    ARowIndex := FRowsViewInfo.IndexAtPos(P);
    if ARowIndex <> -1 then
    begin
      if Result = nil then
      begin
        Result := GetHitTestClass.Instance(P);
        InitHitTest(Result);
      end;
      TcxGridBandHitTest(Result).VisibleRowIndex := ARowIndex;
    end;
  end;
end;

procedure TcxGridBandViewInfo.InitAutoWidthItem(AAutoWidthItem: TcxAutoWidthItem);
begin
  AAutoWidthItem.MinWidth := MinWidth;
  AAutoWidthItem.Width := CalculateWidth;
  AAutoWidthItem.Fixed := IsFixed;
end;

{ TcxGridBandsViewInfo }

constructor TcxGridBandsViewInfo.Create(AContainerViewInfo: TcxGridBandedHeaderViewInfo);
begin
  inherited Create;
  FContainerViewInfo := AContainerViewInfo;
  FBandHeadersAreaHeight := -1;
  FLineCount := -1;
  FRowCount := -1;
  CreateItems;
end;

destructor TcxGridBandsViewInfo.Destroy;
begin
  DestroyItems;
  inherited;
end;

function TcxGridBandsViewInfo.GetBandHeadersAreaHeight: Integer;
begin
  if FBandHeadersAreaHeight = -1 then
    if ShowBandHeaders then
      FBandHeadersAreaHeight := CalculateBandHeadersAreaHeight
    else
      FBandHeadersAreaHeight := 0;
  Result := FBandHeadersAreaHeight;
end;

function TcxGridBandsViewInfo.GetBands: TcxGridBands;
begin
  Result := GridView.Bands;
end;

function TcxGridBandsViewInfo.GetColumnHeadersAreaHeight: Integer;
begin
  if ShowColumnHeaders then
    Result := FContainerViewInfo.Specific.Height
  else
    Result := 0;
end;

function TcxGridBandsViewInfo.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxGridBandsViewInfo.GetGridView: TcxGridBandedTableView;
begin
  Result := FContainerViewInfo.GridView;
end;

function TcxGridBandsViewInfo.GetGridViewInfo: TcxGridBandedTableViewInfo;
begin
  Result := FContainerViewInfo.GridViewInfo;
end;

function TcxGridBandsViewInfo.GetInternalItem(Index: Integer): TcxGridBandViewInfo;
begin
  Result := FItems[Index];
end;

function TcxGridBandsViewInfo.GetItem(Index: Integer): TcxGridBandViewInfo;
begin
  Result := InternalItems[Index];
  if Result = nil then
  begin
    Result := GetItemClass.Create(Self, Index);
    FItems[Index] := Result;
  end;
end;

function TcxGridBandsViewInfo.GetLastFixedItem(AFixedKind: TcxGridBandFixedKind): TcxGridBandViewInfo;
begin
  Result := nil;
  case AFixedKind of
    fkLeft:
      if Bands.VisibleLeftFixedCount <> 0 then
        Result := Items[Bands.VisibleLeftFixedCount - 1];
    fkRight:
      if Bands.VisibleRightFixedCount <> 0 then
        Result := Items[Count - Bands.VisibleRightFixedCount];
  end;
end;

function TcxGridBandsViewInfo.GetLineCount: Integer;

  function CalculateLineCount: Integer;
  var
    I, ALineCount: Integer;
  begin
    Result := 0;
    for I := 0 to Count - 1 do
    begin
      ALineCount := Items[I].LineCount;
      if ALineCount > Result then Result := ALineCount;
    end;
  end;

begin
  if FLineCount = -1 then
    FLineCount := CalculateLineCount;
  Result := FLineCount;
end;

function TcxGridBandsViewInfo.GetRowCount: Integer;

  function CalculateRowCount: Integer;
  var
    I, ARowCount: Integer;
  begin
    Result := 0;
    for I := 0 to Count - 1 do
    begin
      ARowCount := Items[I].RowCount;
      if ARowCount > Result then Result := ARowCount;
    end;
  end;

begin
  if FRowCount = -1 then
    FRowCount := CalculateRowCount;
  Result := FRowCount;
end;

procedure TcxGridBandsViewInfo.CreateItems;
begin
  FItems := TList.Create;
  FItems.Count := GridView.Bands.VisibleCount;
end;

procedure TcxGridBandsViewInfo.DestroyItems;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    InternalItems[I].Free;
  FItems.Free;
end;

procedure TcxGridBandsViewInfo.Calculate;
var
  AScrollableAreaBounds, ABounds: TRect;

  procedure ProcessLeftFixedItems;
  var
    I: Integer;
  begin
    ABounds := ContainerViewInfo.Bounds;
    for I := 0 to Count - 1 do
      if Items[I].FixedKind = fkLeft then
      begin
        ABounds.Right := ABounds.Left + Items[I].Width;
        Items[I].Calculate(ABounds);
        ABounds.Left := ABounds.Right;
      end;
    AScrollableAreaBounds.Left := ABounds.Left;
  end;

  procedure ProcessRightFixedItems;
  var
    I: Integer;

    {function GetOffset: Integer;
    begin
      Result := GridViewInfo.ScrollableAreaWidth - GridViewInfo.DataWidth;
      if Result < 0 then Result := 0;
    end;}

  begin
    ABounds := ContainerViewInfo.Bounds;
    //Dec(ABounds.Right, GetOffset);
    for I := Count - 1 downto 0 do
      if Items[I].FixedKind = fkRight then
      begin
        ABounds.Left := ABounds.Right - Items[I].Width;
        Items[I].Calculate(ABounds);
        ABounds.Right := ABounds.Left;
      end;
    AScrollableAreaBounds.Right := ABounds.Right;
  end;

  procedure ProcessNonFixedItems;
  var
    I: Integer;
  begin
    ABounds := AScrollableAreaBounds;
    if not FContainerViewInfo.IsScrollable then
      Dec(ABounds.Left, GridViewInfo.LeftPos);
    for I := 0 to Count - 1 do
      if Items[I].FixedKind = fkNone then
      begin
        ABounds.Right := ABounds.Left + Items[I].Width;
        Items[I].Calculate(ABounds);
        ABounds.Left := ABounds.Right;
      end;
  end;

begin
  AScrollableAreaBounds := ContainerViewInfo.Bounds;
  ProcessLeftFixedItems;
  ProcessRightFixedItems;
  ProcessNonFixedItems;
end;

function TcxGridBandsViewInfo.CalculateBandHeadersAreaHeight: Integer;
var
  I, AHeight: Integer;
begin
  if IsBandHeaderHeightAssigned then
    Result := GridView.OptionsView.BandHeaderHeight
  else
  begin
    Result := 0;
    for I := 0 to Count - 1 do
    begin
      AHeight := Items[I].HeaderViewInfo.CalculateHeight;
      if AHeight > Result then Result := AHeight;
    end;
    Result := Result * GridView.OptionsView.BandHeaderLineCount;
  end;  
end;

procedure TcxGridBandsViewInfo.CalculateColumnWidths;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].CalculateColumnWidths;
end;

function TcxGridBandsViewInfo.CalculateHeight: Integer;
begin
  Result := BandHeadersAreaHeight + ColumnHeadersAreaHeight;
end;

function TcxGridBandsViewInfo.CalculateWidth: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do
    Inc(Result, Items[I].CalculateWidth);
end;

function TcxGridBandsViewInfo.GetBandBackgroundBitmap: TBitmap;
begin
  Result := GridView.BackgroundBitmaps.GetBitmap(bbBandBackground);
end;

function TcxGridBandsViewInfo.GetBandHeaderBackgroundBitmap: TBitmap;
begin
  Result := GridView.BackgroundBitmaps.GetBitmap(bbBandHeader);
end;

function TcxGridBandsViewInfo.GetItemClass: TcxGridBandViewInfoClass;
begin
  Result := TcxGridBandViewInfo;
end;

function TcxGridBandsViewInfo.IsBandHeaderHeightAssigned: Boolean;
begin
  Result := GridView.OptionsView.BandHeaderHeight <> 0;
end;

function TcxGridBandsViewInfo.ShowBandHeaders: Boolean;
begin
  Result := GridView.OptionsView.BandHeaders;
end;

function TcxGridBandsViewInfo.ShowColumnHeaders: Boolean;
begin
  Result := GridView.OptionsView.Header;
end;

procedure TcxGridBandsViewInfo.AssignItemWidths;
var
  I: Integer;
begin
  GridView.BeginUpdate;
  try
    for I := 0 to Count - 1 do
      with Items[I] do
        Band.Width := ContentWidth;
  finally
    GridView.EndUpdate;
  end;
end;

function TcxGridBandsViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;

  procedure ProcessItems(AFixedKind: TcxGridBandFixedKind);
  var
    I: Integer;
  begin
    if Result = nil then
      for I := 0 to Count - 1 do
        if Items[I].FixedKind = AFixedKind then
        begin
          Result := Items[I].GetHitTest(P);
          if Result <> nil then Break;
        end;
  end;

begin
  Result := nil;
  ProcessItems(fkLeft);
  ProcessItems(fkRight);
  ProcessItems(fkNone);
end;

function TcxGridBandsViewInfo.IndexAtPos(const P: TPoint): Integer;
var
  R: TRect;
begin
  if Count <> 0 then
  begin
    R := Items[0].HeaderViewInfo.Bounds;
    InflateRect(R, 0, BandHeaderMovingZoneSize);
    for Result := 0 to Count do
    begin
      if Result = Count then
        R.Right := GridViewInfo.ClientBounds.Right
      else
        with Items[Result].HeaderViewInfo.Bounds do
          R.Right := (Left + Right) div 2;
      if PtInRect(R, P) then Exit;
      R.Left := R.Right;
    end;
  end;
  Result := -1;
end;

procedure TcxGridBandsViewInfo.Offset(DX, DY: Integer);
var
  I: Integer;
begin  {2}
  for I := 0 to Count - 1 do
    Items[I].DoOffset(DX, DY);
end;

{ TcxGridBandedHeaderViewInfoSpecific }

function TcxGridBandedHeaderViewInfoSpecific.GetGridViewInfo: TcxGridBandedTableViewInfo;
begin
  Result := TcxGridBandedTableViewInfo(inherited GridViewInfo);
end;

function TcxGridBandedHeaderViewInfoSpecific.CalculateHeight: Integer;
begin
  Result := GridViewInfo.HeaderViewInfo.LineCount * ItemHeight;
end;

{ TcxGridBandedHeaderViewInfo }

constructor TcxGridBandedHeaderViewInfo.Create(AGridViewInfo: TcxGridTableViewInfo);
begin
  inherited;
  FBandsViewInfo := GetBandsViewInfoClass.Create(Self);
end;

destructor TcxGridBandedHeaderViewInfo.Destroy;
begin
  FBandsViewInfo.Free;
  inherited;
end;

function TcxGridBandedHeaderViewInfo.GetGridView: TcxGridBandedTableView;
begin
  Result := TcxGridBandedTableView(inherited GridView);
end;

function TcxGridBandedHeaderViewInfo.GetGridViewInfo: TcxGridBandedTableViewInfo;
begin
  Result := TcxGridBandedTableViewInfo(inherited GridViewInfo);
end;

function TcxGridBandedHeaderViewInfo.GetItem(Index: Integer): TcxGridBandedColumnHeaderViewInfo;
begin
  Result := TcxGridBandedColumnHeaderViewInfo(inherited Items[Index]);
end;

function TcxGridBandedHeaderViewInfo.GetLineCount: Integer;
begin
  Result := FBandsViewInfo.LineCount;
end;

function TcxGridBandedHeaderViewInfo.GetRowCount: Integer;
begin
  Result := FBandsViewInfo.RowCount;
end;

function TcxGridBandedHeaderViewInfo.GetSpecific: TcxGridBandedHeaderViewInfoSpecific;
begin
  Result := TcxGridBandedHeaderViewInfoSpecific(inherited Specific);
end;

procedure TcxGridBandedHeaderViewInfo.CalculateColumnAutoWidths;
var
  AAutoWidthObject: TcxAutoWidthObject;
  I: Integer;
begin
  AAutoWidthObject := TcxAutoWidthObject.Create(FBandsViewInfo.Count);
  try
    for I := 0 to FBandsViewInfo.Count - 1 do
      FBandsViewInfo[I].InitAutoWidthItem(AAutoWidthObject.AddItem);
    AAutoWidthObject.AvailableWidth := GridViewInfo.ClientWidth;
    AAutoWidthObject.Calculate;
    for I := 0 to FBandsViewInfo.Count - 1 do
      FBandsViewInfo[I].Width := AAutoWidthObject[I].AutoWidth;
  finally
    AAutoWidthObject.Free;
  end;
end;

procedure TcxGridBandedHeaderViewInfo.CalculateColumnWidths;
begin
  inherited;
  FBandsViewInfo.CalculateColumnWidths;
end;

function TcxGridBandedHeaderViewInfo.CalculateHeight: Integer;
begin
  Result := FBandsViewInfo.CalculateHeight;
end;

procedure TcxGridBandedHeaderViewInfo.CalculateItems;
begin
  FBandsViewInfo.Calculate;
end;

function TcxGridBandedHeaderViewInfo.GetAutoHeight: Boolean;
begin
  Result := inherited GetAutoHeight and (LineCount = 1);
end;

function TcxGridBandedHeaderViewInfo.GetBandsViewInfoClass: TcxGridBandsViewInfoClass;
begin
  Result := TcxGridBandsViewInfo;
end;

function TcxGridBandedHeaderViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := nil;
end;

function TcxGridBandedHeaderViewInfo.GetIsScrollable: Boolean;
begin
  Result := FBandsViewInfo.Bands.Layout in [blNonFixed, blRightFixed];
end;

function TcxGridBandedHeaderViewInfo.GetItemClass: TcxGridColumnHeaderViewInfoClass;
begin
  Result := TcxGridBandedColumnHeaderViewInfo;
end;

function TcxGridBandedHeaderViewInfo.GetItemsAreaBounds: TRect;
begin
  Result := inherited GetItemsAreaBounds;
  Inc(Result.Top, FBandsViewInfo.BandHeadersAreaHeight);
end;

function TcxGridBandedHeaderViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridBandedHeaderPainter;
end;

function TcxGridBandedHeaderViewInfo.GetVisible: Boolean;
begin
  with FBandsViewInfo do
    Result := ShowBandHeaders or ShowColumnHeaders;
end;

function TcxGridBandedHeaderViewInfo.GetWidth: Integer;
begin
  Result := FBandsViewInfo.CalculateWidth;
end;

function TcxGridBandedHeaderViewInfo.IsHeightAssigned: Boolean;
begin
  Result := inherited IsHeightAssigned and (LineCount = 1);
end;

procedure TcxGridBandedHeaderViewInfo.Offset(DX, DY: Integer);
begin       {2}
  inherited;
  FBandsViewInfo.Offset(DX, 0);
end;

function TcxGridBandedHeaderViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
var
  ABand: TcxGridBand;
  AHitTest: TcxCustomGridHitTest;
begin
  Result := FBandsViewInfo.GetHitTest(P);
  if (Result is TcxGridBandHitTest) and FBandsViewInfo.ShowColumnHeaders then
  begin
    ABand := TcxGridBandHitTest(Result).Band;
    AHitTest := inherited GetHitTest(P);
    if AHitTest is TcxCustomGridColumnHitTest and
      ((TcxCustomGridColumnHitTest(AHitTest).Column as TcxGridBandedColumn).Position.Band = ABand) then
      Result := AHitTest;
  end;
end;

function TcxGridBandedHeaderViewInfo.GetZone(const P: TPoint): TcxGridColumnContainerZone;
var
  AHitTest: TcxCustomGridHitTest;
  AColumn: TcxGridBandedColumn;
  ABounds: TRect;
  ABand: TcxGridBand;
  ARowIndex: Integer;
begin
  Result := nil;
  AHitTest := GridViewInfo.GetHitTest(P);
  if GridViewInfo.Controller.CanHandleHitTest(AHitTest) then
    if AHitTest is TcxCustomGridColumnHitTest then
    begin
      AColumn := TcxGridBandedColumn(TcxCustomGridColumnHitTest(AHitTest).Column);
      ABounds := Items[AColumn.VisibleIndex].Bounds;
      with AColumn.Position do
        Result := TcxGridBandedColumnContainerZone.Create(AColumn.VisibleIndex, Band,
          VisibleColIndex + Ord(P.X >= (ABounds.Left + ABounds.Right) div 2), VisibleRowIndex);
    end
    else
      if AHitTest is TcxGridBandHitTest then
      begin
        with TcxGridBandHitTest(AHitTest) do
        begin
          ABand := Band;
          ARowIndex := VisibleRowIndex;
        end;
        if ARowIndex <> -1 then
        begin
          if ARowIndex <> ABand.Rows.VisibleCount then
            Inc(ARowIndex);
          Result := TcxGridBandedColumnContainerZone.Create(-1, ABand, 0, ARowIndex);
        end;
      end;
end;

{ TcxGridBandedDataRowCellsAreaItemViewInfo }

constructor TcxGridBandedDataRowCellsAreaItemViewInfo.Create(ACellsAreaViewInfo: TcxGridBandedDataRowCellsAreaViewInfo;
  ABandViewInfo: TcxGridBandViewInfo);
begin
  inherited Create(ACellsAreaViewInfo.RecordViewInfo);
  FCellsAreaViewInfo := ACellsAreaViewInfo;
  FBandViewInfo := ABandViewInfo;
  CreateLineBounds;
end;

destructor TcxGridBandedDataRowCellsAreaItemViewInfo.Destroy;
begin
  DestroyLineBounds;
  inherited;
end;

function TcxGridBandedDataRowCellsAreaItemViewInfo.GetFixedBandsSeparatorLocation: TcxGridFixedBandsSeparatorLocation;
begin
  if bLeft in FBandViewInfo.Borders then
    Result := slLeft
  else
    if bRight in FBandViewInfo.Borders then
      Result := slRight
    else
      Result := slNone;
end;

function TcxGridBandedDataRowCellsAreaItemViewInfo.GetGridViewInfo: TcxGridBandedTableViewInfo;
begin
  Result := TcxGridBandedTableViewInfo(inherited GridViewInfo);
end;

function TcxGridBandedDataRowCellsAreaItemViewInfo.GetLineBounds(Index: Integer): TRect;
begin
  Result := PRect(FLineBounds[Index])^;
end;

function TcxGridBandedDataRowCellsAreaItemViewInfo.GetLineCount: Integer;
begin
  Result := FLineBounds.Count;
end;

function TcxGridBandedDataRowCellsAreaItemViewInfo.GetRecordsViewInfo: TcxGridBandedRowsViewInfo;
begin
  Result := TcxGridBandedRowsViewInfo(RecordViewInfo.RecordsViewInfo);
end;

function TcxGridBandedDataRowCellsAreaItemViewInfo.GetRecordViewInfo: TcxGridDataRowViewInfo;
begin
  Result := TcxGridDataRowViewInfo(inherited RecordViewInfo);
end;

procedure TcxGridBandedDataRowCellsAreaItemViewInfo.ClearLines;
var
  I: Integer;
begin
  for I := 0 to LineCount - 1 do
    Dispose(PRect(FLineBounds[I]));
  FLineBounds.Clear;
end;

procedure TcxGridBandedDataRowCellsAreaItemViewInfo.CreateLineBounds;
begin
  FLineBounds := TList.Create;
end;

procedure TcxGridBandedDataRowCellsAreaItemViewInfo.DestroyLineBounds;
begin
  ClearLines;
  FLineBounds.Free;
end;

procedure TcxGridBandedDataRowCellsAreaItemViewInfo.AddLine(const ABounds: TRect);
var
  ALineBounds: PRect;
begin
  New(ALineBounds);
  ALineBounds^ := ABounds;
  FLineBounds.Add(ALineBounds);
end;

procedure TcxGridBandedDataRowCellsAreaItemViewInfo.AddLines;

  procedure AddCellsLines(AShowLeftLines, AShowTopLines: Boolean);
  var
    I: Integer;
    ACellViewInfo: TcxGridDataCellViewInfo;
    APosition: TcxGridBandedColumnPosition;
    R: TRect;

    procedure AddLeftLine;
    begin
      R := ACellViewInfo.Bounds;
      R.Right := R.Left;
      Dec(R.Left, GridViewInfo.GridLineWidth);
      AddLine(R);
    end;

    procedure AddTopLine;
    begin
      R := ACellViewInfo.Bounds;
      R.Bottom := R.Top;
      Dec(R.Top, GridViewInfo.GridLineWidth);
      AddLine(R);
    end;

  begin
    if not (AShowLeftLines or AShowTopLines) then Exit;
    for I := 0 to FBandViewInfo.ColumnViewInfoCount - 1 do
    begin
      ACellViewInfo := RecordViewInfo.InternalCellViewInfos[FBandViewInfo[I].Index];
      if ACellViewInfo <> nil then
      begin
        APosition := TcxGridBandedColumn(ACellViewInfo.Item).Position;
        if AShowLeftLines and (APosition.VisibleColIndex > 0) then
          AddLeftLine;
        if AShowTopLines and (APosition.VisibleRowIndex > 0) then
          AddTopLine;
      end;
    end;
  end;

begin
  if Borders <> [] then
    AddCellsLines(RecordsViewInfo.ShowCellLeftLines, RecordsViewInfo.ShowCellTopLines);
end;

function TcxGridBandedDataRowCellsAreaItemViewInfo.CalculateWidth: Integer;
begin
  Result := 0;
end;

function TcxGridBandedDataRowCellsAreaItemViewInfo.GetBorders: TcxBorders;
begin
  Result := RecordViewInfo.GetCellBorders(BandViewInfo.IsRight, CellsAreaViewInfo.IsBottom);
  if GridViewInfo.FixedBandSeparatorWidth <> 0 then
    Result := Result - FBandViewInfo.Borders;
end;

function TcxGridBandedDataRowCellsAreaItemViewInfo.GetFixedBandsSeparatorBounds: TRect;
begin
  Result := ContentBounds;
  with Result do
    case FixedBandsSeparatorLocation of
      slLeft:
        Right := Left + GridViewInfo.FixedBandSeparatorWidth;
      slRight:
        Left := Right - GridViewInfo.FixedBandSeparatorWidth;
    end;
end;

function TcxGridBandedDataRowCellsAreaItemViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridBandedDataRowCellsAreaItemPainter;
end;

procedure TcxGridBandedDataRowCellsAreaItemViewInfo.GetViewParams(var AParams: TcxViewParams);
var
  ACellPos: TcxGridDataCellPos;
begin
  if RecordViewInfo.Selected then
    inherited
  else
  begin
    ACellPos := TcxGridDataCellPos.Create;
    try
      with TcxGridDataCellPos(ACellPos) do
      begin
        GridRecord := RecordViewInfo.GridRecord;
        Item := nil;
      end;
      FBandViewInfo.Band.Styles.GetViewParams(bsContent, ACellPos, nil, AParams);
    finally
      ACellPos.Free;
    end;
  end;
end;

procedure TcxGridBandedDataRowCellsAreaItemViewInfo.Offset(DX, DY: Integer);
begin       {2}
  inherited;
  ClearLines;
  AddLines;
end;

procedure TcxGridBandedDataRowCellsAreaItemViewInfo.BeforeRecalculation;
begin
  inherited;
  ClearLines;
  RecordViewInfo.BeforeCellRecalculation(Self);
end;

procedure TcxGridBandedDataRowCellsAreaItemViewInfo.Calculate(ALeftBound, ATopBound: Integer;
  AWidth: Integer = -1; AHeight: Integer = -1);
begin
  inherited;
  AddLines;
end;

function TcxGridBandedDataRowCellsAreaItemViewInfo.CanDrawSelected: Boolean;
begin
  Result := True;
end;

{ TcxGridBandedDataRowCellsAreaViewInfo }

constructor TcxGridBandedDataRowCellsAreaViewInfo.Create(ARecordViewInfo: TcxCustomGridRecordViewInfo);
begin
  inherited;
  CreateItems;
end;

destructor TcxGridBandedDataRowCellsAreaViewInfo.Destroy;
begin
  DestroyItems;
  inherited;
end;

function TcxGridBandedDataRowCellsAreaViewInfo.GetBandsViewInfo: TcxGridBandsViewInfo;
begin
  Result := GridViewInfo.HeaderViewInfo.BandsViewInfo;
end;

function TcxGridBandedDataRowCellsAreaViewInfo.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxGridBandedDataRowCellsAreaViewInfo.GetGridViewInfo: TcxGridBandedTableViewInfo;
begin
  Result := TcxGridBandedTableViewInfo(inherited GridViewInfo);
end;

function TcxGridBandedDataRowCellsAreaViewInfo.GetItem(Index: Integer): TcxGridBandedDataRowCellsAreaItemViewInfo;
begin
  Result := FItems[Index];
end;

procedure TcxGridBandedDataRowCellsAreaViewInfo.CreateItems;
var
  I: Integer;
begin
  FItems := TList.Create;
  for I := 0 to BandsViewInfo.Count - 1 do
    FItems.Add(GetItemClass.Create(Self, BandsViewInfo[I]));
end;

procedure TcxGridBandedDataRowCellsAreaViewInfo.DestroyItems;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do Items[I].Free;
  FItems.Free;
end;

function TcxGridBandedDataRowCellsAreaViewInfo.CalculateVisible: Boolean;
begin
  Result := TcxGridBandedRowsViewInfo(RecordViewInfo.RecordsViewInfo).RowCellsAreaVisible;
end;

function TcxGridBandedDataRowCellsAreaViewInfo.GetItemClass: TcxGridBandedDataRowCellsAreaItemViewInfoClass;
begin
  Result := TcxGridBandedDataRowCellsAreaItemViewInfo;
end;

procedure TcxGridBandedDataRowCellsAreaViewInfo.Offset(DX, DY: Integer);
var
  I: Integer;
begin       {2}
  inherited;
  for I := 0 to Count - 1 do
    Items[I].DoOffset(DX, DY);
end;

procedure TcxGridBandedDataRowCellsAreaViewInfo.BeforeRecalculation;
var
  I: Integer;
begin
  inherited;
  for I := 0 to Count - 1 do
    Items[I].BeforeRecalculation;
end;

procedure TcxGridBandedDataRowCellsAreaViewInfo.Calculate(ALeftBound, ATopBound: Integer;
  AWidth: Integer = -1; AHeight: Integer = -1);
var
  R: TRect;
  I: Integer;
begin
  inherited;
  R := Bounds;
  for I := 0 to Count - 1 do
  begin
    with Items[I].BandViewInfo.Bounds do
    begin
      if I <> 0 then R.Left := Left;
      R.Right := Right;
    end;
    Items[I].Calculate(R);
  end;
end;

{ TcxGridBandedRowsViewInfo }

function TcxGridBandedRowsViewInfo.GetHeaderViewInfo: TcxGridBandedHeaderViewInfo;
begin
  Result := TcxGridBandedHeaderViewInfo(inherited HeaderViewInfo);
end;

function TcxGridBandedRowsViewInfo.GetLineCount: Integer;
begin
  Result := HeaderViewInfo.LineCount;
end;

function TcxGridBandedRowsViewInfo.GetRowCount: Integer;
begin
  Result := HeaderViewInfo.BandsViewInfo.RowCount;
end;

function TcxGridBandedRowsViewInfo.CalculateDataRowHeight: Integer;
begin
  Result := inherited CalculateDataRowHeight;
  if HeaderViewInfo.LineCount <> 0 then
    Result := Result * HeaderViewInfo.LineCount;
end;

function TcxGridBandedRowsViewInfo.CalculateRowCellsAreaVisible: Boolean;
var
  I: Integer;
begin
  with HeaderViewInfo.BandsViewInfo do
  begin
    Result := LineCount > 1;
    if not Result then
      for I := 0 to Count - 1 do
        with Items[I] do
          if (ColumnViewInfoCount = 0) or (FixedKind <> fkNone) or AreAllColumnsFixed then
          begin
            Result := True;
            Break;
          end;
  end;
end;

function TcxGridBandedRowsViewInfo.GetAutoDataRecordHeight: Boolean;
begin
  Result := inherited GetAutoDataRecordHeight and (HeaderViewInfo.LineCount = 1);
end;

function TcxGridBandedRowsViewInfo.GetPainterClass: TcxCustomGridRecordsPainterClass;
begin
  Result := TcxGridBandedRowsPainter;
end;

function TcxGridBandedRowsViewInfo.GetRowWidth: Integer;
var
  AClientWidth: Integer;
begin
  Result := inherited GetRowWidth;
  AClientWidth := GridViewInfo.ClientWidth;
  if Result > AClientWidth then
    case HeaderViewInfo.BandsViewInfo.Bands.Layout of
      blLeftFixed:
        Dec(Result, GridViewInfo.LeftPos);
      blRightFixed:
        Result := AClientWidth + GridViewInfo.LeftPos;
      blLeftRightFixed:
        Result := AClientWidth;
    end;
end;

function TcxGridBandedRowsViewInfo.GetShowBandSeparators: Boolean;
begin
  Result := (LineCount > 1) and (GridLines in [glBoth, glVertical]);
end;

function TcxGridBandedRowsViewInfo.GetShowCellLeftLines: Boolean;
begin
  Result := (LineCount > 1) and (GridLines in [glBoth, glVertical]);
end;

function TcxGridBandedRowsViewInfo.GetShowCellTopLines: Boolean;
begin
  Result := (RowCount > 1) and (GridLines = glBoth);
end;

procedure TcxGridBandedRowsViewInfo.AfterConstruction;
begin
  FRowCellsAreaVisible := CalculateRowCellsAreaVisible;
  inherited;
end;

function TcxGridBandedRowsViewInfo.CanDataRowSize: Boolean;
begin
  Result := inherited CanDataRowSize and (HeaderViewInfo.LineCount = 1);
end;

function TcxGridBandedRowsViewInfo.GetDataRowCellsAreaViewInfoClass: TClass;
begin
  Result := TcxGridBandedDataRowCellsAreaViewInfo;
end;

function TcxGridBandedRowsViewInfo.IsDataRowHeightAssigned: Boolean;
begin
  Result := inherited IsDataRowHeightAssigned and (HeaderViewInfo.LineCount = 1);
end;

{ TcxGridBandedTableViewInfo }

function TcxGridBandedTableViewInfo.GetController: TcxGridBandedTableController;
begin
  Result := TcxGridBandedTableController(inherited Controller);
end;

function TcxGridBandedTableViewInfo.GetFixedBandSeparatorColor: TColor;
begin
  Result := GridView.OptionsView.GetFixedBandSeparatorColor;
end;

function TcxGridBandedTableViewInfo.GetFixedBandSeparatorWidth: Integer;
begin
  Result := GridView.OptionsView.FixedBandSeparatorWidth;
end;

function TcxGridBandedTableViewInfo.GetGridView: TcxGridBandedTableView;
begin
  Result := TcxGridBandedTableView(inherited GridView);
end;

function TcxGridBandedTableViewInfo.GetHeaderViewInfo: TcxGridBandedHeaderViewInfo;
begin
  Result := TcxGridBandedHeaderViewInfo(inherited HeaderViewInfo);
end;

function TcxGridBandedTableViewInfo.GetFooterPainterClass: TcxGridFooterPainterClass;
begin
  Result := TcxGridBandedFooterPainter;
end;

function TcxGridBandedTableViewInfo.GetHeaderViewInfoClass: TcxGridHeaderViewInfoClass;
begin
  Result := TcxGridBandedHeaderViewInfo;
end;

function TcxGridBandedTableViewInfo.GetHeaderViewInfoSpecificClass: TcxGridHeaderViewInfoSpecificClass;
begin
  Result := TcxGridBandedHeaderViewInfoSpecific;
end;

function TcxGridBandedTableViewInfo.GetRecordsViewInfoClass: TcxCustomGridRecordsViewInfoClass;
begin
  Result := TcxGridBandedRowsViewInfo;
end;

function TcxGridBandedTableViewInfo.GetScrollableAreaBoundsForEdit: TRect;
begin
  Result := inherited GetScrollableAreaBoundsForEdit;
  with ScrollableAreaBoundsHorz do
  begin
    Result.Left := Left;
    Result.Right := Right;
  end;  
end;

function TcxGridBandedTableViewInfo.GetScrollableAreaBoundsHorz: TRect;
begin
  Result := inherited GetScrollableAreaBoundsHorz;
  with GridView.Bands do
  begin
    if VisibleLeftFixedCount <> 0 then
      Result.Left := HeaderViewInfo.BandsViewInfo[GetLastVisibleIndex(fkLeft)].Bounds.Right;
    if VisibleRightFixedCount <> 0 then
      Result.Right := HeaderViewInfo.BandsViewInfo[GetFirstVisibleIndex(fkRight)].Bounds.Left;
  end;
end;

function TcxGridBandedTableViewInfo.CanOffset(ARecordCountDelta, DX, DY: Integer): Boolean;
begin
  Result := inherited CanOffset(ARecordCountDelta, DX, DY) and
    ((ARecordCountDelta <> 0) or (GridView.Bands.Layout = blNonFixed));
end;

function TcxGridBandedTableViewInfo.GetCellHeight(AIndex, ACellHeight: Integer): Integer;
begin
  Result := HeaderViewInfo[AIndex].Column.Position.LineCount * ACellHeight;
end;

function TcxGridBandedTableViewInfo.GetCellTopOffset(AIndex, ACellHeight: Integer): Integer;
begin
  with HeaderViewInfo, Items[AIndex].Column.Position do
    if (VisibleBandIndex = -1) or (VisibleRowIndex = -1) then
      Result := 0
    else
      Result := BandsViewInfo[VisibleBandIndex].RowsViewInfo[VisibleRowIndex].LineOffset * ACellHeight;
end;

{ TcxGridBandedColumnOptions }

constructor TcxGridBandedColumnOptions.Create(AItem: TcxCustomGridTableItem);
begin
  inherited;
  FVertSizing := True;
end;

procedure TcxGridBandedColumnOptions.SetVertSizing(Value: Boolean);
begin
  if FVertSizing <> Value then
  begin
    FVertSizing := Value;
    Changed;
  end;
end;

procedure TcxGridBandedColumnOptions.Assign(Source: TPersistent);
begin
  if Source is TcxGridBandedColumnOptions then
    with TcxGridBandedColumnOptions(Source) do
      Self.VertSizing := VertSizing;
  inherited;
end;

{ TcxGridBandedColumnStyles }

function TcxGridBandedColumnStyles.GetItem: TcxGridBandedColumn;
begin
  Result := TcxGridBandedColumn(inherited Item);
end;

procedure TcxGridBandedColumnStyles.GetDefaultViewParams(Index: Integer; AData: TObject;
  out AParams: TcxViewParams);
var
  ADataCellPos: TcxGridDataCellPos;
begin
  if (Index = isContent) and (Item.Position.Band <> nil) then
  begin
    ADataCellPos := TcxGridDataCellPos.Create;
    try
      with ADataCellPos do
      begin
        GridRecord := TcxCustomGridRecord(AData);
        Item := Self.Item;
      end;
      Item.Position.Band.Styles.GetViewParams(bsContent, ADataCellPos, nil, AParams);
    finally
      ADataCellPos.Free;
    end;
  end
  else
    inherited;
end;

{ TcxGridBandedColumnPosition }

constructor TcxGridBandedColumnPosition.Create(AItem: TcxCustomGridTableItem);
begin
  inherited;
  FColIndex := -1;
  FLineCount := 1;
  FRowIndex := -1;
end;

function TcxGridBandedColumnPosition.GetBandIndex: Integer;
begin
  if FBand = nil then
    Result := -1
  else
    Result := FBand.Index;
end;

function TcxGridBandedColumnPosition.GetColIndex: Integer;
begin
  if FBand = nil then
    Result := -1
  else
    Result := FBand.ColIndexOf(Item);
end;

function TcxGridBandedColumnPosition.GetGridView: TcxGridBandedTableView;
begin
  Result := TcxGridBandedTableView(inherited GridView);
end;

function TcxGridBandedColumnPosition.GetItem: TcxGridBandedColumn;
begin
  Result := TcxGridBandedColumn(inherited Item);
end;

function TcxGridBandedColumnPosition.GetRow: TcxGridBandRow;
begin
  if RowIndex = -1 then
    Result := nil
  else
    Result := FBand.Rows[RowIndex];
end;

function TcxGridBandedColumnPosition.GetRowIndex: Integer;
begin
  if FBand = nil then
    Result := -1
  else
    Result := FBand.RowIndexOf(Item);
end;

function TcxGridBandedColumnPosition.GetVisibleBandIndex: Integer;
begin
  if FBand = nil then
    Result := -1
  else
    Result := FBand.VisibleIndex;
end;

function TcxGridBandedColumnPosition.GetVisibleColIndex: Integer;
begin
  Result := RowIndex;
  if Result <> -1 then
    Result := Row.VisibleIndexOf(Item);
end;

function TcxGridBandedColumnPosition.GetVisibleRowIndex: Integer;
begin
  Result := RowIndex;
  if Result <> -1 then
    Result := Row.VisibleIndex;
end;

procedure TcxGridBandedColumnPosition.SetBandIndex(Value: Integer);
var
  APrevVisible: Boolean;
begin
  if BandIndex <> Value then
  begin
    APrevVisible := Item.ActuallyVisible;
    GridView.BeginUpdate;
    try
      if BandIndex <> -1 then
        FBand.RemoveColumn(Item);
      if (0 <= Value) and (Value < GridView.Bands.Count) then
        GridView.Bands[Value].AddColumn(Item);
      if Item.ComponentState * [csReading, csUpdating] <> [] then
        FBandIndex := BandIndex;
      if Item.ActuallyVisible <> APrevVisible then
        GridView.ItemVisibilityChanged(Item, Item.ActuallyVisible)
      else
        GridView.RefreshVisibleItemsList;
      GridView.SizeChanged;
    finally
      GridView.EndUpdate;
    end;
  end;
end;

procedure TcxGridBandedColumnPosition.SetColIndex(Value: Integer);
begin

  if Item.IsUpdating then Exit;

  if FBand <> nil then
    if Item.IsLoading then
      FColIndex := Value
    else
      if Value >= 0 then
      begin
        FBand.MoveColumn(Item, RowIndex, Value);
        GridView.SizeChanged;
      end;
end;

procedure TcxGridBandedColumnPosition.SetLineCount(Value: Integer);
begin
  CheckLineCount(Value);
  if FLineCount <> Value then
  begin
    FLineCount := Value;
    GridView.SizeChanged;
  end;
end;

procedure TcxGridBandedColumnPosition.SetRowIndex(Value: Integer);
begin

  if Item.IsUpdating then Exit;

  if (FBand <> nil) and (RowIndex <> Value) then
    if Item.IsLoading then
      FRowIndex := Value
    else
      if Value >= 0 then
      begin
        FBand.MoveColumn(Item, Value, -1);
        GridView.SizeChanged;
      end;
end;

procedure TcxGridBandedColumnPosition.DefineProperties(Filer: TFiler);
begin
  inherited;
end;

procedure TcxGridBandedColumnPosition.CheckLineCount(var Value: Integer);
begin
  if Value < 1 then Value := 1;
end;

procedure TcxGridBandedColumnPosition.SaveParams;
begin
  FBandIndex := BandIndex;
  FColIndex := ColIndex;
  FRowIndex := RowIndex;
end;

procedure TcxGridBandedColumnPosition.Assign(Source: TPersistent);
begin
  if Source is TcxGridBandedColumnPosition then
    with TcxGridBandedColumnPosition(Source) do
    begin
      Self.BandIndex := BandIndex;
      Self.RowIndex := RowIndex;
      Self.ColIndex := ColIndex;
    end;
  inherited;
end;

{ TcxGridBandedColumn }

destructor TcxGridBandedColumn.Destroy;
begin
  FPosition.BandIndex := -1;
  inherited;
end;

function TcxGridBandedColumn.GetGridView: TcxGridBandedTableView;
begin
  Result := TcxGridBandedTableView(inherited GridView);
end;

function TcxGridBandedColumn.GetOptions: TcxGridBandedColumnOptions;
begin
  Result := TcxGridBandedColumnOptions(inherited Options);
end;

function TcxGridBandedColumn.GetStyles: TcxGridBandedColumnStyles;
begin
  Result := TcxGridBandedColumnStyles(inherited Styles);
end;

procedure TcxGridBandedColumn.SetOptions(Value: TcxGridBandedColumnOptions);
begin
  inherited Options := Value;
end;

procedure TcxGridBandedColumn.SetPosition(Value: TcxGridBandedColumnPosition);
begin
  FPosition.Assign(Value);
end;

procedure TcxGridBandedColumn.SetStyles(Value: TcxGridBandedColumnStyles);
begin
  inherited Styles := Value;
end;

function TcxGridBandedColumn.GetStoredProperties(AProperties: TStrings): Boolean;
begin
  inherited GetStoredProperties(AProperties);
  with AProperties do
  begin
    Add('BandIndex');
    Add('ColIndex');
    Add('RowIndex');
    Add('LineCount');
  end;
  Result := True;
end;

procedure TcxGridBandedColumn.GetPropertyValue(const AName: string; var AValue: Variant);
begin
  if AName = 'BandIndex' then
    AValue := Position.BandIndex
  else
    if AName = 'ColIndex' then
      AValue := Position.ColIndex
    else
      if AName = 'RowIndex' then
        AValue := Position.RowIndex
      else
        if AName = 'LineCount' then
          AValue := Position.LineCount
        else
          inherited;
end;

procedure TcxGridBandedColumn.SetPropertyValue(const AName: string; const AValue: Variant);
begin
  if AName = 'BandIndex' then
    Position.BandIndex := AValue
  else
    if AName = 'ColIndex' then
      Position.FColIndex := AValue
    else
      if AName = 'RowIndex' then
        Position.FRowIndex := AValue
      else
        if AName = 'LineCount' then
          Position.LineCount := AValue
        else
          inherited;
end;

procedure TcxGridBandedColumn.CreateSubClasses;
begin
  inherited;
  FPosition := TcxGridBandedColumnPosition.Create(Self);
end;

procedure TcxGridBandedColumn.DestroySubClasses;
begin
  FreeAndNil(FPosition);
  inherited;
end;

procedure TcxGridBandedColumn.AssignColumnWidths;

  function GetRowViewInfo: TcxGridBandRowViewInfo;
  begin
    with GridView.ViewInfo.HeaderViewInfo do
      Result := BandsViewInfo[Position.VisibleBandIndex].RowsViewInfo[Position.VisibleRowIndex];
  end;

begin
  GetRowViewInfo.AssignColumnWidths;
  inherited;
end;

function TcxGridBandedColumn.CanScroll: Boolean;
begin
  Result := inherited CanScroll and
    (Position.Band <> nil) and (Position.Band.FixedKind = fkNone);
end;

function TcxGridBandedColumn.CanVertSize: Boolean;
begin
  Result := GridView.OptionsCustomize.ColumnVertSizing and Options.VertSizing;
end;

function TcxGridBandedColumn.GetActuallyVisible: Boolean;
begin
  Result := inherited GetActuallyVisible and
    (Position.Band <> nil) and Position.Band.Visible;
end;

function TcxGridBandedColumn.GetEditPartVisible: Boolean;
begin
  if CanScroll then
    Result := inherited GetEditPartVisible
  else
    Result := IsRectEmpty(GridView.ViewInfo.ScrollableAreaBoundsForEdit);
end;

function TcxGridBandedColumn.GetIsBottom: Boolean;
begin
  Result := (Position.Row <> nil) and Position.Row.IsLast;
end;

function TcxGridBandedColumn.GetIsLeft: Boolean;
begin
  Result := Position.VisibleColIndex = 0;
end;

function TcxGridBandedColumn.GetIsMostBottom: Boolean;
begin
  Result := IsBottom and
    (Position.VisibleRowIndex = GridView.Bands.VisibleRowCount - 1);
end;

function TcxGridBandedColumn.GetIsMostLeft: Boolean;
begin
  Result := IsLeft and Position.Band.IsFirst;
end;

function TcxGridBandedColumn.GetIsMostRight: Boolean;
begin
  Result := IsRight and Position.Band.IsLast;
end;

function TcxGridBandedColumn.GetIsRight: Boolean;
begin
  Result := (Position.Row <> nil) and
    (Position.VisibleColIndex = Position.Row.VisibleCount - 1);
end;

function TcxGridBandedColumn.GetOptionsClass: TcxCustomGridTableItemOptionsClass;
begin
  Result := TcxGridBandedColumnOptions;
end;

function TcxGridBandedColumn.GetStylesClass: TcxCustomGridTableItemStylesClass;
begin
  Result := TcxGridBandedColumnStyles;
end;

procedure TcxGridBandedColumn.Assign(Source: TPersistent);
begin
  if Source is TcxGridBandedColumn then
    with TcxGridBandedColumn(Source) do
    begin
      Self.Position := Position;
    end;
  inherited;
end;

{ TcxGridBandRow }

constructor TcxGridBandRow.Create(ABandRows: TcxGridBandRows);
begin
  inherited Create;
  FBandRows := ABandRows;
  FItems := TList.Create;
  FVisibleItems := TList.Create;
end;

destructor TcxGridBandRow.Destroy;
begin
  FBandRows.RemoveItem(Self);
  FVisibleItems.Free;
  FItems.Free;
  inherited;
end;

function TcxGridBandRow.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxGridBandRow.GetIndex: Integer;
begin
  Result := FBandRows.FItems.IndexOf(Self);
end;

function TcxGridBandRow.GetIsFirst: Boolean;
begin
  Result := VisibleIndex = 0;
end;

function TcxGridBandRow.GetIsLast: Boolean;
begin
  Result := VisibleIndex = FBandRows.VisibleCount - 1;
end;

function TcxGridBandRow.GetItem(Index: Integer): TcxGridBandedColumn;
begin
  Result := FItems[Index];
end;

function TcxGridBandRow.GetLineCount: Integer;
var
  I, ALineCount: Integer;
begin
  Result := 1;
  for I := 0 to VisibleCount - 1 do
  begin
    ALineCount := VisibleItems[I].Position.LineCount;
    if ALineCount > Result then Result := ALineCount;
  end;
end;

function TcxGridBandRow.GetLineOffset: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to VisibleIndex - 1 do
    Inc(Result, FBandRows.VisibleItems[I].LineCount);
end;

function TcxGridBandRow.GetVisible: Boolean;
begin
  Result := (VisibleCount <> 0) or (Count = 0); // for new just inserted empty rows
end;

function TcxGridBandRow.GetVisibleCount: Integer;
begin
  Result := FVisibleItems.Count;
end;

function TcxGridBandRow.GetVisibleIndex: Integer;
begin
  Result := FBandRows.FVisibleItems.IndexOf(Self);
end;

function TcxGridBandRow.GetVisibleItem(Index: Integer): TcxGridBandedColumn;
begin
  Result := FVisibleItems[Index];
end;

procedure TcxGridBandRow.CheckIndexForInsert(var AIndex: Integer; AExistingItem: Boolean);
begin
  if AIndex < 0 then AIndex := 0;
  if AIndex > Count - Ord(AExistingItem) then AIndex := Count - Ord(AExistingItem);
end;

procedure TcxGridBandRow.RefreshVisibleItemsList;
var
  I: Integer;
begin
  FVisibleItems.Clear;
  for I := 0 to Count - 1 do
    if Items[I].Visible then
      FVisibleItems.Add(Items[I]);
  FBandRows.RefreshVisibleItemsList;    
end;

procedure TcxGridBandRow.ApplyBestFit;
var
  I: Integer;
begin
  for I := 0 to VisibleCount - 1 do
    VisibleItems[I].ApplyBestFit;
end;

procedure TcxGridBandRow.Delete(AIndex: Integer);
begin
  FItems.Delete(AIndex);
  if Count = 0 then
    Free
  else
    RefreshVisibleItemsList;
end;

function TcxGridBandRow.IndexOf(AColumn: TcxGridBandedColumn): Integer;
begin
  Result := FItems.IndexOf(AColumn);
end;

procedure TcxGridBandRow.Insert(AIndex: Integer; AColumn: TcxGridBandedColumn);
begin
  CheckIndexForInsert(AIndex, False);
  FItems.Insert(AIndex, AColumn);
  RefreshVisibleItemsList;
end;

procedure TcxGridBandRow.Move(ACurIndex, ANewIndex: Integer);
begin
  if ACurIndex < ANewIndex then Dec(ANewIndex);
  CheckIndexForInsert(ANewIndex, True);
  FItems.Move(ACurIndex, ANewIndex);
  RefreshVisibleItemsList;
end;

function TcxGridBandRow.VisibleIndexOf(AColumn: TcxGridBandedColumn): Integer;
begin
  Result := FVisibleItems.IndexOf(AColumn);
end;

{ TcxGridBandRows }

constructor TcxGridBandRows.Create(ABand: TcxGridBand);
begin
  inherited Create;
  FBand := ABand;
  FItems := TList.Create;
  FVisibleItems := TList.Create;
end;

destructor TcxGridBandRows.Destroy;
begin
  Count := 0;
  FVisibleItems.Free;
  FItems.Free;
  inherited;
end;

function TcxGridBandRows.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxGridBandRows.GetFirstVisible: TcxGridBandRow;
begin
  Result := VisibleItems[0];
end;

function TcxGridBandRows.GetGridView: TcxGridBandedTableView;
begin
  Result := FBand.GridView;
end;

function TcxGridBandRows.GetItem(Index: Integer): TcxGridBandRow;
begin
  Result := FItems[Index];
end;

function TcxGridBandRows.GetLastVisible: TcxGridBandRow;
begin
  Result := VisibleItems[VisibleCount - 1];
end;

function TcxGridBandRows.GetVisibleCount: Integer;
begin
  Result := FVisibleItems.Count;
end;

function TcxGridBandRows.GetVisibleItem(Index: Integer): TcxGridBandRow;
begin
  Result := FVisibleItems[Index];
end;

procedure TcxGridBandRows.SetCount(Value: Integer);
var
  APrevCount, I: Integer;
begin
  if Value < 0 then Value := 0;
  if Count <> Value then
  begin
    if Value > Count then
    begin
      APrevCount := Count;
      FItems.Count := Value;
      for I := APrevCount to Count - 1 do
        FItems[I] := TcxGridBandRow.Create(Self);
    end
    else
    begin
      for I := Value to Count - 1 do Items[I].Free;
      FItems.Count := Value;
    end;
    RefreshVisibleItemsList;
  end;
end;

procedure TcxGridBandRows.RemoveItem(ARow: TcxGridBandRow);
begin
  FItems.Remove(ARow);
  RefreshVisibleItemsList;
end;

procedure TcxGridBandRows.ColumnVisibilityChanged(AColumn: TcxGridBandedColumn);
begin
  if AColumn.Position.RowIndex <> -1 then
    Items[AColumn.Position.RowIndex].RefreshVisibleItemsList;
end;

procedure TcxGridBandRows.RefreshVisibleItemsList;
var
  I: Integer;
begin
  FVisibleItems.Clear;
  for I := 0 to Count - 1 do
    if Items[I].Visible then
      FVisibleItems.Add(Items[I]);
end;

procedure TcxGridBandRows.ApplyBestFit;
var
  I: Integer;
begin
  for I := 0 to VisibleCount - 1 do
    VisibleItems[I].ApplyBestFit;
end;

function TcxGridBandRows.GetLineIndex(ARowIndex: Integer): Integer;
begin
  Result := VisibleItems[ARowIndex].LineOffset;
end;

function TcxGridBandRows.GetRowIndex(ALineIndex: Integer): Integer;
begin
  for Result := 0 to VisibleCount - 1 do
    with VisibleItems[Result] do
      if (LineOffset <= ALineIndex) and (ALineIndex < LineOffset + LineCount) then
        Exit;
  Result := -1;
end;

function TcxGridBandRows.IndexOf(AColumn: TcxGridBandedColumn): Integer;
begin
  for Result := 0 to Count - 1 do
    if Items[Result].IndexOf(AColumn) <> -1 then Exit;
  Result := -1;
end;

function TcxGridBandRows.Insert(AIndex: Integer): TcxGridBandRow;
begin
  if AIndex > Count then AIndex := Count;
  Result := TcxGridBandRow.Create(Self);
  FItems.Insert(AIndex, Result);
  RefreshVisibleItemsList;
end;

procedure TcxGridBandRows.MoveColumn(AColumn: TcxGridBandedColumn; ARowIndex, AColIndex: Integer);
var
  AColumnColIndex, AColumnRowIndex, APrevCount: Integer;
begin
  AColumnRowIndex := AColumn.Position.RowIndex;
  AColumnColIndex := AColumn.Position.ColIndex;
  if AColumnRowIndex <> ARowIndex then
  begin
    if AColumnRowIndex <> -1 then
    begin
      APrevCount := Count;
      Items[AColumnRowIndex].Delete(AColumnColIndex);
      if (Count <> APrevCount) and (AColumnRowIndex < ARowIndex) then
        Dec(ARowIndex);
    end;
    if ARowIndex <> -1 then
    begin
      if ARowIndex > Count then ARowIndex := Count;
      if ARowIndex = Count then Count := ARowIndex + 1;
      if AColIndex = -1 then
        AColIndex := Items[ARowIndex].Count;
      Items[ARowIndex].Insert(AColIndex, AColumn);
    end;
  end
  else
    if (ARowIndex <> -1) and (AColumnColIndex <> AColIndex) then
      if AColumnColIndex = -1 then
        Items[ARowIndex].Insert(AColIndex, AColumn)
      else
        if AColIndex = -1 then
          Items[ARowIndex].Delete(AColumnColIndex)
        else
          Items[ARowIndex].Move(AColumnColIndex, AColIndex);
end;

{ TcxGridBandOptions }

constructor TcxGridBandOptions.Create(ABand: TcxGridBand);
begin
  inherited Create;
  FBand := ABand;
  FMoving := True;
  FSizing := True;
end;

procedure TcxGridBandOptions.Assign(Source: TPersistent);
begin
  if Source is TcxGridBandOptions then
    with TcxGridBandOptions(Source) do
    begin
      Self.HoldOwnColumnsOnly := HoldOwnColumnsOnly;
      Self.Moving := Moving;
      Self.Sizing := Sizing;
    end
  else
    inherited;
end;

{ TcxGridBandStyles }

function TcxGridBandStyles.GetBand: TcxGridBand;
begin
  Result := TcxGridBand(GetOwner);
end;

function TcxGridBandStyles.GetGridViewValue: TcxGridBandedTableView;
begin
  Result := TcxGridBandedTableView(inherited GridView);
end;

procedure TcxGridBandStyles.GetDefaultViewParams(Index: Integer; AData: TObject;
  out AParams: TcxViewParams);
begin
  case Index of
    bsBackground:
      GridView.Styles.GetViewParams(vsBandBackground, AData, nil, AParams);
    bsContent:
      with TcxGridDataCellPos(AData) do
        GridView.Styles.GetRecordContentParams(GridRecord, Item, AParams);
    bsHeader:
      GridView.Styles.GetBandHeaderParams(TcxGridBand(AData), AParams);
  else
    inherited;
  end;
end;

function TcxGridBandStyles.GetGridView: TcxCustomGridView;
begin
  Result := Band.GridView;
end;

procedure TcxGridBandStyles.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TcxGridBandStyles then
    with TcxGridBandStyles(Source) do
     begin
       Self.Background := Background;
       Self.Content := Content;
       Self.Header := Header;
       Self.OnGetHeaderStyle := OnGetHeaderStyle;
     end;
end;

procedure TcxGridBandStyles.GetHeaderParams(out AParams: TcxViewParams);
var
  AStyle: TcxStyle;
begin
  AStyle := nil;
  if Assigned(FOnGetHeaderStyle) then
    FOnGetHeaderStyle(GridView, Band, AStyle);
  GetViewParams(bsHeader, Band, AStyle, AParams);
end;

{ TcxGridBand }

constructor TcxGridBand.Create(Collection: TCollection);
begin
  inherited;
  FColumns := TList.Create;
  FHeaderAlignmentHorz := taCenter;
  FHeaderAlignmentVert := vaCenter;
  FOptions := GetOptionsClass.Create(Self);
  FRows := TcxGridBandRows.Create(Self);
  FStyles := GetStylesClass.Create(Self);
  FVisible := True;
  Bands.AddItem(Self);
end;

destructor TcxGridBand.Destroy;
var
  ABands: TcxGridBands;
  I: Integer;
begin
  ABands := Bands;
  if not GridView.IsDestroying then
    GridView.BeginUpdate;
  try
    for I := ColumnCount - 1 downto 0 do
      Columns[I].Position.BandIndex := -1;
  finally
    if not GridView.IsDestroying then
      GridView.CancelUpdate;
  end;
  FStyles.Free;
  FRows.Free;
  FOptions.Free;
  FColumns.Free;
  inherited;
  ABands.RemoveItem(Self);
end;

function TcxGridBand.GetBands: TcxGridBands;
begin
  Result := TcxGridBands(Collection);
end;

function TcxGridBand.GetColumnCount: Integer;
begin
  Result := FColumns.Count;
end;

function TcxGridBand.GetColumn(Index: Integer): TcxGridBandedColumn;
begin
  Result := FColumns[Index];
end;

function TcxGridBand.GetGridView: TcxGridBandedTableView;
begin
  Result := Bands.GridView;
end;

function TcxGridBand.GetIsFirst: Boolean;
begin
  Result := VisibleIndex = 0;
end;

function TcxGridBand.GetIsFirstNonEmpty: Boolean;
begin
  Result := Bands.FirstVisibleNonEmpty = Self;
end;

function TcxGridBand.GetIsLast: Boolean;
begin
  Result := VisibleIndex = Bands.VisibleCount - 1;
end;

function TcxGridBand.GetIsLastNonEmpty: Boolean;
begin
  Result := Bands.LastVisibleNonEmpty = Self;
end;

function TcxGridBand.GetVisibleIndex: Integer;
begin
  Result := Bands.FVisibleItems.IndexOf(Self);
end;

procedure TcxGridBand.SetCaption(const Value: string);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    GridView.LayoutChanged;
  end;
end;

procedure TcxGridBand.SetFixedKind(Value: TcxGridBandFixedKind);
begin
  if FFixedKind <> Value then
  begin
    FFixedKind := Value;
    GridView.RefreshVisibleItemsList;
    Bands.RefreshVisibleItemsList;
  end;
end;

procedure TcxGridBand.SetHeaderAlignmentHorz(Value: TAlignment);
begin
  if FHeaderAlignmentHorz <> Value then
  begin
    FHeaderAlignmentHorz := Value;
    GridView.LayoutChanged;
  end;
end;

procedure TcxGridBand.SetHeaderAlignmentVert(Value: TcxAlignmentVert);
begin
  if FHeaderAlignmentVert <> Value then
  begin
    FHeaderAlignmentVert := Value;
    GridView.LayoutChanged;
  end;
end;

procedure TcxGridBand.SetHidden(Value: Boolean);
begin
  if FHidden <> Value then
  begin
    FHidden := Value;
    HiddenChanged;
  end;
end;

procedure TcxGridBand.SetOptions(Value: TcxGridBandOptions);
begin
  FOptions.Assign(Value);
end;

procedure TcxGridBand.SetStyles(Value: TcxGridBandStyles);
begin
  FStyles.Assign(Value);
end;

procedure TcxGridBand.SetVisible(Value: Boolean);
var
  AColumnVisibles: TList;

  procedure AddColumnVisibles;
  var
    I: Integer;
  begin
    AColumnVisibles.Count := ColumnCount;
    for I := 0 to ColumnCount - 1 do
      AColumnVisibles[I] := Pointer(Columns[I].ActuallyVisible);
  end;

  procedure CheckColumnVisibles;
  var
    I: Integer;
  begin
    for I := 0 to ColumnCount - 1 do
      if Columns[I].ActuallyVisible <> Boolean(AColumnVisibles[I]) then
        GridView.ItemVisibilityChanged(Columns[I], Columns[I].ActuallyVisible);
  end;

begin
  if FVisible <> Value then
  begin
    AColumnVisibles := TList.Create;
    try
      AddColumnVisibles;
      FVisible := Value;
      GridView.RefreshVisibleItemsList;
      Bands.RefreshVisibleItemsList;
      CheckColumnVisibles;
      GridView.RefreshCustomizationForm;
    finally
      AColumnVisibles.Free;
    end;
  end;
end;

procedure TcxGridBand.SetWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FWidth <> Value then
  begin
    FWidth := Value;
    GridView.SizeChanged;
  end;
end;

procedure TcxGridBand.AddColumn(AColumn: TcxGridBandedColumn);
begin
  FColumns.Add(AColumn);
  AColumn.Position.FBand := Self;
  AColumn.Position.RowIndex := 0;
end;

procedure TcxGridBand.RemoveColumn(AColumn: TcxGridBandedColumn);
begin
  MoveColumn(AColumn, -1, -1);
  AColumn.Position.FBand := nil;
  FColumns.Remove(AColumn);
end;

function TcxGridBand.GetObjectName: string;
begin
  Result := 'Band' + IntToStr(Index);
end;

function TcxGridBand.GetProperties(AProperties: TStrings): Boolean;
begin
  with AProperties do
  begin
    Add('Caption');
    Add('Width');
    Add('Visible');
    Add('Hidden');
    Add('Index');
  end;
  Result := True;
end;

procedure TcxGridBand.GetPropertyValue(const AName: string; var AValue: Variant);
begin
  if AName = 'Width' then
    AValue := Width
  else
    if AName = 'Visible' then
      AValue := Visible
    else
      if AName = 'Hidden' then
        AValue := Hidden
      else
        if AName = 'Index' then
          AValue := Index
        else
          if AName = 'Caption' then
            AValue := Caption
          else
            AValue := Null;
end;

procedure TcxGridBand.SetPropertyValue(const AName: string; const AValue: Variant);
begin
  if AName = 'Width' then
    Width := AValue
  else
    if AName = 'Visible' then
      Visible := AValue
    else
      if AName = 'Hidden' then
        Hidden := AValue
      else
        if AName = 'Index' then
          Index := AValue
        else
          if AName = 'Caption' then
            Caption := AValue;
end;

function TcxGridBand.CanHide: Boolean;
begin
  Result := Bands.VisibleCount > 1;
end;

function TcxGridBand.CanMove: Boolean;
begin
  Result := GridView.OptionsCustomize.BandMoving and FOptions.Moving;
end;

function TcxGridBand.CanSize: Boolean;
begin
  Result := GridView.OptionsCustomize.BandSizing and FOptions.Sizing;
end;

procedure TcxGridBand.ColumnVisibilityChanged(AColumn: TcxGridBandedColumn);
begin
  FRows.ColumnVisibilityChanged(AColumn);
end;

procedure TcxGridBand.ForceWidth(Value: Integer);

  procedure AssignBandWidths;
  begin
    with GridView do
      if OptionsView.ColumnAutoWidth then
        ViewInfo.HeaderViewInfo.BandsViewInfo.AssignItemWidths;
  end;

begin
  AssignBandWidths;
  Width := Value;
  AssignBandWidths;
end;

procedure TcxGridBand.HiddenChanged;
begin
  GridView.RefreshCustomizationForm;
end;

function TcxGridBand.ColIndexOf(AColumn: TcxGridBandedColumn): Integer;
begin
  Result := AColumn.Position.RowIndex;
  if Result <> -1 then
    Result := FRows[Result].IndexOf(AColumn);
end;

function TcxGridBand.RowIndexOf(AColumn: TcxGridBandedColumn): Integer;
begin
  Result := FRows.IndexOf(AColumn);
end;

procedure TcxGridBand.SetIndex(Value: Integer);
var
  APrevIndex: Integer;
begin
  APrevIndex := Index;
  inherited;
  if Visible and (Index <> APrevIndex) then
    Bands.RefreshVisibleItemsList;
end;

function TcxGridBand.GetOptionsClass: TcxGridBandOptionsClass;
begin
  Result := TcxGridBandOptions;
end;

function TcxGridBand.GetStylesClass: TcxGridBandStylesClass;
begin
  Result := TcxGridBandStyles;
end;

procedure TcxGridBand.DoHeaderClick;
begin
  if Assigned(FOnHeaderClick) then FOnHeaderClick(Self);
end;

procedure TcxGridBand.Assign(Source: TPersistent);
begin
  if Source is TcxGridBand then
    with TcxGridBand(Source) do
    begin
      Self.HeaderAlignmentHorz := HeaderAlignmentHorz;
      Self.HeaderAlignmentVert := HeaderAlignmentVert;
      Self.Caption := Caption;
      Self.FixedKind := FixedKind;
      Self.Options := Options;
      Self.Styles := Styles;
      Self.Visible := Visible;
      Self.Width := Width;
      Self.OnHeaderClick := OnHeaderClick;
    end
  else
    inherited;
end;

procedure TcxGridBand.ApplyBestFit;
begin
  FWidth := 0;
  FRows.ApplyBestFit;
end;

procedure TcxGridBand.MoveColumn(AColumn: TcxGridBandedColumn; ARowIndex, AColIndex: Integer);
begin
  AColumn.Position.BandIndex := Index;
  FRows.MoveColumn(AColumn, ARowIndex, AColIndex);
end;

{ TcxGridBands }

constructor TcxGridBands.Create(AGridView: TcxGridBandedTableView);
begin
  inherited Create(AGridView, GetBandClass);
  FGridView := AGridView;
  FVisibleItems := TList.Create;
end;

destructor TcxGridBands.Destroy;
begin
  FreeAndNil(FVisibleItems);
  inherited;
end;

function TcxGridBands.GetFirstVisibleNonEmpty: TcxGridBand;
var
  I: Integer;
begin
  for I := 0 to VisibleCount - 1 do
  begin
    Result := VisibleItems[I];
    if Result.Rows.VisibleCount <> 0 then Exit;
  end;
  Result := nil;
end;

function TcxGridBands.GetItem(Index: Integer): TcxGridBand;
begin
  Result := TcxGridBand(inherited GetItem(Index));
end;

function TcxGridBands.GetLastVisibleNonEmpty: TcxGridBand;
var
  I: Integer;
begin
  for I := VisibleCount - 1 downto 0 do
  begin
    Result := VisibleItems[I];
    if Result.Rows.VisibleCount <> 0 then Exit;
  end;
  Result := nil;
end;

function TcxGridBands.GetLayout: TcxGridBandsLayout;
begin
  if (VisibleLeftFixedCount <> 0) and (VisibleRightFixedCount <> 0) then
    Result := blLeftRightFixed
  else
    if VisibleLeftFixedCount <> 0 then
      Result := blLeftFixed
    else
      if VisibleRightFixedCount <> 0 then
        Result := blRightFixed
      else
        Result := blNonFixed;
end;

function TcxGridBands.GetVisibleCount: Integer;
begin
  Result := FVisibleItems.Count;
end;

function TcxGridBands.GetVisibleItem(Index: Integer): TcxGridBand;
begin
  Result := FVisibleItems[Index];
end;

function TcxGridBands.GetVisibleRowCount: Integer;
var
  I, ACount: Integer;
begin
  Result := 0;
  for I := 0 to VisibleCount - 1 do
  begin
    ACount := VisibleItems[I].Rows.VisibleCount;
    if ACount > Result then Result := ACount;
  end;
end;

procedure TcxGridBands.SetItem(Index: Integer; Value: TcxGridBand);
begin
  inherited SetItem(Index, Value);
end;

procedure TcxGridBands.AddItem(AItem: TcxGridBand);
begin
  RefreshVisibleItemsList;
end;

procedure TcxGridBands.RemoveItem(AItem: TcxGridBand);
begin
  RefreshVisibleItemsList;
end;

procedure TcxGridBands.RefreshVisibleItemsList;
var
  I: Integer;
begin
  if FVisibleItems = nil then Exit;
  FVisibleItems.Clear;
  FVisibleLeftFixedCount := 0;
  FVisibleRightFixedCount := 0;
  for I := 0 to Count - 1 do
    if Items[I].Visible then
    begin
      FVisibleItems.Add(Items[I]);
      case Items[I].FixedKind of
        fkNone:
          FVisibleItems.Move(VisibleCount - 1, VisibleCount - 1 - FVisibleRightFixedCount);
        fkLeft:
          begin
            FVisibleItems.Move(VisibleCount - 1, FVisibleLeftFixedCount);
            Inc(FVisibleLeftFixedCount);
          end;
        fkRight:
          Inc(FVisibleRightFixedCount);
      end;
    end;
  GridView.SizeChanged;
end;

function TcxGridBands.GetObjectName: string;
begin
  Result := 'Bands';
end;

function TcxGridBands.GetProperties(AProperties: TStrings): Boolean;
begin
  Result := True;
end;

procedure TcxGridBands.GetPropertyValue(const AName: string; var AValue: Variant);
begin
end;

procedure TcxGridBands.SetPropertyValue(const AName: string; const AValue: Variant);
begin
end;

function TcxGridBands.CreateChild(const AObjectName, AClassName: string): TObject;
begin
  if AClassName = 'TcxGridBand' then
    Result := Add
  else
    Result := nil;
end;

procedure TcxGridBands.DeleteChild(const AObjectName: string; AObject: TObject);
begin
  AObject.Free;
end;

procedure TcxGridBands.GetChildren(AChildren: TStringList);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    AChildren.AddObject('', Items[I]);
end;

function TcxGridBands.GetBandClass: TcxGridBandClass;
begin
  Result := TcxGridBand;
end;

function TcxGridBands.Add: TcxGridBand;
begin
  Result := TcxGridBand(inherited Add);
end;

function TcxGridBands.GetFirstVisibleIndex(AFixedKind: TcxGridBandFixedKind): Integer;
begin
  case AFixedKind of
    fkLeft:
      Result := 0;
    fkNone:
      Result := VisibleLeftFixedCount;
    fkRight:
      Result := VisibleCount - VisibleRightFixedCount;
  else
    Result := -1;
  end;
end;

function TcxGridBands.GetLastVisibleIndex(AFixedKind: TcxGridBandFixedKind): Integer;
begin
  case AFixedKind of
    fkLeft:
      Result := GetFirstVisibleIndex(fkNone) - 1;
    fkNone:
      Result := GetFirstVisibleIndex(fkRight) - 1;
    fkRight:
      Result := VisibleCount - 1;
  else
    Result := -1;
  end;
end;

{ TcxGridBandedTableBackgroundBitmaps }

function TcxGridBandedTableBackgroundBitmaps.GetBitmapStyleIndex(Index: Integer): Integer;
begin
  case Index of
    bbBandBackground:
      Result := vsBandBackground;
    bbBandHeader:
      Result := vsBandHeader;
  else
    Result := inherited GetBitmapStyleIndex(Index);
  end;
end;

procedure TcxGridBandedTableBackgroundBitmaps.Assign(Source: TPersistent);
begin
  if Source is TcxGridBandedTableBackgroundBitmaps then
    with TcxGridBandedTableBackgroundBitmaps(Source) do
    begin
      Self.BandBackground := BandBackground;
      Self.BandHeader := BandHeader;
    end;
  inherited;
end;

{ TcxGridBandedTableOptionsCustomize }

constructor TcxGridBandedTableOptionsCustomize.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FBandMoving := True;
  FBandSizing := True;
  FColumnVertSizing := True;
end;

procedure TcxGridBandedTableOptionsCustomize.SetColumnVertSizing(Value: Boolean);
begin
  if FColumnVertSizing <> Value then
  begin
    FColumnVertSizing := Value;
    LayoutChanged;
  end;
end;

procedure TcxGridBandedTableOptionsCustomize.Assign(Source: TPersistent);
begin
  if Source is TcxGridBandedTableOptionsCustomize then
    with TcxGridBandedTableOptionsCustomize(Source) do
    begin
      Self.BandHiding := BandHiding;
      Self.BandMoving := BandMoving;
      Self.BandSizing := BandSizing;
      Self.ColumnVertSizing := ColumnVertSizing;
    end;
  inherited;
end;

{ TcxGridBandedTableOptionsView }

constructor TcxGridBandedTableOptionsView.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FBandHeaderLineCount := 1;
  FBandHeaders := True;
  FFixedBandSeparatorColor := clDefault;
  FFixedBandSeparatorWidth := cxGridDefaultFixedBandSeparatorWidth;
end;

procedure TcxGridBandedTableOptionsView.SetBandHeaderEndEllipsis(Value: Boolean);
begin
  if FBandHeaderEndEllipsis <> Value then
  begin
    FBandHeaderEndEllipsis := Value;
    LayoutChanged;
  end;
end;

procedure TcxGridBandedTableOptionsView.SetBandHeaderHeight(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FBandHeaderHeight <> Value then
  begin
    FBandHeaderHeight := Value;
    SizeChanged;
  end;
end;

procedure TcxGridBandedTableOptionsView.SetBandHeaderLineCount(Value: Integer);
begin
  if Value < 1 then Value := 1;
  if FBandHeaderLineCount <> Value then
  begin
    FBandHeaderLineCount := Value;
    SizeChanged;
  end;
end;

procedure TcxGridBandedTableOptionsView.SetBandHeaders(Value: Boolean);
begin
  if FBandHeaders <> Value then
  begin
    FBandHeaders := Value;
    LayoutChanged;
  end;
end;

procedure TcxGridBandedTableOptionsView.SetFixedBandSeparatorColor(Value: TColor);
begin
  if FFixedBandSeparatorColor <> Value then
  begin
    FFixedBandSeparatorColor := Value;
    LayoutChanged;
  end;
end;

procedure TcxGridBandedTableOptionsView.SetFixedBandSeparatorWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FFixedBandSeparatorWidth <> Value then
  begin
    FFixedBandSeparatorWidth := Value;
    SizeChanged;
  end;
end;

procedure TcxGridBandedTableOptionsView.Assign(Source: TPersistent);
begin
  if Source is TcxGridBandedTableOptionsView then
    with TcxGridBandedTableOptionsView(Source) do
    begin
      Self.BandHeaderEndEllipsis := BandHeaderEndEllipsis;
      Self.BandHeaderHeight := BandHeaderHeight;
      Self.BandHeaderLineCount := BandHeaderLineCount;
      Self.BandHeaders := BandHeaders;
      Self.FixedBandSeparatorColor := FixedBandSeparatorColor;
      Self.FixedBandSeparatorWidth := FixedBandSeparatorWidth;
    end;
  inherited;
end;

function TcxGridBandedTableOptionsView.GetFixedBandSeparatorColor: TColor;
begin
  Result := FFixedBandSeparatorColor;
  if Result = clDefault then
    Result := LookAndFeelPainter.DefaultFixedSeparatorColor;
end;

{ TcxGridBandedTableViewStyles }

function TcxGridBandedTableViewStyles.GetGridViewValue: TcxGridBandedTableView;
begin
  Result := TcxGridBandedTableView(inherited GridView);
end;

procedure TcxGridBandedTableViewStyles.GetDefaultViewParams(Index: Integer;
  AData: TObject; out AParams: TcxViewParams);
begin
  inherited;
  with AParams, LookAndFeelPainter do
    case Index of
      vsBandBackground:
        begin
          Color := DefaultHeaderBackgroundColor;
          TextColor := DefaultHeaderBackgroundTextColor;
        end;
      vsBandHeader:
        begin
          Color := DefaultHeaderColor;
          TextColor := DefaultHeaderTextColor;
        end;
    end;
end;

procedure TcxGridBandedTableViewStyles.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TcxGridBandedTableViewStyles then
    with TcxGridBandedTableViewStyles(Source) do
    begin
      Self.BandBackground := BandBackground;
      Self.BandHeader := BandHeader;
      Self.OnGetBandHeaderStyle := OnGetBandHeaderStyle;
    end;
end;

procedure TcxGridBandedTableViewStyles.GetBandHeaderParams(ABand: TcxGridBand;
  out AParams: TcxViewParams);
var
  AStyle: TcxStyle;
begin
  AStyle := nil;
  if Assigned(FOnGetBandHeaderStyle) then
    FOnGetBandHeaderStyle(GridView, ABand, AStyle);
  GetViewParams(vsBandHeader, ABand, AStyle, AParams);
end;

{ TcxGridBandedTableViewStyleSheet }

function TcxGridBandedTableViewStyleSheet.GetStylesValue: TcxGridBandedTableViewStyles;
begin
  Result := TcxGridBandedTableViewStyles(GetStyles);
end;

procedure TcxGridBandedTableViewStyleSheet.SetStylesValue(Value: TcxGridBandedTableViewStyles);
begin
  SetStyles(Value);
end;

class function TcxGridBandedTableViewStyleSheet.GetStylesClass: TcxCustomStylesClass;
begin
  Result := TcxGridBandedTableViewStyles;
end;

{ TcxGridBandedTableView }

constructor TcxGridBandedTableView.Create(AOwner: TComponent);
begin
  inherited;
  if (AOwner <> nil) and (csDesigning in AOwner.ComponentState) then
    Bands.Add;
end;

function TcxGridBandedTableView.GetBackgroundBitmaps: TcxGridBandedTableBackgroundBitmaps;
begin
  Result := TcxGridBandedTableBackgroundBitmaps(inherited BackgroundBitmaps);
end;

function TcxGridBandedTableView.GetColumn(Index: Integer): TcxGridBandedColumn;
begin
  Result := TcxGridBandedColumn(inherited Columns[Index]);
end;

function TcxGridBandedTableView.GetController: TcxGridBandedTableController;
begin
  Result := TcxGridBandedTableController(inherited Controller);
end;

function TcxGridBandedTableView.GetGroupedColumn(Index: Integer): TcxGridBandedColumn;
begin
  Result := TcxGridBandedColumn(inherited GroupedColumns[Index]);
end;

function TcxGridBandedTableView.GetOptionsCustomize: TcxGridBandedTableOptionsCustomize;
begin
  Result := TcxGridBandedTableOptionsCustomize(inherited OptionsCustomize);
end;

function TcxGridBandedTableView.GetOptionsView: TcxGridBandedTableOptionsView;
begin
  Result := TcxGridBandedTableOptionsView(inherited OptionsView);
end;

function TcxGridBandedTableView.GetStyles: TcxGridBandedTableViewStyles;
begin
  Result := TcxGridBandedTableViewStyles(inherited Styles);
end;

function TcxGridBandedTableView.GetViewInfo: TcxGridBandedTableViewInfo;
begin
  Result := TcxGridBandedTableViewInfo(inherited ViewInfo);
end;

function TcxGridBandedTableView.GetVisibleColumn(Index: Integer): TcxGridBandedColumn;
begin
  Result := TcxGridBandedColumn(inherited VisibleColumns[Index]);
end;

procedure TcxGridBandedTableView.SetBackgroundBitmaps(Value: TcxGridBandedTableBackgroundBitmaps);
begin
  inherited BackgroundBitmaps := Value;
end;

procedure TcxGridBandedTableView.SetBands(Value: TcxGridBands);
begin
  FBands.Assign(Value);
end;

procedure TcxGridBandedTableView.SetColumn(Index: Integer;
  Value: TcxGridBandedColumn);
begin
  inherited Columns[Index] := Value;
end;

procedure TcxGridBandedTableView.SetOptionsCustomize(Value: TcxGridBandedTableOptionsCustomize);
begin
  inherited OptionsCustomize := Value;
end;

procedure TcxGridBandedTableView.SetOptionsView(Value: TcxGridBandedTableOptionsView);
begin
  inherited OptionsView := Value;
end;

procedure TcxGridBandedTableView.SetStyles(Value: TcxGridBandedTableViewStyles);
begin
  inherited Styles := Value;
end;

procedure TcxGridBandedTableView.GetStoredChildren(AChildren: TStringList);
begin
  AChildren.AddObject('', Bands);
  inherited;
end;

procedure TcxGridBandedTableView.ReadState(Reader: TReader);
var
  I: Integer;
begin
  for I := 0 to ColumnCount - 1 do
    with Columns[I].Position do
      FBandIndex := BandIndex;
  inherited;
  BeginUpdate;
  try
    for I := 0 to ColumnCount - 1 do
      with Columns[I].Position do
        BandIndex := FBandIndex;
    RefreshVisibleItemsList;
  finally
    EndUpdate;
  end;
end;

procedure TcxGridBandedTableView.Updated;
var
  I: Integer;
begin
  inherited;
  BeginUpdate;
  try
    for I := 0 to ColumnCount - 1 do
      with Columns[I].Position do
        BandIndex := FBandIndex;
    AssignColumnParams;
  finally
    EndUpdate;
  end;
end;

procedure TcxGridBandedTableView.Updating;
var
  I: Integer;
begin
  for I := 0 to ColumnCount - 1 do
    Columns[I].Position.SaveParams;
  inherited;
end;

procedure TcxGridBandedTableView.DoAssign(ASource: TcxCustomGridView);
begin
  if ASource is TcxGridBandedTableView then
    with TcxGridBandedTableView(ASource) do
    begin
      Self.Bands := Bands;
      Self.OnBandPosChanged := OnBandPosChanged;
      Self.OnBandSizeChanged := OnBandSizeChanged;
      Self.OnCustomDrawBandHeader := OnCustomDrawBandHeader;
    end;
  inherited;
end;

procedure TcxGridBandedTableView.GetFakeComponentLinks(AList: TList);
var
  I: Integer;
begin
  inherited;
  for I := 0 to FBands.Count - 1 do
    FBands[I].Styles.GetFakeComponentLinks(AList);
end;

function TcxGridBandedTableView.HasCustomDrawBandHeader: Boolean;
begin
  Result := Assigned(FOnCustomDrawBandHeader);
end;

procedure TcxGridBandedTableView.CreateOptions;
begin
  inherited;
  FBands := GetBandsClass.Create(Self);
end;

procedure TcxGridBandedTableView.DestroyOptions;
begin
  FreeAndNil(FBands);
  inherited;
end;

function CompareLoadedColumnPositions(Item1, Item2: Pointer): Integer;
var
  APosition1, APosition2: TcxGridBandedColumnPosition;
begin
  APosition1 := TcxGridBandedColumnPosition(Item1);
  APosition2 := TcxGridBandedColumnPosition(Item2);
  Result := APosition1.BandIndex - APosition2.BandIndex;
  if Result = 0 then
  begin
    Result := APosition1.FRowIndex - APosition2.FRowIndex;
    if Result = 0 then
      Result := APosition1.FColIndex - APosition2.FColIndex;
  end;
end;

procedure TcxGridBandedTableView.AddItem(AItem: TcxCustomGridTableItem);
begin
  inherited;
  if not IsLoading and (FBands.VisibleCount <> 0) then
    TcxGridBandedColumn(AItem).Position.BandIndex := FBands.VisibleItems[0].Index;
end;

procedure TcxGridBandedTableView.AssignColumnParams;
var
  AColumnPositions: TList;
  I: Integer;

  procedure GetSortedColumnPositionList(AList: TList);
  var
    I: Integer;
  begin
    AList.Count := ColumnCount;
    for I := 0 to ColumnCount - 1 do
      AList[I] := Columns[I].Position;
    AList.Sort(CompareLoadedColumnPositions);
  end;

begin
  AColumnPositions := TList.Create;
  try
    GetSortedColumnPositionList(AColumnPositions);
    for I := 0 to AColumnPositions.Count - 1 do
      with TcxGridBandedColumnPosition(AColumnPositions[I]) do
      begin
        Item.IgnoreLoadingStatus := True;
        try
          RowIndex := FRowIndex;
          ColIndex := FColIndex;
        finally
          Item.IgnoreLoadingStatus := False;
        end;
      end;
  finally
    AColumnPositions.Free;
  end;
  RefreshVisibleItemsList;
end;

procedure TcxGridBandedTableView.ItemVisibilityChanged(AItem: TcxCustomGridTableItem;
  Value: Boolean);
begin
  with TcxGridBandedColumn(AItem).Position do
    if Band <> nil then
      Band.ColumnVisibilityChanged(Item);
  inherited;
end;

procedure TcxGridBandedTableView.LoadingComplete;
begin
  inherited;
  AssignColumnParams;
end;

function CompareColumns(Item1, Item2: Pointer): Integer;
var
  AColumn1, AColumn2: TcxGridBandedColumn;
  AFixedKind1, AFixedKind2: TcxGridBandFixedKind;
begin
  AColumn1 := TcxGridBandedColumn(Item1);
  AColumn2 := TcxGridBandedColumn(Item2);
  AFixedKind1 := AColumn1.Position.Band.FixedKind;
  AFixedKind2 := AColumn2.Position.Band.FixedKind;

  if AFixedKind1 = AFixedKind2 then
    Result := CompareVisibleColumnPositions(AColumn1.Position, AColumn2.Position)
  else
    if (AFixedKind1 = fkNone) and (AFixedKind2 = fkLeft) then
      Result := 1
    else
      if (AFixedKind2 = fkNone) and (AFixedKind1 = fkLeft) then
        Result := -1
      else
        Result := Ord(AFixedKind1) - Ord(AFixedKind2);
end;

procedure TcxGridBandedTableView.RefreshVisibleItemsList;
begin
  inherited;
  VisibleItemsList.Sort(CompareColumns);
  AssignVisibleItemsIndexes;
end;

procedure TcxGridBandedTableView.RestoringComplete;
begin
  inherited;
  AssignColumnParams;
end;

function TcxGridBandedTableView.GetBackgroundBitmapsClass: TcxCustomGridBackgroundBitmapsClass;
begin        {4}
  Result := TcxGridBandedTableBackgroundBitmaps;
end;

function TcxGridBandedTableView.GetBandsClass: TcxGridBandsClass;
begin
  Result := TcxGridBands;
end;

function TcxGridBandedTableView.GetControllerClass: TcxCustomGridControllerClass;
begin
  Result := TcxGridBandedTableController;
end;

function TcxGridBandedTableView.GetItemClass: TcxCustomGridTableItemClass;
begin
  Result := TcxGridBandedColumn;
end;

function TcxGridBandedTableView.GetOptionsCustomizeClass: TcxCustomGridTableOptionsCustomizeClass;
begin
  Result := TcxGridBandedTableOptionsCustomize;
end;

function TcxGridBandedTableView.GetOptionsViewClass: TcxCustomGridOptionsViewClass;
begin
  Result := TcxGridBandedTableOptionsView;
end;

function TcxGridBandedTableView.GetPainterClass: TcxCustomGridPainterClass;
begin
  Result := TcxGridBandedTablePainter;
end;

function TcxGridBandedTableView.GetStylesClass: TcxCustomGridViewStylesClass;
begin
  Result := TcxGridBandedTableViewStyles;
end;

function TcxGridBandedTableView.GetViewInfoClass: TcxCustomGridViewInfoClass;
begin
  Result := TcxGridBandedTableViewInfo;
end;

procedure TcxGridBandedTableView.DoBandPosChanged(ABand: TcxGridBand);
begin
  if Assigned(FOnBandPosChanged) then FOnBandPosChanged(Self, ABand);
end;

procedure TcxGridBandedTableView.DoBandSizeChanged(ABand: TcxGridBand);
begin
  if Assigned(FOnBandSizeChanged) then FOnBandSizeChanged(Self, ABand);
end;

procedure TcxGridBandedTableView.DoCustomDrawBandHeader(ACanvas: TcxCanvas;
  AViewInfo: TcxGridBandHeaderViewInfo; var ADone: Boolean);
begin
  if HasCustomDrawBandHeader then
    FOnCustomDrawBandHeader(Self, ACanvas, AViewInfo, ADone);
end;

function TcxGridBandedTableView.CreateColumn: TcxGridBandedColumn;
begin
  Result := TcxGridBandedColumn(inherited CreateColumn);
end;

initialization
  cxGridRegisteredViews.Register(TcxGridBandedTableView, 'Banded Table');
  Classes.RegisterClasses([TcxGridBandedColumn, TcxGridBandedTableViewStyleSheet]);

finalization
  cxGridRegisteredViews.Unregister(TcxGridBandedTableView);

end.
