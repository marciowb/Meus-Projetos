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
    procedure CdsListagemAfterScroll(DataSet: TDataSet);
    procedure actNovoExecute(Sender: TObject);
    procedure TvNotasNavigatorButtonsButtonClick(Sender: TObject;
      AButtonIndex: Integer; var ADone: Boolean);
    procedure CdsItensLoteNewRecord(DataSet: TDataSet);
    procedure TvNotasDblClick(Sender: TObject);
    procedure actExcluirExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure CarregarDados;
  end;

var
  frmLst_LoteNotas: TfrmLst_LoteNotas;

implementation

uses MinhasClasses, Comandos, uLibERP, uRegras, uClassesERP, uForms,
  uConstantes;

{$R *.dfm}

procedure TfrmLst_LoteNotas.actExcluirExecute(Sender: TObject);
begin
  if (CdsListagem.FieldByName('FLAGSTATUSNFE').AsString= StatusLoteDocumentosFiscaisSucesso) or
     (CdsListagem.FieldByName('FLAGSTATUSNFSE').AsString= StatusLoteDocumentosFiscaisSucesso)  then
  begin
    Avisa('Esse lote não pode ser excluido, pois já foi processado com sucesso');
    Exit;
  end;
  inherited;

end;

procedure TfrmLst_LoteNotas.actGerarDocumentosExecute(Sender: TObject);
var
  SP: TBookmark;
begin
  inherited;
  if  ((CdsListagem.FieldByName('FLAGSTATUSNFE').AsString= StatusLoteDocumentosFiscaisSucesso) and
       (CdsListagem.FieldByName('FLAGSTATUSNFSE').AsString= StatusLoteDocumentosFiscaisSucesso)) or
      ((CdsListagem.FieldByName('FLAGSTATUSNFE').AsString = '') and
       (CdsListagem.FieldByName('FLAGSTATUSNFSE').AsString= StatusLoteDocumentosFiscaisSucesso)) or
      ((CdsListagem.FieldByName('FLAGSTATUSNFE').AsString = StatusLoteDocumentosFiscaisSucesso) and
       (CdsListagem.FieldByName('FLAGSTATUSNFSE').AsString= ''))    then
  begin
    Avisa('Esse lote já foi processado com sucesso');
    Exit;
  end;
  Try
    SP := CdsListagem.GetBookmark;
    TRegrasLotesDocumentosFiscais.ProcessaLote(CdsListagem.FieldByName('IDLOTEDOCUMENTO').AsString,CdsListagem.FieldByName('NUMEROLOTE').AsString);
    Self.CarregarDados;
  Finally
    CdsListagem.GotoBookmark(SP);
    CdsListagem.FreeBookmark(Sp);
  End;

end;

procedure TfrmLst_LoteNotas.actNovoExecute(Sender: TObject);
begin
  inherited;
  TRegrasLotesDocumentosFiscais.NovoLote;
  Self.CarregarDados;
end;

procedure TfrmLst_LoteNotas.CarregarDados;
begin
  Try
    CdsItensLote.DisableControls;
    SetCds(CdsItensLote,tpERPItensLotesNota,'');
    AtuDados;

  Finally
    CdsItensLote.EnableControls;
  End;
end;

procedure TfrmLst_LoteNotas.CdsItensLoteNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsItensLote.FieldByName('IDLOTEDOCUMENTO').Value := CdsListagem.FieldByName('IDLOTEDOCUMENTO').Value;
  CdsItensLote.FieldByName('IDITENSLOTEDOCUMENTO').Value := GetCodigo(tpERPItensLotesNota);
  CdsItensLote.FieldByName('FLAGSTATUS').Value := 'A';
  CdsItensLote.FieldByName('STATUS').Value := 'AGUARDANDO';

end;

procedure TfrmLst_LoteNotas.CdsListagemAfterScroll(DataSet: TDataSet);
begin
  inherited;
  CdsItensLote.Filter := 'IDLOTEDOCUMENTO = '+TipoCampoChaveToStr(CdsListagem.FieldByName('IDLOTEDOCUMENTO').AsString);
  CdsItensLote.Filtered := True;
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
  CarregarDados;


end;

procedure TfrmLst_LoteNotas.TvNotasDblClick(Sender: TObject);
begin
  inherited;
  TrotinasForms.AbreVenda(CdsItensLote.FieldByName('idsaida').AsString);
end;

procedure TfrmLst_LoteNotas.TvNotasNavigatorButtonsButtonClick(Sender: TObject;
  AButtonIndex: Integer; var ADone: Boolean);
begin
  inherited;
  ADone := True;
  if AButtonIndex = 6 then // Insert
  begin
    Try
      AdicionaListaPesquisa(CdsItensLote,tpERPSaida,'Já existe essa nota nesse lote',['Data'],['Datasaida'],
                                '                      NOT EXISTS(SELECT 1 '+
                                '                     FROM ITENSLOTEDOCUMENTO I'+
                                '                    WHERE I.IDSAIDA = S.IDSAIDA '+
                                '                      AND COALESCE(I.FLAGSTATUS,''A'') <> ''S'' ) '+
                                '    AND NOT EXISTS(SELECT 1 '+
                                '                     FROM ITENSLOTEDOCUMENTO I'+
                                '                    INNER JOIN LOTEDOCUMENTO L  '+
                                '                       ON (L.IDLOTEDOCUMENTO = I.IDLOTEDOCUMENTO)'+
                                '                    WHERE I.IDSAIDA = S.IDSAIDA '+
                                '                      AND COALESCE(I.FLAGSTATUS,''A'') <> ''S'' '+
                                '                      AND COALESCE(L.FLAGSTATUSNFE,''X'') IN (''R'',''X'') '+
                                '                      AND COALESCE(L.FLAGSTATUSNFSE,''X'') IN (''R'',''X'')'+
                                '                      )'
                            );
      StartTrans;
      AlteraBanco(taInsere,CdsItensLote,tpERPItensLotesNota);
      Commit;
    except
      on e:Exception do
      begin
        RollBack;
        Raise;
      end;
    End;
  end;

  if (AButtonIndex = 8) and (ConfirmaDel) then // Delete
  begin
    try
      StartTrans;
      AlteraBanco(taDeleta,CdsItensLote,tpERPItensLotesNota);
      Commit;
      CdsItensLote.Delete;
    except
      on E: Exception do
      begin
        RollBack;
        Raise;
      end;
    end;
  end;


end;

end.
