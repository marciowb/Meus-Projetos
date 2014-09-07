unit uDlg_RecebimentosContasReceber;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDlg_CadastroERP, StdCtrls, Buttons, ExtCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, Mask, EditPesquisa, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxDBEdit, DBCtrls, LabelDBEdit, DB, DBClient,
  pFIBClientDataSet;

type
  TfrmDlg_RecebimentosContasReceber = class(TfrmDlg_CadastroERP)
    DataRecebimentos: TDataSource;
    LabelDBEdit5: TLabelDBEdit;
    LabelDBEdit6: TLabelDBEdit;
    LabelDBEdit7: TLabelDBEdit;
    edtValorRecebido: TLabelDBEdit;
    edtData: TcxDBDateEdit;
    Label1: TLabel;
    LabelDBEdit1: TLabelDBEdit;
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure edtDataExit(Sender: TObject);
  private
    FDataSetMaster: TpFIBClientDataSet;
    procedure SetDataSetMaster(const Value: TpFIBClientDataSet);
    { Private declarations }
  public
    { Public declarations }
     property DataSetMaster: TpFIBClientDataSet read FDataSetMaster write SetDataSetMaster;
  end;

var
  frmDlg_RecebimentosContasReceber: TfrmDlg_RecebimentosContasReceber;

implementation

uses Comandos, MinhasClasses, uRegras;

{$R *.dfm}

procedure TfrmDlg_RecebimentosContasReceber.btnOkClick(Sender: TObject);
begin
  if edtData.Date = 0 then
  begin
    Avisa('Informe a data da conta');
    edtData.SetFocus;
    Exit;
  end;
  VerificaEdit(pDataSet, edtValorRecebido,'','Informe o valor recebido');
  inherited;

end;

procedure TfrmDlg_RecebimentosContasReceber.edtDataExit(Sender: TObject);
begin
  inherited;
  if (pDataSet.State = dsInsert) or
     ((pDataSet.State = dsEdit) and (pDataSet.FieldByName('DATARECEBIDO').Value <>
       pDataSet.FieldByName('DATARECEBIDO').OldValue))  then
  begin
    pDataSet.FieldByName('VALORMORA').AsCurrency := TRegrasContasReceber.CalculaMora(DataSetMaster.FieldByName('VALORRESTANTE').AsCurrency,
                                                                                   pDataSet.FieldByName('DATARECEBIDO').AsDateTime,
                                                                                   DataSetMaster.FieldByName('DATAVENCIMENTO').AsDateTime) ;
    pDataSet.FieldByName('VALORJUROS').AsCurrency := TRegrasContasReceber.CalculaJuros(DataSetMaster.FieldByName('VALORRESTANTE').AsCurrency,
                                                                                   pDataSet.FieldByName('DATARECEBIDO').AsDateTime,
                                                                                   DataSetMaster.FieldByName('DATAVENCIMENTO').AsDateTime) ;
    pDataSet.FieldByName('ALIQJUROS').AsCurrency := TRegrasContasReceber.CalculaAliqJuros(pDataSet.FieldByName('DATARECEBIDO').AsDateTime,
                                                                                          DataSetMaster.FieldByName('DATAVENCIMENTO').AsDateTime) ;

    pDataSet.FieldByName('VALORRECEBIDO').AsCurrency := (DataSetMaster.FieldByName('VALORRESTANTE').AsCurrency +
                                                         pDataSet.FieldByName('VALORJUROS').AsCurrency +
                                                         pDataSet.FieldByName('VALORMORA').AsCurrency);
  end;
end;

procedure TfrmDlg_RecebimentosContasReceber.FormShow(Sender: TObject);
begin
  inherited;
  
  DataRecebimentos.DataSet:= pDataSet;
end;

procedure TfrmDlg_RecebimentosContasReceber.SetDataSetMaster(
  const Value: TpFIBClientDataSet);
begin
  FDataSetMaster := Value;
end;

end.
