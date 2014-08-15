{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0063;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass, dmUtil, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppTypes,
  ppRegion, ppProd, ppDBPipe, ppVar, ppRelatv, ExtCtrls, ppSubRpt;

type
  Tfrm0063 = class(TdmCustomForm)
    dsStock: TDataSource;
    plStock: TppBDEPipeline;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ppStockList: TppReport;
    qryStock: TQuery;
    dsHoldings: TDataSource;
    plHoldings: TppBDEPipeline;
    tblHoldings: TTable;
    Shape3: TShape;
    ppStockListHeader: TppHeaderBand;
    ppStockListLabel31: TppLabel;
    ppStockListLabel32: TppLabel;
    ppStockListDetail: TppDetailBand;
    ppSubReport1: TppSubReport;
    ppChildReport1: TppChildReport;
    ppTitleBand1: TppTitleBand;
    ppDetailBand1: TppDetailBand;
    ppStockListShape2: TppShape;
    ppStockListDBText12: TppDBText;
    ppStockListDBText15: TppDBText;
    ppStockListDBText18: TppDBText;
    ppStockListDBText19: TppDBText;
    ppSummaryBand1: TppSummaryBand;
    ppStockListLabel33: TppLabel;
    ppStockListDBCalc2: TppDBCalc;
    ppStockListLine8: TppLine;
    ppStockListFooter: TppFooterBand;
    ppStockListCalc1: TppSystemVariable;
    ppStockListCalc3: TppSystemVariable;
    ppStockListSummaryBand1: TppSummaryBand;
    ppStockListLabel25: TppLabel;
    ppStockListLabel27: TppLabel;
    ppStockListLabel28: TppLabel;
    ppStockListLabel29: TppLabel;
    ppStockListLabel30: TppLabel;
    ppStockListDBCalc1: TppDBCalc;
    ppStockListLabel26: TppLabel;
    ppStockListLine7: TppLine;
    ppDBCalcRecommendations: TppDBCalc;
    ppCalcBuyTotal: TppVariable;
    ppCalcHoldTotal: TppVariable;
    ppCalcSellTotal: TppVariable;
    ppStockListGroup1: TppGroup;
    ppStockListGroupHeaderBand1: TppGroupHeaderBand;
    ppStockListLine6: TppLine;
    ppLblRecommendation: TppLabel;
    ppStockListGroupFooterBand1: TppGroupFooterBand;
    ppStockListGroup2: TppGroup;
    ppStockListGroupHeaderBand2: TppGroupHeaderBand;
    ppStockListLine5: TppLine;
    ppStockListLine1: TppLine;
    ppStockListDBText2: TppDBText;
    ppStockListDBText3: TppDBText;
    ppStockListDBText4: TppDBText;
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
    ppStockListLine2: TppLine;
    ppStockListLabel16: TppLabel;
    ppStockListLine3: TppLine;
    ppStockListLabel19: TppLabel;
    ppStockListLabel20: TppLabel;
    ppStockListGroupFooterBand2: TppGroupFooterBand;
    ppRegion1: TppRegion;
    ppStockListLabel21: TppLabel;
    ppStockListLabel22: TppLabel;
    ppStockListLabel23: TppLabel;
    ppStockListLabel24: TppLabel;
    ppLabelClientHoldings: TppLabel;
    ppStockListLine4: TppLine;
    ppReport1: TppReport;
    ppDetailBand2: TppDetailBand;
    ppDBText1: TppDBText;
    ppSubReport2: TppSubReport;
    ppChildReport2: TppChildReport;
    ppDetailBand3: TppDetailBand;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppShape1: TppShape;
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
  frm0063: Tfrm0063;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{Tfrm0063.GetReport}

function Tfrm0063.GetReport: TppProducer;
begin
  Result := ppStockList;
end;


{------------------------------------------------------------------------------}
{Tfrm0063.ppStockListGroupHeaderBand1BeforePrint

          - GroupHeaderBand.BeforePrint event handler}

procedure Tfrm0063.ppStockListGroupHeaderBand1BeforePrint(Sender: TObject);
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
{Tfrm0063.ppStockListGroupHeaderBand2BeforePrint

              - GroupHeaderBand2.BeforePrint event handler}

procedure Tfrm0063.ppStockListGroupHeaderBand2BeforePrint(Sender: TObject);
var
  lbDetailVisible: Boolean;
  
begin

  {set the font color of Symbol, Recommendation variables}
  ppDBTextRcmndation.Font.Color := FRecommendationColor;
  ppDBTextSymbol.Font.Color     := FRecommendationColor;

  {determine whether there are any detail records associated with
    this master record}
  if (ppdaNoRecords in plHoldings.State) then
    lbDetailVisible := False
  else
    lbDetailVisible := True;

  {set visibility of detail band}
  ppStockListDetail.Visible := lbDetailVisible;

  {set detail record heading}
  if lbDetailVisible then
    ppLabelClientHoldings.Text := 'Client Holdings for ' +  qryStock.FieldByName('Symbol').AsString
  else
    ppLabelClientHoldings.Text := '***No Client Holdings for ' + qryStock.FieldByName('Symbol').AsString;

end;

{------------------------------------------------------------------------------}
{Tfrm0063.ppStockListGroupFooterBand1BeforePrint

              - GroupFooterBand1.BeforePrint event handler  }

procedure Tfrm0063.ppStockListGroupFooterBand1BeforePrint(Sender: TObject);
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
