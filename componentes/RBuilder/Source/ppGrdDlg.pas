{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppGrdDlg;

interface

{$I ppIfDef.pas}

uses
  Windows,
  Classes,
  Graphics,
  Forms,
  Controls,
  StdCtrls,
  Buttons,
  ExtCtrls,
  SysUtils,
  Dialogs,
  
  ppForms,
  ppDesignerForms,
  ppTypes,
  ppUtils;

type
  TppGridDialog = class(TppCustomGridDialog)
    cbxDisplayGrid: TCheckBox;
    cbxSnapToGrid: TCheckBox;
    lblXGridSize: TLabel;
    lblYGridSize: TLabel;
    edtXGridSize: TEdit;
    edtYGridSize: TEdit;
    btnCancel: TButton;
    btnOK: TButton;
    procedure FormCreate(Sender: TObject);
    procedure lblYGridSizeClick(Sender: TObject);
    procedure lblXGridSizeClick(Sender: TObject);
    procedure edtXGridSizeChange(Sender: TObject);
    procedure edtYGridSizeChange(Sender: TObject);
    procedure cbxSnapToGridClick(Sender: TObject);
    procedure cbxDisplayGridClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure edtYGridSizeKeyPress(Sender: TObject; var Key: Char);
    procedure edtXGridSizeKeyPress(Sender: TObject; var Key: Char);

  private
    FValidEntry: Boolean;

    procedure SetSnapToGrid(Value: Boolean);
    procedure SetDisplayGrid(Value: Boolean);
    procedure SetXGridSpace(Value: Integer);
    procedure SetYGridSpace(Value: Integer);

    function CheckRange(aValue: Integer): Boolean;

  protected
    procedure Activate; override;
    procedure LanguageChanged; override;

  end;

var
  ppGridDialog: TppGridDialog;

implementation

{$R *.DFM}


{------------------------------------------------------------------------------}
{ TppGridDialog.FormCreate }

procedure TppGridDialog.FormCreate(Sender: TObject);
begin

  FValidEntry := True;

end;  {procedure, FormCreate}

{------------------------------------------------------------------------------}
{ TppGridDialog.Activate }

procedure TppGridDialog.Activate;
begin
  inherited Activate;

  cbxSnapToGrid.Checked  := SnapToGrid;
  cbxDisplayGrid.Checked := DisplayGrid;

  if not CheckRange(XGridSpace) then
    XGridSpace := 8;

  if not CheckRange(YGridSpace) then
    YGridSpace := 8;

  SetXGridSpace(XGridSpace);
  SetYGridSpace(YGridSpace);

end; {procedure, Activate}


{------------------------------------------------------------------------------}
{ TppGridDialog.btnOKClick }

procedure TppGridDialog.btnOKClick(Sender: TObject);
begin
  ExitActiveControl;
  
  if (FValidEntry) then
    ModalResult := mrOK;
end; {procedure, btnOKClick}


{------------------------------------------------------------------------------}
{ TppGridDialog.lblXGridSizeClick }

procedure TppGridDialog.lblXGridSizeClick(Sender: TObject);
begin
  edtXGridSize.SetFocus;
end; {procedure, lblXGridSizeClick}

{------------------------------------------------------------------------------}
{ TppGridDialog.lblYGridSizeClick }

procedure TppGridDialog.lblYGridSizeClick(Sender: TObject);
begin
  edtYGridSize.SetFocus;
end; {procedure, lblYGridSizeClick}

{------------------------------------------------------------------------------}
{ TppGridDialog.edtXGridSizeChange }

procedure TppGridDialog.edtXGridSizeChange(Sender: TObject);
begin
 if (ActiveControl = btnCancel) then Exit;
  try
    SetXGridSpace(StrToIntDef(edtXGridSize.Text, 0));
  except on EConvertError do
    WarningDlg(ppLoadStr(377));
  end;

end;  {procedure, edtXGridSizeChange}



{------------------------------------------------------------------------------}
{ TppGridDialog.edtXGridSizeKeyPress }

procedure TppGridDialog.edtXGridSizeKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = chEnterKey) then
    edtXGridSizeChange(Sender);
end;



{------------------------------------------------------------------------------}
{ TppGridDialog.edtYGridSizeChange }

procedure TppGridDialog.edtYGridSizeChange(Sender: TObject);
begin
  if (ActiveControl = btnCancel) then Exit;

  try
    SetYGridSpace(StrToIntDef(edtYGridSize.Text, 0));
  except on EConvertError do
    WarningDlg(ppLoadStr(377));
  end;


end;  {procedure, edtYGridSizeChange}

{------------------------------------------------------------------------------}
{ TppGridDialog.edtYGridSizeKeyPress }

procedure TppGridDialog.edtYGridSizeKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = chEnterKey) then
    edtYGridSizeChange(Sender);
end; {procedure, edtYGridSizeKeyPress}

{------------------------------------------------------------------------------}
{ TppGridDialog.SetSnapToGrid }

procedure TppGridDialog.SetSnapToGrid(Value: Boolean);
begin
  SnapToGrid := Value;

  cbxSnapToGrid.Checked := SnapToGrid;
end;  {procedure, SetSnapToGrid}

{------------------------------------------------------------------------------}
{ TppGridDialog.SetDisplayGrid }

procedure TppGridDialog.SetDisplayGrid(Value: Boolean);
begin
  DisplayGrid := Value;

  cbxDisplayGrid.Checked := DisplayGrid;
end; {procedure, SetDisplayGrid}

{------------------------------------------------------------------------------}
{ TppGridDialog.SetXGridSize }

procedure TppGridDialog.SetXGridSpace(Value: Integer);
begin

  FValidEntry := CheckRange(Value);

  if FValidEntry then
    begin
      XGridSpace := Value;
      edtXGridSize.Text := IntToStr(XGridSpace);

    end
  else
    begin
      MessageDlg(ppLoadStr(349), mtError, [mbOK], 0);
      ActiveControl := edtXGridSize;
    end;

 end; {procedure, SetXGridSpace}

{------------------------------------------------------------------------------}
{ TppGridDialog.SetYGridSize }

procedure TppGridDialog.SetYGridSpace(Value: Integer);
begin

  FValidEntry := CheckRange(Value);

  if FValidEntry then
    begin
      YGridSpace  := Value;
      edtYGridSize.Text := IntToStr(YGridSpace);

    end
  else
    begin
      MessageDlg(ppLoadStr(350), mtError, [mbOK], 0);
      ActiveControl := edtYGridSize;
    end;

end; {procedure, SetYGridSpace}

{------------------------------------------------------------------------------}
{ TppGridDialog.cbxSnapToGridClick }

procedure TppGridDialog.cbxSnapToGridClick(Sender: TObject);
begin
  SetSnapToGrid(cbxSnapToGrid.Checked);
end;

{------------------------------------------------------------------------------}
{ TppGridDialog.cbxDisplayGridClick }

procedure TppGridDialog.cbxDisplayGridClick(Sender: TObject);
begin
  SetDisplayGrid(cbxDisplayGrid.Checked);
end; {procedure, cbxDisplayGridClick}


{------------------------------------------------------------------------------}
{ TppGridDialog.CheckRange }

function TppGridDialog.CheckRange(aValue: Integer): Boolean;
begin
  Result := ((aValue >= 2) and (aValue <= 128));
end; {procedure, CheckRange}

{------------------------------------------------------------------------------}
{ TppGridDialog.LanguageChanged }

procedure TppGridDialog.LanguageChanged;
begin

  Caption := ppLoadStr(326); {'Grid Options'}

  cbxDisplayGrid.Caption := ppLoadStr(345); {'Display &Grid'}
  cbxSnapToGrid.Caption := ppLoadStr(346); {'Sna&p to Grid'}
  lblXGridSize.Caption := ppLoadStr(347); {'Grid Size &X'}
  lblYGridSize.Caption := ppLoadStr(348); {'Grid Size &Y'}

  btnOK.Caption := ppLoadStr(ppMsgOK);
  btnCancel.Caption := ppLoadStr(ppMsgCancel);

end; {procedure, LanguageChanged}

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  ppRegisterForm(TppCustomGridDialog, TppGridDialog);

finalization

  ppUnRegisterForm(TppCustomGridDialog);

end.

