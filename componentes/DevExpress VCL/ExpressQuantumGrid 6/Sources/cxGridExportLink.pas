{*******************************************************************}
{                                                                   }
{       Developer Express Cross Platform Component Library          }
{       ExpressQuantumGrid                                          }
{                                                                   }
{       Copyright (c) 2001-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSQUANTUMGRID AND ALL           }
{   ACCOMPANYING VCL AND CLX CONTROLS AS PART OF AN EXECUTABLE      }
{   PROGRAM ONLY.                                                   }
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

unit cxGridExportLink;

{$I cxVer.inc}

interface

uses
{$IFDEF DELPHI6}
  Types, Variants, FMTBcd, SqlTimSt,
{$ENDIF}
  Windows, Classes, SysUtils, Graphics, DB,
  dxCore, cxGeometry, cxControls, cxClasses, cxGraphics,
  cxStyles, cxLookAndFeels, cxLookAndFeelPainters,
  cxCustomData, cxDataStorage, cxDataUtils, cxDBData, cxVariants, cxExport,
  cxEdit, cxImage, cxCalendar, cxCurrencyEdit, cxSpinEdit,
  cxCalc, cxTimeEdit, cxMaskEdit,
  cxGrid, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridBandedTableView, cxGridCardView, cxGridLevel,
  cxGridStrs, cxGridDBDataDefinitions, cxGridCommon, cxGridChartView;

const
  cxGridFooterCellIndent: Integer = 0;

type
  EcxGridExport = class(EdxException);

  { TcxGridCustomExport }

  TcxGridCustomExport = class
  private
    FColumns: TcxExportScale;
    FDefaultRowHeight: Integer;
    FDefaultStyle: TcxCacheCellStyle;
    FDefaultStyleIndex: Integer;
    FExpand: Boolean;
    FExportType: Integer;
    FFileName: string;
    FGrid: TcxCustomGrid;
    FGridView: TcxCustomGridView;
    FInternalProvider: IcxCellInternalCache;
    FInternalProviderSupported: Boolean;
    FProvider: IcxExportProvider;
    FRows: TcxExportScale;
    FRecordsList: TList;
    FSaveAll: Boolean;
    FSaveGridModeFlag: Boolean;
    FUseNativeFormat: Boolean;
    FViewInfo: TcxCustomGridViewInfo;
    function GetDataController: TcxCustomDataController;
    function GetExpandButtonSize: Integer;
    function GetRecord(ARecordIndex: Integer): TcxCustomGridRecord;
    function GetRecordCount: Integer;
    function GetViewInfo: TcxCustomGridViewInfo;
  protected
    procedure BeforeCommit; virtual;
    function CalculateViewViewInfo(AGridView: TcxCustomGridView; ABounds: TRect): TcxCustomGridViewInfo; virtual;
    function CheckNativeValue(AProperties: TcxCustomEditProperties; AItem: TcxCustomGridTableItem; const AValue: Variant): Variant;
    procedure CreateExportCache; virtual;
    procedure CreateExportCells; virtual;
    procedure ExpandRecords(AFullExpand: Boolean); virtual;
    procedure ExportCells; virtual;
    procedure ExtractRowsForExport; virtual;
    procedure FillArea(const ABounds: TRect; AStyleIndex: Integer;
      ABorderColor: TColor = clDefault; ABorders: TcxBorders = cxBordersAll);
    procedure FillRealArea(const ABounds: TRect; AStyleIndex: Integer;
      ABorderColor: TColor = clDefault; ABorders: TcxBorders = cxBordersAll);
    procedure Finalize; virtual;
    function GetContentParams(ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      out AParams: TcxViewParams; ABorders: TcxBorders = []; ABorderColor: TColor = clDefault): TcxCacheCellStyle;
    function GetViewItemValue(ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem): Variant; 
    function GetViewItemValueEx(ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AProperties: TcxCustomEditProperties): Variant; virtual;
    function HasSelectedChildren(ARecord: TcxCustomGridRecord): Boolean;
    function HasSelectedRecords(AView: TcxCustomGridView): Boolean;
    procedure Initialize; virtual;
    function IsCurrencyItem(AItem: TcxCustomGridTableItem): Boolean;
    function IsCurrencyProperties(AProperties: TcxCustomEditProperties): Boolean;
    function IsEmpty: Boolean;
    function IsNativeFormatProperties(AProperties: TcxCustomEditProperties; AItem: TcxCustomGridTableItem): Boolean; virtual;
    procedure RealBoundsToLogicalBounds(const ABounds: TRect; out ALogicalBounds: TRect);
    procedure RealBoundsToLogicalBoundsEx(const ABounds, ASearchArea: TRect; out ALogicalBounds: TRect);
    function RegisterContentParams(ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AParams: TcxViewParams): Integer;
    function RegisterSolidStyle(AStyleIndex: Integer; AData: TObject = nil): Integer;
    function RegisterSolidStyleEx(AColor: TColor): Integer;
    procedure RegisterStyles; virtual;
    function RegisterViewParams(const AViewParams: TcxViewParams; const AAlignment: TAlignment = taLeftJustify): Integer;
    function SetCellAsGraphic(AColumn, ARow: Integer; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem): Boolean;
    procedure SetCellValueAndStyle(AColumn, ARow: Integer;
      const AValue: Variant; const AStyle: TcxCacheCellStyle);
    procedure SetRealCellStyle(const ARealBounds, ASearchArea: TRect; AStyleIndex: Integer);
    procedure SetRealCellStyleAndValue(const ARealBounds, ASearchArea: TRect; AStyleIndex: Integer; const AValue: Variant);
    procedure SetRealCellStyleAndValueEx(const ARealBounds, ASearchArea: TRect;
      AStyleIndex: Integer; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem);
    function TextHeight(AFont: TFont): Integer;
    function TextHeightEx(const AViewParams: TcxViewParams): Integer;
    function TextWidth(AFont: TFont; const AText: string): Integer;
    function TextWidthEx(const AViewParams: TcxViewParams; const AText: string): Integer;
    procedure ViewParamsToExportStyle(const AViewParams: TcxViewParams;
      var AExportStyle: TcxCacheCellStyle; const AAlignment: TAlignment = taLeftJustify;
      ABorders: TcxBorders = []; ABorderColor: TColor = clDefault);

    property DataController: TcxCustomDataController read GetDataController;
    property DefaultRowHeight: Integer read FDefaultRowHeight write FDefaultRowHeight;
    property DefaultStyle: TcxCacheCellStyle read FDefaultStyle write FDefaultStyle;
    property DefaultStyleIndex: Integer read FDefaultStyleIndex write FDefaultStyleIndex;
    property ExportType: Integer read FExportType;
    property RecordsList: TList read FRecordsList;
  public
    constructor Create(AFileName: string; AExportType: Integer; AGridView: TcxCustomGridView;
      AGrid: TcxCustomGrid; AViewInfo: TcxCustomGridViewInfo); virtual;
    constructor CreateFrom(AMasterExport: TcxGridCustomExport;
      AGridView: TcxCustomGridView; AViewInfo: TcxCustomGridViewInfo); virtual;
    destructor Destroy; override;
    procedure AddSeparators(const ASeparators: array of string);
    procedure DoExport; virtual;

    property Columns: TcxExportScale read FColumns;
    property Expand: Boolean read FExpand write FExpand;
    property ExpandButtonSize: Integer read GetExpandButtonSize;
    property FileName: string read FFileName;
    property Grid: TcxCustomGrid read FGrid;
    property GridView: TcxCustomGridView read FGridView;
    property InternalProvider: IcxCellInternalCache read FInternalProvider;
    property InternalProviderSupported: Boolean read FInternalProviderSupported;
    property Provider: IcxExportProvider read FProvider;
    property RecordCount: Integer read GetRecordCount;
    property Records[ARecordIndex: Integer]: TcxCustomGridRecord read GetRecord;
    property Rows: TcxExportScale read FRows;
    property SaveAll: Boolean read FSaveAll write FSaveAll;
    property UseNativeFormat: Boolean read FUseNativeFormat write FUseNativeFormat;
    property ViewInfo: TcxCustomGridViewInfo read GetViewInfo;
  end;

  TcxGridCustomExportClass = class of TcxGridCustomExport;

  TcxExportVisualItem = class
  public
    Bounds: TRect;
    Data: TObject;
    Data2: TObject;
    DisplayText: string;
    Hidden: Boolean;
    IsBackground: Boolean;
    Style: Integer;
    Slave: Boolean;
    Value: Variant; 
    function GetBoundsRelativeTo(ATop, ALeft: Integer): TRect;
    function IsColumn: Boolean;
  end;

  TcxExportGroupSummaryItem = class
  public
    Alignment: TAlignment;
    Bounds: TRect;
    Column: TcxGridColumn;
    Index: Integer;
    SummaryItem: TcxGridTableSummaryItem;
    Text: string;
    Value: Variant;
    ViewParams: TcxViewParams;
    procedure InitWidth;
  end;

  TcxExportVisualItemClass = class of TcxExportVisualItem;

  { TcxGridTableViewExport }

  TcxGridTableViewExport = class(TcxGridCustomExport)
  private
    FGroupSummaryItemsList: TcxObjectList;
    FRecordHeight: Integer;
    FRecordRowCount: Integer;
    FRecordWidth: Integer;
    FPatternsList: TcxObjectList;
    FVisualItemsList: TcxObjectList;
    function GetFooterCellBorderColor: TColor;
    function GetGridLineColor: TColor;
    function GetGridLines: TcxBorders;
    function GetGridView: TcxGridTableView;
    function GetGroupSummaryCount: Integer;
    function GetGroupSummaryItem(AIndex: Integer): TcxExportGroupSummaryItem;
    function GetHasPreview(ARow: TcxCustomGridRecord): Boolean;
    function GetIndicatorWidth: Integer;
    function GetLeftPos: Integer;
    function GetOptionsView: TcxGridTableOptionsView;
    function GetPattern(AIndex: Integer): TcxExportVisualItem;
    function GetPatternCount: Integer;
    function GetPreviewPlace: TcxGridPreviewPlace;
    function GetStyles: TcxGridTableViewStyles;
    function GetViewInfo: TcxGridTableViewInfo;
    function GetVisualItem(AIndex: Integer): TcxExportVisualItem;
    function GetVisualItemCount: Integer;
    procedure SetLeftPos(AValue: Integer);
  protected
    procedure AddDataRow(var ATop, ALeft: Integer; ARow: TcxGridDataRow); virtual;
    procedure AddFooterCells(var ATop, ALeft: Integer; ARow: TcxCustomGridRow;
      ALevel, ADataLevel: Integer; AItems: TcxDataSummaryItems; AValues: PVariant; AIsFooter: Boolean); virtual;
    procedure AddGroupRow(var ATop, ALeft: Integer; ARow: TcxGridGroupRow); virtual;
    function AddIndents(ATop, ARowHeight: Integer; ARow: TcxCustomGridRecord; AHasButton: Boolean; ALevel: Integer = -1): Integer; virtual;
    procedure AddMasterDataRow(var ATop, ALeft: Integer; ARow: TcxGridMasterDataRow); virtual;
    procedure AddRowFooter(var ATop, ALeft: Integer; ADataLevel, ALevel: Integer; ARow: TcxCustomGridRecord); virtual;
    procedure AddRowFooters(var ATop, ALeft: Integer; ARow: TcxCustomGridRecord); virtual;
    procedure AddRowPreview(var ATop, ALeft: Integer; ARow: TcxCustomGridRecord); virtual;
    function AddVisualDataItem(const AItemBounds: TRect; AStyle: Integer;
      ARecord: TcxCustomGridRecord; AColumn: TcxGridColumn): TcxExportVisualItem;
    function AddVisualItem(AItemClass: TcxExportVisualItemClass; const ABounds: TRect): TcxExportVisualItem; virtual;
    function AddVisualItemEx(const AItemBounds: TRect; const ADisplayText: string;
      const AViewParams: TcxViewParams; AAlignment: TAlignment; ABorders: TcxBorders;
      ABorderColor: TColor = clDefault; AIsBackground: Boolean = False): TcxExportVisualItem; overload;
    function AddVisualItemEx(const AItemBounds: TRect; const ADisplayText: string;
      AStyle: Integer; AIsBackground: Boolean = False): TcxExportVisualItem; overload;
    function AddPattern(const ABounds: TRect; AData: TObject; AOffset: Integer = 0): TcxExportVisualItem;
    function CanShowMultiSummaries(AIsFooter: Boolean): Boolean;
    procedure CreateContent(var ATop, ALeft: Integer); virtual;
    procedure CreateFooter(var ATop, ALeft: Integer); virtual;
    procedure CreateHeader(var ATop, ALeft: Integer); virtual;
    procedure CreateExportCells; override;
    procedure CreateRecordFromPattern(var ATop, ALeft: Integer; ARecord: TcxCustomGridRecord);
    function DoMergeCell(AMasterItem, ASlaveItem: TcxExportVisualItem): Boolean;
    procedure ExportCells; override;
    procedure ExportDetailCell(ACell: TcxExportVisualItem); virtual;
    procedure Finalize; override;
    function GetColumnOffset(AColumn: TcxGridColumn): Integer; virtual;
    function GetExpandButtonParams(ABorders: TcxBorders): TcxCacheCellStyle;
    function GetFooterCellCount(AItems: TcxDataSummaryItems): Integer;
    function GetFooterItemBounds(AIndex, ALineIndex: Integer; const AOrigin: TRect; AIsFooter: Boolean): TRect;
    function GetFooterLineCount(AItems: TcxDataSummaryItems): Integer;
    function GetGroupRowColumnIntersection(const ARowBounds: TRect; AColumn: TcxGridColumn): TRect;
    function GetIsSummaryUnderColumns: Boolean; virtual;
    function GetPatternParams(ARecord: TcxCustomGridRecord; AItem: TcxExportVisualItem): TcxViewParams; virtual;
    function GetPreviewHeight(ARow: TcxCustomGridRecord): Integer;
    function HasFooter(ARow: TcxCustomGridRecord; var ALevel: Integer): Boolean; virtual;
    procedure Initialize; override;
    procedure MergeCells; virtual;
    procedure ProcessGroupSummaryItem(ARow: TcxGridGroupRow; AValues: PVariant;
      AIndex: Integer; const ABounds: TRect; const ARowViewParams: TcxViewParams);
    procedure ProcessGroupSummaryItems(ARow: TcxGridGroupRow; ABounds: TRect);
    procedure ProduceHeadersContainer(var ATop, ALeft: Integer;
      AViewInfo: TcxGridColumnContainerViewInfo);
    procedure SetPatternsBounds(ATop, ABottom: Integer);

    property GroupSummaryItemCount: Integer read GetGroupSummaryCount;
    property GroupSummaryItems[Index: Integer]: TcxExportGroupSummaryItem read GetGroupSummaryItem;
    property GroupSummaryItemsList: TcxObjectList read FGroupSummaryItemsList;
    property LeftPos: Integer read GetLeftPos write SetLeftPos;
    property PatternCount: Integer read GetPatternCount;
    property Patterns[Index: Integer]: TcxExportVisualItem read GetPattern;
    property PatternsList: TcxObjectList read FPatternsList;
  public
    property FooterCellBorderColor: TColor read GetFooterCellBorderColor;
    property GridLineColor: TColor read GetGridLineColor;
    property GridLines: TcxBorders read GetGridLines;
    property GridView: TcxGridTableView read GetGridView;
    property HasPreview[ARow: TcxCustomGridRecord]: Boolean read GetHasPreview;
    property IndicatorWidth: Integer read GetIndicatorWidth;
    property IsSummaryUnderColumns: Boolean read GetIsSummaryUnderColumns;
    property OptionsView: TcxGridTableOptionsView read GetOptionsView;
    property PreviewPlace: TcxGridPreviewPlace read GetPreviewPlace;
    property RecordHeight: Integer read FRecordHeight write FRecordHeight;
    property RecordRowCount: Integer read FRecordRowCount;
    property RecordWidth: Integer read FRecordWidth write FRecordWidth;
    property Styles: TcxGridTableViewStyles read GetStyles;
    property ViewInfo: TcxGridTableViewInfo read GetViewInfo;
    property VisualItemCount: Integer read GetVisualItemCount;
    property VisualItems[Index: Integer]: TcxExportVisualItem read GetVisualItem;
    property VisualItemsList: TcxObjectList read FVisualItemsList;
  end;

  { TcxGridBandedTableViewExport }

  TcxGridBandedTableViewExport = class(TcxGridTableViewExport)
  private
    function GetGridView: TcxGridBandedTableView;
    function GetOptionsView: TcxGridBandedTableOptionsView;
    function GetViewInfo: TcxGridBandedTableViewInfo;
  protected
    procedure CreateBandHeaders(var ATop: Integer; AForRootBands: Boolean); virtual;
    procedure CreateHeader(var ATop, ALeft: Integer); override;
    function GetColumnOffset(AColumn: TcxGridColumn): Integer; override;
    function GetContentOffset: TPoint; virtual;
    function GetIsSummaryUnderColumns: Boolean; override;
    function GetParentBandOffset(ABand: TcxGridBand): Integer;
    function GetPatternByBand(ABand: TcxGridBand): TcxExportVisualItem;
    function GetPatternParams(ARecord: TcxCustomGridRecord; AItem: TcxExportVisualItem): TcxViewParams; override;
    function ProduceColumnsContainer(AContainer: TcxGridColumnContainerViewInfo; ATop, ALeft: Integer): Integer;
  public
    property ContentOffset: TPoint read GetContentOffset;
    property GridView: TcxGridBandedTableView read GetGridView;
    property OptionsView: TcxGridBandedTableOptionsView read GetOptionsView; 
    property ViewInfo: TcxGridBandedTableViewInfo read GetViewInfo;
  end;

  { TcxGridCardViewExport }

  TcxExportCard = class;
  TcxGridCardViewExport = class;

  TcxExportCardRow = class
  private
    FHasSeparator: Boolean;
    FOwner: TcxExportCard;
    function GetCaptionBounds: TRect;
    function GetCaptionStyle: TcxViewParams;
    function GetCard: TcxGridCard;
    function GetCategoryIndent: Integer;
    function GetDataAlignment: TAlignment;
    function GetDataBounds: TRect;
    function GetDataStyle: TcxViewParams;
    function GetDataValue: Variant;
    function GetHasIndent: Boolean;
    function GetHasSeparator: Boolean;
    function GetHeight: Integer;
    function GetIndentBounds: TRect;
    function GetIndentStyle: TcxViewParams;
    function GetSeparatorBounds: TRect;
    function GetSeparatorWidth: Integer;
    function GetShowCaption: Boolean;
    function GetShowData: Boolean;
    function GetVisibleCaption: string;
    function GetWidth: Integer;
    procedure SetHeight(AValue: Integer);
    procedure SetWidth(AValue: Integer);
  protected
    procedure AddToScales(AColumnScale, ARowScale: TcxExportScale);
  public
    Bounds: TRect;
    CaptionStyleIndex: Integer;
    CaptionWidth: Integer;
    DataStyleIndex: Integer;
    IndentStyleIndex: Integer;
    Row: TcxGridCardViewRow;
    constructor Create(AOwner: TcxExportCard);

    property CaptionBounds: TRect read GetCaptionBounds;
    property CaptionStyle: TcxViewParams read GetCaptionStyle;
    property Card: TcxGridCard read GetCard;
    property CategoryIndent: Integer read GetCategoryIndent;
    property DataAlignment: TAlignment read GetDataAlignment;
    property DataBounds: TRect read GetDataBounds;
    property DataStyle: TcxViewParams read GetDataStyle;
    property DataValue: Variant read GetDataValue;
    property HasIndent: Boolean read GetHasIndent;
    property HasSeparator: Boolean read GetHasSeparator;
    property Height: Integer read GetHeight write SetHeight;
    property IndentBounds: TRect read GetIndentBounds;
    property IndentStyle: TcxViewParams read GetIndentStyle;
    property Owner: TcxExportCard read FOwner;
    property SeparatorBounds: TRect read GetSeparatorBounds; 
    property SeparatorWidth: Integer read GetSeparatorWidth;
    property ShowCaption: Boolean read GetShowCaption;
    property ShowData: Boolean read GetShowData;
    property VisibleCaption: string read GetVisibleCaption;
    property Width: Integer read GetWidth write SetWidth;
  end;

  TcxExportCard = class
  protected
    FBounds: TRect; 
    FCard: TcxGridCard;
    FLayersList: TcxObjectList;
    FOwner: TcxGridCardViewExport;
    function GetBorderWidth: Integer;
    function GetHasSeparators: Boolean;
    function GetLayer(AIndex: Integer): TList;
    function GetLayerCount: Integer;
    function GetLayerSeparator(AIndex: Integer): TRect;
    function GetRow(ALayerIndex, ARowIndex: Integer): TcxExportCardRow;
    function GetRowCount(ALayerIndex: Integer): Integer;
    function GetSeparatorWidth: Integer;
    procedure SetBounds(const ABounds: TRect);
  protected
    function AddLayer: TList;
    function AddRow(ALayerIndex: Integer; ARow: TcxGridCardViewRow): TcxExportCardRow;
    procedure AddLayerSeparators;
    procedure AdjustLayersWidthToWidth;
    function AdjustRowsHeightInLayer(ALayer, ATop: Integer): Integer;
    procedure AdjustRowsWidthToWidth(ALayer: Integer);
    procedure CheckCategorySeparators(AHorizontalLayout: Boolean);
  public
    constructor Create(AOwner: TcxGridCardViewExport; ACard: TcxGridCard);
    destructor Destroy; override;
    procedure AddToScales(AColumnScale, ARowScale: TcxExportScale);
    procedure CalculateLayersCaptionWidth(AWidths: TcxExportIntList; AFistRowInLayerOnly: Boolean);
    function GetRowCaptionWidth(ALayerIndex, ARowIndex: Integer; AMaxWidth: Integer = 0): Integer;
    procedure SetLayersCaptionWidth(AWidths: TcxExportIntList; AFistRowInLayerOnly: Boolean);
    procedure SetRowCaptionWidth(ALayerIndex, ARowIndex, AWidth: Integer);

    property BorderWidth: Integer read GetBorderWidth;
    property Bounds: TRect read FBounds write SetBounds;
    property Card: TcxGridCard read FCard;
    property HasSeparators: Boolean read GetHasSeparators;
    property LayerCount: Integer read GetLayerCount;
    property Layers[AIndex: Integer]: TList read GetLayer;
    property LayerSeparators[Index: Integer]: TRect read GetLayerSeparator;
    property LayersList: TcxObjectList read FLayersList;
    property Owner: TcxGridCardViewExport read FOwner;
    property RowCount[ALayerIndex: Integer]: Integer read GetRowCount;
    property Rows[ALayerIndex, ARowIndex: Integer]: TcxExportCardRow read GetRow;
    property SeparatorWidth: Integer read GetSeparatorWidth;
  end;

  TcxExportCardLayoutBuilder = class
  private
    FExportCard: TcxExportCard;
    FOwner: TcxGridCardViewExport;
    FRowsList: TList;
  protected
    function GetLayerIndex(ARow: TcxGridCardViewRow): Integer; virtual;
    procedure SplitRowsToLayers; virtual; 
  public
    constructor Create(AOwner: TcxGridCardViewExport);
    destructor Destroy; override;
    procedure BuildLayout(ACard: TcxGridCard; AExportCard: TcxExportCard);
    
    property ExportCard: TcxExportCard read FExportCard;  
    property Owner: TcxGridCardViewExport read FOwner;
    property RowsList: TList read FRowsList;
  end;

  TcxGridCardViewExport = class(TcxGridCustomExport)
  private
    FCardBorderStyle: Integer;
    FCardSeparators: TcxExportScale;
    FCardSeparatorStyleIndex: Integer;

    FCategorySeparatorStyleIndex: Integer;
    FColumnCardCount: Integer;
    FKeepRowsSameHeight: Boolean;
    FLayerSeparatorStyleIndex: Integer;
    FLayoutBuilder: TcxExportCardLayoutBuilder;
    FRowCardCount: Integer;
    FExportCardsList: TcxObjectList;
    function GetCard(AIndex: Integer): TcxGridCard;
    function GetCardBorderWidth: Integer;
    function GetCardCount: Integer;
    function GetCardHeight: Integer;
    function GetCardIndent: Integer;
    function GetCardSeparator(AIndex: Integer): TRect;
    function GetCardSeparatorCount: Integer;
    function GetCardWidth: Integer;
    function GetCategoryIndent: Integer;
    function GetCategorySeparatorWidth: Integer;
    function GetExportCard(AIndex: Integer): TcxExportCard;
    function GetGridView: TcxGridCardView;
    function GetInterCardHorzSpace: Integer;
    function GetInterCardVertSpace: Integer;
    function GetIsHorizontalRows: Boolean;
    function GetIsSimpleLayout: Boolean;
    function GetLayerSeparatorWidth: Integer;
    function GetLayoutDirection: TcxGridCardViewLayoutDirection;
    function GetOptionsView: TcxGridCardViewOptionsView;
  protected
    procedure AddCardSeparator(APosition: Integer);
    function AddExportCard(AColumnPosition, ARowPosition: Integer; ACard: TcxGridCard): TcxExportCard;
    procedure AdjustRowCaptionWidth;
    procedure CalculateVisibleInfo;
    function CreateCardLayoutBuilder: TcxExportCardLayoutBuilder;
    procedure CreateExportCells; override;
    procedure ExportCardRow(ACard: TcxExportCard; ARow: TcxExportCardRow; const ACardLogicalBounds: TRect);
    procedure ExportCells; override;
    procedure Finalize; override;
    procedure RegisterStyles; override;
    procedure SetRowSameHeight; virtual;

    property ExportCardsList: TcxObjectList read FExportCardsList;
  public
    property CardBorderStyle: Integer read FCardBorderStyle;
    property CardBorderWidth: Integer read GetCardBorderWidth;
    property CardCount: Integer read GetCardCount;
    property CardHeight: Integer read GetCardHeight;
    property CardIndent: Integer read GetCardIndent;
    property Cards[Index: Integer]: TcxGridCard read GetCard;
    property CardSeparatorCount: Integer read GetCardSeparatorCount;
    property CardSeparators[Index: Integer]: TRect read GetCardSeparator;
    property CardSeparatorStyleIndex: Integer read FCardSeparatorStyleIndex;
    property CardWidth: Integer read GetCardWidth;
    property CategoryIndent: Integer read GetCategoryIndent;
    property CategorySeparatorStyleIndex: Integer read FCategorySeparatorStyleIndex;
    property CategorySeparatorWidth: Integer read GetCategorySeparatorWidth;
    property ColumnCardCount: Integer read FColumnCardCount write FColumnCardCount;
    property ExportCards[Index: Integer]: TcxExportCard read GetExportCard;
    property GridView: TcxGridCardView read GetGridView;
    property InterCardHorzSpace: Integer read GetInterCardHorzSpace;
    property InterCardVertSpace: Integer read GetInterCardVertSpace;
    property IsHorizontalRows: Boolean read GetIsHorizontalRows;
    property IsSimpleLayout: Boolean read GetIsSimpleLayout;
    property KeepRowsSameHeight: Boolean read FKeepRowsSameHeight;
    property LayerSeparatorStyleIndex: Integer read FLayerSeparatorStyleIndex;
    property LayerSeparatorWidth: Integer read GetLayerSeparatorWidth;
    property LayoutBuilder: TcxExportCardLayoutBuilder read FLayoutBuilder;
    property LayoutDirection: TcxGridCardViewLayoutDirection read GetLayoutDirection;
    property OptionsView: TcxGridCardViewOptionsView read GetOptionsView;
    property RowCardCount: Integer read FRowCardCount write FRowCardCount;
  end;

  { TcxGridChartViewExport }
  
  TcxGridChartViewExport = class(TcxGridCustomExport)
  private
    function GetGridView: TcxGridChartView;
  protected
    procedure CreateExportCache; override;
    procedure ExportAsGraphic; virtual;
    procedure ExportAsData; virtual;
  public
    property GridView: TcxGridChartView read GetGridView;
  end;

procedure ExportGridToHTML(const AFileName: string; AGrid: TcxGrid;
  AExpand: Boolean = True; ASaveAll: Boolean = True; const AFileExt: string = 'html');
procedure ExportGridToXML(const AFileName: string; AGrid: TcxGrid;
  AExpand: Boolean = True; ASaveAll: Boolean = True; const AFileExt: string = 'xml');
procedure ExportGridToExcel(const AFileName: string; AGrid: TcxGrid;
  AExpand: Boolean = True; ASaveAll: Boolean = True; AUseNativeFormat: Boolean = True;
  const AFileExt: string = 'xls');
procedure ExportGridToText(const AFileName: string; AGrid: TcxGrid;
  AExpand: Boolean = True; ASaveAll: Boolean = True; const ASeparator: string = '';
  const ABeginString: string = ''; const AEndString: string = '';
  const AFileExt: string = 'txt');

const
  ExportImagesAsGraphic: Boolean = True; 

implementation

uses
  cxXLSExport, cxHtmlXmlTxtExport, Math;

const
  Alignment2ExportAlignment: array[TAlignment] of TcxAlignText =
    (catLeft, catRight, catCenter);

  GridLines2Borders: array[TcxGridLines] of TcxBorders =
    (cxBordersAll, [], [bRight, bLeft], [bTop, bBottom]);

  BorderWidths: array[Boolean] of Integer = (0, 1);

  ButtonTexts: array[Boolean] of string = ('+', '-');

  CardRowDefaultWidth = 20;
  cxDefaultRowHeight  = 19;

type
  TcxCustomGridRecordAccess = class(TcxCustomGridRecord);

function cxCompareGroupSummaryItems(AItem1, AItem2: TcxExportGroupSummaryItem): Integer;
begin
  if AItem1.Column =  AItem2.Column then
    Result := AItem1.Index - AItem2.Index
  else
    if AItem1.Column = nil then
      Result := -1
    else
      if AItem2.Column = nil then
        Result := 1
      else
        Result := AItem1.Column.VisibleIndex - AItem2.Column.VisibleIndex;
end;

function GetExportClassByGridView(AGridView: TcxCustomGridView): TcxGridCustomExportClass;
begin
  if AGridView is TcxGridBandedTableView then
    Result := TcxGridBandedTableViewExport
  else
    if AGridView is TcxGridTableView then
      Result := TcxGridTableViewExport
    else
      if AGridView is TcxGridCardView then
        Result := TcxGridCardViewExport
      else
        if AGridView is TcxGridChartView then
          Result := TcxGridChartViewExport
        else
          raise EcxGridExport.Create(cxGetResourceString(@scxNotExistGridView));
end;

procedure CalculateCardRowWidths(var AWidths: array of Integer; AAvailableWidth: Integer);
var
  AAutoWidths: TcxAutoWidthObject;
  AAllFixed: Boolean;
  I: Integer;
begin
  AAutoWidths := TcxAutoWidthObject.Create(Length(AWidths));
  try
    AAllFixed := True;
    for I := 0 to High(AWidths) do
      with AAutoWidths.AddItem do
      begin
        Width := AWidths[I];
        Fixed := Width <> 0;
        AAllFixed := AAllFixed and Fixed;
        if Width = 0 then Width := CardRowDefaultWidth;
      end;
    if AAllFixed or (AAutoWidths.Width > AAvailableWidth) then
      for I := 0 to AAutoWidths.Count - 1 do
        AAutoWidths[I].Fixed := False;
    AAutoWidths.AvailableWidth := AAvailableWidth;
    AAutoWidths.Calculate;
    for I := 0 to High(AWidths) do
      AWidths[I] := AAutoWidths[I].AutoWidth;
  finally
    AAutoWidths.Free;
  end;
end;

procedure ExportGridToFile(AFileName: string; AExportType: Integer;
  AGrid: TcxGrid; AExpand, ASaveAll, AUseNativeFormat: Boolean;
  const ASeparator, ABeginString, AEndString: string; const AFileExt: string);
var
  AView: TcxCustomGridView;
  AGridExport: TcxGridCustomExport;
begin
  if AGrid <> nil then
  begin
    if AFileExt <> '' then
      AFileName := ChangeFileExt(AFileName, '.' + AFileExt);
    AView := AGrid.ActiveLevel.GridView;
    AGridExport := GetExportClassByGridView(AGrid.ActiveLevel.GridView).Create(AFileName, AExportType, AView, AGrid, nil);
    AGridExport.SaveAll := ASaveAll;
    AGridExport.Expand := AExpand;
    AGridExport.UseNativeFormat := AUseNativeFormat;
    AGridExport.AddSeparators([ASeparator, ABeginString, AEndString]);
    AGrid.BeginUpdate;
    try
      try
        AGridExport.DoExport;
      finally
        AGridExport.Free;
      end;
    finally
      AGrid.EndUpdate;
    end;
  end;
end;

// ***

{ TcxGridCustomExport }

constructor TcxGridCustomExport.Create(AFileName: string;  AExportType: Integer;
    AGridView: TcxCustomGridView; AGrid: TcxCustomGrid; AViewInfo: TcxCustomGridViewInfo);
begin
  try
  {$IFDEF DELPHI5}
    FProvider := TcxExport.Provider(AExportType, AFileName) as IcxExportProvider;
    FInternalProviderSupported := Supports(FProvider,
      IcxCellInternalCache, FInternalProvider);
  {$ELSE}
    TcxExport.Provider(AExportType, AFileName).GetInterface(IcxExportProvider, FProvider);
    FInternalProviderSupported := (FExport.QueryInterface(IcxCellInternalCache, FInternalProvider) = S_OK);
  {$ENDIF}
  except
    on EStreamError do
      raise EcxGridExport.Create(cxGetResourceString(@scxCantCreateExportOutputFile));
  end;
  FDefaultRowHeight := cxDefaultRowHeight;
  FGridView := AGridView;
  FGrid := AGrid;
  FRecordsList := TList.Create;
  FViewInfo := AViewInfo;
  FFileName := AFileName;
  FExportType := AExportType;
  FColumns := TcxExportScale.Create;
  FRows := TcxExportScale.Create;
end;

constructor TcxGridCustomExport.CreateFrom(AMasterExport: TcxGridCustomExport;
  AGridView: TcxCustomGridView; AViewInfo: TcxCustomGridViewInfo);
begin
  Create(AMasterExport.FileName, AMasterExport.ExportType,
    AGridView, AMasterExport.Grid, AViewInfo);
  Expand := AMasterExport.Expand;
  SaveAll := AMasterExport.SaveAll;
end;

destructor TcxGridCustomExport.Destroy;
begin
  FInternalProvider := nil;
  FProvider := nil;
  FreeAndNil(FRecordsList);
  FreeAndNil(FColumns);
  FreeAndNil(FRows);
  inherited Destroy;
end;

procedure TcxGridCustomExport.AddSeparators(const ASeparators: array of string);
var
  I: Integer;
  AExportWithSeparators: IcxExportWithSeparators;
begin
{$IFDEF DELPHI5}
  if Supports(Provider, IcxExportWithSeparators, AExportWithSeparators) then
{$ELSE}
  if (FExport.QueryInterface(IcxExportWithSeparators, AExportWithSeparators) = S_OK) then
{$ENDIF}
  begin
    for I := 0 to High(ASeparators) do
      AExportWithSeparators.AddSeparator(ASeparators[I]);
  end;
end;

procedure TcxGridCustomExport.DoExport;
begin                  
  CreateExportCache;
  BeforeCommit;             
  Provider.Commit;
end;

procedure TcxGridCustomExport.BeforeCommit;
begin
end;

function TcxGridCustomExport.CalculateViewViewInfo(AGridView: TcxCustomGridView;
  ABounds: TRect): TcxCustomGridViewInfo;
begin
  Result := nil;
  if not (AGridView is TcxCustomGridTableView) then Exit;
  Result := AGridView.CreateViewInfo;
  with Result as TcxCustomGridTableViewInfo do
  begin
    FirstRecordIndex := 0;
    MainCalculate(ABounds);
  end;
end;                                           

function TcxGridCustomExport.CheckNativeValue(AProperties: TcxCustomEditProperties;
  AItem: TcxCustomGridTableItem; const AValue: Variant): Variant;
begin
  try
    if (IsCurrencyItem(AItem) and IsCurrencyProperties(AProperties)) or
      (AProperties is TcxCurrencyEditProperties) then
      VarCast(Result, AValue, varCurrency)
    else
      if (VarType(AValue) = varCurrency) and not IsCurrencyItem(AItem) and
        not (AProperties is TcxCurrencyEditProperties) then
        VarCast(Result, AValue, varDouble)
      else
        Result := AValue;
  except
    on EVariantError do
      Result := AValue
    else
      raise;
  end;
end;

procedure TcxGridCustomExport.CreateExportCache;
begin
  Initialize;
  try
    ExtractRowsForExport;
    RegisterStyles;
    CreateExportCells;
    Columns.Arrange;
    Rows.Arrange;
    if not IsEmpty then
    begin
      Provider.SetRange(Columns.VisibleCount, Rows.VisibleCount, False);
      ExportCells;
    end;
  finally
    Finalize;
  end;
end;

procedure TcxGridCustomExport.CreateExportCells;
begin
end;

procedure TcxGridCustomExport.ExpandRecords(AFullExpand: Boolean);
var
  I: Integer;
  ARecord: TcxCustomGridRecord;
  AViewData: TcxCustomGridTableViewData;
begin
  if not GridView.InheritsFrom(TcxCustomGridTableView) then Exit;
  AViewData := (GridView as TcxCustomGridTableView).ViewData;
  if AFullExpand then
    AViewData.Expand(True)
  else
  begin
    I := 0;
    while I < AViewData.RecordCount - 1 do
    begin
      ARecord := AViewData.Records[I];
      if ARecord.Selected and ARecord.Expandable and not ARecord.Expanded then
        ARecord.Expanded := True
      else
        Inc(I);
    end;
  end;
end;

procedure TcxGridCustomExport.ExportCells;
var
  I: Integer;
begin
  for I := 0 to Columns.VisibleCount - 1 do
    Provider.SetColumnWidth(I, Columns.Delta[I]);
  for I := 0 to Rows.VisibleCount - 1 do
  begin
    if Rows.Delta[I] <> DefaultRowHeight then
      Provider.SetRowHeight(I, Rows.Delta[I]);
  end; 
  FillArea(Rect(0, 0, Columns.Count - 1, Rows.Count - 1),  DefaultStyleIndex);
end;

procedure TcxGridCustomExport.ExtractRowsForExport;
var
  I: Integer;
  ARecord: TcxCustomGridRecord; 
  AViewData: TcxCustomGridTableViewData;
begin
  if not (GridView.ViewData is TcxCustomGridTableViewData) then Exit;
  AViewData := GridView.ViewData as TcxCustomGridTableViewData;
  SaveAll := SaveAll or not HasSelectedRecords(GridView);
  Grid.BeginUpdate;
  try
    I := 0;
    while I < AViewData.RecordCount do
    begin
      ARecord := AViewData.Records[I];
      Inc(I);
      if not SaveAll and not HasSelectedChildren(ARecord) then Continue;
      if Expand then
        ARecord.Expanded := True;
      RecordsList.Add(Pointer(I - 1));
    end;
    for I := 0 to RecordCount - 1 do
      RecordsList[I] := AViewData.Records[Integer(RecordsList[I])];
  finally
    Grid.EndUpdate;
  end;
end;

procedure TcxGridCustomExport.FillArea(const ABounds: TRect; AStyleIndex: Integer;
  ABorderColor: TColor = clDefault; ABorders: TcxBorders = cxBordersAll);
var
  AStyle: TcxCacheCellStyle;
  I, J, AActualStyleIndex: Integer;

  procedure SetBorderStyle(ASide: TcxBorder);
  begin
    AStyle.Borders[Integer(ASide)].IsDefault := False;
    AStyle.Borders[Integer(ASide)].Width := 1;
    AStyle.Borders[Integer(ASide)].Color := ColorToRgb(ABorderColor);
  end;

begin
  for I := ABounds.Top to ABounds.Bottom - 1 do
    for J := ABounds.Left to ABounds.Right - 1 do
    begin
      AActualStyleIndex := AStyleIndex;
      if (ABorderColor <> clDefault) and (ABorders <> []) then
      begin
        AStyle := Provider.GetStyle(AStyleIndex)^;
        if J = ABounds.Left then
          SetBorderStyle(bLeft);
        if I = ABounds.Top then
          SetBorderStyle(bTop);
        if J = ABounds.Right - 1 then
          SetBorderStyle(bRight);
        if I = ABounds.Bottom - 1 then
          SetBorderStyle(bBottom);
        AActualStyleIndex := Provider.RegisterStyle(AStyle);
      end;
      Provider.SetCellStyle(J, I, AActualStyleIndex);
    end;
end;

procedure TcxGridCustomExport.FillRealArea(const ABounds: TRect; AStyleIndex: Integer;
  ABorderColor: TColor = clDefault; ABorders: TcxBorders = cxBordersAll);
var
  ALogicalBounds: TRect;
begin
  RealBoundsToLogicalBounds(ABounds, ALogicalBounds);
  FillArea(ALogicalBounds, AStyleIndex, ABorderColor, ABorders);
end;

procedure TcxGridCustomExport.Finalize;
begin
  if FSaveGridModeFlag and (DataController is TcxDBDataController) then
  begin
    TcxDBDataController(DataController).DataModeController.GridMode := FSaveGridModeFlag;
    DataController.RestoreDataSetPos;
  end;
end;

function TcxGridCustomExport.GetContentParams(ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AParams: TcxViewParams;
  ABorders: TcxBorders = []; ABorderColor: TColor = clDefault): TcxCacheCellStyle;
begin
  AItem.Styles.GetContentParams(ARecord, AParams);
  ViewParamsToExportStyle(AParams, Result, AItem.GetProperties.Alignment.Horz,
    ABorders, ABorderColor);
end;

function TcxGridCustomExport.GetViewItemValue(
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem): Variant;
var
  AProperties: TcxCustomEditProperties;
begin
  Result := GetViewItemValueEx(ARecord, AItem, AProperties);
end;

function TcxGridCustomExport.GetViewItemValueEx(ARecord: TcxCustomGridRecord;
   AItem: TcxCustomGridTableItem; out AProperties: TcxCustomEditProperties): Variant;
var
  S: string;
begin
  AProperties := AItem.GetProperties(ARecord);
  if IsNativeFormatProperties(AProperties, AItem) then
    Result := CheckNativeValue(AProperties, AItem, ARecord.Values[AItem.Index])
  else
  begin
    if AProperties.GetEditValueSource(False) = evsValue then
      S := AProperties.GetDisplayText(ARecord.Values[AItem.Index], True)
    else
      S := ARecord.DisplayTexts[AItem.Index];
    TcxCustomGridTableItemAccess.DoGetDisplayText(AItem, ARecord, S);
    Result := S;
  end;
end;

function TcxGridCustomExport.HasSelectedChildren(ARecord: TcxCustomGridRecord): Boolean;
begin
  Result := ARecord.Selected or ARecord.Expanded and (ARecord is TcxGridMasterDataRow) and
    (TcxGridMasterDataRow(ARecord).ActiveDetailGridView <> nil) and
    HasSelectedRecords(TcxGridMasterDataRow(ARecord).ActiveDetailGridView)
end;

function TcxGridCustomExport.HasSelectedRecords(AView: TcxCustomGridView): Boolean;
var
  I: Integer;
begin
  Result := False;
  if AView is TcxCustomGridTableView then
  begin
    Result := TcxCustomGridTableView(AView).Controller.SelectedRecordCount > 0;
    if Result then Exit;
    for I := 0 to TcxCustomGridTableView(AView).ViewData.RecordCount - 1 do
      if HasSelectedChildren(TcxCustomGridTableView(AView).ViewData.Records[I]) then
      begin
        Result := True;
        Break;
      end;
  end;
end;

procedure TcxGridCustomExport.Initialize;
begin
  FSaveGridModeFlag := DataController.IsGridMode;
  if FSaveGridModeFlag and (DataController is TcxDBDataController) then
  begin
    DataController.SaveDataSetPos;
    TcxDBDataController(DataController).DataModeController.GridMode := False;
  end;
  Columns.Add(0);
  Rows.Add(0);
end;

function TcxGridCustomExport.IsCurrencyItem(AItem: TcxCustomGridTableItem): Boolean;
var
  AField: TField;
begin
  Result := AItem.DataBinding.ValueTypeClass = TcxCurrencyValueType;
  if GridView.DataController is TcxGridDBDataController then
  begin
    AField := TcxGridDBDataController(GridView.DataController).GetItemField(AItem.Index);
    if AField is TFloatField then
      Result := TFloatField(AField).Currency
    else
      if AField is TBCDField then
        Result := TBCDField(AField).Currency
  {$IFDEF DELPHI5}
      else
        if AField is TAggregateField then
          Result := TAggregateField(AField).Currency
  {$ENDIF}
  {$IFDEF DELPHI6}
      else
        if AField is TFMTBCDField then
          Result := TFMTBCDField(AField).Currency
  {$ENDIF}
  end;
end;

function TcxGridCustomExport.IsCurrencyProperties(
  AProperties: TcxCustomEditProperties): Boolean;
begin
  Result := ((AProperties is TcxMaskEditProperties) or
    (AProperties is TcxCalcEditProperties) or
    (AProperties is TcxCurrencyEditProperties)) and UseNativeFormat;
end;

function TcxGridCustomExport.IsEmpty: Boolean;
begin
  Result := (Columns.VisibleCount = 0) or (Rows.VisibleCount = 0);
end;

function TcxGridCustomExport.IsNativeFormatProperties(
  AProperties: TcxCustomEditProperties; AItem: TcxCustomGridTableItem): Boolean;
begin
  Result := (AProperties is TcxDateEditProperties) or (AProperties is TcxSpinEditProperties)
     or (AProperties is TcxTimeEditProperties) or IsCurrencyProperties(AProperties);
  Result := Result and UseNativeFormat;
end;

procedure TcxGridCustomExport.RealBoundsToLogicalBounds(
  const ABounds: TRect; out ALogicalBounds: TRect);
begin
  with ALogicalBounds do
  begin
    Columns.GetPosition(ABounds.Left, ABounds.Right, Left, Right);
    Rows.GetPosition(ABounds.Top, ABounds.Bottom, Top, Bottom);
  end;
end;

procedure TcxGridCustomExport.RealBoundsToLogicalBoundsEx(
  const ABounds, ASearchArea: TRect; out ALogicalBounds: TRect);
begin
  with ALogicalBounds do
  begin
    Columns.GetPositionEx(ABounds.Left, ABounds.Right,
      ASearchArea.Left, ASearchArea.Right, Left, Right);
    Rows.GetPositionEx(ABounds.Top, ABounds.Bottom,
      ASearchArea.Top, ASearchArea.Bottom, Top, Bottom);
  end;
end;

function TcxGridCustomExport.RegisterContentParams(ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AParams: TcxViewParams): Integer;
begin
  Result := Provider.RegisterStyle(GetContentParams(ARecord, AItem, AParams));
end;

function TcxGridCustomExport.RegisterSolidStyle(
  AStyleIndex: Integer; AData: TObject = nil): Integer;
var
  AParams: TcxViewParams;
begin
  AParams.Color := clNone;
  if GridView is TcxCustomGridTableView then
    TcxCustomGridTableView(GridView).Styles.GetViewParams(AStyleIndex, AData, nil, AParams);
  Result := RegisterSolidStyleEx(AParams.Color);
end;

procedure TcxGridCustomExport.RegisterStyles;
var
  AViewParams: TcxViewParams;
begin
  if GridView is TcxCustomGridTableView then
    with TcxCustomGridTableView(GridView).Styles do
    begin
      GetViewParams(vsBackground, nil, Background, AViewParams);
      ViewParamsToExportStyle(AViewParams, FDefaultStyle);
    end;
  Provider.SetDefaultStyle(DefaultStyle);
  DefaultStyleIndex := Provider.RegisterStyle(DefaultStyle);
end;

function TcxGridCustomExport.RegisterSolidStyleEx(AColor: TColor): Integer;
var
  AStyle: TcxCacheCellStyle;
begin
  AStyle := DefaultStyle;
  AStyle.BrushBkColor := ColorToRgb(AColor);
  Result := Provider.RegisterStyle(AStyle);
end;

function TcxGridCustomExport.RegisterViewParams(
  const AViewParams: TcxViewParams; const AAlignment: TAlignment = taLeftJustify): Integer;
var
  AStyle: TcxCacheCellStyle;
begin
  ViewParamsToExportStyle(AViewParams, AStyle, AAlignment);
  Result := Provider.RegisterStyle(AStyle)
end;

function TcxGridCustomExport.SetCellAsGraphic(AColumn, ARow: Integer;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem): Boolean;
var
  AGraphic: TGraphic;
  APicture: TPicture;
begin
  Result := (AItem.GetProperties is TcxImageProperties) and ExportImagesAsGraphic;
  if not Result then Exit;  
  APicture := TPicture.Create;
  try
    LoadPicture(APicture, TcxImageProperties(AItem.GetProperties).GetGraphicClass(
      AItem, ARecord.Index), ARecord.Values[AItem.Index]);
    AGraphic := APicture.Graphic;
    if AGraphic <> nil then
      Provider.SetCellDataGraphic(AColumn, ARow, AGraphic);
  finally
    APicture.Free;
  end
end;

procedure TcxGridCustomExport.SetCellValueAndStyle(
  AColumn, ARow: Integer; const AValue: Variant; const AStyle: TcxCacheCellStyle);
begin
  Provider.SetCellValue(AColumn, ARow, AValue);
  Provider.SetCellStyle(AColumn, ARow, AStyle);
end;

procedure TcxGridCustomExport.SetRealCellStyle(
  const ARealBounds, ASearchArea: TRect; AStyleIndex: Integer);
begin
  SetRealCellStyleAndValue(ARealBounds, ASearchArea, AStyleIndex, Null);
end;

procedure TcxGridCustomExport.SetRealCellStyleAndValue(
  const ARealBounds, ASearchArea: TRect; AStyleIndex: Integer; const AValue: Variant);
var
  R: TRect;
begin
  RealBoundsToLogicalBoundsEx(ARealBounds, ASearchArea, R);
  if not VarIsNull(AValue) then
    Provider.SetCellValue(R.Left, R.Top, AValue);
  Provider.SetCellStyleEx(R.Left, R.Top, R.Bottom - R.Top, R.Right - R.Left, AStyleIndex);
end;

procedure TcxGridCustomExport.SetRealCellStyleAndValueEx(
  const ARealBounds, ASearchArea: TRect; AStyleIndex: Integer;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem);
var
  R: TRect;
begin
  RealBoundsToLogicalBoundsEx(ARealBounds, ASearchArea, R);
  if AItem <> nil then
  begin
    if not Provider.SupportGraphic or not SetCellAsGraphic(R.Left, R.Top, ARecord, AItem) then
      Provider.SetCellValue(R.Left, R.Top, GetViewItemValue(ARecord, AItem));
  end;
  Provider.SetCellStyleEx(R.Left, R.Top, R.Bottom - R.Top, R.Right - R.Left, AStyleIndex);
end;

function TcxGridCustomExport.TextHeight(AFont: TFont): Integer;
begin
  Result := cxTextHeight(AFont) + cxTextOffset * 2;
end;

function TcxGridCustomExport.TextHeightEx(
  const AViewParams: TcxViewParams): Integer;
begin
  Result := TextHeight(AViewParams.Font);
end;

function TcxGridCustomExport.TextWidth(
  AFont: TFont; const AText: string): Integer;
begin
  Result := cxTextWidth(AFont, AText) + cxTextOffset * 2; 
end;

function TcxGridCustomExport.TextWidthEx(
  const AViewParams: TcxViewParams; const AText: string): Integer;
begin
  Result := TextWidth(AViewParams.Font, AText);
end;

procedure TcxGridCustomExport.ViewParamsToExportStyle(
  const AViewParams: TcxViewParams; var AExportStyle: TcxCacheCellStyle;
  const AAlignment: TAlignment = taLeftJustify;
  ABorders: TcxBorders = []; ABorderColor: TColor = clDefault);
var
  I: Integer;
begin
  AExportStyle := DefaultCellStyle;
  with AExportStyle do
  begin
    BrushBkColor := cxColorToRGB(AViewParams.Color);
    FontColor := cxColorToRGB(AViewParams.TextColor);
    FillChar(FontName, SizeOf(FontName), 0);
    dxStringToBytes(AViewParams.Font.Name, FontName);
    FontStyle := TcxFontStyles(AViewParams.Font.Style);
    FontSize := AViewParams.Font.Size;
    FontCharset := Integer(AViewParams.Font.Charset);
    AlignText := Alignment2ExportAlignment[AAlignment];
    for I := 0 to 3 do
    begin
      Borders[I].IsDefault := (ABorderColor = clDefault) or not (TcxBorder(I) in ABorders);
      Borders[I].Width := BorderWidths[not Borders[I].IsDefault];
      if not Borders[I].IsDefault then
        Borders[I].Color := ColorToRgb(ABorderColor);
    end;
  end;
end;

function TcxGridCustomExport.GetDataController: TcxCustomDataController;
begin
  Result := GridView.DataController;
end;

function TcxGridCustomExport.GetExpandButtonSize: Integer;
begin
  Result := ViewInfo.LookAndFeelPainter.ExpandButtonSize;
end;

function TcxGridCustomExport.GetRecord(
  ARecordIndex: Integer): TcxCustomGridRecord;
begin
  Result := TcxCustomGridRecord(RecordsList[ARecordIndex]);
end;

function TcxGridCustomExport.GetRecordCount: Integer;
begin
  Result := RecordsList.Count;
end;

function TcxGridCustomExport.GetViewInfo: TcxCustomGridViewInfo;
begin
  if FViewInfo = nil then
    FViewInfo := GridView.ViewInfo;
  Result := FViewInfo;
end;

{ TcxExportVisualItem }

function TcxExportVisualItem.GetBoundsRelativeTo(ATop, ALeft: Integer): TRect;
begin
  Result := Bounds;
  OffsetRect(Result, 0, ATop);
  Result.Left := Max(Result.Left, ALeft);
  Result.Right := Max(Result.Right, ALeft);
end;

function TcxExportVisualItem.IsColumn: Boolean;
begin
  Result := Data is TcxGridColumn;
end;

{ TcxExportGroupSummaryItem }

procedure TcxExportGroupSummaryItem.InitWidth;
begin
  Bounds.Right := Min(Bounds.Right, Bounds.Left +
    cxTextWidth(ViewParams.Font, Text) + cxTextOffset * 3);
end;

{ TcxGridTableViewExport }

procedure TcxGridTableViewExport.AddDataRow(
  var ATop, ALeft: Integer; ARow: TcxGridDataRow);
begin
  ALeft := AddIndents(ATop, RecordHeight + GetPreviewHeight(ARow), ARow, ARow.Expandable);
  if (PreviewPlace = ppTop) and HasPreview[ARow] then
    AddRowPreview(ATop, ALeft, ARow);
  CreateRecordFromPattern(ATop, ALeft, ARow);
  Inc(ATop, RecordHeight);
  if (PreviewPlace = ppBottom) and HasPreview[ARow] then
    AddRowPreview(ATop, ALeft, ARow);
end;

procedure TcxGridTableViewExport.AddFooterCells(var ATop, ALeft: Integer;
  ARow: TcxCustomGridRow; ALevel, ADataLevel: Integer; AItems: TcxDataSummaryItems;
  AValues: PVariant; AIsFooter: Boolean);
var
  R: TRect;
  AValue: Variant;
  AColumn: TcxGridColumn;
  AParams: TcxViewParams;
  AItem: TcxDataSummaryItem;
  I, J, ACellCount, ALineIndex, ARowCount: Integer;
  AFooterCell: TcxExportVisualItem;
begin
  if CanShowMultiSummaries(AIsFooter) then
    ARowCount := GetFooterLineCount(AItems)
  else
    ARowCount := RecordRowCount;
  R.Bottom := ATop + ARowCount * (DefaultRowHeight + cxGridFooterCellIndent);
  if ALevel <> 0 then
    ALeft := AddIndents(ATop, R.Bottom - ATop, ARow, False, ALevel - 1);
  R := Rect(ALeft, ATop, RecordWidth, R.Bottom);
  Styles.GetFooterParams(TcxCustomGridRow(ARow), nil, ADataLevel, nil, AParams);
  AddVisualItemEx(R, '', AParams, taLeftJustify, [], clDefault, True);
  ATop := R.Bottom;
  ACellCount := GetFooterCellCount(AItems);
  for I := 0 to PatternCount - 1 do
  begin
    if ACellCount = 0 then Break;
    ALineIndex := 0;
    if Patterns[I].IsColumn then
    begin
      AColumn := TcxGridColumn(Patterns[I].Data);
      for J := 0 to AItems.Count - 1 do
      begin
        AItem := AItems[J];
        if (AItem.ItemLink <> AColumn) or (AItem.Position <> spFooter) then Continue;
        GridView.Styles.GetFooterCellParams(ARow, AColumn, ADataLevel, AItem, AParams);
        if AIsFooter then
          AValue := DataController.Summary.FooterSummaryValues[J]
        else        
          AValue := AValues^[J];
        AFooterCell := AddVisualItemEx(GetFooterItemBounds(I, ALineIndex, R, AIsFooter), AItem.FormatValue(
          AValue, True), AParams, AColumn.FooterAlignmentHorz, cxBordersAll, FooterCellBorderColor);
        if UseNativeFormat and VarIsNumeric(AValue) then
        begin
          AFooterCell.Data2 := AItem;
          AFooterCell.Value := AValue;
          if UseNativeFormat and (AColumn <> nil) and (AItem.Format = '')  then
            AFooterCell.Value := CheckNativeValue(AColumn.GetProperties, AColumn, AValue);
        end;
        Dec(ACellCount);
        Inc(ALineIndex);
        if not CanShowMultiSummaries(AIsFooter) then Break;
      end;
    end;
  end;
end;

procedure TcxGridTableViewExport.AddGroupRow(
  var ATop, ALeft: Integer; ARow: TcxGridGroupRow);
var
  R: TRect;
  S: string;
  AValues: PVariant;
  I, AHeight: Integer;
  AViewParams: TcxViewParams;
  AItems: TcxDataSummaryItems;
  AItem: TcxExportGroupSummaryItem;
  AExportItem: TcxExportVisualItem;
begin
  AHeight := Viewinfo.RecordsViewInfo.GroupRowHeight;
  R := Rect(0, ATop, RecordWidth, ATop + AHeight);
  R.Left := AddIndents(ATop, AHeight, ARow, True);
  Styles.GetGroupParams(ARow, ARow.Level, AViewParams);
  AddVisualItemEx(R, '', AViewParams, taLeftJustify, [], clDefault, True);
  if IsSummaryUnderColumns and ARow.GetGroupSummaryInfo(AItems, AValues) then
  begin
    GroupSummaryItemsList.Clear;
    GroupSummaryItemsList.Capacity := 1024;
    for I := 0 to AItems.Count - 1 do
      ProcessGroupSummaryItem(ARow, AValues, I, R, AViewParams);
    GroupSummaryItemsList.Sort(@cxCompareGroupSummaryItems);
    ProcessGroupSummaryItems(ARow, R);
    for I := 0 to GroupSummaryItemCount - 1 do
    begin
      AItem := GroupSummaryItems[I];
      AExportItem := AddVisualItemEx(AItem.Bounds, AItem.Text, AItem.ViewParams,
        AItem.Alignment, GridLines - [bLeft, bRight], GridLineColor, False);
      if UseNativeFormat and not VarIsNull(AItem.Value) then
      begin
        AExportItem.Data2 := AItem.SummaryItem;
        AExportItem.Value := AItem.Value;
      end;
    end;
  end
  else
  begin
    S := ARow.DisplayText;
    TcxCustomGridTableItemAccess.DoGetDisplayText(ARow.GroupedColumn, ARow, S);
    AddVisualItemEx(R, S, AViewParams,
      taLeftJustify, GridLines, GridLineColor, False);
  end;
  Inc(ATop, AHeight);
end;

function TcxGridTableViewExport.AddIndents(ATop, ARowHeight: Integer;
  ARow: TcxCustomGridRecord; AHasButton: Boolean; ALevel: Integer = -1): Integer;
var
  R: TRect;
  I: Integer;
  AText: string;
  AStyle: TcxCacheCellStyle;
  AGridLines: TcxBorders; 
  AViewParams: TcxViewParams;
begin
  if ALevel = -1 then
    ALevel := ARow.Level - 1 + Byte(AHasButton);
  while (ALevel >= 0) and (ALevel < ARow.Level) do
    ARow := TcxGridDataRow(ARow).ParentRecord;
  R := Rect(ALevel * ViewInfo.LevelIndent, ATop,
    (ALevel + 1) * ViewInfo.LevelIndent, ATop + ARowHeight);
  AGridLines := GridLines;
  if not ARow.IsLast or AHasButton and ARow.Expanded then
    AGridLines := GridLines - [bBottom];
  for I := ALevel downto 0 do
  begin
    AText := '';
    if AHasButton and (I = ALevel) then
    begin
      AText := ButtonTexts[ARow.Expanded];
      AStyle := GetExpandButtonParams(AGridLines);
    end
    else
    begin
      if ARow is TcxGridGroupRow then
        Styles.GetGroupParams(ARow, I, AViewParams)
      else
        Styles.GetContentParams(ARow, nil, AViewParams);
      ViewParamsToExportStyle(AViewParams, AStyle, taLeftJustify, AGridLines - [bTop], GridLineColor);
    end;
    ARow := ARow.ParentRecord;
    AddVisualItemEx(R, AText, Provider.RegisterStyle(AStyle), False);
    OffsetRect(R, -ViewInfo.LevelIndent, 0);
  end;
  Result := (ALevel + 1) * ViewInfo.LevelIndent;
end;

procedure TcxGridTableViewExport.AddMasterDataRow(
  var ATop, ALeft: Integer; ARow: TcxGridMasterDataRow);
var
  ABounds: TRect;
begin
  AddDataRow(ATop, ALeft, ARow);
  if not ARow.Expanded or not InternalProviderSupported then Exit;
  ALeft := AddIndents(ATop, DefaultRowHeight, ARow, False, ARow.Level);
  ABounds := Rect(ALeft, ATop, RecordWidth, ATop + DefaultRowHeight);
  with AddVisualDataItem(ABounds, DefaultStyleIndex, ARow, nil) do
    Hidden := True;
  ATop := ABounds.Bottom;
end;

procedure TcxGridTableViewExport.AddRowFooter(
  var ATop, ALeft: Integer; ADataLevel, ALevel: Integer; ARow: TcxCustomGridRecord);
var
  AValues: PVariant;
  AItems: TcxDataSummaryItems;
begin
  ALeft := 0;
  while ARow.Level > ADataLevel do
    ARow := ARow.ParentRecord;
  if DataController.Summary.GetGroupSummaryInfo(ARow.Index, AItems, AValues) then
  begin
    AddFooterCells(ATop, ALeft, TcxCustomGridRow(ARow),
      ALevel, ADataLevel, AItems, AValues, False);
  end; 
end;

procedure TcxGridTableViewExport.AddRowFooters(
  var ATop, ALeft: Integer; ARow: TcxCustomGridRecord);
var
  ALevel, ARealLevel: Integer;
begin
  for ALevel := 0 to ARow.Level do
  begin
    ARealLevel := ALevel;
    if HasFooter(ARow, ARealLevel) then
      AddRowFooter(ATop, ALeft, ARealLevel, ARow.Level - ALevel, ARow);
  end;
end;

procedure TcxGridTableViewExport.AddRowPreview(
  var ATop, ALeft: Integer; ARow: TcxCustomGridRecord);
var
  R: TRect;
  AColumn: TcxGridColumn;
  AParams: TcxViewParams;
begin
  AColumn := GridView.Preview.Column;
  AColumn.Styles.GetContentParams(ARow, AParams);
  R := Rect(ALeft, ATop, RecordWidth, ATop + GetPreviewHeight(ARow));
  AddVisualItemEx(R, VarToStr(GetViewItemValue(ARow, AColumn)), AParams,
    AColumn.GetProperties.Alignment.Horz, GridLines, GridLineColor);
  ATop := R.Bottom;
end;

function TcxGridTableViewExport.AddVisualItem(
  AItemClass: TcxExportVisualItemClass; const ABounds: TRect): TcxExportVisualItem;
begin
  Result := AItemClass.Create();
  Result.Style := -1;
  Result.Bounds := ABounds;
  with ABounds do
  begin
    Columns.AddPairs(Left, Right);
    Rows.AddPairs(Top, Bottom);
  end;
  with VisualItemsList do 
    if Capacity - Count < 2 then Capacity := Count * 2;
  VisualItemsList.Add(Result);
end;

function TcxGridTableViewExport.AddVisualDataItem(
  const AItemBounds: TRect; AStyle: Integer; 
  ARecord: TcxCustomGridRecord; AColumn: TcxGridColumn): TcxExportVisualItem;
begin
  Result := AddVisualItem(TcxExportVisualItem, AItemBounds);
  Result.Style := AStyle;
  Result.Data := ARecord;
  Result.Data2 := AColumn;
end;

function TcxGridTableViewExport.AddVisualItemEx(
  const AItemBounds: TRect; const ADisplayText: string; const AViewParams: TcxViewParams;
  AAlignment: TAlignment; ABorders: TcxBorders; ABorderColor: TColor = clDefault;
  AIsBackground: Boolean = False): TcxExportVisualItem;
var
  ASide: TcxBorder;
  AStyle: TcxCacheCellStyle;
begin
  ViewParamsToExportStyle(AViewParams, AStyle, AAlignment);
  if ABorderColor <> clDefault then
  begin
    ABorderColor := ColorToRgb(ABorderColor);
    for ASide := bLeft to bBottom do
      if ASide in ABorders then
      begin
        AStyle.Borders[Integer(ASide)].IsDefault := False;
        AStyle.Borders[Integer(ASide)].Color := ABorderColor;
        AStyle.Borders[Integer(ASide)].Width := 1;
      end;
  end;
  Result := AddVisualItemEx(AItemBounds, ADisplayText,
    Provider.RegisterStyle(AStyle), AIsBackground);
end;

function TcxGridTableViewExport.AddVisualItemEx(
  const AItemBounds: TRect; const ADisplayText: string;
  AStyle: Integer; AIsBackground: Boolean = False): TcxExportVisualItem;
begin
  Result := AddVisualItem(TcxExportVisualItem, AItemBounds);
  Result.Bounds := AItemBounds;
  Result.IsBackground := AIsBackground;
  Result.DisplayText := ADisplayText;
  Result.Style := AStyle;
end;

function TcxGridTableViewExport.AddPattern(const ABounds: TRect;
  AData: TObject; AOffset: Integer = 0): TcxExportVisualItem;
begin
  Result := TcxExportVisualItem.Create;
  Result.Bounds := ABounds;
  Result.Data := AData;
  Result.Data2 := TObject(AOffset);
  PatternsList.Add(Result);
end;

function TcxGridTableViewExport.CanShowMultiSummaries(AIsFooter: Boolean): Boolean;
begin
  if AIsFooter then 
    Result := OptionsView.CanShowFooterMultiSummaries
  else
    Result := OptionsView.CanShowGroupFooterMultiSummaries;
end;

procedure TcxGridTableViewExport.CreateContent(var ATop, ALeft: Integer);
var
  I: Integer;
  ARow: TcxCustomGridRecord;
begin
  for I := 0 to RecordCount - 1 do
  begin
    ALeft := 0;
    ARow := Records[I];
    if ARow is TcxGridGroupRow then
      AddGroupRow(ATop, ALeft, TcxGridGroupRow(ARow))
    else
      if ARow is TcxGridMasterDataRow then
        AddMasterDataRow(ATop, ALeft, TcxGridMasterDataRow(ARow))
      else
        if ARow is TcxGridDataRow then
          AddDataRow(ATop, ALeft, TcxGridDataRow(ARow));
    AddRowFooters(ATop, ALeft, ARow);
  end;
end;

procedure TcxGridTableViewExport.CreateFooter(var ATop, ALeft: Integer);
begin
  if not OptionsView.Footer then Exit;
  AddFooterCells(ATop, ALeft, nil, 0, -1,
    DataController.Summary.FooterSummaryItems, nil, True);
end;

procedure TcxGridTableViewExport.CreateHeader(var ATop, ALeft: Integer);
begin
  FRecordWidth := ViewInfo.DataWidth;
  ProduceHeadersContainer(ATop, ALeft, ViewInfo.HeaderViewInfo);
end;

procedure TcxGridTableViewExport.CreateExportCells;
var
  ATop, ALeft: Integer; 
begin
  ATop := 0;
  ALeft := 0;
  CreateHeader(ATop, ALeft);
  CreateContent(ATop, ALeft);
  ALeft := 0;
  CreateFooter(ATop, ALeft);
  MergeCells;
end;

procedure TcxGridTableViewExport.CreateRecordFromPattern(
  var ATop, ALeft: Integer; ARecord: TcxCustomGridRecord);
var
  R: TRect;
  I: Integer;
  APattern: TcxExportVisualItem;
  AViewParams: TcxViewParams;
  AStyle: TcxCacheCellStyle; 
begin
  for I := 0 to PatternCount - 1 do
  begin
    APattern := Patterns[I];
    R := APattern.GetBoundsRelativeTo(ATop, ALeft);
    if APattern.IsColumn then
    begin
      AStyle := GetContentParams(ARecord, TcxGridColumn(APattern.Data),
        AViewParams, GridLines, GridLineColor);
      AddVisualDataItem(R, Provider.RegisterStyle(AStyle), ARecord, TcxGridColumn(APattern.Data));
    end
    else
      AddVisualItemEx(R, '', GetPatternParams(ARecord, APattern), taLeftJustify, [], clDefault, True);
  end;
end;

function TcxGridTableViewExport.DoMergeCell(
  AMasterItem, ASlaveItem: TcxExportVisualItem): Boolean;
var
  AColumn: TcxGridColumn;
  AMasterValue, ASlaveValue: Variant;
  AMasterProperties, ASlaveProperties: TcxCustomEditProperties; 
begin
  Result := AMasterItem <> ASlaveItem;
  with AMasterItem.Bounds do
  begin
    Result := Result and not TcxGridDataRow(AMasterItem.Data).Expanded and
      (Bottom = ASlaveItem.Bounds.Top) and (Left = ASlaveItem.Bounds.Left) and
      (Right = ASlaveItem.Bounds.Right);
  end;
  if Result then
  begin
    AColumn := TcxGridColumn(AMasterItem.Data2);
    AMasterValue := GetViewItemValueEx(
      TcxGridDataRow(AMasterItem.Data), AColumn, AMasterProperties);
    ASlaveValue := GetViewItemValueEx(
      TcxGridDataRow(ASlaveItem.Data), AColumn, ASlaveProperties);
    Result := AColumn.DoCompareValuesForCellMerging(TcxGridDataRow(AMasterItem.Data), AMasterProperties,
      AMasterValue, TcxGridDataRow(ASlaveItem.Data), ASlaveProperties,  ASlaveValue);
  end;
  if Result then
  begin
    AMasterItem.Bounds.Bottom := ASlaveItem.Bounds.Bottom;
    ASlaveItem.Hidden := True;
    ASlaveItem.Slave := True;
  end;
end;

procedure TcxGridTableViewExport.ExportCells;
var
  R: TRect;
  I: Integer;
  AItem: TcxExportVisualItem;
begin
  inherited ExportCells;
  R := Rect(0, 0, Columns.Count - 1, Rows.Count - 1);
  for I := 0 to VisualItemCount - 1 do
  begin
    AItem := VisualItems[I];
    if cxRectIsEmpty(AItem.Bounds) then Continue;
    if AItem.Slave then Continue; 
    if AItem.Hidden then
    begin
      if AItem.Data is TcxGridMasterDataRow and TcxGridMasterDataRow(AItem.Data).Expanded then
        ExportDetailCell(AItem);
      Continue;
    end;
    if AItem.IsBackground then
      FillRealArea(AItem.Bounds, AItem.Style, clBtnShadow, GridLines)
    else
    begin
      if AItem.Data2 is TcxGridColumn then
      begin
        SetRealCellStyleAndValueEx(AItem.Bounds, R, AItem.Style,
          TcxCustomGridRecord(AItem.Data), TcxGridColumn(AItem.Data2));
      end
      else
        if AItem.Data2 is TcxDataSummaryItem then
          SetRealCellStyleAndValue(AItem.Bounds, R, AItem.Style, AItem.Value)
        else
          SetRealCellStyleAndValue(AItem.Bounds, R, AItem.Style, AItem.DisplayText)
    end;
  end;
end;

procedure TcxGridTableViewExport.ExportDetailCell(ACell: TcxExportVisualItem); 
var
  R: TRect;
  AViewInfo: TcxCustomGridViewInfo; 
  AGridRow: TcxGridMasterDataRow;
  ADetailExport: TcxGridCustomExport;
  AParams: TcxViewParams; 
  AStyle: TcxCacheCellStyle;
  AStyleIndex: Integer;
begin
  AGridRow := TcxGridMasterDataRow(ACell.Data);
  AViewInfo := CalculateViewViewInfo(AGridRow.ActiveDetailGridView, ViewInfo.Bounds);
  try
    ADetailExport := GetExportClassByGridView(AGridRow.ActiveDetailGridView).CreateFrom(
      Self, AGridRow.ActiveDetailGridView, AViewInfo);
    try
      ADetailExport.CreateExportCache;
      RealBoundsToLogicalBounds(ACell.Bounds, R);
      Styles.GetContentParams(AGridRow, nil, AParams);
      ViewParamsToExportStyle(AParams, AStyle, taLeftJustify, GridLines, GridLineColor);
      AStyleIndex := Provider.RegisterStyle(AStyle);
      Provider.SetCellStyleEx(R.Left, R.Top, R.Bottom - R.Top, R.Right - R.Left, AStyleIndex);
      if not ADetailExport.IsEmpty then
        InternalProvider.SetCacheIntoCell(R.Left, R.Top, ADetailExport.InternalProvider);
    finally
      ADetailExport.Free;
    end;
  finally
    AViewInfo.Free;
  end;
end;

procedure TcxGridTableViewExport.Finalize;
begin
  inherited Finalize;
  FreeAndNil(FPatternsList);
  FreeAndNil(FVisualItemsList);
  FreeAndNil(FGroupSummaryItemsList);
end;

function TcxGridTableViewExport.GetColumnOffset(
  AColumn: TcxGridColumn): Integer;
begin
  Result := LeftPos - IndicatorWidth;
end;

function TcxGridTableViewExport.GetExpandButtonParams(
  ABorders: TcxBorders): TcxCacheCellStyle;
var
  ABorder: TcxBorder;
begin
  Result := DefaultCellStyle;
  for ABorder := bLeft to bBottom do
    if ABorder in ABorders then
    begin
      Result.Borders[Integer(ABorder)].IsDefault := False;
      Result.Borders[Integer(ABorder)].Width := 1;
      Result.Borders[Integer(ABorder)].Color := ColorToRgb(GridLineColor);
    end
    else
    begin
      Result.Borders[Integer(ABorder)].IsDefault := True;
      Result.Borders[Integer(ABorder)].Width := 0;
    end;
  Result.BrushBkColor := ColorToRgb(clBtnFace);
end;

function TcxGridTableViewExport.GetFooterCellCount(
  AItems: TcxDataSummaryItems): Integer;
var
  I: Integer;
begin
  Result := 0;
  if AItems = nil then Exit;
  for I := 0 to AItems.Count - 1 do
    if AItems[I].Position = spFooter then
      Inc(Result);
end;

function TcxGridTableViewExport.GetFooterItemBounds(
  AIndex, ALineIndex: Integer; const AOrigin: TRect; AIsFooter: Boolean): TRect;
var
  H, LCount: Integer;
begin
  with Patterns[AIndex] do
  begin
    H := DefaultRowHeight + cxGridFooterCellIndent;
    Result.Left := Max(Bounds.Left, AOrigin.Left);
    Result.Right := Min(Bounds.Right, AOrigin.Right);
    Result.Top := AOrigin.Top + (Bounds.Top div DefaultRowHeight + ALineIndex) * H;
    LCount := 1;
    if not CanShowMultiSummaries(AIsFooter) then
      LCount := Max(1, (Bounds.Bottom - Bounds.Top) div DefaultRowHeight);
    Result.Bottom := Result.Top + LCount * H;
    InflateRect(Result, -cxGridFooterCellIndent, -cxGridFooterCellIndent);
  end;
end;

function TcxGridTableViewExport.GetFooterLineCount(
  AItems: TcxDataSummaryItems): Integer;

  function IsSameFooterItems(AItem1, AItem2: TcxDataSummaryItem): Boolean;
  begin
    Result := (AItem1.ItemLink = AItem2.ItemLink) and
      (AItem1.Position = spFooter) and (AItem2.Position = spFooter);
  end;

var
  I, J, ACount: Integer;
begin
  Result := 1;
  if AItems = nil then Exit;
  for I := 0 to AItems.Count - 1 do
  begin
    ACount := 0;
    for J := 0 to AItems.Count - 1 do
      if IsSameFooterItems(AItems[I], AItems[J]) then
        Inc(ACount);
    Result := Max(Result, ACount);
  end;
end;

function TcxGridTableViewExport.GetGroupRowColumnIntersection(
  const ARowBounds: TRect; AColumn: TcxGridColumn): TRect;
var
  I: Integer;
begin
  Result := ARowBounds;
  if AColumn = nil then Exit;
  for I := 0 to PatternCount - 1 do
  begin
    if Patterns[I].Data = AColumn then
    begin
      Result.Left := Max(Result.Left, Patterns[I].Bounds.Left);
      Result.Right := Min(Result.Right, Patterns[I].Bounds.Right);
      Break;
    end;
  end;
end;

function TcxGridTableViewExport.GetIsSummaryUnderColumns: Boolean;
begin
  Result := OptionsView.GroupSummaryLayout <> gslStandard;
end;

function TcxGridTableViewExport.GetPatternParams(
  ARecord: TcxCustomGridRecord; AItem: TcxExportVisualItem): TcxViewParams;
begin
  if AItem.IsColumn then
    TcxGridColumn(AItem.Data).Styles.GetContentParams(ARecord, Result)
  else
    FillChar(Result, SizeOf(Result), 0);
end;

function TcxGridTableViewExport.GetPreviewHeight(ARow: TcxCustomGridRecord): Integer;
var
  R: TRect;
  AMaxLineCount: Integer;
  AColumn: TcxGridColumn;
  AParams: TcxViewParams;
begin
  if HasPreview[ARow] then
  begin
    AMaxLineCount := GridView.Preview.MaxLineCount;
    Result := AMaxLineCount * DefaultRowHeight;
    if GridView.Preview.AutoHeight then
    begin
      AColumn := GridView.Preview.Column;
      AColumn.Styles.GetContentParams(ARow, AParams);
      R := Rect(0, 0, RecordWidth, Result);
      with TcxScreenCanvas.Create do
      try
        TextExtent(VarToStr(GetViewItemValue(ARow, AColumn)), R, cxWordBreak and not cxSingleLine);
      finally
        Free;
      end;
      if AMaxLineCount = 0 then 
        Result := cxRectHeight(R) + cxTextOffset * 3
      else
        Result := Min(Result, cxRectHeight(R) + cxTextOffset * 3);
    end;
  end
  else
    Result := 0;
end;

function TcxGridTableViewExport.HasFooter(
  ARow: TcxCustomGridRecord; var ALevel: Integer): Boolean;
begin
  if OptionsView.GroupFooters = gfInvisible then
    Result := False
  else
  begin
    if OptionsView.GroupFooters = gfAlwaysVisible then
      Dec(ALevel);
    Result := (0 <= ALevel) and (ALevel < ARow.Level) and
      TcxCustomGridRecordAccess(ARow).IsParentRecordLast[ALevel] and
      TcxGridColumnAccess.CanShowGroupFooters(GridView.GroupedColumns[ARow.Level - 1 - ALevel]);
  end;
  if ARow is TcxGridGroupRow then
  begin
    Result := Result or
      (OptionsView.GroupFooters = gfAlwaysVisible) and
      (ALevel = -1) and not ARow.Expanded and
      TcxGridColumnAccess.CanShowGroupFooters(TcxGridGroupRow(ARow).GroupedColumn);
  end;
  if Result then
    ALevel := ARow.Level - ALevel - 1;
end;

procedure TcxGridTableViewExport.Initialize;
const
  ACapacitySize: array[Boolean] of Integer =
    (1024 * 1024, 1024);
begin
  inherited Initialize;
  FRecordRowCount := 1;
  FPatternsList := TcxObjectList.Create;
  FVisualItemsList := TcxObjectList.Create;
  FVisualItemsList.Capacity := ACapacitySize[InternalProviderSupported and GridView.IsDetail];
  FGroupSummaryItemsList := TcxObjectList.Create;
  FGroupSummaryItemsList.Capacity := 1024;
end;

procedure TcxGridTableViewExport.MergeCells;
var
  I, J, AMasterRowIndex, ASlaveRowIndex: Integer;
  AColumn: TcxGridColumn;
  AMergedRowsList: TList;
begin
  AMergedRowsList := TList.Create;
  try
    for I := 0 to PatternCount - 1 do
    begin
      if not Patterns[I].IsColumn then Continue;
      AColumn := TcxGridColumn(Patterns[I].Data);
      if not AColumn.Options.CellMerging then Continue;
      AMergedRowsList.Clear;
      for J := 0 to VisualItemCount - 1 do
      begin
        if VisualItems[J].Data2 = AColumn then
          AMergedRowsList.Add(VisualItems[J]);
      end;
      AMasterRowIndex := 0;
      while AMasterRowIndex < AMergedRowsList.Count do
      begin
        ASlaveRowIndex := AMasterRowIndex + 1;
        while ASlaveRowIndex < AMergedRowsList.Count do
        begin
          if DoMergeCell(TcxExportVisualItem(AMergedRowsList[AMasterRowIndex]),
            TcxExportVisualItem(AMergedRowsList[ASlaveRowIndex])) then
            Inc(ASlaveRowIndex)
          else
            Break;
        end;
        AMasterRowIndex := ASlaveRowIndex; 
      end;
    end;
  finally
    AMergedRowsList.Free;
  end;
end;

procedure TcxGridTableViewExport.ProcessGroupSummaryItem(ARow: TcxGridGroupRow;
  AValues: PVariant; AIndex: Integer; const ABounds: TRect; const ARowViewParams: TcxViewParams);
var
  ADisplayText: string;
  ADisplayValue: Variant;
  AItem: TcxExportGroupSummaryItem;
  ASummaryItem: TcxGridTableSummaryItem;
begin
  ASummaryItem := TcxGridTableSummaryItem(ARow.GroupSummaryItems[AIndex]);
  if (ASummaryItem.Column <> nil) and not ASummaryItem.Column.ActuallyVisible then Exit;
  ADisplayText := ASummaryItem.FormatValue(AValues^[AIndex], False);
  ADisplayValue := AValues^[AIndex];
  if (ASummaryItem.Position <> spGroup) or (ADisplayText = '') then Exit;
  AItem := TcxExportGroupSummaryItem.Create;
  AItem.Column := ASummaryItem.Column;
  if (AItem.Column <> nil) and (AItem.Column.VisibleIndex < 0) then
    AItem.Column := nil;
  if AItem.Column <> nil then
  begin
    Styles.GetGroupSummaryCellContentParams(ARow, ASummaryItem, AItem.ViewParams);
    AItem.ViewParams.Color := ARowViewParams.Color;
    AItem.ViewParams.Bitmap := ARowViewParams.Bitmap;
  end
  else
    AItem.ViewParams := ARowViewParams;
  AItem.Bounds := GetGroupRowColumnIntersection(ABounds, AItem.Column);
  AItem.Text := ADisplayText;
  AItem.SummaryItem := ASummaryItem;
  AItem.Value := ADisplayValue;
  AItem.Index := AIndex;
  GroupSummaryItemsList.Add(AItem);
end;

procedure TcxGridTableViewExport.ProcessGroupSummaryItems(
  ARow: TcxGridGroupRow; ABounds: TRect);
var
  I: Integer;
  AItem: TcxExportGroupSummaryItem;
  AItems: TcxDataGroupSummaryItems;
begin
  I := 0;
  AItems := ARow.GroupSummaryItems;
  while I < GroupSummaryItemCount do
  begin
    AItem := GroupSummaryItems[I];
    if (I < (GroupSummaryItemCount - 1)) and
      (AItem.Column = GroupSummaryItems[I + 1].Column) then
    begin
      AItem.Text := AItem.Text + AItems.Separator + ' ' + GroupSummaryItems[I + 1].Text;
      AItem.Value := Null;
      GroupSummaryItemsList[I + 1].Free;
      GroupSummaryItemsList.Delete(I + 1);
      Continue;
    end
    else
      Inc(I);
  end;
  if (GroupSummaryItemCount > 0) and (GroupSummaryItems[0].Column = nil) then
  begin
    GroupSummaryItems[0].Text := ARow.DisplayCaption +
      AItems.BeginText + GroupSummaryItems[0].Text + AItems.EndText;
    GroupSummaryItems[0].Value := Null;
  end
  else
  begin
    AItem := TcxExportGroupSummaryItem.Create;
    AItem.Text := ARow.DisplayCaption;
    if GroupSummaryItemCount = 0 then
    begin
      TcxCustomGridTableItemAccess.DoGetDisplayText(ARow.GroupedColumn, ARow, AItem.Text);
      if AItem.Text <> ARow.DisplayCaption then
        AItem.Value := Null;
    end;
    Styles.GetGroupParams(ARow, ARow.Level, AItem.ViewParams);
    AItem.Bounds := ABounds;
    GroupSummaryItemsList.Insert(0, AItem);
  end;
  GroupSummaryItemsList.Sort(@cxCompareGroupSummaryItems);
  I := 0;
  while I <= GroupSummaryItemCount - 2 do
  begin
    if (I = 0) and (GroupSummaryItems[I].Column = nil) then
      GroupSummaryItems[I].InitWidth;
    with GroupSummaryItems[I] do
    begin
      if (I = 0) and (Column = nil) and (Bounds.Left >= GroupSummaryItems[I + 1].Bounds.Left) then
        GroupSummaryItems[I + 1].Bounds.Left := Bounds.Right
      else
        Bounds.Right := Min(Bounds.Right, GroupSummaryItems[I + 1].Bounds.Left);
      if Bounds.Left >= Bounds.Right then
        GroupSummaryItemsList.Delete(I)
      else
        Inc(I);
    end;
  end;
end;

procedure TcxGridTableViewExport.ProduceHeadersContainer(var ATop, ALeft: Integer;
  AViewInfo: TcxGridColumnContainerViewInfo);
var
  R, AVisibleRect: TRect;
  I, APrevTop, AOffsetY: Integer;
  AItem: TcxGridColumnHeaderViewInfo;
  AVisualItem: TcxExportVisualItem;
begin
  AOffsetY := ATop - AViewInfo.Bounds.Top;
  APrevTop := MaxInt;
  for I := 0 to AViewInfo.Count - 1 do
  begin
    AItem := AViewInfo.Items[I];
    AItem.Recalculate;
    R := cxRectOffset(AItem.RealBounds, GetColumnOffset(AItem.Column), AOffsetY);
    APrevTop := Min(APrevTop, R.Top);
    AVisibleRect := R;
    if not AViewInfo.Visible or not OptionsView.Header then
      AVisibleRect := cxNullRect;
    AVisualItem := AddVisualItemEx(AVisibleRect, AItem.Text,
      AItem.Params, AItem.AlignmentHorz, cxBordersAll, clBtnShadow);
    AVisualItem.Bounds := R;
    AVisualItem.Hidden := not OptionsView.Header;
    ATop := Max(ATop, R.Bottom);
    AVisualItem.Data := AItem.Column;
    AddPattern(R, AVisualItem.Data);
  end;
  SetPatternsBounds(APrevTop, ATop - APrevTop);
  if not OptionsView.Header then
    ATop := 0;
end;

procedure TcxGridTableViewExport.SetPatternsBounds(ATop, ABottom: Integer);
var
  I: Integer;
begin
  for I := 0 to PatternsList.Count - 1 do
    with Patterns[I] do 
    begin
      OffsetRect(Bounds, 0, -ATop);
      Bounds.Top := Max(0, Bounds.Top);
      Bounds.Bottom := Min(ABottom, Bounds.Bottom);
    end;
  RecordHeight := ABottom;
  if RecordHeight = 0 then
    RecordHeight := ViewInfo.RecordsViewInfo.RowHeight;
  DefaultRowHeight := RecordHeight;
end;

function TcxGridTableViewExport.GetFooterCellBorderColor: TColor;
begin
  Result := Grid.LookAndFeelPainter.FooterSeparatorColor;
end;

function TcxGridTableViewExport.GetGridLineColor: TColor;
begin
  Result := OptionsView.GridLineColor;
  if Result = clDefault then
    Result := clBtnShadow;
end;

function TcxGridTableViewExport.GetGridLines: TcxBorders;
begin
  Result := GridLines2Borders[OptionsView.GridLines];  
end;

function TcxGridTableViewExport.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

function TcxGridTableViewExport.GetGroupSummaryCount: Integer;
begin
  Result := FGroupSummaryItemsList.Count;
end;

function TcxGridTableViewExport.GetGroupSummaryItem(
  AIndex: Integer): TcxExportGroupSummaryItem;
begin
  Result := TcxExportGroupSummaryItem(FGroupSummaryItemsList[AIndex]);
end;

function TcxGridTableViewExport.GetHasPreview(
  ARow: TcxCustomGridRecord): Boolean;
begin
  with GridView.Preview do
    Result := Visible and (Column <> nil);
end;

function TcxGridTableViewExport.GetIndicatorWidth: Integer;
begin
  if ViewInfo.IndicatorViewInfo.Visible then
    Result := OptionsView.IndicatorWidth
  else
    Result := 0;
end;

function TcxGridTableViewExport.GetLeftPos: Integer;
begin
  Result := GridView.Controller.LeftPos;
end;

function TcxGridTableViewExport.GetOptionsView: TcxGridTableOptionsView;
begin
  Result := GridView.OptionsView;
end;

function TcxGridTableViewExport.GetPattern(AIndex: Integer): TcxExportVisualItem;
begin
  Result := PatternsList[AIndex] as TcxExportVisualItem;
end;

function TcxGridTableViewExport.GetPatternCount: Integer;
begin
  Result := PatternsList.Count;
end;

function TcxGridTableViewExport.GetPreviewPlace: TcxGridPreviewPlace;
begin
  Result := GridView.Preview.Place; 
end;

function TcxGridTableViewExport.GetStyles: TcxGridTableViewStyles;
begin
  Result := GridView.Styles;
end;

function TcxGridTableViewExport.GetViewInfo: TcxGridTableViewInfo;
begin
  Result := inherited ViewInfo as TcxGridTableViewInfo;
end;

function TcxGridTableViewExport.GetVisualItem(
  AIndex: Integer): TcxExportVisualItem;
begin
  Result := VisualItemsList[AIndex] as TcxExportVisualItem;
end;

function TcxGridTableViewExport.GetVisualItemCount: Integer;
begin
  Result := VisualItemsList.Count;
end;

procedure TcxGridTableViewExport.SetLeftPos(AValue: Integer);
begin
  GridView.Controller.LeftPos := AValue;
  ViewInfo.Recalculate;
end;

{ TcxGridBandedTableViewExport }

procedure TcxGridBandedTableViewExport.CreateBandHeaders(
  var ATop: Integer; AForRootBands: Boolean);

  function IsFirstInGroup(ABand: TcxGridBand): Boolean;
  begin
    if ABand.IsRoot then
      Result := (ABand.VisibleRootIndex = 0) or
        (ABand.Bands.VisibleRootItems[ABand.VisibleRootIndex - 1].FixedKind <> ABand.FixedKind)
    else
      Result := (ABand = ABand.ParentBand.VisibleChildBands[0]) and IsFirstInGroup(ABand.ParentBand); 
  end;

var
  R: TRect;
  ABandViewInfo: TcxGridBandViewInfo;
  ABandsViewInfo: TcxGridBandsViewInfo;
  ABandHeader: TcxGridBandHeaderViewInfo;
  AVisualItem: TcxExportVisualItem;
  AHeight, I, AOffsetX, AOffsetY, AColsOffset: Integer;
begin
  AHeight := 0;
  AOffsetX := 0;
  AOffsetY := ATop - ViewInfo.HeaderViewInfo.Bounds.Top;
  ABandsViewInfo := ViewInfo.HeaderViewInfo.BandsViewInfo;
  for I := 0 to ABandsViewInfo.Count - 1 do
  begin
    ABandViewInfo := ABandsViewInfo.Items[I];
    if (AForRootBands and (ABandViewInfo.Band.ParentBand <> nil)) or
      (not AForRootBands and (ABandViewInfo.Band.ParentBand = nil)) then Continue;
    if not AForRootBands then
      AOffsetX := ABandViewInfo.Bounds.Left + GetParentBandOffset(ABandViewInfo.Band.ParentBand);
    with cxRectSize(ABandViewInfo.Bounds) do
      R := cxRectBounds(AOffsetX, ABandViewInfo.Bounds.Top + AOffsetY, cx, cy);
    if not cxRectIsEmpty(R) then
    begin
      AddVisualItemEx(R, ABandViewInfo.Text, ABandViewInfo.Params,
        ABandViewInfo.AlignmentHorz, [], clDefault, True);
    end;
    AColsOffset := AOffsetX - ABandViewInfo.Bounds.Left;
    AddPattern(R, ABandViewInfo.Band, AColsOffset);
    ABandHeader := ABandViewInfo.HeaderViewInfo;
    R := cxRectOffset(cxRectSetLeft(ABandHeader.Bounds, AOffsetX), 0, AOffsetY);
    if (ABandHeader.Band.FixedKind = fkRight) and IsFirstInGroup(ABandHeader.Band) then
      OffsetRect(R, OptionsView.FixedBandSeparatorWidth, 0);
    AVisualItem := AddVisualItemEx(R, ABandHeader.Text, ABandHeader.Params,
      ABandHeader.AlignmentHorz, cxBordersAll, clBtnShadow);
    AVisualItem.Data := ABandHeader.Band;
    AVisualItem.Hidden := not OptionsView.BandHeaders;
    if OptionsView.BandHeaders then
      AHeight := Max(AHeight, R.Bottom);
    if AForRootBands then
      Inc(AOffsetX, cxRectWidth(ABandViewInfo.Bounds));
  end;
  ATop := AHeight;
end;

procedure TcxGridBandedTableViewExport.CreateHeader(var ATop, ALeft: Integer);
var
  ABandsViewInfo: TcxGridBandsViewInfo;
  APrevTop, AHeight: Integer;
begin
  AHeight := 0;
  APrevTop := ATop;
  ABandsViewInfo := ViewInfo.HeaderViewInfo.BandsViewInfo;
  CreateBandHeaders(AHeight, True);
  ATop := Max(ATop, AHeight);
  AHeight := APrevTop;
  CreateBandHeaders(AHeight, False);
  ATop := Max(ATop, AHeight);
  inherited CreateHeader(APrevTop, ALeft);
  ATop := Max(ATop, APrevTop);
  FRecordRowCount := ABandsViewInfo.LineCount;
  if RecordRowCount = 0 then
    DefaultRowHeight := RecordHeight
  else
    DefaultRowHeight := RecordHeight div RecordRowCount;
end;

function TcxGridBandedTableViewExport.GetColumnOffset(
  AColumn: TcxGridColumn): Integer;
begin
  Result := Integer(GetPatternByBand(
    TcxGridBandedColumn(AColumn).Position.Band).Data2);
end;

function TcxGridBandedTableViewExport.GetContentOffset: TPoint;
begin
  Result := Point(0, 0);
  if ViewInfo.GroupByBoxViewInfo.Visible then
    Result.Y := -ViewInfo.GroupByBoxViewInfo.Bounds.Bottom;
end;

function TcxGridBandedTableViewExport.GetIsSummaryUnderColumns: Boolean;
var
  I: Integer;
  ARowIndex: Integer; 
begin
  Result := inherited GetIsSummaryUnderColumns;
  ARowIndex := -1;
  for I := 0 to GridView.VisibleColumnCount - 1 do
  with GridView.VisibleColumns[I] do
  begin
    if ARowIndex = -1 then
      ARowIndex := Position.RowIndex
    else
      Result := Result and (ARowIndex = Position.RowIndex);
  end;
end;

function TcxGridBandedTableViewExport.GetParentBandOffset(ABand: TcxGridBand): Integer;
begin
  while ABand.ParentBand <> nil do
    ABand := ABand.ParentBand;
  Result := Integer(GetPatternByBand(ABand).Data2);
end;

function TcxGridBandedTableViewExport.GetPatternByBand(
  ABand: TcxGridBand): TcxExportVisualItem;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to PatternCount - 1 do
    with Patterns[I] do
      if not IsColumn and (Data = ABand) then
      begin
        Result := Patterns[I];
        Break;
      end;
end;

function TcxGridBandedTableViewExport.GetPatternParams(
  ARecord: TcxCustomGridRecord; AItem: TcxExportVisualItem): TcxViewParams;
var
  ACellPos: TcxGridDataCellPos;
begin
  if AItem.IsColumn then
    Result := inherited GetPatternParams(ARecord, AItem)
  else
  begin
    ACellPos := TcxGridDataCellPos.Create(ARecord, nil);
    try
      TcxGridBand(AItem.Data).Styles.GetViewParams(bsContent, ACellPos, nil, Result);
    finally
      ACellPos.Free;
    end;
  end;
end;

function TcxGridBandedTableViewExport.ProduceColumnsContainer(
  AContainer: TcxGridColumnContainerViewInfo; ATop, ALeft: Integer): Integer;
var
  R: TRect;
  I: Integer;
  AItem: TcxGridColumnHeaderViewInfo;
  AVisualItem: TcxExportVisualItem;
begin
  Result := 0;
  if not AContainer.Visible then Exit;
  Dec(ATop, AContainer.Bounds.Top);
  Dec(ALeft, AContainer.Bounds.Left);
  R := AContainer.Bounds;
  AddVisualItemEx(cxRectOffset(AContainer.Bounds, ALeft, ATop),
    AContainer.Text, AContainer.Params, AContainer.AlignmentHorz, [], clDefault, True);
  Result := 0;
  for I := 0 to AContainer.Count - 1 do
  begin
    AItem := AContainer.Items[I];
    if not AItem.Visible then
    R := cxRectOffset(AItem.RealBounds, ALeft, ATop);
    AVisualItem := AddVisualItemEx(R, AItem.Text,
      AItem.Params, AItem.AlignmentHorz, cxBordersAll, clBtnShadow);
    Result := Max(Result, R.Bottom);
    AVisualItem.Data := AItem.Column;
  end;
end;

function TcxGridBandedTableViewExport.GetGridView: TcxGridBandedTableView;
begin
  Result := TcxGridBandedTableView(inherited GridView);
end;

function TcxGridBandedTableViewExport.GetViewInfo: TcxGridBandedTableViewInfo;
begin
  Result := TcxGridBandedTableViewInfo(inherited ViewInfo); 
end;

function TcxGridBandedTableViewExport.GetOptionsView: TcxGridBandedTableOptionsView;
begin
  Result := TcxGridBandedTableOptionsView(inherited OptionsView);
end;

{  TcxExportCardRow }

constructor TcxExportCardRow.Create(AOwner: TcxExportCard);
begin
  FOwner := AOwner;  
end;

procedure TcxExportCardRow.AddToScales(
  AColumnScale, ARowScale: TcxExportScale);
begin
  AColumnScale.AddPairs(Bounds.Left, Bounds.Right);
  if HasIndent then
    AColumnScale.Add(Bounds.Left + CategoryIndent);
  if HasSeparator then
    ARowScale.Add(Bounds.Top + SeparatorWidth);
  if ShowCaption then
    AColumnScale.Add(Bounds.Left + CaptionWidth);
  ARowScale.AddPairs(Bounds.Top, Bounds.Bottom);
end;

function TcxExportCardRow.GetCaptionBounds: TRect;
begin
  Result := Bounds;
  if ShowData then
    Result.Right := Result.Left + CaptionWidth;
  if HasIndent then
    Inc(Result.Left, CategoryIndent);
  if HasSeparator then
    Inc(Result.Top, SeparatorWidth);
end;

function TcxExportCardRow.GetCaptionStyle: TcxViewParams;
begin
  case Row.Kind of
    rkCaption:
      Row.Styles.GetCaptionRowParams(Card, Result);
    rkCategory:
      Row.Styles.GetCategoryRowParams(Card,Result);
    else
      Row.Styles.GetCaptionParams(Card, Result);
  end;
end;

function TcxExportCardRow.GetCard: TcxGridCard;
begin
  Result := Owner.Card; 
end;

function TcxExportCardRow.GetCategoryIndent: Integer;
begin
  if Row.HasExpandButton then
    Result := Owner.Owner.ExpandButtonSize + cxTextOffset * 2
  else
    Result := Owner.Owner.CategoryIndent;
end;

function TcxExportCardRow.GetDataAlignment: TAlignment;
begin
  Result := Row.GetProperties.Alignment.Horz;
end;

function TcxExportCardRow.GetDataBounds: TRect;
begin
  Result := Bounds;
  if ShowCaption then
    Inc(Result.Left, CaptionWidth)
  else
    if HasIndent then
      Inc(Result.Left, CategoryIndent);
  if HasSeparator then
    Inc(Result.Top, SeparatorWidth);
end;

function TcxExportCardRow.GetDataStyle: TcxViewParams;
begin
  case Row.Kind of
    rkCaption:
      Row.Styles.GetCaptionRowParams(Card, Result);
    rkCategory:
      Row.Styles.GetCategoryRowParams(Card, Result);
    else
      Row.Styles.GetContentParams(Card, Result);
  end;
end;

function TcxExportCardRow.GetDataValue: Variant;
begin
  Result := Owner.Owner.GetViewItemValue(Card, Row);
end;

function TcxExportCardRow.GetHasIndent: Boolean;
begin
  Result := Row.HasExpandButton or (Row.CategoryRow <> nil);
  if Result and Owner.Owner.IsHorizontalRows then
    Result := Row.Position.VisibleIndexInLayer = 0;
end;

function TcxExportCardRow.GetHasSeparator: Boolean;
begin
  Result := FHasSeparator; 
end;

function TcxExportCardRow.GetHeight: Integer;
begin
  Result := Bounds.Bottom - Bounds.Top;
end;

function TcxExportCardRow.GetIndentBounds: TRect;
begin
  Result := Bounds;
  Result.Right := Result.Left + CategoryIndent;
  if HasSeparator then
    Inc(Result.Top, SeparatorWidth);
end;

function TcxExportCardRow.GetIndentStyle: TcxViewParams;
begin
  if HasIndent then
  begin
    if Row.HasExpandButton or (Row.CategoryRow = nil) then
      Result := CaptionStyle
    else
      Row.CategoryRow.Styles.GetCategoryRowParams(Card, Result);
  end;
end;

function TcxExportCardRow.GetSeparatorBounds: TRect;
begin
  if Owner.Owner.IsHorizontalRows then
  begin
    Result := cxRectSetTop(Owner.Bounds, Bounds.Top, SeparatorWidth);
    InflateRect(Result, -Owner.BorderWidth, 0);
  end
  else
    Result := cxRectSetTop(Bounds, Bounds.Top, SeparatorWidth);
end;

function TcxExportCardRow.GetSeparatorWidth: Integer;
begin
  Result := Owner.Owner.OptionsView.CategorySeparatorWidth;
end;

function TcxExportCardRow.GetShowCaption: Boolean;
begin
  Result := Row.Options.ShowCaption;
end;

function TcxExportCardRow.GetShowData: Boolean;
begin
  Result := Row.Options.ShowData;
end;

function TcxExportCardRow.GetVisibleCaption: string;
begin
  Result := Row.VisibleCaption;
end;

function TcxExportCardRow.GetWidth: Integer;
begin
  Result := Bounds.Right - Bounds.Left;
end;

procedure TcxExportCardRow.SetHeight(AValue: Integer);
begin
  Bounds.Bottom := Bounds.Top + AValue;
end;

procedure TcxExportCardRow.SetWidth(AValue: Integer);
begin
  Bounds.Right := Bounds.Left + AValue;
end;

{ TcxExportCard }

constructor TcxExportCard.Create(
  AOwner: TcxGridCardViewExport; ACard: TcxGridCard);
begin
  FCard := ACard;
  FLayersList := TcxObjectList.Create();
  FOwner := AOwner;
end;

destructor TcxExportCard.Destroy;
begin
  FreeAndNil(FLayersList);
  inherited Destroy;
end;

procedure TcxExportCard.AddToScales(
  AColumnScale, ARowScale: TcxExportScale);
var
  ALayerIndex, ARowIndex: Integer;
begin
  for ALayerIndex := 0 to LayerCount - 1 do
    for ARowIndex := 0 to RowCount[ALayerIndex] - 1 do
      Rows[ALayerIndex, ARowIndex].AddToScales(AColumnScale, ARowScale);
  if BorderWidth > 0 then
  begin
    AColumnScale.AddPairs(Bounds.Left, Bounds.Right);
    ARowScale.AddPairs(Bounds.Top, Bounds.Bottom);
  end;
  if HasSeparators then
  begin
    for ALayerIndex := 0 to LayerCount - 2 do
      with LayerSeparators[ALayerIndex] do
      begin
        AColumnScale.AddPairs(Left, Right);
        ARowScale.AddPairs(Top, Bottom);
      end;
  end;
end;

procedure TcxExportCard.CalculateLayersCaptionWidth(
  AWidths: TcxExportIntList; AFistRowInLayerOnly: Boolean);
var
  I, J: Integer;
begin
  I := LayerCount;
  if AFistRowInLayerOnly then
    I := 1;
  if AWidths.Count < I then
    AWidths.Count := I;
  for I := 0 to LayerCount - 1 do
  begin
    if AFistRowInLayerOnly then
       AWidths[0] := GetRowCaptionWidth(I, 0, AWidths[0])
    else
      for J := 0 to RowCount[I] - 1 do
        AWidths[I] := GetRowCaptionWidth(I, J, AWidths[I]);
  end;
end;

function TcxExportCard.GetRowCaptionWidth(
  ALayerIndex, ARowIndex: Integer; AMaxWidth: Integer = 0): Integer;
var
  ARow: TcxExportCardRow;
begin
  ARow := Rows[ALayerIndex, ARowIndex];
  if ARow.HasIndent then
    Result := Owner.OptionsView.CategoryIndent
  else
    Result := 0;
  if ARow.ShowCaption and ARow.ShowData then
    Inc(Result, Owner.TextWidthEx(ARow.CaptionStyle, ARow.VisibleCaption) + cxTextOffset * 2);
  Result := Max(Result, AMaxWidth);
end;

procedure TcxExportCard.SetLayersCaptionWidth(
  AWidths: TcxExportIntList; AFistRowInLayerOnly: Boolean);
var
  ALayerIndex, ARowIndex, AWidth: Integer;
begin
  for ALayerIndex := 0 to LayerCount - 1 do
    for ARowIndex := 0 to RowCount[ALayerIndex] - 1 do
    begin
      if Owner.IsHorizontalRows then
      begin
        if (ARowIndex = 0) or not AFistRowInLayerOnly then
          AWidth := AWidths[ARowIndex]
        else
          AWidth := GetRowCaptionWidth(ALayerIndex, ARowIndex);
        SetRowCaptionWidth(ALayerIndex, ARowIndex, AWidth);
      end
      else
        SetRowCaptionWidth(ALayerIndex, ARowIndex, AWidths[ALayerIndex]);
    end;
end;

procedure TcxExportCard.SetRowCaptionWidth(
  ALayerIndex, ARowIndex, AWidth: Integer);
begin
  Rows[ALayerIndex, ARowIndex].CaptionWidth := AWidth;
end;

function TcxExportCard.AddLayer: TList;
begin
  Result := TList.Create;
  LayersList.Add(Result);
end;

function TcxExportCard.AddRow(
  ALayerIndex: Integer; ARow: TcxGridCardViewRow): TcxExportCardRow;
begin
  Result := TcxExportCardRow.Create(Self);
  Result.Row := ARow;
  if ARow.Options.ShowCaption then
  begin
    Result.CaptionStyleIndex :=
      Owner.RegisterViewParams(Result.CaptionStyle, ARow.CaptionAlignmentHorz);
  end;
  Result.DataStyleIndex := Owner.RegisterViewParams(Result.DataStyle, Result.DataAlignment);
  if Result.HasIndent then
    Result.IndentStyleIndex := Owner.RegisterViewParams(Result.IndentStyle); 
  Result.Bounds := Rect(Bounds.Left, 0, Bounds.Left +  ARow.Position.Width,
    ARow.Position.LineCount * Owner.TextHeightEx(Result.DataStyle));
  Layers[ALayerIndex].Add(Result);
end;

procedure TcxExportCard.AddLayerSeparators;
var
  ALayerIndex, ARowIndex, AOffset: Integer; 
begin
  if not HasSeparators then Exit;
  if Owner.IsHorizontalRows then
  begin
    AOffset := 0;
    for ALayerIndex := 1 to LayerCount - 1 do
    begin
      Inc(AOffset, SeparatorWidth);
      for ARowIndex := 0 to RowCount[ALayerIndex] - 1 do
        OffsetRect(Rows[ALayerIndex, ARowIndex].Bounds, 0, AOffset);
    end;
    Inc(FBounds.Bottom, AOffset);
  end;
end;

procedure TcxExportCard.AdjustLayersWidthToWidth;
var
  ALayer, ARowIndex, ALeft: Integer;
  AWidths: array of Integer;
begin
  SetLength(AWidths, LayerCount);
  for ALayer := 0 to LayerCount - 1 do
    for ARowIndex := 0 to RowCount[ALayer] - 1 do
      AWidths[ALayer] := Max(AWidths[ALayer], Rows[ALayer, ARowIndex].Width);
  CalculateCardRowWidths(AWidths, (Bounds.Right - Bounds.Left) - BorderWidth * 2);
  ALeft := Bounds.Left + BorderWidth;
  for ALayer := 0 to LayerCount - 1 do
  begin
    if HasSeparators and (ALayer > 0) then
    begin
      Inc(ALeft, SeparatorWidth);
      Dec(AWidths[ALayer], SeparatorWidth);
    end;
    for ARowIndex := 0 to RowCount[ALayer] - 1 do
      with Rows[ALayer, ARowIndex] do 
        Bounds := cxRectSetLeft(Bounds, ALeft, AWidths[ALayer]);
    Inc(ALeft, AWidths[ALayer]);
  end;
end;

function TcxExportCard.AdjustRowsHeightInLayer(
  ALayer, ATop: Integer): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to RowCount[ALayer] - 1 do
    Result := Max(Rows[ALayer, I].Height, Result);
  for I := 0 to RowCount[ALayer] - 1 do
    with Rows[ALayer, I].Bounds do
    begin
      Top := ATop;
      Bottom := Top + Result;
    end;
end;

procedure TcxExportCard.AdjustRowsWidthToWidth(ALayer: Integer);
var
  I, ALeft, AWidth: Integer;
  AWidths: array of Integer;
begin
  AWidth := Bounds.Right - Bounds.Left - BorderWidth * 2;
  if RowCount[ALayer] = 1 then
  begin
    Rows[ALayer, 0].Bounds.Left := Bounds.Left + BorderWidth;
    Rows[ALayer, 0].Width := AWidth
  end
  else
  begin
    SetLength(AWidths, RowCount[ALayer]);
    for I := 0 to RowCount[ALayer] - 1 do
      AWidths[I] := Rows[ALayer, I].Width;
    CalculateCardRowWidths(AWidths, AWidth);
    ALeft := Bounds.Left + BorderWidth;
    for I := 0 to RowCount[ALayer] - 1 do
      with Rows[ALayer, I] do
      begin
        Bounds.Left := ALeft;
        Inc(ALeft, AWidths[I]);
        Bounds.Right := ALeft;
      end;
  end;
end;

procedure TcxExportCard.CheckCategorySeparators(AHorizontalLayout: Boolean);
var
  ARow: TcxExportCardRow; 
  ALayerIndex, ARowIndex, ACountRowsInLayer: Integer;
begin
  if Owner.OptionsView.CategorySeparatorWidth = 0 then Exit; 
  for ALayerIndex := 1 to LayerCount - 1 do
  begin
    ACountRowsInLayer := RowCount[ALayerIndex];
    for ARowIndex := 0 to ACountRowsInLayer - 1 do
    begin
      ARow := Rows[ALayerIndex, ARowIndex];
      ARow.FHasSeparator := ARow.Row.Kind = rkCategory;
      if ARow.FHasSeparator then
      begin
        if Owner.IsHorizontalRows then
          ARow.FHasSeparator := ACountRowsInLayer = 1
        else
          ARow.FHasSeparator := ARowIndex > 0
      end;
      if ARow.HasSeparator then
        Inc(ARow.Bounds.Bottom, SeparatorWidth);
    end;
  end;
end;

function TcxExportCard.GetBorderWidth: Integer;
begin
  Result := Owner.OptionsView.CardBorderWidth;
end;

function TcxExportCard.GetHasSeparators: Boolean; 
begin
  Result := not Owner.IsSimpleLayout and (LayerCount > 1) and (SeparatorWidth > 0);
end;

function TcxExportCard.GetLayer(AIndex: Integer): TList;
begin
  Result := TList(LayersList[AIndex])
end;

function TcxExportCard.GetLayerCount: Integer;
begin
  Result := LayersList.Count;
end;

function TcxExportCard.GetLayerSeparator(AIndex: Integer): TRect;
begin
  if Owner.IsHorizontalRows then
  begin
    Result := cxRectSetTop(Bounds, Rows[AIndex, 0].Bounds.Bottom, SeparatorWidth);
    InflateRect(Result, -BorderWidth, 0);
  end
  else
  begin
    Result := cxRectSetLeft(Bounds, Rows[AIndex, 0].Bounds.Right, SeparatorWidth);
    InflateRect(Result, 0, -BorderWidth);
  end;
end;

function TcxExportCard.GetRow(ALayerIndex, ARowIndex: Integer): TcxExportCardRow;
begin
  Result := TcxExportCardRow(Layers[ALayerIndex][ARowIndex]);
end;

function TcxExportCard.GetRowCount(ALayerIndex: Integer): Integer;
begin
  Result := Layers[ALayerIndex].Count;
end;

function TcxExportCard.GetSeparatorWidth: Integer;
begin
  Result := Owner.OptionsView.LayerSeparatorWidth; 
end;

procedure TcxExportCard.SetBounds(const ABounds: TRect);
var
  AOffset: TPoint;
  ALayerIndex, ARowIndex: Integer;
begin
  FBounds := ABounds;
  AOffset := Point(ABounds.Left - FBounds.Left, ABounds.Top - FBounds.Top);
  for ALayerIndex := 0 to LayerCount - 1 do
    for ARowIndex := 0 to RowCount[ALayerIndex] - 1 do
      OffsetRect(Rows[ALayerIndex, ARowIndex].Bounds, AOffset.X, AOffset.Y); 
end;

{ TcxExportCardLayoutBuilder }

constructor TcxExportCardLayoutBuilder.Create(AOwner: TcxGridCardViewExport);
begin
  FRowsList := TList.Create;
  FOwner := AOwner;
end;

destructor TcxExportCardLayoutBuilder.Destroy;
begin
  FreeAndNil(FRowsList);
  inherited Destroy;
end;

procedure TcxExportCardLayoutBuilder.BuildLayout(
  ACard: TcxGridCard; AExportCard: TcxExportCard);
var
  ALayerIndex, ARowIndex, ATop: Integer;
begin
  FExportCard := AExportCard;
  ACard.GetVisibleRows(RowsList);
  ATop := AExportCard.Bounds.Top + AExportCard.BorderWidth;
  SplitRowsToLayers;
  if Owner.IsHorizontalRows then
  begin
    for ALayerIndex := 0 to ExportCard.LayerCount - 1 do
    begin
      ExportCard.AdjustRowsWidthToWidth(ALayerIndex);
      Inc(ATop, ExportCard.AdjustRowsHeightInLayer(ALayerIndex, ATop));
      AExportCard.FBounds.Bottom := ATop + AExportCard.BorderWidth;
    end;
    ExportCard.AddLayerSeparators;
  end
  else
  begin
    ExportCard.AdjustLayersWidthToWidth();
    for ALayerIndex := 0 to ExportCard.LayerCount - 1 do
    begin
      ATop := ExportCard.Bounds.Top + ExportCard.BorderWidth;
      for ARowIndex := 0 to ExportCard.RowCount[ALayerIndex] - 1 do
        with ExportCard.Rows[ALayerIndex, ARowIndex] do
        begin
          Bounds := cxRectSetTop(Bounds, ATop);
          ATop := Bounds.Bottom;
        end;
      ExportCard.FBounds.Bottom := Max(ExportCard.FBounds.Bottom, ATop + ExportCard.BorderWidth);
    end;
  end;
end;

function TcxExportCardLayoutBuilder.GetLayerIndex(ARow: TcxGridCardViewRow): Integer;
begin
  if Owner.IsHorizontalRows then
    Result := ARow.Position.RowIndex
  else
    Result := ARow.Position.ColIndex;
end;

procedure TcxExportCardLayoutBuilder.SplitRowsToLayers;
var
  ARow: TcxGridCardViewRow;
  I, ACurrentLayerIndex: Integer;
begin
  ACurrentLayerIndex := -1;
  for I := 0 to RowsList.Count - 1 do
  begin
    ARow := TcxGridCardViewRow(RowsList[I]);
    if GetLayerIndex(ARow) <> ACurrentLayerIndex then
    begin
      ACurrentLayerIndex := GetLayerIndex(ARow);
      ExportCard.AddLayer();
    end;
    ExportCard.AddRow(ExportCard.LayerCount - 1, ARow);
  end;
  ExportCard.CheckCategorySeparators(Owner.IsHorizontalRows);
end;

{ TcxGridCardViewExport }

procedure TcxGridCardViewExport.AddCardSeparator(APosition: Integer);
begin
  if LayoutDirection = ldHorizontal then
    Columns.AddPairs(APosition, APosition + OptionsView.SeparatorWidth)
  else
    Rows.AddPairs(APosition, APosition + OptionsView.SeparatorWidth);
  FCardSeparators.AddPairs(APosition, APosition + OptionsView.SeparatorWidth);
end;

function TcxGridCardViewExport.AddExportCard(
  AColumnPosition, ARowPosition: Integer; ACard: TcxGridCard): TcxExportCard;
begin
  Result := TcxExportCard.Create(Self, ACard);
  Result.Bounds := cxRectBounds(AColumnPosition, ARowPosition, CardWidth, 0);
  LayoutBuilder.BuildLayout(ACard, Result);
  FExportCardsList.Add(Result);
end;

procedure TcxGridCardViewExport.AdjustRowCaptionWidth;
var
  I: Integer;
  AWidths: TcxExportIntList;
  AAutoWidth: Boolean;
begin
  AWidths := TcxExportIntList.Create;
  try
    AAutoWidth := (GridView.OptionsView.CaptionWidth = 0);
    if AAutoWidth then
    begin
      for I := 0 to CardCount - 1 do
        ExportCards[I].CalculateLayersCaptionWidth(AWidths, IsHorizontalRows);
    end
    else
    begin
      for I := 0 to CardCount - 1 do
        AWidths.Count := Max(AWidths.Count, ExportCards[I].LayerCount);
      for I := 0 to AWidths.Count - 1 do
        AWidths[I] := GridView.OptionsView.CaptionWidth;
    end;
    for I := 0 to CardCount - 1 do
      ExportCards[I].SetLayersCaptionWidth(AWidths, AAutoWidth);
  finally
    AWidths.Free;
  end;
end;

procedure TcxGridCardViewExport.CalculateVisibleInfo;
begin
  FCardSeparators := TcxExportScale.Create; 
  FExportCardsList := TcxObjectList.Create;
  FLayoutBuilder := CreateCardLayoutBuilder;
  RowCardCount := 1;
  ColumnCardCount := 1;
  with GridView.ViewInfo do
  try
    if LayoutDirection = ldVertical then
      ColumnCardCount := Min(CardCount, Max(1, (Bounds.Right - Bounds.Left) div CardWidth))
    else
      RowCardCount := Min(CardCount, Max(1, (Bounds.Bottom - Bounds.Top) div CardHeight));

  except
    on EDivByZero do;
  end;
  if LayoutDirection = ldHorizontal then
    ColumnCardCount := Ceil(CardCount / RowCardCount)
  else
    RowCardCount := Ceil(CardCount / ColumnCardCount)
end;

function TcxGridCardViewExport.CreateCardLayoutBuilder: TcxExportCardLayoutBuilder;
begin
  Result := TcxExportCardLayoutBuilder.Create(Self);
end;

procedure TcxGridCardViewExport.CreateExportCells;
var
  AIndex, AColumnPosition, ARowPosition, ARowHeight, ACount: Integer;
begin
  CalculateVisibleInfo;
  ACount := CardCount;
  AColumnPosition := CardIndent;
  ARowPosition := CardIndent;
  ARowHeight := 0;
  for AIndex := 0 to ACount - 1 do
  begin
    ARowHeight := Max(ARowHeight,
      cxRectHeight(AddExportCard(AColumnPosition, ARowPosition, Cards[AIndex]).Bounds));
    if LayoutDirection = ldHorizontal then
    begin                               
      Inc(ARowPosition, ARowHeight + InterCardVertSpace);
      if (AIndex + 1) mod RowCardCount = 0 then
      begin
        AddCardSeparator(AColumnPosition + CardWidth + CardIndent);
        Inc(AColumnPosition, CardWidth + InterCardHorzSpace);
        ARowPosition := CardIndent;
      end;
    end
    else
    begin
      Inc(AColumnPosition, CardWidth + InterCardHorzSpace);
      if (AIndex + 1) mod ColumnCardCount = 0 then
      begin
        AddCardSeparator(AColumnPosition + ARowHeight + CardIndent);
        Inc(ARowPosition, ARowHeight + InterCardVertSpace);
        AColumnPosition := CardIndent;
      end;
    end;
  end;
  AdjustRowCaptionWidth;
  if KeepRowsSameHeight then
    SetRowSameHeight;
  for AIndex := 0 to ACount - 1 do
    ExportCards[AIndex].AddToScales(Columns, Rows);
  Columns.Arrange;
  Columns.Add(Columns.Last + CardIndent);
  Rows.Arrange;
  Rows.Add(Rows.Last + CardIndent);
end;

procedure TcxGridCardViewExport.ExportCardRow(ACard: TcxExportCard; 
  ARow: TcxExportCardRow; const ACardLogicalBounds: TRect);
var
  ARowLogicalBounds: TRect;
begin
  RealBoundsToLogicalBoundsEx(ARow.Bounds, ACardLogicalBounds, ARowLogicalBounds);
  if ARow.HasIndent then
    SetRealCellStyle(ARow.IndentBounds, ARowLogicalBounds, ARow.IndentStyleIndex);
  if ARow.HasSeparator then
    SetRealCellStyle(ARow.SeparatorBounds, ARowLogicalBounds, CategorySeparatorStyleIndex);
  if ARow.ShowCaption then
    SetRealCellStyleAndValue(ARow.CaptionBounds, ARowLogicalBounds, ARow.CaptionStyleIndex, ARow.VisibleCaption);
  if ARow.Row.Options.ShowData then
    SetRealCellStyleAndValueEx(ARow.DataBounds, ARowLogicalBounds, ARow.DataStyleIndex, ACard.Card, ARow.Row);   
end;

procedure TcxGridCardViewExport.ExportCells;
var
  ACard: TcxExportCard;
  ALogicalBounds: TRect;
  AParams: TcxViewParams; 
  I, ALayerIndex, ARowIndex: Integer;
begin
  inherited ExportCells;
  for I := 0 to CardCount - 1 do
  begin
    ACard := ExportCards[I];
    RealBoundsToLogicalBounds(ACard.Bounds, ALogicalBounds);
    FillArea(ALogicalBounds, CardBorderStyle);
    RealBoundsToLogicalBounds(cxRectInflate(ACard.Bounds,
      -CardBorderWidth, -CardBorderWidth), ALogicalBounds);
    GridView.Styles.GetContentParams(ACard.Card, nil, AParams);
    FillArea(ALogicalBounds, RegisterViewParams(AParams));
    for ALayerIndex := 0 to ACard.LayerCount - 1 do
    begin
      for ARowIndex := 0 to ACard.RowCount[ALayerIndex] - 1 do
        ExportCardRow(ACard, ACard.Rows[ALayerIndex, ARowIndex], ALogicalBounds);
      if ACard.HasSeparators and (ALayerIndex < (ACard.LayerCount - 1)) then
        SetRealCellStyle(ACard.LayerSeparators[ALayerIndex],
          ALogicalBounds, LayerSeparatorStyleIndex);
    end;
  end;
  for I := 0 to CardSeparatorCount - 1 do
    FillArea(CardSeparators[I], CardSeparatorStyleIndex);
end;

procedure TcxGridCardViewExport.Finalize;
begin
  FreeAndNil(FCardSeparators);
  FreeAndNil(FLayoutBuilder);
  FreeAndNil(FExportCardsList);
  inherited Finalize;
end;

procedure TcxGridCardViewExport.RegisterStyles;
begin
  inherited RegisterStyles;
  FCardSeparatorStyleIndex := RegisterSolidStyleEx(OptionsView.SeparatorColor);
  FCategorySeparatorStyleIndex := RegisterSolidStyle(vsCategorySeparator);
  FLayerSeparatorStyleIndex := RegisterSolidStyle(vsLayerSeparator);
  FCardBorderStyle := RegisterSolidStyle(vsCardBorder);
end;

procedure TcxGridCardViewExport.SetRowSameHeight;
begin
end;

function TcxGridCardViewExport.GetCard(AIndex: Integer): TcxGridCard;
begin
  Result := Records[AIndex] as TcxGridCard;
end;

function TcxGridCardViewExport.GetCardBorderWidth: Integer;
begin
  Result := OptionsView.CardBorderWidth;
end;

function TcxGridCardViewExport.GetCardCount: Integer;
begin
  Result := RecordCount;
end;

function TcxGridCardViewExport.GetCardHeight: Integer;
begin
  Result := GridView.ViewInfo.RecordsViewInfo.RowHeight;
end;

function TcxGridCardViewExport.GetCardIndent: Integer;
begin
  Result := OptionsView.CardIndent; 
end;

function TcxGridCardViewExport.GetCardSeparatorCount: Integer;
begin
  Result := FCardSeparators.Count div 2;
end;

function TcxGridCardViewExport.GetCardSeparator(AIndex: Integer): TRect;
var
  AIndex1, AIndex2: Integer;
begin
  if LayoutDirection = ldHorizontal then
  begin
    Columns.GetPosition(FCardSeparators[AIndex * 2],
      FCardSeparators[AIndex * 2 + 1], AIndex1, AIndex2);
    Result := Rect(AIndex1, 1, AIndex2, Rows.Count - 1);
  end
  else
  begin
    Rows.GetPosition(FCardSeparators[AIndex * 2],
      FCardSeparators[AIndex * 2 + 1], AIndex1, AIndex2);
    Result := Rect(1, AIndex1, Columns.Count - 1, AIndex2);
  end; 
end;

function TcxGridCardViewExport.GetCardWidth: Integer;
var
  R: TRect;
begin
  Result := OptionsView.CardWidth;
  if OptionsView.CardAutoWidth then
  begin
    R := GridView.ViewInfo.Bounds;
    Result := Max(1, (R.Right - R.Left) div (Result + InterCardHorzSpace));
    Result := (R.Right - R.Left) div Result;
  end;
end;

function TcxGridCardViewExport.GetCategoryIndent: Integer;
begin
  Result := OptionsView.CategoryIndent;
end;

function TcxGridCardViewExport.GetCategorySeparatorWidth: Integer;
begin
  Result := GridView.OptionsView.CategorySeparatorWidth;
end;

function TcxGridCardViewExport.GetExportCard(AIndex: Integer): TcxExportCard;
begin
  Result := ExportCardsList[AIndex] as TcxExportCard;
end;

function TcxGridCardViewExport.GetGridView: TcxGridCardView;
begin
  Result := TcxGridCardView(inherited GridView);
end;

function TcxGridCardViewExport.GetInterCardHorzSpace: Integer;
begin
  Result := CardIndent * 2;
  if LayoutDirection = ldHorizontal then
    Inc(Result, OptionsView.SeparatorWidth);
end;

function TcxGridCardViewExport.GetInterCardVertSpace: Integer;
begin
  Result := CardIndent * 2;
  if LayoutDirection = ldVertical then
    Inc(Result, OptionsView.SeparatorWidth);
end;

function TcxGridCardViewExport.GetIsHorizontalRows: Boolean;
begin
  Result := GridView.RowLayout = rlHorizontal;
end;

function TcxGridCardViewExport.GetIsSimpleLayout: Boolean;
begin
  Result := GridView.RowLayoutController.IsSimpleLayout or
    (LayerSeparatorWidth = 0);
end; 

function TcxGridCardViewExport.GetLayerSeparatorWidth: Integer;
begin
  Result := GridView.OptionsView.LayerSeparatorWidth; 
end;

function TcxGridCardViewExport.GetLayoutDirection: TcxGridCardViewLayoutDirection;
begin
  Result := GridView.LayoutDirection;
end;

function TcxGridCardViewExport.GetOptionsView: TcxGridCardViewOptionsView;
begin
  Result := GridView.OptionsView;
end;

{ TcxGridChartViewExport }

procedure TcxGridChartViewExport.CreateExportCache;
begin
  if Provider.SupportGraphic then
    ExportAsGraphic
  else
    ExportAsData;
end;

procedure TcxGridChartViewExport.ExportAsGraphic;
var
  AGraphic: TGraphic;
begin
  Provider.SetRange(1, 1, False);
  if SupportGraphic(cxExportGraphicClass) then
    AGraphic := GridView.CreateImage(cxExportGraphicClass)
  else
    AGraphic := GridView.CreateImage(TBitmap);
  try
    Provider.SetCellDataGraphic(0, 0, AGraphic);
  finally
    AGraphic.Free;
  end;
end;

procedure TcxGridChartViewExport.ExportAsData;
var
  AColCount, ARowCount, C, R: Integer;
  ASeries: TcxGridChartSeries;
  AHeaderStyle, AStyle: TcxCacheCellStyle;
begin
  AStyle := DefaultCellStyle;
  for C := 0 to 3 do
    with AStyle.Borders[C] do
    begin
      IsDefault := False;
      Width := 1;
      Color := clBlack;
    end;
  AHeaderStyle := AStyle;
  AHeaderStyle.BrushStyle := cbsSolid;
  AHeaderStyle.BrushBkColor := cxColorToRGB(clBtnFace);
  Provider.SetDefaultStyle(DefaultCellStyle);
  AColCount := Max(GridView.VisibleSeriesCount + 1, 1);
  ARowCount := GridView.ViewData.VisibleCategoryCount + 1;
  Provider.SetRange(AColCount, ARowCount, False);
  for C := 0 to AColCount - 1 do
  begin
    if C = 0 then
    begin
      Provider.SetCellDataWideString(C, 0, 'Category');
      for R := 0 to GridView.ViewData.VisibleCategoryCount - 1 do
        SetCellValueAndStyle(C, R + 1, GridView.ViewData.VisibleCategories[R], AStyle);
    end
    else
    begin
      ASeries := GridView.VisibleSeries[C - 1];
      Provider.SetCellDataWideString(C, 0, ASeries.GetDisplayText);
      for R := 0 to ASeries.VisibleValueCount - 1 do
        SetCellValueAndStyle(C, R + 1, ASeries.VisibleValues[R], AStyle);
    end;
    Provider.SetCellStyle(C, 0, AHeaderStyle);
  end;
end;

function TcxGridChartViewExport.GetGridView: TcxGridChartView;
begin
  Result := TcxGridChartView(FGridView);
end;

// ***

procedure ExportGridToHTML(const AFileName: string; AGrid: TcxGrid;
  AExpand: Boolean; ASaveAll: Boolean; const AFileExt: string);
begin
  ExportGridToFile(AFileName, cxExportToHtml, AGrid, AExpand, ASaveAll, False, '', '', '', AFileExt);
end;

procedure ExportGridToXML(const AFileName: string; AGrid: TcxGrid;
  AExpand: Boolean; ASaveAll: Boolean; const AFileExt: string);
begin
  ExportGridToFile(AFileName, cxExportToXml, AGrid, AExpand, ASaveAll, False, '', '', '', AFileExt);
end;

procedure ExportGridToExcel(const AFileName: string; AGrid: TcxGrid;
  AExpand: Boolean; ASaveAll: Boolean; AUseNativeFormat: Boolean; const AFileExt: string);
begin
  ExportGridToFile(AFileName, cxExportToExcel, AGrid, AExpand, ASaveAll, AUseNativeFormat, '', '', '', AFileExt);
end;

procedure ExportGridToText(const AFileName: string; AGrid: TcxGrid;
  AExpand: Boolean; ASaveAll: Boolean; const ASeparator: string;
  const ABeginString: string; const AEndString: string; const AFileExt: string);
begin
  ExportGridToFile(AFileName, cxExportToText, AGrid, AExpand, ASaveAll, False,
    ASeparator, ABeginString, AEndString, AFileExt);
end;

initialization
  cxExportInit(TcxGetResourceStringProc(@cxGetResourceString), @ColorToRGB,  True );

end.


