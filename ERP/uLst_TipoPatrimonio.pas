unit uLst_TipoPatrimonio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Lst_CadastroERP, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxTL, cxTLdxBarBuiltInMenu,
  DBClient, pFIBClientDataSet, Menus, ActnList, cxInplaceContainer, cxTLData,
  cxDBTL, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxPC, ComCtrls, ToolWin, StdCtrls,
  Buttons, Mask, DBCtrls, LabelDBEdit, cxSplitter, ExtCtrls, EditPesquisa;

type
  TfrmLst_TipoPatrimonio = class(TfrmLstCadastroSimplesERP)
    LabelDBEdit1: TLabelDBEdit;
    chkFLAGCONTROLACONTADOR: TDBCheckBox;
    edtUnidade: TEditPesquisa;
    GroupBox1: TGroupBox;
    TvEventos: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    DataEventos: TDataSource;
    CdsEventos: TpFIBClientDataSet;
    vEventosColumn1: TcxGridDBColumn;
    vEventosColumn2: TcxGridDBColumn;
    procedure CdsCadastroFLAGCONTROLACONTADORChange(Sender: TField);
    procedure FormShow(Sender: TObject);
    procedure CdsCadastroAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure chkFLAGCONTROLACONTADORClick(Sender: TObject);
    procedure edtUnidadeBtnNovoClick(Sender: TObject);
    procedure CdsCadastroNewRecord(DataSet: TDataSet);
    procedure CdsEventosNewRecord(DataSet: TDataSet);
    procedure CdsCadastroAfterScroll(DataSet: TDataSet);
    procedure CdsEventosBeforePost(DataSet: TDataSet);
    procedure CdsEventosBeforeDelete(DataSet: TDataSet);
    procedure TvEventosNavigatorButtonsButtonClick(Sender: TObject;
      AButtonIndex: Integer; var ADone: Boolean);
    procedure CdsCadastroAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLst_TipoPatrimonio: TfrmLst_TipoPatrimonio;

implementation

uses MinhasClasses, Comandos, uForms, uLibERP;

{$R *.dfm}

procedure TfrmLst_TipoPatrimonio.CdsCadastroAfterOpen(DataSet: TDataSet);
begin
  inherited;
  CdsCadastro.FieldByName('FLAGCONTROLACONTADOR').OnChange := CdsCadastroFLAGCONTROLACONTADORChange;
end;

procedure TfrmLst_TipoPatrimonio.CdsCadastroAfterPost(DataSet: TDataSet);
begin
  inherited;
  SetRegistros(CdsEventos, tpERPTipoPatrimonioTipoEventos);
end;

procedure TfrmLst_TipoPatrimonio.CdsCadastroAfterScroll(DataSet: TDataSet);
begin
  inherited;
  SetCds(CdsEventos,tpERPTipoPatrimonioTipoEventos,'IDTIPOPATRIMONIO = '+TipoCampoChaveToStr(CdsCadastro.FieldByName('IDTIPOPATRIMONIO').Value));
end;

procedure TfrmLst_TipoPatrimonio.CdsCadastroFLAGCONTROLACONTADORChange(
  Sender: TField);
begin
  inherited;
  edtUnidade.Enabled := chkFLAGCONTROLACONTADOR.Checked;
end;

procedure TfrmLst_TipoPatrimonio.CdsCadastroNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsCadastro.FieldByName('FLAGCONTROLACONTADOR').AsString := 'N';
end;

procedure TfrmLst_TipoPatrimonio.CdsEventosBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  MudaEstado;
  CdsEventos.Edit;
  CdsEventos.FieldByName('FLAGEDICAO').Value := 'D';
  CdsEventos.Post;
  Abort;
end;

procedure TfrmLst_TipoPatrimonio.CdsEventosBeforePost(DataSet: TDataSet);
begin
  inherited;
  if CdsEventos.FieldByName('FLAGEDICAO').Value = 'N' then
    CdsEventos.FieldByName('FLAGEDICAO').Value := 'E';
end;

procedure TfrmLst_TipoPatrimonio.CdsEventosNewRecord(DataSet: TDataSet);
begin
  inherited;
  MudaEstado;
  CdsEventos.FieldByName('IDTIPOPATRIMONIOTIPOEVENTO').Value := GetCodigo(tpERPTipoPatrimonioTipoEventos);
  CdsEventos.FieldByName('IDTIPOPATRIMONIO').Value := CdsCadastro.FieldByName('IDTIPOPATRIMONIO').Value;
  CdsEventos.FieldByName('FLAGEDICAO').Value := 'I';


end;

procedure TfrmLst_TipoPatrimonio.chkFLAGCONTROLACONTADORClick(Sender: TObject);
begin
  inherited;
  CdsCadastroFLAGCONTROLACONTADORChange(CdsCadastro.FieldByName('FLAGCONTROLACONTADOR'));
end;

procedure TfrmLst_TipoPatrimonio.edtUnidadeBtnNovoClick(Sender: TObject);
begin
  inherited;
  TrotinasForms.AbreCadastroUnidade(toIncluir);
end;

procedure TfrmLst_TipoPatrimonio.FormCreate(Sender: TObject);
begin
  inherited;
  TipoPesquisa := tpERPTipoPatrimonio;
  CriaColuna('CODIGO','Código');
  CriaColuna('NOMETIPOPATRIMONIO','Descrição',150);
end;

procedure TfrmLst_TipoPatrimonio.FormShow(Sender: TObject);
begin
  inherited;
  ConfiguraEditPesquisa(edtUnidade,CdsCadastro,tpERPUnidade,False,'','','codigo','IDUNIDADECONTADOR');

end;

procedure TfrmLst_TipoPatrimonio.TvEventosNavigatorButtonsButtonClick(
  Sender: TObject; AButtonIndex: Integer; var ADone: Boolean);
begin
  inherited;
  if AButtonIndex = 6 then
  begin
    AdicionaListaPesquisa(CdsEventos,tpERPTipoEventos,'Esse evento já foi adicionado');
    ADone:= True;
  end;
end;

end.
