{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0081;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dmUtil, ppClass, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppProd, ppDBPipe,
  ppVar, ppRelatv;

type
  Tfrm0081 = class(TdmCustomForm)
    ppBiolife: TppReport;
    ppReport1Header: TppHeaderBand;
    ppReport1Shape1: TppShape;
    ppReport1Label1: TppLabel;
    ppReport1Label2: TppLabel;
    ppReport1Label3: TppLabel;
    ppReport1Label4: TppLabel;
    ppReport1Label5: TppLabel;
    ppReport1Label6: TppLabel;
    ppReport1Detail: TppDetailBand;
    ppReport1Shape4: TppShape;
    ppReport1Shape5: TppShape;
    ppReport1Shape6: TppShape;
    ppReport1Shape3: TppShape;
    ppReport1Shape2: TppShape;
    ppReport1DBMemo1: TppDBMemo;
    ppReport1DBText1: TppDBText;
    ppReport1DBImage1: TppDBImage;
    ppReport1DBText2: TppDBText;
    ppReport1DBText3: TppDBText;
    ppReport1Footer: TppFooterBand;
    ppReport1Group1: TppGroup;
    ppReport1GroupHeader1: TppGroupHeaderBand;
    ppReport1GroupFooter1: TppGroupFooterBand;
    ppReport1Shape7: TppShape;
    ppReport1Label7: TppLabel;
    ppReport1DBCalc1: TppDBCalc;
    ppReport1Line1: TppLine;
    tblBioLife: TTable;
    dsBioLife: TDataSource;
    ppBDEPipeline1: TppBDEPipeline;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ppReport1Calc1: TppSystemVariable;
    ppReport1Calc2: TppSystemVariable;
  private
    { Private declarations }
  protected
    function GetReport: TppProducer; override;
  public
    { Public declarations }
  end;

var
  frm0081: Tfrm0081;

implementation

{$R *.DFM}

function Tfrm0081.GetReport: TppProducer;
begin
  Result := ppBiolife;
end;



end.
