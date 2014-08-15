{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0062;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass, dmUtil, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppProd, ppDBPipe,
  ppVar, ppRelatv, ExtCtrls, ppSubRpt;

type
  Tfrm0062 = class(TdmCustomForm)
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
    dsHoldings: TDataSource;
    plHoldings: TppBDEPipeline;
    tblHoldings: TTable;
    ppDBCalcRecommendations: TppDBCalc;
    ppCalcBuyTotal: TppVariable;
    ppCalcHoldTotal: TppVariable;
    ppCalcSellTotal: TppVariable;
    ppStockListCalc1: TppSystemVariable;
    ppStockListCalc3: TppSystemVariable;
    ppSubReport1: TppSubReport;
    ppChildReport1: TppChildReport;
    ppTitleBand1: TppTitleBand;
    ppDetailBand1: TppDetailBand;
    ppSummaryBand1: TppSummaryBand;
    ppStockListShape1: TppShape;
    ppStockListLine4: TppLine;
    ppStockListLabel1: TppLabel;
    ppStockListDBText20: TppDBText;
    ppStockListLabel21: TppLabel;
    ppStockListLabel22: TppLabel;
    ppStockListLabel23: TppLabel;
    ppStockListLabel24: TppLabel;
    ppStockListShape2: TppShape;
    ppStockListDBText12: TppDBText;
    ppStockListDBText15: TppDBText;
    ppStockListDBText18: TppDBText;
    ppStockListDBText19: TppDBText;
    ppStockListLabel33: TppLabel;
    ppStockListDBCalc2: TppDBCalc;
    ppStockListLine8: TppLine;
    Shape3: TShape;
    procedure ppStockListGroupHeaderBand1BeforePrint(Sender: TObject);
    procedure ppStockListGroupHeaderBand2BeforePrint(Sender: TObject);
    procedure ppStockListGroupFooterBand1BeforePrint(Sender: TObject);
  private
    { Private declarations }
    FRecommendationColor: TColor;

  protected
    function GetReport: TppProducer; override;
    
  public
    { Public declarations }
  end;

var
  frm0062: Tfrm0062;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{Tfrm0062.GetReport}

function Tfrm0062.GetReport: TppProducer;
begin
  Result := ppStockList;
end;


{------------------------------------------------------------------------------}
{Tfrm0062.ppStockListGroupHeaderBand1BeforePrint

          - GroupHeaderBand.BeforePrint event handler}

procedure Tfrm0062.ppStockListGroupHeaderBand1BeforePrint(Sender: TObject);
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
  if ppStockList.Groups[0].FirstPage then

    ppLblRecommendation.Caption := 'Recommended ' + lsRecommendation + ' List'
  else
    ppLblRecommendation.Caption := 'Recommended ' + lsRecommendation + '''s continued...';

  ppLblRecommendation.Font.Color := FRecommendationColor;


end;

{------------------------------------------------------------------------------}
{Tfrm0062.ppStockListDetailBeforePrint

              - DetailBand.BeforePrint event handler}

procedure Tfrm0062.ppStockListGroupHeaderBand2BeforePrint(Sender: TObject);
begin
  {set the font color of Symbol, Recommendation variables}
  ppDBTextRcmndation.Font.Color := FRecommendationColor;
  ppDBTextSymbol.Font.Color     := FRecommendationColor;

end;

{------------------------------------------------------------------------------}
{Tfrm0062.ppStockListGroupFooterBand1BeforePrint

              - GroupFooterBand1.BeforePrint event handler  }

procedure Tfrm0062.ppStockListGroupFooterBand1BeforePrint(Sender: TObject);
var
  lsRecommendation: String;
begin

  lsRecommendation := qryStock.FieldByName('Rcmndation').AsString;

  if (lsRecommendation = 'BUY') then
    ppCalcBuyTotal.AsFloat := ppDBCalcRecommendations.Value

  else if (lsRecommendation = 'SELL') then
    ppCalcSellTotal.AsFloat := ppDBCalcRecommendations.Value

  else if (lsRecommendation = 'HOLD') then
    ppCalcHoldTotal.AsFloat := ppDBCalcRecommendations.Value;

end;

end.
