unit uLst_LoteNotas;

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
  StdCtrls, Buttons, dxStatusBar, ExtCtrls, cxSplitter;

type
  TfrmLst_LoteNotas = class(TfrmListagemPadraoERP)
    GroupBox1: TGroupBox;
    cxSplitter1: TcxSplitter;
    TvNotas: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    cxGrid2: TcxGrid;
    DataItens: TDataSource;
    CdsItensLote: TpFIBClientDataSet;
    vNotasColumn1: TcxGridDBColumn;
    vNotasColumn2: TcxGridDBColumn;
    vNotasColumn3: TcxGridDBColumn;
    vNotasColumn4: TcxGridDBColumn;
    BitBtn11: TBitBtn;
    actGerarDocumentos: TAction;
    procedure FormCreate(Sender: TObject);
    procedure actGerarDocumentosExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLst_LoteNotas: TfrmLst_LoteNotas;

implementation

uses MinhasClasses;

{$R *.dfm}

procedure TfrmLst_LoteNotas.actGerarDocumentosExecute(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmLst_LoteNotas.FormCreate(Sender: TObject);
begin
  inherited;
  TipoPesquisa := tpERPLotesNota;
  CriaColuna('NUMEROLOTE','Lote',90,tcString);
  CriaColuna('DATAGERACAO','Data',90,tcCampoData);
  CriaColuna('HORAGERACAO','Hora',90,tcHora);
  CriaColuna('STATUSNFE','Status NF-e',100,tcString);
  CriaColuna('STATUSNFSE','Status NFS-e',100,tcString);
  CriaColuna('MSGERRONFE','Msg erro NF-e',300,tcString);
  CriaColuna('MSGERRONFSE','Msg erro NF-e',300,tcString);

end;

end.
