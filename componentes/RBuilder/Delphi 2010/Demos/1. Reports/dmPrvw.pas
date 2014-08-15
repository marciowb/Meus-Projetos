{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2001                    BBBBB   }

unit dmPrvw;

interface

uses
  Windows, SysUtils, Messages, Classes, Graphics, Controls,
  Forms, ExtCtrls, StdCtrls, Mask, Buttons,
  ppForms, ppTypes, ppDevice, ppViewr, ppFilDev, ppUtils, ComCtrls;

type

  { TfrmTwoPagePreview }
  TfrmTwoPagePreview = class(TppCustomPreviewer)
    pnlPreviewBar: TPanel;
    spbPreviewPrint: TSpeedButton;
    spbPreviewWhole: TSpeedButton;
    spbPreviewFirst: TSpeedButton;
    spbPreviewPrior: TSpeedButton;
    spbPreviewNext: TSpeedButton;
    spbPreviewLast: TSpeedButton;
    mskPreviewPage: TMaskEdit;
    spbPreviewWidth: TSpeedButton;
    spbPreview100Percent: TSpeedButton;
    spbPreviewClose: TSpeedButton;
    ppViewer1: TppViewer;
    mskPreviewPercentage: TMaskEdit;
    pnlStatusBar: TStatusBar;
    ppViewer2: TppViewer;
    procedure spbPreviewPrintClick(Sender: TObject);
    procedure spbPreviewWholeClick(Sender: TObject);
    procedure spbPreviewFirstClick(Sender: TObject);
    procedure spbPreviewPriorClick(Sender: TObject);
    procedure spbPreviewNextClick(Sender: TObject);
    procedure spbPreviewLastClick(Sender: TObject);
    procedure mskPreviewPageKeyPress(Sender: TObject; var Key: Char);
    procedure ppViewerPageChange(Sender: TObject);
    procedure ppViewerStatusChange(Sender: TObject);
    procedure spbPreviewWidthClick(Sender: TObject);
    procedure spbPreview100PercentClick(Sender: TObject);
    procedure spbPreviewCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mskPreviewPercentageKeyPress(Sender: TObject; var Key: Char);
    procedure ppViewer1PrintStateChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private

  protected
    {overriden from TppForm}
    procedure LanguageChanged; override;
    procedure ReportAssigned; override;
    function  GetViewer: TObject; override;

  public

  end; {class, TfrmTwoPagePreview}

var
  frmTwoPagePreview: TfrmTwoPagePreview;

implementation

{$R *.DFM}

uses ppReport;

{------------------------------------------------------------------------------}
{ TppPrintPreview.FormCreate }

procedure TfrmTwoPagePreview.FormCreate(Sender: TObject);
begin

  {scale, if large fonts}
  if (Screen.PixelsPerInch <> 96) then
    begin
      Height := Trunc(Height * 1.25);
      Width  := Trunc(Width  * 1.25);
    end;

  {default second viewer second page}
  ppViewer2.ScreenDevice.PageSetting := psSinglePage;
  ppViewer2.ScreenDevice.PageRequested := 2;

end; {procedure FormCreate}

{------------------------------------------------------------------------------}
{ TppPrintPreview.ReportAssigned }

procedure TfrmTwoPagePreview.ReportAssigned;
begin
  if Report is TppReport then
    begin
      ppViewer1.Report := TppReport(Report);
      ppViewer2.Report := TppReport(Report);
    end;
end; {procedure, ReportAssigned}

{------------------------------------------------------------------------------}
{ TppPrintPreview.LanguageChanged}

procedure TfrmTwoPagePreview.LanguageChanged;
var
  lBitMap: TBitMap;
begin
  spbPreviewPrint.Hint := ppLoadStr(ppMsgPrint);
  spbPreviewWhole.Hint := ppLoadStr(ppMsgWhole);
  spbPreviewWidth.Hint := ppLoadStr(ppMsgPageWidth);
  spbPreview100Percent.Hint := ppLoadStr(ppMsg100Percent);
  spbPreviewFirst.Hint := ppLoadStr(ppMsgFirst);
  spbPreviewPrior.Hint := ppLoadStr(ppMsgPrior);
  spbPreviewNext.Hint := ppLoadStr(ppMsgNext);
  spbPreviewLast.Hint := ppLoadStr(ppMsgLast);
  spbPreviewClose.Caption := ppLoadStr(ppMsgClose);

  lBitMap := TBitMap.Create;
  spbPreviewClose.Width := lBitMap.Canvas.TextWidth(spbPreviewClose.Caption) + 30;
  lBitMap.Free;

  Caption := ppLoadStr(ppMsgPrintPreview);

end; {procedure, LanguageChanged}

{------------------------------------------------------------------------------}
{ TppPrintPreview.GetViewer }

function TfrmTwoPagePreview.GetViewer: TObject;
begin
  Result := ppViewer1;
end; {function, GetViewer}

{------------------------------------------------------------------------------}
{ TppPrintPreview.ppViewer1PrintStateChange }

procedure TfrmTwoPagePreview.ppViewer1PrintStateChange(Sender: TObject);
var
  lPosition: TPoint;
begin

  if ppViewer1.Busy then
    begin
      mskPreviewPercentage.Enabled := False;
      mskPreviewPage.Enabled := False;

      pnlPreviewBar.Cursor := crHourGlass;

      ppViewer1.Cursor := crHourGlass;
      ppViewer2.Cursor := crHourGlass;

      pnlStatusBar.Cursor := crHourGlass;

      spbPreviewClose.Cursor := crArrow;

      spbPreviewClose.Caption := ppLoadStr(ppMsgCancel);
    end
  else
    begin
      mskPreviewPercentage.Enabled := True;
      mskPreviewPage.Enabled := True;

      pnlPreviewBar.Cursor := crDefault;

      ppViewer1.Cursor := crDefault;
      ppViewer2.Cursor := crDefault;

      pnlStatusBar.Cursor := crDefault;

      spbPreviewClose.Cursor := crDefault;

      spbPreviewClose.Caption := ppLoadStr(ppMsgClose);
    end;

  {this code will force the cursor to update}
  GetCursorPos(lPosition);
  SetCursorPos(lPosition.X, lPosition.Y);

end;


{------------------------------------------------------------------------------}
{ TppPrintPreview.spbCloseClick }

procedure TfrmTwoPagePreview.spbPreviewCloseClick(Sender: TObject);
begin
  if TppReport(Report).Printing then
    ppViewer1.Cancel
  else
    Close;
end; {procedure, spbCloseClick}

{------------------------------------------------------------------------------}
{ TppPrintPreview.ppViewerStatusChange }

procedure TfrmTwoPagePreview.ppViewerStatusChange(Sender: TObject);
begin
  pnlStatusBar.SimpleText := TppViewer(Sender).Status;

end; {procedure, ppViewerStatusChange}

{------------------------------------------------------------------------------}
{ TppPrintPreview.ppViewerPageChange }

procedure TfrmTwoPagePreview.ppViewerPageChange(Sender: TObject);
begin
  mskPreviewPage.Text := IntToStr(TppViewer(Sender).AbsolutePageNo);
  mskPreviewPercentage.Text := IntToStr(TppViewer(Sender).CalculatedZoom);
end; {procedure, ppViewerPageChange}

{------------------------------------------------------------------------------}
{ TppPrintPreview.spbPreviewPrintClick }

procedure TfrmTwoPagePreview.spbPreviewPrintClick(Sender: TObject);
begin
  ppViewer1.Print;
end; {procedure, spbPreviewPrintClick}

{------------------------------------------------------------------------------}
{ TppPrintPreview.spbPreviewFirstClick}

procedure TfrmTwoPagePreview.spbPreviewFirstClick(Sender: TObject);
begin
  ppViewer2.ScreenDevice.Active := False;
  ppViewer1.FirstPage;
  ppViewer2.ScreenDevice.Active := True;

  ppViewer2.GotoPage(ppViewer1.AbsolutePageNo + 1);
end; {procedure, spbCloseClick}

{------------------------------------------------------------------------------}
{ TppPrintPreview.spbPreviewPriorClick}

procedure TfrmTwoPagePreview.spbPreviewPriorClick(Sender: TObject);
begin
  ppViewer2.ScreenDevice.Active := False;
  ppViewer1.PriorPage;
  ppViewer2.ScreenDevice.Active := True;

  ppViewer2.GotoPage(ppViewer1.AbsolutePageNo + 1);
end; {procedure, spbPreviewFirstClick}

{------------------------------------------------------------------------------}
{ TppPrintPreview.spbPreviewNextClick}

procedure TfrmTwoPagePreview.spbPreviewNextClick(Sender: TObject);
begin

  ppViewer2.ScreenDevice.Active := False;
  ppViewer1.NextPage;
  ppViewer2.ScreenDevice.Active := True;

  ppViewer2.GotoPage(ppViewer1.AbsolutePageNo + 1);
end; {procedure, spbPreviewNextClick}

{------------------------------------------------------------------------------}
{ TppPrintPreview.spbPreviewLastClick}

procedure TfrmTwoPagePreview.spbPreviewLastClick(Sender: TObject);
begin
  ppViewer1.ScreenDevice.Active := False;
  ppViewer2.LastPage;
  ppViewer1.ScreenDevice.Active := True;

  ppViewer1.GotoPage(ppViewer2.AbsolutePageNo - 1);
end; {procedure, spbPreviewLastClick}

{------------------------------------------------------------------------------}
{ TppPrintPreview.mskPreviewPageKeyPress}

procedure TfrmTwoPagePreview.mskPreviewPageKeyPress(Sender: TObject; var Key: Char);
var
  liPage: Longint;
begin

  if (Key = #13) then
    begin
      liPage := StrToInt(mskPreviewPage.Text);

      ppViewer2.ScreenDevice.Active := False;
      ppViewer1.GotoPage(liPage);
      ppViewer2.ScreenDevice.Active := True;

      ppViewer2.GotoPage(liPage + 1);
    end; {if, carriage return pressed}

end; {procedure, mskPreviewPageKeyPress}

{------------------------------------------------------------------------------}
{ TppPrintPreview.spbPreviewZoomClick }

procedure TfrmTwoPagePreview.spbPreviewWholeClick(Sender: TObject);
begin
  ppViewer1.ZoomSetting := zsWholePage;
  ppViewer2.ZoomSetting := zsWholePage;

  mskPreviewPercentage.Text := IntToStr(ppViewer1.CalculatedZoom);

  pnlPreviewBar.SetFocus;
end; {procedure, spbPreviewZoomClick}

{------------------------------------------------------------------------------}
{ TppPrintPreview.spbPreviewWidthClick}

procedure TfrmTwoPagePreview.spbPreviewWidthClick(Sender: TObject);
begin
  ppViewer1.ZoomSetting := zsPageWidth;
  ppViewer2.ZoomSetting := zsPageWidth;

  mskPreviewPercentage.Text := IntToStr(ppViewer1.CalculatedZoom);

  pnlPreviewBar.SetFocus;
end; {procedure, spbPreviewWidthClick}

{------------------------------------------------------------------------------}
{ TppPrintPreview.spbPreview100PercentClick}

procedure TfrmTwoPagePreview.spbPreview100PercentClick(Sender: TObject);
begin
  ppViewer1.ZoomSetting := zs100Percent;
  ppViewer2.ZoomSetting := zs100Percent;

  mskPreviewPercentage.Text := IntToStr(ppViewer1.CalculatedZoom);

  pnlPreviewBar.SetFocus;
end; {procedure, spbPreview100PercentClick}

{------------------------------------------------------------------------------}
{ TppPrintPreview.mskPreviewPercentageKeyPress}

procedure TfrmTwoPagePreview.mskPreviewPercentageKeyPress(Sender: TObject; var Key: Char);
var
  liPercentage: Integer;
begin
  if (Key = #13) then
    begin
      liPercentage := StrToIntDef(mskPreviewPercentage.Text, 100);

      ppViewer1.ZoomPercentage := liPercentage;
      ppViewer2.ZoomPercentage := liPercentage;

      spbPreviewWhole.Down := False;
      spbPreviewWidth.Down := False;
      spbPreview100Percent.Down := False;

      mskPreviewPercentage.Text := IntToStr(ppViewer1.CalculatedZoom);
    end; {if, carriage return pressed}

end; {procedure, mskPreviewPercentageKeyPress}

{------------------------------------------------------------------------------}
{ TppPrintPreview.FormClose}

procedure TfrmTwoPagePreview.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

{------------------------------------------------------------------------------}
{ TppPrintPreview.FormResize}

procedure TfrmTwoPagePreview.FormResize(Sender: TObject);
begin
  ppViewer1.Width := (Width div 2) - 4;
  ppViewer2.Width := ppViewer1.Width;
end; {procedure, FormResize}

{------------------------------------------------------------------------------}
{ TppPrintPreview.FormKeyDown}

procedure TfrmTwoPagePreview.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if not(ssCtrl in Shift) then Exit;

  case Key of
    VK_PRIOR:
      begin
        ppViewer2.ScreenDevice.Active := False;
        ppViewer1.PriorPage;
        ppViewer2.ScreenDevice.Active := True;
        ppViewer2.GotoPage(ppViewer1.AbsolutePageNo + 1);
      end;

    VK_NEXT:
      begin
        ppViewer2.ScreenDevice.Active := False;
        ppViewer1.NextPage;
        ppViewer2.ScreenDevice.Active := True;
        ppViewer2.GotoPage(ppViewer1.AbsolutePageNo + 1);
      end;

    VK_HOME:
      begin
        ppViewer2.ScreenDevice.Active := False;
        ppViewer1.FirstPage;
        ppViewer2.ScreenDevice.Active := True;
        ppViewer2.GotoPage(ppViewer1.AbsolutePageNo + 1);
      end;

    VK_END:
      begin
        ppViewer1.ScreenDevice.Active := False;
        ppViewer2.LastPage;
        ppViewer1.ScreenDevice.Active := True;
        ppViewer1.GotoPage(ppViewer2.AbsolutePageNo - 1);
      end;

  end;

end; {procedure, FormResize}


end.
