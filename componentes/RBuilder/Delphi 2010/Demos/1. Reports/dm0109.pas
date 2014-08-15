{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0109;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ShellAPI,
  StdCtrls, dmUtil, ppClass, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppProd, ppFilDev,
  ppDBPipe, ppRelatv, ppVar,
  ppTypes,
  ppPDFDevice; // include PDF support

type
  Tfrm0109 = class(TdmCustomForm)
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
    btnGenerate: TButton;
    btnSaveToFile: TButton;
    btnAcrobat: TButton;
    ppSystemVariable3: TppSystemVariable;
    procedure FormCreate(Sender: TObject);
    procedure btnGenerateClick(Sender: TObject);
    procedure btnSaveToFileClick(Sender: TObject);
    procedure btnAcrobatClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FOutputStream: TMemoryStream;
  protected
    function GetReport: TppProducer; override;
    procedure Init; override;
  public
    { Public declarations }
  end;

var
  frm0109: Tfrm0109;

implementation

{$R *.DFM}


procedure Tfrm0109.Init;
begin
  AssignViewer := True;
  DisplayForm := True;
end;

function Tfrm0109.GetReport: TppProducer;
begin
  Result := ppReport1;
end;

procedure Tfrm0109.FormCreate(Sender: TObject);
begin
  ppReport1.AllowPrintToFile := True;
  ppReport1.DeviceType := dtPDF;

  ppReport1.PDFSettings.Author := 'ReportBuilder';
  ppReport1.PDFSettings.Title := 'Export to PDF Demo';
  ppReport1.PDFSettings.OpenPDFFile := True;

  ppReport1.TextFileName := ExtractFilePath(ParamStr(0)) + 'dm' + Copy(Name, 4, 4) + '.pdf';
end;

procedure Tfrm0109.FormDestroy(Sender: TObject);
begin

  FOutputStream.Free;

end;

procedure Tfrm0109.btnGenerateClick(Sender: TObject);
var
  lPDFDevice: TppPDFDevice;
begin

  // delete existing file
  if FileExists(ppReport1.TextFileName) then
    DeleteFile(ppReport1.TextFileName);


  // creat and configure the PDFDevice
  lPDFDevice := TppPDFDevice.Create(nil);

  if (FOutputStream = nil) then
    FOutputStream := TMemoryStream.Create
  else
    FOutputStream.Clear;

  try
    lPDFDevice.PDFSettings := ppReport1.PDFSettings;
    lPDFDevice.OutputStream := FOutputStream;        // assign output stream
    lPDFDevice.Publisher := ppReport1.Publisher;

    // generate the report
    ppReport1.PrintToDevices;

    btnSaveToFile.Enabled := True;

  finally
    lPDFDevice.Free;
  end;

end;


const
  cFileExtension = 'pdf';
  cFileFilter    = 'Adobe Acrobat file (*.pdf)|*.pdf';

procedure Tfrm0109.btnSaveToFileClick(Sender: TObject);
var
  lSaveDlg: TSaveDialog;
begin

  if FileExists(ppReport1.TextFileName) then
    DeleteFile(ppReport1.TextFileName);

  if (FOutputStream = nil) or (FOutputStream.Size = 0) then
    begin
      ShowMessage('Please generate the report');
      Exit;

    end;

  // create and display Save To File dialog
  lSaveDlg := TSaveDialog.Create(Application);
  lSaveDlg.DefaultExt := cFileExtension;
  lSaveDlg.Filter     := cFileFilter;
  lSaveDlg.Options    := [ofOverWritePrompt, ofPathMustExist, ofHideReadOnly];
  lSaveDlg.FileName   := ppReport1.TextFileName;

  try

  if lSaveDlg.Execute then
    begin
      // save the output stream to the file
      ppReport1.TextFileName := lSaveDlg.FileName;
      FOutputStream.SaveToFile(lSaveDlg.FileName);

      btnAcrobat.Enabled := True;

    end;

  finally
    lSaveDlg.Free;
  end;

end;

procedure Tfrm0109.btnAcrobatClick(Sender: TObject);
begin
  if FileExists(ppReport1.TextFileName) then
    ShellExecute(0, PChar('open'), PChar(ppReport1.TextFileName), PChar(''), PChar(ExtractFilePath(ppReport1.TextFileName)), SW_SHOWNORMAL)
  else
    ShowMessage('No file exists: ' + ppReport1.TextFileName);


end;



end.
