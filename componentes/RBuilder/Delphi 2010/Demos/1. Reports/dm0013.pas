{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0013;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass, dmUtil, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppProd, ppDBPipe,
  ppVar, ppRelatv;

type
  Tfrm0013 = class(TdmCustomForm)
    tblStock: TTable;
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
    ppStockListLabel31: TppLabel;
    ppStockListLabel32: TppLabel;
    ppStockListCalc1: TppSystemVariable;
    ppStockListCalc3: TppSystemVariable;
    procedure ppStockListDetailBeforePrint(Sender: TObject);
  private
    { Private declarations }
  protected
    function GetReport: TppProducer; override;
  public
    { Public declarations }
  end;

var
  frm0013: Tfrm0013;

implementation

{$R *.DFM}


function Tfrm0013.GetReport: TppProducer;
begin
  Result := ppStockList;
end;


{******************************************************************************

 D e t a i l B a n d -  B e f o r e P r i n t  E v e n t

******************************************************************************}

{------------------------------------------------------------------------------}
{Tfrm0013.ppStockListDetailBeforePrint}

procedure Tfrm0013.ppStockListDetailBeforePrint(Sender: TObject);
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
