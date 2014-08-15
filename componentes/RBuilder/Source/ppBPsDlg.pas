{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                   BBBBB   }

unit ppBPsDlg;

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
  ComCtrls,
  Dialogs,

  ppForms,
  ppDesignerForms,
  ppTypes,
  ppUtils;


type

  TppBandPosType = (ppptHeight, ppptBottomOffset, ppptPrintPosition);



  TppBandPositionDialog = class(TppCustomBandPositionDialog)
    lblPrintPosition: TLabel;
    lblBottomOffset: TLabel;
    lblHeight: TLabel;
    edtHeight: TEdit;
    edtBottomOffset: TEdit;
    edtPrintPosition: TEdit;
    btnOK: TButton;
    btnCancel: TButton;
    btnApply: TButton;
    lblPrintCount: TLabel;
    edtPrintCount: TEdit;
    lblBandsPerRecord: TLabel;
    edtBandsPerRecord: TEdit;
    procedure btnOKClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure edtBottomOffsetChange(Sender: TObject);
    procedure edtBottomOffsetKeyPress(Sender: TObject; var Key: Char);
    procedure edtPrintPositionChange(Sender: TObject);
    procedure edtPrintPositionKeyPress(Sender: TObject; var Key: Char);
    procedure edtHeightChange(Sender: TObject);
    procedure edtHeightKeyPress(Sender: TObject; var Key: Char);
    procedure edtPrintCountChange(Sender: TObject);
    procedure edtPrintCountKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edtBandsPerRecordChange(Sender: TObject);
    procedure edtBandsPerRecordKeyPress(Sender: TObject; var Key: Char);

  private
    FPropBandsPerRecord: Integer;
    FSpinIncrement: Single;
    FSpinHeight: TUpDown;
    FSpinPrintPosition: TUpDown;
    FSpinBottomOffset: TUpDown;
    FSpinPrintCount: TUpDown;
    FSpinBandsPerRecord: TUpDown;

    procedure SpinPosition(PositionType: TppBandPosType; Increment: Single);

    procedure SpinHeightClick(Sender: TObject; Button: TUDBtnType);
    procedure SpinBottomOffsetClick(Sender: TObject; Button: TUDBtnType);
    procedure SpinPrintPositionClick(Sender: TObject; Button: TUDBtnType);
    procedure SpinPrintCountClick(Sender: TObject; Button: TUDBtnType);
    procedure SpinBandsPerRecordClick(Sender: TObject; Button: TUDBtnType);

  protected
    procedure LanguageChanged; override;

  public
    procedure Initialize; override;

  end;

var
  ppBandPositionDialog: TppBandPositionDialog;

implementation

uses
  ppClass, TypInfo;

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TppBandPositionDialog.FormCreate }

procedure TppBandPositionDialog.FormCreate(Sender: TObject);
begin

  FSpinHeight := TppUpDown.CreateForControl(edtHeight);
  FSpinHeight.OnClick := spinHeightClick;

  FSpinBottomOffset := TppUpDown.CreateForControl(edtBottomOffset);
  FSpinBottomOffset.OnClick := spinBottomOffsetClick;

  FSpinPrintPosition := TppUpDown.CreateForControl(edtPrintPosition);
  FSpinPrintPosition.OnClick := spinPrintPositionClick;

  FSpinPrintCount := TppUpDown.CreateForControl(edtPrintCount);
  FSpinPrintCount.OnClick := spinPrintCountClick;

  FSpinBandsPerRecord := TppUpDown.CreateForControl(edtBandsPerRecord);
  FSpinBandsPerRecord.OnClick := spinBandsPerRecordClick;

end; {procedure, FormCreate}

{------------------------------------------------------------------------------}
{ TppBandPositionDialog.Initialize }

procedure TppBandPositionDialog.Initialize;
begin

  {set increment for spin controls based on Units }
  case Units of
    utInches:        FSpinIncrement  := 0.10;
    utMillimeters:   FSpinIncrement  := 1;
    utScreenPixels:  FSpinIncrement  := 1.0;
    utPrinterPixels: FSpinIncrement  := 50.0;
    utMMThousandths: FSpinIncrement  := 1000.0;
  end;

  edtHeight.Text          := FloatToStrF(PropHeight, ffGeneral,  7, 0);
  edtBottomOffset.Text    := FloatToStrF(PropBottomOffset, ffGeneral, 7, 0);
  edtPrintPosition.Text   := FloatToStrF(PropPrintPosition, ffGeneral, 7, 0);
  edtPrintCount.Text      := IntToStr(PropPrintCount);


  {PrintPosition only applicable to certain bands}
   if not ppCheckPropInfo(Band, 'PrintPosition') then
     begin
       lblPrintPosition.Enabled   := False;
       edtPrintPosition.Enabled   := False;
       FSpinPrintPosition.Enabled := False;
     end;

  {BottomOffset only applicable to certain bands}
  if not ppCheckPropInfo(Band, 'BottomOffset') then
    begin
       lblBottomOffset.Enabled   := False;
       edtBottomOffset.Enabled   := False;
       FSpinBottomOffset.Enabled := False;
     end;

  {PrintCount only applicable to certain bands}
  if not ppCheckPropInfo(Band, 'PrintCount') then
    begin
       lblPrintCount.Visible   := False;
       edtPrintCount.Visible   := False;
       FSpinPrintCount.Visible := False;
     end;

  {BandsPerRecord only applicable to certain bands}
  if ppCheckPropInfo(Band, 'BandsPerRecord') then
    begin
      FPropBandsPerRecord     := ppGetOrdPropValue(Band, 'BandsPerRecord');
      edtBandsPerRecord.Text  := IntToStr(FPropBandsPerRecord);

    end
  else
    begin
       lblBandsPerRecord.Visible   := False;
       edtBandsPerRecord.Visible   := False;
       FSpinBandsPerRecord.Visible := False;
       Height := Height - edtBandsPerRecord.Height;

     end;



end; {procedure, Initialize}

{------------------------------------------------------------------------------}
{ TppBandPositionDialog.SpinPosition}

procedure TppBandPositionDialog.SpinPosition(PositionType: TppBandPosType; Increment: Single);
begin

  case PositionType of
     ppptHeight:
      begin
        PropHeight   := PropHeight + Increment;
        edtHeight.Text := FloatToStrF(PropHeight, ffGeneral, 7, 0);
      end;

    ppptBottomOffset:
      begin
        PropBottomOffset   := PropBottomOffset + Increment;
        edtBottomOffset.Text := FloatToStrF(PropBottomOffset, ffGeneral, 7, 0);
      end;

    ppptPrintPosition:
      begin
        PropPrintPosition   := PropPrintPosition + Increment;
        edtPrintPosition.Text := FloatToStrF(PropPrintPosition, ffGeneral, 7, 0);
      end;


  end;

end;



{------------------------------------------------------------------------------}
{ TppBandPositionDialog.btnOKClick }


procedure TppBandPositionDialog.btnApplyClick(Sender: TObject);
begin

  ppSetOrdPropValue(Band, 'BandsPerRecord', FPropBandsPerRecord);


  DoPositionChange;
end;


{------------------------------------------------------------------------------}
{ TppBandPositionDialog.btnOKClick }

procedure TppBandPositionDialog.btnOKClick(Sender: TObject);
begin

  ExitActiveControl;
  
  btnApplyClick(Self);

end; {procedure, btnOKClick}

{------------------------------------------------------------------------------}
{ TppBandPositionDialog.ppCalcMaxLabelCaption }

function ppCalcMaxLabelCaption(aLabels: TList): Integer;
var
  liTextWidth: Integer;
  liIndex: Integer;
  lLabel: TLabel;

begin
  Result := 0;

  for liIndex := 0 to aLabels.Count-1 do
    begin
     lLabel := TLabel(aLabels[liIndex]);
     liTextWidth := ppGetSpTextWidth(lLabel.Font, lLabel.Caption);

     if liTextWidth > Result then
       Result := liTextWidth;

    end;


end; {function, ppCalcMaxLabelCaption}


{------------------------------------------------------------------------------}
{ TppBandPositionDialog.LanguageChanged }

procedure TppBandPositionDialog.LanguageChanged;
var
  liIndex: Integer;
  lLabels: TList;
  liSaveMaxCaption: Integer;
  liMaxCaption: Integer;
  liDifference: Integer;

begin

  Caption := ppLoadStr(384); {Position}

  lLabels := TList.Create;

  for liIndex := 0 to ControlCount-1 do
    if not (Controls[liIndex] is TLabel) then
      lLabels.Add(Controls[liIndex]);

  liSaveMaxCaption := ppCalcMaxLabelCaption(lLabels);

  lblBottomOffset.Caption    := ppLoadStr(397); {Bottom Offset}
  lblPrintPosition.Caption   := ppLoadStr(398); {Print Position}
  lblHeight.Caption          := ppLoadStr(184); {Height}
  lblPrintCount.Caption      := ppLoadStr(267); {Print Count}
  lblBandsPerRecord.Caption  := ppLoadStr(1133); {Bands Per Record}

  btnApply.Caption  := ppLoadStr(385); {Apply}
  btnOK.Caption     := ppLoadStr(ppMsgOK);
  btnCancel.Caption := ppLoadStr(ppMsgCancel);


  liMaxCaption := ppCalcMaxLabelCaption(lLabels);

  liDifference := liMaxCaption-liSaveMaxCaption;

  for liIndex := 0 to ControlCount-1 do
    if not (Controls[liIndex] is TLabel) then
      Controls[liIndex].Left :=  Controls[liIndex].Left + liDifference;


  Width := Width + liDifference;


  lLabels.Free;

end; {procedure, LanguageChanged}


{------------------------------------------------------------------------------}
{ TppBandPositionDialog.edtBottomOffsetExit }

procedure TppBandPositionDialog.edtBottomOffsetChange(Sender: TObject);
begin

  if (ActiveControl = btnCancel) then Exit;

  try
    PropBottomOffset := StrToFloat(edtBottomOffset.Text);
  except on EConvertError do
    WarningDlg(ppLoadStr(377));
  end;

end; {procedure, edtBottomOffsetExit}


{------------------------------------------------------------------------------}
{ TppBandPositionDialog.edtBottomOffsetKeyPress }

procedure TppBandPositionDialog.edtBottomOffsetKeyPress(Sender: TObject; var Key: Char);
begin

  if (Key = chEnterKey) then
    edtBottomOffsetChange(Sender);

end;  {procedure, edtBottomOffsetKeyPress}


{------------------------------------------------------------------------------}
{ TppBandPositionDialog.edtPrintPositionChange }

procedure TppBandPositionDialog.edtPrintPositionChange(Sender: TObject);
begin

  if (ActiveControl = btnCancel) then Exit;

  try
    PropPrintPosition := StrToFloat(edtPrintPosition.Text);
  except on EConvertError do
    WarningDlg(ppLoadStr(377));
  end;

end; {procedure, edtPrintPositionChange}

{------------------------------------------------------------------------------}
{ TppBandPositionDialog.edtPrintPositionKeyPress }

procedure TppBandPositionDialog.edtPrintPositionKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = chEnterKey) then
    edtPrintPositionChange(Sender);

end; {procedure, edtPrintPositionKeyPress}

{------------------------------------------------------------------------------}
{ TppBandPositionDialog.edtHeightExit }

procedure TppBandPositionDialog.edtHeightChange(Sender: TObject);
begin

  if (ActiveControl = btnCancel) then Exit;

  try
    PropHeight := StrToFloat(edtHeight.Text);
  except on EConvertError do
    begin
      ModalResult := mrNone;
      WarningDlg(ppLoadStr(377));
    end
  end;

end; {procedure, edtHeightExit}

{------------------------------------------------------------------------------}
{ TppBandPositionDialog.edtHeightKeyPress }

procedure TppBandPositionDialog.edtHeightKeyPress(Sender: TObject; var Key: Char);
begin
   if (Key = chEnterKey) then
    edtHeightChange(Sender);

end; {procedure, edtHeightKeyPress}


{------------------------------------------------------------------------------}
{ TppBandPositionDialog.spinHeightClick }

procedure TppBandPositionDialog.spinHeightClick(Sender: TObject; Button: TUDBtnType);
begin

  if (Button = btPrev) then
    SpinPosition(ppptHeight, -FSpinIncrement)
  else
    SpinPosition(ppptHeight, FSpinIncrement);

end; {procedure, spinHeightClick}


{------------------------------------------------------------------------------}
{ TppBandPositionDialog.spinBottomOffsetClick }

procedure TppBandPositionDialog.spinBottomOffsetClick(Sender: TObject; Button: TUDBtnType);
begin
  if Button = btPrev then
    SpinPosition(ppptBottomOffset, -FSpinIncrement)
  else
    SpinPosition(ppptBottomOffset, FSpinIncrement);

end; {procedure, spinBottomOffsetClick}


{------------------------------------------------------------------------------}
{ TppBandPositionDialog.spinPrintPositionClick }

procedure TppBandPositionDialog.spinPrintPositionClick(Sender: TObject; Button: TUDBtnType);
begin

  if Button = btPrev then
    begin
      if (PropPrintPosition = 0) then Exit;
      SpinPosition(ppptPrintPosition, -FSpinIncrement);
    end
  else
    SpinPosition(ppptPrintPosition, FSpinIncrement);

end; {procedure, spinPrintPositionClick}

{------------------------------------------------------------------------------}
{ TppBandPositionDialog.spinPrintCountClick }

procedure TppBandPositionDialog.spinPrintCountClick(Sender: TObject; Button: TUDBtnType);
begin

  if Button = btNext then
    PropPrintCount  := PropPrintCount + 1

  else if PropPrintCount > 0 then
    PropPrintCount  := PropPrintCount - 1;

  edtPrintCount.Text := IntToStr(PropPrintCount);

end; {procedure, spinPrintCountClick}

{------------------------------------------------------------------------------}
{ TppBandPositionDialog.spinBandsPerRecordClick }

procedure TppBandPositionDialog.spinBandsPerRecordClick(Sender: TObject; Button: TUDBtnType);
begin

  if Button = btNext then
    FPropBandsPerRecord := FPropBandsPerRecord + 1

  else if FPropBandsPerRecord > 1 then
    FPropBandsPerRecord := FPropBandsPerRecord - 1;

  edtBandsPerRecord.Text := IntToStr(FPropBandsPerRecord);

end; {procedure, spinBandsPerRecordClick}

{------------------------------------------------------------------------------}
{ TppBandPositionDialog.edtPrintCountChange }

procedure TppBandPositionDialog.edtPrintCountChange(Sender: TObject);
begin

  if (ActiveControl = btnCancel) then Exit;

  try
    PropPrintCount := StrToInt(edtPrintCount.Text);
  except on EConvertError do
    WarningDlg(ppLoadStr(377));
  end;

end;

{------------------------------------------------------------------------------}
{ TppBandPositionDialog.edtPrintCountKeyPress }

procedure TppBandPositionDialog.edtPrintCountKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = chEnterKey) then
    edtPrintCountChange(Sender);

end;

{------------------------------------------------------------------------------}
{ TppBandPositionDialog.edtBandsPerRecordExit }

procedure TppBandPositionDialog.edtBandsPerRecordChange(Sender: TObject);
var
  liBandsPerRecord: Integer;
begin

  if (ActiveControl = btnCancel) then Exit;

  try
    liBandsPerRecord := StrToInt(edtBandsPerRecord.Text);

    if liBandsPerRecord >= 1 then
      FPropBandsPerRecord :=  liBandsPerRecord
    else
      edtBandsPerRecord.Text := '1';

  except on EConvertError do
    WarningDlg(ppLoadStr(377));
  end;

end;

{------------------------------------------------------------------------------}
{ TppBandPositionDialog.edtBandsPerRecordKeyPress }

procedure TppBandPositionDialog.edtBandsPerRecordKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = chEnterKey) then
    edtBandsPerRecordChange(Sender);

end;


{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}



initialization

  ppRegisterForm(TppCustomBandPositionDialog, TppBandPositionDialog);

finalization

  ppUnRegisterForm(TppCustomBandPositionDialog);

end.

