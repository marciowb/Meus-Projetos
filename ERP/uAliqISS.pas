unit uAliqISS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormPadrao, StdCtrls, Grids, DBGrids, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, DBClient, pFIBClientDataSet, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid;

type
  TfrmAliqISS = class(TfrmPadrao)
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    DataEstados: TDataSource;
    DataMunicipio: TDataSource;
    DataCodMinicipal: TDataSource;
    CdsEstados: TpFIBClientDataSet;
    CdsMunicipio: TpFIBClientDataSet;
    CdsCodMunicipal: TpFIBClientDataSet;
    cxGrid1DBTableView1UF: TcxGridDBColumn;
    cxGrid1DBTableView1NOME: TcxGridDBColumn;
    cxGrid1Level2: TcxGridLevel;
    cxGrid1DBTableView2: TcxGridDBTableView;
    cxGrid1DBTableView2IBGE: TcxGridDBColumn;
    cxGrid1DBTableView2NOME: TcxGridDBColumn;
    cxGrid1Level3: TcxGridLevel;
    cxGrid1DBTableView3: TcxGridDBTableView;
    cxGrid1DBTableView3IDCODIGOMUNICIPALSERVICO: TcxGridDBColumn;
    cxGrid1DBTableView3ALIQISS: TcxGridDBColumn;
    cxGrid1DBTableView3Column1: TcxGridDBColumn;
    procedure CdsCodMunicipalNewRecord(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure CdsCodMunicipalAfterPost(DataSet: TDataSet);
    procedure CdsCodMunicipalAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAliqISS: TfrmAliqISS;

implementation

uses UDmConexao, Comandos, MinhasClasses, uPesquisa_kimera;

{$R *.dfm}

procedure TfrmAliqISS.CdsCodMunicipalAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FormataMascara(CdsCodMunicipal.FieldByName('ALIQISS'),tcPercent);
end;

procedure TfrmAliqISS.CdsCodMunicipalAfterPost(DataSet: TDataSet);
begin
  inherited;
  Try
    CdsCodMunicipal.DisableControls;
    try
      StartTrans;
      AlteraBanco(taInsertOrUpdate,CdsCodMunicipal,tperpISS);
      Commit;
    except
      on E: Exception do
      begin
        RollBack;
        Raise;
      end;
    end;
  Finally
    CdsCodMunicipal.EnableControls;
  End;
end;

procedure TfrmAliqISS.CdsCodMunicipalNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsCodMunicipal.FieldByName('IDISS').Value := GetCodigo(tperpISS);
  CdsCodMunicipal.FieldByName('IDMUNICIPIO').Value := CdsMunicipio.FieldByName('IDMUNICIPIO').Value ;
  frmPesquisa := TfrmPesquisa.Create(nil);
  Try
    frmPesquisa.TipoPesquisa := tpERPCodigoMunicipalServico;
    if frmPesquisa.ShowModal = mrOk then
    begin
      CdsCodMunicipal.FieldByName('IDCODIGOMUNICIPALSERVICO').Value := frmPesquisa.cdsPesquisa.FieldValues['IDCODIGOMUNICIPALSERVICO'];
      CdsCodMunicipal.FieldByName('CODIGO').Value := frmPesquisa.cdsPesquisa.FieldValues['CODIGO'];
      CdsCodMunicipal.FieldByName('DESCRICAO').Value := frmPesquisa.cdsPesquisa.FieldValues['DESCRICAOCODIGOSERVICO'];
    end;

  Finally
    FreeAndNil(frmPesquisa);
  End;

end;

procedure TfrmAliqISS.FormCreate(Sender: TObject);
begin
  inherited;
  SetCds(CdsEstados, 'Select * from vw_uf');
  SetCds(CdsMunicipio,'select * from MUNICIPIO ');
  SetCds(CdsCodMunicipal,tpERPISS,'');
end;

end.
