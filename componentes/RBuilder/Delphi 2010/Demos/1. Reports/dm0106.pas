{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0106;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dmUtil, ppClass, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppFilDev, ppProd,
  ppDBPipe, ppRelatv;

type
  Tfrm0106 = class(TdmCustomForm)
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
    procedure ppReport1SaveText(Sender: TObject; var Text: String);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    function GetReport: TppProducer; override;
  public
    { Public declarations }
  end;

var
  frm0106: Tfrm0106;

implementation

{$R *.DFM}

function Tfrm0106.GetReport: TppProducer;
begin
  Result := ppReport1;
end;

procedure Tfrm0106.FormCreate(Sender: TObject);
begin
  ppReport1.TextFileName := ExtractFilePath(ParamStr(0)) + 'dm' + Copy(Name, 4, 4) + '.txt';
end;

procedure Tfrm0106.ppReport1SaveText(Sender: TObject; var Text: String);
const
  cDelimiter = '><';
  cCRLF = #13#10;
var
  lDevice: TppTextFileDevice;
  lsText: String;
begin

  lDevice := TppTextFileDevice(Sender);

  lsText := '';

  {describe any starting coniditions}
  if lDevice.StartingPage then
    lsText := lsText + '----Starting Page----' + cCRLF;

  if lDevice.FirstLine and lDevice.StartingLine then
    lsText := lsText + '----First Line----' + cCRLF;

  {add the text item}
  if lDevice.StartingLine then
    lsText := lsText + '<Line ' + IntToStr(lDevice.LineNo) + '><' + Text + cDelimiter

  else if lDevice.EndingLine then
    lsText := lsText + Text + '><Line ' + IntToStr(lDevice.LineNo) + ', ' + IntToStr(lDevice.LineItemNo) + ' items>' + cCRLF

  else
    lsText := lsText + Text + cDelimiter;

  {describe any ending conditions}
  if lDevice.LastLine and lDevice.EndingLine then
    lsText := lsText + '----Last Line----' + cCRLF;

  if lDevice.EndingPage then
    lsText := lsText + '----Ending Page----' + cCRLF ;

  Text := lsText;

end;





end.
