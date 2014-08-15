{******************************************************************************}
{                                                                              }
{                   ReportBuilder Tutorials                                    }
{                                                                              }
{             Copyright (c) 1996, 2000 Digital Metaphors Corporation           }
{                                                                              }
{******************************************************************************}

unit rbSectSR;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppDB, ppComm, ppRelatv, ppDBPipe, Db, DBTables, ppVar, ppBands,
  ppCtrls, ppReport, ppPrnabl, ppClass, ppStrtch, ppSubRpt, ppCache, ppProd;

type
  TfrmSectionSubReport = class(TForm)
    tblCustomer: TTable;
    dsCustomer: TDataSource;
    plCustomer: TppDBPipeline;
    plCustomerppField1: TppField;
    plCustomerppField2: TppField;
    plCustomerppField3: TppField;
    plCustomerppField4: TppField;
    plCustomerppField5: TppField;
    plCustomerppField6: TppField;
    plCustomerppField7: TppField;
    plCustomerppField8: TppField;
    plCustomerppField9: TppField;
    plCustomerppField10: TppField;
    plCustomerppField11: TppField;
    plCustomerppField12: TppField;
    plCustomerppField13: TppField;
    Label1: TLabel;
    qryStock: TQuery;
    dsStock: TDataSource;
    plStock: TppDBPipeline;
    plStockppField1: TppField;
    plStockppField2: TppField;
    plStockppField3: TppField;
    plStockppField4: TppField;
    plStockppField5: TppField;
    plStockppField6: TppField;
    plStockppField7: TppField;
    plStockppField8: TppField;
    plStockppField9: TppField;
    plStockppField10: TppField;
    plStockppField11: TppField;
    plStockppField12: TppField;
    plStockppField13: TppField;
    plStockppField14: TppField;
    plStockppField15: TppField;
    plStockppField16: TppField;
    plStockppField17: TppField;
    Label2: TLabel;
    rbSectSub: TppReport;
    ppDetailBand1: TppDetailBand;
    srCustomerList: TppSubReport;
    ppChildReport1: TppChildReport;
    ppHeaderBand1: TppHeaderBand;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppLabel8: TppLabel;
    ppLine1: TppLine;
    ppDetailBand2: TppDetailBand;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppFooterBand1: TppFooterBand;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    srStockSummary: TppSubReport;
    ppChildReport2: TppChildReport;
    ppHeaderBand2: TppHeaderBand;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    ppDetailBand3: TppDetailBand;
    ppLine4: TppLine;
    ppLabel11: TppLabel;
    ppDBText7: TppDBText;
    ppLabel12: TppLabel;
    ppDBText8: TppDBText;
    ppLabel13: TppLabel;
    ppDBText9: TppDBText;
    ppLabel14: TppLabel;
    ppDBText10: TppDBText;
    ppLabel15: TppLabel;
    ppLabel16: TppLabel;
    ppDBText11: TppDBText;
    ppLabel17: TppLabel;
    ppDBText12: TppDBText;
    ppLabel18: TppLabel;
    ppDBText13: TppDBText;
    ppLabel19: TppLabel;
    ppDBText14: TppDBText;
    ppLine3: TppLine;
    ppLabel20: TppLabel;
    ppLabel21: TppLabel;
    ppDBText15: TppDBText;
    ppLabel22: TppLabel;
    ppDBText16: TppDBText;
    ppLabel23: TppLabel;
    ppDBText17: TppDBText;
    ppLabel24: TppLabel;
    ppDBText18: TppDBText;
    ppLine2: TppLine;
    ppLabel25: TppLabel;
    dbtRecommendation: TppLabel;
    ppDBText19: TppDBText;
    ppLabel26: TppLabel;
    ppDBText20: TppDBText;
    ppLabel27: TppLabel;
    ppDBText21: TppDBText;
    ppLine5: TppLine;
    ppLabel28: TppLabel;
    dbtSymbol: TppDBText;
    dbtCompany: TppDBText;
    ppFooterBand2: TppFooterBand;
    ppSystemVariable3: TppSystemVariable;
    ppSystemVariable4: TppSystemVariable;
    ppSummaryBand1: TppSummaryBand;
    ppLabel29: TppLabel;
    ppLabel30: TppLabel;
    ppLabel31: TppLabel;
    ppLabel32: TppLabel;
    ppLabel33: TppLabel;
    ppLabel34: TppLabel;
    vrBuyTotal: TppVariable;
    vrHoldTotal: TppVariable;
    vrSellTotal: TppVariable;
    ppDBCalc1: TppDBCalc;
    ppLine6: TppLine;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    rlRecommendation: TppLabel;
    ppLine7: TppLine;
    ppGroupFooterBand1: TppGroupFooterBand;
    btnPreview: TButton;
    ppTitleBand1: TppTitleBand;
    ppLabel35: TppLabel;
    ppLabel36: TppLabel;
    ppLabel37: TppLabel;
    ppLabel38: TppLabel;
    ppLabel39: TppLabel;
    ppLabel40: TppLabel;
    ppLabel41: TppLabel;
    ppLabel42: TppLabel;
    procedure btnPreviewClick(Sender: TObject);
    procedure ppGroupHeaderBand1BeforeGenerate(Sender: TObject);
    procedure ppDetailBand1BeforeGenerate(Sender: TObject);
    procedure vrBuyTotalCalc(Sender: TObject; var Value: Variant);
    procedure vrHoldTotalCalc(Sender: TObject; var Value: Variant);
    procedure vrSellTotalCalc(Sender: TObject; var Value: Variant);
  private
    FRecommendationColor: TColor;
  public
    { Public declarations }
  end;

var
  frmSectionSubReport: TfrmSectionSubReport;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TfrmSectionSubReport.btnPreviewClick }

procedure TfrmSectionSubReport.btnPreviewClick(Sender: TObject);
begin
  rbSectSub.Print;
end;

{------------------------------------------------------------------------------}
{ TfrmSectionSubReport.ppGroupHeaderBand1BeforeGenerate }

procedure TfrmSectionSubReport.ppGroupHeaderBand1BeforeGenerate(Sender: TObject);
var
  lsRecommendation: String;
begin
  lsRecommendation := qryStock.FieldByName('Rcmndation').AsString;

  {determine the font color based on the value of Recommendation}
  if lsRecommendation = 'BUY' then
    FRecommendationColor := clGreen
  else if lsRecommendation = 'HOLD' then
    FRecommendationColor := clOlive
  else if lsRecommendation = 'SELL' then
    FRecommendationColor := clMaroon;

  rlRecommendation.Font.Color := FRecommendationColor;

  {check whether first page of group or a continuation}
  if srStockSummary.Report.Groups[0].FirstPage then
    rlRecommendation.Caption := 'Recommended ' + lsRecommendation + ' List'
  else
    rlRecommendation.Caption := 'Recommended ' + lsRecommendation + '''s continued...';

end;

{------------------------------------------------------------------------------}
{ TfrmSectionSubReport.ppDetailBand1BeforeGenerate }

procedure TfrmSectionSubReport.ppDetailBand1BeforeGenerate(Sender: TObject);
begin
  {set the font color of Symbol, Recommendation variables}
  dbtRecommendation.Font.Color := FRecommendationColor;
  dbtSymbol.Font.Color         := FRecommendationColor;

end;

{------------------------------------------------------------------------------}
{ TfrmSectionSubReport.vrBuyTotalCalc }

procedure TfrmSectionSubReport.vrBuyTotalCalc(Sender: TObject; var Value: Variant);
begin
  if (qryStock.FieldByName('Rcmndation').AsString = 'BUY') then
    Value := Value + 1;
end;

{------------------------------------------------------------------------------}
{ TfrmSectionSubReport.vrHoldTotalCalc }

procedure TfrmSectionSubReport.vrHoldTotalCalc(Sender: TObject;var Value: Variant);
begin
  if (qryStock.FieldByName('Rcmndation').AsString = 'HOLD') then
    Value := Value + 1;

end;

{------------------------------------------------------------------------------}
{ TfrmSectionSubReport.vrSellTotalCalc }

procedure TfrmSectionSubReport.vrSellTotalCalc(Sender: TObject;var Value: Variant);
begin
  if (qryStock.FieldByName('Rcmndation').AsString = 'SELL') then
    Value := Value + 1;

end;

end.
