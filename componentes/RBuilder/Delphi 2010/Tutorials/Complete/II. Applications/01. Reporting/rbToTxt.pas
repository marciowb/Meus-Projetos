{******************************************************************************}
{                                                                              }
{                   ReportBuilder Tutorials                                    }
{                                                                              }
{             Copyright (c) 1996, 2000 Digital Metaphors Corporation           }
{                                                                              }
{******************************************************************************}

unit rbToTxt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ppBands, ppCtrls, ppVar, ppPrnabl, ppClass, ppCache, ppDB, ppProd,
  ppReport, ppComm, ppRelatv, ppDBPipe, Db, DBTables, StdCtrls, ppTypes, rbClass;

type

  {Note: This form is setup to run as part of the main tutorial project.
         It descends from TrbReportForm which is defined in rbClass.pas.

         You will need to add rbClass.pas to any project that uses this form.
         The rbClass.pas unit is part of the main tutorial project. }



  TfrmPrintToTextFile = class(TrbReportForm)
    tblCustomer: TTable;
    dsCustomer: TDataSource;
    plCustomer: TppDBPipeline;
    rbPrintData: TppReport;
    gbReportStyle: TGroupBox;
    rbTabular: TRadioButton;
    rbVertical: TRadioButton;
    btnPrint: TButton;
    ppTitleBand1: TppTitleBand;
    ppLabel1: TppLabel;
    ppHeaderBand1: TppHeaderBand;
    ppLine1: TppLine;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppLabel8: TppLabel;
    ppLabel9: TppLabel;
    ppDetailBand1: TppDetailBand;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppDBText8: TppDBText;
    ppFooterBand1: TppFooterBand;
    ppLine2: TppLine;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    procedure FormCreate(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure rbTabularClick(Sender: TObject);
    procedure rbVerticalClick(Sender: TObject);
  private
    FPathName: String;
  protected
    function GetReport: TppReport; override;
  public
    { Public declarations }
  end;

var
  frmPrintToTextFile: TfrmPrintToTextFile;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TfrmPrintToTextFile.GetReport }

function TfrmPrintToTextFile.GetReport: TppReport;
begin
  Result := rbPrintData;

end; {function, GetReport}

{------------------------------------------------------------------------------}
{ TfrmPrintToTextFile.FormCreate }

procedure TfrmPrintToTextFile.FormCreate(Sender: TObject);
begin
  {get the path name for this application}
  FPathName := ExtractFilePath(ParamStr(0));

  {set the initial report template file name}
  rbPrintData.Template.FileName := FPathName + 'CustTab.rtm';

end;

{------------------------------------------------------------------------------}
{ TfrmPrintToTextFile.btnPreviewClick }

procedure TfrmPrintToTextFile.btnPreviewClick(Sender: TObject);
begin
  {load the template file and print to screen}
  rbPrintData.Template.LoadFromFile;
  rbPrintData.DeviceType := dtScreen;
  rbPrintData.Print;
end;

{------------------------------------------------------------------------------}
{ TfrmPrintToTextFile.btnPrintClick }

procedure TfrmPrintToTextFile.btnPrintClick(Sender: TObject);
begin
  {load the template file and print to printer}
  rbPrintData.Template.LoadFromFile;

  if rbTabular.Checked then
    begin
      rbPrintData.AllowPrintToFile := True;
      rbPrintData.TextFileName := FPathName + 'Customer.txt';
      rbPrintData.DeviceType   := dtTextFile;
    end
  else
    begin
      rbPrintData.AllowPrintToFile := False;
      rbPrintData.TextFileName := '';
      rbPrintData.DeviceType := dtPrinter;
    end;

  rbPrintData.Print;

end;

{------------------------------------------------------------------------------}
{ TfrmPrintToTextFile.rbTabularClick }

procedure TfrmPrintToTextFile.rbTabularClick(Sender: TObject);
begin
  {set template file name for the tabular report}
  rbPrintData.Template.FileName := FPathName + 'CustTab.rtm';
end;

{------------------------------------------------------------------------------}
{ TfrmPrintToTextFile.rbVerticalClick }

procedure TfrmPrintToTextFile.rbVerticalClick(Sender: TObject);
begin
  {set template file name for the vertical report}
  rbPrintData.Template.FileName := FPathName + 'CustVert.rtm';

end;

end.
