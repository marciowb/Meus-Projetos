unit uCad_CFOP;

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
  ExtCtrls, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, StdCtrls, DBCtrls, Mask, LabelDBEdit,
  FIBDataSet, pFIBDataSet, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid;

type
  TfrmCad_CFOP = class(TfrmCad_CadastroPaiERP)
    edtCFOP: TLabelDBEdit;
    LabelDBEdit2: TLabelDBEdit;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    cxDBLookupComboBox1: TcxDBLookupComboBox;
    DBRadioGroup1: TDBRadioGroup;
    DBCheckBox5: TDBCheckBox;
    DBCheckBox6: TDBCheckBox;
    Label1: TLabel;
    dsCST_PIS_COFINS: TpFIBDataSet;
    DataCST_PIS_COFINS: TDataSource;
    DataCST_CFOP: TDataSource;
    cdsCST_CFOP: TpFIBClientDataSet;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    GroupBox1: TGroupBox;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    cxGrid1: TcxGrid;
    TvCST_CFOP: TcxGridDBTableView;
    vCST_CFOPColumn1: TcxGridDBColumn;
    vCST_CFOPColumn2: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    cxTabSheet2: TcxTabSheet;
    Panel4: TPanel;
    SpeedButton3: TSpeedButton;
    SpeedButton5: TSpeedButton;
    cxGrid2: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    DataCFOPSemelhante: TDataSource;
    cxGridDBTableView1Column1: TcxGridDBColumn;
    cxGridDBTableView1Column2: TcxGridDBColumn;
    CdsCFOPSemelhante: TpFIBClientDataSet;
    cxTabSheet3: TcxTabSheet;
    Panel5: TPanel;
    SpeedButton15: TSpeedButton;
    SpeedButton16: TSpeedButton;
    cxGrid3: TcxGrid;
    cxGridDBTableView2: TcxGridDBTableView;
    cxGridLevel2: TcxGridLevel;
    DataCSOSN_CFOP: TDataSource;
    CdsCSOSN_CFOP: TpFIBClientDataSet;
    cxGridDBTableView2Column1: TcxGridDBColumn;
    cxGridDBTableView2Column2: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure actGravarExecute(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure cdsCST_CFOPNewRecord(DataSet: TDataSet);
    procedure SpeedButton2Click(Sender: TObject);
    procedure CdsCadastroAfterPost(DataSet: TDataSet);
    procedure CdsCadastroAfterScroll(DataSet: TDataSet);
    procedure cdsCST_CFOPBeforePost(DataSet: TDataSet);
    procedure CdsCFOPSemelhanteNewRecord(DataSet: TDataSet);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure cxGridDBTableView1DblClick(Sender: TObject);
    procedure SpeedButton15Click(Sender: TObject);
    procedure SpeedButton16Click(Sender: TObject);
    procedure CdsCSOSN_CFOPNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCad_CFOP: TfrmCad_CFOP;

implementation

uses UDmConexao, MinhasClasses, Comandos, uLibERP;
{$R *.dfm}

procedure TfrmCad_CFOP.actGravarExecute(Sender: TObject);
begin
  inherited;
  dsCST_PIS_COFINS.OPen;
end;

procedure TfrmCad_CFOP.CdsCadastroAfterPost(DataSet: TDataSet);
begin
  inherited;
  SetRegistros(cdsCST_CFOP, tpERPCST_CFOP);
  SetRegistros(CdsCFOPSemelhante, tpERPCFOPSemelhante);
  SetRegistros(cdsCSOSN_CFOP, tpERPCSOSN_CFOP);
end;

procedure TfrmCad_CFOP.CdsCadastroAfterScroll(DataSet: TDataSet);
begin
  inherited;
  SetCds(cdsCST_CFOP, tpERPCST_CFOP, 'idcfop = ' + TipoCampoChaveToStr(ValorChave));
  SetCds(CdsCFOPSemelhante, tpERPCFOPSemelhante, 'idcfoppai = ' + TipoCampoChaveToStr(ValorChave));
  SetCds(cdsCSOSN_CFOP, tpERPCSOSN_CFOP, 'idcfop = ' + TipoCampoChaveToStr(ValorChave));
end;

procedure TfrmCad_CFOP.CdsCFOPSemelhanteNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsCFOPSemelhante.FieldByName('IDCFOPSEMELHANTE').Value := GetCodigo(tpERPCFOPSemelhante);
  CdsCFOPSemelhante.FieldByName('idCFOPPAI').Value := ValorChave;
  CdsCFOPSemelhante.FieldByName('FLAGEDICAO').Value := 'I';
end;

procedure TfrmCad_CFOP.CdsCSOSN_CFOPNewRecord(DataSet: TDataSet);
begin
  inherited;
  cdsCSOSN_CFOP.FieldByName('IDCFOPCSOSN').Value := GetCodigo(tpERPCST_CFOP);
  cdsCSOSN_CFOP.FieldByName('idCFOP').Value := ValorChave;
  cdsCSOSN_CFOP.FieldByName('FLAGEDICAO').Value := 'I';
end;

procedure TfrmCad_CFOP.cdsCST_CFOPBeforePost(DataSet: TDataSet);
begin
  inherited;
  cdsCST_CFOP.FieldByName('CST').Value := cdsCST_CFOP.FieldByName('ST').Value;
end;

procedure TfrmCad_CFOP.cdsCST_CFOPNewRecord(DataSet: TDataSet);
begin
  inherited;
  cdsCST_CFOP.FieldByName('IDCFOPCST').Value := GetCodigo(tpERPCST_CFOP);
  cdsCST_CFOP.FieldByName('idCFOP').Value := ValorChave;
  cdsCST_CFOP.FieldByName('FLAGEDICAO').Value := 'I';

end;

procedure TfrmCad_CFOP.cxGridDBTableView1DblClick(Sender: TObject);
begin
  inherited;
  if CdsCadastro.State <> dsBrowse then
  begin
    Avisa('Grave suas alterações antes de continuar');
    Exit;
  end;

  ValorChave := CdsCFOPSemelhante.FieldByName('idcfop').Value;
  SetValorChave(psIgual);

end;

procedure TfrmCad_CFOP.FormCreate(Sender: TObject);
begin
  inherited;
  TipoPesquisa := tpERPCFOP;
  dsCST_PIS_COFINS.OPen;
end;

procedure TfrmCad_CFOP.SpeedButton15Click(Sender: TObject);
begin
  inherited;
  MudaEstado;
  AdicionaListaPesquisa(CdsCSOSN_CFOP, tpERPCSOSN, 'Esse CSOSN já foi adicionado');
end;

procedure TfrmCad_CFOP.SpeedButton16Click(Sender: TObject);
begin
  inherited;
  if ConfirmaDel then
  BEGIN
    MudaEstado;
    cdsCSOSN_CFOP.Edit;
    cdsCSOSN_CFOP.FieldByName('flagedicao').AsString := 'D';
    cdsCSOSN_CFOP.Post;
  END;
end;

procedure TfrmCad_CFOP.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  MudaEstado;
  AdicionaListaPesquisa(cdsCST_CFOP, tpERPST, 'Esse CST já foi adicionado');
end;

procedure TfrmCad_CFOP.SpeedButton2Click(Sender: TObject);
begin
  inherited;
  if ConfirmaDel then
  BEGIN
    MudaEstado;
    cdsCST_CFOP.Edit;
    cdsCST_CFOP.FieldByName('flagedicao').AsString := 'D';
    cdsCST_CFOP.Post;
  END;
end;

procedure TfrmCad_CFOP.SpeedButton3Click(Sender: TObject);
begin
  inherited;
  MudaEstado;
  AdicionaListaPesquisa(CdsCFOPSemelhante, tpERPCFOPVisivel, 'Esse CFOP já foi adicionado');
end;

procedure TfrmCad_CFOP.SpeedButton5Click(Sender: TObject);
begin
  inherited;
  if ConfirmaDel then
  BEGIN
    MudaEstado;
    CdsCFOPSemelhante.Edit;
    CdsCFOPSemelhante.FieldByName('flagedicao').AsString := 'D';
    CdsCFOPSemelhante.Post;
  END;
end;

end.
