
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

unit cxDBTL;

{$I cxVer.inc}

interface

uses
  SysUtils, Classes, {$IFDEF DELPHI6} Variants, {$ENDIF} cxVariants, DB, cxEdit,
  cxDBEdit, cxControls, cxClasses, cxDataStorage, cxCustomData, cxDBData, cxDataUtils,
  cxInplaceContainer, cxEditDBRegisteredRepositoryItems, cxTL, cxTLData, cxTLIntf;

type
  TcxCustomDBTreeList = class;

  { TcxDBTreeListDataController }

  TcxDBTreeListDataController = class(TcxDBDataController, IcxTreeListSubClass)
  private
    FImageIndexField: TcxDBDataField;
    FImageIndexFieldName: string;
    FParentKeyField: TcxDBDataField;
    FParentKeyFieldNames: string;
    FStateIndexField: TcxDBDataField;
    FStateIndexFieldName: string;
    function GetKeyField: string;
    function GetKeyFieldField: TField;
    function GetParentFieldField: TField;
    function GetTreeList: TcxCustomDBTreeList;
    procedure SetImageIndexFieldName(const Value: string);
    procedure SetKeyField(const Value: string);
    procedure SetParentKeyFieldNames(const Value: string);
    procedure SetStateIndexFieldName(const Value: string);
  protected
    procedure DataScrolled(ADistance: Integer); override;
    procedure DoCopyTo(AttachNode: TcxTreeListDataNode;
      AttachMode: TcxTreeListNodeAttachMode; ANodes: TList);
    procedure DoInitInsertingRecord(AInsertingRecordIndex: Integer); override;
    function GetControl: TObject;
    function GetIsKeyFieldEmpty: Boolean;
    function GetItemID(AItem: TObject): Integer; override;
    function GetKeyValue(ARecordIndex: Integer): Variant;
    function GetParentKeyValue(ARecordIndex: Integer): Variant;
    function GetUniqueKeyValue(Delta: Integer = 0): Variant;
    function IsSmartLoad: Boolean; override;
    procedure SetKeyFieldValue(ANode: TcxTreeListDataNode; Value: Variant);
    procedure SetNodeParentValue(ANode: TcxTreeListDataNode; const Value: Variant);
    procedure UpdateControl(AInfo: TcxUpdateControlInfo); override;
    property IsKeyFieldEmpty: Boolean read GetIsKeyFieldEmpty;
    property KeyFieldField: TField read GetKeyFieldField;
    property ParentFieldField: TField read GetParentFieldField;
  public
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure CreateAllItems; virtual;
    procedure FocusControl(AItemIndex: Integer; var Done: Boolean); override;
    function GetItem(Index: Integer): TObject; override;
    function GetItemValueSource(AItemIndex: Integer): TcxDataEditValueSource; override;
    procedure UpdateData; override;
    procedure UpdateItemIndexes; override;
    property TreeList: TcxCustomDBTreeList read GetTreeList;
  published
    property DataSource;
    property ImageIndexFieldName: string read FImageIndexFieldName write SetImageIndexFieldName;
    property ParentField: string read FParentKeyFieldNames write SetParentKeyFieldNames;
    property KeyField: string read GetKeyField write SetKeyField;
    property StateIndexFieldName: string read FStateIndexFieldName write SetStateIndexFieldName;
  end;

  { TcxDBTreeListDefaultValuesProvider }

  TcxDBTreeListDefaultValuesProvider = class(TcxCustomDBEditDefaultValuesProvider)
  public
    function IsDisplayFormatDefined(AIsCurrencyValueAccepted: Boolean): Boolean; override;
  end;

  { TcxDBItemDataBinding }

  TcxDBItemDataBinding = class(TcxCustomItemDataBinding, IUnknown, IcxTreeListSubClass)
  private
    function GetDataController: TcxDBTreeListDataController;
    function GetField: TField;
    function GetFieldName: string;
    procedure SetFieldName(const AName: string);
  protected
    function DefaultRepositoryItem: TcxEditRepositoryItem; override;
    function GetControl: TObject;
    function GetDefaultCaption: string; override;
    function GetDefaultValuesProviderClass: TcxCustomEditDefaultValuesProviderClass; override;
    function GetValueTypeClass: TcxValueTypeClass; override;
    procedure Init; override;
    procedure ValueTypeClassChanged; override;
    // IUnknown
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    function QueryInterface(const IID: TGUID; out Obj): HResult; virtual; stdcall;
  public
    procedure Assign(Source: TPersistent); override;
    property DataController: TcxDBTreeListDataController read GetDataController;
    property Field: TField read GetField;
  published
    property FieldName: string read GetFieldName write SetFieldName;
  end;

  { TcxDBTreeListColumnSummaryFooter }

  TcxDBTreeListColumnSummaryFooter = class(TcxTreeListColumnSummaryFooter, IcxTreeListSubClass)
  private
    function GetDataController: TcxDBTreeListDataController;
    function GetFieldName: string;
    function GetSummaryItem: TcxDBDataSummaryItem;
    procedure SetFeldName(const Value: string);
    function IsFieldNameStored: Boolean;
  protected
    function GetControl: TObject;
  public
    procedure Assign(Source: TPersistent); override;
    property SummaryItem: TcxDBDataSummaryItem read GetSummaryItem;
    property DataController: TcxDBTreeListDataController read GetDataController;
  published
    property FieldName: string read GetFieldName write SetFeldName stored IsFieldNameStored;
  end;

  { TcxDBTreeListColumn }

  TcxDBTreeListColumn = class(TcxTreeListColumn)
  private
    function GetDataBinding: TcxDBItemDataBinding;
    function GetSummaryFooter: TcxDBTreeListColumnSummaryFooter;
    procedure SetDataBinding(Value: TcxDBItemDataBinding);
    procedure SetSummaryFooter(Value: TcxDBTreeListColumnSummaryFooter);
  protected
    function GetDataBindingClass: TcxItemDataBindingClass; override;
    function GetSummaryFooterClass: TcxTreeListColumnSummaryFooterClass; override;
  published
    property DataBinding: TcxDBItemDataBinding read GetDataBinding write SetDataBinding;
    property SummaryFooter: TcxDBTreeListColumnSummaryFooter read GetSummaryFooter write SetSummaryFooter;
  end;

  { TcxDBTreeListOptionsData }

  TcxDBTreeListOptionsData = class(TcxVirtualTreeListOptionsData)
  private
    function GetDataController: TcxDBTreeListDataController;
    function GetSmartRefresh: Boolean;
    function GetSyncMode: Boolean;
    procedure SetSmartRefresh(Value: Boolean);
    procedure SetSyncMode(Value: Boolean);
  protected
    procedure SetSmartLoad(Index: Integer; Value: Boolean); override;
    property DataController: TcxDBTreeListDataController read GetDataController;
  public
    constructor Create(AOwner: TPersistent); override;
    procedure Assign(Source: TPersistent); override;
  published
    property AutoCalcKeyValue: Boolean index 2 read GetState write SetState default False;
    property CheckHasChildren: Boolean index 4 read GetState write SetState default True;
    property SmartRefresh: Boolean read GetSmartRefresh write SetSmartRefresh default False;
    property SyncMode: Boolean read GetSyncMode write SetSyncMode default True;
    property SmartLoad;
  end;

  { TcxDBTreeListLoader }

  TcxDBTreeListLoader = class(TcxDataTreeListStructureLoader)
  private
    FValueDefReader: TcxValueDefReader;
    function GetDataController: TcxDBTreeListDataController;
    function GetDataSet: TDataSet;
    function GetDBTreeList: TcxCustomDBTreeList;
    function GetKeyField: TField;
    function GetKeyFieldName: string;
    function GetParentField: TField;
    function GetParentFieldName: string;
  protected
    FHasChildrenNodes: TList;
    procedure AfterSmartLoad; override;
    procedure BeforeSmartLoad; override;
    procedure DoneLoading; override;
    function GetImageIndexAsInteger(const AIndex: Integer; AField: TcxDBDataField): Integer;
    function GetKeyValue(ARecordIndex: Integer): Variant; override;
    function GetNodeImageIndex(ARecordIndex: Integer): Integer; override;
    function GetNodeStateImage(ARecordIndex: Integer): Integer; override;
    function GetParentKeyValue(ARecordIndex: Integer): Variant; override;
    procedure InitLoadedNode(ANode: TcxTreeListDataNode); override;
    procedure InitLoading; override;
    function IsExistChildren(ANode: TcxTreeListDataNode): Boolean;
    function IsExistKeyRoot(AParentValue: Variant): Boolean; virtual;
    procedure LoadChildItems(ANode: TcxTreeListDataNode); override;
    procedure LoadLevel(ANode: TcxTreeListDataNode; const AParentValue: Variant; ANewNodes: TList);
    procedure LoadLevelBack(AParentValue: Variant);
    procedure LoadTreeListInSmartLoadMode; override;
    function NeedCheckChildren: Boolean;
    property DataController: TcxDBTreeListDataController read GetDataController;
    property DataSet: TDataSet read GetDataSet;
    property DBTreeList: TcxCustomDBTreeList read GetDBTreeList;
    property KeyField: TField read GetKeyField;
    property KeyFieldName: string read GetKeyFieldName;
    property ParentField: TField read GetParentField;
    property ParentFieldName: string read GetParentFieldName;
    property ValueDefReader: TcxValueDefReader read FValueDefReader;
  end;

  { TcxCustomDBTreeList }

  TcxDBTreeListGetUniqueKeyValueEvent = procedure(Sender: TObject; var KeyValue: Variant) of object;
  TcxDBTreeListInitInsertingRecordEvent = procedure(Sender: TObject; AFocusedNode: TcxTreeListDataNode; var AHandled: Boolean) of object;

  TcxCustomDBTreeList = class(TcxCustomDataTreeList)
  private
    FRootValue: Variant;
    FOnGetUniqueKeyValue: TcxDBTreeListGetUniqueKeyValueEvent;
    FOnInitInsertingRecord: TcxDBTreeListInitInsertingRecordEvent;
    function GetColumn(Index: Integer): TcxDBTreeListColumn;
    function GetDataController: TcxDBTreeListDataController;
    function GetDataSet: TDataSet;
    function GetOptionsData: TcxDBTreeListOptionsData;
    function GetVisibleColumn(Index: Integer): TcxDBTreeListColumn;
    procedure SetColumn(Index: Integer; Value: TcxDBTreeListColumn);
    procedure SetDataController(Value: TcxDBTreeListDataController);
    procedure SetOptionsData(Value: TcxDBTreeListOptionsData);
    procedure SetRootValue(const Value: Variant);
    procedure SetVisibleColumn(Index: Integer; Value: TcxDBTreeListColumn);
  protected
    procedure CreateAllItems; override;
    procedure AddToDelitionList(ANode: TcxTreeListNode); override;
    procedure DoClearDataSource; override;
    procedure DoDeleteNode(ANode: TcxTreeListNode);  override;
    procedure DoDeleteNodeEntry(ANode: TcxTreeListDataNode); virtual;
    function DoExecuteInitInsertingRecord(ANode: TcxTreeListDataNode): Boolean; virtual;
    procedure DoMoveTo(AttachNode: TcxTreeListNode;
      AttachMode: TcxTreeListNodeAttachMode; ANodes: TList; IsCopy: Boolean); override;
    function GetDataControllerClass: TcxCustomDataControllerClass; override;
    function GetLoaderClass: TcxDataTreeListStructureLoaderClass; override;
    function GetOptionsDataClass: TcxControlOptionsDataClass; override;
    function GetTreeListColumnClass: TcxTreeListColumnClass; override;
    function InsertNode(IsAppend: Boolean): Boolean; override;
    function IsAutoCalcKeyValue: Boolean;
    function IsDataSettingsValid: Boolean; override;
    function IsSmartRefresh: Boolean;
    function SupportsCreateAllItems: Boolean; override;
    procedure LoadListByID(const AKeyValue: Variant; AList: TList);
    procedure LoadListByNode(ANode: TcxTreeListDataNode; AList: TList);
    procedure UpdateNode(ANode: TcxTreeListNode); override;
    property DataController: TcxDBTreeListDataController read GetDataController write SetDataController;
    property DataSet: TDataSet read GetDataSet;
    property Columns[Index: Integer]: TcxDBTreeListColumn read GetColumn write SetColumn;
    property OptionsData: TcxDBTreeListOptionsData read GetOptionsData write SetOptionsData;
    property VisibleColumns[Index: Integer]: TcxDBTreeListColumn read GetVisibleColumn write SetVisibleColumn;
    property RootValue: Variant read FRootValue write SetRootValue;
    property OnGetUniqueKeyValue: TcxDBTreeListGetUniqueKeyValueEvent read FOnGetUniqueKeyValue write FOnGetUniqueKeyValue;
    property OnInitInsertingRecord: TcxDBTreeListInitInsertingRecordEvent read FOnInitInsertingRecord write FOnInitInsertingRecord;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  { TcxDBTreeList }

  TcxDBTreeList = class(TcxCustomDBTreeList)
  public
    property Customizing;
    property ColumnCount;
    property Columns;
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
    property DataController; 
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
    property RootValue;
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
    property OnGetUniqueKeyValue;
    property OnHotTrackNode;
    property OnInitEdit;
    property OnInitInsertingRecord;
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

implementation
type
  TcxDataFieldAccess = class(TcxDBDataField);
  TcxDataNodeAccess = class(TcxTreeListDataNode);
  TcxDBDataProviderAccess = class(TcxDBDataProvider);
  TDataSetAccess = class(TDataSet);

function cxCompareParentNode(AItem1, AItem2: Pointer): Integer;
begin
  Result := VarCompare(TcxTreeListDataNode(AItem1).ParentValue,
    TcxTreeListDataNode(AItem2).ParentValue);
end;

{ TcxDBTreeListDataController }

destructor TcxDBTreeListDataController.Destroy;
begin
  FreeAndNil(FParentKeyField);
  FreeAndNil(FImageIndexField);
  FreeAndNil(FStateIndexField);
  inherited Destroy;
end;

procedure TcxDBTreeListDataController.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TcxDBTreeListDataController then
  begin
    ParentField := TcxDBTreeListDataController(Source).ParentField;
    KeyField := TcxDBTreeListDataController(Source).ParentField;
  end;
end;

procedure TcxDBTreeListDataController.CreateAllItems;
var
  I: Integer;
  ABand: TcxTreeListBand;
begin
  if (DataSet = nil) or (DataSet.FieldCount = 0) then Exit;
  TreeList.SetGlassCursor;
  try
    TreeList.BeginUpdate;
    try
      if TreeList.Bands.Count = 0 then
        ABand := TreeList.Bands.Add
      else
        ABand := TreeList.Bands[0];
      for I := 0 to DataSet.FieldCount - 1 do
        with TcxDBTreeListColumn(TreeList.CreateColumn(ABand)) do
        begin
          DataBinding.FieldName := DataSet.Fields[I].FieldName;
          Visible := DataSet.Fields[I].Visible;
        end;
    finally
      TreeList.EndUpdate;
    end;
  finally
    TreeList.RestoreCursor;
    TreeList.Modified;
  end;                      
end;
                           
procedure TcxDBTreeListDataController.FocusControl(AItemIndex: Integer; var Done: Boolean);
begin
  TcxDBTreeListColumn(GetItem(AItemIndex)).Editing := True;
  Done := TcxDBTreeListColumn(GetItem(AItemIndex)).Editing;
end;

function TcxDBTreeListDataController.GetItem(Index: Integer): TObject;
begin
  Result := TreeList.ContainerList[Index];
end;

function TcxDBTreeListDataController.GetItemValueSource(
  AItemIndex: Integer): TcxDataEditValueSource;
begin
  with TreeList.Columns[AItemIndex] do
    Result := PropertiesValue.GetEditValueSource(True);
end;

procedure TcxDBTreeListDataController.UpdateData;
begin
  TreeList.UpdateData;
end;

procedure TcxDBTreeListDataController.UpdateItemIndexes;
begin
  TreeList.UpdateIndexes;
  inherited UpdateItemIndexes;
end;

procedure TcxDBTreeListDataController.DataScrolled(ADistance: Integer);
var
  ANode: TcxTreeListDataNode;
begin
  inherited DataScrolled(ADistance);
  if IsSmartLoad and (ADistance <> 0) then
  begin
    ANode := TreeList.GetNodeByRecordIndex(FindRecordIndexByKey(KeyFieldField.Value));
    if ANode <> nil then
      ANode.MakeVisible
    else
      with TreeList do
      begin
        DataController.RecordCount := 0;
        if FocusedNode <> nil then
          FocusedNode.MakeVisible;
      end;
  end;
end;

procedure TcxDBTreeListDataController.DoCopyTo(AttachNode: TcxTreeListDataNode;
  AttachMode: TcxTreeListNodeAttachMode; ANodes: TList);

type
  PNodeBuffer =^TNodeBuffer;
  TNodeBuffer = record
    Key: Variant;
    Buffer: Variant;
    Items: TList;
  end;

var
  I: Integer;
  NewParentValue, KeyValue, Delta: Variant;
  // Drag Copy
  AKeyField, AParentField: TField;
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
    with DataSet do
    begin
      AParentValue := PBuffer^.Key;
      if Locate(ParentField, AParentValue, []) then
      begin
        PBuffer^.Items := TList.Create;
        while not EOF and (AParentField.Value = AParentValue) do
        begin
          PBuffer^.Items.Add(LoadBufferValues(AKeyField.Value));
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
    with DataSet do
    begin
      Insert;
      if AKeyField.IsNull and TreeList.OptionsData.AutoCalcKeyValue then
      begin
        AKeyField.Value := GetUniqueKeyValue(Delta);
        Inc(Delta);
      end;
      AParentField.Value := AParentValue;
      for I := 0 to AFieldList.Count - 1 do
        TField(AFieldList[I]).Value := PBuffer^.Buffer[I];
      Post;
      Key := AKeyField.Value;
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
      FreeAndNil(L);
    end;
    Dispose(PBuffer);
  end;

begin
  AParentField := TcxDataFieldAccess(FParentKeyField).Field;
  AKeyField := KeyFieldField; 
  with DataSet do
  begin
    if AttachMode in [tlamAddChild, tlamAddChildFirst] then
      NewParentValue := AttachNode.KeyValue
    else
      NewParentValue := AttachNode.ParentValue;
    DisableControls;
    try
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
          if (F = AKeyField) or (F = AParentField) or (F.FieldKind <> fkData) then
            F := nil;
          if Assigned(F) and F.CanModify then
            AFieldList.Add(F);
        end;
        if AFieldList.Count > 0 then
        begin
          // sort and remove dublicate
          ANodes.Sort(cxCompareParentNode);
          for I := ANodes.Count - 1 downto 1 do
            if TcxTreeListNode(ANodes[I]).HasAsParent(TcxTreeListNode(ANodes[I - 1])) then
              ANodes.Delete(I);
          // make Buffer List
          BufferList := TList.Create;
          try
            for I := 0 to ANodes.Count - 1 do
            begin
              KeyValue := TcxTreeListDataNode(ANodes[I]).KeyValue;
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
            FreeAndNil(BufferList);
          end;
        end;
      finally
        FreeAndNil(AFieldList);
      end;
    finally
      EnableControls;
    end;
  end;
end;

procedure TcxDBTreeListDataController.DoInitInsertingRecord(
  AInsertingRecordIndex: Integer);
var
  ANode: TcxTreeListDataNode;
begin
  inherited DoInitInsertingRecord(AInsertingRecordIndex);
  if IsSmartLoad and (FocusedRecordIndex >=0) then
    AInsertingRecordIndex := FocusedRecordIndex; 
  if cxInRange(AInsertingRecordIndex, 0, TreeList.Nodes.Count - 1) then
    ANode := TcxTreeListDataNode(TreeList.Nodes.Items[AInsertingRecordIndex])
  else
    ANode := nil;
    if not TreeList.DoExecuteInitInsertingRecord(ANode) then
      if TreeList.IsAutoCalcKeyValue then
      begin
        KeyFieldField.Value := GetUniqueKeyValue(0);
        if ANode <> nil then
          ParentFieldField.Value := ANode.ParentValue
      end;
end;

function TcxDBTreeListDataController.GetControl: TObject;
begin
  Result := TreeList;
end;

function TcxDBTreeListDataController.GetIsKeyFieldEmpty: Boolean;
begin
  Result := (ParentField = '') or (KeyField = '');
end;

function TcxDBTreeListDataController.GetItemID(AItem: TObject): Integer;
begin
  if AItem is TcxTreeListColumn then
    Result := TcxTreeListColumn(AItem).ItemIndex
  else
    Result := -1;
end;

function TcxDBTreeListDataController.GetKeyValue(ARecordIndex: Integer): Variant;
begin
  Result := GetInternalValue(ARecordIndex, inherited KeyField);
end;

function TcxDBTreeListDataController.GetParentKeyValue(ARecordIndex: Integer): Variant;
begin             
  Result := GetInternalValue(ARecordIndex, FParentKeyField);
end;

function TcxDBTreeListDataController.GetUniqueKeyValue(
  Delta: Integer = 0): Variant;
var
  I: Integer;
begin
  Result := Null;
  if Assigned(TreeList.FOnGetUniqueKeyValue) then
    TreeList.FOnGetUniqueKeyValue(Self, Result)
  else
    if not TreeList.IsSmartLoad then 
    try
      if not IsKeyFieldEmpty and (RecordCount > 0) then
      begin
        Result := GetKeyValue(0);
        for I := 1 to RecordCount - 1 do
          if VarCompare(GetKeyValue(I), Result) > 0 then Result := GetKeyValue(I);
      end;
      if VarType(Result) in [varSmallint, varInteger, varSingle, varDouble, varCurrency] then
        Result := Result + 1 + Delta
      else
        Result := 0;
    except
      Result := Null;
    end;
end;

function TcxDBTreeListDataController.IsSmartLoad: Boolean;
begin
  Result := TreeList.OptionsData.SmartLoad;
end;

procedure TcxDBTreeListDataController.SetKeyFieldValue(
  ANode: TcxTreeListDataNode; Value: Variant);
begin
  DataSet.Edit;
  if ANode <> nil then ANode.KeyValue := Value;
  KeyFieldField.Value := Value;
  DataSet.Post;
  if TreeList.IsSmartRefresh then
    DoUpdateRecord(TcxDataNodeAccess(ANode).RecordIndex);
end;

procedure TcxDBTreeListDataController.SetNodeParentValue(
  ANode: TcxTreeListDataNode; const Value: Variant);
begin
  if DataSet.Locate(KeyFieldNames, ANode.KeyValue, []) then
  begin
    DataSet.Edit;
    ANode.ParentValue := Value;
    TcxDataFieldAccess(FParentKeyField).Field.Value := Value;
    DataSet.Post;
    if TreeList.IsSmartRefresh then
      DoUpdateRecord(TcxDataNodeAccess(ANode).RecordIndex);
  end;
end;

procedure TcxDBTreeListDataController.UpdateControl(
  AInfo: TcxUpdateControlInfo);
begin
  TreeList.ControlUpdateData(AInfo);
  if AInfo is TcxLayoutChangedInfo then
    TreeList.FullRefresh;
end;

function TcxDBTreeListDataController.GetKeyField: string;
begin
  Result := KeyFieldNames;
end;

function TcxDBTreeListDataController.GetKeyFieldField: TField;
begin
  Result := TcxDataFieldAccess(inherited KeyField).Field;
end;

function TcxDBTreeListDataController.GetParentFieldField: TField;
begin
  Result := TcxDataFieldAccess(FParentKeyField).Field;  
end;

function TcxDBTreeListDataController.GetTreeList: TcxCustomDBTreeList;
begin
  Result := TcxCustomDBTreeList(GetOwner)
end;

procedure TcxDBTreeListDataController.SetImageIndexFieldName(
  const Value: string);
begin
  if Value <> ImageIndexFieldName then
  begin
    FImageIndexFieldName := Value;
    UpdateInternalKeyFields(FImageIndexFieldName, FImageIndexField);
  end;
end;

procedure TcxDBTreeListDataController.SetKeyField(const Value: string);
begin
  KeyFieldNames := Value;
end;

procedure TcxDBTreeListDataController.SetParentKeyFieldNames(
  const Value: string);
begin
  if FParentKeyFieldNames <> Value then
  begin
    FParentKeyFieldNames := Value;
    UpdateInternalKeyFields(FParentKeyFieldNames, FParentKeyField);
  end;
end;

procedure TcxDBTreeListDataController.SetStateIndexFieldName(
  const Value: string);
begin
  if Value <> FStateIndexFieldName then
  begin
    FStateIndexFieldName := Value;
    UpdateInternalKeyFields(FStateIndexFieldName, FStateIndexField);
  end;
end;

{ TcxDBTreeListDefaultValuesProvider }

function TcxDBTreeListDefaultValuesProvider.IsDisplayFormatDefined(
  AIsCurrencyValueAccepted: Boolean): Boolean;
begin
  Result := TcxDBItemDataBinding(Owner).IsDisplayFormatDefined(AIsCurrencyValueAccepted);
end;

{ TcxDBItemDataBinding }

procedure TcxDBItemDataBinding.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TcxDBItemDataBinding then
    FieldName := TcxDBItemDataBinding(Source).FieldName;
end;

function TcxDBItemDataBinding.DefaultRepositoryItem: TcxEditRepositoryItem;
begin
  Result := GetDefaultEditDBRepositoryItems.GetItemByField(Field);
end;

function TcxDBItemDataBinding.GetControl: TObject;
begin
  Result := DataController.GetControl;
end;

function TcxDBItemDataBinding.GetDefaultCaption: string;
begin
  if Field <> nil then 
    Result := Field.DisplayName
  else
    Result := FieldName;
end;

function TcxDBItemDataBinding.GetDefaultValuesProviderClass: TcxCustomEditDefaultValuesProviderClass;
begin
  Result := TcxDBTreeListDefaultValuesProvider;
end;

function TcxDBItemDataBinding.GetValueTypeClass: TcxValueTypeClass;
begin
  Result := GetValueTypeClassByField(Field);
end;

procedure TcxDBItemDataBinding.Init;
begin
  inherited Init;
  TcxDBTreeListDefaultValuesProvider(DefaultValuesProvider).DataSource := DataController.DataSource;
  TcxDBTreeListDefaultValuesProvider(DefaultValuesProvider).Field := Field;
end;

procedure TcxDBItemDataBinding.ValueTypeClassChanged;
begin
  TcxDBTreeListColumn(EditContainer).InternalPropertiesChanged;
end;

function TcxDBItemDataBinding._AddRef: Integer;
begin
  Result := -1;
end;

function TcxDBItemDataBinding._Release: Integer;
begin
  Result := -1;
end;

function TcxDBItemDataBinding.QueryInterface(
  const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := cxE_NOINTERFACE;
end;

function TcxDBItemDataBinding.GetDataController: TcxDBTreeListDataController;
begin
  Result := TcxDBTreeListDataController(inherited DataController);
end;

function TcxDBItemDataBinding.GetField: TField;
begin
  Result := DataController.GetItemField(EditContainer.ItemIndex);
end;

function TcxDBItemDataBinding.GetFieldName: string;
begin
  Result := DataController.GetItemFieldName(EditContainer.ItemIndex);
end;

procedure TcxDBItemDataBinding.SetFieldName(const AName: string);
begin
  DataController.ChangeFieldName(EditContainer.ItemIndex, AName);
  Init;
  ValueTypeClassChanged;
end;

{ TcxDBTreeListColumnSummaryFooter }

procedure TcxDBTreeListColumnSummaryFooter.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TcxDBTreeListColumnSummaryFooter then
    FieldName := TcxDBTreeListColumnSummaryFooter(Source).FieldName;
end;

function TcxDBTreeListColumnSummaryFooter.GetControl: TObject;
begin
  Result := DataController.GetControl;
end;

function TcxDBTreeListColumnSummaryFooter.GetDataController: TcxDBTreeListDataController;
begin
  Result := TcxDBTreeListDataController(inherited DataController);
end;

function TcxDBTreeListColumnSummaryFooter.GetFieldName: string;
begin
  if IsSummaryItemValid then
    Result := SummaryItem.FieldName
  else
    Result := '';
end;

function TcxDBTreeListColumnSummaryFooter.GetSummaryItem: TcxDBDataSummaryItem;
begin
  Result := TcxDBDataSummaryItem(inherited SummaryItem);
end;

procedure TcxDBTreeListColumnSummaryFooter.SetFeldName(const Value: string);
begin
  if IsSummaryItemValid then
    SummaryItem.FieldName := Value;
  SummaryItemChanged;
end;

function TcxDBTreeListColumnSummaryFooter.IsFieldNameStored: Boolean;
begin
  Result := FieldName <> '';
end;

{ TcxDBTreeListOptionsData }

constructor TcxDBTreeListOptionsData.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  CheckHasChildren := True; 
end;

procedure TcxDBTreeListOptionsData.Assign(Source: TPersistent);
begin
  if Source is TcxDBTreeListOptionsData then
  begin
    SmartRefresh := TcxDBTreeListOptionsData(Source).SmartRefresh;
    SyncMode := TcxDBTreeListOptionsData(Source).SyncMode;
  end;
  inherited Assign(Source);
end;

procedure TcxDBTreeListOptionsData.SetSmartLoad(Index: Integer; Value: Boolean);
begin
  with TcxCustomDBTreeList(GetOwner) do
  begin
    DataController.BeginUpdate;
    try
      if Value then
        SmartRefresh := False;
      inherited SetSmartLoad(Index, Value);
    finally
      DataController.EndUpdate;
    end;
  end;
end;

function TcxDBTreeListOptionsData.GetDataController: TcxDBTreeListDataController;
begin
  Result := TcxCustomDBTreeList(EditingControl).DataController;
end;

function TcxDBTreeListOptionsData.GetSmartRefresh: Boolean;
begin
  Result := DataController.DataModeController.SmartRefresh;
end;

function TcxDBTreeListOptionsData.GetSyncMode: Boolean;
begin
  Result := DataController.DataModeController.SyncMode;
end;

procedure TcxDBTreeListOptionsData.SetSmartRefresh(Value: Boolean);
begin
  if SmartRefresh <> Value then
    DataController.DataModeController.SmartRefresh := Value;
end;

procedure TcxDBTreeListOptionsData.SetSyncMode(Value: Boolean);
begin
  if SyncMode <> Value then
    DataController.DataModeController.SyncMode := Value;
end;

{ TcxDBTreeListColumn }

function TcxDBTreeListColumn.GetDataBindingClass: TcxItemDataBindingClass;
begin
  Result := TcxDBItemDataBinding;
end;

function TcxDBTreeListColumn.GetSummaryFooterClass: TcxTreeListColumnSummaryFooterClass;
begin
  Result := TcxDBTreeListColumnSummaryFooter;
end;

function TcxDBTreeListColumn.GetDataBinding: TcxDBItemDataBinding;
begin
  Result := TcxDBItemDataBinding(inherited DataBinding);
end;

procedure TcxDBTreeListColumn.SetDataBinding(Value: TcxDBItemDataBinding);
begin
  DataBinding.Assign(Value);
end;

function TcxDBTreeListColumn.GetSummaryFooter: TcxDBTreeListColumnSummaryFooter;
begin
  Result := TcxDBTreeListColumnSummaryFooter(inherited SummaryFooter)
end;

procedure TcxDBTreeListColumn.SetSummaryFooter(
  Value: TcxDBTreeListColumnSummaryFooter);
begin
  SummaryFooter.Assign(Value)
end;

{ TcxDBTreeListLoader }

procedure TcxDBTreeListLoader.AfterSmartLoad;
begin
  FreeAndNil(FValueDefReader);
  inherited AfterSmartLoad;
end;

procedure TcxDBTreeListLoader.BeforeSmartLoad;
begin
  with TcxDBDataProviderAccess(DataController.Provider) do
    FValueDefReader := GetValueDefReaderClass.Create;
  inherited BeforeSmartLoad;
end;

procedure TcxDBTreeListLoader.DoneLoading;
begin
//  DataSet.Locate(KeyFieldName, SaveKeyValue, []);
  try
    inherited DoneLoading;
  finally
    FHasChildrenNodes.Free;
  end;
end;

function TcxDBTreeListLoader.GetImageIndexAsInteger(
  const AIndex: Integer; AField: TcxDBDataField): Integer;
begin
  if AField = nil then
    Result := -1
  else
    try
      Result := DataController.GetInternalValue(AIndex, AField);
    except
      on EVariantError do Result := -1;
    end;
end;

function TcxDBTreeListLoader.GetKeyValue(ARecordIndex: Integer): Variant;
begin
  Result := DataController.GetKeyValue(ARecordIndex);
end;

function TcxDBTreeListLoader.GetNodeImageIndex(
  ARecordIndex: Integer): Integer;
begin
  with DataController do
    Result := GetImageIndexAsInteger(ARecordIndex, FImageIndexField);
end;

function TcxDBTreeListLoader.GetNodeStateImage(
  ARecordIndex: Integer): Integer;
begin
  with DataController do
    Result := GetImageIndexAsInteger(ARecordIndex, FStateIndexField);
end;

function TcxDBTreeListLoader.GetParentKeyValue(ARecordIndex: Integer): Variant;
begin
  Result := DataController.GetParentKeyValue(ARecordIndex);
end;

procedure TcxDBTreeListLoader.InitLoadedNode(ANode: TcxTreeListDataNode);
begin
  if IsSmartLoad and not IsLoadLoadingData then
    TcxDataNodeAccess(ANode).RecordIndex := DataController.LoadRecord(ValueDefReader);
end;

procedure TcxDBTreeListLoader.InitLoading;
begin
  FHasChildrenNodes := TList.Create;
  inherited InitLoading;
end;

function TcxDBTreeListLoader.IsExistChildren(ANode: TcxTreeListDataNode): Boolean;
begin
  Result := not NeedCheckChildren or DataSet.Locate(ParentFieldName, ANode.KeyValue, []);
end;

function TcxDBTreeListLoader.IsExistKeyRoot(AParentValue: Variant): Boolean;
var
  ARootValue: Variant;
begin
  Result := False;
  ARootValue := DBTreeList.RootValue;
  repeat
    if AParentValue = ARootValue then
    begin
      Result := True;
      Break;
    end;
    if not DataSet.Locate(KeyFieldName, AParentValue, []) or
      (KeyField.Value = ParentField.Value) then Break;
    AParentValue := ParentField.Value;
  until False;
end;

procedure TcxDBTreeListLoader.LoadLevel(ANode: TcxTreeListDataNode;
  const AParentValue: Variant; ANewNodes: TList);
var
  I: Integer;
  AItem: TcxTreeListDataNode;
  AList: TList;
begin
  if not DataSet.Locate(ParentFieldName, AParentValue, []) then Exit;
  AList := TList.Create;
  try
    while not DataSet.EOF and (ParentField.Value = AParentValue) do
    begin
      AItem := LoadValues(AParentValue, KeyField.Value);
      if ANewNodes <> nil then ANewNodes.Add(AItem);
      if ANode = nil then AList.Add(AItem);
      DataSet.Next;
    end;
    // load children if expanded
    if ANode = nil then
    begin
      for I := 0 to AList.Count - 1 do
      begin
        AItem := TcxTreeListDataNode(AList[I]);
        if AItem.Expanded then
          LoadLevel(AItem, AItem.KeyValue, nil)
        else
          if IsExistChildren(AItem) then FHasChildrenNodes.Add(AItem);
      end;
    end
    else
    begin
      ANode := TcxTreeListDataNode(ANode.GetFirstChild);
      while ANode <> nil do
      begin
        if ANode.Expanded then
          LoadLevel(ANode, ANode.KeyValue, nil)
        else
          if IsExistChildren(ANode) then FHasChildrenNodes.Add(ANode);
        ANode := TcxTreeListDataNode(ANode.GetNextSibling);
      end;
    end;
  finally
    for I := 0 to FHasChildrenNodes.Count - 1 do
      TcxTreeListDataNode(FHasChildrenNodes[I]).HasChildren := True;
    FHasChildrenNodes.Clear;
    AList.Free;
  end;
end;

procedure TcxDBTreeListLoader.LoadChildItems(ANode: TcxTreeListDataNode);
var
  AItem: TcxTreeListNode;
  AParentValue: Variant;
begin
  AParentValue := ANode.KeyValue;
  if not DataSet.Locate(ParentFieldName, AParentValue, []) then Exit;
  while not DataSet.EOF and (ParentField.Value = ANode.KeyValue) do
  begin
    LoadValues(ANode, AParentValue, KeyField.Value);
    DataSet.Next;
  end;
  AItem := ANode.GetFirstChild;
  while AItem <> nil do
  begin
    AItem.HasChildren := IsExistChildren(TcxTreeListDataNode(AItem));
    AItem := AItem.GetNextSibling;
  end;
end;

procedure TcxDBTreeListLoader.LoadLevelBack(AParentValue: Variant);
var
  I, AIndex: Integer;
  ANewNodes: TList;
  ANode: TcxTreeListDataNode;
begin
  ANewNodes := TList.Create;
  try
    repeat
      if FindParentNode(AParentValue, I) then
      begin
        LoadLevel(Loaded[I], AParentValue, nil);
        Break;
      end
      else
      begin
        LoadLevel(nil, AParentValue, ANewNodes);
        if not DataSet.Locate(KeyFieldName, AParentValue, []) then Break;
        AParentValue := ParentField.Value;
      end;
    until False;
    // Correct Parent
    for I := 0 to ANewNodes.Count - 1 do
    begin
      ANode := TcxTreeListDataNode(ANewNodes[I]);
      if FindParentNode(ANode.ParentValue, AIndex) and
         ANode.CanMove(Loaded[AIndex], tlamAddChild) then
        InternalMove(ANode, Loaded[AIndex], tlamAddChild);
    end;
  finally
    ANewNodes.Free;
  end;
end;

procedure TcxDBTreeListLoader.LoadTreeListInSmartLoadMode;
var
  I: Integer;
  AKeyValue: Variant;
  AParentValue: Variant;
begin
  if LoadingNode = nil then
  begin
    AKeyValue := KeyField.Value;
    AParentValue := ParentField.Value;
    LoadLevel(nil, DBTreeList.RootValue, nil);
    if (KeyField <> ParentField) and IsExistKeyRoot(AParentValue) and
      not FindParentNode(AKeyValue, I) then
      LoadLevelBack(AParentValue);
  end
  else
    LoadChildItems(LoadingNode);
end;

function TcxDBTreeListLoader.NeedCheckChildren: Boolean;
begin
  Result := DBTreeList.OptionsData.CheckHasChildren;
end;

function TcxDBTreeListLoader.GetDataController: TcxDBTreeListDataController;
begin
  Result := TcxDBTreeListDataController(inherited DataController);
end;

function TcxDBTreeListLoader.GetDataSet: TDataSet;
begin
  Result := DataController.DataSet;
end;

function TcxDBTreeListLoader.GetDBTreeList: TcxCustomDBTreeList;
begin
  Result := TcxCustomDBTreeList(TreeList)
end;

function TcxDBTreeListLoader.GetKeyField: TField;
begin
  Result := DataController.KeyFieldField;
end;

function TcxDBTreeListLoader.GetKeyFieldName: string;
begin
  Result := DataController.KeyField;
end;

function TcxDBTreeListLoader.GetParentField: TField;
begin
  Result := DataController.ParentFieldField;
end;

function TcxDBTreeListLoader.GetParentFieldName: string;
begin
  Result := DataController.ParentField;
end;

{ TcxCustomDBTreeList }

constructor TcxCustomDBTreeList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner); 
  FRootValue := Integer(-1);
end;

destructor TcxCustomDBTreeList.Destroy;
begin
  BeginUpdate;
  DataController.DataSource := nil;
  inherited Destroy;
end;

procedure TcxCustomDBTreeList.CreateAllItems;
begin
  DataController.CreateAllItems;
end;

procedure TcxCustomDBTreeList.AddToDelitionList(ANode: TcxTreeListNode);
begin
  if not IsSmartLoad then
    inherited AddToDelitionList(ANode);
end;

procedure TcxCustomDBTreeList.DoClearDataSource;
var
  ADataSource: TDataSource;
begin
  ADataSource := DataController.DataSource;
  DataController.DataSource := nil;
  DataController.DataSource := ADataSource;
end;

procedure TcxCustomDBTreeList.DoDeleteNode(ANode: TcxTreeListNode);
begin
  if IsDestroying or SafeDelete then
  begin
    DoRemoveNode(ANode);
    Exit;
  end;
  UpdateFocusedRecordPost;
  if IsSmartLoad and IsDataSettingsValid then
    DoDeleteNodeEntry(TcxTreeListDataNode(ANode));
  inherited DoDeleteNode(ANode);
end;

procedure TcxCustomDBTreeList.DoDeleteNodeEntry(
  ANode: TcxTreeListDataNode);
var
  AList: TList;
  I: Integer;
begin
  if not ANode.HasChildren then
  begin
    if DataSet.Locate(DataController.KeyField, ANode.KeyValue, []) then
      DataSet.Delete;
  end
  else
    with DataSet do
    begin
      SetGlassCursor;
      DisableControls;
      try
        AList := TList.Create;
        try
          if not IsSmartLoad then
            LoadListByNode(ANode, AList)
          else
            LoadListByID(ANode.KeyValue, AList);
          // Delete Nodes
          for I := AList.Count - 1 downto 0 do
            if Locate(DataController.KeyField, PVariant(AList[I])^, []) then Delete;
        finally
          for I := 0 to AList.Count - 1 do
            Dispose(AList[I]);
          AList.Free;
        end;
      finally
        EnableControls;
      end;
    end;
end;

function TcxCustomDBTreeList.DoExecuteInitInsertingRecord(
  ANode: TcxTreeListDataNode): Boolean;
begin
  Result := False;
  if Assigned(FOnInitInsertingRecord) then
    FOnInitInsertingRecord(Self, ANode, Result);
end;

procedure TcxCustomDBTreeList.DoMoveTo(AttachNode: TcxTreeListNode;
  AttachMode: TcxTreeListNodeAttachMode; ANodes: TList; IsCopy: Boolean);
var
  I: Integer;
  NewParentValue: Variant;
begin
  if AttachMode in [tlamAddChild, tlamAddChildFirst] then
    NewParentValue := TcxTreeListDataNode(AttachNode).KeyValue
  else
    NewParentValue := TcxTreeListDataNode(AttachNode).ParentValue;
  if not IsCopy then
  begin
    inherited DoMoveTo(AttachNode, AttachMode, ANodes, IsCopy);
    DataController.DataSet.DisableControls;
    try
      for I := 0 to ANodes.Count - 1 do
        DataController.SetNodeParentValue(
            TcxTreeListDataNode(ANodes.List^[I]), NewParentValue);
    finally
      DataController.DataSet.EnableControls;
    end;
  end
  else
  begin
    BeginUpdate;
    try
      DataController.DoCopyTo(TcxTreeListDataNode(AttachNode), AttachMode, ANodes);
      if IsSmartRefresh then DataController.UpdateItems(False);
    finally
      EndUpdate;
      DoDataChanged; 
    end
  end;
end;

function TcxCustomDBTreeList.GetDataControllerClass: TcxCustomDataControllerClass;
begin
  Result := TcxDBTreeListDataController;
end;

function TcxCustomDBTreeList.GetOptionsDataClass: TcxControlOptionsDataClass;
begin
  Result := TcxDBTreeListOptionsData;
end;

function TcxCustomDBTreeList.GetLoaderClass: TcxDataTreeListStructureLoaderClass;
begin
  Result := TcxDBTreeListLoader;
end;

function TcxCustomDBTreeList.GetTreeListColumnClass: TcxTreeListColumnClass;
begin
  Result := TcxDBTreeListColumn;
end;

function TcxCustomDBTreeList.InsertNode(IsAppend: Boolean): Boolean;
begin
  if IsAppend then
    DataController.Append
  else
    DataController.Insert;
  Result := True;
end;

function TcxCustomDBTreeList.IsAutoCalcKeyValue: Boolean;
begin
  Result := OptionsData.AutoCalcKeyValue and not IsSmartLoad;
end;

function TcxCustomDBTreeList.IsDataSettingsValid: Boolean;
begin
  with DataController do
    Result := (DataSet <> nil) and DataSet.Active and not IsKeyFieldEmpty;
end;

function TcxCustomDBTreeList.IsSmartRefresh: Boolean;
begin
  Result := OptionsData.SmartRefresh;
end;

function TcxCustomDBTreeList.SupportsCreateAllItems: Boolean;
begin
  Result := True;
end;

procedure TcxCustomDBTreeList.LoadListByNode(
  ANode: TcxTreeListDataNode; AList: TList);
var
  P: PVariant;
  I: Integer;
begin
  New(P);
  P^ := ANode.KeyValue;
  AList.Add(P);
  for I := 0 to ANode.Count - 1 do
    LoadListByNode(TcxTreeListDataNode(ANode[I]), AList);
end;

procedure TcxCustomDBTreeList.LoadListByID(
  const AKeyValue: Variant; AList: TList);
var
  P: PVariant;
  ATempList: TList;
  I: Integer;
begin
  New(P);
  P^ := AKeyValue;
  AList.Add(P);
  if not DataSet.Locate(DataController.ParentField, AKeyValue, []) then Exit;
  ATempList := TList.Create;
  try
    while not DataSet.Eof and (DataController.ParentFieldField.Value = AKeyValue) do
    begin
      New(P);
      P^ := DataController.KeyFieldField.Value;
      ATempList.Add(P);
      DataSet.Next;
    end;
    for I := 0 to ATempList.Count - 1 do
      LoadListByID(PVariant(ATempList[I])^, AList);
  finally
    for I := 0 to ATempList.Count - 1 do
      Dispose(ATempList[I]);
    ATempList.Free;
  end;
end;

procedure TcxCustomDBTreeList.UpdateNode(ANode: TcxTreeListNode);

  function IsDataChanged: Boolean;
  begin
    with DataController, TcxDataNodeAccess(ANode) do
      Result := (VarCompare(GetKeyValue(RecordIndex), KeyValue) <> 0) or
        (VarCompare(GetParentKeyValue(RecordIndex), ParentValue) <> 0);
  end;

begin
  if IsFreeze then Exit; 
  if IsDataChanged then
    DataChanged
  else
    inherited UpdateNode(ANode);
end;

function TcxCustomDBTreeList.GetColumn(Index: Integer): TcxDBTreeListColumn;
begin
  Result := TcxDBTreeListColumn(inherited Columns[Index])
end;

function TcxCustomDBTreeList.GetDataController: TcxDBTreeListDataController;
begin
  Result := TcxDBTreeListDataController(inherited DataController);
end;

function TcxCustomDBTreeList.GetDataSet: TDataSet;
begin
  Result := DataController.DataSource.DataSet;
end;

function TcxCustomDBTreeList.GetOptionsData: TcxDBTreeListOptionsData;
begin
  Result := TcxDBTreeListOptionsData(inherited OptionsData); 
end;

function TcxCustomDBTreeList.GetVisibleColumn(
  Index: Integer): TcxDBTreeListColumn;
begin
  Result := TcxDBTreeListColumn(inherited VisibleColumns[Index])
end;

procedure TcxCustomDBTreeList.SetColumn(
  Index: Integer; Value: TcxDBTreeListColumn);
begin
  Columns[Index].Assign(Value);
end;

procedure TcxCustomDBTreeList.SetDataController(
  Value: TcxDBTreeListDataController);
begin
  DataController.Assign(Value);
end;

procedure TcxCustomDBTreeList.SetOptionsData(Value: TcxDBTreeListOptionsData);
begin
  OptionsData.Assign(Value);
end;

procedure TcxCustomDBTreeList.SetRootValue(const Value: Variant);
begin
  FRootValue := Value;
  DataChanged;
end;

procedure TcxCustomDBTreeList.SetVisibleColumn(
  Index: Integer; Value: TcxDBTreeListColumn);
begin
  VisibleColumns[Index].Assign(Value);
end;

end.
