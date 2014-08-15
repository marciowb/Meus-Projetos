{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppLWzDlg;

interface

{$I ppIfDef.pas}
     
uses

  Windows,
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  ExtCtrls, Printers, Buttons, TypInfo,
  ppTypes, ppUtils, ppComm, ppClass, ppReport, ppBands, ppCtrls, 
  ppClasUt, ppRelatv, ppProd, ppViewr, ppPrnabl, ppCache,
  ppLabelDef;

type

  {@TppLabelTemplateWizardDialog }
  TppLabelTemplateWizardDialog = class(TForm)
    nbkWizard: TNotebook;
    Label1: TLabel;
    Panel1: TPanel;
    Bevel5: TBevel;
    btnCancel: TButton;
    btnOK: TButton;
    Panel2: TPanel;
    Bevel3: TBevel;
    Bevel2: TBevel;
    lblLabelInfoType: TLabel;
    lblLabelInfoHeight: TLabel;
    lblLabelInfoWidth: TLabel;
    lblLabelInfoPageSize: TLabel;
    lblType: TLabel;
    lblHeight: TLabel;
    lblWidth: TLabel;
    lblPageSize: TLabel;
    lblLabelInfo: TLabel;
    bvlPrinterType: TBevel;
    lblPrinterInfo: TLabel;
    lblProducts: TLabel;
    lbxLabels: TListBox;
    rbDotMatrix: TRadioButton;
    rbLaserJet: TRadioButton;
    cbxLabelProducts: TComboBox;
    ppViewer1: TppViewer;
    cbxPaperTrays: TComboBox;
    lblPaperTray: TLabel;
    ppReport1: TppReport;
    ppDetailBand1: TppDetailBand;
    ppShape1: TppShape;
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lbxLabelsClick(Sender: TObject);
    procedure rbPrinterTypeClick(Sender: TObject);
    procedure cbxLabelProductsChange(Sender: TObject);

  private
    FWizard: TPersistent;
    FPrinterType: TppLabelPrinterType;
    FLabelDef: TppLabelDefRec;

    function GetLabelSet: TppLabelSetClass;
    function GetBinName: String;

    procedure DisplayLabelInfo;
    procedure InitializePaperTrayList;
    procedure InitializeReport;
    procedure SetPrinterType(aPrinterType: TppLabelPrinterType);
    procedure UpdateLabelList;

  public
    procedure LanguageChanged;

    property Wizard: TPersistent read FWizard write FWizard;

    property LabelDef: TppLabelDefRec read FLabelDef;
    property BinName: String read GetBinName;

  end; {class, TppReportWizardDialog}

var
  ppLabelTemplateWizardDialog: TppLabelTemplateWizardDialog;

implementation

uses
  ppLabWiz;
  
{$R *.DFM}

{******************************************************************************
 *
 ** W I Z A R D   F O R M
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppLabelTemplateWizardDialog.FormCreate }

procedure TppLabelTemplateWizardDialog.FormCreate(Sender: TObject);
begin
  FWizard := nil;

  SetPrinterType(ptLaserJet);

  InitializePaperTrayList;

  lblPrinterInfo.Transparent := False;
  lblLabelInfo.Transparent := False;
  lblProducts.Transparent := False;

end;  {procedure, FormCreate}

{------------------------------------------------------------------------------}
{ TppLabelTemplateWizardDialog.GetBinName }

function TppLabelTemplateWizardDialog.GetBinName: String;
begin

  if (cbxPaperTrays.ItemIndex >= 0) then
    Result := cbxPaperTrays.Items[cbxPaperTrays.ItemIndex]
  else
    Result := '';

end; {function, GetBinName}

{------------------------------------------------------------------------------}
{ TppLabelTemplateWizardDialog.GetLabelSet }

function TppLabelTemplateWizardDialog.GetLabelSet: TppLabelSetClass;
begin

  if (cbxLabelProducts.ItemIndex >= 0) then
    Result := TppLabelSetClass(cbxLabelProducts.Items.Objects[cbxLabelProducts.ItemIndex])
  else
    Result := nil;

end; {function, GetLabelSet}

{------------------------------------------------------------------------------}
{ TppLabelTemplateWizardDialog.InitializePaperTrayList }

procedure TppLabelTemplateWizardDialog.InitializePaperTrayList;
var
  liIndex: Integer;
  
begin

  {get list of paper trays from report's printersetup}
  cbxPaperTrays.Items.Assign(ppReport1.PrinterSetup.BinNames);

  {initial default is the first bin}
  cbxPaperTrays.ItemIndex := 0;

  {attempt to default to 'manual' paper tray}
  for liIndex := 0 to cbxPaperTrays.Items.Count-1 do

    if Pos('Manual', cbxPaperTrays.Items[liIndex]) > 0 then
      cbxPaperTrays.ItemIndex := liIndex;


end; {procedure, InitializePaperTrayList}

{------------------------------------------------------------------------------}
{ TppLabelTemplateWizardDialog.InitializeReport }

procedure TppLabelTemplateWizardDialog.InitializeReport;
begin

  {assign the label definition settings to the report}
  TppLabelSet.AssignLabelDefToReport(FLabelDef, ppReport1);

  {assign Label size to the report's Shape control - this draws the label outline}
  ppShape1.Width  := FLabelDef.Width;
  ppShape1.Height := FLabelDef.Height;

end; {procedure, InitializeReport}

{------------------------------------------------------------------------------}
{ TppLabelTemplateWizardDialog.DisplayLabelInfo }

procedure TppLabelTemplateWizardDialog.DisplayLabelInfo;
var
  lLabelSet: TppLabelSetClass;
  lsUnits: String;

begin

  lLabelSet := GetLabelSet;

  if (lLabelSet = nil) then Exit;

  FLabelDef := lLabelSet.GetLabelDefRec(lbxLabels.ItemIndex);

  {configure report}
  InitializeReport;

  case FLabelDef.Units of
    utInches: lsUnits := '"';
    utMillimeters: lsUnits := 'mm';
  else
    lsUnits := '';
  end;


  {update label information description}
  lblType.Caption     := FLabelDef.LabelType;
  lblHeight.Caption   := FloatToStrF(FLabelDef.Height, ffGeneral, 7, 0) + lsUnits;
  lblWidth.Caption    := FloatToStrF(FLabelDef.Width,  ffGeneral, 7, 0) + lsUnits;

  {use PaperName if not a custom paper size}
  if CompareText(ppReport1.PrinterSetup.PaperName,'Custom') <> 0 then
    lblPageSize.Caption := ppReport1.PrinterSetup.PaperName
  else
    lblPageSize.Caption := '(' + FloatToStrF(FLabelDef.PaperWidth,  ffGeneral, 7, 0) + ' x ' +
                                 FloatToStrF(FLabelDef.PaperHeight, ffGeneral, 7, 0) + ')';


  {update the report viewer}
  ppViewer1.Reset;
  ppReport1.PrintToDevices;

end;  {procedure, DisplayLabelInfo}

{------------------------------------------------------------------------------}
{ TppLabelTemplateWizardDialog.UpdateLabelList }

procedure TppLabelTemplateWizardDialog.UpdateLabelList;
begin

  {get list of labels for this product}
  ppGetLabelDefs(cbxLabelProducts.Text, FPrinterType, lbxLabels.Items);

  {select first item in the list}
  if lbxLabels.Items.Count > 0 then
    lbxLabels.ItemIndex := 0;

  DisplayLabelInfo;

end; {procedure, UpdateLabelList}

{------------------------------------------------------------------------------}
{ TppLabelTemplateWizardDialog.SetPrinterType }

procedure TppLabelTemplateWizardDialog.SetPrinterType(aPrinterType: TppLabelPrinterType);
begin
  FPrinterType := aPrinterType;

  ppGetLabelProducts(aPrinterType, cbxLabelProducts.Items);

  {try to default to Avery Standard}
  cbxLabelProducts.ItemIndex := cbxLabelProducts.Items.IndexOf('Avery Standard');

  if (cbxLabelProducts.ItemIndex < 0) and (cbxLabelProducts.Items.Count > 0) then
    cbxLabelProducts.ItemIndex := 0;

  UpdateLabelList;

end; {procedure, SetPrinterType}

{------------------------------------------------------------------------------}
{ TppLabelTemplateWizardDialog.lbxLabelsClick }

procedure TppLabelTemplateWizardDialog.lbxLabelsClick(Sender: TObject);
begin
  if ppReport1.Printing then Exit;

  DisplayLabelInfo;

end; {procedure, lbxLabelsClick}

{------------------------------------------------------------------------------}
{ TppLabelTemplateWizardDialog.rbPrinterTypeClick }

procedure TppLabelTemplateWizardDialog.rbPrinterTypeClick(Sender: TObject);
var
  lComponent: TComponent;
  lPrinterType: TppLabelPrinterType;

begin
  lComponent := TComponent(Sender);
  lPrinterType := TppLabelPrinterType(lComponent.Tag);

  SetPrinterType(lPrinterType);

end; {procedure, rbPrinterTypeClick}

{------------------------------------------------------------------------------}
{ TppLabelTemplateWizardDialog.cbxLabelProductsChange }

procedure TppLabelTemplateWizardDialog.cbxLabelProductsChange( Sender: TObject);
begin
  UpdateLabelList;
end; {procedure, cbxLabelProductsChange}

{------------------------------------------------------------------------------}
{ TppLabelTemplateWizardDialog.FinishClick }

procedure TppLabelTemplateWizardDialog.btnOKClick(Sender: TObject);
begin

  ModalResult := mrOK;

end; {procedure, btnFinishClick}

{------------------------------------------------------------------------------}
{ TppReportWizardDialog.LanguageChanged }

procedure TppLabelTemplateWizardDialog.LanguageChanged;
begin

  if (FWizard = nil) then Exit;

  Caption := ppLoadStr(1119); {'Label Templates'}

  lblPrinterInfo.Caption := ppLoadStr(1120); {'Printer information'}
  rbDotMatrix.Caption   := ppLoadStr(1121); {'Dot Matrix'}
  rbLaserJet.Caption    := ppLoadStr(1122); {'Laser and ink jet'}

  lblPaperTray.Caption := ppLoadStr(221); {'Paper Tray'}

  lblProducts.Caption  := ppLoadStr(1123); {'Products'}

  lblLabelInfo.Caption := ppLoadStr(1124); {'Label information'}

  lblLabelInfoType.Caption     := ppLoadStr(588); {'Type'}
  lblLabelInfoHeight.Caption   := ppLoadStr(184); {'Height'}
  lblLabelInfoWidth.Caption    := ppLoadStr(183); {'Width'}
  lblLabelInfoPageSize.Caption := ppLoadStr(219); {'Paper Size'}


  btnCancel.Caption := ppLoadStr(ppMsgCancel);
  btnOK.Caption     := ppLoadStr(ppMsgOK);

end; {procedure, LanguageChanged}


end.
