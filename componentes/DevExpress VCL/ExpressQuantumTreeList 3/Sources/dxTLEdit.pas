
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressQuantumTreeList items editor                         }
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
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxTLEdit;

interface

{$I dxTLVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dxTL, StdCtrls, ExtCtrls, Mask, Menus, dxCntner;

type
  TFdxTreeListEdit = class(TForm)
    Panel1: TPanel;
    BColumnCustomizing: TButton;
    TreeList: TdxTreeList;
    Panel2: TPanel;
    btNewItem: TButton;
    btNewSubItem: TButton;
    btDeleteItem: TButton;
    Panel3: TPanel;
    BHelp: TButton;
    BCancel: TButton;
    BOk: TButton;
    PopupMenu: TPopupMenu;
    miNew: TMenuItem;
    miNewSubItem: TMenuItem;
    miDelete: TMenuItem;
    N1: TMenuItem;
    miColumns: TMenuItem;
    Panel4: TPanel;
    Panel5: TPanel;
    GroupBox1: TGroupBox;
    LImage: TLabel;
    edImageIndex: TEdit;
    LSelected: TLabel;
    edSelectedIndex: TEdit;
    LState: TLabel;
    edStateIndex: TEdit;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edDefImage: TEdit;
    edDefSelected: TEdit;
    edDefState: TEdit;
    procedure BColumnCustomizingClick(Sender: TObject);
    procedure TreeListChangeNode(Sender: TObject; OldNode,
      Node: TdxTreeListNode);
    procedure TreeListEnter(Sender: TObject);
    procedure btNewItemClick(Sender: TObject);
    procedure btNewSubItemClick(Sender: TObject);
    procedure btDeleteItemClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure TreeListDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TreeListDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
  private
    procedure WMGetMinMaxInfo(var Message : TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
    procedure SetDefaultSettings(Node: TdxTreeListNode);
  end;

function ShowdxTreeListEditor(ATreeList: TdxTreeList): Boolean;

implementation

{$R *.DFM}

function ShowdxTreeListEditor(ATreeList: TdxTreeList): Boolean;
var
  AForm: TFdxTreeListEdit;
  Column: TdxTreeListColumn;
  I: Integer;
begin
  Result := False;
  AForm := TFdxTreeListEdit.Create(nil);
  with AForm do
  begin
    TreeList.BeginUpdate;
    try
      // Style
      with TreeList do
      begin
        ArrowsColor := ATreeList.ArrowsColor;
        BandColor := ATreeList.BandColor;
        BandFont.Assign(ATreeList.BandFont);
        BandMaxRowCount := ATreeList.BandMaxRowCount;
        BandRowCount := ATreeList.BandRowCount;
        Color := ATreeList.Color;
        DefaultLayout := ATreeList.DefaultLayout;
        DefaultRowHeight := ATreeList.DefaultRowHeight;
        FixedBandLineWidth := ATreeList.FixedBandLineWidth;
        RowFooterColor := ATreeList.RowFooterColor;
        RowFooterTextColor := ATreeList.RowFooterTextColor;
        GridLineColor := ATreeList.GridLineColor;
        GroupNodeColor := ATreeList.GroupNodeColor;
        GroupNodeTextColor := ATreeList.GroupNodeTextColor;
        HeaderColor := ATreeList.HeaderColor;
        HeaderFont.Assign(ATreeList.HeaderFont);
        HeaderMinRowCount := ATreeList.HeaderMinRowCount;
        HeaderPanelMaxRowCount := ATreeList.HeaderPanelMaxRowCount;
        HeaderPanelRowCount := ATreeList.HeaderPanelRowCount;
        Images := ATreeList.Images;
        IndentDesc := ATreeList.IndentDesc;
        LookAndFeel := ATreeList.LookAndFeel;
        // Options
        Options := ATreeList.Options;
        Options := Options + [aoColumnSizing, aoColumnMoving, aoEditing,
          aoMultiSelect, aoImmediateEditor, aoExtMultiSelect];
        Options := Options - [aoRowSelect, aoTabs, aoHideFocusRect];
        // OptionsEx
        OptionsEx := ATreeList.OptionsEx;
        OptionsEx := OptionsEx + [aoBandSizing, aoBandMoving, aoEnterShowEditor,
          aoFullSizing, aoDragScroll, aoDragExpand, aoDragCollapse,
          aoBandPanelSizing, aoHeaderPanelSizing{, aoRowSizing}];
        PaintStyle := ATreeList.PaintStyle;
        PreviewLines := ATreeList.PreviewLines;
        RowSeparatorLineWidth := ATreeList.RowSeparatorLineWidth;
        ScrollBars := ATreeList.ScrollBars;
        ShowBands := ATreeList.ShowBands;
        ShowButtons := ATreeList.ShowButtons;
        ShowFooter := ATreeList.ShowFooter;
        ShowGrid := ATreeList.ShowGrid;
        ShowHeader := ATreeList.ShowHeader;
        ShowIndicator := ATreeList.ShowIndicator;
        ShowLines := ATreeList.ShowLines;
        ShowPreviewGrid := ATreeList.ShowPreviewGrid;
        ShowRoot := ATreeList.ShowRoot;
        ShowRowFooter := ATreeList.ShowRowFooter;
        StateImages := ATreeList.StateImages;
        TreeLineColor := ATreeList.TreeLineColor;
        TreeLineStyle := ATreeList.TreeLineStyle;
        WaitForExpandNodeTime := ATreeList.WaitForExpandNodeTime;
      end;
      TreeList.Bands.Assign(ATreeList.Bands);
      TreeList.AssignColumns(ATreeList);
      TreeList.AssignNodes(ATreeList);
      TreeList.FullExpand;
      if TreeList.TopNode <> nil then
      begin
        TreeList.TopNode.Focused := True;
        TreeList.TopNode.Selected := True;
      end;
    finally
      TreeList.EndUpdate;
    end;
    Caption := 'ExpressTreeList Items Editor (' + ATreeList.Name + ')';
    ShowModal;
    TreeList.EndColumnsCustomizing;
    if (ModalResult = mrOk) then
    begin
      ATreeList.BeginUpdate;
      try
        ATreeList.BandRowCount := TreeList.BandRowCount;
        ATreeList.DefaultRowHeight := TreeList.DefaultRowHeight;
        ATreeList.HeaderPanelRowCount := TreeList.HeaderPanelRowCount;
        ATreeList.Bands.Assign(TreeList.Bands);
        // assign columns
//        ATreeList.AssignColumns(TreeList);
        for I := 0 to TreeList.ColumnCount - 1 do
        begin
          Column := ATreeList.ColumnByName(TreeList.Columns[I].Name);
          Column.Assign(TreeList.Columns[I]);
        end;
        ATreeList.AssignNodes(TreeList);
        ATreeList.FullExpand;
        ATreeList.TopIndex := TreeList.TopIndex;
        ATreeList.FocusedNumber := TreeList.FocusedNumber;
        ATreeList.FocusedColumn := TreeList.FocusedColumn;
      finally
        ATreeList.EndUpdate;
      end;
      Result := True;
    end;
  end;
  AForm.Free;
end;

procedure TFdxTreeListEdit.FormCreate(Sender: TObject);
begin
  {PM}
  miNew.Caption := btNewItem.Caption;
  miNewSubItem.Caption := btNewSubItem.Caption;
  miDelete.Caption := btDeleteItem.Caption;
  miColumns.Caption := BColumnCustomizing.Caption;
end;

procedure TFdxTreeListEdit.FormActivate(Sender: TObject);
begin
  TreeListChangeNode(Self, nil, TreeList.FocusedNode);
end;

procedure TFdxTreeListEdit.WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo);
begin
  Message.MinMaxInfo^.ptMinTrackSize := Point(450, 354{280});
  inherited;
end;

procedure TFdxTreeListEdit.SetDefaultSettings(Node: TdxTreeListNode);
begin
  with Node do
  try
    TreeList.ClearSelection;
    Focused := True;
    Selected := True;
    ImageIndex := StrToInt(edDefImage.Text);
    SelectedIndex := StrToInt(edDefSelected.Text);
    StateIndex := StrToInt(edDefState.Text);
  except
  end;
end;

// Events
procedure TFdxTreeListEdit.BColumnCustomizingClick(Sender: TObject);
begin
  TreeList.ColumnsCustomizing;
end;

procedure TFdxTreeListEdit.btNewItemClick(Sender: TObject);
var
  Item: TdxTreeListNode;
begin
  if (TreeList.FocusedNode <> nil) and
     (TreeList.FocusedNode.Parent <> nil) then
    Item := TreeList.FocusedNode.Parent.AddChild
  else Item := TreeList.Add;
  if Item <> nil then
    SetDefaultSettings(Item);
end;

procedure TFdxTreeListEdit.btNewSubItemClick(Sender: TObject);
var
  Item: TdxTreeListNode;
begin
  if TreeList.FocusedNode <> nil then
  begin
    Item := TreeList.FocusedNode.AddChild;
    if Item <> nil then
      SetDefaultSettings(Item);
  end;
end;

procedure TFdxTreeListEdit.btDeleteItemClick(Sender: TObject);
begin
  TreeList.DeleteSelection;
end;

procedure TFdxTreeListEdit.TreeListChangeNode(Sender: TObject; OldNode,
  Node: TdxTreeListNode);
begin
  try
    if edImageIndex.Modified and (OldNode <> nil) then
      OldNode.ImageIndex := StrToInt(edImageIndex.Text);
    if edSelectedIndex.Modified and (OldNode <> nil) then
      OldNode.SelectedIndex := StrToInt(edSelectedIndex.Text);
    if edStateIndex.Modified and (OldNode <> nil) then
      OldNode.StateIndex := StrToInt(edStateIndex.Text);
  except
  end;
  if Node = nil then Exit;
  edImageIndex.Text := IntToStr(Node.ImageIndex);
  edSelectedIndex.Text := IntToStr(Node.SelectedIndex);
  edStateIndex.Text := IntToStr(Node.StateIndex);
end;

procedure TFdxTreeListEdit.TreeListDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  AItem, AnItem: TdxTreeListNode;
  AttachMode: TdxTreeListNodeAttachMode;
  HT: TdxTreeListHitTest;
begin
  if TreeList.SelectedCount = 0 then Exit;
  HT := TreeList.GetHitTestInfoAt(X, Y);
  AnItem := TreeList.GetNodeAt(X, Y);
  if HT in [htButton, htIcon, htStateIcon, htLabel, htNowhere, htIndent] then
  begin
    AttachMode := natlAddChild;
    if HT in [htButton, htIcon, htStateIcon, htLabel] then
      AttachMode := natlAddChild
    else if HT = htNowhere then
    begin
      AnItem := TreeList.Items[0];
      AttachMode := natlAdd;
    end
    else if HT = htIndent then AttachMode := natlInsert;
    while TreeList.SelectedCount > 0 do
    begin
      AItem := TreeList.SelectedNodes[0];
      AItem.Selected := False;
      AItem.MoveTo(AnItem, AttachMode);
    end;
  end;
end;

procedure TFdxTreeListEdit.TreeListDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if Source = TreeList then Accept := True
  else Accept := False;
end;

procedure TFdxTreeListEdit.TreeListEnter(Sender: TObject);
begin
  TreeListChangeNode(Self, TreeList.FocusedNode, TreeList.FocusedNode);
end;

end.
