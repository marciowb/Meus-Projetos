unit uEnderecoPadrao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormPadrao, StdCtrls, Mask, EditPesquisa, DB, DBClient,
  pFIBClientDataSet, DBCtrls, LabelDBEdit;

type
  TfrmEnderecoPadrao = class(TfrmPadrao)
    GroupBox1: TGroupBox;
    edtCEP: TEditPesquisa;
    DataEndereco: TDataSource;
    LabelDBEdit1: TLabelDBEdit;
    LabelDBEdit2: TLabelDBEdit;
    LabelDBEdit3: TLabelDBEdit;
    LabelDBEdit4: TLabelDBEdit;
    LabelDBEdit5: TLabelDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure edtCEPRegAchado(ADataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEnderecoPadrao: TfrmEnderecoPadrao;

implementation

uses Comandos, MinhasClasses, uSQL;

{$R *.dfm}

procedure TfrmEnderecoPadrao.edtCEPRegAchado(ADataSet: TDataSet);
var
  Cds : TpFIBClientDataSet;
begin
  inherited;
  Try
    Cds := TpFIBClientDataSet.Create(Self);
    SetCds(Cds, GetSelect(tpAluguelCEP, 'IDCEP = '+VarToStr(edtCEP.ValorChave)));
    (DataEndereco.DataSet as TpFIBClientDataSet).FieldByName('BAIRRO').AsString := Cds.FieldByName('BAIRRO').AsString;
    (DataEndereco.DataSet as TpFIBClientDataSet).FieldByName('CIDADE').AsString := Cds.FieldByName('CIDADE').AsString;
    (DataEndereco.DataSet as TpFIBClientDataSet).FieldByName('UF').AsString := Cds.FieldByName('UF').AsString;
  Finally
    FreeAndNil(Cds);
  End;
end;

procedure TfrmEnderecoPadrao.FormCreate(Sender: TObject);
begin
  inherited;
  FormataMascara(edtCEP, tcCEP);
  ConfiguraEditPesquisa(edtCEP, (DataEndereco.DataSet as TpFIBClientDataSet), 'LOGRADOURO', 'CEP', tpAluguelCEP, 'CEP', '', 8);
end;

end.
