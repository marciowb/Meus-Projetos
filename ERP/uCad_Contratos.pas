unit uCad_Contratos;

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
  cxFilter, cxData, cxDataStorage, cxDBData, cxMemo, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid,ulibERP, cxSpinEdit;

type
  TfrmCad_Contrato = class(TfrmCad_CadastroPaiERP)
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtData: TcxDBDateEdit;
    edtEmpresa: TEditPesquisa;
    LabelDBEdit1: TLabelDBEdit;
    edtCliente: TEditPesquisa;
    edtPeriodoVigenciaContrato: TEditPesquisa;
    edtPeriodoVisitaContrato: TEditPesquisa;
    edtValidadeContrato: TcxDBDateEdit;
    DBCheckBox1: TDBCheckBox;
    edtTipoContrato: TEditPesquisa;
    edtCondPagamento: TEditPesquisa;
    pageOpcoes: TcxPageControl;
    tsObs: TcxTabSheet;
    cxDBMemo1: TcxDBMemo;
    tsEquipamentos: TcxTabSheet;
    DataServicos: TDataSource;
    CdsServicos: TpFIBClientDataSet;
    Panel5: TPanel;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    cxGrid2: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    CdsEquipamentos: TpFIBClientDataSet;
    DataEquipamento: TDataSource;
    actIncluirEquipamento: TAction;
    actEditarEquipamento: TAction;
    acExcluirEquipamento: TAction;
    cxGridDBTableView1Column1: TcxGridDBColumn;
    cxGridDBTableView1Column2: TcxGridDBColumn;
    cxGridDBTableView1Column3: TcxGridDBColumn;
    cxGridDBTableView1Column4: TcxGridDBColumn;
    cxGridDBTableView1Column5: TcxGridDBColumn;
    CdsCompetencia: TpFIBClientDataSet;
    cxTabSheet1: TcxTabSheet;
    GroupBox1: TGroupBox;
    pnlCompetencias: TPanel;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    DataCompetencia: TDataSource;
    Panel4: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    BitBtn3: TBitBtn;
    cxDBSpinEdit1: TcxDBSpinEdit;
    Label3: TLabel;
    BitBtn7: TBitBtn;
    procedure actIncluirServicoExecute(Sender: TObject);
    procedure actAlterarServicoExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CdsCadastroAfterScroll(DataSet: TDataSet);
    procedure CdsCadastroAfterPost(DataSet: TDataSet);
    procedure CdsServicosNewRecord(DataSet: TDataSet);
    procedure CdsServicosBeforePost(DataSet: TDataSet);
    procedure CdsEquipamentosBeforePost(DataSet: TDataSet);
    procedure CdsEquipamentosNewRecord(DataSet: TDataSet);
    procedure actIncluirEquipamentoExecute(Sender: TObject);
    procedure actEditarEquipamentoExecute(Sender: TObject);
    procedure acExcluirEquipamentoExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtClienteBtnNovoClick(Sender: TObject);
    procedure actGravarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtPeriodoVigenciaContratoRegAchado(
      const ValoresCamposEstra: array of Variant);
    procedure CdsEquipamentosAfterScroll(DataSet: TDataSet);
    procedure CdsServicosAfterOpen(DataSet: TDataSet);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
  private
    FidProposta: TipoCampoChave;
    procedure SetidProposta(const Value: TipoCampoChave);
    { Private declarations }
    procedure ConverteProposta;
  public
    { Public declarations }
    property idProposta: TipoCampoChave read FidProposta write SetidProposta;
  end;

var
  frmCad_Contrato: TfrmCad_Contrato;

implementation

uses UDmConexao, Comandos, uForms, MinhasClasses, uRegras, uDlg_ServicoContrato,
  uDlgEquipamentoClienteContrato, uLst_OS, uCad_OS;
{$R *.dfm}

procedure TfrmCad_Contrato.acExcluirEquipamentoExecute(Sender: TObject);
begin
  inherited;
  if ConfirmaDel then
  begin
    MudaEstado;
    CdsServicos.Edit;
    CdsServicos.FieldByName('FLAGEDICAO').AsString := 'D';
    CdsServicos.Post;
  end;
end;

procedure TfrmCad_Contrato.actAlterarServicoExecute(Sender: TObject);
begin
  inherited;
  MudaEstado;
  
end;

procedure TfrmCad_Contrato.actEditarEquipamentoExecute(Sender: TObject);
begin
  inherited;
  MudaEstado;
  frmDlg_ServicoContrato := tfrmDlg_ServicoContrato.Create(NIL);
  try
    frmDlg_ServicoContrato.IdCliente := edtCliente.ValorChave;
    frmDlg_ServicoContrato.IdEmpresa := edtEmpresa.ValorChave;
    frmDlg_ServicoContrato.Data := CdsCadastro.FieldByName('data').AsDateTime;
    frmDlg_ServicoContrato.pDataSet := Self.CdsServicos;
    frmDlg_ServicoContrato.FechaEGrava := True;
    frmDlg_ServicoContrato.pDataSet.Edit;
    frmDlg_ServicoContrato.ShowModal;
  finally
    FreeAndNil(frmDlg_ServicoContrato);
  end;

end;

procedure TfrmCad_Contrato.actGravarExecute(Sender: TObject);
var
 Tot: Currency;
begin
  VerificaEdit(edtCliente,'Infome o cliente');
  VerificaEdit(edtEmpresa,'Infome a empresa');
  VerificaEdit(edtTipoContrato,'Infome o tipo de contrato');
  VerificaEdit(edtCondPagamento,'Infome a condição de pagamento');

  if CdsServicos.IsEmpty then
  begin
    Avisa('Deve ser informado palo menos um serviço.');
    Exit;
  end;
//  if CdsEquipamentos.IsEmpty then
//  begin
//    if Pergunta('Não foi informado um produto do cliente. Deseja continuar? ') Then
//      Exit;
//  end;
  Tot := 0;
  CdsServicos.First;
  while not CdsServicos.Eof do
  begin
    Tot := ToT+CdsServicos.FieldByName('VALORTOTAL').AsCurrency;
    CdsServicos.Next;
  end;
  CdsCadastro.FieldByName('VALORTOTAL').AsCurrency := Tot;
  inherited;

end;

procedure TfrmCad_Contrato.actIncluirEquipamentoExecute(Sender: TObject);
begin
  inherited;
  MudaEstado;
  frmDlg_ServicoContrato := tfrmDlg_ServicoContrato.Create(NIL);
  try
    frmDlg_ServicoContrato.IdCliente := edtCliente.ValorChave;
    frmDlg_ServicoContrato.IdEmpresa := edtEmpresa.ValorChave;
    frmDlg_ServicoContrato.Data := CdsCadastro.FieldByName('data').AsDateTime;
    frmDlg_ServicoContrato.pDataSet := Self.CdsServicos;
    frmDlg_ServicoContrato.FechaEGrava := False;
    frmDlg_ServicoContrato.pDataSet.Append;
    frmDlg_ServicoContrato.ShowModal;
  finally
    FreeAndNil(frmDlg_ServicoContrato);
  end;

end;

procedure TfrmCad_Contrato.actIncluirServicoExecute(Sender: TObject);
begin
  inherited;
  MudaEstado;
 
end;

procedure TfrmCad_Contrato.BitBtn1Click(Sender: TObject);
begin
  inherited;
  TrotinasForms.AbreAgenda(SemID,CdsCompetencia.FieldByName('IDCONTRATOCOMPETENCIA').AsString);
end;

procedure TfrmCad_Contrato.BitBtn2Click(Sender: TObject);
begin
  inherited;
  Try
    frmLst_OS := TfrmLst_OS.Create(nil);
    frmLst_OS.IdCompetenciaContrato := CdsCompetencia.FieldByName('IDCONTRATOCOMPETENCIA').AsString;
    frmLst_OS.ShowModal;
  Finally
    FreeAndNil(frmLst_OS);
  End;
end;

procedure TfrmCad_Contrato.BitBtn3Click(Sender: TObject);
begin
  inherited;
  frmCad_OS := TfrmCad_OS.Create(nil);
  Try
    frmCad_OS.NovoReg := True;
    frmCad_OS.IdContrato := CdsCompetencia.FieldByName('IDCONTRATOCOMPETENCIA').AsString;
    frmCad_OS.ShowModal;
  Finally
    FreeAndNil(frmCad_OS);
  End;
end;

procedure TfrmCad_Contrato.BitBtn7Click(Sender: TObject);
begin
  inherited;
  TrotinasForms.AbreContasReceber(semid,semid,CdsCompetencia.FieldByName('IDCONTRATOCOMPETENCIA').AsString);
end;

procedure TfrmCad_Contrato.CdsCadastroAfterPost(DataSet: TDataSet);
begin
  inherited;
//  SetRegistros(CdsEquipamentos, tpERPClienteEquipamentoContrato);
  SetRegistros(CdsServicos, tpERPServicoContrato);
end;

procedure TfrmCad_Contrato.CdsCadastroAfterScroll(DataSet: TDataSet);
begin
  inherited;
//  SetCds(CdsEquipamentos, tpERPClienteEquipamentoContrato, 'IDCONTRATO = ' +TipoCampoChaveToStr( ValorChave));
  SetCds(CdsServicos, tpERPServicoContrato,
            ' IDCONTRATO = ' + TipoCampoChaveToStr(ValorChave));
 SetCds(CdsCompetencia,tpERPCompetenciaContrato,'CONTRATOCOMPETENCIA.IDCONTRATO = '+TipoCampoChaveToStr(ValorChave));

end;

procedure TfrmCad_Contrato.CdsEquipamentosAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if CdsEquipamentos.FieldByName('IDCONTRATOEQUIPAMENTOCLIENTE').AsString <> '' then
  begin
    CdsServicos.Filter := 'IDCONTRATOEQUIPAMENTOCLIENTE = '+TipoCampoChaveToStr( CdsEquipamentos.FieldByName('IDCONTRATOEQUIPAMENTOCLIENTE').AsString );
    CdsServicos.Filtered := True;
  end;
end;

procedure TfrmCad_Contrato.CdsEquipamentosBeforePost(DataSet: TDataSet);
begin
  inherited;
  if CdsEquipamentos.FieldByName('FLAGEDICAO').AsString= 'N' then
    CdsEquipamentos.FieldByName('FLAGEDICAO').AsString := 'E';

end;

procedure TfrmCad_Contrato.CdsEquipamentosNewRecord(DataSet: TDataSet);
begin
  inherited;
//  CdsEquipamentos.FieldByName('idcontrato').Value := ValorChave;
//  CdsEquipamentos.FieldByName('IDCONTRATOEQUIPAMENTOCLIENTE').AsString := GetCodigo(tpERPClienteEquipamentoContrato);
//  CdsEquipamentos.FieldByName('FLAGEDICAO').AsString := 'I';
//  CdsEquipamentos.FieldByName('IDPERIODICIADEVISITA').AsString :=  CdsCadastro.FieldByName('IDPERIODICIDADEVISITA').AsString;

end;

procedure TfrmCad_Contrato.CdsServicosAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FormataMascara(CdsServicos.FieldByName('VALORTOTAL'),tcReal);
end;

procedure TfrmCad_Contrato.CdsServicosBeforePost(DataSet: TDataSet);
begin
  inherited;
  if CdsServicos.FieldByName('FLAGEDICAO').AsString= 'N' then
    CdsServicos.FieldByName('FLAGEDICAO').AsString := 'E';
end;

procedure TfrmCad_Contrato.CdsServicosNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsServicos.FieldByName('IDCONTRATO').Value := CdsCadastro.FieldByName('IDCONTRATO').AsString;  //CdsEquipamentos.FieldByName('IDCONTRATOEQUIPAMENTOCLIENTE').AsString;
  CdsServicos.FieldByName('IDCONTRATOPRODUTOS').AsString := GetCodigo(tpERPServicoContrato);
  CdsServicos.FieldByName('FLAGEDICAO').AsString := 'I';
  CdsServicos.FieldByName('QUANTIDADE').AsCurrency := 1;
end;

procedure TfrmCad_Contrato.ConverteProposta;
var
  CdsTemp: TpFIBClientDataSet;
begin
  Try
    CdsTemp := TpFIBClientDataSet.Create(nil);
    SetCds(CdsTemp,tpERPProposta,'IDPROPOSTA = '+TipoCampoChaveToStr(idProposta));
    CdsCadastro.FieldByName('IDEMPRESA').Value := CdsTemp.FieldByName('IDEMPRESA').Value;
    CdsCadastro.FieldByName('IDCLIENTE').Value := CdsTemp.FieldByName('IDCLIENTE').Value;
    CdsCadastro.FieldByName('DATA').Value := CdsTemp.FieldByName('DATA').Value;
    CdsCadastro.FieldByName('IDPERIODICIDADEVIGENCIA').Value := CdsTemp.FieldByName('IDPERIDOVIGENCIACONTRATO').Value;
    CdsCadastro.FieldByName('IDPERIODICIDADEVISITA').Value := CdsTemp.FieldByName('IDPERIODICIDADEVISITACONTRATO').Value;
    CdsCadastro.FieldByName('OBS').Value := CdsTemp.FieldByName('OBS').Value;
    CdsCadastro.FieldByName('IDPROPOSTA').Value := CdsTemp.FieldByName('IDPROPOSTA').Value;
    SetCds(CdsTemp,tpERPCondicaoPagamentoProposta,'IDPROPOSTA = '+TipoCampoChaveToStr(idProposta));
    CdsCadastro.FieldByName('IDCONDICAOPAGAMENTO').Value := CdsTemp.FieldByName('IDCONDICAOPAGAMENTO').Value;
    SetCds(CdsTemp,tpERPItemProposta,'IDPROPOSTA = '+TipoCampoChaveToStr(idProposta)+' and P.TIPOPRODUTO = ''S'' ');
    CdsTemp.First;
    while not CdsTemp.Eof do
    begin
      CdsServicos.Append;
      CdsServicos.FieldByName('IDPRODUTO').Value := CdsTemp.FieldByName('IDPRODUTO').Value;
      CdsServicos.FieldByName('CODIGO').Value := CdsTemp.FieldByName('CODIGO').Value;
      CdsServicos.FieldByName('NOMEPRODUTO').Value := CdsTemp.FieldByName('NOMEPRODUTO').Value;
      CdsServicos.FieldByName('VALORUNITARIO').Value := CdsTemp.FieldByName('VALORUNITARIO').Value;
      CdsServicos.FieldByName('VALORDESCONTO').Value := CdsTemp.FieldByName('VALORDESCONTO').Value;
      CdsServicos.FieldByName('VALORACRESCIMO').Value := CdsTemp.FieldByName('VALORACRESCIMO').Value;
      CdsServicos.FieldByName('VALORTOTAL').Value := CdsTemp.FieldByName('VALORTOTAL').Value;
      CdsServicos.FieldByName('OBS').Value := CdsTemp.FieldByName('OBS').Value;
      CdsServicos.FieldByName('ALIQDESCONTO').Value := CdsTemp.FieldByName('ALIQDESCONTO').Value;
      CdsServicos.FieldByName('ALIQACRESCIMO').Value := CdsTemp.FieldByName('ALIQACRESCIMO').Value;
      CdsServicos.FieldByName('SUBTOTAL').Value := CdsTemp.FieldByName('SUBTOTAL').Value;
      CdsServicos.Post;
      CdsTemp.Next;
    end;

  Finally
    FreeAndNil(CdsTemp);
  End;

end;

procedure TfrmCad_Contrato.edtClienteBtnNovoClick(Sender: TObject);
begin
  inherited;
  TrotinasForms.AbreCadastroCliente(toIncluir);
end;

procedure TfrmCad_Contrato.edtPeriodoVigenciaContratoRegAchado(
  const ValoresCamposEstra: array of Variant);
begin
  inherited;
  if CdsCadastro.State in [dsInsert, dsEdit] then
  begin
     CdsCadastro.FieldByName('DATATERMINO').AsDateTime := TRegrasPeriodo.GetDataFinal(CdsCadastro.FieldByName('DATA').AsDateTime,
                                                                                        edtPeriodoVigenciaContrato.ValorChave);
  end;
end;

procedure TfrmCad_Contrato.FormCreate(Sender: TObject);
begin
  inherited;
  idProposta := SemID;
  TipoPesquisa := tpERPContrato;
end;

procedure TfrmCad_Contrato.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case key of
    vk_F12:
      pageOpcoes.ActivePage := tsEquipamentos;
    Ord('Q'),Ord('q'):
    begin
      if  ssCtrl in Shift then
        pageOpcoes.ActivePage := tsObs;
    end;

  end;
end;

procedure TfrmCad_Contrato.FormShow(Sender: TObject);
begin
  inherited;
  ConfiguraEditPesquisa(edtEmpresa, CdsCadastro, tpERPEmpresa, True);
  ConfiguraEditPesquisa(edtCliente, CdsCadastro, tpERPCliente, True);
  ConfiguraEditPesquisa(edtPeriodoVigenciaContrato, CdsCadastro,
    tpERPPeridicidade, False, '', '', 'CODIGO', 'IDPERIODICIDADEVIGENCIA');
  ConfiguraEditPesquisa(edtPeriodoVisitaContrato, CdsCadastro,
    tpERPPeridicidade, False, '', '', 'CODIGO', 'IDPERIODICIDADEVISITA');
  ConfiguraEditPesquisa(edtTipoContrato, CdsCadastro, tpERPTipoContrato);
  ConfiguraEditPesquisa(edtCondPagamento, CdsCadastro, tpERPCondicaoPagamento);
  if (NovoReg) and (idProposta <> SemID )  then
    ConverteProposta;
  edtEmpresa.SetFocus;
end;

procedure TfrmCad_Contrato.SetidProposta(const Value: TipoCampoChave);
begin
  FidProposta := Value;
end;

end.
