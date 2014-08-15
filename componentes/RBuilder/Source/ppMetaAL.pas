{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppMetaAL;

interface

{$I ppIfDef.pas}

uses
  Classes, Graphics, SysUtils, ppMetaBitmap;

type

  {@TppAutoLayoutBitmap }
  TppAutoLayoutBitmap = class(TppMetaBitmap)
    private
      FFieldFont: TFont;
      FFieldGrid: Boolean;
      FFields: Boolean;
      FLabels: Boolean;
      FLabelFont: TFont;
      FLabelGrid: Boolean;
      FTabular: Boolean;

      procedure DrawTabular(aCanvas: TCanvas);
      procedure DrawVertical(aCanvas: TCanvas);

      procedure SetLabelFont(aFont: TFont);
      procedure SetFieldFont(aFont: TFont);

    protected
      procedure Draw(aCanvas: TCanvas); override;
    public
      constructor Create; override;
      destructor Destroy; override;

      property FieldFont: TFont read FFieldFont write SetFieldFont;
      property FieldGrid: Boolean read FFieldGrid write FFieldGrid;
      property Fields: Boolean read FFields write FFields;
      property LabelFont: TFont read FLabelFont write SetLabelFont;
      property LabelGrid: Boolean read FLabelGrid write FLabelGrid;
      property Labels: Boolean read FLabels write FLabels;
      property Tabular: Boolean read FTabular write FTabular;

  end; {class, TppAutoLayoutBitmap}

implementation

{******************************************************************************
 *
 **  A U T O   L A Y O U T   B I T M A P
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppAutoLayoutBitmap.Create }

constructor TppAutoLayoutBitmap.Create;
begin

  inherited Create;

  BackgroundColor := clWhite;

  Height := 145;
  Width := 210;

  FFieldFont := TFont.Create;
  FFieldGrid :=  False;
  FFields := True;

  FLabelFont := TFont.Create;
  FLabelGrid := False;
  FLabels := True;

  FTabular := True;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppAutoLayoutBitmap.Destroy }

destructor TppAutoLayoutBitmap.Destroy;
begin

  FLabelFont.Free;
  FFieldFont.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppAutoLayoutBitmap.SetLabelFont }

procedure TppAutoLayoutBitmap.SetLabelFont(aFont: TFont);
begin
  FLabelFont.Assign(aFont);
end; {procedure, SetLabelFont}

{------------------------------------------------------------------------------}
{ TppAutoLayoutBitmap.SetFieldFont}

procedure TppAutoLayoutBitmap.SetFieldFont(aFont: TFont);
begin
  FFieldFont.Assign(aFont);
end; {procedure, SetFieldFont}

{------------------------------------------------------------------------------}
{ TppAutoLayoutBitmap.Draw }

procedure TppAutoLayoutBitmap.Draw(aCanvas: TCanvas);
begin
  if FTabular then
    DrawTabular(aCanvas)
  else
    DrawVertical(aCanvas);
end; {procedure, Draw}

{------------------------------------------------------------------------------}
{ TppAutoLayoutBitmap.DrawTabular }

procedure TppAutoLayoutBitmap.DrawTabular(aCanvas: TCanvas);
var
  liZoomHeight: Integer;
  liOutlineHeight: Integer;
  liOutlineTop: Integer;
begin

  if (FLabels and FFields) then
    begin
      liZoomHeight := 70;
      liOutlineHeight := 25;
      liOutlineTop := 91;
    end
  else if (FLabels) then
    begin
      liZoomHeight := 35;
      liOutlineHeight := 12;
      liOutlineTop := 91;
    end
  else
    begin
      liZoomHeight := 35;
      liOutlineHeight := 12;
      liOutlineTop := 103;
    end;

  {zoom box with shadow}
  ppFillRect(aCanvas, 10, 8, 160, 9 + liZoomHeight, clBlack);
  ppFrameRect(aCanvas, 5, 6, 158, 6 + liZoomHeight, clBlack);
  ppFillRect(aCanvas, 6, 7, 157, 5 + liZoomHeight, clWhite);

  {outline box}
  aCanvas.Brush.Color := clWhite;
  aCanvas.Pen.Color := clSilver;
  aCanvas.Pen.Style := psDot;
  aCanvas.Polygon([ Point(34, liOutlineTop),
                    Point(83, liOutlineTop),
                    Point(83, liOutlineTop + liOutlineHeight),
                    Point(34, liOutlineTop + liOutlineHeight),
                    Point(34, liOutlineTop)]);

  aCanvas.Pen.Style := psSolid;

  {set background color for fonts}
  aCanvas.Brush.Color := clWhite;

  aCanvas.Font.Name := 'SMALL FONTS';
  aCanvas.Font.Color := clBlack;
  aCanvas.Font.Size := 5;
  aCanvas.Font.Style := [fsBold];

  {labels}
  if (FLabels) then
    begin
      ppTextOut(aCanvas, 40, 96, 'Company');

      aCanvas.Font.Color := clSilver;

      ppTextOut(aCanvas, 87, 96, 'Region');
      ppTextOut(aCanvas, 128, 96, 'City');
      ppTextOut(aCanvas, 163, 96, 'State');

      if (FLabelGrid) then
        begin
          {horizontal lines}
          ppLine(aCanvas, 38, 93, 163, 93, clSilver);

          {vertical lines}
          ppLine(aCanvas, 37, 93, 37, 104, clSilver);
          ppLine(aCanvas, 84, 93, 84, 104, clSilver);
          ppLine(aCanvas, 125, 93, 125, 104, clSilver);
          ppLine(aCanvas, 160, 93, 160, 104, clSilver);
        end;

    end;

  if (FFields) then
    begin
      aCanvas.Font.Style := [];

      aCanvas.Font.Color := clBlack;

      ppTextOut(aCanvas, 40, 108, 'Action Club');

      aCanvas.Font.Color := clSilver;

      {first column}
      ppTextOut(aCanvas, 40, 119, 'Action Club');
      ppTextOut(aCanvas, 40, 129, 'Action Club');

      {second column}
      ppTextOut(aCanvas, 87, 108, 'Southeast');
      ppTextOut(aCanvas, 87, 119, 'Southeast');
      ppTextOut(aCanvas, 87, 130, 'Southwest');

      {third column}
      ppTextOut(aCanvas, 128, 109, 'Sarasota');
      ppTextOut(aCanvas, 128, 119, 'Tampa');
      ppTextOut(aCanvas, 128, 129, 'San Jose');

      {fourth column}
      ppTextOut(aCanvas, 163, 109, 'FL');
      ppTextOut(aCanvas, 163, 119, 'FL');
      ppTextOut(aCanvas, 163, 129, 'CA');

      if (FFieldGrid) then
        begin
          {horizontal lines}
          ppLine(aCanvas, 38, 104, 163, 104, clSilver);
          ppLine(aCanvas, 38, 115, 163, 115, clSilver);
          ppLine(aCanvas, 38, 126, 163, 126, clSilver);
          ppLine(aCanvas, 38, 137, 163, 137, clSilver);

          {vertical lines}
          ppLine(aCanvas, 37, 104, 37, 137, clSilver);
          ppLine(aCanvas, 84, 104, 84, 137, clSilver);
          ppLine(aCanvas, 125, 104, 125, 137, clSilver);
          ppLine(aCanvas, 160, 104, 160, 137, clSilver);
        end;

    end;

  {lines to zoom box}
  ppLine(aCanvas, 34, liOutlineTop, 29, 9 + liZoomHeight, clSilver);
  ppLine(aCanvas, 34, liOutlineTop + liOutlineHeight, 5, 6 + liZoomHeight, clSilver);
  ppLine(aCanvas, 83, liOutlineTop, 91, 9 + liZoomHeight, clSilver);
  ppLine(aCanvas, 83, liOutlineTop + liOutlineHeight, 158, 6 + liZoomHeight, clSilver);

  {sample text}
  if (FLabels) and (FFields) then
    begin
      aCanvas.Font := FLabelFont;

      ppTextRect(aCanvas, 14, 14, 150, 30, 'Company');

      aCanvas.Font := FFieldFont;

      ppTextRect(aCanvas, 14, 45, 150, 30, 'Action Club');
    end

  else if (FLabels) then
    begin
      aCanvas.Font := FLabelFont;

      ppTextRect(aCanvas, 14, 14, 150, 30, 'Company');
    end

  else
    begin
      aCanvas.Font := FFieldFont;

      ppTextRect(aCanvas, 14, 14, 150, 30, 'Action Club');
    end;

end; {procedure, DrawTabular}

{------------------------------------------------------------------------------}
{ TppAutoLayoutBitmap.DrawVertical }

procedure TppAutoLayoutBitmap.DrawVertical(aCanvas: TCanvas);
var
  liZoomHeight: Integer;
  liOutlineWidth: Integer;
  liOutlineLeft: Integer;
begin

  if (FLabels and FFields) then
    begin
      liZoomHeight := 70;
      liOutlineWidth := 100;
      liOutlineLeft := 34;
    end
  else if (FLabels) then
    begin
      liZoomHeight := 35;
      liOutlineWidth := 50;
      liOutlineLeft := 34;
    end
  else
    begin
      liZoomHeight := 35;
      liOutlineWidth := 50;
      liOutlineLeft := 84;
    end;

  {zoom box with shadow}
  ppFillRect(aCanvas, 10, 8, 160, 9 + liZoomHeight, clBlack);
  ppFrameRect(aCanvas, 5, 6, 158, 6 + liZoomHeight, clBlack);
  ppFillRect(aCanvas, 6, 7, 157, 5 + liZoomHeight, clWhite);

  {outline box}
  aCanvas.Brush.Color := clWhite;
  aCanvas.Pen.Color := clSilver;
  aCanvas.Pen.Style := psDot;
  aCanvas.Polygon([ Point(liOutlineLeft, 91),
                    Point(liOutlineLeft + liOutlineWidth, 91),
                    Point(liOutlineLeft + liOutlineWidth, 103),
                    Point(liOutlineLeft, 103),
                    Point(liOutlineLeft, 91)]);

  aCanvas.Pen.Style := psSolid;

  {set background color for fonts}
  aCanvas.Brush.Color := clWhite;

  aCanvas.Font.Name := 'SMALL FONTS';
  aCanvas.Font.Color := clBlack;
  aCanvas.Font.Size := 5;
  aCanvas.Font.Style := [fsBold];

  {labels}
  if (FLabels) then
    begin
      ppTextOut(aCanvas, 40, 96, 'Company');

      aCanvas.Font.Color := clSilver;

      ppTextOut(aCanvas, 40, 107, 'Region');
      ppTextOut(aCanvas, 40, 118, 'City');
      ppTextOut(aCanvas, 40, 129, 'State');

      if (FLabelGrid) then
        begin
          {horizontal lines}
          ppLine(aCanvas, 36, 93, 86, 93, clSilver);
          ppLine(aCanvas, 36, 104, 86, 104, clSilver);
          ppLine(aCanvas, 36, 115, 86, 115, clSilver);
          ppLine(aCanvas, 36, 126, 86, 126, clSilver);
          ppLine(aCanvas, 36, 137, 86, 137, clSilver);

          {vertical lines}
          ppLine(aCanvas, 36, 93, 36, 137, clSilver);
          ppLine(aCanvas, 86, 93, 86, 137, clSilver);
        end;
    end;

  if (FFields) then
    begin
      aCanvas.Font.Style := [];

      aCanvas.Font.Color := clBlack;

      ppTextOut(aCanvas, 90, 96, 'Action Club');

      aCanvas.Font.Color := clSilver;

      ppTextOut(aCanvas, 90, 107, 'Southeast');
      ppTextOut(aCanvas, 90, 118, 'Sarasota');
      ppTextOut(aCanvas, 90, 129, 'FL');

      if (FFieldGrid) then
        begin
          {horizontal lines}
          ppLine(aCanvas, 86, 93, 145, 93, clSilver);
          ppLine(aCanvas, 86, 104, 145, 104, clSilver);
          ppLine(aCanvas, 86, 115, 145, 115, clSilver);
          ppLine(aCanvas, 86, 126, 145, 126, clSilver);
          ppLine(aCanvas, 86, 137, 145, 137, clSilver);

          {vertical lines}
          ppLine(aCanvas, 86, 93, 86, 137, clSilver);
          ppLine(aCanvas, 145, 93, 145, 137, clSilver);
        end;
    end;

  {lines to zoom box}
  ppLine(aCanvas, liOutlineLeft, 91, 29, 9 + liZoomHeight, clSilver);
  ppLine(aCanvas, liOutlineLeft, 103, 5, 6 + liZoomHeight, clSilver);
  ppLine(aCanvas, liOutlineLeft + liOutlineWidth, 91, 131, 9 + liZoomHeight, clSilver);
  ppLine(aCanvas, liOutlineLeft + liOutlineWidth, 103, 158, 6 + liZoomHeight, clSilver);

  {sample text}
  if (FLabels) and (FFields) then
    begin
      aCanvas.Font := FLabelFont;

      ppTextRect(aCanvas, 14, 14, 150, 30, 'Company');

      aCanvas.Font := FFieldFont;

      ppTextRect(aCanvas, 14, 45, 150, 30, 'Action Club');
    end

  else if (FLabels) then
    begin
      aCanvas.Font := FLabelFont;

      ppTextRect(aCanvas, 14, 14, 150, 30, 'Company');
    end

  else
    begin
      aCanvas.Font := FFieldFont;

      ppTextRect(aCanvas, 14, 14, 150, 30, 'Action Club');
    end;

end; {procedure, DrawVertical}



end.






