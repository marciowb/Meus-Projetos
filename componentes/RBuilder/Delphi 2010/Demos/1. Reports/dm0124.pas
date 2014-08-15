{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0124;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass, dmUtil, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppProd,
  ppTypes, ppUtils, ppDBPipe, ppVar, ppRelatv;

type
  Tfrm0124 = class(TdmCustomForm)
    dsStock: TDataSource;
    plStock: TppBDEPipeline;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ppReport: TppReport;
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
    ppStockListTitleBand1: TppTitleBand;
    ppStockListLabel24: TppLabel;
    ppStockListMemo1: TppMemo;
    ppStockListLabel21: TppLabel;
    ppStockListLabel23: TppLabel;
    ppStockListLabel22: TppLabel;
    ppStockListLabel1: TppLabel;
    ppCalcBuyTotal: TppVariable;
    ppCalcHoldTotal: TppVariable;
    ppCalcSellTotal: TppVariable;
    ppStockListCalc1: TppSystemVariable;
    ppStockListCalc3: TppSystemVariable;
    ppStockListCalc2: TppSystemVariable;
    procedure ppStockListDetailBeforePrint(Sender: TObject);
    procedure ppStockListGroupHeaderBand1BeforeGenerate(Sender: TObject);
    procedure ppReportBeforePrint(Sender: TObject);
    procedure ppCalcBuyTotalCalc(Sender: TObject; var Value: Variant);
    procedure ppCalcHoldTotalCalc(Sender: TObject; var Value: Variant);
    procedure ppCalcSellTotalCalc(Sender: TObject; var Value: Variant);
  private
    { Private declarations }
    FRecommendationColor: TColor;

  protected
    function GetReport: TppProducer; override;
    
  public
    { Public declarations }
  end;

var
  frm0124: Tfrm0124;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{Tfrm0024.GetReport}

function Tfrm0124.GetReport: TppProducer;
begin
  Result := ppReport;
end;

{------------------------------------------------------------------------------}
{Tfrm0024.ppStockListDetailBeforePrint

              - DetailBand.BeforePrint event handler}

procedure Tfrm0124.ppStockListDetailBeforePrint(Sender: TObject);
begin

  {set the font color of Symbol, Recommendation variables}
  ppDBTextRcmndation.Font.Color := FRecommendationColor;
  ppDBTextSymbol.Font.Color     := FRecommendationColor;

end;

{------------------------------------------------------------------------------}
{Tfrm0024.ppStockListGroupHeaderBand1BeforeGenerate}

procedure Tfrm0124.ppStockListGroupHeaderBand1BeforeGenerate(Sender: TObject);

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

  {check whether group first page of group or a continuation}
  if ppReport.Groups[0].FirstPage then

    ppLblRecommendation.Caption := 'Recommended ' + lsRecommendation + ' List'
  else
    ppLblRecommendation.Caption := 'Recommended ' + lsRecommendation + '''s continued...';

  ppLblRecommendation.Font.Color := FRecommendationColor;

end;


{------------------------------------------------------------------------------}
{Tfrm0024.ppReportBeforePrint}

procedure Tfrm0124.ppReportBeforePrint(Sender: TObject);
begin

  {need to add ppTypes and ppUtils to the 'uses' clause}

  {note: PrinterDevice will be nil if NOT printing to printer }
  if (Report.PrinterDevice <> nil) then
    begin
      Report.PrinterDevice.PageSetting := psPageList;

      {note: this is a useful routine for converting the page list text
            to the list of strings}

      {print pages 1 and 30 }      
      ppTextToPageList('1,30', Report.PrinterDevice.PageList, True);
   end;

end;

procedure Tfrm0124.ppCalcBuyTotalCalc(Sender: TObject; var Value: Variant);
begin
  if qryStock.FieldByName('Rcmndation').AsString = 'BUY' then
     ppCalcBuyTotal.AsInteger := ppCalcBuyTotal.AsInteger + 1;
end;

procedure Tfrm0124.ppCalcHoldTotalCalc(Sender: TObject; var Value: Variant);
begin
  if qryStock.FieldByName('Rcmndation').AsString = 'HOLD' then
    ppCalcHoldTotal.AsInteger := ppCalcHoldTotal.AsInteger + 1;
end;

procedure Tfrm0124.ppCalcSellTotalCalc(Sender: TObject; var Value: Variant);
begin
  if qryStock.FieldByName('Rcmndation').AsString = 'SELL' then
    ppCalcSellTotal.AsInteger := ppCalcSellTotal.AsInteger + 1;
end;

end.
