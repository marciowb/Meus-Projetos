{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0017;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass, dmUtil, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppRegion, ppProd,
  ppDBPipe, ppVar, ppRelatv;

type
  Tfrm0017 = class(TdmCustomForm)
    dsEmployeeOrder: TDataSource;
    plEmployeeOrder: TppBDEPipeline;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ppEmpSales: TppReport;
    qryEmployeeOrder: TQuery;
    ppEmpSalesHeaderBand1: TppHeaderBand;
    ppEmpSalesDetailBand1: TppDetailBand;
    ppEmpSalesFooterBand1: TppFooterBand;
    ppEmpSalesDBText2: TppDBText;
    ppEmpSalesLabel1: TppLabel;
    ppEmpSalesDBText5: TppDBText;
    ppDBSalary: TppDBText;
    ppDBCalcSumSales: TppDBCalc;
    ppEmpSalesLabel2: TppLabel;
    ppEmpSalesLabel3: TppLabel;
    ppEmpSalesLabel5: TppLabel;
    ppEmpSalesGroup1: TppGroup;
    ppEmpSalesGroupHeaderBand1: TppGroupHeaderBand;
    ppEmpSalesGroupFooterBand1: TppGroupFooterBand;
    ppEmpSalesLabel6: TppLabel;
    ppOrderDetailLabel1: TppLabel;
    ppEmpSalesLine4: TppLine;
    ppEmpSalesLine5: TppLine;
    ppEmpSalesLine6: TppLine;
    ppEmpSalesLine1: TppLine;
    ppEmpSalesLabel4: TppLabel;
    ppEmpSalesLine2: TppLine;
    ppEmpSalesLabel7: TppLabel;
    ppEmpSalesLabel8: TppLabel;
    ppEmpSalesLabel10: TppLabel;
    ppEmpSalesRegion1: TppRegion;
    ppLblFullName: TppLabel;
    ppOrderDetailCalc2: TppSystemVariable;
    ppOrderDetailCalc3: TppSystemVariable;
    ppEmpSalesCalc1: TppSystemVariable;
    ppEmpSalesCalc2: TppSystemVariable;
    ppCalcNet: TppVariable;
    procedure ppEmpSalesGroupFooterBand1BeforePrint(Sender: TObject);
  private
    { Private declarations }

  protected
    function GetReport: TppProducer; override;
    
  public
    { Public declarations }
  end;

var
  frm0017: Tfrm0017;

implementation

{$R *.DFM}


{------------------------------------------------------------------------------}
{Tfrm0017.GetReport}

function Tfrm0017.GetReport: TppProducer;
begin
  Result := ppEmpSales;
end;


{------------------------------------------------------------------------------}
{Tfrm0017.ppEmpSalesGroupFooterBand1BeforePrint}

procedure Tfrm0017.ppEmpSalesGroupFooterBand1BeforePrint(Sender: TObject);
begin

  {concatenate last name and first name}
  ppLblFullName.Caption := qryEmployeeOrder.FieldByName('LastName').AsString + ', ' +
                           qryEmployeeOrder.FieldByName('FirstName').AsString;

  {calc difference between total sales and salary}
  ppCalcNet.AsFloat := ppDBCalcSumSales.Value - qryEmployeeOrder.FieldByName('Salary').AsFloat;

  {set font color based on sign of ppCalcNet}
  if ppCalcNet.AsFloat < 0 then
   ppCalcNet.Font.Color := clRed
  else
   ppCalcNet.Font.Color := clBlack;

end;


end.
