{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppPDFRendererStandardText;

interface

uses
  Classes,
  Windows,
  ppPrintr,
  ppDevice,
  ppDrwCmd,
  ppPDFRendererCustomText;

type

  {@TppPDFRendererStandardText

    Used to render non-wrapped text to PDF.  Contains instructions to generate
    any one line of text.  The TppPDFRendererStandardText object renders the
    following ReportBuilder components:

     - TppLabel (w/out WrappedText)
     - TppVariable
     - TppSystemVariable
     - TppDBText
     - TppDBCalc

  }

  TppPDFRendererStandardText = class(TppPDFRendererCustomText)
    private
      FBottomOffset: Double;
      FLeftOffset: Double;
      FTextWidthPoints: Double;
      FTextHeightPoints: Double;

      procedure CreateText;
      procedure RotateCoordinateSpace(aLeft, aTop: Integer);

      procedure AdjustTextPosition;
      procedure AdjustRotatedTextPosition;

    public
      class function DrawCommandClass: TppDrawCommandClass; override;
      procedure RenderToPDF; override;

  end;

implementation

uses
  Forms,
  Graphics,
  SysUtils,
  ppRotatedText,
  ppUtils,
  ppPlainText,
  ppTypes,
  ppPDFAction,
  ppPDFUtils,
  Math;

{TppPDFText.AdjustTextPosition

  Calculates the left and top offset of the text based on its justification and
  border setting according to the length of the text compared to the control
  box. }

procedure TppPDFRendererStandardText.AdjustTextPosition;
const
  cDefaultPPI = 600;
var
  ldAscent: Double;
  lCanvas: TCanvas;
  ldLeft: Double;
  ldRight: Double;
  liTextWidthPixels: Integer;
  liTextHeightPixels: Integer;
  lWeight: Single;
  ldControlWidth: Double;
  ldOffset: Double;
  lAlignment: TAlignment;
  lBorderPositions: TppBorderPositions;
  liBuffer: Integer;
  liPPI: Integer;
  liSaveFontSize: Integer;
begin

  lAlignment := DrawTextCommand.Alignment;

  ldAscent := TppPDFUtils.PixelsToPoints(TextMetric.tmAscent, Printer.PixelsPerInch.Y);
  ldLeft := TppPDFUtils.MicronsToPoints(DrawTextCommand.Left);
  ldRight := TppPDFUtils.MicronsToPoints(DrawTextCommand.Left + DrawTextCommand.Width);

  FLeftOffset := ldLeft;
  FBottomOffset := RoundTo(PageHeight - TppPDFUtils.MicronsToPoints(DrawTextCommand.Top) - ldAscent, -2);

  lCanvas := Printer.Canvas;
  lCanvas.Font := DrawTextCommand.Font;

  if Printer.PixelsPerInch.X >= cDefaultPPI then
    liPPI := Printer.PixelsPerInch.X
  else
    begin
      liPPI := cDefaultPPI;
      liSaveFontSize := lCanvas.Font.Size;
      lCanvas.Font.PixelsPerInch := liPPI;
      lCanvas.Font.Size := liSaveFontSize;
    end;

  {Add space to account for text measurement error}
  liBuffer := Round(liPPI * (0.01));

  {Find width and height of text}
  liTextWidthPixels := lCanvas.TextWidth(DrawTextCommand.Text) + liBuffer;
  liTextHeightPixels := lCanvas.TextHeight(DrawTextCommand.Text);
  FTextWidthPoints := TppPDFUtils.PixelsToPoints(liTextWidthPixels, liPPI);
  FTextHeightPoints := TppPDFUtils.PixelsToPoints(liTextHeightPixels, liPPI);

  ldControlWidth := TppPDFUtils.MicronsToPoints(DrawTextCommand.Width);

  ldOffset := ldControlWidth - FTextWidthPoints;

  {Adjust for borders}
  if DrawTextCommand.Border.Visible then
    begin
      lWeight := DrawTextCommand.Border.Weight;
      lBorderPositions := DrawTextCommand.Border.BorderPositions;

      if (bpTop in lBorderPositions) then
        FBottomOffset := FBottomOffset - lWeight;

      if (bpLeft in lBorderPositions) and (lAlignment = taLeftJustify) then
        FLeftOffset := FLeftOffset + lWeight
      else if (bpLeft in lBorderPositions) and (lAlignment = taRightJustify) then
        FLeftOffset := FLeftOffset - lWeight;
    end;

  {Adjust for text alignment}
  case lAlignment of
    taCenter: FLeftOffset := FLeftOffset + (ldOffset/2);
    taRightJustify: FLeftOffset := ldRight - FTextWidthPoints;
  end;

end;

{TppPDFText.AdjustRotatedTextPosition

  Calculates the left and top offset of Rotated text based on its border }

procedure TppPDFRendererStandardText.AdjustRotatedTextPosition;
var
  liAngle: Integer;
  ldBorderWidth: Double;
  lBorder: TppBorder;
begin

  liAngle := DrawTextCommand.Angle;
  lBorder := DrawTextCommand.Border;
  ldBorderWidth := lBorder.Weight;

  if (liAngle > 0) and (liAngle <= 90) then
    begin
      if (bpLeft in lBorder.BorderPositions) and (not(bpBottom in lBorder.BorderPositions)) then
        begin
          FLeftOffset := FLeftOffset + ldBorderWidth;
          FBottomOffset := FBottomOffset - ldBorderWidth;
        end;

      if (bpBottom in lBorder.BorderPositions) and (not(bpLeft in lBorder.BorderPositions)) then
        begin
          FLeftOffset := FLeftOffset + ldBorderWidth;
          FBottomOffset := FBottomOffset + ldBorderWidth;
        end;

      if ([bpLeft, bpBottom] <= lBorder.BorderPositions) then
        FLeftOffset := FLeftOffset + ldBorderWidth;
    end
  else if (liAngle > 90) and (liAngle <= 180) then
    begin
      if (bpRight in lBorder.BorderPositions) and (not(bpBottom in lBorder.BorderPositions)) then
        begin
          FLeftOffset := FLeftOffset + ldBorderWidth;
          FBottomOffset := FBottomOffset + ldBorderWidth;
        end;

      if (bpBottom in lBorder.BorderPositions) and (not(bpRight in lBorder.BorderPositions)) then
        begin
          FLeftOffset := FLeftOffset + ldBorderWidth;
          FBottomOffset := FBottomOffset - ldBorderWidth;
        end;

      if ([bpRight, bpBottom] <= lBorder.BorderPositions) then
        FLeftOffset := FLeftOffset + ldBorderWidth;
    end
  else if (liAngle > 180) and (liAngle <= 270) then
    begin
      if (bpRight in lBorder.BorderPositions) and (not(bpTop in lBorder.BorderPositions)) then
        begin
          FLeftOffset := FLeftOffset + ldBorderWidth;
          FBottomOffset := FBottomOffset - ldBorderWidth;
        end;

      if (bpTop in lBorder.BorderPositions) and (not(bpRight in lBorder.BorderPositions)) then
        begin
          FLeftOffset := FLeftOffset + ldBorderWidth;
          FBottomOffset := FBottomOffset + ldBorderWidth;
        end;

      if ([bpRight, bpTop] <= lBorder.BorderPositions) then
        FLeftOffset := FLeftOffset + ldBorderWidth;
    end
  else
    begin
      if (bpLeft in lBorder.BorderPositions) and (not(bpTop in lBorder.BorderPositions)) then
        begin
          FLeftOffset := FLeftOffset + ldBorderWidth;
          FBottomOffset := FBottomOffset + ldBorderWidth;
        end;

      if (bpTop in lBorder.BorderPositions) and (not(bpLeft in lBorder.BorderPositions)) then
        begin
          FLeftOffset := FLeftOffset + ldBorderWidth;
          FBottomOffset := FBottomOffset - ldBorderWidth;
        end;

      if ([bpLeft, bpTop] <= lBorder.BorderPositions) then
        FLeftOffset := FLeftOffset + ldBorderWidth;
    end;

end;

{ TppPDFText.CreateText

  Calculates position, color, and size of the text, then writes the PDF
  instructions to draw the text to the current PDF Page Content stream. }

procedure TppPDFRendererStandardText.CreateText;
var
  lsText: String;
  lDrawMMRect: TRect;
  lRotatedOrigin: TPoint;
  lCanvasTextOrigin: TPoint;
  liWidthChange: Integer;
  liHeightChange: Integer;
  lPDFAction: TppPDFAction;
  liLeft: Integer;
  liTop: Integer;
  liRight: Integer;
  liBottom: Integer;
begin

  lsText := DrawTextCommand.Text;

  {Text Position}
  if DrawTextCommand.Angle = 0 then
    AdjustTextPosition
  else
    begin
      //Recalc Rotated Origin in case text was manually entered in the OnGetText event
      lRotatedOrigin := TppRotatedText.CalcRotatedOrigin(Printer.Canvas, DrawTextCommand.Text, DrawTextCommand.Font, DrawTextCommand.Width, DrawTextCommand.Height, DrawTextCommand.Angle, DrawTextCommand.AutoSize,DrawTextCommand.Alignment, DrawTextCommand.Border);
      lCanvasTextOrigin.X := DrawTextCommand.Left + lRotatedOrigin.X;
      lCanvasTextOrigin.Y := DrawTextCommand.Top + lRotatedOrigin.Y;

      {Handle aligned growing text}
      if (DrawTextCommand.AutoSize) and (DrawTextCommand.Alignment <> taLeftJustify) then
        begin
          lDrawMMRect := TppRotatedText.CalcRotatedTextBounds(Printer.Canvas, DrawTextCommand.Text, DrawTextCommand.Font, 0, 0, DrawTextCommand.Width, DrawTextCommand.Height, DrawTextCommand.Angle, DrawTextCommand.AutoSize, DrawTextCommand.Alignment, nil);

          liWidthChange := lDrawMMRect.Right - DrawTextCommand.Width;
          liHeightChange := lDrawMMRect.Bottom - DrawTextCommand.Height;

          lCanvasTextOrigin := TppRotatedText.AdjustRotatedText(lCanvasTextOrigin, DrawTextCommand, liWidthChange, liHeightChange);
        end;

      RotateCoordinateSpace(lCanvasTextOrigin.X, lCanvasTextOrigin.Y);

      if DrawTextCommand.Border.Visible then
        AdjustRotatedTextPosition;
    end;

  {Write Text}
  PDFCanvas.DrawText(FLeftOffset, FBottomOffset, lsText);

  if DrawTextCommand.HyperLink <> '' then
    begin
      lPDFAction := TppPDFAction.Create;

      liLeft   := DrawTextCommand.Left;
      liTop    := DrawTextCommand.Top;
      liRight  := DrawTextCommand.Left + DrawTextCommand.Width;
      liBottom := DrawTextCommand.Top + DrawTextCommand.Height;

      lPDFAction.ActionBounds := Rect(liLeft, liTop, liRight, liBottom);
      lPDFAction.ActionPage := PDFXRef.PageCount;
      lPDFAction.HyperLink := DrawTextCommand.HyperLink;
      lPDFAction.PageHeight := PageHeight;
      PDFXRef.AddObject(lPDFAction);
    end;

end;

class function TppPDFRendererStandardText.DrawCommandClass: TppDrawCommandClass;
begin
  Result := TppDrawText;
  
end;

{TppPDFText.RotateCoordinateSpace }

procedure TppPDFRendererStandardText.RotateCoordinateSpace(aLeft, aTop: Integer);
var
  ldRadian: Double;
  ldTransA: Double;
  ldTransB: Double;
  ldTransC: Double;
  ldTransD: Double;
  lsTransA: String;
  lsTransB: String;
  lsTransC: String;
  lsTransD: String;
  ldLeft: Double;
  ldTop: Double;
  ldHeight: Double;
  ldHOffset: Double;
  ldVOffset: Double;
begin

  ldRadian := DegToRad(DrawTextCommand.Angle);

  ldLeft := RoundTo(TppPDFUtils.MicronsToPoints(aLeft), -2);
  ldTop := RoundTo(PageHeight - TppPDFUtils.MicronsToPoints(aTop), -2);

  {Calculate new Transformation Matrix values}
  ldTransA := RoundTo(Cos(ldRadian), -2);
  ldTransB := RoundTo(Sin(ldRadian), -2);
  ldTransC := RoundTo(-Sin(ldRadian), -2);
  ldTransD := ldTransA;

  lsTransA := ExtToStr(ldTransA);
  lsTransB := ExtToStr(ldTransB);
  lsTransC := ExtToStr(ldTransC);
  lsTransD := ExtToStr(ldTransD);

  {Calculate horizontal and vertical offsets}
  ldHeight := TppPDFUtils.PixelsToPoints(TextMetric.tmHeight, Printer.PixelsPerInch.Y);
  ldHOffset := RoundTo(Sin(ldRadian) * ldHeight, -2);
  ldVOffset := RoundTo(Cos(ldRadian) * ldHeight, -2);

  {Translate}
  WriteLine('1 0 0 1 ' + ExtToStr(ldLeft + ldHOffset) + ' ' + ExtToStr(ldTop - ldVOffset) + ' cm');
  {Rotate}
  WriteLine(lsTransA + ' ' + lsTransB + ' ' + lsTransC + ' ' + lsTransD + ' 0 0 cm');

  FLeftOffset := 0;
  FBottomOffset := 0;

end;

{@TppPDFText.RenderToPDF }
procedure TppPDFRendererStandardText.RenderToPDF;
begin
  inherited;

  CreateText;
  StylizeText(FTextWidthPoints, FTextHeightPoints, FBottomOffset, FLeftOffset);
  EndText;

end;

end.
