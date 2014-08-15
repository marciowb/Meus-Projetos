{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2010                    BBBBB   }

unit ppPDFCanvas;

interface

{$I ppIfDef.pas}

uses Classes,
     Windows,
     Types,
     Graphics,
     ppTypes,
     ppPDFXRef,
     ppPDFSettings,
     ppPDFFont,
     ppPrintr;

type

  TppEllipseArcInfo = record
    R1: Double;           //Radius 1
    R2: Double;           //Radius 2
    C1: Double;           //Center coordinates
    C2: Double;
    StartRadian: Double;  //Start angle(radians)
    SweepRadian: Double;  //Sweep angle(radians)
    Sign: TPoint;         //Sign determined by ellipse quadrant
  end;

  TppEllipseArcPos = record
    XCp1: Double;         //Bezier Control Points
    YCp1: Double;
    XCp2: Double;
    YCp2: Double;
    XIp1: Double;         //Intersection points (begin arc, end arc)
    YIp1: Double;
    XIp2: Double;
    YIp2: Double;
  end;


  TppPDFCanvas = class
  private
    FContentStream: TMemoryStream;
    FCurrentFont: TFont;
    FPageHeightStack: array of Double;
    FPageHeightPos: Integer;
    FPathOpen: Boolean;
    FSubPathOpen: Boolean;
    FGraphicsStateIndex: Integer;
    FPDFXRef: TppPDFXRef;
    FPDFSettings: TppPDFSettings;
    FPrinter: TppPrinter;
    FScaleX: Double;
    FScaleY: Double;
    FTextHeight: Double;

    procedure AddCharacters(aText: String);
    function  CalcEllipsePos(aInfo: TppEllipseArcInfo): TppEllipseArcPos;
    function  CalcEllipseQuadInfo(aQuad: Integer; aCx, aCy, aRx, aRy, aStartAngle, aSweepAngle: Double): TppEllipseArcInfo;
    function  DrawArc(aX, aY, aXRadius, aYRadius, aStartAngle, aSweepAngle: Double): TppDoubleRect;
    function  Quadrant(aX1, aY1, aX2, aY2: Double): Integer;
    function  StoreIntersectPts(aStartQuad, aSweepQuad, aCurrentQuad: Integer; aPos: TppEllipseArcPos): TppDoubleRect;
    function  ValidateEmbeddedFonts(aFont: TFont; aFontType: TppPDFFontType): Boolean;
    function  VectorAngle(aX1, aY1, aX2, aY2: Double): Double;
    function  GetPageHeight: Double;
    function  GetFontType(aFont: TFont; aTextMetric: TTextMetricA): TppPDFFontType;
    procedure SetPageHeight(aPageHeight: Double);
    procedure PushPageHeight(aPageHeight: Double);
    function  PopPageHeight: Double;
    procedure JustifyText(aX, aY: Double; aText: string; aSpacingArray: array of Integer);
    function  UniqueSubsetID: String;
    procedure WriteStandardText(aText: String; aIsMemo: Boolean);
{$IFDEF UNICODE}
    procedure WriteUnicodeText(aText: String; aIsMemo: Boolean);
{$ENDIF}

  protected
    function  ExtToStr(aValue: Extended): String;
    procedure WriteLine(aLine: String);
    procedure WriteMem(aBuffer: String);
    procedure SetPDFXRef(aPDFXRef: TppPDFXRef);
    procedure SetPDFSettings(aPDFSettings: TppPDFSettings);
    procedure SetPrinter(const Value: TppPrinter);

  public
    constructor Create;
    destructor Destroy; override;

    procedure Clear;

    //Drawing Routines
    function  AngleArc(aX, aY, aRadius, aStartAngle, aSweepAngle: Double): TppDoubleRect;
    function  Arc(aX1, aY1, aX2, aY2, aX3, aY3, aX4, aY4: Double): TppDoubleRect;
    procedure BezierCurve(aX1, aY1, aX2, aY2, aX3, aY3: Double); overload;
    procedure BezierCurve(aX2, aY2, aX3, aY3: Double); overload;
    procedure Circle(aX, aY, aWidth, aHeight: Double);
    procedure CloseShape;
    procedure Chord(aLeft, aTop, aRight, aBottom, aX1, aY1, aX2, aY2: Double);
    procedure Ellipse(aX, aY, aWidth, aHeight: Double);
    procedure ExecuteFill; overload;
    procedure ExecuteFill(aWinding: Boolean); overload;
    procedure ExecuteStroke;
    procedure ExecuteStrokeAndFill; overload;
    procedure ExecuteStrokeAndFill(aWinding: Boolean); overload;
    procedure ExecuteClip; overload;
    procedure ExecuteClip(aWinding: Boolean); overload;
    procedure MoveTo(aX, aY: double);
    procedure LineTo(aX, aY: double);
    procedure Pie(aX1, aY1, aX2, aY2, aX3, aY3, aX4, aY4: Double);
    procedure Rectangle(aX, aY, aWidth, aHeight: Double);
    procedure RoundRectangle(aX, aY, aWidth, aHeight: Double);

    //Text Routines
    procedure BeginText;
    procedure DrawText(aLeft, aBottom: Double; aText: String);
    procedure EndText;
    procedure TextPos(aLeft, aBottom: Double);
    procedure TextOut(aX, aY: Double; aText: string); overload;
    procedure TextOut(aX, aY: Double; aText: string; aAngle: Integer); overload;
    procedure TextOut(aX, aY: Double; aText: string; aSpacingArray: array of Integer); overload;
    procedure WriteText(aText: String); overload;
    procedure WriteText(aText: String; aIsMemo: Boolean); overload;

    //Image Routines
    procedure Draw(aX, aY: Double; aBitmap: TBitmap);
    procedure DrawImage(aLeft, aBottom, aWidth, aHeight: Double; aName: String; aStretch, aFirst: Boolean; aBitmap: TBitmap);
    procedure StretchDraw(aLeft, aTop, aRight, aBottom: Double; aBitmap: TBitmap);

    //Graphic State Routines
    procedure ClipRegion(aLeft, aTop, aWidth, aHeight: Double);
    procedure RestoreGraphicsState;
    procedure RestorePageHeight;
    procedure SaveGraphicsState;
    procedure InitialGraphicsState;
    procedure SavePageHeight(aHeight: Double);
    procedure SelectBrush(aBrush: TBrush);
    procedure SelectCoordintateSpace(aX, aY, aHeight: Double);
    procedure SelectFont(aFont: TFont);
    procedure SelectPen(aPen: TPen); overload;
    procedure SelectPen(aPen: TPen; aWeight: double); overload;
    procedure SelectRotation(aAngle: Integer; aX, aY: Double);
    procedure SelectScaling(aScaleX, aScaleY: Double);
    procedure SelectWorldTransform(aScaleX, aScaley, aOrgX, aOrgY: Double);

    property ContentStream: TMemoryStream read FContentStream write FContentStream;
    property GraphicsStateIndex: Integer read FGraphicsStateIndex;
    property PageHeight: Double read GetPageHeight write SetPageHeight;
    property PathOpen: Boolean read FPathOpen write FPathOpen;
    property SubPathOpen: Boolean read FSubPathOpen Write FSubPathOpen;
    property PDFXRef: TppPDFXRef read FPDFXRef write SetPDFXRef;
    property PDFSettings: TppPDFSettings read FPDFSettings write SetPDFSettings;
    property Printer: TppPrinter read FPrinter write SetPrinter;

  end;


implementation

uses
  SysUtils,
  StrUtils,
  Forms,
  Math,
  ppCharacter,
  ppPDFObject,
  ppPDFImage,
  ppPDFXObject,
  ppPDFUtils,
  ppPDFFontDescriptor,
  ppPDFFontWidths,
  ppPDFFontFile,
  ppPDFEncoding,
  ppStrUtils;

//******************************************************************************
//
//  DRAWING ROUTINES
//
//******************************************************************************

function TppPDFCanvas.AngleArc(aX, aY, aRadius, aStartAngle, aSweepAngle: Double): TppDoubleRect;
begin
  //TODO: need to draw a line from the current position to the start position of the arc.
  Result := DrawArc(aX, aY, aRadius, aRadius, aStartAngle, aStartAngle + aSweepAngle);

end;

function TppPDFCanvas.Arc(aX1, aY1, aX2, aY2, aX3, aY3, aX4, aY4: Double): TppDoubleRect;
var
  ldXCenter: Double;
  ldYCenter: Double;
  ldXRadius: Double;
  ldYRadius: Double;
  ldStartAngle: Double;
  ldSweepAngle: Double;
begin

  ldXRadius := (aX2 - aX1) / 2;
  ldYRadius := (aY2 - aY1) / 2;

  ldXCenter := aX1 + ldXRadius;
  ldYCenter := aY1 + ldYRadius;

  ldStartAngle := VectorAngle(ldXCenter, ldYCenter, aX3, aY3);
  ldSweepAngle := VectorAngle(ldXCenter, ldYCenter, aX4, aY4);

  Result := DrawArc(ldXCenter, ldYCenter, ldXRadius, ldYRadius, ldStartAngle, ldSweepAngle);
end;

{TppPDFCanvas.BezierCurve

  Append a cubic Bezier curve to the current path.  The curve extends from the
  current point to the point (aX3, aY3), using (aX1, aY1) and (aX2, aY2) as the
  Bezier control points.}

procedure TppPDFCanvas.BezierCurve(aX1, aY1, aX2, aY2, aX3, aY3: Double);
var
  ldY1: Double;
  ldY2: Double;
  ldY3: Double;
begin

  ldY1 := PageHeight - aY1;
  ldY2 := PageHeight - aY2;
  ldY3 := PageHeight - aY3;

  WriteLine(ExtToStr(aX1) + ' ' + ExtToStr(ldY1) + ' ' + ExtToStr(aX2) + ' ' +
            ExtToStr(ldY2) + ' ' + ExtToStr(aX3) + ' ' + ExtToStr(ldY3) + ' c');

end;

{TppPDFCanvas.BezierCurve

  Append a cubic Bezier curve to the current path.  The curve extends from the
  current point to the point (aX3, aY3), using the current point and (aX2, aY2)
  as the Bezier control points.}

procedure TppPDFCanvas.BezierCurve(aX2, aY2, aX3, aY3: Double);
var
  ldY2: Double;
  ldY3: Double;
begin

  ldY2 := PageHeight - aY2;
  ldY3 := PageHeight - aY3;

  WriteLine(ExtToStr(aX2) + ' ' + ExtToStr(ldY2) + ' ' + ExtToStr(aX3) + ' ' + ExtToStr(ldY3) + ' v');

end;

function TppPDFCanvas.CalcEllipsePos(aInfo: TppEllipseArcInfo):TppEllipseArcPos;
var
  ldXDistance: Double;
  ldYDistance: Double;
  ldt1: Double;
  ldt2: Double;
begin

  //Calculate the distance from the intersection point to the control point of the Bezier curve using the following equation.
  //  L = (4/3) * Tan((1/4) * alpha))...Where alpha is the angle created by the two vectors.
  ldXDistance := RoundTo(aInfo.R1 * 4 / 3 * Tan((1/4) * (aInfo.SweepRadian - aInfo.StartRadian)), -2);
  ldYDistance := RoundTo(aInfo.R2 * 4 / 3 * Tan((1/4) * (aInfo.SweepRadian - aInfo.StartRadian)), -2);

  //Find the intersection points based on the start and sweep angles using the parameterized equation of an ellipse.
  //  x = x0 + a * cos(t)
  //  y = y0 + b * sin(t)
  //Where (x0,y0) is the center of the ellipse, a and b are the radii and t is the unknown parameter.

  //Find t for each angle.
  ldt1 := ArcTan2(((aInfo.R1 * Tan(aInfo.StartRadian))/aInfo.R2), 1);
  ldt2 := ArcTan2(((aInfo.R1 * Tan(aInfo.SweepRadian))/aInfo.R2), 1);

  //Insert t into the parameterized equations above to find the intersection points.
  Result.XIp1 := aInfo.C1 + (aInfo.Sign.X)*(aInfo.R1 * Cos(ldt1));
  Result.YIp1 := aInfo.C2 + (aInfo.Sign.Y)*(aInfo.R2 * Sin(ldt1));
  Result.XIp2 := aInfo.C1 + (aInfo.Sign.X)*(aInfo.R1 * Cos(ldt2));
  Result.YIp2 := aInfo.C2 + (aInfo.Sign.Y)*(aInfo.R2 * Sin(ldt2));

  //Calculate the Bezier control point coordinates.  This is done knowing that each control point extends a distance
  //L from the intersection point at 90 degrees relative to the vector angle.
  Result.Xcp1 := aInfo.C1 + (aInfo.Sign.X)*Cos(aInfo.StartRadian + ArcTan2(ldXDistance,aInfo.R1)) * Sqrt(Power(aInfo.R1, 2) + Power(ldXDistance, 2));
  Result.Ycp1 := aInfo.C2 + (aInfo.Sign.Y)*Sin(aInfo.StartRadian + ArcTan2(ldYDistance,aInfo.R2)) * Sqrt(Power(aInfo.R2, 2) + Power(ldYDistance, 2));
  Result.Xcp2 := aInfo.C1 + (aInfo.Sign.X)*Cos(aInfo.SweepRadian - ArcTan2(ldXDistance,aInfo.R1)) * Sqrt(Power(aInfo.R1, 2) + Power(ldXDistance, 2));
  Result.Ycp2 := aInfo.C2 + (aInfo.Sign.Y)*Sin(aInfo.SweepRadian - ArcTan2(ldYDistance,aInfo.R2)) * Sqrt(Power(aInfo.R2, 2) + Power(ldYDistance, 2));

end;

function TppPDFCanvas.CalcEllipseQuadInfo(aQuad: Integer; aCx, aCy, aRx, aRy, aStartAngle, aSweepAngle: Double): TppEllipseArcInfo;
var
  liStartQuad: Integer;
  liSweepQuad: Integer;
  liCurrentQuad: Integer;
begin

  liStartQuad := Trunc(aStartAngle / 90);

  if aStartAngle >= aSweepAngle then
    liSweepQuad := Trunc(aSweepAngle / 90) + 4
  else
    liSweepQuad := Trunc(aSweepAngle / 90);

  if aQuad > 3 then
    liCurrentQuad := aQuad - 4
  else
    liCurrentQuad := aQuad;

  //Each quadrant is calculated as if it were a 90 degree angle.  These signs determine the actual location
  //from the center of the ellipse the measurements should be taken.
  case liCurrentQuad of
    0: Result.Sign := Point(1, -1);
    1: Result.Sign := Point(-1, -1);
    2: Result.Sign := Point(-1, 1);
    3: Result.Sign := Point(1,1);
  end;

  //In order to obtain the proper transformation, we need to reverse the radii and center point for the
  //second and forth quadrant.
  if liCurrentQuad mod 2 = 0 then
    begin
      Result.R1 := aRx;
      Result.R2 := aRy;
      Result.C1 := aCx;
      Result.C2 := aCy;
    end
  else
    begin
      Result.R1 := aRy;
      Result.R2 := aRx;
      Result.C1 := aCy;
      Result.C2 := aCx;
    end;

  //Each quadrant is drawn individually, therefore if the start and sweep angles are in separate quadrants,
  //we need to cut off the sweep angle at 90, then start it up again at 0 (for the next quadrant).
  if aQuad <> liStartQuad then
    Result.StartRadian := 0
  else
    Result.StartRadian := DegToRad((aStartAngle - (liStartQuad * 90)));

  if aQuad <> liSweepQuad then
    Result.SweepRadian := DegToRad(90)
  else
    Result.SweepRadian := DegToRad((aSweepAngle - (liCurrentQuad * 90)));

end;

procedure TppPDFCanvas.Chord(aLeft, aTop, aRight, aBottom, aX1, aY1, aX2, aY2: Double);
var
  ldXRadius: Double;
  ldYRadius: Double;
  ldx1: Double;
  ldy1: Double;
  ldx2: Double;
  ldy2: Double;
  ldCx: Double;
  ldCy: Double;
  ldDx: Double;
  ldDy: Double;
  ldDr: Double;
  ldD: Double;
  liXSign: Integer;
  lSign: TPoint;
  ldXip1: Double;
  ldYip1: Double;
  ldXip2: Double;
  ldYip2: Double;
begin

  //Find the radii and center point(s) of the ellipse
  ldXRadius := (aRight - aLeft) / 2;
  ldYRadius := (aBottom - aTop) / 2;
  ldCx := aLeft + ldXRadius;
  ldCy := aTop + ldYRadius;

  //Convert the line coordinates to cartesian
  ldx1 := aX1 - ldCx;
  ldy1 := ldCy - aY1;
  ldx2 := aX2 - ldCx;
  ldy2 := ldCy - aY2;

  //Calculate the intersection points of a line and an ellipse using the equation
  //of a line and the equation of an ellipse.
  ldDx := ldx2 - ldx1;
  ldDy := ldy2 - ldy1;
  ldDr := Sqrt(Power(ldDx, 2) + Power(ldDy, 2));
  ldD  := (ldx1 * ldy2) - (ldx2 * ldy1);

  if ldDy < 0 then
    liXSign := -1
  else
    liXSign := 1;

  if ((aX1 < aX2) and (aY1 > aY2)) or ((aX1 > aX2) and (aY1 > aY2)) then
    lSign := Point(-1, 1)
  else if ((aX1 < aX2) and (aY1 < aY2)) or ((aX1 > aX2) and (aY1 < aY2)) then
    lSign := Point(1, -1);

  //Solve using the quadratic formula
  ldXip1 := ldCx + ((ldD * ldDy) + (lSign.X)*(liXSign * ldDx * Sqrt(Power(ldXRadius, 2)*Power(ldDr, 2) - Power(ldD, 2)))) / (Power(ldDr, 2));
  ldYip1 := ldCy - ((-ldD * ldDx) + (lSign.X)*(Abs(ldDy) * Sqrt(Power(ldYRadius, 2)*Power(ldDr, 2) - Power(ldD, 2)))) / (Power(ldDr, 2));
  ldXip2 := ldCx + ((ldD * ldDy) + (lSign.Y)*(liXSign * ldDx * Sqrt(Power(ldXRadius, 2)*Power(ldDr, 2) - Power(ldD, 2)))) / (Power(ldDr, 2));
  ldYip2 := ldCy - ((-ldD * ldDx) + (lSign.Y)*(Abs(ldDy) * Sqrt(Power(ldYRadius, 2)*Power(ldDr, 2) - Power(ldD, 2)))) / (Power(ldDr, 2));

  //Draw the chord
  MoveTo(ldXip1, ldYip1);
  LineTo(ldXip2, ldYip2);
  Arc(aLeft, aTop, aRight, aBottom, ldXip1, ldYip1, ldXip2, ldYip2);

end;

procedure TppPDFCanvas.Circle(aX, aY, aWidth, aHeight: Double);
var
  ldRadius: Double;
  ldX: Double;
  ldY: Double;
begin

  ldRadius := Min(aWidth, aHeight) / 2;

  if aWidth <= aHeight then
    begin
      ldX := aX + (aWidth / 2) - ldRadius;
      ldY := aY;
    end
  else
    begin
      ldX := aX;
      ldY := aY + (aHeight / 2) - ldRadius;
    end;

  Ellipse(ldX, ldY, ldRadius, ldRadius);

end;

{TppPDFCanvas.CloseShape

  Closes the current path by performing the equivalent of a LineTo from the
  current point to the path starting point.}

procedure TppPDFCanvas.CloseShape;
begin
  WriteLine('h');
  SubPathOpen := False;

end;

constructor TppPDFCanvas.Create;
begin
  FScaleX := 1;
  FScaleY := 1;

  FPageHeightStack := nil;
  FPageHeightPos := 0;
  FGraphicsStateIndex := 0;

  FCurrentFont := TFont.Create;
  FPathOpen := False;
  FSubPathOpen := False;

end;

destructor TppPDFCanvas.Destroy;
begin
  FCurrentFont.Free;
  FCurrentFont := nil;

end;

procedure TppPDFCanvas.Clear;
begin
  //Clear the page height stack
  FPageHeightStack := nil;
  FPageHeightPos := 0;

end;

{TppPDFCanvas.DrawArc

  Draws an arc along the path of an ellipse defined by (aX,aY) as the center of
  the shape and the two radii.  The arc is drawn from the start angle
  counterclockwise to the sweep angle relative to the positive x-axis.

  This routine returns the intersections points between the ellips bounds and two
  vectors extending from the center of the ellipse toward the defined angles.}

function TppPDFCanvas.DrawArc(aX, aY, aXRadius, aYRadius, aStartAngle, aSweepAngle: Double): TppDoubleRect;
var
  liStartQuad: Integer;
  liSweepQuad: Integer;
  liIndex: Integer;
  lInfo: TppEllipseArcInfo;
  lPos: TppEllipseArcPos;
  lbFirstPass: Boolean;
begin

  lbFirstPass := True;

  liStartQuad := Trunc(aStartAngle / 90);

  if aStartAngle >= aSweepAngle then
    liSweepQuad := Trunc(aSweepAngle / 90) + 4
  else
    liSweepQuad := Trunc(aSweepAngle / 90);

  //Calculate points for each quadrant of an ellipse.
  for liIndex := liStartQuad to liSweepQuad do
    begin
      lInfo := CalcEllipseQuadInfo(liIndex, aX, aY, aXRadius, aYRadius, aStartAngle, aSweepAngle);
      lPos := CalcEllipsePos(lInfo);

      //Draw the arc
      if liIndex mod 2 = 0 then
        begin
          if lbFirstPass then
            begin
              MoveTo(lPos.Xip1, lPos.Yip1);
              lbFirstPass := False;
            end;
          BezierCurve(lPos.Xcp1, lPos.Ycp1, lPos.Xcp2, lPos.Ycp2, lPos.Xip2, lPos.Yip2);
        end
      else
        begin
          if lbFirstPass then
            begin
              MoveTo(lPos.Yip1, lPos.Xip1);
              lbFirstPass := False;
            end;
          BezierCurve(lPos.Ycp1, lPos.Xcp1, lPos.Ycp2, lPos.Xcp2, lPos.Yip2, lPos.Xip2);
        end;

      if (liIndex = liStartQuad) or (liIndex = liSweepQuad) then
        Result := StoreIntersectPts(liStartQuad, liSweepQuad, liIndex, lPos);
    end;

end;

procedure TppPDFCanvas.Ellipse(aX, aY, aWidth, aHeight: Double);
var
  ldXRadius: Double;
  ldYRadius: Double;
  ldCx: Double;
  ldCy: Double;
  ldXDistance: Double;
  ldYDistance: Double;
begin

  ldXRadius := aWidth / 2;
  ldYRadius := aHeight / 2;

  {Shape Center}
  ldCx := aX + (aWidth / 2);
  ldCy := aY + (aHeight / 2);

  ldXDistance := RoundTo(ldXRadius * 4 / 3 * Tan(Pi/8), -2);
  ldYDistance := RoundTo(ldYRadius * 4 / 3 * Tan(Pi/8), -2);

  MoveTo(ldCx, (ldCy - ldYRadius));
  BezierCurve((ldCx + ldXDistance), (ldCy - ldYRadius), (ldCx + ldXRadius), (ldCy - ldYDistance), (ldCx + ldXRadius), ldCy);
  BezierCurve((ldCx + ldXRadius), (ldCy + ldYDistance), (ldCx + ldXDistance), (ldCy + ldYRadius), ldCx, (ldCy + ldYRadius));
  BezierCurve((ldCx - ldXDistance), (ldCy + ldYRadius), (ldCx - ldXRadius), (ldCy + ldYDistance), (ldCx - ldXRadius), ldCy);
  BezierCurve((ldCx - ldXRadius), (ldCy - ldYDistance), (ldCx - ldXDistance), (ldCy - ldYRadius), ldCx, (ldCy - ldYRadius));

end;

procedure TppPDFCanvas.ExecuteClip;
begin
  ExecuteClip(True);

end;

procedure TppPDFCanvas.ExecuteClip(aWinding: Boolean);
begin
  if PathOpen then exit;

  if aWinding then
    WriteLine('W')
  else
    WriteLine('W*');

  WriteLine('n');

end;

procedure TppPDFCanvas.ExecuteFill;
begin
  ExecuteFill(True);

end;

procedure TppPDFCanvas.ExecuteFill(aWinding: Boolean);
begin
  if PathOpen then exit;

  if aWinding then
    WriteLine('f')
  else
    WriteLine('f*');

end;

procedure TppPDFCanvas.ExecuteStroke;
begin
  if PathOpen then exit;

  WriteLine('S');

end;

procedure TppPDFCanvas.ExecuteStrokeAndFill(aWinding: Boolean);
begin
  if PathOpen then exit;

  if aWinding then
    WriteLine('B')
  else
    WriteLine('B*');

end;

procedure TppPDFCanvas.ExecuteStrokeAndFill;
begin
  ExecuteStrokeAndFill(True);

end;

procedure TppPDFCanvas.MoveTo(aX, aY: double);
var
  ldY: Double;
begin

  ldY := PageHeight - aY;
  Writeline(ExtToStr(aX) + ' ' + ExtToStr(ldY) + ' m');

  if (PathOpen) and not(SubPathOpen) then
    SubPathOpen := True;

end;

procedure TppPDFCanvas.Pie(aX1, aY1, aX2, aY2, aX3, aY3, aX4, aY4: Double);
var
  ldWidth: Double;
  ldHeight: Double;
  lDoubleRect: TppDoubleRect;
begin

  ldWidth := aX2 - aX1;
  ldHeight := aY2 - aY1;

  lDoubleRect := Arc(aX1, aY1, aX2, aY2, aX3, aY3, aX4, aY4);

  LineTo(aX1 + (ldWidth / 2), aY1 + (ldHeight / 2));
  LineTo((lDoubleRect.Left), (lDoubleRect.Top));

end;

procedure TppPDFCanvas.LineTo(aX, aY: double);
var
  ldY: Double;
begin

  ldY := PageHeight - aY;
  Writeline(ExtToStr(aX) + ' ' + ExtToStr(ldY) + ' l');

end;

function TppPDFCanvas.Quadrant(aX1, aY1, aX2, aY2: Double): Integer;
begin
  if (aX1 > aX2) then
    begin
      if (aY1 > aY2) then
        Result := 1
      else
        Result := 2
    end
  else
    begin
      if (aY1 > aY2) then
        Result := 0
      else
        Result := 3
    end;
end;

procedure TppPDFCanvas.Rectangle(aX, aY, aWidth, aHeight: Double);
var
  ldY: Double;
begin

  ldY := PageHeight - (aY + aHeight);
  WriteLine(ExtToStr(aX) + ' ' + ExtToStr(ldY) + ' ' + ExtToStr(aWidth) + ' ' + ExtToStr(aHeight) + ' re');
  
end;

procedure TppPDFCanvas.RoundRectangle(aX, aY, aWidth, aHeight: Double);
var
  ldCorner: Double;
begin

  {Corner circle radius}
  ldCorner := (Min(aWidth, aHeight) / 4) / 2;

  MoveTo((aX + ldCorner), aY);
  LineTo((aX + aWidth - ldCorner), aY);
  BezierCurve((aX + aWidth), aY, (aX + aWidth), (aY + ldCorner));
  LineTo((aX + aWidth), (aY + aHeight - ldCorner));
  BezierCurve((aX + aWidth), (aY + aHeight), (aX + aWidth - ldCorner), (aY + aHeight));
  LineTo((aX + ldCorner), (aY + aHeight));
  BezierCurve(aX, (aY + aHeight), aX, (aY + aHeight - ldCorner));
  LineTo(aX, (aY + ldCorner));
  BezierCurve(aX, aY, (aX + ldCorner), aY);

end;

function TppPDFCanvas.StoreIntersectPts(aStartQuad, aSweepQuad, aCurrentQuad: Integer; aPos: TppEllipseArcPos): TppDoubleRect;
begin
  if aCurrentQuad mod 2 = 0 then
    begin
      if aCurrentQuad = aStartQuad then
        begin
          Result.Left := aPos.XIp1;
          Result.Top := aPos.YIp1;
        end;
      if aCurrentQuad = aSweepQuad then
        begin
          Result.Right := aPos.XIp2;
          Result.Bottom := aPos.YIp2;
        end;
    end
  else
    begin
      if aCurrentQuad = aStartQuad then
        begin
          Result.Left := aPos.YIp1;
          Result.Top := aPos.XIp1;
        end;
      if aCurrentQuad = aSweepQuad then
        begin
          Result.Right := aPos.YIp2;
          Result.Bottom := aPos.XIp2;
        end;
    end;

end;

{TppPDFCanvas.VectorAngle

  Returns the angle of a line starting at point (aX1,aY1) and ending at point
  (aX2,aY2) counterclockwise from the positive x-axis.}

function TppPDFCanvas.VectorAngle(aX1, aY1, aX2, aY2: Double): Double;
begin
  case Quadrant(aX1, aY1, aX2, aY2) of
    0: Result := RadToDeg(ArcTan2((aY1 - aY2), (aX2 - aX1)));
    1: Result := RadToDeg(ArcTan2((aX1 - aX2), (aY1 - aY2))) + 90;
    2: Result := RadToDeg(ArcTan2((aY2 - aY1), (aX1 - aX2))) + 180;
    3: Result := RadToDeg(ArcTan2((aX2 - aX1), (aY2 - aY1))) + 270;
    else
       Result := 0;
  end;

end;

//******************************************************************************
//
//  TEXT ROUTINES
//
//******************************************************************************

procedure TppPDFCanvas.AddCharacters(aText: String);
var
  lPDFFont: TppPDFFont;
  liIndex: Integer;
begin

  lPDFFont := FPDFXRef.PDFFontManager.GetFontForName(FCurrentFont.Name);

  if lPDFFont <> nil then
    begin
      for liIndex := 1 to Length(aText) do
        begin
          if lPDFFont.CharList.IndexOf(aText[liIndex]) = -1 then
            lPDFFont.CharList.Add(aText[liIndex]);
        end;
    end;

end;

procedure TppPDFCanvas.BeginText;
begin
  WriteLine('BT');
end;

procedure TppPDFCanvas.DrawText(aLeft, aBottom: Double; aText: String);
begin

  TextPos(aLeft, aBottom);
  WriteText(aText);
  EndText;

end;

procedure TppPDFCanvas.EndText;
begin
  WriteLine('ET');
end;

procedure TppPDFCanvas.JustifyText(aX, aY: Double; aText: string; aSpacingArray: array of Integer);
var
  liIndex: Integer;
  ldTotalSpace: Double;
  ldY: Double;
begin

  ldTotalSpace := 0;

  ldY := PageHeight - aY;

  //End the current text object.
  EndText;

  for liIndex := 1 to Length(aText) do
    begin
      BeginText;

      //Assign the word position on the page .
      TextPos(aX + ldTotalSpace, ldY - FTextHeight);

      //Determine the width of the character based on the char width array
      ldTotalSpace := ldTotalSpace + TppPDFUtils.PixelsToPoints(aSpacingArray[liIndex-1], Screen.PixelsPerInch);

      //Write the character to the page
      WriteText(aText[liIndex]);

      //End the current text object for the word.
      EndText;
    end;

end;

procedure TppPDFCanvas.TextPos(aLeft, aBottom: Double);
begin
  WriteLine(ExtToStr(aLeft) + ' ' + ExtToStr(aBottom) + ' Td');

end;

procedure TppPDFCanvas.TextOut(aX, aY: Double; aText: string);
var
  ldY: Double;
begin

  ldY := PageHeight - aY;

  DrawText(aX, ldY - FTextHeight, aText);

end;

procedure TppPDFCanvas.TextOut(aX, aY: Double; aText: string; aAngle: Integer);
begin
  SelectRotation(aAngle, aX, aY);

  DrawText(0, 0, aText);
end;

procedure TppPDFCanvas.TextOut(aX, aY: Double; aText: string; aSpacingArray: array of Integer);
begin
  if (Length(aSpacingArray) > 0) and (aText <> '') then
    JustifyText(aX, aY, aText, aSpacingArray)
  else
    TextOut(aX, aY, aText);

end;

procedure TppPDFCanvas.WriteText(aText: String);
begin
  WriteText(aText, False);

end;

procedure TppPDFCanvas.WriteText(aText: String; aIsMemo: Boolean);
var
  lsText: String;
begin
  AddCharacters(aText);

  lsText := TppPDFUtils.ProcessText(aText);

{$IFDEF UNICODE}
  if (PDFSettings.FontEncoding = feUnicode) and (TppPDFUtils.IsUnicodeFont(FCurrentFont)) then
    WriteUnicodeText(lsText, aIsMemo)
  else
{$ENDIF}
    WriteStandardText(lsText, aIsMemo);

end;

{$IFDEF UNICODE}
procedure TppPDFCanvas.WriteUnicodeText(aText: String; aIsMemo: Boolean);
var
  lBitmap: TBitmap;
  lsText: String;
  liIndex: Integer;
  lCount: DWORD;
  lChars: array of WORD;
begin

  lBitmap := TBitmap.Create;

  try
    lBitmap.Canvas.Font.Assign(FCurrentFont);

    SetLength(lChars, Length(aText));
    lCount := GetGlyphIndices(lBitmap.Canvas.Handle, PChar(aText), Length(aText), @lChars[0], 0);

    lsText := '<';
    for liIndex := 0 to lCount - 1 do
      if lChars[liIndex] <> 0 then
        lsText := lsText + IntToHex(Ord(Chr(lChars[liIndex])), 4);

    lsText := lsText + '>';

    WriteMem(lsText + ' Tj');

    if aIsMemo then
      WriteLine(' T*')
    else
      WriteLine('');

  finally
    lBitmap.Free;
  end;

end;
{$ENDIF}

procedure TppPDFCanvas.WriteStandardText(aText: String; aIsMemo: Boolean);
begin
  WriteMem('(' + aText + ') Tj');

  if aIsMemo then
    WriteLine(' T*')
  else
    WriteLine('');

end;

//******************************************************************************
//
//  IMAGE ROUTINES
//
//******************************************************************************

procedure TppPDFCanvas.Draw(aX, aY: Double; aBitmap: TBitmap);
var
  ldBottom: Double;
  ldWidth: Double;
  ldHeight: Double;
  lPDFImage: TppPDFImage;
begin

  lPDFImage := TppPDFImage.Create;
  lPDFImage.ImagePage := PDFXRef.PageCount;
  lPDFImage.FirstImage := True;
  lPDFImage.ReferenceNumber := PDFXRef.PDFObjectCount + 1;
  lPDFImage.ImageName := 'MetaImage' + IntToStr(lPDFImage.ReferenceNumber);

  ldWidth := TppPDFUtils.PixelsToPoints(aBitmap.Width, Screen.PixelsPerInch);
  ldHeight := TppPDFUtils.PixelsToPoints(aBitmap.Height, Screen.PixelsPerInch);
  ldBottom := PageHeight - (aY + ldHeight);

  DrawImage(aX, ldBottom, ldWidth, ldHeight, lPDFImage.ImageName, False, True, aBitmap);

  PDFXRef.PDFImageManager.AddImage(lPDFImage);

end;

procedure TppPDFCanvas.DrawImage(aLeft, aBottom, aWidth, aHeight: Double; aName: String; aStretch, aFirst: Boolean; aBitmap: TBitmap);
var
  lsBottom: String;
  lsLeft: String;
  lsWidth: String;
  lsHeight: String;
  lPDFXObject: TppPDFXObject;
begin

  lsBottom := ExtToStr(aBottom);
  lsLeft := ExtToStr(aLeft);

  lsWidth := ExtToStr(aWidth);
  lsHeight := ExtToStr(aHeight);

  //Draw the Image
  WriteLine(lsWidth + ' 0 0 ' + lsHeight + ' ' + lsLeft + ' ' + lsBottom + ' cm');
  WriteLine('/' + aName + ' Do');

  //Create XObject
  if(aFirst) then
    begin
      lPDFXObject := TppPDFXObject.Create;

      lPDFXObject.Bitmap := aBitmap;
      lPDFXObject.Name := aName;
      lPDFXObject.Width := aWidth;
      lPDFXObject.Height := aHeight;
      lPDFXObject.Stretch := aStretch;
      lPDFXObject.CompressionLevel := PDFSettings.CompressionLevel;
      lPDFXObject.ScaleImages := PDFSettings.ScaleImages;
      lPDFXObject.CacheImages := PDFSettings.CacheImages;
      PDFXRef.AddObject(TppPDFObject(lPDFXObject));

    end;
end;

procedure TppPDFCanvas.StretchDraw(aLeft, aTop, aRight, aBottom: Double; aBitmap: TBitmap);
var
  ldBottom: Double;
  ldWidth: Double;
  ldHeight: Double;
  lPDFImage: TppPDFImage;
begin

  lPDFImage := TppPDFImage.Create;
  lPDFImage.ImagePage := PDFXRef.PageCount;
  lPDFImage.FirstImage := True;
  lPDFImage.ReferenceNumber := PDFXRef.PDFObjectCount + 1;
  lPDFImage.ImageName := 'MetaImage' + IntToStr(lPDFImage.ReferenceNumber);

  ldWidth := aRight - aLeft;
  ldHeight := aBottom - aTop;
  ldBottom := PageHeight - aBottom;

  DrawImage(aLeft, ldBottom, ldWidth, ldHeight, lPDFImage.ImageName, True, True, aBitmap);

  PDFXRef.PDFImageManager.AddImage(lPDFImage);
end;

//******************************************************************************
//
//  GRAPHIC STATE ROUTINES
//
//******************************************************************************

procedure TppPDFCanvas.ClipRegion(aLeft, aTop, aWidth, aHeight: Double);
var
  ldBottom: Double;
begin

  ldBottom    := PageHeight - (aTop + aHeight);

  WriteLine(ExtToStr(aLeft) + ' ' + ExtToStr(ldBottom) + ' ' + ExtToStr(aWidth) + ' ' + ExtToStr(aHeight) + ' re');

end;

procedure TppPDFCanvas.RestoreGraphicsState;
begin
  if not(FGraphicsStateIndex > 0) then exit;

  WriteLine('Q');
  RestorePageHeight;

  Dec(FGraphicsStateIndex);

end;

procedure TppPDFCanvas.RestorePageHeight;
begin
  PopPageHeight;

end;

procedure TppPDFCanvas.SaveGraphicsState;
begin
  SavePageHeight(PageHeight);
  WriteLine('q');

  Inc(FGraphicsStateIndex);

end;

procedure TppPDFCanvas.SavePageHeight(aHeight: Double);
begin
  PushPageHeight(aHeight);

end;

procedure TppPDFCanvas.SelectBrush(aBrush: TBrush);
var
  lsBrushColor: String;
begin

  lsBrushColor := TppPDFUtils.ConvertRGB(aBrush.Color);
  WriteLine(lsBrushColor + ' rg');

end;

procedure TppPDFCanvas.SelectCoordintateSpace(aX, aY, aHeight: Double);
var
  ldY: Double;
begin

  ldY := PageHeight - aY - aHeight;
  WriteLine('1 0 0 1' + ' ' + ExtToStr(aX) + ' ' + ExtToStr(ldY) + ' cm');

end;

procedure TppPDFCanvas.SelectScaling(aScaleX, aScaleY: Double);
begin
  //SavePageHeight(PageHeight * aScaleY);
  SavePageHeight(PageHeight / aScaleY);
  WriteLine(ExtToStr(aScaleX) + ' 0 0 ' + ExtToStr(aScaleY) + ' 0 0 cm');

end;

procedure TppPDFCanvas.SelectWorldTransform(aScaleX, aScaley, aOrgX, aOrgY: Double);
begin

  SavePageHeight((PageHeight * aScaleY));

  //WriteLine('1 0 0 1' + ' ' + ExtToStr(aOrgX*aScaleX) + ' ' + ExtToStr(ldY) + ' cm');
  WriteLine(ExtToStr(aScaleX) + ' 0 0 ' + ExtToStr(aScaleY) + ' 0 0 cm');
  WriteLine('1 0 0 1' + ' ' + ExtToStr(aOrgX) + ' ' + ExtToStr(PageHeight - aOrgy) + ' cm');

end;

procedure TppPDFCanvas.SelectFont(aFont: TFont);
var
  lTextMetric: TTextMetricA;
  lsFontName: String;
  lsFontColor: String;
  liFontSize: Integer;
  lFontType: TppPDFFontType;
  lbEmbedFonts: Boolean;
  lPDFFont: TppPDFFont;
begin

  FCurrentFont.Assign(aFont);

  //Font Info
  lTextMetric := TppPDFUtils.PopulateTextMetric(aFont, Printer.Canvas);
  lFontType := GetFontType(aFont, lTextMetric);

  //PDF needs the baseline position for the text
  FTextHeight := TppPDFUtils.PixelsToPoints(lTextMetric.tmAscent, Printer.PixelsPerInch.Y);

  //Check for valid embedded fonts
  lbEmbedFonts := ValidateEmbeddedFonts(aFont, lFontType);

  lsFontName := TppPDFUtils.ProcessFontName(aFont, (lFontType = pfTrueType) or (lFontType = pfType0));

  if (efUseSubset in PDFSettings.EmbedFontOptions) then
    lsFontName := UniqueSubsetID + lsFontName;

  //Font Color
  lsFontColor := TppPDFUtils.ConvertRGB(aFont.Color);
  WriteLine(lsFontColor + ' rg');

  //Font Size
  liFontSize := aFont.Size;

 //Negative font sizes force the text to appear up side down in PDF
  if (liFontSize < 0) then
    liFontSize := Abs(liFontSize);

  BeginText;
  WriteLine('/' + lsFontName + ' ' + IntToStr(liFontSize) + ' Tf');

  //Create a new font dictionary if necessary.
  //The Font object creates all other font dictionaries.
  if(not(PDFXRef.PDFFontManager.FontExists(lsFontName))) then
    begin
      lPDFFont := TppPDFFont.Create;
      lPDFFont.Font := aFont;
      lPDFFont.FontType := lFontType;
      lPDFFont.FontName := lsFontName;
      lPDFFont.RawFontName := aFont.Name;
      lPDFFont.TextMetric := lTextMetric;
      lPDFFont.IsEmbedded := lbEmbedFonts;
      lPDFFont.UseSubset := efUseSubset in PDFSettings.EmbedFontOptions;
      lPDFFont.CompressionLevel := PDFSettings.CompressionLevel;
      lPDFFont.PDFXRef := PDFXRef;
      PDFXRef.AddObject(TppPDFObject(lPDFFont));
      PDFXRef.PDFFontManager.AddFont(lPDFFont);
    end;

end;

function TppPDFCanvas.UniqueSubsetID: String;
var
  liIndex: Integer;
  lbFontExists: Boolean;
begin

  Result := '';
  lbFontExists := True;

  while lbFontExists do
    begin
      Result := '+';
      for liIndex := 0 to 5 do
        Result := Chr(RandomRange(65, 90)) + Result;

      lbFontExists := PDFXRef.PDFFontManager.FontExists(Result + FCurrentFont.Name);
    end;

end;

procedure TppPDFCanvas.SelectPen(aPen: TPen);
var
  ldWeight: Double;
begin

  ldWeight := TppPDFUtils.PixelsToPoints(aPen.Width, Screen.PixelsPerInch);
  SelectPen(aPen, ldWeight);

end;

procedure TppPDFCanvas.SelectPen(aPen: TPen; aWeight: double);
var
  lsPenStyle: String;
  lsStrokeColor: String;
begin

  {Color}
  lsStrokeColor := TppPDFUtils.ConvertRGB(aPen.Color);
  WriteLine(lsStrokeColor + ' RG');

  {Line Width}
  WriteLine(ExtToStr(aWeight) + ' w');

  {Pen Style}
  lsPenStyle := TppPDFUtils.PenStyle(aPen.Style);
  WriteLine(lsPenStyle);

end;

procedure TppPDFCanvas.SelectRotation(aAngle: Integer; aX, aY: Double);
var
  ldRadian: Double;
  ldTransA: Double;
  ldTransB: Double;
  ldTransC: Double;
  ldTransD: Double;
  ldY: Double;
  ldXOffset: Double;
  ldYOffset: Double;
begin

  ldRadian := DegToRad(aAngle);

  //Calculate new Transformation Matrix values
  ldTransA := RoundTo(Cos(ldRadian), -2);
  ldTransB := RoundTo(Sin(ldRadian), -2);
  ldTransC := RoundTo(-Sin(ldRadian), -2);
  ldTransD := ldTransA;

  //Calc offsets
  ldXOffset := 0;
  ldYOffset := 0;

  if ((aAngle > 0) and (aAngle <= 90)) or ((aAngle > 180) and (aAngle <= 270)) then
    ldXOffset := RoundTo(Sin(ldRadian) * FTextHeight, -2)
  else if ((aAngle > 90) and (aAngle <= 180)) or ((aAngle > 270) and (aAngle <= 360)) then
    ldYOffset := RoundTo(Cos(ldRadian) * FTextHeight, -2);

  //Translate
  ldY := PageHeight - aY;
  WriteLine('1 0 0 1' + ' ' + ExtToStr(aX - ldXOffset) + ' ' + ExtToStr(ldY + ldYOffset) + ' cm');

  //Rotate
  WriteLine(ExtToStr(ldTransA) + ' ' + ExtToStr(ldTransB) + ' ' + ExtToStr(ldTransC) + ' ' + ExtToStr(ldTransD) + ' 0 0 cm');

end;

function TppPDFCanvas.ValidateEmbeddedFonts(aFont: TFont; aFontType: TppPDFFontType): Boolean;
begin
  Result := False;

  if (efAllFonts in PDFSettings.EmbedFontOptions) then
    Result := True

  else if (efFontList in PDFSettings.EmbedFontOptions) then
    begin
      if (TStringList(PDFSettings.EmbedFontList).IndexOf(aFont.Name) > -1) then
        Result := True;
    end
  else if (aFontType = pfType0) then  //All Type0 fonts (Unicode) must be embedded
    Result := True;


end;

function TppPDFCanvas.ExtToStr(aValue: Extended): String;
begin
  Result := FormatFloat('0.0####', aValue);
  Result := StringReplace(Result, DecimalSeparator, '.', []);
end;

function TppPDFCanvas.GetFontType(aFont: TFont; aTextMetric: TTextMetricA): TppPDFFontType;
var
  lbTrueType: Boolean;
  lbUnicode: Boolean;
begin

  lbTrueType := ((aTextMetric.tmPitchAndFamily and TMPF_TRUETYPE) = TMPF_TRUETYPE) or
                (not(TppPDFUtils.IsStandardFont(aFont)));

{$IFDEF UNICODE}
  lbUnicode := (PDFSettings.FontEncoding = feUnicode) and (TppPDFUtils.IsUnicodeFont(aFont));
{$ELSE}
  lbUnicode := False;
{$ENDIF}

  if lbTrueType then
    begin
      if lbUnicode then
        Result := pfType0
      else
        Result := pfTrueType;
    end
  else
    Result := pfType1;

end;

function TppPDFCanvas.GetPageHeight: Double;
begin
  Result := FPageHeightStack[FPageHeightPos - 1];

end;

procedure TppPDFCanvas.InitialGraphicsState;
var
  liIndex: Integer;
begin

  for liIndex := FGraphicsStateIndex downto 1 do
    begin
        WriteLine('Q');
        RestorePageHeight;
    end;

  FGraphicsStateIndex := 0;

end;

procedure TppPDFCanvas.SetPageHeight(aPageHeight: Double);
begin
  SavePageHeight(aPageHeight);

end;

function TppPDFCanvas.PopPageHeight: Double;
begin
  if FPageHeightPos > 0 then
    begin
      FPageHeightPos := FPageHeightPos - 1;
      Result := FPageHeightStack[FPageHeightPos - 1];
    end
  else
    Raise EReportBuilderError.Create('Stack Fault: Cannot pop value from empty stack.');

end;

procedure TppPDFCanvas.PushPageHeight(aPageHeight: Double);
begin
  if (Length(FPageHeightStack) = FPageHeightPos) or (FPageHeightStack = nil) then
    SetLength(FPageHeightStack, FPageHeightPos + 1);

  FPageHeightStack[FPageHeightPos] := aPageHeight;
  FPageHeightPos := FPageHeightPos + 1;

end;

procedure TppPDFCanvas.SetPDFSettings(aPDFSettings: TppPDFSettings);
begin
  if FPDFSettings <> aPDFSettings then
    FPDFSettings := aPDFSettings;
end;

procedure TppPDFCanvas.SetPDFXRef(aPDFXRef: TppPDFXRef);
begin
  if FPDFXRef <> aPDFXRef then
    FPDFXRef := aPDFXRef;
end;

procedure TppPDFCanvas.SetPrinter(const Value: TppPrinter);
begin
  FPrinter := Value;

end;

{TppPDFCanvas.WriteLine

  Writes a line of text to the main Device Stream including the Carrage
  Return and Line Feed characters. }
{$WARNINGS OFF}
procedure TppPDFCanvas.WriteLine(aLine: String);
begin
  {$IFDEF UNICODE}
  if (FCurrentFont <> nil) and (FCurrentFont.Charset = 2) then
    aLine := ppUnicodeSymbolsToAnsi(aLine);
  {$ENDIF}
  TppPDFUtils.WriteLine(FContentStream, aLine);

end;

{TppPDFCanvas.WriteMem

  Writes a line of text ot the main Device Stream without the CRLF
  characters. }

procedure TppPDFCanvas.WriteMem(aBuffer: String);
begin
  {$IFDEF UNICODE}
  if (FCurrentFont <> nil) and (FCurrentFont.Charset = 2) then
    aBuffer := ppUnicodeSymbolsToAnsi(aBuffer);
  {$ENDIF}
  TppPDFUtils.WriteMem(FContentStream, aBuffer);

end;
{$WARNINGS ON}

end.
