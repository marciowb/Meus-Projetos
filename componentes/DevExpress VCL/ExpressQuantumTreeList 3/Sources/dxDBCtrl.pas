
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressDBTreeListControl                                    }
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

unit dxDBCtrl;

interface

{$I dxTLVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, dxTL, Mask, dxTLStr, dxCntner, dxEditor, dxExEdtr, dxGrFCmn, dxDBEdtr
  {$IFDEF DELPHI6}, Variants, MaskUtils, FMTBcd{$ENDIF};

const
  dxDBGridIndicatorWidth = 12;

type
  TdxDBTreeListColumn = class;
  TdxDBTreeListControlNode = class;
  TCustomdxDBTreeListControl = class;
  TdxDBTreeListControlDataLink = class;
  TdxDBGridSummaryItems = class;
  TdxDBGridSummaryGroup = class;
  TdxDBGridSummaryGroups = class;

  { TdxDBTreeListColumn }
  TdxSummaryType = (cstNone, cstSum, cstMin, cstMax, cstCount, cstAvg);

  TdxSummaryEvent = procedure(Sender: TObject; DataSet: TDataSet; var Value: Extended) of object;
  TColumnGetText = procedure(Sender: TObject; ANode: TdxTreeListNode; var AText: string) of object;
  // obsolete events
  TCustomDrawEvent = procedure(Sender: TObject; ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
    AColumn: TdxDBTreeListColumn; const AText: string; AFont: TFont; var AColor: TColor;
    ASelected, AFocused: Boolean; var ADone: Boolean ) of object;
  TCustomDrawHeaderEvent = procedure(Sender: TObject; ACanvas: TCanvas;
     var ARect: TRect; AColumn: TdxDBTreeListColumn; var ADone: Boolean) of object;
  TdxDrawSummaryFooter = procedure(Sender: TObject; ACanvas: TCanvas; ARect: TRect;
     var AText: string; var AAlignment: TAlignment; AFont: TFont; var AColor: TColor; var ADone: Boolean) of object;

  TdxDBTreeListColumn = class(TdxTreeListColumn)
  private
    FDisableGrouping: Boolean;
    FFieldName: string;
    // summary
    FSummaryType: TdxSummaryType;
    FSummaryFormat: string;
    FOnSummary: TdxSummaryEvent;
    FOnGetText: TColumnGetText;
    FSortBySummary: Boolean;
    FSummaryGroupName: string;
    // footer
    FSummaryFooterType: TdxSummaryType;
    FSummaryFooterFormat: string;
    FOnSummaryFooter: TdxSummaryEvent;
    // obsolete
    FOnCustomDraw: TCustomDrawEvent;
    FOnCustomDrawHeader: TCustomDrawHeaderEvent;
    FOnDrawSummaryFooter: TdxDrawSummaryFooter;

    function GetDBTreeList: TCustomdxDBTreeListControl;
    function GetField: TField;
    procedure SetDBTreeList(Value: TCustomdxDBTreeListControl);
    procedure SetDisableGrouping(Value: Boolean);
    procedure SetFieldName(const Value: string); virtual;
    procedure SetGroupIndex(Value: Integer);
    // summary
    function GetSortBySummary: Boolean;
    procedure SetSortBySummary(Value: Boolean);
    procedure SetSummaryType(Value: TdxSummaryType);
    procedure SetSummaryFooterType(Value: TdxSummaryType);
  protected
    FField: TField;
    FGroupIndex: Integer;
    FSmrField: TField;
    FSummaryGroup: TdxDBGridSummaryGroup;
    FSmrFooterField: TField;
    FSummaryFooterValue: Extended;
    FAssignedSummaryFooter: Boolean;
    FSummaryFooterField: string;
    FSummaryField: string;
    function AlwaysStoredValue: Boolean; virtual;
    function AssignedDrawCellEvent: Boolean; override;
    function AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    procedure AssignNodeValues(ANode: TdxDBTreeListControlNode); virtual;
    procedure ChangedReload(AllItems: Boolean);
    procedure DoDrawCell(ACanvas: TCanvas; var ARect: TRect; ANode: TdxTreeListNode;
      ASelected, AFocused: Boolean; ANewItemRow: Boolean; ALeftEdge, ARightEdge: Boolean; ABrush: HBRUSH;
      var AText: string; var AColor: TColor; AFont: TFont; var AAlignment: TAlignment; var ADone: Boolean); override;
  //  function GetDisplayText: string; virtual;
    function GetDisplayText(ANode: TdxTreeListNode): string; override;
    function GetFilterEdit(AOwner: TComponent): TdxInplaceEdit; virtual;
    function GetFilterEditClass: TdxInplaceEditClass; virtual;
    procedure GetFilterEditValues(AEdit: TdxInplaceEdit; var V: Variant; var S: string); virtual;
    procedure SetFilterEditValue(AEdit: TdxInplaceEdit; const V: Variant); virtual;
    function GetFilterOperators: TdxDBGridOperatorTypes; virtual;
    function GetFilterValue(ANode: TdxTreeListNode{; Index: ?}): Variant; virtual;
    procedure GetFilterValues(ANode: TdxTreeListNode; var V: Variant; var S: string); virtual;
    function GetGroupText(const Value: string): string; virtual;
    function GetSummaryFooterText: string; virtual;
    function GetText(const Value: Variant): string; virtual;
    function GetVariantType: Integer; virtual; // override in Lookup columns !!! (for QuickSort)
    function InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    function IsBlobColumn: Boolean; virtual;
    function IsEqualValues(const Value: Variant): Boolean; virtual;
    procedure PrepareFilterEdit(AEdit: TdxInplaceEdit); virtual;
    procedure SetIndex(Value: Integer); override;
    procedure SetName(const Value: TComponentName); override;

    property GroupIndex: Integer read FGroupIndex write SetGroupIndex default -1;
    property SortBySummary: Boolean read GetSortBySummary write SetSortBySummary default False;
    property SummaryType: TdxSummaryType read FSummaryType write SetSummaryType default cstNone;
    property SummaryField: string read FSummaryField write FSummaryField;
    property SummaryFormat: string read FSummaryFormat write FSummaryFormat;
    property OnSummary: TdxSummaryEvent read FOnSummary write FOnSummary;
    property SummaryGroupName: string read FSummaryGroupName write FSummaryGroupName;
    property SummaryGroup: TdxDBGridSummaryGroup read FSummaryGroup;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function DefaultAlignment: TAlignment; override;
    function DefaultCaption: string; override;
    function DefaultMaxLength: Integer; override;
    function DefaultReadOnly: Boolean; override;
    function DefaultWidth: Integer; override;
    function IsValidChar(InputChar: Char): Boolean; virtual;
    procedure RestoreDefaults; override;

    property ATreeList: TCustomdxDBTreeListControl read GetDBTreeList write SetDBTreeList;
    property Field: TField read GetField;
    property SummaryFooterText: string read GetSummaryFooterText;
    property SummaryFooterValue: Extended read FSummaryFooterValue;
    property VariantType: Integer read GetVariantType;
  published
    property DisableGrouping: Boolean read FDisableGrouping write SetDisableGrouping default False;
    property FieldName: string read FFieldName write SetFieldName;
    property OnGetText: TColumnGetText read FOnGetText write FOnGetText;
    // obsolete
    property OnCustomDraw: TCustomDrawEvent read FOnCustomDraw write FOnCustomDraw;
    property OnCustomDrawHeader: TCustomDrawHeaderEvent read FOnCustomDrawHeader write FOnCustomDrawHeader;
    // summary
    property SummaryFooterType: TdxSummaryType read FSummaryFooterType write SetSummaryFooterType default cstNone;
    property SummaryFooterField: string read FSummaryFooterField write FSummaryFooterField;
    property SummaryFooterFormat: string read FSummaryFooterFormat write FSummaryFooterFormat;
    property OnSummaryFooter: TdxSummaryEvent read FOnSummaryFooter write FOnSummaryFooter;
    property OnDrawSummaryFooter: TdxDrawSummaryFooter read FOnDrawSummaryFooter write FOnDrawSummaryFooter;
  end;

  TdxDBTreeListColumnClass = class of TdxDBTreeListColumn;

  TdxGetEditColor = procedure(Sender: TObject; ANode: TdxTreeListNode;
    AColumn: TdxDBTreeListColumn; var AColor: TColor) of object;

  {TdxDBTreeListControlNode}
  TNodeAssignedData = (nadValue,         // if field in SimpleFields = [ftSmallint, ...]
                       nadLookupValue);  // if field kind = fkLookup
  TNodeAssignedValues = set of TNodeAssignedData;

  PNodeVariantData = ^TNodeVariantData;
  TNodeVariantData = record
    AssignedValues: TNodeAssignedValues;
    Value: Variant;                   { field value }
    LookupValue: Variant;             { for lookup field (KeyValue)}
  end;

  TdxDBTreeListControlNode = class(TdxTreeListTextNode)
  private
    FId: Variant;                     { Primary Key }
    function GetVariantValue(Column: Integer): Variant;
  protected
    FDescription: string;
    function GetVariantData(Column: Integer): TNodeVariantData;
    procedure SetVariantData(Column: Integer; const Value: TNodeVariantData);
  public
    destructor Destroy; override;
    procedure Delete; virtual;
    property Id: Variant read FId write FId;
    property Description: string read FDescription;
    property VariantData[Column: Integer]: TNodeVariantData read GetVariantData write SetVariantData;
    property VariantValues[Index: Integer]: Variant read GetVariantValue;
  end;

  TdxGetPreviewTextEvent = procedure(Sender: TObject; Node: TdxTreeListNode; var Text: string) of object;

  { TCustomdxDBTreeListControl }
  TCustomdxDBTreeListControl = class(TCustomdxTreeListControl)
  private
    // Selection
    FBkmList: TStringList;
    FBkmCache: TBookmarkStr;
    FBkmCacheFind: Boolean;
    FBkmCacheIndex: Integer;
    // Common
    FInternalDestroying: Boolean;
    FKeyFieldName: string;
    FLockRefresh: Boolean;
    FNodeLink: TList;
    FPreviewFieldName: string;
    FPreviewMaxLength: Integer;
    // Style
    FIndicatorWidth: Integer;
    FOnGetEditColor: TdxGetEditColor;
    FOnChangeNodeEx: TNotifyEvent;
    FOnRefreshNodeData: TTLExpandedEvent;
    FOnBeforeCalcSummary: TNotifyEvent;
    FOnCalcSummary: TNotifyEvent;
    FOnGetPreviewText: TdxGetPreviewTextEvent;
    procedure BkmStringsChanged(Sender: TObject);
    function GetColumn(Index: Integer): TdxDBTreeListColumn;
    function GetFocusedField: TField;
    function GetSortedColumn: TdxDBTreeListColumn;
    function GetSortedColumns(Index: Integer): TdxDBTreeListColumn;
    function GetVisibleColumn(Index: Integer): TdxDBTreeListColumn;
    procedure SetColumn(Index: Integer; Value: TdxDBTreeListColumn);
    procedure SetFocusedField(Value: TField);
    procedure SetIndicatorWidth(Value: Integer);
    procedure SetKeyFieldName(const Value: string);
    procedure SetPreviewFieldName(const Value: string);
    procedure SetPreviewMaxLength(Value: Integer);
    procedure SetVisibleColumn(Index: Integer; Value: TdxDBTreeListColumn);
    procedure WMHScroll(var Message: TWMHScroll); message WM_HSCROLL;
    procedure CMExit(var Message: TMessage); message CM_EXIT;
  protected
    FEditValue: Variant; // for InvalidateEditor
    FInKeyDown: Boolean; // Temporal 
    FKeyField: TField;
    FLoaded: Boolean;
    FPreviewField: TField;
    function AssignedDrawCellEvent(ANode: TdxTreeListNode; AbsoluteIndex: Integer): Boolean; override;
    function AssignedDrawFooterCellEvent(ANode: TdxTreeListNode; AbsoluteIndex, FooterIndex: Integer{Column Index}): Boolean; override;
    procedure DoDrawFooterCell(ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode; AIndex, AFooterIndex: Integer; var AText: string;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment; var ADone: Boolean); override;
    procedure DoDrawHeader(AbsoluteIndex: Integer; ACanvas: TCanvas; ARect, AClipRect: TRect; var AText: string;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment; var ASorted: TdxTreeListColumnSort; var ADone: Boolean); override;
    function GetEditColor: TColor; override;
    // TComponent
    procedure SetName(const Value: TComponentName); override;
    procedure DoStartDrag(var DragObject: TDragObject); override;
    // based
    function GetDataLink: TdxDBTreeListControlDataLink; virtual; abstract;
    function GetDataSource: TDataSource; virtual; abstract;
    function GetDefaultFields: Boolean; virtual; abstract;
    function IsCancelOnExit: Boolean; virtual;
    function IsCanInsert: Boolean; virtual; abstract;
    function IsCanNavigation: Boolean; virtual; abstract;
    function IsEasySelect: Boolean; virtual;
    function IsExistFooterCell(AbsoluteIndex: Integer): Boolean; override;
    function IsKeyFieldEmpty: Boolean; virtual; abstract;
    function IsLoadedAll: Boolean; virtual; abstract;
    function IsUseBookmarks: Boolean; virtual; abstract;
    procedure SetDataChangedBusy(Value: Boolean); virtual; abstract;
    // Editor
    function AssignEditValue(ANode: TdxTreeListNode; AColumn: Integer; AInplaceEdit: TdxInplaceEdit): Variant; override;
    function CanEditAcceptKey(Key: Char): Boolean; override;
    function CanEditModify: Boolean; override;
    function CanEditShow: Boolean; override;
    procedure DoBeforeEditing(Node: TdxTreeListNode; var AllowEditing: Boolean); override;
    procedure DoBeforeEditNewItemRow(var Allow: Boolean); override;
    procedure DoBeginNewItemActive; override;
    function InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    procedure InvalidateEditorValue; virtual;

    procedure DataChanged; virtual;
    function IsDataSetBusy: Boolean; virtual;
    procedure LinkActive(Value: Boolean); virtual;
    procedure RecordChanged(Field: TField); virtual;
    procedure Scroll(Distance: Integer); virtual;
    procedure UpdateData; virtual;
    // RecordChanged
    procedure NodeRecordChanged(Field: TField; var Node: TdxDBTreeListControlNode);
    procedure RefreshNodeValues(var Node: TdxDBTreeListControlNode); virtual;
    // Grouping
    procedure ChangedGroupColumn(Column: TdxDBTreeListColumn); virtual;
    procedure SetGroupIndex(AColumn: TdxDBTreeListColumn; AIndex: Integer); virtual;
    // Summary
    procedure AssignSummaryFields; virtual;
    procedure AssignSummaryFooterFields; virtual;
    procedure DoBeforeCalcSummary; virtual;
    procedure DoRefreshNodeData(Node: TdxTreeListNode); virtual;
    function GetSummaryValue(ANode: TdxTreeListNode): Extended; virtual;
    procedure RefreshSummaryItems(const PrevName, NewName: string); virtual;
    // Sorted
    procedure CheckSortedColumns;
    // override TL control
    function GetIndicatorWidth: Integer; override;
    function GetRowIndicatorKind(Node: TdxTreeListNode; ASelected: Boolean): TdxGridIndicatorKind; override;
    // Navigation
    procedure ResyncSelection;
    // Selected
    function CompareBkm(const Item1, Item2: TBookmarkStr): Integer;
    function FindBkm(const Item: TBookmarkStr; var Index: Integer): Boolean;
    function FindSelectedNode(Node: TdxTreeListNode; var Index: Integer): Boolean;
    function GetSelectedCount: Integer; override;
    function GetSelectedItem(AIndex: Integer): TdxTreeListNode; override;
    function GetSelectedRow(Index: Integer): TBookmarkStr;
    procedure SelectNodes(N1, N2: TdxTreeListNode); override;
    // Sorting
    function CompareEqual(Node1, Node2: TdxTreeListNode): Integer; override;
    function IsDragScroll: Boolean; override;
    procedure PrepareColumnSorted(Column: TdxTreeListColumn); override;
    // Loading Data
    procedure AssignNodeValues(ANode: TdxDBTreeListControlNode; AColumn: TdxDBTreeListColumn); virtual;
    procedure AssignNodeAllValues(Node: TdxDBTreeListControlNode); virtual;
    function GetPreviewString(const S: string): string;
    function GetColumnVariantData(ANode: TdxDBTreeListControlNode; AColumn: TdxDBTreeListColumn): Variant;
    function GetNodeVarData(ANode: TdxDBTreeListControlNode; AColumn: TdxDBTreeListColumn): Extended;
    // Style
    function AcquireFocus: Boolean; override;
    procedure BeginCustomLayout; override;
    // Search
    function FindNodeByText(AColumnIndex: Integer; const AText: string;
      ADirection: TdxTreeListSearchDirection; var ANode: TdxTreeListNode): Boolean; override;

    // based
    procedure AddNodeLink(ANode: Pointer);
    procedure AssignPreviewField;
    function CreateDefaultColumn(ColumnClass: TdxDBTreeListColumnClass): TdxDBTreeListColumn; virtual;
    procedure DefineFieldMap; virtual;
    function ValidateNode(ANode : Pointer) : Boolean;

    // based override
    procedure DeleteNode(Node, Prior, Next: TdxTreeListNode; IsLast, Redraw: Boolean); override;
    procedure DeleteStrings(Node: TdxTreeListNode; Index: Integer); override;
    procedure DoChangeNodeEx; virtual;
    function GetNewItemCellText(AbsoluteIndex: Integer): string; override;
    function GetReadOnly: Boolean; override;
    function IsDisableEditing: Boolean; virtual;
    function IsNewItemRowEditing: Boolean; override;
    function MakeFocused(Node: TdxTreeListNode): Boolean; override;

    property BkmList: TStringList read FBkmList;
    property FocusedField: TField read GetFocusedField write SetFocusedField;
    property GrIndicatorWidth: Integer read GetIndicatorWidth write SetIndicatorWidth default dxDBGridIndicatorWidth;
    property KeyField: string read FKeyFieldName write SetKeyFieldName;
    property LockRefresh: Boolean read FLockRefresh write FLockRefresh;
    property NodeLinkList: TList read FNodeLink;
    property PreviewFieldName: string read FPreviewFieldName write SetPreviewFieldName;
    property PreviewMaxLength: Integer read FPreviewMaxLength write SetPreviewMaxLength default 0;
    property SelectedRows[Index: Integer]: TBookmarkStr read GetSelectedRow;
    property OnChangeNodeEx: TNotifyEvent read FOnChangeNodeEx write FOnChangeNodeEx;
    property OnRefreshNodeData: TTLExpandedEvent read FOnRefreshNodeData write FOnRefreshNodeData;
    property OnBeforeCalcSummary: TNotifyEvent read FOnBeforeCalcSummary write FOnBeforeCalcSummary;
    property OnCalcSummary: TNotifyEvent read FOnCalcSummary write FOnCalcSummary;
    property OnGetPreviewText: TdxGetPreviewTextEvent read FOnGetPreviewText write FOnGetPreviewText;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    procedure ClearColumnsSorted; override;
    procedure ClearGroupColumns; virtual;
    procedure ClearSelection; override;
    function ColumnByFieldName(const FieldName: string): TdxDBTreeListColumn;
    function ColumnByName(const AName: string): TdxDBTreeListColumn;
    function CreateColumn(ColumnClass: TdxDBTreeListColumnClass): TdxDBTreeListColumn;
    function CreateColumnEx(ColumnClass: TdxDBTreeListColumnClass; AOwner: TComponent): TdxDBTreeListColumn; virtual;
    procedure CreateDefaultColumns(DataSet: TDataSet; AOwner: TComponent); virtual;
    procedure DestroyColumns; override;
    function FindColumnByFieldName(const FieldName: string): TdxDBTreeListColumn;
    procedure FullRefresh; virtual;
    function GetColumnAt(X, Y: Integer): TdxDBTreeListColumn;
    class function GetDefaultColumnClass: TdxDBTreeListColumnClass; virtual;
    class function GetDefaultFieldColumnClass(AField: TField): TdxDBTreeListColumnClass; virtual;
    function GetFooterColumnAt(X, Y: Integer): TdxDBTreeListColumn;
    function GetHeaderColumnAt(X, Y: Integer): TdxDBTreeListColumn;
    function RefreshBookmarks: Boolean;
    {$IFDEF DELPHI4}
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    {$ENDIF}
    property Columns[Index: Integer]: TdxDBTreeListColumn read GetColumn write SetColumn;
    property VisibleColumns[Index: Integer]: TdxDBTreeListColumn read GetVisibleColumn write SetVisibleColumn;
    property DataLink: TdxDBTreeListControlDataLink read GetDataLink;
    property DataSource: TDataSource read GetDataSource;
    property SortedColumn: TdxDBTreeListColumn read GetSortedColumn;
    property SortedColumns[Index: Integer]: TdxDBTreeListColumn read GetSortedColumns;
    property OnGetEditColor: TdxGetEditColor read FOnGetEditColor write FOnGetEditColor;
  end;

  { TdxDBGridSummaryItem }
  TdxDBGridSummaryItem = class(TCollectionItem)
  private
    FColumnName: string;
    FSmrField: TField;
    FSummaryType: TdxSummaryType;
    FSummaryField: string;
    FSummaryFormat: string;
    FOnSummary: TdxSummaryEvent;
    procedure SetColumnName(const Value: string);
    procedure SetSummaryField(const Value: string);
    procedure SetSummaryFormat(const Value: string);
    procedure SetSummaryType(Value: TdxSummaryType);
  public
    procedure Assign(Source: TPersistent); override;
    function GetSummaryItems: TdxDBGridSummaryItems;
    property SmrField: TField read FSmrField write FSmrField;
  published
    property ColumnName: string read FColumnName write SetColumnName;
    property SummaryField: string read FSummaryField write SetSummaryField;
    property SummaryFormat: string read FSummaryFormat write SetSummaryFormat;
    property SummaryType: TdxSummaryType read FSummaryType write SetSummaryType default cstNone;
    property OnSummary: TdxSummaryEvent read FOnSummary write FOnSummary;
  end;

  TdxDBGridSummaryItemClass = class of TdxDBGridSummaryItem;

  { TdxDBGridSummaryItems }
  TdxDBGridSummaryItems = class(TCollection)
  private
    FSummaryGroup: TdxDBGridSummaryGroup;
    function GetItem(Index: Integer): TdxDBGridSummaryItem;
    procedure SetItem(Index: Integer; Value: TdxDBGridSummaryItem);
  protected
    function GetOwner: TPersistent; {$IFDEF DELPHI3} override;{$ENDIF}
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(ASummaryGroup: TdxDBGridSummaryGroup; ItemClass: TdxDBGridSummaryItemClass);
    function Add: TdxDBGridSummaryItem;
    property Items[Index: Integer]: TdxDBGridSummaryItem read GetItem write SetItem; default;
    property SummaryGroup: TdxDBGridSummaryGroup read FSummaryGroup;
  end;

  { TdxDBGridSummaryGroup }
  TdxDBGridSummaryGroup = class(TCollectionItem)
  private
    FBeginSummaryText: string;
    FEndSummaryText: string;
    FDefaultGroup: Boolean;
    FSummaryItems: TdxDBGridSummaryItems;
    FName: string;
    FOnChangeName: TNotifyEvent;
    function GetDefaultGroup: Boolean;
    procedure SetDefaultGroup(Value: Boolean);
    procedure SetSummaryItems(Value: TdxDBGridSummaryItems);
    procedure SetName(const Value: string);
  protected
    procedure ChangedGroup;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function GetSummaryGroups: TdxDBGridSummaryGroups;
    property OnChangeName: TNotifyEvent read FOnChangeName write FOnChangeName;
  published
    property BeginSummaryText: string read FBeginSummaryText write FBeginSummaryText;
    property EndSummaryText: string read FEndSummaryText write FEndSummaryText;
    property DefaultGroup: Boolean read GetDefaultGroup write SetDefaultGroup;
    property SummaryItems: TdxDBGridSummaryItems read FSummaryItems write SetSummaryItems;
    property Name: string read FName write SetName;
  end;

  TdxDBGridSummaryGroupClass = class of TdxDBGridSummaryGroup;

  { TdxDBGridSummaryGroups }
  TdxDBGridSummaryGroups = class(TCollection)
  private
    FDBTreeListControl: TCustomdxDBTreeListControl;
    function GetItem(Index: Integer): TdxDBGridSummaryGroup;
    procedure SetItem(Index: Integer; Value: TdxDBGridSummaryGroup);
  protected
    function GetOwner: TPersistent; {$IFDEF DELPHI3} override;{$ENDIF}
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(ADBTreeListControl: TCustomdxDBTreeListControl; ItemClass: TdxDBGridSummaryGroupClass);
    function Add: TdxDBGridSummaryGroup;
    function GetDefaultGroup: TdxDBGridSummaryGroup;
    property DBTreeListControl: TCustomdxDBTreeListControl read FDBTreeListControl;
    property Items[Index: Integer]: TdxDBGridSummaryGroup read GetItem write SetItem; default;
  end;

  { TdxDBTreeListControlDataLink }
  TdxDBTreeListControlDataLink = class(TDataLink)
  private
    FDBTreeListControl: TCustomdxDBTreeListControl;
    FFieldCount: Integer;
    FFieldMap: Pointer;
    FFieldMapSize: Integer;
    FModified: Boolean;
    function GetFields(I: Integer): TField;
  protected
    function  GetMappedIndex(ColIndex: Integer): Integer;
    // override TDataLink
    procedure ActiveChanged; override;
    procedure DataSetChanged; override;
    procedure DataSetScrolled(Distance: Integer); override;
    procedure RecordChanged(Field: TField); override;
    procedure UpdateData; override;
    property DBTreeListControl: TCustomdxDBTreeListControl read FDBTreeListControl;
  public
    constructor Create(ADBTreeListControl: TCustomdxDBTreeListControl);
    destructor Destroy; override;
    function AddMapping(const FieldName: string): Boolean;
    procedure ClearMapping;
    procedure Modified;
    procedure Reset;
    property FieldCount: Integer read FFieldCount;
    property Fields[I: Integer]: TField read GetFields;
    property IsModified: Boolean read FModified;
  end;

  { TdxInplaceDBTreeListMaskEdit }
  TdxInplaceDBTreeListMaskEdit = class(TdxInplaceMaskEdit)
  end;

  { TdxDBTreeListMaskColumn }
  TdxDBTreeListMaskColumn = class(TdxDBTreeListColumn)
  private
    FAssignedEditMask: Boolean;
    FEditMask: string;
    FIgnoreMaskBlank: Boolean;
  protected
    function AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    function GetdxInplaceEditClass: TdxInplaceEditClass; override;
    function GetEditMask: string;
    procedure InitEditProperties(AInplaceEdit: TdxInplaceEdit); override;
    function InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant; override;
    function IsEditMaskStored: Boolean;
    function IsEqualValues(const Value: Variant): Boolean; override;
    procedure SetEditMask(const Value: string);
  public
    procedure Assign(Source: TPersistent); override;
    function DefaultEditMask: string;
    function GetBlankText: string;
    procedure RestoreDefaults; override;
  published
    property EditMask: string read GetEditMask write SetEditMask stored IsEditMaskStored;
    property IgnoreMaskBlank: Boolean read FIgnoreMaskBlank write FIgnoreMaskBlank default False;
  end;

  { TCustomdxFilterEdit }
  TCustomdxFilterEdit = class(TdxInplaceMaskEdit)
  public
    class function IsInplace: Boolean; override;
  end;

  { TdxDBTreeListColumnClassInfo }
  TdxDBTreeListColumnClassInfo = record
    ColumnClass: TdxDBTreeListColumnClass;
    Version: Integer;
  end;

  TInitColumnClassProc = procedure(AFieldType: TFieldType; AFieldKind: TFieldKind;
    var Info: TdxDBTreeListColumnClassInfo);

function DataVarType(AFieldType: TFieldType): Integer;
procedure RegisterDBTreeListControl(ADBTreeListControl: TCustomdxDBTreeListControl);
procedure UnRegisterDBTreeListControl(ADBTreeListControl: TCustomdxDBTreeListControl);
function IsDBTreeListControlDataSetBusy(ADataSet: TDataSet): Boolean;

function CompareNodeId(Item1, Item2: Pointer): Integer;
function CompareParentNode(Item1, Item2: Pointer): Integer;
function CompareVariant(Item1, Item2: Pointer): Integer;
procedure DeleteRecurse(Node: TdxTreeListNode);
function GetSummaryString(ASummaryType: TdxSummaryType; const ASummaryFormat: string;
  AValue: Extended; ADataType: TFieldType; IsFooter: Boolean): string;

var
  sdxGrTitleConfirm: string;                 // 'Confirm';
  sdxGrDeleteRecordQuestion: string;         // 'Delete record?';
  sdxDeleteMultipleRecordsQuestion: string;  // 'Delete all selected records?';

const
  DefaultDBTreeListColumnType: array[ftUnknown..ftTypedBinary] of TdxDBTreeListColumnClassInfo = (
    (ColumnClass: nil; Version: 0),                        { ftUnknown }
    (ColumnClass: TdxDBTreeListColumn; Version: 0),        { ftString }
    (ColumnClass: TdxDBTreeListColumn; Version: 0),        { ftSmallint }
    (ColumnClass: TdxDBTreeListColumn; Version: 0),        { ftInteger }
    (ColumnClass: TdxDBTreeListColumn; Version: 0),        { ftWord }
    (ColumnClass: TdxDBTreeListColumn; Version: 0),        { ftBoolean }
    (ColumnClass: TdxDBTreeListColumn; Version: 0),        { ftFloat }
    (ColumnClass: TdxDBTreeListColumn; Version: 0),        { ftCurrency }
    (ColumnClass: TdxDBTreeListColumn; Version: 0),        { ftBCD }
    (ColumnClass: TdxDBTreeListColumn; Version: 0),        { ftDate }
    (ColumnClass: TdxDBTreeListColumn; Version: 0),        { ftTime }
    (ColumnClass: TdxDBTreeListColumn; Version: 0),        { ftDateTime }
    (ColumnClass: TdxDBTreeListColumn; Version: 0),        { ftBytes }
    (ColumnClass: TdxDBTreeListColumn; Version: 0),        { ftVarBytes }
    (ColumnClass: TdxDBTreeListColumn; Version: 0),        { ftAutoInc }
    (ColumnClass: TdxDBTreeListColumn; Version: 0),        { ftBlob }
    (ColumnClass: TdxDBTreeListColumn; Version: 0),        { ftMemo }
    (ColumnClass: TdxDBTreeListColumn; Version: 0),        { ftGraphic }
    (ColumnClass: TdxDBTreeListColumn; Version: 0),        { ftFmtMemo }
    (ColumnClass: TdxDBTreeListColumn; Version: 0),        { ftParadoxOle }
    (ColumnClass: TdxDBTreeListColumn; Version: 0),        { ftDBaseOle }
    (ColumnClass: TdxDBTreeListColumn; Version: 0));       { ftTypedBinary }
  DefaultDBTreeListLookupColumnType: TdxDBTreeListColumnClassInfo = (ColumnClass: TdxDBTreeListColumn; Version: 0);

procedure InitDefaultDBTreeListColumnClasses(Proc: TInitColumnClassProc);
procedure ResetDefaultDBTreeListColumnClasses;

implementation

{$IFNDEF DELPHI3}uses DBTables, BDE;{$ENDIF}

const
  MaxMapSize = (MaxInt div 2) div SizeOf(Integer);  { 250 million }
  // global list (DBGrid, DBTreeList)
  DBTreeListControls: TList = nil;
  SimpleFields = [ftSmallint, ftInteger, ftWord, ftBoolean, ftFloat, ftCurrency,
    ftBCD, ftDate, ftTime, ftDateTime, ftAutoInc
   {$IFDEF DELPHI6}, ftTimeStamp, ftFMTBcd, ftLargeInt{$ENDIF}];

type
  TIntArray = array[0..MaxMapSize] of Integer;
  PIntArray = ^TIntArray;

function DataVarType(AFieldType: TFieldType): Integer;
const
  varFieldType: array[TFieldType] of Integer = (
    varUnknown,        { ftUnknown }
    varString,         { ftString }
    varSmallint,       { ftSmallint }
    varInteger,        { ftInteger }
    varInteger,        { ftWord }
    varString,         { ftBoolean }
    varDouble,         { ftFloat }
    varCurrency,       { ftCurrency }
    varCurrency,       { ftBCD }
    varDate,           { ftDate }
    varDate,           { ftTime }
    varDate,           { ftDateTime }
    varString,         { ftBytes }
    varString,         { ftVarBytes }
    varInteger,        { ftAutoInc }
    varString,         { ftBlob }
    varString,         { ftMemo }
    varString,         { ftGraphic }
    varString,         { ftFmtMemo }
    varString,         { ftParadoxOle }
    varString,         { ftDBaseOle }
    varString,         { ftTypedBinary }
    varString          { ftCursor }
    {$IFDEF DELPHI4},
    varString,         { ftFixedChar }
    varString,         { ftWideString }
    {$IFDEF DELPHI6}varInt64{$ELSE}varString{$ENDIF},         { ftLargeint }
    varString,         { ftADT }
    varString,         { ftArray }
    varString,         { ftReference }
    varString          { ftDataSet }
      {$IFDEF DELPHI5},
    varString,         { ftOraBlob }
    varString,         { ftOraClob }
    varString,         { ftVariant }
    varString,         { ftInterface }
    varString,         { ftIDispatch }
    varString          { ftGuid }
        {$IFDEF DELPHI6},
    varDate,           { ftTimeStamp }
    varDouble          { ftFMTBcd }
        {$ENDIF}
      {$ENDIF}
    {$ENDIF}
  );
begin
  Result := varFieldType[AFieldType];
end;

procedure RegisterDBTreeListControl(ADBTreeListControl: TCustomdxDBTreeListControl);
begin
  if DBTreeListControls = nil then
    DBTreeListControls := TList.Create;
  DBTreeListControls.Add(ADBTreeListControl);
end;

procedure UnRegisterDBTreeListControl(ADBTreeListControl: TCustomdxDBTreeListControl);
begin
  if DBTreeListControls <> nil then
  begin
    DBTreeListControls.Remove(ADBTreeListControl);
    if DBTreeListControls.Count = 0 then
    begin
      DBTreeListControls.Free;
      DBTreeListControls := nil;
    end;
  end;
end;

function IsDBTreeListControlDataSetBusy(ADataSet: TDataSet): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to DBTreeListControls.Count - 1 do
    if (TCustomdxDBTreeListControl(DBTreeListControls[I]).Datalink.DataSet = ADataSet) and
      TCustomdxDBTreeListControl(DBTreeListControls[I]).IsDataSetBusy then
    begin
      Result := True;
      Break;
    end;
end;

function CompareNodeId(Item1, Item2: Pointer): Integer;
begin
  Result := VarCompare(TdxDBTreeListControlNode(Item1).Id, TdxDBTreeListControlNode(Item2).Id);
end;

function CompareParentNode(Item1, Item2: Pointer): Integer;
begin
  Result := TdxTreeListNode(Item1).Level - TdxTreeListNode(Item2).Level;
end;

function CompareVariant(Item1, Item2: Pointer): Integer;
begin
  Result := VarCompare(PVariant(Item1)^, PVariant(Item2)^);
end;

procedure DeleteRecurse(Node: TdxTreeListNode);
begin
  if (Node.Parent <> nil) and (Node.Parent.Count = 1) then
    DeleteRecurse(Node.Parent)
  else
    Node.Free;
end;

function GetSummaryString(ASummaryType: TdxSummaryType; const ASummaryFormat: string;
  AValue: Extended; ADataType: TFieldType; IsFooter: Boolean): string;
const
  stSummary: array[Boolean, cstSum..cstAvg] of string =
    (('(SUM=0.00);(SUM=-0.00)', '(MIN=0.00);(MIN=-0.00)', '(MAX=0.00);(MAX=-0.00)', '(COUNT=0)', '(AVG=0.00);(AVG=-0.00)'),
     ('0.00;-0.00', 'MIN=0.00;MIN=-0.00', 'MAX=0.00;MAX=-0.00', '0', 'AVG=0.00;AVG=-0.00'));
  stSummaryDateTime: array[Boolean, cstSum .. cstAvg] of string =
     (('(SUM=', '(MIN=', '(MAX=', '(COUNT=0)', '(AVG='),
      ('', 'MIN=', 'MAX=', '0', 'AVG='));
var
  F, F1: string;
begin
  Result := '';
  if ASummaryType <> cstNone then
  begin
    if ASummaryFormat = '' then
      F := stSummary[IsFooter, ASummaryType]
    else F := ASummaryFormat;
    if (ASummaryType <> cstCount) and (ADataType in [ftDate, ftTime, ftDateTime]) then
    begin
      if ASummaryFormat = '' then
      begin
        F := stSummaryDateTime[IsFooter, ASummaryType];
        if not IsFooter then F1 := ')'
        else F1 := '';
      end
      else F1 := '';
      case ADataType of
      ftDate: Result := F + DateToStr(AValue) + F1;
      ftTime: Result := F + TimeToStr(AValue) + F1;
      ftDateTime: Result := F + DateTimeToStr(AValue) + F1;
      end;
    end
    else
      Result := FormatFloat(F, AValue);
  end;
end;

{TdxDBTreeListColumn}
constructor TdxDBTreeListColumn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FGroupIndex := -1;
end;

destructor TdxDBTreeListColumn.Destroy;
begin
  if (ATreeList <> nil) and not (csDestroying in ATreeList.ComponentState) and
    (Self.GroupIndex <> -1) then ATreeList.SetGroupIndex(Self, -1);
  if ATreeList <> nil then
  begin
    if not (csDestroying in ATreeList.ComponentState) then
    begin
      ATreeList.RefreshSummaryItems(Name, '');
    end;
  end;
  inherited Destroy; // TreeList.RemoveColumn(Self);
end;

procedure TdxDBTreeListColumn.Assign(Source: TPersistent);
begin
  if Source is TdxDBTreeListColumn then
  begin
    if Assigned(ATreeList) then ATreeList.BeginUpdate;
    try
      inherited Assign(Source);                          
      DisableGrouping := TdxDBTreeListColumn(Source).DisableGrouping;
      FieldName := TdxDBTreeListColumn(Source).FieldName;
      SummaryGroupName := TdxDBTreeListColumn(Source).SummaryGroupName;
    finally
      if Assigned(ATreeList) then ATreeList.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TdxDBTreeListColumn.DefaultAlignment: TAlignment;
begin
  if Assigned(Field) then
    Result := FField.Alignment
  else Result := taLeftJustify;
end;

function TdxDBTreeListColumn.DefaultCaption: String;
begin
  if Assigned(Field) then
    Result := Field.DisplayName
  else Result := FieldName;
end;

function TdxDBTreeListColumn.DefaultMaxLength: Integer;
begin
  Result := 0;
  if Assigned(Field) and (Field.DataType in [ftString{$IFDEF DELPHI4}, ftWideString{$ENDIF}]) then
    Result := Field.Size;
end;

function TdxDBTreeListColumn.DefaultReadOnly: Boolean;
begin
  Result := False;
  if Assigned(Field) then Result := FField.ReadOnly;
end;

function TdxDBTreeListColumn.DefaultWidth: Integer;
var
  W: Integer;
  RestoreCanvas: Boolean;
  TM: TTextMetric;
begin
  Result := 64;
  if ATreeList = nil then Exit;
  with ATreeList do
  begin
    RestoreCanvas := not HandleAllocated;
    if RestoreCanvas then
      Canvas.Handle := GetDC(0);
    try
      Canvas.Font := ATreeList.HeaderFont;
      if Self.Caption <> '' then
        Result := Canvas.TextWidth(Self.Caption) + 4 + 1 + 1;
      if Assigned(Field) then
      begin
        if (cvFont in AssignedValues) then
          Canvas.Font := Self.Font
        else Canvas.Font := ATreeList.Font;
        GetTextMetrics(Canvas.Handle, TM);
        W := Field.DisplayWidth * (Canvas.TextWidth('0') - TM.tmOverhang)
           + TM.tmOverhang + 4;
        if Result < W then Result := W;
      end;
    finally
      if RestoreCanvas then
      begin
        ReleaseDC(0, Canvas.Handle);
        Canvas.Handle := 0;
      end;
    end;
  end;
end;

function TdxDBTreeListColumn.IsValidChar(InputChar: Char): Boolean;
begin
  Result := ATreeList.DataLink.Active and Assigned(Field) and Field.IsValidChar(InputChar);
end;

procedure TdxDBTreeListColumn.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FDisableGrouping := False;
  FSummaryGroupName := '';
end;

// protected TdxDBTreeListColumn
function TdxDBTreeListColumn.AlwaysStoredValue: Boolean;
begin
  Result := False;
end;

function TdxDBTreeListColumn.AssignedDrawCellEvent: Boolean;
begin
  Result := inherited AssignedDrawCellEvent or Assigned(FOnCustomDraw);
end;

function TdxDBTreeListColumn.AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant;
begin
  if Assigned(Field) then
  begin
    Field.Text := TdxInplaceTreeListEdit(AInplaceEdit).Text;
//    Result := Field.Value;
    Result := ANode.Values[Index]; // TODO Check
  end
  else
    Result := '';
end;

procedure TdxDBTreeListColumn.AssignNodeValues(ANode: TdxDBTreeListControlNode);
var
  VariantData: TNodeVariantData;
  F: TField;
begin
  // display text
  ANode.Strings[Index] := GetText(GetDisplayText(ANode));
  // variant value
  F := Field;
  with VariantData do
  begin
    AssignedValues := [];
    Value := Null;
    LookupValue := Null;
    if Assigned(F) then
    begin
      if (F.DataType in SimpleFields) or F.IsNull or ((F is TStringField) and
         (Assigned(F.OnGetText) or (F.EditMask <> ''))) or AlwaysStoredValue then
      begin
        Include(AssignedValues, nadValue);
        Value := F.Value;
      end;
      if F.Lookup then
      begin
        Include(AssignedValues, nadLookupValue);
  //      LookupValue := F.DataSet.FieldByName(F.KeyFields).Value;
        LookupValue := F.DataSet.FieldValues[F.KeyFields];
      end;
    end;
  end;
  ANode.VariantData[Index] := VariantData;
end;

procedure TdxDBTreeListColumn.ChangedReload(AllItems: Boolean);
begin
  if (ATreeList <> nil) and not (csLoading in ATreeList.ComponentState) and
     ATreeList.Datalink.Active then
    if AllItems then ATreeList.ChangedGroupColumn(nil)
    else ATreeList.ChangedGroupColumn(Self);
end;

procedure TdxDBTreeListColumn.DoDrawCell(ACanvas: TCanvas; var ARect: TRect; ANode: TdxTreeListNode;
    ASelected, AFocused: Boolean; ANewItemRow: Boolean; ALeftEdge, ARightEdge: Boolean; ABrush: HBRUSH;
    var AText: string; var AColor: TColor; AFont: TFont; var AAlignment: TAlignment; var ADone: Boolean);
begin
  // obsolete
  if Assigned(FOnCustomDraw) then FOnCustomDraw(Self, ACanvas, ARect, ANode, Self, AText,
    AFont, AColor, ASelected, AFocused, ADone);
  if not ADone then
    inherited DoDrawCell(ACanvas, ARect, ANode, ASelected, AFocused, ANewItemRow,
      ALeftEdge, ARightEdge, ABrush, AText, AColor, AFont, AAlignment, ADone);
end;

//function TdxDBTreeListColumn.GetDisplayText: String;
function TdxDBTreeListColumn.GetDisplayText(ANode: TdxTreeListNode): string;
begin
  if Field <> nil then Result := Field.DisplayText
  else Result := '';
end;

function TdxDBTreeListColumn.GetFilterEdit(AOwner: TComponent): TdxInplaceEdit;
begin
  Result := GetFilterEditClass.Create(AOwner);
  PrepareFilterEdit(Result);
end;

function TdxDBTreeListColumn.GetFilterEditClass: TdxInplaceEditClass;
begin
  Result := TCustomdxFilterEdit;
end;

procedure TdxDBTreeListColumn.GetFilterEditValues(AEdit: TdxInplaceEdit; var V: Variant; var S: string);
begin
  S := TdxInplaceTreeListEdit(AEdit).Text;
  V := S;
end;

procedure TdxDBTreeListColumn.SetFilterEditValue(AEdit: TdxInplaceEdit; const V: Variant);
begin
//  if AEdit is TCustomdxFilterEdit then
  if AEdit is TdxInplaceEdit then
    if VarIsNull(V) then
      TCustomdxFilterEdit(AEdit).Text := ''
    else
      TCustomdxFilterEdit(AEdit).Text := V;
end;

function TdxDBTreeListColumn.GetFilterOperators: TdxDBGridOperatorTypes;
begin
  Result := [gotEqual, gotNotEqual, gotGreater, gotGreaterEqual, gotLess,
    gotLessEqual, gotBlank, gotNonBlank];
end;

function TdxDBTreeListColumn.GetFilterValue(ANode: TdxTreeListNode{; Index: ?}): Variant;
begin
  Result := ANode.Values[Index];
end;

procedure TdxDBTreeListColumn.GetFilterValues(ANode: TdxTreeListNode; var V: Variant; var S: string);
begin
  V := GetFilterValue(ANode); 
  S := GetGroupText(ANode.Strings[Index]);
end;

function TdxDBTreeListColumn.GetGroupText(const Value : String) : String;
begin
  Result := Value;
end;

function TdxDBTreeListColumn.GetSummaryFooterText: String;
var
  DataType: TFieldType;
begin
  Result := '';
  if (SummaryFooterType <> cstNone) then
  begin
    if (SummaryFooterType <> cstCount) and Assigned(FSmrFooterField) and
      (FSmrFooterField.DataType in [ftDate, ftTime, ftDateTime]) then
      DataType := FSmrFooterField.DataType
    else DataType := ftUnknown;
    Result := GetSummaryString(SummaryFooterType, SummaryFooterFormat, FSummaryFooterValue, DataType, True);
  end;
end;

function TdxDBTreeListColumn.GetText(const Value : Variant) : String;
begin
  Result := Value;
end;

function TdxDBTreeListColumn.GetVariantType: Integer;
begin
  if Assigned(Field) then
  begin
    if Field.DataType in SimpleFields then
      Result := DataVarType(Field.DataType)
    else
      Result := varString;
  end
  else
    Result := varUnknown;
end;

function TdxDBTreeListColumn.InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant;
begin
  if Assigned(Field) then
  begin
    TdxInplaceTreeListEdit(AInplaceEdit).Text := Field.Text;
    Result := TdxInplaceTreeListEdit(AInplaceEdit).Text;
  end
  else
    Result := inherited InitEditValue(ANode, AInplaceEdit);
end;

function TdxDBTreeListColumn.IsBlobColumn: Boolean;
begin
  Result := False;
end;

function TdxDBTreeListColumn.IsEqualValues(const Value: Variant): Boolean;
begin
  if Assigned(Field) and not VarIsEmpty(Value) then
  begin
    if (VarType(Value) = varString) and not IsBlobColumn {TODO Check !!!} then
      Result := Field.Text = Value
    else Result := Field.Value = Value
  end
  else
    Result := False;
end;

type
  TdxInplaceEditWrapper = class(TdxInplaceEdit);

procedure TdxDBTreeListColumn.PrepareFilterEdit(AEdit: TdxInplaceEdit);
begin
  InitEditProperties(AEdit);
  TdxInplaceEditWrapper(AEdit).ReadOnly := False;
  if AEdit is TdxInplaceTextEdit then
    with TdxInplaceTreeListTextEdit(AEdit) do
    begin
      OnChange := nil;
      OnValidate := nil;
    end;
end;

procedure TdxDBTreeListColumn.SetIndex(Value: Integer);
var
  Fld: TField;
begin
  if ATreeList.GetDefaultFields and (ATreeList <> nil) and (ATreeList.Datalink.Active) then
  begin
    Fld := ATreeList.Datalink.Fields[Value];
    if Assigned(Fld) then
      Field.Index := Fld.Index
    else Field.Index := ATreeList.Datalink.FieldCount - 1;
  end;
  inherited SetIndex(Value);
end;

procedure TdxDBTreeListColumn.SetName(const Value: TComponentName);
var
  SaveEvent: TNotifyEvent;
  PrevName: string;
begin
  if not (csLoading in ComponentState) then
  begin
    SaveEvent := OnChangeName;
    PrevName := Name;
    OnChangeName := nil;
    inherited SetName(Value);
    OnChangeName := SaveEvent;
    if (PrevName <> Name) and (ATreeList <> nil) then
      ATreeList.RefreshSummaryItems(PrevName, Name);
    if Assigned(OnChangeName) then OnChangeName(Self);
  end
  else
    inherited SetName(Value);
end;

// private TdxDBTreeListColumn
function TdxDBTreeListColumn.GetDBTreeList: TCustomdxDBTreeListControl;
begin
  Result := TreeList as TCustomdxDBTreeListControl;
end;

function TdxDBTreeListColumn.GetField: TField;
begin
  Result := FField;
end;

procedure TdxDBTreeListColumn.SetDBTreeList(Value: TCustomdxDBTreeListControl);
begin
  TreeList := Value;
end;

procedure TdxDBTreeListColumn.SetDisableGrouping(Value : Boolean);
begin
  if DisableGrouping <> Value then
  begin
    FDisableGrouping := Value;
    if (GroupIndex <> -1) and FDisableGrouping then GroupIndex := -1
    else Changed(True);
  end;
end;

procedure TdxDBTreeListColumn.SetFieldName(const Value: String);
var
  OldValue: string;
  FlagRefresh, FlagActive: Boolean;
  AField: TField;
begin
  OldValue := FieldName;
  FlagRefresh := (Self.GroupIndex <> -1) and (ATreeList <> nil) and ATreeList.Datalink.Active;
  FlagActive := Assigned(ATreeList) and Assigned(ATreeList.DataLink.DataSet) and
                not (csLoading in ATreeList.ComponentState);
  if FlagRefresh and FlagActive then
  begin
    AField := ATreeList.DataLink.DataSet.FindField(Value);
    FField := AField;
    if (FField = nil) then ATreeList.SetGroupIndex(Self, -1);
  end;
//  inherited SetFieldName(Value);
  AField := nil;
  if FlagActive and (Length(Value) > 0) and
     (ATreeList.DataLink.DataSet.Active or
      not ATreeList.DataLink.DataSet.DefaultFields) then
      AField := ATreeList.DataLink.DataSet.FindField(Value);
  FFieldName := Value;
  FField := AField;
  //  Changed(False);
  if (ATreeList <> nil) and (ATreeList.LockUpdate = 0) then Changed(False);

  if (ATreeList <> nil) and
     not (csLoading in ATreeList.ComponentState) and
     (OldValue <> Value) then
  begin
    if (Self.GroupIndex <> -1) or FlagRefresh or True then
      ATreeList.ChangedGroupColumn(Self);
  end;
end;

procedure TdxDBTreeListColumn.SetGroupIndex(Value: Integer);
begin
  if Value >= -1 then
  // Delphi 5 - BUG !!!
    if ({$IFDEF DELPHI5}csReading{$ELSE}csLoading{$ENDIF} in ComponentState) then
      FGroupIndex := Value
    else
      if ATreeList <> nil then
        ATreeList.SetGroupIndex(Self, Value);
end;

function TdxDBTreeListColumn.GetSortBySummary: Boolean;
begin
  Result := FSortBySummary and (FSummaryType <> cstNone);
end;

procedure TdxDBTreeListColumn.SetSortBySummary(Value: Boolean);
begin
  FSortBySummary := Value and (FSummaryType <> cstNone);
end;

procedure TdxDBTreeListColumn.SetSummaryType(Value: TdxSummaryType);
begin
  if FSummaryType <> Value then
  begin
    FSummaryType := Value;
    if FSummaryType = cstNone then FSortBySummary := False;
    Changed(False); // Invalidate - no ReCalc summary (use to Refresh RefreshGroupColumns)
  end;
end;

procedure TdxDBTreeListColumn.SetSummaryFooterType(Value: TdxSummaryType);
begin
  if FSummaryFooterType <> Value then
  begin
    FSummaryFooterType := Value;
    Changed(False); // Invalidate - no ReCalc summary (use to Refresh RefreshGroupColumns)
  end;
end;

{TdxDBTreeListControlNode}
destructor TdxDBTreeListControlNode.Destroy;
var
  PValue: PNodeVariantData;
  I: Integer;
begin
  // free TStrings.Objects
  with FStrings do
    for I := 0 to Count - 1 do
    begin
      PValue := PNodeVariantData(Objects[I]);
      if PValue <> nil then
      begin
        Dispose(PValue);
        Objects[I] := nil;
      end;
    end;
  inherited Destroy;
end;

procedure TdxDBTreeListControlNode.Delete;
begin
end;

function TdxDBTreeListControlNode.GetVariantData(Column: Integer): TNodeVariantData;
begin
  with Result do
  begin
    AssignedValues := [];
    Value := Null;
    LookupValue := Null;
  end;
  if Column < FStrings.Count then
    if FStrings.Objects[Column] <> nil then
      Result := PNodeVariantData(FStrings.Objects[Column])^;
end;

procedure TdxDBTreeListControlNode.SetVariantData(Column: Integer; const Value: TNodeVariantData);
var
  PValue: PNodeVariantData;
begin
  if Column >= FStrings.Count then
     while FStrings.Add('') < Column do;
  if FStrings.Objects[Column] <> nil then
    PValue := PNodeVariantData(FStrings.Objects[Column])
  else New(PValue);
  PValue^ := Value;
  FStrings.Objects[Column] := TObject(PValue);
end;

function TdxDBTreeListControlNode.GetVariantValue(Column: Integer): Variant;
begin
  Result := Values[Column];
end;

{TCustomdxDBTreeListControl }
constructor TCustomdxDBTreeListControl.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FBkmList := TStringList.Create;
  FBkmList.OnChange := BkmStringsChanged;
  FIndicatorWidth := dxDBGridIndicatorWidth;
  FNodeLink := TList.Create;
end;

destructor TCustomdxDBTreeListControl.Destroy;
begin
  BeforeDestroy;
  FNodeLink.Free;
  FNodeLink := nil;
  FBkmList.Free;
  FBkmList := nil;
  inherited Destroy;
end;

procedure TCustomdxDBTreeListControl.ClearColumnsSorted;
var
  I: Integer;
begin
  inherited ClearColumnsSorted;
  for I := 0 to ColumnCount - 1 do
    if Columns[I].GroupIndex = -1 then Columns[I].FSorted := csNone;
end;

procedure TCustomdxDBTreeListControl.ClearGroupColumns;
begin
end;

procedure TCustomdxDBTreeListControl.ClearSelection;
begin
  if GetSelectedCount = 0 then Exit;
  if not (csDestroying in ComponentState) and not FClearNodes then
    InvalidateSelection;
  if FBkmList <> nil then FBkmList.Clear;
  inherited ClearSelection;
end;

function TCustomdxDBTreeListControl.ColumnByFieldName(const FieldName: string): TdxDBTreeListColumn;
begin
  Result := FindColumnByFieldName(FieldName);
  if Result = nil then
    InvaliddxTreeListOperation(FmtLoadStr(dxSColumnNotFound, [Name, FieldName]));
end;

function TCustomdxDBTreeListControl.ColumnByName(const AName: String): TdxDBTreeListColumn;
begin
  Result := inherited ColumnByName(AName) as TdxDBTreeListColumn;
end;

function TCustomdxDBTreeListControl.CreateColumn(ColumnClass: TdxDBTreeListColumnClass): TdxDBTreeListColumn;
begin
  Result := CreateColumnEx(ColumnClass, Self);
end;

function TCustomdxDBTreeListControl.CreateColumnEx(ColumnClass: TdxDBTreeListColumnClass;
  AOwner: TComponent): TdxDBTreeListColumn;
var
  I: Integer;
begin
  if GetDefaultFields then
    raise Exception.Create(LoadStr(dxSDefaultFieldsError){'DefaultFields property should be set to False'});
  Result := ColumnClass.Create(AOwner);
  I := ColumnCount + 1;
  while I <> -1 do
    try
      Result.Name := Name + 'Column' + IntToStr(I);
      I := -1;
    except
      Inc(I);
    end;
  Result.ATreeList := Self;
end;

procedure TCustomdxDBTreeListControl.DestroyColumns;
begin
  if GetDefaultFields and not (FInternalDestroying or
    (csDestroying in ComponentState) or (LockUpdate <> 0)) then
    raise Exception.Create(LoadStr(dxSDefaultFieldsError){'DefaultFields property should be set to False'});
  inherited DestroyColumns;
end;

procedure TCustomdxDBTreeListControl.FullRefresh;
begin
  LayoutChanged;
end;

function TCustomdxDBTreeListControl.GetColumnAt(X, Y: Integer): TdxDBTreeListColumn;
begin
  Result := TdxDBTreeListColumn(inherited GetColumnAt(X, Y));
end;

class function TCustomdxDBTreeListControl.GetDefaultColumnClass: TdxDBTreeListColumnClass;
begin
  Result := TdxDBTreeListColumn;
end;

class function TCustomdxDBTreeListControl.GetDefaultFieldColumnClass(AField: TField): TdxDBTreeListColumnClass;
begin
  Result := TdxDBTreeListColumn;
end;

function TCustomdxDBTreeListControl.GetFooterColumnAt(X, Y: Integer): TdxDBTreeListColumn;
begin
  Result := TdxDBTreeListColumn(inherited GetFooterColumnAt(X, Y));
end;

function TCustomdxDBTreeListControl.GetHeaderColumnAt(X, Y: Integer): TdxDBTreeListColumn;
begin
  Result := TdxDBTreeListColumn(inherited GetHeaderColumnAt(X, Y));
end;

function TCustomdxDBTreeListControl.RefreshBookmarks: Boolean;
var
  I: Integer;
begin
  Result := False;
  if Assigned(DataLink.Datasource.Dataset) then
    with DataLink.Datasource.Dataset do
    try
      CheckBrowseMode;
      for I := FBkmList.Count-1 downto 0 do
        {$IFNDEF DELPHI3}
        if DbiSetToBookmark(Handle, Pointer(FBkmList[I])) <> 0 then
        {$ELSE}
        if not BookmarkValid(TBookmark(FBkmList[I])) then
        {$ENDIF}
        begin
          Result := True;
          FBkmList.Delete(I);
        end;
    finally
      UpdateCursorPos;
      if Result then Invalidate;
    end;
end;

function TCustomdxDBTreeListControl.FindColumnByFieldName(const FieldName: string): TdxDBTreeListColumn;
var
  I: Integer;
begin
  for I := 0 to ColumnCount - 1 do
  begin
    Result := Columns[I];
    if AnsiCompareText(Result.FFieldName, FieldName) = 0 then Exit;
  end;
  Result := nil;
end;

{$IFDEF DELPHI4}
function TCustomdxDBTreeListControl.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (DataLink <> nil) and
    DataLink.ExecuteAction(Action);
end;

function TCustomdxDBTreeListControl.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (DataLink <> nil) and
    DataLink.UpdateAction(Action);
end;
{$ENDIF}

// protected TCustomdxDBTreeListControl
function TCustomdxDBTreeListControl.AssignedDrawCellEvent(ANode: TdxTreeListNode; AbsoluteIndex: Integer): Boolean;
begin
  Result := inherited AssignedDrawCellEvent(ANode, AbsoluteIndex) or
    Columns[AbsoluteIndex].AssignedDrawCellEvent;
end;

function TCustomdxDBTreeListControl.AssignedDrawFooterCellEvent(ANode: TdxTreeListNode; AbsoluteIndex, FooterIndex: Integer{Column Index}): Boolean;
begin
  Result := inherited AssignedDrawFooterCellEvent(ANode, AbsoluteIndex, FooterIndex);
  if not Result and (FooterIndex = -1) then
    Result := Assigned(TdxDBTreeListColumn(Columns[AbsoluteIndex]).FOnDrawSummaryFooter);
end;

procedure TCustomdxDBTreeListControl.DoDrawFooterCell(ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode; AIndex, AFooterIndex: Integer; var AText: string;
    var AColor: TColor; AFont: TFont; var AAlignment: TAlignment; var ADone: Boolean);
var
  Column: TdxDBTreeListColumn;
begin
  if AFooterIndex = -1 then
  begin
    Column := TdxDBTreeListColumn(Columns[AIndex]);
    if Assigned(Column.FOnDrawSummaryFooter) then Column.FOnDrawSummaryFooter(Column, ACanvas, ARect,
      AText, AAlignment, AFont, AColor, ADone);
  end;
  if not ADone then
    inherited DoDrawFooterCell(ACanvas, ARect, ANode, AIndex, AFooterIndex, AText,
      AColor, AFont, AAlignment, ADone);
end;

procedure TCustomdxDBTreeListControl.DoDrawHeader(AbsoluteIndex: Integer; ACanvas: TCanvas;
  ARect, AClipRect: TRect; var AText: string; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ASorted: TdxTreeListColumnSort; var ADone: Boolean);
var
  Column: TdxDBTreeListColumn;
begin
  Column := Columns[AbsoluteIndex];
  // obsolete
  if Assigned(Column.FOnCustomDrawHeader) then
    Column.FOnCustomDrawHeader(Self, ACanvas, ARect, Column, ADone);
  if not ADone then
    inherited DoDrawHeader(AbsoluteIndex, ACanvas, ARect, AClipRect, AText,
      AColor, AFont, AAlignment, ASorted, ADone);
end;

function TCustomdxDBTreeListControl.GetEditColor: TColor;
var
  Column: TdxDBTreeListColumn;
  I: Integer;
begin
  Result := inherited GetEditColor;
  I := FocusedAbsoluteIndex;
  if I <> -1 then Column := Columns[I]
  else Column := nil;
  if Assigned(FOnGetEditColor) then FOnGetEditColor(Self, FocusedNode, Column, Result);
end;

procedure TCustomdxDBTreeListControl.SetName(const Value: TComponentName);
var
  I: Integer;
  OldName, FieldName, NamePrefix: TComponentName;
  Column: TdxDBTreeListColumn;
  OldChangeEvent : TNotifyEvent;
begin
  OldName := Name;
  inherited SetName(Value);
  if (csDesigning in ComponentState) and (Name <> OldName) then
  begin
    { In design mode the name of the columns should track the data set name }
    for I := 0 to ColumnCount - 1 do
    begin
      Column := Columns[I];
      if Column.Owner = Owner then
      begin
        FieldName := Column.Name;
        NamePrefix := FieldName;
        if Length(NamePrefix) > Length(OldName) then
        begin
          SetLength(NamePrefix, Length(OldName));
          if CompareText(OldName, NamePrefix) = 0 then
          begin
            System.Delete(FieldName, 1, Length(OldName));
            System.Insert(Value, FieldName, 1);
            OldChangeEvent := Column.OnChangeName;
            Column.OnChangeName := Nil;
            try
              Column.Name := FieldName;
            except
              on EComponentError do {Ignore rename errors };
            end;
            Column.OnChangeName := OldChangeEvent;
          end;
        end;
      end;
    end;
    {Refresh columns list}
    if Assigned(Designer) then Designer.LayoutChanged;
  end;
end;

procedure TCustomdxDBTreeListControl.DoStartDrag(var DragObject: TDragObject);
begin
  if Assigned(Datalink.DataSet) and (Datalink.DataSet.State in dsEditModes) then
    Datalink.DataSet.Post;
//    InvaliddxTreeListOperation(LoadStr(dxSInvalidDataSetMode){'Dataset in edit or insert mode'});
  inherited DoStartDrag(DragObject);
end;

function TCustomdxDBTreeListControl.IsCancelOnExit: Boolean;
begin
  Result := True;
end;

function TCustomdxDBTreeListControl.IsEasySelect: Boolean;
begin
  Result := False;
end;

function TCustomdxDBTreeListControl.IsExistFooterCell(AbsoluteIndex: Integer): Boolean;
begin
  Result := inherited IsExistFooterCell(AbsoluteIndex) or
    (Columns[AbsoluteIndex].SummaryFooterType <> cstNone);
end;

// Editor
function TCustomdxDBTreeListControl.AssignEditValue(ANode: TdxTreeListNode;
  AColumn: Integer; AInplaceEdit: TdxInplaceEdit): Variant;
var
  I: Integer;
begin
  I := GetFocusedAbsoluteIndex(AColumn);
  if (I <> -1) and DataLink.IsModified then
  begin
    with Columns[I] do
      if Assigned(Field) and Assigned(DataLink.DataSet) and
        (DataLink.DataSet.State in dsEditModes) then
      begin
        FActualNode := ANode;
        try
          AddNodeLink(ANode);
          Result := AssignEditValue(ANode, AInplaceEdit);
          if ValidateNode(ANode) then
          begin
            ANode.Strings[Index] := GetText(GetDisplayText(ANode));
            if NodeLinkList <> nil then
              NodeLinkList.Remove(ANode);
          end;
        finally
          FActualNode := nil;
        end;
      end;
  end
  else
    Result := '';
  FEditValue := Result;  
  inherited AssignEditValue(ANode, AColumn, AInplaceEdit);
end;

function TCustomdxDBTreeListControl.CanEditAcceptKey(Key: Char): Boolean;
//var
//  Field: TField;
begin
  if FocusedAbsoluteIndex <> -1 then
    Result := Columns[FocusedAbsoluteIndex].IsValidChar(Key)
  else
    Result := True;
{
  Result := True;
  Field := FocusedField;
  if Field <> nil then
    Result := Datalink.Active and Assigned(Field) and Field.IsValidChar(Key);}
end;

function TCustomdxDBTreeListControl.CanEditModify: Boolean;
begin
  Result := False;
  if not IsCanNavigation or IsKeyFieldEmpty then Exit;
  if Datalink.Active and not Datalink.Readonly and (FocusedColumn <> -1) then
  with Columns[FocusedAbsoluteIndex] do
  begin
    if (not ReadOnly) and Assigned(Field) and (Field.CanModify or (Field.Lookup and CanLookupFieldModify(Field))) and
      (not {$IFDEF DELHPI3}Field.IsBlob{$else}(Field is TBlobField){$ENDIF} or
      Assigned(Field.OnSetText) or IsBlobColumn) then // TODO EDIT
    begin
      if not IsDisableEditing then
      begin
        Datalink.Edit;
        Result := Datalink.Editing;
        if Result then Datalink.Modified;
      end;
    end;
  end;
end;

function TCustomdxDBTreeListControl.CanEditShow: Boolean;
begin
  Result := inherited CanEditShow and (FocusedNode <> nil ) and DataLink.Active;
end;

procedure TCustomdxDBTreeListControl.DoBeforeEditing(Node: TdxTreeListNode; var AllowEditing: Boolean);
begin
  inherited DoBeforeEditing(Node, AllowEditing);
  AllowEditing := AllowEditing and IsCanNavigation;
end;

procedure TCustomdxDBTreeListControl.DoBeforeEditNewItemRow(var Allow: Boolean);
begin
  Allow := False;
  if (0 <= FocusedColumn) and (FocusedColumn < GetVisibleHeaderCount) and
    Columns[FocusedAbsoluteIndex].GetEnableEditor then // new code * (see TCustomdxTreeListControl.DoBeforeEditing)
  begin
    if (DataLink.DataSet <> nil) and DataLink.DataSet.Active and
      IsCanInsert and IsCanNavigation then
    begin
      if DataLink.DataSet.State <> dsInsert then
        DataLink.DataSet.Insert;
      Allow := True;
      // OnEditing - (FocusedNode)
      if Assigned(OnEditing) then OnEditing(Self, FocusedNode, Allow);
    end;
  end;
end;

procedure TCustomdxDBTreeListControl.DoBeginNewItemActive;
var
  B: Boolean;
begin
  B := True;
  DoBeforeEditNewItemRow(B);
end;

function TCustomdxDBTreeListControl.InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant;
begin
  Result := inherited InitEditValue(ANode, AInplaceEdit);
  FEditValue := Result;
end;

procedure TCustomdxDBTreeListControl.InvalidateEditorValue;
begin
  if State <> tsEditing then Exit;
  if not Columns[FocusedAbsoluteIndex].IsEqualValues(FEditValue) then
    InvalidateEditor;
end;

procedure TCustomdxDBTreeListControl.DataChanged;
begin
end;

function TCustomdxDBTreeListControl.IsDataSetBusy: Boolean;
begin
  Result := False;
end;

procedure TCustomdxDBTreeListControl.LinkActive(Value: Boolean);
begin
end;

procedure TCustomdxDBTreeListControl.RecordChanged(Field: TField);
begin
end;

procedure TCustomdxDBTreeListControl.Scroll(Distance: Integer);
begin
end;

procedure TCustomdxDBTreeListControl.UpdateData;
begin
  HideEditor;
end;

procedure TCustomdxDBTreeListControl.NodeRecordChanged(Field: TField; var Node: TdxDBTreeListControlNode);
var
  CField: TField;
begin
  if not HandleAllocated then Exit;
  RefreshNodeValues(Node);
  if ColumnCount = 0 then Exit;
  if (InplaceEditor = nil) or not InplaceEditor.IsVisible then Exit;
  CField := FocusedField;
  Columns[GetFocusedAbsoluteIndex(InplaceColumnIndex){FocusedAbsoluteIndex}].FActualNode := Node;
  try
    if ((Field = nil) or (CField = Field)) and
      (Assigned(CField) and (InplaceEditor <> nil) and
      not InplaceEditor.DisableRefresh and
      not Columns[GetFocusedAbsoluteIndex(InplaceColumnIndex){FocusedAbsoluteIndex}].IsEqualValues(FEditValue)) then
    begin
      InvalidateEditor;
      if InplaceEditor <> nil then InplaceEditor.Deselect;
    end;
  finally
    Columns[GetFocusedAbsoluteIndex(InplaceColumnIndex){FocusedAbsoluteIndex}].FActualNode := nil;
  end;
end;

procedure TCustomdxDBTreeListControl.RefreshNodeValues(var Node: TdxDBTreeListControlNode);
begin
end;

//Grouping
procedure TCustomdxDBTreeListControl.ChangedGroupColumn(Column : TdxDBTreeListColumn);
begin
end;

procedure TCustomdxDBTreeListControl.SetGroupIndex(AColumn: TdxDBTreeListColumn; AIndex: Integer);
begin
end;

procedure TCustomdxDBTreeListControl.AssignSummaryFields;
begin
end;

procedure TCustomdxDBTreeListControl.AssignSummaryFooterFields;
var
  I: Integer;
begin
  if Assigned(DataLink.DataSet) then
    for I := 0 to ColumnCount - 1 do
    begin
      if Columns[I].SummaryFooterField <> '' then
        Columns[I].FSmrFooterField := DataLink.DataSet.FindField(Columns[I].SummaryFooterField)
      else Columns[I].FSmrFooterField := DataLink.DataSet.FindField(Columns[I].FieldName);
      Columns[I].FSummaryFooterValue := 0;
      Columns[I].FAssignedSummaryFooter := False;
    end;
end;

procedure TCustomdxDBTreeListControl.DoBeforeCalcSummary;
begin
  if Assigned(FOnBeforeCalcSummary) then FOnBeforeCalcSummary(Self);
end;

procedure TCustomdxDBTreeListControl.DoRefreshNodeData(Node: TdxTreeListNode);
begin
  if Assigned(FOnRefreshNodeData) then FOnRefreshNodeData(Self, Node);
end;

function TCustomdxDBTreeListControl.GetSummaryValue(ANode: TdxTreeListNode): Extended;
begin
  Result := 0;
end;

procedure TCustomdxDBTreeListControl.RefreshSummaryItems(const PrevName, NewName: string);
begin
end;

// Sorted
procedure TCustomdxDBTreeListControl.CheckSortedColumns;
var
  I: Integer;
  Found: Boolean;
begin
  if IsMultiSort then Exit;
  Found := False;
  for I := 0 to ColumnCount - 1 do
   if Columns[I].GroupIndex = -1 then
    if Columns[I].Sorted <> csNone then
      if Found then Columns[I].FSorted := csNone
      else Found := True;
end;

function TCustomdxDBTreeListControl.GetIndicatorWidth: Integer;
begin
  Result := FIndicatorWidth;
end;

function TCustomdxDBTreeListControl.GetRowIndicatorKind(Node: TdxTreeListNode; ASelected: Boolean): TdxGridIndicatorKind;
begin
  Result := ikNone;
  if Node.Focused then
  begin
    if ASelected and IsMultiSelect then
      Result := ikMultiArrow
    else Result := ikArrow;
    if DataLink.DataSet <> nil then
    case DataLink.DataSet.State of
    dsEdit: Result := ikEdit;
    dsInsert: Result := ikInsert;
    end;
  end
  else
    if ASelected then Result := ikMultiDot;
end;

procedure TCustomdxDBTreeListControl.ResyncSelection;
begin
  if IsMultiSelect and
    not (Focused or ((InplaceEditor <> nil) and (InplaceEditor.IsFocused))) then
  begin
    if (Count = 0) or (FocusedNode = nil) or
      ((SelectedCount = 1) and FocusedNode.Selected) then Exit;
    BeginSelection;
    try
      ClearSelection;
      FocusedNode.Selected := True;
    finally
      EndSelection;
    end;
  end;
end;

function TCustomdxDBTreeListControl.CompareBkm(const Item1, Item2: TBookmarkStr): Integer;
begin
  if not Datalink.Active then Result := -1
  {$IFNDEF DELPHI3}
  else with FDatalink.Datasource.Dataset do
    DB.Check(DbiCompareBookmarks(Handle, Pointer(Item1), Pointer(Item2), Result));
  if Result = 2 then Result := 0;
  {$ELSE}
  else with Datalink.Datasource.Dataset do
    Result := CompareBookmarks(TBookmark(Item1), TBookmark(Item2));
  {$ENDIF}
end;

function TCustomdxDBTreeListControl.FindBkm(const Item: TBookmarkStr; var Index: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  if (Item = FBkmCache) and (FBkmCacheIndex >= 0) then
  begin
    Index := FBkmCacheIndex;
    Result := FBkmCacheFind;
    Exit;
  end;
  Result := False;
  L := 0;
  H := FBkmList.Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := CompareBkm(FBkmList[I], Item);
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
  FBkmCache := Item;
  FBkmCacheIndex := Index;
  FBkmCacheFind := Result;
end;

function TCustomdxDBTreeListControl.FindSelectedNode(Node: TdxTreeListNode; var Index: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;
  L := 0;
  H := FBkmList.Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
//    C := CompareNodes(FSelectedNodes[I], Node);
    C := Integer(FBkmList.Objects[I]) - Integer(Node);
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

function TCustomdxDBTreeListControl.GetSelectedCount: Integer;
begin
  if FBkmList = nil then Result := 0
  else Result := FBkmList.Count;
end;

function TCustomdxDBTreeListControl.GetSelectedItem(AIndex: Integer): TdxTreeListNode;
begin
  if (AIndex >= 0) and (AIndex < GetSelectedCount) then
    Result := TdxTreeListNode(FBkmList.Objects[AIndex])
  else Result := nil;
end;

function TCustomdxDBTreeListControl.GetSelectedRow(Index: Integer): TBookmarkStr;
begin
  Result := FBkmList[Index];
end;

procedure TCustomdxDBTreeListControl.SelectNodes(N1, N2: TdxTreeListNode);
var
  StartNode, EndNode, OldFocused, Node: TdxTreeListNode;
  I, J, C, I1, I2: Integer;
  FList: TList;
begin
  if (Datalink.Dataset.State in dsEditModes) or not IsMultiSelect then Exit;
  BeginSelection;
  try
    if IsEasySelect then
      inherited SelectNodes(N1, N2)
    else  
    if not IsUseBookmarks then
    begin
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
          FList.Sort(CompareNodes);
          // [FList] or [BkmList]
          J := 0;
          for I := 0 to BkmList.Count - 1 do
          begin
            if J = -1 then
              FList.Add(BkmList.Objects[I])
            else
            repeat
              C := CompareNodes(BkmList.Objects[I], FList[J]);
              if C <= 0 then
              begin
                if C < 0 then
                begin
                  FList.Insert(J, BkmList.Objects[I]);
                  Inc(J);
                end;
                Break;
              end;
              {else C > 0}
              Inc(J);
              if J >= FList.Count then
              begin
                FList.Add(BkmList.Objects[I]);
                J := -1;
                Break;
              end;
            until False;
          end;
          // copy from temp list
          BkmList.Clear;
          BkmList.Capacity := FList.Count;
          for I := 0 to FList.Count - 1 do
            BkmList.AddObject('', FList[I]);
        finally
          FFirstSelectedNode := nil;
          FList.Free;
        end;
      finally
        EndUpdate;
      end;
    end
    else
    begin
      if DataLink.Active then
        with Datalink.Dataset do
        begin
          StartNode := N1;
          EndNode := N2;
          i1 := GetAbsoluteIndex(N1);
          i2 := GetAbsoluteIndex(N2);
          if i1 > i2 then
          begin
            StartNode := N2;
            EndNode := N1;
          end;
          DisableControls;
          OldFocused := FocusedNode;
          BeginUpdate;
          try
            c := 0;
            while (StartNode <> Nil) Do
            begin
              StartNode.Focused := True;
              StartNode.Selected := True;
              Inc(c);
              if (StartNode = EndNode) or ((c-1) >= Abs(i1-i2)) then Break;
              StartNode := GetNextVisible(StartNode);
            end;
          finally
            OldFocused.Focused := True;
            SetDataChangedBusy(True);
            EnableControls;
            SetDataChangedBusy(False);
            EndUpdate;
          end;
        end;
    end;
  finally
    EndSelection;
  end;
end;

function TCustomdxDBTreeListControl.CompareEqual(Node1, Node2: TdxTreeListNode): Integer;
begin
  if (VarType(TdxDBTreeListControlNode(Node1).Id) = varEmpty) or
    (VarType(TdxDBTreeListControlNode(Node2).Id) = varEmpty) then
    Result := 0
  else
  {$IFNDEF DELPHI6}
  if TdxDBTreeListControlNode(Node1).Id = TdxDBTreeListControlNode(Node2).Id then
    Result := inherited CompareEqual(Node1, Node2)
  else
    if TdxDBTreeListControlNode(Node1).Id < TdxDBTreeListControlNode(Node2).Id then
      Result := -1
    else Result := 1;
  {$ELSE}
  begin
    Result := VarCompare(TdxDBTreeListControlNode(Node1).Id, TdxDBTreeListControlNode(Node2).Id);
    if Result = 0 then
      Result := inherited CompareEqual(Node1, Node2);
  end;
  {$ENDIF}
end;

function TCustomdxDBTreeListControl.IsDragScroll: Boolean;
begin
  Result := inherited IsDragScroll and
    not (Assigned(Datalink.DataSet) and (Datalink.DataSet.State in dsEditModes));
end;

procedure TCustomdxDBTreeListControl.PrepareColumnSorted(Column: TdxTreeListColumn);
begin
  if IsAutoSort and (TdxDBTreeListColumn(Column).GroupIndex = -1) and
    not (FlagMultiSort or LockSorting) then ClearColumnsSorted;
end;

procedure TCustomdxDBTreeListControl.AssignNodeValues(ANode: TdxDBTreeListControlNode; AColumn: TdxDBTreeListColumn);
begin
  AColumn.AssignNodeValues(ANode);
end;

procedure TCustomdxDBTreeListControl.AssignNodeAllValues(Node: TdxDBTreeListControlNode);
var
  I: Integer;
begin
  if Assigned(FKeyField) then
     Node.Id := FKeyField.Value
  else Node.Id := Null;
  for I := 0 to ColumnCount - 1 do
    if Assigned(Columns[I].Field) then AssignNodeValues(Node, Columns[I]);
  if Assigned(FPreviewField) then
  try
    if Assigned(FPreviewField.OnGetText) then
      FPreviewField.OnGetText(FPreviewField, Node.FDescription, True)
    else
      Node.FDescription := GetPreviewString(FPreviewField.AsString);
  except
  end;
end;

function TCustomdxDBTreeListControl.GetPreviewString(const S: string): string;
begin
  if PreviewMaxLength > 0 then
  begin
    Result := Copy(S, 1, PreviewMaxLength);
    if Length(S) > PreviewMaxLength then
      Result := Result + '...';
  end
  else
    Result := S;
end;

function TCustomdxDBTreeListControl.GetColumnVariantData(ANode: TdxDBTreeListControlNode; AColumn: TdxDBTreeListColumn): Variant;
begin
  if nadValue in ANode.VariantData[AColumn.Index].AssignedValues then
    Result := ANode.VariantData[AColumn.Index].Value
  else
    begin
      Result := ANode.Values[AColumn.Index];
      if (VarType(Result) = varString) and (Result = '') then
        Result := Null;
    end;
end;

function TCustomdxDBTreeListControl.GetNodeVarData(ANode: TdxDBTreeListControlNode; AColumn: TdxDBTreeListColumn): Extended;
var
  Val: Variant;
  AVarType: Integer;
begin
  Result := 0;
  if AColumn <> nil then
  begin
    Val := GetColumnVariantData(ANode, AColumn);
    AVarType := VarType(Val);
    if (AVarType in [varSmallint, varInteger, varSingle, varDouble, varCurrency,
      varDate, varByte]) {$IFDEF DELPHI6}or VarIsFMTBcd(Val){$ENDIF} then
      Result := Val;
  end;
end;

function TCustomdxDBTreeListControl.AcquireFocus: Boolean;
begin
  Result := True;
  if CanFocus and not (csDesigning in ComponentState) then
  begin
    //SetFocus;
    Windows.SetFocus(Handle);
    Result := Focused or (InplaceEditor <> nil) and InplaceEditor.Focused;
  end;
end;

procedure TCustomdxDBTreeListControl.BeginCustomLayout;
var
  I, J, K: Integer;
  Fld: TField;
  Column: TdxDBTreeListColumn;

  function FieldIsMapped(F: TField): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    if F = nil then Exit;
    for I := 0 to Datalink.FieldCount-1 do
      if Datalink.Fields[I] = F then
      begin
        Result := True;
        Exit;
      end;
  end;

begin
  inherited BeginCustomLayout;
  HideEditor;
  Datalink.ClearMapping;
  if Datalink.Active then DefineFieldMap;
  // Desc Field
  AssignPreviewField;
  if GetDefaultFields then
  begin
    // Destroy columns whose fields have been destroyed or are no longer in field map
    if not DataLink.Active then
    begin
      FInternalDestroying := True;
      try
        DestroyColumns;
      finally
        FInternalDestroying := False;
      end;
    end
    else
      for J := ColumnCount - 1 downto 0 do
        with Columns[J] do
        if (FField = nil) or
           not FieldIsMapped(FField) then Free;
    // Validate order columns
    I := DataLink.FieldCount;
    for J := 0 to I - 1 do
    begin
      Fld := Datalink.Fields[J];
      if Assigned(Fld) then
      begin
        K := J;
        while (K < ColumnCount) and (Columns[K].Field <> Fld) do Inc(K);
        if K < ColumnCount then
          Column := Columns[K]
        else
        begin
          Column := CreateDefaultColumn(GetDefaultFieldColumnClass(Fld));
          Column.FFieldName := Fld.FieldName;
          Column.FField := Fld;
        end;
      end
      else
        Column := CreateDefaultColumn(GetDefaultColumnClass); // simple column
      // set index
      if (J < Count) then Column.Index := J;
    end;
  end
  else
  begin
    // Force columns to reaquire fields (in case dataset has changed)
    for I := 0 to ColumnCount-1 do
      Columns[I].FieldName := Columns[I].FieldName;
  end;
  RefreshDefaultColumnsWidths;
end;

function TCustomdxDBTreeListControl.FindNodeByText(AColumnIndex: Integer; const AText: string;
  ADirection: TdxTreeListSearchDirection; var ANode: TdxTreeListNode): Boolean;
var
  DataSet: TDataSet;
  L: Integer;
  S: string;
  F: TField;
  SavePos, StartPos: TBookmarkStr;
  AColumn: TdxDBTreeListColumn;

  procedure CalcNextRecord;
  begin
    with DataSet do
      if ADirection = sdUp then
      begin
        Prior;
        if BOF then
        begin
          Last;
          StartPos := SavePos;
        end;
      end
      else
      begin
        Next;
        if EOF then
        begin
          First;
          StartPos := SavePos;
        end;
      end;
  end;

begin
  if IsLoadedAll then
    Result := inherited FindNodeByText(AColumnIndex, AText, ADirection, ANode)
  else
  begin
    ANode := nil;
    Result := False;
    DataSet := nil;
    if DataSource <> nil then
    begin
      DataSet := DataSource.DataSet;
      with DataSet do
      begin
        if Active and not (BOF and EOF) and not (State in dsEditModes) and (AText <> '') then
        begin
          AColumn := Columns[AColumnIndex];
          L := Length(AText);
          F := AColumn.Field;
          if Assigned(F) then
          begin
            if IsEqualText(Copy(F.AsString{DisplayText}, 1, L), AText) then
              Result := True;
            if (ADirection <> sdNone) or not Result then
            begin
              SavePos := Bookmark;
              StartPos := '';
              DisableControls;
              try
                if ADirection <> sdNone then CalcNextRecord;
                while (not EOF or (ADirection <> sdNone)) and ((Length(StartPos) = 0) or
                  (CompareBkm(Bookmark, StartPos) <> 0)) do
                begin
                  S := F.AsString{DisplayText};
                  if IsEqualText(Copy(S, 1, L), AText) then
                  begin
                    Result := True;
                    Break;
                  end;
                  CalcNextRecord;
                end;
              finally
                if not Result and BookmarkValid(TBookmark(SavePos)) then
                  Bookmark := SavePos;
                EnableControls;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

// based
procedure TCustomdxDBTreeListControl.AddNodeLink(ANode : Pointer);
begin
  if FNodeLink.IndexOf(ANode) = -1 then FNodeLink.Add(ANode);
end;

procedure TCustomdxDBTreeListControl.AssignPreviewField;
const
  SupportedBlobType = [ftBlob, ftMemo, ftFmtMemo];
begin
  FPreviewField := nil;
  if (PreviewFieldName <> '') and Datalink.Active then
  begin
    FPreviewField := Datalink.DataSet.FindField(PreviewFieldName);
    if (FPreviewField is TBlobField) and
       not (TBlobField(FPreviewField).BlobType in SupportedBlobType) then
         FPreviewField := nil;
    if FPreviewField <> nil then
       FPreviewField.FreeNotification(Self);
  end;
end;

function TCustomdxDBTreeListControl.CreateDefaultColumn(ColumnClass: TdxDBTreeListColumnClass): TdxDBTreeListColumn;
begin
  Result := ColumnClass.Create(Self);
  Result.TreeList := Self;
end;

procedure TCustomdxDBTreeListControl.CreateDefaultColumns(DataSet: TDataSet; AOwner: TComponent);
var
  I: Integer;
  Column: TdxDBTreeListColumn;
begin
  with DataSet do
  begin
    if AOwner = nil then AOwner := Self;
    for I := 0 to FieldCount - 1 do
    begin
      Column := CreateColumnEx(GetDefaultFieldColumnClass(Fields[I]), AOwner);
      Column.FieldName := Fields[I].FieldName;
      Column.Visible := Fields[I].Visible;
    end;
  end;
end;

procedure TCustomdxDBTreeListControl.DefineFieldMap;
var
  I: Integer;
begin
  if not GetDefaultFields then
    for I := 0 to ColumnCount - 1 do
      DataLink.AddMapping(Columns[I].FieldName)
  else
    with Datalink.Dataset do
      for I := 0 to FieldCount - 1 do
        with Fields[I] do if Visible then Datalink.AddMapping(FieldName);
end;

function TCustomdxDBTreeListControl.ValidateNode(ANode : Pointer) : Boolean;
begin
  Result := FNodeLink.IndexOf(ANode) <> -1;
end;

// based override
procedure TCustomdxDBTreeListControl.DeleteNode(Node, Prior, Next: TdxTreeListNode; IsLast, Redraw: Boolean);
begin
  inherited DeleteNode(Node, Prior, Next, IsLast, Redraw);
  if FNodeLink <> nil then FNodeLink.Remove(Node);
end;

procedure TCustomdxDBTreeListControl.DeleteStrings(Node: TdxTreeListNode; Index: Integer);
var
  I: Integer;
  PValue: PNodeVariantData;
begin
  if Index < TdxDBTreeListControlNode(Node).FStrings.Count then
  begin
    PValue := PNodeVariantData(TdxDBTreeListControlNode(Node).FStrings.Objects[Index]);
    if PValue <> nil then Dispose(PValue);
    TdxDBTreeListControlNode(Node).FStrings.Delete(Index);
  end;
  for I := 0 to Node.Count - 1 do
    DeleteStrings(Node[I], Index);
end;

procedure TCustomdxDBTreeListControl.DoChangeNodeEx;
begin
  if LockSelection = 0 then
  begin
    if (FLockSearching = 0) and not FInKeyDown then
      EndSearch;
    if Datalink.Active and Assigned(OnChangeNodeEx) then
      OnChangeNodeEx(Self);
  end;  
end;

function TCustomdxDBTreeListControl.IsDisableEditing: Boolean;
begin
  Result := False;
  with Datalink do
    if Active and (DataSet <> nil) and DataSet.Active then
      Result := not IsCanInsert and DataSet.BOF and DataSet.EOF {Empty} and
       (Datalink.Dataset.State = dsBrowse);
end;

function TCustomdxDBTreeListControl.IsNewItemRowEditing: Boolean;
begin
  Result := inherited IsNewItemRowEditing and (FocusedNode <> nil) and
    (DataLink.DataSet <> nil) and (DataLink.DataSet.State = dsInsert);
end;

function TCustomdxDBTreeListControl.GetNewItemCellText(AbsoluteIndex: Integer): string;
begin
  if (FocusedNode <> nil) and IsNewItemRowEditing then
    Result := GetCellText(FocusedNode, AbsoluteIndex)
  else Result := '';
end;

function TCustomdxDBTreeListControl.GetReadOnly: Boolean;
begin
  Result := inherited GetReadOnly or IsDisableEditing or IsKeyFieldEmpty;
end;

function TCustomdxDBTreeListControl.MakeFocused(Node: TdxTreeListNode): Boolean;
begin
  AddNodeLink(Node);
  Node.Focused := True;
  Result := ValidateNode(Node);
end;

// private TCustomdxDBTreeListControl
procedure TCustomdxDBTreeListControl.BkmStringsChanged(Sender: TObject);
begin
  FBkmCache := '';
  FBkmCacheIndex := -1;
end;

function TCustomdxDBTreeListControl.GetColumn(Index: Integer): TdxDBTreeListColumn;
begin
  Result := TdxDBTreeListColumn(inherited Columns[Index]);
end;

function TCustomdxDBTreeListControl.GetFocusedField: TField;
var
  Index: Integer;
begin
  Index := FocusedAbsoluteIndex;
  if (Index <> -1) and (Index < ColumnCount) then
    Result := Columns[FocusedAbsoluteIndex].Field
  else Result := nil;
end;

function TCustomdxDBTreeListControl.GetSortedColumn: TdxDBTreeListColumn;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to ColumnCount - 1 do
    if Columns[I].GroupIndex = -1 then
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

function TCustomdxDBTreeListControl.GetSortedColumns(Index: Integer): TdxDBTreeListColumn;
begin
  Result := TdxDBTreeListColumn(inherited SortedColumns[Index]);
end;

function TCustomdxDBTreeListControl.GetVisibleColumn(Index: Integer): TdxDBTreeListColumn;
begin
  Result := TdxDBTreeListColumn(inherited VisibleColumns[Index]);
end;

procedure TCustomdxDBTreeListControl.SetColumn(Index: Integer; Value: TdxDBTreeListColumn);
begin
  inherited Columns[Index] := Value;
end;

procedure TCustomdxDBTreeListControl.SetFocusedField(Value: TField);
var
  I: Integer;
begin
  if Value = nil then Exit;
  for I := 0 to GetHeaderAbsoluteCount - 1 do
    if IsHeaderVisible(I) and (Columns[I].Field = Value) then
    begin
      FocusedColumn := GetFocusedVisibleIndex(I);
      Break;
    end;
end;

procedure TCustomdxDBTreeListControl.SetIndicatorWidth(Value: Integer);
begin
  if Value < inherited GetIndicatorWidth then
    Value := inherited GetIndicatorWidth;
  if FIndicatorWidth <> Value then
  begin
    FIndicatorWidth := Value;
    LayoutChanged;
  end;
end;

procedure TCustomdxDBTreeListControl.SetKeyFieldName(const Value: string);
begin
  if FKeyFieldName <> Value then
  begin
    FKeyFieldName := Value;
    LinkActive(DataLink.Active);
  end;
end;

procedure TCustomdxDBTreeListControl.SetPreviewFieldName(const Value: string);
begin
  if FPreviewFieldName <> Value then
  begin
    FPreviewFieldName := Value;
    LinkActive(DataLink.Active);
  end;
end;

procedure TCustomdxDBTreeListControl.SetPreviewMaxLength(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FPreviewMaxLength <> Value then
  begin
    FPreviewMaxLength := Value;
    LayoutChanged;
  end;
end;

procedure TCustomdxDBTreeListControl.SetVisibleColumn(Index: Integer; Value: TdxDBTreeListColumn);
begin
  inherited VisibleColumns[Index] := Value;
end;

procedure TCustomdxDBTreeListControl.WMHScroll(var Message: TWMHScroll);
var
  SI: TScrollInfo;

  function GetColumnLeft(Column: Integer): Integer;
  var
    AAbsoluteIndex, AIndex, BIndex, CCount, RIndex, I: Integer;
    XStart, W: Integer;
  begin
    AAbsoluteIndex := GetFocusedAbsoluteIndex(Column);
    BIndex := GetVisibleBandIndex(GetHeaderBandIndex(AAbsoluteIndex));
    if BIndex = GetBandFixedLeft then
    begin
      Result := 0;
      Exit;
    end;
    RIndex := 0;
    CCount := GetHeaderColCount(BIndex, RIndex);
    XStart := GetStartBandCoord(BIndex);
    for I := 0 to CCount - 1 do
    begin
      AIndex := GetHeaderAbsoluteIndex(BIndex, RIndex, I);
      if AIndex = AAbsoluteIndex then Break;
      W := GetHeaderBoundsWidth(AIndex);
      Inc(XStart, W);
    end;
    Result := XStart;
  end;

  function GetColumnCoordX(X: Integer): Integer;
  var
    AIndex, BIndex, CCount, RIndex, I: Integer;
    XStart, W, B1, B2: Integer;
  begin
    Result := 0;
    // calc band index
    BIndex := 0;
    B1 := 0;
    if GetBandFixedLeft <> -1 then Inc(B1);
    B2 := GetBandCount - 1;
    if GetBandFixedRight <> -1 then Dec(B2);
    for I := B1 to B2 do
    begin
      XStart := GetStartBandCoord(I);
      W := GetBandWidth(I) + Byte(I = 0) * GetIndentWidth;
      if (XStart <= X) and (X < (XStart + W)) then
      begin
        BIndex := I;
        Break;
      end;
    end;
    // calc column index
    RIndex := 0;
    XStart := GetStartBandCoord(BIndex);
    CCount := GetHeaderColCount(BIndex, RIndex);
    for I := 0 to CCount - 1 do
    begin
      AIndex := GetHeaderAbsoluteIndex(BIndex, RIndex, I);
      W := GetHeaderBoundsWidth(AIndex);
      if (XStart <= X) and (X < (XStart + W)) then
      begin
        Result := GetFocusedVisibleIndex(AIndex);
        Break;
      end;
      Inc(XStart, W);
    end;
  end;

  function GetNearestColumn(Column: Integer; LeftFlag: Boolean): Integer;
  var
    BIndex, CIndex, CCount, RIndex: Integer;
  begin
    RIndex := 0;
    BIndex := GetBandCount - 1;
    while (BIndex > 0) and (GetHeaderColCount(BIndex, RIndex) <= 0) do
      Dec(BIndex);
    CCount := GetHeaderColCount(BIndex, RIndex);
    CIndex := GetFocusedVisibleIndex(GetHeaderAbsoluteIndex(BIndex, RIndex, CCount - 1));
    if LeftFlag then Column := Column - 1
    else Column := Column + 1;
    if Column < 0 then Column := 0;
    if Column >= CIndex then Column := CIndex;
    Result := Column;
  end;

  function GetLeft(Column: Integer): Integer;
  begin
    if Column >= GetVisibleHeaderCount then
      Result := GetScrollableBandWidth
    else Result := GetColumnLeft(Column);
  end;

begin
  if not AcquireFocus or (GetVisibleHeaderCount = 0) then Exit;
  with Message do
  begin
    if ScrollCode in [SB_LINEUP, SB_LINEDOWN, SB_THUMBTRACK, SB_THUMBPOSITION] then
    begin
      case ScrollCode of
        SB_LINEUP: LeftCoord := GetLeft(GetNearestColumn(GetColumnCoordX(LeftCoord), True));
        SB_LINEDOWN: LeftCoord := GetLeft(GetNearestColumn(GetColumnCoordX(LeftCoord), False));
        SB_THUMBTRACK,
        SB_THUMBPOSITION:
          begin
             SI.cbSize := SizeOf(SI);
             SI.fMask := SIF_ALL;
             GetScrollInfo(SB_HORZ, SI);
             if SI.nTrackPos <= 0 then LeftCoord := 0
             else if SI.nTrackPos >= GetScrollableBandWidth then LeftCoord := GetScrollableBandWidth
             else if SI.nTrackPos <> LeftCoord then
               LeftCoord := GetLeft(GetNearestColumn(GetColumnCoordX(SI.nTrackPos),
                                          (SI.nTrackPos + GetScrollableWidth) < (GetScrollableBandWidth div 2)));
          end;
      end;
    end
    else
      inherited;
  end;
end;

procedure TCustomdxDBTreeListControl.CMExit(var Message: TMessage);
begin
  FCanceling := True;
  try
    try
      if Datalink.Active then
        with Datalink.Dataset do
          if  IsCancelOnExit and (State = dsInsert) and
            not Modified and not Datalink.IsModified then
          begin
  //          CancelEditor;
            Cancel;
          end
          else
            DataLink.UpdateData;
    except
      SetFocus;
      raise;
    end;
    {Redraw Selection}
    if HideSelection and IsMultiSelect and (State = tsEditing)
      and (SelectedCount > 0) then InvalidateSelection;
    inherited;
  finally
    FCanceling := False;
  end;
end;


{TdxDBGridSummaryItem}
procedure TdxDBGridSummaryItem.Assign(Source: TPersistent);
begin
  if Source is TdxDBGridSummaryItem then
  begin
    if Assigned(Collection) then Collection.BeginUpdate;
    try
      ColumnName := TdxDBGridSummaryItem(Source).ColumnName;
      SummaryType := TdxDBGridSummaryItem(Source).SummaryType;
      SummaryField := TdxDBGridSummaryItem(Source).SummaryField;
      SummaryFormat := TdxDBGridSummaryItem(Source).SummaryFormat;
    finally
      if Assigned(Collection) then Collection.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TdxDBGridSummaryItem.GetSummaryItems: TdxDBGridSummaryItems;
begin
  if Assigned(Collection) and (Collection is TdxDBGridSummaryItems) then
    Result := TdxDBGridSummaryItems(Collection)
  else Result := nil;
end;

procedure TdxDBGridSummaryItem.SetColumnName(const Value: string);
begin
  if FColumnName <> Value then
  begin
    FColumnName := Value;
    Changed(False);
  end;
end;

procedure TdxDBGridSummaryItem.SetSummaryField(const Value: string);
begin
  if FSummaryField <> Value then
  begin
    FSummaryField := Value;
    Changed(False);
  end;
end;

procedure TdxDBGridSummaryItem.SetSummaryFormat(const Value: string);
begin
  if FSummaryFormat <> Value then
  begin
    FSummaryFormat := Value;
    Changed(False);
  end;
end;

procedure TdxDBGridSummaryItem.SetSummaryType(Value: TdxSummaryType);
begin
  if FSummaryType <> Value then
  begin
    FSummaryType := Value;
    Changed(False);
  end;
end;

{TdxDBGridSummaryItems}
constructor TdxDBGridSummaryItems.Create(ASummaryGroup: TdxDBGridSummaryGroup; ItemClass: TdxDBGridSummaryItemClass);
begin
  inherited Create(ItemClass);
  FSummaryGroup := ASummaryGroup;
end;

function TdxDBGridSummaryItems.Add: TdxDBGridSummaryItem;
begin
  Result := TdxDBGridSummaryItem(inherited Add);
end;

function TdxDBGridSummaryItems.GetOwner: TPersistent;
begin
  Result := FSummaryGroup;
end;

procedure TdxDBGridSummaryItems.Update(Item: TCollectionItem);
begin
  FSummaryGroup.ChangedGroup;
end;

function TdxDBGridSummaryItems.GetItem(Index: Integer): TdxDBGridSummaryItem;
begin
  Result := TdxDBGridSummaryItem(inherited GetItem(Index));
end;

procedure TdxDBGridSummaryItems.SetItem(Index: Integer; Value: TdxDBGridSummaryItem);
begin
  inherited SetItem(Index, Value);
end;

{TdxDBGridSummaryGroup}
constructor TdxDBGridSummaryGroup.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FSummaryItems := TdxDBGridSummaryItems.Create(Self, TdxDBGridSummaryItem);
end;

destructor TdxDBGridSummaryGroup.Destroy;
begin
  FSummaryItems.Free;
  FSummaryItems := nil;
  inherited Destroy;
end;

procedure TdxDBGridSummaryGroup.Assign(Source: TPersistent);
begin
  if Source is TdxDBGridSummaryGroup then
  begin
    if Assigned(Collection) then Collection.BeginUpdate;
    try
      BeginSummaryText := TdxDBGridSummaryGroup(Source).BeginSummaryText;
      EndSummaryText := TdxDBGridSummaryGroup(Source).EndSummaryText;
      DefaultGroup := TdxDBGridSummaryGroup(Source).DefaultGroup;
      SummaryItems.Assign(TdxDBGridSummaryGroup(Source).SummaryItems);
      Name := TdxDBGridSummaryGroup(Source).Name;
    finally
      if Assigned(Collection) then Collection.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TdxDBGridSummaryGroup.GetSummaryGroups: TdxDBGridSummaryGroups;
begin
  if Assigned(Collection) and (Collection is TdxDBGridSummaryGroups) then
    Result := TdxDBGridSummaryGroups(Collection)
  else Result := nil;
end;

procedure TdxDBGridSummaryGroup.ChangedGroup;
var
  DBTreeListControl: TCustomdxDBTreeListControl;
begin
  if GetSummaryGroups <> nil then
  begin
    DBTreeListControl := GetSummaryGroups.DBTreeListControl;
    if csLoading in DBTreeListControl.ComponentState then Exit;
    DBTreeListControl.LayoutChanged;
  end;
end;

function TdxDBGridSummaryGroup.GetDefaultGroup: Boolean;
begin
  Result := FDefaultGroup;
end;

procedure TdxDBGridSummaryGroup.SetDefaultGroup(Value: Boolean);
var
  SummaryGroups: TdxDBGridSummaryGroups;
  I: Integer;
begin
  // clear default
  if Value then
  begin
    SummaryGroups := GetSummaryGroups;
    if SummaryGroups <> nil then
    with SummaryGroups do
    begin
      for I:= 0 to Count - 1 do
        Items[I].FDefaultGroup := False;
    end;
  end;
  FDefaultGroup := Value;
end;

procedure TdxDBGridSummaryGroup.SetSummaryItems(Value: TdxDBGridSummaryItems);
begin
  SummaryItems.Assign(Value);
end;

procedure TdxDBGridSummaryGroup.SetName(const Value: string);
var
  SummaryGroups: TdxDBGridSummaryGroups;
  Found: Boolean;
  I: Integer;
begin
  // check name
  if (Value = '') then
    InvaliddxTreeListOperation(LoadStr(dxSInvalidGroupName));
  // check duplication
  SummaryGroups := GetSummaryGroups;
  Found := False;
  if SummaryGroups <> nil then
  with SummaryGroups do
  begin
    for I := 0 to Count - 1 do
      if (Items[I] <> Self) and (Items[I].Name = Value) then
      begin
        Found := True;
        Break;
      end;
  end;
  if Found then
    InvaliddxTreeListOperation(LoadStr(dxSInvalidGroupNameDuplicate));
  FName := Value;
  if Assigned(FOnChangeName) then FOnChangeName(Self);
end;

{TdxDBGridSummaryGroups}
constructor TdxDBGridSummaryGroups.Create(ADBTreeListControl: TCustomdxDBTreeListControl; ItemClass: TdxDBGridSummaryGroupClass);
begin
  inherited Create(ItemClass);
  FDBTreeListControl := ADBTreeListControl;
end;

function TdxDBGridSummaryGroups.Add: TdxDBGridSummaryGroup;
var
  I: Integer;
begin
  Result := TdxDBGridSummaryGroup(inherited Add);
  // generate name
  I := Count + 1;
  while I <> -1 do
    try
      Result.Name := FDBTreeListControl.Name + 'SummaryGroup' + IntToStr(I);
      I := -1;
    except
      Inc(I);
    end;
end;

function TdxDBGridSummaryGroups.GetDefaultGroup: TdxDBGridSummaryGroup;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if Items[I].DefaultGroup then
    begin
      Result := Items[I];
      Break;
    end;
end;

function TdxDBGridSummaryGroups.GetOwner: TPersistent;
begin
  Result := FDBTreeListControl;
end;

procedure TdxDBGridSummaryGroups.Update(Item: TCollectionItem);
begin
  if FDBTreeListControl = nil then Exit;
  if not (csLoading in FDBTreeListControl.ComponentState) then
    FDBTreeListControl.FullRefresh;
end;

function TdxDBGridSummaryGroups.GetItem(Index: Integer): TdxDBGridSummaryGroup;
begin
  Result := TdxDBGridSummaryGroup(inherited GetItem(Index));
end;

procedure TdxDBGridSummaryGroups.SetItem(Index: Integer; Value: TdxDBGridSummaryGroup);
begin
  inherited SetItem(Index, Value);
end;

{TdxDBTreeListControlDataLink}
constructor TdxDBTreeListControlDataLink.Create(ADBTreeListControl: TCustomdxDBTreeListControl);
begin
  inherited Create;
  FDBTreeListControl := ADBTreeListControl;
  {$IFDEF DELPHI5}
  VisualControl := True;
  {$ENDIF}
end;

destructor TdxDBTreeListControlDataLink.Destroy;
begin
  ClearMapping;
  inherited Destroy;
end;

function TdxDBTreeListControlDataLink.AddMapping(const FieldName: string): Boolean;
var
  Field: TField;
  NewSize: Integer;
begin
  Result := True;
  Field := DataSet.FindField(FieldName);

  if FFieldCount = FFieldMapSize then
  begin
    NewSize := FFieldMapSize;
    if NewSize = 0 then
      NewSize := 8
    else
      Inc(NewSize, NewSize);
    if (NewSize < FFieldCount) then
      NewSize := FFieldCount + 1;
    if (NewSize > MaxMapSize) then
      NewSize := MaxMapSize;
    ReallocMem(FFieldMap, NewSize * SizeOf(Integer));
    FFieldMapSize := NewSize;
  end;
  if Assigned(Field) then
  begin
    PIntArray(FFieldMap)^[FFieldCount] := Field.Index;
    Field.FreeNotification(FDBTreeListControl);
  end
  else
    PIntArray(FFieldMap)^[FFieldCount] := -1;
  Inc(FFieldCount);
end;

procedure TdxDBTreeListControlDataLink.ClearMapping;
begin
  if FFieldMap <> nil then
  begin
    FreeMem(FFieldMap, FFieldMapSize * SizeOf(Integer));
    FFieldMap := nil;
    FFieldMapSize := 0;
    FFieldCount := 0;
  end;
end;

procedure TdxDBTreeListControlDataLink.Modified;
begin
  FModified := True;
end;

procedure TdxDBTreeListControlDataLink.Reset;
begin
  if FModified then RecordChanged(nil) else Dataset.Cancel;
end;

// protected TdxDBTreeListControlDataLink
function TdxDBTreeListControlDataLink.GetMappedIndex(ColIndex: Integer): Integer;
begin
  if (0 <= ColIndex) and (ColIndex < FFieldCount) then
    Result := PIntArray(FFieldMap)^[ColIndex]
  else Result := -1;
end;

procedure TdxDBTreeListControlDataLink.ActiveChanged;
begin
  FDBTreeListControl.LinkActive(Active);
end;

procedure TdxDBTreeListControlDataLink.DataSetChanged;
begin
  FDBTreeListControl.DataChanged;
  FModified := False;
end;

procedure TdxDBTreeListControlDataLink.DataSetScrolled(Distance: Integer);
begin
  FDBTreeListControl.Scroll(-Distance);
end;

procedure TdxDBTreeListControlDataLink.RecordChanged(Field: TField);
begin
  FDBTreeListControl.RecordChanged(Field);
  FModified := False;
end;

procedure TdxDBTreeListControlDataLink.UpdateData;
begin
  if FModified then FDBTreeListControl.UpdateData;
  FModified := False;
end;

function TdxDBTreeListControlDataLink.GetFields(I: Integer): TField;
begin
  if (0 <= I) and (I < FFieldCount) and (PIntArray(FFieldMap)^[I] >= 0) then
    Result := DataSet.Fields[PIntArray(FFieldMap)^[I]]
  else Result := nil;
end;

{ TdxDBTreeListMaskColumn }
procedure TdxDBTreeListMaskColumn.Assign(Source: TPersistent);
begin
  if Source is TdxDBTreeListMaskColumn then
  begin
    if Assigned(ATreeList) then ATreeList.BeginUpdate;
    try
      inherited Assign(Source);
      EditMask := TdxDBTreeListMaskColumn(Source).EditMask;
      IgnoreMaskBlank := TdxDBTreeListMaskColumn(Source).IgnoreMaskBlank;
    finally
      if Assigned(ATreeList) then ATreeList.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TdxDBTreeListMaskColumn.DefaultEditMask: String;
begin
  if Assigned(Field) then
    Result := Field.EditMask
  else Result := '';
end;

function TdxDBTreeListMaskColumn.GetBlankText: string;
begin
  Result := '';
  if EditMask <> '' then
    Result := FormatMaskText(EditMask, '');
end;

procedure TdxDBTreeListMaskColumn.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FAssignedEditMask := False;
  EditMask := DefaultEditMask;
  FIgnoreMaskBlank := False; 
end;

function TdxDBTreeListMaskColumn.AssignEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant;
begin
  if Assigned(Field) then
  begin
    Field.Text := TdxInplaceDBTreeListMaskEdit(AInplaceEdit).Text;
    Result := Field.Value;
  end
  else
    Result := inherited AssignEditValue(ANode, AInplaceEdit);
end;

function TdxDBTreeListMaskColumn.GetdxInplaceEditClass: TdxInplaceEditClass;
begin
  Result := TdxInplaceDBTreeListMaskEdit;
end;

function TdxDBTreeListMaskColumn.GetEditMask: string;
begin
  if FAssignedEditMask then
    Result := FEditMask
  else Result := DefaultEditMask;
end;

procedure TdxDBTreeListMaskColumn.InitEditProperties(AInplaceEdit: TdxInplaceEdit);
begin
  inherited InitEditProperties(AInplaceEdit);
  if AInplaceEdit is TdxInplaceMaskEdit then
    with TdxInplaceDBTreeListMaskEdit(AInplaceEdit) do
    begin
      EditMask := Self.EditMask;
      IgnoreMaskBlank := Self.IgnoreMaskBlank;
    end;
end;

function TdxDBTreeListMaskColumn.InitEditValue(ANode: TdxTreeListNode; AInplaceEdit: TdxInplaceEdit): Variant;
begin
  if Assigned(Field) then
  begin
    TdxInplaceDBTreeListMaskEdit(AInplaceEdit).Text := Field.Text;
    Result := TdxInplaceDBTreeListMaskEdit(AInplaceEdit).Text;
  end
  else
    Result := inherited InitEditValue(ANode, AInplaceEdit);
end;

function TdxDBTreeListMaskColumn.IsEditMaskStored: Boolean;
begin
  Result := FAssignedEditMask and (FEditMask <> DefaultEditMask);
end;

function TdxDBTreeListMaskColumn.IsEqualValues(const Value: Variant): Boolean;
begin
  if Assigned(Field) and not VarIsEmpty(Value) then
  begin
    if (VarType(Value) = varString) and not IsBlobColumn {TODO Check !!!} then
    begin
      if (Value = GetBlankText) and (Field.Text = '') then
        Result := True
      else
        Result := TrimRight(FormatMaskText(EditMask, Field.Text)) =
          TrimRight(FormatMaskText(EditMask, Value));
    end
    else
      Result := Field.Value = Value
  end
  else
    Result := inherited IsEqualValues(Value);
end;

procedure TdxDBTreeListMaskColumn.SetEditMask(const Value: string);
begin
  if FEditMask <> Value then
  begin
    FEditMask := Value;
    FAssignedEditMask := True;
  end;
end;

{ TCustomdxFilterEdit }
class function TCustomdxFilterEdit.IsInplace: Boolean;
begin
  Result := False;
end;

procedure InitDefaultDBTreeListColumnClasses(Proc: TInitColumnClassProc);
var
  I: TFieldType;
  C: TdxDBTreeListColumnClassInfo;
begin
  for I := ftUnknown to ftTypedBinary do
  begin
    C := DefaultDBTreeListColumnType[I];
    Proc(I, fkData, C);
    if C.Version > DefaultDBTreeListColumnType[I].Version then
      DefaultDBTreeListColumnType[I] := C;
  end;
  C := DefaultDBTreeListLookupColumnType;
  Proc(ftUnknown, fkLookup, C);
  if C.Version > DefaultDBTreeListLookupColumnType.Version then
    DefaultDBTreeListLookupColumnType := C;
end;

procedure ResetDefaultDBTreeListColumnClasses;
var
  I: TFieldType;
begin
  DefaultDBTreeListColumnType[ftUnknown].ColumnClass := nil;
  DefaultDBTreeListColumnType[ftUnknown].Version := 0;
  for I := Succ(ftUnknown) to ftTypedBinary do
  begin
    DefaultDBTreeListColumnType[ftUnknown].ColumnClass := TdxDBTreeListColumn;
    DefaultDBTreeListColumnType[ftUnknown].Version := 0;
  end;
  DefaultDBTreeListLookupColumnType.ColumnClass := TdxDBTreeListColumn;
  DefaultDBTreeListLookupColumnType.Version := 0;
end;

initialization
  Classes.RegisterClasses([TdxDBTreeListColumn, TdxDBTreeListMaskColumn]);

  sdxGrTitleConfirm := LoadStr(dxSTitleWarning);
  sdxGrDeleteRecordQuestion := LoadStr(dxSDeleteRecordQuestion);
  sdxDeleteMultipleRecordsQuestion := LoadStr(dxSDeleteMultipleRecordsQuestion);

end.
