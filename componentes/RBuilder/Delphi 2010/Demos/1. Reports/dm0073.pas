{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0073;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass, dmUtil, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ExtCtrls,
  ppSubRpt, ppProd, ppDBPipe, ppVar, ppRelatv,
  ppFileUtils;

const
  {WindDing ASCII codes for check marks and X's}
  cEmptyBox       = #111;
  cCheckMarkInBox = #254;
  cCheckMark      = #252;
  cX              = #251;
  cXInBox         = #253;

  
type
  Tfrm0073 = class(TdmCustomForm)
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
    ppOrderListChildReport1DBText4: TppDBText;
    varItemTotal: TppVariable;
    ppOrderListChildReport1Group1: TppGroup;
    ppOrderListChildReport1GroupHeaderBand1: TppGroupHeaderBand;
    ppOrderListChildReport1Shape1: TppShape;
    ppOrderListChildReport1Label1: TppLabel;
    ppOrderListChildReport1Label2: TppLabel;
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
    Label9: TLabel;
    Shape5: TShape;
    Label10: TLabel;
    Shape6: TShape;
    dsVendOrd: TDataSource;
    plVendOrd: TppBDEPipeline;
    tblVendOrd: TTable;
    dsVendor: TDataSource;
    plVendor: TppBDEPipeline;
    tblVendor: TTable;
    sbrVendor: TppSubReport;
    ppChildReport2: TppChildReport;
    ppOrderDetailChildReport1DetailBand1: TppDetailBand;
    ppOrderDetailChildReport1Shape4: TppShape;
    ppOrderDetailChildReport1DBText1: TppDBText;
    ppOrderDetailChildReport1DBText2: TppDBText;
    lblPreferred: TppLabel;
    ppOrderDetailChildReport1DBText3: TppDBText;
    ppOrderDetailChildReport1Group1: TppGroup;
    ppOrderDetailChildReport1GroupHeaderBand1: TppGroupHeaderBand;
    ppOrderDetailChildReport1Shape1: TppShape;
    ppOrderDetailChildReport1Label1: TppLabel;
    ppOrderDetailChildReport1Label2: TppLabel;
    ppOrderDetailChildReport1Label3: TppLabel;
    ppOrderDetailChildReport1GroupFooterBand1: TppGroupFooterBand;
    ppGroup2: TppGroup;
    ppGroupHeaderBand2: TppGroupHeaderBand;
    ppGroupFooterBand2: TppGroupFooterBand;
    ppGroup3: TppGroup;
    ppGroupHeaderBand3: TppGroupHeaderBand;
    ppGroupFooterBand3: TppGroupFooterBand;
    procedure varItemTotalCalc(Sender: TObject; var Value: Variant);
    procedure varOrderTotalCalc(Sender: TObject; var Value: Variant);
    procedure ppDetailBand1BeforePrint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lblPreferredPrint(Sender: TObject);
  private
    { Private declarations }
  protected
    function GetReport: TppProducer; override;
  public
    { Public declarations }
  end;

var
  frm0073: Tfrm0073;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ Tfrm0072.FormCreate }

procedure Tfrm0073.FormCreate(Sender: TObject);
begin
  tblVendOrd.Active := False;
  tblVendOrd.DatabaseName := TppFileUtils.GetApplicationShortFilePath;
  tblVendOrd.Active := True;
end; {procedure, FormCreate}

{------------------------------------------------------------------------------}
{ Tfrm0072.GetReport }

function Tfrm0073.GetReport: TppProducer;
begin
  Result := ppReport1;
end; {function, GetReport}

{------------------------------------------------------------------------------}
{ Tfrm0072.varItemTotalCalc }

procedure Tfrm0073.varItemTotalCalc(Sender: TObject; var Value: Variant);
begin
  {calculate item subreport's item total, ItemTotal = Quantity * Price }
  varItemTotal.Value := tblItem.FieldByName('Qty').AsInteger * tblPart.FieldByName('ListPrice').AsFloat;
end; {procedure, varItemTotalCalc}

{------------------------------------------------------------------------------}
{ Tfrm0072.varOrderTotalCalc }

procedure Tfrm0073.varOrderTotalCalc(Sender: TObject; var Value: Variant);
begin
  {calculate item subreport's order total, OrderTotal = Sum(ItemTotal)}
  Value := Value + varItemTotal.Value;
end; {procedure, varOrderTotalCalc}

{------------------------------------------------------------------------------}
{ Tfrm0072.ppOrderDetailDetailBand1BeforePrint }

procedure Tfrm0073.ppDetailBand1BeforePrint(Sender: TObject);
begin
  {when the detail band of the order subreport overflows, show continued label}
  lblContinued.Visible := TppBandedReport(sbrOrder.Report).Detail.OverFlow;
end; {procedure, ppOrderDetailDetailBand1BeforePrint}

{------------------------------------------------------------------------------}
{ Tfrm0072.lblPreferredPrint }

procedure Tfrm0073.lblPreferredPrint(Sender: TObject);
begin

  {use ASCII constants defined above to set check mark}
  if tblVendor.FieldByName('Preferred').AsBoolean then
    lblPreferred.Caption := cCheckMarkInBox
  else
    lblPreferred.Caption := cEmptyBox;

end; {procedure, lblPreferredPrint}

end.
