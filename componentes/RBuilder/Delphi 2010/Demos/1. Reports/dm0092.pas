{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0092;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass, dmUtil, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppProd,
  TeEngine, Series, ExtCtrls, TeeProcs, Chart, DBChart, ppChrt,
  ppDBPipe, ppVar, ppRelatv, ppChrtDP;

type
  Tfrm0092 = class(TdmCustomForm)
    tblStock: TTable;
    dsStock: TDataSource;
    plStock: TppBDEPipeline;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ppBasicChart: TppReport;
    ppBasicChartHeader: TppHeaderBand;
    ppBasicChartDetail: TppDetailBand;
    ppBasicChartDBText2: TppDBText;
    ppBasicChartDBText3: TppDBText;
    ppBasicChartDBText4: TppDBText;
    ppBasicChartFooter: TppFooterBand;
    ppBasicChartLabel2: TppLabel;
    ppBasicChartLabel4: TppLabel;
    ppBasicChartDBText1: TppDBText;
    ppBasicChartLabel5: TppLabel;
    ppBasicChartDBText5: TppDBText;
    ppBasicChartLabel6: TppLabel;
    ppBasicChartDBText6: TppDBText;
    ppBasicChartDBText7: TppDBText;
    ppBasicChartLabel7: TppLabel;
    ppBasicChartLabel8: TppLabel;
    ppBasicChartDBText8: TppDBText;
    ppBasicChartLabel9: TppLabel;
    ppBasicChartLabel10: TppLabel;
    ppBasicChartDBText9: TppDBText;
    ppBasicChartDBText10: TppDBText;
    ppBasicChartLabel11: TppLabel;
    ppBasicChartDBText11: TppDBText;
    ppBasicChartLabel12: TppLabel;
    ppDBTextRcmndation: TppDBText;
    ppBasicChartLabel13: TppLabel;
    ppBasicChartDBText13: TppDBText;
    ppBasicChartLabel14: TppLabel;
    ppBasicChartDBText14: TppDBText;
    ppBasicChartLabel15: TppLabel;
    ppDBTextSymbol: TppDBText;
    ppBasicChartDBText16: TppDBText;
    ppBasicChartLabel17: TppLabel;
    ppBasicChartDBText17: TppDBText;
    ppBasicChartLabel18: TppLabel;
    ppBasicChartLabel3: TppLabel;
    ppBasicChartLine1: TppLine;
    ppBasicChartLine2: TppLine;
    ppBasicChartLabel16: TppLabel;
    ppBasicChartLine3: TppLine;
    ppBasicChartLabel19: TppLabel;
    ppBasicChartLine4: TppLine;
    ppBasicChartLine5: TppLine;
    ppBasicChartLabel20: TppLabel;
    ppBasicChartLine6: TppLine;
    ppBasicChartLabel31: TppLabel;
    ppBasicChartLabel32: TppLabel;
    ppBasicChartTitleBand1: TppTitleBand;
    ppBasicChartLabel21: TppLabel;
    ppBasicChartLabel22: TppLabel;
    ppBasicChartCalc1: TppSystemVariable;
    ppBasicChartCalc3: TppSystemVariable;
    ppDPTeeChart1: TppDPTeeChart;
    Series2: TLineSeries;
    procedure ppBasicChartDetailBeforePrint(Sender: TObject);
  private
    { Private declarations }
  protected
    function GetReport: TppProducer; override;
  public
    { Public declarations }
  end;

var
  frm0092: Tfrm0092;

implementation

{$R *.DFM}


function Tfrm0092.GetReport: TppProducer;
begin
  Result := ppBasicChart;
end;


{******************************************************************************

 D e t a i l B a n d -  B e f o r e P r i n t  E v e n t

******************************************************************************}

{------------------------------------------------------------------------------}
{Tfrm0013.ppStockListDetailBeforePrint}

procedure Tfrm0092.ppBasicChartDetailBeforePrint(Sender: TObject);
var
  lsRecommendation: String;
  lFontColor: TColor;

begin

  lsRecommendation := tblStock.FieldByName('Rcmndation').AsString;

  {determine the font color based on the value of Recommendation}
  if lsRecommendation = 'BUY' then
    lFontColor := clRed

  else if lsRecommendation = 'HOLD' then
    lFontColor := clGreen

  else {lsRecommendation = 'SELL'}
    lFontColor := clBlue;

  {set the font color of Symbol, Recommendation variables}
  ppDBTextRcmndation.Font.Color := lFontColor;
  ppDBTextSymbol.Font.Color     := lFontColor;

end;


end.
