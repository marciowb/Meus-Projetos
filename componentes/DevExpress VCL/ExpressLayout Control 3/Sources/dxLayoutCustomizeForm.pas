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
  cxLookAndFeels, cxTreeView, cxCheckBox, dxLayoutcxEditAdapters, dxLayoutContainer,
  dxLayoutControlAdapters;

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
    miHLeft: TMenuItem;
    miHCenter: TMenuItem;
    miHRight: TMenuItem;
    miHClient: TMenuItem;
    miHParentManaged: TMenuItem;
    acVAlignTop: TAction;
    acVAlignBottom: TAction;
    acVAlignCenter: TAction;
    acVAlignClient: TAction;
    acVAlignParent: TAction;
    miAlignVert: TMenuItem;
    miVAlignTop: TMenuItem;
    miVAlignCenter: TMenuItem;
    miVAlignBottom: TMenuItem;
    miVAlignClient: TMenuItem;
    miVAlignParent: TMenuItem;
    acDirectionHorizontal: TAction;
    acDirectionVertical: TAction;
    acDirectionTabbed: TAction;
    miDirection: TMenuItem;
    miDirectionHorizontal: TMenuItem;
    miDirectionVertical: TMenuItem;
    miDirectionTabbed: TMenuItem;
    acAddEmptySpaceItem: TAction;
    acBorder: TAction;
    miBorder: TMenuItem;
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
    acExpandButton: TAction;
    miExpandButton: TMenuItem;
    miTextPosition: TMenuItem;
    miTextPositionLeft: TMenuItem;
    miTextPositionTop: TMenuItem;
    miTextPositionRight: TMenuItem;
    miTextPositionBottom: TMenuItem;
    acTextPositionLeft: TAction;
    acTextPositionTop: TAction;
    acTextPositionRight: TAction;
    acTextPositionBottom: TAction;
    miCaptionAlignHorz: TMenuItem;
    miCaptionAlignHorzLeft: TMenuItem;
    miCaptionAlignHorzCenter: TMenuItem;
    miCaptionAlignHorzRight: TMenuItem;
    acCaptionAlignHorzLeft: TAction;
    acCaptionAlignHorzCenter: TAction;
    acCaptionAlignHorzRight: TAction;
    miCaption: TMenuItem;
    acCaption: TAction;
    miCaptionAlignVert: TMenuItem;
    miCaptionAlignVertTop: TMenuItem;
    miCaptionAlignVertCenter: TMenuItem;
    miCaptionAlignVertBottom: TMenuItem;
    acCaptionAlignVertTop: TAction;
    acCaptionAlignVertCenter: TAction;
    acCaptionAlignVertBottom: TAction;
    miGroup: TMenuItem;
    miUngroup: TMenuItem;
    acGroup: TAction;
    acUngroup: TAction;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
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
    procedure acBorderExecute(Sender: TObject);
    procedure acAddSeparatorExecute(Sender: TObject);
    procedure acAddCustomItemExecute(Sender: TObject);
    procedure acAddLabeledItemExecute(Sender: TObject);
    procedure acAddSplitterExecute(Sender: TObject);
    procedure tvItemsDeletion(Sender: TObject; Node: TTreeNode);
    procedure acExpandButtonExecute(Sender: TObject);
    procedure acTextPositionExecute(Sender: TObject);
    procedure acCaptionAlignHorzExecute(Sender: TObject);
    procedure acCaptionExecute(Sender: TObject);
    procedure acCaptionAlignVertExecute(Sender: TObject);
    procedure acGroupExecute(Sender: TObject);
    procedure acUngroupExecute(Sender: TObject);
  private
    FDragHelper: TdxLayoutDragAndDropHelper;
    FCollapsedAvailableItems: TcxComponentList;
    FCollapsedItems: TcxComponentList;
    FLockCount: Integer;
    FAvailableItemsWndProc: TWndMethod;
    FItemsWndProc: TWndMethod;
    procedure AddItemNode(ANodes: TTreeNodes; AParentNode: TTreeNode; AItem: TdxCustomLayoutItem; AAddChildren: Boolean = True);
    procedure AvailableItemsWndProc(var Message: TMessage);
    function DoCreateItem(AClass: TdxCustomLayoutItemClass; const ACaption: string): TdxCustomLayoutItem;
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
    procedure RefreshAvailableItems;
    procedure RefreshEnableds; virtual;
    procedure RefreshLayoutLookAndFeel; virtual;
    procedure RefreshStoring; virtual;
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
  TdxCustomLayoutItemAccess = class(TdxCustomLayoutItem);
  TdxCustomLayoutItemViewInfoAccess = class(TdxCustomLayoutItemViewInfo);
  TdxLayoutContainerAccess = class(TdxLayoutContainer);
  TdxCustomLayoutItemCaptionOptionsAccess = class(TdxCustomLayoutItemCaptionOptions);
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

function CompareItemsByIndex(Item1, Item2: Pointer): Integer;
var
  AItem1, AItem2: TdxCustomLayoutItem;
begin
  AItem1 := TdxCustomLayoutItem(Item1);
  AItem2 := TdxCustomLayoutItem(Item2);
  Result := AItem1.Index - AItem2.Index;
end;

function CompareItems(Item1, Item2: Pointer): Integer;
begin
  Result := CompareItemsByClass(Item1, Item2);
  if (Result = 0) and (TObject(Item1) is TdxLayoutGroup) then
    Result := Integer(TdxLayoutGroup(Item1).Count > 0) - Integer(TdxLayoutGroup(Item2).Count > 0);
  if Result = 0 then
    Result := CompareItemsByName(Item1, Item2);
end;

function GetGeneralParent(AItem: TdxCustomLayoutItem): TdxLayoutGroup;
begin
  Result := AItem.Parent;
  if (Result <> nil) and Result.Hidden and not Result.IsRoot then
    Result := GetGeneralParent(Result);
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
  inherited Destroy;
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
      if (dxLayoutDragAndDropObject <> nil) and (TdxLayoutDragAndDropObjectAccess(dxLayoutDragAndDropObject).Container = Container) then
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
  AHitTest: TdxCustomLayoutHitTest;
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
    TdxLayoutCustomizeFormHitTest(Result).Item := AItem;
    TdxLayoutCustomizeFormHitTest(Result).AreaPart := GetAreaPart(AItem);
  end
  else
  begin
    TdxLayoutCustomizeFormHitTest(Result).Item := nil;
    AHitTest := lcMain.GetHitTest(P);
    if (AHitTest <> nil) and ((AHitTest.GetDestinationItem = lcgTreeView) or (AHitTest.GetDestinationItem = lcgAvailableItems)) then
      TdxLayoutContainerAccess(lcMain.Container).MakeVisible(AHitTest.GetDestinationItem);
  end;

  TdxLayoutCustomizeFormHitTest(Result).Container := Container;
end;

procedure TdxLayoutControlCustomizeForm.ToggleHotTrackState(AItem: TdxCustomLayoutItem);
var
  ANode: TTreeNode;
  R: TRect;
begin
  if GetNode(AItem, ANode) and ANode.IsVisible then
  begin
    R := ANode.DisplayRect(False);
    if ANode.HasChildren and not ANode.Expanded then
      ANode.Expand(False)
    else
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
  if Container.IsDesigning then
    Caption := Format(cxGetResourceString(@sdxLayoutControlDesignerCaptionFormat),
      [cxGetFullComponentName(Container.ILayout.GetItemsParentComponent)])
  else
    Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormCaption);
end;

procedure TdxLayoutControlCustomizeForm.UpdateContent;
begin
  RefreshLists;
end;

procedure TdxLayoutControlCustomizeForm.UpdateDragAndDropState;
begin
  if FDragHelper.DragItem <> nil then
  begin
    if Container.ItemsParent.DragAndDropState = ddsNone then
      FDragHelper.Reset;
  end;
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
    if Supports(Container, IdxLayoutDesignerHelper, AIntf) then
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

procedure TdxLayoutControlCustomizeForm.RefreshStoring;
begin
  acStore.Visible := not Container.IsDesigning;
  liStore.Visible := acStore.Visible;
  acRestore.Visible := not Container.IsDesigning;
  liRestore.Visible := acRestore.Visible;
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
    if GetNode(AItem, ANode) then
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
          if Supports(Container, IdxLayoutDesignerHelper, AIntf) then
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
    Container.BeginUpdate;
    try
      while AList.Count > 0 do
        AList[0].Free;
    finally
      Container.EndUpdate;
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
  Result := (Container <> nil) and (AItem.Container = Container);
  if Result then
  begin
    ANode := FindNode(tvAvailableItems.Items);
    if ANode = nil then
      ANode := FindNode(tvItems.Items);
    Result := ANode <> nil;
  end;
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
    FDragHelper := TdxLayoutDragAndDropHelper.Create(Container);
    inherited InitializeControl;
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

  miTextPosition.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormTextPosition);
  acTextPositionLeft.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormTextPositionLeft);
  acTextPositionTop.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormTextPositionTop);
  acTextPositionRight.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormTextPositionRight);
  acTextPositionBottom.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormTextPositionBottom);

  miCaptionAlignHorz.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormCaptionAlignHorz);
  acCaptionAlignHorzLeft.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormCaptionAlignHorzLeft);
  acCaptionAlignHorzCenter.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormCaptionAlignHorzCenter);
  acCaptionAlignHorzRight.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormCaptionAlignHorzRight);

  miCaptionAlignVert.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormCaptionAlignVert);
  acCaptionAlignVertTop.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormCaptionAlignVertTop);
  acCaptionAlignVertCenter.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormCaptionAlignVertCenter);
  acCaptionAlignVertBottom.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormCaptionAlignVertBottom);

  acCaption.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormItemCaption);

  acBorder.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormGroupBorder);
  acExpandButton.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormGroupExpandButton);

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

  acGroup.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormGroup);
  acUngroup.Caption := cxGetResourceString(@sdxLayoutControlCustomizeFormUngroup);
end;

procedure TdxLayoutControlCustomizeForm.RefreshAvailableItems;

  procedure PopulateItemChildren(AList: TList; AItem: TdxCustomLayoutItem);
  var
    I: Integer;
  begin
    if AItem is TdxLayoutGroup then
    begin
      for I := 0 to TdxLayoutGroup(AItem).Count - 1 do
        if CanShowItem(TdxLayoutGroup(AItem).Items[I]) then
        begin
          AList.Add(TdxLayoutGroup(AItem).Items[I]);
          PopulateItemChildren(AList, TdxLayoutGroup(AItem).Items[I]);
        end;
    end;
  end;

  procedure PopulateItems(AList: TList);
  var
    I: Integer;
    AItem: TdxCustomLayoutItem;
  begin
    for I := 0 to Container.AvailableItemCount - 1 do
    begin
      AItem := Container.AvailableItems[I];
      if CanShowItem(AItem) then
      begin
        AList.Add(AItem);
        if Container.CustomizeAvailableItemsViewKind = aivkList then
          PopulateItemChildren(AList, AItem);
      end;
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
        case Container.CustomizeAvailableItemsViewKind of
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
  tvAvailableItems.ShowRoot := Container.CustomizeAvailableItemsViewKind = aivkTree;
end;

procedure TdxLayoutControlCustomizeForm.RefreshEnableds;
var
  ACanModify: Boolean;
begin
  if not IsLocked then
  begin
    ACanModify := CanModify;
    acAlignBy.Enabled := (tvItems.SelectionCount > 1) and ACanModify;
    acAvailableItemsExpandAll.Enabled := Container.CustomizeAvailableItemsViewKind = aivkTree;
    acAvailableItemsCollapseAll.Enabled := Container.CustomizeAvailableItemsViewKind = aivkTree;
    acStore.Enabled := Container.ILayout.StoringSupports;
    acRestore.Enabled := Container.ILayout.StoringSupports and Container.ILayout.CanRestore;
    acTreeViewItemRename.Enabled := ACanModify and (tvItems.Selected <> nil) and (tvItems.SelectionCount = 1) and
      not (TObject(tvItems.Selected.Data) as TdxCustomLayoutItem).IsRoot and not TdxCustomLayoutItemAccess(tvItems.Selected.Data).IsParentLocked;
    acAvailableItemRename.Enabled := ACanModify and (tvAvailableItems.Selected <> nil) and (tvAvailableItems.SelectionCount = 1) and
      not TdxCustomLayoutItemAccess(tvAvailableItems.Selected.Data).IsParentLocked;
    acUndo.Enabled := Container.UndoRedoManager.CanUndo;
    acRedo.Enabled := Container.UndoRedoManager.CanRedo;
    acAddItem.Enabled := Container.IsDesigning and ACanModify;
    acTreeViewItemsDelete.Enabled := CanDeleteItems(tvItems);
    acAvailableItemsDelete.Enabled := CanDeleteItems(tvAvailableItems);
    acAddGroup.Enabled := ACanModify;
    acAddEmptySpaceItem.Enabled := ACanModify;
    acAlignLeftSide.Enabled := ACanModify;
    acAlignRightSide.Enabled := ACanModify;
    acAlignTopSide.Enabled := ACanModify;
    acAlignBottomSide.Enabled := ACanModify;
    acAlignNone.Enabled := ACanModify;
    acAvailableItemsViewAsList.Enabled := ACanModify;
    acTabbedView.Enabled := ACanModify;
    acHighlightRoot.Enabled := ACanModify;
    acShowDesignSelectors.Enabled := ACanModify;
    acHAlignLeft.Enabled := ACanModify;
    acHAlignRight.Enabled := ACanModify;
    acHAlignCenter.Enabled := ACanModify;
    acHAlignClient.Enabled := ACanModify;
    acHAlignRight.Enabled := ACanModify;
    acHAlignParent.Enabled := ACanModify;
    acVAlignTop.Enabled := ACanModify;
    acVAlignBottom.Enabled := ACanModify;
    acVAlignCenter.Enabled := ACanModify;
    acVAlignClient.Enabled := ACanModify;
    acVAlignParent.Enabled := ACanModify;
    acDirectionHorizontal.Enabled := ACanModify;
    acDirectionVertical.Enabled := ACanModify;
    acDirectionTabbed.Enabled := ACanModify;
    acAddEmptySpaceItem.Enabled := ACanModify;
    acBorder.Enabled := ACanModify;
    acAddSeparator.Enabled := ACanModify;
    acAddSplitter.Enabled := ACanModify;
    acAddLabeledItem.Enabled := ACanModify;
    acExpandButton.Enabled := ACanModify;
    miAlignHorz.Enabled := ACanModify;
    miDirection.Enabled := ACanModify;
    miAlignVert.Enabled := ACanModify;
    acAddCustomItem.Enabled := ACanModify;
  end;
end;

procedure TdxLayoutControlCustomizeForm.RefreshLayoutLookAndFeel;
begin
  lcMain.LayoutLookAndFeel := Container.ILayout.GetLayoutLookAndFeel;
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
      AddItemNode(Items, nil, Container.Root);
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
      if CanShowItem(AGroup[I]) then
        AddItemNode(ANodes, AThisNode, AGroup[I]);
  end;
end;

procedure TdxLayoutControlCustomizeForm.AvailableItemsWndProc(var Message: TMessage);
begin
  if not TreeViewWndProcHandler(tvAvailableItems.InnerTreeView, Message) then
    FAvailableItemsWndProc(Message);
end;

function TdxLayoutControlCustomizeForm.DoCreateItem(AClass: TdxCustomLayoutItemClass; const ACaption: string): TdxCustomLayoutItem;
begin
  Result := Container.CreateItem(AClass);
  Result.Caption := ACaption;
end;

function TdxLayoutControlCustomizeForm.CreateItem(AClass: TdxCustomLayoutItemClass; const ACaption: string): TdxCustomLayoutItem;
begin
  SaveToUndo;
  BeginUpdate;
  try
    Result := DoCreateItem(AClass, ACaption);
    DoAfterInsertionItem(Result);
  finally
    CancelUpdate;
  end;
end;

procedure TdxLayoutControlCustomizeForm.DoAfterInsertionItem(AItem: TdxCustomLayoutItem);
var
  AIntf: IdxLayoutDesignerHelper;
begin
  if Supports(Container, IdxLayoutDesignerHelper, AIntf) then
  begin
    AIntf.SelectComponent(AItem);
    AIntf := nil;
  end;
end;

function TdxLayoutControlCustomizeForm.GetImageIndex(AItem: TdxCustomLayoutItem): Integer;
const
  AGroupIndexMap: array[Boolean, Boolean, TdxLayoutDirection] of Integer = (
    ((7, 8, 9), (10, 11, 12)),
    ((20, 21, 22), (23, 24, 25)));
  ASeparatorIndexMap: array[Boolean] of Integer = (2, 3);
  ASplitterIndexMap: array[Boolean] of Integer = (4, 5);

var
  AGroup: TdxLayoutGroup;
begin
  if AItem is TdxLayoutGroup then
  begin
    AGroup := AItem as TdxLayoutGroup;
    Result := AGroupIndexMap[AGroup.Hidden and not AGroup.IsRoot, AGroup.Locked, AGroup.LayoutDirection];
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
  Result := (LockCount > 0) or Container.IsUpdateLocked;
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
  acAvailableItemsViewAsList.Checked := Container.CustomizeAvailableItemsViewKind = aivkTree;
  acTabbedView.Checked := Container.CustomizeFormTabbedView;
  acHighlightRoot.Checked := Container.HighlightRoot;
  acShowDesignSelectors.Checked := Container.ShowDesignSelectors;
  RefreshEnableds;
end;

procedure TdxLayoutControlCustomizeForm.RefreshView;
const
  MainGroupDirectionMap: array[Boolean] of TdxLayoutDirection = (ldHorizontal, ldTabbed);
begin
  lcMainGroup1.LayoutDirection := MainGroupDirectionMap[Container.CustomizeFormTabbedView];

  acShowDesignSelectors.Visible := Container.IsDesigning;
  liShowDesignSelectors.Visible := acShowDesignSelectors.Visible;
  acHighlightRoot.Visible := Container.IsDesigning;
  liHighlightRoot.Visible := acHighlightRoot.Visible;

  RefreshStoring;

  acUndo.Visible := not Container.IsDesigning;
  liUndo.Visible := acUndo.Visible;
  acRedo.Visible := not Container.IsDesigning;
  liRedo.Visible := acRedo.Visible;

  lsSeparator4.Visible := (liUndo.Visible or liRedo.Visible) and
    (liShowDesignSelectors.Visible or liHighlightRoot.Visible or liStore.Visible or liRestore.Visible);

  acAddItem.Visible := Container.IsDesigning;
  liAddItem.Visible := acAddItem.Visible;

  acAlignBy.Visible := Container.IsDesigning;
  lsAlignBy.Visible := acAlignBy.Visible;
  liAlignBy.Visible := acAlignBy.Visible;

  RefreshLayoutLookAndFeel;
  RefreshButtonStates;
end;

procedure TdxLayoutControlCustomizeForm.SaveToUndo;
begin
  Container.SaveToUndo;
end;

function TdxLayoutControlCustomizeForm.CanSelectItem(AItem: TdxCustomLayoutItem): Boolean;
begin
  Result := (AItem <> nil) and not TdxCustomLayoutItemAccess(AItem).IsDestroying and
    Supports(Container, IdxLayoutDesignerHelper);
end;

procedure TdxLayoutControlCustomizeForm.SelectItem(AItem: TdxCustomLayoutItem);
var
  AIntf: IdxLayoutDesignerHelper;
begin
  if Supports(Container, IdxLayoutDesignerHelper, AIntf) then
  begin
    if AItem <> nil then
      AIntf.SelectComponent(AItem)
    else
      AIntf.SelectComponent(Container);
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
    if Supports(Container, IdxLayoutDesignerHelper, AIntf) then
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
  CreateItem(TdxLayoutContainerAccess(Container).GetDefaultGroupClass,
    cxGetResourceString(@sdxLayoutControlNewGroupCaption));
end;

procedure TdxLayoutControlCustomizeForm.acAddItemExecute(Sender: TObject);
begin
  CreateItem(TdxLayoutContainerAccess(Container).GetDefaultItemClass,
    cxGetResourceString(@sdxLayoutControlNewItemCaption));
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
  AItem := Container.CreateItem(TdxLayoutSplitterItem);
  AItem.Caption := cxGetResourceString(@sdxLayoutControlNewSplitterItemCaption);
  DoAfterInsertionItem(AItem);
end;

procedure TdxLayoutControlCustomizeForm.tvItemsEdited(Sender: TObject; Node: TTreeNode;
  var S: String);
begin
  if TdxCustomLayoutItem(Node.Data).IsRoot then
    Exit;
  RefreshButtonStates;
  BeginUpdate;
  try
    if Container.IsDesigning then
      TdxCustomLayoutItem(Node.Data).Name := S
    else
      TdxCustomLayoutItemAccess(Node.Data).SetInplaceRenameCaption(S);
    Node.Text := TdxCustomLayoutItem(Node.Data).CaptionForCustomizeForm;
    S := Node.Text;
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
  AIntf: IdxLayoutDesignerHelper;
  AList: TList;
  ATag: Integer;
  I: Integer;
begin
  //todo: TdxLayoutControlAccess(Control).SaveToUndo;
  ATag := (Sender as TAction).Tag;
  AList := TList.Create;
  try
    if Supports(Container, IdxLayoutDesignerHelper, AIntf) then
    begin
      AIntf.GetSelection(AList);
      AIntf := nil;
    end;
    BeginUpdate;
    try
      Container.BeginUpdate;
      try
        if ATag = -1 then
          for I := 0 to AList.Count - 1 do
            TdxCustomLayoutItem(AList[I]).AlignmentConstraint := nil
        else
          with Container.CreateAlignmentConstraint do
          begin
            Kind := TdxLayoutAlignmentConstraintKind(ATag);
            for I := 0 to AList.Count - 1 do
              AddItem(TdxCustomLayoutItem(AList[I]));
          end;
      finally
        Container.EndUpdate;
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
    Result := (dxLayoutDragAndDropObject <> nil) and
      (TdxLayoutDragAndDropObjectAccess(dxLayoutDragAndDropObject).DestinationItem = AItem);
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
  Container.CustomizeAvailableItemsViewKind := AViewKindMap[acAvailableItemsViewAsList.Checked];
end;

procedure TdxLayoutControlCustomizeForm.tvItemsEditing(Sender: TObject;
  Node: TTreeNode; var AllowEdit: Boolean);

  function IsKeyDown(AShift: TShiftState): Boolean;
  begin
    Result := (AShift * KeyboardStateToShiftState) <> [];
  end;

var
  AEditWnd: THandle;
  AEditingText: string;
begin
  AllowEdit := not (TdxCustomLayoutItem(Node.Data).IsRoot or (DragHelper.DragItem <> nil) or
    IsKeyDown([ssCtrl, ssShift]) or TdxCustomLayoutItemAccess(Node.Data).IsParentLocked);
  if not AllowEdit or Container.IsDesigning then
    Exit;
  AEditingText := TdxCustomLayoutItemAccess(Node.Data).GetInplaceRenameCaption;
  if AEditingText <> Node.Text then
  begin
    AEditWnd := SendMessage(Node.Owner.Owner.Handle, TVM_GETEDITCONTROL, 0, 0);
    if AEditWnd <> 0 then
      SetWindowText(AEditWnd, PChar(AEditingText));
  end;
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

procedure TdxLayoutControlCustomizeForm.acTabbedViewExecute(Sender: TObject);
begin
  Container.CustomizeFormTabbedView := acTabbedView.Checked;
end;

procedure TdxLayoutControlCustomizeForm.acHighlightRootExecute(Sender: TObject);
begin
  Container.HighlightRoot := acHighlightRoot.Checked;
end;

procedure TdxLayoutControlCustomizeForm.acShowDesignSelectorsExecute(Sender: TObject);
begin
  Container.ShowDesignSelectors := acShowDesignSelectors.Checked;
end;

procedure TdxLayoutControlCustomizeForm.acStoreExecute(Sender: TObject);
begin
  Container.ILayout.Store;
  RefreshEnableds;
end;

procedure TdxLayoutControlCustomizeForm.acRestoreExecute(Sender: TObject);
begin
  SaveToUndo;
  Container.ILayout.Restore;
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
  Container.UndoRedoManager.Undo;
  RefreshButtonStates;
end;

procedure TdxLayoutControlCustomizeForm.acRedoExecute(Sender: TObject);
begin
  Container.UndoRedoManager.Redo;
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
    Container.Modified;
  finally
    AList.Free;
  end;
end;

procedure TdxLayoutControlCustomizeForm.pmTreeViewActionsPopup(Sender: TObject);
const
  CaptionAlignHorzMap: array[TAlignment] of Integer = (0, 2, 1);

  procedure ResetSubMenu(AMenu: TMenuItem);
  var
    I: Integer;
  begin
    for I := 0 to AMenu.Count - 1 do
      TAction(AMenu.Items[I].Action).Checked := False;
  end;

  function IsContainInSelections(AClass: TClass): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 0 to tvItems.SelectionCount - 1 do
    begin
      Result := TObject(tvItems.Selections[I].Data) is AClass;
      if Result then
        Break;
    end;
  end;

  function IsContainLabeledItemInSelections: Boolean;
  begin
    Result := IsContainInSelections(TdxLayoutCustomLabeledItem);
  end;

  function IsContainGroupInSelections: Boolean;
  begin
    Result := IsContainInSelections(TdxLayoutGroup);
  end;

  function IsContainDirectionalItemInSelections: Boolean;
  begin
    Result := IsContainInSelections(TdxLayoutDirectionalItem);
  end;

  function IsContainRootInSelections: Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 0 to tvItems.SelectionCount - 1 do
    begin
      Result := TdxCustomLayoutItem(tvItems.Selections[I].Data).IsRoot;
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

  function CanMakeGroup: Boolean;
  var
    I: Integer;
  begin
    Result := tvItems.SelectionCount = 1;
    if not Result and (tvItems.SelectionCount > 1) then
      for I := 1 to tvItems.SelectionCount - 1 do
      begin
        Result := GetGeneralParent(TdxCustomLayoutItem(tvItems.Selections[I - 1].Data)) =
          GetGeneralParent(TdxCustomLayoutItem(tvItems.Selections[I].Data));
        if not Result then
          Break;
      end;
  end;

var
  AItem: TdxCustomLayoutItem;
  AHitTest: TdxCustomLayoutHitTest;
  APopupForTree: Boolean;
  AIsContainLockedItem: Boolean;
  AIsContainGroup: Boolean;
  AIsContainLabeledItem: Boolean;
  AIsContainDirectionalItem: Boolean;
  AIsContainOnlyGroup: Boolean;
  AIsContainRoot: Boolean;
  ACanModify: Boolean;
begin
  AHitTest := Container.GetHitTest;
  APopupForTree := AHitTest.HitTestCode = htTreeViewItems;
  miTreeViewItemRename.Visible := APopupForTree;
  miExpandAll.Visible := APopupForTree;
  miCallapseAll.Visible := APopupForTree;
  miSeparator1.Visible := APopupForTree;

  AIsContainLockedItem := IsContainLockedItemInSelections;
  AIsContainGroup := IsContainGroupInSelections;
  AIsContainLabeledItem := IsContainLabeledItemInSelections;
  AIsContainDirectionalItem := IsContainDirectionalItemInSelections;
  AIsContainOnlyGroup := AIsContainGroup and not AIsContainLabeledItem and not AIsContainDirectionalItem;
  AIsContainRoot := IsContainRootInSelections;
  ACanModify := CanModify;

  miDirection.Visible := AIsContainOnlyGroup and CanShowMenuItem(cfmiDirection);
  miBorder.Visible := AIsContainOnlyGroup and not AIsContainRoot and CanShowMenuItem(cfmiBorder);
  acExpandButton.Visible := AIsContainOnlyGroup and not AIsContainRoot and CanShowMenuItem(cfmiExpandButton);
  miTextPosition.Visible := (AIsContainGroup or AIsContainLabeledItem) and not AIsContainDirectionalItem and
    not AIsContainRoot and CanShowMenuItem(cfmiCaptionLayout);
  miCaptionAlignHorz.Visible := (AIsContainGroup or AIsContainLabeledItem) and not AIsContainDirectionalItem and
    not AIsContainRoot and CanShowMenuItem(cfmiCaptionAlignHorz);
  miCaptionAlignVert.Visible := (AIsContainGroup or AIsContainLabeledItem) and not AIsContainDirectionalItem and
    not AIsContainRoot and CanShowMenuItem(cfmiCaptionAlignVert);
  acCaption.Visible := (AIsContainGroup or AIsContainLabeledItem) and not AIsContainDirectionalItem and
    not AIsContainRoot and CanShowMenuItem(cfmiCaption);
  miAlignHorz.Visible := CanShowMenuItem(cfmiAlignHorz);
  miAlignVert.Visible := CanShowMenuItem(cfmiAlignVert);
  acGroup.Visible := not AIsContainRoot;
  acUngroup.Visible := AIsContainOnlyGroup and not AIsContainRoot and (tvItems.SelectionCount = 1) and not TdxCustomLayoutItem(tvItems.Selected.Data).IsRoot;

  miDirection.Enabled := ACanModify and not AIsContainLockedItem;
  miAlignHorz.Enabled := ACanModify and not AIsContainLockedItem;
  miAlignVert.Enabled := ACanModify and not AIsContainLockedItem;
  miTextPosition.Enabled := ACanModify;
  miCaptionAlignHorz.Enabled := ACanModify;
  miCaptionAlignVert.Enabled := ACanModify;
  acCaption.Enabled := ACanModify;

  acGroup.Enabled := ACanModify and CanMakeGroup;
  acUngroup.Enabled := ACanModify;

  ResetSubMenu(miAlignHorz);
  ResetSubMenu(miAlignVert);
  ResetSubMenu(miDirection);
  ResetSubMenu(miTextPosition);
  ResetSubMenu(miCaptionAlignHorz);
  ResetSubMenu(miCaptionAlignVert);

  if tvItems.SelectionCount >= 1 then
  begin
    AItem := TdxCustomLayoutItem(tvItems.Selected.Data);
    TAction(miTextPosition.Items[Integer(TdxCustomLayoutItemCaptionOptionsAccess(AItem.CaptionOptions).Layout)].Action).Checked := True;
    TAction(miCaptionAlignHorz.Items[CaptionAlignHorzMap[AItem.CaptionOptions.AlignHorz]].Action).Checked := True;
    TAction(miCaptionAlignVert.Items[Integer(TdxCustomLayoutItemCaptionOptionsAccess(AItem.CaptionOptions).AlignVert)].Action).Checked := True;
    TAction(miAlignHorz.Items[Integer(AItem.AlignHorz)].Action).Checked := True;
    TAction(miAlignVert.Items[Integer(AItem.AlignVert)].Action).Checked := True;
    acCaption.Checked := AItem.CaptionOptions.Visible;
    if AItem is TdxLayoutGroup then
    begin
      TAction(miDirection.Items[Integer((AItem as TdxLayoutGroup).LayoutDirection)].Action).Checked := True;
      acBorder.Checked := (AItem as TdxLayoutGroup).ShowBorder;
      acExpandButton.Checked := (AItem as TdxLayoutGroup).ButtonOptions.ShowExpandButton;
    end;
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
    Container.Modified;
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
    Container.Modified;
  finally
    AList.Free;
  end;
  tvItems.Invalidate;
end;

procedure TdxLayoutControlCustomizeForm.acBorderExecute(
  Sender: TObject);
var
  AList: TList;
  I: Integer;
begin
  if tvItems.IsEditing then
    Exit;
  SaveToUndo;
  acBorder.Checked := not acBorder.Checked;
  AList := TList.Create;
  try
    cxTreeViewGetSelection(tvItems.InnerTreeView, AList);
    for I := 0 to AList.Count - 1 do
    begin
      if TObject(AList[I]) is TdxLayoutGroup then
        TdxLayoutGroup(AList[I]).ShowBorder := (Sender as TAction).Checked;
    end;
    Container.Modified;
  finally
    AList.Free;
  end;
end;

procedure TdxLayoutControlCustomizeForm.tvItemsDeletion(
  Sender: TObject; Node: TTreeNode);
var
  ANode: TTreeNode;
begin
  if csDestroying in ComponentState then
    Exit;
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

procedure TdxLayoutControlCustomizeForm.acExpandButtonExecute(
  Sender: TObject);
var
  AList: TList;
  I: Integer;
begin
  if tvItems.IsEditing then
    Exit;
  SaveToUndo;
  Container.BeginUpdate;
  try
    acExpandButton.Checked := not acExpandButton.Checked;
    AList := TList.Create;
    try
      cxTreeViewGetSelection(tvItems.InnerTreeView, AList);
      for I := 0 to AList.Count - 1 do
      begin
        if TObject(AList[I]) is TdxLayoutGroup then
          TdxLayoutGroup(AList[I]).ButtonOptions.ShowExpandButton := acExpandButton.Checked;
      end;
      Container.Modified;
    finally
      AList.Free;
    end;
  finally
    Container.EndUpdate(False);
  end;
end;

procedure TdxLayoutControlCustomizeForm.acTextPositionExecute(
  Sender: TObject);
var
  AList: TList;
  I: Integer;
begin
  if tvItems.IsEditing then
    Exit;
  SaveToUndo;
  Container.BeginUpdate;
  try
    AList := TList.Create;
    try
      cxTreeViewGetSelection(tvItems.InnerTreeView, AList);
      for I := 0 to AList.Count - 1 do
        TdxCustomLayoutItemCaptionOptionsAccess(TdxCustomLayoutItem(AList[I]).CaptionOptions).Layout := TdxCaptionLayout((Sender as TAction).Tag);
      Container.Modified;
    finally
      AList.Free;
    end;
  finally
    Container.EndUpdate(False);
  end;
end;

procedure TdxLayoutControlCustomizeForm.acCaptionAlignHorzExecute(
  Sender: TObject);
var
  AList: TList;
  I: Integer;
begin
  if tvItems.IsEditing then
    Exit;
  SaveToUndo;
  Container.BeginUpdate;
  try
    AList := TList.Create;
    try
      cxTreeViewGetSelection(tvItems.InnerTreeView, AList);
      for I := 0 to AList.Count - 1 do
        TdxCustomLayoutItem(AList[I]).CaptionOptions.AlignHorz := TAlignment((Sender as TAction).Tag);
      Container.Modified;
    finally
      AList.Free;
    end;
  finally
    Container.EndUpdate(False);
  end;
end;

procedure TdxLayoutControlCustomizeForm.acCaptionExecute(
  Sender: TObject);
var
  AList: TList;
  I: Integer;
begin
  if tvItems.IsEditing then
    Exit;
  SaveToUndo;
  Container.BeginUpdate;
  try
    acCaption.Checked := not acCaption.Checked;
    AList := TList.Create;
    try
      cxTreeViewGetSelection(tvItems.InnerTreeView, AList);
      for I := 0 to AList.Count - 1 do
        TdxCustomLayoutItem(AList[I]).CaptionOptions.Visible := acCaption.Checked;
      Container.Modified;
    finally
      AList.Free;
    end;
  finally
    Container.EndUpdate(False);
  end;
end;

procedure TdxLayoutControlCustomizeForm.acCaptionAlignVertExecute(
  Sender: TObject);
var
  AList: TList;
  I: Integer;
begin
  if tvItems.IsEditing then
    Exit;
  SaveToUndo;
  Container.BeginUpdate;
  try
    AList := TList.Create;
    try
      cxTreeViewGetSelection(tvItems.InnerTreeView, AList);
      for I := 0 to AList.Count - 1 do
        TdxCustomLayoutItemCaptionOptionsAccess(TdxCustomLayoutItem(AList[I]).CaptionOptions).AlignVert := TdxAlignmentVert((Sender as TAction).Tag);
      Container.Modified;
    finally
      AList.Free;
    end;
  finally
    Container.EndUpdate(False);
  end;
end;

procedure TdxLayoutControlCustomizeForm.acGroupExecute(Sender: TObject);
const
  LayoutDirectionMap: array [TdxLayoutDirection] of TdxLayoutDirection = (ldHorizontal, ldVertical, ldVertical);

  function GetIndexByItem(AItem: TdxCustomLayoutItem): Integer;
  begin
    Result := AItem.Index;
    if AItem.Parent.Hidden and not AItem.Parent.IsRoot then
      Result := GetIndexByItem(AItem.Parent);
  end;

  function GetIndex(AParent: TdxLayoutGroup; AList: TList): Integer;
  var
    I: Integer;
  begin
    Result := AParent.Count;
    for I := 0 to AList.Count - 1 do
      Result := Min(Result, GetIndexByItem(TdxCustomLayoutItem(AList[I])));
  end;

var
  AList: TList;
  I: Integer;
  AParent: TdxLayoutGroup;
  AGroup: TdxLayoutGroup;
  AIndex: Integer;
begin
  if tvItems.IsEditing then
    Exit;
  SaveToUndo;
  Container.BeginUpdate;
  try
    AList := TList.Create;
    try
      cxTreeViewGetSelection(tvItems.InnerTreeView, AList);
      AList.Sort(CompareItemsByIndex);
      AParent := GetGeneralParent(TdxCustomLayoutItem(AList[0]));
      AIndex := GetIndex(AParent, AList);
      AGroup := DoCreateItem(TdxLayoutContainerAccess(Container).GetDefaultGroupClass, cxGetResourceString(@sdxLayoutControlNewGroupCaption)) as TdxLayoutGroup;
      AGroup.LayoutDirection := LayoutDirectionMap[AParent.LayoutDirection];
      AGroup.MoveTo(AParent, AIndex);
      for I := 0 to AList.Count - 1 do
        TdxCustomLayoutItem(AList[I]).Parent := AGroup;
      Container.Modified;
    finally
      AList.Free;
    end;
  finally
    Container.EndUpdate;
  end;
end;

procedure TdxLayoutControlCustomizeForm.acUngroupExecute(Sender: TObject);
var
  AGroup: TdxLayoutGroup;
begin
  if tvItems.IsEditing then
    Exit;
  SaveToUndo;
  Container.BeginUpdate;
  try
    AGroup := TdxLayoutGroup(tvItems.Selected.Data);
    AGroup.MoveChildrenToParent;
    AGroup.Free;
  finally
    Container.EndUpdate;
  end;
end;

end.
