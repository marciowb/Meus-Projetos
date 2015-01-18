unit uDlg_CancelamentoDocumento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Dlg_Cadastro, StdCtrls, ExtCtrls, Buttons;

type
  TfrmDlg_CancelamentoDocumento = class(TfrmDlg_Cadastro)
    grpMotivoCancelamento: TRadioGroup;
    GroupBox1: TGroupBox;
    mmDealhes: TMemo;
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDlg_CancelamentoDocumento: TfrmDlg_CancelamentoDocumento;

implementation

uses Comandos;

{$R *.dfm}

procedure TfrmDlg_CancelamentoDocumento.btnOkClick(Sender: TObject);
begin
  if grpMotivoCancelamento.ItemIndex = -1 then
  begin
    Avisa('Informe o motivo do cancelamento');
    Exit;
  end;
  if Trim(mmDealhes.Text) = '' then
  begin
    Avisa('Informe os detalhes do cancelamento');
    mmDealhes.SetFocus;
    Exit;
  end;

  inherited;

end;

end.
