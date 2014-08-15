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
  StdCtrls, Buttons, dxStatusBar, ExtCtrls;

type
  TfrmLst_Saidas = class(TfrmListagemPadraoERP)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actNovoExecute(Sender: TObject);
    procedure actEditarExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLst_Saidas: TfrmLst_Saidas;

implementation

uses MinhasClasses, uForms;

{$R *.dfm}

procedure TfrmLst_Saidas.actEditarExecute(Sender: TObject);
begin
  inherited;
  TrotinasForms.AbreVenda(CdsListagem.FieldByName('idsaida').AsLargeInt);
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
end;

procedure TfrmLst_Saidas.FormShow(Sender: TObject);
begin
  inherited;
  AtuDados;
end;

end.

