{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0041;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dmUtil, ppClass, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppRegion, ppProd,
  ppDBPipe, ppVar, ppRelatv;

type
  Tfrm0041 = class(TdmCustomForm)
    ppReport1: TppReport;
    ppReport1Detail: TppDetailBand;
    tblBioLife: TTable;
    tblBioLifeSpeciesNo: TFloatField;
    tblBioLifeCategory: TStringField;
    tblBioLifeCommon_Name: TStringField;
    tblBioLifeSpeciesName: TStringField;
    tblBioLifeLengthcm: TFloatField;
    tblBioLifeLength_In: TFloatField;
    tblBioLifeNotes: TMemoField;
    tblBioLifeGraphic: TGraphicField;
    dsBioLife: TDataSource;
    ppBDEPipeline1: TppBDEPipeline;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ppReport1HeaderBand1: TppHeaderBand;
    ppReport1FooterBand1: TppFooterBand;
    ppReport1Region2: TppRegion;
    ppReport1DBMemo1: TppDBMemo;
    ppReport1Region1: TppRegion;
    ppReport1DBText1: TppDBText;
    ppReport1DBText2: TppDBText;
    ppReport1DBText3: TppDBText;
    ppReport1Label1: TppLabel;
    ppReport1Label3: TppLabel;
    ppReport1Label4: TppLabel;
    ppReport1Label5: TppLabel;
    ppReport1DBText4: TppDBText;
    ppReport1Label2: TppLabel;
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
  frm0041: Tfrm0041;

implementation

{$R *.DFM}

function Tfrm0041.GetReport: TppProducer;
begin
  Result := ppReport1;
end;



end.
