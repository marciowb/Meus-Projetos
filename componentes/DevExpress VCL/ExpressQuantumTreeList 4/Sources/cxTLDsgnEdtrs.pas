
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

unit cxTLDsgnEdtrs;

{$I cxVer.inc}

interface

uses
  Classes, SysUtils,
{$IFDEF DELPHI5}
  DesignConst, //DesignEditors,
{$ENDIF}
{$IFDEF DELPHI6}
  DesignIntf, ComponentDesigner,
{$ELSE}
  DsgnWnds, DsgnIntf, LibIntf,
{$ENDIF}
  Windows, Messages,
  cxDesignWindows, Forms, Controls, ComCtrls, Graphics, Dialogs, Menus, StdCtrls,
  ExtCtrls, cxControls, cxButtons, cxClasses, cxLookAndFeelPainters, cxTLIntf,
  cxTLStrs, cxInplaceContainer, cxTL, cxDBTL, cxLookAndFeels;

type
  TcxTreeListAccess = class(TcxCustomTreeListControl);

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
    mnuCAdd: TMenuItem;
    pmBands: TPopupMenu;
    btnBAdd: TcxButton;
    btnCreateAllFields: TcxButton;
    mnuCSelectAll: TMenuItem;
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
    mnuBDel: TMenuItem;
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
  private
    FDisableSelection: Boolean;
    function GetTreeList: TcxTreeListAccess;
  protected
   // new metods
    procedure AddListItem(AListBox: TListBox; AProc: TNotifyEvent);
    procedure DeleteSelectedItems(AListBox: TListBox; AProc: TNotifyEvent);
    procedure ChangeNameHandler(Sender: TObject);
    procedure GetSelection(AListBox: TListBox; AList: TList);
    procedure InitControls;
    procedure FillLists;
    procedure ListBoxSelectionChanged(AListBox: TListBox;
      const AButtons: array of TcxButton; const AMenuItems: array of TMenuItem);
    procedure MoveBy(AListBox: TListBox; AProc: TNotifyEvent; AIncr: Integer);
    procedure MoveDownListItem(AListBox: TListBox; AProc: TNotifyEvent);
    procedure MoveUpListItem(AListBox: TListBox; AProc: TNotifyEvent);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SelectAll(AListBox: TListBox; AProc: TNotifyEvent);
    procedure SelectItem;
    procedure SelectSelectedItems(AListBox: TListBox);
    procedure SetListBoxSelection(AList: TListBox; ASelection: Boolean);
    procedure UnSelectAll;

   // IcxTreeListDesigner
    procedure ComponentRemoved(Sender: TObject);
    procedure Modified;
    property TreeList: TcxTreeListAccess read GetTreeList;
  public
    destructor Destroy; override;
    procedure Activate; override;
    procedure InitFormEditor; override;
    procedure SetVisibleSheetIndex(AIndex: Integer);
  end;

procedure SetColumnsUniqueName(ATreeList: TcxCustomTreeListControl);
procedure SetColumnUniqueName(ATreeList: TcxCustomTreeListControl; AColumn: TcxTreeListColumn);

implementation

{$R *.dfm}

type
  TcxControlAccess = class(TcxControl);
  TcxColumnAccess = class(TcxTreeListColumn); 

procedure SetColumnUniqueName(ATreeList: TcxCustomTreeListControl; AColumn: TcxTreeListColumn);
var
  AFieldName: string;
begin
  if AColumn.Name <> '' then Exit;
  if AColumn is TcxDBTreeListColumn then
    AFieldName := TcxDBTreeListColumn(AColumn).DataBinding.FieldName
  else
    AFieldName := '';
  AColumn.Name := CreateUniqueName(ATreeList.Owner, ATreeList, AColumn, '', AFieldName);
end;

procedure SetColumnsUniqueName(ATreeList: TcxCustomTreeListControl);
var
  I: Integer;
begin
  with TcxTreeListAccess(ATreeList) do
    for I := 0 to ColumnCount - 1 do SetColumnUniqueName(ATreeList, Columns[I]);
end;

{ TcxTreeListBandColumnDesigner }

destructor TcxTreeListBandColumnDesigner.Destroy;
var
  I: Integer;
begin
  if (TreeList <> nil) and (not TreeList.IsDestroying) then
  begin
    for I := 0 to TreeList.ColumnCount - 1 do
      TcxColumnAccess(TreeList.Columns[I]).OnChangeName := nil;
  end;
  inherited Destroy;
end;

procedure TcxTreeListBandColumnDesigner.Activate;
begin
  inherited Activate;
  Constraints.MinHeight := Height;
  Constraints.MinWidth := Width;
  FillLists;
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
  FillLists;
  btnCreateAllFields.Visible := Component is TcxDBTreeList;
  mnuCreateAllFields.Visible := Component is TcxDBTreeList;
  SetShortCuts;
end;

procedure TcxTreeListBandColumnDesigner.SetVisibleSheetIndex(AIndex: Integer);
begin
{$IFDEF DELPHI5}
  PageControl.ActivePageIndex := AIndex;
{$ELSE}
  PageControl.ActivePage := PageControl.Pages[AIndex];
{$ENDIF}
end;

procedure TcxTreeListBandColumnDesigner.ComponentRemoved(Sender: TObject);
begin
end;

procedure TcxTreeListBandColumnDesigner.Modified;
begin
  Designer.Modified;
end;

function TcxTreeListBandColumnDesigner.GetTreeList: TcxTreeListAccess;
begin
  if Component is TcxCustomTreeListControl then
    Result := TcxTreeListAccess(Component)
  else
    Result := nil;
end;

procedure TcxTreeListBandColumnDesigner.BandTabButtonsClick(Sender: TObject);
begin
  TreeList.BeginUpdate;
  try
    case (Sender as TComponent).Tag of
      0:
      begin
        TreeList.Bands.Add;
        AddListItem(lbxBands, BandsListClick);
      end;
      1:
        DeleteSelectedItems(lbxBands, BandsListClick);
      2:
        MoveUpListItem(lbxBands, BandsListClick);
      3:
        MoveDownListItem(lbxBands, BandsListClick);
      4:
        TreeList.Bands.RestoreDefaults;
      5:
        TreeList.Bands.RestoreWidths;
      8:
        SelectAll(lbxBands, BandsListClick);
    end;
  finally
    TreeList.EndUpdate;
  end;
end;

procedure TcxTreeListBandColumnDesigner.ColumnsEventHandle(Sender: TObject);
begin
  TreeList.BeginUpdate;
  try
    case (Sender as TComponent).Tag of
      0:
      begin
        SetColumnUniqueName(TreeList, TreeList.CreateColumn);
        AddListItem(lbxColumns, ColumnsListClick);
      end;
      1:
        DeleteSelectedItems(lbxColumns, ColumnsListClick);
      2:
        MoveUpListItem(lbxColumns, ColumnsListClick);
      3:
        MoveDownListItem(lbxColumns, ColumnsListClick);
      4:
        TreeList.RestoreColumnsDefaults;
      5:
        TreeList.RestoreColumnsWidths;
      6:
      begin
        if Component is TcxDBTreeList then
          (Component as TcxDBTreeList).DataController.CreateAllItems;
        SetColumnsUniqueName(TreeList);
        AddListItem(lbxColumns, ColumnsListClick);
      end;
      8:
        SelectAll(lbxColumns, ColumnsListClick);
    end;
  finally
    TreeList.EndUpdate;
  end;
end;

procedure TcxTreeListBandColumnDesigner.AddListItem(AListBox: TListBox; AProc: TNotifyEvent);
begin
  with AListBox do
  begin
    Items.BeginUpdate;
    FDisableSelection := True;
    try
      FillLists;
      Selected[Items.Count - 1] := True;
      ItemIndex := Items.Count - 1;
      AListBox.SetFocus;
    finally
      FDisableSelection := False;
      Items.EndUpdate;
    end;
    AProc(AListBox);
    Modified;
  end;
end;

procedure TcxTreeListBandColumnDesigner.ChangeNameHandler(Sender: TObject);
var
  AIndex: Integer;
begin
  AIndex := lbxColumns.Items.IndexOfObject(Sender);
  if AIndex <> -1 then
    lbxColumns.Items[AIndex] := TComponent(Sender).Name;
end;

procedure TcxTreeListBandColumnDesigner.DeleteSelectedItems(
  AListBox: TListBox; AProc: TNotifyEvent);
var
  I, AOldIndex: Integer;
  AList: TList;
begin
  if AListBox.SelCount = 0 then Exit;
  AOldIndex := AListBox.ItemIndex;
  AList := TList.Create;
  try
    GetSelection(AListBox, AList);
    AListBox.Items.BeginUpdate;
    FDisableSelection := True;
    try
      UnSelectAll;
      SelectItem;
      for I := 0 to AList.Count - 1 do
        TObject(AList[I]).Free;
      FillLists;
      if AOldIndex >= AListBox.Items.Count then
        AOldIndex := AListBox.Items.Count - 1;
      if (AOldIndex <> -1) and (AListBox.Items.Count > 0) then
        AListBox.Selected[AOldIndex] := True;
      AListBox.SetFocus;
    finally
      FDisableSelection := False;
      AListBox.Items.EndUpdate;
    end;
    AProc(AListBox);
    Modified;
  finally
    AList.Free;
  end;
end;

procedure TcxTreeListBandColumnDesigner.GetSelection(
  AListBox: TListBox; AList: TList);
var
  I: Integer;
begin
  with AListBox do
  begin
    for I := 0 to Items.Count - 1 do
      if Selected[I] and (Items.Objects[I] <> nil) then
        AList.Add(Items.Objects[I]);
  end;
end;

procedure TcxTreeListBandColumnDesigner.InitControls;
var
  AMasterLookAndFeel: TcxLookAndFeel;

  procedure DoCheckSubControls(AComponent: TComponent);
  var
    I: Integer;
  begin
    for I := 0 to AComponent.ComponentCount - 1 do
    begin
      if AComponent.Components[I] is TcxControl then
        with TcxControlAccess(AComponent.Components[I]) do
          LookAndFeel.MasterLookAndFeel := AMasterLookAndFeel;
      DoCheckSubControls(AComponent.Components[I]);
    end;
  end;

begin
  AMasterLookAndFeel := TreeList.LookAndFeel;
  DoCheckSubControls(Self);
end;

procedure TcxTreeListBandColumnDesigner.MoveBy(
  AListBox: TListBox; AProc: TNotifyEvent; AIncr: Integer);
var
  AIntf: IcxTreeListIndexedItem;
  AIndex, I, AOldIndex: Integer;
begin
  if AListBox.SelCount = 0 then Exit;
  AListBox.Items.BeginUpdate;
  FDisableSelection := True;
  try
    AOldIndex := 0;
    for I := 0 to AListBox.Items.Count - 1 do
      if AListBox.Selected[I] then
      begin
        if Supports(AListBox.Items.Objects[I], IcxTreeListIndexedItem, AIntf) then
        begin
          AIndex := AIntf.GetItemIndex; 
          AIntf.SetItemIndex(AIndex + AIncr);
        end;
        AOldIndex := I + AIncr;
      end;
    FillLists;
    if AOldIndex < 0 then AOldIndex := 0;
    if AOldIndex >= AListBox.Items.Count then
      AOldIndex := AListBox.Items.Count - 1;
    if (AOldIndex <> -1) and (AListBox.Items.Count > 0) then
      AListBox.Selected[AOldIndex] := True;
  finally
    FDisableSelection := False;
    AListBox.Items.EndUpdate;
  end;
  AProc(AListBox);
  Modified;
end;

procedure TcxTreeListBandColumnDesigner.MoveDownListItem(
  AListBox: TListBox; AProc: TNotifyEvent);
begin
  MoveBy(AListBox, AProc, 1);
end;

procedure TcxTreeListBandColumnDesigner.MoveUpListItem(
  AListBox: TListBox; AProc: TNotifyEvent);
begin
  MoveBy(AListBox, AProc, -1);
end;

procedure TcxTreeListBandColumnDesigner.Notification(AComponent: TComponent; Operation: TOperation);
var
  I: Integer;
begin
  inherited Notification(AComponent, Operation);
  if (csDestroying in ComponentState) or (TreeList = nil) or TreeList.IsDestroying then Exit;
  if Operation = opRemove then
  begin
    I := lbxColumns.Items.IndexOfObject(AComponent);
    if I <> -1 then
    begin
      lbxColumns.Items.Delete(I);
      UnselectAll;
    end;
  end;
end;

procedure TcxTreeListBandColumnDesigner.FillLists;
var
  I: Integer;
begin
  // Bands
  lbxBands.Items.BeginUpdate;
  try
    lbxBands.Items.Clear;
    with TreeList do
    begin
      for I := 0 to Bands.Count - 1 do
        lbxBands.Items.AddObject(IntToStr(I) + ' - ' + Bands[I].ClassName, Bands[I]);
    end;
  finally
    lbxBands.Items.EndUpdate;
  end;
  // Columns
  lbxColumns.Items.BeginUpdate;
  try
    lbxColumns.Items.Clear;
    with TreeList do
    begin
      for I := 0 to ColumnCount - 1 do
      begin
        lbxColumns.Items.AddObject(Columns[I].Name, Columns[I]);
        TcxColumnAccess(Columns[I]).OnChangeName := ChangeNameHandler;
        TreeList.Columns[I].FreeNotification(Self);
      end;
    end;
  finally
    lbxColumns.Items.EndUpdate;
  end;
  // select component
  SelectItem;
  Modified;
end;

procedure TcxTreeListBandColumnDesigner.ListBoxSelectionChanged(
  AListBox: TListBox; const AButtons: array of TcxButton;
  const AMenuItems: array of TMenuItem);

  procedure SetState(AIndex: Integer; AEnabled: Boolean);
  begin
    AButtons[AIndex].Enabled := AEnabled;
    if AMenuItems[AIndex] <> nil then
      AMenuItems[AIndex].Enabled := AEnabled;
  end;

var
  I: Integer;
begin
  if FDisableSelection then Exit;
  SelectSelectedItems(AListBox);
  for I := Low(AButtons) to High(AButtons) do
  begin
    if I in [0, 1] then
      SetState(I, AListBox.Items.Count > 0)
    else
      SetState(I, AListBox.SelCount > 0)
  end;
  Modified;
end;

procedure TcxTreeListBandColumnDesigner.SelectAll(AListBox: TListBox; AProc: TNotifyEvent);
begin
  AListBox.Items.BeginUpdate;
  try
    SetListBoxSelection(AListBox, True);
    AListBox.SetFocus;
  finally
    AListBox.Items.EndUpdate;
    AProc(AListBox);
  end;
end;

procedure TcxTreeListBandColumnDesigner.SelectItem;
begin
  if PageControl.ActivePage.TabIndex = 0 then
    BandsListClick(lbxBands)
  else
    ColumnsListClick(lbxColumns);
end;

procedure TcxTreeListBandColumnDesigner.SelectSelectedItems(AListBox: TListBox);
var
  AList: TList;
begin
  AList := TList.Create;
  try
    GetSelection(AListBox, AList);
    if AListBox = lbxColumns then
      AList.Sort(cxCompareColumnsPos);
    if AList.Count > 0 then
      SetSelectionList(AList);
  finally
    AList.Free;
  end;
end;

procedure TcxTreeListBandColumnDesigner.SetListBoxSelection(
  AList: TListBox; ASelection: Boolean);
var
  I: Integer;
begin
  AList.Items.BeginUpdate;
  try
    for I := 0 to AList.Items.Count - 1 do
      AList.Selected[I] := ASelection;
  finally
    AList.Items.EndUpdate;
  end;
end;

procedure TcxTreeListBandColumnDesigner.UnSelectAll;
begin
  SetListBoxSelection(lbxBands, False);
  SetListBoxSelection(lbxColumns, False);
end;

procedure TcxTreeListBandColumnDesigner.ColumnsListClick(Sender: TObject);
begin
  ListBoxSelectionChanged(lbxColumns,
    [btnCResD, btnCResW, btnCDel, btnCMoveU, btnCMoveD],
    [mnuCResD, mnuCResW, mnuCDel, mnuCMoveU, mnuCMoveD]);
end;

procedure TcxTreeListBandColumnDesigner.BandsListClick(Sender: TObject);
begin
  ListBoxSelectionChanged(lbxBands,
    [btnBResD, btnBResW, btnBDel, btnBMoveU, btnBMoveD],
    [mnuBResD, mnuBResW, mnuBDel, mnuBMoveU, mnuBMoveD]);
end;

procedure TcxTreeListBandColumnDesigner.lbxKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then ActivateInspector(#0);
end;

procedure TcxTreeListBandColumnDesigner.PageControlChange(Sender: TObject);
begin
  SelectItem;
end;

end.
