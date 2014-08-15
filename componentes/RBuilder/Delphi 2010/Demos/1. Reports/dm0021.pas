{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0021;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass, dmUtil, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppProd, ppDBPipe,
  ppVar, ppRelatv;

type
  Tfrm0021 = class(TdmCustomForm)
    tblBiolife: TTable;
    dsBiolife: TDataSource;
    plBiolife: TppBDEPipeline;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ppReport1: TppReport;
    ppCustomerListHeader: TppHeaderBand;
    ppCustomerListLabel1: TppLabel;
    ppCustomerListLabel2: TppLabel;
    ppCustomerListDetail: TppDetailBand;
    ppCustomerListFooter: TppFooterBand;
    ppCustomerListDBImage1: TppDBImage;
    ppReport1Label1: TppLabel;
    ppReport1Label2: TppLabel;
    ppReport1DBImage2: TppDBImage;
    ppReport1Label3: TppLabel;
    ppReport1DBImage1: TppDBImage;
    ppReport1DBImage3: TppDBImage;
    ppReport1Label4: TppLabel;
    ppReport1Shape1: TppShape;
    ppReport1Shape2: TppShape;
    ppReport1Shape3: TppShape;
    ppReport1Shape4: TppShape;
    ppReport1Label5: TppLabel;
    ppReport1Label6: TppLabel;
    ppReport1Line1: TppLine;
    ppReport1Line2: TppLine;
    ppReport1SummaryBand1: TppSummaryBand;
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
  frm0021: Tfrm0021;

implementation

{$R *.DFM}


function Tfrm0021.GetReport: TppProducer;
begin
  Result := ppReport1;
end;








end.
