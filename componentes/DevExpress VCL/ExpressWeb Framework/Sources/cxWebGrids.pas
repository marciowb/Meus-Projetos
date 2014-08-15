{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Visual Web Controls Library                                 }
{                                                                   }
{       Copyright (c) 2000-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSWEB FRAMEWORK AND ALL         }
{   ACCOMPANYING VCL CLASSES AS PART OF AN EXECUTABLE WEB           }
{   APPLICATION ONLY.                                               }
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
unit cxWebGrids;

{$I cxVer.inc}

interface

uses   Classes, TypInfo, SysUtils, DB,
  {$IFDEF VCL}
  Graphics,
  {$ENDIF}
  cxWebIntf, cxWebClasses, cxWebControls, cxWebTypes,
  cxWebRender, cxWebImgList, cxWebMenus, cxWebDataUtils;

const
  cxWebGridBitmapHeight = 24;
  cxWebGridBitmapWidth = 16;

  cxWebGridExpandBitmapHeight = 12;
  cxWebGridExpandBitmapWidth = 12;
  cxWebGridSortBitmapHeight = 16;
  cxWebGridSortBitmapWidth = 16;
  cxWebGridGroupBitmapHeight = 13;
  cxWebGridGroupBitmapWidth = 15;

  cxWebGridMinGroupPanelHeight = 30;
  cxWebGridMinHeaderHeight = 26;
  cxWebGridMinStatusPanelHeight = 20;
  cxWebGridMinIndicatorWidth = 18;

  cxWebGridGroupPanelInterval = 10;
  cxWebGridGroupPanelNodeWidth = 100;

type
  TcxWebColumn = class;
  TcxCustomWebGrid = class;

  TcxWebColumnHelper = class
  private
    FColumn: TcxWebColumn;
    function GetWebGrid: TcxCustomWebGrid;

    function DefualtStyle(ARowIndex: Integer): TcxWebStyleItem;
    function HoverStyle(ARowIndex: Integer): TcxWebStyleItem;
    procedure SetDefaultStyleProc(var AScript: string);
    procedure SetHoverStyleProc(ARowIndex: Integer; var AScript: string);
    procedure WriteComponentEvents(HTMLTextBuilder: TcxHTMLTextBuilder; ARowIndex: Integer);
  protected
    function CanGetValue: Boolean; virtual;
    function GetValue: Variant; virtual;
    function GetScriptClass: string; virtual;
    procedure WriteCellHTML(HTMLTextBuilder: TcxHTMLTextBuilder; ARowIndex: Integer;
        IsEditing: Boolean); virtual;
    procedure WriteCellInterior(HTMLTextBuilder: TcxHTMLTextBuilder; ARowIndex: Integer;
        IsEditing: Boolean); virtual;
    procedure WriteCellText(HTMLTextBuilder: TcxHTMLTextBuilder; ARowIndex: Integer;
        AText: string); virtual;
    procedure WriteScript(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;
  public
    constructor Create(AColumn: TcxWebColumn);
    property Column: TcxWebColumn read FColumn;
    property WebGrid: TcxCustomWebGrid read GetWebGrid;
  end;
  TcxWebColumnHelperClass = class of TcxWebColumnHelper;

  TcxWebTextColumnHelper = class(TcxWebColumnHelper)
  protected
    function GetScriptClass: string; override;
    procedure WriteCellInterior(HTMLTextBuilder: TcxHTMLTextBuilder; ARowIndex: Integer;
        IsEditing: Boolean); override;
    function GetValue: Variant; override;
  end;

  TcxWebHyperTextColumnHelper = class(TcxWebTextColumnHelper)
  protected
    function CanGetValue: Boolean; override;
    function GetScriptClass: string; override;
    procedure WriteCellInterior(HTMLTextBuilder: TcxHTMLTextBuilder; ARowIndex: Integer;
        IsEditing: Boolean); override;
  end;

  TcxWebListColumnHelper = class(TcxWebColumnHelper)
  protected
    function GetValue: Variant; override;
    function GetScriptClass: string; override;
    procedure WriteScriptValues(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;
    procedure WriteValues(HTMLTextBuilder: TcxHTMLTextBuilder; AText: string); virtual;
    procedure WriteCellInterior(HTMLTextBuilder: TcxHTMLTextBuilder; ARowIndex: Integer;
        IsEditing: Boolean); override;
    procedure WriteScript(HTMLTextBuilder: TcxHTMLTextBuilder); override;
  end;

  TcxWebCheckColumnHelper = class(TcxWebColumnHelper)
  protected
    function GetValue: Variant; override;
    function GetScriptClass: string; override;
    procedure WriteCellInterior(HTMLTextBuilder: TcxHTMLTextBuilder; ARowIndex: Integer;
        IsEditing: Boolean); override;
    procedure WriteScript(HTMLTextBuilder: TcxHTMLTextBuilder); override;
  end;

  TcxWebImageColumnHelper = class(TcxWebColumnHelper)
  protected
    function CanGetValue: Boolean; override;
    function GetScriptClass: string; override;
    procedure WriteCellInterior(HTMLTextBuilder: TcxHTMLTextBuilder; ARowIndex: Integer;
        IsEditing: Boolean); override;
    procedure WriteScript(HTMLTextBuilder: TcxHTMLTextBuilder); override;
  end;

  TcxWebColumnViewType = (cvtText, cvtHyperText, cvtImage, cvtList, cvtLookup, cvtCheck);
  TcxWebGridSortMode = (smNone, smAscending, smDescending);
  TcxWebGridHeaderArrows = (arUp, arDown);
  TcxWebGridButtons = (gbNode, gbDelete, gbInsert, gbPost, gbCancel, gbCursor, gbExpand, gbCollapse);

  TcxLoadImageEvent = procedure(Sender: TObject{$IFDEF VCL}; var GraphicClass: TGraphicClass{$ENDIF}) of object;
  TcxGetURLEvent = procedure(Sender: TObject; ARowIndex: Integer; URL: TcxURL) of object;
  TcxGetTextEvent = procedure(Sender: TObject; ARowIndex: Integer; var Text: string) of object;
  TcxGetValueEvent = procedure(Sender: TObject; ARowIndex: Integer; var Value: Variant) of object;

  TcxWebColumnUndefinedValueState = (uvsChecked, uvsUnchecked);

  TcxWebColumnClass = class of TcxWebColumn;
  TcxWebColumn = class(TComponent, IcxWebValues, IcxWebProvidersSupport)
  private
    FAlignment: TcxWebHorzAlignment;
    FAlternatingStyles: TcxWebStyles;
    FCheckedValue: string;
    FCellHint: string;
    FColumnHelper: TcxWebColumnHelper;
    FEditValue: Variant;
    FHeaderHint: string;
    FIndex: Integer;
    FMinWidth: Integer;
    FPopupMenu: TcxWebPopupMenu;
    FPossibleValues: TStrings;
    FReadOnly: Boolean;
    FShowCellHint: Boolean;
    FShowHeaderHint: Boolean;
    FStyles: TcxWebStyles;
    FTitle: string;
    FUncheckedValue: string;
    FUndefinedValuesState: TcxWebColumnUndefinedValueState;
    FVAlignment: TcxWebVertAlignment;
    FViewType: TcxWebColumnViewType;
    FVisible: Boolean;
    FWebGrid: TcxCustomWebGrid;
    FWebValuesHelper: TcxWebValuesHelper;
    FWidth: Integer;
    FWordWrap: Boolean;
    FOnGetHref: TcxGetURLEvent;
    FOnGetText: TcxGetTextEvent;
    FOnGetValue: TcxGetValueEvent;
    FOnLoadImage: TcxLoadImageEvent;

    function GetAlternatingStyles: TcxWebStyles;
    function GetGroupingIndex: Integer;
    function GetIndex: Integer;
    function GetReadOnly: Boolean;
    function GetSortingOrder: TcxWebGridSortMode;
    function GetStyles: TcxWebStyles;
    procedure SetAlignment(AValue: TcxWebHorzAlignment);
    procedure SetAlternatingStyles(AValue: TcxWebStyles);
    procedure SetIndex(Value: Integer);
    procedure SetMinWidth(AValue: Integer);
    procedure SetPopupMenu(AValue: TcxWebPopupMenu);
    procedure SetPossibleValues(AValue: TStrings);
    procedure SetReadOnly(Value: Boolean);
    procedure SetStyles(AValue: TcxWebStyles);
    procedure SetTitle(AValue: string);
    procedure SetVAlignment(AValue: TcxWebVertAlignment);
    procedure SetViewType(AValue: TcxWebColumnViewType);
    procedure SetVisible(AValue: Boolean);
    procedure SetWidth(AValue: Integer);
    procedure SetWordWrap(AValue: Boolean);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ReadState(Reader: TReader); override;
    procedure SetName(const NewName: TComponentName); override;
    procedure SetParentComponent(AParent: TComponent); override;
    { IcxWebProvidersSupport}
    procedure GetProviders(AList: TList);
    { designer support }
    procedure DesignerUpdate(TheAll: Boolean);
    { html }
    procedure WriteCellHTML(HTMLTextBuilder: TcxHTMLTextBuilder; ARowIndex: Integer; IsEditing: Boolean); virtual;
    procedure WriteScript(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;
    { values }
    function CanSetValues: Boolean; virtual;
    procedure DoAfterSetValues; virtual;
    procedure DoSetValues; virtual;
    procedure RegisterValues; virtual;
    function GetWebValuesHelper: TcxWebValuesHelper; virtual;
    property WebValuesHelper: TcxWebValuesHelper read GetWebValuesHelper implements IcxWebValues;

    function GetWebGrid: TcxCustomWebGrid; overload; virtual;
    procedure SetWebGrid(Value: TcxCustomWebGrid); overload; virtual;

    function GetFieldIndex: Integer; virtual;

    function CreateColumnHelper(HelperClass: TcxWebColumnHelperClass): TcxWebColumnHelper;
    function GetColumnHelper: TcxWebColumnHelper; virtual;
    property ColumnHelper: TcxWebColumnHelper read GetColumnHelper write FColumnHelper;

    property EditValue: Variant read FEditValue;
    property FieldIndex: Integer read GetFieldIndex;
    property GroupingIndex: Integer read GetGroupingIndex;
    property SortingOrder: TcxWebGridSortMode read GetSortingOrder;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;

    function AlternatingColumnStyles: TcxWebStyles;
    function ColumnStyles: TcxWebStyles;
    function GetCellHint(ARowIndex: Integer): string; virtual;
    function GetCellText(ARowIndex: Integer): string; virtual;
    function GetCellValue(ARowIndex: Integer): Variant; virtual;
    function IsVisible: Boolean;
    property WebGrid: TcxCustomWebGrid read GetWebGrid write SetWebGrid;
  published
    property Alignment: TcxWebHorzAlignment read FAlignment write SetAlignment
      default whalCenter;
    property AlternatingStyles: TcxWebStyles read GetAlternatingStyles write SetAlternatingStyles;
    property CellHint: string read FCellHint write FCellHint;
    property CheckedValue: string read FCheckedValue write FCheckedValue;
    property HeaderHint: string read FHeaderHint write FHeaderHint;
    property Index: Integer read GetIndex write SetIndex stored False;
    property MinWidth: Integer read FMinWidth write SetMinWidth
      default 150;
    property PopupMenu: TcxWebPopupMenu read FPopupMenu write SetPopupMenu;
    property PossibleValues: TStrings read FPossibleValues write SetPossibleValues;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly
      default False;
    property ShowCellHint: Boolean read FShowCellHint write FShowCellHint;
    property ShowHeaderHint: Boolean read FShowHeaderHint write FShowHeaderHint;
    property Styles: TcxWebStyles read GetStyles write SetStyles;
    property Title: string read FTitle write SetTitle;
    property VAlignment: TcxWebVertAlignment read FVAlignment write SetVAlignment;
    property ViewType: TcxWebColumnViewType read FViewType write SetViewType
      default cvtText;
    property UncheckedValue: string read FUncheckedValue write FUncheckedValue;
    property UndefinedValuesState: TcxWebColumnUndefinedValueState read FUndefinedValuesState
        write FUndefinedValuesState;
    property Visible: Boolean read FVisible write SetVisible
      default True;
    property Width: Integer read FWidth write SetWidth;
    property WordWrap: Boolean read FWordWrap write SetWordWrap;

    property OnGetHref: TcxGetURLEvent read FOnGetHref write FOnGetHref;
    property OnGetText: TcxGetTextEvent read FOnGetText write FOnGetText;
    property OnGetValue: TcxGetValueEvent read FOnGetValue write FOnGetValue;
    property OnLoadImage: TcxLoadImageEvent read FOnLoadImage write FOnLoadImage;
  end;

  TAbstractcxCustomWebGridDesigner = class
  private
    FWebGrid: TcxCustomWebGrid;
  protected
    procedure Modified; virtual; abstract;
    procedure Update(AColumn: TcxWebColumn); virtual; abstract;
  public
    constructor Create(AWebGrid: TcxCustomWebGrid);
    destructor Destroy; override;

    procedure BeginUpdate; virtual; abstract;
    procedure CancelUpdate; virtual; abstract;
    procedure EndUpdate; virtual; abstract;

    property WebGrid: TcxCustomWebGrid read FWebGrid;
  end;

  TcxWebGridEvent = (geOnRowClick, geOnHeaderClick,
    geOnStartDragHeader, geOnEndDragHeader,
    geOnIndicatorClick, geOnExpandButtonClick,
    geOnGetColumnText, geOnGetColumnHref);

  TcxWebGridEventsHelper = class(TcxWebScriptEventsHelper)
  protected
    function EventName(const AEvent: Integer): string; override;
    function EventProcParams(const AEvent: Integer): string; override;
    function ScriptObject: string; override;
  public
    function EventTypeInfo: PTypeInfo; override;
  end;

  TcxIndicatorType = (itCursor, itDataOp);
  TcxWebGridMode = (mBrowse, mEdit);

  TcxWebGridImageIndexes = class(TPersistent)
  private
    FNode: Integer;
    FDelete: Integer;
    FInsert: Integer;
    FPost: Integer;
    FCancel: Integer;
    FCursor: Integer;
    FExpand: Integer;
    FCollapse: Integer;
  public
    constructor Create; virtual;
  published
    property Node: Integer read FNode write FNode default -1;
    property Delete: Integer read FDelete write FDelete default -1;
    property Insert: Integer read FInsert write FInsert default -1;
    property Post: Integer read FPost write FPost default -1;
    property Cancel: Integer read FCancel write FCancel default -1;
    property Cursor: Integer read FCursor write FCursor default -1;
    property Expand: Integer read FExpand write FExpand default -1;
    property Collapse: Integer read FCollapse write FCollapse default -1;
  end;

  TcxCustomWebGrid = class(TcxWebControl, IcxDesignCodeProvider)
  private
    FDesigner: TAbstractcxCustomWebGridDesigner;
    FColumns: TList;

    FAutoWidth: Boolean;
    FBorderWidth: Integer;
    FBorderColor: TcxWebColor;
    FEditMode: Boolean;
    FDesignerUpdateLock: Integer;
    FImages: TcxWebImageList;
    FImageIndexes: TcxWebGridImageIndexes;
    FIndicatorPopupMenu: TcxWebPopupMenu;
    FIndicatorStyles: TcxWebStyles;
    FIndicatorType: TcxIndicatorType;
    FIndicatorWidth: Integer;
    FFirstVisibleRow: Integer;
    FHeaderHeight: Integer;
    FHeaderPopupMenu: TcxWebPopupMenu;
    FHeaderStyles: TcxWebStyles;
    FGroupNodesPopupMenu: TcxWebPopupMenu;
    FGroupNodesStyles: TcxWebStyles;
    FGroupPanelHeight: Integer;
    FGroupPanelPopupMenu: TcxWebPopupMenu;
    FGroupPanelStyles: TcxWebStyles;
    FKeepRowHeight: Boolean;
    FKeepPageSize: Boolean;
    FLockCount: Integer;
    FPageSize: Integer;
    FReadOnly: Boolean;
    FRowHeight: Integer;
    FSelectedColor: TcxWebColor;
    FSelectedFontColor: TcxWebColor;
    FShowGrid: Boolean;
    FShowGroupedColumns: Boolean;
    FShowGroupPanel: Boolean;
    FShowHeader: Boolean;
    FShowIndicator: Boolean;
    FShowStatusPanel: Boolean;
    FStatusPanelHeight: Integer;
    FStatusPanelPopupMenu: TcxWebPopupMenu;
    FStatusPanelStyles: TcxWebStyles;

    function GetBordersCount: Integer;
    function GetColumnCount: Integer;
    function GetFirstVisibleColumnIndex: Integer;
    function GetIndicatorStyles: TcxWebStyles;
    function GetIndicatorType: TcxIndicatorType;
    function GetHeaderStyles: TcxWebStyles;
    function GetGroupNodesStyles: TcxWebStyles;
    function GetGroupPanelStyles: TcxWebStyles;
    function GetLastVisibleRowIndex: Integer;
    function GetLastVisibleColumnIndex: Integer;
    function GetStatusPanelStyles: TcxWebStyles;
    function GetStatusPanelText: string;
    function GetVisibleColumnsCount: Integer;
    procedure SetAutoWidth(AValue: Boolean);
    procedure SetBorderWidth(AValue : Integer);
    procedure SetBorderColor(AValue : TcxWebColor);
    procedure SetImages(Value: TcxWebImageList);
    procedure SetIndicatorPopupMenu(AValue: TcxWebPopupMenu);
    procedure SetIndicatorStyles(AValue: TcxWebStyles);
    procedure SetIndicatorType(Value: TcxIndicatorType);
    procedure SetIndicatorWidth(Value: Integer);
    procedure SetHeaderHeight(AValue: Integer);
    procedure SetHeaderPopupMenu(AValue: TcxWebPopupMenu);
    procedure SetHeaderStyles(AValue: TcxWebStyles);
    procedure SetGroupNodesPopupMenu(AValue: TcxWebPopupMenu);
    procedure SetGroupNodesStyles(AValue: TcxWebStyles);
    procedure SetGroupPanelHeight(AValue: Integer);
    procedure SetGroupPanelPopupMenu(AValue: TcxWebPopupMenu);
    procedure SetGroupPanelStyles(AValue: TcxWebStyles);
    procedure SetKeepRowHeight(AValue: Boolean);
    procedure SetPageSize(AValue: Integer);
    procedure SetRowHeight(AValue: Integer);
    procedure SetSelectedColor(AValue : TcxWebColor);
    procedure SetSelectedFontColor(AValue : TcxWebColor);
    procedure SetShowGrid(AValue: Boolean);
    procedure SetShowGroupedColumns(AValue: Boolean);
    procedure SetShowGroupPanel(AValue: Boolean);
    procedure SetShowHeader(AValue: Boolean);
    procedure SetShowIndicator(AValue: Boolean);
    procedure SetShowStatusPanel(AValue: Boolean);
    procedure SetStatusPanelHeight(AValue: Integer);
    procedure SetStatusPanelPopupMenu(AValue: TcxWebPopupMenu);
    procedure SetStatusPanelStyles(AValue: TcxWebStyles);
    { Columns operations }
    procedure InsertColumn(Value: TcxWebColumn);
    procedure MoveColumn(ACurIndex, ANewIndex: Integer);
    procedure RemoveColumn(Value: TcxWebColumn);

    function GetHeaderColumnWidth(AColumnIndex: Integer): Integer;
    function GetExpandingLevel: Integer;
    function GetExpandingColumnCount: Integer;
    function IsVisibleRow(ARowIndex: Integer): Boolean;
    function IsVisibleColumn(AItemIndex: Integer): Boolean;
  protected
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetName(const NewName: TComponentName); override;
    function UniqueColumnName(Column: TcxWebColumn): string;
    { Persistent }
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadFirstVisibleRow(Reader: TReader); virtual;
    procedure WriteFirstVisibleRow(Writer: TWriter); virtual;
    { IcxWebProvidersSupport}
    procedure ImplGetProviders(AList: TList); override;
    { Columns layout }
    function GetColumn(Index: Integer): TcxWebColumn; overload; virtual;
    procedure SetColumn(Index: Integer; Value: TcxWebColumn); overload; virtual;
    procedure AdjustWebGridWidth;
    procedure ChangeColumnsLayout(Index: Integer);
    { Size Correction }
    procedure RefreshPageSize; virtual;
    procedure RefreshHeight; virtual;
    function ShownHeaderHeight: Integer; virtual;
    function ShownGroupPanelHeight: Integer; virtual;
    function ShownStatusPanelHeight: Integer; virtual;
    function ShownIndicatorWidth: Integer; virtual;
    function GetMaxHeight: Integer; override;
    function GetMinHeight: Integer; override;
    function GetMaxWidth: Integer; override;
    function GetMinWidth: Integer; override;
    function NeedCorrectHeight: Boolean; virtual;
    { Designer Notification }
    procedure DesignerModified;
    procedure DesignerColumnUpdate(AColumn: TcxWebColumn);
    procedure StyleChanged(Style: TcxWebStyleItem); override;
    { events }
    function GetWebEventsHelper: TcxWebGridEventsHelper;
    class function GetWebEventsHelperClass: TcxWebEventsHelperClass; override;
    property WebEventsHelper: TcxWebGridEventsHelper read GetWebEventsHelper;
    { values }
    procedure DoSetValues; override;
    procedure RegisterValues; override;
    { renderers }
    procedure RegisterRenderers; override;
    { IcxDsgnCodeProvider}
    procedure WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
    function GetRendererClass: TcxWebRendererClass;
    { Scripts }
    procedure ScriptsSubscription; override;

    property EditMode: Boolean read FEditMode;
    property LastVisibleRowIndex: Integer read GetLastVisibleRowIndex;
    property FirstVisibleColumnIndex: Integer read GetFirstVisibleColumnIndex;
    property LastVisibleColumnIndex: Integer read GetLastVisibleColumnIndex;
    property LockCount: Integer read FLockCount write FLockCount;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { Columns }
    function Add: TcxWebColumn; virtual;
    procedure AssignItems(ASource: TcxCustomWebGrid);
    procedure Clear;
    procedure Delete(AIndex: Integer);
    procedure GetColumnList(const AList: TList);
    function IndexOf(AItem: TcxWebColumn): Integer;
    function ColumnByName(const AName: string): TcxWebColumn; overload; virtual;
    function CanCreateDefaultColumns: Boolean; virtual;
    procedure CreateDefaultColumns(ADeleteExistColumns: Boolean); virtual;
    { Data }
    function Mode: TcxWebGridMode; virtual;
    function AllowExpanding: Boolean; virtual;
    function AllowGrouping: Boolean; virtual;
    function AllowSorting: Boolean; virtual;
    function LoadAllRecords: Boolean; virtual;

    function GetFocusedRow: Integer; virtual;
    function GetRecordCount: Integer; virtual;
    function GetRowCount: Integer; virtual;
    function GetDisplayText(ARecordIndex, AColIndex: Integer): string; virtual;
    function GetValue(ARecordIndex, AColIndex: Integer): Variant; virtual;
    function GetRowDisplayText(ARowIndex, AColIndex: Integer): string; virtual;
    function GetRowValue(ARowIndex, AColIndex: Integer): Variant; virtual;
    function GetRowExpanded(RowIndex: Integer): Boolean; virtual;
    function GetRowLevel(RowIndex: Integer): Integer; virtual;
    function GetRowRecord(RowIndex: Integer): Integer; virtual;
    function GetGroupingItemCount: Integer; virtual;
    function GetSortingItemCount: Integer; virtual;
    function GetItemGroupIndex(AColIndex: Integer): Integer; virtual;
    function GetItemSortOrder(AColIndex: Integer): TcxWebGridSortMode; virtual;
    function GetSortingItemIndex(Item: Integer): Integer; virtual;
    function GetGroupingItemIndex(Item: Integer): Integer; virtual;
    { Data and column layout notification }
    procedure BeginUpdateLayout;
    procedure EndUpdateLayout;
    procedure UpdateColumnsLayout;
    { Size }
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;

    property Columns[Index: Integer]: TcxWebColumn read GetColumn write SetColumn;
    property ColumnCount: Integer read GetColumnCount;
    property Designer: TAbstractcxCustomWebGridDesigner read FDesigner;
    property FirstVisibleRow: Integer read FFirstVisibleRow write FFirstVisibleRow; // TODO protected
    property FocusedRow: Integer read GetFocusedRow;
    property RecordCount: Integer read GetRecordCount;
    property RowCount: Integer read GetRowCount;
    property StatusPanelText: string read GetStatusPanelText;
    property VisibleColumnsCount: Integer read GetVisibleColumnsCount;
  published
    property AutoWidth: Boolean read FAutoWidth write SetAutoWidth
      default True;
    property BorderWidth: Integer read FBorderWidth write SetBorderWidth;
    property BorderColor: TcxWebColor read FBorderColor write SetBorderColor;
    property IndicatorPopupMenu: TcxWebPopupMenu read FIndicatorPopupMenu write SetIndicatorPopupMenu;
    property IndicatorStyles: TcxWebStyles read GetIndicatorStyles write SetIndicatorStyles;
    property IndicatorType: TcxIndicatorType read GetIndicatorType write SetIndicatorType
      default itDataOp;
    property IndicatorWidth: Integer read FIndicatorWidth write SetIndicatorWidth;
    property HeaderHeight: Integer read FHeaderHeight write SetHeaderHeight
      default 30;
    property HeaderPopupMenu: TcxWebPopupMenu read FHeaderPopupMenu write SetHeaderPopupMenu;
    property HeaderStyles: TcxWebStyles read GetHeaderStyles write SetHeaderStyles;
    property Height;
    property GroupNodesPopupMenu: TcxWebPopupMenu read FGroupNodesPopupMenu write SetGroupNodesPopupMenu;
    property GroupNodesStyles: TcxWebStyles read GetGroupNodesStyles write SetGroupNodesStyles;
    property GroupPanelHeight: Integer read FGroupPanelHeight write SetGroupPanelHeight
      default 40;
    property GroupPanelPopupMenu: TcxWebPopupMenu read FGroupPanelPopupMenu write SetGroupPanelPopupMenu;
    property GroupPanelStyles: TcxWebStyles read GetGroupPanelStyles write SetGroupPanelStyles;
    property Images: TcxWebImageList read FImages write SetImages;
    property ImageIndexes: TcxWebGridImageIndexes read FImageIndexes write FImageIndexes;
    property KeepRowHeight: Boolean read FKeepRowHeight write SetKeepRowHeight default True;
    property KeepPageSize: Boolean read FKeepPageSize write FKeepPageSize;
    property PageSize: Integer read FPageSize write SetPageSize;
    property PopupShowingType;    
    property ReadOnly: Boolean read FReadOnly write FReadOnly;
    property RowHeight: Integer read FRowHeight write SetRowHeight;
    property SelectedColor: TcxWebColor read FSelectedColor write SetSelectedColor;
    property SelectedFontColor: TcxWebColor read FSelectedFontColor write SetSelectedFontColor;
    property ShowGrid: Boolean read FShowGrid write SetShowGrid
      default True;
    property ShowGroupedColumns: Boolean read FShowGroupedColumns write SetShowGroupedColumns;
    property ShowGroupPanel: Boolean read FShowGroupPanel write SetShowGroupPanel
      default True;
    property ShowHeader: Boolean read FShowHeader write SetShowHeader
      default True;
    property ShowIndicator: Boolean read FShowIndicator write SetShowIndicator
      default True;
    property ShowStatusPanel: Boolean read FShowStatusPanel write SetShowStatusPanel
      default True;
    property StatusPanelHeight: Integer read FStatusPanelHeight write SetStatusPanelHeight
      default 20;
    property StatusPanelPopupMenu: TcxWebPopupMenu read FStatusPanelPopupMenu write SetStatusPanelPopupMenu;
    property StatusPanelStyles: TcxWebStyles read GetStatusPanelStyles write SetStatusPanelStyles;
    property Styles;
    property Width;
  end;

  TcxWebGridDragHeaderStyle = class(TcxInternalWebStyle)
    class function GetName: string; override;
    class procedure WriteStyle(HTMLTextBuilder: TcxHTMLTextBuilder); override;
  end;

  TcxWebGridGroupNodesStyle = class(TcxInternalWebStyle)
    class function GetName: string; override;
    class procedure WriteStyle(HTMLTextBuilder: TcxHTMLTextBuilder); override;
  end;

  TcxWebGridPanelsStyle = class(TcxInternalWebStyle)
    class function GetName: string; override;
    class procedure WriteStyle(HTMLTextBuilder: TcxHTMLTextBuilder); override;
  end;

  TcxWebGridButtonStyle = class(TcxInternalWebStyle)
    class function GetName: string; override;
    class procedure WriteStyle(HTMLTextBuilder: TcxHTMLTextBuilder); override;
  end;

  TcxCustomWebGridRenderer = class(TcxWebControlRenderer)
  private
    function GetWebGrid: TcxCustomWebGrid;

    function GetExpandImageIndex(ARowIndex: Integer): Integer;
    function GetExpandImageSrc(ARowIndex: Integer): string;
    function GetNodeImageSrc(ARowIndex: Integer): string;
    function GetSortImageSrc(AItemIndex: Integer): string;
    function IsDesigning: Boolean;
  protected
    procedure WriteComponentEvents(AStyle: TcxWebStyleItem; AMenu: TcxWebPopupMenu);
    { Grid styles }
    function ColumnDefaultStyle(Index, ARowIndex: Integer): TcxWebStyleItem; virtual;
    function IndicatorDefaultStyle: TcxWebStyleItem; virtual;
    function HeaderDefaultStyle: TcxWebStyleItem; virtual;
    function GroupNodesDefaultStyle: TcxWebStyleItem; virtual;
    function GroupPanelDefaultStyle: TcxWebStyleItem; virtual;
    function StatusPanelDefaultStyle: TcxWebStyleItem; virtual;
    function ColumnHoverStyle(Index, ARowIndex: Integer): TcxWebStyleItem; virtual;
    function IndicatorHoverStyle: TcxWebStyleItem; virtual;
    function HeaderHoverStyle: TcxWebStyleItem; virtual;
    function GroupNodesHoverStyle: TcxWebStyleItem; virtual;
    function GroupPanelHoverStyle: TcxWebStyleItem; virtual;
    function StatusPanelHoverStyle: TcxWebStyleItem; virtual;

    function IsIndicatorCursorType: Boolean; virtual;
    function GetHorizBordersWidth: Integer; virtual;
    function GetVertBordersWidth: Integer; virtual;
    procedure WriteNodeHandler; virtual;
    procedure WriteGroupNodeHandler; virtual;
    { Buttons render }
    procedure WriteButton(ID, ClassName, Handler, ImageID, ImageSrc, Hint: string;
        ImageIndex, Height, Width: Integer; HoverStyle: TcxWebStyleItem); virtual;
    procedure WriteCancelButton; virtual;
    procedure WriteDeleteButton(ARowIndex: Integer); virtual;
    procedure WriteExpandButton(ARowIndex: Integer); virtual;
    procedure WriteHeaderButton; virtual;
    procedure WriteInsertButton; virtual;
    procedure WriteNodeButton(ARowIndex: Integer); virtual;
    procedure WriteOkButton(ARowIndex: Integer); virtual;
    procedure WriteSortButton(AColumnIndex: Integer); virtual;
    { Cells render }
    procedure WriteCell(AColumnIndex, ARowIndex: Integer; IsEditing: Boolean); virtual;
    { Data frame render }
    procedure WriteDataFrame; virtual;
    { Indicator render }
    procedure WriteIndicatorHeaderCell; virtual;
    procedure WriteIndicatorCell(ARowIndex: Integer); virtual;
    { Header render }
    procedure WriteHeaderCell(ID, ClassName, Cursor, Hint, Handler: string;
        ColumnIndex, Height, Width: Integer; ShowSortImage: Boolean;
        HoverStyle: TcxWebStyleItem); virtual;
    procedure WriteHeaderNode(AColumnIndex: Integer); virtual;
    procedure WriteHeader; virtual;
    { Group nodes render }
    procedure WriteGroupNode(ARowIndex: Integer); virtual;
    procedure WriteGroupNodeExpandingCells(ARowIndex: Integer); virtual;
    { Nodes render }
    procedure WriteEmptyNode(ARowIndex: Integer); virtual;
    procedure WriteNode(ARowIndex: Integer); virtual;
    procedure WriteNodeExpandingCells(ARowIndex: Integer); virtual;
    { Group panel render }
    function IsEmptyGroupPanel: Boolean; virtual;
    procedure WriteGroupingPanelNode(ANodeIndex: Integer); virtual;
    procedure WriteEmptyGroupingPanel; virtual;
    procedure WriteGroupingPanel; virtual;
    { Status panel render}
    procedure WriteStatusPanel; virtual;
    { Default styles }
    function ColumnDefaultStyleName(Index, ARowIndex: Integer): string; virtual;
    function IndicatorDefaultStyleName: string; virtual;
    function HeaderDefaultStyleName: string; virtual;
    function GroupNodesDefaultStyleName: string; virtual;
    function GroupPanelDefaultStyleName: string; virtual;
    function StatusPanelDefaultStyleName: string; virtual;
    { WebGrid Render }
    procedure WriteGrid; virtual;
  public
    class procedure GetScriptFiles(AList: TStrings); override;
    procedure WriteHiddenFormElements; override;
    procedure WriteHTML; override;
    class procedure WriteClassHTML(AHTMLTextBuilder: TcxHTMLTextBuilder); override;
    procedure WriteScripts; override;
    class procedure WriteClassScripts(AHTMLTextBuilder: TcxHTMLTextBuilder); override;
    class procedure WriteStyles(AHTMLTextBuilder: TcxHTMLTextBuilder); override;

    property WebGrid: TcxCustomWebGrid read GetWebGrid;
  end;

  TcxWebGridButtonNS4Style = class(TcxInternalWebStyle)
    class function GetName: string; override;
    class procedure WriteStyle(HTMLTextBuilder: TcxHTMLTextBuilder); override;
  end;

  TcxCustomWebGridNS4Renderer = class(TcxCustomWebGridRenderer)
  protected
    function IsIndicatorCursorType: Boolean; override;
    { Buttons render }
    procedure WriteButton(ID, ClassName, Handler, ImageID, ImageSrc, Hint: string;
        ImageIndex, Height, Width: Integer; HoverStyle: TcxWebStyleItem); override;
    procedure WriteCancelButton; override;
    procedure WriteExpandButton(ARowIndex: Integer); override;
    procedure WriteHeaderButton; override;
    procedure WriteNodeButton(ARowIndex: Integer); override;
    procedure WriteOkButton(ARowIndex: Integer); override;
    { Header render }
    procedure WriteHeaderCell(ID, ClassName, Cursor, Hint, Handler: string;
        ColumnIndex, Height, Width: Integer; ShowSortImage: Boolean;
        HoverStyle: TcxWebStyleItem); override;
    procedure WriteHeaderNode(AColumnIndex: Integer); override;
    procedure WriteHeader; override;
    { Data frame render }
    procedure WriteDataFrame; override;
    { Grouping panel render }
    procedure WriteGroupingPanel; override;
    procedure WriteGroupingPanelNode(ANodeIndex: Integer); override;
    { Status panel render }
    procedure WriteStatusPanel; override;
  public
    class function IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean; override;
    class procedure WriteClassHTML(AHTMLTextBuilder: TcxHTMLTextBuilder); override;
    class procedure WriteStyles(AHTMLTextBuilder: TcxHTMLTextBuilder); override;
    procedure WriteOutOfFormHTML; override;
  end;

  TcxCustomWebGridNS6Renderer = class(TcxCustomWebGridRenderer)
  protected
    procedure WriteNodeHandler; override;
    procedure WriteGroupNodeHandler; override;
    { Buttons render }
    procedure WriteButton(ID, ClassName, Handler, ImageID, ImageSrc, Hint: string;
        ImageIndex, Height, Width: Integer; HoverStyle: TcxWebStyleItem); override;
    { Header render }
    procedure WriteHeaderCell(ID, ClassName, Cursor, Hint, Handler: string;
        ColumnIndex, Height, Width: Integer; ShowSortImage: Boolean;
        HoverStyle: TcxWebStyleItem); override;
    { Group panel render }
    procedure WriteGroupingPanel; override;
  public
    class function IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean; override;
    class procedure WriteClassHTML(AHTMLTextBuilder: TcxHTMLTextBuilder); override;
  end;

  TcxCustomWebGridOperaRenderer = class(TcxCustomWebGridRenderer)
  protected
    function IsIndicatorCursorType: Boolean; override;
    { Buttons render }
    procedure WriteButton(ID, ClassName, Handler, ImageID, ImageSrc, Hint: string;
        ImageIndex, Height, Width: Integer; HoverStyle: TcxWebStyleItem); override;
    { Header render }
    procedure WriteHeaderCell(ID, ClassName, Cursor, Hint, Handler: string;
        ColumnIndex, Height, Width: Integer; ShowSortImage: Boolean;
        HoverStyle: TcxWebStyleItem); override;
  public
    class function IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean; override;
    class procedure WriteClassHTML(AHTMLTextBuilder: TcxHTMLTextBuilder); override;
    procedure WriteOutOfFormHTML; override;
  end;

  TcxWebGridDsgnRenderer = class(TcxCustomWebGridRenderer)
  public
    class procedure WriteClassHTML(AHTMLTextBuilder: TcxHTMLTextBuilder); override;
  end;

implementation

uses
  Math, StrUtils, Variants, DBConsts,
  cxWebScriptFactory, cxWebFileCacheManager, cxWebConsts, cxWebStrs, cxWebUtils,
  cxWebColors, cxWebGraphics;

const
  cxSortingImgs: array[TcxWebGridSortMode] of string =
    (scxgiNoneImageName, scxgiAscendingImageName, scxgiDescendingImageName);
  cxGroupingImgs: array[TcxWebGridHeaderArrows] of string =
    (scxgaUpImageName, scxgaDownImageName);
  cxWebGridButtonImgs: array[TcxWebGridButtons] of string =
    (scxgbNodeImageName, scxgbDeleteImageName, scxgbInsertImageName, scxgbPostImageName,
     scxgbCancelImageName, scxgbCursorImageName, scxgbExpandImageName, scxgbCollapseImageName);

  scxCancelImgID = '_CANCELIMG_'; // Do not localize
  scxDeleteImgID = '_DELETEIMG_'; // Do not localize
  scxExpandImgID = '_EXPANDIMG_'; // Do not localize
  scxInsertImgID = '_INSERTIMG_'; // Do not localize
  scxPostImgID = '_POSTIMG_'; // Do not localize
  scxNodeImgID = '_NODEIMG_'; // Do not localize
  scxSortImgID = '_SORTIMG_'; // Do not localize
  scxCellID = '_TD_'; // Do not localize
  scxNodeID = '_TR_'; // Do not localize
  scxGroupNodeID = '_GTR_'; // Do not localize
  scxHeaderNodeID = '_Header_'; // Do not localize
  scxGroupPanelNodeID = '_GHeader_'; // Do not localize
  scxGroupUpImageID = 'GUpImage'; // Do not localize
  scxGroupDownImageID = 'GDownImage'; // Do not localize
  scxDragNodeID = '_DHeader_'; // Do not localize
  scxCancelBtnID = '_CancelBtn_'; // Do not localize
  scxDeleteBtnID = '_DeleteBtn_'; // Do not localize
  scxExpandBtnID = '_ExpandBtn_'; // Do not localize
  scxHeaderBtnID = '_HeaderBtn_'; // Do not localize
  scxInsertBtnID = '_InsertBtn_'; // Do not localize
  scxNodeBtnID = '_NodeBtn_'; // Do not localize
  scxPostBtnID = '_PostBtn_'; // Do not localize
  scxEditorID= '_Editor_'; // Do not localize
  scxHeaderNodeHandler = 'OnHMDown(%s);'; // Do not localize
  scxDraggingNodeHandler = 'OnDHMUp(%s);'; // Do not localize
  scxGroupPanelNodeHandler = 'OnGHMDown(%s);'; // Do not localize
  scxNodeHandler = 'OnTRCl()'; // Do not localize
  scxGroupNodeHandler = 'OnGTRCl()'; // Do not localize
  scxCancelBtnHandler = 'OnLBCancelCl(%s);'; // Do not localize
  scxCancelBtnNS4Handler = 'OnLBCancelClNS4(%s);'; // Do not localize
  scxDeleteBtnHandler = 'OnLBDelCl(%s);'; // Do not localize
  scxExpandBtnHandler = 'OnEBCl(%s);'; // Do not localize
  scxExpandBtnNS4Handler = 'OnEBClNS4(%s);'; // Do not localize
  scxInsertBtnHandler = 'OnLBInsCl(%s);'; // Do not localize
  scxNodeBtnHandler = 'OnLBNodeCl(%s);'; // Do not localize
  scxNodeBtnNS4Handler = 'OnLBNodeClNS4(%s);'; // Do not localize
  scxPostBtnHandler = 'OnLBOkCl(%s);'; // Do not localize
  scxPostBtnNS4Handler = 'OnLBOkClNS4(%s);'; // Do not localize
  scxKeyPressHandler = 'OnEKPrs();'; // Do not localize

{ TcxWebColumnHelper }

constructor TcxWebColumnHelper.Create(AColumn: TcxWebColumn);
begin
  FColumn := AColumn;
end;

function TcxWebColumnHelper.GetWebGrid: TcxCustomWebGrid;
begin
  Result := Column.WebGrid;
end;

function TcxWebColumnHelper.DefualtStyle(ARowIndex: Integer): TcxWebStyleItem;
begin
  Result := nil;
  if Column <> nil then
  begin
    if (ARowIndex mod 2 = 1) and (Column.AlternatingStyles.Default <> nil) then
      Result := Column.AlternatingStyles.Default
    else Result := Column.Styles.Default;
  end;
  if (Result = nil) and (WebGrid <> nil) then
    Result := WebGrid.Styles.Default;
end;

function TcxWebColumnHelper.HoverStyle(ARowIndex: Integer): TcxWebStyleItem;
begin
  Result := nil;
  if Column <> nil then
  begin
    if (ARowIndex mod 2 = 1) and (Column.AlternatingStyles.Hover <> nil) then
      Result := Column.AlternatingStyles.Hover
    else Result := Column.Styles.Hover;
  end;
  if (Result = nil) and (WebGrid <> nil) then
    Result := WebGrid.Styles.Hover;
end;

procedure TcxWebColumnHelper.SetDefaultStyleProc(var AScript: string);
begin
  AScript := '__ChangeStyle(event, this);';
end;

procedure TcxWebColumnHelper.SetHoverStyleProc(ARowIndex: Integer; var AScript: string);
begin
  if Column.Styles.Hover <> nil then
    AScript := Format('__ChangeStyle(event, this, ''%s'');', [HoverStyle(ARowIndex).FullName])
  else AScript := '';
end;

procedure TcxWebColumnHelper.WriteComponentEvents(HTMLTextBuilder: TcxHTMLTextBuilder;
    ARowIndex: Integer);
var
  MouseOutString, MouseOverString: string;
begin
  if Column.Styles.Hover <> nil then
  begin
    SetHoverStyleProc(ARowIndex, MouseOverString);
    SetDefaultStyleProc(MouseOutString);

    HTMLTextBuilder.WriteEventAttribute(eOnMouseOver, MouseOverString);
    HTMLTextBuilder.WriteEventAttribute(eOnMouseOut, MouseOutString);
  end;
end;

function TcxWebColumnHelper.CanGetValue: Boolean;
begin
  Result := Column.Visible and not Column.ReadOnly;
end;

procedure TcxWebColumnHelper.WriteCellHTML(HTMLTextBuilder: TcxHTMLTextBuilder;
    ARowIndex: Integer; IsEditing: Boolean);
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  if(HTMLTextBuilder.Browser <> TcxWebBrowserNS4) then
  begin
    HTMLTextBuilder.WriteAttribute(aHeight, 100, '%');
    HTMLTextBuilder.WriteAttribute(aWidth, 100, '%');
  end;
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  if DefualtStyle(ARowIndex) <> nil then
    HTMLTextBuilder.WriteAttribute(aClass, DefualtStyle(ARowIndex).FullName);
  HTMLTextBuilder.WriteAttribute(aAlign, cxWebHorzAlignment[Column.Alignment]);
  if not IsEditing then
    HTMLTextBuilder.WriteAttribute(aValign, cxWebVertAlignment[Column.VAlignment]);
  if not Column.WordWrap then
    HTMLTextBuilder.WriteAttribute(aNowrap);
  WriteComponentEvents(HTMLTextBuilder, ARowIndex);

  WriteCellInterior(HTMLTextBuilder, ARowIndex, IsEditing);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
end;

procedure TcxWebColumnHelper.WriteCellInterior(HTMLTextBuilder: TcxHTMLTextBuilder;
    ARowIndex: Integer; IsEditing: Boolean);
begin
  if WebGrid.KeepRowHeight or not Column.WordWrap then
  begin
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv, False, False);
    HTMLTextBuilder.WriteStyleAttribute(saOverflow, 'hidden');
    HTMLTextBuilder.WriteStyleAttribute(saHeight, 100, '%');
    HTMLTextBuilder.WriteStyleAttribute(saWidth, Column.Width - 1, 'px');
  end;
  WriteCellText(HTMLTextBuilder, ARowIndex, Column.GetCellText(ARowIndex));
  if WebGrid.KeepRowHeight or not Column.WordWrap then
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv, False, False);
end;

procedure TcxWebColumnHelper.WriteCellText(HTMLTextBuilder: TcxHTMLTextBuilder;
    ARowIndex: Integer; AText: string);
begin
  if AText = '' then
    AText := AText + '&nbsp;';
  HTMLTextBuilder.WriteText(AText, False, False);
end;

function TcxWebColumnHelper.GetScriptClass: string;
begin
  Result := 'dx_Column';
end;

procedure TcxWebColumnHelper.WriteScript(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
  HTMLTextBuilder.WriteText(Format('  _Column = new %s();', [GetScriptClass]));
  HTMLTextBuilder.WriteText(Format('  _Column.FieldIndex = %d;', [Column.FieldIndex]));
  HTMLTextBuilder.WriteText(Format('  _Column.Title = "%s";', [Column.Title]));
  HTMLTextBuilder.WriteText(Format('  _Column.Visible = %s;', [cxWebUtils.BoolToStr(Column.Visible)]));
  HTMLTextBuilder.WriteText(Format('  _Column.Width = %d;', [Column.Width]));
  HTMLTextBuilder.WriteText(Format('  _Column.MinWidth = %d;', [Column.Width]));
  HTMLTextBuilder.WriteText(Format('  _Column.VAlignment = "%s";', [cxWebVertAlignment[Column.VAlignment]]));
  HTMLTextBuilder.WriteText(Format('  _Column.HAlignment = "%s";', [cxWebHorzAlignment[Column.Alignment]]));
  HTMLTextBuilder.WriteText(Format('  _Column.ReadOnly = %s;', [cxWebUtils.BoolToStr(Column.ReadOnly)]));
  HTMLTextBuilder.WriteText(Format('  _Column.WordWrap = %s;', [cxWebUtils.BoolToStr(Column.WordWrap)]));
  if Column.ShowCellHint then
  begin
    HTMLTextBuilder.WriteText(Format('  _Column.CellHint = "%s";', [Column.CellHint]));
    HTMLTextBuilder.WriteText('  _Column.ShowCellHint = true;');
  end;
  if Column.ShowHeaderHint then
  begin
    HTMLTextBuilder.WriteText(Format('  _Column.HeaderHint = "%s";', [Column.HeaderHint]));
    HTMLTextBuilder.WriteText('  _Column.ShowHeaderHint = true;');
  end;
  if Column.ColumnStyles.Default <> nil then
    HTMLTextBuilder.WriteText(Format('  _Column.DefaultStyle = "%s";',
      [Column.ColumnStyles.Default.FullName]));
  if Column.AlternatingColumnStyles.Default <> nil then
    HTMLTextBuilder.WriteText(Format('  _Column.AltDefaultStyle = "%s";',
      [Column.AlternatingColumnStyles.Default.FullName]));
  HTMLTextBuilder.WriteText('  _Grid.AddColumn(_Column);');
end;

function TcxWebColumnHelper.GetValue: Variant;
begin
  Result := Null;
end;

{ TcxWebTextColumnHelper }

function TcxWebTextColumnHelper.GetScriptClass: string;
begin
  Result := 'dx_TextColumn';
end;

procedure TcxWebTextColumnHelper.WriteCellInterior(HTMLTextBuilder: TcxHTMLTextBuilder;
    ARowIndex: Integer; IsEditing: Boolean);
begin
  if IsEditing then
  begin
    HTMLTextBuilder.WriteSingleTag(TcxHTMLTagInput);
    HTMLTextBuilder.WriteAttribute(aId, WebGrid.Name + scxEditorID + IntToStr(Column.Index));
    HTMLTextBuilder.WriteAttribute(aName, WebGrid.Name + scxEditorID + IntToStr(Column.Index));
    HTMLTextBuilder.WriteAttribute(aType, 'text');
    HTMLTextBuilder.WriteAttribute(aValue, Column.GetCellText(ARowIndex));
    HTMLTextBuilder.WriteEventAttribute(eOnKeyPress, scxKeyPressHandler);
    HTMLTextBuilder.WriteStyleAttribute(saWidth, Column.Width - 1, 'px');
  end
  else inherited;
end;

function TcxWebTextColumnHelper.GetValue: Variant;
var
  EditName: string;
begin
  EditName := Format('%s%s%d', [WebGrid.Name, scxEditorID, Column.Index]);
  Result := Column.WebValuesHelper.Values.Values[EditName];
end;

{ TcxWebHyperTextColumnHelper }

function TcxWebHyperTextColumnHelper.CanGetValue: Boolean;
begin
  Result := True;
end;

function TcxWebHyperTextColumnHelper.GetScriptClass: string;
begin
  Result := 'dx_HyperTextColumn';
end;

procedure TcxWebHyperTextColumnHelper.WriteCellInterior(HTMLTextBuilder: TcxHTMLTextBuilder;
    ARowIndex: Integer; IsEditing: Boolean);
var
  AURL: TcxURL;
begin
  if not IsEditing then
  begin
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagA, False, False);
    if DefualtStyle(ARowIndex) <> nil then
      HTMLTextBuilder.WriteAttribute(aClass, DefualtStyle(ARowIndex).FullName);
    AURL := TcxURL.Create(nil);
    try
      AURL.Href := Column.GetCellText(ARowIndex);
      if Assigned(Column.OnGetHref) then
        Column.OnGetHref(Column, ARowIndex, AURL);
      AURL.Write(HTMLTextBuilder);
    finally
      AURL.Free;
    end;  
    HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, 0, 'px');
    WriteCellText(HTMLTextBuilder, ARowIndex, Column.GetCellText(ARowIndex));
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagA, False, False);
  end
  else inherited;
end;

{ TcxWebListColumnHelper }

procedure TcxWebListColumnHelper.WriteScriptValues(HTMLTextBuilder: TcxHTMLTextBuilder);
var
  I: Integer;
begin
  for I := 0 to Column.PossibleValues.Count - 1 do
  begin
    HTMLTextBuilder.WriteText(Format('    _Column.AddPossibleValue("%s", "%s");',
        [Column.PossibleValues[I], Column.PossibleValues[I]]));
  end;
end;

procedure TcxWebListColumnHelper.WriteValues(HTMLTextBuilder: TcxHTMLTextBuilder;
    AText: string);
var
  I: Integer;
begin
  for I := 0 to Column.PossibleValues.Count - 1 do
  begin
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagOption, True, False);
    HTMLTextBuilder.WriteAttribute(aValue, Column.PossibleValues[I]);
    if AText = Column.PossibleValues[I] then
      HTMLTextBuilder.WriteAttribute(aSelected);
    HTMLTextBuilder.WriteText(Column.PossibleValues[I], False, False);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagOption, False, True);
  end;
end;

procedure TcxWebListColumnHelper.WriteCellInterior(HTMLTextBuilder: TcxHTMLTextBuilder;
    ARowIndex: Integer; IsEditing: Boolean);
begin
  if IsEditing then
  begin
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagSelect);
    HTMLTextBuilder.WriteAttribute(aId, WebGrid.Name + scxEditorID + IntToStr(Column.Index));
    HTMLTextBuilder.WriteAttribute(aName, WebGrid.Name + scxEditorID + IntToStr(Column.Index));
    HTMLTextBuilder.WriteAttribute(aSize, 1);
    HTMLTextBuilder.WriteStyleAttribute(saWidth, Column.Width - 1, 'px');
    HTMLTextBuilder.WriteEventAttribute(eOnKeyPress, scxKeyPressHandler);
    WriteValues(HTMLTextBuilder, Column.GetCellText(ARowIndex));
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagSelect);
  end
  else inherited;
end;

function TcxWebListColumnHelper.GetScriptClass: string;
begin
  Result := 'dx_ListColumn';
end;

procedure TcxWebListColumnHelper.WriteScript(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
  inherited WriteScript(HTMLTextBuilder);
  if WebGrid.LoadAllRecords then WriteScriptValues(HTMLTextBuilder);
end;

function TcxWebListColumnHelper.GetValue: Variant;
var
  EditName: string;
begin
  EditName := Format('%s%s%d', [WebGrid.Name, scxEditorID, Column.Index]);
  Result := Column.WebValuesHelper.Values.Values[EditName];
end;

{ TcxWebCheckColumnHelper }

procedure TcxWebCheckColumnHelper.WriteCellInterior(HTMLTextBuilder: TcxHTMLTextBuilder;
    ARowIndex: Integer; IsEditing: Boolean);
var
  Text: string;
  MinCheckSize: Integer;
begin
  Text := Column.GetCellText(ARowIndex);
  HTMLTextBuilder.WriteSingleTag(TcxHTMLTagInput, False, False);
  if IsEditing then
  begin
    HTMLTextBuilder.WriteAttribute(aId, WebGrid.Name + scxEditorID + IntToStr(Column.Index));
    HTMLTextBuilder.WriteAttribute(aName, WebGrid.Name + scxEditorID + IntToStr(Column.Index));
  end;
  HTMLTextBuilder.WriteAttribute(aType, 'checkbox');
  HTMLTextBuilder.WriteAttribute(aValue, '1');
  if SameText(Text, Column.CheckedValue) or (not SameText(Text, Column.UncheckedValue)
    and (Column.UndefinedValuesState = uvsChecked)) then
    HTMLTextBuilder.WriteAttribute(aChecked);
  if WebGrid.KeepRowHeight then
    MinCheckSize := Min(WebGrid.RowHeight, Column.Width)
  else
    MinCheckSize := Column.Width;
  if MinCheckSize > 13 then
    MinCheckSize := 13;
  HTMLTextBuilder.WriteStyleAttribute(saHeight, MinCheckSize, 'px');
  HTMLTextBuilder.WriteStyleAttribute(saWidth, MinCheckSize, 'px');

  if IsEditing then
    HTMLTextBuilder.WriteEventAttribute(eOnKeyPress, scxKeyPressHandler)
  else
    HTMLTextBuilder.WriteEventAttribute(eOnClick, 'return false;')
end;

function TcxWebCheckColumnHelper.GetScriptClass: string;
begin
  Result := 'dx_CheckColumn';
end;

procedure TcxWebCheckColumnHelper.WriteScript(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
  inherited WriteScript(HTMLTextBuilder);
  HTMLTextBuilder.WriteText(Format('  _Column.CheckedValue = "%s";', [Column.CheckedValue]));
  HTMLTextBuilder.WriteText(Format('  _Column.UncheckedValue = "%s";', [Column.UncheckedValue]));
  if Column.UndefinedValuesState = uvsChecked then
    HTMLTextBuilder.WriteText('  _Column.UncheckedIsDefault = false;');
end;

function TcxWebCheckColumnHelper.GetValue: Variant;
var
  EditName, Value: string;
begin
  EditName := Format('%s%s%d', [WebGrid.Name, scxEditorID, Column.Index]);
  Value := Column.WebValuesHelper.Values.Values[EditName];
  if Value <> '' then
    Result := Column.CheckedValue
  else Result := Column.UncheckedValue;
end;

{ TcxWebImageColumnHelper }

function TcxWebImageColumnHelper.CanGetValue: Boolean;
begin
  Result := False;
end;

procedure TcxWebImageColumnHelper.WriteCellInterior(HTMLTextBuilder: TcxHTMLTextBuilder; ARowIndex: Integer; IsEditing: Boolean);
var
  APictureURL: string;
  ImgHeight, ImgWidth: Integer;
{$IFDEF VCL}
  AGraphicClass: TGraphicClass;
{$ENDIF}  
begin
  {$IFDEF VCL}
  AGraphicClass := nil;
  {$ENDIF}
  if Assigned(Column.OnLoadImage) then
    Column.OnLoadImage(Column{$IFDEF VCL}, AGraphicClass{$ENDIF});
  try
    LoadImage(Column.GetCellValue(ARowIndex), {$IFDEF VCL}AGraphicClass,{$ENDIF} APictureURL, ImgHeight, ImgWidth);

    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv, False, False);
    HTMLTextBuilder.WriteStyleAttribute(saOverflow, 'hidden');
    if IsEditing then
      HTMLTextBuilder.WriteStyleAttribute(saHeight, 100, '%')
    else
      if WebGrid.KeepRowHeight and (ImgHeight > WebGrid.RowHeight) then
        HTMLTextBuilder.WriteStyleAttribute(saHeight, WebGrid.RowHeight, 'px');
    HTMLTextBuilder.WriteStyleAttribute(saWidth, Column.Width, 'px');

    HTMLTextBuilder.WriteSingleTag(TcxHTMLTagImg, False, False);
    HTMLTextBuilder.WriteAttribute(aSrc, APictureURL);
    if IsEditing then
    begin
      if ImgHeight > WebGrid.RowHeight then
        HTMLTextBuilder.WriteAttribute(aHeight, 100, '%');
    end    
    else
    begin
      if WebGrid.KeepRowHeight then
        HTMLTextBuilder.WriteAttribute(aHeight, WebGrid.RowHeight)
      else
        if ImgWidth > Column.Width then
          HTMLTextBuilder.WriteAttribute(aWidth, 100, '%');
    end;              
    HTMLTextBuilder.WriteAttribute(aAlign, 'absmiddle');
    HTMLTextBuilder.WriteAttribute(aHspace, 0);
    HTMLTextBuilder.WriteAttribute(aVspace, 0);
  except
    HTMLTextBuilder.WriteText('[Unable to load image]');
  end;

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv, False, False);
end;

procedure TcxWebImageColumnHelper.WriteScript(HTMLTextBuilder: TcxHTMLTextBuilder);
var
  I, AHeight, AWidth: Integer;
  {$IFDEF VCL}
  AGraphicClass: TGraphicClass;
  {$ENDIF}
  AURL: string;
begin
  inherited WriteScript(HTMLTextBuilder);
  if WebGrid.LoadAllRecords then
    for I := 0 to WebGrid.RecordCount - 1 do
    begin
      {$IFDEF VCL}
      AGraphicClass := nil;
      {$ENDIF}
      if Assigned(Column.OnLoadImage) then
        Column.OnLoadImage(Column{$IFDEF VCL}, AGraphicClass{$ENDIF});
      try
        LoadImage(Column.GetCellValue(I){$IFDEF VCL}, AGraphicClass{$ENDIF}, AURL, AHeight, AWidth);
      except
        AURL := '';
      end;
      HTMLTextBuilder.WriteText(Format('  _Column.AddImage("%s");', [AURL]));
    end;
end;

function TcxWebImageColumnHelper.GetScriptClass: string;
begin
  Result := 'dx_ImageColumn';
end;

{ TcxWebColumn }

constructor TcxWebColumn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FAlignment := whalCenter;
  FCheckedValue := DBConsts.STextTrue;
  FEditValue := Null;
  FMinWidth := 150;
  FPopupMenu := nil;
  FPossibleValues := TStringList.Create;
  FReadOnly := False;
  FShowCellHint := False;
  FShowHeaderHint := False;
  FTitle := Name;
  FUncheckedValue := DBConsts.STextFalse;
  FUndefinedValuesState := uvsUnchecked;
  FVAlignment := wvalCenter;
  FViewType := cvtText;
  FVisible := True;
  FWidth := 150;
  FWordWrap := True;
end;

destructor TcxWebColumn.Destroy;
var
  AWebGrid: TcxCustomWebGrid;
begin
  FreeAndNil(FColumnHelper);
  FreeAndNil(FWebValuesHelper);
    
  FPossibleValues.Free;
  FStyles.Free;
  FAlternatingStyles.Free;
  AWebGrid := WebGrid;
  WebGrid := nil;
  inherited Destroy;
  if not (csDestroying in AWebGrid.ComponentState) then
     AWebGrid.AdjustBounds;
end;

procedure TcxWebColumn.Assign(Source: TPersistent);
begin
  if Source is TcxWebColumn then
    Styles := TcxWebColumn(Source).Styles
  else
  inherited;
end;

function TcxWebColumn.GetParentComponent: TComponent;
begin
  Result := WebGrid;
end;

function TcxWebColumn.HasParent: Boolean;
begin
  HasParent := WebGrid <> nil;
end;

procedure TcxWebColumn.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = WebGrid then
      WebGrid := nil;
    if AComponent = PopupMenu then
      PopupMenu := nil;
    if not (csDestroying in ComponentState) and (AComponent is TcxWebStyleItem) and
      (Styles <> nil) then
        Styles.Notification(AComponent, Operation);
  end;
end;

procedure TcxWebColumn.ReadState(Reader: TReader);
begin
  if Reader.Parent is TcxCustomWebGrid then
    WebGrid := TcxCustomWebGrid(Reader.Parent);
  inherited;
  WebGrid.UpdateColumnsLayout;
end;

procedure TcxWebColumn.SetName(const NewName: TComponentName);
begin
  inherited;
  DesignerUpdate(False);
end;

procedure TcxWebColumn.SetParentComponent(AParent: TComponent);
begin
  inherited;
  if not (csLoading in ComponentState) then
    WebGrid := AParent as TcxCustomWebGrid;
end;

procedure TcxWebColumn.GetProviders(AList: TList);
var
  I: Integer;
  AStyleController: TComponent;
begin
  for I := 0 to Styles.ItemCount - 1 do
  begin
    if Styles.Items[I] <> nil then
    begin
      AStyleController := Styles.Items[I].Controller;
      if AList.IndexOf(AStyleController) < 0 then
        AList.Add(AStyleController);
    end;
  end;
end;

procedure TcxWebColumn.DesignerUpdate(TheAll: Boolean);
begin
  if WebGrid <> nil then
    if TheAll then
      WebGrid.DesignerColumnUpdate(nil)
    else
      WebGrid.DesignerColumnUpdate(Self);
end;

{ html }
procedure TcxWebColumn.WriteCellHTML(HTMLTextBuilder: TcxHTMLTextBuilder; ARowIndex: Integer; IsEditing: Boolean);
begin
  ColumnHelper.WriteCellHTML(HTMLTextBuilder, ARowIndex, IsEditing and not ReadOnly);
end;

procedure TcxWebColumn.WriteScript(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
  ColumnHelper.WriteScript(HTMLTextBuilder);
end;

function TcxWebColumn.GetCellHint(ARowIndex: Integer): string;
begin
  if CellHint = '' then
    Result := WebGrid.GetRowDisplayText(ARowIndex, Index)
  else Result := CellHint;
end;

function TcxWebColumn.GetCellText(ARowIndex: Integer): string;
begin
  Result := WebGrid.GetRowDisplayText(ARowIndex, Index);
  if Assigned(FOnGetText) then
    FOnGetText(Self, ARowIndex, Result);
end;

function TcxWebColumn.GetCellValue(ARowIndex: Integer): Variant;
begin
  Result := WebGrid.GetRowValue(ARowIndex, Index);
  if Assigned(FOnGetValue) then
    FOnGetValue(Self, ARowIndex, Result);
end;

{ values }
function TcxWebColumn.CanSetValues: Boolean;
begin
  Result := ColumnHelper.CanGetValue;
end;

procedure TcxWebColumn.DoAfterSetValues;
begin
end;

procedure TcxWebColumn.DoSetValues;
begin
  FEditValue := ColumnHelper.GetValue;
end;

procedure TcxWebColumn.RegisterValues;
var
  EditName: string;
begin
  if Visible and (not ReadOnly) then
  begin
    EditName := Format('%s%s%d', [WebGrid.Name, scxEditorID, Index]);
    WebValuesHelper.RegisterValue(EditName, '');
  end;
end;

function TcxWebColumn.GetWebValuesHelper: TcxWebValuesHelper;
begin
  if FWebValuesHelper = nil then
    FWebValuesHelper := TcxWebValuesHelper.Create(Self);
  Result := FWebValuesHelper;
end;

function TcxWebColumn.GetFieldIndex: Integer;
begin
  Result := -1;
end;

function TcxWebColumn.GetAlternatingStyles: TcxWebStyles;
begin
  if FAlternatingStyles = nil then
    if WebGrid <> nil then
      FAlternatingStyles := TcxWebStyles.Create(WebGrid);
  Result := FAlternatingStyles;
end;

function TcxWebColumn.GetGroupingIndex: Integer;
begin
  if not (csLoading in ComponentState) then
    Result := WebGrid.GetItemGroupIndex(Index)
  else Result := -1
end;

function TcxWebColumn.GetIndex: Integer;
begin
  if WebGrid <> nil then
    Result := WebGrid.IndexOf(Self)
  else Result := FIndex;
end;

function TcxWebColumn.GetReadOnly: Boolean;
begin
  Result := FReadOnly or ((WebGrid <> nil) and WebGrid.ReadOnly);
end;

function TcxWebColumn.GetSortingOrder: TcxWebGridSortMode;
begin
  if not (csLoading in ComponentState) then
    Result := WebGrid.GetItemSortOrder(Index)
  else Result := smNone;
end;

function TcxWebColumn.GetStyles: TcxWebStyles;
begin
  if FStyles = nil then
    if WebGrid <> nil then
      FStyles := TcxWebStyles.Create(WebGrid);
  Result := FStyles;
end;

procedure TcxWebColumn.SetAlignment(AValue: TcxWebHorzAlignment);
begin
  if FAlignment <> AValue then
  begin
    FAlignment := AValue;
    WebGrid.UpdateDesignerContext;
  end;
end;

procedure TcxWebColumn.SetAlternatingStyles(AValue: TcxWebStyles);
begin
  if AValue is TcxWebStyles then
  begin
    FAlternatingStyles.Assign(AValue);
    WebGrid.UpdateDesignerContext;
  end;
end;

procedure TcxWebColumn.SetIndex(Value: Integer);
var
  CurIndex: Integer;
begin
  if WebGrid = nil then
    Exit;
  if Value < 0 then
    Value := 0;
  if Value > WebGrid.ColumnCount - 1 then
    Value := WebGrid.ColumnCount - 1;
  CurIndex := Index;
  if CurIndex <> Value then
  begin
    FIndex := Value;
    WebGrid.MoveColumn(CurIndex, Value);
  end;
  WebGrid.UpdateDesignerContext;
end;

procedure TcxWebColumn.SetMinWidth(AValue: Integer);
begin
  if FMinWidth <> AValue then
  begin
    FMinWidth := AValue;
    if Width < FMinWidth then
      Width := FMinWidth;
    WebGrid.UpdateDesignerContext;
  end;
end;

procedure TcxWebColumn.SetPopupMenu(AValue: TcxWebPopupMenu);
begin
  if FPopupMenu <> AValue then
  begin
    if FPopupMenu <> nil then
      FPopupMenu.RemoveFreeNotification(Self);
    FPopupMenu := AValue;
    if FPopupMenu <> nil then
      FPopupMenu.FreeNotification(Self);

    WebGrid.UpdateDesignerContext;
  end;
end;

procedure TcxWebColumn.SetPossibleValues(AValue: TStrings);
begin
  FPossibleValues.Assign(AValue);
end;

procedure TcxWebColumn.SetReadOnly(Value: Boolean);
begin
  if FReadOnly <> Value then
  begin
    FReadOnly := Value;
    WebGrid.UpdateDesignerContext;
  end;
end;

procedure TcxWebColumn.SetTitle(AValue: string);
begin
  if FTitle <> AValue then
  begin
    FTitle := AValue;
    WebGrid.UpdateDesignerContext;
  end;
end;

procedure TcxWebColumn.SetVAlignment(AValue: TcxWebVertAlignment);
begin
  if FVAlignment <> AValue then
  begin
    FVAlignment := AValue;
    WebGrid.UpdateDesignerContext;
  end;
end;

procedure TcxWebColumn.SetViewType(AValue: TcxWebColumnViewType);
begin
  if FViewType <> AValue then
  begin
    FreeAndNil(FColumnHelper);
    FViewType := AValue;
    WebGrid.UpdateDesignerContext;
  end;
end;

procedure TcxWebColumn.SetStyles(AValue: TcxWebStyles);
begin
  if AValue is TcxWebStyles then
  begin
    FStyles.Assign(AValue);
    WebGrid.UpdateDesignerContext;
  end;
end;

procedure TcxWebColumn.SetVisible(AValue: Boolean);
begin
  if FVisible <> AValue then
  begin
    if AValue or (GroupingIndex = -1) then
    begin
      FVisible := AValue;
      if not WebGrid.AutoWidth then
        WebGrid.AdjustWebGridWidth
      else
        WebGrid.ChangeColumnsLayout(-1);
      WebGrid.UpdateDesignerContext;
    end;
  end;
end;

procedure TcxWebColumn.SetWidth(AValue: Integer);
var
  I: Integer;
  MaxWidth: Integer;
begin
  if WebGrid = nil then exit;
  if FWidth <> AValue then
  begin
    if AValue < FMinWidth then
      FWidth := FMinWidth
    else FWidth := AValue;

    if not WebGrid.AutoWidth then
      WebGrid.AdjustWebGridWidth
    else
    begin
      if not (csLoading in WebGrid.ComponentState) then
      begin
        MaxWidth := WebGrid.Width - WebGrid.BorderWidth - WebGrid.ShownIndicatorWidth -
          WebGrid.GetExpandingColumnCount * WebGrid.IndicatorWidth;
        for I := 0 to WebGrid.ColumnCount - 1 do
        begin
          if not WebGrid.IsVisibleColumn(I) then continue;

          if WebGrid.Columns[I] <> Self then
            Dec(MaxWidth, WebGrid.Columns[I].MinWidth);
        end;
        if FWidth > MaxWidth then
          FWidth := MaxWidth;
      end;
      WebGrid.ChangeColumnsLayout(Index);
    end;
    WebGrid.UpdateDesignerContext;
  end;
end;

procedure TcxWebColumn.SetWordWrap(AValue: Boolean);
begin
  if FWordWrap <> AValue then
  begin
    FWordWrap := AValue;
    WebGrid.UpdateDesignerContext;
  end;
end;

function TcxWebColumn.ColumnStyles: TcxWebStyles;
begin
  if (Styles.Default <> nil) or (Styles.Hover <> nil) then
    Result := Styles
  else Result := WebGrid.Styles;
end;

function TcxWebColumn.AlternatingColumnStyles: TcxWebStyles;
begin
  if (AlternatingStyles.Default <> nil) or (AlternatingStyles.Hover <> nil) then
    Result := AlternatingStyles
  else Result := ColumnStyles;
end;

function TcxWebColumn.IsVisible: Boolean;
begin
  Result := Visible and (WebGrid.ShowGroupedColumns or (GroupingIndex = -1));
end;

function TcxWebColumn.GetWebGrid: TcxCustomWebGrid;
begin
  Result := FWebGrid;
end;

procedure TcxWebColumn.SetWebGrid(Value: TcxCustomWebGrid);
begin
  if FWebGrid <> Value then
  begin
    if FWebGrid <> nil then
      FWebGrid.RemoveColumn(Self);
    if Value <> nil then
      Value.InsertColumn(Self);
  end;
end;

function TcxWebColumn.CreateColumnHelper
(HelperClass: TcxWebColumnHelperClass): TcxWebColumnHelper;
begin
  FColumnHelper.Free;
  FColumnHelper := HelperClass.Create(Self);
  Result := FColumnHelper;
end;

function TcxWebColumn.GetColumnHelper: TcxWebColumnHelper;
begin
  if FColumnHelper = nil then
  begin
    case ViewType of
      cvtText:
        Result := CreateColumnHelper(TcxWebTextColumnHelper);
      cvtHyperText:
        Result := CreateColumnHelper(TcxWebHyperTextColumnHelper);
      cvtList, cvtLookup:
        Result := CreateColumnHelper(TcxWebListColumnHelper);
      cvtCheck:
        Result := CreateColumnHelper(TcxWebCheckColumnHelper);
      cvtImage:
        Result := CreateColumnHelper(TcxWebImageColumnHelper);
    else
      Result := CreateColumnHelper(TcxWebColumnHelper);
    end;
  end
  else Result := FColumnHelper;
end;

{ TAbstractcxCustomWebGridDesigner }

constructor TAbstractcxCustomWebGridDesigner.Create(AWebGrid: TcxCustomWebGrid);
begin
  FWebGrid := AWebGrid;
  if FWebGrid <> nil then
    FWebGrid.FDesigner := Self;
end;

destructor TAbstractcxCustomWebGridDesigner.Destroy;
begin
  if WebGrid <> nil then
    WebGrid.FDesigner := nil;
  inherited;
end;

{ TcxWebGridEventsHelper }

function TcxWebGridEventsHelper.EventTypeInfo: PTypeInfo;
begin
  Result := TypeInfo(TcxWebGridEvent);
end;

function TcxWebGridEventsHelper.EventName(const AEvent: Integer): string;
const
  cxHTMLEvent: array[TcxWebGridEvent] of string = ('OnRowClick', 'OnHeaderClick',
      'OnStartDragHeader', 'OnEndDragHeader', 'OnIndicatorClick', 'OnExpandButtonClick',
      'OnGetColumnText', 'OnGetColumnHref');
begin
  Result := cxHTMLEvent[TcxWebGridEvent(AEvent)];
end;

function TcxWebGridEventsHelper.EventProcParams(const AEvent: Integer): string;
const
  cxHTMLEventProcParams: array[TcxWebGridEvent] of string = ('(Sender, RowIndex, IsGroupedRow)',
    '(Sender, ColumnIndex)', '(Sender, ColumnIndex)', '(Sender, ColumnIndex)',
    '(Sender, RowIndex, Reason)', '(Sender, RowIndex)',
    '(Sender, ColumnIndex, RowIndex, Text)', '(Sender, ColumnIndex, RowIndex, Href)');
begin
  Result := cxHTMLEventProcParams[TcxWebGridEvent(AEvent)];
end;

function TcxWebGridEventsHelper.ScriptObject: string;
begin
  Result := '_Grid';
end;

{ TcxWebGridImageIndexes }

constructor TcxWebGridImageIndexes.Create;
begin
  FNode := -1;
  FDelete := -1;
  FInsert := -1;
  FPost := -1;
  FCancel := -1;
  FCursor := -1;
  FExpand := -1;
  FCollapse := -1;
end;

{TcxCustomWebGrid}

constructor TcxCustomWebGrid.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [wcsFixedHeight, wcsFixedWidth];
  FImageIndexes := TcxWebGridImageIndexes.Create;

  FAutoWidth := True;
  FBorderWidth := 1;
  FBorderColor := clWebBlack;
  FDesignerUpdateLock := 0;
  FIndicatorType := itDataOp;
  FIndicatorWidth := cxWebGridBitmapWidth + 2;
  FHeaderHeight := 30;
  FGroupPanelHeight := 40;
  FKeepRowHeight := True;
  FPageSize := 5;
  FRowHeight := cxWebGridBitmapHeight + 2;
  FSelectedColor := clWebDarkBlue;
  FSelectedFontColor := clWebWhite;
  FShowGrid := True;
  FShowHeader := True;
  FShowGroupedColumns := True;
  FShowGroupPanel := True;
  FShowIndicator := True;
  FShowStatusPanel := True;
  FStatusPanelHeight := 20;

  FColumns := TList.Create;

  Height := 200;
  Width := 400;
end;

destructor TcxCustomWebGrid.Destroy;
begin
  Destroying;
  FDesigner.Free;
  Clear;
  FColumns.Free;

  FHeaderStyles.Free;
  FHeaderPopupMenu := nil;
  FGroupNodesStyles.Free;
  FGroupNodesPopupMenu := nil;
  FGroupPanelStyles.Free;
  FGroupPanelPopupMenu := nil;
  FIndicatorStyles.Free;
  FIndicatorPopupMenu := nil;
  FStatusPanelStyles.Free;
  FStatusPanelPopupMenu := nil;

  FImageIndexes.Free;
  inherited Destroy;
end;

function TcxCustomWebGrid.GetWebEventsHelper: TcxWebGridEventsHelper;
begin
  Result := inherited GetWebEventsHelper as TcxWebGridEventsHelper;
end;

class function TcxCustomWebGrid.GetWebEventsHelperClass: TcxWebEventsHelperClass; 
begin
  Result := TcxWebGridEventsHelper;
end;

procedure TcxCustomWebGrid.DoSetValues;
var
  I, Index: Integer;
  S: string;
  ColumnList: TList;
begin
  FirstVisibleRow := StrToInt(WebValuesHelper.Values.Values[Name + 'FirstVisibleRow']);
  if FirstVisibleRow < 0 then FirstVisibleRow := 0;
  
  S := WebValuesHelper.Values.Values[Name + 'ColumnIndexes'];
  ColumnList := TList.Create;
  try
    for I := 0 to ColumnCount - 1 do
      ColumnList.Add(Columns[I]);
    for I := 0 to ColumnList.Count - 1 do
    begin
      Index := StrToInt(GetActionParameter(S, I));
      TcxWebColumn(ColumnList.Items[I]).Index := Index;
    end;
  finally
    ColumnList.Free;
  end;
  try
    FEditMode := StrToBool(WebValuesHelper.Values.Values[Name + 'EditMode']);
  except
    on EConvertError do ;
    else raise;
  end;
end;

procedure TcxCustomWebGrid.RegisterValues;
var
  I: Integer;
  S: string;
begin
  inherited;
  WebValuesHelper.RegisterValue(Name + 'FirstVisibleRow', IntToStr(FirstVisibleRow));
  S := '';
  for I := 0 to ColumnCount - 1 do
  begin
    S := S + IntToStr(I);
    if I <> ColumnCount - 1 then S := S + ':';
  end;
  WebValuesHelper.RegisterValue(Name + 'ColumnIndexes', S);
  WebValuesHelper.RegisterValue(Name + 'EditMode', cxWebUtils.BoolToStr(EditMode));
end;

procedure TcxCustomWebGrid.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  BeginUpdateDesignerContext;
  inherited;
  UpdateColumnsLayout;
  RefreshPageSize;
  EndUpdateDesignerContext;
end;

procedure TcxCustomWebGrid.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
  Column: TcxWebColumn;
begin
  for I := 0 to ColumnCount - 1 do
  begin
    Column := Columns[I];
    if Column.Owner = Root then Proc(Column);
  end;
end;

procedure TcxCustomWebGrid.Loaded;
begin
  inherited;
//  RefreshPageSize;
//  UpdateColumnsLayout;
end;

procedure TcxCustomWebGrid.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = HeaderPopupMenu then
      HeaderPopupMenu := nil;
    if AComponent = GroupNodesPopupMenu then
      GroupNodesPopupMenu := nil;
    if AComponent = GroupPanelPopupMenu then
      GroupPanelPopupMenu := nil;
    if AComponent = IndicatorPopupMenu then
      IndicatorPopupMenu := nil;
    if AComponent = StatusPanelPopupMenu then
      StatusPanelPopupMenu := nil;
    if not IsDestroying and (AComponent is TcxWebStyleItem) then
    begin
      if HeaderStyles <> nil then
        HeaderStyles.Notification(AComponent, Operation);
      if GroupNodesStyles <> nil then
        GroupNodesStyles.Notification(AComponent, Operation);
      if GroupPanelStyles <> nil then
        GroupPanelStyles.Notification(AComponent, Operation);
      if IndicatorStyles <> nil then
        IndicatorStyles.Notification(AComponent, Operation);
      if StatusPanelStyles <> nil then
        StatusPanelStyles.Notification(AComponent, Operation);
    end;
    if AComponent = Images then
      Images := nil;
  end;
end;

procedure TcxCustomWebGrid.SetName(const NewName: TComponentName);
var
  OldName, NewItemName: string;
  I, L: Integer;
  Column: TcxWebColumn;
begin
  OldName := Name;
  L := Length(OldName);
  inherited;
  if (csDesigning in ComponentState) and (ColumnCount > 0) then
  begin
    if Designer <> nil then Designer.BeginUpdate;
    try
      for I := 0 to ColumnCount - 1 do
      begin
        Column := Columns[I];
        NewItemName := Column.Name;
        if Pos(OldName, NewItemName) = 1 then
        begin
          System.Delete(NewItemName, 1, L);
          System.Insert(Name, NewItemName, 1);
          try
            Column.Name := NewItemName;
          except
            on EComponentError do ;
          end;
        end;
      end;
    finally
      if Designer <> nil then Designer.EndUpdate;
    end;
  end;
end;

function TcxCustomWebGrid.UniqueColumnName(Column: TcxWebColumn): string;
var
  I: Integer;
begin
  I := 1;
  while True do
  begin
    Result := Name + 'Column' + IntToStr(I);
    if Owner.FindComponent(Result) = nil then
      break;
    Inc(I);
  end;
end;

procedure TcxCustomWebGrid.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('FirstVisibleRow', ReadFirstVisibleRow, WriteFirstVisibleRow, True);
end;

procedure TcxCustomWebGrid.ReadFirstVisibleRow(Reader: TReader);
begin
  FFirstVisibleRow := Reader.ReadInteger;
end;

procedure TcxCustomWebGrid.WriteFirstVisibleRow(Writer: TWriter);
begin
  Writer.WriteInteger(FFirstVisibleRow);
end;

procedure TcxCustomWebGrid.ImplGetProviders(AList: TList);
begin
  inherited ImplGetProviders(AList);
  AddStylesToProviderList(AList, [HeaderStyles, IndicatorStyles, GroupNodesStyles,
      GroupPanelStyles, StatusPanelStyles]);
end;

function TcxCustomWebGrid.GetColumn(Index: Integer): TcxWebColumn;
begin
  Result := TcxWebColumn(FColumns[Index]);
end;

procedure TcxCustomWebGrid.SetColumn(Index: Integer; Value: TcxWebColumn);
begin
  Columns[Index].Assign(Value);
end;

procedure TcxCustomWebGrid.AdjustWebGridWidth;
var
  I, AWidth: Integer;
begin
  if FLockCount <> 0 then exit;
  if csLoading in ComponentState then exit;
  if VisibleColumnsCount = 0 then exit;

  BeginUpdateLayout;
  try
    AWidth := 2 * BorderWidth + ShownIndicatorWidth + GetExpandingColumnCount * IndicatorWidth;
    for I := 0 to ColumnCount - 1 do
    begin
      if not IsVisibleColumn(I) then continue;
      AWidth := AWidth + Columns[I].Width;
    end;
    Width := AWidth;
  finally
    EndUpdateLayout;
  end;
end;

procedure TcxCustomWebGrid.BeginUpdateLayout;
begin
  Inc(FLockCount);
end;

procedure TcxCustomWebGrid.ChangeColumnsLayout(Index: Integer);
var
  I, J: Integer;

  function GetDiffrentWidth: Integer;
  var
    I: Integer;
  begin
    Result := 0;
    if VisibleColumnsCount > 1 then
    begin
      for I := 0 to ColumnCount - 1 do
      begin
        if not IsVisibleColumn(I) then continue;
        Inc(Result, Columns[I].Width);
      end;
      Result := Width - 2 * BorderWidth - ShownIndicatorWidth - GetExpandingColumnCount * IndicatorWidth - Result;
      if Index <> -1 then
        Result := Result div (VisibleColumnsCount - 1)
      else Result := Result div VisibleColumnsCount;
    end;
  end;

var
  NewWidth, DiffrentWidth: Integer;
begin
  if LockCount <> 0 then exit;
  if csLoading in ComponentState then exit;
  if VisibleColumnsCount = 0 then exit;

  if Width < GetMinWidth then
    Width := GetMinWidth;

  BeginUpdateLayout;
  try
    DiffrentWidth := GetDiffrentWidth;

    for I := 0 to ColumnCount - 1 do
    begin
      if not IsVisibleColumn(I) then continue;
      if I = Index then continue;

      Columns[I].Width := Columns[I].Width + DiffrentWidth;
    end;

    NewWidth := 2 * BorderWidth + ShownIndicatorWidth + GetExpandingColumnCount * IndicatorWidth;
    for J := 0 to ColumnCount - 1 do
    begin
      if not IsVisibleColumn(J) then continue;
      Inc(NewWidth, Columns[J].Width);
    end;

    if LastVisibleColumnIndex <> -1 then
      Columns[LastVisibleColumnIndex].FWidth :=
          Columns[LastVisibleColumnIndex].Width +  Width - NewWidth;
  finally
    EndUpdateLayout;
  end;
end;

procedure TcxCustomWebGrid.EndUpdateLayout;
begin
  Dec(FLockCount);
end;

function TcxCustomWebGrid.GetMaxHeight: Integer;
begin
  if RowCount <> 0 then
    Result := GetBordersCount * BorderWidth + ShownGroupPanelHeight + ShownHeaderHeight +
      RowCount * RowHeight + ShownStatusPanelHeight
  else Result := 0;
end;

function TcxCustomWebGrid.GetMinHeight: Integer;
begin
  Result := GetBordersCount * BorderWidth + ShownGroupPanelHeight + ShownHeaderHeight +
    RowHeight + ShownStatusPanelHeight;
end;

function TcxCustomWebGrid.GetMaxWidth: Integer;
var
  I: Integer;
begin
  Result := 0;
  if not AutoWidth and (FColumns <> nil) and (VisibleColumnsCount <> 0) then
  begin
    Result := 2 * BorderWidth + ShownIndicatorWidth + GetExpandingColumnCount * IndicatorWidth;
    for I := 0 to ColumnCount - 1 do
    begin
      if not IsVisibleColumn(I) then continue;
      Inc(Result, Columns[I].Width);
    end;
  end;
end;

function TcxCustomWebGrid.GetMinWidth: Integer;
var
  I: Integer;
begin
  Result := 2 * BorderWidth + ShownIndicatorWidth + GetExpandingColumnCount * IndicatorWidth;
  if FColumns <> nil then
    for I := 0 to ColumnCount - 1 do
    begin
      if not IsVisibleColumn(I) then continue;
      if not AutoWidth then
        Inc(Result, Columns[I].Width)
      else
        Inc(Result, Columns[I].MinWidth);
    end;
end;

procedure TcxCustomWebGrid.DesignerModified;
begin
  if Designer <> nil then Designer.Modified;
end;

procedure TcxCustomWebGrid.DesignerColumnUpdate(AColumn: TcxWebColumn);
begin
  if Designer <> nil then Designer.Update(AColumn);
end;

procedure TcxCustomWebGrid.StyleChanged(Style: TcxWebStyleItem);
begin
  inherited;
//  DesignerModified;
end;

function TcxCustomWebGrid.Add: TcxWebColumn;
begin
  BeginUpdateDesignerContext;
  Result := TcxWebColumn.Create(Owner);
  Result.WebGrid := Self;
  Result.Name := UniqueColumnName(Result);

  UpdateColumnsLayout;
  RefreshPageSize;

  EndUpdateDesignerContext;
  DesignerModified;
end;

procedure TcxCustomWebGrid.AssignItems(ASource: TcxCustomWebGrid);
var
  I: Integer;
begin
  Clear;
  if ASource <> nil then
    for I := 0 to ASource.ColumnCount - 1 do
      Add.Assign(ASource.Columns[I]);
end;

procedure TcxCustomWebGrid.Clear;
begin
  BeginUpdateDesignerContext;
  while ColumnCount > 0 do Delete(ColumnCount - 1);
  EndUpdateDesignerContext;
end;

procedure TcxCustomWebGrid.Delete(AIndex: Integer);
var
  Column: TcxWebColumn;
begin
  if (AIndex > -1) and (AIndex < ColumnCount) then
  begin
    BeginUpdateDesignerContext;

    Column := Columns[AIndex];
    Column.Free;
    UpdateColumnsLayout;
    RefreshPageSize;

    EndUpdateDesignerContext;
    DesignerModified;
  end;
end;

procedure TcxCustomWebGrid.GetColumnList(const AList: TList);
var
  I: Integer;
begin
  for I := 0 to ColumnCount - 1 do
    AList.Add(Columns[I]);
end;

function TcxCustomWebGrid.IndexOf(AItem: TcxWebColumn): Integer;
begin
  Result := FColumns.IndexOf(AItem);
end;

function TcxCustomWebGrid.ColumnByName(const AName: string): TcxWebColumn;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to ColumnCount - 1 do
  begin
    if SameText(AName, Columns[I].Name) then
    begin
      Result := Columns[I];
      break;
    end;
  end;
end;

function TcxCustomWebGrid.CanCreateDefaultColumns: Boolean;
begin
  Result := False;
end;

procedure TcxCustomWebGrid.CreateDefaultColumns(ADeleteExistColumns: Boolean);
begin
end;

procedure TcxCustomWebGrid.UpdateColumnsLayout;
begin
  if FColumns = nil then exit;
  
  BeginUpdateDesignerContext;
  try
    if not AutoWidth then
      AdjustWebGridWidth
    else ChangeColumnsLayout(-1);
  finally
    EndUpdateDesignerContext;
  end;
end;

procedure TcxCustomWebGrid.ScriptsSubscription;
var
  I: Integer;
  NeedStyleChangedScript: Boolean;
begin
  inherited;
  NeedStyleChangedScript := False;
  if (Styles.Hover <> nil) or (HeaderStyles.Hover <> nil) or (GroupPanelStyles.Hover <> nil) or
    (GroupNodesStyles.Hover <> nil) or (StatusPanelStyles.Hover <> nil) then
    NeedStyleChangedScript := True;
  if not NeedStyleChangedScript then
    for I := 0 to VisibleColumnsCount - 1 do
      if Columns[I].Styles.Hover <> nil then
      begin
        NeedStyleChangedScript := True;
        break;
      end;
  if NeedStyleChangedScript then
    WebScriptsHelper.ScriptSubscription(TcxWebChangeStyleScript);
end;

procedure TcxCustomWebGrid.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxCustomWebGridRenderer);
  WebRenderHelper.RegisterRenderer(TcxCustomWebGridNS4Renderer);
  WebRenderHelper.RegisterRenderer(TcxCustomWebGridNS6Renderer);
  WebRenderHelper.RegisterRenderer(TcxCustomWebGridOperaRenderer);
end;

procedure TcxCustomWebGrid.WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
var
  Renderer: TcxWebGridDsgnRenderer;
begin
  Renderer := TcxWebGridDsgnRenderer.Create(Self, HTMLTextBuilder);
  Renderer.WriteHTML;
  Renderer.Free;
end;

function TcxCustomWebGrid.GetRendererClass: TcxWebRendererClass;
begin
  Result := TcxWebGridDsgnRenderer;
end;

function TcxCustomWebGrid.GetExpandingLevel: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to RowCount - 1 do
  begin
    if not IsVisibleRow(I) then continue;

    if Result < GetRowLevel(I) then
      Result := GetRowLevel(I);
  end;
end;

function TcxCustomWebGrid.GetExpandingColumnCount: Integer;
begin
  Result := 0;
  if GetGroupingItemCount = 0 then Exit;

  Result := GetExpandingLevel;
  if Result <> GetGroupingItemCount then Inc(Result);
end;

function TcxCustomWebGrid.IsVisibleRow(ARowIndex: Integer): Boolean;
begin
  if (ARowIndex >= 0) and (ARowIndex < RowCount) then
    Result := (ARowIndex >= FirstVisibleRow) and (ARowIndex < FirstVisibleRow + PageSize)
  else  Result := False;
end;

function TcxCustomWebGrid.IsVisibleColumn(AItemIndex: Integer): Boolean;
begin
  Result := Columns[AItemIndex].Visible and (ShowGroupedColumns or (GetItemGroupIndex(AItemIndex) = -1));
end;

procedure TcxCustomWebGrid.RefreshPageSize;
begin
  if not IsLoading and IsDesigning and (RowHeight <> 0) then
  begin
    FPageSize := (Height - GetBordersCount * BorderWidth - ShownGroupPanelHeight - ShownHeaderHeight - ShownStatusPanelHeight) div RowHeight;
    if NeedCorrectHeight then RefreshHeight;
  end;
end;

procedure TcxCustomWebGrid.RefreshHeight;
begin
  Height := GetBordersCount * BorderWidth + ShownGroupPanelHeight + ShownHeaderHeight + PageSize * RowHeight + ShownStatusPanelHeight;
end;

function TcxCustomWebGrid.ShownHeaderHeight: Integer;
begin
  if ShowHeader and (ColumnCount <> 0) then
    Result := FHeaderHeight
  else Result := 0;
end;

function TcxCustomWebGrid.ShownGroupPanelHeight: Integer;
begin
  if ShowGroupPanel then
    Result := FGroupPanelHeight
  else Result := 0;
end;

function TcxCustomWebGrid.ShownStatusPanelHeight: Integer;
begin
  if ShowStatusPanel then
    Result := FStatusPanelHeight
  else Result := 0;
end;

function TcxCustomWebGrid.ShownIndicatorWidth: Integer;
begin
  if ShowIndicator then
    Result := FIndicatorWidth
  else Result := 0;
end;

function TcxCustomWebGrid.NeedCorrectHeight: Boolean;
begin
  Result := (Height - GetBordersCount * BorderWidth - ShownGroupPanelHeight - ShownHeaderHeight - ShownStatusPanelHeight) mod RowHeight <> 0;
end;

function TcxCustomWebGrid.GetHeaderColumnWidth(AColumnIndex: Integer): Integer;
begin
  if (AColumnIndex = FirstVisibleColumnIndex) then
    Result := Columns[AColumnIndex].Width + GetExpandingColumnCount * IndicatorWidth
  else Result := Columns[AColumnIndex].Width;
end;

function TcxCustomWebGrid.GetStatusPanelText: string;
var
  EndRow: Integer;
begin
  if RowCount = 0 then
    Result := scxStatusBarEmptyGridText
  else
  begin
    if FirstVisibleRow + PageSize <= RowCount - 1 then
      EndRow := FirstVisibleRow + PageSize - 1
    else EndRow := RowCount - 1;
    Result := Format(scxStatusBarText, [FirstVisibleRow + 1, EndRow + 1, RowCount]);
  end;
end;

function TcxCustomWebGrid.GetVisibleColumnsCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to ColumnCount - 1 do
    if IsVisibleColumn(I) then
      Inc(Result);
end;

function TcxCustomWebGrid.Mode: TcxWebGridMode;
begin
  Result := mBrowse;
end;

function TcxCustomWebGrid.AllowExpanding: Boolean;
begin
  Result := False;
end;

function TcxCustomWebGrid.AllowGrouping: Boolean;
begin
  Result := False;
end;

function TcxCustomWebGrid.AllowSorting: Boolean;
begin
  Result := False;
end;

function TcxCustomWebGrid.LoadAllRecords: Boolean;
begin
  Result := False;
end;

function TcxCustomWebGrid.GetBordersCount: Integer;
begin
  Result := 2;
  if ShowGroupPanel then Inc(Result);
  if ShowStatusPanel then Inc(Result);
end;

function TcxCustomWebGrid.GetColumnCount: Integer;
begin
  if FColumns <> nil then
    Result := FColumns.Count
  else Result := 0;
end;

function TcxCustomWebGrid.GetFirstVisibleColumnIndex: Integer;
begin
  for Result := 0 to ColumnCount - 1 do
  begin
    if not IsVisibleColumn(Result) then continue;
    break;
  end;
  if Result = ColumnCount then Result := -1;
end;

function TcxCustomWebGrid.GetIndicatorStyles: TcxWebStyles;
begin
  if FIndicatorStyles = nil then
    FIndicatorStyles := TcxWebStyles.Create(Self);
  Result := FIndicatorStyles;
end;

function TcxCustomWebGrid.GetIndicatorType: TcxIndicatorType;
begin
  if ReadOnly then
    Result := itCursor
  else Result := FIndicatorType;
end;

function TcxCustomWebGrid.GetHeaderStyles: TcxWebStyles;
begin
  if FHeaderStyles = nil then
    FHeaderStyles := TcxWebStyles.Create(Self);
  Result := FHeaderStyles;
end;

function TcxCustomWebGrid.GetGroupNodesStyles: TcxWebStyles;
begin
  if FGroupNodesStyles = nil then
    FGroupNodesStyles := TcxWebStyles.Create(Self);
  Result := FGroupNodesStyles;
end;

function TcxCustomWebGrid.GetGroupPanelStyles: TcxWebStyles;
begin
  if FGroupPanelStyles = nil then
    FGroupPanelStyles := TcxWebStyles.Create(Self);
  Result := FGroupPanelStyles;
end;

function TcxCustomWebGrid.GetLastVisibleRowIndex: Integer;
begin
  Result := FirstVisibleRow + PageSize - 1;
end;

function TcxCustomWebGrid.GetLastVisibleColumnIndex: Integer;
begin
  for Result := ColumnCount - 1 downto 0 do
  begin
    if not IsVisibleColumn(Result) then continue;
    break;
  end;
end;

function TcxCustomWebGrid.GetStatusPanelStyles: TcxWebStyles;
begin
  if FStatusPanelStyles = nil then
    FStatusPanelStyles := TcxWebStyles.Create(Self);
  Result := FStatusPanelStyles;
end;

procedure TcxCustomWebGrid.SetAutoWidth(AValue: Boolean);
begin
  if FAutoWidth <> AValue then
  begin
    FAutoWidth := AValue;
  end;
end;

procedure TcxCustomWebGrid.SetBorderWidth(AValue : Integer);
var
  MaxWidth: Integer;
begin
  if FBorderWidth <> AValue then
  begin
    MaxWidth := (Height - ShownHeaderHeight - ShownGroupPanelHeight - RowHeight - ShownStatusPanelHeight) div GetBordersCount;
    if MaxWidth < AValue then
      AValue := MaxWidth;
    if AValue < 0 then AValue := 0;
    if AValue > RowHeight then AValue := RowHeight;
    FBorderWidth := AValue;
    UpdateColumnsLayout;
    RefreshPageSize;
  end;
end;

procedure TcxCustomWebGrid.SetBorderColor(AValue : TcxWebColor);
begin
  if FBorderColor <> AValue then
  begin
    FBorderColor := AValue;
  end;
end;

procedure TcxCustomWebGrid.SetImages(Value: TcxWebImageList);
begin
  if FImages <> Value then
  begin
    if Assigned(FImages) then
    begin
      FImages.RemoveFreeNotification(Self);
      FImages.UnregisterClient(Self);
    end;
    FImages := Value;
    if Assigned(FImages) then
    begin
      FImages.RegisterClient(Self);
      FImages.FreeNotification(Self);
    end;
  end;
end;

procedure TcxCustomWebGrid.SetIndicatorPopupMenu(AValue: TcxWebPopupMenu);
begin
  if FIndicatorPopupMenu <> AValue then
  begin
    if FIndicatorPopupMenu <> nil then
      FIndicatorPopupMenu.RemoveFreeNotification(Self);
    FIndicatorPopupMenu := AValue;
    if FIndicatorPopupMenu <> nil then
      FIndicatorPopupMenu.FreeNotification(Self);
  end;
end;

procedure TcxCustomWebGrid.SetIndicatorStyles(AValue: TcxWebStyles);
begin
  FIndicatorStyles.Assign(AValue);
end;

procedure TcxCustomWebGrid.SetIndicatorType(Value: TcxIndicatorType);
begin
  if FIndicatorType <> Value then
  begin
    FIndicatorType := Value;
  end;
end;

procedure TcxCustomWebGrid.SetIndicatorWidth(Value: Integer);
begin
  if FIndicatorWidth <> Value then
  begin
    FIndicatorWidth := Value;
    if FIndicatorWidth < cxWebGridMinIndicatorWidth then
      FIndicatorWidth := cxWebGridMinIndicatorWidth;
    UpdateColumnsLayout;
  end;
end;

procedure TcxCustomWebGrid.SetHeaderHeight(AValue: Integer);
var
  MaxHeight: Integer;
begin
  if FHeaderHeight <> AValue then
  begin
    MaxHeight := Height - GetBordersCount * BorderWidth - ShownGroupPanelHeight - RowHeight - ShownStatusPanelHeight;
    if MaxHeight > AValue then
      FHeaderHeight := AValue
    else FHeaderHeight := MaxHeight;
    if ShowIndicator then
      if FHeaderHeight < cxWebGridMinHeaderHeight then
        FHeaderHeight := cxWebGridMinHeaderHeight;
    RefreshPageSize;
  end;
end;

procedure TcxCustomWebGrid.SetHeaderPopupMenu(AValue: TcxWebPopupMenu);
begin
  if FHeaderPopupMenu <> AValue then
  begin
    if FHeaderPopupMenu <> nil then
      FHeaderPopupMenu.RemoveFreeNotification(Self);
    FHeaderPopupMenu := AValue;
    if FHeaderPopupMenu <> nil then
      FHeaderPopupMenu.FreeNotification(Self);
  end;
end;

procedure TcxCustomWebGrid.SetHeaderStyles(AValue: TcxWebStyles);
begin
  FHeaderStyles.Assign(AValue);
end;

procedure TcxCustomWebGrid.SetGroupNodesPopupMenu(AValue: TcxWebPopupMenu);
begin
  if FGroupNodesPopupMenu <> AValue then
  begin
    if FGroupNodesPopupMenu <> nil then
      FGroupNodesPopupMenu.RemoveFreeNotification(Self);
    FGroupNodesPopupMenu := AValue;
    if FGroupNodesPopupMenu <> nil then
      FGroupNodesPopupMenu.FreeNotification(Self);
  end;
end;

procedure TcxCustomWebGrid.SetGroupNodesStyles(AValue: TcxWebStyles);
begin
  FGroupNodesStyles.Assign(AValue);
end;

procedure TcxCustomWebGrid.SetGroupPanelHeight(AValue: Integer);
var
  MaxHeight: Integer;
begin
  if FGroupPanelHeight <> AValue then
  begin
    MaxHeight := Height - GetBordersCount * BorderWidth - ShownStatusPanelHeight - RowHeight - ShownHeaderHeight;
    if MaxHeight > AValue then
      FGroupPanelHeight := AValue
    else FGroupPanelHeight := MaxHeight;
    if FGroupPanelHeight < cxWebGridMinGroupPanelHeight then
      FGroupPanelHeight := cxWebGridMinGroupPanelHeight;
    RefreshPageSize;
  end;
end;

procedure TcxCustomWebGrid.SetGroupPanelPopupMenu(AValue: TcxWebPopupMenu);
begin
  if FGroupPanelPopupMenu <> AValue then
  begin
    if FGroupPanelPopupMenu <> nil then
      FGroupPanelPopupMenu.RemoveFreeNotification(Self);
    FGroupPanelPopupMenu := AValue;
    if FGroupPanelPopupMenu <> nil then
      FGroupPanelPopupMenu.FreeNotification(Self);
  end;
end;

procedure TcxCustomWebGrid.SetGroupPanelStyles(AValue: TcxWebStyles);
begin
  FGroupPanelStyles.Assign(AValue);
end;

procedure TcxCustomWebGrid.SetKeepRowHeight(AValue: Boolean);
begin
  if FKeepRowHeight <> AValue then
  begin
    FKeepRowHeight := AValue;
    UpdateDesignerContext;
  end;
end;

procedure TcxCustomWebGrid.SetSelectedColor(AValue : TcxWebColor);
begin
  if FSelectedColor <> AValue then
  begin
    FSelectedColor := AValue;
  end;
end;

procedure TcxCustomWebGrid.SetSelectedFontColor(AValue : TcxWebColor);
begin
  if FSelectedFontColor <> AValue then
  begin
    FSelectedFontColor := AValue;
  end;
end;

procedure TcxCustomWebGrid.SetShowGroupPanel(AValue: Boolean);
begin
  if FShowGroupPanel <> AValue then
  begin
    FShowGroupPanel := AValue;
    if FShowGroupPanel then
      Height := Height + FGroupPanelHeight
    else Height := Height - FGroupPanelHeight;
//    RefreshPageSize;
  end;
end;

procedure TcxCustomWebGrid.SetShowHeader(AValue: Boolean);
begin
  if FShowHeader <> AValue then
  begin
    FShowHeader := AValue;
    if FShowHeader then
      Height := Height + FHeaderHeight
    else Height := Height - FHeaderHeight;
//    RefreshPageSize;
  end;
end;

procedure TcxCustomWebGrid.SetShowStatusPanel(AValue: Boolean);
begin
  if FShowStatusPanel <> AValue then
  begin
    FShowStatusPanel := AValue;
    if FShowStatusPanel then
      Height := Height + FStatusPanelHeight
    else Height := Height - FStatusPanelHeight;
//  RefreshPageSize;
  end;
end;

procedure TcxCustomWebGrid.SetShowGrid(AValue: Boolean);
begin
  if FShowGrid <> AValue then
  begin
    FShowGrid := AValue;
  end;
end;

procedure TcxCustomWebGrid.SetShowGroupedColumns(AValue: Boolean);
begin
  if FShowGroupedColumns <> AValue then
  begin
    FShowGroupedColumns := AValue;
    UpdateColumnsLayout;
  end;
end;

procedure TcxCustomWebGrid.SetShowIndicator(AValue: Boolean);
begin
  if FShowIndicator <> AValue then
  begin
    FShowIndicator := AValue;
    if AValue then
    begin
      if HeaderHeight < cxWebGridMinHeaderHeight then
        HeaderHeight := cxWebGridMinHeaderHeight;
      if RowHeight < cxWebGridBitmapHeight + 2 then
        RowHeight := cxWebGridBitmapHeight + 2;
    end;
    UpdateColumnsLayout;
  end;
end;

procedure TcxCustomWebGrid.SetStatusPanelHeight(AValue: Integer);
var
  MaxHeight: Integer;
begin
  if FStatusPanelHeight <> AValue then
  begin
    MaxHeight := Height - GetBordersCount * BorderWidth - ShownGroupPanelHeight - RowHeight - ShownHeaderHeight;
    if MaxHeight > AValue then
      FStatusPanelHeight := AValue
    else FStatusPanelHeight := MaxHeight;
    if FStatusPanelHeight < cxWebGridMinStatusPanelHeight then
      FStatusPanelHeight := cxWebGridMinStatusPanelHeight;
    RefreshPageSize;
  end;
end;

procedure TcxCustomWebGrid.SetStatusPanelPopupMenu(AValue: TcxWebPopupMenu);
begin
  if FStatusPanelPopupMenu <> AValue then
  begin
    if FStatusPanelPopupMenu <> nil then
      FStatusPanelPopupMenu.RemoveFreeNotification(Self);
    FStatusPanelPopupMenu := AValue;
    if FStatusPanelPopupMenu <> nil then
      FStatusPanelPopupMenu.FreeNotification(Self);
  end;
end;

procedure TcxCustomWebGrid.SetStatusPanelStyles(AValue: TcxWebStyles);
begin
  FStatusPanelStyles.Assign(AValue);
end;

procedure TcxCustomWebGrid.SetPageSize(AValue: Integer);
begin
  if FPageSize <> AValue then
  begin
    FPageSize := AValue;
    Height := GetBordersCount * BorderWidth + ShownGroupPanelHeight + ShownHeaderHeight + FPageSize * RowHeight + ShownStatusPanelHeight;
  end;
end;

procedure TcxCustomWebGrid.SetRowHeight(AValue: Integer);
var
  MaxHeight: Integer;
begin
  if (FRowHeight <> AValue) and (AValue > 8) then
  begin
    MaxHeight := Height - GetBordersCount * BorderWidth - ShownGroupPanelHeight - ShownStatusPanelHeight - ShownHeaderHeight;
    if (MaxHeight > AValue) or IsLoading then
      FRowHeight := AValue
    else FRowHeight := MaxHeight;
    if ShowIndicator and not IsLoading then
      if FRowHeight < cxWebGridBitmapHeight + 2 then
        FRowHeight := cxWebGridBitmapHeight + 2;
    RefreshPageSize;
  end;
end;

function TcxCustomWebGrid.GetFocusedRow: Integer;
begin
  Result := 0;
end;

function TcxCustomWebGrid.GetRecordCount: Integer;
begin
  Result := 0;
end;

function TcxCustomWebGrid.GetRowCount: Integer;
begin
  Result := 0;
end;

function TcxCustomWebGrid.GetDisplayText(ARecordIndex, AColIndex: Integer): string;
begin
  Result := '';
end;

function TcxCustomWebGrid.GetValue(ARecordIndex, AColIndex: Integer): Variant;
begin
  Result := Null;
end;

function TcxCustomWebGrid.GetRowDisplayText(ARowIndex, AColIndex: Integer): string;
begin
  Result := '';
end;

function TcxCustomWebGrid.GetRowValue(ARowIndex, AColIndex: Integer): Variant;
begin
  Result := Null;
end;

function TcxCustomWebGrid.GetRowExpanded(RowIndex: Integer): Boolean;
begin
  Result := False;
end;

function TcxCustomWebGrid.GetRowLevel(RowIndex: Integer): Integer;
begin
  Result := 0;
end;

function TcxCustomWebGrid.GetRowRecord(RowIndex: Integer): Integer;
begin
  Result := 0;
end;

function TcxCustomWebGrid.GetGroupingItemCount: Integer;
begin
  Result := 0;
end;

function TcxCustomWebGrid.GetSortingItemCount: Integer;
begin
  Result := 0;
end;

function TcxCustomWebGrid.GetItemGroupIndex(AColIndex: Integer): Integer;
begin
  Result := -1;
end;

function TcxCustomWebGrid.GetItemSortOrder(AColIndex: Integer): TcxWebGridSortMode;
begin
  Result := smNone;
end;

function TcxCustomWebGrid.GetSortingItemIndex(Item: Integer): Integer;
begin
  Result := -1;
end;

function TcxCustomWebGrid.GetGroupingItemIndex(Item: Integer): Integer;
begin
  Result := -1;
end;

procedure TcxCustomWebGrid.InsertColumn(Value: TcxWebColumn);
begin
  FColumns.Add(Value);
  Value.FWebGrid := Self;
end;

procedure TcxCustomWebGrid.MoveColumn(ACurIndex, ANewIndex: Integer);
begin
  FColumns.Move(ACurIndex, ANewIndex);
  DesignerColumnUpdate(nil);
end;

procedure TcxCustomWebGrid.RemoveColumn(Value: TcxWebColumn);
begin
  Value.FWebGrid := nil;
  FColumns.Remove(Value);
end;

{ TcxWebGridDragHeaderStyle }

class function TcxWebGridDragHeaderStyle.GetName: string;
begin
  Result := 'clsDragHeader'
end;

class procedure TcxWebGridDragHeaderStyle.WriteStyle(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
  HTMLTextBuilder.WriteStyle(GetName);
  HTMLTextBuilder.WriteStyleAttribute(saBorderStyle, 'solid');
  HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, 1, 'px');
  HTMLTextBuilder.WriteStyleAttribute(saBorderColor, '#000000');
  HTMLTextBuilder.WriteStyleAttribute(saBackgroundColor, '#666666');
  HTMLTextBuilder.WriteUnknownStyleAttribute('filter:alpha( opacity=70 );');
end;

{ TcxWebGridGroupNodesStyle }

class function TcxWebGridGroupNodesStyle.GetName: string;
begin
  Result := 'WGGrNodesStyle';
end;

class procedure TcxWebGridGroupNodesStyle.WriteStyle;
begin
  HTMLTextBuilder.WriteStyle(GetName);
  HTMLTextBuilder.WriteStyleAttribute(saColor, '#000000');
  HTMLTextBuilder.WriteStyleAttribute(saBackgroundColor, '#D4D0C8');
  HTMLTextBuilder.WriteStyleAttribute(saBorderStyle, 'solid');
end;


{ TcxWebGridPanelsStyle }

class function TcxWebGridPanelsStyle.GetName: string;
begin
  Result := 'WGPanelStyle';
end;

class procedure TcxWebGridPanelsStyle.WriteStyle;
begin
  HTMLTextBuilder.WriteStyle(GetName);
  HTMLTextBuilder.WriteStyleAttribute(saBackgroundColor, 'gray');
  HTMLTextBuilder.WriteStyleAttribute(saColor, 'lightgray');
end;

{ TcxWebGridButtonStyle }

class function TcxWebGridButtonStyle.GetName: string;
begin
  Result := 'WGBtnStyle';
end;

class procedure TcxWebGridButtonStyle.WriteStyle;
begin
  HTMLTextBuilder.WriteStyle(GetName);
  HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, 1, 'px');
  HTMLTextBuilder.WriteStyleAttribute(saBorderStyle, 'solid');
  HTMLTextBuilder.WriteStyleAttribute(saBorderTopColor, 'white');
  HTMLTextBuilder.WriteStyleAttribute(saBorderLeftColor, 'white');
  HTMLTextBuilder.WriteStyleAttribute(saBorderBottomColor, 'black');
  HTMLTextBuilder.WriteStyleAttribute(saBorderRightColor, 'black');
  HTMLTextBuilder.WriteStyleAttribute(saBackgroundColor, '#D4D0C8');
  HTMLTextBuilder.WriteStyleAttribute(saColor, '#000000');
end;

{ TcxCustomWebGridRenderer }

function TcxCustomWebGridRenderer.GetWebGrid: TcxCustomWebGrid;
begin
  Result := Component as TcxCustomWebGrid;
end;

function TcxCustomWebGridRenderer.ColumnDefaultStyleName(Index, ARowIndex: Integer): string;
begin
  if ColumnDefaultStyle(Index, ARowIndex) <> nil then
    Result := ColumnDefaultStyle(Index, ARowIndex).FullName
  else Result := '';
end;

function TcxCustomWebGridRenderer.IndicatorDefaultStyleName: string;
begin
  if IndicatorDefaultStyle <> nil then
    Result := IndicatorDefaultStyle.FullName
  else Result := TcxWebGridButtonStyle.GetName;
end;

function TcxCustomWebGridRenderer.HeaderDefaultStyleName: string;
begin
  if HeaderDefaultStyle <> nil then
    Result := HeaderDefaultStyle.FullName
  else Result := TcxWebGridButtonStyle.GetName;
end;

function TcxCustomWebGridRenderer.GroupNodesDefaultStyleName: string;
begin
  if GroupNodesDefaultStyle <> nil then
    Result := GroupNodesDefaultStyle.FullName
  else Result := TcxWebGridGroupNodesStyle.GetName;
end;

function TcxCustomWebGridRenderer.GroupPanelDefaultStyleName: string;
begin
  if GroupPanelDefaultStyle <> nil then
    Result := GroupPanelDefaultStyle.FullName
  else Result := TcxWebGridPanelsStyle.GetName;
end;

function TcxCustomWebGridRenderer.StatusPanelDefaultStyleName: string;
begin
  if StatusPanelDefaultStyle <> nil then
    Result := StatusPanelDefaultStyle.FullName
  else Result := TcxWebGridPanelsStyle.GetName;
end;

function TcxCustomWebGridRenderer.ColumnDefaultStyle(Index, ARowIndex: Integer): TcxWebStyleItem;
begin
  if (ARowIndex mod 2 = 1) and (WebGrid.Columns[Index].AlternatingStyles.Default <> nil) then
    Result := WebGrid.Columns[Index].AlternatingStyles.Default
  else if WebGrid.Columns[Index].Styles.Default <> nil then
    Result := WebGrid.Columns[Index].Styles.Default
  else Result := WebGrid.Styles.Default;
end;

function TcxCustomWebGridRenderer.IndicatorDefaultStyle: TcxWebStyleItem;
begin
  if WebGrid.IndicatorStyles.Default <> nil then
    Result := WebGrid.IndicatorStyles.Default
  else Result := WebGrid.Styles.Default;
end;

function TcxCustomWebGridRenderer.HeaderDefaultStyle: TcxWebStyleItem;
begin
  if WebGrid.HeaderStyles.Default <> nil then
    Result := WebGrid.HeaderStyles.Default
  else Result := WebGrid.Styles.Default;
end;

function TcxCustomWebGridRenderer.GroupNodesDefaultStyle: TcxWebStyleItem;
begin
  if WebGrid.GroupNodesStyles.Default <> nil then
    Result := WebGrid.GroupNodesStyles.Default
  else Result := WebGrid.Styles.Default;
end;

function TcxCustomWebGridRenderer.GroupPanelDefaultStyle: TcxWebStyleItem;
begin
  if WebGrid.GroupPanelStyles.Default <> nil then
    Result := WebGrid.GroupPanelStyles.Default
  else Result := WebGrid.Styles.Default;
end;

function TcxCustomWebGridRenderer.StatusPanelDefaultStyle: TcxWebStyleItem;
begin
  if WebGrid.StatusPanelStyles.Default <> nil then
    Result := WebGrid.StatusPanelStyles.Default
  else Result := WebGrid.Styles.Default;
end;

function TcxCustomWebGridRenderer.ColumnHoverStyle(Index, ARowIndex: Integer): TcxWebStyleItem;
begin
  if (ARowIndex mod 2 = 1) and (WebGrid.Columns[Index].AlternatingStyles.Hover <> nil) then
    Result := WebGrid.Columns[Index].AlternatingStyles.Hover
  else if WebGrid.Columns[Index].Styles.Hover <> nil then
    Result := WebGrid.Columns[Index].Styles.Hover
  else Result := WebGrid.Styles.Hover;
end;

function TcxCustomWebGridRenderer.IndicatorHoverStyle: TcxWebStyleItem;
begin
  if WebGrid.IndicatorStyles.Hover <> nil then
    Result := WebGrid.IndicatorStyles.Hover
  else Result := WebGrid.Styles.Hover;
end;

function TcxCustomWebGridRenderer.HeaderHoverStyle: TcxWebStyleItem;
begin
  if WebGrid.HeaderStyles.Hover <> nil then
    Result := WebGrid.HeaderStyles.Hover
  else Result := WebGrid.Styles.Hover;
end;

function TcxCustomWebGridRenderer.GroupNodesHoverStyle: TcxWebStyleItem;
begin
  if WebGrid.GroupNodesStyles.Hover <> nil then
    Result := WebGrid.GroupNodesStyles.Hover
  else Result := WebGrid.Styles.Hover;
end;

function TcxCustomWebGridRenderer.GroupPanelHoverStyle: TcxWebStyleItem;
begin
  if WebGrid.GroupPanelStyles.Hover <> nil then
    Result := WebGrid.GroupPanelStyles.Hover
  else Result := WebGrid.Styles.Hover;
end;

function TcxCustomWebGridRenderer.StatusPanelHoverStyle: TcxWebStyleItem;
begin
  if WebGrid.StatusPanelStyles.Hover <> nil then
    Result := WebGrid.StatusPanelStyles.Hover
  else Result := WebGrid.Styles.Hover;
end;

procedure TcxCustomWebGridRenderer.WriteComponentEvents(AStyle: TcxWebStyleItem; AMenu: TcxWebPopupMenu);
var
  MouseClickString, MouseOutString, MouseOverString: string;
begin
  if IsDesigning then exit;

  if WebGrid.PopupShowingType = stClick then
    MouseClickString := GetPopupMenuProc(AMenu)
  else MouseOverString := GetPopupMenuProc(AMenu);
  if AStyle <> nil then
  begin
    MouseOverString := MouseOverString + GetHoverStyleProc(AStyle);
    MouseOutString := MouseOutString + GetDefaultStyleProc(AStyle);
  end;

  if MouseClickString <> '' then
    HTMLTextBuilder.WriteEventAttribute(eOnClick, MouseClickString);
  if MouseOverString <> '' then
    HTMLTextBuilder.WriteEventAttribute(eOnMouseOver, MouseOverString);
  if MouseOutString <> '' then
    HTMLTextBuilder.WriteEventAttribute(eOnMouseOut, MouseOutString);
end;

function TcxCustomWebGridRenderer.GetExpandImageIndex(ARowIndex: Integer): Integer;
begin
  if WebGrid.GetRowExpanded(ARowIndex) then
    Result := WebGrid.ImageIndexes.Collapse
  else Result := WebGrid.ImageIndexes.Expand;
end;

function TcxCustomWebGridRenderer.GetExpandImageSrc(ARowIndex: Integer): string;
begin
  if WebGrid.GetRowExpanded(ARowIndex) then
    Result := QualifyImageFileName(cxWebGridButtonImgs[gbCollapse])
  else Result := QualifyImageFileName(cxWebGridButtonImgs[gbExpand]);
end;

function TcxCustomWebGridRenderer.GetSortImageSrc(AItemIndex: Integer): string;
begin
  Result := QualifyImageFileName(cxSortingImgs[WebGrid.GetItemSortOrder(AItemIndex)]);
end;

function TcxCustomWebGridRenderer.GetNodeImageSrc(ARowIndex: Integer): string;
begin
  if (ARowIndex = WebGrid.FocusedRow) and IsIndicatorCursorType then
    Result := QualifyImageFileName(cxWebGridButtonImgs[gbCursor])
  else Result := QualifyImageFileName(cxWebGridButtonImgs[gbNode]);
end;

function TcxCustomWebGridRenderer.IsDesigning: Boolean;
begin
  Result := WebGrid.IsDesigning;
end;

function TcxCustomWebGridRenderer.IsIndicatorCursorType: Boolean;
begin
  Result := (WebGrid.IndicatorType = itCursor);
end;

function TcxCustomWebGridRenderer.GetHorizBordersWidth: Integer;
begin
  Result := 2;
end;

function TcxCustomWebGridRenderer.GetVertBordersWidth: Integer;
begin
  Result := 2;
end;

procedure TcxCustomWebGridRenderer.WriteNodeHandler;
begin
  HTMLTextBuilder.WriteEventAttribute(eOnClick, scxNodeHandler);
end;

procedure TcxCustomWebGridRenderer.WriteGroupNodeHandler;
begin
  HTMLTextBuilder.WriteEventAttribute(eOnClick, scxGroupNodeHandler);
end;

procedure TcxCustomWebGridRenderer.WriteButton(
    ID, ClassName, Handler, ImageID, ImageSrc, Hint: string;
    ImageIndex, Height, Width: Integer; HoverStyle: TcxWebStyleItem);
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv);
  HTMLTextBuilder.WriteAttribute(aID, ID);
  HTMLTextBuilder.WriteAttribute(aClass, ClassName);
  HTMLTextBuilder.WriteAttribute(aAlign, 'center');
  if Height = -1 then
    HTMLTextBuilder.WriteStyleAttribute(saHeight, '100%')
  else
    HTMLTextBuilder.WriteStyleAttribute(saHeight, Height, 'px');
  if Width = -1 then
    HTMLTextBuilder.WriteStyleAttribute(saWidth, '100%')
  else
    HTMLTextBuilder.WriteStyleAttribute(saWidth, Width, 'px');
  HTMLTextBuilder.WriteStyleAttribute(saOverflow, 'hidden');
  WriteComponentEvents(HoverStyle, WebGrid.IndicatorPopupMenu);
  HTMLTextBuilder.WriteEventAttribute(eOnClick, Handler);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aHeight, '100%');
  HTMLTextBuilder.WriteAttribute(aWidth, '100%');
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aAlign, 'center');
  HTMLTextBuilder.WriteAttribute(aValign, 'center');

  if (WebGrid.Images <> nil) and (WebGrid.Images.ValidIndex(ImageIndex)) then
    WebGrid.Images.Images[ImageIndex].WriteHTML(HTMLTextBuilder)
  else
  begin
    HTMLTextBuilder.WriteSingleTag(TcxHTMLTagImg);
    HTMLTextBuilder.WriteAttribute(aSrc, ImageSrc);
    HTMLTextBuilder.WriteAttribute(aBorder, 0);
    if WebGrid.ShowHint then
      HTMLTextBuilder.WriteAttribute(aTitle, Hint);
    HTMLTextBuilder.WriteAttribute(aAlt, Hint);
  end;
  HTMLTextBuilder.WriteAttribute(aId, ImageID);
  HTMLTextBuilder.WriteAttribute(aAlign, 'top');

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv);
end;

procedure TcxCustomWebGridRenderer.WriteCancelButton;
var
  AID, AHandler, AImageID, AImageSrc: string;
begin
  AID := Format('%s%s', [WebGrid.Name, scxCancelBtnID]);
  AImageID := Format('%s%s', [WebGrid.Name, scxCancelImgID]);
  AImageSrc := QualifyImageFileName(cxWebGridButtonImgs[gbCancel]);
  AHandler := Format(scxCancelBtnHandler, ['']);

  WriteButton(AID, IndicatorDefaultStyleName, AHandler,
    AImageID, AImageSrc, scxCancelBtnHint, WebGrid.ImageIndexes.Cancel, WebGrid.HeaderHeight,
    WebGrid.IndicatorWidth, IndicatorHoverStyle);
end;

procedure TcxCustomWebGridRenderer.WriteDeleteButton(ARowIndex: Integer);
var
  AID, AHandler, AImageID, AImageSrc: string;
begin
  AID := Format('%s%s%d', [WebGrid.Name, scxDeleteBtnID, ARowIndex]);
  AImageID := Format('%s%s', [WebGrid.Name, scxDeleteImgID]);
  AImageSrc := QualifyImageFileName(cxWebGridButtonImgs[gbDelete]);
  AHandler := Format(scxDeleteBtnHandler, ['']);

  WriteButton(AID, IndicatorDefaultStyleName, AHandler,
    AImageID, AImageSrc, scxDeleteBtnHint, WebGrid.ImageIndexes.Delete, -1,
    WebGrid.IndicatorWidth, IndicatorHoverStyle);
end;

procedure TcxCustomWebGridRenderer.WriteExpandButton(ARowIndex: Integer);
var
  AID, AHandler, AImageID, AImageSrc: string;
begin
  AID := Format('%s%s%d', [WebGrid.Name, scxExpandBtnID, ARowIndex]);
  AImageID := Format('%s%s', [WebGrid.Name, scxExpandImgID]);
  AImageSrc := GetExpandImageSrc(ARowIndex);
  AHandler := Format(scxExpandBtnHandler, ['']);

  WriteButton(AID, IndicatorDefaultStyleName, AHandler,
    AImageID, AImageSrc, '', GetExpandImageIndex(ARowIndex), cxWebGridExpandBitmapHeight + 2,
    cxWebGridExpandBitmapWidth + 2, IndicatorHoverStyle);
end;

procedure TcxCustomWebGridRenderer.WriteHeaderButton;
var
  AID, AImageSrc: string;
begin
  AID := Format('%s%s', [WebGrid.Name, scxHeaderBtnID]);
  AImageSrc := QualifyImageFileName(cxWebGridButtonImgs[gbNode]);

  WriteButton(AID, IndicatorDefaultStyleName, '', '', AImageSrc, '',
    WebGrid.ImageIndexes.Node, WebGrid.HeaderHeight, WebGrid.IndicatorWidth, IndicatorHoverStyle);
end;

procedure TcxCustomWebGridRenderer.WriteInsertButton;
var
  AID, AHandler, AImageID, AImageSrc: string;
begin
  AID := Format('%s%s', [WebGrid.Name, scxInsertBtnID]);
  AImageID := Format('%s%s', [WebGrid.Name, scxInsertImgID]);
  AImageSrc := QualifyImageFileName(cxWebGridButtonImgs[gbInsert]);
  AHandler := Format(scxInsertBtnHandler, ['']);

  WriteButton(AID, IndicatorDefaultStyleName, AHandler,
    AImageID, AImageSrc, scxInsertBtnHint, WebGrid.ImageIndexes.Insert, WebGrid.HeaderHeight,
    WebGrid.IndicatorWidth, IndicatorHoverStyle);
end;

procedure TcxCustomWebGridRenderer.WriteNodeButton(ARowIndex: Integer);
var
  AID, AHandler, AImageID, AImageSrc: string;
begin
  AID := Format('%s%s%d', [WebGrid.Name, scxNodeBtnID, ARowIndex]);
  AImageID := Format('%s%s%d', [WebGrid.Name, scxNodeImgID, ARowIndex]);
  AImageSrc := GetNodeImageSrc(ARowIndex);
  AHandler := Format(scxNodeBtnHandler, ['']);

  WriteButton(AID, IndicatorDefaultStyleName, AHandler,
    AImageID, AImageSrc, scxNodeBtnHint + IntToStr(ARowIndex), WebGrid.ImageIndexes.Node,
    -1, WebGrid.IndicatorWidth, IndicatorHoverStyle);
end;

procedure TcxCustomWebGridRenderer.WriteOkButton(ARowIndex: Integer);
var
  AID, AHandler, AImageID, AImageSrc: string;
begin
  AID := Format('%s%s%d', [WebGrid.Name, scxPostBtnID, ARowIndex]);
  AImageID := Format('%s%s', [WebGrid.Name, scxPostImgID]);
  AImageSrc := QualifyImageFileName(cxWebGridButtonImgs[gbPost]);
  AHandler := Format(scxPostBtnHandler, ['']);

  WriteButton(AID, IndicatorDefaultStyleName, AHandler,
    AImageID, AImageSrc, scxPostBtnHint, WebGrid.ImageIndexes.Post,
    -1, WebGrid.IndicatorWidth, IndicatorHoverStyle);
end;

procedure TcxCustomWebGridRenderer.WriteSortButton(AColumnIndex: Integer);
begin
 if WebGrid.AllowSorting then
 begin
    HTMLTextBuilder.WriteSingleTag(TcxHTMLTagImg, False, False);
    HTMLTextBuilder.WriteAttribute(aId, WebGrid.Name + scxSortImgID + IntToStr(AColumnIndex));
    HTMLTextBuilder.WriteAttribute(aSrc, GetSortImageSrc(AColumnIndex));
    HTMLTextBuilder.WriteAttribute(aBorder, 0);
    HTMLTextBuilder.WriteAttribute(aAlign, 'absmiddle');
 end;
end;

procedure TcxCustomWebGridRenderer.WriteCell(AColumnIndex, ARowIndex: Integer; IsEditing: Boolean);
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aId, WebGrid.Name + scxCellID +
      IntToStr(ARowIndex) + '_' + IntToStr(AColumnIndex));
  HTMLTextBuilder.WriteAttribute(aClass, ColumnDefaultStyleName(AColumnIndex, ARowIndex));
  if WebGrid.Columns[AColumnIndex].ShowCellHint then
    HTMLTextBuilder.WriteAttribute(aTitle, WebGrid.Columns[AColumnIndex].GetCellHint(ARowIndex));
  HTMLTextBuilder.WriteStyleAttribute(saBorderStyle, 'solid');
  HTMLTextBuilder.WriteStyleAttribute(saBorderColor, '#000000');
  if WebGrid.ShowGrid then
  begin
    HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, 1, 'px');
    HTMLTextBuilder.WriteStyleAttribute(saBorderTopWidth, 0, 'px');
    HTMLTextBuilder.WriteStyleAttribute(saBorderLeftWidth, 0, 'px');
    if AColumnIndex = WebGrid.LastVisibleColumnIndex then
    begin
      HTMLTextBuilder.WriteStyleAttribute(saBorderRightWidth, 0, 'px');
      HTMLTextBuilder.WriteAttribute(aWidth, WebGrid.Columns[AColumnIndex].Width, 'px');
    end
    else
    begin
      HTMLTextBuilder.WriteAttribute(aWidth, WebGrid.Columns[AColumnIndex].Width - 1, 'px');
    end;
    if ARowIndex = WebGrid.LastVisibleRowIndex then
      HTMLTextBuilder.WriteStyleAttribute(saBorderBottomWidth, 0, 'px');
  end
  else
  begin
    HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, 0, 'px');
    HTMLTextBuilder.WriteAttribute(aWidth, WebGrid.Columns[AColumnIndex].Width, 'px');
  end;
  HTMLTextBuilder.WriteAttribute(aHeight, WebGrid.RowHeight, 'px');
  WriteComponentEvents(ColumnHoverStyle(AColumnIndex, ARowIndex), WebGrid.Columns[AColumnIndex].PopupMenu);  //bas: move to column helper
  WebGrid.Columns[AColumnIndex].WriteCellHTML(HTMLTextBuilder, ARowIndex, IsEditing);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
end;

procedure TcxCustomWebGridRenderer.WriteDataFrame;
var
  I: Integer;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aId, WebGrid.Name + 'DataTable');
  HTMLTextBuilder.WriteAttribute(aWidth, WebGrid.Width, 'px');
  HTMLTextBuilder.WriteAttribute(aBorder, 1);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aBordercolor, cxWebColorToWebString(WebGrid.BorderColor));
  HTMLTextBuilder.WriteStyleAttribute(saBorderStyle, 'solid');  
  if not (WebGrid.ShowGroupPanel or WebGrid.ShowHeader) then
    HTMLTextBuilder.WriteStyleAttribute(saBorderTopWidth, WebGrid.BorderWidth, 'px')
  else HTMLTextBuilder.WriteStyleAttribute(saBorderTopWidth, 0, 'px');
  HTMLTextBuilder.WriteStyleAttribute(saBorderBottomWidth, WebGrid.BorderWidth, 'px');
  HTMLTextBuilder.WriteStyleAttribute(saBorderLeftWidth, WebGrid.BorderWidth, 'px');
  HTMLTextBuilder.WriteStyleAttribute(saBorderRightWidth, WebGrid.BorderWidth, 'px');

  for I := WebGrid.FirstVisibleRow to WebGrid.FirstVisibleRow + WebGrid.PageSize - 1 do
  begin
    if WebGrid.IsVisibleRow(I) and (WebGrid.ColumnCount > 0) then
    begin
      if WebGrid.GetRowLevel(I) < WebGrid.GetGroupingItemCount then
        WriteGroupNode(I)
      else WriteNode(I);
    end
    else WriteEmptyNode(I);
  end;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
end;

procedure TcxCustomWebGridRenderer.WriteIndicatorHeaderCell;
begin
  if (WebGrid.ColumnCount = 0) or not WebGrid.ShowIndicator then exit;

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aWidth, WebGrid.IndicatorWidth, 'px');
  HTMLTextBuilder.WriteAttribute(aAlign, 'center');
  HTMLTextBuilder.WriteAttribute(aValign, 'center');
  HTMLTextBuilder.WriteStyleAttribute(saBackgroundColor, '#D4D0C8');
  HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, 0, 'px');

  if WebGrid.Mode = mEdit then
    WriteCancelButton
  else
  begin
    if IsIndicatorCursorType  then
      WriteHeaderButton
    else WriteInsertButton;
  end;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
end;

procedure TcxCustomWebGridRenderer.WriteIndicatorCell(ARowIndex: Integer);
begin
  if {(WebGrid.ColumnCount = 0) or} not WebGrid.ShowIndicator then exit;

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aWidth, WebGrid.IndicatorWidth, 'px');
  HTMLTextBuilder.WriteAttribute(aHeight, WebGrid.RowHeight);
  HTMLTextBuilder.WriteAttribute(aAlign, 'center');
  HTMLTextBuilder.WriteAttribute(aValign, 'center');
  HTMLTextBuilder.WriteStyleAttribute(saBackgroundColor, '#D4D0C8');
  HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, 0, 'px');
  
  if WebGrid.GetRowLevel(ARowIndex) < WebGrid.GetGroupingItemCount then
    WriteNodeButton(ARowIndex)
  else
  begin
    if (IsIndicatorCursorType) then
    begin
      if (WebGrid.Mode = mEdit) and (WebGrid.FocusedRow = ARowIndex) then
        WriteOkButton(ARowIndex)
      else WriteNodeButton(ARowIndex);
    end
    else
    begin
      if (WebGrid.Mode = mEdit) and (WebGrid.FocusedRow = ARowIndex) then
        WriteOkButton(ARowIndex)
      else WriteDeleteButton(ARowIndex);
    end;
  end;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
end;

procedure TcxCustomWebGridRenderer.WriteHeaderCell(
    ID, ClassName, Cursor, Hint, Handler: string; ColumnIndex, Height, Width: Integer;
    ShowSortImage: Boolean; HoverStyle: TcxWebStyleItem);
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv);
  if ID <> '' then HTMLTextBuilder.WriteAttribute(aId, ID);
  if ClassName <> '' then HTMLTextBuilder.WriteAttribute(aClass, ClassName);
  if Hint <> '' then HTMLTextBuilder.WriteAttribute(aTitle, Hint);
  if Cursor <> '' then HTMLTextBuilder.WriteStyleAttribute(saCursor, Cursor);
  HTMLTextBuilder.WriteStyleAttribute(saPosition, 'releative');
  HTMLTextBuilder.WriteStyleAttribute(saWidth, Width, 'px');
  HTMLTextBuilder.WriteStyleAttribute(saHeight, Height, 'px');
  HTMLTextBuilder.WriteStyleAttribute(saOverflow, 'hidden');
  HTMLTextBuilder.WriteEventAttribute(eOnMouseDown, Handler);
  WriteComponentEvents(HoverStyle, WebGrid.HeaderPopupMenu);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aClass, ClassName);
  HTMLTextBuilder.WriteAttribute(aHeight, '100%');
  HTMLTextBuilder.WriteAttribute(aWidth, '100%');
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, 0, 'px');
  WriteComponentEvents(HoverStyle, WebGrid.HeaderPopupMenu);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aAlign, 'center');
  HTMLTextBuilder.WriteAttribute(aValign, 'center');
  HTMLTextBuilder.WriteText(WebGrid.Columns[ColumnIndex].Title + '&nbsp;', False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aAlign, 'center');
  HTMLTextBuilder.WriteAttribute(aValign, 'center');
  HTMLTextBuilder.WriteAttribute(aWidth, cxWebGridSortBitmapWidth + 4, 'px');
  if ShowSortImage then WriteSortButton(ColumnIndex);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv);
end;

procedure TcxCustomWebGridRenderer.WriteHeaderNode(AColumnIndex: Integer);
var
  AId, AHandler, AHint: string;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aWidth, WebGrid.GetHeaderColumnWidth(AColumnIndex), 'px');
  HTMLTextBuilder.WriteAttribute(aAlign, cxWebHorzAlignment[WebGrid.Columns[AColumnIndex].Alignment]);
  HTMLTextBuilder.WriteAttribute(aValign, 'center');
  HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, 0, 'px');

  AId := Format('%s%s%d', [WebGrid.Name, scxHeaderNodeID, AColumnIndex]);
  AHandler := Format(scxHeaderNodeHandler, ['']);
  if WebGrid.Columns[AColumnIndex].ShowHeaderHint then
    AHint := WebGrid.Columns[AColumnIndex].HeaderHint
  else AHint := '';
  WriteHeaderCell(AId, HeaderDefaultStyleName, 'hand', AHint,
    AHandler, AColumnIndex, WebGrid.HeaderHeight,
    WebGrid.GetHeaderColumnWidth(AColumnIndex),
    True, HeaderHoverStyle);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
end;

procedure TcxCustomWebGridRenderer.WriteHeader;
var
  I: Integer;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aId, WebGrid.Name + 'HeaderPanelTable');
  HTMLTextBuilder.WriteAttribute(aWidth, WebGrid.Width, 'px');
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aBordercolor, cxWebColorToWebString(WebGrid.BorderColor));
  HTMLTextBuilder.WriteAttribute(aBgcolor, 'ButtonFace');
  HTMLTextBuilder.WriteStyleAttribute(saBorderStyle, 'solid');
  if not WebGrid.ShowGroupPanel then
    HTMLTextBuilder.WriteStyleAttribute(saBorderTopWidth, WebGrid.BorderWidth, 'px')
  else HTMLTextBuilder.WriteStyleAttribute(saBorderTopWidth, 0, 'px');
  HTMLTextBuilder.WriteStyleAttribute(saBorderBottomWidth, 0, 'px');
  HTMLTextBuilder.WriteStyleAttribute(saBorderLeftWidth, WebGrid.BorderWidth, 'px');
  HTMLTextBuilder.WriteStyleAttribute(saBorderRightWidth, WebGrid.BorderWidth, 'px');

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteAttribute(aId, WebGrid.Name + 'HeaderPanel');
  HTMLTextBuilder.WriteAttribute(aHeight, WebGrid.HeaderHeight);
  WriteIndicatorHeaderCell;
  for I := 0 to WebGrid.ColumnCount - 1 do
  begin
    if not WebGrid.IsVisibleColumn(I) then continue;
    WriteHeaderNode(I);
  end;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
end;

procedure TcxCustomWebGridRenderer.WriteGroupNode(ARowIndex: Integer);
var
  I, CellWidth: Integer;
  WebColumn: TcxWebColumn;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteAttribute(aId, WebGrid.Name + scxGroupNodeID + IntToStr(ARowIndex));
  HTMLTextBuilder.WriteAttribute(aHeight, WebGrid.RowHeight);
  WriteGroupNodeHandler;

  WriteIndicatorCell(ARowIndex);
  WriteGroupNodeExpandingCells(ARowIndex);

  CellWidth := 0;
  for I := 0 to WebGrid.ColumnCount - 1 do
  begin
    if not WebGrid.IsVisibleColumn(I) then continue;
    CellWidth := CellWidth + WebGrid.Columns[I].Width;
  end;

  WebColumn := WebGrid.Columns[WebGrid.GetGroupingItemIndex(WebGrid.GetRowLevel(ARowIndex))];
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aId, WebGrid.Name + scxCellID + IntToStr(ARowIndex));
  HTMLTextBuilder.WriteAttribute(aClass, GroupNodesDefaultStyleName);
  HTMLTextBuilder.WriteAttribute(aBgcolor, '#D4D0C8');
  HTMLTextBuilder.WriteAttribute(aColspan, WebGrid.VisibleColumnsCount + WebGrid.GetExpandingLevel - WebGrid.GetRowLevel(ARowIndex));
  HTMLTextBuilder.WriteAttribute(aValign, 'center');
  HTMLTextBuilder.WriteAttribute(aWidth, CellWidth, 'px');
  WriteComponentEvents(GroupNodesHoverStyle, WebGrid.GroupNodesPopupMenu);
  if GroupNodesDefaultStyle = nil then
  begin
    HTMLTextBuilder.WriteStyleAttribute(saBorderStyle, 'solid');
    HTMLTextBuilder.WriteStyleAttribute(saBorderColor, '#000000');
    if WebGrid.ShowGrid then
    begin
      if ARowIndex <> WebGrid.LastVisibleRowIndex then
      begin
        HTMLTextBuilder.WriteStyleAttribute(saBorderBottomWidth, 1, 'px');
        HTMLTextBuilder.WriteStyleAttribute(saBorderLeftWidth, 0, 'px');
        HTMLTextBuilder.WriteStyleAttribute(saBorderRightWidth, 0, 'px');
        HTMLTextBuilder.WriteStyleAttribute(saBorderTopWidth, 0, 'px');
      end
      else HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, 0, 'px');
    end
    else HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, 0, 'px');
  end;
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagSpan, True, False);
  HTMLTextBuilder.WriteText('&nbsp;' + WebColumn.Title + ': ' + WebColumn.GetCellText(ARowIndex), False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagSpan, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
end;

procedure TcxCustomWebGridRenderer.WriteGroupNodeExpandingCells(ARowIndex: Integer);
var
  I, RowLevel, NextRowLevel: Integer;
begin
  RowLevel := WebGrid.GetRowLevel(ARowIndex);
  if (ARowIndex + 1) < WebGrid.RowCount then
    NextRowLevel := WebGrid.GetRowLevel(ARowIndex + 1)
  else NextRowLevel := -1;

  for I := 0 to RowLevel do
  begin
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
    HTMLTextBuilder.WriteAttribute(aClass, GroupNodesDefaultStyleName);
    HTMLTextBuilder.WriteAttribute(aBgcolor, '#D4D0C8');    
    HTMLTextBuilder.WriteAttribute(aWidth, WebGrid.IndicatorWidth, 'px');
    HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
    HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
    HTMLTextBuilder.WriteAttribute(aAlign, 'center');
    HTMLTextBuilder.WriteAttribute(aValign, 'center');
    WriteComponentEvents(GroupNodesHoverStyle, WebGrid.GroupNodesPopupMenu);
    HTMLTextBuilder.WriteStyleAttribute(saBorderStyle, 'solid');
    HTMLTextBuilder.WriteStyleAttribute(saBorderColor, '#000000');
    if WebGrid.ShowGrid then
    begin
      HTMLTextBuilder.WriteStyleAttribute(saBorderTopWidth, 0, 'px');
      HTMLTextBuilder.WriteStyleAttribute(saBorderLeftWidth, 0, 'px');
      if (NextRowLevel > I) or (ARowIndex = WebGrid.LastVisibleRowIndex) then
        HTMLTextBuilder.WriteStyleAttribute(saBorderBottomWidth, 0, 'px')
      else HTMLTextBuilder.WriteStyleAttribute(saBorderBottomWidth, 1, 'px');
      if I = RowLevel then
        HTMLTextBuilder.WriteStyleAttribute(saBorderRightWidth, 0, 'px')
      else HTMLTextBuilder.WriteStyleAttribute(saBorderRightWidth, 1, 'px');
    end
    else HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, 0, 'px');

    if I = RowLevel then
      WriteExpandButton(ARowIndex)
    else HTMLTextBuilder.WriteText('&nbsp;');
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  end;
end;

procedure TcxCustomWebGridRenderer.WriteEmptyNode(ARowIndex: Integer);
begin
  if WebGrid.KeepPageSize or (WebGrid.RowCount = 0) or (WebGrid.ColumnCount = 0) then
  begin
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
    HTMLTextBuilder.WriteAttribute(aId, WebGrid.Name + scxNodeID + IntToStr(ARowIndex));
    HTMLTextBuilder.WriteAttribute(aHeight, WebGrid.RowHeight);
    HTMLTextBuilder.WriteStyleAttribute(saCursor, 'default');
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
    HTMLTextBuilder.WriteAttribute(aColspan, WebGrid.VisibleColumnsCount + WebGrid.GetExpandingLevel);
    HTMLTextBuilder.WriteAttribute(aHeight, WebGrid.RowHeight);
    HTMLTextBuilder.WriteStyleAttribute(saBorderStyle, 'none');
    HTMLTextBuilder.WriteText('&nbsp;');
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  end;
end;

procedure TcxCustomWebGridRenderer.WriteNode(ARowIndex: Integer);
var
  I: Integer;
  IsEditing: Boolean;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteAttribute(aId, WebGrid.Name + scxNodeID + IntToStr(ARowIndex));
  HTMLTextBuilder.WriteAttribute(aHeight, WebGrid.RowHeight, 'px');
  HTMLTextBuilder.WriteStyleAttribute(saCursor, 'default');
  WriteNodeHandler;

  WriteIndicatorCell(ARowIndex);
  WriteNodeExpandingCells(ARowIndex);

  for I := 0 to WebGrid.ColumnCount - 1 do
  begin
    if not WebGrid.IsVisibleColumn(I) then continue;
    IsEditing := (WebGrid.FocusedRow = ARowIndex) and
        (not WebGrid.Columns[I].ReadOnly) and
        (WebGrid.Mode = mEdit);
    WriteCell(I, ARowIndex, IsEditing);
  end;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
end;

procedure TcxCustomWebGridRenderer.WriteNodeExpandingCells(ARowIndex: Integer);
var
  I, RowLevel, NextRowLevel: Integer;
begin
  RowLevel := WebGrid.GetRowLevel(ARowIndex);
  if (ARowIndex + 1) < WebGrid.RowCount then
    NextRowLevel := WebGrid.GetRowLevel(ARowIndex + 1)
  else NextRowLevel := -1;

  for I := 0  to RowLevel - 1 do
  begin
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
    HTMLTextBuilder.WriteAttribute(aClass, GroupNodesDefaultStyleName);
    HTMLTextBuilder.WriteAttribute(aBgcolor, '#D4D0C8');    
    HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
    HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
    HTMLTextBuilder.WriteAttribute(aWidth, WebGrid.IndicatorWidth, 'px');
    HTMLTextBuilder.WriteStyleAttribute(saBorderStyle, 'solid');
    HTMLTextBuilder.WriteStyleAttribute(saBorderColor, '#000000');
    if WebGrid.ShowGrid then
    begin
      HTMLTextBuilder.WriteStyleAttribute(saBorderTopWidth, 0, 'px');
      HTMLTextBuilder.WriteStyleAttribute(saBorderLeftWidth, 0, 'px');
      HTMLTextBuilder.WriteStyleAttribute(saBorderRightWidth, 1, 'px');
      if (NextRowLevel <= I) and (ARowIndex <> WebGrid.LastVisibleRowIndex) then
        HTMLTextBuilder.WriteStyleAttribute(saBorderBottomWidth, 1, 'px')
      else HTMLTextBuilder.WriteStyleAttribute(saBorderBottomWidth, 0, 'px');
    end
    else HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, 0, 'px');
    WriteComponentEvents(GroupNodesHoverStyle, WebGrid.GroupNodesPopupMenu);
    HTMLTextBuilder.WriteText('&nbsp;');
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  end;
end;

function TcxCustomWebGridRenderer.IsEmptyGroupPanel: Boolean;
var
  I, AIndex: Integer;
begin
  Result := True;
  for I := 0 to WebGrid.GetGroupingItemCount - 1 do
  begin
    AIndex := WebGrid.GetGroupingItemIndex(I);
    if (AIndex >= 0) and (AIndex < WebGrid.ColumnCount) and WebGrid.Columns[AIndex].Visible then
    begin
      Result := False;
      break;
    end;
  end;
end;

procedure TcxCustomWebGridRenderer.WriteGroupingPanelNode(ANodeIndex: Integer);
var
  AId, AHandler: string;
begin
  AId := Format('%s%s%d', [WebGrid.Name, scxGroupPanelNodeID, ANodeIndex]);
  AHandler := Format(scxGroupPanelNodeHandler, ['']);
  WriteHeaderCell(AId, HeaderDefaultStyleName, 'hand', '',
    AHandler, ANodeIndex, WebGrid.HeaderHeight,
    cxWebGridGroupPanelNodeWidth, True, HeaderHoverStyle);
end;

procedure TcxCustomWebGridRenderer.WriteEmptyGroupingPanel;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aWidth, '100%');
  WriteComponentEvents(GroupPanelHoverStyle, WebGrid.GroupPanelPopupMenu);
  HTMLTextBuilder.WriteStyleAttribute(saCursor, 'default');
  HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, 0, 'px');
  HTMLTextBuilder.WriteText(scxEmptyGroupPanelText);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
end;

type
  TcxGroupPanelCell = class
  private
    FBorderBottomWidth: Integer;
    FBorderLeftWidth: Integer;
    FBorderRightWidth: Integer;
    FBorderTopWidth: Integer;
    FColSpan: Integer;
    FHeight: Integer;
    FIndex: Integer;
    FInvalide: Boolean;
    FRenderer: TcxCustomWebGridRenderer;
    FRowSpan: Integer;
    FText: string;
    FWidth: Integer;

    procedure WriteBorders(HTMLTextBuilder: TcxHTMLTextBuilder);
  public
    constructor Create(ARenderer: TcxCustomWebGridRenderer);
    procedure Write(HTMLTextBuilder: TcxHTMLTextBuilder);

    property BorderBottomWidth: Integer read FBorderBottomWidth write FBorderBottomWidth;
    property BorderLeftWidth: Integer read FBorderLeftWidth write FBorderLeftWidth;
    property BorderRightWidth: Integer read FBorderRightWidth write FBorderRightWidth;
    property BorderTopWidth: Integer read FBorderTopWidth write FBorderTopWidth;
    property ColSpan: Integer read FColSpan write FColSpan;
    property Height: Integer read FHeight write FHeight;
    property Index: Integer read FIndex write FIndex;
    property Invalide: Boolean read FInvalide write FInvalide;
    property Renderer: TcxCustomWebGridRenderer read FRenderer;
    property RowSpan: Integer read FRowSpan write FRowSpan;
    property Text: string read FText write FText;
    property Width: Integer read FWidth write FWidth;
  end;

constructor TcxGroupPanelCell.Create(ARenderer: TcxCustomWebGridRenderer);
begin
  FRenderer := ARenderer;
  FBorderBottomWidth := 0;
  FBorderLeftWidth := 0;
  FBorderRightWidth := 0;
  FBorderTopWidth := 0;
  FColSpan := 1;
  FRowSpan := 1;
  FIndex := -1;
  FInvalide := False;
  FText := '';
end;

procedure TcxGroupPanelCell.WriteBorders(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
  if (BorderTopWidth <> 0) or (BorderRightWidth <> 0) or
    (BorderLeftWidth <> 0) or (BorderBottomWidth <> 0) then
  begin
    HTMLTextBuilder.WriteStyleAttribute(saBorderBottomWidth, BorderBottomWidth, 'px');
    HTMLTextBuilder.WriteStyleAttribute(saBorderLeftWidth, BorderLeftWidth, 'px');
    HTMLTextBuilder.WriteStyleAttribute(saBorderRightWidth, BorderRightWidth, 'px');
    HTMLTextBuilder.WriteStyleAttribute(saBorderTopWidth, BorderTopWidth, 'px');
    HTMLTextBuilder.WriteStyleAttribute(saBorderStyle, 'solid');
    HTMLTextBuilder.WriteStyleAttribute(saBorderColor, '#000000');
  end
  else HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, 0, 'px');
end;

procedure TcxGroupPanelCell.Write(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
  if not Invalide then
  begin
    if Index <> -1 then
    begin
      HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
      HTMLTextBuilder.WriteAttribute(aColspan, ColSpan);
      HTMLTextBuilder.WriteAttribute(aRowspan, RowSpan);
      HTMLTextBuilder.WriteAttribute(aHeight, Height, 'px');
      HTMLTextBuilder.WriteAttribute(aWidth, Width, 'px');
      WriteBorders(HTMLTextBuilder);
      Renderer.WriteGroupingPanelNode(Renderer.WebGrid.GetGroupingItemIndex(Index));
      HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
    end
    else
    begin
      HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
      HTMLTextBuilder.WriteAttribute(aColspan, ColSpan);
      HTMLTextBuilder.WriteAttribute(aRowspan, RowSpan);
      HTMLTextBuilder.WriteAttribute(aHeight, Height, 'px');
      HTMLTextBuilder.WriteAttribute(aWidth, Width, 'px');
      WriteBorders(HTMLTextBuilder);
      HTMLTextBuilder.WriteText(Text, False, False);
      HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
    end
  end;
end;

type
  TcxGroupPanelTableBuilder = class
  private
    FCells: TList;
    FRenderer: TcxCustomWebGridRenderer;

    function GetCell(RowIndex, ColIndex: Integer): TcxGroupPanelCell;
    function GetColCount: Integer;
    function GetItemCount: Integer;
    function GetRowCount: Integer;
  public
    constructor Create(ARenderer: TcxCustomWebGridRenderer);
    destructor Destroy; override;
    procedure BuildPanel; virtual;

    property Cells[RowIndex, ColIndex: Integer]: TcxGroupPanelCell read GetCell;
    property ColCount: Integer read GetColCount;
    property ItemCount: Integer read GetItemCount;
    property Renderer: TcxCustomWebGridRenderer read FRenderer;
    property RowCount: Integer read GetRowCount;
  end;

constructor TcxGroupPanelTableBuilder.Create(ARenderer: TcxCustomWebGridRenderer);
var
  I, J: Integer;
begin
  FRenderer := ARenderer;
  FCells := TList.Create;
  for I := 0 to RowCount - 1 do
    for J := 0 to ColCount - 1 do
    begin
      FCells.Add(TcxGroupPanelCell.Create(Renderer));
    end;

end;

destructor TcxGroupPanelTableBuilder.Destroy;
var
  I: Integer;
begin
  for I := 0 to FCells.Count - 1 do
    TcxGroupPanelCell(FCells.Items[I]).Free;
  FCells.Clear;
  FCells.Free;
  inherited;
end;

procedure TcxGroupPanelTableBuilder.BuildPanel;
var
  I, J: Integer;
  HIndex, VIndex: Integer;
begin
  for I := 0 to RowCount - 1 do
    for J := 0 to ColCount - 1 do
    begin
      if Cells[I, J].Invalide then continue;

      HIndex := J div 3;
      VIndex := (I - 1) div 2;

      if (I = 0) or (I = RowCount - 1) then
        Cells[I, J].Height := cxWebGridGroupPanelInterval
      else Cells[I, J].Height := Renderer.WebGrid.HeaderHeight div 4;
      if (J mod 3) = 0 then
        Cells[I, J].Width := cxWebGridGroupPanelInterval
      else
      begin
        if (HIndex = VIndex) and ((J - 1) mod 3 = 0) and ((I - 1) mod 2 = 0) then
        begin
          Cells[I, J].Width := cxWebGridGroupPanelNodeWidth;
          Cells[I, J].ColSpan := 2;
          Cells[I, J].RowSpan := 4;
          Cells[I + 1, J].Invalide := True;
          Cells[I + 2, J].Invalide := True;
          Cells[I + 3, J].Invalide := True;
          Cells[I, J + 1].Invalide := True;
          Cells[I + 1, J + 1].Invalide := True;
          Cells[I + 2, J + 1].Invalide := True;
          Cells[I + 3, J + 1].Invalide := True;
          Cells[I, J].Index := HIndex;
          if HIndex <> ItemCount -1 then
          begin
            Cells[I + 4, J + 1].BorderLeftWidth := 1;
            Cells[I + 4, J + 1].BorderBottomWidth := 1;
            Cells[I + 4, J + 2].BorderBottomWidth := 1;
            Cells[I + 4, J + 1].Text := Format('<IMG src="%s">', [QualifyImageFileName(scx1x1ImageName)]);
            Cells[I + 4, J + 2].Text := Format('<IMG src="%s">', [QualifyImageFileName(scx1x1ImageName)]);
          end;
        end
        else
        begin
          Cells[I, J].Width := cxWebGridGroupPanelNodeWidth div 2;
        end;
      end;
    end;
  for I := 0 to RowCount - 1 do
  begin
    Cells[I, ColCount - 1].Width := Renderer.WebGrid.Width - Renderer.WebGrid.BorderWidth;
    for J := 0 to ColCount - 2 do
    begin
      Cells[I, ColCount - 1].Width := Cells[I, ColCount - 1].Width - Cells[I, J].Width -
          cxWebGridGroupPanelInterval;
    end;
  end;

end;

function TcxGroupPanelTableBuilder.GetCell(RowIndex, ColIndex: Integer): TcxGroupPanelCell;
begin
  Result := TcxGroupPanelCell(FCells.Items[ColCount * RowIndex + ColIndex]);
end;

function TcxGroupPanelTableBuilder.GetColCount: Integer;
begin
  Result := 3 * ItemCount + 1;
end;

function TcxGroupPanelTableBuilder.GetItemCount: Integer;
begin
  Result := Renderer.WebGrid.GetGroupingItemCount;
end;

function TcxGroupPanelTableBuilder.GetRowCount: Integer;
begin
  Result := 1 + (ItemCount + 1) * 4 div 2 + 1;
end;

procedure TcxCustomWebGridRenderer.WriteGroupingPanel;
var
  I, J: Integer;
  TableBuilder: TcxGroupPanelTableBuilder;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv);
  HTMLTextBuilder.WriteAttribute(aId, WebGrid.Name + 'GroupPanel');
  HTMLTextBuilder.WriteStyleAttribute(saOverflow, 'hidden');
  HTMLTextBuilder.WriteStyleAttribute(saWidth, WebGrid.Width, 'px');

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aId, WebGrid.Name + 'GroupPanelTable');
  HTMLTextBuilder.WriteAttribute(aClass, GroupPanelDefaultStyleName);
  HTMLTextBuilder.WriteAttribute(aHeight, WebGrid.GroupPanelHeight);
  HTMLTextBuilder.WriteAttribute(aWidth, '100%');
  HTMLTextBuilder.WriteAttribute(aBorder, 1);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aBordercolor, cxWebColorToWebString(WebGrid.BorderColor));
  HTMLTextBuilder.WriteAttribute(aBgcolor, 'gray');
  if GroupPanelDefaultStyle = nil then
    HTMLTextBuilder.WriteStyleAttribute(saColor, 'lightgrey');
  if not IsAnyBorderStyleAssigned(GroupPanelDefaultStyle) then
    HTMLTextBuilder.WriteStyleAttribute(saBorderStyle, 'solid');
  if not IsAnyBorderWidthAssigned(GroupPanelDefaultStyle) then
    HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, WebGrid.BorderWidth, 'px');
  if IsEmptyGroupPanel then
    WriteEmptyGroupingPanel
  else
  begin
    TableBuilder := TcxGroupPanelTableBuilder.Create(Self);
    TableBuilder.BuildPanel;
    for I := 0 to TableBuilder.RowCount - 1 do
    begin
      HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
      HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, 1, 'px');
      for J := 0 to TableBuilder.ColCount - 1 do
        TableBuilder.Cells[I, J].Write(HTMLTextBuilder);
      HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
    end;
    TableBuilder.Free;
  end;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv);  
end;

procedure TcxCustomWebGridRenderer.WriteStatusPanel;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aId, WebGrid.Name + 'StatusPanelTable');
  HTMLTextBuilder.WriteAttribute(aWidth, WebGrid.Width, 'px');
  HTMLTextBuilder.WriteAttribute(aHeight, WebGrid.StatusPanelHeight);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aBordercolor, cxWebColorToWebString(WebGrid.BorderColor));
  HTMLTextBuilder.WriteAttribute(aBgcolor, 'gray');
  HTMLTextBuilder.WriteStyleAttribute(saBorderStyle, 'solid');
  HTMLTextBuilder.WriteStyleAttribute(saColor, cxWebColorToWebString(clWebButtonFace));
  HTMLTextBuilder.WriteStyleAttribute(saBorderBottomWidth, WebGrid.BorderWidth, 'px');
  HTMLTextBuilder.WriteStyleAttribute(saBorderLeftWidth, WebGrid.BorderWidth, 'px');
  HTMLTextBuilder.WriteStyleAttribute(saBorderRightWidth, WebGrid.BorderWidth, 'px');
  HTMLTextBuilder.WriteStyleAttribute(saBorderTopWidth, 0, 'px');
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteAttribute(aClass, StatusPanelDefaultStyleName);
  WriteComponentEvents(StatusPanelHoverStyle, WebGrid.StatusPanelPopupMenu);
  HTMLTextBuilder.WriteAttribute(aValign, 'center');
  HTMLTextBuilder.WriteAttribute(aHeight, WebGrid.StatusPanelHeight);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, 0, 'px');
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv);
  HTMLTextBuilder.WriteAttribute(aId, WebGrid.Name + 'StatusPanelText');
  HTMLTextBuilder.WriteText('&nbsp;' + WebGrid.StatusPanelText);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
end;

procedure TcxCustomWebGridRenderer.WriteHTML;
begin
  WriteGrid;
end;

class procedure TcxCustomWebGridRenderer.WriteClassHTML(AHTMLTextBuilder: TcxHTMLTextBuilder);
begin
  AHTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv);
  AHTMLTextBuilder.WriteAttribute(aId, scxDragNodeID);
  AHTMLTextBuilder.WriteAttribute(aClass, TcxWebGridDragHeaderStyle.GetName);
  AHTMLTextBuilder.WriteAttribute(aAlign, 'center');
  AHTMLTextBuilder.WriteEventAttribute(eOnMouseUp, Format(scxDraggingNodeHandler, ['event']));
  AHTMLTextBuilder.WriteStyleAttribute(saPosition, 'absolute');
  AHTMLTextBuilder.WriteStyleAttribute(saZIndex, 10000);
  AHTMLTextBuilder.WriteStyleAttribute(saVisibility, 'hidden');
  AHTMLTextBuilder.WriteStyleAttribute(saCursor, 'hand');
  AHTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv);

  AHTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv);
  AHTMLTextBuilder.WriteAttribute(aId, scxGroupUpImageID);
  AHTMLTextBuilder.WriteAttribute(aAlign, 'center');
  AHTMLTextBuilder.WriteStyleAttribute(saBorderWidth, 0, 'px');
  AHTMLTextBuilder.WriteStyleAttribute(saPosition, 'absolute');
  AHTMLTextBuilder.WriteStyleAttribute(saZIndex, 10001);
  AHTMLTextBuilder.WriteStyleAttribute(saVisibility, 'hidden');
  AHTMLTextBuilder.WriteSingleTag(TcxHTMLTagImg);
  AHTMLTextBuilder.WriteAttribute(aAlign, 'top');
  AHTMLTextBuilder.WriteAttribute(aBorder, 0);
  AHTMLTextBuilder.WriteAttribute(aSrc, QualifyImageFileName(cxGroupingImgs[arUp]));
  AHTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv);

  AHTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv);
  AHTMLTextBuilder.WriteAttribute(aId, scxGroupDownImageID);
  AHTMLTextBuilder.WriteAttribute(aAlign, 'center');
  AHTMLTextBuilder.WriteStyleAttribute(saBorderWidth, 0, 'px');
  AHTMLTextBuilder.WriteStyleAttribute(saPosition, 'absolute');
  AHTMLTextBuilder.WriteStyleAttribute(saZIndex, 10001);
  AHTMLTextBuilder.WriteStyleAttribute(saVisibility, 'hidden');
  AHTMLTextBuilder.WriteSingleTag(TcxHTMLTagImg);
  AHTMLTextBuilder.WriteAttribute(aAlign, 'top');
  AHTMLTextBuilder.WriteAttribute(aBorder, 0);
  AHTMLTextBuilder.WriteAttribute(aSrc, QualifyImageFileName(cxGroupingImgs[arDown]));
  AHTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv);
end;

procedure TcxCustomWebGridRenderer.WriteGrid;
begin
  with WebGrid do
    if not IsDesigning then
    begin
      UpdateColumnsLayout;
      RefreshPageSize;
    end;

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aWidth, WebGrid.Width, 'px');
  WriteID;
  WriteAttributes;
  WritePosition;
  WriteZIndex;
  WriteStyleAttributes;

  if WebGrid.ShowGroupPanel then
  begin
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
    HTMLTextBuilder.WriteAttribute(aWidth, WebGrid.Width, 'px');
    WriteGroupingPanel;
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  end;
  if WebGrid.ShowHeader then
  begin
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
    HTMLTextBuilder.WriteAttribute(aWidth, WebGrid.Width, 'px');
    WriteHeader;
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  end;

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aWidth, WebGrid.Width, 'px');
  WriteDataFrame;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);

  if WebGrid.ShowStatusPanel then
  begin
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
    HTMLTextBuilder.WriteAttribute(aWidth, WebGrid.Width, 'px');
    WriteStatusPanel;
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  end;

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
end;

class procedure TcxCustomWebGridRenderer.GetScriptFiles(AList: TStrings);
begin
  AList.Add(scxCommonScriptName);
  AList.Add(scxGridScriptName);
  AList.Add(scxGridPainterScriptName);
end;

procedure TcxCustomWebGridRenderer.WriteHiddenFormElements;
var
  I: Integer;
  S: string;
begin
  WriteHiddenField(WebGrid.Name + 'FirstVisibleRow', IntToStr(WebGrid.FirstVisibleRow));
  S := '';
  for I := 0 to WebGrid.ColumnCount - 1 do
    if I <> WebGrid.ColumnCount - 1 then
      S := Format('%s%d:', [S, I])
    else S := S + IntToStr(I);
  WriteHiddenField(WebGrid.Name + 'ColumnIndexes', S);
  WriteHiddenField(WebGrid.Name + 'EditMode', cxWebUtils.BoolToStr(WebGrid.Mode = mEdit));
end;

procedure TcxCustomWebGridRenderer.WriteScripts;
var
  I: Integer;
begin
  WriteEventsScript;
  HTMLTextBuilder.WriteText('_Grid = CreateGrid();');
  HTMLTextBuilder.WriteText(Format('  _Grid.Name = "%s";', [WebGrid.Name]));
  HTMLTextBuilder.WriteText(Format('  _Grid.PageSize = %d;', [WebGrid.PageSize]));
  HTMLTextBuilder.WriteText(Format('  _Grid.Width = %d;', [WebGrid.Width]));
  HTMLTextBuilder.WriteText(Format('  _Grid.ControlColumnWidth = %d;', [WebGrid.IndicatorWidth]));
  HTMLTextBuilder.WriteText(Format('  _Grid.BorderWidth = %d;', [WebGrid.BorderWidth]));
  HTMLTextBuilder.WriteText(Format('  _Grid.AutoWidth = "%s";', [cxWebUtils.BoolToStr(WebGrid.AutoWidth)]));
  HTMLTextBuilder.WriteText(Format('  _Grid.HeaderHeight = %d;', [WebGrid.HeaderHeight]));
  HTMLTextBuilder.WriteText(Format('  _Grid.RowHeight = %d;', [WebGrid.RowHeight]));
  HTMLTextBuilder.WriteText(Format('  _Grid.KeepRowHeight = %s;', [cxWebUtils.BoolToStr(WebGrid.KeepRowHeight)]));
  HTMLTextBuilder.WriteText(Format('  _Grid.HeaderStyle = "%s";', [HeaderDefaultStyleName]));
  HTMLTextBuilder.WriteText(Format('  _Grid.GroupPanelStyle = "%s";', [GroupPanelDefaultStyleName]));
  HTMLTextBuilder.WriteText(Format('  _Grid.IndicatorStyle = "%s";', [IndicatorDefaultStyleName]));
  HTMLTextBuilder.WriteText(Format('  _Grid.GroupNodesStyle = "%s";', [GroupNodesDefaultStyleName]));
  HTMLTextBuilder.WriteText(Format('  _Grid.StatusPanel = "%s";', [StatusPanelDefaultStyleName]));
  HTMLTextBuilder.WriteText(Format('  _Grid.FirstVisibleRow = %d;', [WebGrid.FirstVisibleRow]));
  HTMLTextBuilder.WriteText(Format('  _Grid.SavedFirstVisibleRow = %d;', [WebGrid.FirstVisibleRow]));
  HTMLTextBuilder.WriteText(Format('  _Grid.SavedFocusedRow = %d;', [WebGrid.FocusedRow]));
  HTMLTextBuilder.WriteText(Format('  _Grid.SelectedForeColor = "%s";', [cxWebColorToWebString(WebGrid.SelectedFontColor)]));
  HTMLTextBuilder.WriteText(Format('  _Grid.SelectedBackColor = "%s";', [cxWebColorToWebString(WebGrid.SelectedColor)]));
  HTMLTextBuilder.WriteText(Format('  _Grid.LBCursorStyle = %s;', [cxWebUtils.BoolToStr(IsIndicatorCursorType)]));
  HTMLTextBuilder.WriteText(Format('  _Grid.ReadOnly = %s;', [cxWebUtils.BoolToStr(WebGrid.ReadOnly)]));
  WriteEvents;
  HTMLTextBuilder.WriteText(Format('  _Grid.ShowGrid = %s;', [cxWebUtils.BoolToStr(WebGrid.ShowGrid)]));
  HTMLTextBuilder.WriteText(Format('  _Grid.ShowHeader = %s;', [cxWebUtils.BoolToStr(WebGrid.ShowHeader)]));
  HTMLTextBuilder.WriteText(Format('  _Grid.ShowGroupPanel = %s;', [cxWebUtils.BoolToStr(WebGrid.ShowGroupPanel)]));
  HTMLTextBuilder.WriteText(Format('  _Grid.ShowGroupedColumns = %s;', [cxWebUtils.BoolToStr(WebGrid.ShowGroupedColumns)]));
  HTMLTextBuilder.WriteText(Format('  _Grid.ShowIndicator = %s;', [cxWebUtils.BoolToStr(WebGrid.ShowIndicator)]));
  HTMLTextBuilder.WriteText(Format('  _Grid.ShowStatusPanel = %s;', [cxWebUtils.BoolToStr(WebGrid.ShowStatusPanel)]));
  for I := 0 to WebGrid.ColumnCount - 1 do
    WebGrid.Columns[I].WriteScript(HTMLTextBuilder);
end;

class procedure TcxCustomWebGridRenderer.WriteClassScripts(AHTMLTextBuilder: TcxHTMLTextBuilder);
var
  SortMode: TcxWebGridSortMode;
  Button: TcxWebGridButtons;
begin
  AHTMLTextBuilder.WriteText('var GridSortingImages = new Array();');
  for SortMode := Low(TcxWebGridSortMode) to High(TcxWebGridSortMode) do
    AHTMLTextBuilder.WriteText(Format('    GridSortingImages[%d] = "%s";',
        [Integer(SortMode), QualifyImageFileName(cxSortingImgs[SortMode])]));
  AHTMLTextBuilder.WriteText('var GridButtonsImages = new Array();');
  for Button := Low(TcxWebGridButtons) to High(TcxWebGridButtons) do
    AHTMLTextBuilder.WriteText(Format('    GridButtonsImages[%d] = "%s";',
        [Integer(Button), QualifyImageFileName(cxWebGridButtonImgs[Button])]));
  AHTMLTextBuilder.WriteText(Format('var InvisibleImage = "%s";',
      [QualifyImageFileName(scx1x1ImageName)]));
  AHTMLTextBuilder.WriteText(Format('var scxEmptyGroupPanelText = "%s";', [scxEmptyGroupPanelText]));
  AHTMLTextBuilder.WriteText(Format('var scxStatusBarText = "%s";', [scxStatusBarText]));
  AHTMLTextBuilder.WriteText(Format('var scxStatusBarEmptyGridText = "%s";', [scxStatusBarEmptyGridText]));
end;

class procedure TcxCustomWebGridRenderer.WriteStyles(AHTMLTextBuilder: TcxHTMLTextBuilder);
begin
  TcxWebGridButtonStyle.WriteStyle(AHTMLTextBuilder);
  TcxWebGridGroupNodesStyle.WriteStyle(AHTMLTextBuilder);
  TcxWebGridPanelsStyle.WriteStyle(AHTMLTextBuilder);
  TcxWebGridDragHeaderStyle.WriteStyle(AHTMLTextBuilder);
end;

{ TcxWebGridButtonNS4Style }

class function TcxWebGridButtonNS4Style.GetName: string;
begin
  Result := 'BtnNS4Style';
end;

class procedure TcxWebGridButtonNS4Style.WriteStyle(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
  HTMLTextBuilder.WriteStyle(GetName);
  HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, 1, 'px');
  HTMLTextBuilder.WriteStyleAttribute(saBorderStyle, 'solid');
  HTMLTextBuilder.WriteStyleAttribute(saBorderColor, 'black');
  HTMLTextBuilder.WriteStyleAttribute(saBackgroundColor, '#D4D0C8');
end;

{ TcxCustomWebGridNS4Renderer }

function TcxCustomWebGridNS4Renderer.IsIndicatorCursorType: Boolean;
begin
  Result := true;
end;

procedure TcxCustomWebGridNS4Renderer.WriteButton(ID, ClassName, Handler, ImageID, ImageSrc, Hint: string;
    ImageIndex, Height, Width: Integer; HoverStyle: TcxWebStyleItem);
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aHeight, Height);
  HTMLTextBuilder.WriteAttribute(aWidth, Width, 'px');
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr, True, False);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteAttribute(aHeight, 1);
  HTMLTextBuilder.WriteAttribute(aWidth, 1);
  HTMLTextBuilder.WriteAttribute(aBgcolor, 'white');
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aHeight, 1);
  HTMLTextBuilder.WriteAttribute(aBgcolor, 'white');
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aHeight, 1);
  HTMLTextBuilder.WriteAttribute(aWidth, 1);
  HTMLTextBuilder.WriteAttribute(aBgcolor, 'black');
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr, False, True);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aWidth, 1);
  HTMLTextBuilder.WriteAttribute(aBgcolor, 'white');
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aHeight, Height - 2);
  HTMLTextBuilder.WriteAttribute(aWidth, 3000);
  HTMLTextBuilder.WriteAttribute(aBgcolor, '#D4D0C8');
  HTMLTextBuilder.WriteAttribute(aAlign, 'center');
  HTMLTextBuilder.WriteAttribute(aValign, 'center');

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagA, False, False);
  HTMLTextBuilder.WriteAttribute(aHref, 'javascript:' + Handler);
//  HTMLTextBuilder.WriteEventAttribute(eOnClick, Handler);

  if (WebGrid.Images <> nil) and (WebGrid.Images.ValidIndex(ImageIndex)) then
    WebGrid.Images.Images[ImageIndex].WriteHTML(HTMLTextBuilder)
  else
  begin
    HTMLTextBuilder.WriteSingleTag(TcxHTMLTagImg, False, False);
    HTMLTextBuilder.WriteAttribute(aSrc, ImageSrc);
    HTMLTextBuilder.WriteAttribute(aBorder, 0);
    if WebGrid.ShowHint then
      HTMLTextBuilder.WriteAttribute(aTitle, Hint);
  end;
  HTMLTextBuilder.WriteAttribute(aId, ImageID);
  HTMLTextBuilder.WriteAttribute(aName, ImageID);
  HTMLTextBuilder.WriteAttribute(aAlign, 'absmiddle');

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagA, False, False);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aWidth, 1);
  HTMLTextBuilder.WriteAttribute(aBgcolor, 'black');
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr, True, False);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteAttribute(aHeight, 1);
  HTMLTextBuilder.WriteAttribute(aWidth, 1);
  HTMLTextBuilder.WriteAttribute(aBgcolor, 'black');
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aHeight, 1);
  HTMLTextBuilder.WriteAttribute(aBgcolor, 'black');
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aHeight, 1);
  HTMLTextBuilder.WriteAttribute(aWidth, 1);
  HTMLTextBuilder.WriteAttribute(aBgcolor, 'black');
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr, False, True);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
end;

procedure TcxCustomWebGridNS4Renderer.WriteCancelButton;
var
  AID, AHandler, AImageID, AImageSrc: string;
begin
  AID := Format('%s%s', [WebGrid.Name, scxCancelBtnID]);
  AImageID := Format('%s%s', [WebGrid.Name, scxCancelImgID]);
  AImageSrc := QualifyImageFileName(cxWebGridButtonImgs[gbCancel]);
  AHandler := Format(scxCancelBtnNS4Handler, [Format('''%s''', [WebGrid.Name])]);

  WriteButton(AID, IndicatorDefaultStyleName, AHandler,
    AImageID, AImageSrc, scxCancelBtnHint, WebGrid.ImageIndexes.Cancel, WebGrid.HeaderHeight,
    WebGrid.IndicatorWidth - 2, IndicatorHoverStyle);
end;

procedure TcxCustomWebGridNS4Renderer.WriteExpandButton(ARowIndex: Integer);
var
  AID, AHandler, AImageID, AImageSrc: string;
begin
  AID := Format('%s%s%d', [WebGrid.Name, scxExpandBtnID, ARowIndex]);
  AImageID := Format('%s%s', [WebGrid.Name, scxExpandImgID]);
  AImageSrc := GetExpandImageSrc(ARowIndex);
  AHandler := Format(scxExpandBtnNS4Handler, [Format('''%s'', %d', [WebGrid.Name, ARowIndex])]);

  WriteButton(AID, IndicatorDefaultStyleName, AHandler,
    AImageID, AImageSrc, '', GetExpandImageIndex(ARowIndex), cxWebGridExpandBitmapHeight + 2,
    cxWebGridExpandBitmapWidth + 2, IndicatorHoverStyle);
end;

procedure TcxCustomWebGridNS4Renderer.WriteHeaderButton;
var
  AID, AImageSrc: string;
begin
  AID := Format('%s%s', [WebGrid.Name, scxHeaderBtnID]);
  AImageSrc := QualifyImageFileName(cxWebGridButtonImgs[gbNode]);

  WriteButton(AID, IndicatorDefaultStyleName, '', '', AImageSrc, '', WebGrid.ImageIndexes.Node,
      WebGrid.HeaderHeight, WebGrid.IndicatorWidth - 2, IndicatorHoverStyle);
end;

procedure TcxCustomWebGridNS4Renderer.WriteNodeButton(ARowIndex: Integer);
var
  AID, AHandler, AImageID, AImageSrc: string;
begin
  AID := Format('%s%s%d', [WebGrid.Name, scxNodeBtnID, ARowIndex]);
  AImageID := Format('%s%s%d', [WebGrid.Name, scxNodeImgID, ARowIndex]);
  AImageSrc := GetNodeImageSrc(ARowIndex);
  AHandler := Format(scxNodeBtnNS4Handler, [Format('''%s'', %d', [WebGrid.Name, ARowIndex])]);

  WriteButton(AID, IndicatorDefaultStyleName, AHandler,
    AImageID, AImageSrc, scxNodeBtnHint + IntToStr(ARowIndex), WebGrid.ImageIndexes.Node,
    WebGrid.RowHeight, WebGrid.IndicatorWidth - 2, IndicatorHoverStyle);
end;

procedure TcxCustomWebGridNS4Renderer.WriteOkButton(ARowIndex: Integer);
var
  AID, AHandler, AImageID, AImageSrc: string;
begin
  AID := Format('%s%s%d', [WebGrid.Name, scxPostBtnID, ARowIndex]);
  AImageID := Format('%s%s', [WebGrid.Name, scxPostImgID]);
  AImageSrc := QualifyImageFileName(cxWebGridButtonImgs[gbPost]);
  AHandler := Format(scxPostBtnNS4Handler, [Format('''%s''', [WebGrid.Name])]);

  WriteButton(AID, IndicatorDefaultStyleName, AHandler,
    AImageID, AImageSrc, scxPostBtnHint, WebGrid.ImageIndexes.Post,
    WebGrid.RowHeight, WebGrid.IndicatorWidth - 2, IndicatorHoverStyle);
end;

const
  scxLTImgID = 'LTImg';
  scxRBImgID = 'RBImg';

procedure TcxCustomWebGridNS4Renderer.WriteHeaderCell(ID, ClassName, Cursor, Hint, Handler: string;
    ColumnIndex, Height, Width: Integer; ShowSortImage: Boolean; HoverStyle: TcxWebStyleItem);
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  if Hint <> '' then HTMLTextBuilder.WriteAttribute(aTitle, Hint);  
  HTMLTextBuilder.WriteAttribute(aHeight, Height);
  HTMLTextBuilder.WriteAttribute(aWidth, Width);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr, True, False);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteAttribute(aHeight, 1);
  HTMLTextBuilder.WriteAttribute(aWidth, 1);
  HTMLTextBuilder.WriteAttribute(aBgcolor, 'white');
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteAttribute(aName, ID + scxLTImgID);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aHeight, 1);
  HTMLTextBuilder.WriteAttribute(aBgcolor, 'white');
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aHeight, 1);
  HTMLTextBuilder.WriteAttribute(aBgcolor, 'white');
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aHeight, 1);
  HTMLTextBuilder.WriteAttribute(aWidth, 1);
  HTMLTextBuilder.WriteAttribute(aBgcolor, 'black');
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr, False, True);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aWidth, 1);
  HTMLTextBuilder.WriteAttribute(aBgcolor, 'white');
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aHeight, Height - 2);
  HTMLTextBuilder.WriteAttribute(aWidth, Width - cxWebGridSortBitmapWidth - 2);
  HTMLTextBuilder.WriteAttribute(aBgcolor, '#D4D0C8');
  HTMLTextBuilder.WriteAttribute(aAlign, 'center');
  HTMLTextBuilder.WriteAttribute(aValign, 'center');

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagA, True, False);
  HTMLTextBuilder.WriteAttribute(aHref, '#');
  HTMLTextBuilder.WriteEventAttribute(eOnMouseDown, Handler);
  HTMLTextBuilder.WriteText(WebGrid.Columns[ColumnIndex].Title + '&nbsp;', False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagA, False, True);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aBgcolor, '#D4D0C8');
  HTMLTextBuilder.WriteAttribute(aAlign, 'center');
  HTMLTextBuilder.WriteAttribute(aValign, 'center');
  if ShowSortImage then WriteSortButton(ColumnIndex);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aWidth, 1);
  HTMLTextBuilder.WriteAttribute(aBgcolor, 'black');
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr, True, False);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteAttribute(aHeight, 1);
  HTMLTextBuilder.WriteAttribute(aWidth, 1);
  HTMLTextBuilder.WriteAttribute(aBgcolor, 'black');
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aHeight, 1);
  HTMLTextBuilder.WriteAttribute(aBgcolor, 'black');
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aHeight, 1);
  HTMLTextBuilder.WriteAttribute(aBgcolor, 'black');
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aHeight, 1);
  HTMLTextBuilder.WriteAttribute(aWidth, 1);
  HTMLTextBuilder.WriteAttribute(aBgcolor, 'black');
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteAttribute(aName, ID + scxRBImgID);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr, False, True);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
end;

procedure TcxCustomWebGridNS4Renderer.WriteHeaderNode(AColumnIndex: Integer);
var
  AId, AHint, AHandler: string;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aWidth, WebGrid.GetHeaderColumnWidth(AColumnIndex));
  HTMLTextBuilder.WriteAttribute(aAlign, cxWebHorzAlignment[WebGrid.Columns[AColumnIndex].Alignment]);
  HTMLTextBuilder.WriteAttribute(aValign, 'center');
  HTMLTextBuilder.WriteAttribute(aWidth, WebGrid.GetHeaderColumnWidth(AColumnIndex));
  HTMLTextBuilder.WriteStyleAttribute(saBackgroundColor, '#D4D0C8');

  AId := Format('%s%s%d', [WebGrid.Name, scxHeaderNodeID, AColumnIndex]);
  if WebGrid.GetItemGroupIndex(AColumnIndex) = -1 then
    AHandler := Format(scxHeaderNodeHandler, [Format('event, ''%s'', %d',
        [WebGrid.Name, AColumnIndex])])
  else AHandler := '';
  if WebGrid.Columns[AColumnIndex].ShowHeaderHint then
    AHint := WebGrid.Columns[AColumnIndex].HeaderHint
  else AHint := '';
  WriteHeaderCell(AId, HeaderDefaultStyleName, 'hand', AHint, AHandler, AColumnIndex,
      WebGrid.HeaderHeight, WebGrid.GetHeaderColumnWidth(AColumnIndex) - 2, True, nil);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
end;

procedure TcxCustomWebGridNS4Renderer.WriteDataFrame;
var
  I: Integer;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aWidth, WebGrid.Width);
  HTMLTextBuilder.WriteAttribute(aBorder, 1);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);

  for I := WebGrid.FirstVisibleRow to WebGrid.FirstVisibleRow + WebGrid.PageSize - 1 do
  begin
    if WebGrid.IsVisibleRow(I) then
    begin
      if WebGrid.GetRowLevel(I) < WebGrid.GetGroupingItemCount then
        WriteGroupNode(I)
      else WriteNode(I);
    end
    else WriteEmptyNode(I);
  end;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
end;

const
  scxGPLT = 'GPLT';
  scxGPRB = 'GPRB';

procedure TcxCustomWebGridNS4Renderer.WriteGroupingPanel;
var
  I: Integer;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aHeight, WebGrid.GroupPanelHeight);
  HTMLTextBuilder.WriteAttribute(aWidth, WebGrid.Width);
  HTMLTextBuilder.WriteAttribute(aBorder, 1);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aBgcolor, 'gray');

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aWidth, '100%');

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aWidth, '100%');
  HTMLTextBuilder.WriteAttribute(aHeight, WebGrid.GroupPanelHeight);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr, True, False);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteAttribute(aHeight, 1);
  HTMLTextBuilder.WriteAttribute(aWidth, 1);
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteAttribute(aName, WebGrid.Name + scxGPLT);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteAttribute(aHeight, 1);
  HTMLTextBuilder.WriteAttribute(aWidth, '100%');
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteAttribute(aHeight, 1);
  HTMLTextBuilder.WriteAttribute(aWidth, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr, False, True);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr, True, False);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteAttribute(aWidth, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aHeight, WebGrid.GroupPanelHeight - 2);
  HTMLTextBuilder.WriteAttribute(aWidth, '100%');
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aBgcolor, 'gray');  
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);

  if IsEmptyGroupPanel then
    WriteEmptyGroupingPanel
  else
  begin
    for I := 0 to WebGrid.GetGroupingItemCount - 1 do
    begin
      HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
      HTMLTextBuilder.WriteAttribute(aWidth, cxWebGridGroupPanelInterval div 2, 'px');
      HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);

      WriteGroupingPanelNode(WebGrid.GetGroupingItemIndex(I));

      HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
      HTMLTextBuilder.WriteAttribute(aWidth, cxWebGridGroupPanelInterval div 2, 'px');
      HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
    end;
  end;

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aWidth, '100%');
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aWidth, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr, False, True);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr, True, False);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteAttribute(aHeight, 1);
  HTMLTextBuilder.WriteAttribute(aWidth, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteAttribute(aHeight, 1);
  HTMLTextBuilder.WriteAttribute(aWidth, '100%');
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteAttribute(aHeight, 1);
  HTMLTextBuilder.WriteAttribute(aWidth, 1);
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteAttribute(aName, WebGrid.Name + scxGPRB);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr, False, True);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
end;

procedure TcxCustomWebGridNS4Renderer.WriteGroupingPanelNode(ANodeIndex: Integer);
var
  AId, AHandler: string;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aAlign, cxWebHorzAlignment[WebGrid.Columns[ANodeIndex].Alignment]);
  HTMLTextBuilder.WriteAttribute(aValign, 'center');
  HTMLTextBuilder.WriteAttribute(aWidth, cxWebGridGroupPanelNodeWidth - 2);

  AId := Format('%s%s%d', [WebGrid.Name, scxGroupPanelNodeID, ANodeIndex]);
  AHandler := Format(scxGroupPanelNodeHandler, [Format('event, ''%s'', %d',
      [WebGrid.Name, ANodeIndex])]);
  WriteHeaderCell(AId, HeaderDefaultStyleName, 'hand', '', AHandler, ANodeIndex,
      WebGrid.HeaderHeight, cxWebGridGroupPanelNodeWidth - 2, True, nil);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
end;

procedure TcxCustomWebGridNS4Renderer.WriteHeader;
var
  I: Integer;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aWidth, WebGrid.Width);
  HTMLTextBuilder.WriteAttribute(aBorder, 1);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aBgcolor, 'ButtonFace');

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteAttribute(aHeight, WebGrid.HeaderHeight);
  WriteIndicatorHeaderCell;
  for I := 0 to WebGrid.ColumnCount - 1 do
  begin
    if not WebGrid.IsVisibleColumn(I) then continue;
    WriteHeaderNode(I);
  end;
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
end;

procedure TcxCustomWebGridNS4Renderer.WriteStatusPanel;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aWidth, WebGrid.Width);
  HTMLTextBuilder.WriteAttribute(aHeight, WebGrid.StatusPanelHeight);
  HTMLTextBuilder.WriteAttribute(aBorder, 1);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aBgcolor, 'gray');
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteAttribute(aValign, 'center');
  HTMLTextBuilder.WriteAttribute(aHeight, WebGrid.StatusPanelHeight);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aAlign, 'left');
  HTMLTextBuilder.WriteText('&nbsp;' + WebGrid.StatusPanelText);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
end;

class procedure TcxCustomWebGridNS4Renderer.WriteClassHTML(AHTMLTextBuilder: TcxHTMLTextBuilder);
begin
end;

class procedure TcxCustomWebGridNS4Renderer.WriteStyles(AHTMLTextBuilder: TcxHTMLTextBuilder);
begin
  TcxWebGridButtonNS4Style.WriteStyle(AHTMLTextBuilder);
end;

class function TcxCustomWebGridNS4Renderer.IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean;
begin
  Result := AWebBrowser = TcxWebBrowserNS4;
end;

procedure TcxCustomWebGridNS4Renderer.WriteOutOfFormHTML;
var
  I, AWidth: Integer;
begin
  for I := 0 to WebGrid.ColumnCount - 1 do
  begin
    if not WebGrid.Columns[I].Visible then continue;

    if WebGrid.Columns[I].GetGroupingIndex < 0 then
      AWidth := WebGrid.GetHeaderColumnWidth(I)
    else AWidth := cxWebGridGroupPanelNodeWidth;

    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagLayer, True, False);
    HTMLTextBuilder.WriteAttribute(aName, WebGrid.Name + scxDragNodeID + IntToStr(I));
    HTMLTextBuilder.WriteAttribute(aBgcolor, 'white');
    HTMLTextBuilder.WriteAttribute(aVisibility, 'hidden');
    WriteHeaderCell('', '', 'hand', '', '', I, WebGrid.HeaderHeight, AWidth, True, nil);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagLayer, False, True);
  end;
end;

{ TcxCustomWebGridNS6Renderer }

procedure TcxCustomWebGridNS6Renderer.WriteNodeHandler;
begin
end;

procedure TcxCustomWebGridNS6Renderer.WriteGroupNodeHandler;
begin
end;

procedure TcxCustomWebGridNS6Renderer.WriteButton(
    ID, ClassName, Handler, ImageID, ImageSrc, Hint: string;
    ImageIndex, Height, Width: Integer; HoverStyle: TcxWebStyleItem);
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv);
  HTMLTextBuilder.WriteAttribute(aId, ID);
  HTMLTextBuilder.WriteAttribute(aClass, ClassName);
  HTMLTextBuilder.WriteAttribute(aAlign, 'center');
  HTMLTextBuilder.WriteStyleAttribute(saHeight, Height - 2, 'px');
  HTMLTextBuilder.WriteStyleAttribute(saWidth, Width - 2, 'px');
  WriteComponentEvents(HoverStyle, WebGrid.IndicatorPopupMenu);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aHeight, Height - 2);
  HTMLTextBuilder.WriteAttribute(aWidth, Width - 2);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aAlign, 'center');
  HTMLTextBuilder.WriteAttribute(aValign, 'center');

  if (WebGrid.Images <> nil) and (WebGrid.Images.ValidIndex(ImageIndex)) then
    WebGrid.Images.Images[ImageIndex].WriteHTML(HTMLTextBuilder)
  else
  begin
    HTMLTextBuilder.WriteSingleTag(TcxHTMLTagImg);
    HTMLTextBuilder.WriteAttribute(aSrc, ImageSrc);
    if WebGrid.ShowHint then
      HTMLTextBuilder.WriteAttribute(aTitle, Hint);
    HTMLTextBuilder.WriteAttribute(aAlt, Hint);
    HTMLTextBuilder.WriteAttribute(aBorder, 0);
  end;
  HTMLTextBuilder.WriteAttribute(aId, ImageId);
  HTMLTextBuilder.WriteAttribute(aAlign, 'top');

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv);
end;

procedure TcxCustomWebGridNS6Renderer.WriteHeaderCell(ID, ClassName, Cursor, Hint, Handler: string;
    ColumnIndex, Height, Width: Integer; ShowSortImage: Boolean; HoverStyle: TcxWebStyleItem);
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv);
  if ID <> '' then HTMLTextBuilder.WriteAttribute(aId, ID);
  if ClassName <> '' then HTMLTextBuilder.WriteAttribute(aClass, ClassName);
  if Hint <> '' then HTMLTextBuilder.WriteAttribute(aTitle, Hint);
  if Cursor <> '' then HTMLTextBuilder.WriteStyleAttribute(saCursor, Cursor);
  HTMLTextBuilder.WriteStyleAttribute(saPosition, 'releative');
  HTMLTextBuilder.WriteStyleAttribute(saHeight, Height - 2, 'px');
  HTMLTextBuilder.WriteStyleAttribute(saWidth, Width - 2, 'px');
  HTMLTextBuilder.WriteStyleAttribute(saOverflow, 'hidden');
  WriteComponentEvents(HoverStyle, WebGrid.HeaderPopupMenu);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aClass, ClassName);
  HTMLTextBuilder.WriteAttribute(aHeight, Height - 2);
  HTMLTextBuilder.WriteAttribute(aWidth, Width - 2);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, 0, 'px');
  WriteComponentEvents(HoverStyle, WebGrid.HeaderPopupMenu);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aAlign, 'center');
  HTMLTextBuilder.WriteAttribute(aValign, 'center');
  HTMLTextBuilder.WriteText(WebGrid.Columns[ColumnIndex].Title + '&nbsp;');
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aAlign, 'center');
  HTMLTextBuilder.WriteAttribute(aValign, 'center');
  HTMLTextBuilder.WriteAttribute(aWidth, cxWebGridSortBitmapWidth + 4);
  if ShowSortImage then
    WriteSortButton(ColumnIndex);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv);
end;

procedure TcxCustomWebGridNS6Renderer.WriteGroupingPanel;
var
  I: Integer;
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv);
  HTMLTextBuilder.WriteAttribute(aId, WebGrid.Name + 'GroupPanel');
  HTMLTextBuilder.WriteStyleAttribute(saOverflow, 'hidden');
  HTMLTextBuilder.WriteStyleAttribute(saWidth, WebGrid.Width, 'px');

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aId, WebGrid.Name + 'GroupPanelTable');
  HTMLTextBuilder.WriteAttribute(aClass, GroupPanelDefaultStyleName);
  HTMLTextBuilder.WriteAttribute(aHeight, WebGrid.GroupPanelHeight);
  HTMLTextBuilder.WriteAttribute(aWidth, '100%');
  HTMLTextBuilder.WriteAttribute(aBorder, 1);
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aBordercolor, cxWebColorToWebString(WebGrid.BorderColor));
  HTMLTextBuilder.WriteAttribute(aBgcolor, 'gray');
  HTMLTextBuilder.WriteStyleAttribute(saBorderStyle, 'solid');
  if GroupPanelDefaultStyle = nil then
    HTMLTextBuilder.WriteStyleAttribute(saColor, 'lightgrey');
  HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, WebGrid.BorderWidth, 'px');
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTr, True, False);

  if IsEmptyGroupPanel then
    WriteEmptyGroupingPanel
  else
  begin
    for I := 0 to WebGrid.GetGroupingItemCount - 1 do
    begin
      HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
      HTMLTextBuilder.WriteAttribute(aWidth, cxWebGridGroupPanelInterval div 2);
      HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, 0, 'px');
      WriteInvisibleImage(cxWebGridGroupPanelInterval div 2, 1);
      HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);

      HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
      HTMLTextBuilder.WriteAttribute(aWidth, cxWebGridGroupPanelNodeWidth);
      HTMLTextBuilder.WriteAttribute(aValign, 'center');
      HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, 0, 'px');
      WriteGroupingPanelNode(WebGrid.GetGroupingItemIndex(I));
      HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);

      HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
      HTMLTextBuilder.WriteAttribute(aWidth, cxWebGridGroupPanelInterval div 2);
      HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, 0, 'px');
      WriteInvisibleImage(cxWebGridGroupPanelInterval div 2, 1);
      HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
    end;
  end;

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aWidth, '100%');
  HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, 0, 'px');
  WriteInvisibleImage(1, 1);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTr);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv);
end;

class function TcxCustomWebGridNS6Renderer.IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean;
begin
  Result := AWebBrowser = TcxWebBrowserNS6;
end;

class procedure TcxCustomWebGridNS6Renderer.WriteClassHTML(AHTMLTextBuilder: TcxHTMLTextBuilder);
begin
  AHTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv);
  AHTMLTextBuilder.WriteAttribute(aId, scxDragNodeID);
  AHTMLTextBuilder.WriteAttribute(aClass, TcxWebGridDragHeaderStyle.GetName);
  AHTMLTextBuilder.WriteAttribute(aAlign, 'center');
  AHTMLTextBuilder.WriteStyleAttribute(saPosition, 'absolute');
  AHTMLTextBuilder.WriteStyleAttribute(saZIndex, 10000);
  AHTMLTextBuilder.WriteStyleAttribute(saVisibility, 'hidden');
  AHTMLTextBuilder.WriteStyleAttribute(saCursor, 'hand');
  AHTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv);
end;

{ TcxCustomWebGridOperaRenderer }

function TcxCustomWebGridOperaRenderer.IsIndicatorCursorType: Boolean;
begin
  Result := True;
end;

class function TcxCustomWebGridOperaRenderer.IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean;
begin
  Result := AWebBrowser = TcxWebBrowserOpera;
end;

class procedure TcxCustomWebGridOperaRenderer.WriteClassHTML(AHTMLTextBuilder: TcxHTMLTextBuilder);
begin
end;

procedure TcxCustomWebGridOperaRenderer.WriteButton(ID, ClassName, Handler,
  ImageID, ImageSrc, Hint: string; ImageIndex, Height, Width: Integer;
  HoverStyle: TcxWebStyleItem);
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv);
  HTMLTextBuilder.WriteAttribute(aID, ID);
  HTMLTextBuilder.WriteAttribute(aClass, ClassName);
  HTMLTextBuilder.WriteAttribute(aAlign, 'center');
  HTMLTextBuilder.WriteStyleAttribute(saHeight, Height - 2, 'px');
  HTMLTextBuilder.WriteStyleAttribute(saWidth, Width - 2, 'px');
  HTMLTextBuilder.WriteStyleAttribute(saOverflow, 'hidden');
  WriteComponentEvents(HoverStyle, WebGrid.IndicatorPopupMenu);
  HTMLTextBuilder.WriteEventAttribute(eOnClick, Handler);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aHeight, '100%');
  HTMLTextBuilder.WriteAttribute(aWidth, '100%');
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteAttribute(aAlign, 'center');
  HTMLTextBuilder.WriteAttribute(aValign, 'center');

  if (WebGrid.Images <> nil) and (WebGrid.Images.ValidIndex(ImageIndex)) then
    WebGrid.Images.Images[ImageIndex].WriteHTML(HTMLTextBuilder)
  else
  begin
    HTMLTextBuilder.WriteSingleTag(TcxHTMLTagImg);
    HTMLTextBuilder.WriteAttribute(aSrc, ImageSrc);
    HTMLTextBuilder.WriteAttribute(aBorder, 0);
    if WebGrid.ShowHint then
      HTMLTextBuilder.WriteAttribute(aTitle, Hint);
    HTMLTextBuilder.WriteAttribute(aAlt, Hint);
  end;
  HTMLTextBuilder.WriteAttribute(aId, ImageID);
  HTMLTextBuilder.WriteAttribute(aAlign, 'top');

  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv);
end;

procedure TcxCustomWebGridOperaRenderer.WriteHeaderCell(ID, ClassName,
  Cursor, Hint, Handler: string; ColumnIndex, Height, Width: Integer;
  ShowSortImage: Boolean; HoverStyle: TcxWebStyleItem);
begin
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv);
  if ID <> '' then HTMLTextBuilder.WriteAttribute(aId, ID);
  if ClassName <> '' then HTMLTextBuilder.WriteAttribute(aClass, ClassName);
  if Hint <> '' then HTMLTextBuilder.WriteAttribute(aTitle, Hint);
  if Cursor <> '' then HTMLTextBuilder.WriteStyleAttribute(saCursor, Cursor);
  HTMLTextBuilder.WriteStyleAttribute(saWidth, Width - 2, 'px');
  HTMLTextBuilder.WriteStyleAttribute(saHeight, Height - 2, 'px');
  HTMLTextBuilder.WriteStyleAttribute(saOverflow, 'hidden');
  HTMLTextBuilder.WriteEventAttribute(eOnMouseDown, Handler);
  WriteComponentEvents(HoverStyle, WebGrid.HeaderPopupMenu);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteAttribute(aClass, ClassName);
  HTMLTextBuilder.WriteAttribute(aHeight, '100%');
  HTMLTextBuilder.WriteAttribute(aWidth, '100%');
  HTMLTextBuilder.WriteAttribute(aCellpadding, 0);
  HTMLTextBuilder.WriteAttribute(aCellspacing, 0);
  HTMLTextBuilder.WriteAttribute(aBorder, 0);
  HTMLTextBuilder.WriteStyleAttribute(saBorderWidth, 0, 'px');
  WriteComponentEvents(HoverStyle, WebGrid.HeaderPopupMenu);

  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aAlign, 'center');
  HTMLTextBuilder.WriteAttribute(aValign, 'center');
  HTMLTextBuilder.WriteText(WebGrid.Columns[ColumnIndex].Title + '&nbsp;', False, False);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteBeginTag(TcxHTMLTagTd, True, False);
  HTMLTextBuilder.WriteAttribute(aAlign, 'center');
  HTMLTextBuilder.WriteAttribute(aValign, 'center');
  HTMLTextBuilder.WriteAttribute(aWidth, cxWebGridSortBitmapWidth + 4);
  if ShowSortImage then WriteSortButton(ColumnIndex);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTd, False, True);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagTable);
  HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv);
end;

procedure TcxCustomWebGridOperaRenderer.WriteOutOfFormHTML;
var
  I: Integer;
begin
  for I := 0 to WebGrid.ColumnCount - 1 do
  begin
    if not WebGrid.Columns[I].Visible then continue;

    HTMLTextBuilder.WriteBeginTag(TcxHTMLTagDiv);
    HTMLTextBuilder.WriteAttribute(aId, WebGrid.Name + scxDragNodeID + IntToStr(I));
    HTMLTextBuilder.WriteAttribute(aAlign, 'center');
    HTMLTextBuilder.WriteEventAttribute(eOnMouseUp, Format(scxDraggingNodeHandler, ['event']));
    HTMLTextBuilder.WriteStyleAttribute(saPosition, 'absolute');
    HTMLTextBuilder.WriteStyleAttribute(saWidth, WebGrid.GetHeaderColumnWidth(I));
    HTMLTextBuilder.WriteStyleAttribute(saHeight, WebGrid.HeaderHeight);
    HTMLTextBuilder.WriteStyleAttribute(saZIndex, 10000);
    HTMLTextBuilder.WriteStyleAttribute(saVisibility, 'hidden');
    HTMLTextBuilder.WriteStyleAttribute(saCursor, 'hand');
    WriteHeaderCell('', HeaderDefaultStyleName, 'hand', '', '', I, WebGrid.HeaderHeight,
        WebGrid.GetHeaderColumnWidth(I), True, nil);
    HTMLTextBuilder.WriteEndTag(TcxHTMLTagDiv);
  end;
end;

{ TcxWebGridDsgnRenderer }

class procedure TcxWebGridDsgnRenderer.WriteClassHTML(AHTMLTextBuilder: TcxHTMLTextBuilder);
begin
end;

initialization
  RegisterClasses([TcxWebColumn, TcxCustomWebGrid]);

end.


