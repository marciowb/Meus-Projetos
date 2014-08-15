{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0114;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ppClass, Db, DBTables, ppDB, dmUtil, ppReport, ppComm, ppCache,
  ppBands, ppPrnabl, ppCtrls, ppDBBDE, Grids, DBGrids, ppProd, ppDBPipe,
  ppRelatv;

type
  Tfrm0114 = class(TdmCustomForm)
    ppReport1: TppReport;
    ppReport1Shape2: TppShape;
    ppReport1Shape3: TppShape;
    ppReport1Shape4: TppShape;
    ppReport1Label2: TppLabel;
    ppReport1Label3: TppLabel;
    ppReport1Label4: TppLabel;
    ppBDEPipeline1: TppBDEPipeline;
    Table1: TTable;
    DataSource1: TDataSource;
    ppReport1DBText1: TppDBText;
    ppReport1DBText2: TppDBText;
    ppReport1DBCalc1: TppDBCalc;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
  private
    { Private declarations }
  protected
    function GetReport: TppProducer; override;
  public
    { Public declarations }
  end;

var
  frm0114: Tfrm0114;

implementation

{$R *.DFM}


function Tfrm0114.GetReport: TppProducer;
begin
  Result := ppReport1;
end;

end.
