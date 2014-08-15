{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppPDFRendererShape;

interface

{$I ppIfDef.pas}

uses
  Classes,
  Graphics,
  SysUtils,
  ExtCtrls,
  ppUtils,
  ppTypes,
  ppDevice,
  ppDrwCmd,
  ppPDFRenderer;

type

  {@TppPDFRendererShape

    Creates the instructions to render a shape to the PDF File. }

  TppPDFRendererShape = class(TppPDFRenderer)
    private
      FDrawShape: TppDrawShape;
      
      procedure CreateEllipse;
      procedure CreateRectangle;
      procedure CreateRoundRect;
      procedure FillGradient;

    protected
      procedure SetDrawCommand(const Value: TppDrawCommand); override;
    public
      class function DrawCommandClass: TppDrawCommandClass; override;
      procedure RenderToPDF; override;

  end;

implementation

uses
  Forms,
  Windows,
  Math,
  ppPDFUtils,
  ppPDFRendererManager;

{@TppPDFShape.CreateEllipse}

procedure TppPDFRendererShape.CreateEllipse;
var
  ldLeft: Double;
  ldTop: Double;
  ldWidth: Double;
  ldHeight: Double;
begin

  {Position & Dimentions}
  ldWidth := TppPDFUtils.MicronsToPoints(FDrawShape.Width);
  ldHeight := TppPDFUtils.MicronsToPoints(FDrawShape.Height);
  ldTop := TppPDFUtils.MicronsToPoints(FDrawShape.Top);
  ldLeft := TppPDFUtils.MicronsToPoints(FDrawShape.Left);

  {Color}
  if FDrawShape.Pen.Style = psClear then
    FDrawShape.Pen.Color := FDrawShape.Brush.Color;

  PDFCanvas.SelectPen(FDrawShape.Pen);
  PDFCanvas.SelectBrush(FDrawShape.Brush);

  {Draw the ellipse}
  PDFCanvas.Ellipse(ldLeft, ldTop, ldWidth, ldHeight);

  if FDrawShape.Brush.Style = bsClear then
    PDFCanvas.ExecuteStroke
  else
    PDFCanvas.ExecuteStrokeAndFill;

end;

{@TppPDFShape.CreateRectangle}

procedure TppPDFRendererShape.CreateRectangle;
var
  ldBorderWidth: Double;
  ldTop: Double;
  ldLeft: Double;
  ldWidth: Double;
  ldHeight: Double;
begin

  {Position & Dimentions}
  ldTop := TppPDFUtils.MicronsToPoints(FDrawShape.Top);
  ldLeft := TppPDFUtils.MicronsToPoints(FDrawShape.Left);
  ldWidth := TppPDFUtils.MicronsToPoints(FDrawShape.Width);
  ldHeight := TppPDFUtils.MicronsToPoints(FDrawShape.Height);

  {Color and Border Width}
  if FDrawShape.Pen.Style = psClear then
    begin
      FDrawShape.Pen.Color := FDrawShape.Brush.Color;
      ldBorderWidth := 0.0
    end
  else
      ldBorderWidth := TppPDFUtils.PixelsToPoints(FDrawShape.Pen.Width, Screen.PixelsPerInch);

  PDFCanvas.SelectPen(FDrawShape.Pen, ldBorderWidth);
  PDFCanvas.SelectBrush(FDrawShape.Brush);

  {Draw the Rectangle}
  PDFCanvas.Rectangle(ldLeft, ldTop, ldWidth, ldHeight);

  if FDrawShape.Brush.Style = bsClear then
    PDFCanvas.ExecuteStroke
  else
    PDFCanvas.ExecuteStrokeAndFill;

end;

{@TppPDFShape.CreateRoundRect}

procedure TppPDFRendererShape.CreateRoundRect;
var
  ldTop: Double;
  ldLeft: Double;
  ldWidth: Double;
  ldHeight: Double;
begin

  {Position & Dimentions}
  ldTop := TppPDFUtils.MicronsToPoints(FDrawShape.Top);
  ldLeft := TppPDFUtils.MicronsToPoints(FDrawShape.Left);
  ldWidth := TppPDFUtils.MicronsToPoints(FDrawShape.Width);
  ldHeight := TppPDFUtils.MicronsToPoints(FDrawShape.Height);

  {Color}
  if FDrawShape.Pen.Style = psClear then
    FDrawShape.Pen.Color := FDrawShape.Brush.Color;
    
  PDFCanvas.SelectPen(FDrawShape.Pen);
  PDFCanvas.SelectBrush(FDrawShape.Brush);

  {Draw the Round Rectangle}
  PDFCanvas.RoundRectangle(ldLeft, ldTop, ldWidth, ldHeight);

  if FDrawShape.Brush.Style = bsClear then
    PDFCanvas.ExecuteStroke
  else
    PDFCanvas.ExecuteStrokeAndFill;

end;

class function TppPDFRendererShape.DrawCommandClass: TppDrawCommandClass;
begin
  Result := TppDrawShape;
  
end;

procedure TppPDFRendererShape.FillGradient;
var
  lBitmap: Graphics.TBitmap;
  ldTop: Double;
  ldLeft: Double;
  lRect: TRect;
  lCorner: TPoint;
begin

  FDrawShape.Brush.Style := bsClear;

  lBitmap := Graphics.TBitmap.Create;

  try
    lBitmap.Width := TppPDFUtils.MicronsToPixels(FDrawShape.Width);
    lBitmap.Height := TppPDFUtils.MicronsToPixels(FDrawShape.Height);

    lRect := Rect(0,0,lBitmap.Width, lBitmap.Height);

    lCorner.x := Trunc(ppFromMMThousandths(FDrawShape.XCornerRound, utScreenPixels, pprtHorizontal, nil));
    lCorner.y := Trunc(ppFromMMThousandths(FDrawShape.YCornerRound, utScreenPixels, pprtVertical, nil));

    TppGradient.FillGradient(lBitmap.Canvas, FDrawShape.Gradient, FDrawShape.ShapeType, lRect, lCorner);

    {PDF Position}
    ldTop := TppPDFUtils.MicronsToPoints(FDrawShape.Top);
    ldLeft := TppPDFUtils.MicronsToPoints(FDrawShape.Left);

    PDFCanvas.SaveGraphicsState;
    PDFCanvas.Draw(ldLeft, ldTop, lBitmap);
    PDFCanvas.RestoreGraphicsState;

  finally
    lBitmap.Free;
  end;

end;

{@TppPDFShape.RenderToPDF}

procedure TppPDFRendererShape.RenderToPDF;
begin
  inherited;

  if FDrawshape.Gradient.Style <> gsNone then
    FillGradient;

  if FDrawShape.ShapeType = stSquare then
    CreateRectangle

  else if FDrawShape.ShapeType = stRectangle then
    CreateRectangle

  else if FDrawShape.ShapeType = stRoundRect then
    CreateRoundRect

  else if FDrawShape.ShapeType = stRoundSquare then
    CreateRoundRect

  else if FDrawShape.ShapeType = stEllipse then
    CreateEllipse

  else if FDrawShape.ShapeType = stCircle then
    CreateEllipse

  else
    raise EInvalidPropertyError.Create('ShapeType not supported');

end;

procedure TppPDFRendererShape.SetDrawCommand(const Value: TppDrawCommand);
begin
  FDrawShape := TppDrawShape(Value);

end;

initialization

  TppPDFRendererManager.RegisterRenderer(TppPDFRendererShape);

finalization

  TppPDFRendererManager.UnregisterRenderer(TppPDFRendererShape);

end.
