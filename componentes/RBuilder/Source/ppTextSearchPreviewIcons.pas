{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppTextSearchPreviewIcons;

interface

uses
  Classes, Graphics, Windows,
  ppPreviewIcons;

type

  {@TppTextSearchIcon

   Draws the binoculars icon shown in the Print Preview form.}

  TppTextSearchIcon = class(TppPreviewIcon)
    protected
      procedure Draw(aCanvas: TCanvas); override;

  end;

  {@TppFirstSearchOccurrenceIcon

   Draws the first SearchOccurrence icon used in the Search Preview form .}

  TppFirstSearchOccurrenceIcon = class(TppFirstIcon)
    protected
      function ButtonImageColor: TColor; //override;
    end;

  {@TppLastSearchOccurrenceIcon

   Draws the last SearchOccurrence icon used in the Search Preview form.}

  TppLastSearchOccurrenceIcon = class(TppLastIcon)
    protected
      function ButtonImageColor: TColor; //override;
    end;

  {@TppNextSearchOccurrenceIcon

   Draws the next SearchOccurrence icon used in the Search Preview form.}

  TppNextSearchOccurrenceIcon = class(TppNextIcon)
    protected
      function ButtonImageColor: TColor; //override;
    end;

  {@TppPriorSearchOccurrenceIcon

   Draws the prior SearchOccurrence icon used in the Search Preview form.}

  TppPriorSearchOccurrenceIcon = class(TppPriorIcon)
    protected
      function ButtonImageColor: TColor; //override;
    end;


implementation

uses
  ppMetaBitmap;

{@TppTextSearchIcon.Draw

 Draws the icon.}

procedure TppTextSearchIcon.Draw(aCanvas: TCanvas);
begin

{ENABLED}
  {black parts}
  ppLine(aCanvas, 3, 2, 5, 2, clBlack);
  ppLine(aCanvas, 3, 4, 5, 4, clBlack);
  aCanvas.Pixels[3, 3] := clBlack;
  aCanvas.Pixels[5, 3] := clBlack;

  ppLine(aCanvas, 9, 2, 11, 2, clBlack);
  ppLine(aCanvas, 9, 4, 11, 4, clBlack);
  aCanvas.Pixels[9, 3] := clBlack;
  aCanvas.Pixels[11, 3] := clBlack;

  ppFillRect(aCanvas, 2, 5, 6, 6, clBlack);
  ppFillRect(aCanvas, 8, 5, 12, 6, clBlack);

  ppLine(aCanvas, 1, 7, 13, 7, clBlack);

  ppFillRect(aCanvas, 0, 8, 14, 11, clBlack);
  ppFillRect(aCanvas, 0, 12, 4, 14, clBlack);
  ppFillRect(aCanvas, 10, 12, 14, 14, clBlack);

  {highlight details and "shading"}
  aCanvas.Pixels[4, 3] := clSilver;
  aCanvas.Pixels[10, 3] := clSilver;
  aCanvas.Pixels[3, 6] := clSilver;
  aCanvas.Pixels[9, 6] := clSilver;
  aCanvas.Pixels[7, 11] := clBtnFace;

  ppLine(aCanvas, 2, 8, 2, 10, clSilver);
  ppLine(aCanvas, 6, 8, 6, 9, clWhite);
  ppLine(aCanvas, 9, 8, 9, 10, clSilver);
  ppLine(aCanvas, 1, 12, 1, 13, clSilver);
  ppLine(aCanvas, 11, 12, 11, 13, clSilver);

  Exit;
  
{DISABLED}

  {black parts}
  ppLine(aCanvas, 19, 2, 21, 2, clGray);
  ppLine(aCanvas, 19, 4, 21, 4, clGray);
  aCanvas.Pixels[19, 3] := clGray;
  aCanvas.Pixels[21, 3] := clGray;

  ppLine(aCanvas, 25, 2, 27, 2, clGray);
  ppLine(aCanvas, 25, 4, 27, 4, clGray);
  aCanvas.Pixels[25, 3] := clGray;
  aCanvas.Pixels[27, 3] := clGray;

  ppFillRect(aCanvas, 18, 5, 22, 6, clGray);
  ppFillRect(aCanvas, 24, 5, 28, 6, clGray);

  ppLine(aCanvas, 17, 7, 29, 7, clGray);

  ppFillRect(aCanvas, 16, 8, 30, 11, clGray);
  ppFillRect(aCanvas, 16, 12, 20, 14, clGray);
  ppFillRect(aCanvas, 26, 12, 30, 14, clGray);

  {highlight details and "shading"}
  aCanvas.Pixels[20, 3] := clSilver;
  aCanvas.Pixels[26, 3] := clSilver;
  aCanvas.Pixels[19, 6] := clSilver;
  aCanvas.Pixels[25, 6] := clSilver;
  aCanvas.Pixels[23, 11] := clBtnFace;

  ppLine(aCanvas, 18, 8, 18, 10, clSilver);
  ppLine(aCanvas, 22, 8, 22, 9, clYellow);
  ppLine(aCanvas, 25, 8, 25, 10, clSilver);
  ppLine(aCanvas, 17, 12, 17, 13, clSilver);
  ppLine(aCanvas, 27, 12, 27, 13, clSilver);

end;

{@TppFirstSearchOccurrenceIcon.ButtonImageColor }

function TppFirstSearchOccurrenceIcon.ButtonImageColor: TColor;
begin
  Result := clMaroon;
end;

{@TppLastSearchOccurrenceIcon.ButtonImageColor }

function TppLastSearchOccurrenceIcon.ButtonImageColor: TColor;
begin
  Result := clMaroon;
end;

{@TppNextSearchOccurrenceIcon.ButtonImageColor }

function TppNextSearchOccurrenceIcon.ButtonImageColor: TColor;
begin
  Result := clMaroon;
end;

{@TppPriorSearchOccurrenceIcon.ButtonImageColor }

function TppPriorSearchOccurrenceIcon.ButtonImageColor: TColor;
begin
  Result := clMaroon;
end;

end.
