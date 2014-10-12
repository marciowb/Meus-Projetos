unit uALiqICMS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormPadrao, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxClasses, cxCustomData, cxStyles, cxEdit, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue,
  cxCustomPivotGrid, cxDBPivotGrid, ExtCtrls, DB, cxContainer, cxLabel,
  DBClient, pFIBClientDataSet, FIBDataSet, pFIBDataSet, cxCalc, StdCtrls;

type
  TfrmALiqICMS = class(TfrmPadrao)
    DataICMS: TDataSource;
    GridICMS: TcxDBPivotGrid;
    cxDBPivotGrid1ALIQICMS: TcxDBPivotGridField;
    cxDBPivotGrid1UFORIGEM: TcxDBPivotGridField;
    cxDBPivotGrid1UFDESTINO: TcxDBPivotGridField;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    CdsICMS: TpFIBClientDataSet;
    lblPos: TLabel;
    Panel1: TPanel;
    procedure DataSetICMSBeforeDelete(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure GridICMSDblClick(Sender: TObject);
    procedure CdsICMSAfterPost(DataSet: TDataSet);
    procedure GridICMSClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmALiqICMS: TfrmALiqICMS;

implementation

uses UDmConexao, Comandos, MinhasClasses;

{$R *.dfm}

procedure TfrmALiqICMS.CdsICMSAfterPost(DataSet: TDataSet);
begin
  inherited;
  Try
    StartTrans;
    AlteraBanco(taModifica,CdsICMS,tpERPICMS);
    Commit;
  Except
    on e: Exception do
    begin
      RollBack;
      Raise;
    end;
  End;
  SetCds(CdsICMS,tpERPICMS,'');
end;

procedure TfrmALiqICMS.GridICMSClick(Sender: TObject);
var
  UfOrigem,UFDestino: String;
  R: Array of Variant;
begin
  inherited;
  SetLength(R,2);
  GetValorCelulaSelecionadaPivotGrid(Sender as TcxDBPivotGrid, 'UFORIGEM','UFDESTINO',R);
  UfOrigem := R[0];
  UFDestino := R[1];
  lblPos.Caption := 'Origem: '+UfOrigem+' Destino: '+UFDestino;
end;

procedure TfrmALiqICMS.GridICMSDblClick(Sender: TObject);
Var
  Valor: String;
  UfOrigem,UFDestino: String;
  R: Array of Variant;
label
  Aliq;
begin
  inherited;

  Aliq:
  if InputQuery(Application.Title,'Informe a alíquota: ', Valor) then
  begin
    if StrToCurrDef(Valor,-1) < 0 then
    begin
      Avisa('Informe uma alíquota válida');
      goto Aliq;
    end;

  end;


  SetLength(R,2);
  GetValorCelulaSelecionadaPivotGrid(GridICMS, 'UFORIGEM','UFDESTINO',R);
  UfOrigem := R[0];
  UFDestino := R[1];

  CdsICMS.Locate('UFORIGEM;UFDESTINO', VarArrayOf([UfOrigem, UFDestino]),[]);
  CdsICMS.Edit;
  CdsICMS.FieldByName('ALIQICMS').AsCurrency := StrToCurrDef(Valor,-1) ;
  CdsICMS.Post;

end;

procedure TfrmALiqICMS.DataSetICMSBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  Abort;
end;

procedure TfrmALiqICMS.FormShow(Sender: TObject);
begin
  inherited;
  SetCds(CdsICMS,tpERPICMS,'')
end;

end.
