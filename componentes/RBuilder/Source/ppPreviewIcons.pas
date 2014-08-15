{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppPreviewIcons;

interface

uses
  Classes, Graphics, Windows,
  ppMetaBitmap;

type

  {TppPreviewIcon

   Ancestor to all of the icon drawing classes used in the Print Preview form
   and in the Preview notebook tab of the designer.}

  TppPreviewIconClass = class of TppPreviewIcon;

  TppPreviewIcon = class(TppMetaBitmap)
    public
      constructor Create; override;

      class function CreateIcon(aClass: TppPreviewIconClass): HBitmap;

  end;

  {TppAutoSearchIcon

   Draws the autosearch icon used in the Print Preview form and in the Preview
   notebook tab of the designer.}

  TppAutoSearchIcon = class(TppPreviewIcon)
    protected
      procedure Draw(aCanvas: TCanvas); override;

  end;

  {@TppDoubleGlyphIcon }

  TppDoubleGlyphIcon = class(TppPreviewIcon)
    protected
      function ButtonImageColor: TColor; virtual;
      function ButtonImageColorDisabled: TColor; virtual;

    public
      constructor Create; override;

    end;

  {TppFirstIcon

   Draws the first page icon used in the Print Preview form and in the Preview
   notebook tab of the designer.}

  TppFirstIcon = class(TppPreviewIcon)
    protected
      procedure Draw(aCanvas: TCanvas); override;

  end;

  {TppLastIcon

   Draws the last page icon used in the Print Preview form and in the Preview
   notebook tab of the designer.}

  TppLastIcon = class(TppPreviewIcon)
    protected
      procedure Draw(aCanvas: TCanvas); override;

  end;

  {TppNextIcon

   Draws the next page icon used in the Print Preview form and in the Preview
   notebook tab of the designer.}

  TppNextIcon = class(TppPreviewIcon)
    protected
      procedure Draw(aCanvas: TCanvas); override;

  end;

  {TppPriorIcon

   Draws the prior page icon used in the Print Preview form and in the Preview
   notebook tab of the designer.}

  TppPriorIcon = class(TppPreviewIcon)
    protected
      procedure Draw(aCanvas: TCanvas); override;

  end;

  {TppPrinterIcon

   Draws the printer icon used in the Print Preview form and in the Preview
   notebook tab of the designer.}

  TppPrinterIcon = class(TppPreviewIcon)
    protected
      procedure Draw(aCanvas: TCanvas); override;

  end;

  {TppZoomIcon

   Ancestor to the classes that draw the icons used to represent the zoom state
   in the Print Preview form and in the Preview notebook tab of the designer.}

  TppZoomIcon = class(TppPreviewIcon)
    protected
      procedure Draw(aCanvas: TCanvas); override;
      
  end;

  {TppZoomPageWidthIcon

   Draws the icon used to represent page width zoom in the Print Preview form
   and in the Preview notebook tab of the designer.}

  TppZoomPageWidthIcon = class(TppZoomIcon)
    protected
      procedure Draw(aCanvas: TCanvas); override;
      
  end;

  {TppZoomWholePageIcon

   Draws the icon used to represent whole page zoom in the Print Preview form
   and in the Preview notebook tab of the designer.}

  TppZoomWholePageIcon = class(TppZoomIcon)
    protected
      procedure Draw(aCanvas: TCanvas); override;

  end;

  {TppZoom100PercentIcon

   Draws the icon used to represent the state of 100% zoom in the Print Preview
   form and in the Preview notebook tab of the designer.}

  TppZoom100PercentIcon = class(TppZoomIcon)
    protected
      procedure Draw(aCanvas: TCanvas); override;
      
  end;

implementation

{@TppPreviewIcon.Create

 Initializes the background color and icon size.}

constructor TppPreviewIcon.Create;
begin

  inherited Create;

  BackgroundColor := clSilver;
  Width := 16;
  Height := 16;

end;

{@TppPreviewIcon.CreateIcon

 Draws the icon.}

class function TppPreviewIcon.CreateIcon(aClass: TppPreviewIconClass): HBitmap;
var
  lBitmap: Graphics.TBitmap;
begin
  {create a bitmap}
  lBitmap := ppGetMetaBitmap(aClass);

  {return the HBitmap}
  Result := lBitmap.Handle;

  {release the handle and then free the TBimap}
  lBitmap.ReleaseHandle;
  lBitmap.Free;
end;

{@TppAutoSearchIcon.Draw

 Draws the icon.}

procedure TppAutoSearchIcon.Draw(aCanvas: TCanvas);
begin

  ppEllipse(aCanvas, 0, 0, 11, 11, clBlack);
  ppEllipse(aCanvas, 1, 1, 10, 10, clSilver);

  {left side of handle}
  ppLine(aCanvas, 8, 11, 12, 15, clNavy);

  {right side of handle}
  ppLine(aCanvas, 11, 10, 14, 13, clNavy);

  {fill handle with color}
  ppLine(aCanvas, 10, 10, 14, 14, clNavy);
  ppLine(aCanvas, 9, 10, 13, 14, clNavy);
  ppLine(aCanvas, 12, 15, 15, 12, clNavy);
  ppLine(aCanvas, 13, 15, 15, 14, clNavy);

  {handle highlight}
  ppLine(aCanvas, 9, 11, 13, 15, clSilver);

  {lense shading}
  aCanvas.Pixels[2, 2] := clGray;
  aCanvas.Pixels[2, 9] := clGray;
  aCanvas.Pixels[9, 2] := clGray;

  {shade top of handle}
  ppLine(aCanvas, 8, 10, 10, 8, clGray);

  {highlight top of handle}
  ppLine(aCanvas, 7, 10, 10, 7, clWhite);

  {highlight lense}
  ppLine(aCanvas, 2, 3, 2, 5, clWhite);
  ppLine(aCanvas, 3, 2, 5, 2, clWhite);
  aCanvas.Pixels[3, 3] := clWhite;

  {shade right edge of handle}
  aCanvas.Pixels[11, 9] := clGray;

  {widen lense}
  aCanvas.Pixels[1, 4] := clSilver;
  aCanvas.Pixels[1, 7] := clSilver;
  aCanvas.Pixels[4, 1] := clSilver;
  aCanvas.Pixels[7, 1] := clSilver;
  aCanvas.Pixels[10, 4] := clSilver;
  aCanvas.Pixels[10, 7] := clSilver;
  aCanvas.Pixels[4, 10] := clSilver;

  {widen frame}
  aCanvas.Pixels[0, 4] := clBlack;
  aCanvas.Pixels[0, 7] := clBlack;
  aCanvas.Pixels[4, 0] := clBlack;
  aCanvas.Pixels[7, 0] := clBlack;
  aCanvas.Pixels[11, 4] := clBlack;
  aCanvas.Pixels[11, 7] := clBlack;
  aCanvas.Pixels[4, 11] := clBlack;
  aCanvas.Pixels[7, 11] := clBlack;

end;

{@TppPrinterIcon.Draw

 Draws the icon.}

procedure TppPrinterIcon.Draw(aCanvas: TCanvas);
begin

  ppFillRect(aCanvas, 0, 9, 12, 12, clSilver);
  ppLine(aCanvas, 0, 9, 12, 9, clBlack);
  ppLine(aCanvas, 0, 12, 12, 12, clBlack);
  ppLine(aCanvas, 0, 9, 0, 12, clBlack);
  ppLine(aCanvas, 12, 9, 12, 12, clBlack);

  {top of paper}
  ppLine(aCanvas, 5, 1, 13, 1, clBlack);

  {paper lines}
  ppLine(aCanvas, 6, 3, 10, 3, clBlack);
  ppLine(aCanvas, 5, 5, 9, 5, clBlack);

  {left side of paper}
  ppLine(aCanvas, 4, 2, 4, 3, clBlack);
  ppLine(aCanvas, 3, 4, 3, 5, clBlack);

  aCanvas.Pixels[2, 6] := clBlack;

  {right side of paper}
  ppLine(aCanvas, 13, 1, 13, 2, clBlack);
  ppLine(aCanvas, 12, 3, 12, 4, clBlack);
  ppLine(aCanvas, 11, 5, 14, 5, clBlack);
  ppLine(aCanvas, 11, 5, 11, 6, clBlack);

  {top of printer}
  ppLine(aCanvas, 1, 7, 10, 7, clBlack);

  {bottom of printer}
  ppLine(aCanvas, 2, 14, 12, 14, clBlack);

  {left side of printer}
  aCanvas.Pixels[0, 8] := clBlack;
  aCanvas.Pixels[1, 13] := clBlack;

  {right side of printer}
  ppLine(aCanvas, 12, 14, 14, 12, clBlack);
  ppLine(aCanvas, 11, 13, 15, 9, clBlack);
  ppLine(aCanvas, 14, 10, 14, 12, clBlack);
  ppLine(aCanvas, 15, 6, 15, 9, clBlack);
  ppLine(aCanvas, 12, 9, 15, 6, clBlack);
  ppLine(aCanvas, 11, 8, 14, 5, clBlack);

  {color panels}
  ppLine(aCanvas, 1, 8, 10, 8, clSilver);
  ppLine(aCanvas, 2, 13, 10, 13, clSilver);

  aCanvas.Pixels[12, 13] := clSilver;
  aCanvas.Pixels[13, 12] := clSilver;
  aCanvas.Pixels[14, 6] := clSilver;
  aCanvas.Pixels[11, 7] := clSilver;

  ppLine(aCanvas, 13, 9, 13, 10, clSilver);
  ppLine(aCanvas, 14, 8, 14, 9, clSilver);
  ppLine(aCanvas, 12, 8, 14, 6, clSilver);

  aCanvas.Pixels[12, 6] := clSilver;

  ppLine(aCanvas, 7, 10, 9, 10, clGray);
  ppLine(aCanvas, 7, 11, 9, 11, clYellow);

  {make paper white}
  ppFloodFill(aCanvas, 5, 2, clWhite);

end;

{@TppZoomIcon.Draw

 Draws the icon.}

procedure TppZoomIcon.Draw(aCanvas: TCanvas);
begin

  ppFrameRect(aCanvas, 2, 2, 13, 13, clBlack);
  ppFillRect(aCanvas, 3, 3, 12, 12, clTeal);

  ppLine(aCanvas, 3, 4, 5, 2, clGray);
  ppLine(aCanvas, 3, 6, 7, 2, clGray);
  ppLine(aCanvas, 3, 8, 9, 2, clGray);
  ppLine(aCanvas, 3, 10, 11, 2, clGray);
  ppLine(aCanvas, 3, 12, 13, 2, clGray);
  ppLine(aCanvas, 5, 12, 13, 4, clGray);
  ppLine(aCanvas, 7, 12, 13, 6, clGray);
  ppLine(aCanvas, 9, 12, 13, 8, clGray);
  ppLine(aCanvas, 11, 12, 13, 10, clGray);

end;

{@TppZoomPageWidthIcon.Draw

 Draws the icon.}

procedure TppZoomPageWidthIcon.Draw(aCanvas: TCanvas);
begin

  inherited Draw(aCanvas);

  ppFrameRect(aCanvas, 4, 5, 11, 13, clBlack);
  ppFillRect(aCanvas, 5, 6, 10, 12, clWhite);

  ppLine(aCanvas, 6, 7, 7, 7, clBlack);
  ppLine(aCanvas, 6, 9, 7, 9, clBlack);
  ppLine(aCanvas, 6, 11, 7, 11, clBlack);

  aCanvas.Pixels[9, 7] := clBlack;
  aCanvas.Pixels[9, 9] := clBlack;
  aCanvas.Pixels[9, 11] := clBlack;

end;

{@TppZoomWholePageIcon.Draw

 Draws the icon.}

procedure TppZoomWholePageIcon.Draw(aCanvas: TCanvas);
begin

  inherited Draw(aCanvas);

  ppFrameRect(aCanvas, 5, 4, 10, 11, clBlack);
  ppFillRect(aCanvas, 6, 5, 9, 10, clWhite);

  ppLine(aCanvas, 7, 6, 8, 6, clBlack);
  ppLine(aCanvas, 7, 8, 8, 8, clBlack);

end;

{@TppZoom100PercentIcon.Draw

 Draws the icon.}

procedure TppZoom100PercentIcon.Draw(aCanvas: TCanvas);
begin

  inherited Draw(aCanvas);

  ppFrameRect(aCanvas, 5, 5, 13, 13, clBlack);
  ppFillRect(aCanvas, 6, 6, 12, 12, clWhite);

  ppFillRect(aCanvas, 7, 7, 8, 8, clBlack);
  ppFillRect(aCanvas, 7, 10, 8, 11, clBlack);

  ppFillRect(aCanvas, 10, 7, 12, 8, clBlack);
  ppFillRect(aCanvas, 10, 10, 12, 11, clBlack);

end;
 
{@TppDoubleGlyphIcon.Create }

constructor TppDoubleGlyphIcon.Create;
begin

  inherited Create;

  BackgroundColor := clBtnFace;
  Width := 32;
  Height := 16;

end;

{@TppDoubleGlyphIcon.ButtonImageColor }

function TppDoubleGlyphIcon.ButtonImageColor: TColor;
begin
  Result := clBlack;
end;

{@TppDoubleGlyphIcon.ButtonImageColorDisabled }

function TppDoubleGlyphIcon.ButtonImageColorDisabled: TColor;
begin
  Result := clGray;
end;

{@TppFirstIcon.Draw

 Draws the icon.}

procedure TppFirstIcon.Draw(aCanvas: TCanvas);
var
  laPolygon: array[0..3] of TPoint;
begin

  aCanvas.Brush.Color := clBlack;
  aCanvas.FillRect(Rect(3,1,5,14));

  laPolygon[0] := Point(7,7);
  laPolygon[1] := Point(12,2);
  laPolygon[2] := Point(12,13);
  laPolygon[3] := Point(7,8);

  aCanvas.Polygon(laPolygon);

end;

{@TppLastIcon.Draw

 Draws the icon.}

procedure TppLastIcon.Draw(aCanvas: TCanvas);
var
  laPolygon: array[0..3] of TPoint;
begin

  aCanvas.Brush.Color := clBlack;
  aCanvas.FillRect(Rect(10,1,12,14));

  laPolygon[0] := Point(2,2);
  laPolygon[1] := Point(7,7);
  laPolygon[2] := Point(7,8);
  laPolygon[3] := Point(2,13);

  aCanvas.Polygon(laPolygon);
end;

{@TppNextIcon.Draw

 Draws the icon.}

procedure TppNextIcon.Draw(aCanvas: TCanvas);
var
  laPolygon: array[0..3] of TPoint;
begin

  aCanvas.Brush.Color := clBlack;
  laPolygon[0] := Point(5,2);
  laPolygon[1] := Point(10,7);
  laPolygon[2] := Point(10,8);
  laPolygon[3] := Point(5,13);

  aCanvas.Polygon(laPolygon);


end;

{@TppPriorIcon.Draw

 Draws the icon.}

procedure TppPriorIcon.Draw(aCanvas: TCanvas);
var
  laPolygon: array[0..3] of TPoint;
begin

  aCanvas.Brush.Color := clBlack;
  laPolygon[0] := Point(4,7);
  laPolygon[1] := Point(9,2);
  laPolygon[2] := Point(9,13);
  laPolygon[3] := Point(4,8);

  aCanvas.Polygon(laPolygon);

end;

end.
