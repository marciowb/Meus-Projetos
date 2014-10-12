unit uLst_ManutencaoPatrimonio;

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
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxTL, cxTLdxBarBuiltInMenu, Mask,
  EditPesquisa, DBClient, pFIBClientDataSet, Menus, ActnList,
  cxInplaceContainer, cxTLData, cxDBTL, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, cxPC, ComCtrls, ToolWin, StdCtrls, Buttons, DBCtrls, LabelDBEdit,
  cxSplitter, ExtCtrls, cxContainer, cxMemo, cxDBEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar,uLibERP;

type
  TfrmLst_ManutencaoPatrimonio = class(TfrmLstCadastroSimplesERP)
    edtFornecedor: TEditPesquisa;
    cxDBDateEdit1: TcxDBDateEdit;
    Label1: TLabel;
    LabelDBEdit1: TLabelDBEdit;
    edtPatrimonio: TEditPesquisa;
    edtNotaEntrada: TEditPesquisa;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxDBMemo1: TcxDBMemo;
    cxTabSheet2: TcxTabSheet;
    TvEventos: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    DataEventos: TDataSource;
    CdsEventos: TpFIBClientDataSet;
    vEventosColumn1: TcxGridDBColumn;
    vEventosColumn2: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtNotaEntradaRegAchado(
      const ValoresCamposEstra: array of Variant);
    procedure edtFornecedorRegAchado(
      const ValoresCamposEstra: array of Variant);
    procedure TvEventosNavigatorButtonsButtonClick(Sender: TObject;
      AButtonIndex: Integer; var ADone: Boolean);
    procedure CdsEventosNewRecord(DataSet: TDataSet);
    procedure CdsCadastroAfterPost(DataSet: TDataSet);
    procedure CdsCadastroAfterScroll(DataSet: TDataSet);
  private
    FIdPatrimonio: TipoCampoChave;
    procedure SetIdPatrimonio(const Value: TipoCampoChave);
    { Private declarations }
  public
    { Public declarations }
    property IdPatrimonio: TipoCampoChave read FIdPatrimonio write SetIdPatrimonio;
  end;

var
  frmLst_ManutencaoPatrimonio: TfrmLst_ManutencaoPatrimonio;

implementation

uses MinhasClasses, Comandos;

{$R *.dfm}

procedure TfrmLst_ManutencaoPatrimonio.CdsCadastroAfterPost(DataSet: TDataSet);
begin
  inherited;
  SetRegistros(CdsEventos,tpERPPatrimonioManutencaoTerceirosEventos);
end;

procedure TfrmLst_ManutencaoPatrimonio.CdsCadastroAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  SetCds(CdsEventos,tpERPPatrimonioManutencaoTerceirosEventos,'IDPATRIMONIOMANUTENCAO = '+TipoCampoChaveToStr(CdsCadastro.FieldByName('IDPATRIMONIOMANUTENCAO').Value));
end;

procedure TfrmLst_ManutencaoPatrimonio.CdsEventosNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsEventos.FieldByName('IDPATRIMONIOMANUTENCAOEVENTOS').Value := GetCodigo(tpERPPatrimonioManutencaoTerceirosEventos);
  CdsEventos.FieldByName('IDPATRIMONIOMANUTENCAO').Value := CdsCadastro.FieldByName('IDPATRIMONIOMANUTENCAO').Value;
  CdsEventos.FieldByName('FLAGEDICAO').Value := 'I';
end;

procedure TfrmLst_ManutencaoPatrimonio.edtFornecedorRegAchado(
  const ValoresCamposEstra: array of Variant);
begin
  inherited;
  edtNotaEntrada.SQLComp := 'IDFORNECEDOR = '+TipoCampoChaveToStr(edtFornecedor.ValorChave);
end;

procedure TfrmLst_ManutencaoPatrimonio.edtNotaEntradaRegAchado(
  const ValoresCamposEstra: array of Variant);
var
  StrSQL: String;
begin
  inherited;
  if CdsCadastro.State in [dsInsert] then
  begin
    StrSQL :=
      'SELECT EP.CONTADORPATRIMONIO,E.DATA '+
      '  FROM ENTRADA E '+
      ' INNER JOIN  ENTRADAPRODUTO EP '+
      '    ON (E.IDENTRADA = EP.IDENTRADA)'+
      ' WHERE E.IDENTRADA = '+TipoCampoChaveToStr(edtNotaEntrada.ValorChave)+
      '   AND EP.IDPATRIMONIO = '+TipoCampoChaveToStr(edtPatrimonio.ValorChave);
    WITH GetCds(StrSQL) do
    begin
      CdsCadastro.FieldByName('CONTADORPATRIMONIO').Value := FieldByName('CONTADORPATRIMONIO').Value;
      CdsCadastro.FieldByName('DATA').Value := FieldByName('DATA').Value;
      Free;
    end;
  end;

end;

procedure TfrmLst_ManutencaoPatrimonio.FormCreate(Sender: TObject);
begin
  inherited;
  TipoPesquisa:= tpERPPatrimonioManutencaoTerceiros;
  IdPatrimonio := SemID;
  CriaColuna('DATA','Data');
  CriaColuna('RAZAOSOCIAL','Fornecedor',200);
  CriaColuna('NUMERONOTA','Nota');

end;

procedure TfrmLst_ManutencaoPatrimonio.FormShow(Sender: TObject);
begin
  inherited;
  ConfiguraEditPesquisa(edtFornecedor,CdsCadastro,tpERPFornecedor, True);
  ConfiguraEditPesquisa(edtPatrimonio,CdsCadastro,tpERPPatrimonio, True);
  ConfiguraEditPesquisa(edtNotaEntrada,CdsCadastro,tpERPEntrada);
  if IdPatrimonio <> SemID then
  begin
    edtPatrimonio.ValorChave := IdPatrimonio ;
    edtPatrimonio.Localiza;
    edtPatrimonio.Enabled := False;
  end;
end;

procedure TfrmLst_ManutencaoPatrimonio.SetIdPatrimonio(
  const Value: TipoCampoChave);
begin
  FIdPatrimonio := Value;
end;

procedure TfrmLst_ManutencaoPatrimonio.TvEventosNavigatorButtonsButtonClick(
  Sender: TObject; AButtonIndex: Integer; var ADone: Boolean);
begin
  inherited;
  if AButtonIndex = 6 then
  begin
    MudaEstado;
    AdicionaListaPesquisa(CdsEventos,tpERPTipoEventos,'Esse evento já foi adicionado');
    ADone := True;
    Abort;
  end;
  if AButtonIndex = 7 then
  begin
    if not ConfirmaDel then
      Abort;
    MudaEstado;
    CdsEventos.Edit;
    CdsEventos.FieldByName('FLAGEDICAO').AsString := 'D';
    CdsEventos.Post;
    ADone := True;
    Abort;
  end;

end;

end.
