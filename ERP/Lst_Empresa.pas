unit Lst_Empresa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Lst_CadastroERP, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxTL, cxTLdxBarBuiltInMenu, DBClient,
  pFIBClientDataSet, Menus, ActnList, cxInplaceContainer, cxTLData, cxDBTL,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxPC, ComCtrls, ToolWin, StdCtrls,
  Buttons, Mask, DBCtrls, LabelDBEdit, cxSplitter, ExtCtrls, EditPesquisa,
  cxContainer, cxImage, cxDBEdit, ExtDlgs, JvDBImage, Lst_CadastroSimples,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, Grids, DBGrids, cxImageComboBox;

type
  TfrmLst_Empresa = class(TfrmLstCadastroSimplesERP)
    LabelDBEdit1: TLabelDBEdit;
    LabelDBEdit2: TLabelDBEdit;
    edtCNPJ: TLabelDBEdit;
    LabelDBEdit4: TLabelDBEdit;
    LabelDBEdit5: TLabelDBEdit;
    LabelDBEdit6: TLabelDBEdit;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    GroupBox1: TGroupBox;
    edtCEP: TEditPesquisa;
    edtBairro: TLabeledEdit;
    edtCidade: TLabeledEdit;
    LabelDBEdit7: TLabelDBEdit;
    LabelDBEdit8: TLabelDBEdit;
    cxTabSheet2: TcxTabSheet;
    cxTabSheet3: TcxTabSheet;
    Panel5: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Open: TOpenPictureDialog;
    edtUf: TLabeledEdit;
    Logo: TJvDBImage;
    GroupBox2: TGroupBox;
    DBMemo1: TDBMemo;
    LabelDBEdit10: TLabelDBEdit;
    cxTabSheet4: TcxTabSheet;
    LabelDBEdit9: TLabelDBEdit;
    LabelDBEdit11: TLabelDBEdit;
    LabelDBEdit12: TLabelDBEdit;
    LabelDBEdit13: TLabelDBEdit;
    GroupBox3: TGroupBox;
    cxTabSheet5: TcxTabSheet;
    edtMunicipio: TEditPesquisa;
    cxPageControl2: TcxPageControl;
    cxTabSheet6: TcxTabSheet;
    DBRadioGroup1: TDBRadioGroup;
    cxTabSheet7: TcxTabSheet;
    DataLimiteReceita: TDataSource;
    CdsLimiteReceitaBruta: TpFIBClientDataSet;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    LabelDBEdit3: TLabelDBEdit;
    cxGrid2DBTableView1: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    cxGrid2: TcxGrid;
    DataDocumentos: TDataSource;
    CdsDocumentos: TpFIBClientDataSet;
    cxGrid2DBTableView1Column1: TcxGridDBColumn;
    cxGrid2DBTableView1Column2: TcxGridDBColumn;
    cxGrid2DBTableView1Column3: TcxGridDBColumn;
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCEPRegNaoAchado(ADataSet: TDataSet; Sender: TObject);
    procedure CdsCadastroAfterOpen(DataSet: TDataSet);
    procedure actGravarExecute(Sender: TObject);
    procedure edtCEPRegAchado(const ValoresCamposEstra: array of Variant);
    procedure CdsLimiteReceitaBrutaNewRecord(DataSet: TDataSet);
    procedure CdsLimiteReceitaBrutaBeforePost(DataSet: TDataSet);
    procedure CdsLimiteReceitaBrutaAfterOpen(DataSet: TDataSet);
    procedure CdsLimiteReceitaBrutaBeforeDelete(DataSet: TDataSet);
    procedure CdsCadastroAfterPost(DataSet: TDataSet);
    procedure CdsCadastroAfterScroll(DataSet: TDataSet);
    procedure CdsLimiteReceitaBrutaBeforeEdit(DataSet: TDataSet);
    procedure CdsDocumentosNewRecord(DataSet: TDataSet);
    procedure CdsDocumentosBeforeDelete(DataSet: TDataSet);
    procedure CdsDocumentosBeforePost(DataSet: TDataSet);
    procedure CdsDocumentosBeforeEdit(DataSet: TDataSet);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  frmLst_Empresa: TfrmLst_Empresa;

implementation

uses MinhasClasses, Comandos, uSQL, uLibERP;

{$R *.dfm}

procedure TfrmLst_Empresa.actGravarExecute(Sender: TObject);
begin
  VerificaEdit(edtCEP,'Informe o cep');
  if not Verifica_CNPJ(CdsCadastro.FieldByName('CNPJ').AsString) Then
  begin
    Avisa('Informe um CNPJ válido');
    edtCNPJ.SetFocus;
    Exit;
  end;
  inherited;

end;

procedure TfrmLst_Empresa.CdsCadastroAfterOpen(DataSet: TDataSet);
begin
  inherited;
//  CdsCadastro.FieldByName('BAIRRO').ProviderFlags := [];
//  CdsCadastro.FieldByName('CEP').ProviderFlags := [];
//  CdsCadastro.FieldByName('CIDADE').ProviderFlags := [];
////  CdsCadastro.FieldByName('UF').ProviderFlags := [];
//  CdsCadastro.FieldByName('LOGRADOURO').ProviderFlags := [];
  FormataMascara(CdsCadastro.FieldByName('CNPJ'),tcCNPJ);
end;

procedure TfrmLst_Empresa.CdsCadastroAfterPost(DataSet: TDataSet);
begin
  inherited;
  SetRegistros(CdsLimiteReceitaBruta,tpERPLimiteReceitaBruta);
  SetRegistros(CdsDocumentos,tpERPNumeracaoNotaSaida);
end;

procedure TfrmLst_Empresa.CdsCadastroAfterScroll(DataSet: TDataSet);
begin
  inherited;
  SetCds(CdsLimiteReceitaBruta,tpERPLimiteReceitaBruta,'idempresa= '+TipoCampoChaveToStr(ValorChave));
  SetCds(CdsDocumentos,tpERPNumeracaoNotaSaida,'idempresa= '+TipoCampoChaveToStr(ValorChave));
end;

procedure TfrmLst_Empresa.CdsDocumentosBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  if ConfirmaDel then
  begin
    MudaEstado;
    CdsDocumentos.Edit;
    CdsDocumentos.FieldByName('FLAGEDICAO').AsString :='D';
    CdsDocumentos.Post;
  end;
  Abort;
end;

procedure TfrmLst_Empresa.CdsDocumentosBeforeEdit(DataSet: TDataSet);
begin
  inherited;
  MudaEstado;
end;

procedure TfrmLst_Empresa.CdsDocumentosBeforePost(DataSet: TDataSet);
begin
  inherited;
  if CdsDocumentos.FieldByName('FLAGEDICAO').Value = 'N' then
     CdsDocumentos.FieldByName('FLAGEDICAO').Value := 'E';
end;

procedure TfrmLst_Empresa.CdsDocumentosNewRecord(DataSet: TDataSet);
begin
  inherited;
  MudaEstado;
  CdsDocumentos.FieldByName('idempresa').Value := ValorChave;
  CdsDocumentos.FieldByName('flagedicao').Value := 'I';
  CdsDocumentos.FieldByName('IDNUMERACAONOTASAIDA').Value := GetCodigo(tpERPNumeracaoNotaSaida);
  CdsDocumentos.FieldByName('Serie').Value := '0';
  CdsDocumentos.FieldByName('NUMEROATUAL').Value := 0;
end;

procedure TfrmLst_Empresa.CdsLimiteReceitaBrutaAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FormataMascara(CdsLimiteReceitaBruta.FieldByName('valor'), tcMoeda);
end;

procedure TfrmLst_Empresa.CdsLimiteReceitaBrutaBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  if ConfirmaDel then
  begin
    MudaEstado;
    CdsLimiteReceitaBruta.Edit;
    CdsLimiteReceitaBruta.FieldByName('FLAGEDICAO').AsString :='D';
    CdsLimiteReceitaBruta.Post;
  end;
  Abort;

end;

procedure TfrmLst_Empresa.CdsLimiteReceitaBrutaBeforeEdit(DataSet: TDataSet);
begin
  inherited;
  MudaEstado;
end;

procedure TfrmLst_Empresa.CdsLimiteReceitaBrutaBeforePost(DataSet: TDataSet);
begin
  inherited;
  if CdsLimiteReceitaBruta.FieldByName('FLAGEDICAO').Value = 'N' then
     CdsLimiteReceitaBruta.FieldByName('FLAGEDICAO').Value := 'E';
end;

procedure TfrmLst_Empresa.CdsLimiteReceitaBrutaNewRecord(DataSet: TDataSet);
begin
  inherited;
  MudaEstado;
  CdsLimiteReceitaBruta.FieldByName('IDLIMITERECEITABRUTA').Value := GetCodigo(tpERPLimiteReceitaBruta);
  CdsLimiteReceitaBruta.FieldByName('IDEMPRESA').Value := ValorChave;
  CdsLimiteReceitaBruta.FieldByName('FLAGEDICAO').Value := 'I';

end;

procedure TfrmLst_Empresa.edtCEPRegAchado(
  const ValoresCamposEstra: array of Variant);
begin
  inherited;
  with getCds(GetSelect(tpERPCEP,'idcep = '+TipoCampoChaveToStr(edtCEP.ValorChaveString))) do
  Begin
    edtBairro.Text := FieldByName('BAIRRO').AsString;
    edtCidade.Text := FieldByName('CIDADE').AsString;
    edtUf.Text :=     FieldByName('UF').AsString;
    edtMunicipio.ValorChave := FieldByName('IDMUNICIPIO').Value;
    edtMunicipio.Localiza;
    Free;
  End;
end;

procedure TfrmLst_Empresa.edtCEPRegNaoAchado(ADataSet: TDataSet;
  Sender: TObject);
begin
  inherited;
  edtBairro.Clear;
  edtCidade.Clear;
  edtUf.Clear;
end;


procedure TfrmLst_Empresa.FormCreate(Sender: TObject);
begin
  inherited;
  TipoPesquisa := tperpEmpresa;
  CriaColuna('CODIGO','Código');
  CriaColuna('RAZAOSOCIAL','Razão social',120);
  ConfiguraEditPesquisa(edtCEP,CdsCadastro,tpERPCEP,True, 'LOGRADOURO','CEP','CEP','IDCEP',8);
  ConfiguraEditPesquisa(edtMunicipio,CdsCadastro,tpERPMunicpio,True);

end;

procedure TfrmLst_Empresa.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  CdsCadastro.FieldByName('LOGOMARCA').Clear;
end;

procedure TfrmLst_Empresa.SpeedButton2Click(Sender: TObject);
begin
  inherited;
  if OPen.Execute then
    TBlobField(CdsCadastro.FieldByName('LOGOMARCA')).LoadFromFile(Open.FileName);
end;

end.
