{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0032;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass, dmUtil, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppTypes, ppProd,
  ppDBPipe, ppVar, ppRelatv;

type
  Tfrm0032 = class(TdmCustomForm)
    dsInvoice: TDataSource;
    ppBDEPipeline1: TppBDEPipeline;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ppReport1: TppReport;
    ppReport1Header: TppHeaderBand;
    ppReport1Label1: TppLabel;
    ppReport1ColumnHeaderBand1: TppColumnHeaderBand;
    ppReport1Detail: TppDetailBand;
    ppReport1Shape2: TppShape;
    ppReport1DBMemo1: TppDBMemo;
    ppReport1ColumnFooterBand1: TppColumnFooterBand;
    ppReport1Footer: TppFooterBand;
    ppReport1Group1: TppGroup;
    ppReport1GroupHeaderBand1: TppGroupHeaderBand;
    ppReport1Shape1: TppShape;
    ppReport1DBText1: TppDBText;
    ppReport1DBImage1: TppDBImage;
    ppReport1GroupFooterBand1: TppGroupFooterBand;
    tblBioLife: TTable;
    ppReport1Calc1: TppSystemVariable;
    ppReport1Calc3: TppSystemVariable;
  private
    { Private declarations }
  protected
    function GetReport: TppProducer; override;
  public
    { Public declarations }
  end;

var
  frm0032: Tfrm0032;

implementation

{$R *.DFM}

function Tfrm0032.GetReport: TppProducer;
begin
  Result := ppReport1;
end;



end.
