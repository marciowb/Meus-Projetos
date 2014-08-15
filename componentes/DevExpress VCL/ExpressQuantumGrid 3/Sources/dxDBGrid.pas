
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressQuantumGrid Suite                                    }
{                                                                   }
{       Copyright (c) 1998-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSGRID AND ALL ACCOMPANYING VCL }
{   CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.                 }
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

unit dxDBGrid;

interface

{$I dxTLVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, dxTL, Mask, dxTLStr, dxCntner, dxEditor, dxDBCtrl,
  dxExEdtr, dxUtils, dxFilter{$IFDEF DELPHI6}, Variants{$ENDIF};

const
  {for AGroupPanel}
  agpHOfs    = 8;
  agpHWidht  = 100;
  agpHDeltaX = 4;
  agpHDeltaY = 0;

  {Paint}
  dxclGroupPanel = clBtnShadow;
  dxclGroupPanelText = clBtnFace;
  dxclGroupPanelLine = clBtnText;

type
  { TCustomdxDBGrid }
  TdxDBGridOption = (egoColumnSizing, egoColumnMoving, egoEditing, egoTabs, egoTabThrough,
    egoRowSelect, egoMultiSelect, egoCanDelete, egoConfirmDelete, egoCanNavigation,
    egoCanAppend, egoCancelOnExit, egoImmediateEditor, egoCanInsert, egoLoadAllRecords,
    egoPreview, egoDrawEndEllipsis, egoStoreToRegistry, egoAutoWidth, egoShowHourGlass,
    egoCaseInsensitive, egoDblClick, egoIndicator, egoExtMultiSelect, egoResetColumnFocus,
    egoExtCustomizing, egoHideFocusRect, egoStoreToIniFile, egoUseLocate, egoSmartReload,
    egoSmartRefresh, egoSeekDetail);
  TdxDBGridOptions = set of TdxDBGridOption;

  TdxDBGridOptionEx = (egoInvertSelect, egoUseBitmap, egoBandHeaderWidth, egoAutoCalcPreviewLines,
    egoBandSizing, egoBandMoving, egoHorzThrough, egoVertThrough, egoCellMultiSelect,
    egoEnterThrough, egoEnterShowEditor, egoFullSizing, egoDragScroll, egoDragExpand,
    egoDragCollapse, egoRowAutoHeight, egoBandButtonClicking, egoBandPanelSizing,
    egoHeaderButtonClicking, egoHeaderPanelSizing, egoRowSizing, egoAutoSort,
    egoNotHideColumn, egoMultiSort, egoShowButtonAlways, egoAutoHeaderPanelHeight,
    egoKeepColumnWidth, egoSyncSelection, egoCollapsedReload, egoAnsiSort,
    egoMouseScroll, egoAutoSearch);
  TdxDBGridOptionsEx = set of TdxDBGridOptionEx;

  // New Options (HotTrack, SimpleButton)
  TdxDBGridOptionBehavior = (edgoAnsiSort, edgoAutoCopySelectedToClipboard,
    edgoAutoSearch, edgoAutoSort,
    edgoBandButtonClicking, edgoCaseInsensitive, edgoCellMultiSelect,
    edgoCollapsedReload, edgoDblClick, edgoDragCollapse, edgoDragExpand, edgoDragScroll,
    edgoEditing, edgoEnterShowEditor, edgoEnterThrough, edgoExtMultiSelect,
    edgoHeaderButtonClicking, edgoHorzThrough, edgoImmediateEditor, edgoMouseScroll,
    edgoMultiSelect, edgoMultiSort, edgoSeekDetail, edgoShowHourGlass, edgoStoreToIniFile,
    edgoStoreToRegistry, edgoTabs, edgoTabThrough, edgoVertThrough);

  TdxDBGridOptionCustomize = (edgoBandMoving, edgoBandPanelSizing, edgoBandSizing,
    edgoColumnMoving, edgoColumnSizing, edgoExtCustomizing, edgoFullSizing,
    edgoHeaderPanelSizing, edgoKeepColumnWidth, edgoNotHideColumn, edgoRowSizing);

  TdxDBGridOptionDB = (edgoCanAppend, edgoCancelOnExit, edgoCanDelete, edgoCanInsert,
    edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoPartialLoad,
    edgoResetColumnFocus, edgoSmartRefresh, edgoSmartReload, edgoSyncSelection,
    edgoUseBookmarks, edgoUseLocate);

  TdxDBGridOptionView = (edgoAutoCalcPreviewLines, edgoAutoHeaderPanelHeight,
    edgoAutoWidth, edgoBandHeaderWidth, edgoDrawEndEllipsis, edgoHideFocusRect,
    edgoHotTrack, edgoIndicator, edgoInvertSelect, edgoPreview, edgoRowAutoHeight,
    edgoRowSelect, edgoShowButtonAlways, edgoUseBitmap);

  TdxDBGridOptionsBehavior = set of TdxDBGridOptionBehavior;
  TdxDBGridOptionsCustomize = set of TdxDBGridOptionCustomize;
  TdxDBGridOptionsDB = set of TdxDBGridOptionDB;
  TdxDBGridOptionsView = set of TdxDBGridOptionView;

  // Add FilterOptions(CaseIns)
const
  dxDBGridDefaultOptionsBehavior = [edgoAutoSort,
    edgoDragScroll, edgoEditing, edgoEnterShowEditor,
    edgoImmediateEditor, edgoTabThrough, edgoVertThrough];
  dxDBGridDefaultOptionsCustomize = [edgoBandMoving, edgoBandSizing, edgoColumnMoving,
    edgoColumnSizing];
  dxDBGridDefaultOptionsDB = [edgoCancelOnExit, edgoCanDelete, edgoCanInsert,
    edgoCanNavigation, edgoConfirmDelete, edgoUseBookmarks];
  dxDBGridDefaultOptionsView = [edgoBandHeaderWidth, edgoUseBitmap];
  
type
  TCustomdxDBGrid = class;
  TdxDBGridFilterPopupListBox = class;
  TdxDBGridFilter = class;
  TdxDBGridFilterClass = class of TdxDBGridFilter;

  { TdxDBGridColumn }
  TdxDBGridColumn = class(TdxDBTreeListColumn)
  public
    property SummaryGroup;
  published
    property DisableFilter;
    property GroupIndex;
    property SummaryType;
    property SummaryField;
    property SummaryFormat;
    property SortBySummary;
    property OnSummary;
    property SummaryGroupName;

    property SummaryFooterType;
    property SummaryFooterField;
    property SummaryFooterFormat;
    property OnSummaryFooter;
    property OnDrawSummaryFooter;
  end;

  { TdxGridDataLink }
  TdxGridDataLink = class(TdxDBTreeListControlDataLink)
  private
    function GetDBGrid: TCustomdxDBGrid;
  protected
    // override TDataLink
    procedure FocusControl(Field: TFieldRef); override;
    procedure LayoutChanged; override;
    property DBGrid: TCustomDxDBGrid read GetDBGrid;
  end;

  { TdxDBGridNode }
  TSummaryValue = record
    Value: Extended;
    AssignedValue: Boolean;
  end;

  PSummaryList =^TSummaryList;
  TSummaryList = array[0..(MaxInt div 2) div SizeOf(TSummaryValue)] of TSummaryValue;

  TdxDBGridNode = class(TdxDBTreeListControlNode)
  private
    FGroupId: Variant;                         {group id}
    FSummary: Extended;                        {summary value}
    FAssignedSummary: Boolean;                 {summary value no asigned if False}
    FRecNo: Integer;                           {RecNo -> MoveBy}
    FSummaryList: PSummaryList;                {multi summary values}
    function GetSummaryValue: Extended;
    function GetMultiSummaryValue(Index: Integer): Extended;
  public
    destructor Destroy; override;
    procedure Delete; override;
    property GroupId: Variant read FGroupId;
    property RecNo: Integer read FRecNo;
    property SummaryValue: Extended read GetSummaryValue;
    property SummaryValues[Index: Integer]: Extended read GetMultiSummaryValue;
  end;

  TdxDBTreeListColumnClick = procedure(Sender: TObject; Column: TdxDBTreeListColumn) of object;
  TdxDBTreeListColumnSorting = procedure(Sender: TObject; Column: TdxDBTreeListColumn; var Allow: Boolean) of object;
  TShowColumnEvent = procedure(Sender: TObject; Column: TdxDBTreeListColumn) of object;
  THideColumnEvent = procedure(Sender: TObject; Column: TdxDBTreeListColumn) of object;

  TAddGroupColumnEvent = procedure(Sender: TObject; Column: TdxDBTreeListColumn; var Allow: Boolean) of object;
  TEndDragGroupColumn = procedure(Sender: TObject; Column: TdxDBTreeListColumn;
    NewGroupIndex: Integer; var Allow: Boolean) of object;
  TdxDBGridBackgroundDrawEvent = procedure(Sender: TObject; ACanvas: TCanvas; ARect: TRect) of object;

  TdxCustomSummaryTextEvent = procedure(Sender: TObject; Node: TdxTreeListNode; var Text: string) of object;
  TdxSummaryNodeEvent = procedure(Sender: TObject; Node: TdxTreeListNode; DataSet: TDataSet; var Value: Extended) of object;

  TdxDBGridFilterChangedEvent = procedure(Sender: TObject; ADataSet: TDataSet; const AFilterText: string) of object;
  TdxDBGridEnumFilterValuesEvent = procedure(Sender: TObject; AColumn: TdxDBTreeListColumn;
    var AValue: Variant; var ADisplayText: string; var ARepeatEnumeration: Boolean) of object;

  TdxChangeNodeInfo = record
    Id: Variant;
    Level: Integer;
    Selected: Boolean;
  end;

  TdxDBGridReloadMode = (rlUnknown, rlGridMode, rlAllRecords);
  TdxDBGridLoadMode = (lmCurrent, lmNext, lmPrior, lmAllRecords);
  TdxDBGridResyncMode = (rmNone, rmTop, rmBottom);

  TCustomdxDBGrid = class(TCustomdxDBTreeListControl)
  private
    // DataSet, Navigation, Sync
    DataChangedBusy: Boolean;
    DataChangedLocate, DataChangedLocateResync: Boolean;
    FDataLink: TdxGridDataLink;
    FDefaultFields: Boolean;
    FGridBOF, FGridEOF: Boolean;
    FInUpdateActive: Boolean;
    FLocateByNode: Boolean;
    FLockPrepareNode: Integer; // Prepare Node - synchronizing with DataSet
    FOldActiveRecord: Integer; // Prepare Node - synchronizing with DataSet
    FOldTopVisibleId: Variant;
    FOldTopVisibleLevel: Integer;
    FPartialLoadBufferCount: Integer;
    FPrevId: Variant;
    FPrevNodeInfo: TdxChangeNodeInfo;
    FTopVisibleUpdate: Integer;
    FUpdateBufferCount: Boolean;
    FUpdatingNode: TdxDBGridNode;
    // Grouping
    FDragGroupColumn: TdxDBTreeListColumn;
    FFlagChangedGroupColumn: Boolean;
    FGroupColumnDragFlag: Boolean;
    FGroupColumnPointDragging: TPoint;
    FGroupColumns: TList;
    FGroupFields: TStrings;
    FLockGrouping: Integer;
    FPrevReloadMode: TdxDBGridReloadMode;
    FRefreshGroupColumns: Boolean;
    FRefreshGroupList: Boolean;
    // Summary
    FSummaryAbsoluteList: TList;
    FSummaryGroups: TdxDBGridSummaryGroups;
    FSummarySeparator: string;
    FTotalSummaryCount: Integer;
    // Selection
    FBkmSelectionAnchor: TBookmarkStr;
    FSaveBkmList: TStringList;
    FSaveIdList: TList;
    FSelectAllFlag: Boolean;
    // Style
    FGroupPanelColor: TColor;
    FGroupPanelFontColor: TColor;
    FGroupPanelVisible: Boolean;
    FOldFocusedColumn: Integer;
    FOptions: TdxDBGridOptions;
    FOptionsEx: TdxDBGridOptionsEx;
    FOptionsBehavior: TdxDBGridOptionsBehavior;
    FOptionsCustomize: TdxDBGridOptionsCustomize;
    FOptionsDB: TdxDBGridOptionsDB;
    FOptionsView: TdxDBGridOptionsView;
    // Filter
    FFiltering: Boolean;
    FFilter: TdxDBGridFilter;
    FFilterPopupListBox: TdxDBGridFilterPopupListBox;
    FFilterStream: TStream;
    // Events
    FOnAddGroupColumn: TAddGroupColumnEvent;
    FOnBackgroundDrawEvent: TdxDBGridBackgroundDrawEvent;
    FOnClearNodeData: TNotifyEvent;
    FOnColumnSorting: TdxDBTreeListColumnSorting;
    FOnEndDragGroupColumn: TEndDragGroupColumn;
    FOnGetCustomSummaryText: TdxCustomSummaryTextEvent;
    FOnReloadGroupList: TNotifyEvent;
    FOnSummaryNode: TdxSummaryNodeEvent;
    // obsolete
    FOnColumnClick: TdxDBTreeListColumnClick;
    FOnCustomDraw: TCustomDrawEvent;
    FOnHideColumnEvent: THideColumnEvent;
    FOnShowColumnEvent: TShowColumnEvent;
    // Filter
    FOnFilterChanged: TdxDBGridFilterChangedEvent;
    FOnEnumFilterValues: TdxDBGridEnumFilterValuesEvent;

    function CalcGroupPanelHeight(ColCount: Integer): Integer;
    function ChangedGroupFields: Boolean;
    procedure CheckChangeNodeEx;
    procedure ClearBookmarks;
    procedure ClearIdList;
    procedure ClearGroupFields;
    function FindIdVariant(const Id: Variant; var Index: Integer): Boolean;
    function GetFilter: TdxDBGridFilter;
    function GetFooterPanelVisible: Boolean;
    function GetGroupPanelVisible: Boolean;
    function GetOptions: TdxDBGridOptions;
    function GetOptionsEx: TdxDBGridOptionsEx;
    function GetOptionsBehavior: TdxDBGridOptionsBehavior;
    function GetOptionsCustomize: TdxDBGridOptionsCustomize;
    function GetOptionsDB: TdxDBGridOptionsDB;
    function GetOptionsView: TdxDBGridOptionsView;
    function GetPartialLoad: Boolean;
    function GetUseBookmarks: Boolean;
    procedure InsertNode(FAppend: Boolean);
    procedure LoadChangeNodeInfo(var NodeInfo: TdxChangeNodeInfo);
    function RestoreBookmark(ANode: TdxTreeListNode; const ABookmark: TBookmarkStr; ABackward: Boolean): Boolean;
    procedure RestoreSelected(ANode: TdxTreeListNode);
    procedure SaveBookmarks;
    procedure SaveGroupFields;
    procedure ScrollGroupPanel;
    procedure SetDataSource(Value: TDataSource);
    procedure SetDefaultFields(Value: Boolean);
    procedure SetFilter(Value: TdxDBGridFilter);
    procedure SetFooterPanelVisible(Value: Boolean);
    procedure SetGroupPanelColor(Value: TColor);
    procedure SetGroupPanelFontColor(Value: TColor);
    procedure SetGroupPanelVisible(Value : Boolean);
    procedure SetOptions(Value: TdxDBGridOptions);
    procedure SetOptionsEx(Value: TdxDBGridOptionsEx);
    // New Options
    procedure SetOptionsBehavior(Value: TdxDBGridOptionsBehavior);
    procedure SetOptionsCustomize(Value: TdxDBGridOptionsCustomize);
    procedure SetOptionsDB(Value: TdxDBGridOptionsDB);
    procedure SetOptionsView(Value: TdxDBGridOptionsView);
    procedure SetPartialLoad(Value: Boolean);
    procedure SetPartialLoadBufferCount(Value: Integer);
    procedure SetSummaryGroups(Value: TdxDBGridSummaryGroups);
    procedure SetSummarySeparator(Value: string);
    procedure SetUseBookmarks(Value: Boolean);
    // dataset
    function InternalGridMode: Boolean;
    procedure UpdateActive;
    // messages
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure CMDesignHitTest(var Msg: TCMDesignHitTest); message CM_DESIGNHITTEST;
  protected
    FlagSmartReload: Boolean;
    FlagFullRefresh: Boolean;

    // override TComponent
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure WndProc(var Message: TMessage); override;
    // Size
    function GetGroupHeaderRect(Index: Integer): TRect;
    function GetGroupPanelHeight: Integer; override;
    function GetIndentWidth: Integer; override;
    function GetScrollVertGridRect: TRect; override;
    function GetVisibleRowCount: Integer; override;
    procedure GetVScrollInfo(var Min, Max, Pos : Integer; var Page, Mask : UINT); override;
    procedure UpdateRowCount; override;
    procedure UpdateScrollBars; override;
    // Drag & Drop & Customizing
    procedure CalcArrowsPos(var P: TPoint; PPosInfo: Pointer; IsBand: Boolean; DownIndex, DragIndex: Integer); override;
    procedure DoEndDragGroupColumn(Column: TdxDBTreeListColumn; NewGroupIndex: Integer; var Accept: Boolean); virtual;
    procedure EndDragHeader(Flag: Boolean); override;
    function GetColumnArrowsPos(Pos: TPoint): Integer;
    procedure GetDragImageCursor(P: TPoint; var ADragCursor: TCursor); override;
    function GetIsCustomizing: Boolean; override;
    function IsHeaderCustomizing: Boolean; override;
    procedure HideHeader(AbsoluteIndex: Integer); override;
    function IsLastNode(ANode: TdxTreeListNode): Boolean; override;
    function IsTopNode(ANode: TdxTreeListNode): Boolean; override;
    procedure ShowColumnHeader(BandIndex, RowIndex, ColIndex, AbsoluteIndex: Integer); override;
    // Paint
    function AssignedDrawCellEvent(ANode: TdxTreeListNode; AbsoluteIndex: Integer): Boolean; override;
    procedure DrawGroupPanel(ACanvas: TCanvas; ARect: TRect; HeaderBrush, PanelBrush: HBRUSH); override;
    procedure DoDrawCell(ACanvas: TCanvas; var ARect: TRect; ANode: TdxTreeListNode; AIndex: Integer; ASelected, AFocused: Boolean;
      ANewItemRow: Boolean; ALeftEdge, ARightEdge: Boolean; ABrush: HBRUSH;
      var AText: string; var AColor: TColor; AFont: TFont; var AAlignment: TAlignment; var ADone: Boolean); override;
    procedure DoHeaderClick(AbsoluteIndex: Integer); override;
    procedure DoHeaderDropDownButtonClick(AbsoluteIndex: Integer); override;
    procedure DoStatusCloseButtonClick; override;
    function GetGridColor(ABrushColor: TColor): TColor; override;
    procedure PrepareNode(ANode: TdxTreeListNode); override;
    procedure UnPrepareNode(ANode: TdxTreeListNode); override;
    // Editor
    function CanEditShow: Boolean; override;
    procedure DoBeforeEditing(Node: TdxTreeListNode; var AllowEditing: Boolean); override;
    // Selected
    function CanFullMultiSelect: Boolean; override;
    function CanNodeSelected(ANode: TdxTreeListNode): Boolean; override;
    function CompareSelectionAnchor(ANode: TdxTreeListNode): Integer; override;
    procedure DoSelectedCountChange; override;
    procedure InvalidateSelection; override;
    function IsNodeSelected(ANode: TdxTreeListNode): Boolean; override;
    procedure NodeSelected(ANode: TdxTreeListNode; ASelected: Boolean); override;
    procedure SelectNodes(N1, N2: TdxTreeListNode); override;
    procedure SelectRecords(ADirectionUp: Boolean; ACount: Integer);
    procedure SetSelectionAnchor(ANode: TdxTreeListNode); override;
    // Sorting
    procedure AddSortedColumn(Column: TdxTreeListColumn); override;
    function CanColumnSorting(Column: TdxTreeListColumn): Boolean; override;
    procedure CheckSorted;
    procedure DoSortColumn(StartIndex, ColIndex: Integer; FlagDesc: Boolean); override;
    function IsAutoFilter: Boolean; override;
    function IsAutoSort: Boolean; override;
    function IsFilterStatusVisible: Boolean; override;
    function IsMultiSort: Boolean; override;
    function IsMultiSortColumn(AbsoluteIndex: Integer): Boolean; override;
    function IsSummaryColumn(ColIndex: Integer): Boolean;
    function IsUseLocate: Boolean; virtual;
    procedure SetColumnSorted(Column: TdxTreeListColumn); override;
    // Grouping
    procedure ChangedGroupColumn(Column: TdxDBTreeListColumn); override;
    function FindGroupNode(StartNode: TdxDBGridNode; Value: Variant;
      var Node: TdxDBGridNode; FlagDesc: Boolean; StartIndex: Integer) : Boolean;
    function GetGroupColumns(Index: Integer ): TdxDBGridColumn;
    function GetGroupColumnsCount: Integer;
    function IsSmartReload: Boolean;
    function IsSmartRefresh: Boolean;
    procedure MoveNodesToRoot;
    // Summary
    procedure AssignSummaryFields; override;
    procedure AssignSummaryFooterFields; override;
    procedure CalcSummary(SmartFlag: Boolean); // Count , Average
    procedure DoClearNodeData; virtual;
    function FindSummaryGroup(Column: TdxDBTreeListColumn): TdxDBGridSummaryGroup;
    function GetCustomSummaryText(Node: TdxTreeListNode): string;
    function GetSummaryText(ANode: TdxTreeListNode; AColumn: TdxDBTreeListColumn): string;
    function GetSummaryValue(ANode: TdxTreeListNode): Extended; override;
    procedure LoadSummaryFooterValues(ADetailNode: TDxDBGridNode; List: TList);
    procedure LoadSummaryValues(ANode, ADetailNode: TDxDBGridNode; List: TList);
    procedure MakeSummaryFieldList(List: TList);
    procedure MakeSummaryFooterFieldList(List: TList);
    procedure ReCalcSummary(ADetailNode: TdxDBGridNode);
    procedure RefreshSummaryItems(const PrevName, NewName: string); override;
    procedure SortingBySummary;
    // Style
    function CanDblClick: Boolean; override;
    procedure EndCustomLayout; override;
    function IsSmartRecalcRowHeight: Boolean; override;
    function IsVScrollBarDisableHide: Boolean; override;
    // based override
    procedure ClearListNodes; override;
    function CreateNode: TdxTreeListNode; override;
    procedure DoMouseWHeelScroll(AScrollUp: Boolean; AScrollLines: Integer); override;
    function GetCellAlignment(Node: TdxTreeListNode; AbsoluteIndex: Integer): TAlignment; override;
    function GetDataLink: TdxDBTreeListControlDataLink; override;
    function GetDataSource: TDataSource; override;
    function GetFooterCellText(Node: TdxTreeListNode; AbsoluteIndex, FooterIndex: Integer): string; override;
    function GetNodeString(Node: TdxTreeListNode; Column: Integer{AbsoluteIndex}): string; override;
    function GetNodeValue(Node : TdxTreeListNode; Column : Integer{AbsoluteIndex}) : Variant; override;
    function GetNodeVariant(Node: TdxTreeListNode; Column: Integer{AbsoluteIndex}): Variant; override;
    function GetPreviewText(Node: TdxTreeListNode): string; override;
    function IsCancelOnExit: Boolean; override;
    function IsCanInsert: Boolean; override;
    function IsCanNavigation: Boolean; override;
    function IsEasySelect: Boolean; override;
    function IsExistRowFooterCell(Node: TdxTreeListNode; AbsoluteIndex, FooterIndex: Integer): Boolean; override;
    function IsKeyFieldEmpty: Boolean; override;
    function IsLevelFooter(Level: Integer): Boolean; override;
    function IsLoadedAll: Boolean; override;
    function IsRowGroup(Node: TdxTreeListNode): Boolean; override;
    function IsUseBookmarks: Boolean; override;
    procedure MakeListNodes; override;
    procedure RemoveColumn(Column: TdxTreeListColumn); override;
    procedure ResetAutoHeaderPanelRowCountOption; override;
    procedure SetDataChangedBusy(Value: Boolean); override;
    procedure SetFocusedNode(Node: TdxTreeListNode; Column: Integer; MakeVisibleFlag: Boolean); override;
    procedure SetFocusedNumber(AIndex: Integer); override;
    procedure SetTopVisibleNode(Node: TdxTreeListNode); override;
    // based
    procedure CorrectIdGroupNodes;
    function GetDefaultFields: Boolean; override;
    function GetMinBufferCount: Integer;
    procedure GetNextNodes(Mode: TdxDBGridLoadMode; ResyncMode: TdxDBGridResyncMode; SelectMode: Boolean);
    procedure FindNodeById;
    procedure LoadGroupList(FNodes: TList); virtual;
    function LocateByNode(OldNode, Node: TdxDBgridNode; const Value: Variant; UseLocate: Boolean) : Boolean;
    procedure RefreshGroupList;
    procedure RefreshNodeValues(var Node: TdxDBTreeListControlNode); override;
    procedure ReLoadGroupList;
    procedure RemoveDuplicateBookmarks(AClearNodes: Boolean);
    procedure SetGroupIndex(AColumn: TdxDBTreeListColumn; AIndex: Integer); override;
    procedure SmartRefreshNode;
    // DataSet
    procedure DataChanged; override;
    function IsDataSetBusy: Boolean; override;
    procedure LinkActive(Value: Boolean); override;
    procedure RecordChanged(Field: TField); override;
    procedure Scroll(Distance: Integer); override;
    // Save/Load
    procedure BeginReadSettings(ARegIniWrapper: TdxRegIniWrapper); override;
    procedure EndReadSettings(ARegIniWrapper: TdxRegIniWrapper); override;
    procedure ReadColumn(ARegIniWrapper: TdxRegIniWrapper; const APathCol: string; AColumn: TdxTreeListColumn); override;
    procedure ReadSettings(ARegIniWrapper: TdxRegIniWrapper; const APath: string); override;
    procedure WriteColumn(ARegIniWrapper: TdxRegIniWrapper; const APathCol: string; AColumn: TdxTreeListColumn); override;
    procedure WriteSettings(ARegIniWrapper: TdxRegIniWrapper; const APath: string); override;
    // Navigation
    function GetNodeByNavigation(ANode: TdxTreeListNode; ANavigationMode: TdxTreeListNavigationMode;
      AGotoHidden: Boolean): TdxTreeListNode; override;
    // Filter
    procedure CancelDragSizing; override;
    function CheckFilterNode(ANode: TdxDBGridNode): Boolean; virtual;
    procedure ClearFilter; virtual;
    procedure DestroyFilter; virtual;
    function GetHeaderDropDownButtonState(AbsoluteIndex: Integer): TdxHeaderDropDownButtonState; override;
    function GetFilterClass: TdxDBGridFilterClass; virtual;
    function IsAutoFilterValuesLoad: Boolean; virtual;
    function NodeFilterTestVisible(ATestNode: TdxDBGridNode): Boolean; virtual;
    function NodeRefreshFilter(ATestNode: TdxDBGridNode; ARecalc: Boolean): Boolean; virtual;
    procedure PrepareFilter; virtual;
    procedure RefreshFilter; virtual;
    procedure UpdateDataSetFilter; virtual;
    function GetStatusButtonVisible: Boolean; override;
    function GetStatusText: string; override;
    function GetStatusCloseButtonHint: string; override;

    procedure SetFilterMode;
    property Filter: TdxDBGridFilter read GetFilter write SetFilter;

    property GroupPanelColor: TColor read FGroupPanelColor write SetGroupPanelColor default dxclGroupPanel;
    property GroupPanelFontColor: TColor read FGroupPanelFontColor write SetGroupPanelFontColor default dxclGroupPanelText;
    property GroupPanelHeight: Integer read GetGroupPanelHeight;
    property HideFocusRect default False;
    property HideSelectionColor default clHighlight;
    property HideSelectionTextColor default clHighlightText;
    property Options: TdxDBGridOptions read GetOptions write SetOptions stored False;
    property OptionsEx: TdxDBGridOptionsEx read GetOptionsEx write SetOptionsEx stored False;
    // New
    property OptionsBehavior: TdxDBGridOptionsBehavior read GetOptionsBehavior
      write SetOptionsBehavior default dxDBGridDefaultOptionsBehavior;
    property OptionsCustomize: TdxDBGridOptionsCustomize read GetOptionsCustomize
      write SetOptionsCustomize default dxDBGridDefaultOptionsCustomize;
    property OptionsDB: TdxDBGridOptionsDB read GetOptionsDB
      write SetOptionsDB default dxDBGridDefaultOptionsDB;
    property OptionsView: TdxDBGridOptionsView read GetOptionsView
      write SetOptionsView default dxDBGridDefaultOptionsView;
    property PaintStyle default psOutlook;
    property ShowGrid default True;
    property OnAddGroupColumn: TAddGroupColumnEvent read FOnAddGroupColumn write FOnAddGroupColumn;
    property OnEndDragGroupColumn: TEndDragGroupColumn read FOnEndDragGroupColumn write FOnEndDragGroupColumn;
    property OnReloadGroupList: TNotifyEvent read FOnReloadGroupList write FOnReloadGroupList;
    // obsolete
    property OnColumnSorting: TdxDBTreeListColumnSorting read FOnColumnSorting write FOnColumnSorting;
    // Filter
    property OnFilterChanged: TdxDBGridFilterChangedEvent read FOnFilterChanged write FOnFilterChanged;
    property OnEnumFilterValues: TdxDBGridEnumFilterValuesEvent read FOnEnumFilterValues write FOnEnumFilterValues;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function AddGroupColumn(Column: TdxDBTreeListColumn): Boolean;
    procedure AssignColumns(ATreeListControl: TCustomdxTreeListControl); override;
    procedure BeginGrouping;
    procedure BeginSelection; override;
    function CanAddGroupColumn(Column: TdxDBTreeListColumn): Boolean; virtual;
    procedure ClearGroupColumns; override;
    procedure DeleteGroupColumn(Index: Integer);
    procedure DeleteSelection; override;
    procedure EndGrouping;
    procedure EndSelection; override;
    function FindNodeByKeyValue(const Value: Variant): TdxDBGridNode;
    procedure FullRefresh; override;
    class function GetDefaultColumnClass: TdxDBTreeListColumnClass; override;
    class function GetDefaultFieldColumnClass(AField: TField): TdxDBTreeListColumnClass; override;
    function GetGroupColumnAt(X, Y: Integer): TdxDBTreeListColumn;
    function GetNodeFooterColumnAt(X, Y: Integer): TdxDBTreeListColumn;
    function GetSummaryGroupByName(const AName: string): TdxDBGridSummaryGroup;
    function GetSummaryItemAt(X, Y: Integer; var ASummaryGroup: TdxDBGridSummaryGroup;
      var AColumn: TdxDBTreeListColumn; AutoCreate: Boolean): TdxDBGridSummaryItem;
    function InsertGroupColumn(AIndex: Integer; Column: TdxDBTreeListColumn): Boolean;
    function IsBOF: Boolean; override;
    function IsEOF: Boolean; override;
    function IsFilterMode: Boolean;
    function IsGridMode: Boolean;
    function IsLoadAllRecords: Boolean;
    function IsPartialLoad: Boolean;
    function PointInFooterPanel(P: TPoint): Boolean; // obsolete - use GetHitInfo and GetHitTestInfoAt
    function PointInGroupPanel(P: TPoint): Boolean;   // obsolete - use GetHitInfo and GetHitTestInfoAt
    procedure RebuildGroupIndexes;
    procedure RefreshGroupColumns;
    procedure RefreshSorting; override;
    procedure ResetFullRefresh;
    procedure SaveAllToStrings(List: TStrings); override;
    procedure SaveSelectedToStrings(List: TStrings); override;
    procedure SelectAll;
    procedure SetFlagSmartReload;

    property DataLink: TdxGridDataLink read FDataLink;
    property DataSetChangedBusy: Boolean read DataChangedBusy;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property GroupColumnCount: Integer read GetGroupColumnsCount;
    property GroupColumns[Index: Integer]: TdxDBGridColumn read GetGroupColumns;
    property LockRefresh;

    property OnBackgroundDrawEvent: TdxDBGridBackgroundDrawEvent read FOnBackgroundDrawEvent write FOnBackgroundDrawEvent;
    property OnGetCustomSummaryText: TdxCustomSummaryTextEvent read FOnGetCustomSummaryText write FOnGetCustomSummaryText;
    property OnSummaryNode: TdxSummaryNodeEvent read FOnSummaryNode write FOnSummaryNode;
    property OnClearNodeData: TNotifyEvent read FOnClearNodeData write FOnClearNodeData;
    // obsolete
    property OnCustomDraw: TCustomDrawEvent read FOnCustomDraw write FOnCustomDraw;
    property OnColumnClick: TdxDBTreeListColumnClick read FOnColumnClick write FOnColumnClick;
    property OnShowColumn: TShowColumnEvent read FOnShowColumnEvent write FOnShowColumnEvent;
    property OnHideColumn: THideColumnEvent read FOnHideColumnEvent write FOnHideColumnEvent;
  published
    property DefaultFields: Boolean read GetDefaultFields write SetDefaultFields default False;
    property KeyField;
    property PartialLoad: Boolean read GetPartialLoad write SetPartialLoad stored False;
    property PartialLoadBufferCount: Integer read FPartialLoadBufferCount write SetPartialLoadBufferCount default 100;
    property ShowGroupPanel: Boolean read GetGroupPanelVisible write SetGroupPanelVisible default False;
    property ShowSummaryFooter: Boolean read GetFooterPanelVisible write SetFooterPanelVisible default False;
    property SummaryGroups: TdxDBGridSummaryGroups read FSummaryGroups write SetSummaryGroups;
    property SummarySeparator: string read FSummarySeparator write SetSummarySeparator;
    property UseBookmarks: Boolean read GetUseBookmarks write SetUseBookmarks stored False; // Option
  end;

  { TdxDBGridFilterPopupListBox }
  TdxDBGridFilterValues = class(TStringList)
  private
    FAnsiSort: Boolean;
    FCaseInsensitive: Boolean;
    FMaxCount: Integer;
  public
    procedure AddValue(AText: string; AValue: Variant; ACustomLoad: Boolean);
    procedure Clear; override;
    function FindValue(const AValue: Variant; var AIndex: Integer): Boolean;
    destructor Destroy; override;
    property AnsiSort: Boolean read FAnsiSort write FAnsiSort;
    property CaseInsensitive: Boolean read FCaseInsensitive write FCaseInsensitive;
    property MaxCount: Integer read FMaxCount write FMaxCount;
  end;

  TdxDBGridFilterPopupListBox = class(TCustomdxPopupPickListBox)
  private
    FColumn: TdxDBTreeListColumn;
    FFilterValues: TdxDBGridFilterValues;
    function GetGrid: TCustomdxDBGrid;
    function GetListVisible: Boolean;
    procedure SetListVisible(Value: Boolean);
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure ClosePopup(Accept: Boolean);
    property Column: TdxDBTreeListColumn read FColumn write FColumn;
    property FilterValues: TdxDBGridFilterValues read FFilterValues;
    property Grid: TCustomdxDBGrid read GetGrid;
    property ListVisible: Boolean read GetListVisible write SetListVisible;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  { TdxDBGridFilter }
  TdxDBGridFilterColumnCriteria = (fcNone, fcBlanks, fcNonBlanks, fcValue, fcCustom);
  TdxDBGridFilterStatus = (fsAuto, fsNone, fsAlways);

  TdxDBGridFilter = class(TPersistent)
  private
    FActive: Boolean;
    FAutoDataSetFilter: Boolean;
    FCaseInsensitive: Boolean;
    FCriteria: TdxCriteria;
    FDBGrid: TCustomdxDBGrid;
    FDropDownCount: Integer;
    FDropDownWidth: Integer;
    FFilterStatus: TdxDBGridFilterStatus;
    FMaxDropDownCount: Integer;
    procedure SetActive(Value: Boolean);
    procedure SetAutoDataSetFilter(Value: Boolean);
    procedure SetCaseInsensitive(Value: Boolean);
    procedure SetFilterStatus(Value: TdxDBGridFilterStatus);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure Changed;
    function CheckFilterNode(ANode: TdxDBGridNode): Boolean;
    function GetFilterCaption: string; virtual;
    function GetFilterText: string; virtual;
    procedure Prepare;
    procedure SetFilterText(const Value: string); virtual;
    property Criteria: TdxCriteria read FCriteria;
    property DBGrid: TCustomdxDBGrid read FDBGrid;
  public
    constructor Create(ADBGrid: TCustomdxDBGrid);
    destructor Destroy; override;
    procedure Add(AColumn: TdxDBTreeListColumn; const AValue: Variant; const ADisplayValue: string); virtual;
    procedure AddNull(AColumn: TdxDBTreeListColumn; IsNot: Boolean); virtual;
    procedure Clear; virtual;
    function GetFilterColumnCriteria(AColumn: TdxDBTreeListColumn; var AValue: Variant): TdxDBGridFilterColumnCriteria;
    function IsColumnFilterExist(AColumn: TdxDBTreeListColumn): Boolean; virtual;
    function IsEmpty: Boolean; virtual;
    procedure Remove(AColumn: TdxDBTreeListColumn); virtual;
    procedure RestoreDefaults;
    procedure ShowCustomDialog(AColumn: TdxDBTreeListColumn); virtual;
    property FilterCaption: string read GetFilterCaption;
    property FilterText: string read GetFilterText write SetFilterText;
  published
    property Active: Boolean read FActive write SetActive default False; 
    property AutoDataSetFilter: Boolean read FAutoDataSetFilter write SetAutoDataSetFilter default False;
    property CaseInsensitive: Boolean read FCaseInsensitive write SetCaseInsensitive default False;
    property DropDownCount: Integer read FDropDownCount write FDropDownCount default 12;
    property DropDownWidth: Integer read FDropDownWidth write FDropDownWidth default 0;
    property FilterStatus: TdxDBGridFilterStatus read FFilterStatus write SetFilterStatus default fsAuto;
    property MaxDropDownCount: Integer read FMaxDropDownCount write FMaxDropDownCount default 1000;
  end;

  { TdxDBGrid }
  TdxDBGrid = class(TCustomdxDBGrid)
  public
    procedure SaveToHTML(const AFileName: string; ASaveAll: Boolean);
    procedure SaveToXLS(const AFileName: string; ASaveAll: Boolean);
    procedure SaveToText(const AFileName: string; ASaveAll: Boolean;
       const ASeparator, ABeginString, AEndString: string);
    procedure SaveToXML(const AFileName: string; ASaveAll: Boolean);

    property DragNode;
    property EditingText;
    property FocusedField;
    property GroupPanelHeight;
    property HeaderHeight;
    property HotTrackInfo;
    property SelectedCount;
    property SelectedNodes;
    property SelectedRows;
    property TopIndex;
  published
    // standard
    property Align;
    property BorderStyle;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;

    // original
    property ArrowsColor;
    property AutoExpandOnSearch;
    property AutoSearchColor;
    property AutoSearchTextColor;
    property BandColor;
    property BandFont;
    property CustomizingRowCount;
    property DataSource;
    property DefaultRowHeight;
    property DblClkExpanding;
    property Filter;
    property FixedBandLineColor;
    property FixedBandLineWidth;
    property GridLineColor;
    property GrIndicatorWidth;
    property GroupPanelColor;
    property GroupPanelFontColor;
    property GroupNodeColor;
    property GroupNodeTextColor;
    property HeaderColor;
    property HeaderFont;
    property HideFocusRect;
    property HideSelection default False;
    property HideSelectionColor;
    property HideSelectionTextColor;
    property HighlightColor;
    property HighlightTextColor;
    property IndentDesc;
    property IniFileName;
    property IniSectionName;
    property LookAndFeel;
    property MaxRowLineCount;
    property Options;
    property OptionsEx;
    property OptionsBehavior;
    property OptionsCustomize;
    property OptionsDB;
    property OptionsView;
    property PreviewFieldName;
    property PreviewFont;
    property PreviewLines;
    property PreviewMaxLength;
    property RegistryPath;
    property RowFooterColor;
    property RowFooterTextColor;
    property RowSeparatorLineWidth;
    property ScrollBars;
    property ShowBands;
    property ShowGrid;
    property ShowHeader;
    property ShowHiddenInCustomizeBox;
    property ShowNewItemRow;
    property ShowPreviewGrid;
    property ShowRowFooter;
    property SimpleCustomizeBox;
    property WaitForExpandNodeTime;

    property OnAddGroupColumn;
    property OnBackgroundDrawEvent;
    property OnBandButtonClick;
    property OnBandClick;
    property OnBeforeCalcSummary;
    property OnBeginDragNode;
    property OnCalcRowLineHeight;
    property OnCalcSummary;
    property OnCanBandDragging;
    property OnCanHeaderDragging;
    property OnCanNodeSelected;
    property OnChangeColumn;
    property OnChangedColumnsWidth;
    property OnChangeLeftCoord;
    property OnChangeNode;
    property OnChangeNodeEx;
    property OnChangeTopVisibleNode;
    property OnClearNodeData;
    property OnCollapsed;
    property OnCollapsing;
    property OnColumnSorting;
    property OnCompare;
    property OnCustomDrawBand;
    property OnCustomDrawCell;
    property OnCustomDrawColumnHeader;
    property OnCustomDrawFooter;
    property OnCustomDrawFooterNode;
    property OnCustomDrawPreview;
    property OnCustomDrawPreviewCell;
    property OnDragEndBand;
    property OnDragEndHeader;
    property OnDragOverBand;
    property OnDragOverHeader;
    property OnDeletion;
    property OnEditChange;
    property OnEdited;
    property OnEditing;
    property OnEditValidate;
    property OnEndColumnsCustomizing;
    property OnEndDragGroupColumn;
    property OnExpanded;
    property OnExpanding;
    property OnGetEditColor;
    property OnGetLevelColor;
    property OnGetNodeDragText;
    property OnGetPreviewText;
    property OnHeaderButtonClick;
    property OnHeaderMoved;
    property OnHideBand;
    property OnHideHeader;
    property OnHotTrackNode;
    property OnIsExistFooterCell;
    property OnRefreshNodeData;
    property OnReloadGroupList;
    property OnSelectedCountChange;
    property OnShowBand;
    property OnShowHeader;
    property OnStartBandDragging;
    property OnStartHeaderDragging;

    // obsolete
    property OnColumnMoved;
    property OnCustomDraw;
    property OnColumnClick;
    property OnShowColumn;
    property OnHideColumn;

    {$IFDEF DELPHI4}
    property Anchors;
    property Constraints;
    {$ENDIF}
    {$IFDEF DELPHI5}
    property OnContextPopup;
    {$ENDIF}

    // Filter
    property OnFilterChanged;
    property OnEnumFilterValues;
  end;

  {TdxDBGridMaskColumn}
  TdxDBGridMaskColumn = class(TdxDBTreeListMaskColumn)
  public
    property SummaryGroup;
  published
    property DisableFilter;
    property GroupIndex;
    property SummaryType;
    property SummaryField;
    property SummaryFormat;
    property SortBySummary;
    property OnSummary;
    property SummaryGroupName;

    property SummaryFooterType;
    property SummaryFooterField;
    property SummaryFooterFormat;
    property OnSummaryFooter;
    property OnDrawSummaryFooter;
  end;

const
  DefaultDBGridColumnType: array[ftUnknown..ftTypedBinary] of TdxDBTreeListColumnClassInfo = (
    (ColumnClass: nil; Version: 0),                    { ftUnknown }
    (ColumnClass: TdxDBGridColumn; Version: 0),        { ftString }
    (ColumnClass: TdxDBGridColumn; Version: 0),        { ftSmallint }
    (ColumnClass: TdxDBGridColumn; Version: 0),        { ftInteger }
    (ColumnClass: TdxDBGridColumn; Version: 0),        { ftWord }
    (ColumnClass: TdxDBGridColumn; Version: 0),        { ftBoolean }
    (ColumnClass: TdxDBGridColumn; Version: 0),        { ftFloat }
    (ColumnClass: TdxDBGridColumn; Version: 0),        { ftCurrency }
    (ColumnClass: TdxDBGridColumn; Version: 0),        { ftBCD }
    (ColumnClass: TdxDBGridColumn; Version: 0),        { ftDate }
    (ColumnClass: TdxDBGridColumn; Version: 0),        { ftTime }
    (ColumnClass: TdxDBGridColumn; Version: 0),        { ftDateTime }
    (ColumnClass: TdxDBGridColumn; Version: 0),        { ftBytes }
    (ColumnClass: TdxDBGridColumn; Version: 0),        { ftVarBytes }
    (ColumnClass: TdxDBGridColumn; Version: 0),        { ftAutoInc }
    (ColumnClass: TdxDBGridColumn; Version: 0),        { ftBlob }
    (ColumnClass: TdxDBGridColumn; Version: 0),        { ftMemo }
    (ColumnClass: TdxDBGridColumn; Version: 0),        { ftGraphic }
    (ColumnClass: TdxDBGridColumn; Version: 0),        { ftFmtMemo }
    (ColumnClass: TdxDBGridColumn; Version: 0),        { ftParadoxOle }
    (ColumnClass: TdxDBGridColumn; Version: 0),        { ftDBaseOle }
    (ColumnClass: TdxDBGridColumn; Version: 0));       { ftTypedBinary }
  DefaultDBGridLookupColumnType: TdxDBTreeListColumnClassInfo = (ColumnClass: TdxDBGridColumn; Version: 0);

procedure InitDefaultDBGridColumnClasses(Proc: TInitColumnClassProc);
procedure ResetDefaultDBGridColumnClasses;

procedure LoadDBGridFilterFromStream(AStream: TStream; AFilter: TdxDBGridFilter);
procedure LoadDBGridFilterFromFile(const FileName: string; AFilter: TdxDBGridFilter);
procedure SaveDBGridFilterToStream(AStream: TStream; AFilter: TdxDBGridFilter);
procedure SaveDBGridFilterToFile(const FileName: string; AFilter: TdxDBGridFilter);

var
  sdxPanelText: string;                      // 'Drag a column header here to group by that column';

implementation

uses Menus, Clipbrd, Consts, Registry, IniFiles
  {$IFNDEF DELPHI3}, DBTables{$ENDIF}, dxGrExpt{filter}, dxGrFltr, dxGrFCmn{filter};

const
  MaxMapSize = (MaxInt div 2) div SizeOf(Integer);  { 250 million }
  
type
  TIntArray = array[0..MaxMapSize] of Integer;
  PIntArray = ^TIntArray;

// CalcSummary routines
function GetSummaryCount(ANode: TdxTreeListNode): Integer;
var
  I: Integer;
begin
  Result := 0;
  if ANode.Count > 0 then
    if ANode[0].Count = 0 then
      Result := ANode.Count
    else
      for I := 0 to ANode.Count - 1 do
        Result := Result + GetSummaryCount(ANode[I]);
end;

procedure CalcSummaryCount(ANode: TdxTreeListNode; ALevel: Integer);
var
  I: Integer;
begin
  if (ANode.Level = ALevel) then
    TdxDBGridNode(ANode).FSummary := GetSummaryCount(ANode)
  else
    for I := 0 to ANode.Count - 1 do
      CalcSummaryCount(ANode[I], ALevel);
end;

procedure CalcAverageCount(ANode: TdxTreeListNode; ALevel: Integer);
var
  I: Integer;
begin
  if (ANode.Level = ALevel) then
    TdxDBGridNode(ANode).FSummary := TdxDBGridNode(ANode).FSummary/GetSummaryCount(ANode)
  else
    for I := 0 to ANode.Count - 1 do
      CalcAverageCount(ANode[I], ALevel);
end;

procedure CalcMultiSummaryCount(ANode: TdxTreeListNode; ALevel, AIndex: Integer);
var
  I: Integer;
begin
  if (ANode.Level = ALevel) then
    TdxDBGridNode(ANode).FSummaryList^[AIndex].Value := GetSummaryCount(ANode)
  else
    for I := 0 to ANode.Count - 1 do
      CalcMultiSummaryCount(ANode[I], ALevel, AIndex);
end;

procedure CalcMultiAverageCount(ANode: TdxTreeListNode; ALevel, AIndex: Integer);
var
  I: Integer;
begin
  if (ANode.Level = ALevel) then
    TdxDBGridNode(ANode).FSummaryList^[AIndex].Value :=
      TdxDBGridNode(ANode).FSummaryList^[AIndex].Value / GetSummaryCount(ANode)
  else
    for I := 0 to ANode.Count - 1 do
      CalcMultiAverageCount(ANode[I], ALevel, AIndex);
end;

// Filter routines

type
  TFilterWrapper = class(TComponent)
  private
    FFilter: TdxDBGridFilter;
  published
    property Filter: TdxDBGridFilter read FFilter write FFilter;
  end;

procedure LoadDBGridFilterFromStream(AStream: TStream; AFilter: TdxDBGridFilter);
var
  Wrapper: TFilterWrapper;
begin
  Wrapper := TFilterWrapper.Create(nil);
  try
    Wrapper.Filter := AFilter;
    AStream.ReadComponent(Wrapper);
  finally
    Wrapper.Free;
  end;
  AFilter.Changed;
end;

procedure LoadDBGridFilterFromFile(const FileName: string; AFilter: TdxDBGridFilter);
var
  AStream: TStream;
begin
  AStream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    LoadDBGridFilterFromStream(AStream, AFilter);
  finally
    AStream.Free;
  end;
end;

procedure SaveDBGridFilterToStream(AStream: TStream; AFilter: TdxDBGridFilter);
var
  Wrapper: TFilterWrapper;
begin
  Wrapper := TFilterWrapper.Create(nil);
  try
    Wrapper.Filter := AFilter;
    AStream.WriteComponent(Wrapper);
  finally
    Wrapper.Free;
  end;
end;

procedure SaveDBGridFilterToFile(const FileName: string; AFilter: TdxDBGridFilter);
var
  AStream: TStream;
begin
  AStream := TFileStream.Create(FileName, fmCreate);
  try
    SaveDBGridFilterToStream(AStream, AFilter);
  finally
    AStream.Free;
  end;
end;

{ TdxGridDataLink }

procedure TdxGridDataLink.FocusControl(Field: TFieldRef);
var
  Node: TdxTreeListNode;
begin
  if Assigned(Field) and Assigned(Field^) then
  begin
    if not (egoCanNavigation in DBGrid.Options) then Exit;
    if not DBGrid.IsGridMode then
    begin
      Node := DBGrid.FocusedNode;
      if Node <> nil then
      begin
        while Node.Count > 0 do
          Node := Node[0];
        Node.Focused := True;
        Node.MakeVisible;
      end;
    end;
    if (egoRowSelect in DBGrid.Options) then Exit;
    if DBGrid.IsNewItemRowVisible then DBGrid.NewItemRowActive := True; // new item row
    DBGrid.FocusedField := Field^;
    if (DBGrid.FocusedField = Field^) and DBGrid.AcquireFocus then
    begin
      Field^ := nil;
      DBGrid.ShowEditor;
    end;
  end;
end;

procedure TdxGridDataLink.LayoutChanged;
var
  FlagGrp: Boolean;
begin
  FlagGrp := not DBGrid.IsGridMode;
  if FlagGrp then DBGrid.BeginGrouping;
  try
    DBGrid.LayoutChanged;
  finally
    DBGrid.FlagFullRefresh := True;
    try
      if FlagGrp then DBGrid.EndGrouping;
    finally
      DBGrid.FlagFullRefresh := False;
    end;
  end;
  if not (FlagGrp and (DBGrid.FLockGrouping = 0)) then
    inherited LayoutChanged;
end;

function TdxGridDataLink.GetDBGrid: TCustomDxDBGrid;
begin
  Result := DBTreeListControl as TCustomDxDBGrid;
end;

{TdxDBGridNode}
destructor TdxDBGridNode.Destroy;
begin
  // free summary list
  if FSummaryList <> nil then
  begin
    FreeMem(FSummaryList);
    FSummaryList := nil;
  end;
  inherited Destroy;
end;

procedure TdxDBGridNode.Delete;
var
  ADBGrid: TCustomDxDBGrid;
begin
  ADBGrid := TCustomDxDBGrid(Owner);
  if not ADBGrid.DataLink.Active then Exit;
  if ADBGrid.IsGridMode then
  begin
    if not Focused then Exit;
  end
  else
  begin
    if HasChildren or not (egoCanNavigation in ADBGrid.Options) then Exit;
    if ADBGrid.IsUseLocate then
      if not ADBGrid.LocateByNode(TdxDBgridNode(ADBGrid.FocusedNode), TdxDBgridNode(Self),
         TdxDBGridNode(Self).Id, True) then Exit
      else
    else
      if not ADBGrid.LocateByNode(TdxDBgridNode(ADBGrid.FocusedNode), TdxDBgridNode(Self), Null, False) then Exit;
  end;
  ADBGrid.FUpdatingNode := Self;
  ADBGrid.FPrevId := Self.Id;
  try
    ADBGrid.DataLink.DataSet.Delete;
  except
    ADBGrid.FUpdatingNode := nil;
    ADBGrid.FPrevId := Null;
    raise;
  end;
end;

function TdxDBGridNode.GetSummaryValue: Extended;
begin
  Result := TCustomdxDBGrid(Owner).GetSummaryValue(Self);
end;

function TdxDBGridNode.GetMultiSummaryValue(Index: Integer): Extended;
begin
  if FSummaryList <> nil then
    Result := FSummaryList^[Index].Value
  else Result := 0;
end;

{TCustomDxDBGrid}
constructor TCustomdxDBGrid.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataLink := TdxGridDataLink.Create(Self);
  FGroupColumns := TList.Create;
  // New Options
  FOptionsBehavior := dxDBGridDefaultOptionsBehavior;
  FOptionsCustomize := dxDBGridDefaultOptionsCustomize;
  FOptionsDB := dxDBGridDefaultOptionsDB;
  FOptionsView := dxDBGridDefaultOptionsView;
  FOptions := [egoEditing, egoColumnSizing, egoColumnMoving,
        egoCanDelete, egoConfirmDelete, egoCanNavigation, egoCancelOnExit,
        egoImmediateEditor, egoCanInsert, egoTabThrough];
  FOptionsEx := [egoUseBitmap, egoBandHeaderWidth, egoBandSizing, egoBandMoving, egoAutoSort,
    egoEnterShowEditor, egoVertThrough, egoDragScroll];
  FOldFocusedColumn := -1;
  inherited HideFocusRect := False;
  inherited HideSelection := False;
  inherited PaintStyle := psOutlook;
  inherited ShowGrid := True;
  inherited Options := [aoEditing, aoColumnSizing, aoColumnMoving, aoImmediateEditor, aoTabThrough];
  inherited OptionsEx := [aoUseBitmap, aoBandHeaderWidth, aoBandSizing, aoBandMoving,
    aoEnterShowEditor, aoVertThrough, aoDragScroll];
  inherited HideSelectionColor := inherited HighlightColor;
  inherited HideSelectionTextColor := inherited HighlightTextColor;
  FFlagChangedGroupColumn := False;
  FGroupFields := TStringList.Create;
  {add self to grid list}
  RegisterDBTreeListControl(Self);
  FGroupPanelColor := dxclGroupPanel;
  FGroupPanelFontColor := dxclGroupPanelText;
  {new}
  FSaveBkmList := TStringList.Create;;
  FSummaryGroups := TdxDBGridSummaryGroups.Create(Self, TdxDBGridSummaryGroup);
  FSummarySeparator := ', ';
  FSummaryAbsoluteList := TList.Create;
  FPartialLoadBufferCount := 100;
end;

destructor TCustomdxDBGrid.Destroy;
begin
  try
    DoSaveLayout;
  finally
    BeforeDestroy;
    DestroyFilter;
    ClearListNodes;
    FSummaryAbsoluteList.Free;
    FSummaryAbsoluteList := nil;
    FSaveBkmList.Free;
    FSaveBkmList := nil;
    if FSaveIdList <> nil then
    begin
      ClearIdList;
      FSaveIdList.Free;
      FSaveIdList := nil;
    end;
    FSummaryGroups.Free;
    FSummaryGroups := nil;
    FGroupFields.Free;
    FGroupFields := nil;
    ClearSelection;
    FGroupColumns.Free;
    FGroupColumns := nil;
    FDataLink.Free;
    FDataLink := nil;
    FFilterStream.Free;
    FFilterStream := nil;
    {remove self from grid list}
    UnRegisterDBTreeListControl(Self);
    inherited Destroy;
  end;
end;

function TCustomdxDBGrid.AddGroupColumn(Column: TdxDBTreeListColumn): Boolean;
begin
  Result := InsertGroupColumn(FGroupColumns.Count, Column);
end;

procedure TCustomdxDBGrid.AssignColumns(ATreeListControl: TCustomdxTreeListControl);
var
  I: Integer;
  ADBGrid: TCustomDxDBGrid;
  Column: TdxDBGridColumn;
begin
  BeginUpdate;
  BeginGrouping;
  try
    ClearGroupColumns;
    inherited AssignColumns(ATreeListControl);
    if ATreeListControl is TCustomdxDBGrid then
    begin
      ADBGrid := TCustomdxDBGrid(ATreeListControl);
      for I := 0 to ADBGrid.GroupColumnCount - 1 do
      begin
        Column := TdxDBGridColumn(ColumnByName(ADBGrid.GroupColumns[i].Name));
        if Column <> nil then Column.GroupIndex := I;
      end;
    end;
  finally
    EndGrouping;
    EndUpdate;
  end;
end;

procedure TCustomdxDBGrid.BeginGrouping;
begin
  if FLockGrouping = 0 then SaveGroupFields;
  Inc(FLockGrouping);
end;

procedure TCustomdxDBGrid.BeginSelection;
begin
  if (LockSelection = 0) and Assigned(OnChangeNodeEx) then
    LoadChangeNodeInfo(FPrevNodeInfo);
  inherited BeginSelection;
end;

function TCustomdxDBGrid.CanAddGroupColumn(Column: TdxDBTreeListColumn): Boolean;
var
  I: Integer;
begin
  Result := False;
  // check Default Fields
  if DefaultFields then Exit;
  if not FRefreshGroupColumns then
    if (Column = nil) or Column.DisableGrouping or
     (Column.Field is TBlobField ) or ((GetVisibleHeaderCount = 1) and Column.Visible) then Exit;
  for i := 0 to FGroupColumns.Count - 1 do
    if (GroupColumns[i] = Column) or
       ((GroupColumns[i].Field = Column.Field)
       and (Column.Field <> nil)) then Exit;
  Result := True;
  if Assigned(FOnAddGroupColumn) then FOnAddGroupColumn(Self, Column, Result);
end;

procedure TCustomdxDBGrid.ClearGroupColumns;
begin
  BeginSorting;
  try
    BeginUpdate;
    try
      BeginGrouping;
      try
        while GroupColumnCount > 0 do DeleteGroupColumn(0);
      finally
        EndGrouping;
      end;
    finally
      EndUpdate;
    end;
  finally
    EndSorting;
  end;
end;

procedure TCustomdxDBGrid.DeleteGroupColumn(Index : Integer);
begin
  if GroupColumnCount = 0 then exit;
  BeginUpdate;
  try
    GroupColumns[Index].Visible := True;
    GroupColumns[Index].Sorted := csNone;
    TdxDBGridColumn(GroupColumns[Index]).FGroupIndex := -1;
    FGroupColumns.Delete(Index);
    RebuildGroupIndexes;
    FlagSmartReload := True;
    if FLockGrouping = 0 then ReLoadGroupList;
  finally
    EndUpdate;
  end;
end;

procedure TCustomdxDBGrid.DeleteSelection;
var
  I: Integer;
  Current: TBookMarkStr;
begin
  inherited DeleteSelection;
  if Datalink.Active then
  with Datalink.Datasource.Dataset do
  begin
    HideEditor;
    ResetFullRefresh;
    DisableControls;
    Current := Bookmark;
    try
      if State in dsEditModes then
      begin
        Cancel;
        Current := Bookmark;
      end;
      // sort bookmark (egoExtMultiSelect)
      for I := BkmList.Count-1 downto 0 do
      begin
        if not IsGridMode and (BkmList.Objects[I] <> nil) and
          TdxTreeListNode(BkmList.Objects[I]).HasChildren then Continue;
        try
          if IsUseBookmarks then
          begin
            if CompareBkm(BkmList[I], Current) = 0 then
              Current := ''; // Check Current
            Bookmark := BkmList[I];
            Delete;
          end
          else
          begin
            if (BkmList.Objects[I] <> nil) and
              (VarType(TdxDBGridNode(BkmList.Objects[I]).Id) <> varEmpty) and
              Locate(KeyField, TdxDBGridNode(BkmList.Objects[I]).Id, []) then
            begin
              if CompareBkm(Bookmark, Current) = 0 then
                Current := ''; // Check Current
              Delete;
            end;
          end;
          BkmList.Delete(I);
        except
          if not (egoExtMultiSelect in Options) then raise;
//          on E: EDBEngineError do ;
        end;
      end;
    finally
      BkmList.Clear;
      try
        if (Current <> '') and BookmarkValid(TBookmark(Current)) then
          Bookmark := Current;
      except
      end;
      EnableControls;
    end;
  end;
end;

procedure TCustomdxDBGrid.EndGrouping;
begin
  Dec(FLockGrouping);
  if FLockGrouping < 0 then FLockGrouping := 0;
  if FLockGrouping = 0 then
  begin
    if FPrevReloadMode = rlGridMode then FlagSmartReload := False;
    if not ChangedGroupFields then RefreshGroupList
    else ReLoadGroupList;
    FPrevReloadMode := rlUnknown;
  end;
  ClearGroupFields;
end;

procedure TCustomdxDBGrid.EndSelection;
begin
  inherited EndSelection;
  if (LockSelection = 0) and Assigned(OnChangeNodeEx) then
    CheckChangeNodeEx;
end;

function TCustomdxDBGrid.FindNodeByKeyValue(const Value: Variant): TdxDBGridNode;

  function Find(ANode: TdxTreeListNode; var Node: TdxDBGridNode): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    if ANode.Count > 0 then
      for I := 0 to ANode.Count - 1 do
        if Find(ANode[I], Node) then
        begin
          Result := True;
          Exit;
        end
        else
    else
      if TdxDBGridNode(ANode).Id = Value then
      begin
        Node := TdxDBGridNode(ANode);
        Result := True;
      end;
  end;

var
  I: Integer;
begin
  Result := nil;
  if not IsGridMode then
  for I := 0 to Count - 1 do
    if Find(Items[I], Result) then Break;
end;

procedure TCustomdxDBGrid.FullRefresh;
begin
  if IsGridMode then
    LayoutChanged
  else
  begin
    ResetFullRefresh;
    RefreshGroupColumns;
  end;
end;

class function TCustomdxDBGrid.GetDefaultColumnClass: TdxDBTreeListColumnClass;
begin
  Result := TdxDBGridColumn;
end;

class function TCustomdxDBGrid.GetDefaultFieldColumnClass(AField: TField): TdxDBTreeListColumnClass;
begin
  if AField.FieldKind = fkLookup then
    Result := DefaultDBGridLookupColumnType.ColumnClass
  else
  if AField.FieldKind = fkData then
    if AField.DataType in [ftUnknown..ftTypedBinary] then
      Result := DefaultDBGridColumnType[AField.DataType].ColumnClass
    else Result := TdxDBGridColumn
  else Result := TdxDBGridColumn;
end;

function TCustomdxDBGrid.GetGroupColumnAt(X, Y: Integer): TdxDBTreeListColumn;
var
  DrawInfo: TdxGridDrawInfo;
  I: Integer;
begin
  Result := nil;
  CalcRectInfo(DrawInfo);
  if PtInRect(DrawInfo.GroupPanelRect, Point(X, Y)) then
    for I := 0 to GroupColumnCount - 1 do
      if PtInRect(GetGroupHeaderRect(I), Point(X, Y)) then
      begin
        Result := GroupColumns[I];
        Break;
      end;
end;

function TCustomdxDBGrid.GetNodeFooterColumnAt(X, Y: Integer): TdxDBTreeListColumn;
begin
  Result := TdxDBTreeListColumn(inherited GetNodeFooterColumnAt(X, Y));
end;

function TCustomdxDBGrid.GetSummaryGroupByName(const AName: string): TdxDBGridSummaryGroup;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to SummaryGroups.Count - 1 do
    if AnsiCompareText(SummaryGroups[I].Name, AName) = 0 then
    begin
      Result := SummaryGroups[I];
      Break;
    end;
end;

function TCustomdxDBGrid.GetSummaryItemAt(X, Y: Integer; var ASummaryGroup: TdxDBGridSummaryGroup;
  var AColumn: TdxDBTreeListColumn; AutoCreate: Boolean): TdxDBGridSummaryItem;
var
  AHitInfo: TdxTreeListHitInfo;
  I, ALevel: Integer;
  ASummaryItem: TdxDBGridSummaryItem;
begin
  Result := nil;
  ASummaryGroup := nil;
  AColumn := nil;
  AHitInfo := GetHitInfo(Point(X, Y));
  if (AHitInfo.hitType = htSummaryNodeFooter) and (AHitInfo.Node <> nil) and
    (AHitInfo.Column <> -1) and (AHitInfo.FooterRow <> -1) then
  begin
    AColumn := Columns[AHitInfo.Column];
    ALevel := GetNodeFooterLevel(AHitInfo.Node, AHitInfo.FooterRow);
    ASummaryGroup := GroupColumns[ALevel].FSummaryGroup;
    if Assigned(ASummaryGroup) then
    begin
      for I := 0 to ASummaryGroup.SummaryItems.Count - 1 do
      begin
        ASummaryItem := ASummaryGroup.SummaryItems[I];
        if ASummaryItem.ColumnName <> '' then
        begin
          if ColumnByName(ASummaryItem.ColumnName) = AColumn then
          begin
            Result := ASummaryItem;
            Break;
          end;
        end;
      end;
      if AutoCreate and (Result = nil) then
      begin
        Result := ASummaryGroup.SummaryItems.Add;
        Result.ColumnName := AColumn.Name;
      end;
    end;
  end;
end;

function TCustomdxDBGrid.InsertGroupColumn(AIndex : Integer; Column:TdxDBTreeListColumn):Boolean;
begin
  Result := False;
  if not CanAddGroupColumn(Column) then Exit;
  if AIndex < 0 then AIndex := 0;
  if AIndex > FGroupColumns.Count then AIndex := FGroupColumns.Count;
  if not IsGridMode and not IsPartialLoad then FlagSmartReload := True;
  FGroupColumns.Insert(AIndex, Column);
  RebuildGroupIndexes;
  BeginUpdate;
  try
    if TdxDBGridColumn(Column).FSorted = csNone then
      TdxDBGridColumn(Column).FSorted := csUp;
    RemoveSortedColumn(Column);
    if not (egoNotHideColumn in OptionsEx) then
      Column.Visible := False;
    if FLockGrouping = 0 then ReLoadGroupList;
  finally
    EndUpdate;
  end;
  Result := True;
end;

function TCustomdxDBGrid.IsAutoFilter: Boolean;
begin
  Result := Filter.Active;
end;

function TCustomdxDBGrid.IsBOF: Boolean;
var
  ADataSet: TDataSet;
begin
  if IsLoadedAll then
    Result := inherited IsBOF
  else
  begin
    if IsPartialLoad then
      Result := FGridBOF and inherited IsBOF 
    else
      if Assigned(DataSource) and Assigned(DataSource.DataSet) then
      begin
        ADataSet := DataSource.DataSet;
        Result := ADataSet.BOF;
      end
      else
        Result := True;
  end;
end;

function TCustomdxDBGrid.IsEOF: Boolean;
var
  ADataSet: TDataSet;  
begin
  if IsLoadedAll then
    Result := inherited IsEOF
  else
  begin
    if IsPartialLoad then
      Result := FGridEOF  and inherited IsEOF
    else
      if Assigned(DataSource) and Assigned(DataSource.DataSet) then
      begin
        ADataSet := DataSource.DataSet;
        Result := ADataSet.EOF;
      end
      else
        Result := True;
  end;
end;

function TCustomdxDBGrid.IsFilterMode: Boolean;
begin
  Result := IsLoadAllRecords and FFiltering;
end;

function TCustomdxDBGrid.IsGridMode: Boolean;
begin
  Result := InternalGridMode and not IsPartialLoad;
end;

function TCustomdxDBGrid.IsLoadAllRecords: Boolean;
begin
  Result := not IsGridMode and not IsPartialLoad;
end;

function TCustomdxDBGrid.IsPartialLoad: Boolean;
begin
  Result := InternalGridMode and PartialLoad;
end;

function TCustomdxDBGrid.PointInFooterPanel(P: TPoint): Boolean;
begin
  Result := GetHitTestInfoAt(P.X, P.Y) = htSummaryFooter;
end;

function TCustomdxDBGrid.PointInGroupPanel(P: TPoint): Boolean;
begin
  Result := GetHitTestInfoAt(P.X, P.Y) = htGroupPanel;
end;

procedure TCustomdxDBGrid.RebuildGroupIndexes;
var
  i : Integer;
begin
  for i := 0 to GroupColumnCount-1 do
    TdxDBGridColumn(GroupColumns[i]).FGroupIndex := i;
end;

procedure TCustomdxDBGrid.RefreshGroupColumns; // after Loaded
var
  List: TStringList;
  I: Integer;
begin
  if (egoSmartRefresh in Options) and not FlagFullRefresh and
     not IsGridMode then
  begin
    BeginUpdate;
    try
      FlagSmartReload := True;
      ReCalcSummary(nil);
    finally
      EndUpdate;
    end;
    Exit;
  end;
  FRefreshGroupColumns := True;
  List := TStringList.Create;
  List.Sorted := True;
  for i := 0 to ColumnCount - 1 do
    if TdxDBGridColumn(Columns[i]).GroupIndex <> -1 then
      List.AddObject(
        Format('%11d', [TdxDBGridColumn(Columns[i]).GroupIndex]),
        Columns[i]);
  try
    if (List.Count > 0) then
    begin
      BeginGrouping;
      try
        for i:= 0 to List.Count - 1 do
          TdxDBGridColumn(List.Objects[i]).GroupIndex :=
            TdxDBGridColumn(List.Objects[i]).GroupIndex;
        FlagSmartReload := False;
      finally
        EndGrouping;
      end;
    end
    else
      if not IsGridMode then ReloadGroupList;
  finally
    List.Free;
    FRefreshGroupColumns := False;
  end;
end;

procedure TCustomdxDBGrid.RefreshSorting;
var
  Column: TdxDBTreeListColumn;
begin
  BeginUpdate;
  try
    Column := SortedColumn;
    if (Column <> nil) and (Column.Sorted <> csNone) then
      DoSortColumn(GroupColumnCount, Column.Index, Column.Sorted = csDown);
    // TODO Refresh Sort Group Nodes
  finally
    EndUpdate;
  end;
end;

procedure TCustomdxDBGrid.ResetFullRefresh;
begin
  FlagFullRefresh := True;
end;

procedure TCustomdxDBGrid.SaveAllToStrings(List : TStrings);
var
  Current : TBookmarkStr;
begin
  if not IsGridMode then
    inherited SaveAllToStrings(List)
  else
  begin
    {Header}
    List.Add(GetHeaderTabText);
    {Records}
    if DataLink.Active then
    with Datalink.Dataset do
    begin
      DisableControls;
      Current := Bookmark;
      {save top pos}
      Datalink.ActiveRecord := 0;
      try
        First;
        while not Eof do
        begin
          List.Add(GetNodeTabText(Items[Datalink.ActiveRecord]));
          Next;
        end;
      finally
        Bookmark := Current;
        EnableControls;
      end;
    end;
  end;
end;

procedure TCustomdxDBGrid.SaveSelectedToStrings(List: TStrings);
var
  Current: TBookmarkStr;
  I: Integer;
begin
  if not IsGridMode or (not (egoMultiSelect in Options)) then
    inherited SaveSelectedToStrings(List)
  else
  begin
    List.Add(GetHeaderTabText);
    if DataLink.Active then
    with Datalink.Dataset do
    begin
      DisableControls;
      Current := Bookmark;
      {save top pos}
      Datalink.ActiveRecord := 0;
      try
        for i := 0 to SelectedCount - 1 do
        begin
          Bookmark := SelectedRows[i];
          List.Add(GetNodeTabText(Items[Datalink.ActiveRecord]));
        end;
      finally
        Bookmark := Current;
        EnableControls;
      end;
    end;
  end;
end;

procedure TCustomdxDBGrid.SelectAll;
var
  bm, Current: TBookmarkStr;
  N1, N2: TdxTreeListNode;
begin
  if not (egoMultiSelect in Options) or
     not DataLink.Active or (Count = 0) then Exit;
  BeginSelection;
  try
    if IsGridMode then
    begin
      with Datalink.Dataset do
      begin
        DisableControls;
        bm := BookMark;
        try
          BkmList.Clear;
          First;
          while not EOF do
          begin
            Current := Bookmark;
            BkmList.Add(Current);
            Next;
          end;
        finally
          BookMark := bm;
          EnableControls;
          Invalidate;
        end;
      end;
    end
    else
    if IsPartialLoad then
    begin
      if IsUseBookmarks or not (FGridBOF and FGridEOF) then
        GetNextNodes(lmAllRecords, rmNone, IsUseBookmarks{selected -> True});
      if not IsUseBookmarks then
      begin
        BkmList.Clear;
        if Count > 0 then SelectNodes(Items[0], Items[Count - 1]);
      end;
    end
    else { Load All Records}
    begin
      BeginUpdate;
      try
        ClearSelection;
        FullExpand;
        if IsUseBookmarks then
        begin
          FSelectAllFlag := True;
          FRefreshGroupList := True;
          try
            RefreshGroupList;
            if not FLocateByNode then FindNodeById;
          finally
            FRefreshGroupList := False;
            FSelectAllFlag := False;
          end;
        end
        else
        begin
          { Start Node }
          N1 := Items[0];
          if not IsExtMultiSelect then
            while N1.Count > 0 do N1 := N1[0];
          { End Node }
          N2 := Items[Count - 1];
          while N2.Count > 0 do N2 := N2[N2.Count - 1];
          SelectNodes(N1, N2);
        end;
      finally
        EndUpdate;
      end;
    end;
  finally
    EndSelection;
  end;
end;

procedure TCustomdxDBGrid.SetFlagSmartReload;
begin
  FlagSmartReload := True;
end;

// protected TCustomDxDBGrid
procedure TCustomdxDBGrid.KeyDown(var Key: Word; Shift: TShiftState);

  function DeletePrompt: Boolean;
  var
    Title, Msg: string;
  begin
    Title := sdxGrTitleConfirm{LoadStr(dxSTitleWarning)};
    Msg := sdxGrDeleteRecordQuestion{LoadStr(dxSDeleteRecordQuestion)};
    if SelectedCount > 0{1} then
       Msg := sdxDeleteMultipleRecordsQuestion{LoadStr(dxSDeleteMultipleRecordsQuestion)};
    Result := not (egoConfirmDelete in Options) or
      (MessageBox(Self.Handle, PChar(Msg), PChar(Title), MB_ICONQUESTION or MB_OKCANCEL) <> IDCANCEL);
  end;

  function IsNeedPost(AUp: Boolean): Boolean;
  begin
    Result := not (IsVertThrough and DoMoveFocusedColumn(AUp, True));
  end;

var
  KeyDownEvent: TKeyEvent;
  D: Integer;
begin
  KeyDownEvent := OnKeyDown;
  OnKeyDown := nil;
  BeginSelection;
  FInKeyDown := True;
  try
    if Assigned(KeyDownEvent) then KeyDownEvent(Self, Key, Shift);
    // check SelectionAnchor
    if IsPartialLoad and (ssShift in Shift) and (SelectionAnchor = nil) then
    begin
      if FDatalink.Active then
        SelectionAnchor := FocusedNode;
    end;

    if not (FSearching and ((Key in [VK_DELETE, VK_BACK, VK_ESCAPE]) or
      ((Key = VK_RETURN) and (Shift*[ssCtrl, ssShift] <> [])))) then
    if FDatalink.Active and CanTreeListAcceptKey(Key, Shift) then
    with FDatalink.DataSet do
    begin
      if ssCtrl in Shift then
        if not NewItemRowActive and (Key = VK_DELETE) and (egoCanDelete in Options) and (egoCanNavigation in Options)
         and not ReadOnly and (FocusedNode <> Nil) and not FocusedNode.HasChildren then
        begin
          if not {$IFDEF DELPHI3}IsEmpty {$else}(FDataLink.RecordCount = 0){$ENDIF}and CanModify and DeletePrompt then
            if SelectedCount > 0{1} then DeleteSelection
            else TdxDBGridNode(FocusedNode).Delete;
          Exit;
        end;
      if (Key = VK_ESCAPE) {and (Self.State <> tsEditing)} then
        FDatalink.Reset
      else
      if IsGridMode then
      begin
        if not (ssShift in Shift) and (Key in [VK_HOME, VK_END]) and
          ((egoRowSelect in Options) or (ssCtrl in Shift)) then
        begin
          case Key of
            VK_HOME: First;
            VK_END: Last;
          end;
          if not (ssCtrl in Shift) then
          begin
            ClearSelection;
            FocusedNode.Selected := True;
          end;
          Exit;
        end
        else
        if Key in [VK_INSERT, VK_DOWN, VK_UP] then
        begin
          if CanModify and (egoEditing in Options)
             and not (egoRowSelect in Options)  then
          case Key of
          VK_INSERT : if not (ssCtrl in Shift) and (egoCanInsert in Options) and (egoCanNavigation in Options) then
            begin
              ClearSelection;
              Insert;
            end;
          VK_DOWN :begin
{              if (State = dsInsert) and
                 not Modified and
                 not FDatalink.FModified and EOF then Exit;}
              if (State = dsInsert) and not Modified and not FDatalink.IsModified then
              begin
                if not EOF then Cancel;
                Exit;
              end;
              inherited KeyDown(Key, Shift);
              if (egoCanAppend in Options) and
                 (egoCanInsert in Options) and EOF and
                 not ((State = dsInsert) and not Modified and
                         not FDatalink.IsModified) then
              begin
                if not FSelecting and (SelectedCount = 1) then ClearSelection;
                Append;
              end;
              Exit;
            end;
          VK_UP : begin
              if (State = dsInsert) and not Modified and EOF and
                 not FDatalink.IsModified then Cancel
              else inherited KeyDown(Key, Shift);
              Exit;
            end;
          end;
        end;
        if (egoMultiSelect in Options) and (ssShift in Shift) and
          (Key in [VK_HOME, VK_END, VK_PRIOR, VK_NEXT]) then
        begin
          case Key of
          VK_HOME: SelectRecords(True, 0);
          VK_END: SelectRecords(False, 0);
          VK_PRIOR: begin
              if FocusedNode <> TopVisibleNode then
                D := FocusedNode.Index - TopVisibleNode.Index
              else D := RowCount - 1;
              if D < 1 then D := 1;
              SelectRecords(True, D);
            end;
          VK_NEXT: begin
              if FocusedNode <> LastNode then
                D := LastNode.Index - FocusedNode.Index
              else D := RowCount - 1;
              if D < 1 then D := 1;
              SelectRecords(False, D);
            end;
          end;
          Exit;
        end;
      end
      else
      begin
        if not (egoRowSelect in Options) and not NewItemRowActive and
          (FocusedNode <> Nil) and (FocusedNode.HasChildren) and
          (Key in [VK_LEFT, VK_RIGHT]) then
        case Key of
        VK_LEFT : if FocusedNode.Expanded then
                     FocusedNode.Expanded := False;
        VK_RIGHT : if not FocusedNode.Expanded then
                     FocusedNode.Expanded := True;
        end;
        if not (egoRowSelect in Options) and CanModify then
        if ((Key = VK_INSERT) and not (ssCtrl in Shift)) and
            (egoCanInsert in Options) and (egoCanNavigation in Options) then
        begin
          if (Self.State = tsEditing) then CloseEditor;
          ClearSelection;
          Insert;
          ShowEditor;
        end;
        case Key of
        VK_UP: if (State in dsEditModes) then
          begin
            if (State = dsInsert) and not Modified and EOF and
                 not FDatalink.IsModified then
            begin
              Cancel;
              FocusedNumber := (GetAbsoluteCount-1);
              Exit;
            end
            else
              if (FocusedNumber = 0) and IsNeedPost(True{Up}) then Post;
          end;
        VK_DOWN: if FocusedNumber = (GetAbsoluteCount-1) then
          begin
            if (State = dsInsert) and
               not Modified and
               not FDatalink.IsModified then Exit;
            if (egoCanAppend in Options) and CanModify and
               (egoCanInsert in Options) and (egoCanNavigation in Options) and
                not ((State = dsInsert) and not Modified and
                       not FDatalink.IsModified) then
            begin
              if not FSelecting and (SelectedCount = 1) then ClearSelection;
              Append;
            end
            else
              if (State in dsEditModes) and IsNeedPost(False{Down}) then Post;
          end;
        end;
      end;
      if (egoRowSelect in Options) and (Key in [VK_LEFT, VK_RIGHT]) and
         (FocusedNode <> Nil) and not FocusedNode.HasChildren then
      begin
        case Key of
        VK_LEFT : PostMessage(self.Handle, WM_HScroll, SB_LINEUP, 0);
        VK_RIGHT : PostMessage(self.Handle, WM_HScroll, SB_LINEDOWN, 0);
        end;
        Key := 0;
      end;
    end;
    inherited KeyDown(Key, Shift);
  finally
    OnKeyDown := KeyDownEvent;
    EndSelection;
    FInKeyDown := False;
  end;
end;

procedure TCustomdxDBGrid.Loaded;
var
  PrevLoadedLayout: Boolean;
begin
  if IsCustomStoring then Exit;
  FLoaded := True;
  BeginUpdate;
  try
    PrevLoadedLayout := LoadedLayout;
    LoadedLayout := True;
    try
      inherited Loaded;
    finally
      LoadedLayout := PrevLoadedLayout;
    end;
    FlagFullRefresh := True;
    try
      RefreshGroupColumns;
    finally
      FlagFullRefresh := False;
    end;
    CheckSortedColumns;
    {RefreshDefWidth before LoadFromReg }
    RefreshDefaultColumnsWidths;
    // Load From Ini/Regsirty
    DoRestoreLayout;
//    if GroupColumnCount = 0 then CheckSorted;
    // calc best panel size
    if IsAutoHeaderPanelRowCount then HeaderPanelBestFit;
  finally
    EndUpdate;
    FLoaded := False;
  end;
end;

procedure TCustomdxDBGrid.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  I: Integer;
  HitInfo: TdxTreeListHitInfo;
begin
  HitInfo := GetHitInfo(Point(X, Y));
  if HitInfo.hitType = htGroupPanel  then
  begin
    if GroupColumnCount > 0 then
    begin
      FDragGroupColumn := nil;
      for I := 0 to GroupColumnCount - 1 do
        if PtInRect(GetGroupHeaderRect(I), Point(X, Y)) then
        begin
          if CanHeaderDragging(GroupColumns[I].Index) then 
            FDragGroupColumn := GroupColumns[I];
          Break;
        end;
      if (Button = mbLeft) and (FDragGroupColumn <> nil) then
      begin
        FGroupColumnPointDragging.X := X;
        FGroupColumnPointDragging.Y := Y;
        FGroupColumnDragFlag := True;
        if ssDouble in Shift then Shift := Shift - [ssDouble];
      end;
    end;
  end;
  if (Button = mbLeft) and (ssDouble in Shift) and
    (State = tsNormal) and (HitInfo.hitType in (NodeHitTests + [htIndicator])) and
    (HitInfo.Node <> nil) and (not HitInfo.Node.HasChildren) then
  begin
    FreeClickTimer;
    {if CanDblClick then }DblClick;
    Exit;
  end;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TCustomdxDBGrid.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if FGroupColumnDragFlag and (FDragGroupColumn <> nil) then
    if ((X < FGroupColumnPointDragging.X - 5) or (X > FGroupColumnPointDragging.X + 5)
     or (Y < FGroupColumnPointDragging.Y - 5) or (Y > FGroupColumnPointDragging.Y + 5)) then
    begin
      FDragAbsoluteHeaderIndex := FDragGroupColumn.Index;
      StartDragHeader(FDragAbsoluteHeaderIndex);
      FGroupColumnDragFlag := False;
    end;
  inherited MouseMove(Shift, X, Y);
end;

procedure TCustomdxDBGrid.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (FDragGroupColumn <> nil) and (State <> tsColumnDragging) and
    (Button = mbLeft) then
  begin
    SetState(tsNormal);
    if IsAutoSort then DoColumnSort(FDragGroupColumn);
  end;

  if (State = tsColumnDragging) then
    EndDragHeader(True);

  FGroupColumnDragFlag := False;
  FDragGroupColumn := nil;

  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TCustomdxDBGrid.Notification(AComponent: TComponent; // TODO remove SmrField!
  Operation: TOperation);
var
  I: Integer;
  NeedLayout, IsKeyField: Boolean;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if (FDataLink <> nil) then
      if (AComponent = DataSource)  then
        DataSource := nil
      else
      if (AComponent is TField) then
      begin
        NeedLayout := False;
        for I := 0 to ColumnCount-1 do
          with TdxDBGridColumn(Columns[I]) do
           if (Field = AComponent) or (FPreviewField = AComponent) or
              ((FKeyField = AComponent) and not IsGridMode and FDataLink.Active) then
           begin
              NeedLayout := True;
              FField := nil;
           end;
        // check KeyField (OnChangeNodeEx)
        IsKeyField := FKeyField = AComponent;
        // reset if needed
        if NeedLayout and Assigned(FDatalink.Dataset) and
           (not FDatalink.Dataset.ControlsDisabled) then
        begin
          if IsKeyField then FKeyField := nil;
          BeginUpdate;
          try
            for I := 0 to ColumnCount-1 do
              with Columns[I] do
                if Field = AComponent then
                  FieldName := FieldName;
            if IsKeyField and (not IsGridMode) and FDataLink.Active then
              LinkActive(FDataLink.DataSet.Active);
            if (FPreviewField = AComponent) then FPreviewField := Nil;
          finally
            EndUpdate;
          end;
        end
        else
          if IsKeyField then FKeyField := nil;
      end;
  end;
end;

procedure TCustomdxDBGrid.WndProc(var Message: TMessage);
var
  P: TPoint;
begin
  if Assigned(FFilterPopupListBox) and FFilterPopupListBox.ListVisible then
  begin
    case Message.Msg of
      WM_KEYDOWN, WM_SYSKEYDOWN, WM_CHAR:
        with Message do
          SendMessage(FFilterPopupListBox.Handle, Msg, WParam, LParam);
      WM_MOUSEFIRST .. WM_MOUSELAST:
        begin
          P := SmallPointToPoint(TWMMouse(Message).Pos);
          MapWindowPoints(Handle, FFilterPopupListBox.Handle, P, 1);
          if PtInRect(FFilterPopupListBox.ClientRect, P) then
          begin
            with Message do
              SendMessage(FFilterPopupListBox.Handle, Msg, WParam, MakeLParam(P.X, P.Y))
          end
          else
          if (Message.Msg = WM_LBUTTONDOWN) or (Message.Msg = WM_LBUTTONUP) or
            (Message.Msg = WM_MOUSEMOVE) then
              inherited;
        end;
      WM_KILLFOCUS, WM_CANCELMODE, CM_CANCELMODE:
        begin
          with TCMCancelMode(Message) do
            if (Sender <> FFilterPopupListBox) then
              FFilterPopupListBox.ClosePopup(False); // TODO global method
        end;
    else
      inherited;
    end;
  end
  else
    inherited;
end;

// Size
function TCustomdxDBGrid.GetGroupHeaderRect(Index: Integer): TRect;
begin
  Result.Left := agpHOfs + Index*(agpHWidht + agpHDeltaX);
  Result.Top := agpHOfs + Index*((HeaderRowHeight div 2) + agpHDeltaY);
  Result.Right := Result.Left + agpHWidht;
  Result.Bottom := Result.Top + HeaderRowHeight;
end;

function TCustomdxDBGrid.GetGroupPanelHeight: Integer;
begin
  Result := 0;
  if FGroupPanelVisible then
    Result := CalcGroupPanelHeight(GroupColumnCount);
end;

function TCustomdxDBGrid.GetIndentWidth: Integer;
begin
  Result := GroupColumnCount * Indent;
end;

function TCustomdxDBGrid.GetScrollVertGridRect: TRect;
var
  RNode: TRect;
begin
  Result := inherited GetScrollVertGridRect;
  if IsGridMode and not (IsRowAutoHeight or (IsShowPreview and IsAutoCalcPreviewLines)) then
  begin
    if Count > 0 then
    begin
      RNode := GetRectNode(Items[Count - 1]);
      if Result.Bottom > RNode.Bottom then Result.Bottom := RNode.Bottom;
    end;
  end;
end;

function TCustomdxDBGrid.GetVisibleRowCount: Integer;
begin
  if IsGridMode then Result := RowCount
  else Result := inherited GetVisibleRowCount;
end;

procedure TCustomdxDBGrid.GetVScrollInfo(var Min, Max, Pos : Integer; var Page, Mask : UINT);
begin
  if IsGridMode then
  begin
    Min := 0;
    Page := 0;
    Max :=  4;
//   Pos := 0;

    if FDatalink.Active and FDatalink.DataSet.Active and
       HandleAllocated then
    with FDatalink.DataSet do
    begin
    {$IFDEF DELPHI3}
      if IsSequenced then
      begin
        Min := 1;
        Page := Self.RowCount;
        Max := RecordCount + Integer(Page) -1;
        if FDatalink.DataSet.State in [dsInactive, dsBrowse, dsEdit] then
        try
          if FDatalink.DataSet.RecNo <> -1 then
            Pos := FDatalink.DataSet.RecNo;
        except
        end;
      end
      else
    {$ENDIF}
      begin
        Min := 0;
        Page := 0;
        Max := 4;
        if BOF then Pos := 0
        else if EOF then Pos := 4
        else Pos := 2;
      end;
    end;
  end
  else
    inherited GetVScrollInfo(Min, Max, Pos, Page, Mask);
end;

procedure TCustomdxDBGrid.UpdateRowCount;
var
  DrawInfo: TdxGridDrawInfo;
  H, RealH, RHeight: Integer;
begin
  inherited UpdateRowCount;
  if IsGridMode and FDataLink.Active then
  begin
    CalcRectInfo(DrawInfo);
    H := DrawInfo.CellsRect.Bottom - DrawInfo.CellsRect.Top;
    if not (IsRowAutoHeight or (IsShowPreview and IsAutoCalcPreviewLines)) then
    begin
      RHeight := GetRowHeight(FocusedNode, DefaultRowHeight, True{ReCalc});
      FRowCount := (H div RHeight);
      FVisibleRowCount := (H div RHeight) + Byte((H mod RHeight) <> 0);
    end
    else
    begin
      RealH := CalcRowCount(TopVisibleNode, H, FRowCount, FVisibleRowCount);
      if (RealH < H) then
      begin
        BeginUpdate;
        try
          while True do
          begin
            with FDataLink do
            begin
              BufferCount := Self.Count + 1; // NodeCount
              if RecordCount < BufferCount then Break;
              Add;
            end;
            RealH := CalcRowCount(TopVisibleNode, H, FRowCount, FVisibleRowCount);
            if (RealH >= H) or (FVisibleRowCount > FRowCount) then
            begin
              if (FRowCount > 0) and (FVisibleRowCount > FRowCount) then
              begin
                Self.Items[Self.Count - 1].Free;
                FDataLink.BufferCount := Self.Count;
              end;
              Break;
            end;
          end;
        finally
          CancelUpdate;
        end;
      end;
    end;
  end;
  if FVisibleRowCount < 1 then FVisibleRowCount := 1;
  if FRowCount < 1 then FRowCount := 1;
end;

procedure TCustomdxDBGrid.UpdateScrollBars;

  procedure SetNodeCount(Value: Integer);
  var
    OldNodeCount, i: Integer;
  begin
    OldNodeCount := GetAbsoluteCount;
    if Value = OldNodeCount then Exit;
    if OldNodeCount < Value then
      for i:= 0 to (Value - OldNodeCount)-1 do Add
    else
      for i:= 0 to (OldNodeCount-Value)-1 do Items[Count-1].Free;
    Invalidate;
  end;

begin
  inherited UpdateScrollBars;
  if FUpdateBufferCount then Exit;
  FUpdateBufferCount := True;
  if IsGridMode then
  with FDataLink do
  begin
    if not Active or (RecordCount = 0) or not HandleAllocated then
      SetNodeCount(1)
    else
    begin
      if FDataLink.BufferCount <> RowCount then
          FDataLink.BufferCount := RowCount;
      if FocusedNumber <> FDatalink.ActiveRecord then CloseEditor;
      SetNodeCount(RecordCount);
    end;
    UpdateActive;
  end
  else
    if FDataLink.Active then
      FDataLink.BufferCount := 1;
  FUpdateBufferCount := False;
end;

// Drag & Drop & Customizing
procedure TCustomdxDBGrid.CalcArrowsPos(var P: TPoint; PPosInfo: Pointer; IsBand: Boolean;
  DownIndex, DragIndex: Integer);
var
  ArrowDelta: Integer;
  Pos: TPoint;
  Col: Integer;
  R: TRect;
begin
  Pos := ScreenToClient(P);
  if not IsBand and ShowGroupPanel and PointInGroupPanel(POS) then
  begin
    SetInfo(PPosInfo, -1, -1, -1, -1);
    P := Point(-100, -100);
    ArrowDelta := arWidth div 2;
    Col := GetColumnArrowsPos(Pos);
    if (DragIndex <> -1) and (TdxDBGridColumn(Columns[DragIndex]).GroupIndex = -1) and
      not CanAddGroupColumn(Columns[DragIndex]) then Exit;
    R := GetGroupHeaderRect(Col);
    Pos.X := R.Left - ArrowDelta;
    Pos.Y := R.Top - arHeight;
    P := ClientToScreen(Pos);
  end
  else
    inherited CalcArrowsPos(P, PPosInfo, IsBand, DownIndex, DragIndex);
end;

procedure TCustomdxDBGrid.DoEndDragGroupColumn(Column: TdxDBTreeListColumn; NewGroupIndex: Integer; var Accept: Boolean);
begin
  if Assigned(FOnEndDragGroupColumn) then
    FOnEndDragGroupColumn(Self, Column, NewGroupIndex, Accept);
end;

procedure TCustomdxDBGrid.EndDragHeader(Flag: Boolean);
var
  P, P1 : TPoint;
  Column, Index: Integer;
  Col: TdxDBGridColumn{TdxDBTreeListColumn};
  PrevVisivle, Accept: Boolean;
begin
  try
    if Flag then
    begin
      GetCursorPos(P);
      P1 := P;
      P := ScreenToClient(P);
      if ShowGroupPanel and not PointInCustomizingForm(P1) and
        PointInGroupPanel(P) then
      begin
        if FDragAbsoluteHeaderIndex <> -1 then
        begin
          Col := TdxDBGridColumn(Columns[FDragAbsoluteHeaderIndex]);
          inherited EndDragHeader(False);
          Index := GetColumnArrowsPos(P);
          if Col <> nil then
          begin
            if (Col.GroupIndex <> -1) and (Index >= GroupColumnCount) then
               Index := GroupColumnCount - 1;
            Accept := True;
            DoEndDragGroupColumn(Col, Index, Accept);
            if Accept then
            begin
              Col.GroupIndex := Index;
              if not Col.Visible and (Col.GroupIndex = -1) then // from customize form
              begin
                if Assigned(OnShowHeader) then OnShowHeader(Self, Col, -1, -1, -1);
              end;
            end;
          end;
          Exit;
        end;
      end
      else if FDragGroupColumn <> nil then
      begin
        Column := FGroupColumns.IndexOf(FDragGroupColumn);
        if Column <> -1 then
        begin
          Col := GroupColumns[Column];
          PrevVisivle := Col.Visible;
          inherited EndDragHeader(Flag);
          DeleteGroupColumn(Column);
          // check sorted
          CheckSorted;
          if not PrevVisivle and PointInCustomizingForm(P1) and not Col.DisableCustomizing and
             not ((GetVisibleHeaderCount = 1) and (VisibleColumns[0] = Col)) then Col.Visible := False;
          if not Col.Visible then
          begin
            if Assigned(OnHideHeader) then OnHideHeader(Self, Col);
          end;
          Exit;
        end;
      end;
    end;
    inherited EndDragHeader(Flag);
  finally
    FDragGroupColumn := nil;
  end;
end;

function TCustomdxDBGrid.GetColumnArrowsPos(Pos: TPoint): Integer;
var
  R: TRect;
  I: Integer;
begin
  Result := 0;
  for I := 0 to GroupColumnCount - 1 do
  begin
    R := GetGroupHeaderRect(I);
    if Pos.X < ((R.Right + R.Left) div 2) then
    begin
      Result := I;
      Break;
    end;
    Inc(Result);
  end;
end;

procedure TCustomdxDBGrid.GetDragImageCursor(P: TPoint; var ADragCursor: TCursor);
var
  Column: TdxDBGridColumn{TdxDBTreeListColumn};
begin
  inherited GetDragImageCursor(p, ADragCursor);
  if ShowGroupPanel and not PointInCustomizingForm(ClientToScreen(P)) then
  begin
    if PointInGroupPanel(P) then
    begin
      ADragCursor := Cursor;
      if (FDragAbsoluteHeaderIndex <> -1) then
      begin
        Column := TdxDBGridColumn(Columns[FDragAbsoluteHeaderIndex]);
        if (Column.GroupIndex = -1) and not CanAddGroupColumn(Column) and
          ((GroupColumnCount >= 0) and (FDragGroupColumn = nil)) then
            ADragCursor := crdxTreeListDeleteCursor;
      end;
    end;
  end;
end;

function TCustomdxDBGrid.GetIsCustomizing: Boolean;
begin
  Result := inherited GetIsCustomizing;
//  if FDragGroupColumn <> Nil then Result := True;
end;

function TCustomdxDBGrid.IsHeaderCustomizing: Boolean;
begin
  Result := inherited IsHeaderCustomizing;
  if FDragGroupColumn <> nil then
    Result := True;
end;

procedure TCustomdxDBGrid.HideHeader(AbsoluteIndex: Integer);
begin
  inherited HideHeader(AbsoluteIndex);
  if Assigned(FOnHideColumnEvent) then FOnHideColumnEvent(Self, Columns[AbsoluteIndex]);
end;

function TCustomdxDBGrid.IsLastNode(ANode: TdxTreeListNode) : Boolean;
begin
  Result := inherited IsLastNode(ANode);
  if IsGridMode and Datalink.Active then
    Result := Datalink.DataSet.EOF
  else
    if IsPartialLoad then Result := Result and FGridEOF;
end;

function TCustomdxDBGrid.IsTopNode(ANode: TdxTreeListNode) : Boolean;
begin
  Result := inherited IsTopNode(ANode);
  if IsGridMode and Datalink.Active then
    Result := Datalink.DataSet.BOF
  else
    if IsPartialLoad then Result := Result and FGridBOF;
end;

procedure TCustomdxDBGrid.ShowColumnHeader(BandIndex, RowIndex, ColIndex, AbsoluteIndex: Integer);
begin
  inherited ShowColumnHeader(BandIndex, RowIndex, ColIndex, AbsoluteIndex);
  if Assigned(FOnShowColumnEvent) then OnShowColumn(Self, Columns[AbsoluteIndex]);
end;

// Paint
function TCustomdxDBGrid.AssignedDrawCellEvent(ANode: TdxTreeListNode; AbsoluteIndex: Integer): Boolean;
begin
  Result := inherited AssignedDrawCellEvent(ANode, AbsoluteIndex) or
    Assigned(FOnCustomDraw);
end;

procedure TCustomdxDBGrid.DrawGroupPanel(ACanvas: TCanvas; ARect: TRect; HeaderBrush, PanelBrush: HBRUSH);

  procedure DrawLines;
  var
    Points: PIntArray;
    Strokes: PIntArray;
    MaxLines, I, J: Integer;
    R1, R2: TRect;
  begin
    if GroupColumnCount = 0 then Exit;
    MaxLines := (GroupColumnCount - 1);
    if MaxLines > 0 then
    begin
      Points := AllocMem(MaxLines * SizeOf(TPoint) * 3);
      Strokes := AllocMem(MaxLines * SizeOf(Integer));
      for I := 0 to MaxLines  - 1 do Strokes^[I] := 3;
      for I := 0 to MaxLines - 1 do
      begin
        R1 := GetGroupHeaderRect(I);
        R2 := GetGroupHeaderRect(I + 1);
        J := I * 6;
        Points^[J] := (R1.Left + R1.Right) div 2;
        Points^[J + 1] := R1.Bottom - 1;
        Points^[J + 2] := Points^[J];
        Points^[J + 3] := Points^[J + 1] + 3;
        Points^[J + 4] := R2.Left + 1;
        Points^[J + 5] := Points^[J + 1] + 3;
      end;
      ACanvas.Pen.Color := dxclGroupPanelLine{clBlack};
      PolyPolyLine(ACanvas.Handle, Points^, Strokes^,  MaxLines);
      FreeMem(Strokes);
      FreeMem(Points);
    end;
  end;

var
  FText: string;
  I: Integer;
begin
  with ACanvas do
  begin
    // Custom Draw
    if Assigned(FOnBackgroundDrawEvent) then
      FOnBackgroundDrawEvent(Self, ACanvas, ARect)
    else
    begin
      if (LookAndFeel = lfUltraFlat) and (FGroupPanelColor = clBtnShadow){Default} then
        Windows.FillRect(ACanvas.Handle, ARect, PanelBrush)
      else
      begin
        Brush.Color := FGroupPanelColor;
        FillRect(ARect);
      end;
      if GroupColumnCount = 0 then
      begin
        Font.Assign(Self.HeaderFont);
        Font.Color := FGroupPanelFontColor;
        FText := ' ' + sdxPanelText;
        SetBkMode(Handle, TRANSPARENT);
        DrawText(Handle, PChar(FText), Length(FText), ARect,
          DT_LEFT or DT_EXPANDTABS or DT_NOPREFIX or DT_SINGLELINE or DT_VCENTER);
      end;
    end;
    DrawLines;
    Font.Assign(Self.HeaderFont);
    for I := 0 to GroupColumnCount - 1 do
    begin
      ARect := GetGroupHeaderRect(I);
      if RectVisible(Handle, ARect) then
      begin
        DrawBandEx(Handle, ARect, ARect, HeaderBrush, DrawBitmap,
          GroupColumns[I].Caption, False{ADown}, False{AMultiLine},
          taLeftJustify, GroupColumns[I].Sorted, GetHeaderGlyph(GroupColumns[I].Index), hbNormal,
          LookAndFeel, []{GetHeaderDropDownButtonState(GroupColumns[I].Index) TODO });
      end;
    end;
  end;
end;

procedure TCustomdxDBGrid.DoDrawCell(ACanvas: TCanvas; var ARect: TRect; ANode: TdxTreeListNode; AIndex: Integer; ASelected, AFocused: Boolean;
  ANewItemRow: Boolean; ALeftEdge, ARightEdge: Boolean; ABrush: HBRUSH;
  var AText: string; var AColor: TColor; AFont: TFont; var AAlignment: TAlignment; var ADone: Boolean);
var
  Column: TdxDBTreeListColumn;
begin
  if (ANode <> nil) and ANode.HasChildren then
    AIndex := GroupColumns[ANode.Level].Index;
  // obsolete
  Column := Columns[AIndex];
  if Assigned(FOnCustomDraw) then FOnCustomDraw(Self, ACanvas, ARect, ANode, Column, AText,
    AFont, AColor, ASelected, AFocused, ADone);
  if ADone then Exit;
  inherited DoDrawCell(ACanvas, ARect, ANode, AIndex, ASelected, AFocused,
    ANewItemRow, ALeftEdge, ARightEdge, ABrush, AText, AColor, AFont, AAlignment, ADone);
end;

procedure TCustomdxDBGrid.DoHeaderClick(AbsoluteIndex: Integer);
begin
  if Assigned(FOnColumnClick) then FOnColumnClick(Self, Columns[AbsoluteIndex]);
  inherited DoHeaderClick(AbsoluteIndex);
end;

procedure TCustomdxDBGrid.DoHeaderDropDownButtonClick(AbsoluteIndex: Integer);
var
  P: TPoint;
  R: TRect;

  function GetHeaderRect: TRect;
  var
    DrawInfo: TdxGridDrawInfo;
    I: Integer;
  begin
    SetRectEmpty(Result);
    CalcDrawInfo(DrawInfo);
    try
      with DrawInfo do
        for I := 0 to HeaderCount - 1 do
          if HeadersInfo^[I].AbsoluteIndex = AbsoluteIndex then
          begin
            Result := HeadersInfo^[I].HeaderRect;
            Break;
          end;
    finally
      FreeDrawInfo(DrawInfo);
    end;
  end;

  procedure LoadItems;
  var
    I, J: Integer;
    FlagNullExist: Boolean;

    procedure AddValue(const V: Variant; const S: string);
    begin
      if VarIsEmpty(V) or VarIsNull(V) or ((VarType(V) = varString) and (V = '')) then
        FlagNullExist := True
      else
        FFilterPopupListBox.FilterValues.AddValue(S, V, not IsAutoFilterValuesLoad);
    end;

    procedure LoadValueFromNode(Node: TdxTreeListNode);
    var
      I: Integer;
      S: string;
      V: Variant;
    begin
      if Node.Count > 0 then
        for I := 0 to Node.Count - 1 do
          LoadValueFromNode(Node[I])
      else
      begin
        TdxDBGridColumn(FFilterPopupListBox.Column).GetFilterValues(Node, V, S);
        AddValue(V, S);
      end;
    end;

  var
    V: Variant;
    S: string;
    AColumnCriteria: TdxDBGridFilterColumnCriteria;
    ARepeatEnumeration: Boolean;
  begin
    // Load Filter Values
    FFilterPopupListBox.FilterValues.Clear;
    FFilterPopupListBox.FilterValues.AnsiSort := IsAnsiSort;
    FFilterPopupListBox.FilterValues.CaseInsensitive := Filter.CaseInsensitive;
    FFilterPopupListBox.FilterValues.MaxCount := Filter.MaxDropDownCount;
    FlagNullExist := False;
    if IsAutoFilterValuesLoad then
    begin
       for I := 0 to Count - 1 do
         LoadValueFromNode(Items[I]);
       for I := 0 to FHiddenList.Count - 1 do
         LoadValueFromNode(TdxTreeListNode(FHiddenList[I]));
    end
    else // Custom Event
    begin
      if Assigned(FOnEnumFilterValues) then
      begin
        repeat
          ARepeatEnumeration := True;
          S := '';
          V := Null;
          FOnEnumFilterValues(Self, FFilterPopupListBox.Column, V, S, ARepeatEnumeration);
          AddValue(V, S);
        until not ARepeatEnumeration;
      end;
    end;
    // ListBox Items
    FFilterPopupListBox.Items.Clear;
    FFilterPopupListBox.Items.Assign(FFilterPopupListBox.FilterValues);
    FFilterPopupListBox.Items.Insert(0, dxSFilterBoxAllCaption);
    FFilterPopupListBox.Items.Insert(1, dxSFilterBoxCustomCaption);
    J := 2;
    if FlagNullExist then
    begin
      FFilterPopupListBox.Items.Insert(2, dxSFilterBoxBlanksCaption);
      FFilterPopupListBox.Items.Insert(3, dxSFilterBoxNonBlanksCaption);
      Inc(J, 2);
    end;
    // Set Index
    with FFilterPopupListBox do
    begin
      AColumnCriteria := Grid.Filter.GetFilterColumnCriteria(FFilterPopupListBox.Column, V);
      case AColumnCriteria of
        fcBlanks:
          if FlagNullExist then ItemIndex := 2;
        fcNonBlanks:
          if FlagNullExist then ItemIndex := 3;
        fcValue:
          begin
            for I := 0 to FilterValues.Count - 1 do
              if PVariant(FilterValues.Objects[I])^ = V then
              begin
                ItemIndex := J + I;
                Break;
              end;
          end;
        fcCustom:
          ItemIndex := 1;
      else
        ItemIndex := 0; // All
      end;
    end;
  end;

  procedure PrepareFilterPopupListBox;
  var
    I, W, TW: Integer;
  begin
    with FFilterPopupListBox do
    begin
      Visible := False;
      Parent := Self;
      Column := Self.Columns[AbsoluteIndex];
      IntegralHeight := True;
      Color := Self.Color;
      Font := Self.Font;
      if LookAndFeel = lfUltraFlat then
        PopupBorderStyle := pbSingle
      else
        PopupBorderStyle := pbFlat;
      LoadItems;
      // check width, height
      if (Grid.Filter.DropDownCount > 0) and (Items.Count >= Grid.Filter.DropDownCount) then
        ClientHeight := Grid.Filter.DropDownCount * RealItemHeight
      else
        ClientHeight := Items.Count * RealItemHeight;
      // calc width
      Width := R.Right - R.Left;
      if Filter.DropDownWidth <> 0 then
        W := Filter.DropDownWidth
      else
      begin
        W := ClientWidth;
        for I := 0 to Items.Count - 1 do
        begin
          TW := Canvas.TextWidth(Items[I]);
          if TW > W then W := TW;
        end;
      end;
      ClientWidth := W + 4;
      if Width < W then Width := W;
    end;
  end;

  procedure ShowFilterPopupListBox;
  begin
    P := ClientToScreen(Point(R.Left, R.Bottom));
    with FFilterPopupListBox do
    begin
      // Calc Position
      CheckScreenPosition(P, Width, Height, R.Bottom - R.Top);
      SetBounds(P.X, P.Y, Width, Height);
      SetWindowPos(Handle, HWND_TOP, Left, Top, 0, 0,
        SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
      ListVisible := True;
    end;
  end;

begin
  R := GetHeaderRect;
  if not IsRectEmpty(R) then
  begin
    if FFilterPopupListBox = nil then
      FFilterPopupListBox := TdxDBGridFilterPopupListBox.Create(Self);
    PrepareFilterPopupListBox;
    ShowFilterPopupListBox;
  end;
end;

procedure TCustomdxDBGrid.DoStatusCloseButtonClick;
begin
  Filter.Clear;
end;

function TCustomdxDBGrid.GetGridColor(ABrushColor : TColor) : TColor;
begin
  Result := inherited GetGridColor(ABrushColor);
  if GroupColumnCount = 0 {IsGridMode} then
  begin
    Result := dxclTreeLineHighColor;
    if (ColorToRGB(ABrushColor) = dxclTreeLineHighColor) or
      (GetSysColor(COLOR_BTNFACE) = 0) {HighContrastBlack} or
      (GetSysColor(COLOR_BTNFACE) = $00FFFFFF) {HighContrastWhite} then
      Result := dxclTreeLineShadowColor;
  end;
  if GridLineColor <> clNone then
    Result := GridLineColor;
end;

procedure TCustomdxDBGrid.PrepareNode(ANode: TdxTreeListNode);
begin
  if FLockPrepareNode = 0 then
    if IsGridMode and FDataLink.Active then
    begin
      FOldActiveRecord := FDataLink.ActiveRecord;
      FDataLink.ActiveRecord := ANode.Index;
    end;
  Inc(FLockPrepareNode);
end;

procedure TCustomdxDBGrid.UnPrepareNode(ANode: TdxTreeListNode);
begin
  Dec(FLockPrepareNode);
  if FLockPrepareNode = 0 then
    if IsGridMode and FDataLink.Active then
      FDataLink.ActiveRecord := FOldActiveRecord;
end;

// Editor
function TCustomdxDBGrid.CanEditShow: Boolean;
begin
  Result := inherited CanEditShow and not FocusedNode.HasChildren;
end;

procedure TCustomdxDBGrid.DoBeforeEditing(Node : TdxTreeListNode; var AllowEditing: Boolean);
begin
  if Node.HasChildren then
    AllowEditing := False
  else
    inherited DoBeforeEditing(Node, AllowEditing);
end;

function TCustomdxDBGrid.CanFullMultiSelect: Boolean;
begin
  Result := not IsGridMode;
end;

function TCustomdxDBGrid.CanNodeSelected(ANode: TdxTreeListNode): Boolean;
var
  Node: TdxTreeListNode;
begin
  Result := True;
  if Assigned(OnCanNodeSelected) then OnCanNodeSelected(Self, ANode, Result);
  if Result and not IsGridMode and not IsExtMultiSelect then
  begin
    Node := GetFirstSelectedNode;
    if Node <> nil then
      Result := not Node.HasChildren and not ANode.HasChildren;
  end;
{  if Result then
  if not IsGridMode and not (egoExtMultiSelect in Options) then
    if GetSelectedCount > 0 then
       Result := not ANode.HasChildren and
                 not (SelectedNodes[0].HasChildren);}
end;

function TCustomdxDBGrid.CompareSelectionAnchor(ANode: TdxTreeListNode) : Integer;
begin
  if IsGridMode and (DataLink.Active) then
    Result := CompareBkm(Datalink.DataSource.DataSet.Bookmark, FBkmSelectionAnchor)
  else Result := inherited CompareSelectionAnchor(ANode);
end;

procedure TCustomdxDBGrid.DoSelectedCountChange;
begin
  inherited DoSelectedCountChange;
  if not (csDestroying in ComponentState) and (LockSelection = 0) and
    Assigned(OnChangeNodeEx) then
  begin
    CheckChangeNodeEx;
    LoadChangeNodeInfo(FPrevNodeInfo);
  end;
end;

procedure TCustomdxDBGrid.InvalidateSelection;
var
  i : Integer;
begin
  if IsGridMode then
  begin
    if SelectedCount = 0 then
      if FocusedNode <> nil then
        InvalidateRect(GetRectNode(FocusedNode))
      else
    else
    for i := 0 to Count - 1 do
      if IsNodeSelected(Items[i]) then
        InvalidateRect(GetRectNode(Items[i]));
  end
  else inherited InvalidateSelection;
end;

function TCustomdxDBGrid.IsNodeSelected(ANode:TdxTreeListNode):Boolean;
var
  OldActive, Index : Integer;
begin
  Result := False;
  if GetSelectedCount = 0 then Exit;
  if not IsGridMode then
  begin
//    Result := BkmList.IndexOfObject(ANode) <> -1;
    if IsUseBookmarks then
      Result := BkmList.IndexOfObject(ANode) <> -1
    else Result := FindSelectedNode(ANode, Index); {Sorted List}
  end
  else
  if DataLink.Active then
  begin
    if ANode.Index = -1 then Exit;
    OldActive := DataLink.ActiveRecord;
    try
      DataLink.ActiveRecord := ANode.Index;
      Result := FindBkm(Datalink.Datasource.Dataset.Bookmark, Index);
    finally
      DataLink.ActiveRecord := OldActive;
    end;
  end;
end;

procedure TCustomdxDBGrid.NodeSelected(ANode:TdxTreeListNode; ASelected : Boolean);
var
  Index: Integer;
  Current: TBookmarkStr;
  OldActive : Integer;
begin
  if not (egoMultiSelect in Options) or not DataLink.Active then Exit;

  if IsUseBookmarks then
  begin
    if not ((egoExtMultiSelect in Options) and (GroupColumnCount > 0)) then
    begin
      if not ANode.Focused and ASelected and not IsGridMode then Exit;

      if not ANode.Focused then
      begin
        OldActive := 0;
        try
          if IsGridMode then
          begin
            OldActive := DataLink.ActiveRecord;
            DataLink.ActiveRecord := ANode.Index;
          end;
          Current := Datalink.Datasource.Dataset.Bookmark;
        finally
          if IsGridMode then
            DataLink.ActiveRecord := OldActive;
        end;
      end
      else
        Current := Datalink.Datasource.Dataset.Bookmark;

      if ASelected and not CanNodeSelected(ANode) then Exit;
      {***}
      if not IsGridMode and not ASelected then
      begin
        Index := BkmList.IndexOfObject(ANode);
        if (Index = -1) then Exit;
      end
      else
      {***}
      if (Length(Current) = 0) or (FindBkm(Current, Index) = ASelected) then Exit;
    end
    else
    begin
      if ASelected and not CanNodeSelected(ANode) then Exit;
      Current := Datalink.Datasource.Dataset.Bookmark;
      Index := BkmList.IndexOfObject(ANode);
      if (Index <> -1) = ASelected then Exit;
      if ASelected then FindBkm(Current, Index);
      if Index = -1 then Index := 0;
    end;

    if ASelected then
    begin
      BkmList.Insert(Index, Current);
      if not IsGridMode then BkmList.Objects[Index] := ANode
    end
    else
      if Index <> -1 then BkmList.Delete(Index);
  end
  else
  begin
    if ASelected then
    begin
      if not CanNodeSelected(ANode) then Exit;
      if not FindSelectedNode(ANode, Index) then
        BkmList.InsertObject(Index, '', ANode);
    end
    else
      if FindSelectedNode(ANode, Index) then
        BkmList.Delete(Index);
  end;
  UpdateNode(ANode, False {no Below});
  inherited NodeSelected(ANode, ASelected);
end;

procedure TCustomdxDBGrid.SelectNodes(N1, N2: TdxTreeListNode);
begin
  if (Datalink.Dataset.State in dsEditModes) or not IsMultiSelect then Exit;
  if IsPartialLoad and IsUseBookmarks then
  begin
    BeginSelection;
    try
      SaveBookmarks;
      try
        GetNextNodes(lmCurrent, rmNone, True)
      finally
        ClearBookmarks;
      end;
    finally
      EndSelection;
    end;
  end
  else
    inherited SelectNodes(N1, N2);
end;

procedure TCustomdxDBGrid.SelectRecords(ADirectionUp: Boolean; ACount: Integer);
var
  bm, Current: TBookmarkStr;
  I: Integer;
  FlagFound: Boolean;
begin
  if not (egoMultiSelect in Options) or
     not DataLink.Active or (Count = 0) or
     not IsGridMode then Exit;
  BeginSelection;
  try
    with Datalink.Dataset do
    begin
      DisableControls;
      bm := Bookmark;
      if Length(FBkmSelectionAnchor) = 0 then
        FBkmSelectionAnchor := BookMark;
      try
        BkmList.Clear;
        if ACount = 0 then
        begin
          BookMark := FBkmSelectionAnchor;
          repeat
            Current := Bookmark;
            if ADirectionUp then
            begin
              BkmList.Insert(0, Current);
              Prior;
            end
            else
            begin
              BkmList.Add(Current);
              Next;
            end;
          until (ADirectionUp and Bof) or (not ADirectionUp and Eof);
        end
        else
        begin
          I := 0;
          if ADirectionUp and (CompareBkm(FBkmSelectionAnchor, bm) < 0) then
          begin
            while (CompareBkm(FBkmSelectionAnchor, Bookmark) <> 0) and (I < ACount) do
            begin
              Prior;
              Inc(I);
            end;
            if I = ACount then
            begin
              bm := Bookmark;
              Bookmark := FBkmSelectionAnchor;
              repeat
                Current := Bookmark;
                BkmList.Add(Current);
                if (CompareBkm(Current, bm) = 0) or Eof then Break;
                Next;
              until False;
            end
            else
            begin
              repeat
                Current := Bookmark;
                BkmList.Insert(0, Current);
                Inc(I);
                if (I > ACount) or Bof then Break;
                Prior;
              until False;
            end;
          end
          else
          if not ADirectionUp and (CompareBkm(bm, FBkmSelectionAnchor) < 0) then
          begin
            while (CompareBkm(FBkmSelectionAnchor, Bookmark) <> 0) and (I < ACount) do
            begin
              Next;
              Inc(I);
            end;
            if I = ACount then
            begin
              bm := Bookmark;
              Bookmark := FBkmSelectionAnchor;
              repeat
                Current := Bookmark;
                BkmList.Insert(0, Current);
                if (CompareBkm(Current, bm) = 0) or Bof then Break;
                Prior;
              until False;
            end
            else
            begin
              repeat
                Current := Bookmark;
                BkmList.Add(Current);
                Inc(I);
                if (I > ACount) or Eof then Break;
                Next;
              until False;
            end;
          end
          else
          begin
            FlagFound := False;
            Bookmark := FBkmSelectionAnchor;
            repeat
              Current := Bookmark;
              if ADirectionUp then
                BkmList.Insert(0, Current)
              else BkmList.Add(Current);
              if (CompareBkm(Current, bm) = 0) then FlagFound := True;
              if FlagFound then Inc(I);
              if (I > ACount) then Break;
              if ADirectionUp then
                Prior
              else Next;
            until ((ADirectionUp and Bof) or (not ADirectionUp and Eof));
          end;
        end;
        FSelecting := True;
      finally
        // check empty DataSet
        if (BkmList.Count = 1) and (Length(BkmList[0]) = 0) then BkmList.Clear; 
        EnableControls;
        Invalidate;
      end;
    end;
  finally
    EndSelection;
  end;
end;

procedure TCustomdxDBGrid.SetSelectionAnchor(ANode : TdxTreeListNode);
var
  OldIndex : Integer;
begin
  if IsGridMode and (DataLink.Active) then
  begin
    if (ANode <> nil) then
    begin
      OldIndex := DataLink.ActiveRecord;
      try
        DataLink.ActiveRecord := ANode.Index;
        FBkmSelectionAnchor := Datalink.DataSource.DataSet.Bookmark;
        inherited SetSelectionAnchor(Nil);
      finally
        DataLink.ActiveRecord := OldIndex;
      end;
    end
    else FBkmSelectionAnchor := '';
  end
  else
  begin
    if IsPartialLoad and DataLink.Active then
    begin
      FBkmSelectionAnchor := Datalink.DataSource.DataSet.Bookmark;
//      if ANode = nil then ANode := FocusedNode;
    end;
    inherited SetSelectionAnchor(ANode);
  end;
end;

// Sorting
procedure TCustomdxDBGrid.AddSortedColumn(Column: TdxTreeListColumn);
begin
  if (Column <> nil) and (Column.Sorted <> csNone) and
    (TdxDBGridColumn(Column).GroupIndex = -1) then
      inherited AddSortedColumn(Column);
end;

function TCustomdxDBGrid.CanColumnSorting(Column: TdxTreeListColumn): Boolean;
begin
  Result := True;
  if Assigned(FOnColumnSorting) then
    FOnColumnSorting(Self, Column as TdxDBTreeListColumn, Result);
end;

procedure TCustomdxDBGrid.CheckSorted;
var
  I: Integer;
begin
  if IsGridMode or IsPartialLoad then
  begin
    for I := 0 to ColumnCount - 1 do
     if (TdxDBGridColumn(Columns[I]).GroupIndex = -1) and (Columns[I].Sorted <> csNone) then
     begin
       TdxDBGridColumn(Columns[I]).FSorted := csNone;
       RemoveSortedColumn(Columns[I]);
     end;
  end;
end;

procedure TCustomdxDBGrid.DoSortColumn(StartIndex, ColIndex : Integer; FlagDesc : Boolean);
begin
  inherited DoSortColumn(StartIndex, ColIndex, FlagDesc);
  {correct group nodes id}
  CorrectIdGroupNodes;
end;

function TCustomdxDBGrid.IsAutoSort: Boolean;
begin
  Result := (egoAutoSort in OptionsEx) and not (IsGridMode or IsPartialLoad);
end;

function TCustomdxDBGrid.IsFilterStatusVisible: Boolean;
begin
  Result := (Filter.FilterStatus <> fsNone) and
    ((Filter.FilterStatus = fsAlways) or (FFiltering and not Filter.IsEmpty));
end;

function TCustomdxDBGrid.IsMultiSort: Boolean;
begin
  Result := (egoMultiSort in OptionsEx) and not IsGridMode;
end;

function TCustomdxDBGrid.IsMultiSortColumn(AbsoluteIndex: Integer): Boolean;
begin
  Result := inherited IsMultiSortColumn(AbsoluteIndex) and
    ((TdxDBGridColumn(Columns[AbsoluteIndex]).GroupIndex = -1) or
     (TdxDBGridColumn(Columns[AbsoluteIndex]).SortedOrder <> -1));
end;

function TCustomdxDBGrid.IsSummaryColumn(ColIndex : Integer) : Boolean;
begin
  Result := (TdxDBGridColumn(Columns[ColIndex]).GroupIndex <> -1) and
     TdxDBGridColumn(Columns[ColIndex]).SortBySummary;
end;

function TCustomdxDBGrid.IsUseLocate: Boolean;
begin
  Result := (egoUseLocate in Options) or (egoSmartRefresh in Options) or IsFilterMode;
end;

procedure TCustomdxDBGrid.SetColumnSorted(Column : TdxTreeListColumn);

  function ExistGroupColumn(const AFieldName: string): Boolean;
  var
    i: Integer;
  begin
    Result := True;
    for i := 0 to GroupColumnCount - 1 do
      if AnsiCompareText(GroupColumns[i].FieldName, AFieldName) = 0 then Exit;
    Result := False;
  end;

var
  StartIndex: Integer;
  Col: TdxDBGridColumn{TdxDBTreeListColumn};
begin
  Col := TdxDBGridColumn(Column);
  if {IsGridMode or IsPartialLoad or }(Col = nil) or (csLoading in ComponentState) or (Col.Sorted = csNone) or
   {(Col.Field = nil) or }((Col.GroupIndex = -1) and ExistGroupColumn(Col.FieldName)) then Exit;
  if IsMultiSort and (SortedColumn <> nil) then; // check SortedColumns[]
  inherited SetColumnSorted(Column);
//  if not LockSorting then
  if IsAutoSort and not LockSorting then
  begin
    BeginUpdate;
    try
      // sort nodes
      StartIndex := Col.GroupIndex;
      if StartIndex = -1 then StartIndex := GroupColumnCount;
      DoSortColumn(StartIndex, Col.Index, Col.Sorted = csDown);
    finally
      EndUpdate;
    end;
  end;
end;

// Grouping
procedure TCustomdxDBGrid.ChangedGroupColumn(Column: TdxDBTreeListColumn);
begin
  if FFlagChangedGroupColumn or FLoaded then Exit;
  FFlagChangedGroupColumn := True;
  try
    if (Column <> nil) and
      ((Column.FieldName = '') or
      ((Column.Field <> nil) and (Column.Field is TBlobField) and
        not TdxDBGridColumn(Column).IsBlobColumn) or
      ((FDataLink.DataSet <> nil) and
       (FDataLink.DataSet.FindField(Column.FieldName) = nil))) then
       TdxDBGridColumn(Column).GroupIndex := -1
    else
    begin
      BeginGrouping;
      EndGrouping;
    end;
  finally
    FFlagChangedGroupColumn := False;
  end;
end;

function TCustomdxDBGrid.FindGroupNode(StartNode: TdxDBGridNode; Value : Variant; var Node : TdxDBGridNode;
   FlagDesc : Boolean; StartIndex: Integer) : Boolean; {return ANode = Nil - add node, else - insert before}

  {
  function CompareValues (V1, V2 : Variant) : Integer;
  begin
    try
      if V1 = V2 then Result := 0
      else if V1 < V2 then Result := -1
           else Result := 1;
    except
      Result := -1;
    end;
  end;
  }

  function CompareValues(V1, V2: Variant): Integer;
  begin
    try
{
      if (VarType(V1) = varString) and IsCaseInsensitive then
      begin
        V1 := AnsiUpperCase(V1);
        V2 := AnsiUpperCase(V2);
      end;
      if V1 = V2 then
        Result := 0
      else
        if (VarType(V1) = varString) and IsAnsiSort then
          Result := AnsiCompareStr(V1, V2)
        else
          if V1 < V2 then Result := -1
          else Result := 1;
}
      if (VarType(V1) = varString) and (VarType(V2) = varString) and
        IsCaseInsensitive then
      begin
        V1 := AnsiUpperCase(V1);
        V2 := AnsiUpperCase(V2);
      end;
      if V1 = V2 then
        Result := 0
      else
        if VarType(V1) = varNull then
          Result := -1
        else
          if VarType(V2) = varNull then
            Result := 1
          else
          begin
            if (VarType(V1) = varString) and IsAnsiSort then
              Result := AnsiCompareStr(V1, V2)
            else
              if V1 < V2 then Result := -1
              else Result := 1;
          end;
    except
      on EVariantError do
        Result := -1;
    end;
  end;

var
  C, I, L, H, CountItems : Integer;
begin
  Result := False;
  Node := Nil;
  if StartNode = Nil then Exit;
  L := StartIndex{0};
  if StartNode.Parent <> Nil then
    CountItems := StartNode.Parent.Count - 1
  else CountItems := Count - 1;
  H := CountItems;
  { if SortBySummary begin}
  if IsSummaryColumn(GroupColumns[StartNode.Level].Index) then
  begin
    for I := StartIndex{0} to CountItems do
    begin
      if StartNode.Parent <> Nil then
        Node := TdxDBGridNode(StartNode.Parent[i])
      else Node := TdxDBGridNode(Items[i]);
      C := CompareValues(Node.GroupId, Value);
      if C = 0 then
      begin
        Result := True;
        Break;
      end;
    end;
    Exit;
  end;
  {end}
  if FlagDesc then begin
     L := H;
     H := StartIndex{0};
  end;
  while ((L <= H) and (not FlagDesc)) or
        ((H <= L) and (H >=0) and (L >=0) and (FlagDesc)) Do
  begin
    I := (L + H) shr 1;
    if StartNode.Parent <> Nil then
      Node := TdxDBGridNode(StartNode.Parent[i])
    else Node := TdxDBGridNode(Items[i]);
    C := CompareValues(Node.GroupId, Value);
    if C = 0 then
    begin
      Result := True;
      Exit;
    end
    else
    if not FlagDesc then
    begin
      if (C < 0) then L := I + 1
      else H := I - 1;
    end
    else
    begin
      if (C > 0) then H := I + 1
      else L := I - 1;
    end;
  end;
  if FlagDesc then L := H;
  if L > CountItems then Node := Nil
  else
    if StartNode.Parent <> Nil then
      Node := TdxDBGridNode(StartNode.Parent[L])
    else Node := TdxDBGridNode(Items[L]);
end;

function TCustomdxDBGrid.GetGroupColumns(Index: Integer ): TdxDBGridColumn;
begin
  Result := nil;
  if FGroupColumns <> nil then
     Result := FGroupColumns[Index];
end;

function TCustomdxDBGrid.GetGroupColumnsCount: Integer;
begin
  Result := FGroupColumns.Count;
end;

function TCustomdxDBGrid.IsSmartReload: Boolean;
begin
  Result := (egoSmartReload in Options) and FlagSmartReload and not IsGridMode;
end;

function TCustomdxDBGrid.IsSmartRefresh: Boolean;
begin
  Result := (egoSmartRefresh in Options) and not FlagFullRefresh and
    not (FDataLink.DataSet.BOF or FDataLink.DataSet.EOF) and
    not ((Count = 1) and (GroupColumnCount > 0) and (not Items[0].HasChildren){insert new record in empty grid})
    and not IsPartialLoad;
end;

procedure TCustomdxDBGrid.MoveNodesToRoot;

  procedure MoveToRoot(Node: TdxDBGridNode);
  var
    i: Integer;
  begin
    if Node[0].Count = 0 then
       Node.MoveChildrenToRoot
    else
      for i := 0 to Node.Count - 1 do
        MoveToRoot(TdxDBGridNode(Node[i]));
  end;

var
  I: Integer;
  PrevFlag: Boolean;
begin
  ClearListNodes;
  PrevFlag := FClearListNodesFlag;
  FClearListNodesFlag := True;
  try
    for I := 0 to Count - 1 do
    begin
      MoveToRoot(TdxDBGridNode(Items[0]));
      Items[0].Free;
    end;
  finally
    FClearListNodesFlag := PrevFlag;
  end;
end;

// Summary
procedure TCustomdxDBGrid.AssignSummaryFields;

  procedure ClearSummaryList(Node: TdxTreeListNode);
  var
    I: Integer;
  begin
    if Node.Count > 0 then
    begin
      FreeMem(TdxDBGridNode(Node).FSummaryList);
      TdxDBGridNode(Node).FSummaryList := nil;
      for I := 0 to Node.Count - 1 do
        ClearSummaryList(Node[I]);
    end;
  end;

var
  I, J: Integer;
  SummaryItem: TdxDBGridSummaryItem;
  S: string;
  Column: TdxDBTreeListColumn;
begin
  if Assigned(DataLink.DataSet) then
  begin
    for I := 0 to GroupColumnCount - 1 do
    begin
      GroupColumns[I].FSmrField := DataLink.DataSet.FindField(GroupColumns[I].SummaryField);
      GroupColumns[I].FSummaryGroup := FindSummaryGroup(GroupColumns[I]);
    end;
    // summary groups
    if SummaryGroups.Count > 0 then
    begin
      // clear nodes
      for I := 0 to Self.Count - 1 do
        ClearSummaryList(Items[I]);
      // assign fields
      for I := 0 to SummaryGroups.Count - 1 do
        if SummaryGroups[I].SummaryItems <> nil then
          for J := 0 to SummaryGroups[I].SummaryItems.Count - 1 do
          begin
            SummaryItem := SummaryGroups[I].SummaryItems[J];
            S := SummaryItem.SummaryField;
            if (S = '') and (SummaryItem.ColumnName <> '') then
            begin
              Column := ColumnByName(SummaryItem.ColumnName);
              if Column <> nil then
                S := Column.FieldName;
            end;
            SummaryItem.SmrField := DataLink.DataSet.FindField(S);
          end;
    end;
  end;
  FTotalSummaryCount := 0;
end;

procedure TCustomdxDBGrid.AssignSummaryFooterFields;
begin
  inherited AssignSummaryFooterFields;
  FTotalSummaryCount := 0;
end;

procedure TCustomdxDBGrid.CalcSummary(SmartFlag: Boolean); // Count , Average
var
  I, J, K: Integer;
  Col: TdxDBGridColumn;
begin
  // group summary
  for i := 0 to GroupColumnCount - 1 do
  begin
    // Simple Summary
    case GroupColumns[i].SummaryType of
      cstCount : for j := 0 to Count - 1 do CalcSummaryCount(Items[j], i);
      cstAvg : for j := 0 to Count - 1 do CalcAverageCount(Items[j], i);
    end;
    // Summary Group
    if GroupColumns[i].FSummaryGroup <> nil then
    begin
      if GroupColumns[i].FSummaryGroup.SummaryItems <> nil then
        for K := 0 to GroupColumns[i].FSummaryGroup.SummaryItems.Count - 1 do
        begin
          case GroupColumns[i].FSummaryGroup.SummaryItems[K].SummaryType of
          cstCount: for J := 0 to Count - 1 do CalcMultiSummaryCount(Items[J], I, K);
          cstAvg: for J := 0 to Count - 1 do CalcMultiAverageCount(Items[J], I, K);
          end;
        end;
    end;
  end;
  // footer summary
  for i := 0 to ColumnCount - 1 do
  begin
    Col := TdxDBGridColumn(Columns[i]);
    case Col.SummaryFooterType of
    cstCount : Col.FSummaryFooterValue := FTotalSummaryCount;
    cstAvg : if (FTotalSummaryCount > 0) and not SmartFlag then
      Col.FSummaryFooterValue := Col.FSummaryFooterValue / FTotalSummaryCount;
    end;
  end;
  if Assigned(OnCalcSummary) then OnCalcSummary(Self);
end;

procedure TCustomdxDBGrid.DoClearNodeData;
begin
  if Assigned(FOnClearNodeData) then FOnClearNodeData(Self);
end;

function TCustomdxDBGrid.FindSummaryGroup(Column: TdxDBTreeListColumn): TdxDBGridSummaryGroup;
var
  I: Integer;
begin
  Result := nil;
  if (TdxDBGridColumn(Column).SummaryGroupName = '') and (TdxDBGridColumn(Column).SummaryType = cstNone) then
    Result := SummaryGroups.GetDefaultGroup
  else
  for I := 0 to SummaryGroups.Count - 1 do
    if AnsiCompareText(SummaryGroups[I].Name, TdxDBGridColumn(Column).SummaryGroupName) = 0 then
    begin
      Result := SummaryGroups[I];
      Break;
    end;
end;

function TCustomdxDBGrid.GetCustomSummaryText(Node: TdxTreeListNode): String;
begin
  Result := '';
  if Assigned(FOnGetCustomSummaryText) then FOnGetCustomSummaryText(Self, Node, Result);
end;

function TCustomdxDBGrid.GetSummaryText(ANode: TdxTreeListNode; AColumn: TdxDBTreeListColumn): string;
var
  V: Extended;
  DataType: TFieldType;
  I, C: Integer;
  IsExistGroupItem: Boolean; 
begin
  Result := '';
  with TdxDBGridColumn(AColumn) do
  begin
    // Simple Summary
    if SummaryType <> cstNone then
    begin
      V := Self.GetSummaryValue(ANode);
      if (SummaryType <> cstCount) and Assigned(FSmrField) and
        (FSmrField.DataType in [ftDate, ftTime, ftDateTime]) then DataType := FSmrField.DataType
      else DataType := ftUnknown;
      Result := Result + GetSummaryString(SummaryType, SummaryFormat, V, DataType, False) + ' ';
    end;
    // Summary Groups
    if (FSummaryGroup <> nil) and (FSummaryGroup.SummaryItems <> nil) then
    begin
      C := FSummaryGroup.SummaryItems.Count;
      IsExistGroupItem := False;
      if C > 0 then
      begin
        Result := Result + FSummaryGroup.BeginSummaryText;
        for I := 0 to C - 1 do
        begin
          with FSummaryGroup.SummaryItems[I] do
            if (ColumnName = '') and (TdxDBGridNode(ANode).FSummaryList <> nil) then
            begin
              if IsExistGroupItem and (SummaryType <> cstNone) then
                Result := Result + SummarySeparator;
              V := TdxDBGridNode(ANode).FSummaryList^[I].Value;
              if (SummaryType <> cstCount) and Assigned(SmrField) and
                (SmrField.DataType in [ftDate, ftTime, ftDateTime]) then
                DataType := SmrField.DataType
              else
                DataType := ftUnknown;
              Result := Result + GetSummaryString(SummaryType, SummaryFormat, V, DataType, False);
              if SummaryType <> cstNone then
                IsExistGroupItem := True;
//              if I < (C - 1) then
//                Result := Result + SummarySeparator;
            end;
        end;
        Result := Result + FSummaryGroup.EndSummaryText;
      end;
    end;
  end;
end;

function TCustomdxDBGrid.GetSummaryValue(ANode: TdxTreeListNode): Extended;
begin
  Result := VarAsType(TdxDBGridNode(ANode).FSummary, varDouble);
end;

procedure TCustomdxDBGrid.LoadSummaryFooterValues(ADetailNode : TDxDBGridNode; List: TList);
var
  SType : TdxSummaryType;
  Col, ColField: TdxDBGridColumn{TdxDBTreeListColumn};
  V : Extended;
  i: Integer;
begin
  for i := 0 to ColumnCount - 1 do
  begin
    Col := TdxDBGridColumn(Columns[i]);
    SType := Col.SummaryFooterType;
    if (SType <> cstNone) then
    begin
      if ADetailNode = nil then
        if Assigned(Col.FSmrFooterField) and (SType <> cstCount) then
          V := Col.FSmrFooterField.AsFloat
        else V := 0
      else
      begin
        V := 0;
        if (List <> nil) and (i < List.Count) then
          ColField := List[i]
        else ColField := TdxDBGridColumn(FindColumnByFieldName(Col.FSummaryFooterField));
        if (ColField <> nil) and (SType <> cstCount) then
          V := GetNodeVarData(ADetailNode, ColField)
        else V := 0;
      end;
      if Assigned(Col.OnSummaryFooter) and Assigned(Datalink.DataSet) then
         Col.OnSummaryFooter(Col{Self}, Datalink.DataSet, V);
      with Col do
      if not FAssignedSummaryFooter then
      begin
        FSummaryFooterValue := V;
        FAssignedSummaryFooter := True;
      end
      else
      case SType of
        cstMin : if V <  FSummaryFooterValue then FSummaryFooterValue := V;
        cstMax : if V >  FSummaryFooterValue then FSummaryFooterValue := V;
        cstSum, cstAvg : FSummaryFooterValue := FSummaryFooterValue + V;
      end;
    end;
  end;
end;

procedure TCustomdxDBGrid.LoadSummaryValues(ANode, ADetailNode: TDxDBGridNode; List: TList);
var
  SType: TdxSummaryType;
  Col, ColField: TdxDBGridColumn{TdxDBTreeListColumn};
  V: Extended;
  I, J: Integer;
  // summary group
  PSummaryValues: PSummaryList;
s:string;
Column:TdxDBTreeListColumn;
begin
  repeat
    J := ANode.Level;
    Col := GroupColumns[J];
    SType := Col.SummaryType;
    // Simple Summary
    if (SType <> cstNone) or Assigned(Self.FOnSummaryNode) then
    begin
      if ADetailNode = nil then
        if Assigned(Col.FSmrField) and (SType <> cstCount) then
          V := Col.FSmrField.AsFloat
        else V := 0
      else
      begin
        if (List <> nil) and (J < List.Count) then
          ColField := List[J]
        else ColField := TdxDBGridColumn(FindColumnByFieldName(Col.FSummaryField));
        if (ColField <> nil) and (SType <> cstCount) then
          V := GetNodeVarData(ADetailNode, ColField)
        else V := 0;
      end;
      if Assigned(Col.OnSummary) and Assigned(Datalink.DataSet) then Col.OnSummary(Col{Self}, Datalink.DataSet, V);
      if Assigned(Self.FOnSummaryNode) and Assigned(Datalink.DataSet) then Self.FOnSummaryNode(Self, ANode, Datalink.DataSet, V);
      if not ANode.FAssignedSummary then
        ANode.FSummary := V
      else
      case SType of
        cstMin: if V < ANode.FSummary then ANode.FSummary := V;
        cstMax: if V > ANode.FSummary then ANode.FSummary := V;
        cstSum, cstAvg: ANode.FSummary := ANode.FSummary + V;
      end;
      ANode.FAssignedSummary := True;
    end;
    // Summary Group
    if (Col.FSummaryGroup <> nil) and (Col.FSummaryGroup.SummaryItems <> nil) then
    begin
      for I := 0 to Col.FSummaryGroup.SummaryItems.Count - 1 do
      begin
        // get Value
        if ADetailNode = nil then
          if Assigned(Col.FSummaryGroup.SummaryItems[I].SmrField) and
            not (Col.FSummaryGroup.SummaryItems[I].SummaryType in [cstCount, cstNone]) then
            V := Col.FSummaryGroup.SummaryItems[I].SmrField.AsFloat
          else V := 0
        else
        begin
          // TODO - list fields 
s := Col.FSummaryGroup.SummaryItems[I].SummaryField;
          if (S = '') and (Col.FSummaryGroup.SummaryItems[I].ColumnName <> '') then
          begin
            Column := ColumnByName(Col.FSummaryGroup.SummaryItems[I].ColumnName);
            if Column <> nil then
              S := Column.FieldName;
          end;
ColField := TdxDBGridColumn(FindColumnByFieldName(s));
          if (ColField <> nil) and
            not (Col.FSummaryGroup.SummaryItems[I].SummaryType in [cstCount, cstNone]) then
            V := GetNodeVarData(ADetailNode, ColField)
          else V := 0;
        end;
        if Assigned(Col.FSummaryGroup.SummaryItems[I].OnSummary) and Assigned(Datalink.DataSet) then
           Col.FSummaryGroup.SummaryItems[I].OnSummary(Col{Self}, Datalink.DataSet, V);
        // create summary list item
        if ANode.FSummaryList = nil then
          ANode.FSummaryList := AllocMem(Col.FSummaryGroup.SummaryItems.Count * SizeOf(TSummaryValue));
        PSummaryValues := ANode.FSummaryList;
        if not PSummaryValues^[I].AssignedValue then
        begin
          PSummaryValues^[I].Value := V;
          PSummaryValues^[I].AssignedValue := True;
        end
        else
        case Col.FSummaryGroup.SummaryItems[I].SummaryType of
          cstMin: if V < PSummaryValues^[I].Value then PSummaryValues^[I].Value := V;
          cstMax: if V > PSummaryValues^[I].Value then PSummaryValues^[I].Value := V;
          cstSum, cstAvg: PSummaryValues^[I].Value := PSummaryValues^[I].Value + V;
        end;
      end;
    end;
    ANode := TdxDBGridNode(ANode.Parent);
  until ANode = nil;
end;

procedure TCustomdxDBGrid.MakeSummaryFieldList(List: TList);
var
  i: Integer;
begin
  List.Clear;
  for i := 0 to GroupColumnCount - 1 do
  begin
    List.Add(FindColumnByFieldName(GroupColumns[i].FSummaryField));
  end;
end;

procedure TCustomdxDBGrid.MakeSummaryFooterFieldList(List: TList);
var
  I: Integer;
  S: string;
begin
  List.Clear;
  for I := 0 to ColumnCount - 1 do
  begin
    S := Columns[I].SummaryFooterField;
    if S = '' then S := Columns[I].FieldName;
    List.Add(FindColumnByFieldName(S));
  end;
end;

procedure TCustomdxDBGrid.ReCalcSummary(ADetailNode: TdxDBGridNode);
var
  Node, ANode, CurNode: TdxDBGridNode;
  Column: TdxDBTreeListColumn;
  i: Integer;
  V: Variant;
  FldList, FooterFldList: TList;
  {$IFDEF EGRID_DEBUG} t1, t2: LongInt; {$ENDIF}

  procedure ResetFlagNodes(Node : TdxTreeListNode);
  var
    i : Integer;
  begin
    TdxDBGridNode(Node).FAssignedSummary := False;
    // multi summary
    if TdxDBGridNode(Node).FSummaryList <> nil then
    begin
      FreeMem(TdxDBGridNode(Node).FSummaryList);
      TdxDBGridNode(Node).FSummaryList := nil;
    end;
    if Node.Count > 0 then
      if Node[0].Count > 0 then
        for I := 0 to Node.Count - 1 do ResetFlagNodes(Node[I]);
  end;

  procedure LoadValues(Node: TdxTreeListNode);
  var
    I: Integer;
  begin
    if Node.Count > 0 then
      for I := 0 to Node.Count - 1 do
        LoadValues(Node[I])
    else
    begin
      LoadSummaryValues(TdxDBGridNode(Node.Parent), TdxDBGridNode(Node), FldList);
      LoadSummaryFooterValues(TdxDBGridNode(Node), FooterFldList);
      Inc(FTotalSummaryCount);
    end;
  end;

begin
  if (GroupColumnCount > 0) and (Count > 0) and (Items[0].HasChildren) then
  begin
    {$IFDEF EGRID_DEBUG} t1 := GetTickCount; {$ENDIF}
    BeginUpdate;
    try
      Node := nil;
      if ADetailNode <> nil then
      for i:= 0 to GroupColumnCount - 1 do
      begin
        CurNode := Node;
        Column := GroupColumns[i];
        if Column <> nil then
          V := GetColumnVariantData(ADetailNode, Column);

        if Node = nil then
          Node := TdxDBGridNode(Items[0])
        else Node := TdxDBGridNode(Node[0]);

        if not FindGroupNode(Node, V , ANode, Column.Sorted = csDown, 0) then
        begin
          if ANode = nil then //add
            if (i > 0) then
              Node := TdxDBGridNode(CurNode.AddChild)
            else
            if (Node = nil) or (Node.Parent = nil) then
              Node := TdxDBGridNode(Self.Add)
            else Node := TdxDBGridNode(Node.Parent.AddChild)
          else
            if ANode.Parent <> nil then
               Node := TdxDBGridNode(ANode.Parent.InsertChild(ANode))
            else Node := TdxDBGridNode(Self.Insert(ANode));
          Node.FGroupId := V;
          Node.Id := ADetailNode.Id;
          Node.VariantData[Column.Index] := ADetailNode.VariantData[Column.Index];
          Node.Strings[Column.Index] := ADetailNode.Strings[Column.Index];
          Node.FRecNo := ADetailNode.FRecNo;
          {Assign propery Data: Pointer}
          DoRefreshNodeData(Node);
        end
        else
          Node := ANode;
      end;

      if ADetailNode <> nil then
      begin
        ANode := TdxDBGridNode(ADetailNode.Parent);
        if (ANode <> nil) and (ANode <> Node) then
        begin
          ADetailNode.MoveTo(Node, natlAddChild);
          if ANode.Count = 0 then
            DeleteRecurse(ANode);
        end;
      end;

      { reset flag AssignValues nodes }
      for i := 0 to Count - 1 do ResetFlagNodes(Items[i]);

      AssignSummaryFooterFields;
      // before summary
      DoBeforeCalcSummary;

      FTotalSummaryCount := 0;
      FldList := TList.Create;
      FooterFldList := TList.Create;
      try
        MakeSummaryFieldList(FldList);
        MakeSummaryFooterFieldList(FooterFldList);
        for i := 0 to Count - 1 do
          LoadValues(Items[i]);
      finally
        FooterFldList.Free;
        FldList.Free;
      end;

      {sorting}
      RefreshSorting;
      {calc summary}
      CalcSummary(False);
      {group sorting - if SortBySummary}
      SortingBySummary;
      {correct group nodes id}
      CorrectIdGroupNodes;
    finally
      EndUpdate;
    end;
    {$IFDEF EGRID_DEBUG}
    t2 := GetTickCount;
    if Assigned(OnDebugEvent) then OnDebugEvent(Self, etRefreshNode, t2 - t1);
    {$ENDIF}
  end
  else
  begin
    {$IFDEF EGRID_DEBUG} t1 := GetTickCount; {$ENDIF}
    BeginUpdate;
    try
      AssignSummaryFooterFields;
      // before summary
      DoBeforeCalcSummary;
      {refresh Summary Footer}
      FooterFldList := TList.Create;
      try
        MakeSummaryFooterFieldList(FooterFldList);
        for i := 0 to Count - 1 do
        begin
          LoadSummaryFooterValues(TdxDBGridNode(Items[i]), FooterFldList);
        end;
      finally
        FooterFldList.Free;
      end;

      FTotalSummaryCount := Count;
      {sorting}
      RefreshSorting;
      {calc summary}
      CalcSummary(False);
    finally
      EndUpdate;
    end;
    {$IFDEF EGRID_DEBUG}
    t2 := GetTickCount;
    if Assigned(OnDebugEvent) then OnDebugEvent(Self, etRefreshNode, t2 - t1);
    {$ENDIF}
  end;
end;

procedure TCustomdxDBGrid.RefreshSummaryItems(const PrevName, NewName: string);
var
  I, J: Integer;
  S: string;
begin
  for I := 0 to SummaryGroups.Count - 1 do
    if SummaryGroups[I].SummaryItems <> nil then
      for J := 0 to SummaryGroups[I].SummaryItems.Count - 1 do
      begin
        S := SummaryGroups[I].SummaryItems[J].ColumnName;
        if AnsiCompareText(S, PrevName) = 0 then
          SummaryGroups[I].SummaryItems[J].ColumnName := NewName;
      end;
end;

procedure TCustomdxDBGrid.SortingBySummary;
var
  Column: TdxDBGridColumn{TdxDBTreeListColumn};
  i: Integer;
begin
  for i := 0 to GroupColumnCount - 1 do
  begin
    Column := GroupColumns[i];
    if Column.SortBySummary and (Column.Sorted <> csNone) then // TODO multi summary
    begin
      DoSortColumn(Column.GroupIndex, Column.Index, Column.Sorted = csDown);
    end;
  end;
end;

// Style
function TCustomdxDBGrid.CanDblClick: Boolean;
begin
  Result := egoDblClick in Options;
end;

procedure TCustomdxDBGrid.EndCustomLayout;
begin
  inherited EndCustomLayout;
  FKeyField := nil;
  if FDataLink.Active and (KeyField <> '') then
     FKeyField := FDataLink.DataSet.FindField(KeyField);
  UpdateActive;
end;

function TCustomdxDBGrid.IsSmartRecalcRowHeight: Boolean;
begin
  Result := inherited IsSmartRecalcRowHeight and not IsGridMode;
end;

function TCustomdxDBGrid.IsVScrollBarDisableHide: Boolean;
begin
  Result := inherited IsVScrollBarDisableHide or
    (IsVScrollBarVisible and IsGridMode);
end;

//based override (TCustomDxDBGrid)
procedure TCustomdxDBGrid.ClearListNodes;
var
  I: Integer;
begin
  inherited ClearListNodes;
  if FSummaryAbsoluteList <> nil then
  begin
    for I := 0 to FSummaryAbsoluteList.Count - 1 do
      if FSummaryAbsoluteList[I] <> nil then
        TList(FSummaryAbsoluteList[I]).Free;
    FSummaryAbsoluteList.Clear;
  end;
end;

function TCustomdxDBGrid.CreateNode: TdxTreeListNode;
begin
  Result := TdxDBGridNode.Create(Self);
end;

procedure TCustomdxDBGrid.DoMouseWHeelScroll(AScrollUp: Boolean; AScrollLines: Integer);
begin
  if IsGridMode then
  begin
    if AScrollUp then
      GotoPrev(False)
    else
      GotoNext(False);
  end
  else
    inherited DoMouseWHeelScroll(AScrollUp, AScrollLines);
end;

function TCustomdxDBGrid.GetCellAlignment(Node: TdxTreeListNode; AbsoluteIndex: Integer): TAlignment;
begin
  if IsRowGroup(Node) then
    Result := taLeftJustify
  else Result := inherited GetCellAlignment(Node, AbsoluteIndex);
end;

function TCustomdxDBGrid.GetDataLink: TdxDBTreeListControlDataLink;
begin
  Result := FDataLink;
end;

function TCustomdxDBGrid.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TCustomdxDBGrid.GetFooterCellText(Node: TdxTreeListNode; AbsoluteIndex, FooterIndex: Integer): string;
var
  SummaryGroup: TdxDBGridSummaryGroup;
  Column: TdxDBTreeListColumn;
  SummaryItem: TdxDBGridSummaryItem;
  I, J, ALevel: Integer;
  V: Extended;
  DataType: TFieldType;
begin
  if FooterIndex = -1 then // summary footer
  begin
    Result := TdxDBGridColumn(Columns[AbsoluteIndex]).GetSummaryFooterText;
  end
  else
  begin
    ALevel := GetNodeFooterLevel(Node, FooterIndex);
    while Node.Level <> ALevel do
      Node := Node.Parent;
    SummaryGroup := GroupColumns[ALevel].FSummaryGroup;
    if SummaryGroup.SummaryItems <> nil then
    begin
      I := -1;
      if (FSummaryAbsoluteList <> nil) then
      begin
        if FSummaryAbsoluteList.Count = 0 then
          MakeListNodes;
        if (FSummaryAbsoluteList[ALevel] <> nil) then
        begin
          I := Integer(TList(FSummaryAbsoluteList[ALevel])[AbsoluteIndex]);
        end;
      end
      else
      for J := 0 to SummaryGroup.SummaryItems.Count - 1 do
      begin
        SummaryItem := SummaryGroup.SummaryItems[J];
        if SummaryItem.ColumnName <> '' then
        begin
          Column := ColumnByName(SummaryItem.ColumnName);
          if (Column <> nil) and (Column.Index = AbsoluteIndex) then
          begin
            I := J;
            Break;
          end;
        end;
      end;
      // text
      if I <> -1 then
      begin
        SummaryItem := SummaryGroup.SummaryItems[I];
        V := TdxDBGridNode(Node).FSummaryList^[I].Value;
        with SummaryItem do
        begin
          if (SummaryType <> cstCount) and Assigned(SmrField) and
             (SmrField.DataType in [ftDate, ftTime, ftDateTime]) then
            DataType := SmrField.DataType
          else DataType := ftUnknown;
          Result := GetSummaryString(SummaryType, SummaryFormat, V, DataType, True);
        end;
      end;
    end
    else
      Result := '';
  end;
end;

function TCustomdxDBGrid.GetNodeString(Node: TdxTreeListNode; Column: Integer): string;
var
  OldActive: Integer;
  DrawColumn: TdxDBGridColumn{TdxDBTreeListColumn};
begin
  if IsGridMode then
  begin
    Result := '';
    DrawColumn := TdxDBGridColumn(Columns[Column]);
    if (DrawColumn = nil) then Exit;
    if not (Assigned(DataLink) and DataLink.Active) then Exit;
    OldActive := FDataLink.ActiveRecord;
    try
      FDataLink.ActiveRecord := Node.Index;
      if Assigned(DrawColumn.Field) then
      begin
        DrawColumn.FActualNode := Node;
        try
          Result := DrawColumn.GetText(DrawColumn.GetDisplayText(Node));
        finally
          DrawColumn.FActualNode := nil;
        end;
      end;
      // OnGetText
      if Assigned(DrawColumn.OnGetText) then
        DrawColumn.OnGetText(DrawColumn, Node, Result);
    finally
      FDataLink.ActiveRecord := OldActive;
    end;
  end
  else
    if Node.HasChildren then
    begin
      DrawColumn := GroupColumns[Node.Level];
      // OnGetText
      if Assigned(DrawColumn.OnGetText) then
      begin
        Result := DrawColumn.GetGroupText(inherited GetNodeString(Node, DrawColumn.Index));
        DrawColumn.OnGetText(DrawColumn, Node, Result);
        Result := DrawColumn.Caption + ' : ' +
          Result+ ' ' +
          GetSummaryText(Node, DrawColumn) + GetCustomSummaryText(Node);
      end
      else
      Result := DrawColumn.Caption + ' : ' +
        DrawColumn.GetGroupText(inherited GetNodeString(Node, DrawColumn.Index))+ ' ' +
        GetSummaryText(Node, DrawColumn) + GetCustomSummaryText(Node);
    end
    else
    begin
      Result := inherited GetNodeString(Node, Column);
      DrawColumn := TdxDBGridColumn(Columns[Column]);
      // TODO OnGetText
      if Assigned(DrawColumn.OnGetText) then
        DrawColumn.OnGetText(DrawColumn, Node, Result);
    end;
end;

function TCustomdxDBGrid.GetNodeValue(Node: TdxTreeListNode; Column: Integer): Variant;
var
  OldActive: Integer;
  DrawColumn: TdxDBTreeListColumn;
begin
  if IsGridMode then
  begin
    Result := Null;
    DrawColumn := Columns[Column];
    if (DrawColumn = nil) then Exit;
    if not (Assigned(DataLink) and DataLink.Active) then Exit;
    OldActive := FDataLink.ActiveRecord;
    try
      FDataLink.ActiveRecord := Node.Index;
      if Assigned(DrawColumn.Field) then
        Result := DrawColumn.Field.Value;
    finally
        FDataLink.ActiveRecord := OldActive;
    end;
  end
  else
    if Node.HasChildren then
      Result := TdxDBGridNode(Node).GroupId
    else
    begin
      with TdxDBGridNode(Node) do
      if nadValue in VariantData[Column].AssignedValues then
        Result := VariantData[Column].Value
      else Result := Node.Strings[Column];
    end;
end;

function TCustomdxDBGrid.GetNodeVariant(Node: TdxTreeListNode; Column: Integer): Variant;
var
  S: string;
begin
  if IsSummaryColumn(Column) then
    Result := TdxDBGridNode(Node).FSummary
  else
  begin
    if Columns[Column].VariantType = varString then
    begin
      S := Node.Strings[Column];
      if IsCaseInsensitive then
        Result := AnsiUpperCase(S)
      else Result := S;
    end
    else
      Result := TdxDBGridNode(Node).VariantData[Column].Value;
  end;
end;

function TCustomdxDBGrid.GetPreviewText(Node: TdxTreeListNode): string;
var
  OldActive : Integer;
begin
  Result := '';
  if IsGridMode then
  begin
    if not (Assigned(DataLink) and DataLink.Active) then Exit;
    OldActive := FDataLink.ActiveRecord;
    try
      FDataLink.ActiveRecord := Node.Index;
      if Assigned(FPreviewField) then
      begin
        try
          if Assigned(FPreviewField.OnGetText) then
            FPreviewField.OnGetText(FPreviewField, Result, True)
          else
            Result := GetPreviewString(FPreviewField.AsString);
        except
          //  ignore error
        end;
      end;
    finally
      FDataLink.ActiveRecord := OldActive;
    end;
  end
  else
  if not Node.HasChildren then
    Result := (Node as TdxDBGridNode).Description;
  if Assigned(OnGetPreviewText) then 
    OnGetPreviewText(Self, Node, Result);
end;

function TCustomdxDBGrid.IsCancelOnExit: Boolean;
begin
  Result := egoCancelOnExit in Options;
end;

function TCustomdxDBGrid.IsCanInsert: Boolean;
begin
  Result := egoCanInsert in Options;
end;

function TCustomdxDBGrid.IsCanNavigation: Boolean;
begin
  Result := IsGridMode or (egoCanNavigation in Options);
end;

function TCustomdxDBGrid.IsEasySelect: Boolean;
begin
  Result := IsGridMode;
end;

function TCustomdxDBGrid.IsExistRowFooterCell(Node: TdxTreeListNode; AbsoluteIndex, FooterIndex: Integer): Boolean;
var
  SummaryGroup: TdxDBGridSummaryGroup;
  SummaryItem: TdxDBGridSummaryItem;
  Column: TdxDBTreeListColumn;
  J, L: Integer;
begin
  Result := False;
  L := GetNodeFooterLevel(Node, FooterIndex);
  SummaryGroup := GroupColumns[L].FSummaryGroup;
  if SummaryGroup.SummaryItems <> nil then
  begin
    if (FSummaryAbsoluteList <> nil) then
    begin
      if FSummaryAbsoluteList.Count = 0 then
        MakeListNodes;
      if FSummaryAbsoluteList[L] <> nil then
        Result := Integer(TList(FSummaryAbsoluteList[L])[AbsoluteIndex]) <> -1;
    end
    else
      for J := 0 to SummaryGroup.SummaryItems.Count - 1 do
      begin
        SummaryItem := SummaryGroup.SummaryItems[J];
        if SummaryItem.ColumnName <> '' then
        begin
          Column := ColumnByName(SummaryItem.ColumnName);
          if (Column <> nil) and (Column.Index = AbsoluteIndex) then
          begin
            Result := SummaryItem.SummaryType <> cstNone;
            Break;
          end;
        end;
      end;
  end;
end;

function TCustomdxDBGrid.IsKeyFieldEmpty: Boolean;
begin
  Result := (FKeyField = nil) and not IsGridMode;
end;

function TCustomdxDBGrid.IsLevelFooter(Level: Integer): Boolean;
var
  I: Integer;
begin
  Result := (Level < GroupColumnCount) and (GroupColumns[Level].FSummaryGroup <> nil);
  if Result then
  begin
    if GroupColumns[Level].FSummaryGroup.SummaryItems <> nil then
      for I := 0 to GroupColumns[Level].FSummaryGroup.SummaryItems.Count - 1 do
        if GroupColumns[Level].FSummaryGroup.SummaryItems[I].ColumnName <> '' then Exit;
  end;
  Result := False;
end;

function TCustomdxDBGrid.IsLoadedAll: Boolean;
begin
  Result := IsLoadAllRecords or (FGridBOF and FGridEOF);
end;

function TCustomdxDBGrid.IsRowGroup(Node: TdxTreeListNode): Boolean;
begin
  if Node <> nil then
    Result := Node.HasChildren
  else Result := inherited IsRowGroup(Node);
end;

function TCustomdxDBGrid.IsUseBookmarks: Boolean;
begin
  Result := UseBookmarks or IsGridMode;
end;

procedure TCustomdxDBGrid.MakeListNodes;
var
  SummaryGroup: TdxDBGridSummaryGroup;
  SummaryItem: TdxDBGridSummaryItem;
  Column: TdxDBTreeListColumn;
  I, J, K, C, G, Index: Integer;
  List: TList;
begin
  inherited MakeListNodes;
  if FSummaryAbsoluteList <> nil then
  begin
    for I := 0 to FSummaryAbsoluteList.Count - 1 do
      if FSummaryAbsoluteList[I] <> nil then
        TList(FSummaryAbsoluteList[I]).Free;
    FSummaryAbsoluteList.Clear;
    G := GroupColumnCount;
    FSummaryAbsoluteList.Capacity := G;
    for I := 0 to G - 1 do
    begin
      SummaryGroup := GroupColumns[I].FSummaryGroup;
      if (SummaryGroup <> nil) and (SummaryGroup.SummaryItems <> nil) then
      begin
        C := ColumnCount;
        List := TList.Create;
        List.Capacity := C;
        for K := 0 to C - 1 do
        begin
          Index := -1;
          for J := 0 to SummaryGroup.SummaryItems.Count - 1 do
          begin
            SummaryItem := SummaryGroup.SummaryItems[J];
            if SummaryItem.ColumnName <> '' then
            begin
              Column := ColumnByName(SummaryItem.ColumnName);
              if (Column <> nil) and (Column.Index = K) then
              begin
                Index := J;
                if SummaryItem.SummaryType = cstNone then Index := -1;
                Break;
              end;
            end;
          end;
          List.Add(Pointer(Index));
        end;
      end
      else
        List := nil;
      FSummaryAbsoluteList.Add(Pointer(List));
    end;
  end;
end;

procedure TCustomdxDBGrid.RemoveColumn(Column: TdxTreeListColumn);
begin
  if FGroupColumns <> nil then
    FGroupColumns.Remove(Column);
  if Assigned(FFilterPopupListBox) and (FFilterPopupListBox.Column = Column) then
    FFilterPopupListBox.Column := nil;
  inherited RemoveColumn(Column);
  if FFilter <> nil then
    FFilter.Remove(TdxDBTreeListColumn(Column));
end;

procedure TCustomdxDBGrid.ResetAutoHeaderPanelRowCountOption;
begin
  inherited ResetAutoHeaderPanelRowCountOption;
  FOptionsEx := FOptionsEx - [egoAutoHeaderPanelHeight];
end;

procedure TCustomdxDBGrid.SetDataChangedBusy(Value: Boolean);
begin
  DataChangedBusy := Value;
end;

procedure TCustomdxDBGrid.SetFocusedNode(Node: TdxTreeListNode; Column: Integer; MakeVisibleFlag: Boolean);
var
  Flag: Boolean;
begin
  if Node = nil then Exit;
  AddNodeLink(Node);
  if not FInUpdateActive then
  begin
    inherited SetFocusedNode(FocusedNode, Column, False);
    if IsGridMode then
    begin
      FocusedNumber := Node.Index;
      Node := Items[FocusedNumber];
    end
    else
      if not FRefreshGroupList then
      begin
        if IsUseLocate then
          if not LocateByNode(TdxDBgridNode(FocusedNode), TdxDBgridNode(Node),
             TdxDBGridNode(Node).Id, True) then Exit
          else
        else
        begin
//          Flag := Datalink.Dataset.State = dsInsert;
          Flag := Datalink.Dataset.State in dsEditModes; // TODO new
          if not LocateByNode(TdxDBgridNode(FocusedNode), TdxDBgridNode(Node), Null, False) then Exit;
          if Flag then
            if not ValidateNode(Node) then Exit
            else
              if TdxDBgridNode(Node).Id <> FKeyField.Value then
              begin
                if NodeLinkList <> nil then NodeLinkList.Remove(Node);
                Exit;
              end;
        end;
      end;
  end;
  if not ValidateNode(Node) then Exit
  else if NodeLinkList <> nil then {FNodeLink.Remove(Node)}; {WARNING}
  inherited SetFocusedNode(Node, Column, MakeVisibleFlag);
  //Save old focused column position
  if FOldFocusedColumn = -1 then FOldFocusedColumn := 0;
  if (FocusedNode <> nil) and not FocusedNode.HasChildren then
     FOldFocusedColumn := FocusedColumn;
end;

procedure TCustomdxDBGrid.SetFocusedNumber(AIndex: Integer);
var
  FSelIndex, FCount: Integer;
begin
  if Count = 0 then Exit;
  if IsGridMode then
  begin
    if (Count = 0) or not FDatalink.Active then Exit;
    if (AIndex-FocusedNumber) <> 0 then
    begin
      FCount := FocusedNumber;
      FDatalink.DataSet.MoveBy(AIndex - FCount);
    end;
  end
  else
  //inherited SetFocusedNumber(AIndex);
  begin
    FSelIndex := FocusedNumber;
    if FSelIndex <> AIndex then
    begin
      if (AIndex < 0) then AIndex := 0;
      FCount := GetAbsoluteCount;
      if AIndex > (FCount-1) then AIndex := FCount-1;
      if (AIndex <> FSelIndex) then
      begin
        FSelIndex := FocusedColumn;
        if FOldFocusedColumn > 0 then
           FSelIndex := FOldFocusedColumn;
        SetFocusedNode(GetAbsoluteNode(AIndex), FSelIndex, True);
      end;
    end;
  end;
end;

procedure TCustomdxDBGrid.SetTopVisibleNode(Node: TdxTreeListNode);
var
  AMinBufferCount, ACount: Integer;
begin
  inherited SetTopVisibleNode(Node);
  if (Node <> nil) and (FTopVisibleUpdate = 0) and
    IsPartialLoad and HandleAllocated then
  begin
    AMinBufferCount := GetMinBufferCount;
    ACount := GetAbsoluteCount;
    // Check Range
    if not FGridBOF and (Node.Index <= AMinBufferCount) then
      GetNextNodes(lmPrior, rmNone, False)
    else
    if not FGridEOF and (Node.Index >= (ACount - AMinBufferCount*2)) then
      GetNextNodes(lmNext, rmNone, False);
  end;
end;

// based
procedure TCustomdxDBGrid.CorrectIdGroupNodes;

  procedure SetId(Node : TdxDBGridNode);
  var
    i : Integer;
  begin
    if Node.Count > 0 then
    begin
      if Node[0].Count > 0 then
        for I := 0 to Node.Count - 1 do SetId(TdxDBGridNode(Node[I]));
      Node.Id := TdxDBGridNode(Node[0]).Id;
      Node.FRecNo := TdxDBGridNode(Node[0]).FRecNo;
    end;
  end;

var
  i : Integer;
begin
  if GroupColumnCount > 0 then
    for i := 0 to Count - 1 do
      SetId(TdxDBGridNode(Items[i]));
end;

function TCustomdxDBGrid.GetDefaultFields: Boolean;
begin
  Result := FDefaultFields;
end;

function TCustomdxDBGrid.GetMinBufferCount: Integer;
var
  DrawInfo: TdxGridDrawInfo;
begin
  CalcRectInfo(DrawInfo);
  with DrawInfo.CellsRect do
    Result := (Bottom - Top) div RowHeight + 1;
end;

type TDummyDataSet = class(TDataSet);

procedure TCustomdxDBGrid.GetNextNodes(Mode: TdxDBGridLoadMode; ResyncMode: TdxDBGridResyncMode; SelectMode: Boolean);
const
  BufferPageCount = 5;
var
  ABufferCount: Integer;
  ASavePos: TBookmarkStr;
  ASaveBOF, ASaveEOF: Boolean;
  ASaveActiveRecord: Integer;
  RecNumber, ARecRangeNumber: Integer;
  Node: TdxDBGridNode;
  APrevNodeOffset: Integer;
  AStartBookmark, AEndBookmark: TBookmarkStr;
  ASetStartBookmark, ASelEndBookmark: TBookmarkStr;

  procedure AssignNode(ABackward: Boolean);
  var
    B: TBookmarkStr;
  begin
    Node.FGroupId := Null;
    // Load Values
    AssignNodeAllValues(Node);
    Node.FRecNo := RecNumber;
    B := DataLink.DataSet.Bookmark;
    // restore selected (bookmars)
    if FSaveBkmList.Count > 0 then
      RestoreBookmark(Node, B, ABackward);
    // select if SelectNodes
    if SelectMode then
    begin
      if Mode = lmAllRecords then
      begin
        if CanNodeSelected(Node) then
          BkmList.AddObject(B, Node);
      end
      else
      begin
        if (CompareBkm(ASetStartBookmark, B) <= 0) and
          (CompareBkm(B, ASelEndBookmark) <= 0) and
          CanNodeSelected(Node) then
        begin
          if ABackward then
            BkmList.InsertObject(0, B, Node)
          else BkmList.AddObject(B, Node);
        end;
      end;
    end;
    if CompareBkm(B, FBkmSelectionAnchor) = 0 then
      SelectionAnchor := Node;
    // Assign propery Data: Pointer
    DoRefreshNodeData(Node);
  end;

begin
  // get records
  if (DataLink.DataSet <> nil) and (DataLink.DataSet.Active) then
  with DataLink.DataSet do
  begin
    DataChangedBusy := True;
    Inc(FTopVisibleUpdate);
    try
      // reset FKeyField
      FKeyField := nil;
      if FDataLink.Active and (KeyField <> '') then
        FKeyField := FDataLink.DataSet.FindField(KeyField);
      // calc min BufferCount
      ABufferCount := GetMinBufferCount * BufferPageCount;
      if PartialLoadBufferCount > ABufferCount then
        ABufferCount := PartialLoadBufferCount;
      BeginUpdate;
      // DateSet
      try
        DisableControls;
        if Active and (State in dsEditModes) then
          Cancel;
        ASavePos := Bookmark;
        ASaveBOF := BOF;
        ASaveEOF := EOF;
        ASaveActiveRecord := TDummyDataSet(DataLink.DataSet).ActiveRecord;
        if Datalink.BufferCount <> 1 then Datalink.BufferCount := 1;
        try
          // save pos
          if State in dsEditModes then Cancel;
          // read data
          case Mode of
            // DataChanged
            lmCurrent, lmAllRecords: begin
              // save Top offset
              if (FocusedNode <> nil) and (TopVisibleNode <> nil) then
                APrevNodeOffset := FocusedNode.AbsoluteIndex - TopVisibleNode.AbsoluteIndex
              else APrevNodeOffset := 0;
              ClearNodes; // check empty
              // load records
              if BOF and EOF then {Empty DataSet}
              begin
                FGridBOF := True;
                FGridEOF := True;
              end
              else
              if Mode = lmAllRecords then
              begin
                FSaveBkmList.Clear;
                RecNumber := 0;
                First;
                while not EOF do
                begin
                  Node := TdxDBGridNode(Self.Add);
                  AssignNode(False);
                  Inc(RecNumber);
                  Next;
                end;
                FGridBOF := True;
                FGridEOF := True;
              end
              else
              begin
                // Calc Ranges
                if FSaveBkmList.Count > 0 then
                begin
                  AStartBookmark := FSaveBkmList[0];
                  AEndBookmark := FSaveBkmList[FSaveBkmList.Count - 1];
                  if CompareBkm(ASavePos, AStartBookmark) < 0 then
                    AStartBookmark := ASavePos;
                  if CompareBkm(ASavePos, AStartBookmark) > 0 then
                    AEndBookmark := ASavePos;
                end
                else
                begin
                  AStartBookmark := '';
                  AEndBookmark := AStartBookmark;
                end;
                // Calc Sel Ranges
                if SelectMode then // SelectNodes
                begin
                  ASetStartBookmark := FBkmSelectionAnchor;
                  ASelEndBookmark := Bookmark;
                  if CompareBkm(ASetStartBookmark, ASelEndBookmark) > 0 then
                  begin
                    ASetStartBookmark := ASelEndBookmark;
                    ASelEndBookmark := FBkmSelectionAnchor;
                  end;
                  // Correct Ranges
                  if AStartBookmark = '' then AStartBookmark := ASetStartBookmark;
                  if AEndBookmark = '' then AEndBookmark := ASelEndBookmark;
                  if CompareBkm(ASetStartBookmark, AStartBookmark) < 0 then
                    AStartBookmark := ASetStartBookmark;
                  if CompareBkm(AEndBookmark, ASelEndBookmark) < 0 then
                    AEndBookmark := ASelEndBookmark;
                end
                else
                begin
                  ASetStartBookmark := '';
                  ASelEndBookmark := '';
                end;
                //
                ARecRangeNumber := ABufferCount div 2;
                RecNumber := ARecRangeNumber - 1;
                // go top
                while (RecNumber >= 0) or
                  ((AStartBookmark <> '') and (CompareBkm(Bookmark, AStartBookmark) >= 0)) do
                begin
                  Node := TdxDBGridNode(Self.Insert(Items[0]));
                  AssignNode(True);
                  Prior;
                  if not BOF then Dec(RecNumber)
                  else Break;
                end;
                FGridBOF := BOF;
                // restore start pos
                MoveBy(ARecRangeNumber - RecNumber);
                RecNumber := ARecRangeNumber;
                ARecRangeNumber := RecNumber + (ABufferCount - Self.Count);
                if ARecRangeNumber < ABufferCount then
                  ARecRangeNumber := ABufferCount;
                // go bottom
                while not EOF and ((RecNumber < ARecRangeNumber) or
                  ((AEndBookmark <> '') and (CompareBkm(Bookmark, AEndBookmark) <= 0))) do
                begin
                  if (AEndBookmark <> '') and (RecNumber >= ARecRangeNumber) and
                    (CompareBkm(Bookmark, AEndBookmark) = 0) then
                    ARecRangeNumber := RecNumber + ABufferCount div 2;
                  Node := TdxDBGridNode(Self.Add);
                  AssignNode(False);
                  Inc(RecNumber);
                  Next;
                end;
                FGridEOF := EOF;
                // remove bookmarks without clear nodes
                if IsUseBookmarks then
                  RemoveDuplicateBookmarks(False);
              end;
              // correct TopIndex
              if ResyncMode = rmTop then
                APrevNodeOffset := 0
              else
              if ResyncMode = rmBottom then
                APrevNodeOffset := TopIndex - RowCount;
              // restore Top Offset
              TopIndex := TopIndex - APrevNodeOffset;
            end;
            // Scroll Up
            lmPrior: begin
              if Self.Count > 0 then
              begin
                RecNumber := TdxDBGridNode(TopNode).RecNo - 1;
                ARecRangeNumber := TdxDBGridNode(FocusedNode).RecNo;
                MoveBy(RecNumber - ARecRangeNumber);
              end
              else RecNumber := 0;
              ARecRangeNumber := RecNumber - ABufferCount;
              // go top
              while not BOF and (RecNumber > ARecRangeNumber) do
              begin
                Node := TdxDBGridNode(Self.Insert(Items[0]));
                AssignNode(True);
                Prior;
                Dec(RecNumber);
              end;
              FGridBOF := BOF;
            end;
            // Scroll Down
            lmNext: begin
              if Self.Count > 0 then
              begin
                RecNumber := TdxDBGridNode(FocusedNode).RecNo;
                ARecRangeNumber := TdxDBGridNode(LastNode).RecNo + 1;
                MoveBy(ARecRangeNumber - RecNumber);
                RecNumber := ARecRangeNumber;
              end
              else RecNumber := 0;
              ARecRangeNumber := RecNumber + ABufferCount;
              // go bottom
              while not EOF and (RecNumber < ARecRangeNumber) do
              begin
                Node := TdxDBGridNode(Self.Add);
                AssignNode(False);
                Inc(RecNumber);
                Next;
              end;
              FGridEOF := EOF;
            end;
          end;
        finally
          // restore pos
          with TDummyDataSet(Datalink.DataSet) do
          begin
            if (Length(ASavePos) > 0) and BookmarkValid(TBookmark(ASavePos)) then
              Bookmark := ASavePos;
            if ActiveRecord > ASaveActiveRecord then
            begin
              MoveBy(BufferCount - ActiveRecord - 1 + ActiveRecord - ASaveActiveRecord);
              MoveBy(ASaveActiveRecord - BufferCount + 1);
            end
            else
              if ActiveRecord < ASaveActiveRecord then
              begin
                MoveBy(-ActiveRecord + ActiveRecord - ASaveActiveRecord);
                MoveBy(ASaveActiveRecord);
              end;
            if ASaveBOF and not BOF then Prior;
            if ASaveEOF and not EOF then Next;
            EnableControls;
          end;
        end;
      finally
        EndUpdate;
      end;
    finally
      Dec(FTopVisibleUpdate);
      DataChangedBusy := False;
      if Mode = lmAllRecords then UpdateActive;
    end;
  end;
end;

procedure TCustomdxDBGrid.FindNodeById;

  function IsNodeIdEqual(ANode: TdxDBGridNode; const AID: Variant): Boolean;
  begin
    Result := not VarIsEmpty(ANode.Id) and (ANode.Id = AID);
  end;

  procedure GotoNode(Node: TdxTreeListNode);
  begin
    if egoSeekDetail in Options then
      while Node.Count > 0 do Node := Node[0];
    Node.MakeVisible;
    Node.Focused := True;
  end;

var
  Id, V: Variant;
  I: Integer;
  Column: TdxDBTreeListColumn;
  Node, ANode: TdxDBGridNode;
begin
  if (FKeyField = nil) or not (egoCanNavigation in Options) then Exit;
  if DataChangedBusy then Exit;
  Id := FKeyField.Value;
  Node := TdxDBGridNode(Items[0]);
  if Node = nil then Exit;
  if (GroupColumnCount > 0) then
  begin
    for i := 0 to GroupColumnCount - 1 do
    begin
      Column := GroupColumns[i];
      V := Column.Field.Value;
      if not FindGroupNode(Node, V , ANode, Column.Sorted = csDown, 0) then Exit;
      if (ANode = nil) or (ANode.Count = 0) then Exit;
      Node := TdxDBGridNode(ANode[0]);
    end;
    if (ANode <> Nil) then
    begin
      if IsNodeIdEqual(ANode, Id) and IsNodeIdEqual(ANode[0] as TdxDBGridNode, Id) then
      begin
        if IsNodeIdEqual(ANode[0] as TdxDBGridNode, Id) and ANode[0].Focused then
          GotoNode(ANode[0])
        else
        begin
          if DataChangedBusy or FInUpdateActive then
          begin
            while not ANode.IsVisible and (ANode.Parent <> Nil) and
              (TdxDBGridNode(ANode.Parent).Id = Id) do ANode := TdxDBGridNode(ANode.Parent);
          end;
          GotoNode(ANode);
        end;
      end
      else
      for i := 0 to ANode.Count - 1 do
      try
        if IsNodeIdEqual(ANode[I] as TdxDBGridNode, Id) then
        begin
          GotoNode(ANode[i]);
          Exit;
        end;
      except end;
    end;
  end
  else {for LoadAllRecords options}
  begin
    for i := 0 to Self.Count - 1 do
    try
      if IsNodeIdEqual(Items[I] as TdxDBGridNode, Id) then
      begin
        GotoNode(Items[i]);
        Exit;
      end;
    except end;
  end;
end;

procedure TCustomdxDBGrid.LoadGroupList(FNodes: TList);

  function FindNodeId(var Node: TdxDBGridNode; const Value: Variant): Boolean;
  var
    L, H, I: Integer;
  begin
    Result := False;
    L := 0;
    H := FNodes.Count - 1;
    while L <= H do
    begin
      I := (L + H) shr 1;
      if (TdxDBGridNode(FNodes[I]).Id = Value) then
      begin
        if (TdxDBGridNode(FNodes[I]).Parent = Node) then
        begin
          Node := TdxDBGridNode(FNodes[I]);
          FNodes.Delete(I);
          Result := True;
        end;
        Break;
      end
      else
        {$IFNDEF DELPHI6}
        if (TdxDBGridNode(FNodes[I]).Id < Value) then L := I + 1
        else H := I - 1;
        {$ELSE}
        if VarCompare(TdxDBGridNode(FNodes[I]).Id, Value) < 0 then
          L := I + 1
        else
          H := I - 1;
        {$ENDIF}
    end;
  end;

  function FindNullGroupField: Boolean;
  var
    i : Integer;
  begin
    Result := False;
    for i:= 0 to GroupColumnCount - 1 do
      if not Assigned(GroupColumns[i].Field) or
         (GroupColumns[i].Field is TBlobField) then
      begin
        Result := True;
        Exit;
      end;
  end;

  procedure LoadBookmark(Node: TdxDBGridNode);
  var
    B: TBookmarkStr;
    Index: Integer;
  begin
    B := DataLink.DataSet.Bookmark;
    if (Length(B) > 0) and
      ((Node.Count = 0) or (BkmList.IndexOfObject(Node) = -1)) and
      CanNodeSelected(Node) then
    begin
      FindBkm(B, Index);
      BkmList.InsertObject(Index, B, Node);
    end;
  end;

var
  Current : TBookMarkStr;
  i : Integer;
  Column : TdxDBTreeListColumn;
  Node, ANode, CurNode, ATopNode : TdxDBGridNode;
  V : Variant;
  OldCursor : TCursor;
  RecNumber, FilteredRecNumber: Integer;
  VNode: TdxDbGridNode;
  k, C, StartIndex: Integer;
  ASmartReload: Boolean;
  FldList, FooterFldList: TList;
  ABOF, AEOF: Boolean;
  {$IFDEF EGRID_DEBUG} t1, t2: LongInt; {$ENDIF}

  function IsNodeFilterVisible(ATestNode: TdxDBGridNode): Boolean;
  begin
    Result := NodeFilterTestVisible(ATestNode);
    if Result then
      Inc(FilteredRecNumber);
  end;

begin
  if (csLoading in ComponentState) then Exit;
  if IsPartialLoad then
  begin
    AssignPreviewField;
    GetNextNodes(lmCurrent, rmNone, False);
    Exit;
  end;
  {$IFDEF EGRID_DEBUG} t1 := GetTickCount; {$ENDIF}
  DataChangedBusy := True;
  try
    FKeyField := Nil;
    if FDataLink.Active and (KeyField <> '') then
      FKeyField := FDataLink.DataSet.FindField(KeyField);
    if not Assigned(FKeyField) and (egoCanNavigation in Options) then Exit;

    Inc(FLockGrouping);
    try
      if FDataLink.Active and DataLink.DataSet.Active then
         for I := GroupColumnCount-1 downto 0 do
           with GroupColumns[I] do
            if Field = nil then DeleteGroupColumn(I);
    finally
      Dec(FLockGrouping);
    end;

    if (not IsGridMode) and not FindNullGroupField and
      (DataLink.DataSet <> nil) and (DataLink.DataSet.Active) then
    with DataLink.DataSet do
    begin
      SelectionAnchor := nil;
      ASmartReload := IsSmartReload;
      AssignPreviewField;
      AssignSummaryFields;
      if not ASmartReload then AssignSummaryFooterFields; {***}
      {save top visible position}
      ATopNode := nil;
      if VarType(FOldTopVisibleId) = varEmpty then
      begin
        FOldTopVisibleId := Null;
        FOldTopVisibleLevel := 0;
      end;

      if not ASmartReload then {***}
      begin
        {save DataSet Position}
//        Current := Bookmark;
        DisableControls;
        if DataLink.Active and
          (DataLink.DataSet.State in dsEditModes) then
             DataLink.DataSet.Cancel;
        Current := Bookmark;
      end;
      OldCursor := Screen.Cursor;
      if IsShowHourGlass then
         Screen.Cursor := crHourglass;    { Show hourglass cursor }
      FldList := TList.Create;
      try
        MakeSummaryFieldList(FldList);
        ABOF := BOF;
        AEOF := EOF;
        if not ASmartReload then
          First;
        RecNumber := 0;
        FilteredRecNumber := 0;
        // new - summary
        DoClearNodeData;
        DoBeforeCalcSummary;
        if IsFilterMode then PrepareFilter;
        if not ASmartReload then // normal
        begin
          FooterFldList := TList.Create;
          try
            MakeSummaryFooterFieldList(FooterFldList);
            while not EOF do
            begin
              Node := nil;
              if (GroupColumnCount <> 0) then
              begin
                for i:= 0 to GroupColumnCount - 1 do
                begin
                  CurNode := Node;
                  Column := GroupColumns[i];
                  V := Column.Field.Value;
                  if Node = nil then
                    Node := TdxDBGridNode(Items[0])
                  else Node := TdxDBGridNode(Node[0]);
                  if not FindGroupNode(Node, V , ANode, Column.Sorted = csDown, 0) then
                  begin
                    if ANode = nil then //add
                      if (i > 0) then
                        Node := TdxDBGridNode(CurNode.AddChild)
                      else
                        if (Node = nil) or (Node.Parent = nil) then
                          Node := TdxDBGridNode(Self.Add)
                        else Node := TdxDBGridNode(Node.Parent.AddChild)
                    else
                      if ANode.Parent <> Nil then Node := TdxDBGridNode(ANode.Parent.InsertChild(ANode))
                      else Node := TdxDBGridNode(Self.Insert(ANode));
                    Node.FGroupId := V;
                    if Assigned(FKeyField) then Node.Id := FKeyField.Value;
                    // assign values
                    AssignNodeValues(TdxDBGridNode(Node), Column);
                    Node.FRecNo := RecNumber;
                    {Assign propery Data: Pointer}
                    DoRefreshNodeData(Node);
                  end
                  else
                    Node := ANode;
                  // select all
                  if FSelectAllFlag then LoadBookmark(Node);
                end;
                {Add (or Find) Child Node }
                if (FNodes = nil) or (not Assigned(FKeyField)) or
                   (not FindNodeId(TdxDBGridNode(Node), FKeyField.Value)) then
                  Node := TdxDBGridNode(Node.AddChild);
              end
              else
              begin
                V := Null;
                Node := TdxDBGridNode(Self.Add);
                Node.FGroupId := V;
                {restore selected (bookmars) - new}
                if IsUseBookmarks then
                  RestoreBookmark(Node, Bookmark, False);
              end;
              {Load Values}
              AssignNodeAllValues(Node);
              Node.FRecNo := RecNumber;
              {Assign propery Data: Pointer}
              DoRefreshNodeData(Node);
              // Check Filter
              if IsNodeFilterVisible(Node) then
              begin
                // select all
                if FSelectAllFlag then LoadBookmark(Node)
                else
                  if not IsUseBookmarks then RestoreSelected(Node);
                // Load summary values - send parent node method
                if Node.Parent <> nil then
                  LoadSummaryValues(TdxDBGridNode(Node.Parent), nil, FldList);
                // Load Summary Footer for current record
                LoadSummaryFooterValues(nil, FooterFldList);
                if FOldTopVisibleId = Node.Id then
                begin
                  ATopNode := Node;
                  while (ATopNode.Parent <> nil) and
                    (FOldTopVisibleLevel < ATopNode.Level) do
                    ATopNode := TdxDBGridNode(ATopNode.Parent);
                end;
              end;
              Next;
              Inc(RecNumber);
            end;
            if TopVisibleNode = nil then // Filter
              ResetTopFocusedNodes;
          finally
            FooterFldList.Free;
          end;
        end
        else
        begin
          if (Items[0] <> nil) and (Items[0].Count > 0) then
            MoveNodesToRoot;
          RecNumber := Count;
          if (GroupColumnCount <> 0) then
          begin
            C := Count;
            for k := 0 to Count - 1 do
            begin
              VNode := TdxDBGridNode(Items[0]);
// CHeck Filter if ... visible then (filter)  
              // Check Filter  
              if IsNodeFilterVisible(VNode) then
              begin
                Node := nil;
                for I := 0 to GroupColumnCount - 1 do
                begin
                  CurNode := Node;
                  Column := GroupColumns[I];
                  if Column <> nil then
                    V := GetColumnVariantData(VNode, Column);
                  if Node = Nil then
                  begin
                    Node := TdxDBGridNode(Items[0]);
                    StartIndex := C - k;
                  end
                  else
                  begin
                    Node := TdxDBGridNode(Node[0]);
                    StartIndex := 0;
                  end;
                  if not FindGroupNode(Node, V , ANode, Column.Sorted = csDown, StartIndex) then
                  begin
                    if ANode = Nil then //add
                      if (i > 0) then
                        Node := TdxDBGridNode(CurNode.AddChild)
                      else
                      if (Node = Nil) or (Node.Parent = Nil) then
                        Node := TdxDBGridNode(Self.Add)
                      else Node := TdxDBGridNode(Node.Parent.AddChild)
                    else
                      if ANode.Parent <> Nil then Node := TdxDBGridNode(ANode.Parent.InsertChild(ANode))
                      else Node := TdxDBGridNode(Self.Insert(ANode));
                    Node.FGroupId := V;
                    Node.Id := VNode.Id;
                    Node.VariantData[Column.Index] := VNode.VariantData[Column.Index];
                    Node.Strings[Column.Index] := VNode.Strings[Column.Index];
                    Node.FRecNo := VNode.FRecNo;
                    {Assign propery Data: Pointer}
                    DoRefreshNodeData(Node);
                  end
                  else
                    Node := ANode;
                end;
                {Add (or Find) Child Node }
                VNode.InternalMoveAsChild(Node, 0);
                {Load summary values - send parent node method}
                if VNode.Parent <> nil then
                  LoadSummaryValues(TdxDBGridNode(VNode.Parent), VNode, FldList);
              end;
            end;
            ResetTopFocusedNodes;
          end
          else
          begin
            for I := 0 to Count - 1 do
            begin
              Node := TdxDBGridNode(Items[I]);
              Node.FGroupId := Null;
              {restore selected (bookmars) - new}
              RestoreBookmark(Node, Bookmark, False);
              IsNodeFilterVisible(Node);
            end;
            if TopVisibleNode = nil then // Filter
              ResetTopFocusedNodes;
          end;
        end;

        if IsFilterMode then
          FTotalSummaryCount := FilteredRecNumber
        else
          FTotalSummaryCount := RecNumber;

        { free deleted nodes}
        if FNodes <> nil then
          for i := 0 to FNodes.Count - 1 do
            if FNodes[i] <> Nil then
            begin
              Node := TdxDBGridNode(FNodes[i]);
              DeleteRecurse(Node);
            end;

        {sorting}
        RefreshSorting;
        {calc summary}
        CalcSummary(ASmartReload);
        {group sorting - if SortBySummary}
        SortingBySummary;
        {correct group nodes id}
        CorrectIdGroupNodes;

        if not ASmartReload then {***}
        begin
          if (Length(Current) > 0) and BookmarkValid(TBookmark(Current)) then
            Bookmark := Current;
//TODO?          Bookmark := Current; {restore dataset pos}
          if ABOF <> AEOF then
          begin
            if ABOF then Prior
            else
            if AEOF then Next;
          end;
          // TODO seek to group node id
          if egoCollapsedReload in OptionsEx then
          begin
            Node := TdxDBgridNode(Items[0]);
            if (GroupColumnCount > 0) and (Node <> nil) and (egoCanNavigation in Options) then
            begin
              Column := GroupColumns[0];
              V := Column.Field.Value;
              if FindGroupNode(Node, V , ANode, Column.Sorted = csDown, 0) then
              begin
                if (ANode <> nil) and not ANode.Expanded then
                  if IsUseLocate then
                  begin
                    DataChangedBusy := False;
                    try
                      LocateByNode(TdxDBgridNode(FocusedNode), TdxDBgridNode(ANode), TdxDBGridNode(ANode).Id, True);
                    finally
                      DataChangedBusy := True;
                    end;
                  end
                  else
                  begin
                    First;
                    FDatalink.DataSet.MoveBy(ANode.RecNo);
                  end;
              end;
            end;
          end;
        end;
        {restore top visible pos}
        if ATopNode <> nil then
          TopIndex := GetAbsoluteIndex(ATopNode);
      finally
        FldList.Free;
        Screen.Cursor := OldCursor;  { Always restore to normal }
        if not ASmartReload then {***}
          EnableControls;
      end;
    end;
  finally
    DataChangedBusy := False;
    FlagSmartReload := False;
  end;
  {$IFDEF EGRID_DEBUG}
  t2 := GetTickCount;
  if Assigned(OnDebugEvent) then OnDebugEvent(Self, etLoadData, t2 - t1);
  {$ENDIF}
end;

function TCustomdxDBGrid.LocateByNode(OldNode, Node: TdxDBgridNode;
  const Value: Variant; UseLocate: Boolean) : Boolean;
var
  Distance: Integer;
//  FlagEqual: Boolean;
  PrevNode: TdxDBGridNode;
begin
  Result := True;
  if DataChangedBusy then Exit;
  if (FKeyField <> nil) and (FKeyField.Value = Node.Id) and
     (OldNode = Node) or ((Node = FUpdatingNode) and Datalink.Active and
     (Datalink.DataSet.State = dsInsert)) then Exit;
  if not (egoCanNavigation in Options) then Exit;
  DataChangedBusy := True;
  try
    try
      if FDatalink.Active then
      begin
        DataChangedBusy := not (FDatalink.DataSet.State in dsEditModes);
        if UseLocate then
        begin
          DataChangedLocate := True;
          FDatalink.DataSet.Locate(KeyField, Value, []);
        end
        else
        begin
          FLocateByNode := True;
          try
//            FDatalink.DataSet.MoveBy(Node.RecNo - OldNode.RecNo);
            with FDatalink.DataSet do
            begin
              PrevNode := OldNode;
//              FlagEqual := False;
              if (State = dsInsert) and (OldNode <> LastNode) then
              begin
                PrevNode := OldNode.GetNextNode as TdxDBGridNode;
                if PrevNode = nil then
                  PrevNode := OldNode.GetPriorNode as TdxDBGridNode;
                if PrevNode = nil then
                  PrevNode := OldNode;
//                FlagEqual := Node.RecNo = PrevNode.RecNo;
              end;
              Distance := Node.RecNo - PrevNode.RecNo;
              MoveBy(Distance);
              Scroll(0); // TODO new
//              if FlagEqual or
//                ((Distance > 0) and EOF) or ((Distance < 0) and BOF) then Scroll(0);
            end;
          finally
            FLocateByNode := False;
          end;
        end;
      end;
    except
      Result := False;
      raise;
    end;
  finally
    if UseLocate then
      DataChangedLocate := False;
    DataChangedBusy := False;
  end;
end;

procedure TCustomdxDBGrid.RefreshGroupList;
var
  List: TList;
  I: Integer;

  procedure LoadNodes(Node: TdxTreeListNode);
  var
    I: Integer;
  begin
    TdxDBGridNode(Node).FAssignedSummary := False;
    if Node.Count > 0 then
      if Node[0].Count > 0 then
        for I := 0 to Node.Count - 1 do LoadNodes(Node[I])
      else Node.AddNodesToList(List);
  end;

begin
  FOldTopVisibleId := Null;
  FOldTopVisibleLevel := 0;
  // reset smart flags
  FlagSmartReload := False;
  FlagFullRefresh := False;
  if (GroupColumnCount < 1) and not (egoLoadAllRecords in Options) and
    not IsPartialLoad then 
  begin
    ClearNodes;
    // ClearSelection;
    RemoveDuplicateBookmarks(True);
    Exit;
  end;
  BeginUpdate;
  try
    {save Bookmarks}
    SaveBookmarks;
    {save top visible position}
    if TopVisibleNode <> nil then
    begin
      FOldTopVisibleId := TdxDBGridNode(TopVisibleNode).Id;
      FOldTopVisibleLevel := TopVisibleNode.Level;
    end;
    if not IsGridMode and not IsPartialLoad then
      if (GroupColumnCount = 0) or
        ((Count = 1) and not Items[0].HasChildren {Append in Empty Dataset}) then
      begin
        ClearNodes;
        ClearSelection;
      end;
    List := TList.Create;
    try
      { load nodes in List }
      if (Count > 0) and (Items[0].HasChildren) then
        for i := 0 to Count - 1 do LoadNodes(Items[i]);
      List.Sort(CompareNodeId);
      { reload nodes}
      LoadGroupList(List);
    finally
      List.Free;
    end;
  finally
    {clear Bookmarks}
    ClearBookmarks;
    EndUpdate;
  end;
end;

procedure TCustomdxDBGrid.RefreshNodeValues(var Node: TdxDBTreeListControlNode);

  function FindDetailNode(Node: TdxDBGridNode; const Id: Variant): TdxDBGridNode;
  var
    i: Integer;
  begin
    Result := nil;
    for i := 0 to Node.Count - 1 do
      if TdxDBGridNode(Node[i]).Id = Id then
      begin
        Result := TdxDBGridNode(Node[i]);
        if Result.Count > 0 then
          Result := FindDetailNode(Result, Id);
        Break;
      end;
  end;
  
begin
  if not IsGridMode and (egoCanNavigation in Options) and (Node <> nil) and
    Assigned(FKeyField) then
  begin
    if Node.Count > 0 then // find Detail Node
      Node := FindDetailNode(Node as TdxDBGridNode, FKeyField.Value);
    if Node <> nil then
    begin
      AssignNodeAllValues(Node);
      {Assign propery Data: Pointer}
      DoRefreshNodeData(Node);
    end;
  end;
  if IsRowAutoHeight or (IsShowPreview and IsAutoCalcPreviewLines) then
  begin
    // reset node height
    ClearNodeRowHeight;
    Invalidate;
  end
  else InvalidateRect(GetRectNode(Node));
end;

procedure TCustomdxDBGrid.ReLoadGroupList;
var
  i : integer;
begin
  BeginUpdate;
  try
    HideEditor;
    if not IsSmartReload then ClearNodes;
    ClearSelection;
    FDatalink.ClearMapping;
    if FDatalink.Active then DefineFieldMap;
    { Force columns to reaquire fields (in case dataset has changed) }
    for I := 0 to ColumnCount-1 do
       Columns[I].FieldName := Columns[I].FieldName;
    LoadGroupList(nil);
    if Assigned(FOnReloadGroupList) then FOnReloadGroupList(Self);
  finally
    EndUpdate;
  end;
end;

procedure TCustomdxDBGrid.RemoveDuplicateBookmarks(AClearNodes: Boolean);
var
  I: Integer;
begin
  for I := BkmList.Count - 1 downto 1 do
  begin
    if CompareBkm(BkmList[I], BkmList[I - 1]) = 0 then
      BkmList.Delete(I)
    else
    if AClearNodes then
      BkmList.Objects[I] := nil;
  end;
end;

procedure TCustomdxDBGrid.Scroll(Distance: Integer);
var
  OldRect, NewRect: TRect;
  DScroll: Integer;
begin
  if IsGridMode then
  begin
    if HandleAllocated then
    begin
      if IsRowAutoHeight or (IsShowPreview and IsAutoCalcPreviewLines) then
      begin
        UpdateScrollBars;
        Invalidate;
      end
      else
      begin
        OldRect := GetRectNode(FocusedNode);
        UpdateScrollBars;
        NewRect := GetRectNode(FocusedNode);
        ValidateRect(Handle, @OldRect);
        Windows.InvalidateRect(Handle, @OldRect, False);
        Windows.InvalidateRect(Handle, @NewRect, False);
        if Distance <> 0 then
        begin
          // scrolling
          if Abs(Distance) > RowCount then
            Invalidate
          else
          begin
            DScroll := GetRowHeight(FocusedNode, DefaultRowHeight, True{ReCalc})*Distance;
            HideDragImages;
            try
              ScrollGridVert(DScroll);
            finally
              ShowDragImages;
            end;
          end;
        end;
      end;
    end;
  end
  else
  begin
    if IsPartialLoad and (Distance <> 0) then
    begin
      DScroll := -Distance;
      SaveBookmarks;
      try
        if DScroll > 0 then
        begin
          if DScroll > (TdxDBGridNode(LastNode).RecNo - TdxDBGridNode(FocusedNode).RecNo) then
            GetNextNodes(lmCurrent, rmBottom, False);
        end
        else
        begin
          if DScroll < (TdxDBGridNode(TopNode).RecNo - TdxDBGridNode(FocusedNode).RecNo) then
            GetNextNodes(lmCurrent, rmTop, False);
        end;
      finally
        ClearBookmarks;
      end;
    end;
    UpdateActive;
  end;
  // new
  if egoSyncSelection in OptionsEx then
    ResyncSelection;
  DoChangeNodeEx;
end;

procedure TCustomdxDBGrid.SetGroupIndex(AColumn: TdxDBTreeListColumn; AIndex: Integer);
begin
  with TdxDBGridColumn(AColumn) do
  if (FGroupIndex <> AIndex) or FRefreshGroupColumns then
  begin
    BeginUpdate;
    BeginGrouping;
    try
      if (FGroupIndex <> -1) and not FRefreshGroupColumns then
      begin
        DeleteGroupColumn(FGroupIndex);
      end;
      if AIndex <> -1 then
         InsertGroupColumn(AIndex, AColumn);
    finally
      EndGrouping;
      EndUpdate;
    end;
  end;
end;

procedure TCustomdxDBGrid.SmartRefreshNode;
var
  V: Variant;
  i: Integer;
  Node: TdxDBGridNode;
  Flag: Boolean;

  function FindNodeId(var Node: TdxDBGridNode; AUpdatingNode: TdxDBGridNode): Boolean;
  var
    i: Integer;
    ANode: TdxDBGridNode;
  begin
    Result := False;
    if (Node.Id = V) and (Node <> AUpdatingNode) then
    begin
      Result := True;
      Exit;
    end
    else
      if Node.Count > 0 then
      for i := 0 to Node.Count - 1 do
      begin
        ANode := TdxDBGridNode(Node[i]);
        if FindNodeId(ANode, AUpdatingNode) then
        begin
          Node := ANode;
          Result := True;
          Exit;
        end;
      end;
  end;

  function FindOtherNodeId(ANode: TdxDBGridNode): Boolean;
  var
    Node: TdxDBGridNode;
    i: Integer;
  begin
    Result := False;
    for i := 0 to Count - 1 do
    begin
      Node := TdxDBGridNode(Items[i]);
      if FindNodeId(Node, ANode) then
      begin
        Result := True;
        Break;
      end;
    end;
  end;

  function FindId: Boolean;
  var
    Node: TdxDBGridNode;
    i: Integer;
  begin
    Result := False;
    for i := 0 to Count - 1 do
    begin
      Node := TdxDBGridNode(Items[i]);
      if FindNodeId(Node, nil) then
      begin
        Result := True;
        Break;
      end;
    end;
  end;

begin
  if not IsGridMode and (FKeyField <> Nil) and
    (egoCanNavigation in Options) then
  begin // find Detail Node
    Flag := False;
    Node := nil;
    V := FKeyField.Value;
    for i := 0 to Count - 1 do
    begin
      Node := TdxDBGridNode(Items[i]);
      if FindNodeId(TdxDBGridNode(Node), nil) then
      begin
        NodeRecordChanged(nil, TdxDBTreeListControlNode(Node));
        Flag := True;
        Break;
      end;
    end;
    // node actual ?
    if FUpdatingNode <> nil then
    begin
      Node := TdxDBGridNode(FocusedNode);
      while Node.Count > 0 do Node := TdxDBGridNode(Node[0]);
      if (FUpdatingNode.Id = Node.Id) and ((Node.Id <> V) or FindOtherNodeId(Node)) then
      begin
        if (FPrevId = V) or not FindId then
          NodeRecordChanged(nil, TdxDBTreeListControlNode(Node))
        else
        begin
          DeleteRecurse(Node);
          Node := nil;
        end;
        Flag := True;
      end;
      FUpdatingNode := nil;
    end;
    if Flag then
    begin
      // Filter (Check)
      if IsFilterMode then
      begin
        PrepareFilter;
        NodeRefreshFilter(Node, True);
        if TopVisibleNode = nil then // Filter
          ResetTopFocusedNodes;
      end
      else
        ReCalcSummary(Node);
    end;  
  end;
end;

procedure TCustomdxDBGrid.DataChanged;
begin
  // ChangeNodeEx
  if (LockSelection = 0) and Assigned(OnChangeNodeEx) then
  begin
    CheckChangeNodeEx;
    LoadChangeNodeInfo(FPrevNodeInfo);
  end;
  {***}
  if IsSmartRefresh and not DataChangedBusy and
     not DataChangedLocateResync then
  begin
    FRefreshGroupList := True;
    try
      SmartRefreshNode;
    finally
      FRefreshGroupList := False;
    end;
  end;
  if DataChangedLocate and not DataChangedBusy then
    DataChangedLocateResync := True
  else DataChangedLocateResync := False;

  if (Datalink.DataSet.State <> dsInsert) then FUpdatingNode := nil;
  {***}
  if DataChangedLocate then
  begin
    DataChangedLocate := False;
    Exit;
  end;
  if DataChangedBusy then Exit;
  if (IsDBTreeListControlDataSetBusy(Datalink.DataSet){IsBusy} or LockRefresh) and
    IsLoadAllRecords then
  begin
    Scroll(0);
    Exit;
  end;

  if IsGridMode then
  begin
    if not HandleAllocated then Exit;
    if not (Datalink.DataSet.IsEmpty and (Datalink.DataSet.State = dsInsert)) then // TODO: Check!
      UpdateScrollBars;
    if (InplaceEditor <> nil) and not InplaceEditor.DisableRefresh then
      InvalidateEditor;
    if (FDataLink.DataSet.State = dsInsert) then
    begin
      EndSearch;
      if egoResetColumnFocus in Options then FocusedColumn := 0; {new}
    end;
    ValidateRect(Handle, nil);
    Invalidate;
  end
  else
  begin
    if DataChangedBusy or (FDataLink.DataSet.State = dsEdit) or
      (FDataLink.DataSet.State = dsSetKey) then Exit;
    if Assigned(FKeyField) and (FDataLink.DataSet.State = dsInsert) then
    begin
      InsertNode(FDataLink.DataSet.EOF);
      if egoResetColumnFocus in Options then FocusedColumn := 0;
      Exit;
    end;

    FRefreshGroupList := True;
    try
      if not IsSmartRefresh then RefreshGroupList;
      if not FLocateByNode then FindNodeById;
    finally
      FRefreshGroupList := False;
    end;
  end;
end;

function TCustomdxDBGrid.IsDataSetBusy: Boolean;
begin
  Result := DataSetChangedBusy or DataChangedLocate;
end;

procedure TCustomdxDBGrid.LinkActive(Value: Boolean);
begin
  if not Value then HideEditor;
  ReLoadGroupList; {<-ClearSelection}
  if Value and (FFilterStream <> nil) then
  begin
    LoadDBGridFilterFromStream(FFilterStream, Filter);
    FFilterStream.Free;
    FFilterStream := nil;
  end;
end;

procedure TCustomdxDBGrid.RecordChanged(Field: TField);
var
  Node: TdxDBGridNode;
begin
  if not IsGridMode then
  begin
    if (FDatalink.Dataset.State = dsInsert) and
      (FUpdatingNode = nil) then Exit; {*****}
    if (FDatalink.Dataset.State = dsSetKey) then
      Exit;
  end;
  Node := TdxDBGridNode(FocusedNode);
  NodeRecordChanged(Field, TdxDBTreeListControlNode(Node));
  if (FUpdatingNode = nil) and (Node <> nil) then
    FPrevId := Node.Id;
  FUpdatingNode := Node;
end;

procedure TCustomdxDBGrid.UpdateActive;
begin
  FInUpdateActive := True;
  try
    if FDatalink.Active {and HandleAllocated} and not (csLoading in ComponentState) then
    if FDatalink.DataSet.Active then
    begin
      if IsGridMode then
      begin
        if HandleAllocated and
          (FocusedNumber <> FDatalink.ActiveRecord) then
        begin
          HideEditor;
          if FDatalink.ActiveRecord < Count then
            Items[FDatalink.ActiveRecord].Focused := True;
        end;
      end
      else
      begin
        if not HandleAllocated and (Parent <> nil) then HandleNeeded;
        if not FRefreshGroupList then FindNodeById;
        if HandleAllocated then
          inherited UpdateScrollBars;
      end;
//      if Assigned(FocusedField) and
//         (FocusedField.Text <> FEditValue) then InvalidateEditor;
      InvalidateEditorValue;
    end;
  finally
    FInUpdateActive := False;
  end;
end;

procedure TCustomdxDBGrid.BeginReadSettings(ARegIniWrapper: TdxRegIniWrapper);
begin
  inherited BeginReadSettings(ARegIniWrapper);
  BeginGrouping;
end;

procedure TCustomdxDBGrid.EndReadSettings(ARegIniWrapper: TdxRegIniWrapper);
begin
  EndGrouping;
  inherited EndReadSettings(ARegIniWrapper);
end;

procedure TCustomdxDBGrid.ReadColumn(ARegIniWrapper: TdxRegIniWrapper;
  const APathCol: string; AColumn: TdxTreeListColumn);
begin
  with ARegIniWrapper do
  begin
    TdxDBGridColumn(AColumn).GroupIndex :=
      ReadInteger(APathCol, 'GroupIndex', TdxDBGridColumn(AColumn).GroupIndex);
  end;
  inherited ReadColumn(ARegIniWrapper, APathCol, AColumn);
end;

procedure TCustomdxDBGrid.ReadSettings(ARegIniWrapper: TdxRegIniWrapper; const APath: string);
var
  AStream: TMemoryStream;
begin
  inherited ReadSettings(ARegIniWrapper, APath);
  with ARegIniWrapper do
  begin
    ShowGroupPanel := ReadBool(APath, 'ShowGroupPanel', ShowGroupPanel);
    ShowNewItemRow := ReadBool(APath, 'ShowNewItemRow', ShowNewItemRow);
    ShowRowFooter := ReadBool(APath, 'ShowRowFooter', ShowRowFooter);
    ShowSummaryFooter := ReadBool(APath, 'ShowSummaryFooter', ShowSummaryFooter);
    AStream := TMemoryStream.Create;
    try
      AStream.SetSize(ReadBinaryData(APath, 'Filter', AStream.Memory^, 0));
      ReadBinaryData(APath, 'Filter', AStream.Memory^, AStream.Size);
      if AStream.Size <> 0 then
      begin
        if (DataLink.DataSet = nil) or (DataLink.DataSet.FieldCount = 0) then
        begin
          FFilterStream := AStream;
          AStream := nil;
        end
        else
          LoadDBGridFilterFromStream(AStream, Filter);
      end;
    finally
      if AStream <> nil then
        AStream.Free;
    end;
  end;
end;

procedure TCustomdxDBGrid.WriteColumn(ARegIniWrapper: TdxRegIniWrapper;
  const APathCol: string; AColumn: TdxTreeListColumn);
begin
  inherited WriteColumn(ARegIniWrapper, APathCol, AColumn);
  with ARegIniWrapper do
  begin
    WriteInteger(APathCol, 'GroupIndex', TdxDBGridColumn(AColumn).GroupIndex);
  end;
end;

procedure TCustomdxDBGrid.WriteSettings(ARegIniWrapper: TdxRegIniWrapper; const APath: string);
var
  AStream: TMemoryStream;
begin
  inherited WriteSettings(ARegIniWrapper, APath);
  with ARegIniWrapper do
  begin
    WriteBool(APath, 'ShowGroupPanel', ShowGroupPanel);
    WriteBool(APath, 'ShowNewItemRow', ShowNewItemRow);
    WriteBool(APath, 'ShowRowFooter', ShowRowFooter);
    WriteBool(APath, 'ShowSummaryFooter', ShowSummaryFooter);
    AStream := TMemoryStream.Create;
    try
      SaveDBGridFilterToStream(AStream, Filter);
      WriteBinaryData(APath, 'Filter', AStream.Memory^, AStream.Size);
    finally
      AStream.Free;
    end;
  end;
end;

function TCustomdxDBGrid.GetNodeByNavigation(ANode: TdxTreeListNode;
  ANavigationMode: TdxTreeListNavigationMode; AGotoHidden: Boolean): TdxTreeListNode;
var
  ADataSet: TDataSet;  
begin
  if IsLoadedAll then
    Result := inherited GetNodeByNavigation(ANode, ANavigationMode, AGotoHidden)
  else
  begin
    Result := nil;
    if Assigned(DataSource) and Assigned(DataSource.DataSet) then
    begin
      ADataSet := DataSource.DataSet;
      case ANavigationMode of
        tlnmFirst:
          begin
            ADataSet.First;
            Result := FocusedNode;
          end;
        tlnmLast:
          begin
            ADataSet.Last;
            Result := FocusedNode;
          end;
        tlnmPrev:
          begin
            ADataSet.Prior;
            if not ADataSet.BOF then
              Result := FocusedNode;
          end;
        tlnmNext:
          begin
            ADataSet.Next;
            if not ADataSet.EOF then
              Result := FocusedNode;
          end;
      end;
    end;
  end;
end;

procedure TCustomdxDBGrid.CancelDragSizing;
begin
  inherited CancelDragSizing;
  if Assigned(FFilterPopupListBox) and FFilterPopupListBox.ListVisible then
    FFilterPopupListBox.ClosePopup(False);
end;

function TCustomdxDBGrid.CheckFilterNode(ANode: TdxDBGridNode): Boolean;
begin
  Result := True;
  if IsFilterMode then
    Result := Filter.CheckFilterNode(ANode);
end;

procedure TCustomdxDBGrid.ClearFilter;
begin
  FFiltering := False;
  SetFilterMode;
end;

procedure TCustomdxDBGrid.DestroyFilter;
begin
  FFilterPopupListBox.Free;
  FFilterPopupListBox := nil;
  FFilter.Free;
  FFilter := nil;
end;

function TCustomdxDBGrid.GetHeaderDropDownButtonState(AbsoluteIndex: Integer): TdxHeaderDropDownButtonState;
begin
  Result := inherited GetHeaderDropDownButtonState(AbsoluteIndex);
  if hdbNormal in Result then
  begin
    if Filter.IsColumnFilterExist(Columns[AbsoluteIndex]) then
      Result := Result + [hdbActive];
  end;
end;

function TCustomdxDBGrid.GetFilterClass: TdxDBGridFilterClass;
begin
  Result := TdxDBGridFilter; 
end;

function TCustomdxDBGrid.IsAutoFilterValuesLoad: Boolean;
begin
  Result := IsLoadAllRecords;
end;

function TCustomdxDBGrid.NodeFilterTestVisible(ATestNode: TdxDBGridNode): Boolean;
begin
  Result := not IsFilterMode or NodeRefreshFilter(ATestNode, False);
end;

function TCustomdxDBGrid.NodeRefreshFilter(ATestNode: TdxDBGridNode; ARecalc: Boolean): Boolean;
var
  ADetailList, AHiddenList: TList;
  APrevFocusedNode, ANewFocusedNode: TdxDBGridNode;

  procedure DeleteEmptyParentRecurse(ANode: TdxTreeListNode);
  var
    AParentNode: TdxTreeListNode;
  begin
    if (ANode <> nil) and (ANode.Count = 0) then
    begin
      AParentNode := ANode.Parent;
      if ANode = APrevFocusedNode then
        APrevFocusedNode := nil; 
      ANode.Free;
      DeleteEmptyParentRecurse(AParentNode);
    end;
  end;

  procedure LoadDetailNodes(ANode: TdxTreeListNode);
  var
    I: Integer;
  begin
    if ANode.Count > 0 then
      for I := 0 to ANode.Count - 1 do
        LoadDetailNodes(ANode[I])
    else
      ADetailList.Add(ANode);
  end;

  procedure MoveToGroup(ADetailNode: TdxDBGridNode);
  var
    I: Integer;
    AColumn: TdxDBGridColumn;
    V: Variant;
    ANode, CurNode, Node: TdxDBGridNode;
  begin
    Node := nil;
    for I := 0 to GroupColumnCount - 1 do
    begin
      AColumn := GroupColumns[I];
      V := GetColumnVariantData(ADetailNode, AColumn);
      CurNode := Node;
      if Node = nil then
        Node := TdxDBGridNode(Items[0])
      else
        Node := TdxDBGridNode(Node[0]);
      if not FindGroupNode(Node, V, ANode, AColumn.Sorted = csDown, 0) then
      begin
        if ANode = nil then //add
          if I > 0 then
            Node := TdxDBGridNode(CurNode.AddChild)
          else
            if (Node = nil) or (Node.Parent = nil) then
              Node := TdxDBGridNode(Self.Add)
            else
              Node := TdxDBGridNode(Node.Parent.AddChild)
        else
          if ANode.Parent <> nil then
             Node := TdxDBGridNode(ANode.Parent.InsertChild(ANode))
          else
            Node := TdxDBGridNode(Self.Insert(ANode));
        Node.FGroupId := V;
        Node.Id := ADetailNode.Id;
        Node.VariantData[AColumn.Index] := ADetailNode.VariantData[AColumn.Index];
        Node.Strings[AColumn.Index] := ADetailNode.Strings[AColumn.Index];
        Node.FRecNo := ADetailNode.FRecNo;
        // Assign propery Data: Pointer
        DoRefreshNodeData(Node);
      end
      else
        Node := ANode;
    end;
    ADetailNode.InternalMove(Node, natlAddChild);
  end;

var
  I: Integer;
  ANode, AParentNode: TdxDBGridNode;
begin
  BeginUpdate;
  try
    ADetailList := TList.Create;
    AHiddenList := TList.Create;
    try
      APrevFocusedNode := TdxDBGridNode(FocusedNode);
//      ClearListNodes; // ??
      SetEmptyNodes;
      if ATestNode = nil then
      begin
        // Load Detail Nodes
        ADetailList.Capacity := Count;
        for I := 0 to Count - 1 do
          LoadDetailNodes(Items[I]);
        // Filtering
        for I := FHiddenList.Count - 1 downto 0 do
        begin
          ANode := TdxDBGridNode(FHiddenList[I]);
          if CheckFilterNode(ANode) then
          begin
            if GroupColumnCount > 0 then // TODO Group
              MoveToGroup(ANode)
            else
              ANode.InternalMoveToRoot;
            FHiddenList.Delete(I);
          end;
        end;
        AHiddenList.Capacity := ADetailList.Count;
        for I := 0 to ADetailList.Count - 1 do
        begin
          ANode := TdxDBGridNode(ADetailList[I]);
          if not CheckFilterNode(ANode) then
            AHiddenList.Add(ANode);
        end;
      end
      else
        if not CheckFilterNode(ATestNode) then
          AHiddenList.Add(ATestNode);
      // Hide Nodes
      Result := AHiddenList.Count = 0;
      for I := 0 to AHiddenList.Count - 1 do
      begin
        ANode := TdxDBGridNode(AHiddenList[I]);
        AParentNode := TdxDBGridNode(ANode.Parent);
        ANode.InternalRemove;
//if NodeLinkList <> nil then NodeLinkList.Remove(ANode); // TODO CHECK
        DeleteEmptyParentRecurse(AParentNode);
      end;
      I := FHiddenList.Count;
      if AHiddenList.Count <> 0 then
        if AHiddenList.Count = 1 then
          FHiddenList.Add(AHiddenList.List^[0])
        else
        begin
          FHiddenList.Count := FHiddenList.Count + AHiddenList.Count;
          System.Move(AHiddenList.List^[0], FHiddenList.List^[I], AHiddenList.Count * SizeOf(Pointer));
        end;
      if ATestNode = nil then
      begin
        // Make Focused (set pos in DataSet)
        ResetTopFocusedNodes;
        ANewFocusedNode := TdxDBGridNode(FocusedNode);
        if Assigned(ANewFocusedNode) then
        begin
          if not Assigned(APrevFocusedNode) then
            SetFocusedNode(ANewFocusedNode, FocusedColumn, False)
          else
            if FHiddenList.IndexOf(APrevFocusedNode) = -1 then
              inherited SetFocusedNode(APrevFocusedNode, FocusedColumn, False)
            else
            begin
              CorrectIdGroupNodes;
              LocateByNode(APrevFocusedNode, ANewFocusedNode, ANewFocusedNode.Id, IsUseLocate);
            end;
        end;
      end;
      if (AHiddenList.Count = 1) and (AHiddenList[0] = ATestNode) then
        ATestNode := nil;
      if ARecalc {and (ATestNode <> nil)} then
        ReCalcSummary(ATestNode);
    finally
      AHiddenList.Free;
      ADetailList.Free;
    end;
  finally
    EndUpdate;
  end;
end;

procedure TCustomdxDBGrid.PrepareFilter;
begin
  Filter.Prepare;
end;

procedure TCustomdxDBGrid.RefreshFilter;
begin
  PrepareFilter;
  NodeRefreshFilter(nil, True);
end;

procedure TCustomdxDBGrid.UpdateDataSetFilter;
var
  ADataSet: TDataSet;
  S: string;
begin
  if Assigned(DataSource) then
    ADataSet := DataSource.DataSet
  else
    ADataSet := nil;
  S := Filter.FilterText;
  if Assigned(FOnFilterChanged) then
    FOnFilterChanged(Self, ADataSet, S);
  // TODO AutoDataSetFilter changed
  if Filter.AutoDataSetFilter and Assigned(ADataSet) then
  begin
    ADataSet.Filter := S;
    if Filter.CaseInsensitive then
      ADataSet.FilterOptions := ADataSet.FilterOptions + [foCaseInsensitive]
    else
      ADataSet.FilterOptions := ADataSet.FilterOptions - [foCaseInsensitive];
    ADataSet.Filtered := ADataSet.Filter <> ''; // TODO: CHECK!!!
  end;
end;

function TCustomdxDBGrid.GetStatusButtonVisible: Boolean;
begin
  Result := not Filter.IsEmpty;
end;

function TCustomdxDBGrid.GetStatusText: string;
begin
  Result := Filter.Criteria.FilterCaption;
end;

function TCustomdxDBGrid.GetStatusCloseButtonHint: string;
begin
  Result := dxSFilterStatusCloseButtonHint;
end;

procedure TCustomdxDBGrid.SetFilterMode;
begin
  FFiltering := not Filter.IsEmpty;
  RefreshFilter;
  UpdateDataSetFilter;
end;

// private
function TCustomdxDBGrid.CalcGroupPanelHeight(ColCount : Integer): Integer;
begin
  Result := HeaderRowHeight + agpHOfs*2 + (ColCount-1)*(agpHDeltaY+(HeaderRowHeight div 2))
end;

function TCustomdxDBGrid.ChangedGroupFields: Boolean;
var
  I: Integer;
begin
  Result := (FGroupFields.Count <> GroupColumnCount);
  if not Result then
  for i := 0 to GroupColumnCount - 1 do
    if AnsiCompareText(FGroupFields[i], GroupColumns[i].FieldName) <> 0 then
    begin
      Result := True;
      Exit;
    end;
end;

procedure TCustomdxDBGrid.CheckChangeNodeEx;
var
  NodeInfo: TdxChangeNodeInfo;
begin
  LoadChangeNodeInfo(NodeInfo);
  if (FPrevNodeInfo.Level <> NodeInfo.Level) or
    (FPrevNodeInfo.Selected <> NodeInfo.Selected) or
    (VarType(FPrevNodeInfo.Id) <> VarType(NodeInfo.Id)) or
    (FPrevNodeInfo.Id <> NodeInfo.Id) then
    DoChangeNodeEx;
end;

procedure TCustomdxDBGrid.ClearBookmarks;
begin
  ClearIdList;
  FSaveBkmList.Clear;
end;

procedure TCustomdxDBGrid.ClearIdList;
var
  I: Integer;
begin
  if FSaveIdList = nil then Exit;
  for I := 0 to FSaveIdList.Count - 1 do
    Dispose(PVariant(FSaveIdList[I]));
  FSaveIdList.Clear;
end;

procedure TCustomdxDBGrid.ClearGroupFields;
begin
  FGroupFields.Clear;
end;

function TCustomdxDBGrid.GetFilter: TdxDBGridFilter;
begin
  if FFilter = nil then
    FFilter := GetFilterClass.Create(Self);
  Result := FFilter;
end;

function TCustomdxDBGrid.GetFooterPanelVisible: Boolean;
begin
  Result := inherited ShowFooter;
end;

function TCustomdxDBGrid.GetGroupPanelVisible: Boolean;
begin
  Result := FGroupPanelVisible;
end;

function TCustomdxDBGrid.GetOptions: TdxDBGridOptions;
begin
  Result := FOptions;
end;

function TCustomdxDBGrid.GetOptionsEx: TdxDBGridOptionsEx;
begin
  Result := FOptionsEx;
end;

function TCustomdxDBGrid.GetOptionsBehavior: TdxDBGridOptionsBehavior;
begin
  Result := FOptionsBehavior;
end;

function TCustomdxDBGrid.GetOptionsCustomize: TdxDBGridOptionsCustomize;
begin
  Result := FOptionsCustomize;
end;

function TCustomdxDBGrid.GetOptionsDB: TdxDBGridOptionsDB;
begin
  Result := FOptionsDB;
end;

function TCustomdxDBGrid.GetOptionsView: TdxDBGridOptionsView;
begin
  Result := FOptionsView;
end;

function TCustomdxDBGrid.GetPartialLoad: Boolean;
begin
  Result := edgoPartialLoad in OptionsDB;
end;

function TCustomdxDBGrid.GetUseBookmarks: Boolean;
begin
  Result := edgoUseBookmarks in OptionsDB;
end;

procedure TCustomdxDBGrid.InsertNode(FAppend: Boolean);
var
  ANode: TdxTreeListNode;
  F: TField;
  I: Integer;
  MasterField: TField;
  VData: TNodeVariantData;
  PrevNewItemRowActive: Boolean;
begin
  ClearListNodes; // TODO: check
  ANode := FocusedNode;
  if ANode <> nil then
    while ANode.Count > 0 do ANode := ANode[0];
  if ANode <> nil then
    if ANode.Parent <> nil then
      if not FAppend then ANode := ANode.Parent.InsertChild(ANode)
      else ANode := ANode.Parent.AddChild
    else if not FAppend then ANode := Self.Insert(ANode)
         else ANode := Self.Add
  else ANode := Self.Add;
  ANode.MakeVisible;
  // no locate !
  TdxDBGridNode(ANode).Id := Null;
  TdxDBGridNode(ANode).FGroupId := Null;
  TdxDBGridNode(ANode).FRecNo := FTotalSummaryCount;
  {*****}
  AssignNodeAllValues(TdxDBGridNode(ANode));
  {*****}
  {***}
  FUpdatingNode := TdxDBGridNode(ANode);
  FPrevId := TdxDBGridNode(ANode).Id;
  {***}
  PrevNewItemRowActive := NewItemRowActive;
  ANode.Focused := True;
  if FocusedNode <> nil then // load group column values
  for I := GroupColumnCount - 1 downto 0 do
    if ANode <> nil then
    begin
      ANode := ANode.Parent;
      F := GroupColumns[I].Field;
      if Assigned(F) and (ANode <> nil) then
      begin
        if not F.Lookup and F.CanModify then
          F.Value := TdxDBGridNode(ANode).GroupId;
        if F.Lookup then
        begin
          MasterField := FDatalink.DataSet.FieldByName(F.KeyFields); // TODO multi lookup
          VData := TdxDBGridNode(ANode).VariantData[GroupColumns[I].Index];
          if MasterField.CanModify and (nadLookupValue in VData.AssignedValues) then
            MasterField.Value := VData.LookupValue;
        end;
      end;
    end;
  NewItemRowActive := PrevNewItemRowActive;
end;

procedure TCustomdxDBGrid.LoadChangeNodeInfo(var NodeInfo: TdxChangeNodeInfo);
begin
  if (FocusedNode <> nil) and
    Assigned(DataLink.DataSet) and DataLink.DataSet.Active then
  begin
    NodeInfo.Level := FocusedNode.Level;
    NodeInfo.Selected := FocusedNode.Selected;
    if Assigned(FKeyField) and Assigned(FKeyField.DataSet) then
      NodeInfo.Id := FKeyField.Value
    else NodeInfo.Id := Null;
  end
  else
  begin
    NodeInfo.Level := -1;
    NodeInfo.Id := Null;
    NodeInfo.Selected := False;
  end;
end;

function TCustomdxDBGrid.RestoreBookmark(ANode: TdxTreeListNode; const ABookmark: TBookmarkStr; ABackward: Boolean): Boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;
  L := 0;
  H := FSaveBkmList.Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := CompareBkm(FSaveBkmList[I], ABookmark);
    if C < 0 then L := I + 1
    else
    begin
      H := I - 1;
      if C = 0 then
      begin
        if ABackward then
        begin
          BkmList.Insert(0, ABookmark);
          BkmList.Objects[0] := ANode;
        end
        else
        begin
          BkmList.Add(ABookmark);
          BkmList.Objects[BkmList.Count - 1] := ANode;
        end;
        Result := True;
        FSaveBkmList.Delete(I);
        Break;
      end;
    end;
  end;
end;

procedure TCustomdxDBGrid.RestoreSelected(ANode: TdxTreeListNode);
var
  Index: Integer;
begin
  if FindIdVariant(TdxDBGridNode(ANode).Id, Index) then
  begin
    ANode.Selected := True;
    Dispose(PVariant(FSaveIdList[Index]));
    FSaveIdList.Delete(Index);
  end;
end;

function TCustomdxDBGrid.FindIdVariant(const Id: Variant; var Index: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;
  if FSaveIdList = nil then Exit;
  L := 0;
  H := FSaveIdList.Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := VarCompare(PVariant(FSaveIdList[I])^, Id);
    if C < 0 then L := I + 1 else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := True;
        L := I;
      end;
    end;
  end;
  Index := L;
end;

procedure TCustomdxDBGrid.SaveBookmarks;
var
  I: Integer;
  P: PVariant;
begin
  if not IsUseBookmarks then
  begin
    FSaveBkmList.Clear;
    if (BkmList.Count > 0) and (BkmList.Objects[0] <> nil) then
    begin
      if FSaveIdList = nil then FSaveIdList := TList.Create
      else ClearIdList;
      for I := 0 to BkmList.Count - 1 do
      begin
        New(P);
        P^ := TdxDBGridNode(BkmList.Objects[I]).Id;
        FSaveIdList.Add(P);
      end;
      FSaveIdList.Sort(CompareVariant);
    end;
  end
  else
    FSaveBkmList.Assign(BkmList);
end;

procedure TCustomdxDBGrid.SaveGroupFields;
var
  I: Integer;
begin
  FGroupFields.Clear;
  for I := 0 to GroupColumnCount - 1 do
    FGroupFields.Add(GroupColumns[I].FieldName);
  if IsGridMode then
    FPrevReloadMode := rlGridMode
  else FPrevReloadMode := rlAllRecords;
end;

procedure TCustomdxDBGrid.ScrollGroupPanel;
const
  MaxTimeScroll = 400; {400 ms}
  hOne = 20;           {pixels - scroll on one pixel}
var
  R, R1: TRect;
  k, i, h, d, j: Integer;
  t1, t2: LongInt;
  FlagUp, Done: Boolean;
  DrawInfo: TdxGridDrawInfo;
begin
  h := CalcGroupPanelHeight(GroupColumnCount);
  t1 := GetTickCount;
  Done := False;
  FlagUp := not ShowGroupPanel;
  CalcRectInfo(DrawInfo);
  with DrawInfo do
  begin
    R := CRect;
    if not IsRectEmpty(FooterRect) then
      R.Bottom := FooterRect.Top
  end;
  d := -1;
  if not FlagUp then d := -d;
  R1 := R;
  if not FlagUp then R1 := Rect(R1.Left, 0, R1.Right, 0)
  else R1.Top := R1.Bottom;
  i := 0;
  k := (R.Bottom - R.Top) div 256;
  if k = 0 then k := 1;
  while (not Done) do
  begin
    if i <= hOne then
    begin
      j := d*k
    end
    else
    begin
      Inc(k);
      j := d*k;
    end;
    if ((i + abs(j)) > h) or (abs(j) > ((h-i) div 2) ) then j := d*(h - i);
    ScrollWindowEx(Handle, 0, j, @R, @R, 0, nil, SW_Invalidate);
    Inc(i, abs(j));
    if not FlagUp then
    begin
      R1.Bottom := i;
      Canvas.Brush.Color := dxclGroupPanel;
    end
    else
    begin
      R1.Top := R1.Bottom - i;
      Canvas.Brush.Color := Color;
    end;
    Canvas.FillRect(R1);

    t2 := GetTickCount;
    Done := ((t2 - t1) > MaxTimeScroll) or (i >= h);
  end;
end;

procedure TCustomdxDBGrid.SetDataSource(Value: TDataSource);
begin
  if Value = FDatalink.Datasource then Exit;
  ClearSelection;
  FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
  if IsGridMode then
    LinkActive(FDataLink.Active);
end;

procedure TCustomdxDBGrid.SetDefaultFields(Value: Boolean);
begin
  if FDefaultFields <> Value then
  begin
    FDefaultFields := Value;
    begin
      BeginUpdate;
      try
        Options := Options - [egoLoadAllRecords];
        ClearGroupColumns;
        DestroyColumns;
        DefaultLayout := True;
        Filter.Active := False;
      finally
        EndUpdate;
      end;
    end;
  end;
end;

procedure TCustomdxDBGrid.SetFilter(Value: TdxDBGridFilter);
begin
end;

procedure TCustomdxDBGrid.SetFooterPanelVisible(Value: Boolean);
begin
  inherited ShowFooter := Value;
end;

procedure TCustomdxDBGrid.SetGroupPanelColor(Value: TColor);
begin
  if GroupPanelColor <> Value then
  begin
    FGroupPanelColor := Value;
    if ShowGroupPanel then Invalidate;
  end;
end;

procedure TCustomdxDBGrid.SetGroupPanelFontColor(Value: TColor);
begin
  if FGroupPanelFontColor <> Value then
  begin
    FGroupPanelFontColor := Value;
    if ShowGroupPanel then Invalidate;
  end;
end;

procedure TCustomdxDBGrid.SetGroupPanelVisible(Value: Boolean);
begin
  if Value = FGroupPanelVisible then Exit;
  HideEditor;
  FGroupPanelVisible := Value;
  if HandleAllocated then
  begin
    Windows.ValidateRect(Handle, nil);
    // ani
    if (LockUpdate = 0) and not (csDesigning in ComponentState) and
      not (csLoading in ComponentState) and (State = tsNormal) then ScrollGroupPanel;
    LayoutChanged;
  end;
end;

procedure TCustomdxDBGrid.SetOptions(Value: TdxDBGridOptions);
const
  OptionsBehaviorCount = 12;
  OptionsCustomizeCount = 3;
  OptionsDBCount = 11;
  OptionsViewCount = 6;
  AOptionsBehavior: array [0..OptionsBehaviorCount - 1] of TdxDBGridOption = (
    egoCaseInsensitive, egoDblClick, egoEditing, egoExtMultiSelect, egoImmediateEditor,
    egoMultiSelect,  egoSeekDetail, egoShowHourGlass, egoStoreToIniFile,
    egoStoreToRegistry, egoTabs, egoTabThrough);
  ANewOptionsBehavior: array [0..OptionsBehaviorCount - 1] of TdxDBGridOptionBehavior = (
    edgoCaseInsensitive, edgoDblClick, edgoEditing, edgoExtMultiSelect, edgoImmediateEditor,
    edgoMultiSelect,  edgoSeekDetail, edgoShowHourGlass, edgoStoreToIniFile,
    edgoStoreToRegistry, edgoTabs, edgoTabThrough);
  AOptionsCustomize: array [0..OptionsCustomizeCount - 1] of TdxDBGridOption = (
    egoColumnMoving, egoColumnSizing, egoExtCustomizing);
  ANewOptionsCustomize: array [0..OptionsCustomizeCount - 1] of TdxDBGridOptionCustomize = (
    edgoColumnMoving, edgoColumnSizing, edgoExtCustomizing);
  AOptionsDB: array [0..OptionsDBCount - 1] of TdxDBGridOption = (
    egoCanAppend, egoCancelOnExit, egoCanDelete, egoCanInsert, egoCanNavigation,
    egoConfirmDelete, egoLoadAllRecords, egoResetColumnFocus, egoSmartRefresh,
    egoSmartReload, egoUseLocate);
  ANewOptionsDB: array [0..OptionsDBCount - 1] of TdxDBGridOptionDB = (
    edgoCanAppend, edgoCancelOnExit, edgoCanDelete, edgoCanInsert, edgoCanNavigation,
    edgoConfirmDelete, edgoLoadAllRecords, edgoResetColumnFocus, edgoSmartRefresh,
    edgoSmartReload, edgoUseLocate);
  AOptionsView: array [0..OptionsViewCount - 1] of TdxDBGridOption = (
    egoAutoWidth, egoDrawEndEllipsis, egoHideFocusRect, egoIndicator,  egoPreview,
    egoRowSelect);
  ANewOptionsView: array [0..OptionsViewCount - 1] of TdxDBGridOptionView = (
    edgoAutoWidth, edgoDrawEndEllipsis, edgoHideFocusRect, edgoIndicator,  edgoPreview,
    edgoRowSelect);
var
  PrevOptionsBehavior: TdxDBGridOptionsBehavior;
  PrevOptionsCustomize: TdxDBGridOptionsCustomize;
  PrevOptionsDB: TdxDBGridOptionsDB;
  PrevOptionsView: TdxDBGridOptionsView;
  I: Integer;
begin
  PrevOptionsBehavior := OptionsBehavior;
  PrevOptionsCustomize := OptionsCustomize;
  PrevOptionsDB := OptionsDB;
  PrevOptionsView := OptionsView;
  // Behavior
  for I := 0 to OptionsBehaviorCount - 1 do
    if AOptionsBehavior[I] in Value then
      Include(PrevOptionsBehavior, ANewOptionsBehavior[I])
    else
      Exclude(PrevOptionsBehavior, ANewOptionsBehavior[I]);
  // Customize
  for I := 0 to OptionsCustomizeCount - 1 do
    if AOptionsCustomize[I] in Value then
      Include(PrevOptionsCustomize, ANewOptionsCustomize[I])
    else
      Exclude(PrevOptionsCustomize, ANewOptionsCustomize[I]);
  // DB    
  for I := 0 to OptionsDBCount - 1 do
    if AOptionsDB[I] in Value then
      Include(PrevOptionsDB, ANewOptionsDB[I])
    else
      Exclude(PrevOptionsDB, ANewOptionsDB[I]);
  // View
  for I := 0 to OptionsViewCount - 1 do
    if AOptionsView[I] in Value then
      Include(PrevOptionsView, ANewOptionsView[I])
    else
      Exclude(PrevOptionsView, ANewOptionsView[I]);
  BeginUpdate;
  try
    OptionsBehavior := PrevOptionsBehavior;
    OptionsCustomize := PrevOptionsCustomize;
    OptionsDB := PrevOptionsDB;
    OptionsView := PrevOptionsView;
  finally
    EndUpdate;
  end;
end;

procedure TCustomdxDBGrid.SetOptionsEx(Value: TdxDBGridOptionsEx);
const
  OptionsBehaviorCount = 16;
  OptionsCustomizeCount = 8;
  OptionsDBCount = 1;
  OptionsViewCount = 7;
  AOptionsBehavior: array [0..OptionsBehaviorCount - 1] of TdxDBGridOptionEx = (
    egoAnsiSort, egoAutoSearch, egoAutoSort, egoBandButtonClicking, egoCellMultiSelect,
    egoCollapsedReload, egoDragCollapse, egoDragExpand, egoDragScroll, egoEnterShowEditor,
    egoEnterThrough, egoHeaderButtonClicking, egoHorzThrough,  egoMouseScroll, egoMultiSort,
    egoVertThrough);
  ANewOptionsBehavior: array [0..OptionsBehaviorCount - 1] of TdxDBGridOptionBehavior = (
    edgoAnsiSort, edgoAutoSearch, edgoAutoSort, edgoBandButtonClicking, edgoCellMultiSelect,
    edgoCollapsedReload, edgoDragCollapse, edgoDragExpand, edgoDragScroll, edgoEnterShowEditor,
    edgoEnterThrough, edgoHeaderButtonClicking, edgoHorzThrough, edgoMouseScroll, edgoMultiSort,
    edgoVertThrough);
  AOptionsCustomize: array [0..OptionsCustomizeCount - 1] of TdxDBGridOptionEx = (
    egoBandMoving, egoBandPanelSizing, egoBandSizing, egoFullSizing, egoHeaderPanelSizing,
    egoKeepColumnWidth, egoNotHideColumn, egoRowSizing);
  ANewOptionsCustomize: array [0..OptionsCustomizeCount - 1] of TdxDBGridOptionCustomize = (
    edgoBandMoving, edgoBandPanelSizing, edgoBandSizing, edgoFullSizing, edgoHeaderPanelSizing,
    edgoKeepColumnWidth, edgoNotHideColumn, edgoRowSizing);
  AOptionsDB: array [0..OptionsDBCount - 1] of TdxDBGridOptionEx = (
    egoSyncSelection);
  ANewOptionsDB: array [0..OptionsDBCount - 1] of TdxDBGridOptionDB = (
    edgoSyncSelection);
  AOptionsView: array [0..OptionsViewCount - 1] of TdxDBGridOptionEx = (
    egoAutoCalcPreviewLines, egoAutoHeaderPanelHeight, egoBandHeaderWidth,
    egoInvertSelect, egoRowAutoHeight, egoShowButtonAlways, egoUseBitmap);
  ANewOptionsView: array [0..OptionsViewCount - 1] of TdxDBGridOptionView = (
    edgoAutoCalcPreviewLines, edgoAutoHeaderPanelHeight, edgoBandHeaderWidth,
    edgoInvertSelect, edgoRowAutoHeight, edgoShowButtonAlways, edgoUseBitmap);
var
  PrevOptionsBehavior: TdxDBGridOptionsBehavior;
  PrevOptionsCustomize: TdxDBGridOptionsCustomize;
  PrevOptionsDB: TdxDBGridOptionsDB;
  PrevOptionsView: TdxDBGridOptionsView;
  I: Integer;
begin
  PrevOptionsBehavior := OptionsBehavior;
  PrevOptionsCustomize := OptionsCustomize;
  PrevOptionsDB := OptionsDB;
  PrevOptionsView := OptionsView;
  // Behavior
  for I := 0 to OptionsBehaviorCount - 1 do
    if AOptionsBehavior[I] in Value then
      Include(PrevOptionsBehavior, ANewOptionsBehavior[I])
    else
      Exclude(PrevOptionsBehavior, ANewOptionsBehavior[I]);
  // Customize
  for I := 0 to OptionsCustomizeCount - 1 do
    if AOptionsCustomize[I] in Value then
      Include(PrevOptionsCustomize, ANewOptionsCustomize[I])
    else
      Exclude(PrevOptionsCustomize, ANewOptionsCustomize[I]);
  // DB    
  for I := 0 to OptionsDBCount - 1 do
    if AOptionsDB[I] in Value then
      Include(PrevOptionsDB, ANewOptionsDB[I])
    else
      Exclude(PrevOptionsDB, ANewOptionsDB[I]);
  // View
  for I := 0 to OptionsViewCount - 1 do
    if AOptionsView[I] in Value then
      Include(PrevOptionsView, ANewOptionsView[I])
    else
      Exclude(PrevOptionsView, ANewOptionsView[I]);
  BeginUpdate;
  try
    OptionsBehavior := PrevOptionsBehavior;
    OptionsCustomize := PrevOptionsCustomize;
    OptionsDB := PrevOptionsDB;
    OptionsView := PrevOptionsView;
  finally
    EndUpdate;
  end;
end;

procedure TCustomdxDBGrid.SetOptionsBehavior(Value: TdxDBGridOptionsBehavior);
const
  OptionCount = 12;
  OptionExCount = 16;
  AOptionsBehavior: array [0..OptionCount - 1] of TdxDBGridOptionBehavior = (edgoCaseInsensitive,
    edgoDblClick, edgoEditing, edgoExtMultiSelect, edgoImmediateEditor, edgoMultiSelect,
    edgoSeekDetail, edgoShowHourGlass, edgoStoreToIniFile, edgoStoreToRegistry, edgoTabs, edgoTabThrough);
  AOptions: array [0..OptionCount - 1] of TdxDBGridOption = (egoCaseInsensitive,
    egoDblClick, egoEditing, egoExtMultiSelect, egoImmediateEditor, egoMultiSelect,
    egoSeekDetail, egoShowHourGlass, egoStoreToIniFile, egoStoreToRegistry, egoTabs, egoTabThrough);
  AOptionsBehaviorEx: array [0..OptionExCount - 1] of TdxDBGridOptionBehavior = (edgoAnsiSort,
    edgoAutoSearch, edgoAutoSort, edgoBandButtonClicking, edgoCellMultiSelect,
    edgoCollapsedReload, edgoDragCollapse, edgoDragExpand, edgoDragScroll,
    edgoEnterShowEditor, edgoEnterThrough, edgoHeaderButtonClicking, edgoHorzThrough,
    edgoMouseScroll, edgoMultiSort, edgoVertThrough);
  AOptionsEx: array [0..OptionExCount - 1] of TdxDBGridOptionEx = (egoAnsiSort,
    egoAutoSearch, egoAutoSort, egoBandButtonClicking, egoCellMultiSelect,
    egoCollapsedReload, egoDragCollapse, egoDragExpand, egoDragScroll,
    egoEnterShowEditor, egoEnterThrough, egoHeaderButtonClicking, egoHorzThrough,
    egoMouseScroll, egoMultiSort, egoVertThrough);
var
  NewOptions: TdxTreeListOptions;
  NewOptionsEx: TdxTreeListOptionsEx;
  SyncOptions: TdxDBGridOptions;
  SyncOptionsEx: TdxDBGridOptionsEx;
  I: Integer;
begin
  if FOptionsBehavior <> Value then
  begin
    BeginUpdate;
    try
      NewOptions := inherited Options;
      NewOptionsEx := inherited OptionsEx;
      if edgoAnsiSort in Value then
        Include(NewOptionsEx, aoAnsiSort)
      else
        Exclude(NewOptionsEx, aoAnsiSort);
      if edgoAutoCopySelectedToClipboard in Value then
        Include(NewOptionsEx, aoAutoCopySelectedToClipboard)
      else
        Exclude(NewOptionsEx, aoAutoCopySelectedToClipboard);
      if edgoAutoSearch in Value then
        Include(NewOptionsEx, aoAutoSearch)
      else
        Exclude(NewOptionsEx, aoAutoSearch);
      if edgoAutoSort in Value then
        Include(NewOptions, aoAutoSort)
      else
        Exclude(NewOptions, aoAutoSort);
      if edgoBandButtonClicking in Value then
        Include(NewOptionsEx, aoBandButtonClicking)
      else
        Exclude(NewOptionsEx, aoBandButtonClicking);
      if edgoCaseInsensitive in Value then
        Include(NewOptions, aoCaseInsensitive)
      else
        Exclude(NewOptions, aoCaseInsensitive);
      if edgoCellMultiSelect in Value then
        Include(NewOptionsEx, aoCellMultiSelect)
      else
        Exclude(NewOptionsEx, aoCellMultiSelect);
      // edgoCollapsedReload
      // edgoDblClick
      if edgoDragCollapse in Value then
        Include(NewOptionsEx, aoDragCollapse)
      else
        Exclude(NewOptionsEx, aoDragCollapse);
      if edgoDragExpand in Value then
        Include(NewOptionsEx, aoDragExpand)
      else
        Exclude(NewOptionsEx, aoDragExpand);
      if edgoDragScroll in Value then
        Include(NewOptionsEx, aoDragScroll)
      else
        Exclude(NewOptionsEx, aoDragScroll);
      if edgoEditing in Value then
        Include(NewOptions, aoEditing)
      else
        Exclude(NewOptions, aoEditing);
      if edgoEnterShowEditor in Value then
        Include(NewOptionsEx, aoEnterShowEditor)
      else
        Exclude(NewOptionsEx, aoEnterShowEditor);
      if edgoEnterThrough in Value then
        Include(NewOptionsEx, aoEnterThrough)
      else
        Exclude(NewOptionsEx, aoEnterThrough);
      if edgoExtMultiSelect in Value then
        Include(NewOptions, aoExtMultiSelect)
      else
        Exclude(NewOptions, aoExtMultiSelect);
      if edgoHeaderButtonClicking in Value then
        Include(NewOptionsEx, aoHeaderButtonClicking)
      else
        Exclude(NewOptionsEx, aoHeaderButtonClicking);
      if edgoHorzThrough in Value then
        Include(NewOptionsEx, aoHorzThrough)
      else
        Exclude(NewOptionsEx, aoHorzThrough);
      if edgoImmediateEditor in Value then
        Include(NewOptions, aoImmediateEditor)
      else
        Exclude(NewOptions, aoImmediateEditor);
      if edgoMouseScroll in Value then
        Include(NewOptionsEx, aoMouseScroll)
      else
        Exclude(NewOptionsEx, aoMouseScroll);
      if edgoMultiSelect in Value then
        Include(NewOptions, aoMultiSelect)
      else
        Exclude(NewOptions, aoMultiSelect);
      // edgoMultiSort
      // edgoSeekDetail
      if edgoShowHourGlass in Value then
        Include(NewOptionsEx, aoShowHourGlass)
      else
        Exclude(NewOptionsEx, aoShowHourGlass);
      if edgoStoreToIniFile in Value then
        Include(NewOptions, aoStoreToIniFile)
      else
        Exclude(NewOptions, aoStoreToIniFile);
      if edgoStoreToRegistry in Value then
        Include(NewOptions, aoStoreToRegistry)
      else
        Exclude(NewOptions, aoStoreToRegistry);
      if edgoTabs in Value then
        Include(NewOptions, aoTabs)
      else
        Exclude(NewOptions, aoTabs);
      if edgoTabThrough in Value then
        Include(NewOptions, aoTabThrough)
      else
        Exclude(NewOptions, aoTabThrough);
      if edgoVertThrough in Value then
        Include(NewOptionsEx, aoVertThrough)
      else
        Exclude(NewOptionsEx, aoVertThrough);
      inherited Options := NewOptions;
      inherited OptionsEx := NewOptionsEx;
      if ((edgoAutoSort in Value) <> (edgoAutoSort in FOptionsBehavior)) or
         ((edgoMultiSort in Value) <> (edgoMultiSort in FOptionsBehavior)) then
        ClearColumnsSorted;
      FOptionsBehavior := Value;
      // SyncOptions
      SyncOptions := FOptions;
      SyncOptionsEx := FOptionsEx;
      for I := 0 to OptionCount - 1 do
        if AOptionsBehavior[I] in FOptionsBehavior then
          Include(SyncOptions, AOptions[I])
        else
          Exclude(SyncOptions, AOptions[I]);
      for I := 0 to OptionExCount - 1 do
        if AOptionsBehaviorEx[I] in FOptionsBehavior then
          Include(SyncOptionsEx, AOptionsEx[I])
        else
          Exclude(SyncOptionsEx, AOptionsEx[I]);
      FOptions := SyncOptions;
      FOptionsEx := SyncOptionsEx;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TCustomdxDBGrid.SetOptionsCustomize(Value: TdxDBGridOptionsCustomize);
const
  OptionCount = 3;
  OptionExCount = 8;
  AOptionsCustomize: array [0..OptionCount - 1] of TdxDBGridOptionCustomize = (
    edgoColumnMoving, edgoColumnSizing, edgoExtCustomizing);
  AOptions: array [0..OptionCount - 1] of TdxDBGridOption = (
    egoColumnMoving, egoColumnSizing, egoExtCustomizing);
  AOptionsCustomizeEx: array [0..OptionExCount - 1] of TdxDBGridOptionCustomize = (edgoBandMoving,
    edgoBandPanelSizing, edgoBandSizing, edgoFullSizing, edgoHeaderPanelSizing,
    edgoKeepColumnWidth, edgoNotHideColumn, edgoRowSizing);
  AOptionsEx: array [0..OptionExCount - 1] of TdxDBGridOptionEx = (egoBandMoving,
    egoBandPanelSizing, egoBandSizing, egoFullSizing, egoHeaderPanelSizing,
    egoKeepColumnWidth, egoNotHideColumn, egoRowSizing);
var
  NewOptions: TdxTreeListOptions;
  NewOptionsEx: TdxTreeListOptionsEx;
  SyncOptions: TdxDBGridOptions;
  SyncOptionsEx: TdxDBGridOptionsEx;
  I: Integer;
begin
  if FOptionsCustomize <> Value then
  begin
    BeginUpdate;
    try
      NewOptions := inherited Options;
      NewOptionsEx := inherited OptionsEx;
      if edgoBandMoving in Value then
        Include(NewOptionsEx, aoBandMoving)
      else
        Exclude(NewOptionsEx, aoBandMoving);
      if edgoBandPanelSizing in Value then
        Include(NewOptionsEx, aoBandPanelSizing)
      else
        Exclude(NewOptionsEx, aoBandPanelSizing);
      if edgoBandSizing in Value then
        Include(NewOptionsEx, aoBandSizing)
      else
        Exclude(NewOptionsEx, aoBandSizing);
      if edgoColumnMoving in Value then
        Include(NewOptions, aoColumnMoving)
      else
        Exclude(NewOptions, aoColumnMoving);
      if edgoColumnSizing in Value then
        Include(NewOptions, aoColumnSizing)
      else
        Exclude(NewOptions, aoColumnSizing);
      if edgoExtCustomizing in Value then
        Include(NewOptions, aoExtCustomizing)
      else
        Exclude(NewOptions, aoExtCustomizing);
      if edgoFullSizing in Value then
        Include(NewOptionsEx, aoFullSizing)
      else
        Exclude(NewOptionsEx, aoFullSizing);
      if edgoHeaderPanelSizing in Value then
        Include(NewOptionsEx, aoHeaderPanelSizing)
      else
        Exclude(NewOptionsEx, aoHeaderPanelSizing);
      if edgoKeepColumnWidth in Value then
        Include(NewOptionsEx, aoKeepColumnWidth)
      else
        Exclude(NewOptionsEx, aoKeepColumnWidth);
      if edgoNotHideColumn in Value then
        Include(NewOptionsEx, aoRowSizing)
      else
        Exclude(NewOptionsEx, aoRowSizing);
      if edgoRowSizing in Value then
        Include(NewOptionsEx, aoRowSizing)
      else
        Exclude(NewOptionsEx, aoRowSizing);
      inherited Options := NewOptions;
      inherited OptionsEx := NewOptionsEx;
      FOptionsCustomize := Value;
      // SyncOptions
      SyncOptions := FOptions;
      SyncOptionsEx := FOptionsEx;
      for I := 0 to OptionCount - 1 do
        if AOptionsCustomize[I] in FOptionsCustomize then
          Include(SyncOptions, AOptions[I])
        else
          Exclude(SyncOptions, AOptions[I]);
      for I := 0 to OptionExCount - 1 do
        if AOptionsCustomizeEx[I] in FOptionsCustomize then
          Include(SyncOptionsEx, AOptionsEx[I])
        else
          Exclude(SyncOptionsEx, AOptionsEx[I]);
      FOptions := SyncOptions;
      FOptionsEx := SyncOptionsEx;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TCustomdxDBGrid.SetOptionsDB(Value: TdxDBGridOptionsDB);
const
  OptionCount = 11;
  OptionExCount = 1;
  AOptionsDB: array [0..OptionCount - 1] of TdxDBGridOptionDB = (edgoCanAppend,
    edgoCancelOnExit, edgoCanDelete, edgoCanInsert, edgoCanNavigation, edgoConfirmDelete,
    edgoLoadAllRecords, edgoResetColumnFocus, edgoSmartRefresh, edgoSmartReload, edgoUseLocate);
  AOptions: array [0..OptionCount - 1] of TdxDBGridOption = (egoCanAppend,
    egoCancelOnExit, egoCanDelete, egoCanInsert, egoCanNavigation, egoConfirmDelete,
    egoLoadAllRecords, egoResetColumnFocus, egoSmartRefresh, egoSmartReload, egoUseLocate);
  AOptionsDBEx: array [0..OptionExCount - 1] of TdxDBGridOptionDB = (edgoSyncSelection);
  AOptionsEx: array [0..OptionExCount - 1] of TdxDBGridOptionEx = (egoSyncSelection);
var                                                     
  PrevOptions: TdxDBGridOptionsDB;
  SyncOptions: TdxDBGridOptions;
  SyncOptionsEx: TdxDBGridOptionsEx;
  I: Integer;
begin
  if FOptionsDB <> Value then
  begin
    BeginUpdate;
    try
      PrevOptions := OptionsDB;
      if edgoLoadAllRecords in Value then
        Exclude(Value, edgoPartialLoad);
      if edgoPartialLoad in Value then
        Exclude(Value, edgoLoadAllRecords); // TODO ?
      FOptionsDB := Value;
      // SyncOptions
      SyncOptions := FOptions;
      SyncOptionsEx := FOptionsEx;
      for I := 0 to OptionCount - 1 do
        if AOptionsDB[I] in FOptionsDB then
          Include(SyncOptions, AOptions[I])
        else
          Exclude(SyncOptions, AOptions[I]);
      for I := 0 to OptionExCount - 1 do
        if AOptionsDBEx[I] in FOptionsDB then
          Include(SyncOptionsEx, AOptionsEx[I])
        else
          Exclude(SyncOptionsEx, AOptionsEx[I]);
      FOptions := SyncOptions;
      FOptionsEx := SyncOptionsEx;
      // set properties
      if (edgoPartialLoad in FOptionsDB) <> (edgoPartialLoad in PrevOptions) then
        if InternalGridMode then
        begin
          if (edgoPartialLoad in FOptionsDB) and DefaultFields then
            DefaultFields := False;
          FGridBOF := False;
          FGridEOF := False;
          LinkActive(FDataLink.Active);
        end;
      if (edgoUseBookmarks in FOptionsDB) and not (edgoUseBookmarks in PrevOptions) then
        ClearSelection;
      // check default fields
      if (edgoLoadAllRecords in FOptionsDB) and DefaultFields then
        DefaultFields := False;
      if (PrevOptions * [edgoLoadAllRecords] <> FOptionsDB * [edgoLoadAllRecords]) and
        (GroupColumnCount = 0) then
      begin
        // check sorted
        CheckSorted;
        BeginGrouping;
        // Filter Refresh (Auto set DataSet.FilterText)
//        SetFilterMode;
        EndGrouping;
        SetFilterMode;
      end
      else
        if (PrevOptions * [edgoCanNavigation] <> FOptionsDB * [edgoCanNavigation]) then
          FullRefresh;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TCustomdxDBGrid.SetOptionsView(Value: TdxDBGridOptionsView);
const
  OptionCount = 6;
  OptionExCount = 7;
  AOptionsView: array [0..OptionCount - 1] of TdxDBGridOptionView = (edgoAutoWidth,
    edgoDrawEndEllipsis, edgoHideFocusRect, edgoIndicator, edgoPreview, edgoRowSelect);
  AOptions: array [0..OptionCount - 1] of TdxDBGridOption = (egoAutoWidth,
    egoDrawEndEllipsis, egoHideFocusRect, egoIndicator, egoPreview, egoRowSelect);
  AOptionsViewEx: array [0..OptionExCount - 1] of TdxDBGridOptionView = (edgoAutoCalcPreviewLines,
    edgoAutoHeaderPanelHeight, edgoBandHeaderWidth, edgoInvertSelect,
    edgoRowAutoHeight, edgoShowButtonAlways, edgoUseBitmap);
  AOptionsEx: array [0..OptionExCount - 1] of TdxDBGridOptionEx = (egoAutoCalcPreviewLines,
    egoAutoHeaderPanelHeight, egoBandHeaderWidth, egoInvertSelect,
    egoRowAutoHeight, egoShowButtonAlways, egoUseBitmap);
var
  NewOptions: TdxTreeListOptions;
  NewOptionsEx: TdxTreeListOptionsEx;
  PrevOptions: TdxDBGridOptionsView;
  SyncOptions: TdxDBGridOptions;
  SyncOptionsEx: TdxDBGridOptionsEx;
  I: Integer;
begin
  if FOptionsView <> Value then
  begin
    BeginUpdate;
    try
      PrevOptions := OptionsView;
      NewOptions := inherited Options;
      NewOptionsEx := inherited OptionsEx;
      if edgoAutoCalcPreviewLines in Value then
        Include(NewOptionsEx, aoAutoCalcPreviewLines)
      else
        Exclude(NewOptionsEx, aoAutoCalcPreviewLines);
      if edgoAutoHeaderPanelHeight in Value then
        Include(NewOptionsEx, aoAutoHeaderPanelHeight)
      else
        Exclude(NewOptionsEx, aoAutoHeaderPanelHeight);
      if edgoAutoWidth in Value then
        Include(NewOptions, aoAutoWidth)
      else
        Exclude(NewOptions, aoAutoWidth);
      if edgoBandHeaderWidth in Value then
        Include(NewOptionsEx, aoBandHeaderWidth)
      else
        Exclude(NewOptionsEx, aoBandHeaderWidth);
      if edgoDrawEndEllipsis in Value then
        Include(NewOptions, aoDrawEndEllipsis)
      else
        Exclude(NewOptions, aoDrawEndEllipsis);
      if edgoHideFocusRect in Value then
        Include(NewOptions, aoHideFocusRect)
      else
        Exclude(NewOptions, aoHideFocusRect);
      if edgoHotTrack in Value then
        Include(NewOptionsEx, aoHotTrack)
      else
        Exclude(NewOptionsEx, aoHotTrack);
      ShowIndicator := edgoIndicator in Value;
      if edgoInvertSelect in Value then
      begin
        Include(NewOptionsEx, aoInvertSelect);
        Exclude(Value, edgoRowSelect);
      end
      else
        Exclude(NewOptionsEx, aoInvertSelect);
      if edgoPreview in Value then
        Include(NewOptions, aoPreview)
      else
        Exclude(NewOptions, aoPreview);
      if edgoRowAutoHeight in Value then
        Include(NewOptionsEx, aoRowAutoHeight)
      else
        Exclude(NewOptionsEx, aoRowAutoHeight);
      if edgoRowSelect in Value then
      begin
        Include(NewOptions, aoRowSelect);
        Exclude(NewOptionsEx, aoInvertSelect);
      end
      else
        Exclude(NewOptions, aoRowSelect);
      if edgoShowButtonAlways in Value then
        Include(NewOptionsEx, aoShowButtonAlways)
      else
        Exclude(NewOptionsEx, aoShowButtonAlways);
      if edgoUseBitmap in Value then
        Include(NewOptionsEx, aoUseBitmap)
      else
        Exclude(NewOptionsEx, aoUseBitmap);
      inherited Options := NewOptions;
      inherited OptionsEx := NewOptionsEx;
      FOptionsView := Value;
      // SyncOptions
      SyncOptions := FOptions;
      SyncOptionsEx := FOptionsEx;
      for I := 0 to OptionCount - 1 do
        if AOptionsView[I] in FOptionsView then
          Include(SyncOptions, AOptions[I])
        else
          Exclude(SyncOptions, AOptions[I]);
      for I := 0 to OptionExCount - 1 do
        if AOptionsViewEx[I] in FOptionsView then
          Include(SyncOptionsEx, AOptionsEx[I])
        else
          Exclude(SyncOptionsEx, AOptionsEx[I]);
      FOptions := SyncOptions;
      FOptionsEx := SyncOptionsEx;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TCustomdxDBGrid.SetPartialLoad(Value: Boolean);
begin
  if Value then
    OptionsDB := OptionsDB + [edgoPartialLoad]
  else
    OptionsDB := OptionsDB - [edgoPartialLoad];
end;

procedure TCustomdxDBGrid.SetPartialLoadBufferCount(Value: Integer);
begin
  if FPartialLoadBufferCount <> Value then
    FPartialLoadBufferCount := Value;
end;

procedure TCustomdxDBGrid.SetSummaryGroups(Value: TdxDBGridSummaryGroups);
begin
  SummaryGroups.Assign(Value);
end;

procedure TCustomdxDBGrid.SetSummarySeparator(Value: string);
begin
  if FSummarySeparator <> Value then
  begin
    FSummarySeparator := Value;
    Invalidate;
  end;
end;

procedure TCustomdxDBGrid.SetUseBookmarks(Value: Boolean);
begin
  if Value then
    OptionsDB := OptionsDB + [edgoUseBookmarks]
  else
    OptionsDB := OptionsDB - [edgoUseBookmarks];
end;

function TCustomdxDBGrid.InternalGridMode: Boolean;
begin
  Result := True;
  if Datalink.Active and (GroupColumnCount > 0) then
    Result := False;
  if egoLoadAllRecords in Options then Result := False;
end;

// private TCustomDxDBGrid
procedure TCustomdxDBGrid.WMVScroll(var Message: TWMVScroll);
{$IFDEF DELPHI3}
var
  SI: TScrollInfo;
{$ENDIF}
begin
  if not AcquireFocus then Exit;
  if not IsGridMode then
  begin
    inherited;
//    inherited UpdateScrollBars;
  end
  else
  if FDatalink.Active then
  begin
    HideEditor;
    with Message, FDataLink.DataSet do
      case ScrollCode of
        SB_LINEUP: MoveBy(-FDatalink.ActiveRecord - 1);
        SB_LINEDOWN: MoveBy(FDatalink.RecordCount - FDatalink.ActiveRecord);
        SB_PAGEUP: MoveBy(-VisibleRowCount);
        SB_PAGEDOWN: MoveBy(VisibleRowCount);
        SB_THUMBPOSITION:
          begin
            {$IFDEF DELPHI3}
            if IsSequenced then
            begin
              SI.cbSize := sizeof(SI);
              SI.fMask := SIF_ALL;
              GetScrollInfo(SB_VERT, SI);
              if SI.nTrackPos <= 1 then First
              else if SI.nTrackPos >= RecordCount then Last
              else RecNo := SI.nTrackPos;
            end
            else
            {$ENDIF}
              case Pos of
                0: First;
                1: MoveBy(-VisibleRowCount);
                2: Exit;
                3: MoveBy(VisibleRowCount);
                4: Last;
              end;
          end;
        SB_BOTTOM: Last;
        SB_TOP: First;
      end;
  end;
end;

procedure TCustomdxDBGrid.CMDesignHitTest(var Msg: TCMDesignHitTest);
begin
  inherited;
  if (Msg.Result <> 1) and (GetGroupColumnAt(Msg.Pos.X, Msg.Pos.Y) <> nil) then
    Msg.Result := 1;
end;

{ TdxDBGridFilterValues }
destructor TdxDBGridFilterValues.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TdxDBGridFilterValues.AddValue(AText: string; AValue: Variant; ACustomLoad: Boolean);
var
  AIndex: Integer;
  P: PVariant;
begin
  if CaseInsensitive and (VarType(AValue) = varString) then
  begin
    AValue := AnsiUpperCase(AValue);
    AText := AnsiUpperCase(AText);
  end;
  if ACustomLoad or
    ((MaxCount = 0) or (Count < MaxCount)) and not FindValue(AValue, AIndex) then
  begin
    New(P);
    P^ := AValue;
    if ACustomLoad then
      AddObject(AText, TObject(P))
    else
      InsertObject(AIndex, AText, TObject(P));
  end;
end;

procedure TdxDBGridFilterValues.Clear;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    if Objects[I] <> nil then
      Dispose(PVariant(Objects[I]));
  inherited Clear;
end;

function TdxDBGridFilterValues.FindValue(const AValue: Variant; var AIndex: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;
  L := 0;
  H := Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    if AnsiSort and (VarType(AValue) = varString) then
      C := AnsiCompareStr(PVariant(Objects[I])^, AValue)
    else
      C := VarCompare(PVariant(Objects[I])^, AValue);
    if C < 0 then
      L := I + 1
    else
    begin
      if C = 0 then
      begin
        Result := True;
        L := I;
      end;
      H := I - 1;
    end;
  end;
  AIndex := L;
end;

{ TdxDBGridFilterPopupListBox }
constructor TdxDBGridFilterPopupListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFilterValues := TdxDBGridFilterValues.Create;
end;

destructor TdxDBGridFilterPopupListBox.Destroy;
begin
  FFilterValues.Free;
  inherited Destroy;
end;

procedure TdxDBGridFilterPopupListBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if Key in [VK_RETURN, VK_ESCAPE, VK_F4] then
  begin
    case Key of
      VK_RETURN: ClosePopup(True);
      VK_ESCAPE, VK_F4: ClosePopup(False);
    end;
    KillMessage(Grid.Handle, WM_CHAR);
  end;
end;

procedure TdxDBGridFilterPopupListBox.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  if Button = mbLeft then
    ClosePopup((X >= 0) and (Y >= 0) and (X < Width) and (Y < Height));
end;

procedure TdxDBGridFilterPopupListBox.ClosePopup(Accept: Boolean);
var
  I: Integer;
begin
  if ListVisible then
  begin
    if GetCapture <> 0 then SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
    SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
    ListVisible := False;
    if Accept then
    begin
      I := ItemIndex;
      if (I <> -1) and Assigned(Column) and Assigned(Grid) then
      begin
        if I = 0 then
          Grid.Filter.Remove(Column)
        else
          if I = 1 then
            Grid.Filter.ShowCustomDialog(Column)
          else
            if (I = 2) and (Items.Objects[I] = nil) then // null
              Grid.Filter.AddNull(Column, False)
            else
              if (I = 3) and (Items.Objects[I] = nil) then // not null
                Grid.Filter.AddNull(Column, True)
              else
                Grid.Filter.Add(Column, PVariant(Items.Objects[I])^, Items[I]);
      end;
    end;
  end;
end;

function TdxDBGridFilterPopupListBox.GetGrid: TCustomdxDBGrid;
begin
  if Assigned(FColumn) then
    Result := TCustomdxDBGrid(FColumn.ATreeList)
  else
    Result := nil;
end;

function TdxDBGridFilterPopupListBox.GetListVisible: Boolean;
begin
  Result := Assigned(Grid) and Grid.FDropDownListVisible;
end;

procedure TdxDBGridFilterPopupListBox.SetListVisible(Value: Boolean);
begin
  if Assigned(Grid) then
    Grid.FDropDownListVisible := Value;
end;

{ TdxDBGridFilter }
constructor TdxDBGridFilter.Create(ADBGrid: TCustomdxDBGrid);
begin
  inherited Create;
  FDBGrid := ADBGrid;
  FCriteria := TdxDBGridCriteria.Create(TdxDBGrid(ADBGrid));
  FDropDownCount := 12;
  FMaxDropDownCount := 1000;
end;

destructor TdxDBGridFilter.Destroy;
begin
  FCriteria.Free;
  inherited Destroy;
end;

procedure TdxDBGridFilter.Add(AColumn: TdxDBTreeListColumn; const AValue: Variant; const ADisplayValue: string);
begin
  TdxDBGridCriteria(FCriteria).RemoveItemsByColumn(AColumn);
  TdxDBGridCriteria(FCriteria).AddItem(nil, AColumn, otEqual, AValue, ADisplayValue, False);
  FDBGrid.SetFilterMode;
end;

procedure TdxDBGridFilter.AddNull(AColumn: TdxDBTreeListColumn; IsNot: Boolean);
begin
  TdxDBGridCriteria(FCriteria).RemoveItemsByColumn(AColumn);
  TdxDBGridCriteria(FCriteria).AddItem(nil, AColumn, otIsNull, Null, '', IsNot);
  FDBGrid.SetFilterMode;
end;

procedure TdxDBGridFilter.Clear;
begin
  FCriteria.Clear;
  FDBGrid.ClearFilter;
end;

function TdxDBGridFilter.GetFilterColumnCriteria(AColumn: TdxDBTreeListColumn;
  var AValue: Variant): TdxDBGridFilterColumnCriteria;
var
  ACriteriaItem: TdxCriteriaItem;  
begin
  Result := fcNone;
  AValue := Null;
  ACriteriaItem := TdxDBGridCriteria(FCriteria).FindItemByColumn(AColumn);
  if ACriteriaItem <> nil then
  begin
    Result := fcValue;
    AValue := ACriteriaItem.Value;
    if VarEqualNull(AValue) and (ACriteriaItem.Operator = otIsNull) then
    begin
      if ACriteriaItem.IsNot then
        Result := fcNonBlanks
      else
        Result := fcBlanks;
    end
    else
      if TdxDBGridCriteria(FCriteria).ExistCustomCriteriaByColumn(AColumn) then
        Result := fcCustom;
  end;
end;

function TdxDBGridFilter.IsColumnFilterExist(AColumn: TdxDBTreeListColumn): Boolean;
begin
  Result := TdxDBGridCriteria(FCriteria).FindItemByColumn(AColumn) <> nil;
end;

function TdxDBGridFilter.IsEmpty: Boolean;
begin
  Result := Criteria.Root.Count = 0;
end;

procedure TdxDBGridFilter.Remove(AColumn: TdxDBTreeListColumn);
begin
  TdxDBGridCriteria(FCriteria).RemoveItemsByColumn(AColumn);
  FDBGrid.SetFilterMode;
end;

procedure TdxDBGridFilter.RestoreDefaults;
begin
  Active := False; 
  AutoDataSetFilter := False;
  CaseInsensitive := False;
  DropDownCount := 12;
  DropDownWidth := 0;
  FilterStatus := fsAuto;
  MaxDropDownCount := 1000;
end;

procedure TdxDBGridFilter.ShowCustomDialog(AColumn: TdxDBTreeListColumn);
begin
  if TdxDBGridCriteria(FCriteria).ShowCustomDialog(AColumn) then
    FDBGrid.SetFilterMode;
end;

type TdxDBGridCriteriaWrapper = class(TdxDBGridCriteria);

procedure TdxDBGridFilter.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('Criteria', TdxDBGridCriteriaWrapper(FCriteria).ReadData,
    TdxDBGridCriteriaWrapper(FCriteria).WriteData, True{FCriteria.Root.Count > 0});
end;

procedure TdxDBGridFilter.Changed;
begin
  FDBGrid.SetFilterMode;
end;

function TdxDBGridFilter.CheckFilterNode(ANode: TdxDBGridNode): Boolean;
begin
  Result := TdxDBGridCriteria(FCriteria).DoFilterNode(ANode);
end;

function TdxDBGridFilter.GetFilterCaption: string;
begin
  Result := FCriteria.FilterCaption;
end;

function TdxDBGridFilter.GetFilterText: string;
begin
  Result := FCriteria.FilterText;
end;

procedure TdxDBGridFilter.Prepare;
begin
  FCriteria.Prepare;
end;

procedure TdxDBGridFilter.SetFilterText(const Value: string);
begin
end;

procedure TdxDBGridFilter.SetActive(Value: Boolean);
begin
  if FActive <> Value then
  begin
    FActive := Value;
    if not Value then
      Clear
    else
      FDBGrid.DefaultFields := False;
    Changed;
  end;
end;

procedure TdxDBGridFilter.SetAutoDataSetFilter(Value: Boolean);
var
  ADataSet: TDataSet;
begin
  if FAutoDataSetFilter <> Value then
  begin
    FAutoDataSetFilter := Value;
    if Assigned(DBGrid.DataSource) then
    begin
      ADataSet := DBGrid.DataSource.DataSet;
      if not Value and Assigned(ADataSet) then
      begin
        ADataSet.Filter := '';
        ADataSet.Filtered := False;
      end;
    end;
    Changed;
  end;
end;

procedure TdxDBGridFilter.SetCaseInsensitive(Value: Boolean);
begin
  if FCaseInsensitive <> Value then
  begin
    FCaseInsensitive := Value;
    TdxDBGridCriteria(FCriteria).CaseInsensitive := FCaseInsensitive;
    if AutoDataSetFilter then
      Changed;
  end;
end;

procedure TdxDBGridFilter.SetFilterStatus(Value: TdxDBGridFilterStatus);
begin
  if FFilterStatus <> Value then
  begin
    FFilterStatus := Value;
    Changed;
  end;
end;

{ TdxDBGrid }
procedure TdxDBGrid.SaveToHTML(const AFileName: String; ASaveAll: Boolean);
begin
  dxGrExpt.SaveToHTML(Self, AFileName, ASaveAll);
end;

procedure TdxDBGrid.SaveToXLS(const AFileName : String; ASaveAll: Boolean);
begin
  dxGrExpt.SaveToXLS(Self, AFileName, ASaveAll);
end;

procedure TdxDBGrid.SaveToText(const AFileName: string; ASaveAll: Boolean;
  const ASeparator, ABeginString, AEndString: string);
begin
  dxGrExpt.SaveToText(Self, AFileName, ASaveAll, ASeparator, ABeginString, AEndString);
end;

procedure TdxDBGrid.SaveToXML(const AFileName: string; ASaveAll: Boolean);
begin
  dxGrExpt.SaveToXML(Self, AFileName, ASaveAll);
end;

procedure InitDefaultDBGridColumnClasses(Proc: TInitColumnClassProc);
var
  I: TFieldType;
  C: TdxDBTreeListColumnClassInfo;
begin
  for I := ftUnknown to ftTypedBinary do
  begin
    C := DefaultDBGridColumnType[I];
    Proc(I, fkData, C);
    if C.Version > DefaultDBGridColumnType[i].Version then
      DefaultDBGridColumnType[I] := C;
  end;
  C := DefaultDBGridLookupColumnType;
  Proc(ftUnknown, fkLookup, C);
  if C.Version > DefaultDBGridLookupColumnType.Version then
    DefaultDBGridLookupColumnType := C;
end;

procedure ResetDefaultDBGridColumnClasses;
var
  I: TFieldType;
begin
  DefaultDBGridColumnType[ftUnknown].ColumnClass := nil;
  DefaultDBGridColumnType[ftUnknown].Version := 0;
  for I := Succ(ftUnknown) to ftTypedBinary do
  begin
    DefaultDBGridColumnType[ftUnknown].ColumnClass := TdxDBGridColumn;
    DefaultDBGridColumnType[ftUnknown].Version := 0;
  end;
  DefaultDBGridLookupColumnType.ColumnClass := TdxDBGridColumn;
  DefaultDBGridLookupColumnType.Version := 0;
end;

initialization
  Classes.RegisterClasses([TdxDBGridColumn, TdxDBGridMaskColumn]);

  sdxPanelText := LoadStr(dxSPanelText);

end.
