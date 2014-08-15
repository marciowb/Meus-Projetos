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

unit cxGridRows;

{$I cxVer.inc}
{$I cxGridVer.inc}

interface

uses
  Windows, Classes, Graphics, Controls,
  dxCore, cxClasses, cxControls, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, cxCustomData, cxPC,
  cxGridCommon, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView,
  cxGridDetailsSite;

const
  htPreview = htGridBase + 31;

type
  TcxGridDataCellViewInfoClass = class of TcxGridDataCellViewInfo;
  TcxGridDataCellViewInfo = class;
  TcxGridDataRowCellsAreaViewInfo = class;
  TcxGridDataRowViewInfo = class;
  TcxGridNewItemRowViewInfo = class;
  TcxGridGroupCellViewInfo = class;
  TcxGridGroupSummaryCellViewInfo = class;
  TcxGridGroupRowViewInfo = class;
{$IFDEF USETABCONTROL}
  TcxGridMasterDataRowDetailsSiteLeftTabsViewInfo = class;
{$ENDIF}
  TcxGridDetailsSiteViewInfo = class;
  TcxGridExpandButtonCellViewInfo = class;
  TcxGridMasterDataRowViewInfo = class;

  { hit tests }

  TcxGridPreviewHitTest = class(TcxGridRecordCellHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  { painters }

  TcxGridDataCellPainter = class(TcxGridTableDataCellPainter)
  private
    function GetViewInfo: TcxGridDataCellViewInfo;
  protected
    procedure DrawBorder(ABorder: TcxBorder); override;
    function ExcludeFromClipRect: Boolean; override;
    property ViewInfo: TcxGridDataCellViewInfo read GetViewInfo;
  end;

  TcxGridDataRowPainter = class(TcxCustomGridRowPainter)
  private
    function GetViewInfo: TcxGridDataRowViewInfo;
  protected
    procedure DrawCells; virtual;
    function GetShowCells: Boolean; virtual;
    procedure Paint; override;
    property ShowCells: Boolean read GetShowCells;
    property ViewInfo: TcxGridDataRowViewInfo read GetViewInfo;
  end;

  TcxGridNewItemRowPainter = class(TcxGridDataRowPainter)
  private
    function GetViewInfo: TcxGridNewItemRowViewInfo;
  protected
    procedure DrawBackground; override;
    procedure DrawSeparator; override;
    function GetShowCells: Boolean; override;
    procedure Paint; override;
    property ViewInfo: TcxGridNewItemRowViewInfo read GetViewInfo;
  end;

{$IFDEF USETABCONTROL}

  TcxGridMasterDataRowDetailsSiteTabsPainter = class(TcxGridDetailsSiteTabsPainter)
  private
    function GetViewInfo: TcxGridMasterDataRowDetailsSiteLeftTabsViewInfo;
  protected
    procedure DrawBottomGridLine; virtual;
    procedure Paint; override;
    property ViewInfo: TcxGridMasterDataRowDetailsSiteLeftTabsViewInfo read GetViewInfo;
  end;

{$ENDIF}

  TcxGridExpandButtonCellPainter = class(TcxCustomGridCellPainter)
  private
    function GetViewInfo: TcxGridExpandButtonCellViewInfo;
  protected
    procedure DrawBorder(ABorder: TcxBorder); override;
    property ViewInfo: TcxGridExpandButtonCellViewInfo read GetViewInfo;
  end;

  TcxGridMasterDataRowPainter = class(TcxGridDataRowPainter)
  private
    function GetViewInfo: TcxGridMasterDataRowViewInfo;
  protected
    procedure DrawCells; override;
    procedure DrawDetailsSite; virtual;
    //procedure DrawDetailsArea; virtual;
    procedure DrawExpandButtonCell; virtual;
    function NeedsPainting: Boolean; override;
    procedure Paint; override;
    property ViewInfo: TcxGridMasterDataRowViewInfo read GetViewInfo;
  end;

  TcxGridGroupCellPainter = class(TcxCustomGridCellPainter)
  private
    function GetViewInfo: TcxGridGroupCellViewInfo;
  protected
    procedure DrawBorder(ABorder: TcxBorder); override;
    property ViewInfo: TcxGridGroupCellViewInfo read GetViewInfo;
  end;

  TcxGridGroupSummaryCellPainter = class(TcxCustomGridCellPainter)
  private
    function GetViewInfo: TcxGridGroupSummaryCellViewInfo;
  protected
    procedure Paint; override;
    property ViewInfo: TcxGridGroupSummaryCellViewInfo read GetViewInfo;
  end;

  TcxGridGroupRowPainter = class(TcxCustomGridRowPainter)
  private
    function GetViewInfo: TcxGridGroupRowViewInfo;
  protected
    procedure DrawBackground; override;
    procedure DrawSeparator; override;
    procedure DrawSummaryCells; virtual;
    procedure Paint; override;
    property ViewInfo: TcxGridGroupRowViewInfo read GetViewInfo;
  end;

  { view infos }

  TcxGridCellViewInfo = class(TcxGridTableCellViewInfo)
  private
    function GetGridView: TcxGridTableView;
    function GetGridLines: TcxGridLines;
    function GetGridRecord: TcxCustomGridRow;
    function GetGridViewInfo: TcxGridTableViewInfo;
    function GetRecordViewInfo: TcxCustomGridRowViewInfo;
  protected
    function GetBorderColor(AIndex: TcxBorder): TColor; override;
    function GetBorderWidth(AIndex: TcxBorder): Integer; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    property GridLines: TcxGridLines read GetGridLines;
  public
    property GridRecord: TcxCustomGridRow read GetGridRecord;
    property GridView: TcxGridTableView read GetGridView;
    property GridViewInfo: TcxGridTableViewInfo read GetGridViewInfo;
    property RecordViewInfo: TcxCustomGridRowViewInfo read GetRecordViewInfo;
  end;

  // data row

  TcxGridDataCellViewInfo = class(TcxGridTableDataCellViewInfo)
  private
    FIsMerged: Boolean;
    FIsMerging: Boolean;
    FMergedCells: TList;
    FMergingCell: TcxGridDataCellViewInfo;
    FOriginalHeight: Integer;
    function GetCacheItem: TcxGridTableViewInfoCacheItem;
    function GetGridView: TcxGridTableView;
    function GetGridViewInfo: TcxGridTableViewInfo;
    function GetItem: TcxGridColumn;
    function GetMergedCell(Index: Integer): TcxGridDataCellViewInfo;
    function GetMergedCellCount: Integer;
    function GetMergedCellOfFocusedRow: TcxGridDataCellViewInfo;
    function GetRecordViewInfo: TcxGridDataRowViewInfo;
  protected
    OriginalBounds: TRect;
    procedure AfterRowsViewInfoCalculate; virtual;
    procedure AfterRowsViewInfoOffset; virtual;
    function CalculateSelected: Boolean; override;
    function CalculateWidth: Integer; override;
    function CanBeMergingCell: Boolean; virtual;
    function CanCellMerging: Boolean; virtual;
    function GetBorderColor(AIndex: TcxBorder): TColor; override;
    function GetBorders: TcxBorders; override;
    function GetBorderWidth(AIndex: TcxBorder): Integer; override;
    function GetFocused: Boolean; override;
    function GetMultiLine: Boolean; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetVisible: Boolean; override;
    function GetVisibleForHitTest: Boolean; override;
    function HasHitTestPoint(const P: TPoint): Boolean; override;
    procedure Offset(DX, DY: Integer); override;
    procedure RemoveMergedCell(ACellViewInfo: TcxGridDataCellViewInfo);

    property CacheItem: TcxGridTableViewInfoCacheItem read GetCacheItem;
    property MergedCellOfFocusedRow: TcxGridDataCellViewInfo read GetMergedCellOfFocusedRow;
    property GridView: TcxGridTableView read GetGridView;
    property GridViewInfo: TcxGridTableViewInfo read GetGridViewInfo;
    property OriginalHeight: Integer read FOriginalHeight;
  public
    destructor Destroy; override;
    procedure BeforeRecalculation; override;
    procedure Calculate(ALeftBound, ATopBound: Integer; AWidth: Integer = -1;
      AHeight: Integer = -1); override;
    function MouseMove(AHitTest: TcxCustomGridHitTest; AShift: TShiftState): Boolean; override;
    procedure Paint(ACanvas: TcxCanvas = nil); override;

    property IsMerged: Boolean read FIsMerged;
    property IsMerging: Boolean read FIsMerging;
    property Item: TcxGridColumn read GetItem;
    property MergedCellCount: Integer read GetMergedCellCount;
    property MergedCells[Index: Integer]: TcxGridDataCellViewInfo read GetMergedCell;
    property MergingCell: TcxGridDataCellViewInfo read FMergingCell;
    property RecordViewInfo: TcxGridDataRowViewInfo read GetRecordViewInfo;
  end;

  TcxGridDataRowCellsAreaViewInfoClass = class of TcxGridDataRowCellsAreaViewInfo;

  TcxGridDataRowCellsAreaViewInfo = class(TcxGridCellViewInfo)
  private
    function GetRecordViewInfo: TcxGridDataRowViewInfo;
  protected
    function CalculateHeight: Integer; override;
    function CalculateVisible: Boolean; virtual;
    function CalculateWidth: Integer; override;
    function GetBorders: TcxBorders; override;
    function GetIsBottom: Boolean; virtual;
  public
    constructor Create(ARecordViewInfo: TcxCustomGridRecordViewInfo); override;
    function CanDrawSelected: Boolean; override;
    function DrawMergedCells: Boolean; virtual;
    property IsBottom: Boolean read GetIsBottom;
    property RecordViewInfo: TcxGridDataRowViewInfo read GetRecordViewInfo;
  end;

  TcxGridPreviewCellViewInfoClass = class of TcxGridPreviewCellViewInfo;

  TcxGridPreviewCellViewInfo = class(TcxGridDataCellViewInfo)
  private
    function GetPreview: TcxGridPreview;
  protected
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function GetAutoHeight: Boolean; override;
    function GetBackgroundBitmap: TBitmap; override;
    function GetBorders: TcxBorders; override;
    procedure GetEditViewDataContentOffsets(var R: TRect); override;
    function GetHeight: Integer; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetMaxLineCount: Integer; override;
    function GetMultiLine: Boolean; override;
    function GetTextAreaBounds: TRect; override;
    function SupportsZeroHeight: Boolean; override;
    property Preview: TcxGridPreview read GetPreview;
  end;

  TcxGridDataRowViewInfo = class(TcxCustomGridRowViewInfo)
  private
    FCellHeight: Integer;
    FCellsAreaBounds: TRect;
    FCellsAreaViewInfo: TcxGridDataRowCellsAreaViewInfo;
    FCellViewInfos: TList;
    FPreviewViewInfo: TcxGridPreviewCellViewInfo;
    function GetCellViewInfo(Index: Integer): TcxGridDataCellViewInfo;
    function GetCellViewInfoCount: Integer;
    function GetGridRecord: TcxGridDataRow;
    function GetHasPreview: Boolean;
    function GetInternalCellViewInfo(Index: Integer): TcxGridDataCellViewInfo;
    procedure CreateViewInfos;
    procedure DestroyViewInfos;
  protected
    procedure AfterRowsViewInfoCalculate; override;
    procedure AfterRowsViewInfoOffset; override;
    procedure ApplyMergedCellsBounds(var R: TRect; AItem: TcxCustomGridTableItem);
    procedure ApplyMergingCellsBounds(var R: TRect);
    procedure CalculateCellViewInfo(AIndex: Integer); virtual;
    function CalculateHeight: Integer; override;
    function CanSize: Boolean; override;
    procedure CheckRowHeight(var AValue: Integer); override;
    function GetAutoHeight: Boolean; override;
    function GetBackgroundBitmapBounds: TRect; override;
    function GetBaseHeight: Integer; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    procedure Offset(DX, DY: Integer); override;
    procedure SetRowHeight(Value: Integer); override;

    function GetCellHeight(AIndex: Integer): Integer; reintroduce; virtual;
    function GetCellHeightValue: Integer; virtual;
    function GetCellLeftBound(AIndex: Integer): Integer; virtual;
    function GetCellTopBound(AIndex: Integer): Integer; virtual;
    function GetCellsAreaBounds: TRect; virtual;
    function GetCellsAreaViewInfoClass: TcxGridDataRowCellsAreaViewInfoClass; virtual;
    function GetCellViewInfoClass(AIndex: Integer): TcxGridDataCellViewInfoClass; virtual;
    function GetCellWidth(AIndex: Integer): Integer; virtual;
    function GetPreviewViewInfoClass: TcxGridPreviewCellViewInfoClass; virtual;
    function GetShowPreview: Boolean; virtual;
    function IsCellVisible(AIndex: Integer): Boolean; virtual;

    property CellHeight: Integer read GetCellHeightValue;
    property ShowPreview: Boolean read GetShowPreview;
  public
    constructor Create(ARecordsViewInfo: TcxCustomGridRecordsViewInfo;
      ARecord: TcxCustomGridRecord); override;
    destructor Destroy; override;
    procedure BeforeCellRecalculation(ACell: TcxGridTableCellViewInfo); virtual;
    procedure BeforeRecalculation; override;
    procedure Calculate(ALeftBound, ATopBound: Integer; AWidth: Integer = -1;
      AHeight: Integer = -1); override;
    function GetAreaBoundsForPainting: TRect; override;
    function GetBoundsForInvalidate(AItem: TcxCustomGridTableItem): TRect; override;
    function GetBoundsForItem(AItem: TcxCustomGridTableItem): TRect; override;
    function GetCellBorders(AIsRight, AIsBottom: Boolean): TcxBorders; virtual;
    function GetCellViewInfoByItem(AItem: TcxCustomGridTableItem): TcxGridTableDataCellViewInfo; override;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; override;

    property CellsAreaBounds: TRect read GetCellsAreaBounds;
    property CellsAreaViewInfo: TcxGridDataRowCellsAreaViewInfo read FCellsAreaViewInfo;
    property CellViewInfoCount: Integer read GetCellViewInfoCount;
    property CellViewInfos[Index: Integer]: TcxGridDataCellViewInfo read GetCellViewInfo;
    property GridRecord: TcxGridDataRow read GetGridRecord;
    property HasPreview: Boolean read GetHasPreview;
    property InternalCellViewInfos[Index: Integer]: TcxGridDataCellViewInfo read GetInternalCellViewInfo;
    property PreviewViewInfo: TcxGridPreviewCellViewInfo read FPreviewViewInfo;
  end;

  // new item row

  TcxGridNewItemRowViewInfo = class(TcxGridDataRowViewInfo)
  private
    FHeight: Integer;
  protected
    function CalculateSelected: Boolean; override;
    function GetAlignmentHorz: TAlignment; override;
    function GetAlignmentVert: TcxAlignmentVert; override;
    function GetAutoHeight: Boolean; override;
    function GetCellLeftBound(AIndex: Integer): Integer; override;
    function GetCellWidth(AIndex: Integer): Integer; override;
    function GetHeight: Integer; override;
    function GetInfoText: string; virtual;
    function GetOptions: TcxGridSpecialRowOptions; virtual;
    function GetSeparatorColor: TColor; override;
    function GetSeparatorWidth: Integer; override;
    function GetShowInfoText: Boolean; virtual;
    function GetShowPreview: Boolean; override;
    function GetStyleIndex: Integer; virtual;
    function GetText: string; override;
    function GetTextAreaBounds: TRect; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function HasFooters: Boolean; override;
    function HasLastHorzGridLine: Boolean; override;

    function GetPainterClass: TcxCustomGridCellPainterClass; override;

    property InfoText: string read GetInfoText;
    property Options: TcxGridSpecialRowOptions read GetOptions;
    property ShowInfoText: Boolean read GetShowInfoText;
  end;

  // filtering row

  TcxGridFilterRowViewInfo = class(TcxGridNewItemRowViewInfo)
  private
    function GetGridRecord: TcxGridFilterRow;
  protected
    function GetOptions: TcxGridSpecialRowOptions; override;
    function GetShowInfoText: Boolean; override;
    function GetStyleIndex: Integer; override;
  public
    property GridRecord: TcxGridFilterRow read GetGridRecord;
  end;

  // details site

{$IFDEF USETABCONTROL}

  TcxGridMasterDataRowDetailsSiteLeftTabsViewInfo = class(TcxGridDetailsSiteLeftTabsViewInfo)
  private
    function GetBottomGridLineColor: TColor;
    function GetBottomGridLineWidth: Integer;
    function GetSiteViewInfo: TcxGridDetailsSiteViewInfo;
  protected
    function CalculateHeight: Integer; override;
    function GetBottomGridLineBounds: TRect; virtual;
    function GetPainterClass: TcxGridDetailsSiteTabsPainterClass; override;
    function GetTabControlBounds: TRect; override;
    property BottomGridLineWidth: Integer read GetBottomGridLineWidth;
  public
    function HasBottomGridLine: Boolean; virtual;
    property BottomGridLineBounds: TRect read GetBottomGridLineBounds;
    property BottomGridLineColor: TColor read GetBottomGridLineColor;
    property SiteViewInfo: TcxGridDetailsSiteViewInfo read GetSiteViewInfo;
  end;

{$ENDIF}

  TcxGridDetailsSiteViewInfoClass = class of TcxGridDetailsSiteViewInfo;

  TcxGridDetailsSiteViewInfo = class(TcxCustomGridDetailsSiteViewInfo)
  private
    FMasterDataRowViewInfo: TcxGridMasterDataRowViewInfo;
    function GetCacheItem: TcxGridMasterTableViewInfoCacheItem;
    function GetMasterGridView: TcxGridTableView;
    function GetMasterGridViewInfo: TcxGridTableViewInfo;
  protected
    procedure ControlFocusChanged; virtual;
    function GetActiveGridView: TcxCustomGridView; override;
    function GetActiveGridViewExists: Boolean; override;
    function GetActiveGridViewValue: TcxCustomGridView; override;
    function GetActiveLevel: TcxGridLevel; override;
    function GetCanvas: TcxCanvas; override;
    function GetContainer: TcxControl; override;
    function GetDesignController: TcxCustomGridDesignController; override;
    function GetFullyVisible: Boolean; override;
    function GetHeight: Integer; override;
    function GetMasterRecord: TObject; override;
    function GetMaxHeight: Integer; override;
    function GetMaxNormalHeight: Integer; override;
    function GetMaxWidth: Integer; override;
    function GetNormalHeight: Integer; override;
  {$IFDEF USETABCONTROL}
    function GetTabsViewInfoClass: TcxCustomGridDetailsSiteTabsViewInfoClass; override;
  {$ENDIF}
    function GetVisible: Boolean; override;
    function GetWidth: Integer; override;
    procedure InitTabHitTest(AHitTest: TcxGridDetailsSiteTabHitTest); override;

    property CacheItem: TcxGridMasterTableViewInfoCacheItem read GetCacheItem;
    property MasterGridView: TcxGridTableView read GetMasterGridView;
    property MasterGridViewInfo: TcxGridTableViewInfo read GetMasterGridViewInfo;
    property MasterDataRowViewInfo: TcxGridMasterDataRowViewInfo read FMasterDataRowViewInfo;
  public
    constructor Create(AMasterDataRowViewInfo: TcxGridMasterDataRowViewInfo); reintroduce; virtual;
    destructor Destroy; override;
    procedure ChangeActiveTab(ALevel: TcxGridLevel; AFocusView: Boolean = False); override;
    function DetailHasData(ALevel: TcxGridLevel): Boolean; override;
    function HasMaxHeight: Boolean;
    function SupportsTabAccelerators: Boolean; override;
  end;

  // master data row

  TcxGridExpandButtonCellViewInfoClass = class of TcxGridExpandButtonCellViewInfo;

  TcxGridExpandButtonCellViewInfo = class(TcxGridCellViewInfo)
  private
    function GetRecordViewInfo: TcxGridMasterDataRowViewInfo;
    function GetRightBorderRestSpaceBounds: TRect;
  protected
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function GetBackgroundBitmap: TBitmap; override;
    function GetBaseWidth: Integer; virtual;
    function GetBorderBounds(AIndex: TcxBorder): TRect; override;
    function GetBorders: TcxBorders; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;

    property BaseWidth: Integer read GetBaseWidth;
    property RightBorderRestSpaceBounds: TRect read GetRightBorderRestSpaceBounds;
  public
    property RecordViewInfo: TcxGridMasterDataRowViewInfo read GetRecordViewInfo;
  end;

  TcxGridDetailsAreaViewInfoClass = class of TcxGridDetailsAreaViewInfo;

  TcxGridDetailsAreaViewInfo = class(TcxGridCellViewInfo)
  private
    function GetRecordViewInfo: TcxGridMasterDataRowViewInfo;
  protected
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function GetBorders: TcxBorders; override;
  public
    property RecordViewInfo: TcxGridMasterDataRowViewInfo read GetRecordViewInfo;
  end;

  TcxGridMasterDataRowViewInfo = class(TcxGridDataRowViewInfo)
  private
    FDetailsAreaViewInfo: TcxGridDetailsAreaViewInfo;
    FDetailsSiteViewInfo: TcxGridDetailsSiteViewInfo;
    FExpandButtonCellViewInfo: TcxGridExpandButtonCellViewInfo;
    FRestHeight: Integer;
    function GetCacheItem: TcxGridMasterTableViewInfoCacheItem;
    function GetDetailsSiteIndentBounds: TRect;
    function GetGridRecord: TcxGridMasterDataRow;
  protected
    procedure CalculateExpandButtonBounds(var ABounds: TRect); override;
    function CalculateHeight: Integer; override;
    function CalculateRestHeight(ARowHeight: Integer): Integer; virtual;
    procedure ControlFocusChanged; override;
    function GetDataHeight: Integer; override;
    function GetDataIndent: Integer; override;
    function GetDataWidth: Integer; override;
    function GetDetailsSiteVisible: Boolean; virtual;
    function GetExpandButtonAreaBounds: TRect; override;
    function GetMaxHeight: Integer; override;
    function IsDetailVisible(ADetail: TcxCustomGridView): Boolean; override;
    function IsFullyVisible: Boolean; override;
    procedure VisibilityChanged(AVisible: Boolean); override;

    function GetPainterClass: TcxCustomGridCellPainterClass; override;

    function GetDetailsAreaViewInfoClass: TcxGridDetailsAreaViewInfoClass; virtual;
    function GetDetailsSiteViewInfoClass: TcxGridDetailsSiteViewInfoClass; virtual;
    function GetExpandButtonCellViewInfoClass: TcxGridExpandButtonCellViewInfoClass; virtual;

    property CacheItem: TcxGridMasterTableViewInfoCacheItem read GetCacheItem;
    property DetailsAreaViewInfo: TcxGridDetailsAreaViewInfo read FDetailsAreaViewInfo;
    property DetailsSiteIndentBounds: TRect read GetDetailsSiteIndentBounds;
    property ExpandButtonCellViewInfo: TcxGridExpandButtonCellViewInfo read FExpandButtonCellViewInfo;
    property RestHeight: Integer read FRestHeight write FRestHeight;
  public
    constructor Create(ARecordsViewInfo: TcxCustomGridRecordsViewInfo;
      ARecord: TcxCustomGridRecord); override;
    destructor Destroy; override;
    procedure BeforeRecalculation; override;
    procedure Calculate(ALeftBound, ATopBound: Integer; AWidth: Integer = -1;
      AHeight: Integer = -1); override;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; override;
    function ProcessDialogChar(ACharCode: Word): Boolean; override;
    function SupportsTabAccelerators: Boolean; virtual;
    property DetailsSiteViewInfo: TcxGridDetailsSiteViewInfo read FDetailsSiteViewInfo;
    property DetailsSiteVisible: Boolean read GetDetailsSiteVisible;
    property GridRecord: TcxGridMasterDataRow read GetGridRecord;
  end;

  // group row

  TcxGridGroupCellViewInfo = class(TcxGridCellViewInfo)
  private
    function GetExpandedAreaBounds: TRect;
    function GetGridRecord: TcxGridGroupRow;
    function GetRecordViewInfo: TcxGridGroupRowViewInfo;
    function GetRowStyle: TcxGridGroupRowStyle;
  protected
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function CustomDraw(ACanvas: TcxCanvas): Boolean; override;
    function GetAlignmentVert: TcxAlignmentVert; override;
    function GetAlwaysSelected: Boolean; override;
    function GetBackgroundBitmap: TBitmap; override;
    function GetBorderBounds(AIndex: TcxBorder): TRect; override;
    function GetBorderColor(AIndex: TcxBorder): TColor; override;
    function GetBorders: TcxBorders; override;
    function GetBorderWidth(AIndex: TcxBorder): Integer; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetText: string; override;
    function GetTextAreaBounds: TRect; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function HasCustomDraw: Boolean; override;

    property ExpandedAreaBounds: TRect read GetExpandedAreaBounds;
    property RowStyle: TcxGridGroupRowStyle read GetRowStyle;
  public
    function CanDrawSelected: Boolean; override;
    property GridRecord: TcxGridGroupRow read GetGridRecord;
    property RecordViewInfo: TcxGridGroupRowViewInfo read GetRecordViewInfo;
  end;

  TcxGridGroupRowSpacerViewInfoClass = class of TcxGridGroupRowSpacerViewInfo;

  TcxGridGroupRowSpacerViewInfo = class(TcxCustomGridViewCellViewInfo)
  private
    FRowViewInfo: TcxGridGroupRowViewInfo;
    function GetGridView: TcxGridTableView;
  protected
    function CalculateWidth: Integer; override;
    function GetAlignmentVert: TcxAlignmentVert; override;
    function GetText: string; override;
    function GetTextAreaBounds: TRect; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function GetWidth: Integer; override;
    function HasBackground: Boolean; override;
  public
    constructor Create(ARowViewInfo: TcxGridGroupRowViewInfo; const AText: string); reintroduce; virtual;
    property GridView: TcxGridTableView read GetGridView;
    property RowViewInfo: TcxGridGroupRowViewInfo read FRowViewInfo;
  end;

  TcxGridGroupSummaryCellViewInfoClass = class of TcxGridGroupSummaryCellViewInfo;

  TcxGridGroupSummaryCellViewInfo = class(TcxCustomGridViewCellViewInfo)
  private
    FIsLast: Boolean;
    FRowViewInfo: TcxGridGroupRowViewInfo;
    FSeparatorViewInfo: TcxGridGroupRowSpacerViewInfo;
    FSummaryItem: TcxDataSummaryItem;
    FTextWidth: Integer;
    FValue: Variant;
    function GetColumn: TcxGridColumn;
    function GetGridView: TcxGridTableView;
    procedure SetIsLast(Value: Boolean);
  protected
    function CalculateWidth: Integer; override;
    function CanAlignWithColumn: Boolean;
    function CustomDraw(ACanvas: TcxCanvas): Boolean; override;
    function GetAlignmentHorz: TAlignment; override;
    function GetAlignmentVert: TcxAlignmentVert; override;
    function GetDesignSelectionBounds: TRect; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetIsDesignSelected: Boolean; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetSeparatorBounds: TRect; virtual;
    function GetSeparatorText: string; virtual;
    function GetShowEndEllipsis: Boolean; override;
    function GetText: string; override;
    function GetTextAreaBounds: TRect; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function HasBackground: Boolean; override;
    function HasCustomDraw: Boolean; override;
    procedure InitHitTest(AHitTest: TcxCustomGridHitTest); override;
    procedure Offset(DX, DY: Integer); override;
  public
    constructor Create(ARowViewInfo: TcxGridGroupRowViewInfo;
      ASummaryItem: TcxDataSummaryItem; const AValue: Variant); reintroduce; virtual;
    destructor Destroy; override;
    procedure BeforeRecalculation; override;
    procedure Calculate(ALeftBound, ATopBound: Integer; AWidth: Integer = -1;
      AHeight: Integer = -1); override;
    function MouseDown(AHitTest: TcxCustomGridHitTest; AButton: TMouseButton;
      AShift: TShiftState): Boolean; override;
    property Column: TcxGridColumn read GetColumn;
    property GridView: TcxGridTableView read GetGridView;
    property IsLast: Boolean read FIsLast write SetIsLast;
    property RowViewInfo: TcxGridGroupRowViewInfo read FRowViewInfo;
    property SeparatorViewInfo: TcxGridGroupRowSpacerViewInfo read FSeparatorViewInfo;
    property SummaryItem: TcxDataSummaryItem read FSummaryItem;
    property Value: Variant read FValue;
  end;

  TcxGridGroupRowViewInfo = class(TcxCustomGridRowViewInfo)
  private
    FCellViewInfo: TcxGridGroupCellViewInfo;
    FSummaryBeginningSpacerViewInfo: TcxGridGroupRowSpacerViewInfo;
    FSummaryCellsWithoutColumns: TList;
    FSummaryCellViewInfos: TList;
    FSummaryEndingSpacerViewInfo: TcxGridGroupRowSpacerViewInfo;
    function GetGridRecord: TcxGridGroupRow;
    function GetRowStyle: TcxGridGroupRowStyle;
    function GetSummaryCellLayout: TcxGridGroupSummaryLayout;
    function GetSummaryCellViewInfo(Index: Integer): TcxGridGroupSummaryCellViewInfo;
    function GetSummaryCellViewInfoCount: Integer;
  protected
    procedure CalculateExpandButtonBounds(var ABounds: TRect); override;
    function CalculateHeight: Integer; override;
    function CanSize: Boolean; override;
    procedure CheckRowHeight(var AValue: Integer); override;
    function GetAutoHeight: Boolean; override;
    function GetBackgroundBitmap: TBitmap; override;
    function GetExpandButtonAreaBounds: TRect; override;
    function GetFocusRectBounds: TRect; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetSeparatorBounds: TRect; override;
    function GetSeparatorIndentBounds: TRect; virtual;
    function GetShowSeparator: Boolean; override;
    function HasFocusRect: Boolean; override;
    function HasFooter(ALevel: Integer): Boolean; override;
    procedure Offset(DX, DY: Integer); override;
    procedure SetRowHeight(Value: Integer); override;

    function CreateSpacerViewInfo(const AText: string): TcxGridGroupRowSpacerViewInfo;
    procedure CreateSpacerViewInfos; virtual;
    procedure DestroySpacerViewInfos; virtual;
    function GetSpacerViewInfoClass: TcxGridGroupRowSpacerViewInfoClass; virtual;

    function AddSummaryCellViewInfo(ASummaryItem: TcxDataSummaryItem;
      const AValue: Variant): TcxGridGroupSummaryCellViewInfo;
    procedure CreateSummaryCellViewInfos; virtual;
    procedure DestroySummaryCellViewInfos; virtual;
    function GetSummaryCellViewInfoClass: TcxGridGroupSummaryCellViewInfoClass; virtual;

    procedure CalculateSummaryCells; overload; virtual;
    procedure CalculateSummaryCells(ACellViewInfos: TList;
      const AAreaBounds: TRect; AAlignment: TAlignment; AAutoWidth: Boolean); overload; virtual;
    function CalculateSummaryCellWidths(ACellViewInfos: TList; AAvailableWidth: Integer;
      AAutoWidth: Boolean): TcxAutoWidthObject; virtual;
    function GetColumnSummaryCellsAreaBounds(AColumnHeaderViewInfo: TcxGridColumnHeaderViewInfo): TRect; virtual;
    procedure GetColumnSummaryCellViewInfos(AColumn: TcxGridColumn; AList: TList);
    function GetSummaryBeginningSpacerBounds: TRect; virtual;
    function GetSummaryEndingSpacerBounds: TRect; virtual;
    function GetSummaryBeginningSpacerText: string; virtual;
    function GetSummaryEndingSpacerText: string; virtual;
    function GetSummaryCellAutoWidth: Boolean; virtual;
    function GetSummaryCellsAreaBounds(AForAlignableCells: Boolean): TRect; virtual;
    function GetSummaryCellsBounds(const AAreaBounds: TRect;
      AWidths: TcxAutoWidthObject; AAlignment: TAlignment; AAutoWidth: Boolean): TRect; virtual;
    function GetUnalignableSummaryCells: TList; virtual;
    function HasUnalignableSummaryCells: Boolean; virtual;

    property SummaryBeginningSpacerViewInfo: TcxGridGroupRowSpacerViewInfo read FSummaryBeginningSpacerViewInfo;
    property SummaryEndingSpacerViewInfo: TcxGridGroupRowSpacerViewInfo read FSummaryEndingSpacerViewInfo;
    property SummaryCellAutoWidth: Boolean read GetSummaryCellAutoWidth;
    property SummaryCellLayout: TcxGridGroupSummaryLayout read GetSummaryCellLayout;
    property SummaryCells: TList read FSummaryCellViewInfos;
    property SummaryCellsWithoutColumns: TList read FSummaryCellsWithoutColumns;
    property UnalignableSummaryCells: TList read GetUnalignableSummaryCells;

    property RowStyle: TcxGridGroupRowStyle read GetRowStyle;
  public
    constructor Create(ARecordsViewInfo: TcxCustomGridRecordsViewInfo;
      ARecord: TcxCustomGridRecord); override;
    destructor Destroy; override;
    procedure BeforeRecalculation; override;
    procedure Calculate(ALeftBound, ATopBound: Integer; AWidth: Integer = -1;
      AHeight: Integer = -1); override;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; override;
    property CellViewInfo: TcxGridGroupCellViewInfo read FCellViewInfo;
    property GridRecord: TcxGridGroupRow read GetGridRecord;
    property SeparatorIndentBounds: TRect read GetSeparatorIndentBounds;
    property SummaryCellViewInfoCount: Integer read GetSummaryCellViewInfoCount;
    property SummaryCellViewInfos[Index: Integer]: TcxGridGroupSummaryCellViewInfo read GetSummaryCellViewInfo;
  end;

implementation

uses
  SysUtils, Math, Forms, cxVariants, cxGrid, cxEdit, dxOffice11;

{ TcxGridPreviewHitTest }

class function TcxGridPreviewHitTest.GetHitTestCode: Integer;
begin
  Result := htPreview;
end;

{ TcxGridDataCellPainter }

function TcxGridDataCellPainter.GetViewInfo: TcxGridDataCellViewInfo;
begin
  Result := TcxGridDataCellViewInfo(inherited ViewInfo);
end;

procedure TcxGridDataCellPainter.DrawBorder(ABorder: TcxBorder);
begin
  if ExcludeFromClipRect then
    inherited
  else
    TcxGridTablePainter(ViewInfo.GridViewInfo.Painter).AddGridLine(ViewInfo.BorderBounds[ABorder]);
end;

function TcxGridDataCellPainter.ExcludeFromClipRect: Boolean;
begin
  Result := ViewInfo.RecordViewInfo.CellsAreaViewInfo.Visible;
end;

{ TcxGridDataRowPainter }

function TcxGridDataRowPainter.GetViewInfo: TcxGridDataRowViewInfo;
begin
  Result := TcxGridDataRowViewInfo(inherited ViewInfo);
end;

procedure TcxGridDataRowPainter.DrawCells;
begin
  ViewInfo.RecordsViewInfo.PainterClass.DrawDataRowCells(ViewInfo);
  with ViewInfo do
    if HasPreview and (PreviewViewInfo.Height <> 0) then
      PreviewViewInfo.Paint;
end;

function TcxGridDataRowPainter.GetShowCells: Boolean;
begin
  Result := True;
end;

procedure TcxGridDataRowPainter.Paint;
var
  AClipRegion: TcxRegion;
begin
  if ShowCells then
  begin
    AClipRegion := Canvas.GetClipRegion;
    try
      DrawCells;
    finally
      Canvas.SetClipRegion(AClipRegion, roSet);
    end;
  end;
  inherited;
end;

{ TcxGridNewItemRowPainter }

function TcxGridNewItemRowPainter.GetViewInfo: TcxGridNewItemRowViewInfo;
begin
  Result := TcxGridNewItemRowViewInfo(inherited ViewInfo);
end;

procedure TcxGridNewItemRowPainter.DrawBackground;
begin
  if not ShowCells and not ViewInfo.Transparent then
    DrawBackground(ViewInfo.ContentBounds)
  else
    inherited;
end;

procedure TcxGridNewItemRowPainter.DrawSeparator;
begin
  ViewInfo.LookAndFeelPainter.DrawHeader(Canvas, ViewInfo.SeparatorBounds,
    ViewInfo.SeparatorBounds, [], cxBordersAll, cxbsNormal, taLeftJustify, vaTop,
    False, False, '', nil, ViewInfo.LookAndFeelPainter.DefaultHeaderTextColor,
    ViewInfo.SeparatorColor);
end;

function TcxGridNewItemRowPainter.GetShowCells: Boolean;
begin
  Result := ViewInfo.Text = '';
end;

procedure TcxGridNewItemRowPainter.Paint;
begin
  inherited;
  DrawText;
end;

{$IFDEF USETABCONTROL}

{ TcxGridMasterDataRowDetailsSiteTabsPainter }

function TcxGridMasterDataRowDetailsSiteTabsPainter.GetViewInfo: TcxGridMasterDataRowDetailsSiteLeftTabsViewInfo;
begin
  Result := TcxGridMasterDataRowDetailsSiteLeftTabsViewInfo(inherited ViewInfo);
end;

procedure TcxGridMasterDataRowDetailsSiteTabsPainter.DrawBottomGridLine;
begin
  Canvas.Brush.Color := ViewInfo.BottomGridLineColor;
  Canvas.FillRect(ViewInfo.BottomGridLineBounds);
end;

procedure TcxGridMasterDataRowDetailsSiteTabsPainter.Paint;
begin
  inherited;
  if ViewInfo.HasBottomGridLine then DrawBottomGridLine;
end;

{$ENDIF}

{ TcxGridExpandButtonCellPainter }

function TcxGridExpandButtonCellPainter.GetViewInfo: TcxGridExpandButtonCellViewInfo;
begin
  Result := TcxGridExpandButtonCellViewInfo(inherited ViewInfo);
end;

procedure TcxGridExpandButtonCellPainter.DrawBorder(ABorder: TcxBorder);
begin
  inherited;
  if (ABorder = bRight) and not ViewInfo.Transparent then
    DrawBackground(ViewInfo.RightBorderRestSpaceBounds);
end;

{ TcxGridMasterDataRowPainter }

function TcxGridMasterDataRowPainter.GetViewInfo: TcxGridMasterDataRowViewInfo;
begin
  Result := TcxGridMasterDataRowViewInfo(inherited ViewInfo);
end;

procedure TcxGridMasterDataRowPainter.DrawCells;
begin
  inherited;
  DrawExpandButtonCell;
end;

procedure TcxGridMasterDataRowPainter.DrawDetailsSite;
begin
  ViewInfo.DetailsSiteViewInfo.Paint(Canvas);
  ViewInfo.GridViewInfo.Painter.ExcludeFromBackground(ViewInfo.DetailsSiteViewInfo.Bounds);
end;

{procedure TcxGridMasterDataRowPainter.DrawDetailsArea;
begin
  ViewInfo.DetailsAreaViewInfo.Paint;
end;}

procedure TcxGridMasterDataRowPainter.DrawExpandButtonCell;
var
  AClipRegion: TcxRegion;
begin
  AClipRegion := Canvas.GetClipRegion;
  try
    Canvas.ExcludeClipRect(ViewInfo.CellsAreaBounds);
    ViewInfo.ExpandButtonCellViewInfo.Paint;
  finally
    Canvas.SetClipRegion(AClipRegion, roSet);
  end;
end;

function TcxGridMasterDataRowPainter.NeedsPainting: Boolean;
begin
  Result := inherited NeedsPainting or
    ViewInfo.DetailsSiteVisible and Canvas.RectVisible(ViewInfo.DetailsAreaViewInfo.GetAreaBoundsForPainting);
end;

procedure TcxGridMasterDataRowPainter.Paint;
begin
  if ViewInfo.DetailsSiteVisible then
  begin
    DrawDetailsSite;
    //DrawDetailsArea;
  end;
  inherited;
end;

{ TcxGridGroupCellPainter }

function TcxGridGroupCellPainter.GetViewInfo: TcxGridGroupCellViewInfo;
begin
  Result := TcxGridGroupCellViewInfo(inherited ViewInfo);
end;

procedure TcxGridGroupCellPainter.DrawBorder(ABorder: TcxBorder);
begin
  inherited;
  with Canvas, ViewInfo do
    if (ABorder = bBottom) and GridRecord.Expanded then
      if GridViewInfo.LevelIndentBackgroundBitmap = nil then
      begin
        Brush.Color := GridViewInfo.LevelIndentColors[GridRecord.Level];
        FillRect(ExpandedAreaBounds);
      end
      else
        FillRect(ExpandedAreaBounds, GridViewInfo.LevelIndentBackgroundBitmap);
end;

{ TcxGridGroupSummaryCellPainter }

function TcxGridGroupSummaryCellPainter.GetViewInfo: TcxGridGroupSummaryCellViewInfo;
begin
  Result := TcxGridGroupSummaryCellViewInfo(inherited ViewInfo);
end;

procedure TcxGridGroupSummaryCellPainter.Paint;
begin
  inherited;
  ViewInfo.SeparatorViewInfo.Paint(Canvas);
end;

{ TcxGridGroupRowPainter }

function TcxGridGroupRowPainter.GetViewInfo: TcxGridGroupRowViewInfo;
begin
  Result := TcxGridGroupRowViewInfo(inherited ViewInfo);
end;

procedure TcxGridGroupRowPainter.DrawBackground;
begin
end;

procedure TcxGridGroupRowPainter.DrawSeparator;
var
  R: TRect;
begin
  R := ViewInfo.SeparatorIndentBounds;
  if not IsRectEmpty(R) then
    DrawIndentPart(ViewInfo.Level, R);
  inherited;
end;

procedure TcxGridGroupRowPainter.DrawSummaryCells;
var
  I: Integer;
begin
  if ViewInfo.SummaryBeginningSpacerViewInfo <> nil then
    ViewInfo.SummaryBeginningSpacerViewInfo.Paint(Canvas);
  for I := 0 to ViewInfo.SummaryCellViewInfoCount - 1 do
    ViewInfo.SummaryCellViewInfos[I].Paint(Canvas);
  if ViewInfo.SummaryEndingSpacerViewInfo <> nil then
    ViewInfo.SummaryEndingSpacerViewInfo.Paint(Canvas);
end;

procedure TcxGridGroupRowPainter.Paint;
begin
  ViewInfo.CellViewInfo.Paint;
  DrawSummaryCells;
  inherited;
end;

{ TcxGridCellViewInfo }

function TcxGridCellViewInfo.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

function TcxGridCellViewInfo.GetGridLines: TcxGridLines;
begin
  Result := RecordViewInfo.GridLines;
end;

function TcxGridCellViewInfo.GetGridRecord: TcxCustomGridRow;
begin
  Result := TcxCustomGridRow(inherited GridRecord);
end;

function TcxGridCellViewInfo.GetGridViewInfo: TcxGridTableViewInfo;
begin
  Result := TcxGridTableViewInfo(inherited GridViewInfo);
end;

function TcxGridCellViewInfo.GetRecordViewInfo: TcxCustomGridRowViewInfo;
begin
  Result := TcxCustomGridRowViewInfo(inherited RecordViewInfo);
end;

function TcxGridCellViewInfo.GetBorderColor(AIndex: TcxBorder): TColor;
begin
  Result := GridViewInfo.GridLineColor;
end;

function TcxGridCellViewInfo.GetBorderWidth(AIndex: TcxBorder): Integer;
begin
  Result := GridViewInfo.GridLineWidth;
end;

procedure TcxGridCellViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  GridView.Styles.GetDataCellParams(GridRecord, nil, AParams, True, Self);
end;

{ TcxGridDataCellViewInfo }

destructor TcxGridDataCellViewInfo.Destroy;
var
  I: Integer;
begin
  if FIsMerging then
  begin
    for I := 0 to MergedCellCount - 1 do
      MergedCells[I].FMergingCell := nil;
    FMergedCells.Free;
  end  
  else
    if FIsMerged and (FMergingCell <> nil) then
      FMergingCell.RemoveMergedCell(Self);
  inherited;
end;

function TcxGridDataCellViewInfo.GetCacheItem: TcxGridTableViewInfoCacheItem;
begin
  Result := TcxGridTableViewInfoCacheItem(inherited CacheItem);
end;

function TcxGridDataCellViewInfo.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

function TcxGridDataCellViewInfo.GetGridViewInfo: TcxGridTableViewInfo;
begin
  Result := TcxGridTableViewInfo(inherited GridViewInfo);
end;

function TcxGridDataCellViewInfo.GetItem: TcxGridColumn;
begin
  Result := TcxGridColumn(inherited Item);
end;

function TcxGridDataCellViewInfo.GetMergedCell(Index: Integer): TcxGridDataCellViewInfo;
begin
  Result := TcxGridDataCellViewInfo(FMergedCells[Index]);
end;

function TcxGridDataCellViewInfo.GetMergedCellCount: Integer;
begin
  Result := FMergedCells.Count;
end;

function TcxGridDataCellViewInfo.GetMergedCellOfFocusedRow: TcxGridDataCellViewInfo;
var
  I: Integer;
begin
  for I := 0 to MergedCellCount - 1 do
  begin
    Result := MergedCells[I];
    if Result.RecordViewInfo.Focused then Exit;
  end;
  Result := nil;
end;

function TcxGridDataCellViewInfo.GetRecordViewInfo: TcxGridDataRowViewInfo;
begin
  Result := TcxGridDataRowViewInfo(inherited RecordViewInfo);
end;

procedure TcxGridDataCellViewInfo.AfterRowsViewInfoCalculate;
var
  AProperties: TcxCustomEditProperties;
  AValue: TcxEditValue;
  I: Integer;
  ARowViewInfo: TcxCustomGridRowViewInfo;
  ACellViewInfo: TcxGridDataCellViewInfo;

  procedure UpdateBounds;
  begin
    if FIsMerging then
    begin
      Bounds.Bottom := MergedCells[MergedCellCount - 1].Bounds.Bottom;
      Recalculate;
    end
    else
      if Height <> FOriginalHeight then
      begin
        Bounds.Bottom := Bounds.Top + FOriginalHeight;
        Recalculate;
      end;
  end;

begin
  if FIsMerged then
  begin
    UpdateBounds;
    Exit;
  end;
  if not CanCellMerging or GridViewInfo.IsInternalUse then Exit;
  AProperties := Properties;
  AValue := DisplayValue;
  for I := RecordViewInfo.Index + 1 to RecordViewInfo.RecordsViewInfo.Count - 1 do
  begin
    ARowViewInfo := RecordViewInfo.RecordsViewInfo[I];
    if ARowViewInfo is TcxGridDataRowViewInfo then
    begin
      ACellViewInfo := TcxGridDataRowViewInfo(ARowViewInfo).InternalCellViewInfos[Item.VisibleIndex];
      if Item.DoCompareValuesForCellMerging(
        RecordViewInfo.GridRecord, AProperties, AValue,
        TcxGridDataRowViewInfo(ARowViewInfo).GridRecord, ACellViewInfo.Properties, ACellViewInfo.DisplayValue) then
      begin
        if not FIsMerging then
        begin
          FIsMerging := True;
          FMergedCells := TList.Create;
        end;
        FMergedCells.Add(ACellViewInfo);
        ACellViewInfo.FIsMerged := True;
        ACellViewInfo.FMergingCell := Self;
        if not ACellViewInfo.CanBeMergingCell then Break;
      end
      else
        Break;
    end
    else
      Break;
  end;
  UpdateBounds;
end;

procedure TcxGridDataCellViewInfo.AfterRowsViewInfoOffset;
begin
  FIsMerging := False;
  FIsMerged := False;
  FreeAndNil(FMergedCells);
  FMergingCell := nil;
end;

function TcxGridDataCellViewInfo.CalculateSelected: Boolean;
var
  AMergedCellOfFocusedRow: TcxGridDataCellViewInfo;

  procedure CheckMergedCells;
  var
    I: Integer;
  begin
    if not Result and GridView.OptionsSelection.MultiSelect then
      for I := 0 to MergedCellCount - 1 do
      begin
        Result := MergedCells[I].Selected;
        if Result then Break;
      end;
  end;

begin
  Result := inherited CalculateSelected;
  if FIsMerging then
    if not GridView.OptionsSelection.MultiSelect or
      GridView.OptionsSelection.InvertSelect or Item.Focused then
      if not RecordViewInfo.Focused then
      begin
        AMergedCellOfFocusedRow := MergedCellOfFocusedRow;
        if AMergedCellOfFocusedRow <> nil then
          Result := AMergedCellOfFocusedRow.Selected
        else
          CheckMergedCells;
      end
      else
    else
      CheckMergedCells;
end;

function TcxGridDataCellViewInfo.CalculateWidth: Integer;
begin
  Result := RecordViewInfo.GetCellWidth(Item.VisibleIndex);
end;

function TcxGridDataCellViewInfo.CanBeMergingCell: Boolean;
begin
  Result := not RecordViewInfo.Expanded;
end;

function TcxGridDataCellViewInfo.CanCellMerging: Boolean;
begin
  Result := CanBeMergingCell and TcxGridColumnAccess.CanCellMerging(Item);
end;

function TcxGridDataCellViewInfo.GetBorderColor(AIndex: TcxBorder): TColor;
begin
  Result := GridViewInfo.GridLineColor;
end;

function TcxGridDataCellViewInfo.GetBorders: TcxBorders;
begin
  Result := RecordViewInfo.GetCellBorders(Item.IsMostRight,
    Item.IsMostBottom and RecordViewInfo.CellsAreaViewInfo.IsBottom);
end;

function TcxGridDataCellViewInfo.GetBorderWidth(AIndex: TcxBorder): Integer;
begin
  Result := GridViewInfo.GridLineWidth;
end;

function TcxGridDataCellViewInfo.GetFocused: Boolean;
var
  AMergedCellOfFocusedRow: TcxGridDataCellViewInfo;
begin
  Result := inherited GetFocused;
  if FIsMerging and not RecordViewInfo.Focused then
  begin
    AMergedCellOfFocusedRow := MergedCellOfFocusedRow;
    if AMergedCellOfFocusedRow <> nil then
      Result := AMergedCellOfFocusedRow.Focused;
  end;
end;

function TcxGridDataCellViewInfo.GetMultiLine: Boolean;
begin
  Result := inherited GetMultiLine or RecordViewInfo.AutoHeight;
end;

function TcxGridDataCellViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridDataCellPainter;
end;

function TcxGridDataCellViewInfo.GetVisible: Boolean;
begin
  Result := not FIsMerged and inherited GetVisible;
end;

function TcxGridDataCellViewInfo.GetVisibleForHitTest: Boolean;
begin
  Result := inherited GetVisible;
end;

function TcxGridDataCellViewInfo.HasHitTestPoint(const P: TPoint): Boolean;
begin
  if IsMerging then
    Result := PtInRect(OriginalBounds, P)
  else
    Result := inherited HasHitTestPoint(P);
end;

procedure TcxGridDataCellViewInfo.Offset(DX, DY: Integer);
begin
  inherited;
  OffsetRect(OriginalBounds, DX, DY);
end;

procedure TcxGridDataCellViewInfo.RemoveMergedCell(ACellViewInfo: TcxGridDataCellViewInfo);
begin
  FMergedCells.Remove(ACellViewInfo);
end;

procedure TcxGridDataCellViewInfo.BeforeRecalculation;
begin
  inherited;
  RecordViewInfo.BeforeCellRecalculation(Self);
end;

procedure TcxGridDataCellViewInfo.Calculate(ALeftBound, ATopBound: Integer;
  AWidth: Integer = -1; AHeight: Integer = -1);
begin
  inherited;
  if not FIsMerging then
  begin
    OriginalBounds := Bounds;
    FOriginalHeight := Height;
  end;
  if FIsMerged and (FMergingCell <> nil) then
    FMergingCell.Recalculate;
end;

function TcxGridDataCellViewInfo.MouseMove(AHitTest: TcxCustomGridHitTest;
  AShift: TShiftState): Boolean;
begin
  if IsMerged then
    Result := MergingCell.MouseMove(AHitTest, AShift)
  else
    Result := inherited MouseMove(AHitTest, AShift);
end;

procedure TcxGridDataCellViewInfo.Paint(ACanvas: TcxCanvas = nil);
begin
  inherited;
  if FIsMerged and RecordViewInfo.CellsAreaViewInfo.DrawMergedCells then
    FMergingCell.Paint(ACanvas);
end;

{ TcxGridDataRowCellsAreaViewInfo }

constructor TcxGridDataRowCellsAreaViewInfo.Create(ARecordViewInfo: TcxCustomGridRecordViewInfo);
begin
  inherited;
  Visible := CalculateVisible;
end;

function TcxGridDataRowCellsAreaViewInfo.GetRecordViewInfo: TcxGridDataRowViewInfo;
begin
  Result := TcxGridDataRowViewInfo(inherited RecordViewInfo);
end;

function TcxGridDataRowCellsAreaViewInfo.CalculateHeight: Integer;
begin
  Result := 0;
end;

function TcxGridDataRowCellsAreaViewInfo.CalculateVisible: Boolean;
begin
  Result := RecordViewInfo.GridViewInfo.HeaderViewInfo.Count = 0;
end;

function TcxGridDataRowCellsAreaViewInfo.CalculateWidth: Integer;
begin
  Result := 0;
end;

function TcxGridDataRowCellsAreaViewInfo.GetBorders: TcxBorders;
begin
  Result := GridViewInfo.GetCellBorders(True, IsBottom);
end;

function TcxGridDataRowCellsAreaViewInfo.GetIsBottom: Boolean;
begin
  Result :=
    not RecordViewInfo.HasPreview or (GridView.Preview.Place = ppTop) or
    (RecordViewInfo.PreviewViewInfo.Height = 0);
end;

function TcxGridDataRowCellsAreaViewInfo.CanDrawSelected: Boolean;
begin
  Result := True;
end;

function TcxGridDataRowCellsAreaViewInfo.DrawMergedCells: Boolean;
begin
  Result := RecordViewInfo.Transparent;
end;

{ TcxGridPreviewCellViewInfo }

function TcxGridPreviewCellViewInfo.GetPreview: TcxGridPreview;
begin
  Result := GridView.Preview;
end;

function TcxGridPreviewCellViewInfo.CalculateHeight: Integer;

  function GetMaxValue: Integer;
  begin
    if Preview.MaxLineCount = 0 then
      Result := 0
    else
    begin
      Result := Preview.MaxLineCount * GridViewInfo.GetFontHeight(Params.Font);
      GetCellTextAreaSize(Result);
    end;  
  end;

begin
  if CacheItem.IsPreviewHeightAssigned then
    Result := Height
  else
  begin
    if AutoHeight then
      Result := inherited CalculateHeight
    else
    begin
      CalculateParams;
      Result := GetMaxValue;
    end;
    if Result <> 0 then
      Result := RecordViewInfo.RecordsViewInfo.GetCellHeight(Result);
  end;
end;

function TcxGridPreviewCellViewInfo.CalculateWidth: Integer;
begin
  Result := RecordViewInfo.DataWidth;
end;

function TcxGridPreviewCellViewInfo.GetAutoHeight: Boolean;
begin
  Result := Preview.AutoHeight;
end;

function TcxGridPreviewCellViewInfo.GetBackgroundBitmap: TBitmap;
begin
  Result := GridView.BackgroundBitmaps.GetBitmap(bbPreview);
end;

function TcxGridPreviewCellViewInfo.GetBorders: TcxBorders;
begin
  Result := GridViewInfo.GetCellBorders(True,
    (Preview.Place = ppBottom) or (RecordViewInfo.CellViewInfoCount = 0));
end;

procedure TcxGridPreviewCellViewInfo.GetEditViewDataContentOffsets(var R: TRect);
begin
  inherited;
  R.Left := Preview.LeftIndent - (cxGridCellTextOffset - cxGridEditOffset);
  R.Right := Preview.RightIndent - (cxGridCellTextOffset - cxGridEditOffset);
end;

function TcxGridPreviewCellViewInfo.GetHeight: Integer;
begin
  if CacheItem.IsPreviewHeightAssigned then
    Result := CacheItem.PreviewHeight
  else
  begin
    Result := CalculateHeight;
    CacheItem.PreviewHeight := Result;
  end;
end;

function TcxGridPreviewCellViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridPreviewHitTest;
end;

function TcxGridPreviewCellViewInfo.GetMaxLineCount: Integer;
begin
  Result := Preview.MaxLineCount;
end;

function TcxGridPreviewCellViewInfo.GetMultiLine: Boolean;
begin
  Result := True;
end;

function TcxGridPreviewCellViewInfo.GetTextAreaBounds: TRect;
begin
  Result := inherited GetTextAreaBounds;
  InflateRect(Result, cxGridCellTextOffset, 0);
  Inc(Result.Left, Preview.LeftIndent);
  Dec(Result.Right, Preview.RightIndent);
end;

function TcxGridPreviewCellViewInfo.SupportsZeroHeight: Boolean;
begin
  Result := True;
end;

{ TcxGridDataRowViewInfo }

constructor TcxGridDataRowViewInfo.Create(ARecordsViewInfo: TcxCustomGridRecordsViewInfo;
  ARecord: TcxCustomGridRecord);
begin
  inherited;
  CreateViewInfos;
end;

destructor TcxGridDataRowViewInfo.Destroy;
begin
  DestroyViewInfos;
  inherited;
end;

function TcxGridDataRowViewInfo.GetCellViewInfo(Index: Integer): TcxGridDataCellViewInfo;
begin
  Result := InternalCellViewInfos[Index];
  if Result = nil then
  begin
    Result := GetCellViewInfoClass(Index).Create(Self, GridView.VisibleColumns[Index]);
    FCellViewInfos[Index] := Result;
  end;
end;

function TcxGridDataRowViewInfo.GetCellViewInfoCount: Integer;
begin
  Result := FCellViewInfos.Count;
end;

function TcxGridDataRowViewInfo.GetGridRecord: TcxGridDataRow;
begin
  Result := TcxGridDataRow(inherited GridRecord);
end;

function TcxGridDataRowViewInfo.GetHasPreview: Boolean;
begin
  Result := FPreviewViewInfo <> nil;
end;

function TcxGridDataRowViewInfo.GetInternalCellViewInfo(Index: Integer): TcxGridDataCellViewInfo;
begin
  Result := TcxGridDataCellViewInfo(FCellViewInfos[Index]);
end;

procedure TcxGridDataRowViewInfo.CreateViewInfos;
begin
  FCellViewInfos := TList.Create;
  FCellViewInfos.Count := GridViewInfo.HeaderViewInfo.Count;
  FCellsAreaViewInfo := GetCellsAreaViewInfoClass.Create(Self);
  if ShowPreview then
    FPreviewViewInfo := GetPreviewViewInfoClass.Create(Self, GridView.Preview.Column);
end;

procedure TcxGridDataRowViewInfo.DestroyViewInfos;
var
  I: Integer;
begin
  FPreviewViewInfo.Free;
  FCellsAreaViewInfo.Free;
  for I := 0 to CellViewInfoCount - 1 do
    InternalCellViewInfos[I].Free;
  FCellViewInfos.Free;
end;

procedure TcxGridDataRowViewInfo.AfterRowsViewInfoCalculate;
var
  I: Integer;
  ACellViewInfo: TcxGridDataCellViewInfo;
begin
  inherited;
  for I := 0 to CellViewInfoCount - 1 do
  begin
    ACellViewInfo := InternalCellViewInfos[I];
    if (ACellViewInfo <> nil) and ACellViewInfo.Calculated then
      ACellViewInfo.AfterRowsViewInfoCalculate;
  end;
end;

procedure TcxGridDataRowViewInfo.AfterRowsViewInfoOffset;
var
  I: Integer;
  ACellViewInfo: TcxGridDataCellViewInfo;
begin
  inherited;
  for I := 0 to CellViewInfoCount - 1 do
  begin
    ACellViewInfo := InternalCellViewInfos[I];
    if ACellViewInfo <> nil then
      ACellViewInfo.AfterRowsViewInfoOffset;
  end;
end;

procedure TcxGridDataRowViewInfo.ApplyMergedCellsBounds(var R: TRect;
  AItem: TcxCustomGridTableItem);
var
  I: Integer;

  procedure ProcessCell(ACellViewInfo: TcxGridDataCellViewInfo);
  begin
    if (ACellViewInfo <> nil) and ACellViewInfo.IsMerged then
      with ACellViewInfo.MergingCell do
      begin
        if Bounds.Top < R.Top then
          R.Top := Bounds.Top;
        if Bounds.Bottom > R.Bottom then
          R.Bottom := Bounds.Bottom;
      end;
  end;

begin
  if AItem = nil then
    for I := 0 to CellViewInfoCount - 1 do
      ProcessCell(InternalCellViewInfos[I])
  else
    ProcessCell(InternalCellViewInfos[AItem.VisibleIndex]);
end;

procedure TcxGridDataRowViewInfo.ApplyMergingCellsBounds(var R: TRect);
var
  I: Integer;
  ACellViewInfo: TcxGridDataCellViewInfo;
begin
  for I := 0 to CellViewInfoCount - 1 do
  begin
    ACellViewInfo := InternalCellViewInfos[I];
    if (ACellViewInfo <> nil) and
      ACellViewInfo.IsMerging and (ACellViewInfo.Bounds.Bottom > R.Bottom) then
      R.Bottom := ACellViewInfo.Bounds.Bottom;
  end;
end;

procedure TcxGridDataRowViewInfo.CalculateCellViewInfo(AIndex: Integer);
begin
  CellViewInfos[AIndex].Calculate(GetCellLeftBound(AIndex), GetCellTopBound(AIndex),
    -1, GetCellHeight(AIndex));
end;

function TcxGridDataRowViewInfo.CalculateHeight: Integer;
var
  I, AHeight: Integer;
begin
  if AutoHeight then
  begin
    Result := 0;
    for I := 0 to CellViewInfoCount - 1 do
    begin
      AHeight := CellViewInfos[I].CalculateHeight;
      if AHeight > Result then Result := AHeight;
    end;
    Result := RecordsViewInfo.GetCellHeight(Result);
    if not TcxCustomGridTableViewAccess.IsGetCellHeightAssigned(GridView) then
      with RecordsViewInfo do
        if Result < DataRowHeight then Result := DataRowHeight;
  end
  else
    Result := RecordsViewInfo.DataRowHeight;
  if HasPreview then
    Inc(Result, PreviewViewInfo.Height);
  Inc(Result, inherited CalculateHeight);
end;

function TcxGridDataRowViewInfo.CanSize: Boolean;
begin
  Result := RecordsViewInfo.CanDataRowSize;
end;

procedure TcxGridDataRowViewInfo.CheckRowHeight(var AValue: Integer);
begin
  Dec(AValue, NonBaseHeight);
  inherited;
  GridView.OptionsView.CheckDataRowHeight(AValue);
  Inc(AValue, NonBaseHeight);
end;

function TcxGridDataRowViewInfo.GetAutoHeight: Boolean;
begin
  Result := RecordsViewInfo.AutoDataRecordHeight;
end;

function TcxGridDataRowViewInfo.GetBackgroundBitmapBounds: TRect;
begin
  Result := inherited GetBackgroundBitmapBounds;
  if HasPreview and (FPreviewViewInfo.BackgroundBitmap <> nil) then
    with CellsAreaBounds do
    begin
      Result.Top := Top;
      Result.Bottom := Bottom;
    end;
end;

function TcxGridDataRowViewInfo.GetBaseHeight: Integer;
begin
  Result := inherited GetBaseHeight;
  if HasPreview then
    Dec(Result, PreviewViewInfo.Height);
end;

function TcxGridDataRowViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridDataRowPainter;
end;

procedure TcxGridDataRowViewInfo.Offset(DX, DY: Integer);

  procedure OffsetCells;
  var
    I: Integer;
    ACellViewInfo: TcxGridDataCellViewInfo;
  begin
    for I := 0 to CellViewInfoCount - 1 do
    begin
      ACellViewInfo := InternalCellViewInfos[I];
      if IsCellVisible(I) then
        if (ACellViewInfo = nil) or not ACellViewInfo.Calculated then
          CalculateCellViewInfo(I)
        else
          ACellViewInfo.DoOffset(DX, DY)
      else
        if (DX <> 0) and (ACellViewInfo <> nil) then
        begin
          ACellViewInfo.Free;
          FCellViewInfos[I] := nil;
        end;
    end;
  end;

begin
  inherited;
  OffsetRect(FCellsAreaBounds, DX, DY);
  OffsetCells;
  FCellsAreaViewInfo.DoOffset(DX, DY);
  if FPreviewViewInfo <> nil then
    FPreviewViewInfo.DoOffset(DX, DY);
end;

procedure TcxGridDataRowViewInfo.SetRowHeight(Value: Integer);
begin
  if RowHeight <> Value then
    GridView.OptionsView.DataRowHeight := Value - NonBaseHeight;
end;

function TcxGridDataRowViewInfo.GetCellHeight(AIndex: Integer): Integer;
begin
  if CellViewInfos[AIndex].IsMerging then
    Result := InternalCellViewInfos[AIndex].Height
  else
    Result := GridViewInfo.GetCellHeight(AIndex, FCellHeight);
end;

function TcxGridDataRowViewInfo.GetCellHeightValue: Integer;
begin
  if AutoHeight then
  begin
    Result := DataHeight;
    if HasPreview then Dec(Result, PreviewViewInfo.Height);
  end
  else
    Result := RecordsViewInfo.RowHeight;
end;

function TcxGridDataRowViewInfo.GetCellLeftBound(AIndex: Integer): Integer;
begin
  Result := GridViewInfo.HeaderViewInfo[AIndex].DataOffset;
end;

function TcxGridDataRowViewInfo.GetCellTopBound(AIndex: Integer): Integer;
begin
  Result := FCellsAreaBounds.Top + GridViewInfo.GetCellTopOffset(AIndex, FCellHeight);
end;

function TcxGridDataRowViewInfo.GetCellsAreaBounds: TRect;
begin
  with Result do
  begin
    Left := DataIndent;
    Right := Left + DataWidth;
    Top := Bounds.Top;
    Bottom := Top + DataHeight;
    if HasPreview then
      if PreviewViewInfo.Preview.Place = ppTop then
        Inc(Top, PreviewViewInfo.Height)
      else
        Dec(Bottom, PreviewViewInfo.Height);
  end;
end;

function TcxGridDataRowViewInfo.GetCellsAreaViewInfoClass: TcxGridDataRowCellsAreaViewInfoClass;
begin
  Result := TcxGridDataRowCellsAreaViewInfoClass(RecordsViewInfo.GetDataRowCellsAreaViewInfoClass);
end;

function TcxGridDataRowViewInfo.GetCellViewInfoClass(AIndex: Integer): TcxGridDataCellViewInfoClass;
begin
  Result := TcxGridDataCellViewInfo;
end;

function TcxGridDataRowViewInfo.GetCellWidth(AIndex: Integer): Integer;
begin
  Result := GridViewInfo.HeaderViewInfo[AIndex].RealWidth;
end;

function TcxGridDataRowViewInfo.GetPreviewViewInfoClass: TcxGridPreviewCellViewInfoClass;
begin
  Result := TcxGridPreviewCellViewInfo;
end;

function TcxGridDataRowViewInfo.GetShowPreview: Boolean;
begin
  Result := GridView.Preview.Active;
end;

function TcxGridDataRowViewInfo.IsCellVisible(AIndex: Integer): Boolean;
begin
  Result := GridViewInfo.HeaderViewInfo[AIndex].Visible;
end;

procedure TcxGridDataRowViewInfo.BeforeCellRecalculation(ACell: TcxGridTableCellViewInfo);
begin
end;

procedure TcxGridDataRowViewInfo.BeforeRecalculation;
var
  I: Integer;
begin
  inherited;
  FCellsAreaViewInfo.BeforeRecalculation;
  for I := 0 to CellViewInfoCount - 1 do
    if InternalCellViewInfos[I] <> nil then
      InternalCellViewInfos[I].BeforeRecalculation;
  if FPreviewViewInfo <> nil then
    FPreviewViewInfo.BeforeRecalculation;
end;

procedure TcxGridDataRowViewInfo.Calculate(ALeftBound, ATopBound: Integer;
  AWidth: Integer = -1; AHeight: Integer = -1);
var
  I: Integer;

  procedure CalculatePreview;

    function GetTopBound: Integer;
    begin
      if PreviewViewInfo.Preview.Place = ppTop then
        Result := ATopBound
      else
        Result := FCellsAreaBounds.Bottom;
    end;

  begin
    PreviewViewInfo.Calculate(FCellsAreaBounds.Left, GetTopBound);
  end;

begin
  inherited;
  FCellsAreaBounds := CellsAreaBounds;
  if HasPreview then CalculatePreview;
  FCellHeight := CellHeight;
  for I := 0 to CellViewInfoCount - 1 do
    if IsCellVisible(I) then CalculateCellViewInfo(I);
  if FCellsAreaViewInfo.Visible then
    FCellsAreaViewInfo.Calculate(FCellsAreaBounds);
end;

function TcxGridDataRowViewInfo.GetAreaBoundsForPainting: TRect;
begin
  Result := inherited GetAreaBoundsForPainting;
  ApplyMergingCellsBounds(Result);
end;

function TcxGridDataRowViewInfo.GetBoundsForInvalidate(AItem: TcxCustomGridTableItem): TRect;
begin
  Result := inherited GetBoundsForInvalidate(AItem);
  if AItem = nil then
    ApplyMergingCellsBounds(Result);
  ApplyMergedCellsBounds(Result, AItem);
end;

function TcxGridDataRowViewInfo.GetBoundsForItem(AItem: TcxCustomGridTableItem): TRect;
begin
  if InternalCellViewInfos[AItem.VisibleIndex] = nil then
    Result := inherited GetBoundsForItem(AItem)
  else
    Result := InternalCellViewInfos[AItem.VisibleIndex].Bounds;
end;

function TcxGridDataRowViewInfo.GetCellBorders(AIsRight, AIsBottom: Boolean): TcxBorders;
begin
  Result := GridViewInfo.GetCellBorders(AIsRight, AIsBottom);
end;

function TcxGridDataRowViewInfo.GetCellViewInfoByItem(AItem: TcxCustomGridTableItem): TcxGridTableDataCellViewInfo;
begin
  if TcxGridColumn(AItem).IsPreview then
    Result := FPreviewViewInfo
  else
    if (AItem.VisibleIndex = -1) or
       (TcxCustomGrid(GridView.Control).UpdateLocked and not GridViewInfo.IsCalculating) then
      Result := nil
    else
      Result := InternalCellViewInfos[AItem.VisibleIndex];
end;

function TcxGridDataRowViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
var
  I: Integer;
  ACellViewInfo: TcxGridDataCellViewInfo;
  AHitTest: TcxCustomGridHitTest;
begin
  Result := inherited GetHitTest(P);
  if (Result <> nil) and (Result.ClassType = GetHitTestClass) then
  begin
    for I := 0 to CellViewInfoCount - 1 do
    begin
      ACellViewInfo := InternalCellViewInfos[I];
      if ACellViewInfo <> nil then
      begin
        AHitTest := ACellViewInfo.GetHitTest(P);
        if AHitTest <> nil then
        begin
          Result := AHitTest;
          Exit;
        end;
      end;
    end;
    if HasPreview then
    begin
      AHitTest := FPreviewViewInfo.GetHitTest(P);
      if AHitTest <> nil then
      begin
        Result := AHitTest;
        Exit;
      end;
    end;
  end;
end;

{ TcxGridNewItemRowViewInfo }

function TcxGridNewItemRowViewInfo.CalculateSelected: Boolean;
begin
  Result := GridRecord.Selected;
end;

function TcxGridNewItemRowViewInfo.GetAlignmentHorz: TAlignment;
begin
  Result := taCenter;
end;

function TcxGridNewItemRowViewInfo.GetAlignmentVert: TcxAlignmentVert;
begin
  Result := vaCenter;
end;

function TcxGridNewItemRowViewInfo.GetAutoHeight: Boolean;
begin
  Result := False;
end;

function TcxGridNewItemRowViewInfo.GetCellLeftBound(AIndex: Integer): Integer;
begin
  Result := GridViewInfo.HeaderViewInfo[AIndex].RealBounds.Left;
end;

function TcxGridNewItemRowViewInfo.GetCellWidth(AIndex: Integer): Integer;
begin
  Result := GridViewInfo.HeaderViewInfo[AIndex].Width;
end;

function TcxGridNewItemRowViewInfo.GetHeight: Integer;
begin
  if FHeight = 0 then
    FHeight := CalculateHeight;
  Result := FHeight;
end;

function TcxGridNewItemRowViewInfo.GetInfoText: string;
begin
  Result := Options.InfoText;
end;

function TcxGridNewItemRowViewInfo.GetOptions: TcxGridSpecialRowOptions;
begin
  Result := GridView.NewItemRow;
end;

function TcxGridNewItemRowViewInfo.GetSeparatorColor: TColor;
begin
  Result := Options.GetSeparatorColor;
end;

function TcxGridNewItemRowViewInfo.GetSeparatorWidth: Integer;
begin
  Result := Options.SeparatorWidth;
end;

function TcxGridNewItemRowViewInfo.GetShowInfoText: Boolean;
begin
  Result := not Focused;
end;

function TcxGridNewItemRowViewInfo.GetShowPreview: Boolean;
begin
  Result := False;
end;

function TcxGridNewItemRowViewInfo.GetStyleIndex: Integer;
begin
  Result := vsNewItemRowInfoText;
end;

function TcxGridNewItemRowViewInfo.GetText: string;
begin
  if ShowInfoText then
    Result := InfoText
  else
    Result := inherited GetText;
end;

function TcxGridNewItemRowViewInfo.GetTextAreaBounds: TRect;
begin
  Result := ContentBounds;
  with GridViewInfo.ScrollableAreaBoundsHorz do
  begin
    Result.Left := Left;
    if Result.Right > Right then
      Result.Right := Right;
  end;
end;

procedure TcxGridNewItemRowViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  GridView.Styles.GetViewParams(GetStyleIndex, GridRecord, nil, AParams);
end;

function TcxGridNewItemRowViewInfo.HasFooters: Boolean;
begin
  Result := False;
end;

function TcxGridNewItemRowViewInfo.HasLastHorzGridLine: Boolean;
begin
  Result := False;
end;

function TcxGridNewItemRowViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridNewItemRowPainter;
end;

{ TcxGridFilterRowViewInfo }

function TcxGridFilterRowViewInfo.GetGridRecord: TcxGridFilterRow;
begin
  Result := TcxGridFilterRow(inherited GridRecord);
end;

function TcxGridFilterRowViewInfo.GetOptions: TcxGridSpecialRowOptions;
begin
  Result := GridView.FilterRow;
end;

function TcxGridFilterRowViewInfo.GetShowInfoText: Boolean;
begin
  Result := inherited GetShowInfoText and GridRecord.IsEmpty;
end;

function TcxGridFilterRowViewInfo.GetStyleIndex: Integer;
begin
  Result := vsFilterRowInfoText;
end;

{$IFDEF USETABCONTROL}

{ TcxGridMasterDataRowDetailsSiteLeftTabsViewInfo }

function TcxGridMasterDataRowDetailsSiteLeftTabsViewInfo.GetBottomGridLineColor: TColor;
begin
  Result := SiteViewInfo.MasterGridViewInfo.GridLineColor;
end;

function TcxGridMasterDataRowDetailsSiteLeftTabsViewInfo.GetBottomGridLineWidth: Integer;
begin
  Result := SiteViewInfo.MasterGridViewInfo.GridLineWidth;
end;

function TcxGridMasterDataRowDetailsSiteLeftTabsViewInfo.GetSiteViewInfo: TcxGridDetailsSiteViewInfo;
begin
  Result := TcxGridDetailsSiteViewInfo(inherited SiteViewInfo);
end;

function TcxGridMasterDataRowDetailsSiteLeftTabsViewInfo.CalculateHeight: Integer;
begin
  Result := inherited CalculateHeight;
  if HasBottomGridLine then
    Inc(Result, BottomGridLineWidth);
end;

function TcxGridMasterDataRowDetailsSiteLeftTabsViewInfo.GetBottomGridLineBounds: TRect;
begin
  Result := Bounds;
  Result.Top := Result.Bottom - BottomGridLineWidth;
end;

function TcxGridMasterDataRowDetailsSiteLeftTabsViewInfo.GetPainterClass: TcxGridDetailsSiteTabsPainterClass;
begin
  Result := TcxGridMasterDataRowDetailsSiteTabsPainter;
end;

function TcxGridMasterDataRowDetailsSiteLeftTabsViewInfo.GetTabControlBounds: TRect;
begin
  Result := inherited GetTabControlBounds;
  if HasBottomGridLine then
    Dec(Result.Bottom, BottomGridLineWidth);
end;

function TcxGridMasterDataRowDetailsSiteLeftTabsViewInfo.HasBottomGridLine: Boolean;
begin
  Result := bBottom in SiteViewInfo.MasterGridViewInfo.GetCellBorders(False, True);
end;

{$ENDIF}

{ TcxGridDetailsSiteViewInfo }

constructor TcxGridDetailsSiteViewInfo.Create(AMasterDataRowViewInfo: TcxGridMasterDataRowViewInfo);
begin
  FMasterDataRowViewInfo := AMasterDataRowViewInfo;
  inherited Create(TcxGridLevel(FMasterDataRowViewInfo.GridView.Level));
  if CacheItem.IsDetailsSiteCachedInfoAssigned then
    SetCachedInfo(CacheItem.DetailsSiteCachedInfo);
end;

destructor TcxGridDetailsSiteViewInfo.Destroy;
begin
  if not MasterGridViewInfo.IsInternalUse and (CacheItem <> nil) then
  begin
    if CacheItem.IsDetailsSiteCachedInfoAssigned then
      raise EdxException.Create('CacheItem.IsDetailsSiteCachedInfoAssigned');  //!!!
    GetCachedInfo(CacheItem.DetailsSiteCachedInfo);
  end;
  inherited;
end;

function TcxGridDetailsSiteViewInfo.GetCacheItem: TcxGridMasterTableViewInfoCacheItem;
begin
  Result := FMasterDataRowViewInfo.CacheItem;
end;

function TcxGridDetailsSiteViewInfo.GetMasterGridView: TcxGridTableView;
begin
  Result := FMasterDataRowViewInfo.GridView;
end;

function TcxGridDetailsSiteViewInfo.GetMasterGridViewInfo: TcxGridTableViewInfo;
begin
  Result := FMasterDataRowViewInfo.GridViewInfo;
end;

procedure TcxGridDetailsSiteViewInfo.ControlFocusChanged;
begin
  if ActiveGridViewExists then
    ActiveGridView.Controller.ControlFocusChanged;
end;

function TcxGridDetailsSiteViewInfo.GetActiveGridView: TcxCustomGridView;
begin
  Result := FMasterDataRowViewInfo.GridRecord.ActiveDetailGridView;
  if Result <> nil then
    Result.CheckSynchronizationAssignNeeded;
end;

function TcxGridDetailsSiteViewInfo.GetActiveGridViewExists: Boolean;
var
  AMasterGridRecord: TcxGridMasterDataRow;
begin
  Result := inherited GetActiveGridViewExists;
  if not Result and not IsActiveGridViewDestroying and not (csDestroying in ComponentState) then
  begin
    AMasterGridRecord := FMasterDataRowViewInfo.GridRecord;
    Result :=
      (AMasterGridRecord <> nil) and AMasterGridRecord.ActiveDetailGridViewExists and
      not AMasterGridRecord.ActiveDetailGridView.IsDestroying;
  end;
end;

function TcxGridDetailsSiteViewInfo.GetActiveGridViewValue: TcxCustomGridView;
begin
  Result := inherited GetActiveGridViewValue;
  if (Result <> nil) and (Result.ViewInfo <> nil) then
    Result.ViewInfo.IsInternalUse := MasterGridViewInfo.IsInternalUse;
end;

function TcxGridDetailsSiteViewInfo.GetActiveLevel: TcxGridLevel;
begin
  Result := FMasterDataRowViewInfo.GridRecord.ActiveDetailLevel;
end;

function TcxGridDetailsSiteViewInfo.GetCanvas: TcxCanvas;
begin
  Result := MasterGridViewInfo.Canvas;
end;

function TcxGridDetailsSiteViewInfo.GetContainer: TcxControl;
begin
  Result := MasterGridViewInfo.Site;
end;

function TcxGridDetailsSiteViewInfo.GetDesignController: TcxCustomGridDesignController;
begin
  Result := MasterGridView.Controller.DesignController;
end;

function TcxGridDetailsSiteViewInfo.GetFullyVisible: Boolean;
begin
  if CacheItem.IsDetailsSiteFullyVisibleAssigned then
    Result := CacheItem.DetailsSiteFullyVisible
  else
  begin
    Result := inherited GetFullyVisible;
    CacheItem.DetailsSiteFullyVisible := Result;
  end;  
end;

function TcxGridDetailsSiteViewInfo.GetHeight: Integer;
begin
  if CacheItem.IsDetailsSiteHeightAssigned then
    Result := CacheItem.DetailsSiteHeight
  else
  begin
    Result := inherited GetHeight;
    CacheItem.DetailsSiteHeight := Result;
  end;
end;

function TcxGridDetailsSiteViewInfo.GetMasterRecord: TObject;
begin
  Result := MasterDataRowViewInfo.GridRecord;
end;

function TcxGridDetailsSiteViewInfo.GetMaxHeight: Integer;
begin
  Result := FMasterDataRowViewInfo.RestHeight;
  TcxGridLevelAccess.CheckHeight(Level, Result);
end;

function TcxGridDetailsSiteViewInfo.GetMaxNormalHeight: Integer;
begin
  Result := inherited GetMaxNormalHeight;
  TcxGridLevelAccess.CheckHeight(Level, Result);
end;

function TcxGridDetailsSiteViewInfo.GetMaxWidth: Integer;
begin
  Result := MasterGridViewInfo.ClientWidth -
    FMasterDataRowViewInfo.LevelIndent -
    FMasterDataRowViewInfo.ExpandButtonCellViewInfo.BaseWidth;
end;

function TcxGridDetailsSiteViewInfo.GetNormalHeight: Integer;
begin
  if CacheItem.IsDetailsSiteNormalHeightAssigned then
    Result := CacheItem.DetailsSiteNormalHeight
  else
  begin
    Result := inherited GetNormalHeight;
    CacheItem.DetailsSiteNormalHeight := Result;
  end;
end;

{$IFDEF USETABCONTROL}

function TcxGridDetailsSiteViewInfo.GetTabsViewInfoClass: TcxCustomGridDetailsSiteTabsViewInfoClass;
begin
  if TabsPosition = dtpLeft then
    Result := TcxGridMasterDataRowDetailsSiteLeftTabsViewInfo
  else
    Result := inherited GetTabsViewInfoClass;
end;

{$ENDIF}

function TcxGridDetailsSiteViewInfo.GetVisible: Boolean;
begin
  Result := FMasterDataRowViewInfo.DetailsSiteVisible;
end;

function TcxGridDetailsSiteViewInfo.GetWidth: Integer;
begin
  if CacheItem.IsDetailsSiteWidthAssigned then
    Result := CacheItem.DetailsSiteWidth
  else
  begin
    Result := inherited GetWidth;
    CacheItem.DetailsSiteWidth := Result;
  end;
end;

procedure TcxGridDetailsSiteViewInfo.InitTabHitTest(AHitTest: TcxGridDetailsSiteTabHitTest);
begin
  AHitTest.Owner := MasterDataRowViewInfo.GridRecord;
end;

procedure TcxGridDetailsSiteViewInfo.ChangeActiveTab(ALevel: TcxGridLevel;
  AFocusView: Boolean = False);
var
  ARow: TcxGridMasterDataRow;
begin
  ARow := MasterDataRowViewInfo.GridRecord;
  ARow.ActiveDetailIndex := ALevel.Index;
  if AFocusView and (ARow.ActiveDetailGridView <> nil) then
    ARow.ActiveDetailGridView.Focused := True;
end;

function TcxGridDetailsSiteViewInfo.DetailHasData(ALevel: TcxGridLevel): Boolean;
begin
  Result := TcxGridMasterDataRow(MasterRecord).DetailGridViewHasData[ALevel.Index];
end;

function TcxGridDetailsSiteViewInfo.HasMaxHeight: Boolean;
begin
  Result := (Level.MaxDetailHeight <> 0) and (Height = Level.MaxDetailHeight);
end;

function TcxGridDetailsSiteViewInfo.SupportsTabAccelerators: Boolean;
begin
  Result := MasterDataRowViewInfo.SupportsTabAccelerators;
end;

{ TcxGridExpandButtonCellViewInfo }

function TcxGridExpandButtonCellViewInfo.GetRecordViewInfo: TcxGridMasterDataRowViewInfo;
begin
  Result := TcxGridMasterDataRowViewInfo(inherited RecordViewInfo);
end;

function TcxGridExpandButtonCellViewInfo.GetRightBorderRestSpaceBounds: TRect;
begin
  Result := inherited GetBorderBounds(bRight);
  Result.Bottom := BorderBounds[bRight].Top;
end;

function TcxGridExpandButtonCellViewInfo.CalculateHeight: Integer;
begin
  Result := RecordViewInfo.DataHeight;
  if RecordViewInfo.DetailsSiteVisible then
    Inc(Result, RecordViewInfo.DetailsAreaViewInfo.CalculateHeight);
end;

function TcxGridExpandButtonCellViewInfo.CalculateWidth: Integer;
begin
  Result := GridViewInfo.ClientBounds.Left + RecordViewInfo.LevelIndent +
    BaseWidth - RecordViewInfo.ContentIndent;
end;

function TcxGridExpandButtonCellViewInfo.GetBackgroundBitmap: TBitmap;
begin
  Result := RecordViewInfo.BackgroundBitmap;
end;

function TcxGridExpandButtonCellViewInfo.GetBaseWidth: Integer;
begin
  Result := GridViewInfo.LevelIndent;
end;

function TcxGridExpandButtonCellViewInfo.GetBorderBounds(AIndex: TcxBorder): TRect;
begin
  Result := inherited GetBorderBounds(AIndex);
  if AIndex = bRight then
  begin
    Inc(Result.Top, RecordViewInfo.DataHeight);
    if bBottom in Borders then
      Dec(Result.Top, BorderWidth[bBottom]);
  end;
end;

function TcxGridExpandButtonCellViewInfo.GetBorders: TcxBorders;
begin
  Result := GridViewInfo.GetCellBorders(False, True);
  if RecordViewInfo.Expanded and (bBottom in Result) then
    Include(Result, bRight)
  else
    Exclude(Result, bRight);
end;

function TcxGridExpandButtonCellViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridExpandButtonCellPainter;
end;

{ TcxGridDetailsAreaViewInfo }

function TcxGridDetailsAreaViewInfo.GetRecordViewInfo: TcxGridMasterDataRowViewInfo;
begin
  Result := TcxGridMasterDataRowViewInfo(inherited RecordViewInfo);
end;

function TcxGridDetailsAreaViewInfo.CalculateHeight: Integer;
begin
  Result := RecordViewInfo.DetailsSiteViewInfo.Height;
end;

function TcxGridDetailsAreaViewInfo.CalculateWidth: Integer;
begin
  Result := RecordViewInfo.DetailsSiteViewInfo.MaxWidth;
end;

function TcxGridDetailsAreaViewInfo.GetBorders: TcxBorders;
begin
  if GridLines in [glBoth, glHorizontal] then
    Result := [bBottom]
  else
    Result := [];
end;

{ TcxGridMasterDataRowViewInfo }

constructor TcxGridMasterDataRowViewInfo.Create(ARecordsViewInfo: TcxCustomGridRecordsViewInfo;
  ARecord: TcxCustomGridRecord);
begin
  inherited;
  if DetailsSiteVisible then
  begin
    FDetailsAreaViewInfo := GetDetailsAreaViewInfoClass.Create(Self);
    FDetailsSiteViewInfo := GetDetailsSiteViewInfoClass.Create(Self);
  end;
  FExpandButtonCellViewInfo := GetExpandButtonCellViewInfoClass.Create(Self);
end;

destructor TcxGridMasterDataRowViewInfo.Destroy;
begin
  FExpandButtonCellViewInfo.Free;
  FDetailsSiteViewInfo.Free;
  FDetailsAreaViewInfo.Free;
  inherited;
end;

function TcxGridMasterDataRowViewInfo.GetCacheItem: TcxGridMasterTableViewInfoCacheItem;
begin
  Result := TcxGridMasterTableViewInfoCacheItem(inherited CacheItem);
end;

function TcxGridMasterDataRowViewInfo.GetDetailsSiteIndentBounds: TRect;
begin
  with DetailsSiteViewInfo.Bounds do
    Result := Rect(ContentIndent, Top, Left, Bottom);
end;

function TcxGridMasterDataRowViewInfo.GetGridRecord: TcxGridMasterDataRow;
begin
  Result := TcxGridMasterDataRow(inherited GridRecord);
end;

procedure TcxGridMasterDataRowViewInfo.CalculateExpandButtonBounds(var ABounds: TRect);
begin
  ABounds := ExpandButtonAreaBounds;
  inherited;
end;

function TcxGridMasterDataRowViewInfo.CalculateHeight: Integer;
begin
  Result := inherited CalculateHeight;
  if DetailsSiteVisible then
  begin
    FRestHeight := CalculateRestHeight(Result);
    Inc(Result, DetailsSiteViewInfo.Height);
  end;
end;

function TcxGridMasterDataRowViewInfo.CalculateRestHeight(ARowHeight: Integer): Integer;
begin
  Result := RecordsViewInfo.GetRestHeight(Bounds.Top) - ARowHeight;
end;

procedure TcxGridMasterDataRowViewInfo.ControlFocusChanged;
begin
  inherited;
  if DetailsSiteVisible then
    DetailsSiteViewInfo.ControlFocusChanged;
end;

function TcxGridMasterDataRowViewInfo.GetDataHeight: Integer;
begin
  Result := inherited GetDataHeight;
  if DetailsSiteVisible then
    Dec(Result, DetailsSiteViewInfo.Height);
end;

function TcxGridMasterDataRowViewInfo.GetDataIndent: Integer;
begin
  Result := inherited GetDataIndent + GridViewInfo.LevelIndent;
end;

function TcxGridMasterDataRowViewInfo.GetDataWidth: Integer;
begin
  Result := inherited GetDataWidth - GridViewInfo.LevelIndent;
end;

function TcxGridMasterDataRowViewInfo.GetDetailsSiteVisible: Boolean;
begin
  Result := Expanded;
end;

function TcxGridMasterDataRowViewInfo.GetExpandButtonAreaBounds: TRect;
begin
  Result := Rect(ContentIndent, Bounds.Top, DataIndent, Bounds.Top + DataHeight);
end;

function TcxGridMasterDataRowViewInfo.GetMaxHeight: Integer;
begin
  Result := inherited GetMaxHeight;
  if DetailsSiteVisible then
    if not DetailsSiteViewInfo.FullyVisible and not GridViewInfo.CalculateDown and
      (Index > 0) and not DetailsSiteViewInfo.HasMaxHeight then
      Result := MaxInt div 2
    else
      Result := Result - DetailsSiteViewInfo.Height + DetailsSiteViewInfo.NormalHeight;
end;

function TcxGridMasterDataRowViewInfo.IsDetailVisible(ADetail: TcxCustomGridView): Boolean;
begin
  Result := DetailsSiteVisible and (DetailsSiteViewInfo <> nil) and
    (DetailsSiteViewInfo.ActiveLevel = ADetail.Level);
end;

function TcxGridMasterDataRowViewInfo.IsFullyVisible: Boolean;
begin
  Result := inherited IsFullyVisible and
    (not DetailsSiteVisible or DetailsSiteViewInfo.HasMaxHeight or DetailsSiteViewInfo.FullyVisible);
end;

procedure TcxGridMasterDataRowViewInfo.VisibilityChanged(AVisible: Boolean);
begin
  inherited;
  if DetailsSiteVisible then
    DetailsSiteViewInfo.VisibilityChanged(AVisible);
end;

function TcxGridMasterDataRowViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridMasterDataRowPainter;
end;

function TcxGridMasterDataRowViewInfo.GetDetailsAreaViewInfoClass: TcxGridDetailsAreaViewInfoClass;
begin
  Result := TcxGridDetailsAreaViewInfo;
end;

function TcxGridMasterDataRowViewInfo.GetDetailsSiteViewInfoClass: TcxGridDetailsSiteViewInfoClass;
begin
  Result := TcxGridDetailsSiteViewInfo;
end;

function TcxGridMasterDataRowViewInfo.GetExpandButtonCellViewInfoClass: TcxGridExpandButtonCellViewInfoClass;
begin
  Result := TcxGridExpandButtonCellViewInfo;
end;

procedure TcxGridMasterDataRowViewInfo.BeforeRecalculation;
begin
  inherited;
  if DetailsSiteVisible then
  begin
    FDetailsSiteViewInfo.BeforeRecalculation;
    FDetailsAreaViewInfo.BeforeRecalculation;
  end;
  FExpandButtonCellViewInfo.BeforeRecalculation;
end;

procedure TcxGridMasterDataRowViewInfo.Calculate(ALeftBound, ATopBound: Integer;
  AWidth: Integer = -1; AHeight: Integer = -1);
var
  ADetailLeftBound, ADetailTopBound: Integer;

  function NeedCalculateDetail: Boolean;
  begin
    Result := DetailsSiteVisible and
      (GridViewInfo.IsCalculating or
        DetailsSiteViewInfo.ActiveGridViewExists and
          (DetailsSiteViewInfo.ActiveGridView.Site.Left = cxGridInvisibleCoordinate));
  end;

begin
  inherited;
  ExpandButtonCellViewInfo.Calculate(ContentIndent, ATopBound);
  if NeedCalculateDetail then
  begin
    ADetailLeftBound := ExpandButtonCellViewInfo.Bounds.Right;
    ADetailTopBound := ATopBound + DataHeight;
    DetailsSiteViewInfo.Calculate(ADetailLeftBound, ADetailTopBound);
    DetailsAreaViewInfo.Calculate(ADetailLeftBound, ADetailTopBound);
  end;
end;

function TcxGridMasterDataRowViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
begin
  if DetailsSiteVisible and PtInRect(DetailsSiteViewInfo.Bounds, P) then
    Result := DetailsSiteViewInfo.GetHitTest(P)
  else
    Result := inherited GetHitTest(P);
end;

function TcxGridMasterDataRowViewInfo.ProcessDialogChar(ACharCode: Word): Boolean;
begin
  Result := inherited ProcessDialogChar(ACharCode);
  if not Result and DetailsSiteVisible then
    Result := DetailsSiteViewInfo.ProcessDialogChar(ACharCode);
end;

function TcxGridMasterDataRowViewInfo.SupportsTabAccelerators: Boolean;
begin
  Result := GridView.Controller.SupportsTabAccelerators(GridRecord);
end;

{ TcxGridGroupCellViewInfo }

function TcxGridGroupCellViewInfo.GetExpandedAreaBounds: TRect;
begin
  Result := inherited GetBorderBounds(bBottom);
  Result.Right := BorderBounds[bBottom].Left;
end;

function TcxGridGroupCellViewInfo.GetGridRecord: TcxGridGroupRow;
begin
  Result := TcxGridGroupRow(inherited GridRecord);
end;

function TcxGridGroupCellViewInfo.GetRecordViewInfo: TcxGridGroupRowViewInfo;
begin
  Result := TcxGridGroupRowViewInfo(inherited RecordViewInfo);
end;

function TcxGridGroupCellViewInfo.GetRowStyle: TcxGridGroupRowStyle;
begin
  Result := RecordViewInfo.RowStyle;
end;

function TcxGridGroupCellViewInfo.CalculateHeight: Integer;
begin
  Result := RecordViewInfo.DataHeight;
end;

function TcxGridGroupCellViewInfo.CalculateWidth: Integer;
begin
  with RecordViewInfo, Bounds do
    Result := Right - Left - LevelIndent;
end;

function TcxGridGroupCellViewInfo.CustomDraw(ACanvas: TcxCanvas): Boolean;
begin
  Result := inherited CustomDraw(ACanvas);
  if not Result then
    TcxGridTableViewAccess.DoCustomDrawGroupCell(GridView, ACanvas, Self, Result);
end;

function TcxGridGroupCellViewInfo.GetAlignmentVert: TcxAlignmentVert;
begin
  if RowStyle = grsStandard then
    Result := vaCenter
  else
    Result := vaBottom;
end;

function TcxGridGroupCellViewInfo.GetAlwaysSelected: Boolean;
begin
  Result := True;
end;

function TcxGridGroupCellViewInfo.GetBackgroundBitmap: TBitmap;
begin
  Result := RecordViewInfo.BackgroundBitmap;
end;

function TcxGridGroupCellViewInfo.GetBorderBounds(AIndex: TcxBorder): TRect;
begin
  Result := inherited GetBorderBounds(AIndex);
  if (AIndex = bBottom) and (RowStyle = grsStandard) and GridRecord.Expanded then
    Result.Left := RecordViewInfo.LevelIndentVertLineBounds[GridRecord.Level].Left;
end;

function TcxGridGroupCellViewInfo.GetBorderColor(AIndex: TcxBorder): TColor;
begin
  if (AIndex = bBottom) and (RowStyle = grsOffice11) then
    Result := GridView.LookAndFeelPainter.GridGroupRowStyleOffice11SeparatorColor
  else
    Result := GridViewInfo.GridLineColor;
end;

function TcxGridGroupCellViewInfo.GetBorders: TcxBorders;
begin
  Result := GridViewInfo.GetCellBorders(True, True);
  if RowStyle = grsOffice11 then
    Include(Result, bBottom);
end;

function TcxGridGroupCellViewInfo.GetBorderWidth(AIndex: TcxBorder): Integer;
begin
  if (AIndex = bBottom) and (RowStyle = grsOffice11) then
    Result := RecordViewInfo.RecordsViewInfo.GroupRowSeparatorWidth
  else
    Result := GridViewInfo.GridLineWidth;
end;

function TcxGridGroupCellViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridGroupCellPainter;
end;

function TcxGridGroupCellViewInfo.GetText: string;
begin
  Result := GridRecord.DisplayCaption;
  TcxCustomGridTableItemAccess.DoGetDisplayText(GridRecord.GroupedColumn, GridRecord, Result);
end;

function TcxGridGroupCellViewInfo.GetTextAreaBounds: TRect;
begin
  Result := inherited GetTextAreaBounds;
  if GridRecord.Expandable then
    Inc(Result.Left, GridViewInfo.LevelIndent);
end;

procedure TcxGridGroupCellViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  GridView.Styles.GetDataCellParams(GridRecord, nil, AParams, True, Self);
end;

function TcxGridGroupCellViewInfo.HasCustomDraw: Boolean;
begin
  Result := TcxGridTableViewAccess.HasCustomDrawGroupCell(GridView);
end;

function TcxGridGroupCellViewInfo.CanDrawSelected: Boolean;
begin
  Result := True;
end;

{ TcxGridGroupRowSpacerViewInfo }

constructor TcxGridGroupRowSpacerViewInfo.Create(ARowViewInfo: TcxGridGroupRowViewInfo;
  const AText: string);
begin
  inherited Create(ARowViewInfo.GridViewInfo);
  FRowViewInfo := ARowViewInfo;
  Text := AText;
end;

function TcxGridGroupRowSpacerViewInfo.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

function TcxGridGroupRowSpacerViewInfo.CalculateWidth: Integer;
begin
  Result := TextWidth;
end;

function TcxGridGroupRowSpacerViewInfo.GetAlignmentVert: TcxAlignmentVert;
begin
  Result := FRowViewInfo.CellViewInfo.AlignmentVert;
end;

function TcxGridGroupRowSpacerViewInfo.GetText: string;
begin
  Result := Text;
end;

function TcxGridGroupRowSpacerViewInfo.GetTextAreaBounds: TRect;
begin
  Result := ContentBounds;
  InflateRect(Result, 0, -cxGridCellTextOffset);
end;

procedure TcxGridGroupRowSpacerViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  GridView.Styles.GetGroupSummaryCellParams(RowViewInfo.GridRecord, nil, AParams);
end;

function TcxGridGroupRowSpacerViewInfo.GetWidth: Integer;
begin
  CalculateParams;
  Result := inherited GetWidth;
end;

function TcxGridGroupRowSpacerViewInfo.HasBackground: Boolean;
begin
  Result := False;
end;

{ TcxGridGroupSummaryCellViewInfo }

constructor TcxGridGroupSummaryCellViewInfo.Create(ARowViewInfo: TcxGridGroupRowViewInfo;
  ASummaryItem: TcxDataSummaryItem; const AValue: Variant);
begin
  inherited Create(ARowViewInfo.GridViewInfo);
  FRowViewInfo := ARowViewInfo;
  FSummaryItem := ASummaryItem;
  FValue := AValue;
  FSeparatorViewInfo := FRowViewInfo.CreateSpacerViewInfo(GetSeparatorText);
  FTextWidth := -1;
end;

destructor TcxGridGroupSummaryCellViewInfo.Destroy;
begin
  FSeparatorViewInfo.Free;
  inherited;
end;

function TcxGridGroupSummaryCellViewInfo.GetColumn: TcxGridColumn;
begin
  Result := FSummaryItem.ItemLink as TcxGridColumn;
end;

function TcxGridGroupSummaryCellViewInfo.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

procedure TcxGridGroupSummaryCellViewInfo.SetIsLast(Value: Boolean);
begin
  if FIsLast <> Value then
  begin
    FIsLast := Value;
    FSeparatorViewInfo.Text := GetSeparatorText;
  end;
end;

function TcxGridGroupSummaryCellViewInfo.CalculateWidth: Integer;
begin
  Result := TextWidth + FSeparatorViewInfo.Width;
end;

function TcxGridGroupSummaryCellViewInfo.CanAlignWithColumn: Boolean;
begin
  Result := Column <> nil;
end;

function TcxGridGroupSummaryCellViewInfo.CustomDraw(ACanvas: TcxCanvas): Boolean;
begin
  Result := inherited CustomDraw(ACanvas);
  if not Result then
  begin
    if Column <> nil then
      TcxGridColumnAccess.DoCustomDrawGroupSummaryCell(Column, ACanvas, Self, Result);
    if not Result then
      TcxGridTableViewAccess.DoCustomDrawGroupSummaryCell(GridView, ACanvas, Self, Result);
  end;
end;

function TcxGridGroupSummaryCellViewInfo.GetAlignmentHorz: TAlignment;
begin
  if CanAlignWithColumn and FRowViewInfo.SummaryCellAutoWidth then
    Result := Column.GroupSummaryAlignment
  else
    Result := taLeftJustify;
end;

function TcxGridGroupSummaryCellViewInfo.GetAlignmentVert: TcxAlignmentVert;
begin
  Result := FRowViewInfo.CellViewInfo.AlignmentVert;
end;

function TcxGridGroupSummaryCellViewInfo.GetDesignSelectionBounds: TRect;
begin
  Result := Bounds;
  InflateRect(Result, 0, -1);
end;

function TcxGridGroupSummaryCellViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridGroupSummaryHitTest;
end;

function TcxGridGroupSummaryCellViewInfo.GetIsDesignSelected: Boolean;
begin
  Result := GridView.IsDesigning and
    GridView.Controller.DesignController.IsObjectSelected(SummaryItem);
end;

function TcxGridGroupSummaryCellViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridGroupSummaryCellPainter;
end;

function TcxGridGroupSummaryCellViewInfo.GetSeparatorBounds: TRect;
begin
  Result := Bounds;
  Result.Left := Min(GetTextBounds(True, False).Right, TextAreaBounds.Right);
end;

function TcxGridGroupSummaryCellViewInfo.GetSeparatorText: string;
begin
  if IsLast then
    Result := ''
  else
    Result := (FSummaryItem.SummaryItems as TcxDataGroupSummaryItems).Separator + ' ';
end;

function TcxGridGroupSummaryCellViewInfo.GetShowEndEllipsis: Boolean;
begin
  Result := True;
end;

function TcxGridGroupSummaryCellViewInfo.GetText: string;
begin
  try
    Result := FSummaryItem.FormatValue(FValue, False);
  except
    Application.HandleException(Self);
  end;
end;

function TcxGridGroupSummaryCellViewInfo.GetTextAreaBounds: TRect;
begin
  Result := ContentBounds;
  InflateRect(Result, 0, -cxGridCellTextOffset);
  Dec(Result.Right, FSeparatorViewInfo.Width);
  if Result.Right < Result.Left then
    Result.Right := Result.Left;
end;

procedure TcxGridGroupSummaryCellViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  GridView.Styles.GetGroupSummaryCellParams(RowViewInfo.GridRecord, SummaryItem, AParams);
end;

function TcxGridGroupSummaryCellViewInfo.HasBackground: Boolean;
begin
  Result := False;
end;

function TcxGridGroupSummaryCellViewInfo.HasCustomDraw: Boolean;
begin
  Result := inherited HasCustomDraw or
    (Column <> nil) and TcxGridColumnAccess.HasCustomDrawGroupSummaryCell(Column) or
    TcxGridTableViewAccess.HasCustomDrawGroupSummaryCell(GridView);
end;

procedure TcxGridGroupSummaryCellViewInfo.InitHitTest(AHitTest: TcxCustomGridHitTest);
begin
  inherited;
  with TcxGridGroupSummaryHitTest(AHitTest) do
  begin
    if not GridView.IsDesigning then
      ViewInfo := Self.RowViewInfo;
    GridRecord := Self.RowViewInfo.GridRecord;
    SummaryItem := Self.SummaryItem;
  end;
end;

procedure TcxGridGroupSummaryCellViewInfo.Offset(DX, DY: Integer);
begin
  inherited;
  FSeparatorViewInfo.DoOffset(DX, DY);
end;

procedure TcxGridGroupSummaryCellViewInfo.BeforeRecalculation;
begin
  inherited;
  FSeparatorViewInfo.BeforeRecalculation;
end;

procedure TcxGridGroupSummaryCellViewInfo.Calculate(ALeftBound, ATopBound: Integer;
  AWidth: Integer = -1; AHeight: Integer = -1);
begin
  inherited;
  FSeparatorViewInfo.Calculate(GetSeparatorBounds);
end;

function TcxGridGroupSummaryCellViewInfo.MouseDown(AHitTest: TcxCustomGridHitTest;
  AButton: TMouseButton; AShift: TShiftState): Boolean;
begin
  Result := inherited MouseDown(AHitTest, AButton, AShift);
  if GridView.IsDesigning and (AButton = mbLeft) then
  begin
    GridView.Controller.DesignController.SelectObject(SummaryItem, not (ssShift in AShift));
    Result := True;
  end;
end;

{ TcxGridGroupRowViewInfo }

constructor TcxGridGroupRowViewInfo.Create(ARecordsViewInfo: TcxCustomGridRecordsViewInfo;
  ARecord: TcxCustomGridRecord); 
begin
  inherited;
  FCellViewInfo := TcxGridGroupCellViewInfo.Create(Self);
  FSummaryCellViewInfos := TList.Create;
  FSummaryCellsWithoutColumns := TList.Create;
  CreateSummaryCellViewInfos;
  GetColumnSummaryCellViewInfos(nil, FSummaryCellsWithoutColumns);
  CreateSpacerViewInfos;
end;

destructor TcxGridGroupRowViewInfo.Destroy;
begin
  DestroySpacerViewInfos;
  DestroySummaryCellViewInfos;
  FSummaryCellsWithoutColumns.Free;
  FSummaryCellViewInfos.Free;
  FCellViewInfo.Free;
  inherited;
end;

function TcxGridGroupRowViewInfo.GetGridRecord: TcxGridGroupRow;
begin
  Result := TcxGridGroupRow(inherited GridRecord);
end;

function TcxGridGroupRowViewInfo.GetRowStyle: TcxGridGroupRowStyle;
begin
  Result := GridView.OptionsView.GroupRowStyle;
end;

function TcxGridGroupRowViewInfo.GetSummaryCellLayout: TcxGridGroupSummaryLayout;
begin
  Result := GridView.OptionsView.GetGroupSummaryLayout;
end;

function TcxGridGroupRowViewInfo.GetSummaryCellViewInfo(Index: Integer): TcxGridGroupSummaryCellViewInfo;
begin
  Result := TcxGridGroupSummaryCellViewInfo(FSummaryCellViewInfos[Index]);
end;

function TcxGridGroupRowViewInfo.GetSummaryCellViewInfoCount: Integer;
begin
  Result := FSummaryCellViewInfos.Count;
end;

procedure TcxGridGroupRowViewInfo.CalculateExpandButtonBounds(var ABounds: TRect);
begin
  ABounds := FCellViewInfo.ContentBounds;
  if RowStyle = grsOffice11 then
    with ABounds do
      Top := Bottom - FCellViewInfo.TextHeightWithOffset;
  inherited;
end;

function TcxGridGroupRowViewInfo.CalculateHeight: Integer;
begin
  if AutoHeight then
  begin
    CellViewInfo.CalculateParams;
    Result := RecordsViewInfo.CalculateCustomGroupRowHeight(False, CellViewInfo.Params);
  end
  else
    Result := RecordsViewInfo.GroupRowHeight;
  Inc(Result, inherited CalculateHeight);
end;

function TcxGridGroupRowViewInfo.CanSize: Boolean;
begin
  Result := GridView.OptionsCustomize.GroupRowSizing;
end;

procedure TcxGridGroupRowViewInfo.CheckRowHeight(var AValue: Integer);
begin
  Dec(AValue, NonBaseHeight);
  inherited;
  GridView.OptionsView.CheckGroupRowHeight(AValue);
  Inc(AValue, NonBaseHeight);
end;

function TcxGridGroupRowViewInfo.GetAutoHeight: Boolean;
begin
  Result := inherited GetAutoHeight and (GridView.OptionsView.GroupRowHeight = 0);
end;

function TcxGridGroupRowViewInfo.GetBackgroundBitmap: TBitmap;
begin
  Result := RecordsViewInfo.GroupBackgroundBitmap;
end;

function TcxGridGroupRowViewInfo.GetExpandButtonAreaBounds: TRect;
begin
  Result := FCellViewInfo.ContentBounds;
  Result.Right := Result.Left + GridViewInfo.LevelIndent;
end;

function TcxGridGroupRowViewInfo.GetFocusRectBounds: TRect;
begin
  Result := inherited GetFocusRectBounds;
  Result.Bottom := FCellViewInfo.ContentBounds.Bottom;
end;

function TcxGridGroupRowViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridGroupRowPainter;
end;

function TcxGridGroupRowViewInfo.GetSeparatorBounds: TRect;
begin
  Result := inherited GetSeparatorBounds;
  if Expanded then Inc(Result.Left, GridViewInfo.LevelIndent);
end;

function TcxGridGroupRowViewInfo.GetSeparatorIndentBounds: TRect;
begin
  Result := inherited GetSeparatorBounds;
  Result.Right := SeparatorBounds.Left;
end;

function TcxGridGroupRowViewInfo.GetShowSeparator: Boolean;
begin
  if RowStyle = grsStandard then
    Result := inherited GetShowSeparator
  else
    Result := False;
end;

function TcxGridGroupRowViewInfo.HasFocusRect: Boolean;
begin
  Result := True;
end;

function TcxGridGroupRowViewInfo.HasFooter(ALevel: Integer): Boolean;
begin
  Result := inherited HasFooter(ALevel) or
    (GridView.OptionsView.GroupFooters = gfAlwaysVisible) and
    (ALevel = 0) and not GridRecord.Expanded and
    TcxGridColumnAccess.CanShowGroupFooters(GridRecord.GroupedColumn);
end;

procedure TcxGridGroupRowViewInfo.Offset(DX, DY: Integer);
var
  I: Integer;
begin
  inherited;
  FCellViewInfo.DoOffset(DX, DY);
  if FSummaryBeginningSpacerViewInfo <> nil then
    FSummaryBeginningSpacerViewInfo.DoOffset(DX, DY);
  for I := 0 to SummaryCellViewInfoCount - 1 do
    SummaryCellViewInfos[I].DoOffset(DX, DY);
  if FSummaryEndingSpacerViewInfo <> nil then
    FSummaryEndingSpacerViewInfo.DoOffset(DX, DY);
end;

procedure TcxGridGroupRowViewInfo.SetRowHeight(Value: Integer);
begin
  if RowHeight <> Value then
    GridView.OptionsView.GroupRowHeight := Value - NonBaseHeight;
end;

function TcxGridGroupRowViewInfo.CreateSpacerViewInfo(const AText: string): TcxGridGroupRowSpacerViewInfo;
begin
  Result := GetSpacerViewInfoClass.Create(Self, AText);
end;

procedure TcxGridGroupRowViewInfo.CreateSpacerViewInfos;
begin
  if HasUnalignableSummaryCells then
  begin
    FSummaryBeginningSpacerViewInfo := CreateSpacerViewInfo(GetSummaryBeginningSpacerText);
    FSummaryEndingSpacerViewInfo := CreateSpacerViewInfo(GetSummaryEndingSpacerText);
  end;
end;

procedure TcxGridGroupRowViewInfo.DestroySpacerViewInfos;
begin
  FSummaryEndingSpacerViewInfo.Free;
  FSummaryBeginningSpacerViewInfo.Free;
end;

function TcxGridGroupRowViewInfo.GetSpacerViewInfoClass: TcxGridGroupRowSpacerViewInfoClass;
begin
  Result := TcxGridGroupRowSpacerViewInfo;
end;

function TcxGridGroupRowViewInfo.AddSummaryCellViewInfo(ASummaryItem: TcxDataSummaryItem;
  const AValue: Variant): TcxGridGroupSummaryCellViewInfo;
begin
  Result := GetSummaryCellViewInfoClass.Create(Self, ASummaryItem, AValue);
  FSummaryCellViewInfos.Add(Result);
end;

procedure TcxGridGroupRowViewInfo.CreateSummaryCellViewInfos;
var
  ASummaryItems: TcxDataSummaryItems;
  ASummaryValues: PVariant;
  I: Integer;
begin
  if not GridRecord.GetGroupSummaryInfo(ASummaryItems, ASummaryValues) then Exit;
  for I := 0 to ASummaryItems.Count - 1 do
    if ASummaryItems[I].Position = spGroup then
      AddSummaryCellViewInfo(ASummaryItems[I], ASummaryValues^[I]);
end;

procedure TcxGridGroupRowViewInfo.DestroySummaryCellViewInfos;
var
  I: Integer;
begin
  for I := 0 to SummaryCellViewInfoCount - 1 do
    SummaryCellViewInfos[I].Free;
end;

function TcxGridGroupRowViewInfo.GetSummaryCellViewInfoClass: TcxGridGroupSummaryCellViewInfoClass;
begin
  Result := TcxGridGroupSummaryCellViewInfo;
end;

procedure TcxGridGroupRowViewInfo.CalculateSummaryCells;
var
  I: Integer;
  AColumnHeaderViewInfo: TcxGridColumnHeaderViewInfo;
  ACellViewInfos: TList;
begin
  if SummaryCellViewInfoCount = 0 then Exit;

  if HasUnalignableSummaryCells then
  begin
    SummaryBeginningSpacerViewInfo.Calculate(GetSummaryBeginningSpacerBounds);
    TcxGridGroupSummaryCellViewInfo(UnalignableSummaryCells.Last).IsLast := True;
    CalculateSummaryCells(UnalignableSummaryCells, GetSummaryCellsAreaBounds(False),
      taLeftJustify, False);
    SummaryEndingSpacerViewInfo.Calculate(GetSummaryEndingSpacerBounds);
  end;

  if SummaryCellLayout <> gslStandard then
  begin
    ACellViewInfos := TList.Create;
    try
      for I := 0 to GridViewInfo.HeaderViewInfo.Count - 1 do
      begin
        AColumnHeaderViewInfo := GridViewInfo.HeaderViewInfo[I];
        GetColumnSummaryCellViewInfos(AColumnHeaderViewInfo.Column, ACellViewInfos);
        if ACellViewInfos.Count <> 0 then
        begin
          TcxGridGroupSummaryCellViewInfo(ACellViewInfos.Last).IsLast := True;
          CalculateSummaryCells(ACellViewInfos,
            GetColumnSummaryCellsAreaBounds(AColumnHeaderViewInfo),
            AColumnHeaderViewInfo.Column.GroupSummaryAlignment, SummaryCellAutoWidth);
        end;
      end;
    finally
      ACellViewInfos.Free;
    end;
  end;
end;

procedure TcxGridGroupRowViewInfo.CalculateSummaryCells(ACellViewInfos: TList;
  const AAreaBounds: TRect; AAlignment: TAlignment; AAutoWidth: Boolean);
var
  AWidths: TcxAutoWidthObject;
  ABounds: TRect;
  I: Integer;
begin
  AWidths := CalculateSummaryCellWidths(ACellViewInfos, AAreaBounds.Right - AAreaBounds.Left,
    AAutoWidth);
  try
    ABounds := GetSummaryCellsBounds(AAreaBounds, AWidths, AAlignment, AAutoWidth);
    for I := 0 to ACellViewInfos.Count - 1 do
    begin
      ABounds.Right := Min(ABounds.Left + AWidths[I].AutoWidth, AAreaBounds.Right);
      TcxGridGroupSummaryCellViewInfo(ACellViewInfos[I]).Calculate(ABounds);
      ABounds.Left := ABounds.Right;
    end;
  finally
    AWidths.Free;
  end;
end;

function TcxGridGroupRowViewInfo.CalculateSummaryCellWidths(ACellViewInfos: TList;
  AAvailableWidth: Integer; AAutoWidth: Boolean): TcxAutoWidthObject;
var
  I: Integer;
begin
  Result := TcxAutoWidthObject.Create(ACellViewInfos.Count);
  Result.AvailableWidth := AAvailableWidth;
  for I := 0 to ACellViewInfos.Count - 1 do
    with Result.AddItem do
    begin
      Width := TcxGridGroupSummaryCellViewInfo(ACellViewInfos[I]).CalculateWidth;
      MinWidth := Width;
      Fixed := False;
      if not AAutoWidth then AutoWidth := Width;
    end;
  if AAutoWidth then Result.Calculate;
end;

function TcxGridGroupRowViewInfo.GetColumnSummaryCellsAreaBounds(AColumnHeaderViewInfo: TcxGridColumnHeaderViewInfo): TRect;
begin
  Result := GetSummaryCellsAreaBounds(True);
  Result.Left := Max(Result.Left, AColumnHeaderViewInfo.DataOffset + cxGridCellTextOffset);
  Result.Right := Min(Result.Right, AColumnHeaderViewInfo.Bounds.Right - cxGridCellTextOffset);
end;

procedure TcxGridGroupRowViewInfo.GetColumnSummaryCellViewInfos(AColumn: TcxGridColumn; AList: TList);
var
  I: Integer;
begin
  AList.Clear;
  for I := 0 to SummaryCellViewInfoCount - 1 do
    if SummaryCellViewInfos[I].Column = AColumn then
      AList.Add(SummaryCellViewInfos[I]);
end;

function TcxGridGroupRowViewInfo.GetSummaryBeginningSpacerBounds: TRect;
begin
  Result := GetSummaryCellsAreaBounds(False);
  Result.Right := Result.Left;
  Dec(Result.Left, SummaryBeginningSpacerViewInfo.Width);
  Result.Right := Min(Result.Right, CellViewInfo.TextAreaBounds.Right);
end;

function TcxGridGroupRowViewInfo.GetSummaryEndingSpacerBounds: TRect;
begin
  Result := GetSummaryCellsAreaBounds(False);
  Result.Left := TcxGridGroupSummaryCellViewInfo(UnalignableSummaryCells.Last).Bounds.Right;
  Result.Right := Result.Left + SummaryEndingSpacerViewInfo.Width;
  Result.Right := Min(Result.Right, CellViewInfo.TextAreaBounds.Right);
end;

function TcxGridGroupRowViewInfo.GetSummaryBeginningSpacerText: string;
begin
  Result := ' ' + GridRecord.GroupSummaryItems.BeginText;
end;

function TcxGridGroupRowViewInfo.GetSummaryEndingSpacerText: string;
begin
  Result := GridRecord.GroupSummaryItems.EndText;
end;

function TcxGridGroupRowViewInfo.GetSummaryCellAutoWidth: Boolean;
begin
  Result := SummaryCellLayout = gslAlignWithColumnsAndDistribute;
end;

function TcxGridGroupRowViewInfo.GetSummaryCellsAreaBounds(AForAlignableCells: Boolean): TRect;
begin
  Result := CellViewInfo.ContentBounds;
  Result.Right := CellViewInfo.TextAreaBounds.Right;
  Result.Left := Min(CellViewInfo.GetTextBounds(True, False).Right, Result.Right);
  if AForAlignableCells then
  begin
    if HasUnalignableSummaryCells then
      Result.Left := SummaryEndingSpacerViewInfo.Bounds.Right;
    Inc(Result.Left, 2 * cxGridCellTextOffset);
  end
  else
  begin
    Inc(Result.Left, SummaryBeginningSpacerViewInfo.Width);
    Dec(Result.Right, SummaryEndingSpacerViewInfo.Width);
    if Result.Right < Result.Left then
      Result.Right := Result.Left;
  end;
end;

function TcxGridGroupRowViewInfo.GetSummaryCellsBounds(const AAreaBounds: TRect;
  AWidths: TcxAutoWidthObject; AAlignment: TAlignment; AAutoWidth: Boolean): TRect;
begin
  Result := AAreaBounds;
  if not AAutoWidth and (AWidths.Width < AWidths.AvailableWidth) then
    case AAlignment of
      taRightJustify:
        Result.Left := Result.Right - AWidths.Width;
      taCenter:
        Result.Left := (Result.Left + Result.Right - AWidths.Width) div 2;
    end;
end;

function TcxGridGroupRowViewInfo.GetUnalignableSummaryCells: TList;
begin
  if SummaryCellLayout = gslStandard then
    Result := SummaryCells
  else
    Result := SummaryCellsWithoutColumns;
end;

function TcxGridGroupRowViewInfo.HasUnalignableSummaryCells: Boolean;
begin
  Result := (SummaryCellLayout = gslStandard) or (SummaryCellsWithoutColumns.Count <> 0);
end;

procedure TcxGridGroupRowViewInfo.BeforeRecalculation;
var
  I: Integer;
begin
  inherited;
  FCellViewInfo.BeforeRecalculation;
  if FSummaryBeginningSpacerViewInfo <> nil then
    FSummaryBeginningSpacerViewInfo.BeforeRecalculation;
  for I := 0 to SummaryCellViewInfoCount - 1 do
    SummaryCellViewInfos[I].BeforeRecalculation;
  if FSummaryEndingSpacerViewInfo <> nil then
    FSummaryEndingSpacerViewInfo.BeforeRecalculation;  
end;

procedure TcxGridGroupRowViewInfo.Calculate(ALeftBound, ATopBound: Integer;
  AWidth: Integer = -1; AHeight: Integer = -1);
begin
  inherited;
  FCellViewInfo.Calculate(ALeftBound + LevelIndent, ATopBound);
  CalculateSummaryCells;
end;

function TcxGridGroupRowViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
var
  I: Integer;
  AHitTest: TcxCustomGridHitTest;
begin
  Result := inherited GetHitTest(P);
  if Result <> nil then
    for I := 0 to SummaryCellViewInfoCount - 1 do
    begin
      AHitTest := SummaryCellViewInfos[I].GetHitTest(P);
      if AHitTest <> nil then
      begin
        Result := AHitTest;
        Break;
      end;
    end;
end;

end.
