{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0012;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass, dmUtil, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppProd, ppDBPipe,
  ppVar, ppRelatv;

type
  Tfrm0012 = class(TdmCustomForm)
    tblCustomer: TTable;
    dsCustomer: TDataSource;
    ppBDEPipeline1: TppBDEPipeline;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ppCustomerList: TppReport;
    ppCustomerListHeader: TppHeaderBand;
    ppCustomerListShape8: TppShape;
    ppCustomerListLabel1: TppLabel;
    ppCustomerListLabel2: TppLabel;
    ppCustomerListLabel3: TppLabel;
    ppCustomerListLabel4: TppLabel;
    ppCustomerListLabel6: TppLabel;
    ppCustomerListLabel7: TppLabel;
    ppCustomerListLabel8: TppLabel;
    ppCustomerListLabel9: TppLabel;
    ppCustomerListDetail: TppDetailBand;
    ppCustomerListDBText2: TppDBText;
    ppCustomerListShape1: TppShape;
    ppCustomerListShape5: TppShape;
    ppCustomerListDBText8: TppDBText;
    ppCustomerListShape4: TppShape;
    ppCustomerListShape6: TppShape;
    ppCustomerListShape3: TppShape;
    ppCustomerListShape2: TppShape;
    ppCustomerListDBText3: TppDBText;
    ppCustomerListDBText4: TppDBText;
    ppCustomerListDBText5: TppDBText;
    ppCustomerListDBText6: TppDBText;
    ppCustomerListFooter: TppFooterBand;
    ppCustomerListCalc1: TppSystemVariable;
    ppCustomerListCalc3: TppSystemVariable;
  private
    { Private declarations }
  protected
    function GetReport: TppProducer; override;
  public
    { Public declarations }
  end;

var
  frm0012: Tfrm0012;

implementation

{$R *.DFM}


function Tfrm0012.GetReport: TppProducer;
begin
  Result := ppCustomerList;
end;








end.
