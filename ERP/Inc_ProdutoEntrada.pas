unit Inc_ProdutoEntrada;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Dlg_Cadastro, StdCtrls, Buttons, ExtCtrls, Mask, EditPesquisa,
  DBCtrls, LabelDBEdit, Comandos, MinhasClasses, DB, pFIBClientDataSet, uSQL,
  ulibERP,uClassesERP;

type
  TfrmInc_ProdutoEntrada = class(TfrmDlg_Cadastro)
    edtCodigoProduto: TEditPesquisa;
    edtQuantidade: TLabelDBEdit;
    edtValorUnitario: TLabelDBEdit;
    LabelDBEdit4: TLabelDBEdit;
    edtUnidade: TEditPesquisa;
    LabelDBEdit5: TLabelDBEdit;
    LabelDBEdit6: TLabelDBEdit;
    LabelDBEdit7: TLabelDBEdit;
    LabelDBEdit8: TLabelDBEdit;
    edtValorTotal: TLabelDBEdit;
    edtCodigoCFOP: TEditPesquisa;
    LabelDBEdit3: TLabelDBEdit;
    edtCodigoFornecedor: TLabelDBEdit;
    DataProdutoEntrada: TDataSource;
    edtUnidadeCompra: TEditPesquisa;
    edtFatorMultiplicacao: TLabelDBEdit;
    LabelDBEdit2: TLabelDBEdit;
    btnSerial: TBitBtn;
    edtCFOPEntrada: TEditPesquisa;
    EdtAlmoxarifado: TEditPesquisa;
    edtPatrimonio: TEditPesquisa;
    procedure FormShow(Sender: TObject);
    procedure edtCodigoFornecedorExit(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure edtCodigoProdutoRegAchado(
      const ValoresCamposEstra: array of Variant);
    procedure edtCodigoCFOPBtnNovoClick(Sender: TObject);
    procedure edtCodigoProdutoBtnNovoClick(Sender: TObject);
    procedure edtUnidadeCompraBtnNovoClick(Sender: TObject);
    procedure edtUnidadeBtnNovoClick(Sender: TObject);
    procedure edtUnidadeBtnPesquisaClick(Sender: TObject);
    procedure edtCodigoProdutoBtnEditarClick(Sender: TObject);
    procedure btnSerialClick(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure edtPatrimonioRegAchado(
      const ValoresCamposEstra: array of Variant);
  private
    FIdFornecedor: TipoCampoChave;
    UsaSerial: Boolean;
    FDataSetSerial: TpFIBClientDataSet;
    FTipoMovimento: TTipoMovimento;
    procedure SetIdFornecedor(const Value: TipoCampoChave);
    procedure SetDataSetSerial(const Value: TpFIBClientDataSet);
    procedure SetTipoMovimento(const Value: TTipoMovimento);
    { Private declarations }
  public
    { Public declarations }
    Property IdFornecedor: TipoCampoChave read FIdFornecedor write SetIdFornecedor;
    property DataSetSerial: TpFIBClientDataSet read FDataSetSerial write SetDataSetSerial;
    property TipoMovimento : TTipoMovimento read FTipoMovimento write SetTipoMovimento;
  end;

var
  frmInc_ProdutoEntrada: TfrmInc_ProdutoEntrada;

implementation

uses uForms, uDlg_ManutencaoSerialProduto, uEntrada, uConstantes;

{$R *.dfm}

procedure TfrmInc_ProdutoEntrada.FormShow(Sender: TObject);
begin
  inherited;
  edtCodigoProduto.CamposExtraPesquisa := 'IDUNIDADE,IDUNIDADECOMPRA,FATORMULTIPLICADOR,FLAGSERIAL';

  DataProdutoEntrada.DataSet := pDataSet;
  ConfiguraEditPesquisa(edtCodigoProduto, pDataSet, tpERPProduto);
  ConfiguraEditPesquisa(edtCodigoCFOP, pDataSet, tpERPCFOPVisivel);
  ConfiguraEditPesquisa(edtCFOPEntrada, pDataSet, tpERPCFOPVisivel,True,'','','CFOP','IDCFOPENTRADA');

  ConfiguraEditPesquisa(edtUnidade, pDataSet, tpERPUnidade);
  ConfiguraEditPesquisa(edtUnidadeCompra, pDataSet, tpERPUnidade,True,'','','','IDUNIDADECOMPRA');

  ConfiguraEditPesquisa(EdtAlmoxarifado, pDataSet, tpERPAlmoxarifado);
  ConfiguraEditPesquisa(edtPatrimonio, pDataSet, tpERPPatrimonio);

  edtCodigoProduto.SQLComp := 'TIPOPRODUTO <> '+QuotedStr(TipoProdutoServico);

  edtCodigoCFOP.TamanhoCodigo := 4;
  edtCodigoCFOP.AutoPesquisa := True;
  edtCFOPEntrada.TamanhoCodigo := 4;
  edtCFOPEntrada.AutoPesquisa := True;
end;

procedure TfrmInc_ProdutoEntrada.SetDataSetSerial(
  const Value: TpFIBClientDataSet);
begin
  FDataSetSerial := Value;
end;

procedure TfrmInc_ProdutoEntrada.SetIdFornecedor(const Value: TipoCampoChave);
begin
  FIdFornecedor := Value;
end;

procedure TfrmInc_ProdutoEntrada.SetTipoMovimento(const Value: TTipoMovimento);
begin
  FTipoMovimento := Value;
  edtCodigoProduto.Visible := FTipoMovimento = tmProduto;
  edtPatrimonio.Visible := FTipoMovimento = tmPatrimonio;

  case Value of
    tmProduto:
    begin
      edtQuantidade.DataField := 'QUANTIDADERECEBIDA';
      edtQuantidade.Titulo.Caption:= 'Quantidade recebida';
    end;
    tmPatrimonio:
    begin
      pDataSet.FieldByName('FATORMULTIPLICADOR').Value := 1;
      pDataSet.FieldByName('QUANTIDADE').Value := 1;
      pDataSet.FieldByName('QUANTIDADERECEBIDA').AsCurrency := 1;
      edtQuantidade.DataField := 'CONTADORPATRIMONIO';
      edtQuantidade.Titulo.Caption:= 'Contador';
      edtFatorMultiplicacao.Enabled := False;
      edtCodigoFornecedor.Enabled := False;
      edtCodigoFornecedor.IsNull := True;
    end;

  end;


end;

procedure TfrmInc_ProdutoEntrada.btnSerialClick(Sender: TObject);
begin
  inherited;
  if UsaSerial then
  begin
    Try
      frmDlg_ManutencaoSerialProduto := TfrmDlg_ManutencaoSerialProduto.Create(nil);
      frmDlg_ManutencaoSerialProduto.pDataSet := DataSetSerial;
      frmDlg_ManutencaoSerialProduto.ShowModal;
    Finally
      FreeAndNil(frmDlg_ManutencaoSerialProduto);
    End;
  end;
end;

procedure TfrmInc_ProdutoEntrada.btnOkClick(Sender: TObject);
begin
  pDataSet.FieldByName('VALORTOTALBRUTO').AsCurrency :=
     pDataSet.FieldByName('VALORUNITARIO').AsCurrency *
     pDataSet.FieldByName('QUANTIDADERECEBIDA').AsCurrency;

  if TipoMovimento = tmProduto then
  begin
    VerificaEdit(pDataSet, edtCodigoFornecedor,'','Informe o código do produto no fornecedor');
    VerificaEdit(edtCodigoProduto,'Informe o produto')
  end else
    VerificaEdit(edtPatrimonio,'Informe o patrimônio');

  VerificaEdit(edtCodigoCFOP,'Informe o CFOP');
  VerificaEdit(pDataSet,edtQuantidade,'','Informe a quantidade');
  VerificaEdit(pDataSet,edtValorUnitario,'','Informe o valor unitário');
  VerificaEdit(pDataSet,edtValorTotal,'','Informe o valor total');
  if (UsaSerial)  then
  begin
    if (DataSetSerial.RecordCount <> pDataSet.FieldByName('quantidade').AsInteger) then
    begin
      Avisa('A quantidade de seriais difere da quantidade informada: '+pDataSet.FieldByName('quantidade').AsString);
      btnSerialClick(nil);
      Abort;
    end;

  end;
  inherited;
  if ModalResult <> mrOk then
    edtCodigoFornecedor.SetFocus;
end;

procedure TfrmInc_ProdutoEntrada.edtCodigoCFOPBtnNovoClick(Sender: TObject);
begin
  inherited;
  TrotinasForms.AbreFormSimplesPeloTipoPesquisa(tpERPCFOPVisivel, toIncluir);
end;

procedure TfrmInc_ProdutoEntrada.edtCodigoFornecedorExit(Sender: TObject);
Var
  StrSQL : String;
begin
  inherited;
  StrSQL :=
    'SELECT IDPRODUTO '+
    '  FROM PRODUTOFORNECEDOR' +
    ' WHERE CODIGOPRODUTO = '+GetStr(edtCodigoFornecedor.Text)+
    '   AND IDFORNECEDOR = '+GetStr(FIdFornecedor);
  pDataSet.FieldByName('IDPRODUTO').AsString := GetValorCds(StrSQL);
  edtCodigoProduto.Localiza;
end;

procedure TfrmInc_ProdutoEntrada.edtCodigoProdutoBtnEditarClick(
  Sender: TObject);
begin
  inherited;
  TrotinasForms.AbreCadastroProduto(toEditar);
end;

procedure TfrmInc_ProdutoEntrada.edtCodigoProdutoBtnNovoClick(Sender: TObject);
begin
  inherited;
  TrotinasForms.AbreCadastroProduto(toIncluir);
end;

Procedure TfrmInc_ProdutoEntrada.edtCodigoProdutoRegAchado(
  const ValoresCamposEstra: array of Variant);
begin
  inherited;
  if not (pDataSet.State in [dsEdit, dsInsert]) then
    Exit;
  pDataSet.FieldByName('IDUNIDADE').AsString := VarToStr(ValoresCamposEstra[0]);// 'IDUNIDADE;

  if pDataSet.FieldByName('IDUNIDADECOMPRA').isnull then
     pDataSet.FieldByName('IDUNIDADECOMPRA').AsString := VarToStr(ValoresCamposEstra[1]); // IDUNIDADECOMPRA ;
  if pDataSet.FieldByName('FATORMULTIPLICADOR').IsNull then
    pDataSet.FieldByName('FATORMULTIPLICADOR').AsString := VarToStr(ValoresCamposEstra[2]); // FATORMULTIPLICADOR ;
  if pDataSet.FieldByName('FATORMULTIPLICADOR').IsNull then
    pDataSet.FieldByName('FATORMULTIPLICADOR').AsInteger := 1;
  pDataSet.FieldByName('CODIGO_PRODUTO').AsString := edtCodigoProduto.Text;
  pDataSet.FieldByName('NOME_PRODUTO').AsString := edtCodigoProduto.Display.Text;
  UsaSerial := VarToStr(ValoresCamposEstra[3]) = 'Y';
  btnSerial.Enabled := UsaSerial;
  edtUnidade.Localiza;


end;

procedure TfrmInc_ProdutoEntrada.edtPatrimonioRegAchado(
  const ValoresCamposEstra: array of Variant);
begin
  inherited;
  if not (pDataSet.State in [dsEdit, dsInsert]) then
    Exit;
  pDataSet.FieldByName('CODIGO_PRODUTO').AsString := edtPatrimonio.Text;
  pDataSet.FieldByName('NOME_PRODUTO').AsString := edtPatrimonio.Display.Text;
  UsaSerial := False;
  btnSerial.Enabled := UsaSerial;
end;

procedure TfrmInc_ProdutoEntrada.edtQuantidadeExit(Sender: TObject);
begin
  inherited;
  if UsaSerial then
  begin
    if StrToInt64Def(edtQuantidade.Text,-1) > 0 then
    begin
      Avisa('Produtos controlados por serial,devem ter a quantidade inteira.');
      edtQuantidade.SetFocus;
      Abort;
    end;
    btnSerialClick(nil);

  end;
end;

procedure TfrmInc_ProdutoEntrada.edtUnidadeBtnNovoClick(Sender: TObject);
begin
  inherited;
  TrotinasForms.AbreCadastroUnidade(toIncluir);
end;

procedure TfrmInc_ProdutoEntrada.edtUnidadeBtnPesquisaClick(Sender: TObject);
begin
  inherited;
  TrotinasForms.AbreCadastroUnidade(toEditar);
end;

procedure TfrmInc_ProdutoEntrada.edtUnidadeCompraBtnNovoClick(Sender: TObject);
begin
  inherited;
   TrotinasForms.AbreCadastroUnidade(toIncluir);
end;

end.
