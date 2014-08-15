{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                   BBBBB   }

unit ppRWzDlg;
        
interface

{$I ppIfDef.pas}
     
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  ExtCtrls, Printers, Buttons, TypInfo,
  ppTypes, ppUtils, ppComm, ppClass, ppReport, ppBands, ppCtrls, ppStrtch, ppDB,
  ppMemo, ppClasUt;

type

  {@TppReportWizardDialog }
  TppReportWizardDialog = class(TForm)
    btnFinish: TButton;
    btnCancel: TButton;
    Bevel5: TBevel;
    btnBack: TButton;
    btnNext: TButton;
    nbkWizard: TNotebook;
    Bevel19: TBevel;
    Bevel20: TBevel;
    Label34: TLabel;
    lblPage1DataName: TLabel;
    imgSelectFields: TImage;
    lblPage1SelectFields: TLabel;
    lblPage1AvailableFields: TLabel;
    lblPage1SelectedFields: TLabel;
    spbSelectField: TSpeedButton;
    spbSelectAllFields: TSpeedButton;
    spbDeselectField: TSpeedButton;
    spbDeselectAllFields: TSpeedButton;
    cbxDataName: TComboBox;
    lbxFieldsAvailable: TListBox;
    lbxFieldsSelected: TListBox;
    Bevel21: TBevel;
    imgGroups: TImage;
    lblPage2Priority: TLabel;
    spbMoveGroupUp: TSpeedButton;
    spbMoveGroupDown: TSpeedButton;
    spbSelectGroupField: TSpeedButton;
    spbDeselectGroupField: TSpeedButton;
    lblPage2AvailableFields: TLabel;
    Label41: TLabel;
    lblPage2Groups: TLabel;
    lbxGroupFieldsAvailable: TListBox;
    lbxGroupFieldsSelected: TListBox;
    Bevel22: TBevel;
    Label43: TLabel;
    lblPage3aLayout: TLabel;
    imgSimpleLayout: TImage;
    lblSimpleAdjustField: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    cbxSimpleAdjustField: TCheckBox;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Bevel27: TBevel;
    Bevel28: TBevel;
    imgFinish: TImage;
    lblDescription: TLabel;
    lblPage5ThatsAll: TLabel;
    lblPage5Preview: TLabel;
    edtDescription: TEdit;
    rdbPreview: TRadioButton;
    rdbDesign: TRadioButton;
    Bevel1: TBevel;
    lblPage3bLayout: TLabel;
    lblGroupFieldAdjust: TLabel;
    Label3: TLabel;
    cbxGroupAdjustField: TCheckBox;
    imgGroupLayout: TImage;
    Bevel7: TBevel;
    lblPage4Style: TLabel;
    lbxStyles: TListBox;
    gbxSimpleLayout: TGroupBox;
    rdbLayoutVertical: TRadioButton;
    rdbLayoutTabular: TRadioButton;
    gbxSimpleOrientation: TGroupBox;
    imgSimpleOrientation: TImage;
    rdbSimpleLandscape: TRadioButton;
    rdbSimplePortrait: TRadioButton;
    gbxGroupOrientation: TGroupBox;
    imgGroupOrientation: TImage;
    rdbGroupLandscape: TRadioButton;
    rdbGroupPortrait: TRadioButton;
    gbxGroupLayout: TGroupBox;
    rdbLayoutAlignLeft2: TRadioButton;
    rdbLayoutAlignLeft1: TRadioButton;
    rdbLayoutOutline2: TRadioButton;
    rdbLayoutOutline1: TRadioButton;
    rdbLayoutBlock: TRadioButton;
    rdbLayoutStepped: TRadioButton;
    imgStyle: TImage;
    spbMoveFieldUp: TSpeedButton;
    lblPage1Order: TLabel;
    spbMoveFieldDown: TSpeedButton;
    procedure btnFinishClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure cbxDataNameChange(Sender: TObject);
    procedure gbxGroupLayoutClick(Sender: TObject);
    procedure gbxSimpleLayoutClick(Sender: TObject);
    procedure gbxSimpleOrientationClick(Sender: TObject);
    procedure gbxGroupOrientationClick(Sender: TObject);
    procedure lbxStylesClick(Sender: TObject);
    procedure cbxAdjustFieldClick(Sender: TObject);
    procedure spbSelectFieldClick(Sender: TObject);
    procedure spbSelectAllFieldsClick(Sender: TObject);
    procedure spbDeselectFieldClick(Sender: TObject);
    procedure spbDeselectAllFieldsClick(Sender: TObject);
    procedure spbDeselectGroupFieldClick(Sender: TObject);
    procedure spbSelectGroupFieldClick(Sender: TObject);
    procedure spbMoveGroupDownClick(Sender: TObject);
    procedure spbMoveGroupUpClick(Sender: TObject);
    procedure lblSimpleAdjustFieldClick(Sender: TObject);
    procedure lblGroupFieldAdjustClick(Sender: TObject);
    procedure spbMoveFieldUpClick(Sender: TObject);
    procedure spbMoveFieldDownClick(Sender: TObject);
    procedure lbxFieldsAvailableDblClick(Sender: TObject);
    procedure lbxFieldsSelectedDblClick(Sender: TObject);
    procedure lbxGroupFieldsAvailableDblClick(Sender: TObject);
    procedure lbxGroupFieldsSelectedDblClick(Sender: TObject);

  private
    FWizard: TPersistent;

  public
    procedure LanguageChanged;

    property Wizard: TPersistent read FWizard write FWizard;

  end; {class, TppReportWizardDialog}

var
  ppReportWizardDialog: TppReportWizardDialog;

implementation

uses
  ppRptWiz;
  
{$R *.DFM}

{******************************************************************************
 *
 ** W I Z A R D   F O R M
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ FormCreate }

procedure TppReportWizardDialog.FormCreate(Sender: TObject);
begin
  FWizard := nil;
end;

{------------------------------------------------------------------------------}
{ FinishClick }

procedure TppReportWizardDialog.btnFinishClick(Sender: TObject);
begin

  TppReportWizard(FWizard).ReportName := edtDescription.Text;

  {indicate to Notebook, whether report should be previewed or modified}
  if rdbPreview.Checked then
    TppReportWizard(FWizard).NextAction := ppnaPreview
  else
    TppReportWizard(FWizard).NextAction := ppnaDesign;

  ModalResult := mrOK;

end;

{------------------------------------------------------------------------------}
{ BackClick }

procedure TppReportWizardDialog.btnBackClick(Sender: TObject);
begin
  TppReportWizard(FWizard).AdvancePage(-1);
end;

{------------------------------------------------------------------------------}
{ NextClick }

procedure TppReportWizardDialog.btnNextClick(Sender: TObject);
begin
  TppReportWizard(FWizard).AdvancePage(1);
end;

{------------------------------------------------------------------------------}
{ cbxDataNameChange }

procedure TppReportWizardDialog.cbxDataNameChange(Sender: TObject);
begin
  TppReportWizard(FWizard).DataName := cbxDataName.Items[cbxDataName.ItemIndex];
end;

{------------------------------------------------------------------------------}
{ SimpleLayoutClick }

procedure TppReportWizardDialog.gbxSimpleLayoutClick(Sender: TObject);
begin
  TppReportWizard(FWizard).Layout := TppReportLayoutType(TRadioButton(Sender).Tag);
end;

{------------------------------------------------------------------------------}
{ SimpleOrientationClick }

procedure TppReportWizardDialog.gbxSimpleOrientationClick(Sender: TObject);
begin
  TppReportWizard(FWizard).Orientation := TPrinterOrientation(TRadioButton(Sender).Tag);
end;

{------------------------------------------------------------------------------}
{ GroupLayoutClick }

procedure TppReportWizardDialog.gbxGroupLayoutClick(Sender: TObject);
begin
  TppReportWizard(FWizard).Layout := TppReportLayoutType(TRadioButton(Sender).Tag);
end;

{------------------------------------------------------------------------------}
{ GroupOrientationClick }

procedure TppReportWizardDialog.gbxGroupOrientationClick(Sender: TObject);
begin
  TppReportWizard(FWizard).Orientation := TPrinterOrientation(TRadioButton(Sender).Tag);
end;

{------------------------------------------------------------------------------}
{ StylesClick }

procedure TppReportWizardDialog.lbxStylesClick(Sender: TObject);
begin
  TppReportWizard(FWizard).Style := TppReportStyleType(lbxStyles.ItemIndex);
end;

{------------------------------------------------------------------------------}
{ lbxFieldsAvailableDblClick }

procedure TppReportWizardDialog.lbxFieldsAvailableDblClick(Sender: TObject);
begin
  TppReportWizard(FWizard).AddFieldToSelection;
end; {procedure, lbxFieldsAvailableDblClick}

{------------------------------------------------------------------------------}
{ lbxFieldsSelectedDblClick }

procedure TppReportWizardDialog.lbxFieldsSelectedDblClick(Sender: TObject);
begin
  TppReportWizard(FWizard).RemoveFieldFromSelection;
end; {procedure, lbxFieldsSelectedDblClick}

{------------------------------------------------------------------------------}
{ lbxGroupFieldsAvailableDblClick }

procedure TppReportWizardDialog.lbxGroupFieldsAvailableDblClick(Sender: TObject);
begin
  TppReportWizard(FWizard).AddGroupToSelection;
end; {procedure, lbxGroupFieldsAvailableDblClick}

{------------------------------------------------------------------------------}
{ lbxGroupFieldsSelectedDblClick }

procedure TppReportWizardDialog.lbxGroupFieldsSelectedDblClick(Sender: TObject);
begin
  TppReportWizard(FWizard).RemoveGroupFromSelection;
end; {procedure, lbxGroupFieldsAvailableDblClick}

{------------------------------------------------------------------------------}
{ SelectFieldClick }

procedure TppReportWizardDialog.spbSelectFieldClick(Sender: TObject);
begin
  TppReportWizard(FWizard).AddFieldToSelection;
end;

{------------------------------------------------------------------------------}
{ SelectAllFieldsClick }

procedure TppReportWizardDialog.spbSelectAllFieldsClick(Sender: TObject);
begin
  TppReportWizard(FWizard).AddAllFieldsToSelection;
end;

{------------------------------------------------------------------------------}
{ DeselectFieldClick }

procedure TppReportWizardDialog.spbDeselectFieldClick(Sender: TObject);
begin
  TppReportWizard(FWizard).RemoveFieldFromSelection;
end;

{------------------------------------------------------------------------------}
{ DeselectAllFieldsClick }

procedure TppReportWizardDialog.spbDeselectAllFieldsClick(Sender: TObject);
begin
  TppReportWizard(FWizard).RemoveAllFieldsFromSelection;
end;

{------------------------------------------------------------------------------}
{ SelectGroupFieldClick }

procedure TppReportWizardDialog.spbSelectGroupFieldClick(Sender: TObject);
begin
  TppReportWizard(FWizard).AddGroupToSelection;
end;

{------------------------------------------------------------------------------}
{ DeselectGroupFieldClick }

procedure TppReportWizardDialog.spbDeselectGroupFieldClick(Sender: TObject);
begin
  TppReportWizard(FWizard).RemoveGroupFromSelection;
end;

{------------------------------------------------------------------------------}
{ MoveGroupDownClick }

procedure TppReportWizardDialog.spbMoveGroupDownClick(Sender: TObject);
begin
  TppReportWizard(FWizard).ChangeGroupPosition(1);
end;

{------------------------------------------------------------------------------}
{ MoveGroupUpClick }

procedure TppReportWizardDialog.spbMoveGroupUpClick(Sender: TObject);
begin
  TppReportWizard(FWizard).ChangeGroupPosition(-1);
end;

{------------------------------------------------------------------------------}
{ MoveFieldUpClick }

procedure TppReportWizardDialog.spbMoveFieldUpClick(Sender: TObject);
begin
  TppReportWizard(FWizard).ChangeFieldPosition(-1);
end;

{------------------------------------------------------------------------------}
{ MoveFieldDownClick }

procedure TppReportWizardDialog.spbMoveFieldDownClick(Sender: TObject);
begin
  TppReportWizard(FWizard).ChangeFieldPosition(1);
end;

{------------------------------------------------------------------------------}
{ AdjustFieldWidthClick }

procedure TppReportWizardDialog.cbxAdjustFieldClick(Sender: TObject);
begin
  TppReportWizard(FWizard).AdjustFieldWidth := TCheckBox(Sender).Checked;
end;

{------------------------------------------------------------------------------}
{ SimpleAdjustFieldClick }

procedure TppReportWizardDialog.lblSimpleAdjustFieldClick(Sender: TObject);
begin
  cbxSimpleAdjustField.Checked := not(cbxSimpleAdjustField.Checked);

  cbxAdjustFieldClick(cbxSimpleAdjustField)
end;

{------------------------------------------------------------------------------}
{ GroupAdjustFieldClick }

procedure TppReportWizardDialog.lblGroupFieldAdjustClick(Sender: TObject);
begin
  cbxGroupAdjustField.Checked := not(cbxGroupAdjustField.Checked);

  cbxAdjustFieldClick(cbxGroupAdjustField)
end;

{------------------------------------------------------------------------------}
{ TppReportWizardDialog.LanguageChanged }

procedure TppReportWizardDialog.LanguageChanged;
begin

  if (FWizard = nil) then Exit;


  Caption := ppLoadStr(620); {Report Wizard}

  btnCancel.Caption := ppLoadStr(ppMsgCancel); {Cancel}
  btnNext.Caption   := ppLoadStr(614) + ' >'; {Next}
  btnBack.Caption   := '< ' + ppLoadStr(600); {Back}
  btnFinish.Caption := ppLoadStr(609); {Finish}

  lblPage1SelectFields.Caption     := ppLoadStr(629); {Which fields do you want on your report?}
  lblPage1AvailableFields.Caption  := ppLoadStr(599); {Available Fields}
  lblPage1SelectedFields.Caption   := ppLoadStr(621); {Selected Fields}
  lblPage1DataName.Caption         := ppLoadStr(606); {Data Pipeline Name}
  lblPage1Order.Caption            := ppLoadStr(255); {Order}

  lblPage2AvailableFields.Caption  := ppLoadStr(599); {Available Fields}
  lblPage2Groups.Caption           := ppLoadStr(204); {Groups}
  lblPage2Priority.Caption         := ppLoadStr(619); {Priority}

  lblPage3aLayout.Caption          := ppLoadStr(611); {How would you like to lay out your report?}
  gbxSimpleLayout.Caption          := ppLoadStr(612); {Layout}
  rdbLayoutTabular.Caption         := ppLoadStr(624); {Tabular}
  rdbLayoutVertical.Caption        := ppLoadStr(626); {Vertical}
  lblSimpleAdjustField.Caption     := ppLoadStr(596); {Adjust field widths so all fields fit on page.}
  gbxSimpleOrientation.Caption     := ppLoadStr(217); {Orientation}
  rdbSimplePortrait.Caption        := ppLoadStr(148); {&Portrait}
  rdbSimpleLandscape.Caption       := ppLoadStr(147); {&Landscape}

  lblPage3bLayout.Caption          := ppLoadStr(217); {Orientation}
  gbxGroupLayout.Caption           := ppLoadStr(612); {Layout}
  rdbLayoutStepped.Caption         := ppLoadStr(623); {Stepped}
  rdbLayoutBlock.Caption           := ppLoadStr(601); {Block}
  rdbLayoutOutline1.Caption        := ppLoadStr(615); {Outline 1}
  rdbLayoutOutline2.Caption        := ppLoadStr(616); {Outline 2}
  rdbLayoutAlignLeft1.Caption      := ppLoadStr(597); {Align Left 1}
  rdbLayoutAlignLeft2.Caption      := ppLoadStr(598); {Align Left 2}
  lblGroupFieldAdjust.Caption      := ppLoadStr(596); {Adjust field widths so all fields fit on page.}
  gbxGroupOrientation.Caption      := ppLoadStr(217); {Orientation}
  rdbGroupPortrait.Caption         := ppLoadStr(148); {&Portrait}
  rdbGroupLandscape.Caption        := ppLoadStr(147); {&Landscape}

  lblPage4Style.Caption            := ppLoadStr(627); {What style would you like?}
  lbxStyles.Items[0]               := ppLoadStr(602); {Bold}
  lbxStyles.Items[1]               := ppLoadStr(603); {Casual}
  lbxStyles.Items[2]               := ppLoadStr(604); {Compact}
  lbxStyles.Items[3]               := ppLoadStr(605); {Corporate}
  lbxStyles.Items[4]               := ppLoadStr(610); {Formal}
  lbxStyles.Items[5]               := ppLoadStr(622); {Soft Gray}

  lblDescription.Caption           := ppLoadStr(617); {Please enter a title for your report.}
  lblPage5ThatsAll.Caption         := ppLoadStr(625); {That is all the information needed to create your report.}
  lblPage5Preview.Caption          := ppLoadStr(607); {Do you want to preview the report or modify the report's design?}
  rdbPreview.Caption               := ppLoadStr(618); {Preview the report}
  rdbDesign.Caption                := ppLoadStr(613); {Modify the report's design}

end; {procedure, LanguageChanged}





end.
