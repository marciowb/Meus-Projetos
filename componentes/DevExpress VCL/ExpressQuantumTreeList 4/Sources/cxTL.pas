
{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressQuantumTreeList                                       }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSQUANTUMTREELIST AND ALL        }
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

unit cxTL;

{$I cxVer.inc}

interface

uses
 {$IFDEF DELPHI6}
  Variants,
 {$ENDIF}
  Classes, SysUtils, Clipbrd, Windows, Messages,
  ExtCtrls, Controls, Forms, StdCtrls, Graphics, ImgList, ComCtrls, Math,
  dxCore, cxControls, cxGraphics, cxClasses, cxGeometry, cxStorage,
  cxCustomData, cxData, cxDataUtils, cxVariants, cxEdit, cxStyles,
  cxListBox, cxNavigator, cxInplaceContainer, cxLookAndFeels, cxLookAndFeelPainters,
  cxTLIntf, cxTLStrs, cxLibraryConsts;

const
  cxTLMajorVersion = '4';
  // default size values for treelist items
  cxTreeListDefWidth           = 100;
  cxTreeListDefMinWidth        = 20;
  // default values for treelist options view

  cxTreeListDefBandHeaderLineCount = 1;
  cxTreeListDefBands               = False;
  cxTreeListDefFooter              = False;
  cxTreeListDefColumnHeaders       = True;
  cxTreeListDefColumnAutoWidth     = False;
  cxTreeListDefIndicatorWidth      = 15;
  cxTreeListDefSeparatorWidth      = 2;
  cxTreeListDefDropArrowColor      = $00FF00;

  cxTreeListDefWaitExpandTime      = 500;

  // preview
  cxTreeListDefPreviewIndent       = 5;
  cxTreeListDefPreviewMaxLineCount = 3;

  // treelist styles predefined indexes

  tlcs_Header = ecs_EditContainerStylesMaxIndex + 1;
  tlcs_Footer = ecs_EditContainerStylesMaxIndex + 2;

  // for band styles
  tlbs_Content          = 0;
  tlbs_Footer           = 1;
  tlbs_Header           = 2;
  tlbs_HeaderBackground = 3;

  // for control styles
  tlsv_Content        = ecs_Content;
  tlsv_BandBackground = ecs_EditingStylesMaxIndex + 1;
  tlsv_BandContent    = ecs_EditingStylesMaxIndex + 2;
  tlsv_BandHeader     = ecs_EditingStylesMaxIndex + 3;
  tlsv_ColumnFooter   = ecs_EditingStylesMaxIndex + 4;
  tlsv_ColumnHeader   = ecs_EditingStylesMaxIndex + 5;
  tlsv_ContentEven    = ecs_EditingStylesMaxIndex + 6;
  tlsv_ContentOdd     = ecs_EditingStylesMaxIndex + 7;
  tlsv_Footer         = ecs_EditingStylesMaxIndex + 8;
  tlsv_HotTrack       = ecs_EditingStylesMaxIndex + 12; 
  tlsv_IncSearch      = ecs_EditingStylesMaxIndex + 9;
  tlsv_Indicator      = ecs_EditingStylesMaxIndex + 10;
  tlsv_Preview        = ecs_EditingStylesMaxIndex + 11;

  // base constants for descendants

  cxtlMaxControlStyleIndex = tlsv_Preview;
  cxtlMaxColumnStyleIndex  = tlcs_Footer;
  cxtlMaxBandStyleIndex    = tlbs_HeaderBackground;

  // base index for hitcodes bits

  tlhc_Base               = 4;
  tlhc_HitAtBand          = tlhc_Base;
  tlhc_HitAtBandContainer = tlhc_Base + 1;
  tlhc_HitAtBandHeader    = tlhc_Base + 2;
  tlhc_HitAtButton        = tlhc_Base + 3;
  tlhc_HitAtColumn        = tlhc_Base + 4;
  tlhc_HitAtColumnHeader  = tlhc_Base + 5;
  tlhc_HitAtFooter        = tlhc_Base + 6;
  tlhc_HitAtFooterItem    = tlhc_Base + 7;
  tlhc_HitAtIndent        = tlhc_Base + 17;
  tlhc_HitAtIndicator     = tlhc_Base + 8;
  tlhc_HitAtNode          = tlhc_Base + 9;
  tlhc_HitAtNodePreview   = tlhc_Base + 16;
  tlhc_HitAtSeparator     = tlhc_Base + 11;
  tlhc_HitAtSizingHorz    = tlhc_Base + 12;
  tlhc_HitAtSizingVert    = tlhc_Base + 13;
  tlhc_HitAtImage         = tlhc_Base + 14;
  tlhc_HitAtStateImage    = tlhc_Base + 15;
  tlhc_MaxIndex           = tlhc_HitAtSizingVert;

  // node state flags
  tlnsFocused          = $0001;
  tlnsDeleting         = $0002;
  tlnsHasChildren      = $0004;
  tlnsHasData          = $0008;
  tlnsCollapsed        = $0010;
  tlnsInternalCreating = $0080;
  tlnsIndexesInvalid   = $1000;
  tlnsRecreateList     = $2000;

  // events state
  tlesNone      = $0000;
  tlesChanged   = $0001;
  tlesSelection = $0002;

  // hit test and sizing constants
  cxtlHitDelta = 3;
  cxtlScrollDelta = 10;
  cxtlSizingMarkWidth = 1;

  // overs
  cxColumnTextSeparator = #9;
  cxLineSeparator       = #13#10;
  cxTreeListScrollWidthDragInterval = 50;
  cxTreeListIndentOffsetSize       = 6;
  cxTreeListEditCellContentOffset: TRect = (Left: 1; Top: 1; Right: 1; Bottom: 1);
  cxTreeListEditCellHeightOffset   = 2;
  cxTreeListDragDropTextAreaOffset: TPoint = (X: 20; Y:0);

type
  EcxTreeList = class(EdxException);

  TcxTreeListColumn = class;
  TcxTreeListColumnViewInfo = class;
  TcxTreeListColumnViewInfoClass = class of TcxTreeListColumnViewInfo;

  TcxTreeListBand = class;
  TcxTreeListBands = class;
  TcxTreeListBandRow = class;
  TcxTreeListBandRows = class;

  TcxTreeListOptionsBehavior = class;

  TcxTreeListOptionsCustomizing = class;
  TcxTreeListOptionsCustomizingClass = class of TcxTreeListOptionsCustomizing;

  TcxTreeListHitTest = class;

  TcxTreeListHeaderViewInfo = class;

  TcxTreeListBandViewInfo = class;
  TcxTreeListViewInfo = class;
  TcxTreeListViewInfoItem = class;
  TcxTreeListNodesViewInfo = class;
  TcxTreeListNodeViewInfo = class;
  TcxTreeListCellsGroupViewInfo = class;
  TcxTreeListEditCellViewInfo = class;
  TcxCustomViewInfoItemClass  = class of TcxCustomViewInfoItem;
  TcxTreeListNodeViewInfoClass = class of TcxTreeListNodeViewInfo;
  TcxTreeListNodesViewInfoClass = class of TcxTreeListNodesViewInfo;
  TcxTreeListViewInfoItemClass = class of TcxTreeListViewInfoItem;
  TcxTreeListIndentViewInfoClass = class of TcxTreeListIndentViewInfo;
  TcxTreeListEditCellViewInfoClass = class of TcxTreeListEditCellViewInfo;
  TcxTreeListCellsGroupViewInfoClass = class of TcxTreeListCellsGroupViewInfo;

  TcxTreeListOptionsView = class;

  TcxTreeListControlPainter = class;

  TcxTreeListNode = class;
  TcxTreeListNodes = class;
  TcxTreeListNodesClass = class of TcxTreeListNodes;

  TcxTreeListPreview = class;
  TcxTreeListPreviewClass = class of TcxTreeListPreview;
  TcxCustomTreeListControl = class;
  TcxTreeListCustomizing = class;

  TcxTreeListStyles = class;

  // overriding types
  PIntArray = ^TIntArray;
  PPointerList = Classes.PPointerList;

  TIntArray = array[0..MaxInt div SizeOf(Integer) - 1] of Integer;

  TcxTreeListBandFixedKind = (tlbfNone, tlbfLeft, tlbfRight);

  TcxTreeListGridLines = (tlglNone, tlglHorz, tlglVert, tlglBoth);

  TcxTreeListImageIndexType = (tlitImageIndex, tlitSelectedIndex, tlitStateIndex);
  TcxTreeListImageIndexes = set of TcxTreeListImageIndexType;

  TcxTreeListNodeAttachMode = (tlamAdd, tlamAddFirst, tlamAddChild, tlamAddChildFirst, tlamInsert);
  TcxTreeListNodeAddMode = (tlnaAdd, tlnaAddFirst, tlnaInsert);
  TcxTreeListNodeImageIndexes = array[TcxTreeListImageIndexType] of TImageIndex;

  TcxTreeListCompareFunc = function(AItem1, AItem2: TcxTreeListNode): Integer;

  TcxCachedContentParams = array[Boolean] of TcxViewParams;
  
  TcxTreeListFindFunc = function(ANode: TcxTreeListNode; AData: Pointer): Boolean;

  { TcxTreeListNodes}

  TcxTreeListNodes = class(TPersistent)
  private
    FFoundItem: TcxTreeListNode;
    FFocusedIndex: Integer;
    FMaxLevel: Integer;
    FOwner: TcxCustomTreeListControl;
    FRoot: TcxTreeListNode;
    FState: Integer;
    FVisibleCount: Integer;
    function GetAbsoluteItem(AFindIndex: Integer): TcxTreeListNode;
    function GetCount: Integer;
    function GetDataController: TcxControlDataController;
    function GetItem(AIndex: Integer): TcxTreeListNode;
    function GetMaxLevel: Integer;
    function GetNodesViewInfo: TcxTreeListNodesViewInfo;
    function GetState(Index: Integer): Boolean;
    function GetTopVisibleNode: TcxTreeListNode;
    function GetVisibleCount: Integer;
    procedure SetAbsoluteItem(Index: Integer; Value: TcxTreeListNode);
    procedure SetItem(AIndex: Integer; Value: TcxTreeListNode);
    procedure SetState(Index: Integer; Value: Boolean);
  protected
    TopIndex: Integer;
    TopNode: TcxTreeListNode;
    procedure CalculateInfo(IsLocked: Boolean); virtual;
    procedure Changed; virtual;
    procedure DoNodeChanged(ANode: TcxTreeListNode); virtual;
    class function FindBetween(AFirst, ALast: TcxTreeListNode; ACount, AIndex: Integer): TcxTreeListNode;
    function GetOwner: TPersistent; override;
    function GetVisibleNode(var AIndex: Integer): TcxTreeListNode; virtual;
    function InternalAddNode(ANode, ARelative: TcxTreeListNode; AddMethod: TcxTreeListNodeAttachMode): TcxTreeListNode;
    procedure SetNodeParent(ANewNode, ANewParent: TcxTreeListNode; AMode: TcxTreeListNodeAddMode);
    procedure SetTopVisibleIndex(AIndex: Integer);
    property DataController: TcxControlDataController read GetDataController;
    property FocusedIndex: Integer read FFocusedIndex write FFocusedIndex;
    property NodesViewInfo: TcxTreeListNodesViewInfo read GetNodesViewInfo;
    property State: Integer read FState write FState;
    property IsInvalidState: Boolean index tlnsIndexesInvalid read GetState write SetState;
    property IsInternalCreating: Boolean index tlnsInternalCreating read GetState write SetState;
  public
    constructor Create(AOwner: TcxCustomTreeListControl); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property Root: TcxTreeListNode read FRoot;
    property Count: Integer read GetCount;
    property AbsoluteItems[AbsoluteIndex: Integer]: TcxTreeListNode read GetAbsoluteItem write SetAbsoluteItem;
    property Items[Index: Integer]: TcxTreeListNode read GetItem write SetItem; default;
    property TopVisibleNode: TcxTreeListNode read GetTopVisibleNode;
    property TreeList: TcxCustomTreeListControl read FOwner;
    property VisibleCount: Integer read GetVisibleCount;
    property MaxLevel: Integer read GetMaxLevel;
  end;

  { TcxTreeListNode }

  TcxTreeListNode = class(TPersistent, IUnknown, IcxDragSizing)
  private
    FCount: Integer;
    FData: Pointer;
    FFirst: TcxTreeListNode;
    FIndex: Integer;
    FLast: TcxTreeListNode;
    FNext: TcxTreeListNode;
    FOwner: TcxTreeListNodes;
    FParent: TcxTreeListNode;
    FPrev: TcxTreeListNode;
    FRecordIndex: Integer;
    FState: Integer;
    function GetAbsoluteIndex: Integer;
    function GetDataController: TcxControlDataController;
    function GetExpanded: Boolean;
    function GetFocused: Boolean;
    function GetHasChildren: Boolean;
    function GetHotTrack: Boolean;
    function GetIsDeleting: Boolean;
    function GetIsFirst: Boolean;
    function GetIsGroupNode: Boolean;
    function GetIsLast: Boolean;
    function GetIsVisible: Boolean;
    function GetItem(AIndex: Integer): TcxTreeListNode;
    function GetLevel: Integer;
    function GetSelected: Boolean;
    function GetNodeImageIndex(AIndex: Integer): TImageIndex;
    function GetText(Index: Integer): string;
    function GetTreeList: TcxCustomTreeListControl;
    function GetValue(AIndex: Integer): Variant;
    function GetValueCount: Integer;
    function GetVisibleIndex: Integer;
    procedure AdjustIndexes(ANode: TcxTreeListNode; AIndex: Integer);
    procedure InternalInsert(Value: TcxTreeListNode);
    procedure InternalRemove(Value: TcxTreeListNode);
    procedure SetExpanded(Value: Boolean);
    procedure SetFirst(Value: TcxTreeListNode);
    procedure SetFocused(Value: Boolean);
    procedure SetHasChildren(Value: Boolean);
    procedure SetItem(AIndex: Integer; Value: TcxTreeListNode);
    procedure SetLast(Value: TcxTreeListNode);
    procedure SetNodeImageIndex(AIndex: Integer; Value: TImageIndex);
    procedure SetParentFor(Value: TcxTreeListNode);
    procedure SetText(AIndex: Integer; const AValue: string);
    procedure SetSelected(Value: Boolean);
    procedure SetValue(AIndex: Integer; const AValue: Variant);
  protected
    FImageIndexes: TcxTreeListNodeImageIndexes;
    FVisibleIndex: Integer;
    function AddDataControllerRecord: Integer; virtual;
    procedure DoReadNodeData(AReader: TcxReader); virtual;
    procedure DoWriteNodeData(AWriter: TcxWriter); virtual;
    function GetIsFirstVisible: Boolean; virtual;
    function GetIsLastVisible: Boolean; virtual;
    function GetNextVisibleEx(IsPrev: Boolean): TcxTreeListNode;
    function GetNextSiblingEx(ANode: TcxTreeListNode; AForward: Boolean): TcxTreeListNode;
    function GetOwner: TPersistent; override;
    function GetRootParent: TcxTreeListNode;
    procedure ReadData(AStream: TStream); virtual;
    procedure WriteData(AStream: TStream); virtual;
    // IcxDragSizing
    function CanSizing(ADirection: TcxDragSizingDirection): Boolean;
    function GetSizingBoundsRect(ADirection: TcxDragSizingDirection): TRect;
    function GetSizingIncrement(ADirection: TcxDragSizingDirection): Integer;
    function IsDynamicUpdate: Boolean;
    procedure SetSizeDelta(ADirection: TcxDragSizingDirection; ADelta: Integer);
    // IUnknown
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    property DataController: TcxControlDataController read GetDataController;
    property State: Integer read FState write FState;
  public
    constructor Create(AOwner: TcxTreeListNodes); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure AssignValues(const AValues:{$IFDEF DELPHI5} array of {$ENDIF} Variant);
    function AddChild: TcxTreeListNode; virtual;
    function AddChildFirst: TcxTreeListNode; virtual;
    procedure AlphaSort(ARecurse: Boolean = False);
    function CanCollapse: Boolean;
    function CanExpand: Boolean;
    function CanMove(ADest: TcxTreeListNode; AMode: TcxTreeListNodeAttachMode): Boolean;
    procedure Collapse(Recurse: Boolean);
    procedure CustomSort(ASortProc: TcxTreeListCompareFunc; ARecurse: Boolean = False);
    procedure Delete;
    procedure DeleteChildren;
    function DisplayRect(AEntryOnly: Boolean): TRect;
    procedure EndEdit(Cancel: Boolean);
    procedure Expand(Recurse: Boolean);
    function GetNext: TcxTreeListNode;
    function GetNextChild(Value: TcxTreeListNode): TcxTreeListNode;
    function getNextSibling: TcxTreeListNode; {GetNextSibling conflicts with C++ macro}
    function GetNextVisible: TcxTreeListNode;
    function GetPrev: TcxTreeListNode;
    function GetPrevChild(Value: TcxTreeListNode): TcxTreeListNode;
    function getPrevSibling: TcxTreeListNode; {GetPrevSibling conflicts with a C++ macro}
    function GetPrevVisible: TcxTreeListNode;
    function getFirstChild: TcxTreeListNode;  {GetFirstChild conflicts with C++ macro}
    function GetLastChild: TcxTreeListNode;
    //
    function HasAsParent(Value: TcxTreeListNode): Boolean;
    function IndexOf(Value: TcxTreeListNode): Integer;
    function InsertChild(ABeforeNode: TcxTreeListNode): TcxTreeListNode; virtual;
    procedure MakeVisible;
    procedure MoveTo(ADestNode: TcxTreeListNode; AMode: TcxTreeListNodeAttachMode); virtual;
    procedure Repaint(ARecalculate: Boolean); virtual;
    property AbsoluteIndex: Integer read GetAbsoluteIndex;
    property Count: Integer read FCount;
    property Data: Pointer read FData write FData;
    property Deleting: Boolean read GetIsDeleting;
    property Expanded: Boolean read GetExpanded write SetExpanded;
    property Focused: Boolean read GetFocused write SetFocused;
    property HasChildren: Boolean read GetHasChildren write SetHasChildren;
    property HotTrack: Boolean read GetHotTrack;
    property ImageIndex: TImageIndex index 0 read GetNodeImageIndex write SetNodeImageIndex;
    property Index: Integer read FIndex;
    property IsFirst: Boolean read GetIsFirst;
    property IsFirstVisible: Boolean read GetIsFirstVisible;
    property IsGroupNode: Boolean read GetIsGroupNode;
    property IsLast: Boolean read GetIsLast;
    property IsLastVisible: Boolean read GetIsLastVisible;
    property IsVisible: Boolean read GetIsVisible;
    property Items[Index: Integer]: TcxTreeListNode read GetItem write SetItem; default;
    property Level: Integer read GetLevel;
    property Owner: TcxTreeListNodes read FOwner;
    property Parent: TcxTreeListNode read FParent;
    property RecordIndex: Integer read FRecordIndex write FRecordIndex;
    property Selected: Boolean read GetSelected write SetSelected;
    property SelectedIndex: TImageIndex index 1 read GetNodeImageIndex write SetNodeImageIndex;
    property StateIndex: TImageIndex index 2 read GetNodeImageIndex write SetNodeImageIndex;
    property Texts[Index: Integer]: string read GetText write SetText;
    property TreeList: TcxCustomTreeListControl read GetTreeList;
    property ValueCount: Integer read GetValueCount;
    property Values[Index: Integer]: Variant read GetValue write SetValue;
    property VisibleIndex: Integer read GetVisibleIndex;
  end;

  { TcxTreeListRootNode }

  TcxTreeListRootNode = class(TcxTreeListNode)
  protected
    function AddDataControllerRecord: Integer; override;
  end;

  { TcxUnboundTreeListNode }

  TcxUnboundTreeListNode = class(TcxTreeListNode)
  protected
    procedure ReadData(AStream: TStream); override;
    procedure WriteData(AStream: TStream); override;
  public
    constructor Create(AOwner: TcxTreeListNodes); override;
    procedure Assign(Source: TPersistent); override;
  end;

  { TcxTreeListColumnStyles }

  TcxTreeListColumnStyles = class(TcxEditContainerStyles)
  private
    function GetBand: TcxTreeListBand;
    function GetTreeList: TcxCustomTreeListControl;
  protected
    ContentParams: TcxCachedContentParams;
    procedure CachedContentStyleChanged;
    property Band: TcxTreeListBand read GetBand;
    property TreeList: TcxCustomTreeListControl read GetTreeList;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Header: TcxStyle index tlcs_Header read GetValue write SetValue;
    property Footer: TcxStyle index tlcs_Footer read GetValue write SetValue;
    property Content;
  end;

  { TcxTreeListColumnPosition }

  TcxTreeListColumnPosition = class(TcxOwnedPersistent)
  private
    FBandIndex: Integer;
    FColIndex: Integer;
    FLineCount: Integer;
    FRowIndex: Integer;
    function GetBandIndex: Integer;
    function GetColumn: TcxTreeListColumn;
    function GetOwnerBandVisibleIndex: Integer;
    function GetTreeList: TcxCustomTreeListControl;
    procedure SetBandIndex(Index: Integer);
    procedure SetColIndex(Value: Integer);
    procedure SetLineCount(Value: Integer);
    procedure SetRowIndex(Value: Integer);
  protected
    procedure Changed; virtual;
    function GetBandFromIndex(AIndex: Integer): TcxTreeListBand;
    procedure Save; virtual;
    procedure Load; virtual;
    property Column: TcxTreeListColumn read GetColumn;
    property OwnerBandVisibleIndex: Integer read GetOwnerBandVisibleIndex;
    property TreeList: TcxCustomTreeListControl read GetTreeList;
  public
    constructor Create(AOwner: TPersistent); override;
    procedure Assign(Source: TPersistent); override;
    procedure SetPosition(AColIndex, ARowIndex: Integer; IsInsertRow: Boolean = False);
    procedure SetPositionEx(ABandIndex, AColIndex, ARowIndex: Integer; IsInsertRow: Boolean = False);
  published
    property ColIndex: Integer read FColIndex write SetColIndex;
    property LineCount: Integer read FLineCount write SetLineCount default 1;
    property RowIndex: Integer read FRowIndex write SetRowIndex;
    property BandIndex: Integer read GetBandIndex write SetBandIndex;
  end;

  TcxTreeListColumnPositionClass = class of TcxTreeListColumnPosition;

  { TcxTreeListCaption }

  TcxTreeListCaption = class(TcxOwnedPersistent)
  private
    FAlignHorz: TAlignment;
    FAlignVert: TcxAlignmentVert;
    FGlyph: TBitmap;
    FGlyphAlignHorz: TAlignment;
    FGlyphAlignVert: TcxAlignmentVert;
    FText: string;
    FTreeList: TcxCustomTreeListControl;
    FState: Integer;
    FViewInfo: TcxTreeListViewInfoItem;
    procedure SetAlignHorz(Value: TAlignment);
    procedure SetAlignVert(Value: TcxAlignmentVert);
    procedure SetGlyph(Value: TBitmap);
    procedure SetGlyphAlignHorz(Value: TAlignment);
    procedure SetGlyphAlignVert(Value: TcxAlignmentVert);
    procedure SetText(const Value: string);
  protected
    procedure Changed; virtual;
    function GetState(Index: Integer): Boolean;
    function GetText: string; virtual;
    function IsTextStored: Boolean; virtual;
    procedure SetState(Index: Integer; Value: Boolean);
    property TreeList: TcxCustomTreeListControl read FTreeList;
  public
    constructor Create(AOwner: TPersistent); override;
    constructor CreateEx(ATreeList: TcxCustomTreeListControl;
      AOwner: TPersistent; AViewInfo: TcxTreeListViewInfoItem); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property AlignHorz: TAlignment read FAlignHorz write SetAlignHorz default taLeftJustify;
    property AlignVert: TcxAlignmentVert read FAlignVert write SetAlignVert default vaTop;
    property Glyph: TBitmap read FGlyph write SetGlyph;
    property GlyphAlignHorz: TAlignment read FGlyphAlignHorz write SetGlyphAlignHorz default taLeftJustify;
    property GlyphAlignVert: TcxAlignmentVert read FGlyphAlignVert write SetGlyphAlignVert default vaTop;
    property MultiLine: Boolean index 2 read GetState write SetState default False;
    property ShowEndEllipsis: Boolean index 1 read GetState write SetState default True;
    property Text: string read GetText write SetText stored IsTextStored;
  end;

  { TcxTreeListColumnOptions }

  TcxTreeListColumnOptions = class(TcxCustomEditContainerItemOptions)
  private
    FState: Integer;
    FHidden: Boolean;
  protected
    procedure Changed; override;
    function GetValue(Index: Integer): Boolean;
    procedure SetValue(Index: Integer; const Value: Boolean);
  public
    constructor Create(AOwner: TPersistent); override;
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; virtual;
  published
    property CellEndEllipsis: Boolean index 1 read GetValue write SetValue default True;
    property Sizing: Boolean index 2 read GetValue write SetValue default True;
    property Footer: Boolean index 3 read GetValue write SetValue default False;
    property Hidden: Boolean read FHidden write FHidden default False;
    property Customizing;
    property Editing; 
    property Focusing;
    property IncSearch;
    property Moving;
    property ShowEditButtons;
    property Sorting;
    property TabStop;
  end;

    { TcxTreeListColumnSummaryFooter }

  TcxTreeListColumnSummaryFooter = class(TcxOwnedInterfacedPersistent)
  private
    FAlignHorz: TAlignment;
    FAlignVert: TcxAlignmentVert;
    FFormat: string;
    FMultiLine: Boolean;
    function GetColumn: TcxTreeListColumn;
    function GetDataController: TcxCustomDataController;
    function GetFormat: string;
    function GetSummaryItem: TcxDataSummaryItem;
    function GetSummaryKind: TcxSummaryKind;
    function GetSummaryText: string;
    function GetSummaryValue: Variant;
    procedure SetAlignHorz(Value: TAlignment);
    procedure SetAlignVert(Value: TcxAlignmentVert);
    procedure SetFormat(const Value: string);
    procedure SetMultiLine(Value: Boolean);
    procedure SetSummaryText(const Value: string);
    procedure SetSummaryValue(const Value: Variant);
    procedure SetSummaryKind(Value: TcxSummaryKind);
  protected
    ItemIndex: Integer;
    function IsFormatStored: Boolean;
    function IsSummaryItemValid: Boolean;
    function Summary: TcxDataSummary;
    procedure SummaryItemChanged; virtual;
    function SummaryItemIndex: Integer;
    function SummaryItems: TcxDataFooterSummaryItems;
    property DataController: TcxCustomDataController read GetDataController;
  public
    procedure Assign(Source: TPersistent); override;
    property Column: TcxTreeListColumn read GetColumn;
    property SummaryItem: TcxDataSummaryItem read GetSummaryItem;
    property SummaryText: string read GetSummaryText write SetSummaryText;
    property SummaryValue: Variant read GetSummaryValue write SetSummaryValue;
  published
    property Format: string read GetFormat write SetFormat stored IsFormatStored;
    property Kind: TcxSummaryKind read GetSummaryKind write SetSummaryKind default skNone;
    property AlignHorz: TAlignment read FAlignHorz write SetAlignHorz default taLeftJustify;
    property AlignVert: TcxAlignmentVert read FAlignVert write SetAlignVert default vaTop;
    property MultiLine: Boolean read FMultiLine write SetMultiLine default False;
  end;

  TcxTreeListColumnSummaryFooterClass = class of TcxTreeListColumnSummaryFooter;

  { TcxTreeListColumn }

  TcxTreeListOnGetDisplayTextEvent = procedure(Sender: TcxTreeListColumn;
    ANode: TcxTreeListNode; var Value: string) of object;
  TcxTreeListGetEditPropertiesEvent = procedure(Sender: TcxTreeListColumn;
    ANode: TcxTreeListNode; var EditProperties: TcxCustomEditProperties) of object;

  TcxTreeListColumn = class(TcxCustomInplaceEditContainer, IUnknown, IcxDragSizing, IcxTreeListIndexedItem, IcxStoredObject)
  private
    FCaption: TcxTreeListCaption;
    FCalculatedWidth: Integer;
    FData: Integer;
    FIsWidthAssigned: Boolean;
    FMinWidth: Integer;
    FOnChangeName: TNotifyEvent;
    FOwnerBand: TcxTreeListBand;
    FPosition: TcxTreeListColumnPosition;
    FSortOrder: TcxDataSortOrder;
    FState: Integer;
    FSummaryFooter: TcxTreeListColumnSummaryFooter;
    FViewInfo: TcxTreeListColumnViewInfo;
    FVisibleIndexAtBand: Integer;
    FWidth: Integer;
    FOnGetDisplayText: TcxTreeListOnGetDisplayTextEvent;
    function GetDataBinding: TcxItemDataBinding;
    function GetDisplayText(Index: Integer): string;
    function GetDisplayWidth: Integer;
    function GetEditingProperties: TcxTreeListGetEditPropertiesEvent;
    function GetEditProperties: TcxTreeListGetEditPropertiesEvent;
    function GetIndentWidth: Integer;
    function GetIsFixed: Boolean;
    function GetIsHidden: Boolean;
    function GetIsLeft: Boolean;
    function GetIsLeftMost: Boolean;
    function GetIsRightMost: Boolean;
    function GetIsPreview: Boolean;
    function GetIsRight: Boolean;
    function GetIsWidthStored: Boolean;
    function GetOptions: TcxTreeListColumnOptions;
    function GetOwnerBandRow: TcxTreeListBandRow;
    function GetRealMinWidth: Integer;
    function GetRealWidth: Integer;
    function GetStyles: TcxTreeListColumnStyles;
    function GetTreeList: TcxCustomTreeListControl;
    function GetVisible: Boolean;
    function GetVisibility: Boolean;
    function GetWidth: Integer;
    procedure SetCaption(Value: TcxTreeListCaption);
    procedure SetDataBinding(Value: TcxItemDataBinding);
    procedure SetEditingProperties(Value: TcxTreeListGetEditPropertiesEvent);
    procedure SetEditProperties(Value: TcxTreeListGetEditPropertiesEvent);
    procedure SetIsPreview(Value: Boolean);
    procedure SetMinWidth(Value: Integer);
    procedure SetOptions(Value: TcxTreeListColumnOptions);
    procedure SetOwnerBand(Value: TcxTreeListBand);
    procedure SetPosition(Value: TcxTreeListColumnPosition);
    procedure SetSorted(Value: TcxDataSortOrder);
    procedure SetStyles(Value: TcxTreeListColumnStyles);
    procedure SetSummaryFooter(Value: TcxTreeListColumnSummaryFooter);
    procedure SetVisible(Value: Boolean);
    procedure SetWidth(Value: Integer);
  protected
    // container metods
    procedure DoSizeChanged; virtual;
    function CanInitEditing: Boolean; override;
    function CanMoving: Boolean; virtual;
    function CanFocus: Boolean; override;
    function CanSorted: Boolean; virtual;
    function GetHeaderFooterBestfitSize: Integer; virtual;
    function GetOptionsClass: TcxCustomEditContainerItemOptionsClass; override;
    function GetRealSortOrder: TcxDataSortOrder; virtual;
    function GetState(Index: Integer): Boolean;
    function GetStylesClass: TcxEditContainerStylesClass; override;
    function GetSummaryFooterClass: TcxTreeListColumnSummaryFooterClass; virtual;
    procedure SetEditingControl(Value: TcxEditingControl); override;
    procedure SetName(const Value: TComponentName); override;
    procedure SetParentComponent(Value: TComponent); override;
    procedure SetState(Index: Integer; Value: Boolean);
    // IcxTreeListDragSizing implementation
    function CanSizing(ADirection: TcxDragSizingDirection): Boolean; virtual;
    function GetAvailableMaxWidth: Integer; virtual;
    function GetRealMinSize: Integer;
    function GetSizingBoundsRect(ADirection: TcxDragSizingDirection): TRect; virtual;
    function GetSizingIncrement(ADirection: TcxDragSizingDirection): Integer; virtual;
    function IsDynamicUpdate: Boolean; virtual;
    procedure SetSizeDelta(ADirection: TcxDragSizingDirection; ADelta: Integer); virtual;
    // IcxTreeListIndexedItem
    function GetItemIndex: Integer;
    function GetVisibleIndex: Integer;
    procedure SetItemIndex(Value: Integer);
    procedure SetVisibleIndex(Value: Integer);
    // IcxStoredObject
    function GetObjectName: string;
    function GetProperties(AProperties: TStrings): Boolean; virtual;
    function GetPropertyIndex(const AName: string): Integer;
    procedure GetPropertyValue(const AName: string; var AValue: Variant); virtual;
    procedure SetPropertyValue(const AName: string; const AValue: Variant); virtual;
    // column metods
    procedure DoGetDisplayText(ARecordIndex: Integer; var AText: string); override;
    function DoGetNodeDisplayText(ANode: TcxTreeListNode; const AValue: Variant): Variant; virtual;
    function DoOnGetDisplayText(ANode: TcxTreeListNode; AsText: Boolean = False;
      AValueOnly: Boolean = False): Variant; virtual;
    procedure DoVisibilityChanged; virtual;
    function GetCellHeight(ANode: TcxTreeListNode; AWidth, ALines: Integer;
      AFont: TFont; const AValue: Variant): Integer;
    function GetPositionClass: TcxTreeListColumnPositionClass; virtual;
    function GetViewInfoClass: TcxTreeListColumnViewInfoClass; virtual;
    function HasDataTextHandler: Boolean; override;
    procedure InitAutoWidthItem(AItem: TcxAutoWidthItem); virtual;
    procedure InternalSetBandOwner(ABand: TcxTreeListBand; RemoveFromOwner: Boolean); virtual;
    function IsBandAssigned: Boolean;
    procedure PositionChanged;
    procedure UpdateIndexesBeforeRemove;

    property Data: Integer read FData write FData;
    property IsFixed: Boolean read GetIsFixed; 
    property ViewInfo: TcxTreeListColumnViewInfo read FViewInfo;
    property Controller;
    property EditingControl;
    property EditViewData;
    property OnChangeName: TNotifyEvent read FOnChangeName write FOnChangeName;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure ApplyBestFit;
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;
    procedure MakeVisible;
    procedure RestoreDefaults; virtual;
    procedure RestoreWidths; virtual;
    property DisplayTexts[Index: Integer]: string read GetDisplayText;
    property DisplayWidth: Integer read GetDisplayWidth;
    property IndentWidth: Integer read GetIndentWidth;
    property IsHidden: Boolean read GetIsHidden;
    property IsLeft: Boolean read GetIsLeft;
    property IsLeftMost: Boolean read GetIsLeftMost;
    property IsRightMost: Boolean read GetIsRightMost;
    property IsPreview: Boolean read GetIsPreview write SetIsPreview;
    property IsRight: Boolean read GetIsRight;
    property OwnerBand: TcxTreeListBand read FOwnerBand write SetOwnerBand;
    property OwnerBandRow: TcxTreeListBandRow read GetOwnerBandRow;
    property PropertiesValue;
    property RealMinWidth: Integer read GetRealMinWidth;
    property RealWidth: Integer read GetRealWidth;
    property TreeList: TcxCustomTreeListControl read GetTreeList;
    property Visibility: Boolean read GetVisibility;
    property VisibleIndex: Integer read GetVisibleIndex;
    property VisibleIndexAtBand: Integer read FVisibleIndexAtBand;
    property Editing;
    property EditValue;
    property Focused;
    property ItemIndex read GetItemIndex write SetItemIndex;
    property Value;
    property ValueCount;
    property Values;
  published
    property Visible: Boolean read GetVisible write SetVisible default True;
    property Caption: TcxTreeListCaption read FCaption write SetCaption;
    property DataBinding: TcxItemDataBinding read GetDataBinding write SetDataBinding;
    property MinWidth: Integer read FMinWidth write SetMinWidth default cxTreeListDefMinWidth;
    property Options: TcxTreeListColumnOptions read GetOptions write SetOptions;
    property Width: Integer read GetWidth write SetWidth stored GetIsWidthStored;
    property Position: TcxTreeListColumnPosition read FPosition write SetPosition;
    property SortOrder: TcxDataSortOrder read FSortOrder write SetSorted default soNone;
    property Styles: TcxTreeListColumnStyles read GetStyles write SetStyles;
    property SummaryFooter: TcxTreeListColumnSummaryFooter read FSummaryFooter write SetSummaryFooter;
    property OnGetDisplayText: TcxTreeListOnGetDisplayTextEvent read FOnGetDisplayText write FOnGetDisplayText;
    property OnGetEditingProperties: TcxTreeListGetEditPropertiesEvent read GetEditingProperties write SetEditingProperties;
    property OnGetEditProperties: TcxTreeListGetEditPropertiesEvent read GetEditProperties write SetEditProperties;
    property PropertiesClassName;
    property Properties;
    property PropertiesEvents;
    property RepositoryItem;
  end;

  TcxTreeListColumnClass = class of TcxTreeListColumn;

  { TcxTreeListDragAndDropObject }

  TcxTreeListDragDropInfo = class
  public
    DropPos: TPoint;
    Accepted: Boolean;
  end;

  TcxTreeListDragDropInfoClass = class of TcxTreeListDragDropInfo;

  TcxTreeListHeaderDragDropInfo = class(TcxTreeListDragDropInfo)
  public
    DropBand: TcxTreeListBand;
    DropViewInfo: TcxTreeListHeaderViewInfo;
    IsInsertRow: Boolean;
    ColIndex: Integer;
    RowIndex: Integer;
  end;

  TcxTreeListDragAndDropObject = class(TcxCustomControlDragAndDropObject)
  private
    function CanDropHeaderObject: Boolean;
    function GetDragBand: TcxTreeListBand;
    function GetDragColumn: TcxTreeListColumn;
    function GetDragItem: TObject;
    function GetHitTest: TcxTreeListHitTest;
    function GetPainter: TcxTreeListControlPainter;
    function GetTreeList: TcxCustomTreeListControl;
    procedure InitDropBandInfo;
    procedure InitDropColumnInfo;
  protected
    ScreenArrows: TcxPlaceArrows;
    DragDropInfo: TcxTreeListDragDropInfo;
    PrevColIndex: Integer;
    ArrowBaseLine: TRect;
    procedure BeginDragAndDrop; override;
    function CanCustomizing: Boolean;
    function GetDisplayRect: TRect; override;
    function GetDragAndDropCursor(Accepted: Boolean): TCursor; override;
    procedure ChangeArrowPos(const ABaseLine: TRect; AllowHide: Boolean);
    function CheckCustomizingBox(const APos: TPoint): Boolean;
    function CheckDropPos(ADragIndex, ADropIndex, DragX, DropX: Integer;
      var APos: Integer; var ASide: TcxBorder; ACheckIndex: Boolean = True): Boolean;
    procedure DoDrawHeaderItem(AItem: TcxTreeListHeaderViewInfo);
    procedure DoDrawArrows;
    procedure DragAndDrop(const P: TPoint; var Accepted: Boolean); override;
    procedure DropHeaderItem; virtual;
    procedure DropNodes; virtual;
    procedure EndDragAndDrop(Accepted: Boolean); override;
    function GetAcceptedRect: TRect; override;
    function GetArrowBaseLine(const ARect: TRect; ASide: TcxBorder): TRect;
    procedure GetArrowRects(out R1, R2: TRect);
    function GetDragDropInfoClass: TcxTreeListDragDropInfoClass; virtual;
    procedure InitDropHeaderInfo; virtual;
    procedure InitDropInfo(const P: TPoint); virtual;
    function IsValidForDrop(AIndex, ADropIndex: Integer; PosIsGreater: Boolean): Boolean;
    procedure Paint; override;
    procedure RestoreArrows;
    procedure RestorePosition;
    procedure StorePosition;
    property DragItem: TObject read GetDragItem;
    property Painter: TcxTreeListControlPainter read GetPainter;
  public
    destructor Destroy; override;
    function IsDragBand: Boolean;
    function IsDragColumn: Boolean;
    property DragBand: TcxTreeListBand read GetDragBand;
    property DragColumn: TcxTreeListColumn read GetDragColumn;
    property HitTest: TcxTreeListHitTest read GetHitTest;
    property TreeList: TcxCustomTreeListControl read GetTreeList;
  end;

  { TcxTreeListCellNavigator }

  TcxTreeListCellNavigator = class(TcxCustomCellNavigator)
  private
    function GetCellIndex(AColumn: TcxTreeListColumn; ABandRow: TcxTreeListBandRow): Integer;
    function GetFocusedNode: TcxTreeListNode;
    function GetTreeList: TcxCustomTreeListControl;
    function GoToNextCellInBand(AForward: Boolean; AColumn: TcxTreeListColumn; var ACellIndex: Integer): Boolean;
    function GoToNextNodeCell(AForward: Boolean; ANode: TcxTreeListNode; AColumn: TcxTreeListColumn; var ACellIndex: Integer): Boolean;
  protected
    procedure AppendRecord(var ARowIndex, ACellIndex: Integer);
    procedure CalcNextRow(AForward: Boolean; var ARowIndex, ACellIndex: Integer); override;
    function GetCount(ARecordIndex: Integer): Integer; override;
    function GetCellContainer(ARowIndex, ACellIndex: Integer): TcxCustomInplaceEditContainer; override;
    procedure Init(var ARowIndex, ACellIndex, ARowCount: Integer); override;
    function IsGroupRow(ARowIndex: Integer): Boolean;
    function SelectCell(AForward, ANextRow: Boolean;
      var ARowIndex, ACellIndex: Integer): TcxCustomInplaceEditContainer; override;
    procedure SetFocusCell(ARowIndex, ACellIndex: Integer; AShift: TShiftState); override;
    property TreeList: TcxCustomTreeListControl read GetTreeList;
    property FocusedNode: TcxTreeListNode read GetFocusedNode;
  public
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Refresh; override;
  end;

  { TcxTreeListController }

  TcxTreeListController = class(TcxCustomControlController)
  private
    function GetDataController: TcxControlDataController;
    function GetFocusedNode: TcxTreeListNode;
    function GetHitTest: TcxTreeListHitTest;
    function GetIsControllerEvent: Boolean;
    function GetOptionsBehavior: TcxTreeListOptionsBehavior;
    function GetSelection: TList;
    function GetSelectionAnchor: TcxTreeListNode;
    function GetTreeList: TcxCustomTreeListControl;
    procedure SetIsControllerEvent(Value: Boolean);
    procedure SetFocusedNode(ANode: TcxTreeListNode);
  protected
    BlockFocusChanged: Boolean;
    DragNodesList: TList;
    DragColumn: TcxTreeListColumn;
    DragNode: TcxTreeListNode;
    ForceFocusedRecord: Integer;
    ForceWidthItem: TObject;
    PrevTopVisibleIndex: Integer;
    PrevHotShift, CurrentShiftState: TShiftState;
    IncSearchText: string;
    IncSearchNode: TcxTreeListNode;
    IsControllerEventRefCount: Integer;
    IsDragDropProcess: Boolean;
    IsInIncSearchChanging: Boolean;
    IsShiftPressed: Boolean;
    PrevCursor: TCursor;
    ResizeDirection: TcxDragSizingDirection;
    SelectionAnchorNode: TcxTreeListNode;
    ShowEditOnMouseUp: Boolean;
    HotTrackNode: TcxTreeListNode;
    // DragDrop fields
    ExpandingNode: TcxTreeListNode;
    ExpandTimer: TTimer;
    ScrollControllers: array[TcxBorder] of TcxAutoScrollingObject;
    procedure BeforeShowEdit; override;
    function CanHandleDeleteRecordKeys: Boolean; override;
    procedure CheckEdit; override;
    function CheckAutoScrolling(const APoint: TPoint): Boolean; virtual;
    procedure CheckHitItemOnMouseDown(X, Y: Integer; Shift: TShiftState); virtual;
    procedure SetFocusedRecordIndex(Value: Integer); override;
    // Drag drop
    procedure BeforeStartDrag; override;
    procedure CheckButtonTimer; virtual;
    procedure DragDrop(Source: TObject; X, Y: Integer); override;
    procedure DragEnter; virtual;
    procedure DragLeave; virtual;
    procedure DragMove(Source: TObject; const P: TPoint; var Accepted: Boolean); virtual;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean); override;
    procedure DropTo(ANode: TcxTreeListNode; AsChildren: Boolean); virtual;
    procedure EndDrag(Target: TObject; X, Y: Integer); override;
    procedure OnExpandTimer(Sender: TObject); virtual;
    procedure ResetButtonTimer;
    //

    procedure DoChangeColumnSortOrder(AColumn: TcxTreeListColumn;
      ASortOrder: TcxDataSortOrder; AShift: TShiftState); virtual;
    procedure DoNextNode(AForward: Boolean);
    procedure DoNextPage(AForward: Boolean; Shift: TShiftState); override;
    procedure DoShowNextPageEx(AGoForward, ASetCursor: Boolean;
      AShift: TShiftState); virtual;
    procedure FocusedRecordChanged(APrevFocusedRecordIndex, AFocusedRecordIndex: Integer); override;
    procedure FocusedItemChanged(APrevFocusedItem: TcxCustomInplaceEditContainer); override;
    function IsDragMode: Boolean;
    function IsKeyForController(AKey: Word; AShift: TShiftState): Boolean; override;
    function IsNodeKeyHandle(ANode: TcxTreeListNode;
      var AKey: Word; Shift: TShiftState): Boolean; virtual;
    function GetCellFromViewInfo(AColumn: TcxTreeListColumn; ANodeViewInfo: TcxTreeListNodeViewInfo): TcxTreeListEditCellViewInfo; virtual;
    function GetCellFromViewInfoEx(AColumn: TcxTreeListColumn; ANode: TcxTreeListNode): TcxTreeListEditCellViewInfo; virtual;
    function GetFocusedCellViewInfo(AEditContainer: TcxCustomInplaceEditContainer): TcxEditCellViewInfo; override;
    function GetNavigatorClass: TcxCustomCellNavigatorClass; override;
    function GetNode(ARecordIndex: Integer): TcxTreeListNode;
    function GetResizeDirection: TcxDragSizingDirection; override;
    procedure MouseLeave; override;
    procedure DoCancelMode; override;
    function ValidateShift(Shift: TShiftState): TShiftState;
    procedure UpdateRecord(ARecordIndex: Integer); override;
    // incsearch
    procedure CancelIncSearching; override;
    function DoSearch(AFromNode: TcxTreeListNode; AItemIndex: Integer;
      const AText: string; AGoForward: Boolean): Boolean; virtual;
    function GetIncSearchingItem: TcxCustomInplaceEditContainer; override;
    function GetIncSearchingText: string; override;
    function GetIsIncSearching: Boolean; override;
    function GetNextIncSearchNode(ANode: TcxTreeListNode; AGoForward: Boolean): TcxTreeListNode;
    procedure SearchCheck(AItemFound: Boolean);
    procedure SearchLocate(AItem: TcxCustomInplaceEditContainer; const Value: string); override;
    procedure SearchLocateNext(AItem: TcxCustomInplaceEditContainer; AForward: Boolean); override;
    procedure UpdateNodeIncSearchingCell(ANode: TcxTreeListNode);
    // design selection
    procedure SelectionTimerHandler(ASender: TObject);
    function CanCreateSelectionHelper: Boolean;
    function IsObjectSelected(AObject: TPersistent): Boolean; virtual;
    procedure SelectObject(AObject: TPersistent; AShift: TShiftState); virtual;
    procedure UnselectObject(AObject: TPersistent); virtual; 
    // selection
    procedure CancelSelection(KeepPrimary: Boolean = True);
    procedure Select(ANode: TcxTreeListNode; Shift: TShiftState); virtual;
    property IsControllerEvent: Boolean read GetIsControllerEvent write SetIsControllerEvent;
    property SelectionAnchor: TcxTreeListNode read GetSelectionAnchor;
    property Selection: TList read GetSelection;
    property DataController: TcxControlDataController read GetDataController;
  public
    procedure AfterPaint; override;
    procedure BeforePaint; override;
    procedure BeforeMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure BeginDragAndDrop; override;
    function CanDrag(X, Y: Integer): Boolean; override;
    function CanDeleteSelection: Boolean;
    function CanInsertNode: Boolean;
    procedure ControlFocusChanged; override;
    procedure DblClick; override;
    function DeleteConfirmation: Boolean;
    procedure DoMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure DoMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure EndDragAndDrop(Accepted: Boolean); override;
    function HitAtNodeEx: Boolean;
    function GetCursor(X, Y: Integer): TCursor; override;
    function GetDragAndDropObjectClass: TcxDragAndDropObjectClass; override;
    function GetImmediateEditor: Boolean; override;
    function IsDragCopy: Boolean; virtual;
    function IsDestroying: Boolean; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure MakeFocusedItemVisible; override;
    procedure MakeFocusedRecordVisible; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure Scroll(AScrollBarKind: TScrollBarKind; AScrollCode: TScrollCode;
      var AScrollPos: Integer); override;
    procedure SetFocusedRecordItem(ARecordIndex: Integer;
      AItem: TcxCustomInplaceEditContainer); override;
    procedure SetHotTrackCursor(ACursor: TCursor);
    procedure SetHotTrackNode(ANode: TcxTreeListNode; AShift: TShiftState);
    function StartDragAndDrop(const P: TPoint): Boolean; override;
    procedure UpdateHotTrackNode(AShift: TShiftState); overload;
    procedure UpdateHotTrackNode(X, Y: Integer; AShift: TShiftState); overload;
    property HitTest: TcxTreeListHitTest read GetHitTest;
    property FocusedNode: TcxTreeListNode read GetFocusedNode write SetFocusedNode;
    property OptionsBehavior: TcxTreeListOptionsBehavior read GetOptionsBehavior;
    property TreeList: TcxCustomTreeListControl read GetTreeList;
  end;

 { TcxTreeListHitTest }

  TcxTreeListHitTest = class(TcxCustomHitTestController)
  private
    FHitBand: TcxTreeListBand;
    FHitColumn: TcxTreeListColumn;
    FHitNode: TcxTreeListNode;
    FPressedHeader: TcxTreeListHeaderViewInfo;
    FSizingHitNode: TcxTreeListNode;
    function CheckHitInBand(AViewInfo: TcxTreeListBandViewInfo): Boolean;
    function CheckHitInColumn(AViewInfo: TcxTreeListColumnViewInfo): Boolean;
    function CheckHitInNode(AViewInfo: TcxTreeListNodeViewInfo): Boolean;
    function HitInGroup(AViewInfo: TcxTreeListCellsGroupViewInfo): Boolean;
    function HitInGroups(AViewInfo: TcxTreeListNodeViewInfo): Boolean;
    function HitInIndent(AViewInfo: TcxTreeListNodeViewInfo): Boolean;
    function HitInItem(AItem: TcxCustomViewInfoItem; AState: Integer; ADelta: Integer = 0): Boolean;
    function GetHitAtImages: Boolean;
    function GetTreeList: TcxCustomTreeListControl;
    function GetViewInfo: TcxTreeListViewInfo;
  protected
    FLockUpdate: Boolean;
    FNewHitTestItem: TObject;
    function AllowDesignMouseEvents(X, Y: Integer; AShift: TShiftState): Boolean; override;
    procedure DoCalculate; override;
    function Check(const ARect: TRect): Boolean;
    function CheckHitInBands: Boolean; virtual;
    function CheckHitInNodes: Boolean;
    function GetCurrentCursor: TCursor; override;
    function GetHitTestItem: TObject; virtual;
    function GetState(Index: Integer): Boolean;
    procedure HitTestItemChanged(APrevHitTestItem: TObject); override;
    procedure SetHitState(Index: Integer; Value: Boolean);
    procedure Update; virtual;
    property PressedHeader: TcxTreeListHeaderViewInfo read FPressedHeader;
    property SizingHitNode: TcxTreeListNode read FSizingHitNode;
    property ViewInfo: TcxTreeListViewInfo read GetViewInfo;
  public
    function CanMoving: Boolean; virtual;
    function CanSizing: Boolean; overload;
    function CanSizing(var ASizeDirection: TcxDragSizingDirection): Boolean; overload; virtual;
    property CurrentCursor: TCursor read GetCurrentCursor;
    property HitAtBand: Boolean index tlhc_HitAtBand read GetState;
    property HitAtBandContainer: Boolean index tlhc_HitAtBandContainer read GetState;
    property HitAtBandHeader: Boolean index tlhc_HitAtBandHeader read GetState;
    property HitAtButton: Boolean index tlhc_HitAtButton read GetState;
    property HitAtColumn: Boolean index tlhc_HitAtColumn read GetState;
    property HitAtColumnHeader: Boolean index tlhc_HitAtColumnHeader read GetState;
    property HitAtFooter: Boolean index tlhc_HitAtFooter read GetState;
    property HitAtFooterItem: Boolean index tlhc_HitAtFooterItem read GetState;
    property HitAtImage: Boolean index tlhc_HitAtImage read GetState;
    property HitAtImages: Boolean read GetHitAtImages;
    property HitAtIndent: Boolean index tlhc_HitAtIndent read GetState;
    property HitAtIndicator: Boolean index tlhc_HitAtIndicator read GetState;
    property HitAtStateImage: Boolean index tlhc_HitAtStateImage read GetState;
    property HitAtNode: Boolean index tlhc_HitAtNode read GetState;
    property HitAtNodePreview: Boolean index tlhc_HitAtNodePreview read GetState;
    property HitAtSeparator: Boolean index tlhc_HitAtSeparator read GetState;
    property HitAtSizingHorz: Boolean index tlhc_HitAtSizingHorz read GetState;
    property HitAtSizingVert: Boolean index tlhc_HitAtSizingVert read GetState;
    property HitBand: TcxTreeListBand read FHitBand;
    property HitColumn: TcxTreeListColumn read FHitColumn;
    property HitNode: TcxTreeListNode read FHitNode;
    property TreeList: TcxCustomTreeListControl read GetTreeList;
  end;

  { TcxTreeListViewInfoItem }

  TcxTreeListSeparators = array[0..1] of TRect;

  TcxTreeListViewInfoItem = class(TcxCustomViewInfoItem, IUnknown)
  private
    FBrush: TBrush;
    function GetBrushManager: TcxBrushCache;
    function GetControlViewInfo: TcxTreeListViewInfo;
    function GetHitTestProp: TcxTreeListHitTest;
    function GetOptionsView: TcxTreeListOptionsView;
    function GetPainterClass: TcxCustomLookAndFeelPainterClass;
    function GetTreeList: TcxCustomTreeListControl;
  protected
    procedure Calculate(const ADisplayRect, AVisibleRect: TRect); virtual;
    procedure DoCalculate; override;
    procedure DoHorzOffset(AShift: Integer); override;
    procedure DoVertOffset(AShift: Integer); override;
    function ShiftItem(const AVisibleRect: TRect; DX, DY: Integer): Boolean;
    // IUnknown
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    property Brush: TBrush read FBrush;
    property BrushManager: TcxBrushCache read GetBrushManager;
    property OptionsView: TcxTreeListOptionsView read GetOptionsView;
    property ControlViewInfo: TcxTreeListViewInfo read GetControlViewInfo;
  public
    constructor Create(AOwner: TObject); override;
    destructor Destroy; override;
    property TreeList: TcxCustomTreeListControl read GetTreeList;
    property HitTest: TcxTreeListHitTest read GetHitTestProp;
    property LookAndFeelPainter: TcxCustomLookAndFeelPainterClass read GetPainterClass;
  end;

  { TcxTreeListIndicatorViewInfo }

  TcxTreeListIndicatorViewInfo = class(TcxTreeListViewInfoItem)
  private
    FKind: TcxIndicatorKind;
    FNode: TcxTreeListNode;
  protected
    procedure Calculate(const ADisplayRect, AVisibleRect: TRect); override;
    procedure DoCalculate; override;
    procedure DoVertOffset(AShift: Integer); override;
    function GetControl: TcxEditingControl; override;
    procedure UpdateKind(AKind: TcxIndicatorKind);
  public
    property Node: TcxTreeListNode read FNode;
    property Kind: TcxIndicatorKind read FKind;
    property TreeList;
  end;

  TcxTreeListIndicatorViewInfoClass = class of TcxTreeListIndicatorViewInfo;

  { TcxTreeListFooterItemViewInfo }

  TcxTreeListFooterItemViewInfo = class(TcxTreeListViewInfoItem)
  private
    function GetAlignHorz: TAlignment;
    function GetAlignVert: TcxAlignmentVert;
    function GetBandViewInfo: TcxTreeListBandViewInfo;
    function GetColumn: TcxTreeListColumnViewInfo;
    function GetFooterSummary: TcxTreeListColumnSummaryFooter;
    function GetMultiLine: Boolean;
    function GetText: string;
    function GetVisible: Boolean;
  protected
    procedure DoHorzOffset(DX: Integer); override;
    function GetControl: TcxEditingControl; override;
    property FooterSummary: TcxTreeListColumnSummaryFooter read GetFooterSummary;
  public
    property Column: TcxTreeListColumnViewInfo read GetColumn;
    property AlignHorz: TAlignment read GetAlignHorz;
    property AlignVert: TcxAlignmentVert read GetAlignVert;
    property BandViewInfo: TcxTreeListBandViewInfo read GetBandViewInfo;
    property MultiLine: Boolean read GetMultiLine;
    property Text: string read GetText;
    property Visible: Boolean read GetVisible;
    property TreeList;
  end;

  { TcxTreeListHeaderViewInfo }

  TcxTreeListHeaderViewInfo = class(TcxTreeListViewInfoItem, IcxDragSizing, IcxHotTrackElement)
  private
    FBorders: TcxBorders;
    FGlyphPos: TPoint;
    FNeighbors: TcxNeighbors;
    FPressed: Boolean;
    FState: TcxButtonState;
    procedure CustomDrawEvent(var AEvent: TcxCustomDrawViewInfoItemEvent); virtual;
    function GetAlignHorz: TAlignment;
    function GetAlignVert: TcxAlignmentVert;
    function GetBand: TcxTreeListBand;
    function GetBandViewInfo: TcxTreeListBandViewInfo; virtual;
    function GetButtonState: TcxButtonState;
    function GetCaption: TcxTreeListCaption; virtual;
    function GetGlyph: TBitmap;
    function GetGlyphAlignHorz: TAlignment;
    function GetGlyphAlignVert: TcxAlignmentVert;
    function GetHotTrack: Boolean;
    function GetState(Index: Integer): Boolean;
    function GetText: string;
    procedure SetPressed(Value: Boolean);
  protected
    FCallHintNeeded: Integer;
    FSortMarkBounds: TRect;
    FTextBounds: TRect;
    NeedGlyphClipping: Boolean;
    procedure ButtonStateChanged(APrevIsPressed, IsPressed: Boolean); virtual;
    function CanDropAt(const P: TPoint): Boolean; virtual;
    procedure DoCalculate; override;
    procedure DoCalculateGlyphPosition;
    procedure DoHorzOffset(DX: Integer); override;
    function GetDisplayRect: TRect; virtual;
    function GetDragSizing: IcxDragSizing; virtual;
    function GetDroppingRect: TRect; virtual;
    function GetControl: TcxEditingControl; override;
    function GetSelected: Boolean; virtual;
    function GetSortOrder: TcxDataSortOrder; virtual;
    procedure InitViewParams; virtual;
    procedure UpdateState;
    // IcxHotTrackElement
    function GetHintBounds: TRect; virtual;
    function IsNeedHint(ACanvas: TcxCanvas; const P: TPoint; out AText: TCaption;
      out AIsMultiLine: Boolean; out ATextRect: TRect; var IsNeedOffsetHint: Boolean): Boolean; virtual;
    procedure UpdateHotTrackState(const APoint: TPoint); virtual;
    property BandViewInfo: TcxTreeListBandViewInfo read GetBandViewInfo;
    property Caption: TcxTreeListCaption read GetCaption;
    property DragSizing: IcxDragSizing read GetDragSizing implements IcxDragSizing;
    property Pressed: Boolean read FPressed write SetPressed;
    property SortMarkBounds: TRect read FSortMarkBounds;
    property SortOrder: TcxDataSortOrder read GetSortOrder;
  public
    destructor Destroy; override;
    property AlignHorz: TAlignment read GetAlignHorz;
    property AlignVert: TcxAlignmentVert read GetAlignVert;
    property Band: TcxTreeListBand read GetBand;
    property Borders: TcxBorders read FBorders;
    property Glyph: TBitmap read GetGlyph;
    property GlyphAlignHorz: TAlignment read GetGlyphAlignHorz;
    property GlyphAlignVert: TcxAlignmentVert read GetGlyphAlignVert;
    property GlyphPos: TPoint read FGlyphPos;
    property ShowEndEllipsis: Boolean index 1 read GetState;
    property HotTrack: Boolean read GetHotTrack;
    property MultiLine: Boolean index 2 read GetState;
    property Neighbors: TcxNeighbors read FNeighbors;
    property Selected: Boolean read GetSelected;
    property State: TcxButtonState read FState;
    property Text: string read GetText;
    property TextBounds: TRect read FTextBounds;
    property TreeList;
  end;

  { TcxTreeListColumnHeaderViewInfo }

  TcxTreeListColumnHeaderViewInfo = class(TcxTreeListHeaderViewInfo)
  private
    FIsUltraFlat: Boolean;
    procedure CustomDrawEvent(var AEvent: TcxCustomDrawViewInfoItemEvent); override;
    function GetBandViewInfo: TcxTreeListBandViewInfo; override;
    function GetCaption: TcxTreeListCaption; override;
    function GetColumn: TcxTreeListColumn;
  protected
    procedure ButtonStateChanged(APrevIsPressed, IsPressed: Boolean); override;
    function CanDropAt(const P: TPoint): Boolean; override;
    procedure DoCalculate; override;
    function GetControl: TcxEditingControl; override;
    function GetDisplayRect: TRect; override;
    function GetDragSizing: IcxDragSizing; override;
    function GetDroppingRect: TRect; override;
    function GetSortOrder: TcxDataSortOrder; override;
    procedure InitViewParams; override;
    function GetSelected: Boolean; override; 
    property DragSizing;
  public
    property Column: TcxTreeListColumn read GetColumn;
    property SortMarkBounds;
    property SortOrder;
  end;

  { TcxTreeListColumnHeaderViewInfo }

  TcxTreeListColumnViewInfo = class
  private
    FColumn: TcxTreeListColumn;
    FColumnHeader: TcxTreeListColumnHeaderViewInfo;
    FColumnFooter: TcxTreeListFooterItemViewInfo;
    function GetBandViewInfo: TcxTreeListBandViewInfo;
    function GetDisplayWidth: Integer;
    function GetFooterCellsOffset: Integer;
    function GetLineCount: Integer;
    function GetOptionsView: TcxTreeListOptionsView;
    function GetTreeList: TcxCustomTreeListControl;
  protected
    XOfs: Integer;
    YOfs: Integer;
    function CalcHeaderRect: TRect;
    function CalcFooterRect: TRect;
    procedure DoCalculate; virtual;
    procedure DoHorzOffset(DX: Integer); virtual;
    property DisplayWidth: Integer read GetDisplayWidth;
    property FooterCellsOffset: Integer read GetFooterCellsOffset;
    property LineCount: Integer read GetLineCount;
    property OptionsView: TcxTreeListOptionsView read GetOptionsView;
  public
    constructor Create(AOwner: TcxTreeListColumn); virtual;
    destructor Destroy; override;
    property BandViewInfo: TcxTreeListBandViewInfo read GetBandViewInfo;
    property Column: TcxTreeListColumn read FColumn;
    property ColumnFooter: TcxTreeListFooterItemViewInfo read FColumnFooter;
    property ColumnHeader: TcxTreeListColumnHeaderViewInfo read FColumnHeader;
    property TreeList: TcxCustomTreeListControl read GetTreeList;
  end;

  { TcxTreeListBandViewInfo }

  TcxTreeListBandViewInfo = class(TcxTreeListViewInfoItem)
  private
    FBandHeader: TcxTreeListHeaderViewInfo;
    FCapacity: Integer;
    FColumns: PPointerList;
    FContainerViewParams: TcxViewParams;
    FCount: Integer;
    FFooterRect: TRect;
    FFooterViewParams: TcxViewParams;
    function GetBand: TcxTreeListBand;
    function GetColumn(AIndex: Integer): TcxTreeListColumnViewInfo;
    function GetDisplayWidth: Integer;
    function GetFixed: TcxTreeListBandFixedKind;
  protected
    ContainerBrush: TBrush;
    FooterBrush: TBrush;
    IsOpaque: Boolean;
    procedure CalcFooterRect;
    procedure CheckOpaque; virtual;
    procedure DoCalculate; override;
    procedure DoCalculateColumns;
    procedure DoHorzOffset(DX: Integer); override;
    function GetControl: TcxEditingControl; override;
    procedure SetCapacity(ACapacity: Integer);
    property DisplayWidth: Integer read GetDisplayWidth;
  public
    constructor Create(AOwner: TObject); override;
    destructor Destroy; override;
    property Band: TcxTreeListBand read GetBand;
    property BandHeader: TcxTreeListHeaderViewInfo read FBandHeader;
    property ColumnCount: Integer read FCount;
    property Columns[AIndex: Integer]: TcxTreeListColumnViewInfo read GetColumn;
    property ContainerViewParams: TcxViewParams read FContainerViewParams;
    property FooterViewParams: TcxViewParams read FFooterViewParams;
    property Fixed: TcxTreeListBandFixedKind read GetFixed;
    property FooterRect: TRect read FFooterRect;
    property Opaque: Boolean read IsOpaque;
  end;

  { TcxTreeListEditCellViewInfo }

  TcxTreeListEditCellViewInfo = class(TcxEditCellViewInfo)
  private
    function GetBand: TcxTreeListBand;
    function GetControlViewInfo: TcxTreeListViewInfo;
    function GetEditRectEx: TRect;
    function GetGroup: TcxTreeListCellsGroupViewInfo;
    function GetNode: TcxTreeListNode; virtual;
    function GetNodesViewInfo: TcxTreeListNodesViewInfo; virtual;
    function GetNodeViewInfo: TcxTreeListNodeViewInfo; virtual;
    function GetTreeList: TcxCustomTreeListControl; virtual;
  protected
    GroupIndex: Integer;
    FColumnViewInfo: TcxTreeListColumnViewInfo;
    function ContentOffset: TRect; override;
    function ChangedHeight(APrevHeight, ANewHeight: Integer): Boolean; override;
    procedure CustomDrawEvent(var AEvent: TcxCustomDrawViewInfoItemEvent); virtual;
    procedure DoHorzOffset(AShift: Integer); override;
    procedure DoVertOffset(AShift: Integer); override;
    function GetButtonTransparency: TcxEditButtonTransparency; override;
    function GetColumn: TcxTreeListColumn; virtual;
    function GetDisplayValue: Variant; override;
    function GetEditContainer: TcxCustomInplaceEditContainer; override;
    function GetEditViewParams: TcxViewParams; override;
    function GetFocused: Boolean; override;
    function GetHotTrack: Boolean; virtual;
    function GetLineCount: Integer; virtual;
    function GetLineOffset: Integer; virtual;
    function GetRecordIndex: Integer; override;
    function GetSelected: Boolean; virtual;
    function GetSelectedTextColor: Integer; override;
    function GetSelectedBKColor: Integer; override;
    procedure GetTreeListEditCellParams(var AParams: TcxViewParams); virtual;
    function GetViewInfoData: Pointer; override;
    function IncSearchParams: TcxViewParams;
    function IsAutoHeight: Boolean; override;
    function IsEndEllipsis: Boolean; override;
    function IsTransparent: Boolean; override;
    procedure SetPosition(ATop, AHeight: Integer; const AClipRect: TRect);
    procedure ShiftItem(DX, DY: Integer); virtual;
    procedure UpdateViewInfoPosition;
    property ControlViewInfo: TcxTreeListViewInfo read GetControlViewInfo;
    property LineCount: Integer read GetLineCount;
    property LineOffset: Integer read GetLineOffset;
    property NodesViewInfo: TcxTreeListNodesViewInfo read GetNodesViewInfo;
    property NodeViewInfo: TcxTreeListNodeViewInfo read GetNodeViewInfo;
  public
    procedure Assign(Source: TcxCustomViewInfoItem); override;
    property Column: TcxTreeListColumn read GetColumn;
    property EditRect: TRect read GetEditRectEx;
    property Group: TcxTreeListCellsGroupViewInfo read GetGroup;
    property Band: TcxTreeListBand read GetBand;
    property Node: TcxTreeListNode read GetNode;
    property Selected: Boolean read GetSelected;
    property TreeList: TcxCustomTreeListControl read GetTreeList;
    property HotTrack: Boolean read GetHotTrack;
  end;

  { TcxTreeListGroupNodeEditViewInfo }
  
  TcxTreeListGroupNodeEditViewInfo = class(TcxTreeListEditCellViewInfo)
  private
    function GetCellRect: TRect;
  protected
    function ChangedHeight(APrevHeight, ANewHeight: Integer): Boolean; override;
    procedure DoCalculate; override;
    function GetColumn: TcxTreeListColumn; override;
    procedure ShiftItem(DX, DY: Integer); override;
    procedure Update; virtual;
  end;

  { TcxTreeListNodePreviewViewInfo }

  TcxTreeListNodePreviewViewInfo = class(TcxTreeListEditCellViewInfo)
  private
    function GetPreviewRect: TRect;
  protected
    Preview: TcxTreeListPreview;
    PreviewHeight: Integer;
    function ChangedHeight(APrevHeight, ANewHeight: Integer): Boolean; override;
    function CheckPreviewHeight(DH: Integer): Integer;
    function ContentOffset: TRect; override;
    procedure CustomDrawEvent(var AEvent: TcxCustomDrawViewInfoItemEvent); override;
    procedure DoCalculate; override;
    procedure DoInitPreviewSettings(APreviewOffset: Integer); virtual;
    function GetButtonTransparency: TcxEditButtonTransparency; override;
    function GetColumn: TcxTreeListColumn; override;
    function GetHotTrack: Boolean; override;
    function GetLineCount: Integer; override;
    function GetLineOffset: Integer; override;
    function GetMaxLineCount: Integer; override;
    procedure GetTreeListEditCellParams(var AParams: TcxViewParams); override;
    function IsAutoHeight: Boolean; override;
    procedure ShiftItem(DX, DY: Integer); override;
    procedure Update; virtual;
  public
    constructor Create(AOwner: TObject); override;
    property Height: Integer read PreviewHeight;
  end;

  TcxTreeListNodePreviewViewInfoClass = class of TcxTreeListNodePreviewViewInfo;

  { TcxTreeListCellsGroupViewInfo }

  TcxTreeListCellsGroupViewInfo = class(TcxTreeListViewInfoItem)
  private
    function GetBand: TcxTreeListBand;
    function GetCell(Index: Integer): TcxTreeListEditCellViewInfo;
    function GetCellsHeight: Integer;
    function GetCount: Integer;
    function GetCurrentBrush: TBrush;
    function GetFixed: Boolean;
    function GetNode: TcxTreeListNode;
    function GetNodeViewInfo: TcxTreeListNodeViewInfo;
    function GetNodesViewInfo: TcxTreeListNodesViewInfo;
    procedure CalculateEditCellRect(ACell: TcxTreeListEditCellViewInfo; AMostLeftPos: Integer);
  protected
    IsOpaque: Boolean;
    BandViewInfo: TcxTreeListBandViewInfo;
    Borders: TcxBorders;
    Indent: Integer;
    FirstIndex, LastIndex: Integer;
    procedure DoCalculate; override;
    procedure DoCalculateCellsLayout; virtual;
    procedure DoHorzOffset(AShift: Integer); override;
    procedure DoVertOffset(AShift: Integer); override;
    function GetControl: TcxEditingControl; override;
    function GetHotTrack: Boolean; virtual;
    function GetSelected: Boolean; virtual;
    function GetGroupBitmap: TBitmap; virtual;
    procedure SetSize(ATop, AHeight: Integer); virtual;
    procedure ShiftGroup(DX, DY: Integer); virtual;
    property CellsHeight: Integer read GetCellsHeight;
    property CurrentBrush: TBrush read GetCurrentBrush;
    property NodesViewInfo: TcxTreeListNodesViewInfo read GetNodesViewInfo;
    property NodeViewInfo: TcxTreeListNodeViewInfo read GetNodeViewInfo;
    property Fixed: Boolean read GetFixed;
  public
    procedure Assign(Source: TcxCustomViewInfoItem); override;
    property Band: TcxTreeListBand read GetBand;
    property CellCount: Integer read GetCount;
    property Cells[Index: Integer]: TcxTreeListEditCellViewInfo read GetCell;
    property Node: TcxTreeListNode read GetNode;
    property Opaque: Boolean read IsOpaque;
    property Selected: Boolean read GetSelected;
    property HotTrack: Boolean read GetHotTrack; 
  end;

  { TcxTreeListIndentViewInfo }

  TcxTreeListLevelTreeLine = (tltVertUp, tltVertDown, tltHorz);
  TcxTreeListLevelTreeLines = set of TcxTreeListLevelTreeLine;

  TcxTreeListIndentViewInfo = class(TcxTreeListViewInfoItem)
  private
    function GetButtonRect: TRect;
    function GetIsExpanded: Boolean;
    function GetNextVisible: TcxTreeListNodeViewInfo;
    function GetNode: TcxTreeListNode;
    function GetNodeViewInfo: TcxTreeListNodeViewInfo;
    function GetNodesViewInfo: TcxTreeListNodesViewInfo;
    function GetPrevVisible: TcxTreeListNodeViewInfo;
  protected
    IndentBorders: TcxBorders;
    IndentHasImage: Boolean;
    IndentHasExpandButton: Boolean;
    IndentHorzTreeLine: TRect;
    IndentImageIndex: Integer;
    IndentStateImage: Boolean;
    IndentImageList: TCustomImageList;
    IndentIsLevel: Boolean;
    IndentLevel: Integer;
    IndentLevelNode: TcxTreeListNode;
    IndentTreeLines: TcxTreeListLevelTreeLines;
    IndentVertTreeLine: TRect;
    procedure DoCalculate; override;
    procedure DoHorzOffset(AShift: Integer); override;
    procedure DoVertOffset(AShift: Integer); override;
    function GetControl: TcxEditingControl; override;
    procedure ShiftIndent(DX, DY: Integer); virtual;
    procedure UpdateImageIndex;
    property NextVisible: TcxTreeListNodeViewInfo read GetNextVisible;
    property NodesViewInfo: TcxTreeListNodesViewInfo read GetNodesViewInfo;
    property NodeViewInfo: TcxTreeListNodeViewInfo read GetNodeViewInfo;
    property PrevVisible: TcxTreeListNodeViewInfo read GetPrevVisible;
    property Brush;
  public
    property Borders: TcxBorders read IndentBorders;
    property ButtonRect: TRect read GetButtonRect;
    property HasButton: Boolean read IndentHasExpandButton;
    property HasImage: Boolean read IndentHasImage;
    property HorzTreeLine: TRect read IndentHorzTreeLine;
    property IsExpanded: Boolean read GetIsExpanded;
    property IsLevel: Boolean read IndentIsLevel;
    property Level: Integer read IndentLevel;
    property LevelNode: TcxTreeListNode read IndentLevelNode;
    property Node: TcxTreeListNode read GetNode;
    property TreeLines: TcxTreeListLevelTreeLines read IndentTreeLines;
    property VertTreeLine: TRect read IndentVertTreeLine;
    property ImageIndex: Integer read IndentImageIndex;
    property ImageList: TCustomImageList read IndentImageList;
    property ViewParams;
    property TreeList;
  end;

  { TcxTreeListNodeViewInfo }

  TcxTreeListNodeViewInfo = class
  private
    // subitems lists
    FGroups: TList;
    FCells: TList;
    FIndents: TList;
    // sub items
    FIndicator: TcxTreeListIndicatorViewInfo;
    FPreview: TcxTreeListNodePreviewViewInfo;
    // other
    FOwner: TcxTreeListNodesViewInfo;
    function GetCell(Index: Integer): TcxTreeListEditCellViewInfo;
    function GetCellCount: Integer;
    function GetControlViewInfo: TcxTreeListViewInfo;
    function GetFocusRect: TRect;
    function GetGroup(Index: Integer): TcxTreeListCellsGroupViewInfo;
    function GetGroupCount: Integer;
    function GetHotTrack: Boolean;
    function GetIndent(Index: Integer): TcxTreeListIndentViewInfo;
    function GetIndentCount: Integer;
    function GetIndentWidth: Integer;
    function GetOptionsView: TcxTreeListOptionsView;
    function GetRealHeight: Integer;
    function GetTreeList: TcxCustomTreeListControl;
    function GetVisibleIndex: Integer;
    function GetVisibleRect(AFixed: Boolean): TRect;
    function AddGroup(AInfo: TcxTreeListBandViewInfo; var AIndex, AOfs: Integer): TcxTreeListCellsGroupViewInfo;
    procedure AddCell(AInfo: TcxTreeListColumnViewInfo; var AGroupIndex, AIndex: Integer);
    procedure CalculateIndentInfo(AIndent: TcxTreeListIndentViewInfo;
      var ANode: TcxTreeListNode; ALevel: Integer; var ALeft: Integer);
    procedure UpdateContentRects;
    procedure UpdateLinks;
  protected
    ViewInfoNode: TcxTreeListNode;
    NodeCellsCalculated: Boolean;
    NodeFocused: Boolean;
    NodeHasButton: Boolean;
    NodeHasPreview: Boolean;
    NodeSelected: Boolean;
    NodeVisible: Boolean;
    NodeIsGroup: Boolean; 
    NodeIsExpanded: Boolean;
    NodeBorders: TcxBorders;
    NodeLevel: Integer;
    NodeGroupEditViewInfo: TcxTreeListGroupNodeEditViewInfo;
    NodeFocusedCell: TcxTreeListEditCellViewInfo;
    NodeNextVisible: TcxTreeListNodeViewInfo;
    NodePrevVisible: TcxTreeListNodeViewInfo;
    // size and position variables
    NodeIndentLeft: Integer;
    NodeCellsRect: TRect;    // cells only
    NodeClipRect: TRect;     // visible content only
    NodeContentRect: TRect;  // cells + preview + indicator
    NodeCellsOffset: Integer;
    NodePreviewOffset: Integer;
    //    FCellHeight: Integer;
    CellsMaxHeight: Integer;
    CellMaxHeightRefCount: Integer;
    // fixed bands viewinfo variables
    LeftFixedGroup: TcxTreeListCellsGroupViewInfo;
    RightFixedGroup: TcxTreeListCellsGroupViewInfo;
    Separators: TcxTreeListSeparators;
    // position and misc. variables
    Index: Integer;
    Top, Left: Integer;
    UnusedArea: TRect;
    procedure DoCalculate; virtual;
    procedure DoCalculateAutoHeights; virtual;
    procedure DoCalculateCellsViewInfo; virtual;
    procedure DoCalculateImageIndents(var ALeft: Integer); virtual;
    function DoCalculateIndentsLayout: Integer; virtual;
    procedure DoCalculateIndentsViewInfo; virtual;
    procedure DoCalculateLayout; virtual;
    procedure DoHorzOffset(AShift: Integer); virtual;
    procedure DoVertOffset(AShift: Integer); virtual;
    function GetNodeIndicatorKind: TcxIndicatorKind; virtual;
    procedure Update(ARecalculate: Boolean = False); virtual;
    procedure UpdateClipping; virtual;
    procedure UpdateImageIndexes; virtual;
    procedure UpdatePostCalculate(ATop, AIndex: Integer); virtual;
    // node view info routines
    procedure ReallocateData; overload;
    property ControlViewInfo: TcxTreeListViewInfo read GetControlViewInfo;
    property IndentWidth: Integer read GetIndentWidth;
    property Owner: TcxTreeListNodesViewInfo read FOwner;
    property OptionsView: TcxTreeListOptionsView read GetOptionsView;
    property RealHeight: Integer read GetRealHeight;
  public
    constructor Create(AOwner: TcxTreeListNodesViewInfo); virtual;
    destructor Destroy; override;
    procedure AssignLayoutTo(ADest: TcxTreeListNodeViewInfo); virtual;
    procedure Clear;
    property CellCount: Integer read GetCellCount;
    property Cells[Index: Integer]: TcxTreeListEditCellViewInfo read GetCell;
    property ClipRect: TRect read NodeClipRect;
    property ContentRect: TRect read NodeContentRect;
    property Focused: Boolean read NodeFocused;
    property FocusRect: TRect read GetFocusRect;
    property GroupCount: Integer read GetGroupCount;
    property Groups[Index: Integer]: TcxTreeListCellsGroupViewInfo read GetGroup;
    property HasButton: Boolean read NodeHasButton;
    property HasPreview: Boolean read NodeHasPreview;
    property HotTrack: Boolean read GetHotTrack;
    property IndentCount: Integer read GetIndentCount;
    property Indents[Index: Integer]: TcxTreeListIndentViewInfo read GetIndent;
    property Indicator: TcxTreeListIndicatorViewInfo read FIndicator;
    property IsGroupNode: Boolean read NodeIsGroup;
    property IsExpanded: Boolean read NodeIsExpanded;
    property Level: Integer read NodeLevel;
    property NextVisible: TcxTreeListNodeViewInfo read NodeNextVisible;
    property Node: TcxTreeListNode read ViewInfoNode;
    property Preview: TcxTreeListNodePreviewViewInfo read FPreview;
    property PreviewOffset: Integer read NodePreviewOffset;
    property PrevVisible: TcxTreeListNodeViewInfo read NodePrevVisible;
    property Selected: Boolean read NodeSelected;
    property TreeList: TcxCustomTreeListControl read GetTreeList;
    property Visible: Boolean read NodeVisible;
    property VisibleIndex: Integer read GetVisibleIndex;
  end;

  { TcxTreeListNodesViewInfo }

  TcxTreeListNodesViewInfo = class
  private
    FCapacity: Integer;
    FNeedSynchronize: Boolean;
    FNeedUpdatePos: Boolean;
    FNodesCount: Integer;
    FNodes: PPointerList;
    FOwner: TcxTreeListViewInfo;
    FUpdatePost: Boolean;
    function GetMaxVisibleIndex: Integer;
    function GetNextNodeForProcess: TcxTreeListNode;
    function GetNextNodeFromViewInfo(Index: Integer): TcxTreeListNode;
    function GetNodeViewInfo(Index: Integer): TcxTreeListNodeViewInfo;
    function GetOptionsView: TcxTreeListOptionsView;
    function GetScrollWindow: Boolean;
    function GetTopVisibleIndex: Integer;
    function GetTreeList: TcxCustomTreeListControl;
    function ProcessAddNode(var ANode: TcxTreeListNode; var IsBreak: Boolean): Integer;
  protected
    CheckSelectionMode: Boolean;
    ClipRect: TRect;
    Count: Integer;
    IndentWidth: Integer;
    IsAddFirst: Boolean;
    IsRowAutoHeight: Boolean;
    NodesBottom: Integer;
    ScrollRect: TRect;
    SpaceArea: TRect;
    Template: TcxTreeListNodeViewInfo;
    TopNode: TcxTreeListNode;
    VisibleCount: Integer;
    procedure Add(ANode: TcxTreeListNode; var AHeight: Integer); virtual;
    function AddNode(ANode: TcxTreeListNode): TcxTreeListNodeViewInfo;
    procedure BeforeShowEdit; virtual;
    procedure CalculatePreviewHeight; virtual;
    procedure CancelUpdatePost;
    procedure ChangeDirection;
    procedure ClearState;
    procedure DoCalculate(AFullRecalculate: Boolean = True); virtual;
    procedure DoCalculateNextPage(AGoForward: Boolean); virtual;
    procedure DoCalculateShiftUp(ALineCount: Integer); virtual;
    procedure DoCalculateShiftDown(ALineCount: Integer); virtual;
    procedure DoHorzOffset(AShift: Integer); virtual;
    procedure DoVertOffset(AShift: Integer); virtual;
    function FindNodeViewInfo(ANode: TcxTreeListNode;
      var AViewInfo: TcxTreeListNodeViewInfo): Boolean;
    procedure FocusedRecordChanged(APrevNode, ANewNode: TcxTreeListNode); virtual;
    procedure MakeNodeVisible(ANode: TcxTreeListNode); virtual;
    function MoveFirstToLatest(ACheckedOne: Boolean = True): Integer;
    procedure NeedUpdatePost;
    procedure NeedViewInfoUpdatePost;
    function PostViewInfoUpdate: Boolean;
    procedure PostUpdate;
    procedure ProcessNodes(ATopNode: TcxTreeListNode; ANeedLastVisible: Boolean); virtual;
    procedure SetLastVisibleNode(ANode: TcxTreeListNode); virtual;
    procedure SynchronizeTopNode; virtual;
    procedure UpdateSelectedNodes; virtual;
    procedure UpdatePostCalculate; virtual;
    procedure UpdateData; virtual;
    function GetGroupViewInfoItemClass: TcxTreeListCellsGroupViewInfoClass; virtual;
    function GetEditCellViewInfoItemClass: TcxTreeListEditCellViewInfoClass; virtual;
    function GetIndentViewInfoItemClass: TcxTreeListIndentViewInfoClass; virtual;
    function GetNodePreviewViewInfoClass: TcxTreeListNodePreviewViewInfoClass; virtual;
    function GetNodeViewInfoClass: TcxTreeListNodeViewInfoClass; virtual;
    property ScrollWindow: Boolean read GetScrollWindow;
    property MaxVisibleIndex: Integer read GetMaxVisibleIndex;
    property Owner: TcxTreeListViewInfo read FOwner;
    property OptionsView: TcxTreeListOptionsView read GetOptionsView;
    property TopVisibleIndex: Integer read GetTopVisibleIndex;
    property TreeList: TcxCustomTreeListControl read GetTreeList;
    property Nodes[Index: Integer]: TcxTreeListNodeViewInfo read GetNodeViewInfo;
  public
    constructor Create(AOwner: TcxTreeListViewInfo); virtual;
    destructor Destroy; override;
    procedure Clear;
  end;

  { TcxTreeListViewInfo }

  TcxTreeListViewInfo = class(TcxCustomControlViewInfo)
  private
    FBandCapacity: Integer;
    FBandCount: Integer;
    FBands: PPointerList;
    FDefaultRowHeight: Integer;
    FFixedBands: array[0..1] of TcxTreeListBandViewInfo;
    FNodesViewInfo: TcxTreeListNodesViewInfo;
    FScrollingArea: TRect;
    FScrollingAreaVisible: Boolean;
    FSeparators: TcxTreeListSeparators;
    function GetBand(AIndex: Integer): TcxTreeListBandViewInfo;
    function GetBorderSize: Integer;
    function GetBrushManager: TcxBrushCache;
    function GetCellsHeight: Integer;
    function GetCellsOffset: Integer;
    function GetContentOffset: Integer;
    function GetDefaultHeight: Integer;
    function GetFooterOffset: Integer;
    function GetHeaderOffset: Integer;
    function GetLeftFixedBand: TcxTreeListBandViewInfo;
    function GetOptionsView: TcxTreeListOptionsView;
    function GetRightFixedBand: TcxTreeListBandViewInfo;
    function GetTreeList: TcxCustomTreeListControl;
    function GetVisibleBand(Index: Integer): TcxTreeListBandViewInfo;
    function GetVisibleBandCount: Integer;
    procedure SetBandCount(ACount: Integer);
    procedure SetBandViewParams(ABand: TcxTreeListBand; Index: Integer);
    procedure SetColumnViewParams(AColumn: TcxTreeListColumn);
    // helpers function
    function CalcBandRect(var ARect: TRect;
      AWidth, AOfs: Integer; Fixed: TcxTreeListBandFixedKind): Integer;
    procedure CalculateCellRects;
    function SetHeaderSizeValue(const ViewParams: TcxViewParams;
      var ASize: Integer; CheckSize: Boolean; Delta: Integer = 0): TcxViewParams;
  protected
    BackgroundBitmap: TBitmap;
    BandLineHeight: Integer;
    CellsRect: TRect;
    ContentRect: TRect;
    ExpandButtonSize: Integer;
    FooterBitmap: TBitmap;
    FooterBrush: TBrush;
    FooterColor: TColor;
    FooterIndicator: TcxTreeListIndicatorViewInfo;
    FooterLineHeight: Integer;
    FooterRect : TRect;
    FooterSeparators: TcxTreeListSeparators;
    GridLinesBrush: TBrush;
    HeaderRect: TRect;
    HeaderIndicator: TcxTreeListIndicatorViewInfo;
    HeaderLineHeight: Integer;
    HeaderSeparators: TcxTreeListSeparators;
    IndicatorViewParams: TcxViewParams;
    PreviewHeight: Integer;
    PrevClientRect: TRect;
    SeparatorBrush: TBrush;
    TreeLineColor: TColor;
    // scrolling variables
    PrevHorzScrollSize: Integer;
    HorzScrollInc: Integer;
    HorzScrollPage: Integer;
    HorzScrollPos: Integer;
    HorzScrollSize: Integer;
    SizingViewInfo: TcxTreeListEditCellViewInfo;
    procedure CalculateDefaultHeights; override;
    function CalculateDefaultEditHeight: Integer; override;
    procedure CalculateDefaultViewParams; virtual;
    procedure CalculateHeaderFooterViewInfo; virtual;
    procedure CheckScrolling; virtual;
    procedure DoCalculate; override;
    procedure DoScrollHorizontal(APos: Integer); virtual;
    procedure DoScrollVertical(APos: Integer); virtual;
    function GetIndicatorViewInfoClass: TcxTreeListIndicatorViewInfoClass; virtual;
    function GetNodesViewInfoClass: TcxTreeListNodesViewInfoClass; virtual;
    procedure InvalidateRect(const ARect: TRect);
    procedure UpdateSelection; override;
    procedure UpdateFootersViewInfo; virtual;
    property BorderSize: Integer read GetBorderSize;
    property BrushManager: TcxBrushCache read GetBrushManager;
    property CellsHeight: Integer read GetCellsHeight;
    property CellsOffset: Integer read GetCellsOffset;
    property ContentOffset: Integer read GetContentOffset;
    property FooterOffset: Integer read GetFooterOffset;
    property HeaderOffset: Integer read GetHeaderOffset;
    property OptionsView: TcxTreeListOptionsView read GetOptionsView;
    property VisibleBandCount: Integer read GetVisibleBandCount;
    property VisibleBands[Index: Integer]: TcxTreeListBandViewInfo read GetVisibleBand;
  public
    constructor Create(AOwner: TcxEditingControl); override;
    destructor Destroy; override;
    procedure InvalidateScrollRect(ADirection: TcxDragSizingDirection); virtual;
    property BandCount: Integer read FBandCount;
    property Bands[Index: Integer]: TcxTreeListBandViewInfo read GetBand;
    property DefaultHeight: Integer read GetDefaultHeight;
    property DefaultRowHeight: Integer read FDefaultRowHeight;
    property LeftFixedBand: TcxTreeListBandViewInfo read GetLeftFixedBand;
    property NodesViewInfo: TcxTreeListNodesViewInfo read FNodesViewInfo;
    property RightFixedBand: TcxTreeListBandViewInfo read GetRightFixedBand;
    property ScrollingArea: TRect read FScrollingArea;
    property ScrollingAreaVisible: Boolean read FScrollingAreaVisible;
    property TreeList: TcxCustomTreeListControl read GetTreeList;
  end;

  { TcxTreeListControlPainter }

  TcxTreeListControlPainter = class(TcxCustomControlPainter)
  private
    function GetBackgroundBrush: TBrush;
    function GetGridLinesBrush: TBrush;
    function GetIsFooterVisible: Boolean;
    function GetTreeList: TcxCustomTreeListControl;
    function GetTreeLineColor: TColor;
    function GetViewInfo: TcxTreeListViewInfo;
  protected
    ContentClipRegion: TcxRegion;
    CurrentBitmap: TBitmap;
    procedure AfterCustomDraw(AViewInfo: TcxCustomViewInfoItem); override;
    procedure AfterCustomDraw(AViewInfo: TcxTreeListEditCellViewInfo); overload;
    procedure BeforeCustomDraw(AViewInfo: TcxCustomViewInfoItem); override;
    procedure BeforeCustomDraw(AViewInfo: TcxTreeListEditCellViewInfo); overload;
    function DoCustomDrawEx(AViewInfoItem: TcxCustomViewInfoItem;
      AEvent: TcxCustomDrawViewInfoItemEvent; AExclude: Boolean): Boolean;
    procedure DoPaint; override;
    function DoPaintBackground(ACanvas: TcxCanvas; const ABounds: TRect): Boolean;
    procedure DrawBackgroundRect(const R: TRect); virtual;
    procedure DrawBandItem(AViewInfo: TcxTreeListBandViewInfo); virtual;
    procedure DrawBandFooter(AViewInfo: TcxTreeListBandViewInfo); virtual;
    procedure DrawCellsGroup(AViewInfo: TcxTreeListCellsGroupViewInfo); virtual;
    procedure DrawEditCell(AViewInfo: TcxTreeListEditCellViewInfo; IsOpaque: Boolean); virtual;
    procedure DrawExpandButton(const ARect: TRect; AExpanded: Boolean; ABitmap: TBitmap); virtual;
    procedure DrawFocusRect(AViewInfo: TcxTreeListNodeViewInfo); virtual;
    procedure DrawFooter; virtual;
    procedure DrawFooterItem(AViewInfo: TcxTreeListFooterItemViewInfo);
    procedure DrawFooterRect(const R: TRect; AViewInfo: TcxTreeListBandViewInfo); virtual;
    procedure DrawHeader; virtual;
    procedure DrawHeaderItem(AViewInfo: TcxTreeListHeaderViewInfo; IsOpaque: Boolean); virtual;
    procedure DrawHeaderRect(const R: TRect; AViewInfo: TcxTreeListBandViewInfo); virtual;
    procedure DrawImage(AViewInfo: TcxTreeListIndentViewInfo); virtual;
    procedure DrawIndicator(AViewInfo: TcxTreeListIndicatorViewInfo); virtual;
    procedure DrawNode(AViewInfo: TcxTreeListNodeViewInfo); virtual;
    procedure DrawNodeCells(AViewInfo: TcxTreeListNodeViewInfo;
      AFromIndex, AToIndex: Integer); virtual;
    procedure DrawNodeIndent(AViewInfo: TcxTreeListIndentViewInfo); virtual;
    procedure DrawNodePreview(AViewInfo: TcxTreeListNodePreviewViewInfo); virtual;
    procedure DrawNodes; virtual;
    procedure DrawRect(AViewInfo: TcxTreeListViewInfoItem); overload;
    procedure DrawRect(const ARect: TRect; ABrush: TBrush; ABitmap: TBitmap = nil); overload; virtual;
    procedure DrawRectWithBorders(const ARect: TRect; ABrush: TBrush;
      IsOpaque: Boolean; ABorders: TcxBorders = []; ABitmap: TBitmap = nil); overload;
    procedure DrawRectWithBorders(AViewInfo: TcxTreeListViewInfoItem;
      IsOpaque: Boolean; ABorders: TcxBorders = []); overload;
    procedure DrawSeparators(const ASeparators: TcxTreeListSeparators); virtual;
    procedure DrawTreeLines(AViewInfo: TcxTreeListIndentViewInfo); virtual;
    procedure ExtDrawHeader(ACanvas: TcxCanvas;
      const ABounds, ATextAreaBounds: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders;
      AState: TcxButtonState; AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert;
      AMultiLine, AShowEndEllipsis: Boolean; const AText: string; AFont: TFont;
      ATextColor, ABkColor: TColor; AOnDrawBackground: TcxDrawBackgroundEvent = nil);
    function GetViewState(AIndex: Integer): Boolean;
    procedure RestoreClipping;
    property NodesClipping: TcxRegion read ContentClipRegion;
    property Bands: Boolean index 0 read GetViewState;
    property BackgroundBrush: TBrush read GetBackgroundBrush;
    property Footer: Boolean index 2 read GetViewState;
    property Headers: Boolean index 3 read GetViewState;
    property Indicator: Boolean index 4 read GetViewState;
    property IsFooterVisible: Boolean read GetIsFooterVisible;
    property ShowRoot: Boolean index 5 read GetViewState;
    property GridLinesBrush: TBrush read GetGridLinesBrush;
    property TreeLineColor: TColor read GetTreeLineColor;
  public
    property TreeList: TcxCustomTreeListControl read GetTreeList;
    property ViewInfo: TcxTreeListViewInfo read GetViewInfo;
  end;

  { TcxTreeListBandOptions }

  TcxTreeListBandOptions = class(TcxOwnedPersistent)
  private
    FState: Integer;
    FHidden: Boolean;
    function GetState(AIndex: Integer): Boolean;
    procedure SetState(AIndex: Integer; Value: Boolean);
  protected
    procedure Changed; virtual;
  public
    constructor Create(AOwner: TPersistent); override;
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults; virtual;
  published
    property Customizing: Boolean index 0 read GetState write SetState default True;
    property Hidden: Boolean read FHidden write FHidden default False;
    property Moving: Boolean index 1 read GetState write SetState default True;
    property OnlyOwnColumns: Boolean index 2 read GetState write SetState default False;
    property Sizing: Boolean index 3 read GetState write SetState default True;
  end;

  TcxTreeListBandOptionsClass = class of TcxTreeListBandOptions;

  { TcxTreeListBandStyles }

  TcxTreeListBandStyles = class(TcxStyles)
  private
    function GetTreeList: TcxCustomTreeListControl;
  protected
    ContentParams: TcxCachedContentParams;
    procedure CachedContentStyleChanged;
    procedure Changed(AIndex: Integer); override;
    property TreeList: TcxCustomTreeListControl read GetTreeList;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Content: TcxStyle index tlbs_Content read GetValue write SetValue;
    property Footer: TcxStyle index tlbs_Footer read GetValue write SetValue;
    property Header: TcxStyle index tlbs_Header read GetValue write SetValue;
    property HeaderBackground: TcxStyle index tlbs_HeaderBackground read GetValue write SetValue;
  end;

  { TcxTreeListBand }

  TcxTreeListBand = class(TcxInterfacedCollectionItem, IUnknown, IcxTreeListIndexedItem, IcxDragSizing, IcxStoredObject)
  private
    FBandRows: TcxTreeListBandRows;
    FBandViewInfo: TcxTreeListBandViewInfo;
    FCaption: TcxTreeListCaption;
    FCalculatedWidth: Integer; 
    FColumns: TList;
    FMinWidth: Integer;
    FOptions: TcxTreeListBandOptions;
    FState: Integer;
    FStyles: TcxTreeListBandStyles;
    FVisibleColumns: TList;
    FWidth: Integer;
    function GetBands: TcxTreeListBands;
    function GetColumn(Index: Integer): TcxTreeListColumn;
    function GetColumnCount: Integer;
    function GetDisplayWidth: Integer;
    function GetFixedKind: TcxTreeListBandFixedKind;
    function GetIndentWidth: Integer;
    function GetIsLeftMost: Boolean;
    function GetIsRightMost: Boolean;
    function GetItemIndex: Integer;
    function GetRealWidth: Integer;
    function GetTreeList: TcxCustomTreeListControl;
    function GetVisible: Boolean;
    function GetVisibleIndex: Integer;
    function GetVisibleColumn(Index: Integer): TcxTreeListColumn;
    function GetVisibleColumnCount: Integer;
    procedure SetBandVisiblePos(APos: Integer);
    procedure SetCaption(Value: TcxTreeListCaption);
    procedure SetColumn(Index: Integer; Value: TcxTreeListColumn);
    procedure SetFixedKind(Value: TcxTreeListBandFixedKind);
    procedure SetItemIndex(Value: Integer);
    procedure SetMinWidth(Value: Integer);
    procedure SetOptions(Value: TcxTreeListBandOptions);
    procedure SetStyles(Value: TcxTreeListBandStyles);
    procedure SetVisible(Value: Boolean);
    procedure SetVisibleColumn(Index: Integer; Value: TcxTreeListColumn);
    procedure SetVisibleIndex(Value: Integer);
    procedure SetWidth(Value: Integer);
  protected
    procedure AssignColumnWidths;
    procedure InitAutoWidthItem(AItem: TcxAutoWidthItem);
    function IsFixed: Boolean;
    function IsOnlyOwnColumns: Boolean;
    function CanDropColumnAt(const APoint: TPoint; out ARowIndex, AColIndex: Integer): Boolean; virtual;
    function GetMaxDeltaWidth: Integer;
    function CanMoving: Boolean; virtual;
    function GetState(Index: Integer): Boolean;
    function GetOptionsClass: TcxTreeListBandOptionsClass; virtual;
    procedure AddColumn(AColumn: TcxTreeListColumn);
    procedure RealignColumns;
    procedure RemoveColumn(AColumn: TcxTreeListColumn);
    procedure SetState(Index: Integer; Value: Boolean);
    procedure VisibleChanged; virtual;
      // IcxTreeListDragSizing implementation
    function CanSizing(ADirection: TcxDragSizingDirection): Boolean;
    function GetSizingBoundsRect(ADirection: TcxDragSizingDirection): TRect; virtual;
    function GetSizingIncrement(ADirection: TcxDragSizingDirection): Integer; virtual;
    function IsDynamicUpdate: Boolean; virtual;
    procedure SetSizeDelta(ADirection: TcxDragSizingDirection; ADelta: Integer); virtual;
    // IcxStoredObject
    function GetObjectName: string;
    function GetProperties(AProperties: TStrings): Boolean; virtual;
    function GetPropertyIndex(const AName: string): Integer;
    procedure GetPropertyValue(const AName: string; var AValue: Variant); virtual;
    procedure SetPropertyValue(const AName: string; const AValue: Variant); virtual;
    property Bands: TcxTreeListBands read GetBands;
    property TreeList: TcxCustomTreeListControl read GetTreeList;
    property ViewInfo: TcxTreeListBandViewInfo read FBandViewInfo;
    property IndentWidth: Integer read GetIndentWidth;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure ApplyBestFit;
    procedure RestoreDefaults; virtual;
    procedure RestoreWidths;
    property BandRows: TcxTreeListBandRows read FBandRows;
    property ColumnCount: Integer read GetColumnCount;
    property Columns[Index: Integer]: TcxTreeListColumn read GetColumn write SetColumn;
    property DisplayWidth: Integer read GetDisplayWidth;
    property IsLeftMost: Boolean read GetIsLeftMost;
    property IsRightMost: Boolean read GetIsRightMost;
    property RealWidth: Integer read GetRealWidth;
    property VisibleColumnCount: Integer read GetVisibleColumnCount;
    property VisibleColumns[Index: Integer]: TcxTreeListColumn read GetVisibleColumn write SetVisibleColumn;
    property Index;
  published
    property Caption: TcxTreeListCaption read FCaption write SetCaption;
    property FixedKind: TcxTreeListBandFixedKind read GetFixedKind write SetFixedKind default tlbfNone;
    property MinWidth: Integer read FMinWidth write SetMinWidth default cxTreeListDefMinWidth;
    property Options: TcxTreeListBandOptions read FOptions write SetOptions;
    property Styles: TcxTreeListBandStyles read FStyles write SetStyles;
    property Visible: Boolean read GetVisible write SetVisible default True;
    property Width: Integer read FWidth write SetWidth default 0;
    property VisibleIndex: Integer read GetVisibleIndex write SetVisibleIndex stored False;
  end;

  TcxTreeListBandClass = class of TcxTreeListBand;

  { TcxTreeListBands }

  TcxTreeListBands = class(TCollection, {$IFNDEF DELPHI6} IUnknown, {$ENDIF} IcxStoredObject, IcxStoredParent)
  private
    FTreeList: TcxCustomTreeListControl;
    function GetItem(AIndex: Integer): TcxTreeListBand;
    function GetVisibleItemEx(AIndex: Integer): TcxTreeListBand;
    procedure SetItem(AIndex: Integer; Value: TcxTreeListBand);
  protected
    function GetOwner: TPersistent; override;
    procedure RealignColumns;
    procedure RefreshBandStates; virtual;
    procedure Update(Item: TCollectionItem); override;
    //
  {$IFDEF DELPHI6}
    procedure Notify(Item: TCollectionItem; Action: TCollectionNotification); override;
  {$ENDIF}

    // IInterface
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    // IcxStoredObject }
    function GetObjectName: string;
    function GetProperties(AProperties: TStrings): Boolean; virtual;
    procedure GetPropertyValue(const AName: string; var AValue: Variant); virtual;
    procedure SetPropertyValue(const AName: string; const AValue: Variant); virtual;
    // IcxStoredParent
    function CreateChild(const AObjectName, AClassName: string): TObject; virtual;
    procedure DeleteChild(const AObjectName: string; AObject: TObject); virtual;
    procedure GetChildren(AChildren: TStringList); virtual;
  public
    constructor Create(AOwner: TcxCustomTreeListControl); virtual;
    function Add: TcxTreeListBand;
    function GetAbsoluteIndex(VisibleIndex: Integer): Integer;
    function GetVisibleIndex(AbsoluteIndex: Integer): Integer;
    procedure RestoreDefaults; virtual;
    procedure RestoreWidths; virtual;
    property FirstVisible: TcxTreeListBand index 0 read GetVisibleItemEx;
    property Items[AIndex: Integer]: TcxTreeListBand read GetItem write SetItem; default;
    property LastVisible: TcxTreeListBand index 1 read GetVisibleItemEx;
    property TreeList: TcxCustomTreeListControl read FTreeList;
  end;

  { TcxTreeListBandRow }

  TcxTreeListBandRow = class
  private
    FBandRows: TcxTreeListBandRows;
    FItems: TList;
    FLineCount: Integer;
    FLineOffset: Integer;
    function GetBand: TcxTreeListBand;
    function GetCount: Integer;
    function GetFirst: TcxTreeListColumn;
    function GetIndex: Integer;
    function GetIsFirst: Boolean;
    function GetIsLast: Boolean;
    function GetItem(Index: Integer): TcxTreeListColumn;
    function GetItemEx(Index: Integer): TcxTreeListColumn;
    function GetLast: TcxTreeListColumn;
    function GetLineCount: Integer;
    function GetMinWidth: Integer;
    function GetTreeList: TcxCustomTreeListControl;
    function GetWidth: Integer;
  protected
    procedure AddColumn(AColumn: TcxTreeListColumn);
    procedure DoCalculateColumnsAutoWidth;
    function GetRowMinWidth: Integer;
    function GetMaxColumnWidth(AColumn: TcxTreeListColumn): Integer;
    procedure UpdateInformation;
    property Band: TcxTreeListBand read GetBand;
    property TreeList: TcxCustomTreeListControl read GetTreeList;
  public
    constructor Create(AOwner: TcxTreeListBandRows); virtual;
    destructor Destroy; override;
    function IndexOf(AColumn: TcxTreeListColumn): Integer;
    property BandRows: TcxTreeListBandRows read FBandRows;
    property Count: Integer read GetCount;
    property First: TcxTreeListColumn read GetFirst;
    property Index: Integer read GetIndex;
    property IsFirst: Boolean read GetIsLast;
    property IsLast: Boolean read GetIsFirst;
    property Items[Index: Integer]: TcxTreeListColumn read GetItem; default;
    property Last: TcxTreeListColumn read GetLast;
    property LineCount: Integer read GetLineCount;
    property LineOffset: Integer read FLineOffset;
    property MinWidth: Integer read GetMinWidth;
    property Width: Integer read GetWidth;
  end;

  { TcxTreeListBandRows }

  TcxTreeListBandRows = class
  private
    FBand: TcxTreeListBand;
    FColumnsMaxWidth: Integer;
    FColumnsMinWidth: Integer;
    FItems: TList;
    FLineCount: Integer;
    function GetCount: Integer;
    function GetFirst: TcxTreeListBandRow;
    function GetItem(Index: Integer): TcxTreeListBandRow;
    function GetItemEx(Index: Integer): TcxTreeListBandRow;
    function GetLast: TcxTreeListBandRow;
    function GetLeftMostMinWidth: Integer;
    function GetLeftMostWidth: Integer;
    function GetMinWidth: Integer;
  protected
    function Add: TcxTreeListBandRow;
    function CalculateAvaliableMinWidth: Integer;
    procedure Clear;
    procedure Refresh;
    procedure UpdateInformation;
  public
    constructor Create(AOwner: TcxTreeListBand); virtual;
    destructor Destroy; override;
    property Band: TcxTreeListBand read FBand;
    property Count: Integer read GetCount;
    property ColumnsMaxWidth: Integer read FColumnsMaxWidth;
    property ColumnsMinWidth: Integer read FColumnsMinWidth;
    property First: TcxTreeListBandRow read GetFirst;
    property Items[Index: Integer]: TcxTreeListBandRow read GetItem; default;
    property Last: TcxTreeListBandRow read GetLast;
    property LeftMostMinWidth: Integer read GetLeftMostMinWidth;
    property LeftMostWidth: Integer read GetLeftMostWidth;
    property LineCount: Integer read FLineCount;
    property MinWidth: Integer read GetMinWidth;
  end;

  { TcxTreeListOptionsView }

  TcxTreeListTreeLineStyle = (tllsNone, tllsDot, tllsSolid);
  TcxTreeListPaintStyle = (tlpsStandard, tlpsCategorized);

  TcxTreeListOptionsView = class(TcxControlOptionsView, IUnknown, IcxTreeListSubClass)
  private
    FBandLineCount: Integer;
    FCategorizedColumn: TcxTreeListColumn;
    FDropArrowColor: TColor;
    FFixedSeparatorColor: TColor;
    FFixedSeparatorWidth: Integer;
    FGridLineColor: TColor;
    FGridLines: TcxTreeListGridLines;
    FIndicatorWidth: Integer;
    FPaintStyle: TcxTreeListPaintStyle;
    FState: Integer;
    FTreeLineColor: TColor;
    FTreeLineStyle: TcxTreeListTreeLineStyle;
    function GetTreeList: TcxCustomTreeListControl;
    procedure SetCategorizedColumn(Value: TcxTreeListColumn);
    procedure SetColumnAutoWidth(Index: Integer; Value: Boolean);
    procedure SetBandLineCount(Value: Integer);
    procedure SetIndicatorWidth(Value: Integer);
    procedure SetFixedSeparatorColor(Value: TColor);
    procedure SetFixedSeparatorWidth(Value: Integer);
    procedure SetGridLineColor(Value: TColor);
    procedure SetGridLines(Value: TcxTreeListGridLines);
    procedure SetHeaderSingleLine(Index: Integer; Value: Boolean);
    procedure SetPaintStyle(Value: TcxTreeListPaintStyle);
    procedure SetTreeLineColor(Value: TColor);
    procedure SetTreeLineStyle(Value: TcxTreeListTreeLineStyle);
  protected
    procedure Changed; override;
    function GetControl: TObject;
    function GetState(AIndex: Integer): Boolean;
    procedure SetState(AIndex: Integer; Value: Boolean);
    // helper functions
    function HasImages(ANode: TcxTreeListNode): Boolean;
    function HasStateImages(ANode: TcxTreeListNode): Boolean;
    function HorzIncrement: Integer;
    function IsCategorizedPaint: Boolean;
    function IsExtPaintStyle: Boolean;
    function IsRowAutoHeight: Boolean;
    function VertIncrement: Integer;
    // IUnknown
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    function QueryInterface(const IID: TGUID; out Obj): HResult; virtual; stdcall;
    property TreeList: TcxCustomTreeListControl read GetTreeList;
  public
    constructor Create(AOwner: TPersistent); override;
    procedure Assign(Source: TPersistent); override;
    function GetCategorizedColumn: TcxTreeListColumn;
    procedure RestoreDefaults; virtual;
  published
    property BandLineCount: Integer read FBandLineCount write SetBandLineCount default cxTreeListDefBandHeaderLineCount;
    property Bands: Boolean index 0 read GetState write SetState default cxTreeListDefBands;
    property Buttons: Boolean index 7 read  GetState write SetState default True;
    property CategorizedColumn: TcxTreeListColumn read FCategorizedColumn write SetCategorizedColumn;
    property ColumnAutoWidth: Boolean index 1 read GetState write SetColumnAutoWidth default cxTreeListDefColumnAutoWidth;
    property DropArrowColor: TColor read FDropArrowColor write FDropArrowColor default cxTreeListDefDropArrowColor;
    property ExtPaintStyle: Boolean index 12 read GetState write SetState default False;  
    property FixedSeparatorColor: TColor read FFixedSeparatorColor write SetFixedSeparatorColor default clDefault;
    property FixedSeparatorWidth: Integer read FFixedSeparatorWidth write SetFixedSeparatorWidth default cxTreeListDefSeparatorWidth;
    property Footer: Boolean index 2 read GetState write SetState default False;
    property GridLineColor: TColor read FGridLineColor write SetGridLineColor default clDefault;
    property GridLines: TcxTreeListGridLines read FGridLines write SetGridLines default tlglNone;
    property Headers: Boolean index 3 read GetState write SetState default cxTreeListDefColumnHeaders;
    property HeaderSingleLine: Boolean index 10 read GetState write SetHeaderSingleLine default False;
    property Indicator: Boolean index 4 read GetState write SetState default False;
    property IndicatorWidth: Integer read FIndicatorWidth write SetIndicatorWidth default cxTreeListDefIndicatorWidth;
    property PaintStyle: TcxTreeListPaintStyle read FPaintStyle write SetPaintStyle default tlpsStandard;
    property ShowRoot: Boolean index 5 read GetState write SetState default True;
    property SimpleCustomizeBox: Boolean index 8 read GetState write SetState default False;
    property TreeLineColor: TColor read FTreeLineColor write SetTreeLineColor default clDefault;
    property TreeLineStyle: TcxTreeListTreeLineStyle read FTreeLineStyle write SetTreeLineStyle default tllsDot;
    property UseImageIndexForSelected: Boolean index 13 read GetState write SetState default True; 
    property UseNodeColorForIndent: Boolean index 9 read GetState write SetState default True;
    property CellAutoHeight;
    property CellEndEllipsis;
    property CellTextMaxLineCount;
    property ScrollBars;
    property ShowEditButtons;
  end;

  { TcxTreeListOptionsCustomizing }

  TcxTreeListOptionsCustomizing = class(TcxOwnedPersistent)
  private
    FState: Integer;
    function GetTreeList: TcxCustomTreeListControl;
  protected
    function GetState(Index: Integer): Boolean;
    procedure SetState(Index: Integer; Value: Boolean);
    property TreeList: TcxCustomTreeListControl read GetTreeList;
  public
    constructor Create(AOwner: TPersistent); override;
    procedure Assign(Source: TPersistent); override;
  published
    property BandCustomizing: Boolean index 7 read GetState write SetState default True;
    property BandHorzSizing: Boolean index 1 read GetState write SetState default True;
    property BandMoving: Boolean index 2 read GetState write SetState default True;
    property BandVertSizing: Boolean index 3 read GetState write SetState default True;
    property ColumnCustomizing: Boolean index 4 read GetState write SetState default True;
    property ColumnHorzSizing: Boolean index 5 read GetState write SetState default True;
    property ColumnMoving: Boolean index 6 read GetState write SetState default True;
    property ColumnVertSizing: Boolean index 8 read GetState write SetState default True;
    property DynamicSizing: Boolean index 9 read GetState write SetState default False;
    property RowSizing: Boolean index 10 read GetState write SetState default False;
  end;

  { TcxTreeListOptionsSelection }

  TcxTreeListOptionsSelection = class(TcxOwnedPersistent)
  private
    FState: Integer;
    function GetTreeList: TcxCustomTreeListControl;
  protected
    procedure Changed; virtual;
    function GetSelectionState(Index: Integer): Boolean;
    procedure SetSelectionState(Index: Integer; Value: Boolean);
    property TreeList: TcxCustomTreeListControl read GetTreeList;
  public
    constructor Create(AOwner: TPersistent); override;
    procedure Assign(Source: TPersistent); override;
  published
    property CellSelect: Boolean index 0 read GetSelectionState write SetSelectionState default True;
    property HideFocusRect: Boolean index 1 read GetSelectionState write SetSelectionState default True;
    property HideSelection: Boolean index 2 read GetSelectionState write SetSelectionState default False;
    property InvertSelect: Boolean index 3 read GetSelectionState write SetSelectionState default True;
    property MultiSelect: Boolean index 4 read GetSelectionState write SetSelectionState default False;
  end;

  TcxTreeListOptionsSelectionClass = class of TcxTreeListOptionsSelection;

  { TcxTreeListOptionsBehavior }

  TcxTreeListOptionsBehavior = class(TcxControlOptionsBehavior)
  private
    FState: Integer;
    FWaitExpandingTime: Integer;
    function GetChangeDelay: Integer;
    function GetIncSearchItem: TcxTreeListColumn;
    function GetTreeList: TcxCustomTreeListControl;
    procedure SetChangeDelay(Value: Integer);
    procedure SetAutomateLeftMostIndent(Index: Integer; Value: Boolean);
    procedure SetIncSearchItem(Value: TcxTreeListColumn);
  protected
    function GetState(Index: Integer): Boolean;
    procedure SetState(Index: Integer; Value: Boolean);
    property TreeList: TcxCustomTreeListControl read GetTreeList;
  public
    constructor Create(AOwner: TPersistent); override;
    procedure Assign(Source: TPersistent); override;
  published
    property AutoDragCopy: Boolean index 4 read GetState write SetState default False;
    property AutomateLeftMostIndent: Boolean index 9 read GetState write SetAutomateLeftMostIndent default True;
    property ChangeDelay: Integer read GetChangeDelay write SetChangeDelay default 0;
    property ConfirmDelete: Boolean index 6 read GetState write SetState default True;
    property DragCollapse: Boolean index 0 read GetState write SetState default True;
    property DragExpand: Boolean index 1 read GetState write SetState default True;
    property DragFocusing: Boolean index 15 read GetState write SetState default False;
    property ExpandOnDblClick: Boolean index 16 read GetState write SetState default True;
    property ExpandOnIncSearch: Boolean index 2 read GetState write SetState default False;
    property HotTrack: Boolean index 10 read GetState write SetState default False;
    property IncSearchItem: TcxTreeListColumn read GetIncSearchItem write SetIncSearchItem default nil;
    property Sorting: Boolean index 8 read GetState write SetState default True;
    property MultiSort: Boolean index 7 read GetState write SetState default True;
    property ShowHourGlass: Boolean index 3 read GetState write SetState default True;
    property WaitForExpandNodeTime: Integer read FWaitExpandingTime write FWaitExpandingTime default cxTreeListDefWaitExpandTime;
    property DragDropText; 
    property FocusCellOnCycle;
    property IncSearch;
  end;

  { TcxTreeListOptionsData }

  TcxTreeListOptionsData = class(TcxControlOptionsData)
  private
    FState: Integer;
    function GetAnsiSort: Boolean;
    function GetCaseInsensitive: Boolean;
    function GetSummaryNullIgnore: Boolean;
    procedure SetAnsiSort(Value: Boolean);
    procedure SetCaseInsensitive(Value: Boolean);
    procedure SetSummaryNullIgnore(Value: Boolean);
  protected
    procedure Changed; override;
    function GetState(Index: Integer): Boolean;
    procedure SetState(Index: Integer; Value: Boolean);
  public
    constructor Create(AOwner: TPersistent); override;
    procedure Assign(Source: TPersistent); override;
  published
    property AnsiSort: Boolean read GetAnsiSort write SetAnsiSort default False;
    property CaseInsensitive: Boolean read GetCaseInsensitive write SetCaseInsensitive default False;
    property Deleting: Boolean index 0 read GetState write SetState default True;
    property Inserting: Boolean index 1 read GetState write SetState default False;
    property SummaryNullIgnore: Boolean read GetSummaryNullIgnore write SetSummaryNullIgnore default False;
  end;

  { TcxTreeListPreview }

  TcxTreeListPreviewPlace = (tlppBottom, tlppTop);

  TcxTreeListPreview = class(TcxOwnedInterfacedPersistent, IcxTreeListSubClass)
  private
    FAutoHeight: Boolean;
    FColumn: TcxTreeListColumn;
    FLeftIndent: Integer;
    FMaxLineCount: Integer;
    FPlace: TcxTreeListPreviewPlace;
    FRightIndent: Integer;
    FVisible: Boolean;
    function GetActive: Boolean;
    function GetTreeList: TcxCustomTreeListControl;
    procedure SetAutoHeight(Value: Boolean);
    procedure SetColumn(Value: TcxTreeListColumn);
    procedure SetLeftIndent(Value: Integer);
    procedure SetMaxLineCount(Value: Integer);
    procedure SetPlace(Value: TcxTreeListPreviewPlace);
    procedure SetRightIndent(Value: Integer);
    procedure SetVisible(Value: Boolean);
  protected
    procedure Changed(ACheckActivate: Boolean); virtual;
    function GetControl: TObject;
  public
    constructor Create(AOwner: TPersistent); override;
    procedure Assign(Source: TPersistent); override;
    property Active: Boolean read GetActive;
    property TreeList: TcxCustomTreeListControl read GetTreeList;
  published
    property AutoHeight: Boolean read FAutoHeight write SetAutoHeight default True;
    property Column: TcxTreeListColumn read FColumn write SetColumn;
    property LeftIndent: Integer read FLeftIndent write SetLeftIndent
      default cxTreeListDefPreviewMaxLineCount;
    property MaxLineCount: Integer read FMaxLineCount write SetMaxLineCount
      default cxTreeListDefPreviewMaxLineCount;
    property Place: TcxTreeListPreviewPlace read FPlace write SetPlace default tlppBottom;
    property RightIndent: Integer read FRightIndent write SetRightIndent
      default cxTreeListDefPreviewIndent;
    property Visible: Boolean read FVisible write SetVisible default False;
  end;

  { TcxTreeListStyleSheet }

  TcxTreeListStyleSheet = class(TcxCustomStyleSheet)
  private
    function GetStylesValue: TcxTreeListStyles;
    procedure SetStylesValue(Value: TcxTreeListStyles);
  public
    class function GetStylesClass: TcxCustomStylesClass; override;
  published
    property Styles: TcxTreeListStyles read GetStylesValue write SetStylesValue;
  end;

  { TcxTreeListStyles }

  TcxtlOnGetItemStyleEvent = procedure(Sender: TObject; AItem: TObject; var AStyle: TcxStyle) of object;

  TcxtlOnGetContentStyleEvent = procedure(Sender: TObject; AItem: TObject;
    ANode: TcxTreeListNode; var AStyle: TcxStyle) of object;

  TcxtlOnGetNodeIndentStyleEvent = procedure(Sender: TObject;
    ANode: TcxTreeListNode; ALevel: Integer; var AStyle: TcxStyle) of object;

  TcxTreeListStyles = class(TcxCustomControlStyles)
  private
    FOnGetBandBackgroundStyle: TcxtlOnGetItemStyleEvent;
    FOnGetBandContentStyle: TcxtlOnGetContentStyleEvent;
    FOnGetBandHeaderStyle: TcxtlOnGetItemStyleEvent;
    FOnGetBandFooterStyle: TcxtlOnGetItemStyleEvent;
    FOnGetColumnFooterStyle: TcxtlOnGetItemStyleEvent;
    FOnGetColumnHeaderStyle: TcxtlOnGetItemStyleEvent;
    FOnGetContentStyle: TcxtlOnGetContentStyleEvent;
    FOnGetHotTrackStyle: TcxtlOnGetContentStyleEvent;
    FOnGetNodeIndentStyle: TcxtlOnGetNodeIndentStyleEvent;
    FOnGetPreviewStyle: TcxtlOnGetItemStyleEvent;
    function GetTreeList: TcxCustomTreeListControl;
  protected
    ContentParams: TcxCachedContentParams;
    CachedPreviewStyle: TcxViewParams;
    procedure ContentStyleChanged; virtual;
    procedure DoGetContentParams(ANode: TcxTreeListNode; AColumn: TcxTreeListColumn; var AParams: TcxViewParams); virtual;
    procedure DoGetBandContentParams(ANode: TcxTreeListNode; ABand: TcxTreeListBand; var AParams: TcxViewParams); virtual;
    function DoGetBandContentStyle(ANode: TcxTreeListNode; ABand: TcxTreeListBand; out AStyle: TcxStyle): Boolean;
    procedure GetDefaultViewParams(Index: Integer; AData: TObject; out AParams: TcxViewParams); override;
    function GetStyleFromEvent(const AEvent: TcxtlOnGetItemStyleEvent; AItem: TObject): TcxStyle;
    function SelectionFontAssigned: Boolean;
    property TreeList: TcxCustomTreeListControl read GetTreeList;
  public
    procedure Assign(Source: TPersistent); override;
    function GetBandBackgroundParams(ABand: TcxTreeListBand): TcxViewParams;
    function GetBandContentParams(ABand: TcxTreeListBand; ANode: TcxTreeListNode): TcxViewParams;
    function GetBandFooterParams(ABand: TcxTreeListBand): TcxViewParams;
    function GetBandHeaderParams(ABand: TcxTreeListBand): TcxViewParams;
    function GetColumnContentParams(AColumn: TcxTreeListColumn; IsOdd: Boolean): TcxViewParams;
    function GetColumnHeaderParams(AColumn: TcxTreeListColumn): TcxViewParams;
    function GetColumnFooterParams(AColumn: TcxTreeListColumn): TcxViewParams;
    function GetContentParams(ANode: TcxTreeListNode; AColumn: TcxTreeListColumn): TcxViewParams;
    function GetIncSearchParams: TcxViewParams;
    function GetIndentParams(ANode: TcxTreeListNode; AIndent: Integer): TcxViewParams;
    function GetIndicatorParams: TcxViewParams;
    function GetFooterParams: TcxViewParams;
    function GetPreviewParams(ANode: TcxTreeListNode): TcxViewParams;
  published
    property BandBackground: TcxStyle index tlsv_BandBackground read GetValue write SetValue;
    property BandContent: TcxStyle index tlsv_BandContent read GetValue write SetValue;
    property BandHeader: TcxStyle index tlsv_BandHeader read GetValue write SetValue;
    property ColumnFooter: TcxStyle index tlsv_ColumnFooter read GetValue write SetValue;
    property ColumnHeader: TcxStyle index tlsv_ColumnHeader read GetValue write SetValue;
    property ContentEven: TcxStyle index tlsv_ContentEven read GetValue write SetValue;
    property ContentOdd: TcxStyle index tlsv_ContentOdd read GetValue write SetValue;
    property Footer: TcxStyle index tlsv_Footer read GetValue write SetValue;
    property HotTrack: TcxStyle index tlsv_HotTrack read GetValue write SetValue;
    property IncSearch: TcxStyle index tlsv_IncSearch read GetValue write SetValue;
    property Indicator: TcxStyle index tlsv_Indicator read GetValue write SetValue;
    property Preview: TcxStyle index tlsv_Preview read GetValue write SetValue;
    property OnGetBandBackgroundStyle: TcxtlOnGetItemStyleEvent read FOnGetBandBackgroundStyle write FOnGetBandBackgroundStyle;
    property OnGetBandContentStyle: TcxtlOnGetContentStyleEvent read FOnGetBandContentStyle write FOnGetBandContentStyle;
    property OnGetBandHeaderStyle: TcxtlOnGetItemStyleEvent read FOnGetBandHeaderStyle write FOnGetBandHeaderStyle;
    property OnGetBandFooterStyle: TcxtlOnGetItemStyleEvent read FOnGetBandFooterStyle write FOnGetBandFooterStyle;
    property OnGetColumnFooterStyle: TcxtlOnGetItemStyleEvent read FOnGetColumnFooterStyle write FOnGetColumnFooterStyle;
    property OnGetColumnHeaderStyle: TcxtlOnGetItemStyleEvent read FOnGetColumnHeaderStyle write FOnGetColumnHeaderStyle;
    property OnGetContentStyle: TcxtlOnGetContentStyleEvent read FOnGetContentStyle write FOnGetContentStyle;
    property OnGetNodeIndentStyle: TcxtlOnGetNodeIndentStyleEvent read FOnGetNodeIndentStyle write FOnGetNodeIndentStyle;
    property OnGetHotTrackStyle: TcxtlOnGetContentStyleEvent read FOnGetHotTrackStyle write FOnGetHotTrackStyle;
    property OnGetPreviewStyle: TcxtlOnGetItemStyleEvent read FOnGetPreviewStyle write FOnGetPreviewStyle;
    property Background;
    property Content;
    property Inactive;
    property Selection;
    property StyleSheet;
  end;

  { TcxTreeListItemsCustomizeListBox }

  TcxTreeListItemsCustomizeListBox = class(TcxListBox)
  private
    FAccepted: Boolean;
    FDragAndDropItemIndex: Integer;
    FDragAndDropObject: TcxTreeListDragAndDropObject;
    FIsBandListBox: Boolean;
    FMouseDownPos: TPoint;
    FOrgPoint: TPoint;
    FPrevCursor: TCursor;
    FTreeList: TcxCustomTreeListControl;
    function GetPainter: TcxCustomLookAndFeelPainterClass;
    procedure WMCancelMode(var Message: TWMCancelMode); message WM_CANCELMODE;
  protected
    procedure BeginDrag; virtual;
    procedure FocusChanged; override;
    procedure DoDrawItem(AControl: TcxListBox; ACanvas: TcxCanvas;
      AIndex: Integer; ARect: TRect; AState: TOwnerDrawState); virtual;
    procedure DoDrawItemEx(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure EndDrag(Accepted: Boolean); virtual;
    procedure FinishDrag(Accepted: Boolean); virtual;
    procedure InitDragAndDropObject; virtual;
    function GetItemHeight(AItem: Integer): Integer; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MeasureItem(AControl: TcxListBox; Index: Integer; var Height: Integer); virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure RefreshList;
    procedure Resize; override;
    property DragAndDropObject: TcxTreeListDragAndDropObject read FDragAndDropObject;
    property TreeList: TcxCustomTreeListControl read FTreeList;
    property Painter: TcxCustomLookAndFeelPainterClass read GetPainter;
  public
    constructor CreateEx(AOwner: TComponent;
      ATreeList: TcxCustomTreeListControl; IsBandListBox: Boolean);
  end;

  { TcxTreeListCustomizationForm }

  TcxTreeListCustomizationForm = class(TForm)
  private
    FCustomizingListBox: TcxTreeListItemsCustomizeListBox;
    FDeactivationTimer: TTimer;
    FHookTimer: TcxTimer;
    FOwner: TcxTreeListCustomizing;
    function GetTreeList: TcxCustomTreeListControl;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DeactivationTimeHandler(Sender: TObject);
    procedure StartDeactivationTimer(Sender: TcxTreeListItemsCustomizeListBox);
    procedure StopDeactivationTimer;
    procedure HookTimerHandler(Sender: TObject);

    property HookTimer: TcxTimer read FHookTimer; 
    property Customizing: TcxTreeListCustomizing read FOwner;
    property CustomizingListBox: TcxTreeListItemsCustomizeListBox read FCustomizingListBox;
    property TreeList: TcxCustomTreeListControl read GetTreeList;
  public
    constructor CreateEx(AOwner: TcxTreeListCustomizing);
    destructor Destroy; override;
  end;

  { TcxTreeListCustomizing }

  TcxTreeListCustomizing = class(TcxOwnedInterfacedPersistent, IcxTreeListDesigner)
  private
    FBandListBox: TcxTreeListItemsCustomizeListBox;
    FDragAndDropObject: TcxTreeListDragAndDropObject;
    FForm: TcxTreeListCustomizationForm;
    FHeaderListBox: TcxTreeListItemsCustomizeListBox;
    FLastBandIndex: Integer;
    FLastHeaderIndex: Integer;
    FLastPosition: TPoint;
    FLineHeight: Integer;
    FPageControl: TPageControl;
    FRowCount: Integer;
    FTabSheetBands: TTabSheet;
    FTabSheetHeaders: TTabSheet;
    FTreeList: TcxCustomTreeListControl;
    FVisible: Boolean;
    function GetForm: TForm;
    function GetVisible: Boolean;
    procedure SetRowCount(Value: Integer);
    procedure SetVisible(Value: Boolean);
  protected
    procedure AdjustControls; virtual;
    procedure Activate(Sender: TObject); virtual;
    procedure Close(Sender: TObject; var Action: TCloseAction); virtual;
    procedure CreateControls; virtual;
    procedure CreateCustomizingForm;
    function IsSimpleMode: Boolean;
    procedure LookAndFeelChanged; virtual;
    procedure ReleaseControls;
    procedure SetControlParent(AControl, AParent: TWinControl);
    procedure ShowCustomizingForm;
    function SizeDelta: TSize; virtual;
    procedure ValidateListBox(AListBox: TcxTreeListItemsCustomizeListBox; AIndex: Integer);
    procedure VisibleChanged(Sender: TObject);
    procedure Update; virtual;
    // IcxTreeListDesigner
    procedure ComponentRemoved(Sender: TObject); virtual;
    procedure Modified; virtual;
    property DragAndDropObject: TcxTreeListDragAndDropObject read FDragAndDropObject write FDragAndDropObject;
    property BandListBox: TcxTreeListItemsCustomizeListBox read FBandListBox;
    property CustomizingPos: TPoint read FLastPosition write FLastPosition;
    property HeaderListBox: TcxTreeListItemsCustomizeListBox read FHeaderListBox;
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure MakeBandSheetVisible;
    procedure MakeColumnSheetVisible;
    property Form: TForm read GetForm;
    function PtInCustomizingBox(const APoint: TPoint): Boolean;
    property RowCount: Integer read FRowCount write SetRowCount default 10;
    property TreeList: TcxCustomTreeListControl read FTreeList;
    property Visible: Boolean read GetVisible write SetVisible;
  end;

  TcxTreeListCustomizingClass = class of TcxTreeListCustomizing;

  { TcxCustomTreeListControl }

  TcxTreeListNodeChangedEvent = procedure(Sender: TObject; ANode: TcxTreeListNode) of object;

  TcxTreeListNodeChangingEvent = procedure(Sender: TObject; ANode: TcxTreeListNode;
    var Allow: Boolean) of object;

  TcxTreeListMoveToEvent = procedure(Sender: TObject; AttachNode: TcxTreeListNode;
    AttachMode: TcxTreeListNodeAttachMode; Nodes: TList; var IsCopy, Done: Boolean) of object;

  TcxTreeListNodeCompareEvent = procedure(Sender: TObject;
    ANode1, ANode2: TcxTreeListNode; var ACompare: Integer) of object;

  TcxTreeListFocusedChangedEvent = procedure(Sender: TObject;
    APrevFocusedNode, AFocusedNode: TcxTreeListNode) of object;

  TcxTreeListGetNodeImageIndexEvent = procedure(Sender: Tobject;
    ANode: TcxTreeListNode; AIndexType: TcxTreeListImageIndexType; var AIndex: TImageIndex) of object;

  TcxTreeListGetPreviewTextEvent = procedure(Sender: TObject;
    ANode: TcxTreeListNode; var AText: string) of object;

  TcxTreeListGetNodePreviewHeightEvent = procedure(Sender: TObject;
    ANode: TcxTreeListNode; const ADisplayValue: Variant; var AHeight: Integer) of object;

  TcxTreeListIsGroupNodeEvent = procedure(Sender: TObject;
    ANode: TcxTreeListNode; var IsGroup: Boolean) of object;

  TcxTreeListEditingEvent = procedure(Sender: TObject;
    AColumn: TcxTreeListColumn; var Allow: Boolean) of object;

  TcxTreeListColumnChangedEvent = procedure(Sender: TObject;
    AColumn: TcxTreeListColumn) of object;

  TcxTreeListBandChangedEvent = procedure(Sender: TObject;
    ABand: TcxTreeListBand) of object;

  TcxTreeListFocusedColumnChanged = procedure(Sender: TObject;
    APrevFocusedColumn, AFocusedColumn: TcxTreeListColumn) of object;

  TcxTreeListOnHotTrackNodeEvent = procedure(Sender: TObject; ANode: TcxTreeListNode;
    AShift: TShiftState; var ACursor: TCursor) of object;

  TcxTreeListItemChangedEvent = procedure(Sender: TObject; AItem: TObject) of object;

  TcxTreeListNodeDataChangedEvent = procedure(Sender: TObject;
    ANode: TcxTreeListNode; AColumn: TcxTreeListColumn) of object;

  TcxCustomDrawBackgroundEvent = procedure(Sender: TObject; ACanvas: TcxCanvas;
    const R: TRect; var ADone: Boolean) of object;

  TcxCustomDrawEditCellViewInfoEvent = procedure(Sender: TObject; ACanvas: TcxCanvas;
    AViewInfo: TcxTreeListEditCellViewInfo; var ADone: Boolean) of object;

  TcxCustomDrawCellsGroupViewInfoEvent = procedure(Sender: TObject; ACanvas: TcxCanvas;
    AViewInfo: TcxTreeListCellsGroupViewInfo; var ADone: Boolean) of object;

  TcxCustomDrawHeaderViewInfoEvent = procedure(Sender: TObject; ACanvas: TcxCanvas;
    AViewInfo: TcxTreeListHeaderViewInfo; var ADone: Boolean) of object;

  TcxCustomDrawIndentViewInfoEvent = procedure(Sender: TObject; ACanvas: TcxCanvas;
    AViewInfo: TcxTreeListIndentViewInfo; var ADone: Boolean) of object;

  TcxCustomDrawIndicatorViewInfoEvent = procedure(Sender: TObject; ACanvas: TcxCanvas;
    AViewInfo: TcxTreeListIndicatorViewInfo; var ADone: Boolean) of object;

  TcxCustomDrawFooterItemViewInfoEvent = procedure(Sender: TObject; ACanvas: TcxCanvas;
    AViewInfo: TcxTreeListFooterItemViewInfo; var ADone: Boolean) of object;

  TcxCustomDrawBandViewInfoEvent = procedure(Sender: TObject; ACanvas: TcxCanvas;
    AViewInfo: TcxTreeListBandViewInfo; var ADone: Boolean) of object;

  TcxTreeListGetNodeHeight = procedure(Sender: TcxCustomTreeListControl;
    ANode: TcxTreeListNode; var AHeight: Integer) of object;

  TcxCustomTreeListControl = class(TcxExtEditingControl, IcxNavigator, IcxStoredParent,
                                   IcxStoredObject, IcxTreeListDesignTimeOperations, IdxSkinSupport)
  private
    FAutoWidthController: TcxAutoWidthObject;
    FBands: TcxTreeListBands;
    FBandsVisibleList: TList;
    FChangeImagesLink: TChangeLink;
    FChangeStateImagesLink: TChangeLink;
    FCheckedList: TList;
    FColumnsVisibleList: TList;
    FContentIndentWidth: Integer;
    FCustomizing: TcxTreeListCustomizing;
    FDataChangedLocked: Boolean;
    FDelayTimer: TTimer;
    FDefaultLayout: Boolean;
    FDefaultRowHeight: Integer;
    FDeletedNodes: TList;
    FDesigners: TList;
    FDragNode: TcxTreeListNode;
    FFreezeCount: Integer;
    FHeaderLineCount: Integer;
    FImages: TCustomImageList;
    FIsRestore: Boolean; 
    FLevelIndentWidth: Integer;
    FLockChanges: Boolean;
    FNavigatorNotifier: TcxNavigatorControlNotifier;
    FNodes: TcxTreeListNodes;
    FNodesList: TList;
    FNeedMakeVisible: Boolean;
    FNeedSortPost: Boolean;
    FNeedUpdateDesigners: Boolean;
    FNeedRestoreSorting: Boolean;
    FNeedFocusedRecordUpdatePost: Boolean;
    FOptionsCustomizing: TcxTreeListOptionsCustomizing;
    FOptionsSelection: TcxTreeListOptionsSelection;
    FPostChanged: Boolean;
    FPreview: TcxTreeListPreview;
    FRealBandLineHeight: Integer;
    FSafeDelete: Boolean;
    FSortedColumns: TList;
    FSortLocking: Integer;
    FSortOrderList: TList;
    FSelection: TList;
    FSelectionUpdateLocked: Integer;
    FStateImages: TCustomImageList;
    FStoredCursor: TCursor;
    FStylesEvents: TNotifyEvent;
    FTopPos: Integer;
    FUseGlassCursor: Integer;
    FOnAfterSorting: TNotifyEvent;
    FOnBandHeaderClick: TcxTreeListBandChangedEvent;
    FOnBandSizeChanged: TcxTreeListItemChangedEvent;
    FOnCanSelectNode: TcxTreeListNodeChangingEvent;
    FOnChange: TNotifyEvent;
    FOnCollapsed: TcxTreeListNodeChangedEvent;
    FOnCollapsing: TcxTreeListNodeChangingEvent;
    FOnColumnHeaderClick: TcxTreeListColumnChangedEvent;
    FOnColumnSizeChanged: TcxTreeListItemChangedEvent;
    FOnCompare: TcxTreeListNodeCompareEvent;
    FOnCustomDrawBackground: TcxCustomDrawBackgroundEvent;
    FOnCustomDrawBandHeader: TcxCustomDrawHeaderViewInfoEvent;
    FOnCustomDrawCell: TcxCustomDrawEditCellViewInfoEvent;
    FOnCustomDrawCellsGroup: TcxCustomDrawCellsGroupViewInfoEvent;
    FOnCustomDrawIndicatorCell: TcxCustomDrawIndicatorViewInfoEvent;
    FOnCustomDrawIndentCell: TcxCustomDrawIndentViewInfoEvent;
    FOnCustomDrawFooter: TcxCustomDrawBandViewInfoEvent;
    FOnCustomDrawFooterCell: TcxCustomDrawFooterItemViewInfoEvent;
    FOnCustomDrawHeader: TcxCustomDrawBandViewInfoEvent;
    FOnCustomDrawHeaderCell: TcxCustomDrawHeaderViewInfoEvent;
    FOnCustomDrawPreview: TcxCustomDrawEditCellViewInfoEvent;
    FOnCustomizationVisibleChanged: TNotifyEvent;
    FOnDataChanged: TNotifyEvent;
    FOnDeletion: TcxTreeListNodeChangedEvent;
    FOnExpanded: TcxTreeListNodeChangedEvent;
    FOnExpanding: TcxTreeListNodeChangingEvent;
    FOnFocusedColumnChanged: TcxTreeListFocusedColumnChanged;
    FOnFocusedNodeChanged: TcxTreeListFocusedChangedEvent;
    FOnGetNodeImageIndex: TcxTreeListGetNodeImageIndexEvent;
    FOnGetNodePreviewHeight: TcxTreeListGetNodePreviewHeightEvent;
    FOnGetNodeHeight: TcxTreeListGetNodeHeight;
    FOnHotTrackNode: TcxTreeListOnHotTrackNodeEvent;
    FOnIsGroupNode: TcxTreeListIsGroupNodeEvent;
    FOnLayoutChanged: TNotifyEvent;
    FOnMoveTo: TcxTreeListMoveToEvent;
    FOnNodeChanged: TcxTreeListNodeDataChangedEvent;
    FOnSelectionChanged: TNotifyEvent;
    FOnSorting: TNotifyEvent;
    FOnTopRecordIndexChanged: TNotifyEvent;
    function GetBands: TcxTreeListBands;
    function GetBandPanelHeight: Integer;
    function GetColumn(AIndex: Integer): TcxTreeListColumn;
    function GetColumnCount: Integer;
    function GetColumnsList: TList;
    function GetController: TcxTreeListController;
    function GetCount: Integer;
    function GetDefaultRowHeight: Integer;
    function GetFixedBandCount: Integer;
    function GetFooterHeight: Integer;
    function GetFocusedColumn: TcxTreeListColumn;
    function GetFocusedNode: TcxTreeListNode;
    function GetHeaderHeight: Integer;
    function GetHeaderPanelHeight: Integer;
    function GetHitTest: TcxTreeListHitTest;
    function GetInplaceEditor: TcxCustomEdit;
    function GetInplaceColumnIndex: Integer;
    function GetIsEditing: Boolean;
    function GetItem(Index: Integer): TcxTreeListNode;
    function GetLastNode: TcxTreeListNode;
    function GetLastVisibleNode: TcxTreeListNode;
    function GetNavigatorIsActive: Boolean;
    function GetOnAfterSummary: TcxAfterSummaryEvent;
    function GetOnEdited: TcxTreeListColumnChangedEvent;
    function GetOnEditing: TcxTreeListEditingEvent;
    function GetOnEditValueChanged: TcxTreeListColumnChangedEvent;
    function GetOnSummary: TcxSummaryEvent;
    function GetOptionsBehavior: TcxTreeListOptionsBehavior;
    function GetOptionsData: TcxTreeListOptionsData;
    function GetOptionsView: TcxTreeListOptionsView;
    function GetSearching: Boolean;
    function GetSearchingText: string;
    function GetSelection(Index: Integer): TcxtreeListNode;
    function GetSelectionCount: Integer;
    function GetSorted: Boolean;
    function GetSortedColumnCount: Integer;
    function GetSortedColumn(Index: Integer): TcxTreeListColumn;
    function GetStyles: TcxTreeListStyles;
    function GetSummary: TcxDataSummary;
    function GetTopNode: TcxTreeListNode;
    function GetTopVisibleIndex: Integer;
    function GetTopVisibleNode: TcxTreeListNode;
    function GetVisibleCount: Integer;
    function GetViewInfo: TcxTreeListViewInfo;
    function GetVisibleBand(AIndex: Integer): TcxTreeListBand;
    function GetVisibleBandCount: Integer;
    function GetVisibleColumn(AIndex: Integer): TcxTreeListColumn;
    function GetVisibleColumnCount: Integer;
    function IsDefaultRowHeightAssigned: Boolean;
    procedure SetBands(Value: TcxTreeListBands);
    procedure SetColumn(AIndex: Integer; Value: TcxTreeListColumn);
    procedure SetDefaultRowHeight(Value: Integer);
    procedure SetDefaultLayout(Value: Boolean);
    procedure SetFocusedColumn(Value: TcxTreeListColumn);
    procedure SetFocusedNodeProp(Value: TcxTreeListNode);
    procedure SetImages(Value: TCustomImageList);
    procedure SetInternalImageList(AList: TCustomImageList; var Value: TCustomImageList; ALink: TChangeLink);
    procedure SetLastVisibleNode(Value: TcxTreeListNode);
    procedure SetNodes(Value: TcxTreeListNodes);
    procedure SetOnAfterSummary(Value: TcxAfterSummaryEvent);
    procedure SetOnEdited(Value: TcxTreeListColumnChangedEvent);
    procedure SetOnEditing(Value: TcxTreeListEditingEvent);
    procedure SetOnEditValueChanged(Value: TcxTreeListColumnChangedEvent);
    procedure SetOnSummary(Value: TcxSummaryEvent);
    procedure SetOptionsBehavior(Value: TcxTreeListOptionsBehavior);
    procedure SetOptionsCustomizing(Value: TcxTreeListOptionsCustomizing);
    procedure SetOptionsData(Value: TcxTreeListOptionsData);
    procedure SetOptionsSelection(Value: TcxTreeListOptionsSelection);
    procedure SetOptionsView(Value: TcxTreeListOptionsView);
    procedure SetPreview(Value: TcxTreeListPreview);
    procedure SetSearchingText(const Value: string);
    procedure SetSorted(Value: Boolean);
    procedure SetStateImages(Value: TCustomImageList);
    procedure SetStyles(Value: TcxTreeListStyles);
    procedure SetTopVisibleIndex(AValue: Integer);
    procedure SetTopVisibleNode(ANode: TcxTreeListNode);
    procedure SetVisibleBand(Index: Integer; AValue: TcxTreeListBand);
    procedure SetVisibleColumn(Index: Integer; AValue: TcxTreeListColumn);
    procedure DoChangedTimer(Sender: TObject);
    procedure UpdateDesignerForms;
    // IcxStoredObject
    function GetObjectName: string;
    function GetProperties(AProperties: TStrings): Boolean;
    procedure GetPropertyValue(const AName: string; var AValue: Variant);
    procedure SetPropertyValue(const AName: string; const AValue: Variant);
    // IcxStoredParent
    function IcxStoredParent.CreateChild = StoredCreateChild;
    procedure IcxStoredParent.DeleteChild = StoredDeleteChild;
    procedure IcxStoredParent.GetChildren = GetStoredChildren;
    // messages
    procedure CMDrag(var Message: TCMDrag); message CM_DRAG;
  protected
    FMaxIndentWidth: Integer;
    procedure AssignColumnWidths;
    procedure AssignLeftMostWidths;
    procedure BoundsChanged; override;
    // TL procedures
    function AddNode(ANode, ARelative: TcxTreeListNode; AData: Pointer;
      AttachMode: TcxTreeListNodeAttachMode): TcxTreeListNode; virtual;
    procedure BeforeAddNode(ANewNode, ANewParent: TcxTreeListNode;
      AMode: TcxTreeListNodeAddMode); virtual;
    procedure BeforeCalculate; virtual;
    procedure BeforeShowingEdit;
    procedure CalculateLeftMostIndentWidth;
    function CanAddIndentWidth(const AIndentWidth: Integer): Boolean; virtual;
    function CanColumnVisible(AColumn: TcxTreeListColumn): Boolean; virtual;
    function CanMultiSelect: Boolean; virtual;
    procedure CheckFocusedItem;
    procedure ColumnSortOrderChanged(AColumn: TcxTreeListColumn);
    procedure DoAssignNodes(Source: TcxTreeListNodes); virtual;
    procedure DoBandSizeChanged(ABand: TcxTreeListBand); virtual;
    procedure DoClear; virtual;
    procedure DoColumnSizeChanged(AColumn: TcxTreeListColumn); virtual;
    function DoCreateColumn: TcxTreeListColumn;
    procedure DoDeleteSelection;
    procedure AddToDelitionList(ANode: TcxTreeListNode); virtual;
    procedure DoRemoveNode(ANode: TcxTreeListNode); virtual;
    procedure DoCheckDeletedNode(ANode: TcxTreeListNode); virtual;
    procedure DoDeleteNode(ANode: TcxTreeListNode); virtual;
    procedure DoInplaceEditContainerItemRemoved(AItem: TcxCustomInplaceEditContainer); override;
    procedure DoInternalMoveTo(AttachNode: TcxTreeListNode;
      AttachMode: TcxTreeListNodeAttachMode; ANodes: TList; IsCopy: Boolean);
    procedure DoMoveTo(AttachNode: TcxTreeListNode;
      AttachMode: TcxTreeListNodeAttachMode; ANodes: TList; IsCopy: Boolean); virtual;
    // doXXXX metods fire OnXXXX events
    procedure DoOnAfterSorting; virtual;
    procedure DoOnBandSizeChanged(ABand: TcxTreeListBand); virtual;
    procedure DoOnColumnSizeChanged(AColumn: TcxTreeListColumn); virtual;
    procedure DoOnCollapsed(ANode: TcxTreeListNode); virtual;
    procedure DoOnCollapsing(ANode: TcxTreeListNode; var Allow: Boolean); virtual;
    procedure DoOnCompare(ANode1, ANode2: TcxTreeListNode; var ACompare: Integer); virtual;
    procedure DoOnCustomizationVisibleChanged; virtual;
    procedure DoOnDeletion(ANode: TcxTreeListNode); virtual;
    procedure DoOnExpanded(ANode: TcxTreeListNode); virtual;
    procedure DoOnExpanding(ANode: TcxTreeListNode; var Allow: Boolean); virtual;
    procedure DoOnGetNodeHeight(ANode: TcxTreeListNode; var AHeight: Integer); virtual;
    procedure DoOnHotTrackNode(ANode: TcxTreeListNode; AShift: TShiftState; var ACursor: TCursor); virtual;
    procedure DoOnIsGroupNode(ANode: TcxTreeListNode; var IsGroup: Boolean); virtual;
    procedure DoOnMoveTo(AttachNode: TcxTreeListNode; AttachMode: TcxTreeListNodeAttachMode; Nodes: TList; var IsCopy, Done: Boolean); virtual;
    procedure DoOnTopRecordIndexChanged; virtual;
    procedure DoStartDrag(var DragObject: TDragObject); override;
    //
    function DoWriteHeaderToText: string; virtual;
    function DoWriteNodeToText(ANode: TcxTreeListNode): string; virtual;
    procedure DoWriteToClipboard(AOnlySelected: Boolean); virtual;
    function DoWriteToText(AOnlySelected: Boolean; out AText: string): Boolean;
    procedure DoUpdateDesignerForms; virtual;
    procedure DoDeleteRecords; virtual;
    procedure DoValidateDeletedNodes; virtual;
    procedure DeleteSelectionList(AList: TList); virtual;
    function GetCountNodeForBestFit: Integer; virtual;
    function GetImageIndentWidth(AType: TcxTreeListImageIndexType): Integer; virtual;
    function GetIsActive: Boolean; virtual;
    function GetFixedContentSize: Integer; virtual;
    function GetLevelIndentCount(ALevel: Integer; AWithImages: Boolean; ANode: TcxTreeListNode): Integer;
    function GetLevelIndentsWidth(ALevel: Integer; AWithImages: Boolean; ANode: TcxTreeListNode): Integer; virtual;
    function GetMaxBandWidth(ABand: TcxTreeListBand): Integer;
    function GetMouseWheelScrollingKind: TcxMouseWheelScrollingKind; override;
    function GetStartNodeForBestFit: TcxTreeListNode; virtual;
    function HasImages: Boolean;
    function ImagesIndentWidth: Integer; virtual;
    function InsertNode(IsAppend: Boolean): Boolean; virtual;
    procedure InternalMove(ANode, ADestNode: TcxTreeListNode; AMode: TcxTreeListNodeAttachMode); virtual;
    procedure InternalCopy(ANode, ADestNode: TcxTreeListNode); virtual;
    function IsMultiSelect: Boolean;
    function IsCancelOperation: Boolean; virtual;
    function IsSmartLoad: Boolean; virtual;
    function IsNodeInserted(ANode: TcxTreeListNode): Boolean;
    function IsNodeEdited(ANode: TcxTreeListNode): Boolean;
    procedure MakeNodeVisible(ANode: TcxTreeListNode); virtual;
    procedure OnChangeImages(Sender: TObject); virtual;
    procedure SaveDragPos; virtual;
    procedure RestoreDragPos; virtual;
    function RealBandLineHeight: Integer;
    procedure ReadData(AStream: TStream); virtual;
    procedure RealignBands; virtual;
    procedure RefreshVisibleIndexes;
    procedure RestoreCursor;
    procedure RestoreSorting; virtual;
    function SkipFocusedRecordChanged: Boolean; virtual;
    function SkipCancelOperation: Boolean; virtual;
    procedure SetGlassCursor;
    procedure SortingStateChanged(AColumn: TcxTreeListColumn; AShift: TShiftState);
    procedure UpdateEditValue;
    procedure WriteData(AStream: TStream); virtual;
    // IcxTreeListDesignTimeOperations implementation
    function SupportsBandColumnEditor: Boolean; virtual;
    function SupportsItemsEditor: Boolean; virtual;
    function SupportsCreateAllItems: Boolean; virtual;
    function GetVersion: string; virtual;
    procedure CreateAllItems; virtual;
    // IcxNavigator
    function IcxNavigator.IsActive = GetNavigatorIsActive;
    function IcxNavigator.IsEditing = GetIsEditing;
    function IcxNavigator.IsBof = IsBof;
    function IcxNavigator.IsEof = IsEof;

    procedure RefreshNavigatorButtons;
    procedure DoAction(AButtonIndex: Integer);
    function GetNotifier: TcxNavigatorControlNotifier;
    function IsActionSupported(AButtonIndex: Integer): Boolean;

    function CanAppend: Boolean;
    function CanEdit: Boolean;
    function CanDelete: Boolean;
    function CanInsert: Boolean;

    procedure ClearBookmark;
    procedure GotoBookmark;
    function HasData: Boolean;
    function IsBookmarkAvailable: Boolean;
    procedure SaveBookmark;
    function UseRowIndexForNewRecord: Boolean; virtual;
    // updates
    procedure Freeze;
    procedure UnFreeze;
    function IsFreeze: Boolean;
    function IsLocked: Boolean; override;
    // nodes
    function CreateNode: TcxTreeListNode; virtual;
    function DoCanNodeCollapse(ANode: TcxTreeListNode): Boolean; virtual;
    function DoCanNodeExpand(ANode: TcxTreeListNode): Boolean; virtual;
    function DoCreateNode: TcxTreeListNode;
    function DoGetNodeImageIndex(ANode: TcxTreeListNode; AIndex: TcxTreeListImageIndexType): TImageIndex; virtual;
    function DoGetNodeValueCount: Integer; virtual;
    procedure DoNodeChanged(ANode: TcxTreeListNode); virtual;
    function DoIsGroupNode(ANode: TcxTreeListNode): Boolean; virtual;
    procedure DoSelectAll; virtual;
    procedure DoSetNodeExpanded(ANode: TcxTreeListNode; AExpanded: Boolean); virtual;
    procedure DoSetNodeImageIndex(ANode: TcxTreeListNode; AIndex: TcxTreeListImageIndexType; Value: TImageIndex); virtual;
//    procedure DoSetNodeSelected(ANode: TcxTreeListNode; Value: Boolean; Shift: TShiftState = []); virtual;
    procedure DoSetNodeFocused(ANode: TcxTreeListNode; Value: Boolean; Shift: TShiftState = []); virtual;
    procedure DoSorting; virtual;
    function GetColumnById(AItemIndex: Integer): TcxTreeListColumn;
    function GetNodeByID(ARecordIndex: Integer): TcxTreeListNode;
    function GetSelectionsEx: TList;
    // sorting
    procedure CancelSortPost;
    procedure DisableSorting;
    procedure DoSortNodes; virtual;
    procedure EnableSorting;
    procedure NeedSortPost;
    function IsNeedSortPost: Boolean;
    procedure RecreateSortOrdersList; virtual;

    // events generation
    function CheckEvent(AHasHandler: Boolean): Boolean;

    procedure DoBandHeaderClick(ABand: TcxTreeListBand); virtual;
    procedure DoColumnHeaderClick(AColumn: TcxTreeListColumn); virtual;
    procedure DoChanged(BlockChangedEvent: Boolean = True); virtual;
    function DoCanSelectNode(ANode: TcxTreeListNode): Boolean; virtual;
    procedure DoDataChangedEvent(Sender: TObject); virtual;

    procedure DoEditChanged(AItem: TcxCustomInplaceEditContainer); override;
    procedure DoEdited(AItem: TcxCustomInplaceEditContainer); override;
    function DoEditing(AItem: TcxCustomInplaceEditContainer): Boolean; override;
    procedure DoEditValueChanged(AItem: TcxCustomInplaceEditContainer); override;
    procedure DoInitEdit(AItem: TcxCustomInplaceEditContainer; AEdit: TcxCustomEdit); override;

    procedure DoFocusedItemChanged(APrevFocusedItem,
      AFocusedItem: TcxCustomInplaceEditContainer); virtual;
    procedure DoFocusedRecordChanged(APrevIndex, AFocusedIndex: Integer); virtual;
    procedure DoLayoutChangedEvent; virtual;
    procedure DoRecordChanged(Sender: TcxCustomDataController;
      ARecordIndex, AItemIndex: Integer); virtual;
    procedure DoSelectionChanged; virtual;
    // selection
    procedure BeginUpdateSelection;
    procedure CancelUpdateSelection;
    procedure EndUpdateSelection;
    function IsSelectionLocked: Boolean;
    procedure UpdateSelection; virtual;
    procedure CancelFocusedRecordUpdatePost;
    procedure PostUpdateFocusedRecord;
    procedure UpdateFocusedRecordPost;
    // used classes
    function GetBandItemClass: TcxTreeListBandClass; virtual;
    function GetControllerClass: TcxCustomControlControllerClass; override;
    function GetControlStylesClass: TcxCustomControlStylesClass; override;
    function GetHitTestControllerClass: TcxHitTestControllerClass; override;
    function GetNodesClass: TcxTreeListNodesClass; virtual;
    function GetOptionsCustomizingClass: TcxTreeListOptionsCustomizingClass; virtual;
    function GetOptionsBehaviorClass: TcxControlOptionsBehaviorClass; override;
    function GetOptionsDataClass: TcxControlOptionsDataClass; override;
    function GetOptionsSelectionClass: TcxTreeListOptionsSelectionClass; virtual;
    function GetOptionsViewClass: TcxControlOptionsViewClass; override;
    function GetPainterClass: TcxCustomControlPainterClass; override;
    function GetPreviewClass: TcxTreeListPreviewClass; virtual;
    function GetTreeListColumnClass: TcxTreeListColumnClass; virtual;
    function GetTreeListCustomizingClass: TcxTreeListCustomizingClass; virtual;
    function GetViewInfoClass: TcxCustomControlViewInfoClass; override;
    procedure UpdateColumn(ANode: TcxTreeListNode; AColumn: TcxTreeListColumn); virtual;
    procedure UpdateNode(ANode: TcxTreeListNode); virtual;
    // overrided methods
    procedure AfterLayoutChanged; override;
    procedure BeforeUpdate; override;
    procedure CheckCreateDesignSelectionHelper; override;
    procedure ControlUpdateData(AInfo: TcxUpdateControlInfo); override;
    procedure CreateSubClasses; override;
    procedure DataChanged; override;
    procedure DataLayoutChanged; override;
    procedure DestroySubClasses; override;
    procedure DoLayoutChanged; override;
    function DragDropImageDisplayRect: TRect; override;
    procedure DrawDragDropImage(ADragBitmap: TBitmap; ACanvas: TcxCanvas); override;
    procedure ForceRefresh;
    function GetDragDropText: string; virtual;
    function GetDragDropViewParams: TcxViewParams; virtual;
    function GetDragObjectClass: TDragControlObjectClass; override;
    function GetImageListHeight(AImageList: TCustomImageList): Integer; virtual;
    procedure InitScrollBarsParameters; override;
    procedure LookAndFeelChanged(Sender: TcxLookAndFeel; AChangedValues: TcxLookAndFeelValues); override;
    procedure ReadState(Reader: TReader); override;
    procedure Updated; override;
    procedure Updating; override;
    // inherits for loading bug fixing
    procedure AssignColumnsParams; virtual;
    procedure SaveColumnsParams; virtual;

    // cxStorage implementation
    procedure GetStoredChildren(AChildren: TStringList); virtual;
    function GetStoredObjectName: string; virtual;
    function GetStoredObjectProperties(AProperties: TStrings): Boolean; virtual;
    procedure GetStoredPropertyValue(const AName: string; var AValue: Variant); virtual;
    procedure RestoreTopPos;
    procedure StoreTopPos;
    procedure SetStoredPropertyValue(const AName: string; const AValue: Variant); virtual;
    function StoredCreateChild(const AObjectName, AClassName: string): TObject; virtual;
    procedure StoredDeleteChild(const AObjectName: string; AObject: TObject); virtual;
    // standart control metods
  {$IFNDEF DELPHI12}
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
  {$ENDIF}
    function IsUpdating: Boolean;
    procedure Loaded; override;
    procedure Modified; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetName(const NewName: TComponentName); override;

    property Bands: TcxTreeListBands read GetBands write SetBands;
    property CheckedList: TList read FCheckedList write FCheckedList;
    property ColumnCount: Integer read GetColumnCount;
    property Columns[Index: Integer]: TcxTreeListColumn read GetColumn write SetColumn;
    property ColumnsList: TList read GetColumnsList;
    property Controller: TcxTreeListController read GetController;
    property Customizing: TcxTreeListCustomizing read FCustomizing write FCustomizing;
    property DefaultLayout: Boolean read FDefaultLayout write SetDefaultLayout default False;
    property DeletedNodes: TList read FDeletedNodes write FDeletedNodes;
    property Designers: TList read FDesigners;
    property FixedBandCount: Integer read GetFixedBandCount;
    property FocusedColumn: TcxTreeListColumn read GetFocusedColumn write SetFocusedColumn;
    property HeaderLineCount: Integer read FHeaderLineCount;
    property HitTest: TcxTreeListHitTest read GetHitTest;
    property IsRestore: Boolean read FIsRestore write FIsRestore;  
    property Images: TCustomImageList read FImages write SetImages;
    property LastVisibleNode: TcxTreeListNode read GetLastVisibleNode write SetLastVisibleNode;
    property LockChanges: Boolean read FLockChanges write FLockChanges;
    property Nodes: TcxTreeListNodes read FNodes write SetNodes;
    property NodesList: TList read FNodesList write FNodesList;
    property NeedRestoreSorting: Boolean read FNeedRestoreSorting write FNeedRestoreSorting;
    property OptionsBehavior: TcxTreeListOptionsBehavior read GetOptionsBehavior write SetOptionsBehavior;
    property OptionsCustomizing: TcxTreeListOptionsCustomizing read FOptionsCustomizing write SetOptionsCustomizing;
    property OptionsData: TcxTreeListOptionsData read GetOptionsData write SetOptionsData;
    property OptionsSelection: TcxTreeListOptionsSelection read FOptionsSelection write SetOptionsSelection;
    property OptionsView: TcxTreeListOptionsView read GetOptionsView write SetOptionsView;
    property Preview: TcxTreeListPreview read FPreview write SetPreview;
    property SafeDelete: Boolean read FSafeDelete write FSafeDelete;
    property SelectionCount: Integer read GetSelectionCount;
    property Selections[Index: Integer]: TcxTreeListNode read GetSelection;
    property SortedColumnCount: Integer read GetSortedColumnCount;
    property SortedColumns[Index: Integer]: TcxTreeListColumn read GetSortedColumn;
    property SortOrderList: TList read FSortOrderList;
    property StateImages: TCustomImageList read FStateImages write SetStateImages;
    property StoredCursor: TCursor read FStoredCursor;
    property StylesEvents: TNotifyEvent read FStylesEvents write FStylesEvents;
    property TopVisibleIndex: Integer read GetTopVisibleIndex write SetTopVisibleIndex;
    property TopVisibleNode: TcxTreeListNode read GetTopVisibleNode write SetTopVisibleNode;
    property ViewInfo: TcxTreeListViewInfo read GetViewInfo;
    property VisibleBandCount: Integer read GetVisibleBandCount;
    property VisibleBands[Index: Integer]: TcxTreeListBand read GetVisibleBand write SetVisibleBand;
    property VisibleColumnCount: Integer read GetVisibleColumnCount;
    property VisibleColumns[Index: Integer]: TcxTreeListColumn read GetVisibleColumn write SetVisibleColumn;
    property VisibleCount: Integer read GetVisibleCount;
    property OnAfterSorting: TNotifyEvent read FOnAfterSorting write FOnAfterSorting;
    property OnAfterSummary: TcxAfterSummaryEvent read GetOnAfterSummary write SetOnAfterSummary;
    property OnBandHeaderClick: TcxTreeListBandChangedEvent read FOnBandHeaderClick write FOnBandHeaderClick;
    property OnBandSizeChanged: TcxTreeListItemChangedEvent read FOnBandSizeChanged write FOnBandSizeChanged;
    property OnCanSelectNode: TcxTreeListNodeChangingEvent read FOnCanSelectNode write FOnCanSelectNode;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnCollapsed: TcxTreeListNodeChangedEvent read FOnCollapsed write FOnCollapsed;
    property OnCollapsing: TcxTreeListNodeChangingEvent read FOnCollapsing write FOnCollapsing;
    property OnColumnHeaderClick: TcxTreeListColumnChangedEvent read FOnColumnHeaderClick write FOnColumnHeaderClick;
    property OnColumnSizeChanged: TcxTreeListItemChangedEvent read FOnColumnSizeChanged write FOnColumnSizeChanged;
    property OnCompare: TcxTreeListNodeCompareEvent read FOnCompare write FOnCompare;
    property OnCustomDrawBackground: TcxCustomDrawBackgroundEvent read FOnCustomDrawBackground write FOnCustomDrawBackground;
    property OnCustomDrawBandHeader: TcxCustomDrawHeaderViewInfoEvent read FOnCustomDrawBandHeader write FOnCustomDrawBandHeader;
    property OnCustomDrawCell: TcxCustomDrawEditCellViewInfoEvent read FOnCustomDrawCell write FOnCustomDrawCell;
    property OnCustomDrawCellsGroup: TcxCustomDrawCellsGroupViewInfoEvent read FOnCustomDrawCellsGroup write FOnCustomDrawCellsGroup;
    property OnCustomDrawFooter: TcxCustomDrawBandViewInfoEvent read FOnCustomDrawFooter write FOnCustomDrawFooter;
    property OnCustomDrawFooterCell: TcxCustomDrawFooterItemViewInfoEvent read FOnCustomDrawFooterCell write FOnCustomDrawFooterCell;
    property OnCustomDrawHeader: TcxCustomDrawBandViewInfoEvent read FOnCustomDrawHeader write FOnCustomDrawHeader;
    property OnCustomDrawHeaderCell: TcxCustomDrawHeaderViewInfoEvent read FOnCustomDrawHeaderCell write FOnCustomDrawHeaderCell;
    property OnCustomDrawIndentCell: TcxCustomDrawIndentViewInfoEvent read FOnCustomDrawIndentCell write FOnCustomDrawIndentCell;
    property OnCustomDrawIndicatorCell: TcxCustomDrawIndicatorViewInfoEvent read FOnCustomDrawIndicatorCell write FOnCustomDrawIndicatorCell;
    property OnCustomDrawPreview: TcxCustomDrawEditCellViewInfoEvent read FOnCustomDrawPreview write FOnCustomDrawPreview;
    property OnCustomizationFormVisibleChanged: TNotifyEvent read FOnCustomizationVisibleChanged write FOnCustomizationVisibleChanged;
    property OnDataChanged: TNotifyEvent read FOnDataChanged write FOnDataChanged;
    property OnDeletion: TcxTreeListNodeChangedEvent read FOnDeletion write FOnDeletion;
    property OnEdited: TcxTreeListColumnChangedEvent read GetOnEdited write SetOnEdited;
    property OnEditing: TcxTreeListEditingEvent read GetOnEditing write SetOnEditing;
    property OnEditValueChanged: TcxTreeListColumnChangedEvent read GetOnEditValueChanged write SetOnEditValueChanged;
    property OnExpanded: TcxTreeListNodeChangedEvent read FOnExpanded write FOnExpanded;
    property OnExpanding: TcxTreeListNodeChangingEvent read FOnExpanding write FOnExpanding;
    property OnFocusedColumnChanged: TcxTreeListFocusedColumnChanged read FOnFocusedColumnChanged write FOnFocusedColumnChanged;
    property OnFocusedNodeChanged: TcxTreeListFocusedChangedEvent read FOnFocusedNodeChanged write FOnFocusedNodeChanged;
    property OnGetNodeHeight: TcxTreeListGetNodeHeight read FOnGetNodeHeight write FOnGetNodeHeight;
    property OnGetNodeImageIndex: TcxTreeListGetNodeImageIndexEvent read FOnGetNodeImageIndex write FOnGetNodeImageIndex;
    property OnGetNodePreviewHeight: TcxTreeListGetNodePreviewHeightEvent read FOnGetNodePreviewHeight write FOnGetNodePreviewHeight;
    property OnHotTrackNode: TcxTreeListOnHotTrackNodeEvent read FOnHotTrackNode write FOnHotTrackNode;
    property OnIsGroupNode: TcxTreeListIsGroupNodeEvent read FOnIsGroupNode write FOnIsGroupNode;
    property OnLayoutChanged: TNotifyEvent read FOnLayoutChanged write FOnLayoutChanged;
    property OnMoveTo: TcxTreeListMoveToEvent read FOnMoveTo write FOnMoveTo;
    property OnNodeChanged: TcxTreeListNodeDataChangedEvent read FOnNodeChanged write FOnNodeChanged;
    property OnSelectionChanged: TNotifyEvent read FOnSelectionChanged write FOnSelectionChanged;
    property OnSorting: TNotifyEvent read FOnSorting write FOnSorting;
    property OnSummary: TcxSummaryEvent read GetOnSummary write SetOnSummary;
    property OnTopRecordIndexChanged: TNotifyEvent read FOnTopRecordIndexChanged write FOnTopRecordIndexChanged;
   //
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AdjustColumnsWidth;
    procedure ApplyBestFit;
    procedure Clear;
    function CreateColumn(ABand: TcxTreeListBand = nil): TcxTreeListColumn; virtual;
    procedure DeleteAllColumns; virtual;
    procedure DeleteSelection;
    procedure DragDrop(Source: TObject; X, Y: Integer); override;
  {$IFDEF DELPHI12}
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
  {$ENDIF}
    function GetIndentWidth(IsLeftMost: Boolean): Integer;
    procedure MakeDefaultLayout; virtual;
    procedure FullCollapse;
    procedure FullExpand;
    procedure FullRefresh; virtual;
    function Find(AData: Pointer; AStart: TcxTreeListNode; AExpandedOnly, AForward: Boolean;
     AFilter: TcxTreeListFindFunc): TcxTreeListNode; virtual;
    function FindNodeByText(const AText: string; AColumn: TcxTreeListColumn;
      AStartNode: TcxTreeListNode = nil; AExpandedOnly: Boolean = False; AForward: Boolean = True): TcxTreeListNode;
    procedure SelectAll;
    procedure Select(Node: TcxTreeListNode; ShiftState: TShiftState = []); overload; virtual;
    procedure Select(const ANodes: array of TcxTreeListNode); overload; virtual;
    procedure Select(ANodes: TList); overload; virtual;
    procedure SetFocusedNode(Value: TcxTreeListNode; AShift: TShiftState);
    procedure SetColumnSortOrder(AColumn: TcxTreeListColumn;
      ASortOrder: TcxDataSortOrder; AShift: TShiftState);
    function StartDrag(DragObject: TDragObject): Boolean; override;
    procedure Subselect(Node: TcxTreeListNode); virtual;
    procedure Deselect(Node: TcxTreeListNode); virtual;
    procedure ClearSelection(KeepPrimary: Boolean = False); virtual;
    procedure ClearSorting;
    function ColumnByName(const AName: string): TcxTreeListColumn;
    function GetSelections(AList: TList): TcxTreeListNode;
    // navigation
    procedure GotoBOF;
    procedure GotoEOF;
    procedure GotoNext;
    procedure GotoNextPage;
    procedure GotoPrev;
    procedure GotoPrevPage;
    function IsBOF: Boolean;
    function IsEOF: Boolean;
    // edit control
    procedure CancelEdit;
    procedure HideEdit;
    procedure ShowEdit;
    procedure ShowEditByKey(AKey: Char);
    procedure ShowEditByMouse(X, Y: Integer; AShift: TShiftState);
    // storing layout
    procedure RestoreFromIniFile(const AStorageName: string; AChildrenCreating: Boolean = False;
      AChildrenDeleting: Boolean = False);
    procedure RestoreFromRegistry(const AStorageName: string; AChildrenCreating: Boolean = False;
      AChildrenDeleting: Boolean = False);
    procedure RestoreFromStream(AStream: TStream; AChildrenCreating: Boolean = False;
      AChildrenDeleting: Boolean = False);
    procedure StoreToIniFile(AStorageName: string; AReCreate: Boolean = True);
    procedure StoreToRegistry(AStorageName: string; AReCreate: Boolean = True);
    procedure StoreToStream(AStream: TStream);
    // searching
    function FindNext(AForward: Boolean): Boolean;
    procedure CancelSearching;
    // positions
    function CellRect(ANode: TcxTreeListNode; AColumn: TcxTreeListColumn): TRect;
    function GetEditRect(ANode: TcxTreeListNode; AColumn: TcxTreeListColumn): TRect;
    function GetNodeAt(X, Y: Integer): TcxTreeListNode;
    // misc
    procedure CopyAllToClipboard;
    procedure CopySelectedToClipboard;
    procedure RestoreColumnsDefaults;
    procedure RestoreColumnsWidths;
    property BandPanelHeight: Integer read GetBandPanelHeight;
    property BorderSize;
    property Count: Integer read GetCount;
    property DefaultRowHeight: Integer read GetDefaultRowHeight write SetDefaultRowHeight stored IsDefaultRowHeightAssigned;
    property DragNode: TcxTreeListNode read FDragNode;
    property FocusedNode: TcxTreeListNode read GetFocusedNode write SetFocusedNodeProp;
    property FooterPanelHeight: Integer read GetFooterHeight;
    property HeaderHeight: Integer read GetHeaderHeight;
    property HeaderPanelHeight: Integer read GetHeaderPanelHeight;
    property InplaceColumnIndex: Integer read GetInplaceColumnIndex;
    property InplaceEditor: TcxCustomEdit read GetInplaceEditor;
    property IsActive: Boolean read GetIsActive;
    property IsEditing: Boolean read GetIsEditing;
    property Items[Index: Integer]: TcxTreeListNode read GetItem;
    property LastNode: TcxTreeListNode read GetLastNode;
    property LevelIndentWidth: Integer read FLevelIndentWidth write FLevelIndentWidth;
    property Searching: Boolean read GetSearching;
    property SearchingText: string read GetSearchingText write SetSearchingText;
    property Sorted: Boolean read GetSorted write SetSorted;
    property Styles: TcxTreeListStyles read GetStyles write SetStyles;
    property Summary: TcxDataSummary read GetSummary;
    property TopNode: TcxTreeListNode read GetTopNode;
    property Color;
  end;

  { TcxTreeList }

  TcxTreeList = class(TcxCustomTreeListControl)
  private
    FLoadingTemporaryStream: TMemoryStream;
    function ExCreateNode(AParent, APrev: TcxTreeListNode; var AIndex: Integer): TcxTreeListNode;
  protected
    procedure DoAssignNodes(Source: TcxTreeListNodes); override;
    procedure DoSetNodeImageIndex(ANode: TcxTreeListNode;
      AIndex: TcxTreeListImageIndexType; Value: TImageIndex); override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure Loaded; override;
    function SupportsBandColumnEditor: Boolean; override;
    function SupportsItemsEditor: Boolean; override;
    procedure ReadBinaryData(AStream: TStream);
    procedure ReadData(AStream: TStream); override;
    procedure WriteData(AStream: TStream); override;
  public
    destructor Destroy; override;
    function Add: TcxTreeListNode; overload;
    function Add(ASibling: TcxTreeListNode; AData: Pointer = nil): TcxTreeListNode; overload;
    function AddChild(AParent: TcxTreeListNode; AData: Pointer = nil): TcxTreeListNode;
    function AddChildFirst(AParent: TcxTreeListNode; AData: Pointer = nil): TcxTreeListNode;
    function AddFirst: TcxTreeListNode; overload;
    function AddFirst(ASibling: TcxTreeListNode; AData: Pointer = nil): TcxTreeListNode; overload;
    function AddNode(ANode, ARelative: TcxTreeListNode;
      AData: Pointer; AttachMode: TcxTreeListNodeAttachMode): TcxTreeListNode; override;
    function Insert(ASibling: TcxTreeListNode; AData: Pointer = nil): TcxTreeListNode;
    function InsertEx(ANode, ASibling: TcxTreeListNode; AData: Pointer = nil): TcxTreeListNode;
    procedure LoadFromFile(const AFileName: string);
    procedure LoadFromStream(AStream: TStream);
    procedure SaveToFile(const AFileName: string);
    procedure SaveToStream(AStream: TStream);
    property ColumnCount;
    property Columns;
    property Customizing;
    property FocusedColumn;
    property FocusedNode;
    property HitTest;
    property IsEditing;
    property LevelIndentWidth;
    property Nodes;
    property SelectionCount;
    property Selections;
    property Sorted;
    property SortedColumnCount;
    property SortedColumns;
    property TopVisibleIndex;
    property TopVisibleNode;
    property VisibleBandCount;
    property VisibleBands;
    property VisibleColumnCount;
    property VisibleColumns;
    property VisibleCount;
  published
    property Align;
    property Anchors;
    property Bands;
    property BorderStyle;
    property BufferedPaint;
    property Constraints;
    property Cursor;
    property DefaultLayout;
    property DefaultRowHeight;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
  {$IFDEF DELPHI6}
    property HelpContext;
    property HelpKeyword;
    property HelpType;
  {$ENDIF}
    property Hint;
    property Images;
    property LookAndFeel;
    property OptionsBehavior;
    property OptionsCustomizing;
    property OptionsData;
    property OptionsSelection;
    property OptionsView;
    property ParentColor;
    property ParentFont;
    property PopupMenu;
    property Preview;
    property StateImages;
    property Styles;
    property StylesEvents;
    property TabOrder;
    property TabStop;
    property Visible;
    // TreeList events
    property OnAfterSorting;
    property OnAfterSummary;
    property OnBandHeaderClick;
    property OnBandSizeChanged;
    property OnCanResize;
    property OnCanSelectNode;
    property OnChange;
    property OnClick;
    property OnCollapsed;
    property OnCollapsing;
    property OnColumnHeaderClick;
    property OnColumnSizeChanged;
    property OnCompare;
    property OnConstrainedResize;
    property OnSorting;
  {$IFDEF DELPHI5}
    property OnContextPopup;
  {$ENDIF}
    property OnCustomDrawBackground;
    property OnCustomDrawBandHeader;
    property OnCustomDrawCell;
    property OnCustomDrawCellsGroup;
    property OnCustomDrawFooter;
    property OnCustomDrawFooterCell;
    property OnCustomDrawHeader;
    property OnCustomDrawHeaderCell;
    property OnCustomDrawIndentCell;
    property OnCustomDrawIndicatorCell;
    property OnCustomDrawPreview;
    property OnCustomizationFormVisibleChanged;
    property OnDataChanged;
    property OnDblClick;
    property OnDeletion;
    property OnDockDrop;
    property OnDockOver;
    property OnDragDrop;
    property OnDragOver;
    property OnEdited;
    property OnEditing;
    property OnEditValueChanged;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnExpanded;
    property OnExpanding;
    property OnFocusedColumnChanged;
    property OnFocusedNodeChanged;
    property OnGetNodeImageIndex;
    property OnGetNodePreviewHeight;
    property OnGetSiteInfo;
    property OnHotTrackNode;
    property OnInitEdit;
    property OnIsGroupNode;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnLayoutChanged;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnMoveTo;
    property OnNodeChanged;
    property OnResize;
    property OnSelectionChanged;
    property OnStartDock;
    property OnStartDrag;
    property OnSummary;
    property OnTopRecordIndexChanged;
    property OnUnDock;
  end;

procedure cxTreeListError(const Description: string);
function cxCompareColumnsPos(AItem1, AItem2: Pointer): Integer;
function cxCompareColumnsPosEx(AItem1, AItem2: Pointer): Integer;

var
  DesignerNavigatorProc: procedure(AListener: TObject; AddListener: Boolean) of object;

implementation

{$R cxTL.res}

const
  cxTreeListVersion = $00040002;

  cxInvalidIndex   =    -1;
  cxMinCapacityInc =    32;
  cxMaxCapacityInc = 32768;

  cxDefaultImageIndexes: TcxTreeListNodeImageIndexes = (0, 0, -1);

  // internal column state

  tlcsVisible  = $08;

  // internal band state
  tlbsVisible    = $00;
  tlbsFixedLeft  = $02;
  tlbsFixedRight = $04;
  tlbsAllFixed   = tlbsFixedRight or tlbsFixedLeft;

  ColumnPropertiesName: array[0..11] of string =
    ('Visible', 'Index', 'LineCount', 'ColIndex', 'RowIndex',
     'BandIndex', 'Caption', 'SortOrder', 'SortIndex', 'RealMinWidth', 'IsWidthAssigned', 'RealWidth');
  BandPropertiesName: array[0..4] of string =
    ('Caption', 'RealMinWidth', 'RealWidth', 'Visible', 'Index');

  GridLineBorders: array[TcxTreeListGridLines] of TcxBorders =
    ([], [bTop, bBottom], [bLeft, bRight], cxBordersAll);

type
  TAllowExpandChangingFunc = function: Boolean of object;

  TcxDataControllerAccess = class(TcxDataController);
  TcxItemDataBindingAccess = class(TcxItemDataBinding);
  TControlAccess = class(TWinControl);
  TcxEditingControllerAccess = class(TcxEditingController);

  TcxDefColorFunc = function: TColor of object;

  TcxTreeListDataSignature = packed record
    Version, Size: Integer;
  end;

  { TSortingManager }

  PNodesList = ^TNodesList;
  TNodesList = array[0..MaxInt div SizeOf(Pointer) - 1] of TcxTreeListNode;

  PcxSortData = ^TcxSortData;
  TcxSortData = record
    Count: Integer;
    Items: PIntArray;
  end;

  PcxSortingItem = ^TcxSortingItem;
  TcxSortingItem = packed record
    Capacity: Integer;
    Compare: TcxTreeListCompareFunc;
    IsInternalCompare: Boolean;
    Count: Integer;
    DataController: TcxCustomDataController;
    NodesList: PNodesList;
    Node: TcxTreeListNode;
    NeedUpdate: Boolean;
    TreeList: TcxCustomTreeListControl;
    SortOrderList: TList;
    Recurse: Boolean;
    RefCount: Integer;
  end;

  TSortingManager = class
  private
    FList: TList;
  protected
    function AddItem(ANode: TcxTreeListNode; ACompare: TcxTreeListCompareFunc;
      ARecurse: Boolean): PcxSortingItem;
    procedure DoneItem(AItem: PcxSortingItem);
    procedure InitItem(AItem: PcxSortingItem);
    procedure InternalSort(AItem: PcxSortingItem);
    procedure InternalSortChildren(AItem: PcxSortingItem);
    procedure UpdateLinks(AItem: PcxSortingItem);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Sort(ANode: TcxTreeListNode;
      ACompare: TcxTreeListCompareFunc; ARecurse: Boolean = False);
  end;

  { TcxTemporaryCellViewInfo }

  TcxTemporaryCellViewInfo = class(TcxTreeListEditCellViewInfo)
  private
    function GetNode: TcxTreeListNode; override;
    function GetNodesViewInfo: TcxTreeListNodesViewInfo; override;
    function GetNodeViewInfo: TcxTreeListNodeViewInfo; override;
    function GetTreeList: TcxCustomTreeListControl; override;
  protected
    CellColumn: TcxTreeListColumn;
    NodeIsFocused: Boolean;
    CellNode: TcxTreeListNode;
    function ContentOffset: TRect; override;
    function GetButtonTransparency: TcxEditButtonTransparency; override;
    function GetColumn: TcxTreeListColumn; override;
    function GetEditContainer: TcxCustomInplaceEditContainer; override;
    function GetFocused: Boolean; override;
    function GetLineCount: Integer; override;
    function GetRecordIndex: Integer; override;
    function GetSelected: Boolean; override;
    function IsAutoHeight: Boolean; override;
    function IsEndEllipsis: Boolean; override;
  public
    destructor Destroy; override;
    function CalculateWidth(AColumn: TcxTreeListColumn; ANode: TcxTreeListNode;
      AIsFocused: Boolean; AHeight: Integer): Integer;
    property Column;
    property Node;
    property TreeList;
  end;

var
  SortingManager: TSortingManager;

function cxFind(ATreeList: TcxCustomTreeListControl; AData: Pointer;
  AStart: TcxTreeListNode; AExpandedOnly, AForward: Boolean;
  AFilter: TcxTreeListFindFunc): TcxTreeListNode;

  function LoadChildren(ANode: TcxTreeListNode): Boolean;
  begin
    with ANode do
    begin
      if (FCount = 0) and HasChildren and not Expanded and not AExpandedOnly then
      begin
        ANode.Expanded := True;
        ANode.Expanded := False;
      end;
      Result := (FCount <> 0) and (Expanded or not AExpandedOnly);
    end;
  end;

  function GetNext(ANode: TcxTreeListNode): TcxTreeListNode;
  begin
    Result := ANode;
    if not LoadChildren(Result) then
      while Result <> nil do
      begin
        if Result.FNext <> nil then
        begin
          Result := Result.FNext;
          Break;
        end;
        while (Result <> nil) and (Result.FNext = nil) do
          Result := Result.Parent;
      end
    else
      Result := Result.FFirst;
  end;

  function GetPrev(ANode: TcxTreeListNode): TcxTreeListNode;
  begin
    Result := ANode;
    if Result.FPrev <> nil then
    begin
      Result := Result.FPrev;
      while LoadChildren(Result) do Result := Result.FLast;
    end
    else
    begin
      Result := Result.Parent;
      if Result = ATreeList.Nodes.Root then
        Result := nil;;
    end;
  end;
  
begin
  Result := nil;
  AExpandedOnly := AExpandedOnly or (ATreeList.DataController.LockCount > 0);
  if AStart = nil then
    AStart := ATreeList.FNodes.Root.FFirst;
  ATreeList.BeginUpdate;
  try
    while (AStart <> nil) and (Result = nil) do
    begin
      if AFilter(AStart, AData) then
        Result := AStart
      else
      begin
        if AForward then
          AStart := GetNext(AStart)
        else
          AStart := GetPrev(AStart);
      end;
    end;
    ATreeList.FDataChangedLocked := not AExpandedOnly;
  finally
    ATreeList.EndUpdate;
  end;
  ATreeList.FDataChangedLocked := False;
end;

function cxGetLatest(
  ANode: TcxTreeListNode; ACheckExpanded: Boolean = True): TcxTreeListNode;
begin
  Result := ANode;
  if Result <> nil then
  begin
    if ACheckExpanded then
      while (Result.FCount > 0) and (Result.FState and tlnsCollapsed = 0) do
        Result := Result.FLast
    else
      while Result.Count > 0 do Result := Result.FLast;
  end;
end;

function cxGetState(Flags: Integer; Index: Integer): Boolean;
begin
  Result := (Flags and (1 shl Index)) <> 0;
end;

function cxHitDelta(CanSizing: Boolean): Integer;
begin
  if CanSizing then
    Result := cxtlHitDelta
  else
    Result := 0;
end;

procedure cxRectScaleH(var ARect: TRect; AHeight: Integer);
begin
  with ARect do
  begin
    Top := Top * AHeight;
    Bottom := Top + Bottom * AHeight;
  end;
end;

procedure cxRectSetTopEx(var ARect: TRect; ATop, AHeight: Integer); overload;
begin
  with ARect do
  begin
    Bottom := ATop + AHeight;
    Top := ATop;
  end;
end;

procedure cxRectSetTopEx(var ARect: TRect; const ASrcRect: TRect); overload;
begin
  ARect.Top := ASrcRect.Top;
  ARect.Bottom := ASrcRect.Bottom;
end;

procedure cxRectSetHeightEx(var ARect: TRect; const AHeight: Integer); overload;
begin
  ARect.Bottom := ARect.Top + AHeight;
end;

procedure cxRectSetHeightEx(var ARect: TRect; const ASrcRect: TRect); overload;
begin
  ARect.Bottom := ARect.Top + (ASrcRect.Bottom - ASrcRect.Top);
end;

procedure cxSetMax(var AValue: Integer; ANewValue: Integer);
begin
  if AValue < ANewValue then AValue := ANewValue;
end;

procedure cxSetMin(var AValue: Integer; ANewValue: Integer);
begin
  if AValue > ANewValue then AValue := ANewValue;
end;

function cxExcludeBorders(const ARect: TRect; ABorders: TcxBorders): TRect;
begin
  Result := ARect;
  with Result do
  begin
    Inc(Left, Byte(bLeft in ABorders));
    Inc(Top, Byte(bTop in ABorders));
    Dec(Right, Byte(bRight in ABorders));
    Dec(Bottom, Byte(bBottom in ABorders));
  end;
end;

procedure cxGetIndexes(AList: TList; AItem: TObject;
  var AFromIndex, AToIndex: Integer);
begin
  AFromIndex := 0;
  AToIndex := AList.Count - 1;
  if AList.Last = AItem then
    AToIndex := AList.IndexOf(AItem) -  1
  else
    AFromIndex := AList.IndexOf(AItem) + 1;
end;

procedure cxCalcSeparators(var ASeparators: TcxTreeListSeparators;
  const AControlSeparators: TcxTreeListSeparators; const ABounds: TRect);
var
  I: Integer;
begin
  for I := Low(TcxTreeListSeparators) to High(TcxTreeListSeparators) do
    cxRectIntersect(ASeparators[I], AControlSeparators[I], ABounds);
end;

function cxGetNativeColor(AColor: TColor; ADefColorFunc: TcxDefColorFunc): TColor;
begin
  if AColor = clDefault then
    Result := ADefColorFunc
  else
    Result := AColor;
end;

function cxSetState(var Flags: Integer; Index: Integer; Value: Boolean): Boolean;
begin
  Result := (Flags and (1 shl Index) <> 0) <> Value;
  if Result then
  begin
    if Value then
      Flags := Flags or (1 shl Index)
    else
      Flags := Flags xor (1 shl Index);
  end;
end;

procedure cxValidateIntDef(var Value: Integer; AMin: Integer; AMax: Integer = MaxInt);
begin
  if Value < AMin then
    Value := AMin
  else
    if Value > AMax then
      Value := AMax;
end;

function cxValidateIntDefEx(var Value: Integer; ADefValue: Integer;
  AMin: Integer; AMax: Integer = MaxInt): Boolean;
begin
  cxValidateIntDef(Value, AMin, AMax);
  Result := Value <> ADefValue; 
end;

function cxCheckValue(AValue, AMin, AMax: Integer): Boolean;
begin
  Result := (AValue >= AMin) and (AValue < AMax);
end;

function cxMin(AValue1, AValue2: Integer): Integer;
begin
  if AValue1 > AValue2 then
    Result := AValue2
  else
    Result := AValue1;
end;

function cxMax(AValue1, AValue2: Integer): Integer;
begin
  if AValue1 > AValue2 then
    Result := AValue1
  else
    Result := AValue2;
end;

procedure cxOffsetHorz(var Value: TRect; DX: Integer);
begin
  Inc(Value.Left, DX);
  Inc(Value.Right, DX);
end;

function cxParamsCombine(AStyle: TcxStyle; HasValues: TcxStyleValues;
  var AParams: TcxViewParams): TcxStyleValues;

  function SetValue(AValue: TcxStyleValue; var ASetValues: TcxStyleValues): Boolean;
  begin
    Result := not (AValue in HasValues) and (AValue in AStyle.AssignedValues);
    if Result then Include(ASetValues, AValue);
  end;

begin
  Result := HasValues;
  if (AStyle = nil) or ([svColor, svFont, svTextColor, svBitmap] = HasValues) or
    (csDestroying in AStyle.ComponentState) then Exit;
  with AParams do
  begin
    if SetValue(svColor, Result) then Color := AStyle.Color;
    if (AStyle.Font <> nil) and SetValue(svFont, Result) then Font := AStyle.Font;
    if SetValue(svTextColor, Result) then TextColor := AStyle.TextColor;
    if SetValue(svBitmap, Result) then Bitmap := AStyle.Bitmap;
  end;
end;

function cxCompareColumnsPos(AItem1, AItem2: Pointer): Integer;
begin
  with TcxTreeListColumn(AItem1).Position,  TcxTreeListColumn(AItem2) do
  begin
    Result := FRowIndex - Position.FRowIndex;
    if Result = 0 then
      Result := FColIndex - Position.FColIndex
  end;
end;

function cxCompareColumnsPosEx(AItem1, AItem2: Pointer): Integer;
begin
  with TcxTreeListColumn(AItem1).Position,  TcxTreeListColumn(AItem2) do
  begin
    Result := FRowIndex - Position.FRowIndex;
    if Result = 0 then
      Result := OwnerBandVisibleIndex - Position.OwnerBandVisibleIndex;
    if Result = 0 then
      Result := FColIndex - Position.FColIndex
  end;
end;

function cxCompareVisibleBands(AItem1, AItem2: Pointer): Integer;
const
  AWeights: array[TcxTreeListBandFixedKind] of Integer = (0, -1, 1);
begin
  with TcxTreeListBand(AItem1) do
  begin
    Result := AWeights[FixedKind] - AWeights[TcxTreeListBand(AItem2).FixedKind];
    if Result = 0 then
      Result := Index - TcxTreeListBand(AItem2).Index;
  end;
end;

function cxIntegerListCompare(AItem1, AItem2: Pointer): Integer;
begin
  Result := Integer(AItem1) - Integer(AItem2);
end;

procedure cxCheckObjectList(AList: TList; ACount: Integer;
  AItemClass: TcxCustomViewInfoItemClass; AOwner: TObject);
var
  I: Integer;
begin
  with AList do
  begin
    for I := ACount to Count - 1 do FreeAndNil(TObject(List^[I]));
    I := Count;
    Count := ACount;
    while I < Count do
    begin
      List^[I] := AItemClass.Create(AOwner);
      Inc(I);
    end;
  end;
end;

procedure cxValidateSingleLine(APos: TcxTreeListColumnPosition);
begin
  APos.FRowIndex := 0;
  APos.FLineCount := 1;
end;

procedure cxShiftEditViewInfoItem(
  AViewInfo: TcxTreeListEditCellViewInfo; DX, DY: Integer);
begin
  with AViewInfo do
  begin
    OffsetRect(CellEditRect, DX, DY);;
    OffsetRect(CellContentRect, DX, DY);
    OffsetRect(DisplayRect, DX, DY);
    if ViewInfo <> nil then
    begin
      ViewInfo.Top := CellContentRect.Top;
      ViewInfo.Left := CellContentRect.Left;
    end;
    ItemVisible := cxRectIntersect(ClipRect, DisplayRect, NodesViewInfo.ClipRect);
  end;
end;

procedure cxTreeListError(const Description: string); 
begin
  raise EcxTreeList.Create(Description);
end;

procedure cxError(Condition: Boolean;
  const Description: string; Args: array of const); overload;
begin
  if Condition then
    raise EdxException.CreateFmt(Description, Args);
end;

function cxIternalCompare(AItem: PcxSortingItem; ANode1, ANode2: TcxTreeListNode): Integer;
var
  I: Integer;
begin
  Result := 0;
  with AItem^, TcxDataControllerAccess(DataController) do
  begin
    for I := 0 to SortOrderList.Count - 1 do
    begin
      Result := CompareRecords(ANode1.FRecordIndex, ANode2.FRecordIndex, PcxDataSortInfo(SortOrderList.List^[I])^);
      if Result <> 0 then Exit;
    end;
    if Result = 0 then
      Result := CompareEqualRecords(ANode1.FRecordIndex, ANode2.RecordIndex);
  end;
end;

function cxDoCustomCompare(AItem: PcxSortingItem; ANode1, ANode2: TcxTreeListNode): Integer;
begin
  with AItem^ do
  begin
    if Assigned(Compare) then
      Result := Compare(ANode1, ANode2)
    else
      TreeList.DoOnCompare(ANode1, ANode2, Result);
  end;
end;

{ TSortingManager }

constructor TSortingManager.Create;
begin
  FList := TList.Create;
end;

destructor TSortingManager.Destroy;
begin
  FreeAndNil(FList);
  inherited Destroy;
end;

procedure TSortingManager.Sort(ANode: TcxTreeListNode;
  ACompare: TcxTreeListCompareFunc; ARecurse: Boolean = False);
var
  AItem: PcxSortingItem;
begin
  if ANode.FCount = 0 then Exit;
  AItem := AddItem(ANode, ACompare, ARecurse);
  InternalSort(AItem);
end;

function TSortingManager.AddItem(ANode: TcxTreeListNode;
  ACompare: TcxTreeListCompareFunc; ARecurse: Boolean): PcxSortingItem;
begin
  Result := AllocMem(SizeOf(TcxSortingItem));
  FList.Add(Result);
  with Result^ do
  begin
    TreeList := ANode.TreeList;
    IsInternalCompare := not (Assigned(ACompare) or Assigned(TreeList.FOnCompare));
    Compare := ACompare;
    Node := ANode;
    Recurse := ARecurse;
    SortOrderList := TreeList.SortOrderList;
    DataController := TreeList.DataController;
  end;
end;

procedure TSortingManager.DoneItem(AItem: PcxSortingItem);
begin
  with AItem^ do
  begin
    Dec(RefCount);
    if RefCount = 0 then
    begin
      FreeMem(NodesList);
      FList.Remove(AItem);
      if NeedUpdate then
      try
        with Node.Owner do
        begin
          IsInvalidState := True;
          CalculateInfo(False);
          TreeList.DoLayoutChanged;
          NodesViewInfo.Owner.InvalidateRect(NodesViewInfo.ClipRect);
//          TreeList.MakeNodeVisible(TreeList.FocusedNode);
          TreeList.DoChanged;
        end;
      finally
        FreeMem(AItem);
      end;
    end;
  end;
end;

procedure TSortingManager.InitItem(AItem: PcxSortingItem);
var
  I: Integer;
  ANode: TcxTreeListNode;
begin
  with AItem^ do
  begin
    Count := Node.FCount;
    if Capacity <= Count then
    begin
      ReallocMem(NodesList, Count * SizeOf(Pointer));
      Capacity := Count;
    end;
    Inc(RefCount);
    if Count = 0 then Exit;
    ANode := Node.FFirst;
    I := 0;
    while I < Count do
    begin
      NodesList^[I] := ANode;
      ANode := ANode.FNext;
      Inc(I);
    end;
  end;
end;

procedure TSortingManager.InternalSort(AItem: PcxSortingItem);

  procedure DoSort(L, R: Integer);
  var
    I, J: Integer;
    TMP: TcxTreeListNode;
    Mid: TcxTreeListNode;
  begin
    with AItem^ do
    repeat
      I := L;
      J := R;
      Mid := NodesList^[(L + R) shr 1];
      repeat
        if IsInternalCompare then
        begin
          while cxIternalCompare(AItem, NodesList^[I], Mid) < 0 do Inc(I);
          while cxIternalCompare(AItem, NodesList^[J], Mid) > 0 do  Dec(J);
        end
        else
        begin
          while cxDoCustomCompare(AItem, NodesList^[I], Mid) < 0 do Inc(I);
          while cxDoCustomCompare(AItem, NodesList^[J], Mid) > 0 do  Dec(J);
        end;
        if I <= J then
        begin
          NeedUpdate := True; 
          TMP := NodesList^[I];
          NodesList^[I] := NodesList^[J];
          NodesList^[J] := TMP;
          Inc(I);
          Dec(J);
        end;
      until I > J;
      if L < J then DoSort(L, J);
      L := I;
    until I >= R;
  end;

begin
  InitItem(AItem);
  try
    DoSort(0, AItem.Count - 1);
    UpdateLinks(AItem);
    if AItem.Recurse then
      InternalSortChildren(AItem);
  finally
    DoneItem(AItem);
  end;
end;

procedure TSortingManager.InternalSortChildren(AItem: PcxSortingItem);
var
  ANeedUpdate: Boolean;
  ANode: TcxTreeListNode;
begin
  ANeedUpdate := False;
  with AItem^ do
  try
    ANeedUpdate := NeedUpdate;
    ANode := Node.FFirst;
    while ANode <> nil do
    begin
      NeedUpdate := False;
      AItem^.Node := ANode;
      if ANode.Count > 0 then InternalSort(AItem);
      ANeedUpdate := ANeedUpdate or NeedUpdate;
      ANode := ANode.FNext;
    end;
  finally
    NeedUpdate := ANeedUpdate;
  end;
end;

procedure TSortingManager.UpdateLinks(AItem: PcxSortingItem);
var
  I: Integer;
begin
  Dec(AItem^.Count);
  with AItem^ do
  begin
    if (Count = 0) or not NeedUpdate then Exit;
    for I := 0 to Count do
    begin
      with NodesList^[I] do
      begin
         FIndex := I;
         if I > 0 then
           FPrev := NodesList^[I - 1]
         else
           FPrev := nil;
         if I < AItem^.Count then
           FNext := NodesList^[I + 1]
         else
           FNext := nil;
         FIndex := I;
      end;
    end;
    Node.FFirst := NodesList^[0];
    Node.FLast := NodesList^[Count];
  end;
end;

{ TcxTemporaryCellViewInfo }

destructor TcxTemporaryCellViewInfo.Destroy;
begin
  CellColumn := nil;
  inherited Destroy;
end;

function TcxTemporaryCellViewInfo.CalculateWidth(AColumn: TcxTreeListColumn;
  ANode: TcxTreeListNode; AIsFocused: Boolean; AHeight: Integer): Integer;
begin
  NodeIsFocused := AIsFocused;
  CellNode := ANode;
  CellColumn := AColumn;
  Column.InitEditViewInfo(Self);
  CellContentRect := cxRect(0, 0, 0, AHeight);
  Result := CellColumn.GetEditWidth(Self) +
    Byte(AColumn.TreeList.OptionsView.GridLines in [tlglBoth, tlglVert]) shl 1 + 2;
  if Result < Column.MinWidth then
    Result := Column.MinWidth;
  if AColumn.IsLeftMost then
    Inc(Result, AColumn.TreeList.ImagesIndentWidth);
  if Result > Column.Data then
    Column.Data := Result;
end;

function TcxTemporaryCellViewInfo.ContentOffset: TRect;
begin
  Result := cxNullRect;
end;

function TcxTemporaryCellViewInfo.GetButtonTransparency: TcxEditButtonTransparency;
begin
  Result := ebtNone; 
end;

function TcxTemporaryCellViewInfo.GetColumn: TcxTreeListColumn;
begin
  Result := CellColumn;
end;

function TcxTemporaryCellViewInfo.GetEditContainer: TcxCustomInplaceEditContainer;
begin
  Result := CellColumn;
end;

function TcxTemporaryCellViewInfo.GetFocused: Boolean;
begin
  Result := NodeIsFocused;
end;

function TcxTemporaryCellViewInfo.GetLineCount: Integer;
begin
  Result := 1;
end;

function TcxTemporaryCellViewInfo.GetRecordIndex: Integer;
begin
  Result := CellNode.RecordIndex;
end;

function TcxTemporaryCellViewInfo.GetSelected: Boolean;
begin
  Result := False;
end;

function TcxTemporaryCellViewInfo.IsAutoHeight: Boolean;
begin
  Result := False;
end;

function TcxTemporaryCellViewInfo.IsEndEllipsis: Boolean;
begin
  Result := False;
end;

function TcxTemporaryCellViewInfo.GetNode: TcxTreeListNode;
begin
  Result := CellNode;
end;

function TcxTemporaryCellViewInfo.GetNodesViewInfo: TcxTreeListNodesViewInfo;
begin
  Result := nil;
end;

function TcxTemporaryCellViewInfo.GetNodeViewInfo: TcxTreeListNodeViewInfo;
begin
  Result := nil;
end;

function TcxTemporaryCellViewInfo.GetTreeList: TcxCustomTreeListControl;
begin
  Result := Column.TreeList;
end;

{ TcxTreeListNodes}

constructor TcxTreeListNodes.Create(AOwner: TcxCustomTreeListControl);
begin
  FOwner := AOwner;
  FRoot := TcxTreeListRootNode.Create(Self);
  FRoot.FState := 0;
end;

destructor TcxTreeListNodes.Destroy;
begin
  FState := FState or tlnsDeleting;
  TreeList.BeginUpdate;
  try
    FreeAndNil(FRoot);
  finally
    TreeList.CancelUpdate;
    inherited Destroy;
  end;
end;

procedure TcxTreeListNodes.Assign(Source: TPersistent);
begin
  if Source is TcxTreeListNodes then
    TreeList.DoAssignNodes(Source as TcxTreeListNodes)
  else
    inherited Assign(Source);
end;

procedure TcxTreeListNodes.Clear;
begin
  if TreeList.NodesList.Count = 0 then Exit;
  if not TreeList.SafeDelete and not TreeList.IsDestroying then
    TreeList.UpdateFocusedRecordPost;
  TreeList.BeginUpdate;
  try
    NodesViewInfo.Clear;
    Root.DeleteChildren;
  finally
    TopIndex := 0;
    TopNode := nil;
    FState := tlnsIndexesInvalid;
    TreeList.DoValidateDeletedNodes;
    TreeList.EndUpdate;
  end;
end;

procedure TcxTreeListNodes.Changed;
begin
  FFoundItem := nil;
  IsInvalidState := True;
  NodesViewInfo.TopNode := nil;
  TreeList.LayoutChanged;
end;

procedure TcxTreeListNodes.CalculateInfo(IsLocked: Boolean);

  procedure DoCalc(ANode: TcxTreeListNode; ALevel: Integer);
  begin
    while ANode <> nil do
    begin
      if ALevel > FMaxLevel then FMaxLevel := ALevel;
      if TopIndex >= FVisibleCount then TopNode := ANode;
      ANode.FVisibleIndex := FVisibleCount;
      Inc(FVisibleCount);
      with ANode do
        if Expanded then DoCalc(FFirst, ALevel + 1);
      ANode := ANode.FNext;
    end;
  end;

begin
  if not IsInvalidState and (TopNode <> nil) then Exit;
  if not IsLocked then
  begin
    FMaxLevel := -1;
    FVisibleCount := 0;
    if TopIndex < 0 then TopIndex := 0;
    DoCalc(FRoot.FFirst, 0);
    if TopIndex > FVisibleCount then TopIndex := FVisibleCount - 1;
    IsInvalidState := False
  end
  else
  begin
    FMaxLevel := 0;
    FVisibleCount := -1;
    TopIndex := 0;
    TopNode := nil;
  end;
end;

procedure TcxTreeListNodes.DoNodeChanged(ANode: TcxTreeListNode);
begin
  if ANode = nil then
    Changed
  else
    TreeList.DoNodeChanged(ANode);
end;

class function TcxTreeListNodes.FindBetween(
  AFirst, ALast: TcxTreeListNode; ACount, AIndex: Integer): TcxTreeListNode;
begin
  cxError((AIndex < 0) or (AIndex >= ACount) or (AFirst.Index > AIndex) or
    (ALast.FIndex < AIndex), scxStr(@scxIndexOutOfBounds), [AIndex]);
  if (ALast.Index shr 1) <= AIndex  then
  begin
    Result := ALast;
    while Result.FIndex <> AIndex do Result := Result.FPrev;
  end
  else
  begin
    Result := AFirst;
    while Result.FIndex <> AIndex do Result := Result.FNext;
  end;
end;

function TcxTreeListNodes.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TcxTreeListNodes.GetVisibleNode(var AIndex: Integer): TcxTreeListNode;

  procedure DoSearch(AStartNode, AEndNode: TcxTreeListNode;
    AFromEnd: Boolean; var ANode: TcxTreeListNode);
  begin
    if AFromEnd then
    begin
      ANode := AEndNode;
      while (ANode <> nil) and (ANode.FVisibleIndex > AIndex) do
        ANode := ANode.GetPrevVisible;
    end
    else
    begin
      Result := AStartNode;
      while (ANode <> nil) and (ANode.FVisibleIndex < AIndex) do
        Result := ANode.GetNextVisible;
    end;
  end;

begin
  CalculateInfo(False);
  cxValidateIntDefEx(AIndex, -1, 0, VisibleCount - 1);
  if TopNode = nil then
  begin
    TopNode := Root.FFirst;
    TopIndex := 0;
  end
  else
    if TopNode.VisibleIndex <> TopIndex then
      TopIndex := TopNode.VisibleIndex;
  if AIndex >= TopIndex then
    DoSearch(TopNode, cxGetLatest(Root.FLast),
      AIndex > ((VisibleCount + TopIndex) shr 1), Result)
  else
    DoSearch(Root.FFirst, TopNode, AIndex > (TopIndex shr 1), Result);
  if Result = nil then
    AIndex := 0
  else
    AIndex := Result.FVisibleIndex;
end;

function TcxTreeListNodes.InternalAddNode(ANode, ARelative: TcxTreeListNode;
  AddMethod: TcxTreeListNodeAttachMode): TcxTreeListNode;
const
  IsAddChild: array[TcxTreeListNodeAttachMode] of Boolean =
    (False, False, True, True, False);
  AddMode: array[TcxTreeListNodeAttachMode] of TcxTreeListNodeAddMode =
    (tlnaAdd, tlnaAddFirst, tlnaAdd, tlnaAddFirst, tlnaInsert);
begin
  TreeList.BeginUpdateSelection;
  try
    if ANode = nil then
      Result := TreeList.DoCreateNode
    else
      Result := ANode;
    if (ARelative = nil) and (AddMethod = tlamInsert) then
      AddMethod := tlamAdd;
    if ARelative <> nil then
      SetNodeParent(Result, ARelative, AddMode[AddMethod])
    else
      SetNodeParent(Result, FRoot, AddMode[AddMethod]);
    Changed;
  finally
    TreeList.EndUpdateSelection;
  end;
end;

procedure TcxTreeListNodes.SetNodeParent(ANewNode, ANewParent: TcxTreeListNode;
  AMode: TcxTreeListNodeAddMode);
begin
  TreeList.BeforeAddNode(ANewNode, ANewParent, AMode);
  case AMode of
    tlnaAdd:
      ANewParent.SetLast(ANewNode);
    tlnaAddFirst:
      ANewParent.SetFirst(ANewNode);
    tlnaInsert:
      ANewNode.InternalInsert(ANewParent);
  end;
end;

procedure TcxTreeListNodes.SetTopVisibleIndex(AIndex: Integer);
begin
  TopNode := GetVisibleNode(AIndex);
  TopIndex := AIndex;
  NodesViewInfo.TopNode := nil;
  if AIndex >= 0 then
    NodesViewInfo.SynchronizeTopNode;
end;

function TcxTreeListNodes.GetAbsoluteItem(AFindIndex: Integer): TcxTreeListNode;
var
  AIndex: Integer;
begin
  Result := nil;
  if cxInRange(AFindIndex, 0, Count - 1) then
  begin
    AIndex := 0;
    Result := Root.FFirst;
    while AFindIndex <> AIndex do
    begin
      Inc(AIndex);
      if Result.Count > 0 then
        Result := Result.FFirst
      else
      begin
        while Result.FNext = nil do Result := Result.Parent;
        Result := Result.FNext;
      end;
    end;
  end;
end;

function TcxTreeListNodes.GetCount: Integer;
begin
  Result := TreeList.NodesList.Count;
end;

function TcxTreeListNodes.GetDataController: TcxControlDataController;
begin
  Result := TcxControlDataController(TreeList.DataController); 
end;

function TcxTreeListNodes.GetItem(AIndex: Integer): TcxTreeListNode;
begin
  Result := TcxTreeListNode(TreeList.NodesList[AIndex]);
end;

function TcxTreeListNodes.GetMaxLevel: Integer;
begin
  CalculateInfo(TreeList.IsLocked);
  Result := FMaxLevel;
end;

function TcxTreeListNodes.GetState(Index: Integer): Boolean;
begin
  Result := FState and Index <> 0;
end;

function TcxTreeListNodes.GetVisibleCount: Integer;
begin
  CalculateInfo(TreeList.IsLocked);
  Result := FVisibleCount;
end;

procedure TcxTreeListNodes.SetState(Index: Integer; Value: Boolean);
begin
  if Value then
    FState := FState or Index
  else
    FState := FState and not Index;
end;

function TcxTreeListNodes.GetNodesViewInfo: TcxTreeListNodesViewInfo;
begin
  Result := TreeList.ViewInfo.NodesViewInfo;
end;

function TcxTreeListNodes.GetTopVisibleNode: TcxTreeListNode;
begin
  CalculateInfo(TreeList.IsLocked);
  Result := TopNode;
end;

procedure TcxTreeListNodes.SetAbsoluteItem(
  Index: Integer; Value: TcxTreeListNode);
begin
  AbsoluteItems[Index].Assign(Value);
end;

procedure TcxTreeListNodes.SetItem(
  AIndex: Integer; Value: TcxTreeListNode);
begin
  GetItem(AIndex).Assign(Value);
end;

{ TcxTreeListNode }

constructor TcxTreeListNode.Create(AOwner: TcxTreeListNodes);
begin
  FOwner := AOwner;
  FState := FState or tlnsCollapsed;
  FillChar(FImageIndexes, SizeOf(FImageIndexes), -1);
  if Owner.State and tlnsInternalCreating = 0 then
    FRecordIndex := AddDataControllerRecord
  else
    FRecordIndex := -1;
end;

destructor TcxTreeListNode.Destroy;
var
  NeedAdjustIndexes: Boolean;
begin
  TreeList.BeginUpdate;
  try
    if not TreeList.SafeDelete and TreeList.DataController.IsEditing then
      TreeList.DataController.Post;
    TreeList.DoOnDeletion(Self);
    if HasChildren and (Count > 0) then
      DeleteChildren;
    TreeList.DoCheckDeletedNode(Self);
    TreeList.DoDeleteNode(Self);
    Owner.IsInvalidState := True;
    NeedAdjustIndexes := FState and tlnsDeleting = 0;
    FState := FState or tlnsDeleting;
    if Owner.NodesViewInfo.TopNode = Self then
    begin
      Owner.TopNode := nil;
      Owner.NodesViewInfo.TopNode := nil;
    end;
    if NeedAdjustIndexes then
      FState := FState xor tlnsDeleting;
    InternalRemove(Self);
  finally
    TreeList.EndUpdate;
    TreeList.UpdateEditValue; 
    inherited Destroy;
  end;
end;

procedure TcxTreeListNode.Assign(Source: TPersistent);
var
  ANode: TcxTreeListNode;
  I: Integer;
begin
  if Source is TcxTreeListNode then
  begin
    ANode := TcxTreeListNode(Source);
    FData := ANode.Data;
    Focused := ANode.Focused;
    HasChildren := ANode.HasChildren;
    for I := 0 to ANode.ValueCount - 1 do
      Values[I] := ANode.Values[I];
  end
  else
    inherited Assign(Source);
end;

procedure TcxTreeListNode.AssignValues(
  const AValues:{$IFDEF DELPHI5} array of {$ENDIF} Variant);
var
  I, K: Integer;
begin
  K := 0;
  for I := Low(AValues) to High(AValues) do
  begin
    if K >= ValueCount then Break;
    Values[I] := AValues[I];
    Inc(K);
  end;
end;

function TcxTreeListNode.AddChild: TcxTreeListNode;
begin
  Result := TreeList.AddNode(nil, Self, nil, tlamAddChild);
end;

function TcxTreeListNode.AddChildFirst: TcxTreeListNode;
begin
  Result := TreeList.AddNode(nil, Self, nil, tlamAddChildFirst);
end;

procedure TcxTreeListNode.AlphaSort(ARecurse: Boolean = False);
begin
  CustomSort(nil, ARecurse);
end;

function TcxTreeListNode.CanCollapse: Boolean;
begin
  Result := TreeList.DoCanNodeCollapse(Self);
end;

function TcxTreeListNode.CanExpand: Boolean;
begin
  Result := TreeList.DoCanNodeExpand(Self);
end;

function TcxTreeListNode.CanMove(
  ADest: TcxTreeListNode; AMode: TcxTreeListNodeAttachMode): Boolean;
begin
  if (ADest = nil) or ((ADest = Self) and (AMode in [tlamAddChild, tlamAddChildFirst, tlamInsert])) or
    ADest.HasAsParent(Self) then
    Result := False
  else
    Result := True;
end;

procedure TcxTreeListNode.Collapse(Recurse: Boolean);
var
  ANode: TcxTreeListNode;
begin
  if not HasChildren then Exit;
  TreeList.BeginUpdate;
  try
    Expanded := False;
    if Recurse then
    begin
      ANode := FFirst;
      while ANode <> nil do
      begin
        ANode.Collapse(True);
        ANode := ANode.FNext;
      end;
    end;
  finally
    TreeList.EndUpdate;
  end;
end;

procedure TcxTreeListNode.CustomSort(
  ASortProc: TcxTreeListCompareFunc; ARecurse: Boolean = False);
begin
  SortingManager.Sort(Self, ASortProc, ARecurse);
end;

procedure TcxTreeListNode.Delete;
begin
  if not Deleting then Free;
end;

procedure TcxTreeListNode.DeleteChildren;
var
  ANode: TcxTreeListNode; 
begin
  TreeList.BeginUpdate;
  try
    while FFirst <> nil do
    begin
      FFirst.FState := FFirst.FState or tlnsDeleting;
      ANode := FFirst;
      FFirst := FFirst.FNext;
      FreeAndNil(ANode);
    end;
  finally
    FCount := 0;
    HasChildren := False;
    FFirst := nil;
    FLast := nil;
    TreeList.EndUpdate;
  end;
end;

function TcxTreeListNode.DisplayRect(AEntryOnly: Boolean): TRect;
var
  AViewInfo: TcxTreeListNodeViewInfo;
begin
  if Owner.NodesViewInfo.FindNodeViewInfo(Self, AViewInfo) then
  begin
    if AEntryOnly then
      Result := AViewInfo.NodeCellsRect
    else
      Result := AViewInfo.NodeContentRect;
  end
  else
    Result := cxNullRect;
end;

procedure TcxTreeListNode.EndEdit(Cancel: Boolean);
begin
  TreeList.Controller.EditingController.HideEdit(not Cancel);
end;

procedure TcxTreeListNode.Expand(Recurse: Boolean);
var
  ANode: TcxTreeListNode;
begin
  if not HasChildren then Exit;
  if not TreeList.IsSmartLoad then
    TreeList.BeginUpdate;
  try
    Expanded := True;
    if Recurse then
    begin
      ANode := FFirst;
      while ANode <> nil do
      begin
        ANode.Expand(True);
        ANode := ANode.FNext;
      end;
    end;
  finally
    if not TreeList.IsSmartLoad then
      TreeList.EndUpdate;
  end;
end;

function TcxTreeListNode.GetNextChild(Value: TcxTreeListNode): TcxTreeListNode;
begin
  if Value <> nil then
    Result := TcxTreeListNode(Value.FNext)
  else
    Result := nil;
end;

function TcxTreeListNode.GetFirstChild: TcxTreeListNode;
begin
  Result := FFirst
end;

function TcxTreeListNode.GetLastChild: TcxTreeListNode;
begin
  Result := FLast
end;

function TcxTreeListNode.GetNext: TcxTreeListNode;
var
  ANode: TcxTreeListNode;
begin
  Result := FFirst;
  if FCount = 0 then
  begin
    ANode := Self;
    while ANode <> nil do
    begin
      if ANode.FNext <> nil then
      begin
        Result := ANode.FNext;
        Break;
      end;
      while (ANode <> nil) and (ANode.FNext = nil) do ANode := ANode.Parent;
    end;
  end;
end;

function TcxTreeListNode.GetNextSibling: TcxTreeListNode;
begin
  Result := FNext;
end;

function TcxTreeListNode.GetPrev: TcxTreeListNode;
begin
  Result := FPrev;
  if Result <> nil then
    Result := cxGetLatest(Result, False)
  else
    Result := Parent;
  if Result = Owner.Root then Result := nil;
end;

function TcxTreeListNode.GetPrevSibling: TcxTreeListNode;
begin
  Result := FPrev;
end;

function TcxTreeListNode.GetPrevChild(Value: TcxTreeListNode): TcxTreeListNode;
begin
  if Value <> nil then
    Result := TcxTreeListNode(Value.FPrev)
  else
    Result := nil;
end;

function TcxTreeListNode.HasAsParent(Value: TcxTreeListNode): Boolean;
var
  ANode: TcxTreeListNode;
begin
  Result := False;
  ANode := Parent;
  while (ANode <> nil) and not Result do
  begin
    Result := ANode = Value;
    ANode := ANode.FParent;
  end;
end;

function TcxTreeListNode.IndexOf(Value: TcxTreeListNode): Integer;
begin
  if Value.Parent = Self then
    Result := Value.FIndex
  else
    Result := -1;
end;

function TcxTreeListNode.InsertChild(
  ABeforeNode: TcxTreeListNode): TcxTreeListNode;
begin
  Result := TreeList.AddNode(nil, ABeforeNode, nil, tlamInsert);
end;

procedure TcxTreeListNode.MakeVisible;
var
  ANode: TcxTreeListNode;
begin
  if not TreeList.FNeedMakeVisible then Exit;
  if (TreeList.VisibleColumnCount = 0) or (TreeList.TopVisibleNode = nil) then
    TreeList.DoLayoutChanged; 
  if not IsVisible then
  begin
    TreeList.BeginUpdate;
    try
      ANode := FParent;
      while ANode <> nil do
      begin
        ANode.Expanded := True;
        if not ANode.Expanded then Break;
        ANode := ANode.FParent;
      end;
    finally
      TreeList.EndUpdate;
    end;
  end;
  if IsVisible then
    TreeList.MakeNodeVisible(Self);
end;

procedure TcxTreeListNode.MoveTo(
  ADestNode: TcxTreeListNode; AMode: TcxTreeListNodeAttachMode);
begin
  if (ADestNode = nil) or (ADestNode = Self) then Exit;
  if AMode in [tlamAdd, tlamAddFirst] then
    ADestNode := ADestNode.Parent;
  if not ADestNode.HasAsParent(Self) then
    TreeList.InternalMove(Self, ADestNode, AMode);
end;

procedure TcxTreeListNode.Repaint(ARecalculate: Boolean);
var
  AViewInfo: TcxTreeListNodeViewInfo;
begin
  with TreeList.ViewInfo do
  begin
    if NodesViewInfo.FindNodeViewInfo(Self, AViewInfo) then
    begin
      AViewInfo.Update(ARecalculate);
      InvalidateRect(AViewInfo.NodeContentRect);
    end;
  end;
end;

function TcxTreeListNode.AddDataControllerRecord: Integer;
begin
  Result := DataController.AppendRecord;
  FRecordIndex := Result;
  TreeList.NodesList.Add(Self);
end;

procedure TcxTreeListNode.DoReadNodeData(AReader: TcxReader);
begin
  FState := AReader.ReadInteger;
  FCount := AReader.ReadInteger;
  FRecordIndex := AReader.ReadInteger;
end;

procedure TcxTreeListNode.DoWriteNodeData(AWriter: TcxWriter);
begin
  AWriter.WriteInteger(FState);
  AWriter.WriteInteger(FCount);
  AWriter.WriteInteger(FRecordIndex);
end;

function TcxTreeListNode.GetNextSiblingEx(
  ANode: TcxTreeListNode; AForward: Boolean): TcxTreeListNode;
begin
  if AForward then
    Result := ANode.FNext
  else
    Result := ANode.FPrev;
end;

function TcxTreeListNode.GetIsFirstVisible: Boolean;
begin
  Result := IsVisible and (Owner.Root.FFirst = Self);
end;

function TcxTreeListNode.GetIsLastVisible: Boolean;
begin
  Result := IsVisible and (GetNextVisible = nil);
end;

function TcxTreeListNode.GetNextVisibleEx(IsPrev: Boolean): TcxTreeListNode;
begin
  if IsPrev then
    Result := GetPrevVisible
  else
    Result := GetNextVisible; 
end;

function TcxTreeListNode.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TcxTreeListNode.ReadData(AStream: TStream);
begin
  AStream.ReadBuffer(FRecordIndex, SizeOf(Integer));
  AStream.ReadBuffer(FState, SizeOf(Integer));
  FCount := 0;
  if FState and tlnsHasChildren <> 0 then
    AStream.ReadBuffer(FCount, SizeOf(Integer));
end;

procedure TcxTreeListNode.WriteData(AStream: TStream);
begin
  AStream.WriteBuffer(FRecordIndex, SizeOf(Integer));
  if FCount > 0 then FState := FState or tlnsHasChildren;
  AStream.WriteBuffer(FState, SizeOf(Integer));
  if (FCount > 0) or (FState and tlnsHasChildren <> 0) then
    AStream.WriteBuffer(FCount, SizeOf(Integer));
end;

function TcxTreeListNode.CanSizing(
  ADirection: TcxDragSizingDirection): Boolean;
begin
  with TreeList do
  begin
    Result := OptionsCustomizing.RowSizing and (ADirection = dsdVert);
    Result := Result and not OptionsView.CellAutoHeight
  end;
end;

function TcxTreeListNode.GetSizingBoundsRect(
  ADirection: TcxDragSizingDirection): TRect;
begin
  Result := TreeList.ClientBounds;
  with DisplayRect(False) do
  begin
    Result.Top := Top + TreeList.ViewInfo.DefaultEditHeight;
    Result.Bottom := Result.Top + cxRectHeight(TreeList.ClientBounds);
  end;
end;

function TcxTreeListNode.GetSizingIncrement(
  ADirection: TcxDragSizingDirection): Integer;
begin
  Result := 1;
end;

function TcxTreeListNode.IsDynamicUpdate: Boolean;
begin
  Result := False;
end;

procedure TcxTreeListNode.SetSizeDelta(
  ADirection: TcxDragSizingDirection; ADelta: Integer);
begin
  with TreeList do
    DefaultRowHeight := DefaultRowHeight + ADelta;
end;

function TcxTreeListNode.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := cxE_NOINTERFACE;
end;

function TcxTreeListNode._AddRef: Integer;
begin
  Result := -1;
end;

function TcxTreeListNode._Release: Integer;
begin
  Result := -1;
end;

function TcxTreeListNode.GetRootParent: TcxTreeListNode;
begin
  Result := Self;
  while (Result.FParent <> nil) and (Result.FParent <> Owner.Root) do
    Result := Result.FParent;
end;

function TcxTreeListNode.GetAbsoluteIndex: Integer;
var
  ANode: TcxTreeListNode;
begin
  if Self.Parent = nil then
    Result := -1
  else
  begin
    Result := 0;
    ANode := Owner.Root.FFirst;
    while ANode <> Self do
    begin
      Inc(Result);
      if ANode.Count > 0 then
        ANode := ANode.FFirst
      else
      begin
        while ANode.FNext = nil do ANode := ANode.Parent;
        ANode := ANode.FNext;
      end;
    end;
  end;
end;

function TcxTreeListNode.GetDataController: TcxControlDataController;
begin
  Result := Owner.DataController;
end;

function TcxTreeListNode.GetExpanded: Boolean;
begin
  Result := (Count > 0) and ((FState and tlnsCollapsed) = 0); 
end;

function TcxTreeListNode.GetFocused: Boolean;
begin
  Result := DataController.FocusedRecordIndex = RecordIndex;
end;

function TcxTreeListNode.GetHasChildren: Boolean;
begin
  Result := (FState and tlnsHasChildren <> 0) or (FCount > 0)
end;

function TcxTreeListNode.GetIsDeleting: Boolean;
var
  ANode: TcxTreeListNode;
begin
  Result := False;
  ANode := Self;
  while not Result and (ANode <> nil) do
  begin
    Result := ANode.FState and tlnsDeleting <> 0;
    ANode := ANode.Parent;
  end;
end;

function TcxTreeListNode.GetHotTrack: Boolean;
begin
  Result := TreeList.Controller.HotTrackNode = Self;
end;

function TcxTreeListNode.GetIsFirst: Boolean;
begin
  Result := (FParent = nil) or (FParent.FFirst = Self);  
end;

function TcxTreeListNode.GetIsGroupNode: Boolean;
begin
  Result := TreeList.DoIsGroupNode(Self);
end;

function TcxTreeListNode.GetIsLast: Boolean;
begin
  Result := (FParent = nil) or (FParent.FLast = Self);
end;

function TcxTreeListNode.GetIsVisible: Boolean;
var
  ANode: TcxTreeListNode;
begin
  Result := FParent <> nil;
  ANode := Self;
  while Result and (ANode.FParent <> nil) and (ANode.FParent <> FOwner.Root) do
  begin
    Result := ANode.FParent.FState and tlnsCollapsed = 0;
    ANode := ANode.FParent;
  end;
end;

function TcxTreeListNode.GetItem(AIndex: Integer): TcxTreeListNode;
begin
  Result := Owner.FindBetween(FFirst, FLast, FCount, AIndex);
end;

function TcxTreeListNode.GetLevel: Integer;
var
  ANode: TcxTreeListNode;
begin
  ANode := FParent;
  Result := -1;
  while ANode <> nil do
  begin
    Inc(Result);
    ANode := ANode.FParent;
  end;
end;

function TcxTreeListNode.GetSelected: Boolean;
begin
  if TreeList.IsMultiSelect then
    Result := TreeList.FSelection.IndexOf(Self) <> cxInvalidIndex
  else
    Result := Focused; 
end;

function TcxTreeListNode.GetNextVisible: TcxTreeListNode;
begin
  if (FCount > 0) and (FState and tlnsCollapsed = 0) then
    Result := FFirst
  else
  begin
    Result := Self;
    while Result <> nil do
    begin
      if Result.FNext <> nil then
      begin
        Result := Result.FNext;
        Break;
      end;
      Result := Result.FParent;
    end;
  end;
end;

function TcxTreeListNode.GetNodeImageIndex(AIndex: Integer): TImageIndex;
begin
  Result := TreeList.DoGetNodeImageIndex(Self, TcxTreeListImageIndexType(AIndex));
end;

function TcxTreeListNode.GetPrevVisible: TcxTreeListNode;
begin
  Result := cxGetLatest(FPrev);
  if (Result = nil) and (FParent <> FOwner.Root) then
    Result := FParent;
end;

function TcxTreeListNode.GetText(Index: Integer): string;
begin
  Result := TreeList.Columns[Index].DisplayTexts[RecordIndex];
end;

function TcxTreeListNode.GetTreeList: TcxCustomTreeListControl;
begin
  Result := Owner.TreeList;
end;

function TcxTreeListNode.GetValue(AIndex: Integer): Variant;
begin
  Result := DataController.Values[FRecordIndex, AIndex]
end;

function TcxTreeListNode.GetValueCount: Integer;
begin
   Result := TreeList.DoGetNodeValueCount;
end;

function TcxTreeListNode.GetVisibleIndex: Integer;
begin
  if IsVisible then
    Result := FVisibleIndex
  else
    Result := -1;
end;

procedure TcxTreeListNode.AdjustIndexes(ANode: TcxTreeListNode; AIndex: Integer);
begin
  while ANode <> nil do
  begin
    ANode.FIndex := AIndex;
    ANode := ANode.FNext;
    Inc(AIndex);
  end;
end;

procedure TcxTreeListNode.InternalInsert(Value: TcxTreeListNode);
begin
  if FParent <> nil then
    InternalRemove(Self);
  FPrev := Value.FPrev;
  if FPrev <> nil then
    FPrev.FNext := Self
  else
    Value.FParent.FFirst := Self;
  FNext := Value;
  if FNext <> nil then
    FNext.FPrev := Self
  else
    Value.FParent.FLast := Self;
  Value.FParent.SetParentFor(Self);
end;

procedure TcxTreeListNode.InternalRemove(Value: TcxTreeListNode);
begin
  if Deleting then Exit;
  AdjustIndexes(Value.FNext, Value.Index);
  if Value.FParent <> nil then
  begin
    Dec(Value.FParent.FCount);
    if Value.FParent.FFirst = Value then
      Value.FParent.FFirst := Value.FNext;
    if Value.FParent.FLast = Value then
      Value.FParent.FLast := Value.FPrev;
    if Value.FParent.FCount = 0 then
      Value.FParent.FState := (Value.FParent.FState and not tlnsHasChildren) or tlnsCollapsed ;
  end;
  if Value.FNext <> nil then
    Value.FNext.FPrev := Value.FPrev;
  if Value.FPrev <> nil then
    Value.FPrev.FNext := Value.FNext;
  Value.FPrev := nil;
  Value.FNext := nil;
  Value.FParent := nil;
end;

procedure TcxTreeListNode.SetExpanded(Value: Boolean);
begin
  if Value <> Expanded then
  begin
    Owner.IsInvalidState := True;
    TreeList.DoSetNodeExpanded(Self, Value);
  end;
end;

procedure TcxTreeListNode.SetFirst(Value: TcxTreeListNode);
begin
  InternalRemove(Value);
  if FFirst <> nil then
  begin
    Value.FNext := FFirst;
    FFirst.FPrev := Value;
  end
  else
    FLast := Value;
  FFirst := Value;
  SetParentFor(Value);
end;

procedure TcxTreeListNode.SetFocused(Value: Boolean);
begin
  if Value <> Focused then
  begin
    if Value then
      TreeList.Controller.FocusedRecordIndex := RecordIndex
    else
      DataController.FocusedRecordIndex := -1;
  end;
end;

procedure TcxTreeListNode.SetHasChildren(Value: Boolean);
begin
  if HasChildren <> Value then
  begin
    if Value then
      FState := FState or tlnsHasChildren
    else
      if FCount = 0 then
        FState := FState and not tlnsHasChildren;
     Owner.DoNodeChanged(Self);
  end;
end;

procedure TcxTreeListNode.SetItem(AIndex: Integer; Value: TcxTreeListNode);
begin
  GetItem(AIndex).Assign(Value);
end;

procedure TcxTreeListNode.SetLast(Value: TcxTreeListNode);
begin
  InternalRemove(Value);
  if FLast <> nil then
  begin
    Value.FPrev := FLast;
    FLast.FNext := Value;
  end
  else
    FFirst := Value;
  FLast := Value;
  SetParentFor(Value);
end;

procedure TcxTreeListNode.SetNodeImageIndex(AIndex: Integer; Value: TImageIndex);
begin
  TreeList.DoSetNodeImageIndex(Self, TcxTreeListImageIndexType(AIndex), Value);
end;

procedure TcxTreeListNode.SetParentFor(Value: TcxTreeListNode);
begin
  Value.FParent := Self;
  Inc(FCount);
  if Value.FPrev = nil then
    AdjustIndexes(Value, 0)
  else
    AdjustIndexes(Value.FPrev, Value.FPrev.Index);
  Owner.DoNodeChanged(nil);
end;

procedure TcxTreeListNode.SetText(AIndex: Integer; const AValue: string);
begin
  SetValue(AIndex, AValue);
end;

procedure TcxTreeListNode.SetSelected(Value: Boolean);
begin
  if (Selected <> Value) and TreeList.IsMultiSelect then
  try
    if not Value then
      TreeList.FSelection.Remove(Self)
    else
    begin
      if not TreeList.DoCanSelectNode(Self) then
        Exit
      else
      begin
        if not TreeList.OptionsSelection.MultiSelect then
          TreeList.ClearSelection(False);
        TreeList.FSelection.Add(Self);
      end;
    end;
    TreeList.DoSelectionChanged;
  finally
    Repaint(True);
  end;
end;

procedure TcxTreeListNode.SetValue(AIndex: Integer; const AValue: Variant);
begin
  with DataController do
  begin
    if (dceEdit in EditState) and (FocusedRecordIndex = RecordIndex) then
      SetEditValue(AIndex, AValue, evsValue)
    else
      Values[RecordIndex, AIndex] := AValue;       
  end;
end;

{ TcxTreeListRootNode }

function TcxTreeListRootNode.AddDataControllerRecord: Integer;
begin
   Result := -1;
end;

{ TcxUnboundTreeListNode }

constructor TcxUnboundTreeListNode.Create(AOwner: TcxTreeListNodes);
begin
  inherited Create(AOwner);
  FImageIndexes := cxDefaultImageIndexes;
end;

procedure TcxUnboundTreeListNode.Assign(Source: TPersistent);
begin
  if Source is TcxUnboundTreeListNode then
    FImageIndexes := TcxUnboundTreeListNode(Source).FImageIndexes;
  inherited Assign(Source);
end;

procedure TcxUnboundTreeListNode.ReadData(AStream: TStream);
begin
  inherited ReadData(AStream);
  AStream.ReadBuffer(FImageIndexes, SizeOf(FImageIndexes))
end;

procedure TcxUnboundTreeListNode.WriteData(AStream: TStream);
begin
  inherited WriteData(AStream);
  AStream.WriteBuffer(FImageIndexes, SizeOf(FImageIndexes))
end;

{ TcxTreeListColumnStyles }

procedure TcxTreeListColumnStyles.Assign(Source: TPersistent);
begin
  if Source is TcxTreeListColumnStyles then
  begin
    Header := TcxTreeListColumnStyles(Source).Header;
    Footer := TcxTreeListColumnStyles(Source).Footer;
  end;
  inherited Assign(Source);
end;

procedure TcxTreeListColumnStyles.CachedContentStyleChanged;
var
  B: Boolean;
begin
  if Band <> nil then
    ContentParams := Band.Styles.ContentParams
  else
    ContentParams := TreeList.Styles.ContentParams;
  for B := False to True do
    cxParamsCombine(Content, [], ContentParams[B]);
end;

function TcxTreeListColumnStyles.GetBand: TcxTreeListBand;
begin
  Result := TcxTreeListColumn(GetOwner).OwnerBand;
end;

function TcxTreeListColumnStyles.GetTreeList: TcxCustomTreeListControl;
begin
  Result := TcxCustomTreeListControl(Control);
end;

{ TcxTreeListColumnPosition }

constructor TcxTreeListColumnPosition.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FColIndex := 0;
  FLineCount := 1;
  FRowIndex := 0;
end;

procedure TcxTreeListColumnPosition.Assign(Source: TPersistent);
begin
  if Source is TcxTreeListColumnPosition then
  begin
    FLineCount := TcxTreeListColumnPosition(Source).FLineCount;
    with TcxTreeListColumnPosition(Source) do
      Self.SetPositionEx(BandIndex, FColIndex, FRowIndex);
  end
  else
    inherited Assign(Source);
end;

procedure TcxTreeListColumnPosition.SetPosition(
  AColIndex, ARowIndex: Integer; IsInsertRow: Boolean = False);
begin
  SetPositionEx(BandIndex, AColIndex, ARowIndex);
end;

procedure TcxTreeListColumnPosition.SetPositionEx(
  ABandIndex, AColIndex, ARowIndex: Integer; IsInsertRow: Boolean = False);

  procedure CheckColumnPos(AColumn: TcxTreeListColumn);
  begin
    with AColumn.Position do
    begin
      if IsInsertRow and (FRowIndex >= ARowIndex) then Inc(FRowIndex);
      if (FRowIndex = ARowIndex) and (FColIndex >= AColIndex) then
        Inc(FColIndex);
    end;
  end;

  procedure SetOwnerBand(ABand: TcxTreeListBand);
  var
    I: Integer;
  begin
    Column.OwnerBand := ABand;
    if ABand <> nil then
    begin
      for I := 0 to ABand.VisibleColumnCount - 1 do
        CheckColumnPos(ABand.VisibleColumns[I]);
    end;
  end;

begin
  TreeList.BeginUpdate;
  try
    SetOwnerBand(GetBandFromIndex(ABandIndex));
    FColIndex := AColIndex;
    FRowIndex := ARowIndex;
    cxValidateIntDef(FColIndex, 0);
    cxValidateIntDef(FRowIndex, 0);
  finally
    TreeList.CancelUpdate;
    Changed;
  end;
end;

procedure TcxTreeListColumnPosition.Changed;
begin
  if TreeList.OptionsView.HeaderSingleLine then
    cxValidateSingleLine(Self);
  TreeList.LayoutChanged;
end;

function TcxTreeListColumnPosition.GetBandFromIndex(
  AIndex: Integer): TcxTreeListBand;
begin
  Result := nil;
  with TreeList.Bands do
  begin
    if not cxValidateIntDefEx(AIndex, BandIndex, -1, Count - 1) then
      Result := Column.OwnerBand
    else
      if AIndex <> cxInvalidIndex then
        Result := Column.TreeList.Bands[AIndex];
  end;
end;

procedure TcxTreeListColumnPosition.Save;
begin
  FBandIndex := BandIndex;
end;

procedure TcxTreeListColumnPosition.Load;
begin
  BandIndex := FBandIndex;
end;

function TcxTreeListColumnPosition.GetBandIndex: Integer;
begin
  if Column.OwnerBand <> nil then
    Result := Column.OwnerBand.Index
  else
    Result := -1;
end;

function TcxTreeListColumnPosition.GetColumn: TcxTreeListColumn;
begin
  Result := TcxTreeListColumn(GetOwner);
end;

function TcxTreeListColumnPosition.GetOwnerBandVisibleIndex: Integer;
begin
  Result := BandIndex;
  if BandIndex <> cxInvalidIndex then
    Result := Column.OwnerBand.VisibleIndex;
end;

function TcxTreeListColumnPosition.GetTreeList: TcxCustomTreeListControl;
begin
  Result := Column.TreeList;
end;

procedure TcxTreeListColumnPosition.SetBandIndex(Index: Integer);
begin
  if BandIndex <> Index then
    Column.OwnerBand := GetBandFromIndex(Index);
  if [csReading, csUpdating] * Column.ComponentState <> [] then
    FBandIndex := Index;
end;

procedure TcxTreeListColumnPosition.SetColIndex(Value: Integer);
begin
  if TreeList.IsRestore then
    FColIndex := Value
  else
    if cxValidateIntDefEx(Value, FColIndex, 0) then
    begin
      TreeList.BeginUpdate;
      try
        if Value > FColIndex then Inc(Value);
        SetPositionEx(BandIndex, Value, RowIndex, False);
      finally
        TreeList.EndUpdate;
      end;
    end;
end;

procedure TcxTreeListColumnPosition.SetLineCount(Value: Integer);
begin
  if cxValidateIntDefEx(Value, FLineCount, 1) then
  begin
    FLineCount := Value;
    Column.PositionChanged;
  end;
end;

procedure TcxTreeListColumnPosition.SetRowIndex(Value: Integer);
begin
  if TreeList.IsRestore then
    FRowIndex := Value
  else
    if cxValidateIntDefEx(Value, FRowIndex, 0) then
    begin
      FRowIndex := Value;
      Column.PositionChanged;
    end;
end;

{ TcxTreeListCaption }

constructor TcxTreeListCaption.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FGlyph := TBitmap.Create; 
end;

constructor TcxTreeListCaption.CreateEx(ATreeList: TcxCustomTreeListControl;
  AOwner: TPersistent; AViewInfo: TcxTreeListViewInfoItem);
begin
  Create(AOwner);
  FTreeList := ATreeList;
  FViewInfo := AViewInfo;
  ShowEndEllipsis := True;
end;

destructor TcxTreeListCaption.Destroy;
begin
  FreeAndNil(FGlyph);
  inherited Destroy;
end;

procedure TcxTreeListCaption.Assign(Source: TPersistent);
begin
  if Source is TcxTreeListCaption then
  begin
    FState := TcxTreeListCaption(Source).FState;
    FAlignHorz := TcxTreeListCaption(Source).FAlignHorz;
    FAlignVert := TcxTreeListCaption(Source).FAlignVert;
    FText := TcxTreeListCaption(Source).Text;
    FGlyphAlignHorz := TcxTreeListCaption(Source).FGlyphAlignHorz;
    FGlyphAlignVert := TcxTreeListCaption(Source).FGlyphAlignVert;
    Glyph := TcxTreeListCaption(Source).Glyph;
  end
  else
    inherited Assign(Source);
end;

procedure TcxTreeListCaption.Changed;
begin
  if (FViewInfo = nil) or (TreeList = nil) or TreeList.IsLocked then Exit;
  FViewInfo.DoCalculate;
  FViewInfo.Invalidate;
end;

function TcxTreeListCaption.GetState(Index: Integer): Boolean;
begin
  Result := cxGetState(FState, Index);
end;

function TcxTreeListCaption.GetText: string;
begin
  Result := FText;
  if (Result = '') and (GetOwner is TcxTreeListColumn) then
    Result := TcxItemDataBindingAccess(
      TcxTreeListColumn(GetOwner).DataBinding).GetDefaultCaption;
end;

function TcxTreeListCaption.IsTextStored: Boolean;
begin
  Result := FText <> '';
  if Result and (GetOwner is TcxTreeListColumn) then
  begin
    Result := FText <> TcxItemDataBindingAccess(
      TcxTreeListColumn(GetOwner).DataBinding).GetDefaultCaption;
  end; 
end;

procedure TcxTreeListCaption.SetState(Index: Integer; Value: Boolean);
begin
  if cxSetState(FState, Index, Value) then
    Changed;
end;

procedure TcxTreeListCaption.SetAlignHorz(Value: TAlignment);
begin
  if Value <> FAlignHorz then
  begin
    FAlignHorz := Value;
    Changed;
  end;
end;

procedure TcxTreeListCaption.SetAlignVert(Value: TcxAlignmentVert);
begin
  if Value <> FAlignVert then
  begin
    FAlignVert := Value;
    Changed;
  end;
end;

procedure TcxTreeListCaption.SetGlyph(Value: TBitmap);
begin
  FGlyph.Assign(Value);
  Changed;
end;

procedure TcxTreeListCaption.SetGlyphAlignHorz(Value: TAlignment);
begin
  if FGlyphAlignHorz <> Value then
  begin
    FGlyphAlignHorz := Value;
    if not FGlyph.Empty then Changed;
  end;
end;

procedure TcxTreeListCaption.SetGlyphAlignVert(Value: TcxAlignmentVert);
begin
  if FGlyphAlignVert <> Value then
  begin
    FGlyphAlignVert := Value;
    if not FGlyph.Empty then Changed;
  end;
end;

procedure TcxTreeListCaption.SetText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    Changed;
  end;
end;

{ TcxTreeListColumnOptions }

constructor TcxTreeListColumnOptions.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  Sizing := True;
  CellEndEllipsis := True;
end;

procedure TcxTreeListColumnOptions.Assign(Source: TPersistent);
begin
  if Source is TcxTreeListColumnOptions then
    FState := TcxTreeListColumnOptions(Source).FState;
  inherited Assign(Source);
end;

procedure TcxTreeListColumnOptions.RestoreDefaults;
begin
  Sorting := True;
  Sizing := True;
  Customizing := True;
  Editing := True;
  TabStop := True;
  Focusing := True;
  Moving := True;
  Changed; 
end;

procedure TcxTreeListColumnOptions.Changed;
begin
  with TcxTreeListColumn(GetOwner) do
    if TreeList <> nil then TreeList.UpdateViewStyles;
end; 

function TcxTreeListColumnOptions.GetValue(Index: Integer): Boolean;
begin
  Result := cxGetState(FState, Index);
end;

procedure TcxTreeListColumnOptions.SetValue(Index: Integer; const Value: Boolean);
begin
  if cxSetState(FState, Index, Value) then Changed;
end;

{ TcxTreeListColumnSummaryFooter }

procedure TcxTreeListColumnSummaryFooter.Assign(Source: TPersistent);
var
  AProp: TcxTreeListColumnSummaryFooter;
begin
  if Source is TcxTreeListColumnSummaryFooter then
  begin
    AProp := TcxTreeListColumnSummaryFooter(Source);
    Kind := AProp.Kind;
    Format := AProp.Format;
    AlignHorz := AProp.AlignHorz;
    AlignVert := AProp.AlignVert;
    MultiLine := AProp.MultiLine;
  end
  else
    inherited Assign(Source);
end;

function TcxTreeListColumnSummaryFooter.IsFormatStored: Boolean;
begin
  Result := Format <> '';
end;

function TcxTreeListColumnSummaryFooter.IsSummaryItemValid: Boolean;
begin
  ItemIndex := SummaryItemIndex;
  Result := ItemIndex <> -1;
end;

function TcxTreeListColumnSummaryFooter.Summary: TcxDataSummary;
begin
  Result := DataController.Summary;
end;

procedure TcxTreeListColumnSummaryFooter.SummaryItemChanged;
begin                                   
  with Column.TreeList do
  begin
    if IsLocked then Exit; 
    Column.ViewInfo.FColumnFooter.DoCalculate;
    if OptionsView.Footer then
      ViewInfo.InvalidateRect(ViewInfo.FooterRect);
  end;
end;

function TcxTreeListColumnSummaryFooter.SummaryItemIndex: Integer;
begin
  Result := SummaryItems.IndexOfItemLink(Column);
end;

function TcxTreeListColumnSummaryFooter.SummaryItems: TcxDataFooterSummaryItems;
begin
  Result := Summary.FooterSummaryItems;
end;

function TcxTreeListColumnSummaryFooter.GetColumn: TcxTreeListColumn;
begin
  Result := TcxTreeListColumn(GetOwner);
end;

function TcxTreeListColumnSummaryFooter.GetDataController: TcxCustomDataController;
begin
  Result := Column.DataController;
end;

function TcxTreeListColumnSummaryFooter.GetFormat: string;
begin
  if IsSummaryItemValid then
    FFormat := SummaryItem.Format;
  Result := FFormat; 
end;

function TcxTreeListColumnSummaryFooter.GetSummaryItem: TcxDataSummaryItem;
begin
  if IsSummaryItemValid then
    Result := SummaryItems[ItemIndex]
  else
    Result := nil;
end;

function TcxTreeListColumnSummaryFooter.GetSummaryKind: TcxSummaryKind;
begin
  if SummaryItem <> nil then
    Result := SummaryItem.Kind
  else
    Result := skNone;
end;

function TcxTreeListColumnSummaryFooter.GetSummaryText: string;
begin
  if IsSummaryItemValid then
    Result := Summary.FooterSummaryTexts[ItemIndex]
  else
    Result := '';
end;

function TcxTreeListColumnSummaryFooter.GetSummaryValue: Variant;
begin
  if IsSummaryItemValid then
    Result := Summary.FooterSummaryValues[ItemIndex]
  else
    Result := '';
end;

procedure TcxTreeListColumnSummaryFooter.SetAlignHorz(Value: TAlignment);
begin
  if FAlignHorz <> Value then
  begin
    FAlignHorz := Value;
    SummaryItemChanged;
  end;
end;

procedure TcxTreeListColumnSummaryFooter.SetAlignVert(Value: TcxAlignmentVert);
begin
  if FAlignVert <> Value then
  begin
    FAlignVert := Value;
    SummaryItemChanged;
  end;
end;

procedure TcxTreeListColumnSummaryFooter.SetFormat(const Value: string);
begin
  FFormat := Value;
  if IsSummaryItemValid then
    SummaryItem.Format := Value;
  SummaryItemChanged;
end;

procedure TcxTreeListColumnSummaryFooter.SetMultiLine(Value: Boolean);
begin
  if Value <> FMultiLine then
  begin
    FMultiLine := Value;
    SummaryItemChanged;
  end;
end;

procedure TcxTreeListColumnSummaryFooter.SetSummaryText(const Value: string);
begin
  SummaryValue := Value;
  if IsSummaryItemValid then
    Summary.FooterSummaryValues[ItemIndex] := Value;
end;

procedure TcxTreeListColumnSummaryFooter.SetSummaryValue(const Value: Variant);
begin
  if IsSummaryItemValid then
    Summary.FooterSummaryValues[ItemIndex] := Value;
   SummaryItemChanged;
end;

procedure TcxTreeListColumnSummaryFooter.SetSummaryKind(Value: TcxSummaryKind);
begin
{  if Kind <> Value then
  begin
    if Value = skNone then
      SummaryItem.Free
    else }
    begin
      if not IsSummaryItemValid then
        SummaryItems.Add.ItemLink := Column;
      with SummaryItem do
      begin
       Kind := Value;
       Format := FFormat;
      end;
      SummaryItemChanged;
    end;
//  end;
end;

{ TcxTreeListColumn }

constructor TcxTreeListColumn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FViewInfo := GetViewInfoClass.Create(Self);
  FSummaryFooter := GetSummaryFooterClass.Create(Self);
  FCaption := TcxTreeListCaption.CreateEx(nil, Self, FViewInfo.FColumnHeader);
  FPosition := GetPositionClass.Create(Self);
  FMinWidth := cxTreeListDefMinWidth;
  SetState(tlcsVisible, True);
end;

destructor TcxTreeListColumn.Destroy;
begin
  SortOrder := soNone;
  if Visible then
    TreeList.ViewInfo.NodesViewInfo.Clear;
  if (TreeList <> nil) and not TreeList.IsDestroying  then
  begin
    if TreeList <> nil then
      TreeList.ColumnsList.Remove(Self);
    if Controller.FocusedItem = Self then
      Controller.FocusedItem := nil;
    UpdateIndexesBeforeRemove; 
    OwnerBand := nil;
    TreeList.DoUpdateDesignerForms;
    if TreeList.Preview.Column = Self then
      TreeList.Preview.Column := nil;
    if TreeList.OptionsView.CategorizedColumn = Self then
      TreeList.OptionsView.CategorizedColumn := nil;
  end;
  FreeAndNil(FCaption);
  FreeAndNil(FViewInfo);
  FreeAndNil(FPosition);
  FreeAndNil(FSummaryFooter);
  inherited Destroy;
end;

procedure TcxTreeListColumn.Assign(Source: TPersistent);
var
  AColumn: TcxTreeListColumn;
begin
  TreeList.BeginUpdate;
  try
    inherited Assign(Source);
    if Source is TcxTreeListColumn then
    begin
      AColumn := TcxTreeListColumn(Source);
      FCalculatedWidth := AColumn.FCalculatedWidth;
      FMinWidth := AColumn.FMinWidth;
      FWidth := AColumn.FWidth;
      Position := TcxTreeListColumn(Source).Position;
      Caption := AColumn.Caption;
      SortOrder := AColumn.FSortOrder;
      Visible := AColumn.Visible;
    end;
  finally
    TreeList.EndUpdate;
  end;
end;

procedure TcxTreeListColumn.ApplyBestFit;
var
  ANode: TcxTreeListNode;
  AIndentSize, AWidth: Integer;
  AHeight, AOffset, ACount: Integer;
  AIsLeftMost: Boolean;
  AInfo: TcxTemporaryCellViewInfo;
begin
  if (TreeList = nil) or not CanSizing(dsdHorz) then Exit;
  if TreeList.FLevelIndentWidth = 0 then
     TreeList.DoLayoutChanged;
  if IsLeftMost then
    TreeList.FContentIndentWidth := 0;
  TreeList.HandleNeeded;
  AHeight := TreeList.ViewInfo.DefaultHeight;
  ANode := TreeList.GetStartNodeForBestFit;
  ACount := TreeList.GetCountNodeForBestFit;
  AInfo := TcxTemporaryCellViewInfo(TreeList.ViewInfo.SizingViewInfo);
  AIsLeftMost := IsLeftMost;
  AIndentSize := TreeList.FLevelIndentWidth;
  try
    TreeList.HideEdit;
    while (ACount <> 0) and (ANode <> nil) do
    begin
      if AIsLeftMost then
        AOffset := (ANode.Level + Byte(TreeList.OptionsView.ShowRoot)) * AIndentSize
      else
        AOffset := 0;
      AWidth := AInfo.CalculateWidth(Self, ANode, True, AHeight);
      if (AWidth + AOffset) > Data then
        FData := AWidth + AOffset;
      ANode := ANode.GetNextVisible;
      Dec(ACount);
    end;
    AWidth := GetHeaderFooterBestfitSize;
    if AWidth > Data then Data := AWidth;
    SetSizeDelta(dsdHorz, Data - DisplayWidth);
  finally
    Data := 0;
    TreeList.LayoutChanged;
    TreeList.Controller.CheckEdit;
  end;
end;

function TcxTreeListColumn.GetDisplayText(Index: Integer): string;
begin
  Result := VarToStr(DoOnGetDisplayText(TreeList.Controller.GetNode(Index), True));
end;

function TcxTreeListColumn.GetParentComponent: TComponent;
begin
  Result := EditingControl;
end;

function TcxTreeListColumn.HasParent: Boolean;
begin
  Result := True;
end;

procedure TcxTreeListColumn.MakeVisible;
var
  AShift: Integer;
  R: TRect;
begin
  if Visibility and (OwnerBand.FixedKind = tlbfNone) then
  begin
    AShift := 0;
    R := TreeList.ViewInfo.ScrollingArea;
    if TreeList.OptionsView.Indicator and (TreeList.FixedBandCount = 0) then
      Inc(R.Left, TreeList.OptionsView.IndicatorWidth);
    with ViewInfo do
    begin
      if IsLeftMost then
      begin
        if (DisplayWidth > cxRectWidth(R)) and (XOfs <= R.Left) and
          ((XOfs + DisplayWidth) > R.Left) then
          Exit
        else
          AShift := 0;
      end
      else
        if (XOfs + DisplayWidth) >= R.Right then
          AShift := (XOfs + DisplayWidth) - R.Right
        else
          if XOfs <= R.Left then
            AShift := XOfs - R.Left - OptionsView.HorzIncrement;
      if (XOfs >= R.Left) and ((XOfs + DisplayWidth) <= R.Right) and not IsLeftMost then Exit;
    end;
    if AShift <> 0 then
    begin
      Inc(AShift, TreeList.ViewInfo.HorzScrollPos);
      TreeList.Scroll(sbHorizontal, scPosition, AShift);
    end
    else
      if IsLeftMost then
        TreeList.Scroll(sbHorizontal, scPosition, AShift);
  end;
  TreeList.LayoutChanged;
end;

procedure TcxTreeListColumn.RestoreDefaults;
begin
  TreeList.BeginUpdate;
  try
    Options.RestoreDefaults;
    SortOrder := soNone;
    Caption.FAlignVert := vaTop;
    Caption.FAlignHorz := taLeftJustify;
    RestoreWidths;
  finally
    TreeList.EndUpdate;
  end;
end;

procedure TcxTreeListColumn.RestoreWidths;
begin
  TreeList.BeginUpdate;
  try
    FMinWidth := cxTreeListDefMinWidth;
    SetWidth(cxTreeListDefWidth);
  finally
    TreeList.EndUpdate;
  end;
end;

procedure TcxTreeListColumn.DoSizeChanged;
begin
  if Visibility or TreeList.IsLocked then
    TreeList.LayoutChanged;
  if not TreeList.IsLocked then 
    TreeList.DoColumnSizeChanged(Self);
end;

function TcxTreeListColumn.CanInitEditing: Boolean;
begin
  with TreeList do
  begin
    Result := inherited CanInitEditing and ((DragAndDropState = ddsNone) or
      ((DragMode <> dmAutomatic) or not HitTest.HitAtNode));
  end;
end;

function TcxTreeListColumn.CanMoving: Boolean;
begin
  Result := TreeList.OptionsCustomizing.ColumnMoving and
    Options.Moving;
end;

function TcxTreeListColumn.CanSorted: Boolean;
begin
  Result := not Assigned(OnGetEditProperties) and
    (esoSorting in PropertiesValue.GetSupportedOperations);
  if not Result then
    Result := Assigned(TreeList.FOnCompare);
end;

function TcxTreeListColumn.CanFocus: Boolean;
begin
  Result := inherited CanFocus and TreeList.OptionsSelection.CellSelect;
end;

function TcxTreeListColumn.GetRealSortOrder: TcxDataSortOrder;
begin
  Result := soNone;
  if CanSorted then
    Result := FSortOrder;
end;

function TcxTreeListColumn.GetHeaderFooterBestfitSize: Integer;

  function CalcSize(AViewParams: TcxViewParams; const AText: string): Integer;
  begin
    Result := cxTextWidth(AViewParams.Font, AText) + cxTextOffset shl 2;
  end;

var
  ASize: Integer;
begin
  Result := FMinWidth;
  with TreeList.Styles do
  begin
    if TreeList.OptionsView.Headers then
    begin
      with Caption do
      begin
        ASize := CalcSize(GetColumnHeaderParams(Self), Text);
        if not Glyph.Empty and (Byte(GlyphAlignHorz) < 2) then
          Inc(ASize, Glyph.Width);
        if ASize > Result then Result := ASize;
        if SortOrder <> soNone then
          Inc(Result, TreeList.LookAndFeelPainter.SortingMarkAreaSize.X);
      end;
    end;
    if TreeList.OptionsView.Footer and Options.Footer then
    begin
      ASize := CalcSize(GetColumnFooterParams(Self), SummaryFooter.SummaryText);
      with TreeList.LookAndFeelPainter do 
        Inc(ASize, (FooterCellBorderSize + FooterCellOffset) shl 1);
      if ASize > Result then Result := ASize;
    end; 
  end;
end;

function TcxTreeListColumn.GetOptionsClass: TcxCustomEditContainerItemOptionsClass;
begin
  Result := TcxTreeListColumnOptions;
end;

function TcxTreeListColumn.GetState(Index: Integer): Boolean;
begin
  Result := cxGetState(FState, Index);
end;

function TcxTreeListColumn.GetStylesClass: TcxEditContainerStylesClass;
begin
  Result := TcxTreeListColumnStyles;
end;

function TcxTreeListColumn.GetSummaryFooterClass: TcxTreeListColumnSummaryFooterClass;
begin
  Result := TcxTreeListColumnSummaryFooter;
end;

procedure TcxTreeListColumn.SetEditingControl(Value: TcxEditingControl);
begin
  if TreeList <> nil then
    TreeList.ColumnsList.Remove(Self);
  if not (csDestroying in ComponentState) and (Value <> nil) then
    FCaption.FTreeList := TcxCustomTreeListControl(Value);
  inherited SetEditingControl(Value);
  if TreeList <> nil then TreeList.DoUpdateDesignerForms;
end;

procedure TcxTreeListColumn.SetName(const Value: TComponentName);
begin
  inherited SetName(Value);
  if Assigned(FOnChangeName) then FOnChangeName(Self);
end;

procedure TcxTreeListColumn.SetParentComponent(Value: TComponent);
begin
  if Value is TcxEditingControl then
    EditingControl := Value as TcxEditingControl
  else
    EditingControl := nil;
end;

procedure TcxTreeListColumn.SetState(Index: Integer; Value: Boolean);
begin
  cxSetState(FState, Index, Value)
end;

function TcxTreeListColumn.HasDataTextHandler: Boolean; 
begin
  Result := Assigned(FOnGetDisplayText);
end;

procedure TcxTreeListColumn.InitAutoWidthItem(AItem: TcxAutoWidthItem);
begin
  AItem.Width := Width;
  AItem.MinWidth := FMinWidth;
  AItem.Fixed := not Options.Sizing or IsFixed;
  AItem.AutoWidth := -1;
end;

procedure TcxTreeListColumn.InternalSetBandOwner(
  ABand: TcxTreeListBand; RemoveFromOwner: Boolean);
begin
  try
    if ABand = OwnerBand then Exit;
    if IsBandAssigned and RemoveFromOwner then
      FOwnerBand.RemoveColumn(Self);
    if ABand <> nil then
      ABand.AddColumn(Self);
  finally
    FOwnerBand := ABand;
    DoVisibilityChanged;
  end; 
end;

function TcxTreeListColumn.IsBandAssigned: Boolean;
begin
  Result := FOwnerBand <> nil;
end;

procedure TcxTreeListColumn.PositionChanged;
begin
  if IsBandAssigned then
    OwnerBand.Changed(True);
end;

procedure TcxTreeListColumn.UpdateIndexesBeforeRemove;
var
  I: Integer;
  APos: TcxtreeListColumnPosition;
begin
  if OwnerBand = nil then Exit;
  for I := 0 to OwnerBand.ColumnCount - 1 do
  begin
    APos := OwnerBand.Columns[I].Position;
    if (APos.RowIndex = Position.RowIndex) and (APos.FColIndex > Position.ColIndex) then
      Dec(APos.FColIndex);
  end;
end;

function TcxTreeListColumn.CanSizing(ADirection: TcxDragSizingDirection): Boolean;
begin
  if ADirection = dsdVert then
    Result := TreeList.OptionsCustomizing.ColumnVertSizing and
      not TreeList.OptionsView.HeaderSingleLine
  else
    Result := Options.Sizing and TreeList.OptionsCustomizing.ColumnHorzSizing;
end;

function TcxTreeListColumn.GetAvailableMaxWidth: Integer;
var
  AFromIndex, AToIndex: Integer;
begin
  Result := FMinWidth;
  if not Visibility then Exit;
  Result := MaxInt shr 2;
  if OwnerBand.Width <> 0 then
  begin
    Result := OwnerBand.DisplayWidth - OwnerBand.IndentWidth;
    cxGetIndexes(OwnerBandRow.FItems, Self, AFromIndex, AToIndex);
    with OwnerBandRow do
      while AFromIndex <= AToIndex do
      begin
        Dec(Result, Items[AFromIndex].GetRealMinSize);
        Inc(AFromIndex);
      end;
  end;
end;

function TcxTreeListColumn.GetRealMinSize: Integer;
begin
  if Options.Sizing then
    Result := FMinWidth
  else
    Result := FWidth;
end;

function TcxTreeListColumn.GetSizingBoundsRect(
  ADirection: TcxDragSizingDirection): TRect;
begin
  with TreeList.ViewInfo, ViewInfo.FColumnHeader do
  begin
    if ADirection <> dsdVert then
      Result := cxRectSetLeft(ClientRect, DisplayRect.Left + GetRealMinSize, GetAvailableMaxWidth)
    else
      Result := cxRectSetTop(ClientRect, DisplayRect.Top + HeaderLineHeight);
  end;
end;

function TcxTreeListColumn.GetSizingIncrement(
  ADirection: TcxDragSizingDirection): Integer;
begin
  if ADirection = dsdHorz then
    Result := 1
  else
    Result := TreeList.ViewInfo.HeaderLineHeight;
end;

function TcxTreeListColumn.IsDynamicUpdate: Boolean;
var
  ADir: TcxDragSizingDirection;
begin
  Result := TreeList.OptionsCustomizing.DynamicSizing and
    TreeList.HitTest.CanSizing(ADir) and (ADir = dsdHorz);
end;

procedure TcxTreeListColumn.SetSizeDelta(
  ADirection: TcxDragSizingDirection; ADelta: Integer);
begin
  if ADelta = 0 then Exit;
  TreeList.Controller.ForceWidthItem := Self;
  if ADirection = dsdHorz then
  begin
    TreeList.BeginUpdate;
    try
      TreeList.AssignColumnWidths;
      Width := DisplayWidth + ADelta;
      // calculate new realwidth for band 
      OwnerBand.BandRows.Refresh;
      OwnerBand.FCalculatedWidth := OwnerBand.BandRows.ColumnsMaxWidth;
      // refresh columns in band
      OwnerBand.RealignColumns;
      // refresh bands (may be depends on column widths)
      TreeList.RealignBands;
      // refresh columns in band, band width can changed after refresh bands 
      OwnerBand.RealignColumns;
      // apply new widths
      TreeList.AssignColumnWidths;
    finally
      TreeList.EndUpdate;
    end;
  end
  else
    Position.FLineCount := Position.LineCount + ADelta;
  TreeList.Controller.ForceWidthItem := nil;
  TreeList.LayoutChanged;
  TreeList.Modified;
  DoSizeChanged;
end;

function TcxTreeListColumn.GetItemIndex: Integer;
begin
  Result := inherited ItemIndex;
end;

function TcxTreeListColumn.GetVisibleIndex: Integer;
begin
  Result := TreeList.FColumnsVisibleList.IndexOf(Self)
end;

procedure TcxTreeListColumn.SetItemIndex(Value: Integer);

  function IsIndexValid(AIndex: Integer): Boolean;
  begin
    Result := (AIndex >= 0) and (AIndex < TreeList.ContainerList.Count)
  end;

begin
  with TreeList do
  begin
    BeginUpdate;
    try
      if IsIndexValid(ItemIndex) and IsIndexValid(Value) then
        ContainerList.Exchange(ItemIndex, Value);
      Position.ColIndex := Value;
      DataController.UpdateItemIndexes;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TcxTreeListColumn.SetVisibleIndex(Value: Integer);
begin
  // todo: do nothing
end;

function TcxTreeListColumn.GetObjectName: string;
begin
  Result := Name;
  if Result = '' then
    Result := ClassName + IntToStr(ItemIndex);
end;

function TcxTreeListColumn.GetProperties(AProperties: TStrings): Boolean;
var
  I: Integer;
begin
  for I := 0 to High(ColumnPropertiesName) do
    AProperties.Add(ColumnPropertiesName[I]);
  Result := True;
end;

function TcxTreeListColumn.GetPropertyIndex(const AName: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to High(ColumnPropertiesName) do
  begin
    if AnsiCompareText(ColumnPropertiesName[I], AName) = 0 then
    begin
      Result := I;
      Break;
    end;
  end;
end;

procedure TcxTreeListColumn.GetPropertyValue(
  const AName: string; var AValue: Variant);
begin
  case GetPropertyIndex(AName) of
    0: AValue := Visible;
    1: AValue := ItemIndex;
    2: AValue := Position.FLineCount;
    3: AValue := Position.FColIndex;
    4: AValue := Position.FRowIndex;
    5: AValue := Position.BandIndex;
    6: AValue := Caption.Text;
    7: AValue := SortOrder;
    9: AValue := FMinWidth;
    10: AValue := FIsWidthAssigned;
    11: AValue := FWidth;
  end;
end;

procedure TcxTreeListColumn.SetPropertyValue(
  const AName: string; const AValue: Variant);
begin
  case GetPropertyIndex(AName) of
    0: Visible := AValue;
    1: ItemIndex := AValue;
    2: Position.FLineCount := AValue;
    3: Position.FColIndex := AValue;
    4: Position.FRowIndex := AValue;
    5: Position.BandIndex := AValue;
    6:
      if Caption.Text = '' then
        Caption.Text := AValue;
    7: FSortOrder := AValue;
    9: FMinWidth := AValue;
   10: FIsWidthAssigned := AValue;
   11: FWidth := AValue;
   end;
end;

procedure TcxTreeListColumn.DoGetDisplayText(
  ARecordIndex: Integer; var AText: string);
begin
  if (ARecordIndex >= 0) and (ARecordIndex < TreeList.FNodesList.Count) and
    (ARecordIndex < DataController.RecordCount) then
  begin
    AText := DoGetNodeDisplayText(
      TcxTreeListNode(TreeList.FNodesList[ARecordIndex]), AText);
  end;
end;

function TcxTreeListColumn.DoGetNodeDisplayText(
  ANode: TcxTreeListNode; const AValue: Variant): Variant;
var
  AText: string;
begin
  Result := AValue;
  if Assigned(OnGetDisplayText) then
  begin
    AText := VarToStr(Result);
    OnGetDisplayText(Self, ANode, AText);
    Result := AText;
  end;
end;

function TcxTreeListColumn.DoOnGetDisplayText(
  ANode: TcxTreeListNode; AsText: Boolean = False; AValueOnly: Boolean = False): Variant;
var
  AProperties: TcxCustomEditProperties;
  AText: string;
begin
  AProperties := DoGetEditProperties(ANode);
  Result := GetDisplayValue(AProperties, ANode.RecordIndex);
  if AValueOnly then Exit; 
  if Assigned(OnGetDisplayText) or AsText then
  begin
    if AProperties.GetEditValueSource(False) = evsValue then
    begin
      if AsText then
        AText := AProperties.GetDisplayText(Values[ANode.RecordIndex], True)
      else
        AText := '';
      AText := DoGetNodeDisplayText(ANode, AText);
      if (AText = '') and not AsText then
        Result := Values[ANode.RecordIndex]
      else
        Result := AText;
    end
    else
      Result := DoGetNodeDisplayText(ANode, Result);
  end;
end;

procedure TcxTreeListColumn.DoVisibilityChanged;
begin
  if (FOwnerBand <> nil) and (TreeList <> nil) and not TreeList.IsDestroying then
  begin
    FOwnerBand.Changed(True);
    TreeList.DoUpdateDesignerForms;
  end;
end;

function TcxTreeListColumn.GetCellHeight(ANode: TcxTreeListNode;
  AWidth, ALines: Integer; AFont: TFont; const AValue: Variant): Integer;
var
  ASizeProp: TcxEditSizeProperties;
  AEditProp: TcxCustomEditProperties;
  AViewData: TcxCustomEditViewData;
begin
  ASizeProp := cxDefaultEditSizeProp;
  AEditProp := DoGetEditProperties(ANode);
  AViewData := nil;
  try
    if AEditProp = PropertiesValue then
      AViewData := EditViewData
    else
      AViewData := AEditProp.CreateViewData(TreeList.EditStyle, True);
    AViewData.Style.Font := AFont;
    ASizeProp.Width := AWidth;
    ASizeProp.MaxLineCount := ALines;
    Result := AViewData.GetEditSize(GetControlCanvas, AValue, ASizeProp).cy;
  finally
    if AViewData <> EditViewData then FreeAndNil(AViewData);
  end;
end;

function TcxTreeListColumn.GetPositionClass: TcxTreeListColumnPositionClass;
begin
  Result := TcxTreeListColumnPosition;
end;

function TcxTreeListColumn.GetViewInfoClass: TcxTreeListColumnViewInfoClass;
begin
  Result := TcxTreeListColumnViewInfo;
end;

function TcxTreeListColumn.GetEditingProperties: TcxTreeListGetEditPropertiesEvent;
begin
  Result := TcxTreeListGetEditPropertiesEvent(inherited OnGetEditingProperties);
end;

function TcxTreeListColumn.GetEditProperties: TcxTreeListGetEditPropertiesEvent;
begin
  Result := TcxTreeListGetEditPropertiesEvent(inherited OnGetEditProperties);
end;

function TcxTreeListColumn.GetIndentWidth: Integer;
begin
  Result := TreeList.GetIndentWidth(IsLeftMost);
end;

function TcxTreeListColumn.GetDataBinding: TcxItemDataBinding;
begin
  Result := TcxItemDataBinding(inherited DataBinding);
end;

function TcxTreeListColumn.GetDisplayWidth: Integer;
begin
  if Visibility then
    Result := RealWidth + IndentWidth
  else
    Result := 0;
end;

function TcxTreeListColumn.GetIsFixed: Boolean;
var
  AForceWidthItem: TcxTreeListColumn;
begin
  if (TreeList.Controller.ForceWidthItem is TcxTreeListColumn) then
  begin
    AForceWidthItem := TreeList.Controller.ForceWidthItem as TcxTreeListColumn;
    Result := (AForceWidthItem.OwnerBand = OwnerBand) and ((AForceWidthItem = Self) or
      (not AForceWidthItem.IsRight and (VisibleIndex < AForceWidthItem.VisibleIndex)));
  end
  else
    Result := False;
end;

function TcxTreeListColumn.GetIsHidden: Boolean;
begin
  Result := not Visibility or IsPreview; 
end;

function TcxTreeListColumn.GetIsLeft: Boolean;
begin
  Result := Visibility and (OwnerBandRow <> nil) and (OwnerBandRow.First = Self);
end;

function TcxTreeListColumn.GetIsLeftMost: Boolean;
begin
  Result := IsLeft and (OwnerBand.VisibleIndex = 0);
end;

function TcxTreeListColumn.GetIsRightMost: Boolean;
begin
  Result := IsRight and (OwnerBand.VisibleIndex = TreeList.VisibleBandCount - 1);
end;

function TcxTreeListColumn.GetIsPreview: Boolean;
begin
  Result := (TreeList <> nil) and (TreeList.Preview.Column = Self); 
end;

function TcxTreeListColumn.GetIsRight: Boolean;
begin
  Result := Visibility and (OwnerBandRow.Last = Self);
end;

function TcxTreeListColumn.GetIsWidthStored: Boolean;
begin
  Result := FIsWidthAssigned; 
end;

function TcxTreeListColumn.GetStyles: TcxTreeListColumnStyles;
begin
  Result := TcxTreeListColumnStyles(inherited Styles);
end;

function TcxTreeListColumn.GetOptions: TcxTreeListColumnOptions;
begin
  Result := TcxTreeListColumnOptions(inherited Options);
end;

function TcxTreeListColumn.GetOwnerBandRow: TcxTreeListBandRow;
begin
  if (OwnerBand <> nil) and (OwnerBand.BandRows.Count > 0) then
    Result := OwnerBand.BandRows[Position.RowIndex]
  else
    Result := nil;
end;

function TcxTreeListColumn.GetRealMinWidth: Integer;
begin
  Result := FMinWidth;
  if IsFixed then
    Result := RealWidth;
end;

function TcxTreeListColumn.GetRealWidth: Integer;
begin
  Result := FCalculatedWidth;
  if Result = 0 then
    Result := Width;
end;

function TcxTreeListColumn.GetTreeList: TcxCustomTreeListControl;
begin
  Result := TcxCustomTreeListControl(EditingControl);
end;

function TcxTreeListColumn.GetVisible: Boolean;
begin
  if TreeList.CanColumnVisible(Self) then
    Result := GetState(tlcsVisible)
  else
    Result := False;
end;

function TcxTreeListColumn.GetVisibility: Boolean;
begin
  Result := Visible and (IsBandAssigned and OwnerBand.Visible)
end;

function TcxTreeListColumn.GetWidth: Integer;
begin
  if FIsWidthAssigned then
    Result := FWidth
  else
    Result := Max(MinWidth, cxTreeListDefWidth);
end;

procedure TcxTreeListColumn.SetCaption(Value: TcxTreeListCaption);
begin
  FCaption.Assign(Value);
end;

procedure TcxTreeListColumn.SetDataBinding(Value: TcxItemDataBinding);
begin
  DataBinding.Assign(Value);
end;

procedure TcxTreeListColumn.SetEditingProperties(
  Value: TcxTreeListGetEditPropertiesEvent);
begin
  inherited OnGetEditingProperties := TcxGetEditPropertiesEvent(Value);
end;

procedure TcxTreeListColumn.SetEditProperties(
  Value: TcxTreeListGetEditPropertiesEvent);
begin
  inherited OnGetEditProperties := TcxGetEditPropertiesEvent(Value);
end;

procedure TcxTreeListColumn.SetIsPreview(Value: Boolean);
begin
  if Value <> IsPreview then
  begin
    if Value then
      TreeList.Preview.Column := Self
    else
      TreeList.Preview.Column := nil;
  end;
end;

procedure TcxTreeListColumn.SetMinWidth(Value: Integer);
begin
  if cxValidateIntDefEx(Value, FMinWidth, 0) then
  begin
    FMinWidth := Value;
    if FMinWidth > Width then
      SetWidth(FMinWidth); 
  end;
end;

procedure TcxTreeListColumn.SetOptions(Value: TcxTreeListColumnOptions);
begin
  Options.Assign(Value);
end;

procedure TcxTreeListColumn.SetOwnerBand(Value: TcxTreeListBand);
begin
  InternalSetBandOwner(Value, Value <> OwnerBand)
end;

procedure TcxTreeListColumn.SetPosition(Value: TcxTreeListColumnPosition);
begin
  FPosition.Assign(Value);
end;

procedure TcxTreeListColumn.SetSorted(Value: TcxDataSortOrder);
begin
  if not Options.Sorting then
    Value := soNone;
  if Value <> FSortOrder then
  begin
    FSortOrder := Value;
    with TreeList do
    begin
      FNeedRestoreSorting := FNeedRestoreSorting or (Value = soNone);
      ColumnSortOrderChanged(Self);
    end;
    if CanSorted and (TreeList <> nil) and not IsDestroying then
    begin
      TreeList.DoSortNodes;
      if not TreeList.IsLocked then
        ViewInfo.ColumnHeader.Invalidate(True);
    end;
    TreeList.Modified;
  end;
end;

procedure TcxTreeListColumn.SetStyles(Value: TcxTreeListColumnStyles);
begin
  Styles.Assign(Value);
end;

procedure TcxTreeListColumn.SetSummaryFooter(
  Value: TcxTreeListColumnSummaryFooter);
begin
  FSummaryFooter.Assign(Value);
end;

procedure TcxTreeListColumn.SetVisible(Value: Boolean);
begin
  if Value <> GetState(tlcsVisible) then
  begin
    SetState(tlcsVisible, Value);
    if FOwnerBand <> nil then
    begin
{      if not Value then
        OwnerBand.FColumns.Remove(Self)
      else}
        if OwnerBand.FColumns.IndexOf(Self) < 0 then
          OwnerBand.FColumns.Add(Self);
    end;
    if IsBandAssigned and OwnerBand.Visible then DoVisibilityChanged;
  end;
end;

procedure TcxTreeListColumn.SetWidth(Value: Integer);
begin
  if cxValidateIntDefEx(Value, FWidth, FMinWidth) then
  begin
    FWidth := Value;
    FIsWidthAssigned := True;
    DoSizeChanged;
  end;
end;

{ TcxTreeListDragAndDropObject }

destructor TcxTreeListDragAndDropObject.Destroy;
begin
  FreeAndNil(ScreenArrows);
  FreeAndNil(DragDropInfo);
  inherited Destroy;
end;

procedure TcxTreeListDragAndDropObject.BeginDragAndDrop;
begin
  inherited BeginDragAndDrop;
  with TreeList.ViewInfo do
  begin
    if ScrollingAreaVisible then
      with ScrollingArea do
      begin
        AddAutoScrollingObject(Rect(Left, Top, Left + cxtlScrollDelta, Bottom),
          sbHorizontal, scLineUp);
        AddAutoScrollingObject(Rect(Right - cxtlScrollDelta, Top, Right, Bottom),
          sbHorizontal, scLineDown);
      end;
    if IsDragColumn then
    begin
      if not DragColumn.Visibility then StorePosition;
      if TreeList.Customizing.Visible then
        TreeList.Customizing.MakeColumnSheetVisible;
    end
    else
      if IsDragBand and TreeList.Customizing.Visible then
        TreeList.Customizing.MakeBandSheetVisible;
  end;
end;

function TcxTreeListDragAndDropObject.CanCustomizing: Boolean;
begin
  Result := TreeList.Customizing.Visible or
     (IsDragBand and TreeList.OptionsCustomizing.BandCustomizing) or
     (not IsDragBand and TreeList.OptionsCustomizing.ColumnCustomizing);
end;

function TcxTreeListDragAndDropObject.GetDisplayRect: TRect;
begin
  Result := TcxTreeListHeaderViewInfo(DragItem).GetDisplayRect;
end;

function TcxTreeListDragAndDropObject.GetDragAndDropCursor(
  Accepted: Boolean): TCursor;
begin
  Result := inherited GetDragAndDropCursor(Accepted);
  if not Accepted and CanCustomizing then
  begin
    if not IsDragBand or not TreeList.OptionsView.SimpleCustomizeBox and
      (TreeList.VisibleColumnCount > 1) then
      Result := crcxRemove;
    if IsDragColumn and not DragColumn.Options.Customizing then
      Result := crArrow;
  end
  else
    if Accepted and TreeList.Customizing.Visible and
      IsDragColumn and not DragColumn.Options.Customizing then
    begin
      if CheckCustomizingBox(DragDropInfo.DropPos) then
        Result := inherited GetDragAndDropCursor(False)
      else
        Result := crArrow;
    end;
  if Result = crDefault then Result := crArrow;
end;

procedure TcxTreeListDragAndDropObject.ChangeArrowPos(const ABaseLine: TRect;
  AllowHide: Boolean);
begin
  if AllowHide then
  begin
    if ScreenArrows <> nil then
      ScreenArrows.Hide;
  end
  else
  begin
    ArrowBaseLine := ABaseLine;
    DoDrawArrows;
  end;
end;

function TcxTreeListDragAndDropObject.CheckCustomizingBox(
  const APos: TPoint): Boolean;
begin
  with TreeList do 
    Result := Customizing.PtInCustomizingBox(ClientToScreen(APos));
end;

function TcxTreeListDragAndDropObject.CheckDropPos(ADragIndex, ADropIndex,
  DragX, DropX: Integer; var APos: Integer; var ASide: TcxBorder;
  ACheckIndex: Boolean = True): Boolean;
begin
  if ADragIndex = -1 then Dec(ADragIndex);
  APos := ADropIndex;
  ASide := bRight;
  if ACheckIndex then
    Result := (ADragIndex <> ADropIndex) and
      (ADragIndex <> (ADropIndex + cxIntOffs[DragX > DropX]))
  else
    Result := True;
  if not Result then
    APos := ADragIndex
  else
    if DragX <= DropX then
      ASide := bLeft
    else
      Inc(APos);
end;

procedure TcxTreeListDragAndDropObject.DoDrawHeaderItem(
  AItem: TcxTreeListHeaderViewInfo);
var
  AState: TcxButtonState;
begin
  AState := AItem.FState;
  AItem.FState := cxbsDefault;
  try
    if AItem is TcxTreeListColumnHeaderViewInfo and
      not TcxTreeListColumnHeaderViewInfo(AItem).Column.Visibility then
    begin
      Canvas.Brush.Color := clBtnShadow;
      Canvas.FillRect(TcxTreeListColumnHeaderViewInfo(AItem).GetDisplayRect);
    end
    else
    begin
      Canvas.Brush.Color := AItem.BandViewInfo.FContainerViewParams.Color;
      Canvas.FillRect(AItem.BandViewInfo.DisplayRect);
    end;
    Painter.DrawHeaderItem(AItem, True);
  finally
    AItem.FState := AState;
  end;
end;

procedure TcxTreeListDragAndDropObject.DoDrawArrows;
var
  APosChanged: Boolean;
begin
  if ScreenArrows = nil then
    ScreenArrows := TcxPlaceArrows.CreateArrows(TreeList.OptionsView.DropArrowColor, clBtnText);
  if ArrowBaseLine.Left = ArrowBaseLine.Right then
    APosChanged := ScreenArrows.MoveTo(ArrowBaseLine, bLeft)
  else
    APosChanged := ScreenArrows.MoveTo(ArrowBaseLine, bTop);
  if APosChanged and DragImage.Visible then
  begin
    SetWindowPos(ScreenArrows.Handle, DragImage.Handle, 0, 0, 0, 0,
        SWP_NOMOVE + SWP_NOSIZE + SWP_NOACTIVATE);
  end;
end;

procedure TcxTreeListDragAndDropObject.DragAndDrop(
  const P: TPoint; var Accepted: Boolean);
var
  ALine: TRect;
begin
  TreeList.Controller.IsDragDropProcess := True;
  InitDropInfo(P);
  Accepted := DragDropInfo.Accepted;
  ALine := ArrowBaseLine;
  inherited DragAndDrop(P, Accepted);
end;

procedure TcxTreeListDragAndDropObject.DropHeaderItem;
begin
  with TcxTreeListHeaderDragDropInfo(DragDropInfo) do
  begin
    if not Accepted then Exit;
    if IsDragColumn and ((DragColumn.OwnerBand = DropBand) or
      (not DropBand.IsOnlyOwnColumns and ((DragColumn.OwnerBand = nil) or
        not DragColumn.OwnerBand.IsOnlyOwnColumns))) then
      with TcxTreeListColumnHeaderViewInfo(DragItem).Column do
      begin
        TreeList.BeginUpdate;
        try
          Position.SetPositionEx(DropBand.Index, ColIndex, RowIndex, IsInsertRow);
          Visible := True;
        finally
          TreeList.EndUpdate;
        end;
      end
    else
      if IsDragBand then
      begin
        with TcxTreeListHeaderViewInfo(DragItem).BandViewInfo.Band do
        begin
          if Index < (ColIndex - 1) then
            Dec(ColIndex);
          cxRange(ColIndex, 0, TreeList.Bands.Count - 1);
          if TreeList.FixedBandCount < TreeList.VisibleBandCount then
            Index := ColIndex;
          Visible := True;
        end;
      end;
  end;
end;

procedure TcxTreeListDragAndDropObject.DropNodes;
begin
  // todo: do nothing;
end;

procedure TcxTreeListDragAndDropObject.EndDragAndDrop(Accepted: Boolean);
var
  ACanDrop: Boolean;
begin
  ACanDrop := True;
  if DragDropInfo <> nil then
    DragDropInfo.Accepted := DragDropInfo.Accepted and not TreeList.Controller.DragCancel;
  if (DragDropInfo <> nil) and not DragDropInfo.Accepted
    and IsDragColumn and not DragColumn.Visibility then RestorePosition;
  if not TreeList.Controller.DragCancel and (DragDropInfo <> nil) and
    (DragDropInfo.Accepted or CanCustomizing) then
  begin
    if not CheckCustomizingBox(DragDropInfo.DropPos) and DragDropInfo.Accepted then
    begin
      DropHeaderItem;
      ACanDrop := True;
    end
    else
      begin
        ACanDrop := False;
        if IsDragColumn then
        begin
          if DragColumn.Options.Customizing and (TreeList.VisibleColumnCount > 1) then
            DragColumn.Visible := False;
        end
        else
          if not TreeList.OptionsView.SimpleCustomizeBox then
            DragBand.Visible := False;
      end;
  end
  else
    TcxTreeListHeaderViewInfo(DragItem).Pressed := False;
  inherited EndDragAndDrop(ACanDrop);
  RestoreArrows;
  TreeList.UpdateViewStyles;
  TreeList.Modified;
  TreeList.Customizing.Modified;
end;

function TcxTreeListDragAndDropObject.GetAcceptedRect: TRect;
begin
  Result := TcxTreeListHeaderViewInfo(DragItem).GetDroppingRect;
end;

function TcxTreeListDragAndDropObject.GetArrowBaseLine(
  const ARect: TRect; ASide: TcxBorder): TRect;
begin
  with cxRectOffset(ARect, OrgOffset) do
  begin
    case ASide of
      bLeft:
        Result := cxRect(Left, Top, Left, Bottom - 1);
      bTop:
        Result := cxRect(Left, Top, Right - 1, Top);
      bRight:
        Result := cxRect(Right - 1, Top, Right - 1, Bottom - 1);
      bBottom:
        Result := cxRect(Left, Bottom - 1, Right - 1, Bottom - 1);
    end;
  end;
end;

procedure TcxTreeListDragAndDropObject.GetArrowRects(out R1, R2: TRect);
begin
  with ArrowBaseLine do
  begin
    if Top = Bottom then
    begin
      R1 := Rect(Left - 10, Top - 10, Left, Top + 10);
      R2 := Rect(Right, Top - 10, Right + 10, Top + 10);
    end
    else
      begin
        R1 := Rect(Left - 10, Top - 10, Left + 10, Top);
        R2 := Rect(Left - 10, Bottom, Left + 10, Bottom + 10);
      end
  end;
end;

function TcxTreeListDragAndDropObject.GetDragDropInfoClass: TcxTreeListDragDropInfoClass;
begin
  Result := TcxTreeListHeaderDragDropInfo
end;

procedure TcxTreeListDragAndDropObject.InitDropHeaderInfo;
begin
  HitTest.ReCalculate(DragDropInfo.DropPos);
  if IsDragBand then
    InitDropBandInfo
  else
    InitDropColumnInfo;
  with DragDropInfo do
    Accepted := Accepted or CheckCustomizingBox(DropPos);
end;

procedure TcxTreeListDragAndDropObject.InitDropInfo(const P: TPoint);
begin
  if DragDropInfo = nil then
    DragDropInfo := GetDragDropInfoClass.Create;
  DragDropInfo.DropPos := P;
  InitDropHeaderInfo;
end;

function TcxTreeListDragAndDropObject.IsDragBand: Boolean;
begin
  Result := (DragItem is TcxTreeListHeaderViewInfo) and
    not (DragItem is TcxTreeListColumnHeaderViewInfo)
end;

function TcxTreeListDragAndDropObject.IsDragColumn: Boolean;
begin
  Result := DragItem is TcxTreeListColumnHeaderViewInfo;
end;

function TcxTreeListDragAndDropObject.IsValidForDrop(AIndex, ADropIndex: Integer;
  PosIsGreater: Boolean): Boolean;
begin
  Result := (AIndex <> ADropIndex) and
    (AIndex <> (ADropIndex + cxIntOffs[PosIsGreater]))
end;

procedure TcxTreeListDragAndDropObject.Paint;
begin
  DoDrawHeaderItem(TcxTreeListHeaderViewInfo(DragItem));
end;

procedure TcxTreeListDragAndDropObject.RestoreArrows;
begin
  if ScreenArrows <> nil then
    ScreenArrows.Hide;
end;

procedure TcxTreeListDragAndDropObject.RestorePosition;
begin
  if IsDragColumn then
    DragColumn.Position.FColIndex := PrevColIndex;
end;

procedure TcxTreeListDragAndDropObject.StorePosition;
begin
  if IsDragColumn then
  begin
    PrevColIndex := DragColumn.Position.FColIndex;
    DragColumn.Position.FColIndex := -2;
  end;
end;

function TcxTreeListDragAndDropObject.CanDropHeaderObject: Boolean;
begin
  with HitTest do
    Result := HitAtBandHeader or HitAtBandContainer or HitAtColumnHeader
end;

function TcxTreeListDragAndDropObject.GetDragBand: TcxTreeListBand;
begin
  Result := TcxTreeListHeaderViewInfo(DragItem).Band;
end;

function TcxTreeListDragAndDropObject.GetDragColumn: TcxTreeListColumn;
begin
  Result := TcxTreeListColumnHeaderViewInfo(DragItem).Column;
end;

function TcxTreeListDragAndDropObject.GetDragItem: TObject;
begin
  Result := TreeList.Controller.DragItem;
end;

function TcxTreeListDragAndDropObject.GetHitTest: TcxTreeListHitTest;
begin
  Result := TreeList.HitTest;
end;

function TcxTreeListDragAndDropObject.GetPainter: TcxTreeListControlPainter;
begin
  Result := TcxTreeListControlPainter(TreeList.Painter);
end;

function TcxTreeListDragAndDropObject.GetTreeList: TcxCustomTreeListControl;
begin
  Result := TcxCustomTreeListControl(Control);
end;

procedure TcxTreeListDragAndDropObject.InitDropBandInfo;
var
  R: TRect;
  ASide: TcxBorder;
begin
  with TcxTreeListHeaderDragDropInfo(DragDropInfo) do
  begin
    Accepted := CanDropHeaderObject;
    R := cxInvalidRect;
    if Accepted then
    begin
      DropBand := HitTest.HitBand;
      with DropBand, DropBand.ViewInfo.FBandHeader do
      begin
        if (DropPos.X < 30) and (VisibleIndex = 0) then
          ASide := ASide;
        if Accepted and (DropBand.FixedKind <> tlbfNone) then
        begin
          if DropBand.FixedKind = tlbfRight then
            DropPos.X := DisplayRect.Left
          else
            DropPos.X := DisplayRect.Right
        end;
        if CheckDropPos(DragBand.VisibleIndex, VisibleIndex, DropPos.X,
          cxRectCenter(DisplayRect).X, ColIndex, ASide) then
             R := GetArrowBaseLine(ClipRect, ASide);
        if ASide = bLeft then OffsetRect(R, -1, 0);
      end;
    end
    else
      ColIndex := DragBand.VisibleIndex;
    ChangeArrowPos(R, not Accepted or (ColIndex = DragBand.VisibleIndex));
    if not Accepted then
    begin
      with TreeList do
        Accepted := PtInRect(ClientBounds, DropPos) and (VisibleBandCount = 0);
      if Accepted then
      begin
        DropBand := TreeList.Bands[0];
        ColIndex := 0;
        with TreeList do
          ChangeArrowPos(GetArrowBaseLine(CxRectSetHeight(ClientBounds,
            RealBandLineHeight), bLeft), not Accepted or (ColIndex = DragBand.VisibleIndex));
      end;
    end;
  end;
end;

procedure TcxTreeListDragAndDropObject.InitDropColumnInfo;
var
  AInfo: TcxTreeListHeaderDragDropInfo;
  ACanDrop: Boolean;
  R: TRect;
  ADisplayRect, AClipRect: TRect;

  procedure AssignPosition(AColumn: TcxTreeListColumn);
  begin
    AInfo.RowIndex := AColumn.Position.RowIndex;
    AInfo.ColIndex := AColumn.Position.ColIndex;
  end;

  procedure GetRects(AViewInfo: TcxTreeListViewInfoItem; var DisplayRect, ClipRect: TRect);
  begin
    DisplayRect := AViewInfo.DisplayRect;
    ClipRect := AViewInfo.ClipRect;
  end;

  function CheckDropAtColumn: Boolean;
  var
    ASide: TcxBorder;
    AIndex: Integer;
  begin
    with HitTest, AInfo do
    begin
      Result := HitAtColumnHeader and  ((DragColumn.OwnerBand = DropBand) or
        (not DropBand.IsOnlyOwnColumns and ((DragColumn.OwnerBand = nil) or
          not DragColumn.OwnerBand.IsOnlyOwnColumns)));
      if not Result then Exit;
      AssignPosition(HitColumn);
      GetRects(HitColumn.ViewInfo.FColumnHeader, ADisplayRect, AClipRect);
      AIndex := -2;
      if (DragColumn.OwnerBand = DropBand) and
        (DragColumn.Position.RowIndex = RowIndex) then
          AIndex := DragColumn.Position.ColIndex;
      Result := CheckDropPos(AIndex, ColIndex, DropPos.X,
        cxRectCenter(ADisplayRect).X, ColIndex, ASide);
      if Result then
        R := GetArrowBaseLine(AClipRect, ASide);
    end;
  end;

  function GetRelativePos(Y: Integer): Integer;
  begin
    Result := Y;
    if TreeList.OptionsView.Bands then
      Dec(Result, AInfo.DropBand.ViewInfo.FBandHeader.DisplayRect.Bottom);
  end;

  function CheckDropAtContainer: Boolean;
  var
    I, ARowHeight: Integer;
  begin
    with HitTest, AInfo do
    begin
      Result := HitAtBandContainer or ((TreeList.VisibleColumnCount = 0) and HitAtBand);
      Result := Result and ((DragColumn.OwnerBand = DropBand) or (not DropBand.IsOnlyOwnColumns and
          ((DragColumn.OwnerBand = nil) or not DragColumn.OwnerBand.IsOnlyOwnColumns)));
      if not Result then Exit;
      IsInsertRow := DropBand.VisibleColumnCount <> 0;
      if IsInsertRow and TreeList.OptionsView.HeaderSingleLine or (DropViewInfo = DragItem) then
      begin
        Result := False;
        Exit;
      end;
      AClipRect := DropBand.FBandViewInfo.ClipRect;
      if DropBand.FBandViewInfo.OptionsView.Bands then
        AClipRect.Top := DropBand.FBandViewInfo.FBandHeader.DisplayRect.Bottom;
      if IsInsertRow then
      begin
        for I := 0 to DropBand.BandRows.Count - 1 do
        begin
          ARowHeight := DropBand.BandRows[I].LineCount * TreeList.ViewInfo.HeaderLineHeight;
          Inc(AClipRect.Top, ARowHeight);
          RowIndex := DropBand.BandRows[I].Index + 1;
          if cxInRange(GetRelativePos(DropPos.Y), AClipRect.Top -  ARowHeight, AClipRect.Top) then
            Break;
        end;
        R := GetArrowBaseLine(AClipRect, bTop);
      end
      else
      begin
        cxRectSetHeightEx(AClipRect, DragColumn.ViewInfo.FColumnHeader.DisplayRect);
        R := GetArrowBaseLine(AClipRect, bLeft);
      end;
    end;
  end;

  function CheckEmptyContent(): Boolean;
  begin
    with TreeList do
    begin
      Result := (VisibleColumnCount = 0) and (VisibleBandCount > 0) and
        PtInRect(ClientBounds, AInfo.DropPos);
      if not Result then Exit; 
      R := cxRectSetHeight(GetArrowBaseLine(ClientBounds, bLeft), ViewInfo.HeaderLineHeight);
      AInfo.Accepted := Result;
      AInfo.DropBand := TreeList.VisibleBands[0];
      if OptionsView.Bands then
      begin
        with TreeList.VisibleBands[0].ViewInfo do
          R := cxRectSetTop(R, ClientToScreen(FBandHeader.DisplayRect.BottomRight).Y);
      end;
    end;
  end;

begin
  AInfo := TcxTreeListHeaderDragDropInfo(DragDropInfo);
  with AInfo, HitTest do
  begin
    DropBand := HitBand;
    Accepted := HitAtBandContainer or HitAtColumnHeader or CheckEmptyContent;
    IsInsertRow := False;
    AssignPosition(DragColumn);
    ACanDrop := True;
    ChangeArrowPos(R, not (Accepted and (CheckEmptyContent or
      CheckDropAtColumn or CheckDropAtContainer) and ACanDrop));
  end;
end;

{ TcxTreeListCellNavigator }

function TcxTreeListCellNavigator.GetCount(ARecordIndex: Integer): Integer;
begin
  if IsGroupRow(ARecordIndex) then
    Result := 1
  else
    Result := TreeList.VisibleColumnCount;
end;

procedure TcxTreeListCellNavigator.CalcNextRow(AForward: Boolean;
  var ARowIndex, ACellIndex: Integer);
var
  AColumn: TcxTreeListColumn;
  ANewRow: Integer;
  ACellFound: Boolean;
begin
  ACellFound := False;
  if cxInRange(ACellIndex, 0, Count[ARowIndex] - 1) and not IsGroupRow(ARowIndex) then
  begin
    AColumn := TreeList.VisibleColumns[ACellIndex];
    ACellFound := GoToNextCellInBand(AForward, AColumn, ACellIndex);
    if ACellFound then
      ACellIndex := AColumn.OwnerBand.VisibleColumns[ACellIndex].VisibleIndex;
  end
  else
    AColumn := nil;
  if not ACellFound then
  begin
    ANewRow := ARowIndex + cxIntOffs[AForward];
    if cxInRange(ANewRow, 0, TreeList.Nodes.VisibleCount - 1) then
    begin
      ARowIndex := ANewRow;
      GoToNextNodeCell(AForward, TreeList.Nodes.GetVisibleNode(ARowIndex), AColumn, ACellIndex);
    end
    else
      if AForward then AppendRecord(ARowIndex, ACellIndex);
  end
end;

procedure TcxTreeListCellNavigator.AppendRecord(
  var ARowIndex, ACellIndex: Integer);
begin
  if [dceEdit, dceChanging] * DataController.EditState <> [] then
    DataController.Post;
  if dceInsert in DataController.EditState then
  begin
   if [dceChanging, dceModified] * DataController.EditState <> [] then
      TreeList.DataController.Post
   else
     Exit;
  end;
  if TcxTreeListController(Controller).CanInsertNode then
  begin
    if TreeList.InsertNode(True) and TreeList.UseRowIndexForNewRecord then
        ARowIndex := TreeList.Nodes.VisibleCount + 1;
  end;
end;

function TcxTreeListCellNavigator.GetCellContainer(
  ARowIndex, ACellIndex: Integer): TcxCustomInplaceEditContainer;
var
  AMax: Integer;
begin
  if IsGroupRow(ARowIndex) then
    AMax := 0
  else
    AMax := TreeList.VisibleColumnCount - 1;
  if not cxInRange(ACellIndex, 0, AMax) then
    Result := nil
  else
    Result := TreeList.VisibleColumns[ACellIndex];
end;

procedure TcxTreeListCellNavigator.Init(
  var ARowIndex, ACellIndex, ARowCount: Integer);
var
  ANode: TcxTreeListNode;
begin
  ARowCount := TreeList.Nodes.VisibleCount;
  ANode := TcxTreeListController(Controller).FocusedNode;
  if ANode <> nil then
    ARowIndex := ANode.FVisibleIndex
  else
    ARowIndex := 0;
  if TreeList.FocusedColumn <> nil then
    ACellIndex := TreeList.FocusedColumn.VisibleIndex
  else
    ACellIndex := 0;
end;

function TcxTreeListCellNavigator.IsGroupRow(ARowIndex: Integer): Boolean;
var
  ANode: TcxTreeListNode;
begin
  ANode := TreeList.Nodes.GetVisibleNode(ARowIndex);
  Result := (ANode <> nil) and ANode.IsGroupNode;
end;

function TcxTreeListCellNavigator.SelectCell(AForward, ANextRow: Boolean;
  var ARowIndex, ACellIndex: Integer): TcxCustomInplaceEditContainer;
begin
  if (FocusedNode <> nil) and FocusedNode.IsGroupNode then
  begin
    if ANextRow or TreeList.OptionsBehavior.FocusCellOnCycle then
    begin
      if AForward or ANextRow or (ACellIndex < 0) then
        ACellIndex := Min(0, TreeList.VisibleColumnCount - 1)
      else
        ACellIndex := TreeList.VisibleColumnCount - 1;
      if not ANextRow then
        Inc(ARowIndex, cxIntOffs[AForward]);
    end;
  end;
  Result := inherited SelectCell(AForward, ANextRow, ARowIndex, ACellIndex);
end;

procedure TcxTreeListCellNavigator.SetFocusCell(
  ARowIndex, ACellIndex: Integer; AShift: TShiftState);
var
  ANode: TcxTreeListNode;
  AIndex: Integer;
begin
  with TreeList do
  begin
    ANode := Nodes.GetVisibleNode(ARowIndex);
    if ANode <> nil then
      AIndex := ANode.RecordIndex
    else
      AIndex := cxInvalidIndex;
    if IsGroupRow(ARowIndex) then
      Controller.SetFocusedRecordItem(AIndex, TreeList.OptionsView.GetCategorizedColumn)
    else
      Controller.SetFocusedRecordItem(AIndex, VisibleColumns[ACellIndex]);
  end;
end;

procedure TcxTreeListCellNavigator.KeyDown(var Key: Word; Shift: TShiftState);
var
  ANode: TcxTreeListNode;
begin
  TcxTreeListController(Controller).IsControllerEvent := True;
  try
    if TreeList.OptionsSelection.CellSelect and ([ssShift, ssCtrl] * Shift = []) then
      inherited KeyDown(Key, Shift)
    else
      case Key of
        VK_LEFT, VK_RIGHT:
        begin
          if TreeList.ViewInfo.HorzScrollSize <> 0 then
            TreeList.ScrollContent(TcxDirection(Byte(Key = VK_RIGHT) + 1));
          Key := 0;
        end;
        VK_UP, VK_DOWN:
        begin
          if TreeList.FocusedNode <> nil then
          begin
            ANode := TreeList.FocusedNode.GetNextVisibleEx(Key = VK_UP);
            if ANode <> nil then
              TreeList.SetFocusedNode(ANode, Shift);
          end;
          Key := 0;
        end;
      end;
  finally
    TcxTreeListController(Controller).IsControllerEvent := False;
  end;
end;

procedure TcxTreeListCellNavigator.Refresh;
begin
  inherited Refresh; 
end;

function TcxTreeListCellNavigator.GetCellIndex(
  AColumn: TcxTreeListColumn; ABandRow: TcxTreeListBandRow): Integer;
begin
  with AColumn.Position do
    Result := ABandRow[cxMin(ColIndex, ABandRow.Count - 1)].VisibleIndexAtBand;
end;

function TcxTreeListCellNavigator.GetFocusedNode: TcxTreeListNode;
begin
  Result := TreeList.FocusedNode;
end;

function TcxTreeListCellNavigator.GetTreeList: TcxCustomTreeListControl;
begin
  Result := TcxCustomTreeListControl(TcxTreeListController(Controller).EditingControl);
end;

function TcxTreeListCellNavigator.GoToNextCellInBand(AForward: Boolean;
  AColumn: TcxTreeListColumn; var ACellIndex: Integer): Boolean;
var
  ARow: Integer;
begin
  ARow := AColumn.Position.RowIndex;
  Inc(ARow, cxIntOffs[AForward]);
  Result := False;
  with AColumn.OwnerBand do
  begin
    if BandRows.Count > 1 then
    begin
      while not Result and cxInRange(ARow, 0, BandRows.Count - 1) do
      begin
        if BandRows[ARow].Count > 0 then
        begin
          ACellIndex := GetCellIndex(AColumn, BandRows[ARow]);
          Result := True;
        end
        else
          Inc(ARow, cxIntOffs[AForward]);
      end;
    end
    else
      ACellIndex := AColumn.VisibleIndex;
  end;
end;

function TcxTreeListCellNavigator.GoToNextNodeCell(AForward: Boolean;
  ANode: TcxTreeListNode; AColumn: TcxTreeListColumn; var ACellIndex: Integer): Boolean;
var
  ARow: Integer;
begin
  Result := (ANode <> nil) and (AColumn <> nil);
  if Result then
  begin
    if ANode.IsGroupNode then
      ACellIndex := 0
    else
      with AColumn.OwnerBand do
      begin
        ARow := cxSetValue(AForward, 0, BandRows.Count - 1);
        while BandRows[ARow].Count = 0 do
          Inc(ARow, cxIntOffs[AForward]);
        ACellIndex := AColumn.VisibleIndex;
        if ACellIndex = -1 then
          ACellIndex := GetCellIndex(AColumn, BandRows[ARow]);
      end;
  end;
end;

{ TcxTreeListController }

procedure TcxTreeListController.AfterPaint;
begin
  if (TreeList.DragAndDropState = ddsInProcess) and
    (TreeList.Customizing.DragAndDropObject <> nil) then
       TreeList.Customizing.DragAndDropObject.OwnerImageChanged
  else
    inherited AfterPaint;
end;

procedure TcxTreeListController.BeforePaint;
begin
  TreeList.ViewInfo.NodesViewInfo.PostUpdate;
  TreeList.ViewInfo.NodesViewInfo.PostViewInfoUpdate;
  if (TreeList.DragAndDropState = ddsInProcess) and
    (TreeList.Customizing.DragAndDropObject <> nil) then
       TreeList.Customizing.DragAndDropObject.OwnerImageChanging
  else
    inherited BeforePaint;
  if PrevTopVisibleIndex <> TreeList.TopVisibleIndex then
  begin
    PrevTopVisibleIndex := TreeList.TopVisibleIndex;
    TreeList.DoOnTopRecordIndexChanged;
  end;
end;

function TcxTreeListController.CheckAutoScrolling(
  const APoint: TPoint): Boolean;
var
  ASide: TcxBorder;
begin
  Result := False;
  for ASide := bLeft to bBottom do
    Result := Result or ScrollControllers[ASide].Check(APoint);
end;

procedure TcxTreeListController.CheckHitItemOnMouseDown(
  X, Y: Integer; Shift: TShiftState);

  function GetNeededItem: TcxCustomInplaceEditContainer;
  begin
    with TreeList.HitTest do
      if HitAtColumn then
        Result := HitColumn
      else
        Result := FocusedItem
  end;

begin
  IsControllerEvent := True;
  try
    with TreeList.HitTest do
    begin
      RecalculateOnMouseEvent(X, Y, Shift);
      if HitTestItem is TcxTreeListHeaderViewInfo and not CanSizing() and (ssLeft in Shift) then
        TcxTreeListHeaderViewInfo(HitTestItem).Pressed := not TreeList.IsDesigning
      else
        if HitAtButton and (ssLeft in Shift) then
        begin
          if TreeList.IsCancelOperation then Exit;
          RecalculateOnMouseEvent(X, Y, Shift);
          HitNode.Expanded := not HitNode.Expanded
        end
        else
          if HitAtNode and not (HitAtButton or HitAtIndent) and not CanDrag(X, Y) then
          begin
            if not IsItemEditCell then
              SetFocusedRecordItem(HitNode.RecordIndex, GetNeededItem);
          end;
    end;
  finally
    IsControllerEvent := False;
  end;
end;

function TcxTreeListController.CanHandleDeleteRecordKeys: Boolean;
begin
  Result := TreeList.OptionsData.Deleting;
end;

procedure TcxTreeListController.CheckEdit;
begin
  inherited CheckEdit;
  TreeList.RefreshNavigatorButtons;
end;

procedure TcxTreeListController.BeforeShowEdit;
begin
  TreeList.ViewInfo.NodesViewInfo.BeforeShowEdit;
end;

procedure TcxTreeListController.SetFocusedRecordIndex(Value: Integer);
begin
  if not TreeList.SkipFocusedRecordChanged then
    inherited SetFocusedRecordIndex(Value);
end;

procedure TcxTreeListController.BeforeStartDrag;
begin
  inherited BeforeStartDrag;
  DragNodesList := TreeList.GetSelectionsEx;
  if HitTest.HitAtColumn and HitTest.HitAtNode then
  begin
    DragColumn := HitTest.HitColumn;
    DragNode := HitTest.HitNode;
  end
  else
  begin
    DragColumn := nil;
    DragNode := nil;
  end;
end;

procedure TcxTreeListController.CheckButtonTimer;
var
  NeedTimer: Boolean;
begin
  if (ExpandingNode <> HitTest.HitNode) or not HitTest.HitAtButton then
    ResetButtonTimer;
  if ExpandingNode = nil then
  begin
    NeedTimer := HitTest.HitAtButton and
      (OptionsBehavior.DragExpand and not HitTest.HitNode.Expanded) or
        (OptionsBehavior.DragCollapse and HitTest.HitNode.Expanded);
    if NeedTimer then
    begin
      ExpandTimer.Interval := OptionsBehavior.WaitForExpandNodeTime;
      ExpandTimer.Enabled := True;
      ExpandTimer.OnTimer := OnExpandTimer;
      ExpandingNode := HitTest.HitNode;
    end;
  end;
end;

procedure TcxTreeListController.DragDrop(Source: TObject; X, Y: Integer);
begin
  with TreeList, HitTest do
  begin
    BeginUpdate;
    try
      if Source is TBaseDragControlObject then
        Source := TBaseDragControlObject(Source).Control;
      if (Source = TreeList) and HitAtNode then
        DropTo(HitNode, HitAtNodePreview or HitAtColumn);
    finally
      EndUpdate;
    end;
  end;
end;

procedure TcxTreeListController.DragEnter;

  function AddAutoScrollRegion(Kind: TScrollBarKind;
    const ARect: TRect; ACode: TScrollCode): TcxAutoScrollingObject;
  begin
    Result := TcxControllerAutoScrollingObject.Create(Self);
    Result.SetParams(ARect, Kind, ACode, 1);
  end;

begin
  if ExpandTimer <> nil then Exit;
  if TreeList.FDragNode = nil then
    TreeList.FDragNode := TreeList.FocusedNode;
  with TreeList.ViewInfo.NodesViewInfo do
  begin
    ScrollControllers[bTop] := AddAutoScrollRegion(sbVertical,
      cxRectSetHeight(ClipRect, cxtlScrollDelta), scLineUp);
    ScrollControllers[bBottom] := AddAutoScrollRegion(sbVertical,
      cxRectSetTop(ClipRect, ClipRect.Bottom - cxtlScrollDelta), scLineDown);
    ScrollControllers[bLeft] := AddAutoScrollRegion(sbHorizontal,
      cxRectSetWidth(ClipRect, cxtlScrollDelta), scLineUp);
    ScrollControllers[bRight] := AddAutoScrollRegion(sbHorizontal,
      cxRectSetWidth(ClipRect, ClipRect.Right - cxtlScrollDelta, cxtlScrollDelta), scLineDown);
  end;
  ExpandTimer := TTimer.Create(TreeList);
end;

procedure TcxTreeListController.DragLeave;
var
  ASide: TcxBorder;
begin
  for ASide := bLeft to bBottom do
    FreeAndNil(ScrollControllers[ASide]);
  FreeAndNil(ExpandTimer);
end;

procedure TcxTreeListController.DragMove(
  Source: TObject; const P: TPoint; var Accepted: Boolean);

  procedure ProcessDragMove;
  begin
    HitTest.Recalculate(P);
    if HitTest.HitAtButton then
      CheckButtonTimer
    else
      ExpandingNode := nil;
    CheckAutoScrolling(P);
  end;

begin
  ProcessDragMove;
  HitTest.ReCalculate(P);
  with TreeList.OptionsBehavior do
  begin
    if HitTest.HitAtNode and DragFocusing and not HitTest.HitNode.Focused then
      HitTest.HitNode.Focused := True;
  end;
end;

procedure TcxTreeListController.DragOver(
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  case State of
    dsDragEnter:
      DragEnter;
    dsDragLeave:
      DragLeave;
    dsDragMove:
      DragMove(Source, Point(X, Y), Accept);
  end;
  inherited DragOver(Source, X, Y, State, Accept);
end;

procedure TcxTreeListController.DropTo(
  ANode: TcxTreeListNode; AsChildren: Boolean);
const
  AModes: array[Boolean] of TcxTreeListNodeAttachMode = (tlamInsert, tlamAddChild);
begin
  if ANode <> nil then
  begin
    if TreeList.OptionsBehavior.DragFocusing and
      (DragNodesList.IndexOf(TreeList.DragNode) = cxInvalidIndex) then
      DragNodesList.Add(TreeList.DragNode);
    try
      TreeList.SaveDragPos;
      TreeList.DoInternalMoveTo(ANode,
        AModes[AsChildren], DragNodesList, TreeList.Controller.IsDragCopy);
    finally
      FreeAndNil(DragNodesList);
      TreeList.Controller.CancelSelection;
    end;
  end;
end;

procedure TcxTreeListController.EndDrag(Target: TObject; X, Y: Integer);
begin
  HitTestController.ReCalculate(Point(X, Y));
  if (GetAsyncKeyState(VK_SHIFT) >= 0) and not IsCtrlPressed then
    CancelSelection;
  if TreeList.OptionsBehavior.AlwaysShowEditor or TreeList.OptionsBehavior.ImmediateEditor and
    ((FocusedItem <> nil) and (FocusedNode <> nil)) then  EditingController.ShowEdit();
  FreeAndNil(DragNodesList);
end;

procedure TcxTreeListController.OnExpandTimer(Sender: TObject);
begin
  with HitTest do
  begin
    ResetButtonTimer;
    if HitAtNode and HitAtButton and (HitNode = ExpandingNode) then
      ExpandingNode.Expanded := not ExpandingNode.Expanded
    else
      ExpandingNode := nil;
  end;
end;

procedure TcxTreeListController.ResetButtonTimer;
begin
  if ExpandTimer <> nil then
    ExpandTimer.Enabled := False;
end;

procedure TcxTreeListController.DoChangeColumnSortOrder(
  AColumn: TcxTreeListColumn; ASortOrder: TcxDataSortOrder; AShift: TShiftState);
begin
  AShift := ValidateShift(AShift);
  if not TreeList.OptionsBehavior.Sorting or not AColumn.Options.Sorting then Exit;
  TreeList.DisableSorting;
  try
    TreeList.Sorted := ([ssShift, ssCtrl] * AShift <> []) and
      TreeList.OptionsBehavior.MultiSort;
    if ssCtrl in AShift then
      AColumn.SortOrder := soNone
    else
      if TreeList.OptionsBehavior.Sorting then
        AColumn.SortOrder := ASortOrder;
  finally
    TreeList.EnableSorting;
  end;
end;

procedure TcxTreeListController.DoNextNode(AForward: Boolean);
begin
  if (FocusedNode <> nil) and (FocusedNode.GetNextVisibleEx(AForward) <> nil) then
    FocusedNode := FocusedNode.GetNextVisibleEx(AForward);
end;

procedure TcxTreeListController.DoNextPage(AForward: Boolean; Shift: TShiftState);
begin
  DoShowNextPageEx(AForward, True, Shift);
  TreeList.Controller.CheckEdit;
  TreeList.Update;
end;

procedure TcxTreeListController.DoShowNextPageEx(
  AGoForward, ASetCursor: Boolean; AShift: TShiftState);

  function GetNext(ANode: TcxTreeListNode; IsNext: Boolean): TcxTreeListNode;
  begin
    Result := ANode;
    if (ANode <> nil) and (TreeList.VisibleCount = 1) then
      Result := ANode.GetNextVisibleEx(not IsNext);
  end;

begin
  with TreeList do
  begin
    if AGoForward then
    begin
      if LastVisibleNode <> nil then
        with LastVisibleNode do
          if IsLastVisible and Focused and ASetCursor then Exit;
      if ASetCursor then
      begin
        TopVisibleNode := GetNext(FocusedNode, True);
        SetFocusedNode(LastVisibleNode, AShift)
      end
      else
        TopVisibleNode := GetNext(LastVisibleNode, True);
    end
    else
    begin
      if TopVisibleNode <> nil then
        with TopVisibleNode do
          if IsFirstVisible and Focused and ASetCursor then Exit;
      if ASetCursor then
      begin
        LastVisibleNode := GetNext(FocusedNode, False);
        SetFocusedNode(TopVisibleNode, AShift)
      end
      else
        LastVisibleNode := GetNext(TopVisibleNode, False);
    end;
  end;
end;

procedure TcxTreeListController.FocusedRecordChanged(
  APrevFocusedRecordIndex, AFocusedRecordIndex: Integer);
var
  APrevFocusedNode, AFocusedNode: TcxTreeListNode;
begin
  if not IsInIncSearchChanging and IsIncSearching then
    CancelIncSearching;
  TreeList.DoFocusedRecordChanged(APrevFocusedRecordIndex, AFocusedRecordIndex);
  if TreeList.FNeedFocusedRecordUpdatePost then Exit;
  with TcxTreeListCellNavigator(Navigator) do
  begin
    Refresh;
    AFocusedNode := GetNode(AFocusedRecordIndex);
    if (AFocusedNode <> nil) and not IsDragMode then
      AFocusedNode.MakeVisible;
    APrevFocusedNode := GetNode(APrevFocusedRecordIndex);
    with TreeList do
    begin
      if DoIsGroupNode(AFocusedNode) and (VisibleColumnCount > 0) then
        FocusedColumn := OptionsView.GetCategorizedColumn;
    end;
    TreeList.ViewInfo.NodesViewInfo.FocusedRecordChanged(APrevFocusedNode, AFocusedNode);
  end;
  if(TreeList.DragAndDropState = ddsNone) and not IsControllerEvent or
    (CurrentShiftState * [ssCtrl, ssShift, ssLeft, ssRight] = []) then
  begin
    if not TreeList.IsSelectionLocked then
      CancelSelection
  end
  else
    if (SelectionAnchorNode = nil) and (APrevFocusedNode <> nil) then
      SelectionAnchorNode := APrevFocusedNode;
  inherited FocusedRecordChanged(APrevFocusedRecordIndex, AFocusedRecordIndex);
  AFocusedNode := GetNode(AFocusedRecordIndex);
  if AFocusedNode <> nil then AFocusedNode.Repaint(False);
end;

procedure TcxTreeListController.FocusedItemChanged(
  APrevFocusedItem: TcxCustomInplaceEditContainer);
begin
  inherited FocusedItemChanged(APrevFocusedItem);
  UpdateRecord(DataController.FocusedRecordIndex);
  TreeList.DoFocusedItemChanged(APrevFocusedItem, FocusedItem);
end;

function TcxTreeListController.IsDragMode: Boolean;
begin
  with TreeList do
    Result := DragAndDropState = ddsInProcess;
end;

function TcxTreeListController.IsKeyForController(
  AKey: Word; AShift: TShiftState): Boolean;
begin
  Result := (AKey = VK_ADD) or (AKey = VK_SUBTRACT) or (AKey = VK_MULTIPLY) or
    (AKey = VK_HOME) or (AKey = VK_END);
  Result := inherited IsKeyForController(AKey, AShift) or
    ((IsEditing and (ssCtrl in AShift) and Result) or (not IsEditing and Result));
end;

function TcxTreeListController.IsNodeKeyHandle(ANode: TcxTreeListNode;
  var AKey: Word; Shift: TShiftState): Boolean;
var
  ATop: Integer; 
begin
  Result := True;
  case AKey of
    VK_SUBTRACT, VK_ADD:
      if (IncSearchText = '') and (ANode <> nil) and ANode.HasChildren then
        ANode.Expanded := AKey = VK_ADD
      else
        Result := False; 
    VK_MULTIPLY:
      if (ANode <> nil) and ANode.HasChildren then
        ANode.Expand(AKey = VK_MULTIPLY);
    VK_HOME:
      with TreeList do
      begin
        if ssCtrl in Shift then
        begin
          TreeList.TopVisibleIndex := 0;
          TreeList.FocusedNode := TreeList.TopVisibleNode;
        end
        else
          if VisibleColumnCount > 0 then
            VisibleColumns[0].Focused := True;
      end;
    VK_END:
      with TreeList do
      begin
        if ssCtrl in Shift then
        begin
          TopVisibleIndex := Nodes.VisibleCount - 1;
          FocusedNode := LastVisibleNode;
        end
        else
          if VisibleColumnCount > 0 then
            VisibleColumns[VisibleColumnCount - 1].Focused := True;
      end;
    VK_DELETE:
      begin
        Result := CanHandleDeleteRecordKeys and (ssCtrl in Shift) and CanDeleteSelection and DeleteConfirmation;
        ATop := TreeList.TopVisibleIndex;
        if Result then
        try
          TreeList.DoDeleteSelection;
          TreeList.DataController.Post;
        finally
          TreeList.TopVisibleIndex := ATop;
          if TreeList.FocusedNode <> nil then
            TreeList.FocusedNode.MakeVisible;
        end;
      end;
    VK_INSERT:
      begin
        if (FocusedNode = nil) or (not CanInsertNode) then
          Result := False
       else
          TreeList.InsertNode(ssCtrl in Shift);
      end;
  else
    Result := False
  end;
end;

function TcxTreeListController.CanDrag(X, Y: Integer): Boolean;
begin
  with TreeList.HitTest do
  begin
    HitPoint := Point(X, Y);
    Result := not CanSizing and not TreeList.IsDesigning and not IsEditing and
      (HitAtNode and HitNode.Selected and not HitAtIndent);
    if Result then
      TreeList.FDragNode := HitNode;
  end;
end;

procedure TcxTreeListController.BeforeMouseDown(
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

  function GetNeededItem: TcxCustomInplaceEditContainer;
  begin
    with TreeList.HitTest do
      if HitAtColumn then
        Result := HitColumn
      else
        Result := FocusedItem
  end;
  
begin
  IsControllerEvent := True;
  try
    CurrentShiftState := Shift;
    HitTest.RecalculateOnMouseEvent(X, Y, Shift);
    if not Focused and (FocusedRecordIndex = cxInvalidIndex) then
    begin
     if HitTest.HitAtNode then
       ForceFocusedRecord := HitTest.HitNode.RecordIndex;
     if not HitTest.HitAtButton then
       CheckHitItemOnMouseDown(X, Y, Shift);
     if (FocusedRecordIndex <> cxInvalidIndex) and (TreeList.VisibleColumnCount > 0) then
       TreeList.VisibleColumns[0].Focused := True;
    end;
    if Focused and OptionsBehavior.ImmediateEditor and HitTest.HitAtNode and
      not HitTest.HitAtIndent and not TreeList.IsDesigning then
      begin
        SetFocusedRecordItem(HitTest.HitNode.RecordIndex, GetNeededItem);
        BlockFocusChanged := True;
      end;
  finally
    IsControllerEvent := False;
  end;
  inherited;
end;

procedure TcxTreeListController.BeginDragAndDrop;
begin
  inherited BeginDragAndDrop;
  TreeList.Update;
end;

procedure TcxTreeListController.DoMouseDown(
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (TreeList.DragAndDropState <> ddsNone) and HitTest.CanSizing then
  begin
    EditingController.HideEdit(True);
    Exit;
  end;
  IsControllerEvent := True;
  try
    inherited DoMouseDown(Button, Shift, X, Y);
    BlockFocusChanged := False;
    if CanDrag(X, Y) and HitTest.HitAtNode and IsEditing then
      TreeList.DragAndDropState := ddsNone;
    HitTest.ReCalculate(Point(X, Y));
    if HitAtNodeEx then
    begin
      if ([ssCtrl, ssShift] * Shift <> []) then
        Select(HitTest.HitNode, Shift)
      else
        if (FocusedNode = nil) or not FocusedNode.Selected then
          CancelSelection;
    end;

    if TreeList.IsDesigning and (HitTest.HitTestItem is TcxTreeListHeaderViewInfo) and
      not HitTest.CanSizing() and (ssLeft in Shift) then
    begin
      if HitTest.HitAtColumn then
        SelectObject(HitTest.HitColumn, Shift)
      else
        SelectObject(HitTest.HitBand, Shift);
    end;
    if CanDrag(X, Y) and HitTest.HitAtNode and (HitTest.HitAtImages or
      HitTest.HitAtIndicator or (HitTest.HitAtColumn and
      not GetImmediateEditor) or HitTest.HitAtBandContainer) then;
  finally
    ShowEditOnMouseUp := TreeList.OptionsBehavior.ImmediateEditor and HitTest.IsItemEditCell;
    IsControllerEvent := False;
  end;
end;

procedure TcxTreeListController.ControlFocusChanged;
var
  AColumn: TcxTreeListColumn;
  ARecordIndex: Integer;
begin
  inherited ControlFocusChanged;
  if ForceFocusedRecord >= 0 then Exit;
  ARecordIndex := 0;
  AColumn := TreeList.FocusedColumn;
  with DataController, TreeList do
    if (RecordCount > 0) and (FocusedRecordIndex = cxInvalidIndex) and
      (VisibleColumnCount > 0) then
  begin
    if AColumn = nil then
      AColumn := VisibleColumns[0];
    if SelectionCount > 0 then
      ARecordIndex := Selections[0].RecordIndex;
    SetFocusedRecordItem(ARecordIndex, AColumn);
  end;
end;

function TcxTreeListController.CanDeleteSelection: Boolean;
begin
  Result := TreeList.OptionsData.Deleting and not TreeList.IsEditing;
end;

function TcxTreeListController.CanInsertNode: Boolean;
begin
  Result := TreeList.OptionsData.Inserting;
  if not Result then Exit;
  Result := False;
  if [dceEdit, dceChanging] * DataController.EditState <> [] then
    DataController.Post;
  if dceInsert in DataController.EditState then
  begin
   if [dceChanging, dceModified] * DataController.EditState <> [] then
      TreeList.DataController.Post
   else
     Exit;
  end;
  Result := ([dceInsert, dceEdit] * DataController.EditState = []);
end;

procedure TcxTreeListController.DblClick;
var
  ADir: TcxDragSizingDirection;
begin
  if IsEditing and (FocusedNode <> nil) and FocusedNode.HasChildren then
    EditingController.HideEdit(True);
  if TreeList.IsCancelOperation then Exit;
  EditingController.StopEditShowingTimer;
  inherited DblClick;
  TreeList.ViewInfo.IsDirty := True;
  with HitTest do
  begin
    HitTest.Recalculate;
    if HitAtNode and not HitAtButton and not IsEditing and OptionsBehavior.ExpandOnDblClick then
      HitNode.Expanded := not HitNode.Expanded;
    if (HitAtBandHeader or HitAtColumnHeader) and CanSizing(ADir) and (ADir = dsdHorz) then
    begin
      if HitAtBandHeader then
        HitBand.ApplyBestFit
      else
        HitColumn.ApplyBestFit;
    end;
  end;
end;

procedure TcxTreeListController.EndDragAndDrop(Accepted: Boolean);
begin
  inherited EndDragAndDrop(Accepted);
end;

function TcxTreeListController.DeleteConfirmation: Boolean;
begin
  if TreeList.OptionsBehavior.ConfirmDelete then
    Result := cxConfirmMessageBox(
      scxStr(@scxTreeListDeletingFocusedConfirmationText),
        scxStr(@scxTreeListDeletingConfirmationCaption))
  else
    Result := True;
end;

procedure TcxTreeListController.DoMouseUp(
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if [ssShift, ssCtrl] * Shift <> [] then
   with TreeList do
   begin
     if OptionsSelection.MultiSelect and not GetImmediateEditor then
       EditingController.StopEditShowingTimer;
   end;
   if ShowEditOnMouseUp and HitTest.IsItemEditCell then
   begin
     if not TreeList.IsEditing then
       EditingController.ShowEdit();
     ShowEditOnMouseUp := False;
   end;
end;

function TcxTreeListController.GetCursor(X, Y: Integer): TCursor;
begin
  if not TreeList.IsDesigning then
  begin
    if Int64(Point(X, Y)) <> Int64(HitTestController.HitPoint) then
      TcxTreeListHitTest(HitTestController).RecalculateOnMouseEvent(X, Y, []);
    Result := TcxTreeListHitTest(HitTestController).CurrentCursor;
    if Result = crDefault then
      Result := inherited GetCursor(X, Y);
  end
  else
    Result := inherited GetCursor(X, Y);
end;

function TcxTreeListController.GetDragAndDropObjectClass: TcxDragAndDropObjectClass;
begin
  DragItem := HitTest.HitTestItem;
  if HitTest.CanSizing(ResizeDirection) then
  begin
    Result := TcxSizingDragAndDropObject;
    if HitTest.HitAtNode then
      DragItem := HitTest.SizingHitNode; 
  end
  else
    if HitTest.CanMoving then
      Result := TcxTreeListDragAndDropObject
    else
      if HitTest.HitAtNode then
        Result := nil
      else
      begin
        DragItem := nil;
        Result := inherited GetDragAndDropObjectClass;
      end
end;

function TcxTreeListController.GetImmediateEditor: Boolean;
begin
  Result := inherited GetImmediateEditor;
  if Result and TreeList.OptionsSelection.MultiSelect then
    Result := [ssShift, ssCtrl] * CurrentShiftState = [];
end;

function TcxTreeListController.HitAtNodeEx: Boolean;
begin
  with HitTest do
  begin
    Result := TreeList.IsMultiSelect and HitAtNode and
      not (HitAtButton or (HitAtIndent and not HitAtImage));
  end;
end;

function TcxTreeListController.IsDragCopy: Boolean;
begin
  Result := IsCtrlPressed and
    TreeList.OptionsBehavior.AutoDragCopy;
end;

function TcxTreeListController.IsDestroying: Boolean;
begin
  Result := TreeList.IsDestroying;
end;

procedure TcxTreeListController.KeyDown(var Key: Word;
  Shift: TShiftState);

  procedure RevertExpanding;
  begin
    FocusedNode.Expanded := not FocusedNode.Expanded;
    Key := 0;
  end;

var
  AKey: Word;
  APrevNode: TcxTreeListNode;

begin
  IsControllerEvent := True;
  CurrentShiftState := Shift;
  try
    AKey := Key;
    EatKeyPress := IsNodeKeyHandle(FocusedNode, Key, Shift);
    if (AKey = VK_SPACE) and (FocusedNode <> nil) and
      TreeList.IsMultiSelect and ([ssCtrl, ssShift] * Shift <> []) then
    begin
      if (ssCtrl in Shift) then
      begin
        FocusedNode.Selected := not FocusedNode.Selected;
        if FocusedNode.Selected then
          SelectionAnchorNode := FocusedNode;
      end
      else
        Select(FocusedNode, CurrentShiftState);
      Key := 0;
    end;
    if (TreeList.VisibleColumnCount = 1) and (FocusedNode <> nil) and (FocusedNode.HasChildren) then
    begin
      if ((Key = VK_LEFT) and FocusedNode.Expanded) or
        ((Key = VK_RIGHT) and not FocusedNode.Expanded) then RevertExpanding;
    end;
    inherited KeyDown(Key, Shift);
    case AKey of
      VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT, VK_NEXT, VK_PRIOR, VK_HOME, VK_END:
      begin
        if Key in [VK_NEXT, VK_PRIOR, VK_HOME, VK_END] then
        begin
          APrevNode := SelectionAnchorNode;
          Selection.Clear;
          if (SelectionAnchorNode <> nil) then
            Selection.Add(SelectionAnchorNode);
          Select(FocusedNode, CurrentShiftState);
          SelectionAnchorNode := APrevNode;
        end
        else
          Select(FocusedNode, CurrentShiftState);
      end;
      VK_MENU, VK_SHIFT, VK_CONTROL:
        SetHotTrackNode(HotTrackNode, CurrentShiftState);
    end;
  finally
    IsControllerEvent := False;
  end;
end;

procedure TcxTreeListController.KeyUp(var Key: Word; Shift: TShiftState);
begin
  IsControllerEvent := True;
  try
    CurrentShiftState := Shift;
    inherited KeyUp(Key, Shift);
    case Key of
      VK_MENU, VK_SHIFT, VK_CONTROL:
        SetHotTrackNode(HotTrackNode, CurrentShiftState);
    end;
  finally
    IsControllerEvent := False;
  end;
end;

procedure TcxTreeListController.MakeFocusedItemVisible;
var
  AColumn: TcxTreeListColumn;
begin
  AColumn := TcxTreeListColumn(FocusedItem);
  if AColumn <> nil then
  begin
    AColumn.MakeVisible;
    MakeFocusedRecordVisible;
  end;
end;

procedure TcxTreeListController.MakeFocusedRecordVisible;
begin
  TreeList.MakeNodeVisible(FocusedNode);
end;

procedure TcxTreeListController.MouseDown(
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  CurrentShiftState := Shift;
  inherited MouseDown(Button, Shift, X, Y);
  CheckHitItemOnMouseDown(X, Y, Shift);
  SetHotTrackNode(nil, []);
end;

procedure TcxTreeListController.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  IsControllerEvent := True;
  try
    CurrentShiftState := Shift;
    inherited MouseMove(Shift, X, Y);
    UpdateHotTrackNode(X, Y, Shift);
  finally
    IsControllerEvent := False;
  end;
end;

procedure TcxTreeListController.MouseUp(
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IsControllerEvent := True;
  try
    inherited MouseUp(Button, Shift, X, Y);
    with TreeList do
    begin
      if HitAtNodeEx and (SelectionCount > 1) and ([ssShift, ssCtrl] * Shift = []) and
         (Button = mbLeft) then CancelSelection;
    end; 
    CurrentShiftState := Shift;
    with TreeList.HitTest do
      if FPressedHeader <> nil then FPressedHeader.Pressed := False;
    IsDragDropProcess := False;
  finally
    IsControllerEvent := False;
  end;
end;

procedure TcxTreeListController.Scroll(AScrollBarKind: TScrollBarKind;
  AScrollCode: TScrollCode; var AScrollPos: Integer);
var
  AScrolled: Boolean;

  function CheckPos(APos, APage, AInc, AMax : Integer): Boolean;
  begin
    case AScrollCode of
      scLineUp:
        AScrollPos := APos - AInc;
      scLineDown:
        AScrollPos := APos + AInc;
      scPageUp:
        AScrollPos := APos - APage;
      scPageDown:
        AScrollPos := APos + APage;
      scTop:
        AScrollPos := 0;
      scBottom:
        AScrollPos := AMax;
      scTrack:
        AScrollCode := scPosition;
    end;
    if AScrollPos < 0 then
      AScrollPos := 0
    else
      if AScrollPos + APage > AMax then AScrollPos := AMax - APage;
    if AScrollCode = scPosition then cxRange(AScrollPos, 0, AMax);
    Result := AScrollPos <> APos;
    AScrolled := AScrolled or Result;
  end;

begin
  if TreeList.IsLocked or (AScrollCode = scEndScroll) then Exit;
  with TreeList.ViewInfo do
  begin
    AScrolled := False;
    if (AScrollBarKind = sbHorizontal) and CheckPos(HorzScrollPos,
      Max(1, HorzScrollPage - TreeList.GetFixedContentSize), HorzScrollInc, HorzScrollSize - TreeList.GetFixedContentSize) then
    begin
      TreeList.HScrollBar.Position := AScrollPos;
      DoScrollHorizontal(AScrollPos);
    end
    else
      if AScrollBarKind = sbVertical then
      begin
        begin
          if (AScrollCode in [scPageUp, scPageDown]) then
            TreeList.Controller.DoShowNextPageEx(AScrollCode = scPageDown, False, [])
          else
            with TreeList.Nodes do
            begin
              if CheckPos(TopIndex, NodesViewInfo.VisibleCount, 1, VisibleCount) then
                 DoScrollVertical(AScrollPos - TopIndex);
            end;
        end;
        AScrollPos := TreeList.Nodes.TopIndex;
      end;
  end;
  inherited Scroll(AScrollBarKind, AScrollCode, AScrollPos);
  UpdateHotTrackNode([]);
  TreeList.DoChanged;
  if AScrolled then
    TreeList.Update;
end;

procedure TcxTreeListController.SetFocusedRecordItem(ARecordIndex: Integer;
  AItem: TcxCustomInplaceEditContainer);
begin
  if BlockFocusChanged then Exit; 
  if not TreeList.Dragging and not (ssDouble in CurrentShiftState) then
    inherited SetFocusedRecordItem(ARecordIndex, AItem);
  HitTestController.ReCalculate;
end;

procedure TcxTreeListController.SetHotTrackCursor(ACursor: TCursor);
begin
  TreeList.Cursor := ACursor;
end;

procedure TcxTreeListController.SetHotTrackNode(
  ANode: TcxTreeListNode; AShift: TShiftState);
var
  APrevNode: TcxTreeListNode;
  ACursor: TCursor; 
begin
  if IsDestroying then Exit;
  if not Focused or not TreeList.OptionsBehavior.HotTrack then ANode := nil;
  if ((ANode = HotTrackNode) and (AShift = PrevHotShift)) or
    TreeList.IsDesigning or TreeList.IsDestroying then Exit;
  APrevNode := HotTrackNode;
  HotTrackNode := ANode;
  PrevHotShift := AShift; 
  if TreeList.OptionsBehavior.HotTrack then
  begin
    if APrevNode <> nil then
      APrevNode.Repaint(True)
    else
    begin
      if TreeList.FUseGlassCursor > 0 then
        PrevCursor := TreeList.FStoredCursor
      else
        PrevCursor := TreeList.Cursor;
    end;
    if ANode <> nil then
    begin
      ANode.Repaint(True);
      TreeList.DoOnHotTrackNode(ANode, AShift, ACursor);
      SetHotTrackCursor(ACursor);
    end
    else
      SetHotTrackCursor(PrevCursor);
  end;
end;

function TcxTreeListController.StartDragAndDrop(const P: TPoint): Boolean;
begin
  with TreeList.HitTest do
  begin
    HitPoint := P;
    Result := CanSizing or CanMoving and not (HitAtNode and HitNode.Selected and not HitAtIndent);
  end;
end;

procedure TcxTreeListController.UpdateHotTrackNode(AShift: TShiftState);
begin
  with HitTest.HitPoint do
    UpdateHotTrackNode(X, Y, AShift);
end;

procedure TcxTreeListController.UpdateHotTrackNode(X, Y: Integer; AShift: TShiftState);
begin
  HitTest.RecalculateOnMouseEvent(X, Y, AShift);
  if HitTest.HitAtNode then
    SetHottrackNode(HitTest.HitNode, AShift)
  else
    SetHottrackNode(nil, AShift);
end;

function TcxTreeListController.GetCellFromViewInfo(AColumn: TcxTreeListColumn;
  ANodeViewInfo: TcxTreeListNodeViewInfo): TcxTreeListEditCellViewInfo;

  function IsExtraCell(Condition: Boolean; ACheckedInfo: TcxTreeListEditCellViewInfo;
    var AInfo: TcxTreeListEditCellViewInfo): Boolean;
  begin
    Result := Condition and (ACheckedInfo.Column = AColumn);
    if Result then AInfo := ACheckedInfo;
  end;

begin
  with ANodeViewInfo, AColumn do
  begin
    Result := nil;
    if Visibility and not IsExtraCell(HasPreview, Preview, Result) and
      not IsExtraCell(IsGroupNode, NodeGroupEditViewInfo, Result) then
    begin
       if VisibleIndexAtBand < Groups[Position.OwnerBandVisibleIndex].CellCount then
         Result := Groups[Position.OwnerBandVisibleIndex].Cells[VisibleIndexAtBand]
       else
         Result := nil;
    end;
  end;
end;

function TcxTreeListController.GetCellFromViewInfoEx(
  AColumn: TcxTreeListColumn; ANode: TcxTreeListNode): TcxTreeListEditCellViewInfo;
var
  AViewInfo: TcxTreeListNodeViewInfo;
begin
  if (AColumn <> nil) and (ANode <> nil) and
    TreeList.ViewInfo.NodesViewInfo.FindNodeViewInfo(ANode, AViewInfo) then
    Result := GetCellFromViewInfo(AColumn, AViewInfo)
  else
    Result := nil
end;

function TcxTreeListController.GetFocusedCellViewInfo(
  AEditContainer: TcxCustomInplaceEditContainer): TcxEditCellViewInfo;
begin
  Result := nil;
  if (AEditContainer = nil) or TreeList.ViewInfo.IsDirty then Exit;
  with TcxTreeListColumn(AEditContainer) do
    if not Visibility or IsPreview then Exit;
  Result := GetCellFromViewInfoEx(TcxTreeListColumn(AEditContainer), FocusedNode);
end;

function TcxTreeListController.GetNavigatorClass: TcxCustomCellNavigatorClass;
begin
  Result := TcxTreeListCellNavigator;
end;

function TcxTreeListController.GetNode(ARecordIndex: Integer): TcxTreeListNode;
begin
  if (ARecordIndex >= 0) and (ARecordIndex < TreeList.NodesList.Count) then
    Result := TcxTreeListNode(TreeList.NodesList[ARecordIndex])
  else
    Result := nil;
end;

procedure TcxTreeListController.CancelIncSearching;
begin
  if IsDestroying then Exit;
  IncSearchText := '';
  inherited CancelIncSearching;
  UpdateNodeIncSearchingCell(IncSearchNode);
  IncSearchNode := nil;
end;

function TcxTreeListController.DoSearch(AFromNode: TcxTreeListNode;
  AItemIndex: Integer; const AText: string; AGoForward: Boolean): Boolean;

  function DoSearchNode(AForward: Boolean; var ANode: TcxTreeListNode): Boolean;
  begin
    ANode := AFromNode;
    Result := False;
    while ANode <> nil do
    begin
      if DataCompareText(ANode.Texts[AItemIndex], AText, True) then
      begin
        Result := True;
        Break;
      end;
      ANode := GetNextIncSearchNode(ANode, AForward);
    end;
  end;

var
  ANode: TcxTreeListNode;
  APrevFocusedNode: TcxTreeListNode;
begin
  Result := DoSearchNode(AGoForward, ANode);
  if not Result then
    Result := DoSearchNode(not AGoForward, ANode);
  APrevFocusedNode := TreeList.FocusedNode;
  IsInIncSearchChanging := True;
  if Result then
  begin
    try
      if (ANode <> nil) then
      begin
        ANode.MakeVisible;
        if ANode.IsVisible then
          TreeList.FocusedNode := ANode
        else
          AFromNode.MakeVisible;
      end;
    finally
      IsInIncSearchChanging := False;
    end;
    IncSearchNode := TreeList.FocusedNode;
    UpdateNodeIncSearchingCell(TreeList.FocusedNode);
    if APrevFocusedNode <> TreeList.FocusedNode then
      UpdateNodeIncSearchingCell(APrevFocusedNode);
  end;
end;

function TcxTreeListController.GetIncSearchingItem: TcxCustomInplaceEditContainer;
begin
  Result := TreeList.OptionsBehavior.IncSearchItem;
  if Result = nil then
    Result := TreeList.FocusedColumn;
end;

function TcxTreeListController.GetIncSearchingText: string;
begin
  Result := IncSearchText;
end;

function TcxTreeListController.GetIsIncSearching: Boolean;
begin
  Result := IncSearchText <> '';
end;

function TcxTreeListController.GetNextIncSearchNode(
  ANode: TcxTreeListNode; AGoForward: Boolean): TcxTreeListNode;
begin
  if ANode = nil then
    Result := nil
  else
    if TreeList.OptionsBehavior.ExpandOnIncSearch then
    begin
      if AGoForward then
        Result := ANode.GetNext
      else
        Result := ANode.GetPrev
    end
    else
      Result := ANode.GetNextVisibleEx(not AGoForward);
end;

procedure TcxTreeListController.SearchCheck(AItemFound: Boolean);
begin
  if not AItemFound and (IncSearchNode = nil) then
    CancelIncSearching
  else
    if not AItemFound then
      IncSearchingText := Copy(IncSearchingText, 1, Length(IncSearchingText) - 1);
end;

procedure TcxTreeListController.SearchLocate(
  AItem: TcxCustomInplaceEditContainer; const Value: string);
var
  ANode: TcxTreeListNode;
begin
  if TreeList.FocusedNode <> nil then
    ANode := TreeList.FocusedNode
  else
    ANode := TreeList.Nodes.Root.FFirst;
  IncSearchText := Value;
  if (AItem <> nil) and (ANode <> nil) then
    SearchCheck(DoSearch(ANode, AItem.ItemIndex, IncSearchText, True));
end;

procedure TcxTreeListController.SearchLocateNext(
  AItem: TcxCustomInplaceEditContainer; AForward: Boolean);
var
  ANode: TcxTreeListNode;
begin
  if (AItem <> nil) and (TreeList.FocusedNode <> nil) then
  begin
    ANode := GetNextIncSearchNode(TreeList.FocusedNode, AForward);
    if ANode = nil then
      ANode := TreeList.FocusedNode;
    SearchCheck(DoSearch(ANode, AItem.ItemIndex, IncSearchText, AForward));
  end;
end;

procedure TcxTreeListController.UpdateNodeIncSearchingCell(
  ANode: TcxTreeListNode);
var
  ANodeViewInfo: TcxTreeListNodeViewInfo;
  ACellViewInfo: TcxTreeListEditCellViewInfo;
begin
  if ANode <> nil then
  begin
    if TreeList.ViewInfo.NodesViewInfo.FindNodeViewInfo(ANode, ANodeViewInfo) then
    begin
      ACellViewInfo := GetCellFromViewInfo(TcxTreeListColumn(ItemForIncSearching), ANodeViewInfo);
      if ACellViewInfo <> nil then ACellViewInfo.Invalidate(True);
    end;
  end;
end;

procedure TcxTreeListController.SelectionTimerHandler(ASender: TObject);
begin
//  for I := 0 to 
end;

function TcxTreeListController.CanCreateSelectionHelper: Boolean;
begin
  Result := TreeList.IsDesigning and not TreeList.IsDestroying and not TreeList.IsLoading and
    (cxDesignSelectionHelperClass <> nil) and TreeList.HandleAllocated;
end;

function TcxTreeListController.IsObjectSelected(AObject: TPersistent): Boolean;
var
  AHelper: TcxCustomDesignSelectionHelper;
begin
  Result := False;
  if not CanCreateSelectionHelper then Exit;
  AHelper := cxDesignSelectionHelperClass.Create(TreeList);
  try
    Result := AHelper.IsObjectSelected(AObject);
  finally
    AHelper.Free;
  end;
end;

procedure TcxTreeListController.SelectObject(
  AObject: TPersistent; AShift: TShiftState);
var
  AHelper: TcxCustomDesignSelectionHelper;
begin
  if not CanCreateSelectionHelper then Exit;
  AHelper := cxDesignSelectionHelperClass.Create(TreeList);
  try
    AHelper.Select(AObject, AShift);
  finally
    AHelper.Free;
  end;
end;

procedure TcxTreeListController.UnselectObject(AObject: TPersistent);
var
  AHelper: TcxCustomDesignSelectionHelper;
begin
  if not CanCreateSelectionHelper then Exit;
  AHelper := cxDesignSelectionHelperClass.Create(TreeList);
  try
    AHelper.UnselectObject(AObject);
  finally
    AHelper.Free;
  end;
end;

procedure TcxTreeListController.CancelSelection(KeepPrimary: Boolean = True);
begin
  if TreeList.IsMultiSelect then
  begin
    TreeList.BeginUpdateSelection;
    try
      SelectionAnchorNode := nil;
      Selection.Clear;
      if (FocusedNode <> nil) and KeepPrimary and
        (FocusedNode.RecordIndex < DataController.RecordCount) then
        FocusedNode.Selected := True
    finally
      TreeList.EndUpdateSelection;
    end;
  end;
end;

procedure TcxTreeListController.Select(ANode: TcxTreeListNode; Shift: TShiftState);

   procedure ValidateSelectionList(AIndex1, AIndex2: Integer);
   var
     I: Integer;
   begin
     if AIndex1 > AIndex2 then
       ValidateSelectionList(AIndex2, AIndex1)
     else
     begin
       I := 0;
       while I < Selection.Count do
       begin
         if cxInRange(TcxTreeListNode(Selection.List^[I]).VisibleIndex, AIndex1, AIndex2) then
           Inc(I)
         else
           Selection.Delete(I);
       end;
     end;
   end;

   procedure SelectRange(AToNode: TcxTreeListNode; IsAdd: Boolean);
   var
     AGoToForward: Boolean;
     AIndex1, AIndex2: Integer;
     AFromNode: TcxTreeListNode;
   begin
     AFromNode := SelectionAnchor;
     AIndex1 :=  AToNode.VisibleIndex;
     AIndex2 := AFromNode.VisibleIndex;
     if not IsAdd then
       ValidateSelectionList(AIndex1, AIndex2);
     AGoToForward := AIndex1 < AIndex2;
     TreeList.BeginUpdateSelection;
     try
       AFromNode.Selected := True;
       while AFromNode <> AToNode do
       begin
         AFromNode := AFromNode.GetNextVisibleEx(AGoToForward);
         AFromNode.Selected := True;
       end;
     finally
       TreeList.EndUpdateSelection;
     end;
   end;

var
  AShift: TShiftState;
begin
  if not TreeList.IsMultiSelect then Exit;
  if ANode = nil then
  begin
    TreeList.FocusedNode := nil;
    Exit;
  end;
  if ANode.Selected and not (ssCtrl in Shift) and ((ANode = TreeList.TopVisibleNode) or
    (ANode = TreeList.LastVisibleNode) or (TreeList.SelectionCount = 1)) then Exit;
  if not ANode.IsVisible then Exit;
  TreeList.BeginUpdateSelection;
  try
    AShift := [ssShift, ssCtrl] * Shift;
    if AShift = [] then
      CancelSelection
    else
    begin
      if ssShift in AShift then
        SelectRange(ANode,  ssCtrl in Shift)
      else
        if (AShift = [ssCtrl]) and (ssLeft in Shift) then
          ANode.Selected := not ANode.Selected;
      if (ssCtrl in Shift) and ANode.Selected then
        SelectionAnchorNode := ANode;
    end;
  finally
    TreeList.EndUpdateSelection;
  end;
end;

function TcxTreeListController.GetResizeDirection: TcxDragSizingDirection;
begin
  Result := ResizeDirection;
end;

procedure TcxTreeListController.MouseLeave;
var
  I: Integer;
begin
  inherited MouseLeave;
  SetHotTrackNode(nil, []);
  for I := 0 to TreeList.VisibleColumnCount - 1 do
    TreeList.VisibleColumns[I].ViewInfo.ColumnHeader.UpdateState;
end;

procedure TcxTreeListController.DoCancelMode;
begin
  inherited DoCancelMode;
  if HitTest.FPressedHeader <> nil then
    HitTest.FPressedHeader.Pressed := False;
  SetHotTrackNode(nil, []);
end;

function TcxTreeListController.ValidateShift(Shift: TShiftState): TShiftState;
begin
  if IsControllerEvent then
    Result := CurrentShiftState
  else
    Result := Shift;
end;

procedure TcxTreeListController.UpdateRecord(ARecordIndex: Integer);
var
  ANode: TcxTreeListNode;
  AViewInfo: TcxTreeListNodeViewInfo;
begin
  ANode := GetNode(ARecordIndex);
  if (ANode <> nil) and ANode.IsVisible and
    TreeList.ViewInfo.NodesViewInfo.FindNodeViewInfo(ANode, AViewInfo) then
      AViewInfo.Update(True);
end;

function TcxTreeListController.GetDataController: TcxControlDataController;
begin
  Result := TcxControlDataController(TreeList.DataController);
end;

function TcxTreeListController.GetFocusedNode: TcxTreeListNode;
begin
  Result := GetNode(FocusedRecordIndex);
end;

function TcxTreeListController.GetHitTest: TcxTreeListHitTest;
begin
  Result := TreeList.HitTest;
end;

function TcxTreeListController.GetIsControllerEvent: Boolean;
begin
  Result := IsControllerEventRefCount > 0;
end;

function TcxTreeListController.GetOptionsBehavior: TcxTreeListOptionsBehavior;
begin
  Result := TreeList.OptionsBehavior;
end;

function TcxTreeListController.GetSelection: TList;
begin
  Result := TreeList.FSelection;
end;

function TcxTreeListController.GetSelectionAnchor: TcxTreeListNode;
begin
  Result := SelectionAnchorNode;
  if Result = nil then
    Result := FocusedNode;
  while (Result <> nil) and not Result.IsVisible  do
    Result := Result.Parent;
end;

function TcxTreeListController.GetTreeList: TcxCustomTreeListControl;
begin
  Result := TcxCustomTreeListControl(EditingControl);
end;

procedure TcxTreeListController.SetIsControllerEvent(Value: Boolean);
begin
  if Value then
    Inc(IsControllerEventRefCount)
  else
    Dec(IsControllerEventRefCount);
end;

procedure TcxTreeListController.SetFocusedNode(ANode: TcxTreeListNode);
begin
  if ANode <> nil then
    FocusedRecordIndex := ANode.RecordIndex
  else
    FocusedRecordIndex := cxInvalidIndex;
end;

{ TcxTreeListViewInfoItem }

constructor TcxTreeListViewInfoItem.Create(AOwner: TObject);
begin
  inherited Create(AOwner);
  FBrush := TBrush.Create;
end;

destructor TcxTreeListViewInfoItem.Destroy;
begin
  FBrush.Free;
  inherited Destroy;
end;

procedure TcxTreeListViewInfoItem.Calculate(const ADisplayRect, AVisibleRect: TRect);
begin
  CheckClipping(ADisplayRect, AVisibleRect);
  DoCalculate;
end;

procedure TcxTreeListViewInfoItem.DoHorzOffset(AShift: Integer);
begin
  // do nothing
end;

procedure TcxTreeListViewInfoItem.DoCalculate;
begin
  FBrush.Color := ViewParams.Color;
end;

procedure TcxTreeListViewInfoItem.DoVertOffset(AShift: Integer);
begin
  // do nothing
end;

function TcxTreeListViewInfoItem.ShiftItem(
  const AVisibleRect: TRect; DX, DY: Integer): Boolean;
begin
  Result := Visible;
  CheckClipping(cxRectOffset(DisplayRect, DX, DY), AVisibleRect);
  Result := Result = Visible;
  if not Result and Visible then
    DoCalculate;
end;

function TcxTreeListViewInfoItem.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := cxE_NOINTERFACE;
end;

function TcxTreeListViewInfoItem._AddRef: Integer;
begin
  Result := -1;
end;

function TcxTreeListViewInfoItem._Release: Integer;
begin
  Result := -1;
end;

function TcxTreeListViewInfoItem.GetBrushManager: TcxBrushCache;
begin
  Result := TreeList.BrushCache;
end;

function TcxTreeListViewInfoItem.GetControlViewInfo: TcxTreeListViewInfo;
begin
  Result := TcxCustomTreeListControl(GetControl).ViewInfo;
end;

function TcxTreeListViewInfoItem.GetHitTestProp: TcxTreeListHitTest;
begin
  Result := TreeList.HitTest;
end;

function TcxTreeListViewInfoItem.GetOptionsView: TcxTreeListOptionsView;
begin
  Result := TreeList.OptionsView;
end;

function TcxTreeListViewInfoItem.GetPainterClass: TcxCustomLookAndFeelPainterClass;
begin
  Result := TreeList.LookAndFeelPainter;
end;

function TcxTreeListViewInfoItem.GetTreeList: TcxCustomTreeListControl;
begin
  Result := TcxCustomTreeListControl(GetControl);
end;

{ TcxTreeListIndicatorViewInfo }

procedure TcxTreeListIndicatorViewInfo.Calculate(
  const ADisplayRect, AVisibleRect: TRect);
begin
  if not OptionsView.Indicator then Exit;
  with ADisplayRect, ControlViewInfo do
  begin
    CheckClipping(cxRect(BorderSize, Top,
      BorderSize + OptionsView.IndicatorWidth, Bottom), AVisibleRect);
  end;
  if Visible then DoCalculate;
end;

procedure TcxTreeListIndicatorViewInfo.DoCalculate;
begin
  ItemViewParams := TcxTreeListViewInfo(ControlViewInfo).IndicatorViewParams;
end;

procedure TcxTreeListIndicatorViewInfo.DoVertOffset(AShift: Integer);
begin
  CheckClipping(cxRectOffset(DisplayRect, 0, AShift),
    ControlViewInfo.NodesViewInfo.ClipRect);
end;

function TcxTreeListIndicatorViewInfo.GetControl: TcxEditingControl;
begin
  Result := TcxTreeListViewInfo(Owner).TreeList;
end;

procedure TcxTreeListIndicatorViewInfo.UpdateKind(AKind: TcxIndicatorKind);
begin
  if AKind <> FKind then
  begin
    FKind := AKind;
    Invalidate;
  end;
end;

{ TcxTreeListFooterItemViewInfo }

procedure TcxTreeListFooterItemViewInfo.DoHorzOffset(DX: Integer);
begin
  ShiftItem(BandViewInfo.FooterRect, DX, 0);
end;

function TcxTreeListFooterItemViewInfo.GetControl: TcxEditingControl;
begin
  Result := Column.GetTreeList;
end;

function TcxTreeListFooterItemViewInfo.GetAlignHorz: TAlignment;
begin
  Result := FooterSummary.FAlignHorz;
end;

function TcxTreeListFooterItemViewInfo.GetAlignVert: TcxAlignmentVert;
begin
  Result := FooterSummary.FAlignVert;
end;

function TcxTreeListFooterItemViewInfo.GetBandViewInfo: TcxTreeListBandViewInfo;
begin
  Result := Column.BandViewInfo;
end;

function TcxTreeListFooterItemViewInfo.GetColumn: TcxTreeListColumnViewInfo;
begin
  Result := TcxTreeListColumnViewInfo(Owner);
end;

function TcxTreeListFooterItemViewInfo.GetFooterSummary: TcxTreeListColumnSummaryFooter;
begin
  Result := Column.Column.SummaryFooter;
end;

function TcxTreeListFooterItemViewInfo.GetMultiLine: Boolean;
begin
  Result := FooterSummary.MultiLine;
end;

function TcxTreeListFooterItemViewInfo.GetText: string;
begin
  Result := FooterSummary.SummaryText;
end;

function TcxTreeListFooterItemViewInfo.GetVisible: Boolean;
begin
  Result := inherited Visible and Column.Column.Options.Footer;
end;

{ TcxTreeListHeaderViewInfo }

destructor TcxTreeListHeaderViewInfo.Destroy;
begin
  if (TreeList <> nil) and (TreeList.HitTest.FPressedHeader = Self) then
     TreeList.HitTest.FPressedHeader := nil;
  inherited Destroy; 
end;

procedure TcxTreeListHeaderViewInfo.ButtonStateChanged(
  APrevIsPressed, IsPressed: Boolean);
begin
  if APrevIsPressed and not IsPressed then
    TreeList.DoBandHeaderClick(Band);
end;

function TcxTreeListHeaderViewInfo.CanDropAt(const P: TPoint): Boolean;
begin
  HitTest.HitPoint := P;
  with HitTest do
    Result := HitAtBand and
      PtInRect(cxRectInflate(HitBand.ViewInfo.ClipRect, 0, 0, 0, cxtlScrollDelta), P);
end;

procedure TcxTreeListHeaderViewInfo.DoCalculate;
begin
  if not Visible then Exit;
  FTextBounds := DisplayRect;
  FTextBounds := cxRectInflate(DisplayRect,
    -cxHeaderTextOffset, -cxHeaderTextOffset);
  with LookAndFeelPainter do
  begin
    if SortOrder <> soNone then
    begin
      FSortMarkBounds := FTextBounds;
      FSortMarkBounds.Left := FSortMarkBounds.Right - SortingMarkAreaSize.X;
      FTextBounds.Right := FSortMarkBounds.Left - cxHeaderTextOffset;
    end;
  end;
  InflateRect(FTextBounds, -1, 0);
  DoCalculateGlyphPosition;
  FBorders := cxBordersAll;
  FState := GetButtonState;
  inherited DoCalculate;
end;

procedure TcxTreeListHeaderViewInfo.DoCalculateGlyphPosition;
var
  AWidth, AHeight: Integer;
begin
  if Glyph.Empty then Exit;
  AWidth := Glyph.Width;
  AHeight := Glyph.Height;
  case GlyphAlignHorz of
    taLeftJustify:
    begin
      FGlyphPos.X := FTextBounds.Left;
      Inc(FTextBounds.Left, AWidth + cxHeaderTextOffset);
    end;
    taRightJustify:
    begin
      Dec(FTextBounds.Right, AWidth);
      FGlyphPos.X := FTextBounds.Right;
      Dec(FTextBounds.Right, cxHeaderTextOffset);
    end;
    taCenter:
      with FTextBounds do
        FGlyphPos.X := (Left + Right - AWidth) div 2;
  end;
  case GlyphAlignVert of
    vaTop:
      FGlyphPos.Y := FTextBounds.Top;
    vaBottom:
      FGlyphPos.Y := FTextBounds.Bottom - AHeight;
    vaCenter:
      with FTextBounds do
        FGlyphPos.Y := (Bottom + Top - AHeight) div 2;
  end;
  with ClipRect do
    NeedGlyphClipping := not cxInRange(FGlyphPos.X, Left, Right - AWidth) or
      not cxInRange(FGlyphPos.Y, Top, Bottom - AHeight);
end;

function TcxTreeListHeaderViewInfo.GetDisplayRect: TRect;
begin
  Result := DisplayRect; 
end;

procedure TcxTreeListHeaderViewInfo.DoHorzOffset(DX: Integer);
begin
  if ShiftItem(BandViewInfo.ClipRect, DX, 0) then
  begin
    cxOffsetHorz(FSortMarkBounds, DX);
    cxOffsetHorz(FTextBounds, DX);
    Inc(FGlyphPos.X, DX);
  end;
end;

function TcxTreeListHeaderViewInfo.GetDroppingRect: TRect;
begin
  with ControlViewInfo, ClientRect do
    Result := Rect(ContentOffset, GetBorderSize, Right, HeaderOffset);
  InflateRect(Result, 0, cxtlScrollDelta);
end;

function TcxTreeListHeaderViewInfo.GetDragSizing: IcxDragSizing;
begin
  Supports(TObject(BandViewInfo.Band), IcxDragSizing, Result);
end;

function TcxTreeListHeaderViewInfo.GetControl: TcxEditingControl;
begin
  Result := BandViewInfo.TreeList;
end;

function TcxTreeListHeaderViewInfo.GetSelected: Boolean;
begin
  Result := TreeList.Controller.IsObjectSelected(Band);
end;

function TcxTreeListHeaderViewInfo.GetSortOrder: TcxDataSortOrder;
begin
  Result := soNone;
end;

procedure TcxTreeListHeaderViewInfo.InitViewParams;
begin
  ItemViewParams := TreeList.Styles.GetBandHeaderParams(Band);
end;

procedure TcxTreeListHeaderViewInfo.UpdateState;
begin
  if GetButtonState <> FState then
  begin
    FState := GetButtonState;
    Invalidate;
  end;
end;

function TcxTreeListHeaderViewInfo.GetHintBounds: TRect;
begin
  Result := DisplayRect;
end;

function TcxTreeListHeaderViewInfo.IsNeedHint(ACanvas: TcxCanvas;
  const P: TPoint; out AText: TCaption; out AIsMultiLine: Boolean;
  out ATextRect: TRect; var IsNeedOffsetHint: Boolean): Boolean;
var
  R: TRect;
  AFlags: Integer;
begin
  if FCallHintNeeded >= 1 then
  begin
    Result := False;
    Exit;
  end;
  Inc(FCallHintNeeded);
  AText := Text;
  try
    AFlags := cxAlignTop or cxAlignLeft or cxDontPrint;
    if AIsMultiLine then
      AFlags := AFlags or cxWordBreak;
    ACanvas.Font := ViewParams.Font;
    R := TextBounds; 
    ACanvas.TextExtent(Text, R, AFlags);
    AIsMultiLine := MultiLine;
    Result := not HitTest.CanSizing and PtInRect(TextBounds, P) and
      (cxRectWidth(R) > cxRectWidth(TextBounds)) or
        (cxRectHeight(R) > cxRectHeight(TextBounds));
  finally
    Dec(FCallHintNeeded);
    AText := Text;
    ATextRect := R;
    IsNeedOffsetHint := False;
  end;
end;

procedure TcxTreeListHeaderViewInfo.UpdateHotTrackState(const APoint: TPoint);
begin
end;

procedure TcxTreeListHeaderViewInfo.CustomDrawEvent(
  var AEvent: TcxCustomDrawViewInfoItemEvent);
begin
  AEvent := TcxCustomDrawViewInfoItemEvent(TreeList.FOnCustomDrawBandHeader);
end;

function TcxTreeListHeaderViewInfo.GetAlignHorz: TAlignment;
begin
  Result := Caption.FAlignHorz;
end;

function TcxTreeListHeaderViewInfo.GetAlignVert: TcxAlignmentVert;
begin
  Result := Caption.FAlignVert;
end;

function TcxTreeListHeaderViewInfo.GetBand: TcxTreeListBand;
begin
  Result := BandViewInfo.Band;
end;

function TcxTreeListHeaderViewInfo.GetBandViewInfo: TcxTreeListBandViewInfo;
begin
  Result := TcxTreeListBandViewInfo(Owner);
end;

function TcxTreeListHeaderViewInfo.GetCaption: TcxTreeListCaption;
begin
  Result := BandViewInfo.Band.Caption;
end;

function TcxTreeListHeaderViewInfo.GetButtonState: TcxButtonState;
begin
  Result := cxbsDefault;
  with TreeList do
  begin
    if Pressed then
      Result := cxbsPressed
    else
      if GetHotTrack then Result :=  cxbsHot;
  end;
end;

function TcxTreeListHeaderViewInfo.GetGlyph: TBitmap;
begin
  Result := Caption.Glyph;
end;

function TcxTreeListHeaderViewInfo.GetGlyphAlignHorz: TAlignment;
begin
  Result := Caption.GlyphAlignHorz;
end;

function TcxTreeListHeaderViewInfo.GetGlyphAlignVert: TcxAlignmentVert;
begin
  Result := Caption.GlyphAlignVert;
end;

function TcxTreeListHeaderViewInfo.GetHotTrack: Boolean;
begin
  Result := LookandFeelPainter.IsHeaderHotTrack and
    (TreeList.DragAndDropState <> ddsInProcess) and
      (TreeList.HitTest.HitTestItem = Self);
  if Result then
  begin
    TreeList.HitTest.HitPoint := TreeList.ScreenToClient(GetMouseCursorPos);
    Result := TreeList.HitTest.HitTestItem = Self;
  end;
end;

function TcxTreeListHeaderViewInfo.GetState(Index: Integer): Boolean;
begin
  Result := Caption.GetState(Index);
end;

function TcxTreeListHeaderViewInfo.GetText: string;
begin
  Result := Caption.Text;
end;

procedure TcxTreeListHeaderViewInfo.SetPressed(Value: Boolean);
begin
  if (Self = nil) or (TreeList = nil) or
    (TreeList.HitTest = nil) or (Value = FPressed) then Exit;
  with TreeList.HitTest do
  begin
    FPressed := Value;
    if FPressed and (FPressedHeader <> Self) then
    begin
      if FPressedHeader <> nil then FPressedHeader.Pressed := False;
      FPressedHeader := Self;
    end;
  end;
  ButtonStateChanged(not FPressed, Value);
  UpdateState;
end;

{ TcxTreeListColumnHeaderViewInfo }

procedure TcxTreeListColumnHeaderViewInfo.ButtonStateChanged(
  APrevIsPressed, IsPressed: Boolean);
const
  ASortOrders: array[TcxDataSortOrder] of TcxDataSortOrder =
    (soAscending, soDescending, soAscending);
begin
  with TreeList.Controller do
  begin
    if APrevIsPressed and not IsPressed and not IsDragDropProcess and not IsDblClick then
      DoChangeColumnSortOrder(Column, ASortOrders[Column.SortOrder], []);
    if APrevIsPressed and not IsPressed and not IsDragDropProcess then 
      TreeList.DoColumnHeaderClick(Column);
  end;
end;

function TcxTreeListColumnHeaderViewInfo.CanDropAt(const P: TPoint): Boolean;
begin
  Result := True;
end;

procedure TcxTreeListColumnHeaderViewInfo.DoCalculate;
begin
  inherited DoCalculate;
  FIsUltraFlat := not OptionsView.IsExtPaintStyle and
    (Painter.HeaderBorders([nLeft, nRight]) <> cxBordersAll);
  with Column do
  begin
    if not IsLeft then FNeighbors := [nLeft];
    if not IsRight then FNeighbors := [nRight];
    with GetDisplayRect do
    begin
      if (ClipRect.Left = DisplayRect.Left) and (DisplayRect.Left <> Left) then
        ClipRect.Left := Left;
    end;
  end;
end;

function TcxTreeListColumnHeaderViewInfo.GetControl: TcxEditingControl;
begin
  Result := Column.TreeList;
end;

function TcxTreeListColumnHeaderViewInfo.GetDisplayRect: TRect;
begin
  Result := inherited GetDisplayRect;
  if FIsUltraFlat and not Column.IsLeft then Dec(Result.Left);
end;

function TcxTreeListColumnHeaderViewInfo.GetDragSizing: IcxDragSizing;
begin
  Supports(TObject(Column), IcxDragSizing, Result);
end;

function TcxTreeListColumnHeaderViewInfo.GetDroppingRect: TRect;
begin
  with ControlViewInfo, ClientRect do
    Result := Rect(ContentOffset, HeaderOffset, Right, CellsOffset);
  InflateRect(Result, 0, cxtlScrollDelta);
end;

function TcxTreeListColumnHeaderViewInfo.GetSortOrder: TcxDataSortOrder;
begin
  Result := Column.GetRealSortOrder;
end;

procedure TcxTreeListColumnHeaderViewInfo.InitViewParams;
begin
  ItemViewParams := TreeList.Styles.GetColumnHeaderParams(Column)
end;

function TcxTreeListColumnHeaderViewInfo.GetSelected: Boolean;
begin
  Result := TreeList.Controller.IsObjectSelected(Column);
end;

procedure TcxTreeListColumnHeaderViewInfo.CustomDrawEvent(
  var AEvent: TcxCustomDrawViewInfoItemEvent);
begin
  AEvent := TcxCustomDrawViewInfoItemEvent(TreeList.FOnCustomDrawHeaderCell);
end;

function TcxTreeListColumnHeaderViewInfo.GetBandViewInfo: TcxTreeListBandViewInfo;
begin
  if not Column.Visible then
    Result := nil
  else
    Result := TcxTreeListColumnViewInfo(Owner).BandViewInfo
end;

function TcxTreeListColumnHeaderViewInfo.GetCaption: TcxTreeListCaption;
begin
  Result := Column.Caption;
end;

function TcxTreeListColumnHeaderViewInfo.GetColumn: TcxTreeListColumn;
begin
  Result := TcxTreeListColumnViewInfo(Owner).Column;
end;

{ TcxTreeListColumnHeaderViewInfo }

constructor TcxTreeListColumnViewInfo.Create(AOwner: TcxTreeListColumn);
begin
  FColumn := AOwner;
  FColumnHeader := TcxTreeListColumnHeaderViewInfo.Create(Self);
  FColumnFooter := TcxTreeListFooterItemViewInfo.Create(Self);
end;

destructor TcxTreeListColumnViewInfo.Destroy;
begin
  FreeAndNil(FColumnFooter);
  FreeAndNil(FColumnHeader);
  inherited Destroy;
end;

function TcxTreeListColumnViewInfo.CalcHeaderRect: TRect;
begin
  with TreeList, ViewInfo, Result do
  begin
    Result.TopLeft := Point(XOfs, HeaderOffset + YOfs * HeaderLineHeight);
    with Column.Position do
      Result := cxRectSetSize(Result, DisplayWidth, LineCount * HeaderLineHeight);
  end;
end;

function TcxTreeListColumnViewInfo.CalcFooterRect: TRect;

  function GetWidth: Integer;
  begin
    with Column, TreeList.LookAndFeelPainter do
      Result := DisplayWidth - Byte(IsLeftMost or IsRightMost) * FooterBorderSize;
  end;

begin
  with TreeList, ViewInfo, LookAndFeelPainter, Result do
  begin
    TopLeft := Point(XOfs + Byte(Column.IsLeftMost) * FooterBorderSize, FooterCellsOffset);
    Right := Left + GetWidth;
    Bottom := Top + Column.Position.LineCount * FooterLineHeight;
    InflateRect(Result, -FooterCellOffset, -FooterCellOffset);
  end;
end;

procedure TcxTreeListColumnViewInfo.DoCalculate;
begin
  if OptionsView.Headers then
    FColumnHeader.Calculate(CalcHeaderRect, BandViewInfo.ClipRect);
  if OptionsView.Footer then
    FColumnFooter.Calculate(CalcFooterRect, BandViewInfo.FooterRect);
end;

procedure TcxTreeListColumnViewInfo.DoHorzOffset(DX: Integer);
begin
  if OptionsView.Headers then
    FColumnHeader.DoHorzOffset(DX);
  if OptionsView.Footer and (TreeList.VisibleColumnCount > 0) then
    FColumnFooter.DoHorzOffset(DX);
  Inc(XOfs, DX);
end;

function TcxTreeListColumnViewInfo.GetBandViewInfo: TcxTreeListBandViewInfo;
begin
  Result := Column.OwnerBand.ViewInfo;
end;

function TcxTreeListColumnViewInfo.GetDisplayWidth: Integer;
begin
  Result := Column.DisplayWidth;
end;

function TcxTreeListColumnViewInfo.GetFooterCellsOffset: Integer;
begin
  with TreeList, ViewInfo, LookAndFeelPainter do
    Result := FooterOffset + FooterBorderSize + YOfs * FooterLineHeight;
end;

function TcxTreeListColumnViewInfo.GetLineCount: Integer;
begin
  Result := Column.Position.LineCount;
end;

function TcxTreeListColumnViewInfo.GetOptionsView: TcxTreeListOptionsView;
begin
  Result := TreeList.OptionsView;
end;

function TcxTreeListColumnViewInfo.GetTreeList: TcxCustomTreeListControl;
begin
  Result := FColumn.TreeList;
end;

{ TcxTreeListBandViewInfo }

constructor TcxTreeListBandViewInfo.Create(AOwner: TObject);
begin
  inherited Create(AOwner);
  FBandHeader := TcxTreeListHeaderViewInfo.Create(Self);
  FooterBrush := TBrush.Create;
  ContainerBrush := TBrush.Create;
end;

destructor TcxTreeListBandViewInfo.Destroy;
begin
  FreeAndNil(FBandHeader);
  FreeMem(FColumns);
  FooterBrush.Free; 
  ContainerBrush.Free;
  inherited Destroy;
end;

procedure TcxTreeListBandViewInfo.CalcFooterRect;
begin
  FFooterRect := ControlViewInfo.FooterRect;
  FFooterRect.Left := ClipRect.Left;
  FFooterRect.Right := ClipRect.Right;
end;

procedure TcxTreeListBandViewInfo.CheckOpaque;
var
  I, ALines: Integer;

  function CheckRow(ARow: TcxTreeListBandRow): Integer;
  var
    J: Integer;
  begin
    Result := MaxInt div 20;
    for J := 0 to ARow.Count - 1 do
      Result := cxMin(Result, ARow[J].Position.LineCount);
  end;

begin
  with Band.BandRows do
  begin
    ALines := 0;
    IsOpaque := ColumnCount > 0;
    if IsOpaque then
      for I := 0 to Count - 1 do Inc(ALines, CheckRow(Items[I]));
  end;
  IsOpaque := IsOpaque and (ALines = TreeList.HeaderLineCount);
end;

procedure TcxTreeListBandViewInfo.DoCalculate;
var
  R: TRect;
begin
  if Self = nil then Exit;
  ContainerBrush.Color := ContainerViewParams.Color;
  FFooterViewParams := TreeList.Styles.GetBandFooterParams(Band);
  FooterBrush.Color := FFooterViewParams.Color;
  if OptionsView.Bands then
  begin
    BandHeader.ItemViewParams := ItemViewParams;
    R := DisplayRect;
    R.Bottom := ControlViewInfo.HeaderOffset;
    BandHeader.Calculate(R, ClipRect);
  end;
  CalcFooterRect;
  DoCalculateColumns;
end;

procedure TcxTreeListBandViewInfo.DoCalculateColumns;
var
  I, J, AOfs: Integer;

  procedure AddColumnViewInfo(AViewInfo: TcxTreeListColumnViewInfo; YOfs: Integer);
  begin
    AViewInfo.XOfs := AOfs;
    AViewInfo.YOfs := YOfs;
    FColumns[FCount] := AViewInfo;
    Inc(FCount);
    Inc(AOfs, AViewInfo.DisplayWidth);
    AViewInfo.DoCalculate;
  end;

begin
  SetCapacity(Band.FColumns.Count);
  FCount := 0;
  for I := 0 to Band.BandRows.Count - 1 do
  begin
    with Band.BandRows[I] do
    begin
      AOfs := DisplayRect.Left;
      for J := 0 to Count - 1 do
        AddColumnViewInfo(Items[J].ViewInfo, LineOffset);
    end;
  end;
  IsOpaque := False;
  CheckOpaque;
end;

procedure TcxTreeListBandViewInfo.DoHorzOffset(DX: Integer);
var
  I: Integer;
begin
  if ShiftItem(ControlViewInfo.ScrollingArea, DX, 0) then
  begin
    CalcFooterRect;
    if OptionsView.Bands then
      BandHeader.DoHorzOffset(DX);
    for I := 0 to ColumnCount - 1 do
      Columns[I].DoHorzOffset(DX);
  end;
end;

function TcxTreeListBandViewInfo.GetControl: TcxEditingControl;
begin
  Result := Band.GetTreeList;
end;

procedure TcxTreeListBandViewInfo.SetCapacity(ACapacity: Integer);
begin
  if ACapacity > FCapacity then
  begin
    FCapacity := ACapacity;
    ReallocMem(FColumns, FCapacity * SizeOf(Pointer));
  end;
  FCount := 0;
end;

function TcxTreeListBandViewInfo.GetBand: TcxTreeListBand;
begin
  Result := TcxTreeListBand(Owner);
end;

function TcxTreeListBandViewInfo.GetColumn(AIndex: Integer): TcxTreeListColumnViewInfo;
begin
  Result := TcxTreeListColumnViewInfo(FColumns^[AIndex]);
end;

function TcxTreeListBandViewInfo.GetDisplayWidth: Integer;
begin
  Result := Band.DisplayWidth;
end;

function TcxTreeListBandViewInfo.GetFixed: TcxTreeListBandFixedKind;
begin
  Result := Band.FixedKind;
end;

{ TcxTreeListEditCellViewInfo }

procedure TcxTreeListEditCellViewInfo.Assign(Source: TcxCustomViewInfoItem);
begin
  if Source is TcxTreeListEditCellViewInfo then
  begin
    GroupIndex := TcxTreeListEditCellViewInfo(Source).GroupIndex;
    FColumnViewInfo := TcxTreeListEditCellViewInfo(Source).FColumnViewInfo;
  end;
  inherited Assign(Source);
end;

function TcxTreeListEditCellViewInfo.ContentOffset: TRect;
begin
  Result := cxTreeListEditCellContentOffset;
end;

function TcxTreeListEditCellViewInfo.ChangedHeight(
  APrevHeight, ANewHeight: Integer): Boolean;
begin
  Result := inherited ChangedHeight(APrevHeight, ANewHeight);
  with NodeViewInfo do
  begin
    if Result and (APrevHeight = CellsMaxHeight) then
      Dec(CellMaxHeightRefCount);
    Result := Result or (ANewHeight > CellsMaxHeight) or (CellMaxHeightRefCount = 0);
  end;
end;

procedure TcxTreeListEditCellViewInfo.CustomDrawEvent(
  var AEvent: TcxCustomDrawViewInfoItemEvent);
begin
  AEvent := TcxCustomDrawViewInfoItemEvent(TreeList.FOnCustomDrawCell);
end;

procedure TcxTreeListEditCellViewInfo.DoHorzOffset(AShift: Integer);
begin
  ShiftItem(AShift, 0);
end;

procedure TcxTreeListEditCellViewInfo.DoVertOffset(AShift: Integer);
begin
  ShiftItem(0, AShift);
end;

function TcxTreeListEditCellViewInfo.GetColumn: TcxTreeListColumn;
begin
  if FColumnViewInfo = nil then
    Result := nil
  else
    Result := FColumnViewInfo.FColumn;
end;

function TcxTreeListEditCellViewInfo.GetButtonTransparency: TcxEditButtonTransparency;
var
  B1: TcxEditingControlEditShowButtons;
  B2: TcxEditItemShowEditButtons;
  AFocused: Boolean; 
begin
  AFocused := Node = TreeList.FocusedNode;
  B1 := TreeList.OptionsView.ShowEditButtons;
  B2 := Column.Options.ShowEditButtons;
  if (B2 = eisbAlways) or (B2 = eisbDefault) and
   ((B1 = ecsbAlways) or (B1 = ecsbFocused) and AFocused) then
    Result := ebtNone
  else
    Result := ebtHideInactive;
end;

function TcxTreeListEditCellViewInfo.GetDisplayValue: Variant;
begin
  Result := Column.DoOnGetDisplayText(Node, False, True);
end;

function TcxTreeListEditCellViewInfo.GetEditContainer: TcxCustomInplaceEditContainer;
begin
  if TreeList.IsDestroying then
    Result := nil
  else
    Result := Column;
end;

function TcxTreeListEditCellViewInfo.GetEditViewParams: TcxViewParams;
begin
  GetTreeListEditCellParams(Result);
  if Selected then
    with ControlViewInfo.SelectionParams do
    begin
      Result.TextColor := TextColor;
      if TreeList.Styles.SelectionFontAssigned  then
        Result.Font := Font;
      Result.Color := Color;
    end;
end;

function TcxTreeListEditCellViewInfo.GetFocused: Boolean;
begin
  Result := NodeViewInfo.Selected;
end;

function TcxTreeListEditCellViewInfo.GetHotTrack: Boolean;
begin
  Result := Node.HotTrack;
end;

function TcxTreeListEditCellViewInfo.GetLineCount: Integer;
begin
  Result := FColumnViewInfo.LineCount;
end;

function TcxTreeListEditCellViewInfo.GetLineOffset: Integer;
begin
  Result := FColumnViewInfo.YOfs;
end;

function TcxTreeListEditCellViewInfo.GetRecordIndex: Integer;
begin
  Result := Node.RecordIndex;
end;

function TcxTreeListEditCellViewInfo.GetSelected: Boolean;
begin
  Result := Focused;
  with TreeList, OptionsSelection do
  begin
    if NodeViewInfo.Focused then
    begin
      if Result and CellSelect then
      begin
        Result := Result and ((InvertSelect and not Column.Focused) or
          (not InvertSelect and Column.Focused and not Column.Editing));
        if not InvertSelect and Result then
          NodeViewInfo.NodeFocusedCell := Self;
        if Result and (HideSelection and not IsFocused) then
          Result := False;
      end
      else
        Result := Result and InvertSelect;
      if HideSelection and not IsFocused then
        Result := False; 
    end;
  end;
end;

function TcxTreeListEditCellViewInfo.GetSelectedTextColor: Integer;
begin
  Result := IncSearchParams.TextColor;
end;

function TcxTreeListEditCellViewInfo.GetSelectedBKColor: Integer;
begin
  Result := IncSearchParams.Color
end;

procedure TcxTreeListEditCellViewInfo.GetTreeListEditCellParams(
  var AParams: TcxViewParams);
begin
  TreeList.Styles.DoGetContentParams(Node, Column, AParams);
end;

function TcxTreeListEditCellViewInfo.GetViewInfoData: Pointer;
begin
  Result := Node;
end;

function TcxTreeListEditCellViewInfo.IncSearchParams: TcxViewParams;
begin
  Result := TreeList.Styles.GetIncSearchParams;
  if Result.Color = clDefault then
    Result.Color := inherited GetSelectedBKColor;
  if Result.TextColor = clDefault then
    Result.TextColor := inherited GetSelectedTextColor;
end;

function TcxTreeListEditCellViewInfo.IsAutoHeight: Boolean;
begin
  Result := NodeViewInfo.Owner.IsRowAutoHeight;
end;

function TcxTreeListEditCellViewInfo.IsEndEllipsis: Boolean;
begin
  Result := inherited IsEndEllipsis and Column.Options.CellEndEllipsis;
end;

function TcxTreeListEditCellViewInfo.IsTransparent: Boolean;
begin
  Result := inherited IsTransparent and not Selected;
end;

procedure TcxTreeListEditCellViewInfo.SetPosition(
  ATop, AHeight: Integer; const AClipRect: TRect);
begin
  if not IsAutoHeight then
  begin
    AHeight := cxRectHeight(DisplayRect);
    ATop := ATop - NodeViewInfo.Top + DisplayRect.Top;
  end;
  cxRectSetTopEx(DisplayRect, ATop, AHeight);
  CheckClipping(DisplayRect, AClipRect);
end;

procedure TcxTreeListEditCellViewInfo.ShiftItem(DX, DY: Integer);
begin
  CheckClipping(cxRectOffset(DisplayRect, DX, DY), Group.ClipRect);
  UpdateViewInfoPosition;
end;

procedure TcxTreeListEditCellViewInfo.UpdateViewInfoPosition;
begin
  if ViewInfo <> nil then
  begin
    ViewInfo.Top := DisplayRect.Top + Byte(bTop in Borders);
    ViewInfo.Left := DisplayRect.Left + Byte(bLeft in Borders);
  end;
end;

function TcxTreeListEditCellViewInfo.GetBand: TcxTreeListBand;
begin
  Result := Column.OwnerBand;
end;

function TcxTreeListEditCellViewInfo.GetControlViewInfo: TcxTreeListViewInfo;
begin
  Result := TreeList.ViewInfo;
end;

function TcxTreeListEditCellViewInfo.GetEditRectEx: TRect;
begin
  Result := CellEditRect; 
end;

function TcxTreeListEditCellViewInfo.GetGroup: TcxTreeListCellsGroupViewInfo;
begin
  Result := NodeViewInfo.Groups[GroupIndex]
end;

function TcxTreeListEditCellViewInfo.GetNode: TcxTreeListNode;
begin
  Result := NodeViewInfo.Node;
end;

function TcxTreeListEditCellViewInfo.GetNodesViewInfo: TcxTreeListNodesViewInfo;
begin
  Result := NodeViewInfo.Owner;
end;

function TcxTreeListEditCellViewInfo.GetNodeViewInfo: TcxTreeListNodeViewInfo;
begin
  Result := TcxTreeListNodeViewInfo(Owner);
end; 

function TcxTreeListEditCellViewInfo.GetTreeList: TcxCustomTreeListControl;
begin
  Result := NodeViewInfo.TreeList;
end;

{ TcxTreeListCellsGroupViewInfo }

procedure TcxTreeListCellsGroupViewInfo.Assign(Source: TcxCustomViewInfoItem);
begin
  if Source is TcxTreeListViewInfoItem then
  begin
    BandViewInfo := TcxTreeListCellsGroupViewInfo(Source).BandViewInfo;
    Borders := TcxTreeListCellsGroupViewInfo(Source).Borders;
    Indent := TcxTreeListCellsGroupViewInfo(Source).Indent;
    FirstIndex := TcxTreeListCellsGroupViewInfo(Source).FirstIndex;
    LastIndex := TcxTreeListCellsGroupViewInfo(Source).LastIndex;
    IsOpaque := TcxTreeListCellsGroupViewInfo(Source).IsOpaque;
  end;
  inherited Assign(Source);
end;

procedure TcxTreeListCellsGroupViewInfo.DoCalculate;
begin
  if not IsOpaque then inherited DoCalculate;
end;

procedure TcxTreeListCellsGroupViewInfo.DoCalculateCellsLayout;
var
  I: Integer;
begin
  for I := 0 to CellCount - 1 do
    CalculateEditCellRect(Cells[I], BandViewInfo.DisplayRect.Left);
end;

procedure TcxTreeListCellsGroupViewInfo.DoHorzOffset(AShift: Integer);
begin
  ShiftGroup(AShift, 0);
end;

procedure TcxTreeListCellsGroupViewInfo.DoVertOffset(AShift: Integer);
begin
  ShiftGroup(0, AShift);
end;

function TcxTreeListCellsGroupViewInfo.GetControl: TcxEditingControl;
begin
  Result := NodeViewInfo.TreeList;
end;

function TcxTreeListCellsGroupViewInfo.GetHotTrack: Boolean;
begin
  Result := NodeViewInfo.Node.HotTrack;
end;

function TcxTreeListCellsGroupViewInfo.GetSelected: Boolean;
begin
  with TreeList, OptionsSelection do
  begin
    Result := NodeViewInfo.Selected and InvertSelect and
     ((HideSelection and Focused) or not HideSelection);
  end;
end;

function TcxTreeListCellsGroupViewInfo.GetGroupBitmap: TBitmap;
begin
  if Selected then
    Result := nil
  else
    Result := ViewParams.Bitmap;
end;

procedure TcxTreeListCellsGroupViewInfo.SetSize(ATop, AHeight: Integer);
var
  I: Integer; 
begin
  CheckClipping(cxRectSetTop(DisplayRect, ATop, AHeight),
    NodeViewInfo.NodeClipRect);
  with TcxTreeListNodeViewInfo(Owner), FCells do
  begin
    for I := FirstIndex to LastIndex - 1 do
      TcxTreeListEditCellViewInfo(List^[I]).SetPosition(
        NodeCellsOffset, CellsMaxHeight, ClipRect);
  end;
end;

procedure TcxTreeListCellsGroupViewInfo.ShiftGroup(DX, DY: Integer);
var
  I: Integer;
begin
  CheckClipping(cxRectOffset(DisplayRect, DX, DY), NodeViewInfo.GetVisibleRect(Fixed));
  for I := 0 to CellCount - 1 do
    Cells[I].ShiftItem(DX, DY);
end;

function TcxTreeListCellsGroupViewInfo.GetBand: TcxTreeListBand;
begin
  Result := BandViewInfo.Band;
end;

function TcxTreeListCellsGroupViewInfo.GetCell(Index: Integer): TcxTreeListEditCellViewInfo;
begin
  Result :=
    TcxTreeListEditCellViewInfo(TcxTreeListNodeViewInfo(Owner).FCells.List^[FirstIndex + Index]);
end;

function TcxTreeListCellsGroupViewInfo.GetCellsHeight: Integer;
begin
  Result := ControlViewInfo.DefaultHeight;
end;

function TcxTreeListCellsGroupViewInfo.GetCount: Integer;
begin
  Result := LastIndex - FirstIndex;
end;

function TcxTreeListCellsGroupViewInfo.GetCurrentBrush: TBrush;
begin
  with TreeList.OptionsSelection do
  begin
    if Selected then
      Result := ControlViewInfo.SelectionBrush
    else
      Result := Brush;
  end;
end;

function TcxTreeListCellsGroupViewInfo.GetFixed: Boolean;
begin
  Result := Band.FixedKind <> tlbfNone;
end;

function TcxTreeListCellsGroupViewInfo.GetNodeViewInfo: TcxTreeListNodeViewInfo;
begin
  Result := TcxTreeListNodeViewInfo(Owner);
end;

function TcxTreeListCellsGroupViewInfo.GetNodesViewInfo: TcxTreeListNodesViewInfo;
begin
  Result := NodeViewInfo.Owner;
end;

function TcxTreeListCellsGroupViewInfo.GetNode: TcxTreeListNode;
begin
  Result := NodeViewInfo.Node;
end;

procedure TcxTreeListCellsGroupViewInfo.CalculateEditCellRect(
  ACell: TcxTreeListEditCellViewInfo; AMostLeftPos: Integer);
var
  AOfs: Integer;
begin
  with ACell, FColumnViewInfo do
  begin
    CellBorders := Group.Borders;
    if XOfs = AMostLeftPos then
    begin
      AOfs := Self.DisplayRect.Left;
      if CellBorders <> cxBordersAll then Exclude(CellBorders, bLeft);
    end
    else
      AOfs := XOfs - Byte(bRight in CellBorders);
    if True{not IsAutoHeight} then
    begin
      DisplayRect := cxRect(AOfs, YOfs, XOfs + DisplayWidth, LineCount);
      cxRectScaleH(DisplayRect, Self.CellsHeight);
      DisplayRect:= cxRectOffset(DisplayRect, 0, NodeViewInfo.Top);
    end
    else
      DisplayRect := cxRect(AOfs, 0, XOfs + DisplayWidth, 1);
    if YOfs > 0 then
      Dec(DisplayRect.Top, OptionsView.VertIncrement)
    else
      Exclude(CellBorders, bTop);
  end;
end;

{ TcxTreeListIndentViewInfo }

procedure TcxTreeListIndentViewInfo.DoCalculate;
begin
  if not Visible then Exit;
  if IndentTreeLines <> [] then
    with DisplayRect, cxRectCenter(DisplayRect) do
    begin
      if tltHorz in IndentTreeLines then
        IndentHorzTreeLine := cxRect(X, Y - 1, Right, Y);
      if [tltVertUp, tltVertDown] * IndentTreeLines <> [] then
      begin
        IndentVertTreeLine := cxRect(X, Top, X + 1, Bottom);
        if not (tltVertUp in IndentTreeLines) then
          IndentVertTreeLine.Top := Y - 1;
        if not (tltVertDown in IndentTreeLines) then
          IndentVertTreeLine.Bottom := Y - 1;
      end;
    end;
  inherited DoCalculate;
end;

procedure TcxTreeListIndentViewInfo.DoHorzOffset(AShift: Integer);
begin
  ShiftIndent(AShift, 0);
end;

procedure TcxTreeListIndentViewInfo.DoVertOffset(AShift: Integer);
begin
  ShiftIndent(0, AShift);
end;

function TcxTreeListIndentViewInfo.GetControl: TcxEditingControl;
begin
  Result := Node.TreeList;
end;

procedure TcxTreeListIndentViewInfo.ShiftIndent(DX, DY: Integer);
begin
  CheckClipping(cxRectOffset(DisplayRect, DX, DY), NodesViewInfo.ClipRect);
  DoCalculate;
end;

procedure TcxTreeListIndentViewInfo.UpdateImageIndex;
begin
  with NodeViewInfo do
  begin
    if not IndentStateImage then
      IndentImageIndex :=
        TreeList.DoGetNodeImageIndex(Node, TcxTreeListImageIndexType(Selected))
    else
      IndentImageIndex := TreeList.DoGetNodeImageIndex(Node, tlitStateIndex);
  end;
  IndentHasImage := cxInRange(IndentImageIndex, 0, IndentImageList.Count - 1);
  Invalidate;
end;

function TcxTreeListIndentViewInfo.GetButtonRect: TRect;
begin
  with ControlViewInfo do
  begin
    if HasButton then
    begin
      Result := cxRectCenter(DisplayRect, ExpandButtonSize, ExpandButtonSize);
      OffsetRect(Result, 0, -1);
      with DisplayRect do
        OffsetRect(Result, Byte(not Odd(Right - Left)), Byte(not Odd(Bottom - Top)));
    end
    else
      Result := cxInvalidRect;
  end;
end;

function TcxTreeListIndentViewInfo.GetIsExpanded: Boolean;
begin
  Result := HasButton and NodeViewInfo.IsExpanded;
end;

function TcxTreeListIndentViewInfo.GetNextVisible: TcxTreeListNodeViewInfo;
begin
  Result := NodeViewInfo.NextVisible;
end;

function TcxTreeListIndentViewInfo.GetNode: TcxTreeListNode;
begin
  Result := NodeViewInfo.Node;
end;

function TcxTreeListIndentViewInfo.GetNodeViewInfo: TcxTreeListNodeViewInfo;
begin
  Result := TcxTreeListNodeViewInfo(Owner);
end;

function TcxTreeListIndentViewInfo.GetNodesViewInfo: TcxTreeListNodesViewInfo;
begin
  Result := NodeViewInfo.Owner;
end;

function TcxTreeListIndentViewInfo.GetPrevVisible: TcxTreeListNodeViewInfo;
begin
  Result := NodeViewInfo.PrevVisible;
end;

{ TcxTreeListGroupNodeEditViewInfo }

function TcxTreeListGroupNodeEditViewInfo.ChangedHeight(
  APrevHeight, ANewHeight: Integer): Boolean;
begin
  if ANewHeight < TreeList.ViewInfo.DefaultHeight then
    ANewHeight := TreeList.ViewInfo.DefaultHeight;
  Result := APrevHeight <> ANewHeight;
end;

procedure TcxTreeListGroupNodeEditViewInfo.DoCalculate;
begin
  CellBorders := GridLineBorders[TreeList.OptionsView.GridLines] - [bTop];
//  if TreeList.OptionsView.GridLines = tlglVert then Exclude(CellBorders, bLeft);
  with NodeViewInfo do
    CheckClipping(GetCellRect, NodeClipRect);
  inherited DoCalculate;
end;

function TcxTreeListGroupNodeEditViewInfo.GetColumn: TcxTreeListColumn;
begin
  Result := NodeViewInfo.TreeList.OptionsView.GetCategorizedColumn;
end;

procedure TcxTreeListGroupNodeEditViewInfo.ShiftItem(DX, DY: Integer);
begin
  cxShiftEditViewInfoItem(Self, DX, DY);
end;

procedure TcxTreeListGroupNodeEditViewInfo.Update;
begin
  if not NodeViewInfo.NodeIsGroup then Exit;
  Column.InitEditViewInfo(Self);
  DoCalculate;
end;

function TcxTreeListGroupNodeEditViewInfo.GetCellRect: TRect;
begin
  with NodeViewInfo do
    Result := cxRectSetTop(NodeCellsRect, NodeCellsOffset, CellsMaxHeight);
end;

{ TcxTreeListNodePreviewViewInfo }

constructor TcxTreeListNodePreviewViewInfo.Create(AOwner: TObject);
begin
  inherited Create(AOwner);
  Preview := TreeList.Preview;
end;

function TcxTreeListNodePreviewViewInfo.ChangedHeight(
  APrevHeight, ANewHeight: Integer): Boolean;
begin
  Result := inherited ChangedHeight(APrevHeight, ANewHeight);
end;

function TcxTreeListNodePreviewViewInfo.CheckPreviewHeight(DH: Integer): Integer;
var
  ALines: Integer;
begin
  if Preview.MaxLineCount = 0 then
    ALines := Round(PreviewHeight / ControlViewInfo.PreviewHeight)
  else
    ALines := Preview.MaxLineCount;
  Result := (ControlViewInfo.PreviewHeight + DH) * ALines;
  if Result > PreviewHeight then Result := PreviewHeight;
end;

function TcxTreeListNodePreviewViewInfo.ContentOffset: TRect;
begin
  Result := cxTreeListEditCellContentOffset;
  with Preview do
  begin
    Result.Left := FLeftIndent;
    Result.Right := FRightIndent;
  end;
end;

procedure TcxTreeListNodePreviewViewInfo.CustomDrawEvent(
  var AEvent: TcxCustomDrawViewInfoItemEvent);
begin
  AEvent := TcxCustomDrawViewInfoItemEvent(TreeList.FOnCustomDrawPreview);
end;

procedure TcxTreeListNodePreviewViewInfo.DoCalculate;
begin
  if not NodeViewInfo.HasPreview then Exit;
  with NodeViewInfo do
    CheckClipping(GetPreviewRect, NodeClipRect);
  Refresh(False);
  if Visible then
    Column.CalculateEditViewInfo(CellValue, Self, cxInvalidPoint);
end;

procedure TcxTreeListNodePreviewViewInfo.DoInitPreviewSettings(
  APreviewOffset: Integer);
var
  DH: Integer;
begin
  PreviewHeight := 0;
  CellBorders := NodeViewInfo.NodeBorders;
  NodeViewInfo.NodeHasPreview := TreeList.Preview.Active;
  NodeViewInfo.NodePreviewOffset := APreviewOffset;
  if not NodeViewInfo.NodeHasPreview then Exit;
  Column.InitEditViewInfo(Self);
  Include(ViewData.PaintOptions, epoAllowZeroHeight);
  with ContentOffset do
    DH := Byte(bBottom in Borders) + Byte(bTop in Borders) + Top + Bottom;
  PreviewHeight := ControlViewInfo.PreviewHeight + DH;
  if IsAutoHeight then
  begin
    CellContentRect := GetPreviewRect;
    PreviewHeight := Column.GetEditHeight(Self);
    PreviewHeight := CheckPreviewHeight(DH);
  end;
  with NodesViewInfo do
  begin
    if Assigned(TreeList.OnGetNodePreviewHeight) then
      TreeList.OnGetNodePreviewHeight(TreeList, Node, DisplayValue, PreviewHeight);
    if (PreviewHeight - DH) <= 0  then
    begin
      PreviewHeight := 0;
      ItemVisible := False;
    end;
  end;
end;

function TcxTreeListNodePreviewViewInfo.GetColumn: TcxTreeListColumn;
begin
  Result := Preview.Column;
end;

function TcxTreeListNodePreviewViewInfo.GetButtonTransparency: TcxEditButtonTransparency;
begin
  Result := ebtHideInactive;
end;

function TcxTreeListNodePreviewViewInfo.GetHotTrack: Boolean;
begin
  Result := False; 
end;

function TcxTreeListNodePreviewViewInfo.GetLineCount: Integer;
begin
  Result := Preview.MaxLineCount;
end;

function TcxTreeListNodePreviewViewInfo.GetLineOffset: Integer;
begin
  Result := 0;
end;

function TcxTreeListNodePreviewViewInfo.GetMaxLineCount: Integer;
begin
  Result := Preview.MaxLineCount;
end;

procedure TcxTreeListNodePreviewViewInfo.GetTreeListEditCellParams(
  var AParams: TcxViewParams);
begin
   AParams := TreeList.Styles.GetPreviewParams(Node);
end;

function TcxTreeListNodePreviewViewInfo.IsAutoHeight: Boolean;
begin
  Result := Preview.AutoHeight;
end;

procedure TcxTreeListNodePreviewViewInfo.ShiftItem(DX, DY: Integer);
begin
  cxShiftEditViewInfoItem(Self, DX, DY);
end;

procedure TcxTreeListNodePreviewViewInfo.Update;
begin
  if not NodeViewInfo.HasPreview then Exit;
  Column.InitEditViewInfo(Self);
  DoCalculate;
end;

function TcxTreeListNodePreviewViewInfo.GetPreviewRect: TRect;
begin
  with NodeViewInfo do
  begin
    Result := cxRectSetTop(NodeContentRect, NodePreviewOffset, PreviewHeight);
    if TreeList.ViewInfo.LeftFixedBand = nil then
      Result.Left := NodeCellsRect.Left
    else
      Result.Left := NodeViewInfo.NodeIndentLeft;
  end;
end;

{ TcxTreeListNodeViewInfo }

constructor TcxTreeListNodeViewInfo.Create(AOwner: TcxTreeListNodesViewInfo);
begin
  FOwner := AOwner;
  FGroups := TList.Create;
  FCells := TList.Create;
  FIndents := TList.Create;
  FIndicator := ControlViewInfo.GetIndicatorViewInfoClass.Create(ControlViewInfo);
  FPreview := FOwner.GetNodePreviewViewInfoClass.Create(Self);
  NodeGroupEditViewInfo := TcxTreeListGroupNodeEditViewInfo.Create(Self);
end;

destructor TcxTreeListNodeViewInfo.Destroy;
begin
  try
    FreeAndNil(NodeGroupEditViewInfo);
    Clear;
    FreeAndNil(FPreview);
    FreeAndNil(FIndicator);
    FreeAndNil(FGroups);
    FreeAndNil(FIndents);
    FreeAndNil(FCells);
  finally
    inherited Destroy;
  end;
end;

procedure TcxTreeListNodeViewInfo.AssignLayoutTo(ADest: TcxTreeListNodeViewInfo);

  procedure AssignObjectLists(ASrc, ADest: PPointerList; ACount: Integer);
  var
    I: Integer;
  begin
    for I := 0 to ACount - 1 do
      TcxCustomViewInfoItem(ADest^[I]).Assign(TcxCustomViewInfoItem(ASrc^[I]));
  end;

begin
  ADest.ReallocateData;
  AssignObjectLists(FGroups.List, ADest.FGroups.List, FGroups.Count);
  AssignObjectLists(FCells.List, ADest.FCells.List, FCells.Count);
  ADest.Top := Top;
  ADest.Left := Left;
  ADest.NodeCellsCalculated := False;
  ADest.NodeFocused := False;
  ADest.NodeHasButton := False;
  ADest.NodeHasPreview := False;
  ADest.NodeSelected := False;
  ADest.NodeVisible := False;
  ADest.NodeIsExpanded := False;
  ADest.NodeBorders := NodeBorders;
  ADest.CellsMaxHeight := CellsMaxHeight;
  ADest.NodeContentRect := NodeContentRect;
  ADest.NodeCellsRect := NodeCellsRect;
  ADest.NodeFocusedCell := nil;
end;

procedure TcxTreeListNodeViewInfo.Clear;
begin
  cxCheckObjectList(FGroups, 0, nil, nil);
  cxCheckObjectList(FIndents, 0, nil, nil);
  cxCheckObjectList(FCells, 0, nil, nil);
end;

procedure TcxTreeListNodeViewInfo.DoCalculate;
var
  I: Integer;
begin
  NodeHasButton := OptionsView.Buttons and Node.HasChildren;
  NodeIsGroup := TreeList.DoIsGroupNode(Node);
  NodeFocused := Node.Focused;
  NodeSelected := Node.Selected;
  if NodeHasButton then
    NodeIsExpanded := Node.Expanded
  else
    NodeIsExpanded := False;
  NodeLevel := Node.Level;
  NodeIndentLeft := DoCalculateIndentsLayout;
  NodeCellsOffset := Top;
  if Preview.Preview.Place = tlppTop then
  begin
    Preview.DoInitPreviewSettings(Top);
    NodeCellsOffset := Top + Preview.PreviewHeight;
  end;
  if not NodeIsGroup then
  begin
    for I := 0 to GroupCount - 1 do
      with Groups[I] do
      begin
        ItemViewParams := TreeList.Styles.GetBandContentParams(Band, Node);
        DoCalculate;
      end;
  end;
  if Owner.IsRowAutoHeight then DoCalculateAutoHeights;
  if Preview.Preview.Place = tlppBottom then
    Preview.DoInitPreviewSettings(Top + CellsMaxHeight);
  cxRectSetHeightEx(NodeContentRect, RealHeight);
  UpdateContentRects;
  FIndicator.FKind := GetNodeIndicatorKind;
end;

procedure TcxTreeListNodeViewInfo.DoCalculateAutoHeights;
var
  I: Integer;
  AIndent: Integer;
begin
  CellMaxHeightRefCount := 0;
  CellsMaxHeight := ControlViewInfo.DefaultEditHeight;
  if not IsGroupNode then
  begin
    AIndent := TreeList.GetLevelIndentsWidth(Node.Level, True, Node);
    for I := 0 to CellCount - 1 do
      with Cells[I] do
      begin
        CellContentRect := cxExcludeBorders(DisplayRect, Borders);
        if Column.IsLeftMost then
          Inc(CellContentRect.Left, AIndent);
        CellHeight := CalculateEditHeight;
        if CellsMaxHeight < CellHeight then
        begin
          CellMaxHeightRefCount := 1;
          CellsMaxHeight := CellHeight;
        end
        else
          if CellHeight = CellsMaxHeight then Inc(CellMaxHeightRefCount);
      end;
  end
  else
  begin
    with NodeGroupEditViewInfo do
      CheckClipping(cxRectSetXPos(NodeCellsRect, NodeIndentLeft, NodeCellsRect.Right), NodeClipRect);
    CellsMaxHeight := cxMax(NodeGroupEditViewInfo.CalculateEditHeight, CellsMaxHeight);
  end;
  TreeList.DoOnGetNodeHeight(Node, CellsMaxHeight);
  if CellMaxHeightRefCount = 0 then Inc(CellMaxHeightRefCount);
end;

procedure TcxTreeListNodeViewInfo.DoCalculateCellsViewInfo;
var
  I: Integer;
begin
  if not IsGroupNode then
    for I := 0 to CellCount - 1 do Cells[I].DoCalculate
  else
    NodeGroupEditViewInfo.DoCalculate;
  NodeCellsCalculated := True;
end;

procedure TcxTreeListNodeViewInfo.DoCalculateImageIndents(var ALeft: Integer);

  procedure AddImageIndent(HasImages: Boolean; var Index: Integer; AType: Integer);
  begin
     if not HasImages then Exit;
     with Indents[Index] do
     begin
       IndentIsLevel := False;
       IndentBorders := [];
       IndentImageIndex := Node.GetNodeImageIndex(AType);
       IndentStateImage := AType = Byte(tlitStateIndex);
       if IndentStateImage then
         IndentImageList := TreeList.StateImages
       else
         IndentImageList := TreeList.Images;
       ItemViewParams := TreeList.Styles.GetIndentParams(Self.Node, Index);
       DisplayRect := Rect(ALeft - TreeList.GetImageIndentWidth(
         TcxTreeListImageIndexType(AType)), Self.Top, ALeft, Self.Top + RealHeight);
       Dec(ALeft, TreeList.FMaxIndentWidth);
       IndentHasImage := cxInRange(IndentImageIndex, 0, IndentImageList.Count - 1);
     end;
     Dec(Index);
  end;

var
  AIndex: Integer;
begin
  AIndex := IndentCount - 1;
  with OptionsView do
  begin
    AddImageIndent(HasImages(Node), AIndex, Byte(Node.Selected));
    AddImageIndent(HasStateImages(Node), AIndex, Byte(tlitStateIndex));
  end;
end;

function TcxTreeListNodeViewInfo.DoCalculateIndentsLayout: Integer;
var
  ANode: TcxTreeListNode;
  I, AIndentCount, ANextIndentCount, ALeft: Integer;
begin
  with TreeList do
  begin
    Result := Groups[0].DisplayRect.Left + GetLevelIndentsWidth(NodeLevel, True, Node);
    AIndentCount := GetLevelIndentCount(NodeLevel, True, Node);
    if AIndentCount = 0 then
    begin
      cxCheckObjectList(FIndents, 0, nil, nil);
      Exit;
    end;
    cxCheckObjectList(FIndents, AIndentCount, Self.Owner.GetIndentViewInfoItemClass,  Self);
    Inc(NodeLevel, Byte(OptionsView.ShowRoot));
    ANextIndentCount := -1;
    ANode := Node.GetNextVisible;
    if ANode <> nil then
      ANextIndentCount := GetLevelIndentCount(ANode.Level, True, ANode);
    ANode := Node;
    ALeft := Result;
    DoCalculateImageIndents(ALeft);
    for I := NodeLevel - 1 downto 0 do
      CalculateIndentInfo(Indents[I], ANode, I, ALeft);
    if OptionsView.GridLines in [tlglBoth, tlglHorz] then
    begin
      for I := 0 to AIndentCount - 1 do
        if (I >= ANextIndentCount) then
          Indents[I].IndentBorders := [bBottom]
        else
          Indents[I].IndentBorders := []
    end;
  end;
end;

procedure TcxTreeListNodeViewInfo.DoCalculateIndentsViewInfo;
var
  I: Integer;
begin
  for I := 0 to IndentCount - 1 do
    Indents[I].DoCalculate;
end;

// main calculate layout cells in nodes used for template viewinfo and
// that be assigned to another NodeViewInfo

procedure TcxTreeListNodeViewInfo.DoCalculateLayout;
var
  AOfs, I, AIndex, ACellIndex: Integer;
  AMin, AMax: Integer;
  APrev: TcxTreeListBandViewInfo;

  procedure DoCalculateLayoutCellsInBand(AInfo: TcxTreeListBandViewInfo);
  var
    I: Integer;
    AGroup: TcxTreeListCellsGroupViewInfo;
    AIsLeft: Boolean;
  begin
    if AInfo = nil then Exit;
    AIsLeft := (APrev = nil) or (APrev.Fixed <> tlbfNone) or (AInfo.Fixed <> tlbfNone);
    if AIsLeft then
    begin
      AOfs := AInfo.DisplayRect.Left;
      NodeCellsRect.Left :=  AOfs;
    end
    else
      Dec(AOfs);
    AGroup := AddGroup(AInfo, AIndex, AOfs);
    with AGroup do
    begin
      Borders := GridLineBorders[Self.OptionsView.GridLines];
      FirstIndex := ACellIndex;
      for I := 0 to AInfo.ColumnCount - 1 do
        AddCell(AInfo.Columns[I], AIndex, ACellIndex);
      LastIndex := ACellIndex;
      cxSetMin(Left, DisplayRect.Left);
      CheckClipping(DisplayRect, GetVisibleRect(Fixed));
      DoCalculateCellsLayout;
      AOfs := DisplayRect.Right;
      NodeCellsRect.Right := AOfs;
      Exclude(Borders, bTop);
      if AInfo.Band.IsLeftMost and not (bBottom in Borders) then Exclude(Borders, bLeft);
    end;
    APrev := AInfo;
  end;

begin
  ReallocateData;
  Top := Owner.ClipRect.Top;
  Left := MaxInt;
  NodeContentRect := Owner.ClipRect;
  if OptionsView.Indicator then
    Dec(NodeContentRect.Left, OptionsView.IndicatorWidth);
  with ControlViewInfo do
  begin
    AIndex := 0;
    ACellIndex := 0;
    APrev := nil;
    DoCalculateLayoutCellsInBand(LeftFixedBand);
    for I := 0 to BandCount - 1 do
      DoCalculateLayoutCellsInBand(Bands[I]);
    DoCalculateLayoutCellsInBand(RightFixedBand);
    NodeBorders := Groups[0].Borders;
    if bRight in Groups[GroupCount - 1].Borders then
      Include(NodeBorders, bRight);
  end;
  if not Owner.IsRowAutoHeight then
  begin
    cxRectMinMaxInit(AMin, AMax);
    for I := 0 to CellCount - 1 do
      cxRectMinMaxHeight(Cells[I].DisplayRect, AMax, AMin);
    CellsMaxHeight := AMax - AMin;
  end
  else
    CellsMaxHeight := 0;
  NodeContentRect.Right := cxMin(Owner.ClipRect.Right, NodeCellsRect.Right);
end;

procedure TcxTreeListNodeViewInfo.DoHorzOffset(AShift: Integer);
var
  I: Integer;
  R: TRect;
begin
  if not IsGroupNode then
  begin
    for I := Byte(LeftFixedGroup <> nil) to GroupCount - Byte(RightFixedGroup <> nil) - 1 do
      Groups[I].DoHorzOffset(AShift);
  end
  else
     R := NodeGroupEditViewInfo.GetCellRect;
  if not Groups[GroupCount - 1].Fixed then
    Inc(NodeCellsRect.Right, AShift);
  if not Groups[0].Fixed then
  begin
    Inc(NodeCellsRect.Left, AShift);
    for I := 0 to IndentCount - 1 do Indents[I].DoHorzOffset(AShift);
  end;
  UpdateClipping;
  Preview.DoCalculate;
  if IsGroupNode then
  begin
    with NodeGroupEditViewInfo do
    begin
      CheckClipping(GetCellRect, NodeContentRect);
      DoCalculate;
    end;
  end; 
end;

procedure TcxTreeListNodeViewInfo.DoVertOffset(AShift: Integer);
var
  I: Integer;
begin
  if (AShift = 0) and NodeCellsCalculated then Exit;
  Inc(NodePreviewOffset, AShift);
  Inc(NodeCellsOffset, AShift);
  OffsetRect(NodeContentRect, 0, AShift);
  OffsetRect(NodeCellsRect, 0, AShift);
  UpdateClipping;
  if not IsGroupNode then
    for I := 0 to GroupCount - 1 do
      Groups[I].DoVertOffset(AShift);
  for I := 0 to IndentCount - 1 do
    Indents[I].DoVertOffset(AShift);
  DoCalculateIndentsViewInfo;
  if not IsGroupNode then
    cxCalcSeparators(Separators, ControlViewInfo.FSeparators, NodeCellsRect)
  else
    NodeGroupEditViewInfo.ShiftItem(0, AShift);
  FIndicator.Calculate(ContentRect, NodeContentRect);
  Preview.DoCalculate;
end;

function TcxTreeListNodeViewInfo.GetNodeIndicatorKind: TcxIndicatorKind;

  function IsMultiSelect: Boolean;
  begin
    Result := TreeList.SelectionCount > 1;
  end;

begin
  Result := ikNone;
  if Focused then
  begin
    if Selected and IsMultiSelect then
      Result := ikMultiArrow
    else
      Result := ikArrow;
    if TreeList.IsNodeEdited(Node) then
      Result := ikEdit
    else
      if TreeList.IsNodeInserted(Node) then
        Result := ikInsert
  end
  else
    if Selected then Result := ikMultiDot;
end;

procedure TcxTreeListNodeViewInfo.Update(ARecalculate: Boolean = False);

  function ChangeState(var APrevState: Boolean; AState, ACheckPrev: Boolean): Boolean;
  begin
    Result := (ACheckPrev and APrevState) or (AState <> APrevState);
    APrevState := AState;
  end;

var
  I: Integer;
  ARecalculateOnFocusChanged, NeedUpdate: Boolean;
begin
  NeedUpdate := Node.Focused;
  ARecalculateOnFocusChanged := (NodeFocused <> NeedUpdate);
{$B+}
  NeedUpdate := ChangeState(NodeFocused, NeedUpdate, True) or
    ChangeState(NodeSelected, Node.Selected, not Owner.CheckSelectionMode);
{$B-}
  ARecalculateOnFocusChanged := ARecalculate or ARecalculateOnFocusChanged;
  if NeedUpdate or NodeFocused or ARecalculate then
  begin
    for I := 0 to IndentCount - 1 do
      with Indents[I] do 
      begin
        ItemViewParams := TreeList.Styles.GetIndentParams(Self.Node, I);
        DoCalculate;
      end;
    NeedUpdate := False;
    if not IsGroupNode then
      for I := 0 to CellCount - 1 do
        NeedUpdate := NeedUpdate or Cells[I].Refresh(ARecalculateOnFocusChanged)
    else
      NeedUpdate := NeedUpdate or NodeGroupEditViewInfo.Refresh(ARecalculateOnFocusChanged);
    NeedUpdate := NeedUpdate or (HasPreview and Preview.Refresh(ARecalculateOnFocusChanged));
    if NeedUpdate then
      TreeList.LayoutChanged
    else
    begin
      UpdateImageIndexes;
      Owner.Owner.InvalidateRect(NodeContentRect);
    end;
  end;
  Indicator.FKind := GetNodeIndicatorKind;
end;

procedure TcxTreeListNodeViewInfo.UpdateClipping;
begin
  NodeClipRect := NodeCellsRect;
  NodeClipRect.Right := cxMin(Owner.ClipRect.Right, NodeClipRect.Right);
  NodeVisible := cxRectIntersect(NodeClipRect, NodeContentRect, Owner.ClipRect);
end;

procedure TcxTreeListNodeViewInfo.UpdateImageIndexes;
var
  AIndex: Integer;
begin
  AIndex := IndentCount - 1;
  while AIndex >= 0 do
    with Indents[AIndex] do
    begin
      if not IsLevel then
        UpdateImageIndex
      else
        Break;
      Dec(AIndex)
    end;
end;

procedure TcxTreeListNodeViewInfo.UpdatePostCalculate(ATop, AIndex: Integer);
begin
  Indicator.FNode := Node; 
  Index := AIndex;
  UpdateLinks;
  DoVertOffset(ATop - Top);
  if not NodeCellsCalculated then
    DoCalculateCellsViewInfo
  else
    UpdateClipping;
  Top := ATop;
end;

procedure TcxTreeListNodeViewInfo.ReallocateData;
begin
  with Owner, TreeList do
  begin
    cxCheckObjectList(FGroups, VisibleBandCount, GetGroupViewInfoItemClass,  Self);
    cxCheckObjectList(FCells, VisibleColumnCount, GetEditCellViewInfoItemClass, Self);
  end;
end;

function TcxTreeListNodeViewInfo.GetCell(Index: Integer): TcxTreeListEditCellViewInfo;
begin
  Result := TcxTreeListEditCellViewInfo(FCells.List^[Index]);
end;

function TcxTreeListNodeViewInfo.GetCellCount: Integer;
begin
  Result := FCells.Count;
end;

function TcxTreeListNodeViewInfo.GetControlViewInfo: TcxTreeListViewInfo;
begin
  Result := Owner.Owner;
end;

function TcxTreeListNodeViewInfo.GetFocusRect: TRect;
begin
  if Focused and (GroupCount > 0) then
  begin
    if NodeFocusedCell <> nil then
      Result := NodeFocusedCell.CellContentRect
    else
    begin
      Result := NodeCellsRect;
      cxRectSetTopEx(Result, NodeContentRect);
      Result := cxExcludeBorders(Result, NodeBorders);
    end;
  end
  else
    Result := cxInvalidRect;
end;

function TcxTreeListNodeViewInfo.GetGroup(Index: Integer): TcxTreeListCellsGroupViewInfo;
begin
  Result := TcxTreeListCellsGroupViewInfo(FGroups.List^[Index]);
end;

function TcxTreeListNodeViewInfo.GetGroupCount: Integer;
begin
  Result := FGroups.Count;
end;

function TcxTreeListNodeViewInfo.GetIndent(Index: Integer): TcxTreeListIndentViewInfo;
begin
  Result := TcxTreeListIndentViewInfo(FIndents.List^[Index]);
end;

function TcxTreeListNodeViewInfo.GetHotTrack: Boolean;
begin
  Result := Node.HotTrack;
end;

function TcxTreeListNodeViewInfo.GetIndentCount: Integer;
begin
  Result := FIndents.Count;
end;

function TcxTreeListNodeViewInfo.GetIndentWidth: Integer;
begin
  Result := Owner.IndentWidth;
end;

function TcxTreeListNodeViewInfo.GetOptionsView: TcxTreeListOptionsView;
begin
  Result := TreeList.OptionsView;
end;

function TcxTreeListNodeViewInfo.GetRealHeight: Integer;
begin
  Result := CellsMaxHeight + Byte(HasPreview) * Preview.PreviewHeight;
end;

function TcxTreeListNodeViewInfo.GetTreeList: TcxCustomTreeListControl;
begin
  Result := Owner.TreeList;
end;

function TcxTreeListNodeViewInfo.GetVisibleIndex: Integer;
begin
  Result := Node.FVisibleIndex;  
end;

function TcxTreeListNodeViewInfo.AddGroup(AInfo: TcxTreeListBandViewInfo;
  var AIndex, AOfs: Integer): TcxTreeListCellsGroupViewInfo;
begin
  Result := Groups[AIndex];
  Result.DisplayRect :=
    cxRect(AOfs, Top, AInfo.DisplayRect.Right, NodeContentRect.Bottom);
  Result.BandViewInfo := AInfo;
  Result.IsOpaque := AInfo.IsOpaque;
  Inc(AIndex);
end;

function TcxTreeListNodeViewInfo.GetVisibleRect(AFixed: Boolean): TRect;
begin
  if AFixed then
    Result := Owner.ClipRect
  else
    Result := Owner.ScrollRect;
end;

procedure TcxTreeListNodeViewInfo.AddCell(
  AInfo: TcxTreeListColumnViewInfo; var AGroupIndex, AIndex: Integer);
begin
//  if (AIndex < 0) or (AIndex >= CellCount) then Exit;
  with Cells[AIndex] do
  begin
    GroupIndex := AGroupIndex - 1;
    FColumnViewInfo := AInfo;
  end;
  Inc(AIndex);
end;

procedure TcxTreeListNodeViewInfo.CalculateIndentInfo(AIndent: TcxTreeListIndentViewInfo;
  var ANode: TcxTreeListNode; ALevel: Integer; var ALeft: Integer);
begin
  with AIndent do
  begin
    IndentLevelNode := ANode;
    IndentIsLevel := True;
    IndentLevel := ALevel;
    IndentTreeLines := [];
    IndentBorders := [];
    IndentHasExpandButton := (ANode = Self.Node) and NodeHasButton;
    IndentTreeLines := [];
    if OptionsView.TreeLineStyle <> tllsNone then
    begin
      IndentTreeLines := [tltVertUp];
      if ANode = Self.Node then
        Include(IndentTreeLines, tltHorz);
      if ANode.FNext <> nil then
        Include(IndentTreeLines, tltVertDown)
      else
        if ((ANode <> Self.Node) and (ANode.Parent <> Self.Node.Parent)) then
          Exclude(IndentTreeLines, tltVertUp);
       if (ANode = ViewInfoNode) and (ANode = ANode.Owner.Root.FFirst) then
         Exclude(IndentTreeLines, tltVertUp);
    end;
  end;
  with TreeList do
    AIndent.ItemViewParams := Styles.GetIndentParams(Self.Node, ALevel);
  AIndent.DisplayRect := Rect(ALeft - IndentWidth, Top, ALeft, Top + RealHeight);
  Dec(ALeft, IndentWidth);
  ANode := ANode.Parent;
end;

procedure TcxTreeListNodeViewInfo.UpdateContentRects;

  procedure SetLeftMostIndent(AGroup: TcxTreeListCellsGroupViewInfo);
  var
    I: Integer;
  begin
    AGroup.SetSize(NodeCellsOffset, CellsMaxHeight);
    for I := 0 to AGroup.CellCount - 1 do
      with AGroup.Cells[I] do
      begin
        if DisplayRect.Left = AGroup.DisplayRect.Left then
          DisplayRect.Left := NodeIndentLeft;
      end;
    AGroup.DisplayRect.Left := NodeIndentLeft;
  end;

var
  I: Integer;
begin
  NodeCellsRect.Left := NodeIndentLeft;
  if not IsGroupNode then
  begin
    SetLeftMostIndent(Groups[0]);
    cxRectSetTopEx(NodeCellsRect, NodeCellsOffset, CellsMaxHeight);
    cxRectSetTopEx(NodeContentRect, Top, RealHeight);
    for I := 1 to GroupCount - 1 do
      Groups[I].SetSize(NodeCellsOffset, CellsMaxHeight);
  end;
  for I := 0 to IndentCount - 1 do
    cxRectSetHeightEx(Indents[I].DisplayRect, RealHeight);
end;

procedure TcxTreeListNodeViewInfo.UpdateLinks;

  function GetNodeViewInfo(AIndex: Integer): TcxTreeListNodeViewInfo;
  begin
    with Owner do
      if (AIndex = cxInvalidIndex) or (AIndex >= Count) then
        Result := nil
      else
        Result := Nodes[AIndex];
  end;

  function CheckFixed(AGroup: TcxTreeListCellsGroupViewInfo;
    AKind: TcxTreeListBandFixedKind): TcxTreeListCellsGroupViewInfo;
  begin
    if AGroup.Band.FixedKind = AKind then
      Result := AGroup
    else
      Result := nil;
  end;

begin
  NodeNextVisible := GetNodeViewInfo(Index + 1);
  NodePrevVisible := GetNodeViewInfo(Index - 1);
  if (GroupCount > 0) and not IsGroupNode then
  begin
    LeftFixedGroup := CheckFixed(Groups[0], tlbfLeft);
    RightFixedGroup := CheckFixed(Groups[GroupCount - 1], tlbfRight);
  end;
end;

{ TcxTreeListNodesViewInfo }

constructor TcxTreeListNodesViewInfo.Create(AOwner: TcxTreeListViewInfo);
begin
  FOwner := AOwner;
end;

destructor TcxTreeListNodesViewInfo.Destroy;
begin
  try
    Clear;
    FreeMem(FNodes);
  finally
    inherited Destroy;
  end;
end;

procedure TcxTreeListNodesViewInfo.Add(ANode: TcxTreeListNode; var AHeight: Integer);
var
  AViewInfo: TcxTreeListNodeViewInfo;
begin
  AViewInfo := AddNode(ANode);
  if IsAddFirst and (Count > 1) then
  begin
    System.Move(FNodes^[0], FNodes^[1], (Count - 1) * SizeOf(Pointer));
    FNodes^[0] := AViewInfo;
  end;
  Template.AssignLayoutTo(AViewInfo);
  with AViewInfo do
  begin
    AViewInfo.DoCalculate;
    AHeight := RealHeight;
  end;
end;

function TcxTreeListNodesViewInfo.AddNode(
  ANode: TcxTreeListNode): TcxTreeListNodeViewInfo;
var
  ACapacity: Integer;
begin
  if FNodesCount > Count then
    Result := TcxTreeListNodeViewInfo(FNodes^[Count])
  else
  begin
    Result := GetNodeViewInfoClass.Create(Self);
    Inc(FNodesCount);
    ACapacity :=
      ((FNodesCount + cxMinCapacityInc) div cxMinCapacityInc) * cxMinCapacityInc;
    if ACapacity > FCapacity then
    begin
      FCapacity := ACapacity;
      ReallocMem(FNodes, FCapacity * SizeOf(Pointer));
    end;
    FNodes^[Count] := Result;
  end;
  Result.ViewInfoNode := ANode;
  Inc(Count);
end;

procedure TcxTreeListNodesViewInfo.BeforeShowEdit;
begin
  PostViewInfoUpdate;
end;

procedure TcxTreeListNodesViewInfo.CalculatePreviewHeight;
begin
  with TreeList.Preview do
  begin
    if Active then
    begin
      Self.Owner.PreviewHeight := Column.GetEditDefaultHeight(
        TreeList.Styles.GetPreviewParams(TreeList.Nodes.Root.FFirst).Font);
      Self.Owner.PreviewHeight := Self.Owner.PreviewHeight {* MaxLineCount};
    end;
  end; 
end;

procedure TcxTreeListNodesViewInfo.CancelUpdatePost;
begin
  FUpdatePost := False; 
end;

procedure TcxTreeListNodesViewInfo.ChangeDirection;
begin
  IsAddFirst := not IsAddFirst;
end;

procedure TcxTreeListNodesViewInfo.Clear;
var
  I: Integer;
begin
  try
    for I := 0 to FNodesCount - 1 do
      FreeAndNil(TObject(FNodes^[I]));
    FreeMem(FNodes);
  finally
    FreeAndNil(Template);
    if not TreeList.IsDestroying then ClearState;
    TopNode := nil;
    VisibleCount := 0;
    Count := 0;
    FNodes := nil;
    FNodesCount := 0;
    FCapacity := 0;
  end;
end;

procedure TcxTreeListNodesViewInfo.ClearState;
begin
  IsAddFirst := False;
  Count := 0;
  VisibleCount := 0;
  IsRowAutoHeight := OptionsView.CellAutoHeight and (TreeList.HeaderLineCount = 1);
  with TreeList.Nodes do
  begin
    Self.TopNode := TopVisibleNode;
    TopIndex := TopIndex;
  end;
end;

procedure TcxTreeListNodesViewInfo.DoCalculate(AFullRecalculate: Boolean = True);
begin
  ClearState;
  IndentWidth := TreeList.FLevelIndentWidth;
  with Owner do
  begin
    ClipRect := ContentRect;
    cxRectIntersect(ScrollRect, ContentRect, ScrollingArea);
  end;
  SpaceArea := Owner.CellsRect;
  SpaceArea.Left := Owner.BorderSize;
  TopNode := TreeList.Nodes.TopNode;
  if (TopNode = nil) or (TreeList.VisibleBandCount = 0) or (TreeList.VisibleColumnCount = 0) then
  begin
    VisibleCount := 0;
    Exit;
  end; 
  CalculatePreviewHeight;
  if AFullRecalculate then
  begin
    if Template = nil then Template := GetNodeViewInfoClass.Create(Self);
    Template.DoCalculateLayout;
  end;
  NodesBottom := Owner.CellsRect.Top;
  ProcessNodes(TopNode, True);
end;

procedure TcxTreeListNodesViewInfo.DoCalculateNextPage(AGoForward: Boolean);
begin
  TreeList.Controller.DoShowNextPageEx(AGoForward, False, []);
end;

procedure TcxTreeListNodesViewInfo.DoHorzOffset(AShift: Integer);

  procedure DoOffsetGroup(AGroup: TcxTreeListCellsGroupViewInfo);
  var
    I: Integer;
  begin
    with AGroup do
    begin
      if Band.FixedKind <> tlbfNone then Exit;
      OffsetRect(DisplayRect, AShift, 0);
      for I := 0 to CellCount - 1 do
        OffsetRect(Cells[I].DisplayRect, AShift, 0);
    end;
  end;

var
  I: Integer;
begin
  if Count = 0 then Exit; 
  for I := 0 to Count - 1 do
    Nodes[I].DoHorzOffset(AShift);
  with Template do
    for I := 0 to GroupCount - 1 do DoOffsetGroup(Groups[I]);
end;

procedure TcxTreeListNodesViewInfo.DoCalculateShiftUp(
  ALineCount: Integer);
var
  I: Integer;
begin
  for I := 0 to ALineCount - 1 do
    Dec(NodesBottom, MoveFirstToLatest(False));
  if Count > 0 then
    TopNode := Nodes[0].Node;
  ProcessNodes(GetNextNodeFromViewInfo(Count - 1), True);
end;

procedure TcxTreeListNodesViewInfo.DoCalculateShiftDown(ALineCount: Integer);
var
  I: Integer;
  ANode: TcxTreeListNode;
  IsBreak: Boolean;
begin
  IsAddFirst := True;
  if ALineCount > 0 then
  begin
    NeedViewInfoUpdatePost;
    ANode := GetNextNodeFromViewInfo(0);
    for I := 1 to ALineCount do
    begin
      IsAddFirst := True;
      IsBreak := False;
      if ANode <> nil then
      begin
        NodesBottom := 0;
        ProcessAddNode(ANode, IsBreak);
      end
      else
        Break;
      TopNode := Nodes[0].Node;
    end;
  end;
end;

procedure TcxTreeListNodesViewInfo.DoVertOffset(AShift: Integer);
begin
  if AShift = 0 then Exit;
  if TreeList.IsLocked then
    TreeList.Nodes.SetTopVisibleIndex(TopVisibleIndex + AShift)
  else
  begin
    if Abs(AShift) >= Count then
    begin
      TreeList.Nodes.SetTopVisibleIndex(TopVisibleIndex + AShift);
      DoCalculate(False);
      Owner.InvalidateRect(ClipRect);
    end
    else
    begin
      if AShift > 0 then
      begin
        TreeList.Nodes.SetTopVisibleIndex(TopVisibleIndex + AShift);
        DoCalculate(False);
        Owner.InvalidateRect(ClipRect);
      end
      else
        DoCalculateShiftDown(Abs(AShift));
    end;
  end;
end;

function TcxTreeListNodesViewInfo.FindNodeViewInfo(
  ANode: TcxTreeListNode; var AViewInfo: TcxTreeListNodeViewInfo): Boolean;
var
  AIndex: Integer;
begin
  Result := ANode <> nil;
  if not Result then Exit; 
  with ANode do
    AIndex := VisibleIndex - TopVisibleIndex;
  Result := (AIndex >= 0) and (AIndex < Count);
  if Result then AViewInfo := Nodes[AIndex];
  Result := Result and (ANode = AViewInfo.Node);
end;

procedure TcxTreeListNodesViewInfo.FocusedRecordChanged(
  APrevNode, ANewNode: TcxTreeListNode);
var
  AViewInfo: TcxTreeListNodeViewInfo;
begin
  if (APrevNode <> ANewNode) and not TreeList.IsLocked then
  begin
    if FindNodeViewInfo(APrevNode, AViewInfo) then AViewInfo.Update;
    if FindNodeViewInfo(ANewNode, AViewInfo) then AViewInfo.Update;
    FNeedUpdatePos := True;
  end;
end;

procedure TcxTreeListNodesViewInfo.MakeNodeVisible(ANode: TcxTreeListNode);
var
  AViewInfo: TcxTreeListNodeViewInfo;
begin
  if (ANode = nil) or not ANode.IsVisible or
    (FindNodeViewInfo(ANode, AViewInfo) and (AViewInfo.Index < VisibleCount)) then Exit;
  if ANode.FVisibleIndex <= TopVisibleIndex then
    TreeList.SetTopVisibleNode(ANode)
  else
    if (ANode.FVisibleIndex - TopVisibleIndex) = VisibleCount then
      Owner.DoScrollVertical(1)
    else
      SetLastVisibleNode(ANode);
end;

function TcxTreeListNodesViewInfo.MoveFirstToLatest(
  ACheckedOne: Boolean = True): Integer;
var
  AItem: Pointer;
begin
  Result := 0;
  if Count < 1 then Exit;  
  if (ACheckedOne and (Count > 1)) or not ACheckedOne then
  begin
    AItem := FNodes^[0];
    Dec(Count);
    if Count > 0 then
    begin
      System.Move(FNodes^[1], FNodes^[0], Count * SizeOf(Pointer));
      FNodes^[Count] := AItem;
    end;
    Result := TcxTreeListNodeViewInfo(AItem).RealHeight;
  end;
end;

procedure TcxTreeListNodesViewInfo.NeedUpdatePost;
begin
  FUpdatePost := True;
end;

procedure TcxTreeListNodesViewInfo.NeedViewInfoUpdatePost;
begin
  FNeedSynchronize := True;
  FNeedUpdatePos := True;
end;

function TcxTreeListNodesViewInfo.PostViewInfoUpdate: Boolean;
begin
  if FNeedUpdatePos then
  begin
    UpdatePostCalculate;
    FNeedUpdatePos := False;
    TreeList.HitTest.Recalculate;
    Result := True;
    TreeList.DoChanged;
  end
  else
    Result := False;
end;

procedure TcxTreeListNodesViewInfo.PostUpdate;
begin
  if FUpdatePost then UpdateSelectedNodes;
end;

procedure TcxTreeListNodesViewInfo.ProcessNodes(
  ATopNode: TcxTreeListNode; ANeedLastVisible: Boolean);
var
  ANode: TcxTreeListNode;
  PrevH: Integer;
  IsBreak: Boolean;
begin
  if (TreeList.VisibleColumnCount = 0) or (TopNode = nil) then
  begin
    VisibleCount := 0;
    Exit;
  end;
  NeedViewInfoUpdatePost;
  TreeList.Controller.EditingController.PostEditUpdate;
  try
    ANode := ATopNode;
    IsBreak := False;
    PrevH := 0;
    repeat
      while (ANode <> nil) and not IsBreak do
        PrevH := ProcessAddNode(ANode, IsBreak);
      if (ANode = nil) and not IsBreak then
      begin
        ChangeDirection;
        ANode := GetNextNodeForProcess
      end;
      if IsBreak and ANeedLastVisible and IsAddFirst then
      begin
        Dec(NodesBottom, PrevH);
        IsBreak := NodesBottom > ClipRect.Bottom;
        MoveFirstToLatest;
        ChangeDirection;
        ANode := GetNextNodeForProcess;
        if IsAddFirst then Break;
      end;
    until (ANode = nil) or IsBreak or (Count = TreeList.Nodes.VisibleCount);
    VisibleCount := Count;
    if IsBreak and (Count > 1) then Dec(VisibleCount);
    if Count > 0 then
      TopNode := Nodes[0].Node;

  finally
    IsAddFirst := False;
  end;
end;

procedure TcxTreeListNodesViewInfo.SetLastVisibleNode(ANode: TcxTreeListNode);
begin
  IsAddFirst := True;
  NodesBottom := ClipRect.Top;
  Count := 0;
  VisibleCount := 0;
  ProcessNodes(ANode, True);
  Owner.InvalidateScrollRect(dsdVert);
  UpdatePostCalculate;
  SynchronizeTopNode;
end;

procedure TcxTreeListNodesViewInfo.SynchronizeTopNode;
begin
  with TreeList.Nodes do
  begin
    TopNode := Self.TopNode;
    if TopNode <> nil then
      TopIndex := TopNode.VisibleIndex;
    TreeList.VScrollBar.Position := TopIndex;
    if Self.VisibleCount < VisibleCount then
      TreeList.VScrollBar.PageSize := Self.VisibleCount;
    FNeedSynchronize := False;
  end;
end;

procedure TcxTreeListNodesViewInfo.UpdatePostCalculate;
var
  I: Integer;
begin
  NodesBottom := ClipRect.Top;
  VisibleCount := 0;
  for I := 0 to Count - 1 do
  begin
    with Nodes[I] do
    begin
      UpdatePostCalculate(NodesBottom, I);
      Inc(NodesBottom, RealHeight);
      SpaceArea.Top := NodesBottom;
      if NodesBottom > Self.ClipRect.Bottom then Break;
      Inc(VisibleCount);
    end;
  end;
  if VisibleCount = 0 then VisibleCount := 1;
  if Count > VisibleCount then Count := VisibleCount + 1;
end;

procedure TcxTreeListNodesViewInfo.UpdateData;

  procedure CheckNodeIndicator(ANode: TcxTreeListNodeViewInfo);
  begin
    ANode.Indicator.UpdateKind(ANode.GetNodeIndicatorKind);
  end;

var
  I: Integer;
begin
  if OptionsView.Indicator then
  begin
    for I := 0 to Count - 1 do
      CheckNodeIndicator(Nodes[I]);
  end;
end;

procedure TcxTreeListNodesViewInfo.UpdateSelectedNodes;
var
  I: Integer;
begin
  if not TreeList.IsLocked then
  begin
    CancelUpdatePost;
    for I := 0 to Count - 1 do
      Nodes[I].Update;
    TreeList.DoChanged;
  end
  else
    NeedUpdatePost; 
end;

function TcxTreeListNodesViewInfo.GetGroupViewInfoItemClass: TcxTreeListCellsGroupViewInfoClass;
begin
  Result := TcxTreeListCellsGroupViewInfo;
end;

function TcxTreeListNodesViewInfo.GetEditCellViewInfoItemClass: TcxTreeListEditCellViewInfoClass;
begin
  Result := TcxTreeListEditCellViewInfo;
end;

function TcxTreeListNodesViewInfo.GetIndentViewInfoItemClass: TcxTreeListIndentViewInfoClass;
begin
  Result := TcxTreeListIndentViewInfo;
end;

function TcxTreeListNodesViewInfo.GetNodePreviewViewInfoClass: TcxTreeListNodePreviewViewInfoClass;
begin
  Result := TcxTreeListNodePreviewViewInfo;
end;

function TcxTreeListNodesViewInfo.GetNodeViewInfoClass: TcxTreeListNodeViewInfoClass;
begin
  Result := TcxTreeListNodeViewInfo;
end;

function TcxTreeListNodesViewInfo.GetMaxVisibleIndex: Integer;
begin
  Result := TreeList.Nodes.VisibleCount - 1;
end;

function TcxTreeListNodesViewInfo.GetNextNodeFromViewInfo(
  Index: Integer): TcxTreeListNode;
var
  ANode: TcxTreeListNode;
begin
  if Index < 0 then
    Result := nil
  else
  begin
    Result := Nodes[Index].Node;
    ANode := Result.GetNextVisibleEx(IsAddFirst);
    if ANode = nil then
    begin
      ChangeDirection;
      Result := Nodes[0].Node;
      ANode := Result.GetNextVisibleEx(IsAddFirst);
    end;
    Result := ANode;
  end;
end;

function TcxTreeListNodesViewInfo.GetNextNodeForProcess: TcxTreeListNode;
begin
  if IsAddFirst then
    Result := GetNextNodeFromViewInfo(0)
  else
    Result := GetNextNodeFromViewInfo(Count - 1);
end;

function TcxTreeListNodesViewInfo.GetNodeViewInfo(
  Index: Integer): TcxTreeListNodeViewInfo;
begin
  Result := TcxTreeListNodeViewInfo(FNodes^[Index]);
end;

function TcxTreeListNodesViewInfo.GetOptionsView: TcxTreeListOptionsView;
begin
  Result := Owner.OptionsView;
end;

function TcxTreeListNodesViewInfo.GetScrollWindow: Boolean;
begin
  Result := False;
end;

function TcxTreeListNodesViewInfo.GetTopVisibleIndex: Integer;
begin
  if TopNode <> nil then
    Result := TopNode.VisibleIndex
  else
    Result := TreeList.Nodes.TopIndex;
end;

function TcxTreeListNodesViewInfo.GetTreeList: TcxCustomTreeListControl;
begin
  Result := Owner.TreeList;
end;

function TcxTreeListNodesViewInfo.ProcessAddNode(
  var ANode: TcxTreeListNode; var IsBreak: Boolean): Integer;
begin
  IsBreak := NodesBottom > ClipRect.Bottom;
  Result := 0;
  if IsBreak then Exit;
  Add(ANode, Result);
  Inc(NodesBottom, Result);
  IsBreak := NodesBottom > ClipRect.Bottom;
  ANode := ANode.GetNextVisibleEx(IsAddFirst);
end;

{ TcxTreeListHitTest }

function TcxTreeListHitTest.CanMoving: Boolean;
var
  ADirection: TcxDragSizingDirection;
begin
  Result := (HitAtBandHeader and HitBand.CanMoving) or
     (HitAtColumnHeader and HitColumn.CanMoving) and not CanSizing(ADirection);
end;

function TcxTreeListHitTest.CanSizing: Boolean;
var
  ADir: TcxDragSizingDirection;
begin
  Result := CanSizing(ADir);
end;

type
  TcxHotTrackControllerAccess = class(TcxHotTrackController);

function TcxTreeListHitTest.CanSizing(
  var ASizeDirection: TcxDragSizingDirection): Boolean;

  function SetValue(Condition: Boolean; ADirection: TcxDragSizingDirection): Boolean;
  begin
    Result := Condition;
    if Result then ASizeDirection := ADirection;
  end;

var
  AItem: TObject;
  AIntf: IcxDragSizing;
  ARect: TRect;
begin
  Result := HitAtBandHeader or HitAtColumnHeader or HitAtNode;
  if not Result then Exit;
  if HitAtBandHeader then
    FNewHitTestItem := FHitBand.ViewInfo.FBandHeader
  else
    if HitAtColumnHeader then
       FNewHitTestItem := FHitColumn.ViewInfo.FColumnHeader;
  AItem := FNewHitTestItem;
  if not HitAtNode then
  begin
    ARect := TcxCustomViewInfoItem(FNewHitTestItem).VisibleRect;
    with ARect do
    begin
      Result := SetValue(Abs(Right - HitX) <=  cxtlHitDelta, dsdHorz) or
        SetValue(Abs(Bottom - HitY) <=  cxtlHitDelta, dsdVert)
    end;
  end
  else
  begin
    ARect := HitNode.DisplayRect(False);
    FSizingHitNode := HitNode;
    if HitNode <> TreeList.TopVisibleNode then
    begin
      if cxInRange(HitY, ARect.Top - cxtlHitDelta, ARect.Top + cxtlHitDelta) then
      begin
        FSizingHitNode := HitNode.GetPrevVisible;
        ARect := HitNode.DisplayRect(False);
      end;
    end;
    AItem := FSizingHitNode;
    with ARect do
      Result := SetValue(cxInRange(HitY, Bottom - cxtlHitDelta * 2,
        Bottom + cxtlHitDelta), dsdVert);
  end;
  Result := Result and Supports(AItem, IcxDragSizing, AIntf) and
    AIntf.CanSizing(ASizeDirection);
end;

function TcxTreeListHitTest.AllowDesignMouseEvents(
  X, Y: Integer; AShift: TShiftState): Boolean;
begin
  Result := inherited AllowDesignMouseEvents(X, Y, AShift);
  Result := Result or (TreeList.DragAndDropState <> ddsNone) or HitAtBandContainer or
    HitAtBandHeader or HitAtColumnHeader or CanSizing or HitAtButton;
end;

procedure TcxTreeListHitTest.DoCalculate;
var
  ADir: TcxDragSizingDirection;
const
   ASizingFlags: array[TcxDragSizingDirection] of Integer =
     (tlhc_HitAtSizingHorz, tlhc_HitAtSizingVert);
begin
  FHitBand := nil;
  FHitColumn := nil;
  FHitNode := nil;
  FNewHitTestItem := nil;
  try
    if not cxRectPtIn(TreeList.ClientBounds, HitPoint) then Exit;
    with ViewInfo do
    begin
      NodesViewInfo.PostViewInfoUpdate;
      if cxRectPtIn(FSeparators[0], HitPoint) or
        cxRectPtIn(FSeparators[1], HitPoint) then SetHitState(tlhc_HitAtSeparator, True);
      if not CheckHitInBands then CheckHitInNodes;
    end;
    if not (HitAtNode and HitAtColumn) then
    begin
      FNewHitTestItem := GetHitTestItem;
      if CanSizing(ADir) then SetHitState(ASizingFlags[ADir], True);
    end;
  finally
    HitTestItem := FNewHitTestItem;
  end;
end;

function TcxTreeListHitTest.Check(const ARect: TRect): Boolean;
begin
  Result := cxRectPtIn(ARect, HitPoint);
end;

function TcxTreeListHitTest.CheckHitInBands: Boolean;
var
  I: Integer;
begin
  with TreeList.OptionsView do
  begin
    Result := (HitPoint.Y <= ViewInfo.CellsOffset) or
      (Footer and (HitPoint.Y >= ViewInfo.FooterRect.Top));
  end;
  if Result then
    with ViewInfo do
    begin
      Result := CheckHitInBand(LeftFixedBand) or CheckHitInBand(RightFixedBand);
      if not Result then
        for I := 0 to FBandCount - 1 do
          if CheckHitInBand(TcxTreeListBandViewInfo(FBands^[I])) then
          begin
            Result := True;
            Break;
          end;
    end;
end;

function TcxTreeListHitTest.CheckHitInNodes: Boolean;
var
  I: Integer;
begin
  with ViewInfo.NodesViewInfo do
  begin
    Result := VisibleCount > 0;
    if Result then
    begin
      for I := 0 to Count - 1 do
      begin
        Result := CheckHitInNode(Nodes[I]);
        if Result then Break;
      end;
    end;
  end;
end;

function TcxTreeListHitTest.GetCurrentCursor: TCursor;
var
  ADirection: TcxDragSizingDirection;
const
  ACursors: array[Boolean, TcxDragSizingDirection] of TCursor =
    ((crcxHorzSize, crcxVertSize), (crHSplit, crVSplit));
begin
  Result := inherited GetCurrentCursor;
  if (TreeList.DragAndDropState = ddsInProcess) and
    not (TreeList.DragAndDropObject is TcxSizingDragAndDropObject) then Exit;
  if (Result = crDefault) and CanSizing(ADirection) then
    Result := ACursors[TreeList.DragAndDropState <> ddsNone, ADirection];
end;

function TcxTreeListHitTest.GetHitTestItem: TObject;
begin
  Result := nil;
  if HitAtBandHeader and
    cxPtInViewInfoItem(FHitBand.ViewInfo.FBandHeader, HitPoint) then
      Result := FHitBand.ViewInfo.FBandHeader;
  if HitAtColumnHeader and
    cxPtInViewInfoItem(FHitColumn.ViewInfo.FColumnHeader, HitPoint) then
      Result := FHitColumn.ViewInfo.FColumnHeader;
end;

function TcxTreeListHitTest.GetState(Index: Integer): Boolean;
begin
  Result := (HitState and (1 shl Index)) <> 0;
end;

procedure TcxTreeListHitTest.HitTestItemChanged(APrevHitTestItem: TObject);

  procedure CheckHeader(AViewInfo: TObject);
  begin
    if AViewInfo is TcxTreeListHeaderViewInfo then
      TcxTreeListHeaderViewInfo(AViewInfo).UpdateState;
  end;
  
var
  AHitPoint: TPoint;
begin
  if FLockUpdate then Exit;
  FLockUpdate := True;
  try 
    AHitPoint := HitPoint;
    if TreeList.DragAndDropState = ddsNone then
    begin
      CheckHeader(APrevHitTestItem);
      CheckHeader(HitTestItem);
    end;
    inherited HitTestItemChanged(APrevHitTestItem);
  finally
    HitPoint := AHitPoint;
    FLockUpdate := False;
  end;
end;

procedure TcxTreeListHitTest.SetHitState(Index: Integer; Value: Boolean);
begin
  if Value then
    FHitState := FHitState or (1 shl Index)
  else
    FHitState := FHitState and not (1 shl Index);
end;

procedure TcxTreeListHitTest.Update;
var
  P: TPoint;
begin
  IsMouseEvent := True;
  try
    HitTestItem := nil;
    GetCursorPos(P);
    HitPoint := TreeList.ScreenToClient(P);
  finally
    IsMouseEvent := False;
  end;
end;

function TcxTreeListHitTest.CheckHitInBand(AViewInfo: TcxTreeListBandViewInfo): Boolean;
var
  I: Integer;
begin
  Result := False;
  if AViewInfo = nil then Exit;
  with AViewInfo,  OptionsView do
  begin
    I := cxHitDelta(Band.CanSizing(dsdHorz));
    with ClipRect do
      Result := cxCheckValue(HitX, Left, Right + I);
    if Result then
    begin
      SetHitState(tlhc_HitAtBand, Result);
      FHitBand := AViewInfo.Band;
      if Bands or Headers or Footer then
      begin
         if Bands and HitInItem(BandHeader, tlhc_HitAtBandHeader, I) then Exit;
         for I := 0 to FCount - 1 do
           if CheckHitInColumn(TcxTreeListColumnViewInfo(FColumns^[I])) then Exit;
         if Headers then
           SetHitState(tlhc_HitAtBandContainer,
             cxCheckValue(HitY, ClipRect.Top, ClipRect.Bottom));
         if Footer then
           SetHitState(tlhc_HitAtFooter,
             cxCheckValue(HitY, ViewInfo.FooterOffset, ViewInfo.ClientRect.Bottom));
      end;
    end;
  end;
end;

function TcxTreeListHitTest.CheckHitInColumn(
  AViewInfo: TcxTreeListColumnViewInfo): Boolean;
var
  ADelta: Integer;
begin
  with AViewInfo, OptionsView do
  begin
    with Column do
      ADelta := cxMax(cxHitDelta(CanSizing(dsdVert)), cxHitDelta(CanSizing(dsdHorz)));
    Result := (HitInItem(ColumnFooter, tlhc_HitAtFooterItem)) or
      (Headers and HitInItem(ColumnHeader, tlhc_HitAtColumnHeader, ADelta));
    if Result then
    begin
      FHitColumn := Column;
      SetHitState(tlhc_HitAtColumn, True);
    end;
  end;
end;

function TcxTreeListHitTest.CheckHitInNode(
  AViewInfo: TcxTreeListNodeViewInfo): Boolean;
begin
  Result := HitInIndent(AViewInfo);
  if AViewInfo.IsGroupNode then
  begin
    if not Result and HitInItem(AViewInfo.NodeGroupEditViewInfo, tlhc_HitAtColumn) then
    begin
      SetHitState(tlhc_HitAtBand, True);
      FHitColumn := AViewInfo.NodeGroupEditViewInfo.Column;
      FNewHitTestItem := AViewInfo.NodeGroupEditViewInfo;
      FHitBand := TreeList.VisibleBands[0];
      Result := True;
    end
  end
  else
    Result := Result or HitInGroups(AViewInfo) or
      (AViewInfo.HasPreview and HitInItem(AViewInfo.Preview, tlhc_HitAtNodePreview));
  Result := Result or (TreeList.OptionsView.Indicator and
    HitInItem(AViewInfo.Indicator, tlhc_HitAtIndicator));
  if Result then
  begin
    SetHitState(tlhc_HitAtNode, True);
    FHitNode := AViewInfo.Node;
  end;
end;

function TcxTreeListHitTest.HitInGroup(AViewInfo: TcxTreeListCellsGroupViewInfo): Boolean;

  function CheckHitCell(ACell: TcxTreeListEditCellViewInfo): Boolean;
  begin
    Result := ACell.Visible and Check(ACell.ClipRect);
    if Result then
    begin
      SetHitState(tlhc_HitAtColumn, True);
      FHitColumn := ACell.Column;
      FNewHitTestItem := ACell;
    end;
  end;

var
  I: Integer;
begin
  with AViewInfo do
  begin
    Result := Visible and Check(ClipRect);
    if Result then
    begin
      SetHitState(tlhc_HitAtBand, True);
      FHitBand := Band;
      for I := 0 to CellCount - 1 do
        if CheckHitCell(Cells[I]) then Break;
    end;
  end;
end;

function TcxTreeListHitTest.HitInGroups(AViewInfo: TcxTreeListNodeViewInfo): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to AViewInfo.GroupCount - 1 do
    if HitInGroup(AViewInfo.Groups[I]) then
    begin
      Result := True;
      Break;
    end;
end;

function TcxTreeListHitTest.HitInIndent(AViewInfo: TcxTreeListNodeViewInfo): Boolean;
var
  I: Integer;
begin
  Result := False;
  with AViewInfo do
  begin
    for I := 0 to IndentCount - 1 do
      with Indents[I] do
      begin
        if Check(Indents[I].ClipRect) then
        begin
          SetHitState(tlhc_HitAtIndent, True);
          if not IsLevel then
            SetHitState(tlhc_HitAtImage + Byte(IndentStateImage), True)
          else
            if HasButton and Check(cxRectInflate(ButtonRect, cxtlHitDelta, cxtlHitDelta)) then
              SetHitState(tlhc_HitAtButton, True);
          if HitAtImage or HitAtStateImage then
            SetHitState(tlhc_HitAtIndent, False);
          Result := True;
          Break;
        end;
      end;
  end;
end;

function TcxTreeListHitTest.HitInItem(
  AItem: TcxCustomViewInfoItem; AState: Integer; ADelta: Integer = 0): Boolean;
begin
  Result := (AItem <> nil) and AItem.Visible and 
    cxRectPtIn(cxRectInflate(AItem.VisibleRect, 0, 0, ADelta, ADelta), HitPoint);
  if Result then SetHitState(AState, True);
end;

function TcxTreeListHitTest.GetHitAtImages: Boolean;
begin
  Result := HitAtImage or HitAtStateImage;
end;

function TcxTreeListHitTest.GetTreeList: TcxCustomTreeListControl;
begin
  Result := TcxCustomTreeListControl(Control);
end;

function TcxTreeListHitTest.GetViewInfo: TcxTreeListViewInfo;
begin
  Result := TcxTreeListViewInfo(inherited ViewInfo);
end;

{ TcxTreeListViewInfo }

constructor TcxTreeListViewInfo.Create(AOwner: TcxEditingControl);
begin
  inherited Create(AOwner);
  FooterBrush := TBrush.Create;
  GridLinesBrush := TBrush.Create;
  SeparatorBrush := TBrush.Create;
  HeaderIndicator := GetIndicatorViewInfoClass.Create(Self);
  FooterIndicator := GetIndicatorViewInfoClass.Create(Self);
  FNodesViewInfo := GetNodesViewInfoClass.Create(Self);
  SizingViewInfo := TcxTemporaryCellViewInfo.Create(Self);
end;

destructor TcxTreeListViewInfo.Destroy;
begin
  try
    FreeAndNil(SizingViewInfo);
    FreeAndNil(HeaderIndicator);
    FreeAndNil(FooterIndicator);
    FreeMem(FBands);
    FreeAndNil(FNodesViewInfo);
  finally
    FooterBrush.Free;
    GridLinesBrush.Free;
    SeparatorBrush.Free;
    inherited Destroy;
  end;
end;

procedure TcxTreeListViewInfo.InvalidateScrollRect(
  ADirection: TcxDragSizingDirection);
begin
  if (ADirection = dsdHorz) and ScrollingAreaVisible then
    InvalidateRect(ScrollingArea)
  else
    if ADirection = dsdVert then
      with NodesViewInfo.ClipRect do
        InvalidateRect(cxRectSetTop(ClientRect, Top, Bottom - Top));
end;

procedure TcxTreeListViewInfo.CalculateDefaultHeights;
var
  I: Integer;
begin
  TreeList.Styles.ContentStyleChanged;
  FooterLineHeight := 0;
  if BandLineHeight <> 0 then
    TreeList.FRealBandLineHeight := BandLineHeight;
  HeaderLineHeight := 0;
  BandLineHeight := 0;
  FillChar(FFixedBands, SizeOf(FFixedBands), 0);
  with TreeList do
  begin
    SetBandCount(VisibleBandCount);
    FBandCount := 0;
    for I := 0 to VisibleBandCount - 1 do SetBandViewParams(VisibleBands[I], I);
    HeaderLineHeight := LookAndFeelPainter.HeaderHeight(cxTextHeight(TreeList.Font));
    if VisibleColumnCount = 0 then
      TreeList.FHeaderLineCount := 0
    else
      for I := 0 to VisibleColumnCount - 1 do SetColumnViewParams(VisibleColumns[I]);
    HorzScrollInc := cxTextWidth(Font, 'W');
    if (VisibleBandCount > 0) then
      cxSetMax(BandLineHeight, LookAndFeelPainter.HeaderHeight(cxTextHeight(TreeList.Font)));
  end;
  if FooterLineHeight = 0 then
    with LookAndFeelPainter do
      FooterLineHeight := HeaderHeight(cxTextHeight(TreeList.Font)) + FooterCellBorderSize;
  inherited CalculateDefaultHeights;
  if BandLineHeight <> 0 then
    TreeList.FRealBandLineHeight := BandLineHeight;
end;

function TcxTreeListViewInfo.CalculateDefaultEditHeight: Integer;

  function GetColumnEditHeight(AColumn: TcxTreeListColumn): Integer;
  begin
    with AColumn, Styles do
    begin
      Result := GetEditDefaultHeight(ContentParams[True].Font);
      cxSetMax(Result, GetEditDefaultHeight(ContentParams[False].Font));
    end;
  end;

var
  I: Integer;
  
begin
  Result := 0;
  with TreeList do
  begin
    for I := 0 to VisibleColumnCount - 1 do
      Result := cxMax(Result, GetColumnEditHeight(VisibleColumns[I]));
    Inc(Result, OptionsView.VertIncrement + cxTreeListEditCellHeightOffset);
    Self.FDefaultRowHeight := Result + cxTextOffset;
    if Images <> nil then
      cxSetMax(Result, GetImageListHeight(Images));
    if StateImages <> nil then
      cxSetMax(Result, GetImageListHeight(StateImages));
  end;
end;

procedure TcxTreeListViewInfo.CalculateDefaultViewParams;

  function GetBitmap(AStyle: TcxStyle): TBitmap;
  begin
    if AStyle <> nil then
      Result := AStyle.Bitmap
    else
      Result := nil;
  end;

begin
  IndicatorViewParams := TreeList.Styles.GetIndicatorParams;
  with BrushManager, OptionsView, LookAndFeelPainter do
  begin
    Self.TreeLineColor := cxGetNativeColor(TreeLineColor, DefaultGridLineColor);
    GridLinesBrush.Color := cxGetNativeColor(GridLineColor, DefaultGridLineColor);
    if TreeLineColor <> clDefault then
      Self.TreeLineColor := ColorToRGB(TreeLineColor);
    SeparatorBrush.Color :=
      cxGetNativeColor(FixedSeparatorColor, DefaultFixedSeparatorColor);
    BackgroundBitmap := GetBitmap(TreeList.Styles.Background);
    FooterBitmap := GetBitmap(TreeList.Styles.Footer);
  end;
end;

procedure TcxTreeListViewInfo.CalculateHeaderFooterViewInfo;
var
  I: Integer;
  AOfs: Integer;
  R: TRect;
begin
  FScrollingArea := ClientRect;
  AOfs := cxRectWidth(ClientRect) - cxRectWidth(PrevClientRect);
  if (PrevHorzScrollSize - HorzScrollPos - HorzScrollPage) < AOfs then
  begin
    Dec(HorzScrollPos, AOfs);
    cxValidateIntDef(HorzScrollPos, 0, PrevHorzScrollSize);
  end;
  R := Rect(0, BorderSize, 0, BorderSize + BandLineHeight * OptionsView.BandLineCount +
    HeaderLineHeight * TreeList.HeaderLineCount);//CellsOffset);
  AOfs := ContentOffset;
  if LeftFixedBand = nil then Dec(AOfs, HorzScrollPos);
  if OptionsView.Footer and (TreeList.VisibleColumnCount > 0) then
  begin
    with TreeList do
    begin
      FooterColor := Styles.GetFooterParams.Color;
      FooterBrush.Color := FooterColor;
    end;
    with ClientRect, LookAndFeelPainter do
      FooterRect := cxRectInflate(cxRect(ContentOffset,  FooterOffset, Right, Bottom),
        -FooterBorderSize, -FooterBorderSize);
  end;
  for I := 0 to VisibleBandCount - 1 do
    with VisibleBands[I] do
    begin
      AOfs := CalcBandRect(R, DisplayWidth, AOfs, Fixed);
      Calculate(R, ClientRect);
    end;
  with OptionsView do
  begin
    if Indicator then Inc(HorzScrollSize, IndicatorWidth);
    if (TreeList.VisibleColumnCount = 0) and not Bands then HorzScrollSize := 0;
  end;
end;

procedure TcxTreeListViewInfo.CheckScrolling;
var
  R: TRect;
begin
  HorzScrollPage := cxRectWidth(ClientRect);
  if HorzScrollSize < (HorzScrollPage + HorzScrollPos) then
    HorzScrollPos := HorzScrollSize - HorzScrollPage;
  if HorzScrollSize <= HorzScrollPage then
  begin
    HorzScrollPos := 0;
    HorzScrollSize := 0;
  end
  else
    cxValidateIntDef(HorzScrollPos, 0, HorzScrollSize - HorzScrollPage + 1);
  FScrollingAreaVisible := cxRectIntersect(R, ClientRect, FScrollingArea) or
    (ContentRect.Right >= ClientRect.Right);
end;

procedure TcxTreeListViewInfo.DoCalculate;
begin
  inherited DoCalculate;
  IsDirty := False;
  if TreeList.VisibleBandCount <> BandCount then
  begin
    SetBandCount(TreeList.VisibleBandCount);
    CalculateDefaultHeights;
  end;
  ExpandButtonSize := LookAndFeelPainter.SmallExpandButtonSize;
  HorzScrollSize := 0;
  FillChar(FSeparators, SizeOf(FSeparators), 0);
  CalculateHeaderFooterViewInfo;
  CalculateCellRects;
  CheckScrolling;
  PrevHorzScrollSize := HorzScrollSize;
  NodesViewInfo.DoCalculate;
  HeaderRect := ClientRect;
  HeaderRect.Bottom := CellsOffset;
  cxCalcSeparators(HeaderSeparators, FSeparators, cxRectSetHeight(ClientRect, CellsOffset));
  cxCalcSeparators(FooterSeparators, FSeparators,
    cxRectInflate(cxRectSetTop(ClientRect, FooterOffset), 0, -LookAndFeelPainter.FooterBorderSize));
  HeaderIndicator.Calculate(HeaderRect, HeaderRect);
  HeaderIndicator.ItemViewParams.Color := TreeList.Styles.GetIndicatorParams().Color;
  FooterRect.Right := ContentRect.Right;
  FooterIndicator.Calculate(
    cxRectInflate(FooterRect, 0, LookAndFeelPainter.FooterBorderSize), ClientRect);
  FooterIndicator.ItemViewParams := TreeList.Styles.GetIndicatorParams;
  CalculateDefaultViewParams;
  PrevClientRect := ClientRect;
end;

procedure TcxTreeListViewInfo.DoScrollHorizontal(APos: Integer);
var
  I: Integer;
begin
  try
    for I := 0 to BandCount - 1 do
      Bands[I].DoHorzOffset(HorzScrollPos - APos);
    NodesViewInfo.DoHorzOffset(HorzScrollPos - APos); 
  finally
    HorzScrollPos := APos;
    InvalidateScrollRect(dsdHorz);
  end;
end;

procedure TcxTreeListViewInfo.DoScrollVertical(APos: Integer);
begin
  TreeList.Nodes.CalculateInfo(False);
  NodesViewInfo.DoVertOffset(APos);
  NodesViewInfo.NeedViewInfoUpdatePost;
  InvalidateScrollRect(dsdVert);
  NodesViewInfo.SynchronizeTopNode;
end;

function TcxTreeListViewInfo.GetIndicatorViewInfoClass: TcxTreeListIndicatorViewInfoClass;
begin
  Result := TcxTreeListIndicatorViewInfo;
end;

function TcxTreeListViewInfo.GetNodesViewInfoClass: TcxTreeListNodesViewInfoClass;
begin
  Result := TcxTreeListNodesViewInfo;
end;

procedure TcxTreeListViewInfo.InvalidateRect(const ARect: TRect);
begin
  with TreeList do
    if not IsLocked then InvalidateRect(ARect, False);
end;

procedure TcxTreeListViewInfo.UpdateSelection;
begin
  inherited UpdateSelection;
  NodesViewInfo.UpdateSelectedNodes;
end;

procedure TcxTreeListViewInfo.UpdateFootersViewInfo;
var
  I: Integer;
begin
  with TreeList do
  begin
    for I := 0 to ColumnCount - 1 do
      Columns[I].ViewInfo.FColumnFooter.Invalidate(False);
  end; 
end;

function TcxTreeListViewInfo.GetBand(AIndex: Integer): TcxTreeListBandViewInfo;
begin
  Result := TcxTreeListBandViewInfo(FBands^[AIndex]);
end;

function TcxTreeListViewInfo.GetBorderSize: Integer;
begin
  Result := TreeList.BorderSize;
end;

function TcxTreeListViewInfo.GetBrushManager: TcxBrushCache;
begin
  Result := TreeList.BrushCache;
end;

function TcxTreeListViewInfo.GetCellsHeight: Integer;
begin
  Result := FooterOffset - CellsOffset;
end;

function TcxTreeListViewInfo.GetCellsOffset: Integer;
begin
  with TreeList, OptionsView do
    Result := HeaderOffset + Byte(Headers) * HeaderLineHeight * HeaderLineCount;
end;

function TcxTreeListViewInfo.GetContentOffset: Integer;
begin
  with OptionsView do
    Result := BorderSize + Byte(Indicator) * IndicatorWidth;
end;

function TcxTreeListViewInfo.GetDefaultHeight: Integer;
begin
  Result := DefaultEditHeight;
  if TreeList.FDefaultRowHeight <> 0 then
    Result := TreeList.FDefaultRowHeight;
end;

function TcxTreeListViewInfo.GetFooterOffset: Integer;
begin
  with TreeList, LookAndFeelPainter do
    Result := Self.ClientRect.Bottom -
      Byte(OptionsView.Footer) * Byte(TreeList.VisibleColumnCount > 0) * 
        (HeaderLineCount * FooterLineHeight + FooterBorderSize shl 1);
end;

function TcxTreeListViewInfo.GetHeaderOffset: Integer;
begin
  with OptionsView do 
    Result := BorderSize + Byte(Bands) * BandLineHeight * BandLineCount;
end;

function TcxTreeListViewInfo.GetLeftFixedBand: TcxTreeListBandViewInfo;
begin
  Result := FFixedBands[0];
end;

function TcxTreeListViewInfo.GetOptionsView: TcxTreeListOptionsView;
begin
  Result := TreeList.OptionsView;
end;

function TcxTreeListViewInfo.GetRightFixedBand: TcxTreeListBandViewInfo;
begin
  Result := FFixedBands[1];
end;

function TcxTreeListViewInfo.GetTreeList: TcxCustomTreeListControl;
begin
  Result := TcxCustomTreeListControl(Control)
end;

function TcxTreeListViewInfo.GetVisibleBand(Index: Integer): TcxTreeListBandViewInfo;
begin
  Result := TreeList.VisibleBands[Index].ViewInfo;
end;

function TcxTreeListViewInfo.GetVisibleBandCount: Integer;
begin
  Result := TreeList.VisibleBandCount;
end;

procedure TcxTreeListViewInfo.SetBandCount(ACount: Integer);
begin
  if ACount > FBandCapacity then
    ReallocMem(FBands, ACount * SizeOf(Pointer));
  FBandCount := ACount;
end;

procedure TcxTreeListViewInfo.SetBandViewParams(
  ABand: TcxTreeListBand; Index: Integer);
begin
  if ABand.FixedKind = tlbfNone then
  begin
    FBands^[FBandCount] := ABand.ViewInfo;
    Inc(FBandCount);
  end
  else
    FFixedBands[Byte(ABand.FixedKind) - 1] := ABand.ViewInfo;
  with ABand.ViewInfo, TreeList.Styles do
  begin
    ItemViewParams := SetHeaderSizeValue(GetBandHeaderParams(ABand),
      BandLineHeight, OptionsView.Bands);
    FContainerViewParams := GetBandBackgroundParams(ABand);
  end;
end;

procedure TcxTreeListViewInfo.SetColumnViewParams(AColumn: TcxTreeListColumn);
begin
  with AColumn.ViewInfo, TreeList.Styles, OptionsView do
  begin
    FColumnHeader.ItemViewParams :=
      SetHeaderSizeValue(GetColumnHeaderParams(AColumn), Self.HeaderLineHeight, Headers);
    with Painter.Painter do
      FColumnFooter.ItemViewParams := SetHeaderSizeValue(GetColumnFooterParams(AColumn),
        Self.FooterLineHeight, Footer, FooterCellBorderSize shl 1);
  end;
end;

function TcxTreeListViewInfo.CalcBandRect(var ARect: TRect;
  AWidth, AOfs: Integer; Fixed: TcxTreeListBandFixedKind): Integer;
begin
  with OptionsView do
  begin
    Inc(HorzScrollSize, AWidth);
    if Fixed = tlbfRight then
    begin
      Inc(AOfs, FFixedSeparatorWidth);
      if AOfs > (ClientRect.Right - AWidth) then
        AOfs := ClientRect.Right - AWidth;
      if (LeftFixedBand <> nil) and (AOfs < FSeparators[0].Right) then
        AOfs := FSeparators[0].Right;
      FSeparators[1] := cxRectSetWidth(ClientRect,
        AOfs - FixedSeparatorWidth, FixedSeparatorWidth);
      FScrollingArea.Right := FSeparators[1].Left;
      Inc(HorzScrollSize, FixedSeparatorWidth);
    end;
    Result := AOfs + AWidth;
    ARect.Left := AOfs;
    ARect.Right := Result;
    if Fixed = tlbfLeft then
    begin
      FSeparators[0] := cxRectSetWidth(ClientRect,
        Result, FixedSeparatorWidth);
      Result := FSeparators[0].Right - HorzScrollPos;
      FScrollingArea.Left := FSeparators[0].Right;
      Inc(HorzScrollSize, FixedSeparatorWidth);
    end;
  end;
end;

procedure TcxTreeListViewInfo.CalculateCellRects;

  procedure CheckBounds(ADefInfo: TcxTreeListBandViewInfo;
    AIndex: Integer; var ALeft, ARight: Integer);
  var
    AInfo: TcxTreeListBandViewInfo;
  begin
    AInfo := nil;
    if ADefInfo <> nil then
      AInfo := ADefInfo
    else
      if (AIndex < FBandCount) and (AIndex <> cxInvalidIndex) then
        AInfo := TcxTreeListBandViewInfo(FBands^[AIndex]);
    if (AInfo <> nil) and ((ALeft > AInfo.DisplayRect.Left) or (ALeft = -1)) then
      ALeft := AInfo.DisplayRect.Left;
    if (AInfo <> nil) and (ARight < AInfo.DisplayRect.Right) then
      ARight := AInfo.DisplayRect.Right;
  end;

begin
  CellsRect := cxInvalidRect;
  CheckBounds(LeftFixedBand, 0, CellsRect.Left, CellsRect.Right);
  CheckBounds(RightFixedBand, FBandCount - 1, CellsRect.Left, CellsRect.Right);
  CellsRect.Top := CellsOffset;
  CellsRect.Bottom := FooterOffset;
  ContentRect := CellsRect;
  if ContentRect.Right > ClientRect.Right then
    ContentRect.Right := ClientRect.Right;
  FooterRect.Right := ClientRect.Right;
  PreviewHeight := 0;
end;

function TcxTreeListViewInfo.SetHeaderSizeValue(const ViewParams: TcxViewParams;
  var ASize: Integer; CheckSize: Boolean; Delta: Integer = 0): TcxViewParams;
begin
  Result := ViewParams;
  if CheckSize then
  begin
    with ViewParams do
      Delta := Delta shl 1 + LookAndFeelPainter.HeaderHeight(cxTextHeight(Font));
    if Delta > ASize then ASize := Delta;
  end;
end;

{ TcxTreeListControlPainter }

procedure TcxTreeListControlPainter.AfterCustomDraw(
  AViewInfo: TcxCustomViewInfoItem);
begin
  if AViewInfo is TcxTreeListEditCellViewInfo then
    AfterCustomDraw(TcxTreeListEditCellViewInfo(AViewInfo))
end;

procedure TcxTreeListControlPainter.AfterCustomDraw(
  AViewInfo: TcxTreeListEditCellViewInfo);
begin
  with AViewInfo.EditViewInfo do
  begin
    BackgroundColor := Canvas.Brush.Color;
    TextColor := Canvas.Font.Color;
  end;
end;

procedure TcxTreeListControlPainter.BeforeCustomDraw(
  AViewInfo: TcxCustomViewInfoItem);
begin
  if AViewInfo is TcxTreeListEditCellViewInfo then
    BeforeCustomDraw(TcxTreeListEditCellViewInfo(AViewInfo))
end;

procedure TcxTreeListControlPainter.BeforeCustomDraw(
  AViewInfo: TcxTreeListEditCellViewInfo);
begin
  with AViewInfo.EditViewInfo do
  begin
    if AViewInfo.ViewParams.Font <> nil then
    begin
      Canvas.Brush.Color := AViewInfo.ViewParams.Color;
      if AViewInfo.EditViewInfo.Font <> nil then
        Canvas.Font := AViewInfo.EditViewInfo.Font;
      Canvas.Font.Color := TextColor;
    end;
  end;
end;

function TcxTreeListControlPainter.DoCustomDrawEx(AViewInfoItem: TcxCustomViewInfoItem;
  AEvent: TcxCustomDrawViewInfoItemEvent; AExclude: Boolean): Boolean;
begin
  Result := DoCustomDraw(AViewInfoItem, AEvent);
  if Result and AExclude then
    Canvas.ExcludeClipRect(AViewInfoItem.VisibleRect);
end;

procedure TcxTreeListControlPainter.DoPaint;
begin
  if TreeList.IsLocked then
    inherited DoPaint
  else
  begin
    with ViewInfo, ContentRect do
    begin
      if Right < ClientRect.Right then
        DrawBackgroundRect(cxRectSetLeft(ClientRect, Right, ClientRect.Right - Right));
    end;
    if Bands or Headers then DrawHeader;
    if IsFooterVisible then DrawFooter;
    ContentClipRegion := Canvas.GetClipRegion;
    try
      DrawNodes;
    finally
      FreeAndNil(ContentClipRegion);
    end;
  end;
end;

function TcxTreeListControlPainter.DoPaintBackground(
  ACanvas: TcxCanvas; const ABounds: TRect): Boolean;
begin
  Result := CurrentBitmap <> nil;
  if Result then
    ACanvas.FillRect(ABounds, CurrentBitmap);
  CurrentBitmap := nil;
end;

procedure TcxTreeListControlPainter.DrawBackgroundRect(const R: TRect);
var
  ADone: Boolean;
begin
  if cxRectIsEmpty(R) or not Canvas.RectVisible(R) then Exit; 
  ADone := False;
  if Assigned(TreeList.FOnCustomDrawBackground) then
    TreeList.FOnCustomDrawBackground(TreeList, Canvas, R, ADone);
  if not ADone then
    DrawRect(R, BackgroundBrush, ViewInfo.BackgroundBitmap);
end;

procedure TcxTreeListControlPainter.DrawBandItem(AViewInfo: TcxTreeListBandViewInfo);
var
  I: Integer;
begin
  if not DoCustomDraw(AViewInfo, nil) then
  begin
    with AViewInfo do
    begin
      if Buffered then
        DrawHeaderRect(VisibleRect, AViewInfo);
      if Bands then
        DrawHeaderItem(AViewInfo.BandHeader, Opaque);
      if Headers then
        for I := 0 to AViewInfo.ColumnCount - 1 do
          DrawHeaderItem(AViewInfo.Columns[I].ColumnHeader, Opaque);
      if not Buffered and not Opaque then
        DrawHeaderRect(VisibleRect, AViewInfo);
    end;
  end;
end;

procedure TcxTreeListControlPainter.DrawBandFooter(
  AViewInfo: TcxTreeListBandViewInfo);

  procedure DoDrawBandFooterItem;
  var
    I: Integer;
  begin
    for I := 0 to AViewInfo.ColumnCount - 1 do
      DrawFooterItem(AViewInfo.Columns[I].ColumnFooter);
  end;

begin
  if (AViewInfo = nil) or not AViewInfo.Visible then Exit;
  if Buffered then
  begin
    DrawFooterRect(AViewInfo.FooterRect, AViewInfo);
    DoDrawBandFooterItem;
  end
  else
  begin
    DoDrawBandFooterItem;
    DrawFooterRect(AViewInfo.FooterRect, AViewInfo);
  end
end;

procedure TcxTreeListControlPainter.DrawCellsGroup(
  AViewInfo: TcxTreeListCellsGroupViewInfo);
var
  I: Integer;
begin
  with AViewInfo do
  begin
    if not Visible or not Self.Canvas.RectVisible(ClipRect) then Exit;
    if Buffered and not IsOpaque and not DoCustomDraw(AViewInfo,
      TcxCustomDrawViewInfoItemEvent(TreeList.FOnCustomDrawCellsGroup)) then
        DrawRectWithBorders(DisplayRect, CurrentBrush,  Opaque, Borders, GetGroupBitmap);
    for I := 0 to AViewInfo.CellCount - 1 do
      DrawEditCell(Cells[I], Opaque);
    if not Buffered and not IsOpaque and not DoCustomDraw(AViewInfo,
      TcxCustomDrawViewInfoItemEvent(TreeList.FOnCustomDrawCellsGroup)) then
        DrawRectWithBorders(DisplayRect, CurrentBrush,  Opaque, Borders, GetGroupBitmap);
    DrawRectWithBorders(DisplayRect, CurrentBrush, True, Borders, GetGroupBitmap);
  end;
end;

procedure TcxTreeListControlPainter.DrawEditCell(
  AViewInfo: TcxTreeListEditCellViewInfo; IsOpaque: Boolean);
var
  AEvent: TcxCustomDrawViewInfoItemEvent;
  AFont: TFont;
  ADone: Boolean;
begin
  if Canvas.RectVisible(AViewInfo.DisplayRect) then
  begin
    ADone := False;
    DrawRectWithBorders(AViewInfo.DisplayRect, nil, True, AViewInfo.Borders);
    BeforeCustomDraw(AViewInfo);
    if Assigned(TreeList.FOnCustomDrawCell) then
      TreeList.FOnCustomDrawCell(TreeList, Canvas, AViewInfo, ADone);
    AfterCustomDraw(AViewInfo);
    if not ADone then
    begin
      if (AViewInfo.ViewParams.Bitmap <> nil) and not AViewInfo.Selected then
         Canvas.FillRect(AViewInfo.ContentRect, AViewInfo.ViewParams.Bitmap);
      AFont := AViewInfo.EditViewInfo.Font;
      AViewInfo.EditViewInfo.Font := Canvas.Font;
     AViewInfo.CustomDrawEvent(AEvent);
     if not DoCustomDraw(AViewInfo,  AEvent) then    
       AViewInfo.ViewInfo.PaintEx(Canvas);
     AViewInfo.EditViewInfo.Font := AFont;
    end;
    if not Buffered and not IsOpaque then
      Canvas.ExcludeClipRect(AViewInfo.ClipRect);
  end;
end;

procedure TcxTreeListControlPainter.DrawExpandButton(
  const ARect: TRect; AExpanded: Boolean; ABitmap: TBitmap);
begin
  if ABitmap <> nil then
    Canvas.FillRect(ARect, ABitmap)
  else
    Canvas.FillRect(ARect);
  Canvas.Brush.Color := TreeLineColor;
  Painter.DrawSmallExpandButton(Canvas, ARect, AExpanded, TreeLineColor);
end;

procedure TcxTreeListControlPainter.DrawFocusRect(
  AViewInfo: TcxTreeListNodeViewInfo);
var
  R, R1: TRect;
begin
  R := AViewInfo.FocusRect;
  if AViewInfo.NodeFocusedCell <> nil then
  begin
    if TreeList.Controller.IsEditing then Exit;
    R1 := AViewInfo.NodeFocusedCell.ClipRect
  end
  else
    R1 := AViewInfo.ContentRect;
  if cxRectIntersect(R1, R, R1) then
  begin
    RestoreClipping;
    Canvas.IntersectClipRect(R1);
    try
      if TreeList.IsFocused then
        Self.Canvas.DrawFocusRect(R)
      else
        if not TreeList.OptionsSelection.HideFocusRect then
          Self.Canvas.InvertFrame(R, 1);
    finally
      RestoreClipping;
    end;
  end;
end;

procedure TcxTreeListControlPainter.DrawFooter;
var
  R: TRect;
  I: Integer;
  ARegion: TcxRegion;
begin
  ARegion := Canvas.GetClipRegion;
  if Indicator then
    DrawIndicator(ViewInfo.FooterIndicator);
  with ViewInfo do
  try
    DrawSeparators(FooterSeparators);
    DrawBandFooter(LeftFixedBand);
    DrawBandFooter(RightFixedBand);
    if (BandCount > 0) and ScrollingAreaVisible then
      Canvas.IntersectClipRect(ScrollingArea);
    for I := 0 to BandCount - 1 do DrawBandFooter(Bands[I]);
  finally
    Canvas.SetClipRegion(ARegion, roSet);
    with Self.Painter do
      R := cxRectInflate(ViewInfo.FooterRect, FooterBorderSize,
        FooterBorderSize, 0, FooterBorderSize);
    Self.Painter.DrawFooterSeparator(Canvas,
      cxRectSetHeight(R, Self.Painter.FooterBorderSize));
    Self.Painter.DrawFooterBorder(Canvas, R);
    R.Left := ViewInfo.ClientRect.Left;
    Canvas.ExcludeClipRect(R);
  end;
end;

procedure TcxTreeListControlPainter.DrawFooterItem(
  AViewInfo: TcxTreeListFooterItemViewInfo);
begin
  with AViewInfo do
  begin
    if Visible and Canvas.RectVisible(AViewInfo.VisibleRect) then
    begin
      if not Buffered and not Painter.FooterDrawCellsFirst then
        DrawFooterRect(ClipRect, AViewInfo.BandViewInfo);
      if not DoCustomDraw(AViewInfo,
        TcxCustomDrawViewInfoItemEvent(TreeList.FOnCustomDrawFooterCell)) then
      begin
        CurrentBitmap := ViewParams.Bitmap;
        with ViewParams do
          Painter.DrawFooterCell(Canvas, DisplayRect, AlignHorz, AlignVert,
            MultiLine, Text, Font, TextColor, Color, DoPaintBackground);
      end;
      if not Buffered then Canvas.ExcludeClipRect(ClipRect);
    end;
  end;
end;

procedure TcxTreeListControlPainter.DrawFooterRect(
  const R: TRect; AViewInfo: TcxTreeListBandViewInfo);
var
  ADone: Boolean;
  R1, R2: TRect;
begin
  if not (AViewInfo.Visible and Canvas.RectVisible(R)) then Exit;
  ADone := False;
  if Assigned(TreeList.FOnCustomDrawFooter) then
  begin
    R1 := AViewInfo.DisplayRect;
    R2 := AViewInfo.VisibleRect;
    AViewInfo.DisplayRect := cxRectSetTop(R1, R.Top);
    AViewInfo.ClipRect := R;
    try
      TreeList.FOnCustomDrawFooter(Control, Canvas, AViewInfo, ADone);
    finally
      AViewInfo.DisplayRect := R1;
      AViewInfo.ClipRect := R2;
    end;
  end;
  if not ADone then
  begin
    Canvas.SaveClipRegion;
    try
      Canvas.SetClipRegion(TcxRegion.Create(R), roIntersect);
      Painter.DrawFooterContent(Canvas, R, AViewInfo.FFooterViewParams);
    finally
      Canvas.RestoreClipRegion;
    end;
  end;
end;

procedure TcxTreeListControlPainter.DrawHeader;
var
  I: Integer;
  ARegion: TcxRegion;

  procedure DrawEdgeBorder(AItem: TcxTreeListBandViewInfo);
  begin
    if not AItem.Opaque then
      Canvas.FrameRect(AItem.DisplayRect, clBtnShadow, 1, [bRight]);
  end;

begin
  ARegion := Canvas.GetClipRegion;
  with ViewInfo do
  try
    if Indicator and (Self.Bands or Self.Headers) then
      DrawIndicator(HeaderIndicator);
    DrawSeparators(HeaderSeparators);
    DrawBandItem(LeftFixedBand);
    DrawBandItem(RightFixedBand);
    if (BandCount > 0) and ScrollingAreaVisible then
      Canvas.IntersectClipRect(ScrollingArea);
    for I := 0 to BandCount - 1 do
      DrawBandItem(Bands[I]);
    if RightFixedBand <> nil then
      DrawEdgeBorder(RightFixedBand)
    else
      if BandCount > 0 then
        DrawEdgeBorder(Bands[BandCount - 1])
  finally
    Canvas.SetClipRegion(ARegion, roSet);
    Canvas.ExcludeClipRect(HeaderRect);
  end;
end;

procedure TcxTreeListControlPainter.DrawHeaderItem(
  AViewInfo: TcxTreeListHeaderViewInfo; IsOpaque: Boolean);
var
  AEvent: TcxCustomDrawViewInfoItemEvent;
  AClipRgn: TcxRegion;
begin
  if (AViewInfo = nil) or not Canvas.RectVisible(AViewInfo.ClipRect) then Exit;
  with AViewInfo, LookAndFeelPainter, Self do
  begin
    if not Buffered and not LookAndFeelPainter.HeaderDrawCellsFirst and
      (BandViewInfo <> nil) and (BandViewInfo.ContainerBrush <> nil) then
      DrawHeaderRect(ClipRect, BandViewInfo);
    AViewInfo.CustomDrawEvent(AEvent);
    if not DoCustomDrawEx(AViewInfo, AEvent, False) then
    begin
      CurrentBitmap := ViewParams.Bitmap;
      with ViewParams do
        ExtDrawHeader(Self.Canvas, GetDisplayRect, TextBounds, Neighbors, Borders, State, AlignHorz,
          AlignVert, MultiLine, ShowEndEllipsis, Text, Font, TextColor, Color, DoPaintBackground);
      if not Glyph.Empty then
      begin
        AClipRgn := nil;
        if NeedGlyphClipping then
        begin
          AClipRgn := Self.Canvas.GetClipRegion;
          Self.Canvas.IntersectClipRect(ClipRect);
        end;
        Self.Canvas.DrawGlyph(GlyphPos.X, GlyphPos.Y, Glyph);
        if NeedGlyphClipping then Self.Canvas.SetClipRegion(AClipRgn, roSet);
      end;
      if SortOrder <> soNone then
        DrawSortingMark(Self.Canvas, FSortMarkBounds, SortOrder = soAscending);
      if State = cxbsPressed then
        DrawHeaderPressed(Self.Canvas, DisplayRect);
    end;
    if Selected then
    begin
      Self.Canvas.DrawFocusRect(cxRectInflate(GetDisplayRect, -1, -1));
      Self.Canvas.DrawFocusRect(cxRectInflate(GetDisplayRect, -2, -2));
    end;
    if not Buffered and not IsOpaque then Self.Canvas.ExcludeClipRect(ClipRect);
  end;
end;

procedure TcxTreeListControlPainter.DrawHeaderRect(const R: TRect;
  AViewInfo: TcxTreeListBandViewInfo);
begin
  if not DoCustomDraw(AViewInfo,
    TcxCustomDrawViewInfoItemEvent(TreeList.FOnCustomDrawHeader)) then
  begin
    DrawRect(R, AViewInfo.ContainerBrush, AViewInfo.ContainerViewParams.Bitmap);
    Canvas.FrameRect(R, clBtnShadow, 1, [bBottom]);
  end;
end;

procedure TcxTreeListControlPainter.DrawImage(
  AViewInfo: TcxTreeListIndentViewInfo);
var
  R: TRect;
begin
  with AViewInfo do
  begin
    R := DisplayRect;
    Dec(R.Right, cxTreeListIndentOffsetSize div 2);
    R := cxRectCenter(R, ImageList.Width, ImageList.Height);
    if not IsRectEmpty(R) then
    begin
      ImageList.DrawingStyle := dsTransparent;
      ImageList.Draw(Self.Canvas.Canvas, R.Left, R.Top, ImageIndex);
    end;
  end;
end;

procedure TcxTreeListControlPainter.DrawIndicator(
  AViewInfo: TcxTreeListIndicatorViewInfo);
var
  APainter: TcxCustomLookAndFeelPainterClass;
begin
  if not AViewInfo.Visible then Exit;
  if not DoCustomDraw(AViewInfo,
    TcxCustomDrawViewInfoItemEvent(TreeList.FOnCustomDrawIndicatorCell)) then
  begin
    APainter := Painter;
    CurrentBitmap := AViewInfo.ViewParams.Bitmap;
    if (AViewInfo = ViewInfo.HeaderIndicator) or (AViewInfo = ViewInfo.FooterIndicator) then
      with AViewInfo do
        ExtDrawHeader(Self.Canvas, DisplayRect, DisplayRect, [], cxBordersAll, cxbsDefault,
          taLeftJustify, vaTop, False, False, '', nil, clDefault, ViewParams.Color,
          DoPaintBackground)
    else
      with AViewInfo do
      begin
        if TreeList.OptionsView.IsExtPaintStyle then
          APainter.DrawIndicatorItemEx(Self.Canvas, DisplayRect, Kind, ViewParams.Color, DoPaintBackground)
        else
          APainter.DrawIndicatorItem(Self.Canvas, DisplayRect, Kind, ViewParams.Color, DoPaintBackground);
      end;
  end;
  Canvas.ExcludeClipRect(AViewInfo.ClipRect);
  if ContentClipRegion <> nil then
    ContentClipRegion.Combine(TcxRegion.Create(AViewInfo.ClipRect), roSubtract);
end;

procedure TcxTreeListControlPainter.DrawNode(AViewInfo: TcxTreeListNodeViewInfo);

  function DoDrawFixedGroup(AGroup: TcxTreeListCellsGroupViewInfo): Boolean;
  begin
    Result := AGroup <> nil;
    if Result then DrawCellsGroup(AGroup);
  end;

var
  I, AFromIndex, AToIndex: Integer;
begin
  if Indicator then DrawIndicator(AViewInfo.Indicator);
  if not Canvas.RectVisible(AViewInfo.ContentRect) then Exit;
  for I := AViewInfo.IndentCount - 1 downto 0 do
    DrawNodeIndent(AViewInfo.Indents[I]);
  AFromIndex := 0;
  if not AViewInfo.IsGroupNode then
  begin
    AToIndex := AViewInfo.GroupCount - 1;
    DrawSeparators(AViewInfo.Separators);
    Inc(AFromIndex, Byte(DoDrawFixedGroup(AViewInfo.LeftFixedGroup)));
    Dec(AToIndex, Byte(DoDrawFixedGroup(AViewInfo.RightFixedGroup)));
  end
  else
    AToIndex := -1;
  if AViewInfo.HasPreview then
    DrawNodePreview(AViewInfo.Preview);
  try
    DrawNodeCells(AViewInfo, AFromIndex, AToIndex);
  finally
    RestoreClipping;
    if AViewInfo.Focused then DrawFocusRect(AViewInfo);
    DrawBackgroundRect(AViewInfo.UnusedArea);
  end;
end;

procedure TcxTreeListControlPainter.DrawNodeCells(
  AViewInfo: TcxTreeListNodeViewInfo; AFromIndex, AToIndex: Integer);
begin
  if not AViewInfo.IsGroupNode then
  begin
    if Self.ViewInfo.ScrollingAreaVisible then
      Canvas.IntersectClipRect(Self.ViewInfo.ScrollingArea);
    while AFromIndex <= AToIndex do
    begin
      DrawCellsGroup(AViewInfo.Groups[AFromIndex]);
      Inc(AFromIndex);
    end;
  end
  else
    DrawEditCell(AViewInfo.NodeGroupEditViewInfo, True);
end;

procedure TcxTreeListControlPainter.DrawNodeIndent(
  AViewInfo: TcxTreeListIndentViewInfo);
begin
  if DoCustomDraw(AViewInfo,
    TcxCustomDrawViewInfoItemEvent(TreeList.FOnCustomDrawIndentCell)) then Exit;
  with AViewInfo do
  begin
    DrawRectWithBorders(DisplayRect, Brush, False, Borders, ViewParams.Bitmap);
    if IsLevel then
    begin
      DrawTreeLines(AViewInfo);
      if HasButton then
        DrawExpandButton(ButtonRect, IsExpanded, ViewParams.Bitmap);
    end
    else
      if HasImage then DrawImage(AViewInfo);
  end;
end;

procedure TcxTreeListControlPainter.DrawNodePreview(
  AViewInfo: TcxTreeListNodePreviewViewInfo);
begin
  DrawEditCell(AViewInfo, False)
end;

procedure TcxTreeListControlPainter.DrawNodes;
var
  I: Integer;
begin
  with ViewInfo.NodesViewInfo do
  begin
    for I := 0 to Count - 1 do DrawNode(Nodes[I]);
    DrawBackgroundRect(SpaceArea);
  end;
end;

procedure TcxTreeListControlPainter.DrawRect(AViewInfo: TcxTreeListViewInfoItem);
begin
  with AViewInfo do DrawRect(ClipRect, Brush, ViewParams.Bitmap);
end;

procedure TcxTreeListControlPainter.DrawRect(
  const ARect: TRect; ABrush: TBrush; ABitmap: TBitmap = nil);
begin
  if cxRectIsEmpty(ARect) then Exit;
  if (ABitmap <> nil) and not ABitmap.Empty then
    Canvas.FillRect(ARect, ABitmap)
  else
  begin
    Canvas.Brush := ABrush;
    Canvas.FillRect(ARect);
  end; 
end;

procedure TcxTreeListControlPainter.DrawRectWithBorders(const ARect: TRect;
  ABrush: TBrush; IsOpaque: Boolean; ABorders: TcxBorders = []; ABitmap: TBitmap = nil);
begin
  with ARect do
  begin
    if bLeft in ABorders then
      DrawRect(cxRect(Left, Top, Left + 1, Bottom), GridLinesBrush);
    if bRight in ABorders then
      DrawRect(cxRect(Right - 1, Top, Right, Bottom), GridLinesBrush);
    if bTop in ABorders then
      DrawRect(cxRect(Left, Top, Right, Top + 1), GridLinesBrush);
    if bBottom in ABorders then
      DrawRect(cxRect(Left, Bottom - 1, Right, Bottom), GridLinesBrush);
  end;
  if not IsOpaque then
    DrawRect(cxExcludeBorders(ARect, ABorders), ABrush, ABitmap);
end;

procedure TcxTreeListControlPainter.DrawRectWithBorders(
  AViewInfo: TcxTreeListViewInfoItem; IsOpaque: Boolean; ABorders: TcxBorders = []);
begin
  with AViewInfo do
  begin
    if (ABorders = []) and not IsOpaque then
      DrawRect(ClipRect, Brush, ViewParams.Bitmap)
    else
      DrawRectWithBorders(DisplayRect, Brush, IsOpaque, ABorders, ViewParams.Bitmap);
  end;
end;

procedure TcxTreeListControlPainter.DrawSeparators(const ASeparators: TcxTreeListSeparators);
var
  I: Integer;
begin
  Canvas.Brush.Assign(ViewInfo.SeparatorBrush);
  for I := Low(TcxTreeListSeparators) to High(TcxTreeListSeparators) do
    if not cxRectIsEmpty(ASeparators[I]) then
    begin
      Canvas.FillRect(ASeparators[I]);
      Canvas.ExcludeClipRect(ASeparators[I]);
      if ContentClipRegion <> nil then
        ContentClipRegion.Combine(TcxRegion.Create(ASeparators[I]), roSubtract);
    end;
end;

procedure TcxTreeListControlPainter.DrawTreeLines(
  AViewInfo: TcxTreeListIndentViewInfo);

  procedure DrawTreeLine(const ARect: TRect; AColor: TColor);
  begin
    if TreeList.OptionsView.TreeLineStyle = tllsDot then
      cxFillHalfToneRect(Canvas.Canvas, ARect, AColor, TreeLineColor)
    else
    begin
      Canvas.Brush.Color := TreeLineColor; 
      Canvas.FillRect(ARect);
    end;
  end;

begin
  with AViewInfo, ViewParams do
  begin
    if [tltVertUp, tltVertDown] * TreeLines <> [] then
      DrawTreeLine(IndentVertTreeLine, Color);
    if tltHorz in TreeLines then
      DrawTreeLine(IndentHorzTreeLine, Color);
  end;
end;

procedure TcxTreeListControlPainter.ExtDrawHeader(ACanvas: TcxCanvas;
  const ABounds, ATextAreaBounds: TRect; ANeighbors: TcxNeighbors; ABorders: TcxBorders;
  AState: TcxButtonState; AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert;
  AMultiLine, AShowEndEllipsis: Boolean; const AText: string; AFont: TFont;
  ATextColor, ABkColor: TColor; AOnDrawBackground: TcxDrawBackgroundEvent = nil);
begin
  if TreeList.OptionsView.IsExtPaintStyle then
    Painter.DrawHeaderEx(ACanvas, ABounds, ATextAreaBounds, ANeighbors, ABorders,
      AState, AAlignmentHorz, AAlignmentVert, AMultiLine, AShowEndEllipsis, AText,
      AFont, ATextColor, ABkColor, AOnDrawBackground)
  else
    Painter.DrawHeader(ACanvas, ABounds, ATextAreaBounds, ANeighbors, ABorders,
      AState, AAlignmentHorz, AAlignmentVert, AMultiLine, AShowEndEllipsis, AText,
      AFont, ATextColor, ABkColor, AOnDrawBackground);
end;

function TcxTreeListControlPainter.GetViewState(AIndex: Integer): Boolean;
begin
  Result := TcxTreeListOptionsView(TreeList.OptionsView).GetState(AIndex);
end;

procedure TcxTreeListControlPainter.RestoreClipping;
begin
  Canvas.SetClipRegion(ContentClipRegion, roSet, False);
end;

function TcxTreeListControlPainter.GetBackgroundBrush: TBrush;
begin
  Result := ViewInfo.Brush;
end;

function TcxTreeListControlPainter.GetGridLinesBrush: TBrush;
begin
  Result := ViewInfo.GridLinesBrush;
end;

function TcxTreeListControlPainter.GetTreeList: TcxCustomTreeListControl;
begin
  Result := TcxCustomTreeListControl(Control);
end;

function TcxTreeListControlPainter.GetIsFooterVisible: Boolean;
begin
  Result := Footer and (TreeList.VisibleColumnCount > 0);
end;

function TcxTreeListControlPainter.GetTreeLineColor: TColor;
begin
  Result := ViewInfo.TreeLineColor;
end;

function TcxTreeListControlPainter.GetViewInfo: TcxTreeListViewInfo;
begin
  Result := TcxTreeListViewInfo(inherited ViewInfo); 
end;

{ TcxTreeListBandOptions }

constructor TcxTreeListBandOptions.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FState := Integer($FFFFFFFF);
  OnlyOwnColumns := False;
end;

procedure TcxTreeListBandOptions.Assign(Source: TPersistent);
begin
  if Source is TcxTreeListBandOptions then
  begin
    if FState <> TcxTreeListBandOptions(Source).FState then
    begin
      FState := TcxTreeListBandOptions(Source).FState;
      Changed;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TcxTreeListBandOptions.RestoreDefaults;
begin
  FState := 0;
  Sizing := True;
  Customizing := True;
  Moving := True;
  Changed;
end;

procedure TcxTreeListBandOptions.Changed;
begin
  TcxTreeListBand(GetOwner).Changed(False);
end;

function TcxTreeListBandOptions.GetState(AIndex: Integer): Boolean;
begin
  Result := cxGetState(FState, AIndex);
end;

procedure TcxTreeListBandOptions.SetState(AIndex: Integer; Value: Boolean);
begin
  if cxSetState(FState, AIndex, Value) then
    Changed;
end;

{ TcxTreeListBandStyles }

procedure TcxTreeListBandStyles.Assign(Source: TPersistent);
var
  I: Integer; 
begin
  if Source is TcxTreeListBandStyles then
  begin
    for I := tlbs_Content to tlbs_HeaderBackground do
      SetValue(I, TcxTreeListBandStyles(Source).GetValue(I));
  end;
  inherited Assign(Source);
end;

function TcxTreeListBandStyles.GetTreeList: TcxCustomTreeListControl;
begin
  Result := TcxTreeListBand(GetOwner).TreeList;
end;

procedure TcxTreeListBandStyles.CachedContentStyleChanged;
var
  B: Boolean;
begin
  ContentParams := TreeList.Styles.ContentParams;
  for B := False to True do
    cxParamsCombine(Content, [], ContentParams[B]);
end;

procedure TcxTreeListBandStyles.Changed(AIndex: Integer);
begin
  inherited Changed(AIndex);
  TreeList.UpdateViewStyles;
end;

{ TcxTreeListBand }

constructor TcxTreeListBand.Create(Collection: TCollection);
begin
  TcxTreeListBands(Collection).TreeList.BeginUpdate;
  inherited Create(Collection);
  FVisibleColumns := TList.Create;
  FBandRows := TcxTreeListBandRows.Create(Self);
  FColumns := TList.Create;
  FOptions := GetOptionsClass.Create(Self);
  FBandViewInfo := TcxTreeListBandViewInfo.Create(Self);
  FCaption := TcxTreeListCaption.CreateEx(TreeList, Self, FBandViewInfo);
  FStyles := TcxTreeListBandStyles.Create(Self);
  Visible := True;
  RestoreWidths;
  if TreeList <> nil then TreeList.DoUpdateDesignerForms;
  TreeList.EndUpdate;
end;

destructor TcxTreeListBand.Destroy;
var
  I: Integer;
  ATreeList: TcxCustomTreeListControl;
begin
  ATreeList := TreeList;
  ATreeList.BeginUpdate;
  try
    FreeAndNil(FCaption);
    if not (TreeList.IsDestroying or TreeList.IsLoading) then
    begin
      if TreeList.HitTest.FPressedHeader = ViewInfo.BandHeader then
        TreeList.HitTest.FPressedHeader := nil;
      TreeList.ViewInfo.IsDirty := True;
      Visible := False;
      TreeList.Controller.UnselectObject(Self);
      if Visible then
        TreeList.FBandsVisibleList.Remove(Self);
      for I := 0 to FColumns.Count - 1 do
        TcxTreeListColumn(FColumns[I]).InternalSetBandOwner(nil, False);
    end;
    FreeAndNil(FBandViewInfo);
    FreeAndNil(FColumns);
    FreeAndNil(FOptions);
    FreeAndNil(FStyles);
    FreeAndNil(FBandRows);
    FreeAndNil(FVisibleColumns);
    TreeList.UpdateViewStyles;
  finally
    inherited Destroy;
    ATreeList.EndUpdate;
  end;
end;

procedure TcxTreeListBand.Assign(Source: TPersistent);
var
  ABand: TcxTreeListBand;
begin
  if Source is TcxTreeListBand then
  begin
    ABand := TcxTreeListBand(Source);
    FCalculatedWidth := ABand.FCalculatedWidth;
    FMinWidth := ABand.MinWidth;
    FWidth := ABand.FWidth;
    Visible := ABand.Visible;
    Options := ABand.Options;
    Styles := ABand.Styles;
    Caption := ABand.Caption;
    FixedKind := ABand.FixedKind;
  end
  else
    inherited Assign(Source);
end;

procedure TcxTreeListBand.ApplyBestFit;
var
  I: Integer;
begin
  TreeList.HandleNeeded;
  if IsLeftMost then
    TreeList.FContentIndentWidth := 0;
  if not CanSizing(dsdHorz) then Exit;
  TreeList.BeginUpdate;
  try
    FWidth := 0;
    TreeList.HideEdit;
    I := 0;
    while I < VisibleColumnCount do
    begin
      VisibleColumns[I].ApplyBestFit;
      Inc(I);
    end;
    BandRows.Refresh;
    FCalculatedWidth := BandRows.ColumnsMaxWidth;
    if FWidth <> 0 then
      FCalculatedWidth := FWidth;
    TreeList.Controller.ForceWidthItem := Self;
    AssignColumnWidths;
    TreeList.RealignBands;
  finally
    TreeList.Controller.ForceWidthItem := nil;
    TreeList.EndUpdate;
  end;
end;

procedure TcxTreeListBand.RestoreDefaults;
begin
  TreeList.BeginUpdate;
  try
    Options.RestoreDefaults;
    RestoreWidths;
  finally
    TreeList.EndUpdate;
  end;
end;

procedure TcxTreeListBand.RestoreWidths;
begin
  FMinWidth := cxTreeListDefMinWidth;
  SetWidth(0);
end;

procedure TcxTreeListBand.AssignColumnWidths;
var
  I: Integer;
begin
  TreeList.BeginUpdate;
  try
    for I := 0 to VisibleColumnCount - 1 do
      VisibleColumns[I].Width := VisibleColumns[I].RealWidth;
  finally
    TreeList.EndUpdate;
  end;
end;

procedure TcxTreeListBand.InitAutoWidthItem(AItem: TcxAutoWidthItem);
begin
  AItem.Width := Width;
  if AItem.Width = 0 then
    AItem.Width := BandRows.ColumnsMaxWidth;
  AItem.MinWidth := cxMax(FMinWidth, BandRows.ColumnsMinWidth);
  AItem.AutoWidth := -1;
  AItem.Fixed := (TreeList.Controller.ForceWidthItem = Self) or not Options.Sizing;
end;

function TcxTreeListBand.IsFixed: Boolean;
begin
  Result := FixedKind <> tlbfNone;
end;

function TcxTreeListBand.IsOnlyOwnColumns: Boolean;
begin
  Result := Options.OnlyOwnColumns;
end;

function TcxTreeListBand.CanDropColumnAt(
  const APoint: TPoint; out ARowIndex, AColIndex: Integer): Boolean;
begin
  Result := True;
  ARowIndex := 0;
  AColIndex := 0;
end;

function TcxTreeListBand.GetMaxDeltaWidth: Integer;
begin
  Result := TreeList.GetMaxBandWidth(Self) - DisplayWidth;
end;

function TcxTreeListBand.CanMoving: Boolean;
begin
  Result := (FixedKind = tlbfNone) and (TreeList.VisibleBandCount > 1) and 
    Options.Moving and TreeList.OptionsCustomizing.BandMoving;
end;

function TcxTreeListBand.GetState(Index: Integer): Boolean;
begin
  Result := cxGetState(FState, Index);
end;

function TcxTreeListBand.GetOptionsClass: TcxTreeListBandOptionsClass;
begin
  Result := TcxTreeListBandOptions;
end;

procedure TcxTreeListBand.AddColumn(AColumn: TcxTreeListColumn);
begin
  if FColumns.IndexOf(AColumn) = cxInvalidIndex then
  begin
//    if not (TreeList.IsLocked or TreeList.IsUpdating) then
//      AColumn.Position.FColIndex := FColumns.Count;
    FColumns.Add(AColumn);
  end;
  AColumn.FOwnerBand := Self;
end;

procedure TcxTreeListBand.RealignColumns;
var
  I: Integer;
begin
  if not Visible then Exit;
  BandRows.Refresh;
  if not TreeList.OptionsView.ColumnAutoWidth then
    FCalculatedWidth := BandRows.ColumnsMaxWidth;
  try
    for I := 0 to BandRows.Count - 1 do
      BandRows[I].DoCalculateColumnsAutoWidth;
  finally
    BandRows.UpdateInformation;
  end;                         
end;

procedure TcxTreeListBand.RemoveColumn(AColumn: TcxTreeListColumn);
begin
  if (FColumns <> nil) and (FColumns.Remove(AColumn) <> cxInvalidIndex) then
  begin
    Changed(True);
    AColumn.FOwnerBand := nil;
  end;
end;

procedure TcxTreeListBand.SetState(Index: Integer; Value: Boolean);
begin
  cxSetState(FState, Index, Value);
end;

procedure TcxTreeListBand.VisibleChanged;
begin
  with TreeList do
  begin
    BeginUpdate;
    try
      FixedKind := tlbfNone;
      if not Self.Visible then
        FBandsVisibleList.Remove(Self)
      else
        FBandsVisibleList.Add(Self);
    finally
      Self.Changed(True);
      DoUpdateDesignerForms;
      EndUpdate;
    end;
  end;
end;

function TcxTreeListBand.CanSizing(ADirection: TcxDragSizingDirection): Boolean;
begin
  with TreeList.OptionsCustomizing do
  begin
    if ADirection = dsdVert then
      Result := BandVertSizing
    else
      Result := BandHorzSizing and Options.Sizing;
  end
end;

function TcxTreeListBand.GetSizingBoundsRect(
  ADirection: TcxDragSizingDirection): TRect;
begin
  Result := TreeList.ViewInfo.ClientRect;
  InflateRect(Result, TreeList.Width, 0);
end;

function TcxTreeListBand.GetSizingIncrement(
  ADirection: TcxDragSizingDirection): Integer;
begin
  if ADirection = dsdHorz then
    Result := 1
  else
    Result := TreeList.ViewInfo.BandLineHeight;
end;

function TcxTreeListBand.IsDynamicUpdate: Boolean;
var
  ADir: TcxDragSizingDirection;
begin
  Result := TreeList.OptionsCustomizing.DynamicSizing and
    TreeList.HitTest.CanSizing(ADir) and (ADir = dsdHorz);
end;

procedure TcxTreeListBand.SetSizeDelta(
  ADirection: TcxDragSizingDirection; ADelta: Integer);
begin
  TreeList.Controller.ForceWidthItem := Self;
  if ADirection = dsdHorz then
    Width := DisplayWidth + ADelta
  else
    with TreeList.OptionsView do
      BandLineCount := BandLineCount + ADelta;
  TreeList.LayoutChanged;
  TreeList.Controller.ForceWidthItem := nil;
end;

function TcxTreeListBand.GetObjectName: string;
begin
  Result := 'Band' + IntToStr(Index);
end;

function TcxTreeListBand.GetProperties(
  AProperties: TStrings): Boolean;
var
  I: Integer;
begin
  for I := 0 to High(BandPropertiesName) do
    AProperties.Add(BandPropertiesName[I]);
  Result := True;
end;

function TcxTreeListBand.GetPropertyIndex(const AName: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to High(BandPropertiesName) do
    if BandPropertiesName[I] = AName then
    begin
      Result := I;
      Break;
    end;
end;

procedure TcxTreeListBand.GetPropertyValue(
  const AName: string; var AValue: Variant);
begin
  case GetPropertyIndex(AName) of
    0: AValue := Caption.Text;
    1: AValue := FMinWidth;
    2: AValue := FWidth;
    3: AValue := Visible;
    4: AValue := Index;
  end;
end;

procedure TcxTreeListBand.SetPropertyValue(
  const AName: string; const AValue: Variant);
begin
  case GetPropertyIndex(AName) of
    0:
     Caption.Text := AValue;
    1:
     FMinWidth := AValue;
    2:
      FWidth := AValue;
    3:
      Visible := AValue;
    4:
      Index := AValue;
  end;
end;

function TcxTreeListBand.GetRealWidth: Integer;
begin
  Result := FCalculatedWidth;
  if Result = 0 then
    Result := FWidth;
  if Result = 0 then
    Result := BandRows.ColumnsMaxWidth;
  Result := Max(Result, BandRows.ColumnsMinWidth);
  if Result = 0 then
    Result := cxTreeListDefWidth;
end;

function TcxTreeListBand.GetTreeList: TcxCustomTreeListControl;
begin
  Result := Bands.TreeList;
end;

function TcxTreeListBand.GetBands: TcxTreeListBands;
begin
  Result := TcxTreeListBands(Collection);
end;

function TcxTreeListBand.GetColumn(Index: Integer): TcxTreeListColumn;
var
  I, AIndex: Integer;
begin
  Result := nil;
  AIndex := 0;
  for I := 0 to TreeList.ColumnCount - 1 do
  begin
    Result := TreeList.Columns[I];
    if Result.OwnerBand = Self then
    begin
      if Index = AIndex then Break;
      Inc(AIndex);
    end;
  end; 
end;

function TcxTreeListBand.GetColumnCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to TreeList.ColumnCount - 1 do
    if TreeList.Columns[I].OwnerBand = Self then
      Inc(Result);
end;

function TcxTreeListBand.GetDisplayWidth: Integer;
begin
  Result := FCalculatedWidth + IndentWidth;
end;

function TcxTreeListBand.GetFixedKind: TcxTreeListBandFixedKind;
begin
  Result := TcxTreeListBandFixedKind(FState shr 1 and 3);
end;

function TcxTreeListBand.GetIndentWidth: Integer;
begin
  Result := TreeList.GetIndentWidth(Bands.FirstVisible = Self);
end;

function TcxTreeListBand.GetIsLeftMost: Boolean;
begin
  Result := Visible and (Bands.FirstVisible = Self);
end;

function TcxTreeListBand.GetIsRightMost: Boolean;
begin
  Result := Visible and (Bands.LastVisible = Self);
end;

function TcxTreeListBand.GetItemIndex: Integer;
begin
  Result := Index;
end;

function TcxTreeListBand.GetVisible: Boolean;
begin
  Result := GetState(tlbsVisible); 
end;

function TcxTreeListBand.GetVisibleColumn(Index: Integer): TcxTreeListColumn;
begin
  Result := TcxTreeListColumn(FVisibleColumns[Index]);
end;

function TcxTreeListBand.GetVisibleColumnCount: Integer;
begin
  Result := FVisibleColumns.Count;
end;

function TcxTreeListBand.GetVisibleIndex: Integer;
begin
  Result := TreeList.FBandsVisibleList.IndexOf(Self);
end;

procedure TcxTreeListBand.SetBandVisiblePos(APos: Integer);
var
  I: Integer;
begin
  with TreeList.FBandsVisibleList do
  begin
    I := IndexOf(Self);
    if I <> APos then
    begin
      Remove(Self);
      if APos >= Count then
        Add(Self)
      else
        Insert(APos, Self);
    end;
  end;
end;

procedure TcxTreeListBand.SetCaption(Value: TcxTreeListCaption);
begin
  FCaption.Assign(Value);
end;

procedure TcxTreeListBand.SetColumn(Index: Integer; Value: TcxTreeListColumn);
begin
  Columns[Index].Assign(Value);
end;

procedure TcxTreeListBand.SetFixedKind(Value: TcxTreeListBandFixedKind);
var
  I: Integer;
begin
  if (Value <> FixedKind) and Visible then
  begin
    if Value <> tlbfNone then
    begin
      for I := 0 to Bands.Count - 1 do
        if Bands[I].FixedKind = Value then
          Bands[I].FixedKind := tlbfNone;
    end;
    FState := FState and not tlbsAllFixed;
    if Value <> tlbfNone then
      FState := FState or Integer(Value) shl 1;
    with TreeList.FBandsVisibleList do
    begin
      if Value = tlbfLeft then
        SetBandVisiblePos(0)
      else
        if Value = tlbfRight then
          SetBandVisiblePos(Count - 1);
      Changed(True);
    end;
  end;
end;

procedure TcxTreeListBand.SetItemIndex(Value: Integer);
begin
  if cxInRange(Value, 0, Bands.Count - 1) then
    Index := Value;
end;

procedure TcxTreeListBand.SetMinWidth(Value: Integer);
begin
  if Value <> FMinWidth then
  begin
    FMinWidth := Value;
    Changed(True);
  end;
end;

procedure TcxTreeListBand.SetOptions(Value: TcxTreeListBandOptions);
begin
  FOptions.Assign(Value);
end;

procedure TcxTreeListBand.SetStyles(Value: TcxTreeListBandStyles);
begin
  FStyles.Assign(Value);
end;

procedure TcxTreeListBand.SetVisibleColumn(
  Index: Integer; Value: TcxTreeListColumn);
begin
  VisibleColumns[Index].Assign(Value); 
end;

procedure TcxTreeListBand.SetVisible(Value: Boolean);
begin
  if Value <> Visible then
  begin
    SetState(tlbsVisible, Value);
    VisibleChanged;
  end;
end;

procedure TcxTreeListBand.SetVisibleIndex(Value: Integer);
const
  ACorrectValue: array[TcxTreeListBandFixedKind] of Integer = (0, 1, -1);

  procedure ModifyList;
  begin
    with TreeList.FBandsVisibleList do
    begin
      if cxValidateIntDefEx(Value, -1, 0, Count) then
      begin
        Inc(Value, ACorrectValue[TcxTreeListBand(List^[Value]).FixedKind]);
        if Value >= Count then
          Add(Self)
        else
          Insert(Value, Self);
      end;
    end;
  end;

var
 I: Integer;
begin
  Inc(Value);
  if Value <> VisibleIndex then
  begin
    if Value < 0 then
      Visible := False
    else
      if FixedKind = tlbfNone then
      begin
        I := TreeList.FBandsVisibleList.Remove(Self);
        if (I >= 0) and (I < Value) then Dec(Value);
        ModifyList;
        SetState(tlbsVisible, VisibleIndex >= 0);
        Changed(True);
      end;
  end;
end;

procedure TcxTreeListBand.SetWidth(Value: Integer);
begin
  if (Value = 0) or (cxValidateIntDefEx(Value, FWidth, FMinWidth)) then
  begin
    FWidth := Value;
    if TreeList.IsLocked or not Visible then Exit;
    TreeList.LayoutChanged;
    TreeList.DoOnBandSizeChanged(Self);
  end;
end;

{ TcxTreeListBands }

constructor TcxTreeListBands.Create(AOwner: TcxCustomTreeListControl);
begin
  inherited Create(AOwner.GetBandItemClass);
  FTreeList := AOwner;
end;

function TcxTreeListBands.Add: TcxTreeListBand;
begin
  Result := TcxTreeListBand(inherited Add);
  Update(nil);
end;

function TcxTreeListBands.GetAbsoluteIndex(VisibleIndex: Integer): Integer;
begin
  if (VisibleIndex >= 0) and (VisibleIndex < TreeList.FBandsVisibleList.Count) then
    Result := TcxTreeListBand(TreeList.FBandsVisibleList.List[VisibleIndex]).Index
  else
    Result := -1;
end;

function TcxTreeListBands.GetVisibleIndex(AbsoluteIndex: Integer): Integer;
begin
  Result := TreeList.FBandsVisibleList.IndexOf(inherited GetItem(AbsoluteIndex));
end;

procedure TcxTreeListBands.RestoreDefaults;
var
  I: Integer;
begin
  TreeList.BeginUpdate;
  try
    for I := 0 to Count - 1 do
      Items[I].RestoreDefaults;
  finally
    TreeList.EndUpdate;
  end;
end;

procedure TcxTreeListBands.RestoreWidths;
var
  I: Integer;
begin
  TreeList.BeginUpdate;
  try
    for I := 0 to Count - 1 do
      Items[I].RestoreWidths;
  finally
    TreeList.EndUpdate;
  end;
end;

procedure TcxTreeListBands.RealignColumns;
var
  I: Integer;
begin
  TreeList.FHeaderLineCount := 0;
  for I := 0 to TreeList.VisibleBandCount - 1 do
    TreeList.VisibleBands[I].RealignColumns;
end;

function TcxTreeListBands.GetOwner: TPersistent;
begin
  Result := FTreeList;
end;

procedure TcxTreeListBands.RefreshBandStates;
var
  I: Integer; 
  ALastVisible, AFirstVisible: TcxTreeListBand;

  procedure CheckFixed(ABand: TcxTreeListBand);
  begin
    if (ABand = AFirstVisible) or (ABand = ALastVisible) then Exit;
    ABand.FixedKind := tlbfNone;
  end;

begin
  TreeList.FBandsVisibleList.Sort(cxCompareVisibleBands);
  AFirstVisible := FirstVisible;
  ALastVisible := LastVisible;
  for I := 0 to Count - 1 do
    CheckFixed(TcxTreeListBand(inherited GetItem(I)));
end;

procedure TcxTreeListBands.Update(Item: TCollectionItem);
begin
  if FTreeList = nil then Exit;
  if FTreeList.Bands.Count <> 1 then
    FTreeList.FDefaultLayout := False;
  with FTreeList do
  begin
    if IsLoading or IsDestroying then Exit;
    if not IsLocked then RefreshBandStates;
  end;
  TreeList.DoUpdateDesignerForms;
  TreeList.UpdateViewStyles;
end;

{$IFDEF DELPHI6}

procedure TcxTreeListBands.Notify(Item: TCollectionItem; Action: TCollectionNotification);
var
  I: Integer;
begin
  if (Action = cnExtracting) and (TreeList <> nil) and not TreeList.IsDestroying then
  begin
    TreeList.FBandsVisibleList.Remove(Item);
    for I := 0 to TreeList.ColumnCount - 1 do
      if TreeList.Columns[I].FOwnerBand = Item then
        TreeList.Columns[I].FOwnerBand := nil;
  end;
  inherited Notify(Item, Action);
end;

{$ENDIF}

// IInterface
function TcxTreeListBands.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := cxE_NOINTERFACE;
end;

function TcxTreeListBands._AddRef: Integer;
begin
  Result := -1;
end;

function TcxTreeListBands._Release: Integer;
begin
  Result := -1;
end;

// IcxStoredObject }
function TcxTreeListBands.GetObjectName: string;
begin
  Result := 'Bands';
end;

function TcxTreeListBands.GetProperties(AProperties: TStrings): Boolean;
begin
  Result := True;
end;

procedure TcxTreeListBands.GetPropertyValue(
  const AName: string; var AValue: Variant);
begin
end;

procedure TcxTreeListBands.SetPropertyValue(
  const AName: string; const AValue: Variant);
begin
end;

// IcxStoredParent
function TcxTreeListBands.CreateChild(
  const AObjectName, AClassName: string): TObject;
begin
  if AClassName = 'TcxTreeListBand' then
    Result := Add
  else
    Result := nil;
end;

procedure TcxTreeListBands.DeleteChild(const AObjectName: string; AObject: TObject);
begin
  AObject.Free;
end;

procedure TcxTreeListBands.GetChildren(AChildren: TStringList);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    AChildren.AddObject('', Items[I]);
end;

function TcxTreeListBands.GetItem(AIndex: Integer): TcxTreeListBand;
begin
  Result := TcxTreeListBand(inherited GetItem(AIndex));
end;

function TcxTreeListBands.GetVisibleItemEx(AIndex: Integer): TcxTreeListBand;
begin
  with TreeList.FBandsVisibleList do
  begin
    if Count = 0 then
      Result := nil
    else
      if AIndex = 0 then
        Result := TcxTreeListBand(List^[0])
      else
        Result := TcxTreeListBand(List^[Count - 1]);
  end;
end;

procedure TcxTreeListBands.SetItem(AIndex: Integer; Value: TcxTreeListBand);
begin
  inherited GetItem(AIndex).Assign(Value);
end;

{ TcxTreeListBandRow }

constructor TcxTreeListBandRow.Create(AOwner: TcxTreeListBandRows);
begin
  FBandRows := AOwner; 
  FItems := TList.Create;
end;

destructor TcxTreeListBandRow.Destroy;
begin
  FreeAndNil(FItems);
  inherited Destroy;
end;

function TcxTreeListBandRow.IndexOf(AColumn: TcxTreeListColumn): Integer;
begin
  Result := FItems.IndexOf(AColumn);
end;

function TcxTreeListBandRow.GetRowMinWidth: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do
    Inc(Result, Items[I].GetRealMinWidth);
end;

function TcxTreeListBandRow.GetMaxColumnWidth(
  AColumn: TcxTreeListColumn): Integer;
var
  I, J: Integer;
begin
  Result := Band.DisplayWidth;
  J := FItems.IndexOf(AColumn);
  if J = Count - 1 then
    for I := Count - 2 downto 0 do
      Dec(Result, Items[I].GetRealMinWidth)
  else
    for I := 0 to Count - 1 do
    begin
      if I < J then
        Dec(Result, Items[I].DisplayWidth)
      else
        if I > J then
          Dec(Result, Items[I].GetRealMinWidth);
    end;
end;

procedure TcxTreeListBandRow.UpdateInformation;
var
  I: Integer;
begin
  FLineOffset := 0;
  FLineCount := 0;
  with FItems do
    for I := 0 to Count - 1 do
      FLineCount := cxMax(FLineCount, TcxTreeListColumn(List^[I]).Position.LineCount);
end;

procedure TcxTreeListBandRow.AddColumn(AColumn: TcxTreeListColumn);
begin
  if not AColumn.IsHidden then
  begin
    Band.FVisibleColumns.Add(AColumn);
    FItems.Add(AColumn);
  end;
end;

procedure TcxTreeListBandRow.DoCalculateColumnsAutoWidth;
var
  I: Integer;
  AAutoWidth: TcxAutoWidthObject;
begin
  if Count = 0 then Exit;
  AAutoWidth := TcxAutoWidthObject.Create(Count);
  try
    AAutoWidth.AvailableWidth := Band.RealWidth;
    for I := 0 to Count - 1 do
      Items[I].InitAutoWidthItem(AAutoWidth.AddItem);
    AAutoWidth.Calculate;
    for I := 0 to Count - 1 do
      Items[I].FCalculatedWidth := AAutoWidth.Items[I].AutoWidth;
  finally
    AAutoWidth.Free;
  end;
end;

function TcxTreeListBandRow.GetBand: TcxTreeListBand;
begin
  Result := FBandRows.FBand;
end;

function TcxTreeListBandRow.GetCount: Integer;
begin
  Result := FItems.Count
end;

function TcxTreeListBandRow.GetIsFirst: Boolean;
begin
  Result := BandRows.First = Self;
end;

function TcxTreeListBandRow.GetFirst: TcxTreeListColumn;
begin
  Result := GetItemEx(0);
end;

function TcxTreeListBandRow.GetIndex: Integer;
begin
  Result := BandRows.FItems.IndexOf(Self);
end;

function TcxTreeListBandRow.GetIsLast: Boolean;
begin
  Result := BandRows.Last = Self;
end;

function TcxTreeListBandRow.GetItem(Index: Integer): TcxTreeListColumn;
begin
  Result := TcxTreeListColumn(FItems[Index])
end;

function TcxTreeListBandRow.GetItemEx(Index: Integer): TcxTreeListColumn;
begin
  if (Index >= 0) and (Index < FItems.Count) then
    Result := TcxTreeListColumn(FItems.List^[Index])
  else
    Result := nil;
end;

function TcxTreeListBandRow.GetLast: TcxTreeListColumn;
begin
  Result := GetItemEx(FItems.Count - 1);
end;

function TcxTreeListBandRow.GetLineCount: Integer;
begin
  if FLineCount = 0 then
  begin
    Result := LineOffset;
    UpdateInformation;
    FLineOffset := Result;
  end;
  Result := FLineCount;
end;

function TcxTreeListBandRow.GetMinWidth: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do
    cxSetMax(Result, Items[I].GetRealMinSize);
end;

function TcxTreeListBandRow.GetTreeList: TcxCustomTreeListControl;
begin
  Result := FBandRows.FBand.GetTreeList;
end;

function TcxTreeListBandRow.GetWidth: Integer;
var
  I: Integer; 
begin
  Result := 0;
  for I := 0 to Count - 1 do
    Inc(Result, Items[I].DisplayWidth);
  if Result = 0 then
    Result := Band.DisplayWidth;
end;

{ TcxTreeListBandRows }

constructor TcxTreeListBandRows.Create(AOwner: TcxTreeListBand);
begin
  FBand := AOwner;
  FItems := TList.Create;
end;

destructor TcxTreeListBandRows.Destroy;
begin
  Clear;
  FreeAndNil(FItems);
  inherited Destroy;
end;

function TcxTreeListBandRows.Add: TcxTreeListBandRow;
begin
  Result := TcxTreeListBandRow.Create(Self);
  FItems.Add(Result);
end;

function TcxTreeListBandRows.CalculateAvaliableMinWidth: Integer;

  function GetRowMinWidth(ARow: TcxTreeListBandRow): Integer;
  var
    I: Integer;
  begin
    Result := 0;
    for I := 0 to ARow.Count - 1 do
      Inc(Result, ARow[I].FMinWidth);
  end;

var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do
    Result := cxMax(Result, GetRowMinWidth(Items[I]));
end;

procedure TcxTreeListBandRows.Clear;
var
  I: Integer;
begin
  for I := 0 to FItems.Count - 1 do
    FreeAndNil(TcxTreeListBandRow(FItems.List^[I]));
  FItems.Clear;
end;

procedure TcxTreeListBandRows.Refresh;

  procedure CheckColumns(AList: TList);
  var
    I, ARow, ACurRow: Integer;
  begin
    ARow := cxInvalidIndex;
    ACurRow := 0;
    for I := 0 to AList.Count - 1 do
      with TcxTreeListColumn(AList.List^[I]) do
      begin
        if not Visible then Continue;
        if ARow <> Position.FRowIndex then
        begin
          if ARow <> cxInvalidIndex then
            Inc(ACurRow);
          ARow := Position.FRowIndex
        end;
        Position.FRowIndex := ACurRow;
      end;
  end;

var
  ABandRow: TcxTreeListBandRow;
  AColumn: TcxTreeListColumn;
  I, ARow, ACol, AMaxRowWidth, AMinRowWidth, AVisibleIndex: Integer;
begin
  Clear;
  Band.FVisibleColumns.Clear;
  ABandRow := nil;
  Band.FColumns.Sort(cxCompareColumnsPos);
  CheckColumns(Band.FColumns);
  ARow := -1;
  ACol := -1;
  FColumnsMaxWidth := Band.Width;
  FColumnsMinWidth := Band.FMinWidth;
  AMaxRowWidth := 0;
  AMinRowWidth := 0;
  AVisibleIndex := 0;
  for I := 0 to Band.FColumns.Count - 1 do
  begin
    AColumn := TcxTreeListColumn(Band.FColumns.List^[I]);
    Inc(ACol);
    if AColumn.Position.FRowIndex <> ARow then
    begin
      Inc(ARow);
      AMaxRowWidth := 0;
      AMinRowWidth := 0;
      ACol := 0;
      ABandRow := Add;
    end;
    if AColumn.Visible and not AColumn.IsPreview then
    begin
      Inc(AMaxRowWidth, AColumn.Width);
      Inc(AMinRowWidth, AColumn.MinWidth);
      FColumnsMinWidth := Max(FColumnsMinWidth, AMinRowWidth);
      FColumnsMaxWidth := Max(FColumnsMaxWidth, AMaxRowWidth);
      AColumn.FVisibleIndexAtBand := AVisibleIndex;
      Inc(AVisibleIndex);
    end;
    if not Band.TreeList.IsUpdating then
    begin
      AColumn.Position.FColIndex := ACol; //todo: fixed B20392  
      AColumn.Position.FRowIndex := ARow;
    end;
    if ABandRow <> nil then
      ABandRow.AddColumn(AColumn);
  end;
  if FColumnsMaxWidth = 0 then
    FColumnsMaxWidth := cxTreeListDefWidth;
  if Band.Width <> 0 then
    FColumnsMaxWidth := Max(FColumnsMinWidth, Band.Width);
  UpdateInformation;
end;

procedure TcxTreeListBandRows.UpdateInformation;
var
  I: Integer;
begin
  FLineCount := 0;
  for I := 0 to Count - 1 do
  begin
    with Items[I] do
    begin
      UpdateInformation;
      FLineOffset := Self.FLineCount;
      Inc(Self.FLineCount, LineCount);
    end;
  end;
  with Band.TreeList do
    FHeaderLineCount := cxMax(FHeaderLineCount, LineCount);
end;

function TcxTreeListBandRows.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxTreeListBandRows.GetFirst: TcxTreeListBandRow;
begin
  Result := GetItemEx(0);
end;

function TcxTreeListBandRows.GetItem(Index: Integer): TcxTreeListBandRow;
begin
  Result := TcxTreeListBandRow(FItems[Index]);
end;

function TcxTreeListBandRows.GetItemEx(Index: Integer): TcxTreeListBandRow;
begin
  if (Index < 0) or (Index >= Count) then
    Result := nil
  else
    Result := Items[Index];
end;

function TcxTreeListBandRows.GetLast: TcxTreeListBandRow;
begin
  Result := GetItemEx(FItems.Count - 1);
end;

function TcxTreeListBandRows.GetMinWidth: Integer;
var
  I: Integer;
begin
  Result := Band.FMinWidth;
  for I := 0 to Count - 1 do
    cxSetMax(Result, Items[I].MinWidth);
end;

function TcxTreeListBandRows.GetLeftMostMinWidth: Integer;
var
  I: Integer;
begin
  Result := Band.FMinWidth;
  for I := 0 to Count - 1 do
    if Items[I].Count > 0 then
      cxSetMin(Result, Items[I][0].MinWidth);
end;

function TcxTreeListBandRows.GetLeftMostWidth: Integer;
var
  I: Integer;
begin
  Result := MaxInt;
  for I := 0 to Count - 1 do
    if Items[I].Count > 0 then
      cxSetMin(Result, Items[I][0].RealWidth);
  if Result = MaxInt then
    Result := Band.RealWidth;
end;

{ TcxTreeListOptionsView }

constructor TcxTreeListOptionsView.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FIndicatorWidth := cxTreeListDefIndicatorWidth;
  FBandLineCount := cxTreeListDefBandHeaderLineCount;
  FFixedSeparatorColor := clDefault;
  FFixedSeparatorWidth := cxTreeListDefSeparatorWidth;
  FDropArrowColor := cxTreeListDefDropArrowColor;
  Bands := cxTreeListDefBands;
  Buttons := True;
  Headers := cxTreeListDefColumnHeaders;
  Footer := cxTreeListDefFooter;
  FFixedSeparatorColor := clDefault;
  ColumnAutoWidth := cxTreeListDefColumnAutoWidth;
  FGridLineColor := clDefault;
  FTreeLineColor := clDefault;
  FTreeLineStyle := tllsDot;
  UseNodeColorForIndent := True;
  UseImageIndexForSelected := True;
  ShowRoot := True;
end;

procedure TcxTreeListOptionsView.Assign(Source: TPersistent);
var
  ASource: TcxTreeListOptionsView;
begin
  if Source is TcxTreeListOptionsView then
  begin
    ASource := TcxTreeListOptionsView(Source);
    HeaderSingleLine := ASource.HeaderSingleLine;
    FState := ASource.FState;
    if ASource.FCategorizedColumn <> nil then
      FCategorizedColumn := TreeList.Columns[ASource.FCategorizedColumn.ItemIndex]
    else
      FCategorizedColumn := nil;
    FBandLineCount := ASource.FBandLineCount;
    FIndicatorWidth := ASource.FIndicatorWidth;
    FFixedSeparatorColor := ASource.FFixedSeparatorColor;
    FFixedSeparatorWidth := ASource.FixedSeparatorWidth;
    FGridLines := ASource.FGridLines;
    FGridLineColor := ASource.GridLineColor;
    FDropArrowColor := ASource.FDropArrowColor;
    FPaintStyle := ASource.FPaintStyle;
    FTreeLineColor := ASource.FTreeLineColor;
    FTreeLineStyle := ASource.FTreeLineStyle;
  end;
  inherited Assign(Source);
end;

function TcxTreeListOptionsView.GetCategorizedColumn: TcxTreeListColumn;
begin
  if FCategorizedColumn <> nil then
    Result := FCategorizedColumn
  else
    if TreeList.VisibleColumnCount > 0 then
      Result := TreeList.VisibleColumns[0]
    else
      Result := nil;
end;

procedure TcxTreeListOptionsView.RestoreDefaults;
begin
  FState := 0;
  FIndicatorWidth := cxTreeListDefIndicatorWidth;
  Headers := True;
end;

procedure TcxTreeListOptionsView.Changed;
begin
  TreeList.UpdateViewStyles;
end;

function TcxTreeListOptionsView.GetControl: TObject;
begin
  Result := TreeList;
end;

function TcxTreeListOptionsView.GetState(AIndex: Integer): Boolean;
begin
  Result := cxGetState(FState, AIndex);
end;

procedure TcxTreeListOptionsView.SetState(AIndex: Integer; Value: Boolean);
begin
  if cxSetState(FState, AIndex, Value) then Changed;
end;

function TcxTreeListOptionsView.HasImages(ANode: TcxTreeListNode): Boolean;
begin
  Result := TreeList.Images <> nil;
  if Result and (ANode <> nil) and (TreeList.DoGetNodeImageIndex(ANode, tlitImageIndex) < 0) then
    Result := False;
end;

function TcxTreeListOptionsView.HasStateImages(ANode: TcxTreeListNode): Boolean;
begin
  Result := TreeList.StateImages <> nil;
  if Result and (ANode <> nil) and (TreeList.DoGetNodeImageIndex(ANode, tlitStateIndex) < 0) then
    Result := False;
end;

function TcxTreeListOptionsView.HorzIncrement: Integer;
begin
  Result := Byte(GridLines in [tlglVert, tlglBoth])
end;

function TcxTreeListOptionsView.IsCategorizedPaint: Boolean;
begin
  Result := PaintStyle = tlpsCategorized;
end;

function TcxTreeListOptionsView.IsExtPaintStyle: Boolean;
begin
  Result := ExtPaintStyle and (GetTreeList.LookAndFeel.SkinPainter = nil);
end;

function TcxTreeListOptionsView.IsRowAutoHeight: Boolean;
begin
  Result := (TreeList.HeaderLineCount = 1) and
    (CellAutoHeight or Assigned(TreeList.FOnGetNodeHeight));
end;

function TcxTreeListOptionsView.VertIncrement: Integer;
begin
  Result := Byte(GridLines in [tlglHorz, tlglBoth])
end;

function TcxTreeListOptionsView._AddRef: Integer;
begin
  Result := -1;
end;

function TcxTreeListOptionsView._Release: Integer;
begin
  Result := -1;
end;

function TcxTreeListOptionsView.QueryInterface(
  const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := cxE_NOINTERFACE;
end;

function TcxTreeListOptionsView.GetTreeList: TcxCustomTreeListControl;
begin
  Result := TcxCustomTreeListControl(EditingControl);
end;

procedure TcxTreeListOptionsView.SetCategorizedColumn(Value: TcxTreeListColumn);
begin
  FCategorizedColumn := Value;
  Changed; 
end;

procedure TcxTreeListOptionsView.SetColumnAutoWidth(Index: Integer; Value: Boolean);
begin
  if cxSetState(FState, Index, Value) then
    Changed;
end;

procedure TcxTreeListOptionsView.SetBandLineCount(Value: Integer);
begin
  if cxValidateIntDefEx(Value, FBandLineCount, 1) then
  begin
    FBandLineCount := Value;
    if Bands then Changed;
  end;
end;

procedure TcxTreeListOptionsView.SetIndicatorWidth(Value: Integer);
begin
  if cxValidateIntDefEx(Value, FIndicatorWidth, 0) then
  begin
    FIndicatorWidth := Value;
    if Indicator then Changed;
  end;
end;

procedure TcxTreeListOptionsView.SetFixedSeparatorColor(Value: TColor);
begin
  if Value <> FFixedSeparatorColor then
  begin
    FFixedSeparatorColor := Value;
    Changed;
  end;
end;

procedure TcxTreeListOptionsView.SetFixedSeparatorWidth(Value: Integer);
begin
   if cxValidateIntDefEx(Value, FFixedSeparatorWidth, 0) then
   begin
     FFixedSeparatorWidth := Value;
     Changed;
   end;
end;

procedure TcxTreeListOptionsView.SetGridLineColor(Value: TColor);
begin
  if Value <> FGridLineColor then
  begin
    FGridLineColor := Value;
    if GridLines <> tlglNone then Changed;
  end;
end;

procedure TcxTreeListOptionsView.SetGridLines(Value: TcxTreeListGridLines);
begin
  if Value <> FGridLines then
  begin
    FGridLines := Value;
    TreeList.UpdateViewStyles;
  end;
end;

procedure TcxTreeListOptionsView.SetHeaderSingleLine(
  Index: Integer; Value: Boolean);
var
  I: Integer; 
begin
  if Value <> HeaderSingleLine then
  begin
    if Value then
      for I := 0 to TreeList.ColumnCount - 1 do
        cxValidateSingleLine(TreeList.Columns[I].Position);
    SetState(Index, Value);
  end;
end;

procedure TcxTreeListOptionsView.SetPaintStyle(Value: TcxTreeListPaintStyle);
begin
  if FPaintStyle <> Value then
  begin
    FPaintStyle := Value;
    TreeList.UpdateViewStyles;
  end;
end;

procedure TcxTreeListOptionsView.SetTreeLineColor(Value: TColor);
begin
  if Value <> FTreeLineColor then
  begin
    FTreeLineColor := Value;
    Changed;
  end;
end;

procedure TcxTreeListOptionsView.SetTreeLineStyle(Value: TcxTreeListTreeLineStyle);
begin
  if Value <> FTreeLineStyle then
  begin
    FTreeLineStyle := Value;
    Changed;
  end;
end;

{ TcxTreeListOptionsCustomizing }

constructor TcxTreeListOptionsCustomizing.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FState := Integer($FFFFFFFF);  
  DynamicSizing := False;
  RowSizing := False;
end;

procedure TcxTreeListOptionsCustomizing.Assign(Source: TPersistent);
begin
  if Source is TcxTreeListOptionsCustomizing then
    FState := TcxTreeListOptionsCustomizing(Source).FState
  else
    inherited Assign(Source);
end;

function TcxTreeListOptionsCustomizing.GetState(Index: Integer): Boolean;
begin
  Result := cxGetState(FState, Index);
end;

procedure TcxTreeListOptionsCustomizing.SetState(Index: Integer; Value: Boolean);
begin
  cxSetState(FState, Index, Value);
end;

function TcxTreeListOptionsCustomizing.GetTreeList: TcxCustomTreeListControl;
begin
  Result := TcxCustomTreeListControl(GetOwner);
end;

{ TcxTreeListOptionsSelection }

constructor TcxTreeListOptionsSelection.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  CellSelect := True;
  HideFocusRect := True;
  HideSelection := False;
  InvertSelect := True;
  MultiSelect := False;
end;

procedure TcxTreeListOptionsSelection.Assign(Source: TPersistent);
begin
  if Source is TcxTreeListOptionsSelection then
    FState := TcxTreeListOptionsSelection(Source).FState
  else
    inherited Assign(Source);
end;

procedure TcxTreeListOptionsSelection.Changed;
begin
  TreeList.LayoutChanged;
end;

function TcxTreeListOptionsSelection.GetSelectionState(Index: Integer): Boolean;
begin
  Result := cxGetState(FState, Index);
end;

procedure TcxTreeListOptionsSelection.SetSelectionState(Index: Integer; Value: Boolean);
begin
  if cxSetState(FState, Index, Value) then Changed;
end;

function TcxTreeListOptionsSelection.GetTreeList: TcxCustomTreeListControl;
begin
  Result := TcxCustomTreeListControl(GetOwner);
end;

{ TcxTreeListOptionsBehavior }

constructor TcxTreeListOptionsBehavior.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  ConfirmDelete := True;
  DragCollapse := True;
  DragExpand := True;
  ExpandOnIncSearch := False;
  ShowHourGlass := True;
  Sorting := True;
  MultiSort := True;
  AutomateLeftMostIndent := True;
  FWaitExpandingTime := cxTreeListDefWaitExpandTime;
  ExpandOnDblClick := True;
end;

procedure TcxTreeListOptionsBehavior.Assign(Source: TPersistent);
begin
  if Source is TcxTreeListOptionsBehavior then
  begin
    FState := TcxTreeListOptionsBehavior(Source).FState;
    FWaitExpandingTime := TcxTreeListOptionsBehavior(Source).FWaitExpandingTime;
  end;
  inherited Assign(Source);  
end;

function TcxTreeListOptionsBehavior.GetState(Index: Integer): Boolean;
begin
  Result := cxGetState(FState, Index);
end;

procedure TcxTreeListOptionsBehavior.SetState(Index: Integer; Value: Boolean);
begin
  cxSetState(FState, Index, Value);
end;

function TcxTreeListOptionsBehavior.GetChangeDelay: Integer;
begin
  Result := TreeList.FDelayTimer.Interval;
end;

function TcxTreeListOptionsBehavior.GetIncSearchItem: TcxTreeListColumn;
begin
  Result := TcxTreeListColumn(inherited IncSearchItem);
end;

function TcxTreeListOptionsBehavior.GetTreeList: TcxCustomTreeListControl;
begin
  Result := TcxCustomTreeListControl(GetOwner);
end;

procedure TcxTreeListOptionsBehavior.SetAutomateLeftMostIndent(
  Index: Integer; Value: Boolean);
begin
  SetState(Index, Value);
end;

procedure TcxTreeListOptionsBehavior.SetChangeDelay(Value: Integer);
begin
  if Value < 0 then Value := 0;
  TreeList.FDelayTimer.Enabled := Value > 0;
  TreeList.FDelayTimer.Interval := Value;
end;

procedure TcxTreeListOptionsBehavior.SetIncSearchItem(Value: TcxTreeListColumn);
begin
  inherited IncSearchItem := Value;
end;

{ TcxTreeListOptionsData }

constructor TcxTreeListOptionsData.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  Deleting := True; 
end;

procedure TcxTreeListOptionsData.Assign(Source: TPersistent);
begin
  if Source is TcxTreeListOptionsData then
  begin
    FState := TcxTreeListOptionsData(Source).FState;
    SummaryNullIgnore := TcxTreeListOptionsData(Source).SummaryNullIgnore;
  end;
  inherited Assign(Source);
end;

procedure TcxTreeListOptionsData.Changed;
begin
  inherited Changed;
  TcxCustomTreeListControl(GetOwner).RefreshNavigatorButtons; 
end;

function TcxTreeListOptionsData.GetState(Index: Integer): Boolean;
begin
  Result := cxGetState(FState, Index);
end;

procedure TcxTreeListOptionsData.SetState(Index: Integer; Value: Boolean);
begin
  cxSetState(FState, Index, Value);
  Changed;
end;

function TcxTreeListOptionsData.GetAnsiSort: Boolean;
begin
  Result := dcoAnsiSort in
    TcxCustomTreeListControl(GetOwner).DataController.Options;
end;

function TcxTreeListOptionsData.GetCaseInsensitive: Boolean;
begin
  Result := dcoCaseInsensitive in
    TcxCustomTreeListControl(GetOwner).DataController.Options;
end;

function TcxTreeListOptionsData.GetSummaryNullIgnore: Boolean;
begin
  Result := soNullIgnore in
    TcxCustomTreeListControl(GetOwner).DataController.Summary.Options;
end;

procedure TcxTreeListOptionsData.SetAnsiSort(Value: Boolean);
begin
  with TcxCustomTreeListControl(GetOwner).DataController do
  begin
    if Value then
      Options := Options + [dcoAnsiSort]
    else
      Options := Options - [dcoAnsiSort]
  end;
end;

procedure TcxTreeListOptionsData.SetCaseInsensitive(Value: Boolean);
begin
  with TcxCustomTreeListControl(GetOwner).DataController do
  begin
    if Value then
      Options := Options + [dcoCaseInsensitive]
    else
      Options := Options - [dcoCaseInsensitive]
  end;
end;

procedure TcxTreeListOptionsData.SetSummaryNullIgnore(Value: Boolean);
begin
  if Value then
    TcxCustomTreeListControl(GetOwner).DataController.Summary.Options := [soNullIgnore]
  else
    TcxCustomTreeListControl(GetOwner).DataController.Summary.Options := [];
end;

{ TcxTreeListPreview }

constructor TcxTreeListPreview.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FAutoHeight := True;
  FLeftIndent := cxTreeListDefPreviewMaxLineCount;
  FMaxLineCount := cxTreeListDefPreviewMaxLineCount;
  FRightIndent := cxTreeListDefPreviewIndent;
end;

procedure TcxTreeListPreview.Assign(Source: TPersistent);
var
  APreview: TcxTreeListPreview;
begin
  if Source is TcxTreeListPreview then
  begin
    APreview := TcxTreeListPreview(Source);
    AutoHeight := APreview.AutoHeight;
    if APreview.Column <> nil then
      Column := TreeList.Columns[APreview.Column.ItemIndex];
    LeftIndent := APreview.LeftIndent;
    MaxLineCount := APreview.MaxLineCount;
    Place := APreview.Place;
    RightIndent := APreview.RightIndent;
    Visible := APreview.Visible;
  end
  else
    inherited Assign(Source);
end;

procedure TcxTreeListPreview.Changed(ACheckActivate: Boolean);
begin
  if not ACheckActivate or (ACheckActivate and Active) then
    TreeList.UpdateViewStyles;
end;

function TcxTreeListPreview.GetControl: TObject;
begin
  Result := TreeList;
end;

function TcxTreeListPreview.GetActive: Boolean;
begin
  Result := Visible and (FColumn <> nil);
end;

function TcxTreeListPreview.GetTreeList: TcxCustomTreeListControl;
begin
  Result := TcxCustomTreeListControl(GetOwner);
end;

procedure TcxTreeListPreview.SetAutoHeight(Value: Boolean);
begin
  if Value <> FAutoHeight then
  begin
    FAutoHeight := Value;
    Changed(True);
  end;
end;

procedure TcxTreeListPreview.SetColumn(Value: TcxTreeListColumn);
begin
  if Value <> FColumn then
  begin
    FColumn := Value;
    Changed(False);
  end;
end;

procedure TcxTreeListPreview.SetLeftIndent(Value: Integer);
begin
  if cxValidateIntDefEx(Value, FLeftIndent, 0) then
  begin
    FLeftIndent := Value;
    Changed(True)
  end;
end;

procedure TcxTreeListPreview.SetMaxLineCount(Value: Integer);
begin
  if cxValidateIntDefEx(Value, FMaxLineCount, 0) then
  begin
    FMaxLineCount := Value;
    Changed(True);
  end;
end;

procedure TcxTreeListPreview.SetPlace(Value: TcxTreeListPreviewPlace);
begin
  if Value <> FPlace then
  begin
    FPlace := Value;
    Changed(True);
  end;
end;

procedure TcxTreeListPreview.SetRightIndent(Value: Integer);
begin
  if cxValidateIntDefEx(Value, FRightIndent, 0) then
  begin
    FRightIndent := Value;
    Changed(True)
  end;
end;

procedure TcxTreeListPreview.SetVisible(Value: Boolean);
begin
  if Value <> FVisible then
  begin
    FVisible := Value;
    Changed(False);
  end;
end;

{ TcxTreeListStyleSheet }

function TcxTreeListStyleSheet.GetStylesValue: TcxTreeListStyles;
begin
  Result := TcxTreeListStyles(GetStyles)
end;

procedure TcxTreeListStyleSheet.SetStylesValue(Value: TcxTreeListStyles);
begin
  SetStyles(Value);
end;

class function TcxTreeListStyleSheet.GetStylesClass: TcxCustomStylesClass;
begin
  Result := TcxTreeListStyles;
end;

{ TcxTreeListStyles }

procedure TcxTreeListStyles.Assign(Source: TPersistent);
var
  I: Integer; 
begin
  if Source is TcxTreeListStyles then
  begin
    for I := tlsv_BandBackground to tlsv_Preview do
      SetValue(I, TcxTreeListStyles(Source).GetValue(I));
  end;
  inherited Assign(Source);
end;

function TcxTreeListStyles.GetBandBackgroundParams(
  ABand: TcxTreeListBand): TcxViewParams;
begin
  cxStylesToViewParams(Self, tlsv_BandBackground, nil,
     [GetStyleFromEvent(FOnGetBandBackgroundStyle, ABand),
       ABand.Styles.HeaderBackground, BandBackground], Result);
end;

function TcxTreeListStyles.GetBandContentParams(ABand: TcxTreeListBand;
  ANode: TcxTreeListNode): TcxViewParams;
begin
  DoGetBandContentParams(ANode, ABand, Result);
end;

function TcxTreeListStyles.GetBandHeaderParams(
  ABand: TcxTreeListBand): TcxViewParams;
begin
  cxStylesToViewParams(Self, tlsv_BandHeader, nil,
    [GetStyleFromEvent(FOnGetBandHeaderStyle, ABand),
      ABand.Styles.Header, BandHeader], Result);
end;

function TcxTreeListStyles.GetBandFooterParams(
  ABand: TcxTreeListBand): TcxViewParams;
begin
  cxStylesToViewParams(Self, tlsv_Footer, nil,
    [GetStyleFromEvent(FOnGetBandFooterStyle, ABand),
      ABand.Styles.Footer, Footer], Result);
end;

function TcxTreeListStyles.GetColumnContentParams(
  AColumn: TcxTreeListColumn; IsOdd: Boolean): TcxViewParams;
begin
  Result := AColumn.Styles.ContentParams[IsOdd];
end;

function TcxTreeListStyles.GetColumnHeaderParams(
  AColumn: TcxTreeListColumn): TcxViewParams;
begin
  cxStylesToViewParams(Self, tlsv_ColumnHeader, nil,
    [GetStyleFromEvent(FOnGetColumnHeaderStyle, AColumn),
      AColumn.Styles.Header, ColumnHeader], Result);
end;

function TcxTreeListStyles.GetColumnFooterParams(
  AColumn: TcxTreeListColumn): TcxViewParams;
begin
  if AColumn.OwnerBand <> nil then
  begin
    Result := GetBandFooterParams(AColumn.OwnerBand);
    cxParamsCombine(ColumnFooter,
      cxParamsCombine(AColumn.Styles.Footer, [], Result), Result) ;
  end
  else
    cxStylesToViewParams(Self, tlsv_ColumnFooter, nil,
      [GetStyleFromEvent(FOnGetColumnFooterStyle, AColumn),
        AColumn.Styles.Footer, ColumnFooter, Footer], Result);
end;

function TcxTreeListStyles.GetContentParams(ANode: TcxTreeListNode;
  AColumn: TcxTreeListColumn): TcxViewParams;
begin
  if not ANode.IsVisible then ANode.FVisibleIndex := -1;
  DoGetContentParams(ANode, AColumn, Result);
end;

function TcxTreeListStyles.GetFooterParams: TcxViewParams;
begin
  cxStylesToViewParams(Self, tlsv_Footer, nil, [Footer], Result);
end;

function TcxTreeListStyles.GetIncSearchParams: TcxViewParams;
begin
  GetViewParams(tlsv_IncSearch, nil, IncSearch, Result);
end;

function TcxTreeListStyles.GetIndentParams(
  ANode: TcxTreeListNode; AIndent: Integer): TcxViewParams;

  function GetIndentParams: TcxViewParams;
  var
    AStyle: TcxStyle;
  begin
    with TreeList.OptionsView do
    begin
      AIndent := ANode.Level - AIndent + Byte(ShowRoot);
      if IsCategorizedPaint then
        while AIndent > 0 do
        begin
          ANode := ANode.Parent;
          Dec(AIndent);
        end;
      AStyle := nil;
      if Assigned(FOnGetContentStyle) and (ANode <> ANode.Owner.Root) then
        FOnGetContentStyle(Control, nil, ANode, AStyle);
      if (UseNodeColorForIndent or (AIndent < 0)) then
      begin
        Result := ContentParams[Odd(ANode.FVisibleIndex)];
        cxParamsCombine(AStyle, [], Result);
      end
      else
        cxStylesToViewParams(Self, tlsv_Content, nil, [AStyle, Content], Result);
    end;
  end;

var
  AStyle: TcxStyle;
begin
  AStyle := nil;
  Result.Bitmap := nil;
  if Assigned(FOnGetNodeIndentStyle) then
    FOnGetNodeIndentStyle(Control, ANode, AIndent, AStyle);
  Result := GetIndentParams;
  cxParamsCombine(AStyle, [], Result);
end;

function TcxTreeListStyles.GetIndicatorParams: TcxViewParams;
begin
  cxStylesToViewParams(Self, tlsv_Indicator, nil, [Indicator], Result);
end;

function TcxTreeListStyles.GetPreviewParams(ANode: TcxTreeListNode): TcxViewParams;
var
  AStyle: TcxStyle;
begin
  DoGetContentParams(ANode, TreeList.Preview.Column, Result);
  AStyle := GetStyleFromEvent(FOnGetPreviewStyle, ANode);
  cxParamsCombine(Preview, cxParamsCombine(AStyle, [], Result), Result);
end;

procedure TcxTreeListStyles.ContentStyleChanged;
var
  I: Integer;
  B: Boolean;
begin
  cxStylesToViewParams(Self, tlsv_Preview, nil, [Preview], CachedPreviewStyle);
  for B := False to True do
  begin
    cxStylesToViewParams(Self, tlsv_Content, nil,
      [GetValue(tlsv_ContentEven + Byte(B)), Content], ContentParams[B]);
  end;
  with TreeList do
  begin
    for I := 0 to Bands.Count - 1 do
      Bands[I].Styles.CachedContentStyleChanged;
    for I := 0 to ColumnCount - 1 do
      Columns[I].Styles.CachedContentStyleChanged;
  end;
end;

procedure TcxTreeListStyles.DoGetContentParams(
  ANode: TcxTreeListNode; AColumn: TcxTreeListColumn; var AParams: TcxViewParams);
var
  AStyle: TcxStyle;
  AValues: TcxStyleValues;
begin
  if AColumn <> TreeList.Preview.Column then
  begin
    AParams := AColumn.Styles.ContentParams[Odd(ANode.FVisibleIndex)];
    if DoGetBandContentStyle(ANode, AColumn.OwnerBand, AStyle) then
      cxParamsCombine(AStyle, [], AParams);
   AStyle := nil;
  end
  else
  begin
    AStyle := nil;
    AParams := ContentParams[Odd(ANode.FVisibleIndex)];
  end;
  if Assigned(FOnGetContentStyle) then
    FOnGetContentStyle(Control, AColumn, ANode, AStyle);
  cxParamsCombine(AStyle, [], AParams);
  if ANode.HotTrack and (not TreeList.IsEditing or (TreeList.FocusedNode <> ANode)) then
  begin
    AStyle := nil;
    if Assigned(FOnGetHotTrackStyle) then
      FOnGetHotTrackStyle(Control, AColumn, ANode, AStyle);
    AValues := cxParamsCombine(HotTrack, cxParamsCombine(AStyle, [], AParams), AParams);
    if not (svTextColor in AValues) then
      AParams.TextColor := clHighLightText;
  end;
end;

procedure TcxTreeListStyles.DoGetBandContentParams(
  ANode: TcxTreeListNode; ABand: TcxTreeListBand; var AParams: TcxViewParams);
var
  AStyle: TcxStyle;
begin
  AParams := ABand.Styles.ContentParams[Odd(ANode.FVisibleIndex)];
  DoGetBandContentStyle(ANode, ABand, AStyle);
  cxParamsCombine(BandContent, cxParamsCombine(AStyle, [], AParams), AParams);
end;

function TcxTreeListStyles.DoGetBandContentStyle(
  ANode: TcxTreeListNode; ABand: TcxTreeListBand; out AStyle: TcxStyle): Boolean;
begin
  AStyle := nil;
  if Assigned(FOnGetBandContentStyle) then
    FOnGetBandContentStyle(TreeList, ABand, ANode, AStyle);
  Result := AStyle <> nil;
end;

procedure TcxTreeListStyles.GetDefaultViewParams(
  Index: Integer; AData: TObject; out AParams: TcxViewParams);
begin
  with TcxCustomTreeListControl(Control).LookAndFeelPainter, AParams do
  begin
    Bitmap := nil;
    Font := TcxCustomTreeListControl(Control).Font;
    case Index of
      tlsv_Preview, tlsv_ContentOdd, tlsv_ContentEven, tlsv_Content:
      begin
        Color := DefaultContentColor;
        TextColor := DefaultContentTextColor;
      end;
      tlsv_BandHeader, tlsv_Indicator, tlsv_ColumnHeader:
      begin
        Color := DefaultHeaderColor;
        TextColor := DefaultHeaderTextColor;
      end;
      tlsv_Footer, tlsv_ColumnFooter:
      begin
        Color := DefaultFooterColor;
        TextColor := DefaultFooterTextColor;
      end;
      tlsv_BandBackground:
      begin
        Color := DefaultHeaderBackgroundColor;
        TextColor := DefaultHeaderBackgroundTextColor;
      end;
      tlsv_IncSearch:
      begin
        Color := DefaultSelectionColor;
        TextColor := DefaultSelectionTextColor;
      end;
    else
      inherited GetDefaultViewParams(Index, AData, AParams);
    end;
  end;
end;

function TcxTreeListStyles.GetStyleFromEvent(
  const AEvent: TcxtlOnGetItemStyleEvent; AItem: TObject): TcxStyle;
begin
  Result := nil;
  if Assigned(AEvent) then AEvent(Control, AItem, Result);
end;

function TcxTreeListStyles.SelectionFontAssigned: Boolean;
begin
  if TreeList.Controller.Focused or Control.Focused then
    Result := (Selection <> nil) and (cxStyles.svFont in Selection.AssignedValues)
  else
    Result := (Inactive <> nil) and (cxStyles.svFont in Inactive.AssignedValues);
end;

function TcxTreeListStyles.GetTreeList: TcxCustomTreeListControl;
begin
  Result := TcxCustomTreeListControl(GetOwner);
end;

{ TcxTreeListItemsCustomizeListBox }

constructor TcxTreeListItemsCustomizeListBox.CreateEx(AOwner: TComponent;
  ATreeList: TcxCustomTreeListControl; IsBandListBox: Boolean);
begin
  inherited Create(AOwner);
  Style.HotTrack := False;
  FDragAndDropItemIndex := -1;
  OnMeasureItem := MeasureItem;
  InnerListBox.OnDrawItem := DoDrawItemEx;
  OnDrawItem := DoDrawItem;
  FTreeList := ATreeList;
  FIsBandListBox := IsBandListBox;
  ListStyle := lbOwnerDrawVariable;
  Style.LookAndFeel.MasterLookAndFeel := ATreeList.LookAndFeel;
end;

procedure TcxTreeListItemsCustomizeListBox.BeginDrag;
begin
  SetCaptureControl(TreeList);
  FPrevCursor := Screen.Cursor;
  if FDragAndDropObject <> nil then Exit;
  FDragAndDropObject := TcxTreeListDragAndDropObject.Create(TreeList);
  InitDragAndDropObject;
  TreeList.DragAndDropState := ddsStarting;
  TreeList.Customizing.FDragAndDropObject := FDragAndDropObject;
  FDragAndDropObject.BeginDragAndDrop;
  SetCaptureControl(Self);
  TreeList.Customizing.FForm.StartDeactivationTimer(Self);
  FAccepted := True;
end;

procedure TcxTreeListItemsCustomizeListBox.FocusChanged;
begin
  if not IsFocused then
    FinishDrag(False);
  inherited FocusChanged;
end;

procedure TcxTreeListItemsCustomizeListBox.DoDrawItem(AControl: TcxListBox;
  ACanvas: TcxCanvas; AIndex: Integer; ARect: TRect; AState: TOwnerDrawState);
var
  R: TRect;
  ABitmap: TBitmap;
  ABmpCanvas: TcxCanvas;
begin
  ABitmap := cxCreateBitmap(cxRectSize(ARect));
  ABmpCanvas := TcxCanvas.Create(ABitmap.Canvas);
  try
    R := cxRectOffset(ARect, cxPointInvert(ARect.TopLeft));
    with TcxTreeListHeaderViewInfo(Items.Objects[AIndex]) do
    begin
      InitViewParams;
      if Painter.HeaderDrawCellsFirst then
      begin
        ABmpCanvas.Brush.Color := Color;
        ABmpCanvas.FillRect(R);
      end;
      with  TcxTreeListControlPainter(TreeList.Painter) do
      begin
        ExtDrawHeader(ABmpCanvas, R, cxRectInflate(R, -2, -2), [],
          cxBordersAll, cxbsNormal, AlignHorz, AlignVert, False, True, Text,
          ViewParams.Font, ViewParams.TextColor, ViewParams.Color, nil);
      end;
    end;
    ACanvas.Draw(ARect.Left, ARect.Top, ABitmap);
  finally
    ABmpCanvas.Free;
    ABitmap.Free;
  end;
end;

procedure TcxTreeListItemsCustomizeListBox.DoDrawItemEx(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
end;

procedure TcxTreeListItemsCustomizeListBox.EndDrag(Accepted: Boolean);
begin
  if FDragAndDropObject <> nil then
  begin
    TreeList.BeginUpdate;
    try
      try
        if not Accepted then FAccepted := False;
        FDragAndDropObject.EndDragAndDrop(FAccepted);
      finally
        FreeAndNil(FDragAndDropObject);
        TreeList.Customizing.FDragAndDropObject := nil;
        Screen.Cursor := FPrevCursor;
      end;
    finally
      TreeList.DragAndDropState := ddsNone;
      if not FAccepted then
        TreeList.CancelUpdate
      else
        TreeList.EndUpdate;
    end;
    TreeList.Controller.EndDragAndDrop(Accepted);
  end;
end;

procedure TcxTreeListItemsCustomizeListBox.FinishDrag(Accepted: Boolean);

begin
  if FDragAndDropObject <> nil then
  begin
    TreeList.BeginUpdate;
    try
      try
        if not Accepted then FAccepted := False;
        with FDragAndDropObject do 
          DragDropInfo.Accepted := DragDropInfo.Accepted and FAccepted;
        FDragAndDropObject.EndDragAndDrop(FAccepted);
      finally
        FreeAndNil(FDragAndDropObject);
        TreeList.Customizing.FDragAndDropObject := nil;
        Screen.Cursor := FPrevCursor;
      end;
    finally
      TreeList.DragAndDropState := ddsNone;
      if not FAccepted then
        TreeList.CancelUpdate
      else
        TreeList.EndUpdate;
    end;
    TreeList.Controller.EndDragAndDrop(Accepted);
  end;
end;

procedure TcxTreeListItemsCustomizeListBox.InitDragAndDropObject;
var
  AInfo: TcxTreeListHeaderViewInfo;
begin
  FOrgPoint := Point(0, 0);
  MapWindowPoint(Handle, TreeList.Handle, FOrgPoint);
  AInfo := TcxTreeListHeaderViewInfo(Items.Objects[ItemIndex]);
  AInfo.InitViewParams;
  TreeList.Controller.DragItem := AInfo;
  AInfo.DisplayRect := cxRectOffset(ItemRect(ItemIndex),
    [cxPointInvert(ScreenToClient(Mouse.CursorPos)),
       cxPointInvert(TreeList.ClientToScreen(Point(0, 0)))]);
  AInfo.FTextBounds := cxRectInflate(AInfo.DisplayRect, -2, -2);
  AInfo.ClipRect := AInfo.DisplayRect;
  AInfo.ItemVisible := True;
end;

procedure TcxTreeListItemsCustomizeListBox.MouseDown(
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  if (Button = mbLeft) and (ItemAtPos(Point(X, Y), True) <> -1) then
  begin
    FDragAndDropItemIndex := ItemIndex;
    FMouseDownPos := Point(X, Y);
  end;
end;

procedure TcxTreeListItemsCustomizeListBox.MouseMove(
  Shift: TShiftState; X, Y: Integer);
begin
  if (FDragAndDropItemIndex <> -1) and
    (not IsPointInDragDetectArea(FMouseDownPos, X, Y) or
     (ItemAtPos(Point(X, Y), True) <> FDragAndDropItemIndex)) then
  begin
    ItemIndex := FDragAndDropItemIndex;
    BeginDrag;
    FDragAndDropItemIndex := -1;
  end;
  if FDragAndDropObject <> nil then
  begin
    TreeList.DragAndDropState := ddsInProcess;
    DragAndDropObject.PrevMousePos := DragAndDropObject.CurMousePos;
    DragAndDropObject.CurMousePos := ClientToScreen(Point(X, Y));
    DragAndDropObject.DragAndDrop(cxPointOffset(FOrgPoint, X, Y), FAccepted);
  end
  else
    inherited MouseMove(Shift, X, Y);
end;

procedure TcxTreeListItemsCustomizeListBox.MouseUp(
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  if DragAndDropObject <> nil then
  begin
    FinishDrag(True);
    RefreshList;
    Update;
  end;
  FDragAndDropItemIndex := -1;
end;

function TcxTreeListItemsCustomizeListBox.GetItemHeight(AItem: Integer): Integer;
begin
  if FIsBandListBox then
    Result := TreeList.RealBandLineHeight
  else
    Result := TreeList.ViewInfo.HeaderLineHeight;
  if Result = 0 then Result := ItemHeight;
end;

procedure TcxTreeListItemsCustomizeListBox.KeyDown(
  var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if (Key = VK_ESCAPE) and (FDragAndDropObject <> nil) then
  begin
    FDragAndDropObject.DragDropInfo.Accepted := False;
    FinishDrag(False);
  end;
end;

procedure TcxTreeListItemsCustomizeListBox.MeasureItem(AControl: TcxListBox;
  Index: Integer; var Height: Integer);
begin
  Height := GetItemHeight(Index);
end;

procedure TcxTreeListItemsCustomizeListBox.RefreshList;
var
  I: Integer;
  AIndex: Integer;
begin
  AIndex := ItemIndex;
  Items.BeginUpdate;
  Items.Clear;
  with FTreeList do
  try
    if FIsBandListBox then
    begin
      for I := 0 to Bands.Count - 1 do
        if not Bands[I].Visible and not Bands[I].Options.Hidden then
          Self.Items.AddObject('', Bands[I].ViewInfo.BandHeader);
    end
    else
    begin
      for I := 0 to ColumnCount - 1 do
        if not Columns[I].Visibility and not Columns[I].Options.Hidden then
          Self.Items.AddObject('', Columns[I].ViewInfo.ColumnHeader);
    end;
  finally
    if AIndex >= Self.Items.Count then
      AIndex := Self.Items.Count - 1;
    ItemIndex := AIndex;
    Self.Items.EndUpdate;
  end;
  Update;
end;

procedure TcxTreeListItemsCustomizeListBox.Resize;
begin
  inherited Resize;
  InnerListBox.Invalidate
end;

procedure TcxTreeListItemsCustomizeListBox.WMCancelMode(var Message: TWMCancelMode);
begin
  inherited;
  FinishDrag(False);
end;

function TcxTreeListItemsCustomizeListBox.GetPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := TreeList.LookAndFeel.Painter;
end;

{ TcxTreeListCustomizationForm }

constructor TcxTreeListCustomizationForm.CreateEx(AOwner: TcxTreeListCustomizing);
begin
  CreateNew(nil);
  FOwner := AOwner;
  FHookTimer := TcxTimer.Create(Self);
  FHookTimer.Enabled := False;
  FHookTimer.Interval := 10;
  FHookTimer.OnTimer := HookTimerHandler;   

  FDeactivationTimer := TTimer.Create(Self);
  FDeactivationTimer.Enabled := False;
  FDeactivationTimer.Interval := 10;
end;

destructor TcxTreeListCustomizationForm.Destroy;
begin
  FreeAndNil(FHookTimer);
  FreeAndNil(FDeactivationTimer);
  inherited Destroy;
end;

function TcxTreeListCustomizationForm.GetTreeList: TcxCustomTreeListControl;
begin
  Result := Customizing.TreeList;
end;

procedure TcxTreeListCustomizationForm.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
  begin
    Style := Style or WS_POPUP;
    if not TreeList.IsDestroying then
      WndParent := TreeList.Handle
    else
      WndParent := 0;
  end;
end;

procedure TcxTreeListCustomizationForm.DeactivationTimeHandler(Sender: TObject);
begin
  if not Active then
  begin
    StopDeactivationTimer;
  end;
end;

procedure TcxTreeListCustomizationForm.StartDeactivationTimer(
  Sender: TcxTreeListItemsCustomizeListBox);
begin
  FCustomizingListBox := Sender;
  FDeactivationTimer.Enabled := True;
  FDeactivationTimer.OnTimer := DeactivationTimeHandler;
end;

procedure TcxTreeListCustomizationForm.StopDeactivationTimer;
begin
  if FCustomizingListBox <> nil then
  try
    FCustomizingListBox.FinishDrag(False);
    FDeactivationTimer.Enabled := False;
    FDeactivationTimer.OnTimer := nil;
  finally
    FCustomizingListBox := nil;
    Invalidate; 
    Update;
  end;
end;

procedure TcxTreeListCustomizationForm.HookTimerHandler(Sender: TObject);
begin
  if IsIconic(Application.Handle) then
    Visible := False
  else
    if not TreeList.Visible or not IsWindowVisible(TreeList.Handle) then
      Customizing.Visible := False
    else
      if not Visible then
      begin
        ShowWindow(Handle, SW_SHOWNOACTIVATE);
        Visible := True;
      end;
end;

{ TcxTreeListCustomizing }

constructor TcxTreeListCustomizing.Create(AOwner: TPersistent);
begin
  FTreeList := TcxCustomTreeListControl(AOwner);
  FVisible := False;
  FRowCount := 10;
  FLastPosition := cxPoint(-1000, -1000);
end;

destructor TcxTreeListCustomizing.Destroy;
begin
  Visible := False;
  ReleaseControls;
  inherited Destroy;
end;

procedure TcxTreeListCustomizing.Assign(Source: TPersistent);
begin
  if Source is TcxTreeListCustomizing then
  begin
    RowCount := TcxTreeListCustomizing(Source).RowCount;
    Visible := TcxTreeListCustomizing(Visible).Visible;
  end;
end;

procedure TcxTreeListCustomizing.MakeBandSheetVisible;
begin
  Visible := True;
  if FBandListBox.Parent = FTabSheetBands then
    FPageControl.ActivePage := FTabSheetBands;
end;

procedure TcxTreeListCustomizing.MakeColumnSheetVisible;
begin
  Visible := True;
  if FHeaderListBox.Parent = FTabSheetHeaders then
    FPageControl.ActivePage := FTabSheetHeaders;
end;

function TcxTreeListCustomizing.PtInCustomizingBox(const APoint: TPoint): Boolean;
begin
  Result := Visible and (FForm <> nil) and PtInRect(FForm.BoundsRect, APoint);
end;

procedure TcxTreeListCustomizing.AdjustControls;
var
  AParent: TWinControl;
begin
  with TreeList do
  begin
    AParent := FForm;
    if not IsSimpleMode then
    begin
      SetControlParent(FPageControl, FForm);
      SetControlParent(FTabSheetBands, FPageControl);
      FTabSheetBands.PageControl := FPageControl;
      SetControlParent(FBandListBox, FTabSheetBands);
      if ColumnCount > 0 then
      begin
        SetControlParent(FTabSheetHeaders, FPageControl);
        FTabSheetHeaders.PageControl := FPageControl;
        AParent := FTabSheetHeaders;
      end;
    end;
    if ColumnCount > 0 then
      SetControlParent(FHeaderListBox, AParent);
  end;
  ShowCustomizingForm;
end;

procedure TcxTreeListCustomizing.Activate(Sender: TObject);
begin
end;

procedure TcxTreeListCustomizing.Close(Sender: TObject; var Action: TCloseAction);

  function CheckIndex(AListBox: TcxListBox): Integer;
  begin
    if (AListBox = nil) or (AListBox.Parent = nil) then
      Result := -1
    else
      Result := AListBox.ItemIndex;
  end;

begin
  if FForm <> nil then
    TcxTreeListCustomizationForm(FForm).HookTimer.Enabled := False;
  FLastPosition := FForm.BoundsRect.TopLeft;
  FLastHeaderIndex := CheckIndex(FHeaderListBox);
  FLastBandIndex := CheckIndex(FBandListBox);
  Action := caHide;
  FVisible := False;
  TreeList.DoOnCustomizationVisibleChanged;
end;

procedure TcxTreeListCustomizing.CreateControls;
begin
  if FForm <> nil then
  begin
    FForm.Show;
    Exit;
  end;
  CreateCustomizingForm;
  FForm.OnClose := Close;
  FHeaderListBox := TcxTreeListItemsCustomizeListBox.CreateEx(nil, TreeList, False);
  if not IsSimpleMode then
  begin
    FBandListBox := TcxTreeListItemsCustomizeListBox.CreateEx(nil, TreeList, True);
    FPageControl := TPageControl.Create(nil);
    FPageControl.HotTrack := True;
    FTabSheetBands := TTabSheet.Create(FPageControl);
    FTabSheetBands.Caption := cxGetResourceString(@scxBandsCaption);
    FTabSheetBands.TabVisible := True;
    FTabSheetHeaders := TTabSheet.Create(FPageControl);
    FTabSheetHeaders.Caption := cxGetResourceString(@scxColumnsCaption);
    FTabSheetBands.TabVisible := True;
  end;
  AdjustControls;
end;

procedure TcxTreeListCustomizing.CreateCustomizingForm;
var
  I: Integer;
const
  UnusedItems: array[0..4, 0..1] of Integer =
    ((7, MF_BYPOSITION), (5, MF_BYPOSITION), (SC_MAXIMIZE, MF_BYCOMMAND),
    (SC_MINIMIZE, MF_BYCOMMAND), (SC_RESTORE, MF_BYCOMMAND));
begin
  FForm := TcxTreeListCustomizationForm.CreateEx(Self);
  with FForm do
  begin
    Visible := False;
    Caption := cxGetResourceString(@scxCustomizeCaption);
    BorderStyle := bsSizeToolWin;
    BorderIcons := [biSystemMenu];
    Font.Assign(TreeList.Font);
    ClientWidth := SizeDelta.cx  * cxTextWidth(Font, '0');
    FLineHeight := cxTextHeight(Font) + SizeDelta.cy;
    ClientHeight := (RowCount + 1) * FLineHeight;
    Color := clBtnFace;
    OnActivate := Self.Activate;
    OnClose := Self.Close;
    OnShow := VisibleChanged;
    OnHide := VisibleChanged;
    for I := 0 to High(UnusedItems) do
      DeleteMenu(GetSystemMenu(Handle, False), UnusedItems[I, 0], UnusedItems[I, 1]);
  end;
end;

function TcxTreeListCustomizing.IsSimpleMode: Boolean;
begin
  with TreeList.OptionsView do
    Result := SimpleCustomizeBox or not Bands;
end;

procedure TcxTreeListCustomizing.LookAndFeelChanged;
begin
  if FBandListBox <> nil then
    FBandListBox.Invalidate;
  if FHeaderListBox <> nil then
    FHeaderListBox.Invalidate;
  if FPageControl <> nil then
    FPageControl.Invalidate;
end;

procedure TcxTreeListCustomizing.ReleaseControls;
begin
  TreeList.Designers.Remove(Self);
  if FForm <> nil then
  try
    FLastPosition := Point(FForm.Left, FForm.Top);
    FLastBandIndex := -1;
    FLastHeaderIndex := -1;
    FForm.Free
  finally
    FForm := nil;
  end;
end;

procedure TcxTreeListCustomizing.SetControlParent(AControl, AParent: TWinControl);
begin
  AControl.Parent := AParent;
  if AParent <> nil then
  begin
    AControl.Align := alClient;
    TControlAccess(AControl).ParentFont := True;
    TControlAccess(AControl).ParentColor := True;
    Visible := True;
  end;
end;

procedure TcxTreeListCustomizing.ShowCustomizingForm;
var
  R: TRect;
begin
  if (CustomizingPos.X <> -1000) and (CustomizingPos.Y <> -1000) then
  begin
    FForm.Left := CustomizingPos.X;
    FForm.Top := CustomizingPos.Y;
  end
  else
  begin
    if GetParentForm(TreeList) = nil then
      R := TreeList.BoundsRect
    else
      R := GetParentForm(TreeList).BoundsRect;
    FForm.Left := R.Right - FForm.Width;
    FForm.Top := R.Bottom - FForm.Height;
    if FForm.Left < 0 then FForm.Left := 0;
    if FForm.Top < 0 then FForm.Top := 0;
  end;
  ValidateListBox(FHeaderListBox, FLastHeaderIndex);
  ValidateListBox(FBandListBox, FLastBandIndex);
  FForm.Show;
end;

function TcxTreeListCustomizing.SizeDelta: TSize;
begin
  Result := cxSize(28, 4);
end;

procedure TcxTreeListCustomizing.ComponentRemoved(Sender: TObject);
begin
end;

procedure TcxTreeListCustomizing.Modified;
begin
  if (FHeaderListBox <> nil) and (FHeaderListBox.Parent <> nil) then
    FHeaderListBox.RefreshList;
  if (FBandListBox <> nil) and (FBandListBox.Parent <> nil) then
    FBandListBox.RefreshList;
end;

procedure TcxTreeListCustomizing.ValidateListBox(
  AListBox: TcxTreeListItemsCustomizeListBox; AIndex: Integer);
begin
  if (AListBox = nil) or (AListBox.Parent = nil) then Exit;
  AListBox.RefreshList;
  if (AIndex >= 0) and (AIndex < AListBox.Items.Count) then
    AListBox.ItemIndex := AIndex;
end;

procedure TcxTreeListCustomizing.VisibleChanged(Sender: TObject);
begin
  TreeList.DoOnCustomizationVisibleChanged;
end;

procedure TcxTreeListCustomizing.Update;
begin
  if FBandListBox <> nil then FBandListBox.Invalidate;
  if FHeaderListBox <> nil then FHeaderListBox.Invalidate;
end;

function TcxTreeListCustomizing.GetForm: TForm;
begin
  Result := FForm;
end;

function TcxTreeListCustomizing.GetVisible: Boolean;
begin
  Result := FVisible and ((FForm <> nil) and FForm.Visible);
  FVisible := Result;
end;

procedure TcxTreeListCustomizing.SetRowCount(Value: Integer);
begin
  if Value < 2 then Value := 2;
  if Value <> FRowCount then
    FRowCount := Value;
end;

procedure TcxTreeListCustomizing.SetVisible(Value: Boolean);

  function CanVisible: Boolean;
  begin
    with TreeList.OptionsView  do
      Result := ((TreeList.Bands.Count > 0) and Bands and not SimpleCustomizeBox) or
         (Headers and (TreeList.ColumnCount > 0));
  end;

begin
  if Value <> FVisible then
  begin
    if Value and not CanVisible then Exit;
    FVisible := Value;
    if FForm <> nil then
      TcxTreeListCustomizationForm(FForm).HookTimer.Enabled := False;
    if not Value then
      ReleaseControls
    else
      begin
        CreateControls;
        TreeList.Designers.Add(Self);
        Form.Visible := True;
        TcxTreeListCustomizationForm(FForm).HookTimer.Enabled := True;
      end;
  end;
end;

{ TcxCustomTreeListControl }

constructor TcxCustomTreeListControl.Create(AOwner: TComponent);
begin
  FNodesList := TList.Create;
  FDeletedNodes := TList.Create;
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csDisplayDragImage];
  FNeedMakeVisible := True;
  Width := 250;
  Height := 150;
  if Assigned(DesignerNavigatorProc) then
    DesignerNavigatorProc(Self, True);
end;

destructor TcxCustomTreeListControl.Destroy;
begin
  Customizing.Visible := False;
  if Assigned(DesignerNavigatorProc) then
    DesignerNavigatorProc(Self, False);
  BeginUpdate;
  try
    inherited Destroy;
  finally
    FNodesList.Free;
    FDeletedNodes.Free;
  end;
end;

procedure TcxCustomTreeListControl.AdjustColumnsWidth;
var
  I: Integer;
  APrevValue: Boolean;
begin
  APrevValue := OptionsView.ColumnAutoWidth;
  OptionsView.ColumnAutoWidth := True;
  BeginUpdate;
  try
    for I := 0 to VisibleColumnCount - 1 do
      VisibleColumns[I].Width := VisibleColumns[I].RealWidth;
    for I := 0 to VisibleBandCount - 1 do
      VisibleBands[I].Width := VisibleBands[I].RealWidth;
  finally
    EndUpdate;
  end;
  OptionsView.ColumnAutoWidth := APrevValue;
end;

procedure TcxCustomTreeListControl.ApplyBestFit;
var
  I: Integer;
begin
  BeginUpdate;
  try
    FContentIndentWidth := 0;
    HandleNeeded;
    for I := 0 to VisibleBandCount - 1 do
      VisibleBands[I].ApplyBestFit;
  finally
    EndUpdate;
  end;
  LayoutChanged;
end;

procedure TcxCustomTreeListControl.Clear;
begin
  BeginUpdate;
  try
    DoClear;
  finally
    EndUpdate;
  end;
end;

procedure TcxCustomTreeListControl.DoBandSizeChanged(ABand: TcxTreeListBand);
begin
  Modified;
  LayoutChanged;
  DoOnBandSizeChanged(ABand);
end;

procedure TcxCustomTreeListControl.DoColumnSizeChanged(AColumn: TcxTreeListColumn);
begin
  Modified;
  DoOnColumnSizeChanged(AColumn);
end;

function TcxCustomTreeListControl.DoCreateColumn: TcxTreeListColumn;
begin
  Result := GetTreeListColumnClass.Create(Owner);
  Result.EditingControl := Self;
  Modified;
end;

function TcxCustomTreeListControl.CreateColumn(
  ABand: TcxTreeListBand = nil): TcxTreeListColumn;
begin
  BeginUpdate;
  try
    Result := DoCreateColumn;
    if ABand = nil then
    begin
      if Bands.Count = 0 then Bands.Add;
      if VisibleBandCount > 0 then
        ABand := VisibleBands[0]
      else
        ABand := Bands[0]
    end;
    if (ABand <> nil) and Result.Visible then
      Result.Position.FColIndex := ABand.FColumns.Count;
    Result.OwnerBand := ABand;
    ViewInfo.IsDirty := True;
  finally
    EndUpdate;
  end;
end;

procedure TcxCustomTreeListControl.DeleteAllColumns;
begin
  BeginUpdate;
  try
    ViewInfo.NodesViewInfo.Clear;
    while ColumnCount > 0 do TObject(ContainerList.List^[0]).Free;
  finally
    EndUpdate;
  end;
end;

procedure TcxCustomTreeListControl.DeleteSelection;
begin
  DoDeleteSelection;
end;

procedure TcxCustomTreeListControl.DragDrop(Source: TObject; X, Y: Integer);
var
  AFocusedIndex: Integer;
begin
  if Source <> Self then
  begin
    if Assigned(OnDragDrop) then
      OnDragDrop(Self, Source, X, Y);
    Controller.DragDrop(Source, X, Y);
    Exit;
  end;
  HitTest.HitPoint := Point(X, Y);
  AFocusedIndex := -1;
  try
    if DragNode <> nil then
      AFocusedIndex := DragNode.RecordIndex;
    if Assigned(OnDragDrop) then
      OnDragDrop(Self, Source, X, Y);
    Controller.DragDrop(Source, X, Y);
    if FocusedNode <> nil then
      FocusedNode.MakeVisible;
  finally
    FDragNode := nil;
    if AFocusedIndex < DataController.RecordCount then
      DataController.FocusedRecordIndex := AFocusedIndex;
    if FocusedNode <> nil then
      FocusedNode.MakeVisible;
    RestoreDragPos;
  end;
end;

function TcxCustomTreeListControl.GetIndentWidth(IsLeftMost: Boolean): Integer;
begin
  if IsLeftMost then
    Result := FContentIndentWidth
  else
    Result := 0;
end;

procedure TcxCustomTreeListControl.MakeDefaultLayout;
var
  I: Integer;
begin
  BeginUpdate;
  try
    OptionsView.Bands := False;
    while Bands.Count > 1 do
      Bands[Bands.Count - 1].Free;
    if Bands.Count = 0 then Bands.Add;
    Bands[0].RestoreDefaults;
    Bands[0].Visible := True;
    for I := 0 to ColumnCount - 1 do
      with Columns[I] do
      begin
        RestoreDefaults;
        Position.BandIndex := 0;
      end;
  finally
    EndUpdate;
    Modified;
    FDefaultLayout := True;
  end;
end;

procedure TcxCustomTreeListControl.FullCollapse;
begin
  Nodes.Root.Collapse(True);
end;

procedure TcxCustomTreeListControl.FullExpand;
begin
  Nodes.Root.Expand(True);
end;

procedure TcxCustomTreeListControl.FullRefresh;
begin
  LayoutChanged;
end;

function TcxCustomTreeListControl.Find(AData: Pointer;
  AStart: TcxTreeListNode; AExpandedOnly, AForward: Boolean;
  AFilter: TcxTreeListFindFunc): TcxTreeListNode; 
begin
  Result := cxFind(Self, AData, AStart, AExpandedOnly, AForward, AFilter);
end;

type
  PFindTextInfo = ^TFindTextInfo;
  TFindTextInfo = record
    Text: string;
    Column: TcxTreeListColumn;
  end;

function FindTextFilter(ANode: TcxTreeListNode; AData: Pointer): Boolean;
begin
  with PFindTextInfo(AData)^ do
    Result := AnsiStrPos(PChar(ANode.Texts[Column.ItemIndex]), PChar(Text)) <> nil;
end;

function TcxCustomTreeListControl.FindNodeByText(const AText: string;
  AColumn: TcxTreeListColumn; AStartNode: TcxTreeListNode = nil;
  AExpandedOnly: Boolean = False; AForward: Boolean = True): TcxTreeListNode;
var
  AFindInfo: TFindTextInfo;
begin
  AFindInfo.Text := AText;
  AFindInfo.Column := AColumn;  
  Result := Find(@AFindInfo, AStartNode, AExpandedOnly, AForward, FindTextFilter)
end;

procedure TcxCustomTreeListControl.SetFocusedNode(
  Value: TcxTreeListNode; AShift: TShiftState);
var
  ARecordIndex: Integer;
begin
  ARecordIndex := cxInvalidIndex;
  if (Value <> nil) and Value.IsVisible then
    ARecordIndex := Value.RecordIndex
  else
    if Value <> nil then Exit;
  if ARecordIndex = cxInvalidIndex then
    DataController.FocusedRecordIndex := cxInvalidIndex
  else
  begin
    if OptionsBehavior.AlwaysShowEditor then
      Controller.SetFocusedRecordItem(ARecordIndex, FocusedColumn)
    else
      Controller.FocusedRecordIndex := ARecordIndex;
  end;
end;

procedure TcxCustomTreeListControl.SetColumnSortOrder(AColumn: TcxTreeListColumn;
  ASortOrder: TcxDataSortOrder; AShift: TShiftState);
begin
  Controller.DoChangeColumnSortOrder(AColumn, ASortOrder, AShift);
end;

procedure TcxCustomTreeListControl.SelectAll;
begin
  if not OptionsSelection.MultiSelect or (Nodes.Count = 0) then Exit;
  BeginUpdateSelection;
  try
    DoSelectAll;
  finally
    EndUpdateSelection;
  end;
end;

procedure TcxCustomTreeListControl.CancelEdit;
begin
  Controller.EditingController.HideEdit(False);
end;

procedure TcxCustomTreeListControl.HideEdit;
begin
  Controller.EditingController.HideEdit(True);
end;

procedure TcxCustomTreeListControl.Select(Node: TcxTreeListNode;
  ShiftState: TShiftState = []);
begin
  Controller.Select(Node, ShiftState);
end;

procedure TcxCustomTreeListControl.Select(const ANodes: array of TcxTreeListNode);
var
  I: Integer;
begin
  BeginUpdateSelection;
  try
    ClearSelection;
    for I :=  Low(ANodes) to High(ANodes) do
      ANodes[I].Selected := True; 
  finally
    EndUpdateSelection;
  end;
end;

procedure TcxCustomTreeListControl.Select(ANodes: TList);
begin
  BeginUpdateSelection;
  if Nodes <> nil then
  try
    ClearSelection;
    FSelection.Count := ANodes.Count;
    if FSelection.Count > 0 then
      System.Move(ANodes.List^, FSelection.List^[0], SizeOf(Integer) * FSelection.Count);
  finally
    EndUpdateSelection;
  end
  else
    CancelUpdateSelection;
end;

procedure TcxCustomTreeListControl.Deselect(Node: TcxTreeListNode);
begin
  Node.Selected := False; 
end;

procedure TcxCustomTreeListControl.ShowEdit;
begin
  if not OptionsData.Editing then Exit;
  DataController.Edit;
  Controller.EditingController.ShowEdit();
end;

procedure TcxCustomTreeListControl.ShowEditByKey(AKey: Char);
begin
  BeforeShowingEdit;
  with Controller do
    EditingController.ShowEdit(FocusedItem, AKey);
end;

procedure TcxCustomTreeListControl.ShowEditByMouse(X, Y: Integer; AShift: TShiftState);
begin
  BeforeShowingEdit;
  with Controller do
    EditingController.ShowEdit(FocusedItem, AShift, X, Y);
end;

procedure TcxCustomTreeListControl.RestoreFromIniFile(const AStorageName: string;
  AChildrenCreating: Boolean = False; AChildrenDeleting: Boolean = False);
var
  AStorage: TcxStorage;
begin
  AStorage := TcxStorage.Create(AStorageName);
  try
    IsRestore := True;
    AStorage.NamePrefix := Name;
    if AChildrenCreating then
      AStorage.Modes := [smChildrenCreating];
    if AChildrenDeleting then
      AStorage.Modes := AStorage.Modes + [smChildrenDeleting];
    BeginUpdate;
    try
      AStorage.UseInterfaceOnly := True;
      AStorage.RestoreFromIni(Self);
      ForceRefresh;
    finally
      IsRestore := False;
      EndUpdate;
    end;
  finally
    AStorage.Free;
  end;
end;

procedure TcxCustomTreeListControl.RestoreFromRegistry(const AStorageName: string;
  AChildrenCreating: Boolean = False; AChildrenDeleting: Boolean = False);
var
  AStorage: TcxStorage;
begin
  AStorage := TcxStorage.Create(AStorageName);
  try
    IsRestore := True;
    AStorage.UseInterfaceOnly := True;
    AStorage.NamePrefix := Name;
    if AChildrenCreating then
      AStorage.Modes := [smChildrenCreating];
    if AChildrenDeleting then
      AStorage.Modes := AStorage.Modes + [smChildrenDeleting];
    BeginUpdate;
    try
      AStorage.RestoreFromRegistry(Self);
      ForceRefresh;
    finally
      IsRestore := False;
      EndUpdate;
    end;
  finally
    AStorage.Free;
  end;                     
end;

procedure TcxCustomTreeListControl.RestoreFromStream(AStream: TStream;
  AChildrenCreating: Boolean = False; AChildrenDeleting: Boolean = False);
var
  AStorage: TcxStorage;
begin
  AStorage := TcxStorage.Create(AStream);
  try
    IsRestore := True;
    AStorage.UseInterfaceOnly := True;
    AStorage.NamePrefix := Name;
    if AChildrenCreating then
      AStorage.Modes := [smChildrenCreating];
    if AChildrenDeleting then
      AStorage.Modes := AStorage.Modes + [smChildrenDeleting];
    BeginUpdate;
    try
      AStorage.RestoreFromStream(Self);
      ForceRefresh;
    finally
      IsRestore := False;
      EndUpdate;
    end;
  finally
    AStorage.Free;
  end;
end;

procedure TcxCustomTreeListControl.StoreToIniFile(AStorageName: string;
  AReCreate: Boolean = True);
var
  AStorage: TcxStorage;
begin
  AStorage := TcxStorage.Create(AStorageName);
  try
    AStorage.UseInterfaceOnly := True;
    AStorage.NamePrefix := Name;
    AStorage.ReCreate := AReCreate;
    AStorage.StoreToIni(Self);
  finally
    AStorage.Free;
  end;
end;

procedure TcxCustomTreeListControl.StoreToRegistry(AStorageName: string;
  AReCreate: Boolean = True);
var
  AStorage: TcxStorage;
begin
  AStorage := TcxStorage.Create(AStorageName);
  try
    AStorage.UseInterfaceOnly := True;
    AStorage.NamePrefix := Name;
    AStorage.ReCreate := AReCreate;
    AStorage.StoreToRegistry(Self);
  finally
    AStorage.Free;
  end;
end;

procedure TcxCustomTreeListControl.StoreToStream(AStream: TStream);
var
  AStorage: TcxStorage;
begin
  AStorage := TcxStorage.Create(AStream);
  try
    AStorage.UseInterfaceOnly := True;
    AStorage.NamePrefix := Name;
    AStorage.StoreToStream(Self);
  finally
    AStorage.Free;
  end;
end;

function TcxCustomTreeListControl.CellRect(
  ANode: TcxTreeListNode; AColumn: TcxTreeListColumn): TRect;
var
  AInfo: TcxTreeListEditCellViewInfo;
begin
  AInfo := Controller.GetCellFromViewInfoEx(AColumn, ANode);
  if AInfo <> nil then
    Result := AInfo.ClipRect
  else
    Result := cxInvalidRect;
end;

// searching
function TcxCustomTreeListControl.FindNext(AForward: Boolean): Boolean;
var
  ANode: TcxTreeListNode;
const
  ALocateKeys: array[Boolean] of Word = (VK_UP, VK_DOWN);
begin
  if Searching then
  begin
    ANode := FocusedNode;
    Controller.IncSearchKeyDown(ALocateKeys[AForward], [ssCtrl]);
  end
  else
    ANode := nil;
  Result := ANode <> FocusedNode;
end;

procedure TcxCustomTreeListControl.CancelSearching;
begin
  Controller.CancelIncSearching;
end;

function TcxCustomTreeListControl.GetEditRect(
  ANode: TcxTreeListNode; AColumn: TcxTreeListColumn): TRect;
var
  AInfo: TcxTreeListEditCellViewInfo;
begin
  AInfo := Controller.GetCellFromViewInfoEx(AColumn, ANode);
  if AInfo <> nil then
    Result := AInfo.EditRect
  else
    Result := cxInvalidRect;
end;

function TcxCustomTreeListControl.GetNodeAt(
  X, Y: Integer): TcxTreeListNode;
begin
  HitTest.ReCalculate(cxPoint(X, Y));
  if HitTest.HitAtNode then
    Result := HitTest.HitNode
  else
    Result := nil;
end;

procedure TcxCustomTreeListControl.CopyAllToClipboard;
begin
  DoWriteToClipboard(False);
end;

procedure TcxCustomTreeListControl.CopySelectedToClipboard;
begin
  DoWriteToClipboard(True);
end;

procedure TcxCustomTreeListControl.RestoreColumnsDefaults;
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := 0 to ColumnCount - 1 do
      Columns[I].RestoreDefaults;
    RestoreColumnsWidths;
  finally
    EndUpdate;
  end;
end;

procedure TcxCustomTreeListControl.RestoreColumnsWidths;
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := 0 to ColumnCount - 1 do
      Columns[I].RestoreDefaults;
  finally
    EndUpdate;
  end;
end;

procedure TcxCustomTreeListControl.Subselect(Node: TcxTreeListNode);
begin
  if not CanMultiSelect then
    cxTreeListError(scxStr(@scxMultiSelectRequired))
  else
    Node.Selected := True; 
end;

procedure TcxCustomTreeListControl.ClearSelection(KeepPrimary: Boolean = False);
begin
  Controller.CancelSelection(KeepPrimary)
end;

procedure TcxCustomTreeListControl.ClearSorting;
begin
  Sorted := False; 
end;

function TcxCustomTreeListControl.ColumnByName(
  const AName: string): TcxTreeListColumn;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to ColumnCount - 1 do
    if CompareText(Columns[I].Name, AName) = 0 then
    begin
      Result := Columns[I];
      Break;
    end;
end;

function TcxCustomTreeListControl.GetSelections(AList: TList): TcxTreeListNode;
begin
  AList.Clear;
  if IsMultiSelect then
  begin
    AList.Count := FSelection.Count;
    if FSelection.Count > 0 then
      Move(FSelection.List^, AList.List^, FSelection.Count * SizeOf(Integer));
  end
  else
    AList.Add(FocusedNode);
  Result := FocusedNode;
end;

procedure TcxCustomTreeListControl.GotoBOF;
begin
  FocusedNode := Nodes.Root.GetFirstChild;
end;

procedure TcxCustomTreeListControl.GotoEOF;
begin
  FocusedNode := cxGetLatest(Nodes.Root.GetLastChild);
end;

procedure TcxCustomTreeListControl.GotoNext;
begin
  if not IsEOF and (FocusedNode <> nil) then
    FocusedNode := FocusedNode.GetNextVisible;
end;

procedure TcxCustomTreeListControl.GotoNextPage;
begin
  Controller.DoNextPage(True, []);
end;

procedure TcxCustomTreeListControl.GotoPrev;
begin
  if not IsBOF and (FocusedNode <> nil) then
    FocusedNode := FocusedNode.GetPrevVisible;
end;

procedure TcxCustomTreeListControl.GotoPrevPage;
begin
  Controller.DoNextPage(False, []);
end;

function TcxCustomTreeListControl.IsBOF: Boolean;
begin
  Result := (FocusedNode <> nil) and (FocusedNode.GetPrevVisible = nil);
end;

function TcxCustomTreeListControl.IsEOF: Boolean;
begin
  Result := (FocusedNode <> nil) and (FocusedNode.GetNextVisible = nil);
end;

procedure TcxCustomTreeListControl.AfterLayoutChanged;
begin
  with ViewInfo.NodesViewInfo do
  try
    if FNeedSynchronize then
    begin
      SynchronizeTopNode;
      FNeedSynchronize := False;
    end;
  finally
    if IsNeedSortPost then DoSortNodes;
    inherited AfterLayoutChanged;
    DoLayoutChangedEvent;
  end;
end;

procedure TcxCustomTreeListControl.BeforeUpdate;
begin
  DoValidateDeletedNodes;
  if IsLocked then Exit;
  PostUpdateFocusedRecord;
  RestoreTopPos;
end;

procedure TcxCustomTreeListControl.CheckCreateDesignSelectionHelper;
begin
end;

procedure TcxCustomTreeListControl.ControlUpdateData(
  AInfo: TcxUpdateControlInfo);
var
  ANode: TcxTreeListNode;
begin
  if AInfo is TcxUpdateRecordInfo then
    CancelSearching;
  if AInfo is TcxDataChangedInfo then
  begin
    with TcxDataChangedInfo(AInfo) do
    begin
      if (Kind in [dcField, dcRecord]) and not IsEditing then
      begin
        ANode := Nodes.Items[RecordIndex];
        if Kind = dcField then
          UpdateColumn(ANode, Columns[ItemIndex])
        else
          UpdateNode(ANode);
        AInfo := nil;
      end;
    end;
  end;
  if FDataChangedLocked and (AInfo is TcxDataChangedInfo) then
    FDataChangedLocked := False
  else
    inherited ControlUpdateData(AInfo);
  if not IsLocked then
  begin
    ViewInfo.NodesViewInfo.UpdateData;
    ViewInfo.UpdateFootersViewInfo;
  end;
  RefreshNavigatorButtons;
end;

procedure TcxCustomTreeListControl.UpdateColumn(
  ANode: TcxTreeListNode; AColumn: TcxTreeListColumn);
begin
  UpdateNode(ANode);
end;

procedure TcxCustomTreeListControl.UpdateNode(ANode: TcxTreeListNode);
var
  AViewInfo: TcxTreeListNodeViewInfo;
begin
  if ViewInfo.NodesViewInfo.FindNodeViewInfo(ANode, AViewInfo) then
  begin
    AViewInfo.Update(True);
    if Sorted then
    begin
      DoSorting;
      try
        ANode.Parent.AlphaSort(False);
        if ANode.Focused then ANode.MakeVisible;
      finally
        DoOnAfterSorting;
      end;
    end;
  end;
end;

procedure TcxCustomTreeListControl.CreateSubClasses;
begin
  inherited CreateSubClasses;
  FNavigatorNotifier := TcxNavigatorControlNotifier.Create;
  FSortedColumns := TList.Create;
  FDesigners := TList.Create;
  FSelection := TList.Create;
  FOptionsCustomizing := GetOptionsCustomizingClass.Create(Self);
  FOptionsSelection := GetOptionsSelectionClass.Create(Self);
  FNodes := GetNodesClass.Create(Self);
  FPreview := GetPreviewClass.Create(Self);
  FBandsVisibleList := TList.Create;
  FBands := TcxTreeListBands.Create(Self);
  FColumnsVisibleList := TList.Create;
  FSortOrderList := TList.Create;
  FChangeImagesLink := TChangeLink.Create;
  FChangeImagesLink.OnChange := OnChangeImages;
  FChangeStateImagesLink := TChangeLink.Create;
  FChangeStateImagesLink.OnChange := OnChangeImages;
  FCustomizing := GetTreeListCustomizingClass.Create(Self);
  TcxDataControllerAccess(DataController).OnRecordChanged := DoRecordChanged;
  TcxDataControllerAccess(DataController).OnDataChanged := DoDataChangedEvent;
  FDelayTimer := TTimer.Create(Self);
  FDelayTimer.Enabled := False;
  FDelayTimer.Interval := 0;
  FDelayTimer.OnTimer := DoChangedTimer;
end;

procedure TcxCustomTreeListControl.DataChanged;
begin
  inherited DataChanged;
  DoSortNodes;
end;

procedure TcxCustomTreeListControl.DataLayoutChanged;
begin
  inherited DataLayoutChanged;
end;

procedure TcxCustomTreeListControl.DestroySubClasses;
var
  I: Integer;
begin
  UpdateDesignerForms;
  BeginUpdate;
  try
    for I := 0 to FSortOrderList.Count - 1 do
      Dispose(PcxDataSortInfo(FSortOrderList.List^[I]));
    FreeAndNil(FNavigatorNotifier);
    FreeAndNil(FNodes);
    FreeAndNil(FColumnsVisibleList);
    FreeAndNil(FBandsVisibleList);
    FreeAndNil(FSortOrderList);
    FreeAndNil(FAutoWidthController);
    FreeAndNil(FPreview);
    DeleteAllColumns;
    FreeAndNil(FBands);
    FreeAndNil(FOptionsCustomizing);
    FreeAndNil(FOptionsSelection);
    FreeAndNil(FChangeImagesLink);
    FreeAndNil(FChangeStateImagesLink);
    FreeAndNil(FCustomizing);
    FreeAndNil(FSortedColumns);
  finally
    FreeAndNil(FSelection);
    FreeAndNil(FDesigners);
    FOptionsCustomizing.Free;
    inherited DestroySubClasses;
  end;
end;

procedure TcxCustomTreeListControl.DoLayoutChanged;
begin
  Bands.RefreshBandStates;
  Bands.Changed;
  FHeaderLineCount := 0;
  PostUpdateFocusedRecord;
  Controller.HotTrackNode := nil;
  RestoreCursor;
  ViewInfo.NodesViewInfo.CancelUpdatePost;
  RefreshVisibleIndexes;
  FMaxIndentWidth := LookAndFeelPainter.SmallExpandButtonSize +
    cxTreeListIndentOffsetSize;
  if Images <> nil then  
    cxSetMax(FMaxIndentWidth, Images.Width + cxTreeListIndentOffsetSize div 2);
  if StateImages <> nil then
    cxSetMax(FMaxIndentWidth, StateImages.Width + cxTreeListIndentOffsetSize div 2);
  FLevelIndentWidth := FMaxIndentWidth;
  BeforeCalculate;
  Nodes.CalculateInfo(False);
  RealignBands;
  AssignLeftMostWidths;
  inherited DoLayoutChanged;
  CheckFocusedItem;
  UpdateDesignerForms;
  Controller.ForceFocusedRecord := -1;
end;

procedure TcxCustomTreeListControl.InitScrollBarsParameters;
begin
  if IsLocked then Exit;
  with ViewInfo do
  begin
    SetScrollBarInfo(sbHorizontal, 0, HorzScrollSize, HorzScrollInc,
      cxRectWidth(ClientBounds), HorzScrollPos, True, True);
    with Self.Nodes do
      SetScrollBarInfo(sbVertical, 0, VisibleCount - 1, 1, Self.VisibleCount,
        TopVisibleIndex, VisibleCount > Self.VisibleCount{) and (Self.VisibleCount > 0)}, True);
  end;
end;

procedure TcxCustomTreeListControl.LookAndFeelChanged(
  Sender: TcxLookAndFeel; AChangedValues: TcxLookAndFeelValues);
begin
  HideEdit;
  ViewInfo.NodesViewInfo.Clear;
  inherited LookAndFeelChanged(Sender, AChangedValues);
end;

procedure TcxCustomTreeListControl.ReadState(Reader: TReader);
begin
  SaveColumnsParams;
  inherited ReadState(Reader);
  AssignColumnsParams;
end;

procedure TcxCustomTreeListControl.Updated;
begin
  inherited Updated;
  BeginUpdate;
  try
    AssignColumnsParams;
  finally
    EndUpdate;
  end;
end;

procedure TcxCustomTreeListControl.Updating;
begin
  SaveColumnsParams;
  inherited Updating;
end;

procedure TcxCustomTreeListControl.AssignColumnsParams;
var
  I: Integer;
begin
  for I := 0 to ColumnCount - 1 do
    Columns[I].Position.Load;
end;

procedure TcxCustomTreeListControl.SaveColumnsParams;
var
  I: Integer;
begin
  for I := 0 to ColumnCount - 1 do
    Columns[I].Position.Save;
end;

function TcxCustomTreeListControl.DragDropImageDisplayRect: TRect;
begin
  with GetDragDropViewParams do
  begin
    Result := inherited DragDropImageDisplayRect;
    Result.Bottom := cxTextHeight(Font);
    Result.Right := VisibleColumns[0].DisplayWidth;
    Result := cxRectOffset(Result, [ScreenToClient(GetMouseCursorPos),
      cxTreeListDragDropTextAreaOffset]);
    Result := cxRectInflate(Result, cxTextOffset, cxTextOffset);
  end;
end;

procedure TcxCustomTreeListControl.DrawDragDropImage(
  ADragBitmap: TBitmap; ACanvas: TcxCanvas);
var
  R: TRect;
begin
  cxApplyViewParams(ACanvas, GetDragDropViewParams);
  R := Rect(0, 0, ADragBitmap.Width, ADragBitmap.Height);
  ACanvas.FillRect(R);
  ACanvas.FrameRect(R, clBlack, 1, cxBordersAll);
  ACanvas.Brush.Style := bsClear;
  ACanvas.DrawTexT(GetDragDropText, cxTextRect(R),
    cxAlignLeft or cxAlignVCenter or cxSingleLine);
end;

procedure TcxCustomTreeListControl.ForceRefresh;
begin
  ViewInfo.State[cvis_StyleInvalid] := True;
  DoLayoutChanged;
end;

function TcxCustomTreeListControl.GetDragDropText: string;
begin
  Result := FDragNode.Texts[VisibleColumns[0].ItemIndex];
end;

function TcxCustomTreeListControl.GetDragDropViewParams: TcxViewParams;
begin
  Styles.DoGetContentParams(FDragNode, VisibleColumns[0], Result);
  with Styles.GetSelectionParams do
  begin
    Result.Color := Color;
    if Styles.SelectionFontAssigned then
      Result.Font := Font;
    Result.TextColor := TextColor;
  end;
end;

function TcxCustomTreeListControl.GetImageListHeight(
  AImageList: TCustomImageList): Integer; 
begin
  Result := AImageList.Height;
end;

function TcxCustomTreeListControl.GetDragObjectClass: TDragControlObjectClass;
begin
  Result := nil;
end;

function TcxCustomTreeListControl.StartDrag(DragObject: TDragObject): Boolean;
begin
  Result := DragNode <> nil;
{  HitTest.HitPoint := ScreenToClient(GetMouseCursorPos);
  with HitTest do
    Result := HitAtNode and HitNode.Selected and not HitAtIndent;}
end;

procedure TcxCustomTreeListControl.GetStoredChildren(AChildren: TStringList);
var
  I: Integer;
begin
  AChildren.AddObject('', Bands);
  for I := 0 to ColumnCount - 1 do
    AChildren.AddObject('', Columns[I]);
end;

function TcxCustomTreeListControl.GetStoredObjectName: string;
begin
  Result := Name;
end;

function TcxCustomTreeListControl.GetStoredObjectProperties(
  AProperties: TStrings): Boolean;
begin
  Result := True;
end;

procedure TcxCustomTreeListControl.GetStoredPropertyValue(
  const AName: string; var AValue: Variant);
begin
end;

procedure TcxCustomTreeListControl.RestoreTopPos;
begin
  if FTopPos <> -1 then
  begin
    Nodes.CalculateInfo(False);
    Nodes.TopIndex := 0;
    Nodes.TopNode := Nodes.Root.FFirst;
    Nodes.TopNode := Nodes.GetVisibleNode(FTopPos);
    Nodes.TopIndex := FTopPos;
    FTopPos := -1;
  end;
end;

procedure TcxCustomTreeListControl.StoreTopPos;
begin
  FTopPos := Nodes.TopIndex;
end;

procedure TcxCustomTreeListControl.SetStoredPropertyValue(
  const AName: string; const AValue: Variant);
begin
end;

function TcxCustomTreeListControl.StoredCreateChild(
  const AObjectName, AClassName: string): TObject;
begin
  if AClassName = GetTreeListColumnClass.ClassName then
  begin
    Result := CreateColumn;
    TcxTreeListColumn(Result).Name := AObjectName;
  end
  else
    Result := nil;
end;

procedure TcxCustomTreeListControl.StoredDeleteChild(
  const AObjectName: string; AObject: TObject);
begin
end;

procedure TcxCustomTreeListControl.GetChildren(
  Proc: TGetChildProc; Root: TComponent);

  procedure DoStore(AColumn: TcxTreeListColumn);
  begin
    if AColumn.Owner = Root then
      Proc(AColumn);
  end;

var
  I: Integer;
begin
  inherited GetChildren(Proc, Root);
  RefreshVisibleIndexes;
  for I := 0 to ColumnCount - 1 do DoStore(Columns[I]);
end;

function TcxCustomTreeListControl.IsUpdating: Boolean;
begin
  Result := csUpdating in ComponentState;
end;

procedure TcxCustomTreeListControl.Loaded;
begin
  inherited Loaded;
  if FocusedNode <> nil then
    FocusedNode.MakeVisible;
  DataChanged;
  RestoreCursor;
  RealignBands;
end;

procedure TcxCustomTreeListControl.Modified;
begin
  if HandleAllocated then
    inherited Modified;
  FDefaultLayout := False; 
end;

procedure TcxCustomTreeListControl.Notification(
  AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = Images then Images := nil;
    if AComponent = StateImages then StateImages := nil;
  end;
end;

procedure TcxCustomTreeListControl.SetName(const NewName: TComponentName);
begin
  inherited SetName(NewName);
  UpdateDesignerForms;
end;

procedure TcxCustomTreeListControl.AssignColumnWidths;
var
  I: Integer;
begin
  for I := 0 to VisibleBandCount - 1 do
    VisibleBands[I].AssignColumnWidths;
end;

procedure TcxCustomTreeListControl.AssignLeftMostWidths;
var
  I: Integer;
begin
  if CanAddIndentWidth(FContentIndentWidth) then
  begin
    for I := 0 to VisibleColumnCount - 1 do
      if VisibleColumns[I].IsLeftMost then
        VisibleColumns[I].FWidth := VisibleColumns[I].DisplayWidth;
    for I := 0 to VisibleBandCount - 1 do
      with VisibleBands[I] do
        if IsLeftMost then
        begin
          FCalculatedWidth := DisplayWidth;
          if FWidth <> 0 then
            FWidth := FCalculatedWidth;
          RealignColumns;
        end;
    FContentIndentWidth := 0;
    RealignBands;
  end;
end;

procedure TcxCustomTreeListControl.BoundsChanged;
begin
  inherited;
end;

function TcxCustomTreeListControl.AddNode(ANode, ARelative: TcxTreeListNode;
  AData: Pointer; AttachMode: TcxTreeListNodeAttachMode): TcxTreeListNode;
begin
  Result := Nodes.InternalAddNode(ANode, ARelative, AttachMode);
  Result.FData := AData;
end;

procedure TcxCustomTreeListControl.BeforeAddNode(
  ANewNode, ANewParent: TcxTreeListNode; AMode: TcxTreeListNodeAddMode);
begin
end;

function TcxCustomTreeListControl.CanAddIndentWidth(
  const AIndentWidth: Integer): Boolean;
begin
  Result := not OptionsBehavior.AutomateLeftMostIndent and
    (AIndentWidth <> 0) and not OptionsView.ColumnAutoWidth;
end;

function TcxCustomTreeListControl.CanColumnVisible(
  AColumn: TcxTreeListColumn): Boolean;
begin
  Result := True;
end;

function TcxCustomTreeListControl.CanMultiSelect: Boolean;
begin
  Result := OptionsSelection.MultiSelect;
end;

procedure TcxCustomTreeListControl.BeforeCalculate;
begin
end;

procedure TcxCustomTreeListControl.BeforeShowingEdit;
begin
  with Controller do
    SetFocusedRecordItem(FocusedRecordIndex, FocusedItem);
end;

procedure TcxCustomTreeListControl.CalculateLeftMostIndentWidth;
begin
  FContentIndentWidth := 0;
  if (Nodes.VisibleCount > 0) and (VisibleBandCount > 0) then
    with VisibleBands[0] do
    begin
      FContentIndentWidth := Max(0, GetLevelIndentsWidth(Nodes.MaxLevel, True, nil) +
        BandRows.LeftMostMinWidth - BandRows.LeftMostWidth);
    end;
end;

procedure TcxCustomTreeListControl.CheckFocusedItem;
var
  ANode: TcxTreeListNode;
  ARecordIndex: Integer;
  AItem: TcxTreeListColumn;
begin
  if (ChangesCount <> 1) or (Controller.FocusedRecordIndex = cxInvalidIndex) then Exit;
  ANode := FocusedNode;
  if ANode = nil then
    ANode := Nodes.Root.GetFirstChild;
  if (ANode <> nil) then
    while (ANode.FParent <> nil) and not ANode.IsVisible do ANode := ANode.FParent;
  if ANode <> nil then
    ARecordIndex := ANode.RecordIndex
  else
    ARecordIndex := cxInvalidIndex;
  AItem := FocusedColumn;
  if OptionsSelection.CellSelect and (VisibleColumnCount > 0) and
    (((AItem = nil) or AItem.IsHidden)) then
  begin
    if DoIsGroupNode(ANode) and (OptionsView.CategorizedColumn <> nil) then
      AItem := OptionsView.CategorizedColumn
    else
      AItem := VisibleColumns[0];
  end;
  with Controller do
    if (AItem <> FocusedItem) or (ARecordIndex <> FocusedRecordIndex) and not IsDragMode then
      Controller.SetFocusedRecordItem(ARecordIndex, AItem);
end;

procedure TcxCustomTreeListControl.ColumnSortOrderChanged(
  AColumn: TcxTreeListColumn);
begin
  if AColumn.GetRealSortOrder = soNone then
    FSortedColumns.Remove(AColumn)
  else
    if FSortedColumns.IndexOf(AColumn) = cxInvalidIndex then
      FSortedColumns.Add(AColumn);
end;

procedure TcxCustomTreeListControl.DoAssignNodes(Source: TcxTreeListNodes);
begin
  // todo: do nothing
end;

procedure TcxCustomTreeListControl.DoClear;
begin
  Nodes.Clear;
end;

procedure TcxCustomTreeListControl.DoDeleteSelection;
var
  AList: TList;
begin
  AList := GetSelectionsEx;
  BeginUpdate;
  try
    DeleteSelectionList(AList);
  finally
    FreeAndNil(AList);
    EndUpdate;
  end;
end;

procedure TcxCustomTreeListControl.AddToDelitionList(ANode: TcxTreeListNode);
begin
  FDeletedNodes.Add(Pointer(ANode.RecordIndex));
end;

procedure TcxCustomTreeListControl.DoRemoveNode(ANode: TcxTreeListNode);
begin
  if not SafeDelete and cxInRange(ANode.RecordIndex, 0, FNodesList.Count - 1) then
  begin
    FNodesList.List^[ANode.RecordIndex] := nil;
    AddToDelitionList(ANode);
  end;
  if HitTest.FHitNode = ANode then
    HitTest.FHitNode := nil;
  FSelection.Remove(ANode);
  if FCheckedList <> nil then
    FCheckedList.Remove(ANode);
  if LockUpdate = 0 then
    DoValidateDeletedNodes;
end;

procedure TcxCustomTreeListControl.DoCheckDeletedNode(ANode: TcxTreeListNode);

  function Validate(var ACheckedNode: TcxTreeListNode): Boolean;
  begin
    Result := ACheckedNode = ANode;
    if Result then
      ACheckedNode := nil;
  end;

begin
  if Validate(Controller.IncSearchNode) then
    Controller.CancelIncSearching;
  Validate(Controller.HotTrackNode);
  Validate(Controller.SelectionAnchorNode);
end;

procedure TcxCustomTreeListControl.DoDeleteNode(ANode: TcxTreeListNode);
begin
  if IsDestroying or SafeDelete then Exit;
  UpdateFocusedRecordPost;
  DoRemoveNode(ANode);
end;

procedure TcxCustomTreeListControl.DoInplaceEditContainerItemRemoved(
  AItem: TcxCustomInplaceEditContainer);
begin
  TcxTreeListColumn(AItem).OwnerBand := nil;
  inherited DoInplaceEditContainerItemRemoved(AItem);
end;

procedure TcxCustomTreeListControl.DoInternalMoveTo(AttachNode: TcxTreeListNode;
  AttachMode: TcxTreeListNodeAttachMode; ANodes: TList; IsCopy: Boolean);

  function CheckNodesList: Boolean;
  var
    I: Integer; 
  begin
    I := 0;
    while I < ANodes.Count do
    begin
      if TcxTreeListNode(ANodes[I]).CanMove(AttachNode, AttachMode) then
        Inc(I)
      else
        ANodes.Delete(I);
    end;
    Result := ANodes.Count > 0;
  end;

var
  IsDone: Boolean;
begin
  IsDone := False;
  if IsCopy and (AttachMode = tlamInsert) then
    AttachNode := AttachNode.Parent;
  if not CheckNodesList then Exit;
  DoOnMoveTo(AttachNode, AttachMode, ANodes, IsCopy, IsDone);
  if not IsDone then
  begin
    Freeze;
    try
      DoMoveTo(AttachNode, AttachMode, ANodes, IsCopy);
    finally
      UnFreeze;
    end;
  end;
end;

procedure TcxCustomTreeListControl.DoMoveTo(AttachNode: TcxTreeListNode;
 AttachMode: TcxTreeListNodeAttachMode; ANodes: TList; IsCopy: Boolean);
var
  I: Integer;
begin
  with ANodes do
  begin
    for I := Count - 1 downto 0 do
    begin
      if IsCopy then
        InternalCopy(TcxTreeListNode(List^[I]), AttachNode)
      else
        InternalMove(TcxTreeListNode(List^[I]), AttachNode, AttachMode);
    end;
  end;
end;

procedure TcxCustomTreeListControl.DoOnAfterSorting;
begin
  if Assigned(FOnAfterSorting) then FOnAfterSorting(Self);
end;

procedure TcxCustomTreeListControl.DoOnBandSizeChanged(ABand: TcxTreeListBand);
begin
  if Assigned(FOnBandSizeChanged) then
    FOnBandSizeChanged(Self, ABand);
end;

procedure TcxCustomTreeListControl.DoOnColumnSizeChanged(
  AColumn: TcxTreeListColumn);
begin
  if Assigned(FOnColumnSizeChanged) then
    FOnColumnSizeChanged(Self, AColumn);
end;

procedure TcxCustomTreeListControl.DoOnCollapsed(ANode: TcxTreeListNode);
begin
  if Assigned(FOnCollapsed) then
    FOnCollapsed(Self, ANode);
end;

procedure TcxCustomTreeListControl.DoOnCollapsing(
  ANode: TcxTreeListNode; var Allow: Boolean);
begin
  if Assigned(FOnCollapsing) then
    FOnCollapsing(Self, ANode, Allow);
end;

procedure TcxCustomTreeListControl.DoOnCompare(
  ANode1, ANode2: TcxTreeListNode; var ACompare: Integer);
begin
  ACompare := 1;
  if Assigned(FOnCompare) then
    FOnCompare(Self, ANode1, ANode2, ACompare);
end;

procedure TcxCustomTreeListControl.DoOnCustomizationVisibleChanged;
begin
  if Assigned(FOnCustomizationVisibleChanged) then
    FOnCustomizationVisibleChanged(Self);
end;

procedure TcxCustomTreeListControl.DoOnDeletion(ANode: TcxTreeListNode);
begin
  if Assigned(FOnDeletion) then
    FOnDeletion(Self, ANode);
end;

procedure TcxCustomTreeListControl.DoOnExpanded(ANode: TcxTreeListNode);
begin
  if Assigned(FOnExpanded) then
    FOnExpanded(Self, ANode);
end;

procedure TcxCustomTreeListControl.DoOnExpanding(
  ANode: TcxTreeListNode; var Allow: Boolean);
begin
  if Assigned(FOnExpanding) then
    FOnExpanding(Self, ANode, Allow);
end;

procedure TcxCustomTreeListControl.DoOnGetNodeHeight(
  ANode: TcxTreeListNode; var AHeight: Integer);
begin
  if Assigned(FOnGetNodeHeight) then
    FOnGetNodeHeight(Self, ANode, AHeight)
end;

procedure TcxCustomTreeListControl.DoOnHotTrackNode(
  ANode: TcxTreeListNode; AShift: TShiftState; var ACursor: TCursor);
begin
  ACursor := Cursor;
  if Assigned(FOnHotTrackNode) then
    FOnHotTrackNode(Self, ANode, AShift, ACursor);
end;

procedure TcxCustomTreeListControl.DoOnMoveTo(AttachNode: TcxTreeListNode;
  AttachMode: TcxTreeListNodeAttachMode; Nodes: TList; var IsCopy, Done: Boolean);
begin
  if Assigned(FOnMoveTo) then
    FOnMoveTo(Self, AttachNode, AttachMode, Nodes, IsCopy, Done);
end;

procedure TcxCustomTreeListControl.DoOnIsGroupNode(
  ANode: TcxTreeListNode; var IsGroup: Boolean);
begin
  if Assigned(FOnIsGroupNode) then
    FOnIsGroupNode(Self, ANode, IsGroup);
end;

procedure TcxCustomTreeListControl.DoOnTopRecordIndexChanged;
begin
  if Assigned(FOnTopRecordIndexChanged) then
    FOnTopRecordIndexChanged(Self);
end;

procedure TcxCustomTreeListControl.DoStartDrag(var DragObject: TDragObject);
begin
  if DragMode = dmManual then
    DragPos := ScreenToClient(GetMouseCursorPos);
  if HitTest.HitNode = nil then
    HitTest.FHitNode := FDragNode;
  inherited DoStartDrag(DragObject);
end;

function TcxCustomTreeListControl.DoWriteHeaderToText: string;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to VisibleColumnCount - 1 do
  begin
    if I > 0 then
      Result := Result + cxColumnTextSeparator;
    Result := Result + VisibleColumns[I].Caption.Text;
  end;
end;

function TcxCustomTreeListControl.DoWriteNodeToText(ANode: TcxTreeListNode): string;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to VisibleColumnCount - 1 do
  begin
    if Result <> '' then
      Result := Result + cxColumnTextSeparator;
    Result := Result + VisibleColumns[I].DisplayTexts[ANode.RecordIndex];
  end;
end;

procedure TcxCustomTreeListControl.DoWriteToClipboard(AOnlySelected: Boolean);
var
  AText: string;
begin
  if DoWriteToText(AOnlySelected, AText) then
    ClipBoard.AsText := AText
end;

function TcxCustomTreeListControl.DoWriteToText(AOnlySelected: Boolean; out AText: string): Boolean;
var
  ANode: TcxTreeListNode;
begin
  ANode := Nodes.Root.GetFirstChild;
  if OptionsView.Headers then
    AText := DoWriteHeaderToText
  else
    AText := '';
  while ANode <> nil do
  begin
    if not AOnlySelected or ANode.Selected then
    begin
      if AText <> '' then
        AText := AText + cxLineSeparator;
      AText := AText + DoWriteNodeToText(ANode);
    end;
    ANode := ANode.GetNext;
  end;
  Result := AText <> '';
end;

procedure TcxCustomTreeListControl.DoUpdateDesignerForms;
begin
  if FNeedUpdateDesigners and (IsLocked and not IsDestroying) then Exit;
  FNeedUpdateDesigners := True;
  if IsDestroying or not IsLocked then
    UpdateDesignerForms;
end;

procedure TcxCustomTreeListControl.DoDeleteRecords;
begin
  if FDeletedNodes.Count <> 0 then
  begin
    DataController.Cancel;
    TcxDataControllerAccess(DataController).DeleteRecords(FDeletedNodes)
  end;
end;

procedure TcxCustomTreeListControl.DoValidateDeletedNodes;
var
  I, ACount: Integer;
begin
  ACount := FDeletedNodes.Count;
  if ACount = 0 then Exit;
  BeginUpdate;
  try
    FNodesList.Pack;
    FDeletedNodes.Sort(cxIntegerListCompare);
    for I := Integer(FDeletedNodes[0]) to FNodesList.Count - 1 do
      TcxTreeListNode(FNodesList.List^[I]).RecordIndex := I;
    if not FSafeDelete then DoDeleteRecords;
  finally
    FDeletedNodes.Clear;
    EndUpdate;
  end;
end;

procedure TcxCustomTreeListControl.DeleteSelectionList(AList: TList);
var
  I: Integer;
  ANode: TcxTreeListNode;
begin
  FCheckedList := AList;
  try
    I := -1;
    while AList.Count > 0 do
    try
      I := AList.Count;
      ANode := TcxTreeListNode(AList.List^[AList.Count - 1]);
      if ANode.Selected then
        ANode.Free;
    finally
      if I = AList.Count then AList.Delete(I - 1);
      I := AList.Count;
    end
  finally
    FCheckedList := nil;
  end;
end;

function TcxCustomTreeListControl.GetCountNodeForBestFit: Integer;
begin
  Result := -1;
end;

function TcxCustomTreeListControl.GetImageIndentWidth(
  AType: TcxTreeListImageIndexType): Integer;
begin
  Result := FMaxIndentWidth;
end;

function TcxCustomTreeListControl.GetIsActive: Boolean;
begin
  Result := Controller.Focused;
end;

function TcxCustomTreeListControl.GetFixedContentSize: Integer;
begin
  Result := 0;
  if (Bands.FirstVisible <> nil) and (Bands.FirstVisible.FixedKind = tlbfLeft) then
    Inc(Result, Bands.FirstVisible.DisplayWidth);
  if (Bands.LastVisible <> nil) and (Bands.LastVisible.FixedKind = tlbfRight) then
    Inc(Result, Bands.LastVisible.DisplayWidth);
end;

function TcxCustomTreeListControl.GetLevelIndentCount(
  ALevel: Integer; AWithImages: Boolean; ANode: TcxTreeListNode): Integer;
begin
  Result := ALevel + Byte(OptionsView.ShowRoot);
  if AWithImages then
    Result := Result + Byte((Images <> nil) and (DoGetNodeImageIndex(ANode, tlitImageIndex) >= 0));
  if (StateImages <> nil) and (DoGetNodeImageIndex(ANode, tlitStateIndex) >= 0) then
    Inc(Result);
end;

function TcxCustomTreeListControl.GetLevelIndentsWidth(ALevel: Integer;
  AWithImages: Boolean; ANode: TcxTreeListNode): Integer;
begin
  Result := GetLevelIndentCount(ALevel, AWithImages, ANode) * FLevelIndentWidth;
end;

function TcxCustomTreeListControl.GetMaxBandWidth(ABand: TcxTreeListBand): Integer;
var
  I, J: Integer;
begin
  if not OptionsView.ColumnAutoWidth then
    Result := MaxInt
  else
  begin
    Result := cxRectWidth(ClientBounds) -
      FixedBandCount * OptionsView.FixedSeparatorWidth -
        OptionsView.IndicatorWidth * Byte(OptionsView.Indicator);
    J := FBandsVisibleList.IndexOf(ABand);
    if J = FBandsVisibleList.Count - 1 then
      for I := VisibleBandCount - 2 downto 0 do
        Dec(Result, VisibleBands[I].BandRows.ColumnsMinWidth)
    else
    begin
      for I := 0 to VisibleBandCount - 1 do
        if I < J then
          Dec(Result, VisibleBands[I].DisplayWidth)
        else
          if I > J then
            Dec(Result, VisibleBands[I].BandRows.ColumnsMinWidth);
    end;
  end;
end;

function TcxCustomTreeListControl.GetMouseWheelScrollingKind: TcxMouseWheelScrollingKind;
begin
  Result := mwskVertical; 
end;

function TcxCustomTreeListControl.GetStartNodeForBestFit: TcxTreeListNode;
begin
  Result := Nodes.Root.GetFirstChild;
end;

function TcxCustomTreeListControl.HasImages: Boolean;
begin
  Result := (StateImages <> nil) or (Images <> nil);
end;

function TcxCustomTreeListControl.ImagesIndentWidth: Integer;
begin
  Result := 0;
  if StateImages <> nil then
    Inc(Result, FLevelIndentWidth);
  if Images <> nil then
    Inc(Result, FLevelIndentWidth);
end;

function TcxCustomTreeListControl.InsertNode(IsAppend: Boolean): Boolean;
var
  ANode, AttachNode: TcxTreeListNode;
const
  AMode: array[Boolean] of TcxTreeListNodeAttachMode = (tlamAdd, tlamInsert);
begin
  AttachNode := FocusedNode;
  Result := False;
  if AttachNode <> nil then
  begin
    if IsAppend and (AttachNode.Parent.Parent = nil) then
      AttachNode := nil;
    BeginUpdate;
    try
      ANode := AddNode(nil, AttachNode, nil, AMode[IsAppend]);
      Result := ANode <> nil;
      if Result then ANode.Focused := True;
    finally
      EndUpdate;
    end;
  end
  else
    if IsAppend then
      AddNode(nil, nil, nil, tlamAdd).Focused := True;
end;

procedure TcxCustomTreeListControl.InternalMove(
  ANode, ADestNode: TcxTreeListNode; AMode: TcxTreeListNodeAttachMode);
begin
  if (ANode = nil) or (ADestNode = nil) or ADestNode.HasAsParent(ANode) or
    ((ADestNode = ANode.Parent) and (AMode = tlamAddChild)) or (ANode = ADestNode) then Exit;
  Nodes.InternalAddNode(ANode, ADestNode, AMode);
end;

procedure TcxCustomTreeListControl.InternalCopy(
  ANode, ADestNode: TcxTreeListNode);
var
  I: Integer;
  ANewNode: TcxTreeListNode;
begin
  ANewNode := AddNode(nil, ADestNode, nil, tlamAddChild);
  for I := 0 to ANode.ValueCount - 1 do
    ANewNode.Values[I] := ANode.Values[I];
  ANewNode.FState := ANode.FState;
  ANewNode.Data := ANode.Data;
  ANode := ANode.GetFirstChild;
  while ANode <> nil do
  begin
    InternalCopy(ANode, ANewNode);
    ANode := ANode.FNext;
  end;
end;

function TcxCustomTreeListControl.IsMultiSelect: Boolean;
begin
  Result := OptionsSelection.MultiSelect;
end;

function TcxCustomTreeListControl.IsCancelOperation: Boolean;
var
  AIndex: Integer;
begin
  Result := not SafeDelete and not SkipCancelOperation;
  if not Result then Exit;
  AIndex := DataController.RecordCount;
  DataController.Post;
  Result := DataController.RecordCount <> AIndex;
end;

function TcxCustomTreeListControl.IsSmartLoad: Boolean;
begin
  Result := False;
end;

function TcxCustomTreeListControl.IsNodeInserted(ANode: TcxTreeListNode): Boolean;
begin
  Result := dceInsert in DataController.EditState;
end;

function TcxCustomTreeListControl.IsNodeEdited(ANode: TcxTreeListNode): Boolean;
begin
  Result := dceEdit in DataController.EditState;
end;

procedure TcxCustomTreeListControl.MakeNodeVisible(ANode: TcxTreeListNode);
var
  AIndex: Integer;
  IsInvalidValid: Boolean;                
begin
  if (ANode <> nil) and (ANode.IsVisible) then
  begin
    IsInvalidValid := Nodes.IsInvalidState and IsLocked;
    AIndex := Nodes.TopIndex;
    Nodes.CalculateInfo(False);
    if not IsInvalidValid {and not IsLocked} then
      ViewInfo.NodesViewInfo.MakeNodeVisible(ANode)
    else
    begin
      Nodes.TopIndex := 0;
      Nodes.TopNode := Nodes.Root.FFirst;
      Nodes.TopNode := Nodes.GetVisibleNode(AIndex);
      Nodes.TopIndex := AIndex;
      ANode.MakeVisible;
      StoreTopPos;
    end;
  end;
end;

procedure TcxCustomTreeListControl.RefreshVisibleIndexes;

  procedure AddToVisibleList(AColumn: TcxTreeListColumn);
  begin
    if AColumn.Visibility and not AColumn.IsPreview then
      FColumnsVisibleList.Add(AColumn);
  end;

var
  I: Integer;
begin
  FBandsVisibleList.Sort(cxCompareVisibleBands);
  FColumnsVisibleList.Clear;
  with ColumnsList do
  begin
    FColumnsVisibleList.Capacity := Count;
// todo :// sizing
//    for  I := 0 to Bands.Count - 1 do
//      if Bands[I].Visible then Bands[I].RebuildRows;
    for I := 0 to Count - 1 do
      AddToVisibleList(TcxTreeListColumn(List^[I]));
  end;
  FColumnsVisibleList.Sort(cxCompareColumnsPosEx);
end;

procedure TcxCustomTreeListControl.RestoreCursor;
begin
  if FUseGlassCursor = 1 then
  begin
    Dec(FUseGlassCursor);
    Screen.Cursor := FStoredCursor;
  end;
end;

procedure TcxCustomTreeListControl.RestoreSorting;
begin
end;

procedure TcxCustomTreeListControl.SetGlassCursor;
begin
  with TcxTreeListOptionsBehavior(OptionsBehavior) do
    if (FUseGlassCursor > 0) or not ShowHourGlass then Exit;
  FUseGlassCursor := 1;
  if OptionsBehavior.HotTrack and (Controller.HotTrackNode <> nil) then
    FStoredCursor := Controller.PrevCursor
  else
    FStoredCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
end;

function TcxCustomTreeListControl.SkipFocusedRecordChanged: Boolean;
begin
  Result := False;
end;

function TcxCustomTreeListControl.SkipCancelOperation: Boolean;
begin
  Result := True;
end;

procedure TcxCustomTreeListControl.SortingStateChanged(
  AColumn: TcxTreeListColumn; AShift: TShiftState);
begin
end;

procedure TcxCustomTreeListControl.OnChangeImages(Sender: TObject);
begin
  UpdateViewStyles;
end;

procedure TcxCustomTreeListControl.SaveDragPos;
begin
end;

procedure TcxCustomTreeListControl.RestoreDragPos;
begin
end; 

function TcxCustomTreeListControl.RealBandLineHeight: Integer;
begin
  Result := FRealBandLineHeight;
end; 

procedure TcxCustomTreeListControl.ReadData(AStream: TStream);
var
  ASignature: TcxTreeListDataSignature;
begin
  AStream.ReadBuffer(ASignature, SizeOf(ASignature));
  with ASignature do
    if (Size <> AStream.Size) then
      cxTreeListError(scxStr(@scxInvalidStreamFormat));
  AStream.Position := SizeOf(ASignature);
end;

procedure TcxCustomTreeListControl.RealignBands;
var
  AAutoWidth: TcxAutoWidthObject;
  I: Integer;
begin
  CalculateLeftMostIndentWidth;
  Bands.RealignColumns;
  if OptionsView.ColumnAutoWidth then
  begin
    AAutoWidth := TcxAutoWidthObject.Create(VisibleBandCount);
    try
      with OptionsView do
        AAutoWidth.AvailableWidth := cxRectWidth(ClientBounds) - FContentIndentWidth -
          FixedBandCount * FixedSeparatorWidth - IndicatorWidth * Byte(Indicator);
      for I := 0 to VisibleBandCount - 1 do
        VisibleBands[I].InitAutoWidthItem(AAutoWidth.AddItem);
      AAutoWidth.Calculate;
      for I := 0 to VisibleBandCount - 1 do
        VisibleBands[I].FCalculatedWidth := AAutoWidth.Items[I].AutoWidth;
    finally
      AAutoWidth.Free;
    end;
  end;
  Bands.RealignColumns;
end;

procedure TcxCustomTreeListControl.UpdateEditValue;
begin
  if not Controller.IsDestroying then
    TcxEditingControllerAccess(Controller.EditingController).UpdateEditValue;
end;

procedure TcxCustomTreeListControl.WriteData(AStream: TStream);
var
  ASignature: TcxTreeListDataSignature;
begin
  ASignature.Version := cxTreeListVersion;
  ASignature.Size := AStream.Size; 
  AStream.Position := 0;
  AStream.WriteBuffer(ASignature, SizeOf(ASignature));
end;

function TcxCustomTreeListControl.SupportsBandColumnEditor: Boolean;
begin
  Result := False;
end;

function TcxCustomTreeListControl.SupportsItemsEditor: Boolean;
begin
  Result := False;
end;

function TcxCustomTreeListControl.SupportsCreateAllItems: Boolean;
begin
  Result := False;
end;

function TcxCustomTreeListControl.GetVersion: string;
begin
  Result := cxTLMajorVersion + '.' + IntToStr(dxBuildNumber);
end;

procedure TcxCustomTreeListControl.CreateAllItems;
begin
end;

// IcxNavigator
procedure TcxCustomTreeListControl.RefreshNavigatorButtons;
begin
  if not (IsLoading or IsDestroying) and (FNavigatorNotifier <> nil) then
    FNavigatorNotifier.RefreshNavigatorButtons;
end;

procedure TcxCustomTreeListControl.DoAction(AButtonIndex: Integer);
begin
  case AButtonIndex of
    NBDI_FIRST:
      GotoBOF;
    NBDI_PRIORPAGE:
      GotoPrevPage;
    NBDI_PRIOR:
      GotoPrev;
    NBDI_NEXT:
      GotoNext;
    NBDI_NEXTPAGE:
      GotoNextPage;
    NBDI_LAST:
      GotoEOF;
    NBDI_INSERT:
      if FocusedNode <> nil then
        AddNode(nil, FocusedNode, nil, tlamInsert).Focused := True
      else
        AddNode(nil, Nodes.Root, nil, tlamAdd).Focused := True;
    NBDI_APPEND:
      if FocusedNode <> nil then
        AddNode(nil, FocusedNode.Parent, nil, tlamAdd).Focused := True
      else
        AddNode(nil, Nodes.Root, nil, tlamAdd).Focused := True;
    NBDI_DELETE:
      Self.DeleteSelection;
    NBDI_EDIT:
      ShowEdit;
    NBDI_POST:
      begin
        DataController.PostEditingData;
        DataController.Post;
      end;
    NBDI_CANCEL:
    begin
      DataController.Cancel;
      UpdateEditValue;
    end;
    NBDI_REFRESH:
      DataController.Refresh;
    NBDI_SAVEBOOKMARK:
      SaveBookmark;
    NBDI_GOTOBOOKMARK:
      GotoBookmark;
  end;
end;

function TcxCustomTreeListControl.GetNotifier: TcxNavigatorControlNotifier;
begin
  Result := FNavigatorNotifier;
end;

function TcxCustomTreeListControl.IsActionSupported(AButtonIndex: Integer): Boolean;
begin
  Result := AButtonIndex in [NBDI_FIRST..NBDI_GOTOBOOKMARK];
end;

function TcxCustomTreeListControl.CanAppend: Boolean;
begin
  Result := CanInsert; 
end;

function TcxCustomTreeListControl.CanEdit: Boolean;
begin
  Result := OptionsData.Editing and (HasData or CanInsert) and not IsEditing;
end;

function TcxCustomTreeListControl.CanDelete: Boolean;
begin
  Result := OptionsData.Deleting and HasData;
end;

function TcxCustomTreeListControl.CanInsert: Boolean;
begin
  Result := OptionsData.Inserting and ((FocusedNode <> nil) or not HasData);
end;

procedure TcxCustomTreeListControl.ClearBookmark;
begin
  DataController.ClearBookmark;
end;

procedure TcxCustomTreeListControl.GotoBookmark;
begin
  DataController.GotoBookmark;
end;

function TcxCustomTreeListControl.HasData: Boolean;
begin
  Result := (VisibleColumnCount > 0) and (Nodes.Count > 0);
end;

function TcxCustomTreeListControl.IsBookmarkAvailable: Boolean;
begin
  Result := DataController.IsBookmarkAvailable and HasData;
end;

procedure TcxCustomTreeListControl.SaveBookmark;
begin
  DataController.SaveBookmark;
end;

function TcxCustomTreeListControl.UseRowIndexForNewRecord: Boolean;
begin
  Result := True;
end;

procedure TcxCustomTreeListControl.Freeze;
begin
  Inc(FFreezeCount);
end;

function TcxCustomTreeListControl.IsLocked: Boolean;
begin
  Result := inherited IsLocked or (FFreezeCount <> 0) or
    (csUpdating in ComponentState);
end;

function TcxCustomTreeListControl.IsFreeze: Boolean;
begin
  Result := FFreezeCount > 0;
end;

procedure TcxCustomTreeListControl.UnFreeze;
begin
  Dec(FFreezeCount);
  if FFreezeCount = 0 then
  begin
    BeforeUpdate;
    LayoutChanged;
  end;
end;

function TcxCustomTreeListControl.CreateNode: TcxTreeListNode;
begin
  Result := TcxUnboundTreeListNode.Create(Nodes);
end;

function TcxCustomTreeListControl.DoCanNodeCollapse(
  ANode: TcxTreeListNode): Boolean;
begin
  Result := ANode.HasChildren;
  if Result then
    DoOnCollapsing(ANode, Result);
end;

function TcxCustomTreeListControl.DoCanNodeExpand(
  ANode: TcxTreeListNode): Boolean;
begin
  Result := ANode.HasChildren;
  if Result then
    DoOnExpanding(ANode, Result);
end;

function TcxCustomTreeListControl.DoCreateNode: TcxTreeListNode;
begin
  BeginUpdate;
  try
    DoValidateDeletedNodes;
    Result := CreateNode;
  finally
    NeedSortPost;
    EndUpdate;
  end;
end;

function TcxCustomTreeListControl.DoGetNodeImageIndex(
  ANode: TcxTreeListNode; AIndex: TcxTreeListImageIndexType): TImageIndex;
begin
  LockChanges := True;
  try
    if ANode = nil then
      Result := -1
    else
    begin
      Result := ANode.FImageIndexes[AIndex];
      if (AIndex = tlitSelectedIndex) and (Result = -1) and OptionsView.UseImageIndexForSelected then
        Result := ANode.FImageIndexes[tlitImageIndex];
      if Assigned(OnGetNodeImageIndex) then
        OnGetNodeImageIndex(Self, ANode, AIndex, Result);
    end;
  finally
    LockChanges := False; 
  end;
end;

function TcxCustomTreeListControl.DoGetNodeValueCount: Integer;
begin
  Result := ColumnCount;
end;

procedure TcxCustomTreeListControl.DoNodeChanged(
  ANode: TcxTreeListNode);
begin
  LayoutChanged;
end;

function TcxCustomTreeListControl.DoIsGroupNode(
  ANode: TcxTreeListNode): Boolean;
begin
  Result := False;
  if (ANode <> nil) and (OptionsView.PaintStyle = tlpsCategorized) then
  begin
    Result := ANode.HasChildren;
    DoOnIsGroupNode(ANode, Result);
  end;
end;

procedure TcxCustomTreeListControl.DoSelectAll;
var
  ANode: TcxTreeListNode;
begin
  ANode := Nodes.Root.FFirst;
  if ANode <> nil then FSelection.Clear;
  FSelection.Capacity := Nodes.VisibleCount + 1;
  while ANode <> nil do
  begin
    if DoCanSelectNode(ANode) then
      FSelection.Add(ANode);
    ANode := ANode.GetNext
  end;
end;

procedure TcxCustomTreeListControl.DoSetNodeExpanded(
  ANode: TcxTreeListNode; AExpanded: Boolean);

  procedure DoChanging(AAllowFunc: TAllowExpandChangingFunc; AState: Integer);
  begin
    if AAllowFunc then
    begin
      FPostChanged := True;
      ANode.FState := AState;
      if ANode.FCount > 0 then
        ANode.FState := ANode.FState or tlnsHasChildren
      else
        ANode.FState := ANode.FState and not tlnsHasChildren;
      if AExpanded then
        DoOnExpanded(ANode)
      else
        DoOnCollapsed(ANode);
      Nodes.IsInvalidState := True;
      LayoutChanged;
    end;
  end;

const
  AExpandedState = tlnsCollapsed or tlnsHasChildren;
begin
  StoreTopPos;
//  Controller.EditingController.StopEditShowingTimer;
  FNeedMakeVisible := False;
  if (ANode.Expanded <> AExpanded) and ANode.HasChildren then
  begin
    if AExpanded then
      DoChanging(ANode.CanExpand, ANode.FState and not AExpandedState)
    else
      DoChanging(ANode.CanCollapse, ANode.FState or AExpandedState);
  end;
  FNeedMakeVisible := True;
end;

procedure TcxCustomTreeListControl.DoSetNodeImageIndex(
  ANode: TcxTreeListNode; AIndex: TcxTreeListImageIndexType; Value: TImageIndex);
begin
end;

procedure TcxCustomTreeListControl.DoSetNodeFocused(
  ANode: TcxTreeListNode; Value: Boolean; Shift: TShiftState = []);
begin
  if Value then
    FocusedNode := ANode
  else
    if ANode.Focused then FocusedNode := nil;
end;

procedure TcxCustomTreeListControl.DoSorting;
begin
  if Assigned(FOnSorting) then FOnSorting(Self);
end;

function TcxCustomTreeListControl.GetColumnById(
  AItemIndex: Integer): TcxTreeListColumn;
begin
  if cxInRange(AItemIndex, 0, ColumnCount - 1) then 
    Result := Columns[AItemIndex]
  else
    Result := nil;
end;

function TcxCustomTreeListControl.GetNodeByID(
  ARecordIndex: Integer): TcxTreeListNode;
begin
  if cxInRange(ARecordIndex, 0, FNodesList.Count - 1) then
    Result := FNodesList.List^[ARecordIndex]
  else
    Result := nil;
end;

function TcxCustomTreeListControl.GetSelectionsEx: TList;
begin
  Result := TList.Create;
  GetSelections(Result);
  if (FocusedNode <> nil) and not FocusedNode.Selected then
    Result.Add(FocusedNode);
end;

procedure TcxCustomTreeListControl.CancelSortPost;
begin
  FNeedSortPost := False;
end;

procedure TcxCustomTreeListControl.DisableSorting;
begin
  Inc(FSortLocking);
end;

procedure TcxCustomTreeListControl.DoSortNodes;
begin
  if (FSortLocking = 0) and not IsDestroying and
    (DataController.RecordCount = FNodesList.Count) then
  begin
    DoSorting;
    try
      CancelSortPost;
      if Sorted then
      try
        RecreateSortOrdersList;
      finally
        Nodes.Root.AlphaSort(True);
      end
      else
        if FNeedRestoreSorting then
        begin
          FNeedRestoreSorting := False;
          RestoreSorting;
        end;
    finally
      DoOnAfterSorting;
    end;
  end;
end;

procedure TcxCustomTreeListControl.EnableSorting;
begin
  Dec(FSortLocking);
  if FSortLocking = 0 then DoSortNodes;
end;

procedure TcxCustomTreeListControl.NeedSortPost;
begin
  FNeedSortPost := True;
end;

procedure TcxCustomTreeListControl.BeginUpdateSelection;
begin
  Inc(FSelectionUpdateLocked);
end;

procedure TcxCustomTreeListControl.CancelUpdateSelection;
begin
  Dec(FSelectionUpdateLocked);
end;

procedure TcxCustomTreeListControl.EndUpdateSelection;
begin
  Dec(FSelectionUpdateLocked);
  if FSelectionUpdateLocked = 0 then UpdateSelection;
end;

procedure TcxCustomTreeListControl.UpdateSelection;
begin
  ViewInfo.NodesViewInfo.CheckSelectionMode := True;
  try
    ViewInfo.UpdateSelection;
  finally
    ViewInfo.NodesViewInfo.CheckSelectionMode := False;
    DoSelectionChanged;
  end;
end;

procedure TcxCustomTreeListControl.CancelFocusedRecordUpdatePost;
begin
  FNeedFocusedRecordUpdatePost := False;
end;

procedure TcxCustomTreeListControl.PostUpdateFocusedRecord;
var
  ANode: TcxTreeListNode;
begin
  try
    if (ViewInfo.NodesViewInfo.Count <> 0) and FNeedFocusedRecordUpdatePost then
    begin
      ANode := Nodes.GetVisibleNode(Nodes.FFocusedIndex);
      if ANode <> nil then
      begin
        ANode.MakeVisible;
        ANode.Focused := True;
      end;
    end;
  finally
    CancelFocusedRecordUpdatePost;
  end;
end;

procedure TcxCustomTreeListControl.UpdateFocusedRecordPost;
begin
  if IsDestroying then Exit; 
  if not FNeedFocusedRecordUpdatePost and (FocusedNode <> nil) then
  begin
    FNeedFocusedRecordUpdatePost := True;
    FNodes.FFocusedIndex := FocusedNode.VisibleIndex;
  end;
end;

function TcxCustomTreeListControl.IsSelectionLocked: Boolean;
begin
  Result := FSelectionUpdateLocked <> 0;
end;

function TcxCustomTreeListControl.IsNeedSortPost: Boolean;
begin
  Result := FNeedSortPost;
end;

procedure TcxCustomTreeListControl.RecreateSortOrdersList;

  procedure AddSortInfo(AColumn: TcxTreeListColumn);
  var
    ASortInfo: PcxDataSortInfo;
  begin
    if AColumn.GetRealSortOrder = soNone then Exit;
    New(PcxDataSortInfo(ASortInfo));
    with ASortInfo^ do
    begin
      Field := TcxDataControllerAccess(DataController).Fields[AColumn.ItemIndex];
      SortOrder := AColumn.GetRealSortOrder;
    end;
    FSortOrderList.Add(ASortInfo);
  end;

var
  I: Integer;
begin
  for I := 0 to SortOrderList.Count - 1 do
    Dispose(PcxDataSortInfo(SortOrderList.List^[I]));
  FSortOrderList.Clear;
  for I := 0 to SortedColumnCount - 1 do
    AddSortInfo(SortedColumns[I]);
end;

function TcxCustomTreeListControl.CheckEvent(AHasHandler: Boolean): Boolean;
begin
  FPostChanged := True;
  Result := AHasHandler;
end;

procedure TcxCustomTreeListControl.DoBandHeaderClick(ABand: TcxTreeListBand);
begin
  if CheckEvent(Assigned(FOnBandHeaderClick)) then
    FOnBandHeaderClick(Self, ABand);
end;

procedure TcxCustomTreeListControl.DoColumnHeaderClick(AColumn: TcxTreeListColumn);
begin
  if CheckEvent(Assigned(FOnColumnHeaderClick)) then
    FOnColumnHeaderClick(Self, AColumn);
end;

procedure TcxCustomTreeListControl.DoChanged(BlockChangedEvent: Boolean = True);
begin
  if BlockChangedEvent and (OptionsBehavior.ChangeDelay > 0) then Exit;
  try
    if FPostChanged and CheckEvent(Assigned(FOnChange)) then
      FOnChange(Self);
  finally
    FPostChanged := False;
  end; 
end;

function TcxCustomTreeListControl.DoCanSelectNode(ANode: TcxTreeListNode): Boolean;
begin
  Result := True;
  if IsMultiSelect and (ANode <> nil) and CheckEvent(Assigned(FOnCanSelectNode)) then
    FOnCanSelectNode(Self, ANode, Result);
end;

procedure TcxCustomTreeListControl.DoDataChangedEvent(Sender: TObject);
begin
  if CheckEvent(Assigned(FOnDataChanged)) then
    FOnDataChanged(Self);
end;

procedure TcxCustomTreeListControl.DoEditChanged(
  AItem: TcxCustomInplaceEditContainer);
begin
  CheckEvent(False);
  inherited DoEditChanged(AItem);
end;

procedure TcxCustomTreeListControl.DoEdited(
  AItem: TcxCustomInplaceEditContainer);
begin
  CheckEvent(False);
  inherited DoEdited(AItem);
end;

function TcxCustomTreeListControl.DoEditing(
  AItem: TcxCustomInplaceEditContainer): Boolean;
begin
  CheckEvent(False);
  Result := inherited DoEditing(AItem);
end;

procedure TcxCustomTreeListControl.DoEditValueChanged(
  AItem: TcxCustomInplaceEditContainer);
begin
  CheckEvent(False);
  inherited DoEditValueChanged(AItem);
end;

procedure TcxCustomTreeListControl.DoInitEdit(
  AItem: TcxCustomInplaceEditContainer; AEdit: TcxCustomEdit);
begin
  CheckEvent(False);
  inherited DoInitEdit(AItem, AEdit);
end;

procedure TcxCustomTreeListControl.DoFocusedItemChanged(
  APrevFocusedItem, AFocusedItem: TcxCustomInplaceEditContainer);
begin
  if CheckEvent(Assigned(FOnFocusedColumnChanged)) then
    FOnFocusedColumnChanged(Self,
      TcxTreeListColumn(APrevFocusedItem), TcxTreeListColumn(AFocusedItem));
end;

procedure TcxCustomTreeListControl.DoFocusedRecordChanged(
  APrevIndex, AFocusedIndex: Integer);
begin
  if CheckEvent(Assigned(FOnFocusedNodeChanged)) then
    FOnFocusedNodeChanged(Self, GetNodeByID(APrevIndex), GetNodeByID(AFocusedIndex));
  if not OptionsSelection.MultiSelect then DoSelectionChanged;
end;

procedure TcxCustomTreeListControl.DoLayoutChangedEvent;
begin
  if CheckEvent(Assigned(FOnLayoutChanged)) then
    FOnLayoutChanged(Self);
end;

procedure TcxCustomTreeListControl.DoRecordChanged(
  Sender: TcxCustomDataController; ARecordIndex, AItemIndex: Integer);
begin
  if CheckEvent(Assigned(FOnNodeChanged)) then
    FOnNodeChanged(Self, GetNodeByID(ARecordIndex), GetColumnById(AItemIndex));
end;

procedure TcxCustomTreeListControl.DoSelectionChanged;
begin
  if CheckEvent(Assigned(FOnSelectionChanged)) and not IsSelectionLocked then
    FOnSelectionChanged(Self);
end;

function TcxCustomTreeListControl.GetBandItemClass: TcxTreeListBandClass;
begin
  Result := TcxTreeListBand;
end;

function TcxCustomTreeListControl.GetControllerClass: TcxCustomControlControllerClass;
begin
  Result := TcxTreeListController;
end;

function TcxCustomTreeListControl.GetControlStylesClass: TcxCustomControlStylesClass;
begin
  Result := TcxTreeListStyles;
end;

function TcxCustomTreeListControl.GetHitTestControllerClass: TcxHitTestControllerClass;
begin
  Result := TcxTreeListHitTest;
end;

function TcxCustomTreeListControl.GetNodesClass: TcxTreeListNodesClass;
begin
  Result := TcxTreeListNodes;
end;

function TcxCustomTreeListControl.GetOptionsViewClass: TcxControlOptionsViewClass;
begin
  Result := TcxTreeListOptionsView; 
end;

function TcxCustomTreeListControl.GetOptionsCustomizingClass:
  TcxTreeListOptionsCustomizingClass;
begin
  Result := TcxTreeListOptionsCustomizing;
end;

function TcxCustomTreeListControl.GetOptionsBehaviorClass: TcxControlOptionsBehaviorClass;
begin
  Result := TcxTreeListOptionsBehavior;
end;

function TcxCustomTreeListControl.GetOptionsDataClass: TcxControlOptionsDataClass;
begin
  Result := TcxTreeListOptionsData;
end;

function TcxCustomTreeListControl.GetOptionsSelectionClass: TcxTreeListOptionsSelectionClass;
begin
  Result := TcxTreeListOptionsSelection;
end;

function TcxCustomTreeListControl.GetPainterClass: TcxCustomControlPainterClass;
begin
  Result := TcxTreeListControlPainter;
end;

function TcxCustomTreeListControl.GetPreviewClass: TcxTreeListPreviewClass;
begin
  Result := TcxTreeListPreview;
end;

function TcxCustomTreeListControl.GetTreeListColumnClass: TcxTreeListColumnClass;
begin
  Result := TcxTreeListColumn;
end;

function TcxCustomTreeListControl.GetTreeListCustomizingClass: TcxTreeListCustomizingClass;
begin
  Result := TcxTreeListCustomizing;
end;

function TcxCustomTreeListControl.GetViewInfoClass: TcxCustomControlViewInfoClass;
begin
  Result := TcxTreeListViewInfo;
end;

function TcxCustomTreeListControl.GetOnAfterSummary: TcxAfterSummaryEvent;
begin
  Result := DataController.Summary.OnAfterSummary;
end;

function TcxCustomTreeListControl.GetOnEditing: TcxTreeListEditingEvent;
begin
  Result := TcxTreeListEditingEvent(inherited OnEditing);
end;

function TcxCustomTreeListControl.GetOnEdited: TcxTreeListColumnChangedEvent;
begin
  Result := TcxTreeListColumnChangedEvent(inherited OnEdited);
end;

function TcxCustomTreeListControl.GetOnEditValueChanged: TcxTreeListColumnChangedEvent;
begin
  Result := TcxTreeListColumnChangedEvent(inherited OnEditValueChanged);
end;

function TcxCustomTreeListControl.GetOnSummary: TcxSummaryEvent;
begin
  Result := DataController.Summary.FooterSummaryItems.OnSummary;
end;

function TcxCustomTreeListControl.GetSearching: Boolean;
begin
  Result := Controller.IsIncSearching;
end;

function TcxCustomTreeListControl.GetSearchingText: string;
begin
  Result := Controller.IncSearchText
end;

function TcxCustomTreeListControl.GetBands: TcxTreeListBands;
begin
  Result := FBands;
end;

function TcxCustomTreeListControl.GetBandPanelHeight: Integer;
begin
  with OptionsView do
    Result := ViewInfo.BandLineHeight * BandLineCount * Byte(Bands);
end;

function TcxCustomTreeListControl.GetColumn(
  AIndex: Integer): TcxTreeListColumn;
begin
  Result := TcxTreeListColumn(ColumnsList[AIndex]);
end;

function TcxCustomTreeListControl.GetColumnCount: Integer;
begin
  Result := ColumnsList.Count;
end;

function TcxCustomTreeListControl.GetColumnsList: TList;
begin
  Result := inherited ContainerList;
end;

function TcxCustomTreeListControl.GetController: TcxTreeListController;
begin
  Result := TcxTreeListController(inherited Controller);
end;

function TcxCustomTreeListControl.GetCount: Integer;
begin
  Result := Nodes.Root.Count;
end;

function TcxCustomTreeListControl.GetDefaultRowHeight: Integer;
begin
  Result := FDefaultRowHeight;
  if Result = 0 then
    Result := ViewInfo.DefaultEditHeight;
end;

function TcxCustomTreeListControl.GetFixedBandCount: Integer;
begin
  if VisibleBandCount <> 0 then
    with Bands do
    begin
       Result := Byte(FirstVisible.FixedKind = tlbfLeft) +
         Byte(LastVisible.FixedKind = tlbfRight);
    end
  else
    Result := 0;
end;

function TcxCustomTreeListControl.GetFooterHeight: Integer;
begin
  Result := cxRectHeight(ViewInfo.FooterRect);
end;

function TcxCustomTreeListControl.GetFocusedColumn: TcxTreeListColumn;
begin
  Result := TcxTreeListColumn(Controller.FocusedItem);
end;

function TcxCustomTreeListControl.GetFocusedNode: TcxTreeListNode;
begin
  Result := Controller.FocusedNode;
end;

function TcxCustomTreeListControl.GetHeaderHeight: Integer;
begin
  with OptionsView do
    Result := Byte(Headers) * HeaderLineCount * ViewInfo.HeaderLineHeight;
end;

function TcxCustomTreeListControl.GetHeaderPanelHeight: Integer;
begin
  Result := HeaderHeight + BandPanelHeight;
end;

function TcxCustomTreeListControl.GetHitTest: TcxTreeListHitTest;
begin
  Result := TcxTreeListHitTest(Controller.HitTestController);
end;

function TcxCustomTreeListControl.GetLastNode: TcxTreeListNode;
begin
  Result := cxGetLatest(Nodes.Root.GetLastChild, False);
end;

function TcxCustomTreeListControl.GetLastVisibleNode: TcxTreeListNode;
var
  I: Integer;
begin
  I := VisibleCount - 1;
  Result := TopVisibleNode;
  while (I > 0) and (Result <> nil) do
  begin
    Result := Result.GetNextVisible;
    Dec(I);
  end;
end;

function TcxCustomTreeListControl.GetNavigatorIsActive: Boolean;
begin
  Result := DataController.Active;
end;

function TcxCustomTreeListControl.GetInplaceColumnIndex: Integer;
begin
  if IsEditing then
    Result := Controller.EditingController.EditingItem.ItemIndex
  else
    Result := -1;
end;

function TcxCustomTreeListControl.GetInplaceEditor: TcxCustomEdit;
begin
  if IsEditing then
    Result := Controller.EditingController.Edit
  else
    Result := nil;
end;

function TcxCustomTreeListControl.GetIsEditing: Boolean;
begin
  Result := Controller.IsEditing;
end;

function TcxCustomTreeListControl.GetItem(Index: Integer): TcxTreeListNode;
begin
  Result := Nodes.Root.Items[Index];
end;

function TcxCustomTreeListControl.GetOptionsBehavior: TcxTreeListOptionsBehavior;
begin
  Result := TcxTreeListOptionsBehavior(inherited OptionsBehavior);
end;

function TcxCustomTreeListControl.GetOptionsData: TcxTreeListOptionsData;
begin
  Result := TcxTreeListOptionsData(inherited OptionsData);
end;

function TcxCustomTreeListControl.GetOptionsView: TcxTreeListOptionsView;
begin
  Result := TcxTreeListOptionsView(inherited OptionsView);
end;

function TcxCustomTreeListControl.GetSelection(Index: Integer): TcxTreeListNode;
begin
  if (Index = 0) and not OptionsSelection.MultiSelect and (FocusedNode <> nil) then
    Result := FocusedNode
  else
    Result := TcxTreeListNode(FSelection[Index]);
end;

function TcxCustomTreeListControl.GetSelectionCount: Integer;
begin
  Result := FSelection.Count;
  if not OptionsSelection.MultiSelect and (FocusedNode <> nil) then
    Result := 1;
end;

function TcxCustomTreeListControl.GetSortedColumnCount: Integer;
begin
  Result := FSortedColumns.Count;
end;

function TcxCustomTreeListControl.GetSortedColumn(
  Index: Integer): TcxTreeListColumn;
begin
  Result := TcxTreeListColumn(FSortedColumns[Index]);
end;

function TcxCustomTreeListControl.GetStyles: TcxTreeListStyles;
begin
  Result := TcxTreeListStyles(inherited Styles);
end;

function TcxCustomTreeListControl.GetSummary: TcxDataSummary;
begin
  Result := DataController.Summary;
end;

function TcxCustomTreeListControl.GetSorted: Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to ColumnCount - 1 do
    if Columns[I].GetRealSortOrder <> soNone then
    begin
      Result := True;
      Break;
    end;
end;

function TcxCustomTreeListControl.GetTopNode: TcxTreeListNode;
begin
  Result := Nodes.Root.GetFirstChild;
end;

function TcxCustomTreeListControl.GetTopVisibleIndex: Integer;
begin
  Result := ViewInfo.NodesViewInfo.TopVisibleIndex;
end;

function TcxCustomTreeListControl.GetTopVisibleNode: TcxTreeListNode;
begin
  Result := ViewInfo.NodesViewInfo.TopNode;
  if Result = nil then
    Result := Nodes.TopNode;
end;

function TcxCustomTreeListControl.GetVisibleCount: Integer;
begin
  with ViewInfo.NodesViewInfo do
  begin
    if TopNode <> nil then
      Result := VisibleCount
    else
      Result := -1;
  end;
end;

function TcxCustomTreeListControl.GetViewInfo: TcxTreeListViewInfo;
begin
  Result := TcxTreeListViewInfo(inherited ViewInfo);
end;

function TcxCustomTreeListControl.GetVisibleBand(
  AIndex: Integer): TcxTreeListBand;
var
  I: Integer;
begin
  I := Bands.GetAbsoluteIndex(AIndex);
  if I <> - 1 then
    Result := Bands.GetItem(I)
  else
    Result := nil;
end;

function TcxCustomTreeListControl.GetVisibleBandCount: Integer;
begin
  Result := FBandsVisibleList.Count;
end;

function TcxCustomTreeListControl.GetVisibleColumn(
  AIndex: Integer): TcxTreeListColumn;
begin
  Result := TcxTreeListColumn(FColumnsVisibleList[AIndex])
end;

function TcxCustomTreeListControl.GetVisibleColumnCount: Integer;
begin
  Result := FColumnsVisibleList.Count;
end;

function TcxCustomTreeListControl.IsDefaultRowHeightAssigned: Boolean;
begin
  Result := FDefaultRowHeight <> 0;
end;

procedure TcxCustomTreeListControl.SetBands(Value: TcxTreeListBands);
begin
  FBands.Assign(Value);
end;

procedure TcxCustomTreeListControl.SetColumn(
  AIndex: Integer; Value: TcxTreeListColumn);
begin
  TcxTreeListColumn(ColumnsList[AIndex]).Assign(Value);
end;

procedure TcxCustomTreeListControl.SetDefaultRowHeight(Value: Integer);
begin
  if Value < 0 then Value := 0;
  with ViewInfo do
  begin
    if (DefaultEditHeight > 0) and (Value < DefaultEditHeight) then
      Value := DefaultEditHeight;
  end;
  FDefaultRowHeight := Value;
  LayoutChanged;
  Modified;
end;

procedure TcxCustomTreeListControl.SetDefaultLayout(Value: Boolean);
begin
  if Value <> FDefaultLayout then
  begin
    FDefaultLayout := Value;
    if Value then
      MakeDefaultLayout;
  end;
end;

procedure TcxCustomTreeListControl.SetFocusedColumn(Value: TcxTreeListColumn);
begin
  if (Value <> nil) and Value.Visibility then
    Controller.FocusedItem := Value
  else
    if Value = nil then
      Controller.FocusedItem := Value;
end;

procedure TcxCustomTreeListControl.SetFocusedNodeProp(Value: TcxTreeListNode);
begin
  SetFocusedNode(Value, []);
end;

procedure TcxCustomTreeListControl.SetImages(Value: TCustomImageList);
begin
  SetInternalImageList(Value, FImages, FChangeImagesLink);
end;

procedure TcxCustomTreeListControl.SetInternalImageList(
  AList: TCustomImageList; var Value: TCustomImageList; ALink: TChangeLink);
begin
  Freeze;
  try
    cxSetImageList(AList, Value, ALink, Self);
  finally
    UnFreeze;
  end;
end;

procedure TcxCustomTreeListControl.SetLastVisibleNode(Value: TcxTreeListNode);
begin
  if (Value <> nil) and Value.IsVisible then
    ViewInfo.NodesViewInfo.SetLastVisibleNode(Value);
end;

procedure TcxCustomTreeListControl.SetNodes(Value: TcxTreeListNodes);
begin
  FNodes.Assign(Value);
end;

procedure TcxCustomTreeListControl.SetOnAfterSummary(Value: TcxAfterSummaryEvent);
begin
  DataController.Summary.OnAfterSummary := Value;
end;

procedure TcxCustomTreeListControl.SetOnEdited(Value: TcxTreeListColumnChangedEvent);
begin
  inherited OnEdited := TcxecItemEvent(Value);
end;

procedure TcxCustomTreeListControl.SetOnEditing(Value: TcxTreeListEditingEvent);
begin
  inherited OnEditing := TcxecEditingEvent(Value);
end;

procedure TcxCustomTreeListControl.SetOnEditValueChanged(
  Value: TcxTreeListColumnChangedEvent);
begin
  inherited OnEditValueChanged := TcxecItemEvent(Value);
end;

procedure TcxCustomTreeListControl.SetOnSummary(Value: TcxSummaryEvent);
begin
  DataController.Summary.FooterSummaryItems.OnSummary := Value;
end;

procedure TcxCustomTreeListControl.SetOptionsBehavior(
  Value: TcxTreeListOptionsBehavior);
begin
  inherited OptionsBehavior := Value; 
end;

procedure TcxCustomTreeListControl.SetOptionsCustomizing(
  Value: TcxTreeListOptionsCustomizing);
begin
  FOptionsCustomizing.Assign(Value);
end;

procedure TcxCustomTreeListControl.SetOptionsData(Value: TcxTreeListOptionsData);
begin
  inherited OptionsData := Value;
end;

procedure TcxCustomTreeListControl.SetOptionsView(Value: TcxTreeListOptionsView);
begin
  inherited OptionsView := Value;
end;

procedure TcxCustomTreeListControl.SetOptionsSelection(
  Value: TcxTreeListOptionsSelection);
begin
  FOptionsSelection.Assign(Value);
end;

procedure TcxCustomTreeListControl.SetPreview(Value: TcxTreeListPreview);
begin
  FPreview.Assign(Value);
end;

procedure TcxCustomTreeListControl.SetSearchingText(const Value: string);
begin
  if Value = '' then
    CancelSearching
  else
    Controller.IncSearchingText := Value
end;

procedure TcxCustomTreeListControl.SetSorted(Value: Boolean);
var
  I: Integer;
begin
  if not Value then
  begin
    for I := 0 to ColumnCount - 1 do
      Columns[I].SortOrder := soNone;
  end;
end;

procedure TcxCustomTreeListControl.SetStateImages(Value: TCustomImageList);
begin
  SetInternalImageList(Value, FStateImages, FChangeStateImagesLink);
end;

procedure TcxCustomTreeListControl.SetStyles(Value: TcxTreeListStyles);
begin
  Styles.Assign(Value);
end;

procedure TcxCustomTreeListControl.SetTopVisibleIndex(AValue: Integer);
begin
  if IsLocked then
  begin
    Nodes.TopIndex := AValue;
    Nodes.TopNode := Nodes.GetVisibleNode(AValue);
    ViewInfo.DoCalculate;
  end
  else
    if cxValidateIntDefEx(AValue, TopVisibleIndex, 0, Nodes.VisibleCount - 1) then
      ViewInfo.DoScrollVertical(AValue - TopVisibleIndex);
end;

procedure TcxCustomTreeListControl.SetTopVisibleNode(ANode: TcxTreeListNode);
begin
  Nodes.CalculateInfo(False);
  if (ANode <> nil) and ANode.IsVisible then
    SetTopVisibleIndex(ANode.VisibleIndex);
end;

procedure TcxCustomTreeListControl.SetVisibleBand(
  Index: Integer; AValue: TcxTreeListBand);
begin
  VisibleBands[Index].Assign(AValue);
end;

procedure TcxCustomTreeListControl.SetVisibleColumn(
  Index: Integer; AValue: TcxTreeListColumn);
begin
  TcxTreeListColumn(FColumnsVisibleList[Index]).Assign(AValue);
end;

procedure TcxCustomTreeListControl.DoChangedTimer(Sender: TObject);
begin
  if not IsDestroying and not IsLoading then
    DoChanged(False);
end;

procedure TcxCustomTreeListControl.UpdateDesignerForms;
var
  AIntf: IcxTreeListDesigner;
  I: Integer;
begin
  if not FNeedUpdateDesigners then Exit;
  for I := 0 to Designers.Count - 1 do
    if Supports(TObject(Designers[I]), IcxTreeListDesigner, AIntf) then
    begin
      if IsDestroying then
        AIntf.ComponentRemoved(Self)
      else
        AIntf.Modified;
    end;
  FNeedUpdateDesigners := False;
end;

function TcxCustomTreeListControl.GetObjectName: string;
begin
  Result := GetStoredObjectName;
end;

function TcxCustomTreeListControl.GetProperties(AProperties: TStrings): Boolean;
begin
 Result := GetStoredObjectProperties(AProperties);
end;

procedure TcxCustomTreeListControl.GetPropertyValue(
  const AName: string; var AValue: Variant);
begin
  GetStoredPropertyValue(AName, AValue);
end;

procedure TcxCustomTreeListControl.SetPropertyValue(
  const AName: string; const AValue: Variant);
begin
  SetStoredPropertyValue(AName, AValue);
end;

procedure TcxCustomTreeListControl.CMDrag(var Message: TCMDrag);
const
  AcceptedCursors: array[Boolean] of TCursor = (crDrag, crDragCopy);
begin
  DragCursor := AcceptedCursors[Controller.IsDragCopy];
  inherited;
end;

{ TcxTreeList }

destructor TcxTreeList.Destroy;
begin
  inherited Destroy;
end;

function TcxTreeList.Add: TcxTreeListNode;
begin
  Result := Add(nil);
end;

function TcxTreeList.Add(ASibling: TcxTreeListNode;
  AData: Pointer = nil): TcxTreeListNode;
begin
  if ASibling <> nil then
    ASibling := ASibling.Parent;
  Result := AddNode(nil, ASibling, AData, tlamAdd);
end;

function TcxTreeList.AddChild(AParent: TcxTreeListNode;
  AData: Pointer = nil): TcxTreeListNode;
begin
  Result := AddNode(nil, AParent, AData, tlamAddChild);
end;

function TcxTreeList.AddChildFirst(AParent: TcxTreeListNode;
  AData: Pointer = nil): TcxTreeListNode;
begin
  Result := AddNode(nil, AParent, AData, tlamAddChildFirst);
end;

function TcxTreeList.AddFirst: TcxTreeListNode;
begin
  Result := AddFirst(nil);
end;

function TcxTreeList.AddFirst(ASibling: TcxTreeListNode; // need test???
  AData: Pointer = nil): TcxTreeListNode;
begin
  if ASibling <> nil then
    ASibling := ASibling.Parent;
  Result := AddNode(nil, ASibling, AData, tlamAddFirst);
end;

function TcxTreeList.AddNode(ANode, ARelative: TcxTreeListNode;
  AData: Pointer; AttachMode: TcxTreeListNodeAttachMode): TcxTreeListNode;
begin
  Result := inherited AddNode(ANode, ARelative, AData, AttachMode);
end;

function TcxTreeList.Insert(ASibling: TcxTreeListNode;
  AData: Pointer = nil): TcxTreeListNode;
begin
  Result := AddNode(nil, ASibling, AData, tlamInsert);
end;

function TcxTreeList.InsertEx(ANode, ASibling: TcxTreeListNode;
  AData: Pointer = nil): TcxTreeListNode;
begin
  Result := AddNode(ANode, ASibling, AData, tlamInsert);
end;

procedure TcxTreeList.LoadFromFile(const AFileName: string);
var
  AFileStream: TFileStream;
begin
  AFileStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyNone);
  try
    LoadFromStream(AFileStream);
  finally
    FreeAndNil(AFileStream);
  end;
end;

procedure TcxTreeList.LoadFromStream(AStream: TStream);
begin
  SetGlassCursor;
  try
    ReadData(AStream);
  finally
    RestoreCursor;
  end;
end;

procedure TcxTreeList.SaveToFile(const AFileName: string);
var
  AFileStream: TFileStream;
begin
  AFileStream := TFileStream.Create(AFileName, fmCreate);
  try
    SaveToStream(AFileStream);
  finally
    FreeAndNil(AFileStream);
  end;
end;

procedure TcxTreeList.SaveToStream(AStream: TStream);
var
  ASignature: TcxTreeListDataSignature;
begin
  AStream.WriteBuffer(ASignature, SizeOf(ASignature));
  DataController.SaveToStream(AStream);
  WriteData(AStream);
end;

procedure TcxTreeList.DoAssignNodes(Source: TcxTreeListNodes);
var
  AStream: TMemoryStream;
begin
  if Source.TreeList is TcxTreeList then
  begin
    AStream := TMemoryStream.Create;
    try
      TcxTreeList(Source.TreeList).SaveToStream(AStream);
      AStream.Position := 0;
      LoadFromStream(AStream);
    finally
      FreeAndNil(AStream);
    end;
  end;
end;

procedure TcxTreeList.DoSetNodeImageIndex(ANode: TcxTreeListNode;
  AIndex: TcxTreeListImageIndexType; Value: TImageIndex);
begin
  if ANode = nil then Exit; 
  TcxUnboundTreeListNode(ANode).FImageIndexes[AIndex] := Value;
  if not LockChanges then DoNodeChanged(ANode);
end;

procedure TcxTreeList.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('Data', ReadBinaryData, SaveToStream, Nodes.Count > 0);
end;

procedure TcxTreeList.Loaded;
begin
  if FLoadingTemporaryStream <> nil then
  begin
    LoadFromStream(FLoadingTemporaryStream);
    FreeAndNil(FLoadingTemporaryStream);
  end;
  inherited Loaded;
  if (TopVisibleNode <> nil) and (FocusedNode = nil) then
    TopVisibleNode.Focused := True;
end;

function TcxTreeList.SupportsBandColumnEditor: Boolean;
begin
  Result := True;
end;

function TcxTreeList.SupportsItemsEditor: Boolean;
begin
  Result := True;
end;

procedure TcxTreeList.ReadData(AStream: TStream);

  procedure DoReadNodesData;
  var
    AIndex: Integer;
    ANewNode, ANode, ARoot: TcxTreeListNode;
  begin
    ARoot := Nodes.Root;
    ANode := ARoot;
    AStream.ReadBuffer(ARoot.FCount, SizeOf(Integer));
    if ARoot.FCount = 0 then Exit;
    AIndex := 0;
    repeat
      ANewNode := ExCreateNode(ANode, ANode.FLast, AIndex);
      ANewNode.ReadData(AStream);
      NodesList.List^[ANewNode.RecordIndex] := ANewNode; 
      if ANewNode.FCount > 0 then
      begin
        ANode := ANewNode;
        AIndex := 0;
        Continue;
      end
      else
        while ANewNode.FParent <> nil do
        begin
          ANode := ANewNode.FParent;
          AIndex := ANode.FLast.FIndex + 1;
          if AIndex < ANode.Count then
            Break
          else
            ANewNode := ANode;
        end;
    until (ANode = ARoot) and (AIndex = ANode.Count);
  end;

begin
  inherited ReadData(AStream);
  BeginUpdate;
  try
    Nodes.Clear;
    Nodes.IsInternalCreating := True;
    Nodes.IsInvalidState := True;
    try
      DataController.LoadFromStream(AStream);
      NodesList.Count := DataController.RecordCount;
      DoReadNodesData;
    except
      Nodes.Clear;
      raise;
    end;
  finally
    Nodes.IsInternalCreating := False;
    EndUpdate;
  end;
end;

procedure TcxTreeList.ReadBinaryData(AStream: TStream);
var
  ASignature: TcxTreeListDataSignature;
begin
  AStream.ReadBuffer(ASignature, SizeOf(ASignature));
  with ASignature do
    if {(Version and cxTreeListVersion = 0) or} (Size <> AStream.Size) then
      cxTreeListError(scxStr(@scxInvalidStreamFormat));
  if FLoadingTemporaryStream = nil then
    FLoadingTemporaryStream := TMemoryStream.Create;
  AStream.Position := 0;
  FLoadingTemporaryStream.CopyFrom(AStream, ASignature.Size);
  FLoadingTemporaryStream.Position := 0;
end;

procedure TcxTreeList.WriteData(AStream: TStream);

  procedure DoWriteNodesData;
  var
    ANode, ARoot: TcxTreeListNode;
  begin
    ARoot := Nodes.Root;
    ANode := ARoot.GetFirstChild;
    AStream.WriteBuffer(Nodes.Root.FCount, SizeOf(Integer));
    while ANode <> nil do
    begin
      ANode.WriteData(AStream);
      if ANode.FCount > 0 then
        ANode := ANode.GetFirstChild
      else
      begin
        while (ANode <> nil)and (ANode.FNext = nil)do ANode := ANode.FParent;
        if ANode <> nil then ANode := ANode.FNext;
      end;
    end;
  end;

begin
  DoWriteNodesData;
  inherited WriteData(AStream);
end;

function TcxTreeList.ExCreateNode(AParent, APrev: TcxTreeListNode;
  var AIndex: Integer): TcxTreeListNode;
begin
  Result := DoCreateNode;
  Result.FParent := AParent;
  if APrev <> nil then
    APrev.FNext := Result
  else
    AParent.FFirst := Result;
  Result.FIndex := AIndex;
  Result.FPrev := APrev;
  AParent.FLast := Result;
  Inc(AIndex);
end;

initialization
  SortingManager := TSortingManager.Create;
  Classes.RegisterClass(TcxTreeListStyleSheet);

finalization
  FreeAndNil(SortingManager);
  Classes.UnRegisterClass(TcxTreeListStyleSheet);

end.

