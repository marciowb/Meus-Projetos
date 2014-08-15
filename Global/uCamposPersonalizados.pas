unit uCamposPersonalizados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormPadrao, DB, DBCGrids, StdCtrls, DBCtrls, DBClient,
  pFIBClientDataSet, Mask, MinhasClasses, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxLookAndFeels, cxLookAndFeelPainters;

type
  TfrmCamposPersonalizados = class(TfrmPadrao)
    DataCampoPersonalizado: TDataSource;
    CdsCampos: TpFIBClientDataSet;
    GroupBox1: TGroupBox;
    cxGrid1: TcxGrid;
    TvCampos: TcxGridDBTableView;
    vCamposColumn1: TcxGridDBColumn;
    vCamposColumn2: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    procedure CdsCamposBeforePost(DataSet: TDataSet);
    procedure CdsCamposAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    FTipoPesquisa: TTipoPesquisa;
    procedure SetTipoPesquisa(const Value: TTipoPesquisa);
    { Private declarations }

  public
    { Public declarations }
    property TipoPesquisa : TTipoPesquisa read FTipoPesquisa write SetTipoPesquisa;
    Procedure Atualiza(ID : String);
  end;

var
  frmCamposPersonalizados: TfrmCamposPersonalizados;

implementation

uses  Comandos, uSQL;





{$R *.dfm}

{ TfrmCamposPersonalizados }


{ TfrmCamposPersonalizados }

procedure TfrmCamposPersonalizados.Atualiza(ID : String);
var
  StrSQL, wr : String;
begin
  inherited;
  Wr :=
    ' CR.ENTIDADEDESTINO = '+GetStr(GetTabela(TipoPesquisa))+
    '        AND CR.IDENTIDADEDESTINO = '+ ID;
 // StrSQL := GetSelect(tpAluguelCamposPersonalizadosRef, Wr);
  StrSQL := StringReplace(StrSQL, 'CR.ENTIDADEDESTINO', GetStr(GetTabela(TipoPesquisa))+' ENTIDADEDESTINO ', [rfIgnoreCase]);
  StrSQL := StringReplace(StrSQL, 'CR.IDENTIDADEDESTINO', ID+' IDENTIDADEDESTINO ', [rfIgnoreCase]);
  SetCds(CdsCampos, StrSQL);
end;

procedure TfrmCamposPersonalizados.CdsCamposAfterOpen(DataSet: TDataSet);
begin
  inherited;
  CdsCampos.FieldByName('NOMECAMPO').ProviderFlags := [];
  CdsCampos.FieldByName('FLAGTIPOCAMPO').ProviderFlags := [];
  CdsCampos.FieldByName('TAMANHO').ProviderFlags := [];
  CdsCampos.FieldByName('FLAGOBRIGATORIO').ProviderFlags := [];
  CdsCampos.FieldByName('FLAGEDICAO').ProviderFlags := [];
  CdsCampos.FieldByName('IDCAMPOREF').ProviderFlags := [];
end;

procedure TfrmCamposPersonalizados.CdsCamposBeforePost(DataSet: TDataSet);
 
begin
  inherited;
  
  if CdsCampos.FieldByName('IDCAMPOREF').IsNull then
    CdsCampos.FieldByName('FLAGEDICAO').AsString := 'I'
  else
     CdsCampos.FieldByName('FLAGEDICAO').AsString := 'E';
end;

procedure TfrmCamposPersonalizados.FormCreate(Sender: TObject);
begin
  inherited;
  TvCampos.OptionsView.Header := False;
end;

procedure TfrmCamposPersonalizados.SetTipoPesquisa(const Value: TTipoPesquisa);
begin
  FTipoPesquisa := Value;
end;

end.
