unit Dlg_Regiao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormPadrao_Pan, JvExControls, JvEnterTab, cxControls, cxContainer,
  cxEdit, cxGroupBox, cxRadioGroup, ExtCtrls, Buttons, cxTextEdit, cxMemo,
  cxDBEdit, cxLookAndFeelPainters;

type
  TfrmDlgRegiao = class(TfrmPadrao)
    grpOpcao: TcxRadioGroup;
    Panel1: TPanel;
    btnOk: TSpeedButton;
    btnSair: TSpeedButton;
    procedure FormActivate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDlgRegiao: TfrmDlgRegiao;

implementation

uses Comandos_Pan;

{$R *.dfm}

procedure TfrmDlgRegiao.btnOkClick(Sender: TObject);
begin
  inherited;
  if grpOpcao.ItemIndex < 0 then
  Begin
    AvisaErro('Informe o modelo.');
  End else
  Begin
    ModalResult := MrOk;
  End;
end;

procedure TfrmDlgRegiao.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmDlgRegiao.FormActivate(Sender: TObject);
begin
  inherited;
  Application.BringToFront;
  Self.Caption :=  Application.Title;

end;

end.
