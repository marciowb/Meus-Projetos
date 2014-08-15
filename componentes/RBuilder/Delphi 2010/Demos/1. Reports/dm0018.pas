{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0018;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass, dmUtil, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppRegion, ppProd,
  ppDBPipe, ppVar, ppRelatv;

type
  Tfrm0018 = class(TdmCustomForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ppBDEPipeline1: TppBDEPipeline;
    DataSource1: TDataSource;
    Query1: TQuery;
    Label10: TLabel;
    ppReport1: TppReport;
    ppReport1HeaderBand1: TppHeaderBand;
    ppReport1Label1: TppLabel;
    ppReport1DetailBand1: TppDetailBand;
    ppReport1DBText3: TppDBText;
    ppReport1DBCalc2: TppDBCalc;
    ppReport1DBText5: TppDBText;
    ppReport1FooterBand1: TppFooterBand;
    ppReport1Group1: TppGroup;
    ppReport1GroupHeaderBand1: TppGroupHeaderBand;
    ppReport1DBText1: TppDBText;
    ppReport1DBText4: TppDBText;
    ppReport1GroupFooterBand1: TppGroupFooterBand;
    ppReport1DBText2: TppDBText;
    ppReport1DBCalc1: TppDBCalc;
    ppReport1Calc2: TppSystemVariable;
    ppReport1Calc3: TppSystemVariable;
    ppDBCalc1: TppDBCalc;
    ppLine1: TppLine;
    ppLine2: TppLine;
  private
    { Public declarations }
  protected
    function GetReport: TppProducer; override;
  public
    { Public declarations }
  end;

var
  frm0018: Tfrm0018;

implementation

{$R *.DFM}


{------------------------------------------------------------------------------}
{Tfrm0017.GetReport}

function Tfrm0018.GetReport: TppProducer;
begin
  Result := ppReport1;
end;


end.
