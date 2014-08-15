unit Cad_ContaReceber;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Dlg_Cadastro, StdCtrls, Buttons, ExtCtrls, DB, Mask, DBCtrls,
  LabelDBEdit, EditPesquisa, Grids, DBGrids, DBClient, pFIBClientDataSet;

type
  TfrmCad_ContaReceber = class(TfrmDlg_Cadastro)
    DataCr: TDataSource;
    LabelDBEdit1: TLabelDBEdit;
    LabelDBEdit2: TLabelDBEdit;
    LabelDBEdit3: TLabelDBEdit;
    LabelDBEdit4: TLabelDBEdit;
    edtCliente: TEditPesquisa;
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    LabelDBEdit5: TLabelDBEdit;
    DataQuitacoes: TDataSource;
    CdsQuitacoes: TpFIBClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure CdsQuitacoesAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCad_ContaReceber: TfrmCad_ContaReceber;

implementation

uses Comandos, MinhasClasses;

{$R *.dfm}

procedure TfrmCad_ContaReceber.btnOkClick(Sender: TObject);
begin
  VerificaLabelDbEdit(Self,pDataSet);
  VerificaEdit(edtCliente,'Informe o cliente');
  inherited;

end;

procedure TfrmCad_ContaReceber.CdsQuitacoesAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FormataMascara(CdsQuitacoes.FieldByName('VALOR'),tcMoeda);
end;

procedure TfrmCad_ContaReceber.FormShow(Sender: TObject);
begin
  inherited;
  DataCr.DataSet := pDataSet;
  ConfiguraEditPesquisa(edtCliente,pDataSet, tpPetCliente);
  SetCds(CdsQuitacoes,tpPetContaReceberRec,'IDCONTARECEBER = '+pDataSet.FieldByName('IDCONTARECEBER').AsString);
end;

end.
