{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0028;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass, dmUtil, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppRichTx, ppProd,
  ppDBPipe, ppRelatv;

type
  Tfrm0028 = class(TdmCustomForm)
    tblBiolife: TTable;
    dsBiolife: TDataSource;
    plBioLife: TppBDEPipeline;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ppReport1: TppReport;
    ppReport1DetailBand1: TppDetailBand;
    ppRichText1: TppRichText;
    ppReport1DBImage1: TppDBImage;
  private
    { Private declarations }
  protected
    function GetReport: TppProducer; override;
  public
    { Public declarations }
  end;

var
  frm0028: Tfrm0028;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{Tfrm0028.GetReport}

function Tfrm0028.GetReport: TppProducer;
begin
  Result := ppReport1;
end;



end.
