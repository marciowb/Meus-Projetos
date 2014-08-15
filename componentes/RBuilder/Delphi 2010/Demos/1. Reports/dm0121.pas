{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dm0121;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Spin, Tabnotbk, Printers, 
  ppClass, ppTypes, ppUtils, ppBands, ppPrnabl, ppCtrls, ppCache,
  ppComm, ppReport, ppPrintr, dmUtil, ppProd, ppRelatv, ComCtrls;

type


  Tfrm0121 = class(TdmCustomForm)
    nbkPageSetup: TTabbedNotebook;
    lblPaperSize: TLabel;
    cbxPaperName: TComboBox;
    lblWidth: TLabel;
    lblHeight: TLabel;
    gbxOrientation: TGroupBox;
    rdbPortrait: TRadioButton;
    rdbLandscape: TRadioButton;
    lbxBinName: TListBox;
    lblPaperTray: TLabel;
    lbxBinOtherPages: TListBox;
    lblOtherPages: TLabel;
    spinPaperHeight: TSpinButton;
    edtPaperHeight: TEdit;
    imgLandScape: TImage;
    imgPortrait: TImage;
    edtPaperWidth: TEdit;
    spinPaperWidth: TSpinButton;
    lblPaperSource: TLabel;
    lblMarginTop: TLabel;
    edtMarginTop: TEdit;
    spinMarginTop: TSpinButton;
    lblMarginBottom: TLabel;
    edtMarginBottom: TEdit;
    spinMarginBottom: TSpinButton;
    lblMarginLeft: TLabel;
    lblMarginRight: TLabel;
    edtMarginLeft: TEdit;
    spinMarginLeft: TSpinButton;
    edtMarginRight: TEdit;
    spinMarginRight: TSpinButton;
    lblMargins: TLabel;
    lblPrinter: TLabel;
    cbxDuplex: TComboBox;
    edtCopies: TEdit;
    SpinCopies: TSpinButton;
    Label1: TLabel;
    edtDocumentName: TEdit;
    cbxPrinterName: TComboBox;
    Label3: TLabel;
    lblDuplex: TLabel;
    rdbCollationYes: TRadioButton;
    rdbCollationNo: TRadioButton;
    Label2: TLabel;
    btnPrint: TButton;
    btnPreview: TButton;
    ppReport1: TppReport;
    ppReport1Header: TppHeaderBand;
    ppReport1HeaderShape: TppShape;
    ppReport1Detail: TppDetailBand;
    ppReport1LeftShape: TppShape;
    ppReport1RightShape: TppShape;
    ppReport1Footer: TppFooterBand;
    ppReport1FooterShape: TppShape;
    procedure edtPaperWidthChange(Sender: TObject);
    procedure edtPaperHeightChange(Sender: TObject);
    procedure rdbPortraitClick(Sender: TObject);
    procedure rdbLandscapeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbxPaperNameChange(Sender: TObject);
    procedure edtPaperWidthKeyPress(Sender: TObject; var Key: Char);
    procedure edtPaperHeightKeyPress(Sender: TObject; var Key: Char);
    procedure spinPaperWidthDownClick(Sender: TObject);
    procedure spinPaperWidthUpClick(Sender: TObject);
    procedure spinPaperHeightDownClick(Sender: TObject);
    procedure spinPaperHeightUpClick(Sender: TObject);
    procedure lbxBinNameClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtMarginTopChange(Sender: TObject);
    procedure edtMarginTopKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarginBottomChange(Sender: TObject);
    procedure edtMarginBottomKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarginLeftChange(Sender: TObject);
    procedure edtMarginLeftKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarginRightChange(Sender: TObject);
    procedure edtMarginRightKeyPress(Sender: TObject; var Key: Char);
    procedure spinMarginTopDownClick(Sender: TObject);
    procedure spinMarginTopUpClick(Sender: TObject);
    procedure spinMarginBottomDownClick(Sender: TObject);
    procedure spinMarginBottomUpClick(Sender: TObject);
    procedure spinMarginLeftDownClick(Sender: TObject);
    procedure spinMarginLeftUpClick(Sender: TObject);
    procedure spinMarginRightDownClick(Sender: TObject);
    procedure spinMarginRightUpClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbxPrinterNameChange(Sender: TObject);
    procedure edtDocumentNameExit(Sender: TObject);
    procedure edtDocumentNameKeyPress(Sender: TObject; var Key: Char);
    procedure edtCopiesExit(Sender: TObject);
    procedure edtCopiesKeyPress(Sender: TObject; var Key: Char);
    procedure SpinCopiesDownClick(Sender: TObject);
    procedure SpinCopiesUpClick(Sender: TObject);
    procedure rdbCollationYesClick(Sender: TObject);
    procedure rdbCollationNoClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cbxDuplexChange(Sender: TObject);
    
  private
    FReport: TppCustomReport;
    FSavePrinterSetup: TppPrinterSetup;
    FLanguageIndex: Longint;

    FSpinIncrement: Single;
    FMarginSpinIncrement: Single;

    procedure PaperChange;
    procedure PrinterChange;
    procedure SetLanguage(aLanguageIndex: Longint);
    procedure SetReport(aReport: TppCustomReport);


  protected
    function GetReport: TppProducer; override;
    procedure Init; override;

  public

  end;

var
  frm0121: Tfrm0121;

implementation


{$R *.DFM}

{note: the ReportBuilder IDE strings are in rbIDE.res}

{$R rbIDE.Res}


{------------------------------------------------------------------------------}
{ Tfrm0121.Init}

procedure Tfrm0121.Init;
begin
  {initialize inherited properties for the demo form}
  AssignViewer := True;
  DisplayForm  := True;
end;

{------------------------------------------------------------------------------}
{ Tfrm0121.FormCreate}

procedure Tfrm0121.FormCreate(Sender: TObject);
begin

  FSavePrinterSetup := TppPrinterSetup.Create(Self);

  SetReport(ppReport1);
  SetLanguage(ppReport1.LanguageIndex);

  {make sure first page is the activepage}
  nbkPageSetup.ActivePage := 'Printer';

end; {procedure, FormCreate}

{------------------------------------------------------------------------------}
{ Tfrm0121.FormDestroy}

procedure Tfrm0121.FormDestroy(Sender: TObject);
begin
  FSavePrinterSetup.Free;

end; {procedure, FormDestroy}

{------------------------------------------------------------------------------}
{ Tfrm0121.FormClose}

procedure Tfrm0121.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

{------------------------------------------------------------------------------}
{ Tfrm0121.FormActivate}

procedure Tfrm0121.FormActivate(Sender: TObject);
begin
  {note: use 'PrintToDevices' to print to a custom viewer}
  ppReport1.PrintToDevices;

end;

{------------------------------------------------------------------------------}
{ Tfrm0121.GetReport }

function Tfrm0121.GetReport: TppProducer;
begin
  Result := ppReport1;
end;

{------------------------------------------------------------------------------}
{ Tfrm0121.SetReport}

procedure Tfrm0121.SetReport(aReport: TppCustomReport);
var
  lPrinterSetup: TppPrinterSetup;

begin

  FReport := aReport;


  {save current printer setup settings}
  FSavePrinterSetup.Assign(ppReport1.PrinterSetup);

  {set increment for paper size spin controls based on Units }
  case FReport.Units of
    utInches:        FSpinIncrement  := 0.5;
    utMillimeters:   FSpinIncrement  := 5.0;
    utScreenPixels:  FSpinIncrement  := 50.0;
    utPrinterPixels: FSpinIncrement  := 300.0;
    utMMThousandths: FSpinIncrement  := 5000.0;
  end;

  {set increment for margin spin controls based on Units }
  case FReport.Units of
    utInches:        FMarginSpinIncrement  := 0.10;
    utMillimeters:   FMarginSpinIncrement  := 1;
    utScreenPixels:  FMarginSpinIncrement  := 1.0;
    utPrinterPixels: FMarginSpinIncrement  := 50.0;
    utMMThousandths: FMarginSpinIncrement  := 1000.0;
  end;

  {initialize form controls}
  lPrinterSetup := FReport.PrinterSetup;

  cbxPrinterName.Items := lPrinterSetup.PrinterNames;
  edtDocumentName.Text := 'PrintJob1';
  edtCopies.Text := IntToStr(lPrinterSetup.Copies);
  rdbCollationYes.Checked := lPrinterSetup.Collation;
  rdbCollationNo.Checked  := not lPrinterSetup.Collation;
  cbxDuplex.ItemIndex := 0;


  PrinterChange;


end; {procedure, SetReport}

{------------------------------------------------------------------------------}
{ Tfrm0121.btnPreviewClick}

procedure Tfrm0121.btnPreviewClick(Sender: TObject);
begin
 {note: use 'PrintToDevices' to print to a custom viewer}
  ppReport1.ResetDevices;
  ppReport1.PrintToDevices;
end;


{------------------------------------------------------------------------------}
{ Tfrm0121.btnPrintClick}

procedure Tfrm0121.btnPrintClick(Sender: TObject);
begin

  {print to printer}
  ppReport1.Device := dvPrinter;
  ppReport1.Print;

end; {procedure, btnApplyClick}

{------------------------------------------------------------------------------}
{ Tfrm0121.PrinterChange}

procedure Tfrm0121.PrinterChange;
var
  lPrinterSetup: TppPrinterSetup;

begin

  lPrinterSetup := FReport.PrinterSetup;

  {get the currently selected printer name}
  cbxPrinterName.ItemIndex := cbxPrinterName.Items.IndexOf(lPrinterSetup.PrinterName);

  {initialize paper names, bin names lists}
  cbxPaperName.Items   := lPrinterSetup.PaperNames;
  lbxBinName.Items     := lPrinterSetup.BinNames;

  PaperChange;

end; {procedure, PrinterChange}

{------------------------------------------------------------------------------}
{ Tfrm0121.PaperChange}

procedure Tfrm0121.PaperChange;
var
  lPrinterSetup: TppPrinterSetup;

begin

  lPrinterSetup := FReport.PrinterSetup;

  cbxPaperName.Text := lPrinterSetup.PaperName;

  edtPaperWidth.Text      := FloatToStrF(lPrinterSetup.PaperWidth,   ffGeneral,  7, 0);
  edtPaperHeight.Text     := FloatToStrF(lPrinterSetup.PaperHeight,  ffGeneral,  7, 0);
  edtMarginTop.Text       := FloatToStrF(lPrinterSetup.MarginTop,    ffGeneral,  7, 0);
  edtMarginBottom.Text    := FloatToStrF(lPrinterSetup.MarginBottom, ffGeneral,  7, 0);
  edtMarginLeft.Text      := FloatToStrF(lPrinterSetup.MarginLeft,   ffGeneral,  7, 0);
  edtMarginRight.Text     := FloatToStrF(lPrinterSetup.MarginRight,  ffGeneral,  7, 0);

  rdbPortrait.Checked     := (lPrinterSetup.Orientation = poPortrait);
  rdbLandscape.Checked    := (lPrinterSetup.Orientation = poLandscape);
  imgPortrait.Visible     := (lPrinterSetup.Orientation = poPortrait);
  imgLandscape.Visible    := (lPrinterSetup.Orientation = poLandscape);

  lbxBinName.ItemIndex   := lbxBinName.Items.IndexOf(lPrinterSetup.BinName);


  {draw an outline on page, the size of the printable area}
  ppReport1HeaderShape.Width := lPrinterSetup.PrintableWidth;
  ppReport1FooterShape.Width := lPrinterSetup.PrintableWidth;

  ppReport1RightShape.Left := lPrinterSetup.PrintableWidth - ppReport1RightShape.Width;


end; {procedure, PaperChange}


{******************************************************************************
 *
 ** P R I N T E R  P A G E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ Tfrm0121.cbxPrinterNameChange}

procedure Tfrm0121.cbxPrinterNameChange(Sender: TObject);
begin
  FReport.PrinterSetup.PrinterName := cbxPrinterName.Text;
  PrinterChange;

end;

{------------------------------------------------------------------------------}
{ Tfrm0121.edtDocumentNameExit}

procedure Tfrm0121.edtDocumentNameExit(Sender: TObject);
begin
  FReport.PrinterSetup.DocumentName := edtDocumentName.Text;
end;

{------------------------------------------------------------------------------}
{ Tfrm0121.edtDocumentNameKeyPress}

procedure Tfrm0121.edtDocumentNameKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = chEnterKey) then
    edtDocumentNameExit(Self);

end;

{------------------------------------------------------------------------------}
{ Tfrm0121.edtCopiesExit}

procedure Tfrm0121.edtCopiesExit(Sender: TObject);
var
  liCopies: Integer;

begin

 try
    liCopies := StrToInt(edtCopies.Text);
    if liCopies >= 1 then
      FReport.PrinterSetup.Copies := StrToInt(edtCopies.Text);
  except on EConvertError do
    MessageDlg(LoadStr(FLanguageIndex + 377), mtWarning, [mbOK], 0);
  end;

end;

{------------------------------------------------------------------------------}
{ Tfrm0121.edtCopiesKeyPress}

procedure Tfrm0121.edtCopiesKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = chEnterKey) then
    edtCopiesExit(Self);

end;

{------------------------------------------------------------------------------}
{ Tfrm0121.SpinCopiesDownClick}

procedure Tfrm0121.SpinCopiesDownClick(Sender: TObject);
begin

  if (FReport.PrinterSetup.Copies = 1) then Exit;

  FReport.PrinterSetup.Copies :=  FReport.PrinterSetup.Copies - 1;

  edtCopies.Text := IntToStr(FReport.PrinterSetup.Copies);

end;

{------------------------------------------------------------------------------}
{ Tfrm0121.SpinCopiesUpClick}

procedure Tfrm0121.SpinCopiesUpClick(Sender: TObject);
begin

  FReport.PrinterSetup.Copies :=  FReport.PrinterSetup.Copies + 1;

  edtCopies.Text := IntToStr(FReport.PrinterSetup.Copies);

end;

{------------------------------------------------------------------------------}
{ Tfrm0121.rdbCollationYesClick}

procedure Tfrm0121.rdbCollationYesClick(Sender: TObject);
begin
  FReport.PrinterSetup.Collation := True;
end;

{------------------------------------------------------------------------------}
{ Tfrm0121.rdbCollationNoClick}

procedure Tfrm0121.rdbCollationNoClick(Sender: TObject);
begin
  FReport.PrinterSetup.Collation := False;
end;

{------------------------------------------------------------------------------}
{ Tfrm0121.cbxDuplexChange}

procedure Tfrm0121.cbxDuplexChange(Sender: TObject);
begin

 {defined in ppTypes.pas: TppDuplexType = (dpNone, dpHorizontal, dpVertical);}

  FReport.PrinterSetup.Duplex := TppDuplexType(cbxDuplex.ItemIndex);

end;


{******************************************************************************
 *
 ** P A P E R S I Z E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ Tfrm0121.cbxPaperNameChange}

procedure Tfrm0121.cbxPaperNameChange(Sender: TObject);
begin
  FReport.PrinterSetup.PaperName := cbxPaperName.Text;
  PaperChange;
end; {procedure, cbxPaperNameChange}

{------------------------------------------------------------------------------}
{ Tfrm0121.edtPaperWidthChange}

procedure Tfrm0121.edtPaperWidthChange(Sender: TObject);
begin
  try
    FReport.PrinterSetup.PaperWidth := StrToFloat(edtPaperWidth.Text);
  except on EConvertError do
    MessageDlg(LoadStr(FLanguageIndex + 377), mtWarning, [mbOK], 0);
  end;

  PaperChange;

end; {procedure, edtPaperWidthChange}

{------------------------------------------------------------------------------}
{ Tfrm0121.spinPaperWidthDownClick}

procedure Tfrm0121.spinPaperWidthDownClick(Sender: TObject);
begin
  with FReport.PrinterSetup do
    PaperWidth := PaperWidth - FSpinIncrement;

  PaperChange;
end; {procedure, spinPaperWidthDownClick}

{------------------------------------------------------------------------------}
{ Tfrm0121.spinPaperWidthUpClick}

procedure Tfrm0121.spinPaperWidthUpClick(Sender: TObject);
begin
  with FReport.PrinterSetup do
    PaperWidth := PaperWidth + FSpinIncrement;
 PaperChange;

end; {procedure, spinPaperWidthUpClick}

{------------------------------------------------------------------------------}
{ Tfrm0121.edtPaperWidthKeyPress}

procedure Tfrm0121.edtPaperWidthKeyPress(Sender: TObject; var Key: Char);
begin
   if (Key = chEnterKey) then
     edtPaperWidthChange(Self);

end; {procedure, edtPaperWidthKeyPress}

{------------------------------------------------------------------------------}
{ Tfrm0121.edtPaperHeightChange}

procedure Tfrm0121.edtPaperHeightChange(Sender: TObject);
begin

  try
    FReport.PrinterSetup.PaperHeight := StrToFloat(edtPaperHeight.Text);
  except on EConvertError do
    MessageDlg(LoadStr(FLanguageIndex + 377), mtWarning, [mbOK], 0);
  end;

  PaperChange;

end; {procedure, edtPaperHeightChange}

{------------------------------------------------------------------------------}
{ Tfrm0121.spinPaperHeightDownClick}

procedure Tfrm0121.spinPaperHeightDownClick(Sender: TObject);
begin
  with FReport.PrinterSetup do
    PaperHeight := PaperHeight - FSpinIncrement;
  PaperChange;

end; {procedure, spinPaperHeightDownClick}

{------------------------------------------------------------------------------}
{ Tfrm0121.spinPaperHeightUpClick}

procedure Tfrm0121.spinPaperHeightUpClick(Sender: TObject);
begin
  with FReport.PrinterSetup do
    PaperHeight := PaperHeight + FSpinIncrement;
  PaperChange;

end; {procedure, spinPaperHeightUpClick}

{------------------------------------------------------------------------------}
{ Tfrm0121.edtPaperHeightKeyPress}

procedure Tfrm0121.edtPaperHeightKeyPress(Sender: TObject; var Key: Char);
begin
   if (Key = chEnterKey) then
     edtPaperHeightChange(Self);

end; {procedure, edtPaperHeightKeyPress}

{------------------------------------------------------------------------------}
{ Tfrm0121.rdbPortraitClick}

procedure Tfrm0121.rdbPortraitClick(Sender: TObject);
begin
  FReport.PrinterSetup.Orientation := poPortrait;
  PaperChange;
end; {procedure, rdbPortraitClick}

{------------------------------------------------------------------------------}
{ Tfrm0121.rdbLandscapeClick}

procedure Tfrm0121.rdbLandscapeClick(Sender: TObject);
begin
  FReport.PrinterSetup.Orientation := poLandscape;
  PaperChange;
end; {procedure, rdbLandscapeClick}



{******************************************************************************
 *
 ** P A P E R S O U R C E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ Tfrm0121.lbxBinNamesClick}

procedure Tfrm0121.lbxBinNameClick(Sender: TObject);
begin
  FReport.PrinterSetup.BinName := lbxBinName.Items[lbxBinName.ItemIndex];
end; {procedure, lbxBinNamesClick}


{******************************************************************************
 *
 ** M A R G I N S
 *
{******************************************************************************}


{------------------------------------------------------------------------------}
{ Tfrm0121.edtMarginTopChange}


procedure Tfrm0121.edtMarginTopChange(Sender: TObject);
begin
  try
    FReport.PrinterSetup.MarginTop := StrToFloat(edtMarginTop.Text);
    PaperChange;
  except on EConvertError do
    MessageDlg(LoadStr(FLanguageIndex + 377), mtWarning, [mbOK], 0);
  end;

end; {procedure, edtMarginTopChange}

{------------------------------------------------------------------------------}
{ Tfrm0121.edtMarginTopKeyPress}

procedure Tfrm0121.edtMarginTopKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = chEnterKey) then
    edtMarginTopChange(Self);
end;  {procedure, edtMarginTopKeyPress}

{------------------------------------------------------------------------------}
{ Tfrm0121.edtMarginBottomChange}

procedure Tfrm0121.edtMarginBottomChange(Sender: TObject);
begin
  try
    FReport.PrinterSetup.MarginBottom := StrToFloat(edtMarginBottom.Text);
    PaperChange;
  except on EConvertError do
    MessageDlg(LoadStr(FLanguageIndex + 377), mtWarning, [mbOK], 0);
  end;

end; {procedure, edtMarginBottomChange}

{------------------------------------------------------------------------------}
{ Tfrm0121.edtMarginBottomKeyPress}

procedure Tfrm0121.edtMarginBottomKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = chEnterKey) then
    edtMarginBottomChange(Self);

end; {procedure, edtMarginBottomKeyPress}

{------------------------------------------------------------------------------}
{ Tfrm0121.edtMarginLeftChange}

procedure Tfrm0121.edtMarginLeftChange(Sender: TObject);
begin
  try
    FReport.PrinterSetup.MarginLeft := StrToFloat(edtMarginLeft.Text);
    PaperChange;
  except on EConvertError do
    MessageDlg(LoadStr(FLanguageIndex + 377), mtWarning, [mbOK], 0);
  end;

end; {procedure, edtMarginLeftChange}

{------------------------------------------------------------------------------}
{ Tfrm0121.edtMarginLeftKeyPress}

procedure Tfrm0121.edtMarginLeftKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = chEnterKey) then
    edtMarginLeftChange(Self);

end; {procedure, edtMarginLeftKeyPress}

{------------------------------------------------------------------------------}
{ Tfrm0121.edtMarginRightChange}

procedure Tfrm0121.edtMarginRightChange(Sender: TObject);
begin
  try
    FReport.PrinterSetup.MarginRight := StrToFloat(edtMarginRight.Text);
    PaperChange;
  except on EConvertError do
    MessageDlg(LoadStr(FLanguageIndex + 377), mtWarning, [mbOK], 0);
  end;

end; {procedure, edtMarginRightChange}

{------------------------------------------------------------------------------}
{ Tfrm0121.edtMarginRightKeyPress}

procedure Tfrm0121.edtMarginRightKeyPress(Sender: TObject; var Key: Char);
begin
   if (Key = chEnterKey) then
    edtMarginRightChange(Self);

end; {procedure, edtMarginRightKeyPress}

{------------------------------------------------------------------------------}
{ Tfrm0121.spinMarginTopDownClick}

procedure Tfrm0121.spinMarginTopDownClick(Sender: TObject);
begin
  with FReport.PrinterSetup do
    MarginTop := MarginTop - FMarginSpinIncrement;

  PaperChange;

end; {procedure, spinMarginTopDownClick}

{------------------------------------------------------------------------------}
{ Tfrm0121.spinMarginTopUpClick}

procedure Tfrm0121.spinMarginTopUpClick(Sender: TObject);
begin
  with FReport.PrinterSetup do
    MarginTop := MarginTop + FMarginSpinIncrement;

  PaperChange;

end; {procedure, spinMarginTopUpClick}

{------------------------------------------------------------------------------}
{ Tfrm0121.spinMarginBottomDownClick}

procedure Tfrm0121.spinMarginBottomDownClick(Sender: TObject);
begin
  with FReport.PrinterSetup do
    MarginBottom := MarginBottom - FMarginSpinIncrement;

  PaperChange;

end; {procedure, spinMarginBottomDownClick}

{------------------------------------------------------------------------------}
{ Tfrm0121.spinMarginBottomUpClick}

procedure Tfrm0121.spinMarginBottomUpClick(Sender: TObject);
begin

  with FReport.PrinterSetup do
    MarginBottom := MarginBottom + FMarginSpinIncrement;

  PaperChange;

end; {procedure, spinMarginBottomUpClick}

{------------------------------------------------------------------------------}
{ Tfrm0121.spinMarginLeftDownClick}

procedure Tfrm0121.spinMarginLeftDownClick(Sender: TObject);
begin
  with FReport.PrinterSetup do
    MarginLeft := MarginLeft - FMarginSpinIncrement;

  PaperChange;

end; {procedure, spinMarginLeftDownClick}

{------------------------------------------------------------------------------}
{ Tfrm0121.spinMarginLeftUpClick}

procedure Tfrm0121.spinMarginLeftUpClick(Sender: TObject);
begin

  with FReport.PrinterSetup do
    MarginLeft := MarginLeft + FMarginSpinIncrement;

  PaperChange;

end; {procedure, spinMarginLeftUpClick}

{------------------------------------------------------------------------------}
{ Tfrm0121.spinMarginRightDownClick}

procedure Tfrm0121.spinMarginRightDownClick(Sender: TObject);
begin
  with FReport.PrinterSetup do
    MarginRight := MarginRight - FMarginSpinIncrement;

  PaperChange;

end; {procedure, spinMarginRightDownClick}

{------------------------------------------------------------------------------}
{ Tfrm0121.spinMarginRightUpClick}

procedure Tfrm0121.spinMarginRightUpClick(Sender: TObject);
begin
  with FReport.PrinterSetup do
    MarginRight := MarginRight + FMarginSpinIncrement;

  PaperChange;

end; {procedure, spinMarginRightUpClick}


{------------------------------------------------------------------------------}
{ Tfrm0121.SetLanguage}

procedure Tfrm0121.SetLanguage(aLanguageIndex: Longint);
begin

  Caption := ppLoadStr(218);

  lblHeight.Caption          := ppLoadStr(184);
  lblMargins.Caption         := ppLoadStr(376);
  gbxOrientation.Caption     := ppLoadStr(217);
  lblPaperSize.Caption       := ppLoadStr(219);
  lblPaperSource.Caption     := ppLoadStr(220);
  lblPaperTray.Caption       := ppLoadStr(221);
  lblOtherPages.Caption      := ppLoadStr(271);
  lblWidth.Caption           := ppLoadStr(183);
  lblMarginTop.Caption       := ppLoadStr(182);
  lblMarginBottom.Caption    := ppLoadStr(325);
  lblMarginLeft.Caption      := ppLoadStr(181);
  lblMarginRight.Caption     := ppLoadStr(327);

  rdbPortrait.Caption        := ppLoadStr(148);
  rdbLandscape.Caption       := ppLoadStr(147);

  nbkPageSetup.Pages[1] := lblPaperSize.Caption;
  nbkPageSetup.Pages[2] := lblPaperSource.Caption;
  nbkPageSetup.Pages[3] := lblMargins.Caption;

end; {procedure, SetLanguage}




end.
