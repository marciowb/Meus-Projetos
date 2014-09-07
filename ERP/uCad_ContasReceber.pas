unit uCad_ContasReceber;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCad_CadastroPaiERP, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, ComCtrls, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinXmas2008Blue, dxSkinscxPCPainter, DB, DBClient,
  pFIBClientDataSet, ActnList, cxPC, cxContainer, cxEdit, cxTreeView, Buttons,
  ExtCtrls, DBCtrls, LabelDBEdit, StdCtrls, Mask, EditPesquisa, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxDBEdit, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, cxMemo;

type
  TfrmCad_ContasReceber = class(TfrmCad_CadastroPaiERP)
    Panel2: TPanel;
    edtData: TcxDBDateEdit;
    Label1: TLabel;
    edtEmpresa: TEditPesquisa;
    LabelDBEdit1: TLabelDBEdit;
    edtCliente: TEditPesquisa;
    edtVencimento: TcxDBDateEdit;
    Label2: TLabel;
    LabelDBEdit2: TLabelDBEdit;
    LabelDBEdit3: TLabelDBEdit;
    DBRadioGroup1: TDBRadioGroup;
    edtPlanoConta: TEditPesquisa;
    LabelDBEdit5: TLabelDBEdit;
    LabelDBEdit6: TLabelDBEdit;
    LabelDBEdit7: TLabelDBEdit;
    cxPageControl1: TcxPageControl;
    tsContasReceberRec: TcxTabSheet;
    TvRecebimento: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    tsDocumentos: TcxTabSheet;
    cxGrid2: TcxGrid;
    TVDocumento: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    Panel4: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    actIncluir: TAction;
    actEditarRecebimntos: TAction;
    actExcluirRecebimentos: TAction;
    DataRecebimentos: TDataSource;
    vRecebimentoColumn1: TcxGridDBColumn;
    vRecebimentoColumn2: TcxGridDBColumn;
    vRecebimentoColumn3: TcxGridDBColumn;
    vRecebimentoColumn4: TcxGridDBColumn;
    vRecebimentoColumn5: TcxGridDBColumn;
    vRecebimentoColumn6: TcxGridDBColumn;
    CdsRecebimentos: TpFIBClientDataSet;
    tsObs: TcxTabSheet;
    cxDBMemo1: TcxDBMemo;
    LabelDBEdit4: TLabelDBEdit;
    edtContaBancaria: TEditPesquisa;
    edtFormaPagamento: TEditPesquisa;
    procedure FormShow(Sender: TObject);
    procedure actIncluirExecute(Sender: TObject);
    procedure actEditarRecebimntosExecute(Sender: TObject);
    procedure actExcluirRecebimentosExecute(Sender: TObject);
    procedure actGravarExecute(Sender: TObject);
    procedure CdsCadastroAfterScroll(DataSet: TDataSet);
    procedure CdsRecebimentosNewRecord(DataSet: TDataSet);
    procedure CdsRecebimentosBeforePost(DataSet: TDataSet);
    procedure CdsCadastroAfterPost(DataSet: TDataSet);
    procedure cxDBMemo1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtFormaPagamentoRegAchado(
      const ValoresCamposEstra: array of Variant);
  private
    { Private declarations }
    TipoPagamento: String;
    Procedure CalculaTotais;

  public
    { Public declarations }
  end;

var
  frmCad_ContasReceber: TfrmCad_ContasReceber;

implementation

uses MinhasClasses, Comandos, UDmConexao, uLibERP,
  uDlg_RecebimentosContasReceber, uRegras, uConstantes;

{$R *.dfm}

procedure TfrmCad_ContasReceber.actEditarRecebimntosExecute(Sender: TObject);
begin
  inherited;
  Try
    frmDlg_RecebimentosContasReceber := TfrmDlg_RecebimentosContasReceber.Create(nil);
    frmDlg_RecebimentosContasReceber.pDataSet := CdsRecebimentos;
    frmDlg_RecebimentosContasReceber.DataSetMaster := CdsCadastro;
    frmDlg_RecebimentosContasReceber.FechaEGrava := True;
    frmDlg_RecebimentosContasReceber.pDataSet.Edit;
    frmDlg_RecebimentosContasReceber.ShowModal;
    CalculaTotais;
  Finally
    FreeAndNil(frmDlg_RecebimentosContasReceber);
  End;
end;

procedure TfrmCad_ContasReceber.actExcluirRecebimentosExecute(Sender: TObject);
begin
  inherited;
  if ConfirmaDel then
  begin
    CdsRecebimentos.Edit;
    CdsRecebimentos.FieldByName('FLAGEDICAO').AsString:= 'D';
    CdsRecebimentos.Post;
  end;
end;

procedure TfrmCad_ContasReceber.actGravarExecute(Sender: TObject);
begin
  if edtData.Date = 0 then
  begin
    Avisa('Informe a data da conta');
    edtData.SetFocus;
    Exit;
  end;
   if edtVencimento.Date = 0 then
  begin
    Avisa('Informe a data de vencimento');
    edtVencimento.SetFocus;
    Exit;
  end;
  CalculaTotais;

  if StrToIntDef(TipoPagamento,-1)= FormaPagamentoDinheiro then
  begin
    if (CdsCadastro.FieldByName('VALORPAGO').AsCurrency <
        CdsCadastro.FieldByName('VALOR').AsCurrency) then
    begin
       Avisa('Quando o recebimento é do tipo dinheiro, deve ser feito o lançamento do recebimento.');
       actIncluirExecute(nil);
       Exit;
    end;
  end;

  if (CdsCadastro.FieldByName('FLAGSTATUS').AsString = 'A') and
     (CdsCadastro.FieldByName('VALORPAGO').AsCurrency >=
       CdsCadastro.FieldByName('VALOR').AsCurrency) then
  begin
    if Pergunta('Não existe mais dívida nesse documento. Deseja finaliza-lo?') then
     CdsCadastro.FieldByName('FLAGSTATUS').AsString :='F';
  end;
  VerificaEdits := True;
  inherited;

end;

procedure TfrmCad_ContasReceber.actIncluirExecute(Sender: TObject);
begin
  inherited;
  if (CdsCadastro.FieldByName('FLAGSTATUS').AsString <> 'A') Then
  begin
    Avisa('Esse documento deve estar com o status de "aberta" para se incluído os pagamentos');
    Exit;
  end;
  Try
    frmDlg_RecebimentosContasReceber := TfrmDlg_RecebimentosContasReceber.Create(nil);
    frmDlg_RecebimentosContasReceber.pDataSet := CdsRecebimentos;
    frmDlg_RecebimentosContasReceber.FechaEGrava := True;
    frmDlg_RecebimentosContasReceber.pDataSet.Append;
    frmDlg_RecebimentosContasReceber.DataSetMaster := CdsCadastro;
    frmDlg_RecebimentosContasReceber.ShowModal;
    CalculaTotais;
  Finally
    FreeAndNil(frmDlg_RecebimentosContasReceber);
  End;
end;

procedure TfrmCad_ContasReceber.CalculaTotais;
var
  ValorTotal, JurosTotal,Desconto,Mora: Currency;
begin
  ValorTotal := 0;
  JurosTotal := 0;
  Desconto  := 0;
  Mora  := 0;
  CdsRecebimentos.First;
  while not CdsRecebimentos.Eof do
  begin
    ValorTotal := ValorTotal + CdsRecebimentos.FieldByName('VALORRECEBIDO').AsCurrency;
    JurosTotal := JurosTotal + CdsRecebimentos.FieldByName('VALORJUROS').AsCurrency;
    Desconto := Desconto + CdsRecebimentos.FieldByName('DESCONTOFINANCEIRO').AsCurrency;
    Mora := Mora + CdsRecebimentos.FieldByName('VALORMORA').AsCurrency;
    CdsRecebimentos.Next;
  end;

  CdsCadastro.FieldByName('VALORJUROSTOTAL').AsCurrency := JurosTotal;
  CdsCadastro.FieldByName('VALORMORA').AsCurrency := Mora;
  CdsCadastro.FieldByName('DESCONTOFINANCEIRO').AsCurrency := Desconto;
  CdsCadastro.FieldByName('VALORPAGO').AsCurrency := ValorTotal;
  CdsCadastro.FieldByName('VALORRESTANTE').AsCurrency := CdsCadastro.FieldByName('VALOR').AsCurrency  - ValorTotal;
end;

procedure TfrmCad_ContasReceber.CdsCadastroAfterPost(DataSet: TDataSet);
begin
  inherited;
  SetRegistros(CdsRecebimentos,tpERPContasReceberRecebimentos);
end;

procedure TfrmCad_ContasReceber.CdsCadastroAfterScroll(DataSet: TDataSet);
begin
  inherited;
  SetCds(CdsRecebimentos,tpERPContasReceberRecebimentos,'CR.IDCONTARECEBER = '+TipoCampoChaveToStr(ValorChave) );
end;

procedure TfrmCad_ContasReceber.CdsRecebimentosBeforePost(DataSet: TDataSet);
begin
  inherited;
  if CdsRecebimentos.FieldByName('FLAGEDICAO').AsString = 'N' then
     CdsRecebimentos.FieldByName('FLAGEDICAO').AsString:= 'E';

end;

procedure TfrmCad_ContasReceber.CdsRecebimentosNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsRecebimentos.FieldByName('IDCONTARECEBERRECIMENTOS').AsString := GetCodigo(tpERPContasReceberRecebimentos);
  CdsRecebimentos.FieldByName('IDCONTARECEBER').AsString := ValorChave;
  CdsRecebimentos.FieldByName('IDUSUARIO').AsString := USuarioLogado.Id;
  CdsRecebimentos.FieldByName('DATARECEBIDO').AsString := GetDataServidor;
  CdsRecebimentos.FieldByName('FLAGEDICAO').AsString := 'I';

end;

procedure TfrmCad_ContasReceber.cxDBMemo1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key= vk_return then
    Key := 0;
  inherited;
end;

procedure TfrmCad_ContasReceber.edtFormaPagamentoRegAchado(
  const ValoresCamposEstra: array of Variant);
begin
  inherited;
  if NovoReg then
  begin
    if not VarIsNull(ValoresCamposEstra[0]) then
    begin
      CdsCadastro.FieldByName('IDCONTABANCARIA').AsString :=  ValoresCamposEstra[0];
      edtContaBancaria.Localiza;
    end;
  end;
  TipoPagamento := ValoresCamposEstra[1];
end;

procedure TfrmCad_ContasReceber.FormShow(Sender: TObject);
begin
  inherited;
  edtPlanoConta.SQLComp := 'FLAGTIPO = ''A'' ';
  ConfiguraEditPesquisa(edtPlanoConta,CdsCadastro, tpERPPlanoContas);

  ConfiguraEditPesquisa(edtEmpresa,CdsCadastro, tpERPEmpresa, True);
  ConfiguraEditPesquisa(edtCliente,CdsCadastro, tpERPCliente,True);
  edtContaBancaria.AutoCompletar :=False;
  ConfiguraEditPesquisa(edtContaBancaria,CdsCadastro, tpERPContaBancaria);
  edtFormaPagamento.CamposExtraPesquisa := 'IDCONTABANCARIA,FLAGTIPOPAGAMENTO';
  ConfiguraEditPesquisa(edtFormaPagamento,CdsCadastro, tpERPCondicaoPagamento);

end;

end.
