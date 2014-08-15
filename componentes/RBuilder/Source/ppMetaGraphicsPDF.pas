{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppMetaGraphicsPDF;

interface

{$I ppIfDef.pas}

uses
  Classes,
  Windows,
  Graphics,
  GraphUtil,
  Forms,
  Types,

  ppTypes,
  ppInterfacedObject,
  ppMetaGraphics,

  ppPDFUtils,
  ppPDFCanvas;

type

  {TppMetaGraphicsPDF

     Implements an IppMetaGraphics interface that acts as an adapter for
     translating metafile commands to PDFCanvas rendering commands.

        MetaFile --> MetaFileReader(IMetaGraphics) --> PDFCanvas --> PDFFile


     Example:

         // create metagraphics
        lMetaGraphicsPDF := TppMetaGraphicsPDF.Create(FPDFCanvas);

        // create metafile reader and assign the metafile
        lMetaFileReader := TppMetaFileReader.Create;
        lMetaFileReader.Metafile := FMetaFile;

        // render metafile records to PDF
        lMetaFileReader.Execute(lMetaGraphicsPDF, aClientRect);

  }
  TppMetaGraphicsPDF = class(TppInterfacedObject, IppMetaGraphics)
  private
    FBrush: TBrush;
    FBackgroundColor: TColor;
    FPDFCanvas: TppPDFCanvas;
    FPen: TPen;
    FFont: TFont;
    FMoveToCache: TPoint;
    FRefBitmap: TBitmap;
    FRefCanvas: TCanvas;
    FFontAngle: Integer;
    FTextAlignment: Cardinal;
    FTextColor: TColor;
    FViewPortAssigned: Boolean;
    FWindowExtAssigned: Boolean;
    FWindowOrgAssigned: Boolean;
    FWindowOrg: TPoint;
    FClipped: Boolean;
    FCurrentScaleX: Single;
    FCurrentScaleY: Single;
    FInitialScaleX: Single;
    FInitialScaleY: Single;

    FInitWorldTransform: Boolean;

    procedure RaiseNotImplementedException(aMethodName: String);
    function  AdjustRotatedText(aX, aY, aWidth, aHeight, aAngle: Integer): TPoint;
    procedure DrawPolygon(aPointArray: array of TPoint);
    procedure DrawPolyBezier(aPointArray: array of TPoint; aStartingPoint: Integer);
    function  CreatePointArray(const aSourceArray: array of TPoint; aCount, aPosition: Integer): TppPointArray;
    procedure FinalizeShape;
    procedure SetScaling;

  protected
    procedure PDFBeginPath;
    function ConvertX(aPixels: Integer): Double;
    function ConvertY(aPixels: Integer): Double;

  public
    constructor Create(aPDFCanvas: TppPDFCanvas); virtual;
    destructor Destroy; override;

    // prop getters
    function GetArcDirection: Integer;
    function GetBrush: TBrush;
    function GetCopyMode: TCopyMode;
    function GetFont: TFont;
    function GetFontAngle: Integer;
    function GetFontMapperFlags: Integer;
    function GetMapMode: Integer;
    function GetPen: TPen;
    function GetPolyFillMode: Integer;
    function GetStretchBltMode: Integer;
    function GetTextAlignmentFlags: Cardinal;
    function GetTextFlags: Integer;
    function GetTextColor: TColor;

    // prop setters
    procedure SetArcDirection(const Value: Integer);
    procedure SetBrush(const Value: TBrush);
    procedure SetCopyMode(const Value: TCopyMode);
    procedure ExtSelectClipRgn(aRgn: HRGN; aRgnData: PRgnData; aMode: Integer; aRectArray: array of TRect);
    procedure IntersectClipRect(aRect: TRect);
    procedure SetFont(const Value: TFont);
    procedure SetFontAngle(const Value: Integer);
    procedure SetFontMapperFlags(const Value: Integer);
    procedure SetPen(const Value: TPen);
    procedure SetPolyFillMode(const Value: Integer);
    procedure SetMapMode(const Value: Integer);
    procedure SetTextAlignmentFlags(const Value: Cardinal);
    procedure SetTextColor(const Value: TColor);
    procedure SetTextFlags(const Value: Integer);
    procedure SetStretchBltMode(const Value: Integer);

    // state/environment settings
    procedure OffsetClipRegion(aX, aY: Integer); virtual;
    procedure SelectClipPath(aMode: Integer);
    procedure SetBkMode(aMode: Integer);  virtual;
    procedure SetBrushOrg(aPoint: TPoint); virtual;
    procedure SetViewportExt(aExtent: TSize); virtual;
    procedure SetViewportOrg(aPoint: TPoint); virtual;
    procedure SetWindowExt(aExtent: TSize); virtual;
    procedure SetWindowOrg(aPoint: TPoint); virtual;
    procedure SetWorldTransform(aXForm: TXForm);
    procedure ModifyWorldTransform(aXForm: TXForm; aMode: Cardinal);
    procedure SetMetaRgn; virtual;
    procedure SaveDC; virtual;
    procedure RestoreDC; virtual;

    // drawing methods
    procedure AngleArc(aCenterPoint: TPoint; aRadius: Integer; aStartAngle, aSweepAngle: Double); virtual;
    procedure Arc(aRect: TRect; aStartPoint, aEndPoint: TPoint); virtual;
    procedure BeginPath;
    procedure Chord(aRect: TRect; aStartPoint, aEndPoint: TPoint); virtual;
    procedure CloseFigure;
    procedure Draw(aX, aY: Integer; aBitmap: TBitmap);
    procedure Ellipse(aRect: TRect); virtual;
    procedure EndPath;
    procedure FillPath;
    procedure StrokePath;
    procedure FillRect(aRect: TRect); virtual;
    procedure FloodFill(aStartPoint: TPoint; aColor: TColor; aMode: Integer); virtual;
    procedure GradientFill(aRect: TRect; aStartColor: TColor; aEndColor: TColor; aMode: Integer); virtual;
    procedure InitializeView(aBoundsRect: TRect; aScaleX, aScaleY: Single); virtual;
    procedure LineTo(aX, aY: Integer); virtual;
    procedure MoveTo(aX, aY: Integer); virtual;
    procedure TextRect(aRect: TRect; aX, aY: Integer; aText: String; aSpacingArray: array of Integer); virtual;
    procedure PatBlt(aRect: TRect; aMode: Cardinal); virtual;
    procedure Pie(aRect: TRect; aStartPoint, aEndPoint: TPoint); virtual;
    procedure PolyBezier(const aPointArray: array of TPoint); virtual;
    procedure PolyBezierTo(const aPointArray: array of TPoint); virtual;
    procedure Polygon(const aPointArray: array of TPoint); virtual;
    procedure PolyLine(const aPointArray: array of TPoint); virtual;
    procedure PolyLineTo(const aPointArray: array of TPoint); virtual;
    procedure PolyPolygon(const aPointArray: array of TPoint; aPolyCountsArray: array of Integer); virtual;
    procedure Rectangle(aRect: TRect); virtual;
    procedure RoundRect(aRect: TRect; aCornerSize: TSize); virtual;
    procedure SetBkColor(aColor: TColor); virtual;
    procedure SetPixelColor(aPoint: TPoint; aColor: TColor); virtual;
    procedure StretchDraw(aRect: TRect; aBitmap: TBitmap);

    property FontAngle: Integer read GetFontAngle write SetFontAngle;

  end;


implementation

uses
  Math,
  ppUtils,
  ppRotatedText;



constructor TppMetaGraphicsPDF.Create(aPDFCanvas: TppPDFCanvas);
begin
  inherited Create;

  FPDFCanvas := aPDFCanvas;

  FRefBitmap := TBitmap.Create;
  FRefCanvas := FRefBitmap.Canvas;

  FBrush := FRefCanvas.Brush;
  FPen := FRefCanvas.Pen;
  FFont := FRefCanvas.Font;

  FBackgroundColor := TColor($FFFFFF);

  FWindowExtAssigned := False;
  FViewPortAssigned := False;
  FWindowOrgAssigned := False;

  FClipped := False;

  FMoveToCache := Point(0,0);
  FWindowOrg := Point(0,0);

  FInitialScaleX := 1;
  FInitialScaleY := 1;

  FInitWorldTransform := False;

end;

destructor TppMetaGraphicsPDF.Destroy;
begin

  inherited;

  FRefBitmap.Free;

end;

function TppMetaGraphicsPDF.AdjustRotatedText(aX, aY, aWidth, aHeight, aAngle: Integer): TPoint;
begin
  if (aAngle > 0) and (aAngle <= 90) then
    Result := Point(aX, aY + aHeight)
  else if (aAngle > 90) and (aAngle <= 180) then
    Result := Point(aX + aWidth, aY + aHeight)
  else if (aAngle > 180) and (aAngle <= 270) then
    Result := Point(aX + aWidth, aY)
  else
    Result := Point(aX, aY);

end;

procedure TppMetaGraphicsPDF.AngleArc(aCenterPoint: TPoint; aRadius: Integer; aStartAngle, aSweepAngle: Double);
begin
  FPDFCanvas.SelectPen(FPen);
  FPDFCanvas.SelectBrush(FBrush);

  PDFBeginPath;
  FPDFCanvas.AngleArc(ConvertX(aCenterPoint.X), ConvertY(aCenterPoint.Y), ConvertX(aRadius), aStartAngle, aSweepAngle);
  FPDFCanvas.ExecuteStroke;

end;

procedure TppMetaGraphicsPDF.Arc(aRect: TRect; aStartPoint, aEndPoint: TPoint);
begin
  FPDFCanvas.SelectPen(FPen);
  FPDFCanvas.SelectBrush(FBrush);

  PDFBeginPath;
  FPDFCanvas.Arc(ConvertX(aRect.Left), ConvertY(aRect.Top), ConvertX(aRect.Right), ConvertY(aRect.Bottom), ConvertX(aStartPoint.X), ConvertY(aStartPoint.Y), ConvertX(aEndPoint.X), ConvertY(aEndPoint.Y));
  FPDFCanvas.ExecuteStroke;

end;

{TppMetaGraphicsPDF.PDFBeginPath

  This method must be called before the first drawing function is called for a
  given path on the PDF canvas to ensure the path has the proper starting point.}

procedure TppMetaGraphicsPDF.PatBlt(aRect: TRect; aMode: Cardinal);
begin
  if aMode <> $00AA0029 then  //DSTCOPY mode was removed after Windows 98
    FillRect(Rect(aRect.Left, aRect.Top, aRect.Right, aRect.Bottom));

end;

procedure TppMetaGraphicsPDF.PDFBeginPath;
begin
  if not(FPDFCanvas.PathOpen) or ((FPDFCanvas.PathOpen) and not(FPDFCanvas.SubPathOpen)) then
    FPDFCanvas.MoveTo(ConvertX(FMoveToCache.X), ConvertY(FMoveToCache.Y));

end;

procedure TppMetaGraphicsPDF.BeginPath;
begin
  FPDFCanvas.PathOpen := True;

end;

procedure TppMetaGraphicsPDF.Chord(aRect: TRect; aStartPoint, aEndPoint: TPoint);
begin
  FPDFCanvas.SelectPen(FPen);
  FPDFCanvas.SelectBrush(FBrush);

  PDFBeginPath;

  FPDFCanvas.Chord(ConvertX(aRect.Left), ConvertY(aRect.Top), ConvertX(aRect.Right), ConvertY(aRect.Bottom), ConvertX(aStartPoint.X), ConvertY(aStartPoint.Y), ConvertX(aEndPoint.X), ConvertY(aEndPoint.Y));
  FinalizeShape;
end;

procedure TppMetaGraphicsPDF.CloseFigure;
begin
  FPDFCanvas.CloseShape;
end;

function TppMetaGraphicsPDF.ConvertX(aPixels: Integer): Double;
begin
  Result := TppPDFUtils.PixelsToPoints(aPixels, Screen.PixelsPerInch);
end;

function TppMetaGraphicsPDF.ConvertY(aPixels: Integer): Double;
begin
  Result := TppPDFUtils.PixelsToPoints(aPixels, Screen.PixelsPerInch);
end;

procedure TppMetaGraphicsPDF.Draw(aX, aY: Integer; aBitmap: TBitmap);
begin
  FPDFCanvas.SaveGraphicsState;
  FPDFCanvas.Draw(ConvertX(aX), ConvertY(aY), aBitmap);
  FPDFCanvas.RestoreGraphicsState;
  
end;

procedure TppMetaGraphicsPDF.DrawPolyBezier(aPointArray: array of TPoint; aStartingPoint: Integer);
var
  liIndex: Integer;
  liX1: Integer;
  liY1: Integer;
  liX2: Integer;
  liY2: Integer;
  liX3: Integer;
  liY3: Integer;
begin

  FPDFCanvas.SelectPen(FPen);
  FPDFCanvas.SelectBrush(FBrush);

  PDFBeginPath;

  liIndex := aStartingPoint;

  if liIndex > 0 then
    begin
      liX1 := aPointArray[0].X;
      liY1 := aPointArray[0].Y;

      FPDFCanvas.MoveTo(ConvertX(liX1), ConvertY(liY1));
    end;

  while liIndex < Length(aPointArray) do
    begin
      liX1 := aPointArray[liIndex].X;
      liY1 := aPointArray[liIndex].Y;
      liX2 := aPointArray[liIndex + 1].X;
      liY2 := aPointArray[liIndex + 1].Y;
      liX3 := aPointArray[liIndex + 2].X;
      liY3 := aPointArray[liIndex + 2].Y;
      FPDFCanvas.BezierCurve(ConvertX(liX1), ConvertY(liY1), ConvertX(liX2), ConvertY(liY2), ConvertX(liX3), ConvertY(liY3));

      liIndex := liIndex + 3;
    end;

  FPDFCanvas.ExecuteStroke;

end;

procedure TppMetaGraphicsPDF.DrawPolygon(aPointArray: array of TPoint);
var
  liIndex: Integer;
  liX: Integer;
  liY: Integer;
begin

  liX := aPointArray[0].X;
  liY := aPointArray[0].Y;

  FPDFCanvas.MoveTo(ConvertX(liX), ConvertY(liY));

  for liIndex := 1 to Length(aPointArray) - 1 do
    begin
      liX := aPointArray[liIndex].X;
      liY := aPointArray[liIndex].Y;
      FPDFCanvas.LineTo(ConvertX(liX), Converty(liY));
    end;

end;

procedure TppMetaGraphicsPDF.Ellipse(aRect: TRect);
var
  liWidth: Integer;
  liHeight: Integer;
begin

  liWidth := aRect.Right - aRect.Left;
  liHeight := aRect.Bottom - aRect.Top;

  if FPen.Style = psClear then
    FPen.Color := FBrush.Color;

  FPDFCanvas.SelectPen(FPen);
  FPDFCanvas.SelectBrush(FBrush);

  PDFBeginPath;
  FPDFCanvas.Ellipse(ConvertX(aRect.Left), ConvertY(aRect.Top), ConvertX(liWidth), ConvertY(liHeight));

  FinalizeShape;

end;

procedure TppMetaGraphicsPDF.ExtSelectClipRgn(aRgn: HRGN; aRgnData: PRgnData; aMode: Integer; aRectArray: array of TRect);
var
  liIndex: Integer;
  lRect: TRect;
begin

  if (aRgn = 0) then   //Null region restores back to the initial clip region
    begin
      if FClipped then
        FPDFCanvas.RestoreGraphicsState;

      FClipped := False;
    end
  else
    begin

      if FClipped and (aMode = RGN_COPY) then
        FPDFCanvas.RestoreGraphicsState;

      if not(FClipped) or (aMode = RGN_COPY) then
        FPDFCanvas.SaveGraphicsState;

      for liIndex := 0 to Length(aRectArray) - 1 do
        begin
          lRect := aRectArray[liIndex];
          FPDFCanvas.ClipRegion(ConvertX(lRect.Left), ConvertY(lRect.Top),
                                ConvertX(lRect.Right - lRect.Left), ConvertY(lRect.Bottom - lRect.Top));
        end;

      FPDFCanvas.ExecuteClip(aMode = RGN_AND);

      FClipped := True;

      if aMode = RGN_COPY then
        SetScaling;

    end;

end;

procedure TppMetaGraphicsPDF.FillRect(aRect: TRect);
var
  liWidth: Integer;
  liHeight: Integer;
begin

  if FBrush.Style = bsClear then exit;

  liWidth := aRect.Right - aRect.Left;
  liHeight := aRect.Bottom - aRect.Top;

  FPDFCanvas.SelectBrush(FBrush);

  PDFBeginPath;
  FPDFCanvas.Rectangle(ConvertX(aRect.Left), ConvertY(aRect.Top), ConvertX(liWidth), ConvertY(liHeight));

  FPDFCanvas.ExecuteFill;

end;

procedure TppMetaGraphicsPDF.FinalizeShape;
var
  lbWindingFill: Boolean;
begin

  lbWindingFill :=  Windows.GetPolyFillMode(FRefCanvas.Handle) = 2;

  if (FBrush.Style = bsClear) and (FPen.Style <> psClear) then
    FPDFCanvas.ExecuteStroke
  else if (FBrush.Style <> bsClear) and (FPen.Style = psClear) then
    FPDFCanvas.ExecuteFill(lbWindingFill)
  else if (FBrush.Style <> bsClear) and (FPen.Style <> psClear) then
    FPDFCanvas.ExecuteStrokeAndFill(lbWindingFill);

end;

procedure TppMetaGraphicsPDF.FloodFill(aStartPoint: TPoint; aColor: TColor; aMode: Integer);
begin

  FPDFCanvas.ExecuteFill;

end;

function TppMetaGraphicsPDF.GetArcDirection: Integer;
begin
  RaiseNotImplementedException('GetArcDirection');
  Result := Windows.GetArcDirection(FRefCanvas.Handle);
end;

function TppMetaGraphicsPDF.GetBrush: TBrush;
begin
  Result := FBrush;
end;

function TppMetaGraphicsPDF.GetCopyMode: TCopyMode;
begin
  Result := FRefCanvas.CopyMode;
end;

function TppMetaGraphicsPDF.GetFont: TFont;
begin
  Result := FFont;
end;

function TppMetaGraphicsPDF.GetFontAngle: Integer;
begin
  Result := FFontAngle;

end;

function TppMetaGraphicsPDF.GetFontMapperFlags: Integer;
var
  lAspectRatio: TSize;
begin

  GetAspectRatioFilterEx(FRefCanvas.Handle, lAspectRatio);

  if (lAspectRatio.cx > 0) then
    Result := 1
  else
    Result := 0;

end;

function TppMetaGraphicsPDF.GetMapMode: Integer;
begin
  Result := Windows.GetMapMode(FRefCanvas.Handle);
end;

function TppMetaGraphicsPDF.GetPen: TPen;
begin
  Result := FPen;
end;

function TppMetaGraphicsPDF.GetPolyFillMode: Integer;
begin
  Result := Windows.GetPolyFillMode(FRefCanvas.Handle);
end;

function TppMetaGraphicsPDF.GetStretchBltMode: Integer;
begin
  Result := Windows.GetStretchBltMode(FRefCanvas.Handle);

end;

function TppMetaGraphicsPDF.GetTextAlignmentFlags: Cardinal;
begin
  Result := FTextAlignment;
end;

function TppMetaGraphicsPDF.GetTextColor: TColor;
begin
  Result := FTextColor;
end;

function TppMetaGraphicsPDF.GetTextFlags: Integer;
begin
  Result := FRefCanvas.TextFlags;
end;

procedure TppMetaGraphicsPDF.GradientFill(aRect: TRect; aStartColor, aEndColor: TColor; aMode: Integer);
var
  lBitmap: TBitmap;
begin

  lBitmap := TBitmap.Create;

  try
    lBitmap.Width := aRect.Right - aRect.Left;
    lBitmap.Height := aRect.Bottom - aRect.Top;

    {$IFDEF Delphi9}
    GraphUtil.GradientFillCanvas(lBitmap.Canvas, aStartColor, aEndColor, aRect, TGradientDirection(aMode));
    {$ELSE}
    ppGradientFillCanvas(lBitmap.Canvas, aStartColor, aEndColor, aRect, TppGradientDirection(aMode));
    {$ENDIF}

    Draw(aRect.Left, aRect.Top, lBitmap);

  finally
    lBitmap.Free;
  end;

end;

procedure TppMetaGraphicsPDF.InitializeView(aBoundsRect: TRect; aScaleX, aScaleY: Single);
begin
  if (aScaleX = 0) or (aScaleY = 0) then exit;

  FPDFCanvas.SelectScaling(aScaleX, aScaleY);
  //FPDFCanvas.SelectCoordintateSpace(ConvertX(aBoundsRect.Left), ConvertY(aBoundsRect.Top), ConvertY(aBoundsRect.Bottom - aBoundsRect.Top));
  FInitialScaleX := aScaleX;
  FInitialScaleY := aScaleY;

end;

procedure TppMetaGraphicsPDF.IntersectClipRect(aRect: TRect);
begin

  FPDFCanvas.SaveGraphicsState;

  FPDFCanvas.ClipRegion(ConvertX(aRect.Left), ConvertY(aRect.Top),
                        ConvertX(aRect.Right - aRect.Left), ConvertY(aRect.Bottom - aRect.Top));

  FPDFCanvas.ExecuteClip(False);

  FClipped := True;

end;

procedure TppMetaGraphicsPDF.LineTo(aX, aY: Integer);
begin

  FPDFCanvas.SelectPen(FPen);
  PDFBeginPath;
  FPDFCanvas.LineTo(ConvertX(aX), ConvertY(aY));
  FPDFCanvas.ExecuteStroke();

  // Set the MoveTo Cache to the line end location (necessary when drawing numerous lines sequentially).
  MoveTo(aX, aY);

end;

procedure TppMetaGraphicsPDF.MoveTo(aX, aY: Integer);
begin
  FMoveToCache := Point(aX, aY);

end;

procedure TppMetaGraphicsPDF.OffsetClipRegion(aX, aY: Integer);
begin
  RaiseNotImplementedException('OffsetClipRegion');
//  Windows.OffsetClipRgn(FRefCanvas.Handle, aX, aY);
end;

procedure TppMetaGraphicsPDF.Pie(aRect: TRect; aStartPoint, aEndPoint: TPoint);
begin
  FPDFCanvas.SelectPen(FPen);
  FPDFCanvas.SelectBrush(FBrush);

  PDFBeginPath;

  FPDFCanvas.Pie(ConvertX(aRect.Left), ConvertY(aRect.Top), ConvertX(aRect.Right), ConvertY(aRect.Bottom), ConvertX(aStartPoint.X), ConvertY(aStartPoint.Y), ConvertX(aEndPoint.X), ConvertY(aEndPoint.Y));
  FinalizeShape;

end;

procedure TppMetaGraphicsPDF.PolyBezier(const aPointArray: array of TPoint);
begin
  DrawPolyBezier(aPointArray, 1);

end;

procedure TppMetaGraphicsPDF.PolyBezierTo(const aPointArray: array of TPoint);
begin
  DrawPolyBezier(aPointArray, 0);

end;

procedure TppMetaGraphicsPDF.Polygon(const aPointArray: array of TPoint);
begin

  if FPen.Style = psClear then
    FPen.Color := FBrush.Color;

  FPDFCanvas.SelectPen(FPen);
  FPDFCanvas.SelectBrush(FBrush);

  PDFBeginPath;

  DrawPolygon(aPointArray);

  FPDFCanvas.CloseShape;

  FinalizeShape;

end;

procedure TppMetaGraphicsPDF.PolyLine(const aPointArray: array of TPoint);
var
  liIndex: Integer;
  liX: Integer;
  liY: Integer;
begin

  FPDFCanvas.SelectPen(FPen);

  PDFBeginPath;

  liX := aPointArray[0].X;
  liY := aPointArray[0].Y;

  FPDFCanvas.MoveTo(ConvertX(liX), ConvertY(liY));

  for liIndex := 1 to Length(aPointArray) - 1 do
    begin
      liX := aPointArray[liIndex].X;
      liY := aPointArray[liIndex].Y;
      FPDFCanvas.LineTo(ConvertX(liX), Converty(liY));
    end;

  FPDFCanvas.ExecuteStroke;

end;

procedure TppMetaGraphicsPDF.PolyLineTo(const aPointArray: array of TPoint);
var
  liIndex: Integer;
  liX: Integer;
  liY: Integer;
begin

  FPDFCanvas.SelectPen(FPen);

  PDFBeginPath;

  for liIndex := 0 to Length(aPointArray) - 1 do
    begin
      liX := aPointArray[liIndex].X;
      liY := aPointArray[liIndex].Y;
      FPDFCanvas.LineTo(ConvertX(liX), Converty(liY));
    end;

  FPDFCanvas.ExecuteStroke;

end;

procedure TppMetaGraphicsPDF.RaiseNotImplementedException(aMethodName: String);
begin

  raise EPrintError.Create('TppMetaGraphicsPDF.' + aMethodName + ' not implemented');
end;

procedure TppMetaGraphicsPDF.Rectangle(aRect: TRect);
var
  liWidth: Integer;
  liHeight: Integer;
begin

  liWidth := aRect.Right - aRect.Left;
  liHeight := aRect.Bottom - aRect.Top;

  if FPen.Style = psClear then
    FPen.Color := FBrush.Color;

  FPDFCanvas.SelectPen(FPen);
  FPDFCanvas.SelectBrush(FBrush);

  PDFBeginPath;
  FPDFCanvas.Rectangle(ConvertX(aRect.Left), ConvertY(aRect.Top), ConvertX(liWidth), ConvertY(liHeight));

  FinalizeShape;

end;

procedure TppMetaGraphicsPDF.RestoreDC;
begin
  FPDFCanvas.RestoreGraphicsState;
end;

procedure TppMetaGraphicsPDF.RoundRect(aRect: TRect; aCornerSize: TSize);
var
  liWidth: Integer;
  liHeight: Integer;
begin

  liWidth := aRect.Right - aRect.Left;
  liHeight := aRect.Bottom - aRect.Top;

  if FPen.Style = psClear then
    FPen.Color := FBrush.Color;

  FPDFCanvas.SelectPen(FPen);
  FPDFCanvas.SelectBrush(FBrush);

  PDFBeginPath;
  FPDFCanvas.RoundRectangle(ConvertX(aRect.Left), ConvertY(aRect.Top), ConvertX(liWidth), ConvertY(liHeight));

  FinalizeShape;

end;

procedure TppMetaGraphicsPDF.SaveDC;
begin
  FPDFCanvas.SaveGraphicsState;
end;

procedure TppMetaGraphicsPDF.SetArcDirection(const Value: Integer);
begin
  Windows.SetArcDirection(FRefCanvas.Handle, Value);

end;

procedure TppMetaGraphicsPDF.SetBkMode(aMode: Integer);
begin
// this is handled by the reader - sets brush.Style
//  Windows.SetBkMode(FRefCanvas.Handle, aMode);

end;

procedure TppMetaGraphicsPDF.SetBkColor(aColor: TColor);
begin
// this is handled by the reader - sets brush.Color
  FBackgroundColor := aColor;
end;

procedure TppMetaGraphicsPDF.SetBrush(const Value: TBrush);
begin
  FBrush.Assign(Value);
end;

procedure TppMetaGraphicsPDF.SetCopyMode(const Value: TCopyMode);
begin
  //TODO: RaiseNotImplementedException('SetCopyMode');
//  FCanvas.CopyMode := Value;
end;

procedure TppMetaGraphicsPDF.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TppMetaGraphicsPDF.SetFontMapperFlags(const Value: Integer);
begin
  SetMapperFlags(FRefCanvas.Handle, Value);
end;

procedure TppMetaGraphicsPDF.SetMapMode(const Value: Integer);
begin
  Windows.SetMapMode(FRefCanvas.Handle, Value);
end;

procedure TppMetaGraphicsPDF.SetPen(const Value: TPen);
begin
  FPen.Assign(Value);
end;

procedure TppMetaGraphicsPDF.SetPixelColor(aPoint: TPoint; aColor: TColor);
begin
  FPDFCanvas.SelectBrush(FBrush);

  PDFBeginPath;
  FPDFCanvas.Rectangle(ConvertX(aPoint.X), ConvertY(aPoint.Y), ConvertX(1), ConvertY(1));
  FPDFCanvas.ExecuteFill;

end;

procedure TppMetaGraphicsPDF.SetPolyFillMode(const Value: Integer);
begin
  Windows.SetPolyFillMode(FRefCanvas.Handle, Value);
end;

procedure TppMetaGraphicsPDF.SetStretchBltMode(const Value: Integer);
begin
  Windows.SetStretchBltMode(FRefCanvas.Handle, Value);
end;

procedure TppMetaGraphicsPDF.SetTextFlags(const Value: Integer);
begin
  FRefCanvas.TextFlags := Value;
end;

procedure TppMetaGraphicsPDF.SetBrushOrg(aPoint: TPoint);
begin
  Windows.SetBrushOrgEx(FRefCanvas.Handle, aPoint.X, aPoint.Y, nil);
end;

procedure TppMetaGraphicsPDF.SetScaling;
var
  lVPSize: TSize;
  lWESize: TSize;
begin

  //First restore the graphics state
  //FPDFCanvas.RestoreGraphicsState;

  Windows.GetViewportExtEx(FRefCanvas.Handle, lVPSize);
  Windows.GetWindowExtEx(FRefCanvas.Handle, lWESize);

  FPDFCanvas.SaveGraphicsState;

  FCurrentScaleX := FInitialScaleX * lVPSize.cx/lWESize.cx;
  FCurrentScaleY := FInitialScaleY * lVPSize.cy/lWESize.cy;
  FPDFCanvas.SelectScaling(FCurrentScaleX, FCurrentScaleY);

  //Check to see if the window origin has been set before this call.  Needs to carry over.
  if FWindowOrgAssigned then
    FPDFCanvas.SelectCoordintateSpace(ConvertX(-FWindowOrg.X), ConvertY(-FWindowOrg.Y), FPDFCanvas.PageHeight);

end;

procedure TppMetaGraphicsPDF.SetWindowExt(aExtent: TSize);
begin

  Windows.SetWindowExtEx(FRefCanvas.Handle, aExtent.cx, aExtent.cy, nil);

  FWindowExtAssigned := True;

  if FViewPortAssigned then
    begin
      FPDFCanvas.RestoreGraphicsState;
      SetScaling;
    end;

end;

procedure TppMetaGraphicsPDF.SetViewportExt(aExtent: TSize);
begin
  Windows.SetViewPortExtEx(FRefCanvas.Handle, aExtent.cx, aExtent.cy, nil);

  FViewPortAssigned := True;

  if FWindowExtAssigned then
    begin
      FPDFCanvas.RestoreGraphicsState;
      SetScaling;
    end;
end;

procedure TppMetaGraphicsPDF.SetViewportOrg(aPoint: TPoint);
begin
  Windows.SetViewPortOrgEx(FRefCanvas.Handle, aPoint.X, aPoint.Y, nil);
end;

procedure TppMetaGraphicsPDF.SetWindowOrg(aPoint: TPoint);
begin
  Windows.SetWindowOrgEx(FRefCanvas.Handle, aPoint.X, aPoint.Y, nil);

  FWindowOrgAssigned := True;
  FWindowOrg := aPoint;

  FPDFCanvas.SelectCoordintateSpace(ConvertX(-aPoint.X), ConvertY(-aPoint.Y), FPDFCanvas.PageHeight);
end;

procedure TppMetaGraphicsPDF.SetWorldTransform(aXForm: TXForm);
var
  lXForm: TXForm;
begin

  //First restore the graphics state
  //FPDFCanvas.RestoreGraphicsState;

  Windows.SetGraphicsMode(FRefCanvas.Handle, GM_ADVANCED);
  Windows.SetWorldTransform(FRefCanvas.Handle, aXForm);
  Windows.GetWorldTransform(FRefCanvas.Handle, lXForm);

  //FPDFCanvas.SaveGraphicsState;

  //FPDFCanvas.SelectWorldTransform(FCurrentScaleX * lXForm.eM11, FCurrentScaleY * lXForm.eM22, ConvertX(Trunc(lXForm.eDx)), ConvertY(Trunc(lXForm.eDy)));

  //Image Scale
  //FPDFCanvas.SelectScaling(FCurrentScaleX * aXForm.eM11, FCurrentScaleY * aXForm.eM22);

  //FPDFCanvas.SelectCoordintateSpace(ConvertX(Trunc(aXForm.eDx)), ConvertY(Trunc({Abs}(aXForm.eDy))), 0);

end;

procedure TppMetaGraphicsPDF.ModifyWorldTransform(aXForm: TXForm; aMode: Cardinal);
var
  lXForm: TXForm;
begin

  //First restore the graphics state
  //FPDFCanvas.RestoreGraphicsState;

  Windows.SetGraphicsMode(FRefCanvas.Handle, GM_ADVANCED);
  Windows.ModifyWorldTransform(FRefCanvas.Handle, aXForm, aMode);
  Windows.GetWorldTransform(FRefCanvas.Handle, lXForm);

  //FPDFCanvas.SaveGraphicsState;

  //FPDFCanvas.SelectWorldTransform(FCurrentScaleX * lXForm.eM11, FCurrentScaleY * lXForm.eM22, ConvertX(Trunc(lXForm.eDx)), ConvertY(Trunc(lXForm.eDy)));

  //Image Scale
  //FPDFCanvas.SelectScaling(FCurrentScaleX * lXForm.eM11, FCurrentScaleY * lXForm.eM22);

  //FPDFCanvas.SelectCoordintateSpace(ConvertX(Trunc(aXForm.eDx)), ConvertY(Trunc({Abs}(aXForm.eDy))), 0);

end;

procedure TppMetaGraphicsPDF.PolyPolygon(const aPointArray: array of TPoint; aPolyCountsArray: array of Integer);
var
  liIndex: Integer;
  liPolyCount: Integer;
  lPointArray: TppPointArray;
  liPosition: Integer;
begin

  liPolyCount := High(aPolyCountsArray) + 1;
  liPosition := 0;

{$IFNDEF Delphi9}
  // fix compiler warning in old Delphi versionss
  lPointArray := nil;
{$ENDIF}

  FPDFCanvas.SelectPen(FPen);
  FPDFCanvas.SelectBrush(FBrush);

  PDFBeginPath;

  for liIndex := 0 to liPolyCount - 1 do
    begin
      lPointArray := CreatePointArray(aPointArray, aPolyCountsArray[liIndex], liPosition);
      liPosition := liPosition + aPolyCountsArray[liIndex];
      DrawPolyGon(lPointArray);
    end;

  FPDFCanvas.CloseShape;

  FinalizeShape;
    
end;

function TppMetaGraphicsPDF.CreatePointArray(const aSourceArray: array of TPoint; aCount, aPosition: Integer): TppPointArray;
var
  liIndex: Integer;
begin

  SetLength(Result, aCount);

  for liIndex := 0 to aCount - 1 do
    begin
      Result[liIndex].X := aSourceArray[liIndex + aPosition].X;
      Result[liIndex].Y := aSourceArray[liIndex + aPosition].Y;
    end;

end;

procedure TppMetaGraphicsPDF.EndPath;
begin
  FPDFCanvas.SubPathOpen := False;
  FPDFCanvas.PathOpen := False;

end;

procedure TppMetaGraphicsPDF.StrokePath;
begin
  FPDFCanvas.ExecuteStroke;

end;

procedure TppMetaGraphicsPDF.FillPath;
var
  lbWindingFill: Boolean;
begin

  lbWindingFill :=  Windows.GetPolyFillMode(FRefCanvas.Handle) = 2;

  FPDFCanvas.ExecuteFill(lbWindingFill);

end;

procedure TppMetaGraphicsPDF.SelectClipPath(aMode: Integer);
begin
  // TODO: Windows.SelectClipPath(FCanvas.Handle, aMode);
end;

procedure TppMetaGraphicsPDF.SetFontAngle(const Value: Integer);
begin
  FFontAngle := Trunc(Value / 10);

end;

procedure TppMetaGraphicsPDF.SetMetaRgn;
begin
  // TODO:  Windows.SetMetaRgn(FCanvas.Handle);
end;

procedure TppMetaGraphicsPDF.SetTextAlignmentFlags(const Value: Cardinal);
begin
  FTextAlignment := Value;
end;

procedure TppMetaGraphicsPDF.SetTextColor(const Value: TColor);
begin
  FTextColor := Value;
end;

procedure TppMetaGraphicsPDF.StretchDraw(aRect: TRect; aBitmap: TBitmap);
begin

  FPDFCanvas.SaveGraphicsState;
  FPDFCanvas.StretchDraw(ConvertX(aRect.Left){/FCurrentScaleX}, ConvertY(aRect.Top){/FCurrentScaleY}, ConvertX(aRect.Right){/FCurrentScaleX}, ConvertY(aRect.Bottom){/FCurrentScaleY}, aBitmap);
  FPDFCanvas.RestoreGraphicsState;

end;

procedure TppMetaGraphicsPDF.TextRect(aRect: TRect; aX, aY: Integer; aText: String; aSpacingArray: array of Integer);
var
  lOrigin: TPoint;
begin

  FPDFCanvas.SaveGraphicsState;

  //Clip text
  if ((FRefCanvas.TextFlags and ETO_CLIPPED) > 0)  then
    begin
      FPDFCanvas.ClipRegion(ConvertX(aRect.Left), ConvertY(aRect.Top), ConvertX(aRect.Right - aRect.Left), ConvertY(aRect.Bottom - aRect.Top));
      FPDFCanvas.ExecuteClip;
    end;

  //Highlight Text
  if ((FRefCanvas.TextFlags and ETO_OPAQUE) > 0) then
    begin
      FPen.Style := psClear;
      FBrush.Color := FBackgroundColor;
      Rectangle(Rect(aRect.Left, aRect.Top, aRect.Right, aRect.Bottom));
    end;


  FFont.Color := FTextColor;
  FPDFCanvas.SelectFont(FFont);

  //Rotate Text
  if FFontAngle <> 0 then
    begin
      lOrigin := AdjustRotatedText(aRect.Left, aRect.Top, aRect.Right - aRect.Left, aRect.Bottom - aRect.Top, FFontAngle);
      FPDFCanvas.TextOut(ConvertX(lOrigin.X), ConvertY(lOrigin.Y), aText, FFontAngle);
    end
  else
    begin
      if (FTextAlignment = 0) {or (FTextAlignment = TA_BASELINE)} then
        FPDFCanvas.TextOut(ConvertX(aX), ConvertY(aY), aText, aSpacingArray)
      else
        FPDFCanvas.TextOut(ConvertX(aRect.Left), ConvertY(aRect.Top), aText, aSpacingArray);
    end;

  FPDFCanvas.RestoreGraphicsState;

end;

end.
