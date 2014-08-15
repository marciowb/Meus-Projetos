{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppPosDlg;

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

  ppForms,
  ppDesignerForms,
  ppTypes,
  ppUtils,
  ComCtrls;

type

  TppPosType = (ppptLeft, ppptTop, ppptWidth, ppptHeight, ppptAngle,
                ppptBottomOffset, ppptOverFlowOffset, ppptStopPosition);

  {@TppPositionDialog }
  TppPositionDialog = class(TppCustomPositionDialog)
    lblLeft: TLabel;
    lblTop: TLabel;
    edtLeft: TEdit;
    edtTop: TEdit;
    lblWidth: TLabel;
    lblHeight: TLabel;
    edtWidth: TEdit;
    edtHeight: TEdit;
    btnOK: TButton;
    btnCancel: TButton;
    btnApply: TButton;
    lblBottomOffset: TLabel;
    edtBottomOffset: TEdit;
    lblOverFlowOffset: TLabel;
    edtOverFlowOffset: TEdit;
    lblStopPosition: TLabel;
    edtStopPosition: TEdit;
    lblAngle: TLabel;
    edtAngle: TEdit;
    procedure btnOKClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure edtLeftExit(Sender: TObject);
    procedure edtLeftKeyPress(Sender: TObject; var Key: Char);
    procedure edtTopExit(Sender: TObject);
    procedure edtTopKeyPress(Sender: TObject; var Key: Char);
    procedure edtWidthExit(Sender: TObject);
    procedure edtWidthKeyPress(Sender: TObject; var Key: Char);
    procedure edtHeightExit(Sender: TObject);
    procedure edtHeightKeyPress(Sender: TObject; var Key: Char);
    procedure edtBottomOffsetExit(Sender: TObject);
    procedure edtBottomOffsetKeyPress(Sender: TObject; var Key: Char);
    procedure edtOverFlowOffsetExit(Sender: TObject);
    procedure edtOverFlowOffsetKeyPress(Sender: TObject; var Key: Char);
    procedure edtStopPositionExit(Sender: TObject);
    procedure edtStopPositionKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edtAngleExit(Sender: TObject);
    procedure edtAngleKeyPress(Sender: TObject; var Key: Char);

  private
    FSpinIncrement: Single;
    FSpinLeft: TppUpDown;
    FSpinTop: TppUpDown;
    FSpinWidth: TppUpDown;
    FSpinHeight: TppUpDown;
    FSpinAngle: TppUpDown;
    FSpinBottomOffset: TppUpDown;
    FSpinOverFlowOffset: TppUpDown;
    FSpinStopPosition: TppUpDown;

    procedure SpinPosition(PositionType: TppPosType; Increment: Single);

    procedure SpinLeftClick(Sender: TObject; Button: TUDBtnType);
    procedure SpinTopClick(Sender: TObject; Button: TUDBtnType);
    procedure SpinWidthClick(Sender: TObject; Button: TUDBtnType);
    procedure SpinHeightClick(Sender: TObject; Button: TUDBtnType);
    procedure SpinAngleClick(Sender: TObject; Button: TUDBtnType);
    procedure SpinBottomOffsetClick(Sender: TObject; Button: TUDBtnType);
    procedure SpinOverFlowOffsetClick(Sender: TObject; Button: TUDBtnType);
    procedure SpinStopPositionClick(Sender: TObject; Button: TUDBtnType);


  protected
    procedure LanguageChanged; override;
    procedure DoPositionChange; override;

  public
    procedure Initialize; override;


  end;

var
  ppPositionDialog: TppPositionDialog;

implementation

uses
  ppClass, TypInfo;

{$R *.DFM}


{------------------------------------------------------------------------------}
{ TppPositionDialog.FormCreate }

procedure TppPositionDialog.FormCreate(Sender: TObject);
begin

  FSpinLeft := TppUpDown.CreateForControl(edtLeft);
  FSpinLeft.OnClick := SpinLeftClick;

  FSpinTop := TppUpDown.CreateForControl(edtTop);
  FSpinTop.OnClick := SpinTopClick;

  FSpinWidth := TppUpDown.CreateForControl(edtWidth);
  FSpinWidth.OnClick := SpinWidthClick;

  FSpinHeight := TppUpDown.CreateForControl(edtHeight);
  FSpinHeight.OnClick := SpinHeightClick;

  FSpinAngle := TppUpDown.CreateForControl(edtAngle);
  FSpinAngle.OnClick := SpinAngleClick;

  FSpinBottomOffset := TppUpDown.CreateForControl(edtBottomOffset);
  FSpinBottomOffset.OnClick := SpinBottomOffsetClick;

  FSpinOverFlowOffset := TppUpDown.CreateForControl(edtOverFlowOffset);
  FSpinOverFlowOffset.OnClick :=SpinOverFlowOffsetClick;

  FSpinStopPosition := TppUpDown.CreateForControl(edtStopPosition);
  FSpinStopPosition.OnClick := SpinStopPositionClick;


end; {procedure, FormCreate}


{------------------------------------------------------------------------------}
{ TppPositionDialog.Initialize }

procedure TppPositionDialog.Initialize;
begin

  {set increment for spin controls based on Units }
  case Units of
    utInches:        FSpinIncrement  := 0.10;
    utMillimeters:   FSpinIncrement  := 1;
    utScreenPixels:  FSpinIncrement  := 1.0;
    utPrinterPixels: FSpinIncrement  := 50.0;
    utMMThousandths: FSpinIncrement  := 1000.0;
  end;

  edtLeft.Text   := FloatToStrF(PropLeft, ffGeneral, 7, 0);
  edtTop.Text    := FloatToStrF(PropTop, ffGeneral, 7, 0);
  edtWidth.Text  := FloatToStrF(PropWidth, ffGeneral,  7, 0);
  edtHeight.Text := FloatToStrF(PropHeight, ffGeneral,  7, 0);

  if ParentWidth then
    begin
      lblLeft.Enabled   := False;
      lblWidth.Enabled  := False;
      edtLeft.Enabled   := False;
      edtWidth.Enabled  := False;
      FSpinLeft.Enabled  := False;
      FSpinWidth.Enabled := False;
    end;

  if ParentHeight then
    begin
      lblTop.Enabled     := False;
      lblHeight.Enabled  := False;
      edtTop.Enabled     := False;
      edtHeight.Enabled  := False;
      FSpinTop.Enabled    := False;
      FSpinHeight.Enabled := False;
    end;

  // page break component does not publish the height
  if GetPropInfo(Component.ClassInfo, 'Height') = nil then
    begin
      lblHeight.Enabled  := False;
      edtHeight.Enabled  := False;
      FSpinHeight.Enabled := False;
    end;


  {Angle only applicable to certain components}
  if GetPropInfo(Component.ClassInfo, 'Angle') = nil then
    begin
      {Hide Angle Capabilities}
      lblAngle.Visible := False;
      edtAngle.Visible := False;
      FSpinAngle.Visible := False;
      Height := Height - edtAngle.Height;

      {Move other controls up}
      lblStopPosition.Top := lblOverFlowOffset.Top;
      edtStopPosition.Top := edtOverFlowOffset.Top;
      FSpinStopPosition.Top := FSpinOverFlowOffset.Top;

      lblOverFlowOffset.Top := lblBottomOffset.Top;
      edtOverFlowOffset.Top := edtBottomOffset.Top;
      FSpinOverFlowOffset.Top := FSpinBottomOffset.Top;

      lblBottomOffset.Top := lblAngle.Top;
      edtBottomOffset.Top := edtAngle.Top;
      FSpinBottomOffset.Top := FSpinAngle.Top;
    end;

  edtAngle.Text := IntToStr(PropAngle);

  {BottomOffset only applicable to certain components}
  if GetPropInfo(Component.ClassInfo, 'BottomOffset') = nil then
    begin
      lblBottomOffset.Visible  := False;
      edtBottomOffset.Visible  := False;
      FSpinBottomOffset.Visible := False;
      Height := Height - edtBottomOffset.Height;
    end;

  edtBottomOffset.Text := FloatToStrF(PropBottomOffset, ffGeneral,  7, 0);

  {OverFlowOffset only applicable to certain components}
  if GetPropInfo(Component.ClassInfo, 'OverFlowOffset') = nil then
    begin
      lblOverFlowOffset.Visible  := False;
      edtOverFlowOffset.Visible  := False;
      FSpinOverFlowOffset.Visible := False;
      Height := Height - edtOverFlowOffset.Height;
    end;

  edtOverFlowOffset.Text := FloatToStrF(PropOverFlowOffset, ffGeneral,  7, 0);

  {StopPosition only applicable to certain components}
  if GetPropInfo(Component.ClassInfo, 'StopPosition') = nil then
    begin
      lblStopPosition.Visible  := False;
      edtStopPosition.Visible  := False;
      FSpinStopPosition.Visible := False;
      Height := Height - edtStopPosition.Height;
    end;

  edtStopPosition.Text := FloatToStrF(PropStopPosition, ffGeneral,  7, 0);

end; {procedure, Activate}

{------------------------------------------------------------------------------}
{ TppPositionDialog.SpinPosition}

procedure TppPositionDialog.SpinPosition(PositionType: TppPosType; Increment: Single);
begin

  case PositionType of
    ppptLeft:
      begin
        PropLeft     := PropLeft + Increment;
        if PropLeft < 0 then
          PropLeft := 0;
        edtLeft.Text := FloatToStrF(PropLeft, ffGeneral, 7, 0);
      end;

    ppptTop:
      begin
        PropTop     := PropTop + Increment;
        if PropTop < 0 then
          PropTop := 0;
        edtTop.Text := FloatToStrF(PropTop, ffGeneral, 7, 0);
      end;

    ppptWidth:
      begin
        PropWidth     :=PropWidth + Increment;
        if PropWidth < 0 then
          PropWidth := 0;
        edtWidth.Text := FloatToStrF(PropWidth, ffGeneral, 7, 0);
      end;

    ppptHeight:
      begin
        PropHeight     := PropHeight + Increment;
        if PropHeight < 0 then
          PropHeight := 0;
        edtHeight.Text := FloatToStrF(PropHeight, ffGeneral, 7, 0);
      end;

    ppptAngle:
      begin
        PropAngle      := PropAngle + Trunc(Increment);
        if PropAngle > 359 then
          PropAngle := 359;
        if PropAngle < -359 then
          PropAngle := -359;
        edtAngle.Text := IntToStr(PropAngle);
      end;

    ppptBottomOffset:
      begin
        PropBottomOffset     := PropBottomOffset + Increment;
        edtBottomOffset.Text := FloatToStrF(PropBottomOffset, ffGeneral, 7, 0);
      end;

    ppptOverFlowOffset:
      begin
        PropOverFlowOffset     := PropOverFlowOffset + Increment;
        edtOverFlowOffset.Text := FloatToStrF(PropOverFlowOffset, ffGeneral, 7, 0);
      end;

    ppptStopPosition:
      begin
        PropStopPosition     := PropStopPosition + Increment;
        edtStopPosition.Text := FloatToStrF(PropStopPosition, ffGeneral, 7, 0);
      end;

  end;

end; {procedure, SpinPosition}

{------------------------------------------------------------------------------}
{ TppPositionDialog.btnApplyClick }


procedure TppPositionDialog.btnApplyClick(Sender: TObject);
begin
  DoPositionChange;
end;

{------------------------------------------------------------------------------}
{ TppPositionDialog.btnOKClick }

procedure TppPositionDialog.btnOKClick(Sender: TObject);
begin
  ExitActiveControl;
  
  btnApplyClick(Self);

end; {procedure, btnOKClick}

{------------------------------------------------------------------------------}
{ TppPositionDialog.LanguageChanged }

procedure TppPositionDialog.LanguageChanged;
begin

  Caption := ppLoadStr(384); {Position}

  lblLeft.Caption   := ppLoadStr(181);
  lblTop.Caption    := ppLoadStr(182);
  lblWidth.Caption  := ppLoadStr(183);
  lblHeight.Caption := ppLoadStr(184);
  lblBottomOffset.Caption  := ppLoadStr(397); {'BottomOffset'}
  lblOverFlowOffset.Caption  := ppLoadStr(419);
  lblStopPosition.Caption  := ppLoadStr(507);

  btnApply.Caption  := ppLoadStr(385);
  btnOK.Caption     := ppLoadStr(ppMsgOK);
  btnCancel.Caption := ppLoadStr(ppMsgCancel);

end; {procedure, LanguageChanged}

procedure TppPositionDialog.DoPositionChange;
begin
  inherited;

  edtLeft.Text   := FloatToStrF(PropLeft, ffGeneral, 7, 0);
  edtTop.Text    := FloatToStrF(PropTop, ffGeneral, 7, 0);
  edtWidth.Text  := FloatToStrF(PropWidth, ffGeneral,  7, 0);
  edtHeight.Text := FloatToStrF(PropHeight, ffGeneral,  7, 0);

end;

{------------------------------------------------------------------------------}
{ TppPositionDialog.edtLeftExit }

procedure TppPositionDialog.edtLeftExit(Sender: TObject);
begin

 if (ActiveControl = btnCancel) then Exit;

 try
    PropLeft := StrToFloat(edtLeft.Text);
  except on EConvertError do
    WarningDlg(ppLoadStr(377));
  end;

end; {procedure, edtLeftExit}

{------------------------------------------------------------------------------}
{ TppPositionDialog.edtLeftKeyPress }

procedure TppPositionDialog.edtLeftKeyPress(Sender: TObject; var Key: Char);
begin

  if (Key = chEnterKey) then
    edtLeftExit(Sender);

end;  {procedure, edtLeftKeyPress}

{------------------------------------------------------------------------------}
{ TppPositionDialog.edtTopExit }

procedure TppPositionDialog.edtTopExit(Sender: TObject);
begin
 if (ActiveControl = btnCancel) then Exit;

  try
    PropTop := StrToFloat(edtTop.Text);
  except on EConvertError do
    WarningDlg(ppLoadStr(377));
  end;

end; {procedure, edtTopExit}

{------------------------------------------------------------------------------}
{ TppPositionDialog.edtTopKeyPress }

procedure TppPositionDialog.edtTopKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = chEnterKey) then
    edtTopExit(Sender);

end; {procedure, edtTopKeyPress}

{------------------------------------------------------------------------------}
{ TppPositionDialog.edtWidthExit }

procedure TppPositionDialog.edtWidthExit(Sender: TObject);
begin
  if (ActiveControl = btnCancel) then Exit;
  
  try
    PropWidth := StrToFloat(edtWidth.Text);
  except on EConvertError do
    WarningDlg(ppLoadStr(377));
  end;

end; {procedure, edtWidthExit}

{------------------------------------------------------------------------------}
{ TppPositionDialog.edtWidthKeyPress }

procedure TppPositionDialog.edtWidthKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = chEnterKey) then
    edtWidthExit(Sender);

end; {procedure, edtWidthKeyPress}

{------------------------------------------------------------------------------}
{ TppPositionDialog.edtHeightExit }

procedure TppPositionDialog.edtHeightExit(Sender: TObject);
begin
  if (ActiveControl = btnCancel) then Exit;

  try
    PropHeight := StrToFloat(edtHeight.Text);
  except on EConvertError do
    WarningDlg(ppLoadStr(377));
  end;

end; {procedure, edtHeightExit}

{------------------------------------------------------------------------------}
{ TppPositionDialog.edtHeightKeyPress }

procedure TppPositionDialog.edtHeightKeyPress(Sender: TObject; var Key: Char);
begin
   if (Key = chEnterKey) then
    edtHeightExit(Sender);

end; {procedure, edtHeightKeyPress}

{------------------------------------------------------------------------------}
{ TppPositionDialog.edtAngleExit }

procedure TppPositionDialog.edtAngleExit(Sender: TObject);
begin
  if (ActiveControl = btnCancel) then Exit;

  try
    PropAngle := StrToInt(edtAngle.Text);
  except on EConvertError do
    WarningDlg(ppLoadStr(377));
  end;

end; {procedure, edtAngleExit}

{------------------------------------------------------------------------------}
{ TppPositionDialog.edtAngleKeyPress }

procedure TppPositionDialog.edtAngleKeyPress(Sender: TObject; var Key: Char);
begin
   if (Key = chEnterKey) then
    edtAngleExit(Sender);
    
end; {procedure, edtAngleKeyPress}

{------------------------------------------------------------------------------}
{ TppPositionDialog.edtBottomOffsetExit }

procedure TppPositionDialog.edtBottomOffsetExit(Sender: TObject);
begin
  if (ActiveControl = btnCancel) then Exit;

  try
    PropBottomOffset := StrToFloat(edtBottomOffset.Text);
  except on EConvertError do
    WarningDlg(ppLoadStr(377));
  end;

end; {procedure, edtBottomOffsetExit}

{------------------------------------------------------------------------------}
{ TppPositionDialog.edtBottomOffsetKeyPress }

procedure TppPositionDialog.edtBottomOffsetKeyPress(Sender: TObject; var Key: Char);
begin
   if (Key = chEnterKey) then
    edtBottomOffsetExit(Sender);

end; {procedure, edtBottomOffsetKeyPress}

{------------------------------------------------------------------------------}
{ TppPositionDialog.edtOverFlowOffsetExit }

procedure TppPositionDialog.edtOverFlowOffsetExit(Sender: TObject);
begin
  if (ActiveControl = btnCancel) then Exit;

  try
    PropOverFlowOffset := StrToFloat(edtOverFlowOffset.Text);
  except on EConvertError do
    WarningDlg(ppLoadStr(377));
  end;

end; {procedure, edtOverFlowOffsetExit}

{------------------------------------------------------------------------------}
{ TppPositionDialog.edtOverFlowOffsetKeyPress }

procedure TppPositionDialog.edtOverFlowOffsetKeyPress(Sender: TObject; var Key: Char);
begin
   if (Key = chEnterKey) then
    edtOverFlowOffsetExit(Sender);

end; {procedure, edtOverFlowOffsetKeyPress}



{------------------------------------------------------------------------------}
{ TppPositionDialog.edtStopPositionExit }

procedure TppPositionDialog.edtStopPositionExit(Sender: TObject);
begin
  if (ActiveControl = btnCancel) then Exit;

  try
    PropStopPosition := StrToFloat(edtStopPosition.Text);
  except on EConvertError do
    WarningDlg(ppLoadStr(377));
  end;
end;

{------------------------------------------------------------------------------}
{ TppPositionDialog.edtStopPositionKeyPress }

procedure TppPositionDialog.edtStopPositionKeyPress(Sender: TObject; var Key: Char);
begin
   if (Key = chEnterKey) then
    edtStopPositionExit(Sender);
end;


{------------------------------------------------------------------------------}
{ TppPositionDialog.spinLeftClick }

procedure TppPositionDialog.spinLeftClick(Sender: TObject; Button: TUDBtnType);
begin

  if (Button = btPrev) then
    SpinPosition(ppptLeft, -FSpinIncrement)
  else
    SpinPosition(ppptLeft, FSpinIncrement);

end; {procedure, spinLeftClick}


{------------------------------------------------------------------------------}
{ TppPositionDialog.spinTopClick }

procedure TppPositionDialog.spinTopClick(Sender: TObject; Button: TUDBtnType);
begin

  if (Button = btPrev) then
    SpinPosition(ppptTop, -FSpinIncrement)
  else
    SpinPosition(ppptTop, FSpinIncrement);

end; {procedure, spinTopClick}


{------------------------------------------------------------------------------}
{ TppPositionDialog.spinHeightClick }

procedure TppPositionDialog.spinHeightClick(Sender: TObject; Button: TUDBtnType);
begin

  if (Button = btPrev) then
    SpinPosition(ppptHeight, -FSpinIncrement)
  else
    SpinPosition(ppptHeight, FSpinIncrement);

end; {procedure, spinHeightClick}


{------------------------------------------------------------------------------}
{ TppPositionDialog.spinWidthClick }

procedure TppPositionDialog.spinWidthClick(Sender: TObject; Button: TUDBtnType);
begin

  if (Button = btPrev) then
    SpinPosition(ppptWidth, -FSpinIncrement)
  else
    SpinPosition(ppptWidth, FSpinIncrement);

end; {procedure, spinWidthClick}

{------------------------------------------------------------------------------}
{ TppPositionDialog.spinAngleClick }

procedure TppPositionDialog.spinAngleClick(Sender: TObject; Button: TUDBtnType);
begin

  if (Button = btPrev) then
    SpinPosition(ppptAngle, -1)
  else
    SpinPosition(ppptAngle, 1);

end; {procedure, spinAngleClick}


{------------------------------------------------------------------------------}
{ TppPositionDialog.spinBottomOffsetClick }

procedure TppPositionDialog.spinBottomOffsetClick(Sender: TObject; Button: TUDBtnType);
begin

  if (Button = btPrev) then
    SpinPosition(ppptBottomOffset, -FSpinIncrement)
  else
    SpinPosition(ppptBottomOffset, FSpinIncrement);

end; {procedure, spinBottomOffsetClick}

{------------------------------------------------------------------------------}
{ TppPositionDialog.spinOverflowOffsetClick }

procedure TppPositionDialog.spinOverflowOffsetClick(Sender: TObject; Button: TUDBtnType);
begin

  if (Button = btPrev) then
    SpinPosition(ppptOverFlowOffset, -FSpinIncrement)
  else
    SpinPosition(ppptOverFlowOffset, FSpinIncrement);

end; {procedure, spinOverflowOffsetClick}



{------------------------------------------------------------------------------}
{ TppPositionDialog.StopPosition }

procedure TppPositionDialog.spinStopPositionClick(Sender: TObject; Button: TUDBtnType);
begin

  if (Button = btPrev) then
    SpinPosition(ppptStopPosition, -FSpinIncrement)
  else
    SpinPosition(ppptStopPosition, FSpinIncrement);

end; {procedure, spinHeightClick}


{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}


initialization

  ppRegisterForm(TppCustomPositionDialog, TppPositionDialog);

finalization

  ppUnRegisterForm(TppCustomPositionDialog);

end.

