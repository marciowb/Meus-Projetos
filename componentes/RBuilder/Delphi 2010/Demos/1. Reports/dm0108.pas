{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0108;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dmUtil, ppClass, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppProd, ppFilDev,
  ppDBPipe, ppRelatv, ppVar,
  ppTypes,
  ppPDFDevice; // include PDF support

type
  Tfrm0108 = class(TdmCustomForm)
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
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppTitleBand1: TppTitleBand;
    ppLabel1: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    ppDBText1: TppDBText;
    ppLabel2: TppLabel;
    ppDBImage1: TppDBImage;
    ppLabel3: TppLabel;
    ppDBMemo1: TppDBMemo;
    ppLabel4: TppLabel;
    ppLine1: TppLine;
    ppLine2: TppLine;
    procedure FormCreate(Sender: TObject);
    procedure ppReport1PrintDialogCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    function GetReport: TppProducer; override;
  public
    { Public declarations }
  end;

var
  frm0108: Tfrm0108;

implementation

{$R *.DFM}

function Tfrm0108.GetReport: TppProducer;
begin
  Result := ppReport1;
end;

procedure Tfrm0108.FormCreate(Sender: TObject);
begin
  ppReport1.AllowPrintToFile := True;
  ppReport1.DeviceType := dtPDF;

  ppReport1.PDFSettings.Author := 'ReportBuilder';
  ppReport1.PDFSettings.Title := 'Export to PDF Demo';
  ppReport1.PDFSettings.OpenPDFFile := True;

  ppReport1.TextFileName := ExtractFilePath(ParamStr(0)) + 'dm' + Copy(Name, 4, 4) + '.pdf';
end;

procedure Tfrm0108.ppReport1PrintDialogCreate(Sender: TObject);
begin
  ppReport1.PrintDialog.DeviceType := dtPDF;
  ppReport1.PrintDialog.PrintToFile := True;

end;

end.
