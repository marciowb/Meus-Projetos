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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDlg_CancelamentoDocumento: TfrmDlg_CancelamentoDocumento;

implementation

{$R *.dfm}

end.
