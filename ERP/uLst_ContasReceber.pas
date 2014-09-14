unit uLst_ContasReceber;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uListagemPadraoERP, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinsdxStatusBarPainter, dxSkinscxPCPainter, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, DBClient,
  pFIBClientDataSet, ActnList, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxPC,
  StdCtrls, Buttons, dxStatusBar, ExtCtrls,uLibERP;

type
  TfrmLst_ContasReceber = class(TfrmListagemPadraoERP)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FIdCliente: TipoCampoChave;
    FIdSaida: TipoCampoChave;
    FIdContratoCompetencia: TipoCampoChave;
    procedure SetIdCliente(const Value: TipoCampoChave);
    procedure SetIdSaida(const Value: TipoCampoChave);
    procedure SetIdContratoCompetencia(const Value: TipoCampoChave);
    { Private declarations }
  public
    { Public declarations }
    property IdCliente: TipoCampoChave read FIdCliente write SetIdCliente;
    property IdSaida: TipoCampoChave  read FIdSaida write SetIdSaida;
    property IdContratoCompetencia: TipoCampoChave read FIdContratoCompetencia write SetIdContratoCompetencia;
  end;

var
  frmLst_ContasReceber: TfrmLst_ContasReceber;

implementation

uses MinhasClasses, uCad_ContasReceber;

{$R *.dfm}

procedure TfrmLst_ContasReceber.FormCreate(Sender: TObject);
begin
  inherited;
  TipoPesquisa := tpERPContasReceber;
  CriaColuna('CODIGOEMPRESA','Empresa',60,tcString);
  CriaColuna('DATA','Data',80,tcCampoData);
  CriaColuna('NUMERODOCUMENTO','Nº documento',100,tcString);
  CriaColuna('CODIGOCLIENTE','Cód. Cliente',80,tcString);
  CriaColuna('NOMECLIENTE','Cliente',300,tcString);
  CriaColuna('DATAVENCIMENTO','Vencimento',100,tcCampoData);
  CriaColuna('VALOR','Valor',80,tcReal);
  CriaColuna('STATUS','Status',100,tcString);
  CriaColuna('NOMEPLANOCONTA','Plano de conta',200,tcString);
  CriaColuna('LOGIN','Usuário',100,tcString);
  CampoOrdem := 'CR.FLAGSTATUS, CR.DATAVENCIMENTO asc ,CR.IDCLIENTE';
  FIdCliente := SemID;
  FIdSaida := SemID;
  FIdContratoCompetencia := SemID;
end;

procedure TfrmLst_ContasReceber.FormShow(Sender: TObject);
begin
  inherited;
  Self.FormCadastro :=  frmCad_ContasReceber;
  Self.ClasseCadPai := TfrmCad_ContasReceber;
  Filtros := ' 1=1 ';
  if FIdCliente <> SemID then
    Filtros := Filtros+' and CR.IDCLIENTE  = '+TipoCampoChaveToStr(FIdCliente);
  if FIdSaida <> SemID then
    Filtros := Filtros+' and CR.IDSAIDA  = '+TipoCampoChaveToStr(FIdSaida);
  if FIdContratoCompetencia <> SemID then
    Filtros := Filtros+' and CR.IDCONTRATOCOMPETENCIA  = '+TipoCampoChaveToStr(FIdContratoCompetencia);

  AtuDados;
end;

procedure TfrmLst_ContasReceber.SetIdCliente(const Value: TipoCampoChave);
begin
  FIdCliente := Value;
end;

procedure TfrmLst_ContasReceber.SetIdContratoCompetencia(
  const Value: TipoCampoChave);
begin
  FIdContratoCompetencia := Value;
end;

procedure TfrmLst_ContasReceber.SetIdSaida(const Value: TipoCampoChave);
begin
  FIdSaida := Value;
end;

end.
