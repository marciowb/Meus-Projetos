unit uCad_Patrimonio;

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
  ExtCtrls, StdCtrls, Mask, DBCtrls, LabelDBEdit, EditPesquisa, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxDBEdit, cxSplitter, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid;

type
  TfrmCad_Patrimonio = class(TfrmCad_CadastroPaiERP)
    Panel2: TPanel;
    edtCodigo: TLabelDBEdit;
    LabelDBEdit1: TLabelDBEdit;
    LabelDBEdit3: TLabelDBEdit;
    LabelDBEdit2: TLabelDBEdit;
    edtTipoPatrimonio: TEditPesquisa;
    edtContador: TLabelDBEdit;
    edtUnidadeContador: TEdit;
    edtFabricante: TEditPesquisa;
    GroupBox1: TGroupBox;
    cxDBDateEdit1: TcxDBDateEdit;
    Label1: TLabel;
    LabelDBEdit4: TLabelDBEdit;
    edtEmpresa: TEditPesquisa;
    edtNCM: TEditPesquisa;
    DBCheckBox1: TDBCheckBox;
    GroupBox2: TGroupBox;
    DBMemo1: TDBMemo;
    cxTabSheet1: TcxTabSheet;
    GroupBox3: TGroupBox;
    CdsEventosTipoPatrimonio: TpFIBClientDataSet;
    DataEventos: TDataSource;
    cxGrid1: TcxGrid;
    TvEventos: TcxGridDBTableView;
    vEventosColumn1: TcxGridDBColumn;
    vEventosColumn2: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    LabelDBEdit5: TLabelDBEdit;
    procedure edtTipoPatrimonioBtnNovoClick(Sender: TObject);
    procedure edtTipoPatrimonioBtnEditarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtFabricanteBtnNovoClick(Sender: TObject);
    procedure CdsCadastroAfterPost(DataSet: TDataSet);
    procedure CdsEventosTipoPatrimonioNewRecord(DataSet: TDataSet);
    procedure CdsEventosTipoPatrimonioBeforeDelete(DataSet: TDataSet);
    procedure CdsEventosTipoPatrimonioBeforePost(DataSet: TDataSet);
    procedure TvEventosNavigatorButtonsButtonClick(Sender: TObject;
      AButtonIndex: Integer; var ADone: Boolean);
    procedure FormShow(Sender: TObject);
    procedure edtTipoPatrimonioRegAchado(
      const ValoresCamposEstra: array of Variant);
    procedure edtNCMBtnNovoClick(Sender: TObject);
    procedure actGravarExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCad_Patrimonio: TfrmCad_Patrimonio;

implementation

uses uForms, MinhasClasses, Comandos, uLibERP;

{$R *.dfm}

procedure TfrmCad_Patrimonio.actGravarExecute(Sender: TObject);
begin
  Try
    edtTipoPatrimonio.OnRegAchado := nil;
    inherited;
  Finally
    edtTipoPatrimonio.OnRegAchado := edtTipoPatrimonioRegAchado;
  End;

end;

procedure TfrmCad_Patrimonio.CdsCadastroAfterPost(DataSet: TDataSet);
begin
  inherited;
  SetRegistros(CdsEventosTipoPatrimonio,tpERPPatrimoniosEventos);
end;

procedure TfrmCad_Patrimonio.CdsEventosTipoPatrimonioBeforeDelete(
  DataSet: TDataSet);
begin
  inherited;
  MudaEstado;
  CdsEventosTipoPatrimonio.Edit;
  CdsEventosTipoPatrimonio.FieldByName('FLAGEDICAO').Value := 'D';
  CdsEventosTipoPatrimonio.Post;
  Abort;
end;

procedure TfrmCad_Patrimonio.CdsEventosTipoPatrimonioBeforePost(
  DataSet: TDataSet);
begin
  inherited;
  if CdsEventosTipoPatrimonio.FieldByName('FLAGEDICAO').Value = 'N' then
    CdsEventosTipoPatrimonio.FieldByName('FLAGEDICAO').Value := 'E';
end;

procedure TfrmCad_Patrimonio.CdsEventosTipoPatrimonioNewRecord(
  DataSet: TDataSet);
begin
  inherited;
  CdsEventosTipoPatrimonio.FieldByName('IDPATRIMONIOEVENTO').Value := GetCodigo(tpERPPatrimoniosEventos);
  CdsEventosTipoPatrimonio.FieldByName('FLAGEDICAO').Value :='I';
  CdsEventosTipoPatrimonio.FieldByName('IDPATRIMONIO').Value := ValorChave;
end;

procedure TfrmCad_Patrimonio.edtFabricanteBtnNovoClick(Sender: TObject);
begin
  inherited;
  TrotinasForms.AbreCadastroFabricante(toIncluir);
end;

procedure TfrmCad_Patrimonio.edtNCMBtnNovoClick(Sender: TObject);
begin
  inherited;
  TrotinasForms.AbreCadastroNCM(toIncluir);
end;

procedure TfrmCad_Patrimonio.edtTipoPatrimonioBtnEditarClick(Sender: TObject);
begin
  inherited;
  TrotinasForms.AbreCadastroTipoPatrimonio(toEditar);
end;

procedure TfrmCad_Patrimonio.edtTipoPatrimonioBtnNovoClick(Sender: TObject);
begin
  inherited;
  TrotinasForms.AbreCadastroTipoPatrimonio(toIncluir);
end;

procedure TfrmCad_Patrimonio.edtTipoPatrimonioRegAchado(
  const ValoresCamposEstra: array of Variant);
begin
  inherited;
  edtUnidadeContador.Text := ValoresCamposEstra[0];
  SetCds(CdsEventosTipoPatrimonio,tpERPPatrimoniosEventos,' IDTIPOPATRIMONIO = '+TipoCampoChaveToStr(edtTipoPatrimonio.ValorChave)+
                                                          ' AND ((IDPATRIMONIO= '+TipoCampoChaveToStr(ValorChave)+')OR (IDPATRIMONIO IS NULL))');
end;

procedure TfrmCad_Patrimonio.FormCreate(Sender: TObject);
begin
  inherited;
  TipoPesquisa :=tpERPPatrimonio;
end;

procedure TfrmCad_Patrimonio.FormShow(Sender: TObject);
begin
  inherited;
  ConfiguraEditPesquisa(edtFabricante,CdsCadastro,tpERPFabricante);
  ConfiguraEditPesquisa(edtEmpresa,CdsCadastro,tpERPEmpresa,True);
  ConfiguraEditPesquisa(edtNCM,CdsCadastro,tpERPNCM);
  edtNCM.AutoCompletar := False;
  edtTipoPatrimonio.CamposExtraPesquisa := '(SELECT U.NOMEUNIDADE FROM UNIDADE U  WHERE U.IDUNIDADE = TIPOPATRIMONIO.IDUNIDADECONTADOR) UNIDADE';
  ConfiguraEditPesquisa(edtTipoPatrimonio,CdsCadastro,tpERPTipoPatrimonio);
end;

Procedure TfrmCad_Patrimonio.TvEventosNavigatorButtonsButtonClick(
  Sender: TObject; AButtonIndex: Integer; var ADone: Boolean);
begin
  inherited;
  if AButtonIndex = 6 then
  begin
    MudaEstado;
    AdicionaListaPesquisa(CdsEventosTipoPatrimonio,tpERPTipoEventos,'Esse evento já foi adicionado');
    ADone:= True;
  end;
end;

end.
