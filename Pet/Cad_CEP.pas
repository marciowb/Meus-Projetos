unit Cad_CEP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Cad_CadastroPai, ComCtrls, DB, DBClient, ActnList, cxPC, cxControls,
  cxContainer, cxTreeView, Buttons, ExtCtrls, StdCtrls, Mask, DBCtrls,
  LabelDBEdit,  pFIBClientDataSet, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters;

type
  TfrmCad_CEP = class(TfrmCad_CadastroPai)
    edtCEP: TLabelDBEdit;
    LabelDBEdit2: TLabelDBEdit;
    LabelDBEdit3: TLabelDBEdit;
    LabelDBEdit4: TLabelDBEdit;
    Label1: TLabel;
    cmbUF: TDBComboBox;
    procedure FormCreate(Sender: TObject);
    procedure actGravarExecute(Sender: TObject);
    procedure CdsCadastroAfterOpen(DataSet: TDataSet);
    procedure actNovoExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCad_CEP: TfrmCad_CEP;

implementation

uses Comandos, MinhasClasses;



{$R *.dfm}

procedure TfrmCad_CEP.actGravarExecute(Sender: TObject);
begin
  VerificaEdits := True;
  if cmbUF.Text = '' then
  Begin
    Avisa('Informe a UF');
    cmbUF.SetFocus;
    Exit;
  End;
   Try
    StartTrans;
    inherited;
    Commit;
  Except
    on E: Exception do
    Begin
      RollBack;
      Raise;
    End;

  End;
end;

procedure TfrmCad_CEP.actNovoExecute(Sender: TObject);
begin
  inherited;
  edtCEP.SetFocus;
end;

procedure TfrmCad_CEP.CdsCadastroAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FormataMascara(CdsCadastro.FieldByName('cep'), tcCEP);
end;

procedure TfrmCad_CEP.FormCreate(Sender: TObject);
begin
  inherited;
  TipoPesquisa := tpImoCEP;

  
end;

end.
