{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0152;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass, dmUtil, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ExtCtrls,
  ppSubRpt, ppProd, ppDBPipe, ppVar, ppRegion, ppRelatv;

type
  Tfrm0152 = class(TdmCustomForm)
    tblCustomer: TTable;
    dsCustomer: TDataSource;
    plCustomer: TppBDEPipeline;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ppOrderDetail: TppReport;
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
    ppReport1HeaderBand1: TppHeaderBand;
    ppReport1Label1: TppLabel;
    ppReport1Label2: TppLabel;
    ppReport1Shape1: TppShape;
    ppReport1Label3: TppLabel;
    ppReport1Label4: TppLabel;
    ppReport1DBText1: TppDBText;
    ppReport1DBText2: TppDBText;
    ppReport1DetailBand1: TppDetailBand;
    sbrOrder: TppSubReport;
    ppChildReport1: TppChildReport;
    ppDetailBand1: TppDetailBand;
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
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
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
    ppGroupFooterBand1: TppGroupFooterBand;
    ppOrderDetailLine4: TppLine;
    ppOrderDetailLine3: TppLine;
    ppOrderDetailDBText9: TppDBText;
    ppOrderDetailLabel14: TppLabel;
    ppOrderDetailDBCalc1: TppDBCalc;
    ppReport1FooterBand1: TppFooterBand;
    ppReport1Calc1: TppSystemVariable;
    ppReport1Calc2: TppSystemVariable;
    ppReport1Calc3: TppSystemVariable;
    ppRegion1: TppRegion;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppLabelContinued: TppLabel;
    procedure ppOrderDetailDetailBand1BeforePrint(Sender: TObject);
    procedure varItemTotalCalc(Sender: TObject; var Value: Variant);
    procedure varOrderTotalCalc(Sender: TObject; var Value: Variant);
  private
    { Private declarations }
  protected
    function GetReport: TppProducer; override;
  public
    { Public declarations }
  end;

var
  frm0152: Tfrm0152;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{Tfrm0152.GetReport}

function Tfrm0152.GetReport: TppProducer;
begin
  Result := ppOrderDetail;
end;

{------------------------------------------------------------------------------}
{Tfrm0152.ppOrderDetailDetailBand1BeforePrint}

procedure Tfrm0152.ppOrderDetailDetailBand1BeforePrint(Sender: TObject);
begin
  ppLabelContinued.Visible := ppOrderDetail.DetailBand.OverFlow;
end;

{------------------------------------------------------------------------------}
{Tfrm0152.varItemTotalCalc}

procedure Tfrm0152.varItemTotalCalc(Sender: TObject; var Value: Variant);
begin
  {event handler for TppVariable.OnCalc event of the child report's item total field,
    ItemTotal = Quantity * Price }
  Value := tblItem.FieldByName('Qty').AsInteger * tblPart.FieldByName('ListPrice').AsFloat;

end;

{------------------------------------------------------------------------------}
{Tfrm0152.varOrderTotalCalc}

procedure Tfrm0152.varOrderTotalCalc(Sender: TObject; var Value: Variant);
begin
  {event handler for TppVariable.OnCalc event of the child report's order total field,
    OrderTotal = sum(ItemTotal) }
  Value := Value + varItemTotal.AsFloat;
end;

end.
