
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

unit cxTLData;

{$I cxVer.inc}

interface
uses
  Classes, SysUtils,
  Windows, Messages,
  {$IFDEF DELPHI6} Variants, {$ENDIF} cxVariants, cxControls, cxClasses,
  cxData, cxCustomData, cxInplaceContainer, cxTL, cxTLIntf, cxTLStrs;

type
  TcxCustomDataTreeList = class;
  TcxTreeListDataNode = class;

  { TcxTreeListCustomDataSource }

  TcxTreeListCustomDataSource = class(TcxCustomDataSource)
  protected
    procedure DeleteNode(AParentHandle: TcxDataRecordHandle);
    procedure DeleteChildItems(AParentHandle: TcxDataRecordHandle); virtual;
    function GetChildCount(AParentHandle: TcxDataRecordHandle): Integer; virtual;
    function GetChildRecordHandle(AParentHandle: TcxDataRecordHandle;
      AChildIndex: Integer): TcxDataRecordHandle; virtual;
    function GetHandleFromNode(ANode: TcxTreeListDataNode): TcxDataRecordHandle;
    function GetKeyValue(ARecordHandle: TcxDataRecordHandle): Variant; virtual;
    function GetParentKeyValue(ARecordHandle: TcxDataRecordHandle): Variant; virtual;
    function GetRootRecordHandle: TcxDataRecordHandle; virtual;
    procedure NodeMoveTo(ARecordHandle, AttachRecordHandle: TcxDataRecordHandle;
      AttachMode: TcxTreeListNodeAttachMode; IsCopy: Boolean); virtual;
  end;

  { TcxVirtualTreeListDataController }

  TcxVirtualTreeListDataController = class(TcxControlDataController)
  private
    function GetCustomDataSource: TcxTreeListCustomDataSource;
    function GetRecordHandle(var ARecordHandle: TcxDataRecordHandle): Boolean;
    function GetTreeList: TcxCustomDataTreeList;
    procedure SetCustomDataSource(Value: TcxTreeListCustomDataSource);
  protected
    function GetKeyValue(ARecordIndex: Integer): Variant;
    function GetParentKeyValue(ARecordIndex: Integer): Variant;
    function IsSmartLoad: Boolean; override;
    procedure NodesMoveTo(AttachNode: TcxTreeListDataNode;
      AttachMode: TcxTreeListNodeAttachMode; ANodes: TList; IsCopy: Boolean);
  public
    property TreeList: TcxCustomDataTreeList read GetTreeList;
    property CustomDataSource: TcxTreeListCustomDataSource read GetCustomDataSource write SetCustomDataSource;
  end;

  { TcxTreeListDataNode }

  TcxTreeListDataNode = class(TcxTreeListNode)
  private
    FKeyValue: Variant;
    FParentValue: Variant;
  protected
    function AddDataControllerRecord: Integer; override;
    property RecordIndex;
  public
    function AddChild: TcxTreeListNode; override;
    function AddChildFirst: TcxTreeListNode; override;
    function InsertChild(ABeforeNode: TcxTreeListNode): TcxTreeListNode; override;
    property KeyValue: Variant read FKeyValue write FKeyValue;
    property ParentValue: Variant read FParentValue write FParentValue;
  end;

  { TcxDataTreeListStructureLoader }

  TcxDataTreeListStructureLoader = class
  private
    function GetDataController: TcxCustomDataController;
    function GetLoadedNode(Index: Integer): TcxTreeListDataNode;
    function GetRoot: TcxTreeListNode;
    procedure SetLoadedNode(Index: Integer; Value: TcxTreeListDataNode);
  protected
    InSmartLoadMode: Boolean;
    IsLoading: Boolean;
    IsLoadLoadingData: Boolean;
    LoadingNode: TcxTreeListDataNode;
    LoadedList: TList;
    ExpandedKeysList: TList;
    TreeList: TcxCustomDataTreeList;
    IsRefresh: Boolean; 
    // nodes handling procedures
    function Add: TcxTreeListDataNode;
    function AddChild(AParent: TcxTreeListNode): TcxTreeListDataNode;
    function AddNodeToList(ANode: TcxTreeListDataNode; ARecordIndex: Integer = -1): TcxTreeListDataNode; virtual;
    procedure AfterSmartLoad; virtual;
    procedure AssignNodeImages(ANode: TcxTreeListDataNode);
    procedure BeforeSmartLoad; virtual;
    function GetKeyValue(ARecordIndex: Integer): Variant; virtual;
    function GetNodeImageIndex(ARecordIndex: Integer): Integer; virtual;
    function GetNodeStateImage(ARecordIndex: Integer): Integer; virtual;
    function GetParentKeyValue(ARecordIndex: Integer): Variant; virtual;
    procedure InternalMove(ANode, ADestNode: TcxTreeListNode; AMode: TcxTreeListNodeAttachMode);
    function IsSmartLoad: Boolean;
    // loading procedures
    procedure CheckHasChildren(ANode: TcxTreeListDataNode); virtual;
    procedure DoneLoading; virtual;
    procedure InitLoading; virtual;
    procedure InitLoadedNode(ANode: TcxTreeListDataNode); virtual;
    function IsKeyExpanded(const AKeyValue: Variant; var ANode: TcxTreeListDataNode): Boolean;
    function IsNodeExpanded(const AKeyValue: Variant): Boolean;
    function FindParentNode(const AParentKeyValue: Variant; var Index: Integer): Boolean;
    procedure LoadChildItems(AParentNode: TcxTreeListDataNode); virtual; abstract;
    procedure LoadTreeList; virtual;
    procedure LoadTreeListInLoadAllRecordsMode; virtual;
    procedure LoadTreeListInSmartLoadMode; virtual; abstract;
    function LoadValues(const AParentValue, AKeyValue: Variant): TcxTreeListDataNode; overload;
    function LoadValues(AParentNode: TcxTreeListDataNode; const AParentValue, AKeyValue: Variant): TcxTreeListDataNode; overload;
    property DataController: TcxCustomDataController read GetDataController;
    property Loaded[Index: Integer]: TcxTreeListDataNode read GetLoadedNode write SetLoadedNode;
    property Root: TcxTreeListNode read GetRoot;
  public
    constructor Create(AOwner: TcxCustomDataTreeList);
    procedure DoLoadTreeList(ALoadingNode: TcxTreeListDataNode);
  end;

  TcxDataTreeListStructureLoaderClass = class of TcxDataTreeListStructureLoader;

  { TcxVirtualTreeListLoader }

  TcxVirtualTreeListLoader = class(TcxDataTreeListStructureLoader)
  private
    function GetDataController: TcxVirtualTreeListDataController;
    function GetDataSource: TcxTreeListCustomDataSource;
  protected
    procedure CheckHasChildren(ANode: TcxTreeListDataNode); override;
    function GetKeyValue(ARecordIndex: Integer): Variant; override;
    function GetParentKeyValue(ARecordIndex: Integer): Variant; override;
    procedure LoadChildItems(AParentNode: TcxTreeListDataNode); override;
    procedure LoadTreeListInSmartLoadMode; override;
    property DataController: TcxVirtualTreeListDataController read GetDataController;
    property DataSource: TcxTreeListCustomDataSource read GetDataSource;
  end;

  { TcxVirtualTreeListOptionsData }

  TcxVirtualTreeListOptionsData = class(TcxTreeListOptionsData)
  protected
    procedure SetSmartLoad(Index: Integer; Value: Boolean); virtual;
  published
    property SmartLoad: Boolean index 3 read GetState write SetSmartLoad default False;
  end;

  { TcxCustomDataTreeList }

  TcxCustomDataTreeList = class(TcxCustomTreeListControl)
  private
    FIsDataChanging: Boolean;
    function GetOptionsData: TcxVirtualTreeListOptionsData;
    procedure SetOptionsData(Value: TcxVirtualTreeListOptionsData);
  protected
    DragKeyValue: Variant;
    Loader: TcxDataTreeListStructureLoader;
    function CreateNode: TcxTreeListNode; override;
    procedure CreateSubClasses; override;
    procedure DataChanged; override;
    function DoCanNodeExpand(ANode: TcxTreeListNode): Boolean; override;
    procedure DoClear; override;
    procedure DoClearDataSource; virtual;
    procedure DoDataChanged; virtual;
    procedure DestroySubClasses; override;
    procedure DestroyNodes; virtual;
    function GetOptionsDataClass: TcxControlOptionsDataClass; override;
    function GetNodeByRecordIndex(AIndex: Integer): TcxTreeListDataNode;
    function IsDataChangedBusy: Boolean; virtual;
    function IsSmartLoad: Boolean; override;
    procedure RestoreSorting; override;
    function SkipFocusedRecordChanged: Boolean; override;
    function SkipCancelOperation: Boolean; override;
    // IcxTreeListDesignTimeOperations implementation
    function SupportsBandColumnEditor: Boolean; override;
    // nodes handling procedure
    function InsertNode(IsAppend: Boolean): Boolean; override;
    // loading structure procedures
    function GetLoaderClass: TcxDataTreeListStructureLoaderClass; virtual;
    function IsDataSettingsValid: Boolean; virtual; // for DB IsKeyFieldEmpty
    procedure LoadTreeList(ALoadingNode: TcxTreeListDataNode); virtual;
    procedure RecreateLoader;
    function UseRowIndexForNewRecord: Boolean; override;
    // dragdrop
    procedure SaveDragPos; override;
    procedure RestoreDragPos; override;

    property IsDataChanging: Boolean read FIsDataChanging write FIsDataChanging;
    property OptionsData: TcxVirtualTreeListOptionsData read GetOptionsData write SetOptionsData;
  public
    procedure FullRefresh; override;
    function FindNodeByKeyValue(const AKeyValue: Variant;
     AColumn: TcxTreeListColumn; AStartNode: TcxTreeListNode = nil;
     AExpandedOnly: Boolean = False; AForward: Boolean = True): TcxTreeListNode;
  end;

  { TcxCustomVirtualTreeList }

  TcxCustomVirtualTreeList = class(TcxCustomDataTreeList)
  private
    function GetDataController: TcxVirtualTreeListDataController;
    function GetDataSource: TcxTreeListCustomDataSource;
    procedure SetDataSource(Value: TcxTreeListCustomDataSource);
  protected
    procedure AddToDelitionList(ANode: TcxTreeListNode); override;
    procedure DoDeleteRecords; override; 
    procedure DoMoveTo(AttachNode: TcxTreeListNode;
      AttachMode: TcxTreeListNodeAttachMode; ANodes: TList; IsCopy: Boolean); override;
    function GetDataControllerClass: TcxCustomDataControllerClass; override;
    function GetLoaderClass: TcxDataTreeListStructureLoaderClass; override;
    function IsCancelOperation: Boolean; override;
    function IsDataSettingsValid: Boolean; override;
    property DataController: TcxVirtualTreeListDataController read GetDataController;
  public
    function HandleFromNode(ANode: TcxTreeListNode): TcxDataRecordHandle; virtual;
    function NodeFromHandle(ARecordHandle: TcxDataRecordHandle): TcxTreeListNode; virtual;
    property CustomDataSource: TcxTreeListCustomDataSource read GetDataSource write SetDataSource;
  end;

  { TcxVirtualTreeList }

  TcxVirtualTreeList = class(TcxCustomVirtualTreeList)
  public
    property ColumnCount;
    property Columns;
    property Customizing;
    property DataController;
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

const
  cxNullRecordHandle: TcxDataRecordHandle = TcxDataRecordHandle(-1);
  
implementation

type
  TcxEditContainerAccess = class(TcxCustomInplaceEditContainer);
  TcxNodeAccess = class(TcxTreeListNode);
  TcxNodesAccess = class(TcxTreeListNodes);
  TcxDataControllerAccess = class(TcxCustomDataController);

function cxCompareDataNodesByKeyValue(Item1, Item2: Pointer): Integer;
begin
  with TcxTreeListDataNode(Item1) do
  begin
    Result := VarCompare(KeyValue, TcxTreeListDataNode(Item2).KeyValue);
    if Result = 0 then
      Result := VarCompare(ParentValue, TcxTreeListDataNode(Item2).ParentValue);
  end;
end;

function cxKeyValues(Item1, Item2: Pointer): Integer;
begin
  Result := VarCompare(PVariant(Item1)^, PVariant(Item2)^);
end;

{ TcxTreeListCustomDataSource }

procedure TcxTreeListCustomDataSource.DeleteNode(
  AParentHandle: TcxDataRecordHandle);
begin
  DeleteChildItems(AParentHandle);
  DeleteRecord(AParentHandle);
end;

procedure TcxTreeListCustomDataSource.DeleteChildItems(
  AParentHandle: TcxDataRecordHandle);
var
  I: Integer;
  AItemHandle: TcxDataRecordHandle;
begin
  for I := GetChildCount(AParentHandle) - 1 downto 0 do
  begin
    AItemHandle := GetChildRecordHandle(AParentHandle, I);
    try
      DeleteChildItems(AItemHandle);
    finally
      DeleteRecord(AItemHandle);
    end;
  end;
end;

function TcxTreeListCustomDataSource.GetChildCount(
  AParentHandle: TcxDataRecordHandle): Integer;
begin
  Result := 0;
end;

function TcxTreeListCustomDataSource.GetChildRecordHandle(
  AParentHandle: TcxDataRecordHandle; AChildIndex: Integer): TcxDataRecordHandle;
begin
  Result := cxNullRecordHandle;
end;

function TcxTreeListCustomDataSource.GetHandleFromNode(
  ANode: TcxTreeListDataNode): TcxDataRecordHandle;
begin
  if ANode = nil then
    Result := GetRootRecordHandle
  else
    Result := GetRecordHandleByIndex(TcxNodeAccess(ANode).RecordIndex)
end;

function TcxTreeListCustomDataSource.GetKeyValue(ARecordHandle: TcxDataRecordHandle): Variant;
begin
  Result := Null;
end;

procedure TcxTreeListCustomDataSource.NodeMoveTo(
  ARecordHandle, AttachRecordHandle: TcxDataRecordHandle;
  AttachMode: TcxTreeListNodeAttachMode; IsCopy: Boolean);
begin
end;

function TcxTreeListCustomDataSource.GetParentKeyValue(
  ARecordHandle: TcxDataRecordHandle): Variant;
begin
  Result := Null;
end;

function TcxTreeListCustomDataSource.GetRootRecordHandle: TcxDataRecordHandle;
begin
  Result := cxNullRecordHandle;
end;

{ TcxVirtualTreeListDataController }

function TcxVirtualTreeListDataController.GetKeyValue(ARecordIndex: Integer): Variant;
begin
  if GetRecordHandle(TcxDataRecordHandle(ARecordIndex)) then
    Result := CustomDataSource.GetKeyValue(TcxDataRecordHandle(ARecordIndex))
  else
    Result := Null;
end;

function TcxVirtualTreeListDataController.GetParentKeyValue(ARecordIndex: Integer): Variant;
begin
  if GetRecordHandle(TcxDataRecordHandle(ARecordIndex)) then
    Result := CustomDataSource.GetParentKeyValue(TcxDataRecordHandle(ARecordIndex))
  else
    Result := Null;
end;

function TcxVirtualTreeListDataController.IsSmartLoad: Boolean;
begin
  Result := TreeList.OptionsData.SmartLoad and 
    (CustomDataSource <> nil) and (CustomDataSource.GetRecordCount = 0);
end;

procedure TcxVirtualTreeListDataController.NodesMoveTo(AttachNode: TcxTreeListDataNode;
  AttachMode: TcxTreeListNodeAttachMode; ANodes: TList; IsCopy: Boolean);

  function GetRecordIndex(Index: Integer): Integer;
  begin
    Result := TcxTreeListDataNode(ANodes.List^[Index]).RecordIndex;
  end;

var
  I: Integer;
  AMovedHandle, AttachHandle: TcxDataRecordHandle;
begin
  if CustomDataSource <> nil then
  begin
    BeginUpdate;
    try
      CustomDataSource.CurrentProvider := Provider;
      AttachHandle := CustomDataSource.GetRecordHandleByIndex(AttachNode.RecordIndex);
      for I := 0 to ANodes.Count - 1 do
      begin
        AMovedHandle := CustomDataSource.GetRecordHandleByIndex(GetRecordIndex(I));
        CustomDataSource.NodeMoveTo(AMovedHandle, AttachHandle, AttachMode, IsCopy);
      end;
      CustomDataSource.DataChanged;
    finally
      EndUpdate; 
    end;
  end;
end;

function TcxVirtualTreeListDataController.GetCustomDataSource: TcxTreeListCustomDataSource;
begin
  Result := TcxTreeListCustomDataSource(inherited CustomDataSource);
end;

function TcxVirtualTreeListDataController.GetRecordHandle(
  var ARecordHandle: TcxDataRecordHandle): Boolean;
begin
  Result := CustomDataSource <> nil;
  if Result then
  begin
    CustomDataSource.CurrentProvider := Provider;
    ARecordHandle := CustomDataSource.GetRecordHandleByIndex(Integer(ARecordHandle));
  end;
end;

function TcxVirtualTreeListDataController.GetTreeList: TcxCustomDataTreeList;
begin
  Result := TcxCustomDataTreeList(GetOwner);
end;

procedure TcxVirtualTreeListDataController.SetCustomDataSource(Value: TcxTreeListCustomDataSource);
begin
  inherited CustomDataSource := Value;
end;

{ TcxTreeListDataNode }

function TcxTreeListDataNode.AddChild: TcxTreeListNode;
begin
  raise EcxTreeList.Create(scxOperationNotSupported);
end;

function TcxTreeListDataNode.AddChildFirst: TcxTreeListNode;
begin
  raise EcxTreeList.Create(scxOperationNotSupported);
end;

function TcxTreeListDataNode.InsertChild(
  ABeforeNode: TcxTreeListNode): TcxTreeListNode;
begin
  raise EcxTreeList.Create(scxOperationNotSupported);
end;

function TcxTreeListDataNode.AddDataControllerRecord: Integer;
begin
  Result := inherited AddDataControllerRecord;
end;

{ TcxDataTreeListStructureLoader }

constructor TcxDataTreeListStructureLoader.Create(AOwner: TcxCustomDataTreeList);
begin
  TreeList := AOwner;
end;

procedure TcxDataTreeListStructureLoader.DoLoadTreeList(
  ALoadingNode: TcxTreeListDataNode);
begin
  if IsLoading or IsRefresh then
  begin
    IsRefresh := False;
    Exit;
  end;
  DataController.BeginUpdate;
  try
    if (ALoadingNode = nil) and IsSmartLoad and InSmartLoadMode then
    begin
      InSmartLoadMode := False;
      Exit;
    end;
    IsLoadLoadingData := not IsRefresh and IsSmartLoad and ((DataController.RecordCount <> 0) and (ALoadingNode = nil));
    IsLoading := True;
    LoadingNode := ALoadingNode;
    InitLoading;
    TcxNodesAccess(TreeList.Nodes).IsInternalCreating := True;
    try
      LoadTreeList;
    finally
      TreeList.SafeDelete := True;
      DoneLoading;
    end;
  finally
    TreeList.SafeDelete := False;
    TcxNodesAccess(TreeList.Nodes).IsInternalCreating := False;
    InSmartLoadMode := IsSmartLoad and not IsLoadLoadingData;
    IsLoadLoadingData := False;
    DataController.EndUpdate;
    InSmartLoadMode := False;
    IsLoading := False;
  end;
end;

function TcxDataTreeListStructureLoader.Add: TcxTreeListDataNode;
begin
  Result := TcxTreeListDataNode(TreeList.AddNode(nil, nil, nil, tlamAdd));
end;

function TcxDataTreeListStructureLoader.AddChild(
  AParent: TcxTreeListNode): TcxTreeListDataNode;
begin
  Result := TcxTreeListDataNode(TreeList.AddNode(nil, AParent, nil, tlamAddChild));
end;

function TcxDataTreeListStructureLoader.AddNodeToList(
  ANode: TcxTreeListDataNode; ARecordIndex: Integer = -1): TcxTreeListDataNode;
begin
  if ARecordIndex >= 0 then
  begin
    ANode.RecordIndex := ARecordIndex;
    AssignNodeImages(ANode);
  end;
  TreeList.NodesList.Add(ANode);
  Result := ANode;
end;

procedure TcxDataTreeListStructureLoader.InternalMove(
  ANode, ADestNode: TcxTreeListNode; AMode: TcxTreeListNodeAttachMode);
begin
  TreeList.InternalMove(ANode, ADestNode, AMode);
end;

function TcxDataTreeListStructureLoader.IsSmartLoad: Boolean;
begin
  Result := TcxDataControllerAccess(DataController).IsSmartLoad;
end;

procedure TcxDataTreeListStructureLoader.CheckHasChildren(
  ANode: TcxTreeListDataNode);
begin
end;

procedure TcxDataTreeListStructureLoader.DoneLoading;

  procedure DoExpandExpandedNodes;
  var
    PrevCount, I: Integer;
    ANode: TcxTreeListDataNode;
  begin
    repeat
      PrevCount := ExpandedKeysList.Count;
      for I := 0 to ExpandedKeysList.Count - 1 do
        if IsKeyExpanded(PVariant(ExpandedKeysList.List[I])^, ANode) then
        begin
          if (ANode.Count = 0) then LoadChildItems(ANode);
          Dispose(PVariant(ExpandedKeysList.List^[I]));
          ExpandedKeysList.Delete(I);
          ANode.Expanded := True;
          Break;
        end;
    until PrevCount = ExpandedKeysList.Count;
  end;

var
  I: Integer;
begin
  try
    if (ExpandedKeysList <> nil) and (ExpandedKeysList.Count > 0) then
    begin
      LoadedList.Sort(cxCompareDataNodesByKeyValue);
      DoExpandExpandedNodes;
    end;
  finally
    if ExpandedKeysList <> nil then
    begin
      for I := 0 to ExpandedKeysList.Count - 1 do
        Dispose(PVariant(ExpandedKeysList.List^[I]));
      FreeAndNil(ExpandedKeysList);
    end;
    FreeAndNil(LoadedList);
    if IsSmartLoad then AfterSmartLoad;
  end;
end;

procedure TcxDataTreeListStructureLoader.InitLoading;
var
  I: Integer;
  AKeyPtr: PVariant;
begin
  if IsSmartLoad then
    BeforeSmartLoad;
  if LoadingNode = nil then
  try
    TreeList.ViewInfo.NodesViewInfo.Clear;
    ExpandedKeysList := TList.Create;
    LoadedList := TList.Create;
    if DataController.RecordCount > 0 then
      LoadedList.Capacity := DataController.RecordCount;
    if TreeList.NodesList.Count > 0 then
    begin
      ExpandedKeysList.Capacity := TreeList.NodesList.Count;
      for I := 0 to TreeList.NodesList.Count - 1 do
        with TcxTreeListDataNode(TreeList.NodesList.List^[I]) do
        begin
          if Expanded then
          begin
            New(AKeyPtr);
            AKeyPtr^ := KeyValue;
            ExpandedKeysList.Add(AKeyPtr);
          end;
        end;
      ExpandedKeysList.Sort(cxKeyValues);
    end;
  finally 
    TreeList.DestroyNodes; 
  end;
end;

procedure TcxDataTreeListStructureLoader.InitLoadedNode(ANode: TcxTreeListDataNode); 
begin
end;

function TcxDataTreeListStructureLoader.IsKeyExpanded(
  const AKeyValue: Variant; var ANode: TcxTreeListDataNode): Boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;
  if (LoadedList = nil) or (LoadedList.Count = 0) then Exit;
  L := 0;
  H := LoadedList.Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    ANode := TcxTreeListDataNode(LoadedList.List^[I]);
    C := VarCompare(ANode.KeyValue, AKeyValue);
    Result := C = 0;
    if not Result then
    begin
      if C < 0 then
        L := I + 1
      else
        H := I - 1;
    end
    else
      Break;
  end;
end;

function TcxDataTreeListStructureLoader.IsNodeExpanded(
  const AKeyValue: Variant): Boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;
  if (ExpandedKeysList = nil) or (ExpandedKeysList.Count = 0) then Exit; 
  L := 0;
  H := ExpandedKeysList.Count - 1;
  while (L <= H) and not Result do
  begin
    I := (L + H) shr 1;
    C := VarCompare(PVariant(ExpandedKeysList.List^[I])^, AKeyValue);
    if C = 0 then
      Result := True
    else
      if C < 0 then
        L := I + 1
      else
        H := I - 1;
  end;
end;

function TcxDataTreeListStructureLoader.FindParentNode(
  const AParentKeyValue: Variant; var Index: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;
  L := 0;
  H := LoadedList.Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := VarCompare(TcxTreeListDataNode(LoadedList.List^[I]).KeyValue, AParentKeyValue);
    if C < 0 then
      L := I + 1
    else
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

procedure TcxDataTreeListStructureLoader.AfterSmartLoad;
begin
  if not IsLoadLoadingData then
    TcxDataControllerAccess(DataController).EndSmartLoad;
end;

procedure TcxDataTreeListStructureLoader.AssignNodeImages(
  ANode: TcxTreeListDataNode);
begin
  with ANode do
  begin
    if RecordIndex >= 0 then
    begin
      FImageIndexes[tlitImageIndex] := GetNodeImageIndex(RecordIndex);
      FImageIndexes[tlitStateIndex] := GetNodeStateImage(RecordIndex);
    end;
  end;
end;

procedure TcxDataTreeListStructureLoader.BeforeSmartLoad;
begin
  if not IsLoadLoadingData then
    TcxDataControllerAccess(DataController).BeginSmartLoad;
end;

function TcxDataTreeListStructureLoader.GetKeyValue(
  ARecordIndex: Integer): Variant;
begin
  Result := Null;
end;

function TcxDataTreeListStructureLoader.GetNodeImageIndex(
  ARecordIndex: Integer): Integer;
begin
  Result := -1;
end;

function TcxDataTreeListStructureLoader.GetNodeStateImage(
  ARecordIndex: Integer): Integer;
begin
  Result := -1;
end;

function TcxDataTreeListStructureLoader.GetParentKeyValue(
  ARecordIndex: Integer): Variant;
begin
  Result := -1;
end;

procedure TcxDataTreeListStructureLoader.LoadTreeListInLoadAllRecordsMode;
var
  I, Index: Integer;
  ANode, APrevNode, ADestNode: TcxTreeListDataNode;
begin
  with DataController do
  begin
    for I := 0 to RecordCount - 1 do
    begin
      ANode := LoadValues(GetParentKeyValue(I), GetKeyValue(I));
      ANode.RecordIndex := I;
      AssignNodeImages(ANode);
      CheckHasChildren(ANode);
    end;
    ANode := TcxTreeListDataNode(TreeList.Nodes.Root.GetLastChild);
    while ANode <> nil do
    begin
      APrevNode := TcxTreeListDataNode(ANode.GetPrevSibling);
      if FindParentNode(ANode.FParentValue, Index) then
      begin
        ADestNode := Self.Loaded[Index];
        if ANode.CanMove(ADestNode, tlamAddChild) then
          TreeList.InternalMove(ANode, ADestNode, tlamAddChild);
      end;
      ANode := APrevNode;
    end;
  end;
end;

procedure TcxDataTreeListStructureLoader.LoadTreeList;
begin
  if IsSmartLoad and ((LoadingNode <> nil) or not IsLoadLoadingData) then
    LoadTreeListInSmartLoadMode
  else
    LoadTreeListInLoadAllRecordsMode;
end;

function TcxDataTreeListStructureLoader.LoadValues(
  const AParentValue, AKeyValue: Variant): TcxTreeListDataNode;

  function GetParent: TcxTreeListDataNode;
  var
    AIndex: Integer;
  begin
    Result := nil;
    if FindParentNode(AParentValue, AIndex) then
      Result := TcxTreeListDataNode(LoadedList.List^[AIndex]);
  end;

begin
  Result := LoadValues(GetParent, AParentValue, AKeyValue);
  if Result.RecordIndex >= 0 then
    AssignNodeImages(Result);
end;

function TcxDataTreeListStructureLoader.LoadValues(AParentNode: TcxTreeListDataNode;
  const AParentValue, AKeyValue: Variant): TcxTreeListDataNode;
var
  AIndex: Integer;
begin
  Result := AddChild(AParentNode);
  AddNodeToList(Result);
  Result.FKeyValue := AKeyValue;
  Result.FParentValue := AParentValue;
  InitLoadedNode(Result);
  if (LoadedList <> nil) and not FindParentNode(AKeyValue, AIndex) then
     LoadedList.Insert(AIndex, Result);
  AssignNodeImages(Result);
end;

function TcxDataTreeListStructureLoader.GetDataController: TcxCustomDataController;
begin
  Result := TreeList.DataController;
end;

function TcxDataTreeListStructureLoader.GetLoadedNode(
  Index: Integer): TcxTreeListDataNode;
begin
  Result := TcxTreeListDataNode(LoadedList.List^[Index]);
end;

function TcxDataTreeListStructureLoader.GetRoot: TcxTreeListNode;
begin
  Result := TreeList.Nodes.Root;
end;

procedure TcxDataTreeListStructureLoader.SetLoadedNode(
  Index: Integer; Value: TcxTreeListDataNode);
begin
  LoadedList.List^[Index] := Value;
end;

{ TcxVirtualTreeListLoader }

procedure TcxVirtualTreeListLoader.CheckHasChildren(ANode: TcxTreeListDataNode);
begin
  if IsSmartLoad and (ANode.Count = 0) then
  begin
    with DataSource, ANode do
       HasChildren := GetChildCount(GetRecordHandleByIndex(RecordIndex)) <> 0;
  end; 
end;

function TcxVirtualTreeListLoader.GetKeyValue(
  ARecordIndex: Integer): Variant;
begin
  Result := DataController.GetKeyValue(ARecordIndex);
end;

function TcxVirtualTreeListLoader.GetParentKeyValue(
  ARecordIndex: Integer): Variant;
begin
  Result := DataController.GetParentKeyValue(ARecordIndex);
end;

procedure TcxVirtualTreeListLoader.LoadChildItems(
  AParentNode: TcxTreeListDataNode);
var
  I: Integer;
  AParentValue: Variant;
  AParentHandle: TcxDataRecordHandle;

  procedure AddNewNode(AHandle: TcxDataRecordHandle);
  var
    ANode: TcxTreeListDataNode;
  begin
    ANode := AddNodeToList(AddChild(AParentNode), DataController.LoadRecord(AHandle));
    ANode.ParentValue := AParentValue;
    ANode.KeyValue := DataSource.GetKeyValue(AHandle);
    ANode.HasChildren := DataSource.GetChildCount(AHandle) > 0;
    if IsNodeExpanded(ANode.KeyValue) then
    begin
      LoadChildItems(ANode);
      ANode.Expanded := True; 
    end;
  end;

begin
  with DataSource do
  begin
    AParentHandle := GetHandleFromNode(AParentNode);
    AParentValue := GetKeyValue(AParentHandle);
    for I := 0 to GetChildCount(AParentHandle) - 1 do
      AddNewNode(GetChildRecordHandle(AParentHandle, I));
  end;
end;

procedure TcxVirtualTreeListLoader.LoadTreeListInSmartLoadMode;
begin
  LoadChildItems(LoadingNode);
end;

function TcxVirtualTreeListLoader.GetDataController: TcxVirtualTreeListDataController;
begin
  Result := TcxVirtualTreeListDataController(inherited DataController);
end;

function TcxVirtualTreeListLoader.GetDataSource: TcxTreeListCustomDataSource;
begin
  Result := TcxCustomVirtualTreeList(TreeList).CustomDataSource;
end;

{ TcxVirtualTreeListOptionsData }

procedure TcxVirtualTreeListOptionsData.SetSmartLoad(
  Index: Integer; Value: Boolean);
begin
  if SmartLoad <> Value then
  begin
    SetState(Index, Value);
    with TcxCustomDataTreeList(GetOwner) do
    begin
      if DataController <> nil then
        TcxDataControllerAccess(DataController).RestructData;
    end;
  end;
end;

{ TcxCustomDataTreeList }

function TcxCustomDataTreeList.CreateNode: TcxTreeListNode;
begin
  Result := TcxTreeListDataNode.Create(Nodes);
end;

procedure TcxCustomDataTreeList.CreateSubClasses;
begin
  RecreateLoader;
  inherited CreateSubClasses;
end;

procedure TcxCustomDataTreeList.DataChanged;

   function SkipDataChangedNotification: Boolean;
   begin
     Result := IsLoading or IsDestroying;
     with Loader do
       Result := Result or (IsLoading and InSmartLoadMode)
   end;

begin
  FIsDataChanging := True;
  try
    if not SkipDataChangedNotification then
      DoDataChanged
    else
      Loader.InSmartLoadMode := False;
  finally
     FIsDataChanging := False; 
  end;
end;

function TcxCustomDataTreeList.DoCanNodeExpand(
  ANode: TcxTreeListNode): Boolean;
begin
  Result := inherited DoCanNodeExpand(ANode);
  if Result and IsSmartLoad and (ANode.Count = 0) and not Loader.IsLoading then
  begin
    LoadTreeList(TcxTreeListDataNode(ANode));
    ANode.HasChildren := ANode.Count > 0;
    Result := ANode.HasChildren;
  end;
end;

procedure TcxCustomDataTreeList.DoClear;
begin
  DoClearDataSource;
  inherited DoClear;
end;

procedure TcxCustomDataTreeList.DoClearDataSource;
begin
  DataController.CustomDataSource := nil;
end;

procedure TcxCustomDataTreeList.DoDataChanged;
begin
  FIsDataChanging := True; 
  try
    if not IsDataSettingsValid then
      DestroyNodes
    else
    begin
      LoadTreeList(nil);
      inherited DataChanged;
    end;
  finally
    LayoutChanged;
  end;
end;

procedure TcxCustomDataTreeList.DestroySubClasses;
begin
  inherited DestroySubClasses;
  FreeAndNil(Loader);
end;

procedure TcxCustomDataTreeList.DestroyNodes;
var
  ATopIndex: Integer;
begin
  SafeDelete := True;
  ATopIndex := TcxNodesAccess(Nodes).TopIndex;
  try
    Nodes.Clear;
    DeletedNodes.Clear;
  finally
    NodesList.Clear;
    TcxNodesAccess(Nodes).TopIndex := ATopIndex;
    SafeDelete := False;
  end; 
end;

function TcxCustomDataTreeList.GetOptionsDataClass: TcxControlOptionsDataClass;
begin
  Result := TcxVirtualTreeListOptionsData;
end;

function TcxCustomDataTreeList.GetNodeByRecordIndex(
  AIndex: Integer): TcxTreeListDataNode;
begin
  if cxInRange(AIndex, 0, NodesList.Count - 1) then
    Result := TcxTreeListDataNode(NodesList.List[AIndex])
  else
    Result := nil;
end;

function TcxCustomDataTreeList.SkipFocusedRecordChanged: Boolean;
begin
  Result := IsDataChangedBusy;
end;

function TcxCustomDataTreeList.SkipCancelOperation: Boolean;
begin
  Result := IsDataChangedBusy;
end;

function TcxCustomDataTreeList.IsDataChangedBusy: Boolean; 
begin
  Result := Loader.IsLoading or FIsDataChanging;
end;

procedure TcxCustomDataTreeList.RestoreSorting;
var
  C, I: Integer;
  FIsExpanded: PByteArray;
  ATopIndex: Integer;
const
  AExpandedState = tlnsCollapsed{ or tlnsHasChildren};
begin
  C := Nodes.Count;
  GetMem(FIsExpanded, C);
  ATopIndex := TcxNodesAccess(Nodes).TopIndex;
  try
    BeginUpdate;
    try
      for I := 0 to Nodes.Count - 1 do
        FIsExpanded^[I] := Byte(Nodes.Items[I].Expanded);
      DestroyNodes;
    finally
      try
        DataChanged;
        if C > Nodes.Count then
          C := Nodes.Count;
        // restore expanding
        for I := 0 to C - 1 do
        begin
          with TcxNodeAccess(NodesList.List^[I]) do
          begin
            if Boolean(FIsExpanded^[I]) then
              State := State and not AExpandedState
            else
              State := State or AExpandedState
          end;
        end;
      finally
        TcxNodesAccess(Nodes).TopIndex := ATopIndex;
        EndUpdate;
        if FocusedNode <> nil then FocusedNode.MakeVisible;
      end;
    end;
  finally
    FreeMem(FIsExpanded);
  end;
end;

function TcxCustomDataTreeList.SupportsBandColumnEditor: Boolean;
begin
  Result := True;
end;

function TcxCustomDataTreeList.InsertNode(IsAppend: Boolean): Boolean;
begin
  if IsAppend then
    DataController.Append
  else
    DataController.Insert;
  Result := True;
end;

function TcxCustomDataTreeList.GetLoaderClass: TcxDataTreeListStructureLoaderClass;
begin
  Result := TcxDataTreeListStructureLoader;
end;

function TcxCustomDataTreeList.IsDataSettingsValid: Boolean;
begin
  Result := (DataController.RecordCount > 0) or IsSmartLoad;
end;

function TcxCustomDataTreeList.IsSmartLoad: Boolean;
begin
  Result := TcxDataControllerAccess(DataController).IsSmartLoad; 
end;

procedure TcxCustomDataTreeList.LoadTreeList(ALoadingNode: TcxTreeListDataNode);
begin
  SetGlassCursor;
  try
    Freeze;
    try
      NodesList.Pack;
      if not IsDataSettingsValid then
        DestroyNodes
      else
        Loader.DoLoadTreeList(ALoadingNode);
    finally
      if ALoadingNode = nil then RestoreCursor;
      UnFreeze;
      if not IsLocked and (FocusedNode <> nil) and (ALoadingNode = nil) then
        FocusedNode.MakeVisible;
      LayoutChanged;
    end;
  except
    RestoreCursor;
    raise;
  end;
end;

procedure TcxCustomDataTreeList.FullRefresh;
begin
  BeginUpdate;
  try
    DestroyNodes;
    DataController.RecordCount := 0;
    LoadTreeList(nil);
  finally
    Loader.IsRefresh := True;
    EndUpdate;
    Loader.IsRefresh := False;
    DataController.UpdateItems(False);
  end;
end;

type
  PcxFindInfo = ^TcxFindInfo;
  TcxFindInfo = packed record
    Column: TcxTreeListColumn;
    Value: Variant;
  end;

function FindKeyFilter(ANode: TcxTreeListDataNode; AFindInfo: PcxFindInfo): Boolean;
begin
  if AFindInfo^.Column = nil then
    Result := VarCompare(ANode.FKeyValue, AFindInfo.Value) = 0
  else
    Result := VarCompare(ANode.Values[AFindInfo^.Column.ItemIndex], AFindInfo.Value) = 0;
end;

function TcxCustomDataTreeList.FindNodeByKeyValue(const AKeyValue: Variant;
  AColumn: TcxTreeListColumn; AStartNode: TcxTreeListNode = nil;
  AExpandedOnly: Boolean = False; AForward: Boolean = True): TcxTreeListNode;
var
  AInfo: TcxFindInfo;
begin
  AInfo.Column := AColumn;
  AInfo.Value := AKeyValue;
  Result := Find(@AInfo, AStartNode, AExpandedOnly,
    AForward, TcxTreeListFindFunc(@FindKeyFilter));
end;

procedure TcxCustomDataTreeList.RecreateLoader;
begin
  try
    FreeAndNil(Loader);
  finally
    Loader := GetLoaderClass.Create(Self);
  end;
end;

function TcxCustomDataTreeList.UseRowIndexForNewRecord: Boolean;
begin
  Result := False; 
end;

procedure TcxCustomDataTreeList.SaveDragPos;
begin
  if DragNode <> nil then
    DragKeyValue := TcxTreeListDataNode(DragNode).KeyValue
  else
    DragKeyValue := Null;
end;

procedure TcxCustomDataTreeList.RestoreDragPos;
var
  I: Integer;
begin
  if not VarIsNull(DragKeyValue) then
  begin
    for I := 0 to NodesList.Count - 1 do
      with TcxTreeListDataNode(NodesList.List^[I]) do
        if VarEquals(DragKeyValue, KeyValue) then
        begin
          Focused := True;
          MakeVisible;
          Exit;
        end;
  end; 
end;

function TcxCustomDataTreeList.GetOptionsData: TcxVirtualTreeListOptionsData;
begin
  Result := TcxVirtualTreeListOptionsData(inherited OptionsData);
end;

procedure TcxCustomDataTreeList.SetOptionsData(
  Value: TcxVirtualTreeListOptionsData);
begin
  OptionsData.Assign(Value);
end;

{ TcxCustomVirtualTreeList }

function TcxCustomVirtualTreeList.HandleFromNode(
  ANode: TcxTreeListNode): TcxDataRecordHandle;
begin
  Result := CustomDataSource.GetHandleFromNode(TcxTreeListDataNode(ANode));
end;

function TcxCustomVirtualTreeList.NodeFromHandle(
  ARecordHandle: TcxDataRecordHandle): TcxTreeListNode;
begin
  with CustomDataSource do
    Result := GetNodeByRecordIndex(GetRecordIndexByHandle(ARecordHandle));
end;

procedure TcxCustomVirtualTreeList.AddToDelitionList(ANode: TcxTreeListNode);
begin
  if not IsSmartLoad or not ANode.Deleting then
    DeletedNodes.Add(Pointer(TcxNodeAccess(ANode).RecordIndex));
end;

procedure TcxCustomVirtualTreeList.DoDeleteRecords;
var
  I: Integer; 
begin
  if IsSmartLoad then
  begin
    DataController.BeginUpdate;
    with DeletedNodes do
    try
      for I := 0 to DeletedNodes.Count - 1 do
        List^[I] := CustomDataSource.GetRecordHandleByIndex(Integer(List^[I]));
      for I := 0 to DeletedNodes.Count - 1 do
        CustomDataSource.DeleteNode(List^[I]);
    finally
      Clear;
      DataController.EndUpdate;
    end;
  end
  else
    inherited DoDeleteRecords;
end;

procedure TcxCustomVirtualTreeList.DoMoveTo(AttachNode: TcxTreeListNode;
  AttachMode: TcxTreeListNodeAttachMode; ANodes: TList; IsCopy: Boolean);
begin
  if IsSmartLoad and (AttachMode = tlamAddChild) and (AttachNode <> nil) then
    Loader.DoLoadTreeList(TcxTreeListDataNode(AttachNode));
  DataController.NodesMoveTo(
    TcxTreeListDataNode(AttachNode), AttachMode, ANodes, IsCopy);
end;

function TcxCustomVirtualTreeList.GetDataControllerClass: TcxCustomDataControllerClass;
begin
  Result := TcxVirtualTreeListDataController;
end;

function TcxCustomVirtualTreeList.GetLoaderClass: TcxDataTreeListStructureLoaderClass;
begin
  Result := TcxVirtualTreeListLoader;  
end;

function TcxCustomVirtualTreeList.IsCancelOperation: Boolean;
begin
  if Loader.IsLoading then
    Result := False
  else
    Result := inherited IsCancelOperation;
end;

function TcxCustomVirtualTreeList.IsDataSettingsValid: Boolean;
begin
  with DataController do
    Result := (CustomDataSource <> nil) and inherited IsDataSettingsValid;
end;

function TcxCustomVirtualTreeList.GetDataController: TcxVirtualTreeListDataController;
begin
  Result := TcxVirtualTreeListDataController(inherited DataController);
end;

function TcxCustomVirtualTreeList.GetDataSource: TcxTreeListCustomDataSource;
begin
  Result := DataController.CustomDataSource;
  if Result <> nil then
    Result.CurrentProvider := DataController.Provider;
end;

procedure TcxCustomVirtualTreeList.SetDataSource(
  Value: TcxTreeListCustomDataSource);
begin
  DataController.CustomDataSource := Value;
end;

end.
