{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppMetaBitmap;

interface

{$I ppIfDef.pas}

uses
  Classes, Graphics, SysUtils, TypInfo;

type

  {@TppMetaBitmap

     Abstract ancestor class for meta bitmaps. Meta bitmaps are classes that
     contain code to generate a specific bitmap image.}

  TppMetaBitmap = class
    private
      FBitmap: TBitmap;
      FBackgroundColor: TColor;
      FHeight: Integer;
      FWidth: Integer;

    protected
      procedure Draw(aCanvas: TCanvas); virtual; abstract;

    public
      constructor Create; virtual;
      destructor Destroy; override;

      procedure RenderBitmap(aBitmap: TBitmap);

      property BackgroundColor: TColor read FBackgroundColor write FBackgroundColor;
      property Height: Integer read FHeight write FHeight;
      property Width: Integer read FWidth write FWidth;

  end; {class, TppMetaBitmap}

  {@TppWizardBitmap }
  TppWizardBitmap = class(TppMetaBitmap)
    protected
      procedure DrawDataBox(aCanvas: TCanvas; aX, aY: Integer; aCol1, aCol2, aCol3: Boolean);
      procedure DrawFunnel(aCanvas: TCanvas; aX, aY: Integer);
      procedure DrawMainDataBox(aCanvas: TCanvas; aX, aY: Integer; aColumnCount, aRowCount: Integer;
                                aColumnsSelected: array of Boolean);
      procedure DrawSortBox(aCanvas: TCanvas; aX, aY: Integer; aRowCount: Integer; aSorted: Boolean;
                            aRowsSelected: Boolean);

  end; {class, TppWizardBitmap}

  TppMetaBitmapClass = class of TppMetaBitmap;


  {main function which returns rendered bitmaps}
  function ppGetMetaBitmap(aClass: TppMetaBitmapClass): TBitmap;
  procedure ppDrawMetaBitmap(aClass: TppMetaBitmapClass; aBitmap: TBitmap);


  {drawing routines}
  procedure ppLine(aCanvas: TCanvas; aX1, aY1, aX2, aY2: Integer; aColor: TColor);
  procedure ppFillRect(aCanvas: TCanvas; aX1, aY1, aX2, aY2: Integer; aColor: TColor);
  procedure ppFrameRect(aCanvas: TCanvas; aX1, aY1, aX2, aY2: Integer; aColor: TColor);
  procedure ppEllipse(aCanvas: TCanvas; aX1, aY1, aX2, aY2: Integer; aColor: TColor);
  procedure ppFloodFill(aCanvas: TCanvas; aX, aY: Integer; aColor: TColor);
  procedure ppTextOut(aCanvas: TCanvas; aX, aY: Integer; const aText: String);
  procedure ppTextRect(aCanvas: TCanvas; aX, aY, aWidthMax, aHeightMax: Integer; const aText: String);
  procedure ppTextOutJustified(aCanvas: TCanvas; aX, aY: Integer; const aText: String; aAlignment: TAlignment);

implementation

{------------------------------------------------------------------------------}
{ ppGetMetaBitmap }

function ppGetMetaBitmap(aClass: TppMetaBitmapClass): TBitmap;
var
  lMetaBitmap: TppMetaBitmap;
  lBitmap: TBitmap;
begin

  lMetaBitmap := aClass.Create;

  lBitmap := TBitmap.Create;

  lMetaBitmap.RenderBitmap(lBitmap);

  lMetaBitmap.Free;

  Result := lBitmap;

end; {function, ppGetMetaBitmap}


{------------------------------------------------------------------------------}
{ ppDrawMetaBitmap }

procedure ppDrawMetaBitmap(aClass: TppMetaBitmapClass; aBitmap: TBitmap);
var
  lMetaBitmap: TppMetaBitmap;

begin

  lMetaBitmap := aClass.Create;

  lMetaBitmap.RenderBitmap(aBitmap);

  lMetaBitmap.Free;

end; {procedure, ppDrawMetaBitmap}

{******************************************************************************
 *
 **  D R A W I N G   R O U T I N E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ ppLine }

procedure ppLine(aCanvas: TCanvas; aX1, aY1, aX2, aY2: Integer; aColor: TColor);
var
  liX2: Integer;
  liY2: Integer;
begin

  aCanvas.Pen.Color := aColor;

  if (aX1 = aX2) then
    liY2 := aY2 + 1
  else
    liY2 := aY2;

  if (aY1 = aY2) then
    liX2 := aX2 + 1
  else
    liX2 := aX2;

  aCanvas.MoveTo(aX1, aY1);
  aCanvas.LineTo(liX2, liY2);

end; {procedure, ppLine}

{------------------------------------------------------------------------------}
{ ppFillRect }

procedure ppFillRect(aCanvas: TCanvas; aX1, aY1, aX2, aY2: Integer; aColor: TColor);
begin
  aCanvas.Brush.Color := aColor;
  aCanvas.Pen.Color := aColor;

  aCanvas.FillRect(Rect(aX1, aY1, aX2 + 1, aY2 + 1));

end; {procedure, ppFillRect}

{------------------------------------------------------------------------------}
{ ppFrameRect }

procedure ppFrameRect(aCanvas: TCanvas; aX1, aY1, aX2, aY2: Integer; aColor: TColor);
begin
  aCanvas.Brush.Color := aColor;
  aCanvas.Pen.Color := aColor;

  aCanvas.FrameRect(Rect(aX1, aY1, aX2 + 1, aY2 + 1));
end; {procedure, ppFrameRect}

{------------------------------------------------------------------------------}
{ ppEllipse }

procedure ppEllipse(aCanvas: TCanvas; aX1, aY1, aX2, aY2: Integer; aColor: TColor);
begin
  aCanvas.Brush.Color := aColor;
  aCanvas.Pen.Color := aColor;

  aCanvas.Ellipse(aX1, aY1, aX2 + 1, aY2 + 1);
end; {procedure, ppEllipse}

{------------------------------------------------------------------------------}
{ ppFloodFill }

procedure ppFloodFill(aCanvas: TCanvas; aX, aY: Integer; aColor: TColor);
begin
  aCanvas.Brush.Color := aColor;
  aCanvas.Pen.Color := aColor;

  aCanvas.FloodFill(aX, aY, aCanvas.Pixels[aX,aY], fsSurface);
end; {procedure, ppFloodFill}

{------------------------------------------------------------------------------}
{ ppTextOut }

procedure ppTextOut(aCanvas: TCanvas; aX, aY: Integer; const aText: String);
begin
  {if (aCanvas.Font.Color = clWhite) then
    aCanvas.Brush.Color := clBlack
  else
    aCanvas.Brush.Color := clWhite;}

  aCanvas.TextOut(aX - 1, aY - 2, aText);
end; {procedure, ppTextOut}

{------------------------------------------------------------------------------}
{ ppTextRect }

procedure ppTextRect(aCanvas: TCanvas; aX, aY, aWidthMax, aHeightMax: Integer; const aText: String);
begin

  if (aCanvas.Font.Color = clWhite) then
    aCanvas.Brush.Color := clBlack
  else
    aCanvas.Brush.Color := clWhite;

  if (aCanvas.TextWidth(aText) > aWidthMax) or (aCanvas.TextHeight(aText) > aHeightMax) then
    begin
      aCanvas.TextRect(Rect(aX, aY, aX + aWidthMax, aY + aHeightMax), aX, aY, aText);
    end
  else
    ppTextOut(aCanvas, aX, aY, aText);
    
end; {procedure, ppTextRect}

{------------------------------------------------------------------------------}
{ ppTextOutJustified }

procedure ppTextOutJustified(aCanvas: TCanvas; aX, aY: Integer; const aText: String; aAlignment: TAlignment);
var
  liWidth: Integer;
begin

  case aAlignment of
  
    taLeftJustify:
      ppTextOut(aCanvas, aX, aY, aText);

    taRightJustify:
      begin
        liWidth := aCanvas.TextWidth(aText);
        aX := (aX - liWidth) + 2;
        
        aCanvas.TextOut(aX - 1, aY - 2, aText);
      end;
  end;
  
end; {procedure, ppTextOutJustified}

{******************************************************************************
 *
 **  M E T A   B I T M A P
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppMetaBitmap.Create }

constructor TppMetaBitmap.Create;
begin
  inherited Create;

  FBitmap := nil;
  FHeight := 0;
  FWidth := 0;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppMetaBitmap.Destroy }

destructor TppMetaBitmap.Destroy;
begin

  FBitmap.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppMetaBitmap.RenderBitmap }

procedure TppMetaBitmap.RenderBitmap(aBitmap: TBitmap);
begin

  if (aBitmap = nil) then Exit;

  aBitmap.Height := FHeight;
  aBitmap.Width := FWidth;

  {draw background}
  aBitmap.Canvas.Brush.Color := FBackgroundColor;
  aBitmap.Canvas.FillRect(Rect(0, 0, FWidth, FHeight));

  Draw(aBitmap.Canvas);

end; {procedure, RenderBitmap}

{******************************************************************************
 *
 **  W I Z A R D   B I T M A P
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppWizardBitmap.DrawFunnel }

procedure TppWizardBitmap.DrawFunnel(aCanvas: TCanvas; aX, aY: Integer);
begin

  {top}
  ppEllipse(aCanvas, aX, aY + 2, aX + 29, aY + 6, clBlack);

  {bottom}
  ppLine(aCanvas, aX + 13, aY + 31, aX + 16, aY + 31, clBlack);

  {sloping sides}
  ppLine(aCanvas, aX,      aY + 4, aX + 12, aY + 23, clBlack);
  ppLine(aCanvas, aX + 29, aY + 4, aX + 17, aY + 23, clBlack);

  {sloping side shadow}
  ppLine(aCanvas, aX + 30, aY + 4,  aX + 18, aY + 23, clGray);
  ppLine(aCanvas, aX + 31, aY + 5,  aX + 19, aY + 22, clGray);

  {straight sides}
  ppLine(aCanvas, aX + 12, aY + 23, aX + 12, aY + 30, clBlack);
  ppLine(aCanvas, aX + 17, aY + 23, aX + 17, aY + 30, clBlack);

  {straight side shadow}
  ppLine(aCanvas, aX + 18, aY + 23, aX + 18, aY + 30, clGray);

  {color}
  ppFloodFill(aCanvas, aX + 14, aY + 13, clAqua);
  ppFloodFill(aCanvas, aX + 14, aY + 20, clAqua);

  {make sure funnel is really filled}
  ppFillRect(aCanvas, aX + 13, aY + 8, aX + 16, aY + 30, clAqua);

  {fill top}
  ppFillRect(aCanvas, aX + 7, aY + 3, aX + 24, aY + 5, clTeal);
  ppFillRect(aCanvas, aX + 1, aY + 4, aX + 28, aY + 4, clTeal);

  {fill accent}
  ppLine(aCanvas, aX + 24, aY + 3, aX + 24, aY + 3, clSilver);
  ppLine(aCanvas, aX + 22, aY + 4, aX + 22, aY + 4, clSilver);
  ppLine(aCanvas, aX + 20, aY + 5, aX + 20, aY + 5, clSilver);

  {fill shine}
  ppFillRect(aCanvas, aX + 8, aY + 3, aX + 11, aY + 3, clAqua);
  ppFillRect(aCanvas, aX + 9, aY + 4, aX + 10, aY + 5, clAqua);

  ppLine(aCanvas, aX + 7, aY + 3, aX + 7,  aY + 3, clSilver);
  ppLine(aCanvas, aX + 10, aY + 3, aX + 10, aY + 3, clSilver);

  ppFillRect(aCanvas, aX + 8,  aY + 4, aX + 8,  aY + 5, clSilver);
  ppFillRect(aCanvas, aX + 11, aY + 4, aX + 11, aY + 5, clSilver);

end; {procedure, DrawFunnel}

{------------------------------------------------------------------------------}
{ TppWizardBitmap.DrawDataBox }

procedure TppWizardBitmap.DrawDataBox(aCanvas: TCanvas; aX, aY: Integer; aCol1, aCol2, aCol3: Boolean);

  procedure DrawColumn(aX, aY: Integer; aXOffset, aYOffset: Integer; aSelected: Boolean);
  var
    liRow: Integer;
    lLineColor: TColor;
    liX: Integer;
    liY: Integer;
  begin

     liX := aX + aXOffset;
     liY := aY + aYOffset;

    if aSelected then
      ppFillRect(aCanvas, liX - 1, liY - 1, liX + 7, liY + 17, clAqua);

    if aSelected then
      lLineColor := clBlack
    else
      lLineColor := clGray;

    for liRow := 0 to 8 do
      begin
        ppLine(aCanvas, liX, liY, liX + 6, liY, lLineColor);

        liY := liY + 2;
      end;

  end;

begin

  ppFrameRect(aCanvas, aX, aY, aX + 30, aY + 24, clBlack);
  ppFillRect(aCanvas, aX, aY, aX + 30, aY + 2, clNavy);

  ppFillRect(aCanvas, aX + 1, aY + 3, aX + 29, aY + 23, clWhite);

  DrawColumn(aX, aY, 3, 5, aCol1);
  DrawColumn(aX, aY, 12, 5, aCol2);
  DrawColumn(aX, aY, 21, 5, aCol3);

end; {procedure, DrawDataBox}

{------------------------------------------------------------------------------}
{ TppWizardBitmap.DrawMainDataBox }

procedure TppWizardBitmap.DrawMainDataBox(aCanvas: TCanvas; aX, aY: Integer; aColumnCount, aRowCount: Integer; aColumnsSelected: array of Boolean);
var
 liIndex: Integer;
 liIndex2: Integer;
 liX: Integer;
 liY: Integer;
 liHeight: Integer;
 liWidth: Integer;
begin

  liHeight := (aRowCount * 3) + aRowCount + 4 + 3;
  liWidth := (aColumnCount * 11) + aColumnCount + 3 + 2;

  {border}
  ppFrameRect(aCanvas, aX, aY, aX + liWidth, aY + liHeight, clBlack);

  {title bar}
  ppFillRect(aCanvas, aX, aY, aX + liWidth, aY + 3, clNavy);

  {fill with white}
  ppFillRect(aCanvas, aX + 1, aY + 4, aX + (liWidth - 1), aY + (liHeight - 1), clWhite);

  {shadow}
  ppFillRect(aCanvas, aX + (liWidth + 1), aY + 2, aX + (liWidth + 2), aY + (liHeight + 1), clGray);
  ppFillRect(aCanvas, aX + 2, aY + (liHeight + 1), aX + (liWidth + 2), aY + (liHeight + 2), clGray);


  {draw selection highlights}
  liX := aX + 5;
  liY := aY + 4;

  for liIndex := 0 to aColumnCount - 1 do
    begin
      if aColumnsSelected[liIndex] then
        ppFillRect(aCanvas, liX, liY, liX + 10, liY + 30, clAqua);

      liX := liX + 12;
    end;

  liY := aY + 7;

  {row lines}
  for liIndex := 0 to (aRowCount - 1) do
    begin
      ppLine(aCanvas, aX + 1, liY, aX + (liWidth - 1), liY, clSilver);

      liY := liY + 4;
    end;

  liX := aX + 4;
  liY := aY + 4;

  {column lines}
  for liIndex := 0 to aColumnCount - 1 do
    begin
      ppLine(aCanvas, liX, liY, liX, liY + (liHeight - 5), clSilver);

      liX := liX + 12;
    end;

  liX := aX + 2;
  liY := aY + 5;

  {row labels}
  for liIndex := 0 to (aRowCount) do
    begin
      ppFillRect(aCanvas, liX, liY, liX + 1, liY + 1, clSilver);

      liY := liY + 4;
    end;

  liX := aX + 6;
  liY := aY + 5;

  {column labels}
  for liIndex := 0 to (aColumnCount - 1) do
    begin
      ppFillRect(aCanvas, liX, liY, liX + 9, liY + 1, clSilver);

      liX := liX + 12;
    end;

  {row data}
  liX := aX + 6;

  for liIndex := 0 to (aColumnCount - 1) do
    begin

      liY := aY + 9;

      for liIndex2 := 0 to (aRowCount - 1) do
        begin
          ppFillRect(aCanvas, liX, liY, liX + 4 + Random(4), liY, clGray);

          liY := liY + 4;
        end;

      liX := liX + 12;
    end;

end; {procedure, DrawMainDataBox}

{------------------------------------------------------------------------------}
{ TppWizardBitmap.DrawSortBox }

procedure TppWizardBitmap.DrawSortBox(aCanvas: TCanvas; aX, aY: Integer; aRowCount: Integer; aSorted: Boolean; aRowsSelected: Boolean);
var
  liX: Integer;
  liY: Integer;
  lData: TStringList;
  liIndex: Integer;
  liIndex2: Integer;
begin

  {X 2, Y 25}

  {box}
  ppFrameRect(aCanvas, aX,      aY,       aX + 63, aY + 47, clBlack);
  ppFillRect(aCanvas,  aX,      aY,       aX + 63, aY + 3,  clNavy);
  ppFillRect(aCanvas,  aX + 1,  aY + 4,   aX + 62, aY + 46, clWhite);
  ppFillRect(aCanvas,  aX + 2,  aY + 48,  aX + 63, aY + 49, clGray);
  ppFillRect(aCanvas,  aX + 64, aY + 1,   aX + 65, aY + 49, clGray);

  {draw selections}
  liX := aX + 3;
  liY := aY + 7;

  if (aRowsSelected) then
    for liIndex := 0 to (aRowCount - 1) do
      begin
        ppFillRect(aCanvas, liX, liY, aX + 65, liY + 10, clAqua);

        liY := liY + 12;
      end;

  {set background color for fonts}
  if (aRowsSelected) then
    aCanvas.Brush.Color := clAqua
  else
    aCanvas.Brush.Color := clWhite;

  aCanvas.Font.Name := 'SMALL FONTS';
  aCanvas.Font.Color := clGray;
  aCanvas.Font.Size := 6;
  aCanvas.Font.Style := [fsBold];

  liX := aX + 5;
  liY := aY + 10;

  for liIndex := 0 to (aRowCount - 1) do
    begin
      ppTextOut(aCanvas, liX, liY, IntToStr(liIndex + 1));

      liY := liY + 12;
    end;

  aCanvas.Font.Size := 5;
  aCanvas.Font.Style := [];

  lData := TStringList.Create;

  lData.Add('BBB');
  lData.Add('CCC');
  lData.Add('AAA');

  if (aRowCount = 4) then
    lData.Add('DDD');

  if aSorted then
    lData.Sort;

  liX := aX + 15;

  for liIndex := 0 to 2 do
    begin

      liY := aY + 11;

      for liIndex2 := 0 to (aRowCount - 1) do
        begin
          if (liIndex = 0) then
            begin
              aCanvas.Font.Color := clBlack;

              ppTextOut(aCanvas, liX, liY, lData[liIndex2]);
            end
          else
            begin
              aCanvas.Font.Color := clGray;

              ppTextOut(aCanvas, liX, liY, 'XXX');
            end;

          liY := liY + 12;
        end;

      if (liIndex = 0) then
        liX := liX + 19

      else
        liX := liX + 14;

    end;

  lData.Free;

end; {procedure, DrawSortBox}


end.





