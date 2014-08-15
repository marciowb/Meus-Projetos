{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppMetaGraphics;

interface

{$I ppIfDef.pas}

uses
  Classes,
  SysUtils,
  Windows,
  Graphics,
  GraphUtil,

  ppDevice,
  ppDrwCmd,

  ppInterfacedObject;

type


  {IppMetaGraphics}
  IppMetaGraphics = interface(IInterface)

    // prop getter/setters
    function GetArcDirection: Integer;
    function GetBrush: TBrush;
//    function GetCanvas: TCanvas;
    function GetCopyMode: TCopyMode;
    function GetFont: TFont;
    function GetFontAngle: Integer;
    function GetFontMapperFlags: Integer;
    function GetMapMode: Integer;
    function GetPen: TPen;
    function GetPolyFillMode: Integer;
    function GetStretchBltMode: Integer;
    function GetTextAlignmentFlags: Cardinal;
    function GetTextColor: TColor; 
    function GetTextFlags: Integer;

    procedure SetArcDirection(const Value: Integer);
    procedure SetBrush(const Value: TBrush);
    procedure SetCopyMode(const Value: TCopyMode);
    procedure SetFont(const Value: TFont);
    procedure SetFontAngle(const Value: Integer);
    procedure SetFontMapperFlags(const Value: Integer);
    procedure SetMapMode(const Value: Integer);
    procedure SetPen(const Value: TPen);
    procedure SetPolyFillMode(const Value: Integer);
    procedure SetTextAlignmentFlags(const Value: Cardinal); 
    procedure SetTextFlags(const Value: Integer);
    procedure SetStretchBltMode(const Value: Integer);

    // state/environment settings
    procedure ExtSelectClipRgn(aRgn: HRGN; aRgnData: PRgnData; aMode: Integer; aRectArray: array of TRect);
    procedure IntersectClipRect(aRect: TRect);
    procedure ModifyWorldTransform(aXForm: TXForm; aMode: Cardinal);
    procedure OffsetClipRegion(aX, aY: Integer);
    procedure RestoreDC;
    procedure SaveDC;
    procedure SetBrushOrg(aPoint: TPoint);
    procedure SetBkMode(aMode: Integer);
    procedure SetBkColor(aColor: TColor);
    procedure SetMetaRgn;
    procedure SetPixelColor(aPoint: TPoint; aColor: TColor);
    procedure InitializeView(aBoundsRect: TRect; aScaleX, aScaleY: Single);
    procedure SelectClipPath(aMode: Integer);
    procedure SetTextColor(const Value: TColor); 
    procedure SetViewportExt(aExtent: TSize);
    procedure SetViewportOrg(aPoint: TPoint);
    procedure SetWindowExt(aExtent: TSize);
    procedure SetWindowOrg(aPoint: TPoint);
    procedure SetWorldTransform(aXForm: TXForm);

    // drawing methods
    procedure AngleArc(aCenterPoint: TPoint; aRadius: Integer; aStartAngle, aSweepAngle: Double);
    procedure Arc(aRect: TRect; aStartPoint, aEndPoint: TPoint);
    procedure BeginPath;
    procedure CloseFigure;
    procedure Chord(aRect: TRect; aStartPoint, aEndPoint: TPoint);
    procedure Draw(aX, aY: Integer; aBitmap: TBitmap);
    procedure StretchDraw(aRect: TRect; aBitmap: TBitmap);
    procedure EndPath;
    procedure Ellipse(aRect: TRect);
    procedure FillPath;
    procedure FillRect(aRect: TRect);
    procedure FloodFill(aStartPoint: TPoint; aColor: TColor; aMode: Integer);
    procedure GradientFill(aRect: TRect; aStartColor: TColor; aEndColor: TColor; aMode: Integer);
    procedure LineTo(aX, aY: Integer);
    procedure MoveTo(aX, aY: Integer);
    procedure PatBlt(aRect: TRect; aMode: Cardinal);
    procedure Pie(aRect: TRect; aStartPoint, aEndPoint: TPoint);
    procedure PolyBezier(const aPointArray: array of TPoint);
    procedure PolyBezierTo(const aPointArray: array of TPoint);
    procedure Polygon(const aPointArray: array of TPoint);
    procedure PolyLine(const aPointArray: array of TPoint);
    procedure PolyLineTo(const aPointArray: array of TPoint);
    procedure PolyPolygon(const aPointArray: array of TPoint; aPolyCountsArray: array of Integer);
    procedure Rectangle(aRect: TRect);
    procedure RoundRect(aRect: TRect; aCornerSize: TSize);
    procedure TextRect(aRect: TRect; aX, aY: Integer; aText: String; aSpacingArray: array of Integer);

    property ArcDirection: Integer read GetArcDirection write SetArcDirection;
    property Brush: TBrush read GetBrush write SetBrush;
//    property Canvas: TCanvas read GetCanvas;
    property CopyMode: TCopyMode read GetCopyMode write SetCopyMode;
    property Font: TFont read GetFont write SetFont;
    property FontAngle: Integer read GetFontAngle write SetFontAngle;
    property FontMapperFlags: Integer read GetFontMapperFlags write SetFontMapperFlags;
    property MapMode: Integer read GetMapMode write SetMapMode;
    property Pen: TPen read GetPen write SetPen;
    property PolyFillMode: Integer read GetPolyFillMode write SetPolyFillMode;
    property StretchBltMode: Integer read GetStretchBltMode write SetStretchBltMode;
    property TextAlignmentFlags: Cardinal read GetTextAlignmentFlags write SetTextAlignmentFlags;
    property TextColor: TColor read GetTextColor write SetTextColor;
    property TextFlags: Integer read GetTextFlags write SetTextFlags;

  end;

  {TppCanvasMetaGraphics}
  TppCanvasMetaGraphics = class(TppInterfacedObject, IppMetaGraphics)
  private

    FCanvas: TCanvas;
    FSaveDC: THandle;
    FTextColor: TColor;
    FViewScaleX: Single;
    FViewScaleY: Single;
    FViewOrgX: Single;
    FViewOrgY: Single;
//    FViewXForm: Windows.XFORM;

  protected
    property Canvas: TCanvas read FCanvas;
    property TextColor: TColor read FTextColor;

  public
    constructor Create(aCanvas: TCanvas); virtual;
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
    function GetTextColor: TColor;
    function GetTextFlags: Integer;

    // prop setters
    procedure SetArcDirection(const Value: Integer);
    procedure SetBrush(const Value: TBrush);
    procedure SetCopyMode(const Value: TCopyMode);
    procedure ExtSelectClipRgn(aRgn: HRGN; aRgnData: PRgnData; aMode: Integer; aRectArray: array of TRect);
    procedure IntersectClipRect(aRect: TRect);
    procedure SelectClipPath(aMode: Integer);
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
    procedure RestoreDC; virtual;
    procedure SaveDC; virtual;
    procedure SetBkMode(aMode: Integer);  virtual;
    procedure SetBrushOrg(aPoint: TPoint); virtual;
    procedure SetMetaRgn; virtual;
    procedure InitializeView(aBoundsRect: TRect; aScaleX, aScaleY: Single); virtual;
    procedure SetViewportExt(aExtent: TSize); virtual;
    procedure SetViewportOrg(aPoint: TPoint); virtual;
    procedure SetWindowExt(aExtent: TSize); virtual;
    procedure SetWindowOrg(aPoint: TPoint); virtual;

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
    procedure FillRect(aRect: TRect); virtual;
    procedure FloodFill(aStartPoint: TPoint; aColor: TColor; aMode: Integer); virtual;
    procedure GradientFill(aRect: TRect; aStartColor: TColor; aEndColor: TColor; aMode: Integer); virtual;
    procedure LineTo(aX, aY: Integer); virtual;
    procedure ModifyWorldTransform(aXForm: TXForm; aMode: Cardinal);
    procedure MoveTo(aX, aY: Integer); virtual;
    procedure TextRect(aRect: TRect; aX, aY: Integer; aText: String; aSpacingArray: array of Integer); virtual;
    procedure PatBlt(aRect: TRect; aMode: Cardinal); virtual;
    procedure Pie(aRect: TRect; aStartPoint, aEndPoint: TPoint); virtual;
    procedure PolyBezier(const aPointArray: array of TPoint); virtual;
    procedure PolyBezierTo(const aPointArray: array of TPoint); virtual;
    procedure Polygon(const aPointArray: array of TPoint); virtual;
    procedure PolyPolygon(const aPointArray: array of TPoint; aPolyCountsArray: array of Integer); virtual;
    procedure PolyLine(const aPointArray: array of TPoint); virtual;
    procedure PolyLineTo(const aPointArray: array of TPoint); virtual;
    procedure Rectangle(aRect: TRect); virtual;
    procedure RoundRect(aRect: TRect; aCornerSize: TSize); virtual;
    procedure SetBkColor(aColor: TColor); virtual;
    procedure SetPixelColor(aPoint: TPoint; aColor: TColor); virtual;
    procedure SetWorldTransform(aXForm: TXForm);
    procedure StretchDraw(aRect: TRect; aBitmap: TBitmap);

  end;


  {TppDrawCommandMetaGraphics}
  TppDrawCommandMetaGraphics = class(TppCanvasMetaGraphics)
  private
    FBitmap: TBitmap;
    FDrawCommands: TList;
    FScaleX: Single;
    FScaleY: Single;
  public
    constructor Create(aCanvas: TCanvas); overload; override;
    destructor Destroy; override;

    procedure InitializeView(aBoundsRect: TRect; aScaleX, aScaleY: Single); override;

    procedure TextRect(aRect: TRect; aX, aY: Integer; aText: String; aSpacingArray: array of Integer); override;

    property DrawCommands: TList read FDrawCommands;

  end;


  TppMetaFileToDrawCommandConverter = class
  protected
    class function ScreenPixelsPerMM: Single;
  public
    class procedure Convert(aMetaFile: TMetafile; var aDrawCommands: TList);
  end;



implementation

uses
  ppUtils,
  ppTypes,

  ppMetaFileReader;

type
  PPoints = ^TPoints;
  TPoints = array[0..0] of TPoint;
  PIntegers = ^TIntegers;
  TIntegers = array[0..0] of Integer;


procedure TppCanvasMetaGraphics.AngleArc(aCenterPoint: TPoint; aRadius: Integer; aStartAngle, aSweepAngle: Double);
begin
  Windows.AngleArc(FCanvas.Handle, aCenterPoint.X, aCenterPoint.Y, aRadius, aStartAngle, aSweepAngle);
end;

procedure TppCanvasMetaGraphics.Arc(aRect: TRect; aStartPoint, aEndPoint: TPoint);
begin
  FCanvas.Arc(aRect.Left, aRect.Top, aRect.Right, aRect.Top, aStartPoint.X, aStartPoint.Y, aEndPoint.X, aEndPoint.Y);

end;

procedure TppCanvasMetaGraphics.Chord(aRect: TRect; aStartPoint, aEndPoint: TPoint);
begin
  FCanvas.Chord(aRect.Left, aRect.Top, aRect.Right, aRect.Top, aStartPoint.X, aStartPoint.Y, aEndPoint.X, aEndPoint.Y);

end;

constructor TppCanvasMetaGraphics.Create(aCanvas: TCanvas);
begin
  inherited Create;

  FCanvas := aCanvas;


end;

destructor TppCanvasMetaGraphics.Destroy;
begin
  inherited;

end;

procedure TppCanvasMetaGraphics.BeginPath;
begin
  Windows.BeginPath(FCanvas.Handle);

end;

procedure TppCanvasMetaGraphics.CloseFigure;
begin
  Windows.CloseFigure(FCanvas.Handle);
end;

procedure TppCanvasMetaGraphics.Draw(aX, aY: Integer; aBitmap: TBitmap);
begin
  FCanvas.Draw(aX, aY, aBitmap);
end;

procedure TppCanvasMetaGraphics.Ellipse(aRect: TRect);
begin
  FCanvas.Ellipse(aRect);
end;

procedure TppCanvasMetaGraphics.EndPath;
begin
  Windows.EndPath(FCanvas.Handle);
end;

procedure TppCanvasMetaGraphics.ExtSelectClipRgn(aRgn: HRGN; aRgnData: PRgnData; aMode: Integer; aRectArray: array of TRect);
begin
  Windows.ExtSelectClipRgn(FCanvas.Handle, aRgn, aMode);
end;

procedure TppCanvasMetaGraphics.FillPath;
begin
  Windows.FillPath(FCanvas.Handle);
end;

procedure TppCanvasMetaGraphics.FillRect(aRect: TRect);
begin
  FCanvas.FillRect(aRect);
end;

procedure TppCanvasMetaGraphics.FloodFill(aStartPoint: TPoint; aColor: TColor; aMode: Integer);
begin
  FCanvas.FloodFill(aStartPoint.X, aStartPoint.Y, aColor, TFillStyle(aMode));
end;

function TppCanvasMetaGraphics.GetArcDirection: Integer;
begin
  Result := Windows.GetArcDirection(FCanvas.Handle);
end;

function TppCanvasMetaGraphics.GetBrush: TBrush;
begin
  Result := FCanvas.Brush;
end;

function TppCanvasMetaGraphics.GetCopyMode: TCopyMode;
begin
  Result := FCanvas.CopyMode;
end;

function TppCanvasMetaGraphics.GetFont: TFont;
begin
  Result := FCanvas.Font;
end;

function TppCanvasMetaGraphics.GetFontAngle: Integer;
begin
  // do nothing - not needed by TCanvas
  Result := 0;
end;

function TppCanvasMetaGraphics.GetFontMapperFlags: Integer;
var
  lAspectRatio: TSize;
begin

  GetAspectRatioFilterEx(FCanvas.Handle, lAspectRatio);

  if (lAspectRatio.cx > 0) then
    Result := 1
  else
    Result := 0;

end;

function TppCanvasMetaGraphics.GetMapMode: Integer;
begin
  Result := Windows.GetMapMode(FCanvas.Handle);
end;

function TppCanvasMetaGraphics.GetPen: TPen;
begin
  Result := FCanvas.Pen;
end;

function TppCanvasMetaGraphics.GetPolyFillMode: Integer;
begin
  Result := Windows.GetPolyFillMode(FCanvas.Handle);
end;

function TppCanvasMetaGraphics.GetStretchBltMode: Integer;
begin
  Result := Windows.GetStretchBltMode(FCanvas.Handle);         

end;

function TppCanvasMetaGraphics.GetTextAlignmentFlags: Cardinal;
begin
  Result := Windows.GetTextAlign(FCanvas.Handle);
end;

function TppCanvasMetaGraphics.GetTextColor: TColor;
begin
  Result := FTextColor;
end;

function TppCanvasMetaGraphics.GetTextFlags: Integer;
begin
  Result := FCanvas.TextFlags;
end;

procedure TppCanvasMetaGraphics.GradientFill(aRect: TRect; aStartColor, aEndColor: TColor; aMode: Integer);
begin
  {$IFDEF Delphi9}
  GraphUtil.GradientFillCanvas(FCanvas, aStartColor, aEndColor, aRect, TGradientDirection(aMode));
  {$ELSE}
  ppGradientFillCanvas(FCanvas, aStartColor, aEndColor, aRect, TppGradientDirection(aMode));
  {$ENDIF}

end;

procedure TppCanvasMetaGraphics.LineTo(aX, aY: Integer);
begin
  FCanvas.LineTo(aX, aY);
end;

procedure TppCanvasMetaGraphics.ModifyWorldTransform(aXForm: TXForm; aMode: Cardinal);
begin
  Windows.SetGraphicsMode(FCanvas.Handle, GM_ADVANCED);
  Windows.ModifyWorldTransform(FCanvas.Handle, aXForm, aMode);
end;

procedure TppCanvasMetaGraphics.MoveTo(aX, aY: Integer);
begin
  FCanvas.MoveTo(aX, aY);
end;

procedure TppCanvasMetaGraphics.OffsetClipRegion(aX, aY: Integer);
begin
  Windows.OffsetClipRgn(FCanvas.Handle, aX, aY);
end;

procedure TppCanvasMetaGraphics.PatBlt(aRect: TRect; aMode: Cardinal);
begin
  Windows.PatBlt(FCanvas.Handle, aRect.Left, aRect.Top, aRect.Right - aRect.Left, aRect.Bottom - aRect.Top, aMode);

end;

procedure TppCanvasMetaGraphics.Pie(aRect: TRect; aStartPoint, aEndPoint: TPoint);
begin
  FCanvas.Pie(aRect.Left, aRect.Top, aRect.Right, aRect.Top, aStartPoint.X, aStartPoint.Y, aEndPoint.X, aEndPoint.Y);

end;

procedure TppCanvasMetaGraphics.PolyBezier(const aPointArray: array of TPoint);
begin
  FCanvas.PolyBezier(aPointArray);
end;

procedure TppCanvasMetaGraphics.PolyBezierTo(const aPointArray: array of TPoint);
begin
  FCanvas.PolyBezierTo(aPointArray);
end;

procedure TppCanvasMetaGraphics.Polygon(const aPointArray: array of TPoint);
begin
  FCanvas.Polygon(aPointArray);

end;

procedure TppCanvasMetaGraphics.PolyLine(const aPointArray: array of TPoint);
begin
  FCanvas.PolyLine(aPointArray);
end;

procedure TppCanvasMetaGraphics.PolyLineTo(const aPointArray: array of TPoint);
begin
  Windows.PolyLineTo(FCanvas.Handle, aPointArray, Length(aPointArray))
end;

procedure TppCanvasMetaGraphics.Rectangle(aRect: TRect);
begin
  FCanvas.Rectangle(aRect);
end;

procedure TppCanvasMetaGraphics.RestoreDC;
begin
  Windows.RestoreDC(FCanvas.Handle, FSaveDC);
end;

procedure TppCanvasMetaGraphics.RoundRect(aRect: TRect; aCornerSize: TSize);
begin
  FCanvas.RoundRect(aRect.Left, aRect.Top, aRect.Right, aRect.Bottom, aCornerSize.cx, aCornerSize.cy);
end;

procedure TppCanvasMetaGraphics.SaveDC;
begin
  FSaveDC := Windows.SaveDC(FCanvas.Handle);

end;

procedure TppCanvasMetaGraphics.SetArcDirection(const Value: Integer);
begin
  Windows.SetArcDirection(FCanvas.Handle, Value);
end;

procedure TppCanvasMetaGraphics.SetBkMode(aMode: Integer);
begin
  Windows.SetBkMode(FCanvas.Handle, aMode)
end;

procedure TppCanvasMetaGraphics.SetBkColor(aColor: TColor);
begin
  Windows.SetBkColor(FCanvas.Handle, aColor);
end;

procedure TppCanvasMetaGraphics.SetBrush(const Value: TBrush);
begin
  FCanvas.Brush := Value;
end;

procedure TppCanvasMetaGraphics.SetCopyMode(const Value: TCopyMode);
begin
  FCanvas.CopyMode := Value;
end;

procedure TppCanvasMetaGraphics.SetFont(const Value: TFont);
begin
  FCanvas.Font := Value;
end;

procedure TppCanvasMetaGraphics.SetFontAngle(const Value: Integer);
begin
  // do nothing - not needed by TCanvas
end;

procedure TppCanvasMetaGraphics.SetFontMapperFlags(const Value: Integer);
begin
  SetMapperFlags(FCanvas.Handle, Value);
end;

procedure TppCanvasMetaGraphics.SetMapMode(const Value: Integer);
begin
  Windows.SetMapMode(FCanvas.Handle, Value);
end;

procedure TppCanvasMetaGraphics.SetMetaRgn;
begin
  Windows.SetMetaRgn(FCanvas.Handle);
end;

procedure TppCanvasMetaGraphics.SetPen(const Value: TPen);
begin
  FCanvas.Pen := Value;
end;

procedure TppCanvasMetaGraphics.SetPixelColor(aPoint: TPoint; aColor: TColor);
begin
  FCanvas.Pixels[aPoint.X, aPoint.Y] := aColor;
end;

procedure TppCanvasMetaGraphics.SetPolyFillMode(const Value: Integer);
begin
  Windows.SetPolyFillMode(FCanvas.Handle, Value);
end;


procedure TppCanvasMetaGraphics.InitializeView(aBoundsRect: TRect; aScaleX, aScaleY: Single);
var
//  lXForm: Windows.TXForm;
  lSize: TSize;
  lPoint: TPoint;
begin


  lSize.cx := aBoundsRect.Right - aBoundsRect.Left;
  lSize.cy := aBoundsRect.Bottom - aBoundsRect.Top;

  SetMapMode(MM_ANISOTROPIC);
  SetWindowExt(lSize);

  lSize.cx := Round(lSize.cx * aScaleX);
  lSize.cy := Round(lSize.cy * aScaleY);

//  SetViewportExt(lSize);
  SetViewPortExtEx(FCanvas.Handle, lSize.cx, lSize.cy, nil);

  lPoint.X := -Round(aBoundsRect.Left * aScaleX);
  lPoint.Y := -Round(aBoundsRect.Top * aScaleY);

  SetViewPortOrgEx(FCanvas.Handle, lPoint.X, lPoint.Y, nil);

  // do this last
//  FViewScaleX := aScaleX;
//  FViewScaleY := aScaleY;
//  FViewOrgX := -aBoundsRect.Left * aScaleX;
//  FViewOrgY := -aBoundsRect.Top * aScaleY;

end;


procedure TppCanvasMetaGraphics.IntersectClipRect(aRect: TRect);
begin
  Windows.IntersectClipRect(FCanvas.Handle, aRect.Left, aRect.Top, aRect.Right, aRect.Bottom);

end;

{$IFDEF Old}

procedure TppCanvasMetaGraphics.InitializeView(aBoundsRect: TRect; aScaleX, aScaleY: Single);
var
  lXForm: Windows.TXForm;
  lSize: TSize;
begin

  FViewScaleX := 0;
  FViewScaleY := 0;
  FViewOrgX := 0;
  FViewOrgY := 0;

  if Win32Platform = VER_PLATFORM_WIN32_NT then
    begin
      lXForm.eM11 := aScaleX;
      lXForm.eM12 := 0;
      lXForm.em21 := 0;
      lXForm.eM22 := aScaleY;
      lXForm.eDx := -aBoundsRect.Left;
      lXForm.eDy := -aBoundsRect.Top;

      SetWorldTransform(lXForm);
    end
  else 
    begin

      lSize.cx := aBoundsRect.Right - aBoundsRect.Left;
      lSize.cy := aBoundsRect.Bottom - aBoundsRect.Top;

      SetMapMode(MM_ANISOTROPIC);
      SetWindowExt(lSize);

      lSize.cx := Round(lSize.cx * aScaleX);
      lSize.cy := Round(lSize.cy * aScaleY);

      SetViewportExt(lSize);

    end;

  // do this last
  FViewScaleX := aScaleX;
  FViewScaleY := aScaleY;
  FViewOrgX := -aBoundsRect.Left * aScaleX;
  FViewOrgY := -aBoundsRect.Top * aScaleY;

end;

{$ENDIF}


procedure TppCanvasMetaGraphics.PolyPolygon(const aPointArray: array of TPoint; aPolyCountsArray: array of Integer);
begin

  Windows.PolyPolygon(FCanvas.Handle, PPoints(@aPointArray)^, PIntegers(@aPolyCountsArray)^, High(aPolyCountsArray) + 1);

end;

procedure TppCanvasMetaGraphics.SelectClipPath(aMode: Integer);
begin
  Windows.SelectClipPath(FCanvas.Handle, aMode);
end;

procedure TppCanvasMetaGraphics.SetStretchBltMode(const Value: Integer);
begin
  Windows.SetStretchBltMode(FCanvas.Handle, Value);
end;

procedure TppCanvasMetaGraphics.SetTextFlags(const Value: Integer);
begin
  FCanvas.TextFlags := Value;
end;


procedure TppCanvasMetaGraphics.SetBrushOrg(aPoint: TPoint);
begin
  SetBrushOrgEx(FCanvas.Handle, aPoint.X, aPoint.Y, nil);
end;

procedure TppCanvasMetaGraphics.SetTextAlignmentFlags(const Value: Cardinal);
begin
  Windows.SetTextAlign(FCanvas.Handle, Value)
end;

procedure TppCanvasMetaGraphics.SetTextColor(const Value: TColor);
begin
  FTextColor := Value;
end;

procedure TppCanvasMetaGraphics.SetWindowExt(aExtent: TSize);
begin
  SetWindowExtEx(FCanvas.Handle, aExtent.cx, aExtent.cy, nil);

end;

procedure TppCanvasMetaGraphics.SetViewportExt(aExtent: TSize);
begin
  SetViewPortExtEx(FCanvas.Handle, aExtent.cx, aExtent.cy, nil);
end;

procedure TppCanvasMetaGraphics.SetViewportOrg(aPoint: TPoint);
begin
  SetViewPortOrgEx(FCanvas.Handle, aPoint.X, aPoint.Y, nil);
end;

procedure TppCanvasMetaGraphics.SetWindowOrg(aPoint: TPoint);
begin
  SetWindowOrgEx(FCanvas.Handle, aPoint.X, aPoint.Y, nil);
end;

procedure TppCanvasMetaGraphics.SetWorldTransform(aXForm: TXForm);
//var
//  lXForm: Windows.TXForm;
//  lXForm3: Windows.TXForm;
//  lSize: TSize;
begin

{  if (FViewScaleX > 0) then
begin
      lXForm.eM11 := FViewScaleX;
      lXForm.eM12 := 0;
      lXForm.em21 := 0;
      lXForm.eM22 := FViewScaleY;
      lXForm.eDx := 0;
      lXForm.eDy := 0;

      Windows.CombineTransform(lXForm3, aXForm, lXForm)


    end
  else
    lXForm3 := aXForm;
}

  if (FViewScaleX > 0) then
    aXForm.eM11 := aXForm.eM11 * FViewScaleX;

  if (FViewScaleY > 0) then
    aXForm.eM22 := aXForm.eM22 * FViewScaleY;

  if (FViewOrgX <> 0) then
    aXForm.eDx := aXForm.eDx + FViewOrgX;

  if (FViewOrgY <> 0) then
    aXForm.eDy := aXForm.eDy + FViewOrgY;

  Windows.SetGraphicsMode(FCanvas.Handle, GM_ADVANCED);
  Windows.SetWorldTransform(FCanvas.Handle, aXForm);


end;

procedure TppCanvasMetaGraphics.StretchDraw(aRect: TRect; aBitmap: TBitmap);
begin
  FCanvas.StretchDraw(aRect, aBitmap);
end;

procedure TppCanvasMetaGraphics.TextRect(aRect: TRect; aX, aY: Integer; aText: String; aSpacingArray: array of Integer);
begin

  FCanvas.Font.Color := FTextColor;

 if Length(aSpacingArray) > 0 then

   Windows.ExtTextOut(FCanvas.Handle, aX, aY, FCanvas.TextFlags, @aRect, PChar(aText), Length(aText), @aSpacingArray)

  // check text flags to determine whether aRect is being specified/used
  else if ((FCanvas.TextFlags and ETO_CLIPPED) > 0) or ((FCanvas.TextFlags and ETO_OPAQUE) > 0)  then
    FCanvas.TextRect(aRect, aX, aY, aText)
  else
    FCanvas.TextOut(aX, aY, aText);

end;

constructor TppDrawCommandMetaGraphics.Create(aCanvas: TCanvas);
begin

  FBitmap := TBitmap.Create;

  inherited Create(FBitmap.Canvas);

  FDrawCommands := TList.Create;

end;

destructor TppDrawCommandMetaGraphics.Destroy;
begin

  inherited;

  FBitmap.Free;
  FBitmap := nil;

  FDrawCommands.Free;
  FDrawCommands := nil;

end;

procedure TppDrawCommandMetaGraphics.InitializeView(aBoundsRect: TRect; aScaleX, aScaleY: Single);
var
  lSize: TSize;
begin

  inherited;

  FScaleX := aScaleX;
  FScaleY := aScaleY;

  lSize.cx := aBoundsRect.Right - aBoundsRect.Left;
  lSize.cy := aBoundsRect.Bottom - aBoundsRect.Top;

  FBitmap.Width := Round(lSize.cx * aScaleX);
  FBitmap.Height := Round(lSize.cy * aScaleY);


end;

procedure TppDrawCommandMetaGraphics.TextRect(aRect: TRect; aX, aY: Integer; aText: String; aSpacingArray: array of Integer);
var
  lDrawText: TppDrawText;
  lTextMetric: TTextMetric;
begin

  if aText = '' then Exit;

  inherited;

  lDrawText := TppDrawText.Create(nil);
  lDrawText.Font := FCanvas.Font;
  lDrawText.Text := aText;

   if ((FCanvas.TextFlags and ETO_CLIPPED) > 0) or ((FCanvas.TextFlags and ETO_OPAQUE) > 0)  then
     begin
      lDrawText.Left := ppToMMThousandths(aRect.Left, utScreenPixels, pprtHorizontal, nil);
      lDrawText.Top := ppToMMThousandths(aRect.Top, utScreenPixels, pprtVertical, nil);
      lDrawText.Width := ppToMMThousandths(aRect.Right, utScreenPixels, pprtHorizontal, nil) - lDrawText.Left;
      lDrawText.Height := ppToMMThousandths(aRect.Bottom, utScreenPixels, pprtVertical, nil) - lDrawText.Top;

     end
   else
     begin
      lDrawText.Left := ppToMMThousandths(aX, utScreenPixels, pprtHorizontal, nil);
      lDrawText.Top := ppToMMThousandths(aY, utScreenPixels, pprtVertical, nil);
      lDrawText.Width := FCanvas.TextWidth(aText);
      lDrawText.Height := Abs(FCanvas.Font.Height);

      // add internal leading
      GetTextMetrics(FCanvas.Handle, lTextMetric);
      lDrawText.Height := lDrawText.Height + lTextMetric.tmInternalLeading ;


      lDrawText.Width := ppToMMThousandths(lDrawText.Width, utScreenPixels, pprtHorizontal, nil);
      lDrawText.Height := ppToMMThousandths(lDrawText.Height, utScreenPixels, pprtVertical, nil);

     end;

  // scale
  lDrawText.Left := Round(lDrawText.Left * FScaleX);
  lDrawText.Width := Round(lDrawText.Width * FScaleX);

  lDrawText.Top := Round(lDrawText.Top * FScaleY);
  lDrawText.Height := Round(lDrawText.Height * FScaleY);
  lDrawText.Font.Height := Round(lDrawText.Font.Height * FScaleY);

  FDrawCommands.Add(lDrawText);

end;

class procedure TppMetaFileToDrawCommandConverter.Convert(aMetaFile: TMetafile; var aDrawCommands: TList);
var
  lMetaFileReader: TppMetaFileReader;
  lMetaGraphics: TppDrawCommandMetaGraphics;
  lMetaRect: TRect;
  lMetaPixelsPerMM:Single;
  lScale: Single;
begin

  lMetaPixelsPerMM := aMetaFile.Width * 100 / aMetaFile.MMWidth;

  lScale := ScreenPixelsPerMM / lMetaPixelsPerMM;

  lMetaRect.TopLeft := Point(0,0);
  lMetaRect.Right := Round(aMetaFile.Width * lScale);
  lMetaRect.Bottom := Round(aMetaFile.Height * lScale);

  // create metagraphics
  lMetaGraphics := TppDrawCommandMetaGraphics.Create(nil);

  // create metafile reader
  lMetaFileReader := TppMetaFileReader.Create;
  lMetaFileReader.Metafile := aMetaFile;

  // translate metafile records to draw commands
  lMetaFileReader.Execute(lMetaGraphics, lMetaRect);

  aDrawCommands.Assign(lMetaGraphics.DrawCommands);

  lMetaGraphics.Free;
  lMetaFileReader.Free;


end;

class function TppMetaFileToDrawCommandConverter.ScreenPixelsPerMM: Single;
const
  cMMPerInch = 25.4;
var
  lDC: HDC;
begin

  lDC := GetDC(0);

  Result := Windows.GetDeviceCaps(lDC, LOGPIXELSX)/ cMMPerInch;

  ReleaseDC(0, lDC);

end;


end.
