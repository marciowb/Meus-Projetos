{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       Express data-aware tree view                                }
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
{   FILES or ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, or OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxdbtree;

interface

{$I cxVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Variants, ComCtrls, CommCtrl, DB, dxMessages, dxtree;

type
  EDBTreeViewError = class(Exception);

  TdxDBTreeView = class;

  TDataLinkTreeView = class(TDataLink)
  private
    FDBTreeView: TdxDBTreeView;
    Filter: string;
    Filtered: Boolean;
  protected
    procedure ActiveChanged; override;
    procedure DataSetChanged; override;
    procedure DataSetScrolled(Distance: Integer); override;
    procedure RecordChanged(Field: TField); override;
  public
    constructor Create;  
  end;

  TdxDBTreeNodes = class;

  TdxDBTreeNode = class(TdxTreeNode)
  private
    IsInserting: Boolean;
    Refreshed: Boolean;
  protected
    DBTreeNodes: TdxDBTreeNodes;

    FKeyFieldValue: Variant;
    FParentFieldValue: Variant;
    FChildLoaded: Boolean;

    FIndex: Integer;
    FListText: string;

    FBkColor: TColor;
    FColor: TColor;
    FFontStyle: TFontStyles;
    FFontName: TFontName;
    FIsCustomDraw: Boolean;

    procedure SetChildLoaded(Value: Boolean);
    procedure SetIsCustomDraw(Value: Boolean);
  protected
    procedure SetKeyFieldValue(Value: Variant);
    procedure SetParentFieldValue(Value: Variant);
    procedure UpdateImages;
  public
    constructor Create(AOwner: TdxDBTreeNodes; Value: Variant); reintroduce; overload;
    destructor Destroy; override;
    procedure LoadChildren(Recurse: Boolean);

    property BkColor: TColor read FBkColor write FBkColor;
    property Color: TColor read FColor write FColor;
    property FontStyle: TFontStyles read FFontStyle write FFontStyle;
    property FontName: TFontName read FFontName write FFontName;
    property IsCustomDraw: Boolean read FIsCustomDraw write SetIsCustomDraw;

    property ChildLoaded: Boolean read FChildLoaded write SetChildLoaded;
    property Index: Integer read FIndex;
    property KeyFieldValue: Variant read FKeyFieldValue;
    property ParentFieldValue: Variant read FParentFieldValue;
  end;

  TdxDBTreeNodes = class
  private
    FDBTreeView: TdxDBTreeView;
    FList: TList;
    FCustomDrawCount: Integer;
    Destroying: Boolean;

    function GetDBNodeFromIndex(Index: Integer): TdxDBTreeNode;
    function GetMaxKeyFieldValue: Variant;
  protected
    procedure BeginRefreshRecord;
    procedure EndRefreshRecord;
    function FindNearest(Value: Variant; var Index: Integer): Boolean;
    procedure Clear;
    procedure Delete(ADBTreeNode: TdxDBTreeNode);
    procedure NodeChangeParent(TreeNode: TTreeNode; Value: Variant);
    function RefreshRecord: TdxDBTreeNode;
    procedure RefreshParents;
  public
    constructor Create(ADBTreeView: TdxDBTreeView);
    destructor Destroy; override;
    function Count: Integer;
    function GetKeyFieldValue(Value: TTreeNode): Variant;
    function GetParentValue(Value: TTreeNode): Variant;
    function GetDBTreeNode(Value: Variant): TdxDBTreeNode;
    function GetTreeNode(Value: Variant): TTreeNode;
    function IndexOf(Value: TTreeNode): Integer;
    property Items[Index: Integer]: TdxDBTreeNode read GetDBNodeFromIndex; default;
    property MaxKeyFieldValue: Variant read GetMaxKeyFieldValue;
  end;

  TAddNewDBTreeNodeEvent = procedure(Sender: TObject; var DBTreeNode: TdxDBTreeNode) of Object;
  TDBTreeRefreshNodeEvent = procedure(Sender: TObject; DBTreeNode: TdxDBTreeNode) of Object;
  TCreateNewKeyValue = procedure(Sender: TObject; var NewKeyValue: Variant) of Object;
  TSetDisplayItemText = procedure(Sender: TObject; var DisplayText: string) of Object;
  TdxDBTreeViewOption = (trDBCanDelete, trDBConfirmDelete, trCanDBNavigate,
                    trSmartRecordLoad, trSmartRecordCopy, trCheckHasChildren);
  TdxDBTreeViewOptions = set of TdxDBTreeViewOption;

  TdxDBTreeViewAction = (trDBInsert, trDBDelete, trDBChangeText, trDBChangeParent, trDBMove);
  TdxDBTreeViewActionEvent = procedure(Sender: TObject; DBNode1, DBNode2: TdxDBTreeNode;
                           Action: TdxDBTreeViewAction; var Automatic: Boolean) of Object;

  TdxDBTreeView = class(TCustomdxTreeView)
  private
    DataChangedBusy: Boolean;
    CNNotifyFlag: Boolean;

    FDataLink: TDataLinkTreeView;
    FDBTreeNodes: TdxDBTreeNodes;
    FAddNewItem: TAddNewDBTreeNodeEvent;
    FCreateNewKeyValue: TCreateNewKeyValue;
    FOnSetDisplayItemText: TSetDisplayItemText;
    FOnInsertNodeError: TNotifyEvent;
    FRaiseOnError: Boolean;
    FOnDBAction: TdxDBTreeViewActionEvent;
    FOnRefreshNode: TDBTreeRefreshNodeEvent;

    FKeyFieldName: string;
    FListFieldName: string;
    FParentFieldName: string;
    FDisplayFieldName: string;
    FImageIndexFieldName: string;
    FStateIndexFieldName: string;
    FRootValue: Variant;
    FSeparatedSt: string;
    FOptions: TdxDBTreeViewOptions;

    FImageIndexField: TField;
    FKeyField: TField;
    FListField: TField;
    FDisplayFields: TList;
    FParentField: TField;
    FStateIndexField: TField;

    FEditInstance: Pointer;
    FDefEditProc: Pointer;
    FEditHandle: HWND;

    procedure AssignFields;
    procedure DataLinkActiveChanged;
    procedure DataLinkRecordChanged(Field: TField);
    procedure DataChanged;
    procedure RecordEdit(Field: TField);
    procedure RecordInsert(Field: TField);

    function GetDataSource: TDataSource;
    {$IFNDEF DELPHI6}
    function GetRootValue: string;
    {$ENDIF}
    function GetSeletectedDBTreeNode: TdxDBTreeNode;
    procedure Scroll;
    procedure SetDataSource(Value: TDataSource);
    procedure SetDisplayFieldName(const Value: string);
    procedure SetImageIndexFieldName(const Value: string);
    procedure SetKeyFieldName(const Value: string);
    procedure SetListFieldName(const Value: string);
    procedure SetRootValue(const Value: {$IFNDEF DELPHI6}string{$ELSE}Variant{$ENDIF});
    procedure SetStateIndexFieldName(const Value: string);
    procedure SetOptions(const Value: TdxDBTreeViewOptions);
    procedure SetParentFieldName(const Value: string);
    procedure SetSeparatedSt(const Value: string);

    function GetDisplayText: string;

    procedure DoCNNotify(var Message: TWMNotify);
    procedure DoWMPaint(var Message: TMessage);
    procedure DoVMInsertItem(var Message: TMessage);
    procedure DoVMSelectItem(var Message: TMessage);
    procedure DoVMSetItem(var Message: TMessage);
    procedure DoVMExpand(var Message: TMessage);
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
    procedure VM_INSERTITEM(var Message: TMessage); message TVM_INSERTITEM;
    procedure VM_SELECTITEM(var Message: TMessage); message TVM_SELECTITEM;
    procedure VM_SETITEM(var Message: TMessage); message TVM_SETITEM;
    procedure VM_EXPAND(var Message: TMessage); message TVM_EXPAND;
    procedure WMPAINT(var Message: TMessage); message WM_PAINT;
    procedure WMUpdateImages(var Message: TMessage); message DXM_UPDATEIMAGES;
    procedure EditWndProc(var Message: TMessage);
    procedure FrameSelectedItem;
    procedure DeleteDBNode(AKeyValue: Variant);

    procedure InsertTreeNode(Node, Parent: TdxDBTreeNode);
    procedure SetNewTreeNodeParent(Node, NewParent: TdxDBTreeNode);
  protected
    function CanExpand(Node: TTreeNode): Boolean; override;
    function DoDBAction(DBNode1, DBNode2: TdxDBTreeNode; Action: TdxDBTreeViewAction): Boolean; dynamic;

    procedure CreateWnd; override;
    procedure DestroyWnd; override;

    procedure CreateHandle; override;
    procedure Change(Node: TTreeNode); override;
    procedure DoCustomDraw(TreeNode: TTreeNode; AFont: TFont;
               var AColor, ABkColor: TColor); override;
    function GetListItemText(TreeNode: TTreeNode): string; override;
    procedure Edit(const Item: TTVItem); override;
    procedure InsertTreeNodeStructure(ListS, ListD: TList; Flag: Boolean); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function GetNextMaxKeyValue: Variant;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CreateNode: TTreeNode; override;

    procedure GetNodeStructure(TreeNode: TTreeNode; List: TList); override;

    function GetImageIndexField: TField;
    function GetKeyField: TField;
    function GetListField: TField;
    function GetParentField: TField;
    function GetStateIndexField: TField;

    procedure GotoKeyFieldValue(Value: Variant);
    function IsCustomDraw: Boolean; override;
    procedure RefreshItems;

    property DBSelected: TdxDBTreeNode read GetSeletectedDBTreeNode;
    property DBTreeNodes: TdxDBTreeNodes read FDBTreeNodes;
    property Items;
    property Selected;
  published
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DisplayField: string read FDisplayFieldName write SetDisplayFieldName;
    property ImageIndexField: string read FImageIndexFieldName write SetImageIndexFieldName;
    property KeyField: string read FKeyFieldName write SetKeyFieldName;
    property ListField: string read FListFieldName write SetListFieldName;
    property ParentField: string read FParentFieldName write SetParentFieldName;
    {$IFNDEF DELPHI6}
    property RootValue: string read GetRootValue write SetRootValue;
    {$ELSE}
    property RootValue: Variant read FRootValue write SetRootValue;
    {$ENDIF}
    property SeparatedSt: string read FSeparatedSt write SetSeparatedSt;
    property StateIndexField: string read FStateIndexFieldName write SetStateIndexFieldName;
    property RaiseOnError: Boolean read FRaiseOnError write FRaiseOnError;  
    property ShowButtons;
    property BorderStyle;
    property DragCursor;
    property ShowLines;
    property ShowRoot;
    property ReadOnly;
    property DragMode;
    property HideSelection;
    property Indent;
    property OnEditing;
    property OnEdited;
    property OnExpanding;
    property OnExpanded;
    property OnCollapsing;
    property OnCompare;
    property OnCollapsed;
    property OnChanging;
    property OnChange;
    property OnDeletion;
    property OnGetImageIndex;
    property OnGetSelectedIndex;
    property Align;
    property Enabled;
    property Font;
    property Color;
    property ParentColor;
    property ParentCtl3D;
    property Ctl3D;
    property Options: TdxDBTreeViewOptions read FOptions write SetOptions default [];
    property SortType;
    property SelectedIndex;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnAddNewItem: TAddNewDBTreeNodeEvent read FAddNewItem write FAddNewItem;
    property OnCreateNewKeyValue: TCreateNewKeyValue read FCreateNewKeyValue
                                 write FCreateNewKeyValue;
    property OnSetDisplayItemText: TSetDisplayItemText read FOnSetDisplayItemText
                                 write FOnSetDisplayItemText;
    property OnInsertNodeError: TNotifyEvent read FOnInsertNodeError write FOnInsertNodeError;
    property OnDBAction: TdxDBTreeViewActionEvent read FOnDBAction write FOnDBAction;
    property OnRefreshNode: TDBTreeRefreshNodeEvent read FOnRefreshNode write FOnRefreshNode;   
    property OnClick;
    property OnEnter;
    property OnExit;
    property OnDragDrop;
    property OnDragOver;
    property OnStartDrag;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnDblClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property PopupMenu;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    property Images;
    property StateImages;
    {$IFDEF DELPHI6}
    property OnContextPopup;
    {$ENDIF}
end;

implementation
uses TypInfo {$IFNDEF DELPHI3}, DBTables {$ENDIF}, dxlocate
  ;

function VarEquals(const V1, V2: Variant): Boolean;
begin
  try
    Result := V1 = V2;
  except
    Result := False;
  end;
end;

function VarFirstMore(const V1, V2: Variant): Boolean;
begin
  try
    Result := V1 >= V2;
  except
    Result := False;
  end;
end;

function VarFirstMoreEx(const V1, V2: Variant): Boolean;
begin
  try
    Result := V1 > V2;
  except
    Result := False;
  end;
end;

{TDataLinkTreeView}
constructor TDataLinkTreeView.Create;
begin
  inherited Create;
  {$IFDEF DELPHI5}
  VisualControl := True;
  {$ENDIF}
end;

procedure TDataLinkTreeView.ActiveChanged;
begin
  if DataSet <> nil then
  begin
    Filter := DataSet.Filter;
    Filtered := DataSet.Filtered;
  end
  else
  begin
    Filter := '';
    Filtered := False;
  end;
  if FDBTreeView <> nil then
    FDBTreeView.DataLinkActiveChanged;
end;

procedure TDataLinkTreeView.DataSetChanged;
begin
  if (DataSet <> nil) and ((Filter <> DataSet.Filter)
    or (Filtered <> DataSet.Filtered)) then
  begin
    Filter := DataSet.Filter;
    Filtered := DataSet.Filtered;
    FDBTreeView.DataLinkActiveChanged;
  end
  else
    FDBTreeView.DataChanged;
end;

procedure TDataLinkTreeView.DataSetScrolled(Distance: Integer);
begin
  FDBTreeView.Scroll;
end;

procedure TDataLinkTreeView.RecordChanged(Field: TField);
begin
  FDBTreeView.DataLinkRecordChanged(Field);
end;

{TdxDBTreeNode}
constructor TdxDBTreeNode.Create(AOwner: TdxDBTreeNodes; Value: Variant);
var
  i: Integer;
begin
  inherited Create(AOwner.FDBTreeView.Items);
  DBTreeNodes := AOwner;

  FBkColor := clWindow;
  FColor  := DBTreeNodes.FDBTreeView.Font.Color;
  FFontStyle := DBTreeNodes.FDBTreeView.Font.Style;
  FFontName := DBTreeNodes.FDBTreeView.Font.Name;
  FIsCustomDraw := False;

  FKeyFieldValue := Value;
  DBTreeNodes.FindNearest(Value, findex);
  if findex < 0 then
    findex := 0;
  for i := fIndex to DBTreeNodes.FList.Count - 1 do
    Inc(DBTreeNodes[i].findex);
  DBTreeNodes.FList.Insert(findex, Self);
end;

destructor TdxDBTreeNode.Destroy;
var
  AKeyValue: Variant;
begin
  if not DBTreeNodes.Destroying and not (csDestroying in DBTreeNodes.FDBTreeView.ComponentState) then
  begin
    AKeyValue := FKeyFieldValue;
    with DBTreeNodes.FDBTreeView do
      if (FKeyField <> nil) and (FParentField <> nil) and not DataChangedBusy
        and not CNNotifyFlag and not CopyTreeNodeStructFlag and HandleAllocated then
      begin
        if not DBTreeNodes.FDBTreeView.DoDBAction(Self, nil, trDBDelete) then
          AKeyValue := Null;
        if (trSmartRecordLoad in Options) then
          Self.LoadChildren(True);
      end;
    DBTreeNodes.FList.Remove(Self);
  end
  else
    AKeyValue := Null;
  inherited Destroy;
  if not VarIsNull(AKeyValue)then
    DBTreeNodes.FDBTreeView.DeleteDBNode(AKeyValue);
end;

procedure TdxDBTreeNode.SetKeyFieldValue(Value: Variant);
var
  newind, i: Integer;
begin
  if FKeyFieldValue <> Value then
  begin
    FKeyFieldValue := Value;
    DBTreeNodes.FindNearest(Value, newind);
    if newind <> fIndex then
    begin
      if newind > fIndex then
        for i := fIndex + 1 to newind do
          Inc(DBTreeNodes[i].findex)
      else
        for i := newind to fIndex - 1 do
          Dec(DBTreeNodes[i].findex);
      DBTreeNodes.FList.Delete(findex);
      findex := newind;
      DBTreeNodes.FList.Insert(findex, Self);
    end;
  end;
end;

procedure TdxDBTreeNode.SetParentFieldValue(Value: Variant);
var
  DBNode: TdxDBTreeNode;
begin
  if FParentFieldValue <> Value then
  begin
    FParentFieldValue := Value;
    DBNode := DBTreeNodes.GetDBTreeNode(Value);
    Self.MoveTo(DBNode, naAddChild);
  end;
end;

procedure TdxDBTreeNode.UpdateImages;
begin
  with DBTreeNodes.FDBTreeView do
  begin
    if FKeyFieldValue <> FKeyField.Value then Exit; 
    if FImageIndexField <> nil then
    begin
      ImageIndex := 0;
      if not VarIsNull(FImageIndexField.Value) then
        ImageIndex := FImageIndexField.AsInteger;
    end;
    if FStateIndexField <> nil then
    begin
      StateIndex := -1;
      if not VarIsNull(FStateIndexField.Value) then
        StateIndex := FStateIndexField.AsInteger;
    end;
  end;
end;

procedure TdxDBTreeNode.LoadChildren(Recurse: Boolean);
var
  DataSet: TDataSet;
  Flag, FlagDis: Boolean;
  bm: TBookMark;
  ASortType: TSortType;
begin
  Flag := DBTreeNodes.FDBTreeView.DataChangedBusy;
  DBTreeNodes.FDBTreeView.DataChangedBusy := True;
  DataSet := DBTreeNodes.FDBTreeView.FDataLink.DataSet;
  FlagDis := DataSet.ControlsDisabled;
  if not flagDis then
    DataSet.DisableControls;
  bm := DataSet.GetBookmark;
  HasChildren := DBTrDataSetLocate(DataSet, DBTreeNodes.FDBTreeView.FParentFieldName, KeyFieldValue, []);
  if HasChildren then
    while not DataSet.EOF
      and VarEquals(DBTreeNodes.FDBTreeView.FParentField.Value, KeyFieldValue) do
    begin
      if DBTreeNodes.GetDBTreeNode(DBTreeNodes.FDBTreeView.FKeyField.Value) = nil then
        DBTreeNodes.RefreshRecord;
      if Recurse then
        DBTreeNodes.FDBTreeView.DBSelected.LoadChildren(True);
      DataSet.Next;
    end;
  DataSet.GotoBookmark(bm);
  DataSet.FreeBookmark(bm);
  if not flagDis then
    DataSet.EnableControls;
  DBTreeNodes.FDBTreeView.DataChangedBusy := Flag;
  ASortType := DBTreeNodes.FDBTreeView.SortType;
  if ASortType in [stText, stData, stBoth] then
    AlphaSort;
end;

procedure TdxDBTreeNode.SetChildLoaded(Value: Boolean);
var
  flag: Boolean;
begin
  if Value <> FChildLoaded then
  begin
    FChildLoaded := Value;
    if Value then
      LoadChildren(False)
    else
    begin
      flag := HasChildren;
      DeleteChildren;
      HasChildren := flag;
    end;
  end;
end;

procedure TdxDBTreeNode.SetIsCustomDraw(Value: Boolean);
begin
  if FIsCustomDraw <> Value then
  begin
    FIsCustomDraw := Value;
    if Value then
      Inc(DBTreeNodes.FCustomDrawCount)
    else
      Dec(DBTreeNodes.FCustomDrawCount);
  end;
end;

{TdxDBTreeNodes}
constructor TdxDBTreeNodes.Create(ADBTreeView: TdxDBTreeView);
begin
  FDBTreeView := ADBTreeView;
  FList := TList.Create;
  FCustomDrawCount := 0;
end;

destructor TdxDBTreeNodes.Destroy;
begin
  Destroying := True;
  Clear;
  FList.Free;
  inherited Destroy;
end;

procedure TdxDBTreeNodes.BeginRefreshRecord;
Var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    Items[i].Refreshed := False;
end;

procedure TdxDBTreeNodes.EndRefreshRecord;
Var
 i: Integer;
begin
  i := 0;
  while i < Count  do
    if not Items[i].Refreshed then
    begin
      Delete(Items[i]);
      i := 0;
    end
      else Inc(i);
end;

function TdxDBTreeNodes.FindNearest(Value: Variant; var Index: Integer): Boolean;
var
  Min, Max: LongInt;
begin
  Index := -1;
  Result := False;
  if (FList.Count = 0) or VarIsNull(Value)
    or VarFirstMoreEx(TdxDBTreeNode(FList.List[0]).FKeyFieldValue, Value) then
    Exit;

  if VarFirstMoreEx(Value, MaxKeyFieldValue) then
  begin
    Index := FList.Count;
    Exit;
  end;

  Min := 0;
  Max := FList.Count - 1;

  repeat
    if Max - Min = 1 then
    begin
      if Min = Index then Min := Max;
      if Max = Index then Max := Min;
    end;
    Index := Min + ((Max - Min) div 2);
    if VarEquals(Value, TdxDBTreeNode(FList.List[Index]).FKeyFieldValue) then
      Break;
    if VarFirstMore(Value, TdxDBTreeNode(FList.List[Index]).FKeyFieldValue) then
      Min := Index
    else
      Max := Index;
  until Min = Max;
  if VarEquals(Value, TdxDBTreeNode(FList.List[Index]).KeyFieldValue) then
    Result := True
  else
    if (Index < FList.Count - 1) and VarFirstMore(Value, TdxDBTreeNode(FList.List[Index]).FKeyFieldValue) then
      Inc(Index);
end;

function TdxDBTreeNodes.RefreshRecord: TdxDBTreeNode;
var
  DBParentNode: TdxDBTreeNode;
  AText: string;
  bm: TBookMark;
  FlagDis: Boolean;
  OldBusyFlag: Boolean;
begin
  Result := nil;
  if varIsNull(FDBTreeView.FKeyField.Value) then
    Exit;
  OldBusyFlag := FDBTreeView.DataChangedBusy;
  FDBTreeView.DataChangedBusy := True;

  AText := FDBTreeView.GetDisplayText;
  Result := GetDBTreeNode(FDBTreeView.FKeyField.Value);
  DBParentNode := GetDBTreeNode(FDBTreeView.FParentField.Value);
  if Result = nil then
  begin
    if DBParentNode = nil then
      Result := TdxDBTreeNode(FDBTreeView.Items.Add(nil, AText))
    else
      Result := TdxDBTreeNode(FDBTreeView.Items.AddChild(DBParentNode, AText));
  end
  else
  begin
    if (Result.Parent <> DBParentNode) and (Result <> DBParentNode) and
      (Result.Parent <> nil) then
    begin
      if DBParentNode <> nil then
      begin
        Result.MoveTo(DBParentNode, naAddChild);
        DBParentNode.HasChildren := True;
      end
      else
        Result.MoveTo(nil, naAdd);
    end;
    if Result.Text <> AText then
      Result.Text := AText;
  end;

  Result.FParentFieldValue := FDBTreeView.FParentField.Value;

  if trSmartRecordLoad in FDBTreeView.Options then
  begin
    if trCheckHasChildren in FDBTreeView.Options then
    begin
      FlagDis := FDBTreeView.FDataLink.DataSet.ControlsDisabled;
      if not FlagDis then
        FDBTreeView.FDataLink.DataSet.DisableControls;
      bm := FDBTreeView.FDataLink.DataSet.GetBookmark;
      Result.HasChildren := DBTrDataSetLocate(FDBTreeView.FDataLink.DataSet,
        FDBTreeView.FParentFieldName, Result.FKeyFieldValue, []);
      FDBTreeView.FDataLink.DataSet.GotoBookmark(bm);
      FDBTreeView.FDataLink.DataSet.FreeBookmark(bm);
      if not flagDis then
        FDBTreeView.FDataLink.DataSet.EnableControls;
    end
    else
      Result.HasChildren := True;
  end;

  Result.FListText := FDBTreeView.FListField.Text;
  Result.UpdateImages;
  Result.Refreshed := True;
  if Assigned(FDBTreeView.FOnRefreshNode) then
    FDBTreeView.FOnRefreshNode(FDBTreeView, Result);

  if (Count < 100) and (Count > FDBTreeView.FDataLink.BufferCount) then
    FDBTreeView.FDataLink.BufferCount := Count
  else
    FDBTreeView.FDataLink.BufferCount := 100;

  FDBTreeView.DataChangedBusy := OldBusyFlag;
end;

procedure TdxDBTreeNodes.RefreshParents;
var
  i: Integer;
  ParentNode: TTreeNode;
  Node: TTreeNode;
  List: TList;
begin
  List := TList.Create;
  try
    Node := FDBTreeView.Items.GetFirstNode;
    while Node <> nil do
    begin
      List.Add(Node);
      Node := Node.GetNextSibling;
    end;

    for i := 0 to List.Count - 1  do
      if TdxDBTreeNode(List[i]).Refreshed then
      begin
        ParentNode := GetTreeNode(TdxDBTreeNode(List[i]).ParentFieldValue);
        if (ParentNode <> nil) and (ParentNode <> TdxDBTreeNode(List[i])) then
        begin
          ParentNode.HasChildren := True;
          TdxDBTreeNode(List[i]).MoveTo(ParentNode, naAddChild);
        end;
      end;
  finally
    List.Free;
  end;
end;

procedure TdxDBTreeNodes.Clear;
begin
  with FDBTreeView do
  begin
    if HandleAllocated then
      Items.BeginUpdate;
    try
      Items.Clear;
    finally
      if HandleAllocated then
        Items.EndUpdate;
    end;
  end;
  FList.Clear;
end;

procedure TdxDBTreeNodes.Delete(ADBTreeNode: TdxDBTreeNode);
begin
 if ADBTreeNode <> nil then
   ADBTreeNode.Free;
end;

function TdxDBTreeNodes.Count: Integer;
begin
  Result := FList.Count;
end;

function TdxDBTreeNodes.GetDBNodeFromIndex(Index: Integer): TdxDBTreeNode;
begin
  if (Index > - 1) and (Index < Count) then
    Result := TdxDBTreeNode(FList[Index])
  else
    Result := nil;
end;

function TdxDBTreeNodes.GetMaxKeyFieldValue: Variant;
begin
  Result := Null;
  if FList.Count > 0 then
    Result := Items[FList.Count - 1].KeyFieldValue;
end;

function TdxDBTreeNodes.GetKeyFieldValue(Value: TTreeNode): Variant;
begin
  if Value = nil then
    Result := Null
  else
    Result := TdxDBTreeNode(Value).KeyFieldValue;
end;

function TdxDBTreeNodes.GetParentValue(Value: TTreeNode): Variant;
begin
  if Value = nil then
    Result := Null
  else
    Result := TdxDBTreeNode(Value).ParentFieldValue;
end;

function TdxDBTreeNodes.GetDBTreeNode(Value: Variant): TdxDBTreeNode;
var
  i: Integer;
begin
  if FindNearest(Value, i) then
    Result := Items[i]
  else
    Result := nil;
end;

function TdxDBTreeNodes.GetTreeNode(Value: Variant): TTreeNode;
begin
  Result := GetDBTreeNode(Value);
end;

function TdxDBTreeNodes.IndexOf(Value: TTreeNode): Integer;
var
  i: Integer;
begin
  Result := -1;
  if Value <> nil then
    for i := 0 to Count - 1 do
      if Items[i] = Value then
      begin
        Result := i;
        Break;
      end;
end;

procedure TdxDBTreeNodes.NodeChangeParent(TreeNode: TTreeNode; Value: Variant);
var
  t: TTreeNode;
  Flag: Boolean;
  dbtr: TdxDBTreeNode;
  St: string;
begin
  dbtr := TdxDBTreeNode(TreeNode);
  if dbtr = nil then
    Exit;
  if not VarEquals(dbtr.ParentFieldValue, Value) then
    dbtr.FParentFieldValue := Value;
  t := GetTreeNode(Value);
  if t = TreeNode.Parent then
    Exit;

  Flag := FDBTreeView.DataChangedBusy;
  FDBTreeView.DataChangedBusy := True;
  if (t <> nil) and (dbtr <> t) then
  begin
    TreeNode.Focused := False;
    if trSmartRecordLoad in FDBTreeView.Options then
      TdxDBTreeNode(t).ChildLoaded := True;
    t.HasChildren := True;
    TreeNode.MoveTo(t, naAddChild);
  end
  else
    TreeNode.MoveTo(nil, naAdd);
  St := fDBTreeView.GetDisplayText;
  if TreeNode.Text <> St then
    TreeNode.Text := St;
  FDBTreeView.DataChangedBusy := Flag;
  FDBTreeView.Repaint;
end;

{TdxDBTreeView}
constructor TdxDBTreeView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRootValue := NULL;
  FDataLink := TDataLinkTreeView.Create;
  FDataLink.FDBTreeView := Self;
  FDBTreeNodes := TdxDBTreeNodes.Create(Self);
  {$IFDEF DELPHI6}
    FEditInstance := Classes.MakeObjectInstance(EditWndProc);
  {$ELSE}
    FEditInstance := MakeObjectInstance(EditWndProc);
  {$ENDIF}
  CNNotifyFlag := False;

  FDisplayFields := TList.Create;
  FSeparatedSt := ' - ';
  Options := [trDBCanDelete, trDBConfirmDelete, trCanDBNavigate,
    trSmartRecordCopy, trCheckHasChildren];
  FRaiseOnError := True;
end;

destructor TdxDBTreeView.Destroy;
begin
  {$IFDEF DELPHI6}
    Classes.FreeObjectInstance(FEditInstance);
  {$ELSE}
  FreeObjectInstance(FEditInstance);
  {$ENDIF}
  FDisplayFields.Free;
  FDBTreeNodes.Free;
  FDataLink.FDBTreeView := nil;
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

function TdxDBTreeView.CanExpand(Node: TTreeNode): Boolean;
begin
  Result := inherited CanExpand(Node);
  if Result and (Node is TdxDBTreeNode) and FDataLink.Active then
    (Node as TdxDBTreeNode).ChildLoaded := True;
end;

function TdxDBTreeView.DoDBAction(DBNode1, DBNode2: TdxDBTreeNode; Action: TdxDBTreeViewAction): Boolean;
begin
  Result := True;
  if Assigned(FOnDBAction) then
    FOnDBAction(Self, DBNode1, DBNode2, Action, Result);
end;

function TdxDBTreeView.GetImageIndexField: TField;
begin
  Result := FImageIndexField;
end;

function TdxDBTreeView.GetKeyField: TField;
begin
  Result := FKeyField;
end;

function TdxDBTreeView.GetListField: TField;
begin
  Result := FListField;
end;

function TdxDBTreeView.GetParentField: TField;
begin
  Result := FParentField;
end;

function TdxDBTreeView.GetStateIndexField: TField;
begin
  Result := FStateIndexField;
end;

procedure TdxDBTreeView.GotoKeyFieldValue(Value: Variant);
var
  TreeNode: TTreeNode;
  PValue: PVariant;
  List: TList;
  bm: TBookmark;
  i: Integer;
  FlagDis, FlagValueExist: Boolean;
begin
  if VarIsNull(Value) then
    Exit;

  TreeNode := FDBTreeNodes.GetTreeNode(Value);
  if TreeNode <> nil then
  begin
    TreeNode.MakeVisible;
    Selected := TreeNode;
  end
  else
    if (trSmartRecordLoad in Options) and not DataChangedBusy then
    begin
      DataChangedBusy := True;

      if not (VarEquals(FKeyField.Value, Value)) then
        FlagValueExist := DBTrDataSetLocate(FDataLink.DataSet, FKeyFieldName, Value, [])
      else
        FlagValueExist := True;

      if FlagValueExist then
      begin
        List := TList.Create;
        bm := FDataLink.DataSet.GetBookmark;
        FlagDis := FDataLink.DataSet.ControlsDisabled;

        if not flagDis then
          FDataLink.DataSet.DisableControls;

        while (TreeNode = nil) do
          if DBTrDataSetLocate(FDBTreeNodes.FDBTreeView.FDataLink.DataSet, FKeyFieldName, FParentField.Value, [])
            and not (VarEquals(FKeyField.Value, FParentField.Value)) then
          begin
            New(PValue);
            PValue^ := FKeyField.Value;
            List.Add(PValue);
            TreeNode := FDBTreeNodes.GetTreeNode(PValue^);
          end
          else
            Break;
        if TreeNode = nil then
        begin
          DBTreeNodes.RefreshRecord;
          TreeNode := DBSelected;
          DBSelected.ChildLoaded := True;
        end;
        if TreeNode <> nil then
          for i := List.Count - 1 downto 0 do
          begin
            PValue := List[i];
            DBTrDataSetLocate(FDataLink.DataSet, FKeyFieldName, PValue^, []);
            DBSelected.ChildLoaded := True;
          end;
        GotoKeyFieldValue(Value);
        if not flagDis then
          FDataLink.DataSet.EnableControls;
        FDataLink.DataSet.GotoBookmark(bm);
        FDataLink.DataSet.FreeBookmark(bm);
        for i := 0 to List.Count - 1 do
          Dispose(PVariant(List[i]));
        List.Free;
      end;

      DataChangedBusy := False;
    end;
end;

procedure TdxDBTreeView.CreateHandle;
var
  Flag: Boolean;
begin
  Flag := DataChangedBusy;
  DataChangedBusy := True;
  inherited CreateHandle;
  DataChangedBusy := Flag;
end;

procedure TdxDBTreeView.CreateWnd;
begin
  inherited CreateWnd;
  RefreshItems;
end;

procedure TdxDBTreeView.DestroyWnd;
var
  Flag: Boolean;
begin
  Flag := DataChangedBusy;
  DataChangedBusy := True;
  DBTreeNodes.Clear;
  inherited DestroyWnd;
  DataChangedBusy := Flag;
end;

procedure TdxDBTreeView.InsertTreeNode(Node, Parent: TdxDBTreeNode);
var
  Flag, FlagDis: Boolean;
  St: string;
begin
  PostMessage(Handle, DXM_UPDATEIMAGES, Integer(Node), 0);

  Flag := DataChangedBusy;
  DataChangedBusy := True;
  Node.IsInserting := False;
  if not DoDBAction(Node, Parent, trDBInsert) then
  begin
    DataChangedBusy := flag;
    Exit;
  end;

  FlagDis := FDataLink.DataSet.ControlsDisabled;

  if not flagDis then
     FdataLink.DataSet.DisableControls;

  try
    if Parent <> nil then
    begin
       if trSmartRecordLoad in FOptions then
         Parent.ChildLoaded := True;
       Node.FParentFieldValue := Parent.KeyFieldValue;
    end
    else
    begin
      if not VarIsNull(FRootValue) then
        Node.FParentFieldValue := FRootValue
      else
        Node.FParentFieldValue := Node.FKeyFieldValue;
    end;
    FdataLink.DataSet.Append;
    FParentField.Value :=  node.FParentFieldValue;
    if (FListField <> FKeyField) and (FListField <> FParentField) then
      FListField.Text :=  Node.Text;
      if FListField.IsNull then
        FListField.Text := ' ';
      if not (FKeyField is TAutoIncField) then
      begin
        if VarIsNull(FKeyField.Value) then
          FKeyField.Value :=  Node.FKeyFieldValue
        else
          Node.SetKeyFieldValue(FKeyField.Value);
      end;
      FDataLink.DataSet.Post;
      if FKeyField is TAutoIncField then
        Node.SetKeyFieldValue(FKeyField.Value);
      St := GetDisplayText;
      if Node.Text <> St then
        Node.Text := St;

      if Assigned(FAddNewItem) then
        FAddNewItem(nil, Node);
      if not flagDis then
        FDataLink.DataSet.EnableControls;
      DataChangedBusy := Flag;
      Selected := Node;
      Node.MakeVisible;
   except
     DataChangedBusy := True;
     {$IFNDEF DELPHI5}
     TreeView_DeleteItem(Handle, Node.ItemId);
     DataChangedBusy := Flag;
     {$ENDIF}
     if not flagDis then
       FDataLink.DataSet.EnableControls;
     {$IFDEF DELPHI5}
     DataChangedBusy := Flag;
     {$ENDIF}
    if Assigned(FOnInsertNodeError) then
       FOnInsertNodeError(Self)
     else
       if FRaiseOnError then
         raise;
   end;
end;

procedure TdxDBTreeView.SetNewTreeNodeParent(Node, NewParent: TdxDBTreeNode);
var
  Flag, FlagDis: Boolean;
  KeyValue: Variant;
  St: string;
begin
  Flag := DataChangedBusy;
  DataChangedBusy := True;

  if not DoDBAction(Node, NewParent, trDBChangeParent) then
  begin
    DataChangedBusy := flag;
    Exit;
  end;

  FlagDis := FDataLink.DataSet.ControlsDisabled;
  if not flagDis then
    FdataLink.DataSet.DisableControls;
  if NewParent <> nil then
    node.FParentFieldValue := NewParent.FKeyFieldValue
  else
  begin
    if (trSmartRecordLoad in FOptions) and not VarIsNull(FRootValue) then
      Node.FParentFieldValue := FRootValue
    else
      Node.FParentFieldValue := Node.FKeyFieldValue;
  end;
  if not VarEquals(FKeyField.Value, Node.FKeyFieldValue) then
  begin
    KeyValue := FKeyField.Value;
    DBTrDataSetLocate(FDataLink.DataSet, FKeyFieldName, Node.FKeyFieldValue, []);
  end
  else
    KeyValue := NULL;
  FDataLink.DataSet.Edit;
  FParentField.Value := Node.FParentFieldValue;
  FdataLink.DataSet.Post;

  St := GetDisplayText;
  if Node.Text <> St then
    Node.Text := St;

  if not VarIsNULL(KeyValue) then
    DBTrDataSetLocate(FDataLink.DataSet, FKeyFieldName, KeyValue, []);
  if not flagDis then
    FDataLink.DataSet.EnableControls;
  DataChangedBusy := Flag;
end;

function TdxDBTreeView.CreateNode: TTreeNode;
begin
  if (FKeyField <> nil) and (FParentField <> nil) then
  begin
    if DataChangedBusy then
      Result := TdxDBTreeNode.Create(FDBTreeNodes, FKeyField.Value)
   else
   begin
     Result := TdxDBTreeNode.Create(FDBTreeNodes, GetNextMaxKeyValue);
     TdxDBTreeNode(Result).IsInserting := True;
   end;
   if (Result <> nil) and (SelectedIndex <> -1) then
     Result.SelectedIndex := SelectedIndex;
  end
  else
    Result := nil;
end;

procedure TdxDBTreeView.Change(Node: TTreeNode);
var
  V: Variant;
  tr, tr1: TTreenode;
  Flag: Boolean;
begin
  if Node = nil then
    Exit;
  if DataChangedBusy then
  begin
    inherited;
    Exit;
  end;
  DataChangedBusy := True;
  if FKeyField <> nil then
  begin
    V := FDBTreeNodes.GetKeyFieldValue(Node);
    if not VarIsNull(V) and (VarType(V) <> varEmpty)
      and not VarEquals(FKeyField.Value, V)
      and (dsInsert <> FKeyField.DataSet.State)
      and not ((FdataLink.DataSet.EOF) and (FdataLink.DataSet.BOF)) then
    begin
      Flag := FDataLink.DataSet.State = dsEdit;
      tr1 := nil;
      if Flag then
      begin
        tr := DBTreeNodes.GetTreeNode(FKeyField.Value);
        if tr <> Selected then
        begin
          SendMessage(Handle, WM_SETREDRAW, Integer(False), 0);
          tr1 := Selected;
          Selected := tr;
        end
        else
          Flag := False;
      end;
      try
        DBTrDataSetLocate(FdataLink.DataSet, FKeyFieldName, V, []);
      except
      end;
      if Flag then
      begin
        Selected := tr1;
        SendMessage(Handle, WM_SETREDRAW, Integer(True), 0);
      end;
    end;
  end;
  DataChangedBusy := False;
  inherited;
end;

procedure TdxDBTreeView.Edit(const Item: TTVItem);
var
  Flag: Boolean;
begin
  inherited;
  if (FListField <> nil) and (FDisplayFields.Count > 0) then
  begin
    Flag := DataChangedBusy;
    DataChangedBusy := True;
    if (not ReadOnly) and (FListField.DataSet <> nil) and (Selected <> nil)
      and ((FListField.DataSet.State = dsEdit) or (FListField.DataSet.State = dsInsert)) and
      (FListField.Text <> Selected.Text) then
      FListField.Text := Selected.Text
    else
      if Selected.Text <> FListField.Text then
        Selected.Text := FListField.Text;
    if (Selected <> nil) and (Selected.Text <> GetDisplayText) then
      Selected.Text := GetDisplayText;
    DataChangedBusy := Flag;
  end;
end;

procedure TdxDBTreeView.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and (AComponent = DataSource) then
    DataSource := nil;
end;

procedure TdxDBTreeView.RefreshItems;
var
  bm: TBookMark;
  i: Integer;
  FlagDis: Boolean;
  OldSortType: TSortType;
begin
  DataChangedBusy := True;

  if (FKeyField <> nil) and (FListField <> nil) and (FParentField <> nil) then
  begin
    Items.BeginUpdate;
    DBTreeNodes.BeginRefreshRecord;
    OldSortType := SortType;
    SortType := stNone;
    FlagDis := FDataLink.DataSet.ControlsDisabled;
    if not flagDis then
      FDataLink.DataSet.DisableControls;
    bm := FDataLink.DataSet.GetBookmark;
    if not (trSmartRecordLoad in Options) then
    begin
      i := mrNo;
      if (csDesigning in ComponentState) and (FDataLink.DataSet.RecordCount > 999) then
        i :=  MessageDlg(dxDBTreeViewSmartLoadS, mtConfirmation, [mbYes, mbNo], 0);
      if i = mrNo then
      begin
        FDataLink.DataSet.First;
        while not FDataLink.DataSet.EOF do
        begin
          FDBTreeNodes.RefreshRecord;
          FDataLink.DataSet.Next;
        end;
      end;
    end
    else
    begin
      if FDBTreeNodes.Count > 0 then
      begin
        for i := 0 to FDBTreeNodes.Count - 1 do
        begin
          FDBTreeNodes[i].FChildLoaded := False;
          if not (VarEquals(FKeyField.Value, FDBTreeNodes[i].FKeyFieldValue)) then
            DBTrDataSetLocate(FDataLink.DataSet, FKeyFieldName, FDBTreeNodes[i].FKeyFieldValue, []);
          FDBTreeNodes.RefreshRecord;
          FDataLink.DataSet.Next;
        end;
      end
      else
        FDataLink.DataSet.First;
        if DBTrDataSetLocate(FDataLink.DataSet, FParentFieldName, FRootValue, []) then
          while (not FDataLink.DataSet.EOF) and VarEquals(FParentField.Value, FRootValue) do begin
            FDBTreeNodes.RefreshRecord;
            FDataLink.DataSet.Next;
         end;
    end;
    FDataLink.DataSet.GotoBookmark(bm);
    FDataLink.DataSet.FreeBookmark(bm);
    if not flagDis then
      FDataLink.DataSet.EnableControls;
    FDBTreeNodes.RefreshParents;
    DBTreeNodes.EndRefreshRecord;
    Items.EndUpdate;
    SortType := OldSortType;
  end
  else
    DBTreeNodes.Clear;

  Scroll;
  DataChangedBusy := False;
end;

procedure TdxDBTreeView.AssignFields;

  function IsIntegerField(AField: TField): Boolean;
  begin
    Result := AField.DataType in [ftSmallint, ftInteger, ftWord, ftFloat, ftCurrency, ftAutoInc];
  end;
  
begin
  FDisplayFields.Clear;
  if FDataLink.Active then
  begin
    if FKeyFieldName <> '' then
      FKeyField := FDataLink.DataSet.FieldByName(FKeyFieldName);
    if FListFieldName <> '' then
      FListField := FDataLink.DataSet.FieldByName(FListFieldName);
    if FParentFieldName <> '' then
      FParentField := FDataLink.DataSet.FieldByName(FParentFieldName);
    if FImageIndexFieldName <> '' then
    begin
      FImageIndexField := FDataLink.DataSet.FieldByName(FImageIndexFieldName);
      if (FImageIndexField <> nil) and not IsIntegerField(FImageIndexField) then
        FImageIndexField := nil;
    end;
    if FStateIndexFieldName <> '' then
    begin
      FStateIndexField := FDataLink.DataSet.FieldByName(FStateIndexFieldName);
      if (FStateIndexField <> nil) and not IsIntegerField(FStateIndexField) then
        FStateIndexField := nil;
    end;

    FDataLink.DataSet.GetFieldList(FDisplayFields, FDisplayFieldName);
  end;
end;

procedure TdxDBTreeView.DataLinkActiveChanged;
begin
  FKeyField := nil;
  FListField := nil;
  FParentField := nil;
  FImageIndexField := nil;
  FStateIndexField := nil;

  FDisplayFields.Clear;
  AssignFields;
  if (FKeyField <> nil) and not VarIsNull(FRootValue) then
    case FKeyField.DataType of
      ftSmallint: VarCast(FRootValue, FRootValue,  varSmallint);
      ftInteger, ftWord, ftAutoInc: VarCast(FRootValue, FRootValue,  varInteger);
      ftFloat, ftCurrency: VarCast(FRootValue, FRootValue,  varDouble);
    else
      VarCast(FRootValue, FRootValue,  varString);
    end;

  if HandleAllocated then
    RefreshItems;
end;

procedure TdxDBTreeView.DataLinkRecordChanged(Field: TField);
begin
  if (Field <> nil) and (Field.DataSet <> nil) then
    case Field.DataSet.State of
      dsEdit: RecordEdit(Field);
      dsInsert: RecordInsert(Field);
    end;
end;

function TdxDBTreeView.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

{$IFNDEF DELPHI6}
function TdxDBTreeView.GetRootValue: string;
begin
  if VarIsNull(FRootValue) then
    Result := ''
  else
    Result := string(FRootValue);
end;
{$ENDIF}

function TdxDBTreeView.GetSeletectedDBTreeNode: TdxDBTreeNode;
begin
  Result := nil;
  if (FKeyField <> nil) and (FKeyField.Value <> NULL) then
    Result := FDBTreeNodes.GetDBTreeNode(FKeyField.Value);
end;

procedure TdxDBTreeView.Scroll;
begin
  if not (trCanDBNavigate in Options) then
    Exit;
  if FKeyField <> nil then
    GotoKeyFieldValue(FKeyField.Value);
end;

procedure TdxDBTreeView.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Value <> nil then
    Value.FreeNotification(Self);
end;

procedure TdxDBTreeView.SetDisplayFieldName(const Value: string);
begin
  if FDisplayFieldName <> Value then
  begin
    FDisplayFieldName := Value;
    DataLinkActiveChanged;
  end;
end;

procedure TdxDBTreeView.SetImageIndexFieldName(const Value: string);
begin
  if FImageIndexFieldName <> Value then
  begin
    FImageIndexFieldName := Value;
    DataLinkActiveChanged;
  end;
end;

procedure TdxDBTreeView.SetKeyFieldName(const Value: string);
begin
  if FKeyFieldName <> Value then
  begin
    FKeyFieldName := Value;
    DataLinkActiveChanged;
  end;
end;

procedure TdxDBTreeView.SetListFieldName(const Value: string);
begin
  if FListFieldName <> Value then
  begin
    FListFieldName := Value;
    DataLinkActiveChanged;
  end;
end;

procedure TdxDBTreeView.SetStateIndexFieldName(const Value: string);
begin
  if FStateIndexFieldName <> Value then
  begin
    FStateIndexFieldName := Value;
    DataLinkActiveChanged;
  end;
end;

procedure TdxDBTreeView.SetOptions(const Value: TdxDBTreeViewOptions);
begin
  if Value <> FOptions then
  begin
    FOptions := Value;
    inherited Options := [];
    if trDBCanDelete in FOptions then
      inherited Options := inherited Options + [trCanDelete];
    if trDBConfirmDelete in FOptions then
      inherited Options := inherited Options + [trConfirmDelete];
    RefreshItems;
  end;
end;

procedure TdxDBTreeView.SetParentFieldName(const Value: string);
begin
  if FParentFieldName <> Value then
  begin
    FParentFieldName := Value;
    DataLinkActiveChanged;
  end;
end;

procedure TdxDBTreeView.SetRootValue(const Value: {$IFNDEF DELPHI6}string{$ELSE}Variant{$ENDIF});
var
{$IFNDEF DELPHI6}
  V: Variant;
{$ENDIF}
  OldFlag: Boolean;
begin
{$IFNDEF DELPHI6}
  V := Value;
  if not VarIsNull(FRootValue) then
    try
      FRootValue := VarAsType(V,  VarType(FRootValue))
    except
      FRootValue := Null;
    end
  else
    FRootValue := V;
{$ELSE}
  FRootValue := Value;
{$ENDIF}
  if trSmartRecordLoad in FOptions then
  begin
    OldFlag := DataChangedBusy;
    DataChangedBusy := True;
    Items.Clear;
    DataLinkActiveChanged;
    DataChangedBusy := OldFlag;
  end;
end;

procedure TdxDBTreeView.SetSeparatedSt(const Value: string);
begin
  if FSeparatedSt <> Value then
  begin
    FSeparatedSt := Value;
    if FDisplayFields.Count > 0 then
      DataLinkActiveChanged;
  end;
end;

procedure TdxDBTreeView.DataChanged;
begin
  if DataChangedBusy or not HandleAllocated or (FDataLink.DataSet.State = dsInsert)
    or (FDataLink.DataSet.State = dsEdit) then
    Exit;
  if IsEditing and (Selected <> nil) then
    Selected.EndEdit(True);
  AssignFields;
  RefreshItems;
  Scroll;
end;

function TdxDBTreeView.GetDisplayText: string;
var
  i: Integer;
begin
  Result := '';
  if FDisplayFields.Count > 0 then
  begin
    for i := 0 to FDisplayFields.Count - 1 do
    begin
      if i > 0 then
        Result := Result + FSeparatedSt;
      Result := Result + TField(FDisplayFields[i]).Text;
    end;
  end
  else
    if FListField <> nil then
      Result := FListField.Text;
  if Assigned(FOnSetDisplayItemText) then
    FOnSetDisplayItemText(Self, Result);
end;

var
  RecordEditFlag: Boolean;

procedure TdxDBTreeView.RecordEdit(Field: TField);
var
  TreeNode: TTreeNode;
  V: Variant;
  flag: Boolean;

  procedure RepaintNode(ANode: TTreeNode);
  var
    R: TRect;
  begin
    if HandleAllocated and (ANode <> nil) and ANode.IsVisible then
    begin
      R := ANode.DisplayRect(False);
      InvalidateRect(Handle, @R, False);
    end;
  end;

begin
  if RecordEditFlag then Exit;
  if FKeyField <> nil then
  begin
    TreeNode := Selected;
    if TreeNode = nil then
    Exit;

    if (Field = FListField) and (TreeNode.Text <> Field.Text ) then
      TreeNode.Text := Field.Text;

    if FImageIndexField = Field then
    begin
      if not VarIsNull(FImageIndexField.Value) then
        TreeNode.ImageIndex := FImageIndexField.AsInteger
      else
        TreeNode.ImageIndex := -1;
      RepaintNode(TreeNode);
    end;

    if FStateIndexField = Field then
    begin
      if not VarIsNull(FStateIndexField.Value) then
        TreeNode.StateIndex := FStateIndexField.AsInteger
      else
        TreeNode.StateIndex := -1;
      RepaintNode(TreeNode);
    end;

    if Field = FParentField then
    begin
      V := FDBTreeNodes.GetParentValue(TreeNode);
      if not VarIsNull(Field.Value) and not VarIsNull(V) and
        not VarEquals(Field.Value, V) then
      begin
        try
          if trSmartRecordLoad in FOptions then
          begin
            RecordEditFlag := True;
            flag := DataChangedBusy;
            DataChangedBusy := True;
            FDataLink.DataSet.Post;
            DataChangedBusy := flag;
          end;
          FDBTreeNodes.NodeChangeParent(TreeNode, Field.Value);
        except
          Field.Value := V;
        end;
        RecordEditFlag := False;
      end;
    end;
  end;
end;

procedure TdxDBTreeView.RecordInsert(Field: TField);
var
  DBTreeNode: TdxDBTreeNode;
begin
  if (FKeyField <> nil) and (FKeyField.Value <> NULL) then
  begin
    if not DataChangedBusy then
      FDBTreeNodes.RefreshRecord;
    DBTreeNode := DBSelected;
    if DBTreeNode <> nil then
    begin
      Selected := DBTreeNode;
      if Selected <> nil then
        Selected.MakeVisible;
     end;
     if (DBTreeNode <> nil) and (DBTreeNode.ParentFieldValue <> NULL) and
       Assigned(FAddNewItem) then
       FAddNewItem(nil, DBTreeNode);
  end;
end;

procedure TdxDBTreeView.FrameSelectedItem;
var
  Rect: TRect;
  DC: HDC;
  wnd: HWND;
  C1, C2, OldColor: TColor;
  AHandle: HFont;
  ASize: TSize;
const
  TextOffset = 2;
begin
  if not Focused and not DataChangedBusy and (Selected <> nil) then
  begin
    if HandleAllocated then
       DoCustomDraw(Selected, Font, C1, C2);
    TreeView_GetItemRect(Selected.Handle, Selected.ItemId, Rect, true);
    Wnd := handle;
    DC := GetDeviceContext(Wnd);
    AHandle := SelectObject(DC, Font.Handle);
    GetTextExtentPoint(DC, PChar(Selected.Text), Length(Selected.Text), ASize);
    SelectObject(DC, AHandle);
    Rect.Right := Rect.Left + ASize.cx + TextOffset * 2;
    OldColor := Brush.Color;
    Brush.Color := Font.Color;
    FrameRect(DC, Rect, Brush.Handle);
    Brush.Color := OldColor;
    ReleaseDC(Wnd, DC);
  end;
end;

procedure TdxDBTreeView.DeleteDBNode(AKeyValue: Variant);
var
  flag, FlagDis: Boolean;
  AParentForm: TCustomForm;
begin
  if (FKeyField = nil) or (FParentField = nil) or DataChangedBusy or CNNotifyFlag
    or CopyTreeNodeStructFlag or not HandleAllocated then
    Exit;
  AParentForm := GetParentForm(Self);
  if (AParentForm <> nil) and (csDestroying in AParentForm.ComponentState) then
    Exit;

  FlagDis := FDataLink.DataSet.ControlsDisabled;
  if not flagDis then
    FDataLink.DataSet.DisableControls;
  if not (FDataLink.DataSet.EOF and FDataLink.DataSet.BOF) then
  begin
    try
      flag := DBTrDataSetLocate(FdataLink.DataSet, FKeyFieldName, AKeyValue, []);
    except
      flag := False;
    end;
    if flag and VarEquals(AKeyValue, FKeyField.Value) then
      FDataLink.DataSet.Delete;
  end;

  DataChangedBusy := True;
  if not flagDis then
    FDataLink.DataSet.EnableControls;
  DataChangedBusy := False;
  Change(Selected);
end;

procedure TdxDBTreeView.DoCustomDraw(TreeNode: TTreeNode; AFont: TFont;
  var AColor, ABkColor: TColor);
begin
  if Assigned(OnCustomDraw) then
    inherited DoCustomDraw(TreeNode, AFont, AColor, ABkColor)
  else
  begin
    if TdxDBTreeNode(TreeNode).IsCustomDraw then
      with TdxDBTreeNode(TreeNode) do
      begin
        AFont.Style := FontStyle;
        AFont.Name := FontName;
        AColor := Color;
        ABkColor := BkColor;
      end;
  end;
end;

procedure TdxDBTreeView.GetNodeStructure(TreeNode: TTreeNode; List: TList);
begin
  if (trSmartRecordLoad in FOptions) and CopyTreeNodeStructFlag then
    TdxDBTreeNode(TreeNode).LoadChildren(True);
  inherited GetNodeStructure(TreeNode, List);
end;

type
  TInsertFieldStruct = class
  private
    Buffer: Pointer;
    {$IFNDEF DELPHI3}
    Stream: TBlobStream;
    {$ELSE}
    Stream: TStream;
    {$ENDIF}
    FieldName: string;
  public
    constructor Create(Size: Integer);
    destructor Destroy; override;
  end;

constructor TInsertFieldStruct.Create(Size: Integer);
begin
  inherited Create;
  GetMem(Buffer, Size);
end;

destructor TInsertFieldStruct.Destroy;
begin
  FreeMem(Buffer);
  if Stream <> nil then
    Stream.Free;
  inherited Destroy;
end;

function TdxDBTreeView.GetNextMaxKeyValue: Variant;
begin
  Result := DBTreeNodes.MaxKeyFieldValue;
  if Assigned(FCreateNewKeyValue) then
    FCreateNewKeyValue(nil, Result)
  else
    try
      if not VarIsNULL(Result) then
        Result := Result + 1 
      else
        Result := 0;
    except
    end;
end;

procedure TdxDBTreeView.InsertTreeNodeStructure(ListS, ListD: TList; Flag: Boolean);
var
  i, index: Integer;
  MaxKeyFieldValue: Variant;
  tr, tr1: TTreeNode;
  dbtr, dbtr1: TdxDBTreeNode;
  ifs: TInsertFieldStruct;
  List: TList;
  FlagBuzy, FlagDis: Boolean;
  sDBTreeView: TdxDBTreeView;
  sDBTreeKeyValue: Variant;
  FCopiedFields: TList;
  {$IFDEF DELPHI3}
  AStream: TStream;
  {$ENDIF}

  function IsBlobField(AField: TField): Boolean;
  begin
    Result := AField is TBlobField;
  end;

begin
  if (ListS.Count > 0) and (TTreeNode(ListS[0]).TreeView is TdxDBTreeView) then
    sDBTreeView := TdxDBTreeView(TTreeNode(ListS[0]).TreeView)
  else
    sDBTreeView := nil;
  FlagBuzy := DataChangedBusy;
  DataChangedBusy := True;

  if not DoDBAction(TdxDBTreeNode(ListS[0]), TdxDBTreeNode(ListD[0]), trDBMove) then
  begin
    DataChangedBusy := FlagBuzy;
    Exit;
  end;

  FlagDis := FDataLink.DataSet.ControlsDisabled;
  if not flagDis then
    FdataLink.DataSet.DisableControls;
  if (ListD.Count > 0) and (trSmartRecordLoad in FOptions) then
  begin
    tr := TTreeNode(ListD[0]);
    if (tr <> nil) and (tr.Parent <> nil) then
      TdxDBTreeNode(tr.Parent).ChildLoaded := True;
  end;
  sDBTreeKeyValue := varNull;
  FCopiedFields := TList.Create;
  if Flag and (trSmartRecordCopy in FOptions) and (ListS.Count > 0) and (sDBTreeView <> nil) then
  begin
    sDBTreeKeyValue := sDBTreeView.FKeyField.Value;
    for index := 0 to sDBTreeView.FDataLink.DataSet.FieldCount - 1 do
      if (CompareText(sDBTreeView.FDataLink.DataSet.Fields[index].FieldName, FKeyFieldName) <> 0)
        and (CompareText(sDBTreeView.FDataLink.DataSet.Fields[index].FieldName, FParentFieldName) <> 0)
        and (FDataLink.DataSet.FindField(sDBTreeView.FDataLink.DataSet.Fields[index].FieldName) <> nil) then
        FCopiedFields.Add(sDBTreeView.FDataLink.DataSet.Fields[index]);
  end;

  MaxKeyFieldValue := DBTreeNodes.MaxKeyFieldValue;
  for i := 0 to ListD.Count - 1 do
  begin
    tr := TTreeNode(ListD[i]);
    dbtr := TdxDBTreeNode(TTreeNode(ListD[i]));
    if tr.Parent <> nil then
      dbtr.FParentFieldValue := DBTreeNodes.GetKeyFieldValue(tr.Parent)
    else
      if not VarIsNull(FRootValue) or (trSmartRecordLoad in FOptions) then
        dbtr.FParentFieldValue := FRootValue
      else
        dbtr.FParentFieldValue := dbtr.FKeyFieldValue;
    dbtr := TdxDBTreeNode(tr);
    if (FDisplayFields.Count > 0) and (sDBTreeView = Self) then
    begin
      tr1 := TTreeNode(ListS[i]);
      if tr1 <> nil then
      begin
        DBTrDataSetLocate(FDataLink.DataSet, FKeyFieldName, TdxDBTreeNode(tr1).FKeyFieldValue, []);
        tr.Text := FListField.Text;
      end;
    end;
    FDataLink.DataSet.Append;
    FParentField.Value :=  dbtr.FParentFieldValue;
    if (FListField <> FKeyField) and (FListField <> FParentField) then
      FListField.Value :=  tr.Text;

    if FKeyField.DataType <> ftAutoInc then
      FKeyField.Value :=  dbtr.FKeyFieldValue;
    FDataLink.DataSet.Post;
    if (FKeyField.DataType = ftAutoInc) and not FKeyField.IsNull then
      dbtr.FKeyFieldValue := FKeyField.Value;

    if FCopiedFields.Count > 0 then
    begin
      tr1 := TTreeNode(ListS[i]);
      List := TList.Create;
      if tr1 <> nil then
      begin
        dbtr1 := TdxDBTreeNode(tr1);
        if sDBTreeView <> Self then
          sDBTreeView.DataChangedBusy := True;
        DBTrDataSetLocate(sDBTreeView.FDataLink.DataSet, sDBTreeView.FKeyFieldName,
          dbtr1.FKeyFieldValue, []);
        if sDBTreeView <> Self then
          sDBTreeView.DataChangedBusy := False;
        for index := 0 to FCopiedFields.Count - 1 do
        begin
          ifs := TInsertFieldStruct.Create(TField(FCopiedFields[Index]).DataSize + 1);
          try
            ifs.Stream := nil;
            if IsBlobField(TField(FCopiedFields[Index])) then
            begin
              {$IFNDEF DELPHI3}
              ifs.Stream := TBlobStream.Create(TBlobField(FCopiedFields[Index]), bmRead);
              {$ELSE}
              AStream :=  sDBTreeView.FDataLink.DataSet.CreateBlobStream(TField(FCopiedFields[Index]), bmRead);
              ifs.Stream := TMemoryStream.Create;
              ifs.Stream.CopyFrom(AStream, AStream.Size);
              AStream.Free;
              {$ENDIF}
              ifs.FieldName := TField(FCopiedFields[Index]).FieldName;
              List.Add(ifs);
            end
            else
              if TField(FCopiedFields[Index]).GetData(ifs.Buffer) then
              begin
                ifs.FieldName := TField(FCopiedFields[Index]).FieldName;
                List.Add(ifs)
              end
              else
                ifs.Free;
          except
            ifs.Free;
          end;
        end;
      end;

      if List.Count > 0 then
        try
          DBTrDataSetLocate(FDataLink.DataSet, FKeyFieldName, dbtr.FKeyFieldValue, []);
          FDataLink.DataSet.Edit;
          for index := 0 to List.Count - 1 do
          begin
            ifs := TInsertFieldStruct(List[index]);
            try
              if ifs.Stream <> nil then
              {$IFNDEF DELPHI3}
                TBlobField(FDataLink.DataSet.FindField(ifs.FieldName)).LoadFromStream(ifs.Stream)
              {$ELSE}
              begin
                AStream := FDataLink.DataSet.CreateBlobStream(FDataLink.DataSet.FindField(ifs.FieldName), bmWrite);
                ifs.Stream.Position := 0;
                AStream.CopyFrom(ifs.Stream, ifs.Stream.Size);
                AStream.Free;
              end
              {$ENDIF}
              else FDataLink.DataSet.FindField(ifs.FieldName).SetData(ifs.Buffer);
            except
            end;
          end;
          FDataLink.DataSet.Post;
        except
        end;
      while List.Count > 0 do
      begin
        ifs := TInsertFieldStruct(List[0]);
        List.Remove(ifs);
        ifs.Free;
      end;
      List.Free;
    end;

    tr.Text := GetDisplayText;
    if Assigned(FAddNewItem) then
      FAddNewItem(nil, dbtr);
  end;
  tr := TTreeNode(ListD[0]);
  if (tr <> nil) and (tr.Parent <> nil) then
    DBTrDataSetLocate(FDataLink.DataSet, FKeyFieldName,
      TdxDBTreeNode(tr.Parent).FKeyFieldValue, []);

  if (sDBTreeView <> nil) and (sDBTreeView <> Self) then
  begin
    sDBTreeView.DataChangedBusy := True;
    DBTrDataSetLocate(sDBTreeView.FDataLink.DataSet, sDBTreeView.FKeyFieldName,
      sDBTreeKeyValue, []);
    sDBTreeView.DataChangedBusy := False;
  end;

  FCopiedFields.Free;

  if not flagDis then
    FdataLink.DataSet.EnableControls;
  DataChangedBusy := FlagBuzy;
end;

function TdxDBTreeView.IsCustomDraw: Boolean;
begin
  Result := (inherited IsCustomDraw) or (DBTreeNodes.FCustomDrawCount > 0);
end;

function TdxDBTreeView.GetListItemText(TreeNode: TTreeNode): string;
begin
  if FDisplayFields.Count > 0 then
    Result := TdxDBTreeNode(TreeNode).FListText
  else
    Result := inherited GetListItemText(TreeNode);
end;

procedure TdxDBTreeView.DoCNNotify(var Message: TWMNotify);
var
  TreeNode: TTreeNode;
  dbtr: TdxDBTreeNode;
  OldCNNotifyFlag: Boolean;
begin
  if trSmartRecordLoad in FOptions then
    with Message.NMHdr^, PNMTreeView(Pointer(Message.NMHdr))^do
    begin
      if (code = TVN_ITEMEXPANDING) and (Action = TVE_EXPAND) then
      begin
        dbtr := TdxDBTreeNode(GetNodeFromItem(ItemNew));
        if dbtr <> nil then
        begin
          if CanExpand(dbtr) then
            dbtr.ChildLoaded := True
          else
            Message.Result := 1;
        end;
        Exit;
      end;
      if (code = TVN_ITEMEXPANDED) and (action = TVE_COLLAPSE) then
      begin
        inherited;
        dbtr := TdxDBTreeNode(GetNodeFromItem(ItemNew));
        if dbtr <> nil then
        begin
          OldCNNotifyFlag := CNNotifyFlag;
          CNNotifyFlag := True;
          dbtr.ChildLoaded := False;
          CNNotifyFlag := OldCNNotifyFlag;
        end;
        Exit;
      end;
    end;
    
  with Message.NMHdr^ do
  begin
    if (code = TVN_BEGINLABELEDIT) and (FListField <> nil) then
    begin
      with PTVDispInfo(Pointer(Message.NMHdr))^do
        TreeNode := GetNodeFromItem(item);
      if TreeNode.Text <> FListField.Text then
      begin
        TreeNode.Text := FListField.Text;
        SendMessage(TreeView_GetEditControl(handle), WM_SETTEXT, 0, Integer(PChar(TreeNode.Text)));
      end;
      if FDataLink.DataSet.CanModify then
        FDataLink.Edit;
      FEditHandle := TreeView_GetEditControl(Handle);
      SendMessage(FEditHandle, EM_SETLIMITTEXT, FListField.DisplayWidth, 0);
      FDefEditProc := Pointer(GetWindowLong(FEditHandle, GWL_WNDPROC));
      SetWindowLong(FEditHandle, GWL_WNDPROC, Integer(FEditInstance));
    end;
  end;
end;

procedure TdxDBTreeView.DoVMInsertItem(var Message: TMessage);
var
  tn, oldtnp, newtnp: TTreeNode;
  str: TTVInsertStruct;
begin
  if not DataChangedBusy then
  begin
    tn := Items.GetNode(HTreeItem(Message.Result));
    if tn <> nil then
    begin
      str := PTVInsertStruct(Message.lParam)^;
      newtnp := Items.GetNode(str.hparent);
      if TdxDBTreeNode(tn).IsInserting then
      begin
        if not CopyTreeNodeStructFlag then
          InsertTreeNode(TdxDBTreeNode(tn), TdxDBTreeNode(newtnp));
        TdxDBTreeNode(tn).IsInserting := False;
      end
      else
      begin
        oldtnp := DBTreeNodes.GetTreeNode(TdxDBTreeNode(tn).FParentFieldValue);
        if newtnp <> oldtnp then
          SetNewTreeNodeParent(TdxDBTreeNode(tn), TdxDBTreeNode(newtnp));
      end;
    end;
  end;
end;

procedure TdxDBTreeView.DoVMSelectItem(var Message: TMessage);
begin
  FrameSelectedItem;
end;

procedure TdxDBTreeView.DoVMSetItem(var Message: TMessage);
var
  tr: TTreeNode;
  FlagDis: Boolean;
begin
  if  not DataChangedBusy and not CopyTreeNodeStructFlag and not IsEditing
    and (PTVITEM(Message.lparam)^.mask and TVIF_TEXT = 1)
    and (PTVITEM(Message.lparam)^.hItem <> nil)
    and (not ReadOnly) and (FListField <> nil) and (FDisplayFields.Count = 0)
    and (FDataLink.DataSet.CanModify) and not FListField.ReadOnly then
  begin
    DataChangedBusy := True;
    FlagDis := FDataLink.DataSet.ControlsDisabled;
    if not FlagDis then
      FDataLink.DataSet.DisableControls;
    SendMessage(Handle, WM_SETREDRAW, Integer(False), 0);
    DataChangedBusy := False;
    tr := Selected;
    TreeView_SelectItem(Handle, PTVITEM(Message.lparam)^.hItem);
    DataChangedBusy := True;
    if (FListField.Text <> Selected.Text)
      and DoDBAction(TdxDBTreeNode(selected), nil, trDBChangeText) then
    begin
      FDataLink.DataSet.Edit;
      FListField.Text := Selected.Text;
      FDataLink.DataSet.Post;
    end;
    Selected := tr;
    SendMessage(Handle, WM_SETREDRAW, Integer(True), 0);
    if not FlagDis then
      FDataLink.DataSet.EnableControls;
    DataChangedBusy := False;
  end;
end;

procedure TdxDBTreeView.DoVMExpand(var Message: TMessage);
begin
  if (Message.wParam = TVE_COLLAPSE) and (Selected <> nil) then
    Change(Selected);
end;

procedure TdxDBTreeView.DoWMPaint(var Message: TMessage);
begin
  if not Focused and (Selected <> nil) and (Selected.IsVisible) and not IsEditing then
    FrameSelectedItem;
end;

procedure TdxDBTreeView.CNNotify(var Message: TWMNotify);
begin
  DoCNNotify(Message);
  inherited;
end;

procedure TdxDBTreeView.VM_INSERTITEM(var Message: TMessage);
begin
  inherited;
  DoVMInsertItem(Message);
end;

procedure TdxDBTreeView.VM_SELECTITEM(var Message: TMessage);
begin
  inherited;
  DoVMSelectItem(Message);
end;

procedure TdxDBTreeView.VM_SETITEM(var Message: TMessage);
begin
  inherited;
  DoVMSetItem(Message);
end;

procedure TdxDBTreeView.VM_EXPAND(var Message: TMessage);
begin
  inherited;
  DoVMExpand(Message);
end;

procedure TdxDBTreeView.WMPaint(var Message: TMessage);
begin
  inherited;
  DoWMPaint(Message);
end;

procedure TdxDBTreeView.WMUpdateImages(var Message: TMessage);
var
  ANode: TdxDBTreeNode;
begin
  ANode := TdxDBTreeNode(Message.WParam);
  if ANode is TdxDBTreeNode then
    ANode.UpdateImages;
end;

procedure TdxDBTreeView.EditWndProc(var Message: TMessage);
begin
  with Message do
  begin
    case Msg of
      WM_CHAR:
        if not (FDataLink.DataSet.CanModify) or FListField.ReadOnly then
          Exit
        else
          if not FListField.IsValidChar(Char(wParam)) then
          begin
            MessageBeep(0);
            Exit;
          end;
    end;
    Result := CallWindowProc(FDefEditProc, FEditHandle, Msg, WParam, LParam);
  end;
end;

end.

