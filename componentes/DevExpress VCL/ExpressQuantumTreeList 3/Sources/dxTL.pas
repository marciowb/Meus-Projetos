
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressQuantumTreeList control                              }
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

unit dxTL;

interface

{$I dxTLVer.inc}

uses
  SysUtils, Messages, Windows, Classes, Graphics, Menus, Controls, Forms,
  StdCtrls, Mask, CommCtrl {$IFDEF DELPHI4}, ImgList{$ENDIF}, dxTLStr,
  Clipbrd, dxCntner, dxEditor, ComCtrls, dxUtils{$IFDEF DELPHI6}, Variants{$ENDIF};

const
  dxTreeListMaxResizeWidth = 4;
  dxclArrows = clLime;
  // Timer interval
  tiHScroll = 100; {ms}
  tiVScroll = 100; {ms}
  // Arrowa size
  arWidth = 11;
  arHeight = 9;
  {Colors}
  dxclTreeLineHighColor     = clBtnFace;   {clSilver}
  dxclTreeLineShadowColor   = clBtnShadow; {clGray}

  crdxTreeListDeleteCursor  = -1124;
  dxTreeListDeleteCursor    = 'DXTLDELETECURSOR';

  crdxTreeListFullScroll    = -1131;
  crdxTreeListHorScroll     = -1132;
  crdxTreeListVerScroll     = -1133;
  crdxTreeListUpScroll      = -1134;
  crdxTreeListRightScroll   = -1135;
  crdxTreeListDownScroll    = -1136;
  crdxTreeListLeftScroll    = -1137;
  crdxTreeListDragCopy      = -1138;
  crdxTreeListMultiDragCopy = -1139;

  // Draw Info constants
  dxGridMaxDrawItems        = 100000;
  dxGridFixedBandLineWidth  = 2;
  dxGridSortedShapeMinWidth = 16;
  dxGridPreviewMaxLineCount = 60;

  // Bands constants
  dxGridBandMinWidth        = 30;
  dxGridBandDefaultWidth    = 250;
  // Headers constants
  dxGridHeaderMinWidth      = 20;
  dxGridHeaderTempIndex     = -2;
  dxGridHeaderNewIndex      = -3;
  dxGridHeaderFilterBoxWidth = 15;
  // Status line
  dxGridStatusCloseButtonSizeX = 12;
  dxGridStatusCloseButtonSizeY = 11;
  dxGridStatusCloseButtonWidth = dxGridStatusCloseButtonSizeX + 3 * 2;
  dxGridStatusCloseButtonMinHeight = dxGridStatusCloseButtonSizeY + 3 * 2;

  dxDragExapndTimerId       = 101;
  dxWaitForExpandNodeTime   = 500;
  dxCustomizingRowCount     = 11;

type
  {$IFDEF EGRID_DEBUG}
  TdxDBGridEventType = (etLoadData, etSort, etRefreshNode);
  TdxDBGridDebugEvent = procedure(Sender: TObject; Event: TdxDBGridEventType;
    Count: LongInt) of object;
  {$ENDIF}

  EInvaliddxTreeListOperation = class(Exception);

  TCustomdxTreeList = class;
  TdxTreeListNode = class;
  TdxBandsListBox = class;
  TdxHeadersListBox = class;

  TdxTreeListNodeAttachMode = (natlAdd, natlAddFirst, natlAddChild, natlAddChildFirst, natlInsert);

  TdxTreeListOption = (aoColumnSizing, aoColumnMoving, aoEditing, aoTabs, aoTabThrough, aoRowSelect,
    aoMultiSelect, aoImmediateEditor, aoPreview, aoDrawEndEllipsis, aoAutoWidth, aoExtMultiSelect,
    aoExtCustomizing, aoHideFocusRect, aoAutoSort, aoCaseInsensitive,
    aoStoreToRegistry, aoStoreToIniFile);
  TdxTreeListOptions = set of TdxTreeListOption;

  TdxTreeListOptionEx = (aoInvertSelect, aoUseBitmap, aoBandHeaderWidth, aoAutoCalcPreviewLines,
    aoBandSizing, aoBandMoving, aoHorzThrough, aoVertThrough, aoCellMultiSelect,
    aoEnterThrough, aoEnterShowEditor, aoFullSizing, aoDragScroll, aoDragExpand, aoDragCollapse,
    aoRowAutoHeight, aoShowHourGlass, aoBandButtonClicking, aoBandPanelSizing, aoHeaderButtonClicking,
    aoHeaderPanelSizing, aoRowSizing, aoMultiSort, aoAutoSortRefresh, aoShowButtonAlways,
    aoAutoHeaderPanelHeight, aoKeepColumnWidth, aoAnsiSort, aoMouseScroll, aoAutoSearch,
    aoHotTrack, aoAutoCopySelectedToClipboard);
  TdxTreeListOptionsEx = set of TdxTreeListOptionEx;

  TdxTreeListState = (tsNormal, tsColumnSizing, tsEditing,
    tsColumnDragging, tsColumnDown, tsNodeDragging, tsNodeDown,
    tsHeaderButtonDown, tsBandSizing, tsBandDragging, tsBandDown,
    tsBandButtonDown, tsBandPanelSizing, tsHeaderPanelSizing, tsRowSizing,
    tsDropDownButtonDown, tsStatusCloseButtonDown);

  TdxTreeListHitTest = (htNowhere, htColumn, htColumnEdge, htButton,
    htIcon, htStateIcon, htIndent, htLabel, htRight, htOutside,
    htGroupPanel, htBandButton, htBand, htBandEdge, htHeaderButton,
    htIndicator, htNewRowItem, htSummaryNodeFooter, htSummaryFooter,
    htBandPanelEdge, htHeaderPanelEdge, htRowEdge, htPreview,
    htStatusPanel);
  TdxTreeListHitTests = set of TdxTreeListHitTest;

  TdxTreeListColumnSort = (csNone, csDown, csUp);

  TdxTreeListPaintStyle = (psStandard, psOutlook);

  TdxTreeListSearchDirection = (sdNone, sdUp, sdDown);

  TTLExpandingEvent = procedure(Sender: TObject; Node: TdxTreeListNode; var Allow: Boolean) of object;
  TTLExpandedEvent = procedure(Sender: TObject; Node: TdxTreeListNode) of object;
  TTLChangeNodeEvent = procedure(Sender: TObject; OldNode, Node: TdxTreeListNode) of object;
  TTLChangeColumnEvent = procedure(Sender: TObject; Node: TdxTreeListNode; Column: Integer) of object;
  TTLGetImageEvent = procedure(Sender: TObject; Node: TdxTreeListNode; var Index: Integer) of object;
  TdxTLCanNodeSelected = procedure(Sender: TObject; ANode: TdxTreeListNode; var Allow: Boolean) of object;
  TdxTLCompareEvent = procedure(Sender: TObject; Node1, Node2: TdxTreeListNode;
    var Compare: Integer) of object;

  TdxTLGetEditColor = procedure(Sender: TObject; var AColor: TColor) of object;
  TdxTLGetPreviewText = procedure(Sender: TObject; ANode: TdxTreeListNode; var AText: string) of object;
  TdxTLGetPreviewLineCount = procedure(Sender: TObject; ANode: TdxTreeListNode; var LCount: Integer) of object;
  TdxTLIsLevelFooter = procedure(Sender: TObject; ALevel: Integer; var AExist: Boolean) of object;
  TdxTLIsExistFooterCell = procedure(Sender: TObject; AColumn: Integer; var AExist: Boolean) of object;
  TdxTLIsExistRowFooterCell = procedure(Sender: TObject; ANode: TdxTreeListNode;
    AColumn, AFooterIndex: Integer; var AExist: Boolean) of object;
  TdxTLGetFooterCellText = procedure(Sender: TObject; ANode: TdxTreeListNode;
    AColumn, AFooterIndex: Integer; var AText: string) of object;

  TdxTreeListNode = class
  private
    FData: Pointer;
    FDeleting: Boolean;
    FExpanded: Boolean;
    FHasChildren: Boolean;
    FList: TList;
    FOwner: TCustomdxTreeList;
    FParent: TdxTreeListNode;
    FRowHeight: Integer;
    FRowLineCount: Integer; // NEW
    function GetAbsoluteIndex: Integer;
    function GetCount: Integer;
    function GetCountValues: Integer;
    function GetFocused: Boolean;
    function GetImageIndex: Integer;
    function GetIndex: Integer;
    function GetIsLast: Boolean;
    function GetIsNodeVisible: Boolean;
    function GetItem(Index: Integer): TdxTreeListNode;
    function GetLevel: Integer;
    function GetSelected: Boolean;
    function GetSelectedIndex: Integer;
    function GetStateIndex: Integer;
    function GetString(Column: Integer): string;
    function GetValue(Column: Integer): Variant;
    procedure SetData(Value: Pointer);
    procedure SetExpanded(Value: Boolean);
    procedure SetFocused(Value: Boolean);
    procedure SetHasChildren(Value: Boolean);
    procedure SetImageIndex(Value: Integer);
    procedure SetSelected(Value: Boolean);
    procedure SetSelectedIndex(Value: Integer);
    procedure SetStateIndex(Value: Integer);
    procedure SetString(Column: Integer; const Value: string);
    procedure SetValue(Column: Integer; const Value: Variant);
  protected
    procedure InternalMove(Destination: TdxTreeListNode; Mode: TdxTreeListNodeAttachMode);
    procedure InternalMoveAsChild(Destination: TdxTreeListNode; AIndex: Integer);
    procedure InternalMoveToRoot;
    procedure InternalRemove;
    procedure MoveChildrenToRoot;
  public
    constructor Create(AOwner: TCustomdxTreeList);
    destructor Destroy; override;
    function AddChild: TdxTreeListNode;
    function AddChildFirst: TdxTreeListNode;
    procedure AddNodesToList(List: TList);
    function CanMove(Destination: TdxTreeListNode; Mode: TdxTreeListNodeAttachMode): Boolean;
    procedure Collapse(Recurse: Boolean);
    procedure DeleteChildren;
    procedure Expand(Recurse: Boolean);
    function GetFirstChild: TdxTreeListNode;
    function GetLastChild: TdxTreeListNode;
    function GetNext: TdxTreeListNode;
    function GetNextNode: TdxTreeListNode;
    function GetNextSibling: TdxTreeListNode;
    function GetPrev: TdxTreeListNode;
    function GetPrevSibling: TdxTreeListNode;
    function GetPriorNode: TdxTreeListNode;
    function GetPriorParentNode: TdxTreeListNode;
    function HasAsParent(Value: TdxTreeListNode): Boolean;
    function IndexOf(Value: TdxTreeListNode) : Integer;
    function InsertChild(BeforeNode: TdxTreeListNode): TdxTreeListNode;
    procedure MakeVisible;
    procedure MoveTo(Destination: TdxTreeListNode; Mode: TdxTreeListNodeAttachMode);

    property AbsoluteIndex: Integer read GetAbsoluteIndex;
    property Count: Integer read GetCount;
    property CountValues: Integer read GetCountValues;
    property Data: Pointer read FData write SetData;
    property Deleting: Boolean read FDeleting;
    property Expanded: Boolean read FExpanded write SetExpanded;
    property Focused: Boolean read GetFocused write SetFocused;
    property HasChildren: Boolean read FHasChildren write SetHasChildren;
    property ImageIndex: Integer read GetImageIndex write SetImageIndex;
    property Index: Integer read GetIndex;
    property IsLast: Boolean read GetIsLast;
    property IsVisible: Boolean read GetIsNodeVisible;
    property Items[Index: Integer]: TdxTreeListNode read GetItem; default;
    property Level: Integer read GetLevel;
    property Owner: TCustomdxTreeList read FOwner;
    property Parent: TdxTreeListNode read FParent;
    property Selected: Boolean read GetSelected write SetSelected;
    property SelectedIndex: Integer read GetSelectedIndex write SetSelectedIndex;
    property StateIndex: Integer read GetStateIndex write SetStateIndex;
    property Strings[Index: Integer]: string read GetString write SetString;
    property Values[Index: Integer]: Variant read GetValue write SetValue;
  end;

  TdxLookAndFeel = (lfStandard, lfFlat, lfUltraFlat);
  TdxGridDrawCellKind = (ckRow, ckFooter, ckNewItemRow, ckGroup);
  TdxHeaderButtonStyle = (hbNormal, hbLeft, hbRight, hbLeftRight);
  TdxShowButtonStyle = (sbDefault, sbAlways, sbNone);

  TdxHeaderDropDownButtonKind = (hdbNormal, hdbSelected, hdbPushed, hdbActive); // TODO Filter
  TdxHeaderDropDownButtonState = set of TdxHeaderDropDownButtonKind;

  TdxTreeListHitInfo = record
    X, Y: Integer;                 // Client
    Band: Integer;                 // VisibleIndex
    Column: Integer;               // AbsoluteIndex
    Node: TdxTreeListNode;
    Row: Integer;
    FooterRow: Integer;
    hitType: TdxTreeListHitTest;
  end;

  // Draw Info
  TdxTreeLineStyle = (tlSolid, tlDot);
  TdxGridIndicatorKind = (ikNone, ikArrow, ikEdit, ikInsert, ikMultiDot, ikMultiArrow);

  TdxGridBandDrawInfo = record
    Index: Integer;
    BandRect: TRect;
    BandClipRect: TRect;
  end;
  PdxGridBandsInfo = ^TdxGridBandsInfo;
  TdxGridBandsInfo = array [0..dxGridMaxDrawItems - 1] of TdxGridBandDrawInfo;

  TdxGridHeaderDrawInfo = record
    AbsoluteIndex: Integer;
    BandIndex, RowIndex, ColIndex: Integer;  // BandIndex - visible index
    LineCount: Integer;
    HeaderRect: TRect;
    HeaderClipRect: TRect;
    HeaderEmptyRect: TRect;
    FirstColumn: Boolean;
    LastColumn: Boolean;
    LeftEdgeColumn: Boolean;
    RightEdgeColumn: Boolean;
    MultiLine: Boolean;
  end;
  PdxGridHeadersInfo = ^TdxGridHeadersInfo;
  TdxGridHeadersInfo = array [0..dxGridMaxDrawItems - 1] of TdxGridHeaderDrawInfo;

  TdxGridEmptyRectDrawInfo = record
    BandIndex: Integer;  // BandIndex - visible index
    EmptyRect: TRect;
    ClippingFlag: Boolean;
  end;
  PdxGridEmptyRectsInfo = ^TdxGridEmptyRectsInfo;
  TdxGridEmptyRectsInfo = array [0..dxGridMaxDrawItems - 1] of TdxGridEmptyRectDrawInfo;

  TdxGridRowDrawInfo = record
    Node: TdxTreeListNode;
    IsGroup: Boolean;
    IsSelected: Boolean;
    RowHeight: Integer;
    RowFooterCount: Integer;
    RowFooterHeight: Integer;
    IndicatorKind: TdxGridIndicatorKind;
    PreviewLineCount: Integer;
    RowLineCount: Integer;
    Indent: Integer;
  end;
  PdxGridRowsInfo = ^TdxGridRowsInfo;
  TdxGridRowsInfo = array [0..dxGridMaxDrawItems - 1] of TdxGridRowDrawInfo;

  PdxGridDrawInfo = ^TdxGridDrawInfo;
  TdxGridDrawInfo = record
    CRect: TRect;
    GroupPanelRect: TRect;
    BandRect: TRect;
    BandButtonRect: TRect;
    HeaderRect: TRect;
    HeaderButtonRect: TRect;
    IndicatorRect: TRect;
    NewItemRowRect: TRect;
    CellsRect: TRect;
    EmptyRectRight,
    EmptyRectBottom: TRect;
    FooterRect: TRect;
    StatusRect: TRect;
    // fixed bands
    FixedBandLeftRect: TRect;
    FixedBandRightRect: TRect;
    FixedBandLeftIndex: Integer;
    FixedBandRightIndex: Integer;
    FixedBandPrevRightIndex: Integer;
    // edges
    EdgeX, EdgeY: Integer;
    IndentLimit: Integer;
    RowSeparatorLineWidth: Integer;
    // bands
    BandCount: Integer;
    BandsInfo: PdxGridBandsInfo;
    // headers
    HeaderCount: Integer;
    HeadersInfo: PdxGridHeadersInfo;
    // empty headers rect
    EmptyRectCount: Integer;
    EmptyRectsInfo: PdxGridEmptyRectsInfo;
    // rows
    RowCount: Integer;
    RowsInfo: PdxGridRowsInfo;
  end;

  PdxHeaderPosInfo = ^TdxHeaderPosInfo;
  TdxHeaderPosInfo = record
    BandIndex: Integer;
    RowIndex: Integer;
    ColIndex: Integer;
    AbsoluteIndex: Integer;
  end;

  TdxTreeListCellViewData = class
    Cell_Brush: HBRUSH;
    Cell_Font: HFONT;
    Cell_BkColor: TColor;
    Cell_TextColor: TColor;
    Cell_Alignment: TAlignment;
    Cell_Text: string;
    Cell_TextLength: Integer;
    Cell_Selected: Boolean;
    Cell_InvertSelect: Boolean;
    Cell_LeftEdge: Boolean;
    Cell_RightEdge: Boolean;
    Cell_MultiLine: Boolean;
    Cell_InvertText: Boolean;
    Cell_DrawEndEllipsis: Boolean;
    Cell_Node: TdxTreeListNode;
    Cell_IsNullNode: Boolean;
    Cell_SelectionColor: TColor;
    Cell_CellBrush: HBRUSH;
    Cell_CellColor: TColor;
    Cell_HotTrackNode: Boolean;
    Cell_Rect: TRect;
  end;


  TdxTreeListHeaderHotTrack = (hhtNone, hhtBody, hhtDropDownButton, hhtDropDownButtonDisabled);

  TdxTreeListHotTrackInfo = record
    Node: TdxTreeListNode;
    Column: Integer;               // AbsoluteIndex
    ActiveIndex: Integer;          // HotButton (TODO)
    HeaderHotTrack: TdxTreeListHeaderHotTrack;
  end;

  TdxInplaceTreeListEdit = class(TdxInplaceEdit)
  public
    property Text;
  end;

  TdxTLHotTrackNode = procedure (Sender: TObject; AHotTrackInfo: TdxTreeListHotTrackInfo;
    var ACursor: TCursor) of object;

  TdxTreeListNavigationMode = (tlnmFirst, tlnmPrev, tlnmNext, tlnmLast);

  TCustomdxTreeList = class(TCustomdxContainer)
  private
    // Structure
    FNodeList: TList;
    FLockUpdate: Integer;
    FFocused: TdxTreeListNode;
    OldFocusedNode: TdxTreeListNode;
    FlagCtrl, FlagSelect, FlagEditor: Boolean;
    FListIndexes: TList; // get index of node
    FListNodes: TList; // get node at index
    FListRealNodes: TList; // get node at index
    FMakeListNodesFlag: Boolean;
    FMakeListNode: TdxTreeListNode;
    FMakeListNodeVisible: Boolean;
    FNodeDeleteing: Boolean;
    // Style
    FArrowsColor: TColor;
    FBandColor: TColor;
    FBandFont: TFont;
    FBorderStyle: TBorderStyle;
    FDblClkExpanding: Boolean;
    FFixedBandLineColor: TColor;
    FFlat: Boolean;
    FFooterColor: TColor;
    FFooterTextColor: TColor;
    FGridColor: TColor;
    FGridLineColor: TColor;
    FGroupColor: TColor;
    FGroupTextColor: TColor;
    FHeaderColor: TColor;
    FHeaderFont: TFont;
    FHideFocusRect: Boolean;
    FHideSelection: Boolean;
    FHideSelectionColor: TColor;
    FHideSelectionTextColor: TColor;
    FHighlightColor: TColor;
    FHighlightTextColor: TColor;
    FLookAndFeel: TdxLookAndFeel;
    FPaintStandard: Boolean;
    FPaintStyle: TdxTreeListPaintStyle;
    FPreviewFont: TFont;
    FScrollBars: TScrollStyle;
    FShowBands: Boolean;
    FShowButtons: Boolean;
    FShowFooter: Boolean;
    FShowGrid: Boolean;
    FShowHeaders: Boolean;
    FShowIndicator: Boolean;
    FShowLines: Boolean;
    FShowNewItemRow: Boolean;
    FShowPreviewGrid: Boolean;
    FShowRoot: Boolean;
    FShowRowFooter: Boolean;
    FTreeLineColor: TColor;
    FTreeLineStyle: TdxTreeLineStyle;
    // Sizes
    // - group panel
    FGroupPanelHeight: Integer;
    // - bands
    FBandHeight: Integer;
    FBandRowCount: Integer;
    FBandTextHeight: Integer;
    // - headers
    FHeaderHeight: Integer;
    FHeaderLineCount: Integer;
    FHeaderRowCount: Integer;
    FHeaderRowHeight: Integer;
    // - new item row
    FNewItemRowHeight: Integer;
    FNewItemRowSeparatorHeight: Integer;
    // - row
    FFixedBandLineWidth: Integer;
    FMinRowHeight: Integer;
    FRowHeight: Integer;
    FRowHeightAssigned: Boolean;
    FRowSeparatorLineWidth: Integer;
    FTextHeight: Integer;
    FMaxRowLineCount: Integer;
    // - preview
    FDescTextHeight: Integer;
    FIndentDesc: Integer;
    FPreviewLines: Integer;
    // - indicator
    FIndicatorWidth: Integer;
    // - footer row
    FFooterRowHeight: Integer;
    FFooterRowNodeHeight: Integer;
    // - footer
    FFooterHeight: Integer;
    // status
    FStatusHeight: Integer;
    // - other...
    FDeltaHScroll: Integer;
    FImageH: Integer;
    FImageW: Integer;
    FImageButtonH: Integer;
    FImageButtonW: Integer;
    FImageStateH: Integer;
    FImageStateW: Integer;
    FIndent: Integer;

    // flags
    FBandButtonPushed: Boolean;
    FDragAbsoluteBandIndex: Integer;
    FDownBandIndex: Integer;
    FDownBandPushed: Boolean;
    FDownColumnIndex: Integer; // absolute index FDragAbsoluteHeaderIndex
    FDownColumnPushed: Boolean;
    FHeaderButtonPushed: Boolean;
    FDropDownButtonColumnIndex: Integer;
    FDropDownButtonColumnPushed: Boolean;
    FStatusCloseButtonActive: Boolean;
    FStatusCloseButtonPressed: Boolean;

    // Position
    FArrowsPos: TPoint;
    FFlagSaveArrowsRect: Boolean;
    FFocusedAbsoluteIndex: Integer;
    FFocusedColumn: Integer;
    FHitInfo: TdxTreeListHitInfo;
    FHitTest: TPoint;
    FLeftCoord: Integer;
    FPointDragging: TPoint;
    FSaveArrowsRect, FArrowsRect: TRect;
    FSizingPos: Integer;
    FPrevSizingPos: Integer;
    FTopVisibleNode: TdxTreeListNode;

    // DragDrop
    FDragExpandNode: TdxTreeListNode;
    FDragExpandTimerId: Integer;
    FDragImageList: TImageList;
    FDragNode: TdxTreeListNode;
    FDragObject: TDragObject;
    FShowDragImage: Boolean;
    FWaitForExpandNodeTime: UINT;

    // Other
    FCellViewData: TdxTreeListCellViewData;
    FImages: TImageList;
    FImageChangeLink: TChangeLink;
    FLockHideDragImages: Integer;
    FLockSelection: Integer;
    FNewItemRowActive: Boolean;
    FOptions: TdxTreeListOptions;
    FOptionsEx: TdxTreeListOptionsEx;
    FPrevSelectedCount: Integer;
    FSaveFont: TFont;
    FSelectionAnchor: TdxTreeListNode;
    FSelfChangingTitleFont: Boolean;
    FState: TdxTreeListState;
    FStateImages: TImageList;
    FStateChangeLink: TChangeLink;

    // Editor
    FCursorChange: Boolean; 
    FDefaultCursor: TCursor;
    FHotTrackInfo: TdxTreeListHotTrackInfo;
    FInplaceEdit: TdxInplaceEdit;
    FInplaceColumn: Integer;
    FInplaceColumnIndex: Integer;
    FInplaceNode: TdxTreeListNode;

    // Customizig
    FCustomizingBandListBox: TdxBandsListBox;
    FCustomizingForm: TForm;
    FCustomizingHeaderListBox: TdxHeadersListBox;
    FCustomizingLastBandIndex: Integer;
    FCustomizingLastHeaderIndex: Integer;
    FCustomizingPos: TPoint;
    FCustomizingRowCount: Integer;
    FSimpleCustomizeBox: Boolean;
    FShowHiddenInCustomizeBox: Boolean;

    // Search
    FSearchColumnIndex: Integer;
    FAutoExpandOnSearch: Boolean;
    FAutoSearchColor: TColor;
    FAutoSearchTextColor: TColor;

    // Hints
    FHideHintTimerId: Integer;
    FHintWindow: TdxContainerHintWindow;
    FShowHintTimerId: Integer;

    // Events
    FOnBeginDragNode: TTLExpandedEvent;
    FOnCanNodeSelected: TdxTLCanNodeSelected;
    FOnChangeColumn: TTLChangeColumnEvent;
    FOnChangeLeftCoord: TNotifyEvent;
    FOnChangeNode: TTLChangeNodeEvent;
    FOnChangeTopVisibleNode: TNotifyEvent;
    FOnCollapsed: TTLExpandedEvent;
    FOnCollapsing: TTLExpandingEvent;
    FOnCompare: TdxTLCompareEvent;
    FOnDeletion: TTLExpandedEvent;
    FOnEditChange: TNotifyEvent;
    FOnEdited: TTLExpandedEvent;
    FOnEditing: TTLExpandingEvent;
    FOnEditValidate: TdxEditValidateEvent;
    FOnEndColumnsCustomizing: TNotifyEvent;
    FOnExpanded: TTLExpandedEvent;
    FOnExpanding: TTLExpandingEvent;
    FOnGetEditColor: TdxTLGetEditColor;
    FOnHotTrackNode: TdxTLHotTrackNode; 
    FOnSelectedCountChange: TNotifyEvent;
    {$IFDEF EGRID_DEBUG}
    FOnDebugEvent: TdxDBGridDebugEvent;
    {$ENDIF}
    function FindListNode(Node: TdxTreeListNode): Integer;
    function GetCount: Integer;
    function GetFocused: TdxTreeListNode;
    function GetFocusedColumn: Integer;
    function GetFocusedNumber: Integer;
    function GetLastNode: TdxTreeListNode;
    function GetNode(Index: Integer): TdxTreeListNode;
    function GetOptions: TdxTreeListOptions;
    function GetOptionsEx: TdxTreeListOptionsEx;
    function GetTopIndex: Integer;
    function IsActiveControl: Boolean;
    function IsSmartNavigation: Boolean;
    procedure SetFocusedColumn(Value : Integer);
    procedure SetLeftCoord(ALeft: Integer);
    procedure SetOptions(Value: TdxTreeListOptions);
    procedure SetOptionsEx(Value: TdxTreeListOptionsEx);
    procedure SetTopIndex(AIndex: Integer);
    procedure UpdateDesigner;
    procedure UpdateHScrollBar;
    procedure UpdateTopLeftCoord;
    procedure UpdateVScrollBar;

    // size
    function GetDefaultRowHeight: Integer;
    function IsRowHeightStored: Boolean;
    procedure SetCustomizingRowCount(Value: Integer);
    procedure SetDefaultRowHeight(Value: Integer);
    procedure SetFixedBandLineWidth(Value: Integer);
    procedure SetIndentDesc(Value: Integer);
    procedure SetMaxRowLineCount(Value: Integer);
    procedure SetPreviewLines(Value: Integer);
    procedure SetRowSeparatorLineWidth(Value: Integer);

    // paint methods
    procedure DrawArrows(FlagHide: Boolean);
    procedure DrawSizingLine;
    function GetFooterRect(Node: TdxTreeListNode; Index, YStart, SizeGrid: Integer;
      const DrawInfo: TdxGridDrawInfo): TRect;
    procedure InvalidateBand(BandIndex: Integer);
    procedure InvalidateBandButton;
    procedure InvalidateColumn(ColumnIndex: Integer);
    procedure InvalidateHeaderButton;
    procedure InvalidateNewItemRow;

    // style
    function GetRootVisible: Boolean;
    procedure HeaderFontChanged(Sender: TObject);
    procedure ImageListChange(Sender: TObject);
    procedure InternalLayout;
    function IsHeaderFontStored: Boolean;
    procedure LoadButtonFaces;
    procedure SetBandColor(Value: TColor);
    procedure SetBandFont(Value: TFont);
    procedure SetBandVisible(Value: Boolean);
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure SetButtonVisible(Value: Boolean);
    procedure SetFixedBandLineColor(Value: TColor);
    procedure SetFooterColor(Value: TColor);
    procedure SetFooterTextColor(Value: TColor);
    procedure SetFooterVisible(Value: Boolean);
    procedure SetGridLineColor(Value: TColor);
    procedure SetGridVisible(Value: Boolean);
    procedure SetGroupColor(Value : TColor);
    procedure SetGroupTextColor(Value : TColor);
    procedure SetHeaderColor(Value: TColor);
    procedure SetHeaderFont(Value: TFont);
    procedure SetHeaderVisible(Value: Boolean);
    procedure SetHideFocusRect(Value: Boolean);
    procedure SetHideSelection(Value: Boolean);
    procedure SetHideSelectionColor(Value: TColor);
    procedure SetHideSelectionTextColor(Value: TColor);
    procedure SetHighlightColor(Value: TColor);
    procedure SetHighlightTextColor(Value: TColor);
    procedure SetImages(Value: TImageList);
    procedure SetIndicatorVisible(Value: Boolean);
    procedure SetLineVisible(Value: Boolean);
    procedure SetLookAndFeel(Value : TdxLookAndFeel);
    procedure SetNewItemRowVisible(Value: Boolean);
    procedure SetPaintStyle(Value: TdxTreeListPaintStyle);
    procedure SetPreviewFont(Value: TFont);
    procedure SetPreviewGridVisible(Value: Boolean);
    procedure SetRootVisible(Value: Boolean);
    procedure SetRowFooterVisible(Value: Boolean);
    procedure SetScrollBars(Value: TScrollStyle);
    procedure SetStateImages(Value: TImageList);
    procedure SetTreeLineColor(Value: TColor);
    procedure SetTreeLineStyle(Value: TdxTreeLineStyle);
    // Other
    procedure ActivateCustomizingForm(Sender: TObject);
    procedure CloseCustomizingForm(Sender: TObject; var Action: TCloseAction);
    procedure SetDragObject(Value: TDragObject);
    procedure SetNewItemRowActive(Value: Boolean);

    // Editor
    procedure HideEdit(ABackFocus: Boolean);
    procedure UpdateText;
    procedure UpdateEdit(Activate: Boolean);

    // Hint
    procedure ShowStatusCloseButtonHint(AImmediately: Boolean);
    procedure HideStatusCloseButtonHint;

    // Messages
    procedure WMCancelMode(var Msg: TMessage); message WM_CANCELMODE;
    procedure WMDestroy(var Msg: TWMDestroy); message WM_DESTROY;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMGetDlgCode(var Msg: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMHScroll(var Message: TWMHScroll); message WM_HSCROLL;
    procedure WMIMEStartComp(var Message: TMessage); message WM_IME_STARTCOMPOSITION;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCalcSize;
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMNCPaint(var Message: TMessage); message WM_NCPaint;
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure WMTimer(var Msg: TWMTimer); message WM_TIMER;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure CMCancelMode(var Msg: TMessage); message CM_CANCELMODE;
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure CMDesignHitTest(var Msg: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure CMDrag(var Message: TCMDrag); message CM_DRAG;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMParentFontChanged(var Message: TMessage); message CM_PARENTFONTCHANGED;
    procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;
  protected
    FVisibleRowCount, FRowCount: Integer;
    FFirstSelectedNode: TdxTreeListNode;
    FSelecting: Boolean;
    DrawBitmap: TBitmap;
    FlagMultiSort: Boolean;
    FlagClearSort: Boolean;
    FDragAbsoluteHeaderIndex: Integer; // property DragAbsoluteHeaderIndex
    FClearListNodesFlag: Boolean;
    FClearNodes: Boolean;
    FSearching: Boolean;
    FSearchText: string;
    FLockSearching: Integer;
    FCanceling: Boolean;
    // Filter
    FHiddenList: TList;
    FDropDownListVisible: Boolean;

    // override TCustomControl
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DoExit; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure WndProc(var Message: TMessage); override;

    // routines
    function CalcBandHeight(LineCount: Integer): Integer;
    function CalcBandPanelRowCount(Y: Integer): Integer;
    function CalcHeaderPanelRowCount(Y: Integer): Integer;
    function CalcNearestRowHeight(Node: TdxTreeListNode; ResizeRowHeight: Integer): Integer;
    class function CalcTextRowHeight(TextHeight: Integer): Integer;
    procedure CancelDragSizing; virtual;
    procedure ChangedBandAutoWidth(BandIndex, NewWidth: Integer);
    procedure ChangedHeaderAutoWidth(BandIndex, AbsoluteHeaderIndex, NewWidth: Integer);
    procedure DoBandDragging;
    procedure DoHeaderDragging;
    procedure DoScrolling;
    procedure FreeImageList(var AImgList: TImageList);
    function GetBandMinWidth(VisibleIndex: Integer): Integer;
    procedure GetBandPanelResizeRanges(Y: Integer; var Min, Max: Integer);
    function GetBandRealWidth(VisibleIndex: Integer): Integer;
    procedure GetBandResizeRanges(VisibleIndex, X: Integer; var Start, Min, Max: Integer);
    function GetBandTotalWidth: Integer;
    function GetBandWidth(VisibleIndex: Integer): Integer;
    function GetFocusedColumnAbsoluteIndex: Integer;
    procedure SetFocusedColumnAbsoluteIndex(Value: Integer);
    function GetHeaderLineCount(BandIndex, RowIndex, ColIndex: Integer): Integer;
    procedure GetHeaderPanelResizeRanges(Y: Integer; var Min, Max: Integer);
    procedure GetHeaderResizeRanges(AbsoluteIndex, X: Integer; var Start, Min, Max: Integer);
    function GetHeaderTotalMinWidth(BandIndex, RowIndex: Integer): Integer;
    function GetHeaderTotalWidth(BandIndex, RowIndex: Integer): Integer;
    function GetHorzGridRect: TRect;
    function GetNodeFooterLevel(Node: TdxTreeListNode; Index: Integer): Integer;
    function GetNodeFooterRowCount(Node: TdxTreeListNode; Level: Integer): Integer;
    procedure GetNodeIndent(ANode: TdxTreeListNode; var AIndent, AImageIndent: Integer);
    function GetPreviewBoundsWidth(Node: TdxTreeListNode): Integer;
    function GetRowHeight(Node: TdxTreeListNode; FHeight: Integer; ReCalc: Boolean): Integer;
    function GetRowFooterCount(Node: TdxTreeListNode): Integer;
    procedure GetRowResizeRanges(Node: TdxTreeListNode; Y: Integer; var Min, Max: Integer);
    function GetScrollableBandWidth: Integer;
    function GetScrollableWidth: Integer;
    function GetScrollHorzGridRect: TRect;
    function GetStartBandCoord(VisibleIndex: Integer): Integer;
    function GetVisibleHeaderCount: Integer;
    procedure HideDragImages;
    function IsCalcRowAutoHeight: Boolean;
    function IsFixedBand(VisibleIndex: Integer): Boolean;
    function IsFixedBandHeader(AbsoluteIndex: Integer): Boolean;
    procedure PrepareArrowsRect(IsBand: Boolean);
    procedure PrepareDragBand(AbsoluteIndex: Integer);
    procedure PrepareDragHeader(AbsoluteIndex: Integer);
    procedure PrepareDragNode(Node: TdxTreeListNode; Column: Integer{absolute index}); virtual;
    procedure ResetTopFocusedNodes;
    procedure ScaledBandHeaderWidth(BandIndex, NewWidth: Integer);
    procedure ScaledHeaderBandWidth(BandIndex, AbsoluteHeaderIndex, NewWidth: Integer);
    procedure ScrollGridHorz(Distance: Integer);
    procedure ScrollGridVert(Distance: Integer);
    procedure ShowDragImages;
    procedure UpdateCustomizingColumns;
    procedure UpdateDragging;

    // Copy to text format
    function GetHeaderTabText: string;
    function GetNodeTabText(ANode: TdxtreeListNode): string;

    // based
    function AcquireFocus: Boolean; virtual;
    procedure AddNode(Node: TdxTreeListNode); virtual;
    procedure BeforeDestroy;
    procedure BeginCustomLayout; virtual;
    function CanDblClick: Boolean; virtual;
    function CheckHasChildren(Node: TdxTreeListNode): Boolean; virtual;
    procedure ClearBoundsInfo; virtual;
    procedure ClearListNodes; virtual;
    procedure ClearNodeRowHeight; virtual;
    procedure DoAfterCollapse(Node : TdxTreeListNode); virtual;
    procedure DoAfterEditing(Node : TdxTreeListNode); virtual;
    procedure DoAfterExpand(Node : TdxTreeListNode); virtual;
    procedure DoBeforeCollapse(Node : TdxTreeListNode; var AllowCollapse: Boolean); virtual;
    procedure DoBeforeEditing(Node : TdxTreeListNode; var AllowEditing: Boolean); virtual;
    procedure DoBeforeExpand(Node : TdxTreeListNode; var AllowExpand: Boolean); virtual;
    procedure DoBestFitBand(BandIndex: Integer); virtual;
    procedure DoBestFitColumn(AbsoluteIndex: Integer); virtual;
    procedure DoChangeColumn(Node : TdxTreeListNode; Column : Integer); virtual;
    procedure DoChangeLeftCoord; virtual;
    procedure DoChangeNode(OldNode, Node : TdxTreeListNode); virtual;
    procedure DoEditChange(Sender: TObject); virtual;
    procedure DoEditValidate(Sender: TObject; var ErrorText: string; var Accept: Boolean); virtual;
    procedure DoRestoreLayout; virtual;
    procedure DoSaveLayout; virtual;
    procedure DeleteNode(Node, Prior, Next: TdxTreeListNode; IsLast, Redraw: Boolean); virtual;
    procedure DeleteStrings(Node: TdxTreeListNode; Index: Integer); virtual;
    function DoMoveFocusedColumn(FlagUp, IsTest: Boolean): Boolean; virtual;
    procedure EndCustomLayout; virtual;
    function GetAbsoluteCount: Integer;
    function GetAbsoluteIndex(Node: TdxTreeListNode): Integer;
    function GetAbsoluteNode(AIndex: Integer): TdxTreeListNode;
    function GetRectNode(Node:TdxTreeListNode): TRect;
    function GetRectNodeBelow(Node:TdxTreeListNode): TRect;
    function GetRowNode(Node:TdxTreeListNode): Integer;
    function GetScrollVertGridRect: TRect; virtual;
    function GetTopNode: TdxTreeListNode;
    procedure FreeClickTimer;
    function IsColumnHotTrack(X, Y: Integer; Node: TdxTreeListNode; ColumnAbsoluteIndex: Integer; var ActiveIndex: Integer): Boolean; virtual;
    function IsHeaderHotTrack(X, Y: Integer; ColumnAbsoluteIndex: Integer; var HeaderHotTrack: TdxTreeListHeaderHotTrack): Boolean; virtual;
    procedure LayoutChanged; virtual;
    procedure MakeBandHeaderList(CalcBounds: Boolean); virtual;
    procedure MakeBoundsInfo; virtual;
    procedure MakeListNode(Node: TdxTreeListNode; Deleteing: Boolean);
    procedure MakeListNodes; virtual;
    function MakeFocused(Node: TdxTreeListNode): Boolean; virtual;
    function NeedShowButtonEdit(X, Y: Integer; IsCurrentNode: Boolean; ColumnAbsoluteIndex: Integer): Boolean; virtual;
    procedure SetEmptyNodes;
    procedure SetState(Value: TdxTreeListState);
    procedure UpdateNode(Node: TdxTreeListNode; Below: Boolean); virtual;

    // based virtual & abstract
    function CanSetData: Boolean; virtual;
    function CreateNode: TdxTreeListNode; virtual; abstract;
    function GetNodeImageIndex(Node: TdxTreeListNode): Integer; virtual; abstract;
    function GetNodeSelectedIndex(Node: TdxTreeListNode): Integer; virtual; abstract;
    function GetNodeStateIndex(Node: TdxTreeListNode): Integer; virtual; abstract;
    function GetNodeValue(Node: TdxTreeListNode; Column: Integer) : Variant; virtual; abstract;
    function GetNodeString(Node: TdxTreeListNode; Column: Integer): string; virtual; abstract;
    function GetNodeVariant(Node: TdxTreeListNode; Column: Integer): Variant; virtual;
    procedure SetFocusedNode(Node: TdxTreeListNode; Column: Integer; MakeVisibleFlag: Boolean); virtual;
    procedure SetFocusedNumber(AIndex: Integer); virtual;
    procedure SetNodeImageIndex(Node: TdxTreeListNode; Value: Integer); virtual; abstract;
    procedure SetNodeSelectedIndex(Node: TdxTreeListNode; Value: Integer); virtual; abstract;
    procedure SetNodeStateIndex(Node: TdxTreeListNode; Value: Integer); virtual; abstract;
    procedure SetNodeString(Node: TdxTreeListNode; Column: Integer; const Value: string); virtual; abstract;
    procedure SetNodeValue(Node: TdxTreeListNode; Column: Integer; const Value: Variant); virtual; abstract;
    procedure SetTopVisibleNode(Node: TdxTreeListNode); virtual;

    // GroupPanel
    function GetGroupPanelHeight: Integer; virtual;

    // Bands
    function GetAbsoluteBandAlignment(AbsoluteIndex: Integer): TAlignment; virtual;
    function GetAbsoluteBandCount: Integer; virtual;
    function GetAbsoluteBandIndex(VisibleIndex: Integer): Integer; virtual;
    function GetAbsoluteBandText(AbsoluteIndex: Integer): string; virtual;
    function GetAbsoluteBandWidth(AbsoluteIndex: Integer): Integer; virtual;
    function GetBandAlignment(VisibleIndex: Integer): TAlignment; virtual;
    function GetBandCount: Integer; virtual;
    function GetBandFixedLeft: Integer; virtual;
    function GetBandFixedRight: Integer; virtual;
    function GetBandMinWidthSize(VisibleIndex: Integer): Integer; virtual;
    function GetBandSizeWidth(VisibleIndex: Integer): Integer; virtual;
    function GetBandText(VisibleIndex: Integer): string; virtual;
    function GetIndentWidth: Integer; virtual;
    function GetVisibleBandIndex(AbsoluteIndex: Integer): Integer; virtual;
    function IsOwnBand(ABandIndex: Integer{VisibleIndex}): Boolean; virtual;

    // Headers
    function GetHeaderAbsoluteCount: Integer; virtual;
    function GetHeaderAbsoluteIndex(BandIndex, RowIndex, ColIndex: Integer): Integer; virtual;  // get absolute index
    function GetHeaderAlignment(AbsoluteIndex: Integer): TAlignment; virtual;
    function GetHeaderBandIndex(AbsoluteIndex: Integer): Integer; virtual;
    function GetHeaderBoundsWidth(AbsoluteIndex: Integer): Integer; virtual;
    function GetHeaderColCount(BandIndex, RowIndex: Integer): Integer; virtual;
    function GetHeaderColIndex(AbsoluteIndex: Integer): Integer; virtual;
    function GetHeaderDropDownButtonState(AbsoluteIndex: Integer): TdxHeaderDropDownButtonState; virtual;
    function GetHeaderGlyph(AbsoluteIndex: Integer): TBitmap; virtual;
    function GetHeaderMaxLineCount(AbsoluteIndex: Integer): Integer; virtual;  // 0 - while not limit
    function GetHeaderMinWidth(AbsoluteIndex: Integer): Integer; virtual;
    function GetHeaderRowCount(BandIndex: Integer): Integer; virtual;
    function GetHeaderRowIndex(AbsoluteIndex: Integer): Integer; virtual;
    function GetHeaderSorted(AbsoluteIndex: Integer): TdxTreeListColumnSort; virtual;
    function GetHeaderTabStop(AbsoluteIndex: Integer): Boolean; virtual;
    function GetHeaderText(AbsoluteIndex: Integer): string; virtual;
    function GetHeaderTextListBox(AbsoluteIndex: Integer): string; virtual;
    function GetHeaderWidth(AbsoluteIndex: Integer): Integer; virtual;
    function GetColumnColor(AbsoluteIndex: Integer): TColor; virtual;
    function GetColumnFont(AbsoluteIndex: Integer): TFont; virtual;
    function IsExistColumnFont(AbsoluteIndex: Integer): Boolean; virtual;
    function IsExistHeaderGlyph(AbsoluteIndex: Integer): Boolean; virtual;

    // Cells
    function GetCellAlignment(Node: TdxTreeListNode; AbsoluteIndex: Integer): TAlignment; virtual;
    function GetCellText(Node: TdxTreeListNode; AbsoluteIndex: Integer): string; virtual;
    function GetNewItemCellText(AbsoluteIndex: Integer): string; virtual;
    function IsCellMultiLine(AbsoluteIndex: Integer): Boolean; virtual;
    function IsNewItemRowEditing: Boolean; virtual;

    // Indicator
    function GetIndicatorWidth: Integer; virtual;

    // Rows
    function GetHeaderMaxRowHeight(ACanvas: TCanvas; AbsoluteIndex: Integer): Integer; virtual; // column (image)
    function GetPreviewText(Node: TdxTreeListNode): string; virtual;
    function GetRowIndicatorKind(Node: TdxTreeListNode; ASelected: Boolean): TdxGridIndicatorKind; virtual;
    function GetRowLineCount(Node: TdxTreeListNode; var LineHeight: Integer): Integer; virtual;
    // Status
    function GetStatusButtonVisible: Boolean; virtual;
    function GetStatusText: string; virtual;
    function GetStatusCloseButtonHint: string; virtual;
    function GetStatusCloseButtonRect: TRect;

    function ColumnCalcLineCount(ANode: TdxTreeListNode; AbsoluteIndex: Integer; const Text: string;
      BoundsWidth, TextHeight, MaxLineCount: Integer; InflateFlag{obsolete}, GridFlag{obsolete}: Boolean;
      var LineCount, LineHeight: Integer): Boolean; virtual;

    function GetRowMaxColumnHeight(ACanvas: TCanvas): Integer; virtual;
    function GetRowPreviewLineCount(Node: TdxTreeListNode): Integer; virtual;
    function GetRowSeparatorLineWidth: Integer; virtual; // 1, 2, ... 5 ?
    procedure HeaderPanelBestFit; virtual;
    function IsRowGroup(Node: TdxTreeListNode): Boolean; virtual;

    // Footer
    function GetFooterCellAlignment(Node: TdxTreeListNode; AbsoluteIndex, FooterIndex: Integer): TAlignment; virtual;
    function GetFooterCellText(Node: TdxTreeListNode; AbsoluteIndex, FooterIndex: Integer): string; virtual;
    function IsExistFooterCell(AbsoluteIndex: Integer): Boolean; virtual;
    function IsExistRowFooterCell(Node: TdxTreeListNode; AbsoluteIndex, FooterIndex: Integer): Boolean; virtual;
    function IsLevelFooter(Level: Integer): Boolean; virtual;

    // Style
    function IsAnsiSort: Boolean; virtual;
    function IsAutoCalcPreviewLines: Boolean; virtual;
    function IsAutoDragCopy: Boolean; virtual;
    function IsAutoFilter: Boolean; virtual;
    function IsAutoHeaderPanelRowCount: Boolean; virtual;
    function IsAutoSearch: Boolean; virtual;
    function IsAutoSort: Boolean; virtual;
    function IsAutoSortRefresh: Boolean; virtual;
    function IsAutoWidth: Boolean; virtual;
    function IsBandHeaderWidth: Boolean; virtual;
    function IsCaseInsensitive: Boolean; virtual;
    function IsCellMultiSelect: Boolean; virtual;
    function IsDragCollapse: Boolean; virtual;
    function IsDrawEndEllipsis: Boolean; virtual;
    function IsDragExpand: Boolean; virtual;
    function IsDragScroll: Boolean; virtual;
    function IsEditing: Boolean; virtual;
    function IsEnterShowEditor: Boolean; virtual;
    function IsEnterThrough: Boolean; virtual;
    function IsExtCustomizing: Boolean; virtual;
    function IsExtMultiSelect: Boolean; virtual;
    function IsFilterStatusVisible: Boolean; virtual;
    function IsHorzThrough: Boolean; virtual;
    function IsHScrollBarVisible: Boolean; virtual;
    function IsImmediateEditor: Boolean; override;
    function IsMouseScroll: Boolean; virtual;
    function IsMultiSelect: Boolean; virtual;
    function IsMultiSort: Boolean; virtual;
    function IsNewItemRowActive: Boolean; virtual;
    function IsNewItemRowVisible: Boolean; virtual;
    function IsRowAutoHeight: Boolean; virtual;
    function IsRowSelect: Boolean; virtual;
    function IsShowHourGlass: Boolean; virtual;
    function IsShowRowFooter: Boolean; virtual;
    function IsShowPreview: Boolean; virtual;
    function IsSmartRecalcRowHeight: Boolean; virtual;
    function IsTabs: Boolean; override;
    function IsTabThrough: Boolean; virtual;
    function IsVertThrough: Boolean; virtual;
    function IsVScrollBarDisableHide: Boolean; virtual;
    function IsVScrollBarVisible: Boolean; virtual;
    function IsUseBitmap: Boolean; virtual;

    // Sizing, Clicking
    function CanBandButtonClicking: Boolean; virtual;
    function CanBandFullSizing(VisibleIndex: Integer): Boolean; virtual;
    function CanBandPanelSizing: Boolean; virtual;
    function CanBandSizing(VisibleIndex: Integer): Boolean; virtual;
    function CanHeaderBandSizing: Boolean; virtual; // header width changed - > band width changed
    function CanHeaderButtonClicking: Boolean; virtual;
    function CanHeaderFullSizing(AbsoluteIndex: Integer): Boolean; virtual;
    function CanHeaderPanelSizing: Boolean; virtual;
    function CanHeaderSizing(AbsoluteIndex: Integer): Boolean; virtual;
    function CanHeaderReSizing(AbsoluteIndex: Integer): Boolean; virtual;
    function CanRowSizing: Boolean; virtual;
    procedure ChangedBandRowCount(BandRowCount: Integer); virtual;
    procedure ChangedBandWidth(VisibleIndex, Width: Integer); virtual;
    procedure ChangedHeaderMaxRowCount(RowCount: Integer); virtual; // header panel sizing
    procedure ChangedHeaderWidth(AbsoluteIndex, Width: Integer); virtual;
    procedure ChangeHiddenBandWidth(ScaleNum, ScaleDenom: Integer); virtual;
    procedure ChangeHiddenHeaderWidth(BandIndex: Integer; ScaleNum, ScaleDenom: Integer); virtual;
    procedure ChangedRowHeight(NewRowHeight: Integer); virtual;
    procedure DoBandButtonClick; virtual;
    procedure DoBandClick(VisibleIndex: Integer); virtual;
    procedure DoChangedColumnsWidth; virtual;
    procedure DoHeaderButtonClick; virtual;
    procedure DoHeaderClick(AbsoluteIndex: Integer); virtual;
    procedure DoHeaderDropDownButtonClick(AbsoluteIndex: Integer); virtual;
    procedure DoStatusCloseButtonClick; virtual;
    function GetBandMaxRowCount: Integer; virtual; // sizing
    function GetBandRowCount: Integer; virtual;
    function GetHeaderMaxLimitRowCount: Integer; virtual; // header panel sizing
    function GetHeaderMaxRowCount: Integer; virtual;
    function GetHeaderLineRowCount: Integer; virtual;

    // DragDrop
    procedure CalcArrowsPos(var P: TPoint; PPosInfo: Pointer; IsBand: Boolean; DownIndex, DragIndex: Integer); virtual;
    procedure GetDragImageCursor(P: TPoint; var ADragCursor:TCursor); virtual;
    function GetIsCustomizing: Boolean; virtual;
    function GetNodeDragText(Node: TdxTreeListNode; AbsoluteIndex: Integer): string; virtual;
    function IsHeaderCustomizing: Boolean; virtual;
    procedure SetBandInfo(PPosInfo: Pointer; AIndex: Integer);
    procedure SetInfo(PPosInfo: Pointer; ABandIndex, ARowIndex, AColIndex, AAbsoluteIndex: Integer);

    // DragDrop Bands
    procedure BandMoved(FromIndex, ToIndex: Integer); virtual; // visible indexes
    function CanBandDragging(VisibleIndex: Integer): Boolean; virtual;
    procedure DoDragOverBand(P: TPoint{client}; AbsoluteIndex: Integer; var Accept: Boolean); virtual;
    procedure DoEndDragBand(P: TPoint; AbsoluteIndex, VisibleIndex: Integer; var NewIndex: Integer; var Accept: Boolean); virtual;
    procedure EndDragBand(Flag: Boolean); virtual;
    function GetBandDisableCustomizing(AbsoluteIndex: Integer): Boolean; virtual;
    procedure HideBand(AbsoluteIndex: Integer); virtual;
    function IsBandInListBox(AbsoluteIndex: Integer): Boolean; virtual;
    procedure StartDragBand(AbsoluteIndex: Integer); virtual;
    procedure ShowBand(NewIndex{visible index}, AbsoluteIndex: Integer); virtual;

    // DragDrop Headers
    function CanHeaderDragging(AbsoluteIndex: Integer): Boolean; virtual;
    procedure DoDragOverHeader(P: TPoint{client}; AbsoluteIndex: Integer; var Accept: Boolean); virtual;
    procedure DoEndDragHeader(P: TPoint; AbsoluteIndex: Integer; var NewPosInfo: TdxHeaderPosInfo; var Accept: Boolean); virtual;
    procedure EndDragHeader(Flag: Boolean); virtual;
    function GetDragHeaderWidth(AbsoluteIndex: Integer): Integer; virtual; // UnVisible Header or Group Header
    function GetHeaderDisableCustomizing(AbsoluteIndex: Integer): Boolean; virtual;
    procedure HeaderMoved(FromAbsoluteIndex, ToBandIndex, ToRowIndex, ToColIndex: Integer); virtual;
    procedure HideHeader(AbsoluteIndex: Integer); virtual;
    function IsHeaderInListBox(AbsoluteIndex: Integer): Boolean; virtual;
    function IsHeaderVisible(AbsoluteIndex: Integer): Boolean; virtual;
    procedure StartDragHeader(AbsoluteIndex: Integer); virtual;
    procedure ShowColumnHeader(BandIndex, RowIndex, ColIndex, AbsoluteIndex: Integer); virtual;

    // DragDrop Nodes
    procedure DoBeginDragNode(Node: TdxTreeListNode); virtual;
    procedure DoEndDrag(Target: TObject; X, Y: Integer); override;
    procedure DoStartDrag(var DragObject: TDragObject); override;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean); override;
    function GetDragImages: {$IFDEF DELPHI4}TDragImageList{$ELSE}TCustomImageList{$ENDIF}; override;
    function IsLastNode(ANode: TdxTreeListNode): Boolean; virtual;
    function IsTopNode(ANode: TdxTreeListNode): Boolean; virtual;

    // Size
    function CalcDistance(Distance: Integer): Integer;
    function CalcNearTopIndex(AIndex: Integer): Integer;
    function CalcRowCount(ATopVisibleNode: TdxTreeListNode; AHeight: Integer;
      var ARowCount, AVisibleRowCount: Integer): Integer;
    procedure CheckSize;
    function GetVisibleRowCount: Integer; virtual;
    procedure GetVScrollInfo(var Min, Max, Pos : Integer; var Page, Mask : UINT); virtual;
    procedure UpdateRowCount; virtual;
    procedure UpdateScrollBars; virtual;

    //Editor
    function AssignEditValue(ANode: TdxTreeListNode; AColumn: Integer; AInplaceEdit: TdxInplaceEdit): Variant; virtual;
    function CanEditAcceptKey(Key: Char): Boolean; override;
    function CanEditModify: Boolean; override;
    function CanEditShow: Boolean; virtual;
    function CanTreeListAcceptKey(Key: Word; Shift: TShiftState): Boolean; virtual;
    procedure CheckHotTrackNode(AHitInfo: TdxTreeListHitInfo); virtual;
    function CreateEditor(AColumn: Integer): TdxInplaceEdit; virtual;
    function CreateEditStyle(AEdit: TdxInplaceEdit): TdxEditStyle; override;
    procedure DoBeforeEditNewItemRow(var Allow: Boolean); virtual;
    procedure DoBeginNewItemActive; virtual;
    procedure DoHotTrackNode(AHotTrackInfo: TdxTreeListHotTrackInfo; var ACursor: TCursor); virtual;
    function EditStyleBorderColor: TColor;
    function EditStyleBorderStyle: TdxEditBorderStyle;
    function EditStyleButtonStyle: TdxEditButtonViewStyle;
    function EditStyleButtonTransparence: TdxEditButtonTransparence;
    function EditStyleEdges: TdxEditEdges;
    function EditStyleHotTrack: Boolean;
    function EditStyleShadow: Boolean;
    function FindInplaceEdit(AColumn : Integer):TdxInplaceEdit; virtual;
    function GetEditColor: TColor; override;
    function GetEditFont: TFont; override;
    function GetEditingText : String; virtual;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); virtual;
    function InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; virtual; // return Value for Editor
    procedure InvalidateEditor;
    function IsEditorMoved: Boolean; override;
    function IsHotTrackNode(ANode: TdxTreeListNode; AIndex: Integer): Boolean; virtual;
    procedure MoveCol(ALeft: Boolean); override;
    procedure RedrawSelection; override;
    procedure SetEditingText(Value : String); virtual;

    // Selected
    function CanFullMultiSelect: Boolean; virtual;
    function CanNodeSelected(ANode: TdxTreeListNode): Boolean; virtual;
    procedure ClearSelection; virtual;
    function CompareSelectionAnchor(ANode: TdxTreeListNode): Integer; virtual;
    procedure DeleteSelection; virtual;
    procedure DoSelectedCountChange; virtual;
    function GetFirstSelectedNode: TdxTreeListNode;
    function GetSelectedCount: Integer; virtual;
    function GetSelectedItem(AIndex: Integer): TdxTreeListNode; virtual;
    procedure InvalidateSelection; virtual;
    function IsNodeSelected(ANode: TdxTreeListNode):Boolean; virtual;
    procedure NodeSelected(ANode: TdxTreeListNode; ASelected: Boolean); virtual;
    procedure SelectNodes(N1, N2: TdxTreeListNode); virtual;
    procedure SetSelectionAnchor(ANode : TdxTreeListNode); virtual;

    // Sorting
    procedure ClearColumnsSorted; virtual;
    function CompareEqual(Node1, Node2: TdxTreeListNode): Integer; virtual;
    procedure DoSortColumn(StartIndex, ColIndex: Integer; FlagDesc: Boolean); virtual;
    procedure DoSortNodes(List: TList; Col: Integer; FlagDesc: Boolean);
    function GetSortedColumnCount: Integer; virtual;
    function GetSortedColumnDesc(Index: Integer): Boolean; virtual;
    function GetSortedColumnIndex(Index: Integer): Integer; virtual; // return AbsoluteIndex
    function IsMultiSortColumn(AbsoluteIndex: Integer): Boolean; virtual;

    // Paint
    function AssignedDrawBandEvent(VisibleIndex: Integer): Boolean; virtual;
    function AssignedDrawCellEvent(ANode: TdxTreeListNode; AbsoluteIndex: Integer{Column Index}): Boolean; virtual;
    function AssignedDrawFooterCellEvent(ANode: TdxTreeListNode; AbsoluteIndex, FooterIndex: Integer{Column Index}): Boolean; virtual;
    function AssignedDrawHeaderEvent(AbsoluteIndex: Integer): Boolean; virtual;
    function AssignedDrawPreviewEvent: Boolean; virtual;
    function AssignedLevelColorEvent: Boolean; virtual;
    procedure DoDrawBand(VisibleIndex: Integer; ACanvas: TCanvas; ARect, AClipRect: TRect; var AText: string;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment; var ADone: Boolean); virtual;
    procedure DoDrawCell(ACanvas: TCanvas; var ARect: TRect; ANode: TdxTreeListNode; AIndex: Integer; ASelected, AFocused: Boolean;
      ANewItemRow: Boolean; ALeftEdge, ARightEdge: Boolean; ABrush: HBRUSH;
      var AText: string; var AColor: TColor; AFont: TFont; var AAlignment: TAlignment; var ADone: Boolean); virtual;
    procedure DoDrawFooterCell(ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode; AIndex, AFooterIndex: Integer; var AText: string;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment; var ADone: Boolean); virtual;
    procedure DoDrawHeader(AbsoluteIndex: Integer; ACanvas: TCanvas; ARect, AClipRect: TRect; var AText: string;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment; var ASorted: TdxTreeListColumnSort; var ADone: Boolean); virtual;
    procedure DoDrawPreview(ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode; ASelected: Boolean;
      var AText: string; var AColor, ATextColor: TColor; AFont: TFont; var ADone: Boolean); virtual;
    procedure DoGetLevelColor(ALevel: Integer; var AColor: TColor); virtual;
    procedure DrawCell(ACanvas: TCanvas; ARect: TRect; ABitmap: TBitmap; ANode: TdxTreeListNode; AIndex, AFooterIndex: Integer;
      ASelected, AFocused: Boolean; ACellColor: TColor; ABrush: HBRUSH; AMultiLine: Boolean; ACellKind: TdxGridDrawCellKind;
      ALeftEdge, ARightEdge: Boolean); virtual;
    // TODO PAINT1
    procedure DefaultDrawCell(ADC: HDC; ARect: TRect; AAbsoluteIndex: Integer;
      ACellViewData: TdxTreeListCellViewData); virtual;
    procedure DrawCellEx(ACanvas: TCanvas; ARect: TRect; ABitmap: TBitmap; {temp draw bitmap}
      ANode: TdxTreeListNode; AIndex: Integer; ASelected, AFocused: Boolean;
      ACellColor, ACellTextColor: TColor; ABrush: HBRUSH; AMultiLine: Boolean; ACellKind: TdxGridDrawCellKind;
      ALeftEdge, ARightEdge: Boolean; ACellBkColor: TColor; ACellBkBrush: HBRUSH); virtual;

    procedure DrawGroupPanel(ACanvas: TCanvas; ARect: TRect; HeaderBrush, PanelBrush: HBRUSH); virtual;
    procedure DrawPreview(ACanvas: TCanvas; ARect: TRect; ABitmap: TBitmap; ANode: TdxTreeListNode; AColor, ATextColor: TColor; ABrush: HBRUSH; ASelected: Boolean); virtual;
    function GetGridColor(ABrushColor: TColor): TColor; virtual;
    procedure InvalidateHotTrack(AHotTrackInfo: TdxTreeListHotTrackInfo);
    procedure InvalidateRect(ARect: TRect);

    procedure PrepareNode(ANode: TdxTreeListNode); virtual;
    procedure UnPrepareNode(ANode: TdxTreeListNode); virtual;
    // Navigation
    function GetNodeByNavigation(ANode: TdxTreeListNode; ANavigationMode: TdxTreeListNavigationMode;
      AGotoHidden: Boolean): TdxTreeListNode; virtual;
    function GotoNodeByNavigation(ANavigationMode: TdxTreeListNavigationMode;
      AGotoHidden: Boolean): TdxTreeListNode; virtual;

    // Search
    procedure CheckSearchColumn;
    procedure DoSearch(var AText: string; ADirection: TdxTreeListSearchDirection; AExact: Boolean); virtual;
    function FindNodeByText(AColumnIndex: Integer; const AText: string;
      ADirection: TdxTreeListSearchDirection; var ANode: TdxTreeListNode): Boolean; virtual;
    property ArrowsColor: TColor read FArrowsColor write FArrowsColor default dxclArrows;
    property AutoExpandOnSearch: Boolean read FAutoExpandOnSearch write FAutoExpandOnSearch default True;
    property AutoSearchColor: TColor read FAutoSearchColor write FAutoSearchColor default clNone;
    property AutoSearchTextColor: TColor read FAutoSearchTextColor write FAutoSearchTextColor default clNone;
    property BandColor: TColor read FBandColor write SetBandColor default clBtnFace;
    property BandFont: TFont read FBandFont write SetBandFont stored IsHeaderFontStored;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property Color default clWindow;
    property DblClkExpanding: Boolean read FDblClkExpanding write FDblClkExpanding default True;
    property DefaultRowHeight: Integer read GetDefaultRowHeight write SetDefaultRowHeight stored IsRowHeightStored;
    property DragNode: TdxTreeListNode read FDragNode;
    property EditingText: string read GetEditingText write SetEditingText;
    property FixedBandLineColor: TColor read FFixedBandLineColor write SetFixedBandLineColor default clWindowFrame;
    property FixedBandLineWidth: Integer read FFixedBandLineWidth write SetFixedBandLineWidth default dxGridFixedBandLineWidth;
    property FocusedAbsoluteIndex: Integer read GetFocusedColumnAbsoluteIndex
      write SetFocusedColumnAbsoluteIndex; // absolute header index
    property FocusedColumn: Integer read GetFocusedColumn write SetFocusedColumn;
    property FocusedNumber: Integer read GetFocusedNumber write SetFocusedNumber;
    property GridLineColor: TColor read FGridLineColor write SetGridLineColor default clNone;
    property GroupNodeColor: TColor read FGroupColor write SetGroupColor default clBtnFace;
    property GroupNodeTextColor: TColor read FGroupTextColor write SetGroupTextColor default clNone;
    property HeaderColor: TColor read FHeaderColor write SetHeaderColor default clBtnFace;
    property HeaderFont: TFont read FHeaderFont write SetHeaderFont stored IsHeaderFontStored;
    property HideFocusRect: Boolean read FHideFocusRect write SetHideFocusRect default True;
    property HideSelection: Boolean read FHideSelection write SetHideSelection default True;
    property HideSelectionColor: TColor read FHideSelectionColor write SetHideSelectionColor default clBtnFace;
    property HideSelectionTextColor: TColor read FHideSelectionTextColor write SetHideSelectionTextColor default clBtnText;
    property HighlightColor: TColor read FHighlightColor write SetHighlightColor default clHighlight;
    property HighlightTextColor: TColor read FHighlightTextColor write SetHighlightTextColor default clHighlightText;
    property HotTrackInfo: TdxTreeListHotTrackInfo read FHotTrackInfo;
    property Images: TImageList read FImages write SetImages;
    property Indent: Integer read FIndent;
    property IndentDesc: Integer read FIndentDesc write SetIndentDesc default 20;
    property LeftCoord: Integer read FLeftCoord write SetLeftCoord;
    property LockUpdate: Integer read FLockUpdate;
    property LookAndFeel: TdxLookAndFeel read FLookAndFeel write SetLookAndFeel default lfStandard;
    property MaxRowLineCount: Integer read FMaxRowLineCount write SetMaxRowLineCount default -1;
    property NewItemRowActive: Boolean read FNewItemRowActive write SetNewItemRowActive;
    property PaintStyle: TdxTreeListPaintStyle read FPaintStyle write SetPaintStyle default psStandard;
    property ParentColor default False;
    property PreviewFont: TFont read FPreviewFont write SetPreviewFont stored IsHeaderFontStored;
    property PreviewLines: Integer read FPreviewLines write SetPreviewLines default 2;
    property RowCount: Integer read FRowCount;
    property RowFooterColor: TColor read FFooterColor write SetFooterColor default cl3DLight;
    property RowFooterTextColor: TColor read FFooterTextColor write SetFooterTextColor default clWindowText;
    property RowSeparatorLineWidth: Integer read GetRowSeparatorLineWidth write SetRowSeparatorLineWidth default 1;
    property ScrollBars: TScrollStyle read FScrollBars write SetScrollBars default ssBoth;
    property SelectedCount: Integer read GetSelectedCount;
    property SelectedNodes[Index:Integer] : TdxTreeListNode read GetSelectedItem;
    property SelectionAnchor: TdxTreeListNode read FSelectionAnchor write SetSelectionAnchor;
    property ShowBands: Boolean read FShowBands write SetBandVisible default False;
    property ShowButtons: Boolean read FShowButtons write SetButtonVisible default True;
    property ShowFooter: Boolean read FShowFooter write SetFooterVisible default False;
    property ShowGrid: Boolean read FShowGrid write SetGridVisible default False;
    property ShowHeader: Boolean read FShowHeaders write SetHeaderVisible default True;
    property ShowIndicator: Boolean read FShowIndicator write SetIndicatorVisible default False;
    property ShowLines: Boolean read FShowLines write SetLineVisible default True;
    property ShowNewItemRow: Boolean read FShowNewItemRow write SetNewItemRowVisible default False;
    property ShowPreviewGrid: Boolean read FShowPreviewGrid write SetPreviewGridVisible default True;
    property ShowRoot: Boolean read GetRootVisible write SetRootVisible default True;
    property ShowRowFooter: Boolean read FShowRowFooter write SetRowFooterVisible default False;

    property SimpleCustomizeBox: Boolean read FSimpleCustomizeBox write FSimpleCustomizeBox default False;
    property ShowHiddenInCustomizeBox: Boolean read FShowHiddenInCustomizeBox write FShowHiddenInCustomizeBox default False;

    property ShowDragImage: Boolean read FShowDragImage write FShowDragImage default True;
    property StateImages: TImageList read FStateImages write SetStateImages;
    property TopIndex: Integer read GetTopIndex write SetTopIndex;
    property TreeLineColor: TColor read FTreeLineColor write SetTreeLineColor default clBtnShadow;
    property TreeLineStyle: TdxTreeLineStyle read FTreeLineStyle write SetTreeLineStyle default tlDot;
    property VisibleRowCount: Integer read GetVisibleRowCount;
    property WaitForExpandNodeTime: UINT read FWaitForExpandNodeTime write FWaitForExpandNodeTime default dxWaitForExpandNodeTime;
    property OnBeginDragNode: TTLExpandedEvent read FOnBeginDragNode write FOnBeginDragNode;
    property OnCanNodeSelected: TdxTLCanNodeSelected read FOnCanNodeSelected write FOnCanNodeSelected;
    property OnChangeColumn: TTLChangeColumnEvent read FOnChangeColumn write FOnChangeColumn;
    property OnChangeLeftCoord: TNotifyEvent read FOnChangeLeftCoord write FOnChangeLeftCoord;
    property OnChangeNode: TTLChangeNodeEvent read FOnChangeNode write FOnChangeNode;
    property OnChangeTopVisibleNode: TNotifyEvent read FOnChangeTopVisibleNode write FOnChangeTopVisibleNode;
    property OnCollapsed: TTLExpandedEvent read FOnCollapsed write FOnCollapsed;
    property OnCollapsing: TTLExpandingEvent read FOnCollapsing write FOnCollapsing;
    property OnCompare: TdxTLCompareEvent read FOnCompare write FOnCompare;
    property OnDeletion: TTLExpandedEvent read FOnDeletion write FOnDeletion;
    property OnEditChange: TNotifyEvent read FOnEditChange write FOnEditChange;
    property OnEdited: TTLExpandedEvent read FOnEdited write FOnEdited;
    property OnEditing: TTLExpandingEvent read FOnEditing write FOnEditing;
    property OnEditValidate: TdxEditValidateEvent read FOnEditValidate write FOnEditValidate;
    property OnEndColumnsCustomizing: TNotifyEvent read FOnEndColumnsCustomizing write FOnEndColumnsCustomizing;
    property OnExpanded: TTLExpandedEvent read FOnExpanded write FOnExpanded;
    property OnExpanding: TTLExpandingEvent read FOnExpanding write FOnExpanding;
    property OnGetEditColor: TdxTLGetEditColor read FOnGetEditColor write FOnGetEditColor;
    property OnHotTrackNode: TdxTLHotTrackNode read FOnHotTrackNode write FOnHotTrackNode;
    property OnSelectedCountChange : TNotifyEvent read FOnSelectedCountChange write FOnSelectedCountChange;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function Add: TdxTreeListNode;
    function AddFirst: TdxTreeListNode;
    procedure AdjustColumnsWidth;
    procedure BeginUpdate;
    procedure CalcDrawInfo(var DrawInfo: TdxGridDrawInfo);
    procedure CalcRectInfo(var DrawInfo: TdxGridDrawInfo);
    procedure CancelEditor;
    procedure CancelUpdate;
    function CellRect(ANode:TdxTreeListNode; AColumn : Integer): TRect;
    procedure ClearNodes;
    procedure CloseEditor;
    procedure ColumnsCustomizing;
    procedure CopyAllToClipboard;
    procedure CopySelectedToClipboard;
    procedure EndColumnsCustomizing;
    procedure EndUpdate;
    procedure FreeDrawInfo(var DrawInfo: TdxGridDrawInfo);
    procedure FullCollapse;
    procedure FullExpand;
    function GetEditRect(Node: TdxTreeListNode; Column: Integer): TRect;
    function GetFocusedAbsoluteIndex(FocusedIndex: Integer): Integer;
    function GetFocusedVisibleIndex(AbsoluteIndex: Integer): Integer;
    function GetHitInfo(Pos: TPoint): TdxTreeListHitInfo; virtual;
    function GetHitTestInfoAt(X, Y: Integer): TdxTreeListHitTest;
    function GetNextVisible(Node: TdxTreeListNode): TdxTreeListNode;
    function GetNodeAt(X, Y: Integer): TdxTreeListNode;
    procedure GotoFirst;
    procedure GotoLast(AGotoHidden: Boolean);
    function GotoNext(AGotoHidden: Boolean): Boolean;
    function GotoPrev(AGotoHidden: Boolean): Boolean;
    function HideDrawFocusRect: Boolean; override;
    procedure HideEditor;
    function IndexOf(Value: TdxTreeListNode): Integer;
    function Insert(BeforeNode: TdxTreeListNode): TdxTreeListNode;
    function IsActive: Boolean; virtual;
    function IsBOF: Boolean; virtual;
    function IsEOF: Boolean; virtual;
    function IsInvertSelect: Boolean; virtual;
    function IsNodeVisible(Node: TdxTreeListNode): Boolean;
    function IsShowButtonAlways: Boolean; override;
    procedure MakeBandVisible(VisibleIndex: Integer);
    procedure MakeColumnVisible(AbsoluteIndex: Integer);
    procedure MakeNodeVisible(Node: TdxTreeListNode);
    function PointInCustomizingForm(P: TPoint): Boolean;
    procedure SaveAllToStrings(List: TStrings); virtual;
    procedure SaveAllToTextFile(const FileName: String);
    procedure SaveSelectedToStrings(List: TStrings); virtual;
    procedure SaveSelectedToTextFile(const FileName: String);
    procedure ShowEditor;
    procedure ShowEditorChar(Ch: Char);
    procedure ShowButtonEditorMouse(X, Y: Integer);
    procedure ShowEditorMouse(X, Y: Integer);
    procedure StabilizeAutoWidth;
    function StartSearch(AColumnIndex: Integer; const AText: string): Boolean;
    procedure EndSearch;

    // TODO ?
    function GetDefaultPopupBorderStyle(AEditBorderStyle: TdxEditBorderStyle): TdxPopupBorderStyle; override;

    procedure BeginSelection; virtual;
    procedure EndSelection; virtual;
    property LockSelection: Integer read FLockSelection;

    property BandButtonPushed: Boolean read FBandButtonPushed;
    property BandPanelHeight: Integer read FBandHeight;
    property Canvas;
    property Count: Integer read GetCount;
    property CustomizingBandListBox: TdxBandsListBox read FCustomizingBandListBox;
    property CustomizingForm: TForm read FCustomizingForm;
    property CustomizingHeaderListBox: TdxHeadersListBox read FCustomizingHeaderListBox;
    property CustomizingPos: TPoint read FCustomizingPos write FCustomizingPos;
    property CustomizingRowCount: Integer read FCustomizingRowCount write SetCustomizingRowCount default dxCustomizingRowCount;
    property DescTextHeight: Integer read FDescTextHeight;
    property DownBandIndex: Integer read FDownBandIndex;
    property DownBandPushed: Boolean read FDownBandPushed;
    property DownColumnIndex: Integer read FDownColumnIndex; // absolute index
    property DownColumnPushed: Boolean read FDownColumnPushed;
    property DragAbsoluteBandIndex: Integer read FDragAbsoluteBandIndex;
    property DragAbsoluteHeaderIndex: Integer read FDragAbsoluteHeaderIndex;
    property FocusedNode: TdxTreeListNode read GetFocused;
    property FooterPanelHeight: Integer read FFooterHeight;
    property FooterRowHeight: Integer read FFooterRowHeight;
    property FooterRowNodeHeight: Integer read FFooterRowNodeHeight;
    property HeaderButtonPushed: Boolean read FHeaderButtonPushed;
    property HeaderHeight: Integer read FHeaderHeight;
    property HeaderPanelHeight: Integer read FHeaderHeight;
    property HeaderRowHeight: Integer read FHeaderRowHeight;
    property InplaceColumnIndex: Integer read FInplaceColumnIndex;
    property InplaceEditor: TdxInplaceEdit read FInplaceEdit;
    property IsCustomizing: Boolean read GetIsCustomizing;
    property Items[Index: Integer]: TdxTreeListNode read GetNode;
    property LastNode: TdxTreeListNode read GetLastNode;
    property NewItemRowHeight: Integer read FNewItemRowHeight;
    property Options: TdxTreeListOptions read GetOptions write SetOptions
        default [aoEditing, aoColumnSizing, aoColumnMoving, aoRowSelect, aoTabThrough];
    property OptionsEx: TdxTreeListOptionsEx read GetOptionsEx write SetOptionsEx
        default [aoUseBitmap, aoBandHeaderWidth, aoAutoCalcPreviewLines,
          aoBandSizing, aoBandMoving, aoDragExpand, aoDragScroll];
    property ReadOnly;
    property RowHeight: Integer read FRowHeight;
    property Searching: Boolean read FSearching;
    property SearchText: string read FSearchText;
    property State: TdxTreeListState read FState;
    property TopNode: TdxTreeListNode read GetTopNode;
    property TopVisibleNode: TdxTreeListNode read FTopVisibleNode;
    {$IFDEF EGRID_DEBUG}
    property OnDebugEvent: TdxDBGridDebugEvent read FOnDebugEvent write FOnDebugEvent;
    {$ENDIF}
  published
    property TabStop default True;
  end;

  {TdxCustomizingListBox}
  TdxCustomizingListBox = class(TListBox)
  private
    FDragFlag: Boolean;
    FDragItemIndex: Integer;
    FFlat: Boolean;
    FMultiLine: Boolean;
    FPointDragging: TPoint;
    FTreeList: TCustomdxTreeList;
    procedure DrawItem_(ACanvas: TCanvas; Index: Integer; Rect: TRect; Focused: Boolean);
    procedure SetFlat(Value: Boolean);
    procedure SetTreeList(Value: TCustomdxTreeList);
    // messages
    procedure WMCaptureChanged(var Msg: TMessage); message WM_CAPTURECHANGED;
    procedure WMLButtonUp(var Message : TMessage); message WM_LBUTTONUP;
    procedure WMMouseMove(var Message : TMessage); message WM_MOUSEMOVE;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TMessage); message WM_NCPaint;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    // virtual
    procedure BeginDragging(DragIndex: Integer); virtual;
    procedure DoCancelDragging; virtual;
    procedure DoDragging; virtual;
    procedure DoEndDragging(Flag: Boolean); virtual;
    procedure LoadItems(List: TStrings); virtual;
    procedure UpdateItems; virtual;
  public
    constructor Create(AOwner : TComponent); override;
    property DragItemIndex: Integer read FDragItemIndex;
    property Flat: Boolean read FFlat write SetFlat;
    property TreeList: TCustomdxTreeList read FTreeList write SetTreeList;
  end;

  {TdxBandsListBox}
  TdxBandsListBox = class(TdxCustomizingListBox)
  protected
    procedure BeginDragging(DragIndex: Integer); override;
    procedure DoDragging; override;
    procedure DoEndDragging(Flag: Boolean); override;
    procedure LoadItems(List: TStrings); override;
    procedure UpdateItems; override;
  end;

  {TdxHeadersListBox}
  TdxHeadersListBox = class(TdxCustomizingListBox)
  protected
    procedure BeginDragging(DragIndex: Integer); override;
    procedure DoDragging; override;
    procedure DoEndDragging(Flag: Boolean); override;
    procedure LoadItems(List: TStrings); override;
    procedure UpdateItems; override;
  end;

  {TdxTreeListTextNode}
  PdxTextNodeInfo = ^TdxTextNodeInfo;
  TdxTextNodeInfo = packed record
    ImageIndex: Integer;
    SelectedIndex: Integer;
    StateIndex: Integer;
    Data: Pointer;
    Count: Integer;
    StrCount: Integer;
    Str: record end;
  end;

  TdxTreeListTextNode = class(TdxTreeListNode)
  private
    procedure ReadData(Stream: TStream);
    procedure WriteData(Stream: TStream);
  protected
    FImageIndex: Integer;
    FSelectedIndex: Integer;
    FStateIndex: Integer;
    FStrings: TStrings;
  public
    constructor Create(AOwner: TCustomdxTreeList);
    destructor Destroy; override;
  end;

  TCustomdxTreeListControl = class;
  TdxTreeListColumn = class;

  {TdxTreeListBand}
  TdxGridBandFixed = (bfNone, bfLeft, bfRight);

  TdxTreeListBand = class(TCollectionItem)
  private
    FAlignment: TAlignment;
    FCaption: string;
    FDisableCustomizing: Boolean;
    FDisableDragging: Boolean;
    FFixed: TdxGridBandFixed;
    FMinWidth: Integer;
    FOnlyOwnColumns: Boolean;
    FSizing: Boolean;
    FVisible: Boolean;
    FWidth: Integer;
    function GetHeaderColCount(RowIndex: Integer): Integer;
    function GetHeaderColumn(RowIndex, ColIndex: Integer): TdxTreeListColumn;
    function GetHeaderRowCount: Integer;
    function GetVisibleIndex: Integer;
    procedure SetAlignment(Value: TAlignment);
    procedure SetCaption(const Value: string);
    procedure SetDisableCustomizing(Value: Boolean);
    procedure SetFixed(Value: TdxGridBandFixed);
    procedure SetMinWidth(Value: Integer);
    procedure SetSizing(Value: Boolean);
    procedure SetVisible(Value: Boolean);
    procedure SetWidth(Value: Integer);
  protected
    function GetdxTreeListControl: TCustomdxTreeListControl;
    procedure SetIndex(Value: Integer); override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; virtual;
    property HeaderRowCount: Integer read GetHeaderRowCount;
    property HeaderColCount[RowIndex: Integer]: Integer read GetHeaderColCount;
    property HeaderColumn[RowIndex, ColIndex: Integer]: TdxTreeListColumn read GetHeaderColumn;
    property VisibleIndex: Integer read GetVisibleIndex;
  published
    property Alignment: TAlignment read FAlignment write SetAlignment default taCenter;
    property Caption: string read FCaption write SetCaption;
    property DisableCustomizing: Boolean read FDisableCustomizing write SetDisableCustomizing default False;
    property DisableDragging: Boolean read FDisableDragging write FDisableDragging default False;
    property Fixed: TdxGridBandFixed read FFixed write SetFixed default bfNone;
    property MinWidth: Integer read FMinWidth write SetMinWidth default dxGridBandMinWidth;
    property OnlyOwnColumns: Boolean read FOnlyOwnColumns write FOnlyOwnColumns default False;
    property Sizing: Boolean read FSizing write SetSizing default True;
    property Visible: Boolean read FVisible write SetVisible default True;
    property Width: Integer read FWidth write SetWidth default dxGridBandDefaultWidth;
  end;

  TdxTreeListBandClass = class of TdxTreeListBand;

  {TdxTreeListBands}
  TdxTreeListBands = class(TCollection)
  private
    FTreeList: TCustomdxTreeListControl;
    function GetItem(Index: Integer): TdxTreeListBand;
    function GetVisibleCount: Integer;
    function GetVisibleItem(Index: Integer): TdxTreeListBand;
    procedure SetItem(Index: Integer; Value: TdxTreeListBand);
    procedure SetVisibleItem(Index: Integer; Value: TdxTreeListBand);
  protected
    function GetOwner: TPersistent; {$IFDEF DELPHI3} override;{$ENDIF}
    procedure RefreshFixedBands;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(ATreeList: TCustomdxTreeListControl; BandClass: TdxTreeListBandClass);
    function Add: TdxTreeListBand;
    procedure RestoreDefaults;
    function GetAbsoluteIndex(VisibleIndex: Integer): Integer;
    function GetVisibleIndex(AbsoluteIndex: Integer): Integer; // -1 if UnVisible

    property TreeList: TCustomdxTreeListControl read FTreeList;
    property Items[Index: Integer]: TdxTreeListBand read GetItem write SetItem; default;
    property VisibleCount: Integer read GetVisibleCount;
    property VisibleItems[Index: Integer]: TdxTreeListBand read GetVisibleItem write SetVisibleItem;
  end;

  {TdxTreeListColumn}
  TdxColumnValue = (cvAlignment, cvCaption, cvReadOnly, cvWidth, cvColor, cvFont, cvMaxLength);
  TdxColumnValues = set of TdxColumnValue;

  TdxTLCustomDrawCell = procedure(Sender: TObject; ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
    AColumn: TdxTreeListColumn; ASelected, AFocused, ANewItemRow: Boolean; var AText: string;
    var AColor: TColor; AFont: TFont; var AAlignment: TAlignment; var ADone: Boolean) of object;

  TdxTLCustomDrawHeader = procedure(Sender: TObject; AColumn: TdxTreeListColumn;
    ACanvas: TCanvas; ARect: TRect; var AText: string; var AColor: TColor;
    AFont: TFont; var AAlignment: TAlignment; var ASorted: TdxTreeListColumnSort; var ADone: Boolean) of object;

  TdxInplaceTreeListTextEdit = class(TdxInplaceTextEdit);

  TdxTreeListColumn = class(TComponent)
  private
    FTreeList: TCustomdxTreeListControl;
    FAlignment: TAlignment;
    FCaption: string;
    FCharCase: TEditCharCase;
    FColor: TColor;
    FDisableCaption: Boolean;
    FDisableCustomizing: Boolean; 
    FDisableEditor: Boolean;
    FDisableDragging: Boolean;
    FFont: TFont;
    FHeaderAlignment: TAlignment;
    FHeaderGlyph: TBitmap;
    FMaxLength: Integer;
    FMinWidth: Integer;
    FOEMConvert: Boolean;
    FPasswordChar: Char;
    FReadonly: Boolean;
    FSortedOrder: Integer;
    FSizing: Boolean;
    FTabStop: Boolean;            
    FVertAlignment: TTextLayout;
    FVisible: Boolean;
    FWidth: Integer;
    FAssignedValues: TdxColumnValues;
    FOnChangeName: TNotifyEvent;

    FBandIndex: Integer;
    FRowIndex: Integer;
    FHeaderMaxLineCount: Integer;
    FStoredRowIndex: Integer;
    FViewData: TdxEditViewData;
    FDisableFilter: Boolean;

    FOnChange: TNotifyEvent;
    FOnCustomDrawCell: TdxTLCustomDrawCell;
    FOnCustomDrawColumnHeader: TdxTLCustomDrawHeader;
    FOnValidate: TdxEditValidateEvent;
    function GetAlignment: TAlignment;
    function GetCaption: string;
    function GetColor: TColor;
    function GetFont: TFont;
    function GetHeaderGlyph: TBitmap;
    function GetMaxLength: Integer;
    function GetReadOnly: Boolean;
    function GetVisible: Boolean;
    function GetWidth: Integer;
    function IsAlignmentStored: Boolean;
    function IsCaptionStored: Boolean;
    function IsColorStored: Boolean;
    function IsFontStored: Boolean;
    function IsMaxLengthStored: Boolean;
    function IsReadOnlyStored: Boolean;
    function IsWidthStored: Boolean;
    procedure SetAlignment(Value: TAlignment);
    procedure SetCaption(const Value: string);
    procedure SetCharCase(Value: TEditCharCase);
    procedure SetColor(Value: TColor);
    procedure SetDisableCaption(Value: Boolean);
    procedure SetDisableCustomizing(Value: Boolean);
    procedure SetDisableFilter(Value: Boolean);
    procedure SetFont(Value: TFont);
    procedure SetHeaderAlignment(Value: TAlignment);
    procedure SetHeaderGlyph(Value: TBitmap);
    procedure SetMaxLength(Value: Integer);
    procedure SetMinWidth(Value: Integer);
    procedure SetOEMConvert(Value: Boolean);
    procedure SetPasswordChar(Value: Char);
    procedure SetReadOnly(Value: Boolean);
    procedure SetSizing(Value: Boolean);
    procedure SetSorted(Value: TdxTreeListColumnSort);
    procedure SetVertAlignment(Value: TTextLayout);
    procedure SetVisible(Value: Boolean);
    procedure SetWidth(Value: Integer);
    procedure SetTreeList(TreeList: TCustomdxTreeListControl);

    function GetBandIndex: Integer;
    function GetRowIndex: Integer;
    function GetColIndex: Integer;
    function GetHeaderMaxLineCount: Integer;
    procedure SetBandIndex(Value: Integer);
    procedure SetRowIndex(Value: Integer);
    procedure SetColIndex(Value: Integer);
    procedure SetHeaderMaxLineCount(Value: Integer);

    function GetSortedOrder: Integer;
    procedure ReadSortedOrder(Reader: TReader);
    procedure WriteSortedOrder(Writer: TWriter);
    procedure ReadStoredRowIndex(Reader: TReader);
    procedure WriteStoredRowIndex(Writer: TWriter);
  protected
    FSorted: TdxTreeListColumnSort;
    // TODO Wrapper Column
    FActualIndex: Integer;
    FActualNode: TdxTreeListNode;
    // override TComponent
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadState(Reader: TReader); override;
    procedure SetName(const Value: TComponentName); override;
    procedure SetParentComponent(AParent: TComponent); override;
    // original
    function AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; virtual;
    function AssignedDrawCellEvent: Boolean; virtual;
    procedure Changed(AllItems: Boolean);
    procedure ChangedWidth(Value: Integer);
    procedure DoChange(Sender: TObject); virtual;
    procedure DoDrawCell(ACanvas: TCanvas; var ARect: TRect; ANode: TdxTreeListNode;
      ASelected, AFocused: Boolean; ANewItemRow: Boolean; ALeftEdge, ARightEdge: Boolean; ABrush: HBRUSH;
      var AText: string; var AColor: TColor; AFont: TFont; var AAlignment: TAlignment; var ADone: Boolean); virtual;
    procedure DoValidate(Sender: TObject; var ErrorText: string; var Accept: Boolean); virtual;
    procedure DrawColumnIndent(DC: HDC; var ARect: TRect; ALeftEdge, ARightEdge: Boolean; ABrush: HBRUSH);
    procedure FontChanged(Sender: TObject); virtual;
    function GetdxInplaceEditClass: TdxInplaceEditClass; virtual;
    function GetDisplayText(ANode: TdxTreeListNode): string; virtual;
    function GetEnableEditor: Boolean; virtual;
    procedure GetHotTrackCursor(ANode: TdxTreeListNode; var ACursor: TCursor); virtual;
    function GetIndex: Integer; virtual;
    function GetMaxRowHeight(ACanvas: TCanvas): Integer; virtual;
    function GetViewData: TdxEditViewData; virtual;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); virtual;
    function InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; virtual;
    function IsColumnHotTrack(X, Y: Integer; Node: TdxTreeListNode; var ActiveIndex: Integer): Boolean; virtual;
    function IsHeaderHotTrack(X, Y: Integer; var HeaderHotTrack: TdxTreeListHeaderHotTrack): Boolean; virtual;
    function IsColumnMultiLine: Boolean; virtual;
    function NeedShowButtonEdit(X, Y: Integer; IsCurrentNode: Boolean): Boolean; virtual;
    procedure PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData); virtual;
    procedure RefreshDefaultFont;
    procedure RefreshDefaultWidth;
    procedure SetIndex(Value: Integer); virtual;
    property SortedOrder: Integer read GetSortedOrder write FSortedOrder;
    property StoredRowIndex: Integer read FStoredRowIndex write FStoredRowIndex;
    property ViewData: TdxEditViewData read GetViewData;
    property DisableFilter: Boolean read FDisableFilter write SetDisableFilter default False; 
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function ConvertExportValue(var Value: Variant; IsHTML: Boolean): Boolean; virtual;
    function DefaultAlignment: TAlignment; virtual;
    function DefaultCaption: string; virtual;
    function DefaultColor: TColor;
    function DefaultFont: TFont;
    function DefaultMaxLength: Integer; virtual;
    function DefaultReadOnly: Boolean; virtual;
    function DefaultWidth: Integer; virtual;
    function GetBestFit(ACanvas: TCanvas; ANode: TdxTreeListNode): Integer; virtual;
    function GetDisplayValue(Node: TdxTreeListNode; const Value: string): string; virtual;
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;
    procedure RestoreDefaults; virtual;
    procedure RestoreDefaultWidth;
    property AssignedValues: TdxColumnValues read FAssignedValues;
    property TreeList: TCustomdxTreeListControl read FTreeList write SetTreeList;
    property Index: Integer read GetIndex write SetIndex;
    property OnChangeName: TNotifyEvent read FOnChangeName write FOnChangeName;
  published
    property Alignment: TAlignment read GetAlignment write SetAlignment stored IsAlignmentStored;
    property Caption: string read GetCaption write SetCaption stored IsCaptionStored;
    property CharCase: TEditCharCase read FCharCase write SetCharCase default ecNormal;
    property Color: TColor read GetColor write SetColor stored IsColorStored;
    property DisableCaption: Boolean read FDisableCaption write SetDisableCaption default False;
    property DisableCustomizing: Boolean read FDisableCustomizing write SetDisableCustomizing default False;
    property DisableDragging: Boolean read FDisableDragging write FDisableDragging default False;
    property DisableEditor: Boolean read FDisableEditor write FDisableEditor default False;
    property Font: TFont read GetFont write SetFont stored IsFontStored;
    property HeaderAlignment: TAlignment read FHeaderAlignment write SetHeaderAlignment default taLeftJustify;
    property HeaderGlyph: TBitmap read GetHeaderGlyph write SetHeaderGlyph;
    property MaxLength: Integer read GetMaxLength write SetMaxLength stored IsMaxLengthStored;
    property MinWidth: Integer read FMinWidth write SetMinWidth default dxGridHeaderMinWidth;
    property OEMConvert: Boolean read FOEMConvert write SetOEMConvert default False;
    property PasswordChar: Char read FPasswordChar write SetPasswordChar default #0;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly stored IsReadOnlyStored;
    property Sizing: Boolean read FSizing write SetSizing default True;
    property Sorted: TdxTreeListColumnSort read FSorted write SetSorted default csNone;
    property TabStop: Boolean read FTabStop write FTabStop default True;
    property VertAlignment: TTextLayout read FVertAlignment write SetVertAlignment default tlTop;
    property Visible: Boolean read GetVisible write SetVisible default True;
    property Width: Integer read GetWidth write SetWidth stored IsWidthStored;

    property BandIndex: Integer read GetBandIndex write SetBandIndex;
    property RowIndex: Integer read GetRowIndex write SetRowIndex;
    property ColIndex: Integer read GetColIndex write SetColIndex stored False;
    property HeaderMaxLineCount: Integer read GetHeaderMaxLineCount write SetHeaderMaxLineCount default 1;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnCustomDrawCell: TdxTLCustomDrawCell read FOnCustomDrawCell write FOnCustomDrawCell;
    property OnCustomDrawColumnHeader: TdxTLCustomDrawHeader read FOnCustomDrawColumnHeader write FOnCustomDrawColumnHeader;
    property OnValidate: TdxEditValidateEvent read FOnValidate write FOnValidate;
  end;

  TdxTreeListColumnClass = class of TdxTreeListColumn;
  TdxTreeListDesigner = class;

  TdxTLCustomDrawBand = procedure(Sender: TObject; ABand: TdxTreeListBand;
    ACanvas: TCanvas; ARect: TRect; var AText: string;
    var AColor: TColor; AFont: TFont; var AAlignment: TAlignment; var ADone: Boolean) of object;

  TdxTLCustomDrawFooterNode = procedure(Sender: TObject; ACanvas: TCanvas; ARect: TRect;
      ANode: TdxTreeListNode; AColumn: TdxTreeListColumn; AFooterIndex: Integer; var AText: string;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment; var ADone: Boolean) of object;

  TdxTLCustomDrawFooter = procedure(Sender: TObject; ACanvas: TCanvas; ARect: TRect;
      ANode: TdxTreeListNode; AColumn: TdxTreeListColumn; var AText: string;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment; var ADone: Boolean) of object;

  TdxTLCustomDrawPreview = procedure(Sender : TObject; ACanvas: TCanvas; ARect: TRect;
    ANode: TdxTreeListNode; ASelected: Boolean; var AText: string;
    var AColor, ATextColor: TColor; AFont: TFont; var ADone: Boolean) of object;

  TdxTLGetLevelColor = procedure(Sender: TObject; ALevel: Integer; var AColor: TColor) of object;

  TdxTLCanBandDragging = procedure(Sender: TObject; ABand: TdxTreeListBand; var Allow: Boolean) of object;
  TdxTLStartBandDragging = procedure(Sender: TObject; ABand: TdxTreeListBand) of object;
  TdxTLDragOverBand = procedure(Sender: TObject; ABand: TdxTreeListBand; P: TPoint; var Accept: Boolean) of object;
  TdxTLDragEndBand = procedure(Sender: TObject; ABand: TdxTreeListBand; P: TPoint;
    AbsoluteIndex, VisibleIndex: Integer; var NewIndex: Integer; var Accept: Boolean) of object;
  TdxTLShowBand = procedure(Sender: TObject; ABand: TdxTreeListBand; NewIndex: Integer) of object;

  TdxTLCanHeaderDragging = procedure(Sender: TObject; AColumn: TdxTreeListColumn; var Allow: Boolean) of object;
  TdxTLStartHeaderDragging = procedure(Sender: TObject; AColumn: TdxTreeListColumn) of object;
  TdxTLDragOverHeader = procedure(Sender: TObject; AColumn: TdxTreeListColumn; P: TPoint; var Accept: Boolean) of object;
  TdxTLDragEndHeader = procedure(Sender: TObject; AColumn: TdxTreeListColumn; P: TPoint;
    var NewPosInfo: TdxHeaderPosInfo; var Accept: Boolean) of object;
  TdxTLShowHeader = procedure(Sender: TObject; AColumn: TdxTreeListColumn;
    BandIndex, RowIndex, ColIndex: Integer) of object;
  TdxTreeListColumnSorting = procedure(Sender: TObject; Column: TdxTreeListColumn; var Allow: Boolean) of object;

  // obsolete
  TTLColumnMovedEvent = procedure(Sender: TObject; FromIndex, ToIndex: Longint) of object;
  TTLCustomDrawEvent = procedure(Sender: TObject; ACanvas: TCanvas; ARect: TRect;
     ANode: TdxTreeListNode; AColumn: TdxTreeListColumn; const AText: String;
     AFont: TFont; var AColor: TColor; ASelected, AFocused: Boolean; var ADone: Boolean ) of object;
  TTLColumnClick = procedure(Sender : TObject; Column : TdxTreeListColumn) of object;
  TTLColumnSorted = procedure (Sender: TObject; Column: TdxTreeListColumn;
    var Sorted : TdxTreeListColumnSort) of object;
  TTLCustomDrawPreviewEvent = procedure(Sender: TObject; ACanvas: TCanvas; ARect: TRect;
     ANode: TdxTreeListNode; ASelected: Boolean; const AText: String; var ADone : Boolean ) of object;
  TdxTLEndDragColumn = procedure(Sender : TObject; X, Y: Integer;
    Column: TdxTreeListColumn; var NewPosition: Integer) of object;
  TdxTLHeaderMoved = procedure(Sender: TObject; Column: TdxTreeListColumn) of object;

  // new
  TdxTLCalcRowLineHeight = procedure(Sender: TObject; Node: TdxTreeListNode; Column: TdxTreeListColumn;
    const Text: string; BoundsWidth, TextHeight, MaxLineCount: Integer; InflateFlag{obsolete}, GridFlag{obsolete}: Boolean;
    var LineCount, LineHeight: Integer; var Done: Boolean) of object;

  TdxTLGetNodeDragText = procedure(Sender: TObject; Node: TdxTreeListNode;
    Column: TdxTreeListColumn; var AText: string) of object;

  {TCustomdxTreeListControl}
  TCustomdxTreeListControl = class(TCustomdxTreeList)
  private
    FBands: TdxTreeListBands;
    FBandMaxRowCount: Integer;
    FBandRowCount: Integer;
    FColumns: TList;
    FDefaultLayout: Boolean;
    FDesigner: TdxTreeListDesigner;
    FEditors: TList;
    FHeaderMinRowCount: Integer;
    FHeaderPanelMaxRowCount: Integer;
    FHeaderPanelRowCount: Integer;
    FIniFileName: string;
    FIniSectionName: string;
    FLockSorting: Integer;
    FParentFormName: string;
    FRegistryPath: string;
    FSetAutoHeaderPanelRowCount: Boolean;
    FSortedColumns: TList;
    // customize layout
    FCustomStoring: Boolean;
    FSavedLayout: Boolean;
    FLoadedLayout: Boolean;

    // Events
    FOnGetImageIndex: TTLGetImageEvent;
    FOnGetSelectedIndex: TTLGetImageEvent;
    FOnGetStateIndex: TTLGetImageEvent;

    FOnCustomDrawBand: TdxTLCustomDrawBand;
    FOnCustomDrawColumnHeader: TdxTLCustomDrawHeader;
    FOnCustomDrawCell: TdxTLCustomDrawCell;
    FOnCustomDrawFooterNode: TdxTLCustomDrawFooterNode;
    FOnCustomDrawFooter: TdxTLCustomDrawFooter;
    FOnCustomDrawPreviewCell: TdxTLCustomDrawPreview;
    FOnGetLevelColor: TdxTLGetLevelColor;
    FOnIsExistFooterCell: TdxTLIsExistFooterCell;

    FOnChangedColumnsWidth: TNotifyEvent;
    FOnCanBandDragging: TdxTLCanBandDragging;
    FOnStartBandDragging: TdxTLStartBandDragging;
    FOnDragOverBand: TdxTLDragOverBand;
    FOnDragEndBand: TdxTLDragEndBand;
    FOnShowBand: TdxTLShowBand;
    FOnHideBand: TdxTLStartBandDragging;
    FOnBandClick: TdxTLStartBandDragging;
    FOnCanHeaderDragging: TdxTLCanHeaderDragging;
    FOnStartHeaderDragging: TdxTLStartHeaderDragging;
    FOnDragOverHeader: TdxTLDragOverHeader;
    FOnDragEndHeader: TdxTLDragEndHeader;
    FOnShowHeader: TdxTLShowHeader;
    FOnHideHeader: TdxTLStartHeaderDragging;
    FOnColumnClick: TTLColumnClick;
    FOnBandButtonClick: TNotifyEvent;
    FOnHeaderButtonClick: TNotifyEvent;
    FOnColumnSorting: TdxTreeListColumnSorting;
    FOnColumnSorted : TTLColumnSorted;
    FOnHeaderMoved: TdxTLHeaderMoved;

    // obsolete
    FOnColumnMoved: TTLColumnMovedEvent;
    FOnCustomDraw: TTLCustomDrawEvent;
    FOnCustomDrawPreview: TTLCustomDrawPreviewEvent;
    FOnEndDragColumn: TdxTLEndDragColumn;

    //new
    FOnCalcRowLineHeight: TdxTLCalcRowLineHeight;
    FOnGetNodeDragText: TdxTLGetNodeDragText;

    procedure AddColumn(Column: TdxTreeListColumn);
    function GetColumn(Index: Integer): TdxTreeListColumn;
    function GetColumnCount: Integer;
    function GetDefaultLayout: Boolean;
    function GetSortedColumns(Index: Integer): TdxTreeListColumn;
    function GetVisibleColumn(Index: Integer): TdxTreeListColumn;
    function GetVisibleColumnCount: Integer;
    function IsHeaderPanelRowCountStored: Boolean;
    procedure MakeDefaultLayout;
    procedure SetBands(Value: TdxTreeListBands);
    procedure SetBandMaxRowCount(Value: Integer);
    procedure SetBandRowCount(Value: Integer);
    procedure SetColumn(Index: Integer; Value: TdxTreeListColumn);
    procedure SetHeaderPanelMaxRowCount(Value: Integer);
    procedure SetHeaderPanelRowCount(Value: Integer);
    procedure SetHeaderRowCount(Value: Integer);
    procedure RefreshRowIndexes;
    procedure SetDefaultLayout(Value: Boolean);
    procedure SetVisibleColumn(Index: Integer; Value: TdxTreeListColumn);
    // messages
    procedure CMCursorChanged(var Message: TMessage); message CM_CURSORCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
  protected
    // speed
    FBandList: TList;
    FBandVisibleList: TList;
    FBandListLoading: Boolean;

    FHeaderAbsoluteList: TList;
    FHeaderListLoading: Boolean;

    FHeaderBounds: TList;
    FHeaderBoundsLoading: Boolean;

    FLockRefreshRowIndexes: Integer;
    // Bands (size)
    function GetAbsoluteBandAlignment(AbsoluteIndex: Integer): TAlignment; override;
    function GetAbsoluteBandCount: Integer; override;
    function GetAbsoluteBandIndex(VisibleIndex: Integer): Integer; override;
    function GetAbsoluteBandText(AbsoluteIndex: Integer): string; override;
    function GetAbsoluteBandWidth(AbsoluteIndex: Integer): Integer; override;
    function GetBandAlignment(VisibleIndex: Integer): TAlignment; override;
    function GetBandCount: Integer; override;
    function GetBandFixedLeft: Integer; override;
    function GetBandFixedRight: Integer; override;
    function GetBandMinWidthSize(VisibleIndex: Integer): Integer; override;
    function GetBandText(VisibleIndex: Integer): string; override;
    function GetBandSizeWidth(VisibleIndex: Integer): Integer; override;
    function GetVisibleBandIndex(AbsoluteIndex: Integer): Integer; override;
    function IsOwnBand(ABandIndex: Integer{VisibleIndex}): Boolean; override;

    // Headers (size)
    function GetColumnColor(AbsoluteIndex: Integer): TColor; override;
    function GetColumnFont(AbsoluteIndex: Integer): TFont; override;
    function GetHeaderAbsoluteCount: Integer; override;
    function GetHeaderAbsoluteIndex(BandIndex, RowIndex, ColIndex: Integer): Integer; override;
    function GetHeaderAlignment(AbsoluteIndex: Integer): TAlignment; override;
    function GetHeaderBandIndex(AbsoluteIndex: Integer): Integer; override;
    function GetHeaderBoundsWidth(AbsoluteIndex: Integer): Integer; override;
    function GetHeaderColCount(BandIndex, RowIndex: Integer): Integer; override;
    function GetHeaderColIndex(AbsoluteIndex: Integer): Integer; override;
    function GetHeaderDropDownButtonState(AbsoluteIndex: Integer): TdxHeaderDropDownButtonState; override;
    function GetHeaderGlyph(AbsoluteIndex: Integer): TBitmap; override;
    function GetHeaderMaxLineCount(AbsoluteIndex: Integer): Integer; override;
    function GetHeaderMaxRowHeight(ACanvas: TCanvas; AbsoluteIndex: Integer): Integer; override; // column (image)
    function GetHeaderMinWidth(AbsoluteIndex: Integer): Integer; override;
    function GetHeaderRowCount(BandIndex: Integer): Integer; override;
    function GetHeaderRowIndex(AbsoluteIndex: Integer): Integer; override;
    function GetHeaderSorted(AbsoluteIndex: Integer): TdxTreeListColumnSort; override;
    function GetHeaderTabStop(AbsoluteIndex: Integer): Boolean; override;
    function GetHeaderText(AbsoluteIndex: Integer): string; override;
    function GetHeaderTextListBox(AbsoluteIndex: Integer): string; override;
    function GetHeaderWidth(AbsoluteIndex: Integer): Integer; override;
    function IsExistColumnFont(AbsoluteIndex: Integer): Boolean; override;
    function IsExistHeaderGlyph(AbsoluteIndex: Integer): Boolean; override;

    // Cells
    function GetCellAlignment(Node: TdxTreeListNode; AbsoluteIndex: Integer): TAlignment; override;
    function GetCellText(Node: TdxTreeListNode; AbsoluteIndex: Integer): string; override;
    function IsCellMultiLine(AbsoluteIndex: Integer): Boolean; override;

    // Sizing, Clicking
    function CanBandSizing(VisibleIndex: Integer): Boolean; override;
    function CanHeaderSizing(AbsoluteIndex: Integer): Boolean; override;
    procedure ChangedBandRowCount(BandRowCount: Integer); override;
    procedure ChangedBandWidth(VisibleIndex, Width: Integer); override;
    procedure ChangedHeaderMaxRowCount(RowCount: Integer); override;
    procedure ChangedHeaderWidth(AbsoluteIndex, Width: Integer); override;
    procedure ChangeHiddenBandWidth(ScaleNum, ScaleDenom: Integer); override;
    procedure ChangeHiddenHeaderWidth(BandIndex: Integer; ScaleNum, ScaleDenom: Integer); override;
    function GetBandMaxRowCount: Integer; override;
    function GetBandRowCount: Integer; override;
    function GetHeaderMaxLimitRowCount: Integer; override;
    function GetHeaderMaxRowCount: Integer; override;
    function GetHeaderLineRowCount: Integer; override;
    procedure DoBandButtonClick; override;
    procedure DoBandClick(VisibleIndex: Integer); override;
    procedure DoBestFitBand(BandIndex: Integer); override;
    procedure DoBestFitColumn(AbsoluteIndex: Integer); override;
    procedure DoChangedColumnsWidth; override;
    procedure DoHeaderButtonClick; override;
    procedure DoHeaderClick(AbsoluteIndex: Integer); override;
    function IsBandHeaderWidth: Boolean; override;

    // DragDrop
    function GetNodeDragText(Node: TdxTreeListNode; AbsoluteIndex: Integer): string; override;

    // DragDrop Bands
    procedure BandMoved(FromIndex, ToIndex: Integer); override;
    function CanBandDragging(VisibleIndex: Integer): Boolean; override;
    procedure DoDragOverBand(P: TPoint; AbsoluteIndex: Integer; var Accept: Boolean); override;
    procedure DoEndDragBand(P: TPoint; AbsoluteIndex, VisibleIndex: Integer;
      var NewIndex: Integer; var Accept: Boolean); override;
    function GetBandDisableCustomizing(AbsoluteIndex: Integer): Boolean; override;
    procedure HideBand(AbsoluteIndex: Integer); override;
    function IsBandInListBox(AbsoluteIndex: Integer): Boolean; override;
    procedure ShowBand(NewIndex{visible index}, AbsoluteIndex: Integer); override;
    procedure StartDragBand(AbsoluteIndex: Integer); override;

    // DragDrop Headers
    function CanHeaderDragging(AbsoluteIndex: Integer): Boolean; override;
    procedure DoDragOverHeader(P: TPoint; AbsoluteIndex: Integer; var Accept: Boolean); override;
    procedure DoEndDragHeader(P: TPoint; AbsoluteIndex: Integer; var NewPosInfo: TdxHeaderPosInfo;
      var Accept: Boolean); override;
    function GetHeaderDisableCustomizing(AbsoluteIndex: Integer): Boolean; override;
    procedure HeaderMoved(FromAbsoluteIndex, ToBandIndex, ToRowIndex, ToColIndex: Integer); override;
    procedure HideHeader(AbsoluteIndex: Integer); override;
    function IsHeaderInListBox(AbsoluteIndex: Integer): Boolean; override;
    function IsHeaderVisible(AbsoluteIndex: Integer): Boolean; override;
    procedure ShowColumnHeader(BandIndex, RowIndex, ColIndex, AbsoluteIndex: Integer); override;
    procedure StartDragHeader(AbsoluteIndex: Integer); override;

    // Editor
    function CreateEditor(AColumn: Integer): TdxInplaceEdit; override;
    procedure DoBeforeEditing(Node : TdxTreeListNode; var AllowEditing: Boolean); override;
    procedure DoHotTrackNode(AHotTrackInfo: TdxTreeListHotTrackInfo; var ACursor: TCursor); override;
    function FindInplaceEdit(AColumn: Integer): TdxInplaceEdit; override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    function InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;

    // virtual
    procedure ClearBoundsInfo; override;
    procedure ClearListNodes; override;
    procedure ClearNodeRowHeight; override;
    function IsColumnHotTrack(X, Y: Integer; Node: TdxTreeListNode; ColumnAbsoluteIndex: Integer; var ActiveIndex: Integer): Boolean; override;
    function IsHeaderHotTrack(X, Y: Integer; ColumnAbsoluteIndex: Integer; var HeaderHotTrack: TdxTreeListHeaderHotTrack): Boolean; override;
    procedure MakeBandHeaderList(CalcBounds: Boolean); override;
    procedure MakeBoundsInfo; override;
    procedure MakeListNodes; override;
    procedure MoveNodeValues(FromIndex, ToIndex: Integer); virtual;
    function NeedShowButtonEdit(X, Y: Integer; IsCurrentNode: Boolean; ColumnAbsoluteIndex: Integer): Boolean; override;
    procedure ResetAutoHeaderPanelRowCountOption; virtual;
    procedure UpdateBands; virtual;
    procedure UpdateColumn(Column: TdxTreeListColumn); virtual;
    procedure UpdateHeaders; virtual;

    // Sorting
    procedure AddSortedColumn(Column: TdxTreeListColumn); virtual;
    function CanColumnSorting(Column: TdxTreeListColumn): Boolean; virtual;
    procedure DoColumnSort(Column: TdxTreeListColumn); virtual;
    procedure PrepareColumnSorted(Column: TdxTreeListColumn); virtual;
    procedure RefreshSortedList;
    procedure RemoveSortedColumn(Column: TdxTreeListColumn); virtual;
    procedure SetColumnSorted(Column: TdxTreeListColumn); virtual;

    // based
    procedure BeginCustomLayout; override;
    function CanEditModify: Boolean; override;
    function CreateNode: TdxTreeListNode; override;
    procedure DoRestoreLayout; override;
    procedure DoSaveLayout; override;
    function GetSortedColumnCount: Integer; override;
    function GetSortedColumnDesc(Index: Integer): Boolean; override;
    function GetSortedColumnIndex(Index: Integer): Integer; override;
    function GetNodeImageIndex(Node : TdxTreeListNode) : Integer; override;
    function GetNodeSelectedIndex(Node : TdxTreeListNode) : Integer; override;
    function GetNodeStateIndex(Node : TdxTreeListNode) : Integer; override;
    function GetNodeValue(Node : TdxTreeListNode; Column : Integer) : Variant; override;
    function GetNodeString(Node: TdxTreeListNode; Column: Integer): string; override;
    function LockSorting: Boolean;
    procedure RemoveColumn(Column: TdxTreeListColumn); virtual;
    procedure SetNodeImageIndex(Node : TdxTreeListNode; Value : Integer); override;
    procedure SetNodeSelectedIndex(Node : TdxTreeListNode; Value : Integer); override;
    procedure SetNodeStateIndex(Node : TdxTreeListNode; Value : Integer); override;
    procedure SetNodeString(Node: TdxTreeListNode; Column: Integer; const Value: string); override;
    procedure SetNodeValue(Node: TdxTreeListNode; Column: Integer; const Value: Variant); override;

    // Save/Load  
    procedure BeginReadSettings(ARegIniWrapper: TdxRegIniWrapper); virtual;
    procedure EndReadSettings(ARegIniWrapper: TdxRegIniWrapper); virtual;
    procedure LoadFromRegIni(ARegIniObject: TObject; APath: string);
    procedure ReadColumn(ARegIniWrapper: TdxRegIniWrapper; const APathCol: string; AColumn: TdxTreeListColumn); virtual;
    procedure ReadSettings(ARegIniWrapper: TdxRegIniWrapper; const APath: string); virtual;
    procedure SaveToRegIni(ARegIniObject: TObject; APath: string);
    procedure WriteColumn(ARegIniWrapper: TdxRegIniWrapper; const APathCol: string; AColumn: TdxTreeListColumn); virtual;
    procedure WriteSettings(ARegIniWrapper: TdxRegIniWrapper; const APath: string); virtual;

    // TComponent
    procedure GetChildren(Proc: TGetChildProc{$IFDEF DELPHI3}; Root: TComponent{$ENDIF}); override;
    procedure SetChildOrder(Component: TComponent; Order: Integer); override;
    procedure Loaded; override;
    procedure SetParent(AParent: TWinControl); override;

    // Draw
    function AssignedDrawBandEvent(VisibleIndex: Integer): Boolean; override;
    function AssignedDrawCellEvent(ANode: TdxTreeListNode; AbsoluteIndex: Integer): Boolean; override;
    function AssignedDrawFooterCellEvent(ANode: TdxTreeListNode; AbsoluteIndex, FooterIndex: Integer): Boolean; override;
    function AssignedDrawHeaderEvent(AbsoluteIndex: Integer): Boolean; override;
    function AssignedDrawPreviewEvent: Boolean; override;
    function AssignedLevelColorEvent: Boolean; override;

    procedure DoDrawBand(VisibleIndex: Integer; ACanvas: TCanvas; ARect, AClipRect: TRect; var AText: string;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment; var ADone: Boolean); override;
    procedure DoDrawCell(ACanvas: TCanvas; var ARect: TRect; ANode: TdxTreeListNode; AIndex: Integer; ASelected, AFocused: Boolean;
      ANewItemRow: Boolean; ALeftEdge, ARightEdge: Boolean; ABrush: HBRUSH;
      var AText: string; var AColor: TColor; AFont: TFont; var AAlignment: TAlignment; var ADone: Boolean); override;
    procedure DoDrawFooterCell(ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode; AIndex, AFooterIndex: Integer; var AText: string;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment; var ADone: Boolean); override;
    procedure DoDrawHeader(AbsoluteIndex: Integer; ACanvas: TCanvas; ARect, AClipRect: TRect; var AText: string;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment; var ASorted: TdxTreeListColumnSort; var ADone: Boolean); override;
    procedure DoDrawPreview(ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode; ASelected: Boolean;
      var AText: string; var AColor, ATextColor: TColor; AFont: TFont; var ADone: Boolean); override;
    procedure DoGetLevelColor(ALevel: Integer; var AColor: TColor); override;
    function IsExistFooterCell(AbsoluteIndex: Integer): Boolean; override;

    // TODO PAINT1
    procedure DefaultDrawCell(ADC: HDC; ARect: TRect; AAbsoluteIndex: Integer;
      ACellViewData: TdxTreeListCellViewData); override;
    procedure CalcCellViewBoundsRect(const ACellRect: TRect; var AViewRect: TRect); virtual;

    property IniFileName: string read FIniFileName write FIniFileName;
    property IniSectionName: string read FIniSectionName write FIniSectionName;
    property IsCustomStoring: Boolean read FCustomStoring write FCustomStoring;
    property LoadedLayout: Boolean read FLoadedLayout write FLoadedLayout;
    property RegistryPath: string read FRegistryPath write FRegistryPath;
    // Events
    property OnGetImageIndex: TTLGetImageEvent read FOnGetImageIndex write FOnGetImageIndex;
    property OnGetSelectedIndex: TTLGetImageEvent read FOnGetSelectedIndex write FOnGetSelectedIndex;
    property OnGetStateIndex: TTLGetImageEvent read FOnGetStateIndex write FOnGetStateIndex;

    property OnCustomDrawBand: TdxTLCustomDrawBand read FOnCustomDrawBand write FOnCustomDrawBand;
    property OnCustomDrawColumnHeader: TdxTLCustomDrawHeader read FOnCustomDrawColumnHeader write FOnCustomDrawColumnHeader;
    property OnCustomDrawCell: TdxTLCustomDrawCell read FOnCustomDrawCell write FOnCustomDrawCell;
    property OnCustomDrawFooterNode: TdxTLCustomDrawFooterNode read FOnCustomDrawFooterNode write FOnCustomDrawFooterNode;
    property OnCustomDrawFooter: TdxTLCustomDrawFooter read FOnCustomDrawFooter write FOnCustomDrawFooter;
    property OnCustomDrawPreviewCell: TdxTLCustomDrawPreview read FOnCustomDrawPreviewCell write FOnCustomDrawPreviewCell;
    property OnGetLevelColor: TdxTLGetLevelColor read FOnGetLevelColor write FOnGetLevelColor;
    property OnIsExistFooterCell: TdxTLIsExistFooterCell read FOnIsExistFooterCell write FOnIsExistFooterCell;

    property OnCanBandDragging: TdxTLCanBandDragging read FOnCanBandDragging write FOnCanBandDragging;
    property OnChangedColumnsWidth: TNotifyEvent read FOnChangedColumnsWidth write FOnChangedColumnsWidth;
    property OnStartBandDragging: TdxTLStartBandDragging read FOnStartBandDragging write FOnStartBandDragging;
    property OnDragOverBand: TdxTLDragOverBand read FOnDragOverBand write FOnDragOverBand;
    property OnDragEndBand: TdxTLDragEndBand read FOnDragEndBand write FOnDragEndBand;
    property OnShowBand: TdxTLShowBand read FOnShowBand write FOnShowBand;
    property OnHideBand: TdxTLStartBandDragging read FOnHideBand write FOnHideBand;
    property OnBandClick: TdxTLStartBandDragging read FOnBandClick write FOnBandClick;
    property OnCanHeaderDragging: TdxTLCanHeaderDragging read FOnCanHeaderDragging write FOnCanHeaderDragging;
    property OnStartHeaderDragging: TdxTLStartHeaderDragging read FOnStartHeaderDragging write FOnStartHeaderDragging;
    property OnDragOverHeader: TdxTLDragOverHeader read FOnDragOverHeader write FOnDragOverHeader;
    property OnDragEndHeader: TdxTLDragEndHeader read FOnDragEndHeader write FOnDragEndHeader;
    property OnShowHeader: TdxTLShowHeader read FOnShowHeader write FOnShowHeader;
    property OnHideHeader: TdxTLStartHeaderDragging read FOnHideHeader write FOnHideHeader;
    property OnColumnClick: TTLColumnClick read FOnColumnClick write FOnColumnClick;
    property OnBandButtonClick: TNotifyEvent read FOnBandButtonClick write FOnBandButtonClick;
    property OnHeaderButtonClick: TNotifyEvent read FOnHeaderButtonClick write FOnHeaderButtonClick;
    property OnColumnSorting: TdxTreeListColumnSorting read FOnColumnSorting write FOnColumnSorting;
    property OnColumnSorted: TTLColumnSorted read FOnColumnSorted write FOnColumnSorted;
    property OnHeaderMoved: TdxTLHeaderMoved read FOnHeaderMoved write FOnHeaderMoved;
    // obsolete
    property OnColumnMoved: TTLColumnMovedEvent read FOnColumnMoved write FOnColumnMoved;
    property OnCustomDraw: TTLCustomDrawEvent read FOnCustomDraw write FOnCustomDraw;
    property OnCustomDrawPreview: TTLCustomDrawPreviewEvent read FOnCustomDrawPreview write FOnCustomDrawPreview;
    property OnEndDragColumn: TdxTLEndDragColumn read FOnEndDragColumn write FOnEndDragColumn;
    // new
    property OnCalcRowLineHeight: TdxTLCalcRowLineHeight read FOnCalcRowLineHeight write FOnCalcRowLineHeight;
    property OnGetNodeDragText: TdxTLGetNodeDragText read FOnGetNodeDragText write FOnGetNodeDragText;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    procedure ApplyBestFit(AColumn: TdxTreeListColumn); virtual; // nil - all columns
    procedure AssignColumns(ATreeListControl: TCustomdxTreeListControl); virtual;
    function ColumnByName(const AName: string): TdxTreeListColumn;
    function CreateColumn(ColumnClass: TdxTreeListColumnClass): TdxTreeListColumn;
    function CreateColumnEx(ColumnClass: TdxTreeListColumnClass; AOwner: TComponent): TdxTreeListColumn;
    procedure DestroyColumns; virtual;
    function GetAbsoluteColumnIndex(VisibleIndex: Integer): Integer;
    function GetDisplayValue(Node: TdxTreeListNode; AbsoluteIndex: Integer): string;
    function GetVisibleColumnIndex(AbsoluteIndex: Integer): Integer;
    procedure RefreshDefaultColumnsWidths;
    procedure RestoreColumnsDefaults;
    // hit test functions
    function GetBandAt(X, Y: Integer): TdxTreeListBand;
    function GetColumnAt(X, Y: Integer): TdxTreeListColumn;
    function GetFooterColumnAt(X, Y: Integer): TdxTreeListColumn;
    function GetHeaderColumnAt(X, Y: Integer): TdxTreeListColumn;
    function GetNodeFooterColumnAt(X, Y: Integer): TdxTreeListColumn;
    // multi sort
    procedure BeginSorting;
    procedure ClearColumnsSorted; override;
    procedure EndSorting;
    procedure RefreshSorting; virtual;
    // multi headers
    procedure HeaderPanelBestFit; override;
    // new
    function ColumnCalcLineCount(ANode: TdxTreeListNode; AbsoluteIndex: Integer; const Text: string;
      BoundsWidth, TextHeight, MaxLineCount: Integer; InflateFlag{obsolete}, GridFlag{obsolete}: Boolean;
      var LineCount, LineHeight: Integer): Boolean; override;
    // Save/Restore Layout
    procedure LoadFromIniFile(const AFileName: string);
    procedure LoadFromRegistry(const ARegPath: string);
    procedure SaveToIniFile(const AFileName: string);
    procedure SaveToRegistry(const ARegPath: string);

    property ColumnCount: Integer read GetColumnCount;
    property Columns[Index: Integer]: TdxTreeListColumn read GetColumn write SetColumn;
    property Designer: TdxTreeListDesigner read FDesigner;
    property SortedColumnCount: Integer read GetSortedColumnCount;
    property SortedColumns[Index: Integer]: TdxTreeListColumn read GetSortedColumns;
    property VisibleColumnCount: Integer read GetVisibleColumnCount;
    property VisibleColumns[Index: Integer]: TdxTreeListColumn read GetVisibleColumn write SetVisibleColumn;

    property FocusedAbsoluteIndex;
    property FocusedColumn;
    property LeftCoord;
    property OnGetEditColor;
  published
    property BandMaxRowCount: Integer read FBandMaxRowCount write SetBandMaxRowCount default 5;
    property BandRowCount: Integer read FBandRowCount write SetBandRowCount default 1;
    property Bands: TdxTreeListBands read FBands write SetBands;
    property DefaultLayout: Boolean read GetDefaultLayout write SetDefaultLayout{ default True};
    property HeaderMinRowCount: Integer read FHeaderMinRowCount write SetHeaderRowCount default 1;
    property HeaderPanelMaxRowCount: Integer read FHeaderPanelMaxRowCount write SetHeaderPanelMaxRowCount default 5;
    property HeaderPanelRowCount: Integer read FHeaderPanelRowCount write SetHeaderPanelRowCount
      stored IsHeaderPanelRowCountStored{default 1};
  end;

  {TdxTreeListDesigner}
  TdxTreeListDesigner = class
  private
    FTreeList: TCustomdxTreeListControl;
  public
    constructor Create(ATreeList: TCustomdxTreeListControl);
    destructor Destroy; override;
    procedure LayoutChanged; virtual;
    property TreeList: TCustomdxTreeListControl read FTreeList;
  end;

  {TdxTreeList}
  TdxTreeList = class(TCustomdxTreeListControl)
  private
    FNeededSortRefresh: Boolean;
    FSelectedNodes: TList;
    FStreamVersion: Integer;
    // Events
    FOnGetFooterCellText: TdxTLGetFooterCellText;
    FOnGetPreviewLineCount: TdxTLGetPreviewLineCount;
    FOnGetPreviewText: TdxTLGetPreviewText;
    FOnGetRowLineCount: TdxTLGetPreviewLineCount;
    FOnIsExistRowFooterCell: TdxTLIsExistRowFooterCell;
    FOnIsLevelFooter: TdxTLIsLevelFooter;
    procedure CheckRefreshSorting;
    function GetSortedColumn: TdxTreeListColumn;
    function FindSelectedNode(Node: TdxTreeListNode; var Index: Integer): Boolean;
    procedure ReadData(Stream: TStream);
    procedure WriteData(Stream: TStream);
  protected
    // override TComponent
    procedure DefineProperties(Filer: TFiler); override;
    // Rows
    function GetPreviewText(Node: TdxTreeListNode): string; override;
    function GetRowIndicatorKind(Node: TdxTreeListNode; ASelected: Boolean): TdxGridIndicatorKind; override;
    function GetRowLineCount(Node: TdxTreeListNode; var LineHeight: Integer): Integer; override;
    function GetRowPreviewLineCount(Node: TdxTreeListNode): Integer; override;
    // Footer
    function GetFooterCellText(Node: TdxTreeListNode; AbsoluteIndex, FooterIndex: Integer): string; override;
    function IsExistRowFooterCell(Node: TdxTreeListNode; AbsoluteIndex, FooterIndex: Integer): Boolean; override;
    function IsLevelFooter(Level: Integer): Boolean; override;
    // based
    procedure AddNode(Node: TdxTreeListNode); override;
    procedure BeginCustomLayout; override;
    procedure DeleteNode(Node, Prior, Next: TdxTreeListNode; IsLast, Redraw: Boolean); override;
    function GetNodeVariant(Node: TdxTreeListNode; Column: Integer) : Variant; override;
    procedure PrepareColumnSorted(Column: TdxTreeListColumn); override;
    procedure SetColumnSorted(Column: TdxTreeListColumn); override;
    procedure SetNodeString(Node: TdxTreeListNode; Column: Integer; const Value: string); override;
    //Editor
    function AssignEditValue(ANode: TdxTreeListNode; AColumn: Integer; AInplaceEdit: TdxInplaceEdit): Variant; override;
    //Selected
    function GetSelectedCount: Integer; override;
    function GetSelectedItem(AIndex: Integer): TdxTreeListNode; override;
    function IsNodeSelected(ANode: TdxTreeListNode): Boolean; override;
    procedure NodeSelected(ANode: TdxTreeListNode; ASelected: Boolean); override;
    procedure SelectNodes(N1, N2: TdxTreeListNode); override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure AssignNodes(Source: TPersistent);
    procedure ClearColumnsSorted; override;
    procedure ClearSelection; override;
    procedure DeleteSelection; override;
    procedure LoadFromFile(const FileName: string);
    procedure LoadFromStream(Stream: TStream);
    procedure RefreshSorting; override;
    procedure SaveToFile(const FileName: string);
    procedure SaveToStream(Stream: TStream);
    procedure SelectAll;

    property DragNode;
    property EditingText;
    property FocusedColumn;
    property FocusedNumber;
    property HotTrackInfo;
    property RowCount;
    property SelectedCount;
    property SelectedNodes;
    property SortedColumn: TdxTreeListColumn read GetSortedColumn;
    property TopIndex;
    property VisibleRowCount;
  published
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

    property ArrowsColor;
    property AutoExpandOnSearch;
    property AutoSearchColor;
    property AutoSearchTextColor;
    property DblClkExpanding;

    property GroupNodeColor;
    property GroupNodeTextColor;

    property RowFooterColor;
    property RowFooterTextColor;
    property HeaderColor;
    property BandColor;
    property BandFont;
    property HeaderFont;
    property HideFocusRect;
    property HideSelection;
    property Images;
    property IndentDesc;
    property IniFileName;
    property IniSectionName;
    property RegistryPath;
    property FixedBandLineColor;
    property FixedBandLineWidth;
    property LookAndFeel;
    property MaxRowLineCount;
    property Options;
    property OptionsEx;
    property PaintStyle;
    property StateImages;
    property DefaultRowHeight;
    property RowSeparatorLineWidth;
    property PreviewLines;
    property PreviewFont;
    property HighlightColor;
    property HighlightTextColor;
    property TreeLineColor;
    property TreeLineStyle;
    property HideSelectionColor;
    property HideSelectionTextColor;
    property WaitForExpandNodeTime;
    property ScrollBars;
    property CustomizingRowCount;

    property ShowBands;
    property ShowButtons;
    property ShowGrid;
    property ShowPreviewGrid;
    property ShowHeader;
    property ShowLines;
    property ShowRoot;
    property ShowRowFooter;
    property SimpleCustomizeBox;
    property ShowHiddenInCustomizeBox;
    property ShowIndicator;
    property ShowFooter;
    property GridLineColor;

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

    property OnGetImageIndex;
    property OnGetSelectedIndex;
    property OnGetStateIndex;

    property OnCustomDrawBand;
    property OnCustomDrawColumnHeader;
    property OnCustomDrawCell;
    property OnCustomDrawFooterNode;
    property OnCustomDrawFooter;
    property OnCustomDrawPreviewCell;
    property OnGetLevelColor;

    property OnChangedColumnsWidth;
    property OnCanBandDragging;
    property OnStartBandDragging;
    property OnDragOverBand;
    property OnDragEndBand;
    property OnShowBand;
    property OnHideBand;
    property OnBandClick;
    property OnCanHeaderDragging;
    property OnStartHeaderDragging;
    property OnDragOverHeader;
    property OnDragEndHeader;
    property OnShowHeader;
    property OnHideHeader;
    property OnColumnClick;
    property OnBandButtonClick;
    property OnHeaderButtonClick;
    property OnColumnSorting;
    property OnColumnSorted;
    property OnHeaderMoved;
    // obsolete
    property OnColumnMoved;
    property OnCustomDraw;
    property OnCustomDrawPreview;
    property OnEndDragColumn;
    // new
    property OnCalcRowLineHeight;
    property OnGetNodeDragText;

    property OnBeginDragNode;
    property OnCanNodeSelected;
    property OnChangeColumn;
    property OnChangeLeftCoord;
    property OnChangeNode;
    property OnChangeTopVisibleNode;
    property OnCollapsed;
    property OnCollapsing;
    property OnCompare;
    property OnDeletion;
    property OnEditChange;
    property OnEdited;
    property OnEditing;
    property OnEditValidate;
    property OnEndColumnsCustomizing;
    property OnExpanded;
    property OnExpanding;
    property OnGetEditColor;
    property OnGetFooterCellText: TdxTLGetFooterCellText read FOnGetFooterCellText write FOnGetFooterCellText;
    property OnGetPreviewLineCount: TdxTLGetPreviewLineCount read FOnGetPreviewLineCount write FOnGetPreviewLineCount;
    property OnGetPreviewText: TdxTLGetPreviewText read FOnGetPreviewText write FOnGetPreviewText;
    property OnGetRowLineCount: TdxTLGetPreviewLineCount read FOnGetRowLineCount write FOnGetRowLineCount;
    property OnHotTrackNode;
    property OnIsExistRowFooterCell: TdxTLIsExistRowFooterCell read FOnIsExistRowFooterCell write FOnIsExistRowFooterCell;
    property OnIsExistFooterCell;
    property OnIsLevelFooter: TdxTLIsLevelFooter read FOnIsLevelFooter write FOnIsLevelFooter;
    property OnSelectedCountChange;

    {$IFDEF DELPHI4}
    property Anchors;
    property Constraints;
    {$ENDIF}
    {$IFDEF DELPHI5}
    property OnContextPopup;
    {$ENDIF}
  end;

// TODO ***
  { TdxTreeListEditStyle }
  TdxTreeListEditStyle = class(TdxEditStyle)
  private
    FTreeList: TCustomdxTreeList;
  protected
    property TreeList: TCustomdxTreeList read FTreeList;
  public
    constructor Create(AEdit: TdxInplaceEdit; ATreeList: TCustomdxTreeList);
    function DefaultBorderColor: TColor; override;
    function DefaultBorderStyle: TdxEditBorderStyle; override;
    function DefaultButtonStyle: TdxEditButtonViewStyle; override;
    function DefaultButtonTransparence: TdxEditButtonTransparence; override;
    function DefaultEdges: TdxEditEdges; override;
    function DefaultHotTrack: Boolean; override;
    function DefaultShadow: Boolean; override;
  end;

  { TdxTreeListMaskColumn }
  TdxInplaceTreeListMaskEdit = class(TdxInplaceMaskEdit)
  end;
  
  TdxTreeListMaskColumn = class(TdxTreeListColumn)
  private
    FEditMask: string;
    FIgnoreMaskBlank: Boolean;
  protected
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; override;
  published
    property EditMask: string read FEditMask write FEditMask;
    property IgnoreMaskBlank: Boolean read FIgnoreMaskBlank write FIgnoreMaskBlank default False;
  end;

const
  NodeHitTests: TdxTreeListHitTests = [htIcon, htStateIcon, htLabel, htSummaryNodeFooter,
    htPreview, htNewRowItem];
  RowHitTests: TdxTreeListHitTests = [htButton, htIcon, htStateIcon, htIndent, htLabel, htRight,
    htSummaryNodeFooter, htPreview];
  DragExpandHitTests: TdxTreeListHitTests = [htButton];
  HotTrackHitTests: TdxTreeListHitTests = [htIcon, htStateIcon, htLabel, htNewRowItem];

var
  sdxGrColumns: string;         // 'Customize'
  sdxGrBandsCaption: string;    // '    Bands    '
  sdxGrHeadersCaption: string;  // '   Headers   '

function VarCompare(const V1, V2: Variant): Integer;

procedure DrawButton(ACanvas: TCanvas; ARect: TRect; YCenter: Integer; IsPlus: Boolean);
procedure DrawOutButton(ACanvas: TCanvas; ARect: TRect; IsPlus: Boolean);
procedure DrawUltraFlatButton(ADC: HDC; ARect: TRect; AIsPlus: Boolean);
procedure DrawSortedShape(DC: HDC; ARect: TRect; IsUp: Boolean); {min width rect -> dxGridSortedShapeMinWidth}
procedure DrawBandButton(DC: HDC; var ARect: TRect; ABrush: HBRUSH;
  ADown: Boolean; AStyle: TdxHeaderButtonStyle; ALookAndFeel: TdxLookAndFeel);
procedure DrawBandButtonEx(DC: HDC; var ARect: TRect; ABrush: HBRUSH;
  ADown: Boolean; AStyle: TdxHeaderButtonStyle; ALookAndFeel: TdxLookAndFeel);
procedure DrawFlatButton(ADC: HDC; ARect: TRect; ADropDownButtonState: TdxHeaderDropDownButtonState);
procedure DrawBand(DC: HDC; ARect: TRect; ABrush: HBRUSH;
  const AText: string; ADown: Boolean;
  AMultiLine: Boolean; AAlignment: TAlignment;
  ASorted: TdxTreeListColumnSort; AGlyph: TBitmap; AStyle: TdxHeaderButtonStyle;
  ALookAndFeel: TdxLookAndFeel;
  ADropDownButtonState: TdxHeaderDropDownButtonState);
procedure DrawUltraBandButton(ADC: HDC; var ARect: TRect; ABrush: HBRUSH);
procedure DrawIndicatorEx(DC: HDC; ARect, AClipRect: TRect; ABrush: HBRUSH;
  ABitmap: TBitmap; AKind: TdxGridIndicatorKind; ALookAndFeel: TdxLookAndFeel);
procedure DrawFocused(DC: HDC; R: TRect);
procedure DrawFramed(DC: HDC; const R: TRect);

procedure DrawBandEx(DC: HDC; ARect, AClipRect: TRect; ABrush: HBRUSH; ABitmap: TBitmap;
  const AText: string; ADown: Boolean; AMultiLine: Boolean; AAlignment: TAlignment;
  ASorted: TdxTreeListColumnSort; AGlyph: TBitmap; AStyle: TdxHeaderButtonStyle;
  ALookAndFeel: TdxLookAndFeel;
  ADropDownButtonState: TdxHeaderDropDownButtonState);
procedure InvaliddxTreeListOperation(const Id: string);
procedure WriteImage(ACanvas: TCanvas; ARect: TRect; ImageList: TImageList; Index: Integer);
procedure WriteBmp(ACanvas: TCanvas; ARect: TRect; ABitmap: TBitmap);

// row auto height
function GetTextLineCount(const S: string; BoundsWidth, TextHeight, MaxLineCount: Integer;
  Font: HFONT; InflateFlag, GridFlag: Boolean; var LineHeight: Integer): Integer;

// multi select
function CompareByAbsoluteIndex(Node1, Node2: TdxTreeListNode): Integer;
function CompareNodes(Item1, Item2: Pointer): Integer;

function IsEqualText(const S1, S2: string): Boolean;

implementation

uses
  Registry, IniFiles;

{$R dxTL.Res}

type
  PIntArray = ^TIntArray;
  TIntArray = array[0..MaxListSize] of Integer;

  PdxNodeInfo = ^TdxNodeInfo;
  TdxNodeInfo = record
    Node: TdxTreeListNode;
    Index: Integer;
  end;

  PNextVariant = ^TNextVariant;

  PNodeVariant = ^TNodeVariant;
  TNodeVariant = record
    Node: TdxTreeListNode;
    Value: Variant;
    Desc: Boolean;
    PNext: PNextVariant;
  end;

  TNextVariant = TNodeVariant;

  { sizing band/header width}
  TSizingInfo = record
    AIndex: Integer;
    Width: Integer;
  end;
  PSizingInfoArray = ^TSizingInfoArray;
  TSizingInfoArray = array [0..dxGridMaxDrawItems - 1] of TSizingInfo;


const
  bmArrow      = 'DXGRID_ARROW';
  bmEdit       = 'DXGRID_EDIT';
  bmInsert     = 'DXGRID_INSERT';
  bmMultiDot   = 'DXGRID_MULTIDOT';
  bmMultiArrow = 'DXGRID_MULTIARROW';

  SaveArrowsBitmap : TBitmap = nil;
  OutButtonPlus    : TBitmap = nil;
  OutButtonMinus   : TBitmap = nil;
  dxIndicatorImages: TImageList = nil;

const
  ShowHintTimerId     = 110;
  HideHintTimerId     = 111;
  WaitForShowHintTime = 1000;
  WaitForHideHintTime = 5000;

var
  ClickTimerID: Integer;
  ScrollTimerID: Integer;
  ScrollTimerLeftFlag: Boolean;
  ScrollNodeTimerID: Integer;
  ScrollNodeTimerTopFlag: Boolean;
  TempDC: HDC; // temporal DC for calc line count

{$IFNDEF DELPHI6}
function VarCompare(const V1, V2: Variant): Integer;
begin
  if not VarIsEmpty(V1) and not VarIsEmpty(V2) then
  try
    if V1 = V2 then
      Result := 0
    else
      if V1 < V2 then
        Result := -1
      else
        Result := 1;
  except
    on EVariantError do
      Result := -1;
  end
  else
    Result := -1;
end;
{$ELSE}
function VarCompare(const V1, V2: Variant): Integer;
begin
  try
    if V1 = V2 then
      Result := 0
    else
      if VarIsNull(V1) then
        Result := -1
      else
        if VarIsNull(V2) then
          Result := 1
        else
          if V1 < V2 then
            Result := -1
          else
            Result := 1;
  except
    on EVariantError do
      Result := -1;
  end
end;
{$ENDIF}

function CompareByAbsoluteIndex(Node1, Node2: TdxTreeListNode): Integer;
begin
  if Node1.HasAsParent(Node2) then
    Result := 1
  else
  if Node2.HasAsParent(Node1) then
    Result := -1
  else
  begin
    while Node1.Level > Node2.Level do Node1 := Node1.Parent;
    while Node2.Level > Node1.Level do Node2 := Node2.Parent;
    while Node1.Parent <> Node2.Parent do
    begin
      Node1 := Node1.Parent;
      Node2 := Node2.Parent;
    end;
    Result := (Node1.Index - Node2.Index);
  end;
end;

function CompareNodes(Item1, Item2: Pointer): Integer;
begin
  Result := Integer(Item1) - Integer(Item2);
end;

procedure CreateBitmaps;
var
  Bmp: TBitmap;
begin
  SaveArrowsBitmap := TBitmap.Create;
  OutButtonPlus := TBitmap.Create;
  OutButtonMinus := TBitmap.Create;
  // indicator
  Bmp := TBitmap.Create;
  try
    Bmp.LoadFromResourceName(HInstance, bmArrow);
    dxIndicatorImages := TImageList.CreateSize(Bmp.Width, Bmp.Height);
    dxIndicatorImages.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmEdit);
    dxIndicatorImages.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmInsert);
    dxIndicatorImages.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmMultiDot);
    dxIndicatorImages.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmMultiArrow);
    dxIndicatorImages.AddMasked(Bmp, clWhite);
  finally
    Bmp.Free;
  end;
end;

procedure DestroyBitmaps;
begin
  if dxIndicatorImages <> nil then dxIndicatorImages.Free;
  dxIndicatorImages := nil;
  if SaveArrowsBitmap <> nil then SaveArrowsBitmap.Free;
  if OutButtonPlus <> nil then OutButtonPlus.Free;
  if OutButtonMinus <> nil then OutButtonMinus.Free;
  SaveArrowsBitmap := nil;
  OutButtonPlus := nil;
  OutButtonMinus := nil;
end;

function GetTextLineCount(const S: string; BoundsWidth, TextHeight, MaxLineCount: Integer;
  Font: HFONT; InflateFlag, GridFlag: Boolean; var LineHeight: Integer): Integer;
var
  L: Integer;
  R: TRect;
  PrevFont: HFONT;
  TextYOffset: Integer;
  SizeText: TSize;
begin
  Result := 0;
  L := Length(S);
  if (L > 0) and (MaxLineCount <> 0) then
  begin
    R := Bounds(0, 0, BoundsWidth - Byte(GridFlag), TextHeight);
    if InflateFlag then TextYOffset := 2
    else TextYOffset := 1;
    InflateRect(R, -2{TextXOffset}, -TextYOffset);
    PrevFont := SelectObject(TempDC, Font);

    LineHeight := DrawText(TempDC, PChar(S), L, R,
      DT_LEFT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX or DT_CALCRECT);

    if TextHeight <> 0 then
      Result := LineHeight div TextHeight
    else
    begin
      GetTextExtentPoint(TempDC, 'Wg', Length('Wg'), SizeText);
      Result := LineHeight div SizeText.cy;
    end;

    SelectObject(TempDC, PrevFont);
    if (MaxLineCount <> -1) and (Result > MaxLineCount) then
    begin
      Result := MaxLineCount;
      if TextHeight <> 0 then LineHeight := Result * TextHeight
      else LineHeight := Result * SizeText.cy;
    end;
    
    LineHeight := TCustomdxTreeList.CalcTextRowHeight(LineHeight);
  end;
end;

function IsRectEmptyEx(const R: TRect): Boolean;
begin
  Result := (R.Left = R.Right) and (R.Top = R.Bottom);
end;

function Max(X, Y: Integer): Integer;
begin
  Result := Y;
  if X > Y then Result := X;
end;

procedure ScrollTimerProc(Wnd: HWND; Msg, TimerID, SysTime: Longint); stdcall;
var
  TreeList: TCustomdxTreeList;
begin
  TreeList := TCustomdxTreeList(FindControl(Wnd));
  if TreeList <> nil then
  with TreeList do
  begin
    if ((State in [tsColumnDragging, tsNodeDragging, tsBandDragging]) or
        (TreeList.FDragObject <> nil)) and
     ((ScrollTimerLeftFlag and (LeftCoord > 0)) or
      (not ScrollTimerLeftFlag and (LeftCoord < (GetScrollableBandWidth - GetScrollableWidth)))) then
    begin
      if ScrollTimerLeftFlag then
        LeftCoord := LeftCoord - 32{8}
      else LeftCoord := LeftCoord + 32{8};
      {new modification}
      UpdateDragging;
    end
    else
    begin
      KillTimer(Handle, ScrollTimerID);
      ScrollTimerID := -1;
    end;
  end;
end;

procedure ScrollNodeTimerProc(Wnd: HWnd; Msg, TimerID, SysTime: Longint); stdcall;
var
  TreeList : TCustomdxTreeList;
  P: TPoint;
begin
  TreeList := TCustomdxTreeList(FindControl(wnd));
  if (TreeList.State in [tsNodeDragging]) or
    (TreeList.FDragObject <> nil) then
  begin
    GetCursorPos(P);
    if WindowFromPoint(P) = TreeList.Handle then
      if ScrollNodeTimerTopFlag then
        TreeList.FocusedNumber := TreeList.FocusedNumber - 1
      else
        TreeList.FocusedNumber := TreeList.FocusedNumber + 1;
    {new modification}
    TreeList.UpdateDragging;
  end
  else
  begin
    KillTimer(TreeList.Handle, ScrollNodeTimerID);
    ScrollNodeTimerID := -1;
  end;
end;

procedure MouseScrollTimerProc(Wnd: HWnd; Msg, TimerID, SysTime: Longint); stdcall;
var
  TreeList : TCustomdxTreeList;
begin
  TreeList := TCustomdxTreeList(FindControl(wnd));
  if (TreeList.State in [tsNodeDown]) then
  begin
    if ScrollNodeTimerTopFlag then
      TreeList.FocusedNumber := TreeList.FocusedNumber - 1
    else TreeList.FocusedNumber := TreeList.FocusedNumber + 1;
  end
  else
  begin
    KillTimer(TreeList.Handle, ScrollNodeTimerID);
    ScrollNodeTimerID := -1;
  end;
end;

procedure WriteImage(ACanvas: TCanvas; ARect: TRect; ImageList : TImageList; Index : Integer);
begin
  if (ImageList = nil) or (Index >= ImageList.Count) or (Index < 0) then Exit;
  ImageList.Draw(ACanvas, (ARect.Left + ARect.Right - ImageList.Width + 1) div 2,
    (ARect.Top + ARect.Bottom - ImageList.Height + 1) div 2, Index);
end;

procedure WriteBmp(ACanvas: TCanvas; ARect: TRect; ABitmap: TBitmap);
begin
  if ABitmap <> nil then
    ACanvas.Draw((ARect.Left + ARect.Right - ABitmap.Width + 1) div 2,
      (ARect.Top + ARect.Bottom - ABitmap.Height + 1) div 2, ABitmap);
end;

function CustomCompareNodes(Item1, Item2: Pointer): Integer;
begin
  Result := 0;
  with PNodeVariant(Item1)^.Node do
  begin
    Owner.OnCompare(Owner, PNodeVariant(Item1)^.Node, PNodeVariant(Item2)^.Node, Result);
    if Result = 0 then
      Result := Owner.CompareEqual(PNodeVariant(Item1)^.Node, PNodeVariant(Item2)^.Node);
  end;  
end;

function CompareItems(Item1, Item2: Pointer): Integer;
begin
  Result := Integer(PdxNodeInfo(Item1)^.Node) - Integer(PdxNodeInfo(Item2)^.Node);
end;

//  multi sorting

function CompareNextVariantValues(PNext1, PNext2: PNextVariant): Integer;
begin
  if PNext1 = nil then
    Result := 0
  else
  begin
    if PNext1^.Value = PNext2^.Value then
      Result := CompareNextVariantValues(PNext1^.PNext, PNext2^.PNext)
    else
    begin
      {$IFNDEF DELPHI6}
      if PNext1^.Value < PNext2^.Value then
        Result := -1
      else Result := 1;
      {$ELSE}
      Result := VarCompare(PNext1^.Value, PNext2^.Value);
      {$ENDIF}
      if PNext1^.Desc then Result := - Result;
    end;
  end;
end;

function CompareVariantValues(Item1, Item2: Pointer): Integer;
begin
  if PNodeVariant(Item1)^.Value = PNodeVariant(Item2)^.Value then
  begin
    Result := CompareNextVariantValues(PNodeVariant(Item1)^.PNext, PNodeVariant(Item2)^.PNext);
    if Result = 0 then
      Result := PNodeVariant(Item1)^.Node.FOwner.CompareEqual(PNodeVariant(Item1)^.Node, PNodeVariant(Item2)^.Node);
  end
  else
  begin
    {$IFNDEF DELPHI6}
    if PNodeVariant(Item1)^.Value < PNodeVariant(Item2)^.Value then
      Result := -1
    else Result := 1;
    {$ELSE}
    Result := VarCompare(PNodeVariant(Item1)^.Value, PNodeVariant(Item2)^.Value);
    {$ENDIF}
    if PNodeVariant(Item1)^.Desc then Result := - Result;
  end;
end;

function CompareNextAnsiVariantValues(PNext1, PNext2: PNextVariant): Integer;
begin
  if PNext1 = nil then
    Result := 0
  else
  begin
    if PNext1^.Value = PNext2^.Value then
      Result := CompareNextAnsiVariantValues(PNext1^.PNext, PNext2^.PNext)
    else
    begin
      if PNext1^.Node.FOwner.IsAnsiSort and (VarType(PNext1^.Value) = varString) then
        Result := AnsiCompareStr(PNext1^.Value, PNext2^.Value)
      else
      {$IFNDEF DELPHI6}
      if PNext1^.Value < PNext2^.Value then
        Result := -1
      else Result := 1;
      {$ELSE}
      Result := VarCompare(PNext1^.Value, PNext2^.Value);
      {$ENDIF}
      if PNext1^.Desc then Result := - Result;
    end;
  end;
end;

function CompareAnsiVariantValues(Item1, Item2: Pointer): Integer;
begin
  if PNodeVariant(Item1)^.Value = PNodeVariant(Item2)^.Value then
  begin
    Result := CompareNextAnsiVariantValues(PNodeVariant(Item1)^.PNext, PNodeVariant(Item2)^.PNext);
    if Result = 0 then
      Result := PNodeVariant(Item1)^.Node.FOwner.CompareEqual(PNodeVariant(Item1)^.Node, PNodeVariant(Item2)^.Node);
  end
  else
  begin
    if PNodeVariant(Item1)^.Node.FOwner.IsAnsiSort and (VarType(PNodeVariant(Item1)^.Value) = varString) then
      Result := AnsiCompareStr(PNodeVariant(Item1)^.Value, PNodeVariant(Item2)^.Value)
    else
    {$IFNDEF DELPHI6}
    if PNodeVariant(Item1)^.Value < PNodeVariant(Item2)^.Value then
      Result := -1
    else Result := 1;
    {$ELSE}
    Result := VarCompare(PNodeVariant(Item1)^.Value, PNodeVariant(Item2)^.Value);
    {$ENDIF}
    if PNodeVariant(Item1)^.Desc then Result := - Result;
  end;
end;

function CompareSortedOrderColumns(Item1, Item2: Pointer): Integer;
begin
  Result := TdxTreeListColumn(Item1).FSortedOrder - TdxTreeListColumn(Item2).FSortedOrder;
end;

// button 9x9
procedure DrawButton(ACanvas: TCanvas; ARect: TRect; YCenter: Integer; IsPlus: Boolean);
const
  btSize = 9;
begin
  with ACanvas do
  begin
    // calc rect
    with ARect do
    begin
      Left := (Left + Right - btSize) div 2;
      Top := YCenter - btSize div 2;
      Right := Left + btSize;
      Bottom := Top + btSize;
    end;
    // draw
    Windows.FrameRect(Handle, ARect, GetSysColorBrush(COLOR_GRAYTEXT)); {BTNSHADOW}
    with ARect do
    begin
      Windows.FillRect(Handle, Rect(Left + 2, Top + 4, Right - 2{Left + 7}, Top + 4 + 1), {-}
        GetSysColorBrush(COLOR_WINDOWTEXT));
      if IsPlus then
        Windows.FillRect(Handle, Rect(Left + 4, Top + 2, Left + 4 + 1, Bottom - 2{Top + 7}),   {|}
          GetSysColorBrush(COLOR_WINDOWTEXT));
    end;
  end;
end;

// button 12x12
procedure DrawOutButton(ACanvas: TCanvas; ARect: TRect; IsPlus: Boolean);
begin
  if IsPlus then
    WriteBmp(ACanvas, ARect, OutButtonPlus)
  else WriteBmp(ACanvas, ARect, OutButtonMinus);
end;

procedure DrawUltraFlatButton(ADC: HDC; ARect: TRect; AIsPlus: Boolean);
begin
  OffsetRect(ARect, (ARect.Right - ARect.Left - 11) div 2, (ARect.Bottom - ARect.Top - 11) div 2);
  ARect.Right := ARect.Left + 11;
  ARect.Bottom := ARect.Top + 11;
  OffsetRect(ARect, 1, 1);
  DrawEdge(ADC, ARect, BDR_RAISEDOUTER, BF_RIGHT or BF_BOTTOM or BF_FLAT{ or BF_ADJUST});
  OffsetRect(ARect, -1, -1);
  FrameRect(ADC, ARect, GetSysColorBrush(COLOR_WINDOWFRAME));
  Dec(ARect.Right);
  Dec(ARect.Bottom);
//    Windows.FillRect(Handle, ARect, COLOR_BTNFACE + 1);
  FillRect(ADC, Rect(ARect.Left + 3, ARect.Top + 5, ARect.Left + 8, ARect.Top + 5 + 1),
    GetSysColorBrush(COLOR_WINDOWFRAME));
  if AIsPlus then
    FillRect(ADC, Rect(ARect.Left + 5, ARect.Top + 3, ARect.Left + 5 + 1, ARect.Top + 8),
      GetSysColorBrush(COLOR_WINDOWFRAME));
end;

procedure DrawSortedShape(DC: HDC; ARect: TRect; IsUp: Boolean); {min width rect -> dxGridSortedShapeMinWidth}
const
  Width  = 8;
  Height = 7;
var
  PrevPen: HPEN;
  Points: array [0..2] of TPoint;
begin
  with ARect do
  begin
    Left := ((Left + Right) div 2) - (Width div 2);
    Right := Left + Width;
    Top := ((Top + Bottom) div 2) - (Height div 2);
    Bottom := Top + Height;
    if IsUp then
    begin
      // shadow
      PrevPen := SelectObject(DC, CreatePen(PS_SOLID, 1, GetSysColor(COLOR_BTNSHADOW)));
      Points[0] := Point(Left + Width div 2 - 1, Top);
      Points[1] := Point(Left, Bottom);
      Polyline(DC, Points, 2);
      Points[0] := Point(Left + Width div 2 - 2, Top + 1);
      Points[1] := Point(Left, Bottom - 1);
      Polyline(DC, Points, 2);
      // highlight
      DeleteObject(SelectObject(DC, CreatePen(PS_SOLID, 1, GetSysColor(COLOR_BTNHIGHLIGHT))));
      Points[0] := Point(Left + 1, Bottom - 1);
      Points[1] := Point(Left + Width - 1, Bottom - 1);
      Points[2] := Point(Left + Width div 2, Top - 1);
      Polyline(DC, Points, 3);
      Points[0] := Point(Left + Width div 2, Top + 1);
      Points[1] := Point(Left + Width - 1, Bottom - 1);
      Polyline(DC, Points, 2);
      DeleteObject(SelectObject(DC, PrevPen));
    end
    else
    begin
      // shadow
      PrevPen := SelectObject(DC, CreatePen(PS_SOLID, 1, GetSysColor(COLOR_BTNSHADOW)));
      Points[0] := Point(Left + Width - 1, Top);
      Points[1] := Point(Left, Top);
      Points[2] := Point(Left + Width div 2 - 1, Bottom);
      Polyline(DC, Points, 3);
      Points[0] := Point(Left + 1, Top + 1);
      Points[1] := Point(Left + Width div 2 - 1, Bottom - 1);
      Polyline(DC, Points, 2);
      // highlight
      DeleteObject(SelectObject(DC, CreatePen(PS_SOLID, 1, GetSysColor(COLOR_BTNHIGHLIGHT))));
      Points[0] := Point(Left + Width - 1, Top + 1);
      Points[1] := Point(Left + Width div 2, Bottom);
      Polyline(DC, Points, 2);
      Points[0] := Point(Left + Width - 2, Top + 1);
      Points[1] := Point(Left + Width div 2, Bottom - 1);
      Polyline(DC, Points, 2);
      DeleteObject(SelectObject(DC, PrevPen));
    end;
  end;
end;

procedure DrawBandButton(DC: HDC; var ARect: TRect; ABrush: HBRUSH;
  ADown: Boolean; AStyle: TdxHeaderButtonStyle; ALookAndFeel: TdxLookAndFeel);
var
  R: TRect;
begin
  // Draw Frame
  if ALookAndFeel = lfStandard then
  begin
    DrawEdge(DC, ARect, BDR_RAISEDOUTER, BF_BOTTOMRIGHT or BF_ADJUST);
    // Draw 3D frame
    if not ADown then
    begin
      DrawEdge(DC, ARect, BDR_RAISEDINNER, BF_BOTTOMRIGHT or BF_ADJUST);
      DrawEdge(DC, ARect, BDR_RAISEDINNER, BF_TOPLEFT or BF_ADJUST);
    end
    else
      DrawEdge(DC, ARect, BDR_SUNKENOUTER, BF_TOPLEFT or BF_ADJUST);
    // Fill Background
    FillRect(DC, ARect, ABrush);
  end
  else
  begin
    if AStyle = hbNormal then
    begin
      if ALookAndFeel = lfUltraFlat then
      begin
        FrameRect(DC, ARect, GetSysColorBrush(COLOR_BTNSHADOW));
        InflateRect(ARect, -1, -1);
      end
      else
        DrawEdge(DC, ARect, BDR_RAISEDINNER, BF_RECT or BF_ADJUST);
      FillRect(DC, ARect, ABrush);
      InflateRect(ARect, -1, 0);
    end
    else
    begin
      FillRect(DC, ARect, ABrush);
      R := ARect;
      if ALookAndFeel = lfUltraFlat then
      begin
        DrawEdge(DC, R, BDR_SUNKENOUTER, BF_TOP or BF_FLAT);
        DrawEdge(DC, R, BDR_SUNKENOUTER, BF_BOTTOM or BF_FLAT);
      end
      else
      begin
        DrawEdge(DC, R, BDR_RAISEDINNER, BF_TOP);
        DrawEdge(DC, R, BDR_RAISEDINNER, BF_BOTTOM);
      end;
      if AStyle in [hbLeft, hbLeftRight] then
      begin
        R.Top := ARect.Top + 2;
        R.Bottom := ARect.Bottom - 2;
      end
      else
      begin
        R.Top := ARect.Top + 1;
        R.Bottom := ARect.Bottom - 1;
      end;
      if ALookAndFeel = lfFlat then
        DrawEdge(DC, R, BDR_RAISEDINNER, BF_LEFT);
      if AStyle in [hbRight, hbLeftRight] then
      begin
        R.Top := ARect.Top + 2;
        R.Bottom := ARect.Bottom - 2;
      end
      else
      begin
        R.Top := ARect.Top;
        R.Bottom := ARect.Bottom - 1;
      end;
      DrawEdge(DC, R, BDR_RAISEDINNER, BF_RIGHT);
      InflateRect(ARect, -2, -1);
    end;
  end;
end;

procedure DrawBandButtonEx(DC: HDC; var ARect: TRect; ABrush: HBRUSH;
  ADown: Boolean; AStyle: TdxHeaderButtonStyle; ALookAndFeel: TdxLookAndFeel);
var
  R: TRect;
begin
  R := ARect;
  DrawBandButton(DC, ARect, ABrush, ADown, AStyle, ALookAndFeel);
  if (ALookAndFeel <> lfStandard) and ADown then
  with R do
    BitBlt(DC, Left, Top, Right-Left, Bottom-Top, 0, 0, 0, DSTINVERT);
end;

procedure DrawFlatButton(ADC: HDC; ARect: TRect; ADropDownButtonState: TdxHeaderDropDownButtonState);
var
  ABkBrush: HBRUSH;
  APen: HPEN;
  APenColor: TColorRef;
  X, Y, Size: Integer;
  P: array[1..3] of TPoint;
begin
  FrameRect(ADC, ARect, GetSysColorBrush(COLOR_BTNSHADOW));
  InflateRect(ARect, -1, -1);
  if (hdbPushed in ADropDownButtonState) then
    ABkBrush := GetSysColorBrush(COLOR_BTNTEXT)
  else
    if (hdbSelected in ADropDownButtonState) then
      ABkBrush := GetSysColorBrush(COLOR_BTNSHADOW)
    else
      ABkBrush := GetSysColorBrush(COLOR_BTNFACE);
  FillRect(ADC, ARect, ABkBrush);
  if ([hdbSelected, hdbPushed] * ADropDownButtonState <> []) then
    APenColor := GetSysColor(COLOR_WINDOW)
  else
    if (hdbActive in ADropDownButtonState) then
      APenColor := ColorToRGB(clBlue)
    else
      APenColor := GetSysColor(COLOR_BTNTEXT);
  with ARect do
  begin
    Size := (Right - Left) div 2;
    if not Odd(Size) then Inc(Size);
    X := (Left + Right - Size) div 2;
    Y := (Top + Bottom - Size div 2) div 2 - Byte(Odd(Bottom - Top)){1};
    P[1] := Point(X, Y);
    P[2] := Point(X + Size - 1, Y);
    P[3] := Point(X + Size div 2, Y + Size div 2);
    APen := SelectObject(ADC, CreatePen(PS_SOLID, 1, APenColor));
    ABkBrush := SelectObject(ADC, CreateSolidBrush(APenColor));
    Polygon(ADC, P, 3);
    DeleteObject(SelectObject(ADC, ABkBrush));
    DeleteObject(SelectObject(ADC, APen));
  end;
end;

procedure DrawBand(DC: HDC; ARect: TRect; ABrush: HBRUSH;
  const AText: string; ADown: Boolean;
  AMultiLine: Boolean; AAlignment: TAlignment;
  ASorted: TdxTreeListColumnSort; AGlyph: TBitmap; AStyle: TdxHeaderButtonStyle;
  ALookAndFeel: TdxLookAndFeel;
  ADropDownButtonState: TdxHeaderDropDownButtonState);
const
  DrawFlags: array [Boolean] of Integer = (
    DT_EXPANDTABS or DT_NOPREFIX or DT_END_ELLIPSIS or DT_VCENTER or DT_SINGLELINE,
    DT_EXPANDTABS or DT_NOPREFIX or DT_WORDBREAK);
  AlignFlags: array [TAlignment] of Integer = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  R: TRect;
  Flag: Integer;
  Size: TSize;
  AFlat: Boolean;
begin
  // Draw 3D Frame
  DrawBandButton(DC, ARect, ABrush, ADown, AStyle, ALookAndFeel);
  AFlat := ALookAndFeel <> lfStandard;
  // Draw text
  if not ADown or AFlat then
  begin
    InflateRect(ARect, -1, -1);
    Dec(ARect.Bottom);
  end
  else
    with ARect do
    begin
      Inc(Left, 3);
      Inc(Top, 3);
      Dec(Bottom);
    end;
  if ADropDownButtonState <> [] then
  begin
    with ARect do
    begin
      if (Right - Left) >= dxGridHeaderFilterBoxWidth then
      begin
        R := Rect(Right - dxGridHeaderFilterBoxWidth, Top, Right, Bottom);
        Dec(Right, dxGridHeaderFilterBoxWidth);
        Inc(R.Bottom);
        // Combo Button
        DrawFlatButton(DC, R, ADropDownButtonState);
      end;
    end;
  end;
  if ASorted <> csNone then
    with ARect do
    begin
      if (Right - Left) >= dxGridSortedShapeMinWidth then
      begin
        R := Rect(Right - dxGridSortedShapeMinWidth, Top, Right, Bottom);
        Dec(Right, dxGridSortedShapeMinWidth);
        DrawSortedShape(DC, R, ASorted = csUp);
      end;
    end;
  if (AGlyph <> nil) and not AGlyph.Empty then
    with ARect do
    begin
      if (Right - Left) > 0 then
      begin
        R := Rect(Left - 1, Top - 1, Left + AGlyph.Width, Bottom + 2 - Byte(ADown and not AFlat));
        if AFlat then OffsetRect(R, -1 , 0);
        if R.Right > Right + Byte(not ADown or AFlat) + Byte(AFlat) then
          R.Right := Right + Byte(not ADown or AFlat) + Byte(AFlat);
        Left := R.Right;
        TransparentDraw(DC, ABrush, R, AGlyph);
      end;
    end;
  SetBkMode(DC, TRANSPARENT);
  Flag := 0;
  if not AMultiLine then
  begin
    GetTextExtentPoint32(DC, PChar(AText), Length(AText), Size);
    if Size.CX <= (ARect.Right - ARect.Left) then
      Flag := DT_NOCLIP;
  end;
  DrawText(DC, PChar(AText), Length(AText), ARect,
    DrawFlags[AMultiLine] or AlignFlags[AAlignment] or Flag);
end;

procedure DrawBandEx(DC: HDC; ARect, AClipRect: TRect; ABrush: HBRUSH; ABitmap: TBitmap; {temp draw bitmap}
  const AText: string; ADown: Boolean;
  AMultiLine: Boolean; AAlignment: TAlignment;
  ASorted: TdxTreeListColumnSort; AGlyph: TBitmap; AStyle: TdxHeaderButtonStyle;
  ALookAndFeel: TdxLookAndFeel;
  ADropDownButtonState: TdxHeaderDropDownButtonState);
var
  R: TRect;
  bmpDC: HDC;
  PrevFont: HFONT;
  PrevTextColor: TColorRef;
begin
  R := ARect;
  OffsetRect(R, -R.Left, -R.Top);
  CheckDrawBitmap(ABitmap, R.Right - R.Left, R.Bottom - R.Top);
  bmpDC := ABitmap.Canvas.Handle;
  PrevFont := SelectObject(bmpDC, GetCurrentObject(DC, OBJ_FONT));
  PrevTextColor := SetTextColor(bmpDC, GetTextColor(DC));
  DrawBand(bmpDC, R, ABrush, AText, ADown,
    AMultiLine, AAlignment, ASorted, AGlyph, AStyle, ALookAndFeel, ADropDownButtonState);
  SetTextColor(bmpDC, PrevTextColor);
  SelectObject(bmpDC, PrevFont);
  if (ALookAndFeel <> lfStandard) and ADown then
  with R do
    BitBlt(bmpDC, Left, Top, Right-Left, Bottom-Top, 0, 0, 0, DSTINVERT);
  with AClipRect do
    BitBlt(DC, Left, Top, Right-Left, Bottom-Top, bmpDC, Left - ARect.Left, Top - ARect.Top, SRCCOPY);
end;

procedure DrawUltraBandButton(ADC: HDC; var ARect: TRect; ABrush: HBRUSH);
begin
  DrawEdge(ADC, ARect, BDR_SUNKENOUTER, BF_BOTTOM or BF_RIGHT or BF_FLAT or BF_ADJUST);
  FillRect(ADC, ARect, ABrush);
  InflateRect(ARect, -1, 0);
end;

procedure DrawIndicatorEx(DC: HDC; ARect, AClipRect: TRect; ABrush: HBRUSH;
  ABitmap: TBitmap; AKind: TdxGridIndicatorKind; ALookAndFeel: TdxLookAndFeel);
var
  R: TRect;
begin
  R := ARect;
  OffsetRect(R, -R.Left, -R.Top);
  CheckDrawBitmap(ABitmap, R.Right - R.Left, R.Bottom - R.Top);
  // Draw 3D Frame
  if ALookAndFeel = lfUltraFlat then
    DrawUltraBandButton(ABitmap.Canvas.Handle, R, ABrush)
  else
    DrawBandButton(ABitmap.Canvas.Handle, R, ABrush, False, hbNormal, ALookAndFeel);
  if AKind <> ikNone then
  begin
    with R, dxIndicatorImages do
      Draw(ABitmap.Canvas, (Left + Right - Width) shr 1,
        (Top + Bottom - Height) shr 1, Integer(AKind) - 1);
  end;
  with AClipRect do
    BitBlt(DC, Left, Top, Right-Left, Bottom-Top, ABitmap.Canvas.Handle, Left - ARect.Left, Top - ARect.Top, SRCCOPY);
end;

procedure DrawCellText(DC: HDC; ARect: TRect; ABrush: HBRUSH; AColor: TColor; ABitmap: TBitmap; {temp draw bitmap}
  const AText: string; ATextLen: Integer; AMultiLine: Boolean; AEndEllipsis: Boolean; AAlignment: TAlignment;
  UseBitmap, InflateFlag, SearchFlag: Boolean);
const
  DrawFlags: array [Boolean] of Integer =
    (DT_EXPANDTABS or DT_NOPREFIX or DT_VCENTER or DT_SINGLELINE,
     DT_EXPANDTABS or DT_NOPREFIX or DT_WORDBREAK);
  EllipsisFlags: array [Boolean] of Integer = (0, DT_END_ELLIPSIS);
  AlignFlags: array [TAlignment] of Integer = (DT_LEFT, DT_RIGHT, DT_CENTER);
  TextXOffset = 2;
var
  R: TRect;
  bmpDC: HDC;
  PrevFont: HFONT;
  I: TColorRef;
  LeftOffset: Integer;
  LRect, RRect: TRect;
  SizeText: TSize;
  TextYOffset: Integer;

  procedure Draw(DC: HDC; R: TRect);
  begin
    Windows.FillRect(DC, R, ABrush);
    SetBkMode(DC, TRANSPARENT);
    InflateRect(R, -TextXOffset, -TextYOffset);
        DrawText(DC, PChar(AText), ATextLen{Length(AText)}, R,
      DrawFlags[AMultiLine] or EllipsisFlags[AEndEllipsis] or AlignFlags[AAlignment]);
  end;

begin
  if InflateFlag then
    TextYOffset := 2
  else TextYOffset := 1;
  I := ColorToRGB(AColor);
  if SearchFlag or (not AEndEllipsis and not AMultiLine and (GetNearestColor(DC, I) = I)) then
  begin
    SetRectEmpty(LRect);
    SetRectEmpty(RRect);
    with ARect do
    begin
      RRect := Rect(Right - TextXOffset, Top, Right, Bottom);
      if RRect.Left < ARect.Left then
        RRect.Left := ARect.Left;
      ARect.Right := RRect.Left;
      if AAlignment in [taRightJustify, taCenter] then
      begin
        LRect := Rect(Left, Top, Left + TextXOffset, Bottom);
        if LRect.Right > ARect.Right then
          LRect.Right := ARect.Right;
        ARect.Left := LRect.Right;
      end;
    end;
    case AAlignment of
      taLeftJustify:
        with ARect do
        begin
          LeftOffset := TextXOffset;
        end;
      taRightJustify:
        with ARect do
        begin
          GetTextExtentPoint(DC, PChar(AText), Length(AText), SizeText);
          LeftOffset := (Right - Left) - SizeText.CX{ - TextXOffset};
        end;
     else {taCenter:}
        with ARect do
        begin
          GetTextExtentPoint(DC, PChar(AText), Length(AText), SizeText);
          LeftOffset := (ARect.Right - ARect.Left) shr 1 - (SizeText.CX shr 1);
        end;
    end;
    if SearchFlag then SetBkMode(DC, OPAQUE);
    ExtTextOut(DC, ARect.Left + LeftOffset, ARect.Top + TextYOffset,
      ETO_CLIPPED or Byte(not SearchFlag)*ETO_OPAQUE, @ARect, PChar(AText), ATextLen{Length(AText)}, nil);
    if not SearchFlag then
    begin
      if not IsRectEmpty(LRect) then
        FillRect(DC, LRect, ABrush);
      if not IsRectEmpty(RRect) then
        FillRect(DC, RRect, ABrush);
    end;
  end
  else {DrawText use Bitmap}
  begin
    if UseBitmap then
    begin
      R := ARect;
      OffsetRect(R, -R.Left, -R.Top);
      CheckDrawBitmap(ABitmap, R.Right - R.Left, R.Bottom - R.Top);
      bmpDC := ABitmap.Canvas.Handle;
      PrevFont := SelectObject(bmpDC, GetCurrentObject(DC, OBJ_FONT));
      SetTextColor(bmpDC, GetTextColor(DC));
      Draw(bmpDC, R);
      SelectObject(bmpDC, PrevFont);
      with ARect do
        BitBlt(DC, Left, Top, Right-Left, Bottom-Top, bmpDC, 0, 0, SRCCOPY);
    end
    else
    begin
      Draw(DC, ARect);
    end;
  end;
end;

procedure DrawPreviewText(DC: HDC; ARect: TRect; ABrush: HBRUSH; AFont: HFONT; ABitmap: TBitmap; {temp draw bitmap}
  ATextColor: TColor; const AText: string; AIndent: Integer; UseBitmap: Boolean);
const
  AlignFlag : Integer = DT_LEFT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX or DT_END_ELLIPSIS;
var
  PrevFont: HFONT;

  procedure Draw(DC: HDC; R: TRect);
  begin
    Windows.FillRect(DC, R, ABrush);
    SetBkMode(DC, TRANSPARENT);
    InflateRect(R, -1, -1);
    Inc(R.Left, AIndent);
    SetTextColor(DC, ColorToRGB(ATextColor));
    PrevFont := SelectObject(DC, AFont);
    DrawText(DC, PChar(AText), Length(AText), R, AlignFlag);
    SelectObject(DC, PrevFont);
  end;

var
  R: TRect;
  bmpDC: HDC;
begin
  if UseBitmap then
  begin
    R := ARect;
    OffsetRect(R, -R.Left, -R.Top);
    CheckDrawBitmap(ABitmap, R.Right - R.Left, R.Bottom - R.Top);
    bmpDC := ABitmap.Canvas.Handle;
    Draw(bmpDC, R);
    with ARect do
      BitBlt(DC, Left, Top, Right-Left, Bottom-Top, bmpDC, 0, 0, SRCCOPY);
  end
  else
  begin
    Draw(DC, ARect);
  end;
end;

procedure DrawFocused(DC: HDC; R: TRect);
var
  PrevBkColor, PrevTextColor: TColorRef;
begin
  PrevBkColor := SetBkColor(DC, clBlack);
  PrevTextColor := SetTextColor(DC, clWhite);
  Windows.DrawFocusRect(DC, R);
  SetBkColor(DC, PrevBkColor);
  SetTextColor(DC, PrevTextColor);
end;

procedure DrawFramed(DC: HDC; const R: TRect);
begin
  with R do
  begin
    InvertRect(DC, Rect(Left, Top, Right, Top + 1));
    InvertRect(DC, Rect(Right - 1, Top + 1, Right, Bottom));
    InvertRect(DC, Rect(Left, Top + 1, Left + 1, Bottom{ + 1}));
    InvertRect(DC, Rect(Left + 1, Bottom - 1, Right - 1, Bottom));
  end;
end;

function IsEqualText(const S1, S2: string): Boolean;
begin
  Result := AnsiUpperCase(S1) = AnsiUpperCase(S2);
end;

{TdxTreeListNode}
procedure InvaliddxTreeListOperation(const Id: string);
begin
  raise EInvaliddxTreeListOperation.Create(Id);
end;

constructor TdxTreeListNode.Create(AOwner: TCustomdxTreeList);
begin
//  inherited Create;
  FOwner := AOwner;
  {if AOwner is Nil - raise exception and destroy yourself}
  if AOwner = nil then
  begin
    InvaliddxTreeListOperation(LoadStr(dxSInvalidOwner));
    Exit;
  end;
end;

destructor TdxTreeListNode.Destroy;
var
  Prior, Next: TdxTreeListNode;
  fgLast, fgRedraw: Boolean;
begin
  if FOwner <> nil then
  begin
    FDeleting := True;
    DeleteChildren;
    if not FOwner.FClearNodes then
    begin
      Prior := GetPriorParentNode;
      Next := FOwner.GetNextVisible(Self);
      fgLast := IsLast;
      fgRedraw := IsVisible;
      FOwner.FMakeListNodeVisible := fgRedraw;
      if (Parent <> nil) and Parent.Deleting then fgRedraw := False;
    end
    else
    begin
      Prior := nil;
      Next := nil;
      fgLast := False;
      fgRedraw := False;
      FOwner.FMakeListNodeVisible := False;
    end;

    if Parent <> nil then
    begin
      if Parent.FList <> nil then
      begin
        Parent.FList.Remove(self);
        if Parent.Count = 0 then
        begin
          Parent.FList.Free;
          Parent.FList := nil;
          Parent.HasChildren := FOwner.CheckHasChildren(Parent);
          Parent.FExpanded := False;
        end;
      end;
    end
    else
    if (FOwner <> nil) and not FOwner.FClearNodes then
      FOwner.FNodeList.Remove(self);
    if FList <> nil then FList.Free;

    FOwner.DeleteNode(Self, Prior, Next, fgLast, fgRedraw);
  end;
  inherited Destroy;
end;

function TdxTreeListNode.AddChild: TdxTreeListNode;
begin
  Result := InsertChild(nil);
end;

function TdxTreeListNode.AddChildFirst: TdxTreeListNode;
begin
  Result := FOwner.CreateNode;
  Result.FParent := self;
  if FList = nil then
  begin
    FList := TList.Create;
    FList.Add(Result);
  end
  else
    FList.Insert(0, Result);
  HasChildren := True;
  FOwner.AddNode(Result);
end;

procedure TdxTreeListNode.AddNodesToList(List: TList);
var
  I: Integer;
begin
  if FList <> nil then
  begin
    I := List.Count;
    List.Count := List.Count + Self.Count;
    System.Move(FList.List^[0], List.List^[I], (Self.Count) * SizeOf(Pointer));
  end;
end;

function TdxTreeListNode.CanMove(Destination: TdxTreeListNode; Mode: TdxTreeListNodeAttachMode): Boolean;
begin
  if (Destination = nil) or ((Destination = Self) and (Mode in [natlAddChild, natlAddChildFirst, natlInsert])) or
    Destination.HasAsParent(Self) then
    Result := False
  else Result := True;
end;

procedure TdxTreeListNode.Collapse(Recurse: Boolean);
var
  I: Integer;
  Flag: Boolean;
begin
  if not HasChildren then Exit;
  Flag := FOwner.LockUpdate = 0;
  if Flag then FOwner.BeginUpdate;
  try
    Expanded := False;
    if Recurse then
      for I := 0 to Count - 1 do
        Items[I].Collapse(Recurse);
  finally
    if Flag then FOwner.EndUpdate;
  end;
end;

procedure TdxTreeListNode.DeleteChildren;
var
  I: Integer;
  L: TList;
begin
  if (FOwner = nil) or FOwner.FClearNodes then
  begin
    if FList <> nil then
    begin
      L := FList;
      FList := nil;
      try
        for I := 0 to L.Count - 1 do TdxTreeListNode(L[I]).Free;
      finally
        L.Free;
      end;
    end;
  end
  else
    while Count > 0 do Items[0].Free;
end;

procedure TdxTreeListNode.Expand(Recurse: Boolean);
var
  I: Integer;
  Flag: Boolean;
begin
  if not HasChildren then Exit;
  Flag := FOwner.LockUpdate = 0;
  if Flag then FOwner.BeginUpdate;
  try
    Expanded := True;
    if Recurse then
      for I := 0 to Count - 1 do
        Items[I].Expand(Recurse);
  finally
    if Flag then FOwner.EndUpdate;
  end;
end;

function TdxTreeListNode.GetFirstChild: TdxTreeListNode;
begin
  Result := Items[0];
end;

function TdxTreeListNode.GetLastChild: TdxTreeListNode;
var
  Node: TdxTreeListNode;
begin
  Result := GetFirstChild;
  if Result <> nil then
  begin
    Node := Result;
    repeat
      Result := Node;
      Node := Result.GetNextSibling;
    until Node = nil;
  end;
end;

function TdxTreeListNode.GetNext: TdxTreeListNode;
var
  Node: TdxTreeListNode;
begin
  Result := GetFirstChild;
  if Result = nil then
  begin
    Result := GetNextSibling;
    if (Result = nil) and (Parent <> nil) then
    begin
      Result := Parent;
      repeat
        Node := Result.GetNextSibling;
        Result := Result.Parent;
      until (Node <> nil) or (Result = nil);
      Result := Node;
    end;
  end;
end;

function TdxTreeListNode.GetNextNode: TdxTreeListNode;
begin
  Result := FOwner.GetNextVisible(Self);
end;

function TdxTreeListNode.GetNextSibling: TdxTreeListNode;
var
  I: Integer;
begin
  Result := nil;
  I := Index;
  if Parent = nil then
    if I < FOwner.Count then
      Result := FOwner.Items[I + 1]
    else
  else
    if I < Parent.Count then
      Result := Parent.Items[I + 1];
end;

function TdxTreeListNode.GetPrev: TdxTreeListNode;
var
  Node: TdxTreeListNode;
begin
  Result := GetPrevSibling;
  if Result <> nil then
  begin
    Node := Result;
    repeat
      Result := Node;
      Node := Result.GetLastChild;
    until Node = nil;
  end else
    Result := Parent;
end;

function TdxTreeListNode.GetPrevSibling: TdxTreeListNode;
var
  I: Integer;
begin
  Result := nil;
  I := Index;
  if (I > 0) then
    if Parent = nil then
      Result := FOwner.Items[I - 1]
    else
      Result := Parent.Items[I - 1];
end;

function TdxTreeListNode.GetPriorNode: TdxTreeListNode;

  function GetPrior(ANode: TdxTreeListNode): TdxTreeListNode;
  begin
    if not ANode.Expanded or (ANode.Count = 0) then
      Result := ANode
    else Result := GetPrior(ANode[ANode.Count-1]);
  end;

var
  i: Integer;
begin
  with FOwner do
    if IsSmartNavigation then
    begin
      i := FindListNode(Self);
      Result := nil;
      if i <> -1 then
      begin
        i := Integer(FListIndexes[i]);
        Dec(i);
        if i >= 0 then
          Result := TdxTreeListNode(FListRealNodes[i]);
      end;
      Exit;
    end;
  I := Index;
  if I > 0 then
  begin
    if Parent <> nil then
       Result := GetPrior(Parent.Items[I - 1])
    else Result := GetPrior(FOwner.Items[I - 1]);
  end
  else
    Result := Parent;
end;

function TdxTreeListNode.GetPriorParentNode: TdxTreeListNode;
begin
  if Index > 0 then
  begin
    if Parent <> nil then
       Result := Parent.Items[Index-1]
    else Result := FOwner.Items[Index-1];
  end
  else
    Result := Parent;
end;

function TdxTreeListNode.HasAsParent(Value: TdxTreeListNode): Boolean;
var
  ANode: TdxTreeListNode;
begin
  Result := False;
  ANode := Parent;
  while ANode <> nil do
  begin
    if ANode = Value then
    begin
      Result := True;
      Break;
    end;
    ANode := ANode.Parent;
  end;
end;

function TdxTreeListNode.IndexOf(Value: TdxTreeListNode): Integer;
begin
  Result := -1;
  if Count > 0 then
    Result := FList.IndexOf(Value);
end;

function TdxTreeListNode.InsertChild(BeforeNode: TdxTreeListNode) : TdxTreeListNode;
begin
  Result := FOwner.CreateNode;
  Result.FParent := Self;
  if FList = nil then
  begin
    FList := TList.Create;
    FList.Add(Result);
  end
  else
  begin
    if BeforeNode = nil then
      FList.Add(Result)
    else FList.Insert(BeforeNode.Index, Result);
  end;
  HasChildren := True;
  FOwner.AddNode(Result);
end;

procedure TdxTreeListNode.MakeVisible;
begin
  FOwner.MakeNodeVisible(self);
end;

procedure TdxTreeListNode.MoveTo(Destination: TdxTreeListNode; Mode: TdxTreeListNodeAttachMode);
begin
  // Check Destination
  if not CanMove(Destination, Mode) then Exit;
  FOwner.BeginUpdate;
  try
    InternalMove(Destination, Mode);
    FOwner.FFocused := Self;
    FOwner.MakeListNodes;
    MakeVisible;
  finally
    FOwner.EndUpdate;
  end;
end;

// protected TdxTreeListNode
procedure TdxTreeListNode.InternalMove(Destination: TdxTreeListNode; Mode: TdxTreeListNodeAttachMode);

  procedure CheckList(Node: TdxTreeListNode);
  begin
    if Node.FList = nil then
      Node.FList := TList.Create;
  end;

begin
  InternalRemove;
  // InternalAdd 
  if (Destination.Parent = nil) or (Mode in [natlAddChild, natlAddChildFirst]) then
  begin
    case Mode of
      natlAdd: FOwner.FNodeList.Add(Self);
      natlAddFirst: FOwner.FNodeList.Insert(0, Self);
      natlInsert: FOwner.FNodeList.Insert(Destination.Index, Self);
    else {Mode in [natlAddChild, natlAddChildFirst]}
      begin
        CheckList(Destination);
        if Mode = natlAddChild then
           Destination.FList.Add(Self)
        else Destination.FList.Insert(0, Self);
      end;
    end; {case}
    if (Mode in [natlAddChild, natlAddChildFirst]) then
    begin
      FParent := Destination;
      Parent.FHasChildren := True;
    end
    else
      FParent := nil;
  end
  else
  begin {Parent <> Nil}
    CheckList(Destination.Parent);
    case Mode of
      natlAdd: Destination.Parent.FList.Add(Self);
      natlAddFirst: Destination.Parent.FList.Insert(0, Self);
      natlInsert: Destination.Parent.FList.Insert(Destination.Index, Self);
    end;
    FParent := Destination.Parent;
  end;
end;

procedure TdxTreeListNode.InternalMoveAsChild(Destination: TdxTreeListNode; AIndex: Integer);
begin
  System.Move(FOwner.FNodeList.List^[AIndex+1], FOwner.FNodeList.List^[AIndex],
    (FOwner.FNodeList.Count - AIndex - 1) * SizeOf(Pointer));
  FOwner.FNodeList.Count := FOwner.FNodeList.Count - 1;
  if Destination.FList = nil then
     Destination.FList := TList.Create;
  Destination.FList.Add(Self);
  FParent := Destination;
  Parent.FHasChildren := True;
end;

procedure TdxTreeListNode.InternalMoveToRoot;
begin
  FOwner.FNodeList.Add(Self);
end;

procedure TdxTreeListNode.InternalRemove;
begin
  if Parent = nil then
    FOwner.FNodeList.Remove(Self)
  else
  begin
    Parent.FList.Remove(Self);
    if Parent.FList.Count = 0 then
    begin
      Parent.FList.Free;
      Parent.FList := nil;
      Parent.HasChildren := FOwner.CheckHasChildren(Parent);
      Parent.FExpanded := False;
    end;
  end;
  FParent := nil;
end;

procedure TdxTreeListNode.MoveChildrenToRoot;
var
  i: Integer;
begin
  // move all detail nodes (not has children) to root
  for i := 0 to FList.Count - 1 do
  begin
    FOwner.FNodeList.Add(Items[i]);
    Items[i].FParent := nil;
  end;
  // Clear FList
  FList.Free;
  FList := nil;
  HasChildren := FOwner.CheckHasChildren(Self);
  FExpanded := False;
  FOwner.FFocused := Self;
end;

// private TdxTreeListNode
function TdxTreeListNode.GetAbsoluteIndex: Integer;
begin
  Result := FOwner.GetAbsoluteIndex(Self);
end;

function TdxTreeListNode.GetCount: Integer;
begin
  if FList = nil then
    Result := 0
  else Result := FList.Count;
end;

function TdxTreeListNode.GetCountValues: Integer;
begin
  Result := FOwner.GetHeaderAbsoluteCount;
end;

function TdxTreeListNode.GetFocused: Boolean;
begin
  Result := FOwner.FocusedNode = Self;
end;

function TdxTreeListNode.GetImageIndex: Integer;
begin
  Result := FOwner.GetNodeImageIndex(Self);
end;

function TdxTreeListNode.GetIndex: Integer;
begin
  if Parent <> nil then
    Result := Parent.IndexOf(Self)
  else Result := FOwner.IndexOf(Self);
end;

function TdxTreeListNode.GetIsLast: Boolean;
begin
  if Parent <> nil then
    Result := Self = (Parent.Items[Parent.Count-1])
  else Result := Self = FOwner.Items[FOwner.Count-1];
end;

function TdxTreeListNode.GetIsNodeVisible: Boolean;
begin
  Result := FOwner.IsNodeVisible(Self);
end;

function TdxTreeListNode.GetItem(Index: Integer): TdxTreeListNode;
begin
  Result := nil;
  if (Index > -1) and (Index < Count) then
    Result := FList.List^[Index];
end;

function TdxTreeListNode.GetLevel: Integer;
var
 ANode: TdxTreeListNode;
begin
  Result := 0;
  ANode := Parent;
  while ANode <> nil do
  begin
    Inc(Result);
    ANode := ANode.Parent;
  end;
end;

function TdxTreeListNode.GetSelected: Boolean;
begin
  if FOwner.IsMultiSelect then
    Result := FOwner.IsNodeSelected(Self)
  else Result := Focused;
end;

function TdxTreeListNode.GetSelectedIndex: Integer;
begin
  Result := FOwner.GetNodeSelectedIndex(Self);
end;

function TdxTreeListNode.GetStateIndex: Integer;
begin
  Result := FOwner.GetNodeStateIndex(Self);
end;

function TdxTreeListNode.GetString(Column: Integer): string;
begin
  Result := FOwner.GetNodeString(Self, Column);
end;

function TdxTreeListNode.GetValue(Column: Integer): Variant;
begin
  Result := FOwner.GetNodeValue(Self, Column);
end;

procedure TdxTreeListNode.SetData(Value : Pointer);
begin
  if FOwner.CanSetData then FData := Value;
end;

procedure TdxTreeListNode.SetExpanded(Value: Boolean);
var
  Allow: Boolean;
begin
  if not HasChildren then Exit;
  if Value <> Expanded then
  begin
    {DoBeforeExpand <- Loading Nodes }
    Allow := True;
    if Value then
      FOwner.DoBeforeExpand(Self, Allow)
    else FOwner.DoBeforeCollapse(Self, Allow);
    if not Allow then Exit;
    // check TopVisibleNode
    if not Value and (FOwner.FTopVisibleNode <> nil) and
      FOwner.FTopVisibleNode.HasAsParent(Self) then
        FOwner.SetTopVisibleNode(Self);
    // check FocusedNode
    if not Value and (FOwner.FocusedNode <> nil) and
      FOwner.FocusedNode.HasAsParent(Self) then //Focused := True;
      if not FOwner.MakeFocused(Self) then Exit; // DB
    FExpanded := Value;
    {**}
    if (FOwner.FLockUpdate = 0) and
       not (csDestroying in FOwner.ComponentState) then FOwner.MakeListNodes;
    {**}
    FOwner.UpdateNode(Self, True {Below});
    {DoAfterExpand}
    if Value then
      FOwner.DoAfterExpand(Self)
    else FOwner.DoAfterCollapse(Self);
  end;
end;

function TCustomdxTreeList.MakeFocused(Node: TdxTreeListNode): Boolean;
begin
  Node.Focused := True;
  Result := True;
end;

procedure TdxTreeListNode.SetFocused(Value: Boolean);
begin
  if Focused = Value then Exit;
  if Value then
    FOwner.SetFocusedNode(Self, FOwner.FocusedColumn, True)
  else FOwner.SetFocusedNode(nil, FOwner.FocusedColumn, True);
end;

procedure TdxTreeListNode.SetHasChildren(Value: Boolean);
begin
  if FHasChildren = Value then Exit;
  FHasChildren := Value or (Count > 0);
  FOwner.UpdateNode(Self, False{no Below});
end;

procedure TdxTreeListNode.SetImageIndex(Value: Integer);
begin
  FOwner.SetNodeImageIndex(Self, Value);
end;

procedure TdxTreeListNode.SetSelected(Value: Boolean);
begin
//  if Selected = Value then Exit;
//  if FOwner.CanNodeSelected(Self) then
  FOwner.NodeSelected(Self, Value);
end;

procedure TdxTreeListNode.SetSelectedIndex(Value: Integer);
begin
  FOwner.SetNodeSelectedIndex(Self, Value);
end;

procedure TdxTreeListNode.SetStateIndex(Value: Integer);
begin
  FOwner.SetNodeStateIndex(Self, Value);
end;

procedure TdxTreeListNode.SetString(Column: Integer; const Value: string);
begin
  FOwner.SetNodeString(Self, Column, Value);
end;

procedure TdxTreeListNode.SetValue(Column: Integer; const Value: Variant);
begin
  FOwner.SetNodeValue(Self, Column, Value);
end;

{TCustomdxTreeList}
constructor TCustomdxTreeList.Create(AOwner: TComponent);
const
  ListStyle = [csCaptureMouse, csOpaque, csDoubleClicks, csDisplayDragImage];
begin
  inherited Create(AOwner);
  FNodeList := TList.Create;
  {**}
  FListIndexes := TList.Create;
  FListNodes := TList.Create;
  FListRealNodes := TList.Create;
  {**}

  // Control Style
  if NewStyleControls then
    ControlStyle := ListStyle
  else ControlStyle := ListStyle + [csFramed];

  // Initial installation
  Width := 250;
  Height := 150;
  Color := clWindow;
  ParentColor := False;
  TabStop := True;

  // Colors
  FArrowsColor := dxclArrows;
  FBandColor := clBtnFace;
  FGridColor := dxclTreeLineShadowColor;
  FGridLineColor := clNone;
  FGroupColor := clBtnFace;
  FGroupTextColor := clNone;
  FHeaderColor := clBtnFace;
  FHighlightColor := clHighlight;
  FHighlightTextColor := clHighlightText;
  FTreeLineColor := clGrayText{clBtnShadow};
  FTreeLineStyle := tlDot;
  FHideSelectionColor := clBtnFace;
  FHideSelectionTextColor := clBtnText;
  FFixedBandLineColor := clWindowFrame;
  FFooterColor := cl3DLight;
  FFooterTextColor := clWindowText;

  // Fonts
  FBandFont := TFont.Create;
  FBandFont.OnChange := HeaderFontChanged;
  FHeaderFont := TFont.Create;
  FHeaderFont.OnChange := HeaderFontChanged;
  FPreviewFont := TFont.Create;
  FPreviewFont.Color := clBlue;
  FPreviewFont.OnChange := HeaderFontChanged;
  FSaveFont := TFont.Create;

  // Indexes and positions
  FCustomizingPos := Point(-1000, -1000);
  FCustomizingLastBandIndex := -1;
  FCustomizingLastHeaderIndex := -1;
  FDownBandIndex := -1;
  FDownColumnIndex := -1;
  FFocusedColumn := -1;
  FFocusedAbsoluteIndex := -1;
  FOptions := [aoEditing, aoColumnSizing, aoColumnMoving, aoRowSelect, aoTabThrough];
  FOptionsEx := [aoUseBitmap, aoBandHeaderWidth, aoAutoCalcPreviewLines,
    aoBandSizing, aoBandMoving, aoDragExpand, aoDragScroll];
  FState := tsNormal;

  // Size
  FDescTextHeight := 11;
  FHeaderHeight := 18;
  FIndentDesc := 20;
  FRowCount := 1;
  FRowHeight := 18;
  FRowSeparatorLineWidth := 1;
  FTextHeight := 11;
  FVisibleRowCount := 1;
  FPreviewLines := 2;
  FMaxRowLineCount := -1;
  FCustomizingRowCount := dxCustomizingRowCount;
  FFixedBandLineWidth := dxGridFixedBandLineWidth;
  FDragAbsoluteHeaderIndex := -1;
  // Style
  FAutoExpandOnSearch := True;
  FAutoSearchColor := clNone;
  FAutoSearchTextColor := clNone;

  FBorderStyle := bsSingle;
  FDblClkExpanding := True;
  FHideFocusRect := True;
  FHideSelection := True;
  FShowButtons := True;
  FShowHeaders := True;
  FShowLines := True;
  FShowPreviewGrid := True;
  FShowRoot := True;
  FWaitForExpandNodeTime := dxWaitForExpandNodeTime;
  FScrollBars := ssBoth;
  FShowDragImage := True;

  // Links
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FStateChangeLink := TChangeLink.Create;
  FStateChangeLink.OnChange := ImageListChange;

  // draw buttons
  LoadButtonFaces;
  FCellViewData := TdxTreeListCellViewData.Create;
  // Filter
  FHiddenList := TList.Create;
end;

destructor TCustomdxTreeList.Destroy;
begin
  BeforeDestroy;
  {**}
  ClearListNodes;
  FListIndexes.Free;
  FListIndexes := nil;
  FListNodes.Free;
  FListNodes := nil;
  FListRealNodes.Free;
  FListRealNodes := nil;
  {**}
  if FCustomizingForm <> nil then
    FCustomizingForm.Free;
  ClearNodes;
  FHiddenList.Free;
  FHiddenList := nil;
  FPreviewFont.Free;
  FPreviewFont := nil;
  FNodeList.Free;
  FImageChangeLink.Free;
  FStateChangeLink.Free;
  FHeaderFont.Free;
  FHeaderFont := nil;
  FBandFont.Free;
  FBandFont := nil;
  FSaveFont.Free;
  FSaveFont := nil;
  FCellViewData.Free;
  inherited Destroy;
end;

function TCustomdxTreeList.Add: TdxTreeListNode;
begin
  Result := CreateNode;
  FNodeList.Add(Result);
  AddNode(Result);
end;

function TCustomdxTreeList.AddFirst : TdxTreeListNode;
begin
  Result := CreateNode;
  FNodeList.Insert(0, Result);
  AddNode(Result);
end;

procedure TCustomdxTreeList.AdjustColumnsWidth;
begin
  if IsAutoWidth then Exit;
  BeginUpdate;
  try
    Options := Options + [aoAutoWidth];
    try
      MakeBandHeaderList(True);
      StabilizeAutoWidth;
    finally
      Options := Options - [aoAutoWidth];
    end;
  finally
    EndUpdate;
  end;
end;

procedure TCustomdxTreeList.BeginUpdate;
begin
  Inc(FLockUpdate);
  //CancelEditor;
  if FState = tsNodeDown then
    FlagEditor := True;
  FInplaceColumn := -1;
  FInplaceNode := Nil;
  SetState(tsNormal);
  HideEdit(False);
  {**}
//  if FLockUpdate = 1 then
    ClearListNodes;
  {**}
  BeginSelection;
end;

procedure TCustomdxTreeList.CalcDrawInfo(var DrawInfo: TdxGridDrawInfo);

  function IntersectCoords(Point1, Point2, Range1, Range2: Integer): Boolean;
  begin
    Result := ((Point1 >= Range1) and (Point1 <= Range2)) or
      ((Point2 >= Range1) and (Point2 <= Range2)) or
      ((Point1 < Range1) and (Point2 > Range2));
  end;

var
  i, j, k, c, rCount, rMaxCount, iStart, iEnd,
  FixedLeft, FixedRight,
  BandLeftCoord, BandRightCoord, BandCoord, BandWidth,
  BandTotalWidth: Integer;
  Y, L, W, H, HeaderLeftCoord, HeaderTotalWidth: Integer;
  R: TRect;
  CurNode: TdxTreeListNode;
  cCount: Integer;
  AIndex: Integer;
  HeaderTotalMinWidth, RealBandWidth, ScaledWidth, MinW, CalcWidth: Integer;
  FlagScaled: Boolean;
  // new calc
  AHWList, AFixedHWList: TList;
  AVisibleWidth, AWidth, AScalableWidth: Integer;
  ARecalcNeeded, ACalculation: Boolean;
begin
  CalcRectInfo(DrawInfo);
  with DrawInfo do
  begin
    // bands info
    BandCount := GetBandCount;
    GetMem(BandsInfo, BandCount * SizeOf(TdxGridBandDrawInfo));
    FixedLeft := GetBandFixedLeft;
    FixedRight := GetBandFixedRight;
    iStart := 0;
    iEnd := BandCount - 1;
    BandCount := 0;
    BandTotalWidth := GetBandTotalWidth;
    FixedBandLeftIndex := -1;
    FixedBandRightIndex:= -1;
    FixedBandPrevRightIndex := -1;
    with BandRect do
    begin
      BandLeftCoord := Left;
      BandRightCoord := Right;
      if FixedLeft <> -1 then
      begin
        BandWidth := GetBandWidth(iStart) + GetIndentWidth; // Indent
        Inc(BandLeftCoord, BandWidth);
        FixedBandLeftRect := Rect(Left, Top, Left + BandWidth, CellsRect.Top);
        if FNewItemRowHeight > 0 then
          Dec(FixedBandLeftRect.Bottom, FNewItemRowSeparatorHeight);
        BandsInfo^[BandCount].Index := iStart;
        BandsInfo^[BandCount].BandRect := Rect(Left, Top,
          FixedBandLeftRect.Right - FFixedBandLineWidth, Bottom);
        BandsInfo^[BandCount].BandClipRect := BandsInfo^[BandCount].BandRect;
        FixedBandLeftIndex := iStart;
        Inc(iStart);
        Inc(BandCount);
      end;
      if (Right - Left){BandRect} > BandTotalWidth then // empty rect
      begin
        Right := Left + BandTotalWidth;
        HeaderRect.Right := Right; // correct HeaderRect
        EmptyRectRight := Rect(Right, Top, CRect.Right, CellsRect.Bottom);
        if not IsRectEmpty(NewItemRowRect) then
          NewItemRowRect.Right := EmptyRectRight.Left;
      end;
      if FixedRight <> -1 then
      begin
        BandWidth := GetBandWidth(FixedRight);
        FixedBandRightRect := Rect(Right - BandWidth, Top, Right, CellsRect.Top);
        if FNewItemRowHeight > 0 then
          Dec(FixedBandRightRect.Bottom, FNewItemRowSeparatorHeight);
        BandCoord := Max(FixedBandLeftRect.Right, IndicatorRect.Right);
        if FixedBandRightRect.Left < BandCoord then
        begin
          FixedBandRightRect.Left := BandCoord;
          FixedBandRightRect.Right := FixedBandRightRect.Left + BandWidth;
        end;
        FixedBandRightIndex := iEnd;
        Dec(iEnd);
        BandRightCoord := FixedBandRightRect.Left;
      end;
      BandCoord := - LeftCoord;
      for i := iStart to iEnd do
      begin
        BandWidth := GetBandWidth(i);
        if i = 0 then Inc(BandWidth, GetIndentWidth); // Indent
        if IntersectCoords(BandCoord, BandCoord + BandWidth, 0, BandRightCoord - BandLeftCoord) then
        begin
          BandsInfo^[BandCount].Index := i;
          BandsInfo^[BandCount].BandRect := Rect(BandLeftCoord + BandCoord, Top,
            BandLeftCoord + BandCoord + BandWidth, Bottom);
          BandsInfo^[BandCount].BandClipRect := BandsInfo^[BandCount].BandRect;
          if BandsInfo^[BandCount].BandClipRect.Left < BandLeftCoord then
            BandsInfo^[BandCount].BandClipRect.Left := BandLeftCoord;
          if BandsInfo^[BandCount].BandClipRect.Right > BandRightCoord then
            BandsInfo^[BandCount].BandClipRect.Right := BandRightCoord;
          Inc(BandCount);
        end;
        Inc(BandCoord, BandWidth);
        if FixedBandRightIndex <> -1 then
          FixedBandPrevRightIndex := i;
        if BandCoord > BandRightCoord then Break;
      end;
      if FixedRight <> -1 then
      begin
        BandsInfo^[BandCount].Index := FixedRight;
        BandsInfo^[BandCount].BandRect := Rect(FixedBandRightRect.Left + FFixedBandLineWidth, Top,
          FixedBandRightRect.Right, Bottom);
        with BandsInfo^[BandCount].BandRect do
          BandsInfo^[BandCount].BandClipRect := Rect(Left, Top, BandRect.Right, Bottom);
        Inc(BandCount);
      end;
    end;
    // headers info
    HeaderCount := 0;
    EmptyRectCount := 0;
    for i := 0 to BandCount - 1 do
    begin
      k := BandsInfo^[i].Index;
      rCount := GetHeaderRowCount(k);
      if rCount > 0 then
      begin
        for j := 0 to rCount - 1 do
          Inc(HeaderCount, GetHeaderColCount(k, j))
      end
      else Inc(EmptyRectCount);
    end;
    HeadersInfo := AllocMem(HeaderCount * SizeOf(TdxGridHeaderDrawInfo));
    HeaderCount := 0;
    EmptyRectsInfo := AllocMem(EmptyRectCount * SizeOf(TdxGridEmptyRectDrawInfo));
    EmptyRectCount := 0;
    rMaxCount := GetHeaderMaxRowCount;
    for i := 0 to BandCount - 1 do
    begin
      k := BandsInfo^[i].Index;
      rCount := GetHeaderRowCount(k);
      if rCount > 0 then
      begin
        for j := 0 to rCount - 1 do
        begin
          // *
          AHWList := TList.Create;
          AFixedHWList := TList.Create; 
          try
            BandWidth := BandsInfo^[i].BandRect.Right - BandsInfo^[i].BandRect.Left;
            RealBandWidth := BandWidth - Byte(k = 0)*GetIndentWidth;
            HeaderTotalWidth := GetHeaderTotalWidth(k, j);
            HeaderTotalMinWidth := GetHeaderTotalMinWidth(k, j);
            CCount := GetHeaderColCount(k, j);
            // calc widths
            AVisibleWidth := RealBandWidth;
            AHWList.Count := cCount;
            AFixedHWList.Count := cCount;
            for c := 0 to cCount - 1 do
            begin
              AIndex := GetHeaderAbsoluteIndex(k, j, c);
              AWidth := GetHeaderWidth(AIndex);
              AHWList[c] := Pointer(AWidth);
              AFixedHWList[c] := Pointer(not CanHeaderSizing(AIndex)); 
              if Boolean(AFixedHWList[c]) then
                Dec(AVisibleWidth, AWidth);
            end;
            // scale widths
            if AVisibleWidth < 0 then
              AVisibleWidth := 0;
            ACalculation := True;
            repeat
              ARecalcNeeded := False;
              AScalableWidth := 0;
              for c := 0 to cCount - 1 do
                if not Boolean(AFixedHWList[c]) then
                  Inc(AScalableWidth, Integer(AHWList[c]));
              for c := 0 to cCount - 1 do
              begin
                AIndex := GetHeaderAbsoluteIndex(k, j, c);
                if not Boolean(AFixedHWList[c]) then
                begin
                  if AScalableWidth > 0 then
                    AWidth := Integer(AHWList[c]) * AVisibleWidth div AScalableWidth
                  else
                    AWidth := 0;
                  if ACalculation then
                  begin
                    if AWidth < GetHeaderMinWidth(AIndex) then
                    begin
                      AHWList[c] := Pointer(GetHeaderMinWidth(AIndex));
                      AFixedHWList[c] := Pointer(True); 
                      Dec(AVisibleWidth, Integer(AHWList[c]));
                      ARecalcNeeded := True;
                      Break;
                    end;
                  end
                  else
                    AHWList[c] := Pointer(AWidth);
                end;
              end;
              if not ACalculation then
                Break;
              if not ARecalcNeeded then
                ACalculation := False;
            until False;

            // fill array
            HeaderLeftCoord := 0;
            for c := 0 to cCount - 1 do
            begin
              AIndex := GetHeaderAbsoluteIndex(k, j, c);
              if c <> (cCount - 1) {not last} then
                W := Integer(AHWList[c])
              else
                W := BandWidth - HeaderLeftCoord;
              if (k = 0) and (c = 0) and (cCount > 1) then Inc(W, GetIndentWidth); // Indent
              L := GetHeaderLineCount(k, j, c);
              H := FHeaderRowHeight * L;
              with BandsInfo^[i].BandRect do
                R := Rect(Left + HeaderLeftCoord, Bottom + FHeaderRowHeight*j,
                  Left + HeaderLeftCoord + W, Bottom + FHeaderRowHeight*j + H);
              Inc(HeaderLeftCoord, W);

              with BandsInfo^[i] do
                if IntersectCoords(R.Left, R.Right, BandClipRect.Left, BandClipRect.Right) then
                with HeadersInfo^[HeaderCount] do
                begin
                  BandIndex := k;
                  RowIndex := j;
                  ColIndex := c;
                  AbsoluteIndex := AIndex; //GetHeaderAbsoluteIndex(BandIndex, RowIndex, ColIndex);
                  LineCount := L;
                  MultiLine := IsCellMultiLine(AIndex);
                  FirstColumn := c = 0;
                  LastColumn := c = (cCount - 1);
                  // if invert select
                  LeftEdgeColumn := (c = 0) and (k = 0);
                  RightEdgeColumn := (c = (cCount - 1)) and (k = iEnd);
                  HeaderRect := R;
                  HeaderClipRect := HeaderRect;
                  if HeaderClipRect.Right > BandClipRect.Right then
                    HeaderClipRect.Right := BandClipRect.Right;
                  if HeaderClipRect.Left < BandClipRect.Left then
                    HeaderClipRect.Left := BandClipRect.Left;
                  Inc(HeaderCount);
                  // exist empty rect ?
                  if (j = (rCount - 1)) and ((j + L) < rMaxCount) then // last row
                  begin
                    with BandsInfo^[i].BandRect do
                      HeaderEmptyRect := Rect(HeaderClipRect.Left, Bottom + FHeaderRowHeight * (j + L),
                        HeaderClipRect.Right, Bottom + FHeaderRowHeight * rMaxCount);
                  end;
                end;
            end;
            // end fill array
          finally
            AFixedHWList.Free;
            AHWList.Free;
          end;
          // *
        end;
      end
      else
      begin
        W := BandsInfo^[i].BandRect.Right - BandsInfo^[i].BandRect.Left;
        with BandsInfo^[i].BandRect do
          R := Rect(Left, Bottom, Left + W, Bottom + FHeaderRowHeight * rMaxCount);
        with BandsInfo^[i] do
          if IntersectCoords(R.Left, R.Right,
               BandClipRect.Left, BandClipRect.Right) then
          with EmptyRectsInfo^[EmptyRectCount] do
          begin
            BandIndex := k;
            EmptyRect := R;
            if EmptyRect.Right > BandClipRect.Right then
              EmptyRect.Right := BandClipRect.Right;
            if EmptyRect.Left < BandClipRect.Left then
              EmptyRect.Left := BandClipRect.Left;
            if (BandsInfo^[i].BandRect.Right > BandsInfo^[i].BandClipRect.Right) then
              ClippingFlag := True;
            Inc(EmptyRectCount);
          end;
      end;
    end;
    // cells info
    RowCount := (CellsRect.Bottom - CellsRect.Top) div FRowHeight + 1;
    RowsInfo := AllocMem(RowCount * SizeOf(TdxGridRowDrawInfo));
    RowCount := 0;
    CurNode := TopVisibleNode;
    Y := CellsRect.Top;
    while (CurNode <> nil) and (Y < CellsRect.Bottom) do
    begin
      with RowsInfo^[RowCount] do
      begin
        Node := CurNode;
        IsGroup := IsRowGroup(CurNode);
        IsSelected := CurNode.Selected;
        RowHeight := GetRowHeight(CurNode, FRowHeight, False{ReCalc});
        RowFooterCount := GetRowFooterCount(CurNode);
        RowFooterHeight := RowFooterCount * FFooterRowNodeHeight;
        IndicatorKind := GetRowIndicatorKind(CurNode, IsSelected);
        if IsShowPreview then
          PreviewLineCount := GetRowPreviewLineCount(CurNode);
        if IsCalcRowAutoHeight then
        begin
          H := FRowHeight;
          RowLineCount := GetRowLineCount(CurNode, H)
        end
        else RowLineCount := -1;
        CurNode := GetNextVisible(CurNode);
        Inc(Y, RowHeight);
      end;
      Inc(RowCount);
    end;
    // edges
    EdgeX := CellsRect.Left + GetBandTotalWidth - 1;
    if IsRectEmptyEx(FixedBandLeftRect) then Dec(EdgeX, LeftCoord);
    if not IsRectEmptyEx(FixedBandRightRect) and (EdgeX > CellsRect.Right - 1) then
      EdgeX := CellsRect.Right - 1;
    EdgeY := -1;
    if Y < CellsRect.Bottom then // Y contains last coord of cells
    begin
      EdgeY := Y - 1;
      // empty bottom rect
      EmptyRectBottom := Rect(CRect.Left, EdgeY + 1, EdgeX + 1, CellsRect.Bottom);
      // correct Indicator
      IndicatorRect.Bottom := EmptyRectBottom.Top;
    end;
    if GetBandCount > 0 then
      IndentLimit := GetBandWidth(0) + GetIndentWidth
    else IndentLimit := 0;
    if not IsRectEmptyEx(FixedBandLeftRect) and
      ((CellsRect.Left + IndentLimit) > (FixedBandLeftRect.Right - FFixedBandLineWidth)) then
        IndentLimit := FixedBandLeftRect.Right - FFixedBandLineWidth - CellsRect.Left;
    if IsRectEmptyEx(FixedBandLeftRect) then
      W := LeftCoord
    else W := 0;
    if not IsRectEmptyEx(FixedBandRightRect) and
      ((CellsRect.Left + IndentLimit - W) > FixedBandRightRect.Left) then
      IndentLimit := FixedBandRightRect.Left - CellsRect.Left + W;
    if FShowGrid then
      RowSeparatorLineWidth := GetRowSeparatorLineWidth;
    // check empty rect
    if BandRect.Top = BandRect.Bottom then
      SetRectEmpty(BandRect);
    if BandButtonRect.Top = BandButtonRect.Bottom then
      SetRectEmpty(BandButtonRect);
    if HeaderRect.Top = HeaderRect.Bottom then
      SetRectEmpty(HeaderRect);
    if HeaderButtonRect.Top = HeaderButtonRect.Bottom then
      SetRectEmpty(HeaderButtonRect);
  end;
end;

procedure TCustomdxTreeList.CalcRectInfo(var DrawInfo: TdxGridDrawInfo);
begin
  FillChar(DrawInfo, SizeOf(DrawInfo), 0);
  with DrawInfo do
  begin
(*    if (Parent = nil) {not HandleAllocated} then
      CRect := Rect(0, 0, 0, 0)
    else*)
      CRect := Self.ClientRect;
    // GroupPanel
    if FGroupPanelHeight > 0 then
    with CRect do
      GroupPanelRect := Rect(Left, Top, Right, Top + FGroupPanelHeight);
    // Band
    with CRect do
      BandRect := Rect(Left + FIndicatorWidth, Top + FGroupPanelHeight,
        Right, Top + FGroupPanelHeight + FBandHeight);
    if FIndicatorWidth > 0 then // band button
    with BandRect do
      BandButtonRect := Rect(Left - FIndicatorWidth, Top, Left, Bottom);
    // Header
    with CRect do
      HeaderRect := Rect(Left + FIndicatorWidth, Top + FGroupPanelHeight + FBandHeight,
        Right, Top + FGroupPanelHeight + FBandHeight + FHeaderHeight);
    if FIndicatorWidth > 0 then // header button
    with HeaderRect do
      HeaderButtonRect := Rect(Left - FIndicatorWidth, Top, Left, Bottom);
    // New Item Row Height
    if (FNewItemRowHeight > 0) then
    with CRect do
      NewItemRowRect := Rect(Left, Top + FGroupPanelHeight + FBandHeight + FHeaderHeight,
        Right, Top + FGroupPanelHeight + FBandHeight + FHeaderHeight + FNewItemRowHeight);
    // Cells
    with CRect do
      CellsRect := Rect(Left + FIndicatorWidth,
        Top + FGroupPanelHeight + FBandHeight + FHeaderHeight + FNewItemRowHeight,
        Right, Bottom - FFooterHeight - FStatusHeight);
    with CellsRect do
      if Top > Bottom then Bottom := Top;
    // Indicator
    with CellsRect do
      IndicatorRect := Rect(CRect.Left, Top, Left, Bottom);
    // Footer
    FooterRect := Rect(CRect.Left, CellsRect.Bottom, CRect.Right, CRect.Bottom);
    FooterRect.Bottom := FooterRect.Top + FFooterHeight;
    // Filter (Status)
    StatusRect := Rect(FooterRect.Left, FooterRect.Bottom, FooterRect.Right, FooterRect.Bottom);
    StatusRect.Bottom := StatusRect.Top + FStatusHeight;
  end;
end;

procedure TCustomdxTreeList.CancelEditor;
begin
  FInplaceColumn := -1;
  FInplaceNode := Nil;
  if (csDestroying in ComponentState) {or (FLockUpdate <> 0)} then Exit;
  CloseEditor;
end;

procedure TCustomdxTreeList.CancelUpdate;
begin
  Dec(FLockUpdate);
  EndSelection;
end;

function TCustomdxTreeList.CellRect(ANode: TdxTreeListNode; AColumn: Integer): TRect;
var
  DrawInfo: TdxGridDrawInfo;
  I, K, X, Ind, Ind1, CorrectY, SizeGrid: Integer;
  R: TRect;
begin
  Result := Rect(-1, -1, -1, -1);
  K := GetFocusedAbsoluteIndex(AColumn);
  CalcDrawInfo(DrawInfo);
  try
    R := GetRectNode(ANode);
    with DrawInfo do
    for i := 0 to HeaderCount - 1 do
    begin
      if HeadersInfo^[i].AbsoluteIndex = K then
      with HeadersInfo^[i] do
      begin
        // calc indent
        GetNodeIndent(ANode, Ind, Ind1);

        X := HeaderRect.Left;
        if IsRectEmptyEx(FixedBandLeftRect) then
          Inc(X, LeftCoord);
        if (BandIndex = 0) and (X - CellsRect.Left < Ind) then
          Ind := Ind - (X - CellsRect.Left)
        else Ind := 0;

        CorrectY := Byte(not FShowGrid and ANode.HasChildren and not FPaintStandard);
        if FShowGrid then SizeGrid := 1
        else SizeGrid := 0;
        Result := Rect(HeaderRect.Left + Ind, R.Top + FRowHeight * RowIndex + CorrectY, HeaderRect.Right,
                  R.Top + FRowHeight * RowIndex + LineCount * FRowHeight - SizeGrid * Byte(FShowPreviewGrid) + CorrectY);
        if IsCalcRowAutoHeight then
        begin
          for X := 0 to DrawInfo.RowCount - 1 do
            if (RowsInfo^[X].Node = ANode) then
            begin
              Result.Bottom := Result.Top + RowsInfo^[X].RowHeight - RowSeparatorLineWidth - RowsInfo^[X].RowFooterHeight;
              Break;
            end;
        end;
        Break;
      end;
    end;
  finally
    FreeDrawInfo(DrawInfo);
  end;
end;

procedure TCustomdxTreeList.ClearNodes;
var
  PrevFlag: Boolean;
  I: Integer;
begin
  if not (csDestroying in ComponentState) then BeginUpdate;
  try
    FClearNodes := True;
    ClearListNodes;
    PrevFlag := FClearListNodesFlag;
    FClearListNodesFlag := True;
//    FClearNodes := True;
    try
      ClearSelection;
      SetEmptyNodes;
      for I := 0 to Count - 1 do Items[I].Free;
      FNodeList.Clear;
      // Hidden
      for I := 0 to FHiddenList.Count - 1 do
        TdxTreeListNode(FHiddenList[I]).Free;
      FHiddenList.Clear; 
    finally
      FClearListNodesFlag := PrevFlag;
      FClearNodes := False;
    end;
  finally
    if not (csDestroying in ComponentState) then EndUpdate;
  end;
end;

procedure TCustomdxTreeList.CloseEditor;
begin
  if FState <> tsEditing then Exit;
  if not (csDestroying in ComponentState) then
    if InplaceEditor <> Nil then InplaceEditor.ValidateEdit;
  SetState(tsNormal);
  HideEdit(True);
end;

type
  TCustomizeForm = class(TForm)
  private
    FParentForm: TCustomForm;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor CreateForm(AOwner: TComponent; AParentForm: TCustomForm);
  end;

constructor TCustomizeForm.CreateForm(AOwner: TComponent; AParentForm: TCustomForm);
begin
  inherited CreateNew(AOwner);
  FParentForm := AParentForm;
end;

procedure TCustomizeForm.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if FParentForm <> nil then
    with Params do
    begin
      WndParent := FParentForm.Handle;
    end;
end;

procedure TCustomdxTreeList.ColumnsCustomizing;
const
  dXY     = 4;
  dWidth  = 28;
var
  AParentForm: {$IFDEF DELPHI3}TCustomForm{$else}TForm{$ENDIF};
  APageControl: TPageControl;
  ATabSheet: TTabSheet;
  H: Integer;
  SysMenu: HMENU;
  FlagSimple: Boolean;
  R: TRect;
begin
  if (FCustomizingForm <> nil) then
    FCustomizingForm.Close;
  if not ShowBands and not ShowHeader or
    ((GetAbsoluteBandCount = 0) and (GetHeaderAbsoluteCount = 0)) then Exit;
  FlagSimple := SimpleCustomizeBox or ((GetAbsoluteBandCount = 1) and not ShowBands);
//  FCustomizingForm := TForm.Create(nil);
  FCustomizingForm := TCustomizeForm.CreateForm(nil, GetParentForm(Self));
  with FCustomizingForm do
  begin
//ParentWindow := GetDesktopWindow; // Windows.GetParent(GetParentForm(Self).Handle);
    Caption := sdxGrColumns;
    BorderStyle := bsToolWindow;
    BorderIcons := [biSystemMenu];
    FormStyle := fsStayOnTop;
    Font.Assign(Self.Font);
    H := FTextHeight + 3{indent} + 2 + Byte(not FFlat);
    ClientWidth := dWidth * Canvas.TextWidth('0');
    ClientHeight := FCustomizingRowCount * H + dXY;
    Color := clBtnFace;
    AParentForm := GetParentForm(Self);
    OnClose := CloseCustomizingForm;
    OnActivate := ActivateCustomizingForm;
    // Clear SysMenu
    SysMenu := GetSystemMenu(Handle, False);
    DeleteMenu(SysMenu, 7, MF_BYPOSITION);
    DeleteMenu(SysMenu, 5, MF_BYPOSITION);
    DeleteMenu(SysMenu, SC_MAXIMIZE, MF_BYCOMMAND);
    DeleteMenu(SysMenu, SC_MINIMIZE, MF_BYCOMMAND);
    DeleteMenu(SysMenu, SC_SIZE, MF_BYCOMMAND);
    DeleteMenu(SysMenu, SC_RESTORE, MF_BYCOMMAND);
  end;
  if FlagSimple then
  begin
    FCustomizingHeaderListBox := TdxHeadersListBox.Create(FCustomizingForm);
    with FCustomizingHeaderListBox do
    begin
      Parent := FCustomizingForm;
      Align := alClient;
      TreeList := Self;
      Sorted := True;
      Color := FCustomizingForm.Color{HeaderColor};
      Flat := Boolean(Self.LookAndFeel <> lfStandard);
      // correct size
      FCustomizingForm.ClientWidth := FCustomizingForm.ClientWidth +
        dWidth * Canvas.TextWidth('0') - FCustomizingHeaderListBox.ClientWidth;
      FCustomizingForm.ClientHeight := FCustomizingForm.ClientHeight +
        FCustomizingRowCount * H + - FCustomizingHeaderListBox.ClientHeight;
    end;
  end
  else
  begin
    // Page Control
    APageControl := TPageControl.Create(FCustomizingForm);
    with APageControl do
    begin
      Parent := FCustomizingForm;
      Align := alClient;
      HotTrack := True;
      Name := 'PageControl';
      // Bands
      ATabSheet := TTabSheet.Create(APageControl);
      with ATabSheet do
      begin
        Align := alClient;
        Caption := sdxGrBandsCaption;

        Name := 'tsBands';
        PageControl := APageControl;

        FCustomizingBandListBox := TdxBandsListBox.Create(ATabSheet);
        with FCustomizingBandListBox do
        begin
          Parent := ATabSheet;
          Align := alClient;
          TreeList := Self;
          Sorted := True;
          Color := FCustomizingForm.Color{BandColor};
          Flat := Boolean(Self.LookAndFeel <> lfStandard);
          // correct size
          FCustomizingForm.ClientWidth := FCustomizingForm.ClientWidth +
            dWidth * Canvas.TextWidth('0') - FCustomizingBandListBox.ClientWidth;
          FCustomizingForm.ClientHeight := FCustomizingForm.ClientHeight +
            FCustomizingRowCount * H + - FCustomizingBandListBox.ClientHeight;
        end;
      end;
      // Headers
      ATabSheet := TTabSheet.Create(APageControl);
      with ATabSheet do
      begin
        Align := alClient;
        Caption := sdxGrHeadersCaption;

        Name := 'tsHeaders';
        PageControl := APageControl;

        FCustomizingHeaderListBox := TdxHeadersListBox.Create(ATabSheet);
        with FCustomizingHeaderListBox do
        begin
          Parent := ATabSheet;
          Align := alClient;
          TreeList := Self;
          Sorted := True;
          Color := FCustomizingForm.Color{HeaderColor};
          Flat := Boolean(Self.LookAndFeel <> lfStandard);
        end;
      end;
    end;
  end;
  // Calc Position
  with FCustomizingForm do
  begin
    if (FCustomizingPos.X <> -1000) and (FCustomizingPos.Y <> -1000) then
    begin
      Left := FCustomizingPos.X;
      Top := FCustomizingPos.Y;
    end
    else
    begin
      Windows.GetWindowRect(AParentForm.Handle, R);
//      Left := R.Left + AParentForm.Width - FCustomizingForm.Width;
//      Top := R.Top + AParentForm.Height - FCustomizingForm.Height;
      Left := R.Right - FCustomizingForm.Width;
      Top := R.Bottom - FCustomizingForm.Height;
      if Left < 0 then Left := 0;
      if Top < 0 then Top := 0;
    end;
    if (FCustomizingBandListBox <> nil) and (0 <= FCustomizingLastBandIndex) and
      (FCustomizingLastBandIndex < FCustomizingBandListBox.Items.Count) then
      FCustomizingBandListBox.ItemIndex := FCustomizingLastBandIndex;
    if (FCustomizingHeaderListBox <> nil) and (0 <= FCustomizingLastHeaderIndex) and
      (FCustomizingLastHeaderIndex < FCustomizingHeaderListBox.Items.Count) then
      FCustomizingHeaderListBox.ItemIndex := FCustomizingLastHeaderIndex;
    Show;
  end;
end;

procedure TCustomdxTreeList.CopyAllToClipboard;
var
  L: TStrings;
begin
  L := TStringList.Create;
  try
    SaveAllToStrings(L);
    Clipboard.AsText := L.Text;
  finally
    L.Free;
  end;
end;

procedure TCustomdxTreeList.CopySelectedToClipboard;
var L : TStrings;
begin
  L := TStringList.Create;
  try
    SaveSelectedToStrings(L);
    Clipboard.AsText := L.Text;
  finally
    L.Free;
  end;
end;

procedure TCustomdxTreeList.EndColumnsCustomizing;
begin
  if (FCustomizingForm <> nil) then
    FCustomizingForm.Close;
end;

procedure TCustomdxTreeList.EndUpdate;
begin
  Dec(FLockUpdate);
  LayoutChanged;
  EndSelection;
end;

procedure TCustomdxTreeList.FreeDrawInfo(var DrawInfo: TdxGridDrawInfo);
begin
  with DrawInfo do
  begin
    if RowsInfo <> nil then
    begin
      FreeMem(RowsInfo);
      RowsInfo := nil;
    end;
    if EmptyRectsInfo <> nil then
    begin
      FreeMem(EmptyRectsInfo);
      EmptyRectsInfo := nil;
    end;
    if HeadersInfo <> nil then
    begin
      FreeMem(HeadersInfo);
      HeadersInfo := nil;
    end;
    if BandsInfo <> nil then
    begin
      FreeMem(BandsInfo);
      BandsInfo := nil;
    end;
  end;
end;

procedure TCustomdxTreeList.FullCollapse;
var
  I: Integer;
begin
  if Count = 0 then Exit;
  BeginUpdate;
  try
    for I := 0 to Count - 1 do
      Items[I].Collapse(True{Recurse});
  finally
    EndUpdate;
  end;
end;

procedure TCustomdxTreeList.FullExpand;
var
  I: Integer;
begin
  if Count = 0 then Exit;
  BeginUpdate;
  try
    for I := 0 to Count - 1 do
      Items[I].Expand(True{Recurse});
  finally
    EndUpdate;
  end;
end;

function TCustomdxTreeList.GetEditRect(Node: TdxTreeListNode; Column: Integer): TRect;
var
  AIndex, BIndex, RIndex, CIndex, CCount: Integer;
  Ind, Ind1: Integer;
  DrawInfo: TdxGridDrawInfo;
begin
  Result := CellRect(Node, Column);
  AIndex := GetFocusedAbsoluteIndex(Column);
  BIndex := GetVisibleBandIndex(GetHeaderBandIndex(AIndex));
  RIndex := GetHeaderRowIndex(AIndex);
  CIndex := GetHeaderColIndex(AIndex);
  CCount := GetHeaderColCount(BIndex, RIndex);
  if FShowGrid and FShowPreviewGrid then
  begin
    if not ((CIndex = (CCount - 1)) and ((BIndex = GetBandFixedLeft) or
      ((GetBandFixedRight <> -1) and (BIndex = (GetBandFixedRight - 1))))) then
      Dec(Result.Right);
  end
  else
  begin
    if (BIndex = (GetBandCount - 1)) and (CIndex = (CCount - 1)) and
      (not IsInvertSelect or FShowGrid) then
      Dec(Result.Right);
  end;
  GetNodeIndent(Node, Ind, Ind1);
  CalcRectInfo(DrawInfo);
  if (BIndex = 0) and (CIndex = 0) and (Result.Left < (DrawInfo.CellsRect.Left + Ind1)) then
    Result.Left := DrawInfo.CellsRect.Left + Ind1;
  if IsNewItemRowActive and (BIndex = 0) and (CIndex = 0) then Dec(Result.Left, Ind1);
  // in NewItemRow
  if IsNewItemRowActive then
  with DrawInfo do
  begin
    Result.Top := NewItemRowRect.Top;
    Result.Bottom := NewItemRowRect.Top + FRowHeight - Byte(FShowGrid and FShowPreviewGrid);
  end;
  if IsInvertSelect then
  begin
    InflateRect(Result, 0, -1);
    if (BIndex = 0) and (CIndex = 0) then Inc(Result.Left);
    if (BIndex = (GetBandCount - 1)) and (CIndex = (CCount - 1)) then Dec(Result.Right);
  end;
end;

function TCustomdxTreeList.GetFocusedAbsoluteIndex(FocusedIndex: Integer): Integer;
var
  I, J, FIndex, RIndex, MaxRowCount: Integer;
begin
  Result := -1;
  FIndex := -1;
  MaxRowCount := GetHeaderMaxRowCount;
  for RIndex := 0 to MaxRowCount - 1 do
  begin
    for I := 0 to GetBandCount - 1 do
    begin
      if RIndex < GetHeaderRowCount(I) then
        for J := 0 to GetHeaderColCount(I, RIndex) - 1 do
        begin
          Inc(FIndex);
          if FIndex = FocusedIndex then
          begin
            Result := GetHeaderAbsoluteIndex(I, RIndex, J);
            Break;
          end;
        end;
    end;
  end;
end;

function TCustomdxTreeList.GetFocusedVisibleIndex(AbsoluteIndex: Integer): Integer;
var
  I, J: Integer;
begin
  Result := 0;
  for I := 0 to GetVisibleHeaderCount - 1 do
  begin
    J := GetFocusedAbsoluteIndex(I);
    if J = AbsoluteIndex then
    begin
      Result := I;
      Break;
    end;
  end;
end;

function TCustomdxTreeList.GetHitInfo(Pos: TPoint): TdxTreeListHitInfo;
var
  DrawInfo: TdxGridDrawInfo;
  R, RClip: TRect;
  I, J, K, Y, Ind, Ind1: Integer;

  procedure GetNodeIndentInfo(Node: TdxTreeListNode; IsSelected: Boolean; YTop, YBottom: Integer;
    var IndentRect, ButtonRect, StateImageRect, ImageRect: TRect);

    procedure CheckRect(var R: TRect);
    begin
{.}      if not ShowRoot then
         OffsetRect(R, - FIndent, 0);
      with DrawInfo do
        if R.Left < IndentLimit then
        begin
          if R.Right > IndentLimit then
            R.Right := IndentLimit;
        end
        else SetRectEmpty(R);
    end;

  var
    X, I: Integer;
  begin
    FillChar(IndentRect, SizeOf(IndentRect), 0);
    FillChar(ButtonRect, SizeOf(ButtonRect), 0);
    FillChar(StateImageRect, SizeOf(StateImageRect), 0);
    FillChar(ImageRect, SizeOf(ImageRect), 0);
    X := -1;
    I := Node.Level;
    // button
    if Node.HasChildren and FShowButtons then
    begin
      ButtonRect := Rect(I * FIndent, YTop, (I + 1)* FIndent, YBottom);
      X := ButtonRect.Left;
    end;
    // state icon
    if (Node.StateIndex <> -1) then
    begin
      StateImageRect := Rect((I + 1)* FIndent, YTop, (I + 1)* FIndent + FImageStateW, YBottom);
      if not FPaintStandard and not Node.HasChildren then
        OffsetRect(StateImageRect, -FIndent, 0);
      if X < 0 then
        X := StateImageRect.Left;
    end;
    // icon
    if (Node.SelectedIndex <> -1) or (Node.ImageIndex <> -1) then
    begin
      if not IsRectEmpty(StateImageRect) then
      begin
        ImageRect := StateImageRect;
        Inc(ImageRect.Left, FImageW);
        ImageRect.Right := ImageRect.Left + FImageW;
      end
      else
      begin
        ImageRect := Rect((I + 1)* FIndent, YTop, (I + 1)* FIndent + FImageW - 1, YBottom);
        if not FPaintStandard and not Node.HasChildren then
          OffsetRect(ImageRect, -FIndent, 0);
      end;
      if X < 0 then
        X := ImageRect.Left;
    end;
    if X > 0 then
      IndentRect := Rect(0, YTop, X, YBottom);
    // check range
    CheckRect(IndentRect);
    CheckRect(ButtonRect);
    CheckRect(StateImageRect);
    CheckRect(ImageRect);
  end;

  function GetHitTest(Node: TdxTreeListNode; IsSelected: Boolean;
    YTop, YBottom: Integer; P: TPoint): TdxTreeListHitTest;
  var
    IndentRect, ButtonRect, StateImageRect, ImageRect: TRect;
  begin
    with DrawInfo do
    begin
      if IsRectEmptyEx(FixedBandLeftRect) then
        Inc(P.X, LeftCoord);
      P.X := P.X - CellsRect.Left;
    end;
    GetNodeIndentInfo(Node, IsSelected, YTop, YBottom,
      IndentRect, ButtonRect, StateImageRect, ImageRect);
    if PtInRect(IndentRect, P) then
      Result := htIndent
    else
    if PtInRect(ButtonRect, P) then
      Result := htButton
    else
    if PtInRect(StateImageRect, P) then
      Result := htStateIcon
    else
    if PtInRect(ImageRect, P) then
      Result := htIcon
    else Result := htNowhere;
  end;

  function CanBandReSizing(VisibleIndex: Integer): Boolean;
  begin
    Result := (aoBandSizing in OptionsEx) and CanBandSizing(VisibleIndex);
    if Result and IsBandHeaderWidth and not ShowBands then Result := False;
  end;

begin
  CalcDrawInfo(DrawInfo);
  try
    with Result do
    begin
      X := Pos.X;
      Y := Pos.Y;
      Band := -1;
      Column := -1;
      Node := nil;
      Row := -1;
      FooterRow := -1;
      hitType := htOutside;
    end;
    with DrawInfo do
    begin
      if not PtInRect(CRect, Pos) then Exit;
      Result.hitType := htNowhere;
      // Group Panel
      if not IsRectEmpty(GroupPanelRect) and PtInRect(GroupPanelRect, Pos) then
      begin
        Result.hitType := htGroupPanel;
        Exit;
      end;
      // Band Panel Edge
      if not IsRectEmpty(BandRect) and CanBandPanelSizing then
      begin
        R := BandRect;
        if not IsRectEmpty(BandButtonRect) then
          R.Left := BandButtonRect.Left;
        Inc(R.Bottom, dxTreeListMaxResizeWidth);
        if PtInRect(R, Pos) and (Pos.Y >= (R.Bottom - 2*dxTreeListMaxResizeWidth)) then
        begin
          Result.hitType := htBandPanelEdge;
          Exit;
        end;
      end;
      // BandButtonRect
      if not IsRectEmpty(BandButtonRect) and PtInRect(BandButtonRect, Pos) then
      begin
        Result.hitType := htBandButton;
        Exit;
      end;
      // BandRect
      if not IsRectEmpty(BandRect) then
      begin
        if PtInRect(BandRect, Pos) then
        begin
          Result.hitType := htBand;
          // test band edge
          if BandsInfo <> nil then
            for i := 0 to BandCount - 1 do
            begin
              R := BandsInfo^[i].BandRect;
              if PtInRect(R, Pos) and PtInRect(BandsInfo^[i].BandClipRect, Pos) then
              begin
                Result.Band := BandsInfo^[i].Index;
                if CanBandReSizing(Result.Band) then
                begin
                  RClip := DrawInfo.BandRect;
                  if not IsRectEmptyEx(FixedBandLeftRect) then
                    RClip.Left := FixedBandLeftRect.Right;
                  if not IsRectEmptyEx(FixedBandRightRect) then
                    RClip.Right := FixedBandRightRect.Left;
                  if (R.Left <= RClip.Left) and (R.Right > RClip.Right) and
                    (Pos.X >= (RClip.Right - dxTreeListMaxResizeWidth)) then
                  begin
                    Result.hitType := htBandEdge;
                    Exit;
                  end
                  else
                  if Pos.X >= (R.Right - dxTreeListMaxResizeWidth) then
                  begin
                    Result.hitType := htBandEdge;
                    Exit;
                  end
                  else
                  if (i > 0) then
                  begin
                    if (Pos.X >= (BandsInfo^[i - 1].BandRect.Right - dxTreeListMaxResizeWidth)) and
                       (Pos.X <= (BandsInfo^[i - 1].BandRect.Right + dxTreeListMaxResizeWidth)) and
                       CanBandReSizing(BandsInfo^[i - 1].Index) then
                    begin
                      Result.Band := BandsInfo^[i - 1].Index;
                      Result.hitType := htBandEdge;
                      Exit;
                    end;
                  end;
                end;
                Break;
              end;
              if CanBandReSizing(BandsInfo^[i].Index) and (Pos.X > R.Right) and
                (Pos.X <= (R.Right + dxTreeListMaxResizeWidth)) then // last band
              begin
                Result.Band := BandsInfo^[i].Index;
                Result.hitType := htBandEdge;
                Exit;
              end;
            end;
          Exit;
        end;
        // Band Edge (last band)
        if (BandCount > 0) and CanBandReSizing(BandsInfo^[BandCount - 1].Index) and
          PtInRect(Rect(BandRect.Right, BandRect.Top,
          BandRect.Right + dxTreeListMaxResizeWidth, BandRect.Bottom), Pos) then
        begin
          Result.Band := BandsInfo^[BandCount - 1].Index;
          Result.hitType := htBandEdge;
          Exit;
        end;
      end;
      // Header Panel Edge
      if not IsRectEmpty(HeaderRect) and CanHeaderPanelSizing then
      begin
        R := HeaderRect;
        if not IsRectEmpty(HeaderButtonRect) then
          R.Left := HeaderButtonRect.Left;
        Inc(R.Bottom, dxTreeListMaxResizeWidth);
        if PtInRect(R, Pos) and (Pos.Y >= (R.Bottom - 2*dxTreeListMaxResizeWidth)) then
        begin
          Result.hitType := htHeaderPanelEdge;
          Exit;
        end;
      end;
      // HeaderButtonRect
      if not IsRectEmpty(HeaderButtonRect) and PtInRect(HeaderButtonRect, Pos) then
      begin
        Result.hitType := htHeaderButton;
        Exit;
      end;
      // HeaderRect
      if not IsRectEmpty(HeaderRect) then
      begin
        if PtInRect(HeaderRect, Pos) then
        begin
          Result.hitType := htColumn;
          if HeadersInfo <> nil then
          begin
            for i := 0 to HeaderCount - 1 do
            begin
              R := HeadersInfo^[i].HeaderRect;
              if PtInRect(R, Pos) and PtInRect(HeadersInfo^[i].HeaderClipRect, Pos) then
              begin
                Result.Band := HeadersInfo^[i].BandIndex;
                Result.Column := HeadersInfo^[i].AbsoluteIndex;
                // test long header
                RClip := DrawInfo.HeaderRect;
                if not IsRectEmptyEx(FixedBandLeftRect) then
                  RClip.Left := FixedBandLeftRect.Right;
                if not IsRectEmptyEx(FixedBandRightRect) then
                  RClip.Right := FixedBandRightRect.Left;
                if ((R.Left <= RClip.Left) and (R.Right > RClip.Right) and
                  (Pos.X >= (RClip.Right - dxTreeListMaxResizeWidth))) or
                  (Pos.X >= (R.Right - dxTreeListMaxResizeWidth)) then
                begin
                  if CanHeaderReSizing(HeadersInfo^[i].AbsoluteIndex) and
                    (not HeadersInfo^[i].LastColumn or CanHeaderBandSizing) then
                    Result.hitType := htColumnEdge
                  else
                  if HeadersInfo^[i].LastColumn and CanBandReSizing(HeadersInfo^[i].BandIndex) then
                    Result.hitType := htBandEdge;
                end
                else
                if (HeadersInfo^[i].ColIndex > 0) and (i > 0) and
                  (HeadersInfo^[i - 1].BandIndex = HeadersInfo^[i].BandIndex) and
                  (HeadersInfo^[i - 1].RowIndex = HeadersInfo^[i].RowIndex) then
                begin
                  if (Pos.X >= (HeadersInfo^[i - 1].HeaderRect.Right - dxTreeListMaxResizeWidth)) and
                     (Pos.X <= (HeadersInfo^[i - 1].HeaderRect.Right + dxTreeListMaxResizeWidth)) and
                     CanHeaderReSizing(HeadersInfo^[i - 1].AbsoluteIndex) then
                  begin
                    Result.Column := HeadersInfo^[i - 1].AbsoluteIndex;
                    Result.hitType := htColumnEdge;
                  end;
                end
                else
                if (HeadersInfo^[i].ColIndex = 0) and (HeadersInfo^[i].BandIndex > 0) and
                  (Pos.X < (HeadersInfo^[i].HeaderRect.Left + dxTreeListMaxResizeWidth)) then
                begin
                  Result.Band := HeadersInfo^[i].BandIndex - 1;
                  if not CanHeaderBandSizing and CanBandReSizing(HeadersInfo^[i].BandIndex - 1) then
                    Result.hitType := htBandEdge
                  else
                  if CanHeaderBandSizing then
                  begin
                    k := GetHeaderRowCount(Result.Band);
                    if k > 0 then
                    begin
                      Result.Column := GetHeaderAbsoluteIndex(Result.Band, k - 1,
                        GetHeaderColCount(Result.Band, k - 1) - 1);
                      if (Result.Column <> -1) and CanHeaderReSizing(Result.Column) then
                        Result.hitType := htColumnEdge;
                    end;
                  end;
                end;
                Exit;
              end;
            end;
          end;
          Result.hitType := htNowhere; // Empty rect
          Exit;
        end;
        // Band Edge (last band)
        if (BandCount > 0) and PtInRect(Rect(HeaderRect.Right, HeaderRect.Top,
          HeaderRect.Right + dxTreeListMaxResizeWidth, HeaderRect.Bottom), Pos) then
        begin
          Result.Band := BandsInfo^[BandCount - 1].Index;
          if not CanHeaderBandSizing and CanBandReSizing(BandsInfo^[BandCount - 1].Index) then
            Result.hitType := htBandEdge
          else
          if CanHeaderBandSizing then 
          begin
            k := GetHeaderRowCount(Result.Band);
            if k > 0 then
            begin
              Result.Column := GetHeaderAbsoluteIndex(Result.Band, k - 1,
                GetHeaderColCount(Result.Band, k - 1) - 1);
              if (Result.Column <> -1) and CanHeaderReSizing(Result.Column) then
                Result.hitType := htColumnEdge;
            end;
          end;
          Exit;
        end;
      end;
      // NewItemRowRect
      if not IsRectEmpty(NewItemRowRect) and PtInRect(NewItemRowRect, Pos) then
      begin
        Result.hitType := htNewRowItem;
        // calc column index
        if HeadersInfo <> nil then
        begin
          for i := 0 to HeaderCount - 1 do
          begin
            R := HeadersInfo^[i].HeaderRect;
            R.Top := NewItemRowRect.Top;
            R.Bottom := NewItemRowRect.Bottom - FNewItemRowSeparatorHeight;
            with HeadersInfo^[i].HeaderClipRect do
              RClip := Rect(Left, R.Top, Right, R.Bottom);
            if PtInRect(R, Pos) and PtInRect(RClip, Pos) then
            begin
              Result.Band := HeadersInfo^[i].BandIndex;
              Result.Column := HeadersInfo^[i].AbsoluteIndex;
              Break;
            end;
          end;
        end;
        Exit;
      end;
      // IndicatorRect
      if not ShowIndicator then
        IndicatorRect.Right := CellsRect.Right; 
      if not IsRectEmpty(IndicatorRect) then
      begin
        if PtInRect(IndicatorRect, Pos) then
        begin
          Result.hitType := htIndicator;
          // calc Row index
          if RowsInfo <> nil then
          begin
            Y := CellsRect.Top;
            for i := 0 to RowCount - 1 do
            begin
              if (Y <= Pos.Y) and (Pos.Y < (Y + RowsInfo^[i].RowHeight)) then
              begin
                Result.Row := i;
                Result.Node := RowsInfo^[i].Node;
                if CanRowSizing then
                begin
                  if (Y <> CellsRect.Top) and (i > 0) and
                    (Y <= Pos.Y) and (Pos.Y <= (Y + dxTreeListMaxResizeWidth)) then
                  begin
                    Result.Row := i - 1;
                    Result.Node := RowsInfo^[i - 1].Node;
                    Result.hitType := htRowEdge;
                    Exit;
                  end
                  else
                  if ((Y + RowsInfo^[i].RowHeight - dxTreeListMaxResizeWidth) <= Pos.Y) and
                    (Pos.Y <= (Y + RowsInfo^[i].RowHeight)) then
                  begin
                    Result.Row := i;
                    Result.Node := RowsInfo^[i].Node;
                    Result.hitType := htRowEdge;
                    Exit;
                  end;
                end;
                Break;
              end;
              Inc(Y, RowsInfo^[i].RowHeight);
            end;
          end;
          if ShowIndicator or (Result.hitType = htRowEdge) then Exit;
        end
        else // test last row
        if PtInRect(Rect(IndicatorRect.Left, IndicatorRect.Bottom,
          IndicatorRect.Right, IndicatorRect.Bottom + dxTreeListMaxResizeWidth), Pos) and
          (RowCount > 0) and CanRowSizing then
        begin
          Result.Row := RowCount - 1;
          Result.Node := RowsInfo^[RowCount - 1].Node;
          Result.hitType := htRowEdge;
          if ShowIndicator or (Result.hitType = htRowEdge) then Exit;
        end;
      end;
      // Status
      if not IsRectEmpty(StatusRect) and PtInRect(StatusRect, Pos) then
      begin
        Result.hitType := htStatusPanel;
        Exit;
      end;
      // FooterRect
      if not IsRectEmpty(FooterRect) and PtInRect(FooterRect, Pos) then
      begin
        Result.hitType := htSummaryFooter;
        // calc column
        if HeadersInfo <> nil then
        begin
          for i := 0 to HeaderCount - 1 do
          begin
            with HeadersInfo^[i] do
            begin
              R := Rect(HeaderRect.Left, FooterRect.Top + FFooterRowHeight * RowIndex,
                HeaderRect.Right, FooterRect.Top + FFooterRowHeight * RowIndex + LineCount * FFooterRowHeight + 3);
              if RowIndex = 0 then Dec(R.Top);
              with HeaderClipRect do
                RClip := Rect(Left, R.Top, Right, R.Bottom);
            end;
            if PtInRect(R, Pos) and PtInRect(RClip, Pos) then
            begin
              Result.Band := HeadersInfo^[i].BandIndex;
              Result.Column := HeadersInfo^[i].AbsoluteIndex;
              Break;
            end;
          end;
        end;
        Exit;
      end;
      // Row
      if (RowsInfo <> nil) and (BandCount > 0) then
      begin
        Y := CellsRect.Top;
        for i := 0 to RowCount - 1 do
        begin
          if (Y <= Pos.Y) and (Pos.Y < (Y + RowsInfo^[i].RowHeight)) then
          begin
            Result.Row := i;
            Result.hitType := htRight;
            Result.Node := RowsInfo^[i].Node;
            if Pos.X < EdgeX then
              Result.hitType := htLabel;
            if Result.Node <> nil then
            begin
              with RowsInfo^[i] do
              begin
                // test node footer 
                for k := 0 to RowFooterCount - 1 do
                begin
                  R := GetFooterRect(Node, k, Y + RowHeight - RowSeparatorLineWidth - RowFooterHeight, Byte(FShowGrid), DrawInfo);
                  if PtInRect(R, Pos) then
                  begin
                    Result.hitType := htSummaryNodeFooter;
                    Result.FooterRow := k;
                    Break;
                  end;
                end;
                // test indent
                if Result.hitType <> htSummaryNodeFooter then
                begin
                  GetNodeIndent(Node, Ind1, Ind);
                  if Ind > IndentLimit then
                    Ind := IndentLimit;
                  if IsRectEmptyEx(FixedBandLeftRect) then
                    Dec(Ind, LeftCoord);
                  if Pos.X < (CellsRect.Left + Ind) then
                    Result.hitType := GetHitTest(Node, IsSelected, Y, Y + RowHeight, Pos);
                end;
                // test preview
                if Result.hitType = htLabel then
                begin
                  if PreviewLineCount > 0 then
                  begin
                    if ((Y + RowHeight - PreviewLineCount * FDescTextHeight -
                      RowSeparatorLineWidth - 2 - RowFooterHeight) <= Pos.Y) and
                      (Pos.Y <= Y + RowHeight - RowSeparatorLineWidth - RowFooterHeight) then
                    begin
                      Result.hitType := htPreview;
                    end;
                  end;
                end;
                // calc column index
                if Result.hitType in [htLabel, htSummaryNodeFooter] then
                begin
                  if (HeadersInfo <> nil) then
                  begin
                    for j := 0 to HeaderCount - 1 do
                    begin
                      with HeadersInfo^[j] do
                      begin
                        if Result.hitType = htLabel then
                        begin
                          R := Rect(HeaderRect.Left, Y + FRowHeight * RowIndex, HeaderRect.Right,
                            Y + FRowHeight * RowIndex + LineCount * FRowHeight);
                          if (FHeaderRowCount = 1) then
                            R.Bottom := Y + RowHeight - PreviewLineCount * FDescTextHeight {- RowSeparatorLineWidth} - RowFooterHeight;
                        end
                        else
                        begin
                          k := Y + RowHeight {- RowSeparatorLineWidth} - RowFooterHeight +
                            Result.FooterRow * FFooterRowNodeHeight;
                          R := Rect(HeaderRect.Left, k + FFooterRowHeight * RowIndex,
                            HeaderRect.Right, k + FFooterRowHeight * RowIndex + LineCount * FFooterRowHeight + 2);
                          if RowIndex = 0 then Dec(R.Top);
                        end;
                        with HeaderClipRect do
                          RClip := Rect(Left, R.Top, Right, R.Bottom);
                        if PtInRect(R, Pos) and PtInRect(RClip, Pos) then
                        begin
                          Result.Band := HeadersInfo^[j].BandIndex;
                          Result.Column := HeadersInfo^[j].AbsoluteIndex;
                          Break;
                        end;
                      end;
                    end;
                  end;
                end;
              end;
            end;
            Break;
          end;
          Inc(Y, RowsInfo^[i].RowHeight);
        end;
      end;
    end;
  finally
    FreeDrawInfo(DrawInfo);
  end;
end;

function TCustomdxTreeList.GetHitTestInfoAt(X, Y: Integer): TdxTreeListHitTest;
begin
  Result := GetHitInfo(Point(X, Y)).hitType;
end;

function TCustomdxTreeList.GetNextVisible(Node: TdxTreeListNode):TdxTreeListNode;
  function GetLastVisible(Node:TdxTreeListNode):TdxTreeListNode;
  begin
     if Node.Parent = Nil then
       Result := Items[Node.Index+1]
     else
       if (Node.Parent.Count-1) > Node.Index then
         Result := Node.Parent.Items[Node.Index+1]
       else
         Result := GetLastVisible(Node.Parent);
  end;
{**}var i: Integer;
begin
{**}
  if IsSmartNavigation then
  begin
    i := FindListNode(Node);
    Result := nil;
    if i <> -1 then
    begin
      i := Integer(FListIndexes[i]);
      Inc(i);
      if i < FListRealNodes.Count then
        Result := TdxTreeListNode(FListRealNodes[i]);
    end;
    Exit;
  end;
{**}

  if Node.Expanded and (Node.Count > 0) then
     Result := Node.Items[0]
  else
    if Node.Parent = Nil then
    begin
      Result := Items[Node.Index+1]
    end
    else
    begin {Parent <> NIl}
      if Node.Index < (Node.Parent.Count-1) then
         Result := Node.Parent.Items[Node.Index+1]
      else {last node}
         Result := GetLastVisible(Node.Parent);
    end;
end;

function TCustomdxTreeList.GetNodeAt(X, Y: Integer): TdxTreeListNode;
begin
  Result := GetHitInfo(Point(X, Y)).Node;
end;

function TCustomdxTreeList.GetNodeByNavigation(ANode: TdxTreeListNode;
  ANavigationMode: TdxTreeListNavigationMode; AGotoHidden: Boolean): TdxTreeListNode;
begin
  Result := ANode;
  if Assigned(ANode) then
  begin
    case ANavigationMode of
      tlnmFirst:
        Result := TopNode;
      tlnmPrev:
        begin
          Result := ANode.GetPriorNode;
        end;
      tlnmNext:
        begin
          if AGotoHidden then
            Result := ANode.GetNext
          else
            Result := ANode.GetNextNode;
        end;
      tlnmLast:
        begin
          Result := LastNode;
          if AGotoHidden then
            while Result.Count > 0 do
              Result := Result[Result.Count - 1];
        end;
    else
      Result := nil;
    end;
  end;
end;

function TCustomdxTreeList.GotoNodeByNavigation(ANavigationMode: TdxTreeListNavigationMode;
  AGotoHidden: Boolean): TdxTreeListNode;
var
  ANeededSelectedResync: Boolean;
begin
  Result := FocusedNode;
  if Assigned(Result) then
  begin
    ANeededSelectedResync := IsMultiSelect and (SelectedCount = 1) and
      IsNodeSelected(Result);
    Result := GetNodeByNavigation(Result, ANavigationMode, AGotoHidden);
    if Assigned(Result) then
    begin
      Result.Focused := True;
      if ANeededSelectedResync then
      begin
        ClearSelection;
        Result.Selected := True;
      end;
    end;
  end;
end;

procedure TCustomdxTreeList.GotoFirst;
begin
  GotoNodeByNavigation(tlnmFirst, False);
end;

procedure TCustomdxTreeList.GotoLast(AGotoHidden: Boolean);
begin
  GotoNodeByNavigation(tlnmLast, AGotoHidden);
end;

function TCustomdxTreeList.GotoNext(AGotoHidden: Boolean): Boolean;
begin
  Result := GotoNodeByNavigation(tlnmNext, AGotoHidden) <> nil;
end;

function TCustomdxTreeList.GotoPrev(AGotoHidden: Boolean): Boolean;
begin
  Result := GotoNodeByNavigation(tlnmPrev, AGotoHidden) <> nil;
end;

function TCustomdxTreeList.HideDrawFocusRect: Boolean;
begin
  Result := aoHideFocusRect in Options;
end;

procedure TCustomdxTreeList.HideEditor;
begin
  if FState <> tsEditing then Exit;
  if not (csDestroying in ComponentState) then
    if InplaceEditor <> nil then InplaceEditor.ValidateEdit;
  SetState(tsNormal);
  HideEdit(False);
end;

function TCustomdxTreeList.IndexOf(Value: TdxTreeListNode) : Integer;
begin
  Result := FNodeList.IndexOf(Value);
end;

function TCustomdxTreeList.Insert(BeforeNode: TdxTreeListNode) : TdxTreeListNode;
begin
  Result := CreateNode;
  if (BeforeNode = nil) then FNodeList.Add(Result)
  else FNodeList.Insert(BeforeNode.Index, Result);
  AddNode(Result);
end;

function TCustomdxTreeList.IsAutoFilter: Boolean;
begin
  Result := False;
end;

function TCustomdxTreeList.IsActive: Boolean;
begin
  Result := IsActiveControl or
    ((State = tsEditing) and (InplaceEditor <> nil) and InplaceEditor.IsFocused);
end;

function TCustomdxTreeList.IsBOF: Boolean;
begin
  Result := (Count = 0) or (FocusedNode = TopNode);
end;

function TCustomdxTreeList.IsEOF: Boolean;
begin
  Result := (Count = 0) or (FocusedNode = LastNode); 
end;

function TCustomdxTreeList.IsInvertSelect: Boolean;
begin
  Result := aoInvertSelect in OptionsEx;
end;

function TCustomdxTreeList.IsNodeVisible(Node: TdxTreeListNode) : Boolean;
begin
  Result := False;
  repeat
    Node := Node.Parent;
    if Node = nil then
    begin
      Result := True;
      Exit;
    end
    else
      if not Node.Expanded then Exit;
  until False;
end;

function TCustomdxTreeList.IsShowButtonAlways: Boolean;
begin
  Result := aoShowButtonAlways in OptionsEx;
end;

procedure TCustomdxTreeList.MakeBandVisible(VisibleIndex: Integer);
var
  XStart, XEnd, SWidth: Integer;
begin
  if (GetBandCount > 1) and (VisibleIndex >= 0) and
    (VisibleIndex < GetBandCount) and
    (VisibleIndex <> GetBandFixedLeft) and
    (VisibleIndex <> GetBandFixedRight) then
  begin
    // Calc Left and Right Position
    XStart := GetStartBandCoord(VisibleIndex);
    XEnd := XStart + GetBandWidth(VisibleIndex);
    SWidth := GetScrollableWidth;
    // Check Pos
    if (XStart < LeftCoord) then
      LeftCoord := XStart
    else
    if (XEnd > (LeftCoord + SWidth)) then
    begin
      XEnd := LeftCoord + (XEnd - (LeftCoord + SWidth));
      if XStart < XEnd then XEnd := XStart;
      LeftCoord := XEnd;
    end;
  end;
end;

procedure TCustomdxTreeList.MakeColumnVisible(AbsoluteIndex: Integer);
var
  AIndex, BIndex, RIndex, CIndex, C, XStart, XEnd: Integer;
  SWidth, W: Integer;
begin
  if (0 <= AbsoluteIndex) and (AbsoluteIndex < GetHeaderAbsoluteCount) then
  begin
    BIndex := GetVisibleBandIndex(GetHeaderBandIndex(AbsoluteIndex));
    if (BIndex <> -1) and (BIndex <> GetBandFixedLeft) and (BIndex <> GetBandFixedRight) then
    begin
      // Calc Left and Right Pos 1
      RIndex := GetHeaderRowIndex(AbsoluteIndex);
      CIndex := GetHeaderColIndex(AbsoluteIndex);
      XStart := GetStartBandCoord(BIndex);
      XEnd := XStart;
      for C := 0 to CIndex do
      begin
        AIndex := GetHeaderAbsoluteIndex(BIndex, RIndex, C);
        W := GetHeaderBoundsWidth(AIndex);
        if C <> CIndex then
          Inc(XStart, W)
        else XEnd := XStart + W;
      end;
      // Check Pos
      SWidth := GetScrollableWidth;
      // Check Pos
      if (XStart < LeftCoord) then
        LeftCoord := XStart
      else
      if (XEnd > (LeftCoord + SWidth)) then
      begin
        XEnd := LeftCoord + (XEnd - (LeftCoord + SWidth));
        if XStart < XEnd then XEnd := XStart;
        LeftCoord := XEnd;
      end;
    end;
  end;
end;

procedure TCustomdxTreeList.MakeNodeVisible(Node: TdxTreeListNode);
var
  FTopIndex, FIndex: Integer;
  FlagRepaint: Boolean;
  CurNode: TdxTreeListNode;
begin
  FlagRepaint := False;
  if not Node.IsVisible then
  begin
    BeginUpdate;
    FlagRepaint := True;
    CurNode := Node.Parent;
    while CurNode <> nil Do
    begin
      if not CurNode.Expanded then CurNode.Expanded := True;
      CurNode := CurNode.Parent;
    end;
  end;
  FTopIndex := GetAbsoluteIndex(TopVisibleNode);
  FIndex := GetAbsoluteIndex(Node);
  if (FTopIndex <= FIndex) and (FIndex <= (FTopIndex + RowCount - 1))
     and (not FlagRepaint) then Exit;
  if FIndex < FTopIndex then
    TopIndex := FIndex
  else
    if (FIndex > (FTopIndex + RowCount - 1)) then
      TopIndex := CalcNearTopIndex(FIndex);
  if FlagRepaint then EndUpdate;
end;

function TCustomdxTreeList.PointInCustomizingForm(P:TPoint) : Boolean;
begin
  Result := False;
  if (FCustomizingForm <> nil) and FCustomizingForm.Visible and
    PtInRect(FCustomizingForm.ClientRect, FCustomizingForm.ScreenToClient(P)) then Result := True;
end;

procedure TCustomdxTreeList.SaveAllToStrings(List: TStrings);
var
  Node: TdxTreeListNode;
begin
  {Copy Headers}
  List.Add(GetHeaderTabText);
  {Copy nodes}
  Node := TopNode;
  while Node <> nil do
  begin
    List.Add(GetNodeTabText(Node));
    Node := Node.GetNextNode;
  end;
end;

procedure TCustomdxTreeList.SaveAllToTextFile(const FileName : String);
var
  L: TStrings;
begin
  L := TStringList.Create;
  try
    SaveAllToStrings(L);
    L.SaveToFile(FileName);
  finally
    L.Free;
  end;
end;

procedure TCustomdxTreeList.SaveSelectedToStrings(List: TStrings);
var
  I: Integer;
  L: TList;
begin
  {Copy Headers}
  List.Add(GetHeaderTabText);
  {Copy nodes}
  if IsMultiSelect then
  begin
    L := TList.Create;
    try
      for I := 0 to SelectedCount - 1 do
        L.Add(SelectedNodes[I]);
      L.Sort(@CompareByAbsoluteIndex);
      for I := 0 to L.Count - 1 do
        List.Add(GetNodeTabText(L[I]));
    finally
      L.Free;
    end;
  end
  else
  begin
    if FocusedNode <> nil then
      List.Add(GetNodeTabText(FocusedNode));
  end;
end;

procedure TCustomdxTreeList.SaveSelectedToTextFile(const FileName : String);
var
  L: TStrings;
begin
  L := TStringList.Create;
  try
    SaveSelectedToStrings(L);
    L.SaveToFile(FileName);
  finally
    L.Free;
  end;
end;

procedure TCustomdxTreeList.ShowEditor;
var
  Allow : Boolean;
begin
  if not IsEditing or IsRowSelect or (FocusedNode = nil) then Exit;
  Allow := True;
  // check new item row
  if NewItemRowActive then
    DoBeforeEditNewItemRow(Allow)
  else
  if FocusedNode <> nil then
     DoBeforeEditing(FocusedNode, Allow)
  else Allow := False;
  if not Allow then
  begin
    FInplaceEdit := nil;
    Exit;
  end;
  if FState <> tsNormal then Exit;
  if (FocusedColumn = -1) or (GetVisibleHeaderCount = 0) then Exit;
  MakeColumnVisible(GetFocusedAbsoluteIndex(FocusedColumn));
  if FocusedNode <> nil then FocusedNode.MakeVisible;
  SetState(tsEditing);
  UpdateEdit(True);
end;

procedure TCustomdxTreeList.ShowEditorChar(Ch: Char);
begin
  ShowEditor;
  if (InplaceEditor <> nil) and (State = tsEditing) then
    case Ch of // RE
      ^V: PostMessage(InplaceEditor.Handle, WM_PASTE, 0, 0);
      ^X: PostMessage(InplaceEditor.Handle, WM_CUT, 0, 0);
    else
      PostMessage(InplaceEditor.Handle, WM_CHAR, Word(Ch), 0);
    end;  
end;

procedure TCustomdxTreeList.ShowButtonEditorMouse(X, Y: Integer);
begin
  ShowEditor;
  if (State = tsEditing) and (InplaceEditor <> nil) then
    InplaceEditor.MouseButtonClick(X, Y);
end;

procedure TCustomdxTreeList.ShowEditorMouse(X, Y: Integer);
begin
  ShowEditor;
  if (State = tsEditing) and (InplaceEditor <> nil) then
    InplaceEditor.MouseClick;
end;

procedure TCustomdxTreeList.StabilizeAutoWidth;
var
  AIndex: Integer;
begin
  if IsBandHeaderWidth and (GetVisibleHeaderCount > 0) and (GetBandCount = 1) then
  begin
    AIndex := GetFocusedAbsoluteIndex(0);
    ChangedHeaderAutoWidth(GetBandCount - 1, AIndex, GetHeaderBoundsWidth(AIndex));
  end
  else
  if GetBandCount > 0 then
    ChangedBandAutoWidth(0, GetBandWidth(0) + GetIndentWidth);
end;

function TCustomdxTreeList.StartSearch(AColumnIndex: Integer; const AText: string): Boolean;
begin
  HideEditor;
  NewItemRowActive := False;
  if AColumnIndex = -1 then AColumnIndex := FocusedAbsoluteIndex;
  FSearchColumnIndex := AColumnIndex;
  FocusedColumn := GetFocusedVisibleIndex(FSearchColumnIndex);
  FSearching := True;
  FSearchText := AText;
  DoSearch(FSearchText, sdNone, True{Exact});
  Result := FSearchText <> '';
end;

procedure TCustomdxTreeList.EndSearch;
begin
  if FSearching then
  begin
    FSearching := False;
    if (LockUpdate = 0) and (FocusedNode <> nil) and
      not (csDestroying in ComponentState) then
      InvalidateRect(GetRectNode(FocusedNode));
  end;  
end;

procedure TCustomdxTreeList.CheckSearchColumn;
begin
  if not IsRowSelect and (FSearchColumnIndex <> FocusedAbsoluteIndex) then
  begin
    FSearchColumnIndex := FocusedAbsoluteIndex;
    FSearchText := '';
  end;
end;

procedure TCustomdxTreeList.DoSearch(var AText: string;
  ADirection: TdxTreeListSearchDirection; AExact: Boolean);
var
  Node: TdxTreeListNode;
begin
  Inc(FLockSearching);
  try
    if (FSearchColumnIndex <> -1) and (Count > 0) then
    begin
      Node := nil;
      if not FindNodeByText(FSearchColumnIndex, AText, ADirection, Node) then
      begin
        if AExact then AText := ''
        else
        if ADirection = sdNone then Delete(AText, Length(AText), 1);
      end
      else
        if Node <> nil then Node.Focused := True;
    end
    else
      AText := '';
    if FocusedNode <> nil then
    begin
      if IsMultiSelect then
      begin
        ClearSelection;
        if not FocusedNode.Selected then
          FocusedNode.Selected := True;
      end;
      FocusedNode.MakeVisible;
      InvalidateRect(GetRectNode(FocusedNode));
    end;
  finally
    Dec(FLockSearching);
  end;
end;

function TCustomdxTreeList.FindNodeByText(AColumnIndex: Integer; const AText: string;
  ADirection: TdxTreeListSearchDirection; var ANode: TdxTreeListNode): Boolean;

  function GetPrior(Node: TdxTreeListNode): TdxTreeListNode;
  begin
    Result := nil;
    if Node <> nil then
    begin
      if AutoExpandOnSearch then 
        Result := Node.GetPrev
      else Result := Node.GetPriorNode;
    end;
  end;

  function GetNext(Node: TdxTreeListNode): TdxTreeListNode;
  begin
    Result := nil;
    if Node <> nil then
    begin
      if AutoExpandOnSearch then
        Result := Node.GetNext
      else Result := Node.GetNextNode;
    end;
  end;

var
  CurNode, StartNode: TdxTreeListNode;
  L: Integer;
  S: string;

  procedure CalcNextNode;
  begin
    if CurNode <> nil then
      if ADirection = sdUp then
      begin
        CurNode := GetPrior(CurNode);
        if CurNode = nil then
        begin
          CurNode := LastNode;
          StartNode := FocusedNode;
        end;
      end
      else
      begin
        CurNode := GetNext(CurNode);
        if CurNode = nil then
        begin
          CurNode := TopNode;
          StartNode := FocusedNode;
        end;
      end;
  end;

begin
  Result := False;
  if AText <> '' then
  begin
    CurNode := FocusedNode;
    StartNode := nil;
    if ADirection <> sdNone then CalcNextNode;
    L := Length(AText);
    while (CurNode <> nil) and (CurNode <> StartNode) do
    begin
      S := CurNode.Strings[AColumnIndex];
      if IsEqualText(Copy(S, 1, L), AText) then
      begin
        ANode := CurNode;
        Result := True;
        Break;
      end;
      CalcNextNode;
    end;
  end;
end;

procedure TCustomdxTreeList.BeginSelection;
begin
  if FLockSelection = 0 then
    FPrevSelectedCount := SelectedCount;
  Inc(FLockSelection);
end;

function TCustomdxTreeList.GetDefaultPopupBorderStyle(AEditBorderStyle: TdxEditBorderStyle): TdxPopupBorderStyle;
begin
  if LookAndFeel = lfStandard then
    Result := pbFrame3D
  else
    Result := pbSingle;
end;

procedure TCustomdxTreeList.EndSelection;
begin
  Dec(FLockSelection);
  if (FLockSelection = 0) and (FPrevSelectedCount <> SelectedCount) then
    DoSelectedCountChange;
end;

// protected TCustomdxTreeList
// override TCustomControl
// override TCustomControl
procedure TCustomdxTreeList.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or WS_TABSTOP or WS_CLIPCHILDREN;
    WindowClass.Style := CS_DBLCLKS or CS_VREDRAW or CS_HREDRAW; 
    if (FBorderStyle = bsSingle) and (LookAndFeel = lfStandard) then
      if NewStyleControls and Ctl3D then
      begin
        Style := Style and not WS_BORDER;
        ExStyle := ExStyle or WS_EX_CLIENTEDGE;
      end
      else
        Style := Style or WS_BORDER;
    if (LookAndFeel <> lfStandard) then
      if (FBorderStyle = bsNone) then
        Style := Style and not WS_BORDER;
  end;
end;

procedure TCustomdxTreeList.CreateWnd;
begin
  inherited CreateWnd;
  UpdateScrollBars;
end;

procedure TCustomdxTreeList.DoExit;
begin
  inherited DoExit;
  HideEditor;
end;

procedure TCustomdxTreeList.KeyDown(var Key: Word; Shift: TShiftState);

  procedure DoSelection(Direction: Integer);

    function Sign(const I: Integer): Integer;
    begin
      if I = 0 then Result := 0
      else if I < 0 then Result := -1
      else Result := 1;
    end;

  var
    AddAfter: Boolean;
  begin
    AddAfter := False;
    if IsMultiSelect then
    if (ssShift in Shift) then
    begin
      if not FSelecting then
      begin
        if not ((GetSelectedCount=1)
           and ((Direction < 0) and IsTopNode(FocusedNode))
           or  ((Direction > 0) and IsLastNode(FocusedNode))) then
        ClearSelection;
        if CanFullMultiSelect and (SelectionAnchor <> nil) then
        begin
          SelectNodes(SelectionAnchor, FocusedNode);
          FocusedNode.Selected := Sign(SelectionAnchor.AbsoluteIndex - FocusedNode.AbsoluteIndex) <> Sign(Direction);
//          FocusedNode.Selected := False;
        end
        else
        begin
          SelectionAnchor := FocusedNode;
          FocusedNode.Selected := True;
        end;
        FSelecting := True;
        AddAfter := True;
      end
      else
      begin
        AddAfter := CompareSelectionAnchor(FocusedNode) <> -Direction;
        if not AddAfter then
           FocusedNode.Selected := False;
      end;
    end
    else
    begin
      if not ((GetSelectedCount=1)
          and ((Direction < 0) and IsTopNode(FocusedNode))
          or  ((Direction > 0) and IsLastNode(FocusedNode))) then
      ClearSelection;
      SelectionAnchor := nil;
    end;
    FocusedNumber:=FocusedNumber+Direction;
    if AddAfter then FocusedNode.Selected := True;
  end;

  procedure MoveFocused(Direction: Integer);
  var
    AFocusedIndex, ATopIndex, AEndIndex, FCount: Integer;
  begin
    FCount := GetAbsoluteCount;
    if (FocusedNode <> nil) {and (FCount > 1) }then
    begin
      if FCount > 1 then
      begin
        AFocusedIndex := GetAbsoluteIndex(FocusedNode);
        ATopIndex := GetAbsoluteIndex(TopVisibleNode);
        AEndIndex := ATopIndex + RowCount - 1;
        if AEndIndex > (FCount - 1) then AEndIndex := FCount - 1;
        if (ATopIndex < AFocusedIndex) and (AFocusedIndex < AEndIndex) then
          if Direction < 0 then
            FocusedNumber := ATopIndex
          else FocusedNumber := AEndIndex
        else
        begin
          AFocusedIndex := RowCount - 1;
          if AFocusedIndex < 1 then AFocusedIndex := 1;
          if Direction < 0 then
            FocusedNumber := FocusedNumber - AFocusedIndex
          else FocusedNumber := FocusedNumber + AFocusedIndex;
        end;
      end
      else
      begin
        if ((Direction < 0) and not IsTopNode(FocusedNode)) or
          ((Direction > 0) and not IsLastNode(FocusedNode)) then
        FocusedNumber := FocusedNumber + Direction;
      end;
    end;
  end;

  function CalcNextColumn(AColumn: Integer; AForward: Boolean): Integer;
  var
    AIndex, C: Integer;
  begin
    if AForward then
    begin
      C := GetVisibleHeaderCount;
      while (AColumn < C) do
      begin
        AIndex := GetFocusedAbsoluteIndex(AColumn);
        if GetHeaderTabStop(AIndex) then Break;
        Inc(AColumn);
      end;
    end
    else
    begin
      while (0 <= AColumn) do
      begin
        AIndex := GetFocusedAbsoluteIndex(AColumn);
        if GetHeaderTabStop(AIndex) then Break;
        Dec(AColumn);
      end;
    end;
    Result := AColumn;
  end;

  procedure MoveToEndColumnPriorRow;
  var
    AIndex: Integer;
  begin
    ClearSelection;
    FocusedNumber := FocusedNumber - 1;
    AIndex := CalcNextColumn(GetVisibleHeaderCount - 1, False{Forward});
//    if AIndex < 0 then AIndex := GetVisibleHeaderCount - 1;
    if AIndex >= 0 then
       FocusedColumn := AIndex;
  end;

  procedure MoveToHomeNextRow;
  var
    AIndex: Integer;
  begin
    ClearSelection;
    FocusedNumber := FocusedNumber + 1;
    AIndex := CalcNextColumn(0, True{Forward});
//    if AIndex > (GetVisibleHeaderCount - 1) then AIndex := 0;
    if AIndex <= (GetVisibleHeaderCount - 1) then
      FocusedColumn := AIndex;
  end;

var
  AIndex: Integer;
  SearchDirection: TdxTreeListSearchDirection;
begin
  BeginSelection;
  try
    inherited KeyDown(Key, Shift);
    if not CanTreeListAcceptKey(Key, Shift) then Key := 0;
    if State in [tsColumnSizing, tsColumnDragging, tsBandSizing, tsBandDragging,
      tsBandPanelSizing, tsHeaderPanelSizing, tsRowSizing] then
    begin
      if Key = VK_ESCAPE then CancelDragSizing;
      Exit;
    end;
    if Count = 0 then Exit;
    if (Key In [VK_UP, VK_DOWN, VK_PRIOR, VK_NEXT, VK_TAB, VK_RETURN, {VK_INSERT,}
                VK_ESCAPE])
           and (FState = tsEditing) then
    begin
      CloseEditor;
      if Key = VK_ESCAPE then Exit;
    end;
    if NewItemRowActive and (Key in [VK_NEXT, VK_DOWN]) then
    begin
      NewItemRowActive := False;
      if TopVisibleNode <> nil then
        TopVisibleNode.Focused := True;
      if not ((ssCtrl in Shift) or (ssShift in Shift)) then
      begin
        ClearSelection;
        SelectionAnchor := nil;
        if FocusedNode <> nil then
          FocusedNode.Selected := True;
      end;
    end
    else // Search
    if FSearching and ((Key in [VK_DELETE, VK_BACK, VK_ESCAPE]) or
      ((Key = VK_RETURN) and (Shift*[ssCtrl, ssShift] <> []))) then
    begin
      CheckSearchColumn;
      SearchDirection := sdNone;
      case Key of
        VK_DELETE: FSearchText := '';
        VK_BACK: Delete(FSearchText, Length(FSearchText), 1);
        VK_RETURN:
          if ssCtrl in Shift then
            SearchDirection := sdDown
          else
            if ssShift in Shift then
              SearchDirection := sdUp;
      end;
      if Key = VK_ESCAPE then EndSearch
      else DoSearch(FSearchText, SearchDirection, False);
    end
    else
    if (ssCtrl in Shift) and
      not ( (Key in [VK_HOME, VK_END, VK_NEXT, VK_PRIOR, VK_UP, VK_DOWN]) and
       (ssShift in Shift) and CanFullMultiSelect) then
    begin
      FSelecting := False;
      case Key of
        VK_SPACE: if (IsRowSelect or not IsEditing) and (FocusedNode <> nil) then
          begin
            FocusedNode.Selected := not FocusedNode.Selected;
            SelectionAnchor := FocusedNode;
          end;
        VK_HOME: FocusedNumber := 0;
        VK_END: FocusedNumber := GetAbsoluteCount - 1;
        VK_NEXT: MoveFocused(1); //FocusedNumber:=FocusedNumber+RowCount - 1;
        VK_PRIOR: MoveFocused(-1); //FocusedNumber:=FocusedNumber-RowCount + 1;
        VK_UP: if IsTopNode(FocusedNode) then
                 NewItemRowActive := True
               else FocusedNumber:=FocusedNumber-1;
        VK_DOWN: FocusedNumber:=FocusedNumber+1;
        VK_LEFT: FocusedColumn := 0;
        VK_RIGHT: FocusedColumn := GetVisibleHeaderCount - 1;
        VK_INSERT: CopySelectedToClipboard;
      end;
    end
    else
    begin
      case Key of
        VK_HOME: begin
           if (IsRowSelect or (ssShift in Shift)) then
           begin
             ClearSelection;
             {
             if (ssShift in Shift) and CanFullMultiSelect then
             begin
               if SelectionAnchor = nil then
                 SelectionAnchor := FocusedNode;
               SelectNodes(SelectionAnchor, TopNode);
             end
             else
               SelectionAnchor := nil;
             FocusedNumber:=0;
             }
             if (ssShift in Shift) and CanFullMultiSelect then
             begin
               if SelectionAnchor = nil then
                 SelectionAnchor := FocusedNode;
               FocusedNumber := 0;
               if SelectionAnchor <> nil then
                 SelectNodes(SelectionAnchor, FocusedNode{TopNode});
             end
             else
             begin
               SelectionAnchor := nil;
               FocusedNumber := 0;
             end;
           end
           else
             FocusedColumn := 0;
         end;
        VK_END: begin
           if (IsRowSelect or (ssShift in Shift)) then
           begin
             ClearSelection;
             {
             if (ssShift in Shift) and CanFullMultiSelect then
             begin
               if SelectionAnchor = nil then
                 SelectionAnchor := FocusedNode;
               SelectNodes(SelectionAnchor, LastNode);
             end
             else
               SelectionAnchor := nil;
             FocusedNumber:=GetAbsoluteCount-1;
             }
             if (ssShift in Shift) and CanFullMultiSelect then
             begin
               if SelectionAnchor = nil then
                 SelectionAnchor := FocusedNode;
               FocusedNumber := GetAbsoluteCount - 1;
               if SelectionAnchor <> nil then
                 SelectNodes(SelectionAnchor, FocusedNode{LastNode});
             end
             else
             begin
               SelectionAnchor := nil;
               FocusedNumber := GetAbsoluteCount - 1;
             end;
           end
           else
             FocusedColumn := GetVisibleHeaderCount - 1;
         end;
        VK_PRIOR: begin
             ClearSelection;
             if (ssShift in Shift) and CanFullMultiSelect then
             begin
               if SelectionAnchor = nil then
                 SelectionAnchor := FocusedNode;
             end
             else
               SelectionAnchor := nil;

//             FocusedNumber := FocusedNumber - RowCount;
             if IsTopNode(FocusedNode) then
               NewItemRowActive := True
             else
               MoveFocused(-1);

             if (ssShift in Shift) and CanFullMultiSelect and
               (SelectionAnchor <> nil) then
               SelectNodes(SelectionAnchor, FocusedNode);
           end;
        VK_NEXT: begin
             ClearSelection;
             if (ssShift in Shift) and CanFullMultiSelect then
             begin
               if SelectionAnchor = nil then
                 SelectionAnchor := FocusedNode;
             end
             else
               SelectionAnchor := nil;

             MoveFocused(1);

             if (ssShift in Shift) and CanFullMultiSelect and
               (SelectionAnchor <> nil) then
               SelectNodes(SelectionAnchor, FocusedNode);
           end;
        VK_UP: begin
            if not (IsVertThrough and DoMoveFocusedColumn(True{Up}, False)) then
            begin
              if IsTopNode(FocusedNode) then
                NewItemRowActive := True
              else
                DoSelection(-1);
            end;
          end;
        VK_DOWN: begin
            if not (IsVertThrough and DoMoveFocusedColumn(False{Down}, False)) then
              DoSelection(1);
          end;

        VK_LEFT: begin
          if IsRowSelect then          
          begin
            FocusedNode.MakeVisible;
            if not NewItemRowActive then
              if FocusedNode.Expanded then
                 FocusedNode.Expanded := False
              else
              if (FocusedNode.Index = 0) and
                 (FocusedNode.Parent <> Nil) then
              begin
                ClearSelection;
                FocusedNode.Parent.Focused := True;
                FocusedNode.Selected := True;
              end
              else
              begin
                ClearSelection;
                FocusedNumber := FocusedNumber - 1;
              end;
          end
          else
          begin
            if (FocusedColumn = 0) and IsHorzThrough then
              MoveToEndColumnPriorRow
            else
              FocusedColumn := FocusedColumn - 1;
          end;
        end;

        VK_RIGHT: begin
          if IsRowSelect then
          begin
            FocusedNode.MakeVisible;
            if not NewItemRowActive then
              if FocusedNode.HasChildren then
              begin
                if not FocusedNode.Expanded then
                  FocusedNode.Expanded := True
                else
                  if FocusedNode.Count > 0 then
                  begin
                    ClearSelection;
                    FocusedNode[0].Focused := True;
                    FocusedNode.Selected := True;
                  end;
              end
              else
              begin
                ClearSelection;
                FocusedNumber := FocusedNumber + 1;
              end;
          end
          else
          begin
            if (FocusedColumn >= (GetVisibleHeaderCount - 1)) and IsHorzThrough then
              MoveToHomeNextRow
            else
              FocusedColumn := FocusedColumn + 1;
          end;
        end;

        VK_ESCAPE:
        begin
           ClearSelection;
           InvalidateEditor;
           if FInplaceEdit <> nil then FInplaceEdit.Deselect;
           CloseEditor;
        end;
        VK_F2: ShowEditor;
        VK_TAB: if not (ssAlt in Shift) then
        begin
          if ssShift in Shift then
          begin
            if IsRowSelect then
            begin
              ClearSelection;
              FocusedNumber:=FocusedNumber - 1;
            end
            else
            begin
              // TabStop - calc next column
              AIndex := CalcNextColumn(FocusedColumn - 1, False{Forward});
              if (AIndex < 0) and IsTabThrough then
                MoveToEndColumnPriorRow
              else FocusedColumn := AIndex;
            end;
            Shift := [];
          end
          else
          begin
            if IsRowSelect then
            begin
              ClearSelection;
              FocusedNumber:=FocusedNumber + 1;
            end
            else
            begin
              // TabStop - calc next column
              AIndex := CalcNextColumn(FocusedColumn + 1, True{Forward});
              if (AIndex > (GetVisibleHeaderCount - 1)) and IsTabThrough then
                MoveToHomeNextRow
              else FocusedColumn := AIndex;
            end;
          end;
        end;
        VK_RETURN: begin
          if IsEnterThrough then
          begin
            // TabStop - calc next column
            AIndex := CalcNextColumn(FocusedColumn + 1, True{Forward});
            if (AIndex > (GetVisibleHeaderCount - 1)) then
              MoveToHomeNextRow
            else FocusedColumn := AIndex;
            ShowEditor;
          end;
        end;
      end;
      if (GetSelectedCount=0) and (FocusedNode <> nil) then FocusedNode.Selected := True;
    end;
  finally
    EndSelection;
  end;
end;

procedure TCustomdxTreeList.KeyPress(var Key: Char);

  function IsControlPressed: Boolean;
  begin
    Result := (GetAsyncKeyState(VK_CONTROL) < 0) and
      (GetAsyncKeyState(VK_MENU) >= 0);
  end;

begin
  if (State = tsNormal) and not FSearching and IsAutoSearch and
   not (Key in [#8..#9, #13, #27]) and not IsControlPressed then // TODO: ^V, ^X, ...
    StartSearch(FocusedAbsoluteIndex, '');
  if not FSearching and IsEnterShowEditor and (FState <> tsEditing) then
  begin
    if Key = #13 then
      ShowEditor
    else
      if Key in [^H, ^V, ^X, #32..#255] then
      begin
        ShowEditorChar(Key);
        if InplaceEditor = nil then inherited KeyPress(Key); // OnKeyPress event
      end
      else inherited KeyPress(Key)
  end
  else
    inherited KeyPress(Key);
  if FState = tsEditing then Exit;
  if FocusedNode <> nil then
    case Key of
      '-':
        begin
          FocusedNode.MakeVisible;
          FocusedNode.Expanded := False;
        end;
      '+':
        begin
          FocusedNode.MakeVisible;
          FocusedNode.Expanded := True;
        end;
      '*':
        begin
          if FocusedNode.HasChildren then
             FocusedNode.Expand(True{Recuse});
        end;
      ^C:
        if aoAutoCopySelectedToClipboard in OptionsEx then
          CopySelectedToClipboard;
    end;
  if FSearching and (Key in [#32..#255]) and not IsControlPressed then // TODO: ^V, ^X, ...
  begin
    CheckSearchColumn;
    FSearchText := FSearchText + Key;
    DoSearch(FSearchText, sdNone, False);
  end;
end;

procedure TCustomdxTreeList.Loaded;
begin
  inherited Loaded;
  LayoutChanged;
end;

procedure TCustomdxTreeList.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
const
  DblClickHitTest = [htNowhere, htButton, htIcon, htStateIcon,
    htIndent, htLabel, htRight, htOutside];
var
  OldFocusedColumn, NewColumn: Integer;
  FlagFocus: Boolean;
  PrevNewItemRowActive: Boolean;
begin
  if (State = tsEditing) and (InplaceEditor <> Nil)
     and (InplaceEditor.DisableKillFocus) then Exit;
  if (InplaceEditor <> nil) and
    not InplaceEditor.DisableCloseEditor then CloseEditor;
  FlagFocus := False;
  FlagCtrl := False;
  FlagSelect := False;
  FlagEditor := False;
  if not (csDesigning in ComponentState) and
    (CanFocus or (GetParentForm(Self) = nil)) then
  begin
    if not Focused then FlagFocus := True;
    //SetFocus;
    Windows.SetFocus(Handle);
    if not IsActiveControl then
    begin
      MouseCapture := False;
      Exit;
    end;
  end;

  FHitInfo := GetHitInfo(Point(X, Y));

  // if Right button pressed then Cancel Drag and Sizing
  if (FState <> tsNormal) and (Button = mbRight) then
    CancelDragSizing;

  // Sizing
  if (FState = tsNormal) and (Button = mbLeft) then
  begin
    if (FHitInfo.hitType = htBandEdge) and (FHitInfo.Band <> -1) then
    begin
      if ssDouble in Shift then
        DoBestFitBand(FHitInfo.Band)
      else
      begin
        SetState(tsBandSizing);
        FSizingPos := X;
        FPrevSizingPos := FSizingPos;
        DrawSizingLine;
      end;
      Exit;
    end;

    if (FHitInfo.hitType = htColumnEdge) and (FHitInfo.Column <> -1) then
    begin
      if ssDouble in Shift then
        DoBestFitColumn(FHitInfo.Column)
      else
      begin
        SetState(tsColumnSizing);
        FSizingPos := X;
        FPrevSizingPos := FSizingPos;
        DrawSizingLine;
      end;
      Exit;
    end;

    if (FHitInfo.hitType = htBandPanelEdge) then
    begin
      SetState(tsBandPanelSizing);
      FSizingPos := Y;
      FPrevSizingPos := FSizingPos;
      DrawSizingLine;
      Exit;
    end;

    if (FHitInfo.hitType = htHeaderPanelEdge) then
    begin
      SetState(tsHeaderPanelSizing);
      FSizingPos := Y;
      FPrevSizingPos := FSizingPos;
      DrawSizingLine;
      Exit;
    end;

    if (FHitInfo.hitType = htRowEdge) then
    begin
      SetState(tsRowSizing);
      FSizingPos := Y;
      FPrevSizingPos := FSizingPos;
      DrawSizingLine;
      Exit;
    end;

    // Drag Drop
    if (FHitInfo.hitType = htBand) then
    begin
      SetState(tsBandDown);
      FDownBandIndex := FHitInfo.Band;
      FDownBandPushed:= True;
      FPointDragging.X := X;
      FPointDragging.Y := Y;
      InvalidateBand(FDownBandIndex);
    end;

    if (FHitInfo.hitType = htColumn) then
    begin
      if IsAutoFilter and (FHotTrackInfo.HeaderHotTrack in [hhtDropDownButton, hhtDropDownButtonDisabled]) then
      begin
        if (FHotTrackInfo.HeaderHotTrack in [hhtDropDownButton]) then
        begin
          SetState(tsDropDownButtonDown);
          FDropDownButtonColumnIndex := FHitInfo.Column;
          FDropDownButtonColumnPushed := True;
          InvalidateColumn(FDropDownButtonColumnIndex);
        end;
      end
      else
      begin
        SetState(tsColumnDown);
        FDownColumnIndex := FHitInfo.Column;
        FDownColumnPushed := True;
        FPointDragging.X := X;
        FPointDragging.Y := Y;
        InvalidateColumn(FDownColumnIndex);
      end;
    end;

    if (FHitInfo.hitType = htBandButton) and CanBandButtonClicking then
    begin
      SetState(tsBandButtonDown);
      FBandButtonPushed := True;
      InvalidateBandButton;
    end;

    if (FHitInfo.hitType = htHeaderButton) and CanHeaderButtonClicking then
    begin
      SetState(tsHeaderButtonDown);
      FHeaderButtonPushed := True;
      InvalidateHeaderButton;
    end;
  end;

  if (Button = mbLeft) and (FHitInfo.hitType in [htStatusPanel]) then
  begin
    if PtInRect(GetStatusCloseButtonRect, Point(X, Y)) then
    begin
      SetState(tsStatusCloseButtonDown);
      FStatusCloseButtonPressed := True;
      InvalidateRect(GetStatusCloseButtonRect);
    end;
  end;

  PrevNewItemRowActive := FNewItemRowActive;
  if (State = tsNormal) and ((Button = mbLeft) or
     ((Button = mbRight) and (FHitInfo.hitType in NodeHitTests) )) then
  begin
    if (FHitInfo.hitType = htNewRowItem) then
    begin
      if FocusedNode = nil then
        DoBeginNewItemActive;
      if FocusedNode <> nil then
      begin
        OldFocusedColumn := FocusedColumn;
        if FHitInfo.Column <> -1 then
          NewColumn := GetFocusedVisibleIndex(FHitInfo.Column)
        else NewColumn := OldFocusedColumn;
        if NewColumn <> OldFocusedColumn then
          FocusedColumn := NewColumn;
        NewItemRowActive := True;
        FlagEditor := True;
        if (Button = mbLeft) and not IsRowSelect and (FHitInfo.Column <> -1) and
           (PrevNewItemRowActive = FNewItemRowActive) and
           (OldFocusedColumn = NewColumn) and (not FlagFocus) then
        begin
          if FState <> tsEditing then
          if ClickTimerID = -1 then
            ClickTimerID := SetTimer(Handle, 2, GetDoubleClickTime, nil);
        end;
      end;
    end
    else
    begin
      if ((FHitInfo.hitType = htButton) {and not (ssDouble in Shift)}{TODO ? Option}) or
        ((FHitInfo.hitType in NodeHitTests) and (ssDouble in Shift) {and Flag?}) then
      begin
        FreeClickTimer;
        if DblClkExpanding or (FHitInfo.hitType = htButton) then
          FHitInfo.Node.Expanded := not FHitInfo.Node.Expanded; {and Flag?}
        if (ssDouble in Shift) and CanDblClick then DblClick;
        Exit;
      end;

      if (FHitInfo.hitType in NodeHitTests) or (FHitInfo.hitType = htIndicator) then
      begin
        if (Button = mbLeft) and (FHitInfo.hitType <> htIndicator) then
          SetState(tsNodeDown);
        FDragNode := FHitInfo.Node;
        NewItemRowActive := False;

        BeginSelection;
        try
          OldFocusedNode := FocusedNode;
          OldFocusedColumn := FocusedColumn;
          if FHitInfo.Column <> -1 then
            NewColumn := GetFocusedVisibleIndex(FHitInfo.Column)
          else NewColumn := OldFocusedColumn;
          SetFocusedNode(FHitInfo.Node, NewColumn, True);

          FPointDragging.X := X;
          FPointDragging.Y := Y;
if FocusedNode <> nil then     // TODO DB
          if IsMultiSelect then
          begin
            FSelecting := False;
            if (ssCtrl in Shift) or (ssShift in Shift) then
            begin
              BeginSelection;
              try
                FlagCtrl := True;
                if (ssShift in Shift) then
                begin
                  if (SelectionAnchor = nil) or not SelectionAnchor.IsVisible then
                    SelectionAnchor := OldFocusedNode;
                  if not (ssCtrl in Shift) and (SelectionAnchor <> nil) then
                  begin
                    //UnselectNodes
                    ClearSelection;
                    OldFocusedNode := SelectionAnchor;
                  end;
                  if OldFocusedNode <> nil then
                    SelectNodes(OldFocusedNode, FocusedNode)
                  else
                    FocusedNode.Selected := not FocusedNode.Selected;
                  OldFocusedNode := Nil;
                end
                else
                begin
                  FocusedNode.Selected := not FocusedNode.Selected;
                  SelectionAnchor := FocusedNode;
                end;
              finally
                EndSelection;
              end;
              Exit;          
            end
            else
            if not FocusedNode.Selected then
            begin
              BeginSelection;
              try
                ClearSelection;
                FocusedNode.Selected := True;
                SelectionAnchor := FocusedNode;
              finally
                EndSelection;
              end;
            end
            else
            if (Button <> mbRight) then
              FlagSelect := True;
          end;
        finally
          EndSelection;
        end;

        if FHitInfo.hitType <> htIndicator then
          if (Button = mbLeft) and not IsRowSelect and (FHitInfo.Column <> -1) and
            (FHitInfo.hitType = htLabel) then
          begin
            if NeedShowButtonEdit(X, Y, OldFocusedNode = FocusedNode, FocusedAbsoluteIndex) then
            begin
              FState := tsNormal;
              ShowButtonEditorMouse(X, Y);
            end
            else
            if (OldFocusedNode = FocusedNode) and (OldFocusedColumn = FocusedColumn) and
              (not FlagFocus) then
            begin
              if FState <> tsEditing then
              if ClickTimerID = -1 then
                ClickTimerID := SetTimer(Handle, 2, GetDoubleClickTime, nil);
            end;
          end;
      end;
    end;
  end
  else
    if FState = tsEditing then CloseEditor;

  if (Button = mbLeft) and (ssDouble in Shift) and CanDblClick and
    (FHitInfo.hitType in DblClickHitTest) then DblClick;

  if (Button = mbMiddle) and (State = tsNormal) then DoScrolling;

  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TCustomdxTreeList.MouseMove(Shift: TShiftState; X, Y: Integer);

  procedure CheckAndDrawSizingLine(X, Coord1, Coord2: Integer);
  begin
    if X < Coord1 then X := Coord1;
    if X > Coord2 then X := Coord2;
    if (FSizingPos <> X) then
    begin
      DrawSizingLine;
      FSizingPos := X;
      DrawSizingLine;
    end;
  end;

var
  hInfo: TdxTreeListHitInfo;
  Coord1, Coord2, Coord: Integer;
  PrevPushed: Boolean;
  Node: TdxTreeListNode;
  // Mouse Scroll
  HInfoScroll: TdxTreeListHitInfo;
  DrawInfo: TdxGridDrawInfo;
begin
  hInfo := GetHitInfo(Point(X, Y));

  if not (ssLeft in Shift) and (State = tsNodeDown) then
    SetState(tsNormal);

  if (State = tsBandSizing) then
  begin
    GetBandResizeRanges(FHitInfo.Band, X, Coord, Coord1, Coord2);
    CheckAndDrawSizingLine(X, Coord1, Coord2);
  end;

  if (State = tsColumnSizing) then
  begin
    GetHeaderResizeRanges(FHitInfo.Column, X, Coord, Coord1, Coord2);
    CheckAndDrawSizingLine(X, Coord1, Coord2);
  end;

  if (State = tsBandPanelSizing) then
  begin
    GetBandPanelResizeRanges(Y, Coord1, Coord2);
    CheckAndDrawSizingLine(Y, Coord1, Coord2);
  end;

  if (State = tsHeaderPanelSizing) then
  begin
    GetHeaderPanelResizeRanges(Y, Coord1, Coord2);
    CheckAndDrawSizingLine(Y, Coord1, Coord2);
  end;

  if (State = tsRowSizing) then
  begin
    GetRowResizeRanges(FHitInfo.Node, Y, Coord1, Coord2);
    CheckAndDrawSizingLine(Y, Coord1, Coord2);
  end;

  if (State = tsBandDragging) then
    DoBandDragging;

  if (State = tsBandDown) and (FDownBandIndex <> -1) and CanBandDragging(FDownBandIndex) and
    ((X < FPointDragging.X - 5) or (X > FPointDragging.X + 5) or
     (Y < FPointDragging.Y - 5) or (Y > FPointDragging.Y + 5)) then
  begin
    FDragAbsoluteBandIndex := GetAbsoluteBandIndex(FDownBandIndex);
    StartDragBand(FDragAbsoluteBandIndex);
  end;

  if (FState = tsColumnDragging) then
    DoHeaderDragging;

  if (State = tsColumnDown) and (FDownColumnIndex <> -1) and CanHeaderDragging(FDownColumnIndex) and
    ((X < FPointDragging.X - 5) or (X > FPointDragging.X + 5) or
     (Y < FPointDragging.Y - 5) or (Y > FPointDragging.Y + 5)) then
  begin
    FDragAbsoluteHeaderIndex := FDownColumnIndex;
    StartDragHeader(FDragAbsoluteHeaderIndex);
  end;

  if State = tsNodeDown then
  begin
    if (DragMode = dmAutomatic) then
    begin
      if ((X < FPointDragging.X - 5) or (X > FPointDragging.X + 5) or
        (Y < FPointDragging.Y - 5) or (Y > FPointDragging.Y + 5)) then
      begin
        Node := FDragNode;
        if Node = nil then Node := GetNodeAt(X, Y);
        if Node <> nil then
        begin
          if Node <> FocusedNode then
          begin
            if not FlagCtrl then ClearSelection;
            Node.Focused := True;
          end;
          Node.Selected := True;
          FlagCtrl := False;
          FlagSelect := False;
          BeginDrag(False);
        end;
      end;
    end
    else
    if IsMouseScroll and (Count > 0) then
    begin
      CalcRectInfo(DrawInfo);
      if (DrawInfo.CellsRect.Top <= Y) and (Y <= DrawInfo.CellsRect.Bottom) then
      begin
        HInfoScroll := GetHitInfo(Point(DrawInfo.CellsRect.Left, Y));
        if HInfoScroll.Node <> nil then
        begin
          if ScrollNodeTimerID <> -1 then KillTimer(Handle, ScrollNodeTimerID);
          ScrollNodeTimerID := -1;
          HInfoScroll.Node.Focused := True;
          if IsMultiSelect then
          begin
            ClearSelection;
            if FocusedNode <> nil then
              FocusedNode.Selected := True;
          end;
        end
      end
      else
      begin
        ScrollNodeTimerTopFlag := Y < DrawInfo.CellsRect.Top;
        if ScrollNodeTimerTopFlag and not TopVisibleNode.Focused then
          TopVisibleNode.Focused := True
        else
        begin
          HInfoScroll.Node := GetAbsoluteNode(TopIndex + RowCount - 1);
          if not ScrollNodeTimerTopFlag and (HInfoScroll.Node <> nil) and
            not HInfoScroll.Node.Focused then HInfoScroll.Node.Focused := True;
        end;  
        ScrollNodeTimerID := SetTimer(Handle, 1, 60, @MouseScrollTimerProc);
      end;
    end;
  end;

  if (State = tsBandDown) and (FDownBandIndex <> -1) then
  begin
    PrevPushed := FDownBandPushed;
    if (hInfo.hitType = htBand) and (hInfo.Band = FDownBandIndex) then
      FDownBandPushed := True
    else FDownBandPushed := False;
    if FDownBandPushed <> PrevPushed then
      InvalidateBand(FDownBandIndex);
  end;

  if (State = tsDropDownButtonDown) and (FDropDownButtonColumnIndex <> -1) then
  begin
    PrevPushed := FDropDownButtonColumnPushed;
    if (hInfo.hitType = htColumn) and (hInfo.Column = FDropDownButtonColumnIndex) and
      (FHotTrackInfo.HeaderHotTrack = hhtDropDownButton) then
      FDropDownButtonColumnPushed := True
    else
      FDropDownButtonColumnPushed := False;
    if FDropDownButtonColumnPushed <> PrevPushed then
      InvalidateColumn(FDropDownButtonColumnIndex);
  end;

  if (State = tsColumnDown) and (FDownColumnIndex <> -1) then
  begin
    PrevPushed := FDownColumnPushed;
    if (hInfo.hitType = htColumn) and (hInfo.Column = FDownColumnIndex) then
       FDownColumnPushed := True
    else FDownColumnPushed := False;
    if FDownColumnPushed <> PrevPushed then
      InvalidateColumn(FDownColumnIndex);
  end;

  if (State = tsBandButtonDown) then
  begin
    PrevPushed := FBandButtonPushed;
    if (hInfo.hitType = htBandButton) then
      FBandButtonPushed := True
    else FBandButtonPushed := False;
    if FBandButtonPushed <> PrevPushed then
      InvalidateBandButton;
  end;

  if (State = tsHeaderButtonDown) then
  begin
    PrevPushed := FHeaderButtonPushed;
    if (hInfo.hitType = htHeaderButton) then
      FHeaderButtonPushed := True
    else FHeaderButtonPushed := False;
    if FHeaderButtonPushed <> PrevPushed then
      InvalidateHeaderButton;
  end;

  CheckHotTrackNode(hInfo);

  inherited MouseMove(Shift, X, Y);
end;

procedure TCustomdxTreeList.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Coord1, Coord2, Coord: Integer;
  OldDownIndex: Integer;
  hInfo : TdxTreeListHitInfo;
  FlagClick : Boolean;
begin
  BeginSelection;
  try
    hInfo := GetHitInfo(Point(X, Y));

    if (FState = tsBandSizing) then
    begin
      DrawSizingLine;
      if FHitInfo.Band <> -1 then
      begin
        GetBandResizeRanges(FHitInfo.Band, FSizingPos, Coord, Coord1, Coord2);
        if FSizingPos < Coord1 then FSizingPos := Coord1;
        if FSizingPos > Coord2 then FSizingPos := Coord2;
      end;
      if FPrevSizingPos <> FSizingPos then
      begin
        if not IsAutoWidth then
          ScaledBandHeaderWidth(FHitInfo.Band, FSizingPos - Coord + 2)
        else ChangedBandAutoWidth(FHitInfo.Band, FSizingPos - Coord + 2);
        DoChangedColumnsWidth;
      end;
      SetState(tsNormal);
    end;

    if (FState = tsColumnSizing) then
    begin
      DrawSizingLine;
      if FHitInfo.Column <> -1 then
      begin
        GetHeaderResizeRanges(FHitInfo.Column, FSizingPos, Coord, Coord1, Coord2);
        if FSizingPos < Coord1 then FSizingPos := Coord1;
        if FSizingPos > Coord2 then FSizingPos := Coord2;
      end;
      if FPrevSizingPos <> FSizingPos then
      begin
        if IsBandHeaderWidth and not IsAutoWidth and (GetHeaderRowCount(FHitInfo.Band) <= 1) then
          ScaledHeaderBandWidth(FHitInfo.Band, FHitInfo.Column, FSizingPos - Coord + 1)
        else ChangedHeaderAutoWidth(FHitInfo.Band, FHitInfo.Column, FSizingPos - Coord + 1);
        DoChangedColumnsWidth;
      end;
      SetState(tsNormal);
    end;

    if (FState = tsBandPanelSizing) then
    begin
      DrawSizingLine;
      ChangedBandRowCount(CalcBandPanelRowCount(FSizingPos));
      SetState(tsNormal);
    end;

    if (FState = tsRowSizing) then
    begin
      DrawSizingLine;
      if (FPrevSizingPos <> FSizingPos) and (FHitInfo.Node <> nil) then
        ChangedRowHeight(CalcNearestRowHeight(FHitInfo.Node,
          FSizingPos - GetRectNode(FHitInfo.Node).Top));
      SetState(tsNormal);
    end;

    if (FState = tsHeaderPanelSizing) then
    begin
      DrawSizingLine;
      ChangedHeaderMaxRowCount(CalcHeaderPanelRowCount(FSizingPos));
      SetState(tsNormal);
    end;

    if State = tsBandDown then
    begin
      OldDownIndex := FDownBandIndex;
      CancelDragSizing;
      if (hInfo.hitType = htBand) and (hInfo.Band = OldDownIndex) then
        DoBandClick(OldDownIndex);
    end;

    if (State = tsBandDragging) then
      EndDragBand(True);

    if State = tsDropDownButtonDown then
    begin
      OldDownIndex := FDropDownButtonColumnIndex;
      CancelDragSizing;
      if (hInfo.hitType = htColumn) and (hInfo.Column = OldDownIndex) and
        (FHotTrackInfo.HeaderHotTrack = hhtDropDownButton) and
        not (csDesigning in ComponentState) then
      begin
        FDropDownButtonColumnIndex := OldDownIndex;
        try
          DoHeaderDropDownButtonClick(OldDownIndex);
        finally
          FDropDownButtonColumnIndex := -1;
        end;
      end;
    end;

    if State = tsStatusCloseButtonDown then
    begin
      CancelDragSizing;
      if FStatusCloseButtonActive then
        DoStatusCloseButtonClick;
    end;

    if State = tsColumnDown then
    begin
      OldDownIndex := FDownColumnIndex;
      CancelDragSizing;
      if (hInfo.hitType = htColumn) and (hInfo.Column = OldDownIndex) then
      begin
        FlagMultiSort := IsMultiSort and (ssShift in Shift);
        FlagClearSort := (ssCtrl in Shift);
        try
          DoHeaderClick(OldDownIndex);
        finally
          FlagClearSort := False;
          FlagMultiSort := False;
        end;
      end;
    end;

    if (State = tsColumnDragging) then
      EndDragHeader(True);

    if (State = tsBandButtonDown) then
    begin
      if FBandButtonPushed then OldDownIndex := 1
      else OldDownIndex := -1;
      CancelDragSizing;
      if OldDownIndex <> -1 then
        DoBandButtonClick;
    end;

    if (State = tsHeaderButtonDown) then
    begin
      if FHeaderButtonPushed then OldDownIndex := 1
      else OldDownIndex := -1;
      CancelDragSizing;
      if OldDownIndex <> -1 then
        DoHeaderButtonClick;
    end;

    if FlagSelect then
    begin
      ClearSelection;
      FocusedNode.Selected := True;
      SelectionAnchor := FocusedNode;
      FlagSelect := False;
    end;

    if FState in [tsEditing, tsNodeDragging, tsNodeDown] then
      FlagClick := True
    else FlagClick := False;
    if (FlagClick or FlagEditor) and IsImmediateEditor and
      not IsRowSelect and (hInfo.Column <> -1) and (FHitInfo.Column = hInfo.Column) and
     (FHitInfo.Row = hInfo.Row) and (FHitInfo.hitType = hInfo.hitType) and
     (hInfo.hitType in [htLabel, htNewRowItem]) and (Button = mbLeft) and
     ((hInfo.Node = FocusedNode) or (FHitInfo.hitType = htNewRowItem))then
    begin
      FState := tsNormal;
      if not (ssShift in Shift) and not (ssCtrl in Shift) then ShowEditorMouse(X, Y);
    end;
    FlagEditor := False;

    if State = tsNodeDown then
      SetState(tsNormal);

    if FlagClick then Click;

    inherited MouseUp(Button, Shift, X, Y);
  finally
    EndSelection;
  end;
end;

procedure TCustomdxTreeList.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = Images then Images := nil;
    if AComponent = StateImages then StateImages := nil;
  end;
end;

procedure TCustomdxTreeList.Paint;
type
  TBrushInfo = record
    Brush: HBRUSH;
    Color: TColor;
  end;
  PBrushesInfo = ^TBrushesInfo;
  TBrushesInfo = array [0..dxGridMaxDrawItems - 1] of TBrushInfo;
var
  DrawInfo: TdxGridDrawInfo;
  BandBrush: HBRUSH;
  HeaderBrush: HBRUSH;
  GroupBrush: HBRUSH;
  BackgroundBrush: HBRUSH;
  PanelBrush: HBRUSH;
  HighlightBrush: HBRUSH;
  TreeLineBrush: HBRUSH;
  HideSelectionBrush: HBRUSH;
  LevelBrush: HBRUSH;
  FooterBrush: HBRUSH;
  FixedBandLineBrush: HBRUSH;
  // clip region
  FlagClip, FlagRgn, IsClipRgnExists: Boolean;
  Rgn, PrevClipRgn: HRGN;
  PBrushes: PBrushesInfo;
  BrushIndex: Integer;
  // New
  ACellBkColor: TColor;
  ACellBkBrush: HBRUSH;
  APanelBrushColor: TColor;

  function GetLookAndFeelStyle: TdxLookAndFeel;
  begin
    Result := LookAndFeel;
    if Result = lfUltraFlat then
      Result := lfFlat;
  end;

  function GetLevelBrush(ALevel: Integer; var AColor: TColor): HBRUSH;
  begin
    Result := GroupBrush;
    if AssignedLevelColorEvent then
    begin
      DoGetLevelColor(ALevel, AColor);
      if AColor <> FGroupColor then
      begin
        if LevelBrush <> 0 then DeleteObject(LevelBrush);
        LevelBrush := CreateSolidBrush(ColorToRGB(AColor));
        Result := LevelBrush;
      end;
    end;
  end;

  procedure GetBkBrush(Node: TdxTreeListNode; ASelected, AFocused, AGroup, AHasChildren: Boolean;
    ALevel, AIndex: Integer; var AColor, ATextColor: TColor; var ABrush: HBRUSH);
  begin
    if not AFocused and (FDragObject <> nil) and (Node <> nil) and Node.Focused then
    begin
      AColor := FHighlightColor; //clHighlight;
      ATextColor := FHighlightTextColor; //clHighlightText;
      ABrush := HighlightBrush;
    end
    else
    if ASelected and not (HideSelection and not AFocused) then
    begin
      if AFocused then
      begin
        AColor := FHighlightColor; //clHighlight;
        ATextColor := FHighlightTextColor; //clHighlightText;
        ABrush := HighlightBrush;
      end
      else
      begin
        AColor := HideSelectionColor;
        ATextColor := HideSelectionTextColor;
        ABrush := HideSelectionBrush;
      end;
    end
    else
    begin
      if not FPaintStandard and (AGroup or AHasChildren) then
      begin
        AColor := FGroupColor;
        if FGroupTextColor <> clNone then
          ATextColor := FGroupTextColor
        else ATextColor := Self.Font.Color;
        ABrush := GetLevelBrush(ALevel, AColor);
      end
      else
      begin
        if (AIndex <> -1) and (IsExistColumnFont(DrawInfo.HeadersInfo^[AIndex].AbsoluteIndex)) then
          ATextColor := GetColumnFont(DrawInfo.HeadersInfo^[AIndex].AbsoluteIndex).Color
        else ATextColor := Self.Font.Color;
        if ((not ASelected) or (HideSelection and not AFocused)) and
          (AIndex <> -1) and (PBrushes^[AIndex].Brush <> 0) then
        begin
          AColor := PBrushes^[AIndex].Color;
          ABrush := PBrushes^[AIndex].Brush;
        end
        else
        begin
          ABrush := BackgroundBrush;
          AColor := Self.Color;
        end;
      end;
    end;
  end;

  procedure GetCellBkBrush(AIndex: Integer; var AColor: TColor; var ABrush: HBRUSH);
  begin
    if (AIndex <> -1) and (PBrushes^[AIndex].Brush <> 0) then
    begin
      AColor := PBrushes^[AIndex].Color;
      ABrush := PBrushes^[AIndex].Brush;
    end
    else
    begin
      ABrush := BackgroundBrush;
      AColor := Self.Color;
    end;
  end;

  procedure SaveRegion(const AClipRect: TRect);
  begin
    PrevClipRgn := CreateRectRgn(0, 0, 0, 0);
    IsClipRgnExists := GetClipRgn(Canvas.Handle, PrevClipRgn) = 1;
    Rgn := CreateRectRgnIndirect(AClipRect);
    if IsClipRgnExists then
      CombineRgn(Rgn, PrevClipRgn, Rgn, RGN_AND);
    SelectClipRgn(Canvas.Handle, Rgn);
    DeleteObject(Rgn);
    FlagRgn := True;
  end;

  procedure RestoreRegion;
  begin
    if not FlagRgn then Exit;
    if IsClipRgnExists then
      SelectClipRgn(Canvas.Handle, PrevClipRgn)
    else SelectClipRgn(Canvas.Handle, 0);
    DeleteObject(PrevClipRgn);
    FlagRgn := False;
  end;

  procedure SetPoints(P: PIntArray; Index: Integer; X1, Y1, X2, Y2: Integer);
  begin
    Index := Index * 4;
    P^[Index] := X1;
    P^[Index + 1] := Y1;
    P^[Index + 2] := X2;
    P^[Index + 3] := Y2;
  end;

  procedure DrawGrPanel;
  begin
    with Canvas, DrawInfo do
      if RectVisible(Handle, GroupPanelRect) then
      begin
        DrawGroupPanel(Canvas, GroupPanelRect, HeaderBrush, PanelBrush);
      end;
  end;

  procedure DrawFooterFrame(ADC: HDC; ARect: TRect);
  begin
    if LookAndFeel = lfUltraFlat then
      FrameRect(ADC, ARect, GetSysColorBrush(COLOR_BTNSHADOW))
    else
      DrawEdge(ADC, ARect, BDR_SUNKENOUTER, BF_RECT);
  end;

  procedure DrawCaptionButton(ADC: HDC; var ARect: TRect; ABrush: HBRUSH;
    ADown: Boolean; ALookAndFeel: TdxLookAndFeel);
  begin
    if LookAndFeel = lfUltraFlat then
    begin
      DrawEdge(ADC, ARect, BDR_SUNKENOUTER, BF_TOP or BF_BOTTOM or BF_RIGHT or BF_FLAT or BF_ADJUST);
      FillRect(ADC, ARect, ABrush);
      if ADown then
        with ARect do
          BitBlt(ADC, Left, Top, Right - Left, Bottom - Top, 0, 0, 0, DSTINVERT);
    end
    else
      DrawBandButtonEx(ADC, ARect, ABrush, ADown, hbNormal, ALookAndFeel);
  end;

  procedure DrawBands;
  var
    S: string;
    R, RClip: TRect;
    i, BIndex: Integer;
    ExistEvent, Done: Boolean;
    AAlignment: TAlignment;
    AColor: TColor;
    AFont: TFont;
    Br: HBRUSH;
    // clip rect
    IsClipRgnExists: Boolean;
    PrevRgn, Rgn: HRGN;
  begin
    with Canvas, DrawInfo do
    begin
      // draw band button
      if RectVisible(Handle, BandButtonRect) then
        DrawCaptionButton(Handle, BandButtonRect, BandBrush, FBandButtonPushed{Down}, LookAndFeel{GetLookAndFeelStyle});
//        DrawBandButtonEx(Handle, BandButtonRect, BandBrush, FBandButtonPushed{Down}, hbNormal,
//          LookAndFeel{GetLookAndFeelStyle});
      // draw bands
      if RectVisible(Handle, BandRect) then
      begin
        if BandsInfo <> nil then
        begin
          Font.Assign(BandFont);
          SetTextColor(Handle, ColorToRGB(BandFont.Color));
          for i := 0 to BandCount - 1 do
          begin
            BIndex := BandsInfo^[i].Index;
            S := GetBandText(BIndex);
            AAlignment := GetBandAlignment(BIndex);
            R := BandsInfo^[i].BandRect;
            RClip := BandsInfo^[i].BandClipRect;
            Br := BandBrush;
            Done := False;
            // begin custom draw
            ExistEvent := AssignedDrawBandEvent(BIndex);
            if ExistEvent then
            begin
              FSaveFont.Assign(Font);
              AColor := BandColor;
              AFont := Canvas.Font;
              // set clip rect
              IsClipRgnExists := False;
              PrevRgn := 0;
              Rgn := 0;
              if not EqualRect(R, RCLip) then
              begin
                PrevRgn := CreateRectRgn(0, 0, 0, 0);
                IsClipRgnExists := GetClipRgn(Handle, PrevRgn) = 1;
                Rgn := CreateRectRgnIndirect(RClip);
                SelectClipRgn(Handle, Rgn)
              end;
              DoDrawBand(BIndex, Canvas, R, RClip, S, AColor, AFont, AAlignment, Done);
              if not Done then
              begin
                if ColorToRGB(AColor) <> ColorToRGB(BandColor) then
                begin
                  Brush.Color := AColor;
                  Br := Brush.Handle;
                end;
              end;
              // restore prev clip recct
              if PrevRgn <> 0 then
              begin
                if IsClipRgnExists then
                  SelectClipRgn(Handle, PrevRgn)
                else SelectClipRgn(Handle, 0);
                DeleteObject(PrevRgn);
              end;
              if Rgn <> 0 then DeleteObject(Rgn);
            end;
            if not Done then
              DrawBandEx(Handle, R, RClip, Br, DrawBitmap, S,
                FDownBandPushed and (FDownBandIndex = BIndex){ADown}, (FBandRowCount > 1){AMultiLine},
                AAlignment, csNone{no sorted}, nil {no glyph}, hbNormal,
                LookAndFeel{GetLookAndFeelStyle}, []{TODO Ultra});
            // end custom draw
            if ExistEvent then
              Font.Assign(FSaveFont);
          end;
        end;
      end;
      // draw fixed lines
      if not IsRectEmpty(FixedBandLeftRect) and RectVisible(Handle, FixedBandLeftRect) then
      begin
        with FixedBandLeftRect do
          R := Rect(Right - FFixedBandLineWidth, Top, Right, Bottom);
        Windows.FillRect(Handle, R, FixedBandLineBrush{GetSysColorBrush(COLOR_WINDOWFRAME)});
      end;
      if not IsRectEmpty(FixedBandRightRect)and RectVisible(Handle, FixedBandRightRect) then
      begin
        with FixedBandRightRect do
          R := Rect(Left, Top, Left + FFixedBandLineWidth, Bottom);
        Windows.FillRect(Handle, R, FixedBandLineBrush{GetSysColorBrush(COLOR_WINDOWFRAME)});
      end;
    end;
  end;

  procedure DrawHeaders;
  var
    S: string;
    R, RClip: TRect;
    I: Integer;
    ExistEvent, Done: Boolean;
    AAlignment: TAlignment;
    AColor: TColor;
    AFont: TFont;
    AGlyph: TBitmap;
    ASorted: TdxTreeListColumnSort;
    ADropDownButtonState: TdxHeaderDropDownButtonState;
    Br: HBRUSH;
    ButtonStyle: TdxHeaderButtonStyle;
    // clip rect
    IsClipRgnExists: Boolean;
    PrevRgn, Rgn: HRGN;
  begin
    with Canvas, DrawInfo do
    begin
      // draw header button
      if RectVisible(Handle, HeaderButtonRect) then
        DrawCaptionButton(Handle, HeaderButtonRect, HeaderBrush, FHeaderButtonPushed{Down}, LookAndFeel{GetLookAndFeelStyle});
      // draw headers
      if RectVisible(Handle, HeaderRect) then
      begin
        if HeadersInfo <> nil then
        begin
          Font.Assign(HeaderFont);
          SetTextColor(Handle, ColorToRGB(HeaderFont.Color));
          for I := 0 to HeaderCount - 1 do
          with HeadersInfo^[I] do
          begin
            AAlignment := GetHeaderAlignment(AbsoluteIndex);
            if IsExistHeaderGlyph(AbsoluteIndex) then
              AGlyph := GetHeaderGlyph(AbsoluteIndex)
            else AGlyph := nil;
            S := GetHeaderText(AbsoluteIndex);
            ASorted := GetHeaderSorted(AbsoluteIndex);
            R := HeaderRect;
            RClip := HeaderClipRect;
            Br := HeaderBrush;
            ADropDownButtonState := GetHeaderDropDownButtonState(AbsoluteIndex);
            Done := False;
            // begin custom draw
            ExistEvent := AssignedDrawHeaderEvent(AbsoluteIndex);
            if ExistEvent then
            begin
              FSaveFont.Assign(Font);
              AColor := HeaderColor;
              AFont := Canvas.Font;
              // set clip rect
              IsClipRgnExists := False;
              PrevRgn := 0;
              Rgn := 0;
              if not EqualRect(R, RCLip) then
              begin
                PrevRgn := CreateRectRgn(0, 0, 0, 0);
                IsClipRgnExists := GetClipRgn(Handle, PrevRgn) = 1;
                Rgn := CreateRectRgnIndirect(RClip);
                SelectClipRgn(Handle, Rgn)
              end;
              DoDrawHeader(AbsoluteIndex, Canvas, R, RClip, S, AColor, AFont, AAlignment, ASorted, Done);
              if not Done then
              begin
                if ColorToRGB(AColor) <> ColorToRGB(HeaderColor) then
                begin
                  Brush.Color := AColor;
                  Br := Brush.Handle;
                end;
              end;
              // restore prev clip recct
              if PrevRgn <> 0 then
              begin
                if IsClipRgnExists then
                  SelectClipRgn(Handle, PrevRgn)
                else SelectClipRgn(Handle, 0);
                DeleteObject(PrevRgn);
              end;
              if Rgn <> 0 then DeleteObject(Rgn);
            end;
            if not Done then
            begin
              ButtonStyle := hbNormal;
              if True {Options} and not ((FirstColumn = LastColumn) and FirstColumn) then
              begin
                if FirstColumn then
                  ButtonStyle := hbRight
                else
                if LastColumn then
                  ButtonStyle := hbLeft
                else ButtonStyle := hbLeftRight;
              end;
              DrawBandEx(Handle, R, RClip, Br,
                DrawBitmap, S, FDownColumnPushed and (FDownColumnIndex = AbsoluteIndex){ADown},
                (LineCount > 1) or (FHeaderLineCount > 1){AMultiLine}, AAlignment, ASorted,
                AGlyph, ButtonStyle, LookAndFeel, ADropDownButtonState);
            end;
            if not IsRectEmpty(HeaderEmptyRect) then
              Windows.FillRect(Handle, HeaderEmptyRect, PanelBrush);
            // end custom draw
            if ExistEvent then
              Font.Assign(FSaveFont);
          end;
        end;
        // Empty Headers
        if EmptyRectsInfo <> nil then
        begin
          for I := 0 to EmptyRectCount - 1 do
          with EmptyRectsInfo^[I] do
            if not IsRectEmpty(EmptyRect) then
              Windows.FillRect(Handle, EmptyRect, PanelBrush);
        end;
      end;
    end;
  end;

  procedure DrawNewItemRow;
  var
    R, R1, RClip: TRect;
    i: Integer;
    Points, Strokes: PIntArray;
    MaxLines, LinesCount: Integer;
    Br: HBRUSH;
    AColor, ATextColor: TColor;
    IsFocused, ASelected: Boolean;
  begin
    with Canvas, DrawInfo do
    begin
      if RectVisible(Handle, NewItemRowRect) then
      begin
        // draw separator
        R := Rect(CellsRect.Left, NewItemRowRect.Bottom - FNewItemRowSeparatorHeight,
          CellsRect.Left + GetBandTotalWidth, NewItemRowRect.Bottom);
        OffsetRect(R, -LeftCoord, 0);
        if not IsRectEmptyEx(FixedBandLeftRect) then
          R.Left := CellsRect.Left;
        if not IsRectEmptyEx(FixedBandRightRect) and (R.Right > CellsRect.Right) then
          R.Right := CellsRect.Right;
        RClip := Rect(CellsRect.Left, NewItemRowRect.Top, CellsRect.Right, NewItemRowRect.Bottom);
        SaveRegion(RClip);
        DrawBandButton(Handle, R, HeaderBrush, False{Down}, hbNormal, GetLookAndFeelStyle);
        RestoreRegion;
        // draw indicator
        if FIndicatorWidth > 0 then
        begin
          R1 := Rect(NewItemRowRect.Left, NewItemRowRect.Top,
            NewItemRowRect.Left + FIndicatorWidth, NewItemRowRect.Bottom);
          DrawIndicatorEx(Handle, R1, R1, HeaderBrush, DrawBitmap, ikInsert, LookAndFeel {GetLookAndFeelStyle}); // TODO
        end;
        // draw cells
        MaxLines := 1;
        if FShowGrid and FShowPreviewGrid then
          Inc(MaxLines, HeaderCount * 2 + EmptyRectCount);
        // grid lines memory allocating
        Points := AllocMem(MaxLines * SizeOf(TPoint) * 2);
        Strokes := AllocMem(MaxLines * SizeOf(Integer));
        for i := 0 to MaxLines - 1 do Strokes^[i] := 2;
        LinesCount := 0;
        try
          FlagClip := ((not IsRectEmptyEx(FixedBandLeftRect)) or
            (not IsRectEmptyEx(FixedBandRightRect)) or (LeftCoord <> 0 )) and
            ((CellsRect.Right - CellsRect.Left) < GetBandTotalWidth);
          RClip := Rect(CellsRect.Left, NewItemRowRect.Top,
            CellsRect.Right, NewItemRowRect.Top + FRowHeight);
          if not IsRectEmptyEx(FixedBandLeftRect) then
            RClip.Left := FixedBandLeftRect.Right
          else
          begin
            Dec(RClip.Left, LeftCoord);
            if RClip.Left < CellsRect.Left then
              RClip.Left := CellsRect.Left;
          end;
          if not IsRectEmptyEx(FixedBandRightRect) then
            RClip.Right := FixedBandRightRect.Left;
          // set Font
          Font.Assign(Self.Font);
          IsFocused := IsActiveControl or
            ((State = tsEditing) and (InplaceEditor <> nil) and (InplaceEditor.IsFocused));
          for i := 0 to HeaderCount - 1 do
          with HeadersInfo^[i] do
          begin
            if FlagClip then // set clip region
            begin
              if not ((BandIndex = FixedBandLeftIndex) or
                 (BandIndex = FixedBandRightIndex)) and not FlagRgn then // set region
                SaveRegion(RClip)
              else
              if FlagRgn and ((BandIndex = FixedBandLeftIndex) or
                 (BandIndex = FixedBandRightIndex)) then // restore prev rgn
                RestoreRegion;
            end;
            R := Rect(HeaderRect.Left, NewItemRowRect.Top, HeaderRect.Right,
              NewItemRowRect.Top + FRowHeight - Byte(FShowGrid and FShowPreviewGrid));
            if not (((BandIndex = FixedBandLeftIndex) or (BandIndex = FixedBandPrevRightIndex))
              and LastColumn) then Dec(R.Right, Byte(FShowGrid and FShowPreviewGrid));
            if FShowGrid and not FShowPreviewGrid and LastColumn then
            begin
              if (BandCount > 1) and (BandIndex = BandsInfo^[BandCount - 1].Index) or
                (BandCount = 1) then Dec(R.Right, 1{SizeGrid});
            end;

            ASelected := IsNewItemRowActive and (IsRowSelect or (IsMultiSelect and not IsInvertSelect) or
                       ((FocusedAbsoluteIndex = AbsoluteIndex) and not IsInvertSelect) or
                       ((FocusedAbsoluteIndex <> AbsoluteIndex) and IsInvertSelect));
            if ASelected and HideSelection and not IsFocused then ASelected := False; // TODO ?

            // TODO PAINT1
            GetBkBrush(FocusedNode, ASelected, IsFocused, False, False, 0, I, AColor, ATextColor, Br);
            GetCellBkBrush(I, ACellBkColor, ACellBkBrush);

            DrawCellEx(Canvas, R, DrawBitmap, FocusedNode, AbsoluteIndex, ASelected, False{Focused TODO},
              AColor, ATextColor, Br, MultiLine, ckNewItemRow, LeftEdgeColumn, RightEdgeColumn,
              ACellBkColor, ACellBkBrush);

            // Draw Focus
            if ASelected and not (IsRowSelect or IsInvertSelect) and (FocusedAbsoluteIndex = AbsoluteIndex) and
              ((IsFocused and not HideDrawFocusRect) or (not IsFocused and not HideFocusRect)) then
              if IsFocused then
                DrawFocused(Handle, R)
              else if (FDragObject = nil) then DrawFramed(Handle, R);
            // grid horz line
            if FShowGrid and FShowPreviewGrid then
            begin
              SetPoints(Points, LinesCount,
                R.Left, R.Bottom, R.Right, R.Bottom);
              if FlagRgn then
              begin
                if (Points^[LinesCount * 4] < RClip.Left) then
                  Points^[LinesCount * 4] := RClip.Left;
                if (Points^[LinesCount * 4 + 2] > RClip.Right) then
                  Points^[LinesCount * 4 + 2] := RClip.Right;
              end;
              Inc(LinesCount);
            end;
            // grid vert line
            if FShowGrid and FShowPreviewGrid and not (((BandIndex = FixedBandLeftIndex) or
              (BandIndex = FixedBandPrevRightIndex)) and LastColumn) then
            begin
              if not (FlagRgn and ((R.Right < RClip.Left) or (R.Right > RClip.Right))) then
              begin
                SetPoints(Points, LinesCount,
                  R.Right, R.Top, R.Right, R.Bottom + 1);
                Inc(LinesCount);
              end;
            end;
          end;
          // Draw Focus - if RowSelect
          if IsNewItemRowActive and (IsRowSelect or IsInvertSelect) and ((IsFocused and not HideDrawFocusRect) or
            not IsFocused and not HideFocusRect) then
          begin
            R := Rect(CellsRect.Left, NewItemRowRect.Top, CellsRect.Left + GetBandTotalWidth - Byte(FShowGrid),
              NewItemRowRect.Top + FRowHeight - Byte(FShowGrid and FShowPreviewGrid));
            if IsRectEmptyEx(FixedBandLeftRect) then
              OffsetRect(R, - LeftCoord, 0);
            if not IsRectEmptyEx(FixedBandRightRect) then
              if R.Right > CellsRect.Right - Byte(FShowGrid) then
                R.Right := CellsRect.Right - Byte(FShowGrid);
            if IsFocused then
              DrawFocused(Handle, R)
            else
              if (FDragObject = nil) then DrawFramed(Handle, R);
          end;
          // vert right line
          if FShowGrid then
          begin
            SetPoints(Points, LinesCount,
              EdgeX, NewItemRowRect.Top, EdgeX, NewItemRowRect.Top + FRowHeight);
            Inc(LinesCount);
          end;
          // restore prev rgn
          if FlagRgn then RestoreRegion;
          // Empty Headers
          if EmptyRectsInfo <> nil then
          begin
            for i := 0 to EmptyRectCount - 1 do
            with EmptyRectsInfo^[i] do
            begin
              R := Rect(EmptyRect.Left, NewItemRowRect.Top, EmptyRect.Right,
                NewItemRowRect.Top + FRowHeight);
              // grid vert line
              if FShowGrid and FShowPreviewGrid and not ((BandIndex = FixedBandLeftIndex) or
                (BandIndex = FixedBandPrevRightIndex)) then
              begin
                if not ((R.Right < RClip.Left) or (R.Right > RClip.Right)) and not ClippingFlag then
//                  (BandsInfo^[BandIndex].BandRect.Right <= BandsInfo^[BandIndex].BandClipRect.Right) then
                begin
                  SetPoints(Points, LinesCount,
                    R.Right - 1, R.Top, R.Right - 1, R.Bottom);
                  Inc(LinesCount);
                  Dec(R.Right);
                end;
              end;
              if not IsRectEmpty(R) then
                Windows.FillRect(Handle, R, BackgroundBrush);
            end;
          end;
          // draw grid
          if FShowGrid then
          begin
            Canvas.Pen.Color := GetGridColor(Self.Color); //clBtnShadow
            PolypolyLine(Canvas.Handle, Points^, Strokes^,  LinesCount);
          end;
        finally
          FreeMem(Strokes);
          FreeMem(Points);
        end;
      end;
    end;
  end;

  procedure DrawIndicator;
  var
    i, Y: Integer;
    R1, R2: TRect;
  begin
    with Canvas, DrawInfo do
    begin
      if RectVisible(Handle, IndicatorRect) and (RowsInfo <> nil) then
      begin
        Y := CellsRect.Top;
        for i := 0 to RowCount - 1 do
        with RowsInfo^[i] do
        begin
          R1 := Rect(IndicatorRect.Left, Y, IndicatorRect.Right, Y + RowHeight);
          R2 := R1;
          if not IsRectEmpty(FooterRect) then
            if R2.Bottom > FooterRect.Top then
              R2.Bottom := FooterRect.Top;
          DrawIndicatorEx(Handle, R1, R2, HeaderBrush, DrawBitmap, IndicatorKind, LookAndFeel {GetLookAndFeelStyle}); // TODO
          Inc(Y, RowHeight);
        end;
        with IndicatorRect do
          ExcludeClipRect(Handle, Left, Top, Right, Bottom);
      end;
    end;
  end;

  procedure DrawFooter;
  var
    R, RClip: TRect;
    i, X, Ind, H, YTop: Integer;
  begin
    with Canvas, DrawInfo do
    begin
      if RectVisible(Handle, FooterRect) then
      begin
        // draw frame
        R := FooterRect;
        if IsRectEmptyEx(FixedBandLeftRect) and (LeftCoord <> 0) then
          Dec(R.Left, Byte(not FFlat) + 1);
        if IsRectEmptyEx(FixedBandRightRect) and
          (CellsRect.Left + GetBandTotalWidth - LeftCoord > R.Right)  then
          Inc(R.Right, Byte(not FFlat) + 1);
        if not FFlat then
        begin
          Windows.FrameRect(Handle, R, GetSysColorBrush(COLOR_WINDOWFRAME));
          InflateRect(R, -1, -1);
          Dec(R.Left);
          DrawEdge(Handle, R, BDR_RAISEDINNER, BF_RECT);
        end
        else
        begin
          DrawEdge(Handle, R, BDR_SUNKENOUTER, BF_TOP);
          Inc(R.Top);
          if LookAndFeel = lfUltraFlat then
            Windows.FillRect(Handle, R, HeaderBrush)
          else
            DrawEdge(Handle, R, BDR_RAISEDINNER, BF_RECT);
        end;
        InflateRect(R, -1, -1);
        Windows.FillRect(Handle, R, HeaderBrush);
        YTop := R.Top;
        // draw footer cells
        try
          FlagClip := ((not IsRectEmptyEx(FixedBandLeftRect)) or
            (not IsRectEmptyEx(FixedBandRightRect)) or (LeftCoord <> 0 )) and
            ((CellsRect.Right - CellsRect.Left) < GetBandTotalWidth);
          RClip := Rect(CellsRect.Left, FooterRect.Top,
            CellsRect.Right, FooterRect.Bottom);
          if not IsRectEmptyEx(FixedBandLeftRect) then
            RClip.Left := FixedBandLeftRect.Right
          else
          begin
            Dec(RClip.Left, LeftCoord);
            if RClip.Left < CellsRect.Left - FIndicatorWidth then
              RClip.Left := CellsRect.Left - FIndicatorWidth;
          end;
          if not IsRectEmptyEx(FixedBandRightRect) then
            RClip.Right := FixedBandRightRect.Left;
          FlagRgn := False;
          // set Font
          Font.Assign(Self.Font);
//          SetTextColor(Handle, ColorToRGB(Self.Font.Color));
          for i := 0 to HeaderCount - 1 do
          with HeadersInfo^[i] do
          begin
            if FlagClip then // set clip region
            begin
              if not ((BandIndex = FixedBandLeftIndex) or
                 (BandIndex = FixedBandRightIndex)) and not FlagRgn then // set region
                SaveRegion(RClip)
              else
              if FlagRgn and ((BandIndex = FixedBandLeftIndex) or
                 (BandIndex = FixedBandRightIndex)) then // restore prev rgn
                RestoreRegion;
            end;
            X := HeaderRect.Left;
            if IsRectEmptyEx(FixedBandLeftRect) then
              Inc(X, LeftCoord);
            if (BandIndex = 0) and (X < CellsRect.Left) then
              Ind := CellsRect.Left - X
            else Ind := 0;
            H := LineCount * FFooterRowHeight;
            if HeaderRect.Right > (HeaderRect.Left + Ind) then // if Visible
            begin
              R := Rect(HeaderRect.Left + Ind, YTop + FFooterRowHeight * RowIndex,
                HeaderRect.Right, YTop + FFooterRowHeight * RowIndex + H);
              InflateRect(R, -1, -1);
              if (BandIndex = 0) and (ColIndex = 0) then
                Inc(R.Left);
              if LastColumn and (BandIndex = BandsInfo^[BandCount - 1].Index) then
                Dec(R.Right, 2);
              if IsExistFooterCell(AbsoluteIndex) then
              begin
                DrawFooterFrame(Canvas.Handle, R);
//                DrawEdge(Canvas.Handle, R, BDR_SUNKENOUTER, BF_RECT);
// TODO REMOVE
//                Windows.FrameRect(Canvas.Handle, R, GetSysColorBrush(COLOR_BTNSHADOW));

                InflateRect(R, -1, -1);
                SetBkColor(Canvas.Handle, ColorToRGB(HeaderColor));
                SetTextColor(Canvas.Handle, ColorToRGB(Self.Font.Color));
                DrawCell(Canvas, R, DrawBitmap, nil{footer}, AbsoluteIndex, -1, False, False,
                  HeaderColor, HeaderBrush, LineCount > 1, ckFooter {footer}, False, False);
              end;
            end;
          end;
        finally
          // restore prev rgn
          if FlagRgn then RestoreRegion;
        end;
        with FooterRect do
          ExcludeClipRect(Handle, Left, Top, Right, bottom);
      end;
    end;
  end;

  procedure DrawStatus;

    procedure DrawCloseButton(ADC: HDC; ARect: TRect; ASelected, APushed: Boolean);
    var
      ABkBrush: HBRUSH;
      APenColor: TColor;
      APrevPen: HPEN;
    begin
      if APushed then
      begin
        ABkBrush := GetSysColorBrush(COLOR_WINDOWFRAME);
        APenColor := clWindow;
      end
      else
        if ASelected then
        begin
          ABkBrush := GetSysColorBrush(COLOR_WINDOW);
          APenColor := clWindowFrame;
        end
        else
        begin
          ABkBrush := GetSysColorBrush(COLOR_BTNFACE);
          APenColor := clBtnText;
        end;
      Windows.FillRect(ADC, ARect, ABkBrush);
      // cross
      APrevPen := SelectObject(ADC, CreatePen(PS_SOLID, 1, ColorToRGB(APenColor)));
      InflateRect(ARect, -2, -2);
      with ARect do
      begin
        { \ }
        MoveToEx(ADC, Left, Top, nil);
        LineTo(ADC, Right - 2, Bottom - 1);
        LineTo(ADC, Right - 1, Bottom - 1);
        LineTo(ADC, Left + 1, Top);
        LineTo(ADC, Left, Top);
        { / }
        MoveToEx(ADC, Right - 1, Top, nil);
        LineTo(ADC, Left + 1, Bottom - 1);
        LineTo(ADC, Left, Bottom - 1);
        LineTo(ADC, Right - 2, Top);
        LineTo(ADC, Right, Top);
      end;
      DeleteObject(SelectObject(ADC, APrevPen));
    end;

  var
    AShowStatusButton: Boolean;
    R: TRect;
    S: string;
  begin
    with Canvas, DrawInfo do
      if RectVisible(Handle, StatusRect) then
      begin
        AShowStatusButton := GetStatusButtonVisible; 
        S := GetStatusText;
        // Text
        Font.Assign(Self.Font);
        //Font.Style := Font.Style + [fsBold];
        R := StatusRect;
        InflateRect(R, -2, -2);
        if AShowStatusButton then
          Inc(R.Left, dxGridStatusCloseButtonWidth);
        DrawTextRect(Handle, S, Length(S), StatusRect, R,
          DX_DTR_LEFT or DX_DTR_SINGLELINE or DX_DTR_VCENTER,
          PanelBrush, Font.Handle, ColorToRGB(APanelBrushColor), ColorToRGB(clBtnHighlight), nil);
        // Button
        if AShowStatusButton then
        begin
          with StatusRect do
            R := Rect(Left, Top, Left + dxGridStatusCloseButtonSizeX, Top + dxGridStatusCloseButtonSizeY);
          OffsetRect(R, 3, (StatusRect.Bottom - StatusRect.Top - dxGridStatusCloseButtonSizeY) div 2);
          DrawCloseButton(Handle, R, FStatusCloseButtonActive and not FStatusCloseButtonPressed,
            FStatusCloseButtonActive and FStatusCloseButtonPressed);
        end;
        with StatusRect do
          ExcludeClipRect(Handle, Left, Top, Right, bottom);
      end;
  end;

  procedure DrawCells;
  var
    I, J, Y, H, Ind, SizeGrid, StartLineX: Integer;
    XPos1, XPos2: Integer;
    R, RClip: TRect;
    // lines
    Points, Strokes: PIntArray;
    MaxLines, LinesCount: Integer;
    Br: HBRUSH;
    CorrectY, DeltaButton, YPos1, YPos2: Integer;
    LevelNode: TdxTreeListNode;
    X, YTop, YBottom, YCenter: Integer;
    K, FooterCount: Integer;
    TreeBrush: HBRUSH;
    PrevBkColor: TColorRef;
    AColor, ATextColor: TColor;
    IsFocused: Boolean;
    NodeLevel: Integer;
    FlagSelected: Boolean;

    procedure CheckCoord(var Value: Integer; Limit: Integer);
    begin
      if Value > Limit then Value := Limit;
    end;

    function GetStartLineCoord(Node: TdxTreeListNode; Index: Integer): Integer;
    begin
      with DrawInfo do
      begin
        Result := Node.Level * FIndent;
        if Node.Expanded then
          Inc(Result, FIndent - 1)
        else
        if not Node.HasChildren and Node.IsLast then
           Dec(Result, FIndent);
        if (Index + 1) < RowCount then
           if RowsInfo^[Index + 1].Node.Level < RowsInfo^[Index].Node.Level then
              Result := RowsInfo^[Index + 1].Node.Level * FIndent;
        if (Node = LastNode) then Result := 0;
        if not ShowRoot then
          Dec(Result, FIndent);
      end;
    end;

    function GetTotalRect(AIndent, YTop, YBottom: Integer): TRect; // group and preview
    begin
      with DrawInfo do
      begin
        Result := Rect(CellsRect.Left + AIndent, YTop,
          CellsRect.Left + GetBandTotalWidth - SizeGrid, YBottom);
        if IsRectEmptyEx(FixedBandLeftRect) then
          OffsetRect(Result, - LeftCoord, 0);
        if not IsRectEmptyEx(FixedBandRightRect) then
          if Result.Right > CellsRect.Right - SizeGrid then
            Result.Right := CellsRect.Right - SizeGrid;
      end;
    end;

    procedure DrawTreeLine(X1, Y1, X2, Y2: Integer);
    begin
      Windows.FillRect(Canvas.Handle, Rect(X1, Y1, X2 + 1, Y2 + 1), TreeBrush);
    end;

  begin
    with Canvas, DrawInfo do
    begin
      // Empty rect
      if not IsRectEmpty(EmptyRectRight) and RectVisible(Handle, EmptyRectRight) then
        Windows.FillRect(Handle, EmptyRectRight, BackgroundBrush);
      if not IsRectEmpty(EmptyRectBottom) and RectVisible(Handle, EmptyRectBottom) then
        Windows.FillRect(Handle, EmptyRectBottom, BackgroundBrush);
      if RectVisible(Handle, CellsRect) and (BandCount > 0) then
      begin
        IsFocused := IsActiveControl or
          ((State = tsEditing) and (InplaceEditor <> nil) and (InplaceEditor.IsFocused));
        if FShowGrid then
        begin
          SizeGrid := 1;
          MaxLines := RowSeparatorLineWidth * RowCount * ( 1 +
            Byte(not IsRectEmptyEx(FixedBandLeftRect)) +
            Byte(not IsRectEmptyEx(FixedBandRightRect))); // separators row
          Inc(MaxLines); // vert right line
        end
        else
        begin
          SizeGrid := 0;
          MaxLines := 0;
        end;

        if RowsInfo <> nil then
        begin
          // draw Indent and calc count grid points
          RClip := Rect(CellsRect.Left, CellsRect.Top, CellsRect.Left + IndentLimit, CellsRect.Bottom);
          if IsRectEmptyEx(FixedBandLeftRect) then
            Dec(RClip.Right, LeftCoord);
          if RClip.Left > RClip.Right then
            RClip.Left := RClip.Right;
          FlagRgn := False;
          SaveRegion(RClip);
          try // OnGetImageIndex events -> raised exception
            //set tree line color
            if FPaintStandard and FShowLines and (TreeLineStyle = tlDot) then
            begin
              {save Bk Color}
              PrevBkColor := GetBkColor(Canvas.Handle);
              TreeBrush := HalftoneBrush;
              if Odd(CellsRect.Left) = Odd(CellsRect.Top) then
              begin
                SetBkColor(Canvas.Handle, ColorToRGB(TreeLineColor));
                SetTextColor(Canvas.Handle, ColorToRGB(Self.Color));
              end
              else
              begin
                SetBkColor(Canvas.Handle, ColorToRGB(Self.Color));
                SetTextColor(Canvas.Handle, ColorToRGB(TreeLineColor));
              end;
            end
            else
              TreeBrush := TreeLineBrush;
            // start position
            Y := CellsRect.Top;
            for j := 0 to RowCount - 1 do
            with RowsInfo^[j] do
            begin
              PrepareNode(Node); 
              try
                if FPaintStandard then
                  Br := BackgroundBrush
                else Br := GroupBrush;
                CorrectY := Byte(not FShowGrid and Node.HasChildren and not FPaintStandard);
                GetNodeIndent(Node, Ind, Indent);
                R := Rect(CellsRect.Left, Y, CellsRect.Left + Indent, Y + RowHeight);
                if IsRectEmptyEx(FixedBandLeftRect) then
                  OffsetRect(R, - LeftCoord, 0);
                if (R.Right > R.Left) then // fill and draw images
                begin
                  StartLineX := GetStartLineCoord(Node, j);
                  NodeLevel := Node.Level;
                  H := NodeLevel;
                  if not Node.HasChildren then Dec(NodeLevel);
                  if Node.HasChildren or FPaintStandard then Inc(H);
                  YCenter := Y + RowHeight div 2 - 1 + 1{?};
                  for i := 0 to H - 1 do
                  begin
                    R := Rect(CellsRect.Left + i * FIndent, Y  + Byte(i = H - 1)*CorrectY,
                      CellsRect.Left + (i + 1) * FIndent - 1, Y + RowHeight);
  {.}                  if not ShowRoot then OffsetRect(R, - FIndent, 0);
                    if not FShowGrid and FPaintStandard then
                      Inc(R.Right)
                    else
                    if R.Right > (CellsRect.Left + StartLineX) then
                      R.Bottom := Y + RowHeight - RowSeparatorLineWidth;
                    if IsRectEmptyEx(FixedBandLeftRect) then
                      OffsetRect(R, - LeftCoord, 0);
                    // footer indent
                    if (RowFooterCount > 0) then
                    begin
                      k := GetNodeFooterRowCount(Node, i);
                      if k <> -1 then
                        Dec(R.Bottom, k * FFooterRowNodeHeight);
                    end;
                    if not FPaintStandard then
                    begin
                      if (I <= NodeLevel) and AssignedLevelColorEvent then
                      begin
                        AColor := FGroupColor;
                        Br := GetLevelBrush(I, AColor);
                      end
                      else Br := GroupBrush;
                    end;
                    // fill indent
                    Windows.FillRect(Canvas.Handle, R, Br);
                    // tree lines
                    if FPaintStandard and FShowLines then
                    begin
                      DeltaButton := 9 div 2 + 1;
                      // horz line
                      X := CellsRect.Left + Node.Level * FIndent;
  {.}                   if not ShowRoot then Dec(X, FIndent);
                      if IsRectEmptyEx(FixedBandLeftRect) then
                        Dec(X, LeftCoord);
                      XPos1 := X + (FIndent div 2) - 1;
                      if FShowButtons and Node.HasChildren then
                        Inc(XPos1, DeltaButton);
                      DrawTreeLine(XPos1, YCenter, X + FIndent - 1, YCenter);
                      // vert lines
                      X := CellsRect.Left + Node.Level * FIndent + (FIndent div 2) - 1; // x coord
  {.}                   if not ShowRoot then Dec(X, FIndent);
                      if IsRectEmptyEx(FixedBandLeftRect) then
                        Dec(X, LeftCoord);
                      if FShowButtons and Node.HasChildren then
                      begin
                        // top line
                        if Node <> TopNode then
                        begin
                          YPos1 := Y;
                          // NEW
                          if (J > 0) and (FImageH > 0) and (Node.Parent <> nil) and (Node.Parent[0] = Node) then
                            Dec(YPos1, (RowsInfo^[J - 1].RowHeight - FImageH) div 2);
                          YPos2 := YCenter - DeltaButton;
                          DrawTreeLine(X, YPos1, X, YPos2);
                        end;
                        // bottom line
                        if not Node.IsLast then
                        begin
                          YPos1 := YCenter + DeltaButton;
                          YPos2 := Y + RowHeight;
                          DrawTreeLine(X, YPos1, X, YPos2);
                       end;
                      end
                      else
                      begin
                        if Node = TopNode then
                          YPos1 := YCenter
                        else YPos1 := Y;
                        // NEW
                        if (J > 0) and (FImageH > 0) and (Node.Parent <> nil) and (Node.Parent[0] = Node) then
                          Dec(YPos1, (RowsInfo^[J - 1].RowHeight - FImageH) div 2);
                        if not Node.IsLast then
                          YPos2 := Y + RowHeight
                        else YPos2 := YCenter;
                        if YPos1 < YPos2 then
                          DrawTreeLine(X, YPos1, X, YPos2);
                      end;
                      // left lines
                      LevelNode := Node.Parent;
                      while LevelNode <> nil do
                      begin
                        Dec(X, FIndent);
                        if not LevelNode.IsLast then
                        begin
                          YPos1 := Y;
                          YPos2 := Y + RowHeight;
                          DrawTreeLine(X, YPos1, X, YPos2);
                        end;
                        LevelNode := LevelNode.Parent;
                      end;
                    end;
                  end;
                  if Node.HasChildren and not (FPaintStandard and FShowGrid) then
                  begin
                    R.Left := R.Right;
                    R.Right := R.Left + 1;
                    R.Bottom := Y + RowHeight - RowSeparatorLineWidth;
                    Windows.FillRect(Canvas.Handle, R, Br);
                  end;
                  if FShowButtons and Node.HasChildren then // draw plus/minus button
                  begin
                    R.Left := CellsRect.Left + (Node.Level) * FIndent;
  {.}                   if not ShowRoot then OffsetRect(R, - FIndent, 0);
                    R.Right := R.Left + FIndent - 1;
                    R.Bottom := Y + RowHeight - RowSeparatorLineWidth;
                    if IsRectEmptyEx(FixedBandLeftRect) then
                      OffsetRect(R, - LeftCoord, 0);
                    if FPaintStandard then
                    begin
                      R.Bottom := Y + RowHeight;
                      DrawButton(Canvas, R, YCenter, not Node.Expanded);
                    end
                    else
                      if LookAndFeel = lfUltraFlat then
                        DrawUltraFlatButton(Canvas.Handle, R, not Node.Expanded)
                      else
                        DrawOutButton(Canvas, R, not Node.Expanded);
                  end;
                  // images
                  R.Bottom := Y + RowHeight - RowSeparatorLineWidth;
                  if (RowFooterCount > 0) then // footer indent
                  begin
                    k := GetRowFooterCount(Node);
                    if k <> -1 then
                      Dec(R.Bottom, k * FFooterRowNodeHeight);
                  end;
                  if not FPaintStandard then
                  begin
                    if IsGroup or Node.HasChildren then
                    begin
                      if AssignedLevelColorEvent then
                      begin
                        AColor := FGroupColor;
                        Br := GetLevelBrush(Node.Level, AColor);
                      end
                      else Br := GroupBrush;
                    end
                    else Br := BackgroundBrush;
                  end;
                  if Node.StateIndex <> -1 then
                  begin
                    R.Left := CellsRect.Left + Ind;
                    R.Right := R.Left + FImageStateW;
                    if IsRectEmptyEx(FixedBandLeftRect) then
                      OffsetRect(R, - LeftCoord, 0);
                    Windows.FillRect(Canvas.Handle, R, Br);
                    WriteImage(Canvas, R, StateImages, Node.StateIndex);
                    Inc(Ind, FImageStateW);
                  end;
                  if IsSelected then
                  begin
                    R.Left := CellsRect.Left + Ind;
                    R.Right := R.Left + FImageW;
                    if IsRectEmptyEx(FixedBandLeftRect) then
                      OffsetRect(R, - LeftCoord, 0);
                    Windows.FillRect(Canvas.Handle, R, Br);
                    if Node.SelectedIndex <> -1 then
                      WriteImage(Canvas, R, Images, Node.SelectedIndex);
                  end
                  else
                  begin
                    R.Left := CellsRect.Left + Ind;
                    R.Right := R.Left + FImageW;
                    if IsRectEmptyEx(FixedBandLeftRect) then
                      OffsetRect(R, - LeftCoord, 0);
                    Windows.FillRect(Canvas.Handle, R, Br);
                    if Node.ImageIndex <> -1 then
                      WriteImage(Canvas, R, Images, Node.ImageIndex);
                  end;
                end;
                // calc lines count
                if FShowGrid then
                begin
                  Inc(MaxLines, Node.Level + Byte(FPaintStandard)); // vert separators
                  if not IsGroup and FShowPreviewGrid then Inc(MaxLines, HeaderCount * 2 + EmptyRectCount); // cells
                  if FShowPreviewGrid and (PreviewLineCount > 0) then Inc(MaxLines); // preview separator line
                  if FShowGrid and FShowPreviewGrid then
                    Inc(MaxLines, RowFooterHeight * RowFooterCount); // row footer separator line
                end
                else
                begin
                  Inc(MaxLines, Node.Level + 1{bottom line - group or last children node });
                  if not IsGroup then
                  begin
                    if not IsRectEmptyEx(FixedBandLeftRect) then Inc(MaxLines);
                    if not IsRectEmptyEx(FixedBandRightRect) then Inc(MaxLines);
                  end;
                end;
                if Indent > IndentLimit then
                  Indent := IndentLimit;
                Inc(Y, RowHeight);
              finally
                UnPrepareNode(Node); 
              end;
            end;
            // restore Bk Color
            if FPaintStandard and FShowLines then
              SetBkColor(Canvas.Handle, PrevBkColor);
          finally
            // restore prev rgn
            RestoreRegion;
          end;

          // grid lines memory allocating
          Points := AllocMem(MaxLines * SizeOf(TPoint) * 2);
          Strokes := AllocMem(MaxLines * SizeOf(Integer));
          for i := 0 to MaxLines - 1 do Strokes^[i] := 2;
          LinesCount := 0;

          // draw values
          try // OnCustomDraw events -> raised exception
            Y := CellsRect.Top;
            FlagClip := ((not IsRectEmptyEx(FixedBandLeftRect)) or
              (not IsRectEmptyEx(FixedBandRightRect)) or (LeftCoord <> 0 )) and
              ((CellsRect.Right - CellsRect.Left) < GetBandTotalWidth);
            // set Font
            Font.Assign(Self.Font); // TODO PAINT*
            SetTextColor(Handle, ColorToRGB(Self.Font.Color)); // TODO PAINT*
            for j := 0 to RowCount - 1 do
            with RowsInfo^[j] do
            begin
              PrepareNode(Node);
              try
                CorrectY := Byte(not FShowGrid and Node.HasChildren and not FPaintStandard);
                if IsGroup then
                begin
                  FlagRgn := False;
                  R := GetTotalRect(Indent, Y + CorrectY, Y + RowHeight - RowSeparatorLineWidth);
                  RClip := Rect(CellsRect.Left, R.Top, CellsRect.Right, R.Bottom);
                  if FlagClip then SaveRegion(RClip);

                  // TODO PAINT1
                  GetBkBrush(Node, IsSelected and (not IsNewItemRowActive or IsMultiSelect), IsFocused,
                    IsGroup, Node.HasChildren, Node.Level, -1, AColor, ATextColor, Br);
                  SetBkColor(Canvas.Handle, ColorToRGB(AColor));
                  SetTextColor(Canvas.Handle, ColorToRGB(ATextColor));
                  DrawCell(Canvas, R, DrawBitmap, Node, 0, -1, IsSelected, IsFocused and Node.Focused,
                    AColor, Br, False, ckGroup, False, False);

                  // Draw Focus
                  if not IsNewItemRowActive and  Node.Focused and ((IsFocused and not HideDrawFocusRect) or
                    (not IsFocused and not HideFocusRect)) then
                    if IsFocused then
                      DrawFocused(Handle, R)
                    else if (FDragObject = nil) then DrawFramed(Handle, R);
                  if FlagRgn then RestoreRegion;
                end
                else
                begin
                  // draw fixed band lines
                  R.Top := Y;
                  R.Bottom := R.Top + RowHeight - PreviewLineCount * FDescTextHeight -
                    Byte((PreviewLineCount > 0) and FShowGrid and FShowPreviewGrid) -
                    2 * Byte(PreviewLineCount > 0) - RowFooterHeight;
                  if PreviewLineCount > 0 then Dec(R.Bottom, RowSeparatorLineWidth);
                  if not IsRectEmpty(FooterRect) then
                    if R.Bottom > FooterRect.Top then R.Bottom := FooterRect.Top;
                  // draw fixed lines
                  if not IsRectEmptyEx(FixedBandLeftRect) then
                  begin
                    with FixedBandLeftRect do
                      R := Rect(Right - FFixedBandLineWidth, R.Top, Right, R.Bottom);
                    Windows.FillRect(Handle, R, FixedBandLineBrush{GetSysColorBrush(COLOR_WINDOWFRAME)});
                  end;
                  if not IsRectEmptyEx(FixedBandRightRect) then
                  begin
                    with FixedBandRightRect do
                      R := Rect(Left, R.Top, Left + FFixedBandLineWidth, R.Bottom);
                    Windows.FillRect(Handle, R, FixedBandLineBrush{GetSysColorBrush(COLOR_WINDOWFRAME)});
                  end;
                  Inc(R.Top, CorrectY);
                  // cells - calc clip region
                  FlagRgn := False;
                  RClip := Rect(CellsRect.Left + Indent, Y, CellsRect.Right,
                    Y + RowHeight{ - PreviewLineCount * FDescTextHeight - RowSeparatorLineWidth});
                  if not IsRectEmptyEx(FixedBandLeftRect) then
                    RClip.Left := FixedBandLeftRect.Right
                  else
                  begin
                    Dec(RClip.Left, LeftCoord);
                    if RClip.Left < CellsRect.Left then
                      RClip.Left := CellsRect.Left;
                  end;
                  if not IsRectEmptyEx(FixedBandRightRect) then
                    RClip.Right := FixedBandRightRect.Left;
                  // draw cells
                  for I := 0 to HeaderCount - 1 do
                  with HeadersInfo^[I] do
                  begin
                    if FlagClip then // set clip region
                    begin
                      if not ((BandIndex = FixedBandLeftIndex) or
                         (BandIndex = FixedBandRightIndex)) and not FlagRgn then // set region
                        SaveRegion(RClip)
                      else
                      if FlagRgn and ((BandIndex = FixedBandLeftIndex) or
                         (BandIndex = FixedBandRightIndex)) then // restore prev rgn
                        RestoreRegion;
                    end;
                    // calc indent
                    StartLineX := HeaderRect.Left;
                    if IsRectEmptyEx(FixedBandLeftRect) then
                      Inc(StartLineX, LeftCoord);
                    if (BandIndex = 0) and (StartLineX - CellsRect.Left < Indent) then
                      Ind := Indent - (StartLineX - CellsRect.Left)
                    else Ind := 0;

                    H := LineCount * FRowHeight;
                    if HeaderRect.Right > (HeaderRect.Left + Ind) then // if Visible
                    begin
                      R := Rect(HeaderRect.Left + Ind, Y + FRowHeight * RowIndex + CorrectY, HeaderRect.Right,
                        Y + FRowHeight * RowIndex + H - SizeGrid * Byte(FShowPreviewGrid) + CorrectY);
                      if (FHeaderRowCount = 1) then
                      begin
                        R.Bottom := Y + RowHeight - PreviewLineCount * FDescTextHeight - RowSeparatorLineWidth - RowFooterHeight;
                        if PreviewLineCount > 0 then
                          Dec(R.Bottom, 2 + Byte(FShowGrid and FShowPreviewGrid));
                      end;
                      if not (((BandIndex = FixedBandLeftIndex) or (BandIndex = FixedBandPrevRightIndex))
                        and LastColumn) then Dec(R.Right, SizeGrid * Byte(FShowPreviewGrid));
                      if FShowGrid and not FShowPreviewGrid and LastColumn then
                      begin
                        if (BandCount > 1) and (BandIndex = BandsInfo^[BandCount - 1].Index) or
                          (BandCount = 1) then Dec(R.Right, SizeGrid);
                      end;
                      if RectVisible(Handle, R) then
                      begin
                        // Bk Color and Text Color
                        FlagSelected := IsSelected and (not IsNewItemRowActive or IsMultiSelect) and
                           (IsRowSelect or (IsMultiSelect and not IsInvertSelect) or
                           (IsMultiSelect and IsInvertSelect and IsNewItemRowActive) or
                           (IsMultiSelect and IsInvertSelect and not Node.Focused) or
                           ((FocusedAbsoluteIndex = AbsoluteIndex) and not IsInvertSelect) or
                           ((FocusedAbsoluteIndex <> AbsoluteIndex) and IsInvertSelect));
                        if FlagSelected and HideSelection and not IsFocused then FlagSelected := False; // TODO ?

                        // TODO PAINT1
                        GetBkBrush(Node, FlagSelected, IsFocused, IsGroup, Node.HasChildren,
                          Node.Level, I, AColor, ATextColor, Br);
                        GetCellBkBrush(I, ACellBkColor, ACellBkBrush);

                        DrawCellEx(Canvas, R, DrawBitmap, Node, AbsoluteIndex, FlagSelected,
                          IsFocused and Node.Focused and (IsInvertSelect or IsRowSelect or (FocusedAbsoluteIndex = AbsoluteIndex)),
                          AColor, ATextColor, Br, (LineCount > 1) or (RowLineCount > 1) or MultiLine, ckRow,
                          LeftEdgeColumn, RightEdgeColumn, ACellBkColor, ACellBkBrush);

                        // Draw Focus
                        if not IsNewItemRowActive and not (IsRowSelect or IsInvertSelect) and
                          Node.Focused and (FocusedAbsoluteIndex = AbsoluteIndex) and
                          ((IsFocused and not HideDrawFocusRect) or
                           (not IsFocused and not HideFocusRect)) then
                          if IsFocused then
                            DrawFocused(Handle, R)
                          else if (FDragObject = nil) then DrawFramed(Handle, R);
                      end;
                      if RectVisible(Handle, Rect(R.Left, R.Top, R.Right, R.Bottom + 1)) then
                      begin
                        // grid horz line
                        if FShowGrid and FShowPreviewGrid and (FHeaderRowCount > 1) then
                        begin
                          SetPoints(Points, LinesCount,
                            R.Left, R.Bottom, R.Right, R.Bottom);
                          if FlagRgn and (Points^[LinesCount * 4] < RClip.Left) then
                            Points^[LinesCount * 4] := RClip.Left;
                          if FlagRgn and (Points^[LinesCount * 4 + 2] > RClip.Right) then
                            Points^[LinesCount * 4 + 2] := RClip.Right;
                          Inc(LinesCount);
                        end;
                      end;
                      // grid vert line
                      if FShowGrid and FShowPreviewGrid and not (((BandIndex = FixedBandLeftIndex) or
                        (BandIndex = FixedBandPrevRightIndex)) and LastColumn) then
                      begin
                        if not (FlagRgn and ((R.Right < RClip.Left) or (R.Right >= RClip.Right))) then
                        begin
                          SetPoints(Points, LinesCount,
                            R.Right, R.Top, R.Right, R.Bottom + 1);
                          if LastColumn then // band edge
                          begin
                            Points^[LinesCount * 4 + 3] := Y + FRowHeight * GetHeaderMaxRowCount;
                            if (FHeaderRowCount = 1) then
                              Points^[LinesCount * 4 + 3]:= Y + RowHeight - PreviewLineCount * FDescTextHeight -
                                RowSeparatorLineWidth - RowFooterHeight - 2 * Byte(PreviewLineCount > 0);
                          end
                          else
                            if (i < (HeaderCount - 1)) and (BandIndex = HeadersInfo^[i + 1].BandIndex) and
                              (RowIndex = HeadersInfo^[i + 1].RowIndex) then
                            begin
                              H := HeadersInfo^[i + 1].LineCount * FRowHeight;
                              H := Y + FRowHeight * RowIndex + H - SizeGrid;
                              if (H + 1) > Points^[LinesCount * 4 + 3] then
                                Points^[LinesCount * 4 + 3] := (H + 1);
                            end;
                          Inc(LinesCount);
                        end;
                      end;
                      // empty header rect
                      if not IsRectEmpty(HeaderEmptyRect) and not IsGroup then
                      begin
                        R.Top := Y + FRowHeight * (RowIndex + LineCount) + CorrectY;
                        R.Bottom := Y + FRowHeight * GetHeaderMaxRowCount + CorrectY;
                        if FShowGrid and FShowPreviewGrid then Dec(R.Bottom);
                        if FShowGrid and FShowPreviewGrid then
                        begin
                          Inc(R.Right, SizeGrid);
                          if LastColumn then
                          begin
                            if (i > 0) and (BandIndex = HeadersInfo^[i - 1].BandIndex) and
                             (RowIndex = HeadersInfo^[i - 1].RowIndex) then
                              if HeadersInfo^[i - 1].LineCount < HeadersInfo^[i].LineCount then
                                Dec(R.Left);
                            Dec(R.Right);
                          end
                          else
                          if (i < (HeaderCount - 1)) and (BandIndex = HeadersInfo^[i + 1].BandIndex) and
                            (RowIndex = HeadersInfo^[i + 1].RowIndex) then
                          begin
                            if HeadersInfo^[i].LineCount < HeadersInfo^[i + 1].LineCount then
                              Dec(R.Right)
                            else
                            if HeadersInfo^[i].LineCount > HeadersInfo^[i + 1].LineCount then
                              Dec(R.Left);
                          end;
                        end;
                        GetBkBrush(Node, IsSelected and (not IsNewItemRowActive or IsMultiSelect) and (IsRowSelect or IsInvertSelect or IsMultiSelect), IsFocused,
                          IsGroup, Node.HasChildren, Node.Level, -1, AColor, ATextColor, Br);
                        Windows.FillRect(Handle, R, Br);
                      end;
                    end;
                  end;
                  // restore prev rgn
                  if FlagRgn then RestoreRegion;
                  // fill empty rect
                  if EmptyRectsInfo <> nil then
                  begin
                    for i := 0 to EmptyRectCount - 1 do
                    with EmptyRectsInfo^[i] do
                    begin
                      R := GetTotalRect(Indent, Y + CorrectY,
                        Y + FRowHeight * GetHeaderMaxRowCount + CorrectY - Byte(FShowGrid and FShowPreviewGrid));

                      if (FHeaderRowCount = 1) then
                      begin
                        R.Bottom := Y + RowHeight - PreviewLineCount * FDescTextHeight - RowSeparatorLineWidth - RowFooterHeight;
                        if PreviewLineCount > 0 then
                          Dec(R.Bottom, 2 + Byte(FShowGrid and FShowPreviewGrid));
                      end;

                      if EmptyRectsInfo^[i].BandIndex <> 0 then
                        R.Left := EmptyRect.Left;
                      R.Right := EmptyRect.Right;
                      // vert line - group separator
                      if FShowGrid and FShowPreviewGrid and not ((BandIndex = FixedBandLeftIndex) or
                        (BandIndex = FixedBandPrevRightIndex)) then
                      begin
                        if not ((R.Right < RClip.Left) or (R.Right > RClip.Right)) and not ClippingFlag then
  //                        (BandsInfo^[BandIndex].BandRect.Right <= BandsInfo^[BandIndex].BandClipRect.Right) then
                        begin
                          SetPoints(Points, LinesCount,
                            R.Right - 1, R.Top, R.Right - 1, R.Bottom);
                          Inc(LinesCount);
                          Dec(R.Right);
                        end;
                      end;
                      GetBkBrush(Node, IsSelected and (not IsNewItemRowActive or IsMultiSelect) and (IsRowSelect or IsInvertSelect or IsMultiSelect), IsFocused,
                        IsGroup, Node.HasChildren, Node.Level, -1, AColor, ATextColor, Br);
                      if not IsRectEmpty(R) then
                        Windows.FillRect(Handle, R, Br);
                    end;
                  end;
                  // preview
                  if PreviewLineCount > 0 then
                  begin
                    FlagRgn := False;
                    R := GetTotalRect(Indent, Y + RowHeight - PreviewLineCount * FDescTextHeight -
                      RowSeparatorLineWidth - 2 - RowFooterHeight, Y + RowHeight - RowSeparatorLineWidth - RowFooterHeight);
                    RClip := Rect(CellsRect.Left, R.Top, CellsRect.Right, R.Bottom);
                    if FlagClip then SaveRegion(RClip);
                    GetBkBrush(Node, IsSelected and (not IsNewItemRowActive or IsMultiSelect) and (IsRowSelect or IsInvertSelect or IsMultiSelect), IsFocused,
                      IsGroup, Node.HasChildren, Node.Level, -1, AColor, ATextColor, Br);
                    DrawPreview(Canvas, R, DrawBitmap, Node, AColor, ATextColor, Br, IsSelected);
                    // grid - separator preview
                    if FShowGrid and FShowPreviewGrid then
                    begin
                      SetPoints(Points, LinesCount,
                        R.Left, R.Top - 1, R.Right, R.Top - 1);
                      if FlagRgn and (Points^[LinesCount * 4] < RClip.Left) then
                        Points^[LinesCount * 4] := RClip.Left;
                      if FlagRgn and (Points^[LinesCount * 4 + 2] > RClip.Right) then
                        Points^[LinesCount * 4 + 2] := RClip.Right;
                      Inc(LinesCount);
                    end;
                    if FlagRgn then RestoreRegion;
                  end;
                  // node footer
                  for k := 0 to RowFooterCount - 1 do
                  begin
                    R := GetFooterRect(Node, k, Y + RowHeight - RowSeparatorLineWidth - RowFooterHeight, SizeGrid, DrawInfo);
                    if FShowGrid and FShowPreviewGrid then
                    begin
                      // grid footer separator (horz line)
                      SetPoints(Points, LinesCount,
                        R.Left, R.Top, R.Right, R.Top);
                      Inc(LinesCount);
                      // grid vert line
                      if R.Right < CellsRect.Right then
                      begin
                        SetPoints(Points, LinesCount,
                          R.Right, R.Top, R.Right, R.Bottom);
                        Inc(LinesCount);
                      end;
                      // correct rect size
                      Inc(R.Top, SizeGrid);
                    end;
//fc                    Br := FooterBrush;
                    AColor := FFooterColor;
                    if AssignedLevelColorEvent then
                      Br := GetLevelBrush(GetNodeFooterLevel(Node, k), AColor)
                    else Br := FooterBrush;

                    Windows.FillRect(Handle, R, Br);
                    // draw footer cells
                    try
                      RClip := R;
                      if not IsRectEmptyEx(FixedBandLeftRect) then
                        RClip.Left := FixedBandLeftRect.Right
                      else
                      begin
                        Dec(RClip.Left, LeftCoord);
                        if RClip.Left < CellsRect.Left - FIndicatorWidth then
                          RClip.Left := CellsRect.Left - FIndicatorWidth;
                      end;
                      if not IsRectEmptyEx(FixedBandRightRect) then
                        RClip.Right := FixedBandRightRect.Left;
                      YTop := R.Top + 1;
                      for i := 0 to HeaderCount - 1 do
                      with HeadersInfo^[i] do
                      begin
                        if FlagClip then // set clip region
                        begin
                          if not ((BandIndex = FixedBandLeftIndex) or
                             (BandIndex = FixedBandRightIndex)) and not FlagRgn then // set region
                            SaveRegion(RClip)
                          else
                          if FlagRgn and ((BandIndex = FixedBandLeftIndex) or
                             (BandIndex = FixedBandRightIndex)) then // restore prev rgn
                            RestoreRegion;
                        end;
                        X := HeaderRect.Left;
                        if IsRectEmptyEx(FixedBandLeftRect) then
                          Inc(X, LeftCoord);
                        // calc indent
                        StartLineX := Indent;
                        XPos1 := GetNodeFooterLevel(Node, k);
                        if XPos1 <> -1 then
                          Dec(StartLineX, (Node.Level - 1 - XPos1) * FIndent);
                        if (BandIndex = 0) and (X - CellsRect.Left < StartLineX{Indent}) then
                          Ind := StartLineX{Indent} - (X - CellsRect.Left)
                        else Ind := 0;
                        H := LineCount * FFooterRowHeight;
                        if HeaderRect.Right > (HeaderRect.Left + Ind) then // if Visible
                        begin
                          R := Rect(HeaderRect.Left + Ind, YTop + FFooterRowHeight * RowIndex,
                            HeaderRect.Right, YTop + FFooterRowHeight * RowIndex + H);
                          InflateRect(R, -1, -1);
                          if (BandIndex = 0) and (ColIndex = 0) then
                            Inc(R.Left);
                          if LastColumn and (BandIndex = BandsInfo^[BandCount - 1].Index) then
                            Dec(R.Right, 2);
                          if IsExistRowFooterCell(Node, AbsoluteIndex, K) then
                          begin
                            DrawFooterFrame(Canvas.Handle, R);
//                            DrawEdge(Canvas.Handle, R, BDR_SUNKENOUTER, BF_RECT);
                            InflateRect(R, -1, -1);
                            // DrawFooterCell
//fc                            SetBkColor(Canvas.Handle, ColorToRGB(FFooterColor));
                            SetBkColor(Canvas.Handle, ColorToRGB(AColor));
                            SetTextColor(Canvas.Handle, ColorToRGB(FFooterTextColor));
//fc                            DrawCell(Canvas, R, DrawBitmap, Node, AbsoluteIndex, K, False, False,
//                              FFooterColor, Br, LineCount > 1, ckFooter{footer}, False, False);
                            DrawCell(Canvas, R, DrawBitmap, Node, AbsoluteIndex, K, False, False,
                              AColor, Br, LineCount > 1, ckFooter{footer}, False, False);
                          end;
                        end;
                      end;
                    finally
                      // restore prev rgn
                      if FlagRgn then RestoreRegion;
                    end;
                  end;
                  // Draw Focus - if RowSelect
                  if not IsNewItemRowActive and (IsRowSelect or IsInvertSelect) and Node.Focused and
                     ((IsFocused and not HideDrawFocusRect) or not IsFocused and not HideFocusRect) then
                  begin
                    R := GetTotalRect(Indent, Y, {Y + RowHeight - RowSeparatorLineWidth}
                      Y + RowHeight - RowSeparatorLineWidth - RowFooterHeight);
                    if not FPaintStandard and not FShowGrid and Node.HasChildren then Inc(R.Top);
                    if IsFocused then
                      DrawFocused(Handle, R)
                    else
                      if (FDragObject = nil) then DrawFramed(Handle, R);
                  end;
                end;
                // grid - vert line separator group
                H := Node.Level;
                if FPaintStandard then
                  if FShowGrid then Inc(H)
                  else H := 0;
                for i := 0 to H - 1 do
                begin
                  StartLineX := CellsRect.Left + (i + 1) * FIndent - 1;
  {.}              if not ShowRoot then Dec(StartLineX, FIndent);
                  // footer indent
                  YBottom := Y + RowHeight;
                  if (RowFooterCount > 0) then
                  begin
                    k := GetNodeFooterRowCount(Node, i);
                    if k > 0 then
                      Dec(YBottom, k * FFooterRowNodeHeight + RowSeparatorLineWidth);
                  end;
                  if StartLineX < CellsRect.Left + IndentLimit then
                  begin
                    if IsRectEmptyEx(FixedBandLeftRect) then
                      Dec(StartLineX, LeftCoord);
                    if StartLineX >= CellsRect.Left then
                    begin
                      SetPoints(Points, LinesCount,
                        StartLineX, Y, StartLineX, YBottom);
                      Inc(LinesCount);
                    end;
                  end;
                end;
                Inc(Y, RowHeight);
                // grid - separator row
                if FShowGrid or (Node.HasChildren and not FPaintStandard) then
                begin
                  if not FShowGrid and Node.HasChildren then
                  begin
                    Ind := Node.Level * FIndent;
  {.}              if not ShowRoot then Dec(Ind, FIndent);
                    StartLineX := RowHeight - 1;
                  end
                  else
                  begin
                    Ind := GetStartLineCoord(Node, j);
                    StartLineX := 0;
                  end;
                  if FShowGrid then H := RowSeparatorLineWidth
                  else H := 1;
                  if Ind > IndentLimit then Ind := IndentLimit;
                  XPos1 := CellsRect.Left + Ind;
                  if IsRectEmptyEx(FixedBandLeftRect) then
                    Dec(XPos1, LeftCoord);
                  if XPos1 < CellsRect.Left then
                    XPos1 := CellsRect.Left;
                  if not IsGroup and (PreviewLineCount = 0) and (RowFooterHeight = 0) then
                  begin
                    if not IsRectEmptyEx(FixedBandLeftRect) then
                    begin
                      XPos2 := FixedBandLeftRect.Right - FFixedBandLineWidth;
                      for i := 0 to H - 1 do
                      begin
                        SetPoints(Points, LinesCount,
                          XPos1, Y + i - H - StartLineX, XPos2, Y + i - H - StartLineX);
                        Inc(LinesCount);
                      end;
                      XPos1 := FixedBandLeftRect.Right;
                    end;
                    if not IsRectEmptyEx(FixedBandRightRect) then
                    begin
                      XPos2 := FixedBandRightRect.Left;
                      for i := 0 to H - 1 do
                      begin
                        SetPoints(Points, LinesCount,
                          XPos1, Y + i - H - StartLineX, XPos2, Y + i - H - StartLineX);
                        Inc(LinesCount);
                      end;
                      XPos1 := FixedBandRightRect.Left + FFixedBandLineWidth;
                    end;
                  end;
                  XPos2 := EdgeX + Byte(not FShowGrid);
                  for i := 0 to H - 1 do
                  begin
                    SetPoints(Points, LinesCount,
                      XPos1, Y + i - H - StartLineX, XPos2, Y + i - H - StartLineX);
                    Inc(LinesCount);
                  end;
                end;
              finally
                UnPrepareNode(Node); // synchronizing with DataSet
              end;
            end;
            // Vert right line
            if FShowGrid then
            begin
              SetPoints(Points, LinesCount,
                EdgeX, CellsRect.Top, EdgeX, CellsRect.Bottom);
              if EdgeY <> -1 then
                Points^[LinesCount * 4 + 3] := EdgeY + 1;
              Inc(LinesCount);
            end;
            // grid lines
            if FShowGrid then
              Canvas.Pen.Color := GetGridColor(Self.Color) //clBtnShadow
            else Canvas.Pen.Color := Self.Color;
//            SelectObject(Canvas.Handle, Canvas.Pen.Handle);
            PolypolyLine(Canvas.Handle, Points^, Strokes^,  LinesCount);
          finally
            FreeMem(Strokes);
            FreeMem(Points);
          end;
        end;
      end;
    end;
  end;

  function GetShadowPanelColor: TColor;
  begin
    if LookAndFeel = lfUltraFlat then
      Result := $00A0A0A0
    else
      Result := clBtnShadow;
  end;

{.$DEFINE DEBUG_PAINT}
{$IFDEF DEBUG_PAINT}
var
  i, t1, t2: LongInt;
{$ENDIF DEBUG_PAINT}
begin
{$IFDEF DEBUG_PAINT}
t1 := gettickcount;
for i := 0 to 100 do
{$ENDIF DEBUG_PAINT}
begin
  HideDragImages;
  try
    // calc Draw Info
    CalcDrawInfo(DrawInfo);
    // create GDI objects
    DrawBitmap := TBitmap.Create;
    BandBrush := CreateSolidBrush(ColorToRGB(FBandColor));
    HeaderBrush := CreateSolidBrush(ColorToRGB(FHeaderColor));
    GroupBrush := CreateSolidBrush(ColorToRGB(FGroupColor));
    BackgroundBrush := CreateSolidBrush(ColorToRGB(Self.Color));
    APanelBrushColor := GetShadowPanelColor;
    PanelBrush := CreateSolidBrush(ColorToRGB(APanelBrushColor)); //GetSysColorBrush(COLOR_BTNSHADOW);
    HighlightBrush := CreateSolidBrush(ColorToRGB(FHighlightColor));//GetSysColorBrush(COLOR_HIGHLIGHT);
    TreeLineBrush := CreateSolidBrush(ColorToRGB(TreeLineColor));
    HideSelectionBrush := CreateSolidBrush(ColorToRGB(FHideSelectionColor));
    FooterBrush := CreateSolidBrush(ColorToRGB(FFooterColor));
    FixedBandLineBrush := CreateSolidBrush(ColorToRGB(FFixedBandLineColor));
    LevelBrush := 0;
    // create column brushes
    with DrawInfo do
    begin
      PBrushes := AllocMem(HeaderCount * SizeOf(TBrushInfo));
      for BrushIndex := 0 to HeaderCount - 1 do
        with HeadersInfo^[BrushIndex] do
        begin
          PBrushes^[BrushIndex].Color := GetColumnColor(AbsoluteIndex);
          if ColorToRGB(PBrushes^[BrushIndex].Color) <> ColorToRGB(Self.Color) then
            PBrushes^[BrushIndex].Brush := CreateSolidBrush(ColorToRGB(PBrushes^[BrushIndex].Color));
        end;
    end;
    try
      DrawGrPanel;
      DrawBands;
      DrawHeaders;
      DrawNewItemRow;
      DrawIndicator;
      DrawFooter;
      DrawStatus;
      DrawCells;
    finally
      // free Brushes Info
      with DrawInfo do
        for BrushIndex := 0 to HeaderCount - 1 do
          if PBrushes^[BrushIndex].Brush <> 0 then
            DeleteObject(PBrushes^[BrushIndex].Brush);
      FreeMem(PBrushes);
      // free other
      DeleteObject(FixedBandLineBrush);
      DeleteObject(FooterBrush);
      if LevelBrush <> 0 then
        DeleteObject(LevelBrush);
      DeleteObject(HideSelectionBrush);
      DeleteObject(TreeLineBrush);
      DeleteObject(HighlightBrush);
      DeleteObject(PanelBrush);
      DeleteObject(BackgroundBrush);
      DeleteObject(GroupBrush);
      DeleteObject(HeaderBrush);
      DeleteObject(BandBrush);
      if DrawBitmap <> nil then
      begin
        DrawBitmap.Free;
        DrawBitmap := nil;
      end;
      // free Draw Info
      FreeDrawInfo(DrawInfo);
    end;
  finally
    ShowDragImages;
  end;

end;
{$IFDEF DEBUG_PAINT}
SelectClipRgn(Canvas.Handle, 0);
t2 := gettickcount;
getparentform(self).caption := inttostr(t2 - t1);
{$ENDIF DEBUG_PAINT}
end;

procedure TCustomdxTreeList.WndProc(var Message: TMessage);
var
  Node: TdxTreeListNode;
  P: TPoint;
begin
  if (Message.Msg = WM_MOUSEMOVE) and
    (State in [tsBandDragging, tsColumnDragging]) then
  begin
    if State = tsBandDragging then DoBandDragging;
    if State = tsColumnDragging then DoHeaderDragging;
    Exit;
  end;

  if (Message.Msg = WM_KEYDOWN) and (Message.wParam = VK_ESCAPE) and
    Dragging and (DragMode = dmAutomatic) then EndDrag(False);

  {$IFNDEF DELPHI4}
  if ((Message.Msg = WM_KEYUP) or (Message.Msg = WM_KEYDOWN)) and
    (Message.wParam = VK_CONTROL) and Dragging then
  begin
    GetCursorPos(P);
    SetCursorPos(P.X, P.Y);
  end;
  {$ENDIF}

  if (Message.Msg = WM_KEYDOWN) and
     (Message.wParam in [VK_ADD, VK_SUBTRACT]) and
     Dragging and (DragMode = dmAutomatic) then
  begin
    GetCursorPos(P);
    P := ScreenToClient(P);
//    Windows.ScreenToClient(Parent.Handle, P);
    Node := GetNodeAt(P.X, P.Y);
    if Node <> nil then
      if Node.HasChildren then
      if (Message.wParam = VK_ADD) and
         not Node.Expanded then Node.Expanded := True
      else
      if (Message.wParam = VK_SUBTRACT) and
          Node.Expanded then Node.Expanded := False;
  end;

  if not (csDesigning in ComponentState) and ((Message.Msg = WM_LBUTTONDOWN) or
    (Message.Msg = WM_LBUTTONDBLCLK)) and not Dragging and (DragMode = dmAutomatic) then
  begin
    if not IsControlMouseMsg(TWMMouse(Message)) then
    begin
      ControlState := ControlState + [csLButtonDown];
      Dispatch(Message);
    end;
  end
  else inherited WndProc(Message);
end;

// routines TCustomdxTreeList
function TCustomdxTreeList.CalcBandHeight(LineCount: Integer): Integer;
begin
  Result := FBandTextHeight * LineCount + 3{indent}
    + 2 + Byte(not FFlat){black line -> right_bottom};
end;

function TCustomdxTreeList.CalcBandPanelRowCount(Y: Integer): Integer;
var
  DrawInfo: TdxGridDrawInfo;
  i: Integer;
begin
  CalcRectInfo(DrawInfo);
  with DrawInfo do
  begin
    Result := 0;
    for i := 1 to GetBandMaxRowCount do
    begin
      if Y >= (BandRect.Top + CalcBandHeight(i)) then
        Inc(Result)
      else Break;
    end;
  end;
end;

function TCustomdxTreeList.CalcHeaderPanelRowCount(Y: Integer): Integer;
var
  DrawInfo: TdxGridDrawInfo;
begin
  CalcRectInfo(DrawInfo);
  with DrawInfo do
  begin
    Result := (Y - HeaderRect.Top + FHeaderRowHeight div 2) div FHeaderRowHeight;
    if Result < 1 then Result := 1;
  end;
end;

function TCustomdxTreeList.CalcNearestRowHeight(Node: TdxTreeListNode; ResizeRowHeight: Integer): Integer;
var
  i: Integer;
begin
  Result := FRowHeight;
  if Node <> nil then
  begin
    for i := FMinRowHeight to ResizeRowHeight do
    begin
      if GetRowHeight(Node, i, True{ReCalc}) <= ResizeRowHeight then
        Result := i
      else Break;
    end;
  end;
end;

class function TCustomdxTreeList.CalcTextRowHeight(TextHeight: Integer): Integer;
begin
  Result := TextHeight + 3;
end;

procedure TCustomdxTreeList.CancelDragSizing;
begin
  if State in [tsBandSizing, tsColumnSizing, tsBandPanelSizing, tsHeaderPanelSizing, tsRowSizing] then
  begin
    DrawSizingLine;
    SetState(tsNormal);
    SetCursor(Screen.Cursors[Cursor]);
  end;
  if State = tsBandDown then
  begin
    SetState(tsNormal);
    FDownBandIndex := -1;
    InvalidateBand(-1);
  end;
  if State = tsBandDragging then
    EndDragBand(False);
  if State = tsDropDownButtonDown then
  begin
    SetState(tsNormal);
    FDropDownButtonColumnIndex := -1;
    FDownColumnIndex := -1;
    InvalidateColumn(-1);
  end;
  if State = tsStatusCloseButtonDown then
  begin
    SetState(tsNormal);
    FStatusCloseButtonPressed := False;
    InvalidateRect(GetStatusCloseButtonRect);
  end;
  if State = tsColumnDown then
  begin
    SetState(tsNormal);
    FDownColumnIndex := -1;
    InvalidateColumn(-1);
  end;
  if State = tsColumnDragging then
    EndDragHeader(False);
  if State = tsBandButtonDown then
  begin
    SetState(tsNormal);
    FBandButtonPushed := False;
    InvalidateBandButton;
  end;
  if State = tsHeaderButtonDown then
  begin
    SetState(tsNormal);
    FHeaderButtonPushed := False;
    InvalidateHeaderButton;
  end;
  // Hide Hints
  HideStatusCloseButtonHint;
end;

procedure TCustomdxTreeList.ChangedBandAutoWidth(BandIndex, NewWidth: Integer);
var
  OldWidth, NewAutoWidth: Integer;
  I, W: Integer;
  PInfo: PSizingInfoArray;
  BandCoord, InfoCount, iStart, iEnd, TotalWidth: Integer;
begin
  InfoCount := GetBandCount;
  // calc resize band indexes
  if BandIndex = (InfoCount - 1) then
  begin
    iStart := 0;
    iEnd := InfoCount - 2;
  end
  else
  begin
    iStart := BandIndex + 1;
    iEnd := InfoCount - 1;
  end;
  PInfo := AllocMem(InfoCount * SizeOf(TSizingInfo));
  try
    NewWidth := NewWidth - Byte(BandIndex = 0) * GetIndentWidth;
    TotalWidth := 0;
    OldWidth := GetBandWidth(BandIndex);
    for I := 0 to InfoCount - 1 do
    begin
      W := GetBandWidth(I);
      if (I = 0) then Dec(W, GetIndentWidth); // Indent
      if I = BandIndex then W := NewWidth;
      if (iStart <= I) and (I <= iEnd) then
        Inc(TotalWidth, W);
      PInfo^[I].AIndex := I;
      PInfo^[I].Width := W;
    end;

    BeginUpdate;
    try
      if TotalWidth > 0 then
      begin
        BandCoord := 0;
        NewAutoWidth := TotalWidth - (NewWidth - OldWidth);
        for I := iStart to iEnd do
        begin
          if I <> iEnd then
            W := MulDiv(PInfo^[I].Width, NewAutoWidth, TotalWidth)
          else W := NewAutoWidth - BandCoord;
          PInfo^[I].Width := W;
          Inc(BandCoord, W);
        end;
        ChangeHiddenBandWidth(NewAutoWidth, TotalWidth);
      end;
      // set width
      for I := 0 to InfoCount - 1 do
        if not IsBandHeaderWidth then
          ChangedBandWidth(I, PInfo^[I].Width)
        else
        begin
          MakeBandHeaderList(True);
          ScaledBandHeaderWidth(I, PInfo^[I].Width);
        end;
    finally
      EndUpdate;
    end;
  finally
    FreeMem(PInfo);
  end;
end;

procedure TCustomdxTreeList.ChangedHeaderAutoWidth(BandIndex, AbsoluteHeaderIndex, NewWidth: Integer);
var
  OldBandWidth, NewBandWidth, OldWidth, NewAutoWidth: Integer;
  I, J, W, RIndex, CIndex, CCount, AIndex: Integer;
  PInfo: PSizingInfoArray;
  HeaderCoord, iStart, iEnd, TotalWidth: Integer;
begin
  RIndex := GetHeaderRowIndex(AbsoluteHeaderIndex);
  CIndex := GetHeaderColIndex(AbsoluteHeaderIndex);
  CCount := GetHeaderColCount(BandIndex, RIndex);
  NewWidth := NewWidth - Byte((BandIndex = 0) and (CIndex = 0)) * GetIndentWidth;
  // calc resize band indexes
  if CIndex = (CCount - 1) then
  begin
    iStart := 0;
    iEnd := CCount - 2;
  end
  else
  begin
    iStart := CIndex + 1;
    iEnd := CCount - 1;
  end;

  PInfo := AllocMem(CCount * SizeOf(TSizingInfo));
  try
    // save prev width
    OldBandWidth := GetBandWidth(BandIndex);
    OldWidth := GetHeaderBoundsWidth(AbsoluteHeaderIndex);
    if (BandIndex = 0) and (CIndex = 0) then Dec(OldWidth, GetIndentWidth); // Indent
    TotalWidth := 0;
    for I := 0 to CCount - 1 do
    begin
      AIndex := GetHeaderAbsoluteIndex(BandIndex, RIndex, I);
      W := GetHeaderBoundsWidth(AIndex);
      if (BandIndex = 0) and (I = 0) then Dec(W, GetIndentWidth); // Indent
      if I = CIndex then W := NewWidth;
      if (iStart <= I) and (I <= iEnd) then
        Inc(TotalWidth, W);
      PInfo^[I].AIndex := AIndex;
      PInfo^[I].Width := W;
    end;
    // change size
    BeginUpdate;
    try
      MakeBandHeaderList(False);
      if TotalWidth > 0 then
      begin
        HeaderCoord := 0;
        NewAutoWidth := TotalWidth - (NewWidth - OldWidth);
        for I := iStart to iEnd do
        begin
          if I <> iEnd then
            W := MulDiv(PInfo^[I].Width, NewAutoWidth, TotalWidth)
          else W := NewAutoWidth - HeaderCoord;
          PInfo^[I].Width := W;
          Inc(HeaderCoord, W);
        end;
        ChangeHiddenHeaderWidth(BandIndex, NewAutoWidth, TotalWidth);
      end;
      // set width
      NewBandWidth := 0;
      for I := 0 to CCount - 1 do
      begin
        ChangedHeaderWidth(PInfo^[I].AIndex, PInfo^[I].Width);
        Inc(NewBandWidth, PInfo^[I].Width);
      end;
      // change other rows
      if IsBandHeaderWidth and (OldBandWidth > 0) then
      begin
        for J := 0 to GetHeaderRowCount(BandIndex) - 1 do
        begin
          if J <> RIndex then
          begin
            CCount := GetHeaderColCount(BandIndex, J);
            for I := 0 to CCount - 1 do
            begin
              AIndex := GetHeaderAbsoluteIndex(BandIndex, J, I);
              W := MulDiv(GetHeaderWidth(AIndex), NewBandWidth, OldBandWidth);
              ChangedHeaderWidth(AIndex, W);
            end;
          end;
        end;
      end;
    finally
      EndUpdate;
    end;
  finally
    FreeMem(PInfo);
  end;
end;

procedure TCustomdxTreeList.DoBandDragging;
var
  DrawInfo: TdxGridDrawInfo;
  P, P1: TPoint;
  DragCur: TCursor;
  NewArrowsPos: TPoint;
  ACurWidth: Integer;
  Flag, Accept: Boolean;
  LeftEdge, RightEdge: Integer;
begin
  if (ScrollTimerID <> -1) then
  begin
    KillTimer(Handle, ScrollTimerID);
    ScrollTimerID := -1;
  end;
  GetCursorPos(P);
  NewArrowsPos := P;
  CalcDrawInfo(DrawInfo);
  try
    CalcArrowsPos(NewArrowsPos, nil, True, FDownBandIndex, FDragAbsoluteBandIndex);
    if (NewArrowsPos.X <> FArrowsPos.X) or
      (NewArrowsPos.Y <> FArrowsPos.Y) then
    begin
      DrawArrows(True);
      FArrowsPos := NewArrowsPos;
      DrawArrows(True);
    end;
    P := ScreenToClient(P);
    if PtInRect(Rect(DrawInfo.CRect.Left, DrawInfo.BandRect.Top,
      DrawInfo.CRect.Right, DrawInfo.BandRect.Bottom), P) then DragCur := Cursor
    else DragCur := crdxTreeListDeleteCursor;
    GetDragImageCursor(P, DragCur);
    Accept := DragCur <> crdxTreeListDeleteCursor;
    DoDragOverBand(P, FDragAbsoluteBandIndex, Accept);
    if not Accept then
      DragCur := crdxTreeListDeleteCursor
    else DragCur := Cursor;
    Flag := (FDragImageList.DragCursor <> DragCur);
    if Flag then FDragImageList.HideDragImage;
    FDragImageList.DragCursor := DragCur;
    if Flag then FDragImageList.ShowDragImage;
    if FDragImageList.DragCursor = crdxTreeListDeleteCursor then
       ACurWidth := 32
    else ACurWidth := 0;
    P1 := FDragImageList.GetHotSpot;
    if  FDragImageList.Dragging and
      ((P1.X <> (FDragImageList.Width - ACurWidth) div 2) or
       (P1.Y <> FDragImageList.Height div 2)) then
    begin
      P1 := ClientToScreen(Point(P.X, P.Y));
      Dec(P1.X, ACurWidth div 2);
      FDragImageList.EndDrag;
      FDragImageList.SetDragImage(0, (FDragImageList.Width - ACurWidth) div 2,
         (FDragImageList.Height) div 2);
      FDragImageList.BeginDrag(GetDeskTopWindow, P1.X, P1.Y)
    end
    else
      P1 := ClientToScreen(Point(P.X - ACurWidth div 2, P.Y));

    if not FDragImageList.Dragging then
      FDragImageList.BeginDrag(GetDeskTopWindow, P1.X, P1.Y)
    else FDragImageList.DragMove(P1.X, P1.Y);

    if not PointInCustomizingForm(P) then
    with DrawInfo do
    begin
      LeftEdge := BandRect.Left;
      if not IsRectEmpty(FixedBandLeftRect) then
        LeftEdge := FixedBandLeftRect.Right;
      RightEdge := BandRect.Right;
      if not IsRectEmpty(FixedBandRightRect) then
        RightEdge := FixedBandRightRect.Left;
      if (P.X > LeftEdge) and (P.X < LeftEdge + 3 * dxTreeListMaxResizeWidth) then
      begin
        ScrollTimerLeftFlag := True;
        ScrollTimerID := SetTimer(Handle, 1, tiHScroll, @ScrollTimerProc);
      end
      else
      if (P.X > RightEdge - 3 * dxTreeListMaxResizeWidth) and (P.X <= RightEdge) then
      begin
        ScrollTimerLeftFlag := False;
        ScrollTimerID := SetTimer(Handle, 1, tiHScroll, @ScrollTimerProc);
      end;
    end;
  finally
    FreeDrawInfo(DrawInfo);
  end;
end;

procedure TCustomdxTreeList.DoHeaderDragging;
var
  DrawInfo: TdxGridDrawInfo;
  P, P1: TPoint;
  DragCur: TCursor;
  NewArrowsPos: TPoint;
  ACurWidth: Integer;
  Flag, Accept: Boolean;
  LeftEdge, RightEdge: Integer;
begin
  if (ScrollTimerID <> -1) then
  begin
    KillTimer(Handle, ScrollTimerID);
    ScrollTimerID := -1;
  end;
  GetCursorPos(P);
  NewArrowsPos := P;
  CalcDrawInfo(DrawInfo);
  try
    CalcArrowsPos(NewArrowsPos, nil, False, FDownColumnIndex, FDragAbsoluteHeaderIndex);
    if (NewArrowsPos.X <> FArrowsPos.X) or
       (NewArrowsPos.Y <> FArrowsPos.Y) then
    begin
      DrawArrows(True);
      FArrowsPos := NewArrowsPos;
      DrawArrows(True);
    end;
    P := ScreenToClient(P);
    if PtInRect(Rect(DrawInfo.CRect.Left, DrawInfo.HeaderRect.Top,
      DrawInfo.CRect.Right, DrawInfo.HeaderRect.Bottom), P) then DragCur := Cursor
    else DragCur := crdxTreeListDeleteCursor;
    GetDragImageCursor(P, DragCur);
    Accept := DragCur <> crdxTreeListDeleteCursor;
    DoDragOverHeader(P, FDragAbsoluteHeaderIndex, Accept);
    if not Accept then
      DragCur := crdxTreeListDeleteCursor
    else DragCur := Cursor;
    Flag := (FDragImageList.DragCursor <> DragCur);
    if Flag then FDragImageList.HideDragImage;
    FDragImageList.DragCursor := DragCur;
    if Flag then FDragImageList.ShowDragImage;
    if FDragImageList.DragCursor = crdxTreeListDeleteCursor then
      ACurWidth := 32
    else ACurWidth := 0;
    P1 := FDragImageList.GetHotSpot;
    if  FDragImageList.Dragging and
      ((P1.X <> (FDragImageList.Width - ACurWidth) div 2) or
       (P1.Y <> FDragImageList.Height div 2)) then
    begin
      P1 := ClientToScreen(Point(P.X, P.Y));
      Dec(P1.X, ACurWidth div 2);
      FDragImageList.EndDrag;
      FDragImageList.SetDragImage(0, (FDragImageList.Width - ACurWidth) div 2,
         (FDragImageList.Height) div 2);
      FDragImageList.BeginDrag(GetDeskTopWindow, P1.X, P1.Y)
    end
    else
      P1 := ClientToScreen(Point(P.X - ACurWidth div 2, P.Y));

    if not FDragImageList.Dragging then
      FDragImageList.BeginDrag(GetDeskTopWindow, p1.X, p1.Y)
    else FDragImageList.DragMove(p1.X, p1.Y);

    if not PointInCustomizingForm(P) then
    with DrawInfo do
    begin
      LeftEdge := HeaderRect.Left;
      if not IsRectEmpty(FixedBandLeftRect) then
        LeftEdge := FixedBandLeftRect.Right;
      RightEdge := HeaderRect.Right;
      if not IsRectEmpty(FixedBandRightRect) then
        RightEdge := FixedBandRightRect.Left;
      if (P.X > LeftEdge) and (P.X < LeftEdge + 3 * dxTreeListMaxResizeWidth) then
      begin
        ScrollTimerLeftFlag := True;
        ScrollTimerID := SetTimer(Handle, 1, tiHScroll, @ScrollTimerProc);
      end
      else
      if (P.X > RightEdge - 3 * dxTreeListMaxResizeWidth) and (P.X <= RightEdge) then
      begin
        ScrollTimerLeftFlag := False;
        ScrollTimerID := SetTimer(Handle, 1, tiHScroll, @ScrollTimerProc);
      end;
    end;
  finally
    FreeDrawInfo(DrawInfo);
  end;
end;

procedure TCustomdxTreeList.DoScrolling;
type
  TdxScrollDirection = (dirNone, dirLeft, dirUp, dirRight, dirDown);
const
  ScrollTimeStep = 20;
  ScrollValueStep = 5;
  MaxSpeed = 12;
var
  BreakOnMouseUp: Boolean;
  AllowHorScrolling, AllowVerScrolling: Boolean;
  P, PrevP: TPoint;
  AnchorPos: TPoint;
  AnchorSize: Integer;
  AnchorWnd: HWND;
  Direction: TdxScrollDirection;
  Speed: Integer;
  TimerHits: Integer;
  Timer: UINT;
  CaptureWnd: HWND;
  Msg: TMsg;

  function CreateScrollingAnchorWnd: HWND;
  var
    B: TBitmap;
    W, H: Integer;
    Rgn: HRGN;
    DC: HDC;

    function GetResourceBitmapName: string;
    begin
      if AllowHorScrolling and AllowVerScrolling then
        Result := 'DXGRID_FULLSCROLLBITMAP'
      else
        if AllowHorScrolling then
          Result := 'DXGRID_HORSCROLLBITMAP'
        else
          Result := 'DXGRID_VERSCROLLBITMAP';
    end;

  begin
    B := TBitmap.Create;
    B.LoadFromResourceName(HInstance, GetResourceBitmapName);

    W := B.Width;
    H := B.Height;
    AnchorSize := W;
    with AnchorPos do
      Result := CreateWindow('STATIC', nil, WS_POPUP,
        X - W div 2, Y - H div 2, W, H, Handle, 0, HInstance, nil);
    Rgn := CreateEllipticRgn(0, 0, W + 1, H + 1);
    SetWindowRgn(Result, Rgn, True);
    SetWindowPos(Result, 0, 0, 0, 0, 0,
      SWP_NOZORDER or SWP_NOMOVE or SWP_NOSIZE or SWP_SHOWWINDOW or SWP_NOACTIVATE);

    DC := GetWindowDC(Result);
    BitBlt(DC, 0, 0, W, H, B.Canvas.Handle, 0, 0, SRCCOPY);
    Rgn := CreateEllipticRgn(0, 0, W + 1, H + 1);
    FrameRgn(DC, Rgn, GetSysColorBrush(COLOR_WINDOWTEXT), 1, 1);
    DeleteObject(Rgn);
    ReleaseDC(Result, DC);

    B.Free;
  end;

  procedure CalcDirectionAndSpeed(const P: TPoint);
  var
    DeltaX, DeltaY, SpeedValue: Integer;

    function GetNeutralZone: TRect;
    begin
      with AnchorPos do
        Result := Bounds(X - AnchorSize div 2, Y - AnchorSize div 2, AnchorSize, AnchorSize);
      if not AllowHorScrolling then
      begin
        Result.Left := 0;
        Result.Right := Screen.Width;
      end;
      if not AllowVerScrolling then
      begin
        Result.Top := 0;
        Result.Bottom := Screen.Height;
      end;
    end;

  begin
    if PtInRect(GetNeutralZone, P) then
    begin
      Direction := dirNone;
      Speed := 0;
      Exit;
    end
    else
    begin
      BreakOnMouseUp := True;
      DeltaX := P.X - AnchorPos.X;
      DeltaY := P.Y - AnchorPos.Y;
      if AllowHorScrolling and (not AllowVerScrolling or (Abs(DeltaX) > Abs(DeltaY))) then
      begin
        if DeltaX < 0 then Direction := dirLeft
        else Direction := dirRight;
        SpeedValue := Abs(DeltaX);
      end
      else
      begin
        if DeltaY < 0 then Direction := dirUp
        else Direction := dirDown;
        SpeedValue := Abs(DeltaY);
      end;
    end;
    Dec(SpeedValue, AnchorSize div 2);
    Speed := 1 + SpeedValue div ScrollValueStep;
    if Speed > MaxSpeed then Speed := MaxSpeed;
  end;

  procedure SetMouseCursor;
  var
    Cursor: TCursor;
  begin
    case Direction of
      dirLeft:
        Cursor := crdxTreeListLeftScroll;
      dirUp:
        Cursor := crdxTreeListUpScroll;
      dirRight:
        Cursor := crdxTreeListRightScroll;
      dirDown:
        Cursor := crdxTreeListDownScroll;
    else
      if AllowHorScrolling and AllowVerScrolling then
        Cursor := crdxTreeListFullScroll
      else
        if AllowHorScrolling then
          Cursor := crdxTreeListHorScroll
        else
          Cursor := crdxTreeListVerScroll;
    end;
    SetCursor(Screen.Cursors[Cursor]);
  end;

  procedure Scroll(Direction: TdxScrollDirection);
  begin
    case Direction of
      dirLeft: SendMessage(Handle, WM_HScroll, SB_LINEUP, 0);
      dirRight: SendMessage(Handle, WM_HScroll, SB_LINEDOWN, 0);
      dirUp: SendMessage(Handle, WM_VScroll, SB_LINEUP, 0);
      dirDown: SendMessage(Handle, WM_VScroll, SB_LINEDOWN, 0);
    end;
  end;

begin
  BreakOnMouseUp := False;
  // TODO
  AllowHorScrolling := GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0;
  AllowVerScrolling := GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL <> 0;
  GetCursorPos(PrevP);
  AnchorPos := PrevP;
  AnchorWnd := CreateScrollingAnchorWnd;
  Direction := dirNone;
  SetMouseCursor;
  Speed := 1;
  TimerHits := 0;
  Timer := SetTimer(0, 0, ScrollTimeStep, nil);

  CaptureWnd := Handle;
  SetCapture(CaptureWnd);
  try
    while GetCapture = CaptureWnd do
    begin
      case Integer(GetMessage(Msg, 0, 0, 0)) of
        -1: Break;
        0: begin
            PostQuitMessage(Msg.wParam);
            Break;
          end;
      end;
      case Msg.message of
        WM_KEYDOWN, WM_KEYUP:
          if Msg.wParam = VK_ESCAPE then Break;
        WM_MOUSEMOVE:
          begin
            P := SmallPointToPoint(TSmallPoint(Msg.lParam));
            Windows.ClientToScreen(Msg.hwnd, P);
            if (P.X <> PrevP.X) or (P.Y <> PrevP.Y) then
            begin
              CalcDirectionAndSpeed(P);
              SetMouseCursor;
              PrevP := P;
            end;
          end;
        WM_MBUTTONUP:
          if BreakOnMouseUp then Break;
        WM_TIMER:
          if UINT(Msg.wParam) = Timer then
          begin
            Inc(TimerHits);
            if TimerHits mod (MaxSpeed - Speed + 1) = 0 then Scroll(Direction);
          end;
      else
        if (Msg.message = WM_PAINT) and (Msg.hwnd = AnchorWnd) then
        begin
          ValidateRect(AnchorWnd, nil);
          Continue;
        end;
        if (Msg.message >= WM_MOUSEFIRST) and (Msg.message <= WM_MOUSELAST) then Break;
        TranslateMessage(Msg);
        DispatchMessage(Msg);
      end;
    end;
  finally
    if GetCapture = CaptureWnd then ReleaseCapture;

    KillTimer(0, Timer);
    DestroyWindow(AnchorWnd);
  end;
end;

procedure TCustomdxTreeList.FreeImageList(var AImgList: TImageList);
begin
  if AImgList <> nil then
  begin
    AImgList.Free;
    AImgList := nil;
  end;
end;

function TCustomdxTreeList.GetBandMinWidth(VisibleIndex: Integer): Integer;
var
  I, J, W: Integer;
begin
  if not CanBandSizing(VisibleIndex) then
    Result := GetBandSizeWidth(VisibleIndex)
  else Result := GetBandMinWidthSize(VisibleIndex);
  for J := 0 to GetHeaderRowCount(VisibleIndex) - 1 do
  begin
    W := 0;
    for I := 0 to GetHeaderColCount(VisibleIndex, J) - 1 do
      Inc(W, GetHeaderMinWidth(GetHeaderAbsoluteIndex(VisibleIndex, J, I)));
    if W > Result then Result := W;
  end;
end;

procedure TCustomdxTreeList.GetBandPanelResizeRanges(Y: Integer; var Min, Max: Integer);
var
  DrawInfo: TdxGridDrawInfo;
  i, Y1, Y2: Integer;
begin
  Min := Y;
  Max := Y;
  CalcRectInfo(DrawInfo);
  with DrawInfo do
  begin
    if not IsRectEmpty(BandRect) then
    begin
      Max := BandRect.Top + CalcBandHeight(1);
      for i := 2 to GetBandMaxRowCount do
      begin
        Y1 := BandRect.Top + CalcBandHeight(i - 1);
        Y2 := BandRect.Top + CalcBandHeight(i);
        if Y < (Y2 + Y1) div 2 then
        begin
          Max := BandRect.Top + CalcBandHeight(i - 1);
          Break;
        end
        else Max := BandRect.Top + CalcBandHeight(i);
      end;
      Min := Max;
    end;
  end;
end;

function TCustomdxTreeList.GetBandRealWidth(VisibleIndex: Integer): Integer;
var
  I, J, W: Integer;
begin
  Result := 0;
  if IsBandHeaderWidth then
  begin
    for J := 0 to GetHeaderRowCount(VisibleIndex) - 1 do
    begin
      W := 0;
      for I := 0 to GetHeaderColCount(VisibleIndex, J) - 1 do
        Inc(W, GetHeaderWidth(GetHeaderAbsoluteIndex(VisibleIndex, J, I)));
      if W > Result then Result := W;
    end;
  end;
  if Result = 0 then
    Result := GetBandSizeWidth(VisibleIndex);
  W := GetBandMinWidth(VisibleIndex);
  if Result < W then Result := W;
end;

procedure TCustomdxTreeList.GetBandResizeRanges(VisibleIndex, X: Integer; var Start, Min, Max: Integer);
var
  DrawInfo: TdxGridDrawInfo;
  i:Integer;
begin
  Min := X;
  Max := X;
  CalcDrawInfo(DrawInfo);
  try
    with DrawInfo do
    if BandsInfo <> nil then
    begin
      for i := 0 to BandCount - 1 do
      begin
        if BandsInfo^[i].Index = VisibleIndex then
        begin
          with BandsInfo^[i].BandRect do
          begin
            Start := Left;
            Min := Start + GetBandMinWidth(VisibleIndex) + Byte(BandsInfo^[i].Index = 0) * GetIndentWidth;
            if CanBandFullSizing(VisibleIndex) then
              Max := 100000
            else Max := ClientWidth - 2;
          end;
          Break;
        end;
      end;
    end;
  finally
    FreeDrawInfo(DrawInfo);
  end;
end;

function TCustomdxTreeList.GetBandTotalWidth: Integer;
var
  I, W: Integer;
  FlagNotSizing: Boolean;
begin
  if GetBandCount = 0 then
    Result := 0
  else
  if not IsAutoWidth then
  begin
    Result := GetIndentWidth;
    for i := 0 to GetBandCount - 1 do
      Inc(Result, GetBandWidth(i));
  end
  else
  begin
    with GetHorzGridRect do
      Result := Right - Left;
    // Check MinWidth
    W := GetIndentWidth;
    FlagNotSizing := True;
    for I := 0 to GetBandCount - 1 do
    begin
      Inc(W, GetBandMinWidth(I));
      if CanBandSizing(I) then
        FlagNotSizing := False;
    end;
    if (Result < W) or FlagNotSizing then Result := W;
  end;
end;

function TCustomdxTreeList.GetBandWidth(VisibleIndex: Integer): Integer;
var
  I, TotalWidth, W, MinW, AllWidth,
  MinRealWidth, ScaledWidth, RealWidth, CalcWidth: Integer;
begin
  if IsAutoWidth then
  begin
    if VisibleIndex = GetBandCount - 1 then
    begin
      // calc all width without self
      AllWidth := GetIndentWidth;
      for I := 0 to GetBandCount - 2 do
        Inc(AllWidth, GetBandWidth(I));
      Result := GetBandTotalWidth - AllWidth;
    end
    else
    begin
      // calc total width
      TotalWidth := 0;
      MinRealWidth := 0;
      for I := 0 to GetBandCount - 1 do
      begin
        Inc(TotalWidth, GetBandRealWidth(I));
        Inc(MinRealWidth, GetBandMinWidth(I));
      end;
      RealWidth := GetBandTotalWidth - GetIndentWidth;
      // calc scaled total width
      ScaledWidth := 0;
      for I := 0 to GetBandCount - 1 do
      begin
        W := GetBandRealWidth(I);
        MinW := GetBandMinWidth(I);
        if CanBandSizing(I) then
          if MulDiv(RealWidth, W, TotalWidth) > MinW then Inc(ScaledWidth, W);
      end;
      // calc real width
      W := GetBandRealWidth(VisibleIndex);
      MinW := GetBandMinWidth(VisibleIndex);
      CalcWidth := MulDiv(RealWidth, W, TotalWidth);
      if not CanBandSizing(VisibleIndex) then
        Result := W
      else
      if ScaledWidth <> TotalWidth then
        if CalcWidth > MinW then
          Result := MinW + MulDiv(RealWidth - MinRealWidth, W, ScaledWidth)
        else Result := MinW
      else Result := CalcWidth;
    end;
  end
  else Result := GetBandRealWidth(VisibleIndex);
end;

function TCustomdxTreeList.GetFocusedColumnAbsoluteIndex: Integer;
begin
  if FFocusedAbsoluteIndex = -1 then
    FFocusedAbsoluteIndex := GetFocusedAbsoluteIndex(FocusedColumn);
  Result := FFocusedAbsoluteIndex;
end;

procedure TCustomdxTreeList.SetFocusedColumnAbsoluteIndex(Value: Integer);
begin
  if FocusedAbsoluteIndex <> Value then
    FocusedColumn := GetFocusedVisibleIndex(Value);
end;

function TCustomdxTreeList.GetHeaderBoundsWidth(AbsoluteIndex: Integer): Integer;
var
  I, AIndex, BIndex, RIndex, CIndex, CCount: Integer;
  HeaderLeftCoord, HeaderTotalWidth, RealBandWidth, BandWidth,
  ScaledWidth, HeaderTotalMinWidth, W, MinW: Integer;
  FlagScaled: Boolean;

  function CalcWidth(AIndex: Integer): Integer;
  var
    MinW, W, CalcWidth: Integer;
  begin
    W := GetHeaderWidth(AIndex);
    MinW := GetHeaderMinWidth(AIndex);
    CalcWidth := MulDiv(RealBandWidth, W, HeaderTotalWidth);
    if CanHeaderSizing(AIndex) then
    begin
      if ScaledWidth <> HeaderTotalWidth then
        if CalcWidth > MinW then
        begin
          if FlagScaled then
            W := MinW + MulDiv(RealBandWidth - HeaderTotalMinWidth, W, ScaledWidth)
          else W := CalcWidth;
        end
        else W := MinW
      else W := CalcWidth;
    end
    else
    begin
      Dec(RealBandWidth, W);
      Dec(HeaderTotalWidth, W);
      Dec(HeaderTotalMinWidth, W);
    end;
    Result := W;
  end;

begin
  BIndex := GetVisibleBandIndex(GetHeaderBandIndex(AbsoluteIndex));
  RIndex := GetHeaderRowIndex(AbsoluteIndex);
  CIndex := GetHeaderColIndex(AbsoluteIndex);
  CCount := GetHeaderColCount(BIndex, RIndex);
  HeaderLeftCoord := 0;
  BandWidth := GetBandWidth(BIndex);
  RealBandWidth := BandWidth;
  HeaderTotalWidth := GetHeaderTotalWidth(BIndex, RIndex);
  HeaderTotalMinWidth := GetHeaderTotalMinWidth(BIndex, RIndex);
  // calc scaled total width
  ScaledWidth := 0;
  FlagScaled := False;
  for I := 0 to CCount - 1 do
  begin
    AIndex := GetHeaderAbsoluteIndex(BIndex, RIndex, I);
    W := GetHeaderWidth(AIndex);
    MinW := GetHeaderMinWidth(AIndex);
    if CanHeaderSizing(AIndex) then
      if MulDiv(RealBandWidth, W, HeaderTotalWidth) >= MinW then Inc(ScaledWidth, W)
      else FlagScaled := True;
  end;
  // calc real width
  Result := RealBandWidth;
  for I := 0 to CCount - 1 do
  begin
    if I <> (CCount - 1){not last} then
    begin
      AIndex := GetHeaderAbsoluteIndex(BIndex, RIndex, I);
      Result := CalcWidth(AIndex);
      if AIndex = AbsoluteIndex then Break;
    end
    else Result := BandWidth - HeaderLeftCoord;
    Inc(HeaderLeftCoord, Result);
  end;
  if (BIndex = 0) and (CIndex = 0) then Inc(Result, GetIndentWidth); // Indent
end;

(*
function TCustomdxTreeList.GetHeaderBoundsWidth(AbsoluteIndex: Integer): Integer;
var
  I, AIndex, BIndex, RIndex, CIndex, CCount: Integer;
  HeaderLeftCoord, HeaderTotalWidth, RealBandWidth,
  ScaledWidth, HeaderTotalMinWidth, W, MinW: Integer;

  function CalcWidth(AIndex: Integer): Integer;
  var
    MinW, W, CalcWidth: Integer;
  begin
    W := GetHeaderWidth(AIndex);
    MinW := GetHeaderMinWidth(AIndex);
    CalcWidth := MulDiv(RealBandWidth, W, HeaderTotalWidth);
    if CanHeaderSizing(AIndex) then
    begin
      if ScaledWidth <> HeaderTotalWidth then
        if CalcWidth > MinW then
          W := MinW + MulDiv(RealBandWidth - HeaderTotalMinWidth, W, ScaledWidth)
        else W := MinW
      else W := CalcWidth;
    end;
    Result := W;
  end;

begin
  BIndex := GetVisibleBandIndex(GetHeaderBandIndex(AbsoluteIndex));
  RIndex := GetHeaderRowIndex(AbsoluteIndex);
  CIndex := GetHeaderColIndex(AbsoluteIndex);
  CCount := GetHeaderColCount(BIndex, RIndex);
  HeaderLeftCoord := 0;
  RealBandWidth := GetBandWidth(BIndex);
  HeaderTotalWidth := GetHeaderTotalWidth(BIndex, RIndex);
  HeaderTotalMinWidth := GetHeaderTotalMinWidth(BIndex, RIndex);
  // calc scaled total width
  ScaledWidth := 0;
  for I := 0 to CCount - 1 do
  begin
    AIndex := GetHeaderAbsoluteIndex(BIndex, RIndex, I);
    W := GetHeaderWidth(AIndex);
    MinW := GetHeaderMinWidth(AIndex);
    if CanHeaderSizing(AIndex) then
      if MulDiv(RealBandWidth, W, HeaderTotalWidth) > MinW then Inc(ScaledWidth, W);
  end;
  // calc real width
  Result := RealBandWidth;
  if CIndex = (CCount - 1) then
  begin
    for I := 0 to CCount - 1 do
    begin
      if I <> (CCount - 1){not last} then
      begin
        AIndex := GetHeaderAbsoluteIndex(BIndex, RIndex, I);
        Result := CalcWidth(AIndex);
//        Result := MulDiv(RealBandWidth, GetHeaderWidth(AIndex), HeaderTotalWidth)
      end
      else Result := RealBandWidth - HeaderLeftCoord;
      Inc(HeaderLeftCoord, Result);
    end;
  end
  else
  begin
    Result := CalcWidth(AbsoluteIndex);
//    Result := MulDiv(RealBandWidth, GetHeaderWidth(AbsoluteIndex), HeaderTotalWidth);
  end;
  if (BIndex = 0) and (CIndex = 0) then Inc(Result, GetIndentWidth); // Indent
end;
*)
function TCustomdxTreeList.GetHeaderLineCount(BandIndex, RowIndex, ColIndex: Integer): Integer;
var
  C: Integer;
begin
  Result := 1;
  if RowIndex = GetHeaderRowCount(BandIndex) - 1 then // is last line
  begin
    C := GetHeaderMaxRowCount;
    Result := GetHeaderMaxLineCount(GetHeaderAbsoluteIndex(BandIndex, RowIndex, ColIndex));
    if Result = 0 then Result := C;
    if (Result + RowIndex) > C then
      Result := C - RowIndex;
  end;
end;

procedure TCustomdxTreeList.GetHeaderPanelResizeRanges(Y: Integer; var Min, Max: Integer);
var
  DrawInfo: TdxGridDrawInfo;
  I: Integer;
begin
  Min := Y;
  Max := Y;
  CalcRectInfo(DrawInfo);
  with DrawInfo do
  begin
    if not IsRectEmpty(HeaderRect) then
    begin
      I := (Y - HeaderRect.Top + FHeaderRowHeight div 2) div FHeaderRowHeight;
      if I < 1 then I := 1;
      if I > GetHeaderMaxLimitRowCount then
         I := GetHeaderMaxLimitRowCount;
      Max := HeaderRect.Top + FHeaderRowHeight * I;
      Min := Max;
    end;
  end;
end;

procedure TCustomdxTreeList.GetHeaderResizeRanges(AbsoluteIndex, X: Integer; var Start, Min, Max: Integer);
var
  DrawInfo: TdxGridDrawInfo;
  i, j: Integer;
begin
  Min := X;
  Max := X;
  CalcDrawInfo(DrawInfo);
  try
    with DrawInfo do
    if HeadersInfo <> nil then
    begin
      for i := 0 to HeaderCount - 1 do
      begin
        if HeadersInfo^[i].AbsoluteIndex = AbsoluteIndex then
        begin
          with HeadersInfo^[i].HeaderRect do
          begin
            Start := Left;
            Min := Left + GetHeaderMinWidth(AbsoluteIndex) +
              Byte((HeadersInfo^[i].BandIndex = 0) and (HeadersInfo^[i].ColIndex = 0)) * GetIndentWidth;
            if not IsAutoWidth and CanHeaderFullSizing(AbsoluteIndex) then
              Max := 100000
            else
            if CanHeaderBandSizing then
              Max := ClientWidth - 1
            else // calc band range coord
            begin
              Max := HeadersInfo^[i].HeaderRect.Right;
              for j := 0 to BandCount - 1 do
              begin
                if BandsInfo^[j].Index = HeadersInfo^[i].BandIndex then
                begin
                  Max := BandsInfo^[j].BandRect.Right;
                  Break;
                end;
              end;
            end;
          end;
          Break;
        end;
      end;
    end;
  finally
    FreeDrawInfo(DrawInfo);
  end;
end;

function TCustomdxTreeList.GetHeaderTotalMinWidth(BandIndex, RowIndex: Integer): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to GetHeaderColCount(BandIndex, RowIndex) - 1 do
    Inc(Result, GetHeaderMinWidth(GetHeaderAbsoluteIndex(BandIndex, RowIndex, i)));
end;

function TCustomdxTreeList.GetHeaderTotalWidth(BandIndex, RowIndex: Integer): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to GetHeaderColCount(BandIndex, RowIndex) - 1 do
    Inc(Result, GetHeaderWidth(GetHeaderAbsoluteIndex(BandIndex, RowIndex, i)));
end;

function TCustomdxTreeList.GetHorzGridRect: TRect;
begin
  Result := ClientRect;
  if FShowIndicator then
    Inc(Result.Left, FIndicatorWidth);
  Dec(Result.Bottom, FStatusHeight);  
end;

function TCustomdxTreeList.GetNodeFooterLevel(Node: TdxTreeListNode; Index: Integer): Integer;
var
  FooterIndex, L: Integer;
begin
  Result := -1;
  FooterIndex := -1;
  if IsShowRowFooter and not Node.HasChildren and Node.IsLast then
  begin
    Node := Node.Parent;
    while Node <> nil do
    begin
      L := Node.Level;
      if IsLevelFooter(L) then
      begin
        Result := L;
        Inc(FooterIndex);
      end;
      if FooterIndex = Index then
        Break;
      Node := Node.Parent;
    end;
  end;
end;

function TCustomdxTreeList.GetNodeFooterRowCount(Node: TdxTreeListNode; Level: Integer): Integer;
var
  i, L: Integer;
begin
  Result := -1;
  if not Node.HasChildren and Node.IsLast then
  begin
    Result := 0;
    for i := 0 to GetRowFooterCount(Node) - 1 do
    begin
      L := GetNodeFooterLevel(Node, i);
      if Level > L then Inc(Result);
    end;
  end;
end;

procedure TCustomdxTreeList.GetNodeIndent(ANode: TdxTreeListNode; var AIndent, AImageIndent: Integer);
begin
  if ANode.HasChildren then
    AIndent := (ANode.Level + 1) * FIndent
  else AIndent := (ANode.Level + Byte(FPaintStandard)) * FIndent;
  if not ShowRoot then Dec(AIndent, FIndent);
  AImageIndent := AIndent;
  if ANode.StateIndex <> -1 then Inc(AImageIndent, FImageStateW);
  Inc(AImageIndent, FImageW); // if Assigned(Images) -> FImageW > 0  
end;

function TCustomdxTreeList.GetPreviewBoundsWidth(Node: TdxTreeListNode): Integer;
var
  Ind, Indent: Integer;
begin
  GetNodeIndent(Node, Ind, Indent);
  Result := GetBandTotalWidth - Byte(FShowGrid) - Indent;
end;

function TCustomdxTreeList.GetRowHeight(Node: TdxTreeListNode; FHeight: Integer; ReCalc: Boolean): Integer;
var
  PreviewCount, L, H: Integer;
begin
  // speed
  if IsSmartRecalcRowHeight then
    if not ReCalc and (Node <> nil) and (Node.FRowHeight <> 0) then
    begin
      Result := Node.FRowHeight;
      Exit;
    end;
  if Node <> nil then Node.FRowLineCount := 0; // TODO NEW
  if IsShowPreview then
    PreviewCount := GetRowPreviewLineCount(Node)
  else PreviewCount := 0;
  if FShowGrid then
    Result := GetRowSeparatorLineWidth
  else Result := 0;
  {begin ^^^}
  if (Node <> nil) and IsCalcRowAutoHeight then
  begin
    H := FHeight;
    L := GetRowLineCount(Node, H);
    if (L > 1) and (H = FHeight) then
      Inc(FHeight, FTextHeight*(L - 1));
    if H > FHeight then FHeight := H;
  end
  else
    L := 0;
  {end ^^^}
  if (Node <> nil) and IsRowGroup(Node) then
  begin
    Inc(Result, FHeight{FRowHeight} - Byte(FShowGrid));
    if FShowGrid then Inc(Result);
  end
  else
  begin
    Inc(Result, GetHeaderMaxRowCount * FHeight{FRowHeight} +
      PreviewCount * FDescTextHeight +
      Byte((PreviewCount > 0) and FShowGrid and FShowPreviewGrid));
  end;
  if not FShowGrid and (Node <> nil) and Node.HasChildren and not FPaintStandard then Inc(Result);
  if (PreviewCount > 0) and (Node <> nil) and not IsRowGroup(Node) then Inc(Result, 2);
  if FShowGrid and FShowPreviewGrid then Dec(Result);
  Inc(Result, GetRowFooterCount(Node) * FFooterRowNodeHeight);

  // speed
  if not ReCalc and (Node <> nil) then
  begin
    Node.FRowHeight := Result;
    Node.FRowLineCount := L; // TODO NEW
  end;
end;

function TCustomdxTreeList.GetRowFooterCount(Node: TdxTreeListNode): Integer;
var
  ANode: TdxTreeListNode;
begin
  Result := 0;
  if IsShowRowFooter and (Node <> nil) and not Node.HasChildren and Node.IsLast then
  begin
    ANode := Node.Parent;
    while ANode <> nil do
    begin
      if Node.IsLast then
      begin
        if IsLevelFooter(ANode.Level) then
          Inc(Result);
        Node := ANode;
        ANode := ANode.Parent;
      end
      else Break;
    end;
  end;
end;

procedure TCustomdxTreeList.GetRowResizeRanges(Node: TdxTreeListNode; Y: Integer; var Min, Max: Integer);
var
  DrawInfo: TdxGridDrawInfo;
begin
  Min := Y;
  Max := Y;
  if Node <> nil then
  begin
    CalcRectInfo(DrawInfo);
    with DrawInfo do
    begin
      Min := GetRectNode(Node).Top + GetRowHeight(Node, FMinRowHeight, True{ReCalc});
      if not IsRectEmpty(FooterRect) then
        Max := FooterRect.Top - 1
      else Max := CRect.Bottom - 1;
    end;
  end;
end;

function TCustomdxTreeList.GetScrollableBandWidth: Integer;
var
  FixedIndex: Integer;
begin
  Result := GetBandTotalWidth;
  FixedIndex := GetBandFixedLeft;
  if FixedIndex <> -1 then
    Dec(Result, GetBandWidth(FixedIndex) + GetIndentWidth);
  FixedIndex := GetBandFixedRight;
  if FixedIndex <> -1 then
    Dec(Result, GetBandWidth(FixedIndex));
end;

function TCustomdxTreeList.GetScrollableWidth: Integer;
var
  R: TRect;
begin
  R := GetScrollHorzGridRect;
  Result := R.Right - R.Left;
end;

function TCustomdxTreeList.GetScrollHorzGridRect: TRect;
var
  FixedIndex: Integer;
begin
  Result := GetHorzGridRect;
  Inc(Result.Top, FGroupPanelHeight);
  if not IsAutoWidth then
  begin
    FixedIndex := GetBandFixedLeft;
    if FixedIndex <> -1 then
      Inc(Result.Left, GetBandWidth(FixedIndex) + GetIndentWidth);
    FixedIndex := GetBandFixedRight;
    if FixedIndex <> -1 then
      Dec(Result.Right, GetBandWidth(FixedIndex));
  end;
end;

function TCustomdxTreeList.GetStartBandCoord(VisibleIndex: Integer): Integer;
var
  I, iStart: Integer;
begin
  Result := 0;
  if (GetBandCount > 1) and (VisibleIndex >= 0) and (VisibleIndex < GetBandCount) then
  begin
    if (VisibleIndex <> GetBandFixedLeft) and (VisibleIndex <> GetBandFixedRight) then
    begin
      iStart := 0;
      if GetBandFixedLeft <> -1 then Inc(iStart);
      for i := iStart to VisibleIndex - 1 do
        Inc(Result, GetBandWidth(I) + Byte(I = 0)*GetIndentWidth);
    end;
  end;
end;

function TCustomdxTreeList.GetVisibleHeaderCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to GetHeaderAbsoluteCount - 1 do
    if IsHeaderVisible(I) then Inc(Result);
end;

procedure TCustomdxTreeList.HideDragImages;
begin
  if FLockHideDragImages = 0 then
  begin
    if State in [tsColumnSizing, tsBandSizing, tsBandPanelSizing,
      tsHeaderPanelSizing, tsRowSizing] then DrawSizingLine;
    if (FDragImageList <> nil) and FDragImageList.Dragging then
      FDragImageList.HideDragImage;
    if State in [tsBandDragging, tsColumnDragging] then
      DrawArrows(False);
    {new modification}
    if (FDragObject <> nil) then
      FDragObject.HideDragImage;
  end;
  Inc(FLockHideDragImages);
end;

function TCustomdxTreeList.IsCalcRowAutoHeight: Boolean;
begin
  Result := not IsShowPreview and (GetHeaderMaxRowCount = 1) and IsRowAutoHeight;
end;

function TCustomdxTreeList.IsFixedBand(VisibleIndex: Integer): Boolean;
begin
  Result := False;
//  Result := not (csDesigning in ComponentState) and
//    ((VisibleIndex = GetBandFixedRight) or (VisibleIndex = GetBandFixedLeft));
end;

function TCustomdxTreeList.IsFixedBandHeader(AbsoluteIndex: Integer): Boolean;
{var
  I: Integer;}
begin
  Result := False;
{  if csDesigning in ComponentState then
    Result := False
  else
  begin
    I := GetVisibleBandIndex(GetHeaderBandIndex(AbsoluteIndex));
    Result := (I <> -1) and ((I = GetBandFixedLeft) or (I = GetBandFixedRight));
  end;}
end;

procedure TCustomdxTreeList.PrepareArrowsRect(IsBand: Boolean);
begin
  if IsBand then
    FArrowsRect := Rect(0, 0, arWidth{9}, FBandHeight + 2*arHeight{9})
  else FArrowsRect := Rect(0, 0, arWidth{9}, FHeaderRowHeight + 2*arHeight{9});
  with SaveArrowsBitmap, FArrowsRect Do
  begin
    Width := Max(Width, Right - Left);
    Height := Max(Height, Bottom - Top);
  end;
end;

procedure TCustomdxTreeList.PrepareDragBand(AbsoluteIndex: Integer);
var
  bmp: TBitmap;
  I, W: Integer;
  S: string;
  R: TRect;
  AAlignment: TAlignment;
begin
  bmp := TBitmap.Create;
  with bmp do
  begin
    I := GetVisibleBandIndex(AbsoluteIndex);
    if I <> -1 then
      W := GetBandWidth(I)
    else W := GetAbsoluteBandWidth(AbsoluteIndex);
    if AbsoluteIndex = 0 then Inc(W, GetIndentWidth); // Indent
    // check width
    if W > Screen.Width then W := Screen.Width; 
    Width := W;
    Height := FBandHeight;
  end;
  with bmp.Canvas do
  begin
    Font.Assign(BandFont);
    Brush.Color := BandColor;
    S := GetAbsoluteBandText(AbsoluteIndex);
    AAlignment := GetAbsoluteBandAlignment(AbsoluteIndex);
    R := Rect(0, 0, bmp.Width, bmp.Height);
    DrawBand(Handle, R, Brush.Handle, S, False{ADown},
      (FBandRowCount > 1){AMultiLine}, AAlignment, csNone{no sorted}, nil {no glyph}, hbNormal, LookAndFeel, []);
  end;
  // check image list
  if FDragImageList = nil then
    FDragImageList := TImageList.CreateSize(bmp.Width, bmp.Height);
  FDragImageList.AddMasked(bmp, clNone);
  bmp.Free;
end;

procedure TCustomdxTreeList.PrepareDragHeader(AbsoluteIndex: Integer);
var
  DrawInfo: TdxGridDrawInfo;
  bmp: TBitmap;
  I, W: Integer;
  S: string;
  R: TRect;
  AAlignment: TAlignment;
  ASorted: TdxTreeListColumnSort;
  AGlyph: TBitmap;
begin
  bmp := TBitmap.Create;
  if IsHeaderVisible(AbsoluteIndex) then
    W := GetHeaderBoundsWidth(AbsoluteIndex)
  else W := GetHeaderWidth(AbsoluteIndex);
  if IsHeaderVisible(AbsoluteIndex) then //is Visible Header
  begin
    CalcDrawInfo(DrawInfo);
    with DrawInfo do
    begin
      for i := 0 to HeaderCount - 1 do
      if HeadersInfo^[i].AbsoluteIndex = AbsoluteIndex then
      with HeadersInfo^[i] do
      begin
        W := HeaderRect.Right - HeaderRect.Left;
        Break;
      end;
    end;
    FreeDrawInfo(DrawInfo);
  end;
  // check width
  if W <= 0 then W := 20;
  if W > Screen.Width then W := Screen.Width;
  S := GetHeaderText(AbsoluteIndex);
  AAlignment := GetHeaderAlignment(AbsoluteIndex);
  ASorted := GetHeaderSorted(AbsoluteIndex);
  if IsExistHeaderGlyph(AbsoluteIndex) then
    AGlyph := GetHeaderGlyph(AbsoluteIndex)
  else AGlyph := nil;
  // draw bitmap
  with bmp, Canvas do
  begin
    Width := W;
    Height := FHeaderRowHeight;
    Font.Assign(HeaderFont);
    Brush.Color := HeaderColor;
    R := Rect(0, 0, bmp.Width, bmp.Height);
    DrawBand(Handle, R, Brush.Handle, S, False{ADown},
      False{AMultiLine}, AAlignment, ASorted, AGlyph, hbNormal, LookAndFeel, []);
  end;
  // check image list
  if FDragImageList = nil then
    FDragImageList := TImageList.CreateSize(bmp.Width, bmp.Height);
  FDragImageList.AddMasked(bmp, clNone);
  bmp.Free;
end;

procedure TCustomdxTreeList.PrepareDragNode(Node: TdxTreeListNode; Column: Integer{absolute index});
const
  DragIndent = 20;
var
  bmp: TBitmap;
  W: Integer;
  S: string;
  R, R1: TRect;
begin
  bmp := TBitmap.Create;
  if Column = -1 then
    Column := 0;
  if GetVisibleHeaderCount > 0 then
  begin
    R := CellRect(Node, GetFocusedVisibleIndex(Column));
    S := GetNodeDragText(Node, Column);
  end
  else
  begin
    R := Rect(0, 0, FRowHeight, 16);
    S := '';
  end;
  W := R.Right - R.Left;
  // draw bitmap
  with bmp, Canvas do
  begin
    Width := W + 6 + DragIndent;
//    Height := FRowHeight + 6;
    Height := R.Bottom - R.Top{Node.FRowHeight} + 6;
    Font.Assign(Self.Font);
    Brush.Color := Self.Color;
    R := Rect(0, 0, bmp.Width, bmp.Height);
    FillRect(R);
    Inc(R.Left, DragIndent);
    // Draw Frame
    DrawFocusRect(R);
    InflateRect(R, -1, -1);
    DrawFocusRect(R);
    InflateRect(R, -1, -1);
    DrawFocusRect(R);
    InflateRect(R, -1, -1);
    // Draw Images
    R1 := R;
    if Node.StateIndex <> -1 then
    begin
      R1.Right := R1.Left + FImageStateW;
      WriteImage(bmp.Canvas, R1, StateImages, Node.StateIndex);
      R1.Left := R1.Right;
    end;
    if Node.ImageIndex <> -1 then
    begin
      R1.Right := R1.Left + FImageW;
      WriteImage(bmp.Canvas, R1, Images, Node.ImageIndex);
      R1.Left := R1.Right;
    end;
    // Draw text
    R1.Right := R.Right;
    SetBkMode(Handle, Windows.TRANSPARENT);
    DrawText(Handle, PChar(S), Length(S), R1, DT_LEFT {or DT_VCENTER or DT_SINGLELINE }or DT_WORDBREAK or // TODO ?
      DT_EXPANDTABS or DT_NOPREFIX or DT_END_ELLIPSIS);
  end;
  // check image list
  if FDragImageList = nil then
    FDragImageList := TImageList.CreateSize(bmp.Width, bmp.Height);
  FDragImageList.AddMasked(bmp, Self.Color);
  bmp.Free;
end;

procedure TCustomdxTreeList.ResetTopFocusedNodes;
begin
  FFocused := Items[0];
  SetTopVisibleNode(FFocused);
end;

procedure TCustomdxTreeList.ScaledBandHeaderWidth(BandIndex, NewWidth: Integer);
var
  OldWidth: Integer;
  I, J, W, AIndex: Integer;
  PInfo: PSizingInfoArray;
  InfoCount: Integer;
  PrevLockUpdate: Boolean;
begin
  OldWidth := GetBandWidth(BandIndex);
  NewWidth := NewWidth - Byte(BandIndex = 0) * GetIndentWidth;
  PInfo := AllocMem(GetVisibleHeaderCount * SizeOf(TSizingInfo));
  InfoCount := 0;
  try
    for J := 0 to GetHeaderRowCount(BandIndex) - 1 do
      for I := 0 to GetHeaderColCount(BandIndex, J) - 1 do
      begin
        AIndex := GetHeaderAbsoluteIndex(BandIndex, J, I);
        W := GetHeaderBoundsWidth(AIndex);
        if (BandIndex = 0) and (I = 0) then Dec(W, GetIndentWidth); // Indent
        PInfo^[InfoCount].AIndex := AIndex;
        PInfo^[InfoCount].Width := W;
        Inc(InfoCount);
      end;
    PrevLockUpdate := (LockUpdate <> 0);
    if not PrevLockUpdate then BeginUpdate;
    try
      for I := 0 to InfoCount - 1 do
      begin
        W := MulDiv(PInfo^[I].Width, NewWidth, OldWidth);
        ChangedHeaderWidth(PInfo^[I].AIndex, W);
      end;
      ChangeHiddenHeaderWidth(BandIndex, NewWidth, OldWidth);
      ChangedBandWidth(BandIndex, NewWidth);
    finally
      if not PrevLockUpdate then EndUpdate;
    end;
  finally
    FreeMem(PInfo);
  end;
end;

procedure TCustomdxTreeList.ScaledHeaderBandWidth(BandIndex, AbsoluteHeaderIndex, NewWidth: Integer);
var
  I, J, W, AIndex, RIndex, CIndex, Ccount: Integer;
  PInfo: PSizingInfoArray;
  InfoCount: Integer;
  HeaderCoord, OldBandWidth, NewBandWidth, OldWidth: Integer;
begin
  PInfo := AllocMem(GetVisibleHeaderCount * SizeOf(TSizingInfo));
  InfoCount := 0;
  try
    OldBandWidth := GetBandWidth(BandIndex);
    OldWidth := GetHeaderBoundsWidth(AbsoluteHeaderIndex);
    NewBandWidth := OldBandWidth + (NewWidth - OldWidth);
    RIndex := GetHeaderRowIndex(AbsoluteHeaderIndex);
    CIndex := GetHeaderColIndex(AbsoluteHeaderIndex);
    NewWidth := NewWidth - Byte((BandIndex = 0) and (CIndex = 0)) * GetIndentWidth;
    for J := 0 to GetHeaderRowCount(BandIndex) - 1 do
    begin
      HeaderCoord := 0;
      CCount := GetHeaderColCount(BandIndex, J);
      for I := 0 to CCount - 1 do
      begin
        AIndex := GetHeaderAbsoluteIndex(BandIndex, J, I);
        W := GetHeaderBoundsWidth(AIndex);
        if (BandIndex = 0) and (I = 0) then Dec(W, GetIndentWidth); // Indent
        if J = RIndex then
        begin
          if I = (CCount - 1) then
            W := NewBandWidth - HeaderCoord
          else
          if AIndex = AbsoluteHeaderIndex then
            W := NewWidth;
        end
        else
          if I <> (CCount - 1) then
            W := MulDiv(W, NewBandWidth, OldBandWidth)
          else W := NewBandWidth - HeaderCoord;
        Inc(HeaderCoord, W);
        PInfo^[InfoCount].AIndex := AIndex;
        PInfo^[InfoCount].Width := W;
        Inc(InfoCount);
      end;
    end;
    // change width
    BeginUpdate;
    try
      for I := 0 to InfoCount - 1 do
        ChangedHeaderWidth(PInfo^[I].AIndex, PInfo^[I].Width);
      ChangeHiddenHeaderWidth(BandIndex, NewBandWidth, OldBandWidth);
    finally
      EndUpdate;
    end;
  finally
    FreeMem(PInfo);
  end;
end;

procedure TCustomdxTreeList.ScrollGridHorz(Distance: Integer); // TODO - animation
var
  R: TRect;
begin
  R := GetScrollHorzGridRect;
  ScrollWindowEx(Handle, Distance, 0, @R, @R, 0, nil, SW_INVALIDATE);
end;

procedure TCustomdxTreeList.ScrollGridVert(Distance: Integer); // TODO - animation
var
  R: TRect;
begin
  R := GetScrollVertGridRect;
  ScrollWindowEx(Handle, 0, Distance, @R, @R, 0, nil, SW_INVALIDATE);
  if FPaintStandard and (TreeLineStyle = tlDot) then
  begin
    R.Right := R.Left + GetBandWidth(0) + GetIndentWidth;
    if GetBandFixedLeft <> -1 then
      Dec(R.Right, LeftCoord);
    Windows.InvalidateRect(Handle, @R, False);
  end;
end;

procedure TCustomdxTreeList.ShowDragImages;
begin
  Dec(FLockHideDragImages);
  if FLockHideDragImages = 0 then
  begin
    if State in [tsColumnSizing, tsBandSizing, tsBandPanelSizing,
      tsHeaderPanelSizing, tsRowSizing] then DrawSizingLine;
    if State in [tsBandDragging, tsColumnDragging] then
      DrawArrows(False);
    if (FDragImageList <> nil) and FDragImageList.Dragging then
      FDragImageList.ShowDragImage;
    {new modification}
    if (FDragObject <> nil) then
      FDragObject.ShowDragImage;
  end;
end;

procedure TCustomdxTreeList.UpdateCustomizingColumns;
begin
  if (FCustomizingBandListBox <> nil) then
  begin
    FCustomizingBandListBox.Flat := Boolean(Self.LookAndFeel <> lfStandard);
    FCustomizingBandListBox.UpdateItems;
  end;
  if (FCustomizingHeaderListBox <> nil) then
  begin
    FCustomizingHeaderListBox.Flat := Boolean(Self.LookAndFeel <> lfStandard);
    FCustomizingHeaderListBox.UpdateItems;
  end;
end;

procedure TCustomdxTreeList.UpdateDragging;
begin
  UpdateWindow(Handle);
end;

// Copy to text format
const
  EndOfLine = #13#10;
  ColumnSeparator = #9;

function TCustomdxTreeList.GetHeaderTabText: string;
var
  I, C: Integer;
begin
  Result := '';
  C := GetVisibleHeaderCount;
  for I := 0 to C - 1 do
  begin
    Result := Result + GetHeaderText(GetFocusedAbsoluteIndex(I));
    if I <> (C - 1) then
      Result := Result + ColumnSeparator;
  end;
  Result := Result + EndOfLine;
end;

function TCustomdxTreeList.GetNodeTabText(ANode: TdxtreeListNode): string;
var
  I, C: Integer;
begin
  Result := '';
  if IsRowGroup(ANode) then
    Result := ANode.Strings[0]
  else
  begin
    C := GetVisibleHeaderCount; 
    for I := 0 to C - 1 do
    begin
      Result := Result + ANode.Strings[GetFocusedAbsoluteIndex(I)];
      if I <> (C - 1) then
        Result := Result + ColumnSeparator;
    end;
  end;  
end;

// based
function TCustomdxTreeList.AcquireFocus: Boolean;
begin
  Result := True;
end;

procedure TCustomdxTreeList.AddNode(Node: TdxTreeListNode);
var
  RedrawNode: TdxTreeListNode;
begin
  {Close Edit}
  CancelEditor;
  if TopVisibleNode = nil then SetTopVisibleNode(Node);// FTopVisibleNode := Node;
  if FocusedNode = nil then FFocused := TopVisibleNode;
  if (FLockUpdate = 0) then {**}
  begin
    RedrawNode := Node.GetPriorParentNode{GetPriorNode};
    if RedrawNode = nil then RedrawNode := Node;
    {**}
    if not (csLoading in ComponentState) and
       not (csDestroying in ComponentState) then //MakeListNodes;
      MakeListNode(Node, False);
    {**}
    UpdateNode(RedrawNode, True {Below});
  end;  
end;

procedure TCustomdxTreeList.BeforeDestroy;
begin
  Destroying;
  if HandleAllocated then DestroyHandle;
  Parent := nil;
  CancelEditor;
end;

procedure TCustomdxTreeList.BeginCustomLayout;
begin
end;

function TCustomdxTreeList.CanDblClick: Boolean;
begin
  Result := True;
end;

function TCustomdxTreeList.CheckHasChildren(Node : TdxTreeListNode) : Boolean;
begin
  if Node.Count = 0 then Result := False
  else Result := True;
end;

procedure TCustomdxTreeList.ClearBoundsInfo;
begin
end;

procedure TCustomdxTreeList.ClearListNodes;
begin
  if FClearListNodesFlag then Exit;
  FMakeListNodesFlag := False;
  if FListNodes <> nil then FListNodes.Clear;
  if FListIndexes <> nil then FListIndexes.Clear;
  if FListRealNodes <> nil then FListRealNodes.Clear;
  FFocusedAbsoluteIndex := -1;
  ClearNodeRowHeight;
end;

procedure TCustomdxTreeList.ClearNodeRowHeight;

  procedure ClearRowHeightInfo(Node: TdxTreeListNode);
  var
    I: Integer;
  begin
    Node.FRowHeight := 0;
    for I := 0 to Node.Count - 1 do
      ClearRowHeightInfo(TdxTreeListNode(Node.FList.List^[I]));
  end;
var
  I: Integer;
begin
  if FClearNodes or (csDestroying in ComponentState) then Exit;
  for I := 0 to FNodeList.Count - 1 do
    ClearRowHeightInfo(TdxTreeListNode(FNodeList.List^[I]));
end;

procedure TCustomdxTreeList.DoAfterCollapse(Node : TdxTreeListNode);
begin
  if Assigned(FOnCollapsed) then FOnCollapsed(Self, Node);
end;

procedure TCustomdxTreeList.DoAfterEditing(Node : TdxTreeListNode);
begin
  if Assigned(FOnEdited) then FOnEdited(Self, Node);
end;

procedure TCustomdxTreeList.DoAfterExpand(Node : TdxTreeListNode);
begin
  if Assigned(FOnExpanded) then FOnExpanded(Self, Node);
end;

procedure TCustomdxTreeList.DoBeforeCollapse(Node : TdxTreeListNode; var AllowCollapse: Boolean);
begin
  if Assigned(FOnCollapsing) then FOnCollapsing(Self, Node, AllowCollapse);
end;

procedure TCustomdxTreeList.DoBeforeEditing(Node : TdxTreeListNode; var AllowEditing: Boolean);
begin
  if Assigned(FOnEditing) then FOnEditing(Self, Node, AllowEditing);
end;

procedure TCustomdxTreeList.DoBeforeExpand(Node : TdxTreeListNode; var AllowExpand: Boolean);
begin
  if Assigned(FOnExpanding) then FOnExpanding(Self, Node, AllowExpand);
end;

procedure TCustomdxTreeList.DoBestFitBand(BandIndex: Integer);
begin
end;

procedure TCustomdxTreeList.DoBestFitColumn(AbsoluteIndex: Integer);
begin
end;

procedure TCustomdxTreeList.DoChangeColumn(Node : TdxTreeListNode; Column : Integer);
begin
  if Assigned(FOnChangeColumn) then FOnChangeColumn(Self, Node, Column);
end;

procedure TCustomdxTreeList.DoChangeLeftCoord;
begin
  if Assigned(FOnChangeLeftCoord) then FOnChangeLeftCoord(Self);
end;

procedure TCustomdxTreeList.DoChangeNode(OldNode, Node : TdxTreeListNode);
begin
  if Assigned(FOnChangeNode) then FOnChangeNode(Self, OldNode, Node);
end;

procedure TCustomdxTreeList.DoEditChange(Sender: TObject);
begin
  if Assigned(FOnEditChange) then FOnEditChange(Sender{Column});
end;

procedure TCustomdxTreeList.DoEditValidate(Sender: TObject; var ErrorText: string; var Accept: Boolean);
begin
  if Assigned(FOnEditValidate) then FOnEditValidate(Sender{Column}, ErrorText, Accept);
end;

procedure TCustomdxTreeList.DoRestoreLayout;
begin
end;

procedure TCustomdxTreeList.DoSaveLayout;
begin
end;

procedure TCustomdxTreeList.SetEmptyNodes;
begin
  SetTopVisibleNode(nil); // FTopVisibleNode := Nil;
  FFocused := nil;
  FInplaceColumn := -1;
  FInplaceNode := nil;
  FSelectionAnchor := nil;
  FSelecting := False;
  OldFocusedNode := nil;
  FDragNode := nil;
  FHotTrackInfo.Node := nil;
end;

procedure TCustomdxTreeList.DeleteNode(Node, Prior, Next: TdxTreeListNode; IsLast, Redraw: Boolean);
var
  RedrawNode: TdxTreeListNode;
begin
  if Assigned(FOnDeletion) then FOnDeletion(Self, Node);

  if FClearNodes then Exit;
  if IsNodeSelected(Node) then Node.Selected := False;
  if not (csDestroying in ComponentState) and not FClearListNodesFlag and (Count = 0) then
    ClearListNodes;
  if Count = 0 then
  begin
    SetEmptyNodes;
    if (FLockUpdate = 0) and not (csDestroying in ComponentState) then
    begin
      UpdateScrollBars;
      Invalidate;
    end;
    Exit;
  end;
  RedrawNode := nil;
  if TopVisibleNode = Node then
  begin
    SetTopVisibleNode(Prior);
    if FTopVisibleNode = nil then SetTopVisibleNode(Next);
    RedrawNode := FTopVisibleNode;
  end;
  if FocusedNode = Node then
  begin
    FFocused := Prior;
    if FocusedNode = nil then FFocused := Next;
    if RedrawNode = nil then RedrawNode := FocusedNode;
  end;
  if OldFocusedNode = Node then OldFocusedNode := nil;
  if FSelectionAnchor = Node then
  begin
    FSelectionAnchor := Prior;
    if FSelectionAnchor = nil then FSelectionAnchor := Next;
  end;
  if FDragNode = Node then FDragNode := nil;
  if FHotTrackInfo.Node = Node then FHotTrackInfo.Node := nil;
  CancelEditor;
  if FMakeListNodeVisible and (FLockUpdate = 0) and not (csDestroying in ComponentState) then
    MakeListNode(Node, True);
  if Redraw then
  begin
    if RedrawNode = nil then RedrawNode := Prior;
    if RedrawNode = nil then RedrawNode := Next;
    if RedrawNode <> nil then UpdateNode(RedrawNode, True{Below});
  end;
end;

procedure TCustomdxTreeList.DeleteStrings(Node: TdxTreeListNode; Index: Integer);
var
  I: Integer;
begin
  if Index < TdxTreeListTextNode(Node).FStrings.Count then
    TdxTreeListTextNode(Node).FStrings.Delete(Index);
  for I := 0 to Node.Count - 1 do
    DeleteStrings(Node[I], Index);
end;

function TCustomdxTreeList.DoMoveFocusedColumn(FlagUp, IsTest: Boolean): Boolean;
var
  AIndex, BIndex, RIndex, CIndex, RCount, CCount: Integer;
  FlagCol, FlagRow: Boolean;
begin
  Result := False;
  if IsRowSelect then Exit;
  if (FocusedNode <> nil) and IsRowGroup(FocusedNode) then Exit;
  FlagCol := False;
  FlagRow := False;
  CIndex := -1;
  RIndex := -1;
  AIndex := GetFocusedAbsoluteIndex(FocusedColumn);
  if AIndex = -1 then Exit;
  BIndex := GetVisibleBandIndex(GetHeaderBandIndex(AIndex));
  RCount := GetHeaderRowCount(BIndex);
  if RCount > 1 then
  begin
    RIndex := GetHeaderRowIndex(AIndex);
    CIndex := GetHeaderColIndex(AIndex);
    if FlagUp then
    begin
      if (RIndex = 0) and IsTopNode(FocusedNode) then Exit;
      if RIndex > 0 then
      begin
        Dec(RIndex);
        FlagCol := True;
      end
      else
      begin
        RIndex := GetHeaderRowCount(BIndex) - 1;
        FlagCol := True;
        FlagRow := True;
      end;
    end
    else
    begin
      if (RIndex = (RCount - 1)) and IsLastNode(FocusedNode) then Exit;

      if RIndex < (RCount - 1) then
      begin
        Inc(RIndex);
        FlagCol := True;
      end
      else
//        if FocusedNumber < (GetAbsoluteCount - 1) then
      begin
        RIndex := 0;
        FlagCol := True;
        FlagRow := True;
      end;
    end;
  end;
  if FlagCol then
  begin
    CCount := GetHeaderColCount(BIndex, RIndex);
    if CIndex >= CCount then CIndex := CCount - 1;
    if CIndex >= 0 then
    begin
      AIndex := GetHeaderAbsoluteIndex(BIndex, RIndex, CIndex);
      if AIndex <> -1 then
      begin
        CIndex := GetFocusedVisibleIndex(AIndex);
        if CIndex <> -1 then
        begin
          if not IsTest then
            FocusedColumn := CIndex;
          if not FlagRow then
            Result := True;
        end;
      end;
    end;
  end;
end;

procedure TCustomdxTreeList.EndCustomLayout;
begin
end;

function TCustomdxTreeList.GetAbsoluteCount: Integer;

  function GetExpandedCount(Node:TdxTreeListNode):Integer;
  var
    i: Integer;
  begin
    Result := Node.Count;
    for I := 0 to Result - 1 do
      if TdxTreeListNode(Node.FList.List^[I]).Expanded then
        Inc(Result, GetExpandedCount(TdxTreeListNode(Node.FList.List^[I])));
  end;

var
  i: Integer;
begin
{**}
  if IsSmartNavigation then
  begin
    Result := FListNodes.Count;
    Exit;
  end;
{**}

  Result := FNodeList.Count;
  for i := 0 to FNodeList.Count - 1 do
    if TdxTreeListNode(FNodeList.List^[I]).Expanded then
      Inc(Result, GetExpandedCount(TdxTreeListNode(FNodeList.List^[I])));
end;

function TCustomdxTreeList.GetAbsoluteIndex(Node: TdxTreeListNode): Integer;
var
  Ret, i: Integer;
  CurNode: TdxTreeListNode;

  function FoundNode(ParentNode, FindNode : TdxTreeListNode) : Boolean;
  var i : Integer;
      CurNode : TdxTreeListNode;
  begin
    Result := False;
    for i := 0 to ParentNode.Count - 1 do
    begin
      CurNode := ParentNode [i];
      Inc(Ret);
      if CurNode = FindNode then
      begin
        Result := True;
        Exit;
      end
      else
        if CurNode.Expanded then
          if FoundNode (CurNode, FindNode) then
          begin
            Result := True;
            Exit;
          end;
    end;
  end;

begin
  Ret := -1;
  Result := Ret;
  if (Node = Nil) or (Count = 0) then Exit;
{**}
  if IsSmartNavigation then
  begin
    Result := Integer(FListIndexes[FindListNode(Node)]);
    Exit;
  end;
{**}
  for i :=0 to Count - 1 do
  begin
    CurNode := Items[i];
    Inc(Ret);
    if CurNode = Node then
    begin
      Result := Ret;
      Exit;
    end
    else
      if CurNode.Expanded then
        if FoundNode (CurNode, Node) then
        begin
          Result := Ret;
          Exit;
        end
  end;
end;

function TCustomdxTreeList.GetAbsoluteNode(AIndex : Integer) : TdxTreeListNode;
var i : Integer;
    k : Integer;
    CurNode : TdxTreeListNode;
    function GetNextNodes (Node:TdxTreeListNode) : TdxTreeListNode;
    var k : Integer;
    begin
      Result := Nil;
      for k := 0 to Node.Count - 1 do
      begin
        Inc(i);
        if i = AIndex then
        begin
          Result := Node[k];
          Exit;
        end;
        if Node[k].Expanded then
           Result := GetNextNodes(Node[k]);
        if Result <> Nil then Exit;
      end;
    end;
begin
  Result := Nil;
{**}
  if IsSmartNavigation then
  begin
    if (0 <= AIndex) and (AIndex < FListRealNodes.Count) then
      Result := TdxTreeListNode(FListRealNodes[AIndex])
    else Result := nil;
    Exit;
  end;
{**}
  i := -1;
  for k:= 0 to Count - 1 do
  begin
    Inc(i);
    CurNode := Items[k];
    if i = AIndex then
    begin
      Result := CurNode;
      Exit;
    end;
    if CurNode.Expanded then
       Result := GetNextNodes(CurNode);
    if Result <> Nil then Exit;
  end;
end;

function TCustomdxTreeList.GetRectNode(Node:TdxTreeListNode): TRect;
var
  DrawInfo: TdxGridDrawInfo;
  CurNode: TdxTreeListNode;
  Y, H: Integer;
begin
  Result := Rect(-1, -1, -1, -1);
  CalcRectInfo(DrawInfo);
  with DrawInfo do
  begin
    CurNode := TopVisibleNode;
    Y := CellsRect.Top;
    while (CurNode <> nil) and (Y < CellsRect.Bottom) do
    begin
      H := GetRowHeight(CurNode, FRowHeight, False{ReCalc});
      if CurNode = Node then
      begin
        with CellsRect do
          Result := Rect(Left, Y, Right, Y + H);
        if not IsRectEmpty(IndicatorRect) then
          Result.Left := IndicatorRect.Left;
        Break;
      end;
      Inc(Y, H);
      CurNode := GetNextVisible(CurNode);
    end;
  end;
end;

function TCustomdxTreeList.GetRectNodeBelow(Node:TdxTreeListNode): TRect;
var
  DrawInfo: TdxGridDrawInfo;
begin
  CalcRectInfo(DrawInfo);
  Result := GetRectNode(Node);
  Result.Bottom := DrawInfo.CellsRect.Bottom;
end;

function TCustomdxTreeList.GetRowNode(Node:TdxTreeListNode) : Integer;
var CurRow : Integer;
    CurNode : TdxTreeListNode;
begin
  Result := -1;
  CurNode := TopVisibleNode;
  CurRow := 0;
  While (CurNode <> Nil) and (CurRow <= VisibleRowCount) Do
  begin
    if CurNode = Node then
    begin
      Result := CurRow;
      Exit;
    end;
    CurNode := GetNextVisible(CurNode);
    Inc(CurRow);
  end;
end;

function TCustomdxTreeList.GetScrollVertGridRect: TRect;
var
  DrawInfo: TdxGridDrawInfo;
begin
  CalcRectInfo(DrawInfo);
  Result := DrawInfo.CellsRect;
  if not IsRectEmpty(DrawInfo.IndicatorRect) then
    Result.Left := DrawInfo.IndicatorRect.Left;
end;

function TCustomdxTreeList.GetTopNode : TdxTreeListNode;
begin
  Result := GetNode(0);
end;

procedure TCustomdxTreeList.FreeClickTimer;
begin
  if ClickTimerID <> -1 then
  begin
    KillTimer(Handle, 2{ClickTimerID});
    ClickTimerID := -1;
  end;
end;

function TCustomdxTreeList.IsColumnHotTrack(X, Y: Integer; Node: TdxTreeListNode;
  ColumnAbsoluteIndex: Integer; var ActiveIndex: Integer): Boolean;
begin
  Result := aoHotTrack in OptionsEx;
end;

function TCustomdxTreeList.IsHeaderHotTrack(X, Y: Integer; ColumnAbsoluteIndex: Integer;
  var HeaderHotTrack: TdxTreeListHeaderHotTrack): Boolean;
var
  DrawInfo: TdxGridDrawInfo;
  I: Integer;
  R: TRect;
begin
//  Result := aoHotTrack in OptionsEx; // TODO Option + Filter
  Result := True;
  HeaderHotTrack := hhtBody;
  CalcDrawInfo(DrawInfo);
  try
    with DrawInfo do
      for I := 0 to HeaderCount - 1 do
        if HeadersInfo^[I].AbsoluteIndex = ColumnAbsoluteIndex then
        begin
          if PtInRect(HeadersInfo^[I].HeaderClipRect, Point(X, Y)) then
          begin
            R := HeadersInfo^[I].HeaderRect;
            InflateRect(R, -2, -2);
            if (R.Right - R.Left) > dxGridHeaderFilterBoxWidth then
            begin
              R.Left := R.Right - dxGridHeaderFilterBoxWidth;
              if PtInRect(R, Point(X, Y)) then
                HeaderHotTrack := hhtDropDownButton;
            end;  
          end;
          Break;
        end;
  finally
    FreeDrawInfo(DrawInfo);
  end;
end;

procedure TCustomdxTreeList.LayoutChanged;
begin
  if FLockUpdate <> 0 then Exit;
  Inc(FLockUpdate);
  try
    InternalLayout;
  finally
    Dec(FLockUpdate);
  end;
end;

procedure TCustomdxTreeList.MakeBandHeaderList(CalcBounds: Boolean);
begin
end;

procedure TCustomdxTreeList.MakeBoundsInfo;
begin
end;

procedure TCustomdxTreeList.MakeListNode(Node: TdxTreeListNode; Deleteing: Boolean);
begin
  FMakeListNode := Node;
  FMakeListNodeVisible := FMakeListNodeVisible or Node.IsVisible;
  try
    FNodeDeleteing := Deleteing;
    MakeListNodes;
  finally
    FMakeListNode := nil;
    FMakeListNodeVisible := False;
  end;
end;

procedure TCustomdxTreeList.MakeListNodes;
var
  K: Integer;
  FList: TList;

  procedure LoadNode(ANode: TdxTreeListNode);
  var
    PValue: PdxNodeInfo;
  begin
    New(PValue);
    PValue^.Node := ANode;
    PValue^.Index := k;
    FList.Add(PValue);
    FListRealNodes.Add(ANode);
    Inc(k);
  end;

  procedure LoadExpanded(ANode: TdxTreeListNode);
  var
    i : Integer;
  begin
    LoadNode(ANode);
    for i := 0 to ANode.Count-1 do
      if ANode[i].Expanded then
        LoadExpanded(ANode[i])
      else LoadNode(ANode[i]);
  end;

  function CalcAbsoluteIndex(Node: TdxTreeListNode): Integer;

    function CalcNextNode(Node: TdxTreeListNode): TdxTreeListNode;
    var
      I: Integer;
    begin
      if Node.Parent = nil then
      begin
        if Node = Items[Count - 1] then
          Result := nil
        else
        begin
          I := Node.FOwner.IndexOf(Node);
          Result := Items[I + 1];
        end;
      end
      else
      begin
        I := Node.Parent.IndexOf(Node);
        if I < (Node.Parent.Count - 1) then
          Result := Node.Parent.Items[I + 1]
        else
          Result := CalcNextNode(Node.Parent);
      end;
    end;

  var
    N: TdxTreeListNode;
  begin
    N := CalcNextNode(Node);
    if N = nil then
      Result := FListRealNodes.Count
    else
      Result := Integer(FListIndexes[FindListNode(N)]);
  end;

  function FindNearestNode(Node: TdxTreeListNode): Integer;
  var
    L, H, I, C: Integer;
  begin
    L := 0;
    H := FListNodes.Count - 1;
    while L <= H do
    begin
      I := (L + H) shr 1;
      C := Integer(FListNodes[I]) - Integer(Node);
      if C < 0 then
        L := I + 1
      else
        begin
          H := I - 1;
          if C = 0 then L := I;
        end;
    end;
    Result := L;
  end;

var
  I, J: Integer;
  N: TdxTreeListNode;
begin
  if (FListIndexes = nil) or (FListNodes = nil) or (FListRealNodes = nil) then Exit;
  if FMakeListNode <> nil then
  begin
    if FMakeListNodeVisible then
    begin
      if IsSmartNavigation then // NEW 3.0
      begin
        if FNodeDeleteing then
        begin
          K := FindListNode(FMakeListNode);
          J := Integer(FListIndexes[K]);
          for I := 0 to FListIndexes.Count - 1 do
            if Integer(FListIndexes.List^[I]) >= J then
              FListIndexes.List^[I] := Pointer(Integer(FListIndexes.List^[I]) - 1);
          FListIndexes.Delete(K);
          FListNodes.Delete(K);
          FListRealNodes.Delete(J);
          // Check RowHeight
          with FMakeListNode do
            if (Parent <> nil) and IsLast and (Parent.Count > 1) then
              Parent.Items[Parent.Count - 1].FRowHeight := 0;
        end
        else
        begin
          J := CalcAbsoluteIndex(FMakeListNode);
          for I := 0 to FListIndexes.Count - 1 do
          begin
            if Integer(FListIndexes.List^[I]) >= J then
              FListIndexes.List^[I] := Pointer(Integer(FListIndexes.List^[I]) + 1);
          end;
          I := FindNearestNode(FMakeListNode);
          FListIndexes.Insert(I, Pointer(J));
          FListNodes.Insert(I, FMakeListNode);
          FListRealNodes.Insert(J, FMakeListNode);
          // Check RowHeight
          with FMakeListNode do
            if (Parent <> nil) and IsLast and (Parent.Count > 1) then
              Parent.Items[Parent.Count - 2].FRowHeight := 0;
        end;
      end;
    end;
  end
  else
  begin
    FList := TList.Create;
    try
      FList.Capacity := Count;
      FListRealNodes.Clear;
      FListRealNodes.Capacity := Count;
      k := 0;
      for I := 0 to FNodeList.Count{Count} - 1 do
      begin
        N := TdxTreeListNode(FNodeList.List^[I]);
        if N.Expanded then
          LoadExpanded(N)
        else LoadNode(N);
      end;
      // sort List
      FList.Sort(CompareItems);
      // load list's
      FListIndexes.Clear;
      FListIndexes.Capacity := FList.Count;
      FListNodes.Clear;
      FListNodes.Capacity := FList.Count;
      for i := 0 to FList.Count - 1 do
      begin
        FListIndexes.Add(Pointer(PdxNodeInfo(FList[i])^.Index));
        FListNodes.Add(Pointer(PdxNodeInfo(FList[i])^.Node));
        Dispose(PdxNodeInfo(FList[i]));
      end;
    finally
      FList.Free;
    end;
  end;
  if not FClearListNodesFlag and IsRowAutoHeight then
    ClearNodeRowHeight;
  FMakeListNodesFlag := True;
end;

function TCustomdxTreeList.NeedShowButtonEdit(X, Y: Integer;
  IsCurrentNode: Boolean; ColumnAbsoluteIndex: Integer): Boolean;
begin
  Result := IsShowButtonAlways;
end;

procedure TCustomdxTreeList.SetState(Value : TdxTreeListState);
var
  PrevState: TdxTreeListState;
begin
  PrevState := FState;
  FState := Value;
  if (FState = tsEditing) and
     (FInplaceEdit <> nil) then FInplaceEdit.Deselect;
  if (State = tsNormal) and (PrevState in [tsColumnDown, tsColumnSizing, tsBandSizing, tsBandPanelSizing,
    tsHeaderPanelSizing, tsRowSizing, tsColumnDragging, tsBandDragging]) then UpdateDesigner;
  if (FState = tsEditing) and FSearching then EndSearch;
end;

procedure TCustomdxTreeList.UpdateNode(Node : TdxTreeListNode; Below : Boolean);
begin
  if Node.Deleting then Exit;
  if (FLockUpdate = 0) and
   (not (csDestroying in ComponentState))
    and (Node.IsVisible) then
  begin
    if Below then
    begin
      UpdateScrollBars;
      UpdateTopLeftCoord;
      InvalidateRect(GetRectNodeBelow(Node))
    end
    else
      InvalidateRect(GetRectNode(Node));
  end;
end;

// based virtual & abstract
function TCustomdxTreeList.CanSetData : Boolean;
begin
  Result := True;
end;

function TCustomdxTreeList.GetNodeVariant(Node: TdxTreeListNode; Column: Integer) : Variant;
begin
  Result := '';
end;

procedure TCustomdxTreeList.SetFocusedNode(Node:TdxTreeListNode; Column:Integer; MakeVisibleFlag : Boolean);
var
  NewRect, OldRect: TRect;
  OldNode: TdxTreeListNode;
  OldColumn: Integer;
begin
  if Node = nil then Exit;
  HideEditor;
  FFocusedAbsoluteIndex := -1;
  OldNode := FocusedNode;
  OldColumn := FocusedColumn;
  try
    if FLockUpdate <> 0 then
    begin
      FFocused := Node;
      FFocusedColumn := Column;
      Exit;
    end;
//    if (Node <> nil) and MakeVisibleFlag then // ppp
//      Node.MakeVisible;
    if (FocusedNode = Node) then
    begin
       if IsRowSelect then Exit
       else
         if (FocusedColumn = Column) then Exit;
    end;
    if (FocusedNode = Node) and (not IsRowSelect) then
    begin
      MakeColumnVisible(GetFocusedAbsoluteIndex(Column));
      OldRect := CellRect(FocusedNode, FocusedColumn);
      FFocusedColumn := Column;
      NewRect := CellRect(FocusedNode, FocusedColumn);
      InvalidateRect(OldRect);
      InvalidateRect(NewRect);
      InvalidateNewItemRow;
      Exit;
    end
    else
    if not IsRowSelect then
    begin
      FFocusedColumn := Column;
      MakeColumnVisible(GetFocusedAbsoluteIndex(Column));
    end;
    OldRect := GetRectNode(FocusedNode);
    FFocused := Node;
    NewRect := GetRectNode(FocusedNode);
    InvalidateRect(OldRect);
    InvalidateRect(NewRect);
    NewItemRowActive := False;
  finally
    if (FocusedNode <> nil) and MakeVisibleFlag then FocusedNode.MakeVisible; // ppp
    if ((OldNode <> FocusedNode) and (FLockSearching = 0)) or (OldColumn <> FocusedColumn) then
      EndSearch;
    if OldNode <> FocusedNode then DoChangeNode(OldNode, FocusedNode);
    if OldColumn <> FocusedColumn then DoChangeColumn(FocusedNode, FocusedColumn);
  end;
end;

procedure TCustomdxTreeList.SetFocusedNumber(AIndex: Integer);
var FSelIndex, FCount : Integer;
begin
  if Count = 0 then Exit;
  FSelIndex := FocusedNumber;
  if FSelIndex <> AIndex then
  begin
    if (AIndex < 0) then AIndex := 0;
    FCount := GetAbsoluteCount;
    if AIndex > (FCount-1) then AIndex := FCount-1;
    if (AIndex <> FSelIndex) then
    begin
      SetFocusedNode(GetAbsoluteNode(AIndex), FocusedColumn, True);
    end;
  end;
end;

procedure TCustomdxTreeList.SetTopVisibleNode(Node: TdxTreeListNode);
begin
  FTopVisibleNode := Node;
  if Assigned(FOnChangeTopVisibleNode) then FOnChangeTopVisibleNode(Self);
end;

// DESIGN
// GroupPanel
function TCustomdxTreeList.GetGroupPanelHeight: Integer;
begin
  Result := 0;
end;

// Bands

function TCustomdxTreeList.GetAbsoluteBandAlignment(AbsoluteIndex: Integer): TAlignment;
begin
  Result := taLeftJustify;
end;

function TCustomdxTreeList.GetAbsoluteBandCount: Integer;
begin
  Result := 0;
end;

function TCustomdxTreeList.GetAbsoluteBandIndex(VisibleIndex: Integer): Integer;
begin
  Result := VisibleIndex;
end;

function TCustomdxTreeList.GetAbsoluteBandText(AbsoluteIndex: Integer): string;
begin
  Result := '';
end;

function TCustomdxTreeList.GetAbsoluteBandWidth(AbsoluteIndex: Integer): Integer;
begin
  Result := 0;
end;

function TCustomdxTreeList.GetBandAlignment(VisibleIndex: Integer): TAlignment;
begin
  Result := taLeftJustify;
end;

function TCustomdxTreeList.GetBandCount: Integer;
begin
  Result := 0;
end;

function TCustomdxTreeList.GetBandFixedLeft: Integer;
begin
  Result := -1;
end;

function TCustomdxTreeList.GetBandFixedRight: Integer;
begin
  Result := -1;
end;

function TCustomdxTreeList.GetBandMinWidthSize(VisibleIndex: Integer): Integer;
begin
  Result := 0;
end;

function TCustomdxTreeList.GetBandSizeWidth(VisibleIndex: Integer): Integer;
begin
  Result := 0;
end;

function TCustomdxTreeList.GetBandText(VisibleIndex: Integer): string;
begin
  Result := '';
end;

function TCustomdxTreeList.GetIndentWidth: Integer;
begin
  Result := 0;
end;

function TCustomdxTreeList.GetVisibleBandIndex(AbsoluteIndex: Integer): Integer;
begin
  Result := AbsoluteIndex;
end;

// Headers
function TCustomdxTreeList.GetHeaderAbsoluteCount: Integer;
begin
  Result := 0;
end;

function TCustomdxTreeList.GetHeaderAbsoluteIndex(BandIndex, RowIndex, ColIndex: Integer): Integer;
begin
  Result := -1;
end;

function TCustomdxTreeList.GetHeaderAlignment(AbsoluteIndex: Integer): TAlignment;
begin
  Result := taLeftJustify;
end;

function TCustomdxTreeList.GetHeaderBandIndex(AbsoluteIndex: Integer): Integer;
begin
  Result := 0;
end;

function TCustomdxTreeList.GetHeaderColCount(BandIndex, RowIndex: Integer): Integer;
begin
  Result := 0;
end;

function TCustomdxTreeList.GetHeaderColIndex(AbsoluteIndex: Integer): Integer;
begin
  Result := 0;
end;

function TCustomdxTreeList.GetHeaderDropDownButtonState(AbsoluteIndex: Integer): TdxHeaderDropDownButtonState;
begin
  if IsAutoFilter then
  begin
    Result := [hdbNormal];
    if (FHotTrackInfo.Column = AbsoluteIndex) and (FHotTrackInfo.HeaderHotTrack = hhtDropDownButton) then
    begin
      Result := Result + [hdbSelected];
      if (FDropDownButtonColumnIndex = AbsoluteIndex) and FDropDownButtonColumnPushed then
        Result := Result + [hdbPushed];
    end;
  end
  else
    Result := [];
end;

function TCustomdxTreeList.GetHeaderGlyph(AbsoluteIndex: Integer): TBitmap;
begin
  Result := nil;
end;

function TCustomdxTreeList.GetHeaderMaxLineCount(AbsoluteIndex: Integer): Integer;
begin
  Result := 1;
end;

function TCustomdxTreeList.GetHeaderMinWidth(AbsoluteIndex: Integer): Integer;
begin
  Result := 0;
end;

function TCustomdxTreeList.GetHeaderRowCount(BandIndex: Integer): Integer;
begin
  Result := 0;
end;

function TCustomdxTreeList.GetHeaderRowIndex(AbsoluteIndex: Integer): Integer;
begin
  Result := 0;
end;

function TCustomdxTreeList.GetHeaderSorted(AbsoluteIndex: Integer): TdxTreeListColumnSort;
begin
  Result := csNone;
end;

function TCustomdxTreeList.GetHeaderTabStop(AbsoluteIndex: Integer): Boolean;
begin
  Result := True;
end;

function TCustomdxTreeList.GetHeaderText(AbsoluteIndex: Integer): string;
begin
  Result := '';
end;

function TCustomdxTreeList.GetHeaderTextListBox(AbsoluteIndex: Integer): string;
begin
  Result := GetHeaderText(AbsoluteIndex);
end;

function TCustomdxTreeList.GetHeaderWidth(AbsoluteIndex: Integer): Integer;
begin
  Result := 0;
end;

function TCustomdxTreeList.GetColumnColor(AbsoluteIndex: Integer): TColor;
begin
  Result := Self.Color;
end;


function TCustomdxTreeList.GetColumnFont(AbsoluteIndex: Integer): TFont;
begin
  Result := Self.Font;
end;

function TCustomdxTreeList.IsExistColumnFont(AbsoluteIndex: Integer): Boolean;
begin
  Result := False;
end;

function TCustomdxTreeList.IsExistHeaderGlyph(AbsoluteIndex: Integer): Boolean;
begin
  Result := False;
end;

// Cells
function TCustomdxTreeList.GetCellAlignment(Node: TdxTreeListNode; AbsoluteIndex: Integer): TAlignment;
begin
  Result := taLeftJustify;
end;

function TCustomdxTreeList.GetCellText(Node: TdxTreeListNode; AbsoluteIndex: Integer): string;
begin
  Result := '';
end;

function TCustomdxTreeList.GetNewItemCellText(AbsoluteIndex: Integer): string;
begin
  Result := '';
end;

function TCustomdxTreeList.IsCellMultiLine(AbsoluteIndex: Integer): Boolean;
begin
  Result := False;
end;

function TCustomdxTreeList.IsNewItemRowEditing: Boolean;
begin
  Result := True;
end;

// Indicator
function TCustomdxTreeList.GetIndicatorWidth: Integer;
begin
  Result := 12;
end;

// Rows
function TCustomdxTreeList.GetHeaderMaxRowHeight(ACanvas: TCanvas; AbsoluteIndex: Integer): Integer;
begin
  Result := 0;
  if IsExistColumnFont(AbsoluteIndex) then
  begin
    ACanvas.Font.Assign(GetColumnFont(AbsoluteIndex));
    Result := CalcTextRowHeight(ACanvas.TextHeight('Wg'));
  end;
end;

function TCustomdxTreeList.GetPreviewText(Node: TdxTreeListNode): string;
begin
  Result := '';
end;

function TCustomdxTreeList.GetRowIndicatorKind(Node: TdxTreeListNode; ASelected: Boolean): TdxGridIndicatorKind;
begin
  Result := ikNone;
end;

function TCustomdxTreeList.GetRowLineCount(Node: TdxTreeListNode; var LineHeight: Integer): Integer;
var
  I, J, AIndex, W, H, MaxLineHeight: Integer;
  Text: string;
  Ind, Indent: Integer;
begin
  Result := -1;
  if (Node.FRowHeight <> 0) and (Node.FRowLineCount <> 0) then
    Result := Node.FRowLineCount // TODO NEW
  else
  if IsRowGroup(Node) then
    Result := 1
  else
  begin
    J := GetVisibleHeaderCount - 1;
    for I := 0 to J do
    begin
      AIndex := GetFocusedAbsoluteIndex(I);
      Text := GetCellText(Node, AIndex);
      W := GetHeaderBoundsWidth(AIndex);
      if I = 0 then
      begin
        GetNodeIndent(Node, Ind, Indent);
        Dec(W, Indent);
        if IsInvertSelect then Dec(W);
      end;
      if I = J then
        if IsInvertSelect then Dec(W);
      MaxLineHeight := LineHeight;
      H := -1;
      // TODO PAINT2
      if ShowGrid and ShowPreviewGrid then Dec(W);
      if ColumnCalcLineCount(Node, AIndex, Text, W, FTextHeight, MaxRowLineCount,
        IsInvertSelect, ShowGrid and ShowPreviewGrid{obsolete}, H, LineHeight) then
      begin
        if ShowGrid and ShowPreviewGrid then Inc(LineHeight);
        if IsInvertSelect then Inc(LineHeight, 2);
      end;
      if LineHeight > MaxLineHeight then
        MaxLineHeight := LineHeight;
      LineHeight := MaxLineHeight;
      if H > Result then Result := H;
    end;
  end;
end;

function TCustomdxTreeList.GetStatusButtonVisible: Boolean;
begin
  Result := False;
end;

function TCustomdxTreeList.GetStatusText: string;
begin
  Result := '';
end;

function TCustomdxTreeList.GetStatusCloseButtonHint: string;
begin
  Result := '';
end;

function TCustomdxTreeList.GetStatusCloseButtonRect: TRect;
var
  DI: TdxGridDrawInfo;
begin
  CalcRectInfo(DI);
  if not IsRectEmpty(DI.StatusRect) then
    with DI.StatusRect do
    begin
      Result := Rect(Left, Top, Left + dxGridStatusCloseButtonSizeX, Top + dxGridStatusCloseButtonSizeY);
      OffsetRect(Result, 3, (Bottom - Top - dxGridStatusCloseButtonSizeY) div 2);
    end;
end;

function TCustomdxTreeList.ColumnCalcLineCount(ANode: TdxTreeListNode; AbsoluteIndex: Integer; const Text: string;
  BoundsWidth, TextHeight, MaxLineCount: Integer; InflateFlag, GridFlag: Boolean;
  var LineCount, LineHeight: Integer): Boolean;
begin
  Result := False;
end;

procedure TCustomdxTreeListControl.LoadFromIniFile(const AFileName: string);
var
  Ini: {$IFDEF DELPHI4}TMemIniFile{$ELSE}TIniFile{$ENDIF};
  APath: string;
begin
  {$IFDEF DELPHI4}
  Ini := TMemIniFile.Create(AFileName);
  {$ELSE}
  Ini := TIniFile.Create(AFileName);
  {$ENDIF}
  try
    if IniSectionName = '' then
    begin
      if GetParentForm(Self) <> nil then
        APath := GetParentForm(Self).Name;
      APath := APath + '_' + Self.Name;
    end
    else
      APath := IniSectionName;
    LoadFromRegIni(Ini, APath);
  finally
    Ini.Free;
  end;
end;

procedure TCustomdxTreeListControl.LoadFromRegistry(const ARegPath: string);
var
  Reg: TRegIniFile;
begin
  Reg := TRegIniFile.Create('');
  try
    if Reg.OpenKey(ARegPath, False) then
    begin
      Reg.CloseKey;
      LoadFromRegIni(Reg, ARegPath);
    end;
  finally
    Reg.Free;
  end;
end;

procedure TCustomdxTreeListControl.SaveToIniFile(const AFileName: string);
var
  Ini: {$IFDEF DELPHI4}TMemIniFile{$ELSE}TIniFile{$ENDIF};
  APath: string;
begin
  {$IFDEF DELPHI4}
  Ini := TMemIniFile.Create(AFileName);
  {$ELSE}
  Ini := TIniFile.Create(AFileName);
  {$ENDIF}
  try
    if IniSectionName <> '' then
      APath := IniSectionName
    else
      APath := FParentFormName + '_' + Self.Name;
    SaveToRegIni(Ini, APath);
    {$IFDEF DELPHI4}
    Ini.UpdateFile;
    {$ENDIF}
  finally
    Ini.Free;
  end;
end;

procedure TCustomdxTreeListControl.SaveToRegistry(const ARegPath: string);
var
  Reg: TRegIniFile;
begin
  Reg := TRegIniFile.Create('');
  try
    SaveToRegIni(Reg, ARegPath);
  finally
    Reg.Free;
  end;
end;

function TCustomdxTreeList.GetRowMaxColumnHeight(ACanvas: TCanvas): Integer;
var
  I, H: Integer;
begin
  Result := 0;
  for I := 0 to GetHeaderAbsoluteCount - 1 do
    if IsHeaderVisible(I) then
    begin
      H := GetHeaderMaxRowHeight(ACanvas, I);
      if H > Result then Result := H;
    end;
end;

function TCustomdxTreeList.GetRowPreviewLineCount(Node: TdxTreeListNode): Integer;
var
  Text: string;
  W, H: Integer;
begin
  if (Node <> nil) and IsAutoCalcPreviewLines then
  begin
    Text := GetPreviewText(Node);
    if Text <> '' then
    begin
      W := GetPreviewBoundsWidth(Node) - IndentDesc;
      Result := GetTextLineCount(Text, W, FDescTextHeight, PreviewLines,
        FPreviewFont.Handle, False, False, H);
    end
    else Result := 0;
  end
  else
    Result := PreviewLines;
  if Result < 0 then Result := 0;    
end;

function TCustomdxTreeList.GetRowSeparatorLineWidth: Integer;
begin
  Result := FRowSeparatorLineWidth;
  if Result < 1 then Result := 1;
end;

procedure TCustomdxTreeList.HeaderPanelBestFit;
begin
end; 

function TCustomdxTreeList.IsRowGroup(Node: TdxTreeListNode): Boolean;
begin
  Result := False;
end;

// Footer
function TCustomdxTreeList.GetFooterCellAlignment(Node: TdxTreeListNode; AbsoluteIndex, FooterIndex: Integer): TAlignment;
begin
  Result := GetCellAlignment(Node, AbsoluteIndex);
end;

function TCustomdxTreeList.GetFooterCellText(Node: TdxTreeListNode; AbsoluteIndex, FooterIndex: Integer): string;
begin
  Result := '';
end;

function TCustomdxTreeList.IsExistFooterCell(AbsoluteIndex: Integer): Boolean;
begin
  Result := False;
end;

function TCustomdxTreeList.IsExistRowFooterCell(Node: TdxTreeListNode; AbsoluteIndex, FooterIndex: Integer): Boolean;
begin
  Result := False;
end;

function TCustomdxTreeList.IsLevelFooter(Level: Integer): Boolean;
begin
  Result := False;
end;

// Style
function TCustomdxTreeList.IsAnsiSort: Boolean;
begin
  Result := aoAnsiSort in OptionsEx;
end;

function TCustomdxTreeList.IsAutoCalcPreviewLines: Boolean;
begin
  Result := aoAutoCalcPreviewLines in OptionsEx;
end;

function TCustomdxTreeList.IsAutoDragCopy: Boolean;
begin
  Result := False;
end;

function TCustomdxTreeList.IsAutoSearch: Boolean;
begin
  Result := aoAutoSearch in OptionsEx;
end;

function TCustomdxTreeList.IsAutoSort: Boolean;
begin
  Result := aoAutoSort in Options;
end;

function TCustomdxTreeList.IsAutoHeaderPanelRowCount: Boolean;
begin
  Result := aoAutoHeaderPanelHeight in OptionsEx;
end;

function TCustomdxTreeList.IsAutoSortRefresh: Boolean;
begin
  Result := aoAutoSortRefresh in OptionsEx;
end;

function TCustomdxTreeList.IsAutoWidth: Boolean;
begin
  Result := aoAutoWidth in Options;
end;

function TCustomdxTreeList.IsBandHeaderWidth: Boolean;
begin
  Result := aoBandHeaderWidth in OptionsEx;
end;

function TCustomdxTreeList.IsCaseInsensitive: Boolean;
begin
  Result := aoCaseInsensitive in Options;
end;

function TCustomdxTreeList.IsCellMultiSelect: Boolean;
begin
  Result := aoCellMultiSelect in OptionsEx;
end;

function TCustomdxTreeList.IsDragCollapse: Boolean;
begin
  Result := aoDragCollapse in OptionsEx;
end;

function TCustomdxTreeList.IsDrawEndEllipsis: Boolean;
begin
  Result := aoDrawEndEllipsis in Options;
end;

function TCustomdxTreeList.IsDragExpand: Boolean;
begin
  Result := aoDragExpand in OptionsEx;
end;

function TCustomdxTreeList.IsDragScroll: Boolean;
begin
  Result := aoDragScroll in OptionsEx;
end;

function TCustomdxTreeList.IsEditing: Boolean;
begin
  Result := aoEditing in Options;
end;

function TCustomdxTreeList.IsEnterShowEditor: Boolean;
begin
  Result := aoEnterShowEditor in OptionsEx;
end;

function TCustomdxTreeList.IsEnterThrough: Boolean;
begin
  Result := (aoEnterThrough in OptionsEx) and IsEnterShowEditor;
end;

function TCustomdxTreeList.IsExtCustomizing: Boolean;
begin
  Result := aoExtCustomizing in Options;
end;

function TCustomdxTreeList.IsExtMultiSelect: Boolean;
begin
  Result := aoExtMultiSelect in Options;
end;

function TCustomdxTreeList.IsFilterStatusVisible: Boolean;
begin
  Result := False;
end;

function TCustomdxTreeList.IsHorzThrough: Boolean;
begin
  Result := aoHorzThrough in OptionsEx;
end;

function TCustomdxTreeList.IsHScrollBarVisible: Boolean;
begin
  Result := (FScrollBars = ssBoth) or (FScrollBars = ssHorizontal);
end;

function TCustomdxTreeList.IsImmediateEditor: Boolean;
begin
  Result := aoImmediateEditor in Options;
end;

function TCustomdxTreeList.IsMouseScroll: Boolean;
begin
  Result := (IsRowSelect or not IsEditing) and (aoMouseScroll in OptionsEx);
end;

function TCustomdxTreeList.IsMultiSelect: Boolean;
begin
  Result := aoMultiSelect in Options;
end;

function TCustomdxTreeList.IsMultiSort: Boolean;
begin
  Result := aoMultiSort in OptionsEx;
end;

function TCustomdxTreeList.IsNewItemRowActive: Boolean;
begin
  Result := FNewItemRowActive;
end;

function TCustomdxTreeList.IsNewItemRowVisible: Boolean;
begin
  Result := ShowNewItemRow and (NewItemRowHeight > 0);
end;

function TCustomdxTreeList.IsRowAutoHeight: Boolean;
begin
  Result := (aoRowAutoHeight in OptionsEx) and (MaxRowLineCount <> 0);
end;

function TCustomdxTreeList.IsRowSelect: Boolean;
begin
  Result := aoRowSelect in Options;
end;

function TCustomdxTreeList.IsShowHourGlass: Boolean;
begin
  Result := aoShowHourGlass in OptionsEx;
end;

function TCustomdxTreeList.IsShowPreview: Boolean;
begin
  Result := (aoPreview in Options) and (PreviewLines <> 0);
end;

function TCustomdxTreeList.IsShowRowFooter: Boolean;
begin
  Result := FShowRowFooter;
end;

function TCustomdxTreeList.IsSmartRecalcRowHeight: Boolean;
begin
  Result := True;
end;

function TCustomdxTreeList.IsTabs: Boolean;
begin
  Result := (aoTabs in Options) and (GetAsyncKeyState(VK_CONTROL) >= 0);
end;

function TCustomdxTreeList.IsTabThrough: Boolean;
begin
  Result := aoTabThrough in Options;
end;

function TCustomdxTreeList.IsVertThrough: Boolean;
begin
  Result := aoVertThrough in OptionsEx;
end;

function TCustomdxTreeList.IsVScrollBarDisableHide: Boolean;
begin
  Result := False;
end;

function TCustomdxTreeList.IsVScrollBarVisible: Boolean;
begin
  Result := (FScrollBars = ssBoth) or (FScrollBars = ssVertical);
end;

function TCustomdxTreeList.IsUseBitmap: Boolean;
begin
  Result := aoUseBitmap in OptionsEx;
end;

// Sizing, Clicking
function TCustomdxTreeList.CanBandButtonClicking: Boolean;
begin
  Result := aoBandButtonClicking in OptionsEx;
end;

function TCustomdxTreeList.CanBandFullSizing(VisibleIndex: Integer): Boolean;
begin
  Result := aoFullSizing in OptionsEx;
end;

function TCustomdxTreeList.CanBandPanelSizing: Boolean;
begin
  Result := aoBandPanelSizing in OptionsEx;
end;

function TCustomdxTreeList.CanBandSizing(VisibleIndex: Integer): Boolean;
begin
  Result := True; //aoBandSizing in OptionsEx;
end;

function TCustomdxTreeList.CanHeaderBandSizing: Boolean;
begin
  Result := IsBandHeaderWidth and not ShowBands {and not IsAutoWidth};
end;

function TCustomdxTreeList.CanHeaderButtonClicking: Boolean;
begin
  Result := aoHeaderButtonClicking in OptionsEx;
end;

function TCustomdxTreeList.CanHeaderFullSizing(AbsoluteIndex: Integer): Boolean;
begin
  Result := aoFullSizing in OptionsEx;
end;

function TCustomdxTreeList.CanHeaderPanelSizing: Boolean;
begin
  Result := aoHeaderPanelSizing in OptionsEx;
end;

function TCustomdxTreeList.CanHeaderSizing(AbsoluteIndex: Integer): Boolean;
begin
  Result := True;
end;

function TCustomdxTreeList.CanHeaderReSizing(AbsoluteIndex: Integer): Boolean;
begin
  Result := (aoColumnSizing in Options) and CanHeaderSizing(AbsoluteIndex);
end;

function TCustomdxTreeList.CanRowSizing: Boolean;
begin
  Result := aoRowSizing in OptionsEx;
end;

procedure TCustomdxTreeList.ChangedBandRowCount(BandRowCount: Integer);
begin
end;

procedure TCustomdxTreeList.ChangedBandWidth(VisibleIndex, Width: Integer);
begin
end;

procedure TCustomdxTreeList.ChangedHeaderMaxRowCount(RowCount: Integer);
begin
end;

procedure TCustomdxTreeList.ChangedHeaderWidth(AbsoluteIndex, Width: Integer);
begin
end;

procedure TCustomdxTreeList.ChangeHiddenBandWidth(ScaleNum, ScaleDenom: Integer);
begin
end;

procedure TCustomdxTreeList.ChangeHiddenHeaderWidth(BandIndex: Integer; ScaleNum, ScaleDenom: Integer);
begin
end;

procedure TCustomdxTreeList.ChangedRowHeight(NewRowHeight: Integer);
begin
  DefaultRowHeight := NewRowHeight; 
end;

procedure TCustomdxTreeList.DoBandButtonClick;
begin
end;

procedure TCustomdxTreeList.DoBandClick(VisibleIndex: Integer);
begin
end;

procedure TCustomdxTreeList.DoChangedColumnsWidth;
begin
end;

procedure TCustomdxTreeList.DoHeaderButtonClick;
begin
end;

procedure TCustomdxTreeList.DoHeaderClick(AbsoluteIndex: Integer);
begin
end;

procedure TCustomdxTreeList.DoHeaderDropDownButtonClick(AbsoluteIndex: Integer);
begin
end;

procedure TCustomdxTreeList.DoStatusCloseButtonClick;
begin
end;

function TCustomdxTreeList.GetBandMaxRowCount: Integer;
begin
  Result := 5;
end;

function TCustomdxTreeList.GetBandRowCount: Integer;
begin
  Result := 1;
end;

function TCustomdxTreeList.GetHeaderMaxLimitRowCount: Integer;
begin
  Result := 4;
end;

function TCustomdxTreeList.GetHeaderMaxRowCount: Integer;
begin
  Result := 1;
end;

function TCustomdxTreeList.GetHeaderLineRowCount: Integer;
begin
  Result := 1;
end;

// DragDrop
function TCustomdxTreeList.IsOwnBand(ABandIndex: Integer{VisibleIndex}): Boolean;
begin
  Result := False; 
end;

procedure TCustomdxTreeList.CalcArrowsPos(var P: TPoint; PPosInfo: Pointer;
  IsBand: Boolean; DownIndex, DragIndex: Integer);

  function IsOnlyOwnFlag(ADragIndex, AIndex, ABandIndex: Integer): Boolean;
  var
    ABandIndexDragColumn: Integer;
  begin
    ABandIndexDragColumn := GetHeaderBandIndex(ADragIndex);
    if AIndex <> -1 then ABandIndex := GetHeaderBandIndex(AIndex);
    Result := (IsOwnBand(ABandIndex) or IsOwnBand(ABandIndexDragColumn)) and
      (ABandIndexDragColumn <> ABandIndex);
  end;

var
  DrawInfo: TdxGridDrawInfo;
  TempIndex: Integer;
  FlagBefore: Boolean;
  ArrowDelta: Integer;
  Pos, TempPos: TPoint;
  i, Index1, Index2: Integer;
begin
   if IsBand then
     SetBandInfo(PPosInfo, -1)
   else SetInfo(PPosInfo, -1, -1, -1, -1);
   Pos := ScreenToClient(P);
   P := Point(-100, -100);
   TempIndex := -1;
   FlagBefore := False;
   ArrowDelta := arWidth div 2;
   if PointInCustomizingForm(ClientToScreen(Pos)) then Exit;
   CalcDrawInfo(DrawInfo);
   with DrawInfo do
   try
     if IsBand then
     begin
       if (BandRect.Top <= Pos.Y) and (Pos.Y < BandRect.Bottom) then
       begin
         SetBandInfo(PPosInfo, dxGridHeaderTempIndex);
         // calc band index and before-flag
         for i := 0 to BandCount - 1 do
         with BandsInfo^[i] do
         begin
           if PtInRect(BandClipRect, Pos) then
           begin
             if (Index = DownIndex{FDownBandIndex}) then Exit;
             FlagBefore := Pos.X <= (BandRect.Left + BandRect.Right) div 2;
             TempIndex := i;
             SetBandInfo(PPosInfo, Index);
             if (DownIndex <> -1) then
               if (FlagBefore and (Index = ({FDownBandIndex}DownIndex + 1))) or
                 (not FlagBefore and ((Index + 1) = DownIndex{FDownBandIndex})) then
               begin
                 SetBandInfo(PPosInfo, dxGridHeaderTempIndex);
                 Exit;
               end;
             if FlagBefore and (GetBandFixedLeft = BandsInfo^[TempIndex].Index) then
             begin
               SetBandInfo(PPosInfo, dxGridHeaderTempIndex);
               Exit;
             end;
             if not FlagBefore and (GetBandFixedRight = BandsInfo^[TempIndex].Index) then
             begin
               SetBandInfo(PPosInfo, dxGridHeaderTempIndex);
               Exit;
             end;
             Break;
           end;
         end;
         if BandCount = 0 then
         begin
           SetBandInfo(PPosInfo, 0);
           Pos.Y := BandRect.Top - arHeight;
           Pos.X := BandRect.Left - ArrowDelta;
           P := ClientToScreen(Pos);
           Exit;
         end
         else
         begin
           if (TempIndex = -1) and (Pos.X >= BandsInfo^[BandCount - 1].BandClipRect.Right) and
             (BandsInfo^[BandCount - 1].Index <> DownIndex{FDownBandIndex}) and
             (GetBandFixedRight <> BandsInfo^[BandCount - 1].Index) then
           begin
             TempIndex := BandCount - 1;
             FlagBefore := False;
           end;
         end;
         // calc coord
         if TempIndex <> -1 then
         begin
           if PPosInfo <> nil then
           begin
             SetBandInfo(PPosInfo, BandsInfo^[TempIndex].Index);
             if not FlagBefore then
             begin
               if ((DownIndex <> -1) and (DownIndex > Integer(PPosInfo^))) or
                 ((DownIndex = -1) and (DragIndex <> -1)) then
                 Inc(Integer(PPosInfo^));
             end
             else
             if (DownIndex <> -1) and (DownIndex < Integer(PPosInfo^)) then
               Dec(Integer(PPosInfo^));
           end;
           Pos.Y := BandsInfo^[TempIndex].BandRect.Top - arHeight;
           if FlagBefore then
             Pos.X := BandsInfo^[TempIndex].BandClipRect.Left - ArrowDelta
           else Pos.X := BandsInfo^[TempIndex].BandClipRect.Right - ArrowDelta;
           // check limits
           if Pos.X < BandRect.Left - ArrowDelta then
             Pos.X := BandRect.Left - ArrowDelta;
           if Pos.X > BandRect.Right then
             Pos.X := BandRect.Right;
         end;
       end;
     end
     else
     if (BandCount > 0) then 
     begin
       // calc header index and before-flag
       if (HeaderRect.Top <= Pos.Y) and (Pos.Y < HeaderRect.Bottom) then
       begin
         SetInfo(PPosInfo, -1, -1, -1, dxGridHeaderTempIndex);
         for i := 0 to HeaderCount - 1 do
         with HeadersInfo^[i] do
         begin
           if not IsFixedBandHeader(AbsoluteIndex) and PtInRect(HeaderClipRect, Pos) then
           begin
             if IsOnlyOwnFlag(DragIndex, AbsoluteIndex, -1) or
               (AbsoluteIndex = DownIndex{FDownColumnIndex}) then
             begin
               SetInfo(PPosInfo, BandIndex, RowIndex, ColIndex, dxGridHeaderTempIndex);
               Exit;
             end;
             FlagBefore := Pos.X <= (HeaderRect.Left + HeaderRect.Right) div 2;
             TempIndex := i;
             SetInfo(PPosInfo, BandIndex, RowIndex, ColIndex, AbsoluteIndex);
             // check nearest columns
             if (DownIndex <> -1) and (GetVisibleBandIndex(GetHeaderBandIndex(DownIndex)) = BandIndex) and
               (GetHeaderRowIndex(DownIndex) = RowIndex) then
             begin
               Index1 :=  GetFocusedVisibleIndex(AbsoluteIndex);
               Index2 := GetFocusedVisibleIndex(DownIndex);
               if (FlagBefore and (Index1 = (Index2 + 1))) or
                 (not FlagBefore and ((Index1 + 1) = Index2)) then
               begin
                 SetInfo(PPosInfo, BandIndex, RowIndex, ColIndex, dxGridHeaderTempIndex);
                 Exit;
               end;
             end;
             Break;
           end;
         end;
         if (TempIndex = -1) then
         begin
           if (Pos.X >= BandsInfo^[BandCount - 1].BandClipRect.Right) then // edge last band
           begin
             TempIndex := HeaderCount - 1;
             TempPos := Point(BandsInfo^[BandCount - 1].BandClipRect.Right - 1, Pos.Y);
             for i := HeaderCount - 1 downto 0 do
             with HeadersInfo^[i] do
             begin
               if not IsFixedBandHeader(AbsoluteIndex) and PtInRect(HeaderClipRect, TempPos) then
               begin
                 if IsOnlyOwnFlag(DragIndex, AbsoluteIndex, -1) then
                 begin
                   SetInfo(PPosInfo, BandIndex, RowIndex, ColIndex, dxGridHeaderTempIndex);
                   Exit;
                 end
                 else
                 begin
                   TempIndex := i;
                   Break;
                 end;
               end;
             end;
             FlagBefore := False;
           end
           else
           begin
             // under Header ?
             for i := HeaderCount - 1 downto 0 do
             with HeadersInfo^[i] do
             if not IsOnlyOwnFlag(DragIndex, AbsoluteIndex, -1) and
               not IsFixedBandHeader(AbsoluteIndex) then
             begin
               if (HeaderClipRect.Left <= Pos.X) and (Pos.X <{=} HeaderClipRect.Right) then
               begin
                 SetInfo(PPosInfo, BandIndex, RowIndex + 1, ColIndex, dxGridHeaderNewIndex);
                 Pos.X := HeaderClipRect.Left - ArrowDelta;
                 // check limits
                 if Pos.X < HeaderRect.Left - ArrowDelta then
                   Pos.X := HeaderRect.Left - ArrowDelta;
                 if Pos.X > HeaderRect.Right then
                   Pos.X := HeaderRect.Right;
                 Pos.Y := HeaderRect.Top + FHeaderRowHeight - arHeight;
                 P := ClientToScreen(Pos);
                 Exit;
               end;
             end;
             // under Band ?
             for i := 0 to BandCount - 1 do
             with BandsInfo^[i] do
             if not IsOnlyOwnFlag(DragIndex, -1, BandsInfo^[i].Index) and
               not IsFixedBand(BandsInfo^[i].Index) then
             begin
               if (BandClipRect.Left <= Pos.X) and (Pos.X <{=} BandClipRect.Right) then
               begin
                 SetInfo(PPosInfo, Index, 0, 0, dxGridHeaderNewIndex);
                 Pos.X := BandClipRect.Left - ArrowDelta;
                 // check limits
                 if Pos.X < HeaderRect.Left - ArrowDelta then
                   Pos.X := HeaderRect.Left - ArrowDelta;
                 if Pos.X > HeaderRect.Right then
                   Pos.X := HeaderRect.Right;
                 Pos.Y := BandRect.Bottom - arHeight;
                 P := ClientToScreen(Pos);
                 Exit;
               end;
             end;
           end;
         end;
         // calc coord
         if TempIndex <> -1 then
         begin
           if PPosInfo <> nil then
           begin
             I := HeadersInfo^[TempIndex].ColIndex;
             if not FlagBefore then
             begin
               if ((DownIndex <> -1) and (DownIndex > HeadersInfo^[TempIndex].AbsoluteIndex)) or
                 ((DragIndex <> -1) and (
                 (GetHeaderBandIndex(DragIndex) <> GetAbsoluteBandIndex(HeadersInfo^[TempIndex].BandIndex)) or
                 (GetHeaderRowIndex(DragIndex) <> HeadersInfo^[TempIndex].RowIndex) ) ) or
                 ((DragIndex <> -1) and (DownIndex = -1)) then
                 Inc(I);
             end
             else
             if (I > 0) and (DownIndex <> -1) and (DownIndex < HeadersInfo^[TempIndex].AbsoluteIndex) and
               (GetHeaderBandIndex(DownIndex) = GetAbsoluteBandIndex(HeadersInfo^[TempIndex].BandIndex)) then
               Dec(I);
             with HeadersInfo^[TempIndex] do
               SetInfo(PPosInfo, BandIndex, RowIndex, I, dxGridHeaderNewIndex {AbsoluteIndex});
           end;
           Pos.Y := HeadersInfo^[TempIndex].HeaderRect.Top - arHeight;
           if FlagBefore then
             Pos.X := HeadersInfo^[TempIndex].HeaderClipRect.Left - ArrowDelta
           else Pos.X := HeadersInfo^[TempIndex].HeaderClipRect.Right - ArrowDelta;
           // check limits
           if Pos.X < HeaderRect.Left - ArrowDelta then
             Pos.X := HeaderRect.Left - ArrowDelta;
           if Pos.X > HeaderRect.Right then
             Pos.X := HeaderRect.Right;
         end;
       end;
     end;
   finally
     FreeDrawInfo(DrawInfo);
   end;
   if TempIndex <> -1 then
     P := ClientToScreen(Pos);
end;

procedure TCustomdxTreeList.GetDragImageCursor(P:TPoint; var ADragCursor: TCursor);
begin
  P := ClientToScreen(P);
  if PointInCustomizingForm(P) then
  begin
    if not ((GetVisibleHeaderCount = 1) and (FDownColumnIndex <> -1)) then
      ADragCursor := crDrag;
    if (FDragAbsoluteHeaderIndex <> -1) and GetHeaderDisableCustomizing(FDragAbsoluteHeaderIndex) then
      ADragCursor := crdxTreeListDeleteCursor;
  end;
  if (State = tsColumnDragging) and (GetBandCount = 0) then
    ADragCursor := crdxTreeListDeleteCursor;
end;

function TCustomdxTreeList.GetIsCustomizing: Boolean;
begin
  Result := FCustomizingForm <> nil;
end;

function TCustomdxTreeList.GetNodeDragText(Node: TdxTreeListNode; AbsoluteIndex: Integer): string;
begin
  Result := GetCellText(Node, AbsoluteIndex);
end;

function TCustomdxTreeList.IsHeaderCustomizing: Boolean;
begin
  Result := FCustomizingForm <> nil;
end;

procedure TCustomdxTreeList.SetBandInfo(PPosInfo: Pointer; AIndex: Integer);
begin
  if PPosInfo <> nil then
    Integer(PPosInfo^) := AIndex;
end;

procedure TCustomdxTreeList.SetInfo(PPosInfo: Pointer; ABandIndex, ARowIndex, AColIndex, AAbsoluteIndex: Integer);
begin
  if PPosInfo <> nil then
    with PdxHeaderPosInfo(PPosInfo)^ do
    begin
      BandIndex := ABandIndex;
      RowIndex := ARowIndex;
      ColIndex := AColIndex;
      AbsoluteIndex := AAbsoluteIndex;
    end;
end;

// DragDrop Bands
procedure TCustomdxTreeList.BandMoved(FromIndex, ToIndex: Integer);
begin
end;

function TCustomdxTreeList.CanBandDragging(VisibleIndex: Integer): Boolean;
begin
  Result := aoBandMoving in OptionsEx;
end;

procedure TCustomdxTreeList.DoDragOverBand(P: TPoint{client}; AbsoluteIndex: Integer; var Accept: Boolean);
begin
end;

procedure TCustomdxTreeList.DoEndDragBand(P: TPoint; AbsoluteIndex, VisibleIndex: Integer;
  var NewIndex: Integer; var Accept: Boolean);
begin
end;

procedure TCustomdxTreeList.EndDragBand(Flag: Boolean);
var
  DragBandIndex: Integer;
  NewIndex: Integer;
  Accept: Boolean;
  P: TPoint;

  function GetDragBand(Pos: TPoint): Integer;
  begin
    Result := -1;
    Pos := ClientToScreen(Pos);
    CalcArrowsPos(Pos, @Result, True, DragBandIndex, FDragAbsoluteBandIndex);
  end;

begin
  SetState(tsNormal);
  FDragImageList.EndDrag;
  FreeImageList(FDragImageList);
  DrawArrows(False); // hide Arrows
  DragBandIndex := FDownBandIndex;
  FDownBandIndex := -1;
  InvalidateBand(-1);
  if Flag and (FDragAbsoluteBandIndex <> -1) then
  begin
    GetCursorPos(P);
    if not PointInCustomizingForm(P) then
      NewIndex := GetDragBand(ScreenToClient(P))
    else NewIndex := -1;
    Accept := True;
    DoEndDragBand(ScreenToClient(P), FDragAbsoluteBandIndex {absolute Index},
      DragBandIndex {prev visible index}, NewIndex {new visible index}, Accept);
    if Accept then
      if (DragBandIndex <> -1) then {is visible}
      begin
        if (NewIndex <> -1) and (NewIndex <> DragBandIndex) and (NewIndex <> dxGridHeaderTempIndex) then
        begin
          BandMoved(DragBandIndex,  NewIndex);
          MakeBandVisible(NewIndex);
        end
        else
        if (IsCustomizing or IsExtCustomizing) and (NewIndex = -1) and
          not GetBandDisableCustomizing(FDragAbsoluteBandIndex) {and (GetBandCount > 1)} then // TODO
            HideBand(FDragAbsoluteBandIndex);
      end
      else
      if IsCustomizing and (NewIndex <> -1) and (NewIndex <> dxGridHeaderTempIndex) then
      begin
        ShowBand(NewIndex, FDragAbsoluteBandIndex);
      end;
  end;
end;

function TCustomdxTreeList.GetBandDisableCustomizing(AbsoluteIndex: Integer): Boolean;
begin
  Result := False;
end;

procedure TCustomdxTreeList.HideBand(AbsoluteIndex: Integer);
begin
end;

function TCustomdxTreeList.IsBandInListBox(AbsoluteIndex: Integer): Boolean;
begin
  Result := False;
end;

procedure TCustomdxTreeList.StartDragBand(AbsoluteIndex: Integer);
var
  P: TPoint;
begin
  Application.CancelHint; 
  PrepareArrowsRect(True);
  PrepareDragBand(AbsoluteIndex);
  FDragImageList.SetDragImage(0, FDragImageList.Width div 2, FDragImageList.Height div 2);
  GetCursorPos(P);
  FArrowsPos := Point(-100, -100);
  FFlagSaveArrowsRect := False;
  DrawArrows(False); // start - save screen
  FDragImageList.BeginDrag(GetDeskTopWindow, P.X, P.Y);
  SetState(tsBandDragging);
  // active page in customizing box
  if IsCustomizing and (FCustomizingBandListBox <> nil) then
    with TPageControl(FCustomizingForm.FindComponent('PageControl')) do
      ActivePage := Pages[0];
end;

procedure TCustomdxTreeList.ShowBand(NewIndex, AbsoluteIndex: Integer);
begin
end;

// DragDrop Headers
function TCustomdxTreeList.CanHeaderDragging(AbsoluteIndex: Integer): Boolean;
begin
  Result := aoColumnMoving in Options;
end;

procedure TCustomdxTreeList.DoDragOverHeader(P: TPoint{client}; AbsoluteIndex: Integer; var Accept: Boolean);
begin
end;

procedure TCustomdxTreeList.DoEndDragHeader(P: TPoint; AbsoluteIndex: Integer;
  var NewPosInfo: TdxHeaderPosInfo; var Accept: Boolean);
begin
end;

procedure TCustomdxTreeList.EndDragHeader(Flag: Boolean);
var
  NewPosInfo: TdxHeaderPosInfo;
  DragColumnIndex: Integer;
  Accept: Boolean;
  P: TPoint;

  procedure ClearPosInfo(var PosInfo: TdxHeaderPosInfo);
  begin
    FillChar(PosInfo, SizeOf(PosInfo), 0);
    with PosInfo do
    begin
      BandIndex := -1;
      RowIndex := -1;
      ColIndex := -1;
      AbsoluteIndex := -1;
    end;
  end;

  function GetDragColumn(Pos: TPoint): TdxHeaderPosInfo;
  begin
    ClearPosInfo(Result);
    Pos := ClientToScreen(Pos);
    CalcArrowsPos(Pos, @Result, False, DragColumnIndex, FDragAbsoluteHeaderIndex);
  end;

begin
  SetState(tsNormal);
  FDragImageList.EndDrag;
  FreeImageList(FDragImageList);
  DrawArrows(False); // hide Arrows
  DragColumnIndex := FDownColumnIndex;
  FDownColumnIndex := -1;
  InvalidateColumn(-1);
  if Flag and (FDragAbsoluteHeaderIndex <> -1) then
  begin
    GetCursorPos(P);
    if not PointInCustomizingForm(P) then
      NewPosInfo := GetDragColumn(ScreenToClient(P))
    else ClearPosInfo(NewPosInfo);
    Accept := True;
    DoEndDragHeader(ScreenToClient(P), FDragAbsoluteHeaderIndex {absolute Index},
      NewPosInfo {new pos info}, Accept);
    if Accept then
      if IsHeaderVisible(FDragAbsoluteHeaderIndex) then // is Visible
      begin
        if (NewPosInfo.AbsoluteIndex <> -1) and (NewPosInfo.AbsoluteIndex <> FDragAbsoluteHeaderIndex) and
          (NewPosInfo.AbsoluteIndex <> dxGridHeaderTempIndex) then
        begin
          with NewPosInfo do
          begin
            HeaderMoved(FDragAbsoluteHeaderIndex, BandIndex, RowIndex, ColIndex);
            MakeColumnVisible(AbsoluteIndex);
          end;
        end
        else
        if (IsHeaderCustomizing or IsExtCustomizing) and (NewPosInfo.AbsoluteIndex = -1) and
          not GetHeaderDisableCustomizing(FDragAbsoluteHeaderIndex) and
          (GetVisibleHeaderCount > 1) then
            HideHeader(FDragAbsoluteHeaderIndex);
      end
      else
        if IsHeaderCustomizing and (NewPosInfo.AbsoluteIndex <> -1) and
          (NewPosInfo.AbsoluteIndex <> dxGridHeaderTempIndex) then
        begin
          with NewPosInfo do
            ShowColumnHeader(BandIndex, RowIndex, ColIndex, FDragAbsoluteHeaderIndex);
        end;
  end;
end;

function TCustomdxTreeList.GetDragHeaderWidth(AbsoluteIndex: Integer): Integer;
begin
  Result := 100;
end;

function TCustomdxTreeList.GetHeaderDisableCustomizing(AbsoluteIndex: Integer): Boolean;
begin
  Result := False;
end;

procedure TCustomdxTreeList.HeaderMoved(FromAbsoluteIndex, ToBandIndex, ToRowIndex, ToColIndex: Integer);
begin
end;

procedure TCustomdxTreeList.HideHeader(AbsoluteIndex: Integer);
begin
end;

function TCustomdxTreeList.IsHeaderInListBox(AbsoluteIndex: Integer): Boolean;
begin
  Result := False;
end;

function TCustomdxTreeList.IsHeaderVisible(AbsoluteIndex: Integer): Boolean;
begin
  Result := True;
end;

procedure TCustomdxTreeList.StartDragHeader(AbsoluteIndex: Integer);
var
  P: TPoint;
begin
  Application.CancelHint; 
  PrepareArrowsRect(False);
  PrepareDragHeader(AbsoluteIndex);
  FDragImageList.SetDragImage(0, FDragImageList.Width div 2, FDragImageList.Height div 2);
  GetCursorPos(P);
  FArrowsPos := Point(-100, -100);
  FFlagSaveArrowsRect := False;
  DrawArrows(False); // start - save screen
  FDragImageList.BeginDrag(GetDeskTopWindow, P.X, P.Y);
  SetState(tsColumnDragging);
  // active page in customizing box
  if IsCustomizing and (FCustomizingBandListBox <> nil) and
    (FCustomizingHeaderListBox <> nil) then
    with TPageControl(FCustomizingForm.FindComponent('PageControl')) do
      ActivePage := Pages[PageCount - 1];
end;

procedure TCustomdxTreeList.ShowColumnHeader(BandIndex, RowIndex, ColIndex, AbsoluteIndex: Integer);
begin
end;

// DragDrop Nodes
procedure TCustomdxTreeList.DoBeginDragNode(Node: TdxTreeListNode);
begin
  if Assigned(FOnBeginDragNode) then FOnBeginDragNode(Self, Node);
end;

procedure TCustomdxTreeList.DoEndDrag(Target: TObject; X, Y: Integer);
begin
  inherited DoEndDrag(Target, X, Y);
  FDragNode := nil;
  SetDragObject(nil); {+++}
  SetState(tsNormal);
  FreeImageList(FDragImageList);
end;

procedure TCustomdxTreeList.DoStartDrag(var DragObject: TDragObject);
var
  P: TPoint;
  Column: Integer;
begin
  if State = tsEditing then HideEditor;
  FreeClickTimer;
  inherited DoStartDrag(DragObject);
  if FDragNode = nil then
  begin
    GetCursorPos(P);
    with ScreenToClient(P) do FDragNode := GetNodeAt(X, Y);
  end;
  if (FDragNode <> nil) {and (GetVisibleHeaderCount > 0) }then
  begin
    Column := FocusedAbsoluteIndex {FocusedColumn};
    DoBeginDragNode(FDragNode);
    PrepareDragNode(FDragNode, Column);
    SetState(tsNodeDragging);
  end;
  SetDragObject(nil);{+++}
end;

procedure TCustomdxTreeList.DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  P: TPoint;
  DrawInfo: TdxGridDrawInfo;
  FHitTest: TdxTreeListHitInfo;
  LeftEdge, RightEdge: Integer;
begin
  inherited;
  if not (Dragging or (FDragObject <> nil)) then Exit;
  if (ScrollTimerID <> -1) then
  begin
    KillTimer(Handle, ScrollTimerID);
    ScrollTimerID := -1;
  end;
  if (ScrollNodeTimerID <> -1) then
  begin
    KillTimer(Handle, ScrollNodeTimerID);
    ScrollNodeTimerID := -1;
  end;
  P := Point(X, Y);
  FHitTest := GetHitInfo(P);
  if IsDragExpand then
  begin
    if (FHitTest.hitType in DragExpandHitTests) then
    begin
      FDragExpandNode := FHitTest.Node;
      if FDragExpandTimerId <> 0 then
        KillTimer(Handle, dxDragExapndTimerId);
      FDragExpandTimerId := SetTimer(Handle, dxDragExapndTimerId, WaitForExpandNodeTime, nil);
    end;
  end;
  if IsDragScroll then
  begin
    CalcDrawInfo(DrawInfo);
    try
      with DrawInfo do
      begin
        {Hor scroll}
        LeftEdge := CellsRect.Left;
        if not IsRectEmpty(FixedBandLeftRect) then
          LeftEdge := FixedBandLeftRect.Right;
        RightEdge := CellsRect.Right;
        if not IsRectEmpty(FixedBandRightRect) then
          RightEdge := FixedBandRightRect.Left;
        if (P.X > LeftEdge) and (P.X < LeftEdge + 3 * dxTreeListMaxResizeWidth) then
        begin
          ScrollTimerLeftFlag := True;
          ScrollTimerID := SetTimer(Handle, 1, tiHScroll, @ScrollTimerProc);
        end
        else
        if (P.X > RightEdge - 3 * dxTreeListMaxResizeWidth) and (P.X <= RightEdge) then
        begin
          ScrollTimerLeftFlag := False;
          ScrollTimerID := SetTimer(Handle, 1, tiHScroll, @ScrollTimerProc);
        end;

        if FHitTest.hitType in RowHitTests then
        begin
          if FHitTest.Column = -1 then FHitTest.Column := FocusedAbsoluteIndex;
          if ((FHitTest.Node <> FocusedNode) and
              (True {(GetAbsoluteIndex(TopVisibleNode) + VisibleRowCount - 1) <> GetAbsoluteIndex(FHitTest.Node)})) or
             ((not IsRowSelect) and IsDragScroll and (FHitTest.Column <> -1) and
              (FHitTest.Column <> FocusedAbsoluteIndex{FocusedColumn})) then
             SetFocusedNode(FHitTest.Node, GetFocusedVisibleIndex(FHitTest.Column), True);
          {new modification}
          UpdateDragging;
          {Vert scroll}
          if (FHitTest.Node = TopVisibleNode) and not IsTopNode(TopVisibleNode) then {Up}
          begin
            ScrollNodeTimerTopFlag := True;
            ScrollNodeTimerID := SetTimer(Handle, 1, tiVScroll, @ScrollNodeTimerProc);
          end;
          if (GetAbsoluteIndex(FHitTest.Node) >= (GetAbsoluteIndex(TopVisibleNode) + Self.RowCount - 1)) and
             not IsLastNode(FHitTest.Node) then {Down}
          begin
            ScrollNodeTimerTopFlag := False;
            ScrollNodeTimerID := SetTimer(Handle, 1, tiVScroll, @ScrollNodeTimerProc);
          end;
        end;
      end;
    finally
      FreeDrawInfo(DrawInfo);
    end;
  end;
end;

function TCustomdxTreeList.GetDragImages: {$IFDEF DELPHI4}TDragImageList{$else}TCustomImageList{$ENDIF};
begin
  if ShowDragImage then
    Result := FDragImageList
  else Result := nil;
end;

function TCustomdxTreeList.IsLastNode(ANode: TdxTreeListNode) : Boolean;
begin
 Result := ANode = GetAbsoluteNode(GetAbsoluteCount-1);
end;

function TCustomdxTreeList.IsTopNode(ANode: TdxTreeListNode) : Boolean;
begin
 Result := ANode = TopNode;
end;

// Size
function TCustomdxTreeList.CalcDistance(Distance: Integer) : Integer;
var
  i, TotalHeight : Integer;
  CurNode : TdxTreeListNode;
begin
  if Distance < 0 then
  begin
    TotalHeight := 0;
    CurNode := TopVisibleNode;
    i := 0;
    while (CurNode <> Nil) and (i < abs(Distance)) do
    begin
      Inc(TotalHeight, GetRowHeight(CurNode, FRowHeight, False{ReCalc}));
      CurNode := GetNextVisible(CurNode);
      Inc(i);
    end;
    Result := - TotalHeight;
  end
  else
  begin
    TotalHeight := 0;
    CurNode := TopVisibleNode;
    if CurNode <> nil then
       CurNode := CurNode.GetPriorNode;
    i := 0;
    while (CurNode <> Nil) and (i < abs(Distance)) do
    begin
      Inc(TotalHeight, GetRowHeight(CurNode, FRowHeight, False{ReCalc}));
      CurNode := CurNode.GetPriorNode;
      Inc(i);
    end;
    Result := TotalHeight;
  end;
end;

function TCustomdxTreeList.CalcNearTopIndex(AIndex: Integer): Integer;
var
  i, TotalHeight, H: Integer;
  CurNode: TdxTreeListNode;
  DrawInfo: TdxGridDrawInfo;
begin
  Result := AIndex - RowCount + 1;
  CurNode := GetAbsoluteNode(AIndex);
  CalcRectInfo(DrawInfo);
  TotalHeight := 0;
  H := DrawInfo.CellsRect.Bottom - DrawInfo.CellsRect.Top;
  i := AIndex;
  Inc(TotalHeight, GetRowHeight(CurNode, FRowHeight, False{ReCalc}));
  CurNode := CurNode.GetPriorNode;
  while (CurNode <> nil) do
  begin
    Inc(TotalHeight, GetRowHeight(CurNode, FRowHeight, False{ReCalc}));
    if TotalHeight > H then Break;
    Dec(i);
    CurNode := CurNode.GetPriorNode;
  end;
  if i >= 0 then Result := i;
end;

function TCustomdxTreeList.CalcRowCount(ATopVisibleNode: TdxTreeListNode; AHeight: Integer;
  var ARowCount, AVisibleRowCount: Integer): Integer;
var
  RowHeight{, TotalHeight}: Integer;
  CurNode: TdxTreeListNode;
begin
  CurNode := ATopVisibleNode;
  Result := 0;
  ARowCount := 0;
  AVisibleRowCount := 0;
  {go Down}
  while (CurNode <> nil) do
  begin
    RowHeight := GetRowHeight(CurNode, FRowHeight, False{ReCalc});
    if (Result + RowHeight) > AHeight then
    begin
      if Result <= AHeight then Inc(AVisibleRowCount);
      Inc(Result, RowHeight);
      Break;
    end;
    Inc(Result, RowHeight);
    Inc(ARowCount);
    Inc(AVisibleRowCount);
    CurNode := GetNextVisible(CurNode);
  end;
  {go Up}
  CurNode := ATopVisibleNode;
  if CurNode <> nil then CurNode := CurNode.GetPriorNode;
  while CurNode <> nil do
  begin
    RowHeight := GetRowHeight(CurNode, FRowHeight, False{ReCalc});
    if (Result + RowHeight) > AHeight then
    begin
      if Result <= AHeight then Inc(AVisibleRowCount);
      Break;
    end;
    Inc(Result, RowHeight);
    Inc(ARowCount);
    Inc(AVisibleRowCount);
    CurNode := CurNode.GetPriorNode;
  end;
  if AVisibleRowCount < 1 then AVisibleRowCount := 1;
  if ARowCount < 1 then ARowCount := 1;
end;

procedure TCustomdxTreeList.CheckSize;
var
  R: TRect;
  AStyle: LongInt;
  ARowCount, Dummy: Integer;
  DrawInfo: TdxGridDrawInfo;
begin
  if not HandleAllocated then Exit;
  AStyle := GetWindowLong(Handle, GWL_STYLE);
  if (AStyle and WS_HSCROLL = 0) or (AStyle  and WS_VSCROLL = 0) or
    IsVScrollBarDisableHide then Exit;
  // Calc Full rect
  CalcRectInfo(DrawInfo);
  R := DrawInfo.CellsRect;
  with R do
  begin
    Inc(Right, GetSystemMetrics(SM_CXVSCROLL));
    Inc(Bottom, GetSystemMetrics(SM_CYHSCROLL));
    // Calc RowCount
    CalcRowCount(TopVisibleNode, Bottom - Top, ARowCount, Dummy);
    // Check ClientHeight and ClientWidht
    if (GetAbsoluteCount <= ARowCount) and
      (GetScrollableBandWidth <= (Right - Left)) then // hide Scroll Bars
    begin
      AStyle := AStyle and not WS_HSCROLL and not WS_VSCROLL;
      SetWindowLong(Handle, GWL_STYLE, AStyle);
      SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
        SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_FRAMECHANGED);
    end;
  end;
end;

function TCustomdxTreeList.GetVisibleRowCount: Integer;
begin
  Result := FVisibleRowCount;
end;

procedure TCustomdxTreeList.GetVScrollInfo(var Min, Max, Pos : Integer; var Page, Mask : UINT);
var
  FCount : Integer;
begin
  Min := 0;
  Page := RowCount;
  FCount := GetAbsoluteCount;
  Max := FCount - 1;
  if FCount <= RowCount then Max := 0;
  Pos := TopIndex;
end;

procedure TCustomdxTreeList.UpdateRowCount;
var
  DrawInfo: TdxGridDrawInfo;
begin
  CalcRectInfo(DrawInfo);
  with DrawInfo.CellsRect do
    CalcRowCount(TopVisibleNode, Bottom - Top, FRowCount, FVisibleRowCount);
  if FVisibleRowCount < 1 then FVisibleRowCount := 1;
  if FRowCount < 1 then FRowCount := 1;
end;

procedure TCustomdxTreeList.UpdateScrollBars;
begin
   if not HandleAllocated then Exit;
   UpdateVScrollBar;
   UpdateHScrollBar;
   UpdateVScrollBar;
   UpdateHScrollBar;
end;

// Editor
function TCustomdxTreeList.AssignEditValue(ANode: TdxTreeListNode; AColumn: Integer; AInplaceEdit: TdxInplaceEdit): Variant;
begin
//  DoAfterEditing(ANode);
  Result := '';
end;

function TCustomdxTreeList.CanEditAcceptKey(Key: Char): Boolean;
begin
  Result := True;
end;

function TCustomdxTreeList.CanEditModify: Boolean;
begin
  Result := True;
end;

function TCustomdxTreeList.CanEditShow: Boolean;
begin
  Result := (FState = tsEditing)
    and not (csDesigning in ComponentState)
    and (FLockUpdate = 0)
    and HandleAllocated {and IsActiveControl};
end;

function TCustomdxTreeList.CanTreeListAcceptKey(Key: Word; Shift: TShiftState): Boolean;
begin
  Result := True;
end;

procedure TCustomdxTreeList.CheckHotTrackNode(AHitInfo: TdxTreeListHitInfo);
var
  PrevHotTrackInfo: TdxTreeListHotTrackInfo;
  ACursor: TCursor;
  AHeaderHotTrack: TdxTreeListHeaderHotTrack;
  // Hint
  PrevActive: Boolean;
  R: TRect;
begin
  if State in [tsNormal, tsStatusCloseButtonDown] then
  begin
    PrevActive := FStatusCloseButtonActive;
    R := GetStatusCloseButtonRect;
    FStatusCloseButtonActive := PtInRect(R, Point(AHitInfo.X, AHitInfo.Y));
    if PrevActive <> FStatusCloseButtonActive then
    begin
      InvalidateRect(R);
      if FStatusCloseButtonActive and (State in [tsNormal]) then
        ShowStatusCloseButtonHint(False)
      else
        HideStatusCloseButtonHint;
    end;
  end;
  if (aoHotTrack in OptionsEx) or IsAutoFilter then
  begin
    PrevHotTrackInfo := FHotTrackInfo;
    with AHitInfo do
    begin
      if (Node <> nil) and (Column <> -1) and
        IsColumnHotTrack(X, Y, Node, Column, FHotTrackInfo.ActiveIndex) then
      begin
        FHotTrackInfo.Node := Node;
        FHotTrackInfo.Column := Column;
        FHotTrackInfo.HeaderHotTrack := hhtNone;
      end
      else
        if (hitType in [htColumn]) and (Column <> -1) and
          IsHeaderHotTrack(X, Y, Column, AHeaderHotTrack) then
        begin
          FHotTrackInfo.Node := nil;
          FHotTrackInfo.Column := Column;
          FHotTrackInfo.HeaderHotTrack := AHeaderHotTrack;
          if FDropDownListVisible and (FDropDownButtonColumnIndex = Column) then
            FHotTrackInfo.HeaderHotTrack := hhtDropDownButtonDisabled;
        end
        else
        begin
          FHotTrackInfo.Node := nil;
          FHotTrackInfo.Column := -1;
          FHotTrackInfo.HeaderHotTrack := hhtNone;
        end;
    end;
    if (PrevHotTrackInfo.Node <> FHotTrackInfo.Node) or
      (PrevHotTrackInfo.Column <> FHotTrackInfo.Column) then
    begin
      ACursor := FDefaultCursor;
      DoHotTrackNode(FHotTrackInfo, ACursor);
      FCursorChange := True;
      try
        if Cursor <> ACursor then Cursor := ACursor;
      finally
        FCursorChange := False;
      end;
      InvalidateHotTrack(PrevHotTrackInfo);
      InvalidateHotTrack(FHotTrackInfo);
    end
    else
      if (PrevHotTrackInfo.Column <> FHotTrackInfo.Column) or
        (PrevHotTrackInfo.HeaderHotTrack <> FHotTrackInfo.HeaderHotTrack) then
      begin
        InvalidateHotTrack(PrevHotTrackInfo);
        InvalidateHotTrack(FHotTrackInfo);
      end;
  end;
end;

function TCustomdxTreeList.CreateEditor(AColumn: Integer): TdxInplaceEdit;
begin
  Result := TdxInplaceTreeListTextEdit.Create(Self);
end;

function TCustomdxTreeList.CreateEditStyle(AEdit: TdxInplaceEdit): TdxEditStyle;
begin
  Result := TdxTreeListEditStyle.Create(AEdit, Self);
end;

procedure TCustomdxTreeList.DoBeforeEditNewItemRow(var Allow: Boolean);
begin
end;

procedure TCustomdxTreeList.DoBeginNewItemActive;
begin
end;

procedure TCustomdxTreeList.DoHotTrackNode(AHotTrackInfo: TdxTreeListHotTrackInfo; var ACursor: TCursor);
begin
  if Assigned(FOnHotTrackNode) then FOnHotTrackNode(Self, AHotTrackInfo, ACursor);
end;

function TCustomdxTreeList.EditStyleBorderColor: TColor;
begin
  Result := clWindowFrame;
end;

function TCustomdxTreeList.EditStyleBorderStyle: TdxEditBorderStyle;
begin
  if ShowGrid then Result := xbsNone
  else Result := xbsSingle;
end;

function TCustomdxTreeList.EditStyleButtonStyle: TdxEditButtonViewStyle;
const
  AEditStyleButtonStyle: array [TdxLookAndFeel] of TdxEditButtonViewStyle = (
    bts3D, btsFlat, btsHotFlat);
begin
  Result := AEditStyleButtonStyle[LookAndFeel];
end;

function TCustomdxTreeList.EditStyleButtonTransparence: TdxEditButtonTransparence;
begin
  Result := ebtNone;
end;

function TCustomdxTreeList.EditStyleEdges: TdxEditEdges;
begin
  Result := [edgLeft, edgTop, edgRight, edgBottom];
end;

function TCustomdxTreeList.EditStyleHotTrack: Boolean;
begin
  Result := False;
end;

function TCustomdxTreeList.EditStyleShadow: Boolean;
begin
  Result := False;
end;

function TCustomdxTreeList.FindInplaceEdit(AColumn : Integer):TdxInplaceEdit;
begin
  if FInplaceEdit <> nil then
    Result := FInplaceEdit
  else Result := nil;
end;

function TCustomdxTreeList.GetEditColor: TColor;
var
  I: Integer;
begin
  Result := inherited GetEditColor;
  I := FocusedAbsoluteIndex;
  if I <> -1 then Result := GetColumnColor(I);
  if Assigned(FOnGetEditColor) then FOnGetEditColor(Self, Result);
end;

function TCustomdxTreeList.GetEditFont: TFont;
var
  I: Integer;
begin
  Result := inherited GetEditFont;
  I := FocusedAbsoluteIndex;
  if (I <> -1) and IsExistColumnFont(I) then Result := GetColumnFont(I);
end;

function TCustomdxTreeList.GetEditingText : String;
begin
  Result := '';
  if (FState = tsEditing) and (FInplaceEdit <> Nil) then
     Result := FInplaceEdit.GetEditingText;
end;

procedure TCustomdxTreeList.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
var
  DC: HDC;
begin
  with TdxInplaceTreeListEdit(AInplaceEdit) do // TODO
  begin
    CloseFlag := False; // for Mask Edit
    // Color
    Color := Self.GetEditColor;
    DC := GetDC(0);
    try
      Color := GetNearestColor(DC, ColorToRGB(Color));
    finally
      ReleaseDC(0, DC);
    end;
    // Font
    Font.Assign(Self.GetEditFont);
    // Offset
    OffsetSize := Rect(1, 0, 0, 0);
    // Activate TODO?
//    SetActive(True);
  end;
end;

function TCustomdxTreeList.InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant;
begin
  Result := '';
end;

procedure TCustomdxTreeList.InvalidateEditor;
begin
  if FCanceling then Exit;
  FInplaceColumn := -1;
  FInplaceNode := nil;
  UpdateEdit(False);
end;

function TCustomdxTreeList.IsEditorMoved: Boolean;
begin
  Result := (InplaceColumnIndex <> FocusedColumn);
end;

function TCustomdxTreeList.IsHotTrackNode(ANode: TdxTreeListNode; AIndex: Integer): Boolean;
begin
  Result := (FHotTrackInfo.Node = ANode) and (FHotTrackInfo.Column = AIndex);
end;

procedure TCustomdxTreeList.MoveCol(ALeft: Boolean);
begin
  CloseEditor;
  if ALeft then
    FocusedColumn := FocusedColumn - 1
  else FocusedColumn := FocusedColumn + 1;
end;

procedure TCustomdxTreeList.RedrawSelection;
begin
  InvalidateSelection;
end;

procedure TCustomdxTreeList.SetEditingText(Value : String);
begin
  if (FState = tsEditing) and (FInplaceEdit <> Nil) then
     FInplaceEdit.SetEditingText(Value);
end;

function TCustomdxTreeList.CanFullMultiSelect: Boolean;
begin
  Result := True;
end;

function TCustomdxTreeList.GetFirstSelectedNode: TdxTreeListNode;
begin
  if SelectedCount > 0 then
    Result := SelectedNodes[0]
  else
  if FFirstSelectedNode <> nil then
    Result := FFirstSelectedNode
  else Result := nil;
end;

function TCustomdxTreeList.CanNodeSelected(ANode: TdxTreeListNode): Boolean;
var
  Node: TdxTreeListNode;
begin
  Result := True;
  if Assigned(FOnCanNodeSelected) then FOnCanNodeSelected(Self, ANode, Result);
  if Result and not IsExtMultiSelect then
  begin
    Node := GetFirstSelectedNode;
    if Node <> nil then
      Result := Node.Parent = ANode.Parent;
  end;
end;

procedure TCustomdxTreeList.ClearSelection;
begin
  FSelecting := False;
  DoSelectedCountChange;
end;

function TCustomdxTreeList.CompareSelectionAnchor(ANode: TdxTreeListNode) : Integer;
var
  i1, i2: Integer;
begin
  i1 := GetAbsoluteIndex(ANode);
  i2 := GetAbsoluteIndex(SelectionAnchor);
  if i1 = i2 then Result := 0
  else
    if i1 < i2 then Result := -1
    else Result := 1;
end;

procedure TCustomdxTreeList.DeleteSelection;
begin
  FSelecting := False;
  if GetSelectedCount = 0 then Exit;
end;

procedure TCustomdxTreeList.DoSelectedCountChange;
begin
  if not (csDestroying in ComponentState) and (FLockSelection = 0) then
    if Assigned(FOnSelectedCountChange) then FOnSelectedCountChange(Self);
end;

function TCustomdxTreeList.GetSelectedCount : Integer;
begin
  Result := 0;
end;

function TCustomdxTreeList.GetSelectedItem(AIndex : Integer) : TdxTreeListNode;
begin
  Result := nil;
end;

procedure TCustomdxTreeList.InvalidateSelection;
var
  i: Integer;
begin
  if FocusedNode <> nil then
    InvalidateRect(GetRectNode(FocusedNode));
  if SelectedCount > 10 then
    Invalidate
  else
  for i := 0 to SelectedCount - 1 do
    InvalidateRect(GetRectNode(SelectedNodes[i]));
end;

function TCustomdxTreeList.IsNodeSelected(ANode:TdxTreeListNode):Boolean;
begin
  Result := False;
end;

procedure TCustomdxTreeList.NodeSelected(ANode: TdxTreeListNode; ASelected: Boolean);
begin
  DoSelectedCountChange;
end;

procedure TCustomdxTreeList.SelectNodes(N1, N2 : TdxTreeListNode);
var i1, i2, c : Integer;
    StartNode, EndNode : TdxTreeListNode;
begin
  BeginSelection;
  try
    try
      StartNode := N1;
      EndNode := N2;
      i1 := GetAbsoluteIndex(N1);
      i2 := GetAbsoluteIndex(N2);
      if i1 > i2 then
      begin
        StartNode := N2;
        EndNode := N1;
      end;
      c := 0;
      while (StartNode <> Nil) Do
      begin
        StartNode.Selected := True;
        Inc(c);
        if (StartNode = EndNode) or ((c-1) >= Abs(i1-i2)) then Break;
        StartNode := GetNextVisible(StartNode);
      end;
    except
    end;
  finally
    EndSelection;
  end;
end;

procedure TCustomdxTreeList.SetSelectionAnchor(ANode : TdxTreeListNode);
begin
  FSelectionAnchor := ANode;
end;

// Sorting
procedure TCustomdxTreeList.ClearColumnsSorted;
begin
end;

function TCustomdxTreeList.CompareEqual(Node1, Node2: TdxTreeListNode): Integer;
begin
  Result := Integer(Node1) - Integer(Node2);
end;

procedure TCustomdxTreeList.DoSortColumn(StartIndex, ColIndex: Integer; FlagDesc: Boolean);

 procedure SortLevel(L: TList; C: Integer);
 var
   i: Integer;
 begin
   if C = 0 then
     DoSortNodes(L, ColIndex, FlagDesc)
   else if L <> nil then
   begin
     Dec(C);
     for i := 0 to L.Count - 1 do
       SortLevel(TdxTreeListNode(L[i]).FList, C);
   end;
 end;

 procedure SortTree(L: TList);
 var
   i: Integer;
 begin
   DoSortNodes(L, ColIndex, FlagDesc);
   if L <> nil then
     for i := 0 to L.Count - 1 do
       SortTree(TdxTreeListNode(L[i]).FList);
 end;
 
var
  OldCursor : TCursor;
  {$IFDEF EGRID_DEBUG} t1, t2: LongInt; {$ENDIF}
begin
  OldCursor := Screen.Cursor;
  if IsShowHourGlass then
    Screen.Cursor := crHourglass;
  {$IFDEF EGRID_DEBUG} t1 := GetTickCount; {$ENDIF}
  try
    if StartIndex <> -1 then
      SortLevel(FNodeList, StartIndex)
    else SortTree(FNodeList);
  finally
    Screen.Cursor := OldCursor;
  end;
  {$IFDEF EGRID_DEBUG}
  t2 := GetTickCount;
  if Assigned(OnDebugEvent) then OnDebugEvent(Self, etSort, t2 - t1);
  {$ENDIF}
end;

procedure TCustomdxTreeList.DoSortNodes(List: TList; Col: Integer; FlagDesc: Boolean);
var
  PValue: PNodeVariant;
  PNext, PPrevNext: PNextVariant;
  PPNext: ^PNextVariant;
  FList: TList;
  I, J, C: Integer;
  FlagMulti: Boolean;
begin
  if (List = nil) or (List.Count <= 1) then Exit;
  FList := TList.Create;
  try
    C := GetSortedColumnCount;
//    FlagMulti := IsMultiSort and (C > 1);
    FlagMulti := IsMultiSortColumn(Col) and (C > 1);
    FList.Capacity := List.Count;
    if FlagMulti then
    begin
      Col := GetSortedColumnIndex(0);
      FlagDesc := GetSortedColumnDesc(0);
    end;
    // load values
    for I := 0 to List.Count - 1 do
    begin
      New(PValue);
      PValue^.Node := TdxTreeListNode(List[I]);
      PValue^.Value := GetNodeVariant(PValue^.Node, Col);
      PValue^.Desc := FlagDesc;
      PValue^.PNext := nil;
      if FlagMulti then
      begin
        PPNext := @PValue^.PNext;
        for J := 1 to C - 1 do
        begin
          New(PNext);
          PNext.Node := PValue^.Node;
          PNext.Value := GetNodeVariant(PValue^.Node, GetSortedColumnIndex(J));
          PNext.Desc := GetSortedColumnDesc(J);
          PNext.PNext := nil;
          PPNext^ := PNext;
          PPNext := @PNext^.PNext;
        end;
      end;
      FList.Add(PValue);
    end;
    // sort items
    if Assigned(FOnCompare) then
    begin
      FList.Sort(CustomCompareNodes);
      { MultiSort
      if not FlagDesc then
        FList.Sort(CustomCompareNodes)
      else FList.Sort(CustomCompareNodesDesc);
      }
    end
    else
    begin
      if not IsAnsiSort then
        FList.Sort(CompareVariantValues)
      else
        FList.Sort(CompareAnsiVariantValues);
    end;
    // assign order
    for I := 0 to List.Count - 1 do
    begin
      PValue := PNodeVariant(FList[I]);
      List[I] := PValue^.Node;
      if FlagMulti then
      begin
        PNext := PValue^.PNext;
        while PNext <> nil do
        begin
          PPrevNext := PNext;
          PNext := PNext^.PNext;
          Dispose(PPrevNext);
        end;
      end;
      Dispose(PValue);
    end;
  finally
    FList.Free;
  end;
end;

function TCustomdxTreeList.GetSortedColumnCount: Integer;
begin
  Result := 0;
end;

function TCustomdxTreeList.GetSortedColumnDesc(Index: Integer): Boolean;
begin
  Result := False;
end;

function TCustomdxTreeList.GetSortedColumnIndex(Index: Integer): Integer;
begin
  Result := Index;
end;

function TCustomdxTreeList.IsMultiSortColumn(AbsoluteIndex: Integer): Boolean;
begin
  Result := IsMultiSort;
end;

// Paint
function TCustomdxTreeList.AssignedDrawBandEvent(VisibleIndex: Integer): Boolean;
begin
  Result := False;
end;

function TCustomdxTreeList.AssignedDrawCellEvent(ANode: TdxTreeListNode; AbsoluteIndex: Integer): Boolean;
begin
  Result := False;
end;

function TCustomdxTreeList.AssignedDrawFooterCellEvent(ANode: TdxTreeListNode; AbsoluteIndex, FooterIndex: Integer): Boolean;
begin
  Result := False;
end;

function TCustomdxTreeList.AssignedDrawHeaderEvent(AbsoluteIndex: Integer): Boolean;
begin
  Result := False;
end;

function TCustomdxTreeList.AssignedDrawPreviewEvent: Boolean;
begin
  Result := False;
end;

function TCustomdxTreeList.AssignedLevelColorEvent: Boolean;
begin
  Result := False;
end;

procedure TCustomdxTreeList.DoDrawBand(VisibleIndex: Integer; ACanvas: TCanvas; ARect, AClipRect: TRect; var AText: string;
  var AColor: TColor; AFont: TFont; var AAlignment: TAlignment; var ADone: Boolean);
begin
end;

procedure TCustomdxTreeList.DoDrawCell(ACanvas: TCanvas; var ARect: TRect;
  ANode: TdxTreeListNode; AIndex: Integer; ASelected, AFocused: Boolean;
  ANewItemRow: Boolean; ALeftEdge, ARightEdge: Boolean; ABrush: HBRUSH;
  var AText: string; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ADone: Boolean);
begin
end;

procedure TCustomdxTreeList.DoDrawFooterCell(ACanvas: TCanvas; ARect: TRect;
  ANode: TdxTreeListNode; AIndex, AFooterIndex: Integer; var AText: string; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ADone: Boolean);
begin
end;

procedure TCustomdxTreeList.DoDrawHeader(AbsoluteIndex: Integer; ACanvas: TCanvas; ARect, AClipRect: TRect; var AText: string;
  var AColor: TColor; AFont: TFont; var AAlignment: TAlignment; var ASorted: TdxTreeListColumnSort; var ADone: Boolean);
begin
end;

procedure TCustomdxTreeList.DoDrawPreview(ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode; ASelected: Boolean;
  var AText: string; var AColor, ATextColor: TColor; AFont: TFont; var ADone: Boolean);
begin
end;

procedure TCustomdxTreeList.DoGetLevelColor(ALevel: Integer; var AColor: TColor);
begin
end;

procedure TCustomdxTreeList.DefaultDrawCell(ADC: HDC; ARect: TRect; AAbsoluteIndex: Integer;
  ACellViewData: TdxTreeListCellViewData);
begin
end;

procedure TCustomdxTreeListControl.CalcCellViewBoundsRect(const ACellRect: TRect; var AViewRect: TRect);
begin
  AViewRect := ACellRect;
  InflateRect(AViewRect, 2, 2);
end;

procedure TCustomdxTreeListControl.DefaultDrawCell(ADC: HDC; ARect: TRect; AAbsoluteIndex: Integer;
  ACellViewData: TdxTreeListCellViewData);
begin
  with Columns[AAbsoluteIndex] do
  begin
    FActualNode := ACellViewData.Cell_Node;
    try
      PrepareViewData(ViewData, ACellViewData);
      with ACellViewData do
        if Cell_InvertSelect then
          DrawColumnIndent(ADC, ARect, Cell_LeftEdge, Cell_RightEdge, Cell_Brush);
      CalcCellViewBoundsRect(ARect, ViewData.ViewBounds);
      GetdxInplaceEditClass.Draw(ADC, ARect, ViewData, 0);
    finally
      FActualNode := nil;
    end;
  end;
end;

procedure TCustomdxTreeList.DrawCellEx(ACanvas: TCanvas; ARect: TRect; ABitmap: TBitmap; {temp draw bitmap}
  ANode: TdxTreeListNode; AIndex: Integer; ASelected, AFocused: Boolean;
  ACellColor, ACellTextColor: TColor; ABrush: HBRUSH; AMultiLine: Boolean; ACellKind: TdxGridDrawCellKind;
  ALeftEdge, ARightEdge: Boolean; ACellBkColor: TColor; ACellBkBrush: HBRUSH);
var
  S: string;
  Done, ExistEvent, ExistFont: Boolean;
  AAlignment: TAlignment;
  AColor, AFontColor: TColor;
  AFont: TFont;
begin
  with ACanvas do
  begin
    if ANode <> nil then PrepareNode(ANode);
    try
      if ACellKind in [ckRow, ckGroup] then
        S := GetCellText(ANode, AIndex)
      else S := GetNewItemCellText(AIndex);
      AAlignment := GetCellAlignment(ANode, AIndex);
      // cell color
      if ACellKind in [ckRow, ckNewItemRow] then
        ExistFont := IsExistColumnFont(AIndex)
      else ExistFont := False;
      AColor := ACellColor;
      AFont := ACanvas.Font;
      AFontColor := AFont.Color;
      // begin custom draw
      ExistEvent := AssignedDrawCellEvent(ANode, AIndex);
      if ExistEvent or ExistFont then
      begin
        if not ExistFont then
          AFont.Color := ACellTextColor;
        FSaveFont.Assign(AFont);
        if ExistFont then
        begin
          AFont.Assign(GetColumnFont(AIndex));
          if ASelected then
            AFont.Color := ACellTextColor
          else ACellTextColor := AFont.Color;
        end;
        AFontColor := AFont.Color; // TODO: check it
      end;
      Done := False;
      DoDrawCell(ACanvas, ARect, ANode, AIndex, ASelected, AFocused,
        (ACellKind = ckNewItemRow), ALeftEdge, ARightEdge, ABrush, S, ACellColor, AFont, AAlignment, Done);
      if not Done then // Default Drawing
      begin
        if ExistEvent then
        begin
          if ColorToRGB(AColor) <> ColorToRGB(ACellColor) then
          begin
            Brush.Color := ACellColor;
            ABrush := Brush.Handle;
          end;
          if ColorToRGB(AFontColor) <> ColorToRGB(AFont.Color) then // TODO ?
            ACellTextColor := AFont.Color;
        end;
        // Default Draw
        with FCellViewData do
        begin
          Cell_Brush := ABrush;
          Cell_Font := AFont.Handle;
          Cell_BkColor := ACellColor;
          Cell_TextColor := ACellTextColor;
          Cell_Alignment := AAlignment;
          Cell_Text := S;
          Cell_TextLength := 0;
          Cell_Selected := ASelected;
          Cell_InvertSelect := IsInvertSelect;
          Cell_LeftEdge := ALeftEdge;
          Cell_RightEdge := ARightEdge;
          Cell_MultiLine := AMultiLine;
          Cell_InvertText := False;
          Cell_DrawEndEllipsis := IsDrawEndEllipsis;
          Cell_Node := ANode;
          Cell_IsNullNode := (ACellKind = ckNewItemRow) and not IsNewItemRowEditing;
          if AFocused then
            Cell_SelectionColor := HighlightColor
          else Cell_SelectionColor := HideSelectionColor;
          Cell_CellBrush := ACellBkBrush;
          Cell_CellColor := ACellBkColor;
          Cell_HotTrackNode := IsHotTrackNode(ANode, AIndex);
          with ARect do
            Cell_Rect := Rect(0, 0, Right - Left, Bottom - Top);
          InflateRect(Cell_Rect, 2, 2); // TODO PAINT2
        end;
        DefaultDrawCell(Handle, ARect, AIndex, FCellViewData);
        // Search Text Invert
        if FSearching and AFocused and (ACellKind = ckRow) and (FSearchColumnIndex = AIndex) then
        begin
          if FSearchText <> '' then
          begin
            if AutoSearchColor = clNone then
              ACellColor := ColorToRGB(ACellColor) xor $00FFFFFF
            else ACellColor := AutoSearchColor;
            Brush.Color := ACellColor;
            ABrush := Brush.Handle;
            if AutoSearchTextColor = clNone then
              ACellTextColor := ColorToRGB(ACellTextColor) xor $00FFFFFF
            else ACellTextColor := AutoSearchTextColor;
            // Default Draw
            with FCellViewData do
            begin
              Cell_Brush := ABrush;
              Cell_Font := AFont.Handle;
              Cell_BkColor := ACellColor;
              Cell_TextColor := ACellTextColor;
              Cell_Alignment := AAlignment;
              Cell_Text := S;
              Cell_TextLength := Length(FSearchText); // *
              Cell_Selected := ASelected;
              Cell_InvertSelect := IsInvertSelect;
              Cell_LeftEdge := ALeftEdge;
              Cell_RightEdge := ARightEdge;
              Cell_MultiLine := AMultiLine;
              Cell_InvertText := True; // *
              Cell_DrawEndEllipsis := IsDrawEndEllipsis;
              Cell_Node := ANode;
              if AFocused then
                Cell_SelectionColor := HighlightColor
              else Cell_SelectionColor := HideSelectionColor;
              Cell_CellBrush := ACellBkBrush;
              Cell_CellColor := ACellBkColor;
              Cell_HotTrackNode := IsHotTrackNode(ANode, AIndex);
              with ARect do
                Cell_Rect := Rect(0, 0, Right - Left, Bottom - Top);
              InflateRect(Cell_Rect, 2, 2); // TODO PAINT2
            end;
            DefaultDrawCell(Handle, ARect, AIndex, FCellViewData);
          end;
          // Draw Focus Rect
          InflateRect(ARect, -1, -1);
          if IsRowSelect or IsInvertSelect then
          begin
            if not ALeftEdge then Dec(ARect.Left);
            if not ARightEdge then Inc(ARect.Right);
          end;
          DrawFocused(Handle, ARect);
        end;
      end;
      // end custom draw
      if ExistEvent or ExistFont then
        Font.Assign(FSaveFont);
    finally
      if ANode <> nil then UnPrepareNode(ANode);
    end;
  end;
end;

procedure TCustomdxTreeList.DrawCell(ACanvas: TCanvas; ARect: TRect; ABitmap: TBitmap; ANode: TdxTreeListNode; AIndex, AFooterIndex: Integer;
  ASelected, AFocused: Boolean; ACellColor: TColor; ABrush: HBRUSH; AMultiLine: Boolean; ACellKind: TdxGridDrawCellKind;
  ALeftEdge, ARightEdge: Boolean);
var
  S: string;
  ExistEvent, Done, ExistFont: Boolean;
  AAlignment: TAlignment;
  AColor: TColor;
  AFont: TFont;
  PrevBkColor: TColorRef;
begin
  with ACanvas do
  begin
    if ANode <> nil then PrepareNode(ANode);
    try
      if (ACellKind <> ckFooter) then
      begin
        if ACellKind in [ckRow, ckGroup] then
          S := GetCellText(ANode, AIndex)
        else S := GetNewItemCellText(AIndex);
        AAlignment := GetCellAlignment(ANode, AIndex);
      end
      else
      begin
        S := GetFooterCellText(ANode, AIndex, AFooterIndex);
        AAlignment := GetFooterCellAlignment(ANode, AIndex, AFooterIndex);
      end;
      // cell color
      if ACellKind in [ckRow, ckNewItemRow] then
        ExistFont := IsExistColumnFont(AIndex)
      else ExistFont := False;
      AColor := ACellColor;
      AFont := ACanvas.Font;
      Done := False;
      // begin custom draw
      if (ACellKind <> ckFooter) then
        ExistEvent := AssignedDrawCellEvent(ANode, AIndex)
      else ExistEvent := AssignedDrawFooterCellEvent(ANode, AIndex, AFooterIndex);
      if ExistEvent or ExistFont then
      begin
        AFont.Color := GetTextColor(Handle);
        FSaveFont.Assign(AFont); // Canvas.Font <- Self.Font
        if ExistFont then
        begin
          AFont.Assign(GetColumnFont(AIndex));
          if ASelected then
            AFont.Color := FSaveFont.Color;
        end;
      end;
      PrevBkColor := GetBkColor(Handle);
      if (ACellKind <> ckFooter) then
        DoDrawCell(ACanvas, ARect, ANode, AIndex, ASelected, AFocused,
          (ACellKind = ckNewItemRow), ALeftEdge, ARightEdge, ABrush, S, AColor, AFont, AAlignment, Done)
      else DoDrawFooterCell(ACanvas, ARect, ANode, AIndex, AFooterIndex, S, AColor, AFont, AAlignment, Done);
      if not Done then
      begin
        if ColorToRGB(AColor) <> ColorToRGB(ACellColor) then
        begin
          Brush.Color := AColor;
          ABrush := Brush.Handle;
          SetBkColor(Handle, ColorToRGB(AColor));
        end;
        DrawCellText(Handle, ARect, ABrush, AColor, ABitmap, S, Length(S),
          AMultiLine, IsDrawEndEllipsis{AEndEllipsis}, AAlignment, IsUseBitmap,
          (ACellKind <> ckFooter) and IsInvertSelect, False);
        // Search Text Invert
        if FSearching and AFocused and (ACellKind = ckRow) and ({FocusedAbsoluteIndex}FSearchColumnIndex = AIndex) then
        begin
          if FSearchText <> '' then
          begin
            if AutoSearchColor = clNone then
              AColor := ColorToRGB(AColor) xor $00FFFFFF
            else AColor := AutoSearchColor;
            Brush.Color := AColor;
            ABrush := Brush.Handle;
            if not (ExistEvent or ExistFont) then
            begin
              AFont.Color := GetTextColor(Handle);
              FSaveFont.Assign(AFont); // Canvas.Font <- Self.Font
              ExistFont := True;
            end;
            if AutoSearchTextColor = clNone then
              AFont.Color := ColorToRGB(AFont.Color) xor $00FFFFFF
            else AFont.Color := AutoSearchTextColor;
            SetBkColor(Handle, ColorToRGB(AColor));
            SetTextColor(Handle, ColorToRGB(AFont.Color));
            DrawCellText(Handle, ARect, ABrush, AColor, ABitmap, S, Length(FSearchText),
              AMultiLine, IsDrawEndEllipsis{AEndEllipsis}, AAlignment, IsUseBitmap,
              (ACellKind <> ckFooter) and IsInvertSelect, True);
          end;
          // Draw Focus Rect
          InflateRect(ARect, -1, -1);
          if IsRowSelect or IsInvertSelect then
          begin
            if not ALeftEdge then Dec(ARect.Left);
            if not ARightEdge then Inc(ARect.Right);
          end;
          DrawFocused(Handle, ARect);
        end;
      end;
      // end custom draw
      if ExistEvent or ExistFont then
        Font.Assign(FSaveFont);
      if ColorToRGB(AColor) <> ColorToRGB(ACellColor) then
        SetBkColor(Handle, PrevBkColor);
    finally
      if ANode <> nil then UnPrepareNode(ANode);
    end;
  end;
end;

procedure TCustomdxTreeList.DrawGroupPanel(ACanvas: TCanvas; ARect: TRect; HeaderBrush, PanelBrush: HBRUSH);
begin
end;

procedure TCustomdxTreeList.DrawPreview(ACanvas: TCanvas; ARect: TRect; ABitmap: TBitmap;
  ANode: TdxTreeListNode; AColor, ATextColor: TColor; ABrush: HBRUSH; ASelected: Boolean);
var
  S: string;
  ANewColor: TColor;
  AFont: TFont;
  PrevBkColor: TColorRef;
  Done{, ExistEvent}: Boolean;
begin
  with ACanvas do
  begin
    S := GetPreviewText(ANode);
    if AColor <> FHighlightColor then
      ATextColor := FPreviewFont.Color;
    ANewColor := AColor;
    AFont := ACanvas.Font;
    FSaveFont.Assign(AFont); // Canvas.Font <- Self.Font
    AFont.Assign(FPreviewFont);
    Done := False;
{    ExistEvent := AssignedDrawPreviewEvent;
    if ExistEvent then
    begin
      AFont := FPreviewFont;
      AFont.Color := GetTextColor(Handle);
      FSaveFont.Assign(AFont); // Canvas.Font <- Self.Font
    end;}
    PrevBkColor := GetBkColor(Handle);
    DoDrawPreview(ACanvas, ARect, ANode, ASelected, S, ANewColor, ATextColor, AFont, Done);
    if not Done then
    begin
      if ColorToRGB(AColor) <> ColorToRGB(ANewColor) then
      begin
        Brush.Color := ANewColor;
        ABrush := Brush.Handle;
        SetBkColor(Handle, ColorToRGB(ANewColor));
      end;
      DrawPreviewText(Handle, ARect, ABrush, AFont.Handle, ABitmap,
        ATextColor, S, IndentDesc, IsUseBitmap);
    end;
    // end custom draw
//    if ExistEvent then
    AFont.Assign(FSaveFont);
    if ColorToRGB(AColor) <> ColorToRGB(ANewColor) then
      SetBkColor(Handle, PrevBkColor);
  end;
end;

function TCustomdxTreeList.GetGridColor(ABrushColor : TColor) : TColor;
begin
  if FGridLineColor <> clNone then
    Result := FGridLineColor
  else Result := FGridColor;
end;

procedure TCustomdxTreeList.InvalidateHotTrack(AHotTrackInfo: TdxTreeListHotTrackInfo);
var
  Ind, FullInd: Integer; 
  R: TRect;
begin
  with AHotTrackInfo do
  begin
    // Node
    if (Node <> nil) and (Column <> -1) then
    begin
      R := CellRect(Node, GetFocusedVisibleIndex(Column));
      InvalidateRect(R);
      // Indent TODO PAINT
      GetNodeIndent(Node, Ind, FullInd);
      R.Left := 0;
      R.Right := FullInd;
      InvalidateRect(R);
    end;
    // Header
    if (Column <> -1) and (HeaderHotTrack <> hhtNone) then
    begin
      InvalidateColumn(Column);
    end;
  end;
end;

procedure TCustomdxTreeList.InvalidateRect(ARect: TRect);
begin
  if not HandleAllocated then Exit;
  Windows.InvalidateRect(Handle, @ARect, False);
end;

procedure TCustomdxTreeList.PrepareNode(ANode: TdxTreeListNode);
begin
end;

procedure TCustomdxTreeList.UnPrepareNode(ANode: TdxTreeListNode);
begin
end;

// private TCustomdxTreeList
// based
function TCustomdxTreeList.FindListNode(Node: TdxTreeListNode): Integer;
var
  L, H, I, C: Integer;
begin
  Result := -1;
  L := 0;
  H := FListNodes.Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := {DWORD}Integer(FListNodes.List^[I]) - {DWORD}Integer(Node);
    if C = 0 then
    begin
      Result := I;
      Break;
    end
    else
      if (C < 0) then L := I + 1
      else H := I - 1;
  end;
end;

function TCustomdxTreeList.GetCount: Integer;
begin
  Result := FNodeList.Count;
end;

function TCustomdxTreeList.GetFocused: TdxTreeListNode;
begin
  Result := FFocused;
end;

function TCustomdxTreeList.GetFocusedColumn: Integer;
begin
  Result := 0;
  if IsRowSelect then Exit;
  if (FFocusedColumn >=0) and
     (FFocusedColumn < GetVisibleHeaderCount) then
     Result := FFocusedColumn;
end;

function TCustomdxTreeList.GetFocusedNumber: Integer;
begin
  Result := 0;
  if FocusedNode <> Nil then
    Result := GetAbsoluteIndex(FocusedNode);
end;

function TCustomdxTreeList.GetLastNode: TdxTreeListNode;
begin
  Result := nil;
  if Count > 0 then
  begin
    Result := Items[Count - 1];
    while (Result.Count > 0) and (Result.Expanded) do
      Result := Result[Result.Count - 1];
  end;
end;

function TCustomdxTreeList.GetNode(Index: Integer): TdxTreeListNode;
begin
  if (Index > -1) and (Index < FNodeList.Count{Count}) then
    Result := FNodeList.List^[Index]
  else Result := nil;
end;

function TCustomdxTreeList.GetOptions: TdxTreeListOptions;
begin
  Result := FOptions;
end;

function TCustomdxTreeList.GetOptionsEx: TdxTreeListOptionsEx;
begin
  Result := FOptionsEx;
end;

function TCustomdxTreeList.GetTopIndex: Integer;
begin
  Result := -1;
  if TopVisibleNode <> Nil then
    Result := GetAbsoluteIndex(TopVisibleNode);
end;

function TCustomdxTreeList.IsActiveControl: Boolean;
var
  H: Hwnd;
begin
  Result := False;
  begin
    H := GetFocus;
    while IsWindow(H) and (Result = False) do
    begin
      if H = WindowHandle then
        Result := True
      else
        H := GetParent(H);
    end;
  end;
end;

function TCustomdxTreeList.IsSmartNavigation: Boolean;
begin
  Result := (FListIndexes <> nil) and (FListNodes <> nil) and
    (FListRealNodes <> nil) and (FListNodes.Count > 0) and
   not (csDestroying in ComponentState);
end;

procedure TCustomdxTreeList.SetFocusedColumn(Value: Integer);
begin
  if (FFocusedColumn <> Value) and (Value >=0) and (Value < GetVisibleHeaderCount) then
    SetFocusedNode(FocusedNode, Value, True);
end;

procedure TCustomdxTreeList.SetLeftCoord(ALeft: Integer);
var
  FLeft, FTotal : Integer;
  Distance: Integer;
begin
  HideEditor;
  FLeft := LeftCoord;
  if FLeft <> ALeft then
  begin
    if (ALeft < 0) then ALeft := 0;
    FTotal := GetScrollableBandWidth; 
    if ((ALeft + GetScrollableWidth) > FTotal) then
      ALeft := FTotal - GetScrollableWidth;
    if ALeft < 0 then ALeft := 0;
    if (ALeft <> FLeft) then
    begin
      FLeftCoord := ALeft;
      UpdateScrollBars;
      if FLockUpdate <> 0 then Exit;
      Distance := (FLeft - ALeft);
      if ShowFooter or (abs(Distance) > GetScrollableWidth) or (GetBandFixedLeft <> -1) or
       (GetBandFixedRight <> -1) then
       Invalidate
      else
      begin
        HideDragImages;
        try
          ScrollGridHorz(Distance);
        finally
          ShowDragImages;
        end;
      end;
      // event
      DoChangeLeftCoord;
    end;
  end;
end;

procedure TCustomdxTreeList.SetOptions(Value: TdxTreeListOptions);
var
  OldOptions: TdxTreeListOptions;
begin
  if FOptions <> Value then
  begin
    HideEditor;
    BeginUpdate;
    try
      OldOptions := FOptions;
      if aoRowSelect in Value then
        OptionsEx := OptionsEx - [aoInvertSelect];
      if (aoAutoSort in Value) and not (aoAutoSort in FOptions) then
        ClearColumnsSorted;
      if (aoKeepColumnWidth in OptionsEx) and (aoAutoWidth in OldOptions) and
        not (aoAutoWidth in Value) then StabilizeAutoWidth;
      FOptions := Value;
      if not (csLoading in ComponentState) then
      begin
        ClearSelection;
        if (FocusedNode <> Nil) then
           FocusedNode.Selected := True;
        if not IsRowSelect and
          (FocusedColumn = -1) then FocusedColumn := 0;
      end;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TCustomdxTreeList.SetOptionsEx(Value: TdxTreeListOptionsEx);
var
  OldOptions: TdxTreeListOptionsEx;
begin
  if FOptionsEx <> Value then
  begin
    HideEditor;
    BeginUpdate;
    try
      OldOptions := FOptionsEx;
      if aoInvertSelect in Value then
        Options := Options - [aoRowSelect];
      if ((aoMultiSort in FOptionsEx) and not (aoMultiSort in Value)) or
        ((aoAnsiSort in FOptionsEx) <> (aoAnsiSort in Value)) then
        ClearColumnsSorted;
      FOptionsEx := Value;
      if (aoAutoHeaderPanelHeight in FOptionsEx) and
        not (aoAutoHeaderPanelHeight in OldOptions) then HeaderPanelBestFit;
      if FSearching and not (aoAutoSearch in FOptionsEx) then EndSearch;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TCustomdxTreeList.SetTopIndex(AIndex: Integer);
var
  FTopIndex, FCount, FRealRowCount, FDummy: Integer;
  Distance, DScroll: Integer;
  OldRect, NewRect: TRect;
  DrawInfo: TdxGridDrawInfo;
begin
  HideEditor;
  FTopIndex := TopIndex;
  if FTopIndex <> AIndex then
  begin
    if (AIndex < 0) then AIndex := 0;
    FCount := GetAbsoluteCount;
    if FCount <= 1 then Exit;
    FRealRowCount := RowCount;
    CalcRectInfo(DrawInfo);
    with DrawInfo.CellsRect do
      CalcRowCount(GetAbsoluteNode(AIndex), Bottom - Top, FRealRowCount, FDummy);
    if (AIndex + FRealRowCount{RowCount}) > FCount then
      AIndex := FCount - RowCount;
    if (AIndex < 0) then AIndex := 0;
    Distance := (FTopIndex - AIndex);
    if Distance = 0 then
      DScroll := 0
    else DScroll := CalcDistance(Distance);
    if (AIndex <> FTopIndex) then
    begin
      OldRect := GetRectNode(FocusedNode);
      SetTopVisibleNode(GetAbsoluteNode(AIndex));
      UpdateScrollBars;
      if FLockUpdate <> 0 then Exit;
      NewRect := GetRectNode(FocusedNode);
      ValidateRect(Handle, @OldRect);
      Windows.InvalidateRect(Handle, @OldRect, False);
      Windows.InvalidateRect(Handle, @NewRect, False);
    end;
    // scrolling
    if Abs(Distance) > RowCount then
      Invalidate
    else
    begin
      HideDragImages;
      try
        ScrollGridVert(DScroll);
      finally
        ShowDragImages;
      end;
    end;
  end;
end;

procedure TCustomdxTreeList.UpdateDesigner;
var
  ParentForm: {$IFNDEF DELPHI3}TForm{$ELSE}TCustomForm{$ENDIF};
begin
  if (csDesigning in ComponentState) and HandleAllocated and
    not (csUpdating in ComponentState) then
  begin
    ParentForm := GetParentForm(Self);
    if Assigned(ParentForm) and Assigned(ParentForm.Designer) then
      ParentForm.Designer.Modified;
  end;
end;

procedure TCustomdxTreeList.UpdateHScrollBar;
var
  SIOld, SINew: TScrollInfo;
  FTotalWidth : Integer;
begin
  if not HandleAllocated then Exit;
  if IsHScrollBarVisible then
  begin
    SIOld.cbSize := sizeof(SIOld);
    SIOld.fMask := SIF_ALL;
    GetScrollInfo(SB_HORZ, SIOld);
    SINew := SIOld;
    SINew.nMin := 0;
    SINew.nPage := GetScrollableWidth;
    FTotalWidth := GetScrollableBandWidth;
    SINew.nMax :=  FTotalWidth - 1;
    if FTotalWidth <= GetScrollableWidth then SINew.nMax := 0;
    SINew.nPos := FLeftCoord;
    if (SINew.nMin <> SIOld.nMin) or (SINew.nMax <> SIOld.nMax) or
       (SINew.nPage <> SIOld.nPage) or (SINew.nPos <> SIOld.nPos) then
    begin
       HideDragImages;
       try
         SetScrollInfo(SB_HORZ, SINew, True);
       finally
         ShowDragImages;
       end;
    end;
  end;
end;

procedure TCustomdxTreeList.UpdateTopLeftCoord;
var
  FTopIndex, FCount : Integer;
begin
  if not HandleAllocated then Exit;
  {TopIndex}
  FTopIndex := TopIndex;
  FCount := GetAbsoluteCount;
  if ((FTopIndex + RowCount) > FCount) then FTopIndex := FCount - RowCount;
  if FTopIndex < 0 then FTopIndex := 0;
  if FTopIndex <> TopIndex then TopIndex := FTopIndex;
  {LeftCoord}
  if GetScrollableWidth >= GetScrollableBandWidth then
  begin
    if (LeftCoord <> 0) then  LeftCoord := 0
  end
  else
    if (LeftCoord + GetScrollableWidth) > GetScrollableBandWidth then
    begin
      FLeftCoord := GetScrollableBandWidth - GetScrollableWidth;
      Invalidate;
    end;
end;

procedure TCustomdxTreeList.UpdateVScrollBar;
var
  SIOld, SINew: TScrollInfo;
begin
  if not HandleAllocated then Exit;
  UpdateRowCount;
  if IsVScrollBarVisible then
  begin
    SIOld.cbSize := SizeOf(SIOld);
    SIOld.fMask := SIF_ALL;
    GetScrollInfo(SB_VERT, SIOld);
    SINew := SIOld;
    GetVScrollInfo(SINew.nMin, SINew.nMax, SINew.nPos, SINew.nPage, SINew.fMask);
    if (SINew.nMin <> SIOld.nMin) or (SINew.nMax <> SIOld.nMax) or
       (SINew.nPage <> SIOld.nPage) or (SINew.nPos <> SIOld.nPos) or
       (SINew.fMask <> SIOld.fMask)  then
    begin
       HideDragImages;
       try
         SetScrollInfo(SB_VERT, SINew, True);
       finally
         ShowDragImages;
       end;
    end;
  end;
end;

// size
function TCustomdxTreeList.GetDefaultRowHeight: Integer;
begin
  Result := FRowHeight;
end;

function TCustomdxTreeList.IsRowHeightStored: Boolean;
begin
  Result := FRowHeightAssigned;
end;

procedure TCustomdxTreeList.SetCustomizingRowCount(Value: Integer);
begin
  if Value < 2 then Value := 2;
  FCustomizingRowCount := Value;
end;

procedure TCustomdxTreeList.SetDefaultRowHeight(Value: Integer);
begin
  if FRowHeight <> Value then
  begin
    FRowHeight := Value;
    FRowHeightAssigned := True;
    LayoutChanged;
  end;
end;

procedure TCustomdxTreeList.SetFixedBandLineWidth(Value: Integer);
begin
  if Value < 1 then Value := 1;
  if FFixedBandLineWidth <> Value then
  begin
    FFixedBandLineWidth := Value;
    LayoutChanged;
  end;
end;

procedure TCustomdxTreeList.SetIndentDesc(Value : Integer);
begin
  if Value < 0 then Value := 0;
  if IndentDesc <> Value then
  begin
    FIndentDesc := Value;
    LayoutChanged;
//    Invalidate;
  end;
end;

procedure TCustomdxTreeList.SetMaxRowLineCount(Value: Integer);
begin
  if Value < -1 then Value := -1;
  if FMaxRowLineCount <> Value then
  begin
    FMaxRowLineCount := Value;
    LayoutChanged;
  end;
end;

procedure TCustomdxTreeList.SetPreviewLines(Value: Integer);
begin
  if Value < -1 then Value := -1;
//  if Value < 0 then Value := 0;
//  if Value > dxGridPreviewMaxLineCount then
//    Value := dxGridPreviewMaxLineCount;
  if FPreviewLines <> Value then
  begin
    FPreviewLines := Value;
    LayoutChanged;
  end;
end;

procedure TCustomdxTreeList.SetRowSeparatorLineWidth(Value: Integer);
begin
  if Value < 1 then Value := 1;
  if FRowSeparatorLineWidth <> Value then
  begin
    FRowSeparatorLineWidth := Value;
    LayoutChanged;
  end;
end;

// paint methods
procedure TCustomdxTreeList.DrawArrows(FlagHide : Boolean);
const
  CurSize = 16;
var
  PrevBrush: HBRUSH;
  PrevPen: HPEN;
  DC: HDC;
  P: array [0..6] of TPoint;
  Pos, HotSpot: TPoint;
  SizeX, SizeY: Integer;
  R: TRect;
begin
  FSaveArrowsRect := Rect(FArrowsPos.X, FArrowsPos.Y,
    FArrowsPos.X + FArrowsRect.Right, FArrowsPos.Y + FArrowsRect.Bottom);
  if FlagHide and (FDragImageList <> nil) and FDragImageList.Dragging then  // check intersect rect
  begin
    ImageList_GetIconSize(ImageList_GetDragImage(@Pos, @HotSpot), SizeX, SizeY);
    R := Rect(Pos.X, Pos.Y, Pos.X + SizeX, Pos.Y + SizeY);
    OffsetRect(R, -HotSpot.X, -HotSpot.Y);
    if not IntersectRect(R, R, FSaveArrowsRect) then
      FlagHide := False;
  end;
  if FlagHide and (FDragImageList <> nil) and FDragImageList.Dragging then
    FDragImageList.HideDragImage;
  DC := GetDC(0);
  with SaveArrowsBitmap, FArrowsRect Do
  begin
    Width := Max(Width, Right - Left);
    Height := Max(Height, Bottom - Top);
  end;
  if not FFlagSaveArrowsRect then // save Screen rect
  begin
    with FSaveArrowsRect do
      BitBlt(SaveArrowsBitmap.Canvas.Handle, 0, 0, Right-Left, Bottom-Top,
        DC, FSaveArrowsRect.Left, FSaveArrowsRect.Top, SRCCOPY);
    FFlagSaveArrowsRect := True;
    // Draw Arrows
    PrevPen := SelectObject(DC, GetStockObject(BLACK_PEN));
    PrevBrush := SelectObject(DC, CreateSolidBrush(ColorToRGB(FArrowsColor)));
    with FSaveArrowsRect do
    begin
      P[0] := Point(Left + 5, Top + 8);
      P[1] := Point(Left, Top + 3);
      P[2] := Point(Left + 3, Top + 3);
      P[3] := Point(Left + 3, Top);
      P[4] := Point(Left + 7, Top);
      P[5] := Point(Left + 7, Top + 3);
      P[6] := Point(Left + 10, Top + 3);
      Polygon(DC, P, 7);
      P[0] := Point(Left + 5, Bottom - 9);
      P[1] := Point(Left + 10, Bottom - 4);
      P[2] := Point(Left + 7, Bottom - 4);
      P[3] := Point(Left + 7, Bottom - 1);
      P[4] := Point(Left + 3, Bottom - 1);
      P[5] := Point(Left + 3, Bottom - 4);
      P[6] := Point(Left, Bottom - 4);
      Polygon(DC, P, 7);
    end;
    DeleteObject(SelectObject(DC, PrevBrush));
    SelectObject(DC, PrevPen);
  end
  else // restore Screen rect
  begin
    with FSaveArrowsRect do
      BitBlt(DC, Left, Top, Right - Left, Bottom - Top,
        SaveArrowsBitmap.Canvas.Handle, 0, 0, SRCCOPY);
    FFlagSaveArrowsRect := False;
  end;
  ReleaseDC(0, DC);
  if FlagHide and (FDragImageList <> nil) and FDragImageList.Dragging then
    FDragImageList.ShowDragImage;
end;

procedure TCustomdxTreeList.DrawSizingLine;
var
  DC: HDC;
  PrevPen: HPEN;
  PrevROP2: Integer;
  DrawInfo: TdxGridDrawInfo;
  x1, y1, x2, y2, i, W: Integer;
  FlagVert: Boolean;
begin
  DC := Canvas.Handle;
  PrevPen := SelectObject(DC, GetStockObject(BLACK_PEN));
  PrevROP2 := GetROP2(DC);
  try
    SetROP2(DC, R2_NOTXORPEN);
    // draw line
    CalcRectInfo(DrawInfo);
    with DrawInfo do
    begin
      // vert line
      if FState in [tsColumnSizing, tsBandSizing] then
      begin
        x1 := FSizingPos;
        y1 := CellsRect.Top;
        x2 := FSizingPos;
        y2 := CellsRect.Bottom;
        FlagVert := True;
        if (FState = tsBandSizing) then
          if not IsRectEmpty(BandRect) then
            y1 := BandRect.Top
          else y1 := HeaderRect.Top
        else
        if (FState = tsColumnSizing) and not IsRectEmpty(HeaderRect) then
          y1 := HeaderRect.Top;
        if (FState = tsBandSizing) then W := 2
        else W := 1;
      end
      else // horz line if FState in [tsBandPanelSizing, tsHeaderPanelSizing, tsRowSizing] then
      begin
        x1 := CellsRect.Left;
        y1 := FSizingPos;
        x2 := CellsRect.Right;
        y2 := FSizingPos;
        FlagVert := False;
        if FState = tsRowSizing then
        begin
          W := 1;
          if not IsRectEmpty(IndicatorRect) then
            x1 := IndicatorRect.Left;
        end
        else W := 2;
      end;
      for i := 0 to W - 1 do
      begin
        Windows.MoveToEx(DC, x1, y1, nil);
        Windows.LineTo(DC, x2, y2);
        if FlagVert then
        begin
          Inc(x1);
          Inc(x2);
        end
        else
        begin
          Inc(y1);
          Inc(y2);
        end;
      end;
    end;
  finally
    SelectObject(DC, PrevPen);
    SetROP2(DC, PrevROP2);
  end;
end;

function TCustomdxTreeList.GetFooterRect(Node: TdxTreeListNode;
  Index, YStart, SizeGrid: Integer; const DrawInfo: TdxGridDrawInfo): TRect;
var
  I: Integer;
begin
  with DrawInfo do
  begin
    I := GetNodeFooterLevel(Node, Index);
    if I <> -1 then
      I := (I + 1) * FIndent
    else I := 0;
    Result := Rect(CellsRect.Left + I, YStart + Index * FFooterRowNodeHeight,
      CellsRect.Left + GetBandTotalWidth - SizeGrid, YStart + (Index + 1) * FFooterRowNodeHeight);
{.}      if not ShowRoot then
      Dec(Result.Left, FIndent);
    if IsRectEmptyEx(FixedBandLeftRect) then
      OffsetRect(Result, - LeftCoord, 0)
    else Dec(Result.Right, LeftCoord);
    if not IsRectEmptyEx(FixedBandRightRect) then
    begin
      if (Result.Right >= CellsRect.Right) then
        Result.Right := CellsRect.Right - SizeGrid;
      if Result.Left > FixedBandRightRect.Left then
        Result.Left := FixedBandRightRect.Left;
    end;
    if Result.Left < CellsRect.Left then
      Result.Left := CellsRect.Left;
  end;
end;

procedure TCustomdxTreeList.InvalidateBand(BandIndex: Integer);
var
  DrawInfo: TdxGridDrawInfo;
begin
  CalcRectInfo(DrawInfo);
  Windows.InvalidateRect(Handle, @DrawInfo.BandRect, False);
  UpdateWindow(Handle);
end;

procedure TCustomdxTreeList.InvalidateBandButton;
var
  DrawInfo: TdxGridDrawInfo;
begin
  CalcRectInfo(DrawInfo);
  Windows.InvalidateRect(Handle, @DrawInfo.BandButtonRect, False);
  UpdateWindow(Handle);
end;

procedure TCustomdxTreeList.InvalidateColumn(ColumnIndex: Integer);
var
  DrawInfo: TdxGridDrawInfo;
begin
  CalcRectInfo(DrawInfo);
  Windows.InvalidateRect(Handle, @DrawInfo.HeaderRect, False);
  UpdateWindow(Handle);
end;

procedure TCustomdxTreeList.InvalidateHeaderButton;
var
  DrawInfo: TdxGridDrawInfo;
begin
  CalcRectInfo(DrawInfo);
  Windows.InvalidateRect(Handle, @DrawInfo.HeaderButtonRect, False);
  UpdateWindow(Handle);
end;

procedure TCustomdxTreeList.InvalidateNewItemRow;
var
  DrawInfo: TdxGridDrawInfo;
begin
  CalcRectInfo(DrawInfo);
  Windows.InvalidateRect(Handle, @DrawInfo.NewItemRowRect, False);
end;

// style
function TCustomdxTreeList.GetRootVisible: Boolean;
begin
  Result := FShowRoot or not FPaintStandard;
end;

procedure TCustomdxTreeList.HeaderFontChanged(Sender: TObject);
begin
  if (not FSelfChangingTitleFont) and not (csLoading in ComponentState) then
    ParentFont := False;
  LayoutChanged;
end;

procedure TCustomdxTreeList.ImageListChange(Sender: TObject);
begin
  if HandleAllocated then
    if (Sender = Images) or
       (Sender = StateImages) then  LayoutChanged;
end;

procedure TCustomdxTreeList.InternalLayout;
var
  H: Integer;
begin
  if (csLoading in ComponentState) or (csDestroying in ComponentState) then Exit;
  Canvas.Handle := GetDC(0);
  try
    FBandRowCount := GetBandRowCount;
    FHeaderRowCount := GetHeaderMaxRowCount;
    FHeaderLineCount := GetHeaderLineRowCount;
    FFlat := Boolean(LookAndFeel <> lfStandard);
    FPaintStandard := not Boolean(PaintStyle);
    // Band
    Canvas.Font.Assign(BandFont);
    FBandTextHeight := Canvas.TextHeight('Wg');
    FBandHeight := CalcBandHeight(FBandRowCount);
    if not FShowBands then FBandHeight := 0;
    // Header
    Canvas.Font.Assign(HeaderFont);
    FHeaderRowHeight := FHeaderLineCount * Canvas.TextHeight('Wg') + 3{indent}
      + 2 + Byte(not FFlat){black line -> right_bottom};
    FHeaderHeight := FHeaderRowHeight * FHeaderRowCount;
    if not ShowHeader then FHeaderHeight := 0;
    // Arrows
    FArrowsRect := Rect(0, 0, arWidth{9}, FHeaderRowHeight + 2*arHeight{9});
    // Group Panel
    FGroupPanelHeight := GetGroupPanelHeight;
    // Indicator Width
    if FShowIndicator then
      FIndicatorWidth := GetIndicatorWidth{12}
    else FIndicatorWidth := 0;
    // Ground
    Canvas.Font.Assign(Self.Font);
    FTextHeight := Canvas.TextHeight('Wg');
    // Footer
    FFooterRowHeight := FTextHeight + 3 {text} + 2 {text frame} + 2 {text indent};
    FFooterHeight := FFooterRowHeight * FHeaderRowCount + 3 {frame} + Byte(not FFlat);
    FFooterRowNodeHeight := FFooterRowHeight * FHeaderRowCount + 2 + Byte(FShowGrid and FShowPreviewGrid);
    if not FShowFooter then
      FFooterHeight := 0;
    // Filter (Status)
    if IsFilterStatusVisible then
    begin
      FStatusHeight := FTextHeight + 3 + 2;
      if FStatusHeight < dxGridStatusCloseButtonMinHeight then
        FStatusHeight := dxGridStatusCloseButtonMinHeight;
    end  
    else
      FStatusHeight := 0;  // TODO
    // Row
    FMinRowHeight := CalcTextRowHeight(FTextHeight);
    FDeltaHScroll := Canvas.TextWidth('0');
    FImageW := 0; FImageH := 0;
    FImageStateW := 0; FImageStateH := 0;
    FImageButtonW := 16; FImageButtonH := 16;
    if Images <> nil then
    begin
      FImageW := Images.Width;
      FImageH := Images.Height;
    end;
    if StateImages <> nil then
    begin
      FImageStateW := StateImages.Width;
      FImageStateH := StateImages.Height;
    end;
    FIndent := FImageButtonW;
    // correct FMinRowHeight - Image Height
    if FMinRowHeight < FImageButtonH then
       FMinRowHeight := FImageButtonH;

    H := FMinRowHeight + Byte(FShowGrid and FShowPreviewGrid); // Text and Grid Line
    if FHeaderRowCount*H < FImageH then
      FMinRowHeight := FImageH;
    H := FMinRowHeight + Byte(FShowGrid and FShowPreviewGrid); // Text and Grid Line
    if FHeaderRowCount*H < FImageStateH then
       FMinRowHeight := FImageStateH;
    // check FMinRowHeight - column Image Height
    H := GetRowMaxColumnHeight(Canvas);
//*    if {FHeaderRowCount*}(FMinRowHeight + Byte(FShowGrid and FShowPreviewGrid)) < H then
//*      FMinRowHeight := H;
    if FHeaderRowCount*(FMinRowHeight + Byte(FShowGrid and FShowPreviewGrid)) < H then
      FMinRowHeight := H;

//    if FMinRowHeight < H then FMinRowHeight := H;

    Inc(FMinRowHeight, Byte(FShowGrid and FShowPreviewGrid));

    if IsInvertSelect then
      Inc(FMinRowHeight, 2);
    // correct FMinRowHeight - custom resing
    if not FRowHeightAssigned then
      FRowHeight := FMinRowHeight;
    if FRowHeight < FMinRowHeight then
      FRowHeight := FMinRowHeight;
    if FRowHeight = FMinRowHeight then
       FRowHeightAssigned := False;
    // New Item Row Height
    FNewItemRowHeight := 0;
    if FFlat then
      FNewItemRowSeparatorHeight := 5
    else FNewItemRowSeparatorHeight := 6;
    if FHeaderRowCount = 1 then
      FNewItemRowHeight := FRowHeight + FNewItemRowSeparatorHeight;
    if not IsNewItemRowVisible or (GetBandCount = 0) then FNewItemRowHeight := 0;
    // Preview
    Canvas.Font.Assign(PreviewFont);
    FDescTextHeight := Canvas.TextHeight('Wg');
  finally
    ReleaseDC(0, Canvas.Handle);
    Canvas.Handle := 0;
  end;
  {**}
  ClearListNodes;
  {**}
  BeginCustomLayout;
  UpdateScrollBars;
  UpdateTopLeftCoord;
  UpdateCustomizingColumns;
  {**}
  MakeListNodes;
  {**}
  EndCustomLayout;
  if not FMakeListNodesFlag then MakeListNodes;
  CheckSize;
  Invalidate;
end;

function TCustomdxTreeList.IsHeaderFontStored: Boolean;
begin
  Result := not ParentFont and not DesktopFont;
end;

procedure TCustomdxTreeList.LoadButtonFaces;
var
  Bmp: TBitmap;
  R : TRect;

  procedure DrawOutlookButton(B: TBitmap; R: TRect; IsPlus: Boolean);
  begin
    with B.Canvas do
    begin
      DrawEdge(Handle, R, BDR_RAISEDINNER, BF_LEFT or BF_TOP);
      DrawEdge(Handle, R, BDR_RAISEDOUTER, BF_RIGHT or BF_BOTTOM);
      InflateRect(R, -1, -1);
      DrawEdge(Handle, R, BDR_RAISEDINNER, BF_RIGHT or BF_BOTTOM);
      Dec(R.Right);
      Dec(R.Bottom);
      Windows.FillRect(Handle, R, COLOR_BTNFACE + 1);
      Windows.FillRect(Handle, Rect(3, 5, 8, 5 + 1), COLOR_BTNTEXT + 1);
      if IsPlus then
        Windows.FillRect(Handle, Rect(5, 3, 5 + 1, 8), COLOR_BTNTEXT + 1);
    end;
  end;

begin
  Bmp := TBitmap.Create;
  try
    Bmp.Width :=12;
    Bmp.Height := 12;
    R := Rect(0, 0, Bmp.Width, Bmp.Height);
    DrawOutlookButton(Bmp, R, True{+});
    OutButtonPlus.Assign(Bmp);
    DrawOutlookButton(Bmp, R, False{-});
    OutButtonMinus.Assign(Bmp);
  finally
    Bmp.Free;
  end;
end;

procedure TCustomdxTreeList.SetBandColor(Value: TColor);
begin
  if FBandColor <> Value then
  begin
    FBandColor := Value;
    Invalidate;
  end;
end;

procedure TCustomdxTreeList.SetBandFont(Value: TFont);
begin
  FBandFont.Assign(Value);
  LayoutChanged;
end;

procedure TCustomdxTreeList.SetBandVisible(Value: Boolean);
begin
  if FShowBands <> Value then
  begin
    FShowBands := Value;
    LayoutChanged;
  end;
end;

procedure TCustomdxTreeList.SetBorderStyle(Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    {if LookAndFeel = lfStandard then }RecreateWnd;
  end;
end;

procedure TCustomdxTreeList.SetButtonVisible(Value: Boolean);
begin
  if FShowButtons <> Value then
  begin
    FShowButtons := Value;
    Invalidate;
  end;
end;

procedure TCustomdxTreeList.SetFixedBandLineColor(Value: TColor);
begin
  if FFixedBandLineColor <> Value then
  begin
    FFixedBandLineColor := Value;
    Invalidate;
  end;
end;

procedure TCustomdxTreeList.SetFooterColor(Value: TColor);
begin
  if FFooterColor <> Value then
  begin
    FFooterColor := Value;
    Invalidate;
  end;
end;

procedure TCustomdxTreeList.SetFooterTextColor(Value: TColor);
begin
  if FFooterTextColor <> Value then
  begin
    FFooterTextColor := Value;
    Invalidate;
  end;
end;

procedure TCustomdxTreeList.SetFooterVisible(Value: Boolean);
begin
  if FShowFooter <> Value then
  begin
    FShowFooter := Value;
    LayoutChanged;
  end;
end;

procedure TCustomdxTreeList.SetGridLineColor(Value: TColor);
begin
  if FGridLineColor <> Value then
  begin
    FGridLineColor := Value;
    Invalidate;
  end;
end;

procedure TCustomdxTreeList.SetGridVisible(Value: Boolean);
begin
  if FShowGrid <> Value then
  begin
    FShowGrid := Value;
    LayoutChanged;
  end;
end;

procedure TCustomdxTreeList.SetGroupColor(Value : TColor);
begin
  if FGroupColor <> Value then
  begin
    FGroupColor := Value;
    Invalidate;
  end;
end;

procedure TCustomdxTreeList.SetGroupTextColor(Value : TColor);
begin
  if FGroupTextColor <> Value then
  begin
    FGroupTextColor := Value;
    Invalidate;
  end;
end;

procedure TCustomdxTreeList.SetHeaderColor(Value: TColor);
begin
  if FHeaderColor <> Value then
  begin
    FHeaderColor := Value;
    Invalidate;
  end;
end;

procedure TCustomdxTreeList.SetHeaderFont(Value: TFont);
begin
  FHeaderFont.Assign(Value);
  LayoutChanged;
end;

procedure TCustomdxTreeList.SetHeaderVisible(Value: Boolean);
begin
  if FShowHeaders <> Value then
  begin
    FShowHeaders := Value;
    LayoutChanged;
  end;
end;

procedure TCustomdxTreeList.SetHideFocusRect(Value: Boolean);
begin
  if HideFocusRect <> Value then
  begin
    FHideFocusRect := Value;
    Invalidate;
  end;
end;

procedure TCustomdxTreeList.SetHideSelection(Value: Boolean);
begin
  if HideSelection <> Value then
  begin
    FHideSelection := Value;
    Invalidate;
  end;
end;

procedure TCustomdxTreeList.SetHideSelectionColor(Value: TColor);
begin
  if FHideSelectionColor <> Value then
  begin
    FHideSelectionColor := Value;
    Invalidate;
  end;
end;

procedure TCustomdxTreeList.SetHideSelectionTextColor(Value: TColor);
begin
  if FHideSelectionTextColor <> Value then
  begin
    FHideSelectionTextColor := Value;
    Invalidate;
  end;
end;

procedure TCustomdxTreeList.SetHighlightColor(Value : TColor);
begin
  if FHighlightColor <> Value then
  begin
    FHighlightColor := Value;
    Invalidate;
  end;
end;

procedure TCustomdxTreeList.SetHighlightTextColor(Value : TColor);
begin
  if FHighlightTextColor <> Value then
  begin
    FHighlightTextColor := Value;
    Invalidate;
  end;
end;

procedure TCustomdxTreeList.SetImages(Value: TImageList);
begin
  BeginUpdate;
  if Images <> nil then
    Images.UnRegisterChanges(FImageChangeLink);
  FImages := Value;
  if Value <> nil then
  begin
    Images.RegisterChanges(FImageChangeLink);
    Value.FreeNotification(Self);
  end;
  EndUpdate;
end;

procedure TCustomdxTreeList.SetIndicatorVisible(Value: Boolean);
begin
  if FShowIndicator <> Value then
  begin
    FShowIndicator := Value;
    LayoutChanged;
  end;
end;

procedure TCustomdxTreeList.SetLineVisible(Value: Boolean);
begin
  if ShowLines <> Value then
  begin
    FShowLines := Value;
    Invalidate;
  end;
end;

procedure TCustomdxTreeList.SetLookAndFeel(Value: TdxLookAndFeel);
begin
  if LookAndFeel <> Value then
  begin
    CancelEditor;
    FLookAndFeel := Value;
    {$IFDEF DELPHI4}
    if FLookAndFeel = lfUltraFlat then
      ScrollBarStyle := ssHotTrack
    else
      ScrollBarStyle := ssRegular;
    {$ENDIF}
    LoadButtonFaces;
    RecreateWnd;
    LayoutChanged;
  end;
end;

procedure TCustomdxTreeList.SetNewItemRowVisible(Value: Boolean);
begin
  if FShowNewItemRow <> Value then
  begin
    if not Value and NewItemRowActive then
      NewItemRowActive := False;
    FShowNewItemRow := Value;
    LayoutChanged;
  end;
end;

procedure TCustomdxTreeList.SetPaintStyle(Value: TdxTreeListPaintStyle);
begin
  if PaintStyle <> Value then
  begin
    FPaintStyle := Value;
    LayoutChanged;
  end;
end;

procedure TCustomdxTreeList.SetPreviewFont(Value: TFont);
begin
  FPreviewFont.Assign(Value);
  LayoutChanged;
end;

procedure TCustomdxTreeList.SetPreviewGridVisible(Value: Boolean);
begin
  if FShowPreviewGrid <> Value then
  begin
    FShowPreviewGrid := Value;
    LayoutChanged;
  end;
end;

procedure TCustomdxTreeList.SetRootVisible(Value: Boolean);
begin
  if FShowRoot <> Value then
  begin
    FShowRoot := Value;
    LayoutChanged;
    //Invalidate;
  end;
end;

procedure TCustomdxTreeList.SetRowFooterVisible(Value: Boolean);
begin
  if FShowRowFooter <> Value then
  begin
    FShowRowFooter := Value;
    LayoutChanged;
  end;
end;

procedure TCustomdxTreeList.SetScrollBars(Value: TScrollStyle);
begin
  if FScrollBars <> Value then
  begin
    FScrollBars := Value;
    RecreateWnd;
  end;
end;

procedure TCustomdxTreeList.SetStateImages(Value: TImageList);
begin
  BeginUpdate;
  if StateImages <> nil then
    StateImages.UnRegisterChanges(FStateChangeLink);
  FStateImages := Value;
  if Value <> nil then
  begin
    StateImages.RegisterChanges(FStateChangeLink);
    Value.FreeNotification(Self);
  end;
  EndUpdate;
end;

procedure TCustomdxTreeList.SetTreeLineColor(Value : TColor);
begin
  if FTreeLineColor <> Value then
  begin
    FTreeLineColor := Value;
    Invalidate;
  end;
end;

procedure TCustomdxTreeList.SetTreeLineStyle(Value: TdxTreeLineStyle);
begin
  if FTreeLineStyle <> Value then
  begin
    FTreeLineStyle := Value;
    Invalidate;
  end;
end;

// Other
procedure TCustomdxTreeList.ActivateCustomizingForm(Sender: TObject);
begin
  HideEditor;
end;

procedure TCustomdxTreeList.CloseCustomizingForm(Sender: TObject; var Action: TCloseAction);
begin
  FCustomizingPos.X := FCustomizingForm.Left;
  FCustomizingPos.Y := FCustomizingForm.Top;
  if FCustomizingBandListBox <> nil then
    FCustomizingLastBandIndex := FCustomizingBandListBox.ItemIndex
  else FCustomizingLastBandIndex := -1;
  if FCustomizingHeaderListBox <> nil then
    FCustomizingLastHeaderIndex := FCustomizingHeaderListBox.ItemIndex
  else FCustomizingLastHeaderIndex := -1;
  Action := caFree;
  FCustomizingForm := nil;
  FCustomizingBandListBox := nil;
  FCustomizingHeaderListBox := nil;
  if Assigned(FOnEndColumnsCustomizing) then FOnEndColumnsCustomizing(Self);
end;

procedure TCustomdxTreeList.SetDragObject(Value: TDragObject);
var
  PrevDragObject: TDragObject;
begin
  if FDragObject <> Value then
  begin
    PrevDragObject := FDragObject;
    FDragObject := Value;
    if (FDragObject = nil) and (PrevDragObject <> nil) then
      PrevDragObject.HideDragImage;
    if FocusedNode <> nil then
      InvalidateRect(GetRectNode(FocusedNode));
    UpdateDragging;
    if (FDragObject = nil) and (PrevDragObject <> nil) then
      PrevDragObject.ShowDragImage;
    if FDragObject = nil then
      FDragExpandNode := nil;
  end;
end;

procedure TCustomdxTreeList.SetNewItemRowActive(Value: Boolean);
begin
  if IsNewItemRowVisible and (FNewItemRowActive <> Value) then
  begin
    FNewItemRowActive := Value;
    if FocusedNode <> nil then
      InvalidateRect(GetRectNode(FocusedNode));
    InvalidateNewItemRow;
  end;
end;

// Editor
procedure TCustomdxTreeList.HideEdit(ABackFocus: Boolean);
begin
  if (FInplaceEdit <> nil) then
    try
      FInplaceEdit.CloseFlag := True;
      if not (csDestroying in FInplaceEdit.ComponentState) then
        UpdateText;
    finally
      FInplaceColumn := -1;
      FInplaceNode := nil;
      FInplaceEdit.Hide;
      ABackFocus := ABackFocus or
        (FInplaceEdit.HandleAllocated and (GetFocus = FInplaceEdit.Handle));
      if ABackFocus and Self.HandleAllocated and IsWindowVisible(Self.Handle) and
        not FCanceling then
        Windows.SetFocus(Self.Handle);
    end;
end;

procedure TCustomdxTreeList.UpdateText;
var
  PrevInplaceNode: TdxTreeListNode;
begin
  if (FInplaceColumn <> -1) and (FInplaceNode <> nil) and (FInplaceEdit <> nil) then
  begin
    PrevInplaceNode := FInplaceNode; 
    if FInplaceEdit.Modified then
      AssignEditValue(FInplaceNode, FInplaceColumn, FInplaceEdit);
    // TODO: FInplaceNode OnDelete notification
    DoAfterEditing(PrevInplaceNode);
  end;
end;

procedure TCustomdxTreeList.UpdateEdit(Activate: Boolean);
var
  EditRect: TRect;

  procedure UpdateEditor;
  begin
    FInplaceColumn := 0;
    FInplaceNode := FocusedNode;
    if FocusedColumn <> -1 then
      FInplaceColumn := FocusedColumn;
    FInplaceColumnIndex := FInplaceColumn;
    FInplaceEdit.Parent := Self;
    if FInplaceNode <> nil then
    begin
      BeginInitEdit;
      try
        InitEditProperties(FInplaceEdit);
        InitEditValue(FInplaceNode, FInplaceEdit);
        with TdxInplaceTreeListEdit(FInplaceEdit) do
        begin
          Modified := False;
          if Self.GetReadOnly then ReadOnly := True;
          SetActive(True);
        end;
        // TODO InitEvents -> OnChange, ...
        // TODO Event
      finally
        EndInitEdit;
      end;
    end;
  end;

begin
  if CanEditShow then
  begin
    FInplaceEdit := FindInplaceEdit(FocusedColumn);
    if FInplaceEdit = nil then
    begin
      FInplaceEdit := CreateEditor(FocusedColumn);
      UpdateEditor;
    end
    else
    begin
      if (FocusedColumn <> FInplaceColumn) or (FocusedNode <> FInplaceNode) then
      begin
        HideEdit(False);
        SetState(tsEditing);
        UpdateEditor;
      end;
    end;
    EditRect := GetEditRect(FocusedNode, FocusedColumn);
    if CanEditShow then
    begin
      if not Activate then FInplaceEdit.LockActivate;
      try
        FInplaceEdit.Move(EditRect);
      finally
        if not Activate then FInplaceEdit.UnLockActivate;
      end;
    end
    else
    begin
      FInplaceColumn := -1;
      FInplaceNode := nil;
    end;
  end;
end;

procedure TCustomdxTreeList.ShowStatusCloseButtonHint(AImmediately: Boolean);
var
  P: TPoint;
  R: TRect;
begin
  HideStatusCloseButtonHint;
  if AImmediately then
  begin
    GetCursorPos(P);
    P := ScreenToClient(P);
    R := GetStatusCloseButtonRect;
    P := Point(R.Right + 4, R.Top - FTextHeight);
    P := ClientToScreen(P);
    if FHintWindow = nil then
      FHintWindow := TdxContainerHintWindow.Create(nil);
    FHintWindow.ActivateHint(P, GetStatusCloseButtonHint, Self.Font);
    FHideHintTimerId := SetTimer(Handle, HideHintTimerId, WaitForHideHintTime, nil);
  end
  else
  begin
    FShowHintTimerId := SetTimer(Handle, ShowHintTimerId, WaitForShowHintTime, nil);
  end;
end;

procedure TCustomdxTreeList.HideStatusCloseButtonHint;
begin
  if FShowHintTimerId <> 0 then
  begin
    KillTimer(Handle, FShowHintTimerId);
    FShowHintTimerId := 0;
  end;
  if FHideHintTimerId <> 0 then
  begin
    KillTimer(Handle, FHideHintTimerId);
    FHideHintTimerId := 0;
  end;
  if FHintWindow <> nil then
  begin
    FHintWindow.Free;
    FHintWindow := nil;
  end;
end;

// Messages
procedure TCustomdxTreeList.WMCancelMode(var Msg: TMessage);
begin
  CancelDragSizing;
  inherited;
end;

procedure TCustomdxTreeList.WMDestroy(var Msg: TWMDestroy);
begin
  HideStatusCloseButtonHint;
  inherited;
end;

procedure TCustomdxTreeList.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TCustomdxTreeList.WMGetDlgCode(var Msg: TWMGetDlgCode);
begin
  Msg.Result := DLGC_WANTARROWS;
  if IsEditing or FSearching or (IsAutoSearch and (GetAsyncKeyState(VK_MENU) >= 0)) then
    Msg.Result := Msg.Result or DLGC_WANTCHARS;
  if IsRowSelect and not IsTabs then Exit;
  if IsTabs {and (GetAsyncKeyState(VK_CONTROL) >= 0) }then Msg.Result := Msg.Result or DLGC_WANTTAB;
end;

procedure TCustomdxTreeList.WMHScroll(var Message: TWMHScroll);
var
  SI: TScrollInfo;
begin
  if not AcquireFocus or (GetVisibleHeaderCount = 0) then Exit;
  with Message do
    case ScrollCode of
      SB_LINEUP: LeftCoord := LeftCoord - FDeltaHScroll;
      SB_LINEDOWN: LeftCoord := LeftCoord + FDeltaHScroll;
      SB_PAGEUP: LeftCoord := LeftCoord - GetScrollableWidth;
      SB_PAGEDOWN: LeftCoord := LeftCoord + GetScrollableWidth;
      SB_THUMBTRACK,
      SB_THUMBPOSITION:
        begin
            SI.cbSize := SizeOf(SI);
            SI.fMask := SIF_ALL;
            GetScrollInfo(SB_HORZ, SI);
            if SI.nTrackPos <= 0 then LeftCoord := 0
            else if SI.nTrackPos >= GetScrollableBandWidth then LeftCoord := GetScrollableBandWidth
            else
            begin
              if (SI.nTrackPos + 1 + GetScrollableWidth) >= GetScrollableBandWidth then
                LeftCoord := (SI.nTrackPos + 1)
              else LeftCoord := ((SI.nTrackPos + 1) div 4) * 4;
            end;
        end;
      SB_BOTTOM: LeftCoord := GetScrollableBandWidth;
      SB_TOP: LeftCoord := 0;
    end;
end;

procedure TCustomdxTreeList.WMIMEStartComp(var Message: TMessage);
begin
  inherited;
  ShowEditor;
end;

procedure TCustomdxTreeList.WMKillFocus(var Msg: TWMKillFocus);
begin
  inherited;
  if (FInplaceEdit <> nil) and (Msg.FocusedWnd = FInplaceEdit.Handle)
    then Exit;

  InvalidateRect(GetRectNode(FocusedNode));
  if (FInplaceEdit <> nil) and (Msg.FocusedWnd <> FInplaceEdit.Handle)
    then HideEditor;
  {Redraw Selection}
  if IsMultiSelect and (SelectedCount > 0) then
    InvalidateSelection;
  // invalidate new item row
  if IsNewItemRowVisible then
    InvalidateNewItemRow;
  if State = tsNodeDown then SetState(tsNormal); //after Abort
end;

procedure TCustomdxTreeList.WMLButtonDown(var Message: TWMLButtonDown);
begin
  FreeClickTimer;
  inherited;
  if FInplaceEdit <> nil then FInplaceEdit.FClickTime := GetMessageTime;
end;

procedure TCustomdxTreeList.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  if (BorderStyle <> bsNone) and (LookAndFeel <> lfStandard) then
    InflateRect(Message.CalcSize_Params.rgrc[0], -1, -1);
  inherited;
end;

procedure TCustomdxTreeList.WMNCHitTest(var Msg: TWMNCHitTest);
begin
  DefaultHandler(Msg);
  FHitTest := SmallPointToPoint(Msg.Pos);
end;

procedure TCustomdxTreeList.WMNCPaint(var Message: TMessage);
var
  R: TRect;
  DC: HDC;
  H, W: Integer;
  AStyle: LongInt;
begin
  inherited;
  if (LookAndFeel = lfStandard) or (BorderStyle = bsNone) then Exit;
  GetWindowRect(Handle, R);
  OffsetRect(R, -R.Left, -R.Top);
  DC := GetWindowDC(Handle);
  if LookAndFeel = lfUltraFlat then
    FrameRect(DC, R, GetSysColorBrush(COLOR_BTNSHADOW)) // TODO
  else
    DrawEdge(DC, R, BDR_SUNKENOUTER, BF_RECT);
  AStyle := GetWindowLong(Handle, GWL_STYLE);
  if (AStyle and WS_HSCROLL <> 0) and (AStyle and WS_VSCROLL <> 0) then
  begin
    W := GetSystemMetrics(SM_CXVSCROLL);
    H := GetSystemMetrics(SM_CYHSCROLL);
    InflateRect(R, -1, -1);
    with R do
      R := Rect(Right-W, Bottom-H, Right, Bottom);
    FillRect(DC, R, GetSysColorBrush(COLOR_BTNFACE));
  end;
  ReleaseDC(Handle, DC);
end;

procedure TCustomdxTreeList.WMSetCursor(var Msg: TWMSetCursor);
var
  hInfo: TdxTreeListHitInfo;
  State: TdxTreeListState;
  Cur: HCURSOR;
begin
  Cur := 0;
  with Msg do begin
    if HitTest = HTCLIENT then
    begin
      State := tsNormal;
      if FState in [tsNormal, tsEditing] then
      begin
        FHitTest := ScreenToClient(FHitTest);
        hInfo := GetHitInfo(FHitTest);
        {Band}
        if (hInfo.hitType = htBandEdge) and (hInfo.Band <> -1) then
          State := tsColumnSizing;
        {Column}
        if (hInfo.hitType = htColumnEdge) then
          State := tsColumnSizing;
        {Row}
        if (hInfo.hitType in [htBandPanelEdge, htHeaderPanelEdge, htRowEdge]) then
          State := tsRowSizing;
      end
      else
        State := FState;
      if (State in [tsColumnSizing, tsBandSizing]) then
        Cur := Screen.Cursors[crHSplit];
      if (State in [tsBandPanelSizing, tsHeaderPanelSizing, tsRowSizing]) then
        Cur := Screen.Cursors[crVSplit];
    end;
  end;
  if Cur <> 0 then
    SetCursor(Cur)
  else inherited;
end;

procedure TCustomdxTreeList.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  if FocusedNode = Nil then FFocused := TopVisibleNode;
  if (Not IsRowSelect)
     and (FocusedColumn = -1) then FFocusedColumn := 0;
  if (FInplaceEdit = nil) or (Msg.FocusedWnd <> FInplaceEdit.Handle) then
  begin
    InvalidateRect(GetRectNode(FocusedNode));
    UpdateEdit(False);
  end;
  {Redraw Selection}
  if IsMultiSelect and (SelectedCount > 0) then
    InvalidateSelection;
  // invalidate new item row
  if IsNewItemRowVisible then
    InvalidateNewItemRow;
end;

procedure TCustomdxTreeList.WMSize(var Msg: TWMSize);
begin
  ClearNodeRowHeight;
  CloseEditor;
  CheckSize;
  inherited;
  UpdateScrollBars;
  UpdateTopLeftCoord;
//  if not (csLoading in ComponentState) then
//    MakeBoundsInfo; // new
end;

procedure TCustomdxTreeList.WMTimer(var Msg: TWMTimer);
var
  P: TPoint;
  FHitInfo: TdxTreeListHitInfo;
begin
  inherited;
  if (Msg.TimerId = ClickTimerID) then
  begin
    FreeClickTimer;
    if State = tsNormal then ShowEditor;
  end
  else
  if (Msg.TimerId = dxDragExapndTimerId) then
  begin
    if dxDragExapndTimerId <> 0 then
      KillTimer(Handle, dxDragExapndTimerId);
    FDragExpandTimerId := 0;
    GetCursorPos(P);
    P := ScreenToClient(P);
    FHitInfo := GetHitInfo(P);
    if FHitInfo.hitType in DragExpandHitTests then
    begin
      if (FHitInfo.Node <> nil) and (FHitInfo.Node = FDragExpandNode) then
      begin
        if IsDragCollapse then
        begin
          FHitInfo.Node.Expanded := not FHitInfo.Node.Expanded;
          FDragExpandTimerId := SetTimer(Handle, dxDragExapndTimerId, WaitForExpandNodeTime * 2, nil);
        end
        else
          FHitInfo.Node.Expanded := True;
      end;
    end;
  end
  else
  if (Msg.TimerId = HideHintTimerId) then // hint
    HideStatusCloseButtonHint
  else
  if (Msg.TimerId = ShowHintTimerId) then // show hint
    ShowStatusCloseButtonHint(True);
end;

procedure TCustomdxTreeList.WMVScroll(var Message: TWMVScroll);
var
  SI: TScrollInfo;
begin
  if not AcquireFocus then Exit;
    with Message do
      case ScrollCode of
        SB_LINEUP: TopIndex := TopIndex - 1 ;
        SB_LINEDOWN: TopIndex := TopIndex + 1;
        SB_PAGEUP: TopIndex := TopIndex - RowCount;
        SB_PAGEDOWN: TopIndex := TopIndex + RowCount;
        SB_THUMBTRACK,
        SB_THUMBPOSITION:
          begin
              SI.cbSize := sizeof(SI);
              SI.fMask := SIF_ALL;
              GetScrollInfo(SB_VERT, SI);
              if SI.nTrackPos <= 0 then TopIndex := 0
              else if SI.nTrackPos >= GetAbsoluteCount then TopIndex := GetAbsoluteCount
              else TopIndex := SI.nTrackPos;
          end;
        SB_BOTTOM: TopIndex := GetAbsoluteCount;
        SB_TOP: TopIndex := 0;
      end;
end;

type TWinControlCracker = class(TWinControl);

procedure TCustomdxTreeList.CMCancelMode(var Msg: TMessage);
begin
  CancelDragSizing;
  if Assigned(FInplaceEdit) then TWinControlCracker(FInplaceEdit).WndProc(Msg);
  inherited;
end;

procedure TCustomdxTreeList.CMColorChanged(var Message: TMessage);
begin
  inherited;
  LayoutChanged;
end;

procedure TCustomdxTreeList.CMCtl3DChanged(var Message: TMessage);
begin
  inherited;
  if (FBorderStyle = bsSingle) and (LookAndFeel = lfStandard) then RecreateWnd;
end;

procedure TCustomdxTreeList.CMDesignHitTest(var Msg: TCMDesignHitTest);
var
  HType: TdxTreeListHitTest;
begin
  Msg.Result := 0;
  HType := GetHitInfo(Point(Msg.Pos.X, Msg.Pos.Y)).hitType;
  if (HType in [htBandEdge, htColumnEdge, htBandPanelEdge, htHeaderPanelEdge, htRowEdge, htColumn, htBand])
    or (State in [tsColumnSizing, tsBandSizing, tsBandPanelSizing, tsHeaderPanelSizing,
    tsRowSizing, tsColumnDragging, tsBandDragging, tsColumnDown, tsBandDown]) then Msg.Result := 1;
end;

procedure TCustomdxTreeList.CMDrag(var Message: TCMDrag);
const
  DragCursors: array [Boolean, Boolean] of Integer =
    ((crDrag, crdxTreeListDragCopy), (crMultiDrag, crdxTreeListMultiDragCopy));
begin
  // check Cursor
  // TODO
  DragCursor := DragCursors[SelectedCount > 1,
    IsAutoDragCopy and (GetAsyncKeyState(VK_CONTROL) < 0)];
  inherited;
  if (State <> tsNodeDragging) and not Dragging then
  with Message, DragRec^ do
    case DragMessage of
      dmDragEnter: if Assigned(OnDragOver) then {if IsDragScroll then }SetDragObject(TDragObject(Source));
      dmDragLeave,
      dmDragDrop: SetDragObject(nil);
    end;
end;

procedure TCustomdxTreeList.CMFontChanged(var Message: TMessage);
begin
  inherited;
  LayoutChanged;
end;

procedure TCustomdxTreeList.CMMouseEnter(var Message: TMessage);
var
  AHitInfo: TdxTreeListHitInfo;
  P: TPoint;
begin
  inherited;
  GetCursorPos(P);
  P := ScreenToClient(P);
  AHitInfo := GetHitInfo(P);
  CheckHotTrackNode(AHitInfo);
  // TODO Event
end;

procedure TCustomdxTreeList.CMMouseLeave(var Message: TMessage);
var
  AHitInfo: TdxTreeListHitInfo;
begin
  inherited;
  AHitInfo.hitType := htNowhere;
  AHitInfo.Node := nil;
  CheckHotTrackNode(AHitInfo);
  // Hide Hints
  HideStatusCloseButtonHint;
  // TODO Event
end;

procedure TCustomdxTreeList.CMParentFontChanged(var Message: TMessage);
begin
  inherited;
  if ParentFont then
  begin
    FSelfChangingTitleFont := True;
    try
      BandFont := Font;
      HeaderFont := Font;
      FPreviewFont.Name := Font.Name;
      FPreviewFont.Size := Font.Size;
      FPreviewFont.Style := Font.Style;
      FPreviewFont.Color := clBlue;
    finally
      FSelfChangingTitleFont := False;
    end;
    LayoutChanged;
  end;
end;

procedure TCustomdxTreeList.CMSysColorChange(var Message: TMessage);
begin
  inherited;
  LoadButtonFaces;
end;

{TdxCustomizingListBox}
constructor TdxCustomizingListBox.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  Style := lbOwnerDrawFixed;
  FDragFlag := False;
  FDragItemIndex := -1;
end;

// protected TdxCustomizingListBox
procedure TdxCustomizingListBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    if FFlat then
    begin
      Style := Style and not WS_BORDER;
      ExStyle := ExStyle and not WS_EX_CLIENTEDGE;
    end;
  end;
end;

procedure TdxCustomizingListBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  DrawItem_(Canvas, Index, Rect, {odFocused}(odSelected in State) and
    (GetParentForm(Self) <> nil) and GetParentForm(Self).Active);
end;

procedure TdxCustomizingListBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    DoCancelDragging;
  inherited KeyDown(Key, Shift);
end;

procedure TdxCustomizingListBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button in [mbMiddle, mbRight] then DoCancelDragging;
  if (Button = mbLeft) and (Items.Count > 0) and (ItemIndex > -1) and
    (ItemAtPos(Point(X, Y), False) = ItemIndex) and (TreeList <> nil) and IsWindowVisible(TreeList.Handle) and
    not (ssDouble in Shift) then
  begin
    FPointDragging.X := X;
    FPointDragging.Y := Y;
    FDragFlag := True;
    FDragItemIndex := ItemIndex;
  end;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TdxCustomizingListBox.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if (FDragFlag) and (FDragItemIndex <> -1) then
    if ((X < FPointDragging.X - 3) or (X > FPointDragging.X + 3) or
      (Y < FPointDragging.Y - 3) or (Y > FPointDragging.Y + 3)) then
    begin
      FDragFlag := False;
      BeginDragging(FDragItemIndex);
    end;
  inherited MouseMove(Shift, X, Y);
end;

procedure TdxCustomizingListBox.BeginDragging(DragIndex: Integer);
begin
end;

procedure TdxCustomizingListBox.DoCancelDragging;
begin
  if (TreeList <> nil) then
  begin
    DoEndDragging(False);
    FDragFlag := False;
    FDragItemIndex := -1;
  end;
end;

procedure TdxCustomizingListBox.DoDragging;
begin
end;

procedure TdxCustomizingListBox.DoEndDragging(Flag: Boolean);
begin
end;

procedure TdxCustomizingListBox.LoadItems(List: TStrings);
begin
end;

procedure TdxCustomizingListBox.UpdateItems;
var
  PrevItemIndex, PrevTopIndex: Integer;
begin
  PrevTopIndex := TopIndex;
  PrevItemIndex := ItemIndex;
  Items.BeginUpdate;
  try
    Items.Clear;
    LoadItems(Items);
    if (PrevItemIndex > -1) and (Items.Count > 0) then
    begin
      if (PrevItemIndex >= Items.Count) then
         PrevItemIndex := Items.Count - 1;
      TopIndex := PrevTopIndex;
      ItemIndex := PrevItemIndex;
    end;
  finally
    Items.EndUpdate;
  end;
end;

// protected TdxCustomizingListBox
procedure TdxCustomizingListBox.DrawItem_(ACanvas: TCanvas; Index: Integer; Rect: TRect; Focused: Boolean);
begin
  if (Index < Items.Count) and (TreeList <> nil) then
  with ACanvas do
  begin
    DrawBand(Handle, Rect, Brush.Handle, Items[Index], False{ADown}, FMultiLine,
      taLeftJustify, csNone{no sorted}, nil {no glyph}, hbNormal, TreeList.LookAndFeel, []);
    {Draw FocusRect}
    if Focused then
    begin
      if TreeList.LookAndFeel <> lfStandard then // TODO 
        InvertRect(Handle, Rect)
      else
      begin
        InflateRect(Rect, -2, -2);
        DrawFocusRect(Rect);
      end;
    end;
  end;
end;

procedure TdxCustomizingListBox.SetFlat(Value: Boolean);
begin
  if FFlat <> Value then
  begin
    FFlat := Value;
    RecreateWnd;
  end;
end;

procedure TdxCustomizingListBox.SetTreeList(Value: TCustomdxTreeList);
begin
  if (FTreeList <> Value) then
  begin
    FTreeList := Value;
    UpdateItems;
  end;
end;

procedure TdxCustomizingListBox.WMCaptureChanged(var Msg: TMessage);
begin
  DoCancelDragging;
  inherited;
end;

procedure TdxCustomizingListBox.WMLButtonUp(var Message : TMessage);
begin
  DoEndDragging(True);
  FDragFlag := False;
  FDragItemIndex := -1;
  inherited;
end;

procedure TdxCustomizingListBox.WMMouseMove(var Message: TMessage);
begin
  if (TreeList = nil) or not (TreeList.State in [tsBandDragging, tsColumnDragging]) then
    inherited
  else
    DoDragging;
end;

procedure TdxCustomizingListBox.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  if (BorderStyle <> bsNone) and Flat then
    InflateRect(Message.CalcSize_Params.rgrc[0], -1, -1);
  inherited;
end;

procedure TdxCustomizingListBox.WMNCPaint(var Message: TMessage);
var
  R: TRect;
  DC: HDC;
begin
  inherited;
  if not Flat or (BorderStyle = bsNone) then Exit;
  GetWindowRect(Handle, R);
  OffsetRect(R, -R.Left, -R.Top);
  DC := GetWindowDC(Handle);
  DrawEdge(DC, R, BDR_SUNKENOUTER, BF_RECT);
  ReleaseDC(Handle, DC);
end;

procedure TdxCustomizingListBox.CNDrawItem(var Message: TWMDrawItem);
var
  State: TOwnerDrawState;
begin
  with Message.DrawItemStruct^ do
  begin
    {$IFDEF DELPHI5}
    State := TOwnerDrawState(LongRec(itemState).Lo);
    {$ELSE}
    State := TOwnerDrawState(WordRec(LongRec(itemState).Lo).Lo);
    {$ENDIF}
    Canvas.Handle := hDC;
    Canvas.Font := Font;
    Canvas.Brush := Brush;
    if Integer(itemID) >= 0 then
      DrawItem(itemID, rcItem, State)
    else Canvas.FillRect(rcItem);
    Canvas.Handle := 0;
  end;
end;

{TdxBandsListBox}
procedure TdxBandsListBox.BeginDragging(DragIndex: Integer);
begin
  if (TreeList <> nil) and (TreeList.ShowBands) then
  with TreeList do
  begin
    FDragAbsoluteBandIndex := Integer(Self.Items.Objects[DragIndex]);
    StartDragBand(FDragAbsoluteBandIndex);
  end;
end;

procedure TdxBandsListBox.DoDragging;
begin
  if TreeList <> nil then
    TreeList.DoBandDragging;
end;

procedure TdxBandsListBox.DoEndDragging(Flag: Boolean);
begin
  if (TreeList <> nil) and (TreeList.State = tsBandDragging) then
    TreeList.EndDragBand(Flag);
end;

procedure TdxBandsListBox.LoadItems(List: TStrings);
var
  i: Integer;
begin
  if (TreeList <> nil) then
  with TreeList do
  begin
    for i := 0 to GetAbsoluteBandCount - 1 do
    begin
      if IsBandInListBox(I) then
        Self.Items.AddObject(GetAbsoluteBandText(I), Pointer(I));
    end;
  end;
end;

procedure TdxBandsListBox.UpdateItems;
begin
  ItemHeight := FTreeList.FBandHeight;
  FMultiLine := FTreeList.FBandRowCount > 1; 
  inherited UpdateItems;
end;

{TdxHeadersListBox}
procedure TdxHeadersListBox.BeginDragging(DragIndex: Integer);
begin
  if (TreeList <> nil) and (TreeList.ShowHeader) then
  with TreeList do
  begin
    FDragAbsoluteHeaderIndex := Integer(Self.Items.Objects[DragIndex]);
    if not CanHeaderDragging(FDragAbsoluteHeaderIndex) then
      FDragAbsoluteHeaderIndex := -1
    else
      StartDragHeader(FDragAbsoluteHeaderIndex);
  end;
end;

procedure TdxHeadersListBox.DoDragging;
begin
  if TreeList <> nil then
    TreeList.DoHeaderDragging;
end;

procedure TdxHeadersListBox.DoEndDragging(Flag: Boolean);
begin
  if (TreeList <> nil) and (TreeList.State = tsColumnDragging) then
    TreeList.EndDragHeader(Flag);
end;

procedure TdxHeadersListBox.LoadItems(List: TStrings);
var
  I: Integer;
begin
  if (TreeList <> nil) then
  with TreeList do
  begin
    for I := 0 to GetHeaderAbsoluteCount - 1 do
    begin
      if IsHeaderInListBox(I) then
        Self.Items.AddObject(GetHeaderTextListBox(I), Pointer(I));
    end;
  end;
end;

procedure TdxHeadersListBox.UpdateItems;
begin
  ItemHeight := FTreeList.FHeaderRowHeight;
  FMultiLine := TreeList.GetHeaderLineRowCount > 1;
  inherited UpdateItems;
end;

{TdxTreeListTextNode}
constructor TdxTreeListTextNode.Create(AOwner: TCustomdxTreeList);
begin
  inherited Create(AOwner);
  FSelectedIndex := -1;
  FStateIndex := -1;
  FStrings := TStringList.Create;
end;

destructor TdxTreeListTextNode.Destroy;
begin
  FStrings.Free;
  inherited Destroy;
end;

procedure TdxTreeListTextNode.ReadData(Stream: TStream);
var
  B: Byte;
  I, L, Size, ItemCount: Integer;
  Info: PdxTextNodeInfo;
  S: string;
begin
  Stream.ReadBuffer(Size, SizeOf(Size));
  GetMem(Info, Size);
  try
    Stream.ReadBuffer(Info^, Size);
    ImageIndex := Info^.ImageIndex;
    SelectedIndex := Info^.SelectedIndex;
    StateIndex := Info^.StateIndex;
    Data := Info^.Data;
    ItemCount := Info^.Count;
    for I := 0 to Info^.StrCount - 1 do
    begin
      if TdxTreeList(FOwner).FStreamVersion <> 0 then // new format (huge string) 
      begin
        Stream.ReadBuffer(L, SizeOf(L));
      end
      else
      begin
        Stream.ReadBuffer(B, SizeOf(B));
        L := B;
      end;
      SetLength(S, L);
      Stream.ReadBuffer(S[1], L);
      Strings[I] := S;
    end;
  finally
    FreeMem(Info, Size);
  end;
  for I := 0 to ItemCount - 1 do
      with TdxTreeListTextNode(AddChild) do ReadData(Stream);
end;

procedure TdxTreeListTextNode.WriteData(Stream: TStream);
var
  I, Size, L, ItemCount: Integer;
  Info: PdxTextNodeInfo;
  S: string;
begin
  Size := SizeOf(TdxTextNodeInfo);
  GetMem(Info, Size);
  try
    Info^.ImageIndex := ImageIndex;
    Info^.SelectedIndex := SelectedIndex;
    Info^.StateIndex := StateIndex;
    Info^.Data := Data;
    ItemCount := Count;
    Info^.Count := ItemCount;
    Info^.StrCount := FStrings.Count;
    Stream.WriteBuffer(Size, SizeOf(Size));
    Stream.WriteBuffer(Info^, Size);
    for I := 0 to Info^.StrCount - 1 do
    begin
      S := FStrings[I];
      L := Length(S);
      // new format (huge string)
      Stream.WriteBuffer(L, SizeOf(L));
      Stream.WriteBuffer(S[1], L);
    end;
  finally
    FreeMem(Info, Size);
  end;
  for I := 0 to ItemCount - 1 do
    TdxTreeListTextNode(Items[I]).WriteData(Stream);
end;

{TdxTreeListBand}
constructor TdxTreeListBand.Create(Collection: TCollection);
begin
  FAlignment := taCenter;
  FMinWidth := dxGridBandMinWidth;
  FSizing := True;
  FVisible := True;
  FWidth := dxGridBandDefaultWidth;
  inherited Create(Collection);
end;

destructor TdxTreeListBand.Destroy;
var
  TreeList: TCustomdxTreeListControl;
  I, J: Integer;
begin
  // remove headers
  TreeList := GetdxTreeListControl;
  if (TreeList <> nil) and not (csDestroying in TreeList.ComponentState) and
    not (csUpdating in TreeList.ComponentState) and
    not ((csInheritable in TreeLIst.ComponentStyle) and (csLoading in TreeList.ComponentState)) then
  with TreeList do
  begin
    J := Self.Index;
    for I := 0 to ColumnCount - 1 do
    begin
      if Columns[I].FBandIndex = J then
        Columns[I].FBandIndex := -1
      else
      if Columns[I].FBandIndex > J then
        Dec(Columns[I].FBandIndex);
    end;
  end;
  inherited Destroy;
end;

procedure TdxTreeListBand.Assign(Source: TPersistent);
begin
  if Source is TdxTreeListBand then
  begin
    if Assigned(Collection) then Collection.BeginUpdate;
    try
      RestoreDefaults;
      Alignment := TdxTreeListBand(Source).Alignment;
      Caption := TdxTreeListBand(Source).Caption;
      Fixed := TdxTreeListBand(Source).Fixed;
      MinWidth := TdxTreeListBand(Source).MinWidth;
      OnlyOwnColumns := TdxTreeListBand(Source).OnlyOwnColumns;
      Sizing := TdxTreeListBand(Source).Sizing;
      Visible := TdxTreeListBand(Source).Visible;
      Width := TdxTreeListBand(Source).Width;
    finally
      if Assigned(Collection) then Collection.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TdxTreeListBand.RestoreDefaults;
begin
  FAlignment := taCenter;
  FFixed := bfNone;
  FMinWidth := dxGridBandMinWidth;
  FOnlyOwnColumns := False;
  FSizing := True;
  FWidth := dxGridBandDefaultWidth;
end;

// protected TdxTreeListBand
function TdxTreeListBand.GetdxTreeListControl: TCustomdxTreeListControl;
begin
  if Assigned(Collection) and (Collection is TdxTreeListBands) then
    Result := TdxTreeListBands(Collection).TreeList
  else Result := nil;
end;

procedure TdxTreeListBand.SetIndex(Value: Integer);

   procedure SetHeaderIndexes(CurBandIndex, NewBandIndex: Integer);
   var
     TreeList: TCustomdxTreeListControl;
     I: Integer;
   begin
     TreeList := GetdxTreeListControl;
     if TreeList <> nil then
     with TreeList do
     begin
       for I := 0 to ColumnCount - 1 do
         if Columns[I].FBandIndex = CurBandIndex then
           Columns[I].FBandIndex := NewBandIndex;
     end;
   end;

var
  FromIndex, ToIndex, I: Integer;
begin
  if Value < 0 then Value := 0;
  if Value >= Collection.Count then Value := Collection.Count - 1;
  if (Fixed = bfNone) and (Index <> Value) then
  begin
    FromIndex := Self.Index;
    ToIndex := Value;
    SetHeaderIndexes(FromIndex, dxGridHeaderTempIndex);
    if ToIndex < FromIndex then
    begin
      for I := FromIndex - 1 downto ToIndex do
        SetHeaderIndexes(I, I + 1);
    end
    else
    begin
      for I := FromIndex + 1 to ToIndex do
        SetHeaderIndexes(I, I - 1);
    end;
    SetHeaderIndexes(dxGridHeaderTempIndex, ToIndex);
    inherited SetIndex(Value);
  end;
end;

// private TdxTreeListBand
function TdxTreeListBand.GetHeaderColCount(RowIndex: Integer): Integer;
var
  TreeList: TCustomdxTreeListControl;
begin
  TreeList := GetdxTreeListControl;
  if TreeList <> nil then
    Result := TreeList.GetHeaderColCount(Self.VisibleIndex, RowIndex)
  else Result := 0;
end;

function TdxTreeListBand.GetHeaderColumn(RowIndex, ColIndex: Integer): TdxTreeListColumn;
var
  TreeList: TCustomdxTreeListControl;
  I: Integer;
begin
  TreeList := GetdxTreeListControl;
  Result := nil;
  if TreeList <> nil then
  begin
    I := TreeList.GetHeaderAbsoluteIndex(Self.VisibleIndex, RowIndex, ColIndex);
    if I <> -1 then
      Result := TreeList.Columns[I];
  end;
end;

function TdxTreeListBand.GetHeaderRowCount: Integer;
var
  TreeList: TCustomdxTreeListControl;
begin
  TreeList := GetdxTreeListControl;
  if TreeList <> nil then
    Result := TreeList.GetHeaderRowCount(Self.VisibleIndex)
  else Result := 0;
end;

function TdxTreeListBand.GetVisibleIndex: Integer;
begin
  Result := TdxTreeListBands(Collection).GetVisibleIndex(Self.Index);
end;

procedure TdxTreeListBand.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    Changed(False);
  end;
end;

procedure TdxTreeListBand.SetCaption(const Value: string);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    Changed(False);
  end;
end;

procedure TdxTreeListBand.SetDisableCustomizing(Value: Boolean);
begin
  if FDisableCustomizing <> Value then
  begin
    FDisableCustomizing := Value;
    Changed(False);
  end;
end;

procedure TdxTreeListBand.SetFixed(Value: TdxGridBandFixed);
var
  i: Integer;
begin
  if FFixed <> Value then
  begin
    // clear fixed
    FFixed := bfNone;
    if (Value <> bfNone) and Assigned(Collection) and (Collection is TdxTreeListBands) then
      with Collection as TdxTreeListBands do
      begin
        for i := 0 to Count - 1 do
          if TdxTreeListBand(Items[i]).Fixed = Value then
            TdxTreeListBand(Items[i]).FFixed := bfNone;
        // set idnex
        case Value of
          bfLeft: Index := 0;
          bfRight: Index := Count - 1;
        end;
      end;
    if Visible then
      FFixed := Value;
    Changed(False);
  end;
end;

procedure TdxTreeListBand.SetMinWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  FMinWidth := Value;
  SetWidth(FWidth);
end;

procedure TdxTreeListBand.SetSizing(Value: Boolean);
begin
  if FSizing <> Value then
  begin
    FSizing := Value;
    Changed(False);
  end;
end;

procedure TdxTreeListBand.SetVisible(Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    if not FVisible then
      FFixed := bfNone;
    Changed(True);
  end;
end;

procedure TdxTreeListBand.SetWidth(Value: Integer);
var
  TreeList: TCustomdxTreeListControl;
begin
  if Value < FMinWidth then Value := FMinWidth;
  TreeList := GetdxTreeListControl;
  if (FWidth <> Value) or (Assigned(TreeList) and TreeList.IsBandHeaderWidth) then
  begin
    FWidth := Value;
    Changed(True);
  end;
end;

{TdxTreeListBands}
constructor TdxTreeListBands.Create(ATreeList: TCustomdxTreeListControl; BandClass: TdxTreeListBandClass);
begin
  inherited Create(BandClass);
  FTreeList := ATreeList;
end;

function TdxTreeListBands.Add: TdxTreeListBand;
begin
  Result := TdxTreeListBand(inherited Add);
end;

procedure TdxTreeListBands.RestoreDefaults;
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := 0 to Count-1 do
      Items[I].RestoreDefaults;
  finally
    EndUpdate;
  end;
end;

function TdxTreeListBands.GetAbsoluteIndex(VisibleIndex: Integer): Integer;
var
  i, j: Integer;
begin
  Result := -1;
  // speed
  if (TreeList <> nil) and not TreeList.FBandListLoading and
    (TreeList.FBandList.Count > 0) then
  begin
    if VisibleIndex < TreeList.FBandList.Count then
      Result := Integer(TreeList.FBandList[VisibleIndex]);
    Exit;
  end;
  j := -1;
  for i := 0 to Count - 1 do
  begin
    if TdxTreeListBand(Items[i]).Visible then Inc(j);
    if j = VisibleIndex then
    begin
      Result := i;
      Break;
    end;
  end;
end;

function TdxTreeListBands.GetVisibleIndex(AbsoluteIndex: Integer): Integer;
var
  i: Integer;
begin
  Result := -1;
  // speed
  if (TreeList <> nil) and not TreeList.FBandListLoading and
    (TreeList.FBandVisibleList.Count > 0) then
  begin
    if AbsoluteIndex < TreeList.FBandVisibleList.Count then
      Result := Integer(TreeList.FBandVisibleList[AbsoluteIndex]);
    Exit;
  end;
  if (AbsoluteIndex < Count) and (TdxTreeListBand(Items[AbsoluteIndex]).Visible) then
  begin
    for i := 0 to AbsoluteIndex do
      if TdxTreeListBand(Items[i]).Visible then Inc(Result);
  end;
end;

// protected TdxTreeListBands
function TdxTreeListBands.GetOwner: TPersistent;
begin
  Result := FTreeList;
end;

procedure TdxTreeListBands.RefreshFixedBands;
var
  LeftBand, RightBand: TdxTreeListBand;
  Flag: Boolean;
  i: Integer;
begin
  Flag := False;
  LeftBand := nil;
  RightBand := nil;
  for i := 0 to Count - 1 do
  begin
    case TdxTreeListBand(Items[i]).Fixed of
    bfLeft: begin
        if LeftBand = nil then
        begin
          LeftBand := TdxTreeListBand(Items[i]);
          if GetVisibleIndex(i) <> 0 then
            Flag := True;
        end
        else
          Flag := True;
      end;
    bfRight: begin
        if RightBand = nil then
        begin
          RightBand := TdxTreeListBand(Items[i]);
          if GetVisibleIndex(i) <> VisibleCount - 1 then
            Flag := True;
        end
        else
          Flag := True;
      end;
    end;
  end;
  if Flag then
  begin
    // clear fixed
    for i := 0 to Count - 1 do
      TdxTreeListBand(Items[i]).FFixed := bfNone;
    // reorder bands
    BeginUpdate;
    try
      if LeftBand <> nil then
        LeftBand.Fixed := bfLeft;
      if RightBand <> nil then
        RightBand.Fixed := bfRight;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TdxTreeListBands.Update(Item: TCollectionItem);
begin
  if FTreeList = nil then Exit;
  if FTreeList.Bands.Count <> 1 then FTreeList.FDefaultLayout := False;
  if csLoading in FTreeList.ComponentState then Exit;
  // recalculate fixed
  FTreeList.ClearListNodes;
  RefreshFixedBands;
  FTreeList.UpdateBands;
end;

// private
function TdxTreeListBands.GetItem(Index: Integer): TdxTreeListBand;
begin
  Result := TdxTreeListBand(inherited GetItem(Index));
end;

function TdxTreeListBands.GetVisibleCount: Integer;
var
  i : Integer;
begin
  Result := 0;
  // speed
  if (TreeList <> nil) and not TreeList.FBandListLoading and
    (TreeList.FBandList.Count > 0) then
  begin
    Result := Integer(TreeList.FBandList.Count);
    Exit;
  end;
  for i := 0 to Count - 1 do
    if TdxTreeListBand(Items[i]).Visible then Inc(Result);
end;

function TdxTreeListBands.GetVisibleItem(Index: Integer): TdxTreeListBand;
var
  i : Integer;
begin
  Result := nil;
  i := GetAbsoluteIndex(Index);
  if i <> -1 then Result := Items[i];
end;

procedure TdxTreeListBands.SetItem(Index: Integer; Value: TdxTreeListBand);
begin
  inherited SetItem(Index, Value);
end;

procedure TdxTreeListBands.SetVisibleItem(Index: Integer; Value: TdxTreeListBand);
var
  i :Integer;
begin
  i := GetAbsoluteIndex(Index);
  if i <> -1 then inherited SetItem(i, Value);
end;

{ TdxTreeListColumn }
constructor TdxTreeListColumn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMinWidth := dxGridHeaderMinWidth;
  FTabStop := True;
  FWidth := 100;
  FVisible := True;
  FSizing := True;
  FHeaderMaxLineCount := 1;
  FSortedOrder := -1;
  FViewData := GetdxInplaceEditClass.GetViewDataClass.Create;
  FActualIndex := -1;
end;

destructor TdxTreeListColumn.Destroy;
var
  I: Integer;
begin
  if FTreeList <> nil then
  begin
    if not (csDestroying in FTreeList.ComponentState) then
    begin
      // Delete in Strings
      for I := 0 to FTreeList.Count - 1 do
        FTreeList.DeleteStrings(FTreeList.Items[I], Self.Index);
      // Hidden
      for I := 0 to FTreeList.FHiddenList.Count - 1 do
        FTreeList.DeleteStrings(TdxTreeListNode(FTreeList.FHiddenList[I]), Self.Index);
    end;
    FTreeList.RemoveColumn(Self);
  end;
  if FFont <> nil then
  begin
    FFont.Free;
    FFont := nil;
  end;
  if FHeaderGlyph <> nil then
  begin
    FHeaderGlyph.Free;
    FHeaderGlyph := nil;
  end;
  FViewData.Free;
  inherited Destroy;
end;

procedure TdxTreeListColumn.Assign(Source: TPersistent);
begin
  if Source is TdxTreeListColumn then
  begin
    if Assigned(TreeList) then TreeList.BeginUpdate;
    try
      RestoreDefaults;
      if cvAlignment in TdxTreeListColumn(Source).AssignedValues then
        Alignment := TdxTreeListColumn(Source).Alignment;
      if cvCaption in TdxTreeListColumn(Source).AssignedValues then
        Caption := TdxTreeListColumn(Source).Caption;
      if cvReadOnly in TdxTreeListColumn(Source).AssignedValues then
        ReadOnly := TdxTreeListColumn(Source).ReadOnly;
      if cvWidth in TdxTreeListColumn(Source).AssignedValues then
        Width := TdxTreeListColumn(Source).Width;
      if cvColor in TdxTreeListColumn(Source).AssignedValues then
        Color := TdxTreeListColumn(Source).Color;
      if cvFont in TdxTreeListColumn(Source).AssignedValues then
        Font := TdxTreeListColumn(Source).Font;
      DisableCaption := TdxTreeListColumn(Source).DisableCaption;
      DisableCustomizing := TdxTreeListColumn(Source).DisableCustomizing;
      DisableEditor := TdxTreeListColumn(Source).DisableEditor;
      DisableFilter := TdxTreeListColumn(Source).DisableFilter;
      HeaderAlignment := TdxTreeListColumn(Source).HeaderAlignment;
      if TdxTreeListColumn(Source).FHeaderGlyph <> nil then
        HeaderGlyph := TdxTreeListColumn(Source).HeaderGlyph;
      MinWidth := TdxTreeListColumn(Source).MinWidth;
      Sizing := TdxTreeListColumn(Source).Sizing;
      Sorted := TdxTreeListColumn(Source).Sorted;
      VertAlignment := TdxTreeListColumn(Source).VertAlignment;
      Visible := TdxTreeListColumn(Source).Visible;
      TabStop := TdxTreeListColumn(Source).TabStop;
      // new indexes
      BandIndex := TdxTreeListColumn(Source).BandIndex;
      RowIndex := TdxTreeListColumn(Source).RowIndex;
      ColIndex := TdxTreeListColumn(Source).ColIndex;
      HeaderMaxLineCount := TdxTreeListColumn(Source).HeaderMaxLineCount;
    finally
      if Assigned(TreeList) then TreeList.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TdxTreeListColumn.ConvertExportValue(var Value: Variant; IsHTML: Boolean): Boolean;
begin
  Result := False;
end;

function TdxTreeListColumn.DefaultAlignment: TAlignment;
begin
  Result := taLeftJustify;
end;

function TdxTreeListColumn.DefaultCaption: string;
begin
  Result := '';
end;

function TdxTreeListColumn.DefaultColor: TColor;
begin
  if TreeList <> nil then
    Result := TreeList.Color
  else Result := clWindow;
end;

function TdxTreeListColumn.DefaultFont: TFont;
begin
  if TreeList <> nil then
    Result := TreeList.Font
  else Result := FFont;
end;

function TdxTreeListColumn.DefaultMaxLength: Integer;
begin
  Result := 0;
end;

function TdxTreeListColumn.DefaultReadOnly: Boolean;
begin
  Result := False;
end;

function TdxTreeListColumn.DefaultWidth: Integer;
begin
  Result := 100;
end;

function TdxTreeListColumn.GetBestFit(ACanvas: TCanvas; ANode: TdxTreeListNode): Integer;
var
  S: string;
begin
  S := ANode.Strings[Index];
  if CharCase <> ecNormal then
    S := ConvertTextCase(S, CharCase);
  Result := ACanvas.TextWidth(S);
end;

function TdxTreeListColumn.GetDisplayValue(Node: TdxTreeListNode; const Value: string): string;
begin
  Result := Value;
end;

function TdxTreeListColumn.GetParentComponent : TComponent;
begin
  Result := TreeList;
end;

function TdxTreeListColumn.HasParent: Boolean;
begin
  HasParent := True;
end;

procedure TdxTreeListColumn.RestoreDefaults;
begin
  FAssignedValues := [];
  RefreshDefaultFont;
  RefreshDefaultWidth;
  FDisableEditor := False;
  FDisableCaption := False;
  FDisableCustomizing := False;
  FHeaderAlignment := taLeftJustify;
  FMinWidth := dxGridHeaderMinWidth;
  FSizing := True;
  FSorted := csNone;
  FTabStop := True;
  FVertAlignment := tlTop;
end;

procedure TdxTreeListColumn.RestoreDefaultWidth;
begin
  FAssignedValues := FAssignedValues - [cvWidth];
  RefreshDefaultWidth;
end;

procedure TdxTreeListColumn.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('SortedOrder', ReadSortedOrder, WriteSortedOrder,
    (TreeList <> nil) and TreeList.IsMultiSort and (TreeList.SortedColumnCount > 1) and (Sorted <> csNone));
  Filer.DefineProperty('StoredRowIndex', ReadStoredRowIndex, WriteStoredRowIndex, FStoredRowIndex <> 0);
end;

procedure TdxTreeListColumn.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
  if Reader.Parent is TCustomdxTreeListControl then
    TreeList := TCustomdxTreeListControl(Reader.Parent);
end;

procedure TdxTreeListColumn.SetName(const Value: TComponentName);
begin
  inherited SetName(Value);
  if Assigned(FOnChangeName) then FOnChangeName(Self);
end;

procedure TdxTreeListColumn.SetParentComponent(AParent: TComponent);
begin
  if not (csLoading in ComponentState) then
    TreeList:= AParent as TCustomdxTreeListControl;
end;

function TdxTreeListColumn.AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant;
begin
  if AInplaceEdit is TdxInplaceTextEdit then
    ANode.Strings[Index] := TdxInplaceTreeListTextEdit(AInplaceEdit).Text;
  Result := ANode.Values[Index];  
end;

function TdxTreeListColumn.AssignedDrawCellEvent: Boolean;
begin
  Result := Assigned(FOnCustomDrawCell);
end;

procedure TdxTreeListColumn.Changed(AllItems: Boolean);
var
  Item: TdxTreeListColumn;
begin
  if (FTreeList <> nil) then
  begin
    if AllItems then Item := nil else Item := Self;
    FTreeList.UpdateColumn(Item);
  end;
end;

procedure TdxTreeListColumn.ChangedWidth(Value: Integer);
begin
  if Value < FMinWidth then Value := FMinWidth;
  FWidth := Value;
  Include(FAssignedValues, cvWidth);
end;

procedure TdxTreeListColumn.DoChange(Sender: TObject);
begin
  if (FTreeList <> nil) and not FTreeList.IsInitEdit then
  begin
    FTreeList.DoEditChange(Self);
    if Assigned(FOnChange) then FOnChange(Self);
  end;  
end;

procedure TdxTreeListColumn.DoDrawCell(ACanvas: TCanvas; var ARect: TRect; ANode: TdxTreeListNode;
  ASelected, AFocused: Boolean; ANewItemRow: Boolean; ALeftEdge, ARightEdge: Boolean; ABrush: HBRUSH;
  var AText: string; var AColor: TColor; AFont: TFont; var AAlignment: TAlignment; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawCell) then FOnCustomDrawCell(Self, ACanvas, ARect, ANode, Self,
    ASelected, AFocused, ANewItemRow, AText, AColor, AFont, AAlignment, ADone);
end;

procedure TdxTreeListColumn.DoValidate(Sender: TObject; var ErrorText: string; var Accept: Boolean);
begin
  // TODO State (Init Edit)
  if (FTreeList <> nil) and not FTreeList.IsInitEdit then
  begin
    FTreeList.DoEditValidate(Self, ErrorText, Accept);
    if Assigned(FOnValidate) then FOnValidate(Self, ErrorText, Accept);
  end;
end;

procedure TdxTreeListColumn.DrawColumnIndent(DC: HDC; var ARect: TRect;
  ALeftEdge, ARightEdge: Boolean; ABrush: HBRUSH);
begin
  with ARect do
  begin
    Windows.FillRect(DC, Rect(Left, Top, Right, Top + 1), ABrush);
    Windows.FillRect(DC, Rect(Left, Bottom - 1, Right, Bottom), ABrush);
    InflateRect(ARect, 0, -1);
    if ALeftEdge then
    begin
      Windows.FillRect(DC, Rect(Left, Top, Left + 1, Bottom), ABrush);
      Inc(ARect.Left, 1);
    end;
    if ARightEdge then
    begin
      Windows.FillRect(DC, Rect(Right - 1, Top, Right, Bottom), ABrush);
      Dec(ARect.Right, 1);
    end;
  end;
end;

procedure TdxTreeListColumn.FontChanged(Sender: TObject);
begin
  Include(FAssignedValues, cvFont);
  Changed(True);
end;

function TdxTreeListColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceTreeListTextEdit;
end;

function TdxTreeListColumn.GetDisplayText(ANode: TdxTreeListNode): string;
begin
  Result := ANode.Strings[Index];
end;

function TdxTreeListColumn.GetEnableEditor: Boolean;
begin
  Result := not FDisableEditor;
end;

procedure TdxTreeListColumn.GetHotTrackCursor(ANode: TdxTreeListNode; var ACursor: TCursor);
begin
end;

function TdxTreeListColumn.GetIndex: Integer;
begin
  if FActualIndex <> -1 then
    Result := FActualIndex
  else   
    if FTreeList <> nil then
      Result := FTreeList.FColumns.IndexOf(Self)
    else Result := -1;
end;

function TdxTreeListColumn.GetMaxRowHeight(ACanvas: TCanvas): Integer;
begin
  Result := 0;
end;

function TdxTreeListColumn.GetViewData: TdxEditViewData;
begin
  Result := FViewData; 
end;

procedure TdxTreeListColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  if AInplaceEdit is TdxInplaceEdit then
    with TdxInplaceTreeListEdit(AInplaceEdit) do
    begin
      ReadOnly := Self.ReadOnly;
      OnChange := Self.DoChange;
      OnValidate := Self.DoValidate;
    end;
  if AInplaceEdit is TdxInplaceTextEdit then
    with TdxInplaceTreeListTextEdit(AInplaceEdit) do
    begin
      CharCase := Self.CharCase;
      MaxLength := Self.MaxLength;
      OEMConvert := Self.OEMConvert;
      PasswordChar := Self.PasswordChar;
      if HandleAllocated then ClearUndo;
    end;
end;

function TdxTreeListColumn.InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant;
begin
  TdxInplaceTreeListEdit(AInplaceEdit).Text := ANode.Strings[Index];
  Result := TdxInplaceTreeListEdit(AInplaceEdit).Text;
end;

function TdxTreeListColumn.IsColumnHotTrack(X, Y: Integer; Node: TdxTreeListNode; var ActiveIndex: Integer): Boolean;
begin
  Result := False;
end;

function TdxTreeListColumn.IsHeaderHotTrack(X, Y: Integer; var HeaderHotTrack: TdxTreeListHeaderHotTrack): Boolean;
begin
  Result := not DisableFilter and not (csDesigning in ComponentState);
end;

function TdxTreeListColumn.IsColumnMultiLine: Boolean;
begin
  Result := False;
end;

function TdxTreeListColumn.NeedShowButtonEdit(X, Y: Integer; IsCurrentNode: Boolean): Boolean;
begin
  Result := False;
end;

procedure TdxTreeListColumn.PrepareViewData(AViewData: TdxEditViewData; ACellViewData: TdxTreeListCellViewData);
begin
  with AViewData do
  begin
    Enabled := True;
    Focused := False;
    Selected := ACellViewData.Cell_HotTrackNode;
    // Style
    BorderColor := clNone; //TreeList.EditStyleBorderColor;
    BorderStyle := xbsNone; //TreeList.EditStyleBorderStyle;
    ButtonStyle := TreeList.EditStyleButtonStyle;
//    if True {TODO Option} and not Selected then
//      ButtonStyle := btsSimple;
    ButtonTransparence := False; //TODO TreeList.EditStyleButtonTransparence;
    Edges := TreeList.EditStyleEdges;
    Shadow := TreeList.EditStyleShadow;
    Transparent := False; // TODO
    if ACellViewData.Cell_InvertText then
    begin
      Transparent := True;
      NoTransparentText := True;
    end;
    // ViewBounds
    OffsetSize := Rect(1, 0, 0, 0);
    ViewBounds := ACellViewData.Cell_Rect;
    // General
    if ACellViewData.Cell_MultiLine then
      DrawAlignment := daMultiLine
    else DrawAlignment := TdxDrawAlignment(VertAlignment); //daSinleLine;
    Font := ACellViewData.Cell_Font;
    Brush := ACellViewData.Cell_Brush;
    BkColor := ColorToRGB(ACellViewData.Cell_BkColor);
    TextColor := ColorToRGB(ACellViewData.Cell_TextColor);
    Alignment := ACellViewData.Cell_Alignment;
    IsEditClass := False; // TODO
    Data := ACellViewData.Cell_Text;
    DataLength := ACellViewData.Cell_TextLength;
    //LoadDisplayValue(Data, IsPaintCopy); // TODO
    CalcHeight := False;
  end;
  if AViewData is TdxTextEditViewData then
    with TdxTextEditViewData(AViewData) do
    begin
      CharCase := Self.CharCase;
      EndEllipsis := ACellViewData.Cell_DrawEndEllipsis;
      PasswordChar := Self.PasswordChar;
    end;
end;

procedure TdxTreeListColumn.RefreshDefaultFont;
var
  Save: TNotifyEvent;
begin
  if cvFont in FAssignedValues then Exit;
  if FFont <> nil then
  begin
    Save := FFont.OnChange;
    FFont.OnChange := nil;
    try
      FFont.Assign(DefaultFont);
    finally
      FFont.OnChange := Save;
    end;
  end;
end;

procedure TdxTreeListColumn.RefreshDefaultWidth;
begin
  if (cvWidth in FAssignedValues) then Exit;
  FWidth := DefaultWidth;
end;

procedure TdxTreeListColumn.SetIndex(Value: Integer);
var
  FromIndex, ToIndex: Integer;
  CurIndex: Integer;
begin
  CurIndex := GetIndex;
  if (CurIndex < 0) or (TreeList = nil) then Exit;
  if Value < 0 then Value := 0;
  if Value >= TreeList.FColumns.Count then
    Value := TreeList.FColumns.Count - 1;
  if CurIndex <> Value then
  begin
    FromIndex := Index;
    ToIndex := Value;
    with TreeList do
    begin
      TreeList.MoveNodeValues(FromIndex, ToIndex);
      FColumns.Delete(CurIndex);
      FColumns.Insert(Value, Self);
      Self.Changed(True);
    end;
  end;
end;

function TdxTreeListColumn.GetAlignment: TAlignment;
begin
  if cvAlignment in FAssignedValues then
    Result := FAlignment
  else Result := DefaultAlignment;
end;

function TdxTreeListColumn.GetCaption: string;
begin
  if cvCaption in FAssignedValues then
    Result := FCaption
  else Result := DefaultCaption;
end;

function TdxTreeListColumn.GetColor: TColor;
begin
  if cvColor in FAssignedValues then
    Result := FColor
  else Result := DefaultColor;
end;

function TdxTreeListColumn.GetFont: TFont;
var
  Save: TNotifyEvent;
begin
  if FFont = nil then
  begin
    FFont := TFont.Create;
    if DefaultFont <> nil then
      FFont.Assign(DefaultFont);
    FFont.OnChange := FontChanged;
  end
  else
  if not (cvFont in FAssignedValues) and (FFont.Handle <> DefaultFont.Handle) then
  begin
    Save := FFont.OnChange;
    FFont.OnChange := nil;
    FFont.Assign(DefaultFont);
    FFont.OnChange := Save;
  end;
  Result := FFont;
end;

function TdxTreeListColumn.GetHeaderGlyph: TBitmap;
begin
  if FHeaderGlyph = nil then
    FHeaderGlyph := TBitmap.Create;
  Result := FHeaderGlyph;
end;

function TdxTreeListColumn.GetMaxLength: Integer;
begin
  if cvMaxLength in FAssignedValues then
    Result := FMaxLength
  else
    Result := DefaultMaxLength;
end;

function TdxTreeListColumn.GetReadOnly: Boolean;
begin
  if cvReadOnly in FAssignedValues then
    Result := FReadOnly
  else Result := DefaultReadOnly;
  if not Result and (TreeList <> nil) then
    Result := TreeList.ReadOnly; {container property}
end;

function TdxTreeListColumn.GetVisible: Boolean;
begin
  Result := FVisible{and (BandIndex <> -1)};
end;

function TdxTreeListColumn.GetWidth: Integer;
begin
  Result := FWidth;
end;

function TdxTreeListColumn.IsAlignmentStored: Boolean;
begin
  Result := (cvAlignment in FAssignedValues){ and (FAlignment <> DefaultAlignment)};
end;

function TdxTreeListColumn.IsCaptionStored: Boolean;
begin
  Result := (cvCaption in FAssignedValues) and (FCaption <> DefaultCaption);
end;

function TdxTreeListColumn.IsColorStored: Boolean;
begin
  Result := (cvColor in FAssignedValues) and (FColor <> DefaultColor);
end;

function TdxTreeListColumn.IsFontStored: Boolean;
begin
  Result := (cvFont in FAssignedValues);
end;

function TdxTreeListColumn.IsMaxLengthStored: Boolean;
begin
  Result := (cvMaxLength in FAssignedValues) and (FMaxLength <> DefaultMaxLength);
end;

function TdxTreeListColumn.IsReadOnlyStored: Boolean;
begin
  Result := (cvReadOnly in FAssignedValues) and (FReadOnly <> DefaultReadOnly);
end;

function TdxTreeListColumn.IsWidthStored: Boolean;
begin
  Result := (cvWidth in FAssignedValues);
end;

procedure TdxTreeListColumn.SetAlignment(Value: TAlignment);
begin
  if (cvAlignment in FAssignedValues) and (Value = FAlignment) then Exit;
  FAlignment := Value;
  Include(FAssignedValues, cvAlignment);
  Changed(False);
end;

procedure TdxTreeListColumn.SetCaption(const Value: string);
begin
  if (cvCaption in FAssignedValues) and (Value = FCaption) then Exit;
  FCaption := Value;
  Include(FAssignedValues, cvCaption);
  RefreshDefaultWidth;
  Changed(False);
end;

procedure TdxTreeListColumn.SetCharCase(Value: TEditCharCase);
begin
  if FCharCase <> Value then
  begin
    FCharCase := Value;
    Changed(True);
  end;
end;

procedure TdxTreeListColumn.SetColor(Value: TColor);
begin
  if (cvColor in FAssignedValues) and (Value = FColor) then Exit;
  FColor := Value;
  Include(FAssignedValues, cvColor);
  Changed(False);
end;

procedure TdxTreeListColumn.SetDisableCaption(Value: Boolean);
begin
  if FDisableCaption <> Value then
  begin
    FDisableCaption := Value;
    Changed(True);
  end;
end;

procedure TdxTreeListColumn.SetDisableCustomizing(Value: Boolean);
begin
  if FDisableCustomizing <> Value then
  begin
    FDisableCustomizing := Value;
    Changed(True);
  end;
end;

procedure TdxTreeListColumn.SetDisableFilter(Value: Boolean);
begin
  if FDisableFilter <> Value then
  begin
    FDisableFilter := Value;
    Changed(True);
  end;
end;

procedure TdxTreeListColumn.SetFont(Value: TFont);
begin
  Font.Assign(Value);
  Include(FAssignedValues, cvFont);
  Changed(True);
end;

procedure TdxTreeListColumn.SetHeaderAlignment(Value: TAlignment);
begin
  if FHeaderAlignment <> Value then
  begin
    FHeaderAlignment := Value;
    Changed(True);
  end;
end;

procedure TdxTreeListColumn.SetHeaderGlyph(Value: TBitmap);
begin
  if (Value = nil) then
  begin
    FHeaderGlyph.Free;
    FHeaderGlyph := nil;
  end
  else
    HeaderGlyph.Assign(Value);
  Changed(True);
end;

procedure TdxTreeListColumn.SetMaxLength(Value: Integer);
begin
  if FMaxLength <> Value then
  begin
    FMaxLength := Value;
    Include(FAssignedValues, cvMaxLength);
    Changed(False);
  end;
end;

procedure TdxTreeListColumn.SetMinWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  FMinWidth := Value;
  SetWidth(FWidth);
end;

procedure TdxTreeListColumn.SetOEMConvert(Value: Boolean);
begin
  if FOEMConvert <> Value then
  begin
    FOEMConvert := Value;
    Changed(False);
  end;
end;

procedure TdxTreeListColumn.SetPasswordChar(Value: Char);
begin
  if FPasswordChar <> Value then
  begin
    FPasswordChar := Value;
    Changed(False);
  end;
end;

procedure TdxTreeListColumn.SetReadOnly(Value: Boolean);
begin
  if (cvReadOnly in FAssignedValues) and (Value = FReadOnly) then Exit;
  FReadOnly := Value;
  Include(FAssignedValues, cvReadOnly);
  Changed(False);
end;

procedure TdxTreeListColumn.SetSizing(Value: Boolean);
begin
  if FSizing <> Value then
  begin
    FSizing := Value;
    Changed(False);
  end;
end;

procedure TdxTreeListColumn.SetSorted(Value: TdxTreeListColumnSort);
begin
  if FSorted <> Value then
  begin
    if (TreeList <> nil) and not (csLoading in TreeList.ComponentState) then
    begin
      if (Value <> csNone) then
      begin
        TreeList.BeginUpdate;
        try
          TreeList.PrepareColumnSorted(Self);
          FSorted := Value;
          TreeList.SetColumnSorted(Self);
        finally
          TreeList.EndUpdate;
        end;
      end
      else
      begin
        TreeList.BeginSorting;
        try
          FSorted := Value;
//          TreeList.FSortedColumns.Remove(Self);
          TreeList.RemoveSortedColumn(Self);
          Changed(False);
        finally
          TreeList.EndSorting;
        end;
      end;
    end
    else
    begin
      FSorted := Value;
      Changed(False);
    end;
  end;
end;

procedure TdxTreeListColumn.SetVertAlignment(Value: TTextLayout);
begin
  if FVertAlignment <> Value then
  begin
    FVertAlignment := Value;
    Changed(False);
  end;
end;

procedure TdxTreeListColumn.SetVisible(Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed(False);
  end;
end;

procedure TdxTreeListColumn.SetWidth(Value: Integer);
begin
  if Value < FMinWidth then Value := FMinWidth;
//  else
//    if not (csLoading in ComponentState) and not Sizing then Exit;
  if (cvWidth in FAssignedValues) or (Value <> DefaultWidth) then
  begin
    FWidth := Value;
    Include(FAssignedValues, cvWidth);
    Changed(False);
  end;
end;

procedure TdxTreeListColumn.SetTreeList(TreeList: TCustomdxTreeListControl);
begin
  if FTreeList <> TreeList then
  begin
    if FTreeList <> nil then FTreeList.RemoveColumn(Self);
    if TreeList <> nil then TreeList.AddColumn(Self);
  end;
end;

function TdxTreeListColumn.GetBandIndex: Integer;
begin
  Result := FBandIndex;
end;

function TdxTreeListColumn.GetRowIndex: Integer;
begin
  if (TreeList <> nil) then
  begin
    Result := FStoredRowIndex;
    if Result >= TreeList.HeaderPanelRowCount then
      Result := TreeList.HeaderPanelRowCount - 1;
  end
  else
    Result := FRowIndex;
end;

function TdxTreeListColumn.GetColIndex: Integer;
var
  I: Integer;
  Column: TdxTreeListColumn;
begin
  Result := -1;
  if TreeList <> nil then
  with TreeList do
    for I := 0 to ColumnCount - 1 do
    begin
      Column := Columns[I];
      if Column.Visible and (Column.BandIndex = Self.BandIndex) and
        (Column.RowIndex = Self.RowIndex) then
      begin
        Inc(Result);
        if Column = Self then Break;
      end;
    end;
end;

function TdxTreeListColumn.GetHeaderMaxLineCount: Integer;
begin
  Result := FHeaderMaxLineCount;
end;

procedure TdxTreeListColumn.SetBandIndex(Value: Integer);
begin
  if Value < -1 then Value := -1;
  if (TreeList <> nil) and (Value >= TreeList.Bands.Count) then
    Value := TreeList.Bands.Count - 1;
  if FBandIndex <> Value then
  begin
    FBandIndex := Value;
    Changed(False);
  end;
end;

procedure TdxTreeListColumn.SetRowIndex(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if (TreeList <> nil) and (Value >= TreeList.HeaderPanelRowCount) then
    Value := TreeList.HeaderPanelRowCount - 1;
  if {FRowIndex} RowIndex <> Value then
  begin
    FRowIndex := Value;
    // store max index
    FStoredRowIndex := Value;
    Changed(False);
  end;
end;

procedure TdxTreeListColumn.SetColIndex(Value: Integer);
var
  Band: TdxTreeListBand;
  Column: TdxTreeListColumn;
  ColCount: Integer;
begin
  if GetColIndex <> Value then
  begin
    if Self.BandIndex = -1 then Exit;
    Band := TreeList.Bands[Self.BandIndex];
    ColCount := Band.HeaderColCount[Self.RowIndex];
    if Value < 0 then Value := 0;
    if Value >= ColCount then Value := ColCount - 1;
    Column := Band.HeaderColumn[Self.RowIndex, Value];
    if Column <> nil then
    begin
      if Value = (ColCount - 1) then
        Self.Index := Column.Index + 1
      else Self.Index := Column.Index;
    end;
  end;
end;

procedure TdxTreeListColumn.SetHeaderMaxLineCount(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FHeaderMaxLineCount <> Value then
  begin
    FHeaderMaxLineCount := Value;
    Changed(True);
  end;
end;

function TdxTreeListColumn.GetSortedOrder: Integer;
begin
  Result := TreeList.FSortedColumns.IndexOf(Self);
end;

procedure TdxTreeListColumn.ReadSortedOrder(Reader: TReader);
begin
  FSortedOrder := Reader.ReadInteger;
end;

procedure TdxTreeListColumn.WriteSortedOrder(Writer: TWriter);
begin
  Writer.WriteInteger(Self.SortedOrder{TreeList.FSortedColumns.IndexOf(Self)});
end;

procedure TdxTreeListColumn.ReadStoredRowIndex(Reader: TReader);
begin
  FStoredRowIndex := Reader.ReadInteger;
end;

procedure TdxTreeListColumn.WriteStoredRowIndex(Writer: TWriter);
begin
  Writer.WriteInteger(FStoredRowIndex);
end;

{TCustomdxTreeListControl}
constructor TCustomdxTreeListControl.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FColumns := TList.Create;
  FBands := TdxTreeListBands.Create(Self, TdxTreeListBand);
  FBandRowCount := 1;
  FBandMaxRowCount := 5;
  FHeaderPanelRowCount := 1;
  FHeaderMinRowCount := 1;
  FHeaderPanelMaxRowCount := 5;
  FEditors := TList.Create;
  FSortedColumns := TList.Create;
  FBands.FTreeList := nil;
  try
    FBands.Add;
  finally
    FBands.FTreeList := Self;
  end;
  FDefaultLayout := True;
  // smart calc indexes
  FBandList := TList.Create;
  FBandVisibleList := TList.Create;
  FHeaderAbsoluteList := TList.Create;
  FHeaderBounds := TList.Create;
end;

procedure TCustomdxTreeListControl.DoRestoreLayout;
begin
  if FLoadedLayout then Exit;
  FLoadedLayout := True;
  if (aoStoreToRegistry in Options) and not (csDesigning in ComponentState) and
    (RegistryPath <> '') then LoadFromRegistry(RegistryPath);
  if (aoStoreToIniFile in Options) and not (csDesigning in ComponentState) and
    (IniFileName <> '') then LoadFromIniFile(IniFileName);
end;

procedure TCustomdxTreeListControl.DoSaveLayout;
begin
  if FSavedLayout then Exit;
  FSavedLayout := True;
  if (aoStoreToRegistry in Options) and not (csDesigning in ComponentState) and
    (RegistryPath <> '') then SaveToRegistry(RegistryPath);
  if (aoStoreToIniFile in Options) and not (csDesigning in ComponentState) and
    (IniFileName <> '') then SaveToIniFile(IniFileName);
end;

destructor TCustomdxTreeListControl.Destroy;
begin
  try
    DoSaveLayout;
  finally
    BeforeDestroy;
    if FDesigner <> nil then FDesigner.Free;
    // smart calc indexes
    ClearListNodes;
    FHeaderBounds.Free;
    FHeaderBounds := nil;
    FHeaderAbsoluteList.Free;
    FHeaderAbsoluteList := nil;
    FBandVisibleList.Free;
    FBandVisibleList := nil;
    FBandList.Free;
    FBandList := nil;

    if Assigned(FColumns) then DestroyColumns;
    FBands.Free;
    FBands := nil;
    FColumns.Free;
    FColumns := nil;
    FEditors.Free;
    FEditors := nil;
    FSortedColumns.Free;
    FSortedColumns := nil;
    inherited Destroy;
  end;
end;

procedure TCustomdxTreeListControl.ApplyBestFit(AColumn: TdxTreeListColumn);
var
  Col: TdxTreeListColumn;
  MaxWidth, CharWidth, W, I: Integer;
  LeftColumn: Boolean;

  procedure CalcMaxWidth(Node: TdxTreeListNode);
  var
    I, W: Integer;
  begin
    if Node.HasChildren then
      for I := 0 to Node.Count - 1 do
        CalcMaxWidth(Node[I]);
//    else
    if not IsRowGroup(Node) then
    begin
      W := Col.GetBestFit(Canvas, Node);
      if LeftColumn then
        W := W + (Node.Level + Byte(ShowRoot and (PaintStyle = psStandard)))*FIndent - GetIndentWidth +
          Byte(Node.StateIndex <> -1)*FImageStateW +
          Byte((Node.ImageIndex <> -1) or (Node.SelectedIndex <> -1))*FImageW;
      if W > MaxWidth then MaxWidth := W;
    end;
  end;

  procedure CalcBestFit;
  var
    I: Integer;
  begin
    if IsExistColumnFont(Col.Index) then
      Canvas.Font := Col.Font
    else Canvas.Font := Self.Font;
    for I := 0 to Count - 1 do
      CalcMaxWidth(Items[I]);
    // Header  
    Canvas.Font := Self.HeaderFont;
    W := Canvas.TextWidth(Col.Caption) + Byte(not Col.DisableFilter) * dxGridHeaderFilterBoxWidth;
    if W > MaxWidth then MaxWidth := W;
    if Col.Sizing then
      Col.Width := MaxWidth + 2 * CharWidth;
  end;

  function IsLeftHeader(AbsoluteIndex: Integer): Boolean;
  begin
    Result := IsHeaderVisible(AbsoluteIndex) and (GetVisibleBandIndex(GetHeaderBandIndex(AbsoluteIndex)) = 0) and
      (GetHeaderColIndex(AbsoluteIndex) = 0);
  end;

begin
  Canvas.Font := Self.Font;
  MaxWidth := 0;
  CharWidth := Canvas.TextWidth('0') div 2 + 1;
  Col := AColumn;
  if Col = nil then
  begin
    BeginUpdate;
    try
      for i := 0 to ColumnCount - 1 do
      begin
        Col := Columns[i];
        LeftColumn := IsLeftHeader(Col.Index);
        MaxWidth := 0;
        CalcBestFit;
      end;
    finally
     EndUpdate;
    end;
  end
  else
  begin
    LeftColumn := IsLeftHeader(Col.Index);
    CalcBestFit;
  end;
end;

procedure TCustomdxTreeListControl.AssignColumns(ATreeListControl: TCustomdxTreeListControl);
var
  I: Integer;
  Column, NewColumn: TdxTreeListColumn;
  PrevOwner: TComponent;
begin
  BeginUpdate;
  try
    if ColumnCount > 0 then
      PrevOwner := Columns[0].Owner
    else PrevOwner := Self;
    DestroyColumns;
    for I := 0 to ATreeListControl.ColumnCount - 1 do
    begin
      Column := ATreeListControl.Columns[I];
      NewColumn := CreateColumnEx(TdxTreeListColumnClass(Column.ClassType), PrevOwner);
      NewColumn.Assign(Column);
      NewColumn.Name := Column.Name;
    end;
  finally
    EndUpdate;
  end;
end;

function TCustomdxTreeListControl.ColumnByName(const AName: string): TdxTreeListColumn;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to ColumnCount - 1 do
    if {Ansi}CompareText(Columns[I].Name, AName) = 0 then
    begin
      Result := Columns[I];
      Break;
    end;
end;

function TCustomdxTreeListControl.CreateColumn(ColumnClass: TdxTreeListColumnClass): TdxTreeListColumn;
begin
  Result := CreateColumnEx(ColumnClass, Self);
end;

function TCustomdxTreeListControl.CreateColumnEx(ColumnClass: TdxTreeListColumnClass;
  AOwner: TComponent): TdxTreeListColumn;
var
  I: Integer;
begin
  Result := ColumnClass.Create(AOwner);
  I := ColumnCount + 1;
  while I <> -1 do
    try
      Result.Name := Name + 'Column' + IntToStr(I);
      I := -1;
    except
      Inc(I);
    end;
  Result.TreeList := Self;
end;

procedure TCustomdxTreeListControl.DestroyColumns;
var
  Column: TdxTreeListColumn;
begin
  while FColumns.Count > 0 do
  begin
    Column := FColumns.Last;
    RemoveColumn(Column);
    Column.Free;
  end;
end;

function TCustomdxTreeListControl.GetAbsoluteColumnIndex(VisibleIndex: Integer): Integer;
var
  i, j: Integer;
begin
  Result := -1;
  j := -1;
  for i := 0 to FColumns.Count - 1 do
  begin
    if TdxTreeListColumn(FColumns[i]).Visible then Inc(j);
    if j = VisibleIndex then
    begin
      Result := i;
      Break;
    end;
  end;
end;

function TCustomdxTreeListControl.GetDisplayValue(Node: TdxTreeListNode; AbsoluteIndex: Integer): string;
begin
  Result := Columns[AbsoluteIndex].GetDisplayValue(Node, Node.Strings[AbsoluteIndex]);
end;

function TCustomdxTreeListControl.GetVisibleColumnIndex(AbsoluteIndex: Integer): Integer;
var
  i: Integer;
begin
  Result := -1;
  if AbsoluteIndex < FColumns.Count then
  begin
    for i := 0 to AbsoluteIndex do
      if TdxTreeListColumn(FColumns[i]).Visible then Inc(Result);
  end;
end;

procedure TCustomdxTreeListControl.RefreshDefaultColumnsWidths;
var
  I: Integer;
begin
  for i := 0 to ColumnCount - 1 do
    Columns[i].RefreshDefaultWidth;
end;

procedure TCustomdxTreeListControl.RestoreColumnsDefaults;
var
  i: Integer;
begin
  BeginUpdate;
  try
    for i := 0 to ColumnCount - 1 do
      Columns[I].RestoreDefaults;
  finally
    EndUpdate;
  end;
end;

// hit test functions
function TCustomdxTreeListControl.GetBandAt(X, Y: Integer): TdxTreeListBand;
var
  Info: TdxTreeListHitInfo;
begin
  Info := GetHitInfo(Point(X, Y));
  if (Info.hitType in [htBand, htBandEdge]) and (Info.Band <> -1) then
    Result := Bands.VisibleItems[Info.Band]
  else Result := nil;
end;

function TCustomdxTreeListControl.GetColumnAt(X, Y: Integer): TdxTreeListColumn;
var
  Info: TdxTreeListHitInfo;
begin
  Info := GetHitInfo(Point(X, Y));
  if (Info.hitType in [htColumn, htColumnEdge, htButton,
      htIcon, htStateIcon, htIndent, htLabel]) and (Info.Column <> -1) then
    Result := Columns[Info.Column]
  else Result := nil;
end;

function TCustomdxTreeListControl.GetFooterColumnAt(X, Y: Integer): TdxTreeListColumn;
var
  Info: TdxTreeListHitInfo;
begin
  Info := GetHitInfo(Point(X, Y));
  if (Info.hitType in [htSummaryFooter]) and (Info.Column <> -1) then
    Result := Columns[Info.Column]
  else Result := nil;
end;

function TCustomdxTreeListControl.GetHeaderColumnAt(X, Y: Integer): TdxTreeListColumn;
var
  Info: TdxTreeListHitInfo;
begin
  Info := GetHitInfo(Point(X, Y));
  if (Info.hitType in [htColumn, htColumnEdge]) and (Info.Column <> -1) then
    Result := Columns[Info.Column]
  else Result := nil;
end;

function TCustomdxTreeListControl.GetNodeFooterColumnAt(X, Y: Integer): TdxTreeListColumn;
var
  Info: TdxTreeListHitInfo;
begin
  Info := GetHitInfo(Point(X, Y));
  if (Info.hitType in [htSummaryNodeFooter]) and (Info.Column <> -1) then
    Result := Columns[Info.Column]
  else Result := nil;
end;

procedure TCustomdxTreeListControl.BeginSorting;
begin
  Inc(FLockSorting);
end;

procedure TCustomdxTreeListControl.ClearColumnsSorted;
begin
  FSortedColumns.Clear;
end;

procedure TCustomdxTreeListControl.EndSorting;
begin
  Dec(FLockSorting);
  if FLockSorting = 0 then RefreshSorting;
end;

procedure TCustomdxTreeListControl.RefreshSorting;
begin
end;

procedure TCustomdxTreeListControl.HeaderPanelBestFit;
var
  I, H: Integer;
begin
  H := -1;
  for I := 0 to ColumnCount - 1 do
    if IsHeaderVisible(I) and (Columns[I].StoredRowIndex > H) then
      H := Columns[I].StoredRowIndex;
  if H <> -1 then
  begin
    FSetAutoHeaderPanelRowCount := True;
    try
      HeaderPanelRowCount := H + 1;
    finally
      FSetAutoHeaderPanelRowCount := False;
    end;
  end;
end;

function TCustomdxTreeListControl.ColumnCalcLineCount(ANode: TdxTreeListNode;
  AbsoluteIndex: Integer; const Text: string;
  BoundsWidth, TextHeight, MaxLineCount: Integer;
  InflateFlag{obsolete}, GridFlag{obsolete}: Boolean;
  var LineCount, LineHeight: Integer): Boolean;
var
  ViewInfo: TdxEditViewInfo;
begin
  Result := False;
  if Assigned(FOnCalcRowLineHeight) then
    FOnCalcRowLineHeight(Self, ANode, Columns[AbsoluteIndex], Text, BoundsWidth, TextHeight, MaxLineCount,
      InflateFlag{obsolete}, GridFlag{obsolete}, LineCount, LineHeight, Result);
  if not Result then
  begin
    with FCellViewData do
    begin
      Cell_Brush := Self.Brush.Handle;
      if IsExistColumnFont(AbsoluteIndex) then
        Cell_Font := Columns[AbsoluteIndex].Font.Handle
      else Cell_Font := Self.Font.Handle;
      Cell_BkColor := clBlack;
      Cell_TextColor := clBlack;
      Cell_Alignment := Columns[AbsoluteIndex].Alignment;
      Cell_Text := Text;
      Cell_TextLength := 0;
      Cell_InvertSelect := False;
      Cell_LeftEdge := False;
      Cell_RightEdge := False;
      Cell_MultiLine := True;
      Cell_InvertText := False;
      Cell_DrawEndEllipsis := False;
      Cell_Node := ANode;
      Cell_IsNullNode := False;
      Cell_SelectionColor := HighlightColor;
      Cell_CellBrush := Cell_Brush;
      Cell_CellColor := Cell_BkColor;
      Cell_HotTrackNode := IsHotTrackNode(ANode, AbsoluteIndex);
      Cell_Rect := Rect(0, 0, BoundsWidth, TextHeight);
      InflateRect(Cell_Rect, 2, 2); // TODO PAINT2
    end;
    with Columns[AbsoluteIndex] do
    begin
      FActualNode := ANode;
      try
        PrepareViewData(ViewData, FCellViewData);
        CalcCellViewBoundsRect(Rect(0, 0, BoundsWidth, TextHeight), ViewData.ViewBounds);
        GetdxInplaceEditClass.CalcViewInfo(ViewData, False, ViewInfo);
        ViewData.CalcHeight := True;
        ViewData.LineCount := 0;
        if GetdxInplaceEditClass.DrawClientArea(TempDC, ViewInfo.ClientBounds, ViewData, False) then
        begin
          LineHeight := ViewData.LineHeight;
          LineCount := ViewData.LineCount;
          if (MaxLineCount <> -1) and (LineCount > MaxLineCount) then
          begin
            LineCount := MaxLineCount;
            LineHeight := LineCount * ViewData.LineTextHeight;
          end;
        end
        else
          LineCount := 1;
        LineHeight := TCustomdxTreeList.CalcTextRowHeight(LineHeight);
      finally
        FActualNode := nil;
      end;
    end;
    Result := True;
  end;
end;

// protected TCustomdxTreeListControl
function TCustomdxTreeListControl.GetAbsoluteBandAlignment(AbsoluteIndex: Integer): TAlignment;
begin
  Result := FBands.Items[AbsoluteIndex].Alignment;
end;

function TCustomdxTreeListControl.GetAbsoluteBandCount: Integer;
begin
  Result := FBands.Count;
end;

function TCustomdxTreeListControl.GetAbsoluteBandIndex(VisibleIndex: Integer): Integer;
begin
  Result := FBands.GetAbsoluteIndex(VisibleIndex);
end;

function TCustomdxTreeListControl.GetAbsoluteBandText(AbsoluteIndex: Integer): string;
begin
  Result := FBands.Items[AbsoluteIndex].Caption;
end;

function TCustomdxTreeListControl.GetAbsoluteBandWidth(AbsoluteIndex: Integer): Integer;
begin
  Result := FBands.Items[AbsoluteIndex].Width;
end;

function TCustomdxTreeListControl.GetBandAlignment(VisibleIndex: Integer): TAlignment;
begin
  Result := FBands.VisibleItems[VisibleIndex].Alignment;
end;

function TCustomdxTreeListControl.GetBandCount: Integer;
begin
  Result := FBands.VisibleCount;
end;

function TCustomdxTreeListControl.GetBandFixedLeft: Integer;
begin
  Result := -1;
  with FBands do
    if (VisibleCount > 0) and (VisibleItems[0].Fixed = bfLeft) then
      Result := 0;
end;

function TCustomdxTreeListControl.GetBandFixedRight: Integer;
begin
  Result := -1;
  with FBands do
    if (VisibleCount > 0) and (VisibleItems[VisibleCount - 1].Fixed = bfRight) then
      Result := VisibleCount - 1;
end;

function TCustomdxTreeListControl.GetBandMinWidthSize(VisibleIndex: Integer): Integer;
begin
  Result := FBands.VisibleItems[VisibleIndex].MinWidth;
end;

function TCustomdxTreeListControl.GetBandText(VisibleIndex: Integer): string;
begin
  Result := FBands.VisibleItems[VisibleIndex].Caption;
end;

function TCustomdxTreeListControl.GetBandSizeWidth(VisibleIndex: Integer): Integer;
begin
  Result := FBands.VisibleItems[VisibleIndex].Width;
end;

function TCustomdxTreeListControl.GetVisibleBandIndex(AbsoluteIndex: Integer): Integer;
begin
  Result := FBands.GetVisibleIndex(AbsoluteIndex);
end;

function TCustomdxTreeListControl.IsOwnBand(ABandIndex: Integer{VisibleIndex}): Boolean;
begin
  if (0 <= ABandIndex) and (ABandIndex < GetBandCount) then
    Result := FBands.VisibleItems[ABandIndex].OnlyOwnColumns
  else Result := False;
end;

function TCustomdxTreeListControl.GetColumnColor(AbsoluteIndex: Integer): TColor;
begin
  Result := Columns[AbsoluteIndex].Color;
end;

function TCustomdxTreeListControl.GetColumnFont(AbsoluteIndex: Integer): TFont;
begin
  Result := Columns[AbsoluteIndex].Font;
end;

function TCustomdxTreeListControl.GetHeaderAbsoluteCount: Integer;
begin
  Result := FColumns.Count;
end;

function TCustomdxTreeListControl.GetHeaderAbsoluteIndex(BandIndex, RowIndex, ColIndex: Integer): Integer;
var
  I: Integer;
  Column: TdxTreeListColumn;
begin
  Result := -1;
  // speed
  if not FHeaderListLoading and (FHeaderAbsoluteList.Count > 0) then
  begin
    if (BandIndex < FHeaderAbsoluteList.Count) and
      (RowIndex < TList(FHeaderAbsoluteList[BandIndex]).Count) and
      (ColIndex < TList(TList(FHeaderAbsoluteList[BandIndex])[RowIndex]).Count) then
    Result := Integer(TList(TList(FHeaderAbsoluteList[BandIndex])[RowIndex])[ColIndex]);
    Exit;
  end;
  for I := 0 to ColumnCount - 1 do
  begin
    Column := Columns[I];
    if Column.Visible and (Column.BandIndex = Bands.VisibleItems[BandIndex].Index) and
      (Column.RowIndex = RowIndex) and (Column.ColIndex = ColIndex) then
    begin
      Result := I;
      Break;
    end;
  end;
end;

function TCustomdxTreeListControl.GetHeaderAlignment(AbsoluteIndex: Integer): TAlignment;
begin
  Result := Columns[AbsoluteIndex].HeaderAlignment;
end;

function TCustomdxTreeListControl.GetHeaderBoundsWidth(AbsoluteIndex: Integer): Integer;
begin
  if (LockUpdate = 0) and (FHeaderBounds.Count = 0) and not FHeaderBoundsLoading then
    MakeBoundsInfo;
  if not FHeaderBoundsLoading and (FHeaderBounds.Count > 0) and (AbsoluteIndex < FHeaderBounds.Count) then // speed
    Result := Integer(FHeaderBounds[AbsoluteIndex])
  else
    Result := inherited GetHeaderBoundsWidth(AbsoluteIndex);
end;

function TCustomdxTreeListControl.GetHeaderBandIndex(AbsoluteIndex: Integer): Integer;
begin
  Result := Columns[AbsoluteIndex].BandIndex;
end;

function TCustomdxTreeListControl.GetHeaderColCount(BandIndex, RowIndex: Integer): Integer;
var
  I: Integer;
  Column: TdxTreeListColumn;
begin
  Result := 0;
  // new check
  if (BandIndex = -1) or (RowIndex = -1) then Exit;
  // speed
  if not FHeaderListLoading and (FHeaderAbsoluteList.Count > 0) then
  begin
    if (BandIndex < FHeaderAbsoluteList.Count) and
      (RowIndex < TList(FHeaderAbsoluteList[BandIndex]).Count) then
      Result := TList(TList(FHeaderAbsoluteList[BandIndex])[RowIndex]).Count;
    Exit;
  end;
  for I := 0 to ColumnCount - 1 do
  begin
    Column := Columns[I];
    if Column.Visible and (Column.BandIndex = Bands.VisibleItems[BandIndex].Index) and
      (Column.RowIndex = RowIndex) then Inc(Result);
  end;    
end;

function TCustomdxTreeListControl.GetHeaderColIndex(AbsoluteIndex: Integer): Integer;
begin
  Result := Columns[AbsoluteIndex].ColIndex;
end;

function TCustomdxTreeListControl.GetHeaderDropDownButtonState(AbsoluteIndex: Integer): TdxHeaderDropDownButtonState;
begin
  if Columns[AbsoluteIndex].DisableFilter then
    Result := []
  else
    Result := inherited GetHeaderDropDownButtonState(AbsoluteIndex);
end;

function TCustomdxTreeListControl.GetHeaderGlyph(AbsoluteIndex: Integer): TBitmap;
begin
  Result := Columns[AbsoluteIndex].HeaderGlyph;
end;

function TCustomdxTreeListControl.GetHeaderMaxLineCount(AbsoluteIndex: Integer): Integer;
begin
  Result := Columns[AbsoluteIndex].HeaderMaxLineCount;
end;

function TCustomdxTreeListControl.GetHeaderMaxRowHeight(ACanvas: TCanvas; AbsoluteIndex: Integer): Integer;
begin
  Result := Max(inherited GetHeaderMaxRowHeight(ACanvas, AbsoluteIndex),
    Columns[AbsoluteIndex].GetMaxRowHeight(ACanvas));
end;

function TCustomdxTreeListControl.GetHeaderMinWidth(AbsoluteIndex: Integer): Integer;
begin
  if not Columns[AbsoluteIndex].Sizing then
    Result := Columns[AbsoluteIndex].Width
  else Result := Columns[AbsoluteIndex].MinWidth;
end;

function TCustomdxTreeListControl.GetHeaderRowCount(BandIndex: Integer): Integer;
var
  PIndexes: PIntArray;
  I, RCount: Integer;
  Column: TdxTreeListColumn;
begin
  Result := 0;
  // new check visible
  if BandIndex = -1 then Exit;
  // speed
  if not FHeaderListLoading and (FHeaderAbsoluteList.Count > 0) then
  begin
    if (BandIndex < FHeaderAbsoluteList.Count) then
      Result := TList(FHeaderAbsoluteList[BandIndex]).Count;
    Exit;
  end;
  RCount := HeaderPanelRowCount + 1;
  PIndexes := AllocMem(RCount * SizeOf(Integer));
  try
    for I := 0 to ColumnCount - 1 do
    begin
      Column := Columns[I];
      if Column.Visible and (Column.BandIndex = Bands.VisibleItems[BandIndex].Index) and
        (0 <= Column.RowIndex) and (Column.RowIndex < RCount) then
          PIndexes^[Column.RowIndex] := 1;
    end;
    for I := 0 to RCount - 1 do
      if PIndexes^[I] = 1 then Inc(Result);
  finally
    FreeMem(PIndexes);
  end;
end;

function TCustomdxTreeListControl.GetHeaderRowIndex(AbsoluteIndex: Integer): Integer;
begin
  Result := Columns[AbsoluteIndex].RowIndex;
end;

function TCustomdxTreeListControl.GetHeaderSorted(AbsoluteIndex: Integer): TdxTreeListColumnSort;
begin
  Result := Columns[AbsoluteIndex].Sorted;
  if Assigned(FOnColumnSorted) then
    FOnColumnSorted(Self, Columns[AbsoluteIndex], Result);
end;

function TCustomdxTreeListControl.GetHeaderTabStop(AbsoluteIndex: Integer): Boolean;
begin
  Result := Columns[AbsoluteIndex].TabStop;
end;

function TCustomdxTreeListControl.GetHeaderText(AbsoluteIndex: Integer): string;
begin
  if Columns[AbsoluteIndex].DisableCaption then Result := ''
  else Result := Columns[AbsoluteIndex].Caption;
end;

function TCustomdxTreeListControl.GetHeaderTextListBox(AbsoluteIndex: Integer): string;
begin
  Result := Columns[AbsoluteIndex].Caption;
end;

function TCustomdxTreeListControl.GetHeaderWidth(AbsoluteIndex: Integer): Integer;
begin
  Result := Columns[AbsoluteIndex].Width;
end;

function TCustomdxTreeListControl.IsExistColumnFont(AbsoluteIndex: Integer): Boolean;
begin
  Result := cvFont in Columns[AbsoluteIndex].AssignedValues;
end;

function TCustomdxTreeListControl.IsExistHeaderGlyph(AbsoluteIndex: Integer): Boolean;
begin
  Result := Columns[AbsoluteIndex].FHeaderGlyph <> nil;
end;

function TCustomdxTreeListControl.GetCellAlignment(Node: TdxTreeListNode; AbsoluteIndex: Integer): TAlignment;
begin
  Result := Columns[AbsoluteIndex].Alignment;
end;

function TCustomdxTreeListControl.GetCellText(Node: TdxTreeListNode; AbsoluteIndex: Integer): string;
begin
  Result := GetNodeString(Node, AbsoluteIndex);
end;

function TCustomdxTreeListControl.IsCellMultiLine(AbsoluteIndex: Integer): Boolean;
begin
  Result := Columns[AbsoluteIndex].IsColumnMultiLine;
end;

function TCustomdxTreeListControl.CanBandSizing(VisibleIndex: Integer): Boolean;
begin
  Result := inherited CanBandSizing(VisibleIndex);
  if Result then
  with FBands do
    Result := (0 <= VisibleIndex) and (VisibleIndex < VisibleCount) and
      {(VisibleItems[VisibleIndex].Fixed = bfNone) and }VisibleItems[VisibleIndex].Sizing;
end;

function TCustomdxTreeListControl.CanHeaderSizing(AbsoluteIndex: Integer): Boolean;
begin
  Result := inherited CanHeaderSizing(AbsoluteIndex);
  if Result then
    Result := Columns[AbsoluteIndex].Sizing;
end;

procedure TCustomdxTreeListControl.ChangedBandRowCount(BandRowCount: Integer);
begin
  SetBandRowCount(BandRowCount);
end;

procedure TCustomdxTreeListControl.ChangedBandWidth(VisibleIndex, Width: Integer);
begin
  if (0 <= VisibleIndex) and (VisibleIndex < FBands.VisibleCount) then
    FBands.VisibleItems[VisibleIndex].Width := Width;
end;

procedure TCustomdxTreeListControl.ChangedHeaderMaxRowCount(RowCount: Integer);
begin
  HeaderPanelRowCount := RowCount;
end;

procedure TCustomdxTreeListControl.ChangedHeaderWidth(AbsoluteIndex, Width: Integer);
var
  Column: TdxTreeListColumn;
begin
  Column := Columns[AbsoluteIndex];
  if Column.Sizing then
  begin
    if Width < Column.FMinWidth then Width := Column.FMinWidth;
    Column.FWidth := Width;
    Include(Column.FAssignedValues, cvWidth);
  end;
end;

procedure TCustomdxTreeListControl.ChangeHiddenBandWidth(ScaleNum, ScaleDenom: Integer);
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := 0 to Bands.Count - 1 do
      if not Bands[I].Visible and Bands[I].Sizing then
        Bands[I].Width := MulDiv(Bands[I].Width, ScaleNum, ScaleDenom);
  finally
    EndUpdate;
  end;
end;

procedure TCustomdxTreeListControl.ChangeHiddenHeaderWidth(BandIndex: Integer; ScaleNum, ScaleDenom: Integer);
var
  I: Integer;
  Column: TdxTreeListColumn;
begin
  BeginUpdate;
  try
    BandIndex := GetAbsoluteBandIndex(BandIndex);
    for I := 0 to ColumnCount - 1 do
    begin
      Column := Columns[I];
      if (Column.BandIndex = BandIndex) and
        not Column.Visible and Column.Sizing then
          Column.Width := MulDiv(Column.Width, ScaleNum, ScaleDenom);
    end;      
  finally
    EndUpdate;
  end;
end;

function TCustomdxTreeListControl.GetBandMaxRowCount: Integer;
begin
  Result := FBandMaxRowCount;
end;

function TCustomdxTreeListControl.GetBandRowCount: Integer;
begin
  Result := FBandRowCount;
end;

function TCustomdxTreeListControl.GetHeaderMaxLimitRowCount: Integer;
begin
  Result := FHeaderPanelMaxRowCount;
end;

function TCustomdxTreeListControl.GetHeaderMaxRowCount: Integer;
begin
  Result := FHeaderPanelRowCount;
end;

function TCustomdxTreeListControl.GetHeaderLineRowCount: Integer;
begin
  Result := FHeaderMinRowCount;
  if Result < inherited GetHeaderLineRowCount then
    Result := inherited GetHeaderLineRowCount;
end;

procedure TCustomdxTreeListControl.DoBandButtonClick;
begin
  if Assigned(FOnBandButtonClick) then FOnBandButtonClick(Self);
end;

procedure TCustomdxTreeListControl.DoBandClick(VisibleIndex: Integer);
begin
  if Assigned(FOnBandClick) then FOnBandClick(Self, Bands.VisibleItems[VisibleIndex]);
end;

procedure TCustomdxTreeListControl.DoBestFitBand(BandIndex: Integer);
var
  Band: TdxTreeListBand;
  I, J: Integer;
begin
  BeginUpdate;
  try
    Band := Bands.VisibleItems[BandIndex];
    for J := 0 to Band.HeaderRowCount - 1 do
      for I := 0 to Band.HeaderColCount[J] - 1 do
        ApplyBestFit(Band.HeaderColumn[J, I]);
  finally
    EndUpdate;
  end;
  DoChangedColumnsWidth;
end;

procedure TCustomdxTreeListControl.DoBestFitColumn(AbsoluteIndex: Integer);
begin
  ApplyBestFit(Columns[AbsoluteIndex]);
  DoChangedColumnsWidth;
end;

procedure TCustomdxTreeListControl.DoChangedColumnsWidth;
begin
  if Assigned(FOnChangedColumnsWidth) then FOnChangedColumnsWidth(Self);
end;

procedure TCustomdxTreeListControl.DoHeaderButtonClick;
begin
  if Assigned(FOnHeaderButtonClick) then FOnHeaderButtonClick(Self);
end;

procedure TCustomdxTreeListControl.DoHeaderClick(AbsoluteIndex: Integer);
var
  Column: TdxTreeListColumn;
begin
  Column := Columns[AbsoluteIndex];
  if Assigned(FOnColumnClick) then FOnColumnClick(Self, Column);
  if IsAutoSort then DoColumnSort(Column);
end;

function TCustomdxTreeListControl.IsBandHeaderWidth: Boolean;
begin
  Result := DefaultLayout or inherited IsBandHeaderWidth;
end;

function TCustomdxTreeListControl.GetNodeDragText(Node: TdxTreeListNode; AbsoluteIndex: Integer): string;
begin
  Result := inherited GetNodeDragText(Node, AbsoluteIndex);
  if Assigned(FOnGetNodeDragText) then
    FOnGetNodeDragText(Self, Node, Columns[AbsoluteIndex], Result);
end;

procedure TCustomdxTreeListControl.BandMoved(FromIndex, ToIndex: Integer);
begin
  if FromIndex <> ToIndex then
    with FBands do
     Bands[GetAbsoluteIndex(FromIndex)].Index := GetAbsoluteIndex(ToIndex);
end;

function TCustomdxTreeListControl.CanBandDragging(VisibleIndex: Integer): Boolean;
var
  Band: TdxTreeListBand;
begin
  Result := inherited CanBandDragging(VisibleIndex);
  with FBands do
    if (0 <= VisibleIndex) and (VisibleIndex < VisibleCount) then
      Band := VisibleItems[VisibleIndex]
    else Band := nil;
  if Result and (Band <> nil) then
  begin
    Result := (Band.Fixed = bfNone) and not Band.DisableDragging;
    if Result and Assigned(FOnCanBandDragging) then FOnCanBandDragging(Self, Band, Result);
  end;
end;

procedure TCustomdxTreeListControl.DoDragOverBand(P: TPoint; AbsoluteIndex: Integer; var Accept: Boolean);
begin
  inherited DoDragOverBand(P, AbsoluteIndex, Accept);
  if Assigned(FOnDragOverBand) then FOnDragOverBand(Self, Bands[AbsoluteIndex], P, Accept);
end;

procedure TCustomdxTreeListControl.DoEndDragBand(P: TPoint; AbsoluteIndex, VisibleIndex: Integer;
  var NewIndex: Integer; var Accept: Boolean);
begin
  inherited DoEndDragBand(P, AbsoluteIndex, VisibleIndex, NewIndex, Accept);
  if Assigned(FOnDragEndBand) then
    FOnDragEndBand(Self, Bands[AbsoluteIndex], P, AbsoluteIndex, VisibleIndex, NewIndex, Accept);
end;

function TCustomdxTreeListControl.GetBandDisableCustomizing(AbsoluteIndex: Integer): Boolean;
begin
  Result := FBands[AbsoluteIndex].DisableCustomizing;
end;

procedure TCustomdxTreeListControl.HideBand(AbsoluteIndex: Integer);
begin
  FBands[AbsoluteIndex].Visible := False;
  if Assigned(FOnHideBand) then FOnHideBand(Self, Bands[AbsoluteIndex]);
end;

function TCustomdxTreeListControl.IsBandInListBox(AbsoluteIndex: Integer): Boolean;
begin
  with FBands.Items[AbsoluteIndex] do
    Result := not Visible and not DisableCustomizing;
end;

procedure TCustomdxTreeListControl.ShowBand(NewIndex{visible index}, AbsoluteIndex: Integer);
var
  Band: TdxTreeListBand;
begin
  BeginUpdate;
  try
    Band := FBands[AbsoluteIndex];
    Band.Visible := True;
    if NewIndex < 0 then NewIndex := 0;
    if FBands.VisibleCount > 1 then
      if NewIndex >= FBands.VisibleCount then
        Band.Index := FBands.Count - 1
      else
        Band.Index := FBands.VisibleItems[NewIndex].Index;
  finally
    EndUpdate;
  end;
  if Assigned(FOnShowBand) then FOnShowBand(Self, Band, NewIndex);
end;

procedure TCustomdxTreeListControl.StartDragBand(AbsoluteIndex: Integer);
begin
  inherited StartDragBand(AbsoluteIndex);
  if Assigned(FOnStartBandDragging) then FOnStartBandDragging(Self, Bands[AbsoluteIndex]);
end;

function TCustomdxTreeListControl.CanHeaderDragging(AbsoluteIndex: Integer): Boolean;
begin
  Result := inherited CanHeaderDragging(AbsoluteIndex) and
    not IsFixedBandHeader(AbsoluteIndex) and
    not Columns[AbsoluteIndex].DisableDragging;
  if Result and Assigned(FOnCanHeaderDragging) then
    FOnCanHeaderDragging(Self, Columns[AbsoluteIndex], Result);
end;

procedure TCustomdxTreeListControl.DoDragOverHeader(P: TPoint; AbsoluteIndex: Integer; var Accept: Boolean);
begin
  inherited DoDragOverHeader(P, AbsoluteIndex, Accept);
  if Assigned(FOnDragOverHeader) then FOnDragOverHeader(Self, Columns[AbsoluteIndex], P, Accept);
end;

procedure TCustomdxTreeListControl.DoEndDragHeader(P: TPoint; AbsoluteIndex: Integer; var NewPosInfo: TdxHeaderPosInfo; var Accept: Boolean);
begin
  inherited DoEndDragHeader(P, AbsoluteIndex, NewPosInfo, Accept);
  if Assigned(FOnDragEndHeader) then FOnDragEndHeader(Self, Columns[AbsoluteIndex], P, NewPosInfo, Accept);
  // obsolete
  if GetBandCount = 1 then
  begin
    if Assigned(FOnColumnMoved) then
      FOnColumnMoved(Self, GetHeaderColIndex(AbsoluteIndex), NewPosInfo.ColIndex);
    if Assigned(FOnEndDragColumn) then
      FOnEndDragColumn(Self, P.X, P.Y, Columns[AbsoluteIndex], NewPosInfo.ColIndex);
  end;
end;

function TCustomdxTreeListControl.GetHeaderDisableCustomizing(AbsoluteIndex: Integer): Boolean;
begin
  Result := Columns[AbsoluteIndex].DisableCustomizing;
end;

procedure TCustomdxTreeListControl.HeaderMoved(FromAbsoluteIndex, ToBandIndex, ToRowIndex, ToColIndex: Integer);
var
  Column: TdxTreeListColumn;
begin
  BeginUpdate;
  try
    Column := Columns[FromAbsoluteIndex];
    Column.BandIndex := Bands.GetAbsoluteIndex(ToBandIndex);
    Column.RowIndex := ToRowIndex; 
    Column.ColIndex := ToColIndex;
  finally
    EndUpdate;
  end;
  if Assigned(FOnHeaderMoved) then FOnHeaderMoved(Self, Column);
end;

procedure TCustomdxTreeListControl.HideHeader(AbsoluteIndex: Integer);
begin
  Columns[AbsoluteIndex].Visible := False;
  if Assigned(FOnHideHeader) then FOnHideHeader(Self, Columns[AbsoluteIndex]);
end;

function TCustomdxTreeListControl.IsHeaderInListBox(AbsoluteIndex: Integer): Boolean;
var
  Column: TdxTreeListColumn;
begin
  Column := Columns[AbsoluteIndex];
  Result := (not Column.Visible or (Column.BandIndex = -1)) and
    not Column.DisableCustomizing;
  if not Column.DisableCustomizing and
    not Result and ShowHiddenInCustomizeBox and
    not IsHeaderVisible(AbsoluteIndex) then Result := True;
end;

function TCustomdxTreeListControl.IsHeaderVisible(AbsoluteIndex: Integer): Boolean;
var
  Column: TdxTreeListColumn;
begin
  Column := Columns[AbsoluteIndex];
  Result := Column.Visible and (Column.BandIndex <> -1) and
    (Bands.Count > 0) and Bands[Column.BandIndex].Visible;
end;

procedure TCustomdxTreeListControl.ShowColumnHeader(BandIndex, RowIndex, ColIndex, AbsoluteIndex: Integer);
var
  Column: TdxTreeListColumn;
begin
  BeginUpdate;
  try
    Column := Columns[AbsoluteIndex];
    Column.BandIndex := Bands.GetAbsoluteIndex(BandIndex);
    Column.Visible := True;
    Column.RowIndex := RowIndex;
    Column.ColIndex := ColIndex;
  finally
    EndUpdate;
  end;
  if Assigned(FOnShowHeader) then FOnShowHeader(Self, Column, BandIndex, RowIndex, ColIndex);
end;

procedure TCustomdxTreeListControl.StartDragHeader(AbsoluteIndex: Integer);
begin
  inherited StartDragHeader(AbsoluteIndex);
  if Assigned(FOnStartHeaderDragging) then FOnStartHeaderDragging(Self, Columns[AbsoluteIndex]);
end;

function TCustomdxTreeListControl.CreateEditor(AColumn: Integer): TdxInplaceEdit;
begin
  Result := Columns[GetFocusedAbsoluteIndex(AColumn)].GetdxInplaceEditClass.Create(Self);
  FEditors.Add(Result);
end;

procedure TCustomdxTreeListControl.DoBeforeEditing(Node : TdxTreeListNode; var AllowEditing: Boolean);
begin
  inherited DoBeforeEditing(Node, AllowEditing);
  if AllowEditing and (0 <= FocusedColumn) and (FocusedColumn < GetVisibleHeaderCount) then
    AllowEditing := Columns[FocusedAbsoluteIndex].GetEnableEditor;
end;

procedure TCustomdxTreeListControl.DoHotTrackNode(AHotTrackInfo: TdxTreeListHotTrackInfo; var ACursor: TCursor);
begin
  with AHotTrackInfo do
    if (Column <> -1) and (Node <> nil) then
      Columns[Column].GetHotTrackCursor(Node, ACursor);
  inherited DoHotTrackNode(AHotTrackInfo, ACursor);
end;

function TCustomdxTreeListControl.FindInplaceEdit(AColumn: Integer): TdxInplaceEdit;
var
  I: Integer;
  EditClass: TdxInplaceEditClass;
begin
  Result := nil;
  EditClass := Columns[GetFocusedAbsoluteIndex(AColumn)].GetdxInplaceEditClass;
  for I := 0 to FEditors.Count - 1 do
    if TdxInplaceEdit(FEditors[I]).ClassType = EditClass then
    begin
      Result := FEditors[i];
      Exit;
    end;
end;

procedure TCustomdxTreeListControl.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if FocusedAbsoluteIndex <> -1 then
    Columns[FocusedAbsoluteIndex].InitEditProperties(AInplaceEdit);
end;

function TCustomdxTreeListControl.InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant;
begin
  if FocusedAbsoluteIndex <> -1 then
    Result := Columns[FocusedAbsoluteIndex].InitEditValue(ANode, AInplaceEdit)
  else Result := inherited InitEditValue(ANode, AInplaceEdit);
end;

procedure TCustomdxTreeListControl.ClearListNodes;
var
  I, J: Integer;
  List: TList;
begin
  inherited ClearListNodes;
  if FBandList <> nil then FBandList.Clear;
  if FBandVisibleList <> nil then FBandVisibleList.Clear;
  if FHeaderAbsoluteList <> nil then
  begin
    for I := 0 to FHeaderAbsoluteList.Count - 1 do
    begin
      List := FHeaderAbsoluteList[I];  // get row list
      for J := 0 to List.Count - 1 do  // free col list
        TList(List[J]).Free;
      List.Free;                       // free row list
    end;
    FHeaderAbsoluteList.Clear;
  end;
  ClearBoundsInfo;
end;

procedure TCustomdxTreeListControl.ClearNodeRowHeight;
begin
  inherited ClearNodeRowHeight;
  ClearBoundsInfo;
end;

type
PdxHeaderCalculateInfo =^TdxHeaderCalculateInfo;
TdxHeaderCalculateInfo = record
  Column: TdxTreeListColumn;
  BandIndex: Integer;
  RowIndex: Integer;
  Index: Integer;              // calculate in cycle for I := 0
end;

function CompareHeaders(Item1, Item2: Pointer): Integer;
begin
  Result := PdxHeaderCalculateInfo(Item1)^.BandIndex - PdxHeaderCalculateInfo(Item2)^.BandIndex;
  if Result = 0 then
  begin
    Result := PdxHeaderCalculateInfo(Item1)^.RowIndex - PdxHeaderCalculateInfo(Item2)^.RowIndex;
    if Result = 0 then
      Result := PdxHeaderCalculateInfo(Item1)^.Index - PdxHeaderCalculateInfo(Item2)^.Index;
  end;
end;

function TCustomdxTreeListControl.IsColumnHotTrack(X, Y: Integer; Node: TdxTreeListNode;
  ColumnAbsoluteIndex: Integer; var ActiveIndex: Integer): Boolean;
begin
  Result := inherited IsColumnHotTrack(X, Y, Node, ColumnAbsoluteIndex, ActiveIndex);
  if not Result and (ColumnAbsoluteIndex <> -1) then
    Result := Columns[ColumnAbsoluteIndex].IsColumnHotTrack(X, Y, Node, ActiveIndex);
end;

function TCustomdxTreeListControl.IsHeaderHotTrack(X, Y: Integer; ColumnAbsoluteIndex: Integer;
  var HeaderHotTrack: TdxTreeListHeaderHotTrack): Boolean;
begin
  Result := inherited IsHeaderHotTrack(X, Y, ColumnAbsoluteIndex, HeaderHotTrack);
  if ColumnAbsoluteIndex <> -1 then
    Result := Result and Columns[ColumnAbsoluteIndex].IsHeaderHotTrack(X, Y, HeaderHotTrack);
end;

procedure TCustomdxTreeListControl.MakeBandHeaderList(CalcBounds: Boolean);
var
  I, J, B, R, C: Integer;
  RowList, ColList, List: TList;
  AHeaderList: TList;
  PHeaderInfo: PdxHeaderCalculateInfo;
  AColumn: TdxTreeListColumn;
begin
  if (FBandList <> nil) and (FBandVisibleList <> nil) and (FHeaderAbsoluteList <> nil) and
    (FHeaderBounds <> nil) then
  begin
    // bands
    FBandListLoading := True;
    try
      // get absolute index from visible index
      C := Bands.GetVisibleCount;
      FBandList.Clear;
      FBandList.Capacity := C;
      for I := 0 to C - 1 do
        FBandList.Add(Pointer(Bands.GetAbsoluteIndex(I)));
      // get visible index from absolute index
      C := Bands.Count;
      FBandVisibleList.Clear;
      FBandVisibleList.Capacity := C;
      for I := 0 to C - 1 do
        FBandVisibleList.Add(Pointer(Bands.GetVisibleIndex(I)));
    finally
      FBandListLoading := False;
    end;
    // headers
    FHeaderListLoading := True;
    try
      // get absolute index from band, row, col index
      for I := 0 to FHeaderAbsoluteList.Count - 1 do
      begin
        List := FHeaderAbsoluteList[I];  // get row list
        for J := 0 to List.Count - 1 do  // free col list
          TList(List[J]).Free;
        List.Free;                       // free row list
      end;
      FHeaderAbsoluteList.Clear;
      B := FBandList.Count; // Visible Band Count
      FHeaderAbsoluteList.Capacity := B;
      // create temp list
      AHeaderList := TList.Create;
      try
        if Bands.Count > 0 then
          for I := 0 to ColumnCount - 1 do
          begin
            AColumn := Columns[I];
            if AColumn.Visible and (AColumn.BandIndex <> -1) and
              Bands.Items[AColumn.BandIndex].Visible then
            begin
              New(PHeaderInfo);
              PHeaderInfo^.Column := AColumn;
              PHeaderInfo^.BandIndex := AColumn.BandIndex;
              PHeaderInfo^.RowIndex := AColumn.RowIndex;
              PHeaderInfo^.Index := I;
              AHeaderList.Add(PHeaderInfo);
            end;
          end;
        AHeaderList.Sort(CompareHeaders);
        // Save to FHeaderAbsoluteList
        if AHeaderList.Count > 0 then
        begin
          FHeaderAbsoluteList.Capacity := FBandList.Count;
          I := 0;
          PHeaderInfo := AHeaderList[I];
          repeat
            RowList := TList.Create;
            B := PHeaderInfo^.BandIndex;
            repeat
              ColList := TList.Create;
              R := PHeaderInfo^.RowIndex;
              repeat
                ColList.Add(Pointer(PHeaderInfo^.Index));
                Inc(I);
                if I >= AHeaderList.Count then Break;
                PHeaderInfo := AHeaderList[I];
              until (PHeaderInfo^.BandIndex <> B) or (PHeaderInfo^.RowIndex <> R);
              RowList.Add(ColList);
              if I >= AHeaderList.Count then Break;
            until (PHeaderInfo^.BandIndex <> B);
            // check band empty
            while FHeaderAbsoluteList.Count < Bands.GetVisibleIndex(B) do
              FHeaderAbsoluteList.Add(TList.Create);
            FHeaderAbsoluteList.Add(Pointer(RowList));
          until (I >= AHeaderList.Count);
        end;
      finally
        for I := 0 to AHeaderList.Count - 1 do
        begin
          PHeaderInfo := AHeaderList[I];
          Dispose(PHeaderInfo);
        end;
        AHeaderList.Free;
      end;
    finally
      FHeaderListLoading := False;
    end;
    ClearBoundsInfo;
//    if CalcBounds then MakeBoundsInfo;
  end;
end;

procedure TCustomdxTreeListControl.ClearBoundsInfo;
begin
  inherited ClearBoundsInfo;
  if FHeaderBounds <> nil then FHeaderBounds.Clear;
end;

procedure TCustomdxTreeListControl.MakeBoundsInfo;
var
  I, J: Integer;
begin
  inherited MakeBoundsInfo;
  if FHeaderBounds = nil then Exit;
  FHeaderBoundsLoading := True;
  try
    FHeaderBounds.Clear;
    FHeaderBounds.Capacity := GetVisibleHeaderCount;
    for I := 0 to ColumnCount - 1 do
    begin
      if IsHeaderVisible(I) then
        J := GetHeaderBoundsWidth(I)
      else J := 0;
      FHeaderBounds.Add(Pointer(J));
    end;
  finally
    FHeaderBoundsLoading := False;
  end;
end;

procedure TCustomdxTreeListControl.MakeListNodes;
begin
  inherited MakeListNodes;
  MakeBandHeaderList(True);
end;

procedure TCustomdxTreeListControl.MoveNodeValues(FromIndex, ToIndex: Integer);

  procedure MoveValue(Item: TdxTreeListNode);
  begin
    with Item as TdxTreeListTextNode do
    begin
      if ToIndex >= FStrings.Count then
        while FStrings.Add('') < ToIndex do;
      if FromIndex >= FStrings.Count then
        while FStrings.Add('') < FromIndex do;
      if (FromIndex < ToIndex) then
      begin
        if (ToIndex + 1) = FStrings.Count then
        begin
          FStrings.Add(FStrings[FromIndex]);
          FStrings.Objects[FStrings.Count-1] := FStrings.Objects[FromIndex];
        end
        else
        begin
          FStrings.Insert(ToIndex + 1, FStrings[FromIndex]);
          FStrings.Objects[ToIndex + 1] := FStrings.Objects[FromIndex];
        end;
        FStrings.Delete(FromIndex);
      end
      else
      begin
        FStrings.Insert(ToIndex, FStrings[FromIndex]);
        FStrings.Objects[ToIndex] := FStrings.Objects[FromIndex + 1];
        FStrings.Delete(FromIndex + 1);
      end;
    end;
  end;

  procedure MoveValues(Node: TdxTreeListNode);
  var
    I: Integer;
  begin
    MoveValue(Node);
    for I := 0 to Node.Count - 1 do
      MoveValues(Node[I]);
  end;

var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    MoveValues(Items[i]);
  // Hidden
  for I := 0 to FHiddenList.Count - 1 do
    MoveValues(TdxTreeListNode(FHiddenList[I]));
end;

procedure TCustomdxTreeListControl.ResetAutoHeaderPanelRowCountOption;
begin
  FOptionsEx := FOptionsEx - [aoAutoHeaderPanelHeight];
end;

function TCustomdxTreeListControl.NeedShowButtonEdit(X, Y: Integer;
  IsCurrentNode: Boolean; ColumnAbsoluteIndex: Integer): Boolean;
begin
  Result := inherited NeedShowButtonEdit(X, Y, IsCurrentNode, ColumnAbsoluteIndex);
  if Result and (ColumnAbsoluteIndex <> -1) then
    Result := Columns[ColumnAbsoluteIndex].NeedShowButtonEdit(X, Y, IsCurrentNode);
end;

procedure TCustomdxTreeListControl.UpdateBands;
begin
  // calc best panel size
  if IsAutoHeaderPanelRowCount then
  begin
    BeginUpdate;
    try
      HeaderPanelBestFit;
    finally
      EndUpdate;
    end;
  end
  else
    LayoutChanged;
end;

procedure TCustomdxTreeListControl.UpdateColumn(Column: TdxTreeListColumn);
begin
  if csLoading in ComponentState then Exit;
  if Column <> nil then Column.RefreshDefaultWidth;
//  RefreshRowIndexes;
  if FLockRefreshRowIndexes = 0 then RefreshRowIndexes;
  LayoutChanged;
end;

procedure TCustomdxTreeListControl.UpdateHeaders;
begin
  LayoutChanged;
end;

procedure TCustomdxTreeListControl.AddSortedColumn(Column: TdxTreeListColumn);
begin
  if (Column <> nil) and (FSortedColumns.IndexOf(Column) = -1) and
    (Column.Sorted <> csNone) then FSortedColumns.Add(Column);
end;

function TCustomdxTreeListControl.CanColumnSorting(Column: TdxTreeListColumn): Boolean;
begin
  Result := True;
  if Assigned(FOnColumnSorting) then FOnColumnSorting(Self, Column, Result);
end;

procedure TCustomdxTreeListControl.DoColumnSort(Column: TdxTreeListColumn);
begin
  if CanColumnSorting(Column) then
  begin
    if FlagClearSort then
      Column.Sorted := csNone
    else  
    if Column.Sorted in [csDown, csNone] then
      Column.Sorted := csUp
    else Column.Sorted := csDown;
  end;
end;

procedure TCustomdxTreeListControl.PrepareColumnSorted(Column: TdxTreeListColumn);
begin
end;

procedure TCustomdxTreeListControl.RefreshSortedList;
var
  I: Integer;
begin
  for I := 0 to ColumnCount - 1 do
    if Columns[I].Sorted <> csNone then
      AddSortedColumn(Columns[I]);
  FSortedColumns.Sort(CompareSortedOrderColumns);
end;

procedure TCustomdxTreeListControl.RemoveSortedColumn(Column: TdxTreeListColumn);
begin
  FSortedColumns.Remove(Column);
end;

procedure TCustomdxTreeListControl.SetColumnSorted(Column: TdxTreeListColumn);
begin
  if (Column.Sorted <> csNone) {and (FlagMultiSort or LockSorting)} then
    AddSortedColumn(Column);
end;

procedure TCustomdxTreeListControl.BeginCustomLayout;
begin
  inherited BeginCustomLayout;
  MakeBandHeaderList(True);
end;

function TCustomdxTreeListControl.CanEditModify: Boolean;
var
  I: Integer;
begin
  I := FocusedAbsoluteIndex;
  if (I <> -1) and not Columns[I].ReadOnly then
    Result := True
  else Result := False;
end;

function TCustomdxTreeListControl.CreateNode: TdxTreeListNode;
begin
  Result := TdxTreeListTextNode.Create(Self);
end;

function TCustomdxTreeListControl.GetSortedColumnCount: Integer;
begin
  Result := FSortedColumns.Count;
end;

function TCustomdxTreeListControl.GetSortedColumnDesc(Index: Integer): Boolean;
begin
  Result := SortedColumns[Index].Sorted = csDown;
end;

function TCustomdxTreeListControl.GetSortedColumnIndex(Index: Integer): Integer;
begin
  Result := SortedColumns[Index].Index;
end;

function TCustomdxTreeListControl.GetNodeImageIndex(Node : TdxTreeListNode) : Integer;
begin
  Result := (Node as TdxTreeListTextNode).FImageIndex;
  if Assigned(FOnGetImageIndex) then FOnGetImageIndex(Self, Node, Result);
end;

function TCustomdxTreeListControl.GetNodeSelectedIndex(Node : TdxTreeListNode) : Integer;
begin
  Result := (Node as TdxTreeListTextNode).FSelectedIndex;
  if Assigned(FOnGetSelectedIndex) then FOnGetSelectedIndex(Self, Node, Result);
end;

function TCustomdxTreeListControl.GetNodeStateIndex(Node : TdxTreeListNode) : Integer;
begin
  Result := (Node as TdxTreeListTextNode).FStateIndex;
  if Assigned(FOnGetStateIndex) then FOnGetStateIndex(Self, Node, Result);
end;

function TCustomdxTreeListControl.GetNodeValue(Node: TdxTreeListNode; Column: Integer) : Variant;
begin
  Result := (Node as TdxTreeListTextNode).Strings[Column];
end;

function TCustomdxTreeListControl.GetNodeString(Node: TdxTreeListNode; Column: Integer): string;
begin
  with Node as TdxTreeListTextNode do
    if Column < FStrings.Count then
      Result := FStrings[Column]
    else Result := '';
end;

function TCustomdxTreeListControl.LockSorting: Boolean;
begin
  Result := FLockSorting <> 0;
end;

procedure TCustomdxTreeListControl.RemoveColumn(Column: TdxTreeListColumn);
begin
  Column.FTreeList := nil; // TODO remove strings
  FColumns.Remove(Column);
//  FSortedColumns.Remove(Column);
  RemoveSortedColumn(Column);
  if not (csDestroying in ComponentState) then UpdateColumn(nil);
end;

procedure TCustomdxTreeListControl.SetNodeImageIndex(Node : TdxTreeListNode; Value : Integer);
begin
  if Node.ImageIndex <> Value then
    (Node as TdxTreeListTextNode).FImageIndex := Value;
  UpdateNode(Node, False {no Below});
end;

procedure TCustomdxTreeListControl.SetNodeSelectedIndex(Node : TdxTreeListNode; Value : Integer);
begin
  if Node.SelectedIndex <> Value then
    (Node as TdxTreeListTextNode).FSelectedIndex := Value;
  UpdateNode(Node, False {no Below});
end;

procedure TCustomdxTreeListControl.SetNodeStateIndex(Node : TdxTreeListNode; Value : Integer);
begin
  if Node.StateIndex <> Value then
    (Node as TdxTreeListTextNode).FStateIndex := Value;
  UpdateNode(Node, False {no Below});
end;

procedure TCustomdxTreeListControl.SetNodeString(Node: TdxTreeListNode; Column: Integer; const Value: string);
begin
  with Node as TdxTreeListTextNode do
  begin
    if Column >= FStrings.Count then
       while FStrings.Add('') < Column do;
    FStrings[Column] := Value;
  end;
end;

procedure TCustomdxTreeListControl.SetNodeValue(Node: TdxTreeListNode; Column: Integer; const Value: Variant);
begin
  Node.Strings[Column] := VarToStr(Value);
  if FLockUpdate = 0 then InvalidateRect(GetRectNode(Node));
end;

procedure TCustomdxTreeListControl.BeginReadSettings(ARegIniWrapper: TdxRegIniWrapper);
begin
  BeginUpdate;
  if IsMultiSort then BeginSorting;
end;

procedure TCustomdxTreeListControl.EndReadSettings(ARegIniWrapper: TdxRegIniWrapper);
begin
  if IsMultiSort then EndSorting;
  EndUpdate;
end;

procedure TCustomdxTreeListControl.LoadFromRegIni(ARegIniObject: TObject; APath: string);
var
  RegIniWrapper: TdxRegIniWrapper;
  APathCol, S: string;
  I, ID, J: Integer;
  ABand: TdxTreeListBand;
  AColumn: TdxTreeListColumn;
  FList: TStringList;
begin
  // check "\"
  if (Length(APath) > 0) and (APath[1] <> '\') then
    APath := '\' + APath;
  while (Length(APath) > 0) and (APath[Length(APath)] = '\') do
    Delete(APath, Length(APath), 1);
  RegIniWrapper := TdxRegIniWrapper.Create;
  try
    RegIniWrapper.RegIniObject := ARegIniObject;
    with RegIniWrapper do
    begin
      FList := TStringList.Create;
      BeginReadSettings(RegIniWrapper);
      try
        ReadSettings(RegIniWrapper, APath);
        // bands
        for I := 0 to Bands.Count - 1 do
        begin
          APathCol := APath + '\Band\Band' + IntToStr(I);
          ID := ReadInteger(APathCol, 'ID', -1);
          ABand := nil;
          if ID <> -1 then // find band by ID
            for J := 0 to Bands.Count - 1 do
              if Bands[J].ID = ID then
              begin
                ABand := Bands[J];
                Break;
              end;
          if ABand <> nil then
          begin
            ABand.Visible := ReadBool(APathCol, 'Visible', ABand.Visible);
            ABand.Width := ReadInteger(APathCol, 'Width', ABand.Width);
            // add in sort list
            Str(ReadInteger(APathCol, 'Index', ABand.Index): 11, S);
            FList.AddObject(S, ABand);
          end;
        end;
        FList.Sorted := True;
        for I := 0 to FList.Count - 1 do
          TdxTreeListBand(FList.Objects[I]).Index := I;
        // columns
        FList.Clear;
        FList.Sorted := False;
        for I := 0 to ColumnCount - 1 do
        begin
          AColumn := Columns[I];
          APathCol := APath + '\Columns\' + AColumn.Name;
          ReadColumn(RegIniWrapper, APathCol, AColumn);
          Str(ReadInteger(APathCol, 'Index', AColumn.Index): 11, S);
          FList.AddObject(S, AColumn);
        end;
        // columns order
        FList.Sorted := True;
        for I := 0 to FList.Count - 1 do
          TdxTreeListColumn(FList.Objects[I]).Index := I;
        Inc(FLockRefreshRowIndexes);
        try
          for I := 0 to ColumnCount - 1 do
          begin
            AColumn := Columns[I];
            APathCol := APath + '\Columns\' + AColumn.Name;
            AColumn.BandIndex := ReadInteger(APathCol, 'BandIndex', AColumn.BandIndex);
            AColumn.RowIndex := ReadInteger(APathCol, 'RowIndex', AColumn.RowIndex);
            AColumn.StoredRowIndex := ReadInteger(APathCol, 'StoredRowIndex', Integer(AColumn.StoredRowIndex));
          end;
        finally
          Dec(FLockRefreshRowIndexes);
          UpdateColumn(nil);
        end;
        // Resync Sorted
        if IsMultiSort then RefreshSortedList;
      finally
        EndReadSettings(RegIniWrapper);
        FList.Free;
      end;
    end;
  finally
    RegIniWrapper.Free;
  end;
end;

procedure TCustomdxTreeListControl.ReadColumn(ARegIniWrapper: TdxRegIniWrapper;
  const APathCol: string; AColumn: TdxTreeListColumn);
begin
  with ARegIniWrapper do
  begin
    AColumn.Visible := ReadBool(APathCol, 'Visible', AColumn.Visible);
    AColumn.Width := ReadInteger(APathCol,'Width', AColumn.Width);
    AColumn.Sorted := TdxTreeListColumnSort(ReadInteger(APathCol, 'Sorted', Integer(AColumn.Sorted)));
    AColumn.SortedOrder := ReadInteger(APathCol, 'SortedOrder', Integer(-1));
  end;
end;

procedure TCustomdxTreeListControl.ReadSettings(ARegIniWrapper: TdxRegIniWrapper; const APath: string);
var
  H: Integer;
begin
  with ARegIniWrapper do
  begin
    ShowGrid := ReadBool(APath, 'ShowGrid', ShowGrid);
    ShowPreviewGrid := ReadBool(APath, 'ShowPreviewGrid', ShowPreviewGrid);
    BandRowCount := ReadInteger(APath, 'BandRowCount', BandRowCount);
    DefaultRowHeight := ReadInteger(APath, 'DefaultRowHeight', DefaultRowHeight);
    H := ReadInteger(APath, 'HeaderPanelRowCount', HeaderPanelRowCount);
    if H <> -1 then
    begin
      ResetAutoHeaderPanelRowCountOption;
      HeaderPanelRowCount := H;
    end;
  end;
end;

procedure TCustomdxTreeListControl.SaveToRegIni(ARegIniObject: TObject; APath: string);
var
  RegIniWrapper: TdxRegIniWrapper;
  I: Integer;
  AColumn: TdxTreeListColumn;
begin
  // check "\"
  if (Length(APath) > 0) and (APath[1] <> '\') then
    APath := '\' + APath;
  while (Length(APath) > 0) and (APath[Length(APath)] = '\') do
    Delete(APath, Length(APath), 1);
  RegIniWrapper := TdxRegIniWrapper.Create;
  try
    RegIniWrapper.RegIniObject := ARegIniObject;
    with RegIniWrapper do
    begin
      // erase prev settings
      Erase(APath);
      // write settings
      WriteSettings(RegIniWrapper, APath);
      // columns
      for I := 0 to ColumnCount - 1 do
      begin
        AColumn := TdxTreeListColumn(Columns[I]);
        WriteColumn(RegIniWrapper, APath + '\Columns\' + AColumn.Name, AColumn);
      end;
    end;
  finally
    RegIniWrapper.Free;
  end;
end;

procedure TCustomdxTreeListControl.WriteColumn(ARegIniWrapper: TdxRegIniWrapper;
  const APathCol: string; AColumn: TdxTreeListColumn);
begin
  with ARegIniWrapper do
  begin
    WriteInteger(APathCol, 'BandIndex', Integer(AColumn.BandIndex));
    WriteInteger(APathCol, 'RowIndex', Integer(AColumn.RowIndex));
    WriteInteger(APathCol, 'ColIndex', Integer(AColumn.ColIndex));
    WriteBool(APathCol, 'Visible', AColumn.Visible);
    WriteInteger(APathCol, 'Index', AColumn.Index);
    WriteInteger(APathCol, 'Width', AColumn.Width);
    WriteInteger(APathCol, 'Sorted', Integer(AColumn.Sorted));
    WriteInteger(APathCol, 'SortedOrder', Integer(AColumn.SortedOrder));
    WriteInteger(APathCol, 'StoredRowIndex', Integer(AColumn.StoredRowIndex));
  end;
end;

procedure TCustomdxTreeListControl.WriteSettings(ARegIniWrapper: TdxRegIniWrapper; const APath: string);
var
  APathCol: string;
  I: Integer;
  ABand: TdxTreeListBand;
begin
  with ARegIniWrapper do
  begin
    WriteBool(APath, 'ShowGrid', ShowGrid);
    WriteBool(APath, 'ShowPreviewGrid', ShowPreviewGrid);
    WriteInteger(APath, 'BandRowCount', BandRowCount);
    WriteInteger(APath, 'DefaultRowHeight', DefaultRowHeight);
    if IsAutoHeaderPanelRowCount then
      WriteInteger(APath, 'HeaderPanelRowCount', -1)
    else WriteInteger(APath, 'HeaderPanelRowCount', HeaderPanelRowCount);
    // bands
    for I := 0 to Bands.Count - 1 do
    begin
      ABand := Bands[I];
      APathCol := APath + '\Band\Band' + IntToStr(I);
      WriteInteger(APathCol, 'ID', ABand.ID);         // Collection Item ID
      WriteBool(APathCol, 'Visible', ABand.Visible);
      WriteInteger(APathCol, 'Index', ABand.Index);
      WriteInteger(APathCol, 'Width', ABand.Width);
    end;
  end;
end;

procedure TCustomdxTreeListControl.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
  Column: TdxTreeListColumn;
begin
  for I := 0 to FColumns.Count - 1 do
  begin
    Column := FColumns[I];
    if (Column.Owner = Root) or IsCustomStoring then Proc(Column);
  end;
end;

procedure TCustomdxTreeListControl.SetChildOrder(Component: TComponent; Order: Integer);
begin
  if FColumns.IndexOf(Component) >= 0 then
    (Component as TdxTreeListColumn).Index := Order;
end;

procedure TCustomdxTreeListControl.Loaded;
begin
  inherited Loaded;
  RefreshRowIndexes;
  RefreshSortedList;
  // Load From Ini/Regsirty
  DoRestoreLayout;
end;

procedure TCustomdxTreeListControl.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
  if (AParent <> nil) and (GetParentForm(Self) <> nil) then
    FParentFormName := GetParentForm(Self).Name;
end;

function TCustomdxTreeListControl.AssignedDrawBandEvent(VisibleIndex: Integer): Boolean;
begin
  Result := Assigned(FOnCustomDrawBand);
end;

function TCustomdxTreeListControl.AssignedDrawCellEvent(ANode: TdxTreeListNode; AbsoluteIndex: Integer): Boolean;
begin
  Result := Assigned(FOnCustomDrawCell) or Assigned(FOnCustomDraw){obsolete} or
    Columns[AbsoluteIndex].AssignedDrawCellEvent;
end;

function TCustomdxTreeListControl.AssignedDrawFooterCellEvent(ANode: TdxTreeListNode; AbsoluteIndex, FooterIndex: Integer): Boolean;
begin
  if FooterIndex <> -1 then
    Result := Assigned(FOnCustomDrawFooterNode)
  else Result := Assigned(FOnCustomDrawFooter);
end;

function TCustomdxTreeListControl.AssignedDrawHeaderEvent(AbsoluteIndex: Integer): Boolean;
begin
  Result := Assigned(FOnCustomDrawColumnHeader) or Assigned(Columns[AbsoluteIndex].FOnCustomDrawColumnHeader);
end;

function TCustomdxTreeListControl.AssignedDrawPreviewEvent: Boolean;
begin
  Result := Assigned(FOnCustomDrawPreviewCell) or Assigned(FOnCustomDrawPreview);
end;

function TCustomdxTreeListControl.AssignedLevelColorEvent: Boolean;
begin
  Result := Assigned(OnGetLevelColor);
end;

procedure TCustomdxTreeListControl.DoDrawBand(VisibleIndex: Integer; ACanvas: TCanvas; ARect, AClipRect: TRect; var AText: string;
    var AColor: TColor; AFont: TFont; var AAlignment: TAlignment; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawBand) then FOnCustomDrawBand(Self, Bands.VisibleItems[VisibleIndex],
    ACanvas, ARect, AText, AColor, AFont, AAlignment, ADone);
end;

procedure TCustomdxTreeListControl.DoDrawCell(ACanvas: TCanvas; var ARect: TRect; ANode: TdxTreeListNode; AIndex: Integer;
   ASelected, AFocused: Boolean; ANewItemRow: Boolean; ALeftEdge, ARightEdge: Boolean; ABrush: HBRUSH;
   var AText: string; var AColor: TColor; AFont: TFont; var AAlignment: TAlignment; var ADone: Boolean);
var
  Column: TdxTreeListColumn;
begin
  Column := Columns[AIndex];
  // obsolete
  if Assigned(FOnCustomDraw) then FOnCustomDraw(Self, ACanvas, ARect, ANode, Column, AText,
    AFont, AColor, ASelected, AFocused, ADone);
  if not ADone then
  begin
    if Assigned(FOnCustomDrawCell) then FOnCustomDrawCell(Self, ACanvas, ARect, ANode, Column,
      ASelected, AFocused, ANewItemRow, AText, AColor, AFont, AAlignment, ADone);
    if not ADone and ((ANewItemRow and IsNewItemRowEditing) or (not ANewItemRow and not IsRowGroup(ANode))) then
      Column.DoDrawCell(ACanvas, ARect, ANode, ASelected, AFocused, ANewItemRow, ALeftEdge, ARightEdge, ABrush,
        AText, AColor, AFont, AAlignment, ADone);
  end;
end;

procedure TCustomdxTreeListControl.DoDrawFooterCell(ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AIndex, AFooterIndex: Integer; var AText: string; var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
  var ADone: Boolean);
begin
  if AFooterIndex <> -1 then
    if Assigned(FOnCustomDrawFooterNode) then FOnCustomDrawFooterNode(Self, ACanvas, ARect, ANode,
      Columns[AIndex], AFooterIndex, AText, AColor, AFont, AAlignment, ADone)
    else
  else
    if Assigned(FOnCustomDrawFooter) then FOnCustomDrawFooter(Self, ACanvas, ARect, ANode,
      Columns[AIndex], AText, AColor, AFont, AAlignment, ADone);
end;

procedure TCustomdxTreeListControl.DoDrawHeader(AbsoluteIndex: Integer; ACanvas: TCanvas; ARect, AClipRect: TRect; var AText: string;
    var AColor: TColor; AFont: TFont; var AAlignment: TAlignment; var ASorted: TdxTreeListColumnSort; var ADone: Boolean);
var
  Column: TdxTreeListColumn;
begin
  Column := Columns[AbsoluteIndex];
  if Assigned(FOnCustomDrawColumnHeader) then FOnCustomDrawColumnHeader(Self, Column,
     ACanvas, ARect, AText, AColor, AFont, AAlignment, ASorted, ADone);
  if not ADone and Assigned(Column.FOnCustomDrawColumnHeader) then
    Column.FOnCustomDrawColumnHeader(Self, Column,
     ACanvas, ARect, AText, AColor, AFont, AAlignment, ASorted, ADone);
end;

procedure TCustomdxTreeListControl.DoDrawPreview(ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode; ASelected: Boolean;
  var AText: string; var AColor, ATextColor: TColor; AFont: TFont; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawPreview) then
    FOnCustomDrawPreview(Self, ACanvas, ARect, ANode, ASelected, AText, ADone);
  if not ADone and Assigned(FOnCustomDrawPreviewCell) then FOnCustomDrawPreviewCell(Self, ACanvas, ARect, ANode, ASelected,
    AText, AColor, ATextColor, AFont, ADone);
end;

procedure TCustomdxTreeListControl.DoGetLevelColor(ALevel: Integer; var AColor: TColor);
begin
  if Assigned(FOnGetLevelColor) then FOnGetLevelColor(Self, ALevel, AColor);
end;

function TCustomdxTreeListControl.IsExistFooterCell(AbsoluteIndex: Integer): Boolean;
begin
  Result := False;
  if Assigned(FOnIsExistFooterCell) then FOnIsExistFooterCell(Self, AbsoluteIndex, Result);
end;

// private TCustomdxTreeListControl
procedure TCustomdxTreeListControl.AddColumn(Column: TdxTreeListColumn);
begin
  FColumns.Add(Column);
  Column.FTreeList := Self;
  UpdateColumn(nil);
end;

function TCustomdxTreeListControl.GetColumn(Index: Integer): TdxTreeListColumn;
begin
  Result := FColumns[Index];
end;

function TCustomdxTreeListControl.GetColumnCount: Integer;
begin
  Result := FColumns.Count;
end;

function TCustomdxTreeListControl.GetDefaultLayout: Boolean;
begin
  Result := FDefaultLayout;
end;

function TCustomdxTreeListControl.GetSortedColumns(Index: Integer): TdxTreeListColumn;
begin
  Result := FSortedColumns[Index];
end;

function TCustomdxTreeListControl.GetVisibleColumn(Index: Integer): TdxTreeListColumn;
var
  i: Integer;
begin
  Result := nil;
  i := GetAbsoluteColumnIndex(Index);
  if i <> -1 then Result := Columns[i];
end;

function TCustomdxTreeListControl.GetVisibleColumnCount: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to FColumns.Count - 1 do
    if TdxTreeListColumn(FColumns[i]).Visible then
      Inc(Result);
end;

function TCustomdxTreeListControl.IsHeaderPanelRowCountStored: Boolean;
begin
  Result := not (aoAutoHeaderPanelHeight in OptionsEx);
end;

procedure TCustomdxTreeListControl.MakeDefaultLayout;
var
  I: Integer;
begin
  //if csLoading in ComponentState then Exit;
  BeginUpdate;
  try
    ShowBands := False;
    HeaderPanelRowCount := 1;
    while Bands.Count > 1 do
      Bands[Bands.Count - 1].Free;
    if Bands.Count = 0 then Bands.Add;
    Bands[0].Visible := True;
    for I := 0 to ColumnCount - 1 do
      Columns[I].BandIndex := 0;
  finally
    EndUpdate;
  end;
end;

procedure TCustomdxTreeListControl.SetBands(Value: TdxTreeListBands);
begin
  Bands.Assign(Value);
end;

procedure TCustomdxTreeListControl.SetBandMaxRowCount(Value: Integer);
begin
  if Value < 1 then Value := 1;
  FBandMaxRowCount := Value;
  SetBandRowCount(FBandRowCount);
end;

procedure TCustomdxTreeListControl.SetBandRowCount(Value: Integer);
begin
  if Value < 1 then Value := 1;
  if Value > FBandMaxRowCount then Value := FBandMaxRowCount;
  if FBandRowCount <> Value then
  begin
    FBandRowCount := Value;
    UpdateBands;
  end;
end;

procedure TCustomdxTreeListControl.SetColumn(Index: Integer; Value: TdxTreeListColumn);
begin
  TdxTreeListColumn(FColumns[Index]).Assign(Value);
end;

procedure TCustomdxTreeListControl.SetHeaderPanelMaxRowCount(Value: Integer);
begin
  if Value < 1 then Value := 1;
  FHeaderPanelMaxRowCount := Value;
  SetHeaderPanelRowCount(FHeaderPanelRowCount);
end;

procedure TCustomdxTreeListControl.SetHeaderPanelRowCount(Value: Integer);
begin
  if Value < 1 then Value := 1;
  if Value > FHeaderPanelMaxRowCount then Value := FHeaderPanelMaxRowCount;
  if FHeaderPanelRowCount <> Value then
  begin
    if not FSetAutoHeaderPanelRowCount then
      ResetAutoHeaderPanelRowCountOption;
    FHeaderPanelRowCount := Value;
    if FHeaderPanelRowCount > 1 then FDefaultLayout := False;
    RefreshRowIndexes;
    UpdateHeaders;
  end;
end;

procedure TCustomdxTreeListControl.SetHeaderRowCount(Value: Integer);
begin
  if Value < 1 then Value := 1;
  if FHeaderMinRowCount <> Value then
  begin
    FHeaderMinRowCount := Value;
    UpdateHeaders;
  end;
end;

procedure TCustomdxTreeListControl.RefreshRowIndexes;

  procedure MakeBandRowList(AList: TList);
  var
    PIndexes: PIntArray;
    I, J, RCount, R: Integer;
    Column: TdxTreeListColumn;
  begin
    AList.Clear;
    RCount := HeaderPanelRowCount + 1;
    GetMem(PIndexes, RCount * SizeOf(Integer));
    try
      for J := 0 to Bands.Count - 1 do
      begin
        FillChar(PIndexes^, RCount * SizeOf(Integer), 0);
        for I := 0 to ColumnCount - 1 do
        begin
          Column := Columns[I];
          if Column.Visible and (Column.BandIndex = J) and
            (0 <= Column.RowIndex) and (Column.RowIndex < RCount) then
              PIndexes^[Column.RowIndex] := 1;
        end;
        R := 0;
        for I := 0 to RCount - 1 do
          if PIndexes^[I] = 1 then Inc(R);
        AList.Add(Pointer(R));  
      end;
    finally
      FreeMem(PIndexes);
    end;
  end;

var
  I, J, K, RCount, BIndex: Integer;
  Found: Boolean;
  Column: TdxTreeListColumn;
  ABandRowList: TList;
begin
  ClearListNodes;
  for I := 0 to ColumnCount - 1 do
  begin
    Column := Columns[I];
    if Column.FRowIndex >= FHeaderPanelRowCount then
      Column.FRowIndex := FHeaderPanelRowCount - 1;
    if Column.FRowIndex < 0 then
      Column.FRowIndex := 0;
  end;
  // check empty row
  for K := 0 to Bands.VisibleCount - 1 do
  begin
    BIndex := Bands.VisibleItems[K].Index;
    RCount := GetHeaderRowCount(K);
    for J := RCount - 1 downto 0 do
    begin
      Found := False;
      for I := 0 to ColumnCount - 1 do
      begin
        Column := Columns[I];
        if Column.Visible and (Column.BandIndex = BIndex) and
          (Column.RowIndex = J) then
        begin
          Found := True;
          Break;
        end;
      end;
      // if exist empty row -> move up
      if not Found then
      begin
        for I := 0 to ColumnCount - 1 do
        begin
          Column := Columns[I];
          if Column.Visible and (Column.BandIndex = BIndex) and
            (Column.RowIndex > J) then
          begin
            Dec(Column.FRowIndex);
            Dec(Column.FStoredRowIndex);
          end;
        end;
      end;
    end;
  end;
  // check ranges
  ABandRowList := TList.Create;
  try
    // make Band Row List
    MakeBandRowList(ABandRowList);
    // check
    if ABandRowList.Count > 0 then
      for I := 0 to ColumnCount - 1 do
      begin
        Column := Columns[I];
        BIndex := Column.BandIndex;
        if BIndex <> -1 then
        begin
          RCount := Integer(ABandRowList[BIndex]);
          if Column.FRowIndex >= RCount then
          begin
            Column.FRowIndex := RCount - 1;
            if Column.FRowIndex = -1 then Column.FRowIndex := 0;
            Column.FStoredRowIndex := Column.FRowIndex;    //-2 TODO
          end;
        end;
      end;
  finally
    ABandRowList.Free;
  end;
  // calc best panel size
  if IsAutoHeaderPanelRowCount and not FSetAutoHeaderPanelRowCount then
    HeaderPanelBestFit;
  if LockUpdate = 0 then MakeListNodes;
end;

procedure TCustomdxTreeListControl.SetDefaultLayout(Value: Boolean);
begin
  if FDefaultLayout <> Value then
  begin
    FDefaultLayout := Value;
    if FDefaultLayout then MakeDefaultLayout;
  end;
end;

procedure TCustomdxTreeListControl.SetVisibleColumn(Index: Integer; Value: TdxTreeListColumn);
var
  i :Integer;
begin
  i := GetAbsoluteColumnIndex(Index);
  if i <> -1 then Columns[i] := Value;
end;

procedure TCustomdxTreeListControl.CMCursorChanged(var Message: TMessage);
begin
  inherited;
  if not FCursorChange then FDefaultCursor := Cursor;
end;

procedure TCustomdxTreeListControl.CMFontChanged(var Message: TMessage);
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := 0 to ColumnCount - 1 do
      Columns[I].RefreshDefaultFont;
  finally
    EndUpdate;
  end;
end;

{TdxTreeListDesigner}
constructor TdxTreeListDesigner.Create(ATreeList: TCustomdxTreeListControl);
begin
  FTreeList := ATreeList;
  FTreeList.FDesigner := Self;
end;

destructor TdxTreeListDesigner.Destroy;
begin
  FTreeList.FDesigner := nil;
  inherited Destroy;
end;

procedure TdxTreeListDesigner.LayoutChanged;
begin
end;

{TdxTreeList}
constructor TdxTreeList.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FSelectedNodes := TList.Create;
end;

destructor TdxTreeList.Destroy;
begin
  ClearSelection;
  inherited Destroy;
  FSelectedNodes.Free;
  FSelectedNodes := nil;
end;

procedure TdxTreeList.AssignNodes(Source: TPersistent);
var
  MemStream: TMemoryStream;
  ATreeList: TdxTreeList;
begin
  if Source is TdxTreeList then
  begin
    ATreeList := TdxTreeList(Source);
    BeginUpdate;
    try
      ClearNodes;
      MemStream := TMemoryStream.Create;
      try
        ATreeList.WriteData(MemStream);
        MemStream.Position := 0;
        ReadData(MemStream);
      finally
        MemStream.Free;
      end;
    finally
      EndUpdate;
    end;
  end
  else inherited Assign(Source);
end;

procedure TdxTreeList.ClearColumnsSorted;
var
  I: Integer;
begin
  inherited ClearColumnsSorted;
  for I := 0 to ColumnCount - 1 do
    Columns[I].FSorted := csNone;
end;

procedure TdxTreeList.ClearSelection;
begin
  if GetSelectedCount = 0 then Exit;
  if not (csDestroying in  ComponentState) and not FClearNodes then
    InvalidateSelection;
  if FSelectedNodes <> nil then
    FSelectedNodes.Clear;
  inherited ClearSelection;
end;

procedure TdxTreeList.DeleteSelection;
begin
  inherited DeleteSelection;
  BeginUpdate;
  try
    while SelectedCount > 0 do
      SelectedNodes[0].Free;
    FSelectedNodes.Clear;
  finally
    EndUpdate;
  end;
end;

procedure TdxTreeList.LoadFromFile(const FileName: string);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead);
  try
    LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TdxTreeList.LoadFromStream(Stream: TStream);
begin
  BeginUpdate;
  try
    ClearNodes;
    Self.ReadData(Stream);
  finally
    EndUpdate;
  end;
end;

procedure TdxTreeList.RefreshSorting;
var
  Column: TdxTreeListColumn;
begin
  if IsAutoSort then
  begin
    BeginUpdate;
    try
      Column := SortedColumn;
      if (Column <> nil) and (Column.Sorted <> csNone) then
        DoSortColumn(-1{all levels}, Column.Index, Column.Sorted = csDown);
//      if IsAutoSort and (SortedColumnCount > 0) then
//        DoSortColumn(-1{all levels}, SortedColumns[0].Index, SortedColumns[0].Sorted = csDown);
    finally
      EndUpdate;
    end;
  end;
end;

procedure TdxTreeList.SaveToFile(const FileName: string);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TdxTreeList.SaveToStream(Stream: TStream);
begin
  Self.WriteData(Stream);
end;

procedure TdxTreeList.SelectAll;
var
  N1, N2: TdxTreeListNode;
begin
  if not IsMultiSelect or (Count = 0) then Exit;
  BeginSelection;
  try
    BeginUpdate;
    try
      ClearSelection;
      if IsExtMultiSelect then
      begin
        FullExpand;
        {calc start Node}
        N1 := Items[0];
        {calc end Node}
        N2 := Items[Count - 1];
        while N2.Count > 0 do N2 := N2[N2.Count - 1];
      end
      else
      begin
        if FocusedNode.Parent = nil then
        begin
          N1 := Items[0];
          N2 := Items[Count - 1];
        end
        else
        begin
          N1 := FocusedNode.Parent[0];
          N2 := FocusedNode.Parent[FocusedNode.Parent.Count - 1];
        end;
      end;
      SelectNodes(N1, N2);
    finally
      EndUpdate;
    end;
  finally
    EndSelection;
  end;
end;

//protected TdxTreeList
procedure TdxTreeList.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('Data', ReadData, WriteData, Count > 0);
end;

function TdxTreeList.GetRowIndicatorKind(Node: TdxTreeListNode; ASelected: Boolean): TdxGridIndicatorKind;
begin
  Result := ikNone;
  if Node.Focused then
  begin
    if ASelected and IsMultiSelect then
      Result := ikMultiArrow
    else Result := ikArrow;
  end
  else
    if ASelected then Result := ikMultiDot;
end;

function TdxTreeList.GetPreviewText(Node: TdxTreeListNode): string;
begin
  Result := inherited GetPreviewText(Node);
  if Assigned(FOnGetPreviewText) then FOnGetPreviewText(Self, Node, Result);
end;

function TdxTreeList.GetRowLineCount(Node: TdxTreeListNode; var LineHeight: Integer): Integer;
begin
  Result := inherited GetRowLineCount(Node, LineHeight);
  if Assigned(FOnGetRowLineCount) then FOnGetRowLineCount(Self, Node, Result);
end;

function TdxTreeList.GetRowPreviewLineCount(Node: TdxTreeListNode): Integer;
begin
  Result := inherited GetRowPreviewLineCount(Node);
  if Assigned(FOnGetPreviewLineCount) then FOnGetPreviewLineCount(Self, Node, Result);
end;

function TdxTreeList.GetFooterCellText(Node: TdxTreeListNode; AbsoluteIndex, FooterIndex: Integer): string;
begin
  Result := '';
  if Assigned(FOnGetFooterCellText) then FOnGetFooterCellText(Self, Node, AbsoluteIndex, FooterIndex, Result);
end;

function TdxTreeList.IsExistRowFooterCell(Node: TdxTreeListNode; AbsoluteIndex, FooterIndex: Integer): Boolean;
begin
  Result := False;
  if Assigned(FOnIsExistRowFooterCell) then FOnIsExistRowFooterCell(Self, Node, AbsoluteIndex, FooterIndex, Result);
end;

function TdxTreeList.IsLevelFooter(Level: Integer): Boolean;
begin
  Result := False;
  if Assigned(FOnIsLevelFooter) then FOnIsLevelFooter(Self, Level, Result);
end;

procedure TdxTreeList.AddNode(Node: TdxTreeListNode);
begin
  inherited AddNode(Node);
  CheckRefreshSorting;
end;

procedure TdxTreeList.BeginCustomLayout;
begin
  inherited BeginCustomLayout;
  HideEditor;
  if IsAutoSortRefresh and FNeededSortRefresh and not (csDestroying in ComponentState) then
    RefreshSorting;
  FNeededSortRefresh := False;
end;

procedure TdxTreeList.DeleteNode(Node, Prior, Next: TdxTreeListNode; IsLast, Redraw: Boolean);
begin
  inherited DeleteNode(Node, Prior, Next, IsLast, Redraw);
  CheckRefreshSorting;
end;

function TdxTreeList.GetNodeVariant(Node: TdxTreeListNode; Column: Integer) : Variant;
begin
  if not IsCaseInsensitive then
    Result := Node.Strings[Column]
  else Result := AnsiUpperCase(Node.Strings[Column]);
end;

procedure TdxTreeList.PrepareColumnSorted(Column: TdxTreeListColumn);
begin
  if IsAutoSort and not (FlagMultiSort or LockSorting) then
    ClearColumnsSorted;
end;

procedure TdxTreeList.SetColumnSorted(Column: TdxTreeListColumn);
begin
  if IsMultiSort and (SortedColumn <> nil) then; // check SortedColumns[]
  inherited SetColumnSorted(Column);
  if IsAutoSort and not LockSorting then
    DoSortColumn(-1{all levels}, Column.Index, Column.Sorted = csDown);
end;

procedure TdxTreeList.SetNodeString(Node : TdxTreeListNode; Column : Integer; const Value: string);
begin
  inherited SetNodeString(Node, Column, Value);
  CheckRefreshSorting;
end;

function TdxTreeList.AssignEditValue(ANode: TdxTreeListNode; AColumn: Integer; AInplaceEdit: TdxInplaceEdit): Variant;
var
  I: Integer;
begin
  I := GetFocusedAbsoluteIndex(AColumn);
  if I <> -1 then
  begin
    with Columns[I] do
    begin
      Result := AssignEditValue(ANode, AInplaceEdit);
      ANode.Strings[Index] := GetDisplayText(ANode);
    end;
    if IsRowAutoHeight or (IsShowPreview and IsAutoCalcPreviewLines) then
    begin
      BeginUpdate;
      try
        UpdateNode(ANode, False{Below});
      finally
        EndUpdate;
      end;
    end;
    if IsAutoSortRefresh and not (csDestroying in ComponentState) and (FLockUpdate = 0) then
    begin
      RefreshSorting;
      ANode.MakeVisible;
    end;
  end
  else
    Result := '';
  inherited AssignEditValue(ANode, AColumn, AInplaceEdit);
end;

function TdxTreeList.GetSelectedCount : Integer;
begin
  Result := FSelectedNodes.Count;
end;

function TdxTreeList.GetSelectedItem(AIndex : Integer) : TdxTreeListNode;
begin
  if (AIndex >=0) and (AIndex < GetSelectedCount) then
    Result := FSelectedNodes[AIndex]
  else  Result := nil;
end;

function TdxTreeList.IsNodeSelected(ANode: TdxTreeListNode): Boolean;
var
  TempIndex: Integer;
begin
  Result := FindSelectedNode(ANode, TempIndex); {Sorted List}
end;

procedure TdxTreeList.NodeSelected(ANode: TdxTreeListNode; ASelected: Boolean);
var
  Index: Integer;
begin
  if not IsMultiSelect then Exit;
  if ASelected then
  begin
    if not CanNodeSelected(ANode) then Exit;
    if not FindSelectedNode(ANode, Index) then
      FSelectedNodes.Insert(Index, ANode);
  end
  else
    if FindSelectedNode(ANode, Index) then
      FSelectedNodes.Delete(Index);
  UpdateNode(ANode, False {no Below});
  inherited NodeSelected(ANode, ASelected);
end;

procedure TdxTreeList.SelectNodes(N1, N2: TdxTreeListNode);
var
  I, J, C: Integer;
  FList: TList;
  Node: TdxTreeListNode;
begin
  BeginSelection;
  try
    I := CompareByAbsoluteIndex(N1, N2);
    if I > 0 then
    begin
      Node := N1;
      N1 := N2;
      N2 := Node;
    end;
    BeginUpdate;
    try
      MakeListNodes;
      J := GetAbsoluteIndex(N1);
      C := GetAbsoluteIndex(N2);
      FList := TList.Create;
      try
        FList.Capacity := C - J + 1;
        for I := J to C do
        begin
          Node := GetAbsoluteNode(I);
          if FFirstSelectedNode = nil then FFirstSelectedNode := Node;
          if CanNodeSelected(Node) then FList.Add(Node);
        end;
        if FList.Count > 0 then
        begin
          FList.Sort(CompareNodes);
          // [FList] or [FSelectedNodes]
          J := 0;
          for I := 0 to FSelectedNodes.Count - 1 do
          begin
            if J = -1 then
              FList.Add(FSelectedNodes[I])
            else
            repeat
              C := CompareNodes(FSelectedNodes[I], FList[J]);
              if C <= 0 then
              begin
                if C < 0 then
                begin
                  FList.Insert(J, FSelectedNodes[I]);
                  Inc(J);
                end;
                Break;
              end;
              {else C > 0}
              Inc(J);
              if J >= FList.Count then
              begin
                FList.Add(FSelectedNodes[I]);
                J := -1;
                Break;
              end;
            until False;
          end;
        end;
        // copy from temp list
        FSelectedNodes.Count := FList.Count;
        System.Move(FList.List^, FSelectedNodes.List^, FList.Count * SizeOf(Pointer));
      finally
        FFirstSelectedNode := nil;
        FList.Free;
      end;
    finally
      EndUpdate;
    end;
  finally
    EndSelection;
  end;
end;

//private TdxTreeList
procedure TdxTreeList.CheckRefreshSorting;
begin
  if not FClearNodes and not (csDestroying in ComponentState) and IsAutoSortRefresh then
    if FLockUpdate = 0 then RefreshSorting
    else FNeededSortRefresh := True;
end;

function TdxTreeList.FindSelectedNode(Node: TdxTreeListNode; var Index: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;
  L := 0;
  H := FSelectedNodes.Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
//    C := CompareNodes(FSelectedNodes[I], Node);
    C := Integer(FSelectedNodes[I]) - Integer(Node);
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

function TdxTreeList.GetSortedColumn: TdxTreeListColumn;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to ColumnCount - 1 do
    if Columns[I].Sorted <> csNone then
    begin
      Result := Columns[I];
      Break;
    end;
  if IsMultiSort then
  begin
    if SortedColumnCount = 0 then
      AddSortedColumn(Result)
    else Result := SortedColumns[0];
  end;
end;

procedure TdxTreeList.ReadData(Stream: TStream);
var
  I, ItemCount: Integer;
begin
  ClearNodes;
  Stream.ReadBuffer(ItemCount, SizeOf(ItemCount));
  if ItemCount < 0 then // new format (version)
  begin
    FStreamVersion := ItemCount;
    Stream.ReadBuffer(ItemCount, SizeOf(ItemCount));
  end
  else
    FStreamVersion := 0; 
  for I := 0 to ItemCount - 1 do
    TdxTreeListTextNode(Add).ReadData(Stream);
end;

procedure TdxTreeList.WriteData(Stream: TStream);
var
  I: Integer;
begin
  // new format (version)
  I := -1;
  Stream.WriteBuffer(I, SizeOf(I));
  // count
  I := Count;
  Stream.WriteBuffer(I, SizeOf(I));
  for I := 0 to Count - 1 do
    TdxTreeListTextNode(Items[i]).WriteData(Stream);
end;

{ TdxTreeListEditStyle }
constructor TdxTreeListEditStyle.Create(AEdit: TdxInplaceEdit; ATreeList: TCustomdxTreeList);
begin
  inherited Create(AEdit);
  FTreeList := ATreeList; 
end;

function TdxTreeListEditStyle.DefaultBorderColor: TColor;
begin
  Result := TreeList.EditStyleBorderColor;
end;

function TdxTreeListEditStyle.DefaultBorderStyle: TdxEditBorderStyle;
begin
  Result := TreeList.EditStyleBorderStyle;
end;

function TdxTreeListEditStyle.DefaultButtonStyle: TdxEditButtonViewStyle;
begin
  Result := TreeList.EditStyleButtonStyle;
end;

function TdxTreeListEditStyle.DefaultButtonTransparence: TdxEditButtonTransparence;
begin
  Result := TreeList.EditStyleButtonTransparence;
end;

function TdxTreeListEditStyle.DefaultEdges: TdxEditEdges;
begin
  Result := TreeList.EditStyleEdges;
end;

function TdxTreeListEditStyle.DefaultHotTrack: Boolean;
begin
  Result := TreeList.EditStyleHotTrack;
end;

function TdxTreeListEditStyle.DefaultShadow: Boolean;
begin
  Result := TreeList.EditStyleShadow;
end;

{ TdxTreeListMaskColumn }
procedure TdxTreeListMaskColumn.Assign(Source: TPersistent);
begin
  if Source is TdxTreeListMaskColumn then
  begin
    if Assigned(TreeList) then TreeList.BeginUpdate;
    try
      inherited Assign(Source);
      EditMask := TdxTreeListMaskColumn(Source).EditMask;
    finally
      if Assigned(TreeList) then TreeList.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TdxTreeListMaskColumn.RestoreDefaults;
begin
  inherited RestoreDefaults;
  EditMask := '';
end;

function TdxTreeListMaskColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceTreeListMaskEdit;
end;

procedure TdxTreeListMaskColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceMaskEdit then
    with TdxInplaceTreeListMaskEdit(AInplaceEdit) do
    begin
      EditMask := Self.EditMask;
      IgnoreMaskBlank := Self.IgnoreMaskBlank;
    end;
end;

var
  FAntiBugImageList: HImageList;

initialization
  Classes.RegisterClasses([TdxTreeListColumn, TdxTreeListMaskColumn]);

  Screen.Cursors[crdxTreeListDeleteCursor] := LoadCursor(HInstance, dxTreeListDeleteCursor);
  Screen.Cursors[crdxTreeListFullScroll] := LoadCursor(HInstance, 'DXTL_FULLSCROLLCURSOR');
  Screen.Cursors[crdxTreeListHorScroll] := LoadCursor(HInstance, 'DXTL_HORSCROLLCURSOR');
  Screen.Cursors[crdxTreeListVerScroll] := LoadCursor(HInstance, 'DXTL_VERSCROLLCURSOR');
  Screen.Cursors[crdxTreeListUpScroll] := LoadCursor(HInstance, 'DXTL_UPSCROLLCURSOR');
  Screen.Cursors[crdxTreeListRightScroll] := LoadCursor(HInstance, 'DXTL_RIGHTSCROLLCURSOR');
  Screen.Cursors[crdxTreeListDownScroll] := LoadCursor(HInstance, 'DXTL_DOWNSCROLLCURSOR');
  Screen.Cursors[crdxTreeListLeftScroll] := LoadCursor(HInstance, 'DXTL_LEFTSCROLLCURSOR');
  Screen.Cursors[crdxTreeListDragCopy] := LoadCursor(HInstance, 'DXTL_DRAGCOPY');
  Screen.Cursors[crdxTreeListMultiDragCopy] := LoadCursor(HInstance, 'DXTL_MULTIDRAGCOPY');

  ScrollTimerID := -1;
  ScrollNodeTimerID := -1;
  ClickTimerID := -1;
  CreateBitmaps;

  sdxGrColumns := LoadStr(dxSColumnsCaption);
  sdxGrBandsCaption := LoadStr(dxSBandsCaption);
  sdxGrHeadersCaption := LoadStr(dxSHeadersCaption);

  FAntiBugImageList := ImageList_Create(1, 1, ILC_COLOR, 1, 1);

  TempDC := GetDC(0);

finalization

  ReleaseDC(0, TempDC);

  if FAntiBugImageList <> 0 then
  begin
    ImageList_Destroy(FAntiBugImageList);
    FAntiBugImageList := 0;
  end;

  DestroyBitmaps;
  {$IFDEF DELPHI4}
  DestroyCursor(Screen.Cursors[crdxTreeListDeleteCursor]);
  DestroyCursor(Screen.Cursors[crdxTreeListFullScroll]);
  DestroyCursor(Screen.Cursors[crdxTreeListHorScroll]);
  DestroyCursor(Screen.Cursors[crdxTreeListVerScroll]);
  DestroyCursor(Screen.Cursors[crdxTreeListUpScroll]);
  DestroyCursor(Screen.Cursors[crdxTreeListRightScroll]);
  DestroyCursor(Screen.Cursors[crdxTreeListDownScroll]);
  DestroyCursor(Screen.Cursors[crdxTreeListLeftScroll]);
  DestroyCursor(Screen.Cursors[crdxTreeListDragCopy]);
  DestroyCursor(Screen.Cursors[crdxTreeListMultiDragCopy]);
  {$ENDIF}

end.

