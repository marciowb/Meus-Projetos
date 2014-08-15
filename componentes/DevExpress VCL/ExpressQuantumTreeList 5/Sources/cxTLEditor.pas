
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

unit cxTLEditor;

{$I cxVer.inc}

interface

uses
  Classes, SysUtils, DesignIntf, ComponentDesigner, Windows, Messages,
  cxDesignWindows, Forms, Controls, ComCtrls, Graphics, Dialogs, Menus, StdCtrls,
  ExtCtrls, cxControls, cxButtons, cxClasses, cxLookAndFeelPainters,
  cxTLStrs, cxInplaceContainer, cxTL, cxLookAndFeels, Math;

type
  { TcxTreeListBandColumnDesigner }

  TcxTreeListSetIndexProc = procedure(AItem: TObject; AIndex: Integer) of object;
  TcxTreeListAddItemProc = procedure(AListBox: TListBox; AIndex: Integer) of object;

  TcxTreeListDesignerChange = (tldsgStructure, tldsgSelection);
  TcxTreeListDesignerChanges = set of TcxTreeListDesignerChange;

  TcxTreeListBandColumnDesigner = class(TcxDesignFormEditor, IcxTreeListDesigner)
    Panel2: TPanel;
    PageControl: TPageControl;
    tsBands: TTabSheet;
    Panel12: TPanel;
    lbxBands: TListBox;
    tsColumns: TTabSheet;
    pnButtons: TPanel;
    lbxColumns: TListBox;
    pmColumns: TPopupMenu;
    pmBands: TPopupMenu;
    btnBAdd: TcxButton;
    btnCreateAllFields: TcxButton;
    btnBDel: TcxButton;
    btnBMoveU: TcxButton;
    btnBMoveD: TcxButton;
    btnBResD: TcxButton;
    btnBResW: TcxButton;
    btnCAdd: TcxButton;
    btnCDel: TcxButton;
    btnCMoveU: TcxButton;
    btnCMoveD: TcxButton;
    btnCResD: TcxButton;
    btnCResW: TcxButton;
    mnuBAdd: TMenuItem;
    mnuCSelectAll: TMenuItem;
    mnuBDel: TMenuItem;
    mnuCAdd: TMenuItem;
    mnuBMoveU: TMenuItem;
    mnuBMoveD: TMenuItem;
    mnuBResD: TMenuItem;
    mnuBResW: TMenuItem;
    mnuCDel: TMenuItem;
    mnuCMoveU: TMenuItem;
    mnuCMoveD: TMenuItem;
    mnuCResD: TMenuItem;
    mnuCResW: TMenuItem;
    mnuCreateAllFields: TMenuItem;
    mnuBSelectAll: TMenuItem;
    procedure BandTabButtonsClick(Sender: TObject);
    procedure ColumnsListClick(Sender: TObject);
    procedure ColumnsEventHandle(Sender: TObject);
    procedure BandsListClick(Sender: TObject);
    procedure lbxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PageControlChange(Sender: TObject);
    procedure lbxColumnsDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure lbxBandsDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure FormCreate(Sender: TObject);
  private
    FChanges: TcxTreeListDesignerChanges;
    FLockCount: Integer;
    procedure AddBand(AListBox: TListBox; AIndex: Integer);
    procedure AddColumn(AListBox: TListBox; AIndex: Integer);
    function GetOperations: IcxTreeListDesignTimeOperations;
    function GetTreeList: TcxCustomTreeList;
  protected
    procedure Loaded; override;
   // new metods
    procedure DeleteSelection(AListBox: TListBox);
    procedure InitControls;
    procedure SyncEnabled;
    procedure SelectAllItems(AListBox: TListBox; ADefaultComponent: TPersistent);
    procedure UpdateItems(AListBox: TListBox; AItemCount: Integer;
      AAddItemProc: TcxTreeListAddItemProc);
    procedure UpdateLists(ARecreate: Boolean);

    procedure CalculateListBoxItemHeight(AListBox: TListBox);
    procedure DrawListBoxItem(AListBox: TListBox; AIndex: Integer; R: TRect;
      AParentBand: TcxTreeListBand);

    procedure MoveBy(AListBox: TListBox; AIncrement: Integer;
      ASetIndex: TcxTreeListSetIndexProc);
    procedure SetBandIndex(AItem: TObject; AIndex: Integer);
    procedure SetColumnIndex(AItem: TObject; AIndex: Integer);

   // IcxTreeListDesigner
    procedure ComponentRemoved(Sender: TObject);
    procedure ComponentModified;

    property Operations: IcxTreeListDesignTimeOperations read GetOperations;
    property TreeList: TcxCustomTreeList read GetTreeList;
  public
    destructor Destroy; override;
    procedure Activate; override;
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure InitFormEditor; override;
    procedure DoItemDeleted(AItem: TPersistent); override;
    procedure DoItemsModified; override;
    procedure SelectionsChanged(const ASelection: TDesignerSelectionList); override;
    procedure SetVisiblePageIndex(AIndex: Integer);
  end;

implementation

{$R *.dfm}

{ TcxTreeListBandColumnDesigner }

destructor TcxTreeListBandColumnDesigner.Destroy;
begin
  if TreeList <> nil then 
    TreeList.Designers.Remove(Self);
  inherited Destroy;
end;

procedure TcxTreeListBandColumnDesigner.Activate;
begin
  inherited Activate;
  SetControlLookAndFeel(Self, TreeList.LookAndFeel);
  UpdateLists(True);
end;

procedure TcxTreeListBandColumnDesigner.BeginUpdate;
begin
  Inc(FLockCount);
end;

procedure TcxTreeListBandColumnDesigner.EndUpdate;
begin
  Dec(FLockCount);
  if (FLockCount = 0) and (FChanges <> []) then
    UpdateLists(tldsgStructure in FChanges);
end;

procedure TcxTreeListBandColumnDesigner.InitFormEditor;

  procedure SetShortCuts;
  begin
    mnuBMoveU.ShortCut := ShortCut(VK_UP, [ssCtrl]);
    mnuBMoveD.ShortCut := ShortCut(VK_DOWN, [ssCtrl]);
    mnuCMoveU.ShortCut := ShortCut(VK_UP, [ssCtrl]);
    mnuCMoveD.ShortCut := ShortCut(VK_DOWN, [ssCtrl]);
  end;

begin
  inherited InitFormEditor;
  TreeList.Designers.Add(Self);
  UpdateLists(True);
  SetShortCuts;
end;

procedure TcxTreeListBandColumnDesigner.DoItemDeleted(AItem: TPersistent);

  procedure DeleteItem(AListBox: TListBox);
  var
    AIndex: Integer;
  begin
    AIndex := AListBox.Items.IndexOfObject(AItem);
    if AIndex <> -1 then
      AListBox.Items.Delete(AIndex);
  end;

begin
  inherited DoItemDeleted(AItem);
  if AItem is TcxTreeListColumn then
   DeleteItem(lbxColumns)
  else
    if AItem is TcxTreeListBand then
      DeleteItem(lbxBands);
end;

procedure TcxTreeListBandColumnDesigner.DoItemsModified;
begin
  inherited DoItemsModified;
  UpdateLists(True);
end;

procedure TcxTreeListBandColumnDesigner.SelectionsChanged(const ASelection: TDesignerSelectionList);
begin
  inherited SelectionsChanged(ASelection);
  if (TreeList <> nil) and not TreeList.IsDestroying then
    UpdateLists(False);
end;

procedure TcxTreeListBandColumnDesigner.SetVisiblePageIndex(AIndex: Integer);
begin
  PageControl.ActivePageIndex := AIndex;
end;

procedure TcxTreeListBandColumnDesigner.ComponentRemoved(Sender: TObject);
begin
end;

procedure TcxTreeListBandColumnDesigner.ComponentModified;
begin
end;

procedure TcxTreeListBandColumnDesigner.AddBand(AListBox: TListBox; AIndex: Integer);

  function GetBandDisplayText: string;
  begin
    Result := TreeList.Bands[AIndex].Caption.Text;
    if Result = '' then
      Result := '<Empty caption>';
    Result := IntToStr(AIndex) + ' - ' + Result;
  end;

begin
  AListBox.Items.AddObject(GetBandDisplayText, TreeList.Bands[AIndex]);
end;

procedure TcxTreeListBandColumnDesigner.AddColumn(AListBox: TListBox; AIndex: Integer);
begin
  AListBox.Items.AddObject(TreeList.Columns[AIndex].Name, TreeList.Columns[AIndex]);
//  TreeList.Columns[AIndex].FreeNotification(Self);
end;

function TcxTreeListBandColumnDesigner.GetOperations: IcxTreeListDesignTimeOperations;
begin
  Supports(TreeList, IcxTreeListDesignTimeOperations, Result)
end;

function TcxTreeListBandColumnDesigner.GetTreeList: TcxCustomTreeList;
begin
  if Component is TcxCustomTreeList then
    Result := Component as TcxCustomTreeList
  else
    Result := nil;
end;

procedure TcxTreeListBandColumnDesigner.BandTabButtonsClick(Sender: TObject);
begin
  TreeList.BeginUpdate;
  BeginUpdate;
  try
    case (Sender as TComponent).Tag of
      0:
        begin
          SelectComponent(TreeList.Bands.Add);
          Designer.Modified;
        end;
      1:
        DeleteSelection(lbxBands);
      2:
        MoveBy(lbxBands, -1, SetBandIndex);
      3:
        MoveBy(lbxBands, 1, SetBandIndex);
      4:
        TreeList.Bands.RestoreDefaults;
      5:
        TreeList.Bands.RestoreWidths;
      8:
        SelectAllItems(lbxBands, TreeList.Bands);
    end;
  finally
    EndUpdate;
    TreeList.EndUpdate;
  end;
end;

procedure TcxTreeListBandColumnDesigner.ColumnsEventHandle(Sender: TObject);
begin
  TreeList.BeginUpdate;
  BeginUpdate;
  try
    case (Sender as TComponent).Tag of
      0:
        SelectComponent(TreeList.CreateColumn);
      1:
        DeleteSelection(lbxColumns);
      2:
        MoveBy(lbxColumns, -1, SetColumnIndex);
      3:
        MoveBy(lbxColumns, 1, SetColumnIndex);
      4:
        TreeList.RestoreColumnsDefaults;
      5:
        TreeList.RestoreColumnsWidths;
      6:
        Operations.CreateAllItems;
      8:
        SelectAllItems(lbxColumns, TreeList);
    end;
  finally
    EndUpdate;
    TreeList.EndUpdate;
  end;
end;

procedure TcxTreeListBandColumnDesigner.Loaded;
begin
  inherited Loaded;
  Constraints.MinHeight := Height;
  Constraints.MinWidth := Width;
end;

procedure TcxTreeListBandColumnDesigner.DeleteSelection(AListBox: TListBox);
begin
  AListBox.Items.BeginUpdate;
  try
    ListBoxDeleteSelection(AListBox, False);
    if cxInRange(AListBox.ItemIndex, 0, AListBox.Count - 1) then
      SelectComponent(TPersistent(AListBox.Items.Objects[AListBox.ItemIndex]));
  finally
    AListBox.Items.EndUpdate;
  end;
end;

procedure TcxTreeListBandColumnDesigner.InitControls;

  procedure DoCheckSubControls(AComponent: TComponent);
  var
    I: Integer;
  begin
    for I := 0 to AComponent.ComponentCount - 1 do
    begin
      if AComponent.Components[I] is TcxControl then
        SetControlLookAndFeel(TWinControl(AComponent.Components[I]), TreeList.LookAndFeel);
      DoCheckSubControls(AComponent.Components[I]);
    end;
  end;

begin
  DoCheckSubControls(Self);
end;

procedure TcxTreeListBandColumnDesigner.MoveBy(AListBox: TListBox;
  AIncrement: Integer; ASetIndex: TcxTreeListSetIndexProc);
var
  I: Integer;
begin
  if AListBox.SelCount = 0 then Exit;
  BeginUpdate; 
  try
    for I := 0 to AListBox.Items.Count - 1 do
      if AListBox.Selected[I] then
        ASetIndex(AListBox.Items.Objects[I], I + AIncrement);
  finally
    EndUpdate; 
  end;
end;

procedure TcxTreeListBandColumnDesigner.SyncEnabled;

  procedure SyncEnabled(AButton: TcxButton; AMenuItem: TMenuItem; AEnabled: Boolean);
  begin
    AButton.Enabled := AEnabled;
    AMenuItem.Enabled := AEnabled;
  end;

begin
  btnCreateAllFields.Visible := Operations.SupportCreateAllItems;
  mnuCreateAllFields.Visible := Operations.SupportCreateAllItems;
  //
  SyncEnabled(btnBAdd, mnuBAdd, True);
  SyncEnabled(btnBDel, mnuBDel,  lbxBands.SelCount > 0);
  SyncEnabled(btnBMoveU, mnuBMoveU, lbxBands.SelCount > 0);
  SyncEnabled(btnBMoveD, mnuBMoveD, lbxBands.SelCount > 0);
  SyncEnabled(btnBResD, mnuBResD,  lbxBands.Count > 0);
  SyncEnabled(btnBResW, mnuBResW, lbxBands.Count > 0);
  mnuBSelectAll.Enabled := lbxBands.Count > 0;
  //
  SyncEnabled(btnCAdd, mnuCAdd, True);
  SyncEnabled(btnCDel, mnuCDel, lbxColumns.SelCount > 0);
  SyncEnabled(btnCMoveU, mnuCMoveU, lbxColumns.SelCount > 0);
  SyncEnabled(btnCMoveD, mnuCMoveD, lbxColumns.SelCount > 0);
  SyncEnabled(btnCResD, mnuCResD, lbxColumns.Count > 0);
  SyncEnabled(btnCResW, mnuCResW, lbxColumns.Count > 0);
  mnuCSelectAll.Enabled := lbxColumns.Count > 0;
end;

procedure TcxTreeListBandColumnDesigner.SelectAllItems(AListBox: TListBox;
  ADefaultComponent: TPersistent);
begin
  AListBox.Items.BeginUpdate;
  try
    ListBoxSelectAll(AListBox);
    ListBoxApplySelection(AListBox, ADefaultComponent);
  finally
    AListBox.Items.EndUpdate;
  end;
end;

procedure TcxTreeListBandColumnDesigner.UpdateItems(AListBox: TListBox;
  AItemCount: Integer; AAddItemProc: TcxTreeListAddItemProc);

  function IsSelected(AItem: TObject; ASelections: IDesignerSelections): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 0 to ASelections.Count - 1 do
      if AItem = ASelections[I] then
      begin
        Result := True;
        Break;
      end;
  end;

var
  I: Integer;
  ASelections: IDesignerSelections;
begin
  ASelections := CreateSelectionList;
  Designer.GetSelections(ASelections);
  AListBox.Items.BeginUpdate;
  try
    if Assigned(AAddItemProc) then
      AListBox.Items.Clear
    else
      AItemCount := AListBox.Count;
    for I := 0 to AItemCount - 1 do
    begin
      if Assigned(AAddItemProc) then
        AAddItemProc(AListBox, I);
      if AListBox.Selected[I] xor IsSelected(AListBox.Items.Objects[I], ASelections) then
        ListBoxSetSelected(AListBox, I, not AListBox.Selected[I]);
    end;
  finally
    AListBox.Items.EndUpdate;
  end;
end;

procedure TcxTreeListBandColumnDesigner.UpdateLists(ARecreate: Boolean);
const
  AChangeMap: array [Boolean] of TcxTreeListDesignerChange = (tldsgSelection, tldsgStructure);
var
  AAddBand, AAddColumn: TcxTreeListAddItemProc;
begin
  if FLockCount > 0 then
  begin
    Include(FChanges, AChangeMap[ARecreate]);
    Exit;
  end;

  if ARecreate then
  begin
    AAddBand := AddBand;
    AAddColumn := AddColumn;
  end
  else
  begin
    AAddBand := nil;
    AAddColumn := nil;
  end;

  UpdateItems(lbxColumns, TreeList.ColumnCount, AAddColumn);
  UpdateItems(lbxBands, TreeList.Bands.Count, AAddBand);

  SyncEnabled;
  FChanges := [];
end;

procedure TcxTreeListBandColumnDesigner.CalculateListBoxItemHeight(AListBox: TListBox);
begin
  with AListBox do
  begin
    Canvas.Font := Font;
    ItemHeight := 2 + Canvas.TextHeight('Qq');
  end;
end;

procedure TcxTreeListBandColumnDesigner.DrawListBoxItem(AListBox: TListBox; AIndex: Integer; R: TRect;
  AParentBand: TcxTreeListBand);

  function GetParentBandInfoOffset: Integer;
  var
    I, W: Integer;
  begin
    Result := 0;
    with AListBox as TListBox, Items do
      for I := 0 to Count - 1 do
      begin
        W := Canvas.TextWidth(Items[I]);
        if W > Result then Result := W;
      end;
    Inc(Result, 30);
  end;

  function GetParentBandInfoText: string;
  begin
    Result := '[ParentBand: ' + IntToStr(AParentBand.Index);
    if AParentBand.Caption.Text <> '' then
      Result := Result + ' - ' + AParentBand.Caption.Text;
    Result := Result + ']';
  end;

begin
  AListBox.Canvas.FillRect(R);
  AListBox.Canvas.TextOut(R.Left + 2, R.Top, AListBox.Items[AIndex]);
  if AParentBand <> nil then
  begin
    Inc(R.Left, GetParentBandInfoOffset);
    AListBox.Canvas.TextOut(R.Left, R.Top, GetParentBandInfoText);
  end;
end;

procedure TcxTreeListBandColumnDesigner.SetBandIndex(
  AItem: TObject; AIndex: Integer);
begin
  AIndex := Max(0, Min(AIndex, TreeList.Bands.Count - 1));
  if AIndex <> TcxTreeListBand(AItem).Index then
  begin
     TcxTreeListBand(AItem).Index := AIndex;
     UpdateLists(True);
     Designer.Modified;
  end;
end;

procedure TcxTreeListBandColumnDesigner.SetColumnIndex(
  AItem: TObject; AIndex: Integer);
begin
  AIndex := Max(0, Min(AIndex, TreeList.ColumnCount - 1));
  if AIndex <> TcxTreeListColumn(AItem).ItemIndex then
  begin
     TcxTreeListColumn(AItem).ItemIndex := AIndex;
     UpdateLists(True);
     Designer.Modified;
  end;
end;

procedure TcxTreeListBandColumnDesigner.ColumnsListClick(Sender: TObject);
begin
  ListBoxApplySelection(lbxColumns, TreeList);
end;

procedure TcxTreeListBandColumnDesigner.BandsListClick(Sender: TObject);
begin
  ListBoxApplySelection(lbxBands, TreeList.Bands);
end;

procedure TcxTreeListBandColumnDesigner.lbxKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then ActivateInspector(#0);
end;

procedure TcxTreeListBandColumnDesigner.PageControlChange(Sender: TObject);
var
  AListBox: TListBox;
begin
  if PageControl.ActivePageIndex = 0 then
    AListBox := lbxBands
  else
    AListBox := lbxColumns;
  ListBoxApplySelection(AListBox, TreeList);
end;

procedure TcxTreeListBandColumnDesigner.lbxColumnsDrawItem(
  Control: TWinControl; Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
begin
  DrawListBoxItem(TListBox(Control), Index, Rect, TcxTreeListColumn(lbxColumns.Items.Objects[Index]).Position.Band);
end;

procedure TcxTreeListBandColumnDesigner.lbxBandsDrawItem(
  Control: TWinControl; Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
begin
  DrawListBoxItem(TListBox(Control), Index, Rect, TcxTreeListBand(lbxBands.Items.Objects[Index]).ParentBand);
end;

procedure TcxTreeListBandColumnDesigner.FormCreate(Sender: TObject);
begin
  inherited FormCreate(Sender);
  CalculateListBoxItemHeight(lbxBands);
  CalculateListBoxItemHeight(lbxColumns);
end;

end.
