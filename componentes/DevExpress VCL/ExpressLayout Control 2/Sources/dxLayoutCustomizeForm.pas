
{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{           ExpressLayoutControl customize form                      }
{                                                                    }
{           Copyright (c) 2001-2010 Developer Express Inc.           }
{           ALL RIGHTS RESERVED                                      }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSLAYOUTCONTROL AND ALL          }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM       }
{   ONLY.                                                            }
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

unit dxLayoutCustomizeForm;

{$I cxVer.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Contnrs, Controls, Forms, Dialogs,
  ComCtrls, ActnList, Menus, ToolWin, StdCtrls, ImgList, cxClasses,
  dxLayoutLookAndFeels, cxControls, cxGraphics, dxLayoutControl, dxLayoutDragAndDrop,
  cxLookAndFeelPainters, cxButtons, cxContainer, cxEdit, cxGroupBox,
  cxLookAndFeels, cxTreeView, cxCheckBox, dxLayoutcxEditAdapters;

type
  TdxLayoutControlCustomizeForm = class(TdxLayoutControlCustomCustomizeForm)
    alMain: TActionList;
    acAddGroup: TAction;
    acAddItem: TAction;
    acClose: TAction;
    acTreeViewExpandAll: TAction;
    acTreeViewCollapseAll: TAction;
    acTreeViewItemsDelete: TAction;
    acAlignLeftSide: TAction;
    acAlignRightSide: TAction;
    acAlignTopSide: TAction;
    acAlignBottomSide: TAction;
    acAlignNone: TAction;
    ilActions: TcxImageList;
    ilItems: TcxImageList;
    pmTreeViewActions: TPopupMenu;
    miExpandAll: TMenuItem;
    miCallapseAll: TMenuItem;
    miSeparator1: TMenuItem;
    miTreeViewDelete: TMenuItem;
    miSeparator2: TMenuItem;
    miAlignBy: TMenuItem;
    pmAvailableItemsActions: TPopupMenu;
    AddGroup1: TMenuItem;
    AddItem1: TMenuItem;
    Delete1: TMenuItem;
    pmAlign: TPopupMenu;
    Left1: TMenuItem;
    Right1: TMenuItem;
    op1: TMenuItem;
    Bottom1: TMenuItem;
    miSeparator3: TMenuItem;
    miSeparator4: TMenuItem;
    None1: TMenuItem;
    lcMainGroup_Root: TdxLayoutGroup;
    lcMain: TdxLayoutControl;
    lcgTreeView: TdxLayoutGroup;
    lcgAvailableItems: TdxLayoutGroup;
    acAvailableItemsDelete: TAction;
    acAvailableItemsExpandAll: TAction;
    acAvailableItemsCollapseAll: TAction;
    acAvailableItemsViewAsList: TAction;
    acTabbedView: TAction;
    acHighlightRoot: TAction;
    lcMainGroup1: TdxLayoutGroup;
    acShowDesignSelectors: TAction;
    acStore: TAction;
    acRestore: TAction;
    ilHelper: TcxImageList;
    acTreeViewItemRename: TAction;
    miTreeViewItemRename: TMenuItem;
    Rename2: TMenuItem;
    acAvailableItemRename: TAction;
    acUndo: TAction;
    acRedo: TAction;
    N1: TMenuItem;
    Undo1: TMenuItem;
    Redo1: TMenuItem;
    N2: TMenuItem;
    Undo2: TMenuItem;
    Redo2: TMenuItem;
    acAlignBy: TAction;
    tvItems: TcxTreeView;
    lcMainItem6: TdxLayoutItem;
    tvAvailableItems: TcxTreeView;
    lcMainItem8: TdxLayoutItem;
    btnClose: TcxButton;
    lcMainItem1: TdxLayoutItem;
    lcMainGroup3: TdxLayoutGroup;
    cbTabbedView: TcxCheckBox;
    lcMainItem4: TdxLayoutItem;
    liShowDesignSelectors: TdxLayoutItem;
    btnShowDesignSelectors: TcxButton;
    liHighlightRoot: TdxLayoutItem;
    btnHighlightRoot: TcxButton;
    liRestore: TdxLayoutItem;
    btnRestore: TcxButton;
    liStore: TdxLayoutItem;
    btnStore: TcxButton;
    liRedo: TdxLayoutItem;
    btnRedo: TcxButton;
    liUndo: TdxLayoutItem;
    btnUndo: TcxButton;
    lcMainGroup2: TdxLayoutGroup;
    liAlignBy: TdxLayoutItem;
    btnAlignBy: TcxButton;
    lcMainItem7: TdxLayoutItem;
    btnTreeViewItemsDelete: TcxButton;
    lcMainItem9: TdxLayoutItem;
    btnTreeViewCollapseAll: TcxButton;
    lcMainItem10: TdxLayoutItem;
    btnTreeViewExpandAll: TcxButton;
    lgTreeView: TdxLayoutGroup;
    lgAvailableItems: TdxLayoutGroup;
    lcMainItem3: TdxLayoutItem;
    btnAvailableItemsViewAsList: TcxButton;
    lcMainItem11: TdxLayoutItem;
    btnAvailableItemsDelete: TcxButton;
    liAddCustomItem: TdxLayoutItem;
    btnAddItem: TcxButton;
    lcMainItem13: TdxLayoutItem;
    btnAddGroup: TcxButton;
    lcMainItem14: TdxLayoutItem;
    btnAvailableItemsCollapseAll: TcxButton;
    lcMainItem15: TdxLayoutItem;
    btnAvailableItemsExpandAll: TcxButton;
    acHAlignLeft: TAction;
    acHAlignCenter: TAction;
    acHAlignRight: TAction;
    acHAlignClient: TAction;
    acHAlignParent: TAction;
    miAlignHorz: TMenuItem;
    ahLeft1: TMenuItem;
    ahCenter1: TMenuItem;
    ahRight1: TMenuItem;
    ahClient1: TMenuItem;
    ahParentManaged1: TMenuItem;
    acVAlignTop: TAction;
    acVAlignBottom: TAction;
    acVAlignCenter: TAction;
    acVAlignClient: TAction;
    acVAlignParent: TAction;
    miAlignVert: TMenuItem;
    acVAlignTop1: TMenuItem;
    acVAlignCenter1: TMenuItem;
    acVAlignBottom1: TMenuItem;
    acVAlignClient1: TMenuItem;
    acVAlignParent1: TMenuItem;
    acDirectionHorizontal: TAction;
    acDirectionVertical: TAction;
    acDirectionTabbed: TAction;
    miDirection: TMenuItem;
    acDirectionHorizontal1: TMenuItem;
    acDirectionVertical1: TMenuItem;
    acDirectionTabbed1: TMenuItem;
    acAddEmptySpaceItem: TAction;
    acShowBorder: TAction;
    miShowBorder: TMenuItem;
    acAddSeparator: TAction;
    AddEmptySpaceItem1: TMenuItem;
    acAddSeparator1: TMenuItem;
    acAddSplitter: TAction;
    acAddLabeledItem: TAction;
    PopupMenu1: TPopupMenu;
    AddEmptySpaceItem2: TMenuItem;
    acAddLabeledItem1: TMenuItem;
    acAddSeparator2: TMenuItem;
    acAddSplitter1: TMenuItem;
    acAddCustomItem: TAction;
    AddSplitter1: TMenuItem;
    AddLabel1: TMenuItem;
    lcMainSeparatorItem1: TdxLayoutSeparatorItem;
    lcMainSeparatorItem2: TdxLayoutSeparatorItem;
    N3: TMenuItem;
    lcMainSeparatorItem3: TdxLayoutSeparatorItem;
    lsAlignBy: TdxLayoutSeparatorItem;
    N4: TMenuItem;
    ExpandAll1: TMenuItem;
    CallapseAll1: TMenuItem;
    liAddItem: TdxLayoutItem;
    cxButton1: TcxButton;
    lsSeparator4: TdxLayoutSeparatorItem;
    procedure acCloseExecute(Sender: TObject);
    procedure acAddGroupExecute(Sender: TObject);
    procedure acAddItemExecute(Sender: TObject);
    procedure tvItemsEdited(Sender: TObject; Node: TTreeNode;
      var S: String);
    procedure tvItemsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ItemsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ItemsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tvItemsChange(Sender: TObject; Node: TTreeNode);
    procedure tvItemsChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure AlignExecute(Sender: TObject);
    procedure acTreeViewItemsDeleteExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tvItemsContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure acAvailableItemsDeleteExecute(Sender: TObject);
    procedure tvItemsCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure tvAvailableItemsContextPopup(Sender: TObject;
      MousePos: TPoint; var Handled: Boolean);
    procedure acAvailableItemsExpandAllExecute(Sender: TObject);
    procedure acAvailableItemsCollapseAllExecute(Sender: TObject);
    procedure acTreeViewExpandAllExecute(Sender: TObject);
    procedure acTreeViewCollapseAllExecute(Sender: TObject);
    procedure acAvailableItemsViewAsListExecute(Sender: TObject);
    procedure tvItemsEditing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure acTabbedViewExecute(Sender: TObject);
    procedure acHighlightRootExecute(Sender: TObject);
    procedure acShowDesignSelectorsExecute(Sender: TObject);
    procedure acStoreExecute(Sender: TObject);
    procedure acRestoreExecute(Sender: TObject);
    procedure acTreeViewItemRenameExecute(Sender: TObject);
    procedure acAvailableItemRenameExecute(Sender: TObject);
    procedure acUndoExecute(Sender: TObject);
    procedure acRedoExecute(Sender: TObject);
    procedure acAlignByExecute(Sender: TObject);
    procedure acHAlignExecute(Sender: TObject);
    procedure pmTreeViewActionsPopup(Sender: TObject);
    procedure acVAlignExecute(Sender: TObject);
    procedure acDirectionsExecute(Sender: TObject);
    procedure acAddEmptySpaceItemExecute(Sender: TObject);
    procedure acShowBorderExecute(Sender: TObject);
    procedure acAddSeparatorExecute(Sender: TObject);
    procedure acAddCustomItemExecute(Sender: TObject);
    procedure acAddLabeledItemExecute(Sender: TObject);
    procedure acAddSplitterExecute(Sender: TObject);
    procedure tvItemsDeletion(Sender: TObject; Node: TTreeNode);
  private
    FDragHelper: TdxLayoutDragAndDropHelper;
    FCollapsedAvailableItems: TcxComponentList;
    FCollapsedItems: TcxComponentList;
    FLockCount: Integer;
    FAvailableItemsWndProc: TWndMethod;
    FItemsWndProc: TWndMethod;
    procedure AddItemNode(ANodes: TTreeNodes; AParentNode: TTreeNode; AItem: TdxCustomLayoutItem; AAddChildren: Boolean = True);
    procedure AvailableItemsWndProc(var Message: TMessage);
    function CreateItem(AClass: TdxCustomLayoutItemClass; const ACaption: string): TdxCustomLayoutItem;
    procedure DoAfterInsertionItem(AItem: TdxCustomLayoutItem);
    function GetImageIndex(AItem: TdxCustomLayoutItem): Integer;
    function GetIsLocked: Boolean;
    procedure InitializePopupMenu;
    procedure ItemsWndProc(var Message: TMessage);
    procedure RefreshImages;
    procedure RefreshLists(ARefreshSelection: Boolean = False);
    procedure RefreshNode(ANode: TTreeNode);
    procedure RefreshButtonStates;
    procedure RefreshView;
    procedure SaveToUndo;

    // Selection
    function CanSelectItem(AItem: TdxCustomLayoutItem): Boolean;
    procedure SelectItem(AItem: TdxCustomLayoutItem);
    procedure SetItemsSelections(AList: TList);
    procedure SetLayoutItemsSelections(ATreeView: TTreeView);

    function TreeViewWndProcHandler(ATreeView: TTreeView; var Message: TMessage): Boolean;

    procedure RestoreCollapsedNodes(ATreeView: TTreeView; AList: TcxComponentList);
    procedure StoreCollapsedNodes(ATreeView: TTreeView; AList: TcxComponentList);
  protected
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    procedure ItemChanged(AItem: TdxCustomLayoutItem); override;
    procedure InitializeControl; override;
    function GetLayoutPopupMenu: TPopupMenu; override;
    function CanDeleteItems(ATreeView: TcxTreeView): Boolean;
    procedure DeleteItems(AList: TComponentList; ATreeView: TTreeView);
    function GetNode(AItem: TdxCustomLayoutItem; out ANode: TTreeNode): Boolean;
    procedure Localize; virtual;
    function NeedRefreshItemsAfterDeleting(AComponent: TPersistent): Boolean;
    procedure RefreshAvailableItems;
    procedure RefreshEnableds;
    procedure RefreshTreeView;

    procedure StoreTreeViewWndProc(ATreeView: TTreeView; var AStoredWndMethod: TWndMethod; ANewWndMethod: TWndMethod);
    procedure RestoreTreeViewWndProc(ATreeView: TTreeView; var AStoredWndMethod: TWndMethod);

    property DragHelper: TdxLayoutDragAndDropHelper read FDragHelper;
    property IsLocked: Boolean read GetIsLocked;
    property LockCount: Integer read FLockCount;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function GetHitTest(const P: TPoint): TdxCustomLayoutHitTest; override;
    procedure ToggleHotTrackState(AItem: TdxCustomLayoutItem); override;

    // Updates
    procedure BeginUpdate;
    procedure CancelUpdate;
    procedure EndUpdate;

    procedure UpdateAvailableItems; override;
    procedure UpdateCaption; override;
    procedure UpdateContent; override;
    procedure UpdateDragAndDropState; override;
    procedure UpdateSelection; override;
    procedure UpdateView; override;
    procedure UpdateVisibleItems; override;
  end;

procedure cxTreeViewGetSelection(ATreeView: TTreeView; AList: TList);
procedure cxTreeViewSyncSelection(ATreeView: TTreeView; AList: TList);

implementation

{$R *.DFM}

uses
  Types, Math, CommCtrl, dxLayoutCommon, dxLayoutEditForm, cxGeometry,
  dxLayoutStrs, dxCore, dxOffice11, dxLayoutSelection;

type
  TdxLayoutDragAndDropObjectAccess = class(TdxLayoutDragAndDropObject);
  TdxCustomLayoutControlAccess = class(TdxCustomLayoutControl);
  TdxCustomLayoutItemAccess = class(TdxCustomLayoutItem);
  TdxCustomLayoutItemViewInfoAccess = class(TdxCustomLayoutItemViewInfo);
  TToolBarAccess = class(TToolBar);

function CompareItemsByClass(Item1, Item2: Pointer): Integer;
var
  AItem1, AItem2: TdxCustomLayoutItem;
begin
  AItem1 := TdxCustomLayoutItem(Item1);
  AItem2 := TdxCustomLayoutItem(Item2);
  Result := Integer(AItem1.ClassType) - Integer(AItem2.ClassType);
end;

function CompareItemsByName(Item1, Item2: Pointer): Integer;

  procedure SplitNameByTrailingDigits(const AName: string; out ATrailingDigits: Integer;
    out ANameWithoutTrailingDigitals: string);
  var
    ACurrentLength: Integer;
  begin
    ANameWithoutTrailingDigitals := AName;
    ACurrentLength := Length(ANameWithoutTrailingDigitals);
    while (ACurrentLength > 0) and
      dxCharIsNumeric(ANameWithoutTrailingDigitals[ACurrentLength]) do
    begin
      ATrailingDigits := ATrailingDigits * 10 +
        StrToInt(ANameWithoutTrailingDigitals[ACurrentLength]);
      ANameWithoutTrailingDigitals := Copy(ANameWithoutTrailingDigitals, 1, ACurrentLength - 1);
      ACurrentLength := Length(ANameWithoutTrailingDigitals);
    end;
    if ACurrentLength = Length(AName) then
      ATrailingDigits := -1
    else
      ATrailingDigits := StrToInt(Copy(AName, ACurrentLength + 1, Length(AName) - ACurrentLength));
  end;

var
  AName1, AName2: string;
  ANameWithoutLastDigitals1, ANameWithoutLastDigitals2: string;
  ANumber1, ANumber2: Integer;
begin
  Result := CompareItemsByClass(Item1, Item2);
  if Result = 0 then
  begin
    AName1 := TdxCustomLayoutItem(Item1).CaptionForCustomizeForm;
    AName2 := TdxCustomLayoutItem(Item2).CaptionForCustomizeForm;
    if AName1 = AName2 then
    begin
      AName1 := AName1 + TdxCustomLayoutItem(Item1).Name;
      AName2 := AName2 + TdxCustomLayoutItem(Item2).Name;
    end;
    SplitNameByTrailingDigits(AName1, ANumber1, ANameWithoutLastDigitals1);
    SplitNameByTrailingDigits(AName2, ANumber2, ANameWithoutLastDigitals2);
    Result := CompareText(ANameWithoutLastDigitals1, ANameWithoutLastDigitals2);
    if Result = 0 then
      Result := ANumber1 - ANumber2;
  end;
end;

function CompareItems(Item1, Item2: Pointer): Integer;
begin
  Result := CompareItemsByClass(Item1, Item2);
  if (Result = 0) and (TObject(Item1) is TdxLayoutGroup) then
    Result := Integer(TdxLayoutGroup(Item1).Count > 0) - Integer(TdxLayoutGroup(Item2).Count > 0);
  if Result = 0 then
    Result := CompareItemsByName(Item1, Item2);
end;

procedure cxTreeViewGetSelection(ATreeView: TTreeView; AList: TList);
var
  I: Integer;
begin
  for I := 0 to ATreeView.SelectionCount - 1 do
    AList.Add(ATreeView.Selections[I].Data);
end;

procedure cxTreeViewSyncSelection(ATreeView: TTreeView; AList: TList);

  procedure InternalSyncSelection(ANode: TTreeNode);
  var
    I: Integer;
  begin
    if ANode = nil then
      Exit;
    if ANode.Selected xor (ANode.Data <> nil) and (AList.IndexOf(ANode.Data) >= 0) then
      if ANode.Selected then
        ATreeView.Deselect(ANode)
      else
        ATreeView.Select(ANode, [ssCtrl]);
    ANode.Focused := ANode.Selected;
    for I := 0 to ANode.Count - 1 do
      InternalSyncSelection(ANode[I]);
  end;

var
  I: Integer;
begin
  with ATreeView do
  begin
    if AList.Count > 0 then
      for I := 0 to Items.Count - 1 do
        InternalSyncSelection(Items[I])
    else
      ATreeView.ClearSelection(False);
  end;
  if ATreeView.SelectionCount = 0 then
    ATreeView.Selected := nil;
end;

{ TdxLayoutDesignForm }

constructor TdxLayoutControlCustomizeForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCollapsedItems := TcxComponentList.Create(False);
  FCollapsedAvailableItems := TcxComponentList.Create(False);
  Localize;
  InitializePopupMenu;
  RefreshImages;
  tvItems.InnerTreeView.PopupMenu := pmTreeViewActions;
  tvAvailableItems.InnerTreeView.PopupMenu := pmAvailableItemsActions;

  StoreTreeViewWndProc(tvItems.InnerTreeView, FItemsWndProc, ItemsWndProc);
  StoreTreeViewWndProc(tvAvailableItems.InnerTreeView, FAvailableItemsWndProc, AvailableItemsWndProc);
end;

destructor TdxLayoutControlCustomizeForm.Destroy;
begin
  RestoreTreeViewWndProc(tvItems.InnerTreeView, FItemsWndProc);
  RestoreTreeViewWndProc(tvAvailableItems.InnerTreeView, FAvailableItemsWndProc);

  FreeAndNil(FDragHelper);
  FreeAndNil(FCollapsedAvailableItems);
  FreeAndNil(FCollapsedItems);
  inherited;
end;

function TdxLayoutControlCustomizeForm.GetHitTest(const P: TPoint): TdxCustomLayoutHitTest;

  function IsMenuKeyDown: Boolean;
  begin
    Result := GetAsyncKeyState(VK_MENU) <> 0;
  end;

  function GetAreaPart(AItem: TdxCustomLayoutItem): TdxLayoutAreaPart;
  const
    AreaParts: array[Boolean] of TdxLayoutAreaPart = (apAfter, apBefore);
  var
    ASourceItem: TdxCustomLayoutItem;
    ASourceNode, ADestinationNode: TTreeNode;
    AIsBefore: Boolean;
  begin
    if (AItem is TdxLayoutGroup) and IsMenuKeyDown then
      Result := apLastChild
    else
      if (dxLayoutDragAndDropObject <> nil) and (TdxLayoutDragAndDropObjectAccess(dxLayoutDragAndDropObject).Control = Control) then
      begin
        ASourceItem := dxLayoutDragAndDropObject.SourceItem;
        AIsBefore := GetNode(ASourceItem, ASourceNode) and GetNode(AItem, ADestinationNode) and
          (ASourceNode.TreeView = ADestinationNode.TreeView) and
          (ASourceNode.AbsoluteIndex > ADestinationNode.AbsoluteIndex);
        Result := AreaParts[AIsBefore];
      end
      else
        Result := apAfter;
  end;

  function GetHitNode(ATreeView: TcxTreeView): TTreeNode;
  begin
    with cxPointOffset(P, ATreeView.BoundsRect.TopLeft, False) do
      if htOnItem in ATreeView.GetHitTestInfoAt(X, Y) then
        Result := ATreeView.GetNodeAt(X, Y)
      else
        Result := nil;
  end;

var
  AItem: TdxCustomLayoutItem;
  ANode: TTreeNode;
begin
  ANode := nil;
  if tvItems.Visible and PtInRect(tvItems.BoundsRect, P) then
  begin
    Result := TdxLayoutCustomizeFormTreeViewItemsHitTest.Instance;
    ANode := GetHitNode(tvItems);
  end
  else
    if tvAvailableItems.Visible and PtInRect(tvAvailableItems.BoundsRect, P) then
    begin
      Result := TdxLayoutCustomizeFormAvailableItemsHitTest.Instance;
      ANode := GetHitNode(tvAvailableItems);
    end
    else
      Result := inherited GetHitTest(P);
  if ANode <> nil then
  begin
    AItem := TdxCustomLayoutItem(ANode.Data);
    TdxLayoutCustomizeFormHitTest(Result).HitItem := AItem;
    TdxLayoutCustomizeFormHitTest(Result).AreaPart := GetAreaPart(AItem);
  end
  else
    TdxLayoutCustomizeFormHitTest(Result).HitItem := nil;
end;

procedure TdxLayoutControlCustomizeForm.ToggleHotTrackState(AItem: TdxCustomLayoutItem);
var
  ANode: TTreeNode;
  R: TRect;
begin
  if GetNode(AItem, ANode) and ANode.IsVisible then
  begin
    R := ANode.DisplayRect(False);
    InvalidateRect(ANode.TreeView.Handle, @R, True);
  end;
end;

procedure TdxLayoutControlCustomizeForm.BeginUpdate;
begin
  Inc(FLockCount);
end;

procedure TdxLayoutControlCustomizeForm.CancelUpdate;
begin
  Dec(FLockCount);
end;

procedure TdxLayoutControlCustomizeForm.EndUpdate;
begin
  Dec(FLockCount);
  if LockCount = 0 then
    RefreshLists(True);
end;

procedure TdxLayoutControlCustomizeForm.UpdateAvailableItems;
begin
  RefreshAvailableItems;
end;

procedure TdxLayoutControlCustomizeForm.UpdateCaption;
begin
  if Control.IsDesigning then
    Caption := Format(cxGetResourceString(@sdxLayoutControlDesignerCaptionFormat), [cxGetFullComponentName(Control)])
  else
    Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormCaption);
end;

procedure TdxLayoutControlCustomizeForm.UpdateContent;
begin
  RefreshLists;
end;

procedure TdxLayoutControlCustomizeForm.UpdateDragAndDropState;
begin
  if (FDragHelper.DragItem <> nil) and (Control.DragAndDropState = ddsNone) then
    FDragHelper.Reset;
end;

procedure TdxLayoutControlCustomizeForm.UpdateSelection;
var
  AList: TList;
  AIntf: IdxLayoutDesignerHelper;
begin
  if IsLocked then
    Exit;
  AList := TList.Create;
  try
    if Supports(Control, IdxLayoutDesignerHelper, AIntf) then
    begin
      AIntf.GetSelection(AList);
      AIntf := nil;
    end;
    SetItemsSelections(AList);
  finally
    AList.Free;
  end;
end;

procedure TdxLayoutControlCustomizeForm.UpdateView;
begin
  RefreshView;
end;

procedure TdxLayoutControlCustomizeForm.UpdateVisibleItems;
begin
  RefreshTreeView;
end;

procedure TdxLayoutControlCustomizeForm.Loaded;
begin
  inherited Loaded;
  Constraints.MinHeight := Height div 2;
  Constraints.MinWidth := Width;
end;

procedure TdxLayoutControlCustomizeForm.Notification(AComponent: TComponent; Operation: TOperation);
var
  ANode: TTreeNode;
  AItem: TdxCustomLayoutItem;
begin
  inherited;
  if not (csDestroying in ComponentState) and (Operation = opRemove) and
    (AComponent is TdxCustomLayoutItem) then
  begin
    AItem := AComponent as TdxCustomLayoutItem;
    if TdxCustomLayoutItemAccess(AItem).IsOwner(Control) and GetNode(AItem, ANode) then
      ANode.Delete;
  end;
end;

function TdxLayoutControlCustomizeForm.CanDeleteItems(ATreeView: TcxTreeView): Boolean;
var
  AList: TList;
  I: Integer;
  AIntf: IdxLayoutDesignerHelper;
begin
  Result := not ATreeView.IsEditing;
  if Result then
  begin
    AList := TList.Create;
    try
      cxTreeViewGetSelection(ATreeView.InnerTreeView, AList);
      Result := AList.Count > 0;
      if Result then
        for I := 0 to AList.Count - 1 do
        begin
          if Supports(Control, IdxLayoutDesignerHelper, AIntf) then
          begin
            Result := AIntf.CanDeleteComponent(TComponent(AList[I]));
            AIntf := nil;
          end;
          if not Result then
            Break;
        end;
    finally
      AList.Free;
    end;
  end;
end;

procedure TdxLayoutControlCustomizeForm.DeleteItems(AList: TComponentList; ATreeView: TTreeView);
begin
  if AList.Count = 0 then
    Exit;
  SaveToUndo;
  BeginUpdate;
  ATreeView.Items.BeginUpdate;
  try
    Control.BeginUpdate;
    try
      while AList.Count > 0 do
        AList[0].Free;
    finally
      Control.EndUpdate;
    end;
  finally
    ATreeView.Items.EndUpdate;
    CancelUpdate;
  end;
end;

function TdxLayoutControlCustomizeForm.GetNode(AItem: TdxCustomLayoutItem; out ANode: TTreeNode): Boolean;

  function FindNode(ANodes: TTreeNodes): TTreeNode;

    function FindNode(ANode: TTreeNode): TTreeNode;
    var
      I: Integer;
    begin
      Result := nil;
      if ANode.Data = AItem then
        Result := ANode
      else
        if ANode.HasChildren then
          for I := 0 to ANode.Count - 1 do
          begin
            Result := FindNode(ANode.Item[I]);
            if Result <> nil then
              Break;
          end;
    end;

  var
    I: Integer;
  begin
    Result := nil;
    for I := 0 to ANodes.Count - 1 do
    begin
      Result := FindNode(ANodes[I]);
      if Result <> nil then
        Break;
    end;
  end;

begin
  ANode := FindNode(tvAvailableItems.Items);
  if ANode = nil then
    ANode := FindNode(tvItems.Items);
  Result := ANode <> nil;
end;

function TdxLayoutControlCustomizeForm.GetLayoutPopupMenu: TPopupMenu;
begin
  Result := pmTreeViewActions;
end;

procedure TdxLayoutControlCustomizeForm.ItemChanged(AItem: TdxCustomLayoutItem);
var
  ANode: TTreeNode;
begin
  if GetNode(AItem, ANode) and not IsLocked then
    RefreshNode(ANode);
  if not IsLocked then
    RefreshButtonStates;
end;

procedure TdxLayoutControlCustomizeForm.InitializeControl;
begin
  lcMain.BeginUpdate;
  try
    FDragHelper.Free;
    FDragHelper := TdxLayoutDragAndDropHelper.Create(Control);
    inherited;
    tvItems.FullExpand;
    tvAvailableItems.FullExpand;
  finally
    lcMain.EndUpdate;
  end;
end;

procedure TdxLayoutControlCustomizeForm.Localize;
begin
  acAddGroup.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormAddGroup);
  acAddGroup.Hint := StripHotKey(acAddGroup.Caption);

  acAddItem.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormAddItem);
  acAddItem.Hint := StripHotKey(acAddItem.Caption);

  acAddCustomItem.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormAddAuxiliaryItem);
  acAddCustomItem.Hint := StripHotKey(acAddCustomItem.Caption);

  acAddEmptySpaceItem.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormAddEmptySpaceItem);
  acAddEmptySpaceItem.Hint := StripHotKey(acAddEmptySpaceItem.Caption);

  acAddSeparator.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormAddSeparatorItem);
  acAddSeparator.Hint := StripHotKey(acAddSeparator.Caption);

  acAddSplitter.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormAddSplitterItem);
  acAddSplitter.Hint := StripHotKey(acAddSplitter.Caption);

  acAddLabeledItem.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormAddLabeledItem);
  acAddLabeledItem.Hint := StripHotKey(acAddLabeledItem.Caption);

  acAvailableItemsDelete.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormDelete);
  acAvailableItemsDelete.Hint := cxGetResourceString(@sdxLayoutControlCustomizeFormDeleteHint);

  acTreeViewItemsDelete.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormDelete);
  acTreeViewItemsDelete.Hint := cxGetResourceString(@sdxLayoutControlCustomizeFormDeleteHint);

  acAlignBy.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormAlignBy);
  acAlignBy.Hint := StripHotKey(acAlignBy.Caption);

  acClose.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormClose);
  acClose.Hint := StripHotKey(acClose.Caption);

  acTreeViewExpandAll.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormExpandAll);
  acTreeViewExpandAll.Hint := StripHotKey(acTreeViewExpandAll.Caption);

  acAvailableItemsExpandAll.Caption := acTreeViewExpandAll.Caption;
  acAvailableItemsExpandAll.Hint := acTreeViewExpandAll.Hint;

  acTreeViewCollapseAll.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormCollapseAll);
  acTreeViewCollapseAll.Hint := StripHotKey(acTreeViewCollapseAll.Caption);

  acAvailableItemsCollapseAll.Caption := acTreeViewCollapseAll.Caption;
  acAvailableItemsCollapseAll.Hint := StripHotKey(acTreeViewCollapseAll.Hint);

  acAlignLeftSide.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormAlignLeftSide);
  acAlignRightSide.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormAlignRightSide);
  acAlignTopSide.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormAlignTopSide);
  acAlignBottomSide.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormAlignBottomSide);
  acAlignNone.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormAlignNone);

  miAlignHorz.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormHAlign);
  acHAlignLeft.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormHAlignLeft);
  acHAlignCenter.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormHAlignCenter);
  acHAlignRight.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormHAlignRight);
  acHAlignClient.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormHAlignClient);
  acHAlignParent.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormHAlignParent);

  miAlignVert.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormVAlign);
  acVAlignTop.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormVAlignTop);
  acVAlignCenter.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormVAlignCenter);
  acVAlignBottom.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormVAlignBottom);
  acVAlignClient.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormVAlignClient);
  acVAlignParent.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormVAlignParent);

  miDirection.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormDirection);
  acDirectionHorizontal.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormDirectionHorizontal);
  acDirectionVertical.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormDirectionVertical);
  acDirectionTabbed.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormDirectionTabbed);

  acShowBorder.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormShowBorder);

  lcgTreeView.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormTreeViewGroup);
  lcgAvailableItems.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormListViewGroup);

  acTabbedView.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormTabbedView);
  acTabbedView.Hint := StripHotKey(acTabbedView.Caption);

  acAvailableItemsViewAsList.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormTreeView);
  acAvailableItemsViewAsList.Hint := StripHotKey(acAvailableItemsViewAsList.Caption);

  acStore.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormStore);
  acStore.Hint := StripHotKey(acStore.Caption);

  acRestore.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormRestore);
  acRestore.Hint := StripHotKey(acRestore.Caption);

  acTreeViewItemRename.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormRename);
  acTreeViewItemRename.Hint := acTreeViewItemRename.Caption;

  acAvailableItemRename.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormRename);
  acAvailableItemRename.Hint := acAvailableItemRename.Caption;

  acUndo.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormUndo);
  acUndo.Hint := acUndo.Caption;

  acRedo.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormRedo);
  acRedo.Hint := acRedo.Caption;
end;

function TdxLayoutControlCustomizeForm.NeedRefreshItemsAfterDeleting(AComponent: TPersistent): Boolean;
begin
  Result := (AComponent is TdxCustomLayoutItem) and
    (TdxCustomLayoutItem(AComponent).Container = Control);
end;

procedure TdxLayoutControlCustomizeForm.RefreshAvailableItems;

  procedure PopulateItemChildren(AList: TList; AItem: TdxCustomLayoutItem);
  var
    I: Integer;
  begin
    if AItem is TdxLayoutGroup then
    begin
      for I := 0 to TdxLayoutGroup(AItem).Count - 1 do
      begin
        AList.Add(TdxLayoutGroup(AItem).Items[I]);
        PopulateItemChildren(AList, TdxLayoutGroup(AItem).Items[I]);
      end;
    end;
  end;

  procedure PopulateItems(AList: TList);
  var
    I: Integer;
  begin
    for I := 0 to Control.AvailableItemCount - 1 do
    begin
      AList.Add(Control.AvailableItems[I]);
      if Control.CustomizeAvailableItemsViewKind = aivkList then
        PopulateItemChildren(AList, Control.AvailableItems[I]);
    end;
  end;

var
  AList: TList;
  I: Integer;
begin
  with tvAvailableItems do
  begin
    BeginUpdate;
    Items.BeginUpdate;
    try
      StoreCollapsedNodes(tvAvailableItems.InnerTreeView, FCollapsedAvailableItems);
      Items.Clear;
      AList := TList.Create;
      try
        PopulateItems(AList);
        case Control.CustomizeAvailableItemsViewKind of
          aivkList:
            begin
              AList.Sort(CompareItemsByName);
              for I := 0 to AList.Count - 1 do
                AddItemNode(Items, nil, TdxCustomLayoutItem(AList[I]), False);
            end;
          aivkTree:
            begin
              AList.Sort(CompareItems);
              for I := 0 to AList.Count - 1 do
                AddItemNode(Items, nil, TdxCustomLayoutItem(AList[I]));
            end;
        end;
      finally
        AList.Free;
      end;
      RestoreCollapsedNodes(tvAvailableItems.InnerTreeView, FCollapsedAvailableItems);
    finally
      Items.EndUpdate;
      CancelUpdate;
    end;
  end;
  tvAvailableItems.ShowRoot := Control.CustomizeAvailableItemsViewKind = aivkTree;
end;

procedure TdxLayoutControlCustomizeForm.RefreshEnableds;
begin
  if not IsLocked then
  begin
    acAlignBy.Enabled := (tvItems.SelectionCount > 1);
    acAvailableItemsExpandAll.Enabled := Control.CustomizeAvailableItemsViewKind = aivkTree;
    acAvailableItemsCollapseAll.Enabled := Control.CustomizeAvailableItemsViewKind = aivkTree;
    acRestore.Enabled := Control.CanRestore;
    acTreeViewItemRename.Enabled := (tvItems.Selected <> nil) and (tvItems.SelectionCount = 1) and
      not (TObject(tvItems.Selected.Data) as TdxCustomLayoutItem).IsRoot and not TdxCustomLayoutItemAccess(tvItems.Selected.Data).IsParentLocked;
    acAvailableItemRename.Enabled := (tvAvailableItems.Selected <> nil) and (tvAvailableItems.SelectionCount = 1) and
      not TdxCustomLayoutItemAccess(tvAvailableItems.Selected.Data).IsParentLocked;
    acUndo.Enabled := Control.UndoRedoManager.CanUndo;
    acRedo.Enabled := Control.UndoRedoManager.CanRedo;
    acAddItem.Enabled := Control.IsDesigning;
    acTreeViewItemsDelete.Enabled := CanDeleteItems(tvItems);
    acAvailableItemsDelete.Enabled := CanDeleteItems(tvAvailableItems);
  end;
end;

procedure TdxLayoutControlCustomizeForm.RefreshTreeView;
begin
  with tvItems do
  begin
    BeginUpdate;
    Items.BeginUpdate;
    try
      StoreCollapsedNodes(tvItems.InnerTreeView, FCollapsedItems);
      Items.Clear;
      AddItemNode(Items, nil, Control.Items);
      RestoreCollapsedNodes(tvItems.InnerTreeView, FCollapsedItems);
    finally
      Items.EndUpdate;
      CancelUpdate;
    end;
  end;
end;

procedure TdxLayoutControlCustomizeForm.StoreTreeViewWndProc(ATreeView: TTreeView; var AStoredWndMethod: TWndMethod; ANewWndMethod: TWndMethod);
begin
  AStoredWndMethod := ATreeView.WindowProc;
  ATreeView.WindowProc := ANewWndMethod;
end;

procedure TdxLayoutControlCustomizeForm.RestoreTreeViewWndProc(ATreeView: TTreeView; var AStoredWndMethod: TWndMethod);
begin
  if Assigned(AStoredWndMethod) then
    ATreeView.WindowProc := AStoredWndMethod;
  AStoredWndMethod := nil;
end;

procedure TdxLayoutControlCustomizeForm.AddItemNode(ANodes: TTreeNodes; AParentNode: TTreeNode; AItem: TdxCustomLayoutItem; AAddChildren: Boolean = True);
var
  I: Integer;
  AThisNode: TTreeNode;
  AGroup: TdxLayoutGroup;
begin
  AThisNode := ANodes.AddChild(AParentNode, '');
  AThisNode.Data := AItem;
  AItem.FreeNotification(Self);
  RefreshNode(AThisNode);
  AThisNode.Selected := False;
  AThisNode.Focused := False;
  if AAddChildren and (AItem is TdxLayoutGroup) then
  begin
    AGroup := TdxLayoutGroup(AItem);
    for I := 0 to AGroup.Count - 1 do
      AddItemNode(ANodes, AThisNode, AGroup[I]);
  end;
end;

procedure TdxLayoutControlCustomizeForm.AvailableItemsWndProc(var Message: TMessage);
begin
  if not TreeViewWndProcHandler(tvAvailableItems.InnerTreeView, Message) then
    FAvailableItemsWndProc(Message);
end;

function TdxLayoutControlCustomizeForm.CreateItem(AClass: TdxCustomLayoutItemClass; const ACaption: string): TdxCustomLayoutItem;
begin
  SaveToUndo;
  BeginUpdate;
  try
    Result := Control.CreateItem(AClass);
    Result.Caption := ACaption;
    DoAfterInsertionItem(Result);
  finally
    CancelUpdate;
  end;
end;

procedure TdxLayoutControlCustomizeForm.DoAfterInsertionItem(AItem: TdxCustomLayoutItem);
var
  AIntf: IdxLayoutDesignerHelper;
begin
  if Supports(Control, IdxLayoutDesignerHelper, AIntf) then
  begin
    AIntf.SelectComponent(AItem);
    AIntf := nil;
  end;
end;

function TdxLayoutControlCustomizeForm.GetImageIndex(AItem: TdxCustomLayoutItem): Integer;
const
  AGroupIndexMap: array[Boolean, TdxLayoutDirection] of Integer = (
    (7, 8, 9),
    (17, 18, 19));
  ASeparatorIndexMap: array[Boolean] of Integer = (2, 3);
  ASplitterIndexMap: array[Boolean] of Integer = (4, 5);

var
  AGroup: TdxLayoutGroup;
begin
  if AItem is TdxLayoutGroup then
  begin
    AGroup := AItem as TdxLayoutGroup;
    Result := AGroupIndexMap[AGroup.Hidden and not AGroup.IsRoot, AGroup.LayoutDirection];
  end
  else
    if AItem is TdxLayoutEmptySpaceItem then
      Result := 6
    else
      if AItem is TdxLayoutLabeledItem then
        Result := 1
      else
        if AItem is TdxLayoutSeparatorItem then
          Result := ASeparatorIndexMap[(AItem as TdxLayoutSeparatorItem).IsVertical]
        else
          if AItem is TdxLayoutSplitterItem then
            Result := ASplitterIndexMap[(AItem as TdxLayoutSplitterItem).IsVertical]
          else
            Result := 0;
end;

function TdxLayoutControlCustomizeForm.GetIsLocked: Boolean;
begin
  Result := (LockCount > 0) or TdxCustomLayoutControlAccess(Control).IsUpdateLocked;
end;

procedure TdxLayoutControlCustomizeForm.InitializePopupMenu;
var
  I: Integer;
  AMenuItem: TMenuItem;
begin
  for I := 0 to pmAlign.Items.Count - 1 do
  begin
    AMenuItem := TMenuItem.Create(miAlignBy);
    AMenuItem.Caption := pmAlign.Items[I].Caption;
    AMenuItem.Action := pmAlign.Items[I].Action;
    miAlignBy.Add(AMenuItem);
  end;
end;

procedure TdxLayoutControlCustomizeForm.ItemsWndProc(var Message: TMessage);
begin
  if not TreeViewWndProcHandler(tvItems.InnerTreeView, Message) then
    FItemsWndProc(Message);
end;

procedure TdxLayoutControlCustomizeForm.RefreshImages;
begin
  cxTransformImages(ilItems, ilHelper, clWindow, False);
  if not IsXPManifestEnabled then
    cxTransformImages(ilItems, clWindow);
  ilItems.AddImages(ilHelper);
  ilHelper.Clear;
end;

procedure TdxLayoutControlCustomizeForm.RefreshLists(ARefreshSelection: Boolean = False);
begin
  if IsLocked then
    Exit;
  BeginUpdate;
  tvAvailableItems.Items.BeginUpdate;
  tvItems.Items.BeginUpdate;
  try
    tvAvailableItems.Items.Clear;
    tvItems.Items.Clear;
    RefreshAvailableItems;
    RefreshTreeView;
  finally
    tvItems.Items.EndUpdate;
    tvAvailableItems.Items.EndUpdate;
    CancelUpdate;
  end;
  if ARefreshSelection then
    UpdateSelection;
end;

procedure TdxLayoutControlCustomizeForm.RefreshNode(ANode: TTreeNode);
var
  AItem: TdxCustomLayoutItem;
begin
  AItem := ANode.Data;
  if AItem.IsRoot then
    ANode.Text := cxGetResourceString(@sdxLayoutControlRoot)
  else
    ANode.Text := AItem.CaptionForCustomizeForm;
  ANode.ImageIndex := GetImageIndex(AItem);
  ANode.SelectedIndex := ANode.ImageIndex;
end;

procedure TdxLayoutControlCustomizeForm.RefreshButtonStates;
begin
  acAvailableItemsViewAsList.Checked := Control.CustomizeAvailableItemsViewKind = aivkTree;
  acTabbedView.Checked := Control.CustomizeFormTabbedView;
  acHighlightRoot.Checked := Control.HighlightRoot;
  acShowDesignSelectors.Checked := Control.ShowDesignSelectors;

  RefreshEnableds;
end;

procedure TdxLayoutControlCustomizeForm.RefreshView;
const
  MainGroupDirectionMap: array[Boolean] of TdxLayoutDirection = (ldHorizontal, ldTabbed);
begin
  lcMainGroup1.LayoutDirection := MainGroupDirectionMap[Control.CustomizeFormTabbedView];
  acShowDesignSelectors.Visible := Control.IsDesigning;
  liShowDesignSelectors.Visible := acShowDesignSelectors.Visible;
  acHighlightRoot.Visible := Control.IsDesigning;
  liHighlightRoot.Visible := acHighlightRoot.Visible;
  acStore.Visible := not Control.IsDesigning;
  liStore.Visible := acStore.Visible;
  acRestore.Visible := not Control.IsDesigning;
  liRestore.Visible := acRestore.Visible;
  acUndo.Visible := not Control.IsDesigning;
  liUndo.Visible := acUndo.Visible;
  acRedo.Visible := not Control.IsDesigning;
  liRedo.Visible := acRedo.Visible;
  lsSeparator4.Visible := acRedo.Visible;
  acAddItem.Visible := Control.IsDesigning;
  liAddItem.Visible := acAddItem.Visible;

  acAlignBy.Visible := Control.IsDesigning;
  lsAlignBy.Visible := acAlignBy.Visible;
  liAlignBy.Visible := acAlignBy.Visible;

  lcMain.LayoutLookAndFeel := TdxCustomLayoutControlAccess(Control).GetLayoutLookAndFeel;
  RefreshButtonStates;
end;

procedure TdxLayoutControlCustomizeForm.SaveToUndo;
begin
  TdxCustomLayoutControlAccess(Control).SaveToUndo;
end;

function TdxLayoutControlCustomizeForm.CanSelectItem(AItem: TdxCustomLayoutItem): Boolean;
begin
  Result := (AItem <> nil) and not TdxCustomLayoutItemAccess(AItem).IsDestroying and
    Supports(Control, IdxLayoutDesignerHelper);
end;

procedure TdxLayoutControlCustomizeForm.SelectItem(AItem: TdxCustomLayoutItem);
var
  AIntf: IdxLayoutDesignerHelper;
begin
  if Supports(Control, IdxLayoutDesignerHelper, AIntf) then
  begin
    if AItem <> nil then
      AIntf.SelectComponent(AItem)
    else
      AIntf.SelectComponent(Control);
    AIntf := nil;
  end;
  RefreshEnableds;
end;

procedure TdxLayoutControlCustomizeForm.SetItemsSelections(AList: TList);

  procedure SetTreeViewAsActiveControl(ATreeView: TcxTreeView);
  begin
    if ATreeView.Visible then
      ActiveControl := ATreeView.InnerTreeView
    else
      ActiveControl := nil;
  end;

var
  AItem: TdxCustomLayoutItemAccess;
begin
  if IsLocked then
    Exit;
  BeginUpdate;
  try
    cxTreeViewSyncSelection(tvItems.InnerTreeView, AList);
    cxTreeViewSyncSelection(tvAvailableItems.InnerTreeView, AList);
    if (AList.Count > 0) and (TObject(AList.Last) is TdxCustomLayoutItem) then
    begin
      AItem := TdxCustomLayoutItemAccess(AList.Last);
      if AItem.IsAvailable then
        SetTreeViewAsActiveControl(tvAvailableItems)
      else
        SetTreeViewAsActiveControl(tvItems);
    end;
  finally
    CancelUpdate;
  end;
  RefreshEnableds;
end;

procedure TdxLayoutControlCustomizeForm.SetLayoutItemsSelections(ATreeView: TTreeView);
var
  AList: TList;
  AIntf: IdxLayoutDesignerHelper;
begin
  AList := TList.Create;
  try
    cxTreeViewGetSelection(ATreeView, AList);
    if Supports(Control, IdxLayoutDesignerHelper, AIntf) then
    begin
      AIntf.SetSelection(AList);
      AIntf := nil;
    end;
  finally
    AList.Free;
  end;
end;

function TdxLayoutControlCustomizeForm.TreeViewWndProcHandler(ATreeView: TTreeView; var Message: TMessage): Boolean;

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
            SetLayoutItemsSelections(ATreeView);
          end;
        end;
        Message.Result := 1;
        Result := True;
      end;
    WM_LBUTTONDOWN:
      begin
        ANode := ATreeView.GetNodeAt(Message.LParamLo, Message.LParamHi);
        if (ANode <> nil) and (ATreeView.SelectionCount > 1) then
        begin
          ANode.Focused := True;
          AShift := KeysToShiftState(Message.WParam);
          if ANode.Selected and ([ssCtrl, ssShift] * AShift = []) then
          begin
            BeginUpdate;
            try
              ATreeView.ClearSelection;
            finally
              CancelUpdate;
            end;
          end;
        end;
      end;
  end;
end;

procedure TdxLayoutControlCustomizeForm.RestoreCollapsedNodes(ATreeView: TTreeView; AList: TcxComponentList);
var
  I: Integer;
  ANode: TTreeNode;
begin
  ATreeView.FullExpand;
  for I := 0 to AList.Count - 1 do
    if GetNode(AList[I] as TdxCustomLayoutItem, ANode) then
      ANode.Expanded := False;
  AList.Clear;
end;

procedure TdxLayoutControlCustomizeForm.StoreCollapsedNodes(ATreeView: TTreeView; AList: TcxComponentList);

  procedure CheckNode(ANode: TTreeNode);
  var
    I: Integer;
  begin
    if ANode.HasChildren then
    begin
      if not ANode.Expanded then
        AList.Add(TComponent(ANode.Data));
      for I := 0 to ANode.Count - 1 do
        CheckNode(ANode[I]);
    end;
  end;

  procedure CheckTreeView(ATreeView: TTreeView);
  var
    I: Integer;
  begin
    for I := 0 to ATreeView.Items.Count - 1 do
      CheckNode(ATreeView.Items[I]);
  end;

begin
  if AList.Count > 0 then
    Exit;
  CheckTreeView(ATreeView);
end;

procedure TdxLayoutControlCustomizeForm.acCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TdxLayoutControlCustomizeForm.acAddGroupExecute(Sender: TObject);
begin
  CreateItem(TdxCustomLayoutControlAccess(Control).GetDefaultGroupClass, cxGetResourceString(@sdxLayoutControlNewGroupCaption));
end;

procedure TdxLayoutControlCustomizeForm.acAddItemExecute(Sender: TObject);
begin
  CreateItem(TdxCustomLayoutControlAccess(Control).GetDefaultItemClass, cxGetResourceString(@sdxLayoutControlNewItemCaption));
end;

procedure TdxLayoutControlCustomizeForm.acAddEmptySpaceItemExecute(Sender: TObject);
var
  AItem: TdxCustomLayoutItem;
begin
  AItem := CreateItem(TdxLayoutEmptySpaceItem, cxGetResourceString(@sdxLayoutControlNewEmptySpaceItemCaption));
  AItem.Width := 10;
  AItem.Height := 10;
end;

procedure TdxLayoutControlCustomizeForm.acAddSeparatorExecute(Sender: TObject);
begin
  CreateItem(TdxLayoutSeparatorItem, cxGetResourceString(@sdxLayoutControlNewSeparatorItemCaption));
end;

procedure TdxLayoutControlCustomizeForm.acAddCustomItemExecute(
  Sender: TObject);
begin
//
end;

procedure TdxLayoutControlCustomizeForm.acAddLabeledItemExecute(
  Sender: TObject);
begin
  CreateItem(TdxLayoutLabeledItem, cxGetResourceString(@sdxLayoutControlNewLabeledItemCaption));
end;

procedure TdxLayoutControlCustomizeForm.acAddSplitterExecute(
  Sender: TObject);
var
  AItem: TdxCustomLayoutItem;
begin
  SaveToUndo;
  AItem := Control.CreateItem(TdxLayoutSplitterItem);
  AItem.Caption := cxGetResourceString(@sdxLayoutControlNewSplitterItemCaption);
  DoAfterInsertionItem(AItem);
end;

procedure TdxLayoutControlCustomizeForm.tvItemsEdited(Sender: TObject; Node: TTreeNode;
  var S: String);
begin
  if TdxCustomLayoutItem(Node.Data).IsRoot then
    Exit;
  SaveToUndo;
  RefreshButtonStates;
  BeginUpdate;
  try
    if Control.IsDesigning then
      TdxCustomLayoutItem(Node.Data).Name := S
    else
      TdxCustomLayoutItem(Node.Data).Caption := S;
    Node.Text := TdxCustomLayoutItem(Node.Data).CaptionForCustomizeForm;
  finally
    CancelUpdate;
  end;
end;

procedure TdxLayoutControlCustomizeForm.tvItemsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  ANode: TTreeNode;
  ATreeView: TcxTreeView;
  AHitTests: THitTests;
begin
  ATreeView := TcxTreeView(Sender);
  AHitTests := ATreeView.GetHitTestInfoAt(X, Y);
  if htOnItem in AHitTests then
  begin
    ANode := ATreeView.GetNodeAt(X, Y);
    if ANode = nil then
      Exit;
    if (Button = mbLeft) and ANode.Selected and (ANode = ATreeView.Selected) then
      DragHelper.InitializeDragItem(ATreeView.Selected.Data, X, Y);
  end;
end;

procedure TdxLayoutControlCustomizeForm.ItemsMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  ASource: TdxLayoutDragSource;
begin
  if Sender = tvItems then
    ASource := dsCustomizeFormTreeViewItems
  else
    ASource := dsCustomizeFormAvailableItems;
  if ssLeft in Shift then
    DragHelper.TryBeginDragAndDrop(X, Y, ASource);
end;

procedure TdxLayoutControlCustomizeForm.ItemsMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    DragHelper.Reset;
end;

procedure TdxLayoutControlCustomizeForm.tvItemsChange(Sender: TObject; Node: TTreeNode);
begin
  if not IsLocked then
    SetLayoutItemsSelections(Sender as TTreeView);
end;

procedure TdxLayoutControlCustomizeForm.tvItemsChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin
  AllowChange := (Node = nil) or (Node.Data <> nil);
end;

procedure TdxLayoutControlCustomizeForm.AlignExecute(Sender: TObject);
var
  AList: TList;
  I: Integer;
  ATag: Integer;
  AIntf: IdxLayoutDesignerHelper;
begin
  //todo: TdxLayoutControlAccess(Control).SaveToUndo;
  ATag := (Sender as TAction).Tag;
  AList := TList.Create;
  try
    if Supports(Control, IdxLayoutDesignerHelper, AIntf) then
    begin
      AIntf.GetSelection(AList);
      AIntf := nil;
    end;
    BeginUpdate;
    try
      Control.BeginUpdate;
      try
        if ATag = -1 then
          for I := 0 to AList.Count - 1 do
            TdxCustomLayoutItem(AList[I]).AlignmentConstraint := nil
        else
          with Control.CreateAlignmentConstraint do
          begin
            Kind := TdxLayoutAlignmentConstraintKind(ATag);
            for I := 0 to AList.Count - 1 do
              AddItem(TdxCustomLayoutItem(AList[I]));
          end;
      finally
        Control.EndUpdate;
      end;
    finally
      CancelUpdate;
    end;
  finally
    AList.Free;
  end;
end;

procedure TdxLayoutControlCustomizeForm.acTreeViewItemsDeleteExecute(Sender: TObject);
var
  AList: TComponentList;
begin
  if tvItems.IsEditing then
    tvItems.Selected.EndEdit(True);
  AList := TComponentList.Create;
  try
    cxTreeViewGetSelection(tvItems.InnerTreeView, AList);
    DeleteItems(AList, tvItems.InnerTreeView);
    RefreshTreeView;
    UpdateSelection;
  finally
    AList.Free;
  end;
end;

procedure TdxLayoutControlCustomizeForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  cxDialogsMetricsStore.StoreMetrics(Self);
  Action := caFree;
end;

procedure TdxLayoutControlCustomizeForm.tvItemsContextPopup(
  Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
  acAvailableItemsDelete.Enabled := False;
end;

procedure TdxLayoutControlCustomizeForm.acAvailableItemsDeleteExecute(
  Sender: TObject);
var
  AList: TComponentList;
begin
  AList := TComponentList.Create;
  try
    cxTreeViewGetSelection(tvAvailableItems.InnerTreeView, AList);
    DeleteItems(AList, tvAvailableItems.InnerTreeView);
    RefreshAvailableItems;
    UpdateSelection;
  finally
    AList.Free;
  end;
end;

procedure TdxLayoutControlCustomizeForm.tvItemsCustomDrawItem(
  Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState;
  var DefaultDraw: Boolean);
  function IsDestination(AItem: TdxCustomLayoutItem): Boolean;
  begin
    Result := (dxLayoutDragAndDropObject <> nil) and (TdxLayoutDragAndDropObjectAccess(dxLayoutDragAndDropObject).DestinationItem = AItem);
  end;

begin
  if Node.Deleting then
    Exit;
  if (TObject(Node.Data) is TdxLayoutGroup) and TdxLayoutGroup(Node.Data).Hidden and
      not TdxLayoutGroup(Node.Data).IsRoot then
    Sender.Canvas.Font.Style := [fsItalic];
  if IsDestination(Node.Data) then
  begin
    Sender.Canvas.Font.Color := clHighlightText;
    Sender.Canvas.Brush.Color := clHighlight;
  end;
end;

procedure TdxLayoutControlCustomizeForm.tvAvailableItemsContextPopup(
  Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
  acTreeViewItemsDelete.Enabled := False;
end;

procedure TdxLayoutControlCustomizeForm.acAvailableItemsExpandAllExecute(
  Sender: TObject);
begin
  tvAvailableItems.FullExpand;
end;

procedure TdxLayoutControlCustomizeForm.acAvailableItemsCollapseAllExecute(
  Sender: TObject);
begin
  tvAvailableItems.FullCollapse;
end;

procedure TdxLayoutControlCustomizeForm.acTreeViewExpandAllExecute(
  Sender: TObject);
begin
  tvItems.FullExpand;
end;

procedure TdxLayoutControlCustomizeForm.acTreeViewCollapseAllExecute(
  Sender: TObject);
begin
  tvItems.FullCollapse;
end;

procedure TdxLayoutControlCustomizeForm.acAvailableItemsViewAsListExecute(
  Sender: TObject);
const
  AViewKindMap: array [Boolean] of TdxLayoutAvailableItemsViewKind = (aivkList, aivkTree);
begin
  Control.CustomizeAvailableItemsViewKind := AViewKindMap[acAvailableItemsViewAsList.Checked];
end;

procedure TdxLayoutControlCustomizeForm.tvItemsEditing(Sender: TObject;
  Node: TTreeNode; var AllowEdit: Boolean);

  function IsKeyDown(AShift: TShiftState): Boolean;
  begin
    Result := (AShift * KeyboardStateToShiftState) <> [];
  end;

begin
  AllowEdit := not (TdxCustomLayoutItem(Node.Data).IsRoot or (DragHelper.DragItem <> nil) or
    IsKeyDown([ssCtrl, ssShift]) or TdxCustomLayoutItemAccess(Node.Data).IsParentLocked);
  if not AllowEdit or Control.IsDesigning then
    Exit;
  RefreshEnableds;
end;

procedure TdxLayoutControlCustomizeForm.FormShortCut(var Msg: TWMKey;
  var Handled: Boolean);
begin
  case Msg.CharCode of
    VK_ESCAPE:
      begin
        Handled := tvItems.IsEditing or tvAvailableItems.IsEditing;
        if Handled then
          if tvItems.Selected <> nil then
            tvItems.Selected.EndEdit(True)
          else
            if tvAvailableItems.Selected <> nil then
              tvAvailableItems.Selected.EndEdit(True);
      end;
  end;
end;

procedure TdxLayoutControlCustomizeForm.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DELETE then
  begin
    if tvItems.Focused and not tvItems.IsEditing then
      acTreeViewItemsDelete.Execute;
    if tvAvailableItems.Focused and not tvAvailableItems.IsEditing then
      acAvailableItemsDelete.Execute;
  end;
end;

procedure TdxLayoutControlCustomizeForm.acTabbedViewExecute(
  Sender: TObject);
begin
  Control.CustomizeFormTabbedView := acTabbedView.Checked;
end;

procedure TdxLayoutControlCustomizeForm.acHighlightRootExecute(
  Sender: TObject);
begin
  Control.HighlightRoot := acHighlightRoot.Checked;
end;

procedure TdxLayoutControlCustomizeForm.acShowDesignSelectorsExecute(
  Sender: TObject);
begin
  Control.ShowDesignSelectors := acShowDesignSelectors.Checked;
end;

procedure TdxLayoutControlCustomizeForm.acStoreExecute(Sender: TObject);
begin
  Control.Store;
  RefreshEnableds;
end;

procedure TdxLayoutControlCustomizeForm.acRestoreExecute(Sender: TObject);
begin
  SaveToUndo;
  Control.Restore;
end;

procedure TdxLayoutControlCustomizeForm.acTreeViewItemRenameExecute(
  Sender: TObject);
begin
  tvItems.Selected.EditText;
end;

procedure TdxLayoutControlCustomizeForm.acAvailableItemRenameExecute(
  Sender: TObject);
begin
  tvAvailableItems.Selected.EditText;
end;

procedure TdxLayoutControlCustomizeForm.acUndoExecute(Sender: TObject);
begin
  Control.UndoRedoManager.Undo;
  RefreshButtonStates;
end;

procedure TdxLayoutControlCustomizeForm.acRedoExecute(Sender: TObject);
begin
  Control.UndoRedoManager.Redo;
  RefreshButtonStates;
end;

procedure TdxLayoutControlCustomizeForm.acAlignByExecute(Sender: TObject);
begin
// for popup
end;

procedure TdxLayoutControlCustomizeForm.acHAlignExecute(Sender: TObject);
var
  AList: TList;
  I: Integer;
begin
  if tvItems.IsEditing then
    Exit;
  SaveToUndo;
  AList := TList.Create;
  try
    cxTreeViewGetSelection(tvItems.InnerTreeView, AList);
    for I := 0 to AList.Count - 1 do
      TdxCustomLayoutItem(AList[I]).AlignHorz := TdxLayoutAlignHorz((Sender as TAction).Tag);
    TdxCustomLayoutControlAccess(Control).Modified;
  finally
    AList.Free;
  end;
end;

procedure TdxLayoutControlCustomizeForm.pmTreeViewActionsPopup(
  Sender: TObject);

  procedure ResetSubMenu(AMenu: TMenuItem);
  var
    I: Integer;
  begin
    for I := 0 to AMenu.Count - 1 do
      TAction(AMenu.Items[I].Action).Checked := False;
  end;

  function IsContainGroupInSelections: Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 0 to tvItems.SelectionCount - 1 do
    begin
      Result := TObject(tvItems.Selections[I].Data) is TdxLayoutGroup;
      if Result then
        Break;
    end;
  end;

  function IsContainLockedItemInSelections: Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 0 to tvItems.SelectionCount - 1 do
    begin
      Result := TdxCustomLayoutItemAccess(tvItems.Selections[I].Data).IsParentLocked;
      if Result then
        Break;
    end;
  end;

var
  AItem: TdxCustomLayoutItem;
  AHitTest: TdxCustomLayoutHitTest;
  APopupForTree: Boolean;
  AIsContainLockedItem: Boolean;
  AIsContainGroup: Boolean;
begin
  AHitTest := Control.GetHitTest(Control.ScreenToClient(GetMouseCursorPos));
  APopupForTree := AHitTest.HitTestCode = htTreeViewItems;
  miTreeViewItemRename.Visible := APopupForTree;
  miExpandAll.Visible := APopupForTree;
  miCallapseAll.Visible := APopupForTree;
  miSeparator1.Visible := APopupForTree;

  AIsContainLockedItem := IsContainLockedItemInSelections;
  AIsContainGroup := IsContainGroupInSelections;

  miDirection.Visible := AIsContainGroup;
  miShowBorder.Visible := AIsContainGroup;

  miDirection.Enabled := not AIsContainLockedItem;
  miAlignHorz.Enabled := not AIsContainLockedItem;
  miAlignVert.Enabled := not AIsContainLockedItem;

  if tvItems.SelectionCount = 1 then
  begin
    AItem := TdxCustomLayoutItem(tvItems.Selected.Data);
    TAction(miAlignHorz.Items[Integer(AItem.AlignHorz)].Action).Checked := True;
    TAction(miAlignVert.Items[Integer(AItem.AlignVert)].Action).Checked := True;
    if AItem is TdxLayoutGroup then
    begin
      TAction(miDirection.Items[Integer((AItem as TdxLayoutGroup).LayoutDirection)].Action).Checked := True;
      acShowBorder.Checked := (AItem as TdxLayoutGroup).ShowBorder;
    end;
  end
  else
  begin
    ResetSubMenu(miAlignHorz);
    ResetSubMenu(miAlignVert);
    ResetSubMenu(miDirection);
  end;
end;

procedure TdxLayoutControlCustomizeForm.acVAlignExecute(
  Sender: TObject);
var
  AList: TList;
  I: Integer;
begin
  if tvItems.IsEditing then
    Exit;
  SaveToUndo;
  AList := TList.Create;
  try
    cxTreeViewGetSelection(tvItems.InnerTreeView, AList);
    for I := 0 to AList.Count - 1 do
      TdxCustomLayoutItem(AList[I]).AlignVert := TdxLayoutAlignVert((Sender as TAction).Tag);
    TdxCustomLayoutControlAccess(Control).Modified;
  finally
    AList.Free;
  end;
end;

procedure TdxLayoutControlCustomizeForm.acDirectionsExecute(
  Sender: TObject);
var
  AList: TList;
  I: Integer;
  ANewDirection: TdxLayoutDirection;
begin
  if tvItems.IsEditing then
    Exit;
  SaveToUndo;
  AList := TList.Create;
  try
    cxTreeViewGetSelection(tvItems.InnerTreeView, AList);
    ANewDirection := TdxLayoutDirection((Sender as TAction).Tag);
    for I := 0 to AList.Count - 1 do
      if TObject(AList[I]) is TdxLayoutGroup then
        TdxLayoutGroup(AList[I]).LayoutDirection := ANewDirection;
    TdxCustomLayoutControlAccess(Control).Modified;
  finally
    AList.Free;
  end;
  tvItems.Invalidate;
end;

procedure TdxLayoutControlCustomizeForm.acShowBorderExecute(
  Sender: TObject);
var
  AList: TList;
  I: Integer;
begin
  if tvItems.IsEditing then
    Exit;
  SaveToUndo;
  acShowBorder.Checked := not acShowBorder.Checked;
  AList := TList.Create;
  try
    cxTreeViewGetSelection(tvItems.InnerTreeView, AList);
    for I := 0 to AList.Count - 1 do
      if TObject(AList[I]) is TdxLayoutGroup then
        TdxLayoutGroup(AList[I]).ShowBorder := (Sender as TAction).Checked;
    TdxCustomLayoutControlAccess(Control).Modified;
  finally
    AList.Free;
  end;
end;

procedure TdxLayoutControlCustomizeForm.tvItemsDeletion(
  Sender: TObject; Node: TTreeNode);
var
  ANode: TTreeNode;
begin
  (TObject(Node.Data) as TdxCustomLayoutItem).RemoveFreeNotification(Self);
  if Node = Node.TreeView.Selected then
  begin
    ANode := Node.GetNext;
    if ANode = nil then
      ANode := Node.GetPrev;
    if (ANode <> nil) and CanSelectItem(ANode.Data) then
    begin
      ANode.Selected := True;
      SelectItem(ANode.Data);
    end;
  end;
end;

end.
