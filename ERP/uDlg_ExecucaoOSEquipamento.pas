unit uDlg_ExecucaoOSEquipamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDlg_CadastroERP, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, cxTextEdit,
  cxMemo, cxDBEdit, StdCtrls, Mask, EditPesquisa, Buttons, ExtCtrls, cxStyles,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, DB,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, ActnList, cxSplitter, DBCtrls,
  LabelDBEdit, DBClient, pFIBClientDataSet,ulibERP,uClassesERP;

type
  TfrmDlg_ExecucaoOSEquipamento = class(TfrmDlg_CadastroERP)
    Panel3: TPanel;
    edtEquipamentos: TEditPesquisa;
    GroupBox1: TGroupBox;
    mmDefeito: TcxDBMemo;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Panel4: TPanel;
    edtFuncionario: TEditPesquisa;
    mmLaudo: TcxDBMemo;
    Panel5: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    cxGrid1: TcxGrid;
    tvItens: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    tvItensColumn1: TcxGridDBColumn;
    tvItensColumn2: TcxGridDBColumn;
    tvItensColumn3: TcxGridDBColumn;
    tvItensColumn4: TcxGridDBColumn;
    tvItensColumn5: TcxGridDBColumn;
    ActionList1: TActionList;
    actInserir: TAction;
    actAlterar: TAction;
    actExcluir: TAction;
    cxSplitter2: TcxSplitter;
    LabelDBEdit1: TLabelDBEdit;
    LabelDBEdit2: TLabelDBEdit;
    LabelDBEdit3: TLabelDBEdit;
    cxSplitter1: TcxSplitter;
    edtPatrimonio: TEditPesquisa;
    edtContador: TLabelDBEdit;
    procedure actInserirExecute(Sender: TObject);
    procedure actAlterarExecute(Sender: TObject);
    procedure actExcluirExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    FIdCliente: TipoCampoChave;
    FpDataSetServico: TpFIBClientDataSet;
    FIdEmpresa: TipoCampoChave;
    FData: TDate;
    FDataSetMaster: TpFIBClientDataSet;
    FDataSetProdutosSerial: TpFIBClientDataSet;
    FDataSetProdutos: TpFIBClientDataSet;
    FTipoMovimento: TTipoMovimento;
    FDataSetPatrimonio: TpFIBClientDataSet;
    procedure SetIdCliente(const Value: TipoCampoChave);
    procedure SetpDataSetServico(const Value: TpFIBClientDataSet);
    procedure SetData(const Value: TDate);
    procedure SetIdEmpresa(const Value: TipoCampoChave);
    procedure SetDataSetMaster(const Value: TpFIBClientDataSet);
    procedure SetDataSetProdutos(const Value: TpFIBClientDataSet);
    procedure SetDataSetProdutosSerial(const Value: TpFIBClientDataSet);
    procedure SetTipoMovimento(const Value: TTipoMovimento);
    procedure SetDataSetPatrimonio(const Value: TpFIBClientDataSet);
    { Private declarations }
  public
    { Public declarations }
    property IdCliente: TipoCampoChave read FIdCliente write SetIdCliente;
    property IdEmpresa: TipoCampoChave read FIdEmpresa write SetIdEmpresa;
    property Data: TDate read FData write SetData;
    property pDataSetServico: TpFIBClientDataSet read FpDataSetServico write SetpDataSetServico;
    property DataSetMaster:  TpFIBClientDataSet read FDataSetMaster write SetDataSetMaster;
    property DataSetProdutos: TpFIBClientDataSet read FDataSetProdutos write SetDataSetProdutos;
    property DataSetProdutosSerial: TpFIBClientDataSet read FDataSetProdutosSerial write SetDataSetProdutosSerial;
    property DataSetPatrimonio: TpFIBClientDataSet read FDataSetPatrimonio write SetDataSetPatrimonio;
    property TipoMovimento: TTipoMovimento read FTipoMovimento write SetTipoMovimento;
  end;

var
  frmDlg_ExecucaoOSEquipamento: TfrmDlg_ExecucaoOSEquipamento;

implementation

uses uCad_OS, UDmConexao, Comandos, MinhasClasses, uDlg_ServicoEquipamentoOS,
  uSQL;

{$R *.dfm}

procedure TfrmDlg_ExecucaoOSEquipamento.actAlterarExecute(Sender: TObject);
begin
  inherited;
  Try
    frmDlg_ServicoEquipamentoOS := TfrmDlg_ServicoEquipamentoOS.Create(nil);
    frmDlg_ServicoEquipamentoOS.pDataSet := pDataSetServico;
    frmDlg_ServicoEquipamentoOS.FechaEGrava := True;
    frmDlg_ServicoEquipamentoOS.pDataSet.Edit;
    frmDlg_ServicoEquipamentoOS.IdCliente := Self.IdCliente;
    frmDlg_ServicoEquipamentoOS.IdEmpresa := Self.IdEmpresa;
    frmDlg_ServicoEquipamentoOS.Data := Self.Data;
    frmDlg_ServicoEquipamentoOS.DataSetProdutos := Self.DataSetProdutos;
    frmDlg_ServicoEquipamentoOS.DataSetProdutosSerial := Self.DataSetProdutosSerial;
    frmDlg_ServicoEquipamentoOS.DataSetPatrimonio := Self.DataSetPatrimonio;
    frmDlg_ServicoEquipamentoOS.TipoMovimento := Self.TipoMovimento;
    frmDlg_ServicoEquipamentoOS.IdPatrimonio := edtPatrimonio.ValorChave;
    frmDlg_ServicoEquipamentoOS.ShowModal;
  Finally
    FreeAndNil(frmDlg_ServicoEquipamentoOS);
  End;
end;

procedure TfrmDlg_ExecucaoOSEquipamento.actExcluirExecute(Sender: TObject);
begin
  inherited;
  if ConfirmaDel then
  begin
    pDataSetServico.Edit;
    pDataSetServico.FieldByName('FLAGEDICAO').AsString :='D';
    pDataSetServico.Post;
  end;

end;

procedure TfrmDlg_ExecucaoOSEquipamento.actInserirExecute(Sender: TObject);
begin
  inherited;
  Try
    frmDlg_ServicoEquipamentoOS := TfrmDlg_ServicoEquipamentoOS.Create(nil);
    frmDlg_ServicoEquipamentoOS.pDataSet := pDataSetServico;
    frmDlg_ServicoEquipamentoOS.FechaEGrava := True;
    frmDlg_ServicoEquipamentoOS.pDataSet.Append;
    frmDlg_ServicoEquipamentoOS.IdCliente := Self.IdCliente;
    frmDlg_ServicoEquipamentoOS.IdEmpresa := Self.IdEmpresa;
    frmDlg_ServicoEquipamentoOS.Data := Self.Data;
    frmDlg_ServicoEquipamentoOS.DataSetProdutos := Self.DataSetProdutos;
    frmDlg_ServicoEquipamentoOS.DataSetProdutosSerial := Self.DataSetProdutosSerial;
    frmDlg_ServicoEquipamentoOS.DataSetPatrimonio := Self.DataSetPatrimonio;
    frmDlg_ServicoEquipamentoOS.TipoMovimento := Self.TipoMovimento;
    frmDlg_ServicoEquipamentoOS.IdPatrimonio := edtPatrimonio.ValorChave;
    frmDlg_ServicoEquipamentoOS.ShowModal;
  Finally
    FreeAndNil(frmDlg_ServicoEquipamentoOS);
  End;
end;

procedure TfrmDlg_ExecucaoOSEquipamento.btnOkClick(Sender: TObject);
begin
  if Trim(mmDefeito.Text) = '' then
  begin
    Avisa('Informe o detalhe da ocorrência');
    mmDefeito.SetFocus;
    Exit;
  end;
  if TipoMovimento = tmEquipamento then
  begin
    VerificaEdit(edtEquipamentos,'Informe o equipamento');
    if ExisteRegistro(pDataSet,'IDEQUIPAMENTOCLIENTE') Then
    begin
      Avisa('Esse equipamento já foi dicionado');
      edtEquipamentos.SetFocus;
      exit;
    end;
  end ;
  if TipoMovimento = tmPatrimonio then
  begin
    VerificaEdit(edtPatrimonio,'Informe o patrimônio');
    if ExisteRegistro(pDataSet,'IDPATRIMONIO') Then
    begin
      Avisa('Esse patrimônio já foi dicionado');
      edtPatrimonio.SetFocus;
      exit;
    end;
  end ;


  if (Trim(mmLaudo.Text) <> '') and (edtFuncionario.IsNull) then
  begin
    Avisa('Informe o funcionário responsável pelo laudo');
    edtFuncionario.SetFocus;
    exit;
  end;
  if pDataSetServico.IsEmpty then
  begin
    Avisa('Informe o serviço a ser exeutado');
    exit;
  end;

  Try
    pDataSetServico.DisableControls;
    pDataSetServico.First;
    while not pDataSetServico.Eof do
    begin
      if pDataSetServico.FieldByName('idfuncionario').IsNull then
      begin
       Avisa('Esse serviço "'+pDataSetServico.FieldByName('DESCRICAOSERVICO').AsString+'" não possui funcionário');
       exit;
      end;
      pDataSetServico.Next
    end;
  Finally
    pDataSetServico.EnableControls;
  End;

  inherited;

end;

procedure TfrmDlg_ExecucaoOSEquipamento.FormShow(Sender: TObject);
begin
  inherited;
  if TipoMovimento=tmEquipamento then
  begin
    ConfiguraEditPesquisa(edtEquipamentos,pDataSet,tpERPClienteEquipamento,True,'','','IDENTIFICADOR','IDEQUIPAMENTOCLIENTE');
    edtEquipamentos.SQLComp := 'idcliente = '+TipoCampoChaveToStr(IdCliente);
  end;
  if TipoMovimento=tmPatrimonio then
  begin
    ConfiguraEditPesquisa(edtPatrimonio,pDataSet,tpERPPatrimonio,True);

  end;


  ConfiguraEditPesquisa(edtFuncionario,pDataSet,tpERPFuncionario,False,'','','CODIGO','IDFUNCIONARIOSOLUCAO');

end;

procedure TfrmDlg_ExecucaoOSEquipamento.SetData(const Value: TDate);
begin
  FData := Value;
end;

procedure TfrmDlg_ExecucaoOSEquipamento.SetDataSetMaster(
  const Value: TpFIBClientDataSet);
begin
  FDataSetMaster := Value;
end;

procedure TfrmDlg_ExecucaoOSEquipamento.SetDataSetPatrimonio(
  const Value: TpFIBClientDataSet);
begin
  FDataSetPatrimonio := Value;
end;

procedure TfrmDlg_ExecucaoOSEquipamento.SetDataSetProdutos(
  const Value: TpFIBClientDataSet);
begin
  FDataSetProdutos := Value;
end;

procedure TfrmDlg_ExecucaoOSEquipamento.SetDataSetProdutosSerial(
  const Value: TpFIBClientDataSet);
begin
  FDataSetProdutosSerial := Value;
end;

procedure TfrmDlg_ExecucaoOSEquipamento.SetIdCliente(const Value: TipoCampoChave);
begin
  FIdCliente := Value;
end;

procedure TfrmDlg_ExecucaoOSEquipamento.SetIdEmpresa(const Value: TipoCampoChave);
begin
  FIdEmpresa := Value;
end;

procedure TfrmDlg_ExecucaoOSEquipamento.SetpDataSetServico(
  const Value: TpFIBClientDataSet);
begin
  FpDataSetServico := Value;
end;

procedure TfrmDlg_ExecucaoOSEquipamento.SetTipoMovimento(
  const Value: TTipoMovimento);
begin
  FTipoMovimento := Value;
  edtEquipamentos.Visible :=FTipoMovimento = tmEquipamento;
  edtPatrimonio.Visible := FTipoMovimento = tmPatrimonio;
  edtContador.Visible  := FTipoMovimento = tmPatrimonio;


end;

end.
