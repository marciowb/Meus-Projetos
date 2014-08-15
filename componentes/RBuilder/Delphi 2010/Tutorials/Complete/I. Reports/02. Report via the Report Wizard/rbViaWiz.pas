{******************************************************************************}
{                                                                              }
{                   ReportBuilder Tutorials                                    }
{                                                                              }
{             Copyright (c) 1996, 2000 Digital Metaphors Corporation           }
{                                                                              }
{******************************************************************************}

unit rbViaWiz;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ppBands, ppCtrls, ppVar, ppPrnabl, ppClass, ppCache, ppDB, ppProd,
  ppReport, ppComm, ppRelatv, ppDBPipe, Db, DBTables, StdCtrls, ppTypes;

type
  TfrmViaReportWizard = class(TForm)
    tblCustomer: TTable;
    dsCustomer: TDataSource;
    plCustomer: TppDBPipeline;
    rbCustomerList: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppTitleBand1: TppTitleBand;
    ppLabel1: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    ppDBText1: TppDBText;
    ppLabel2: TppLabel;
    ppDBText2: TppDBText;
    ppLabel3: TppLabel;
    ppDBText3: TppDBText;
    ppLabel4: TppLabel;
    ppDBText4: TppDBText;
    ppLabel5: TppLabel;
    ppDBText5: TppDBText;
    ppLabel6: TppLabel;
    ppDBText6: TppDBText;
    ppLabel7: TppLabel;
    ppDBText7: TppDBText;
    ppLabel8: TppLabel;
    ppDBText8: TppDBText;
    ppLabel9: TppLabel;
    ppLine1: TppLine;
    ppLine2: TppLine;
    ppColumnHeaderBand1: TppColumnHeaderBand;
    ppColumnFooterBand1: TppColumnFooterBand;
    gbReportStyle: TGroupBox;
    rbTabular: TRadioButton;
    rbVertical: TRadioButton;
    btnPreview: TButton;
    btnPrint: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure rbTabularClick(Sender: TObject);
    procedure rbVerticalClick(Sender: TObject);
  private
    FPathName: String;

  protected
  public
    { Public declarations }
  end;

var
  frmViaReportWizard: TfrmViaReportWizard;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TfrmViaReportWizard.FormCreate }

procedure TfrmViaReportWizard.FormCreate(Sender: TObject);
begin
  {get the path name for this application}
  FPathName := ExtractFilePath(ParamStr(0));

  {set the initial report template file name}
  rbCustomerList.Template.FileName := FPathName + 'CustTab.rtm';

end;

{------------------------------------------------------------------------------}
{ TfrmViaReportWizard.btnPreviewClick }

procedure TfrmViaReportWizard.btnPreviewClick(Sender: TObject);
begin
  {load the template file and print to screen}
  rbCustomerList.Template.LoadFromFile;
  rbCustomerList.DeviceType := dtScreen;
  rbCustomerList.Print;
end;

{------------------------------------------------------------------------------}
{ TfrmViaReportWizard.btnPrintClick }

procedure TfrmViaReportWizard.btnPrintClick(Sender: TObject);
begin
  {load the template file and print to printer}
  rbCustomerList.Template.LoadFromFile;
  rbCustomerList.DeviceType := dtPrinter;
  rbCustomerList.Print;
end;

{------------------------------------------------------------------------------}
{ TfrmViaReportWizard.rbTabularClick }

procedure TfrmViaReportWizard.rbTabularClick(Sender: TObject);
begin
  {set template file name for the tabular report}
  rbCustomerList.Template.FileName := FPathName + 'CustTab.rtm';
end;

{------------------------------------------------------------------------------}
{ TfrmViaReportWizard.rbVerticalClick }

procedure TfrmViaReportWizard.rbVerticalClick(Sender: TObject);
begin
  {set template file name for the vertical report}
  rbCustomerList.Template.FileName := FPathName + 'CustVert.rtm';

end;

end.
