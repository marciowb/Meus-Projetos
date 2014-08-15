{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                    BBBBB   }

unit dm0110;

{$I ppIfDef.pas}

{----------------------------------------------------}
{To enable the Indy section of this example you must
 first define which version of Indy you currently
 have installed.}

{Remove "x" if you are using Indy 10.}
{x$DEFINE Indy10}

{Remove "x" if you are using Indy 9.}
{x$DEFINE Indy9}

{Remove "x" if you are using Indy 8 or earlier.}
{x$DEFINE Indy8}

{----------------------------------------------------}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ShellAPI, StdCtrls, dmUtil, ppClass, ppBands, ppCache, ppCtrls, ppComm, ppReport,
  ppPrnabl, ppDB, ppDBBDE, Db, DBTables, ppStrtch, ppMemo, ppProd, ppFilDev,
  ppDBPipe, ppRelatv, ppVar, ppTypes, ppSMTPCustom,

  ppSMTPMAPI               //Include MAPI support.

  {$IFDEF Indy10}          //Include Indy support.
    ,ppSMTPIndy10
    {$DEFINE IndyEnabled}
  {$ENDIF}

  {$IFDEF Indy9}
    ,ppSMTPIndy9
    {$DEFINE IndyEnabled}
  {$ENDIF}

  {$IFDEF Indy8}
    ,ppSMTPIndy
    {$DEFINE IndyEnabled}
  {$ENDIF};

type
  Tfrm0110 = class(TdmCustomForm)
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
    btnMAPI: TButton;
    btnIndy: TButton;
    btnPreview: TButton;
    ppSystemVariable3: TppSystemVariable;
    procedure FormCreate(Sender: TObject);
    procedure btnMAPIClick(Sender: TObject);
    procedure btnIndyClick(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
  private
  protected
    function GetReport: TppProducer; override;
    procedure Init; override;
  public
    { Public declarations }
  end;

var
  frm0110: Tfrm0110;

implementation

{$R *.DFM}

const
  cMapiMail = '<< MAPI Mail Demo >>' + #13#10#13#10 +
              'This demo uses MAPI to load your default (MAPI enabled) email' + #13#10 +
              'client and send the attached report.  This will use your default' + #13#10 +
              'email account and settings.  Simply add a recipient and subject' + #13#10 +
              'before sending.';

  cIndyMail = '<< Indy Mail Demo >>' + #13#10#13#10 +
              'This demo uses the Indy SMTP client (IdSMTP) in conjunction with' + #13#10 +
              'the built-in ReportBuilder Email client.  In order to successfully' + #13#10 +
              'send, you will first need to define the server name, user name,' + #13#10 +
              'and password for the email server you wish to use.  This can be' + #13#10 +
              'done using the "Connection" option of the main menu above.  Finally' + #13#10 +
              'add a recipient email and subject and you''re ready to send.' + #13#10#13#10 +
              'Note:  It is possible to define the login options prior to' + #13#10 +
              'displaying this dialog using the TppReport.EmailSettings property.';


procedure Tfrm0110.Init;
begin
  AssignViewer := True;
  DisplayForm := True;
end;

function Tfrm0110.GetReport: TppProducer;
begin
  Result := ppReport1;
end;

procedure Tfrm0110.FormCreate(Sender: TObject);
begin
  ppReport1.PDFSettings.Author := 'ReportBuilder';
  ppReport1.PDFSettings.Title := 'Email Report Demo';

  ppReport1.EmailSettings.FileName := ExtractFilePath(ParamStr(0)) + 'dm' + Copy(Name, 4, 4) + '.pdf';

end;

procedure Tfrm0110.btnMAPIClick(Sender: TObject);
begin
  //Register MAPI plugin...
  TppSMTPPlugIn.RegisterClass(TppSMTPMapi);

  ppReport1.EmailSettings.ShowEmailDialog := False;
  ppReport1.EmailSettings.PreviewInEmailClient := True;

  ppReport1.EmailSettings.Body.Text := cMapiMail;

  ppReport1.SendMail;

end;

procedure Tfrm0110.btnIndyClick(Sender: TObject);
begin
  {$IFDEF IndyEnabled}
  //Register Indy plugin...
  TppSMTPPlugIn.RegisterClass(TppSMTPIndy);

  ppReport1.EmailSettings.ShowEmailDialog := True;
  ppReport1.EmailSettings.PreviewInEmailClient := False;

  ppReport1.EmailSettings.Body.Text := cIndyMail;

  ppReport1.SendMail;
  {$ELSE}
  ShowMessage('Please define the version of Indy you have installed' + #13#10 +
              'at the top of the dm0110.pas file to enable this section' + #13#10 +
              'of the example.');
  {$ENDIF}

end;

procedure Tfrm0110.btnPreviewClick(Sender: TObject);
begin
  //Register MAPI plugin...
  TppSMTPPlugIn.RegisterClass(TppSMTPMapi);

  ppReport1.EmailSettings.ShowEmailDialog := False;
  ppReport1.EmailSettings.PreviewInEmailClient := True;

  ppReport1.EmailSettings.Enabled := True;
  ppReport1.Print;

end;



end.
