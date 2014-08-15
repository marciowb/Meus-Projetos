{***********************************************************************}
{ TMS Security System                                                   }
{ for Delphi & C++Builder                                               }
{                                                                       }
{ written by                                                            }
{   TMS Software                                                        }
{   Copyright © 2003 - 2009                                             }
{   Email : info@tmssoftware.com                                        }
{   Web : http://www.tmssoftware.com                                    }
{***********************************************************************}
unit uFormPolicyDesigner;

interface

{$I TMSDEFS.INC}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ToolWin, uFormPolicy, ExtCtrls, Menus,
  TypInfo, Buttons, WinTypes, ImgList;

const
  LabelImage = 1;
  EditImage = 2;
  ButtonImage = 3;
  CheckImage = 4;
  RadioImage = 5;
  MenuImage = 6;
  ListBoxImage = 7;
  MemoImage = 8;
  Unknown = 9;

type
  TfrmFormPolicy = class(TForm)
    ToolBar1: TToolBar;
    btnAddItem: TToolButton;
    btnRemoveItem: TToolButton;
    ilToolbar: TImageList;
    ilPolicies: TImageList;
    PopupMenu1: TPopupMenu;
    Hide1: TMenuItem;
    Disable1: TMenuItem;
    N1: TMenuItem;
    Delete1: TMenuItem;
    Panel1: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    tvPolicies: TTreeView;
    Splitter1: TSplitter;
    Panel3: TPanel;
    tvComponents: TTreeView;
    Panel4: TPanel;
    btnCancel: TBitBtn;
    btnOK: TBitBtn;
    Label2: TLabel;
    Label3: TLabel;
    Panel5: TPanel;
    btnAdd: TSpeedButton;
    ilComponents: TImageList;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    Customaction1: TMenuItem;
    ToolButton7: TToolButton;
    Readonly1: TMenuItem;
    N2: TMenuItem;
    Expandall1: TMenuItem;
    Collapsall1: TMenuItem;
    PopupMenu2: TPopupMenu;
    Expandall2: TMenuItem;
    Collapsall2: TMenuItem;
    procedure btnAddItemClick(Sender: TObject);
    procedure Hide1Click(Sender: TObject);
    procedure Disable1Click(Sender: TObject);
    procedure btnRemoveItemClick(Sender: TObject);
    procedure tvPoliciesDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure tvPoliciesDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Splitter1Moved(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tvPoliciesEditing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
    procedure ToolButton4Click(Sender: TObject);
    procedure tvPoliciesChange(Sender: TObject; Node: TTreeNode);
    procedure ToolButton7Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Expandall1Click(Sender: TObject);
    procedure Collapsall1Click(Sender: TObject);
    procedure Expandall2Click(Sender: TObject);
    procedure Collapsall2Click(Sender: TObject);
  private
    FUILFormPolicy: TUilFormPolicy;
    FFormName: string;
  public
    property FormPolicy: TUilFormPolicy read FUilFormPolicy write FUilFormPolicy;
    property FormName: string read FFormName write FFormName;
  end;


implementation


{$R *.DFM}

procedure TfrmFormPolicy.btnAddItemClick(Sender: TObject);
var
  PolicyName: string;
  Node: TTreeNode;
begin
  PolicyName := 'NewPolicyName';
  if InputQuery('New Policy', 'Enter policy name:', PolicyName) then
  begin
    Node := tvPolicies.Items.Add(nil, PolicyName);
    Node.ImageIndex := 0;
    Node.SelectedIndex := 0;
  end;
end;

procedure TfrmFormPolicy.Disable1Click(Sender: TObject);
begin
  if Assigned(tvPolicies.Selected) then
    if not Assigned(tvPolicies.Selected.Parent) then
    begin
      tvPolicies.Selected.ImageIndex := 0;
      tvPolicies.Selected.SelectedIndex := 0;
      tvPolicies.Refresh;
    end;
end;

procedure TfrmFormPolicy.Expandall1Click(Sender: TObject);
begin
  tvPolicies.FullExpand;
end;

procedure TfrmFormPolicy.Expandall2Click(Sender: TObject);
begin
  tvComponents.FullExpand;
end;

procedure TfrmFormPolicy.Hide1Click(Sender: TObject);
begin
  if Assigned(tvPolicies.Selected) then
    if not Assigned(tvPolicies.Selected.Parent) then
    begin
      tvPolicies.Selected.ImageIndex := 1;
      tvPolicies.Selected.SelectedIndex := 1;
      tvPolicies.Refresh;
    end;
end;

procedure TfrmFormPolicy.btnRemoveItemClick(Sender: TObject);
var
  AreYouSure: boolean;
begin
  AreYouSure := True;
  if Assigned(tvPolicies.Selected) then
  begin
    if not Assigned(tvPolicies.Selected.Parent) then
      AreYouSure := MessageDlg('Are you sure you want to delete this Policy?', mtConfirmation, [mbYes, mbNo], 0) = idYes;

    if Assigned(tvPolicies.Selected) and AreYouSure then
    begin
      if not Assigned(tvPolicies.Selected.Parent) Then
      begin
        if Assigned(FormPolicy) then
          FormPolicy.RemoveFromDataBase(FormName, tvPolicies.Selected.Text);
      end;
      tvPolicies.Selected.Delete;
    end;
  end;
end;

procedure TfrmFormPolicy.Collapsall1Click(Sender: TObject);
begin
  tvPolicies.FullCollapse;
end;

procedure TfrmFormPolicy.Collapsall2Click(Sender: TObject);
begin
  tvComponents.FullCollapse;
end;

procedure TfrmFormPolicy.tvPoliciesDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  SourceTree: TTreeView;
  Node: TTreeNode;
begin
  Accept := false;
  SourceTree := (Source as TTreeView);
  if SourceTree = nil then Exit;

  Node := tvPolicies.GetNodeAt(X, Y);
  Accept := (Source = tvComponents) and (Node <> nil) and Assigned(SourceTree.Selected.Parent);
end;

procedure TfrmFormPolicy.tvPoliciesDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  SourceTree: TTreeView;
  CheckNode,
    Node: TTreeNode;
begin
  SourceTree := (Source as TTreeView);

  if (X + Y) > 0 then
    Node := tvPolicies.GetNodeAt(X, Y)
  else
    Node := tvPolicies.Selected;

  if Node = nil then Exit;
  while (Node.Parent <> nil) do
    Node := Node.Parent;

   // Check to see if the item is already in the list
  CheckNode := Node.GetFirstChild;
  while Assigned(CheckNode) do
  begin
    if (CheckNode.Text = SourceTree.Selected.Text) then Exit;
    CheckNode := CheckNode.GetNextSibling;
  end; // while

  Node := tvPolicies.Items.AddChild(Node, SourceTree.Selected.Text);
  if Node <> nil then
  begin
    Node.ImageIndex := 4;
    Node.SelectedIndex := 4;
  end;

  tvPolicies.FullExpand;
end;

procedure TfrmFormPolicy.Splitter1Moved(Sender: TObject);
begin
  tvComponents.Refresh;
end;

procedure TfrmFormPolicy.btnAddClick(Sender: TObject);
begin
  tvPoliciesDragDrop(tvPolicies, tvComponents, 0, 0);
end;

procedure TfrmFormPolicy.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) then
    case Key of
      ord('A'): begin
          btnAddClick(nil);
          Key := 0;
        end;
      ord('P'): begin
          btnAddItemClick(nil);
          Key := 0;
        end;
      vk_Delete: begin
          btnRemoveItemClick(nil);
          Key := 0;
        end;
    end;
end;

procedure TfrmFormPolicy.tvPoliciesEditing(Sender: TObject;
  Node: TTreeNode; var AllowEdit: Boolean);
begin
  AllowEdit := false;
end;

procedure TfrmFormPolicy.ToolButton4Click(Sender: TObject);
begin
  if Assigned(tvPolicies.Selected) then
    if not Assigned(tvPolicies.Selected.Parent) then
    begin
      tvPolicies.Selected.ImageIndex := 2;
      tvPolicies.Selected.SelectedIndex := 2;
      tvPolicies.Refresh;
    end;
end;

procedure TfrmFormPolicy.tvPoliciesChange(Sender: TObject;
  Node: TTreeNode);
begin
  while node.Level > 0 do
    node := node.Parent;

  case (node.ImageIndex) of
  0: toolbutton2.Down := true;
  1: toolbutton3.Down := true;
  2: toolbutton4.Down := true;
  3: toolbutton7.Down := true;
  end;

  toolbutton2.Enabled := Assigned(tvPolicies.Selected);
  toolbutton3.Enabled := Assigned(tvPolicies.Selected);
  toolbutton4.Enabled := Assigned(tvPolicies.Selected);
  toolbutton7.Enabled := Assigned(tvPolicies.Selected);

  Disable1.Visible := not Assigned(tvPolicies.Selected.Parent);
  Hide1.Visible := not Assigned(tvPolicies.Selected.Parent);
  Customaction1.Visible := not Assigned(tvPolicies.Selected.Parent);
  N1.Visible := not Assigned(tvPolicies.Selected.Parent);
  N2.Visible := not Assigned(tvPolicies.Selected.Parent);
  ReadOnly1.Visible := not Assigned(tvPolicies.Selected.Parent);
end;

procedure TfrmFormPolicy.ToolButton7Click(Sender: TObject);
begin
  if Assigned(tvPolicies.Selected) then
    if not Assigned(tvPolicies.Selected.Parent) then
    begin
      tvPolicies.Selected.ImageIndex := 3;
      tvPolicies.Selected.SelectedIndex := 3;
      tvPolicies.Refresh;
    end;
end;

procedure TfrmFormPolicy.FormCreate(Sender: TObject);
begin
  toolbutton2.Enabled := false;
  toolbutton3.Enabled := false;
  toolbutton4.Enabled := false;
  toolbutton7.Enabled := false;
end;

end.
