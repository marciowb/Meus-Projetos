{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0147;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass, dmUtil, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ExtCtrls, ppProd,
  dmEvents, ppDBPipe, ppVar, ppRelatv;

type
  Tfrm0147 = class(TdmCustomForm)
    tblCustomer: TTable;
    dsCustomer: TDataSource;
    plCustomer: TppBDEPipeline;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ppOrderList: TppReport;
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
    ppOrderListHeaderBand1: TppHeaderBand;
    ppOrderListLabel1: TppLabel;
    ppOrderListLabel2: TppLabel;
    ppOrderListShape1: TppShape;
    ppOrderListLabel3: TppLabel;
    ppOrderListLabel4: TppLabel;
    ppOrderListDBText1: TppDBText;
    ppOrderListDBText2: TppDBText;
    ppOrderListDetailBand1: TppDetailBand;
    ppOrderListDBText3: TppDBText;
    ppOrderListDBText4: TppDBText;
    ppOrderListDBText6: TppDBText;
    ppOrderListDBText7: TppDBText;
    ppOrderListLine1: TppLine;
    ppOrderListLine2: TppLine;
    ppOrderListDBText10: TppDBText;
    ppOrderListFooterBand1: TppFooterBand;
    ppOrderListGroup1: TppGroup;
    ppOrderListGroupHeaderBand1: TppGroupHeaderBand;
    ppOrderListShape2: TppShape;
    ppOrderListLabel5: TppLabel;
    ppOrderListLabel6: TppLabel;
    ppOrderListShape3: TppShape;
    ppOrderListShape4: TppShape;
    ppOrderListLabel7: TppLabel;
    ppOrderListLabel9: TppLabel;
    ppOrderListLabel10: TppLabel;
    ppOrderListShape5: TppShape;
    ppOrderListLabel11: TppLabel;
    ppOrderListLabel13: TppLabel;
    ppOrderListLabel15: TppLabel;
    ppOrderListGroupFooterBand1: TppGroupFooterBand;
    ppOrderListLine4: TppLine;
    ppOrderListLine3: TppLine;
    ppOrderListDBText9: TppDBText;
    ppOrderListLabel14: TppLabel;
    ppOrderListDBCalc1: TppDBCalc;
    ppOrderListCalc1: TppSystemVariable;
    ppOrderListCalc2: TppSystemVariable;
    ppOrderListCalc3: TppSystemVariable;
    ppVariable1: TppVariable;
    ppDBCalc1: TppDBCalc;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ppOrderListStartPage(Sender: TObject);
    procedure ppOrderListEndPage(Sender: TObject);
    procedure plCustomerClose(Sender: TObject);
    procedure plCustomerFirst(Sender: TObject);
    procedure plCustomerLast(Sender: TObject);
    procedure plCustomerNext(Sender: TObject);
    procedure plCustomerOpen(Sender: TObject);
    procedure plCustomerPrior(Sender: TObject);
    procedure plCustomerTraversal(Sender: TObject);
    procedure plOrderClose(Sender: TObject);
    procedure plOrderFirst(Sender: TObject);
    procedure plOrderLast(Sender: TObject);
    procedure plOrderNext(Sender: TObject);
    procedure plOrderOpen(Sender: TObject);
    procedure plOrderPrior(Sender: TObject);
    procedure plOrderTraversal(Sender: TObject);
    procedure plEmployeeClose(Sender: TObject);
    procedure plEmployeeFirst(Sender: TObject);
    procedure plEmployeeLast(Sender: TObject);
    procedure plEmployeeNext(Sender: TObject);
    procedure plEmployeeOpen(Sender: TObject);
    procedure plEmployeeTraversal(Sender: TObject);
    procedure plEmployeePrior(Sender: TObject);
    procedure ppVariable1Calc(Sender: TObject; var Value: Variant);
    procedure ppVariable1Reset(Sender: TObject; var Value: Variant);
  private
    FEventTracker: TfrmEvents;
    procedure AddEvent(const aDesc: String);
  protected
    function GetReport: TppProducer; override;
  public
    { Public declarations }
  end;

var
  frm0147: Tfrm0147;

implementation

{$R *.DFM}

function Tfrm0147.GetReport: TppProducer;
begin
  Result := ppOrderList;
end;

procedure Tfrm0147.FormCreate(Sender: TObject);
begin
  FEventTracker := TfrmEvents.Create(Application);
  FEventTracker.Show;
end;

procedure Tfrm0147.FormDestroy(Sender: TObject);
begin
  FEventTracker.Free;
  FEventTracker := nil;
end;

procedure Tfrm0147.AddEvent(const aDesc: String);
begin
  if (FEventTracker <> nil) then
    FEventTracker.AddEvent(aDesc);
end;

procedure Tfrm0147.ppOrderListStartPage(Sender: TObject);
begin
  AddEvent('------------------------------------------------');
  AddEvent('Report.OnStartPage(Page ' + IntToStr(ppOrderList.AbsolutePageNo) + ')');
end;

procedure Tfrm0147.ppOrderListEndPage(Sender: TObject);
begin
  AddEvent('Report.OnEndPage(Page ' + IntToStr(ppOrderList.AbsolutePageNo) + ')');
end;

procedure Tfrm0147.plCustomerClose(Sender: TObject);
begin
  AddEvent('MasterDataPipeline.OnClose');
end;

procedure Tfrm0147.plCustomerFirst(Sender: TObject);
begin
  AddEvent('MasterDataPipeline.OnFirst');
end;

procedure Tfrm0147.plCustomerLast(Sender: TObject);
begin
  AddEvent('MasterDataPipeline.OnLast');
end;

procedure Tfrm0147.plCustomerNext(Sender: TObject);
begin
  AddEvent('MasterDataPipeline.OnNext');
end;

procedure Tfrm0147.plCustomerOpen(Sender: TObject);
begin
  AddEvent('MasterDataPipeline.OnOpen');
end;

procedure Tfrm0147.plCustomerPrior(Sender: TObject);
begin
  AddEvent('MasterDataPipeline.OnPrior');
end;

procedure Tfrm0147.plCustomerTraversal(Sender: TObject);
begin
  AddEvent('MasterDataPipeline.OnTraversal');
end;

procedure Tfrm0147.plOrderClose(Sender: TObject);
begin
  AddEvent('DetailDataPipeline.OnClose');
end;

procedure Tfrm0147.plOrderFirst(Sender: TObject);
begin
  AddEvent('DetailDataPipeline.OnFirst');
end;

procedure Tfrm0147.plOrderLast(Sender: TObject);
begin
  AddEvent('DetailDataPipeline.OnLast');
end;

procedure Tfrm0147.plOrderNext(Sender: TObject);
begin
  AddEvent('DetailDataPipeline.OnNext');
end;

procedure Tfrm0147.plOrderOpen(Sender: TObject);
begin
  AddEvent('DetailDataPipeline.OnOpen');
end;

procedure Tfrm0147.plOrderPrior(Sender: TObject);
begin
  AddEvent('DetailDataPipeline.OnPrior');
end;

procedure Tfrm0147.plOrderTraversal(Sender: TObject);
begin
  AddEvent('DetailDataPipeline.OnTraversal');
end;

procedure Tfrm0147.plEmployeeClose(Sender: TObject);
begin
  AddEvent('LookupDataPipeline.OnClose');
end;

procedure Tfrm0147.plEmployeeFirst(Sender: TObject);
begin
  AddEvent('LookupDataPipeline.OnFirst');
end;

procedure Tfrm0147.plEmployeeLast(Sender: TObject);
begin
  AddEvent('LookupDataPipeline.OnLast');
end;

procedure Tfrm0147.plEmployeeNext(Sender: TObject);
begin
  AddEvent('LookupDataPipeline.OnNext');
end;

procedure Tfrm0147.plEmployeeOpen(Sender: TObject);
begin
  AddEvent('LookupDataPipeline.OnOpen');
end;

procedure Tfrm0147.plEmployeePrior(Sender: TObject);
begin
  AddEvent('LookupDataPipeline.OnPrior');
end;

procedure Tfrm0147.plEmployeeTraversal(Sender: TObject);
begin
  AddEvent('LookupDataPipeline.OnTraversal');
end;

procedure Tfrm0147.ppVariable1Calc(Sender: TObject; var Value: Variant);
begin
  AddEvent('Variable1.OnCalc');
  Value := Value +1;
end;

procedure Tfrm0147.ppVariable1Reset(Sender: TObject; var Value: Variant);
begin
  AddEvent('Variable1.OnReset');
  Value := 1;
end;

end.
