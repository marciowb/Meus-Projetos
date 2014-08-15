{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit daMetaBitmaps;

interface

{$I ppIfDef.pas}

uses
  Classes, Graphics, SysUtils, ppMetaBitmap;

type

  { TdaSelectTablesBitmap }
  TdaSelectTablesBitmap = class(TppWizardBitmap)
    protected
      procedure Draw(aCanvas: TCanvas); override;
    public
      constructor Create; override;
  end; {class, TdaSelectTablesBitmap}

  { TdaSelectFieldsBitmap }
  TdaSelectFieldsBitmap = class(TppWizardBitmap)
    protected
      procedure Draw(aCanvas: TCanvas); override;
    public
      constructor Create; override;
  end; {class, TdaSelectFieldsBitmap}

  { TdaGroupFieldsBitmap }
  TdaGroupFieldsBitmap = class(TppWizardBitmap)
    protected
      procedure Draw(aCanvas: TCanvas); override;
    public
      constructor Create; override;
  end; {class, TdaGroupFieldsBitmap}

  { TdaSearchCriteriaBitmap }
  TdaSearchCriteriaBitmap = class(TppWizardBitmap)
    protected
      procedure Draw(aCanvas: TCanvas); override;
    public
      constructor Create; override;
  end; {class, TdaSearchCriteriaBitmap}

  { TdaSortFieldsBitmap }
  TdaSortFieldsBitmap = class(TppWizardBitmap)
    protected
      procedure Draw(aCanvas: TCanvas); override;
    public
      constructor Create; override;
  end; {class, TdaSortFieldsBitmap}

  { TdaWizardDataBitmap }
  TdaWizardDataBitmap = class(TppWizardBitmap)
    protected
      procedure Draw(aCanvas: TCanvas); override;
    public
      constructor Create; override;
  end; {class, TdaWizardDataBitmap}

  { TdaWizardSearchBitmap }
  TdaWizardSearchBitmap = class(TppWizardBitmap)
    protected
      procedure Draw(aCanvas: TCanvas); override;
    public
      constructor Create; override;
  end; {class, TdaWizardSearchBitmap}

  { TdaWizardSortBitmap }
  TdaWizardSortBitmap = class(TppWizardBitmap)
    protected
      procedure Draw(aCanvas: TCanvas); override;
    public
      constructor Create; override;
  end; {class, TdaWizardSortBitmap}

implementation

{******************************************************************************
 *
 **  S E L E C T   T A B L E S   B I T M A P
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaSelectTablesBitmap.Create }

constructor TdaSelectTablesBitmap.Create;
begin

  inherited Create;

  Height := 80;
  Width := 145;

  BackgroundColor := clSilver;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaSelectTablesBitmap.Draw }

procedure TdaSelectTablesBitmap.Draw(aCanvas: TCanvas);
begin

  {arrow body}
  ppFillRect(aCanvas, 42, 34, 72, 46, clAqua);

  {arrow shadow}
  ppFillRect(aCanvas, 42, 39, 43, 46, clTeal);
  ppLine(aCanvas, 52, 34, 52, 39, clTeal);
  ppLine(aCanvas, 42, 39, 52, 39, clTeal);

  ppFillRect(aCanvas, 44, 47, 72, 48, clGray);
  ppLine(aCanvas, 82, 41, 73, 50, clGray);
  ppLine(aCanvas, 73, 50, 73, 50, clGray);
  ppLine(aCanvas, 82, 42, 74, 50, clGray);
  ppLine(aCanvas, 74, 50, 74, 50, clGray);

  {arrow tip}
  aCanvas.Pen.Color := clAqua;
  aCanvas.Brush.Color := clAqua;
  aCanvas.Polygon([Point(73,31), Point(73,49), Point(82,40), Point(73,31)]);

  {draw tables}
  DrawDataBox(aCanvas, 0, 20, True, True, False);
  DrawDataBox(aCanvas, 21, 14, False, True, True);
  DrawDataBox(aCanvas, 11, 33, False, True, False);

  {table shadows}
  ppFillRect(aCanvas, 42, 47, 43, 59, clGray);
  ppFillRect(aCanvas, 13, 58, 43, 59, clGray);

  ppLine(aCanvas, 1, 45, 10, 45, clGray);
  ppLine(aCanvas, 52, 16, 52, 35, clGray);

  DrawMainDataBox(aCanvas, 86, 23, 4, 7, [False, False, False, False]);

end; {procedure, Draw}

{******************************************************************************
 *
 **  G R O U P   F I E L D S   B I T M A P
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaGroupFieldsBitmap.Create }

constructor TdaGroupFieldsBitmap.Create;
begin

  inherited Create;

  Height := 80;
  Width := 160;

  BackgroundColor := clSilver;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaGroupFieldsBitmap.Draw }

procedure TdaGroupFieldsBitmap.Draw(aCanvas: TCanvas);
var
  liX: Integer;
  liY: Integer;
  liIndex: Integer;
  liIndex2: Integer;
begin

  DrawMainDataBox(aCanvas, 0, 0, 3, 16, [False, False, False]);

  DrawMainDataBox(aCanvas, 99, 36, 3, 7, [False, False, False]);

  {flow line 1}
  ppFillRect(aCanvas, 41, 12, 74, 13, clAqua);
  ppLine(aCanvas, 44, 14, 72, 14, clGray);

  {flow line 2}
  ppFillRect(aCanvas, 41, 16, 74, 17, clAqua);
  ppLine(aCanvas, 44, 18, 72, 18, clGray);

  {flow line 3}
  ppFillRect(aCanvas, 41, 20, 74, 21, clAqua);
  ppLine(aCanvas, 44, 22, 72, 22, clGray);

  {flow line 4}
  ppFillRect(aCanvas, 41, 24, 74, 25, clAqua);
  ppLine(aCanvas, 44, 26, 72, 26, clGray);

  {flow line 5}
  ppFillRect(aCanvas, 41, 28, 74, 29, clAqua);
  ppLine(aCanvas, 44, 30, 72, 30, clGray);

  {arrow body}
  ppFillRect(aCanvas, 74, 12, 83, 49, clAqua);

  {arrow neck}
  ppFillRect(aCanvas, 84, 40, 88, 49, clAqua);

  {arrow tip}
  aCanvas.Brush.Color := clAqua;
  aCanvas.Pen.Color := clAqua;

  aCanvas.Polygon([Point(89, 36),
                   Point(98, 45),
                   Point(89, 54),
                   Point(89, 36)]);

  {top arrow elbow}
  aCanvas.Brush.Color := clSilver;
  aCanvas.Pen.Color := clSilver;

  aCanvas.Polygon([Point(81, 12),
                   Point(83, 12),
                   Point(83, 14),
                   Point(81, 12)]);

  {bottom arrow elbow}
  aCanvas.Brush.Color := clSilver;
  aCanvas.Pen.Color := clSilver;

  aCanvas.Polygon([Point(74, 47),
                   Point(76, 49),
                   Point(74, 49),
                   Point(74, 47)]);

  {arrow shadow}
  ppFillRect(aCanvas, 84, 17,  85, 39, clGray);
  ppFillRect(aCanvas, 80, 50, 88, 51, clGray);

  {straight shadow touch-up}
  ppLine(aCanvas, 79, 50, 79, 50, clGray);
  ppLine(aCanvas, 84, 16, 84, 16, clGray);

  {slant shadow}
  ppLine(aCanvas, 98, 46, 89, 55, clGray);
  ppLine(aCanvas, 98, 47, 90, 55, clGray);

  {slant shadow touch-up}
  ppLine(aCanvas, 89, 55, 89, 55, clGray);
  ppLine(aCanvas, 90, 55, 90, 55, clGray);

  liX := 5;

  for liIndex := 0 to 2 do
    begin
      liY := 12;

      for liIndex2 := 0 to 4 do
        begin
          ppFloodFill(aCanvas, liX, liY, clAqua);

          liY := liY + 4;
        end;

      liX := liX + 12;
    end;

  ppFloodFill(aCanvas, 100, 44, clAqua);
  ppFloodFill(aCanvas, 104, 44, clAqua);
  ppFloodFill(aCanvas, 116, 44, clAqua);
  ppFloodFill(aCanvas, 128, 44, clAqua);

end; {procedure, Draw}

{******************************************************************************
 *
 **  S E L E C T   F I E L D S   B I T M A P
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaSelectFieldsBitmap.Create }

constructor TdaSelectFieldsBitmap.Create;
begin

  inherited Create;

  Height := 80;
  Width := 145;

  BackgroundColor := clSilver;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaSelectFieldsBitmap.Draw }

procedure TdaSelectFieldsBitmap.Draw(aCanvas: TCanvas);
begin

  DrawMainDataBox(aCanvas, 0, 0, 5, 7, [True, False, True, True, False]);

  DrawMainDataBox(aCanvas, 96, 38, 3, 7, [False, False, False]);

  {flow line 1}
  ppFillRect(aCanvas, 6, 34, 14, 60, clAqua);

  ppLine(aCanvas, 15, 38, 15, 49, clGray);

  {flow line 2}
  ppFillRect(aCanvas, 30, 34, 38, 48, clAqua);

  ppLine(aCanvas, 39, 38, 39, 49, clGray);

  {flow line 3}
  ppFillRect(aCanvas, 42, 34, 50, 48, clAqua);

  ppLine(aCanvas, 51, 38, 51, 49, clGray);

  {arrow body}
  ppFillRect(aCanvas, 15, 49, 78, 60, clAqua);

  {arrow shadow}
  ppFillRect(aCanvas, 13, 61, 13, 61, clGray);
  ppFillRect(aCanvas, 14, 61, 78, 62, clGray);

  ppLine(aCanvas, 88, 55, 79, 64, clGray);
  ppLine(aCanvas, 79, 64, 79, 64, clGray);

  ppLine(aCanvas, 88, 56, 80, 64, clGray);
  ppLine(aCanvas, 80, 64, 80, 64, clGray);

  {arrow tip}
  aCanvas.Pen.Color := clAqua;
  aCanvas.Brush.Color := clAqua;
  aCanvas.Polygon([Point(79,45), Point(79,63), Point(88,54), Point(79,45)]);

  {flow elbow}
  aCanvas.Pen.Color := clSilver;
  aCanvas.Brush.Color := clSilver;
  aCanvas.Polygon([Point(6,58), Point(6,60), Point(8,60), Point(6,58)]);

end; {procedure, Draw}

{******************************************************************************
 *
 **  S E A R C H   C R I T E R I A   B I T M A P
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaSearchCriteriaBitmap.Create }

constructor TdaSearchCriteriaBitmap.Create;
begin

  inherited Create;

  Height := 80;
  Width := 145;

  BackgroundColor := clSilver;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaSearchCriteriaBitmap.Draw }

procedure TdaSearchCriteriaBitmap.Draw(aCanvas: TCanvas);
begin

  DrawMainDataBox(aCanvas, 0, 0, 3, 16, [False, False, False]);

  DrawMainDataBox(aCanvas, 88, 43, 3, 7, [False, False, False]);

  DrawFunnel(aCanvas, 94, 24);

  {arrow body}
  ppFillRect(aCanvas, 44, 3, 114, 14, clAqua);

  {arrow neck}
  ppFillRect(aCanvas, 102, 15, 114, 16, clAqua);

  {arrow tip}
  aCanvas.Brush.Color := clAqua;
  aCanvas.Pen.Color := clAqua;

  aCanvas.Polygon([Point(99,17), Point(117,17), Point(108,26), Point(99,17)]);

  {arrow shadow}
  ppFillRect(aCanvas, 42, 3, 43, 14, clTeal);
  ppFillRect(aCanvas, 44, 15, 101, 16, clGray);
  ppFillRect(aCanvas, 115, 10, 116, 16, clGray);
  ppFillRect(aCanvas, 115, 9, 115, 9, clGray);

  ppLine(aCanvas, 117, 18, 110, 25, clGray);
  ppLine(aCanvas, 118, 19, 111, 25, clGray);

  ppLine(aCanvas, 110, 25, 110, 25, clGray);
  ppLine(aCanvas, 111, 25, 111, 25, clGray);

  {arrow elbow}
  aCanvas.Brush.Color := clSilver;
  aCanvas.Pen.Color := clSilver;

  aCanvas.Polygon([Point(112,3), Point(114,5), Point(114,3), Point(112,3)]);

end; {procedure, Draw}

{******************************************************************************
 *
 **  S O R T   F I E L D S   B I T M A P
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaSortFieldsBitmap.Create }

constructor TdaSortFieldsBitmap.Create;
begin

  inherited Create;

  Height := 80;
  Width := 160;

  BackgroundColor := clSilver;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaSortFieldsBitmap.Draw }

procedure TdaSortFieldsBitmap.Draw(aCanvas: TCanvas);
begin

  {unsorted box}
  DrawSortBox(aCanvas, 0, 0, 3, False, True);

  {sorted box}
  DrawSortBox(aCanvas, 94, 30, 3, True, False);

  {arrow body}
  ppFillRect(aCanvas, 68, 7, 77, 59, clAqua);

  ppFillRect(aCanvas, 66, 7,  67, 17, clAqua);
  ppFillRect(aCanvas, 66, 19, 67, 29, clAqua);
  ppFillRect(aCanvas, 66, 31, 67, 41, clAqua);

  {arrow neck}
  ppFillRect(aCanvas, 77, 50, 83, 59, clAqua);

  {arrow tip}
  aCanvas.Brush.Color := clAqua;
  aCanvas.Pen.Color := clAqua;

  aCanvas.Polygon([Point(83,46), Point(92,55), Point(83,64), Point(83,46)]);

  {top arrow elbow}
  aCanvas.Brush.Color := clSilver;
  aCanvas.Pen.Color := clSilver;

  aCanvas.Polygon([Point(75,7), Point(77,7), Point(77,9), Point(75,7)]);

  {bottom arrow elbow}
  aCanvas.Brush.Color := clSilver;
  aCanvas.Pen.Color := clSilver;

  aCanvas.Polygon([Point(68,57), Point(70,59), Point(68,60), Point(68,57)]);

  {arrow shadow}
  ppFillRect(aCanvas, 78, 12, 79, 49, clGray);
  ppFillRect(aCanvas, 74, 60, 82, 61, clGray);

  ppLine(aCanvas, 78, 11, 78, 11, clGray);
  ppLine(aCanvas, 73, 60, 73, 60, clGray);

  ppLine(aCanvas, 92, 56, 83, 65, clGray);
  ppLine(aCanvas, 92, 57, 84, 65, clGray);

  ppLine(aCanvas, 83, 65, 83, 65, clGray);
  ppLine(aCanvas, 84, 65, 84, 65, clGray);

end; {procedure, Draw}

{******************************************************************************
 *
 **  W I Z A R D   S E A R C H   B I T M A P
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaWizardSearchBitmap.Create }

constructor TdaWizardSearchBitmap.Create;
begin

  inherited Create;

  Height := 190;
  Width := 130;

  BackgroundColor := clSilver;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaWizardSearchBitmap.Draw }

procedure TdaWizardSearchBitmap.Draw(aCanvas: TCanvas);
begin

  {column highlights}
  ppFillRect(aCanvas, 39, 25, 49, 55, clAqua);
  ppFillRect(aCanvas, 51, 25, 61, 55, clAqua);
  ppFillRect(aCanvas, 75, 25, 86, 55, clAqua);

  DrawMainDataBox(aCanvas, 34, 21, 4, 7, [False, False, False, False]);

  {bottom rectangle}
  {border}
  ppFrameRect(aCanvas, 40, 107, 81, 142, clBlack);

  {title bar}
  ppFillRect(aCanvas, 40, 107, 81, 110, clNavy);

  {columns}
  ppFillRect(aCanvas, 41, 111, 43, 141, clWhite);
  ppFillRect(aCanvas, 45, 111, 55, 141, clWhite);
  ppFillRect(aCanvas, 57, 111, 67, 141, clWhite);
  ppFillRect(aCanvas, 69, 111, 80, 141, clWhite);

  {shadow}
  ppFillRect(aCanvas, 82, 109, 83, 142, clGray);
  ppFillRect(aCanvas, 43, 143, 83, 144, clGray);

  {row lines}
  ppLine(aCanvas, 41, 114, 80, 114, clSilver);
  ppLine(aCanvas, 41, 118, 80, 118, clSilver);
  ppLine(aCanvas, 41, 122, 80, 122, clSilver);
  ppLine(aCanvas, 41, 126, 80, 126, clSilver);
  ppLine(aCanvas, 41, 130, 80, 130, clSilver);
  ppLine(aCanvas, 41, 134, 80, 134, clSilver);
  ppLine(aCanvas, 41, 138, 80, 138, clSilver);

  {column headings}
  ppFillRect(aCanvas, 46, 112, 55, 113, clSilver);
  ppFillRect(aCanvas, 58, 112, 67, 113, clSilver);
  ppFillRect(aCanvas, 70, 112, 80, 113, clSilver);

  {row labels}
  ppFillRect(aCanvas, 42, 112, 43, 113, clSilver);
  ppFillRect(aCanvas, 42, 116, 43, 117, clSilver);
  ppFillRect(aCanvas, 42, 120, 43, 121, clSilver);
  ppFillRect(aCanvas, 42, 124, 43, 125, clSilver);
  ppFillRect(aCanvas, 42, 128, 43, 129, clSilver);
  ppFillRect(aCanvas, 42, 132, 43, 133, clSilver);
  ppFillRect(aCanvas, 42, 136, 43, 137, clSilver);
  ppFillRect(aCanvas, 42, 140, 43, 141, clSilver);

  {row data}
  {column 1}
  ppLine(aCanvas, 46, 116, 54, 116, clGray);
  ppLine(aCanvas, 46, 120, 51, 120, clGray);
  ppLine(aCanvas, 46, 124, 53, 124, clGray);
  ppLine(aCanvas, 46, 128, 54, 128, clGray);
  ppLine(aCanvas, 46, 132, 53, 132, clGray);
  ppLine(aCanvas, 46, 136, 50, 136, clGray);
  ppLine(aCanvas, 46, 140, 54, 140, clGray);

  {column 2}
  ppLine(aCanvas, 58, 116, 65, 116, clGray);
  ppLine(aCanvas, 58, 120, 66, 120, clGray);
  ppLine(aCanvas, 58, 124, 66, 124, clGray);
  ppLine(aCanvas, 58, 128, 63, 128, clGray);
  ppLine(aCanvas, 58, 132, 67, 132, clGray);
  ppLine(aCanvas, 58, 136, 63, 136, clGray);
  ppLine(aCanvas, 58, 140, 66, 140, clGray);

  {column 3}
  ppLine(aCanvas, 70, 116, 76, 116, clGray);
  ppLine(aCanvas, 70, 120, 78, 120, clGray);
  ppLine(aCanvas, 70, 124, 77, 124, clGray);
  ppLine(aCanvas, 70, 128, 79, 128, clGray);
  ppLine(aCanvas, 70, 132, 76, 132, clGray);
  ppLine(aCanvas, 70, 136, 78, 136, clGray);
  ppLine(aCanvas, 70, 140, 79, 140, clGray);

  {draw funnel}
  DrawFunnel(aCanvas, 46, 73);

  {arrow body}
  ppFillRect(aCanvas, 54, 59, 66, 67, clAqua);

  {arrow shadow}
  ppFillRect(aCanvas, 67, 59, 68, 67, clGray);
  ppLine(aCanvas, 70, 68, 64, 74, clGray);
  ppLine(aCanvas, 70, 69, 65, 74, clGray);

  {arrow outline}
  ppLine(aCanvas, 51, 68, 69, 68, clAqua);
  ppLine(aCanvas, 51, 68, 60, 77, clAqua);
  ppLine(aCanvas, 69, 68, 60, 77, clAqua);
  ppLine(aCanvas, 60, 77, 60, 77, clAqua);

  ppFloodFill(aCanvas, 60, 70, clAqua);

  {clean up arrow tip}
  ppLine(aCanvas, 58, 75, 62, 75, clAqua);
  ppLine(aCanvas, 60, 76, 60, 76, clAqua);

end; {procedure, Draw}

{******************************************************************************
 *
 **  W I Z A R D   D A T A   B I T M A P
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaWizardDataBitmap.Create }

constructor TdaWizardDataBitmap.Create;
begin

  inherited Create;

  Height := 190;
  Width := 130;

  BackgroundColor := clSilver;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaWizardDataBitmap.Draw }

procedure TdaWizardDataBitmap.Draw(aCanvas: TCanvas);
begin

  {draw tables}
  DrawDataBox(aCanvas, 33, 28, True, True, False);
  DrawDataBox(aCanvas, 54, 22, False, True, True);
  DrawDataBox(aCanvas, 44, 41, False, True, False);

  {table shadows}
  ppLine(aCanvas, 34, 53, 43, 53, clGray);
  ppLine(aCanvas, 85, 24, 85, 47, clGray);
  ppLine(aCanvas, 75, 47, 85, 47, clGray);
  ppFillRect(aCanvas, 75, 48, 76, 67, clGray);
  ppFillRect(aCanvas, 46, 66, 76, 67, clGray);

  {arrow tip}
  aCanvas.Pen.Color := clAqua;
  aCanvas.Brush.Color := clAqua;
  aCanvas.Polygon([Point(51,94), Point(69,94), Point(60,103), Point(51,94)]);

  {arrow body}
  ppFillRect(aCanvas, 54, 68, 66, 93, clAqua);

  {arrow shadow}
  ppFillRect(aCanvas, 54, 66, 66, 67, clTeal);

  ppFillRect(aCanvas, 67, 68, 68, 93, clGray);
  ppLine(aCanvas, 60, 104, 69, 95, clGray);
  ppLine(aCanvas, 61, 104, 70, 95, clGray);

  DrawMainDataBox(aCanvas, 33, 107, 4, 7, [False, False, False, False]);

end; {procedure, Draw}

{******************************************************************************
 *
 **  W I Z A R D   S O R T   B I T M A P
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaWizardSortBitmap.Create }

constructor TdaWizardSortBitmap.Create;
begin

  inherited Create;

  Height := 190;
  Width := 130;

  BackgroundColor := clSilver;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TdaWizardSortBitmap.Draw }

procedure TdaWizardSortBitmap.Draw(aCanvas: TCanvas);
begin

  {sort arrows}
  ppFillRect(aCanvas, 7, 33, 96, 43, clAqua);
  ppFillRect(aCanvas, 7, 46, 96, 56, clAqua);
  ppFillRect(aCanvas, 7, 58, 96, 68, clAqua);

  ppLine(aCanvas, 65, 44, 95, 44, clGray);
  ppLine(aCanvas, 65, 56, 95, 56, clGray);
  ppLine(aCanvas, 65, 69, 95, 69, clGray);

  ppFillRect(aCanvas, 97, 33, 107, 88, clAqua);

  ppLine(aCanvas, 96, 44, 96, 44, clAqua);
  ppLine(aCanvas, 96, 46, 96, 46, clAqua);
  ppLine(aCanvas, 96, 56, 96, 56, clAqua);
  ppLine(aCanvas, 96, 58, 96, 58, clAqua);
  ppLine(aCanvas, 96, 69, 96, 69, clAqua);

  {draw unsorted box}
  DrawSortBox(aCanvas, 2, 25, 3, False, True);

  {draw sorted box}
  DrawSortBox(aCanvas, 43, 95, 4, True, False);

  {arrow point}
  aCanvas.Pen.Color := clAqua;
  aCanvas.Brush.Color := clAqua;
  aCanvas.Polygon([Point(93,89), Point(102,98), Point(111,89), Point(93,89)]);

  {arrow elbow}
  aCanvas.Pen.Color := clSilver;
  aCanvas.Brush.Color := clSilver;
  aCanvas.Polygon([Point(102,32), Point(108,38), Point(108,32), Point(102,32)]);

  ppLine(aCanvas, 102, 33, 102, 33, clSilver);
  ppLine(aCanvas, 107, 38, 107, 38, clSilver);

  {arrow shadows}
  ppFillRect(aCanvas, 108, 42, 109, 88, clGray);
  ppLine(aCanvas, 107, 94, 112, 89, clGray);
  ppLine(aCanvas, 108, 94, 113, 89, clGray);
  ppLine(aCanvas, 108, 41, 108, 41, clGray);

end; {procedure, Draw}





end.





