
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

unit cxTLItemsEdtr;

{$I cxVer.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxLookAndFeelPainters, cxMaskEdit, cxSpinEdit,
  cxContainer, cxEdit, cxTextEdit, StdCtrls, cxButtons, cxControls,
  cxLookAndFeels, cxInplaceContainer, cxTL, cxTLStrs, cxTLIntf, Menus,
  ExtCtrls, cxGraphics, cxCustomData;

type
  TcxTreeListAccess = class(TcxTreeList);

  TfrmItemsEditor = class(TForm, IcxTreeListDesigner)
    Panel1: TPanel;
    mnuEditItems: TPopupMenu;
    NewItem1: TMenuItem;
    NewSubItem1: TMenuItem;
    Delete1: TMenuItem;
    N1: TMenuItem;
    Customize1: TMenuItem;
    Panel2: TPanel;
    btnCustomize: TcxButton;
    Panel3: TPanel;
    btnNewItem: TcxButton;
    btnNewSubItem: TcxButton;
    btnDelete: TcxButton;
    cxLookAndFeelController1: TcxLookAndFeelController;
    Panel4: TPanel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    Panel5: TPanel;
    gbIndexes: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtImage: TcxTextEdit;
    edtSelected: TcxTextEdit;
    edtState: TcxTextEdit;
    gbDefaultIndexes: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtDefImage: TcxTextEdit;
    edtDefSelected: TcxTextEdit;
    edtDefState: TcxTextEdit;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel10: TPanel;
    cxTreeList1: TcxTreeList;
    Panel8: TPanel;
    cxTreeList1cxTreeListColumn1: TcxTreeListColumn;
    procedure cxButtonPress(Sender: TObject);
    procedure edtImageExit(Sender: TObject);
    procedure edtImageKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxTreeList1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
  private
    procedure AssignDataToTreeList;
    function GetTreeList: TcxTreeListAccess;
  protected
    procedure DoOnChangeTreeList(Sender: TObject);
    procedure DoSetImageIndex(Sender: TcxTextEdit);
    function GetValue(Sender: TcxTextEdit): Integer;
    // IcxTreeListDesigner
    procedure ComponentRemoved(Sender: TObject);
    procedure Modified;
    property TreeList: TcxTreeListAccess read GetTreeList;
  public
    Control: TcxTreeList;
    procedure Activated;
    function ShowModal: Integer; override;
  end;

  function cxShowTreeListItemsEditor(AControl: TcxTreeList): Boolean;

implementation

type
  TcxTLAccess = class(TcxTreeList);

{$R *.dfm}

function cxShowTreeListItemsEditor(AControl: TcxTreeList): Boolean;
begin
  with TfrmItemsEditor.Create(nil) do
  try
    Control := AControl;
    Result := ShowModal = mrOk;
    if Result then AssignDataToTreeList;
  finally
    Free;
  end;
end;

function TfrmItemsEditor.ShowModal: Integer;
begin
  Activated;
  Result := inherited ShowModal;
end;

procedure TfrmItemsEditor.Activated;
var
  I: Integer;
begin
  cxLookAndFeelController1.NativeStyle := TreeList.LookAndFeel.NativeStyle;
  cxLookAndFeelController1.Kind := TreeList.LookAndFeel.Kind;
  with TcxTreeListAccess(cxTreeList1) do
  begin
    DeleteAllColumns;
    BeginUpdate;
    try
      Bands := TreeList.Bands;
      for I := 0 to TreeList.ColumnCount - 1 do
        DoCreateColumn.Assign(TreeList.Columns[I]);
      Font := TreeList.Font;
      Styles := TreeList.Styles;
      OptionsCustomizing := TreeList.OptionsCustomizing;
      OptionsView := TreeList.OptionsView;
      OptionsBehavior := TreeList.OptionsBehavior;
      OptionsSelection := TreeList.OptionsSelection;
      OptionsSelection.CellSelect := True;
      OptionsData.Editing := True; 
      Nodes.Assign(TreeList.Nodes);
      Images := TreeList.Images;
      StateImages := TreeList.StateImages;
      Preview := TreeList.Preview; 
    finally
      EndUpdate;
    end;
    cxTreeList1.OnChange := DoOnChangeTreeList;
    cxTreeList1.OnSelectionChanged := DoOnChangeTreeList;
  end;
end;

procedure TfrmItemsEditor.DoOnChangeTreeList(Sender: TObject);

  procedure SetValues(const I1, I2, I3: string);
  begin
    edtImage.Text := I1;
    edtSelected.Text := I2;
    edtState.Text := I3;
  end;

begin
  if cxTreeList1.FocusedNode <> nil then
    with cxTreeList1.FocusedNode do
      SetValues(IntToStr(ImageIndex), IntToStr(SelectedIndex), IntToStr(StateIndex))
  else
    SetValues(edtDefImage.Text, edtDefSelected.Text, edtDefState.Text);
end;

procedure TfrmItemsEditor.DoSetImageIndex(Sender: TcxTextEdit);
var
  AIndex: Integer;
  I: Integer;
  AList: TList;
  ANode: TcxTreeListNode;
  AType: TcxTreeListImageIndexType;
begin
  AIndex := GetValue(Sender);
  AType := TcxTreeListImageIndexType(Sender.Tag);
  cxTreeList1.BeginUpdate;
  try
    AList := TList.Create;
    try
      ANode := cxTreeList1.GetSelections(AList);
      for I := 0 to AList.Count - 1 do
        TcxTLAccess(cxTreeList1).DoSetNodeImageIndex(
           TcxTreeListNode(AList.List^[I]), AType, AIndex);
      TcxTLAccess(cxTreeList1).DoSetNodeImageIndex(ANode, AType, AIndex);
    finally
      AList.Free;
    end;
  finally
    cxTreeList1.EndUpdate;
  end;
end;

function TfrmItemsEditor.GetValue(Sender: TcxTextEdit): Integer;
var
  ACode: Integer;
begin
  Val(Sender.Text, Result, ACode);
  if ACode <> 0 then Result := -1;
  Sender.Text := IntToStr(Result);
end;

procedure TfrmItemsEditor.ComponentRemoved(Sender: TObject);
begin
end;

procedure TfrmItemsEditor.Modified;
begin

end;

procedure TfrmItemsEditor.AssignDataToTreeList;
var
  I: Integer;
begin
  TreeList.BeginUpdate;
  try
    TreeList.Nodes.Clear;
    for I := 0 to cxTreeList1.Bands.Count - 1 do
      TreeList.Bands[I] := cxTreeList1.Bands[I];
    for I := 0 to cxTreeList1.ColumnCount - 1 do
      TreeList.Columns[I] := cxTreeList1.Columns[I];
    TreeList.Nodes := cxTreeList1.Nodes;
  finally
    TreeList.EndUpdate;
    TreeList.Modified; 
  end;
end;

function TfrmItemsEditor.GetTreeList: TcxTreeListAccess;
begin
  Result := TcxTreeListAccess(Control);
end;

procedure TfrmItemsEditor.cxButtonPress(Sender: TObject);

  procedure CheckAdd(ANode: TcxTreeListNode);
  begin
    if ANode <> nil then
    begin
      cxTreeList1.BeginUpdate;
      try
        ANode.ImageIndex := GetValue(edtDefImage);
        ANode.SelectedIndex := GetValue(edtDefSelected);
        ANode.StateIndex := GetValue(edtDefState);
        ANode.MakeVisible;
        ANode.Focused := True;
      finally
        cxTreeList1.EndUpdate; 
      end;
    end;
  end;

var
  ATag: Integer;
  AParentNode, ANode: TcxTreeListNode;

begin
  ATag := (Sender as TComponent).Tag;
  ANode := cxTreeList1.FocusedNode;
  if ANode <> nil then
    AParentNode := ANode.Parent
  else
    AParentNode := nil;
  case ATag of
    0:
      cxTreeList1.Customizing.Visible := True;
    1:
    begin
      AssignDataToTreeList;
      Close;
    end; 
    2:
      Close;
    3:;
    4:
      if AParentNode = nil then
        CheckAdd(cxTreeList1.Add)
      else
        CheckAdd(AParentNode.AddChild);
    5:
      if ANode = nil then
        CheckAdd(cxTreeList1.Add)
      else
        CheckAdd(ANode.AddChild);
    6:
    begin
      if ANode <> nil then
      begin
        if ANode.GetPrev <> nil then
          ANode := ANode.GetPrev
        else
          ANode := ANode.GetNext;
      end;
      TcxTreeListAccess(cxTreeList1).DoDeleteSelection;
      if ANode <> nil then ANode.Focused := True;
    end; 
  end;
end;

procedure TfrmItemsEditor.edtImageExit(Sender: TObject);
begin
  DoSetImageIndex(Sender as TcxTextEdit);
end;

procedure TfrmItemsEditor.edtImageKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    DoSetImageIndex(Sender as TcxTextEdit);
end;

procedure TfrmItemsEditor.cxTreeList1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := cxTreeList1.HitTest.HitAtNode;
end;

end.
