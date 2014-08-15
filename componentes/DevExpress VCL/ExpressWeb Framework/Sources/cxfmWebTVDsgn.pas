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
unit cxfmWebTVDsgn;

{$I cxVer.inc}

interface

uses SysUtils, Classes, Variants,
  {$IFDEF VCL}
  Windows, Messages, Graphics, Controls, Forms, Dialogs, StdCtrls,
  ExtCtrls, ComCtrls,
  {$ELSE}
  Qt, Types, QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
  {$ENDIF}
  cxWebTV;

type
  TcxfmWebTreeViewEditor = class(TForm)
  private
    btnOK: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    gbProperties: TGroupBox;
    lbImgIndex: TLabel;
    lbHint: TLabel;
    lbName: TLabel;
    edImgIndex: TEdit;
    edHint: TEdit;
    edName: TEdit;
    btnAdd: TButton;
    btnAddChild: TButton;
    btnDelete: TButton;
    tvPreview: TTreeView;
    lbHref: TLabel;
    edHref: TEdit;
    lbTarget: TLabel;
    edTarget: TEdit;

    btnApply: TButton;

    FOriginalWebTV: TcxWebTreeView;
    FPrevNode: TTreeNode;
    FWebTV: TcxWebTreeView;

    procedure btnAddClick(Sender: TObject);
    procedure btnAddChildClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure tvPreviewChange(Sender: TObject; Node: TTreeNode);
    procedure btnDeleteClick(Sender: TObject);
    procedure tvPreviewEnter(Sender: TObject);
    procedure tvPreviewExpanded(Sender: TObject; Node: TTreeNode);
    procedure tvPreviewCollapsed(Sender: TObject; Node: TTreeNode);
    procedure tvPreviewEdited(Sender: TObject; Node: TTreeNode;
      var S: {$IFDEF VCL}string{$ELSE}WideString{$ENDIF});
    procedure btnOKClick(Sender: TObject);
    procedure edImgIndexKeyPress(Sender: TObject; var Key: Char);
    procedure btnApplyClick(Sender: TObject);

    function GetRegistryPath: string;
    {$IFDEF VCL}
    procedure DrawSizeGrip;
    function MouseInGripRect(const Pt: TPoint): Boolean;
    {$ENDIF}
    procedure HandleException;
    procedure ReadTreeViewItems;
    procedure RestoreLayout;
    procedure StoreLayout;

    {$IFDEF VCL}
    procedure WMNCHitTest(var message: TWMNCHitTest); message WM_NCHITTEST;
    {$ENDIF}
    property RegistryPath: string read GetRegistryPath;
  protected
    procedure CreateComponents;
    procedure Paint; override;
    procedure Resize; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean;
  end;

function ShowcxWebTreeViewEditor(AWebTreeView: TcxWebTreeView): Boolean;

implementation

uses
  Registry, TypInfo, ToolsAPI,
  cxWebDsgnConsts, cxWebDsgnStrs, cxWebDsgnUtils, cxWebClasses;

function ShowcxWebTreeViewEditor(AWebTreeView: TcxWebTreeView): Boolean;
var
  Form: TcxfmWebTreeViewEditor;
begin
  Form := TcxfmWebTreeViewEditor.Create(nil);
  try
    with Form do
    begin
      FOriginalWebTV := AWebTreeView;
      FWebTV.AssignItems(AWebTreeView);
      FWebTV.AutoSort := FOriginalWebTV.AutoSort;
      ReadTreeViewItems;
      tvPreview.Selected := tvPreview.TopItem;
      if FOriginalWebTV.AutoSort then tvPreview.SortType := stText;
      Caption := Format(scxTVDesigner, [AWebTreeView.Owner.Name, DotSep, AWebTreeView.Name]);
      Result := Execute;
      if Result then
        AWebTreeView.AssignItems(FWebTV);
      if FOriginalWebTV.AutoSort then FOriginalWebTV.Sort;        
    end;
  finally
    Form.Free;
  end;
end;

constructor TcxfmWebTreeViewEditor.Create(AOwner: TComponent);
begin
  inherited CreateNew(AOwner);
  CreateComponents;
  FWebTV := TcxWebTreeView.Create(nil);
  RestoreLayout;
end;

destructor TcxfmWebTreeViewEditor.Destroy;
begin
  StoreLayout;
  FWebTV.Free;
  inherited;
end;

function TcxfmWebTreeViewEditor.Execute: Boolean;
begin
  Result := ShowModal = mrOk;
end;

procedure TcxfmWebTreeViewEditor.CreateComponents;
  function CreateButton(ALeft, ATop, AWidth, AHeight: Integer; ACaption: string;
        AModuleResult: Integer; AAnchors: TAnchors): TButton;
  begin
    Result := TButton.Create(self);
    Result.Parent := self;
    Result.SetBounds(ALeft, ATop, AWidth, AHeight);
    Result.Caption := ACaption;
    Result.ModalResult := AModuleResult;
    Result.Anchors := AAnchors;
  end;
  function CreateEditor(ALeft, ATop, AWidth, AHeight: Integer;
        AAnchors: TAnchors): TEdit;
  begin
    Result := TEdit.Create(self);
    Result.Parent := gbProperties;
    Result.SetBounds(ALeft, ATop, AWidth, AHeight);
    Result.Anchors := AAnchors;
  end;
  function CreateLabel(ALeft, ATop, AWidth, AHeight: Integer; ACaption: string;
        AFocusControl: TWinControl): TLabel;
  begin
    Result := TLabel.Create(self);
    Result.Parent := gbProperties;
    Result.SetBounds(ALeft, ATop, AWidth, AHeight);
    Result.Caption := ACaption;
    Result.Transparent := True;
  end;

begin
  Left := 338;
  Top := 187;
  ActiveControl := btnAdd;
  AutoScroll := False;
  BorderIcons := [biSystemMenu];
  ClientHeight := 326;
  ClientWidth := 342;
  Color := clBtnFace;
  Constraints.MinHeight := 330;
  Constraints.MinWidth := 350;
  Font.Charset := DEFAULT_CHARSET;
  Font.Color := clWindowText;
  Font.Height := -11;
  Font.Name := 'MS Sans Serif';
  Font.Style := [];
  OnActivate := FormActivate;
  PixelsPerInch := 96;

  btnAdd := CreateButton(261, 11, 75, 23, cxWebCompEditorNewItem, 0, [akTop, akRight]);
  btnAdd.OnClick := btnAddClick;
  btnAddChild := CreateButton(261, 39, 75, 23, cxWebCompEditorNewSubItem, 0, [akTop, akRight]);
  btnAddChild.OnClick := btnAddChildClick;
  btnDelete := CreateButton(261, 67, 75, 23, cxWebCompEditorDelete, 0, [akTop, akRight]);
  btnDelete.OnClick := btnDeleteClick;

  gbProperties := TGroupBox.Create(Self);
  gbProperties.Parent := Self;
  gbProperties.SetBounds(6, 6, 249, 143);
  gbProperties.Anchors := [akLeft, akTop, akRight];
  gbProperties.Caption := ' ' + cxWebCompEditorItemProperties + ' ';

  edName := CreateEditor(72, 20, 166, 21, [akLeft, akTop, akRight]);
  edHint := CreateEditor(72, 43, 166, 21, [akLeft, akTop, akRight]);
  edHref := CreateEditor(72, 66, 166, 21, [akLeft, akTop, akRight]);
  edTarget := CreateEditor(72, 89, 166, 21, [akLeft, akTop, akRight]);
  edImgIndex := CreateEditor(72, 112, 44, 21, [akLeft, akTop, akRight]);
  edImgIndex.OnKeyPress := edImgIndexKeyPress;

  lbImgIndex := CreateLabel(8, 116, 61, 13, cxWebCompEditorItemImageIndex, edImgIndex);
  lbHint := CreateLabel(8, 47, 22, 13, cxWebCompEditorItemHint, edHint);
  lbName := CreateLabel(8, 24, 31, 13, cxWebCompEditorItemName, edName);
  lbHref := CreateLabel(8, 70, 25, 13, cxWebCompEditorItemHref, edHref);
  lbTarget := CreateLabel(8, 93, 25, 13, cxWebCompEditorItemTarget, edTarget);

  tvPreview := TTreeView.Create(Self);
  tvPreview.Parent := Self;
  tvPreview.SetBounds(5, 152, 330, 132);
  tvPreview.Anchors := [akLeft, akTop, akRight, akBottom];
  {$IFDEF VCL}
  tvPreview.HideSelection := False;
  {$ENDIF}
  tvPreview.Indent := 20;
  tvPreview.TabOrder := 4;
  tvPreview.OnChange := tvPreviewChange;
  tvPreview.OnCollapsed := tvPreviewCollapsed;
  tvPreview.OnEdited := tvPreviewEdited;
  tvPreview.OnEnter := tvPreviewEnter;
  tvPreview.OnExpanded := tvPreviewExpanded;

  btnOK := CreateButton(18, 293, 75, 23, scxWebDsgnButtonOKCaption, 1, [akRight, akBottom]);
  btnOK.OnClick := btnOKClick;
  btnCancel := CreateButton(97, 293, 75, 23, scxWebDsgnButtonCancelCaption, 2, [akRight, akBottom]);
  btnApply := CreateButton(176, 293, 75, 23, scxWebDsgnButtonApplyCaption, 0, [akRight, akBottom]);
  btnApply.OnClick := btnApplyClick;
  btnHelp := CreateButton(256, 293, 75, 23, scxWebDsgnButtonHelpCaption, 0, [akRight, akBottom]);
end;

procedure TcxfmWebTreeViewEditor.Paint;
begin
  inherited;
  {$IFDEF VCL}
  DrawSizeGrip;
  {$ENDIF}
end;

procedure TcxfmWebTreeViewEditor.Resize;
begin
  inherited;
  Invalidate;
end;

function TcxfmWebTreeViewEditor.GetRegistryPath: string;
var
  Services: IOTAServices50;
begin
  if Supports(BorlandIDEServices, IOTAServices50, Services) then
    Result :=
      Services.GetBaseRegistryKey + '\' + scxExpressWebObjectsFormLayoutsRegPath + '\' + DropT(ClassName)
  else
    Result := '';
end;

{$IFDEF VCL}
procedure TcxfmWebTreeViewEditor.DrawSizeGrip;
var
  V: Integer;
  R: TRect;
begin
  V := GetSystemMetrics(SM_CXVSCROLL);
  R := ClientRect;
  Canvas.Brush.Color := clBtnFace;
  Canvas.FillRect(R);
  R := Rect(R.Right - V, R.Bottom - V, R.Right, R.Bottom);
  DrawFrameControl(Canvas.Handle, R, DFC_SCROLL, DFCS_SCROLLSIZEGRIP);
end;
{$ENDIF}

procedure TcxfmWebTreeViewEditor.HandleException;
begin
  SysUtils.Abort;
end;

{$IFDEF VCL}
function TcxfmWebTreeViewEditor.MouseInGripRect(const Pt: TPoint): Boolean;
var
  GripSize: Integer;
  GripRect: TRect;
begin
  GripSize := GetSystemMetrics(SM_CXVSCROLL);
  GripRect :=
    Bounds(ClientWidth - GripSize, ClientHeight - GripSize, GripSize, GripSize);
  Result := PtInRect(GripRect, Pt);
end;
{$ENDIF}

procedure TcxfmWebTreeViewEditor.ReadTreeViewItems;

  procedure ReadItems(Node: TTreeNode; Item: TcxWebTreeItem);
  var
    NewNode: TTreeNode;
    I: Integer;
  begin
    NewNode := tvPreview.Items.AddChildObject(Node, Item.Text, Item);
    for I := 0 to Item.Count - 1 do
      ReadItems(NewNode, Item.Items[I]);
    NewNode.Expanded := Item.Expanded;
  end;

var
  I: Integer;
begin
  with tvPreview.Items do
  begin
    BeginUpdate;
    try
      Clear;
      for I := 0 to FWebTV.Items.Count - 1 do
        ReadItems(nil, FWebTV.Items[I]);
    finally
      EndUpdate;
    end;
  end;
end;

procedure TcxfmWebTreeViewEditor.RestoreLayout;
begin
  with TRegistry.Create do
  try
    try
      if OpenKey(RegistryPath, False) then
      begin
        if ValueExists(scxWidth) then
          Width := ReadInteger(scxWidth);
        if ValueExists(scxHeight) then
          Height := ReadInteger(scxHeight);
      end;
    except
      HandleException;
    end;
  finally
    Free;
  end;
end;

procedure TcxfmWebTreeViewEditor.StoreLayout;
begin
  with TRegistry.Create do
  try
    try
      if OpenKey(RegistryPath, True) then
      begin
        WriteInteger(scxWidth, Width);
        WriteInteger(scxHeight, Height);
      end;
    except
      HandleException;
    end;
  finally
    Free;
  end;
end;

{$IFDEF VCL}
procedure TcxfmWebTreeViewEditor.WMNCHitTest(var message: TWMNCHitTest);
begin
  inherited;
  if MouseInGripRect(ScreenToClient(SmallPointToPoint(message.Pos))) then
    message.Result := HTBOTTOMRIGHT
end;
{$ENDIF}

procedure TcxfmWebTreeViewEditor.btnAddClick(Sender: TObject);
var
  Node: TTreeNode;
  Item: TcxWebTreeItem;
begin
  Node := tvPreview.Selected;
  if Node <> nil then
    Item := TcxWebTreeItem(Node.Data).Parent.AddChild
  else
    Item := FWebTV.AddItem;
  tvPreview.Selected := tvPreview.Items.AddObject(Node, Item.Text, Item);
end;

procedure TcxfmWebTreeViewEditor.btnAddChildClick(Sender: TObject);
var
  Node: TTreeNode;
  Item: TcxWebTreeItem;
begin
  Node := tvPreview.Selected;
  Item := TcxWebTreeItem(Node.Data).AddChild;
  tvPreview.Selected := tvPreview.Items.AddChildObject(Node, Item.Text, Item);
end;

procedure TcxfmWebTreeViewEditor.btnDeleteClick(Sender: TObject);
begin
  TcxWebTreeItem(tvPreview.Selected.Data).Free;
  FPrevNode := nil;
  tvPreview.Selected.Delete;
  tvPreviewChange(Self, tvPreview.Selected);
end;

procedure TcxfmWebTreeViewEditor.tvPreviewEnter(Sender: TObject);
begin
  FPrevNode := tvPreview.Selected;
  tvPreviewChange(Self, tvPreview.Selected);
end;

procedure TcxfmWebTreeViewEditor.FormActivate(Sender: TObject);
begin
  tvPreviewChange(Self, tvPreview.Selected);
end;

procedure TcxfmWebTreeViewEditor.tvPreviewChange(Sender: TObject;
  Node: TTreeNode);
var
  Item: TcxWebTreeItem;
begin
  if FPrevNode <> nil then
  try
    Item := TcxWebTreeItem(FPrevNode.Data);
    Item.Name := edName.Text;
    Item.Hint := edHint.Text;
    Item.URL.Href := edHref.Text;
    Item.URL.Target := edTarget.Text;
    Item.ImageIndex := StrToInt(edImgIndex.Text);
  except
  end;
  if Node = nil then
  begin
    edName.Text := '';
    edHint.Text := '';
    edImgIndex.Text := '';
  end
  else
  begin
    Item := TcxWebTreeItem(Node.Data);
    edName.Text := Item.Name;
    edHint.Text := Item.Hint;
    edHref.Text := Item.URL.Href;
    edTarget.Text := Item.URL.Target;
    edImgIndex.Text := IntToStr(Item.ImageIndex);
  end;
  FPrevNode := Node;
  gbProperties.Enabled := FPrevNode <> nil;
  btnAddChild.Enabled := FPrevNode <> nil;
  btnDelete.Enabled := FPrevNode <> nil;
end;

procedure TcxfmWebTreeViewEditor.tvPreviewExpanded(Sender: TObject;
  Node: TTreeNode);
begin
  TcxWebTreeItem(Node.Data).Expanded := True;
end;

procedure TcxfmWebTreeViewEditor.tvPreviewCollapsed(Sender: TObject;
  Node: TTreeNode);
begin
  TcxWebTreeItem(Node.Data).Expanded := False;
end;

procedure TcxfmWebTreeViewEditor.tvPreviewEdited(Sender: TObject;
  Node: TTreeNode; var S: {$IFDEF VCL}string{$ELSE}WideString{$ENDIF});
begin
  TcxWebTreeItem(Node.Data).Text := S;
end;

procedure TcxfmWebTreeViewEditor.btnOKClick(Sender: TObject);
begin
  FPrevNode := tvPreview.Selected;
  tvPreviewChange(Self, nil);
end;

procedure TcxfmWebTreeViewEditor.edImgIndexKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in ['0'..'9', '-', Char({$IFDEF VCL}VK_BACK{$ELSE}Key_Backspace{$ENDIF})]) then
    Key := #0;
end;

procedure TcxfmWebTreeViewEditor.btnApplyClick(Sender: TObject);
begin
  FOriginalWebTV.AssignItems(FWebTV);
  if FOriginalWebTV.AutoSort then
    FOriginalWebTV.Sort;
end;

end.

