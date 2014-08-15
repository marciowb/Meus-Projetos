{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressBars components                                      }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSBARS AND ALL ACCOMPANYING VCL }
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

unit dxRibbonGalleryDesigner;

interface

uses
  DesignIntf, Variants,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, cxClasses, dxRibbonGallery, ComCtrls, StdCtrls, ToolWin, ImgList,
  cxGraphics, ExtCtrls, cxDesignWindows, dxMessages, Menus, ActnList;

const
  WM_DELETEDESIGNERNODE = WM_DX + 1;

type
  TfrmRibbonGalleryDesigner = class(TcxDesignFormEditor)
    ilButtons: TcxImageList;
    ppmGalleryItems: TPopupMenu;
    ppmiAdd: TMenuItem;
    ppmiDelete: TMenuItem;
    ppmDragDrop: TPopupMenu;
    ppmiCopy: TMenuItem;
    ppmiMove: TMenuItem;
    N1: TMenuItem;
    ppmiGroupVisible: TMenuItem;
    ppmiGroupHeaderVisible: TMenuItem;
    ilGroupState: TcxImageList;
    alMain: TActionList;
    actAddGroup: TAction;
    actRemove: TAction;
    actAddGroupItem: TAction;
    AddGroup1: TMenuItem;
    actMoveNodeUp: TAction;
    actMoveNodeDown: TAction;
    actGroupVisible: TAction;
    actGroupHeaderVisible: TAction;
    tvGalleryItems: TTreeView;
    ToolBar1: TToolBar;
    tbAddGroup: TToolButton;
    tbAddGroupItem: TToolButton;
    tbDelete: TToolButton;
    tbSeparator: TToolButton;
    tbMoveNodeUp: TToolButton;
    tbMoveNodeDown: TToolButton;
    actClose: TAction;
    ilHelper: TcxImageList;
    procedure FormShow(Sender: TObject);
    procedure tvGalleryItemsDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure tvGalleryItemsDragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure tvGalleryItemsChange(Sender: TObject; Node: TTreeNode);
    procedure tvGalleryItemsEdited(Sender: TObject; Node: TTreeNode;
      var S: String);
    procedure ppmiCopyClick(Sender: TObject);
    procedure ppmiMoveClick(Sender: TObject);
    procedure ppmDragDropPopup(Sender: TObject);
    procedure ppmGalleryItemsPopup(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actAddGroupExecute(Sender: TObject);
    procedure actRemoveExecute(Sender: TObject);
    procedure actAddGroupItemExecute(Sender: TObject);
    procedure actMoveNodeUpExecute(Sender: TObject);
    procedure actMoveNodeDownExecute(Sender: TObject);
    procedure actGroupVisibleExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
  private
    FDeletingNode: TTreeNode;
    FDragDropTargetNode: TTreeNode;
    FGalleryItemRemoved: Boolean;
    FGalleryItemsWndProc: TWndMethod;
    FLockSelectionChangedCount: Integer;

    function CanModify: Boolean;
    procedure GalleryItemsMenuSetup(ANode: TTreeNode);
    function GetGalleryItem: TdxRibbonGalleryItem;
    procedure GroupPopupMenuInitialize(ANode: TTreeNode);
    procedure RefreshImages;

    procedure AddGroupNode;
    procedure AddGroupItemNode(ANode: TTreeNode);
    procedure MoveGroupNode(ANode: TTreeNode; MoveUp: Boolean);
    procedure MoveNodeDown(ANode: TTreeNode);
    procedure MoveNodeUp(ANode: TTreeNode);
    procedure MoveGroupItemNode(ANode: TTreeNode; MoveUp: Boolean);
    procedure RemoveNode(ANode: TTreeNode);
    procedure SetGroupNodeGlyph(ANode: TTreeNode);
    procedure UpdateGroupNode(ANode: TTreeNode);
    procedure UpdateGroupItemNode(ANode: TTreeNode);

    // dragdrop
    procedure DoDragDrop(ATargetNode: TTreeNode; DoCopy: Boolean = False);
    procedure GroupItemNodeDragDrop(ASourceNode, ATargetNode: TTreeNode; DoCopy: Boolean);
    procedure GroupNodeDragDrop(ASourceNode, ATargetNode: TTreeNode);

    function AddGalleryGroup(ANode: TTreeNode): TdxRibbonGalleryGroup;
    function AddGalleryGroupItem(ANode: TTreeNode; const ADescription: string): TdxRibbonGalleryGroupItem;
    function GetGalleryGroup(ANode: TTreeNode): TdxRibbonGalleryGroup;
    function GetGalleryGroupItem(ANode: TTreeNode): TdxRibbonGalleryGroupItem;
    procedure ReadGalleryGroupItems;
    procedure ReadGalleryItem;
    function RemoveGroup(ANode: TTreeNode): Boolean;
    function RemoveGroupItem(ANode: TTreeNode): Boolean;
    procedure SetGalleryGroupIndex(ANode: TTreeNode; AIndex: Integer);
    procedure UpdateItemCaption(ANode: TTreeNode; ACaption: string);

    // object inspector
    procedure GalleryItemModified;
    procedure ShowInObjectInspector(ANode: TTreeNode);

    // TreeView wnd proc
    procedure GalleryItemsWndProc(var Message: TMessage);
    procedure RestoreTreeViewWndProc;
    procedure StoreTreeViewWndProc;
    function TreeViewWndProcHandler(ATreeView: TTreeView; var Message: TMessage): Boolean;

    procedure DoSelectionChanged(Sender: TObject; const ASelection: TDesignerSelectionList);
    procedure WMDeleteDesignNode(var Message: TMessage); message WM_DELETEDESIGNERNODE;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure UpdateActions; override;
    procedure UpdateCaption; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DoItemDeleted(AItem: TPersistent); override;
    procedure DoItemsModified; override;
    property GalleryItem: TdxRibbonGalleryItem read GetGalleryItem;
  end;

implementation

{$R *.dfm}

uses Math, CommCtrl, cxControls;

type
  TdxRibbonGalleryItemAccess = class(TdxRibbonGalleryItem);

const
  dxGroupLevel = 0;
  dxGroupItemLevel = 1;

{ TfrmRibbonGalleryDesigner }

constructor TfrmRibbonGalleryDesigner.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  StoreTreeViewWndProc;
  AOwner.FreeNotification(Self);
  RefreshImages;
end;

destructor TfrmRibbonGalleryDesigner.Destroy;
var
  AGalleryItem: TdxRibbonGalleryItem;
begin
  RestoreTreeViewWndProc;
  AGalleryItem := GalleryItem;
  if AGalleryItem <> nil then
    TdxRibbonGalleryItemAccess(AGalleryItem).UnderDesign := False;
  inherited Destroy;
end;

procedure TfrmRibbonGalleryDesigner.DoItemDeleted(AItem: TPersistent);
var
  I: Integer;
begin
  for I := 0 to tvGalleryItems.Items.Count - 1 do
    if AItem = tvGalleryItems.Items[I].Data then
    begin
      FDeletingNode := tvGalleryItems.Items[I];
      PostMessage(Self.Handle, WM_DELETEDESIGNERNODE, 0, 0);
    end;
end;

procedure TfrmRibbonGalleryDesigner.DoItemsModified;
var
  ANode: TTreeNode;
begin
  inherited DoItemsModified;
  ANode := tvGalleryItems.Selected;
  if (ANode = nil) or (ANode = FDeletingNode) then
    Exit;

  if ANode.Level = 0 then
    UpdateGroupNode(ANode)
  else
    UpdateGroupItemNode(ANode);
end;

procedure TfrmRibbonGalleryDesigner.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (AComponent = Owner) and (Operation = opRemove) then
    FGalleryItemRemoved := True;
end;

procedure TfrmRibbonGalleryDesigner.UpdateActions;
var
  ASelectedNode: TTreeNode;
begin
  inherited UpdateActions;
  ASelectedNode := tvGalleryItems.Selected;
  actAddGroup.Enabled := CanModify;
  actAddGroupItem.Enabled := (GalleryItem.GalleryGroups.Count > 0) and CanModify;
  actRemove.Enabled := (ASelectedNode <> nil) and CanModify;
  actMoveNodeUp.Enabled := (ASelectedNode <> nil) and
    ((ASelectedNode.Level = dxGroupLevel) and (ASelectedNode.AbsoluteIndex > 0) or
    (ASelectedNode.Level = dxGroupItemLevel) and (ASelectedNode.AbsoluteIndex > 1)) and
    CanModify;
  actMoveNodeDown.Enabled := (ASelectedNode <> nil) and
    not ((ASelectedNode.AbsoluteIndex = tvGalleryItems.Items.Count - 1) or
    (ASelectedNode.Level = 0) and (ASelectedNode.getNextSibling = nil)) and CanModify;
  actGroupVisible.Enabled := CanModify;
  actGroupHeaderVisible.Enabled := CanModify;
end;

procedure TfrmRibbonGalleryDesigner.UpdateCaption;
begin
  Caption := cxGetFullComponentName(GalleryItem) + ' - Designer';
end;

function TfrmRibbonGalleryDesigner.CanModify: Boolean;
begin
  Result := not Designer.IsSourceReadOnly;
end;

procedure TfrmRibbonGalleryDesigner.GalleryItemsMenuSetup(ANode: TTreeNode);
var
  I: Integer;
begin
  if ANode = nil then
    Exit;

  for I := 0 to ppmGalleryItems.Items.Count - 1 do
    ppmGalleryItems.Items[I].Visible := (ppmGalleryItems.Items[I].Tag = 0) or
     (ppmGalleryItems.Items[I].Tag = 1) and (ANode.Level = 0);

  if ANode.Level = 0 then
    GroupPopupMenuInitialize(ANode);
end;

function TfrmRibbonGalleryDesigner.GetGalleryItem: TdxRibbonGalleryItem;
begin
  Result := nil;
  if not FGalleryItemRemoved and (Component is TdxRibbonGalleryItem) then
    Result := Component as TdxRibbonGalleryItem;
end;

procedure TfrmRibbonGalleryDesigner.GroupPopupMenuInitialize(ANode: TTreeNode);
begin
  actGroupVisible.Checked := GetGalleryGroup(ANode).Visible;
  actGroupHeaderVisible.Checked := GetGalleryGroup(ANode).Header.Visible;
end;

procedure TfrmRibbonGalleryDesigner.RefreshImages;
begin
  cxTransformImages(ilButtons, ilHelper, clWindow, False);
end;

procedure TfrmRibbonGalleryDesigner.AddGroupNode;
var
  AAddedNode: TTreeNode;
begin
  AAddedNode := tvGalleryItems.Items.Add(nil, 'New Group');
  AAddedNode.Data := AddGalleryGroup(AAddedNode);
  SetGroupNodeGlyph(AAddedNode);
  AAddedNode.Selected := True;
  GalleryItemModified;
end;

procedure TfrmRibbonGalleryDesigner.AddGroupItemNode(ANode: TTreeNode);
const
  GroupItemCaption = 'New GroupItem';
var
  AAddedNode: TTreeNode;
begin
  if tvGalleryItems.Items.Count = 0 then
    Exit;
  if ANode = nil then
    ANode := tvGalleryItems.Items[0];
  if ANode.Level = 0 then
    AAddedNode := tvGalleryItems.Items.AddChild(ANode, GroupItemCaption)
  else
    AAddedNode := tvGalleryItems.Items.Add(ANode, GroupItemCaption);
  AAddedNode.Data := AddGalleryGroupItem(AAddedNode, '');
  AAddedNode.Parent.Expand(False);
  AAddedNode.Selected := True;
  GalleryItemModified;
end;

procedure TfrmRibbonGalleryDesigner.MoveGroupNode(ANode: TTreeNode; MoveUp: Boolean);
var
  AIndex: Integer;
begin
  AIndex := ANode.Index + IfThen(MoveUp, - 1, 1);
  if (AIndex >= 0) and (AIndex < GalleryItem.GalleryGroups.Count) then
    SetGalleryGroupIndex(ANode, AIndex);
  GalleryItemModified;
end;

procedure TfrmRibbonGalleryDesigner.MoveNodeDown(ANode: TTreeNode);
begin
  if ANode.Level = 0 then
    MoveGroupNode(ANode, False)
  else
    MoveGroupItemNode(ANode, False);
end;

procedure TfrmRibbonGalleryDesigner.MoveNodeUp(ANode: TTreeNode);
begin
  if ANode.Level = 0 then
    MoveGroupNode(ANode, True)
  else
    MoveGroupItemNode(ANode, True);
end;

procedure TfrmRibbonGalleryDesigner.MoveGroupItemNode(ANode: TTreeNode; MoveUp: Boolean);

type
  TdxGroupChanged = (gcNone, gcIncreased, gcDecreased);

  function CalculateNodePosition(AParentNode: TTreeNode; out ANodeIndex,
    AGroupIndex: Integer): TdxGroupChanged;
  begin
    ANodeIndex := ANode.Index + IfThen(MoveUp, -1, 1);
    AGroupIndex := GetGalleryGroup(AParentNode).Index;
    Result := gcNone;
    if ANodeIndex < 0 then
    begin
      Dec(AGroupIndex);
      Result := gcDecreased;
      ANodeIndex := -1;
    end
    else
      if ANodeIndex > ANode.Parent.Count - 1 then
      begin
        Inc(AGroupIndex);
        Result := gcIncreased;
        ANodeIndex := 0;
      end;
  end;

  function CreateNode(AParentNode: TTreeNode; ANodeIndex: Integer;
    AGroup: TdxRibbonGalleryGroup; AGroupChanged: TdxGroupChanged): TTreeNode;
  begin
    if (ANodeIndex = AGroup.Items.Count - 1) and
      not((AGroupChanged = gcIncreased) and (AParentNode.Count = 1)) or
      (AParentNode.Count = 0) then
    begin
      Result := tvGalleryItems.Items.AddChild(AParentNode, ANode.Text);
      AParentNode.Expand(False);
    end
    else
      Result := tvGalleryItems.Items.Insert(
        AParentNode.Item[ANodeIndex + IfThen(MoveUp or (AGroupChanged = gcIncreased),
          0, 1)], ANode.Text);
  end;

var
  ANodeIndex, AGroupIndex: Integer;
  AGroup: TdxRibbonGalleryGroup;
  AParentNode, ACreatedNode: TTreeNode;
  AGroupChanged: TdxGroupChanged;
begin
  Inc(FLockSelectionChangedCount);
  try
    AParentNode := ANode.Parent;
    AGroupChanged := CalculateNodePosition(AParentNode, ANodeIndex, AGroupIndex);
    case AGroupChanged of
      gcIncreased: AParentNode := AParentNode.getNextSibling;
      gcDecreased: AParentNode := AParentNode.getPrevSibling;
    end;

    if (AGroupIndex >= 0) and (AGroupIndex < GalleryItem.GalleryGroups.Count) then
    begin
      AGroup := GalleryItem.GalleryGroups[AGroupIndex];
      if ANodeIndex = -1 then
        ANodeIndex := AGroup.Items.Count - 1;

      tvGalleryItems.Items.BeginUpdate;
      try
        ACreatedNode := CreateNode(AParentNode, ANodeIndex, AGroup, AGroupChanged);
        ACreatedNode.Data := GalleryItem.MoveGroupItem(TdxRibbonGalleryGroupItem(ANode.Data),
           AGroup, ANodeIndex + IfThen((AGroupChanged = gcDecreased), 1, 0));
        ACreatedNode.Selected := True;
        ANode.Free;
      finally
        tvGalleryItems.Items.EndUpdate;
      end;
    end;
  finally
     Dec(FLockSelectionChangedCount);
  end;
  if AGroupChanged <> gcNone then
    GalleryItemModified;
end;

procedure TfrmRibbonGalleryDesigner.RemoveNode(ANode: TTreeNode);

  procedure SelectAnotherNode(ANode: TTreeNode);
  var
    AAnotherNode: TTreeNode;
  begin
    AAnotherNode := ANode.getPrevSibling;
    if AAnotherNode = nil then
    begin
      AAnotherNode := ANode.getNextSibling;
      if AAnotherNode = nil then
        AAnotherNode := ANode.Parent;
    end;
    if AAnotherNode <> nil then
      AAnotherNode.Selected := True;
  end;

var
  ARemoved: Boolean;
begin
  if ANode = nil then
    Exit;
  SelectAnotherNode(ANode);
  if ANode.Level = 0 then
    ARemoved := RemoveGroup(ANode)
  else
    ARemoved := RemoveGroupItem(ANode);
  if ARemoved then
    tvGalleryItems.Items.Delete(ANode);
  GalleryItemModified;
end;

procedure TfrmRibbonGalleryDesigner.SetGroupNodeGlyph(ANode: TTreeNode);
var
  AGroup: TdxRibbonGalleryGroup;
begin
  AGroup := GetGalleryGroup(ANode);
  ANode.StateIndex := 1;
  if AGroup.Visible then
    if not AGroup.Header.Visible then
      ANode.StateIndex := 3
    else
      ANode.StateIndex := 2;
end;

procedure TfrmRibbonGalleryDesigner.UpdateGroupNode(ANode: TTreeNode);
var
  AGroup: TdxRibbonGalleryGroup;
begin
  SetGroupNodeGlyph(ANode);
  AGroup := GetGalleryGroup(ANode);
  ANode.Text := AGroup.Header.Caption;
end;

procedure TfrmRibbonGalleryDesigner.UpdateGroupItemNode(ANode: TTreeNode);
begin
  ANode.Text := GetGalleryGroupItem(ANode).Caption;
end;

procedure TfrmRibbonGalleryDesigner.DoDragDrop(ATargetNode: TTreeNode;
  DoCopy: Boolean = False);
var
  ASourceNode: TTreeNode;
begin
  if ATargetNode <> nil then
  begin
    ASourceNode := tvGalleryItems.Selected;
    if ATargetNode <> ASourceNode then
    begin
      if ASourceNode.Level = dxGroupItemLevel then
        GroupItemNodeDragDrop(ASourceNode, ATargetNode, DoCopy)
      else
        GroupNodeDragDrop(ASourceNode, ATargetNode);
    end;
  end;
end;

procedure TfrmRibbonGalleryDesigner.GroupItemNodeDragDrop(ASourceNode,
  ATargetNode: TTreeNode; DoCopy: Boolean);

  procedure ChangeGalleryItem(ACreatedNode: TTreeNode; AGroup: TdxRibbonGalleryGroup; AIndex: Integer;
    DoCopy: Boolean);
  begin
    if DoCopy then
      ACreatedNode.Data := GalleryItem.CopyGroupItem(
        TdxRibbonGalleryGroupItem(ASourceNode.Data), AGroup, AIndex)
    else
      ACreatedNode.Data := GalleryItem.MoveGroupItem(
        TdxRibbonGalleryGroupItem(ASourceNode.Data), AGroup, AIndex);
  end;

  function IsDragDropDown: Boolean;
  begin
    Result := (ATargetNode.Level = dxGroupItemLevel) and
      ((ASourceNode.Parent.Index < ATargetNode.Parent.Index) or
      (ASourceNode.Parent.Index = ATargetNode.Parent.Index) and
      (ASourceNode.Index < ATargetNode.Index));
  end;

var
  ACreatedNode, ASibling: TTreeNode;
  AIndex: Integer;
  AGroup: TdxRibbonGalleryGroup;
begin
  tvGalleryItems.Items.BeginUpdate;
  try
    if ATargetNode.Level = dxGroupItemLevel then
    begin
      AIndex := ATargetNode.Index;
      ASibling := nil;
      if IsDragDropDown then
      begin
        ASibling := ATargetNode.getNextSibling;
        if ASibling <> nil then
        begin
          ATargetNode := ASibling;
          Inc(AIndex);
        end;
      end;
      if IsDragDropDown and (ASibling = nil) then
        ACreatedNode := tvGalleryItems.Items.AddChild(ATargetNode.Parent, ASourceNode.Text)
      else
        ACreatedNode := tvGalleryItems.Items.Insert(ATargetNode, ASourceNode.Text);
      AGroup := TdxRibbonGalleryGroup(ATargetNode.Parent.Data);
    end
    else
    begin
      ACreatedNode := tvGalleryItems.Items.AddChild(ATargetNode, ASourceNode.Text);
      ATargetNode.Expand(False);
      AIndex := ATargetNode.Count - 1 -
        IfThen((ASourceNode.Parent = ATargetNode) and not DoCopy, 1, 0);
      AGroup := TdxRibbonGalleryGroup(ATargetNode.Data);
    end;
    ChangeGalleryItem(ACreatedNode, AGroup, AIndex, DoCopy);
    if not DoCopy then
      ASourceNode.Free;
  finally
    tvGalleryItems.Items.EndUpdate;
  end;

  GalleryItemModified;
  ACreatedNode.Selected := True;
end;

procedure TfrmRibbonGalleryDesigner.GroupNodeDragDrop(ASourceNode, ATargetNode: TTreeNode);
var
  ATargetNodeIndex: Integer;
begin
  ATargetNodeIndex := TdxRibbonGalleryGroup(ATargetNode.Data).Index;
  SetGalleryGroupIndex(ASourceNode, ATargetNodeIndex);
end;

function TfrmRibbonGalleryDesigner.AddGalleryGroup(ANode: TTreeNode): TdxRibbonGalleryGroup;
begin
  Result := GalleryItem.GalleryGroups.Add;
  Result.Header.Caption := ANode.Text;
end;

function TfrmRibbonGalleryDesigner.AddGalleryGroupItem(ANode: TTreeNode;
  const ADescription: string): TdxRibbonGalleryGroupItem;
begin
  Result := GalleryItem.GalleryGroups[ANode.Parent.Index].Items.Add;
  Result.Caption := ANode.Text;
  Result.Description := ADescription;
end;

function TfrmRibbonGalleryDesigner.GetGalleryGroup(ANode: TTreeNode): TdxRibbonGalleryGroup;
begin
  Result := TdxRibbonGalleryGroup(ANode.Data);
end;

function TfrmRibbonGalleryDesigner.GetGalleryGroupItem(ANode: TTreeNode): TdxRibbonGalleryGroupItem;
begin
  Result := TdxRibbonGalleryGroupItem(ANode.Data);
end;

procedure TfrmRibbonGalleryDesigner.ReadGalleryGroupItems;
var
  I, J: Integer;
  ANode: TTreeNode;
begin
  tvGalleryItems.Items.Clear;
  for I := 0 to GalleryItem.GalleryGroups.Count - 1 do
  begin
    ANode := tvGalleryItems.Items.AddObject(nil,
      GalleryItem.GalleryGroups[I].Header.Caption, GalleryItem.GalleryGroups[I]);
    SetGroupNodeGlyph(ANode);
    for J := 0 to GalleryItem.GalleryGroups[I].Items.Count - 1 do
      tvGalleryItems.Items.AddChildObject(ANode,
        GalleryItem.GalleryGroups[I].Items[J].Caption, GalleryItem.GalleryGroups[I].Items[J]);
  end;
end;

procedure TfrmRibbonGalleryDesigner.ReadGalleryItem;
begin
  tvGalleryItems.Items.BeginUpdate;
  try
    ReadGalleryGroupItems;
    tvGalleryItems.FullExpand;
  finally
    tvGalleryItems.Items.EndUpdate;
  end;
end;

function TfrmRibbonGalleryDesigner.RemoveGroup(ANode: TTreeNode): Boolean;
begin
  Result := ANode.Data <> nil;
  if Result then
    GalleryItem.GalleryGroups.Remove(TdxRibbonGalleryGroup(ANode.Data));
end;

function TfrmRibbonGalleryDesigner.RemoveGroupItem(ANode: TTreeNode): Boolean;
begin
  Result := (ANode.Parent.Data <> nil) and (ANode.Data <> nil);
  if Result then
    TdxRibbonGalleryGroup(ANode.Parent.Data).Items.Remove(TdxRibbonGalleryGroupItem(ANode.Data));
end;

procedure TfrmRibbonGalleryDesigner.SetGalleryGroupIndex(ANode: TTreeNode; AIndex: Integer);

  procedure SelectGroup(AIndex: Integer);
  var
    I: Integer;
  begin
    ANode := tvGalleryItems.Items[0];
    for I := 1 to AIndex do
      ANode := ANode.GetNextSibling;
    ANode.Selected := True;
  end;

begin
  TdxRibbonGalleryGroup(ANode.Data).Index := AIndex;
  ReadGalleryItem;
  SelectGroup(AIndex);
end;

procedure TfrmRibbonGalleryDesigner.UpdateItemCaption(ANode: TTreeNode; ACaption: string);
begin
  if ANode.Level = 0 then
    GetGalleryGroup(ANode).Header.Caption := ACaption
  else
    GetGalleryGroupItem(ANode).Caption := ACaption;
end;

procedure TfrmRibbonGalleryDesigner.GalleryItemModified;
begin
  Designer.Modified;
end;

procedure TfrmRibbonGalleryDesigner.ShowInObjectInspector(ANode: TTreeNode);
var
  ASelections: TList;
begin
  if ANode <> nil then
  begin
    ASelections := TList.Create;
    try
      if ANode.Level = 0 then
        ASelections.Add(GetGalleryGroup(ANode))
      else
        ASelections.Add(GetGalleryGroupItem(ANode));
      SetSelectionList(ASelections);
    finally
      ASelections.Free;
    end;
  end;
end;

procedure TfrmRibbonGalleryDesigner.GalleryItemsWndProc(var Message: TMessage);
begin
  if not TreeViewWndProcHandler(tvGalleryItems, Message) then
    FGalleryItemsWndProc(Message);
end;

procedure TfrmRibbonGalleryDesigner.RestoreTreeViewWndProc;
begin
  if Assigned(FGalleryItemsWndProc) then
    tvGalleryItems.WindowProc := FGalleryItemsWndProc;
  FGalleryItemsWndProc := nil;
end;

procedure TfrmRibbonGalleryDesigner.StoreTreeViewWndProc;
begin
  FGalleryItemsWndProc := tvGalleryItems.WindowProc;
  tvGalleryItems.WindowProc := GalleryItemsWndProc;
end;

function TfrmRibbonGalleryDesigner.TreeViewWndProcHandler(
  ATreeView: TTreeView; var Message: TMessage): Boolean;

  procedure ShowContextMenu;
  var
    AHitTest: THitTests;
  begin
    AHitTest := ATreeView.GetHitTestInfoAt(Message.LParamLo, Message.LParamHi);
    if (htOnItem in AHitTest) then
      ATreeView.Perform(WM_CONTEXTMENU, ATreeView.Handle, Integer(PointToSmallPoint(GetMouseCursorPos)));
  end;

var
  ANode: TTreeNode;
  AShift: TShiftState;
begin
  Result := False;
  case Message.Msg of
    CN_NOTIFY:
      case TWMNotify(Message).NMHdr^.code of
        NM_RCLICK:
          begin
            ShowContextMenu;
            Message.Result := 1;
            Result := True;
          end;
      end;
    WM_KEYDOWN:
      if Message.WParam = VK_ESCAPE then
        CancelDrag;
    WM_RBUTTONDOWN:
      begin
        if ATreeView.Selected <> nil then
          ATreeView.Selected.EndEdit(False);
        ANode := ATreeView.GetNodeAt(Message.LParamLo, Message.LParamHi);
        if ANode <> nil then
        begin
          ANode.Focused := True;
          AShift := KeysToShiftState(Message.WParam);
          if not ANode.Selected then
          begin
            if [ssShift, ssCtrl] * AShift <> [] then
              AShift := [];
            BeginUpdate;
            try
              ATreeView.Select(ANode, AShift);
            finally
              CancelUpdate;
            end;
            ShowInObjectInspector(ANode);
          end;
          Message.Result := 1;
          Result := True;
        end;
      end;
  end;
end;

procedure TfrmRibbonGalleryDesigner.DoSelectionChanged(Sender: TObject;
  const ASelection: TDesignerSelectionList);
var
  I: Integer;
begin
  if FLockSelectionChangedCount > 0 then
    Exit;
  tvGalleryItems.Selected := nil;
  if ASelection.Count > 0 then
    for I := 0 to tvGalleryItems.Items.Count - 1 do
      if tvGalleryItems.Items[I].Data = ASelection.Items[0] then
        tvGalleryItems.Items[I].Selected := True;
end;

procedure TfrmRibbonGalleryDesigner.WMDeleteDesignNode(var Message: TMessage);
begin
  if FDeletingNode <> nil then
  begin
    tvGalleryItems.Items.Delete(FDeletingNode);
    FDeletingNode := nil;
  end;
end;

procedure TfrmRibbonGalleryDesigner.FormShow(Sender: TObject);
begin
  ReadGalleryItem;
  tvGalleryItems.ReadOnly := not CanModify;
end;

procedure TfrmRibbonGalleryDesigner.tvGalleryItemsDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  ASelectedNode, ATargetNode: TTreeNode;
begin
  ASelectedNode := tvGalleryItems.Selected;
  ATargetNode := tvGalleryItems.GetNodeAt(X, Y);
  Accept := (Sender = tvGalleryItems) and
    (ASelectedNode <> nil) and (ATargetNode <> nil) and
    ((ASelectedNode.Level = dxGroupItemLevel) or
    (ATargetNode.Level = dxGroupLevel)) and CanModify;
end;

procedure TfrmRibbonGalleryDesigner.tvGalleryItemsDragDrop(Sender,
  Source: TObject; X, Y: Integer);
begin
  FDragDropTargetNode := tvGalleryItems.GetNodeAt(X, Y);
  DoDragDrop(FDragDropTargetNode, (GetKeyState(VK_CONTROL) and $10000000) <> 0);
end;

procedure TfrmRibbonGalleryDesigner.tvGalleryItemsChange(Sender: TObject;
  Node: TTreeNode);
begin
  ShowInObjectInspector(tvGalleryItems.Selected);
end;

procedure TfrmRibbonGalleryDesigner.tvGalleryItemsEdited(Sender: TObject;
  Node: TTreeNode; var S: String);
begin
  UpdateItemCaption(Node, S);
  GalleryItemModified;
end;

procedure TfrmRibbonGalleryDesigner.ppmiCopyClick(Sender: TObject);
begin
  DoDragDrop(FDragDropTargetNode, True);
end;

procedure TfrmRibbonGalleryDesigner.ppmiMoveClick(Sender: TObject);
begin
  DoDragDrop(FDragDropTargetNode);
end;

procedure TfrmRibbonGalleryDesigner.ppmDragDropPopup(Sender: TObject);
begin
  ppmiCopy.Enabled := (tvGalleryItems.Selected <> nil) and
    (tvGalleryItems.Selected.Level = dxGroupItemLevel);
end;

procedure TfrmRibbonGalleryDesigner.ppmGalleryItemsPopup(Sender: TObject);
begin
  GalleryItemsMenuSetup(tvGalleryItems.Selected);
end;

procedure TfrmRibbonGalleryDesigner.FormCreate(Sender: TObject);
begin
  OnSelectionsChanged := DoSelectionChanged;
end;

procedure TfrmRibbonGalleryDesigner.actAddGroupExecute(Sender: TObject);
begin
  AddGroupNode;
end;

procedure TfrmRibbonGalleryDesigner.actRemoveExecute(Sender: TObject);
begin
  RemoveNode(tvGalleryItems.Selected);
end;

procedure TfrmRibbonGalleryDesigner.actAddGroupItemExecute(
  Sender: TObject);
begin
  AddGroupItemNode(tvGalleryItems.Selected);
end;

procedure TfrmRibbonGalleryDesigner.actMoveNodeUpExecute(Sender: TObject);
begin
  MoveNodeUp(tvGalleryItems.Selected);
end;

procedure TfrmRibbonGalleryDesigner.actMoveNodeDownExecute(
  Sender: TObject);
begin
  MoveNodeDown(tvGalleryItems.Selected);
end;

procedure TfrmRibbonGalleryDesigner.actGroupVisibleExecute(
  Sender: TObject);
var
  AGroup: TdxRibbonGalleryGroup;
begin
  AGroup := GetGalleryGroup(tvGalleryItems.Selected);
  AGroup.Visible := actGroupVisible.Checked;
  AGroup.Header.Visible := actGroupHeaderVisible.Checked;
  GalleryItemModified;
end;

procedure TfrmRibbonGalleryDesigner.actCloseExecute(Sender: TObject);
begin
  Close;
end;

end.

