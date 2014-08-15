{******************************************************************************}
{                                                                              }
{                   ReportBuilder Tutorials                                    }
{                                                                              }
{             Copyright (c) 1996, 2000 Digital Metaphors Corporation           }
{                                                                              }
{******************************************************************************}

unit rbStock;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppCtrls, ppBands, ppClass, ppPrnabl, ppCache, ppDB, ppProd,
  ppReport, ppComm, ppRelatv, ppDBPipe, Db, DBTables, ppVar, rbClass;

type

  {Note: This form is setup to run as part of the main tutorial project.
         It descends from TrbReportForm which is defined in rbClass.pas.

         You will need to add rbClass.pas to any project that uses this form.
         The rbClass.pas unit is part of the main tutorial project. }



  TfrmStockSummary = class(TrbReportForm)
    qryStock: TQuery;
    dsStock: TDataSource;
    plStock: TppDBPipeline;
    rbStock: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    rlRecommendation: TppLabel;
    ppLine1: TppLine;
    btnPreview: TButton;
    ppLabel3: TppLabel;
    ppDBText1: TppDBText;
    ppLabel4: TppLabel;
    ppDBText2: TppDBText;
    ppLabel5: TppLabel;
    ppDBText3: TppDBText;
    ppLabel6: TppLabel;
    ppDBText4: TppDBText;
    ppLabel7: TppLabel;
    ppLabel8: TppLabel;
    ppDBText5: TppDBText;
    ppLabel9: TppLabel;
    ppDBText6: TppDBText;
    ppLabel10: TppLabel;
    ppDBText7: TppDBText;
    ppLabel11: TppLabel;
    ppDBText8: TppDBText;
    ppLine3: TppLine;
    ppLabel12: TppLabel;
    ppLabel13: TppLabel;
    ppDBText9: TppDBText;
    ppLabel14: TppLabel;
    ppDBText10: TppDBText;
    ppLabel15: TppLabel;
    ppDBText11: TppDBText;
    ppLabel16: TppLabel;
    ppDBText12: TppDBText;
    ppLine4: TppLine;
    ppLine2: TppLine;
    ppLabel17: TppLabel;
    dbtRecommendation: TppLabel;
    ppDBText13: TppDBText;
    ppLabel19: TppLabel;
    ppDBText14: TppDBText;
    ppLabel20: TppLabel;
    ppDBText15: TppDBText;
    ppLine5: TppLine;
    ppLabel18: TppLabel;
    dbtSymbol: TppDBText;
    dbtCompany: TppDBText;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    ppSummaryBand1: TppSummaryBand;
    ppLabel21: TppLabel;
    ppLabel22: TppLabel;
    ppLabel23: TppLabel;
    ppLabel24: TppLabel;
    ppLabel25: TppLabel;
    ppLabel26: TppLabel;
    vrBuyTotal: TppVariable;
    vrHoldTotal: TppVariable;
    vrSellTotal: TppVariable;
    ppDBCalc1: TppDBCalc;
    ppLine6: TppLine;
    procedure ppGroupHeaderBand1BeforeGenerate(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure ppDetailBand1BeforeGenerate(Sender: TObject);
    procedure vrBuyTotalCalc(Sender: TObject; var Value: Variant);
    procedure vrHoldTotalCalc(Sender: TObject; var Value: Variant);
    procedure vrSellTotalCalc(Sender: TObject; var Value: Variant);
  private
    FRecommendationColor: TColor;
  protected
    function GetReport: TppReport; override;
  public
    { Public declarations }
  end;

var
  frmStockSummary: TfrmStockSummary;

implementation

{$R *.DFM}


{------------------------------------------------------------------------------}
{ TfrmStockSummary.GetReport }

function TfrmStockSummary.GetReport: TppReport;
begin
  Result := rbStock;

end; {function, GetReport}

{------------------------------------------------------------------------------}
{ TfrmStockSummary.ppGroupHeaderBand1BeforeGenerate }

procedure TfrmStockSummary.ppGroupHeaderBand1BeforeGenerate(Sender: TObject);
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
  if rbStock.Groups[0].FirstPage then
    rlRecommendation.Caption := 'Recommended ' + lsRecommendation + ' List'
  else
    rlRecommendation.Caption := 'Recommended ' + lsRecommendation + '''s continued...';

end;

{------------------------------------------------------------------------------}
{ TfrmStockSummary.btnPreviewClick }

procedure TfrmStockSummary.btnPreviewClick(Sender: TObject);
begin
  rbStock.Print;
end;

{------------------------------------------------------------------------------}
{ TfrmStockSummary.ppDetailBand1BeforeGenerate }

procedure TfrmStockSummary.ppDetailBand1BeforeGenerate(Sender: TObject);
begin
  {set the font color of Symbol, Recommendation variables}
  dbtRecommendation.Font.Color := FRecommendationColor;
  dbtSymbol.Font.Color         := FRecommendationColor;

end;

{------------------------------------------------------------------------------}
{ TfrmStockSummary.vrBuyTotalCalc }

procedure TfrmStockSummary.vrBuyTotalCalc(Sender: TObject; var Value: Variant);
begin
  if (qryStock.FieldByName('Rcmndation').AsString = 'BUY') then
    Value := Value + 1;
end;

{------------------------------------------------------------------------------}
{ TfrmStockSummary.vrHoldTotalCalc }

procedure TfrmStockSummary.vrHoldTotalCalc(Sender: TObject;var Value: Variant);
begin
  if (qryStock.FieldByName('Rcmndation').AsString = 'HOLD') then
    Value := Value + 1;

end;

{------------------------------------------------------------------------------}
{ TfrmStockSummary.vrSellTotalCalc }

procedure TfrmStockSummary.vrSellTotalCalc(Sender: TObject;var Value: Variant);
begin
  if (qryStock.FieldByName('Rcmndation').AsString = 'SELL') then
    Value := Value + 1;

end;

end.
