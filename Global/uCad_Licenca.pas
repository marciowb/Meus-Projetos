unit uCad_Licenca;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormPadrao, StdCtrls, ExtCtrls, Buttons;

type
  TfrmCad_Licenca = class(TfrmPadrao)
    edtCodComputador: TLabeledEdit;
    edtSerial: TLabeledEdit;
    edtKey: TLabeledEdit;
    btnOk: TBitBtn;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCad_Licenca: TfrmCad_Licenca;

implementation

uses uLibLicenca, Comandos;

{$R *.dfm}

procedure TfrmCad_Licenca.BitBtn1Click(Sender: TObject);
begin
  inherited;
  Application.Terminate;
end;

procedure TfrmCad_Licenca.btnOkClick(Sender: TObject);
begin
  inherited;
  if not ChaveValida(edtKey.Text, edtSerial.Text) then
  Begin
    Avisa('Chave inválida');
    edtKey.SetFocus;
    Abort;
  End else
  Begin
    if Licenciar(edtKey.Text) Then
      ModalResult := mrOk;
  End;
end;

procedure TfrmCad_Licenca.FormCreate(Sender: TObject);
begin
  inherited;
  edtCodComputador.Text := GerarCodigoComputador;

end;

end.
