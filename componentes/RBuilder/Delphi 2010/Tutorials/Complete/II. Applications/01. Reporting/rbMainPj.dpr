program rbMainPj;

uses
  Forms,
  rbClass in 'rbClass.pas',
  rbCust in 'rbCust.pas' {frmCustomerList},
  rbDrillD in 'rbDrillD.pas' {frmDrillDownSubreport},
  rbFrmTxt in 'rbFrmTxt.pas' {frmPrintFromTextFile},
  rbMailL in 'rbMailL.pas' {frmMailingLabels},
  rbMailM in 'rbMailM.pas' {frmMailMerge},
  rbMD in 'rbMD.pas' {frmMasterDetail},
  rbMDD in 'rbMDD.pas' {frmMasterDetailDetail},
  rbRegion in 'rbRegion.pas' {frmRegions},
  rbSectSR in 'rbSectSR.pas' {frmSectionSubReports},
  rbStock in 'rbStock.pas' {frmStockSummary},
  rbToTxt in 'rbToTxt.pas' {frmPrintToTextFile},
  rbViaDT in 'rbViaDT.pas' {frmViaDataTree},
  rbMain in 'rbMain.pas' {frmMain},
  rbPrvDlg in 'rbPrvDlg.pas' {rbPrintPreview},
  rbViaWiz in 'rbViaWiz.pas' {frmViaReportWizard},
  rbFormE in 'rbFormE.pas' {frmFormsEmulation},
  rbFrmJIT in 'rbFrmJIT.pas' {frmPrintFromStringGrid};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
