{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppBarDlg;

interface

{$I ppIfDef.pas}

uses
  Windows,
  Classes,
  Graphics,
  Forms,
  Controls,
  StdCtrls,
  Buttons,
  ExtCtrls,
  SysUtils,
  Dialogs,
  ComCtrls,

  ppForms,
  ppDesignerForms,
  ppTypes,
  ppUtils,
  ppPrintr;

type

  {@TppBarCodeDialog }
  TppBarCodeDialog = class(TppCustomBarCodeDialog)
    lblBarWidth: TLabel;
    lblWideBarRatio: TLabel;
    edtBarWidth: TEdit;
    edtWideBarRatio: TEdit;
    btnOK: TButton;
    btnCancel: TButton;
    btnApply: TButton;
    lblAddOnCode: TLabel;
    edtAddOnCode: TEdit;
    cbxBarCodeType: TComboBox;
    ckbBearerBars: TCheckBox;
    ckbCalcCheckDigit: TCheckBox;
    lblOrientation: TLabel;
    cbxOrientation: TComboBox;
    lblBarCodeType: TLabel;
    ckbAutoEncode: TCheckBox;
    procedure btnOKClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure edtBarWidthChange(Sender: TObject);
    procedure edtBarWidthKeyPress(Sender: TObject; var Key: Char);
    procedure edtWideBarRatioChange(Sender: TObject);
    procedure edtWideBarRatioKeyPress(Sender: TObject; var Key: Char);
    procedure cbxBarCodeTypeChange(Sender: TObject);
    procedure ckbBearerBarsClick(Sender: TObject);
    procedure ckbCalcCheckDigitClick(Sender: TObject);
    procedure edtAddOnCodeKeyPress(Sender: TObject; var Key: Char);
    procedure edtAddOnCodeExit(Sender: TObject);
    procedure cbxOrientationChange(Sender: TObject);
    procedure ckbAutoEncodeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    FSpinIncrement: Single;
    FSpinBarWidth: TppUpDown;
    FSpinWideBarRatio: TppUpDown;

    procedure AdjustPositions;
    procedure SpinBarWidthClick(Sender: TObject; Button: TUDBtnType);
    procedure SpinWideBarRatioClick(Sender: TObject; Button: TUDBtnType);

    function GetRequiredTextWidth(aString: String; aCanvas: TCanvas): Integer;

  protected
    procedure Activate; override;
    procedure LanguageChanged; override;

  end; {class, TppBarCodeDialog}

var
  ppBarCodeDialog: TppBarCodeDialog;

implementation

uses
  ppClass, TypInfo;

{$R *.DFM}


{------------------------------------------------------------------------------}
{ TppBarCodeDialog.FormCreate }

procedure TppBarCodeDialog.FormCreate(Sender: TObject);
begin

  FSpinBarWidth := TppUpDown.CreateForControl(edtBarWidth);
  FSpinBarWidth.OnClick := SpinBarWidthClick;

  FSpinWideBarRatio := TppUpDown.CreateForControl(edtWideBarRatio);
  FSpinWideBarRatio.OnClick := SpinWideBarRatioClick;

end; {procedure, FormCreate }


{------------------------------------------------------------------------------}
{ TppBarCodeDialog.Activate }

procedure TppBarCodeDialog.Activate;
begin

  inherited Activate;

  {set increment for spin controls based on Units }
  case Units of
    utInches:        FSpinIncrement  := 0.10;
    utMillimeters:   FSpinIncrement  := 1;
    utScreenPixels:  FSpinIncrement  := 1.0;
    utPrinterPixels: FSpinIncrement  := 50.0;
    utMMThousandths: FSpinIncrement  := 1000.0;
  end;

  cbxBarCodeType.ItemIndex := Ord(BarCodeType);
  cbxOrientation.ItemIndex := Ord(Orientation);

  edtBarWidth.Text := FloatToStrF(BarWidth, ffGeneral, 7, 0);
  edtWideBarRatio.Text := FloatToStrF(WideBarRatio, ffGeneral, 7, 0);

  edtAddOnCode.Text := AddOnCode;

  ckbBearerBars.Checked := BearerBars;
  ckbCalcCheckDigit.Checked := CalcCheckDigit;

  ckbAutoEncode.Checked := AutoEncode;

  cbxBarCodeTypeChange(Self);

end; {procedure, Activate}

{------------------------------------------------------------------------------}
{ TppBarCodeDialog.btnApplyClick }

procedure TppBarCodeDialog.btnApplyClick(Sender: TObject);
begin
  DoApplyChanges;
end;

{------------------------------------------------------------------------------}
{ TppBarCodeDialog.btnOKClick }

procedure TppBarCodeDialog.btnOKClick(Sender: TObject);
begin
  ExitActiveControl;

  btnApplyClick(Self);
end; {procedure, btnOKClick}

{------------------------------------------------------------------------------}
{ TppBarCodeDialog.LanguageChanged }

procedure TppBarCodeDialog.LanguageChanged;
begin

  Caption := ppLoadStr(444);

  lblBarCodeType.Caption := ppLoadStr(445);
  lblOrientation.Caption := ppLoadStr(217);
  lblBarWidth.Caption := ppLoadStr(446);
  lblWideBarRatio.Caption := ppLoadStr(447);
  lblAddOnCode.Caption := ppLoadStr(448);
  ckbBearerBars.Caption := ppLoadStr(449);
  ckbCalcCheckDigit.Caption := ppLoadStr(450);
  ckbAutoEncode.Caption := ppLoadStr(692); {'Auto Encode'}

  cbxOrientation.Items.Clear;

  cbxOrientation.Items.Add(ppLoadStr(115)); {'Left to Right'}
  cbxOrientation.Items.Add(ppLoadStr(116)); {'Right to Left'}
  cbxOrientation.Items.Add(ppLoadStr(312)); {'Top to Bottom'}
  cbxOrientation.Items.Add(ppLoadStr(375)); {'Bottom to Top'}

  btnApply.Caption  := ppLoadStr(385);
  btnOK.Caption     := ppLoadStr(ppMsgOK);
  btnCancel.Caption := ppLoadStr(ppMsgCancel);

  AdjustPositions;

end; {procedure, LanguageChanged}

{------------------------------------------------------------------------------}
{ TppBarCodeDialog.cbxBarCodeTypeChange }

procedure TppBarCodeDialog.cbxBarCodeTypeChange(Sender: TObject);
var
  llBarWidth: Longint;

begin

  BarCodeType := TppBarCodeType(cbxBarCodeType.ItemIndex);

  if (BarCodeType <> bcInt2of5) then
    ckbBearerBars.Checked := False;

  if not (BarCodeType in cPOSBarCodes) and (BarCodeType <> bcInt2of5) then
    begin
      ckbCalcCheckDigit.Checked := False;
      edtAddOnCode.Text := '';
    end;

  edtAddOnCode.Enabled      := (BarCodeType in cPOSBarCodes);
  lblAddOnCode.Enabled      := (BarCodeType in cPOSBarCodes);
  ckbCalcCheckDigit.Enabled := (BarCodeType in cPOSBarCodes) or (BarCodeType = bcInt2of5) or (BarcodeType = bcMSI) ;


  ckbBearerBars.Enabled     := (BarCodeType = bcInt2of5);

  ckbAutoEncode.Enabled     := (BarCodeType = bcCode128);

  if BarcodeType = bcMSI then
    ckbCalcCheckDigit.Checked := True;


  if (Sender = cbxBarCodeType) then
  begin
    case BarCodeType of
      bcCode128         : llBarWidth := ppToMMThousandths(0.010, utInches, pprtHorizontal, nil);
      bcCode39          : llBarWidth := ppToMMThousandths(0.010, utInches, pprtHorizontal, nil);
      bcEAN_13, bcUPC_A,
      bcEAN_8, bcUPC_E  : llBarWidth := ppToMMThousandths(0.013, utInches, pprtHorizontal, nil);
      bcInt2of5         : llBarWidth := ppToMMThousandths(0.015, utInches, pprtHorizontal, nil);
      bcIntelligentMail,
      bcPostnet         : llBarWidth := ppToMMThousandths(0.020, utInches, pprtHorizontal, nil);
      bcFIM             : llBarWidth := ppToMMThousandths(0.031, utInches, pprtHorizontal, nil);
      bcCodabar         : llBarWidth := ppToMMThousandths(0.010, utInches, pprtHorizontal, nil);
    else
      llBarWidth := ppToMMThousandths(0.010, utInches, pprtHorizontal, nil);

    end;

    BarWidth := ppFromMMThousandths(llBarWidth, Units, pprtHorizontal, ppPrinter);

    edtBarWidth.Text := FloatToStrF(BarWidth, ffGeneral, 7, 0);
    ckbAutoEncode.Checked     := (BarCodeType = bcCode128); // make it the default
  end;
end;

{------------------------------------------------------------------------------}
{ TppBarCodeDialog.cbxBarCodeTypeChange }

procedure TppBarCodeDialog.cbxOrientationChange(Sender: TObject);
begin
  Orientation := TppBarCodeOrientation(cbxOrientation.ItemIndex);
end;

{------------------------------------------------------------------------------}
{ TppBarCodeDialog.edtBarWidthChange }

procedure TppBarCodeDialog.edtBarWidthChange(Sender: TObject);
begin
  if (ActiveControl = btnCancel) then Exit;

  try
    BarWidth := StrToFloat(edtBarWidth.Text);
  except on EConvertError do
    WarningDlg(ppLoadStr(377));
  end;

end; {procedure, edtBarWidthChange}

{------------------------------------------------------------------------------}
{ TppBarCodeDialog.edtBarWidthKeyPress }

procedure TppBarCodeDialog.edtBarWidthKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = chEnterKey) then
    edtBarWidthChange(Sender);

end; {procedure, edtBarWidthKeyPress}


{------------------------------------------------------------------------------}
{ TppBarCodeDialog.spinBarWidthClick }

procedure TppBarCodeDialog.spinBarWidthClick(Sender: TObject; Button: TUDBtnType);
begin

  if (Button = btPrev) then
    BarWidth := BarWidth - FSpinIncrement
  else
    BarWidth := BarWidth + FSpinIncrement;

  edtBarWidth.Text := FloatToStrF(BarWidth, ffGeneral, 7, 0);

end; {procedure, spinBarWidthClick}



{------------------------------------------------------------------------------}
{ TppBarCodeDialog.edtWideBarRatioChange }

procedure TppBarCodeDialog.edtWideBarRatioChange(Sender: TObject);
var
  lfWideBarRatio: Single;
begin
  if (ActiveControl = btnCancel) then Exit;

  try
    lfWideBarRatio := StrToFloat(edtWideBarRatio.Text);

    if lfWideBarRatio <= 0 then Exit;

    WideBarRatio   := lfWideBarRatio;

  except on EConvertError do
    WarningDlg(ppLoadStr(377));
  end;

end; {procedure, edtWideBarRatioChange}

{------------------------------------------------------------------------------}
{ TppBarCodeDialog.edtWideBarRatioKeyPress }

procedure TppBarCodeDialog.edtWideBarRatioKeyPress(Sender: TObject; var Key: Char);
begin
   if (Key = chEnterKey) then
    edtWideBarRatioChange(Sender);

end; {procedure, edtWideBarRatioKeyPress}


{------------------------------------------------------------------------------}
{ TppBarCodeDialog.spinWideBarRatioClick }

procedure TppBarCodeDialog.spinWideBarRatioClick(Sender: TObject; Button: TUDBtnType);
var
  lfWideBarRatio: Single;

begin

  if (Button = btPrev) then
    begin
      lfWideBarRatio := WideBarRatio - 0.10;

      if (lfWideBarRatio <= 0) then Exit;

      WideBarRatio := lfWideBarRatio;
    end
  else
    WideBarRatio := WideBarRatio + 0.10;

  edtWideBarRatio.Text := FloatToStrF(WideBarRatio, ffGeneral, 7, 0);

end; {procedure, spinWideBarRatioClick}


{------------------------------------------------------------------------------}
{ TppBarCodeDialog.edtAddOnCodeExit }

procedure TppBarCodeDialog.edtAddOnCodeExit(Sender: TObject);
begin
 if (ActiveControl = btnCancel) then Exit;

 {message: 'Add-on codes must be either 2 or 5 digits'}
 if not (Length(edtAddOnCode.Text) in [0,2,5]) then
   WarningDlg(ppLoadStr(424))
 else
   AddOnCode := edtAddOnCode.Text;

end; {procedure, edtAddOnCodeExit}

{------------------------------------------------------------------------------}
{ TppBarCodeDialog.edtAddOnCodeKeyPress }

procedure TppBarCodeDialog.edtAddOnCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = chEnterKey) then
    edtAddOnCodeExit(Sender);

end; {procedure, edtAddOnCodeKeyPress}

{------------------------------------------------------------------------------}
{ TppBarCodeDialog.ckbBearerBarsClick }

procedure TppBarCodeDialog.ckbBearerBarsClick(Sender: TObject);
begin
  BearerBars := ckbBearerBars.Checked;
end;

{------------------------------------------------------------------------------}
{ TppBarCodeDialog.ckbCalcCheckDigitClick }

procedure TppBarCodeDialog.ckbCalcCheckDigitClick(Sender: TObject);
begin
  CalcCheckDigit := ckbCalcCheckDigit.Checked;
end;

{------------------------------------------------------------------------------}
{ TppBarCodeDialog.ckbAutoEncodeClick }

procedure TppBarCodeDialog.ckbAutoEncodeClick(Sender: TObject);
begin
  AutoEncode := ckbAutoEncode.Checked;
end;

{------------------------------------------------------------------------------}
{ TppBarCodeDialog.AdjustPositions }

procedure TppBarCodeDialog.AdjustPositions;
var
  liMaxWidth: Integer;
  liOldMaxWidth: Integer;
  liOffset: Integer;
begin
  liOldMaxWidth := 72;

  lblBarCodeType.Width := GetRequiredTextWidth(lblBarCodeType.Caption, lblBarCodeType.Canvas);
  liMaxWidth := lblBarCodeType.Width;

  lblOrientation.Width := GetRequiredTextWidth(lblOrientation.Caption, lblOrientation.Canvas);
  if lblOrientation.Width > liMaxWidth then
    liMaxWidth := lblOrientation.Width;

  lblBarWidth.Width := GetRequiredTextWidth(lblBarWidth.Caption, lblBarWidth.Canvas);
  if lblBarWidth.Width > liMaxWidth then
    liMaxWidth := lblBarWidth.Width;

  lblWideBarRatio.Width := GetRequiredTextWidth(lblWideBarRatio.Caption, lblWideBarRatio.Canvas);
  if lblWideBarRatio.Width > liMaxWidth then
    liMaxWidth := lblWideBarRatio.Width;

  lblAddOnCode.Width := GetRequiredTextWidth(lblAddOnCode.Caption, lblAddOnCode.Canvas);
  if lblAddOnCode.Width > liMaxWidth then
    liMaxWidth := lblAddOnCode.Width;

  liOffset := liMaxWidth - liOldMaxWidth;
  Width := Width + liOffset;

  cbxBarCodeType.Left := cbxBarCodeType.Left + liOffset;
  cbxOrientation.Left := cbxOrientation.Left + liOffset;
  edtBarWidth.Left := edtBarWidth.Left + liOffset;
  edtWideBarRatio.Left := edtWideBarRatio.Left + liOffset;
  edtAddOnCode.Left :=  edtAddOnCode.Left+ liOffset;
  btnOK.Left := btnOK.Left + liOffset;
  btnCancel.Left := btnCancel.Left + liOffset;
  btnApply.Left := btnApply.Left + liOffset;

  FSpinBarWidth.Left := FSpinBarWidth.Left + liOffset;
  FSpinWideBarRatio.Left := FSpinWideBarRatio.Left + liOffset;

end;

{------------------------------------------------------------------------------}
{ TppBarCodeDialog.GetRequiredTextWidth }

function TppBarCodeDialog.GetRequiredTextWidth(aString: String; aCanvas: TCanvas): Integer;
var
  lLineBuf: PChar;
  lSize: TSize;
begin

  lLineBuf := StrAlloc(Length(aString) + 1);

  try
    StrPCopy(lLineBuf, aString);
    GetTextExtentPoint32(aCanvas.Handle, lLineBuf, StrLen(lLineBuf), lSize);
  finally
    StrDispose(lLineBuf);
  end;

  Result := lSize.cx;

end; {function, GetRequiredTextWidth}

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}


initialization

  ppRegisterForm(TppCustomBarCodeDialog, TppBarCodeDialog);

finalization

  ppUnRegisterForm(TppCustomBarCodeDialog);

end.

