unit uDlgEquipamentoClienteContrato;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDlg_CadastroERP, StdCtrls, Buttons, ExtCtrls, Mask, EditPesquisa,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  DBClient, pFIBClientDataSet, ulibERP;

type
  TfrmDlg_EquipamentoClienteContrato = class(TfrmDlg_CadastroERP)
    DataServicos: TDataSource;
    GroupBox1: TGroupBox;
    Panel4: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    cxGrid1: TcxGrid;
    cxGrid1Level1: TcxGridLevel;
    Panel3: TPanel;
    edtEquipamentoCliente: TEditPesquisa;
    edtPeriodoVisita: TEditPesquisa;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    cxGrid1DBTableView1Column3: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure edtEquipamentoClienteBtnNovoClick(Sender: TObject);
    procedure edtEquipamentoClienteBtnEditarClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure edtEquipamentoClienteRegAchado(
      const ValoresCamposEstra: array of Variant);
  private
    FIdCliente: TipoCampoChave;
    FIdEmpresa: TipoCampoChave;
    FData: TDate;
    FDataSetServicos: TpFIBClientDataSet;
    procedure SetIdCliente(const Value: TipoCampoChave);
    procedure SetData(const Value: TDate);
    procedure SetIdEmpresa(const Value: TipoCampoChave);
    procedure SetDataSetServicos(const Value: TpFIBClientDataSet);
    { Private declarations }
  public
    { Public declarations }
    property IdCliente: TipoCampoChave read FIdCliente write SetIdCliente;
    property Data: TDate read FData write SetData;
    property IdEmpresa: TipoCampoChave read FIdEmpresa write SetIdEmpresa;
    property DataSetServicos: TpFIBClientDataSet read FDataSetServicos write SetDataSetServicos;
  end;

var
  frmDlg_EquipamentoClienteContrato: TfrmDlg_EquipamentoClienteContrato;

implementation

uses MinhasClasses, Comandos, uForms, uDlg_ServicoContrato;

{$R *.dfm}

procedure TfrmDlg_EquipamentoClienteContrato.BitBtn1Click(Sender: TObject);
begin
  inherited;
  frmDlg_ServicoContrato := tfrmDlg_ServicoContrato.Create(NIL);
  try
    frmDlg_ServicoContrato.IdCliente := IdCliente;
    frmDlg_ServicoContrato.IdEmpresa := IdEmpresa;
    frmDlg_ServicoContrato.Data := Data;
    frmDlg_ServicoContrato.pDataSet := FDataSetServicos;
    frmDlg_ServicoContrato.FechaEGrava := False;
    frmDlg_ServicoContrato.pDataSet.Append;
    frmDlg_ServicoContrato.ShowModal;
  finally
    FreeAndNil(frmDlg_ServicoContrato);
  end;
end;

procedure TfrmDlg_EquipamentoClienteContrato.BitBtn2Click(Sender: TObject);
begin
  inherited;
  frmDlg_ServicoContrato := tfrmDlg_ServicoContrato.Create(NIL);
  try
    frmDlg_ServicoContrato.IdCliente := IdCliente;
    frmDlg_ServicoContrato.IdEmpresa := IdEmpresa;
    frmDlg_ServicoContrato.Data := Data;
    frmDlg_ServicoContrato.pDataSet := FDataSetServicos;
    frmDlg_ServicoContrato.FechaEGrava := True;
    frmDlg_ServicoContrato.pDataSet.Edit;
    frmDlg_ServicoContrato.ShowModal;
  finally
    FreeAndNil(frmDlg_ServicoContrato);
  end;
end;

procedure TfrmDlg_EquipamentoClienteContrato.BitBtn3Click(Sender: TObject);
begin
  inherited;
  if ConfirmaDel then
  begin
    FDataSetServicos.Edit;
    FDataSetServicos.FieldByName('FLAGEDICAO').AsString := 'D';
    FDataSetServicos.Post;
  end;
end;

procedure TfrmDlg_EquipamentoClienteContrato.btnOkClick(Sender: TObject);
begin
  VerificaEdit(edtEquipamentoCliente,'Infome o equipamento do ciente');
  if DataSetServicos.IsEmpty then
  begin
    Avisa('Não existe serviço para esse equipamento ');
    Exit;
  end;
  if ExisteRegistro(pDataSet,'IDCLIENTEEQUIPAMENTOS',True,True) Then
    Avisa('Esse equipamento já foi usado nesse contrato')
  else
    inherited;
  edtEquipamentoCliente.SetFocus;
end;

procedure TfrmDlg_EquipamentoClienteContrato.edtEquipamentoClienteBtnEditarClick(
  Sender: TObject);
begin
  inherited;
  edtEquipamentoCliente.ValorChave := TrotinasForms.AbreManutencaoEquipamentoCliente(IdCliente,toEditar);
  edtEquipamentoCliente.Localiza;
end;

procedure TfrmDlg_EquipamentoClienteContrato.edtEquipamentoClienteBtnNovoClick(
  Sender: TObject);
begin
  inherited;
  edtEquipamentoCliente.ValorChave := TrotinasForms.AbreManutencaoEquipamentoCliente(IdCliente,toIncluir);
  edtEquipamentoCliente.Localiza;
end;

procedure TfrmDlg_EquipamentoClienteContrato.edtEquipamentoClienteRegAchado(
  const ValoresCamposEstra: array of Variant);
begin
  inherited;
  if pDataSet.State in[dsEdit, dsInsert] then
    pDataSet.FieldByName('IDENTIFICADOR').Value := ValoresCamposEstra[0];

end;

procedure TfrmDlg_EquipamentoClienteContrato.FormShow(Sender: TObject);
begin
  inherited;
  edtEquipamentoCliente.CamposExtraPesquisa := 'IDENTIFICADOR';
  ConfiguraEditPesquisa(edtEquipamentoCliente,pDataSet,tpERPClienteEquipamento,True);
  ConfiguraEditPesquisa(edtPeriodoVisita,pDataSet,tpERPPeridicidade,False,'','','CODIGO','IDPERIODICIADEVISITA');
  edtEquipamentoCliente.SQLComp := 'idcliente = '+TipoCampoChaveToStr(IdCliente);
  DataServicos.DataSet := DataSetServicos;
end;

procedure TfrmDlg_EquipamentoClienteContrato.SetData(const Value: TDate);
begin
  FData := Value;
end;

procedure TfrmDlg_EquipamentoClienteContrato.SetDataSetServicos(
  const Value: TpFIBClientDataSet);
begin
  FDataSetServicos := Value;
end;

procedure TfrmDlg_EquipamentoClienteContrato.SetIdCliente(const Value: TipoCampoChave);
begin
  FIdCliente := Value;
end;

procedure TfrmDlg_EquipamentoClienteContrato.SetIdEmpresa(const Value: TipoCampoChave);
begin
  FIdEmpresa := Value;
end;

end.
