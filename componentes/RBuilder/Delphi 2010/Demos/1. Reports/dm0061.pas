{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0061;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass, dmUtil, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ExtCtrls, ppProd,
  ppDBPipe, ppVar, ppRelatv, ppSubRpt;

type
  Tfrm0061 = class(TdmCustomForm)
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
    ppOrderListFooterBand1: TppFooterBand;
    ppOrderListCalc1: TppSystemVariable;
    ppOrderListCalc2: TppSystemVariable;
    ppOrderListCalc3: TppSystemVariable;
    ppSubReport1: TppSubReport;
    ppChildReport1: TppChildReport;
    ppDetailBand1: TppDetailBand;
    ppOrderListDBText3: TppDBText;
    ppOrderListDBText6: TppDBText;
    ppOrderListDBText10: TppDBText;
    ppOrderListDBText4: TppDBText;
    ppOrderListDBText8: TppDBText;
    ppOrderListDBText5: TppDBText;
    ppOrderListDBText7: TppDBText;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppOrderListShape2: TppShape;
    ppOrderListLabel5: TppLabel;
    ppOrderListLabel6: TppLabel;
    ppOrderListShape3: TppShape;
    ppOrderListShape4: TppShape;
    ppOrderListLabel7: TppLabel;
    ppOrderListLabel8: TppLabel;
    ppOrderListLabel9: TppLabel;
    ppOrderListLabel10: TppLabel;
    ppOrderListShape5: TppShape;
    ppOrderListLabel11: TppLabel;
    ppOrderListLabel12: TppLabel;
    ppOrderListLabel13: TppLabel;
    ppOrderListLabel15: TppLabel;
    ppOrderListLine4: TppLine;
    ppOrderListLine3: TppLine;
    ppOrderListDBText9: TppDBText;
    ppOrderListLabel14: TppLabel;
    ppOrderListDBCalc1: TppDBCalc;
    ppOrderListLine1: TppLine;
    ppOrderListLine2: TppLine;
  private
    { Private declarations }
  protected
    function GetReport: TppProducer; override;
  public
    { Public declarations }
  end;

var
  frm0061: Tfrm0061;

implementation

{$R *.DFM}


function Tfrm0061.GetReport: TppProducer;
begin
  Result := ppOrderList;
end;

















end.
