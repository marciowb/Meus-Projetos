{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2004                    BBBBB   }

unit ppRotatedText;

interface

uses
  Windows,
  Graphics,
  Classes,

  ppUtils,
  ppTypes,
  ppDrwCmd;

type

{TppRotateInfoRec

  - UserBoxWidth:  Width of the user defined control box.

  - UserBoxHeight: Height of the user defined control box.

  - TextBoxWidth:  Width of the virtual angled box able to fit inside the UserBox.

  - TextBoxHeight: Height of the text.

  - AutoBoxWidth:  Virtual width of the minimum sized box the angled text can fit.
                   If AutoSize is True, AutoBoxWidth = UserBoxWidth.

  - AutoBoxHeight: Virtual height of the minimum sized box the angled text can
                   fit.  If AutoSize is True, AutoBoxHeight = UserBoxHeight.

  - Ah,Oh,Aw,Ow:   These variables represent the virtual sides of triangles
                   created by placing the TextBox inside the UserBox according
                   to the given angle of rotation.  They define the adjascent
                   height, opposite height, adjascent width, and opposite width
                   of each triangle respectively.

  - ProportionX:   Proportion of Aw and the TextBoxWidth (used for alignment).

  - ProportionY:   Proportion of Oh and the TextBoxWidth (used of alignment). }

  TppRotateInfoRec = record
    UserBoxWidth: Integer;
    UserBoxHeight: Integer;
    TextBoxWidth: Integer;
    TextBoxHeight: Integer;
    AutoBoxWidth: Integer;
    AutoBoxHeight: Integer;
    Ah: Double;
    Oh: Double;
    Aw: Double;
    Ow: Double;
    ProportionX: Double;
    ProportionY: Double;
  end;

  TppRotatedText = class
    private
      class function CalcRotateInfo(aRadian: Double; aUserBox, aTextSize: TSize; aOrigin: TPoint; aAutoSize: Boolean; aBorder: TppBorder): TppRotateInfoRec;
      class function CalcTextSize(aCanvas: TCanvas; aText: String; aFont: TFont; aAngle: Integer; aAlignment: TAlignment): TSize;
      class function CalcRotatedTextPos(aAngle: Integer; aTextSize: TSize; aOrigin: TPoint; aRotateInfo: TppRotateInfoRec; aAlignment: TAlignment):TPoint;
      class function CreateRotatedFont(aFont: TFont; aAngle: Integer): HFont;
      class function CalcAlignmentRect(aAngle, aOriginalWidth, aOriginalHeight: Integer; aOrigin: TPoint; aAlignment: TAlignment; aRotateInfoRec: TppRotateInfoRec): TRect;

    public
      class procedure TextOutRotate(aCanvas: TCanvas; aFont: TFont; aRect: TRect; aX, aY: Integer; aAngle: longint; aText: string);

      class function AdjustAutoRect(aDrawText: TppDrawText; aLeft, aTop, aWidth, aHeight, aOriginalWidth, aOriginalHeight: Integer): TRect;
      class function AdjustRotatedText(aOrigin: TPoint; aDrawText: TppDrawText; aWidthChange, aHeightChange: Integer): TPoint;
      class function CalcRotatedTextBounds(aCanvas: TCanvas; aText: String; aFont: TFont; aLeft, aTop, aWidth, aHeight, aAngle: Integer; aAutoSize: Boolean; aAlignment: TAlignment; aBorder: TppBorder): TRect;
      class function CalcRotatedOrigin(aCanvas: TCanvas; aText: String; aFont: TFont; aWidth, aHeight, aAngle: Integer; aAutoSize: Boolean; aAlignment: TAlignment; aBorder: TppBorder): TPoint;
  end;

implementation

uses
  SysUtils,
  Math;

{ TppRotatedText }


class function TppRotatedText.AdjustAutoRect(aDrawText: TppDrawText; aLeft, aTop, aWidth, aHeight, aOriginalWidth, aOriginalHeight: Integer): TRect;
begin

  Result.Left := aLeft;
  Result.Top := aTop;

  if aDrawText.Alignment = taCenter then
    begin
      Result.Left := aLeft - ((aWidth - aOriginalWidth) div 2);
      Result.Top := aTop - ((aHeight - aOriginalHeight) div 2);
    end
  else if (aDrawText.Angle > 0) and (aDrawText.Angle <= 90) then
    begin
      case aDrawText.Alignment of
        taLeftJustify:
          begin
            Result.Left := aLeft;
            Result.Top := aTop - (aHeight - aOriginalHeight);
          end;
        taRightJustify:
          begin
            Result.Left := aLeft - (aWidth - aOriginalWidth);
            Result.Top := aTop;
          end;
      end;
    end
  else if (aDrawText.Angle > 90) and (aDrawText.Angle <= 180) then
    begin
      case aDrawText.Alignment of
        taLeftJustify:
          begin
            Result.Left := aLeft - (aWidth - aOriginalWidth);
            Result.Top := aTop - (aHeight - aOriginalHeight);
          end;
      end;
    end
  else if (aDrawText.Angle > 180) and (aDrawText.Angle <= 270) then
    begin
      case aDrawText.Alignment of
        taLeftJustify:
          begin
            Result.Left := aLeft - (aWidth - aOriginalWidth);
            Result.Top := aTop;
          end;
        taRightJustify:
          begin
            Result.Left := aLeft;
            Result.Top := aTop - (aHeight - aOriginalHeight);
          end;
      end;
    end
  else
    begin
      case aDrawText.Alignment of
        taRightJustify:
          begin
            Result.Left := aLeft - (aWidth - aOriginalWidth);
            Result.Top := aTop - (aHeight - aOriginalHeight);
          end;
        end;
    end;

    Result.Right := Result.Left + aWidth;
    Result.Bottom := Result.Top + aHeight;

end;

class function TppRotatedText.AdjustRotatedText(aOrigin: TPoint; aDrawText: TppDrawText; aWidthChange, aHeightChange: Integer): TPoint;
var
  liCenter: Integer;
begin

  if aDrawText.Alignment = taCenter then
    liCenter := 2
  else
    liCenter := 1;

  if (aDrawText.Angle > 0) and (aDrawText.Angle <= 90) then
    begin
      Result.X := aOrigin.X - Round(aWidthChange / liCenter);
      Result.Y := aOrigin.Y + Round(aHeightChange / liCenter);
    end
  else if (aDrawText.Angle > 90) and (aDrawText.Angle <= 180) then
    begin
      Result.X := aOrigin.X + Round(aWidthChange / liCenter);
      Result.Y := aOrigin.Y + Round(aHeightChange / liCenter);
    end
  else if (aDrawText.Angle > 180) and (aDrawText.Angle <= 270) then
    begin
      Result.X := aOrigin.X + Round(aWidthChange / liCenter);
      Result.Y := aOrigin.Y - Round(aHeightChange / liCenter);
    end
  else
    begin
      Result.X := aOrigin.X - Round(aWidthChange / liCenter);
      Result.Y := aOrigin.Y - Round(aHeightChange / liCenter);
    end;

end;

{TppRotatedText.CalcAlignmentRect

  ReCalculates the AutoSized box position based on the current alignment present}

class function TppRotatedText.CalcAlignmentRect(aAngle, aOriginalWidth, aOriginalHeight: Integer; aOrigin: TPoint; aAlignment: TAlignment; aRotateInfoRec: TppRotateInfoRec): TRect;
var
  liWidthChange: Integer;
  liHeightChange: Integer;
begin

  liWidthChange := aRotateInfoRec.AutoBoxWidth - aOriginalWidth;
  liHeightChange := aRotateInfoRec.AutoBoxHeight - aOriginalHeight;

  if aAlignment = taCenter then
    Result := Rect(aOrigin.X - (liWidthChange div 2), aOrigin.Y - (liHeightChange div 2), aRotateInfoRec.AutoBoxWidth, aRotateInfoRec.AutoBoxHeight)

  else if (aAngle > 0) and (aAngle <= 90) then
    begin
      case aAlignment of
        taLeftJustify:
          Result := Rect(aOrigin.X, aOrigin.Y, aRotateInfoRec.AutoBoxWidth, aRotateInfoRec.AutoBoxHeight);
        taRightJustify:
          Result := Rect(aOrigin.X - liWidthChange, aOrigin.Y, aRotateInfoRec.AutoBoxWidth, aRotateInfoRec.AutoBoxHeight);
      end;

    end
  else if (aAngle > 90) and (aAngle <= 180) then
    begin
      case aAlignment of
        taLeftJustify:
          Result := Rect(aOrigin.X, aOrigin.Y, aRotateInfoRec.AutoBoxWidth, aRotateInfoRec.AutoBoxHeight);
        taRightJustify:
          Result := Rect(aOrigin.X, aOrigin.Y, aRotateInfoRec.AutoBoxWidth, aRotateInfoRec.AutoBoxHeight);
      end;

    end
  else if (aAngle > 180) and (aAngle <= 270) then
    begin
      case aAlignment of
        taLeftJustify:
          Result := Rect(aOrigin.X, aOrigin.Y, aRotateInfoRec.AutoBoxWidth, aRotateInfoRec.AutoBoxHeight);
        taRightJustify:
          Result := Rect(aOrigin.X, aOrigin.Y - liHeightChange, aRotateInfoRec.AutoBoxWidth, aRotateInfoRec.AutoBoxHeight);
      end;

    end
  else
    begin
      case aAlignment of
        taLeftJustify:
          Result := Rect(aOrigin.X, aOrigin.Y, aRotateInfoRec.AutoBoxWidth, aRotateInfoRec.AutoBoxHeight);
        taRightJustify:
          Result := Rect(aOrigin.X - liWidthChange, aOrigin.Y - liHeightChange, aRotateInfoRec.AutoBoxWidth, aRotateInfoRec.AutoBoxHeight);
      end;

    end;

end;

{TppRotatedText.CalcRotatedOrigin

  Calculates the point at which the text will be rotated}

class function TppRotatedText.CalcRotatedOrigin(aCanvas: TCanvas; aText: String; aFont: TFont; aWidth, aHeight, aAngle: Integer; aAutoSize: Boolean; aAlignment: TAlignment; aBorder: TppBorder): TPoint;
var
  lRotateInfo: TppRotateInfoRec;
  lTextSize: TSize;
  lUserBox: TSize;
  lOrigin: TPoint;
  ldRadian: Double;
begin

  lTextSize := CalcTextSize(aCanvas, aText, aFont, aAngle, aAlignment);
  ldRadian := DegToRad(aAngle);
  lUserBox.cx := aWidth;
  lUserBox.cy := aHeight;
  lOrigin := Point(0, 0);

  lRotateInfo := CalcRotateInfo(ldRadian, lUserBox, lTextSize, lOrigin, aAutoSize, aBorder);

  //Take autosize into account when recalculating the rotated origin
  if aAutoSize then
    begin
      lOrigin.X := aWidth - lRotateInfo.AutoBoxWidth;
      lOrigin.Y := aHeight - lRotateInfo.AutoBoxHeight;
    end;

  Result := CalcRotatedTextPos(aAngle, lTextSize, lOrigin, lRotateInfo, aAlignment);

end;

class function TppRotatedText.CalcRotatedTextBounds(aCanvas: TCanvas; aText: String; aFont: TFont; aLeft, aTop, aWidth, aHeight, aAngle: Integer; aAutoSize: Boolean; aAlignment: TAlignment; aBorder: TppBorder): TRect;
var
  lRotateInfoRec: TppRotateInfoRec;
  lTextSize: TSize;
  lUserBox: TSize;
  lOrigin: TPoint;
  ldRadian: Double;
begin

  lTextSize := CalcTextSize(aCanvas, aText, aFont, aAngle, aAlignment);
  ldRadian := DegToRad(aAngle);
  lUserBox.cx := aWidth;
  lUserBox.cy := aHeight;
  lOrigin := Point(aLeft, aTop);

  lRotateInfoRec := CalcRotateInfo(ldRadian, lUserBox, lTextSize, lOrigin, aAutoSize, aBorder);

  if aAutoSize then
    Result := CalcAlignmentRect(aAngle, aWidth, aHeight, lOrigin, aAlignment, lRotateInfoRec)
  else
    Result := Rect(lOrigin.X, lOrigin.Y, lRotateInfoRec.UserBoxWidth, lRotateInfoRec.UserBoxHeight);

end;

class function TppRotatedText.CalcRotatedTextPos(aAngle: Integer; aTextSize: TSize; aOrigin: TPoint; aRotateInfo: TppRotateInfoRec; aAlignment: TAlignment): TPoint;
begin
  if (aAngle >= 0) and (aAngle <= 90) then          {Angle Between 0 and 90 degrees (-270 and -360) }
    begin
      Result.X := aOrigin.X;                        {Left Justified Text Position}
      Result.Y := aOrigin.Y + aRotateInfo.UserBoxHeight - Round(Abs(aRotateInfo.Ah));

      if aAlignment = taRightJustify then         {Right Justified Text Position}
        begin
          Result.X := Result.X + Round(Abs(aRotateInfo.Aw)) - Round(aTextSize.cx * aRotateInfo.ProportionX);
          Result.Y := Result.Y - Round(Abs(aRotateInfo.Oh)) + Round(aTextSize.cx * aRotateInfo.ProportionY);
        end
      else if aAlignment = taCenter then          {Center Justified Text Position}
        begin
          Result.X := Result.X + Round(Abs(aRotateInfo.Aw / 2)) - Round((aTextSize.cx * aRotateInfo.ProportionX) / 2);
          Result.Y := Result.Y - Round(Abs(aRotateInfo.Oh / 2)) + Round((aTextSize.cx * aRotateInfo.ProportionY) / 2);
        end;
    end
  else if (aAngle > 90) and (aAngle <= 180) then    {Angle Between 90 and 180 degrees (-180 and -270) }
    begin
      Result.X := aOrigin.X + aRotateInfo.UserBoxWidth - Round(Abs(aRotateInfo.Ow));
      Result.Y := aOrigin.Y +  aRotateInfo.UserBoxHeight;

      if aAlignment = taRightJustify then
        begin
          Result.X := Result.X - Round(Abs(aRotateInfo.Aw)) + Round(aTextSize.cx * aRotateInfo.ProportionX);
          Result.Y := Result.Y - Round(Abs(aRotateInfo.Oh)) + Round(aTextSize.cx * aRotateInfo.ProportionY);
        end
      else if aAlignment = taCenter then
        begin
          Result.X := Result.X - Round(Abs(aRotateInfo.Aw / 2)) + Round((aTextSize.cx * aRotateInfo.ProportionX) / 2);
          Result.Y := Result.Y - Round(Abs(aRotateInfo.Oh / 2)) + Round((aTextSize.cx * aRotateInfo.ProportionY) / 2);
        end;
    end
  else if (aAngle > 180) and (aAngle <= 270) then   {Angle Between 180 and 270 degrees (-180 and -90) }
    begin
      Result.X := aOrigin.X + aRotateInfo.UserBoxWidth;
      Result.Y := aOrigin.Y + Round(Abs(aRotateInfo.Ah));

      if aAlignment = taRightJustify then
        begin
          Result.X := Result.X - Round(Abs(aRotateInfo.Aw)) + Round(aTextSize.cx * aRotateInfo.ProportionX);
          Result.Y := Result.Y + Round(Abs(aRotateInfo.Oh)) - Round(aTextSize.cx * aRotateInfo.ProportionY);
        end
      else if aAlignment = taCenter then
        begin
          Result.X := Result.X - Round(Abs(aRotateInfo.Aw / 2)) + Round((aTextSize.cx * aRotateInfo.ProportionX) / 2);
          Result.Y := Result.Y + Round(Abs(aRotateInfo.Oh / 2)) - Round((aTextSize.cx * aRotateInfo.ProportionY) / 2);
        end;
    end
  else                                              {Angle Between 270 and 360 degrees (-90 and 0) }
    begin
      Result.X := aOrigin.X + Round(Abs(aRotateInfo.Ow));
      Result.Y := aOrigin.Y;

     if aAlignment = taRightJustify then
        begin
          Result.X := Result.X + Round(Abs(aRotateInfo.Aw)) - Round(aTextSize.cx * aRotateInfo.ProportionX);
          Result.Y := Result.Y + Round(Abs(aRotateInfo.Oh)) - Round(aTextSize.cx * aRotateInfo.ProportionY);
        end
      else if aAlignment = taCenter then
        begin
          Result.X := Result.X + Round(Abs(aRotateInfo.Aw / 2)) - Round((aTextSize.cx * aRotateInfo.ProportionX) / 2);
          Result.Y := Result.Y + Round(Abs(aRotateInfo.Oh / 2)) - Round((aTextSize.cx * aRotateInfo.ProportionY) / 2);
        end;
    end;

end;

{TppRotatedText.CalcRotateInfo

  UserBox: Actual size the user defines the text box
  TextBox: Angled box with a height equal to the text height and the maximum
           width able to fit inside the UserBox
  AutoBox: Minimum box size the text can fit in.  If AutoSize is True, UserBox =
           AutoBox.

  -See notes on TppRotateInfoRec for definition of its variables.}

class function TppRotatedText.CalcRotateInfo(aRadian: Double; aUserBox, aTextSize: TSize; aOrigin: TPoint; aAutoSize: Boolean; aBorder: TppBorder): TppRotateInfoRec;
var
  ldCosRadian: Double;
  ldSinRadian: Double;
  ldTanRadian: Double;
begin

  ldCosRadian := RoundTo(Cos(aRadian), -3);
  ldSinRadian := RoundTo(Sin(aRadian), -3);

  if ldCosRadian = 0 then
    ldTanRadian := 0
  else
    ldTanRadian := RoundTo(Tan(aRadian), -3);

  Result.UserBoxWidth := aUserBox.cx;
  Result.UserBoxHeight := aUserBox.cy;

  Result.Ah := ldCosRadian * aTextSize.cy;
  Result.Ow := ldSinRadian * aTextSize.cy;

  if aAutoSize then                                                          //AutoSized Box
    begin
      Result.TextBoxWidth := aTextSize.cx;
      Result.TextBoxHeight := aTextSize.cy;

      Result.Aw := ldCosRadian * aTextSize.cx;
      Result.Oh := ldSinRadian * aTextSize.cx;
    end
  else
    begin
      if aUserBox.cx <= aUserBox.cy then                                     //Tall UserBox
        begin
          {Check to see if angle is 90/270}
          if ldCosRadian = 0 then
            begin
              Result.Aw := 0;
              Result.Oh := aUserBox.cy;
            end
          else
            begin
              Result.Aw :=  aUserBox.cx - Abs(Result.Ow);
              Result.Oh :=  ldTanRadian * Result.Aw;
            end;
          {Angle is large enough to hit the top or bottom boundary of the user box}
          if Round(Abs(Result.Ah) + Abs(Result.Oh)) > aUserBox.cy then
            begin
              Result.Oh := aUserBox.cy - Abs(Result.Ah);
              if ldTanRadian = 0 then
                Result.Aw := 0
              else
                Result.Aw := Result.Oh / ldTanRadian;
            end;
        end
      else                                                                   //Wide UserBox
        begin
          Result.Oh := aUserBox.cy - Abs(Result.Ah);
            {Check to see if the angle is 90/180/270}
            if ldTanRadian = 0 then
              begin
                {Angle is 180}
                if ldSinRadian = 0 then
                  begin
                    Result.Aw := aUserBox.cx;
                    Result.Oh := 0;
                  end
                else
                  Result.Aw := 0;
              end
          else
            Result.Aw := Result.Oh / ldTanRadian;
          {Angle is small enough to hit the left or right boundary of the user box}
          if Round(Abs(Result.Aw) + Abs(Result.Ow)) > aUserBox.cx then
            begin
              Result.Aw :=  aUserBox.cx - Abs(Result.Ow);
              Result.Oh :=  ldTanRadian * Result.Aw;
            end;
        end;
      {Calculate the width of the text box (not the width of the text itself)}
      Result.TextBoxWidth := Round(Sqrt((Sqr(Result.Aw) + Sqr(Result.Oh))));
      Result.TextBoxHeight := aTextSize.cy;
    end;

  Result.AutoBoxWidth := Round(Abs(Result.Aw) + Abs(Result.Ow));
  Result.AutoBoxHeight := Round(Abs(Result.Ah) + Abs(Result.Oh));

  if aAutoSize then
    begin
      if (aBorder <> nil) and (aBorder.Visible) then
        begin
          Result.UserBoxWidth := Result.AutoBoxWidth + 2*aBorder.MMWeight;
          Result.UserBoxHeight := Result.AutoBoxHeight + 2*aBorder.MMWeight;
        end
      else
        begin
          Result.UserBoxWidth := Result.AutoBoxWidth;
          Result.UserBoxHeight := Result.AutoBoxHeight;
        end;

      if Result.UserBoxWidth = 0 then
        Result.UserBoxWidth := 1;
    end;

  if Result.TextBoxWidth = 0 then
    Result.TextBoxWidth := Result.UserBoxWidth;

  Result.ProportionX :=  Abs(Result.Aw) / Result.TextBoxWidth;
  Result.ProportionY := Abs(Result.Oh) / Result.TextBoxWidth;

end;

class function TppRotatedText.CalcTextSize(aCanvas: TCanvas; aText: String; aFont: TFont; aAngle: Integer; aAlignment: TAlignment): TSize;
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  hSaveFont: HFont;
  hNewFont: HFont;
  lClientRect: TRect;
  lFlags: Word;
begin

  hNewFont  := 0;
  hSaveFont := 0;

  lClientRect := Rect(0, 0, 0, 0);

  try
    hNewFont  := CreateRotatedFont(aFont, aAngle);
    hSaveFont := SelectObject(aCanvas.Handle, hNewFont);

    lFlags := DT_CALCRECT or Alignments[aAlignment] or DT_EXPANDTABS or DT_NOPREFIX  or DT_TOP{ or DT_EXTERNALLEADING};

    DrawText(aCanvas.Handle, PChar(aText), Length(aText), lClientRect, lFlags);

    Result.cx := Trunc(ppToMMThousandths(lClientRect.Right,  utScreenPixels, pprtHorizontal, nil));
    Result.cy := Trunc(ppToMMThousandths(lClientRect.Bottom, utScreenPixels, pprtHorizontal, nil));

  finally
    SelectObject(aCanvas.Handle, hSaveFont);
    DeleteObject(hNewFont);

  end;

end;

class function TppRotatedText.CreateRotatedFont(aFont: TFont; aAngle: Integer): HFont;
var
  lLogFont: TLogFont;
begin

  FillChar(lLogFont, SizeOf(lLogFont), #0);

  lLogFont.lfHeight := -Round(aFont.Size * aFont.PixelsPerInch / 72);
  lLogFont.lfWidth := 0;
  lLogFont.lfEscapement := aAngle * 10;
  lLogFont.lfOrientation := aAngle * 10;
  lLogFont.lfCharSet := DEFAULT_CHARSET;

  StrPCopy(lLogFont.lfFaceName, aFont.Name);

  lLogFont.lfQuality := DEFAULT_QUALITY;
  lLogFont.lfOutPrecision := OUT_DEFAULT_PRECIS;
  lLogFont.lfClipPrecision := CLIP_DEFAULT_PRECIS;

  if (fsBold in aFont.Style) then
      lLogFont.lfWeight := FW_BOLD;
  lLogFont.lfItalic := Byte(fsItalic in aFont.Style);
  lLogFont.lfUnderline := Byte(fsUnderline in aFont.Style);
  lLogFont.lfStrikeOut := Byte(fsStrikeout in aFont.Style);

  Result := CreateFontIndirect(lLogFont);

end;

class procedure TppRotatedText.TextOutRotate(aCanvas: TCanvas; aFont: TFont; aRect: TRect; aX, aY, aAngle: Integer; aText: string);
var
  hSaveFont: HFont;
  hNewFont: HFont;
  lBrushStyle: TBrushStyle;
begin

  lBrushStyle := aCanvas.Brush.Style;
  aCanvas.Brush.Style := bsClear;

  hNewFont  := 0;
  hSaveFont := 0;

  try
    hNewFont  := CreateRotatedFont(aFont, aAngle);
    hSaveFont := SelectObject(aCanvas.Handle, hNewFont);

    {Draw text to canvas}
    aCanvas.TextRect(aRect, aX, aY, aText);

  finally
    SelectObject(aCanvas.Handle, hSaveFont);
    DeleteObject(hNewFont);
    aCanvas.Brush.Style := lBrushStyle;

  end;

end;

end.
