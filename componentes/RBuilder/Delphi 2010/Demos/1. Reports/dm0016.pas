{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0016;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass, dmUtil, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppProd, ppDBPipe,
  ppVar, ppRelatv;

type
  Tfrm0016 = class(TdmCustomForm)
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
    ppEmpSalesDBText1: TppDBText;
    ppEmpSalesDBText3: TppDBText;
    ppEmpSalesLabel1: TppLabel;
    ppEmpSalesDBText5: TppDBText;
    ppDBSalary: TppDBText;
    ppEmpSalesDBText7: TppDBText;
    ppEmpSalesDBText8: TppDBText;
    ppDBCalcSumSales: TppDBCalc;
    ppEmpSalesLabel2: TppLabel;
    ppEmpSalesShape1: TppShape;
    ppEmpSalesLabel3: TppLabel;
    ppEmpSalesLine1: TppLine;
    ppEmpSalesLabel4: TppLabel;
    ppEmpSalesLabel5: TppLabel;
    ppEmpSalesGroup1: TppGroup;
    ppEmpSalesGroupHeaderBand1: TppGroupHeaderBand;
    ppEmpSalesGroupFooterBand1: TppGroupFooterBand;
    ppEmpSalesLabel6: TppLabel;
    ppOrderDetailLabel1: TppLabel;
    ppEmpSalesLine2: TppLine;
    ppEmpSalesLine3: TppLine;
    ppEmpSalesLine4: TppLine;
    ppEmpSalesLine5: TppLine;
    ppEmpSalesLine6: TppLine;
    ppLabelContinued: TppLabel;
    ppOrderDetailCalc2: TppSystemVariable;
    ppOrderDetailCalc3: TppSystemVariable;
    ppEmpSalesCalc1: TppSystemVariable;
    ppEmpSalesCalc2: TppSystemVariable;
    ppCalcNet: TppVariable;
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
  frm0016: Tfrm0016;

implementation

{$R *.DFM}



{------------------------------------------------------------------------------}
{Tfrm0016.GetReport}

function Tfrm0016.GetReport: TppProducer;
begin
  Result := ppEmpSales;
end;


{------------------------------------------------------------------------------}
{Tfrm0016.ppEmpSalesGroupFooterBand1BeforePrint}

procedure Tfrm0016.ppEmpSalesGroupFooterBand1BeforePrint(Sender: TObject);
begin
  ppCalcNet.AsFloat := ppDBCalcSumSales.Value - qryEmployeeOrder.FieldByName('Salary').AsFloat;

  if ppCalcNet.AsFloat < 0 then
   ppCalcNet.Font.Color := clRed
  else
   ppCalcNet.Font.Color := clBlack;
end;

{------------------------------------------------------------------------------}
{Tfrm0016.ppLabelContinuedPrint}

procedure Tfrm0016.ppLabelContinuedPrint(Sender: TObject);
begin
  if (not ppEmpSales.Groups[0].FirstPage) and (ppEmpSalesDetailBand1.Count = 1) then
    ppLabelContinued.Visible := True
  else
    ppLabelContinued.Visible := False;

end;

end.
