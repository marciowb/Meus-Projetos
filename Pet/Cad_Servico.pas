unit Cad_Servico;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Cad_CadastroPai, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, ComCtrls, DB, DBClient, pFIBClientDataSet, ActnList,
  cxPC, cxContainer, cxTreeView, Buttons, ExtCtrls, StdCtrls, Mask, DBCtrls,
  LabelDBEdit, EditPesquisa, Grids, DBGrids, cxEdit;

type
  TfrmCad_Servico = class(TfrmCad_CadastroPai)
    GroupBox1: TGroupBox;
    DBMemo1: TDBMemo;
    Panel2: TPanel;
    LabelDBEdit1: TLabelDBEdit;
    LabelDBEdit4: TLabelDBEdit;
    LabelDBEdit2: TLabelDBEdit;
    LabelDBEdit3: TLabelDBEdit;
    edtCliente: TEditPesquisa;
    edtNomeCliente: TLabelDBEdit;
    LabelDBEdit5: TLabelDBEdit;
    LabelDBEdit6: TLabelDBEdit;
    LabelDBEdit7: TLabelDBEdit;
    LabelDBEdit8: TLabelDBEdit;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    cxTabSheet1: TcxTabSheet;
    GroupBox3: TGroupBox;
    DBGrid2: TDBGrid;
    CdsPagamentos: TpFIBClientDataSet;
    DataItens: TDataSource;
    CdsItens: TpFIBClientDataSet;
    DataPagamentos: TDataSource;
    Panel4: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    actAdd: TAction;
    actEditarItem: TAction;
    actDell: TAction;
    procedure CdsCadastroAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure CdsPagamentosAfterOpen(DataSet: TDataSet);
    procedure CdsItensAfterOpen(DataSet: TDataSet);
    procedure CdsCadastroAfterOpen(DataSet: TDataSet);
    procedure actEditarItemExecute(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure actDellExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCad_Servico: TfrmCad_Servico;

implementation

uses Comandos, MinhasClasses, uSQL, Cad_Item;

{$R *.dfm}

procedure TfrmCad_Servico.actAddExecute(Sender: TObject);
begin
  inherited;
  MudaEstado;
  frmCad_Itens := TfrmCad_Itens.Create(Self);
  Try
    frmCad_Itens.pDataSet := Self.CdsItens;
    frmCad_Itens.pDataSet.Append;
    frmCad_Itens.FechaEGrava := True;
    frmCad_Itens.ShowModal;
  Finally
    FreeAndNil(frmCad_Itens);
  End;
end;

procedure TfrmCad_Servico.actDellExecute(Sender: TObject);
begin
  inherited;
  if ConfirmaDel then
  Begin
    try
      StartTrans;
      Exec_SQL('DELETE FROM SERVICODETALHE '+
               ' WHERE IDSERVICODETALHE = '+CdsItens.FieldByName('IDSERVICODETALHE').AsString);
      Commit;
    except
      on E: Exception do
      Begin
        RollBack;
        Raise;
      End;
    end;
  End;

end;

procedure TfrmCad_Servico.actEditarItemExecute(Sender: TObject);
begin
  inherited;
  MudaEstado;
  frmCad_Itens := TfrmCad_Itens.Create(Self);
  Try
    frmCad_Itens.pDataSet := Self.CdsItens;
    frmCad_Itens.pDataSet.Edit;
    frmCad_Itens.FechaEGrava := True;
    frmCad_Itens.ShowModal;
  Finally
    FreeAndNil(frmCad_Itens);
  End;

end;

procedure TfrmCad_Servico.CdsCadastroAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FormataMascara(CdsCadastro.FieldByName('VALORTOTAL'), tcMoeda);
  FormataMascara(CdsCadastro.FieldByName('VALORACRESCIMO'), tcMoeda);
  FormataMascara(CdsCadastro.FieldByName('VALORDESCONTO'), tcMoeda);
  FormataMascara(CdsCadastro.FieldByName('VALORTOTALLIQUIDO'), tcMoeda);
  CdsCadastro.FieldByName('LOGIN').ProviderFlags := [];
end;

procedure TfrmCad_Servico.CdsCadastroAfterScroll(DataSet: TDataSet);
begin
  inherited;
  edtNomeCliente.Visible := CdsCadastro.FieldByName('IDCLIENTE').AsString = '';
  edtCliente.Visible := NOT edtNomeCliente.Visible;

  SetCds(CdsItens,tpPetServicoDetalhe,'IDSERVICO = '+ValorChave);
  SetCds(CdsPagamentos,GetSelect(tpPetServicoPagamentos,'1=1')+' AND S.IDSERVICO = '+ValorChave);

end;

procedure TfrmCad_Servico.CdsItensAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FormataMascara(CdsItens.FieldByName('VALOR'), tcMoeda);
  FormataMascara(CdsItens.FieldByName('VALORORIGINAL'), tcMoeda);
  CdsItens.FieldByName('NOMETIPOSERVICO').ProviderFlags := [];
  CdsItens.FieldByName('NOMETIPOANIMAL').ProviderFlags := [];
  CdsItens.FieldByName('NOMEPROFISSIONAL').ProviderFlags := [];
end;

procedure TfrmCad_Servico.CdsPagamentosAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FormataMascara(CdsPagamentos.FieldByName('VALOR'), tcMoeda);
  CdsPagamentos.FieldByName('NOMEFORMAPAGAMENTO').ProviderFlags := [];
  CdsPagamentos.FieldByName('TIPOFORMAPAGAMENTO').ProviderFlags := [];
end;

procedure TfrmCad_Servico.FormShow(Sender: TObject);
begin
  inherited;
  ConfiguraEditPesquisa(edtCliente,CdsCadastro,tpPetCliente);
end;

end.
