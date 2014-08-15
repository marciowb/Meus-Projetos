{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Designer Module                                             }
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
unit cxfmWebMenusDsgn;

interface

{$I cxVer.inc}

uses Classes, DesignIntf, 
  {$IFDEF VCL}
  Controls, Graphics, Messages, Forms, StdCtrls, ExtCtrls, Menus, ImgList,
  ComCtrls, Windows,
  {$ELSE}
  QControls, QGraphics, QForms, QStdCtrls, QExtCtrls, QMenus, QImgList,
  QComCtrls, Qt,
  {$ENDIF}
  cxWebClasses, cxWebMenus, cxWebControls, cxWebMainMenu,
  cxWebDsgnComponentDesigners;

type
  TcxfmMenuDesignWindow = class(TcxWebBaseComponentDesigner)
  private
    FWebMenuHelper: TcxWebMenuHelper;
    FLastDragIndex: Integer;

    miAddItem: TMenuItem;
    miMoveUp: TMenuItem;
    miMoveDown: TMenuItem;
    miLevelUp: TMenuItem;
    miAddSubItem: TMenuItem;
    miLevelDown: TMenuItem;
    btnAddItem: TButton;
    btnAddSubItem: TButton;
    btnDelete: TButton;
    btnMoveUp: TButton;
    btnMoveDown: TButton;
    btnSelectAll: TButton;
    btnLevelUp: TButton;
    btnLevelDown: TButton;

    procedure btnAddItemClick(Sender: TObject);
    procedure btnAddSubItemClick(Sender: TObject);
    procedure btnMoveUpClick(Sender: TObject);
    procedure btnMoveDownClick(Sender: TObject);
    procedure TreeViewClick(Sender: TObject);
    procedure TreeViewDblClick(Sender: TObject);
    procedure TreeViewEdited(Sender: TObject; Node: TTreeNode;
      var S: {$IFDEF VCL}string{$ELSE}WideString{$ENDIF});
    procedure TreeViewStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure TreeViewEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure TreeViewDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TreeViewDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure btnLevelUpClick(Sender: TObject);
    procedure btnLevelDownClick(Sender: TObject);

    function GetMenuItemNode(AMenuItem: TComponent; MakeVisible: Boolean): TTreeNode;
    function GetNodeMenuItem(ANode: TTreeNode): TcxWebMenuItem;
    function GetWebMenu: TcxWebComponent;
    function GetWebMenuDesigner: TAbstractcxWebMenuDesigner;
    procedure SetWebMenuHelper(Value: TcxWebMenuHelper);

    procedure AddMenuItem(AParentItem: TcxWebMenuItem);
    function CanAddItem: Boolean;
    function CanAddSubItem: Boolean;
    function CanLevelDown: Boolean;
    function CanLevelUp: Boolean;
    function CanMoveDown: Boolean;
    function CanMoveUp: Boolean;
    procedure ChangeIndexes(ADelta: Integer);
    procedure ChangeLevels(ADelta: Integer);
    procedure DrawDragRect;
    procedure MoveItemsTo(AMenuItem: TcxWebMenuItem);
    procedure RefreshMainControlItem(AParentNode: TTreeNode);
    procedure Select(AItem: TPersistent; AddToSelection: Boolean);
    function GetMenuItem(Index: Integer): TcxWebMenuItem;
  protected
    procedure CreateComponents; override;
    function GetComponentCount: Integer; override;
    function GetComponent(Index: Integer): TComponent; override;
    function GetComponentIndex(AComponent: TComponent): Integer; override;
    procedure SetComponentIndex(AComponent: TComponent; AValue: Integer); override;
    function GetCaptionFormat: string; override;
    procedure UpdateControlsState; override;
    procedure UpdateMenuState; override;
    function UniqueName(AComponent: TComponent): string; override;
    function CreateMainControl: TWinControl; override;
    function TreeView: TTreeView;
    function IndexOf(AComponent: TComponent): Integer;

    function SelectedCount: Integer; override;
    function GetSelected(Index: Integer): Boolean; override;
    procedure SetSelected(Index: Integer; const Value: Boolean); override;
    function CurrentComponent: TComponent; override;
    procedure InternalUpdateItem(AComponent: TComponent); override;
    procedure DeleteItem(AComponent: TComponent); override;
    procedure RemoveChildrenBeforeDelete(ASelections, ADeleteList: IDesignerSelections); override;
    procedure RefreshMainControl; override;

    procedure BeginUpdate; override;
    procedure EndUpdate; override;
    procedure CancelUpdate; override;

    procedure RestoreLayout; override;
    procedure UpdateHScrollBar; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function CurrentMenuItem: TcxWebMenuItem;

    property MenuItems[Index: Integer]: TcxWebMenuItem read GetMenuItem;
    property WebMenuHelper: TcxWebMenuHelper read FWebMenuHelper write SetWebMenuHelper;
    property WebMenu: TcxWebComponent read GetWebMenu;
    property WebMenuDesigner: TAbstractcxWebMenuDesigner read GetWebMenuDesigner;
  end;

procedure cxShowWebMenusDesigner(AWebMenuHelper: TcxWebMenuHelper;
  ADelphiDesigner: IDesigner);

implementation

uses
  SysUtils, TypInfo, Registry, 
  cxWebDsgnConsts, cxWebDsgnUtils, cxWebDsgnStrs;

type
  TcxWebMenusDesigner = class(TAbstractcxWebMenuDesigner)
  private
    FDelphiDesigner: IDesigner;
    FDesignWindow: TcxfmMenuDesignWindow;
    FUpdateCount: Integer;

    function GetDesignWindow: TcxfmMenuDesignWindow;
    procedure Activate;
  protected
    procedure Modified; override;
    procedure Update(AMenuItem: TcxWebMenuItem); override;
  public
    constructor Create(AWebMenuHelper: TcxWebMenuHelper; ADelphiDesigner: IDesigner);
    destructor Destroy; override;

    procedure BeginUpdate; override;
    procedure CancelUpdate; override;
    procedure EndUpdate; override;

    property DelphiDesigner: IDesigner read FDelphiDesigner;
    property DesignWindow: TcxfmMenuDesignWindow read GetDesignWindow;
  end;


procedure cxShowWebMenusDesigner(AWebMenuHelper: TcxWebMenuHelper;
  ADelphiDesigner: IDesigner);
begin
  if AWebMenuHelper.Designer = nil then
    TcxWebMenusDesigner.Create(AWebMenuHelper, ADelphiDesigner);
  TcxWebMenusDesigner(AWebMenuHelper.Designer).Activate;
end;


{ TcxWebMenusDesigner }

constructor TcxWebMenusDesigner.Create(AWebMenuHelper: TcxWebMenuHelper;
  ADelphiDesigner: IDesigner);
begin
  inherited Create(AWebMenuHelper);
  FDelphiDesigner := ADelphiDesigner;
end;

destructor TcxWebMenusDesigner.Destroy;
begin
  if FDesignWindow <> nil then
  begin
    FDesignWindow.Designer := nil;
    FDesignWindow.Free;
  end;
  inherited Destroy;
end;

procedure TcxWebMenusDesigner.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TcxWebMenusDesigner.CancelUpdate;
begin
  if FUpdateCount <> 0 then
    Dec(FUpdateCount);
end;

procedure TcxWebMenusDesigner.EndUpdate;
begin
  if FUpdateCount <> 0 then
  begin
    Dec(FUpdateCount);
    if FUpdateCount = 0 then
      Update(nil);
  end;
end;

function TcxWebMenusDesigner.GetDesignWindow: TcxfmMenuDesignWindow;
begin
  if FDesignWindow = nil then
  begin
    FDesignWindow := TcxfmMenuDesignWindow.Create(nil);
    FDesignWindow.Designer := DelphiDesigner;
    FDesignWindow.WebMenuHelper := WebMenuHelper;
  end;
  Result := FDesignWindow;
end;

procedure TcxWebMenusDesigner.Activate;
begin
  DesignWindow.Show;
end;

procedure TcxWebMenusDesigner.Modified;
begin
  if DelphiDesigner <> nil then
    DelphiDesigner.Modified;
end;

procedure TcxWebMenusDesigner.Update(AMenuItem: TcxWebMenuItem);
begin
  if (FUpdateCount = 0) and (FDesignWindow <> nil) then
    DesignWindow.UpdateItem(AMenuItem);
end;

{ TcxfmGridsColumnDesignWindow }

constructor TcxfmMenuDesignWindow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  btnDelete.Tag := Integer(eaDelete);
  btnSelectAll.Tag := Integer(eaSelectAll);
end;

destructor TcxfmMenuDesignWindow.Destroy;
begin
  if WebMenuDesigner <> nil then
    TcxWebMenusDesigner(WebMenuDesigner).FDesignWindow := nil;
  inherited Destroy;
end;

procedure TcxfmMenuDesignWindow.CreateComponents;
begin
  inherited CreateComponents;

  Constraints.MinHeight := 320;
  
  btnAddItem := CreateButton(9, 7, cxWebCompEditorNewItem, btnAddItemClick);
  btnAddSubItem := CreateButton(9, 36, cxWebCompEditorNewSubItem, btnAddSubItemClick);
  btnDelete := CreateButton(9, 65, cxWebCompEditorDelete, SelectAllClick);
  btnSelectAll := CreateButton(9, 99, cxWebCompEditorSelectAll, SelectAllClick);
  btnMoveUp := CreateButton(9, 133, cxWebCompEditorMoveUp, btnMoveUpClick);
  btnMoveDown := CreateButton(9, 162, cxWebCompEditorMoveDown, btnMoveDownClick);
  btnLevelUp := CreateButton(9, 196, cxWebCompEditorLevelUp, btnLevelUpClick);
  btnLevelDown := CreateButton(9, 225, cxWebCompEditorLevelDown, btnLevelDownClick);

  miAddItem := CreateMenuItem(cxWebCompEditorNewItem, ShortCut(Ord({$IFDEF VCL}VK_INSERT{$ELSE}KEY_INSERT{$ENDIF}), []), 0, btnAddItemClick);
  miAddSubItem := CreateMenuItem(cxWebCompEditorNewSubItem, ShortCut(Ord({$IFDEF VCL}VK_RETURN{$ELSE}KEY_ENTER{$ENDIF}), [ssCtrl]), -1, btnAddSubItemClick);
  AddMenuSeparator;
  CreateEditMenuItems;
  AddMenuSeparator;
  miMoveUp := CreateMenuItem(cxWebCompEditorMoveUp, ShortCut(Ord({$IFDEF VCL}VK_UP{$ELSE}KEY_UP{$ENDIF}), [ssCtrl]), 5, btnMoveUpClick);
  miMoveDown := CreateMenuItem(cxWebCompEditorMoveDown, ShortCut(Ord({$IFDEF VCL}VK_DOWN{$ELSE}KEY_DOWN{$ENDIF}), [ssCtrl]), 6, btnMoveDownClick);
  AddMenuSeparator;
  miLevelUp := CreateMenuItem(cxWebCompEditorLevelUp, ShortCut(Ord({$IFDEF VCL}VK_LEFT{$ELSE}KEY_LEFT{$ENDIF}), [ssCtrl]), -1, btnLevelUpClick);
  miLevelDown := CreateMenuItem(cxWebCompEditorLevelDown, ShortCut(Ord({$IFDEF VCL}VK_RIGHT{$ELSE}KEY_RIGHT{$ENDIF}), [ssCtrl]), -1, btnLevelDownClick);
  AddMenuSeparator;
  CreateShowButtonsMenuItem;
end;

function TcxfmMenuDesignWindow.GetComponentCount: Integer;
begin
  Result := TreeView.Items.Count;
end;

function TcxfmMenuDesignWindow.GetComponent(Index: Integer): TComponent;
begin
  Result := TcxWebMenuItem(TreeView.Items[Index].Data);
end;

function TcxfmMenuDesignWindow.GetComponentIndex(AComponent: TComponent): Integer;
begin
  Result := (AComponent as TcxWebMenuItem).Index;
end;

procedure TcxfmMenuDesignWindow.SetComponentIndex(AComponent: TComponent; AValue: Integer);
begin
  (AComponent as TcxWebMenuItem).Index := AValue;
end;

function TcxfmMenuDesignWindow.GetCaptionFormat: string;
begin
  Result := scxWebMenuItemDesigner;
end;

function TcxfmMenuDesignWindow.UniqueName(AComponent: TComponent): string;
begin
  if AComponent.Name = '' then
    Result := Designer.UniqueName(AComponent.Name + scxItem)
  else Result := AComponent.Name;
end;

function TcxfmMenuDesignWindow.CreateMainControl: TWinControl;
begin
  Result := TTreeView.Create(self);
  Result.Parent := self;
  with TTreeView(Result) do
  begin
    {$IFDEF VCL} //TODO: CLX
    DragMode := dmAutomatic;
    HideSelection := False;
    RightClickSelect := True;
    MultiSelectStyle := [msControlSelect, msShiftSelect];
    {$ENDIF}
    PopupMenu := pmMain;
    Indent := 20;
    MultiSelect := True;
    ReadOnly := True;
    OnClick := TreeViewClick;
    OnDblClick := TreeViewDblClick;
    OnDragDrop := TreeViewDragDrop;
    OnDragOver := TreeViewDragOver;
    OnEdited := TreeViewEdited;
    OnEndDrag := TreeViewEndDrag;
    OnStartDrag := TreeViewStartDrag;
  end;
end;

function TcxfmMenuDesignWindow.TreeView: TTreeView;
begin
  Result := MainControl as TTreeView;
end;

function TcxfmMenuDesignWindow.IndexOf(AComponent: TComponent): Integer;
var
  ANode: TTreeNode;
begin
  ANode := GetMenuItemNode(AComponent, false);
  if ANode <> nil then
    Result := ANode.AbsoluteIndex
  else
    Result := -1;
end;

function TcxfmMenuDesignWindow.SelectedCount: Integer;
begin
  Result := TreeView.{$IFDEF VCL}SelectionCount{$ELSE}SelCount{$ENDIF};
end;

function TcxfmMenuDesignWindow.GetSelected(Index: Integer): Boolean;
begin
  if (Index < 0) or (Index >= TreeView.Items.Count) then
    Result := false
  else
    Result := TreeView.Items[Index].Selected;
end;

procedure TcxfmMenuDesignWindow.SetSelected(Index: Integer; const Value: Boolean);
begin
  if (Index < 0) or (Index >= TreeView.Items.Count) then exit;

  if TreeView.Items[Index].Selected <> Value then
    {$IFDEF VCL}
    TreeView.Select(TreeView.Items[Index], [ssCtrl]);
    {$ELSE}
    TreeView.Items[Index].Selected := Value;
    {$ENDIF}
end;

function TcxfmMenuDesignWindow.CurrentComponent: TComponent;
begin
  Result := CurrentMenuItem;
end;

procedure TcxfmMenuDesignWindow.InternalUpdateItem(AComponent: TComponent);
var
  AIndex: Integer;
begin
  AIndex := IndexOf(AComponent);
  if AIndex <> -1 then
  begin
    TreeView.Items[AIndex].Text := (AComponent as TcxWebMenuItem).Caption;
    UpdateHScrollBar;
  end
end;

procedure TcxfmMenuDesignWindow.DeleteItem(AComponent: TComponent);
var
  AIndex: Integer;
begin
  AIndex := IndexOf(AComponent);

  if AIndex <> -1 then
  begin
    TreeView.Items[AIndex].Delete;

    if AIndex > GetComponentCount - 1 then
      AIndex := GetComponentCount - 1;
    if AIndex <> -1 then
      Select(MenuItems[AIndex], False)
    else
      SelectComponent;
    UpdateHScrollBar;
  end;
end;

procedure TcxfmMenuDesignWindow.RemoveChildrenBeforeDelete(
        ASelections, ADeleteList: IDesignerSelections);

  function HasAsParent(AChild, AItem: TcxWebMenuItem): Boolean;
  var
    AParent: TcxWebMenuItem;
  begin
    Result := False;
    AParent := AChild.Parent;
    while AParent <> nil do
    begin
      if AParent = AItem then
      begin
        Result := True;
        break;
      end;
      AParent := AParent.Parent;
    end;
  end;

  function HasParent(AItem: TPersistent): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 0 to ASelections.Count - 1 do
      if (ASelections.Items[I] <> AItem) and
        HasAsParent(AItem as TcxWebMenuItem, ASelections.Items[I] as TcxWebMenuItem) then
      begin
        Result := True;
        break;
      end;
  end;

var
  I: Integer;
begin
  for I := 0 to ASelections.Count - 1 do
    if not HasParent(ASelections[I]) then
      ADeleteList.Add(ASelections.Items[I]);
end;

procedure TcxfmMenuDesignWindow.RefreshMainControl;
var
  I: Integer;
  MenuItem: TcxWebMenuItem;
  ParentNode: TTreeNode;
  ExpandingList: TStringList;

  procedure StoreExpandingLayout(AList: TStringList);
  var
    I: Integer;
  begin
    for I := 0 to TreeView.Items.Count - 1 do
    begin
      if TreeView.Items[I].Expanded then
        AList.Add(TreeView.Items[I].Text);
    end;
  end;

  procedure RestoreExpandingLayout(AList: TStringList);
  var
    I: Integer;
  begin
    for I := 0 to TreeView.Items.Count - 1 do
    begin
      if AList.IndexOf(TreeView.Items[I].Text) <> -1 then
        TreeView.Items[I].Expand(false);
    end;
  end;

begin
  ExpandingList := TStringList.Create;
  TreeView.Items.BeginUpdate;
  try
    StoreExpandingLayout(ExpandingList);
    TreeView.Items.Clear;
    for I := 0 to WebMenuHelper.Items.Count - 1 do
    begin
      MenuItem := WebMenuHelper.Items[I];
      ParentNode := TreeView.Items.AddObject(nil, MenuItem.Caption, MenuItem);
      if MenuItem.Count > 0 then
        RefreshMainControlItem(ParentNode);
    end;
    RestoreExpandingLayout(ExpandingList);
  finally
    TreeView.Items.EndUpdate;
    ExpandingList.Free;
  end;
end;

procedure TcxfmMenuDesignWindow.BeginUpdate;
begin
  inherited BeginUpdate;
end;

procedure TcxfmMenuDesignWindow.EndUpdate;
begin
  inherited EndUpdate;
  if (TreeView <> nil) then
    UpdateItem(nil);
end;

procedure TcxfmMenuDesignWindow.CancelUpdate;
begin
  inherited CancelUpdate;
end;

procedure TcxfmMenuDesignWindow.RestoreLayout;
begin
  inherited RestoreLayout;
  UpdateHScrollBar;
end;

procedure TcxfmMenuDesignWindow.UpdateHScrollBar;
var
  I, NewWidth, CurrentWidth: Integer;
begin
  if TreeView = nil then exit;
  NewWidth := 0;
  with TreeView do
  begin
    for I := 0 to Items.Count - 1 do
    begin
      CurrentWidth := 2 + Canvas.TextWidth(Items[I].Text) + 1;
      if CurrentWidth > NewWidth then
        NewWidth := CurrentWidth;
    end;
    {$IFDEF VCL}
    SendMessage(Handle, LB_SETHORIZONTALEXTENT, NewWidth, 0);
    {$ELSE}
    //TODO LINUX_NOT_IMPL
    {$ENDIF}
  end;
end;

function TcxfmMenuDesignWindow.CurrentMenuItem: TcxWebMenuItem;
begin
  if (GetComponentCount <> 0) and (TreeView.Selected <> nil) then
    Result := TcxWebMenuItem(TreeView.Selected.Data)
  else
    Result := WebMenuHelper.Items;
end;

function TcxfmMenuDesignWindow.GetMenuItemNode(AMenuItem: TComponent; MakeVisible: Boolean): TTreeNode;
var
  I: Integer;
  MenuItem: TcxWebMenuItem;
  ChildNode: TTreeNode;

  function GetMeniItemFromNode(ANode: TTreeNode): TTreeNode;
  var
    I: Integer;
    MenuItem: TcxWebMenuItem;
    ChildNode: TTreeNode;

  begin
    Result := nil;
    for I := 0 to ANode.Count - 1 do
    begin
      ChildNode := ANode.Item[I];
      MenuItem := TcxWebMenuItem(ChildNode.Data);
      if MenuItem = AMenuItem then
      begin
        Result := ChildNode;
        break;
      end;
      if ChildNode.Count <> 0 then
      begin
        Result := GetMeniItemFromNode(ChildNode);
        if Result <> nil then break;
      end;
    end;

  end;

begin
  Result := nil;
  for I := 0 to TreeView.Items.Count - 1 do
  begin
    ChildNode := TreeView.Items[I];
    MenuItem := TcxWebMenuItem(ChildNode.Data);
    if MenuItem = AMenuItem then
    begin
      Result := ChildNode;
      break;
    end;
    if ChildNode.Count <> 0 then
    begin
      Result := GetMeniItemFromNode(ChildNode);
      if Result <> nil then break;
    end;
  end;

  if MakeVisible and (Result <> nil) then
  begin
    ChildNode := Result;
    while Result <> nil do
    begin
      Result.Expanded := true;
      Result := Result.Parent;
    end;
    Result := ChildNode;
  end;
end;

function TcxfmMenuDesignWindow.GetNodeMenuItem(ANode: TTreeNode): TcxWebMenuItem;
begin
  Result := TcxWebMenuItem(ANode.Data);
end;

function TcxfmMenuDesignWindow.GetWebMenu: TcxWebComponent;
begin
  if WebMenuHelper <> nil then
    Result := WebMenuHelper.Menu
  else Result := nil;
end;

function TcxfmMenuDesignWindow.GetWebMenuDesigner: TAbstractcxWebMenuDesigner;
begin
  if WebMenuHelper <> nil then
    Result := WebMenuHelper.Designer
  else Result := nil;
end;

procedure TcxfmMenuDesignWindow.SetWebMenuHelper(Value: TcxWebMenuHelper);
begin
  if FWebMenuHelper <> Value then
  begin
    FWebMenuHelper := Value;
    Component := Value.Menu;
  end;
end;

procedure TcxfmMenuDesignWindow.AddMenuItem(AParentItem: TcxWebMenuItem);
var
  MenuItem: TcxWebMenuItem;
begin
  BeginUpdate;
  try
    MenuItem := AParentItem.Add;
    WebMenuDesigner.BeginUpdate;
    try
      MenuItem.Name := UniqueName(MenuItem);
      MenuItem.Caption := MenuItem.Name;
    finally
      WebMenuDesigner.CancelUpdate;
    end;
    TreeView.Items.AddChildObject(GetMenuItemNode(AParentItem, false), MenuItem.Caption, MenuItem);
    Select(MenuItem, False);
    UpdateHScrollBar;
    TreeView.Update;
  finally
    EndUpdate;
  end;
end;

function TcxfmMenuDesignWindow.CanAddItem: Boolean;
begin
  Result := not ((WebMenu <> nil) and (WebMenu.Owner <> nil) and
    (csInline in WebMenu.Owner.ComponentState));
end;

function TcxfmMenuDesignWindow.CanAddSubItem: Boolean;
begin
  Result := not ((WebMenu <> nil) and (WebMenu.Owner <> nil) and
    (csInline in WebMenu.Owner.ComponentState)) and
    (CurrentMenuItem <> WebMenuHelper.Items);
end;

function TcxfmMenuDesignWindow.CanLevelDown: Boolean;
var
  I: Integer;
  ParentItem: TcxWebMenuItem;
begin
  if TreeView.{$IFDEF VCL}SelectionCount{$ELSE}SelCount{$ENDIF} = 0 then
    Result := false
  else
  begin
    Result := true;
    ParentItem := nil;
    for I := GetComponentCount - 1 downto 0 do
    begin
      if Selected[I] then
      begin
        if (ParentItem <> nil) and (ParentItem <> MenuItems[I].Parent) then
        begin
          Result := false;
          break;
        end;
        ParentItem := MenuItems[I].Parent;
        if MenuItems[I].Index = 0 then
        begin
          Result := false;
          break;
        end;
      end;
    end;
  end;  
end;

function TcxfmMenuDesignWindow.CanLevelUp: Boolean;
var
  I: Integer;
  ParentItem: TcxWebMenuItem;
begin
  if TreeView.{$IFDEF VCL}SelectionCount{$ELSE}SelCount{$ENDIF} = 0 then
    Result := false
  else
  begin
    Result := true;
    ParentItem := nil;
    for I := GetComponentCount - 1 downto 0 do
    begin
      if Selected[I] then
      begin
        if (ParentItem <> nil) and (ParentItem <> MenuItems[I].Parent) then
        begin
          Result := false;
          break;
        end;
        ParentItem := MenuItems[I].Parent;
        if ParentItem = WebMenuHelper.Items then
        begin
          Result := false;
          break;
        end;
      end;
    end;
  end;  
end;

function TcxfmMenuDesignWindow.CanMoveDown: Boolean;
var
  I: Integer;
  ParentItem: TcxWebMenuItem;
begin
  if TreeView.{$IFDEF VCL}SelectionCount{$ELSE}SelCount{$ENDIF} = 0 then
    Result := false
  else
  begin
    Result := true;
    ParentItem := nil;
    for I := GetComponentCount - 1 downto 0 do
    begin
      if Selected[I] then
      begin
        if (ParentItem <> nil) and (ParentItem <> MenuItems[I].Parent) then
        begin
          Result := false;
          break;
        end;
        if MenuItems[I].Parent <> nil then
          if MenuItems[I].Index = MenuItems[I].Parent.Count - 1 then
          begin
            Result := false;
            break;
          end;
        ParentItem := MenuItems[I].Parent;
      end;
    end;
  end;
end;

function TcxfmMenuDesignWindow.CanMoveUp: Boolean;
var
  I: Integer;
  ParentItem: TcxWebMenuItem;
begin
  if TreeView.{$IFDEF VCL}SelectionCount{$ELSE}SelCount{$ENDIF} = 0 then
    Result := false
  else
  begin
    Result := true;
    ParentItem := nil;
    for I := GetComponentCount - 1 downto 0 do
    begin
      if Selected[I] then
      begin
        if (ParentItem <> nil) and (ParentItem <> MenuItems[I].Parent) then
        begin
          Result := false;
          break;
        end;
        if MenuItems[I].Index = 0 then
        begin
          Result := false;
          break;
        end;
        ParentItem := MenuItems[I].Parent;
      end;
    end;
  end;
end;

procedure TcxfmMenuDesignWindow.ChangeIndexes(ADelta: Integer);
var
  Selections: IDesignerSelections;

  procedure ChangeDown(ADelta: Integer);
  var
    I, ItemCount, Index: Integer;
    MenuItem, ParentItem: TcxWebMenuItem;
  begin
    for I := GetComponentCount - 1 downto 0 do
      if Selected[I] then break;
    Index := MenuItems[I].Index;
    Inc(Index, ADelta);
    if Index > MenuItems[Index].Parent.Count - 1 then
      Index := MenuItems[Index].Parent.Count - 1;

    ParentItem := MenuItems[I].Parent;
    ItemCount := 0;
    for I := ParentItem.Count - 1 downto 0 do
    begin
      MenuItem := ParentItem.Items[I];
      if GetMenuItemNode(MenuItem, false).Selected then
      begin
        ParentItem.Remove(MenuItem);
        ParentItem.Insert(Index - ItemCount, MenuItem);
        Inc(ItemCount);
      end;
    end;
  end;

  procedure ChangeUp(ADelta: Integer);
  var
    I, ItemCount, Index: Integer;
    MenuItem, ParentItem: TcxWebMenuItem;
  begin
    for I := 0 to GetComponentCount - 1 do
      if Selected[I] then break;
    Index := MenuItems[I].Index;
    Inc(Index, ADelta);
    if Index < 0 then
      Index := 0;

    ParentItem := MenuItems[I].Parent;
    ItemCount := 0;
    for I := 0 to ParentItem.Count - 1 do
    begin
      MenuItem := ParentItem.Items[I];
      if GetMenuItemNode(MenuItem, false).Selected then
      begin
        ParentItem.Remove(MenuItem);
        ParentItem.Insert(Index + ItemCount, MenuItem);
        Inc(ItemCount);
      end;
    end;
  end;

begin
  WebMenuDesigner.BeginUpdate;
  try
    if ADelta > 0 then
      ChangeDown(ADelta)
    else
      ChangeUp(ADelta);
  finally
    WebMenuDesigner.EndUpdate;
  end;
  RefreshMainControl;  //TODO: Remove

  Selections := CreateSelectionList;
  Designer.GetSelections(Selections);
  UpdateSelections(Selections);
end;

procedure TcxfmMenuDesignWindow.ChangeLevels(ADelta: Integer);
var
  Selections: IDesignerSelections;

  procedure ChangeUp(ADelta: Integer);
  var
    I, Index: Integer;
    ParentItem, NewParentItem, MenuItem: TcxWebMenuItem;
  begin
    for I := 0 to GetComponentCount - 1 do
      if Selected[I] then break;
    ParentItem := MenuItems[I].Parent;
    NewParentItem := ParentItem;
    Index := 0;
    while ADelta < 0 do
    begin
      if ADelta = -1 then
        Index := NewParentItem.Index + 1;
      NewParentItem := ParentItem.Parent;
      Inc(ADelta);
    end;

    for I := GetComponentCount - 1 downto 0 do
      if Selected[I] then
      begin
        MenuItem := MenuItems[I];
        ParentItem.Remove(MenuItem);
        NewParentItem.Insert(Index, MenuItem);
      end;
  end;

  procedure ChangeDown(ADelta: Integer);
  var
    I, Index: Integer;
    ParentItem, NewParentItem, MenuItem: TcxWebMenuItem;
  begin
    for I := 0 to GetComponentCount - 1 do
      if Selected[I] then break;
    ParentItem := MenuItems[I].Parent;
    Index := MenuItems[I].Index - 1;
    if Index < 0 then
      Index := 0;
    NewParentItem := ParentItem.Items[Index];

    for I := GetComponentCount - 1 downto 0 do
      if Selected[I] then
      begin
        MenuItem := MenuItems[I];
        ParentItem.Remove(MenuItem);
        NewParentItem.Insert(NewParentItem.Count, MenuItem);
      end;
  end;

begin
  WebMenuDesigner.BeginUpdate;
  try
    if ADelta > 0 then
      ChangeDown(ADelta)
    else
      ChangeUp(ADelta);
  finally
    WebMenuDesigner.EndUpdate;
  end;
  RefreshMainControl;  //TODO: Remove

  Selections := CreateSelectionList;
  Designer.GetSelections(Selections);
  UpdateSelections(Selections);
end;

procedure TcxfmMenuDesignWindow.DrawDragRect;
begin
  {$IFDEF VCL}
  with TreeView do
    if (TreeView.Selected <> nil) and (FLastDragIndex <> -1) and
      (FLastDragIndex <> TreeView.Selected.AbsoluteIndex) then
      Canvas.DrawFocusRect(TreeView.Items[FLastDragIndex].DisplayRect(true));
  {$ENDIF}    
end;

procedure TcxfmMenuDesignWindow.MoveItemsTo(AMenuItem: TcxWebMenuItem);
var
  I: Integer;
  Item, ParentItem: TcxWebMenuItem;
begin
  for I := 0 to GetComponentCount - 1 do
    if Selected[I] then
    begin
      Item := MenuItems[I];

      ParentItem := AmenuItem;
      while ParentItem <> nil do
      begin
        if ParentItem.Parent = Item then
          break;
        ParentItem := ParentItem.Parent;
      end;

      if ParentItem = nil then
      begin
        Item.Parent.Remove(Item);
        AMenuItem.Insert(AMenuItem.Count, Item);
//        GetMenuItemNode(Item, false).Delete;
//        TreeView.Items.AddChildObject(GetMenuItemNode(AMenuItem, false), Item.Caption, Item);
      end;
    end;
  RefreshMainControl; //TODO: Remove  
end;

procedure TcxfmMenuDesignWindow.RefreshMainControlItem(AParentNode: TTreeNode);
var
  I: Integer;
  ParentMenuItem, MenuItem: TcxWebMenuItem;
  ParentNode: TTreeNode;
begin
  ParentMenuItem := TcxWebMenuItem(AParentNode.Data);
  for I := 0 to ParentMenuItem.Count - 1 do
  begin
    MenuItem := ParentMenuItem.Items[I];
    ParentNode := TreeView.Items.AddChildObject(AParentNode, MenuItem.Caption, MenuItem);
    if MenuItem.Count > 0 then
      RefreshMainControlItem(ParentNode);
  end;
end;

procedure TcxfmMenuDesignWindow.Select(AItem: TPersistent; AddToSelection: Boolean);
var
  Selections: IDesignerSelections;
begin
  Selections := CreateSelectionList;
  if AddToSelection then
    Designer.GetSelections(Selections);
  Selections.Add(AItem);
  Designer.SetSelections(Selections);
end;

procedure TcxfmMenuDesignWindow.UpdateControlsState;
begin
  inherited UpdateControlsState;
  btnAddItem.Enabled := CanAddItem;
  btnAddSubItem.Enabled := CanAddSubItem;
  btnDelete.Enabled := CanDelete;
  btnSelectAll.Enabled := CanSelectAll;
  btnMoveUp.Enabled := CanMoveUp;
  btnMoveDown.Enabled := CanMoveDown;
  btnLevelUp.Enabled := CanLevelUp;
  btnLevelDown.Enabled := CanLevelDown;
end;

function TcxfmMenuDesignWindow.GetMenuItem(Index: Integer): TcxWebMenuItem;
begin
  Result := GetComponent(Index) as TcxWebMenuItem;
end;

procedure TcxfmMenuDesignWindow.UpdateMenuState;
begin
  miAddItem.Enabled := CanAddItem;
  miAddSubItem.Enabled := CanAddSubItem;
  miCut.Enabled := CanCut;
  miCopy.Enabled := CanCopy;
  miPaste.Enabled := CanPaste;
  miDelete.Enabled := CanDelete;
  miSelectAll.Enabled := CanSelectAll;
  miMoveUp.Enabled := CanMoveUp;
  miMoveDown.Enabled := CanMoveDown;
  miLevelUp.Enabled := CanLevelUp;
  miLevelDown.Enabled := CanLevelDown;
  miShowButtons.Checked := pnlButtons.Visible;
end;

procedure TcxfmMenuDesignWindow.btnAddItemClick(Sender: TObject);
begin
  if CurrentMenuItem.Parent <> nil then
    AddMenuItem(CurrentMenuItem.Parent)
  else
    AddMenuItem(WebMenuHelper.Items);
  ActiveControl := TreeView;
end;

procedure TcxfmMenuDesignWindow.btnAddSubItemClick(Sender: TObject);
begin
  AddMenuItem(CurrentMenuItem);
  ActiveControl := TreeView;
end;

procedure TcxfmMenuDesignWindow.btnMoveUpClick(Sender: TObject);
begin
  ChangeIndexes(-1);
end;

procedure TcxfmMenuDesignWindow.btnMoveDownClick(Sender: TObject);
begin
  ChangeIndexes(1);
end;

procedure TcxfmMenuDesignWindow.TreeViewClick(Sender: TObject);
var
  Selections: IDesignerSelections;
begin
  Selections := CreateSelectionList;
  GetSelections(Selections);
  Designer.SetSelections(Selections);
end;

procedure TcxfmMenuDesignWindow.TreeViewDblClick(Sender: TObject);
begin
  Designer.Edit(CurrentMenuItem);
end;

procedure TcxfmMenuDesignWindow.TreeViewEdited(Sender: TObject;
  Node: TTreeNode; var S: {$IFDEF VCL}string{$ELSE}WideString{$ENDIF});
begin
  GetNodeMenuItem(Node).Caption := S;
  Designer.Modified;
end;

procedure TcxfmMenuDesignWindow.TreeViewStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  FLastDragIndex := -1;
end;

procedure TcxfmMenuDesignWindow.TreeViewEndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  DrawDragRect;
end;

procedure TcxfmMenuDesignWindow.TreeViewDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  I, Index: Integer;
  Node: TTreeNode;
  ParentItem: TcxWebMenuItem;
begin
  Accept := Sender = Source;
  if Accept then
    with TTreeView(Sender) do
    begin
      Node := GetNodeAt(X, Y);
      if Node <> nil then
        Index := GetNodeAt(X, Y).AbsoluteIndex
      else Index := -1;

      for I := 0 to GetComponentCount - 1 do
      begin
        if Self.Selected[I] then
        begin
          if FLastDragIndex <> -1 then
            ParentItem := MenuItems[FLastDragIndex]
          else ParentItem := WebMenuHelper.Items;

          while ParentItem <> nil do
          begin
            if ParentItem.Parent = MenuItems[I] then
              break;
            ParentItem := ParentItem.Parent;
          end;

          if ParentItem <> nil then
            break;
        end;
      end;
      Accept := (TreeView.Selected <> nil) and (FLastDragIndex <> TreeView.Selected.AbsoluteIndex) and
          (I >= GetComponentCount);

      DrawDragRect;
      FLastDragIndex := Index;
      DrawDragRect;
    end;
end;

procedure TcxfmMenuDesignWindow.TreeViewDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  ParentItem: TcxWebMenuItem;
begin
  if FLastDragIndex <> -1 then
    ParentItem := MenuItems[FLastDragIndex]
  else ParentItem := WebMenuHelper.Items;

  MoveItemsTo(ParentItem);
end;

procedure TcxfmMenuDesignWindow.btnLevelUpClick(Sender: TObject);
begin
  ChangeLevels(-1);
end;

procedure TcxfmMenuDesignWindow.btnLevelDownClick(Sender: TObject);
begin
  ChangeLevels(1);
end;

end.


