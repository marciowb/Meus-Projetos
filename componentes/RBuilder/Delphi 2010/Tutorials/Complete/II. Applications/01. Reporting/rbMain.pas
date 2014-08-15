{******************************************************************************}
{                                                                              }
{                   ReportBuilder Tutorials                                    }
{                                                                              }
{             Copyright (c) 1996-2006 Digital Metaphors Corporation            }
{                                                                              }
{******************************************************************************}

unit rbMain;

{$I ppIfDef.pas}

interface

uses
{$IFDEF Delphi7}
  {$IFNDEF Delphi11}
    XPMan,
  {$ENDIF}
{$ENDIF}

  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, rbClass, ppReport, ExtCtrls, ppViewr,


  rbViaWiz, { TfrmViaReportWizard     - creating a report via the report wizard }
  rbViaDT,  { TfrmViaDataTree         - creating a report via the data tree }
  rbCust,   { TfrmCustomerList        - a simple report the hard way }
  rbStock,  { TfrmStockSummary        - groups, calculations and the summary band }
  rbRegion, { TfrmRegions             - using regions to dynamically group components }
  rbFormE,  { TfrmFormsEmulation      - forms emulation with a wmf image }
  rbMD,     { TfrmMasterDetail        - master -> detail report }
  rbMDD,    { TfrmMasterDetailDetail  - master -> detail -> detail report }
  rbDrillD, { TfrmDrillDownSubreport  - interactive previewing with drill-down subreports }
  rbSectSR, { TfrmSectionSubreports   - hooking reports together with section-style subreports }
  rbMailL,  { TfrmMailingLabels       - using columns to create mailing labels }
  rbToTxt,  { TfrmPrintToTextFile     - printing to a text file }
  rbFrmTxt, { TfrmPrintFromTextFile   - printing from a text file }
  rbFrmJIT, { TfrmPrintFromStringGrid - printing a report from a string grid }
  rbMailM;  { TfrmMailMerge           - using the richtext component for mail/merge }

type

  TfrmMain = class(TForm)
    lbxReports: TListBox;
    btnPreview: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure lbxReportsDblClick(Sender: TObject);
  private
    procedure LaunchReport;


  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TfrmMain.FormCreate }

procedure TfrmMain.FormCreate(Sender: TObject);
begin

  lbxReports.Items.AddObject('creating a report via the report wizard', TObject(TfrmViaReportWizard));
  lbxReports.Items.AddObject('creating a report via the data tree', TObject(TfrmViaDataTree));
  lbxReports.Items.AddObject('a simple report the hard way', TObject(TfrmCustomerList));
  lbxReports.Items.AddObject('groups, calculations and the summary band', TObject(TfrmStockSummary));
  lbxReports.Items.AddObject('using regions to dynamically group components', TObject(TfrmRegions));
  lbxReports.Items.AddObject('forms emulation with a wmf image', TObject(TfrmFormsEmulation));
  lbxReports.Items.AddObject('master -> detail report', TObject(TfrmMasterDetail));
  lbxReports.Items.AddObject('master -> detail -> detail report', TObject(TfrmMasterDetailDetail));
  lbxReports.Items.AddObject('interactive previewing with drill-down subreports', TObject(TfrmDrillDownSubreport));
  lbxReports.Items.AddObject('hooking reports together with section-style subreports', TObject(TfrmSectionSubreports));
  lbxReports.Items.AddObject('using columns to create mailing labels', TObject(TfrmMailingLabels));
  lbxReports.Items.AddObject('printing to a text file', TObject(TfrmPrintToTextFile));
  lbxReports.Items.AddObject('printing from a text file', TObject(TfrmPrintFromTextFile));
  lbxReports.Items.AddObject('printing a report from a string grid', TObject(TfrmPrintFromStringGrid));
  lbxReports.Items.AddObject('using the richtext component for mail/merge', TObject(TfrmMailMerge));

end; {procedure, FormCreate}

{------------------------------------------------------------------------------}
{ TfrmMain.btnPreviewClick }

procedure TfrmMain.btnPreviewClick(Sender: TObject);
begin
  LaunchReport;

end; {procedure, btnPreviewClick}

{------------------------------------------------------------------------------}
{ TfrmMain.lbxReportsDblClick }

procedure TfrmMain.lbxReportsDblClick(Sender: TObject);
begin
  LaunchReport;
  
end; {procedure, lbxReportsDblClick}


{------------------------------------------------------------------------------}
{ TfrmMain.LaunchReport }

procedure TfrmMain.LaunchReport;
var
  lFormClass: TFormClass;
  liIndex: Integer;
  lForm: TForm;
  lReport: TppReport;
begin

  liIndex := lbxReports.ItemIndex;

  if (liIndex = -1) then Exit;

  lFormClass := TFormClass(lbxReports.Items.Objects[liIndex]);

  lForm := lFormClass.Create(Application);

  lReport := TrbReportForm(lForm).Report;

  lReport.Print;

  lForm.Free;

end; {procedure, LaunchReport}






end.
