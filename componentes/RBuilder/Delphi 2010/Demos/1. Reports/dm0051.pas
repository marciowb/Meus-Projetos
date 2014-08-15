{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0051;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass, dmUtil, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppSubRpt, ppProd,
  ppDBPipe, ppVar, ppRelatv;

type
  Tfrm0051 = class(TdmCustomForm)
    dsEmployeeOrder: TDataSource;
    plEmployeeOrder: TppBDEPipeline;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    qryEmployeeOrder: TQuery;
    tblCustomer: TTable;
    dsCustomer: TDataSource;
    plCustomer: TppBDEPipeline;
    Label4: TLabel;
    Label5: TLabel;
    ppReport1: TppReport;
    ppReport1TitleBand1: TppTitleBand;
    ppReport1SubReport2: TppSubReport;
    ppEmpSales: TppChildReport;
    ppReport1Label9: TppLabel;
    ppReport1Label13: TppLabel;
    ppStockListLabel21: TppLabel;
    ppStockListLabel23: TppLabel;
    ppReport1Label14: TppLabel;
    ppReport1Label10: TppLabel;
    ppReport1Label11: TppLabel;
    ppReport1Label12: TppLabel;
    ppEmpSalesHeaderBand1: TppHeaderBand;
    ppEmpSalesLabel6: TppLabel;
    ppOrderDetailLabel1: TppLabel;
    ppEmpSalesDetailBand1: TppDetailBand;
    ppEmpSalesDBText7: TppDBText;
    ppEmpSalesDBText8: TppDBText;
    ppEmpSalesLine2: TppLine;
    ppEmpSalesLine3: TppLine;
    ppLabelContinued: TppLabel;
    ppEmpSalesFooterBand1: TppFooterBand;
    ppEmpSalesGroup1: TppGroup;
    ppEmpSalesGroupHeaderBand1: TppGroupHeaderBand;
    ppEmpSalesShape1: TppShape;
    ppEmpSalesLabel1: TppLabel;
    ppEmpSalesDBText1: TppDBText;
    ppEmpSalesDBText3: TppDBText;
    ppEmpSalesLabel2: TppLabel;
    ppEmpSalesDBText2: TppDBText;
    ppEmpSalesLabel3: TppLabel;
    ppEmpSalesLabel4: TppLabel;
    ppEmpSalesLabel5: TppLabel;
    ppEmpSalesDBText5: TppDBText;
    ppEmpSalesGroupFooterBand1: TppGroupFooterBand;
    ppDBCalcSumSales: TppDBCalc;
    ppEmpSalesLine1: TppLine;
    ppDBSalary: TppDBText;
    ppEmpSalesLine4: TppLine;
    ppEmpSalesLine5: TppLine;
    ppEmpSalesLine6: TppLine;
    ppReport1SubReport1: TppSubReport;
    ppCustList: TppChildReport;
    ppCustListHeader: TppHeaderBand;
    ppCustListLabel1: TppLabel;
    ppCustListLabel2: TppLabel;
    ppCustListLabel3: TppLabel;
    ppCustListLabel4: TppLabel;
    ppCustListLabel6: TppLabel;
    ppCustListLabel7: TppLabel;
    ppCustListLabel8: TppLabel;
    ppCustListLabel9: TppLabel;
    ppCustListLine1: TppLine;
    ppCustListDetail: TppDetailBand;
    ppCustListDBText2: TppDBText;
    ppCustListDBText8: TppDBText;
    ppCustListDBText3: TppDBText;
    ppCustListDBText4: TppDBText;
    ppCustListDBText5: TppDBText;
    ppCustListDBText6: TppDBText;
    ppCustListFooter: TppFooterBand;
    ppOrderDetailCalc2: TppSystemVariable;
    ppOrderDetailCalc3: TppSystemVariable;
    ppEmpSalesCalc1: TppSystemVariable;
    ppEmpSalesCalc2: TppSystemVariable;
    ppCalcNet: TppVariable;
    ppCustListCalc1: TppSystemVariable;
    ppCustListCalc3: TppSystemVariable;
    procedure ppEmpSalesGroupFooterBand1BeforePrint(Sender: TObject);
    procedure ppLabelContinuedPrint(Sender: TObject);
  private
    { Private declarations }

  protected
    function GetReport: TppProducer; override;
    
  public
    { Public declarations }
  end;

var
  frm0051: Tfrm0051;

implementation

{$R *.DFM}



{------------------------------------------------------------------------------}
{Tfrm0051.GetReport}

function Tfrm0051.GetReport: TppProducer;
begin
  Result := ppReport1;
end;



{------------------------------------------------------------------------------}
{Tfrm0051.ppEmpSalesGroupFooterBand1BeforePrint}

procedure Tfrm0051.ppEmpSalesGroupFooterBand1BeforePrint(Sender: TObject);
begin
  ppCalcNet.AsFloat := ppDBCalcSumSales.Value - qryEmployeeOrder.FieldByName('Salary').AsFloat;

  if ppCalcNet.AsFloat < 0 then
   ppCalcNet.Font.Color := clRed
  else
   ppCalcNet.Font.Color := clBlack;
end;

{------------------------------------------------------------------------------}
{Tfrm0051.ppLabelContinuedPrint}

procedure Tfrm0051.ppLabelContinuedPrint(Sender: TObject);
begin
  if (not ppEmpSales.Groups[0].FirstPage) and (ppEmpSalesDetailBand1.Count = 1) then
    ppLabelContinued.Visible := True
  else
    ppLabelContinued.Visible := False;

end;


end.
