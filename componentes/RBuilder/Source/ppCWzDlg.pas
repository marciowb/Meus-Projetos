{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppCWzDlg;

interface

{$I ppIfDef.pas}
     
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  ExtCtrls, Printers, Buttons, TypInfo,
  ppTypes, ppUtils, ppComm, ppClass, ppReport, ppBands, ppCtrls, ppStrtch, ppDB,
  ppMemo, ppClasUt, ppCTMain, ppCTDsgn;

type

  {@TppCrossTabWizardDialog }
  TppCrossTabWizardDialog = class(TForm)
    nbkWizard: TNotebook;
    Bevel19: TBevel;
    Bevel20: TBevel;
    Label34: TLabel;
    lblPage1DataName: TLabel;
    imgSelectFields: TImage;
    lblPage1SelectFields: TLabel;
    cbxDataName: TComboBox;
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
    Label1: TLabel;
    gbxOrientation: TGroupBox;
    imgOrientation: TImage;
    rdbSimpleLandscape: TRadioButton;
    rdbSimplePortrait: TRadioButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Bevel5: TBevel;
    btnCancel: TButton;
    btnBack: TButton;
    btnNext: TButton;
    btnFinish: TButton;
    procedure btnFinishClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure cbxDataNameChange(Sender: TObject);
    procedure gbxSimpleOrientationClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

  private
    FWizard: TPersistent;
    FCrossTabDesigner: TppCrossTabDesigner;

    function GetCrossTab: TppCrossTab;

  public
    procedure LanguageChanged;

    property Wizard: TPersistent read FWizard write FWizard;
    property CrossTab: TppCrossTab read GetCrossTab;
    property CrossTabDesigner: TppCrossTabDesigner read FCrossTabDesigner;

  end; {class, TppReportWizardDialog}

var
  ppCrossTabWizardDialog: TppCrossTabWizardDialog;

implementation

uses
  ppCtWiz;
  
{$R *.DFM}

{******************************************************************************
 *
 ** W I Z A R D   F O R M
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ FormCreate }

procedure TppCrossTabWizardDialog.FormCreate(Sender: TObject);
begin
  FWizard := nil;

  {create the crosstab designer and assign to page 3}
  FCrossTabDesigner := TppCrossTabDesigner.Create(Self);
  FCrossTabDesigner.Parent := TWinControl(nbkWizard.Pages.Objects[1]);

  FCrossTabDesigner.Width  := nbkWizard.Width;
  FCrossTabDesigner.Height := nbkWizard.Height;

  FCrossTabDesigner.Align  := alClient;

end;

{------------------------------------------------------------------------------}
{ FormDestroy }

procedure TppCrossTabWizardDialog.FormDestroy(Sender: TObject);
begin
  FCrossTabDesigner.Free;

end;

{------------------------------------------------------------------------------}
{ GetCrossTab }
function TppCrossTabWizardDialog.GetCrossTab: TppCrossTab;
begin
  if FCrossTabDesigner = nil then
    Result := nil
  else
    Result := FCrossTabDesigner.CrossTab;
end;


{------------------------------------------------------------------------------}
{ FinishClick }

procedure TppCrossTabWizardDialog.btnFinishClick(Sender: TObject);
begin

  TppCrossTabWizard(FWizard).ReportName := edtDescription.Text;

  {indicate to Notebook, whether report should be previewed or modified}
  if rdbPreview.Checked then
    TppCrossTabWizard(FWizard).NextAction := ppnaPreview
  else
    TppCrossTabWizard(FWizard).NextAction := ppnaDesign;

  ModalResult := mrOK;

end;

{------------------------------------------------------------------------------}
{ BackClick }

procedure TppCrossTabWizardDialog.btnBackClick(Sender: TObject);
begin
  TppCrossTabWizard(FWizard).AdvancePage(-1);
end;

{------------------------------------------------------------------------------}
{ NextClick }

procedure TppCrossTabWizardDialog.btnNextClick(Sender: TObject);
begin

  TppCrossTabWizard(FWizard).AdvancePage(1);

end;


{------------------------------------------------------------------------------}
{ cbxDataNameChange }

procedure TppCrossTabWizardDialog.cbxDataNameChange(Sender: TObject);
begin
  TppCrossTabWizard(FWizard).DataName := cbxDataName.Items[cbxDataName.ItemIndex];
end;

{------------------------------------------------------------------------------}
{ SimpleOrientationClick }

procedure TppCrossTabWizardDialog.gbxSimpleOrientationClick(Sender: TObject);
begin
  TppCrossTabWizard(FWizard).Orientation := TPrinterOrientation(TRadioButton(Sender).Tag);
end;


{------------------------------------------------------------------------------}
{ TppReportWizardDialog.LanguageChanged }

procedure TppCrossTabWizardDialog.LanguageChanged;
begin

  if (FWizard = nil) then Exit;


  Caption := ppLoadStr(678); {Crosstab Wizard}

  btnCancel.Caption := ppLoadStr(ppMsgCancel); {Cancel}
  btnNext.Caption   := ppLoadStr(614) + ' >'; {Next}
  btnBack.Caption   := '< ' + ppLoadStr(600); {Back}
  btnFinish.Caption := ppLoadStr(609); {Finish}

  lblPage1SelectFields.Caption     := ppLoadStr(680); {'Specify the data and page orientation'}

  lblPage1DataName.Caption         := ppLoadStr(606); {Data Pipeline Name}

  gbxOrientation.Caption           := ppLoadStr(217); {Orientation}
  rdbSimplePortrait.Caption        := ppLoadStr(148); {&Portrait}
  rdbSimpleLandscape.Caption       := ppLoadStr(147); {&Landscape}

  lblDescription.Caption           := ppLoadStr(617); {Please enter a title for your report.}
  lblPage5ThatsAll.Caption         := ppLoadStr(625); {That is all the information needed to create your report.}
  lblPage5Preview.Caption          := ppLoadStr(607); {Do you want to preview the report of modify the report's design?}
  rdbPreview.Caption               := ppLoadStr(618); {Preview the report}
  rdbDesign.Caption                := ppLoadStr(613); {Modify the report's design}

end; {procedure, LanguageChanged}


end.
