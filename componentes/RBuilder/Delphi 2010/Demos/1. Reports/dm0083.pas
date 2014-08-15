{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0083;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dmUtil, ppClass, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppProd, ppDBPipe,
  ppRelatv;

type
  Tfrm0083 = class(TdmCustomForm)
    tblBioLife: TTable;
    dsBioLife: TDataSource;
    ppBDEPipeline1: TppBDEPipeline;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ppReport1: TppReport;
    ppReport1HeaderBand1: TppHeaderBand;
    ppReport1Label1: TppLabel;
    ppReport1Line1: TppLine;
    ppReport1DetailBand1: TppDetailBand;
    ppReport1DBMemo2: TppDBMemo;
    ppReport1Memo1: TppMemo;
    ppReport2Memo1: TppMemo;
    ppReport1FooterBand1: TppFooterBand;
  private
    { Private declarations }
  protected
    function GetReport: TppProducer; override;
  public
    { Public declarations }
  end;

var
  frm0083: Tfrm0083;

implementation

{$R *.DFM}

function Tfrm0083.GetReport: TppProducer;
begin
  Result := ppReport1;
end;



end.
