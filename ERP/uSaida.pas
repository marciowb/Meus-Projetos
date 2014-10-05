unit uSaida;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormPadrao, StdCtrls, ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, DB, DBClient,
  pFIBClientDataSet, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxDBEdit, Mask, EditPesquisa, DBCtrls, LabelDBEdit, dxSkinscxPCPainter,
  Buttons, cxPC, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, ActnList,Math, cxSplitter,ulibERP;

type
  TfrmSaida = class(TfrmPadrao)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    GroupBox1: TGroupBox;
    CdsSaida: TpFIBClientDataSet;
    DataSaida: TDataSource;
    GroupBox2: TGroupBox;
    cxDBDateEdit1: TcxDBDateEdit;
    edtEmpresa: TEditPesquisa;
    edtOperacao: TEditPesquisa;
    Label1: TLabel;
    edtPessoa: TEditPesquisa;
    cxPageControl1: TcxPageControl;
    TvItens: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    DataItens: TDataSource;
    CdsItens: TpFIBClientDataSet;
    TvItensNUMITEM: TcxGridDBColumn;
    TvItensQUANTIDADE: TcxGridDBColumn;
    TvItensVALORUNITARIO: TcxGridDBColumn;
    TvItensALIQDESCONTO: TcxGridDBColumn;
    TvItensALIQACRESCIMO: TcxGridDBColumn;
    TvItensVALORDESCONTO: TcxGridDBColumn;
    TvItensVALORACRESCIMO: TcxGridDBColumn;
    TvItensALIQICMS: TcxGridDBColumn;
    TvItensVALORICMS: TcxGridDBColumn;
    TvItensALIQIPI: TcxGridDBColumn;
    TvItensVALORIPI: TcxGridDBColumn;
    TvItensALIQST: TcxGridDBColumn;
    TvItensVALORST: TcxGridDBColumn;
    TvItensALIQPIS: TcxGridDBColumn;
    TvItensALIQCOFINS: TcxGridDBColumn;
    TvItensVALORPIS: TcxGridDBColumn;
    TvItensVALORCOFINS: TcxGridDBColumn;
    TvItensALIQISS: TcxGridDBColumn;
    TvItensVALORISS: TcxGridDBColumn;
    TvItensCST: TcxGridDBColumn;
    TvItensCSOSN: TcxGridDBColumn;
    TvItensVALORTOTALPRODUTOS: TcxGridDBColumn;
    TvItensVALORTOTAL: TcxGridDBColumn;
    TvItensCODIGO_PRODUTO: TcxGridDBColumn;
    TvItensNOMEPRODUTO: TcxGridDBColumn;
    TvItensUNIDADE: TcxGridDBColumn;
    TvItensCFOP: TcxGridDBColumn;
    cxTabSheet3: TcxTabSheet;
    GroupPagamento: TGroupBox;
    TvPagamento: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    cxGrid2: TcxGrid;
    CdsCondicaoPagamento: TpFIBClientDataSet;
    DataCondicaoPagamento: TDataSource;
    TvPagamentoVALOR: TcxGridDBColumn;
    TvPagamentoNUMTOTALPARCELAS: TcxGridDBColumn;
    TvPagamentoNOMECONDICAOPAGAMENTO: TcxGridDBColumn;
    Panel5: TPanel;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    ActionList1: TActionList;
    actNovoPagamento: TAction;
    actEditarPagamento: TAction;
    actExcluirPagamento: TAction;
    actNovoItem: TAction;
    actEditarItem: TAction;
    actExcluirItem: TAction;
    Panel6: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    DataParcelamentos: TDataSource;
    CdsParcelamentos: TpFIBClientDataSet;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    GroupBox3: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    grpFrete: TDBRadioGroup;
    LabelDBEdit1: TLabelDBEdit;
    LabelDBEdit2: TLabelDBEdit;
    LabelDBEdit3: TLabelDBEdit;
    LabelDBEdit4: TLabelDBEdit;
    edtTransportadora: TEditPesquisa;
    LabelDBEdit5: TLabelDBEdit;
    cmbUF: TDBComboBox;
    cxDBDateEdit2: TcxDBDateEdit;
    LabelDBEdit6: TLabelDBEdit;
    GroupTotais: TGroupBox;
    LabelDBEdit16: TLabelDBEdit;
    LabelDBEdit12: TLabelDBEdit;
    edtAcresValor: TLabelDBEdit;
    edtDescValor: TLabelDBEdit;
    edtOutros: TLabelDBEdit;
    edtSeguro: TLabelDBEdit;
    edtFrete: TLabelDBEdit;
    LabelDBEdit7: TLabelDBEdit;
    LabelDBEdit8: TLabelDBEdit;
    LabelDBEdit9: TLabelDBEdit;
    LabelDBEdit10: TLabelDBEdit;
    LabelDBEdit11: TLabelDBEdit;
    LabelDBEdit17: TLabelDBEdit;
    LabelDBEdit19: TLabelDBEdit;
    LabelDBEdit18: TLabelDBEdit;
    LabelDBEdit22: TLabelDBEdit;
    LabelDBEdit24: TLabelDBEdit;
    GroupObs: TGroupBox;
    DBMemo1: TDBMemo;
    LabelDBEdit23: TLabelDBEdit;
    edtAcresAliq: TLabelDBEdit;
    edtDescAliq: TLabelDBEdit;
    cxSplitter1: TcxSplitter;
    cxGrid2Level2: TcxGridLevel;
    cxGrid2DBTableView1: TcxGridDBTableView;
    cxGrid2DBTableView1Column1: TcxGridDBColumn;
    cxGrid2DBTableView1Column2: TcxGridDBColumn;
    EdtAlmoxarifado: TEditPesquisa;
    edtFuncionario: TEditPesquisa;
    CdsSeriais: TpFIBClientDataSet;
    procedure actNovoPagamentoExecute(Sender: TObject);
    procedure actEditarPagamentoExecute(Sender: TObject);
    procedure actExcluirPagamentoExecute(Sender: TObject);
    procedure actNovoItemExecute(Sender: TObject);
    procedure actEditarItemExecute(Sender: TObject);
    procedure actExcluirItemExecute(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtOperacaoRegAchado(const ValoresCamposEstra: array of Variant);
    procedure edtEmpresaRegAchado(const ValoresCamposEstra: array of Variant);
    procedure CdsSaidaNewRecord(DataSet: TDataSet);
    procedure CdsItensNewRecord(DataSet: TDataSet);
    procedure edtFreteExit(Sender: TObject);
    procedure edtDescAliqExit(Sender: TObject);
    procedure edtAcresAliqExit(Sender: TObject);
    procedure edtDescValorExit(Sender: TObject);
    procedure edtAcresValorExit(Sender: TObject);
    procedure CdsParcelamentosNewRecord(DataSet: TDataSet);
    procedure CdsParcelamentosBeforePost(DataSet: TDataSet);
    procedure CdsCondicaoPagamentoAfterScroll(DataSet: TDataSet);
    procedure CdsCondicaoPagamentoNewRecord(DataSet: TDataSet);
    procedure grpFreteClick(Sender: TObject);
    procedure CdsItensAfterPost(DataSet: TDataSet);
    procedure btnGravarClick(Sender: TObject);
    procedure CdsSaidaAfterOpen(DataSet: TDataSet);
    procedure CdsItensAfterOpen(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CdsItensAfterScroll(DataSet: TDataSet);
    procedure CdsItensBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    UfEmpresa: String;
    FTipoMovimento: TTipoMovimento;
    TotalPagamentos: Currency;
    FIdOS: TipoCampoChave;
    GeraFinanceiro: Boolean;
    Procedure RestartaVenda;
    procedure CalculaTotalPagamentos;
    Procedure CalculaTotais(SemDesconAcrescimo: Boolean=False);
    procedure RateiaValores;
    procedure ImportaOS(idOS: TipoCampoChave);
    procedure SetIdOS(const Value: TipoCampoChave);
  public
    { Public declarations }
    Procedure AbreVenda(IdVenda: TipoCampoChave);
    property IdOS: TipoCampoChave read FIdOS write SetIdOS;
  end;

var
  frmSaida: TfrmSaida;

implementation

uses UDmConexao, Comandos, MinhasClasses, uDlg_SaidaItem, udlgCondicaoPagamento,
  uRegras,  uConfiguracaoOS;

{$R *.dfm}
procedure TfrmSaida.AbreVenda(IdVenda: TipoCampoChave);
begin
  SetCds(CdsSaida,tpERPSaida,'IDSAIDA = '+TipoCampoChaveToStr(IdVenda));
  SetCds(CdsItens,tpERPSaidaProduto,'Sp.IDSAIDA = '+TipoCampoChaveToStr(IdVenda));
  SetCds(CdsCondicaoPagamento,tpERPSaidaCondicaoPagamento,'SC.IDSAIDA = '+TipoCampoChaveToStr(IdVenda));
  SetCds(CdsParcelamentos,tpERPSaidaCondicaoPagamentoParcelas, ' EXISTS(SELECT 1 '+
                                                               '          FROM SAIDACONDICAOPAGAMENTO SC '+
                                                               '         WHERE SC.IDSAIDACONDICAOPAGAMENTO =PS.IDSAIDACONDICAOPAGAMENTO '+
                                                               '           AND SC.IDSAIDA = '+TipoCampoChaveToStr(IdVenda)+')');
  SetCds(CdsSeriais,tpERPSaidaSerialProduto,'EXISTS(SELECT 1 '+
                                            '         FROM SAIDAPRODUTO SP '+
                                            '        WHERE SP.IDSAIDAPRODUTO= SSP.IDSAIDAPRODUTO '+
                                            '          AND SP.IDSAIDA ='+TipoCampoChaveToStr(IdVenda)+') ');
  if IdVenda <> '-1' then
    CdsSaida.Edit;
end;

procedure TfrmSaida.actEditarItemExecute(Sender: TObject);
begin
  inherited;
  frmDlg_SaidaItem := TfrmDlg_SaidaItem.Create(nil);
  Try
    frmDlg_SaidaItem.pDataSet := CdsItens;
    frmDlg_SaidaItem.DataSetSeriais := CdsSeriais;
    frmDlg_SaidaItem.pDataSet.Edit;
    frmDlg_SaidaItem.FechaEGrava := True;
    frmDlg_SaidaItem.TipoMovimento := FTipoMovimento;
    frmDlg_SaidaItem.ShowModal;
    CalculaTotais;
  Finally
    FreeAndNil(frmDlg_SaidaItem);
  End;
end;

procedure TfrmSaida.actEditarPagamentoExecute(Sender: TObject);
begin
  inherited;
   Try
    frmdlgCondicaoPagamento := TfrmdlgCondicaoPagamento.Create(nil);
    frmdlgCondicaoPagamento.pDataSet := Self.CdsCondicaoPagamento;
    frmdlgCondicaoPagamento.DataSetParcelas := Self.CdsParcelamentos;
    frmdlgCondicaoPagamento.FechaEGrava := True;
    frmdlgCondicaoPagamento.pDataSet.Edit;
    frmdlgCondicaoPagamento.ValorTotalPagamentos := Self.TotalPagamentos;
    frmdlgCondicaoPagamento.ValorTotal := CdsSaida.FieldByName('VALORTOTALNOTA').AsCurrency;
    frmdlgCondicaoPagamento.ShowModal;
    CalculaTotalPagamentos;
  Finally
    FreeAndNil(frmdlgCondicaoPagamento);
  End;
end;

procedure TfrmSaida.actExcluirItemExecute(Sender: TObject);
begin
  inherited;
  if ConfirmaDel then
  begin
    CdsItens.Edit;
    CdsItens.FieldByName('FLAGEDICAO').AsString := 'D';
    CdsItens.Post;
    TRegrasSaidaProduto.DesbloqueiaQuantidadeProduto(CdsItens.FieldByName('idsaida').Value,
                                                      edtEmpresa.ValorChave,
                                                      CdsItens.FieldByName('NUMITEM').Value);

    CalculaTotais;
  end;

end;

procedure TfrmSaida.actExcluirPagamentoExecute(Sender: TObject);
begin
  inherited;
  if ConfirmaDel then
  begin
    CdsCondicaoPagamento.Edit;
    CdsCondicaoPagamento.FieldByName('FLAGEDICAO').AsString := 'D';
    CdsCondicaoPagamento.Post;
  end;

end;

procedure TfrmSaida.actNovoItemExecute(Sender: TObject);
begin
  inherited;
  frmDlg_SaidaItem := TfrmDlg_SaidaItem.Create(nil);
  Try
    frmDlg_SaidaItem.pDataSet := CdsItens;
    frmDlg_SaidaItem.DataSetSeriais := CdsSeriais;
    frmDlg_SaidaItem.pDataSet.Append;
    frmDlg_SaidaItem.FechaEGrava := False;
    frmDlg_SaidaItem.TipoMovimento := FTipoMovimento;
    frmDlg_SaidaItem.ShowModal;
    CalculaTotais;
  Finally
    FreeAndNil(frmDlg_SaidaItem);
  End;
end;

procedure TfrmSaida.actNovoPagamentoExecute(Sender: TObject);
begin
  inherited;
  Try
    frmdlgCondicaoPagamento := TfrmdlgCondicaoPagamento.Create(nil);
    frmdlgCondicaoPagamento.pDataSet := Self.CdsCondicaoPagamento;
    frmdlgCondicaoPagamento.DataSetParcelas := Self.CdsParcelamentos;
    frmdlgCondicaoPagamento.FechaEGrava := False;
    frmdlgCondicaoPagamento.ValorTotalPagamentos := Self.TotalPagamentos;
    frmdlgCondicaoPagamento.ValorTotal := CdsSaida.FieldByName('VALORTOTALNOTA').AsCurrency;

    frmdlgCondicaoPagamento.pDataSet.Append;
    frmdlgCondicaoPagamento.ShowModal;
    CalculaTotalPagamentos;
  Finally
    FreeAndNil(frmdlgCondicaoPagamento);
  End;
end;

procedure TfrmSaida.btnCancelarClick(Sender: TObject);
begin
  inherited;
  RestartaVenda;
end;

procedure TfrmSaida.btnGravarClick(Sender: TObject);
begin
  inherited;
  if CdsItens.IsEmpty then
  begin
    avisa('Deve existir pelo menos 1 item');
    Exit;
  end;
  CalculaTotalPagamentos;

  if (GeraFinanceiro) and (TotalPagamentos <> CdsSaida.FieldByName('VALORTOTALNOTA').AsCurrency) then
  begin
    avisa('O total dos pagamentos difere do total da nota');
    Exit;
  end;
  if edtFuncionario.IsNull then
  begin
    avisa('O funcionario deve estar preenchido');
    edtFuncionario.SetFocus;
    Exit;
  end;
  if  TRegrasSaidaProduto.GravaSaida(CdsSaida, CdsItens,CdsCondicaoPagamento, CdsParcelamentos,CdsSeriais) Then
  begin
    Avisa('Saída gravada com sucesso');
    if idOs <> '' then
      Self.ModalResult := mrOK;
    RestartaVenda;
  end;
end;

procedure TfrmSaida.CalculaTotais(SemDesconAcrescimo: Boolean=False);
var
  BaseICMS,ICMS,BaseISS,ISS,BaseIPI,IPI,
  BaseST,ST,BasePISCOFINS,COFINS,PIS,
  TotalProduto, TotalNota, ValorDesconto,ValorAcrescimo: Currency;
begin
  Try
    CdsItens.DisableControls;
    BaseICMS := 0;
    ICMS := 0;
    BaseISS := 0;
    ISS := 0;
    BaseIPI := 0;
    IPI := 0;
    BaseST := 0;
    ST := 0;
    BasePISCOFINS := 0;
    COFINS := 0;
    PIS := 0;
    TotalProduto:= 0;
    TotalNota := 0;
    ValorDesconto := 0;
    ValorAcrescimo  := 0;

    CdsItens.First;
    while not CdsItens.Eof do
    begin
      BaseICMS := BaseICMS + CdsItens.FieldByName('BASEICMS').AsCurrency;
      ICMS := ICMS + CdsItens.FieldByName('VALORICMS').AsCurrency;
      BaseISS := BaseISS + CdsItens.FieldByName('BASEISS').AsCurrency;
      ISS := ISS + CdsItens.FieldByName('VALORISS').AsCurrency;
      BaseIPI := BaseIPI + CdsItens.FieldByName('BASEIPI').AsCurrency;
      IPI := IPI + CdsItens.FieldByName('VALORIPI').AsCurrency;
      BaseST := BaseST + CdsItens.FieldByName('BASEICMSST').AsCurrency;
      ST := ST + CdsItens.FieldByName('VALORST').AsCurrency;
      BasePISCOFINS := BasePISCOFINS + CdsItens.FieldByName('BASEPISCOFINS').AsCurrency;
      COFINS := COFINS + CdsItens.FieldByName('VALORCOFINS').AsCurrency;
      PIS := PIS + CdsItens.FieldByName('VALORPIS').AsCurrency;
      TotalProduto := TotalProduto+ CdsItens.FieldByName('SUBTOTAL').AsCurrency;
      if not SemDesconAcrescimo then
      begin
        ValorDesconto := ValorDesconto+ CdsItens.FieldByName('VALORDESCONTO').AsCurrency;
        ValorAcrescimo := ValorAcrescimo+ CdsItens.FieldByName('VALORACRESCIMO').AsCurrency;
      end;
      CdsItens.Next;
    end;
    CdsSaida.FieldByName('BASECALCULOICMS').AsCurrency :=BaseICMS;
    CdsSaida.FieldByName('VALORICMS').AsCurrency :=ICMS;

    CdsSaida.FieldByName('BASECALCULOIPI').AsCurrency :=BaseIPI;
    CdsSaida.FieldByName('VALORIPI').AsCurrency :=IPI;

    CdsSaida.FieldByName('BASECALCULOPISCOFINS').AsCurrency :=BasePISCOFINS;
    CdsSaida.FieldByName('VALORPIS').AsCurrency :=PIS;
    CdsSaida.FieldByName('VALORCOFINS').AsCurrency :=COFINS;

    CdsSaida.FieldByName('BASECALCULOICMSST').AsCurrency :=BaseST;
    CdsSaida.FieldByName('VALORST').AsCurrency :=ST;

    CdsSaida.FieldByName('BASECALCULOISS').AsCurrency :=BaseISS;
    CdsSaida.FieldByName('VALORISS').AsCurrency := ISS;

    CdsSaida.FieldByName('VALORTOTALPRODUTOS').AsCurrency := (TotalProduto-ValorDesconto)+ValorAcrescimo;

    CdsSaida.FieldByName('VALORDESCONTOTOTAL').AsCurrency := ValorDesconto;
    CdsSaida.FieldByName('VALORACRESCIMOTOTAL').AsCurrency := ValorAcrescimo;

    TotalNota :=
     TotalProduto+
       IPI+ST+CdsSaida.FieldByName('VALOROUTRASDESPESAS').AsCurrency+CdsSaida.FieldByName('VALORSEGURO').AsCurrency+
       ifThen(grpFrete.ItemIndex = 0,CdsSaida.FieldByName('VALORFRETE').AsCurrency);

    CdsSaida.FieldByName('ALIQDESCONTO').AsCurrency :=
          (CdsSaida.FieldByName('VALORDESCONTOTOTAL').AsCurrency  / TotalNota) * 100;

    CdsSaida.FieldByName('ALIQACRESCIMO').AsCurrency :=
          (CdsSaida.FieldByName('VALORACRESCIMOTOTAL').AsCurrency  / TotalNota) * 100;

    CdsSaida.FieldByName('VALORTOTALNOTA').AsCurrency := (TotalNota-ValorDesconto)+ValorAcrescimo;

    CdsItens.First;
  Finally

    CdsItens.EnableControls;
  End;
end;

procedure TfrmSaida.CalculaTotalPagamentos;
begin
  TotalPagamentos := 0;
  Try
    CdsCondicaoPagamento.AfterScroll := nil;
    CdsCondicaoPagamento.First;
    while not CdsCondicaoPagamento.Eof do
    begin
      TotalPagamentos :=  TotalPagamentos + CdsCondicaoPagamento.FieldByName('VALOR').AsCurrency;
      CdsCondicaoPagamento.Next;
    end;
  Finally
    CdsCondicaoPagamento.AfterScroll := CdsCondicaoPagamentoAfterScroll;
    CdsCondicaoPagamentoAfterScroll(CdsCondicaoPagamento);
  End;

end;

procedure TfrmSaida.CdsCondicaoPagamentoAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if CdsCondicaoPagamento.FieldByName('IDSAIDACONDICAOPAGAMENTO').AsString <>  '' then
    CdsParcelamentos.Filter := 'FLAGEDICAO<> ''D'' AND IDSAIDACONDICAOPAGAMENTO = '+ TipoCampoChaveToStr(CdsCondicaoPagamento.FieldByName('IDSAIDACONDICAOPAGAMENTO').AsString);
  CdsParcelamentos.Filtered := True;
end;

procedure TfrmSaida.CdsCondicaoPagamentoNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsCondicaoPagamento.FieldByName('IDSAIDACONDICAOPAGAMENTO').AsString := GetCodigo(tpERPSaidaCondicaoPagamento);
  CdsCondicaoPagamento.FieldByName('FLAGEDICAO').AsString := 'I';
  CdsCondicaoPagamento.FieldByName('IDSAIDA').Value := CdsSaida.FieldByName('IDSAIDA').Value ;
end;

procedure TfrmSaida.CdsItensAfterOpen(DataSet: TDataSet);
var
  I: Integer;
begin
  inherited;
  for I := 0 to DataSet.FieldCount - 1 do
  begin
    case DataSet.Fields[i].DataType of
      ftFloat, ftCurrency,ftBCD:
        FormataMascara(DataSet.Fields[i],tcReal);
    end;
    if UpperCase(Copy(DataSet.Fields[i].FieldName,1,4)) = 'ALIQ' then
      FormataMascara(DataSet.Fields[i],tcPercent);
  end;

end;

procedure TfrmSaida.CdsItensAfterPost(DataSet: TDataSet);
begin
  inherited;
  if ((CdsItens.FieldByName('flagedicao').AsString = 'I') or
      (CdsItens.FieldByName('flagedicao').AsString = 'E') ) and
      (FTipoMovimento = tmProduto) then
    TRegrasSaidaProduto.BloqueiaQuantidadeProduto(CdsItens.FieldByName('idsaida').AsString,
                                                  CdsItens.FieldByName('idproduto').AsString,
                                                  CdsSaida.FieldByName('idempresa').AsString ,
                                                  CdsItens.FieldByName('idcor').AsString,
                                                  CdsItens.FieldByName('idtamanho').AsString,
                                                  CdsItens.FieldByName('NUMITEM').AsString,
                                                  CdsItens.FieldByName('IDALMOXARIFADO').AsString,
                                                  CdsItens.FieldByName('quantidade').AsFloat);
end;

procedure TfrmSaida.CdsItensAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if CdsItens.FieldByName('IDSAIDAPRODUTO').AsString <> '' then
  begin
    CdsSeriais.Filter := 'FLAGEDICAO <> ''D'' AND IDSAIDAPRODUTO = '+TipoCampoChaveToStr( CdsItens.FieldByName('IDSAIDAPRODUTO').AsString);
  end;
  CdsSeriais.Filtered := True;
end;

procedure TfrmSaida.CdsItensBeforePost(DataSet: TDataSet);
begin
  inherited;
  if CdsItens.FieldByName('FLAGEDICAO').AsString = 'N' then
    CdsItens.FieldByName('FLAGEDICAO').AsString := 'E';
end;

procedure TfrmSaida.CdsItensNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsItens.FieldByName('IDSAIDA').AsString := CdsSaida.FieldByName('IDSAIDA').AsString ;
  CdsItens.FieldByName('NUMITEM').AsInteger := CdsItens.RecordCount +1;
  CdsItens.FieldByName('IDSAIDAPRODUTO').Value := GetCodigo(tpERPSaidaProduto);
  CdsItens.FieldByName('flagedicao').AsString := 'I';
  CdsItens.FieldByName('IDALMOXARIFADO').Value := EdtAlmoxarifado.ValorChave;
end;

procedure TfrmSaida.CdsParcelamentosBeforePost(DataSet: TDataSet);
begin
  inherited;
  if CdsParcelamentos.FieldByName('FLAGEDICAO').AsString = 'N' then
    CdsParcelamentos.FieldByName('FLAGEDICAO').AsString := 'E';
end;

procedure TfrmSaida.CdsParcelamentosNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsParcelamentos.FieldByName('IDPARSAIDACONDICAOPAGAMENTO').AsString := GetCodigo(tpERPSaidaCondicaoPagamentoParcelas);
  CdsParcelamentos.FieldByName('IDSAIDACONDICAOPAGAMENTO').AsString := CdsCondicaoPagamento.FieldByName('IDSAIDACONDICAOPAGAMENTO').AsString;
  CdsParcelamentos.FieldByName('FLAGEDICAO').AsString := 'I';
end;

procedure TfrmSaida.CdsSaidaAfterOpen(DataSet: TDataSet);
var
  I: Integer;
begin
  inherited;
  for I := 0 to DataSet.FieldCount - 1 do
  begin
    case DataSet.Fields[i].DataType of
      ftFloat, ftCurrency,ftBCD:
        FormataMascara(DataSet.Fields[i],tcReal);
    end;
    if UpperCase(Copy(DataSet.Fields[i].FieldName,1,4)) = 'ALIQ' then
      FormataMascara(DataSet.Fields[i],tcPercent);
  end;



end;

procedure TfrmSaida.CdsSaidaNewRecord(DataSet: TDataSet);
begin
  inherited;
  PreencheCamposValorPadraoBD(CdsSaida,tpERPSaida);
  CdsSaida.FieldByName('IDSAIDA').AsString := GetCodigo(tpERPSaida);
  CdsSaida.FieldByName('FLAGMODALIDADEFRETE').AsString := 'D';
end;

procedure TfrmSaida.edtAcresAliqExit(Sender: TObject);
begin
  inherited;
  RateiaValores;
end;

procedure TfrmSaida.edtAcresValorExit(Sender: TObject);
var
  ValorAcres: Currency;
begin
  inherited;
  if CdsSaida.FieldByName('VALORACRESCIMOTOTAL').AsCurrency = 0 then
  begin
    CdsSaida.FieldByName('ALIQACRESCIMO').AsCurrency := 0;
    Exit;
  end;
  ValorAcres :=  CdsSaida.FieldByName('VALORACRESCIMOTOTAL').AsCurrency ;
  CalculaTotais(True);
  CdsSaida.FieldByName('VALORACRESCIMOTOTAL').AsCurrency := ValorAcres;
  CdsSaida.FieldByName('ALIQACRESCIMO').AsCurrency := (CdsSaida.FieldByName('VALORACRESCIMOTOTAL').AsCurrency  / CdsSaida.FieldByName('VALORTOTALNOTA').AsCurrency) * 100;
  RateiaValores;

end;

procedure TfrmSaida.edtDescAliqExit(Sender: TObject);
begin
  inherited;
  RateiaValores;
end;

procedure TfrmSaida.edtDescValorExit(Sender: TObject);
var
  ValorDesc: Currency;
begin
  inherited;
  if CdsSaida.FieldByName('VALORDESCONTOTOTAL').AsCurrency = 0 then
  begin
    CdsSaida.FieldByName('ALIQDESCONTO').AsCurrency := 0;
    Exit;
  end;
  ValorDesc :=  CdsSaida.FieldByName('VALORDESCONTOTOTAL').AsCurrency ;
  CalculaTotais(True);
  CdsSaida.FieldByName('VALORDESCONTOTOTAL').AsCurrency := ValorDesc;
  CdsSaida.FieldByName('ALIQDESCONTO').AsCurrency := (CdsSaida.FieldByName('VALORDESCONTOTOTAL').AsCurrency  / CdsSaida.FieldByName('VALORTOTALNOTA').AsCurrency) * 100;
  RateiaValores;

end;

procedure TfrmSaida.edtEmpresaRegAchado(
  const ValoresCamposEstra: array of Variant);
begin
  inherited;
  UfEmpresa := VarToStr(ValoresCamposEstra[0]);
end;

procedure TfrmSaida.edtFreteExit(Sender: TObject);
begin
  inherited;
  RateiaValores;
end;

procedure TfrmSaida.edtOperacaoRegAchado(
  const ValoresCamposEstra: array of Variant);
begin
  inherited;
  if ValoresCamposEstra[0] = 'F' then //FLAGTIPOPESSOA
  begin
    ConfiguraEditPesquisa(edtPessoa, CdsSaida, tpERPFornecedor);
    edtPessoa.LblTitulo.Caption :='Fornecedor';
  end else
  if ValoresCamposEstra[0] = 'C' then //FLAGTIPOPESSOA
  begin
    ConfiguraEditPesquisa(edtPessoa, CdsSaida, tpERPCliente);
    edtPessoa.LblTitulo.Caption :='Cliente';
  end;

  GeraFinanceiro := ValoresCamposEstra[1] = 'Y'; //FLAGGERAFINANCEIRO
  GroupPagamento.Enabled := GeraFinanceiro;

  if ValoresCamposEstra[1] = 'N' then //FLAGMOVPATRIMONIO
    FTipoMovimento := tmProduto
  else
    FTipoMovimento := tmPatrimonio;

end;

procedure TfrmSaida.FormCreate(Sender: TObject);
begin
  inherited;
  EdtEmpresa.CamposExtraPesquisa := 'UF';
  edtOperacao.CamposExtraPesquisa := 'FLAGTIPOPESSOA,FLAGGERAFINANCEIRO,FLAGMOVPATRIMONIO';
  ConfiguraEditPesquisa(edtEmpresa,CdsSaida,tpERPEmpresa);
  edtOperacao.SQLComp := ' FLAGTIPOOPERACAO =''S''';
  ConfiguraEditPesquisa(edtOperacao,CdsSaida,tpERPOperacaoSaida);
  ConfiguraEditPesquisa(edtTransportadora,CdsSaida,tpERPTransportadora);
  ConfiguraEditPesquisa(edtPessoa,CdsSaida,tpERPCliente);
  ConfiguraEditPesquisa(EdtAlmoxarifado,nil,tpERPAlmoxarifado);
  RestartaVenda;
end;

procedure TfrmSaida.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case key of
   VK_F9:
    btnGravarClick(nil);
   VK_F12:
     btnCancelarClick(nil);

  end;
end;

procedure TfrmSaida.grpFreteClick(Sender: TObject);
begin
  inherited;
  CalculaTotais;
end;

procedure TfrmSaida.ImportaOS(idOS: TipoCampoChave);
var
  CdsOS,CdsServicos,
  CdsProdutos: TpFIBClientDataSet;
  StrSQL: String;
begin
  Try
    CdsSaida.DisableControls;
    CdsItens.DisableControls;
    RestartaVenda;

    CdsOS := TpFIBClientDataSet.Create(nil);
    CdsServicos := TpFIBClientDataSet.Create(nil);
    CdsProdutos := TpFIBClientDataSet.Create(nil);
    SetCds(CdsOS,tpERPOS,'idos = '+TipoCampoChaveToStr(idOS));
    StrSQL:=
         '  EXISTS(SELECT 1  '+
         '           FROM EQUIPAMENTOSOS E  '+
         '          WHERE E.IDOS =   '+TipoCampoChaveToStr(idOS)+
         '            AND E.IDEQUIPAMENTOSOS = S.IDEQUIPAMENTOSOS) ';

    SetCds(CdsServicos,tpERPServicoEquipamentoOS,StrSQL);

    StrSQL:=
         ' EXISTS(SELECT 1   '+
         '         FROM SERVICOOS S  '+
         '        WHERE S.IDSERVICOOS =PS.IDSERVICOOS  '+
         '          AND EXISTS(SELECT 1  '+
         '                       FROM EQUIPAMENTOSOS E  '+
         '                      WHERE E.IDOS =   '+TipoCampoChaveToStr(idOS)+
         '                        AND E.IDEQUIPAMENTOSOS = S.IDEQUIPAMENTOSOS) '+
         '                         ) ';
    SetCds(CdsProdutos,tpERPProdutoServicoOS,StrSQL);


    CdsSaida.FieldByName('idempresa').Value := CdsOS.FieldByName('idempresa').Value;
    CdsSaida.FieldByName('IDOPERACAOESTOQUE').Value := COnfiguracaoOS.GetConfiguracao(tpcERPOperacaoFaturarOS);
    CdsSaida.FieldByName('data').Value := CdsOS.FieldByName('data').Value;
    CdsSaida.FieldByName('idcliente').Value := CdsOS.FieldByName('idcliente').Value;
    CdsSaida.FieldByName('idos').Value := IdOs;
    CdsProdutos.First;
    while not CdsServicos.Eof do
    begin
      CdsItens.Append;
      CdsItens.FieldByName('idproduto').Value := CdsServicos.FieldByName('idproduto').Value;
      CdsItens.FieldByName('codigo').Value := CdsServicos.FieldByName('codigoservico').Value;
      CdsItens.FieldByName('nomeproduto').Value := CdsServicos.FieldByName('DESCRICAOSERVICO').Value;
      CdsItens.FieldByName('quantidade').Value := 1;
      CdsItens.FieldByName('valorunitario').Value := CdsServicos.FieldByName('valorservico').Value;
      CdsItens.FieldByName('valortotal').Value := CdsServicos.FieldByName('valorservico').Value;
      CdsItens.FieldByName('subtotal').Value := CdsServicos.FieldByName('valorservico').Value;
      CdsItens.FieldByName('obs').Value := CdsServicos.FieldByName('obs').Value;
      CdsItens.FieldByName('idalmoxarifado').Value := CdsServicos.FieldByName('idalmoxarifado').Value;
      CdsItens.Post;
      CdsServicos.Next;
    end;

    while not CdsProdutos.Eof do
    begin
      CdsItens.Append;
      CdsItens.FieldByName('idproduto').Value := CdsProdutos.FieldByName('idproduto').Value;
      CdsItens.FieldByName('codigo').Value := CdsProdutos.FieldByName('codigo').Value;
      CdsItens.FieldByName('nomeproduto').Value := CdsProdutos.FieldByName('DESCRICAO').Value;
      CdsItens.FieldByName('idcor').Value := CdsProdutos.FieldByName('idcor').Value;
      CdsItens.FieldByName('idtamanho').Value := CdsProdutos.FieldByName('idtamanho').Value;
      CdsItens.FieldByName('quantidade').Value := CdsProdutos.FieldByName('quantidade').Value;
      CdsItens.FieldByName('valorunitario').Value := CdsProdutos.FieldByName('valorunitario').Value;
      CdsItens.FieldByName('valortotal').Value := CdsProdutos.FieldByName('total').Value;
      CdsItens.FieldByName('subtotal').Value := CdsProdutos.FieldByName('total').Value;
      CdsItens.FieldByName('idalmoxarifado').Value := CdsProdutos.FieldByName('idalmoxarifado').Value;

      CdsItens.FieldByName('IDUNIDADE').Value := CdsProdutos.FieldByName('IDUNIDADE').Value;
      CdsItens.FieldByName('IDNCM').Value := CdsProdutos.FieldByName('IDNCM').Value;
      CdsItens.FieldByName('CST').Value := CdsProdutos.FieldByName('CST').Value;
      CdsItens.FieldByName('CSOSN').Value := CdsProdutos.FieldByName('CSOSN').Value;
      CdsItens.FieldByName('CUSTOMEDIO').Value := CdsProdutos.FieldByName('CUSTOMEDIO').Value;
      CdsItens.FieldByName('CUSTOESTOQUE').Value := CdsProdutos.FieldByName('CUSTOATUAL').Value;
      CdsItens.FieldByName('CUSTOCONTABIL').Value := CdsProdutos.FieldByName('CUSTOCONTABIL').Value;
      CdsItens.FieldByName('EAN').Value := CdsProdutos.FieldByName('CODIGOBARRAS').Value;
      CdsItens.Post;
      CdsProdutos.Next;
    end;

    CalculaTotais;
  Finally
    FreeAndNil(CdsOS);
    FreeAndNil(CdsServicos);
    FreeAndNil(CdsProdutos);
    CdsSaida.EnableControls;
    CdsItens.EnableControls;
  End;
end;

procedure TfrmSaida.RateiaValores;
var
  Rat, AliqDesconto, ALiqAcrescimo,
  ValorDesconto, ValorAcrescimo: Currency;
begin
  Try
    CdsItens.DisableControls;
    while not CdsItens.eof do
    begin
      CdsItens.Edit;
      CdsItens.FieldByName('ALIQACRESCIMO').AsCurrency := edtAcresAliq.AsCurrency;
      CdsItens.FieldByName('ALIQDESCONTO').AsCurrency := edtDescAliq.AsCurrency;
      CdsItens.FieldByName('VALORDESCONTO').AsCurrency := RoundTo(CdsItens.FieldByName('SUBTOTAL').AsCurrency * CdsItens.FieldByName('ALIQDESCONTO').AsCurrency/100,-2);
      CdsItens.FieldByName('VALORACRESCIMO').AsCurrency := RoundTo(CdsItens.FieldByName('SUBTOTAL').AsCurrency * CdsItens.FieldByName('ALIQACRESCIMO').AsCurrency/100,-2);

      Rat := (100-((CdsItens.FieldByName('VALORTOTAL').AsCurrency/ CdsSaida.FieldByName('VALORTOTALNOTA').AsCurrency) * 100))/100;

      CdsItens.FieldByName('VALORFRETERATEADO').AsCurrency :=  CdsSaida.FieldByName('VALORFRETE').AsCurrency * Rat;
      CdsItens.FieldByName('VALORSEGURORATEADO').AsCurrency :=  CdsSaida.FieldByName('VALORSEGURO').AsCurrency * Rat;
      CdsItens.FieldByName('VALOROUTRASDESPESASRATEADO').AsCurrency :=  CdsSaida.FieldByName('VALOROUTRASDESPESAS').AsCurrency * Rat;

      CdsItens.Post;
      CdsItens.Next;
    end;
    CdsItens.First;
  Finally
    CdsItens.EnableControls;
  End;
  CalculaTotais;
end;

procedure TfrmSaida.RestartaVenda;
begin
  if CdsSaida.Active  then
    TRegrasSaidaProduto.DesbloqueiaProdutosVenda(CdsSaida.FieldByName('idsaida').Value, edtEmpresa.ValorChave);
  AbreVenda('-1');
  IdOS:= '-1';
  CdsSaida.Append;
  TRotinasPesquisa.ConfiguraPesquisaFuncionario(edtFuncionario,CdsSaida);
  if Self.Showing then
    edtFuncionario.SetFocus;

end;

procedure TfrmSaida.SetIdOS(const Value: TipoCampoChave);
begin
  FIdOS := Value;
  if Value<> SemID then
    ImportaOS(Value);
end;

end.

