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
    DataEstados: TDataSource;
    DataMunicipio: TDataSource;
    DataCodMinicipal: TDataSource;
    CdsEstados: TpFIBClientDataSet;
    CdsMunicipio: TpFIBClientDataSet;
    CdsCodMunicipal: TpFIBClientDataSet;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    cxGrid1: TcxGrid;
    TvEstados: TcxGridDBTableView;
    TvEstadosUF: TcxGridDBColumn;
    TvEstadosNOME: TcxGridDBColumn;
    TvMunicipios: TcxGridDBTableView;
    TvMunicipiosIBGE: TcxGridDBColumn;
    TvMunicipiosNOME: TcxGridDBColumn;
    TvTRibutos: TcxGridDBTableView;
    TvTRibutosColumn1: TcxGridDBColumn;
    TvTRibutosIDCODIGOMUNICIPALSERVICO: TcxGridDBColumn;
    TvTRibutosALIQISS: TcxGridDBColumn;
    vTRibutosColumn1: TcxGridDBColumn;
    vTRibutosColumn2: TcxGridDBColumn;
    vTRibutosColumn3: TcxGridDBColumn;
    vTRibutosColumn4: TcxGridDBColumn;
    vTRibutosColumn5: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    cxGrid2DBTableView1: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    cxGrid2: TcxGrid;
    cxGrid3: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cxGrid2DBTableView1Column1: TcxGridDBColumn;
    cxGrid2DBTableView1Column2: TcxGridDBColumn;
    cxGridDBTableView1Column1: TcxGridDBColumn;
    cxGridDBTableView1Column2: TcxGridDBColumn;
    cxGridDBTableView1Column3: TcxGridDBColumn;
    cxGridDBTableView1Column4: TcxGridDBColumn;
    cxGridDBTableView1Column5: TcxGridDBColumn;
    cxGridDBTableView1Column6: TcxGridDBColumn;
    cxGridDBTableView1Column7: TcxGridDBColumn;
    cxGridDBTableView1Column8: TcxGridDBColumn;
    cxGridDBTableView1Column9: TcxGridDBColumn;
    procedure CdsCodMunicipalNewRecord(DataSet: TDataSet);
    procedure CdsCodMunicipalAfterPost(DataSet: TDataSet);
    procedure CdsCodMunicipalAfterOpen(DataSet: TDataSet);
    procedure CdsEstadosAfterScroll(DataSet: TDataSet);
    procedure CdsMunicipioAfterScroll(DataSet: TDataSet);
    procedure CdsCodMunicipalBeforeDelete(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    Procedure AtualizaDataSets;
  public
    { Public declarations }
  end;

var
  frmAliqISS: TfrmAliqISS;

implementation

uses UDmConexao, Comandos, MinhasClasses, uPesquisa_kimera, uLibERP, uAguarde;

{$R *.dfm}

procedure TfrmAliqISS.AtualizaDataSets;
begin
  Try
    frmAguarde.Ativar;
    CdsEstados.DisableControls;
    CdsMunicipio.DisableControls;
    CdsEstados.AfterScroll := nil;
    CdsMunicipio.AfterScroll := nil;

    SetCds(CdsEstados, 'Select * from vw_uf');
    SetCds(CdsMunicipio,tpERPMunicpio,'');
    SetCds(CdsCodMunicipal,tpERPISS,'');

  Finally
    CdsEstados.AfterScroll := CdsEstadosAfterScroll;
    CdsMunicipio.AfterScroll := CdsMunicipioAfterScroll;
    CdsEstados.EnableControls;
    CdsMunicipio.EnableControls;
    frmAguarde.Desativar;
  End;
end;

procedure TfrmAliqISS.CdsCodMunicipalAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FormataMascara(CdsCodMunicipal.FieldByName('ALIQISS'),tcPercent);
  FormataMascara(CdsCodMunicipal.FieldByName('ALIQPIS'),tcPercent);
  FormataMascara(CdsCodMunicipal.FieldByName('ALIQCOFINS'),tcPercent);
  FormataMascara(CdsCodMunicipal.FieldByName('ALIQCSLL'),tcPercent);
  FormataMascara(CdsCodMunicipal.FieldByName('VALORMINIMOTRIBFEDERAL'),tcMoeda);
  FormataMascara(CdsCodMunicipal.FieldByName('VALORMINIMOIR'),tcMoeda);

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

procedure TfrmAliqISS.CdsCodMunicipalBeforeDelete(DataSet: TDataSet);
var
  SPMunicipio, SPEstado: TBookmark;
begin
  inherited;
  if ConfirmaDel then
  begin
    Try
      SPMunicipio:= CdsMunicipio.GetBookmark;
      SPEstado := CdsEstados.GetBookmark;
      CdsCodMunicipal.DisableControls;
      CdsMunicipio.DisableControls;
      CdsEstados.DisableControls;
      try
        StartTrans;
        AlteraBanco(taDeleta,CdsCodMunicipal,tperpISS);
        Commit;
        AtualizaDataSets;
        CdsEstados.GotoBookmark(SPEstado);
        CdsMunicipio.GotoBookmark(SPMunicipio);
      except
        on E: Exception do
        begin
          RollBack;
          Raise;
        end;
      end;
    Finally
      CdsCodMunicipal.EnableControls;
      CdsMunicipio.FreeBookmark(SPMunicipio);
      CdsEstados.FreeBookmark(SPEstado);
      CdsMunicipio.EnableControls;
      CdsEstados.EnableControls;
    End;

    Abort;
  end;

end;

procedure TfrmAliqISS.CdsCodMunicipalNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsCodMunicipal.FieldByName('IDISS').Value := GetCodigo(tperpISS);
  CdsCodMunicipal.FieldByName('IDMUNICIPIO').Value := CdsMunicipio.FieldByName('IDMUNICIPIO').Value ;
  CdsCodMunicipal.FieldByName('ALIQPIS').Value := 0.65;
  CdsCodMunicipal.FieldByName('ALIQCOFINS').Value := 3;
  CdsCodMunicipal.FieldByName('ALIQCSLL').Value := 1;
  CdsCodMunicipal.FieldByName('VALORMINIMOTRIBFEDERAL').Value := 5000;
  CdsCodMunicipal.FieldByName('VALORMINIMOIR').Value := 10;
  CdsCodMunicipal.FieldByName('ALIQIR').Value := 1.5;


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

procedure TfrmAliqISS.CdsEstadosAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if CdsMunicipio.Active then
  begin
    Try
      CdsMunicipio.DisableControls;
      CdsMunicipio.Filter :='UF = '+QuotedStr(CdsEstados.FieldByName('UF').AsString);
      CdsMunicipio.Filtered := True;
    Finally
      CdsMunicipio.EnableControls;
    End;
  end;

end;

procedure TfrmAliqISS.CdsMunicipioAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if CdsCodMunicipal.Active then
  begin
    Try
      CdsCodMunicipal.DisableControls;
      CdsCodMunicipal.Filter := 'IDMUNICIPIO  = '+TipoCampoChaveToStr(CdsMunicipio.FieldByName('IDMUNICIPIO').AsString);
      CdsCodMunicipal.Filtered := True;
    Finally
      CdsCodMunicipal.EnableControls;
    End;
  end;

end;

procedure TfrmAliqISS.FormShow(Sender: TObject);
begin
  inherited;
  AtualizaDataSets;
  CdsEstados.First;
end;

end.
