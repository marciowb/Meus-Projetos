
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressQuantumDBTreeList                                    }
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

unit dxDBTL;

interface

{$I dxTLVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, dxUtils, dxTL, Mask, dxTLStr, dxCntner, dxEditor, dxDBCtrl{$IFDEF DELPHI6},
  Variants{$ENDIF};

type
  TdxDBTreeListOptionBehavior = (etoAnsiSort, etoAutoCopySelectedToClipboard,
    etoAutoDragDrop, etoAutoDragDropCopy,
    etoAutoSearch, etoAutoSort, etoBandButtonClicking, etoCaseInsensitive, etoDblClick,
    etoDragCollapse, etoDragExpand, etoDragScroll, etoEditing, etoEnterShowEditor,
    etoEnterThrough, etoHeaderButtonClicking, etoHorzThrough, etoImmediateEditor,
    etoMouseScroll, etoMultiSelect, etoShowHourGlass, etoStoreToIniFile,
    etoStoreToRegistry, etoTabs, etoTabThrough, etoVertThrough);

  TdxDBTreeListOptionCustomize = (etoBandMoving, etoBandPanelSizing, etoBandSizing,
    etoColumnMoving, etoColumnSizing, etoExtCustomizing, etoFullSizing,
    etoHeaderPanelSizing, etoKeepColumnWidth, etoRowSizing);

  TdxDBTreeListOptionDB = (etoAutoCalcKeyValue, etoCancelOnExit, etoCanDelete,
    etoCanInsert, etoCanNavigation, etoCheckHasChildren, etoConfirmDelete,
    etoLoadAllRecords, etoResetColumnFocus, etoSyncSelection, etoUseBookmarks);

  TdxDBTreeListOptionView = (etoAutoCalcPreviewLines, etoAutoHeaderPanelHeight,
    etoAutoWidth, etoBandHeaderWidth, etoDrawEndEllipsis, etoHideFocusRect, etoHotTrack,
    etoIndicator, etoInvertSelect, etoPreview, etoRowAutoHeight, etoRowSelect,
    etoShowButtonAlways, etoUseBitmap, etoUseImageIndexForSelected);

  TdxDBTreeListOptionsBehavior = set of TdxDBTreeListOptionBehavior;
  TdxDBTreeListOptionsCustomize = set of TdxDBTreeListOptionCustomize;
  TdxDBTreeListOptionsDB = set of TdxDBTreeListOptionDB;
  TdxDBTreeListOptionsView = set of TdxDBTreeListOptionView;

  TdxChangeDBTreeListNodeInfo = record
    Id: Variant;
    Selected: Boolean;
  end;

const
  dxDBTreeListOptionsBehaviorDefault = [etoAutoDragDrop, etoAutoDragDropCopy,
    {etoAutoSearch, }etoAutoSort, etoDragExpand, etoDragScroll, etoEditing,
    etoEnterShowEditor, etoImmediateEditor, etoTabThrough];

  dxDBTreeListOptionsCustomizeDefault = [etoBandMoving, etoBandSizing,
    etoColumnMoving, etoColumnSizing, etoKeepColumnWidth];

  dxDBTreeListOptionsDBDefault = [etoAutoCalcKeyValue, etoCancelOnExit,
    etoCanDelete, {etoCanInsert, }etoCanNavigation, etoCheckHasChildren,
    etoConfirmDelete, etoLoadAllRecords];

  dxDBTreeListOptionsViewDefault = [etoBandHeaderWidth, {etoInvertSelect,}
    etoRowSelect, etoUseBitmap, etoUseImageIndexForSelected];

type
  TCustomdxDBTreeList = class;

  {TdxDBTreeListDataLink}
  TdxDBTreeListDataLink = class(TdxDBTreeListControlDataLink)
  private
    function GetDBTreeList: TCustomdxDBTreeList;
  protected
    // override TDataLink
    procedure FocusControl(Field: TFieldRef); override;
    procedure LayoutChanged; override;
    property DBTreeList: TCustomdxDBTreeList read GetDBTreeList;
  end;

  {TdxDBTreeListNode}
  TdxDBTreeListNode = class(TdxDBTreeListControlNode)
  private
    FParentId: Variant;
  public
    procedure Delete; override;
    property ParentId: Variant read FParentId;
  end;

  {TCustomdxDBTreeList}
  TdxDBTLGetUniqueKeyValueEvent = procedure(Sender: TObject; var UniqueKeyValue: Variant) of object;
  TdxDBTLMoveToEvent = procedure(Sender: TObject; AttachNode: TdxDBTreeListNode;
    AttachMode: TdxTreeListNodeAttachMode; Nodes: TList; var IsCopy, Done: Boolean) of object;

  TCustomdxDBTreeList = class(TCustomdxDBTreeListControl)
  private
    FDataChangedBusy: Boolean;
    FDataChangedLocate, FDataChangedLocateResync: Boolean;
    FDataLink: TdxDBTreeListDataLink;
    FFlagChangedGroupColumn: Boolean;
    FImageIndexField: TField;
    FImageIndexFieldName: string;
    FInUpdateActive: Boolean;
    FLocateByNode: Boolean;
    FLockLayout: Integer;
    FOptionsBehavior: TdxDBTreeListOptionsBehavior;
    FOptionsCustomize: TdxDBTreeListOptionsCustomize;
    FOptionsDB: TdxDBTreeListOptionsDB;
    FOptionsView: TdxDBTreeListOptionsView;
    FParentField: TField;
    FParentFieldName: string;
    FPrevNodeInfo: TdxChangeDBTreeListNodeInfo;
    FRefreshTreeList: Boolean;
    FRootValue: Variant;
    FStateIndexField: TField;
    FStateIndexFieldName: string;
    FSelectAllFlag: Boolean;
    FSelectedIndex: Integer;
    FTotalSummaryCount: Integer;
    FUpdatingNode: TdxDBTreeListNode;
    FOnGetUniqueKeyValue: TdxDBTLGetUniqueKeyValueEvent;
    FOnMoveTo: TdxDBTLMoveToEvent;
    procedure CheckChangeNodeEx;
    function GetOptionsBehavior: TdxDBTreeListOptionsBehavior;
    function GetOptionsCustomize: TdxDBTreeListOptionsCustomize;
    function GetOptionsDB: TdxDBTreeListOptionsDB;
    function GetOptionsView: TdxDBTreeListOptionsView;
    function GetRootValue: string;
    function GetRootValueAsVariant: Variant;
    procedure InsertNode(FAppend: Boolean);
    procedure LoadChangeNodeInfo(var NodeInfo: TdxChangeDBTreeListNodeInfo);
    procedure SetDataSource(Value: TDataSource);
    procedure SetImageIndexFieldName(const Value: string);
    procedure SetOptionsBehavior(Value: TdxDBTreeListOptionsBehavior);
    procedure SetOptionsCustomize(Value: TdxDBTreeListOptionsCustomize);
    procedure SetOptionsDB(Value: TdxDBTreeListOptionsDB);
    procedure SetOptionsView(Value: TdxDBTreeListOptionsView);
    procedure SetParentFieldName(const Value: string);
    procedure SetRootValue(const Value: string);
    procedure SetSelectedIndex(Value: Integer);
    procedure SetStateIndexFieldName(const Value: string);
    procedure UpdateActive;
  protected
    // override TComponent
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    // Selected
    procedure DoSelectedCountChange; override;
    function IsNodeSelected(ANode: TdxTreeListNode): Boolean; override;
    procedure NodeSelected(ANode: TdxTreeListNode; ASelected: Boolean); override;
    // Sorting
    procedure SetColumnSorted(Column: TdxTreeListColumn); override;
    // Style
    function CanDblClick: Boolean; override;
    procedure DoBeforeExpand(Node: TdxTreeListNode; var AllowExpand: Boolean); override;
    procedure EndCustomLayout; override;
    // based override
    function CreateNode: TdxTreeListNode; override;
    procedure DeleteNode(Node, Prior, Next: TdxTreeListNode; IsLast, Redraw: Boolean); override;
    function GetFooterCellText(Node: TdxTreeListNode; AbsoluteIndex, FooterIndex: Integer): string; override;
    function GetNodeString(Node: TdxTreeListNode; Column: Integer{AbsoluteIndex}): string; override;
    function GetNodeValue(Node: TdxTreeListNode; Column: Integer{AbsoluteIndex}): Variant; override;
    function GetNodeVariant(Node: TdxTreeListNode; Column: Integer{AbsoluteIndex}): Variant; override;
    function GetPreviewText(Node: TdxTreeListNode): string; override;
    procedure ResetAutoHeaderPanelRowCountOption; override;
    procedure SetFocusedNode(Node: TdxTreeListNode; Column: Integer; MakeVisibleFlag: Boolean); override;
    // DBTreeListControl
    procedure ChangedGroupColumn(Column: TdxDBTreeListColumn); override;
    function GetDataLink: TdxDBTreeListControlDataLink; override;
    function GetDataSource: TDataSource; override;
    function GetDefaultFields: Boolean; override;
    function IsAutoCalcKeyValue: Boolean; virtual;
    function IsAutoDragCopy: Boolean; override;
    function IsAutoDragDrop: Boolean; virtual;
    function IsAutoSearch: Boolean; override;
    function IsCancelOnExit: Boolean; override;
    function IsCanInsert: Boolean; override;
    function IsCanNavigation: Boolean; override;
    function IsKeyFieldEmpty: Boolean; override;
    function IsLoadAllRecords: Boolean;
    function IsLoadedAll: Boolean; override;
    function IsUseBookmarks: Boolean; override;
    procedure SetDataChangedBusy(Value: Boolean); override;
    // DataSet
    procedure DataChanged; override;
    function IsDataSetBusy: Boolean; override;
    procedure LinkActive(Value: Boolean); override;
    procedure RecordChanged(Field: TField); override;
    procedure Scroll(Distance: Integer); override;
    // based
    procedure AssignKeyFields;
    procedure AssignNodeAllValues(Node: TdxDBTreeListControlNode); override;
    procedure AssignSummaryFooterFields; override;
    procedure CalcSummary; // Count , Average
    procedure FindNodeById;
    function GetUniqueKeyValue(const Delta: Variant): Variant; virtual;
    procedure LoadTreeList(LoadingNode: TdxDBTreeListNode);
    function LocateByNode(OldNode, Node: TdxDBTreeListNode; const Value: Variant): Boolean;
    procedure RefreshNodeValues(var Node: TdxDBTreeListControlNode); override;
    procedure RefreshTreeList;
    procedure ReloadTreeList(AClearNodes: Boolean);
    // Drag Drop
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean); override;
    function GetNodeAttachMode(X, Y: Integer; var DestNode: TdxTreeListNode;
      var AttachMode: TdxTreeListNodeAttachMode): boolean; virtual;
    // Save/Load
    procedure BeginReadSettings(ARegIniWrapper: TdxRegIniWrapper); override;
    procedure EndReadSettings(ARegIniWrapper: TdxRegIniWrapper); override;
    procedure ReadSettings(ARegIniWrapper: TdxRegIniWrapper; const APath: string); override;
    procedure WriteSettings(ARegIniWrapper: TdxRegIniWrapper; const APath: string); override;
    // Navigation
    function GetNodeByNavigation(ANode: TdxTreeListNode; ANavigationMode: TdxTreeListNavigationMode;
      AGotoHidden: Boolean): TdxTreeListNode; override;

    property DataChangedLocate: Boolean read FDataChangedLocate;
    property LockLayout: Integer read FLockLayout;
    property ImageIndexFieldName: string read FImageIndexFieldName write SetImageIndexFieldName;
    property OptionsBehavior: TdxDBTreeListOptionsBehavior read GetOptionsBehavior
      write SetOptionsBehavior default dxDBTreeListOptionsBehaviorDefault;
    property OptionsCustomize: TdxDBTreeListOptionsCustomize read GetOptionsCustomize
      write SetOptionsCustomize default dxDBTreeListOptionsCustomizeDefault;
    property OptionsDB: TdxDBTreeListOptionsDB read GetOptionsDB
      write SetOptionsDB default dxDBTreeListOptionsDBDefault;
    property OptionsView: TdxDBTreeListOptionsView read GetOptionsView
      write SetOptionsView default dxDBTreeListOptionsViewDefault;
    property RootValue: string read GetRootValue write SetRootValue;
    property RootValueAsVariant: Variant read GetRootValueAsVariant;
    property SelectedIndex: Integer read FSelectedIndex write SetSelectedIndex default -1;
    property StateIndexFieldName: string read FStateIndexFieldName write SetStateIndexFieldName;
    // TL override
    property HideFocusRect default False;
    property HideSelection default False;
    // Events
    property OnGetUniqueKeyValue: TdxDBTLGetUniqueKeyValueEvent read FOnGetUniqueKeyValue write FOnGetUniqueKeyValue;
    property OnMoveTo: TdxDBTLMoveToEvent read FOnMoveTo write FOnMoveTo;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure BeginLayout;
    procedure BeginSelection; override;
    procedure DeleteSelection; override;
    procedure DragDrop(Source: TObject; X, Y: Integer); override;
    procedure EndLayout;
    procedure EndSelection; override;
    function FindNodeByKeyValue(const Value: Variant): TdxDBTreeListNode;
    procedure FullRefresh; override;
    class function GetDefaultFieldColumnClass(AField: TField): TdxDBTreeListColumnClass; override;
    procedure RefreshSorting; override;
    procedure SelectAll;

    property DataLink: TdxDBTreeListDataLink read FDataLink;
    property DataSetChangedBusy: Boolean read FDataChangedBusy;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property LockRefresh;
  published
    property KeyField;
    property ParentField: string read FParentFieldName write SetParentFieldName;
  end;

  {TdxDBTreeList}
  TdxDBTreeList = class(TCustomdxDBTreeList)
  public
    property DragNode;
    property EditingText;
    property FocusedField;
    property HotTrackInfo;
    property RootValueAsVariant;
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
    {$IFDEF DELPHI4}
    property Anchors;
    property Constraints;
    {$ENDIF}

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
    {$IFDEF DELPHI5}
    property OnContextPopup;
    {$ENDIF}

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
    property FixedBandLineColor;
    property FixedBandLineWidth;
    property GridLineColor;
    property GrIndicatorWidth;
    property GroupNodeColor;
    property GroupNodeTextColor;
    property HeaderColor;
    property HeaderFont;
    property HideFocusRect;
    property HideSelection;
    property HideSelectionColor;
    property HideSelectionTextColor;
    property HighlightColor;
    property HighlightTextColor;
    property ImageIndexFieldName;
    property Images;
    property IndentDesc;
    property IniFileName;
    property IniSectionName;
    property LookAndFeel;
    property MaxRowLineCount;
    property OptionsBehavior;
    property OptionsCustomize;
    property OptionsDB;
    property OptionsView;
    property PaintStyle;
    property PreviewFieldName;
    property PreviewFont;
    property PreviewLines;
    property PreviewMaxLength;
    property RegistryPath;
    property RootValue;
    property RowSeparatorLineWidth;
    property ScrollBars;
    property SelectedIndex;
    property ShowBands;
    property ShowButtons;
    property ShowFooter;
    property ShowGrid;
    property ShowHeader;
    property ShowHiddenInCustomizeBox;
    property ShowLines;
    property ShowNewItemRow;
    property ShowPreviewGrid;
    property ShowRoot;
    property SimpleCustomizeBox;
    property StateImages;
    property StateIndexFieldName;
    property TreeLineColor;
    property TreeLineStyle;
    property WaitForExpandNodeTime;

    // events
    property OnGetUniqueKeyValue;
    property OnMoveTo;

    property OnGetImageIndex;
    property OnGetSelectedIndex;
    property OnGetStateIndex;

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
    property OnCollapsed;
    property OnCollapsing;
    property OnColumnClick;
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
    property OnSelectedCountChange;
    property OnShowBand;
    property OnShowHeader;
    property OnStartBandDragging;
    property OnStartHeaderDragging;
  end;

implementation

type
  TdxDBTreeListControlColumn = class(TdxDBTreeListColumn);
  TDummyDataSet = class(TDataSet);

  PNodeBuffer =^TNodeBuffer;
  TNodeBuffer = record
    Key: Variant;
    Buffer: Variant;
    Items: TList;
  end;

{TdxDBTreeListDataLink}
procedure TdxDBTreeListDataLink.FocusControl(Field: TFieldRef);
begin
  if Assigned(Field) and Assigned(Field^) then
  begin
    with DBTreeList do
    begin
      if IsCanNavigation and not IsRowSelect and (FocusedNode <> nil) then
      begin
        FocusedNode.MakeVisible;
        if IsNewItemRowVisible then NewItemRowActive := True; // new item row
        FocusedField := Field^;
        if (FocusedField = Field^) and AcquireFocus then
        begin
          Field^ := nil;
          ShowEditor;
        end;
      end;
    end;
  end;
end;

procedure TdxDBTreeListDataLink.LayoutChanged;
begin
  DBTreeList.ReloadTreeList(False);
end;

function TdxDBTreeListDataLink.GetDBTreeList: TCustomdxDBTreeList;
begin
  Result := DBTreeListControl as TCustomdxDBTreeList;
end;

{ TdxDBTreeListNode }

procedure TdxDBTreeListNode.Delete;
var
  DBTreeList: TCustomdxDBTreeList;
  List: TList;
  I: Integer;

  procedure LoadListByNode(ANode: TdxDBTreeListNode);
  var
    P: PVariant;
    I: Integer;
  begin
    New(P);
    P^ := ANode.Id;
    List.Add(P);
    for I := 0 to ANode.Count - 1 do
      LoadListByNode(TdxDBTreeListNode(ANode[I]));
  end;

  procedure LoadListByID(const AKeyValue: Variant);
  var
    P: PVariant;
    TempList: TList;
    I: Integer;
  begin
    New(P);
    P^ := AKeyValue;
    List.Add(P);
    with DBTreeList.DataLink.DataSet do
      if Locate(DBTreeList.ParentField, AKeyValue, []) then
      begin
        TempList := TList.Create;
        try
          while not Eof and (DBTreeList.FParentField.Value = AKeyValue) do
          begin
            New(P);
            P^ := DBTreeList.FKeyField.Value;
            TempList.Add(P);
            Next;
          end;
          for I := 0 to TempList.Count - 1 do
            LoadListByID(PVariant(TempList[I])^);
        finally
          for I := 0 to TempList.Count - 1 do
            Dispose(TempList[I]);
          TempList.Free;
        end;
      end;
  end;

begin
  DBTreeList := TCustomdxDBTreeList(Owner);
  if DBTreeList.DataLink.Active then
  begin
    if not HasChildren then
    begin
      if DBTreeList.DataLink.DataSet.Locate(DBTreeList.KeyField, Self.Id, []) then
        DBTreeList.DataLink.DataSet.Delete;
    end
    else
      with DBTreeList.DataLink.DataSet do
      begin
        DisableControls;
        try
          List := TList.Create;
          try
            if DBTreeList.IsLoadAllRecords then
              LoadListByNode(Self)
            else
              LoadListByID(Self.Id);
            // Delete Nodes
            for I := List.Count - 1 downto 0 do
              if Locate(DBTreeList.KeyField, PVariant(List[I])^, []) then
                Delete;
          finally
            for I := 0 to List.Count - 1 do
              Dispose(List[I]);
            List.Free;
          end;
        finally
          EnableControls;
        end;
      end;
  end;
end;

{TCustomdxDBTreeList}
constructor TCustomdxDBTreeList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataLink := TdxDBTreeListDataLink.Create(Self);
  RegisterDBTreeListControl(Self); // add self to grid list
  // Options
  FOptionsBehavior := dxDBTreeListOptionsBehaviorDefault;
  FOptionsCustomize := dxDBTreeListOptionsCustomizeDefault;
  FOptionsDB := dxDBTreeListOptionsDBDefault;
  FOptionsView := dxDBTreeListOptionsViewDefault;
  inherited Options := [aoColumnSizing, aoColumnMoving, aoEditing, aoTabThrough,
    aoImmediateEditor, aoExtMultiSelect, aoAutoSort, aoRowSelect];
  inherited OptionsEx := [aoUseBitmap, aoBandHeaderWidth, aoBandSizing, aoBandMoving,
    aoEnterShowEditor, aoDragScroll, aoDragExpand, aoMultiSort, aoKeepColumnWidth
    {, aoAutoSearch, aoInvertSelect}];
  FRootValue := Null;
  FSelectedIndex := -1;
  // TL override
  HideFocusRect := False;
  HideSelection := False;
end;

destructor TCustomdxDBTreeList.Destroy;
begin
  try
    DoSaveLayout;
  finally
    BeforeDestroy;
    ClearListNodes;
    ClearSelection;
    FDataLink.Free;
    FDataLink := nil;
    UnRegisterDBTreeListControl(Self); // remove self from grid list
    inherited Destroy;
  end;
end;

procedure TCustomdxDBTreeList.BeginLayout;
begin
  BeginUpdate;
  if FLockLayout = 0 then
    FDataChangedBusy := True;
  Inc(FLockLayout);
end;

procedure TCustomdxDBTreeList.BeginSelection;
begin
  if (LockSelection = 0) and Assigned(OnChangeNodeEx) then
    LoadChangeNodeInfo(FPrevNodeInfo);
  inherited BeginSelection;
end;

procedure TCustomdxDBTreeList.DeleteSelection;
var
  List: TList;
  I: Integer;
begin
  inherited DeleteSelection;
  if Datalink.Active then
    with Datalink.Datasource.Dataset do
    begin
      DisableControls;
      try
        BeginUpdate;
        List := TList.Create;
        try
          // Make List
          for I := 0 to SelectedCount - 1 do
            List.Add(SelectedNodes[I]);
          // Clear Selection
          ClearSelection;
          // sort and remove dublicate
          List.Sort(CompareParentNode);
          for I := List.Count - 1 downto 1 do
            if TdxTreeListNode(List[I]).HasAsParent(TdxTreeListNode(List[I - 1])) then
              List.Delete(I);
          if State in dsEditModes then Cancel;
          // Delete
          for I := 0 to List.Count - 1 do
            TdxDBTreeListNode(List[I]).Delete;
        finally
          List.Free;
          EndUpdate;
        end;
      finally
        EnableControls;
      end;
    end;
end;

procedure TCustomdxDBTreeList.DragDrop(Source: TObject; X, Y: Integer);
var
  Node: TdxTreeListNode;
  NodeAttachMode: TdxTreeListNodeAttachMode;
  Accept, Done, DragCopy: Boolean;
  I: Integer;
  List: TList;
  NewParentValue, KeyValue, Delta: Variant;
  // Drag Copy
  AFieldList: TList;
  F: TField;
  BufferList: TList;

  function LoadBufferValues(const AKeyValue: Variant): PNodeBuffer;
  var
    I: Integer;
  begin
    New(Result);
    Result^.Items := nil;
    Result^.Key := AKeyValue;
    Result^.Buffer := VarArrayCreate([0, AFieldList.Count - 1], varVariant);
    for I := 0 to AFieldList.Count - 1 do
      Result^.Buffer[I] := TField(AFieldList[I]).Value;
  end;

  procedure LoadSubItems(PBuffer: PNodeBuffer);
  var
    AParentValue: Variant;
    I: Integer;
  begin
    with Datalink.DataSet do
    begin
      AParentValue := PBuffer^.Key;
      if Locate(ParentField, AParentValue, []) then
      begin
        PBuffer^.Items := TList.Create;
        while not EOF and (FParentField.Value = AParentValue) do
        begin
          PBuffer^.Items.Add(LoadBufferValues(FKeyField.Value));
          Next;
        end;
        for I := 0 to PBuffer^.Items.Count - 1 do
          LoadSubItems(PNodeBuffer(PBuffer^.Items[I]));
      end;
    end;
  end;

  procedure AddNewNode(PBuffer: PNodeBuffer; const AParentValue: Variant);
  var
    I: Integer;
    Key: Variant;
  begin
    with Datalink.DataSet do
    begin
      Insert;
      if (etoAutoCalcKeyValue in OptionsDB) and FKeyField.IsNull then
      begin
        FKeyField.Value := GetUniqueKeyValue(Delta);
        Inc(Delta);
      end;
      Key := FKeyField.Value;
      FParentField.Value := AParentValue;
      for I := 0 to AFieldList.Count - 1 do
        TField(AFieldList[I]).Value := PBuffer^.Buffer[I];
      Post;
      // add children
      if PBuffer^.Items <> nil then
        for I := 0 to PBuffer^.Items.Count - 1 do
          AddNewNode(PBuffer^.Items[I], Key);
    end;
  end;

  procedure FreeBuffer(PBuffer: PNodeBuffer);
  var
    I: Integer;
    L: TList;
  begin
    L := PBuffer^.Items;
    if L <> nil then
    begin
      for I := 0 to L.Count - 1 do
        FreeBuffer(L[I]);
      L.Free;
    end;
    Dispose(PBuffer);
  end;

begin
  if IsAutoDragDrop then
  begin
    DragCopy := IsAutoDragCopy and (GetAsyncKeyState(VK_CONTROL) < 0);
    Accept := (Source = Self) and GetNodeAttachMode(X, Y, Node, NodeAttachMode);
    if Accept then
    begin
      // Make List Nodes
      List := TList.Create;
      try
        if SelectedCount = 0 then
          List.Add(DragNode)
        else
          for I := 0 to SelectedCount - 1 do
             List.Add(SelectedNodes[I]);
        Done := False;
        if Assigned(FOnMoveTo) then
          FOnMoveTo(Self, TdxDBTreeListNode(Node), NodeAttachMode, List, DragCopy, Done);
        // Move
        if not Done then
          with Datalink.DataSet do
          begin
            if NodeAttachMode in [natlAddChild, natlAddChildFirst] then
              NewParentValue := TdxDBTreeListNode(Node).Id
            else NewParentValue := TdxDBTreeListNode(Node).ParentId;
            DisableControls;
            try
              if not DragCopy then
              begin
                // move drag nodes
                for I := 0 to List.Count - 1 do
                  if Locate(KeyField, TdxDBTreeListNode(List[I]).Id, []) then
                  begin
                    Edit;
                    FParentField.Value := NewParentValue;
                    Post;
                  end;
              end
              else
              begin
                // copy drag nodes
                AFieldList := TList.Create;
                try
                  // create Field List
                  for I := 0 to FieldCount - 1 do
                  begin
                    F := Fields[I];
                    if F.FieldKind = fkLookup then
                      F := FindField(F.KeyFields)
                    else
                    if (F = FKeyField) or (F = FParentField) or (F.FieldKind <> fkData) then
                      F := nil;
                    if Assigned(F) and F.CanModify then
                      AFieldList.Add(F);
                  end;
                  if AFieldList.Count > 0 then
                  begin
                    // sort and remove dublicate
                    List.Sort(CompareParentNode);
                    for I := List.Count - 1 downto 1 do
                      if TdxTreeListNode(List[I]).HasAsParent(TdxTreeListNode(List[I - 1])) then
                        List.Delete(I);
                    // make Buffer List
                    BufferList := TList.Create;
                    try
                      for I := 0 to List.Count - 1 do
                      begin
                        KeyValue := TdxDBTreeListNode(List[I]).Id;
                        if Locate(KeyField, KeyValue, []) then
                        begin
                          BufferList.Add(LoadBufferValues(KeyValue));
                          LoadSubItems(BufferList[I]);
                        end;
                      end;
                      // create new nodes
                      Delta := 0;
                      for I := 0 to BufferList.Count - 1 do
                        AddNewNode(BufferList[I], NewParentValue);
                    finally
                      for I := 0 to BufferList.Count - 1 do
                        FreeBuffer(PNodeBuffer(BufferList[I]));
                      BufferList.Free;
                    end;
                  end;
                finally
                  AFieldList.Free;
                end;
              end;
            finally
              EnableControls;
            end;
          end;
      finally
        List.Free;
      end;
    end;
  end;
  inherited;
end;

procedure TCustomdxDBTreeList.EndLayout;
begin
  Dec(FLockLayout);
  if FLockLayout = 0 then
  begin
    FDataChangedBusy := False;
    FullRefresh;
  end;
  EndUpdate;
end;

procedure TCustomdxDBTreeList.EndSelection;
begin
  inherited EndSelection;
  if (LockSelection = 0) and Assigned(OnChangeNodeEx) then
    CheckChangeNodeEx;
end;

function TCustomdxDBTreeList.FindNodeByKeyValue(const Value: Variant): TdxDBTreeListNode;

  function Find(ANode: TdxTreeListNode; var Node: TdxDBTreeListNode): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    if TdxDBTreeListNode(ANode).Id = Value then
    begin
      Node := TdxDBTreeListNode(ANode);
      Result := True;
    end
    else
      for I := 0 to ANode.Count - 1 do
        if Find(ANode[I], Node) then
        begin
          Result := True;
          Break;
        end;
  end;

var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if Find(Items[I], Result) then Break;
end;

procedure TCustomdxDBTreeList.FullRefresh;
begin
  if FLockLayout = 0 then
    ReloadTreeList(True{ClearNodes});
end;

class function TCustomdxDBTreeList.GetDefaultFieldColumnClass(AField: TField): TdxDBTreeListColumnClass;
begin
  if AField.FieldKind = fkLookup then
    Result := DefaultDBTreeListLookupColumnType.ColumnClass
  else
  if AField.FieldKind = fkData then
    if AField.DataType in [ftUnknown..ftTypedBinary] then
      Result := DefaultDBTreeListColumnType[AField.DataType].ColumnClass
    else Result := TdxDBTreeListColumn
  else Result := TdxDBTreeListColumn;
end;

procedure TCustomdxDBTreeList.RefreshSorting;
var
  Column: TdxDBTreeListColumn;
begin
  if IsAutoSort then
  begin
    BeginUpdate;
    try
      Column := SortedColumn;
      if (Column <> nil) and (Column.Sorted <> csNone) then
        DoSortColumn(-1{all levels}, Column.Index, Column.Sorted = csDown);
    finally
      EndUpdate;
    end;
  end;
end;

procedure TCustomdxDBTreeList.SelectAll;
var
  N1, N2: TdxTreeListNode;
begin
  if not IsMultiSelect or not DataLink.Active or (Count = 0) then Exit;
  BeginSelection;
  try
    BeginUpdate;
    try
      ClearSelection;
      FullExpand;
      if IsUseBookmarks then
      begin
        FSelectAllFlag := True;
        FRefreshTreeList := True;
        try
          RefreshTreeList;
          if not FLocateByNode then FindNodeById;
        finally
          FRefreshTreeList := False;
          FSelectAllFlag := False;
        end;
      end
      else
      begin
        { Start Node }
        N1 := Items[0];
        { End Node }
        N2 := Items[Count - 1];
        while N2.Count > 0 do N2 := N2[N2.Count - 1];
        SelectNodes(N1, N2);
      end;
    finally
      EndUpdate;
    end;
  finally
    EndSelection;
  end;
end;

procedure TCustomdxDBTreeList.KeyDown(var Key: Word; Shift: TShiftState);

  function DeletePrompt: Boolean;
  var
    Title, Msg: string;
  begin
    Title := sdxGrTitleConfirm{LoadStr(dxSTitleWarning)};
    Msg := sdxGrDeleteRecordQuestion{LoadStr(dxSDeleteRecordQuestion)};
    if SelectedCount > 0{1} then
       Msg := sdxDeleteMultipleRecordsQuestion{LoadStr(dxSDeleteMultipleRecordsQuestion)};
    Result := not (etoConfirmDelete in OptionsDB) or
      (MessageBox(Self.Handle, PChar(Msg), PChar(Title), MB_ICONQUESTION or MB_OKCANCEL) <> IDCANCEL);
  end;

var
  KeyDownEvent: TKeyEvent;
begin
  KeyDownEvent := OnKeyDown;
  OnKeyDown := nil;
  BeginSelection;
  try
    if Assigned(KeyDownEvent) then KeyDownEvent(Self, Key, Shift);
    if not (FSearching and ((Key in [VK_DELETE, VK_BACK, VK_ESCAPE]) or
      ((Key = VK_RETURN) and (Shift*[ssCtrl, ssShift] <> [])))) then
    if FDatalink.Active and CanTreeListAcceptKey(Key, Shift) then
    with FDatalink.DataSet do
    begin
      if ssCtrl in Shift then
        if not NewItemRowActive and (Key = VK_DELETE) and (etoCanDelete in OptionsDB) and
          IsCanNavigation and not ReadOnly and (FocusedNode <> nil) then
        begin
          if not {$IFDEF DELPHI3}IsEmpty {$ELSE}(FDataLink.RecordCount = 0){$ENDIF}and CanModify and DeletePrompt then
            if SelectedCount > 0{1} then DeleteSelection
            else TdxDBTreeListNode(FocusedNode).Delete;
          Exit;
        end;
      if (Key = VK_ESCAPE) and (Self.State <> tsEditing) then
        FDatalink.Reset
      else
      begin
        if not IsRowSelect and CanModify then
          if ((Key = VK_INSERT) and not (ssCtrl in Shift)) and
            IsCanInsert and IsCanNavigation and not IsKeyFieldEmpty then
          begin
            if (Self.State = tsEditing) then CloseEditor;
            ClearSelection;
            Insert;
            ShowEditor;
          end;
        // Post  
        case Key of
        VK_UP: if (State in dsEditModes) then
          begin
            if (State = dsInsert) and not Modified and EOF and
              not Datalink.IsModified then
            begin
              Cancel;
              FocusedNumber := GetAbsoluteCount - 1;
              Exit;
            end
            else
              if FocusedNumber = 0 then Post;
          end;
        VK_DOWN: if FocusedNumber = (GetAbsoluteCount - 1) then
          begin
            if (State = dsInsert) and not Modified and
              not Datalink.IsModified then // TODO Exit;
            else
              if (State in dsEditModes) then Post;
          end;
        end;  
      end;
    end;
    inherited KeyDown(Key, Shift);
  finally
    OnKeyDown := KeyDownEvent;
    EndSelection;
  end;
end;

procedure TCustomdxDBTreeList.Loaded;
begin
  FLoaded := True;
  BeginUpdate;
  try
    inherited Loaded;
    FullRefresh;
    {RefreshDefWidth before LoadFromReg}
    RefreshDefaultColumnsWidths;
    // Load From Ini/Regsirty
    DoRestoreLayout;
    // calc best panel size
    if IsAutoHeaderPanelRowCount then HeaderPanelBestFit;
  finally
    EndUpdate;
    FLoaded := False;
  end;
end;

procedure TCustomdxDBTreeList.Notification(AComponent: TComponent; Operation: TOperation);
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
        // check KeyField or ParentField (OnChangeNodeEx)
        IsKeyField := (FKeyField = AComponent) or (FParentField = AComponent);
        if IsKeyField then
        begin
          FKeyField := nil;
          FParentField := nil;
        end;
        NeedLayout := False;
        for I := 0 to ColumnCount-1 do
          with TdxDBTreeListControlColumn(Columns[I]) do
            if (Field = AComponent) or (FPreviewField = AComponent) or
              (IsKeyField and FDataLink.Active) then
            begin
              NeedLayout := True;
              FField := nil;
            end;
        // reset if needed
        if NeedLayout and Assigned(FDatalink.Dataset) and
           (not FDatalink.Dataset.ControlsDisabled) then
        begin
          BeginUpdate;
          try
            for I := 0 to ColumnCount-1 do
              with Columns[I] do
                if Field = AComponent then
                  FieldName := FieldName;
            if IsKeyField and FDataLink.Active then
              LinkActive(FDataLink.DataSet.Active);
            if (FPreviewField = AComponent) then FPreviewField := Nil;
          finally
            EndUpdate;
          end;
        end;
      end;
  end;
end;

// Selection
procedure TCustomdxDBTreeList.DoSelectedCountChange;
begin
  inherited DoSelectedCountChange;
  if not (csDestroying in ComponentState) and (LockSelection = 0) and
    Assigned(OnChangeNodeEx) then
  begin
    CheckChangeNodeEx;
    LoadChangeNodeInfo(FPrevNodeInfo);
  end;
end;

function TCustomdxDBTreeList.IsNodeSelected(ANode: TdxTreeListNode): Boolean;
var
  Index: Integer;
begin
  Result := False;
  if GetSelectedCount = 0 then Exit;
  if IsUseBookmarks then
    Result := BkmList.IndexOfObject(ANode) <> -1
  else Result := FindSelectedNode(ANode, Index); {Sorted List}
end;

procedure TCustomdxDBTreeList.NodeSelected(ANode: TdxTreeListNode; ASelected: Boolean);
var
  Index: Integer;
  Current: TBookmarkStr;
begin
  if not IsMultiSelect or not DataLink.Active then Exit;
  if IsUseBookmarks then
  begin
    if ASelected and not CanNodeSelected(ANode) then Exit;
    Current := Datalink.Datasource.Dataset.Bookmark;
    Index := BkmList.IndexOfObject(ANode);
    if (Index <> -1) = ASelected then Exit;
    if ASelected then FindBkm(Current, Index);
    if Index = -1 then Index := 0;
    if ASelected then
    begin
      BkmList.Insert(Index, Current);
      BkmList.Objects[Index] := ANode;
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
  UpdateNode(ANode, False{no Below});
  inherited NodeSelected(ANode, ASelected);
end;

procedure TCustomdxDBTreeList.SetColumnSorted(Column: TdxTreeListColumn);
begin
  if IsMultiSort and (SortedColumn <> nil) then; // check SortedColumns[]
  inherited SetColumnSorted(Column);
  if IsAutoSort and not LockSorting then
    DoSortColumn(-1{all levels}, Column.Index, Column.Sorted = csDown);
end;

function TCustomdxDBTreeList.CanDblClick: Boolean;
begin
  Result := etoDblClick in OptionsBehavior;
end;

procedure TCustomdxDBTreeList.DoBeforeExpand(Node: TdxTreeListNode; var AllowExpand: Boolean);
begin
  inherited DoBeforeExpand(Node, AllowExpand);
  if AllowExpand and not IsLoadAllRecords and
    (Node.Count = 0) and not FDatachangedBusy then
  begin
    LoadTreeList(TdxDBTreeListNode(Node));
    Node.HasChildren := Node.Count > 0;
    AllowExpand := Node.HasChildren;
  end;
end;

procedure TCustomdxDBTreeList.EndCustomLayout;
begin
  inherited EndCustomLayout;
  AssignKeyFields;
  UpdateActive;
end;

// based override
function TCustomdxDBTreeList.CreateNode: TdxTreeListNode;
begin
  Result := TdxDBTreeListNode.Create(Self);
end;

procedure TCustomdxDBTreeList.DeleteNode(Node, Prior, Next: TdxTreeListNode; IsLast, Redraw: Boolean);
begin
  inherited DeleteNode(Node, Prior, Next, IsLast, Redraw);
  if FUpdatingNode = Node then
    FUpdatingNode := nil;
end;

function TCustomdxDBTreeList.GetFooterCellText(Node: TdxTreeListNode; AbsoluteIndex, FooterIndex: Integer): string;
begin
  if FooterIndex = -1 then // summary footer
    Result := TdxDBTreeListControlColumn(Columns[AbsoluteIndex]).GetSummaryFooterText
  else Result := inherited GetFooterCellText(Node, AbsoluteIndex, FooterIndex);
end;

function TCustomdxDBTreeList.GetNodeString(Node: TdxTreeListNode; Column: Integer): string;
var
  DrawColumn: TdxDBTreeListColumn;
begin
  Result := inherited GetNodeString(Node, Column);
  DrawColumn := Columns[Column];
  // OnGetText
  if Assigned(DrawColumn.OnGetText) then
    DrawColumn.OnGetText(DrawColumn, Node, Result);
end;

function TCustomdxDBTreeList.GetNodeValue(Node: TdxTreeListNode; Column: Integer): Variant;
begin
  with TdxDBTreeListControlNode(Node) do
  if nadValue in VariantData[Column].AssignedValues then
    Result := VariantData[Column].Value
  else Result := Node.Strings[Column];
end;

function TCustomdxDBTreeList.GetNodeVariant(Node: TdxTreeListNode; Column: Integer): Variant;
var
  S: string;
begin
  if Columns[Column].VariantType = varString then
  begin
    S := Node.Strings[Column];
    if IsCaseInsensitive then
      Result := AnsiUpperCase(S)
    else Result := S;
  end
  else
    Result := TdxDBTreeListControlNode(Node).VariantData[Column].Value;
end;

function TCustomdxDBTreeList.GetPreviewText(Node: TdxTreeListNode): string;
begin
  Result := TdxDBTreeListControlNode(Node).Description;
  if Assigned(OnGetPreviewText) then OnGetPreviewText(Self, Node, Result);
end;

procedure TCustomdxDBTreeList.ResetAutoHeaderPanelRowCountOption;
begin
  inherited ResetAutoHeaderPanelRowCountOption;
  FOptionsView := FOptionsView - [etoAutoHeaderPanelHeight];
end;

procedure TCustomdxDBTreeList.SetFocusedNode(Node: TdxTreeListNode; Column: Integer; MakeVisibleFlag: Boolean);
begin
  if Node = nil then Exit;
  AddNodeLink(Node);
  if not FInUpdateActive then
  begin
    inherited SetFocusedNode(FocusedNode, Column, False);
    if not FRefreshTreeList then
      if not LocateByNode(TdxDBTreeListNode(FocusedNode), TdxDBTreeListNode(Node),
        TdxDBTreeListNode(Node).Id) then Exit
  end;
  if not ValidateNode(Node) then Exit
  else if NodeLinkList <> nil then {FNodeLink.Remove(Node)}; {WARNING}
  inherited SetFocusedNode(Node, Column, MakeVisibleFlag);
end;

procedure TCustomdxDBTreeList.ChangedGroupColumn(Column: TdxDBTreeListColumn);
begin
  if FFlagChangedGroupColumn {or FLoaded TODO} then Exit;
  FFlagChangedGroupColumn := True;
  try
//    ReloadTreeList(False);
    FullRefresh;
  finally
    FFlagChangedGroupColumn := False;
  end;
end;

function TCustomdxDBTreeList.GetDataLink: TdxDBTreeListControlDataLink;
begin
  Result := FDataLink;
end;

function TCustomdxDBTreeList.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TCustomdxDBTreeList.GetDefaultFields: Boolean;
begin
  Result := False;
end;

function TCustomdxDBTreeList.IsAutoCalcKeyValue: Boolean;
begin
  Result := etoAutoCalcKeyValue in OptionsDB;
  if not IsLoadAllRecords and not Assigned(FOnGetUniqueKeyValue) then
    Result := False;
end;

function TCustomdxDBTreeList.IsAutoDragCopy: Boolean;
begin
  Result := etoAutoDragDropCopy in OptionsBehavior;
end;

function TCustomdxDBTreeList.IsAutoDragDrop: Boolean;
begin
  Result := etoAutoDragDrop in OptionsBehavior;
end;

function TCustomdxDBTreeList.IsAutoSearch: Boolean;
begin
  Result := IsLoadedAll and inherited IsAutoSearch;
end;

function TCustomdxDBTreeList.IsCancelOnExit: Boolean;
begin
  Result := etoCancelOnExit in OptionsDB;
end;

function TCustomdxDBTreeList.IsCanInsert: Boolean;
begin
  Result := etoCanInsert in OptionsDB;
end;

function TCustomdxDBTreeList.IsCanNavigation: Boolean;
begin
  Result := etoCanNavigation in OptionsDB;
end;

function TCustomdxDBTreeList.IsKeyFieldEmpty: Boolean;
begin
  Result := (FKeyField = nil) or (FParentField = nil);
end;

function TCustomdxDBTreeList.IsLoadAllRecords: Boolean;
begin
  Result := etoLoadAllRecords in OptionsDB;
end;

function TCustomdxDBTreeList.IsLoadedAll: Boolean;
begin
  Result := IsLoadAllRecords;
end;

function TCustomdxDBTreeList.IsUseBookmarks: Boolean;
begin
  Result := etoUseBookmarks in OptionsDB;
end;

procedure TCustomdxDBTreeList.SetDataChangedBusy(Value: Boolean);
begin
  FDataChangedBusy := Value;
end;

procedure TCustomdxDBTreeList.DataChanged;
begin
  // ChangeNodeEx
  if (LockSelection = 0) and Assigned(OnChangeNodeEx) then
  begin
    CheckChangeNodeEx;
    LoadChangeNodeInfo(FPrevNodeInfo);
  end;
  if DataChangedLocate and not DataSetChangedBusy then
    FDataChangedLocateResync := True
  else FDataChangedLocateResync := False;
  if (Datalink.DataSet.State <> dsInsert) then FUpdatingNode := nil;
  if DataChangedLocate then
  begin
    FDataChangedLocate := False;
    Exit;
  end;
  if DataSetChangedBusy then Exit;
  if (IsDBTreeListControlDataSetBusy(Datalink.DataSet) or LockRefresh) then
  begin
    Scroll(0);
    Exit;
  end;
  if DataSetChangedBusy or (DataLink.DataSet.State = dsEdit) or
    (DataLink.DataSet.State = dsSetKey) then Exit;
  if Assigned(FKeyField) and (DataLink.DataSet.State = dsInsert) then
  begin
    InsertNode(DataLink.DataSet.EOF);
    if etoResetColumnFocus in OptionsDB then FocusedColumn := 0;
    Exit;
  end;

  FRefreshTreeList := True;
  try
    RefreshTreeList;
    if not FLocateByNode then FindNodeById;
  finally
    FRefreshTreeList := False;
  end;
end;

function TCustomdxDBTreeList.IsDataSetBusy: Boolean;
begin
  Result := DataSetChangedBusy or DataChangedLocate;
end;

procedure TCustomdxDBTreeList.LinkActive(Value: Boolean);
begin
  if not Value then HideEditor;
//  ReloadTreeList(True); {<-ClearSelection}
  FullRefresh;
end;

procedure TCustomdxDBTreeList.RecordChanged(Field: TField);
var
  Node: TdxDBTreeListControlNode;
begin
  if (Datalink.Dataset.State = dsInsert) and
    (FUpdatingNode = nil) then Exit;
  if Datalink.Dataset.State = dsSetKey then Exit;
  Node := TdxDBTreeListControlNode(FocusedNode);
  NodeRecordChanged(Field, Node);
  FUpdatingNode := TdxDBTreeListNode(Node);
end;

procedure TCustomdxDBTreeList.Scroll(Distance: Integer);
begin
  UpdateActive;
  // new
  if etoSyncSelection in OptionsDB then ResyncSelection;
  DoChangeNodeEx;
end;

procedure TCustomdxDBTreeList.AssignKeyFields;
begin
  FKeyField := nil;
  FParentField := nil;
  FImageIndexField := nil;
  FStateIndexField := nil;
  if DataLink.Active then
  begin
    if KeyField <> '' then
      FKeyField := DataLink.DataSet.FindField(KeyField);
    if ParentField <> '' then
      FParentField := DataLink.DataSet.FindField(ParentField);
    if ImageIndexFieldName <> '' then
      FImageIndexField := DataLink.DataSet.FindField(ImageIndexFieldName);
    if StateIndexFieldName <> '' then
      FStateIndexField := DataLink.DataSet.FindField(StateIndexFieldName);
  end;
end;

procedure TCustomdxDBTreeList.AssignNodeAllValues(Node: TdxDBTreeListControlNode);
begin
  inherited AssignNodeAllValues(Node);
  if Assigned(FImageIndexField) then
    TdxDBTreeListNode(Node).FImageIndex := FImageIndexField.AsInteger;
  if Assigned(FStateIndexField) then
    TdxDBTreeListNode(Node).FStateIndex := FStateIndexField.AsInteger;
  if etoUseImageIndexForSelected in OptionsView then
    TdxDBTreeListNode(Node).FSelectedIndex := TdxDBTreeListNode(Node).FImageIndex
  else TdxDBTreeListNode(Node).FSelectedIndex := Self.SelectedIndex;
  // Assign propery Data: Pointer
  DoRefreshNodeData(Node);
end;

procedure TCustomdxDBTreeList.AssignSummaryFooterFields;
begin
  inherited AssignSummaryFooterFields;
  FTotalSummaryCount := 0;
end;

procedure TCustomdxDBTreeList.CalcSummary;
var
  I: Integer;
  Col: TdxDBTreeListControlColumn;
begin
  // footer summary
  for I := 0 to ColumnCount - 1 do
  begin
    Col := TdxDBTreeListControlColumn(Columns[I]);
    case Col.SummaryFooterType of
    cstCount: Col.FSummaryFooterValue := FTotalSummaryCount;
    cstAvg: if FTotalSummaryCount > 0 then
      Col.FSummaryFooterValue := Col.FSummaryFooterValue / FTotalSummaryCount;
    end;
  end;
  if Assigned(OnCalcSummary) then OnCalcSummary(Self);
end;

procedure TCustomdxDBTreeList.FindNodeById;

  procedure GotoNode(Node: TdxTreeListNode);
  begin
    Node.MakeVisible;
    Node.Focused := True;
  end;

var
  Node: TdxDBTreeListNode;
begin
  if FDataChangedBusy or IsKeyFieldEmpty or not IsCanNavigation then Exit;
  Node := FindNodeByKeyValue(FKeyField.Value);
  if Node <> nil then
    GotoNode(Node)
  else RefreshTreeList;
end;

function TCustomdxDBTreeList.GetUniqueKeyValue(const Delta: Variant): Variant;

  procedure FindMaxValue(Node: TdxDBTreeListNode);
  var
    I: Integer;
  begin
    {$IFNDEF DELPHI6}
    if Node.Id > Result then
      Result := Node.Id;
    {$ELSE}
    if VarCompare(Node.Id, Result) > 0 then
      Result := Node.Id;
    {$ENDIF}
    for I := 0 to Node.Count - 1 do
      FindMaxValue(TdxDBTreeListNode(Node[I]));
  end;

var
  I: Integer;
begin
  Result := Null;
  if Assigned(FOnGetUniqueKeyValue) then
    FOnGetUniqueKeyValue(Self, Result)
  else
    if IsLoadAllRecords then
    begin
      if not IsKeyFieldEmpty and (Count > 0) then
      begin
        Result := TdxDBTreeListNode(Items[0]).Id;
        for I := 0 to Count - 1 do
          FindMaxValue(TdxDBTreeListNode(Items[I]));
      end;
      try
        if VarType(Result) in [varSmallint, varInteger, varSingle, varDouble, varCurrency] then
          Result := Result + 1 + Delta
        else Result := 0;
      except
        Result := Null;
      end;
    end;
end;

procedure TCustomdxDBTreeList.LoadTreeList(LoadingNode: TdxDBTreeListNode);
var
  FLoadedNodes: TList;
  FNodes: TList;
  FHasChildrenNodes: TList;

  procedure LoadNodes(Node: TdxTreeListNode);
  var
    I: Integer;
  begin
    for I := 0 to Node.Count - 1 do LoadNodes(Node[I]);
    FLoadedNodes.Add(Node);
  end;

  function FindParentNode(const Value: Variant; var Index: Integer): Boolean;
  var
    L, H, I, C: Integer;
  begin
    Result := False;
    L := 0;
    H := FLoadedNodes.Count - 1;
    while L <= H do
    begin
      I := (L + H) shr 1;
      C := VarCompare(TdxDBTreeListNode(FLoadedNodes[I]).Id{FParentId}, Value);
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

  function FindNodeId(var Node: TdxDBTreeListNode; const Value: Variant): Boolean;
  var
    L, H, I: Integer;
  begin
    Result := False;
    L := 0;
    H := FNodes.Count - 1;
    while L <= H do
    begin
      I := (L + H) shr 1;
      try
        if (TdxDBTreeListNode(FNodes[I]).Id = Value) then
        begin
          Node := TdxDBTreeListNode(FNodes[I]);
          FNodes.Delete(I);
          Result := True;
          Break;
        end
        else
          if (TdxDBTreeListNode(FNodes[I]).Id < Value) then L := I + 1
          else H := I - 1;
      except
        Result := False; // Variant Error
        Break;
      end;
    end;
  end;

var
  ASavePos: TBookmarkStr;
  ASaveBOF, ASaveEOF: Boolean;
  ASaveActiveRecord: Integer;
  OldCursor: TCursor;
  Node: TdxDBTreeListNode;
  I, Index: Integer;
  IdValue, ParentValue: Variant;
  KeyValue, KeyParentValue: Variant;
  PrevDataSetState: TDataSetState;

  function LoadValues: TdxDBTreeListNode;
  var
    FoundNode: Boolean;
  begin
    Result := nil;
    FoundNode := FindNodeId(Result, IdValue);
    if FoundNode then
    begin
      if (Result.FParentId <> ParentValue) or
        ((Result.Parent <> nil) and (TdxDBTreeListNode(Result.Parent).Id <> ParentValue))then
      begin
        if FindParentNode(ParentValue, I) and Result.CanMove(TdxTreeListNode(FLoadedNodes[I]), natlAddChild) then
          Result.InternalMove(TdxTreeListNode(FLoadedNodes[I]), natlAddChild)
        else
          Result.InternalMove(Items[0], natlAdd);
      end;
    end
    else
    begin
      if FindParentNode(ParentValue, I) then
        Result := TdxDBTreeListNode(TdxTreeListNode(FLoadedNodes[I]).AddChild)
      else
        Result := TdxDBTreeListNode(Add);
    end;
    Result.FParentId := ParentValue;
    // Load Values
    AssignNodeAllValues(Result);
    if not FoundNode then
    begin
      if not FindParentNode(Result.Id, I) then
        FLoadedNodes.Insert(I, Result);
    end;
    // select all
    if FSelectAllFlag then //LoadBookamrk(Node);
      Result.Selected := True;
  end;

  procedure LoadSummaryFooterValues;
  var
    SType: TdxSummaryType;
    Col: TdxDBTreeListControlColumn;
    V: Extended;
    I: Integer;
  begin
    for I := 0 to ColumnCount - 1 do
    begin
      Col := TdxDBTreeListControlColumn(Columns[I]);
      SType := Col.SummaryFooterType;
      if (SType <> cstNone) then
      begin
        if Assigned(Col.FSmrFooterField) and (SType <> cstCount) then
          V := Col.FSmrFooterField.AsFloat
        else V := 0;
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
            cstMin: if V <  FSummaryFooterValue then FSummaryFooterValue := V;
            cstMax: if V >  FSummaryFooterValue then FSummaryFooterValue := V;
            cstSum, cstAvg: FSummaryFooterValue := FSummaryFooterValue + V;
          end;
      end;
    end;
    Inc(FTotalSummaryCount);
  end;

  procedure LoadLevel(ANode: TdxDBTreeListNode; const AParentValue: Variant; NewNodes: TList);

    function IsExistChildren(Node: TdxDBTreeListNode): Boolean;
    begin
      Result := not (etoCheckHasChildren in OptionsDB) or
        DataLink.DataSet.Locate(ParentField, Node.Id, []);
    end;

  var
    I: Integer;
    Item: TdxDBTreeListNode;
    List: TList;
  begin
    ParentValue := AParentValue;
    with DataLink.DataSet do
      if Locate(ParentField, ParentValue, []) then
      begin
        List := TList.Create;
        try
          while not EOF and (FParentField.Value = ParentValue) do
          begin
            IdValue := FKeyField.Value;
            Item := LoadValues;
            if NewNodes <> nil then NewNodes.Add(Item);
            if ANode = nil then List.Add(Item);
            Next;
          end;
          // load children if expanded
          if ANode = nil then
          begin
            for I := 0 to List.Count - 1 do
            begin
              Item := TdxDBTreeListNode(List[I]);
              if Item.Expanded then
                LoadLevel(Item, Item.Id, nil)
              else
                if IsExistChildren(Item) then FHasChildrenNodes.Add(Item);
            end;
          end
          else
          begin
            for I := 0 to ANode.Count - 1 do
            begin
              Item := TdxDBTreeListNode(ANode[I]);
              if Item.Expanded then
                LoadLevel(Item, Item.Id, nil)
              else
                if IsExistChildren(Item) then FHasChildrenNodes.Add(Item);
            end;
          end;
        finally
          List.Free;
        end;
      end;
  end;

  procedure LoadLevelBack(AParentValue: Variant);
  var
    I, Index: Integer;
    NewNodes: TList;
    Node: TdxDBTreeListNode;
  begin
    NewNodes := TList.Create;
    try
      repeat
        if FindParentNode(AParentValue, I) then
        begin
          LoadLevel(TdxDBTreeListNode(FLoadedNodes[I]), AParentValue, nil);
          Break;
        end
        else
        begin
          LoadLevel(nil, AParentValue, NewNodes);
          if not Datalink.DataSet.Locate(KeyField, AParentValue, []) then Break;
          AParentValue := FParentField.Value;
        end;
      until False;
      // Correct Parent
      for I := 0 to NewNodes.Count - 1 do
      begin
        Node := TdxDBTreeListNode(NewNodes[I]);
        if FindParentNode(Node.FParentId, Index) and
          Node.CanMove(TdxTreeListNode(FLoadedNodes[Index]), natlAddChild) then
          Node.InternalMove(TdxTreeListNode(FLoadedNodes[Index]), natlAddChild);
      end;
    finally
      NewNodes.Free;
    end;
  end;

  function IsExistKeyRoot(AParentValue: Variant): Boolean;
  var
    ARootValue: Variant;
  begin
    Result := False;
    ARootValue := RootValueAsVariant;
    repeat
      if AParentValue = ARootValue then
      begin
        Result := True;
        Break;
      end;
      if not Datalink.DataSet.Locate(KeyField, AParentValue, []) or
        (FKeyField.Value = FParentField.Value) then Break;
      AParentValue := FParentField.Value;
    until False;
  end;

begin
  if (csLoading in ComponentState) or (DataLink.DataSet = nil) or
    not DataLink.DataSet.Active then Exit;
  FDataChangedBusy := True;
  try
    // Assign Key, Parent Fields
    AssignKeyFields;
    if IsKeyFieldEmpty then Exit;
    with DataLink.DataSet do
    begin
      AssignPreviewField;
      if IsLoadAllRecords then
      begin
        AssignSummaryFooterFields;
        DoBeforeCalcSummary; // before summary
      end;
      DisableControls;
      OldCursor := Screen.Cursor;
      try
        // save DataSet Position
        if DataLink.DataSet.State in dsEditModes then
        begin
          PrevDataSetState := DataLink.DataSet.State;
          DataLink.DataSet.Cancel;
          if FUpdatingNode <> nil then
          begin
            if PrevDataSetState = dsEdit then
              RefreshNodeValues(TdxDBTreeListControlNode(FUpdatingNode))
            else FUpdatingNode.Free;
          end;  
          FUpdatingNode := nil;
        end;
        ASavePos := Bookmark;
        ASaveBOF := BOF;
        ASaveEOF := EOF;
        ASaveActiveRecord := TDummyDataSet(DataLink.DataSet).ActiveRecord;
        if IsShowHourGlass then Screen.Cursor := crHourglass;
        // refresh list
        FLoadedNodes := TList.Create;
        FNodes := TList.Create;
        FHasChildrenNodes := TList.Create;
        try
          // Load Nodes
          for I := 0 to Count - 1 do LoadNodes(Items[I]);
          FLoadedNodes.Sort(CompareNodeId);
          // Copy Nodes
          if LoadingNode = nil then // RefreshTreeList
          begin
            FNodes.Count := FLoadedNodes.Count;
            System.Move(FLoadedNodes.List^, FNodes.List^, FLoadedNodes.Count * SizeOf(Pointer));
          end;
          if IsLoadAllRecords then
          begin
            // Load From DataSet
            First;
            while not EOF do
            begin
              IdValue := FKeyField.Value;
              ParentValue := FParentField.Value;
              LoadValues;
              // Load Summary Footer for current record
              LoadSummaryFooterValues;
              Next;
            end;
            // Correct Parent
            for I := Count - 1 downto 0 do
            begin
              Node := TdxDBTreeListNode(Items[I]);
              if FindParentNode(Node.FParentId, Index) and
                Node.CanMove(TdxTreeListNode(FLoadedNodes[Index]), natlAddChild) then
//                if TdxDBTreeListNode(FLoadedNodes[Index]).ParentId <> Node.ParentId then
                Node.InternalMove(TdxTreeListNode(FLoadedNodes[Index]), natlAddChild);
            end;
          end
          else
          begin
            if LoadingNode = nil then
            begin
              KeyValue := FKeyField.Value;
              KeyParentValue := FParentField.Value;
              LoadLevel(nil, RootValueAsVariant, nil);
              // check FocusedNode
              {$DEFINE CHECK_EXIST_KEY_ROOT}
              {$IFDEF CHECK_EXIST_KEY_ROOT}
              if (FKeyField <> FParentField) and IsExistKeyRoot(KeyParentValue) then
              {$ENDIF}
                if not FindParentNode(KeyValue, I) then
                  LoadLevelBack(KeyParentValue);
            end
            else LoadLevel(LoadingNode, LoadingNode.Id, nil);
          end;
          // free deleted nodes
          FNodes.Sort(CompareParentNode);
          for I := FNodes.Count - 1 downto 0 do
            TdxDBTreeListNode(FNodes[I]).Free;
          // set HasChildren
          for I := 0 to FHasChildrenNodes.Count - 1 do
            TdxDBTreeListNode(FHasChildrenNodes[I]).HasChildren := True;
          // Check TopVisibleNode
          if TopIndex < 0 then ResetTopFocusedNodes;
        finally
          FHasChildrenNodes.Free;
          FNodes.Free;
          FLoadedNodes.Free;
        end;
        // sorting
        RefreshSorting;
        // calc summary
        CalcSummary;
        // restore dataset pos
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
        end;
      finally
        Screen.Cursor := OldCursor;
        EnableControls;
      end;
    end;
  finally
    FDataChangedBusy := False;
  end;
end;

function TCustomdxDBTreeList.LocateByNode(OldNode, Node: TdxDBTreeListNode; const Value: Variant): Boolean;
begin
  Result := True;
  if FDataChangedBusy then Exit;
  if not IsKeyFieldEmpty and (FKeyField.Value = Node.Id) and
    (OldNode = Node) or ((Node = FUpdatingNode) and Datalink.Active and
    (Datalink.DataSet.State = dsInsert)) then Exit;
  if not IsCanNavigation then Exit;
  FDataChangedBusy := True;
  try
    try
      if Datalink.Active then
      begin
        FDataChangedBusy := not (Datalink.DataSet.State in dsEditModes);
        FDataChangedLocate := True;
        Datalink.DataSet.Locate(KeyField, Value, []);
      end;
    except
      Result := False;
      raise;
    end;
  finally
    FDataChangedLocate := False;
    FDataChangedBusy := False;
  end;
end;

procedure TCustomdxDBTreeList.RefreshNodeValues(var Node: TdxDBTreeListControlNode);
begin
  if (Node <> nil) and IsCanNavigation and not IsKeyFieldEmpty then
  begin
    AssignNodeAllValues(Node);
  end;
  if IsRowAutoHeight or (IsShowPreview and IsAutoCalcPreviewLines) then
  begin
    // reset node height
    ClearNodeRowHeight;
    Invalidate;
  end
  else InvalidateRect(GetRectNode(Node));
end;

procedure TCustomdxDBTreeList.RefreshTreeList;
begin
  BeginUpdate;
  try
    // reload nodes
    LoadTreeList(nil);
  finally
    EndUpdate;
  end;
end;

procedure TCustomdxDBTreeList.ReloadTreeList(AClearNodes: Boolean);
var
  I: Integer;
begin
  BeginUpdate;
  try
    HideEditor;
    if AClearNodes then ClearNodes;
    // Reset and Assign Fields
    Datalink.ClearMapping;
    if Datalink.Active then DefineFieldMap;
    // Force columns to reaquire fields (in case dataset has changed)
    for I := 0 to ColumnCount-1 do
      Columns[I].FieldName := Columns[I].FieldName;
    RefreshTreeList;
  finally
    EndUpdate;
  end;
end;

procedure TCustomdxDBTreeList.DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  Node: TdxTreeListNode;
  NodeAttachMode: TdxTreeListNodeAttachMode;
  PrevAccept: Boolean;
begin
  PrevAccept := IsAutoDragDrop and (Source = Self) and
    GetNodeAttachMode(X, Y, Node, NodeAttachMode);
  Accept := PrevAccept;
  inherited DragOver(Source, X, Y, State, Accept);
  if not Assigned(OnDragOver) then Accept := PrevAccept;
end;

function TCustomdxDBTreeList.GetNodeAttachMode(X, Y: Integer; var DestNode: TdxTreeListNode;
  var AttachMode: TdxTreeListNodeAttachMode): Boolean;

  function CalcAccept(ADragNode: TdxTreeListNode): Boolean;
  begin
    Result := (IsAutoDragCopy and (GetAsyncKeyState(VK_CONTROL) < 0)) or
      ADragNode.CanMove(DestNode, AttachMode);
  end;

var
  AHitInfo: TdxTreeListHitInfo;
  ADrawInfo: TdxGridDrawInfo;
  I: Integer;
begin
  DestNode := nil;
  AttachMode := natlAddChild;
  Result := False;
  // get hit info
  AHitInfo := GetHitInfo(Point(X, Y));
  if AHitInfo.hitType in [htNowhere, htButton, htIcon, htStateIcon, htIndent,
    htLabel, htSummaryNodeFooter, htPreview] then
  begin
    DestNode := AHitInfo.Node;
    if AHitInfo.hitType in [htButton, htIcon, htStateIcon, htLabel, htSummaryNodeFooter, htPreview] then
      AttachMode := natlAddChild
    else
      if AHitInfo.hitType = htNowhere then
      begin
        CalcRectInfo(ADrawInfo);
        if Y >= ADrawInfo.CellsRect.Top then
        begin
          AttachMode := natlAdd;
          DestNode := Items[0];
        end;
      end
      else
        if AHitInfo.hitType = htIndent then
          AttachMode := natlInsert;
    // check parent
    if SelectedCount = 0 then
      Result := CalcAccept(DragNode)
    else
      for I := 0 to SelectedCount - 1 do
      begin
        Result := CalcAccept(SelectedNodes[I]);
        if not Result then Break;
      end;
  end;
end;

procedure TCustomdxDBTreeList.BeginReadSettings(ARegIniWrapper: TdxRegIniWrapper);
begin
  inherited BeginReadSettings(ARegIniWrapper);
  BeginLayout;
end;

procedure TCustomdxDBTreeList.EndReadSettings(ARegIniWrapper: TdxRegIniWrapper);
begin
  EndLayout;
  inherited EndReadSettings(ARegIniWrapper);
end;

procedure TCustomdxDBTreeList.ReadSettings(ARegIniWrapper: TdxRegIniWrapper; const APath: string);
begin
  inherited ReadSettings(ARegIniWrapper, APath);
  with ARegIniWrapper do
  begin
    ShowNewItemRow := ReadBool(APath, 'ShowNewItemRow', ShowNewItemRow);
    ShowFooter := ReadBool(APath, 'ShowFooter', ShowFooter);
  end;
end;

procedure TCustomdxDBTreeList.WriteSettings(ARegIniWrapper: TdxRegIniWrapper; const APath: string);
begin
  inherited WriteSettings(ARegIniWrapper, APath);
  with ARegIniWrapper do
  begin
    WriteBool(APath, 'ShowNewItemRow', ShowNewItemRow);
    WriteBool(APath, 'ShowFooter', ShowFooter);
  end;
end;

function TCustomdxDBTreeList.GetNodeByNavigation(ANode: TdxTreeListNode; ANavigationMode: TdxTreeListNavigationMode;
  AGotoHidden: Boolean): TdxTreeListNode;
begin
  if not IsLoadAllRecords and AGotoHidden then
  begin
    if (ANavigationMode = tlnmNext) and ANode.HasChildren and not ANode.Expanded then
      ANode.Expanded := True;
  end;
  Result := inherited GetNodeByNavigation(ANode, ANavigationMode, AGotoHidden);
end;

procedure TCustomdxDBTreeList.CheckChangeNodeEx;
var
  NodeInfo: TdxChangeDBTreeListNodeInfo;
begin
  LoadChangeNodeInfo(NodeInfo);
  if (FPrevNodeInfo.Selected <> NodeInfo.Selected) or
    (VarType(FPrevNodeInfo.Id) <> VarType(NodeInfo.Id)) or
    (FPrevNodeInfo.Id <> NodeInfo.Id) then DoChangeNodeEx;
end;

function TCustomdxDBTreeList.GetOptionsBehavior: TdxDBTreeListOptionsBehavior;
begin
  Result := FOptionsBehavior;
end;

function TCustomdxDBTreeList.GetOptionsCustomize: TdxDBTreeListOptionsCustomize;
begin
  Result := FOptionsCustomize;
end;

function TCustomdxDBTreeList.GetOptionsDB: TdxDBTreeListOptionsDB;
begin
  Result := FOptionsDB;
end;

function TCustomdxDBTreeList.GetOptionsView: TdxDBTreeListOptionsView;
begin
  Result := FOptionsView;
end;

function TCustomdxDBTreeList.GetRootValue: string;
begin
  if VarIsNull(FRootValue) then
    Result := ''
  else Result := {VarToStr}(FRootValue);
end;

function TCustomdxDBTreeList.GetRootValueAsVariant: Variant;
begin
  if (VarType(FRootValue) = varString) and (FRootValue = '') then
    Result := Null
  else Result := FRootValue;
end;

procedure TCustomdxDBTreeList.InsertNode(FAppend: Boolean);
var
  ANode: TdxTreeListNode;
  PrevNewItemRowActive: Boolean;
begin
  if FocusedNode <> nil then
  begin
    if FocusedNode.Parent <> nil then
      ANode := FocusedNode.Parent.AddChild
    else ANode := Add;
  end
  else ANode := Add;
  TdxDBTreeListNode(ANode).Id := Null;
  if IsAutoCalcKeyValue then
    FKeyField.Value := GetUniqueKeyValue(0);
  AssignNodeAllValues(TdxDBTreeListNode(ANode));
  if Assigned(FParentField) then
    TdxDBTreeListNode(ANode).FParentId := FParentField.Value;
  FUpdatingNode := TdxDBTreeListNode(ANode);
  if TdxDBTreeListNode(ANode).ParentId <> Null then
  begin
    ANode := FindNodeByKeyValue(TdxDBTreeListNode(ANode).ParentId);
    if ANode <> nil then
      FUpdatingNode.MoveTo(ANode, natlAddChild);
  end;
  PrevNewItemRowActive := NewItemRowActive;
  FUpdatingNode.Focused := True;
  FUpdatingNode.MakeVisible;
  NewItemRowActive := PrevNewItemRowActive;
end;

procedure TCustomdxDBTreeList.LoadChangeNodeInfo(var NodeInfo: TdxChangeDBTreeListNodeInfo);
begin
  if (FocusedNode <> nil) and
    Assigned(DataLink.DataSet) and DataLink.DataSet.Active then
  begin
    NodeInfo.Selected := FocusedNode.Selected;
    if Assigned(FKeyField) and Assigned(FKeyField.DataSet) then
      NodeInfo.Id := FKeyField.Value
    else NodeInfo.Id := Null;
  end
  else
  begin
    NodeInfo.Id := Null;
    NodeInfo.Selected := False;
  end;
end;

procedure TCustomdxDBTreeList.SetDataSource(Value: TDataSource);
begin
  if FDatalink.Datasource = Value then Exit;
  ClearSelection;
  FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TCustomdxDBTreeList.SetImageIndexFieldName(const Value: string);
begin
  if FImageIndexFieldName <> Value then
  begin
    FImageIndexFieldName := Value;
    LinkActive(DataLink.Active);
  end;
end;

procedure TCustomdxDBTreeList.SetOptionsBehavior(Value: TdxDBTreeListOptionsBehavior);
var
  NewOptions: TdxTreeListOptions;
  NewOptionsEx: TdxTreeListOptionsEx;
begin
  if FOptionsBehavior <> Value then
  begin
    BeginUpdate;
    try
      NewOptions := inherited Options;
      NewOptionsEx := inherited OptionsEx;
      if etoAnsiSort in Value then
        Include(NewOptionsEx, aoAnsiSort)
      else Exclude(NewOptionsEx, aoAnsiSort);
      if etoAutoCopySelectedToClipboard in Value then
        Include(NewOptionsEx, aoAutoCopySelectedToClipboard)
      else Exclude(NewOptionsEx, aoAutoCopySelectedToClipboard);
      if etoAutoSearch in Value then
        Include(NewOptionsEx, aoAutoSearch)
      else Exclude(NewOptionsEx, aoAutoSearch);
      if etoAutoSort in Value then
        Include(NewOptions, aoAutoSort)
      else Exclude(NewOptions, aoAutoSort);
      if etoBandButtonClicking in Value then
        Include(NewOptionsEx, aoBandButtonClicking)
      else Exclude(NewOptionsEx, aoBandButtonClicking);
      if etoCaseInsensitive in Value then
        Include(NewOptions, aoCaseInsensitive)
      else Exclude(NewOptions, aoCaseInsensitive);
      if etoDragCollapse in Value then
        Include(NewOptionsEx, aoDragCollapse)
      else Exclude(NewOptionsEx, aoDragCollapse);
      if etoDragExpand in Value then
        Include(NewOptionsEx, aoDragExpand)
      else Exclude(NewOptionsEx, aoDragExpand);
      if etoDragScroll in Value then
        Include(NewOptionsEx, aoDragScroll)
      else Exclude(NewOptionsEx, aoDragScroll);
      if etoEditing in Value then
        Include(NewOptions, aoEditing)
      else Exclude(NewOptions, aoEditing);
      if etoEnterShowEditor in Value then
        Include(NewOptionsEx, aoEnterShowEditor)
      else Exclude(NewOptionsEx, aoEnterShowEditor);
      if etoEnterThrough in Value then
        Include(NewOptionsEx, aoEnterThrough)
      else Exclude(NewOptionsEx, aoEnterThrough);
      if etoHeaderButtonClicking in Value then
        Include(NewOptionsEx, aoHeaderButtonClicking)
      else Exclude(NewOptionsEx, aoHeaderButtonClicking);
      if etoHorzThrough in Value then
        Include(NewOptionsEx, aoHorzThrough)
      else Exclude(NewOptionsEx, aoHorzThrough);
      if etoImmediateEditor in Value then
        Include(NewOptions, aoImmediateEditor)
      else Exclude(NewOptions, aoImmediateEditor);
      if etoMouseScroll in Value then
        Include(NewOptionsEx, aoMouseScroll)
      else Exclude(NewOptionsEx, aoMouseScroll);
      if etoMultiSelect in Value then
        Include(NewOptions, aoMultiSelect)
      else Exclude(NewOptions, aoMultiSelect);
      if etoShowHourGlass in Value then
        Include(NewOptionsEx, aoShowHourGlass)
      else Exclude(NewOptionsEx, aoShowHourGlass);
      if etoStoreToIniFile in Value then
        Include(NewOptions, aoStoreToIniFile)
      else Exclude(NewOptions, aoStoreToIniFile);
      if etoStoreToRegistry in Value then
        Include(NewOptions, aoStoreToRegistry)
      else Exclude(NewOptions, aoStoreToRegistry);
      if etoTabs in Value then
        Include(NewOptions, aoTabs)
      else Exclude(NewOptions, aoTabs);
      if etoTabThrough in Value then
        Include(NewOptions, aoTabThrough)
      else Exclude(NewOptions, aoTabThrough);
      if etoVertThrough in Value then
        Include(NewOptionsEx, aoVertThrough)
      else Exclude(NewOptionsEx, aoVertThrough);
      inherited Options := NewOptions;
      inherited OptionsEx := NewOptionsEx;
      FOptionsBehavior := Value;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TCustomdxDBTreeList.SetOptionsCustomize(Value: TdxDBTreeListOptionsCustomize);
var
  NewOptions: TdxTreeListOptions;
  NewOptionsEx: TdxTreeListOptionsEx;
begin
  if FOptionsCustomize <> Value then
  begin
    BeginUpdate;
    try
      NewOptions := inherited Options;
      NewOptionsEx := inherited OptionsEx;
      if etoBandMoving in Value then
        Include(NewOptionsEx, aoBandMoving)
      else Exclude(NewOptionsEx, aoBandMoving);
      if etoBandPanelSizing in Value then
        Include(NewOptionsEx, aoBandPanelSizing)
      else Exclude(NewOptionsEx, aoBandPanelSizing);
      if etoBandSizing in Value then
        Include(NewOptionsEx, aoBandSizing)
      else Exclude(NewOptionsEx, aoBandSizing);
      if etoColumnMoving in Value then
        Include(NewOptions, aoColumnMoving)
      else Exclude(NewOptions, aoColumnMoving);
      if etoColumnSizing in Value then
        Include(NewOptions, aoColumnSizing)
      else Exclude(NewOptions, aoColumnSizing);
      if etoExtCustomizing in Value then
        Include(NewOptions, aoExtCustomizing)
      else Exclude(NewOptions, aoExtCustomizing);
      if etoFullSizing in Value then
        Include(NewOptionsEx, aoFullSizing)
      else Exclude(NewOptionsEx, aoFullSizing);
      if etoHeaderPanelSizing in Value then
        Include(NewOptionsEx, aoHeaderPanelSizing)
      else Exclude(NewOptionsEx, aoHeaderPanelSizing);
      if etoKeepColumnWidth in Value then
        Include(NewOptionsEx, aoKeepColumnWidth)
      else Exclude(NewOptionsEx, aoKeepColumnWidth);
      if etoRowSizing in Value then
        Include(NewOptionsEx, aoRowSizing)
      else Exclude(NewOptionsEx, aoRowSizing);
      inherited Options := NewOptions;
      inherited OptionsEx := NewOptionsEx;
      FOptionsCustomize := Value;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TCustomdxDBTreeList.SetOptionsDB(Value: TdxDBTreeListOptionsDB);
var
  PrevOptions: TdxDBTreeListOptionsDB;
begin
  if FOptionsDB <> Value then
  begin
    BeginUpdate;
    try
      PrevOptions := OptionsDB;
      FOptionsDB := Value;
      if PrevOptions*[etoUseBookmarks] <> OptionsDB*[etoUseBookmarks] then
        ClearSelection;
      if ((etoCanNavigation in OptionsDB) and not (etoCanNavigation in PrevOptions)) or
        ((etoCheckHasChildren in OptionsDB) and not (etoCheckHasChildren in PrevOptions)) or
        ((etoLoadAllRecords in OptionsDB) <> (etoLoadAllRecords in PrevOptions)) then
        FullRefresh;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TCustomdxDBTreeList.SetOptionsView(Value: TdxDBTreeListOptionsView);
var
  NewOptions: TdxTreeListOptions;
  NewOptionsEx: TdxTreeListOptionsEx;
  PrevOptions: TdxDBTreeListOptionsView;
begin
  if FOptionsView <> Value then
  begin
    BeginUpdate;
    try
      PrevOptions := OptionsView;
      NewOptions := inherited Options;
      NewOptionsEx := inherited OptionsEx;
      if etoAutoCalcPreviewLines in Value then
        Include(NewOptionsEx, aoAutoCalcPreviewLines)
      else Exclude(NewOptionsEx, aoAutoCalcPreviewLines);
      if etoAutoHeaderPanelHeight in Value then
        Include(NewOptionsEx, aoAutoHeaderPanelHeight)
      else Exclude(NewOptionsEx, aoAutoHeaderPanelHeight);
      if etoAutoWidth in Value then
        Include(NewOptions, aoAutoWidth)
      else Exclude(NewOptions, aoAutoWidth);
      if etoBandHeaderWidth in Value then
        Include(NewOptionsEx, aoBandHeaderWidth)
      else Exclude(NewOptionsEx, aoBandHeaderWidth);
      if etoDrawEndEllipsis in Value then
        Include(NewOptions, aoDrawEndEllipsis)
      else Exclude(NewOptions, aoDrawEndEllipsis);
      if etoHideFocusRect in Value then
        Include(NewOptions, aoHideFocusRect)
      else Exclude(NewOptions, aoHideFocusRect);
      if etoHotTrack in Value then
        Include(NewOptionsEx, aoHotTrack)
      else
        Exclude(NewOptionsEx, aoHotTrack);
      ShowIndicator := etoIndicator in Value;
      if etoInvertSelect in Value then
      begin
        Include(NewOptionsEx, aoInvertSelect);
        Exclude(Value, etoRowSelect);
      end
      else Exclude(NewOptionsEx, aoInvertSelect);
      if etoPreview in Value then
        Include(NewOptions, aoPreview)
      else Exclude(NewOptions, aoPreview);
      if etoRowAutoHeight in Value then
        Include(NewOptionsEx, aoRowAutoHeight)
      else Exclude(NewOptionsEx, aoRowAutoHeight);
      if etoRowSelect in Value then
      begin
        Include(NewOptions, aoRowSelect);
        Exclude(NewOptionsEx, aoInvertSelect);
      end
      else Exclude(NewOptions, aoRowSelect);
      if etoShowButtonAlways  in Value then
        Include(NewOptionsEx, aoShowButtonAlways)
      else Exclude(NewOptionsEx, aoShowButtonAlways);
      if etoUseBitmap  in Value then
        Include(NewOptionsEx, aoUseBitmap)
      else Exclude(NewOptionsEx, aoUseBitmap);
      inherited Options := NewOptions;
      inherited OptionsEx := NewOptionsEx;
      FOptionsView := Value;
      if (etoUseImageIndexForSelected in OptionsView) <>
        (etoUseImageIndexForSelected in PrevOptions) then FullRefresh;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TCustomdxDBTreeList.SetParentFieldName(const Value: string);
begin
  if FParentFieldName <> Value then
  begin
    FParentFieldName := Value;
    LinkActive(DataLink.Active);
  end;
end;

procedure TCustomdxDBTreeList.SetRootValue(const Value: string);
begin
  if FRootValue <> Value then
  begin
    FRootValue := Value;
    LinkActive(DataLink.Active);
  end;
end;

procedure TCustomdxDBTreeList.SetSelectedIndex(Value: Integer);
begin
  if FSelectedIndex <> Value then
  begin
    FSelectedIndex := Value;
    LinkActive(DataLink.Active);
  end;
end;

procedure TCustomdxDBTreeList.SetStateIndexFieldName(const Value: string);
begin
  if FStateIndexFieldName <> Value then
  begin
    FStateIndexFieldName := Value;
    LinkActive(DataLink.Active);
  end;
end;

procedure TCustomdxDBTreeList.UpdateActive;
begin
  FInUpdateActive := True;
  try
    if FDatalink.Active and not (csLoading in ComponentState) and
      Datalink.DataSet.Active then
    begin
//      if not HandleAllocated and (Parent <> nil) then HandleNeeded; {WARNING}
      if not FRefreshTreeList then FindNodeById;
      if HandleAllocated then inherited UpdateScrollBars;
//      if Assigned(FocusedField) and (FocusedField.Text <> FEditValue) then
//        InvalidateEditor;
      InvalidateEditorValue;
    end;
  finally
    FInUpdateActive := False;
  end;
end;

end.
