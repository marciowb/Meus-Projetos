{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0014;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass, dmUtil, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppProd, ppDBPipe,
  ppVar, ppRelatv, ppModule;

type
  Tfrm0014 = class(TdmCustomForm)
    dsStock: TDataSource;
    plStock: TppBDEPipeline;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ppStockList: TppReport;
    ppStockListHeader: TppHeaderBand;
    ppStockListDetail: TppDetailBand;
    ppStockListDBText2: TppDBText;
    ppStockListDBText3: TppDBText;
    ppStockListDBText4: TppDBText;
    ppStockListFooter: TppFooterBand;
    ppStockListLabel2: TppLabel;
    ppStockListLabel4: TppLabel;
    ppStockListDBText1: TppDBText;
    ppStockListLabel5: TppLabel;
    ppStockListDBText5: TppDBText;
    ppStockListLabel6: TppLabel;
    ppStockListDBText6: TppDBText;
    ppStockListDBText7: TppDBText;
    ppStockListLabel7: TppLabel;
    ppStockListLabel8: TppLabel;
    ppStockListDBText8: TppDBText;
    ppStockListLabel9: TppLabel;
    ppStockListLabel10: TppLabel;
    ppStockListDBText9: TppDBText;
    ppStockListDBText10: TppDBText;
    ppStockListLabel11: TppLabel;
    ppStockListDBText11: TppDBText;
    ppStockListLabel12: TppLabel;
    ppDBTextRcmndation: TppDBText;
    ppStockListLabel13: TppLabel;
    ppStockListDBText13: TppDBText;
    ppStockListLabel14: TppLabel;
    ppStockListDBText14: TppDBText;
    ppStockListLabel15: TppLabel;
    ppDBTextSymbol: TppDBText;
    ppStockListDBText16: TppDBText;
    ppStockListLabel17: TppLabel;
    ppStockListDBText17: TppDBText;
    ppStockListLabel18: TppLabel;
    ppStockListLabel3: TppLabel;
    ppStockListLine1: TppLine;
    ppStockListLine2: TppLine;
    ppStockListLabel16: TppLabel;
    ppStockListLine3: TppLine;
    ppStockListLabel19: TppLabel;
    ppStockListLine4: TppLine;
    ppStockListLine5: TppLine;
    ppStockListLabel20: TppLabel;
    ppStockListLine6: TppLine;
    ppStockListSummaryBand1: TppSummaryBand;
    ppStockListLabel25: TppLabel;
    ppStockListLabel27: TppLabel;
    ppStockListLabel28: TppLabel;
    ppStockListLabel29: TppLabel;
    ppStockListLabel30: TppLabel;
    ppStockListDBCalc1: TppDBCalc;
    ppStockListLabel26: TppLabel;
    ppStockListLine7: TppLine;
    ppStockListLabel31: TppLabel;
    ppStockListLabel32: TppLabel;
    qryStock: TQuery;
    ppLblRecommendation: TppLabel;
    ppCalcBuyTotal: TppVariable;
    ppCalcHoldTotal: TppVariable;
    ppCalcSellTotal: TppVariable;
    ppStockListCalc1: TppSystemVariable;
    ppStockListCalc3: TppSystemVariable;
    procedure ppStockListDetailBeforePrint(Sender: TObject);
    procedure ppStockListGroupHeaderBand1BeforeGenerate(Sender: TObject);
    procedure ppCalcBuyTotalCalc(Sender: TObject; var Value: Variant);
    procedure ppCalcHoldTotalCalc(Sender: TObject; var Value: Variant);
    procedure ppCalcSellTotalCalc(Sender: TObject; var Value: Variant);
    procedure ppVariable1Calc(Sender: TObject; var Value: Variant);
  private
    { Private declarations }
    FRecommendationColor: TColor;

  protected
    function GetReport: TppProducer; override;
    
  public
    { Public declarations }
  end;

var
  frm0014: Tfrm0014;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{Tfrm0013.GetReport}

function Tfrm0014.GetReport: TppProducer;
begin
  Result := ppStockList;
end;

{------------------------------------------------------------------------------}
{Tfrm0013.ppStockListDetailBeforePrint

              - DetailBand.BeforePrint event handler}

procedure Tfrm0014.ppStockListDetailBeforePrint(Sender: TObject);
begin

  {set the font color of Symbol, Recommendation variables}
  ppDBTextRcmndation.Font.Color := FRecommendationColor;
  ppDBTextSymbol.Font.Color     := FRecommendationColor;

end;

{------------------------------------------------------------------------------}
{ Tfrm0014.ppCalcSellTotalCalc }

procedure Tfrm0014.ppStockListGroupHeaderBand1BeforeGenerate(Sender: TObject);
var
  lsRecommendation: String;
begin
  lsRecommendation := qryStock.FieldByName('Rcmndation').AsString;

  {determine the font color based on the value of Recommendation}
  if lsRecommendation = 'BUY' then
    FRecommendationColor := clRed

  else if lsRecommendation = 'HOLD' then
    FRecommendationColor := clGreen

  else {lsRecommendation = 'SELL'}
    FRecommendationColor := clBlue;

  ppLblRecommendation.Font.Color := FRecommendationColor;

  {check whether group first page of group or a continuation}
  if ppStockList.Groups[0].FirstPage then

    ppLblRecommendation.Caption := 'Recommended ' + lsRecommendation + ' List'
  else
    ppLblRecommendation.Caption := 'Recommended ' + lsRecommendation + '''s continued...';

end;

{------------------------------------------------------------------------------}
{ Tfrm0014.ppCalcBuyTotalCalc }

procedure Tfrm0014.ppCalcBuyTotalCalc(Sender: TObject; var Value: Variant);
begin
  if qryStock.FieldByName('Rcmndation').AsString = 'BUY' then
     Value := Value + 1;
end;

{------------------------------------------------------------------------------}
{ Tfrm0014.ppCalcHoldTotalCalc }

procedure Tfrm0014.ppCalcHoldTotalCalc(Sender: TObject; var Value: Variant);
begin
  if qryStock.FieldByName('Rcmndation').AsString = 'HOLD' then
    Value := Value + 1;
end;

{------------------------------------------------------------------------------}
{ Tfrm0014.ppCalcSellTotalCalc }

procedure Tfrm0014.ppCalcSellTotalCalc(Sender: TObject; var Value: Variant);
begin
  if qryStock.FieldByName('Rcmndation').AsString = 'SELL' then
    Value := Value + 1;
end;


procedure Tfrm0014.ppVariable1Calc(Sender: TObject; var Value: Variant);
begin
  Value := ppStockListDBCalc1.Value * 10;
end;

end.
