unit uTabelaPreco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormPadrao, DB, DBClient, pFIBClientDataSet, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxClasses, cxCustomData, cxStyles,
  cxEdit, cxCustomPivotGrid, cxDBPivotGrid, cxFilter, cxData, cxDataStorage,
  cxDBData, cxGridBandedTableView, cxGridDBBandedTableView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxGridCustomView, cxGrid;

type
  TfrmTabelaPreco = class(TfrmPadrao)
    DataPreco: TDataSource;
    CdsPreco: TpFIBClientDataSet;
    TvPreco: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    TvPrecoNOMETIPOSERVICO: TcxGridDBColumn;
    TvPrecoNOMECATEGORIAANIMAL: TcxGridDBColumn;
    TvPrecoPRECO: TcxGridDBColumn;
    vPrecoColumn1: TcxGridDBColumn;
    procedure CdsPrecoBeforePost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure CdsPrecoAfterOpen(DataSet: TDataSet);
    procedure CdsPrecoAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
    Procedure AtuDados(Id: Integer = -1);
  public
    { Public declarations }
  end;

var
  frmTabelaPreco: TfrmTabelaPreco;

implementation

uses UDmConexao, Comandos, MinhasClasses;

{$R *.dfm}

procedure TfrmTabelaPreco.AtuDados(Id: Integer = -1);
begin
  inherited;
  Try
    CdsPreco.DisableControls;
    SetCds(CdsPreco,tpPetPrecoServico,'');
  Finally
    if ID <> -1 then
      CdsPreco.Locate('IDPRECOSERVICO',ID,[]);
    CdsPreco.EnableControls;
    TvPreco.ViewData.Expand(True);
  End;

end;

procedure TfrmTabelaPreco.CdsPrecoAfterOpen(DataSet: TDataSet);
begin
  inherited;
  CdsPreco.FieldByName('CODIGO').ProviderFlags := [];
  CdsPreco.FieldByName('NOMETIPOSERVICO').ProviderFlags := [];
  CdsPreco.FieldByName('NOMECATEGORIAANIMAL').ProviderFlags := [];
  CdsPreco.FieldByName('IDTIPOANIMAL').ProviderFlags := [];
  CdsPreco.FieldByName('FLAGEDICAO').ProviderFlags := [];
  CdsPreco.FieldByName('NOMETIPOANIMAL').ProviderFlags := [];

  FormataMascara(CdsPreco.FieldByName('PRECO'),tcMoeda);
end;

procedure TfrmTabelaPreco.CdsPrecoAfterPost(DataSet: TDataSet);
var
  I: Integer;
begin
  inherited;
  try
    I := CdsPreco.FieldByName('IDPRECOSERVICO').AsInteger;
    StartTrans;
    SetRegistros(CdsPreco,tpPetPrecoServico);
    Commit;
  except
    on E: Exception do
    Begin
      RollBack;
      Raise;
    End;
  end;
  AtuDados(I);
end;

procedure TfrmTabelaPreco.CdsPrecoBeforePost(DataSet: TDataSet);
begin
  inherited;
  if CdsPreco.FieldByName('IDPRECOSERVICO').IsNull then
  Begin
    CdsPreco.FieldByName('FLAGEDICAO').AsString :='I';
    CdsPreco.FieldByName('IDPRECOSERVICO').AsInteger  := GetValSeq('SEQ_IDPRECOSERVICO');
  end else
    CdsPreco.FieldByName('FLAGEDICAO').AsString :='E';
  
end;

procedure TfrmTabelaPreco.FormCreate(Sender: TObject);
begin
  inherited;
  AtuDados;
end;

end.
