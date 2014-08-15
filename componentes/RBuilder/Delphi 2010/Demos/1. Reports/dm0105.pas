{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0105;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dmUtil, ppClass, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppProd, ppFilDev,
  ppDBPipe, ppRelatv;

type
  Tfrm0105 = class(TdmCustomForm)
    ppReport1: TppReport;
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
    ppReport1Shape2: TppShape;
    ppReport1Label2: TppLabel;
    ppReport1DetailBand1: TppDetailBand;
    ppReport1Shape3: TppShape;
    ppReport1Label3: TppLabel;
    ppReport1DBText1: TppDBText;
    ppReport1DBText2: TppDBText;
    ppReport1DBText3: TppDBText;
    ppReport1DBText4: TppDBText;
    ppReport1DBCalc1: TppDBCalc;
    ppReport1FooterBand1: TppFooterBand;
    ppReport1Shape4: TppShape;
    ppReport1Label4: TppLabel;
    procedure FormCreate(Sender: TObject);
    procedure ppReport1SaveText(Sender: TObject; var Text: String);
  private
    { Private declarations }
  protected
    function GetReport: TppProducer; override;
  public
    { Public declarations }
  end;

var
  frm0105: Tfrm0105;

implementation

{$R *.DFM}

function Tfrm0105.GetReport: TppProducer;
begin
  Result := ppReport1;
end;

procedure Tfrm0105.FormCreate(Sender: TObject);
begin
  ppReport1.TextFileName := ExtractFilePath(ParamStr(0)) + 'dm' + Copy(Name, 4, 4) + '.txt';
end;

procedure Tfrm0105.ppReport1SaveText(Sender: TObject; var Text: String);
var
  lDevice: TppTextFileDevice;
begin

  lDevice := TppTextFileDevice(Sender);

  if lDevice.EndingLine then
    Text := Text + #13#10
  else
    Text := Text + '/';

end;


end.
