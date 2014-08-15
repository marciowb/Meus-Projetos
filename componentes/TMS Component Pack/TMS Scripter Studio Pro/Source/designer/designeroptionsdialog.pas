(*  GREATIS RUNTIME FUSION COMPLETE DEMO      *)
(*  Copyright (C) 2003-2004 Greatis Software  *)
(*  http://www.greatis.com/runtime.htm        *)
(*  b-team@greatis.com                        *)

unit DesignerOptionsDialog;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, FormDesigner;

type
  TfrmDesignerOptions = class(TForm)
    lblGridStep: TLabel;
    lblDesignerColor: TLabel;
    lblGridColor: TLabel;
    chbDisplayGrid: TCheckBox;
    chbSnapToGrid: TCheckBox;
    edtGridStep: TEdit;
    udnGridStep: TUpDown;
    pnlDesignerColor: TPanel;
    btnDesignerColor: TButton;
    pnlGridColor: TPanel;
    btnGridColor: TButton;
    btnOk: TButton;
    btnCancel: TButton;
    cldMain: TColorDialog;
    grbNormalGrabs: TGroupBox;
    pnlNBorder: TPanel;
    btnNBorder: TButton;
    lblNBorder: TLabel;
    pnlNFill: TPanel;
    btnNFill: TButton;
    lblNFill: TLabel;
    grbLockedGrabs: TGroupBox;
    lblLBorder: TLabel;
    lblLFill: TLabel;
    pnlLBorder: TPanel;
    btnLBorder: TButton;
    pnlLFill: TPanel;
    btnLFill: TButton;
    lblGrabSize: TLabel;
    edtGrabSize: TEdit;
    udnGrabSize: TUpDown;
    chbShowHint: TCheckBox;
    chbShowComponentHint: TCheckBox;
    chbShowNonVisual: TCheckBox;
    procedure btnDesignerColorClick(Sender: TObject);
    procedure btnGridColorClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnNBorderClick(Sender: TObject);
    procedure btnNFillClick(Sender: TObject);
    procedure btnLBorderClick(Sender: TObject);
    procedure btnLFillClick(Sender: TObject);
  private
    FDesigner: TAdvCustomFormDesigner;
    procedure SetDesigner(const Value: TAdvCustomFormDesigner);
    procedure DesignerToControls;
    { Private declarations }
  public
    { Public declarations }
    property Designer: TAdvCustomFormDesigner read FDesigner write SetDesigner;
  end;

implementation

{$R *.DFM}

procedure TfrmDesignerOptions.DesignerToControls;
begin
  if FDesigner <> nil then with FDesigner do
  begin
    if DesignerColor <> clNone then
      pnlDesignerColor.Color := DesignerColor
    else
      pnlDesignerColor.Color := clBtnFace;
    if GridColor <> clNone then
      pnlGridColor.Color := GridColor
    else
      pnlGridColor.Color := Font.Color;
    pnlNBorder.Color := NormalGrabBorder;
    pnlNFill.Color := NormalGrabFill;
    pnlLBorder.Color := LockedGrabBorder;
    pnlLFill.Color := LockedGrabFill;
    udnGridStep.Position := GridStep;
    chbDisplayGrid.Checked := DisplayGrid;
    chbSnapToGrid.Checked := SnapToGrid;
    udnGrabSize.Position := GrabSize;
    chbShowHint.Checked := ShowMoveSizeHint;
    chbShowComponentHint.Checked := ShowComponentHint;
    chbShowNonVisual.Checked := ShowNonVisual;
  end;
end;

procedure TfrmDesignerOptions.btnDesignerColorClick(Sender: TObject);
begin
  with cldMain do
  begin
    if FDesigner <> nil then
      Color := FDesigner.DesignerColor;
    if Execute then pnlDesignerColor.Color := Color;
  end;
end;

procedure TfrmDesignerOptions.btnGridColorClick(Sender: TObject);
begin
  with cldMain do
  begin
    if FDesigner <> nil then
      Color := FDesigner.GridColor;
    if Execute then pnlGridColor.Color:=Color;
  end;
end;

procedure TfrmDesignerOptions.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult = mrOk then
    if FDesigner <> nil then with FDesigner do
    begin
      DisplayGrid := chbDisplayGrid.Checked;
      SnapToGrid := chbSnapToGrid.Checked;
      GridStep := udnGridStep.Position;
      DesignerColor := pnlDesignerColor.Color;
      GridColor := pnlGridColor.Color;
      NormalGrabBorder := pnlNBorder.Color;
      NormalGrabFill := pnlNFill.Color;
      LockedGrabBorder := pnlLBorder.Color;
      LockedGrabFill := pnlLFill.Color;
      GrabSize := udnGrabSize.Position;
      ShowMoveSizeHint := chbShowHint.Checked;
      ShowComponentHint := chbShowComponentHint.Checked;
      ShowNonVisual := chbShowNonVisual.Checked;
    end;
end;

procedure TfrmDesignerOptions.FormShow(Sender: TObject);
begin
  btnDesignerColor.SetFocus;
end;

procedure TfrmDesignerOptions.btnNBorderClick(Sender: TObject);
begin
  with cldMain do
  begin
    if FDesigner <> nil then
      Color := FDesigner.NormalGrabBorder;
    if Execute then pnlNBorder.Color := Color;
  end;
end;

procedure TfrmDesignerOptions.btnNFillClick(Sender: TObject);
begin
  with cldMain do
  begin
    if FDesigner <> nil then
      Color := FDesigner.NormalGrabFill;
    if Execute then pnlNFill.Color := Color;
  end;
end;

procedure TfrmDesignerOptions.btnLBorderClick(Sender: TObject);
begin
  with cldMain do
  begin
    if FDesigner <> nil then
      Color := FDesigner.LockedGrabBorder;
    if Execute then pnlLBorder.Color := Color;
  end;
end;

procedure TfrmDesignerOptions.btnLFillClick(Sender: TObject);
begin
  with cldMain do
  begin
    if FDesigner <> nil then
      Color := FDesigner.LockedGrabFill;
    if Execute then pnlLFill.Color := Color;
  end;
end;


procedure TfrmDesignerOptions.SetDesigner(
  const Value: TAdvCustomFormDesigner);
begin
  FDesigner := Value;
  DesignerToControls;
end;

end.
