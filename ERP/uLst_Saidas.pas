unit uLst_Saidas;

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
  StdCtrls, Buttons, dxStatusBar, ExtCtrls,uLibErp,uClassesERP;

type
  TfrmLst_Saidas = class(TfrmListagemPadraoERP)
    actContasReceber: TAction;
    BitBtn11: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actNovoExecute(Sender: TObject);
    procedure actEditarExecute(Sender: TObject);
    procedure actContasReceberExecute(Sender: TObject);
  private
    FIdCliente: TipoCampoChave;
    FIdOS: TipoCampoChave;
    procedure SetIdCliente(const Value: TipoCampoChave);
    procedure SetIdOS(const Value: TipoCampoChave);
    { Private declarations }
  public
    { Public declarations }
    property IdCliente: TipoCampoChave read FIdCliente write SetIdCliente;
    property IdOS: TipoCampoChave read FIdOS write SetIdOS;
  end;

var
  frmLst_Saidas: TfrmLst_Saidas;

implementation

uses MinhasClasses, uForms;

{$R *.dfm}

procedure TfrmLst_Saidas.actContasReceberExecute(Sender: TObject);
begin
  inherited;
  TrotinasForms.AbreContasReceber(semid,CdsListagem.FieldByName('idsaida').Value);
end;

procedure TfrmLst_Saidas.actEditarExecute(Sender: TObject);
begin
  inherited;
  TrotinasForms.AbreVenda(CdsListagem.FieldByName('idsaida').Value);
end;

procedure TfrmLst_Saidas.actNovoExecute(Sender: TObject);
begin
//  inherited;
   TrotinasForms.AbreVenda;
end;

procedure TfrmLst_Saidas.FormCreate(Sender: TObject);
begin
  inherited;
  TipoPesquisa := tpERPSaida;
  CriaColuna('CODIGO_EMPRRESA','Empresa',80,tcString);
  CriaColuna('NUMEROSAIDA','Número',80,tcString);
  CriaColuna('DATA','Data',80,tcCampoData);
  CriaColuna('CODIGO_PESSOA','Código pessoa',100,tcString);
  CriaColuna('PESSOA','Pessoa',300,tcString);
  CriaColuna('NOMEOPERACAOESTOQUE','Operação',200,tcString);
  CriaColuna('NOMEFUNCIONARIO','Funcionário',100,tcString);
  CriaColuna('VALORTOTALNOTA','Total',100,tcReal);
  CriaColuna('STATUS_NOTA','Status',80,tcString);
  CriaColuna('USUARIO','Usuário',80,tcString);
  CampoOrdem := 'NUMEROSAIDA desc';
  IdCliente := SemID;
  FIdOS:= SemID;
end;

procedure TfrmLst_Saidas.FormShow(Sender: TObject);
begin
  inherited;
  Filtros := '';
  if IdCliente <> SemID then
    Filtros :='S.IDCLiente = '+TipoCampoChaveToStr(IdCliente);
  if IdOS <> SemID then
    Filtros :='S.IDOS = '+TipoCampoChaveToStr(IdOS);

  AtuDados;
end;

procedure TfrmLst_Saidas.SetIdCliente(const Value: TipoCampoChave);
begin
  FIdCliente := Value;
end;

procedure TfrmLst_Saidas.SetIdOS(const Value: TipoCampoChave);
begin
  FIdOS := Value;
end;

end.

