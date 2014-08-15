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

unit cxGridTableView;

{$I cxVer.inc}

interface

uses
{$IFDEF DELPHI6}
  Variants,
{$ENDIF}
  Windows, Messages,
  Classes, Graphics, Controls, ImgList, Forms, Buttons, StdCtrls, ExtCtrls, ComCtrls,
  cxClasses, cxControls, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxStorage, cxPC, cxListBox,
  cxContainer, cxEdit, cxTextEdit, 
  cxGrid, cxGridCommon, cxGridLevel, cxGridCustomView, cxGridCustomTableView, cxGridDetailsSite,
  cxCustomData, cxData, cxDataStorage, cxFilter;

const
  htGridBase = 200;
  htGroupByBox = htGridBase + 1;
  htColumnHeader = htGridBase + 2;
  htColumnHeaderHorzSizingEdge = htGridBase + 3;
  htColumnHeaderFilterButton = htGridBase + 4;
  htFooter = htGridBase + 5;
  htFooterCell = htGridBase + 6;
  htGroupFooter = htGridBase + 7;
  htGroupFooterCell = htGridBase + 8;
  htRowIndicator = htGridBase + 9;
  htRowSizingEdge = htGridBase + 10;
  htIndicator = htGridBase + 11;
  htIndicatorHeader = htGridBase + 12;
  htRowLevelIndent = htGridBase + 13;
  htHeader = htGridBase + 14;
  htGroupSummary = htGridBase + 15;

  ckHeader = 2;
  ckGroupByBox = 3;
  ckFooter = 4;

  cxGridDefaultIndicatorWidth = 12;

  cxGridCustomRowSeparatorDefaultWidth = 6;
  cxGridCustomRowSeparatorMinWidth = 2;

  cxGridPreviewDefaultLeftIndent = 20;
  cxGridPreviewDefaultMaxLineCount = 3;
  cxGridPreviewDefaultRightIndent = 5;

  cxGridHeaderSizingEdgeSize = 8;
  cxGridRowSizingEdgeSize = 8;

  cxGridOffice11GroupRowSeparatorWidth: Integer = 2;

  // record kind
  rkFiltering = 2;

  isColumnFirst = isCustomItemLast + 1;
  isFooter = isColumnFirst;
  isGroupSummary = isColumnFirst + 1;
  isHeader = isColumnFirst + 2;
  isColumnLast = isHeader;

  bbTableFirst = bbCustomTableLast + 1;
  bbFooter = bbTableFirst;
  bbHeader = bbTableFirst + 1;
  bbGroup = bbTableFirst + 2;
  bbGroupByBox = bbTableFirst + 3;
  bbIndicator = bbTableFirst + 4;
  bbPreview = bbTableFirst + 5;
  bbTableLast = bbPreview;

  vsTableFirst = vsCustomTableLast + 1;
  vsFilterRowInfoText = vsTableFirst;
  vsFooter = vsTableFirst + 1;
  vsGroup = vsTableFirst + 2;
  vsGroupByBox = vsTableFirst + 3;
  vsGroupFooterSortedSummary = vsTableFirst + 4;
  vsGroupSortedSummary = vsTableFirst + 5;
  vsGroupSummary = vsTableFirst + 6;
  vsHeader = vsTableFirst + 7;
  vsNewItemRowInfoText = vsTableFirst + 8;
  vsIndicator = vsTableFirst + 9;
  vsPreview = vsTableFirst + 10;
  vsTableLast = vsPreview;

type
  TcxGridTableCustomizationForm = class;
  TcxGridTableController = class;
  TcxCustomGridRow = class;
  TcxGridMasterDataRow = class;
  TcxGridGroupRow = class;
  TcxGridViewData = class;
  TcxGridColumnHeaderAreaPainterClass = class of TcxGridColumnHeaderAreaPainter;
  TcxGridColumnContainerViewInfo = class;
  TcxGridColumnHeaderAreaViewInfoClass = class of TcxGridColumnHeaderAreaViewInfo;
  TcxGridColumnHeaderAreaViewInfo = class;
  TcxGridColumnHeaderFilterButtonViewInfo = class;
  TcxGridColumnHeaderGlyphViewInfo = class;
  TcxGridColumnHeaderViewInfoClass = class of TcxGridColumnHeaderViewInfo;
  TcxGridColumnHeaderViewInfo = class;
  TcxGridHeaderViewInfo = class;
  TcxGridGroupByBoxViewInfo = class;
  TcxGridFooterViewInfo = class;
  TcxCustomGridIndicatorItemViewInfo = class;
  TcxGridIndicatorHeaderItemViewInfo = class;
  TcxGridIndicatorRowItemViewInfo = class;
  TcxGridIndicatorFooterItemViewInfo = class;
  TcxGridIndicatorViewInfo = class;
  TcxGridRowFooterViewInfo = class;
  TcxGridRowFootersViewInfo = class;
  TcxCustomGridRowViewInfo = class;
  TcxGridRowsViewInfo = class;
  TcxGridTableViewInfo = class;
  TcxGridTableViewInfoCacheItem = class;
  TcxGridColumn = class;
  TcxGridTableView = class;

  TcxGridColumnContainerKind = Integer;

  { hit tests }

  // custom column

  TcxCustomGridColumnHitTest = class(TcxCustomGridViewHitTest)
  protected
    procedure Assign(Source: TcxCustomGridHitTest); override;
  public
    Column: TcxGridColumn;
    ColumnContainerKind: TcxGridColumnContainerKind;
  end;

  // group by box

  TcxGridGroupByBoxHitTest = class(TcxCustomGridViewHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  // column header

  TcxGridColumnHeaderHitTest = class(TcxCustomGridColumnHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  public
    function DragAndDropObjectClass: TcxCustomGridDragAndDropObjectClass; override;
  end;

  TcxGridColumnHeaderHorzSizingEdgeHitTest = class(TcxCustomGridColumnHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  public
    function Cursor: TCursor; override;
    function DragAndDropObjectClass: TcxCustomGridDragAndDropObjectClass; override;
  end;

  TcxGridColumnHeaderFilterButtonHitTest = class(TcxCustomGridColumnHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  // header

  TcxGridHeaderHitTest = class(TcxCustomGridViewHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  // footer

  TcxGridFooterHitTest = class(TcxCustomGridViewHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  TcxGridFooterCellHitTest = class(TcxCustomGridColumnHitTest)
  protected
    procedure Assign(Source: TcxCustomGridHitTest); override;
    class function GetHitTestCode: Integer; override;
  public
    SummaryItem: TcxDataSummaryItem;
  end;

  TcxGridGroupFooterHitTest = class(TcxGridFooterHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  TcxGridGroupFooterCellHitTest = class(TcxGridFooterCellHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  // indicator

  TcxGridRowIndicatorHitTest = class(TcxGridRecordHitTest)
  protected
    procedure Assign(Source: TcxCustomGridHitTest); override;
    class function GetHitTestCode: Integer; override;
  public
    MultiSelect: Boolean;
    function Cursor: TCursor; override;
  end;

  TcxGridRowSizingEdgeHitTest = class(TcxGridRecordHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  public
    function Cursor: TCursor; override;
    function DragAndDropObjectClass: TcxCustomGridDragAndDropObjectClass; override;
  end;

  TcxGridIndicatorHitTest = class(TcxCustomGridViewHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  TcxGridIndicatorHeaderHitTest = class(TcxGridIndicatorHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  // row

  TcxGridRowLevelIndentHitTest = class(TcxGridRecordHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  public
    class function CanClick: Boolean; override;
  end;

  TcxGridGroupSummaryHitTest = class(TcxGridRecordHitTest)
  private
    function GetColumn: TcxGridColumn;
  protected
    procedure Assign(Source: TcxCustomGridHitTest); override;
    class function GetHitTestCode: Integer; override;
  public
    SummaryItem: TcxDataSummaryItem;
    property Column: TcxGridColumn read GetColumn;
  end;

  { view data }

  TcxCustomGridRowClass = class of TcxCustomGridRow;

  TcxCustomGridRow = class(TcxCustomGridRecord)
  private
    function GetAsGroupRow: TcxGridGroupRow;
    function GetAsMasterDataRow: TcxGridMasterDataRow;
    function GetGridView: TcxGridTableView;
    function GetGridViewLevel: TcxGridLevel;
    function GetIsFilterRow: Boolean;
    function GetIsNewItemRow: Boolean;
    function GetViewData: TcxGridViewData;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  public
    function ExpandOnDblClick: Boolean; virtual;
    function SupportsCellMultiSelect: Boolean; virtual;

    property AsGroupRow: TcxGridGroupRow read GetAsGroupRow;
    property AsMasterDataRow: TcxGridMasterDataRow read GetAsMasterDataRow;
    property GridView: TcxGridTableView read GetGridView;
    property GridViewLevel: TcxGridLevel read GetGridViewLevel;
    property IsFilterRow: Boolean read GetIsFilterRow;
    property IsNewItemRow: Boolean read GetIsNewItemRow;
    property ViewData: TcxGridViewData read GetViewData;
  end;

  TcxGridDataRow = class(TcxCustomGridRow)
  protected
    function GetHasCells: Boolean; override;
    function GetViewInfoCacheItemClass: TcxCustomGridViewInfoCacheItemClass; override;
    function GetViewInfoClass: TcxCustomGridRecordViewInfoClass; override;
  public
    function SupportsCellMultiSelect: Boolean; override;
  end;

  TcxGridNewItemRowClass = class of TcxGridNewItemRow;

  TcxGridNewItemRow = class(TcxGridDataRow)
  public
    function SupportsCellMultiSelect: Boolean; override;
  end;

  TcxGridFilterRowClass = class of TcxGridFilterRow;

  TcxGridFilterRow = class(TcxGridNewItemRow)
  private
    FSelected: Boolean;
    function GetFilterCriteriaItem(Index: Integer): TcxFilterCriteriaItem;
  protected
    procedure RefreshRecordInfo; override;

    function GetSelected: Boolean; override;
    function GetVisible: Boolean; override;
    procedure SetSelected(Value: Boolean); override;

    function GetDisplayText(Index: Integer): string; override;
    function GetValue(Index: Integer): Variant; override;
    procedure SetDisplayText(Index: Integer; const Value: string); override;
    procedure SetValue(Index: Integer; const Value: Variant); override;

    function GetDisplayTextForValue(AIndex: Integer; const AValue: Variant): string; virtual;
    function GetFilterOperatorKind(const AValue: Variant; ACheckMask: Boolean): TcxFilterOperatorKind; virtual;
    function IsFilterOperatorSupported(AKind: TcxFilterOperatorKind; const AValue: Variant): Boolean; virtual;

    procedure KeyDown(var Key: Word; Shift: TShiftState); override;

    property FilterCriteriaItems[Index: Integer]: TcxFilterCriteriaItem read GetFilterCriteriaItem;
    property InternalSelected: Boolean read FSelected write FSelected;
  public
    destructor Destroy; override;
    function CanFocusCells: Boolean; override;
    function IsEmpty: Boolean;
  end;

  TcxGridMasterDataRow = class(TcxGridDataRow)
  private
    function GetActiveDetailGridView: TcxCustomGridView;
    function GetActiveDetailGridViewExists: Boolean;
    function GetActiveDetailIndex: Integer;
    function GetActiveDetailLevel: TcxGridLevel;
    function GetDetailGridView(Index: Integer): TcxCustomGridView;
    function GetDetailGridViewCount: Integer;
    function GetDetailGridViewExists(Index: Integer): Boolean;
    function GetDetailGridViewHasData(Index: Integer): Boolean;
    function GetInternalActiveDetailGridView: TcxCustomGridView;
    function GetInternalActiveDetailGridViewExists: Boolean;
    function GetInternalActiveDetailIndex: Integer;
    procedure SetActiveDetailIndex(Value: Integer);
    procedure SetActiveDetailLevel(Value: TcxGridLevel);
  protected
    procedure DoCollapse(ARecurse: Boolean); override;
    procedure DoExpand(ARecurse: Boolean); override;
    function GetExpandable: Boolean; override;
    function GetExpanded: Boolean; override;
    function GetHasChildren: Boolean; virtual;
    function GetViewInfoCacheItemClass: TcxCustomGridViewInfoCacheItemClass; override;
    function GetViewInfoClass: TcxCustomGridRecordViewInfoClass; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure ToggleExpanded; override;
    property InternalActiveDetailGridView: TcxCustomGridView read GetInternalActiveDetailGridView;
    property InternalActiveDetailGridViewExists: Boolean read GetInternalActiveDetailGridViewExists;
    property InternalActiveDetailIndex: Integer read GetInternalActiveDetailIndex;
  public
    function ExpandOnDblClick: Boolean; override;
    function GetFirstFocusableChild: TcxCustomGridRecord; override;
    function GetLastFocusableChild(ARecursive: Boolean): TcxCustomGridRecord; override;

    property ActiveDetailGridView: TcxCustomGridView read GetActiveDetailGridView;
    property ActiveDetailGridViewExists: Boolean read GetActiveDetailGridViewExists;
    property ActiveDetailIndex: Integer read GetActiveDetailIndex write SetActiveDetailIndex;
    property ActiveDetailLevel: TcxGridLevel read GetActiveDetailLevel write SetActiveDetailLevel;
    property DetailGridViewCount: Integer read GetDetailGridViewCount;
    property DetailGridViewExists[Index: Integer]: Boolean read GetDetailGridViewExists;
    property DetailGridViewHasData[Index: Integer]: Boolean read GetDetailGridViewHasData;
    property DetailGridViews[Index: Integer]: TcxCustomGridView read GetDetailGridView;
    property HasChildren: Boolean read GetHasChildren;
  end;

  TcxGridGroupRow = class(TcxCustomGridRow)
  private
    function GetGroupedColumn: TcxGridColumn;
    function GetGroupSummaryItems: TcxDataGroupSummaryItems;
  protected
    procedure DoCollapse(ARecurse: Boolean); override;
    procedure DoExpand(ARecurse: Boolean); override;
    //function GetDestroyingOnExpanding: Boolean; override;
    function GetExpandable: Boolean; override;
    function GetExpanded: Boolean; override;

    function GetDisplayCaption: string; virtual;
    function GetDisplayText(Index: Integer): string; override;
    function GetDisplayTextValue: string; virtual;
    function GetIsData: Boolean; override;
    function GetIsParent: Boolean; override;
    function GetValue: Variant; reintroduce; virtual;
    function GetViewInfoCacheItemClass: TcxCustomGridViewInfoCacheItemClass; override;
    function GetViewInfoClass: TcxCustomGridRecordViewInfoClass; override;
    procedure SetDisplayText(Index: Integer; const Value: string); override;
    procedure SetValue(Index: Integer; const Value: Variant); override;
  public
    function GetGroupSummaryInfo(var ASummaryItems: TcxDataSummaryItems;
      var ASummaryValues: PVariant): Boolean;

    property DisplayCaption: string read GetDisplayCaption;
    property DisplayText: string read GetDisplayTextValue;
    property GroupedColumn: TcxGridColumn read GetGroupedColumn;
    property GroupSummaryItems: TcxDataGroupSummaryItems read GetGroupSummaryItems;
    property Value: Variant read GetValue;
  end;

  TcxGridViewData = class(TcxCustomGridTableViewData)
  private
    FFilterRow: TcxGridFilterRow;
    function GetNewItemRow: TcxGridNewItemRow;
    function GetRow(Index: Integer): TcxCustomGridRow;
    function GetRowCount: Integer;
  protected
    function GetFirstVisibleExpandedMasterRow: TcxGridMasterDataRow; virtual;
    function GetNewItemRecordClass: TcxCustomGridRecordClass; override;
    function GetRecordByKind(AKind, AIndex: Integer): TcxCustomGridRecord; override;
    function GetRecordClass(ARecordInfo: TcxRowInfo): TcxCustomGridRecordClass; override;
    function GetRecordKind(ARecord: TcxCustomGridRecord): Integer; override;

    procedure CreateFilterRow;
    procedure DestroyFilterRow;
    procedure CheckFilterRow;
    //procedure RecreateFilterRow;
    function GetFilterRowClass: TcxGridFilterRowClass; virtual;
  public
    destructor Destroy; override;
    procedure Collapse(ARecurse: Boolean); override;
    procedure Expand(ARecurse: Boolean); override;
    function HasFilterRow: Boolean; virtual;
    function HasNewItemRecord: Boolean; override;
    function MakeDetailVisible(ADetailLevel: TComponent{TcxGridLevel}): TcxCustomGridView; override;
    //procedure Refresh(ARecordCount: Integer); override;

    property FilterRow: TcxGridFilterRow read FFilterRow;
    property NewItemRow: TcxGridNewItemRow read GetNewItemRow;
    property RowCount: Integer read GetRowCount;
    property Rows[Index: Integer]: TcxCustomGridRow read GetRow;
  end;

  { controller }

  // drag&drop objects

  TcxGridColumnHeaderMovingObjectClass = class of TcxGridColumnHeaderMovingObject;

  TcxGridColumnHeaderMovingObject = class(TcxCustomGridTableItemMovingObject)
  private
    FOriginalDestColumnContainerKind: TcxGridColumnContainerKind;

    function GetGridView: TcxGridTableView;
    function GetSourceItem: TcxGridColumn;
    function GetViewInfo: TcxGridTableViewInfo;
    procedure SetSourceItem(Value: TcxGridColumn);
  protected
    procedure CalculateDestParams(AHitTest: TcxCustomGridHitTest;
      out AContainerKind: TcxGridItemContainerKind; out AZone: TcxGridItemContainerZone); override;
    function CanRemove: Boolean; override;
    procedure CheckDestItemContainerKind(var AValue: TcxGridItemContainerKind); override;
    procedure DoColumnMoving; virtual;
    function GetArrowAreaBounds(APlace: TcxGridArrowPlace): TRect; override;
    function GetArrowAreaBoundsForHeader(APlace: TcxGridArrowPlace): TRect; virtual;
    function GetArrowsClientRect: TRect; override;
    function GetSourceItemViewInfo: TcxCustomGridCellViewInfo; override;
    function IsValidDestination: Boolean; override;
    function IsValidDestinationForVisibleSource: Boolean; virtual;

    procedure EndDragAndDrop(Accepted: Boolean); override;

    property GridView: TcxGridTableView read GetGridView;
    property OriginalDestColumnContainerKind: TcxGridColumnContainerKind
      read FOriginalDestColumnContainerKind write FOriginalDestColumnContainerKind;
    property SourceItem: TcxGridColumn read GetSourceItem write SetSourceItem;
    property ViewInfo: TcxGridTableViewInfo read GetViewInfo;
  public
    procedure Init(const P: TPoint; AParams: TcxCustomGridHitTest); override;
  end;

  TcxCustomGridSizingObject = class(TcxCustomGridDragAndDropObject)
  private
    FDestPointX: Integer;
    FDestPointY: Integer;
    FOriginalSize: Integer;
    function GetController: TcxGridTableController;
    function GetGridView: TcxGridTableView;
    function GetViewInfo: TcxGridTableViewInfo;
    procedure SetDestPointX(Value: Integer);
    procedure SetDestPointY(Value: Integer);
  protected
    procedure DirtyChanged; override;
    function GetCurrentSize: Integer; virtual;
    function GetDeltaSize: Integer; virtual;
    function GetDragAndDropCursor(Accepted: Boolean): TCursor; override;
    function GetHorzSizingMarkBounds: TRect; virtual;
    function GetImmediateStart: Boolean; override;
    function GetIsHorizontalSizing: Boolean; virtual;
    function GetSizingItemBounds: TRect; virtual; abstract;
    function GetSizingMarkBounds: TRect; virtual;
    function GetSizingMarkWidth: Integer; virtual; abstract;
    function GetVertSizingMarkBounds: TRect; virtual;

    procedure DragAndDrop(const P: TPoint; var Accepted: Boolean); override;

    property Controller: TcxGridTableController read GetController;
    property CurrentSize: Integer read GetCurrentSize;
    property DeltaSize: Integer read GetDeltaSize;
    property DestPointX: Integer read FDestPointX write SetDestPointX;
    property DestPointY: Integer read FDestPointY write SetDestPointY;
    property GridView: TcxGridTableView read GetGridView;
    property IsHorizontalSizing: Boolean read GetIsHorizontalSizing;
    property OriginalSize: Integer read FOriginalSize write FOriginalSize;
    property SizingItemBounds: TRect read GetSizingItemBounds;
    property SizingMarkBounds: TRect read GetSizingMarkBounds;
    property SizingMarkWidth: Integer read GetSizingMarkWidth;
    property ViewInfo: TcxGridTableViewInfo read GetViewInfo;
  public
    procedure Init(const P: TPoint; AParams: TcxCustomGridHitTest); override;
  end;

  TcxCustomGridColumnSizingObject = class(TcxCustomGridSizingObject)
  private
    FColumn: TcxGridColumn;
    function GetColumnHeaderViewInfo: TcxGridColumnHeaderViewInfo;
  protected  
    function GetSizingItemBounds: TRect; override;
    function GetSizingMarkWidth: Integer; override;
    property Column: TcxGridColumn read FColumn write FColumn;
    property ColumnHeaderViewInfo: TcxGridColumnHeaderViewInfo read GetColumnHeaderViewInfo;
  public
    procedure Init(const P: TPoint; AParams: TcxCustomGridHitTest); override;
  end;

  TcxGridColumnHorzSizingObject = class(TcxCustomGridColumnSizingObject)
  protected
    procedure BeginDragAndDrop; override;
    procedure EndDragAndDrop(Accepted: Boolean); override;
    function GetCurrentSize: Integer; override;
  end;

  TcxGridRowSizingObject = class(TcxCustomGridSizingObject)
  private
    FRow: TcxCustomGridRow;
    function GetRowViewInfo: TcxCustomGridRowViewInfo;
  protected
    procedure BeginDragAndDrop; override;
    procedure EndDragAndDrop(Accepted: Boolean); override;
    function GetCurrentSize: Integer; override;
    function GetIsHorizontalSizing: Boolean; override;
    function GetSizingItemBounds: TRect; override;
    function GetSizingMarkWidth: Integer; override;
    property Row: TcxCustomGridRow read FRow;
    property RowViewInfo: TcxCustomGridRowViewInfo read GetRowViewInfo;
  public
    procedure Init(const P: TPoint; AParams: TcxCustomGridHitTest); override;
  end;

  // customization form

  TcxGridTableItemsListBox = class(TcxCustomGridTableItemsListBox)
  private
    function GetGridView: TcxGridTableView;
    function GetTextColor: TColor;
  protected
    function CalculateItemHeight: Integer; override;
    function DrawItemDrawBackgroundHandler(ACanvas: TcxCanvas; const ABounds: TRect): Boolean; virtual; abstract;
    function GetItemEndEllipsis: Boolean; virtual; abstract;
    procedure LookAndFeelChanged(Sender: TcxLookAndFeel; AChangedValues: TcxLookAndFeelValues); override;
    procedure UpdateBackgroundColor;
    //
    property GridView: TcxGridTableView read GetGridView;
    property TextColor: TColor read GetTextColor;
  public
    constructor Create(AOwner: TComponent); override;
    procedure PaintItem(ACanvas: TcxCanvas; R: TRect; AIndex: Integer; AFocused: Boolean); override;
  end;

  TcxGridTableColumnsListBox = class(TcxGridTableItemsListBox)
  protected
    procedure DoRefreshItems; override;
    function DrawItemDrawBackgroundHandler(ACanvas: TcxCanvas; const ABounds: TRect): Boolean; override;
    function GetDragAndDropParams: TcxCustomGridHitTest; override;
    function GetItemEndEllipsis: Boolean; override;
  end;

  TcxGridTableCustomizationForm = class(TcxCustomGridTableCustomizationForm)
  private
    function GetColumnsListBox: TcxGridTableColumnsListBox;
    function GetColumnsPage: TcxTabSheet;
    function GetController: TcxGridTableController;
    function GetGridView: TcxGridTableView;
    function GetViewInfo: TcxGridTableViewInfo;
  protected
    function GetItemsListBoxClass: TcxCustomGridTableItemsListBoxClass; override;
    function GetItemsPageCaption: string; override;

    property ColumnsListBox: TcxGridTableColumnsListBox read GetColumnsListBox;
    property GridView: TcxGridTableView read GetGridView;
    property ViewInfo: TcxGridTableViewInfo read GetViewInfo;
  public
    property Controller: TcxGridTableController read GetController;
    property ColumnsPage: TcxTabSheet read GetColumnsPage;
  end;

  // drag open info

  TcxGridDragOpenInfoMasterDataRowTab = class(TcxGridDragOpenInfoTab)
  public
    GridRow: TcxGridMasterDataRow;
    constructor Create(ALevel: TcxGridLevel; AGridRow: TcxGridMasterDataRow); reintroduce; virtual;
    function Equals(AInfo: TcxCustomGridDragOpenInfo): Boolean; override;
    procedure Run; override;
  end;

  // popup

  TcxGridColumnsCustomizationPopup = class(TcxCustomGridItemsCustomizationPopup)
  private
    function GetGridView: TcxGridTableView;
  protected
    procedure ItemClicked(AItem: TObject; AChecked: Boolean); override;
    procedure SetItemIndex(AItem: TObject; AIndex: Integer); override;
  public
    property GridView: TcxGridTableView read GetGridView;
  end;

  // controllers

  TcxGridTableEditingController = class(TcxGridEditingController)
  private
    FApplyingImmediateFiltering: Boolean;
    function GetController: TcxGridTableController;
    function GetGridView: TcxGridTableView;
  protected
    function CanInitEditing: Boolean; override;
    function CanUpdateEditValue: Boolean; override;
    procedure DoEditChanged; override;
    procedure DoEditKeyDown(var Key: Word; Shift: TShiftState); override;
    function GetHideEditOnFocusedRecordChange: Boolean; override;
    procedure InitEdit; override;
    procedure PostEditingData; override;
    property ApplyingImmediateFiltering: Boolean read FApplyingImmediateFiltering write FApplyingImmediateFiltering;
  public
    property Controller: TcxGridTableController read GetController;
    property GridView: TcxGridTableView read GetGridView;
  end;

  TcxGridTableController = class(TcxCustomGridTableController)
  private
    FCellSelectionAnchor: TcxGridColumn;
    FHorzSizingColumn: TcxGridColumn;
    FIsFilterPopupOpenedFromHeader: Boolean;
    FKeepFilterRowFocusing: Boolean;
    FLeftPos: Integer;
    FPressedColumn: TcxGridColumn;
    FSelectedColumns: TList;

    function GetColumnsCustomizationPopup: TcxGridColumnsCustomizationPopup;
    function GetCustomizationForm: TcxGridTableCustomizationForm;
    function GetEditingController: TcxGridTableEditingController;
    function GetFocusedColumn: TcxGridColumn;
    function GetFocusedColumnIndex: Integer;
    function GetFocusedRow: TcxCustomGridRow;
    function GetFocusedRowIndex: Integer;
    function GetGridView: TcxGridTableView;
    function GetIsColumnHorzSizing: Boolean;
    function GetSelectedColumn(Index: Integer): TcxGridColumn;
    function GetSelectedColumnCount: Integer;
    function GetSelectedRow(Index: Integer): TcxCustomGridRow;
    function GetSelectedRowCount: Integer;
    function GetTopRowIndex: Integer;
    function GetViewData: TcxGridViewData;
    function GetViewInfo: TcxGridTableViewInfo;
    procedure SetFocusedColumn(Value: TcxGridColumn);
    procedure SetFocusedColumnIndex(Value: Integer);
    procedure SetFocusedRow(Value: TcxCustomGridRow);
    procedure SetFocusedRowIndex(Value: Integer);
    procedure SetLeftPos(Value: Integer);
    procedure SetPressedColumn(Value: TcxGridColumn);
    procedure SetTopRowIndex(Value: Integer);

    procedure AddSelectedColumn(AColumn: TcxGridColumn);
    procedure RemoveSelectedColumn(AColumn: TcxGridColumn);
  protected
    function CanAppend(ACheckOptions: Boolean): Boolean; override;
    function CanDelete(ACheckOptions: Boolean): Boolean; override;
    function CanEdit: Boolean; override;
    function CanInsert(ACheckOptions: Boolean): Boolean; override;
    procedure CheckCoordinates; override;
    procedure CheckLeftPos(var Value: Integer);
    procedure FocusedItemChanged(APrevFocusedItem: TcxCustomGridTableItem); override;
    procedure FocusedRecordChanged(APrevFocusedRecordIndex, AFocusedRecordIndex,
      APrevFocusedDataRecordIndex, AFocusedDataRecordIndex: Integer;
      ANewItemRecordFocusingChanged: Boolean); override;
    function GetDesignHitTest(AHitTest: TcxCustomGridHitTest): Boolean; override;
    function GetFocusedRecord: TcxCustomGridRecord; override;
    function GetIsRecordsScrollHorizontal: Boolean; override;
    function GetItemsCustomizationPopupClass: TcxCustomGridItemsCustomizationPopupClass; override;
    function GetMaxTopRecordIndexValue: Integer; override;
    function GetMouseWheelScrollingKind: TcxMouseWheelScrollingKind; override;
    function GetScrollBarRecordCount: Integer; override;
    function IsColumnFixedDuringHorzSizing(AColumn: TcxGridColumn): Boolean; virtual;
    function IsKeyForMultiSelect(AKey: Word; AShift: TShiftState;
      AFocusedRecordChanged: Boolean): Boolean; override;
    function IsPixelScrollBar(AKind: TScrollBarKind): Boolean; override;
    procedure LeftPosChanged; virtual;
    function NeedsAdditionalRowsScrolling(AIsCallFromMaster: Boolean = False): Boolean; virtual;
    procedure RemoveFocus; override;
    procedure ScrollData(ADirection: TcxDirection); override;
    procedure SetFocusedRecord(Value: TcxCustomGridRecord); override;
    procedure ShowNextPage; override;
    procedure ShowPrevPage; override;

    // internal draganddrop data scrolling
    function CanScrollData(ADirection: TcxDirection): Boolean; override;

    // selection
    function CanPostponeRecordSelection(AShift: TShiftState): Boolean; override;
    function CanProcessMultiSelect(AHitTest: TcxCustomGridHitTest;
      AShift: TShiftState): Boolean; override;
    procedure DoMouseNormalSelection(AHitTest: TcxCustomGridHitTest); override;
    procedure DoMouseRangeSelection(AClearSelection: Boolean = True; AData: TObject = nil); override;
    procedure DoNormalSelection; override;
    procedure MultiSelectKeyDown(var Key: Word; Shift: TShiftState); override;
    function SupportsAdditiveSelection: Boolean; override;
    function SupportsRecordSelectionToggling: Boolean; override;

    // special row focusing
    function DefocusSpecialRow: Boolean; virtual;
    function FocusSpecialRow: Boolean; virtual;
    procedure FilterRowFocusChanged; virtual;
    procedure FilterRowFocusChanging(AValue: Boolean); virtual;

    // pull focusing
    procedure DoPullFocusingScrolling(ADirection: TcxDirection); override;
    function GetPullFocusingScrollingDirection(X, Y: Integer; out ADirection: TcxDirection): Boolean; override;
    function SupportsPullFocusing: Boolean; override;

    // delphi drag and drop
    function GetDragOpenInfo(AHitTest: TcxCustomGridHitTest): TcxCustomGridDragOpenInfo; override;
    function GetDragScrollDirection(X, Y: Integer): TcxDirection; override;

    // customization
    procedure CheckCustomizationFormBounds(var R: TRect); override;
    function GetColumnHeaderDragAndDropObjectClass: TcxGridColumnHeaderMovingObjectClass; virtual;
    function GetCustomizationFormClass: TcxCustomGridCustomizationFormClass; override;

    // cells selection
    function CanProcessCellMultiSelect(APrevFocusedColumn: TcxGridColumn): Boolean; virtual;
    procedure CellMultiSelectKeyDown(var Key: Word; Shift: TShiftState); virtual;
    procedure DoNormalCellSelection;
    procedure DoRangeCellSelection;
    function GetCellMultiSelect: Boolean; virtual;
    property CellMultiSelect: Boolean read GetCellMultiSelect;

    // BeginsWith mask
    procedure AddBeginsWithMask(var AValue: Variant);
    procedure RemoveBeginsWithMask(var AValue: Variant);
    function GetBeginsWithMaskPos(const AValue: string): Integer;

    function GetEditingControllerClass: TcxGridEditingControllerClass; override;

    property IsFilterPopupOpenedFromHeader: Boolean read FIsFilterPopupOpenedFromHeader
      write FIsFilterPopupOpenedFromHeader;
    property KeepFilterRowFocusing: Boolean read FKeepFilterRowFocusing write FKeepFilterRowFocusing;
    property ViewData: TcxGridViewData read GetViewData;
    property ViewInfo: TcxGridTableViewInfo read GetViewInfo;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    destructor Destroy; override;
    procedure CheckScrolling(const P: TPoint); override;
    procedure ClearGrouping;
    procedure ClearSelection; override;
    procedure DoCancelMode; override;
    function IsFilterRowFocused: Boolean;
    function IsNewItemRowFocused: Boolean;
    function IsSpecialRowFocused: Boolean; virtual;
    procedure MakeItemVisible(AItem: TcxCustomGridTableItem); override;
    procedure SelectAll; override;

    procedure InitScrollBarsParameters; override;
    function IsDataFullyVisible(AIsCallFromMaster: Boolean = False): Boolean; override;
    procedure Scroll(AScrollBarKind: TScrollBarKind; AScrollCode: TScrollCode;
      var AScrollPos: Integer); override;

    procedure EndDragAndDrop(Accepted: Boolean); override;

    procedure DoKeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;

    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    // cells selection
    procedure ClearCellSelection;
    procedure SelectAllColumns;
    procedure SelectCells(AFromColumn, AToColumn: TcxGridColumn;
      AFromRowIndex, AToRowIndex: Integer);
    procedure SelectColumns(AFromColumn, AToColumn: TcxGridColumn);

    property CellSelectionAnchor: TcxGridColumn read FCellSelectionAnchor write FCellSelectionAnchor;
    property ColumnsCustomizationPopup: TcxGridColumnsCustomizationPopup read GetColumnsCustomizationPopup;
    property CustomizationForm: TcxGridTableCustomizationForm read GetCustomizationForm;
    property EditingController: TcxGridTableEditingController read GetEditingController;
    property FocusedColumn: TcxGridColumn read GetFocusedColumn write SetFocusedColumn;
    property FocusedColumnIndex: Integer read GetFocusedColumnIndex write SetFocusedColumnIndex;
    property FocusedRow: TcxCustomGridRow read GetFocusedRow write SetFocusedRow;
    property FocusedRowIndex: Integer read GetFocusedRowIndex write SetFocusedRowIndex;
    property GridView: TcxGridTableView read GetGridView;
    property HorzSizingColumn: TcxGridColumn read FHorzSizingColumn;
    property IsColumnHorzSizing: Boolean read GetIsColumnHorzSizing;
    property LeftPos: Integer read FLeftPos write SetLeftPos;
    property PressedColumn: TcxGridColumn read FPressedColumn write SetPressedColumn;
    property SelectedColumnCount: Integer read GetSelectedColumnCount;
    property SelectedColumns[Index: Integer]: TcxGridColumn read GetSelectedColumn;
    property SelectedRowCount: Integer read GetSelectedRowCount;
    property SelectedRows[Index: Integer]: TcxCustomGridRow read GetSelectedRow;
    property TopRowIndex: Integer read GetTopRowIndex write SetTopRowIndex;
  end;

  { painters }

  // column container

  TcxGridColumnContainerPainter = class(TcxCustomGridPartPainter)
  private
    function GetViewInfo: TcxGridColumnContainerViewInfo;
  protected
    procedure DrawContent; override;
    procedure DrawItems; virtual;
    function DrawItemsFirst: Boolean; virtual;
    function ExcludeFromClipRect: Boolean; override;
    property ViewInfo: TcxGridColumnContainerViewInfo read GetViewInfo;
  end;

  // header

  TcxGridColumnHeaderAreaPainter = class(TcxCustomGridCellPainter)
  private
    function GetViewInfo: TcxGridColumnHeaderAreaViewInfo;
  protected
    function ExcludeFromClipRect: Boolean; override;
    property ViewInfo: TcxGridColumnHeaderAreaViewInfo read GetViewInfo;
  end;

  TcxGridColumnHeaderSortingMarkPainter = class(TcxGridColumnHeaderAreaPainter)
  protected
    procedure Paint; override;
  end;

  TcxGridColumnHeaderFilterButtonPainter = class(TcxGridColumnHeaderAreaPainter)
  private
    function GetViewInfo: TcxGridColumnHeaderFilterButtonViewInfo;
  protected
    procedure Paint; override;
    property ViewInfo: TcxGridColumnHeaderFilterButtonViewInfo read GetViewInfo;
  end;

  TcxGridColumnHeaderGlyphPainter = class(TcxGridColumnHeaderAreaPainter)
  private
    function GetViewInfo: TcxGridColumnHeaderGlyphViewInfo;
  protected
    procedure Paint; override;
    property ViewInfo: TcxGridColumnHeaderGlyphViewInfo read GetViewInfo;
  end;

  TcxGridColumnHeaderPainter = class(TcxCustomGridCellPainter)
  private
    function GetViewInfo: TcxGridColumnHeaderViewInfo;
  protected
    procedure DrawAreas; virtual;
    procedure DrawBorders; override;
    procedure DrawContent; override;
    procedure DrawPressed; virtual;
    function ExcludeFromClipRect: Boolean; override;
    procedure Paint; override;
    property ViewInfo: TcxGridColumnHeaderViewInfo read GetViewInfo;
  end;

  TcxGridHeaderPainter = class(TcxGridColumnContainerPainter)
  protected
    function DrawItemsFirst: Boolean; override;
  end;

  // group by box

  TcxGridGroupByBoxPainter = class(TcxGridColumnContainerPainter)
  protected
    procedure DrawBackground(const R: TRect); override;
    procedure DrawContent; override;
    function DrawItemsFirst: Boolean; override;
  end;

  // footer

  TcxGridFooterCellPainter = class(TcxGridColumnHeaderPainter)
  protected
    procedure DrawBorders; override;
    procedure DrawContent; override;
  end;

  TcxGridFooterPainterClass = class of TcxGridFooterPainter;

  TcxGridFooterPainter = class(TcxGridColumnContainerPainter)
  private
    function GetViewInfo: TcxGridFooterViewInfo;
  protected
    procedure DrawBackground(const R: TRect); override;
    procedure DrawBorders; override;
    function DrawItemsFirst: Boolean; override;
    procedure DrawSeparator; virtual;
    property ViewInfo: TcxGridFooterViewInfo read GetViewInfo;
  end;

  // indicator

  TcxCustomGridIndicatorItemPainter = class(TcxCustomGridCellPainter)
  private
    function GetViewInfo: TcxCustomGridIndicatorItemViewInfo;
  protected
    function ExcludeFromClipRect: Boolean; override;
    property ViewInfo: TcxCustomGridIndicatorItemViewInfo read GetViewInfo;
  end;

  TcxGridIndicatorHeaderItemPainter = class(TcxCustomGridIndicatorItemPainter)
  private
    function GetViewInfo: TcxGridIndicatorHeaderItemViewInfo;
  protected
    function DrawBackgroundHandler(ACanvas: TcxCanvas; const ABounds: TRect): Boolean; override;
    procedure DrawContent; override;
    procedure DrawQuickCustomizationMark; virtual;
    property ViewInfo: TcxGridIndicatorHeaderItemViewInfo read GetViewInfo;
  end;

  TcxGridIndicatorRowItemPainter = class(TcxCustomGridIndicatorItemPainter)
  private
    function GetViewInfo: TcxGridIndicatorRowItemViewInfo;
  protected
    procedure DrawContent; override;
    property ViewInfo: TcxGridIndicatorRowItemViewInfo read GetViewInfo;
  end;

  TcxGridIndicatorFooterItemPainter = class(TcxCustomGridIndicatorItemPainter)
  private
    function GetViewInfo: TcxGridIndicatorFooterItemViewInfo;
  protected
    procedure DrawContent; override; 
    procedure DrawBorders; override;
    property ViewInfo: TcxGridIndicatorFooterItemViewInfo read GetViewInfo;
  end;

  TcxGridIndicatorPainter = class(TcxCustomGridCellPainter)
  private
    function GetViewInfo: TcxGridIndicatorViewInfo;
  protected
    procedure DrawContent; override;
    procedure DrawItems; virtual;
    function DrawItemsFirst: Boolean; virtual;
    function ExcludeFromClipRect: Boolean; override;
    property ViewInfo: TcxGridIndicatorViewInfo read GetViewInfo;
  end;

  // custom row

  TcxCustomGridRowPainter = class(TcxCustomGridRecordPainter)
  private
    function GetViewInfo: TcxCustomGridRowViewInfo;
  protected
    procedure DrawFooters; virtual;
    procedure DrawIndent; virtual;
    procedure DrawIndentPart(ALevel: Integer; const ABounds: TRect); virtual;
    procedure DrawLastHorzGridLine; virtual;
    procedure DrawSeparator; virtual;
    procedure Paint; override;
    property ViewInfo: TcxCustomGridRowViewInfo read GetViewInfo;
  end;

  // rows

  TcxGridRowsPainterClass = class of TcxGridRowsPainter;

  TcxGridRowsPainter = class(TcxCustomGridRecordsPainter)
  private
    function GetViewInfo: TcxGridRowsViewInfo;
  protected
    procedure Paint; override;
    property ViewInfo: TcxGridRowsViewInfo read GetViewInfo;
  public
    class procedure DrawDataRowCells(ARowViewInfo: TcxCustomGridRowViewInfo); virtual;
  end;

  // table

  TcxGridTablePainter = class(TcxCustomGridTablePainter)
  private
    FGridLines: TList;
    function GetController: TcxGridTableController;
    function GetGridView: TcxGridTableView;
    function GetViewInfo: TcxGridTableViewInfo;
  protected
    function CanOffset(AItemsOffset, DX, DY: Integer): Boolean; override;
    procedure DrawFooter; virtual;
    procedure DrawGroupByBox; virtual;
    procedure DrawHeader; virtual;
    procedure DrawIndicator; virtual;
    procedure DrawRecords; override;
    procedure Offset(AItemsOffset: Integer); override;
    procedure Offset(DX, DY: Integer); override;
    procedure PaintContent; override;
  public
    procedure AddGridLine(const R: TRect);
    property Controller: TcxGridTableController read GetController;
    property GridView: TcxGridTableView read GetGridView;
    property ViewInfo: TcxGridTableViewInfo read GetViewInfo;
  end;

  { view infos }

  // column container

  TcxGridColumnContainerViewInfo = class(TcxCustomGridPartViewInfo)
  private
    FItemHeight: Integer;
    FItems: TList;
    function GetController: TcxGridTableController;
    function GetCount: Integer;
    function GetGridView: TcxGridTableView;
    function GetGridViewInfo: TcxGridTableViewInfo;
    function GetInternalItem(Index: Integer): TcxGridColumnHeaderViewInfo;
    function GetItem(Index: Integer): TcxGridColumnHeaderViewInfo;
    function GetItemHeight: Integer;
  protected
    function CreateItem(AIndex: Integer): TcxGridColumnHeaderViewInfo; virtual;
    procedure CreateItems; virtual;
    procedure DestroyItems; virtual;
    function GetColumn(Index: Integer): TcxGridColumn; virtual; abstract;
    function GetColumnCount: Integer; virtual; abstract;
    function GetItemClass: TcxGridColumnHeaderViewInfoClass; virtual;

    function CalculateItemHeight: Integer; virtual;
    function GetAutoHeight: Boolean; virtual;
    function GetColumnAdditionalWidth(AColumn: TcxGridColumn): Integer;
    function GetColumnMinWidth(AColumn: TcxGridColumn): Integer; virtual;
    function GetColumnNeighbors(AColumn: TcxGridColumn): TcxNeighbors; virtual;
    function GetColumnWidth(AColumn: TcxGridColumn): Integer; virtual;
    function GetItemAreaBounds(AItem: TcxGridColumnHeaderViewInfo): TRect; virtual;
    function GetItemMultiLinePainting(AItem: TcxGridColumnHeaderViewInfo): Boolean; virtual;
    function GetItemsAreaBounds: TRect; virtual;
    function GetItemsHitTest(const P: TPoint): TcxCustomGridHitTest; virtual;
    function GetKind: TcxGridColumnContainerKind; virtual; abstract;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetZonesAreaBounds: TRect; virtual;
    procedure InitHitTest(AHitTest: TcxCustomGridHitTest); override;
    procedure Offset(DX, DY: Integer); override;

    property AutoHeight: Boolean read GetAutoHeight;
    property ColumnCount: Integer read GetColumnCount;
    property Columns[Index: Integer]: TcxGridColumn read GetColumn;
    property Controller: TcxGridTableController read GetController;
    property ZonesAreaBounds: TRect read GetZonesAreaBounds;
  public
    constructor Create(AGridViewInfo: TcxCustomGridTableViewInfo); override;
    destructor Destroy; override;
    procedure BeforeRecalculation; override;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; override;
    function GetZone(const P: TPoint): TcxGridItemContainerZone; virtual;
    property Count: Integer read GetCount;
    property GridView: TcxGridTableView read GetGridView;
    property GridViewInfo: TcxGridTableViewInfo read GetGridViewInfo;
    property InternalItems[Index: Integer]: TcxGridColumnHeaderViewInfo read GetInternalItem;
    property ItemHeight: Integer read GetItemHeight;
    property Items[Index: Integer]: TcxGridColumnHeaderViewInfo read GetItem; default;
    property ItemsAreaBounds: TRect read GetItemsAreaBounds;
    property Kind: TcxGridColumnContainerKind read GetKind;
  end;

  // column header areas

  TcxGridColumnHeaderAreaViewInfo = class(TcxCustomGridViewCellViewInfo)
  private
    FColumnHeaderViewInfo: TcxGridColumnHeaderViewInfo;
    function GetColumn: TcxGridColumn;
    function GetGridView: TcxGridTableView;
    function GetGridViewInfo: TcxGridTableViewInfo;
  protected
    function GetAlignmentVert: TcxAlignmentVert; override;
    function GetCanvas: TcxCanvas; override;
    function GetHeight: Integer; override;
    function GetWidth: Integer; override;
    function HasMouse(AHitTest: TcxCustomGridHitTest): Boolean; override;
    procedure InitHitTest(AHitTest: TcxCustomGridHitTest); override;
    //procedure Invalidate; virtual;
    function NeedsContainerHotTrack: Boolean; virtual;
    function OccupiesSpace: Boolean; virtual;
    function ResidesInContent: Boolean; virtual;

    property Column: TcxGridColumn read GetColumn;
    property GridView: TcxGridTableView read GetGridView;
    property GridViewInfo: TcxGridTableViewInfo read GetGridViewInfo;
  public
    constructor Create(AColumnHeaderViewInfo: TcxGridColumnHeaderViewInfo); reintroduce; virtual;
    procedure Calculate(const ABounds: TRect; var ATextAreaBounds: TRect); reintroduce; virtual;
    property AlignmentHorz: TAlignment read GetAlignmentHorz;
    property AlignmentVert: TcxAlignmentVert read GetAlignmentVert;
    property ColumnHeaderViewInfo: TcxGridColumnHeaderViewInfo read FColumnHeaderViewInfo;
    property Height: Integer read GetHeight;
    property Width: Integer read GetWidth;
  end;

  TcxGridColumnHeaderSortingMarkViewInfo = class(TcxGridColumnHeaderAreaViewInfo)
  private
    function GetSortOrder: TcxGridSortOrder;
  protected
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function GetAlignmentHorz: TAlignment; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    property SortOrder: TcxGridSortOrder read GetSortOrder;
  end;

  TcxGridColumnHeaderHorzSizingEdgeViewInfo = class(TcxGridColumnHeaderAreaViewInfo)
  protected
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function GetAlignmentHorz: TAlignment; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function OccupiesSpace: Boolean; override;
    function ResidesInContent: Boolean; override;
  public
    procedure Calculate(const ABounds: TRect; var ATextAreaBounds: TRect); override;
    function MouseDown(AHitTest: TcxCustomGridHitTest; AButton: TMouseButton;
      AShift: TShiftState): Boolean; override;
  end;

  TcxGridColumnHeaderFilterButtonViewInfo = class(TcxGridColumnHeaderAreaViewInfo,
    IcxGridFilterPopupOwner)
  private
    function GetActive: Boolean;
    function GetDropDownWindowValue: TcxGridFilterPopup;
  protected
    { IcxGridFilterPopupOwner }
    function GetItem: TcxCustomGridTableItem;

    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    procedure DropDown; override;
    function EmulateMouseMoveAfterCalculate: Boolean; override;
    function GetAlignmentHorz: TAlignment; override;
    function GetAlwaysVisible: Boolean; virtual;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetVisible: Boolean; override;
    function NeedsContainerHotTrack: Boolean; override;
    function OccupiesSpace: Boolean; override;
    procedure StateChanged(APrevState: TcxGridCellState); override;

    function CloseDropDownWindowOnDestruction: Boolean; override;
    function DropDownWindowExists: Boolean; override;
    function GetDropDownWindow: TcxCustomGridPopup; override;
    function GetDropDownWindowOwnerBounds: TRect; override;
    function IsDropDownWindowOwner: Boolean; override;
    property DropDownWindow: TcxGridFilterPopup read GetDropDownWindowValue;

    property AlwaysVisible: Boolean read GetAlwaysVisible;
  public
    function MouseMove(AHitTest: TcxCustomGridHitTest; AShift: TShiftState): Boolean; override;
    property Active: Boolean read GetActive;
  end;

  TcxGridColumnHeaderGlyphViewInfo = class(TcxGridColumnHeaderAreaViewInfo)
  private
    function GetGlyph: TBitmap;
  protected
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function GetAlignmentHorz: TAlignment; override;
    function GetAlignmentVert: TcxAlignmentVert; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
  public
    property Glyph: TBitmap read GetGlyph;
  end;

  // column header

  TcxGridColumnHeaderViewInfo = class(TcxCustomGridViewCellViewInfo)
  private
    FAdditionalHeightAtTop: Integer;
    FAdditionalWidthAtLeft: Integer;
    FAreaViewInfos: TList;
    FColumn: TcxGridColumn;
    FContainer: TcxGridColumnContainerViewInfo;
    FNeighbors: TcxNeighbors;
    FRealWidth: Integer;
    FTextAreaBounds: TRect;
    FWidth: Integer;

    function GetAreaViewInfoCount: Integer;
    function GetAreaViewInfo(Index: Integer): TcxGridColumnHeaderAreaViewInfo;
    function GetGridView: TcxGridTableView;
    function GetGridViewInfo: TcxGridTableViewInfo;
    function GetHasTextOffsetLeft: Boolean;
    function GetHasTextOffsetRight: Boolean;
    function GetIndex: Integer;
    function GetIsFixed: Boolean;
    function GetRealWidth: Integer;

    procedure EnumAreaViewInfoClasses(AClass: TClass);
    procedure CreateAreaViewInfos;
    procedure DestroyAreaViewInfos;
  protected
    function AreasNeedHotTrack: Boolean;
    function CalculateHasTextOffset(ASide: TAlignment): Boolean; virtual;
    function CalculateHeight: Integer; override;
    function CalculateRealWidth(Value: Integer): Integer;
    procedure CalculateTextAreaBounds; virtual;
    procedure CalculateVisible(ALeftBound, AWidth: Integer); virtual;
    function CalculateWidth: Integer; override;
    function CanFilter: Boolean; virtual;
    function CanHorzSize: Boolean; virtual;
    function CanPress: Boolean; virtual;
    function CanShowHint: Boolean; override;
    function CanSort: Boolean; virtual;
    procedure CheckWidth(var Value: Integer); virtual;
    function CustomDraw(ACanvas: TcxCanvas): Boolean; override;
    procedure DoCalculateParams; override;
    function GetAlignmentHorz: TAlignment; override;
    function GetAlignmentVert: TcxAlignmentVert; override;
    function GetAreaBounds: TRect; override;
    procedure GetAreaViewInfoClasses(AProc: TcxGridClassEnumeratorProc); virtual;
    function GetBackgroundBitmap: TBitmap; override;
    function GetBorders: TcxBorders; override;
    function GetBorderWidth(AIndex: TcxBorder): Integer; override;
    function GetCanvas: TcxCanvas; override;
    function GetCaption: string; virtual;
    class function GetCellBorderWidth(ALookAndFeelPainter: TcxCustomLookAndFeelPainterClass): Integer; virtual;
    class function GetCellHeight(ATextHeight: Integer;
      ALookAndFeelPainter: TcxCustomLookAndFeelPainterClass): Integer; override;
    function GetDataOffset: Integer; virtual;
    function GetHeight: Integer; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetHotTrack: Boolean; override;
    function GetIsDesignSelected: Boolean; override;
    function GetIsPressed: Boolean; virtual;
    function GetMaxWidth: Integer; virtual;
    function GetMinWidth: Integer; virtual;
    function GetMultiLine: Boolean; override;
    function GetMultiLinePainting: Boolean; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetRealBounds: TRect; override;
    function GetShowEndEllipsis: Boolean; override;
    function GetText: string; override;
    function GetTextAreaBounds: TRect; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function GetWidth: Integer; override;
    function HasCustomDraw: Boolean; override;
    function HasFixedContentSpace: Boolean; virtual;
    function HasGlyph: Boolean; virtual;
    function HasHeaderAsContainer: Boolean;
    procedure InitHitTest(AHitTest: TcxCustomGridHitTest); override;
    procedure Offset(DX, DY: Integer); override;
    procedure SetWidth(Value: Integer); override;
    procedure StateChanged(APrevState: TcxGridCellState); override;

    property Caption: string read GetCaption;
    property GridView: TcxGridTableView read GetGridView;
    property GridViewInfo: TcxGridTableViewInfo read GetGridViewInfo;
    property HasTextOffsetLeft: Boolean read GetHasTextOffsetLeft;
    property HasTextOffsetRight: Boolean read GetHasTextOffsetRight;
  public
    constructor Create(AContainer: TcxGridColumnContainerViewInfo;
      AColumn: TcxGridColumn); reintroduce; virtual;
    destructor Destroy; override;
    procedure Calculate(ALeftBound, ATopBound: Integer; AWidth: Integer = -1;
      AHeight: Integer = -1); override;
    function GetBestFitWidth: Integer; override;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; override;
    procedure InitAutoWidthItem(AAutoWidthItem: TcxAutoWidthItem);
    function MouseDown(AHitTest: TcxCustomGridHitTest; AButton: TMouseButton;
      AShift: TShiftState): Boolean; override;

    property AreaViewInfoCount: Integer read GetAreaViewInfoCount;
    property AreaViewInfos[Index: Integer]: TcxGridColumnHeaderAreaViewInfo read GetAreaViewInfo;
    property Column: TcxGridColumn read FColumn;
    property Container: TcxGridColumnContainerViewInfo read FContainer;
    property DataOffset: Integer read GetDataOffset;
    property Index: Integer read GetIndex;
    property IsFixed: Boolean read GetIsFixed;
    property IsPressed: Boolean read GetIsPressed;
    property MaxWidth: Integer read GetMaxWidth;
    property MinWidth: Integer read GetMinWidth;
    property Neighbors: TcxNeighbors read FNeighbors write FNeighbors;
    property RealWidth: Integer read GetRealWidth;
  end;

  // header

  TcxGridHeaderViewInfoSpecificClass = class of TcxGridHeaderViewInfoSpecific;

  TcxGridHeaderViewInfoSpecific = class
  private
    FContainerViewInfo: TcxGridHeaderViewInfo;
    function GetGridViewInfo: TcxGridTableViewInfo;
    function GetItemHeight: Integer;
  protected
    function CalculateHeight: Integer; virtual;
    function GetHeight: Integer; virtual;
  public
    constructor Create(AContainerViewInfo: TcxGridHeaderViewInfo); virtual;
    property ContainerViewInfo: TcxGridHeaderViewInfo read FContainerViewInfo;
    property GridViewInfo: TcxGridTableViewInfo read GetGridViewInfo;
    property Height: Integer read GetHeight;
    property ItemHeight: Integer read GetItemHeight;
  end;

  TcxGridHeaderViewInfoClass = class of TcxGridHeaderViewInfo;

  TcxGridHeaderViewInfo = class(TcxGridColumnContainerViewInfo)
  private
    FSpecific: TcxGridHeaderViewInfoSpecific;
  protected
    function GetColumn(Index: Integer): TcxGridColumn; override;
    function GetColumnCount: Integer; override;

    procedure AddIndicatorItems(AIndicatorViewInfo: TcxGridIndicatorViewInfo; ATopBound: Integer); virtual;
    procedure CalculateColumnAutoWidths; virtual;
    procedure CalculateColumnWidths; virtual;
    function CalculateHeight: Integer; override;
    procedure CalculateInvisible; override;
    function CalculateItemHeight: Integer; override;
    procedure CalculateItems; virtual;
    procedure CalculateVisible; override;
    function CalculateWidth: Integer; override;
    function CanCalculateAutoWidths: Boolean; virtual;
    function DrawColumnBackgroundHandler(ACanvas: TcxCanvas; const ABounds: TRect): Boolean; virtual;
    function GetAlignment: TcxGridPartAlignment; override;
    function GetAutoHeight: Boolean; override;
    function GetColumnBackgroundBitmap: TBitmap; virtual;
    function GetColumnNeighbors(AColumn: TcxGridColumn): TcxNeighbors; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetIsAutoWidth: Boolean; override;
    function GetIsScrollable: Boolean; override;
    function GetItemMultiLinePainting(AItem: TcxGridColumnHeaderViewInfo): Boolean; override;
    function GetKind: TcxGridColumnContainerKind; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function GetVisible: Boolean; override;
    function GetWidth: Integer; override;
    function GetZonesAreaBounds: TRect; override;
    function IsAlwaysVisibleForCalculation: Boolean; virtual;
    function IsHeightAssigned: Boolean; virtual;
    procedure Offset(DX, DY: Integer); override;
    procedure RecalculateItemVisibles;

    property ColumnBackgroundBitmap: TBitmap read GetColumnBackgroundBitmap;
  public
    constructor Create(AGridViewInfo: TcxCustomGridTableViewInfo); override;
    destructor Destroy; override;
    procedure AssignColumnWidths;
    procedure Calculate(ALeftBound, ATopBound: Integer; AWidth: Integer = -1;
      AHeight: Integer = -1); override;
    property Specific: TcxGridHeaderViewInfoSpecific read FSpecific;
  end;

  // group by box

  TcxGridGroupByBoxColumnHeaderViewInfo = class(TcxGridColumnHeaderViewInfo)
  private
    function GetContainer: TcxGridGroupByBoxViewInfo;
  protected
    function CalculateHeight: Integer; override;
    function GetCaption: string; override;
    function HasFixedContentSpace: Boolean; override;
    function InheritedCalculateHeight: Integer;
  public
    property Container: TcxGridGroupByBoxViewInfo read GetContainer;
  end;

  TcxGridGroupByBoxViewInfoClass = class of TcxGridGroupByBoxViewInfo;

  TcxGridGroupByBoxViewInfo = class(TcxGridColumnContainerViewInfo)
  private
    FCalculatingColumnWidth: Boolean;
    function GetGroupByBoxVerOffset: Integer;
    function GetLinkLineBounds(Index: Integer; Horizontal: Boolean): TRect;
  protected
    function GetColumn(Index: Integer): TcxGridColumn; override;
    function GetColumnCount: Integer; override;
    function GetItemClass: TcxGridColumnHeaderViewInfoClass; override;

    function CalculateHeight: Integer; override;
    function CalculateItemHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function GetAlignment: TcxGridPartAlignment; override;
    function GetAlignmentVert: TcxAlignmentVert; override;
    function GetBackgroundBitmap: TBitmap; override;
    function GetColumnWidth(AColumn: TcxGridColumn): Integer; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetIsAutoWidth: Boolean; override;
    function GetIsScrollable: Boolean; override;
    function GetItemAreaBounds(AItem: TcxGridColumnHeaderViewInfo): TRect; override;
    function GetKind: TcxGridColumnContainerKind; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetText: string; override;
    function GetTextAreaBounds: TRect; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function GetVisible: Boolean; override;

    property CalculatingColumnWidth: Boolean read FCalculatingColumnWidth;
    property GroupByBoxVerOffset: Integer read GetGroupByBoxVerOffset;
  public
    procedure Calculate(ALeftBound, ATopBound: Integer; AWidth: Integer = -1;
      AHeight: Integer = -1); override;
    property LinkLineBounds[Index: Integer; Horizontal: Boolean]: TRect read GetLinkLineBounds;
  end;

  // footer

  TcxGridFooterCellViewInfoClass = class of TcxGridFooterCellViewInfo;

  TcxGridFooterCellViewInfo = class(TcxGridColumnHeaderViewInfo)
  private
    FSummaryItem: TcxDataSummaryItem;
    function GetContainer: TcxGridFooterViewInfo;
    function GetSummary: TcxDataSummary;
  protected
    procedure AfterCalculateBounds(var ABounds: TRect); override;
    function CanPress: Boolean; override;
    function CustomDraw(ACanvas: TcxCanvas): Boolean; override;
    function GetAlignmentHorz: TAlignment; override;
    function GetBackgroundBitmap: TBitmap; override;
    procedure GetAreaViewInfoClasses(AProc: TcxGridClassEnumeratorProc); override;
    function GetBorders: TcxBorders; override;
    class function GetCellBorderWidth(ALookAndFeelPainter: TcxCustomLookAndFeelPainterClass): Integer; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetIsDesignSelected: Boolean; override;
    function GetIsPressed: Boolean; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetText: string; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function HasCustomDraw: Boolean; override;
    procedure InitHitTest(AHitTest: TcxCustomGridHitTest); override;
    property Summary: TcxDataSummary read GetSummary;
  public
    constructor Create(AContainer: TcxGridColumnContainerViewInfo;
      ASummaryItem: TcxDataSummaryItem); reintroduce; virtual;
    function GetBestFitWidth: Integer; override;
    function MouseDown(AHitTest: TcxCustomGridHitTest; AButton: TMouseButton;
      AShift: TShiftState): Boolean; override;
    property Container: TcxGridFooterViewInfo read GetContainer;
    property SummaryItem: TcxDataSummaryItem read FSummaryItem;
  end;

  TcxGridFooterViewInfoClass = class of TcxGridFooterViewInfo;

  TcxGridFooterViewInfo = class(TcxGridHeaderViewInfo)
  private
    FRowCount: Integer;
    FSummaryItems: TList;
    function GetMultipleSummaries: Boolean;
    function GetRowCount: Integer;
    function GetRowHeight: Integer;
  protected
    function CreateItem(AIndex: Integer): TcxGridColumnHeaderViewInfo; override;
    procedure CreateItems; override;
    procedure DestroyItems; override;
    function GetColumn(Index: Integer): TcxGridColumn; override;
    function GetColumnCount: Integer; override;
    function GetItemClass: TcxGridColumnHeaderViewInfoClass; override;
    procedure PrepareSummaryItems(ASummaryItems: TList); virtual;

    function CalculateBounds: TRect; override;
    function CalculateHeight: Integer; override;
    function CalculateItemHeight: Integer; override;
    procedure CalculateItem(AIndex: Integer); virtual;
    procedure CalculateItems; override;
    function CalculateRowCount: Integer; virtual;
    function CanCalculateAutoWidths: Boolean; override;
    function GetAlignment: TcxGridPartAlignment; override;
    function GetAutoHeight: Boolean; override;
    function GetBackgroundBitmap: TBitmap; override;
    function GetBordersBounds: TRect; virtual;
    function GetBorders: TcxBorders; override;
    function GetBorderWidth(AIndex: TcxBorder): Integer; override;
    function GetColumnWidth(AColumn: TcxGridColumn): Integer; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetIsAutoWidth: Boolean; override;
    function GetIsScrollable: Boolean; override;
    function GetItemAreaBounds(AItem: TcxGridColumnHeaderViewInfo): TRect; override;
    function GetItemHeight(AColumn: TcxGridColumn): Integer; overload; virtual;
    function GetItemHeight(AIndex: Integer): Integer; overload;
    function GetItemHitTestClass: TcxCustomGridHitTestClass; virtual;
    function GetItemLeftBound(AColumn: TcxGridColumn): Integer; overload; virtual;
    function GetItemLeftBound(AIndex: Integer): Integer; overload;
    function GetItemRowIndex(AIndex: Integer): Integer; virtual;
    function GetItemsAreaBounds: TRect; override;
    function GetItemTopBound(AColumn: TcxGridColumn): Integer; overload; virtual;
    function GetItemTopBound(AIndex: Integer): Integer; overload; virtual;
    function GetKind: TcxGridColumnContainerKind; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetSeparatorBounds: TRect; virtual;
    function GetSeparatorWidth: Integer; virtual;
    function GetSummaryItems: TcxDataSummaryItems; virtual;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function GetVisible: Boolean; override;
    function HasSeparator: Boolean; virtual;
    function IsAlwaysVisibleForCalculation: Boolean; override;
    function IsColumnOnFirstLayer(AColumnIndex: Integer): Boolean; virtual;
    function IsHeightAssigned: Boolean; override;
    function IsItemVisible(AIndex: Integer): Boolean; virtual;
    function IsMultilayerLayout: Boolean; virtual;
    procedure Offset(DX, DY: Integer); override;

    property SummaryItemsList: TList read FSummaryItems;
  public
    function CanShowMultipleSummaries: Boolean; virtual;
    function GetCellBestFitWidth(AColumn: TcxGridColumn): Integer; virtual;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; override;

    property BordersBounds: TRect read GetBordersBounds;
    property MultipleSummaries: Boolean read GetMultipleSummaries;
    property RowCount: Integer read GetRowCount;
    property RowHeight: Integer read GetRowHeight;
    property SeparatorBounds: TRect read GetSeparatorBounds;
    property SeparatorWidth: Integer read GetSeparatorWidth;
    property SummaryItems: TcxDataSummaryItems read GetSummaryItems;
  end;

  // indicator

  TcxCustomGridIndicatorItemViewInfoClass = class of TcxCustomGridIndicatorItemViewInfo;

  TcxCustomGridIndicatorItemViewInfo = class(TcxCustomGridViewCellViewInfo)
  private
    FContainer: TcxGridIndicatorViewInfo;
    function GetGridView: TcxGridTableView;
    function GetGridViewInfo: TcxGridTableViewInfo;
  protected
    function CalculateWidth: Integer; override;
    function CustomDraw(ACanvas: TcxCanvas): Boolean; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function HasCustomDraw: Boolean; override;
  public
    constructor Create(AContainer: TcxGridIndicatorViewInfo); reintroduce; virtual;
    destructor Destroy; override;
    property Container: TcxGridIndicatorViewInfo read FContainer;
    property GridView: TcxGridTableView read GetGridView;
    property GridViewInfo: TcxGridTableViewInfo read GetGridViewInfo;
  end;

  TcxGridIndicatorHeaderItemViewInfo = class(TcxCustomGridIndicatorItemViewInfo)
  private
    function GetDropDownWindowValue: TcxCustomGridCustomizationPopup;
  protected
    function CalculateHeight: Integer; override;
    function CanShowHint: Boolean; override;
    function GetCellBoundsForHint: TRect; override;
    function GetHintTextRect(const AMousePos: TPoint): TRect; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetHotTrack: Boolean; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetText: string; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function IsHintForText: Boolean; override;
    function IsHintMultiLine: Boolean; override;
    function SupportsQuickCustomization: Boolean; virtual;

    function CloseDropDownWindowOnDestruction: Boolean; override;
    function DropDownWindowExists: Boolean; override;
    function GetDropDownWindow: TcxCustomGridPopup; override;
    property DropDownWindow: TcxCustomGridCustomizationPopup read GetDropDownWindowValue;
  end;

  TcxGridIndicatorRowItemViewInfoClass = class of TcxGridIndicatorRowItemViewInfo;

  TcxGridIndicatorRowItemViewInfo = class(TcxCustomGridIndicatorItemViewInfo)
  private
    FRowViewInfo: TcxCustomGridRowViewInfo;
    function GetGridRecord: TcxCustomGridRow;
    function GetGridView: TcxGridTableView;
  protected
    function CalculateHeight: Integer; override;
    function GetBackgroundBitmap: TBitmap; override;
    function GetIndicatorKind: TcxIndicatorKind; virtual;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetRowSizingEdgeBounds: TRect; virtual;
    procedure InitHitTest(AHitTest: TcxCustomGridHitTest); override;
    property RowSizingEdgeBounds: TRect read GetRowSizingEdgeBounds;
  public
    destructor Destroy; override;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; override;
    function MouseDown(AHitTest: TcxCustomGridHitTest; AButton: TMouseButton;
      AShift: TShiftState): Boolean; override;
    property GridRecord: TcxCustomGridRow read GetGridRecord;
    property GridView: TcxGridTableView read GetGridView;
    property IndicatorKind: TcxIndicatorKind read GetIndicatorKind;
    property RowViewInfo: TcxCustomGridRowViewInfo read FRowViewInfo write FRowViewInfo;
  end;

  TcxGridIndicatorFooterItemViewInfo = class(TcxCustomGridIndicatorItemViewInfo)
  private
    function GetSeparatorWidth: Integer;
  protected
    function CalculateHeight: Integer; override;
    function GetBackgroundBitmap: TBitmap; override;
    function GetBorders: TcxBorders; override;
    function GetBordersBounds: TRect; virtual;
    function GetBorderWidth(AIndex: TcxBorder): Integer; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetSeparatorBounds: TRect; virtual;
    function HasSeparator: Boolean;
  public
    property BordersBounds: TRect read GetBordersBounds;
    property SeparatorBounds: TRect read GetSeparatorBounds;
    property SeparatorWidth: Integer read GetSeparatorWidth;
  end;

  TcxGridIndicatorViewInfoClass = class of TcxGridIndicatorViewInfo;

  TcxGridIndicatorViewInfo = class(TcxCustomGridViewCellViewInfo)
  private
    FItems: TList;
    function GetCount: Integer;
    function GetGridView: TcxGridTableView;
    function GetGridViewInfo: TcxGridTableViewInfo;
    function GetItem(Index: Integer): TcxCustomGridIndicatorItemViewInfo;
    procedure DestroyItems;
  protected
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function GetAlwaysVisible: Boolean; virtual;
    function GetBackgroundBitmap: TBitmap; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetRowItemClass(ARowViewInfo: TcxCustomGridRowViewInfo): TcxGridIndicatorRowItemViewInfoClass; virtual;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function GetVisible: Boolean; override;
    function GetWidth: Integer; override;
  public
    constructor Create(AGridViewInfo: TcxGridTableViewInfo); reintroduce; virtual;
    destructor Destroy; override;
    function AddItem(AItemClass: TcxCustomGridIndicatorItemViewInfoClass): TcxCustomGridIndicatorItemViewInfo; overload;
    function AddItem(ATopBound, AHeight: Integer;
      AItemClass: TcxCustomGridIndicatorItemViewInfoClass): TcxCustomGridIndicatorItemViewInfo; overload;
    function AddRowItem(ARowViewInfo: TcxCustomGridRowViewInfo): TcxCustomGridIndicatorItemViewInfo;
    procedure Calculate(ALeftBound, ATopBound: Integer; AWidth: Integer = -1;
      AHeight: Integer = -1); override;
    procedure CalculateRowItem(ARowViewInfo: TcxCustomGridRowViewInfo;
      AItem: TcxCustomGridIndicatorItemViewInfo);
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; override;
    function GetRowItemBounds(AGridRecord: TcxCustomGridRow): TRect;

    property AlwaysVisible: Boolean read GetAlwaysVisible;
    property Count: Integer read GetCount;
    property GridView: TcxGridTableView read GetGridView;
    property GridViewInfo: TcxGridTableViewInfo read GetGridViewInfo;
    property Items[Index: Integer]: TcxCustomGridIndicatorItemViewInfo read GetItem;
  end;

  // custom row

  TcxGridRowFooterCellViewInfo = class(TcxGridFooterCellViewInfo)
  private
    function GetContainer: TcxGridRowFooterViewInfo;
    function GetGridRecord: TcxCustomGridRow;
  protected
    function GetText: string; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
  public
    property Container: TcxGridRowFooterViewInfo read GetContainer;
    property GridRecord: TcxCustomGridRow read GetGridRecord;
  end;

  TcxGridRowFooterViewInfoClass = class of TcxGridRowFooterViewInfo;

  TcxGridRowFooterViewInfo = class(TcxGridFooterViewInfo)
  private
    FContainer: TcxGridRowFootersViewInfo;
    FLevel: Integer;
    function GetIndent: Integer;
    function GetGridRecord: TcxCustomGridRow;
    function GetGroupLevel: Integer;
    function GetRowViewInfo: TcxCustomGridRowViewInfo;
  protected
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function GetColumnWidth(AColumn: TcxGridColumn): Integer; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetIsPart: Boolean; override;
    function GetItemAreaBounds(AItem: TcxGridColumnHeaderViewInfo): TRect; override;
    function GetItemClass: TcxGridColumnHeaderViewInfoClass; override;
    function GetItemHitTestClass: TcxCustomGridHitTestClass; override;
    function GetItemMultiLinePainting(AItem: TcxGridColumnHeaderViewInfo): Boolean; override;
    function GetSummaryItems: TcxDataSummaryItems; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function GetVisible: Boolean; override;
    function GetVisualLevel: Integer; virtual;
    function HasSeparator: Boolean; override;
    procedure PrepareSummaryItems(ASummaryItems: TList); override;
    property Indent: Integer read GetIndent;
  public
    constructor Create(AContainer: TcxGridRowFootersViewInfo; ALevel: Integer); reintroduce; virtual;
    function CanShowMultipleSummaries: Boolean; override;
    property Container: TcxGridRowFootersViewInfo read FContainer;
    property GridRecord: TcxCustomGridRow read GetGridRecord;
    property GroupLevel: Integer read GetGroupLevel;
    property Level: Integer read FLevel;
    property RowViewInfo: TcxCustomGridRowViewInfo read GetRowViewInfo;
    property VisualLevel: Integer read GetVisualLevel;
  end;

  TcxGridRowFootersViewInfoClass = class of TcxGridRowFootersViewInfo;

  TcxGridRowFootersViewInfo = class
  private
    FHeight: Integer;
    FItems: TList;
    FRowViewInfo: TcxCustomGridRowViewInfo;
    function GetCount: Integer;
    function GetGridViewInfo: TcxGridTableViewInfo;
    function GetHeight: Integer;
    function GetItem(Index: Integer): TcxGridRowFooterViewInfo;
    function GetVisibleItem(ALevel: Integer): TcxGridRowFooterViewInfo;
    procedure CreateItems;
    procedure DestroyItems;
  protected
    procedure BeforeRecalculation; virtual;
    procedure Calculate(ALeftBound, ATopBound: Integer); virtual;
    function CalculateHeight: Integer; virtual;
    function GetItemClass: TcxGridRowFooterViewInfoClass; virtual;
  public
    constructor Create(ARowViewInfo: TcxCustomGridRowViewInfo); virtual;
    destructor Destroy; override;
    function GetCellBestFitWidth(AColumn: TcxGridColumn): Integer;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; virtual;
    function GetTopBound(ALevel: Integer; var ATopBound: Integer): Boolean;
    procedure Offset(DX, DY: Integer); virtual;
    procedure Paint;

    property Count: Integer read GetCount;
    property GridViewInfo: TcxGridTableViewInfo read GetGridViewInfo;
    property Items[Index: Integer]: TcxGridRowFooterViewInfo read GetItem; default;
    property Height: Integer read GetHeight;
    property RowViewInfo: TcxCustomGridRowViewInfo read FRowViewInfo;
    property VisibleItems[ALevel: Integer]: TcxGridRowFooterViewInfo read GetVisibleItem;
  end;

  TcxCustomGridRowViewInfoClass = class of TcxCustomGridRowViewInfo;

  TcxCustomGridRowViewInfo = class(TcxCustomGridRecordViewInfo)
  private
    FFootersViewInfo: TcxGridRowFootersViewInfo;
    FIndicatorItem: TcxCustomGridIndicatorItemViewInfo;
    function GetCacheItem: TcxGridTableViewInfoCacheItem;
    function GetGridView: TcxGridTableView;
    function GetGridLines: TcxGridLines;
    function GetGridRecord: TcxCustomGridRow;
    function GetGridViewInfo: TcxGridTableViewInfo;
    function GetLevel: Integer;
    function GetLevelIndent: Integer;
    function GetLevelIndentBounds(Index: Integer): TRect;
    function GetLevelIndentHorzLineBounds(Index: Integer): TRect;
    function GetLevelIndentSpaceBounds(Index: Integer): TRect;
    function GetLevelIndentVertLineBounds(Index: Integer): TRect;
    function GetRecordsViewInfo: TcxGridRowsViewInfo;
    function GetVisualLevel: Integer;
    procedure CreateFootersViewInfo;
    procedure DestroyFootersViewInfo;
    procedure RecreateFootersViewInfo;
  protected
    procedure AfterRowsViewInfoCalculate; virtual;
    procedure AfterRowsViewInfoOffset; virtual;
    procedure CalculateExpandButtonBounds(var ABounds: TRect); override;
    function CalculateHeight: Integer; override;
    function CalculateLevelIndentHorzLineBounds(ALevel: Integer; const ABounds: TRect): TRect;
    function CalculateLevelIndentSpaceBounds(ALevel: Integer; const ABounds: TRect): TRect;
    function CalculateLevelIndentVertLineBounds(ALevel: Integer; const ABounds: TRect): TRect;
    function CalculateWidth: Integer; override;
    function CanSize: Boolean; virtual;
    procedure CheckRowHeight(var AValue: Integer); virtual;
    function GetAutoHeight: Boolean; override;
    function GetBaseHeight: Integer; virtual;
    function GetBottomPartHeight: Integer; virtual;
    function GetCellTransparent(ACell: TcxGridTableCellViewInfo): Boolean; override;
    function GetContentBounds: TRect; override;
    function GetContentIndent: Integer; virtual;
    function GetContentWidth: Integer; override;
    function GetDataHeight: Integer; virtual;
    function GetDataIndent: Integer; virtual;
    function GetDataWidth: Integer; virtual;
    function GetFocusRectBounds: TRect; override;
    function GetFootersViewInfoClass: TcxGridRowFootersViewInfoClass; virtual;
    function GetLastHorzGridLineBounds: TRect; virtual;
    function GetMaxHeight: Integer; virtual;
    function GetNonBaseHeight: Integer; virtual;
    function GetRowHeight: Integer; virtual;
    function GetSeparatorBounds: TRect; virtual;
    function GetSeparatorColor: TColor; virtual;
    function GetSeparatorWidth: Integer; virtual;
    function GetShowSeparator: Boolean; virtual;
    function GetVisible: Boolean; override;
    function GetWidth: Integer; override;
    function HasAnyFooter(ALevel: Integer): Boolean;
    function HasFooter(ALevel: Integer): Boolean; virtual;
    function HasFooters: Boolean; virtual;
    function HasLastHorzGridLine: Boolean; virtual;
    function IsFullyVisible: Boolean; virtual;
    procedure Offset(DX, DY: Integer); override;
    procedure SetRowHeight(Value: Integer); virtual; abstract;

    property BaseHeight: Integer read GetBaseHeight;
    property BottomPartHeight: Integer read GetBottomPartHeight;
    property CacheItem: TcxGridTableViewInfoCacheItem read GetCacheItem;
    property IndicatorItem: TcxCustomGridIndicatorItemViewInfo read FIndicatorItem;
    property LastHorzGridLineBounds: TRect read GetLastHorzGridLineBounds;
    property Level: Integer read GetLevel;
    property LevelIndent: Integer read GetLevelIndent;
    property NonBaseHeight: Integer read GetNonBaseHeight;
    property RowHeight: Integer read GetRowHeight write SetRowHeight;
    property ShowSeparator: Boolean read GetShowSeparator;
  public
    constructor Create(ARecordsViewInfo: TcxCustomGridRecordsViewInfo;
      ARecord: TcxCustomGridRecord); override;
    destructor Destroy; override;
    procedure BeforeRecalculation; override;
    procedure Calculate(ALeftBound, ATopBound: Integer; AWidth: Integer = -1;
      AHeight: Integer = -1); override;
    function Click(AHitTest: TcxCustomGridHitTest; AButton: TMouseButton;
      AShift: TShiftState): Boolean; override;
    function GetBoundsForInvalidate(AItem: TcxCustomGridTableItem): TRect; override;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; override;
    function HasSeparator: Boolean;

    property ContentIndent: Integer read GetContentIndent;
    property DataHeight: Integer read GetDataHeight;
    property DataIndent: Integer read GetDataIndent;
    property DataWidth: Integer read GetDataWidth;
    property FootersViewInfo: TcxGridRowFootersViewInfo read FFootersViewInfo;
    property GridView: TcxGridTableView read GetGridView;
    property GridLines: TcxGridLines read GetGridLines;
    property GridRecord: TcxCustomGridRow read GetGridRecord;
    property GridViewInfo: TcxGridTableViewInfo read GetGridViewInfo;
    property LevelIndentBounds[Index: Integer]: TRect read GetLevelIndentBounds;
    property LevelIndentHorzLineBounds[Index: Integer]: TRect read GetLevelIndentHorzLineBounds;
    property LevelIndentSpaceBounds[Index: Integer]: TRect read GetLevelIndentSpaceBounds;
    property LevelIndentVertLineBounds[Index: Integer]: TRect read GetLevelIndentVertLineBounds;
    property MaxHeight: Integer read GetMaxHeight;
    property RecordsViewInfo: TcxGridRowsViewInfo read GetRecordsViewInfo;
    property SeparatorBounds: TRect read GetSeparatorBounds;
    property SeparatorColor: TColor read GetSeparatorColor;
    property SeparatorWidth: Integer read GetSeparatorWidth;
    property VisualLevel: Integer read GetVisualLevel;
  end;

  // rows

  TcxGridRowsViewInfoClass = class of TcxGridRowsViewInfo;

  TcxGridRowsViewInfo = class(TcxCustomGridRecordsViewInfo)
  private
    FDataRowHeight: Integer;
    FFilterRowViewInfo: TcxCustomGridRowViewInfo;
    FGroupRowHeight: Integer;
    FNewItemRowViewInfo: TcxCustomGridRowViewInfo;
    FRestHeight: Integer;
    FRowHeight: Integer;
    function GetFilterRowViewInfo: TcxCustomGridRowViewInfo;
    function GetGridView: TcxGridTableView;
    function GetGridLines: TcxGridLines;
    function GetGridViewInfo: TcxGridTableViewInfo;
    function GetHeaderViewInfo: TcxGridHeaderViewInfo;
    function GetItem(Index: Integer): TcxCustomGridRowViewInfo;
    function GetNewItemRowViewInfo: TcxCustomGridRowViewInfo;
    function GetPainterClassValue: TcxGridRowsPainterClass;
    function GetViewData: TcxGridViewData;
  protected
    FIsFirstRowFullyVisible: Boolean;
    FPartVisibleCount: Integer;
    procedure AfterCalculate; override;
    procedure AfterOffset; override;
    procedure Calculate; override;
    function CalculateBounds: TRect; override;
    procedure CalculateConsts; virtual;
    function CalculateContentBounds: TRect; override;
    function CalculateDataRowHeight: Integer; virtual;
    function CalculateGroupRowDefaultHeight(AMinHeight: Boolean): Integer; virtual;
    function CalculateGroupRowHeight: Integer; virtual;
    function CalculateRestHeight(ATopBound: Integer): Integer; virtual;
    function CalculateRowDefaultHeight: Integer; virtual;
    function CalculateRowHeight: Integer; virtual;
    procedure CalculateVisibleCount; override;
    function GetAutoDataCellHeight: Boolean; override;
    function GetCommonDataRowHeight: Integer; virtual;
    function GetFilterRowViewInfoClass: TcxCustomGridRowViewInfoClass; virtual;
    function GetGroupBackgroundBitmap: TBitmap; virtual;
    function GetGroupRowSeparatorWidth: Integer; virtual;
    function GetItemLeftBound(AIndex: Integer): Integer; override;
    function GetItemsOffset(AItemCountDelta: Integer): Integer; override;
    function GetItemTopBound(AIndex: Integer): Integer; override;
    function GetIsScrollable: Boolean; virtual;
    function GetNewItemRowViewInfoClass: TcxCustomGridRowViewInfoClass; virtual;
    function GetPainterClass: TcxCustomGridRecordsPainterClass; override;
    function GetRowWidth: Integer; virtual;
    function GetSeparatorWidth: Integer; virtual;
    function HasFilterRow: Boolean;
    function HasLastHorzGridLine(ARowViewInfo: TcxCustomGridRowViewInfo): Boolean; virtual;
    function HasNewItemRow: Boolean;
    function IsFilterRowVisible: Boolean; virtual;
    function IsNewItemRowVisible: Boolean; virtual;
    procedure NotifyItemsCalculationFinished;
    procedure OffsetItem(AIndex, AOffset: Integer); override;

    property GridView: TcxGridTableView read GetGridView;
    property GridViewInfo: TcxGridTableViewInfo read GetGridViewInfo;
    property HeaderViewInfo: TcxGridHeaderViewInfo read GetHeaderViewInfo;
    property IsScrollable: Boolean read GetIsScrollable;
    property ViewData: TcxGridViewData read GetViewData;
  public
    destructor Destroy; override;
    procedure AfterConstruction; override;
    function CalculateCustomGroupRowHeight(AMinHeight: Boolean; AParams: TcxViewParams): Integer; virtual;
    function CanDataRowSize: Boolean; virtual;
    function GetCellHeight(ACellContentHeight: Integer): Integer; override;
    function GetDataRowCellsAreaViewInfoClass: TClass; virtual;
    function GetFooterCellBestFitWidth(AColumn: TcxGridColumn): Integer;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; override;
    function GetRealItem(ARecord: TcxCustomGridRecord): TcxCustomGridRecordViewInfo; override;
    function GetRestHeight(ATopBound: Integer): Integer; virtual;
    function IsCellMultiLine(AItem: TcxCustomGridTableItem): Boolean; override;
    function IsDataRowHeightAssigned: Boolean; virtual;
    procedure Offset(DX, DY: Integer); override;

    property CommonDataRowHeight: Integer read GetCommonDataRowHeight;
    property DataRowHeight: Integer read FDataRowHeight;
    property FilterRowViewInfo: TcxCustomGridRowViewInfo read GetFilterRowViewInfo;
    property GridLines: TcxGridLines read GetGridLines;
    property GroupBackgroundBitmap: TBitmap read GetGroupBackgroundBitmap;
    property GroupRowHeight: Integer read FGroupRowHeight write FGroupRowHeight;
    property GroupRowSeparatorWidth: Integer read GetGroupRowSeparatorWidth;
    property IsFirstRowFullyVisible: Boolean read FIsFirstRowFullyVisible;
    property Items[Index: Integer]: TcxCustomGridRowViewInfo read GetItem; default;
    property NewItemRowViewInfo: TcxCustomGridRowViewInfo read GetNewItemRowViewInfo;
    property PainterClass: TcxGridRowsPainterClass read GetPainterClassValue;
    property PartVisibleCount: Integer read FPartVisibleCount;
    property RowHeight: Integer read FRowHeight write FRowHeight;
    property RowWidth: Integer read GetRowWidth;
    property SeparatorWidth: Integer read GetSeparatorWidth;
  end;

  // table

  TcxGridTableViewInfo = class(TcxCustomGridTableViewInfo)
  private
    FDataWidth: Integer;
    FExpandButtonIndent: Integer;
    FFooterViewInfo: TcxGridFooterViewInfo;
    FGroupByBoxViewInfo: TcxGridGroupByBoxViewInfo;
    FHeaderViewInfo: TcxGridHeaderViewInfo;
    FIndicatorViewInfo: TcxGridIndicatorViewInfo;
    FLevelIndent: Integer;
    FPrevDataRowHeight: Integer;

    function GetController: TcxGridTableController;
    function GetDataWidth: Integer;
    function GetGridView: TcxGridTableView;
    function GetGridLineColor: TColor;
    function GetGridLines: TcxGridLines;
    function GetLeftPos: Integer;
    function GetLevelIndentBackgroundBitmap: TBitmap;
    function GetLevelIndentColor(Index: Integer): TColor;
    function GetRecordsViewInfo: TcxGridRowsViewInfo;
    function GetViewData: TcxGridViewData;
  protected
    procedure AfterCalculating; override;
    procedure BeforeCalculating; override;
    procedure CreateViewInfos; override;
    procedure DestroyViewInfos(AIsRecreating: Boolean); override;
    procedure Calculate; override;
    function CalculateClientBounds: TRect; override;
    function CalculateDataWidth: Integer; virtual;
    procedure CalculateExpandButtonParams; virtual;
    procedure CalculateHeight(const AMaxSize: TPoint; var AHeight: Integer;
      var AFullyVisible: Boolean); override;
    function CalculatePartBounds(APart: TcxCustomGridPartViewInfo): TRect; override;
    procedure CalculateParts; virtual;
    function CalculateVisibleEqualHeightRecordCount: Integer; override;
    procedure CalculateWidth(const AMaxSize: TPoint; var AWidth: Integer); override;
    function DoGetHitTest(const P: TPoint): TcxCustomGridHitTest; override;
    function GetDefaultGridModeBufferCount: Integer; override;
    function GetFirstItemAdditionalWidth: Integer; virtual;
    function GetGridLineWidth: Integer; virtual;
    function GetLevelSeparatorColor: TColor; virtual;
    function GetNonRecordsAreaHeight(ACheckScrollBar: Boolean): Integer; override;
    function GetScrollableAreaBoundsHorz: TRect; override;
    function GetScrollableAreaBoundsVert: TRect; override;
    function GetVisualLevelCount: Integer; virtual;
    procedure Offset(DX, DY: Integer); override;
    procedure RecreateViewInfos; override;
    function SupportsAutoHeight: Boolean; virtual;
    function SupportsGroupSummariesAlignedWithColumns: Boolean; virtual;
    function SupportsMultipleFooterSummaries: Boolean; virtual;

    function GetFooterPainterClass: TcxGridFooterPainterClass; virtual;
    function GetFooterViewInfoClass: TcxGridFooterViewInfoClass; virtual;
    function GetGroupByBoxViewInfoClass: TcxGridGroupByBoxViewInfoClass; virtual;
    function GetHeaderViewInfoClass: TcxGridHeaderViewInfoClass; virtual;
    function GetIndicatorViewInfoClass: TcxGridIndicatorViewInfoClass; virtual;
    function GetHeaderViewInfoSpecificClass: TcxGridHeaderViewInfoSpecificClass; virtual;
    function GetRecordsViewInfoClass: TcxCustomGridRecordsViewInfoClass; override;

    property Controller: TcxGridTableController read GetController;
    property ViewData: TcxGridViewData read GetViewData;
  public
    function GetCellBorders(AIsRight, AIsBottom: Boolean): TcxBorders; virtual;
    function GetCellHeight(AIndex, ACellHeight: Integer): Integer; virtual;
    function GetCellTopOffset(AIndex, ACellHeight: Integer): Integer; virtual;
    function GetOffsetBounds(AItemsOffset: Integer; out AUpdateBounds: TRect): TRect; overload; virtual;
    function GetOffsetBounds(DX, DY: Integer; out AUpdateBounds: TRect): TRect; overload; virtual;
    function GetVisualLevel(ALevel: Integer): Integer; virtual;

    // for extended lookup edit
    function GetNearestPopupHeight(AHeight: Integer; AAdditionalRecord: Boolean = False): Integer; override;
    function GetPopupHeight(ADropDownRowCount: Integer): Integer; override;

    property DataWidth: Integer read GetDataWidth;
    property ExpandButtonIndent: Integer read FExpandButtonIndent write FExpandButtonIndent;
    property FirstItemAdditionalWidth: Integer read GetFirstItemAdditionalWidth;
    property FooterViewInfo: TcxGridFooterViewInfo read FFooterViewInfo;
    property GridLineColor: TColor read GetGridLineColor;
    property GridLines: TcxGridLines read GetGridLines;
    property GridLineWidth: Integer read GetGridLineWidth;
    property GridView: TcxGridTableView read GetGridView;
    property GroupByBoxViewInfo: TcxGridGroupByBoxViewInfo read FGroupByBoxViewInfo;
    property HeaderViewInfo: TcxGridHeaderViewInfo read FHeaderViewInfo;
    property IndicatorViewInfo: TcxGridIndicatorViewInfo read FIndicatorViewInfo;
    property LeftPos: Integer read GetLeftPos;
    property LevelIndent: Integer read FLevelIndent write FLevelIndent;
    property LevelIndentBackgroundBitmap: TBitmap read GetLevelIndentBackgroundBitmap;
    property LevelIndentColors[Index: Integer]: TColor read GetLevelIndentColor;
    property LevelSeparatorColor: TColor read GetLevelSeparatorColor;
    property RecordsViewInfo: TcxGridRowsViewInfo read GetRecordsViewInfo;
    property VisualLevelCount: Integer read GetVisualLevelCount;
  end;

  // cache

  TcxGridTableViewInfoCacheItem = class(TcxCustomGridTableViewInfoCacheItem)
  private
    FIsPreviewHeightAssigned: Boolean;
    FPreviewHeight: Integer;
    procedure SetPreviewHeight(Value: Integer);
  public
    procedure UnassignValues(AKeepMaster: Boolean); override;
    property IsPreviewHeightAssigned: Boolean read FIsPreviewHeightAssigned
      write FIsPreviewHeightAssigned;
    property PreviewHeight: Integer read FPreviewHeight write SetPreviewHeight;
  end;

  TcxGridMasterTableViewInfoCacheItem = class(TcxGridTableViewInfoCacheItem)
  private
    FIsDetailsSiteFullyVisibleAssigned: Boolean;
    FIsDetailsSiteHeightAssigned: Boolean;
    FIsDetailsSiteNormalHeightAssigned: Boolean;
    FIsDetailsSiteWidthAssigned: Boolean;
    FDetailsSiteFullyVisible: Boolean;
    FDetailsSiteHeight: Integer;
    FDetailsSiteNormalHeight: Integer;
    FDetailsSiteWidth: Integer;
    FUnassigningValues: Boolean;
    function GetGridRecord: TcxGridMasterDataRow;
    function GetIsDetailsSiteCachedInfoAssigned: Boolean;
    procedure SetDetailsSiteFullyVisible(Value: Boolean);
    procedure SetDetailsSiteHeight(Value: Integer);
    procedure SetDetailsSiteNormalHeight(Value: Integer);
    procedure SetDetailsSiteWidth(Value: Integer);
  protected
    property GridRecord: TcxGridMasterDataRow read GetGridRecord;
  public
    DetailsSiteCachedInfo: TcxCustomGridDetailsSiteViewInfoCachedInfo;
    destructor Destroy; override;
    procedure UnassignValues(AKeepMaster: Boolean); override;
    property IsDetailsSiteCachedInfoAssigned: Boolean read GetIsDetailsSiteCachedInfoAssigned;
    property IsDetailsSiteFullyVisibleAssigned: Boolean read FIsDetailsSiteFullyVisibleAssigned write FIsDetailsSiteFullyVisibleAssigned;
    property IsDetailsSiteHeightAssigned: Boolean read FIsDetailsSiteHeightAssigned write FIsDetailsSiteHeightAssigned;
    property IsDetailsSiteNormalHeightAssigned: Boolean read FIsDetailsSiteNormalHeightAssigned write FIsDetailsSiteNormalHeightAssigned;
    property IsDetailsSiteWidthAssigned: Boolean read FIsDetailsSiteWidthAssigned write FIsDetailsSiteWidthAssigned;
    property DetailsSiteFullyVisible: Boolean read FDetailsSiteFullyVisible write SetDetailsSiteFullyVisible;
    property DetailsSiteHeight: Integer read FDetailsSiteHeight write SetDetailsSiteHeight;
    property DetailsSiteNormalHeight: Integer read FDetailsSiteNormalHeight write SetDetailsSiteNormalHeight;
    property DetailsSiteWidth: Integer read FDetailsSiteWidth write SetDetailsSiteWidth;
  end;

  { view }

  // column

  TcxGridColumnOptions = class(TcxCustomGridTableItemOptions)
  private
    FCellMerging: Boolean;
    FGroupFooters: Boolean;
    FHorzSizing: Boolean;
    function GetGridView: TcxGridTableView;
    procedure SetCellMerging(Value: Boolean);
    procedure SetGroupFooters(Value: Boolean);
    procedure SetHorzSizing(Value: Boolean);
  protected
    property GridView: TcxGridTableView read GetGridView;
  public
    constructor Create(AItem: TcxCustomGridTableItem); override;
    procedure Assign(Source: TPersistent); override;
  published
    property CellMerging: Boolean read FCellMerging write SetCellMerging default False;
    property GroupFooters: Boolean read FGroupFooters write SetGroupFooters default True; 
    property Grouping;
    property HorzSizing: Boolean read FHorzSizing write SetHorzSizing default True;
    property Moving;
    property ShowCaption;
    property SortByDisplayText;
    property Sorting;
  end;

  TcxGridGetFooterStyleExEvent = procedure(Sender: TcxGridTableView; ARow: TcxCustomGridRow;
    AColumn: TcxGridColumn; AFooterGroupLevel: Integer; var AStyle: TcxStyle) of object;
  TcxGridGetFooterSummaryStyleEvent = procedure(AView: TcxGridTableView; ARow: TcxCustomGridRow;
    AColumn: TcxGridColumn; AFooterGroupLevel: Integer; ASummaryItem: TcxDataSummaryItem; var AStyle: TcxStyle) of object;
  TcxGridGetGroupSummaryStyleEvent = procedure(Sender: TcxGridTableView; ARow: TcxGridGroupRow;
    AColumn: TcxGridColumn; ASummaryItem: TcxDataSummaryItem; var AStyle: TcxStyle) of object;
  TcxGridGetHeaderStyleEvent = procedure(Sender: TcxGridTableView;
    AColumn: TcxGridColumn; {$IFDEF BCBCOMPATIBLE}var{$ELSE}out{$ENDIF} AStyle: TcxStyle) of object;

  TcxGridColumnStyles = class(TcxCustomGridTableItemStyles)
  private
    FOnGetFooterStyle: TcxGridGetCellStyleEvent;
    FOnGetFooterStyleEx: TcxGridGetFooterStyleExEvent;
    FOnGetFooterSummaryStyle: TcxGridGetFooterSummaryStyleEvent;
    FOnGetGroupSummaryStyle: TcxGridGetGroupSummaryStyleEvent;
    FOnGetHeaderStyle: TcxGridGetHeaderStyleEvent;
    function GetGridViewValue: TcxGridTableView;
    function GetItem: TcxGridColumn;
    procedure SetOnGetFooterStyle(Value: TcxGridGetCellStyleEvent);
    procedure SetOnGetFooterStyleEx(Value: TcxGridGetFooterStyleExEvent);
    procedure SetOnGetFooterSummaryStyle(Value: TcxGridGetFooterSummaryStyleEvent);
    procedure SetOnGetGroupSummaryStyle(Value: TcxGridGetGroupSummaryStyleEvent);
    procedure SetOnGetHeaderStyle(Value: TcxGridGetHeaderStyleEvent);
  protected
    procedure GetDefaultViewParams(Index: Integer; AData: TObject; out AParams: TcxViewParams); override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure GetFooterParams(ARow: TcxCustomGridRow; AFooterGroupLevel: Integer;
      ASummaryItem: TcxDataSummaryItem; out AParams: TcxViewParams); virtual;
    procedure GetGroupSummaryParams(ARow: TcxGridGroupRow; ASummaryItem: TcxDataSummaryItem;
      out AParams: TcxViewParams); virtual;
    procedure GetHeaderParams(out AParams: TcxViewParams); virtual;
    property GridView: TcxGridTableView read GetGridViewValue;
    property Item: TcxGridColumn read GetItem;
  published
    property Footer: TcxStyle index isFooter read GetValue write SetValue;
    property GroupSummary: TcxStyle index isGroupSummary read GetValue write SetValue;
    property Header: TcxStyle index isHeader read GetValue write SetValue;
    property OnGetFooterStyle: TcxGridGetCellStyleEvent read FOnGetFooterStyle write SetOnGetFooterStyle;
    property OnGetFooterStyleEx: TcxGridGetFooterStyleExEvent read FOnGetFooterStyleEx write SetOnGetFooterStyleEx;
    property OnGetFooterSummaryStyle: TcxGridGetFooterSummaryStyleEvent read FOnGetFooterSummaryStyle write SetOnGetFooterSummaryStyle;
    property OnGetGroupSummaryStyle: TcxGridGetGroupSummaryStyleEvent read FOnGetGroupSummaryStyle write SetOnGetGroupSummaryStyle;
    property OnGetHeaderStyle: TcxGridGetHeaderStyleEvent read FOnGetHeaderStyle write SetOnGetHeaderStyle;
  end;

  TcxGridSummariesIndex = (siFooter, siGroupFooter, siGroup);

  TcxGridColumnSummaryClass = class of TcxGridColumnSummary;

  TcxGridColumnSummary = class(TcxCustomGridTableItemCustomOptions)
  private
    function GetDataController: TcxCustomDataController;
    function GetFormat(Index: Integer): string;
    function GetKind(Index: Integer): TcxSummaryKind;
    function GetSortByGroupFooterSummary: Boolean;
    function GetSortByGroupSummary: Boolean;
    procedure SetFormat(Index: Integer; const Value: string);
    procedure SetKind(Index: Integer; Value: TcxSummaryKind);
    procedure SetSortByGroupFooterSummary(Value: Boolean);
    procedure SetSortByGroupSummary(Value: Boolean);
  protected
    function GetSummaryItems(AIndex: TcxGridSummariesIndex): TcxDataSummaryItems;
    function GetSummaryItemsPosition(AIndex: TcxGridSummariesIndex): TcxSummaryPosition;
    property DataController: TcxCustomDataController read GetDataController;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property FooterKind: TcxSummaryKind index 0 read GetKind write SetKind stored False;
    property FooterFormat: string index 0 read GetFormat write SetFormat stored False;
    property GroupFooterKind: TcxSummaryKind index 1 read GetKind write SetKind stored False;
    property GroupFooterFormat: string index 1 read GetFormat write SetFormat stored False;
    property GroupKind: TcxSummaryKind index 2 read GetKind write SetKind stored False;
    property GroupFormat: string index 2 read GetFormat write SetFormat stored False;
    property SortByGroupFooterSummary: Boolean read GetSortByGroupFooterSummary write SetSortByGroupFooterSummary stored False;
    property SortByGroupSummary: Boolean read GetSortByGroupSummary write SetSortByGroupSummary stored False;
  end;

  TcxGridColumnCompareRowValuesEvent = procedure(Sender: TcxGridColumn;
    ARow1: TcxGridDataRow; AProperties1: TcxCustomEditProperties; const AValue1: TcxEditValue;
    ARow2: TcxGridDataRow; AProperties2: TcxCustomEditProperties; const AValue2: TcxEditValue;
    var AAreEqual: Boolean) of object;
  TcxGridColumnCompareValuesEvent = procedure(Sender: TcxGridColumn;
    AProperties1: TcxCustomEditProperties; const AValue1: TcxEditValue;
    AProperties2: TcxCustomEditProperties; const AValue2: TcxEditValue; var AAreEqual: Boolean) of object;
  TcxGridColumnCustomDrawHeaderEvent = procedure(Sender: TcxGridTableView; ACanvas: TcxCanvas;
    AViewInfo: TcxGridColumnHeaderViewInfo; var ADone: Boolean) of object;
  TcxGridGroupSummaryCellCustomDrawEvent = procedure(Sender: TObject; ACanvas: TcxCanvas;
    ARow: TcxGridGroupRow; AColumn: TcxGridColumn; ASummaryItem: TcxDataSummaryItem;
    AViewInfo: TcxCustomGridViewCellViewInfo; var ADone: Boolean) of object;

  TcxGridColumn = class(TcxCustomGridTableItem)
  private
    FFooterAlignmentHorz: TAlignment;
    FGroupSummaryAlignment: TAlignment;
    FHeaderGlyph: TBitmap;
    FHeaderGlyphAlignmentHorz: TAlignment;
    FHeaderGlyphAlignmentVert: TcxAlignmentVert;
    FIsFooterAlignmentHorzAssigned: Boolean;
    FIsGroupSummaryAlignmentAssigned: Boolean;
    FSelected: Boolean;
    FSummary: TcxGridColumnSummary;
    FOnCompareRowValuesForCellMerging: TcxGridColumnCompareRowValuesEvent;
    FOnCompareValuesForCellMerging: TcxGridColumnCompareValuesEvent;
    FOnCustomDrawFooterCell: TcxGridColumnCustomDrawHeaderEvent;
    FOnCustomDrawGroupSummaryCell: TcxGridGroupSummaryCellCustomDrawEvent;
    FOnCustomDrawHeader: TcxGridColumnCustomDrawHeaderEvent;
    FOnHeaderClick: TNotifyEvent;

    function GetController: TcxGridTableController;
    function GetFooterAlignmentHorz: TAlignment;
    function GetGridView: TcxGridTableView;
    function GetGroupSummaryAlignment: TAlignment;
    function GetIsPreview: Boolean;
    function GetOptions: TcxGridColumnOptions;
    function GetStyles: TcxGridColumnStyles;
    function GetViewData: TcxGridViewData;
    procedure SetFooterAlignmentHorz(Value: TAlignment);
    procedure SetGroupSummaryAlignment(Value: TAlignment);
    procedure SetHeaderGlyph(Value: TBitmap);
    procedure SetHeaderGlyphAlignmentHorz(Value: TAlignment);
    procedure SetHeaderGlyphAlignmentVert(Value: TcxAlignmentVert);
    procedure SetIsPreview(Value: Boolean);
    procedure SetOnCompareRowValuesForCellMerging(Value: TcxGridColumnCompareRowValuesEvent);
    procedure SetOnCompareValuesForCellMerging(Value: TcxGridColumnCompareValuesEvent);
    procedure SetOnCustomDrawFooterCell(Value: TcxGridColumnCustomDrawHeaderEvent);
    procedure SetOnCustomDrawGroupSummaryCell(Value: TcxGridGroupSummaryCellCustomDrawEvent);
    procedure SetOnCustomDrawHeader(Value: TcxGridColumnCustomDrawHeaderEvent);
    procedure SetOnHeaderClick(Value: TNotifyEvent);
    procedure SetOptions(Value: TcxGridColumnOptions);
    procedure SetSelected(Value: Boolean);
    procedure SetStyles(Value: TcxGridColumnStyles);
    procedure SetSummary(Value: TcxGridColumnSummary);

    function IsFooterAlignmentHorzStored: Boolean;
    function IsGroupSummaryAlignmentStored: Boolean;

    procedure HeaderGlyphChanged(Sender: TObject);
  protected
    // IcxStoredObject
    function GetStoredProperties(AProperties: TStrings): Boolean; override;
    procedure GetPropertyValue(const AName: string; var AValue: Variant); override;
    procedure SetPropertyValue(const AName: string; const AValue: Variant); override;

    procedure CreateSubClasses; override;
    procedure DestroySubClasses; override;
    function GetOptionsClass: TcxCustomGridTableItemOptionsClass; override;
    function GetStylesClass: TcxCustomGridTableItemStylesClass; override;
    function GetSummaryClass: TcxGridColumnSummaryClass; virtual;

    procedure AssignColumnWidths; virtual;
    procedure BestFitApplied(AFireEvents: Boolean); override;
    function CalculateBestFitWidth: Integer; override;
    function CanCellMerging: Boolean; virtual;
    function CanEdit: Boolean; override;
    function CanFocus(ARecord: TcxCustomGridRecord): Boolean; override;
    function CanHorzSize: Boolean; override;
    function CanShowGroupFooters: Boolean; virtual;
    procedure ForceWidth(Value: Integer); override;
    function GetEditValue: Variant; override;
    procedure SetEditValue(const Value: Variant); override;
    function GetFixed: Boolean; override;
    function GetIsBottom: Boolean; virtual;
    function GetIsLeft: Boolean; virtual;
    function GetIsMostBottom: Boolean; virtual;
    function GetIsMostLeft: Boolean; virtual;
    function GetIsMostRight: Boolean; virtual;
    function GetIsRight: Boolean; virtual;
    function GetIsTop: Boolean; virtual;
    function GetVisible: Boolean; override;
    function GetVisibleForCustomization: Boolean; override;
    function HasFixedWidth: Boolean; override;
    function HideOnGrouping: Boolean; virtual;
    function IsVisibleStored: Boolean; override;
    function IsVisibleForCustomizationStored: Boolean; override;
    function SupportsBeginsWithFilterOperator(ARow: TcxCustomGridRow): Boolean;
    //procedure VisibleChanged; dynamic;

    function GetHeaderViewInfoClass: TcxGridColumnHeaderViewInfoClass;

    procedure DoCustomDrawFooterCell(ACanvas: TcxCanvas; AViewInfo: TcxGridColumnHeaderViewInfo;
      var ADone: Boolean); virtual;
    procedure DoCustomDrawGroupSummaryCell(ACanvas: TcxCanvas; AViewInfo: TcxCustomGridViewCellViewInfo;
      var ADone: Boolean); virtual;
    procedure DoCustomDrawHeader(ACanvas: TcxCanvas; AViewInfo: TcxGridColumnHeaderViewInfo;
      var ADone: Boolean); virtual;
    procedure DoHeaderClick; virtual;
    function HasCustomDrawFooterCell: Boolean;
    function HasCustomDrawGroupSummaryCell: Boolean;
    function HasCustomDrawHeader: Boolean;

    property Controller: TcxGridTableController read GetController;
    property ViewData: TcxGridViewData read GetViewData;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function DoCompareValuesForCellMerging(
      ARow1: TcxGridDataRow; AProperties1: TcxCustomEditProperties; const AValue1: TcxEditValue;
      ARow2: TcxGridDataRow; AProperties2: TcxCustomEditProperties; const AValue2: TcxEditValue): Boolean;
    procedure FocusWithSelection; override;
    function GroupBy(AGroupIndex: Integer; ACanShow: Boolean = True): Boolean;

    property GridView: TcxGridTableView read GetGridView;
    property GroupingDateRanges;
    property Hidden;  // obsolete, use VisibleForCustomization
    property IsBottom: Boolean read GetIsBottom;
    property IsLeft: Boolean read GetIsLeft;
    property IsMostBottom: Boolean read GetIsMostBottom;
    property IsMostLeft: Boolean read GetIsMostLeft;
    property IsMostRight: Boolean read GetIsMostRight;
    property IsPreview: Boolean read GetIsPreview write SetIsPreview;
    property IsRight: Boolean read GetIsRight;
    property IsTop: Boolean read GetIsTop;
    property Selected: Boolean read FSelected write SetSelected;
  published
    property BestFitMaxWidth;
    property DateTimeGrouping;
    property FooterAlignmentHorz: TAlignment read GetFooterAlignmentHorz write SetFooterAlignmentHorz stored IsFooterAlignmentHorzStored;
    property GroupIndex;
    property GroupSummaryAlignment: TAlignment read GetGroupSummaryAlignment write SetGroupSummaryAlignment stored IsGroupSummaryAlignmentStored;
    property HeaderAlignmentHorz;
    property HeaderAlignmentVert;
    property HeaderGlyph: TBitmap read FHeaderGlyph write SetHeaderGlyph;
    property HeaderGlyphAlignmentHorz: TAlignment read FHeaderGlyphAlignmentHorz write SetHeaderGlyphAlignmentHorz default taLeftJustify;
    property HeaderGlyphAlignmentVert: TcxAlignmentVert read FHeaderGlyphAlignmentVert write SetHeaderGlyphAlignmentVert default vaCenter;
    property MinWidth;
    property Options: TcxGridColumnOptions read GetOptions write SetOptions;
    property SortIndex;
    property SortOrder;
    property Styles: TcxGridColumnStyles read GetStyles write SetStyles;
    property Summary: TcxGridColumnSummary read FSummary write SetSummary;
    property VisibleForCustomization;
    property Width;
    property OnCompareRowValuesForCellMerging: TcxGridColumnCompareRowValuesEvent read FOnCompareRowValuesForCellMerging write SetOnCompareRowValuesForCellMerging;
    property OnCompareValuesForCellMerging: TcxGridColumnCompareValuesEvent read FOnCompareValuesForCellMerging write SetOnCompareValuesForCellMerging;
    property OnCustomDrawFooterCell: TcxGridColumnCustomDrawHeaderEvent read FOnCustomDrawFooterCell write SetOnCustomDrawFooterCell;
    property OnCustomDrawGroupSummaryCell: TcxGridGroupSummaryCellCustomDrawEvent read FOnCustomDrawGroupSummaryCell write SetOnCustomDrawGroupSummaryCell;
    property OnCustomDrawHeader: TcxGridColumnCustomDrawHeaderEvent read FOnCustomDrawHeader write SetOnCustomDrawHeader;
    property OnHeaderClick: TNotifyEvent read FOnHeaderClick write SetOnHeaderClick;
    property OnInitGroupingDateRanges;
  end;

  // options

  TcxGridTableBackgroundBitmaps = class(TcxCustomGridTableBackgroundBitmaps)
  protected
    function GetBitmapStyleIndex(Index: Integer): Integer; override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Footer: TBitmap index bbFooter read GetValue write SetValue;
    property Header: TBitmap index bbHeader read GetValue write SetValue;
    property Group: TBitmap index bbGroup read GetValue write SetValue;
    property GroupByBox: TBitmap index bbGroupByBox read GetValue write SetValue;
    property Indicator: TBitmap index bbIndicator read GetValue write SetValue;
    property Preview: TBitmap index bbPreview read GetValue write SetValue;
  end;

  TcxGridTableDateTimeHandling = class(TcxCustomGridTableDateTimeHandling)
  published
    property DateFormat;
    property Grouping;
    property HourFormat; 
    property UseLongDateFormat;
    property UseShortTimeFormat;
  end;

  // behavior

  TcxGridTableOptionsBehavior = class(TcxCustomGridTableOptionsBehavior)
  private
    FColumnHeaderHints: Boolean;
    FCopyPreviewToClipboard: Boolean;
    FExpandMasterRowOnDblClick: Boolean;
    procedure SetColumnHeaderHints(Value: Boolean);
    procedure SetCopyPreviewToClipboard(Value: Boolean);
    procedure SetExpandMasterRowOnDblClick(Value: Boolean);
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    procedure Assign(Source: TPersistent); override;
  published
    property BestFitMaxRecordCount;
    property ColumnHeaderHints: Boolean read FColumnHeaderHints write SetColumnHeaderHints default True;
    property CopyPreviewToClipboard: Boolean read FCopyPreviewToClipboard write SetCopyPreviewToClipboard default True;
    property ExpandMasterRowOnDblClick: Boolean read FExpandMasterRowOnDblClick write SetExpandMasterRowOnDblClick default True;
    property FocusCellOnCycle;
    property PullFocusing;
  end;

  // filter

  TcxGridTableFiltering = class(TcxCustomGridTableFiltering)
  private
    function GetColumnFilteredItemsList: Boolean;
    function GetColumnMRUItemsList: Boolean;
    function GetColumnMRUItemsListCount: Integer;
    function GetColumnPopup: TcxGridItemFilterPopupOptions;
    procedure SetColumnFilteredItemsList(Value: Boolean);
    procedure SetColumnMRUItemsList(Value: Boolean);
    procedure SetColumnMRUItemsListCount(Value: Integer);
    procedure SetColumnPopup(Value: TcxGridItemFilterPopupOptions);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    // obsolete - use ColumnPopup.DropDownWidth
    property ColumnPopupDropDownWidth: Integer read GetItemPopupDropDownWidth write SetItemPopupDropDownWidth;
    property DropDownWidth;
    // obsolete - use ColumnPopup.MaxDropDownItemCount
    property ColumnPopupMaxDropDownItemCount: Integer read GetItemPopupMaxDropDownItemCount write SetItemPopupMaxDropDownItemCount;
    property MaxDropDownCount;
  published
    property ColumnFilteredItemsList: Boolean read GetColumnFilteredItemsList
      write SetColumnFilteredItemsList default False;
    property ColumnMRUItemsList: Boolean read GetColumnMRUItemsList write SetColumnMRUItemsList default True;
    property ColumnMRUItemsListCount: Integer read GetColumnMRUItemsListCount
      write SetColumnMRUItemsListCount default cxGridFilterDefaultItemMRUItemsListCount;
    property ColumnPopup: TcxGridItemFilterPopupOptions read GetColumnPopup write SetColumnPopup;
  end;

  // customize

  TcxGridTableOptionsCustomize = class(TcxCustomGridTableOptionsCustomize)
  private
    FColumnHidingOnGrouping: Boolean;
    FColumnHorzSizing: Boolean;
    FDataRowSizing: Boolean;
    FGroupBySorting: Boolean;
    FGroupRowSizing: Boolean;
    function GetColumnFiltering: Boolean;
    function GetColumnGrouping: Boolean;
    function GetColumnHiding: Boolean;
    function GetColumnMoving: Boolean;
    function GetColumnSorting: Boolean;
    function GetColumnsQuickCustomization: Boolean;
    function GetColumnsQuickCustomizationMaxDropDownCount: Integer;
    function GetColumnsQuickCustomizationReordering: TcxGridQuickCustomizationReordering;
    function GetGridView: TcxGridTableView;
    procedure SetColumnFiltering(Value: Boolean);
    procedure SetColumnGrouping(Value: Boolean);
    procedure SetColumnHiding(Value: Boolean);
    procedure SetColumnHidingOnGrouping(Value: Boolean);
    procedure SetColumnHorzSizing(Value: Boolean);
    procedure SetColumnMoving(Value: Boolean);
    procedure SetColumnSorting(Value: Boolean);
    procedure SetColumnsQuickCustomization(Value: Boolean);
    procedure SetColumnsQuickCustomizationMaxDropDownCount(Value: Integer);
    procedure SetColumnsQuickCustomizationReordering(Value: TcxGridQuickCustomizationReordering);
    procedure SetDataRowSizing(Value: Boolean);
    procedure SetGroupBySorting(Value: Boolean);
    procedure SetGroupRowSizing(Value: Boolean);
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    procedure Assign(Source: TPersistent); override;
    property GridView: TcxGridTableView read GetGridView;
  published
    property ColumnFiltering: Boolean read GetColumnFiltering write SetColumnFiltering default True;
    property ColumnGrouping: Boolean read GetColumnGrouping write SetColumnGrouping default True;
    property ColumnHiding: Boolean read GetColumnHiding write SetColumnHiding default False;
    property ColumnHidingOnGrouping: Boolean read FColumnHidingOnGrouping write SetColumnHidingOnGrouping default True;
    property ColumnHorzSizing: Boolean read FColumnHorzSizing write SetColumnHorzSizing default True;
    property ColumnMoving: Boolean read GetColumnMoving write SetColumnMoving default True;
    property ColumnSorting: Boolean read GetColumnSorting write SetColumnSorting default True;
    property ColumnsQuickCustomization: Boolean read GetColumnsQuickCustomization
      write SetColumnsQuickCustomization default False;
    property ColumnsQuickCustomizationMaxDropDownCount: Integer read GetColumnsQuickCustomizationMaxDropDownCount
      write SetColumnsQuickCustomizationMaxDropDownCount default 0;
    property ColumnsQuickCustomizationReordering: TcxGridQuickCustomizationReordering
      read GetColumnsQuickCustomizationReordering write SetColumnsQuickCustomizationReordering default qcrDefault;
    property DataRowSizing: Boolean read FDataRowSizing write SetDataRowSizing default False;
    property GroupBySorting: Boolean read FGroupBySorting write SetGroupBySorting default False;
    property GroupRowSizing: Boolean read FGroupRowSizing write SetGroupRowSizing default False;
  end;

  // data

  TcxGridTableOptionsData = class(TcxCustomGridTableOptionsData);

  // selection

  TcxGridTableOptionsSelection = class(TcxCustomGridTableOptionsSelection)
  private
    FCellMultiSelect: Boolean;
    procedure SetCellMultiSelect(Value: Boolean);
  protected
    procedure SetCellSelect(Value: Boolean); override;
    procedure SetInvertSelect(Value: Boolean); override;
    procedure SetMultiSelect(Value: Boolean); override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property CellMultiSelect: Boolean read FCellMultiSelect write SetCellMultiSelect default False;
  end;

  // view

  TcxGridSpecialRowOptions = class(TcxCustomGridOptions)
  private
    FInfoText: string;
    FIsInfoTextAssigned: Boolean;
    FSeparatorColor: TColor;
    FSeparatorWidth: Integer;
    FVisible: Boolean;
    function GetGridView: TcxGridTableView;
    function GetInfoText: string;
    procedure SetInfoText(const Value: string);
    procedure SetSeparatorColor(Value: TColor);
    procedure SetSeparatorWidth(Value: Integer);
    procedure SetVisible(Value: Boolean);
    function IsInfoTextStored: Boolean;
  protected
    function DefaultInfoText: string; virtual; abstract;
    function DefaultSeparatorColor: TColor; virtual;
    procedure VisibleChanged; virtual; abstract;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    procedure Assign(Source: TPersistent); override;
    function GetSeparatorColor: TColor;
    property GridView: TcxGridTableView read GetGridView;
  published
    property InfoText: string read GetInfoText write SetInfoText stored IsInfoTextStored;
    property SeparatorColor: TColor read FSeparatorColor write SetSeparatorColor default clDefault;
    property SeparatorWidth: Integer read FSeparatorWidth write SetSeparatorWidth default cxGridCustomRowSeparatorDefaultWidth;
    property Visible: Boolean read FVisible write SetVisible default False;
  end;

  TcxGridFilterRowApplyChangesMode = (fracOnCellExit, fracImmediately);

  TcxGridFilterRowOptionsClass = class of TcxGridFilterRowOptions;

  TcxGridFilterRowOptions = class(TcxGridSpecialRowOptions)
  private
    FApplyChanges: TcxGridFilterRowApplyChangesMode;
    procedure SetApplyChanges(Value: TcxGridFilterRowApplyChangesMode);
  protected
    function DefaultInfoText: string; override;
    procedure VisibleChanged; override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property ApplyChanges: TcxGridFilterRowApplyChangesMode read FApplyChanges
      write SetApplyChanges default fracOnCellExit;
  end;

  TcxGridNewItemRowOptionsClass = class of TcxGridNewItemRowOptions;

  TcxGridNewItemRowOptions = class(TcxGridSpecialRowOptions)
  protected
    function DefaultInfoText: string; override;
    procedure VisibleChanged; override;
  end;

  TcxGridGroupFootersMode = (gfInvisible, gfVisibleWhenExpanded, gfAlwaysVisible);
  TcxGridGroupRowStyle = (grsStandard, grsOffice11);
  TcxGridGroupSummaryLayout = (gslStandard, gslAlignWithColumns,
    gslAlignWithColumnsAndDistribute);

  TcxGridTableOptionsView = class(TcxCustomGridTableOptionsView)
  private
    FColumnAutoWidth: Boolean;
    FDataRowHeight: Integer;
    FExpandButtonsForEmptyDetails: Boolean;
    FFooter: Boolean;
    FFooterAutoHeight: Boolean;
    FFooterMultiSummaries: Boolean;
    FGridLineColor: TColor;
    FGridLines: TcxGridLines;
    FGroupByBox: Boolean;
    FGroupFooterMultiSummaries: Boolean;
    FGroupFooters: TcxGridGroupFootersMode;
    FGroupRowHeight: Integer;
    FGroupRowStyle: TcxGridGroupRowStyle;
    FGroupSummaryLayout: TcxGridGroupSummaryLayout;
    FHeader: Boolean;
    FHeaderHeight: Integer;
    FIndicator: Boolean;
    FIndicatorWidth: Integer;
    FPrevGroupFooters: TcxGridGroupFootersMode;
    FRowSeparatorColor: TColor;
    FRowSeparatorWidth: Integer;
    function GetExpandButtonsForEmptyDetails: Boolean;
    function GetGridView: TcxGridTableView;
    function GetHeaderAutoHeight: Boolean;
    function GetHeaderEndEllipsis: Boolean;
    function GetNewItemRow: Boolean;
    function GetNewItemRowInfoText: string;
    function GetNewItemRowSeparatorColor: TColor;
    function GetNewItemRowSeparatorWidth: Integer;
    function GetShowColumnFilterButtons: TcxGridShowItemFilterButtons;
    procedure SetColumnAutoWidth(Value: Boolean);
    procedure SetDataRowHeight(Value: Integer);
    procedure SetExpandButtonsForEmptyDetails(Value: Boolean);
    procedure SetFooter(Value: Boolean);
    procedure SetFooterAutoHeight(Value: Boolean);
    procedure SetFooterMultiSummaries(Value: Boolean);
    procedure SetGridLineColor(Value: TColor);
    procedure SetGridLines(Value: TcxGridLines);
    procedure SetGroupByBox(Value: Boolean);
    procedure SetGroupFooterMultiSummaries(Value: Boolean);
    procedure SetGroupFooters(Value: TcxGridGroupFootersMode);
    procedure SetGroupRowHeight(Value: Integer);
    procedure SetGroupRowStyle(Value: TcxGridGroupRowStyle);
    procedure SetGroupSummaryLayout(Value: TcxGridGroupSummaryLayout);
    procedure SetHeader(Value: Boolean);
    procedure SetHeaderAutoHeight(Value: Boolean);
    procedure SetHeaderEndEllipsis(Value: Boolean);
    procedure SetHeaderHeight(Value: Integer);
    procedure SetIndicator(Value: Boolean);
    procedure SetIndicatorWidth(Value: Integer);
    procedure SetNewItemRow(Value: Boolean);
    procedure SetNewItemRowInfoText(const Value: string);
    procedure SetNewItemRowSeparatorColor(Value: TColor);
    procedure SetNewItemRowSeparatorWidth(Value: Integer);
    procedure SetRowSeparatorColor(Value: TColor);
    procedure SetRowSeparatorWidth(Value: Integer);
    procedure SetShowColumnFilterButtons(Value: TcxGridShowItemFilterButtons);
    procedure ReadNewItemRow(Reader: TReader);
    procedure ReadNewItemRowInfoText(Reader: TReader);
    procedure ReadNewItemRowSeparatorColor(Reader: TReader);
    procedure ReadNewItemRowSeparatorWidth(Reader: TReader);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure ItemCaptionAutoHeightChanged; override;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    procedure Assign(Source: TPersistent); override;
    function CanShowFooterMultiSummaries: Boolean; 
    function CanShowGroupFooterMultiSummaries: Boolean; 
    procedure CheckDataRowHeight(var AValue: Integer); virtual;
    procedure CheckGroupRowHeight(var AValue: Integer); virtual;
    function GetGridLineColor: TColor;
    function GetGroupSummaryLayout: TcxGridGroupSummaryLayout;
    function GetRowSeparatorColor: TColor;

    property GridView: TcxGridTableView read GetGridView;
    // obsolete - use GridView.NewItemRow
    property NewItemRow: Boolean read GetNewItemRow write SetNewItemRow;
    property NewItemRowInfoText: string read GetNewItemRowInfoText write SetNewItemRowInfoText;
    property NewItemRowSeparatorColor: TColor read GetNewItemRowSeparatorColor write SetNewItemRowSeparatorColor;
    property NewItemRowSeparatorWidth: Integer read GetNewItemRowSeparatorWidth write SetNewItemRowSeparatorWidth;
    property PrevGroupFooters: TcxGridGroupFootersMode read FPrevGroupFooters;
  published
    property CellAutoHeight;
    property CellTextMaxLineCount;
    property ColumnAutoWidth: Boolean read FColumnAutoWidth write SetColumnAutoWidth default False;
    property DataRowHeight: Integer read FDataRowHeight write SetDataRowHeight default 0;
    property ExpandButtonsForEmptyDetails: Boolean read GetExpandButtonsForEmptyDetails
      write SetExpandButtonsForEmptyDetails default True;
    property Footer: Boolean read FFooter write SetFooter default False;
    property FooterAutoHeight: Boolean read FFooterAutoHeight write SetFooterAutoHeight default False;
    property FooterMultiSummaries: Boolean read FFooterMultiSummaries write SetFooterMultiSummaries default False; 
    property GridLineColor: TColor read FGridLineColor write SetGridLineColor default clDefault;
    property GridLines: TcxGridLines read FGridLines write SetGridLines default glBoth;
    property GroupByBox: Boolean read FGroupByBox write SetGroupByBox default True;
    property GroupFooterMultiSummaries: Boolean read FGroupFooterMultiSummaries write SetGroupFooterMultiSummaries default False; 
    property GroupFooters: TcxGridGroupFootersMode read FGroupFooters write SetGroupFooters default gfInvisible;
    property GroupRowHeight: Integer read FGroupRowHeight write SetGroupRowHeight default 0;
    property GroupRowStyle: TcxGridGroupRowStyle read FGroupRowStyle write SetGroupRowStyle default grsStandard;
    property GroupSummaryLayout: TcxGridGroupSummaryLayout read FGroupSummaryLayout
      write SetGroupSummaryLayout default gslStandard;
    property Header: Boolean read FHeader write SetHeader default True;
    property HeaderAutoHeight: Boolean read GetHeaderAutoHeight write SetHeaderAutoHeight default False;
    property HeaderEndEllipsis: Boolean read GetHeaderEndEllipsis write SetHeaderEndEllipsis default False;
    property HeaderHeight: Integer read FHeaderHeight write SetHeaderHeight default 0;
    property Indicator: Boolean read FIndicator write SetIndicator default False;
    property IndicatorWidth: Integer read FIndicatorWidth write SetIndicatorWidth default cxGridDefaultIndicatorWidth;
    property RowSeparatorColor: TColor read FRowSeparatorColor write SetRowSeparatorColor default clDefault;
    property RowSeparatorWidth: Integer read FRowSeparatorWidth write SetRowSeparatorWidth default 0;
    property ShowColumnFilterButtons: TcxGridShowItemFilterButtons read GetShowColumnFilterButtons
      write SetShowColumnFilterButtons default sfbWhenSelected;
  end;

  // preview

  TcxGridPreviewPlace = (ppBottom, ppTop);

  TcxGridPreviewClass = class of TcxGridPreview;

  TcxGridPreview = class(TcxCustomGridOptions)
  private
    FAutoHeight: Boolean;
    FColumn: TcxGridColumn;
    FLeftIndent: Integer;
    FMaxLineCount: Integer;
    FPlace: TcxGridPreviewPlace;
    FRightIndent: Integer;
    FVisible: Boolean;
    function GetActive: Boolean;
    function GetGridView: TcxGridTableView;
    procedure SetAutoHeight(Value: Boolean);
    procedure SetColumn(Value: TcxGridColumn);
    procedure SetLeftIndent(Value: Integer);
    procedure SetMaxLineCount(Value: Integer);
    procedure SetPlace(Value: TcxGridPreviewPlace);
    procedure SetRightIndent(Value: Integer);
    procedure SetVisible(Value: Boolean);
  protected
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    procedure PropertyChanged;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    procedure Assign(Source: TPersistent); override;
    property Active: Boolean read GetActive;
    property GridView: TcxGridTableView read GetGridView;
  published
    property AutoHeight: Boolean read FAutoHeight write SetAutoHeight default True;
    property Column: TcxGridColumn read FColumn write SetColumn;
    property LeftIndent: Integer read FLeftIndent write SetLeftIndent
      default cxGridPreviewDefaultLeftIndent;
    property MaxLineCount: Integer read FMaxLineCount write SetMaxLineCount
      default cxGridPreviewDefaultMaxLineCount;
    property Place: TcxGridPreviewPlace read FPlace write SetPlace default ppBottom;
    property RightIndent: Integer read FRightIndent write SetRightIndent
      default cxGridPreviewDefaultRightIndent;
    property Visible: Boolean read FVisible write SetVisible default False;
  end;

  // styles

  TcxGridGetGroupStyleEvent = procedure(Sender: TcxGridTableView; ARecord: TcxCustomGridRecord;
    ALevel: Integer; {$IFDEF BCBCOMPATIBLE}var{$ELSE}out{$ENDIF} AStyle: TcxStyle) of object;

  TcxGridTableViewStyles = class(TcxCustomGridTableViewStyles)
  private
    FProcessingGroupSortedSummary: Boolean;
    FOnGetFooterStyle: TcxGridGetCellStyleEvent;
    FOnGetFooterStyleEx: TcxGridGetFooterStyleExEvent;
    FOnGetFooterSummaryStyle: TcxGridGetFooterSummaryStyleEvent;
    FOnGetGroupStyle: TcxGridGetGroupStyleEvent;
    FOnGetGroupSummaryStyle: TcxGridGetGroupSummaryStyleEvent;
    FOnGetHeaderStyle: TcxGridGetHeaderStyleEvent;
    FOnGetPreviewStyle: TcxGridGetCellStyleEvent;
    function GetGridViewValue: TcxGridTableView;
    procedure SetOnGetFooterStyle(Value: TcxGridGetCellStyleEvent);
    procedure SetOnGetFooterStyleEx(Value: TcxGridGetFooterStyleExEvent);
    procedure SetOnGetFooterSummaryStyle(Value: TcxGridGetFooterSummaryStyleEvent);
    procedure SetOnGetGroupStyle(Value: TcxGridGetGroupStyleEvent);
    procedure SetOnGetGroupSummaryStyle(Value: TcxGridGetGroupSummaryStyleEvent);
    procedure SetOnGetHeaderStyle(Value: TcxGridGetHeaderStyleEvent);
    procedure SetOnGetPreviewStyle(Value: TcxGridGetCellStyleEvent);
  protected
    procedure GetDefaultViewParams(Index: Integer; AData: TObject; out AParams: TcxViewParams); override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure GetCellContentParams(ARecord: TcxCustomGridRecord; AItem: TObject;
      out AParams: TcxViewParams); override;
    procedure GetContentParams(ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      out AParams: TcxViewParams); override;
    procedure GetFooterCellParams(ARow: TcxCustomGridRow; AColumn: TcxGridColumn;
      AFooterGroupLevel: Integer; ASummaryItem: TcxDataSummaryItem; out AParams: TcxViewParams); virtual;
    procedure GetFooterParams(ARow: TcxCustomGridRow; AColumn: TcxGridColumn;
      AFooterGroupLevel: Integer; ASummaryItem: TcxDataSummaryItem; out AParams: TcxViewParams); virtual;
    procedure GetGroupParams(ARecord: TcxCustomGridRecord; ALevel: Integer;
      out AParams: TcxViewParams); virtual;
    procedure GetGroupSummaryCellContentParams(ARow: TcxGridGroupRow;
      ASummaryItem: TcxDataSummaryItem; out AParams: TcxViewParams); virtual;
    procedure GetGroupSummaryCellParams(ARow: TcxGridGroupRow;
      ASummaryItem: TcxDataSummaryItem; out AParams: TcxViewParams); virtual;
    procedure GetGroupSummaryParams(ARow: TcxGridGroupRow; ASummaryItem: TcxDataSummaryItem;
      out AParams: TcxViewParams); virtual;
    procedure GetHeaderParams(AItem: TcxGridColumn; out AParams: TcxViewParams); virtual;
    procedure GetPreviewParams(ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      out AParams: TcxViewParams); virtual;
    procedure GetRecordContentParams(ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      out AParams: TcxViewParams); override;
    property GridView: TcxGridTableView read GetGridViewValue;
  published
    property FilterRowInfoText: TcxStyle index vsFilterRowInfoText read GetValue write SetValue;
    property Footer: TcxStyle index vsFooter read GetValue write SetValue;
    property Group: TcxStyle index vsGroup read GetValue write SetValue;
    property GroupByBox: TcxStyle index vsGroupByBox read GetValue write SetValue;
    property GroupFooterSortedSummary: TcxStyle index vsGroupFooterSortedSummary read GetValue write SetValue;
    property GroupSortedSummary: TcxStyle index vsGroupSortedSummary read GetValue write SetValue;
    property GroupSummary: TcxStyle index vsGroupSummary read GetValue write SetValue;
    property Header: TcxStyle index vsHeader read GetValue write SetValue;
    property Indicator: TcxStyle index vsIndicator read GetValue write SetValue;
    property NewItemRowInfoText: TcxStyle index vsNewItemRowInfoText read GetValue write SetValue;
    property Preview: TcxStyle index vsPreview read GetValue write SetValue;
    property StyleSheet;
    property OnGetFooterStyle: TcxGridGetCellStyleEvent read FOnGetFooterStyle write SetOnGetFooterStyle;
    property OnGetFooterStyleEx: TcxGridGetFooterStyleExEvent read FOnGetFooterStyleEx write SetOnGetFooterStyleEx;
    property OnGetFooterSummaryStyle: TcxGridGetFooterSummaryStyleEvent read FOnGetFooterSummaryStyle write SetOnGetFooterSummaryStyle;
    property OnGetGroupStyle: TcxGridGetGroupStyleEvent read FOnGetGroupStyle write SetOnGetGroupStyle;
    property OnGetGroupSummaryStyle: TcxGridGetGroupSummaryStyleEvent read FOnGetGroupSummaryStyle write SetOnGetGroupSummaryStyle;
    property OnGetHeaderStyle: TcxGridGetHeaderStyleEvent read FOnGetHeaderStyle write SetOnGetHeaderStyle;
    property OnGetPreviewStyle: TcxGridGetCellStyleEvent read FOnGetPreviewStyle write SetOnGetPreviewStyle;
  end;

  TcxGridTableViewStyleSheet = class(TcxCustomStyleSheet)
  private
    function GetStylesValue: TcxGridTableViewStyles;
    procedure SetStylesValue(Value: TcxGridTableViewStyles);
  public
    class function GetStylesClass: TcxCustomStylesClass; override;
  published
    property Styles: TcxGridTableViewStyles read GetStylesValue write SetStylesValue;
  end;

  // grid view

  TcxGridTableSummaryGroupItemLink = class(TcxDataSummaryGroupItemLink,
    {$IFNDEF DELPHI6}IUnknown,{$ENDIF} IcxStoredObject)
  private
    function GetColumn: TcxGridColumn;
    procedure SetColumn(Value: TcxGridColumn);
    function GetGridView: TcxGridTableView;
  protected
    // IInterface
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    // IcxStoredObject
    function GetObjectName: string;
    function GetProperties(AProperties: TStrings): Boolean;
    procedure GetPropertyValue(const AName: string; var AValue: Variant);
    procedure SetPropertyValue(const AName: string; const AValue: Variant);
    property GridView: TcxGridTableView read GetGridView;
  published
    property Column: TcxGridColumn read GetColumn write SetColumn;
  end;

  IcxGridSummaryItem = interface
    ['{6F9A0C3E-E33F-4E77-9357-82F1D19CDB67}']
    function GetDisplayText: string;
    function GetVisibleForCustomization: Boolean;
    property DisplayText: string read GetDisplayText;
    property VisibleForCustomization: Boolean read GetVisibleForCustomization;
  end;

  TcxGridTableSummaryItem = class(TcxDataSummaryItem,
    {$IFNDEF DELPHI6}IUnknown,{$ENDIF} IcxStoredObject, IcxGridSummaryItem)
  private
    FDisplayText: string;
    FVisibleForCustomization: Boolean;
    function GetColumn: TcxGridColumn;
    function GetGridView: TcxGridTableView;
    procedure SetColumn(Value: TcxGridColumn);
    procedure SetDisplayText(const Value: string);
    procedure SetVisibleForCustomization(Value: Boolean);
  protected
    // IInterface
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    // IcxStoredObject
    function GetObjectName: string;
    function GetProperties(AProperties: TStrings): Boolean;
    procedure GetPropertyValue(const AName: string; var AValue: Variant);
    procedure SetPropertyValue(const AName: string; const AValue: Variant);
    // IcxGridSummaryItem
    function GetDisplayText: string;
    function GetVisibleForCustomization: Boolean;

    property GridView: TcxGridTableView read GetGridView;
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
  published
    property Column: TcxGridColumn read GetColumn write SetColumn;
    property DisplayText: string read FDisplayText write SetDisplayText;
    property Sorted;
    property VisibleForCustomization: Boolean read FVisibleForCustomization
      write SetVisibleForCustomization default True;
  end;

  TcxGridColumnEvent = procedure(Sender: TcxGridTableView; AColumn: TcxGridColumn) of object;
  TcxGridIndicatorCellCustomDrawEvent = procedure(Sender: TcxGridTableView;
    ACanvas: TcxCanvas; AViewInfo: TcxCustomGridIndicatorItemViewInfo; var ADone: Boolean) of object;

  TcxGridTableView = class(TcxCustomGridTableView)
  private
    FAllowCellMerging: Boolean;
    FFilterRow: TcxGridFilterRowOptions;
    FNewItemRow: TcxGridNewItemRowOptions;
    FPreview: TcxGridPreview;
    FOnColumnHeaderClick: TcxGridColumnEvent;
    FOnColumnPosChanged: TcxGridColumnEvent;
    FOnColumnSizeChanged: TcxGridColumnEvent;
    FOnCustomDrawColumnHeader: TcxGridColumnCustomDrawHeaderEvent;
    FOnCustomDrawFooterCell: TcxGridColumnCustomDrawHeaderEvent;
    FOnCustomDrawGroupCell: TcxGridTableCellCustomDrawEvent;
    FOnCustomDrawGroupSummaryCell: TcxGridGroupSummaryCellCustomDrawEvent;
    FOnCustomDrawIndicatorCell: TcxGridIndicatorCellCustomDrawEvent;
    FOnLeftPosChanged: TNotifyEvent;

    function GetBackgroundBitmaps: TcxGridTableBackgroundBitmaps;
    function GetColumn(Index: Integer): TcxGridColumn;
    function GetColumnCount: Integer;
    function GetController: TcxGridTableController;
    function GetDataController: TcxGridDataController;
    function GetDateTimeHandling: TcxGridTableDateTimeHandling;
    function GetFiltering: TcxGridTableFiltering;
    function GetGroupedColumn(Index: Integer): TcxGridColumn;
    function GetGroupedColumnCount: Integer;
    function GetOptionsBehavior: TcxGridTableOptionsBehavior;
    function GetOptionsCustomize: TcxGridTableOptionsCustomize;
    function GetOptionsData: TcxGridTableOptionsData;
    function GetOptionsSelection: TcxGridTableOptionsSelection;
    function GetOptionsView: TcxGridTableOptionsView;
    function GetPainter: TcxGridTablePainter;
    function GetStyles: TcxGridTableViewStyles;
    function GetViewData: TcxGridViewData;
    function GetViewInfo: TcxGridTableViewInfo;
    function GetVisibleColumn(Index: Integer): TcxGridColumn;
    function GetVisibleColumnCount: Integer;
    procedure SetBackgroundBitmaps(Value: TcxGridTableBackgroundBitmaps);
    procedure SetColumn(Index: Integer; Value: TcxGridColumn);
    procedure SetDataController(Value: TcxGridDataController);
    procedure SetDateTimeHandling(Value: TcxGridTableDateTimeHandling);
    procedure SetFiltering(Value: TcxGridTableFiltering);
    procedure SetFilterRow(Value: TcxGridFilterRowOptions);
    procedure SetNewItemRow(Value: TcxGridNewItemRowOptions);
    procedure SetOnColumnHeaderClick(Value: TcxGridColumnEvent);
    procedure SetOnColumnPosChanged(Value: TcxGridColumnEvent);
    procedure SetOnColumnSizeChanged(Value: TcxGridColumnEvent);
    procedure SetOnCustomDrawColumnHeader(Value: TcxGridColumnCustomDrawHeaderEvent);
    procedure SetOnCustomDrawFooterCell(Value: TcxGridColumnCustomDrawHeaderEvent);
    procedure SetOnCustomDrawGroupCell(Value: TcxGridTableCellCustomDrawEvent);
    procedure SetOnCustomDrawGroupSummaryCell(Value: TcxGridGroupSummaryCellCustomDrawEvent);
    procedure SetOnCustomDrawIndicatorCell(Value: TcxGridIndicatorCellCustomDrawEvent);
    procedure SetOnLeftPosChanged(Value: TNotifyEvent);
    procedure SetOptionsBehavior(Value: TcxGridTableOptionsBehavior);
    procedure SetOptionsCustomize(Value: TcxGridTableOptionsCustomize);
    procedure SetOptionsData(Value: TcxGridTableOptionsData);
    procedure SetOptionsSelection(Value: TcxGridTableOptionsSelection);
    procedure SetOptionsView(Value: TcxGridTableOptionsView);
    procedure SetPreview(Value: TcxGridPreview);
    procedure SetStyles(Value: TcxGridTableViewStyles);

  protected
    // IcxStoredObject
    function GetProperties(AProperties: TStrings): Boolean; override;
    procedure GetPropertyValue(const AName: string; var AValue: Variant); override;
    procedure SetPropertyValue(const AName: string; const AValue: Variant); override;
    // IcxGridViewLayoutEditorSupport - for design-time layout editor
    procedure AssignLayout(ALayoutView: TcxCustomGridView); override;
    procedure BeforeEditLayout(ALayoutView: TcxCustomGridView); override;
    function GetLayoutCustomizationFormButtonCaption: string; override;

    procedure CreateOptions; override;
    procedure DestroyOptions; override;

    function CanCellMerging: Boolean; virtual;
    function CanOffset(ARecordCountDelta: Integer): Boolean; override;
    function CanOffsetHorz: Boolean; virtual;
    procedure DetailDataChanged(ADetail: TcxCustomGridView); override;
    procedure DoAssign(ASource: TcxCustomGridView); override;
    procedure GetItemsListForClipboard(AItems: TList; ACopyAll: Boolean); override;
    function GetResizeOnBoundsChange: Boolean; override;
    function HasCellMerging: Boolean;
    function IsEqualHeightRecords: Boolean; override;
    function IsRecordHeightDependsOnData: Boolean; override;
    function UpdateOnDetailDataChange(ADetail: TcxCustomGridView): Boolean; virtual;

    function GetControllerClass: TcxCustomGridControllerClass; override;
    function GetDataControllerClass: TcxCustomDataControllerClass; override;
    function GetPainterClass: TcxCustomGridPainterClass; override;
    function GetViewDataClass: TcxCustomGridViewDataClass; override;
    function GetViewInfoClass: TcxCustomGridViewInfoClass; override;

    function GetBackgroundBitmapsClass: TcxCustomGridBackgroundBitmapsClass; override;
    function GetDateTimeHandlingClass: TcxCustomGridTableDateTimeHandlingClass; override;
    function GetFilteringClass: TcxCustomGridTableFilteringClass; override;
    function GetFilterRowOptionsClass: TcxGridFilterRowOptionsClass; virtual;
    function GetNewItemRowOptionsClass: TcxGridNewItemRowOptionsClass; virtual;
    function GetOptionsBehaviorClass: TcxCustomGridOptionsBehaviorClass; override;
    function GetOptionsCustomizeClass: TcxCustomGridTableOptionsCustomizeClass; override;
    function GetOptionsDataClass: TcxCustomGridOptionsDataClass; override;
    function GetOptionsSelectionClass: TcxCustomGridOptionsSelectionClass; override;
    function GetOptionsViewClass: TcxCustomGridOptionsViewClass; override;
    function GetPreviewClass: TcxGridPreviewClass; virtual;
    function GetStylesClass: TcxCustomGridViewStylesClass; override;

    function GetSummaryGroupItemLinkClass: TcxDataSummaryGroupItemLinkClass; override;
    function GetSummaryItemClass: TcxDataSummaryItemClass; override;

    function GetItemClass: TcxCustomGridTableItemClass; override;
    procedure ItemVisibilityChanged(AItem: TcxCustomGridTableItem; Value: Boolean); override;

    function CalculateDataCellSelected(ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; AUseViewInfo: Boolean;
      ACellViewInfo: TcxGridTableCellViewInfo): Boolean; override;

    procedure DoColumnHeaderClick(AColumn: TcxGridColumn); virtual;
    procedure DoColumnPosChanged(AColumn: TcxGridColumn); virtual;
    procedure DoColumnSizeChanged(AColumn: TcxGridColumn); virtual;
    procedure DoCustomDrawColumnHeader(ACanvas: TcxCanvas; AViewInfo: TcxGridColumnHeaderViewInfo;
      var ADone: Boolean); virtual;
    procedure DoCustomDrawFooterCell(ACanvas: TcxCanvas; AViewInfo: TcxGridColumnHeaderViewInfo;
      var ADone: Boolean); virtual;
    procedure DoCustomDrawGroupCell(ACanvas: TcxCanvas; AViewInfo: TcxGridTableCellViewInfo;
      var ADone: Boolean); virtual;
    procedure DoCustomDrawGroupSummaryCell(ACanvas: TcxCanvas; AViewInfo: TcxCustomGridViewCellViewInfo;
      var ADone: Boolean); virtual;
    procedure DoCustomDrawIndicatorCell(ACanvas: TcxCanvas; AViewInfo: TcxCustomGridIndicatorItemViewInfo;
      var ADone: Boolean); virtual;
    procedure DoLeftPosChanged; virtual;
    function HasCustomDrawColumnHeader: Boolean;
    function HasCustomDrawFooterCell: Boolean;
    function HasCustomDrawGroupCell: Boolean;
    function HasCustomDrawGroupSummaryCell: Boolean;
    function HasCustomDrawIndicatorCell: Boolean;

    property AllowCellMerging: Boolean read FAllowCellMerging write FAllowCellMerging;
  public
    constructor Create(AOwner: TComponent); override;

    function CreateColumn: TcxGridColumn;

    // for extended lookup edit
    class function CanBeLookupList: Boolean; override;

    property ColumnCount: Integer read GetColumnCount;
    property Columns[Index: Integer]: TcxGridColumn read GetColumn write SetColumn;
    property Controller: TcxGridTableController read GetController;
    property GroupedColumnCount: Integer read GetGroupedColumnCount;
    property GroupedColumns[Index: Integer]: TcxGridColumn read GetGroupedColumn;
    property Painter: TcxGridTablePainter read GetPainter;
    property ViewData: TcxGridViewData read GetViewData;
    property ViewInfo: TcxGridTableViewInfo read GetViewInfo;
    property VisibleColumnCount: Integer read GetVisibleColumnCount;
    property VisibleColumns[Index: Integer]: TcxGridColumn read GetVisibleColumn;
  published
    property BackgroundBitmaps: TcxGridTableBackgroundBitmaps read GetBackgroundBitmaps write SetBackgroundBitmaps;
    property DataController: TcxGridDataController read GetDataController write SetDataController;
    property DateTimeHandling: TcxGridTableDateTimeHandling read GetDateTimeHandling write SetDateTimeHandling;
    property Filtering: TcxGridTableFiltering read GetFiltering write SetFiltering;
    property FilterRow: TcxGridFilterRowOptions read FFilterRow write SetFilterRow;
    property NewItemRow: TcxGridNewItemRowOptions read FNewItemRow write SetNewItemRow;
    property OptionsBehavior: TcxGridTableOptionsBehavior read GetOptionsBehavior write SetOptionsBehavior;
    property OptionsCustomize: TcxGridTableOptionsCustomize read GetOptionsCustomize write SetOptionsCustomize;
    property OptionsData: TcxGridTableOptionsData read GetOptionsData write SetOptionsData;
    property OptionsSelection: TcxGridTableOptionsSelection read GetOptionsSelection write SetOptionsSelection;
    property OptionsView: TcxGridTableOptionsView read GetOptionsView write SetOptionsView;
    property Preview: TcxGridPreview read FPreview write SetPreview;
    property Styles: TcxGridTableViewStyles read GetStyles write SetStyles ;

    property OnColumnHeaderClick: TcxGridColumnEvent read FOnColumnHeaderClick write SetOnColumnHeaderClick;
    property OnColumnPosChanged: TcxGridColumnEvent read FOnColumnPosChanged write SetOnColumnPosChanged;
    property OnColumnSizeChanged: TcxGridColumnEvent read FOnColumnSizeChanged write SetOnColumnSizeChanged;
    property OnCustomDrawColumnHeader: TcxGridColumnCustomDrawHeaderEvent read FOnCustomDrawColumnHeader write SetOnCustomDrawColumnHeader;
    property OnCustomDrawFooterCell: TcxGridColumnCustomDrawHeaderEvent read FOnCustomDrawFooterCell write SetOnCustomDrawFooterCell;
    property OnCustomDrawGroupCell: TcxGridTableCellCustomDrawEvent read FOnCustomDrawGroupCell write SetOnCustomDrawGroupCell;
    property OnCustomDrawGroupSummaryCell: TcxGridGroupSummaryCellCustomDrawEvent read FOnCustomDrawGroupSummaryCell write SetOnCustomDrawGroupSummaryCell;
    property OnCustomDrawIndicatorCell: TcxGridIndicatorCellCustomDrawEvent read FOnCustomDrawIndicatorCell write SetOnCustomDrawIndicatorCell;
    property OnCustomization;
    property OnInitGroupingDateRanges;
    property OnLeftPosChanged: TNotifyEvent read FOnLeftPosChanged write SetOnLeftPosChanged;
  end;

  { TcxGridColumnAccess }

  TcxGridColumnAccess = class
  public
    class function CanCellMerging(AInstance: TcxGridColumn): Boolean;
    class function CanShowGroupFooters(AInstance: TcxGridColumn): Boolean;
    class procedure DoCustomDrawGroupSummaryCell(AInstance: TcxGridColumn;
      ACanvas: TcxCanvas; AViewInfo: TcxCustomGridViewCellViewInfo; var ADone: Boolean); virtual;
    class function HasCustomDrawGroupSummaryCell(AInstance: TcxGridColumn): Boolean;
  end;

  { TcxGridTableViewAccess }

  TcxGridTableViewAccess = class
  public
    class procedure DoColumnPosChanged(AInstance: TcxGridTableView;
      AColumn: TcxGridColumn);
    class procedure DoCustomDrawGroupCell(AInstance: TcxGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
    class procedure DoCustomDrawGroupSummaryCell(AInstance: TcxGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxCustomGridViewCellViewInfo; var ADone: Boolean); virtual;
    class function HasCustomDrawGroupCell(AInstance: TcxGridTableView): Boolean;
    class function HasCustomDrawGroupSummaryCell(AInstance: TcxGridTableView): Boolean;
  end;

implementation

uses
  SysUtils, Math, dxOffice11, cxVariants, cxDataUtils, cxFilterControlUtils,
  cxLibraryConsts, cxGridRows, cxGridStrs;

const
  GroupByBoxLeftOffset = 6;
  GroupByBoxTopOffset = 8;
  GroupByBoxHorOffset = 4;
  GroupByBoxLineVerOffset = 4;
  GroupByBoxColumnWidth = 100;
  GroupByBoxLineWidth = 1;
  GroupByBoxLineColor = clBtnText;
  HScrollDelta = 10;

  FooterSeparatorWidth = 1;

  TopIndexNone = -2;
  RowIndexNone = -1;

  ColumnHeaderHitTestCodes = [htColumnHeader];

  ColumnHeaderMovingZoneSize = 15;

  ColumnSizingMarkWidth = 1;
  RowSizingMarkWidth = 1;

  ScrollHotZoneWidth = 15;

type
  TcxCustomGridAccess = class(TcxCustomGrid);

{ TcxCustomGridColumnHitTest }

procedure TcxCustomGridColumnHitTest.Assign(Source: TcxCustomGridHitTest);
begin
  inherited Assign(Source);
  if Source is TcxCustomGridColumnHitTest then
  begin
    Column := TcxCustomGridColumnHitTest(Source).Column;
    ColumnContainerKind := TcxCustomGridColumnHitTest(Source).ColumnContainerKind;
  end;
end;

{ TcxGridGroupByBoxHitTest }

class function TcxGridGroupByBoxHitTest.GetHitTestCode: Integer;
begin
  Result := htGroupByBox;
end;

{ TcxGridColumnHeaderHitTest }

class function TcxGridColumnHeaderHitTest.GetHitTestCode: Integer;
begin
  Result := htColumnHeader;
end;

function TcxGridColumnHeaderHitTest.DragAndDropObjectClass: TcxCustomGridDragAndDropObjectClass;
begin
  if Column.CanMove then
    Result := TcxGridTableView(GridView).Controller.GetColumnHeaderDragAndDropObjectClass
  else
    Result := nil;
end;

{ TcxGridColumnHeaderHorzSizingEdgeHitTest }

class function TcxGridColumnHeaderHorzSizingEdgeHitTest.GetHitTestCode: Integer;
begin
  Result := htColumnHeaderHorzSizingEdge;
end;

function TcxGridColumnHeaderHorzSizingEdgeHitTest.Cursor: TCursor;
begin
  Result := crcxGridHorzSize;
end;

function TcxGridColumnHeaderHorzSizingEdgeHitTest.DragAndDropObjectClass: TcxCustomGridDragAndDropObjectClass;
begin
  Result := TcxGridColumnHorzSizingObject;
end;

{ TcxGridColumnHeaderFilterButtonHitTest }

class function TcxGridColumnHeaderFilterButtonHitTest.GetHitTestCode: Integer;
begin
  Result := htColumnHeaderFilterButton;
end;

{ TcxGridHeaderHitTest }

class function TcxGridHeaderHitTest.GetHitTestCode: Integer;
begin
  Result := htHeader;
end;

{ TcxGridFooterHitTest }

class function TcxGridFooterHitTest.GetHitTestCode: Integer;
begin
  Result := htFooter;
end;

{ TcxGridFooterCellHitTest }

procedure TcxGridFooterCellHitTest.Assign(Source: TcxCustomGridHitTest);
begin
  inherited Assign(Source);
  if Source is TcxGridFooterCellHitTest then
    SummaryItem := TcxGridFooterCellHitTest(Source).SummaryItem;
end;

class function TcxGridFooterCellHitTest.GetHitTestCode: Integer;
begin
  Result := htFooterCell;
end;

{ TcxGridGroupFooterHitTest }

class function TcxGridGroupFooterHitTest.GetHitTestCode: Integer;
begin
  Result := htGroupFooter;
end;

{ TcxGridGroupFooterCellHitTest }

class function TcxGridGroupFooterCellHitTest.GetHitTestCode: Integer;
begin
  Result := htGroupFooterCell;
end;

{ TcxGridRowIndicatorHitTest }

class function TcxGridRowIndicatorHitTest.GetHitTestCode: Integer;
begin
  Result := htRowIndicator;
end;

procedure TcxGridRowIndicatorHitTest.Assign(Source: TcxCustomGridHitTest);
begin
  inherited Assign(Source);
  if Source is TcxGridRowIndicatorHitTest then
    MultiSelect := TcxGridRowIndicatorHitTest(Source).MultiSelect;
end;

function TcxGridRowIndicatorHitTest.Cursor: TCursor;
begin
  if MultiSelect then
    Result := crcxGridSelectRow
  else
    Result := inherited Cursor;
end;

{ TcxGridRowSizingEdgeHitTest }

class function TcxGridRowSizingEdgeHitTest.GetHitTestCode: Integer;
begin
  Result := htRowSizingEdge;
end;

function TcxGridRowSizingEdgeHitTest.Cursor: TCursor;
begin
  Result := crcxGridVertSize;
end;

function TcxGridRowSizingEdgeHitTest.DragAndDropObjectClass: TcxCustomGridDragAndDropObjectClass;
begin
  Result := TcxGridRowSizingObject;
end;

{ TcxGridIndicatorHitTest }

class function TcxGridIndicatorHitTest.GetHitTestCode: Integer;
begin
  Result := htIndicator;
end;

{ TcxGridIndicatorHeaderHitTest }

class function TcxGridIndicatorHeaderHitTest.GetHitTestCode: Integer;
begin
  Result := htIndicatorHeader;
end;

{ TcxGridRowLevelIndentHitTest }

class function TcxGridRowLevelIndentHitTest.GetHitTestCode: Integer;
begin
  Result := htRowLevelIndent;
end;

class function TcxGridRowLevelIndentHitTest.CanClick: Boolean;
begin
  Result := False;
end;

{ TcxGridGroupSummaryHitTest }

procedure TcxGridGroupSummaryHitTest.Assign(Source: TcxCustomGridHitTest);
begin
  inherited Assign(Source);
  if Source is TcxGridGroupSummaryHitTest then
    SummaryItem := TcxGridGroupSummaryHitTest(Source).SummaryItem;
end;

function TcxGridGroupSummaryHitTest.GetColumn: TcxGridColumn;
begin
  if SummaryItem = nil then
    Result := nil
  else
    Result := SummaryItem.ItemLink as TcxGridColumn;
end;

class function TcxGridGroupSummaryHitTest.GetHitTestCode: Integer;
begin
  Result := htGroupSummary;
end;

{ TcxCustomGridRow }

function TcxCustomGridRow.GetAsGroupRow: TcxGridGroupRow;
begin
  Result := Self as TcxGridGroupRow;
end;

function TcxCustomGridRow.GetAsMasterDataRow: TcxGridMasterDataRow;
begin
  Result := Self as TcxGridMasterDataRow;
end;

function TcxCustomGridRow.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

function TcxCustomGridRow.GetGridViewLevel: TcxGridLevel;
begin
  Result := TcxGridLevel(GridView.Level);
end;

function TcxCustomGridRow.GetIsFilterRow: Boolean;
begin
  Result := ViewData.FilterRow = Self;
end;

function TcxCustomGridRow.GetIsNewItemRow: Boolean;
begin
  Result := IsNewItemRecord;
end;

function TcxCustomGridRow.GetViewData: TcxGridViewData;
begin
  Result := TcxGridViewData(inherited ViewData);
end;

procedure TcxCustomGridRow.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_LEFT:
      if Expandable and Expanded then
      begin
        Expanded := False;
        Key := 0;
      end;
    VK_RIGHT:
      if Expandable and not Expanded then
      begin
        Expanded := True;
        Key := 0;
      end;
    VK_MULTIPLY:
      if Expandable then
      begin
        GridView.Controller.EatKeyPress := True;
        Expand(True);
        Key := 0;
      end;
  end;
end;

function TcxCustomGridRow.ExpandOnDblClick: Boolean;
begin
  Result := Expandable;
end;

function TcxCustomGridRow.SupportsCellMultiSelect: Boolean;
begin
  Result := False;
end;

{ TcxGridDataRow }

function TcxGridDataRow.GetHasCells: Boolean;
begin
  Result := True;
end;

function TcxGridDataRow.GetViewInfoCacheItemClass: TcxCustomGridViewInfoCacheItemClass;
begin
  Result := TcxGridTableViewInfoCacheItem;
end;

function TcxGridDataRow.GetViewInfoClass: TcxCustomGridRecordViewInfoClass;
begin
  Result := TcxGridDataRowViewInfo;
end;

function TcxGridDataRow.SupportsCellMultiSelect: Boolean;
begin
  Result := True;
end;

{ TcxGridNewItemRow }

function TcxGridNewItemRow.SupportsCellMultiSelect: Boolean;
begin
  Result := False;
end;

{ TcxGridFilterRow }

destructor TcxGridFilterRow.Destroy;
begin
  Selected := False;
  inherited;
end;

function TcxGridFilterRow.GetFilterCriteriaItem(Index: Integer): TcxFilterCriteriaItem;
begin
  Result := GridView.Columns[Index].DataBinding.FilterCriteriaItem;
  if (Result <> nil) and not IsFilterOperatorSupported(Result.OperatorKind, Result.Value) then
    Result := nil;
end;

procedure TcxGridFilterRow.RefreshRecordInfo;
begin
  with RecordInfo do
  begin
    Expanded := False;
    Level := 0;
    RecordIndex := -1;
  end
end;

function TcxGridFilterRow.GetSelected: Boolean;
begin
  Result := FSelected;
end;

function TcxGridFilterRow.GetVisible: Boolean;
begin
  Result := True;
end;

procedure TcxGridFilterRow.SetSelected(Value: Boolean);
begin
  if FSelected <> Value then
  begin
    GridView.Controller.FilterRowFocusChanging(Value);
    FSelected := Value;
    Invalidate;
    GridView.Controller.FilterRowFocusChanged;
  end;
end;

function TcxGridFilterRow.GetDisplayText(Index: Integer): string;
var
  AFilterCriteriaItem: TcxFilterCriteriaItem;
begin
  AFilterCriteriaItem := FilterCriteriaItems[Index];
  if AFilterCriteriaItem = nil then
    Result := ''
  else
    Result := AFilterCriteriaItem.DisplayValue;
end;

function TcxGridFilterRow.GetValue(Index: Integer): Variant;
var
  AFilterCriteriaItem: TcxFilterCriteriaItem;
begin
  AFilterCriteriaItem := FilterCriteriaItems[Index];
  if AFilterCriteriaItem = nil then
    Result := Null
  else
    Result := AFilterCriteriaItem.Value;
end;

procedure TcxGridFilterRow.SetDisplayText(Index: Integer; const Value: string);
var
  AFilterCriteriaItem: TcxFilterCriteriaItem;
begin
  AFilterCriteriaItem := FilterCriteriaItems[Index];
  if AFilterCriteriaItem <> nil then
    AFilterCriteriaItem.DisplayValue := Value;
end;

procedure TcxGridFilterRow.SetValue(Index: Integer; const Value: Variant);
var
  AGridView: TcxGridTableView;
begin
  AGridView := GridView;
  AGridView.Controller.KeepFilterRowFocusing := True;
  try
    if VarIsSoftNull(Value) then
      AGridView.Columns[Index].DataBinding.Filtered := False
    else
    begin
      DataController.Filter.BeginUpdate;
      try
        DataController.Filter.Active := True;
        AGridView.Columns[Index].DataBinding.AddToFilter(nil,
          GetFilterOperatorKind(Value, True), Value,
          GetDisplayTextForValue(Index, Value), True);
      finally
        DataController.Filter.EndUpdate;
      end;
    end;
  finally
    AGridView.Controller.KeepFilterRowFocusing := False;
  end;
end;

function TcxGridFilterRow.GetDisplayTextForValue(AIndex: Integer; const AValue: Variant): string;
var
  AValueList: TcxGridFilterValueList;
  AValueIndex: Integer;
begin
  AValueList := ViewData.CreateFilterValueList;
  try
    GridView.Columns[AIndex].DataBinding.GetFilterValues(AValueList);
    AValueIndex := AValueList.FindItemByValue(AValue);
    if AValueIndex = -1 then
      Result := GridView.Columns[AIndex].GetProperties(Self).GetDisplayText(AValue)
    else
      Result := AValueList[AValueIndex].DisplayText;
  finally
    AValueList.Free;
  end;
end;

function TcxGridFilterRow.GetFilterOperatorKind(const AValue: Variant; ACheckMask: Boolean): TcxFilterOperatorKind;

  function HasMask(const AValue: string): Boolean;
  begin
    Result :=
      (Pos(DataController.Filter.PercentWildcard, AValue) <> 0) or
      (Pos(DataController.Filter.UnderscoreWildcard, AValue) <> 0);
  end;

begin
  if VarIsStr(AValue) and (not ACheckMask or HasMask(AValue)) then
    Result := foLike
  else
    Result := foEqual;
end;

function TcxGridFilterRow.IsFilterOperatorSupported(AKind: TcxFilterOperatorKind;
  const AValue: Variant): Boolean;
begin
  Result := (AKind = foEqual) or (GetFilterOperatorKind(AValue, False) = AKind);
end;

procedure TcxGridFilterRow.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_ESCAPE then
  begin
    Focused := False;
    Key := 0;
  end;
end;

function TcxGridFilterRow.CanFocusCells: Boolean;
begin
  Result := True;
end;

function TcxGridFilterRow.IsEmpty: Boolean;
{var
  I: Integer;}
begin
{  for I := 0 to ValueCount - 1 do
  begin
    Result := FilterCriteriaItems[I] = nil;
    if not Result then Exit;
  end;
  Result := True;}
  Result := DataController.Filter.IsEmpty;
end;

{ TcxGridMasterDataRow }

function TcxGridMasterDataRow.GetActiveDetailGridView: TcxCustomGridView;
begin
  if ActiveDetailIndex = -1 then
    Result := nil
  else
    Result := DetailGridViews[ActiveDetailIndex];
end;

function TcxGridMasterDataRow.GetActiveDetailGridViewExists: Boolean;
begin
  Result := IsValid and (ActiveDetailIndex <> -1) and DetailGridViewExists[ActiveDetailIndex];
end;

function TcxGridMasterDataRow.GetActiveDetailIndex: Integer;
begin
  Result := InternalActiveDetailIndex;
  if (Result <> -1) and not GridView.IsDestroying then
    if not GridViewLevel[Result].Visible then
    begin
      GridView.BeginUpdate;
      try
        Result := GridView.GetDefaultActiveDetailIndex;
        ActiveDetailIndex := Result;
      finally
        GridView.CancelUpdate;
      end;
    end
    else
      if not GridViewLevel.Options.TabsForEmptyDetails and not DetailGridViewHasData[Result] then
      begin
        GridView.BeginUpdate;
        try
          for Result := 0 to DetailGridViewCount - 1 do
            if DetailGridViewHasData[Result] then
            begin
              ActiveDetailIndex := Result;
              Exit;
            end;
          Result := -1;
        finally
          GridView.CancelUpdate;
        end;
      end;
end;

function TcxGridMasterDataRow.GetActiveDetailLevel: TcxGridLevel;
begin
  if ActiveDetailIndex = -1 then
    Result := nil
  else
    Result := GridViewLevel[ActiveDetailIndex];
end;

function TcxGridMasterDataRow.GetDetailGridView(Index: Integer): TcxCustomGridView;
begin
  Result := DataController.GetDetailLinkObject(RecordIndex, Index) as TcxCustomGridView;
end;

function TcxGridMasterDataRow.GetDetailGridViewCount: Integer;
begin
  Result := DataController.Relations.Count;
end;

function TcxGridMasterDataRow.GetDetailGridViewExists(Index: Integer): Boolean;
begin
  Result := DataController.IsDetailDataControllerExist(RecordIndex, Index);
end;

function TcxGridMasterDataRow.GetDetailGridViewHasData(Index: Integer): Boolean;
begin
  Result := DataController.GetDetailHasChildren(RecordIndex, Index);
end;

function TcxGridMasterDataRow.GetInternalActiveDetailGridView: TcxCustomGridView;
begin
  if InternalActiveDetailIndex = -1 then
    Result := nil
  else
    Result := DetailGridViews[InternalActiveDetailIndex];
end;

function TcxGridMasterDataRow.GetInternalActiveDetailGridViewExists: Boolean;
begin
  Result := IsValid and (InternalActiveDetailIndex <> -1) and DetailGridViewExists[InternalActiveDetailIndex];
end;

function TcxGridMasterDataRow.GetInternalActiveDetailIndex: Integer;
begin
  Result := DataController.GetDetailActiveRelationIndex(RecordIndex);
end;

procedure TcxGridMasterDataRow.SetActiveDetailIndex(Value: Integer);
var
  AGridView: TcxCustomGridTableView;
  APrevValue: Integer;
  ANewActiveDetailLevel: TcxGridLevel;
begin
  AGridView := GridView;
  APrevValue := InternalActiveDetailIndex;
  if APrevValue <> Value then
  begin
    ANewActiveDetailLevel := GridViewLevel.Items[Value];
    DataController.ChangeDetailActiveRelationIndex(RecordIndex, Value);
    //if InternalActiveDetailIndex <> APrevValue then
      TcxCustomGridAccess(AGridView.Control).DoActiveTabChanged(ANewActiveDetailLevel);
  end;
end;

procedure TcxGridMasterDataRow.SetActiveDetailLevel(Value: TcxGridLevel);
begin
  if Value.Parent = GridViewLevel then
    ActiveDetailIndex := Value.Index;
end;

procedure TcxGridMasterDataRow.DoCollapse(ARecurse: Boolean);
var
  I: Integer;
  AGridView: TcxCustomGridView;
begin
  //GridView.BeginUpdate;
  try
    if Expanded and ARecurse then
      for I := 0 to DetailGridViewCount - 1 do
        if DetailGridViewExists[I] then
        begin
          AGridView := DetailGridViews[I];
          if AGridView is TcxCustomGridTableView then
            TcxCustomGridTableView(AGridView).ViewData.Collapse(ARecurse);
        end;
    DataController.ChangeDetailExpanding(RecordIndex, False);
  finally
    //GridView.EndUpdate;
  end;
end;

procedure TcxGridMasterDataRow.DoExpand(ARecurse: Boolean);
var
  AViewData: TcxGridViewData;
  ARecordIndex, I: Integer;
  ARecord: TcxCustomGridRecord;
  AGridView: TcxCustomGridView;
begin
  AViewData := ViewData;
  ARecordIndex := RecordIndex;
  if not DataController.ChangeDetailExpanding(RecordIndex, True) then Exit;
  ARecord := AViewData.GetRecordByRecordIndex(ARecordIndex);
  if Self <> ARecord then
    if ARecord is TcxGridMasterDataRow then
      TcxGridMasterDataRow(ARecord).DoExpand(ARecurse)
    else  
  else
    if Expanded and ARecurse then
      for I := 0 to DetailGridViewCount - 1 do
      begin
        AGridView := DetailGridViews[I];
        if AGridView is TcxCustomGridTableView then
          TcxCustomGridTableView(AGridView).ViewData.Expand(ARecurse);
      end;
end;

function TcxGridMasterDataRow.GetExpandable: Boolean;
begin
  Result := GridView.OptionsView.ExpandButtonsForEmptyDetails or
    HasChildren or Expanded;
end;

function TcxGridMasterDataRow.GetExpanded: Boolean;
begin
  Result := DataController.GetDetailExpanding(RecordInfo.RecordIndex);
end;

function TcxGridMasterDataRow.GetHasChildren: Boolean;
var
  I: Integer;
  ADataRelation: TcxCustomDataRelation;
begin
  for I := 0 to GridViewLevel.VisibleCount - 1 do
  begin
    ADataRelation := GridViewLevel.VisibleItems[I].DataRelation;
    //if ADataRelation <> nil then   //!!!
    begin
      Result := DetailGridViewHasData[ADataRelation.Index];
      if Result then Exit;    
    end;
  end;
  Result := False;
end;

function TcxGridMasterDataRow.GetViewInfoCacheItemClass: TcxCustomGridViewInfoCacheItemClass;
begin
  Result := TcxGridMasterTableViewInfoCacheItem;
end;

function TcxGridMasterDataRow.GetViewInfoClass: TcxCustomGridRecordViewInfoClass;
begin
  Result := TcxGridMasterDataRowViewInfo;
end;

procedure TcxGridMasterDataRow.KeyDown(var Key: Word; Shift: TShiftState);
begin
  //if not ((Key = VK_LEFT) or (Key = VK_RIGHT)) then - AS5427
    inherited;
end;

procedure TcxGridMasterDataRow.ToggleExpanded;
var
  AGridView: TcxGridTableView;
  AGridRecordIndex: Integer;
begin
  if DataController.IsGridMode and not Expanded and not Focused then
  begin
    AGridView := GridView;
    AGridRecordIndex := RecordIndex;
    inherited;
    if (AGridView.DataController.FocusedRecordIndex = AGridRecordIndex) then
      AGridView.Controller.SelectFocusedRecord;
  end
  else
    inherited;
end;

function TcxGridMasterDataRow.ExpandOnDblClick: Boolean;
begin
  Result := inherited ExpandOnDblClick and
    GridView.OptionsBehavior.ExpandMasterRowOnDblClick;
end;

function TcxGridMasterDataRow.GetFirstFocusableChild: TcxCustomGridRecord;
var
  AGridView: TcxCustomGridView;
  AGridRecordIndex: Integer;
  ACycleChanged: Boolean;
begin
  Result := inherited GetFirstFocusableChild;
  if Expanded then
  begin
    AGridView := ActiveDetailGridView;
    if (AGridView is TcxGridTableView) and TcxGridTableView(AGridView).ViewData.HasFilterRow then
      Result := TcxGridTableView(AGridView).ViewData.FilterRow
    else
      if AGridView is TcxCustomGridTableView then
        with TcxCustomGridTableView(AGridView) do
          if ViewData.HasNewItemRecord then
            Result := ViewData.NewItemRecord
          else
          begin
            AGridRecordIndex := Controller.FindNextRecord(-1, True, False, ACycleChanged);
            if AGridRecordIndex <> -1 then
              Result := ViewData.Records[AGridRecordIndex];
          end;
  end;
end;

function TcxGridMasterDataRow.GetLastFocusableChild(ARecursive: Boolean): TcxCustomGridRecord;
var
  AGridView: TcxCustomGridView;
  AGridRecordIndex: Integer;
  AGridRecord: TcxCustomGridRecord;
  ACycleChanged: Boolean;
begin
  Result := inherited GetLastFocusableChild(ARecursive);
  if Expanded then
  begin
    AGridView := ActiveDetailGridView;
    if AGridView is TcxCustomGridTableView then
      with TcxCustomGridTableView(AGridView) do
      begin
        AGridRecordIndex := Controller.FindNextRecord(-1, False, True, ACycleChanged);
        if AGridRecordIndex <> -1 then
        begin
          Result := ViewData.Records[AGridRecordIndex];
          if ARecursive then
          begin
            AGridRecord := Result.GetLastFocusableChild(ARecursive);
            if AGridRecord <> nil then Result := AGridRecord;
          end;
        end
        else
          if ViewData.HasNewItemRecord then
            Result := ViewData.NewItemRecord
          else
            if (AGridView is TcxGridTableView) and
              TcxGridTableView(AGridView).ViewData.HasFilterRow then
              Result := TcxGridTableView(AGridView).ViewData.FilterRow;
      end;
  end;
end;

{ TcxGridGroupRow }

function TcxGridGroupRow.GetGroupedColumn: TcxGridColumn;
begin
  Result := GridView.GroupedColumns[Level];
end;

function TcxGridGroupRow.GetGroupSummaryItems: TcxDataGroupSummaryItems;
begin
  Result := DataController.Summary.GroupSummaryItems[Level];
end;

procedure TcxGridGroupRow.DoCollapse(ARecurse: Boolean);
begin
  if ARecurse or Expanded then  //!!!
    DataController.Groups.ChangeExpanding(Index, False, ARecurse);
end;

procedure TcxGridGroupRow.DoExpand(ARecurse: Boolean);
begin
  if ARecurse or not Expanded then  //!!!
    DataController.Groups.ChangeExpanding(Index, True, ARecurse);
end;

{function TcxGridGroupRow.GetDestroyingOnExpanding: Boolean;
begin
  Result := True;
end;}

function TcxGridGroupRow.GetExpandable: Boolean;
begin
  Result := not (dcoGroupsAlwaysExpanded in DataController.Options);
end;

function TcxGridGroupRow.GetExpanded: Boolean;
begin
  Result := RecordInfo.Expanded;
end;

function TcxGridGroupRow.GetDisplayCaption: string;
begin
  Result := GroupedColumn.GetAlternateCaption;
  if Result <> '' then
    Result := Result + ' : ';
  Result := Result + DisplayTexts[-1];
end;

function TcxGridGroupRow.GetDisplayText(Index: Integer): string;
begin
  if ViewData.HasCustomDataHandling(GroupedColumn, doGrouping) then
    Result := ViewData.GetCustomDataDisplayText(RecordIndex, GroupedColumn.Index, doGrouping)
  else
    Result := inherited GetDisplayText(Index);
end;

function TcxGridGroupRow.GetDisplayTextValue: string;
var
  S: string;
begin
  Result := DisplayCaption;
  S := DataController.Summary.GroupSummaryText[Index];
  if S <> '' then
    Result := Result + ' ' + S;
end;

function TcxGridGroupRow.GetIsData: Boolean;
begin
  Result := False;
end;

function TcxGridGroupRow.GetIsParent: Boolean;
begin
  Result := RecordInfo.Level < DataController.Groups.GroupingItemCount;  //!!!
end;

function TcxGridGroupRow.GetValue: Variant;
begin
  Result := Values[-1];
  if ViewData.HasCustomDataHandling(GroupedColumn, doGrouping) then
    Result := ViewData.GetCustomDataValue(GroupedColumn, Result, doGrouping);
end;

function TcxGridGroupRow.GetViewInfoCacheItemClass: TcxCustomGridViewInfoCacheItemClass;
begin
  Result := TcxGridTableViewInfoCacheItem;
end;

function TcxGridGroupRow.GetViewInfoClass: TcxCustomGridRecordViewInfoClass;
begin
  Result := TcxGridGroupRowViewInfo;
end;

procedure TcxGridGroupRow.SetDisplayText(Index: Integer; const Value: string);
begin
end;

procedure TcxGridGroupRow.SetValue(Index: Integer; const Value: Variant);
begin
end;

function TcxGridGroupRow.GetGroupSummaryInfo(var ASummaryItems: TcxDataSummaryItems;
  var ASummaryValues: PVariant): Boolean;
begin
  Result := DataController.Summary.GetGroupSummaryInfo(Index, ASummaryItems, ASummaryValues);
end;

{ TcxGridViewData }

destructor TcxGridViewData.Destroy;
begin
  DestroyFilterRow;
  inherited;
end;

function TcxGridViewData.GetNewItemRow: TcxGridNewItemRow;
begin
  Result := TcxGridNewItemRow(NewItemRecord);
end;

function TcxGridViewData.GetRow(Index: Integer): TcxCustomGridRow;
begin
  Result := TcxCustomGridRow(Records[Index]);
end;

function TcxGridViewData.GetRowCount: Integer;
begin
  Result := RecordCount;
end;

function TcxGridViewData.GetFirstVisibleExpandedMasterRow: TcxGridMasterDataRow;

  function GetExistingVisibleExpandedMasterRowIndex: Integer;
  begin
    for Result := Controller.TopRecordIndex to Controller.TopRecordIndex + ViewInfo.RecordsViewInfo.VisibleCount - 1 do
      if (Rows[Result] is TcxGridMasterDataRow) and Rows[Result].Expanded then
        Exit;
    Result := -1;
  end;

  function FindMasterRowAndMakeItExpandedAndVisible: Integer;
  begin
    Result := Controller.TopRecordIndex;
    if Rows[Result] is TcxGridGroupRow then
    begin
      Rows[Result].Expand(True);
      while (Result < RowCount) and not (Rows[Result] is TcxGridMasterDataRow) do
        Inc(Result);
    end;
    if Result < RowCount then
      Rows[Result].Expanded := True
    else
      Result := -1;
  end;

var
  ARowIndex: Integer;
begin
  if (RowCount = 0) or not GridView.IsMaster then
    Result := nil
  else
  begin
    ARowIndex := GetExistingVisibleExpandedMasterRowIndex;
    if ARowIndex = -1 then
      ARowIndex := FindMasterRowAndMakeItExpandedAndVisible;
    if ARowIndex = -1 then
      Result := nil
    else
      Result := Rows[ARowIndex].AsMasterDataRow;
  end;
end;

function TcxGridViewData.GetNewItemRecordClass: TcxCustomGridRecordClass;
begin
  Result := TcxGridNewItemRow;
end;

function TcxGridViewData.GetRecordByKind(AKind, AIndex: Integer): TcxCustomGridRecord;
begin
  if AKind = rkFiltering then
    if HasFilterRow then
      Result := FilterRow
    else
      Result := nil
  else
    Result := inherited GetRecordByKind(AKind, AIndex);
end;

function TcxGridViewData.GetRecordClass(ARecordInfo: TcxRowInfo): TcxCustomGridRecordClass;
begin
  if ARecordInfo.Level < DataController.Groups.GroupingItemCount then
    Result := TcxGridGroupRow
  else
    if GridView.IsMaster then
      Result := TcxGridMasterDataRow
    else
      Result := TcxGridDataRow;
end;

function TcxGridViewData.GetRecordKind(ARecord: TcxCustomGridRecord): Integer;
begin
  if HasFilterRow and (ARecord = FilterRow) then
    Result := rkFiltering
  else
    Result := inherited GetRecordKind(ARecord);
end;

procedure TcxGridViewData.CreateFilterRow;
var
  ARowInfo: TcxRowInfo;
begin
  FFilterRow := GetFilterRowClass.Create(Self, -1, ARowInfo);
  FFilterRow.RefreshRecordInfo;
end;

procedure TcxGridViewData.DestroyFilterRow;
begin
  FFilterRow.Free;
  FFilterRow := nil;
end;

procedure TcxGridViewData.CheckFilterRow;
begin
  if HasFilterRow then
    CreateFilterRow
  else
    DestroyFilterRow;
end;

{procedure TcxGridViewData.RecreateFilterRow;
var
  ASelected: Boolean;
begin
  if HasFilterRow then
  begin
    ASelected := FilterRow.InternalSelected;
    DestroyFilterRow;
    CreateFilterRow;
    FilterRow.InternalSelected := ASelected;
  end;
end;}

function TcxGridViewData.GetFilterRowClass: TcxGridFilterRowClass;
begin
  Result := TcxGridFilterRow;
end;

procedure TcxGridViewData.Collapse(ARecurse: Boolean);
begin
  if ARecurse then
  begin
    BeginUpdate;
    try
      DataController.Groups.FullCollapse;
      DataController.CollapseDetails;
    finally
      EndUpdate;
    end;
  end
  else
    inherited;
end;

procedure TcxGridViewData.Expand(ARecurse: Boolean);
begin
  DataController.Groups.FullExpand;
  inherited;
end;

function TcxGridViewData.HasFilterRow: Boolean;
begin
  Result := TcxGridTableView(GridView).FilterRow.Visible;
end;

function TcxGridViewData.HasNewItemRecord: Boolean;
begin
  Result := TcxGridTableView(GridView).NewItemRow.Visible;
end;

function TcxGridViewData.MakeDetailVisible(ADetailLevel: TComponent{TcxGridLevel}): TcxCustomGridView;
var
  ARow: TcxGridMasterDataRow;
begin
  Result := inherited MakeDetailVisible(ADetailLevel);
  ARow := GetFirstVisibleExpandedMasterRow;
  if ARow <> nil then
  begin
    ARow.ActiveDetailLevel := TcxGridLevel(ADetailLevel);
    if ARow.ActiveDetailLevel = ADetailLevel then
      Result := ARow.ActiveDetailGridView;
    ARow.MakeVisible;
  end;
end;

{procedure TcxGridViewData.Refresh(ARecordCount: Integer);
begin
  RecreateFilterRow;
  inherited;
end;}

{ TcxGridColumnHeaderMovingObject }

function TcxGridColumnHeaderMovingObject.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

function TcxGridColumnHeaderMovingObject.GetSourceItem: TcxGridColumn;
begin
  Result := TcxGridColumn(inherited SourceItem);
end;

function TcxGridColumnHeaderMovingObject.GetViewInfo: TcxGridTableViewInfo;
begin
  Result := TcxGridTableViewInfo(inherited ViewInfo);
end;

procedure TcxGridColumnHeaderMovingObject.SetSourceItem(Value: TcxGridColumn);
begin
  inherited SourceItem := Value;
end;

procedure TcxGridColumnHeaderMovingObject.CalculateDestParams(AHitTest: TcxCustomGridHitTest;
  out AContainerKind: TcxGridItemContainerKind; out AZone: TcxGridItemContainerZone);
begin
  inherited;
  if AContainerKind = ckNone then
  begin
    AZone := ViewInfo.GroupByBoxViewInfo.GetZone(AHitTest.Pos);
    if AZone = nil then
    begin
      AZone := ViewInfo.HeaderViewInfo.GetZone(AHitTest.Pos);
      if AZone <> nil then
        AContainerKind := ckHeader;
    end
    else
      AContainerKind := ckGroupByBox;
  end;
end;

function TcxGridColumnHeaderMovingObject.CanRemove: Boolean;
begin
  Result := SourceItem.VisibleForCustomization and
    ((SourceItemContainerKind = ckGroupByBox) and SourceItem.CanGroup or
     (SourceItemContainerKind = ckHeader) and SourceItem.CanHide and
       (FOriginalDestColumnContainerKind <> ckGroupByBox) and
       (GridView.Controller.Customization or GridView.OptionsCustomize.ColumnHiding));
end;

procedure TcxGridColumnHeaderMovingObject.CheckDestItemContainerKind(var AValue: TcxGridItemContainerKind);
begin
  if (AValue = ckGroupByBox) and not SourceItem.CanGroup then
    AValue := ckNone;
  inherited;
end;

procedure TcxGridColumnHeaderMovingObject.DoColumnMoving;
var
  AIndex: Integer;
begin
  with SourceItem do
  begin
    if DestZone.ItemIndex = GridView.VisibleColumnCount then
      AIndex := GridView.ColumnCount - 1
    else
    begin
      AIndex := GridView.VisibleColumns[DestZone.ItemIndex].Index;
      if Index < AIndex then Dec(AIndex);
    end;
    Index := AIndex;
  end;
end;

function TcxGridColumnHeaderMovingObject.GetArrowAreaBounds(APlace: TcxGridArrowPlace): TRect;

  procedure CalculateForGroupByBox;
  begin
    with ViewInfo.GroupByBoxViewInfo do
      if DestZone.ItemIndex = Count then
        if Count = 0 then
        begin
          Result := Bounds;
          Inc(Result.Left, GroupByBoxLeftOffset);
          InflateRect(Result, 0, -GroupByBoxTopOffset);
        end
        else
        begin
          Result := Items[Count - 1].Bounds;
          Result.Left := Result.Right + GroupByBoxHorOffset div 2;
        end
      else
      begin
        Result := Items[DestZone.ItemIndex].Bounds;
        Dec(Result.Left, GroupByBoxHorOffset div 2);
        if DestZone.ItemIndex <> 0 then
          OffsetRect(Result, 0, -GroupByBoxVerOffset div 2);
      end;
  end;

begin
  if DestItemContainerKind = ckGroupByBox then
    CalculateForGroupByBox
  else
    Result := GetArrowAreaBoundsForHeader(APlace);
end;

function TcxGridColumnHeaderMovingObject.GetArrowAreaBoundsForHeader(APlace: TcxGridArrowPlace): TRect;
begin
  with ViewInfo.HeaderViewInfo do
    if DestZone.ItemIndex = Count then
      if Count = 0 then
        Result := Bounds
      else
      begin
        Result := Items[Count - 1].Bounds;
        Result.Left := Result.Right;
      end
    else
      Result := Items[DestZone.ItemIndex].Bounds;
end;

function TcxGridColumnHeaderMovingObject.GetArrowsClientRect: TRect;
begin
  Result := inherited GetArrowsClientRect;
  with ViewInfo.ClientBounds do
  begin
    Result.Left := Left;
    Result.Right := Right;
  end;
end;

function TcxGridColumnHeaderMovingObject.GetSourceItemViewInfo: TcxCustomGridCellViewInfo;
begin
  case SourceItemContainerKind of
    ckGroupByBox:
      Result := ViewInfo.GroupByBoxViewInfo[SourceItem.GroupIndex];
    ckHeader:
      Result := ViewInfo.HeaderViewInfo[SourceItem.VisibleIndex];
  else
    Result := inherited GetSourceItemViewInfo;
  end;
end;

function TcxGridColumnHeaderMovingObject.IsValidDestination: Boolean;
begin
  Result := DestItemContainerKind in [ckGroupByBox, ckHeader];
  if Result then
  begin
    case DestItemContainerKind of
      ckGroupByBox:
        Result := SourceItem.GroupIndex = -1;
      ckHeader:
        Result := not SourceItem.Visible;
    end;
    Result := Result or IsValidDestinationForVisibleSource;
  end;
end;

function TcxGridColumnHeaderMovingObject.IsValidDestinationForVisibleSource: Boolean;
begin
  case DestItemContainerKind of
    ckGroupByBox:
      Result :=
        (DestZone.ItemIndex < SourceItem.GroupIndex) or
        (SourceItem.GroupIndex + 1 < DestZone.ItemIndex);
    ckHeader:
      Result :=
        (SourceItemContainerKind = ckGroupByBox) or
        (DestZone.ItemIndex < SourceItem.VisibleIndex) or
        (SourceItem.VisibleIndex + 1 < DestZone.ItemIndex);
  else
    Result := False;
  end;
end;

procedure TcxGridColumnHeaderMovingObject.EndDragAndDrop(Accepted: Boolean);
var
  APrevGroupIndex: Integer;
  AColumnPosChanged: Boolean;

  procedure DoColumnGrouping;
  begin
    if IsValidDestination then
      AColumnPosChanged := SourceItem.GroupBy(DestZone.ItemIndex -
        Byte((SourceItem.GroupIndex <> -1) and (SourceItem.GroupIndex < DestZone.ItemIndex)));
  end;

  procedure DoColumnRemoving;
  begin
    if not CanRemove then Exit;
    with SourceItem do
      case SourceItemContainerKind of
        ckGroupByBox:
          AColumnPosChanged := SourceItem.GroupBy(-1,
            (DestItemContainerKind <> ckCustomizationForm) and
            (not GridView.OptionsCustomize.ColumnHiding or not CanHide) and
            not Controller.Customization);
        ckHeader:
          if CanHide then
          begin
            Visible := False;
            AColumnPosChanged := True;
          end;
      end;
  end;

begin
  inherited;
  if Accepted then
  begin
    AColumnPosChanged := False;
    APrevGroupIndex := SourceItem.GroupIndex;
    TcxCustomGrid(GridView.Control){GridView}.BeginUpdate;
    try
      case DestItemContainerKind of
        ckGroupByBox:
          DoColumnGrouping;
        ckHeader:
          if IsValidDestination then
          begin
            DoColumnMoving;
            with SourceItem do
            begin
              if (SourceItemContainerKind = ckGroupByBox) and CanGroup then
                GroupIndex := -1;
              Visible := True;
            end;
            AColumnPosChanged := True;
          end;
      else
        DoColumnRemoving;
      end;
    finally
      TcxCustomGrid(GridView.Control){GridView}.EndUpdate;
    end;
    if SourceItem.GroupIndex <> APrevGroupIndex then
      Controller.MakeFocusedRecordVisible;
    if AColumnPosChanged then
      GridView.DoColumnPosChanged(SourceItem);
  end;
end;

procedure TcxGridColumnHeaderMovingObject.Init(const P: TPoint; AParams: TcxCustomGridHitTest);
begin
  inherited;
  with AParams as TcxGridColumnHeaderHitTest do
  begin
    SourceItem := Column;
    SourceItemContainerKind := ColumnContainerKind;
  end;
end;

{ TcxCustomGridSizingObject }

function TcxCustomGridSizingObject.GetController: TcxGridTableController;
begin
  Result := TcxGridTableController(inherited Controller);
end;

function TcxCustomGridSizingObject.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

function TcxCustomGridSizingObject.GetViewInfo: TcxGridTableViewInfo;
begin
  Result := TcxGridTableViewInfo(inherited ViewInfo);
end;

procedure TcxCustomGridSizingObject.SetDestPointX(Value: Integer);
begin
  if FDestPointX <> Value then
  begin
    Dirty := True;
    FDestPointX := Value;
  end;
end;

procedure TcxCustomGridSizingObject.SetDestPointY(Value: Integer);
begin
  if FDestPointY <> Value then
  begin
    Dirty := True;
    FDestPointY := Value;
  end;
end;

procedure TcxCustomGridSizingObject.DirtyChanged;
begin
  Canvas.InvertRect(SizingMarkBounds);
end;

function TcxCustomGridSizingObject.GetCurrentSize: Integer;
begin
  Result := OriginalSize + DeltaSize;
end;

function TcxCustomGridSizingObject.GetDeltaSize: Integer;
begin
  if IsHorizontalSizing then
    Result := DestPointX - SourcePoint.X
  else
    Result := DestPointY - SourcePoint.Y;
end;

function TcxCustomGridSizingObject.GetDragAndDropCursor(Accepted: Boolean): TCursor;
begin
  if IsHorizontalSizing then
    Result := crcxGridHorzSize
  else
    Result := crcxGridVertSize;
end;

function TcxCustomGridSizingObject.GetHorzSizingMarkBounds: TRect;
begin
  with Result do
  begin
    Right := SizingItemBounds.Left + CurrentSize;
    Left := Right - SizingMarkWidth;
    Top := SizingItemBounds.Top;
    Bottom := ViewInfo.Bounds.Bottom - ViewInfo.PartsBottomHeight;
  end;
end;

function TcxCustomGridSizingObject.GetImmediateStart: Boolean;
begin
  Result := True;
end;

function TcxCustomGridSizingObject.GetIsHorizontalSizing: Boolean;
begin
  Result := True;
end;

function TcxCustomGridSizingObject.GetSizingMarkBounds: TRect;
begin
  if IsHorizontalSizing then
    Result := GetHorzSizingMarkBounds
  else
    Result := GetVertSizingMarkBounds;
end;

function TcxCustomGridSizingObject.GetVertSizingMarkBounds: TRect;
begin
  with Result do
  begin
    Left := ViewInfo.Bounds.Left;
    Right := ViewInfo.Bounds.Right;
    Bottom := SizingItemBounds.Top + CurrentSize;
    Top := Bottom - SizingMarkWidth;
  end;
end;

procedure TcxCustomGridSizingObject.DragAndDrop(const P: TPoint; var Accepted: Boolean);
begin
  if IsHorizontalSizing then
    DestPointX := P.X
  else
    DestPointY := P.Y;
  Accepted := True;
  inherited;
end;

procedure TcxCustomGridSizingObject.Init(const P: TPoint; AParams: TcxCustomGridHitTest);
begin
  inherited;
  FDestPointX := SourcePoint.X;
  FDestPointY := SourcePoint.Y;
end;

{ TcxCustomGridColumnSizingObject }

function TcxCustomGridColumnSizingObject.GetColumnHeaderViewInfo: TcxGridColumnHeaderViewInfo;
begin
  Result := ViewInfo.HeaderViewInfo[Column.VisibleIndex];
end;

function TcxCustomGridColumnSizingObject.GetSizingItemBounds: TRect;
begin
  Result := ColumnHeaderViewInfo.Bounds;
end;

function TcxCustomGridColumnSizingObject.GetSizingMarkWidth: Integer;
begin
  Result := ColumnSizingMarkWidth;
end;

procedure TcxCustomGridColumnSizingObject.Init(const P: TPoint; AParams: TcxCustomGridHitTest);
begin
  inherited;
  Column := (AParams as TcxCustomGridColumnHitTest).Column;
end;

{ TcxGridColumnHorzSizingObject }

procedure TcxGridColumnHorzSizingObject.BeginDragAndDrop;
begin
  OriginalSize := ColumnHeaderViewInfo.Width;
  Controller.FHorzSizingColumn := Column;
  inherited;
end;

procedure TcxGridColumnHorzSizingObject.EndDragAndDrop(Accepted: Boolean);
begin
  inherited;
  Controller.FHorzSizingColumn := nil;
  if Accepted and (CurrentSize <> OriginalSize) then
  begin
    Column.ForceWidth(ColumnHeaderViewInfo.CalculateRealWidth(CurrentSize));
    GridView.DoColumnSizeChanged(Column);
  end;
end;

function TcxGridColumnHorzSizingObject.GetCurrentSize: Integer;
begin
  Result := inherited GetCurrentSize;
  ColumnHeaderViewInfo.CheckWidth(Result);
end;

{ TcxGridRowSizingObject }

function TcxGridRowSizingObject.GetRowViewInfo: TcxCustomGridRowViewInfo;
begin
  Result := TcxCustomGridRowViewInfo(FRow.ViewInfo);
end;

procedure TcxGridRowSizingObject.BeginDragAndDrop;
begin
  OriginalSize := RowViewInfo.RowHeight;
  inherited;
end;

procedure TcxGridRowSizingObject.EndDragAndDrop(Accepted: Boolean);
begin
  inherited;
  if Accepted then
    RowViewInfo.RowHeight := CurrentSize;
end;

function TcxGridRowSizingObject.GetCurrentSize: Integer;
begin
  Result := inherited GetCurrentSize;
  RowViewInfo.CheckRowHeight(Result);
end;

function TcxGridRowSizingObject.GetIsHorizontalSizing: Boolean;
begin
  Result := False;
end;

function TcxGridRowSizingObject.GetSizingItemBounds: TRect;
begin                          //!!!
  Result := RowViewInfo.Bounds;
end;

function TcxGridRowSizingObject.GetSizingMarkWidth: Integer;
begin
  Result := RowSizingMarkWidth;
end;

procedure TcxGridRowSizingObject.Init(const P: TPoint; AParams: TcxCustomGridHitTest);
begin
  inherited;
  FRow := TcxCustomGridRow((AParams as TcxGridRowSizingEdgeHitTest).GridRecord);
end;

{ TcxGridTableItemsListBox }

constructor TcxGridTableItemsListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  UpdateBackgroundColor;
end;

function TcxGridTableItemsListBox.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

function TcxGridTableItemsListBox.GetTextColor: TColor;
begin
  Result := LookAndFeelPainter.DefaultHeaderTextColor;
end;

function TcxGridTableItemsListBox.CalculateItemHeight: Integer;
begin
  Result := 2 * (LookAndFeelPainter.HeaderBorderSize + cxGridCellTextOffset) +
    Canvas.TextHeight('Qq');
end;

procedure TcxGridTableItemsListBox.LookAndFeelChanged(
  Sender: TcxLookAndFeel; AChangedValues: TcxLookAndFeelValues);
begin
  inherited LookAndFeelChanged(Sender, AChangedValues);
  UpdateBackgroundColor;
end;

procedure TcxGridTableItemsListBox.PaintItem(
  ACanvas: TcxCanvas; R: TRect; AIndex: Integer; AFocused: Boolean);
const
  States: array[Boolean] of TcxButtonState = (cxbsNormal, cxbsHot);
var
  ATextR, ASelectionR: TRect;
begin
  ASelectionR := R;
  ACanvas.Font.Color := TextColor;
  with LookAndFeelPainter do
  begin
    InflateRect(ASelectionR, -HeaderBorderSize, -HeaderBorderSize);
    ATextR := ASelectionR;
    InflateRect(ATextR, -cxGridCellTextOffset, 0);
    DrawHeader(ACanvas, R, ATextR, [],
      cxBordersAll, States[AFocused], taLeftJustify, vaCenter, False,
      GetItemEndEllipsis, Items[AIndex], ACanvas.Font,
      ACanvas.Font.Color, Style.Color, DrawItemDrawBackgroundHandler);
    if AFocused then
      DrawHeaderPressed(ACanvas, ASelectionR);
  end;
end;

procedure TcxGridTableItemsListBox.UpdateBackgroundColor;
begin
  Style.Color := LookAndFeelPainter.GetCustomizationFormListBackgroundColor;
end;

{ TcxGridTableColumnsListBox }

procedure TcxGridTableColumnsListBox.DoRefreshItems;
begin
  inherited;
  RefreshItemsAsTableItems;
end;

function TcxGridTableColumnsListBox.DrawItemDrawBackgroundHandler(ACanvas: TcxCanvas;
  const ABounds: TRect): Boolean;
begin
  Result := GridView.ViewInfo.HeaderViewInfo.DrawColumnBackgroundHandler(ACanvas, ABounds);
end;

function TcxGridTableColumnsListBox.GetDragAndDropParams: TcxCustomGridHitTest;
begin
  Result := TcxGridColumnHeaderHitTest.Instance(Point(-1, -1));
  with TcxGridColumnHeaderHitTest(Result) do
  begin
    GridView := Self.GridView;
    Column := TcxGridColumn(DragAndDropItem);
    ColumnContainerKind := ckCustomizationForm;
  end;
end;

function TcxGridTableColumnsListBox.GetItemEndEllipsis: Boolean;
begin
  Result := GridView.OptionsView.HeaderEndEllipsis;
end;

{ TcxGridTableCustomizationForm }

function TcxGridTableCustomizationForm.GetColumnsListBox: TcxGridTableColumnsListBox;
begin
  Result := TcxGridTableColumnsListBox(ItemsListBox);
end;

function TcxGridTableCustomizationForm.GetColumnsPage: TcxTabSheet;
begin
  Result := ItemsPage;
end;

function TcxGridTableCustomizationForm.GetController: TcxGridTableController;
begin
  Result := TcxGridTableController(inherited Controller);
end;

function TcxGridTableCustomizationForm.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

function TcxGridTableCustomizationForm.GetViewInfo: TcxGridTableViewInfo;
begin
  Result := TcxGridTableViewInfo(inherited ViewInfo);
end;

function TcxGridTableCustomizationForm.GetItemsListBoxClass: TcxCustomGridTableItemsListBoxClass;
begin
  Result := TcxGridTableColumnsListBox;
end;

function TcxGridTableCustomizationForm.GetItemsPageCaption: string;
begin
  Result := cxGetResourceString(@scxGridCustomizationFormColumnsPageCaption);
end;

{ TcxGridDragOpenInfoMasterDataRowTab }

constructor TcxGridDragOpenInfoMasterDataRowTab.Create(ALevel: TcxGridLevel;
  AGridRow: TcxGridMasterDataRow);
begin
  inherited Create(ALevel);
  GridRow := AGridRow;
end;

function TcxGridDragOpenInfoMasterDataRowTab.Equals(AInfo: TcxCustomGridDragOpenInfo): Boolean;
begin
  Result := inherited Equals(AInfo) and
    (GridRow = TcxGridDragOpenInfoMasterDataRowTab(AInfo).GridRow);
end;

procedure TcxGridDragOpenInfoMasterDataRowTab.Run;
begin
  GridRow.ActiveDetailIndex := Level.Index;
end;

{ TcxGridColumnsCustomizationPopup }

function TcxGridColumnsCustomizationPopup.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

procedure TcxGridColumnsCustomizationPopup.ItemClicked(AItem: TObject; AChecked: Boolean);
begin
  inherited;
  GridView.DoColumnPosChanged(TcxGridColumn(AItem));
end;

procedure TcxGridColumnsCustomizationPopup.SetItemIndex(AItem: TObject; AIndex: Integer);
begin
  inherited;
  GridView.DoColumnPosChanged(TcxGridColumn(AItem));
end;

{ TcxGridTableEditingController }

function TcxGridTableEditingController.GetController: TcxGridTableController;
begin
  Result := TcxGridTableController(inherited Controller);
end;

function TcxGridTableEditingController.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

function TcxGridTableEditingController.CanInitEditing: Boolean;
begin
  if Controller.IsFilterRowFocused then
    Result := True
  else
    Result := inherited CanInitEditing;
end;

function TcxGridTableEditingController.CanUpdateEditValue: Boolean;
begin
  Result := inherited CanUpdateEditValue and not ApplyingImmediateFiltering;
end;

procedure TcxGridTableEditingController.DoEditChanged;
begin
  inherited;
  if Controller.IsFilterRowFocused and (GridView.FilterRow.ApplyChanges = fracImmediately) then
  begin
    ApplyingImmediateFiltering := True;
    try
      EditingItem.EditValue := Edit.EditingValue;
    finally
      ApplyingImmediateFiltering := False;
    end;
  end;
end;

procedure TcxGridTableEditingController.DoEditKeyDown(var Key: Word; Shift: TShiftState);
begin
  if Controller.IsFilterRowFocused and (GridView.FilterRow.ApplyChanges = fracImmediately) and
    (Key = VK_ESCAPE) then
    Edit.Reset;
  inherited;
end;

function TcxGridTableEditingController.GetHideEditOnFocusedRecordChange: Boolean;
begin
  Result := inherited GetHideEditOnFocusedRecordChange or
    GridView.ViewData.HasFilterRow;
end;

procedure TcxGridTableEditingController.InitEdit;

  procedure AddFilterValues(AStrings: TStrings);
  var
    AValueList: TcxGridFilterValueList;
    I: Integer;
  begin
    AValueList := Controller.ViewData.CreateFilterValueList;
    try
      EditingItem.DataBinding.GetFilterValues(AValueList, True, False, True);
      with AStrings do
      begin
        BeginUpdate;
        try
          for I := 0 to AValueList.Count - 1 do
            Add(AValueList[I].Value);
        finally
          EndUpdate;
        end;
      end;
    finally
      AValueList.Free;
    end;
  end;

begin
  inherited;
  if Controller.IsFilterRowFocused then
  begin
    // won't work if both Properties and RepositoryItem are assigned to column
    Edit.InternalProperties.ReadOnly := False;
    if (GridView.FilterRow.ApplyChanges = fracOnCellExit) and
      (Edit is TcxCustomTextEdit) and (Edit.ActiveProperties = TcxCustomTextEdit(Edit).Properties) then
      AddFilterValues(TcxCustomTextEdit(Edit).Properties.LookupItems);
  end;
end;

procedure TcxGridTableEditingController.PostEditingData;
begin
  if Controller.IsFilterRowFocused then
    UpdateValue
  else
    inherited;
end;

{ TcxGridTableController }

constructor TcxGridTableController.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FSelectedColumns := TList.Create;
end;

destructor TcxGridTableController.Destroy;
begin
  FreeAndNil(FSelectedColumns);
  inherited;
end;

function TcxGridTableController.GetColumnsCustomizationPopup: TcxGridColumnsCustomizationPopup;
begin
  Result := TcxGridColumnsCustomizationPopup(ItemsCustomizationPopup);
end;

function TcxGridTableController.GetCustomizationForm: TcxGridTableCustomizationForm;
begin
  Result := TcxGridTableCustomizationForm(inherited CustomizationForm);
end;

function TcxGridTableController.GetEditingController: TcxGridTableEditingController;
begin
  Result := TcxGridTableEditingController(inherited EditingController);
end;

function TcxGridTableController.GetFocusedColumn: TcxGridColumn;
begin
  Result := TcxGridColumn(FocusedItem);
end;

function TcxGridTableController.GetFocusedColumnIndex: Integer;
begin
  Result := FocusedItemIndex;
end;

function TcxGridTableController.GetFocusedRow: TcxCustomGridRow;
begin
  Result := TcxCustomGridRow(FocusedRecord);
end;

function TcxGridTableController.GetFocusedRowIndex: Integer;
begin
  Result := FocusedRecordIndex;
end;

function TcxGridTableController.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

function TcxGridTableController.GetIsColumnHorzSizing: Boolean;
begin
  Result := FHorzSizingColumn <> nil;
end;

function TcxGridTableController.GetSelectedColumn(Index: Integer): TcxGridColumn;
begin
  Result := TcxGridColumn(FSelectedColumns[Index]);
end;

function TcxGridTableController.GetSelectedColumnCount: Integer;
begin
  Result := FSelectedColumns.Count;
end;

function TcxGridTableController.GetSelectedRow(Index: Integer): TcxCustomGridRow;
begin
  Result := TcxCustomGridRow(SelectedRecords[Index]);
end;

function TcxGridTableController.GetSelectedRowCount: Integer;
begin
  Result := SelectedRecordCount;
end;

function TcxGridTableController.GetTopRowIndex: Integer;
begin
  Result := TopRecordIndex;
end;

function TcxGridTableController.GetViewData: TcxGridViewData;
begin
  Result := TcxGridViewData(inherited ViewData);
end;

function TcxGridTableController.GetViewInfo: TcxGridTableViewInfo;
begin
  Result := TcxGridTableViewInfo(inherited ViewInfo);
end;

procedure TcxGridTableController.SetFocusedColumn(Value: TcxGridColumn);
begin
  FocusedItem := Value;
end;

procedure TcxGridTableController.SetFocusedColumnIndex(Value: Integer);
begin
  FocusedItemIndex := Value;
end;

procedure TcxGridTableController.SetFocusedRow(Value: TcxCustomGridRow);
begin
  FocusedRecord := Value;
end;

procedure TcxGridTableController.SetFocusedRowIndex(Value: Integer);
begin
  FocusedRecordIndex := Value;
end;

procedure TcxGridTableController.SetLeftPos(Value: Integer);
var
  APrevLeftPos: Integer;

//var ft,lt:integer;

begin
  CheckLeftPos(Value);
  if FLeftPos <> Value then
  begin

    //ft:=gettickcount;

    APrevLeftPos := FLeftPos;
    FLeftPos := Value;
    if GridView.CanOffsetHorz then
      GridView.Offset(0, APrevLeftPos - FLeftPos, 0)
    else
      LeftPosChanged;
    GridView.DoLeftPosChanged;

    {site.Update;
    lt := gettickcount;
    application.MainForm.Caption := inttostr(lt-ft);}

  end;
end;

procedure TcxGridTableController.SetPressedColumn(Value: TcxGridColumn);
var
  R1, R2: TRect;

  procedure GetUpdateRects;

    function GetUpdateRect(AContainerViewInfo: TcxGridColumnContainerViewInfo;
      AIndex: Integer): TRect;
    begin
      if AIndex <> -1 then
        Result := AContainerViewInfo[AIndex].Bounds
      else
        Result := Rect(0, 0, 0, 0);
    end;

  begin
    R1 := GetUpdateRect(ViewInfo.GroupByBoxViewInfo, FPressedColumn.GroupIndex);
    R2 := GetUpdateRect(ViewInfo.HeaderViewInfo, FPressedColumn.VisibleIndex);
  end;

  procedure InvalidateRects;
  begin
    GridView.ViewChanged(R1);
    GridView.ViewChanged(R2);
  end;

begin
  if FPressedColumn <> Value then
    if ViewInfo.IsCalculating then
      FPressedColumn := Value
    else
    begin
      if Value = nil then GetUpdateRects;
      FPressedColumn := Value;
      if Value <> nil then GetUpdateRects;
      InvalidateRects;
    end;
end;

procedure TcxGridTableController.SetTopRowIndex(Value: Integer);
begin
  TopRecordIndex := Value;
end;

procedure TcxGridTableController.AddSelectedColumn(AColumn: TcxGridColumn);
begin
  AColumn.FSelected := True;
  FSelectedColumns.Add(AColumn);
  //GridView.LayoutChanged;
  InvalidateSelection;
end;

procedure TcxGridTableController.RemoveSelectedColumn(AColumn: TcxGridColumn);
begin
  AColumn.FSelected := False;
  FSelectedColumns.Remove(AColumn);
  //GridView.LayoutChanged;
  InvalidateSelection;
end;

function TcxGridTableController.CanAppend(ACheckOptions: Boolean): Boolean;
begin
  Result := inherited CanAppend(ACheckOptions) and not ViewData.HasNewItemRecord;
end;

function TcxGridTableController.CanDelete(ACheckOptions: Boolean): Boolean;
begin
  Result := inherited CanDelete(ACheckOptions) and
    not IsFilterRowFocused and not IsNewItemRowFocused;
end;

function TcxGridTableController.CanEdit: Boolean;
begin
  Result := inherited CanEdit and not IsFilterRowFocused;
end;

function TcxGridTableController.CanInsert(ACheckOptions: Boolean): Boolean;
begin
  Result := inherited CanInsert(ACheckOptions) and not IsFilterRowFocused;
end;

procedure TcxGridTableController.CheckCoordinates;
begin
  inherited;
  LeftPos := LeftPos;
end;

procedure TcxGridTableController.CheckLeftPos(var Value: Integer);
begin
  if Value > ViewInfo.DataWidth - ViewInfo.ClientWidth then
    Value := ViewInfo.DataWidth - ViewInfo.ClientWidth;
  if Value < 0 then Value := 0;
end;

procedure TcxGridTableController.FocusedItemChanged(APrevFocusedItem: TcxCustomGridTableItem);
begin
  if CellSelectionAnchor = nil then
    CellSelectionAnchor := FocusedColumn;
  inherited;
end;

procedure TcxGridTableController.FocusedRecordChanged(APrevFocusedRecordIndex, AFocusedRecordIndex,
  APrevFocusedDataRecordIndex, AFocusedDataRecordIndex: Integer;
  ANewItemRecordFocusingChanged: Boolean);
begin
  if IsFilterRowFocused and KeepFilterRowFocusing then Exit;
  inherited;
  if ViewData.HasFilterRow and
    ((AFocusedRecordIndex <> APrevFocusedRecordIndex) or ANewItemRecordFocusingChanged) then
    ViewData.FilterRow.Focused := False;
end;

function TcxGridTableController.GetDesignHitTest(AHitTest: TcxCustomGridHitTest): Boolean;
begin
  Result := inherited GetDesignHitTest(AHitTest);
  if not Result then
    if AHitTest is TcxGridFooterCellHitTest then
      Result := TcxGridFooterCellHitTest(AHitTest).SummaryItem <> nil
    else
      Result := AHitTest.HitTestCode in [htColumnHeader, htExpandButton, htTab,
        htIndicatorHeader, htGroupSummary];
end;

function TcxGridTableController.GetFocusedRecord: TcxCustomGridRecord;
begin
  if ViewData.HasFilterRow and ViewData.FilterRow.Selected then
    Result := ViewData.FilterRow
  else
  begin
    Result := inherited GetFocusedRecord;
    if (Result = nil) and ViewData.HasNewItemRecord and ViewData.NewItemRow.Selected then
      Result := ViewData.NewItemRow;
  end;
end;

function TcxGridTableController.GetIsRecordsScrollHorizontal: Boolean;
begin
  Result := False;
end;

function TcxGridTableController.GetItemsCustomizationPopupClass: TcxCustomGridItemsCustomizationPopupClass;
begin
  Result := TcxGridColumnsCustomizationPopup;
end;

function TcxGridTableController.GetMaxTopRecordIndexValue: Integer;
begin
  if NeedsAdditionalRowsScrolling then
    Result := TopRowIndex + 1
  else
    Result := inherited GetMaxTopRecordIndexValue;
end;

function TcxGridTableController.GetMouseWheelScrollingKind: TcxMouseWheelScrollingKind;
begin
  Result := mwskVertical;
end;

function TcxGridTableController.GetScrollBarRecordCount: Integer;
begin
  Result := inherited GetScrollBarRecordCount;
  if NeedsAdditionalRowsScrolling then Inc(Result);
end;

function TcxGridTableController.IsColumnFixedDuringHorzSizing(AColumn: TcxGridColumn): Boolean;
begin
  Result :=
    (AColumn = ForcingWidthItem) or
    not ForcingWidthItem.IsLast and (AColumn.VisibleIndex < ForcingWidthItem.VisibleIndex);
end;

function TcxGridTableController.IsKeyForMultiSelect(AKey: Word; AShift: TShiftState;
  AFocusedRecordChanged: Boolean): Boolean;
begin
  Result := inherited IsKeyForMultiSelect(AKey, AShift, AFocusedRecordChanged) or
    (AKey = VK_UP) or (AKey = VK_DOWN) or
    ((AKey = VK_HOME) or (AKey = VK_END)) and
      (not GridView.OptionsSelection.CellSelect or (FocusedRecord = nil) or not FocusedRecord.HasCells);
end;

function TcxGridTableController.IsPixelScrollBar(AKind: TScrollBarKind): Boolean;
begin
  Result := AKind = sbHorizontal;
end;

procedure TcxGridTableController.LeftPosChanged;
begin
  GridView.LayoutChanged;
end;

function TcxGridTableController.NeedsAdditionalRowsScrolling(AIsCallFromMaster: Boolean = False): Boolean;
var
  ALastRow: TcxGridMasterDataRow;
begin
  Result := False;
  if GridView.IsMaster and (ViewData.RowCount <> 0) and
    ((ViewInfo.VisibleRecordCount > 1) or AIsCallFromMaster) and
    ((ScrollBarPos = inherited GetScrollBarRecordCount - ViewInfo.VisibleRecordCount) or
     AIsCallFromMaster and (ViewData.RowCount = 1)) and
    (ViewData.Rows[ViewData.RowCount - 1] is TcxGridMasterDataRow) then
  begin
    ALastRow := ViewData.Rows[ViewData.RowCount - 1].AsMasterDataRow;
    if ALastRow.Expanded and ALastRow.ActiveDetailGridViewExists then
      Result :=
        not ALastRow.ActiveDetailGridView.Controller.IsDataFullyVisible(True) and
        TcxGridMasterDataRowViewInfo(ALastRow.ViewInfo).DetailsSiteVisible and
        not TcxGridMasterDataRowViewInfo(ALastRow.ViewInfo).DetailsSiteViewInfo.HasMaxHeight;
  end;
end;

procedure TcxGridTableController.RemoveFocus;
begin
  with ViewData do
  begin
    if HasFilterRow then
      FilterRow.Focused := False;
    if HasNewItemRecord then
      NewItemRow.Focused := False;
  end;
  inherited;
end;

procedure TcxGridTableController.ScrollData(ADirection: TcxDirection);
begin
  case ADirection of
    dirLeft:
      LeftPos := LeftPos - HScrollDelta;
    dirRight:
      LeftPos := LeftPos + HScrollDelta;
    dirUp:
      ScrollRecords(False, 1);
    dirDown:
      ScrollRecords(True, 1);
  end;
end;

procedure TcxGridTableController.SetFocusedRecord(Value: TcxCustomGridRecord);
var
  AIndex: Integer;
begin
  if (FocusedRecord <> Value) and ViewData.HasNewItemRecord then
    if Value = ViewData.NewItemRow then
    begin
      Value.Selected := True;
      Value := ViewData.NewItemRow;
    end
    else
      if (FocusedRecord = ViewData.NewItemRow) and (Value = nil) then
        FocusedRecord.Selected := False;

  if ViewData.HasFilterRow then
    if Value = ViewData.FilterRow then
      if FocusedRecord = Value then
        Exit
      else
      begin
        ViewData.FilterRow.Selected := True;
        Value := ViewData.GetRecordByIndex(FocusedRecordIndex);
      end
    else
      if FocusedRow = ViewData.FilterRow then
      begin
        if Value = nil then
          AIndex := -1
        else
          AIndex := Value.Index;
        FocusedRow.Selected := False;
        if AIndex = -1 then
          Exit
        else
          Value := ViewData.GetRecordByIndex(AIndex);
      end;

  inherited;

  if ViewData.HasFilterRow and ViewData.FilterRow.Focused and (FocusedColumn = nil) then
    FocusNextItem(FocusedItemIndex, True, False, False, True);
end;

procedure TcxGridTableController.ShowNextPage;
begin
  if TopRecordIndex <> -1 then
    TopRecordIndex := TopRecordIndex + Max(1, ViewInfo.VisibleRecordCount - 1);
end;

procedure TcxGridTableController.ShowPrevPage;
var
  AVisibleRowCount: Integer;
begin
  if TopRecordIndex = -1 then Exit;
  if TopRecordIndex = 0 then
    if DataController.IsGridMode then
      AVisibleRowCount := ViewInfo.VisibleRecordCount
    else
      Exit
  else
  begin
    AVisibleRowCount := GetVisibleRecordCount(TopRecordIndex, False);
    if DataController.IsGridMode and (TopRecordIndex - (AVisibleRowCount - 1) = 0) and
      (AVisibleRowCount < ViewInfo.VisibleRecordCount) then
      AVisibleRowCount := ViewInfo.VisibleRecordCount;
  end;
  if AVisibleRowCount = 1 then
    TopRecordIndex := TopRecordIndex - 1
  else
    if DataController.IsGridMode then
      TopRecordIndex := TopRecordIndex - (AVisibleRowCount - 1)
    else
      InternalTopRecordIndex := TopRecordIndex - (AVisibleRowCount - 1);
end;

function TcxGridTableController.CanScrollData(ADirection: TcxDirection): Boolean;
var
  Value: Integer;
begin
  case ADirection of
    dirLeft:
      Result := LeftPos <> 0;
    dirRight:
      begin
        Value := LeftPos + HScrollDelta;
        CheckLeftPos(Value);
        Result := LeftPos <> Value;
      end;
    dirUp:
      Result := TopRowIndex <> 0;
    dirDown:
      begin
        Value := TopRowIndex + 1;
        CheckTopRecordIndex(Value);
        Result := TopRowIndex <> Value;
      end;
  else
    Result := False;
  end;
end;

function TcxGridTableController.CanPostponeRecordSelection(AShift: TShiftState): Boolean;
begin
  Result := inherited CanPostponeRecordSelection(AShift) and not CellMultiSelect;
end;

function TcxGridTableController.CanProcessMultiSelect(AHitTest: TcxCustomGridHitTest;
  AShift: TShiftState): Boolean;
begin
  Result := inherited CanProcessMultiSelect(AHitTest, AShift) and
    not (IsClickableRecordHitTest(AHitTest) and
      TcxCustomGridRow(TcxGridRecordHitTest(AHitTest).GridRecord).IsFilterRow) and
    (not CellMultiSelect or (ssLeft in AShift) or
     not (AHitTest.ViewInfo is TcxGridTableDataCellViewInfo) or
     not TcxGridTableDataCellViewInfo(AHitTest.ViewInfo).Selected);
end;

procedure TcxGridTableController.DoMouseNormalSelection(AHitTest: TcxCustomGridHitTest);
begin
  inherited;
  if CellMultiSelect and (AHitTest is TcxGridRowIndicatorHitTest) then
    SelectAllColumns;
end;

procedure TcxGridTableController.DoMouseRangeSelection(AClearSelection: Boolean = True;
  AData: TObject = nil);
begin
  inherited;
  if CellMultiSelect then
    if AData is TcxGridRowIndicatorHitTest then
      SelectAllColumns
    else
      DoRangeCellSelection;
end;

procedure TcxGridTableController.DoNormalSelection;
var
  ASelectionChanged: Boolean;
begin
  ASelectionChanged := False;
  BeginUpdate;
  try
    inherited;
    if CellMultiSelect then
    begin
      if (SelectedColumnCount = 1) and SelectedColumns[0].Focused then Exit;
      ClearCellSelection;
      if FocusedColumn <> nil then
      begin
        FocusedColumn.Selected := True;
        CellSelectionAnchor := FocusedColumn;
      end;
      ASelectionChanged := True;
    end;
  finally
    EndUpdate;
  end;
  if ASelectionChanged then GridView.DoSelectionChanged;
end;

procedure TcxGridTableController.MultiSelectKeyDown(var Key: Word; Shift: TShiftState);
begin
  if CellMultiSelect then
    if ssShift in Shift then
      DoRangeSelection
    else
      DoNormalSelectionWithAnchor
  else
    inherited;
end;

function TcxGridTableController.SupportsAdditiveSelection: Boolean;
begin
  Result := not CellMultiSelect;
end;

function TcxGridTableController.SupportsRecordSelectionToggling: Boolean;
begin
  Result := not CellMultiSelect;
end;

function TcxGridTableController.DefocusSpecialRow: Boolean;

  function FocusTopRow: Boolean;
  begin
    if TopRecordIndex <> -1 then
    begin
      FocusedRecordIndex := TopRecordIndex;
      Result := FocusedRecordIndex = TopRecordIndex;
    end
    else
      Result := False;
  end;

begin
  Result := IsFilterRowFocused;
  if Result then
    if ViewData.HasNewItemRecord then
    begin
      ViewData.NewItemRow.Focused := True;
      Result := ViewData.NewItemRow.Focused;
    end
    else
    begin
      Result := FocusTopRow;
      if Result then
        ViewData.FilterRow.Focused := False;
    end
  else
    Result := IsNewItemRowFocused and FocusTopRow;
end;

function TcxGridTableController.FocusSpecialRow: Boolean;
begin
  Result := ViewData.HasNewItemRecord and not ViewData.NewItemRow.Focused;
  if Result then
  begin
    Result := not IsFilterRowFocused and IsStart;
    if Result then
      ViewData.NewItemRow.Focused := True;
  end
  else
  begin
    Result := ViewData.HasFilterRow and not ViewData.FilterRow.Focused;
    if Result then
    begin
      Result := ViewData.HasNewItemRecord or IsStart;
      if Result then
        ViewData.FilterRow.Focused := True;
    end;
  end;
end;

procedure TcxGridTableController.FilterRowFocusChanged;
begin
  inherited FocusedRecordChanged(FocusedRecordIndex, FocusedRecordIndex,
    DataController.FocusedRecordIndex, DataController.FocusedRecordIndex,
    NewItemRecordFocused);
  GridView.RefreshNavigators;
end;

procedure TcxGridTableController.FilterRowFocusChanging(AValue: Boolean);
var
  AFocusedRecordIndex: Integer;
begin
  if AValue then
  begin
    AFocusedRecordIndex := -1;
    CheckEditing(AFocusedRecordIndex, False);
  end
  else
    EditingController.HideEdit(not GridView.IsDestroying);
end;

procedure TcxGridTableController.DoPullFocusingScrolling(ADirection: TcxDirection);
begin
  if ADirection in [dirLeft, dirRight] then
    FocusNextCell(ADirection = dirRight, True, False);
  inherited;
end;

function TcxGridTableController.GetPullFocusingScrollingDirection(X, Y: Integer;
  out ADirection: TcxDirection): Boolean;
var
  R: TRect;
begin
  Result := inherited GetPullFocusingScrollingDirection(X, Y, ADirection);
  if not Result then
  begin
    R := ViewInfo.ScrollableAreaBoundsVert;
    if X < R.Left then
    begin
      ADirection := dirLeft;
      Result := True;
    end;
    if X >= R.Right then
    begin
      ADirection := dirRight;
      Result := True;
    end;
  end;
end;

function TcxGridTableController.SupportsPullFocusing: Boolean;
begin
  Result := inherited SupportsPullFocusing or CellMultiSelect;
end;

function TcxGridTableController.GetDragOpenInfo(AHitTest: TcxCustomGridHitTest): TcxCustomGridDragOpenInfo;
begin
  Result := inherited GetDragOpenInfo(AHitTest);
  if (Result = nil) and (AHitTest.HitTestCode = htTab) then
    with TcxGridDetailsSiteTabHitTest(AHitTest) do
      Result := TcxGridDragOpenInfoMasterDataRowTab.Create(Level, Owner as TcxGridMasterDataRow);
end;

function TcxGridTableController.GetDragScrollDirection(X, Y: Integer): TcxDirection;
var
  R: TRect;
begin
  Result := dirNone;

  R := ViewInfo.ScrollableAreaBoundsVert;
  if PtInRect(R, Point(X, Y)) then
    if Y < R.Top + ScrollHotZoneWidth then
      Result := dirUp
    else
      if Y >= R.Bottom - ScrollHotZoneWidth then
        Result := dirDown;

  if Result = dirNone then
  begin
    R := ViewInfo.ScrollableAreaBoundsHorz;
    if PtInRect(R, Point(X, Y)) then
      if X < R.Left + ScrollHotZoneWidth then
        Result := dirLeft
      else
        if X >= R.Right - ScrollHotZoneWidth then
          Result := dirRight;
  end;
end;

procedure TcxGridTableController.CheckCustomizationFormBounds(var R: TRect);
var
  AHeaderBottomBound: Integer;
begin
  inherited;
  AHeaderBottomBound := Site.ClientToScreen(ViewInfo.HeaderViewInfo.Bounds.BottomRight).Y;
  if R.Top < AHeaderBottomBound then
    OffsetRect(R, 0, AHeaderBottomBound - R.Top);
end;

function TcxGridTableController.GetColumnHeaderDragAndDropObjectClass: TcxGridColumnHeaderMovingObjectClass;
begin
  Result := TcxGridColumnHeaderMovingObject;
end;

function TcxGridTableController.GetCustomizationFormClass: TcxCustomGridCustomizationFormClass;
begin
  Result := TcxGridTableCustomizationForm;
end;

function TcxGridTableController.CanProcessCellMultiSelect(APrevFocusedColumn: TcxGridColumn): Boolean;
begin
  Result := CellMultiSelect and (FocusedColumn <> APrevFocusedColumn);
end;

procedure TcxGridTableController.CellMultiSelectKeyDown(var Key: Word; Shift: TShiftState);
begin
  if ssShift in Shift then
    DoRangeCellSelection
  else
    DoNormalCellSelection;
end;

procedure TcxGridTableController.DoNormalCellSelection;
begin
  DoNormalSelection;
  SetSelectionAnchor(FocusedRowIndex);
  //GridView.DoSelectionChanged;
end;

procedure TcxGridTableController.DoRangeCellSelection;
begin
  SelectColumns(FCellSelectionAnchor, FocusedColumn);
end;

function TcxGridTableController.GetCellMultiSelect: Boolean;
begin
  Result := GridView.OptionsSelection.CellMultiSelect;
end;

procedure TcxGridTableController.AddBeginsWithMask(var AValue: Variant);
begin
  if VarIsStr(AValue) and (AValue <> '') and (GetBeginsWithMaskPos(AValue) = 0) then
    AValue := AValue + DataController.Filter.PercentWildcard;
end;

procedure TcxGridTableController.RemoveBeginsWithMask(var AValue: Variant);
var
  APos: Integer;
  S: string;
begin
  if VarIsStr(AValue) then
  begin
    APos := GetBeginsWithMaskPos(AValue);
    if APos <> 0 then
    begin
      S := AValue;
      Delete(S, APos, Length(DataController.Filter.PercentWildcard));
      AValue := S;
    end;
  end;
end;

function TcxGridTableController.GetBeginsWithMaskPos(const AValue: string): Integer;
begin
  if (Length(AValue) = 0) or (AValue[Length(AValue)] <> DataController.Filter.PercentWildcard) then
    Result := 0
  else
    Result := Length(AValue);
end;

function TcxGridTableController.GetEditingControllerClass: TcxGridEditingControllerClass;
begin
  Result := TcxGridTableEditingController;
end;

procedure TcxGridTableController.CheckScrolling(const P: TPoint);
var
  R: TRect;
begin
  R := ViewInfo.ScrollableAreaBoundsHorz;
  if PtInRect(R, P) then
    if P.X < R.Left + ScrollHotZoneWidth then
      ScrollDirection := dirLeft
    else
      if R.Right - ScrollHotZoneWidth <= P.X then
        ScrollDirection := dirRight
      else
        ScrollDirection := dirNone
  else
    ScrollDirection := dirNone;
end;

procedure TcxGridTableController.ClearGrouping;
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := 0 to GridView.GroupedColumnCount - 1 do
      GridView.GroupedColumns[I].Visible := True;
    DataController.Groups.ClearGrouping;
  finally
    EndUpdate;
  end;
end;

procedure TcxGridTableController.ClearSelection;
begin
  ClearCellSelection;
  inherited;
end;

procedure TcxGridTableController.DoCancelMode;
begin
  inherited;
  PressedColumn := nil;
end;

function TcxGridTableController.IsFilterRowFocused: Boolean;
begin
  Result := ViewData.HasFilterRow and ViewData.FilterRow.Focused;
end;

function TcxGridTableController.IsNewItemRowFocused: Boolean;
begin
  Result := ViewData.HasNewItemRecord and ViewData.NewItemRow.Focused;
end;

function TcxGridTableController.IsSpecialRowFocused: Boolean;
begin
  Result := IsFilterRowFocused or IsNewItemRowFocused;
end;

procedure TcxGridTableController.MakeItemVisible(AItem: TcxCustomGridTableItem);
var
  R: TRect;

  function GetColumnBounds: TRect;
  begin
    Result := ViewInfo.HeaderViewInfo[AItem.VisibleIndex].Bounds;
  end;

begin
  if (AItem = nil) or (AItem.VisibleIndex = -1) or
    (AItem.VisibleIndex >= ViewInfo.HeaderViewInfo.Count){!!!} then
    Exit;
  MakeFocusedRecordVisible;
  if TcxGridColumn(AItem).CanScroll then
  begin
    R := GetColumnBounds;
    with ViewInfo.ScrollableAreaBoundsHorz do
      if R.Right - R.Left >= Right - Left then
        LeftPos := LeftPos - (Left - R.Left)
      else
      begin
        if R.Right > Right then
        begin
          LeftPos := LeftPos + (R.Right - Right);
          R := GetColumnBounds;
        end;
        if R.Left < Left then
          LeftPos := LeftPos - (Left - R.Left);
      end;
  end;
end;

procedure TcxGridTableController.SelectAll;
begin
  BeginUpdate;
  try
    inherited;
    if CellMultiSelect then
      SelectAllColumns;
  finally
    EndUpdate;
  end;
end;

procedure TcxGridTableController.InitScrollBarsParameters;
var
  APos: Integer;
begin
  if ViewInfo.ScrollableAreaWidth > 0 then
    APos := LeftPos
  else
    APos := -1;
  Controller.SetScrollBarInfo(sbHorizontal, 0, ViewInfo.DataWidth - 1,
    HScrollDelta, ViewInfo.ClientWidth, APos, True, CanHScrollBarHide);
  Controller.SetScrollBarInfo(sbVertical, 0, ScrollBarRecordCount - 1,
    1, ViewInfo.VisibleRecordCount, ScrollBarPos, True, True);
end;

function TcxGridTableController.IsDataFullyVisible(AIsCallFromMaster: Boolean = False): Boolean;
begin
  Result := inherited IsDataFullyVisible(AIsCallFromMaster) and
    ViewInfo.RecordsViewInfo.IsFirstRowFullyVisible;
  if Result and GridView.IsMaster then
    Result := not NeedsAdditionalRowsScrolling(AIsCallFromMaster);
end;

procedure TcxGridTableController.Scroll(AScrollBarKind: TScrollBarKind; AScrollCode: TScrollCode;
  var AScrollPos: Integer);

  procedure ScrollHorizontal;
  begin
    case AScrollCode of
      scLineUp:
        ScrollData(dirLeft);
      scLineDown:
        ScrollData(dirRight);
      scPageUp:
        LeftPos := LeftPos - ViewInfo.ScrollableAreaWidth;
      scPageDown:
        LeftPos := LeftPos + ViewInfo.ScrollableAreaWidth;
      scTrack:
        LeftPos := AScrollPos;
    end;
    AScrollPos := LeftPos;
  end;

  procedure ScrollVertical;
  begin
    case AScrollCode of
      scLineUp:
        ScrollData(dirUp);
      scLineDown:
        ScrollData(dirDown);
      scPageUp:
        ScrollPage(False);
      scPageDown:
        ScrollPage(True);
      scTrack:
        if not DataController.IsGridMode then
          ScrollBarPos := AScrollPos;
      scPosition:
        if DataController.IsGridMode then
          ScrollBarPos := AScrollPos;
    end;
    AScrollPos := ScrollBarPos;
  end;

begin
  case AScrollBarKind of
    sbHorizontal:
      ScrollHorizontal;
    sbVertical:
      ScrollVertical;
  end;
end;

procedure TcxGridTableController.EndDragAndDrop(Accepted: Boolean);
begin
  PressedColumn := nil;
  inherited;
end;

procedure TcxGridTableController.DoKeyDown(var Key: Word; Shift: TShiftState);
var
  AFocusedColumn: TcxGridColumn;
begin
  AFocusedColumn := FocusedColumn;
  inherited;
  if (Key <> 0) and CanProcessCellMultiSelect(AFocusedColumn) then
    CellMultiSelectKeyDown(Key, Shift);
end;

procedure TcxGridTableController.KeyDown(var Key: Word; Shift: TShiftState);
var
  AGridViewLink: TcxGridListenerLink;
  AFocusedRowIndex: Integer;
begin
  case Key of
    VK_LEFT, VK_RIGHT:
      if FocusNextCell(Key = VK_RIGHT) then Exit;//Key := 0;
    VK_PRIOR:
      if FocusSpecialRow then
        Exit
      else
        if IsSpecialRowFocused then
        begin
          Key := 0;
          Exit;
        end;
    VK_NEXT:
      if DefocusSpecialRow then Exit;
  end;
  inherited;
  AGridViewLink := GridView.AddListenerLink;
  try
    case Key of
      VK_LEFT:
        ScrollData(dirLeft);
      VK_RIGHT:
        ScrollData(dirRight);
      VK_UP:
        if not FocusSpecialRow then
        begin
          if IsSpecialRowFocused then
            AFocusedRowIndex := -1
          else
            AFocusedRowIndex := FocusedRowIndex;
          if not FocusNextRecord(AFocusedRowIndex, False, False, not (ssShift in Shift),
            not (ssShift in Shift)) and IsSpecialRowFocused then
            Key := 0;
          if (AGridViewLink.GridView <> nil) and not MultiSelect then
            Site.Update;
        end;
      VK_DOWN:
        if not DefocusSpecialRow then
        begin
          FocusNextRecord(FocusedRowIndex, True, False, not (ssShift in Shift), not (ssShift in Shift));
          if (AGridViewLink.GridView <> nil) and not MultiSelect then
            Site.Update;
        end;
      VK_HOME:
        if (ssCtrl in Shift) or not FocusedRecordHasCells(True) then
          GoToFirst(False)
        else
          FocusNextItem(-1, True, False, False, True);
      VK_END:
        if (ssCtrl in Shift) or not FocusedRecordHasCells(True) then
          GoToLast(False, False)
        else
          FocusNextItem(-1, False, True, False, True);
    end;
  finally
    AGridViewLink.Free;
  end;
end;

procedure TcxGridTableController.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);

  procedure ProcessSorting;

    procedure RemoveColumnSorting;
    var
      I: Integer;
    begin
      if GridView.OptionsCustomize.GroupBySorting then
        with PressedColumn do
          if (GroupIndex = 0) and CanGroup then
          begin
            GroupIndex := -1;
            Visible := True;
          end;
      PressedColumn.SortOrder := soNone;
      if GridView.OptionsCustomize.GroupBySorting then
        for I := 0 to GridView.SortedItemCount - 1 do
          with TcxGridColumn(GridView.SortedItems[I]) do
            if CanGroup then
            begin
              GroupIndex := 0;
              Break;
            end;
    end;

    procedure AddColumnSorting;
    var
      ASortOrder: TcxGridSortOrder;
    begin
      if PressedColumn.SortOrder = soAscending then
        ASortOrder := soDescending
      else
        ASortOrder := soAscending;
      if not (ssShift in Shift) and (PressedColumn.GroupIndex = -1) then
      begin
        if GridView.OptionsCustomize.GroupBySorting and PressedColumn.CanGroup then
          ClearGrouping;
        DataController.ClearSorting(True);
      end;
      PressedColumn.SortOrder := ASortOrder;
      if GridView.OptionsCustomize.GroupBySorting and (PressedColumn.SortIndex = 0) and
        (GridView.GroupedColumnCount = 0) and PressedColumn.CanGroup then
        PressedColumn.GroupIndex := 0;
    end;

  begin
    if not PressedColumn.CanSort then Exit;
    try
      ShowHourglassCursor;
      BeginUpdate;
      try
        if ssCtrl in Shift then
          RemoveColumnSorting
        else
          AddColumnSorting;
      finally
        EndUpdate;
        HideHourglassCursor;
      end;
    finally
      MakeFocusedRecordVisible;
      DesignerModified;
    end;
  end;

begin
  try
    inherited;
    if Site.IsMouseInPressedArea(X, Y) and (PressedColumn <> nil) then
      ProcessSorting;
  finally
    PressedColumn := nil;
  end;
end;

procedure TcxGridTableController.ClearCellSelection;
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := SelectedColumnCount - 1 downto 0 do
      SelectedColumns[I].Selected := False;
  finally
    EndUpdate;
  end;
end;

procedure TcxGridTableController.SelectAllColumns;
begin
  SelectColumns(nil, nil);
end;

procedure TcxGridTableController.SelectCells(AFromColumn, AToColumn: TcxGridColumn;
  AFromRowIndex, AToRowIndex: Integer);
begin
  BeginUpdate;
  try
    if AFromRowIndex = -1 then AFromRowIndex := 0;
    if AToRowIndex = -1 then AToRowIndex := DataController.RowCount - 1;
    DataController.ClearSelection;
    DataController.SelectRows(AFromRowIndex, AToRowIndex);

    SelectColumns(AFromColumn, AToColumn);
  finally
    EndUpdate;
  end;
end;

procedure TcxGridTableController.SelectColumns(AFromColumn, AToColumn: TcxGridColumn);

  procedure GetNewSelectedColumns(AColumns: TList);
  var
    AStartIndex, AFinishIndex, I: Integer;
  begin
    AStartIndex := AColumns.IndexOf(AFromColumn);
    if AStartIndex = -1 then AStartIndex := 0;
    AFinishIndex := AColumns.IndexOf(AToColumn);
    if AFinishIndex = -1 then
      AFinishIndex := AColumns.Count - 1;
    if (AStartIndex > AFinishIndex) and (AFinishIndex <> -1) then
    begin
      I := AStartIndex;
      AStartIndex := AFinishIndex;
      AFinishIndex := I;
    end;
    
    AColumns.Count := AFinishIndex + 1;
    for I := 0 to AStartIndex - 1 do
      AColumns.Delete(0);
  end;

  function IsSelectionChanged(ANewSelectedColumns: TList): Boolean;
  var
    I: Integer;
  begin
    Result := ANewSelectedColumns.Count <> SelectedColumnCount;
    if not Result then
      for I := 0 to ANewSelectedColumns.Count - 1 do
      begin
        Result := not TcxGridColumn(ANewSelectedColumns[I]).Selected;
        if Result then Break;
      end;
  end;

var
  ASelectionChanged: Boolean;
  AColumns: TList;
  I: Integer;
begin
  ASelectionChanged := False;
  BeginUpdate;
  AColumns := TList.Create;
  try
    GridView.GetVisibleItemsList(AColumns);
    GetNewSelectedColumns(AColumns);
    ASelectionChanged := IsSelectionChanged(AColumns);

    if ASelectionChanged then
    begin
      ClearCellSelection;
      for I := 0 to AColumns.Count - 1 do
        TcxGridColumn(AColumns[I]).Selected := True;
    end;
  finally
    AColumns.Free;
    EndUpdate;
    if ASelectionChanged then
      GridView.DoSelectionChanged;
  end;
end;

{ TcxGridColumnContainerPainter }

function TcxGridColumnContainerPainter.GetViewInfo: TcxGridColumnContainerViewInfo;
begin
  Result := TcxGridColumnContainerViewInfo(inherited ViewInfo);
end;

procedure TcxGridColumnContainerPainter.DrawContent;
var
  AClipRegion: TcxRegion;
begin
  AClipRegion := Canvas.GetClipRegion;
  try
    Canvas.IntersectClipRect(ViewInfo.Bounds);
    if DrawItemsFirst then
    begin
      DrawItems;
      inherited;
    end
    else
    begin
      inherited;
      DrawItems;
    end
  finally
    Canvas.SetClipRegion(AClipRegion, roSet);
  end;
end;

procedure TcxGridColumnContainerPainter.DrawItems;
var
  I: Integer;
  AViewInfo: TcxGridColumnHeaderViewInfo;
begin
  for I := 0 to ViewInfo.Count - 1 do
  begin
    AViewInfo := ViewInfo.InternalItems[I];
    if AViewInfo <> nil then AViewInfo.Paint;
  end;
end;

function TcxGridColumnContainerPainter.DrawItemsFirst: Boolean;
begin
  Result := True;
end;

function TcxGridColumnContainerPainter.ExcludeFromClipRect: Boolean;
begin      
  Result := True;
end;

{ TcxGridColumnHeaderAreaPainter }

function TcxGridColumnHeaderAreaPainter.GetViewInfo: TcxGridColumnHeaderAreaViewInfo;
begin
  Result := TcxGridColumnHeaderAreaViewInfo(inherited ViewInfo);
end;

function TcxGridColumnHeaderAreaPainter.ExcludeFromClipRect: Boolean;
begin
  Result := True;
end;

{ TcxGridColumnHeaderSortingMarkPainter }

procedure TcxGridColumnHeaderSortingMarkPainter.Paint;
begin
  ViewInfo.LookAndFeelPainter.DrawSortingMark(Canvas, ViewInfo.Bounds,
    TcxGridColumnHeaderSortingMarkViewInfo(ViewInfo).SortOrder = soAscending);
end;

{ TcxGridColumnHeaderFilterButtonPainter }

function TcxGridColumnHeaderFilterButtonPainter.GetViewInfo: TcxGridColumnHeaderFilterButtonViewInfo;
begin
  Result := TcxGridColumnHeaderFilterButtonViewInfo(inherited ViewInfo);
end;

procedure TcxGridColumnHeaderFilterButtonPainter.Paint;
begin
  ViewInfo.LookAndFeelPainter.DrawFilterDropDownButton(Canvas, ViewInfo.Bounds,
    ViewInfo.ButtonState, ViewInfo.Active);
end;

{ TcxGridColumnHeaderGlyphPainter }

function TcxGridColumnHeaderGlyphPainter.GetViewInfo: TcxGridColumnHeaderGlyphViewInfo;
begin
  Result := TcxGridColumnHeaderGlyphViewInfo(inherited ViewInfo);
end;

procedure TcxGridColumnHeaderGlyphPainter.Paint;
begin
  cxDrawImage(Canvas.Handle, ViewInfo.Bounds, ViewInfo.Bounds,
    ViewInfo.Glyph, nil, -1, idmNormal);
end;

{ TcxGridColumnHeaderPainter }

function TcxGridColumnHeaderPainter.GetViewInfo: TcxGridColumnHeaderViewInfo;
begin
  Result := TcxGridColumnHeaderViewInfo(inherited ViewInfo);
end;

procedure TcxGridColumnHeaderPainter.DrawAreas;
var
  AClipRegion: TcxRegion;
  I: Integer;
begin
  AClipRegion := Canvas.GetClipRegion;
  try
    for I := 0 to ViewInfo.AreaViewInfoCount - 1 do
      ViewInfo.AreaViewInfos[I].Paint(Canvas);
  finally
    Canvas.SetClipRegion(AClipRegion, roSet);
  end;
end;

procedure TcxGridColumnHeaderPainter.DrawBorders;
begin
  // inherited;
end;

procedure TcxGridColumnHeaderPainter.DrawContent;
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
    LookAndFeelPainter.DrawHeader(Self.Canvas, Bounds, TextAreaBounds, Neighbors,
      Borders, AState, AlignmentHorz, AlignmentVert, MultiLinePainting, ShowEndEllipsis,
      Text, Params.Font, Params.TextColor, Params.Color,
      ViewInfo.GridViewInfo.HeaderViewInfo.DrawColumnBackgroundHandler, Column.IsMostRight,
      ViewInfo.Container.Kind = ckGroupByBox);
  end;
  DrawAreas;
end;

procedure TcxGridColumnHeaderPainter.DrawPressed;
begin
  with ViewInfo do
    LookAndFeelPainter.DrawHeaderPressed(Self.Canvas, Bounds);
end;

function TcxGridColumnHeaderPainter.ExcludeFromClipRect: Boolean;
begin
  Result := True;
end;

procedure TcxGridColumnHeaderPainter.Paint;
begin
  inherited;
  if ViewInfo.IsPressed and IsMainCanvasInUse then DrawPressed;
end;

{ TcxGridHeaderPainter }

function TcxGridHeaderPainter.DrawItemsFirst: Boolean;
begin
  Result := ViewInfo.LookAndFeelPainter.GridDrawHeaderCellsFirst;
end;

{ TcxGridGroupByBoxPainter }

procedure TcxGridGroupByBoxPainter.DrawBackground(const R: TRect);
begin
  with ViewInfo do
    LookAndFeelPainter.DrawGroupByBox(Canvas, R, Transparent, Params.Color,
      BackgroundBitmap);
end;

procedure TcxGridGroupByBoxPainter.DrawContent;
var
  I: Integer;
  J: Boolean;
  R: TRect;
begin
  inherited;
  Canvas.Brush.Color := GroupByBoxLineColor;
  for I := 0 to ViewInfo.Count - 2 do
    for J := Low(J) to High(J) do
    begin
      R := TcxGridGroupByBoxViewInfo(ViewInfo).LinkLineBounds[I, J];
      with Canvas do
      begin
        FillRect(R);
        //ExcludeClipRect(R);
      end;
    end;
end;

function TcxGridGroupByBoxPainter.DrawItemsFirst: Boolean;
begin
  Result := ViewInfo.LookAndFeelPainter.HeaderDrawCellsFirst;
end;

{ TcxGridFooterCellPainter }

procedure TcxGridFooterCellPainter.DrawBorders;
begin
  // inherited;
end;

procedure TcxGridFooterCellPainter.DrawContent;
begin
  with ViewInfo do
    LookAndFeelPainter.DrawFooterCell(Self.Canvas, Bounds, AlignmentHorz,
      AlignmentVert, MultiLinePainting, Text, Params.Font, Params.TextColor, Params.Color,
      DrawBackgroundHandler);
end;

{ TcxGridFooterPainter }

function TcxGridFooterPainter.GetViewInfo: TcxGridFooterViewInfo;
begin
  Result := TcxGridFooterViewInfo(inherited ViewInfo);
end;

procedure TcxGridFooterPainter.DrawBackground(const R: TRect);
begin
  ViewInfo.LookAndFeelPainter.DrawFooterContent(Canvas, R, ViewInfo.Params);
end;

procedure TcxGridFooterPainter.DrawBorders;
begin
  if ViewInfo.HasSeparator then DrawSeparator;
  ViewInfo.LookAndFeelPainter.DrawFooterBorder(Canvas, ViewInfo.BordersBounds);
end;

function TcxGridFooterPainter.DrawItemsFirst: Boolean;
begin
  Result := ViewInfo.LookAndFeelPainter.FooterDrawCellsFirst;
end;

procedure TcxGridFooterPainter.DrawSeparator;
begin
  ViewInfo.LookAndFeelPainter.DrawFooterSeparator(Canvas, ViewInfo.SeparatorBounds);
end;

{ TcxCustomGridIndicatorItemPainter }

function TcxCustomGridIndicatorItemPainter.GetViewInfo: TcxCustomGridIndicatorItemViewInfo;
begin
  Result := TcxCustomGridIndicatorItemViewInfo(inherited ViewInfo);
end;

function TcxCustomGridIndicatorItemPainter.ExcludeFromClipRect: Boolean;
begin
  Result := True;
end;

{ TcxGridIndicatorHeaderItemPainter }

function TcxGridIndicatorHeaderItemPainter.GetViewInfo: TcxGridIndicatorHeaderItemViewInfo;
begin
  Result := TcxGridIndicatorHeaderItemViewInfo(inherited ViewInfo);
end;

function TcxGridIndicatorHeaderItemPainter.DrawBackgroundHandler(ACanvas: TcxCanvas;
  const ABounds: TRect): Boolean;
begin
  Result := ViewInfo.GridViewInfo.HeaderViewInfo.DrawColumnBackgroundHandler(ACanvas, ABounds);
end;

procedure TcxGridIndicatorHeaderItemPainter.DrawContent;
begin
  with ViewInfo do
  begin
    LookAndFeelPainter.DrawHeader(Self.Canvas, Bounds, Bounds, [nRight], cxBordersAll,
      GridCellStateToButtonState(State), taLeftJustify, vaTop, False,
      False, '', nil, clNone, Params.Color, DrawBackgroundHandler);
    if SupportsQuickCustomization then
      DrawQuickCustomizationMark;
    if State = gcsPressed then
      LookAndFeelPainter.DrawHeaderPressed(Self.Canvas, Bounds);
  end;
end;

procedure TcxGridIndicatorHeaderItemPainter.DrawQuickCustomizationMark;
begin
  with ViewInfo do
    LookAndFeelPainter.DrawIndicatorCustomizationMark(Canvas, Bounds, Params.TextColor);
end;

{ TcxGridIndicatorRowItemPainter }

function TcxGridIndicatorRowItemPainter.GetViewInfo: TcxGridIndicatorRowItemViewInfo;
begin
  Result := TcxGridIndicatorRowItemViewInfo(inherited ViewInfo);
end;

procedure TcxGridIndicatorRowItemPainter.DrawContent;
begin
  with ViewInfo do
    LookAndFeelPainter.DrawIndicatorItem(Self.Canvas, Bounds, IndicatorKind, Params.Color,
      DrawBackgroundHandler);
end;

{ TcxGridIndicatorFooterItemPainter }

function TcxGridIndicatorFooterItemPainter.GetViewInfo: TcxGridIndicatorFooterItemViewInfo;
begin
  Result := TcxGridIndicatorFooterItemViewInfo(inherited ViewInfo);
end;

procedure TcxGridIndicatorFooterItemPainter.DrawBorders;
begin
  with Canvas, ViewInfo do
  begin
    if HasSeparator then
      LookAndFeelPainter.DrawFooterSeparator(Self.Canvas, SeparatorBounds);
    LookAndFeelPainter.DrawFooterBorder(Self.Canvas, BordersBounds);
  end;
end;

procedure TcxGridIndicatorFooterItemPainter.DrawContent;
begin
  if ViewInfo.GridView.LookAndFeel.SkinPainter = nil then
    inherited DrawContent
  else
    with ViewInfo do
      LookAndFeelPainter.DrawHeader(Canvas, Bounds, Bounds, [], [], cxbsNormal,
        taLeftJustify, vaTop, False, False, '', nil, clNone, Params.Color, DrawBackgroundHandler);
end;

{ TcxGridIndicatorPainter }

function TcxGridIndicatorPainter.GetViewInfo: TcxGridIndicatorViewInfo;
begin
  Result := TcxGridIndicatorViewInfo(inherited ViewInfo);
end;

procedure TcxGridIndicatorPainter.DrawContent;
begin
  if DrawItemsFirst then
  begin
    DrawItems;
    inherited;
  end
  else
  begin
    inherited;
    DrawItems;
  end;
end;

procedure TcxGridIndicatorPainter.DrawItems;
var
  I: Integer;
begin
  with ViewInfo do
    for I := 0 to Count - 1 do
      Items[I].Paint;
end;

function TcxGridIndicatorPainter.DrawItemsFirst: Boolean;
begin
  Result := ViewInfo.LookAndFeelPainter.IndicatorDrawItemsFirst;
end;

function TcxGridIndicatorPainter.ExcludeFromClipRect: Boolean;
begin
  Result := True;
end;

{ TcxCustomGridRowPainter }

function TcxCustomGridRowPainter.GetViewInfo: TcxCustomGridRowViewInfo;
begin
  Result := TcxCustomGridRowViewInfo(inherited ViewInfo);
end;

procedure TcxCustomGridRowPainter.DrawFooters;
begin
  ViewInfo.FootersViewInfo.Paint;
end;

procedure TcxCustomGridRowPainter.DrawIndent;
var
  I: Integer;
begin
  for I := 0 to ViewInfo.VisualLevel - 1 do
    DrawIndentPart(I, ViewInfo.LevelIndentBounds[I]);
end;

procedure TcxCustomGridRowPainter.DrawIndentPart(ALevel: Integer; const ABounds: TRect);
begin
  with Canvas, ViewInfo do
  begin
    if GridViewInfo.LevelIndentBackgroundBitmap = nil then
    begin
      Brush.Color := GridViewInfo.LevelIndentColors[ALevel];
      FillRect(CalculateLevelIndentSpaceBounds(ALevel, ABounds));
    end
    else
      FillRect(CalculateLevelIndentSpaceBounds(ALevel, ABounds),
        GridViewInfo.LevelIndentBackgroundBitmap);

    Brush.Color := GridViewInfo.LevelSeparatorColor;
    FillRect(CalculateLevelIndentVertLineBounds(ALevel, ABounds));

    Brush.Color := GridViewInfo.GridLineColor;
    FillRect(CalculateLevelIndentHorzLineBounds(ALevel, ABounds));
  end;
end;

procedure TcxCustomGridRowPainter.DrawLastHorzGridLine;
begin
  with Canvas do
  begin
    Brush.Color := ViewInfo.GridViewInfo.GridLineColor;
    FillRect(ViewInfo.LastHorzGridLineBounds);
  end;
end;

procedure TcxCustomGridRowPainter.DrawSeparator;
begin
  Canvas.Brush.Color := ViewInfo.SeparatorColor;
  Canvas.FillRect(ViewInfo.SeparatorBounds);
end;

procedure TcxCustomGridRowPainter.Paint;
begin
  if ViewInfo.HasFooters then DrawFooters;
  DrawIndent;
  if ViewInfo.HasLastHorzGridLine then DrawLastHorzGridLine;
  if ViewInfo.HasSeparator then DrawSeparator;
  inherited;
end;

{ TcxGridRowsPainter }

function TcxGridRowsPainter.GetViewInfo: TcxGridRowsViewInfo;
begin
  Result := TcxGridRowsViewInfo(inherited ViewInfo);
end;

procedure TcxGridRowsPainter.Paint;
begin
  with ViewInfo do
  begin
    if HasFilterRow then
      FilterRowViewInfo.Paint;
    if HasNewItemRow then
      NewItemRowViewInfo.Paint;
  end;
  inherited;
end;

class procedure TcxGridRowsPainter.DrawDataRowCells(ARowViewInfo: TcxCustomGridRowViewInfo);
var
  I: Integer;
  ACellViewInfo: TcxGridDataCellViewInfo;
begin
  with ARowViewInfo as TcxGridDataRowViewInfo do
  begin
    for I := 0 to CellViewInfoCount - 1 do
    begin
      ACellViewInfo := InternalCellViewInfos[I];
      if ACellViewInfo <> nil then ACellViewInfo.Paint;
    end;
    CellsAreaViewInfo.Paint;
  end;
end;

{ TcxGridTablePainter }

function TcxGridTablePainter.GetController: TcxGridTableController;
begin
  Result := TcxGridTableController(inherited Controller);
end;

function TcxGridTablePainter.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

function TcxGridTablePainter.GetViewInfo: TcxGridTableViewInfo;
begin
  Result := TcxGridTableViewInfo(inherited ViewInfo);
end;

function TcxGridTablePainter.CanOffset(AItemsOffset, DX, DY: Integer): Boolean;
begin
  Result := inherited CanOffset(AItemsOffset, DX, DY) and
    ((AItemsOffset <> 0) or not GridView.IsMaster) and
    (ViewInfo.RecordsViewInfo.GroupBackgroundBitmap = nil) and
    ((AItemsOffset <> 0) or (ViewInfo.HeaderViewInfo.ColumnBackgroundBitmap = nil)) and
    (ViewInfo.FooterViewInfo.BackgroundBitmap = nil) and
    ((AItemsOffset <> 0) or not GridView.FilterRow.Visible or
     (GridView.FilterRow.InfoText = '')) and
    ((AItemsOffset <> 0) or not GridView.NewItemRow.Visible or
     (GridView.NewItemRow.InfoText = '')) and
    ((AItemsOffset = 0) or not GridView.HasCellMerging);
end;

procedure TcxGridTablePainter.DrawFooter;
begin
  ViewInfo.FooterViewInfo.Paint;
end;

procedure TcxGridTablePainter.DrawGroupByBox;
begin
  ViewInfo.GroupByBoxViewInfo.Paint;
end;

procedure TcxGridTablePainter.DrawHeader;
begin
  ViewInfo.HeaderViewInfo.Paint;
end;

procedure TcxGridTablePainter.DrawIndicator;
begin
  ViewInfo.IndicatorViewInfo.Paint;
end;

procedure TcxGridTablePainter.DrawRecords;

  procedure DrawGridLines;
  var
    I: Integer;
    N: array of DWORD;
    P: array of TPoint;
    R: TRect;
  begin
    SetLength(P, FGridLines.Count * 2);
    SetLength(N, FGridLines.Count);
    for I := 0 to FGridLines.Count - 1 do
    begin
      R := PRect(FGridLines[I])^;
      P[2 * I] := R.TopLeft;
      if R.Bottom = R.Top + 1 then
        P[2 * I + 1] := Point(R.Right, R.Top)
      else
        P[2 * I + 1] := Point(R.Left, R.Bottom);
      N[I] := 2;
    end;
    with Canvas do
    begin
      Pen.Color := ViewInfo.GridLineColor;
      PolyPolyLine(Handle, P[0], N[0], FGridLines.Count);
    end;
    N := nil;
    P := nil;
  end;

  procedure ClearGridLines;
  var
    I: Integer;
  begin
    for I := 0 to FGridLines.Count - 1 do
      Dispose(PRect(FGridLines[I]));
  end;

begin
  FGridLines := TList.Create;
  try
    inherited;
    DrawGridLines;
  finally
    ClearGridLines;
    FreeAndNil(FGridLines);
  end;
end;

procedure TcxGridTablePainter.Offset(AItemsOffset: Integer);
var
  R, AUpdateBounds: TRect;
begin
  R := ViewInfo.GetOffsetBounds(AItemsOffset, AUpdateBounds);
  Site.ScrollWindow(0, AItemsOffset, R);
  Site.InvalidateRect(AUpdateBounds, True);
  Controller.InvalidateFocusedRecord;
  if Controller.IsEditing then
    RedrawWindow(Controller.EditingController.Edit.Handle, nil, 0, RDW_INVALIDATE or RDW_ALLCHILDREN);
end;

procedure TcxGridTablePainter.Offset(DX, DY: Integer);
var
  R, AUpdateBounds: TRect;
begin
  R := ViewInfo.GetOffsetBounds(DX, DY, AUpdateBounds);
  if not IsRectEmpty(R) then
    Site.ScrollWindow(DX, 0, R);
  if not IsRectEmpty(AUpdateBounds) then
    Site.InvalidateRect(AUpdateBounds, True);
  Controller.InvalidateFocusedRecord;
  Site.Update;
end;

procedure TcxGridTablePainter.PaintContent;
//var
//  ft,lt{,i}:integer;
begin
  {ft:=gettickcount;
  for I:=1 to 10 do
  begin}
  DrawGroupByBox;
  DrawFilterBar;
  DrawIndicator;
  DrawHeader;
  DrawFooter;
  inherited;
  {end;
  lt:=gettickcount;
  application.mainform.caption :=
  inttostr(lt-ft);}
end;

procedure TcxGridTablePainter.AddGridLine(const R: TRect);
var
  AR: PRect;
begin
  New(AR);
  AR^ := R;
  FGridLines.Add(AR);
end;

{ TcxGridColumnContainerViewInfo }

constructor TcxGridColumnContainerViewInfo.Create(AGridViewInfo: TcxCustomGridTableViewInfo);
begin
  inherited;
  FItemHeight := -1;
  CreateItems;
end;

destructor TcxGridColumnContainerViewInfo.Destroy;
begin
  DestroyItems;
  inherited;
end;

function TcxGridColumnContainerViewInfo.GetController: TcxGridTableController;
begin
  Result := GridView.Controller;
end;

function TcxGridColumnContainerViewInfo.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxGridColumnContainerViewInfo.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

function TcxGridColumnContainerViewInfo.GetGridViewInfo: TcxGridTableViewInfo;
begin
  Result := TcxGridTableViewInfo(inherited GridViewInfo);
end;

function TcxGridColumnContainerViewInfo.GetInternalItem(Index: Integer): TcxGridColumnHeaderViewInfo;
begin
  Result := TcxGridColumnHeaderViewInfo(FItems[Index]);
end;

function TcxGridColumnContainerViewInfo.GetItem(Index: Integer): TcxGridColumnHeaderViewInfo;
begin
  Result := InternalItems[Index];
  if Result = nil then
  begin
    Result := CreateItem(Index);
    FItems[Index] := Result;
  end;
end;

function TcxGridColumnContainerViewInfo.GetItemHeight: Integer;
begin
  if FItemHeight = -1 then
    FItemHeight := CalculateItemHeight;
  Result := FItemHeight;
end;

function TcxGridColumnContainerViewInfo.CreateItem(AIndex: Integer): TcxGridColumnHeaderViewInfo;
begin
  Result := GetItemClass.Create(Self, Columns[AIndex]);
end;

procedure TcxGridColumnContainerViewInfo.CreateItems;
begin
  FItems := TList.Create;
  FItems.Count := ColumnCount;
end;

procedure TcxGridColumnContainerViewInfo.DestroyItems;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do InternalItems[I].Free;
  FreeAndNil(FItems);
end;

function TcxGridColumnContainerViewInfo.GetItemClass: TcxGridColumnHeaderViewInfoClass;
begin
  Result := TcxGridColumnHeaderViewInfo;
end;

function TcxGridColumnContainerViewInfo.CalculateItemHeight: Integer;
begin
  CalculateParams;
  Result := GetItemClass.GetCellHeight(
    GridViewInfo.GetFontHeight(Params.Font), LookAndFeelPainter);
end;

function TcxGridColumnContainerViewInfo.GetAutoHeight: Boolean;
begin
  Result := False;
end;

function TcxGridColumnContainerViewInfo.GetColumnAdditionalWidth(AColumn: TcxGridColumn): Integer;
begin
  if AColumn.IsMostLeft then
    Result := GridViewInfo.FirstItemAdditionalWidth
  else
    Result := 0;
end;

function TcxGridColumnContainerViewInfo.GetColumnMinWidth(AColumn: TcxGridColumn): Integer;
begin
  Result := AColumn.MinWidth + GetColumnAdditionalWidth(AColumn);
end;

function TcxGridColumnContainerViewInfo.GetColumnNeighbors(AColumn: TcxGridColumn): TcxNeighbors;
begin
  Result := [];
end;

function TcxGridColumnContainerViewInfo.GetColumnWidth(AColumn: TcxGridColumn): Integer;
begin
  Result := AColumn.Width + GetColumnAdditionalWidth(AColumn);
end;

function TcxGridColumnContainerViewInfo.GetItemAreaBounds(AItem: TcxGridColumnHeaderViewInfo): TRect;
begin
  Result := GridViewInfo.ScrollableAreaBoundsHorz;
end;

function TcxGridColumnContainerViewInfo.GetItemMultiLinePainting(AItem: TcxGridColumnHeaderViewInfo): Boolean;
begin
  Result := False;
end;

function TcxGridColumnContainerViewInfo.GetItemsAreaBounds: TRect;
begin
  Result := Bounds;
end;

function TcxGridColumnContainerViewInfo.GetItemsHitTest(const P: TPoint): TcxCustomGridHitTest;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := Items[I].GetHitTest(P);
    if Result <> nil then Exit;
  end;
  Result := nil;
end;

function TcxGridColumnContainerViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridColumnContainerPainter;
end;

function TcxGridColumnContainerViewInfo.GetZonesAreaBounds: TRect;
begin
  Result := Bounds;
  Result.Right := GridViewInfo.ClientBounds.Right;
end;

procedure TcxGridColumnContainerViewInfo.InitHitTest(AHitTest: TcxCustomGridHitTest);
begin
  inherited;
  if AHitTest is TcxCustomGridColumnHitTest then
    TcxCustomGridColumnHitTest(AHitTest).ColumnContainerKind := Kind;
end;

procedure TcxGridColumnContainerViewInfo.Offset(DX, DY: Integer);
var
  I: Integer;
begin       
  inherited;
  for I := 0 to Count - 1 do
    Items[I].DoOffset(DX, DY);
end;

procedure TcxGridColumnContainerViewInfo.BeforeRecalculation;
var
  I: Integer;
begin
  inherited;
  for I := 0 to Count - 1 do
    Items[I].BeforeRecalculation;
end;

function TcxGridColumnContainerViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
begin
  Result := GetItemsHitTest(P);
  if Result = nil then
    Result := inherited GetHitTest(P);
end;

function TcxGridColumnContainerViewInfo.GetZone(const P: TPoint): TcxGridItemContainerZone;
var
  R: TRect;
  ALastBound, I: Integer;
begin
  Result := nil;
  if not Visible then Exit;
  R := ZonesAreaBounds;
  if not PtInRect(R, P) then Exit;
  ALastBound := R.Right;
  for I := 0 to Count do
  begin
    if I = Count then
      R.Right := ALastBound
    else
      with Items[I] do
        R.Right := (Bounds.Left + Bounds.Right) div 2;
    if PtInRect(R, P) then
    begin
      Result := TcxGridItemContainerZone.Create(I);
      Break;
    end;
    R.Left := R.Right;
  end;
end;

{ TcxGridColumnHeaderAreaViewInfo }

constructor TcxGridColumnHeaderAreaViewInfo.Create(AColumnHeaderViewInfo: TcxGridColumnHeaderViewInfo);
begin
  inherited Create(AColumnHeaderViewInfo.GridViewInfo);
  FColumnHeaderViewInfo := AColumnHeaderViewInfo;
end;

function TcxGridColumnHeaderAreaViewInfo.GetColumn: TcxGridColumn;
begin
  Result := FColumnHeaderViewInfo.Column;
end;

function TcxGridColumnHeaderAreaViewInfo.GetGridView: TcxGridTableView;
begin
  Result := FColumnHeaderViewInfo.GridView;
end;

function TcxGridColumnHeaderAreaViewInfo.GetGridViewInfo: TcxGridTableViewInfo;
begin
  Result := FColumnHeaderViewInfo.GridViewInfo;
end;

function TcxGridColumnHeaderAreaViewInfo.GetAlignmentVert: TcxAlignmentVert;
begin
  Result := vaCenter;
end;

function TcxGridColumnHeaderAreaViewInfo.GetCanvas: TcxCanvas;
begin
  Result := GridViewInfo.Canvas;
end;

function TcxGridColumnHeaderAreaViewInfo.GetHeight: Integer;
begin
  Result := CalculateHeight;
end;

function TcxGridColumnHeaderAreaViewInfo.GetWidth: Integer;
begin
  Result := CalculateWidth;
end;

function TcxGridColumnHeaderAreaViewInfo.HasMouse(AHitTest: TcxCustomGridHitTest): Boolean;
begin
  Result := inherited HasMouse(AHitTest);
  if Result then
    with TcxCustomGridColumnHitTest(AHitTest) do
      Result := (Column = Self.Column) and
        (ColumnContainerKind = ColumnHeaderViewInfo.Container.Kind);
end;

procedure TcxGridColumnHeaderAreaViewInfo.InitHitTest(AHitTest: TcxCustomGridHitTest);
begin
  FColumnHeaderViewInfo.InitHitTest(AHitTest);
  inherited;
end;

{procedure TcxGridColumnHeaderAreaViewInfo.Invalidate;
begin
  if GridView <> nil then
    GridView.ViewChanged(Bounds);
end;}

function TcxGridColumnHeaderAreaViewInfo.NeedsContainerHotTrack: Boolean;
begin
  Result := False;
end;

function TcxGridColumnHeaderAreaViewInfo.OccupiesSpace: Boolean;
begin
  Result := True;
end;

function TcxGridColumnHeaderAreaViewInfo.ResidesInContent: Boolean;
begin
  Result := True;
end;

procedure TcxGridColumnHeaderAreaViewInfo.Calculate(const ABounds: TRect;
  var ATextAreaBounds: TRect);

  procedure AlignHorizontally;
  var
    AAreaAndTextWidth: Integer;
  begin
    case AlignmentHorz of
      taLeftJustify:
        begin
          Bounds.Right := Bounds.Left + Width;
          if OccupiesSpace then
            ATextAreaBounds.Left := Bounds.Right;
        end;
      taRightJustify:
        begin
          Bounds.Left := Bounds.Right - Width;
          if OccupiesSpace then
            ATextAreaBounds.Right := Bounds.Left;
        end;
      taCenter:
        if OccupiesSpace and (ColumnHeaderViewInfo.AlignmentHorz = taCenter) and
          not ((AlignmentVert = vaTop) and (ColumnHeaderViewInfo.AlignmentVert = vaBottom) or
               (AlignmentVert = vaBottom) and (ColumnHeaderViewInfo.AlignmentVert = vaTop)) then
        begin
          AAreaAndTextWidth := Width + ColumnHeaderViewInfo.TextWidthWithOffset;
          if AAreaAndTextWidth < Bounds.Right - Bounds.Left then
            Inc(Bounds.Left, (Bounds.Right - Bounds.Left - AAreaAndTextWidth) div 2);
          Bounds.Right := Bounds.Left + Width;

          ATextAreaBounds.Left := Bounds.Right;
          ATextAreaBounds.Right :=
            Min(ATextAreaBounds.Right, ATextAreaBounds.Left + ColumnHeaderViewInfo.TextWidthWithOffset);
        end
        else
        begin
          Inc(Bounds.Left, (Bounds.Right - Bounds.Left - Width) div 2);
          Bounds.Right := Bounds.Left + Width;
        end;
    end;
  end;

  procedure AlignVertically;
  begin
    case AlignmentVert of
      vaTop:
        Bounds.Bottom := Bounds.Top + Height;
      vaBottom:
        Bounds.Top := Bounds.Bottom - Height;
      vaCenter:
        begin
          Inc(Bounds.Top, (Bounds.Bottom - Bounds.Top - Height) div 2);
          Bounds.Bottom := Bounds.Top + Height;
        end;
    end;
  end;

begin
  if ResidesInContent then
    Bounds := ATextAreaBounds
  else
    Bounds := ABounds;
  if Width <> 0 then AlignHorizontally;
  if Height <> 0 then AlignVertically;
  with Bounds do
    inherited Calculate(Left, Top, Right - Left, Bottom - Top);
end;

{ TcxGridColumnHeaderSortingMarkViewInfo }

function TcxGridColumnHeaderSortingMarkViewInfo.GetSortOrder: TcxGridSortOrder;
begin
  Result := Column.SortOrder;
end;

function TcxGridColumnHeaderSortingMarkViewInfo.CalculateHeight: Integer;
begin
  Result := LookAndFeelPainter.SortingMarkAreaSize.Y;
end;

function TcxGridColumnHeaderSortingMarkViewInfo.CalculateWidth: Integer;
begin
  Result := LookAndFeelPainter.SortingMarkAreaSize.X;
end;

function TcxGridColumnHeaderSortingMarkViewInfo.GetAlignmentHorz: TAlignment;
begin
  Result := taRightJustify;
end;

function TcxGridColumnHeaderSortingMarkViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := nil;
end;

function TcxGridColumnHeaderSortingMarkViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridColumnHeaderSortingMarkPainter;
end;

{ TcxGridColumnHeaderHorzSizingEdgeViewInfo }

function TcxGridColumnHeaderHorzSizingEdgeViewInfo.CalculateHeight: Integer;
begin
  Result := 0;
end;

function TcxGridColumnHeaderHorzSizingEdgeViewInfo.CalculateWidth: Integer;
begin
  Result := cxGridHeaderSizingEdgeSize;
end;

function TcxGridColumnHeaderHorzSizingEdgeViewInfo.GetAlignmentHorz: TAlignment;
begin
  Result := taRightJustify;
end;

function TcxGridColumnHeaderHorzSizingEdgeViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridColumnHeaderHorzSizingEdgeHitTest;
end;

function TcxGridColumnHeaderHorzSizingEdgeViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := nil;
end;

function TcxGridColumnHeaderHorzSizingEdgeViewInfo.OccupiesSpace: Boolean;
begin
  Result := False;
end;

function TcxGridColumnHeaderHorzSizingEdgeViewInfo.ResidesInContent: Boolean;
begin
  Result := False;
end;

procedure TcxGridColumnHeaderHorzSizingEdgeViewInfo.Calculate(const ABounds: TRect;
  var ATextAreaBounds: TRect);
begin
  inherited;
  OffsetRect(Bounds, Width div 2, 0);
end;

function TcxGridColumnHeaderHorzSizingEdgeViewInfo.MouseDown(AHitTest: TcxCustomGridHitTest;
  AButton: TMouseButton; AShift: TShiftState): Boolean;
var
  AColumn: TcxGridColumn;
begin
  Result := inherited MouseDown(AHitTest, AButton, AShift);
  if (AButton = mbLeft) and (ssDouble in AShift) then
  begin
    AColumn := Column;
    AColumn.ApplyBestFit(True, True);
    Result := True;
  end;
end;

{ TcxGridColumnHeaderFilterButtonViewInfo }

function TcxGridColumnHeaderFilterButtonViewInfo.GetActive: Boolean;
begin
  Result := Column.Filtered;
end;

function TcxGridColumnHeaderFilterButtonViewInfo.GetDropDownWindowValue: TcxGridFilterPopup;
begin
  Result := TcxGridFilterPopup(inherited DropDownWindow);
end;

function TcxGridColumnHeaderFilterButtonViewInfo.GetItem: TcxCustomGridTableItem;
begin
  Result := Column;
end;

function TcxGridColumnHeaderFilterButtonViewInfo.CalculateHeight: Integer;
begin
  Result := LookAndFeelPainter.FilterDropDownButtonSize.Y;
end;

function TcxGridColumnHeaderFilterButtonViewInfo.CalculateWidth: Integer;
begin
  Result := LookAndFeelPainter.FilterDropDownButtonSize.X;
end;

procedure TcxGridColumnHeaderFilterButtonViewInfo.DropDown;
begin
  GridView.Controller.IsFilterPopupOpenedFromHeader := ColumnHeaderViewInfo.HasHeaderAsContainer;
  inherited;
end;

function TcxGridColumnHeaderFilterButtonViewInfo.EmulateMouseMoveAfterCalculate: Boolean;
begin
  Result := True;
end;

function TcxGridColumnHeaderFilterButtonViewInfo.GetAlignmentHorz: TAlignment;
begin
  Result := taRightJustify;
end;

function TcxGridColumnHeaderFilterButtonViewInfo.GetAlwaysVisible: Boolean;
begin
  Result := GridView.OptionsView.ShowColumnFilterButtons = sfbAlways;
end;

function TcxGridColumnHeaderFilterButtonViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  if GridView.IsDesigning then
    Result := nil
  else
    Result := TcxGridColumnHeaderFilterButtonHitTest;
end;

function TcxGridColumnHeaderFilterButtonViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridColumnHeaderFilterButtonPainter;
end;

function TcxGridColumnHeaderFilterButtonViewInfo.GetVisible: Boolean;
begin
  Result := AlwaysVisible or
    (ColumnHeaderViewInfo.State <> gcsNone) or (State = gcsPressed);
end;

function TcxGridColumnHeaderFilterButtonViewInfo.NeedsContainerHotTrack: Boolean;
begin
  Result := not AlwaysVisible;
end;

function TcxGridColumnHeaderFilterButtonViewInfo.OccupiesSpace: Boolean;
begin
  Result := ColumnHeaderViewInfo.HasFixedContentSpace or Visible;
end;

procedure TcxGridColumnHeaderFilterButtonViewInfo.StateChanged(APrevState: TcxGridCellState);
begin
  if not IsDestroying and not Visible then
    ColumnHeaderViewInfo.Update;
  inherited;
end;

function TcxGridColumnHeaderFilterButtonViewInfo.CloseDropDownWindowOnDestruction: Boolean;
begin
  Result := False;
end;

function TcxGridColumnHeaderFilterButtonViewInfo.DropDownWindowExists: Boolean;
begin
  Result := GridView.Controller.HasFilterPopup;
end;

function TcxGridColumnHeaderFilterButtonViewInfo.GetDropDownWindow: TcxCustomGridPopup;
begin
  Result := GridView.Controller.FilterPopup;
end;

function TcxGridColumnHeaderFilterButtonViewInfo.GetDropDownWindowOwnerBounds: TRect;
begin
  Result := Bounds;
  with ColumnHeaderViewInfo.Bounds do
  begin
    Result.Left := Left;
    Result.Right := Right;
  end;
end;

function TcxGridColumnHeaderFilterButtonViewInfo.IsDropDownWindowOwner: Boolean;
begin
  Result := inherited IsDropDownWindowOwner and (DropDownWindow.Item = Column) and
    (GridView.Controller.IsFilterPopupOpenedFromHeader = ColumnHeaderViewInfo.HasHeaderAsContainer);
end;

function TcxGridColumnHeaderFilterButtonViewInfo.MouseMove(AHitTest: TcxCustomGridHitTest;
  AShift: TShiftState): Boolean;
begin
  Result := inherited MouseMove(AHitTest, AShift);
  if State = gcsPressed then
    ColumnHeaderViewInfo.State := gcsSelected;
end;

{ TcxGridColumnHeaderGlyphViewInfo }

function TcxGridColumnHeaderGlyphViewInfo.GetGlyph: TBitmap;
begin
  Result := Column.HeaderGlyph;
end;

function TcxGridColumnHeaderGlyphViewInfo.CalculateHeight: Integer;
begin
  Result := Glyph.Height;
end;

function TcxGridColumnHeaderGlyphViewInfo.CalculateWidth: Integer;
begin
  Result := Glyph.Width;
end;

function TcxGridColumnHeaderGlyphViewInfo.GetAlignmentHorz: TAlignment;
begin
  Result := Column.HeaderGlyphAlignmentHorz;
end;

function TcxGridColumnHeaderGlyphViewInfo.GetAlignmentVert: TcxAlignmentVert;
begin
  Result := Column.HeaderGlyphAlignmentVert;
end;

function TcxGridColumnHeaderGlyphViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := nil;
end;

function TcxGridColumnHeaderGlyphViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridColumnHeaderGlyphPainter;
end;

{ TcxGridColumnHeaderViewInfo }

constructor TcxGridColumnHeaderViewInfo.Create(AContainer: TcxGridColumnContainerViewInfo;
  AColumn: TcxGridColumn);
begin
  inherited Create(AContainer.GridViewInfo);
  FAreaViewInfos := TList.Create;
  FContainer := AContainer;
  FColumn := AColumn;
  FWidth := -1;
  Width := -1;
  CreateAreaViewInfos;
end;

destructor TcxGridColumnHeaderViewInfo.Destroy;
begin
  DestroyAreaViewInfos;
  FAreaViewInfos.Free;
  inherited;
end;

function TcxGridColumnHeaderViewInfo.GetAreaViewInfoCount: Integer;
begin
  Result := FAreaViewInfos.Count;
end;

function TcxGridColumnHeaderViewInfo.GetAreaViewInfo(Index: Integer): TcxGridColumnHeaderAreaViewInfo;
begin
  Result := TcxGridColumnHeaderAreaViewInfo(FAreaViewInfos[Index]);
end;

function TcxGridColumnHeaderViewInfo.GetGridView: TcxGridTableView;
begin
  Result := FContainer.GridView;
//  if Result.IsDestroying then Result := nil;
end;

function TcxGridColumnHeaderViewInfo.GetGridViewInfo: TcxGridTableViewInfo;
begin
  Result := FContainer.GridViewInfo;
end;

function TcxGridColumnHeaderViewInfo.GetHasTextOffsetLeft: Boolean;
begin
  Result := CalculateHasTextOffset(taLeftJustify);
end;

function TcxGridColumnHeaderViewInfo.GetHasTextOffsetRight: Boolean;
begin
  Result := CalculateHasTextOffset(taRightJustify);
end;

function TcxGridColumnHeaderViewInfo.GetIndex: Integer;
begin
  Result := FColumn.VisibleIndex;
end;

function TcxGridColumnHeaderViewInfo.GetIsFixed: Boolean;
begin
  Result := FColumn.Fixed;
end;

function TcxGridColumnHeaderViewInfo.GetRealWidth: Integer;
begin
  if FRealWidth = 0 then
    FRealWidth := CalculateRealWidth(Width);
  Result := FRealWidth;
end;

procedure TcxGridColumnHeaderViewInfo.EnumAreaViewInfoClasses(AClass: TClass);
begin
  FAreaViewInfos.Add(TcxGridColumnHeaderAreaViewInfoClass(AClass).Create(Self));
end;

procedure TcxGridColumnHeaderViewInfo.CreateAreaViewInfos;
begin
  GetAreaViewInfoClasses(EnumAreaViewInfoClasses);
end;

procedure TcxGridColumnHeaderViewInfo.DestroyAreaViewInfos;
var
  I: Integer;
begin
  for I := 0 to AreaViewInfoCount - 1 do
    AreaViewInfos[I].Free;
end;

function TcxGridColumnHeaderViewInfo.AreasNeedHotTrack: Boolean;
var
  I: Integer;
begin
  for I := 0 to AreaViewInfoCount - 1 do
  begin
    Result := AreaViewInfos[I].NeedsContainerHotTrack;
    if Result then Exit;
  end;
  Result := False;
end;

function TcxGridColumnHeaderViewInfo.CalculateHasTextOffset(ASide: TAlignment): Boolean;
var
  I: Integer;
begin
  if Text <> '' then
  begin
    Result := True;
    for I := 0 to AreaViewInfoCount - 1 do
      with AreaViewInfos[I] do
        if OccupiesSpace and (AlignmentHorz = ASide) then Exit;
  end;
  Result := False;
end;

function TcxGridColumnHeaderViewInfo.CalculateHeight: Integer;
begin
  Result := GetTextCellHeight(GridViewInfo, LookAndFeelPainter);
end;

function TcxGridColumnHeaderViewInfo.CalculateRealWidth(Value: Integer): Integer;
begin
  Result := Value - FContainer.GetColumnAdditionalWidth(Column);
end;

procedure TcxGridColumnHeaderViewInfo.CalculateTextAreaBounds;
var
  I: Integer;
begin
  FTextAreaBounds := inherited GetTextAreaBounds;
  for I := 0 to AreaViewInfoCount - 1 do
    AreaViewInfos[I].Calculate(Bounds, FTextAreaBounds);
  if HasTextOffsetLeft then
    Inc(FTextAreaBounds.Left, cxGridCellTextOffset);
  if HasTextOffsetRight then
    Dec(FTextAreaBounds.Right, cxGridCellTextOffset);
end;

procedure TcxGridColumnHeaderViewInfo.CalculateVisible(ALeftBound, AWidth: Integer);
begin
  with GridViewInfo.ClientBounds do
    Visible := (ALeftBound < Right) and (ALeftBound + AWidth > Left);
end;

function TcxGridColumnHeaderViewInfo.CalculateWidth: Integer;
begin
  if FWidth = -1 then
    FWidth := FContainer.GetColumnWidth(Column);
  Result := FWidth;
end;

function TcxGridColumnHeaderViewInfo.CanFilter: Boolean;
begin
  Result := FColumn.CanFilter(True);
end;

function TcxGridColumnHeaderViewInfo.CanHorzSize: Boolean;
begin
  Result := FColumn.CanHorzSize and (Container.Kind = ckHeader);
end;

function TcxGridColumnHeaderViewInfo.CanPress: Boolean;
begin
  Result := True;
end;

function TcxGridColumnHeaderViewInfo.CanShowHint: Boolean;
begin
  Result := GridView.OptionsBehavior.ColumnHeaderHints;
end;

function TcxGridColumnHeaderViewInfo.CanSort: Boolean;
begin
  Result := FColumn.SortOrder <> soNone;
end;

procedure TcxGridColumnHeaderViewInfo.CheckWidth(var Value: Integer);
begin
  if Value < MinWidth then Value := MinWidth;
  if Value > MaxWidth then Value := MaxWidth;
end;

function TcxGridColumnHeaderViewInfo.CustomDraw(ACanvas: TcxCanvas): Boolean;
begin
  Result := inherited CustomDraw(ACanvas);
  if not Result then
  begin
    FColumn.DoCustomDrawHeader(ACanvas, Self, Result);
    if not Result then
      GridView.DoCustomDrawColumnHeader(ACanvas, Self, Result);
  end;
end;

procedure TcxGridColumnHeaderViewInfo.DoCalculateParams;
begin
  FNeighbors := FContainer.GetColumnNeighbors(Column);
  inherited;
  CalculateTextAreaBounds;
end;

function TcxGridColumnHeaderViewInfo.GetAlignmentHorz: TAlignment;
begin
  Result := FColumn.HeaderAlignmentHorz;
end;

function TcxGridColumnHeaderViewInfo.GetAlignmentVert: TcxAlignmentVert;
begin
  Result := FColumn.HeaderAlignmentVert;
end;

function TcxGridColumnHeaderViewInfo.GetAreaBounds: TRect;
begin
  Result := Container.GetItemAreaBounds(Self);
end;

procedure TcxGridColumnHeaderViewInfo.GetAreaViewInfoClasses(AProc: TcxGridClassEnumeratorProc);
begin
  if CanHorzSize then AProc(TcxGridColumnHeaderHorzSizingEdgeViewInfo);
  if CanFilter then AProc(TcxGridColumnHeaderFilterButtonViewInfo);
  if CanSort then AProc(TcxGridColumnHeaderSortingMarkViewInfo);
  if HasGlyph then AProc(TcxGridColumnHeaderGlyphViewInfo);
end;

function TcxGridColumnHeaderViewInfo.GetBackgroundBitmap: TBitmap;
begin
  Result := GridViewInfo.HeaderViewInfo.ColumnBackgroundBitmap;
end;

function TcxGridColumnHeaderViewInfo.GetBorders: TcxBorders;
begin
  Result := LookAndFeelPainter.HeaderBorders(Neighbors);
end;

function TcxGridColumnHeaderViewInfo.GetBorderWidth(AIndex: TcxBorder): Integer;
begin
  Result := GetCellBorderWidth(LookAndFeelPainter);
end;

function TcxGridColumnHeaderViewInfo.GetCanvas: TcxCanvas;
begin
  Result := GridViewInfo.Canvas;
end;

function TcxGridColumnHeaderViewInfo.GetCaption: string;
begin
  Result := Column.VisibleCaption;
end;

class function TcxGridColumnHeaderViewInfo.GetCellBorderWidth(ALookAndFeelPainter: TcxCustomLookAndFeelPainterClass): Integer;
begin
  Result := ALookAndFeelPainter.HeaderBorderSize;
end;

class function TcxGridColumnHeaderViewInfo.GetCellHeight(ATextHeight: Integer;
  ALookAndFeelPainter: TcxCustomLookAndFeelPainterClass): Integer;
begin
  Result := inherited GetCellHeight(ATextHeight, ALookAndFeelPainter);
  Inc(Result, 2 * GetCellBorderWidth(ALookAndFeelPainter));
end;

function TcxGridColumnHeaderViewInfo.GetDataOffset: Integer;
begin
  Result := Bounds.Right - RealWidth;
end;

function TcxGridColumnHeaderViewInfo.GetHeight: Integer;
begin
  Result := inherited GetHeight - FAdditionalHeightAtTop;
end;

function TcxGridColumnHeaderViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridColumnHeaderHitTest;
end;

function TcxGridColumnHeaderViewInfo.GetHotTrack: Boolean;
begin
  Result := LookAndFeelPainter.IsHeaderHotTrack or AreasNeedHotTrack;
end;

function TcxGridColumnHeaderViewInfo.GetIsDesignSelected: Boolean;
begin
  Result := GridView.IsDesigning and
    GridView.Controller.DesignController.IsObjectSelected(FColumn);
end;

function TcxGridColumnHeaderViewInfo.GetIsPressed: Boolean;
begin
  Result := (State = gcsPressed) or (GridViewInfo.Controller.PressedColumn = Column);
end;

function TcxGridColumnHeaderViewInfo.GetMaxWidth: Integer;
var
  AIndex, I: Integer;
begin
  if GridView.OptionsView.ColumnAutoWidth then
  begin
    Result := GridViewInfo.ClientWidth;
    AIndex := Column.VisibleIndex;
    if AIndex = FContainer.Count - 1 then
      for I := 0 to AIndex - 1 do
        Dec(Result, FContainer[I].MinWidth)
    else
      for I := 0 to FContainer.Count - 1 do
      begin
        if I < AIndex then
          Dec(Result, FContainer[I].Width);
        if I > AIndex then
          Dec(Result, FContainer[I].MinWidth);
      end;
    if Result < MinWidth then Result := MinWidth;
  end
  else
    Result := MaxInt;
end;

function TcxGridColumnHeaderViewInfo.GetMinWidth: Integer;
begin
  if IsFixed then
    Result := CalculateWidth
  else
    Result := FContainer.GetColumnMinWidth(Column);
end;

function TcxGridColumnHeaderViewInfo.GetMultiLine: Boolean;
begin
  Result := FContainer.AutoHeight;
end;

function TcxGridColumnHeaderViewInfo.GetMultiLinePainting: Boolean;
begin
  Result := inherited GetMultiLinePainting or FContainer.GetItemMultiLinePainting(Self);
end;

function TcxGridColumnHeaderViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridColumnHeaderPainter;
end;

function TcxGridColumnHeaderViewInfo.GetRealBounds: TRect;
begin
  Result := inherited GetRealBounds;
  Inc(Result.Left, FAdditionalWidthAtLeft);
  Inc(Result.Top, FAdditionalHeightAtTop);
end;

function TcxGridColumnHeaderViewInfo.GetShowEndEllipsis: Boolean;
begin
  Result := GridView.OptionsView.HeaderEndEllipsis;
end;

function TcxGridColumnHeaderViewInfo.GetText: string;
begin
  if Column.Options.ShowCaption then
    Result := Caption
  else
    Result := '';
end;

function TcxGridColumnHeaderViewInfo.GetTextAreaBounds: TRect;
begin
  Result := FTextAreaBounds;
end;

procedure TcxGridColumnHeaderViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  Column.Styles.GetHeaderParams(AParams);
end;

function TcxGridColumnHeaderViewInfo.GetWidth: Integer;
begin
  Result := inherited GetWidth - FAdditionalWidthAtLeft;
end;

function TcxGridColumnHeaderViewInfo.HasCustomDraw: Boolean;
begin
  Result := Column.HasCustomDrawHeader or GridView.HasCustomDrawColumnHeader;
end;

function TcxGridColumnHeaderViewInfo.HasFixedContentSpace: Boolean;
begin
  Result := False;
end;

function TcxGridColumnHeaderViewInfo.HasGlyph: Boolean;
begin
  Result := not FColumn.HeaderGlyph.Empty;
end;

function TcxGridColumnHeaderViewInfo.HasHeaderAsContainer: Boolean;
begin
  Result := FContainer = GridViewInfo.HeaderViewInfo;
end;

procedure TcxGridColumnHeaderViewInfo.InitHitTest(AHitTest: TcxCustomGridHitTest);
begin
  FContainer.InitHitTest(AHitTest);
  inherited;
  (AHitTest as TcxCustomGridColumnHitTest).Column := Column;
end;

procedure TcxGridColumnHeaderViewInfo.Offset(DX, DY: Integer);
var
  I: Integer;
begin  
  inherited;
  OffsetRect(FTextAreaBounds, DX, DY);
  for I := 0 to AreaViewInfoCount - 1 do
    AreaViewInfos[I].DoOffset(DX, DY);
end;

procedure TcxGridColumnHeaderViewInfo.SetWidth(Value: Integer);
begin
  inherited;
  FWidth := Value;
end;

procedure TcxGridColumnHeaderViewInfo.StateChanged(APrevState: TcxGridCellState);
begin
  if not IsDestroying and AreasNeedHotTrack then
    Recalculate;
  inherited;
end;

procedure TcxGridColumnHeaderViewInfo.Calculate(ALeftBound, ATopBound: Integer;
  AWidth: Integer = -1; AHeight: Integer = -1);

  procedure CheckHiddenBorders(var AAdditionalWidthAtLeft, AAdditionalHeightAtTop: Integer);
  var
    AHiddenBorders: TcxBorders;
  begin
    CalculateParams;
    AHiddenBorders := cxBordersAll - Borders;
    if AHiddenBorders <> [] then
    begin
      if bLeft in AHiddenBorders then
      begin
        Dec(ALeftBound, BorderWidth[bLeft]);
        Inc(AWidth, BorderWidth[bLeft]);
        Inc(AAdditionalWidthAtLeft, BorderWidth[bLeft]);
      end;
      if bTop in AHiddenBorders then
      begin
        Dec(ATopBound, BorderWidth[bTop]);
        Inc(AHeight, BorderWidth[bTop]);
        Inc(AAdditionalHeightAtTop, BorderWidth[bTop]);
      end;
      Borders := cxBordersAll;
    end;
  end;

begin
  FAdditionalWidthAtLeft := 0;
  FAdditionalHeightAtTop := 0;
  if AWidth = -1 then
    AWidth := CalculateWidth;
  CalculateVisible(ALeftBound, AWidth);
  CheckHiddenBorders(FAdditionalWidthAtLeft, FAdditionalHeightAtTop);
  inherited;
  {if Visible then }CalculateTextAreaBounds;
end;

function TcxGridColumnHeaderViewInfo.GetBestFitWidth: Integer;
var
  I: Integer;
begin
  Result := inherited GetBestFitWidth - FAdditionalWidthAtLeft;
  if HasTextOffsetLeft then Inc(Result, cxGridCellTextOffset);
  if HasTextOffsetRight then Inc(Result, cxGridCellTextOffset);
  for I := 0 to AreaViewInfoCount - 1 do
    with AreaViewInfos[I] do
      if OccupiesSpace then Inc(Result, Width);
end;

function TcxGridColumnHeaderViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
var
  I: Integer;
begin
  for I := 0 to AreaViewInfoCount - 1 do
  begin
    Result := AreaViewInfos[I].GetHitTest(P);
    if Result <> nil then Exit;
  end;
  Result := inherited GetHitTest(P);
end;

procedure TcxGridColumnHeaderViewInfo.InitAutoWidthItem(AAutoWidthItem: TcxAutoWidthItem);
begin
  AAutoWidthItem.MinWidth := MinWidth;
  AAutoWidthItem.Width := CalculateWidth;
  AAutoWidthItem.Fixed := IsFixed;
end;

function TcxGridColumnHeaderViewInfo.MouseDown(AHitTest: TcxCustomGridHitTest;
  AButton: TMouseButton; AShift: TShiftState): Boolean;
begin
  Result := inherited MouseDown(AHitTest, AButton, AShift);
  if (AButton = mbLeft) and not (ssDouble in AShift) and CanPress then
  begin
    if GridView.IsDesigning then
      GridView.Controller.DesignController.SelectObject(FColumn, not (ssShift in AShift))
    else
    begin
      GridView.Controller.PressedColumn := FColumn;
      FColumn.DoHeaderClick;
    end;
    Result := True;
  end;
end;

{ TcxGridHeaderViewInfoSpecific }

constructor TcxGridHeaderViewInfoSpecific.Create(AContainerViewInfo: TcxGridHeaderViewInfo);
begin
  inherited Create;
  FContainerViewInfo := AContainerViewInfo;
end;

function TcxGridHeaderViewInfoSpecific.GetGridViewInfo: TcxGridTableViewInfo;
begin
  Result := FContainerViewInfo.GridViewInfo;
end;

function TcxGridHeaderViewInfoSpecific.GetItemHeight: Integer;
begin
  Result := FContainerViewInfo.ItemHeight;
end;

function TcxGridHeaderViewInfoSpecific.CalculateHeight: Integer;
begin
  Result := ItemHeight;
end;

function TcxGridHeaderViewInfoSpecific.GetHeight: Integer;
begin
  Result := CalculateHeight;
end;

{ TcxGridHeaderViewInfo }

constructor TcxGridHeaderViewInfo.Create(AGridViewInfo: TcxCustomGridTableViewInfo);
begin
  inherited;
  FSpecific := GridViewInfo.GetHeaderViewInfoSpecificClass.Create(Self);
end;

destructor TcxGridHeaderViewInfo.Destroy;
begin
  FSpecific.Free;
  inherited;
end;

function TcxGridHeaderViewInfo.GetColumn(Index: Integer): TcxGridColumn;
begin
  Result := GridView.VisibleColumns[Index];
end;

function TcxGridHeaderViewInfo.GetColumnCount: Integer;
begin
  Result := GridView.VisibleColumnCount;
end;

procedure TcxGridHeaderViewInfo.AddIndicatorItems(AIndicatorViewInfo: TcxGridIndicatorViewInfo;
  ATopBound: Integer);
begin
  AIndicatorViewInfo.AddItem(ATopBound, Height, TcxGridIndicatorHeaderItemViewInfo);
end;

procedure TcxGridHeaderViewInfo.CalculateColumnAutoWidths;
var
  AAutoWidthObject: TcxAutoWidthObject;
  I: Integer;
begin
  AAutoWidthObject := TcxAutoWidthObject.Create(Count);
  try
    for I := 0 to Count - 1 do
      Items[I].InitAutoWidthItem(AAutoWidthObject.AddItem);
    AAutoWidthObject.AvailableWidth := GridViewInfo.ClientWidth;
    AAutoWidthObject.Calculate;
    for I := 0 to Count - 1 do
      Items[I].Width := AAutoWidthObject[I].AutoWidth;
  finally
    AAutoWidthObject.Free;
  end;
end;

procedure TcxGridHeaderViewInfo.CalculateColumnWidths;
begin
  if CanCalculateAutoWidths then CalculateColumnAutoWidths;
end;

function TcxGridHeaderViewInfo.CalculateHeight: Integer;
begin
  Result := FSpecific.Height;
end;

procedure TcxGridHeaderViewInfo.CalculateInvisible;
begin
  if IsAlwaysVisibleForCalculation then
  begin
    CalculateVisible;
    Height := 0;
    Bounds := Rect(0, 0, 0, 0);
  end
  else
    inherited;
end;

function TcxGridHeaderViewInfo.CalculateItemHeight: Integer;
var
  I, AColumnHeight: Integer;
begin
  if IsHeightAssigned then
    Result := GridView.OptionsView.HeaderHeight
  else
  begin
    Result := 0;
    CalculateParams;
    for I := 0 to Count - 1 do
      if Items[I].Visible then
      begin
        AColumnHeight := Items[I].CalculateHeight;
        if AColumnHeight > Result then Result := AColumnHeight;
      end;
    if Result = 0 then
      Result := inherited CalculateItemHeight;
  end;    
end;

procedure TcxGridHeaderViewInfo.CalculateItems;
var
  ALeftBound, ATopBound, I, AWidth: Integer;
  AItem: TcxGridColumnHeaderViewInfo;
begin
  with ItemsAreaBounds do
  begin
    ALeftBound := Left;
    ATopBound := Top;
  end;
  for I := 0 to Count - 1 do
  begin
    AItem := Items[I];
    AWidth := AItem.CalculateWidth;
    AItem.Calculate(ALeftBound, ATopBound, AWidth, ItemHeight);
    Inc(ALeftBound, AWidth);
  end;
end;

procedure TcxGridHeaderViewInfo.CalculateVisible;
begin
  CalculateColumnWidths;
  inherited;
end;

function TcxGridHeaderViewInfo.CalculateWidth: Integer;
begin
  Result := GridViewInfo.RecordsViewInfo.RowWidth;
end;

function TcxGridHeaderViewInfo.CanCalculateAutoWidths: Boolean;
begin
  Result := GridView.OptionsView.ColumnAutoWidth;
end;

function TcxGridHeaderViewInfo.DrawColumnBackgroundHandler(ACanvas: TcxCanvas;
  const ABounds: TRect): Boolean;
begin
  Result := ColumnBackgroundBitmap <> nil;
  if Result then
    ACanvas.FillRect(ABounds, ColumnBackgroundBitmap);
end;

function TcxGridHeaderViewInfo.GetAlignment: TcxGridPartAlignment;
begin
  Result := gpaTop;
end;

function TcxGridHeaderViewInfo.GetAutoHeight: Boolean;
begin
  Result := GridViewInfo.SupportsAutoHeight and GridView.OptionsView.HeaderAutoHeight;
end;

function TcxGridHeaderViewInfo.GetColumnBackgroundBitmap: TBitmap;
begin
  Result := GridView.BackgroundBitmaps.GetBitmap(bbHeader);
end;

function TcxGridHeaderViewInfo.GetColumnNeighbors(AColumn: TcxGridColumn): TcxNeighbors;
begin
  Result := [];
  if not AColumn.IsLeft then Include(Result, nLeft);
  if not AColumn.IsRight then Include(Result, nRight);
end;

function TcxGridHeaderViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridHeaderHitTest;
end;

function TcxGridHeaderViewInfo.GetIsAutoWidth: Boolean;
begin
  Result := False;
end;

function TcxGridHeaderViewInfo.GetIsScrollable: Boolean;
begin
  Result := True;
end;

function TcxGridHeaderViewInfo.GetItemMultiLinePainting(AItem: TcxGridColumnHeaderViewInfo): Boolean;
begin
  Result := inherited GetItemMultiLinePainting(AItem) or IsHeightAssigned;
end;

function TcxGridHeaderViewInfo.GetKind: TcxGridColumnContainerKind;
begin
  Result := ckHeader;
end;

function TcxGridHeaderViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridHeaderPainter;
end;

procedure TcxGridHeaderViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  GridView.Styles.GetHeaderParams(nil, AParams);
end;

function TcxGridHeaderViewInfo.GetVisible: Boolean;
begin
  Result := GridView.OptionsView.Header;
end;

function TcxGridHeaderViewInfo.GetWidth: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do
    Inc(Result, Items[I].CalculateWidth);
end;

function TcxGridHeaderViewInfo.GetZonesAreaBounds: TRect;
begin
  Result := inherited GetZonesAreaBounds;
  Result.Left := GridViewInfo.ClientBounds.Left;
  InflateRect(Result, 0, ColumnHeaderMovingZoneSize);
end;

function TcxGridHeaderViewInfo.IsAlwaysVisibleForCalculation: Boolean;
begin
  Result := True;
end;

function TcxGridHeaderViewInfo.IsHeightAssigned: Boolean;
begin
  Result := GridView.OptionsView.HeaderHeight <> 0;
end;

procedure TcxGridHeaderViewInfo.Offset(DX, DY: Integer);
begin                                 
  inherited;
  RecalculateItemVisibles;
end;

procedure TcxGridHeaderViewInfo.RecalculateItemVisibles;
var
  I: Integer;
begin        
  for I := 0 to Count - 1 do
    with Items[I] do
      CalculateVisible(Bounds.Left, Bounds.Right - Bounds.Left);
end;

procedure TcxGridHeaderViewInfo.AssignColumnWidths;
var
  I: Integer;
begin
  GridView.BeginUpdate;
  try
    for I := 0 to Count - 1 do
      with Items[I] do
        Column.Width := RealWidth;
  finally
    GridView.EndUpdate;
  end;
end;

procedure TcxGridHeaderViewInfo.Calculate(ALeftBound, ATopBound: Integer;
  AWidth: Integer = -1; AHeight: Integer = -1);
begin
  inherited;
  CalculateItems;
end;

{ TcxGridGroupByBoxColumnHeaderViewInfo }

function TcxGridGroupByBoxColumnHeaderViewInfo.GetContainer: TcxGridGroupByBoxViewInfo;
begin
  Result := TcxGridGroupByBoxViewInfo(inherited Container);
end;

function TcxGridGroupByBoxColumnHeaderViewInfo.CalculateHeight: Integer;
begin
  Result := TcxGridGroupByBoxViewInfo(Container).ItemHeight;
end;

function TcxGridGroupByBoxColumnHeaderViewInfo.GetCaption: string;
begin
  Result := Column.GetAlternateCaption;
end;

function TcxGridGroupByBoxColumnHeaderViewInfo.HasFixedContentSpace: Boolean;
begin
  Result := Container.CalculatingColumnWidth;
end;

function TcxGridGroupByBoxColumnHeaderViewInfo.InheritedCalculateHeight: Integer;
begin
  Result := inherited CalculateHeight;
end;

{ TcxGridGroupByBoxViewInfo }

function TcxGridGroupByBoxViewInfo.GetGroupByBoxVerOffset: Integer;
begin
  Result := ItemHeight div 2;
end;

function TcxGridGroupByBoxViewInfo.GetLinkLineBounds(Index: Integer;
  Horizontal: Boolean): TRect;
begin
  Result := Items[Index].Bounds;
  Result.Left := Result.Right - 2 * GroupByBoxHorOffset;
  Result.Top := Result.Bottom;
  Inc(Result.Bottom, GroupByBoxLineVerOffset);
  if Horizontal then
  begin
    Result.Top := Result.Bottom - GroupByBoxLineWidth;
    Inc(Result.Right, GroupByBoxHorOffset);
  end
  else
    Result.Right := Result.Left + GroupByBoxLineWidth;
end;

function TcxGridGroupByBoxViewInfo.GetColumn(Index: Integer): TcxGridColumn;
begin
  Result := GridView.GroupedColumns[Index];
end;

function TcxGridGroupByBoxViewInfo.GetColumnCount: Integer;
begin
  Result := GridView.GroupedColumnCount;
end;

function TcxGridGroupByBoxViewInfo.GetItemClass: TcxGridColumnHeaderViewInfoClass;
begin
  Result := TcxGridGroupByBoxColumnHeaderViewInfo;
end;

function TcxGridGroupByBoxViewInfo.CalculateHeight: Integer;

  function TextHeight: Integer;
  begin
    CalculateParams;
    Result := GridViewInfo.GetFontHeight(Params.Font);
    GetCellTextAreaSize(Result);
    Inc(Result, 2);
  end;

begin
  Result := ColumnCount;
  if Result = 0 then
    Result := 2 * GroupByBoxTopOffset + TextHeight
  else
    Result := 2 * GroupByBoxTopOffset +
      ItemHeight div 2 * (Result + 1) + Byte(Odd(ItemHeight));
end;

function TcxGridGroupByBoxViewInfo.CalculateItemHeight: Integer;
var
  I, AColumnHeight: Integer;
begin
  Result := 0;
  CalculateParams;
  for I := 0 to Count - 1 do
  begin
    AColumnHeight := TcxGridGroupByBoxColumnHeaderViewInfo(Items[I]).InheritedCalculateHeight;
    if AColumnHeight > Result then Result := AColumnHeight;
  end;
  if Result = 0 then
    Result := inherited CalculateItemHeight;
end;

function TcxGridGroupByBoxViewInfo.CalculateWidth: Integer;
begin
  Result := GridViewInfo.ClientWidth;
end;

function TcxGridGroupByBoxViewInfo.GetAlignment: TcxGridPartAlignment;
begin
  Result := gpaTop;
end;

function TcxGridGroupByBoxViewInfo.GetAlignmentVert: TcxAlignmentVert;
begin
  Result := vaCenter;
end;

function TcxGridGroupByBoxViewInfo.GetBackgroundBitmap: TBitmap;
begin
  Result := GridView.BackgroundBitmaps.GetBitmap(bbGroupByBox);
end;

function TcxGridGroupByBoxViewInfo.GetColumnWidth(AColumn: TcxGridColumn): Integer;
begin
  FCalculatingColumnWidth := True;
  Result := Items[AColumn.GroupIndex].GetBestFitWidth;
  FCalculatingColumnWidth := False;
end;

function TcxGridGroupByBoxViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridGroupByBoxHitTest;
end;

function TcxGridGroupByBoxViewInfo.GetIsAutoWidth: Boolean;
begin
  Result := True;
end;

function TcxGridGroupByBoxViewInfo.GetIsScrollable: Boolean;
begin
  Result := False;
end;

function TcxGridGroupByBoxViewInfo.GetItemAreaBounds(AItem: TcxGridColumnHeaderViewInfo): TRect;
begin
  SetRectEmpty(Result);
end;

function TcxGridGroupByBoxViewInfo.GetKind: TcxGridColumnContainerKind;
begin
  Result := ckGroupByBox;
end;

function TcxGridGroupByBoxViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridGroupByBoxPainter;
end;

function TcxGridGroupByBoxViewInfo.GetText: string;
begin
  if Count = 0 then
    Result := cxGetResourceString(@scxGridGroupByBoxCaption)
  else
    Result := '';
end;

function TcxGridGroupByBoxViewInfo.GetTextAreaBounds: TRect;
begin
  Result := inherited GetTextAreaBounds;
  Inc(Result.Left, GroupByBoxLeftOffset);
end;

procedure TcxGridGroupByBoxViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  GridView.Styles.GetViewParams(vsGroupByBox, nil, nil, AParams);
end;

function TcxGridGroupByBoxViewInfo.GetVisible: Boolean;
begin
  Result := GridView.OptionsView.GroupByBox;
end;

procedure TcxGridGroupByBoxViewInfo.Calculate(ALeftBound, ATopBound: Integer;
  AWidth: Integer = -1; AHeight: Integer = -1);
var
  I: Integer;
  AColumnHeaderViewInfo: TcxGridColumnHeaderViewInfo;
begin
  inherited;
  with Bounds do
  begin
    ALeftBound := Left + GroupByBoxLeftOffset;
    ATopBound := Top + GroupByBoxTopOffset;
  end;
  for I := 0 to Count - 1 do
  begin
    AColumnHeaderViewInfo := Items[I];
    AColumnHeaderViewInfo.Calculate(ALeftBound, ATopBound);
    Inc(ALeftBound, AColumnHeaderViewInfo.Width + GroupByBoxHorOffset);
    Inc(ATopBound, GroupByBoxVerOffset);
  end;
end;

{ TcxGridFooterCellViewInfo }

constructor TcxGridFooterCellViewInfo.Create(AContainer: TcxGridColumnContainerViewInfo;
  ASummaryItem: TcxDataSummaryItem);
begin
  inherited Create(AContainer, TcxGridColumn(ASummaryItem.ItemLink));
  FSummaryItem := ASummaryItem;
end;

function TcxGridFooterCellViewInfo.GetContainer: TcxGridFooterViewInfo;
begin
  Result := TcxGridFooterViewInfo(inherited Container);
end;

function TcxGridFooterCellViewInfo.GetSummary: TcxDataSummary;
begin
  Result := SummaryItem.SummaryItems.Summary;
end;

procedure TcxGridFooterCellViewInfo.AfterCalculateBounds(var ABounds: TRect);
begin
  inherited;
  with LookAndFeelPainter do
    InflateRect(ABounds, -FooterCellOffset, -FooterCellOffset);
end;

function TcxGridFooterCellViewInfo.CanPress: Boolean;
begin
  Result := False;
end;

function TcxGridFooterCellViewInfo.CustomDraw(ACanvas: TcxCanvas): Boolean;
begin
  Result := False;
  Column.DoCustomDrawFooterCell(ACanvas, Self, Result);
  if not Result then
    GridView.DoCustomDrawFooterCell(ACanvas, Self, Result);
end;

function TcxGridFooterCellViewInfo.GetAlignmentHorz: TAlignment;
begin
  Result := Column.FooterAlignmentHorz;
end;

function TcxGridFooterCellViewInfo.GetBackgroundBitmap: TBitmap;
begin
  Result := Container.BackgroundBitmap;
end;

procedure TcxGridFooterCellViewInfo.GetAreaViewInfoClasses(AProc: TcxGridClassEnumeratorProc);
begin
end;

function TcxGridFooterCellViewInfo.GetBorders: TcxBorders;
begin
  Result := cxBordersAll;
end;

class function TcxGridFooterCellViewInfo.GetCellBorderWidth(ALookAndFeelPainter: TcxCustomLookAndFeelPainterClass): Integer;
begin
  Result := ALookAndFeelPainter.FooterCellBorderSize;
end;

function TcxGridFooterCellViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := Container.GetItemHitTestClass;
end;

function TcxGridFooterCellViewInfo.GetIsDesignSelected: Boolean;
begin
  Result := GridView.IsDesigning and
    GridView.Controller.DesignController.IsObjectSelected(SummaryItem);
end;

function TcxGridFooterCellViewInfo.GetIsPressed: Boolean;
begin
  Result := False;
end;

function TcxGridFooterCellViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridFooterCellPainter;
end;

function TcxGridFooterCellViewInfo.GetText: string;
begin               
  try
    Result := Summary.FooterSummaryTexts[SummaryItem.Index];
  except
    Application.HandleException(Self);
  end;
end;

procedure TcxGridFooterCellViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  GridView.Styles.GetFooterCellParams(nil, Column, -1, SummaryItem, AParams);
end;

function TcxGridFooterCellViewInfo.HasCustomDraw: Boolean;
begin
  Result := Column.HasCustomDrawFooterCell or GridView.HasCustomDrawFooterCell;
end;

procedure TcxGridFooterCellViewInfo.InitHitTest(AHitTest: TcxCustomGridHitTest);
begin
  inherited;
  (AHitTest as TcxGridFooterCellHitTest).SummaryItem := SummaryItem;
end;

function TcxGridFooterCellViewInfo.GetBestFitWidth: Integer;
begin
  Result := inherited GetBestFitWidth + 2 * LookAndFeelPainter.FooterCellOffset;
end;

function TcxGridFooterCellViewInfo.MouseDown(AHitTest: TcxCustomGridHitTest;
  AButton: TMouseButton; AShift: TShiftState): Boolean;
begin
  Result := inherited MouseDown(AHitTest, AButton, AShift);
  if GridView.IsDesigning and (AButton = mbLeft) then
  begin
    GridView.Controller.DesignController.SelectObject(SummaryItem, not (ssShift in AShift));
    Result := True;
  end;
end;
  
{ TcxGridFooterViewInfo }

function TcxGridFooterViewInfo.GetMultipleSummaries: Boolean;
begin
  Result := RowCount > 1;
end;

function TcxGridFooterViewInfo.GetRowCount: Integer;
begin
  if FRowCount = 0 then
    FRowCount := CalculateRowCount;
  Result := FRowCount;
end;

function TcxGridFooterViewInfo.GetRowHeight: Integer;
begin
  if MultipleSummaries then
    Result := ItemHeight
  else
    Result := inherited CalculateHeight;
end;

function TcxGridFooterViewInfo.CreateItem(AIndex: Integer): TcxGridColumnHeaderViewInfo;
begin
  Result := TcxGridFooterCellViewInfoClass(GetItemClass).Create(Self, FSummaryItems[AIndex]);
end;

procedure TcxGridFooterViewInfo.CreateItems;
var
  AColumnHasSummaries: array of Boolean;
  I, AColumnVisibleIndex: Integer;
  ASummaryItem: TcxDataSummaryItem;
begin
  FSummaryItems := TList.Create;
  SetLength(AColumnHasSummaries, GridView.VisibleColumnCount);
  for I := 0 to SummaryItems.Count - 1 do
  begin
    ASummaryItem := SummaryItems[I];
    if (ASummaryItem.Position = spFooter) and (ASummaryItem.ItemLink is TcxGridColumn) then
    begin
      AColumnVisibleIndex := TcxGridColumn(ASummaryItem.ItemLink).VisibleIndex;
      if (AColumnVisibleIndex <> -1) and
        (CanShowMultipleSummaries or not AColumnHasSummaries[AColumnVisibleIndex]) then
      begin
        FSummaryItems.Add(ASummaryItem);
        AColumnHasSummaries[AColumnVisibleIndex] := True;
      end;
    end;
  end;
  PrepareSummaryItems(FSummaryItems);
  inherited;
end;

procedure TcxGridFooterViewInfo.DestroyItems;
begin
  inherited;
  FreeAndNil(FSummaryItems);
end;

function TcxGridFooterViewInfo.GetColumn(Index: Integer): TcxGridColumn;
begin
  Result := TcxGridColumn(TcxDataSummaryItem(FSummaryItems[Index]).ItemLink);
end;

function TcxGridFooterViewInfo.GetColumnCount: Integer;
begin
  Result := FSummaryItems.Count;
end;

function TcxGridFooterViewInfo.GetItemClass: TcxGridColumnHeaderViewInfoClass;
begin
  Result := TcxGridFooterCellViewInfo;
end;

procedure TcxGridFooterViewInfo.PrepareSummaryItems(ASummaryItems: TList);
begin
end;

function TcxGridFooterViewInfo.CalculateBounds: TRect;
begin
  Result := inherited CalculateBounds;
  with GridViewInfo.HeaderViewInfo.CalculateBounds do
  begin
    Result.Left := Left;
    Result.Right := Right;
  end;
end;

function TcxGridFooterViewInfo.CalculateHeight: Integer;
begin
  CalculateParams;
  Result := BorderSize[bTop] + RowCount * RowHeight + BorderSize[bBottom];
  Inc(Result, SeparatorWidth);
end;

function TcxGridFooterViewInfo.CalculateItemHeight: Integer;
begin
  Result := inherited CalculateItemHeight + 2 * LookAndFeelPainter.FooterCellOffset;
end;

procedure TcxGridFooterViewInfo.CalculateItem(AIndex: Integer);
begin
  Items[AIndex].Calculate(GetItemLeftBound(AIndex), GetItemTopBound(AIndex),
    -1, GetItemHeight(AIndex));
end;

procedure TcxGridFooterViewInfo.CalculateItems;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    if IsItemVisible(I) then CalculateItem(I);
end;

function TcxGridFooterViewInfo.CalculateRowCount: Integer;
var
  I: Integer;
  ItemCount: array of Integer;
begin
  Result := 1;
  if Count = 0 then Exit;
  SetLength(ItemCount, GridView.VisibleItemCount);
  for I := 0 to Count - 1 do
    Inc(ItemCount[Items[I].Column.VisibleIndex]);
  for I := 0 to Length(ItemCount) - 1 do
    Result := Max(Result, ItemCount[I]);
end;

function TcxGridFooterViewInfo.CanCalculateAutoWidths: Boolean;
begin
  Result := False;
end;

function TcxGridFooterViewInfo.GetAlignment: TcxGridPartAlignment;
begin
  Result := gpaBottom;
end;

function TcxGridFooterViewInfo.GetAutoHeight: Boolean;
begin
  Result := GridViewInfo.SupportsAutoHeight and
    GridView.OptionsView.FooterAutoHeight and not MultipleSummaries;
end;

function TcxGridFooterViewInfo.GetBackgroundBitmap: TBitmap;
begin
  Result := GridView.BackgroundBitmaps.GetBitmap(bbFooter);
end;

function TcxGridFooterViewInfo.GetBordersBounds: TRect;
begin
  Result := Bounds;
  Inc(Result.Top, SeparatorWidth);
end;

function TcxGridFooterViewInfo.GetBorders: TcxBorders;
begin
  Result := LookAndFeelPainter.FooterBorders;
end;

function TcxGridFooterViewInfo.GetBorderWidth(AIndex: TcxBorder): Integer;
begin
  Result := LookAndFeelPainter.FooterBorderSize;
end;

function TcxGridFooterViewInfo.GetColumnWidth(AColumn: TcxGridColumn): Integer;
begin
  Result := GridViewInfo.HeaderViewInfo[AColumn.VisibleIndex].Width;
  if AColumn.IsMostLeft then
    Dec(Result, BorderSize[bLeft]);
  if AColumn.IsMostRight then
    Dec(Result, BorderSize[bRight]);
end;

function TcxGridFooterViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridFooterHitTest;
end;

function TcxGridFooterViewInfo.GetIsAutoWidth: Boolean;
begin
  Result := GridViewInfo.HeaderViewInfo.IsAutoWidth;
end;

function TcxGridFooterViewInfo.GetIsScrollable: Boolean;
begin
  Result := GridViewInfo.HeaderViewInfo.IsScrollable;
end;

function TcxGridFooterViewInfo.GetItemAreaBounds(AItem: TcxGridColumnHeaderViewInfo): TRect;
begin
  Result := GridViewInfo.HeaderViewInfo.GetItemAreaBounds(AItem);
end;

function TcxGridFooterViewInfo.GetItemHeight(AColumn: TcxGridColumn): Integer;
begin
  if MultipleSummaries then
    Result := ItemHeight
  else
    Result := GridViewInfo.GetCellHeight(AColumn.VisibleIndex, ItemHeight);
end;

function TcxGridFooterViewInfo.GetItemHeight(AIndex: Integer): Integer;
begin
  Result := GetItemHeight(Items[AIndex].Column);
end;

function TcxGridFooterViewInfo.GetItemHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridFooterCellHitTest;
end;

function TcxGridFooterViewInfo.GetItemLeftBound(AColumn: TcxGridColumn): Integer;
begin
  if AColumn.IsMostLeft then
    Result := ItemsAreaBounds.Left
  else
    Result := GridViewInfo.HeaderViewInfo[AColumn.VisibleIndex].RealBounds.Left;
end;

function TcxGridFooterViewInfo.GetItemLeftBound(AIndex: Integer): Integer;
begin
  Result := GetItemLeftBound(Items[AIndex].Column);
end;

function TcxGridFooterViewInfo.GetItemRowIndex(AIndex: Integer): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to AIndex - 1 do
    if Items[I].Column = Items[AIndex].Column then
      Inc(Result);
end;

function TcxGridFooterViewInfo.GetItemsAreaBounds: TRect;
begin
  Result := BordersBounds;
  with Result do
  begin
    Inc(Left, BorderSize[bLeft]);
    Inc(Top, BorderSize[bTop]);
    Dec(Right, BorderSize[bRight]);
    Dec(Bottom, BorderSize[bBottom]);
  end;
end;

function TcxGridFooterViewInfo.GetItemTopBound(AColumn: TcxGridColumn): Integer;
begin
  Result := ItemsAreaBounds.Top + GridViewInfo.GetCellTopOffset(AColumn.VisibleIndex, ItemHeight);
end;

function TcxGridFooterViewInfo.GetItemTopBound(AIndex: Integer): Integer;
begin
  Result := GetItemTopBound(Items[AIndex].Column) + GetItemRowIndex(AIndex) * RowHeight;
end;

function TcxGridFooterViewInfo.GetKind: TcxGridColumnContainerKind;
begin
  Result := ckFooter;
end;

function TcxGridFooterViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := GridViewInfo.GetFooterPainterClass;
end;

function TcxGridFooterViewInfo.GetSeparatorBounds: TRect;
begin
  Result := Bounds;
  Result.Bottom := Result.Top + SeparatorWidth;
end;

function TcxGridFooterViewInfo.GetSeparatorWidth: Integer;
begin
  if HasSeparator then
    Result := LookAndFeelPainter.FooterSeparatorSize
  else
    Result := 0;
end;

function TcxGridFooterViewInfo.GetSummaryItems: TcxDataSummaryItems;
begin
  Result := GridView.FDataController.Summary.FooterSummaryItems;
end;

procedure TcxGridFooterViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  GridView.Styles.GetFooterParams(nil, nil, -1, nil, AParams);
end;

function TcxGridFooterViewInfo.GetVisible: Boolean;
begin
  Result := GridView.OptionsView.Footer;
end;

function TcxGridFooterViewInfo.HasSeparator: Boolean;
begin
  Result := True;
end;

function TcxGridFooterViewInfo.IsAlwaysVisibleForCalculation: Boolean;
begin
  Result := False;
end;

function TcxGridFooterViewInfo.IsColumnOnFirstLayer(AColumnIndex: Integer): Boolean;
begin
  Result := False;
end;

function TcxGridFooterViewInfo.IsHeightAssigned: Boolean;
begin
  Result := False;
end;

function TcxGridFooterViewInfo.IsItemVisible(AIndex: Integer): Boolean;
begin
  Result := GridViewInfo.HeaderViewInfo[Items[AIndex].Column.VisibleIndex].Visible;
end;

function TcxGridFooterViewInfo.IsMultilayerLayout: Boolean;
begin
  Result := False;
end;

procedure TcxGridFooterViewInfo.Offset(DX, DY: Integer);
var
  I: Integer;
begin
  inherited;
  if DX <> 0 then
    for I := 0 to Count - 1 do
      if IsItemVisible(I) then
        if not Items[I].Calculated then
          CalculateItem(I)
        else
      else
        Items[I].Calculated := False;
end;

function TcxGridFooterViewInfo.CanShowMultipleSummaries: Boolean;
begin
  Result := GridView.OptionsView.CanShowFooterMultiSummaries;
end;

function TcxGridFooterViewInfo.GetCellBestFitWidth(AColumn: TcxGridColumn): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do
    if Items[I].Column = AColumn then
      Result := Max(Result, Items[I].GetBestFitWidth);
end;

function TcxGridFooterViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;

  function GetCellBounds(AColumn: TcxGridColumn): TRect;
  begin
    Result.Left := GetItemLeftBound(AColumn);
    Result.Right := Result.Left + GetColumnWidth(AColumn);
    if MultipleSummaries then
      with ItemsAreaBounds do
      begin
        Result.Top := Top;
        Result.Bottom := Bottom;
      end
    else
    begin
      Result.Top := GetItemTopBound(AColumn);
      Result.Bottom := Result.Top + GetItemHeight(AColumn);
    end;
  end;

var
  I: Integer;
  AColumn: TcxGridColumn;
  ColumnNotFound: Boolean;
begin
  Result := GetItemsHitTest(P);
  ColumnNotFound := True;
  if Result = nil then
  begin
    Result := inherited GetHitTest(P);
    if Result <> nil then
      for I := 0 to GridView.VisibleColumnCount - 1 do
      begin
        AColumn := GridView.VisibleColumns[I];
        if PtInRect(GetCellBounds(AColumn), P) and
          (ColumnNotFound or IsColumnOnFirstLayer(I)) then
        begin
          Result := GetItemHitTestClass.Instance(P);
          InitHitTest(Result);
          TcxGridFooterCellHitTest(Result).Column := AColumn;
          TcxGridFooterCellHitTest(Result).SummaryItem := nil;
          ColumnNotFound := False;
          if not IsMultilayerLayout then
            Break;
        end;
      end;
  end;
end;

{ TcxCustomGridIndicatorItemViewInfo }

constructor TcxCustomGridIndicatorItemViewInfo.Create(AContainer: TcxGridIndicatorViewInfo);
begin
  inherited Create(AContainer.GridViewInfo);
  FContainer := AContainer;
end;

destructor TcxCustomGridIndicatorItemViewInfo.Destroy;
begin
  FContainer.FItems.Remove(Self);
  inherited;
end;

function TcxCustomGridIndicatorItemViewInfo.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

function TcxCustomGridIndicatorItemViewInfo.GetGridViewInfo: TcxGridTableViewInfo;
begin
  Result := TcxGridTableViewInfo(inherited GridViewInfo);
end;

function TcxCustomGridIndicatorItemViewInfo.CalculateWidth: Integer;
begin
  Result := FContainer.Width;
end;

function TcxCustomGridIndicatorItemViewInfo.CustomDraw(ACanvas: TcxCanvas): Boolean;
begin
  Result := inherited CustomDraw(ACanvas);
  if not Result then
    GridView.DoCustomDrawIndicatorCell(ACanvas, Self, Result);
end;

function TcxCustomGridIndicatorItemViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridIndicatorHitTest;
end;

function TcxCustomGridIndicatorItemViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxCustomGridIndicatorItemPainter;
end;

procedure TcxCustomGridIndicatorItemViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  GridView.Styles.GetViewParams(vsIndicator, nil, nil, AParams);
end;

function TcxCustomGridIndicatorItemViewInfo.HasCustomDraw: Boolean;
begin
  Result := GridView.HasCustomDrawIndicatorCell;
end;

{ TcxGridIndicatorHeaderItemViewInfo }

function TcxGridIndicatorHeaderItemViewInfo.GetDropDownWindowValue: TcxCustomGridCustomizationPopup;
begin
  Result := TcxCustomGridCustomizationPopup(inherited DropDownWindow);
end;

function TcxGridIndicatorHeaderItemViewInfo.CalculateHeight: Integer;
begin
  Result := 0;
end;

function TcxGridIndicatorHeaderItemViewInfo.CanShowHint: Boolean;
begin
  Result := SupportsQuickCustomization;
end;

function TcxGridIndicatorHeaderItemViewInfo.GetCellBoundsForHint: TRect;
begin
  Result := Bounds;
end;

function TcxGridIndicatorHeaderItemViewInfo.GetHintTextRect(const AMousePos: TPoint): TRect;
begin
  Result := Bounds;
  OffsetRect(Result, 0, Height + 5);
end;

function TcxGridIndicatorHeaderItemViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridIndicatorHeaderHitTest;
end;

function TcxGridIndicatorHeaderItemViewInfo.GetHotTrack: Boolean;
begin
  Result := SupportsQuickCustomization;
end;

function TcxGridIndicatorHeaderItemViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridIndicatorHeaderItemPainter;
end;

function TcxGridIndicatorHeaderItemViewInfo.GetText: string;
begin
  Result := cxGetResourceString(@scxGridColumnsQuickCustomizationHint);
end;

procedure TcxGridIndicatorHeaderItemViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  GridView.Styles.GetHeaderParams(nil, AParams);
end;

function TcxGridIndicatorHeaderItemViewInfo.IsHintForText: Boolean;
begin
  Result := False;
end;

function TcxGridIndicatorHeaderItemViewInfo.IsHintMultiLine: Boolean;
begin
  Result := False;
end;

function TcxGridIndicatorHeaderItemViewInfo.SupportsQuickCustomization: Boolean;
begin
  Result := GridView.OptionsCustomize.ColumnsQuickCustomization;
end;

function TcxGridIndicatorHeaderItemViewInfo.CloseDropDownWindowOnDestruction: Boolean;
begin
  Result := False;
end;

function TcxGridIndicatorHeaderItemViewInfo.DropDownWindowExists: Boolean;
begin
  Result := GridView.Controller.HasItemsCustomizationPopup;
end;

function TcxGridIndicatorHeaderItemViewInfo.GetDropDownWindow: TcxCustomGridPopup;
begin
  Result := GridView.Controller.ItemsCustomizationPopup;
end;

{ TcxGridIndicatorRowItemViewInfo }

destructor TcxGridIndicatorRowItemViewInfo.Destroy;
begin
  FRowViewInfo.FIndicatorItem := nil;
  inherited;
end;

function TcxGridIndicatorRowItemViewInfo.GetGridRecord: TcxCustomGridRow;
begin
  Result := FRowViewInfo.GridRecord;
end;

function TcxGridIndicatorRowItemViewInfo.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

function TcxGridIndicatorRowItemViewInfo.CalculateHeight: Integer;
begin
  Result := 0;
end;

function TcxGridIndicatorRowItemViewInfo.GetBackgroundBitmap: TBitmap;
begin
  Result := GridView.BackgroundBitmaps.GetBitmap(bbIndicator);
end;

function TcxGridIndicatorRowItemViewInfo.GetIndicatorKind: TcxIndicatorKind;
var
  ARecordSelected: Boolean;
begin
  if GridRecord.IsFilterRow then
    Result := ikFilter
  else
    if GridRecord.IsNewItemRow then
      Result := ikInsert
    else
      if GridRecord.IsEditing then
        if dceInsert in GridView.FDataController.EditState then
          Result := ikInsert
        else
          Result := ikEdit
      else
      begin
        ARecordSelected := GridView.OptionsSelection.MultiSelect and GridRecord.Selected;
        if GridRecord.Focused then
          if ARecordSelected then
            Result := ikMultiArrow
          else
            Result := ikArrow
        else
          if ARecordSelected then
            Result := ikMultiDot
          else
            Result := ikNone;
      end;
end;

function TcxGridIndicatorRowItemViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridRowIndicatorHitTest;
end;

function TcxGridIndicatorRowItemViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridIndicatorRowItemPainter;
end;

function TcxGridIndicatorRowItemViewInfo.GetRowSizingEdgeBounds: TRect;
begin
  Result := Bounds;
  with Result do
  begin
    Top := Bottom - cxGridRowSizingEdgeSize div 2;
    Inc(Bottom, cxGridRowSizingEdgeSize div 2);
  end;  
end;

procedure TcxGridIndicatorRowItemViewInfo.InitHitTest(AHitTest: TcxCustomGridHitTest);
begin
  inherited;
  TcxGridRecordHitTest(AHitTest).GridRecord := GridRecord;
  if AHitTest is TcxGridRowIndicatorHitTest then
  begin
    AHitTest.ViewInfo := GridRecord.ViewInfo;
    TcxGridRowIndicatorHitTest(AHitTest).MultiSelect := GridView.Controller.MultiSelect;
  end;
end;

function TcxGridIndicatorRowItemViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
begin
  if RowViewInfo.CanSize and PtInRect(RowSizingEdgeBounds, P) then
  begin
    Result := TcxGridRowSizingEdgeHitTest.Instance(P);
    InitHitTest(Result);
  end
  else
    Result := inherited GetHitTest(P);
end;

function TcxGridIndicatorRowItemViewInfo.MouseDown(AHitTest: TcxCustomGridHitTest;
  AButton: TMouseButton; AShift: TShiftState): Boolean;
begin
  Result := inherited MouseDown(AHitTest, AButton, AShift);
  if (AButton = mbLeft) and (ssDouble in AShift) and
    (AHitTest.HitTestCode = htRowSizingEdge) then
    RowViewInfo.RowHeight := 0;
end;

{ TcxGridIndicatorFooterItemViewInfo }

function TcxGridIndicatorFooterItemViewInfo.GetSeparatorWidth: Integer;
begin
  Result := GridViewInfo.FooterViewInfo.SeparatorWidth;
end;

function TcxGridIndicatorFooterItemViewInfo.CalculateHeight: Integer;
begin
  Result := 0;
end;

function TcxGridIndicatorFooterItemViewInfo.GetBackgroundBitmap: TBitmap;
begin
  Result := GridViewInfo.FooterViewInfo.BackgroundBitmap;
end;

function TcxGridIndicatorFooterItemViewInfo.GetBorders: TcxBorders;
begin
  Result := LookAndFeelPainter.FooterBorders;
end;

function TcxGridIndicatorFooterItemViewInfo.GetBordersBounds: TRect;
begin
  Result := Bounds;
  Inc(Result.Top, SeparatorWidth);
end;

function TcxGridIndicatorFooterItemViewInfo.GetBorderWidth(AIndex: TcxBorder): Integer;
begin
  Result := LookAndFeelPainter.FooterBorderSize;
  if AIndex = bTop then Inc(Result, SeparatorWidth);
end;

function TcxGridIndicatorFooterItemViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridIndicatorFooterItemPainter;
end;

function TcxGridIndicatorFooterItemViewInfo.GetSeparatorBounds: TRect;
begin
  Result := Bounds;
  Result.Bottom := Result.Top + SeparatorWidth;
end;

function TcxGridIndicatorFooterItemViewInfo.HasSeparator: Boolean;
begin
  Result := GridViewInfo.FooterViewInfo.HasSeparator;
end;

{ TcxGridIndicatorViewInfo }

constructor TcxGridIndicatorViewInfo.Create(AGridViewInfo: TcxGridTableViewInfo);
begin
  inherited Create(AGridViewInfo);
  FItems := TList.Create;
end;

destructor TcxGridIndicatorViewInfo.Destroy;
begin
  DestroyItems;
  FItems.Free;
  inherited;
end;

function TcxGridIndicatorViewInfo.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxGridIndicatorViewInfo.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

function TcxGridIndicatorViewInfo.GetGridViewInfo: TcxGridTableViewInfo;
begin
  Result := TcxGridTableViewInfo(inherited GridViewInfo);
end;

function TcxGridIndicatorViewInfo.GetItem(Index: Integer): TcxCustomGridIndicatorItemViewInfo;
begin
  Result := TcxCustomGridIndicatorItemViewInfo(FItems[Index]);
end;

procedure TcxGridIndicatorViewInfo.DestroyItems;
var
  I: Integer;
begin
  for I := Count - 1 downto 0 do Items[I].Free;
end;

function TcxGridIndicatorViewInfo.CalculateHeight: Integer;
begin
  with GridViewInfo do
    Result := HeaderViewInfo.Height + ClientHeight + FooterViewInfo.Height;
end;

function TcxGridIndicatorViewInfo.CalculateWidth: Integer;
begin
  if Visible then
    Result := GridView.OptionsView.IndicatorWidth
  else
    Result := 0;
end;

function TcxGridIndicatorViewInfo.GetAlwaysVisible: Boolean;
begin
  Result := GridView.OptionsCustomize.ColumnsQuickCustomization;
end;

function TcxGridIndicatorViewInfo.GetBackgroundBitmap: TBitmap;
begin
  Result := GridViewInfo.BackgroundBitmap;
end;

function TcxGridIndicatorViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridIndicatorHitTest;
end;

function TcxGridIndicatorViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridIndicatorPainter;
end;

function TcxGridIndicatorViewInfo.GetRowItemClass(ARowViewInfo: TcxCustomGridRowViewInfo): TcxGridIndicatorRowItemViewInfoClass;
begin
  Result := TcxGridIndicatorRowItemViewInfo;
end;

procedure TcxGridIndicatorViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  AParams.Color := GridViewInfo.BackgroundColor;
end;

function TcxGridIndicatorViewInfo.GetVisible: Boolean;
begin
  Result := GridView.OptionsView.Indicator or AlwaysVisible;
end;

function TcxGridIndicatorViewInfo.GetWidth: Integer;
begin
  Result := CalculateWidth;
end;

function TcxGridIndicatorViewInfo.AddItem(AItemClass: TcxCustomGridIndicatorItemViewInfoClass): TcxCustomGridIndicatorItemViewInfo;
begin
  Result := AItemClass.Create(Self);
  FItems.Add(Result);
end;

function TcxGridIndicatorViewInfo.AddItem(ATopBound, AHeight: Integer;
  AItemClass: TcxCustomGridIndicatorItemViewInfoClass): TcxCustomGridIndicatorItemViewInfo;
begin
  Result := AddItem(AItemClass);
  Result.Calculate(Bounds.Left, ATopBound, Width, AHeight);
end;

function TcxGridIndicatorViewInfo.AddRowItem(ARowViewInfo: TcxCustomGridRowViewInfo): TcxCustomGridIndicatorItemViewInfo;
begin
  Result := AddItem(GetRowItemClass(ARowViewInfo));
  TcxGridIndicatorRowItemViewInfo(Result).RowViewInfo := ARowViewInfo;
end;

procedure TcxGridIndicatorViewInfo.Calculate(ALeftBound, ATopBound: Integer;
  AWidth: Integer = -1; AHeight: Integer = -1);
begin
  inherited;
  if GridViewInfo.HeaderViewInfo.Visible then
    GridViewInfo.HeaderViewInfo.AddIndicatorItems(Self, Bounds.Top);
  if GridViewInfo.FooterViewInfo.Visible then
    AddItem(Bounds.Bottom - GridViewInfo.FooterViewInfo.Height,
      GridViewInfo.FooterViewInfo.Height, TcxGridIndicatorFooterItemViewInfo);
end;

procedure TcxGridIndicatorViewInfo.CalculateRowItem(ARowViewInfo: TcxCustomGridRowViewInfo;
  AItem: TcxCustomGridIndicatorItemViewInfo);
begin
  AItem.Calculate(Bounds.Left, ARowViewInfo.Bounds.Top, Width, ARowViewInfo.Height);
end;

function TcxGridIndicatorViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := Items[I].GetHitTest(P);
    if Result <> nil then Exit;
  end;
  Result := inherited GetHitTest(P);
end;

function TcxGridIndicatorViewInfo.GetRowItemBounds(AGridRecord: TcxCustomGridRow): TRect;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    if (Items[I] is TcxGridIndicatorRowItemViewInfo) and
      (TcxGridIndicatorRowItemViewInfo(Items[I]).GridRecord = AGridRecord) then
    begin
      Result := Items[I].Bounds;
      Exit;
    end;
  Result := Rect(0, 0, 0, 0);
end;

{ TcxGridRowFooterCellViewInfo }

function TcxGridRowFooterCellViewInfo.GetContainer: TcxGridRowFooterViewInfo;
begin
  Result := TcxGridRowFooterViewInfo(inherited Container);
end;

function TcxGridRowFooterCellViewInfo.GetGridRecord: TcxCustomGridRow;
begin
  Result := Container.GridRecord;
end;

function TcxGridRowFooterCellViewInfo.GetText: string;
begin
  try
    Result := Summary.GroupFooterSummaryTexts[GridRecord.Index, Container.GroupLevel,
      SummaryItem.Index];
  except
    Application.HandleException(Self);
  end;
end;

procedure TcxGridRowFooterCellViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  GridView.Styles.GetFooterCellParams(GridRecord, Column, Container.GroupLevel,
    SummaryItem, AParams);
end;

{ TcxGridRowFooterViewInfo }

constructor TcxGridRowFooterViewInfo.Create(AContainer: TcxGridRowFootersViewInfo;
  ALevel: Integer);
begin
  FContainer := AContainer;
  FLevel := ALevel;
  inherited Create(AContainer.GridViewInfo);
end;

function TcxGridRowFooterViewInfo.GetIndent: Integer;
begin
  Result := VisualLevel * GridViewInfo.LevelIndent;
end;

function TcxGridRowFooterViewInfo.GetGridRecord: TcxCustomGridRow;
begin
  Result := RowViewInfo.GridRecord;
end;

function TcxGridRowFooterViewInfo.GetGroupLevel: Integer;
begin
  Result := RowViewInfo.Level - FLevel;
  if GridView.OptionsView.GroupFooters = gfVisibleWhenExpanded then
    Dec(Result);
end;

function TcxGridRowFooterViewInfo.GetRowViewInfo: TcxCustomGridRowViewInfo;
begin
  Result := FContainer.RowViewInfo;
end;

function TcxGridRowFooterViewInfo.CalculateHeight: Integer;
begin
  Result := inherited CalculateHeight;
  Height := Result;
end;

function TcxGridRowFooterViewInfo.CalculateWidth: Integer;
begin
  Result := inherited CalculateWidth - Indent;
end;

function TcxGridRowFooterViewInfo.GetColumnWidth(AColumn: TcxGridColumn): Integer;
begin
  Result := inherited GetColumnWidth(AColumn);
  if AColumn.IsMostLeft then Dec(Result, Indent);
end;

function TcxGridRowFooterViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridGroupFooterHitTest;
end;

function TcxGridRowFooterViewInfo.GetIsPart: Boolean;
begin
  Result := False;
end;

function TcxGridRowFooterViewInfo.GetItemAreaBounds(AItem: TcxGridColumnHeaderViewInfo): TRect;
begin
  Result := Container.GridViewInfo.FooterViewInfo.GetItemAreaBounds(AItem);
end;

function TcxGridRowFooterViewInfo.GetItemClass: TcxGridColumnHeaderViewInfoClass;
begin
  Result := TcxGridRowFooterCellViewInfo;
end;

function TcxGridRowFooterViewInfo.GetItemHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridGroupFooterCellHitTest;
end;

function TcxGridRowFooterViewInfo.GetItemMultiLinePainting(AItem: TcxGridColumnHeaderViewInfo): Boolean;
begin
  Result := GridViewInfo.FooterViewInfo.GetItemMultiLinePainting(AItem);
end;

function TcxGridRowFooterViewInfo.GetSummaryItems: TcxDataSummaryItems;
begin
  Result := GridView.FDataController.Summary.GroupSummaryItems[GroupLevel];
end;

procedure TcxGridRowFooterViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  GridView.Styles.GetFooterParams(GridRecord, nil, GroupLevel, nil, AParams);
end;

function TcxGridRowFooterViewInfo.GetVisible: Boolean;
begin
  Result := True;
end;

function TcxGridRowFooterViewInfo.GetVisualLevel: Integer;
begin
  Result := Container.GridViewInfo.GetVisualLevel(RowViewInfo.Level - FLevel);
end;

function TcxGridRowFooterViewInfo.HasSeparator: Boolean;
begin
  Result := False;
end;

procedure TcxGridRowFooterViewInfo.PrepareSummaryItems(ASummaryItems: TList);
begin
  GridViewInfo.FooterViewInfo.PrepareSummaryItems(ASummaryItems);
end;

function TcxGridRowFooterViewInfo.CanShowMultipleSummaries: Boolean;
begin
  Result := GridView.OptionsView.CanShowGroupFooterMultiSummaries;
end;

{ TcxGridRowFootersViewInfo }

constructor TcxGridRowFootersViewInfo.Create(ARowViewInfo: TcxCustomGridRowViewInfo);
begin
  inherited Create;
  FRowViewInfo := ARowViewInfo;
  FHeight := -1;
  CreateItems;
end;

destructor TcxGridRowFootersViewInfo.Destroy;
begin
  DestroyItems;
  inherited;
end;

function TcxGridRowFootersViewInfo.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxGridRowFootersViewInfo.GetGridViewInfo: TcxGridTableViewInfo;
begin
  Result := FRowViewInfo.GridViewInfo;
end;

function TcxGridRowFootersViewInfo.GetHeight: Integer;
begin
  if FHeight = -1 then
    FHeight := CalculateHeight;
  Result := FHeight;  
end;

function TcxGridRowFootersViewInfo.GetItem(Index: Integer): TcxGridRowFooterViewInfo;
begin
  Result := TcxGridRowFooterViewInfo(FItems[Index]);
end;

function TcxGridRowFootersViewInfo.GetVisibleItem(ALevel: Integer): TcxGridRowFooterViewInfo;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := Items[I];
    if Result.Level = ALevel then Exit;
  end;
  Result := nil;  
end;

procedure TcxGridRowFootersViewInfo.CreateItems;
var
  I: Integer;
begin
  FItems := TList.Create;
  for I := 0 to FRowViewInfo.Level do
    if FRowViewInfo.HasFooter(I) then
      FItems.Add(GetItemClass.Create(Self, I));
end;

procedure TcxGridRowFootersViewInfo.DestroyItems;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do Items[I].Free;
  FItems.Free;
end;

procedure TcxGridRowFootersViewInfo.BeforeRecalculation;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].BeforeRecalculation;
end;

procedure TcxGridRowFootersViewInfo.Calculate(ALeftBound, ATopBound: Integer);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Items[I].Calculate(ALeftBound + Items[I].Indent, ATopBound);
    Inc(ATopBound, Items[I].Height);
  end;
end;

function TcxGridRowFootersViewInfo.CalculateHeight: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do
    Inc(Result, Items[I].CalculateHeight);
end;

function TcxGridRowFootersViewInfo.GetItemClass: TcxGridRowFooterViewInfoClass;
begin
  Result := TcxGridRowFooterViewInfo;
end;

function TcxGridRowFootersViewInfo.GetCellBestFitWidth(AColumn: TcxGridColumn): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do
    Result := Max(Result, Items[I].GetCellBestFitWidth(AColumn));
end;

function TcxGridRowFootersViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
  begin
    Result := Items[I].GetHitTest(P);
    if Result <> nil then Break;
  end;
end;

function TcxGridRowFootersViewInfo.GetTopBound(ALevel: Integer; var ATopBound: Integer): Boolean;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := Items[I].Level >= ALevel;
    if Result then
    begin
      ATopBound := Items[I].Bounds.Top;
      Exit;
    end;
  end;
  Result := False;
end;

procedure TcxGridRowFootersViewInfo.Offset(DX, DY: Integer);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].DoOffset(DX, DY);
end;

procedure TcxGridRowFootersViewInfo.Paint;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do Items[I].Paint;
end;

{ TcxCustomGridRowViewInfo }

constructor TcxCustomGridRowViewInfo.Create(ARecordsViewInfo: TcxCustomGridRecordsViewInfo;
  ARecord: TcxCustomGridRecord);
begin
  inherited;
  FIndicatorItem := GridViewInfo.IndicatorViewInfo.AddRowItem(Self);
  CreateFootersViewInfo;
end;

destructor TcxCustomGridRowViewInfo.Destroy;
begin
  DestroyFootersViewInfo;
  FIndicatorItem.Free;
  inherited;
end;

function TcxCustomGridRowViewInfo.GetCacheItem: TcxGridTableViewInfoCacheItem;
begin
  Result := TcxGridTableViewInfoCacheItem(inherited CacheItem);
end;

function TcxCustomGridRowViewInfo.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

function TcxCustomGridRowViewInfo.GetGridLines: TcxGridLines;
begin
  Result := RecordsViewInfo.GridLines;
end;

function TcxCustomGridRowViewInfo.GetGridRecord: TcxCustomGridRow;
begin
  Result := TcxCustomGridRow(inherited GridRecord);
end;

function TcxCustomGridRowViewInfo.GetGridViewInfo: TcxGridTableViewInfo;
begin
  Result := TcxGridTableViewInfo(inherited GridViewInfo);
end;

function TcxCustomGridRowViewInfo.GetLevel: Integer;
begin
  Result := GridRecord.Level;
end;

function TcxCustomGridRowViewInfo.GetLevelIndent: Integer;
begin
  Result := VisualLevel * GridViewInfo.LevelIndent;
end;

function TcxCustomGridRowViewInfo.GetLevelIndentBounds(Index: Integer): TRect;
begin
  Result := Bounds;
  if Index = -1 then
    Result.Right := ContentIndent
  else
  begin
    Inc(Result.Left, GridViewInfo.LevelIndent * Index);
    Result.Right := Result.Left + GridViewInfo.LevelIndent;
    FootersViewInfo.GetTopBound(Level - Index, Result.Bottom);
  end;
end;

function TcxCustomGridRowViewInfo.GetLevelIndentHorzLineBounds(Index: Integer): TRect;
begin
  Result := CalculateLevelIndentHorzLineBounds(Index, LevelIndentBounds[Index]);
end;

function TcxCustomGridRowViewInfo.GetLevelIndentSpaceBounds(Index: Integer): TRect;
begin
  Result := CalculateLevelIndentSpaceBounds(Index, LevelIndentBounds[Index]);
end;

function TcxCustomGridRowViewInfo.GetLevelIndentVertLineBounds(Index: Integer): TRect;
begin
  Result := CalculateLevelIndentVertLineBounds(Index, LevelIndentBounds[Index]);
end;

function TcxCustomGridRowViewInfo.GetRecordsViewInfo: TcxGridRowsViewInfo;
begin
  Result := TcxGridRowsViewInfo(inherited RecordsViewInfo);
end;

function TcxCustomGridRowViewInfo.GetVisualLevel: Integer;
begin
  Result := GridViewInfo.GetVisualLevel(Level);
end;

procedure TcxCustomGridRowViewInfo.CreateFootersViewInfo;
begin
  if HasFooters then
    FFootersViewInfo := GetFootersViewInfoClass.Create(Self);
end;

procedure TcxCustomGridRowViewInfo.DestroyFootersViewInfo;
begin
  FFootersViewInfo.Free;
end;

procedure TcxCustomGridRowViewInfo.RecreateFootersViewInfo;
begin
  DestroyFootersViewInfo;
  CreateFootersViewInfo;
end;

procedure TcxCustomGridRowViewInfo.AfterRowsViewInfoCalculate;
begin
end;

procedure TcxCustomGridRowViewInfo.AfterRowsViewInfoOffset;
begin
end;

procedure TcxCustomGridRowViewInfo.CalculateExpandButtonBounds(var ABounds: TRect);
begin
  if IsRectEmpty(Bounds) then
    ABounds := Rect(0, 0, 0, 0)
  else
    with ABounds do
    begin
      Inc(Left, GridViewInfo.ExpandButtonIndent);
      Right := Left + GridViewInfo.ExpandButtonSize;
      Top := (Top + Bottom - GridViewInfo.ExpandButtonSize) div 2;
      Bottom := Top + GridViewInfo.ExpandButtonSize;
    end;
end;

function TcxCustomGridRowViewInfo.CalculateHeight: Integer;
begin
  Result := BottomPartHeight;
end;

function TcxCustomGridRowViewInfo.CalculateLevelIndentHorzLineBounds(ALevel: Integer;
  const ABounds: TRect): TRect;
begin
  Result := ABounds;
  with Result do
  begin
    Top := CalculateLevelIndentSpaceBounds(ALevel, ABounds).Bottom;
    Bottom := Top + GridViewInfo.GridLineWidth;
    if Bottom > ABounds.Bottom then Bottom := ABounds.Bottom;
  end;  
end;

function TcxCustomGridRowViewInfo.CalculateLevelIndentSpaceBounds(ALevel: Integer;
  const ABounds: TRect): TRect;
var
  AIsParentRecordLast: Boolean;
begin
  AIsParentRecordLast := GridRecord.IsParentRecordLast[Level - ALevel - 1];
  Result := ABounds;
  if GridLines in [glBoth, glHorizontal] then
    Dec(Result.Right, GridViewInfo.GridLineWidth);
  if (GridLines <> glNone) and ((GridLines <> glVertical) and AIsParentRecordLast) then
    Dec(Result.Bottom, GridViewInfo.GridLineWidth);
  if AIsParentRecordLast and not HasAnyFooter(Level - ALevel) then
    Dec(Result.Bottom, SeparatorWidth);
end;

function TcxCustomGridRowViewInfo.CalculateLevelIndentVertLineBounds(ALevel: Integer;
  const ABounds: TRect): TRect;
begin
  Result := ABounds;
  with CalculateLevelIndentSpaceBounds(ALevel, ABounds) do
  begin
    Result.Left := Right;
    Result.Bottom := Bottom;
  end;
end;

function TcxCustomGridRowViewInfo.CalculateWidth: Integer;
begin
  Result := 0{Width};
end;

function TcxCustomGridRowViewInfo.CanSize: Boolean;
begin
  Result := False;
end;

procedure TcxCustomGridRowViewInfo.CheckRowHeight(var AValue: Integer);
begin
  if AValue < 1 then AValue := 1;
end;

function TcxCustomGridRowViewInfo.GetAutoHeight: Boolean;
begin
  Result := RecordsViewInfo.AutoRecordHeight;
end;

function TcxCustomGridRowViewInfo.GetBaseHeight: Integer;
begin
  Result := DataHeight;
end;

function TcxCustomGridRowViewInfo.GetBottomPartHeight: Integer;
begin
  Result := SeparatorWidth;
  if HasFooters then
    Inc(Result, FFootersViewInfo.Height);
  if HasLastHorzGridLine then
    Inc(Result, GridViewInfo.GridLineWidth);
end;

function TcxCustomGridRowViewInfo.GetCellTransparent(ACell: TcxGridTableCellViewInfo): Boolean;
begin
  Result := inherited GetCellTransparent(ACell) and not ACell.Selected;
end;

function TcxCustomGridRowViewInfo.GetContentBounds: TRect;
begin
  Result := inherited GetContentBounds;
  Result.Left := ContentIndent;
  Result.Bottom := Result.Top + DataHeight;
end;

function TcxCustomGridRowViewInfo.GetContentIndent: Integer;
begin
  Result := Bounds.Left + LevelIndent;
end;

function TcxCustomGridRowViewInfo.GetContentWidth: Integer;
begin
  Result := Width - LevelIndent;
end;

function TcxCustomGridRowViewInfo.GetDataHeight: Integer;
begin
  Result := Height - BottomPartHeight;
end;

function TcxCustomGridRowViewInfo.GetDataIndent: Integer;
begin
  Result := ContentIndent;
end;

function TcxCustomGridRowViewInfo.GetDataWidth: Integer;
begin
  Result := ContentWidth;
end;

function TcxCustomGridRowViewInfo.GetFocusRectBounds: TRect;
begin
  Result := inherited GetFocusRectBounds;
  Result.Left := DataIndent;
  if GridLines <> glNone then
    Dec(Result.Right, GridViewInfo.GridLineWidth);
  Result.Bottom := Result.Top + DataHeight;
  if GridLines in [glBoth, glHorizontal] then
    Dec(Result.Bottom, GridViewInfo.GridLineWidth);
end;

function TcxCustomGridRowViewInfo.GetFootersViewInfoClass: TcxGridRowFootersViewInfoClass;
begin
  Result := TcxGridRowFootersViewInfo;
end;

function TcxCustomGridRowViewInfo.GetLastHorzGridLineBounds: TRect;
begin
  Result := Bounds;
  Result.Top := Result.Bottom - GridViewInfo.GridLineWidth;
end;

function TcxCustomGridRowViewInfo.GetMaxHeight: Integer;
begin
  Result := Height;
end;

function TcxCustomGridRowViewInfo.GetNonBaseHeight: Integer;
begin
  Result := Height - BaseHeight;
end;

function TcxCustomGridRowViewInfo.GetRowHeight: Integer;
begin
  Result := Height;
end;

function TcxCustomGridRowViewInfo.GetSeparatorBounds: TRect;
var
  ASeparatorVisualLevel: Integer;
begin
  with Result do
  begin
    Left := ContentIndent;
    Right := Left + ContentWidth;
    ASeparatorVisualLevel :=
      GridViewInfo.GetVisualLevel(Level - GridRecord.LastParentRecordCount);
    Dec(Left, (VisualLevel - ASeparatorVisualLevel) * GridViewInfo.LevelIndent);
    Bottom := Bounds.Bottom;
    Top := Bottom - SeparatorWidth;
  end;
end;
            
function TcxCustomGridRowViewInfo.GetSeparatorColor: TColor;
begin
  Result := GridView.OptionsView.GetRowSeparatorColor;
end;

function TcxCustomGridRowViewInfo.GetSeparatorWidth: Integer;
begin
  if ShowSeparator then
    Result := RecordsViewInfo.SeparatorWidth
  else
    Result := 0;
end;

function TcxCustomGridRowViewInfo.GetShowSeparator: Boolean;
begin
  Result := True;
end;

function TcxCustomGridRowViewInfo.GetVisible: Boolean;
begin
  Result := Index < RecordsViewInfo.PartVisibleCount;
end;

function TcxCustomGridRowViewInfo.GetWidth: Integer;
begin
  Result := RecordsViewInfo.RowWidth;
end;

function TcxCustomGridRowViewInfo.HasAnyFooter(ALevel: Integer): Boolean;
var
  AFooterTopBound: Integer;
begin
  Result := FootersViewInfo.GetTopBound(ALevel, AFooterTopBound);
end;

function TcxCustomGridRowViewInfo.HasFooter(ALevel: Integer): Boolean;
begin
  if GridView.OptionsView.GroupFooters = gfInvisible then
    Result := False
  else
  begin
    if GridView.OptionsView.GroupFooters = gfAlwaysVisible then
      Dec(ALevel);
    Result := (0 <= ALevel) and (ALevel < Level) and
      GridRecord.IsParentRecordLast[ALevel] and
      GridView.GroupedColumns[Level - 1 - ALevel].CanShowGroupFooters;
  end;
end;

function TcxCustomGridRowViewInfo.HasFooters: Boolean;
begin
  Result := True;
end;

function TcxCustomGridRowViewInfo.HasLastHorzGridLine: Boolean;
begin
  Result := RecordsViewInfo.HasLastHorzGridLine(Self) and GridRecord.IsLast;
end;

function TcxCustomGridRowViewInfo.IsFullyVisible: Boolean;
begin
  Result := Height = MaxHeight;
end;

procedure TcxCustomGridRowViewInfo.Offset(DX, DY: Integer);
begin   
  inherited;
  FIndicatorItem.DoOffset(0, DY);
  if HasFooters then
    FFootersViewInfo.Offset(DX, DY);
end;

procedure TcxCustomGridRowViewInfo.BeforeRecalculation;
begin
  inherited;
  if HasFooters then
    FFootersViewInfo.BeforeRecalculation;
end;

procedure TcxCustomGridRowViewInfo.Calculate(ALeftBound, ATopBound: Integer;
  AWidth: Integer = -1; AHeight: Integer = -1);
begin
  RecreateFootersViewInfo;
  inherited;
  GridViewInfo.IndicatorViewInfo.CalculateRowItem(Self, FIndicatorItem);
  if HasFooters then
    FFootersViewInfo.Calculate(Bounds.Left, ATopBound + Height - BottomPartHeight);
end;

function TcxCustomGridRowViewInfo.Click(AHitTest: TcxCustomGridHitTest; AButton: TMouseButton;
  AShift: TShiftState): Boolean;
var
  AGridRecord: TcxCustomGridRow;
begin
  AGridRecord := GridRecord;
  Result := inherited Click(AHitTest, AButton, AShift);
  if Result and (ssDouble in AShift) and AGridRecord.ExpandOnDblClick then
    AGridRecord.ToggleExpanded;
end;

function TcxCustomGridRowViewInfo.GetBoundsForInvalidate(AItem: TcxCustomGridTableItem): TRect;
var
  R: TRect;
begin
  Result := inherited GetBoundsForInvalidate(AItem);
  if AItem = nil then
    with GridViewInfo.IndicatorViewInfo do
      if Visible then
      begin
        R := GetRowItemBounds(GridRecord);
        if R.Left < Result.Left then Result.Left := R.Left;
      end;
end;

function TcxCustomGridRowViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
begin
  if HasFooters then
    Result := FFootersViewInfo.GetHitTest(P)
  else
    Result := nil;
  if Result = nil then
  begin
    Result := inherited GetHitTest(P);
    if (Result <> nil) and PtInRect(LevelIndentBounds[-1], P) then
    begin
      Result := TcxGridRowLevelIndentHitTest.Instance(P);
      InitHitTest(Result);
    end;
  end;
end;

function TcxCustomGridRowViewInfo.HasSeparator: Boolean;
begin
  Result := SeparatorWidth <> 0;
end;

{ TcxGridRowsViewInfo }

destructor TcxGridRowsViewInfo.Destroy;
begin
  FFilterRowViewInfo.Free;
  FNewItemRowViewInfo.Free;
  inherited;
end;

function TcxGridRowsViewInfo.GetFilterRowViewInfo: TcxCustomGridRowViewInfo;
begin
  Result := FFilterRowViewInfo;
  if (Result <> nil) and (Result.GridRecord = nil) then
    Result := nil;
end;

function TcxGridRowsViewInfo.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

function TcxGridRowsViewInfo.GetGridLines: TcxGridLines;
begin
  Result := GridViewInfo.GridLines;
end;

function TcxGridRowsViewInfo.GetGridViewInfo: TcxGridTableViewInfo;
begin
  Result := TcxGridTableViewInfo(inherited GridViewInfo);
end;

function TcxGridRowsViewInfo.GetHeaderViewInfo: TcxGridHeaderViewInfo;
begin
  Result := GridViewInfo.HeaderViewInfo;
end;

function TcxGridRowsViewInfo.GetItem(Index: Integer): TcxCustomGridRowViewInfo;
begin
  Result := TcxCustomGridRowViewInfo(inherited Items[Index]);
end;

function TcxGridRowsViewInfo.GetNewItemRowViewInfo: TcxCustomGridRowViewInfo;
begin
  Result := FNewItemRowViewInfo;
  if (Result <> nil) and (Result.GridRecord = nil) then
    Result := nil;
end;

function TcxGridRowsViewInfo.GetPainterClassValue: TcxGridRowsPainterClass;
begin
  Result := TcxGridRowsPainterClass(GetPainterClass);
end;

function TcxGridRowsViewInfo.GetViewData: TcxGridViewData;
begin
  Result := TcxGridViewData(inherited ViewData);
end;

procedure TcxGridRowsViewInfo.AfterCalculate;
begin
  NotifyItemsCalculationFinished;
  inherited;
end;

procedure TcxGridRowsViewInfo.AfterOffset;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].AfterRowsViewInfoOffset;
  NotifyItemsCalculationFinished;
  inherited;
end;

procedure TcxGridRowsViewInfo.Calculate;

  procedure CalculateItems;
  var
    I: Integer;
  begin
    for I := 0 to FPartVisibleCount - 1 do
      Items[I].MainCalculate(GetItemLeftBound(I), GetItemTopBound(I));
  end;

var
  ATopBound: Integer;
begin
  CalculateConsts;
  inherited;
  if GridViewInfo.CalculateDown then
  begin
    ATopBound := Bounds.Top;
    if HasFilterRow then
    begin
      FilterRowViewInfo.MainCalculate(ContentBounds.Left, ATopBound);
      Inc(ATopBound, FilterRowViewInfo.Height);
    end;
    if HasNewItemRow then
      NewItemRowViewInfo.MainCalculate(ContentBounds.Left, ATopBound);
  end;
  CalculateVisibleCount;
  if GridViewInfo.CalculateDown and (FirstRecordIndex <> -1) then
    CalculateItems;
end;

function TcxGridRowsViewInfo.CalculateBounds: TRect;
begin
  Result := inherited CalculateBounds;
  if IsScrollable then
    Dec(Result.Left, GridViewInfo.LeftPos);
  Result.Right := Result.Left + RowWidth;
end;

procedure TcxGridRowsViewInfo.CalculateConsts;
begin
  FRowHeight := CalculateRowHeight;
  FDataRowHeight := CalculateDataRowHeight;
  FGroupRowHeight := CalculateGroupRowHeight;
end;

function TcxGridRowsViewInfo.CalculateContentBounds: TRect;
begin
  Result := inherited CalculateContentBounds;
  if HasFilterRow then
    Inc(Result.Top, FilterRowViewInfo.Height);
  if HasNewItemRow then
    Inc(Result.Top, NewItemRowViewInfo.Height);
end;

function TcxGridRowsViewInfo.CalculateDataRowHeight: Integer;
begin
  Result := FRowHeight;
end;

function TcxGridRowsViewInfo.CalculateGroupRowDefaultHeight(AMinHeight: Boolean): Integer;
var
  AParams: TcxViewParams;
begin
  GridView.Styles.GetGroupParams(nil, 0, AParams);
  Result := CalculateCustomGroupRowHeight(AMinHeight, AParams);
end;

function TcxGridRowsViewInfo.CalculateGroupRowHeight: Integer;
begin
  Result := GridView.OptionsView.GroupRowHeight;
  if Result = 0 then
    Result := CalculateGroupRowDefaultHeight(False);
end;

function TcxGridRowsViewInfo.CalculateRestHeight(ATopBound: Integer): Integer;
begin
  Result := ContentBounds.Bottom - ATopBound;
  {if not GridViewInfo.IsCalculating or GridViewInfo.CalculateDown then
    Result := ContentBounds.Bottom - ATopBound
  else
    Result := MaxInt - 100000;}
end;

function TcxGridRowsViewInfo.CalculateRowDefaultHeight: Integer;
var
  I, AFontHeight: Integer;
  AParams: TcxViewParams;
begin
  if GridView.VisibleColumnCount = 0 then
  begin
    GridView.Styles.GetContentParams(nil, nil, AParams);
    Result := GridViewInfo.GetFontHeight(AParams.Font);
    GetCellTextAreaSize(Result);
  end
  else
  begin
    Result := 0;
    for I := 0 to HeaderViewInfo.Count - 1 do
    begin
      GridView.Styles.GetDataCellParams(nil, HeaderViewInfo[I].Column, AParams);
      AFontHeight := HeaderViewInfo[I].Column.CalculateDefaultCellHeight(Canvas, AParams.Font);
      if AFontHeight > Result then Result := AFontHeight;
    end;
  end;
  Result := GetCellHeight(Result);
end;

function TcxGridRowsViewInfo.CalculateRowHeight: Integer;
begin
  if IsDataRowHeightAssigned then
    Result := GridView.OptionsView.DataRowHeight
  else
    Result := CalculateRowDefaultHeight;
end;

procedure TcxGridRowsViewInfo.CalculateVisibleCount;
var
  ALastBottom, I, AHeight: Integer;
begin  
  inherited;
  FPartVisibleCount := 0;
  FIsFirstRowFullyVisible := True;
  if FirstRecordIndex = -1 then Exit;

  ALastBottom := ContentBounds.Top;
  for I := 0 to MaxCount - 1 do
  begin
    Inc(FPartVisibleCount);
    FRestHeight := CalculateRestHeight(ALastBottom);
    AHeight := Items[I].MaxHeight;
    Inc(ALastBottom, AHeight);
    if ALastBottom > ContentBounds.Bottom then Break;
    Inc(FVisibleCount);
    if ALastBottom = ContentBounds.Bottom then Break;
  end;

  if MaxCount > 0 then
  begin
    if (FVisibleCount = FPartVisibleCount) and
      (GridViewInfo.CalculateDown and not Items[FVisibleCount - 1].IsFullyVisible or
       not GridViewInfo.CalculateDown and not Items[0].IsFullyVisible) then
      Dec(FVisibleCount);
    if FVisibleCount = 0 then
    begin
      FVisibleCount := 1;
      FIsFirstRowFullyVisible := False;
    end;
  end;
end;

function TcxGridRowsViewInfo.GetAutoDataCellHeight: Boolean;
begin
  Result := inherited GetAutoDataCellHeight and
    GridViewInfo.SupportsAutoHeight and
    (not IsDataRowHeightAssigned or GridView.IsGetCellHeightAssigned);
end;

function TcxGridRowsViewInfo.GetCommonDataRowHeight: Integer;
begin
  Result := FDataRowHeight + SeparatorWidth;
end;

function TcxGridRowsViewInfo.GetFilterRowViewInfoClass: TcxCustomGridRowViewInfoClass;
begin
  Result := TcxGridFilterRowViewInfo;
end;

function TcxGridRowsViewInfo.GetGroupBackgroundBitmap: TBitmap;
begin
  Result := GridView.BackgroundBitmaps.GetBitmap(bbGroup);
end;

function TcxGridRowsViewInfo.GetGroupRowSeparatorWidth: Integer;
begin
  if GridView.OptionsView.GroupRowStyle = grsOffice11 then
    Result := cxGridOffice11GroupRowSeparatorWidth
  else
    Result := 0;
end;

function TcxGridRowsViewInfo.GetItemLeftBound(AIndex: Integer): Integer;
begin   
  Result := ContentBounds.Left;
end;

function TcxGridRowsViewInfo.GetItemsOffset(AItemCountDelta: Integer): Integer;
var
  I: Integer;
begin   
  Result := 0;
  for I := 0 to Abs(AItemCountDelta) - 1 do
    Inc(Result, Items[I].Height);
  if AItemCountDelta > 0 then
    Result := -Result;
end;

function TcxGridRowsViewInfo.GetItemTopBound(AIndex: Integer): Integer;
begin      
  if AIndex = 0 then
    Result := ContentBounds.Top
  else
    Result := Items[AIndex - 1].Bounds.Bottom;
end;

function TcxGridRowsViewInfo.GetIsScrollable: Boolean;
begin
  Result := HeaderViewInfo.IsScrollable;
end;

function TcxGridRowsViewInfo.GetNewItemRowViewInfoClass: TcxCustomGridRowViewInfoClass;
begin
  Result := TcxGridNewItemRowViewInfo;
end;

function TcxGridRowsViewInfo.GetPainterClass: TcxCustomGridRecordsPainterClass;
begin
  Result := TcxGridRowsPainter;
end;

function TcxGridRowsViewInfo.GetRowWidth: Integer;
begin
  Result := GridViewInfo.DataWidth;
end;

function TcxGridRowsViewInfo.GetSeparatorWidth: Integer;
begin
  Result := GridView.OptionsView.RowSeparatorWidth;
end;

function TcxGridRowsViewInfo.HasFilterRow: Boolean;
begin
  Result := FilterRowViewInfo <> nil;
end;

function TcxGridRowsViewInfo.HasLastHorzGridLine(ARowViewInfo: TcxCustomGridRowViewInfo): Boolean;
begin
  Result := (GridLines = glVertical) and
    ((ARowViewInfo = nil) and (SeparatorWidth = 0) or
     (ARowViewInfo <> nil) and not ARowViewInfo.HasSeparator);
end;

function TcxGridRowsViewInfo.HasNewItemRow: Boolean;
begin
  Result := NewItemRowViewInfo <> nil;
end;

function TcxGridRowsViewInfo.IsFilterRowVisible: Boolean;
begin
  Result := GridView.FilterRow.Visible;
end;

function TcxGridRowsViewInfo.IsNewItemRowVisible: Boolean;
begin
  Result := GridView.NewItemRow.Visible;
end;

procedure TcxGridRowsViewInfo.NotifyItemsCalculationFinished;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].AfterRowsViewInfoCalculate;
end;

procedure TcxGridRowsViewInfo.OffsetItem(AIndex, AOffset: Integer);
begin    
  Items[AIndex].DoOffset(0, AOffset);
end;

procedure TcxGridRowsViewInfo.AfterConstruction;
begin
  inherited;
  if IsFilterRowVisible then
    FFilterRowViewInfo := GetFilterRowViewInfoClass.Create(Self, ViewData.FilterRow);
  if IsNewItemRowVisible then
    FNewItemRowViewInfo := GetNewItemRowViewInfoClass.Create(Self, ViewData.NewItemRow);
end;

function TcxGridRowsViewInfo.CalculateCustomGroupRowHeight(AMinHeight: Boolean;
  AParams: TcxViewParams): Integer;
begin
  Result := Max(GridViewInfo.GetFontHeight(AParams.Font), GridViewInfo.ExpandButtonSize);
  GetCellTextAreaSize(Result);
  if GridView.OptionsView.GroupRowStyle = grsStandard then
    Result := GetCellHeight(Result)
  else
  begin
    if not AMinHeight then
      Result := 2 * Result;
    Inc(Result, GroupRowSeparatorWidth);
  end;  
end;

function TcxGridRowsViewInfo.CanDataRowSize: Boolean;
begin
  Result := GridViewInfo.SupportsAutoHeight and GridView.OptionsCustomize.DataRowSizing;
end;

function TcxGridRowsViewInfo.GetCellHeight(ACellContentHeight: Integer): Integer;
begin
  Result := inherited GetCellHeight(ACellContentHeight);
  if GridLines in [glBoth, glHorizontal] then
    Inc(Result, GridViewInfo.GridLineWidth);
end;

function TcxGridRowsViewInfo.GetDataRowCellsAreaViewInfoClass: TClass;
begin
  Result := TcxGridDataRowCellsAreaViewInfo;
end;

function TcxGridRowsViewInfo.GetFooterCellBestFitWidth(AColumn: TcxGridColumn): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do
    if Items[I].HasFooters then
      Result := Max(Result, Items[I].FootersViewInfo.GetCellBestFitWidth(AColumn));
end;

function TcxGridRowsViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
begin
  Result := inherited GetHitTest(P);
  if Result = nil then
  begin
    if HasFilterRow then
      Result := FilterRowViewInfo.GetHitTest(P);
    if (Result = nil) and HasNewItemRow then
      Result := NewItemRowViewInfo.GetHitTest(P);
  end;
end;

function TcxGridRowsViewInfo.GetRealItem(ARecord: TcxCustomGridRecord): TcxCustomGridRecordViewInfo;
begin
  if ViewData.HasFilterRow and (ARecord = ViewData.FilterRow) then
    Result := FilterRowViewInfo
  else
    if ViewData.HasNewItemRecord and ARecord.IsNewItemRecord then
      Result := NewItemRowViewInfo
    else
      Result := inherited GetRealItem(ARecord);
end;

function TcxGridRowsViewInfo.GetRestHeight(ATopBound: Integer): Integer;
begin
  if GridViewInfo.IsCalculating then
    Result := FRestHeight
  else
    Result := CalculateRestHeight(ATopBound);
end;

function TcxGridRowsViewInfo.IsCellMultiLine(AItem: TcxCustomGridTableItem): Boolean;
begin
  Result := inherited IsCellMultiLine(AItem) or IsDataRowHeightAssigned;
end;

function TcxGridRowsViewInfo.IsDataRowHeightAssigned: Boolean;
begin
  Result := GridViewInfo.SupportsAutoHeight and (GridView.OptionsView.DataRowHeight <> 0);
end;

procedure TcxGridRowsViewInfo.Offset(DX, DY: Integer);
var
  I: Integer;
begin                               
  inherited;
  if HasFilterRow then
    FilterRowViewInfo.DoOffset(DX, 0);
  if HasNewItemRow then
    NewItemRowViewInfo.DoOffset(DX, 0);
  for I := 0 to Count - 1 do
    Items[I].DoOffset(DX, 0);
end;

{ TcxGridTableViewInfo }

function TcxGridTableViewInfo.GetController: TcxGridTableController;
begin
  Result := TcxGridTableController(inherited Controller);
end;

function TcxGridTableViewInfo.GetDataWidth: Integer;
begin
  if FDataWidth = 0 then
    FDataWidth := CalculateDataWidth;
  Result := FDataWidth;
end;

function TcxGridTableViewInfo.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

function TcxGridTableViewInfo.GetGridLineColor: TColor;
begin
  Result := GridView.OptionsView.GetGridLineColor;
end;

function TcxGridTableViewInfo.GetGridLines: TcxGridLines;
begin
  Result := GridView.OptionsView.GridLines;
end;

function TcxGridTableViewInfo.GetLeftPos: Integer;
begin
  Result := Controller.LeftPos;
end;

function TcxGridTableViewInfo.GetLevelIndentBackgroundBitmap: TBitmap;
begin
  Result := RecordsViewInfo.GroupBackgroundBitmap;
end;

function TcxGridTableViewInfo.GetLevelIndentColor(Index: Integer): TColor;
var
  AParams: TcxViewParams;
begin
  GridView.Styles.GetGroupParams(nil, Index, AParams);
  Result := AParams.Color;
end;

function TcxGridTableViewInfo.GetRecordsViewInfo: TcxGridRowsViewInfo;
begin
  Result := TcxGridRowsViewInfo(inherited RecordsViewInfo);
end;

function TcxGridTableViewInfo.GetViewData: TcxGridViewData;
begin
  Result := TcxGridViewData(inherited ViewData);
end;

procedure TcxGridTableViewInfo.AfterCalculating;
begin
  if Visible and (RecordsViewInfo.DataRowHeight <> FPrevDataRowHeight) then
    Controller.PostGridModeBufferCountUpdate;
  inherited;
end;

procedure TcxGridTableViewInfo.BeforeCalculating;
begin
  inherited;
  CalculateExpandButtonParams;
  if Visible then
    FPrevDataRowHeight := RecordsViewInfo.DataRowHeight;
end;

procedure TcxGridTableViewInfo.CreateViewInfos;

  function GetFilterViewInfoIndex: Integer;
  begin
    if FilterViewInfo.Alignment = gpaTop then
      Result := FHeaderViewInfo.Index
    else
      Result := FFooterViewInfo.Index;
  end;

begin
//  inherited; - because of new item row view info in banded view
  FGroupByBoxViewInfo := GetGroupByBoxViewInfoClass.Create(Self);
  FHeaderViewInfo := GetHeaderViewInfoClass.Create(Self);
  FFooterViewInfo := GetFooterViewInfoClass.Create(Self);
  FIndicatorViewInfo := GetIndicatorViewInfoClass.Create(Self);
  inherited;
  FilterViewInfo.Index := GetFilterViewInfoIndex;
end;

procedure TcxGridTableViewInfo.DestroyViewInfos(AIsRecreating: Boolean);
begin
  inherited;
  FreeAndNil(FIndicatorViewInfo);
  FreeAndNil(FFooterViewInfo);
  FreeAndNil(FHeaderViewInfo);
  FreeAndNil(FGroupByBoxViewInfo);
//  inherited;
end;

{var
  max: integer;}

procedure TcxGridTableViewInfo.Calculate;
(*var
  ft,lt{,i}: Integer;*)
begin
  //ft := gettickcount;

//for I := 1 to 10 do

  try
    RecreateViewInfos;
    CalculateParts;
    ClientBounds := CalculateClientBounds;
    IndicatorViewInfo.Calculate(Bounds.Left, ClientBounds.Top - HeaderViewInfo.Height);
  finally
    inherited;
  end;

(*if CalculateDown then
begin
  lt := gettickcount;
  //if lt - ft > max then max := lt - ft;
  //if TcxGridLevel(GridView.Level).IsTop then
  application.MainForm.Caption :=
  //inttostr(max);
  inttostr(lt - ft);
end;*)
end;

function TcxGridTableViewInfo.CalculateClientBounds: TRect;
begin
  Result := inherited CalculateClientBounds;
  Inc(Result.Left, IndicatorViewInfo.Width);
end;

function TcxGridTableViewInfo.CalculateDataWidth: Integer;
begin
  Result := HeaderViewInfo.Width;
  if (Result = 0) and GridView.OptionsView.ColumnAutoWidth then
    Result := ClientWidth;
end;

procedure TcxGridTableViewInfo.CalculateExpandButtonParams;
begin
  FExpandButtonIndent := 3;
  FLevelIndent := FExpandButtonIndent + ExpandButtonSize + FExpandButtonIndent;
end;

procedure TcxGridTableViewInfo.CalculateHeight(const AMaxSize: TPoint;
  var AHeight: Integer; var AFullyVisible: Boolean);
begin
  MainCalculate(Classes.Bounds(
    cxGridInvisibleCoordinate, 0, AMaxSize.X, AMaxSize.Y));
  if VisibleRecordCount = 0 then
    AHeight := GetNonRecordsAreaHeight(False) + RecordsViewInfo.DataRowHeight
  else
    AHeight := RecordsViewInfo.Items[RecordsViewInfo.Count - 1].Bounds.Bottom +
      PartsBottomHeight;
  AFullyVisible := (VisibleRecordCount = 0) or
    (VisibleRecordCount = ViewData.RowCount - FirstRecordIndex) and
    Controller.IsDataFullyVisible(True);
  inherited;
end;

function TcxGridTableViewInfo.CalculatePartBounds(APart: TcxCustomGridPartViewInfo): TRect;
begin
  Result := inherited CalculatePartBounds(APart);
  if APart.IsScrollable then
    OffsetRect(Result, -LeftPos, 0);
end;

procedure TcxGridTableViewInfo.CalculateParts;
begin
  GroupByBoxViewInfo.MainCalculate;
  FilterViewInfo.MainCalculate;
  HeaderViewInfo.MainCalculate;
  FooterViewInfo.MainCalculate;
end;

function TcxGridTableViewInfo.CalculateVisibleEqualHeightRecordCount: Integer;
begin
  Result := (Bounds.Bottom - Bounds.Top - GetNonRecordsAreaHeight(False)) div
    RecordsViewInfo.CommonDataRowHeight;
end;

procedure TcxGridTableViewInfo.CalculateWidth(const AMaxSize: TPoint; var AWidth: Integer);
begin
  if GridView.OptionsView.ColumnAutoWidth then
    with Site.ClientBounds do
      AWidth := Right - Left
  else
    AWidth := IndicatorViewInfo.Width + DataWidth;
  inherited;
end;

function TcxGridTableViewInfo.DoGetHitTest(const P: TPoint): TcxCustomGridHitTest;
begin
  if PtInRect(Site.ClientBounds, P) then
  begin
    Result := IndicatorViewInfo.GetHitTest(P);
    if Result <> nil then Exit;
  end;
  Result := inherited DoGetHitTest(P);
end;

function TcxGridTableViewInfo.GetDefaultGridModeBufferCount: Integer;
begin
  if RecordsViewInfo.DataRowHeight = 0 then
  begin
    Controller.PostGridModeBufferCountUpdate;
    Result := 0;
  end
  else
    Result := Screen.Height div RecordsViewInfo.DataRowHeight + 2;
end;

function TcxGridTableViewInfo.GetFirstItemAdditionalWidth: Integer;
begin
  Result := VisualLevelCount * LevelIndent;
end;

function TcxGridTableViewInfo.GetGridLineWidth: Integer;
begin
  Result := 1;
end;

function TcxGridTableViewInfo.GetLevelSeparatorColor: TColor;
begin
  Result := GridLineColor;
end;

function TcxGridTableViewInfo.GetNonRecordsAreaHeight(ACheckScrollBar: Boolean): Integer;
begin
  Result := inherited GetNonRecordsAreaHeight(ACheckScrollBar);
  with RecordsViewInfo do
  begin
    if HasFilterRow then
      Inc(Result, FilterRowViewInfo.Height);
    if HasNewItemRow then
      Inc(Result, NewItemRowViewInfo.Height);
  end;
end;

function TcxGridTableViewInfo.GetScrollableAreaBoundsHorz: TRect;
begin
  Result := inherited GetScrollableAreaBoundsHorz;
  Dec(Result.Top, HeaderViewInfo.Height);
  Inc(Result.Bottom, FooterViewInfo.Height);
end;

function TcxGridTableViewInfo.GetScrollableAreaBoundsVert: TRect;
begin
  Result := inherited GetScrollableAreaBoundsVert;
  Dec(Result.Left, IndicatorViewInfo.Width);
  Result.Top := RecordsViewInfo.ContentBounds.Top;
end;

function TcxGridTableViewInfo.GetVisualLevelCount: Integer;
begin
  Result := GridView.GroupedColumnCount;
  if (Result <> 0) and (GridView.OptionsView.GroupRowStyle = grsOffice11) then
    Dec(Result);
  if GridView.IsMaster then Inc(Result);
end;

procedure TcxGridTableViewInfo.Offset(DX, DY: Integer);
var
  I: Integer;
begin
  for I := 0 to PartCount - 1 do
    with Parts[I] do
      if IsScrollable then DoOffset(DX, 0);
  inherited;
end;

procedure TcxGridTableViewInfo.RecreateViewInfos;
begin
  FDataWidth := 0;
  inherited;
end;

function TcxGridTableViewInfo.SupportsAutoHeight: Boolean;
begin
  Result := True;
end;

function TcxGridTableViewInfo.SupportsGroupSummariesAlignedWithColumns: Boolean;
begin
  Result := True;
end;

function TcxGridTableViewInfo.SupportsMultipleFooterSummaries: Boolean;
begin
  Result := True;
end;

function TcxGridTableViewInfo.GetFooterPainterClass: TcxGridFooterPainterClass;
begin
  Result := TcxGridFooterPainter;
end;

function TcxGridTableViewInfo.GetFooterViewInfoClass: TcxGridFooterViewInfoClass;
begin
  Result := TcxGridFooterViewInfo;
end;

function TcxGridTableViewInfo.GetGroupByBoxViewInfoClass: TcxGridGroupByBoxViewInfoClass;
begin
  Result := TcxGridGroupByBoxViewInfo;
end;

function TcxGridTableViewInfo.GetHeaderViewInfoClass: TcxGridHeaderViewInfoClass;
begin
  Result := TcxGridHeaderViewInfo;
end;

function TcxGridTableViewInfo.GetIndicatorViewInfoClass: TcxGridIndicatorViewInfoClass;
begin
  Result := TcxGridIndicatorViewInfo;
end;

function TcxGridTableViewInfo.GetHeaderViewInfoSpecificClass: TcxGridHeaderViewInfoSpecificClass;
begin
  Result := TcxGridHeaderViewInfoSpecific;
end;

function TcxGridTableViewInfo.GetRecordsViewInfoClass: TcxCustomGridRecordsViewInfoClass;
begin
  Result := TcxGridRowsViewInfo;
end;

function TcxGridTableViewInfo.GetCellBorders(AIsRight, AIsBottom: Boolean): TcxBorders;
begin
  case GridLines of
    glBoth:
      Result := [bRight, bBottom];
    glNone:
      Result := [];
    glVertical:
      Result := [bRight];
    glHorizontal:
      begin
        if AIsRight then
          Result := [bRight]
        else
          Result := [];
        Include(Result, bBottom);
      end;
  end;
end;

function TcxGridTableViewInfo.GetCellHeight(AIndex, ACellHeight: Integer): Integer;
begin
  Result := ACellHeight;
end;

function TcxGridTableViewInfo.GetCellTopOffset(AIndex, ACellHeight: Integer): Integer;
begin
  Result := 0;
end;

function TcxGridTableViewInfo.GetOffsetBounds(AItemsOffset: Integer; out AUpdateBounds: TRect): TRect;
begin     
  Result := ScrollableAreaBoundsVert;
  AUpdateBounds := Result;
  if AItemsOffset < 0 then
  begin
    Inc(Result.Top, -AItemsOffset);
    with RecordsViewInfo do
      if VisibleCount >= 2 then
        Result.Bottom := Items[VisibleCount - 2].Bounds.Bottom;
    AUpdateBounds.Top := Result.Bottom + AItemsOffset;
  end
  else
  begin
    Dec(Result.Bottom, AItemsOffset);
    with RecordsViewInfo do
      if PartVisibleCount >= 2 then
        Result.Top := Items[1].Bounds.Top;
    AUpdateBounds.Bottom := Result.Top + AItemsOffset;
  end;
end;

function TcxGridTableViewInfo.GetOffsetBounds(DX, DY: Integer; out AUpdateBounds: TRect): TRect;
begin
  Result := ScrollableAreaBoundsHorz;
  AUpdateBounds := Result;
  if DX < 0 then
  begin
    Inc(Result.Left, -DX);
    AUpdateBounds.Left := Max(AUpdateBounds.Left, AUpdateBounds.Right + DX);
  end
  else
  begin
    Dec(Result.Right, DX);
    AUpdateBounds.Right := Min(AUpdateBounds.Left + DX, AUpdateBounds.Right);
  end;
end;

function TcxGridTableViewInfo.GetVisualLevel(ALevel: Integer): Integer;
begin
  Result := ALevel;
  if (Result <> 0) and (Result = GridView.GroupedColumnCount) and
    (GridView.OptionsView.GroupRowStyle = grsOffice11) then
    Dec(Result);
end;

function TcxGridTableViewInfo.GetNearestPopupHeight(AHeight: Integer;
  AAdditionalRecord: Boolean = False): Integer;
var
  ARowCount: Integer;
begin
  ARowCount := (AHeight - GetNonRecordsAreaHeight(True)) div RecordsViewInfo.DataRowHeight;
  if ARowCount < 1 then ARowCount := 1;
  if ARowCount > ViewData.RowCount + Ord(AAdditionalRecord) then
    ARowCount := ViewData.RowCount + Ord(AAdditionalRecord);
  Result := GetNonRecordsAreaHeight(True) + ARowCount * RecordsViewInfo.DataRowHeight;
end;

function TcxGridTableViewInfo.GetPopupHeight(ADropDownRowCount: Integer): Integer;
begin
  Result := GetNonRecordsAreaHeight(True) + ADropDownRowCount * RecordsViewInfo.DataRowHeight;
  if GridLines in [glNone, glVertical] then
    Inc(Result, GridLineWidth);
end;

{ TcxGridTableViewInfoCacheItem }

procedure TcxGridTableViewInfoCacheItem.SetPreviewHeight(Value: Integer);
begin
  FPreviewHeight := Value;
  IsPreviewHeightAssigned := True;
end;

procedure TcxGridTableViewInfoCacheItem.UnassignValues(AKeepMaster: Boolean);
begin
  inherited;
  IsPreviewHeightAssigned := False;
end;

{ TcxGridMasterTableViewInfoCacheItem }

destructor TcxGridMasterTableViewInfoCacheItem.Destroy;
begin
  if IsDetailsSiteCachedInfoAssigned then
    FreeAndNil(DetailsSiteCachedInfo);
  inherited;
end;

function TcxGridMasterTableViewInfoCacheItem.GetGridRecord: TcxGridMasterDataRow;
begin
  Result := TcxGridMasterDataRow(inherited GridRecord);
end;

function TcxGridMasterTableViewInfoCacheItem.GetIsDetailsSiteCachedInfoAssigned: Boolean;
begin
  Result := DetailsSiteCachedInfo <> nil;
end;

procedure TcxGridMasterTableViewInfoCacheItem.SetDetailsSiteFullyVisible(Value: Boolean);
begin
  FDetailsSiteFullyVisible := Value;
  IsDetailsSiteFullyVisibleAssigned := True;
end;

procedure TcxGridMasterTableViewInfoCacheItem.SetDetailsSiteHeight(Value: Integer);
begin
  FDetailsSiteHeight := Value;
  IsDetailsSiteHeightAssigned := True;
end;

procedure TcxGridMasterTableViewInfoCacheItem.SetDetailsSiteNormalHeight(Value: Integer);
begin
  FDetailsSiteNormalHeight := Value;
  IsDetailsSiteNormalHeightAssigned := True;
end;

procedure TcxGridMasterTableViewInfoCacheItem.SetDetailsSiteWidth(Value: Integer);
begin
  FDetailsSiteWidth := Value;
  IsDetailsSiteWidthAssigned := True;
end;

procedure TcxGridMasterTableViewInfoCacheItem.UnassignValues(AKeepMaster: Boolean);
begin
  if FUnassigningValues then Exit;
  FUnassigningValues := True;
  try
    inherited;
    IsDetailsSiteFullyVisibleAssigned := False;
    IsDetailsSiteHeightAssigned := False;
    IsDetailsSiteNormalHeightAssigned := False;
    IsDetailsSiteWidthAssigned := False;
    if GridRecord.InternalActiveDetailGridViewExists and
      (GridRecord.InternalActiveDetailGridView.ViewInfoCache <> nil) then
      GridRecord.InternalActiveDetailGridView.ViewInfoCache.UnassignValues(AKeepMaster);
  finally
    FUnassigningValues := False;
  end;
end;

{ TcxGridColumnOptions }

constructor TcxGridColumnOptions.Create(AItem: TcxCustomGridTableItem);
begin
  inherited;
  FGroupFooters := True;
  FHorzSizing := True;
end;

function TcxGridColumnOptions.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

procedure TcxGridColumnOptions.SetCellMerging(Value: Boolean);
begin
  if FCellMerging <> Value then
  begin
    FCellMerging := Value;
    Changed;
  end;
end;

procedure TcxGridColumnOptions.SetGroupFooters(Value: Boolean);
begin
  if FGroupFooters <> Value then
  begin
    FGroupFooters := Value;
    Changed(ticSize);
  end;
end;

procedure TcxGridColumnOptions.SetHorzSizing(Value: Boolean);
begin
  if FHorzSizing <> Value then
  begin
    FHorzSizing := Value;
    Changed;
  end;
end;

procedure TcxGridColumnOptions.Assign(Source: TPersistent);
begin
  if Source is TcxGridColumnOptions then
    with TcxGridColumnOptions(Source) do
    begin
      Self.CellMerging := CellMerging;
      Self.GroupFooters := GroupFooters;
      Self.HorzSizing := HorzSizing;
    end;
  inherited;
end;

{ TcxGridRowFooterCellPos }

type
  TcxGridRowFooterCellPos = class
  public
    Column: TcxGridColumn;
    FooterGroupLevel: Integer;
    Row: TcxCustomGridRow;
    SummaryItem: TcxDataSummaryItem;
    constructor Create(ARow: TcxCustomGridRow; AColumn: TcxGridColumn;
      AFooterGroupLevel: Integer; ASummaryItem: TcxDataSummaryItem);
  end;

constructor TcxGridRowFooterCellPos.Create(ARow: TcxCustomGridRow; AColumn: TcxGridColumn;
  AFooterGroupLevel: Integer; ASummaryItem: TcxDataSummaryItem);
begin
  inherited Create;
  Row := ARow;
  Column := AColumn;
  FooterGroupLevel := AFooterGroupLevel;
  SummaryItem := ASummaryItem;
end;

{ TcxGridGroupSummaryInfo }

type
  TcxGridGroupSummaryInfo = class
  public
    Row: TcxGridGroupRow;
    SummaryItem: TcxDataSummaryItem;
    constructor Create(ARow: TcxGridGroupRow; ASummaryItem: TcxDataSummaryItem);
  end;

constructor TcxGridGroupSummaryInfo.Create(ARow: TcxGridGroupRow; ASummaryItem: TcxDataSummaryItem);
begin
  inherited Create;
  Row := ARow;
  SummaryItem := ASummaryItem;
end;

{ TcxGridColumnStyles }

function TcxGridColumnStyles.GetGridViewValue: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

function TcxGridColumnStyles.GetItem: TcxGridColumn;
begin
  Result := TcxGridColumn(inherited Item);
end;

procedure TcxGridColumnStyles.SetOnGetFooterStyle(Value: TcxGridGetCellStyleEvent);
begin
  if @FOnGetFooterStyle <> @Value then
  begin
    FOnGetFooterStyle := Value;
    Item.Changed(ticProperty);
  end;
end;

procedure TcxGridColumnStyles.SetOnGetFooterStyleEx(Value: TcxGridGetFooterStyleExEvent);
begin
  if @FOnGetFooterStyleEx <> @Value then
  begin
    FOnGetFooterStyleEx := Value;
    Item.Changed(ticProperty);
  end;
end;

procedure TcxGridColumnStyles.SetOnGetFooterSummaryStyle(Value: TcxGridGetFooterSummaryStyleEvent);
begin
  if @FOnGetFooterSummaryStyle <> @Value then
  begin
    FOnGetFooterSummaryStyle := Value;
    Item.Changed(ticProperty);
  end;
end;

procedure TcxGridColumnStyles.SetOnGetGroupSummaryStyle(Value: TcxGridGetGroupSummaryStyleEvent);
begin
  if @FOnGetGroupSummaryStyle <> @Value then
  begin
    FOnGetGroupSummaryStyle := Value;
    Item.Changed(ticProperty);
  end;
end;

procedure TcxGridColumnStyles.SetOnGetHeaderStyle(Value: TcxGridGetHeaderStyleEvent);
begin
  if @FOnGetHeaderStyle <> @Value then
  begin
    FOnGetHeaderStyle := Value;
    Item.Changed(ticProperty);
  end;
end;

procedure TcxGridColumnStyles.GetDefaultViewParams(Index: Integer; AData: TObject;
  out AParams: TcxViewParams);
begin
  case Index of
    isFooter:
      GridView.Styles.GetFooterParams(TcxGridRowFooterCellPos(AData).Row, Item,
        TcxGridRowFooterCellPos(AData).FooterGroupLevel,
        TcxGridRowFooterCellPos(AData).SummaryItem, AParams);
    isGroupSummary:
      GridView.Styles.GetGroupSummaryParams(TcxGridGroupSummaryInfo(AData).Row,
        TcxGridGroupSummaryInfo(AData).SummaryItem, AParams);
    isHeader:
      GridView.Styles.GetHeaderParams(Item, AParams);
  else
    inherited;
  end;
end;

procedure TcxGridColumnStyles.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TcxGridColumnStyles then
    with TcxGridColumnStyles(Source) do
    begin
      Self.Footer := Footer;
      Self.GroupSummary := GroupSummary;
      Self.Header := Header;
      Self.OnGetFooterStyle := OnGetFooterStyle;
      Self.OnGetFooterStyleEx := OnGetFooterStyleEx;
      Self.OnGetFooterSummaryStyle := OnGetFooterSummaryStyle;
      Self.OnGetGroupSummaryStyle := OnGetGroupSummaryStyle;
      Self.OnGetHeaderStyle := OnGetHeaderStyle;
    end;
end;

procedure TcxGridColumnStyles.GetFooterParams(ARow: TcxCustomGridRow;
  AFooterGroupLevel: Integer; ASummaryItem: TcxDataSummaryItem; out AParams: TcxViewParams);
var
  AStyle: TcxStyle;
  ARowFooterCellPos: TcxGridRowFooterCellPos;
begin
  AStyle := nil;
  if Assigned(FOnGetFooterStyle) then
    FOnGetFooterStyle(GridView, ARow, Item, AStyle);
  if Assigned(FOnGetFooterStyleEx) then
    FOnGetFooterStyleEx(GridView, ARow, Item, AFooterGroupLevel, AStyle);
  if Assigned(FOnGetFooterSummaryStyle) and (ASummaryItem <> nil) then
    FOnGetFooterSummaryStyle(GridView, ARow, Item, AFooterGroupLevel, ASummaryItem, AStyle);
  ARowFooterCellPos := TcxGridRowFooterCellPos.Create(ARow, Item, AFooterGroupLevel, ASummaryItem);
  try
    GetViewParams(isFooter, ARowFooterCellPos, AStyle, AParams);
  finally
    ARowFooterCellPos.Free;
  end;
end;

procedure TcxGridColumnStyles.GetGroupSummaryParams(ARow: TcxGridGroupRow;
  ASummaryItem: TcxDataSummaryItem; out AParams: TcxViewParams);
var
  AStyle: TcxStyle;
  ASummaryInfo: TcxGridGroupSummaryInfo;
begin
  AStyle := nil;
  if (ARow <> nil) and Assigned(FOnGetGroupSummaryStyle) then
    FOnGetGroupSummaryStyle(GridView, ARow, Item, ASummaryItem, AStyle);
  ASummaryInfo := TcxGridGroupSummaryInfo.Create(ARow, ASummaryItem);
  try
    GetViewParams(isGroupSummary, ASummaryInfo, AStyle, AParams);
  finally
    ASummaryInfo.Free;
  end;
end;

procedure TcxGridColumnStyles.GetHeaderParams(out AParams: TcxViewParams);
var
  AStyle: TcxStyle;
begin
  AStyle := nil;
  if Assigned(FOnGetHeaderStyle) then
    FOnGetHeaderStyle(GridView, Item, AStyle);
  GetViewParams(isHeader, nil, AStyle, AParams);
end;

{ TcxGridColumnSummary }

function TcxGridColumnSummary.GetDataController: TcxCustomDataController;
begin
  Result := TcxGridTableView(GridView).FDataController;
end;

function TcxGridColumnSummary.GetFormat(Index: Integer): string;
begin
  Result := GetSummaryItems(TcxGridSummariesIndex(Index)).GetDataItemFormat(
    Item.Index, GetSummaryItemsPosition(TcxGridSummariesIndex(Index)));
end;

function TcxGridColumnSummary.GetKind(Index: Integer): TcxSummaryKind;
begin
  Result := GetSummaryItems(TcxGridSummariesIndex(Index)).GetDataItemKind(
    Item.Index, GetSummaryItemsPosition(TcxGridSummariesIndex(Index)));
end;

function TcxGridColumnSummary.GetSortByGroupFooterSummary: Boolean;
begin
  Result := GetSummaryItems(siGroup).GetDataItemSorted(Item.Index, spFooter);
end;

function TcxGridColumnSummary.GetSortByGroupSummary: Boolean;
begin
  Result := GetSummaryItems(siGroup).GetDataItemSorted(Item.Index, spGroup);
end;

procedure TcxGridColumnSummary.SetFormat(Index: Integer; const Value: string);
begin
  GetSummaryItems(TcxGridSummariesIndex(Index)).SetDataItemFormat(
    Item.Index, GetSummaryItemsPosition(TcxGridSummariesIndex(Index)), Value);
end;

procedure TcxGridColumnSummary.SetKind(Index: Integer; Value: TcxSummaryKind);
begin
  GetSummaryItems(TcxGridSummariesIndex(Index)).SetDataItemKind(
    Item.Index, GetSummaryItemsPosition(TcxGridSummariesIndex(Index)), Value);
end;

procedure TcxGridColumnSummary.SetSortByGroupFooterSummary(Value: Boolean);
begin
  GetSummaryItems(siGroup).SetDataItemSorted(Item.Index, spFooter, Value);
end;

procedure TcxGridColumnSummary.SetSortByGroupSummary(Value: Boolean);
begin
  GetSummaryItems(siGroup).SetDataItemSorted(Item.Index, spGroup, Value);
end;

function TcxGridColumnSummary.GetSummaryItems(AIndex: TcxGridSummariesIndex): TcxDataSummaryItems;
begin
  with DataController.Summary do
    if AIndex = siFooter then
      Result := FooterSummaryItems
    else
      Result := DefaultGroupSummaryItems;
end;

function TcxGridColumnSummary.GetSummaryItemsPosition(AIndex: TcxGridSummariesIndex): TcxSummaryPosition;
begin
  if AIndex = siGroup then
    Result := spGroup
  else
    Result := spFooter;
end;

procedure TcxGridColumnSummary.Assign(Source: TPersistent);
begin
  if Source is TcxGridColumnSummary then
    with TcxGridColumnSummary(Source) do
    begin
      Self.FooterFormat := FooterFormat;
      Self.FooterKind := FooterKind;
      Self.GroupFooterFormat := GroupFooterFormat;
      Self.GroupFooterKind := GroupFooterKind;
      Self.GroupFormat := GroupFormat;
      Self.GroupKind := GroupKind;
      Self.SortByGroupFooterSummary := SortByGroupFooterSummary;
      Self.SortByGroupSummary := SortByGroupSummary;
    end;
  inherited;
end;

{ TcxGridColumn }

constructor TcxGridColumn.Create(AOwner: TComponent);
begin
  inherited;
  FHeaderGlyphAlignmentVert := vaCenter;
end;

destructor TcxGridColumn.Destroy;
begin
  Selected := False;
  IsPreview := False;
  inherited;
end;

function TcxGridColumn.GetController: TcxGridTableController;
begin
  Result := TcxGridTableController(inherited Controller);
end;

function TcxGridColumn.GetFooterAlignmentHorz: TAlignment;
begin
  if FIsFooterAlignmentHorzAssigned then
    Result := FFooterAlignmentHorz
  else
    Result := GetDefaultValuesProvider.DefaultAlignment;
end;

function TcxGridColumn.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

function TcxGridColumn.GetGroupSummaryAlignment: TAlignment;
begin
  if FIsGroupSummaryAlignmentAssigned then
    Result := FGroupSummaryAlignment
  else
    Result := GetDefaultValuesProvider.DefaultAlignment;
end;

function TcxGridColumn.GetIsPreview: Boolean;
begin
  Result := GridView.Preview.Column = Self;
end;

function TcxGridColumn.GetOptions: TcxGridColumnOptions;
begin
  Result := TcxGridColumnOptions(inherited Options);
end;

function TcxGridColumn.GetStyles: TcxGridColumnStyles;
begin
  Result := TcxGridColumnStyles(inherited Styles);
end;

function TcxGridColumn.GetViewData: TcxGridViewData;
begin
  Result := TcxGridViewData(inherited ViewData);
end;

procedure TcxGridColumn.SetFooterAlignmentHorz(Value: TAlignment);
begin
  if (FooterAlignmentHorz <> Value) or IsLoading then
  begin
    FFooterAlignmentHorz := Value;
    FIsFooterAlignmentHorzAssigned := True;
    Changed(ticLayout);
  end;
end;

procedure TcxGridColumn.SetGroupSummaryAlignment(Value: TAlignment);
begin
  if (GroupSummaryAlignment <> Value) or IsLoading then
  begin
    FGroupSummaryAlignment := Value;
    FIsGroupSummaryAlignmentAssigned := True;
    Changed(ticLayout);
  end;
end;

procedure TcxGridColumn.SetHeaderGlyph(Value: TBitmap);
begin
  FHeaderGlyph.Assign(Value);
end;

procedure TcxGridColumn.SetHeaderGlyphAlignmentHorz(Value: TAlignment);
begin
  if FHeaderGlyphAlignmentHorz <> Value then
  begin
    FHeaderGlyphAlignmentHorz := Value;
    Changed(ticLayout);
  end;
end;

procedure TcxGridColumn.SetHeaderGlyphAlignmentVert(Value: TcxAlignmentVert);
begin
  if FHeaderGlyphAlignmentVert <> Value then
  begin
    FHeaderGlyphAlignmentVert := Value;
    Changed(ticLayout);
  end;
end;

procedure TcxGridColumn.SetIsPreview(Value: Boolean);
begin
  if IsPreview <> Value then
    if Value then
      GridView.Preview.Column := Self
    else
      GridView.Preview.Column := nil;
end;

procedure TcxGridColumn.SetOnCompareRowValuesForCellMerging(Value: TcxGridColumnCompareRowValuesEvent);
begin
  if @FOnCompareRowValuesForCellMerging <> @Value then
  begin
    FOnCompareRowValuesForCellMerging := Value;
    Changed(ticProperty);
  end;
end;

procedure TcxGridColumn.SetOnCompareValuesForCellMerging(Value: TcxGridColumnCompareValuesEvent);
begin
  if @FOnCompareValuesForCellMerging <> @Value then
  begin
    FOnCompareValuesForCellMerging := Value;
    Changed(ticProperty);
  end;
end;

procedure TcxGridColumn.SetOnCustomDrawFooterCell(Value: TcxGridColumnCustomDrawHeaderEvent);
begin
  if @FOnCustomDrawFooterCell <> @Value then
  begin
    FOnCustomDrawFooterCell := Value;
    Changed(ticProperty);
  end;
end;

procedure TcxGridColumn.SetOnCustomDrawGroupSummaryCell(Value: TcxGridGroupSummaryCellCustomDrawEvent);
begin
  if @FOnCustomDrawGroupSummaryCell <> @Value then
  begin
    FOnCustomDrawGroupSummaryCell := Value;
    Changed(ticProperty);
  end;
end;

procedure TcxGridColumn.SetOnCustomDrawHeader(Value: TcxGridColumnCustomDrawHeaderEvent);
begin
  if @FOnCustomDrawHeader <> @Value then
  begin
    FOnCustomDrawHeader := Value;
    Changed(ticProperty);
  end;
end;

procedure TcxGridColumn.SetOnHeaderClick(Value: TNotifyEvent);
begin
  if @FOnHeaderClick <> @Value then
  begin
    FOnHeaderClick := Value;
    Changed(ticProperty);
  end;
end;

procedure TcxGridColumn.SetOptions(Value: TcxGridColumnOptions);
begin
  inherited Options := Value;
end;

procedure TcxGridColumn.SetSelected(Value: Boolean);
begin
  if FSelected <> Value then
    if Value then
      Controller.AddSelectedColumn(Self)
    else
      Controller.RemoveSelectedColumn(Self);
end;

procedure TcxGridColumn.SetStyles(Value: TcxGridColumnStyles);
begin
  inherited Styles := Value;
end;

procedure TcxGridColumn.SetSummary(Value: TcxGridColumnSummary);
begin
  FSummary.Assign(Value);
end;

function TcxGridColumn.IsFooterAlignmentHorzStored: Boolean;
begin
  Result := FIsFooterAlignmentHorzAssigned and
    (FFooterAlignmentHorz <> GetDefaultValuesProvider.DefaultAlignment);
end;

function TcxGridColumn.IsGroupSummaryAlignmentStored: Boolean;
begin
  Result := FIsGroupSummaryAlignmentAssigned and
    (FGroupSummaryAlignment <> GetDefaultValuesProvider.DefaultAlignment);
end;

procedure TcxGridColumn.HeaderGlyphChanged(Sender: TObject);
begin
  Changed(ticLayout);
end;

function TcxGridColumn.GetStoredProperties(AProperties: TStrings): Boolean;
begin
  with AProperties do
  begin
    Add('GroupIndex');
    Add('Width');
  end;
  Result := inherited GetStoredProperties(AProperties);
end;

procedure TcxGridColumn.GetPropertyValue(const AName: string; var AValue: Variant);
begin
  if AName = 'Width' then
    AValue := Width
  else
    if AName = 'GroupIndex' then
      AValue := GroupIndex
    else
      inherited;
end;

procedure TcxGridColumn.SetPropertyValue(const AName: string; const AValue: Variant);
begin
  if AName = 'Width' then
    Width := AValue
  else
    if AName = 'GroupIndex' then
      GroupIndex := AValue
    else
      inherited;
end;

procedure TcxGridColumn.CreateSubClasses;
begin
  inherited;
  FHeaderGlyph := TBitmap.Create;
  FHeaderGlyph.OnChange := HeaderGlyphChanged;
  FSummary := GetSummaryClass.Create(Self);
end;

procedure TcxGridColumn.DestroySubClasses;
begin
  FreeAndNil(FSummary);
  FreeAndNil(FHeaderGlyph);
  inherited;
end;

function TcxGridColumn.GetOptionsClass: TcxCustomGridTableItemOptionsClass;
begin
  Result := TcxGridColumnOptions;
end;

function TcxGridColumn.GetStylesClass: TcxCustomGridTableItemStylesClass;
begin
  Result := TcxGridColumnStyles;
end;

function TcxGridColumn.GetSummaryClass: TcxGridColumnSummaryClass;
begin
  Result := TcxGridColumnSummary;
end;

procedure TcxGridColumn.AssignColumnWidths;
begin
  with GridView do
    if OptionsView.ColumnAutoWidth then
      ViewInfo.HeaderViewInfo.AssignColumnWidths;
end;

procedure TcxGridColumn.BestFitApplied(AFireEvents: Boolean);
begin
  inherited;
  if AFireEvents then
    GridView.DoColumnSizeChanged(Self);
end;

function TcxGridColumn.CalculateBestFitWidth: Integer;
var
  ABorders: TcxBorders;
begin
  Result := inherited CalculateBestFitWidth;
  ABorders := GridView.ViewInfo.GetCellBorders(IsMostRight, False);
  Inc(Result, (Ord(bLeft in ABorders) + Ord(bRight in ABorders)) * GridView.ViewInfo.GridLineWidth);
  if (VisibleIndex <> -1) and GridView.Visible then
  begin
    if GridView.OptionsView.Header then
      Result := Max(Result, GridView.ViewInfo.HeaderViewInfo[VisibleIndex].GetBestFitWidth);
    if GridView.OptionsView.Footer then
      Result := Max(Result, GridView.ViewInfo.FooterViewInfo.GetCellBestFitWidth(Self));
    Result := Max(Result, GridView.ViewInfo.RecordsViewInfo.GetFooterCellBestFitWidth(Self));
  end;
end;

function TcxGridColumn.CanCellMerging: Boolean;
begin
  Result := Options.CellMerging and GridView.CanCellMerging;
end;

function TcxGridColumn.CanEdit: Boolean;
begin
  if Controller.IsFilterRowFocused then
    Result := CanFocus(Controller.FocusedRecord) and (FocusedCellViewInfo <> nil)
  else
    Result := inherited CanEdit and not CanCellMerging;
end;

function TcxGridColumn.CanFocus(ARecord: TcxCustomGridRecord): Boolean;
begin
  if ViewData.HasFilterRow and (ARecord = ViewData.FilterRow) then
    Result := ActuallyVisible and CanFilter(False)
  else
    Result := inherited CanFocus(ARecord);
end;

function TcxGridColumn.CanHorzSize: Boolean;
begin
  Result := inherited CanHorzSize and GridView.OptionsCustomize.ColumnHorzSizing;
end;

function TcxGridColumn.CanShowGroupFooters: Boolean;
begin
  Result := Options.GroupFooters;
end;

procedure TcxGridColumn.ForceWidth(Value: Integer);
begin
  AssignColumnWidths;
  inherited;
  AssignColumnWidths;
  Changed(ticSize);
end;

function TcxGridColumn.GetEditValue: Variant;
begin
  if Controller.IsFilterRowFocused then
  begin
    Result := ViewData.FilterRow.Values[Index];
    if (GridView.FilterRow.ApplyChanges = fracImmediately) and
      SupportsBeginsWithFilterOperator(ViewData.FilterRow) then
      Controller.RemoveBeginsWithMask(Result);
  end
  else
    Result := inherited GetEditValue;
end;

procedure TcxGridColumn.SetEditValue(const Value: Variant);
var
  AValue: Variant;
begin
  if Controller.IsFilterRowFocused then
  begin
    AValue := Value;
    if (GridView.FilterRow.ApplyChanges = fracImmediately) and
      SupportsBeginsWithFilterOperator(ViewData.FilterRow) then
      Controller.AddBeginsWithMask(AValue);
    ViewData.FilterRow.Values[Index] := AValue;
    if not Controller.EditingController.ApplyingImmediateFiltering then
      GridView.Filtering.AddFilterToMRUItems;
  end
  else
    inherited SetEditValue(Value);
end;

function TcxGridColumn.GetFixed: Boolean;
begin
  Result := inherited GetFixed or
    (Controller.ForcingWidthItem <> nil) and
    Controller.IsColumnFixedDuringHorzSizing(Self);
end;

function TcxGridColumn.GetIsBottom: Boolean;
begin
  Result := True;
end;

function TcxGridColumn.GetIsLeft: Boolean;
begin
  Result := IsFirst;
end;

function TcxGridColumn.GetIsMostBottom: Boolean;
begin
  Result := IsBottom;
end;

function TcxGridColumn.GetIsMostLeft: Boolean;
begin
  Result := IsLeft;
end;

function TcxGridColumn.GetIsMostRight: Boolean;
begin
  Result := IsRight;
end;

function TcxGridColumn.GetIsRight: Boolean;
begin
  Result := IsLast;
end;

function TcxGridColumn.GetIsTop: Boolean;
begin
  Result := True;
end;

function TcxGridColumn.GetVisible: Boolean;
begin
  Result := inherited GetVisible and not IsPreview;
end;

function TcxGridColumn.GetVisibleForCustomization: Boolean;
begin
  Result := inherited GetVisibleForCustomization and not IsPreview;
end;

function TcxGridColumn.HasFixedWidth: Boolean;
begin
  Result := not Options.HorzSizing;
end;

function TcxGridColumn.HideOnGrouping: Boolean;
begin
  Result := GridView.OptionsCustomize.ColumnHidingOnGrouping;
end;

function TcxGridColumn.IsVisibleStored: Boolean;
begin
  Result := inherited IsVisibleStored and not IsPreview;
end;

function TcxGridColumn.IsVisibleForCustomizationStored: Boolean;
begin
  Result := inherited IsVisibleForCustomizationStored and not IsPreview;
end;

function TcxGridColumn.SupportsBeginsWithFilterOperator(ARow: TcxCustomGridRow): Boolean;
var
  AProperties: TcxCustomEditProperties;
  AFilterHelper: TcxCustomFilterEditHelperClass;
begin
  if ARow = nil then
    AProperties := GetProperties
  else
    AProperties := GetProperties(ARow);
  AFilterHelper := FilterEditsController.FindHelper(AProperties.ClassType);
  Result := (AFilterHelper <> nil) and
    (fcoLike in AFilterHelper.GetSupportedFilterOperators(AProperties, DataBinding.ValueTypeClass));
end;

{procedure TcxGridColumn.VisibleChanged;
begin
  //FGridView.RefreshVisibleColumnsList;
  //FGridView.RefreshCustomizationForm;
end;}

function TcxGridColumn.GetHeaderViewInfoClass: TcxGridColumnHeaderViewInfoClass;
begin
  Result := TcxGridColumnHeaderViewInfo;
end;

procedure TcxGridColumn.DoCustomDrawFooterCell(ACanvas: TcxCanvas;
  AViewInfo: TcxGridColumnHeaderViewInfo; var ADone: Boolean);
begin
  if HasCustomDrawFooterCell then
    FOnCustomDrawFooterCell(GridView, ACanvas, AViewInfo, ADone);
end;

procedure TcxGridColumn.DoCustomDrawGroupSummaryCell(ACanvas: TcxCanvas;
  AViewInfo: TcxCustomGridViewCellViewInfo; var ADone: Boolean);
var
  ACell: TcxGridGroupSummaryCellViewInfo;
begin
  if HasCustomDrawGroupSummaryCell then
  begin
    ACell := TcxGridGroupSummaryCellViewInfo(AViewInfo);
    FOnCustomDrawGroupSummaryCell(Self, ACanvas, ACell.RowViewInfo.GridRecord,
      Self, ACell.SummaryItem, AViewInfo, ADone);
  end;
end;

procedure TcxGridColumn.DoCustomDrawHeader(ACanvas: TcxCanvas;
  AViewInfo: TcxGridColumnHeaderViewInfo; var ADone: Boolean);
begin
  if HasCustomDrawHeader then
    FOnCustomDrawHeader(GridView, ACanvas, AViewInfo, ADone);
end;

procedure TcxGridColumn.DoHeaderClick;
begin
  if Assigned(FOnHeaderClick) then FOnHeaderClick(Self);
  GridView.DoColumnHeaderClick(Self);
end;

function TcxGridColumn.HasCustomDrawFooterCell: Boolean;
begin
  Result := Assigned(FOnCustomDrawFooterCell);
end;

function TcxGridColumn.HasCustomDrawGroupSummaryCell: Boolean;
begin
  Result := Assigned(FOnCustomDrawGroupSummaryCell);
end;

function TcxGridColumn.HasCustomDrawHeader: Boolean;
begin
  Result := Assigned(FOnCustomDrawHeader);
end;

procedure TcxGridColumn.Assign(Source: TPersistent);
begin
  if Source is TcxGridColumn then
    with TcxGridColumn(Source) do
    begin
      Self.FooterAlignmentHorz := FooterAlignmentHorz;
      Self.GroupSummaryAlignment := GroupSummaryAlignment;
      Self.HeaderGlyph := HeaderGlyph;
      Self.HeaderGlyphAlignmentHorz := HeaderGlyphAlignmentHorz;
      Self.HeaderGlyphAlignmentVert := HeaderGlyphAlignmentVert;
      Self.Summary := Summary;
      Self.OnCompareRowValuesForCellMerging := OnCompareRowValuesForCellMerging;
      Self.OnCompareValuesForCellMerging := OnCompareValuesForCellMerging;
      Self.OnCustomDrawFooterCell := OnCustomDrawFooterCell;
      Self.OnCustomDrawGroupSummaryCell := OnCustomDrawGroupSummaryCell;
      Self.OnCustomDrawHeader := OnCustomDrawHeader;
      Self.OnHeaderClick := OnHeaderClick;
    end;
  inherited;
end;

function TcxGridColumn.DoCompareValuesForCellMerging(
  ARow1: TcxGridDataRow; AProperties1: TcxCustomEditProperties; const AValue1: TcxEditValue;
  ARow2: TcxGridDataRow; AProperties2: TcxCustomEditProperties; const AValue2: TcxEditValue): Boolean;
begin
  Result := (AProperties1 = AProperties2) and AProperties1.CompareDisplayValues(AValue1, AValue2);
  if Assigned(FOnCompareValuesForCellMerging) then
    FOnCompareValuesForCellMerging(Self, AProperties1, AValue1, AProperties2, AValue2, Result);
  if Assigned(FOnCompareRowValuesForCellMerging) then
    FOnCompareRowValuesForCellMerging(Self, ARow1, AProperties1, AValue1,
      ARow2, AProperties2, AValue2, Result);
end;

procedure TcxGridColumn.FocusWithSelection;
begin
  if not Focused then
  begin
    GridView.BeginUpdate;
    try
      Controller.ClearCellSelection;
      Selected := True;
      Controller.CellSelectionAnchor := Self;
    finally
      GridView.EndUpdate;
    end;
  end;
  inherited;
end;

function TcxGridColumn.GroupBy(AGroupIndex: Integer; ACanShow: Boolean = True): Boolean;
begin
  Result := CanGroup;
  if not Result then Exit;
  GroupIndex := AGroupIndex;
  if AGroupIndex = -1 then
    if ACanShow and ShowOnUngrouping and WasVisibleBeforeGrouping then
      Visible := True
    else
  else
    if HideOnGrouping and CanHide then
      Visible := False;
end;

{ TcxGridTableBackgroundBitmaps }

function TcxGridTableBackgroundBitmaps.GetBitmapStyleIndex(Index: Integer): Integer;
begin
  case Index of
    bbFooter:
      Result := vsFooter;
    bbHeader:
      Result := vsHeader;
    bbGroup:
      Result := vsGroup;
    bbGroupByBox:
      Result := vsGroupByBox;
    bbIndicator:
      Result := vsIndicator;
    bbPreview:
      Result := vsPreview;
  else
    Result := inherited GetBitmapStyleIndex(Index);
  end;
end;

procedure TcxGridTableBackgroundBitmaps.Assign(Source: TPersistent);
begin
  if Source is TcxGridTableBackgroundBitmaps then
    with TcxGridTableBackgroundBitmaps(Source) do
    begin
      Self.Footer := Footer;
      Self.Header := Header;
      Self.Group := Group;
      Self.GroupByBox := GroupByBox;
      Self.Indicator := Indicator;
      Self.Preview := Preview;
    end;
  inherited;
end;

{ TcxGridTableOptionsBehavior }

constructor TcxGridTableOptionsBehavior.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FColumnHeaderHints := True;
  FCopyPreviewToClipboard := True;
  FExpandMasterRowOnDblClick := True;
end;

procedure TcxGridTableOptionsBehavior.SetColumnHeaderHints(Value: Boolean);
begin
  if FColumnHeaderHints <> Value then
  begin
    FColumnHeaderHints := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxGridTableOptionsBehavior.SetCopyPreviewToClipboard(Value: Boolean);
begin
  if FCopyPreviewToClipboard <> Value then
  begin
    FCopyPreviewToClipboard := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxGridTableOptionsBehavior.SetExpandMasterRowOnDblClick(Value: Boolean);
begin
  if FExpandMasterRowOnDblClick <> Value then
  begin
    FExpandMasterRowOnDblClick := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxGridTableOptionsBehavior.Assign(Source: TPersistent);
begin
  if Source is TcxGridTableOptionsBehavior then
    with TcxGridTableOptionsBehavior(Source) do
    begin
      Self.ColumnHeaderHints := ColumnHeaderHints;
      Self.CopyPreviewToClipboard := CopyPreviewToClipboard;
      Self.ExpandMasterRowOnDblClick := ExpandMasterRowOnDblClick;
    end;
  inherited;
end;

{ TcxGridTableFiltering }

function TcxGridTableFiltering.GetColumnFilteredItemsList: Boolean;
begin
  Result := ItemFilteredItemsList;
end;

function TcxGridTableFiltering.GetColumnMRUItemsList: Boolean;
begin
  Result := ItemMRUItemsList;
end;

function TcxGridTableFiltering.GetColumnMRUItemsListCount: Integer;
begin
  Result := ItemMRUItemsListCount;
end;

function TcxGridTableFiltering.GetColumnPopup: TcxGridItemFilterPopupOptions;
begin
  Result := ItemPopup;
end;

procedure TcxGridTableFiltering.SetColumnFilteredItemsList(Value: Boolean);
begin
  ItemFilteredItemsList := Value;
end;

procedure TcxGridTableFiltering.SetColumnMRUItemsList(Value: Boolean);
begin
  ItemMRUItemsList := Value;
end;

procedure TcxGridTableFiltering.SetColumnMRUItemsListCount(Value: Integer);
begin
  ItemMRUItemsListCount := Value;
end;

procedure TcxGridTableFiltering.SetColumnPopup(Value: TcxGridItemFilterPopupOptions);
begin
  ItemPopup := Value;
end;

procedure TcxGridTableFiltering.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('ColumnPopupDropDownWidth', ReadItemPopupDropDownWidth, nil, True);
  Filer.DefineProperty('ColumnPopupMaxDropDownItemCount', ReadItemPopupMaxDropDownCount, nil, True);
end;

{ TcxGridTableOptionsCustomize }

constructor TcxGridTableOptionsCustomize.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FColumnHidingOnGrouping := True;
  FColumnHorzSizing := True;
end;

function TcxGridTableOptionsCustomize.GetColumnFiltering: Boolean;
begin
  Result := ItemFiltering;
end;

function TcxGridTableOptionsCustomize.GetColumnGrouping: Boolean;
begin
  Result := ItemGrouping;
end;

function TcxGridTableOptionsCustomize.GetColumnHiding: Boolean;
begin
  Result := ItemHiding;
end;

function TcxGridTableOptionsCustomize.GetColumnMoving: Boolean;
begin
  Result := ItemMoving;
end;

function TcxGridTableOptionsCustomize.GetColumnSorting: Boolean;
begin
  Result := ItemSorting;
end;

function TcxGridTableOptionsCustomize.GetColumnsQuickCustomization: Boolean;
begin
  Result := ItemsQuickCustomization;
end;

function TcxGridTableOptionsCustomize.GetColumnsQuickCustomizationMaxDropDownCount: Integer;
begin
  Result := ItemsQuickCustomizationMaxDropDownCount;
end;

function TcxGridTableOptionsCustomize.GetColumnsQuickCustomizationReordering: TcxGridQuickCustomizationReordering;
begin
  Result := ItemsQuickCustomizationReordering;
end;

function TcxGridTableOptionsCustomize.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

procedure TcxGridTableOptionsCustomize.SetColumnFiltering(Value: Boolean);
begin
  ItemFiltering := Value;
end;

procedure TcxGridTableOptionsCustomize.SetColumnGrouping(Value: Boolean);
begin
  ItemGrouping := Value;
end;

procedure TcxGridTableOptionsCustomize.SetColumnHiding(Value: Boolean);
begin
  ItemHiding := Value;
end;

procedure TcxGridTableOptionsCustomize.SetColumnHidingOnGrouping(Value: Boolean);
begin
  if FColumnHidingOnGrouping <> Value then
  begin
    FColumnHidingOnGrouping := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxGridTableOptionsCustomize.SetColumnHorzSizing(Value: Boolean);
begin
  if FColumnHorzSizing <> Value then
  begin
    FColumnHorzSizing := Value;
    Changed(vcLayout);
  end;
end;

procedure TcxGridTableOptionsCustomize.SetColumnMoving(Value: Boolean);
begin
  ItemMoving := Value;
end;

procedure TcxGridTableOptionsCustomize.SetColumnSorting(Value: Boolean);
begin
  ItemSorting := Value;
end;

procedure TcxGridTableOptionsCustomize.SetColumnsQuickCustomization(Value: Boolean);
begin
  ItemsQuickCustomization := Value;
end;

procedure TcxGridTableOptionsCustomize.SetColumnsQuickCustomizationMaxDropDownCount(Value: Integer);
begin
  ItemsQuickCustomizationMaxDropDownCount := Value;
end;

procedure TcxGridTableOptionsCustomize.SetColumnsQuickCustomizationReordering(Value: TcxGridQuickCustomizationReordering);
begin
  ItemsQuickCustomizationReordering := Value;
end;

procedure TcxGridTableOptionsCustomize.SetDataRowSizing(Value: Boolean);
begin
  if FDataRowSizing <> Value then
  begin
    FDataRowSizing := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxGridTableOptionsCustomize.SetGroupBySorting(Value: Boolean);
begin
  if FGroupBySorting <> Value then
  begin
    FGroupBySorting := Value;
    GridView.BeginUpdate;
    try
      GridView.Controller.ClearGrouping;
      GridView.FDataController.ClearSorting(False);
      Changed(vcProperty);
    finally
      GridView.EndUpdate;
    end;
  end;
end;

procedure TcxGridTableOptionsCustomize.SetGroupRowSizing(Value: Boolean);
begin
  if FGroupRowSizing <> Value then
  begin
    FGroupRowSizing := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxGridTableOptionsCustomize.Assign(Source: TPersistent);
begin
  if Source is TcxGridTableOptionsCustomize then
    with TcxGridTableOptionsCustomize(Source) do
    begin
      Self.ColumnHidingOnGrouping := ColumnHidingOnGrouping;
      Self.ColumnHorzSizing := ColumnHorzSizing;
      Self.DataRowSizing := DataRowSizing;
      Self.GroupBySorting := GroupBySorting;
      Self.GroupRowSizing := GroupRowSizing;
    end;
  inherited;
end;

{ TcxGridTableOptionsSelection }

procedure TcxGridTableOptionsSelection.SetCellMultiSelect(Value: Boolean);
begin
  if FCellMultiSelect <> Value then
  begin
    FCellMultiSelect := Value;
    if Value or not IsLoading then
    begin
      CellSelect := True;
      InvertSelect := not Value;
      MultiSelect := Value;
    end;
    Changed(vcProperty);
  end;
end;

procedure TcxGridTableOptionsSelection.SetCellSelect(Value: Boolean);
begin
  if IsLoading or not FCellMultiSelect or Value then
    inherited;
end;

procedure TcxGridTableOptionsSelection.SetInvertSelect(Value: Boolean);
begin
  if IsLoading or not FCellMultiSelect or not Value then
    inherited;
end;

procedure TcxGridTableOptionsSelection.SetMultiSelect(Value: Boolean);
begin
  if IsLoading or not FCellMultiSelect or Value then
    inherited;
end;

procedure TcxGridTableOptionsSelection.Assign(Source: TPersistent);
begin
  if Source is TcxGridTableOptionsSelection then
    with TcxGridTableOptionsSelection(Source) do
      Self.CellMultiSelect := CellMultiSelect;
  inherited;
end;

{ TcxGridSpecialRowOptions }

constructor TcxGridSpecialRowOptions.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FInfoText := DefaultInfoText;
  FSeparatorColor := clDefault;
  FSeparatorWidth := cxGridCustomRowSeparatorDefaultWidth;
end;

function TcxGridSpecialRowOptions.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

function TcxGridSpecialRowOptions.GetInfoText: string;
begin
  if FIsInfoTextAssigned then
    Result := FInfoText
  else
    Result := DefaultInfoText;
end;

procedure TcxGridSpecialRowOptions.SetInfoText(const Value: string);
begin
  if FInfoText <> Value then
  begin
    FInfoText := Value;
    FIsInfoTextAssigned := Value <> DefaultInfoText;
    Changed(vcLayout);
  end;
end;

procedure TcxGridSpecialRowOptions.SetSeparatorColor(Value: TColor);
begin
  if FSeparatorColor <> Value  then
  begin
    FSeparatorColor := Value;
    Changed(vcLayout);
  end;
end;

procedure TcxGridSpecialRowOptions.SetSeparatorWidth(Value: Integer);
begin
  if Value < cxGridCustomRowSeparatorMinWidth then
    Value := cxGridCustomRowSeparatorMinWidth;
  if FSeparatorWidth <> Value then
  begin
    FSeparatorWidth := Value;
    Changed(vcSize);
  end;
end;

procedure TcxGridSpecialRowOptions.SetVisible(Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    VisibleChanged;
  end;
end;

function TcxGridSpecialRowOptions.IsInfoTextStored: Boolean;
begin
  Result := FIsInfoTextAssigned;
end;

function TcxGridSpecialRowOptions.DefaultSeparatorColor: TColor;
begin
  Result := LookAndFeelPainter.DefaultHeaderColor;
end;

procedure TcxGridSpecialRowOptions.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TcxGridSpecialRowOptions then
    with TcxGridSpecialRowOptions(Source) do
    begin
      Self.InfoText := InfoText;
      Self.SeparatorColor := SeparatorColor;
      Self.SeparatorWidth := SeparatorWidth;
      Self.Visible := Visible;
    end;
end;

function TcxGridSpecialRowOptions.GetSeparatorColor: TColor;
begin
  Result := FSeparatorColor;
  if Result = clDefault then
    Result := DefaultSeparatorColor;
end;

{ TcxGridFilterRowOptions }

procedure TcxGridFilterRowOptions.SetApplyChanges(Value: TcxGridFilterRowApplyChangesMode);
begin
  if FApplyChanges <> Value then
  begin
    FApplyChanges := Value;
    Changed(vcProperty);
  end;
end;

function TcxGridFilterRowOptions.DefaultInfoText: string;
begin
  Result := cxGetResourceString(@scxGridFilterRowInfoText);
end;

procedure TcxGridFilterRowOptions.VisibleChanged;
begin
  GridView.ViewData.CheckFilterRow;
  Changed(vcSize);
end;

procedure TcxGridFilterRowOptions.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TcxGridFilterRowOptions then
    ApplyChanges := TcxGridFilterRowOptions(Source).ApplyChanges;
end;

{ TcxGridNewItemRowOptions }

function TcxGridNewItemRowOptions.DefaultInfoText: string;
begin
  Result := cxGetResourceString(@scxGridNewItemRowInfoText);
end;

procedure TcxGridNewItemRowOptions.VisibleChanged;
begin
  GridView.ViewData.CheckNewItemRecord;
  GridView.FDataController.UseNewItemRowForEditing := Visible;
end;

{ TcxGridTableOptionsView }

constructor TcxGridTableOptionsView.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FExpandButtonsForEmptyDetails := True;
  FGridLineColor := clDefault;
  FGroupByBox := True;
  FHeader := True;
  FIndicatorWidth := cxGridDefaultIndicatorWidth;
  FPrevGroupFooters := gfVisibleWhenExpanded;
  FRowSeparatorColor := clDefault;
end;

function TcxGridTableOptionsView.GetExpandButtonsForEmptyDetails: Boolean;
begin
  Result := FExpandButtonsForEmptyDetails and
    ((GridView.Level = nil) or TcxGridLevel(GridView.Level).Options.TabsForEmptyDetails);
end;

function TcxGridTableOptionsView.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

function TcxGridTableOptionsView.GetHeaderAutoHeight: Boolean;
begin
  Result := ItemCaptionAutoHeight;
end;

function TcxGridTableOptionsView.GetHeaderEndEllipsis: Boolean;
begin
  Result := ItemCaptionEndEllipsis;
end;

function TcxGridTableOptionsView.GetNewItemRow: Boolean;
begin
  Result := GridView.NewItemRow.Visible;
end;

function TcxGridTableOptionsView.GetNewItemRowInfoText: string;
begin
  Result := GridView.NewItemRow.InfoText;
end;

function TcxGridTableOptionsView.GetNewItemRowSeparatorColor: TColor;
begin
 Result := GridView.NewItemRow.SeparatorColor;
end;

function TcxGridTableOptionsView.GetNewItemRowSeparatorWidth: Integer;
begin
  Result := GridView.NewItemRow.SeparatorWidth;
end;

function TcxGridTableOptionsView.GetShowColumnFilterButtons: TcxGridShowItemFilterButtons;
begin
  Result := ShowItemFilterButtons;
end;

procedure TcxGridTableOptionsView.SetColumnAutoWidth(Value: Boolean);
begin
  if FColumnAutoWidth <> Value then
  begin
    FColumnAutoWidth := Value;
    Changed(vcSize);
  end;
end;

procedure TcxGridTableOptionsView.SetDataRowHeight(Value: Integer);
begin
  CheckDataRowHeight(Value);
  if FDataRowHeight <> Value then
  begin
    FDataRowHeight := Value;
    Changed(vcSize);
    GridView.Controller.DesignerModified;
  end;
end;

procedure TcxGridTableOptionsView.SetExpandButtonsForEmptyDetails(Value: Boolean);
begin
  if FExpandButtonsForEmptyDetails <> Value then
  begin
    FExpandButtonsForEmptyDetails := Value;
    Changed(vcLayout);
  end;
end;

procedure TcxGridTableOptionsView.SetFooter(Value: Boolean);
begin
  if FFooter <> Value then
  begin
    FFooter := Value;
    Changed(vcSize);
  end;
end;

procedure TcxGridTableOptionsView.SetFooterAutoHeight(Value: Boolean);
begin
  if FFooterAutoHeight <> Value then
  begin
    FFooterAutoHeight := Value;
    Changed(vcSize);
  end;
end;

procedure TcxGridTableOptionsView.SetFooterMultiSummaries(Value: Boolean);
begin
  if FFooterMultiSummaries <> Value then
  begin
    FFooterMultiSummaries := Value;
    Changed(vcSize);
  end;
end;

procedure TcxGridTableOptionsView.SetGridLineColor(Value: TColor);
begin
  if FGridLineColor <> Value then
  begin
    FGridLineColor := Value;
    Changed(vcLayout);
  end;
end;

procedure TcxGridTableOptionsView.SetGridLines(Value: TcxGridLines);
begin
  if FGridLines <> Value then
  begin
    FGridLines := Value;
    Changed(vcSize);
  end;
end;

procedure TcxGridTableOptionsView.SetGroupByBox(Value: Boolean);
begin
  if FGroupByBox <> Value then
  begin
    FGroupByBox := Value;
    Changed(vcSize);
  end;
end;

procedure TcxGridTableOptionsView.SetGroupFooterMultiSummaries(Value: Boolean);
begin
  if FGroupFooterMultiSummaries <> Value then
  begin
    FGroupFooterMultiSummaries := Value;
    Changed(vcSize);
  end;
end;

procedure TcxGridTableOptionsView.SetGroupFooters(Value: TcxGridGroupFootersMode);
begin
  if FGroupFooters <> Value then
  begin
    FPrevGroupFooters := FGroupFooters;
    FGroupFooters := Value;
    Changed(vcSize);
  end;
end;

procedure TcxGridTableOptionsView.SetGroupRowHeight(Value: Integer);
begin
  CheckGroupRowHeight(Value);
  if FGroupRowHeight <> Value then
  begin
    FGroupRowHeight := Value;
    Changed(vcSize);
    GridView.Controller.DesignerModified;
  end;
end;

procedure TcxGridTableOptionsView.SetGroupRowStyle(Value: TcxGridGroupRowStyle);
begin
  if FGroupRowStyle <> Value then
  begin
    FGroupRowStyle := Value;
    Changed(vcSize);
  end;
end;

procedure TcxGridTableOptionsView.SetGroupSummaryLayout(Value: TcxGridGroupSummaryLayout);
begin
  if FGroupSummaryLayout <> Value then
  begin
    FGroupSummaryLayout := Value;
    Changed(vcSize);
  end;
end;

procedure TcxGridTableOptionsView.SetHeader(Value: Boolean);
begin
  if FHeader <> Value then
  begin
    FHeader := Value;
    Changed(vcSize);
  end;
end;

procedure TcxGridTableOptionsView.SetHeaderAutoHeight(Value: Boolean);
begin
  ItemCaptionAutoHeight := Value;
end;

procedure TcxGridTableOptionsView.SetHeaderEndEllipsis(Value: Boolean);
begin
  ItemCaptionEndEllipsis := Value;
end;

procedure TcxGridTableOptionsView.SetHeaderHeight(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FHeaderHeight <> Value then
  begin
    FHeaderHeight := Value;
    Changed(vcSize);
  end;
end;

procedure TcxGridTableOptionsView.SetIndicator(Value: Boolean);
begin
  if FIndicator <> Value then
  begin
    FIndicator := Value;
    Changed(vcSize);
  end;
end;

procedure TcxGridTableOptionsView.SetIndicatorWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FIndicatorWidth <> Value then
  begin
    FIndicatorWidth := Value;
    Changed(vcSize);
  end;
end;

procedure TcxGridTableOptionsView.SetNewItemRow(Value: Boolean);
begin
  GridView.NewItemRow.Visible := Value;
end;

procedure TcxGridTableOptionsView.SetNewItemRowInfoText(const Value: string);
begin
  GridView.NewItemRow.InfoText := Value;
end;

procedure TcxGridTableOptionsView.SetNewItemRowSeparatorColor(Value: TColor);
begin
  GridView.NewItemRow.SeparatorColor := Value;
end;

procedure TcxGridTableOptionsView.SetNewItemRowSeparatorWidth(Value: Integer);
begin
  GridView.NewItemRow.SeparatorWidth := Value;
end;

procedure TcxGridTableOptionsView.SetRowSeparatorColor(Value: TColor);
begin
  if FRowSeparatorColor <> Value then
  begin
    FRowSeparatorColor := Value;
    Changed(vcLayout);
  end;
end;

procedure TcxGridTableOptionsView.SetRowSeparatorWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FRowSeparatorWidth <> Value then
  begin
    FRowSeparatorWidth := Value;
    Changed(vcSize);
  end;
end;

procedure TcxGridTableOptionsView.SetShowColumnFilterButtons(Value: TcxGridShowItemFilterButtons);
begin
  ShowItemFilterButtons := Value;
end;

procedure TcxGridTableOptionsView.ReadNewItemRow(Reader: TReader);
begin
  NewItemRow := Reader.ReadBoolean;
end;

procedure TcxGridTableOptionsView.ReadNewItemRowInfoText(Reader: TReader);
begin
  NewItemRowInfoText := Reader.ReadString;
end;

procedure TcxGridTableOptionsView.ReadNewItemRowSeparatorColor(Reader: TReader);
begin
  if Reader.NextValue = vaIdent then
    NewItemRowSeparatorColor := StringToColor(Reader.ReadIdent)
  else
    NewItemRowSeparatorColor := Reader.ReadInteger;
end;

procedure TcxGridTableOptionsView.ReadNewItemRowSeparatorWidth(Reader: TReader);
begin
  NewItemRowSeparatorWidth := Reader.ReadInteger;
end;

procedure TcxGridTableOptionsView.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('NewItemRow', ReadNewItemRow, nil, True);
  Filer.DefineProperty('NewItemRowInfoText', ReadNewItemRowInfoText, nil, True);
  Filer.DefineProperty('NewItemRowSeparatorColor', ReadNewItemRowSeparatorColor, nil, True);
  Filer.DefineProperty('NewItemRowSeparatorWidth', ReadNewItemRowSeparatorWidth, nil, True);
end;

procedure TcxGridTableOptionsView.ItemCaptionAutoHeightChanged;
begin
  Changed(vcLayout);
end;

procedure TcxGridTableOptionsView.Assign(Source: TPersistent);
begin
  if Source is TcxGridTableOptionsView then
    with TcxGridTableOptionsView(Source) do
    begin
      Self.ColumnAutoWidth := ColumnAutoWidth;
      Self.DataRowHeight := DataRowHeight;
      Self.ExpandButtonsForEmptyDetails := ExpandButtonsForEmptyDetails;
      Self.Footer := Footer;
      Self.FooterAutoHeight := FooterAutoHeight;
      Self.FooterMultiSummaries := FooterMultiSummaries;
      Self.GridLineColor := GridLineColor;
      Self.GridLines := GridLines;
      Self.GroupByBox := GroupByBox;
      Self.GroupFooterMultiSummaries := GroupFooterMultiSummaries;
      Self.GroupFooters := GroupFooters;
      Self.GroupRowHeight := GroupRowHeight;
      Self.GroupRowStyle := GroupRowStyle;
      Self.GroupSummaryLayout := GroupSummaryLayout;
      Self.Header := Header;
      Self.HeaderHeight := HeaderHeight;
      Self.Indicator := Indicator;
      Self.IndicatorWidth := IndicatorWidth;
      Self.FPrevGroupFooters := FPrevGroupFooters;
      Self.RowSeparatorColor := RowSeparatorColor;
      Self.RowSeparatorWidth := RowSeparatorWidth;
    end;
  inherited;
end;

function TcxGridTableOptionsView.CanShowFooterMultiSummaries: Boolean;
begin
  Result := GridView.ViewInfo.SupportsMultipleFooterSummaries and FooterMultiSummaries;
end;

function TcxGridTableOptionsView.CanShowGroupFooterMultiSummaries: Boolean;
begin
  Result := GridView.ViewInfo.SupportsMultipleFooterSummaries and GroupFooterMultiSummaries;
end;

procedure TcxGridTableOptionsView.CheckDataRowHeight(var AValue: Integer);
var
  AMinValue: Integer;
begin
  if AValue < 0 then AValue := 0;
  if AValue > 0 then
  begin
    AMinValue := GridView.ViewInfo.RecordsViewInfo.CalculateRowDefaultHeight;
    if AValue < AMinValue then AValue := AMinValue;
  end;  
end;

procedure TcxGridTableOptionsView.CheckGroupRowHeight(var AValue: Integer);
var
  AMinValue: Integer;
begin
  if AValue < 0 then AValue := 0;
  if AValue > 0 then
  begin
    AMinValue :=
      GridView.ViewInfo.RecordsViewInfo.CalculateGroupRowDefaultHeight(True);
    if AValue < AMinValue then AValue := AMinValue;
  end;
end;

function TcxGridTableOptionsView.GetGridLineColor: TColor;
begin
  Result := FGridLineColor;
  if Result = clDefault then
    Result := LookAndFeelPainter.DefaultGridLineColor;
end;

function TcxGridTableOptionsView.GetGroupSummaryLayout: TcxGridGroupSummaryLayout;
begin
  if GridView.ViewInfo.SupportsGroupSummariesAlignedWithColumns then
    Result := FGroupSummaryLayout
  else
    Result := gslStandard;
end;

function TcxGridTableOptionsView.GetRowSeparatorColor: TColor;
begin
  Result := FRowSeparatorColor;
  if Result = clDefault then
    Result := LookAndFeelPainter.DefaultRecordSeparatorColor;
end;

{ TcxGridPreview }

constructor TcxGridPreview.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FAutoHeight := True;
  FLeftIndent := cxGridPreviewDefaultLeftIndent;
  FMaxLineCount := cxGridPreviewDefaultMaxLineCount;
  FRightIndent := cxGridPreviewDefaultRightIndent;
end;

function TcxGridPreview.GetActive: Boolean;
begin
  Result := FVisible and (FColumn <> nil);
end;

function TcxGridPreview.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

procedure TcxGridPreview.SetAutoHeight(Value: Boolean);
begin
  if FAutoHeight <> Value then
  begin
    FAutoHeight := Value;
    PropertyChanged;
  end;
end;

procedure TcxGridPreview.SetColumn(Value: TcxGridColumn);

  procedure ColumnVisibilityChanged(AColumn: TcxGridColumn);
  begin
    AColumn.VisibleChanged;
    GridView.ItemVisibilityChanged(AColumn, AColumn.ActuallyVisible);
    AColumn.VisibleForCustomizationChanged;
  end;

var
  APrevColumn: TcxGridColumn;
begin
  if (Value <> nil) and (Value.GridView <> GridView) then Value := nil;
  if FColumn <> Value then
  begin
    APrevColumn := FColumn;
    FColumn := Value;
    GridView.BeginUpdate;
    try
      if APrevColumn <> nil then
        ColumnVisibilityChanged(APrevColumn);
      if FColumn <> nil then
        ColumnVisibilityChanged(FColumn);
    finally
      GridView.EndUpdate;
    end;
  end;
end;

procedure TcxGridPreview.SetLeftIndent(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FLeftIndent <> Value then
  begin
    FLeftIndent := Value;
    PropertyChanged;
  end;
end;

procedure TcxGridPreview.SetMaxLineCount(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FMaxLineCount <> Value then
  begin
    FMaxLineCount := Value;
    PropertyChanged;
  end;
end;

procedure TcxGridPreview.SetPlace(Value: TcxGridPreviewPlace);
begin
  if FPlace <> Value then
  begin
    FPlace := Value;
    PropertyChanged;
  end;
end;

procedure TcxGridPreview.SetRightIndent(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FRightIndent <> Value then
  begin
    FRightIndent := Value;
    PropertyChanged;
  end;
end;

procedure TcxGridPreview.SetVisible(Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed(vcSize);
  end;
end;

procedure TcxGridPreview.Notification(AComponent: TComponent;
  AOperation: TOperation);
begin
  inherited;
  if (AOperation = opRemove) and (AComponent = Column) then
    Column := nil;
end;

procedure TcxGridPreview.PropertyChanged;
begin
  if FVisible then
    Changed(vcSize)
  else
    Changed(vcProperty);
end;

procedure TcxGridPreview.Assign(Source: TPersistent);
begin
  if Source is TcxGridPreview then
    with TcxGridPreview(Source) do
    begin
      Self.AutoHeight := AutoHeight;
      if not Self.GridView.AssigningSettings then
        if Column <> nil then
          Self.Column := TcxGridColumn(Self.GridView.FindItemByID(Column.ID))
        else
          Self.Column := Column;
      Self.LeftIndent := LeftIndent;
      Self.MaxLineCount := MaxLineCount;
      Self.Place := Place;
      Self.RightIndent := RightIndent;
      Self.Visible := Visible;
    end;
  inherited;
end;

{ TcxGridTableViewStyles }

function TcxGridTableViewStyles.GetGridViewValue: TcxGridTableView;
begin
  Result := TcxGridTableView(inherited GridView);
end;

procedure TcxGridTableViewStyles.SetOnGetFooterStyle(Value: TcxGridGetCellStyleEvent);
begin
  if @FOnGetFooterStyle <> @Value then
  begin
    FOnGetFooterStyle := Value;
    GridView.Changed(vcProperty);
  end;
end;

procedure TcxGridTableViewStyles.SetOnGetFooterStyleEx(Value: TcxGridGetFooterStyleExEvent);
begin
  if @FOnGetFooterStyleEx <> @Value then
  begin
    FOnGetFooterStyleEx := Value;
    GridView.Changed(vcProperty);
  end;
end;

procedure TcxGridTableViewStyles.SetOnGetFooterSummaryStyle(Value: TcxGridGetFooterSummaryStyleEvent);
begin
  if @FOnGetFooterSummaryStyle <> @Value then
  begin
    FOnGetFooterSummaryStyle := Value;
    GridView.Changed(vcProperty);
  end;
end;

procedure TcxGridTableViewStyles.SetOnGetGroupStyle(Value: TcxGridGetGroupStyleEvent);
begin
  if @FOnGetGroupStyle <> @Value then
  begin
    FOnGetGroupStyle := Value;
    GridView.Changed(vcProperty);
  end;
end;

procedure TcxGridTableViewStyles.SetOnGetGroupSummaryStyle(Value: TcxGridGetGroupSummaryStyleEvent);
begin
  if @FOnGetGroupSummaryStyle <> @Value then
  begin
    FOnGetGroupSummaryStyle := Value;
    GridView.Changed(vcProperty);
  end;
end;

procedure TcxGridTableViewStyles.SetOnGetHeaderStyle(Value: TcxGridGetHeaderStyleEvent);
begin
  if @FOnGetHeaderStyle <> @Value then
  begin
    FOnGetHeaderStyle := Value;
    GridView.Changed(vcProperty);
  end;
end;

procedure TcxGridTableViewStyles.SetOnGetPreviewStyle(Value: TcxGridGetCellStyleEvent);
begin
  if @FOnGetPreviewStyle <> @Value then
  begin
    FOnGetPreviewStyle := Value;
    GridView.Changed(vcProperty);
  end;
end;

procedure TcxGridTableViewStyles.GetDefaultViewParams(
  Index: Integer; AData: TObject; out AParams: TcxViewParams);

  procedure GetGroupDefaultViewParams;
  begin
    inherited GetContentParams(TcxCustomGridRecord(AData), nil, AParams);
    if GridView.OptionsView.GroupRowStyle = grsStandard then
    begin
      AParams.Color := LookAndFeelPainter.DefaultGroupColor;
      AParams.TextColor := LookAndFeelPainter.DefaultGroupTextColor;
    end
    else
    begin
      AParams.Color := LookAndFeelPainter.GridGroupRowStyleOffice11ContentColor(AData <> nil);
      AParams.TextColor := LookAndFeelPainter.GridGroupRowStyleOffice11TextColor;
    end;
  end;

begin
  inherited;
  with AParams, LookAndFeelPainter do
    case Index of
      vsFooter:
        begin
          Color := DefaultFooterColor;
          TextColor := DefaultFooterTextColor;
        end;
      vsGroup:
        GetGroupDefaultViewParams;
      vsGroupByBox:
        begin
          Color := DefaultGroupByBoxColor;
          TextColor := DefaultGroupByBoxTextColor;
        end;
      vsGroupFooterSortedSummary:
        if AData <> nil then
          TcxGridRowFooterCellPos(AData).Column.Styles.GetFooterParams(
            TcxGridRowFooterCellPos(AData).Row,
            TcxGridRowFooterCellPos(AData).FooterGroupLevel,
            TcxGridRowFooterCellPos(AData).SummaryItem, AParams)
        else
          GetFooterParams(nil, nil, -1, nil, AParams);
      vsGroupSortedSummary:
        if AData <> nil then
          GetGroupSummaryCellContentParams(TcxGridGroupSummaryInfo(AData).Row,
            TcxGridGroupSummaryInfo(AData).SummaryItem, AParams)
        else
          GetGroupSummaryCellContentParams(nil, nil, AParams);
      vsGroupSummary:
        GetRecordContentParams(TcxCustomGridRecord(AData), nil, AParams);
      vsHeader, vsIndicator:
        begin
          Color := DefaultHeaderColor;
          TextColor := DefaultHeaderTextColor;
        end;
      vsFilterRowInfoText, vsNewItemRowInfoText:
        begin
          GetContentParams(TcxCustomGridRecord(AData), nil, AParams);
          TextColor := clGrayText;
        end;  
      vsPreview:
        begin
          inherited GetContentParams(TcxCustomGridRecord(AData), GridView.Preview.Column, AParams);
          TextColor := DefaultPreviewTextColor;
        end;
    end;
end;

procedure TcxGridTableViewStyles.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TcxGridTableViewStyles then
    with TcxGridTableViewStyles(Source) do
    begin
      Self.FilterRowInfoText := FilterRowInfoText;
      Self.Footer := Footer;
      Self.Group := Group;
      Self.GroupByBox := GroupByBox;
      Self.GroupFooterSortedSummary := GroupFooterSortedSummary;
      Self.GroupSortedSummary := GroupSortedSummary;
      Self.GroupSummary := GroupSummary;
      Self.Header := Header;
      Self.Indicator := Indicator;
      Self.NewItemRowInfoText := NewItemRowInfoText;
      Self.Preview := Preview;
      Self.OnGetFooterStyle := OnGetFooterStyle;
      Self.OnGetFooterStyleEx := OnGetFooterStyleEx;
      Self.OnGetFooterSummaryStyle := OnGetFooterSummaryStyle;
      Self.OnGetGroupStyle := OnGetGroupStyle;
      Self.OnGetGroupSummaryStyle := OnGetGroupSummaryStyle;
      Self.OnGetHeaderStyle := OnGetHeaderStyle;
      Self.OnGetPreviewStyle := OnGetPreviewStyle;
    end;
end;

procedure TcxGridTableViewStyles.GetCellContentParams(ARecord: TcxCustomGridRecord;
  AItem: TObject; out AParams: TcxViewParams);
begin
  if (AItem is TcxDataSummaryItem) or (AItem is TcxDataSummaryItems) then
  begin
    if AItem is TcxDataSummaryItems then
      AItem := nil;
    GetGroupSummaryCellContentParams(ARecord as TcxGridGroupRow, TcxDataSummaryItem(AItem), AParams);
  end
  else
    inherited;
end;

procedure TcxGridTableViewStyles.GetContentParams(ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AParams: TcxViewParams);
begin
  if (AItem <> nil) and TcxGridColumn(AItem).IsPreview then
    GetPreviewParams(ARecord, AItem, AParams)
  else
    inherited;
end;

procedure TcxGridTableViewStyles.GetFooterCellParams(ARow: TcxCustomGridRow;
  AColumn: TcxGridColumn; AFooterGroupLevel: Integer; ASummaryItem: TcxDataSummaryItem;
  out AParams: TcxViewParams);
var
  AFooterCellPos: TcxGridRowFooterCellPos;
begin
  if (AFooterGroupLevel <> -1) and (ASummaryItem <> nil) and ASummaryItem.Sorted then
  begin
    AFooterCellPos := TcxGridRowFooterCellPos.Create(ARow, AColumn, AFooterGroupLevel, ASummaryItem);
    try
      GetViewParams(vsGroupFooterSortedSummary, AFooterCellPos, nil, AParams);
    finally
      AFooterCellPos.Free;
    end;
  end
  else
    AColumn.Styles.GetFooterParams(ARow, AFooterGroupLevel, ASummaryItem, AParams);
end;

procedure TcxGridTableViewStyles.GetFooterParams(ARow: TcxCustomGridRow;
  AColumn: TcxGridColumn; AFooterGroupLevel: Integer; ASummaryItem: TcxDataSummaryItem;
  out AParams: TcxViewParams);
var
  AStyle: TcxStyle;
begin
  AStyle := nil;
  if Assigned(FOnGetFooterStyle) then
    FOnGetFooterStyle(GridView, ARow, AColumn, AStyle);
  if Assigned(FOnGetFooterStyleEx) then
    FOnGetFooterStyleEx(GridView, ARow, AColumn, AFooterGroupLevel, AStyle);
  if Assigned(FOnGetFooterSummaryStyle) and (ASummaryItem <> nil) then
    FOnGetFooterSummaryStyle(GridView, ARow, AColumn, AFooterGroupLevel, ASummaryItem, AStyle);
  GetViewParams(vsFooter, nil, AStyle, AParams);
  AParams.Bitmap := GridView.BackgroundBitmaps.GetBitmap(bbFooter);
end;

procedure TcxGridTableViewStyles.GetGroupParams(ARecord: TcxCustomGridRecord;
  ALevel: Integer; out AParams: TcxViewParams);
var
  AStyle: TcxStyle;
begin
  AStyle := nil;
  if Assigned(FOnGetGroupStyle) then
  begin
    if ARecord <> nil then ALevel := ARecord.Level;
    FOnGetGroupStyle(GridView, ARecord, ALevel, AStyle);
  end;
  GetViewParams(vsGroup, ARecord, AStyle, AParams);
end;

procedure TcxGridTableViewStyles.GetGroupSummaryCellContentParams(ARow: TcxGridGroupRow;
  ASummaryItem: TcxDataSummaryItem; out AParams: TcxViewParams);
var
  ASummaryInfo: TcxGridGroupSummaryInfo;
begin
  if not FProcessingGroupSortedSummary and
    (ASummaryItem <> nil) and (ASummaryItem = ARow.GroupSummaryItems.SortedSummaryItem) then
  begin
    FProcessingGroupSortedSummary := True;
    ASummaryInfo := TcxGridGroupSummaryInfo.Create(ARow, ASummaryItem);
    try
      GetViewParams(vsGroupSortedSummary, ASummaryInfo, nil, AParams);
    finally
      ASummaryInfo.Free;
      FProcessingGroupSortedSummary := False;
    end;
  end
  else
    if (ASummaryItem = nil) or (ASummaryItem.ItemLink = nil) then
      GetGroupSummaryParams(ARow, ASummaryItem, AParams)
    else
      TcxGridColumn(ASummaryItem.ItemLink).Styles.GetGroupSummaryParams(ARow, ASummaryItem, AParams);
end;

procedure TcxGridTableViewStyles.GetGroupSummaryCellParams(ARow: TcxGridGroupRow;
  ASummaryItem: TcxDataSummaryItem; out AParams: TcxViewParams);
begin
  if GridView.DrawDataCellSelected(ARow, nil) then
    if ASummaryItem = nil then
      GetSelectionParams(ARow, ARow.GroupSummaryItems, AParams)
    else
      GetSelectionParams(ARow, ASummaryItem, AParams)
  else
    GetGroupSummaryCellContentParams(ARow, ASummaryItem, AParams);
end;

procedure TcxGridTableViewStyles.GetGroupSummaryParams(ARow: TcxGridGroupRow;
  ASummaryItem: TcxDataSummaryItem; out AParams: TcxViewParams);
var
  AStyle: TcxStyle;
  AColumn: TcxGridColumn;
begin
  AStyle := nil;
  if (ARow <> nil) and Assigned(FOnGetGroupSummaryStyle) then
  begin
    if ASummaryItem = nil then
      AColumn := nil
    else
      AColumn := ASummaryItem.ItemLink as TcxGridColumn;
    FOnGetGroupSummaryStyle(GridView, ARow, AColumn, ASummaryItem, AStyle);
  end;
  GetViewParams(vsGroupSummary, ARow, AStyle, AParams);
end;

procedure TcxGridTableViewStyles.GetHeaderParams(AItem: TcxGridColumn;
  out AParams: TcxViewParams);
var
  AStyle: TcxStyle;
begin
  AStyle := nil;
  if Assigned(FOnGetHeaderStyle) then
    FOnGetHeaderStyle(GridView, AItem, AStyle);
  GetViewParams(vsHeader, nil, AStyle, AParams);
end;

procedure TcxGridTableViewStyles.GetPreviewParams(ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AParams: TcxViewParams);
var
  AStyle: TcxStyle;
begin
  AStyle := nil;
  if Assigned(FOnGetPreviewStyle) then
    FOnGetPreviewStyle(GridView, ARecord, AItem, AStyle);
  GetViewParams(vsPreview, ARecord, AStyle, AParams);
end;

procedure TcxGridTableViewStyles.GetRecordContentParams(ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AParams: TcxViewParams);
begin
  if ARecord is TcxGridGroupRow then
    GetGroupParams(ARecord, -1, AParams)
  else
    inherited;
end;

{ TcxGridTableViewStyleSheet }

function TcxGridTableViewStyleSheet.GetStylesValue: TcxGridTableViewStyles;
begin
  Result := TcxGridTableViewStyles(GetStyles);
end;

procedure TcxGridTableViewStyleSheet.SetStylesValue(Value: TcxGridTableViewStyles);
begin
  SetStyles(Value);
end;

class function TcxGridTableViewStyleSheet.GetStylesClass: TcxCustomStylesClass;
begin
  Result := TcxGridTableViewStyles;
end;

{ TcxGridTableSummaryGroupItemLink }

function TcxGridTableSummaryGroupItemLink.GetColumn: TcxGridColumn;
begin
  Result := TcxGridColumn(ItemLink);
end;

procedure TcxGridTableSummaryGroupItemLink.SetColumn(Value: TcxGridColumn);
begin
  ItemLink := Value;
end;

function TcxGridTableSummaryGroupItemLink.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView((DataController as IcxCustomGridDataController).GridView);
end;

function TcxGridTableSummaryGroupItemLink.QueryInterface(const IID: TGUID; out Obj): HResult;
const
  E_NOINTERFACE = HResult($80004002);
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

function TcxGridTableSummaryGroupItemLink._AddRef: Integer;
begin
  Result := -1;
end;

function TcxGridTableSummaryGroupItemLink._Release: Integer;
begin
  Result := -1;
end;

function TcxGridTableSummaryGroupItemLink.GetObjectName: string;
begin
  Result := '';
end;

function TcxGridTableSummaryGroupItemLink.GetProperties(AProperties: TStrings): Boolean;
begin
  AProperties.Add('Column');
  Result := True;
end;

procedure TcxGridTableSummaryGroupItemLink.GetPropertyValue(const AName: string;
  var AValue: Variant);
begin
  if AName = 'Column' then
    if Column <> nil then
      AValue := Column.GetObjectName
    else
      AValue := '';
end;

procedure TcxGridTableSummaryGroupItemLink.SetPropertyValue(const AName: string;
  const AValue: Variant);
begin
  if AName = 'Column' then
    Column := TcxGridColumn(GridView.FindItemByObjectName(AValue));
end;

{ TcxGridTableSummaryItem }

constructor TcxGridTableSummaryItem.Create(Collection: TCollection);
begin
  inherited;
  FVisibleForCustomization := True;
end;

function TcxGridTableSummaryItem.GetColumn: TcxGridColumn;
begin
  Result := TcxGridColumn(ItemLink);
end;

function TcxGridTableSummaryItem.GetGridView: TcxGridTableView;
begin
  Result := TcxGridTableView((DataController as IcxCustomGridDataController).GridView);
end;

procedure TcxGridTableSummaryItem.SetColumn(Value: TcxGridColumn);
begin
  ItemLink := Value;
end;

procedure TcxGridTableSummaryItem.SetDisplayText(const Value: string);
begin
  if FDisplayText <> Value then
  begin
    FDisplayText := Value;
    GridView.Changed(vcProperty);
  end;
end;

procedure TcxGridTableSummaryItem.SetVisibleForCustomization(Value: Boolean);
begin
  if FVisibleForCustomization <> Value then
  begin
    FVisibleForCustomization := Value;
    GridView.Changed(vcProperty);
  end;
end;

function TcxGridTableSummaryItem.QueryInterface(const IID: TGUID; out Obj): HResult;
const
  E_NOINTERFACE = HResult($80004002);
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

function TcxGridTableSummaryItem._AddRef: Integer;
begin
  Result := -1;
end;

function TcxGridTableSummaryItem._Release: Integer;
begin
  Result := -1;
end;

function TcxGridTableSummaryItem.GetObjectName: string;
begin
  Result := '';
end;

function TcxGridTableSummaryItem.GetProperties(AProperties: TStrings): Boolean;
begin
  AProperties.Add('Column');
  Result := False;
end;

procedure TcxGridTableSummaryItem.GetPropertyValue(const AName: string; var AValue: Variant);
begin
  if AName = 'Column' then
    if Column <> nil then
      AValue := Column.GetObjectName
    else
      AValue := '';
end;

procedure TcxGridTableSummaryItem.SetPropertyValue(const AName: string; const AValue: Variant);
begin
  if AName = 'Column' then
    Column := TcxGridColumn(GridView.FindItemByObjectName(AValue));
end;

function TcxGridTableSummaryItem.GetDisplayText: string;
begin
  Result := DisplayText;
end;

function TcxGridTableSummaryItem.GetVisibleForCustomization: Boolean;
begin
  Result := VisibleForCustomization;
end;

procedure TcxGridTableSummaryItem.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TcxGridTableSummaryItem then
    with TcxGridTableSummaryItem(Source) do
    begin
      Self.DisplayText := DisplayText;
      Self.VisibleForCustomization := VisibleForCustomization;
    end;
end;

{ TcxGridTableView }

constructor TcxGridTableView.Create(AOwner: TComponent);
begin
  inherited;
  FAllowCellMerging := True;
end;

function TcxGridTableView.GetBackgroundBitmaps: TcxGridTableBackgroundBitmaps;
begin
  Result := TcxGridTableBackgroundBitmaps(inherited BackgroundBitmaps);
end;

function TcxGridTableView.GetColumn(Index: Integer): TcxGridColumn;
begin
  Result := TcxGridColumn(Items[Index]);
end;

function TcxGridTableView.GetColumnCount: Integer;
begin
  Result := ItemCount;
end;

function TcxGridTableView.GetController: TcxGridTableController;
begin
  Result := TcxGridTableController(inherited Controller);
end;

function TcxGridTableView.GetDataController: TcxGridDataController;
begin
  Result := TcxGridDataController(FDataController);
end;

function TcxGridTableView.GetDateTimeHandling: TcxGridTableDateTimeHandling;
begin
  Result := TcxGridTableDateTimeHandling(inherited DateTimeHandling);
end;

function TcxGridTableView.GetFiltering: TcxGridTableFiltering;
begin
  Result := TcxGridTableFiltering(inherited Filtering);
end;

function TcxGridTableView.GetGroupedColumn(Index: Integer): TcxGridColumn;
begin
  Result := TcxGridColumn(GroupedItems[Index]);
end;

function TcxGridTableView.GetGroupedColumnCount: Integer;
begin
  Result := GroupedItemCount;
end;

function TcxGridTableView.GetOptionsBehavior: TcxGridTableOptionsBehavior;
begin
  Result := TcxGridTableOptionsBehavior(inherited OptionsBehavior);
end;

function TcxGridTableView.GetOptionsCustomize: TcxGridTableOptionsCustomize;
begin
  Result := TcxGridTableOptionsCustomize(inherited OptionsCustomize);
end;

function TcxGridTableView.GetOptionsData: TcxGridTableOptionsData;
begin
  Result := TcxGridTableOptionsData(inherited OptionsData);
end;

function TcxGridTableView.GetOptionsSelection: TcxGridTableOptionsSelection;
begin
  Result := TcxGridTableOptionsSelection(inherited OptionsSelection);
end;

function TcxGridTableView.GetOptionsView: TcxGridTableOptionsView;
begin
  Result := TcxGridTableOptionsView(inherited OptionsView);
end;

function TcxGridTableView.GetPainter: TcxGridTablePainter;
begin
  Result := TcxGridTablePainter(inherited Painter);
end;

function TcxGridTableView.GetStyles: TcxGridTableViewStyles;
begin
  Result := TcxGridTableViewStyles(inherited Styles);
end;

function TcxGridTableView.GetViewData: TcxGridViewData;
begin
  Result := TcxGridViewData(inherited ViewData);
end;

function TcxGridTableView.GetViewInfo: TcxGridTableViewInfo;
begin
  Result := TcxGridTableViewInfo(inherited ViewInfo);
end;

function TcxGridTableView.GetVisibleColumn(Index: Integer): TcxGridColumn;
begin
  Result := TcxGridColumn(VisibleItems[Index]);
end;

function TcxGridTableView.GetVisibleColumnCount: Integer;
begin
  Result := VisibleItemCount;
end;

procedure TcxGridTableView.SetBackgroundBitmaps(Value: TcxGridTableBackgroundBitmaps);
begin
  inherited BackgroundBitmaps := Value;
end;

procedure TcxGridTableView.SetColumn(Index: Integer; Value: TcxGridColumn);
begin
  Items[Index] := Value;
end;

procedure TcxGridTableView.SetDataController(Value: TcxGridDataController);
begin
  FDataController.Assign(Value);
end;

procedure TcxGridTableView.SetDateTimeHandling(Value: TcxGridTableDateTimeHandling);
begin
  inherited DateTimeHandling := Value;
end;

procedure TcxGridTableView.SetFiltering(Value: TcxGridTableFiltering);
begin
  inherited Filtering := Value;
end;

procedure TcxGridTableView.SetFilterRow(Value: TcxGridFilterRowOptions);
begin
  FFilterRow.Assign(Value);
end;

procedure TcxGridTableView.SetNewItemRow(Value: TcxGridNewItemRowOptions);
begin
  FNewItemRow.Assign(Value);
end;

procedure TcxGridTableView.SetOnColumnHeaderClick(Value: TcxGridColumnEvent);
begin
  if @FOnColumnHeaderClick <> @Value then
  begin
    FOnColumnHeaderClick := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxGridTableView.SetOnColumnPosChanged(Value: TcxGridColumnEvent);
begin
  if @FOnColumnPosChanged <> @Value then
  begin
    FOnColumnPosChanged := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxGridTableView.SetOnColumnSizeChanged(Value: TcxGridColumnEvent);
begin
  if @FOnColumnSizeChanged <> @Value then
  begin
    FOnColumnSizeChanged := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxGridTableView.SetOnCustomDrawColumnHeader(Value: TcxGridColumnCustomDrawHeaderEvent);
begin
  if @FOnCustomDrawColumnHeader <> @Value then
  begin
    FOnCustomDrawColumnHeader := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxGridTableView.SetOnCustomDrawFooterCell(Value: TcxGridColumnCustomDrawHeaderEvent);
begin
  if @FOnCustomDrawFooterCell <> @Value then
  begin
    FOnCustomDrawFooterCell := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxGridTableView.SetOnCustomDrawGroupCell(Value: TcxGridTableCellCustomDrawEvent);
begin
  if @FOnCustomDrawGroupCell <> @Value then
  begin
    FOnCustomDrawGroupCell := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxGridTableView.SetOnCustomDrawGroupSummaryCell(Value: TcxGridGroupSummaryCellCustomDrawEvent);
begin
  if @FOnCustomDrawGroupSummaryCell <> @Value then
  begin
    FOnCustomDrawGroupSummaryCell := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxGridTableView.SetOnCustomDrawIndicatorCell(Value: TcxGridIndicatorCellCustomDrawEvent);
begin
  if @FOnCustomDrawIndicatorCell <> @Value then
  begin
    FOnCustomDrawIndicatorCell := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxGridTableView.SetOnLeftPosChanged(Value: TNotifyEvent);
begin
  if @FOnLeftPosChanged <> @Value then
  begin
    FOnLeftPosChanged := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxGridTableView.SetOptionsBehavior(Value: TcxGridTableOptionsBehavior);
begin
  inherited OptionsBehavior := Value;
end;

procedure TcxGridTableView.SetOptionsCustomize(Value: TcxGridTableOptionsCustomize);
begin
  inherited OptionsCustomize := Value;
end;

procedure TcxGridTableView.SetOptionsData(Value: TcxGridTableOptionsData);
begin
  inherited OptionsData := Value;
end;

procedure TcxGridTableView.SetOptionsSelection(Value: TcxGridTableOptionsSelection);
begin
  inherited OptionsSelection := Value;
end;

procedure TcxGridTableView.SetOptionsView(Value: TcxGridTableOptionsView);
begin
  inherited OptionsView := Value;
end;

procedure TcxGridTableView.SetPreview(Value: TcxGridPreview);
begin
  FPreview.Assign(Value);
end;

procedure TcxGridTableView.SetStyles(Value: TcxGridTableViewStyles);
begin
  inherited Styles := Value;
end;

function TcxGridTableView.GetProperties(AProperties: TStrings): Boolean;
begin
  with AProperties do
  begin
    Add('Footer');
    Add('GroupByBox');
    Add('GroupFooters');
    Add('NewItemRow');
  end;
  Result := inherited GetProperties(AProperties);
end;

procedure TcxGridTableView.GetPropertyValue(const AName: string; var AValue: Variant);
begin
  if AName = 'Footer' then
    AValue := OptionsView.Footer
  else
    if AName = 'GroupByBox' then
      AValue := OptionsView.GroupByBox
    else
      if AName = 'GroupFooters' then
        AValue := Variant(OptionsView.GroupFooters)
      else
        if AName = 'NewItemRow' then
          AValue := NewItemRow.Visible
        else
          inherited;
end;

procedure TcxGridTableView.SetPropertyValue(const AName: string; const AValue: Variant);
begin
  if AName = 'Footer' then
    OptionsView.Footer := AValue
  else
    if AName = 'GroupByBox' then
      OptionsView.GroupByBox := AValue
    else
      if AName = 'GroupFooters' then
        if VarIsStr(AValue) then  // version 4
          if AValue then
            OptionsView.GroupFooters := gfVisibleWhenExpanded
          else
            OptionsView.GroupFooters := gfInvisible
        else                      // version > 4
          OptionsView.GroupFooters := TcxGridGroupFootersMode((AValue))
      else
        if AName = 'NewItemRow' then
          NewItemRow.Visible := AValue
        else
          inherited;
end;

procedure TcxGridTableView.AssignLayout(ALayoutView: TcxCustomGridView);
begin
  inherited;
  with (ALayoutView as TcxGridTableView).OptionsView do
  begin
    Self.OptionsView.DataRowHeight := DataRowHeight;
    Self.OptionsView.Footer := Footer;
    Self.OptionsView.GroupByBox := GroupByBox;
    Self.OptionsView.GroupFooters := GroupFooters;
    Self.OptionsView.GroupRowHeight := GroupRowHeight;
  end;
end;

procedure TcxGridTableView.BeforeEditLayout(ALayoutView: TcxCustomGridView);
begin
  inherited;
  (ALayoutView as TcxGridTableView).AllowCellMerging := False;
end;

function TcxGridTableView.GetLayoutCustomizationFormButtonCaption: string;
begin
  Result := 'Columns customization';
end;

procedure TcxGridTableView.CreateOptions;
begin
  inherited;
  FFilterRow := GetFilterRowOptionsClass.Create(Self);
  FNewItemRow := GetNewItemRowOptionsClass.Create(Self);
  FPreview := GetPreviewClass.Create(Self);
end;

procedure TcxGridTableView.DestroyOptions;
begin
  FreeAndNil(FPreview);
  FreeAndNil(FNewItemRow);
  FreeAndNil(FFilterRow);
  inherited;
end;

function TcxGridTableView.CanCellMerging: Boolean;
begin
  Result := AllowCellMerging and not FPreview.Active and (OptionsView.RowSeparatorWidth = 0);
end;

function TcxGridTableView.CanOffset(ARecordCountDelta: Integer): Boolean;
begin
  Result := inherited CanOffset(ARecordCountDelta) and not IsMaster;
end;

function TcxGridTableView.CanOffsetHorz: Boolean;
begin
  Result := not TcxCustomGrid(Control).UpdateLocked and
    (not IsMaster or (GroupedColumnCount = 0));
end;

procedure TcxGridTableView.DetailDataChanged(ADetail: TcxCustomGridView);
begin
  inherited;
  if UpdateOnDetailDataChange(ADetail) then
    SizeChanged;
end;

procedure TcxGridTableView.DoAssign(ASource: TcxCustomGridView);
begin
  if ASource is TcxGridTableView then
    with TcxGridTableView(ASource) do
    begin
      Self.OnColumnHeaderClick := OnColumnHeaderClick;
      Self.OnColumnPosChanged := OnColumnPosChanged;
      Self.OnColumnSizeChanged := OnColumnSizeChanged;
      Self.OnCustomDrawColumnHeader := OnCustomDrawColumnHeader;
      Self.OnCustomDrawFooterCell := OnCustomDrawFooterCell;
      Self.OnCustomDrawGroupCell := OnCustomDrawGroupCell;
      Self.OnCustomDrawGroupSummaryCell := OnCustomDrawGroupSummaryCell;
      Self.OnCustomDrawIndicatorCell := OnCustomDrawIndicatorCell;
      Self.OnLeftPosChanged := OnLeftPosChanged;
    end;
  inherited;
  if ASource is TcxGridTableView then
    with TcxGridTableView(ASource) do
    begin
      Self.FilterRow := FilterRow;
      Self.NewItemRow := NewItemRow;
      Self.Preview := Preview;
    end;
end;

procedure TcxGridTableView.GetItemsListForClipboard(AItems: TList; ACopyAll: Boolean);
var
  I: Integer;
begin
  if ACopyAll or not Controller.CellMultiSelect then
    inherited GetVisibleItemsList(AItems)
  else
  begin
    inherited;
    for I := AItems.Count - 1 downto 0 do
      if not TcxGridColumn(AItems[I]).Selected then
        AItems.Delete(I);
  end;
  if OptionsBehavior.CopyPreviewToClipboard then
    if FPreview.Active then AItems.Add(FPreview.Column);
end;

function TcxGridTableView.GetResizeOnBoundsChange: Boolean;
begin
  Result := inherited GetResizeOnBoundsChange or
    OptionsView.ColumnAutoWidth or Preview.Active or IsMaster;
end;

function TcxGridTableView.HasCellMerging: Boolean;
var
  I: Integer;
begin
  for I := 0 to VisibleColumnCount - 1 do
  begin
    Result := VisibleColumns[I].CanCellMerging;
    if Result then Exit;
  end;
  Result := False;
end;

function TcxGridTableView.IsEqualHeightRecords: Boolean;
begin
  Result := inherited IsEqualHeightRecords and
    not ViewInfo.RecordsViewInfo.HasLastHorzGridLine(nil) and
    not Preview.Active and (GroupedColumnCount = 0) and not IsMaster;
end;

function TcxGridTableView.IsRecordHeightDependsOnData: Boolean;
begin
  Result := inherited IsRecordHeightDependsOnData or
    Preview.Active and Preview.AutoHeight;
end;

function TcxGridTableView.UpdateOnDetailDataChange(ADetail: TcxCustomGridView): Boolean;
begin
  Result := not OptionsView.ExpandButtonsForEmptyDetails;
end;

function TcxGridTableView.GetControllerClass: TcxCustomGridControllerClass;
begin
  Result := TcxGridTableController;
end;

function TcxGridTableView.GetDataControllerClass: TcxCustomDataControllerClass;
begin
  Result := TcxGridDataController;
end;

function TcxGridTableView.GetPainterClass: TcxCustomGridPainterClass;
begin
  Result := TcxGridTablePainter;
end;

function TcxGridTableView.GetViewDataClass: TcxCustomGridViewDataClass;
begin
  Result := TcxGridViewData;
end;

function TcxGridTableView.GetViewInfoClass: TcxCustomGridViewInfoClass;
begin
  Result := TcxGridTableViewInfo;
end;

function TcxGridTableView.GetBackgroundBitmapsClass: TcxCustomGridBackgroundBitmapsClass;
begin
  Result := TcxGridTableBackgroundBitmaps;
end;

function TcxGridTableView.GetDateTimeHandlingClass: TcxCustomGridTableDateTimeHandlingClass;
begin
  Result := TcxGridTableDateTimeHandling;
end;

function TcxGridTableView.GetFilteringClass: TcxCustomGridTableFilteringClass;
begin
  Result := TcxGridTableFiltering;
end;

function TcxGridTableView.GetFilterRowOptionsClass: TcxGridFilterRowOptionsClass;
begin
  Result := TcxGridFilterRowOptions;
end;

function TcxGridTableView.GetNewItemRowOptionsClass: TcxGridNewItemRowOptionsClass;
begin
  Result := TcxGridNewItemRowOptions;
end;

function TcxGridTableView.GetOptionsBehaviorClass: TcxCustomGridOptionsBehaviorClass;
begin
  Result := TcxGridTableOptionsBehavior;
end;

function TcxGridTableView.GetOptionsCustomizeClass: TcxCustomGridTableOptionsCustomizeClass;
begin
  Result := TcxGridTableOptionsCustomize;
end;

function TcxGridTableView.GetOptionsDataClass: TcxCustomGridOptionsDataClass;
begin
  Result := TcxGridTableOptionsData;
end;

function TcxGridTableView.GetOptionsSelectionClass: TcxCustomGridOptionsSelectionClass;
begin
  Result := TcxGridTableOptionsSelection;
end;

function TcxGridTableView.GetOptionsViewClass: TcxCustomGridOptionsViewClass;
begin
  Result := TcxGridTableOptionsView;
end;

function TcxGridTableView.GetPreviewClass: TcxGridPreviewClass;
begin
  Result := TcxGridPreview;
end;

function TcxGridTableView.GetStylesClass: TcxCustomGridViewStylesClass;
begin
  Result := TcxGridTableViewStyles;
end;

function TcxGridTableView.GetSummaryGroupItemLinkClass: TcxDataSummaryGroupItemLinkClass;
begin
  Result := TcxGridTableSummaryGroupItemLink;
end;

function TcxGridTableView.GetSummaryItemClass: TcxDataSummaryItemClass;
begin
  Result := TcxGridTableSummaryItem;
end;

function TcxGridTableView.GetItemClass: TcxCustomGridTableItemClass;
begin
  Result := TcxGridColumn;
end;

procedure TcxGridTableView.ItemVisibilityChanged(AItem: TcxCustomGridTableItem;
  Value: Boolean);
begin
  if not Value and (AItem = Controller.CellSelectionAnchor) then
    Controller.CellSelectionAnchor := Controller.FocusedColumn;
  inherited;
end;

function TcxGridTableView.CalculateDataCellSelected(ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; AUseViewInfo: Boolean;
  ACellViewInfo: TcxGridTableCellViewInfo): Boolean;
begin
  if Controller.CellMultiSelect and TcxCustomGridRow(ARecord).SupportsCellMultiSelect then
    Result := (AItem <> nil) and TcxGridColumn(AItem).Selected and
      (not (ACellViewInfo is TcxGridTableDataCellViewInfo) or
       not TcxGridTableDataCellViewInfo(ACellViewInfo).Editing)
  else
    Result := inherited CalculateDataCellSelected(ARecord, AItem, AUseViewInfo, ACellViewInfo);
end;

procedure TcxGridTableView.DoColumnHeaderClick(AColumn: TcxGridColumn);
begin
  if Assigned(FOnColumnHeaderClick) then FOnColumnHeaderClick(Self, AColumn);
end;

procedure TcxGridTableView.DoColumnPosChanged(AColumn: TcxGridColumn);
begin
  if Assigned(FOnColumnPosChanged) then FOnColumnPosChanged(Self, AColumn);
end;

procedure TcxGridTableView.DoColumnSizeChanged(AColumn: TcxGridColumn);
begin
  if Assigned(FOnColumnSizeChanged) then FOnColumnSizeChanged(Self, AColumn);
end;

procedure TcxGridTableView.DoCustomDrawColumnHeader(ACanvas: TcxCanvas;
  AViewInfo: TcxGridColumnHeaderViewInfo; var ADone: Boolean);
begin
  if HasCustomDrawColumnHeader then
    FOnCustomDrawColumnHeader(Self, ACanvas, AViewInfo, ADone);
end;

procedure TcxGridTableView.DoCustomDrawFooterCell(ACanvas: TcxCanvas;
  AViewInfo: TcxGridColumnHeaderViewInfo; var ADone: Boolean);
begin
  if HasCustomDrawFooterCell then
    FOnCustomDrawFooterCell(Self, ACanvas, AViewInfo, ADone);
end;

procedure TcxGridTableView.DoCustomDrawGroupCell(ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
begin
  if HasCustomDrawGroupCell then
    FOnCustomDrawGroupCell(Self, ACanvas, AViewInfo, ADone);
end;

procedure TcxGridTableView.DoCustomDrawGroupSummaryCell(ACanvas: TcxCanvas;
  AViewInfo: TcxCustomGridViewCellViewInfo; var ADone: Boolean);
var
  ACell: TcxGridGroupSummaryCellViewInfo;
begin
  if HasCustomDrawGroupSummaryCell then
  begin
    ACell := TcxGridGroupSummaryCellViewInfo(AViewInfo);
    FOnCustomDrawGroupSummaryCell(Self, ACanvas, ACell.RowViewInfo.GridRecord,
      ACell.Column, ACell.SummaryItem, AViewInfo, ADone);
  end;
end;

procedure TcxGridTableView.DoCustomDrawIndicatorCell(ACanvas: TcxCanvas;
  AViewInfo: TcxCustomGridIndicatorItemViewInfo; var ADone: Boolean);
begin
  if HasCustomDrawIndicatorCell then
    FOnCustomDrawIndicatorCell(Self, ACanvas, AViewInfo, ADone);
end;

procedure TcxGridTableView.DoLeftPosChanged;
begin
  if Assigned(FOnLeftPosChanged) then FOnLeftPosChanged(Self);
end;

function TcxGridTableView.HasCustomDrawColumnHeader: Boolean;
begin
  Result := Assigned(FOnCustomDrawColumnHeader);
end;

function TcxGridTableView.HasCustomDrawFooterCell: Boolean;
begin
  Result := Assigned(FOnCustomDrawFooterCell);
end;

function TcxGridTableView.HasCustomDrawGroupCell: Boolean;
begin
  Result := Assigned(FOnCustomDrawGroupCell);
end;

function TcxGridTableView.HasCustomDrawGroupSummaryCell: Boolean;
begin
  Result := Assigned(FOnCustomDrawGroupSummaryCell);
end;

function TcxGridTableView.HasCustomDrawIndicatorCell: Boolean;
begin
  Result := Assigned(FOnCustomDrawIndicatorCell);
end;

function TcxGridTableView.CreateColumn: TcxGridColumn;
begin
  Result := TcxGridColumn(CreateItem);
end;

class function TcxGridTableView.CanBeLookupList: Boolean;
begin
  Result := True;
end;

{ TcxGridColumnAccess }

class function TcxGridColumnAccess.CanCellMerging(AInstance: TcxGridColumn): Boolean;
begin
  Result := AInstance.CanCellMerging;
end;

class function TcxGridColumnAccess.CanShowGroupFooters(AInstance: TcxGridColumn): Boolean;
begin
  Result := AInstance.CanShowGroupFooters;
end;

class procedure TcxGridColumnAccess.DoCustomDrawGroupSummaryCell(AInstance: TcxGridColumn;
  ACanvas: TcxCanvas; AViewInfo: TcxCustomGridViewCellViewInfo; var ADone: Boolean);
begin
  AInstance.DoCustomDrawGroupSummaryCell(ACanvas, AViewInfo, ADone);
end;

class function TcxGridColumnAccess.HasCustomDrawGroupSummaryCell(AInstance: TcxGridColumn): Boolean;
begin
  Result := AInstance.HasCustomDrawGroupSummaryCell;
end;

{ TcxGridTableViewAccess }

class procedure TcxGridTableViewAccess.DoColumnPosChanged(AInstance: TcxGridTableView;
  AColumn: TcxGridColumn);
begin
  AInstance.DoColumnPosChanged(AColumn);
end;

class procedure TcxGridTableViewAccess.DoCustomDrawGroupCell(AInstance: TcxGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
begin
  AInstance.DoCustomDrawGroupCell(ACanvas, AViewInfo, ADone);
end;

class procedure TcxGridTableViewAccess.DoCustomDrawGroupSummaryCell(AInstance: TcxGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxCustomGridViewCellViewInfo; var ADone: Boolean);
begin
  AInstance.DoCustomDrawGroupSummaryCell(ACanvas, AViewInfo, ADone);
end;

class function TcxGridTableViewAccess.HasCustomDrawGroupCell(AInstance: TcxGridTableView): Boolean;
begin
  Result := AInstance.HasCustomDrawGroupCell;
end;

class function TcxGridTableViewAccess.HasCustomDrawGroupSummaryCell(AInstance: TcxGridTableView): Boolean;
begin
  Result := AInstance.HasCustomDrawGroupSummaryCell;
end;

initialization
  cxGridRegisteredViews.Register(TcxGridTableView, 'Table');
  Classes.RegisterClasses([TcxGridColumn, TcxGridTableViewStyleSheet]);

finalization
  cxGridRegisteredViews.Unregister(TcxGridTableView);

end.
