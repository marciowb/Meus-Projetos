{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0071;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass, dmUtil, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ExtCtrls,
  ppSubRpt, ppProd, ppDBPipe, ppVar, ppRelatv;

type
  Tfrm0071 = class(TdmCustomForm)
    tblCustomer: TTable;
    dsCustomer: TDataSource;
    plCustomer: TppBDEPipeline;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ppReport1: TppReport;
    tblOrder: TTable;
    dsOrder: TDataSource;
    plOrder: TppBDEPipeline;
    Shape3: TShape;
    Label4: TLabel;
    Label5: TLabel;
    tblEmployee: TTable;
    dsEmployee: TDataSource;
    Label6: TLabel;
    plEmployee: TppBDEPipeline;
    Shape2: TShape;
    ppReport1HeaderBand1: TppHeaderBand;
    ppReport1Label1: TppLabel;
    ppReport1Label2: TppLabel;
    ppReport1Shape1: TppShape;
    ppReport1Label3: TppLabel;
    ppReport1Label4: TppLabel;
    ppReport1DBText1: TppDBText;
    ppReport1DBText2: TppDBText;
    ppReport1DetailBand1: TppDetailBand;
    ppReport1FooterBand1: TppFooterBand;
    tblItem: TTable;
    dsItem: TDataSource;
    plItem: TppBDEPipeline;
    Label7: TLabel;
    Shape1: TShape;
    Label8: TLabel;
    Shape4: TShape;
    tblPart: TTable;
    dsPart: TDataSource;
    plPart: TppBDEPipeline;
    ppReport1Calc1: TppSystemVariable;
    ppReport1Calc2: TppSystemVariable;
    ppReport1Calc3: TppSystemVariable;
    sbrOrder: TppSubReport;
    ppChildReport1: TppChildReport;
    ppDetailBand1: TppDetailBand;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppOrderDetailShape2: TppShape;
    ppOrderDetailLabel5: TppLabel;
    ppOrderDetailLabel6: TppLabel;
    ppOrderDetailShape3: TppShape;
    ppOrderDetailShape4: TppShape;
    ppOrderDetailLabel7: TppLabel;
    ppOrderDetailLabel8: TppLabel;
    ppOrderDetailLabel9: TppLabel;
    ppOrderDetailLabel10: TppLabel;
    ppOrderDetailShape5: TppShape;
    ppOrderDetailLabel11: TppLabel;
    ppOrderDetailLabel12: TppLabel;
    ppOrderDetailLabel13: TppLabel;
    ppOrderDetailLabel15: TppLabel;
    lblContinued: TppLabel;
    ppOrderDetailDBText3: TppDBText;
    ppOrderDetailDBText4: TppDBText;
    ppOrderDetailDBText5: TppDBText;
    ppOrderDetailDBText6: TppDBText;
    ppOrderDetailDBText7: TppDBText;
    ppOrderDetailDBText8: TppDBText;
    ppOrderDetailLine1: TppLine;
    ppOrderDetailLine2: TppLine;
    ppOrderDetailDBText10: TppDBText;
    sbrItem: TppSubReport;
    ppOrderListChildReport1: TppChildReport;
    ppOrderListChildReport1DetailBand1: TppDetailBand;
    ppOrderListChildReport1Shape2: TppShape;
    ppOrderListChildReport1DBText1: TppDBText;
    ppOrderListChildReport1DBText2: TppDBText;
    ppOrderListChildReport1DBText3: TppDBText;
    ppOrderListChildReport1DBText4: TppDBText;
    varItemTotal: TppVariable;
    ppOrderListChildReport1Group1: TppGroup;
    ppOrderListChildReport1GroupHeaderBand1: TppGroupHeaderBand;
    ppOrderListChildReport1Shape1: TppShape;
    ppOrderListChildReport1Label1: TppLabel;
    ppOrderListChildReport1Label2: TppLabel;
    ppOrderListChildReport1Label3: TppLabel;
    ppOrderListChildReport1Label4: TppLabel;
    ppOrderListChildReport1Label5: TppLabel;
    ppOrderListChildReport1GroupFooterBand1: TppGroupFooterBand;
    ppOrderListChildReport1Shape3: TppShape;
    ppOrderListChildReport1Label6: TppLabel;
    varOrderTotal: TppVariable;
    ppOrderDetailLine4: TppLine;
    ppOrderDetailLine3: TppLine;
    ppOrderDetailDBText9: TppDBText;
    ppOrderDetailLabel14: TppLabel;
    ppOrderDetailDBCalc1: TppDBCalc;
    procedure varItemTotalCalc(Sender: TObject; var Value: Variant);
    procedure varOrderTotalCalc(Sender: TObject; var Value: Variant);
    procedure ppDetailBand1BeforePrint(Sender: TObject);
  private
    { Private declarations }
  protected
    function GetReport: TppProducer; override;
  public
    { Public declarations }
  end;

var
  frm0071: Tfrm0071;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ Tfrm0071.GetReport}

function Tfrm0071.GetReport: TppProducer;
begin
  Result := ppReport1;
end; {function, GetReport}

{------------------------------------------------------------------------------}
{ Tfrm0071.varItemTotalCalc}

procedure Tfrm0071.varItemTotalCalc(Sender: TObject; var Value: Variant);
begin
  {calculate item subreport's item total, ItemTotal = Quantity * Price }
  varItemTotal.Value := tblItem.FieldByName('Qty').AsInteger * tblPart.FieldByName('ListPrice').AsFloat;
end; {procedure, varItemTotalCalc}

{------------------------------------------------------------------------------}
{ Tfrm0071.varOrderTotalCalc}

procedure Tfrm0071.varOrderTotalCalc(Sender: TObject; var Value: Variant);
begin
  {calculate item subreport's order total, OrderTotal = Sum(ItemTotal)}
  Value := Value + varItemTotal.Value;
end; {procedure, varOrderTotalCalc}

{------------------------------------------------------------------------------}
{ Tfrm0071.ppOrderDetailDetailBand1BeforePrint}

procedure Tfrm0071.ppDetailBand1BeforePrint(Sender: TObject);
begin
  {when the detail band of the order subreport overflows, show continued label}
  lblContinued.Visible := TppBandedReport(sbrOrder.Report).Detail.OverFlow;
end; {procedure, ppOrderDetailDetailBand1BeforePrint}

end.
