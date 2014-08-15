{*******************************************************************}
{                                                                   }
{       Developer Express Cross platform Visual Component Library   }
{       ExpressSpreadSheet				            }
{                                                                   }
{       Copyright (c) 2001-2010 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSSPREADSHEET AND ALL           }
{   ACCOMPANYING VCL AND CLX CONTROLS AS PART OF AN EXECUTABLE      }
{   PROGRAM ONLY.                                                   }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit cxSSPainterWrapper;

{$I cxVer.inc}

interface
uses
  SysUtils, Classes, {$IFDEF WINCLX} Windows, Graphics, {$ENDIF}
  Windows, Graphics, cxExcelConst, cxSSTypes;

type
  TcxFontStyles = Graphics.TFontStyles;
  TcxFontCharset = Graphics.TFontCharset;

  { TcxBackgroundMode }
  TcxBackgroundMode = (bmTransparent, bmOpaque);

  {TcxPaintObjects}
  TcxPaintObjects = (poBrush, poFont, poPen);
  TcxOrientation = (oHorz, oVert);

  { TcxSSTextExtents }
  TcxSSTextExtentsEx = record
     Size: TSize;
     SpaceWidth: Integer;
     LineHeight: Integer;
     TextWidths: array of Integer;
  end;

  { TcxCanvasWrapper }
  TcxCanvasWrapper = class
  private
    FBkColor: TColor;
    FBkMode: TcxBackgroundMode;
    FCanvas: TCanvas;
    FDefColors: array[Boolean, TcxPaintObjects] of TColor;
    FHighLightPalette: TcxExcelPalette;
    FTextColor: TColor;
    FFontHandle: TcxFontHandle;
    FPainterHandle: TcxPainterHandle;
    FPalette: Pointer;
    FSelectionColor: TColor;
    function GetDefBorderColor: TColor;
    function GetDefTextColor: TColor;
    function GetDefWindowColor: TColor;
    function GetPalette: PcxExcelPalette;
    procedure SetDefaultColor(const AValue: TColor; AObject: TcxPaintObjects);
    procedure SetDefBorderColor(const AValue: TColor);
    procedure SetDefTextColor(const AValue: TColor);
    procedure SetDefWindowColor(const AValue: TColor);
    procedure SetPalette(APalette: PcxExcelPalette);
    procedure SetSelectionColor(const AValue: TColor);
  protected
    function CheckHandle(AHandle: Integer): Boolean; overload;
    function CheckHandle(AHandle: TObject): Boolean; overload;
    procedure DrawLine(const AVertex: array of TRect;
      AStyle: TcxSSEdgeLineStyle; AOrientation: TcxOrientation);
    function GetWordFromPos(const AString: TcxString; var APos: Integer): TcxString; virtual;
    procedure HandlesNeeded; virtual;
    procedure SplitToTextBricks(const AText: TcxString; ARect: TRect;
      HAlign: TcxHorzTextAlign;  VAlign: TcxVertTextAlign; var ATextBricks: TWordExtents); virtual;
    procedure ReleaseHandles; virtual;
    class procedure CreateBrushStyles;
    class procedure CreatePenStyles;
    class procedure InitColors;
    class procedure RemoveBrushStyles;
    class procedure RemovePenStyles;
    property Palette: PcxExcelPalette read GetPalette write SetPalette;
  public
    constructor Create(APalette: PcxExcelPalette); virtual;
    destructor Destroy; override;
    procedure BeginPaint(ACanvas: TCanvas); overload;
    procedure BeginPaint(APalette: PcxExcelPalette; ACanvas: TCanvas); overload;
    procedure CalculateTextExtents(const AText: TcxString;const ATextRect: TRect;
      AHorzAlign: TcxHorzTextAlign; AVertAlign: TcxVertTextAlign;
      AWordBreak: Boolean; var ATextParams: TcxTextParameters);
    procedure DrawText(const AText: TcxString; const ARect: TRect);
    procedure DrawTriangleGlyph(const ARect: TRect; AColor: TColor;
      ALeftToRight: Boolean; IsDrawLine: Boolean);
    procedure EndPaint; virtual;
    procedure ExcludeClipRect(const ARect: TRect); overload;
    procedure ExcludeClipRect(X1, Y1, X2, Y2: Integer); overload;
    procedure ExcludeClipRgn(const APoints: array of TPoint);
    procedure ExDrawText(const AClipRect: TRect;
      const AextTextParams: TcxTextParameters); virtual;
    procedure FillRect(const ARect: TRect; AStyle: TcxSSFillStyle;
      const ABkColor, AFgColor: TColor); overload;
    procedure FillRect(const ARect: TRect; AStyle: TcxSSFillStyle;
      const ABkColor, AFgColor: Word; IsSelected: Boolean); overload;
    procedure FrameRect(const ARect: TRect; AColor: TColor;
      IsSelected: Boolean = False); overload;
    procedure FrameRect(const ARect: TRect; const ATopColor,  ABottomColor: TColor;
      IsSelected: Boolean = False); overload;
    class function GetNativeColor(const AColor: TColor): Integer; register;
    function GetTextExtent(const AText: TcxString): TPoint;
    procedure InvertRect(const ARect: TRect);
    procedure Line(const AVertex: TRect; AStyle: TcxSSEdgeLineStyle;
      AOrientation: TcxOrientation; ABkColor, AFgColor: TColor); overload;
    procedure Line(const AVertex: array of TRect; AStyle: TcxSSEdgeLineStyle;
      AOrientation: TcxOrientation; ABkColor, AFgColor: Word; IsSelected: Boolean); overload;
    procedure PaletteChanged; virtual;
    procedure Polygon(const APoints: array of TPoint; const AColor: TColor);
    procedure Rectangle(const ARect: TRect; const ABrush: TcxFillBrushHandle);
    function RectIsVisible(ARect: TRect): Boolean;
    procedure SelectFont(AFont: TFont); overload;
    {$IFDEF WINCLX}
    procedure SelectFont(const AFont: QFontH); overload;
    {$ENDIF}
    procedure SelectFont(const AFont: TcxFontHandle;
      ACheckSettings: Boolean = True); overload;
    procedure SelectFont(const AFont: TcxFontHandle; AColor: Word); overload;
    procedure SetBkMode(AMode: TcxBackgroundMode);
    procedure SetSingleText(const AText: TcxString; const ATextRect: TRect;
      var ATextSettings: TcxTextParameters; AVertCenterAlign: Boolean = True); virtual;
    procedure SetBkColor(AColor: TColor); overload;
    procedure SetBkColor(AColor: Word; IsSelected: Boolean;
      AObject: TcxPaintObjects); overload;
    procedure SetTextColor(AColor: TColor); overload;
    procedure SetTextColor(AColor: Word; IsSelected: Boolean;
      AObject: TcxPaintObjects); overload;
    function TextWidth(const AText: TcxString): Integer;
    function TextHeight(const AText: TcxString): Integer;
    class function MixColors(ASelColor, ASrcColor: TColor): TColor;
    property BorderColor: TColor read GetDefBorderColor write SetDefBorderColor;
    property Canvas: TCanvas read FCanvas write FCanvas;
    property Handle: TcxPainterHandle read FPainterHandle;
    property TextColor: TColor read GetDefTextColor write SetDefTextColor;
    property WindowColor: TColor read GetDefWindowColor write SetDefWindowColor;
    property SelectionColor: TColor read FSelectionColor write SetSelectionColor;
  end;

const
  cxPenWidth: array[TcxSSEdgeLineStyle] of Byte =
    (1, 1, 2, 1, 1, 3, 3, 1, 2, 1, 2, 1, 2, 2, 0);
  cxHalfPenWidth: array[TcxSSEdgeLineStyle] of Byte =
    (1, 1, 2, 1, 1, 2, 2, 1, 2, 1, 2, 1, 2, 2, 0);

  cxBlackColor: Integer = clBlack;
  cxWhiteColor: Integer = clWhite;
  cxBtnFaceColor: Integer = clBtnFace;
  cxBtnShadowColor: Integer = clBtnShadow;
  cxBtnHighLightColor: Integer = clBtnHighLight;

  function ColorToRGB(const AColor: TColor): Integer;

  function RectHeight(const ARect: TRect): Integer;
  function RectWidth(const ARect: TRect): Integer;

implementation

uses
  dxCore;

type
  PPoints = ^TPoints;
  TPoints = array[0..MaxInt div SizeOf(TPoint) - 1] of TPoint;
  TCanvasAccess = class(TCanvas);

  TRGB = packed record
    R, G, B, A: Byte;
  end;

var
  APenBrushes: array[0..9, TcxOrientation] of TcxFillBrushHandle;
  DefaultPens: array[0..16, TcxOrientation] of TcxFillBrushHandle;
  DefaultBrushes: array[TcxSSFillStyle] of TcxFillBrushHandle;

const
  BrushReference: Integer = 0;
  PenReference: Integer = 0;
  EmptyHandle:  Integer = 0 ;

  BrushPatterns: array[TcxSSFillStyle, 0..7] of Word =
  (($00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF),
   ($00AA, $0000, $0055, $0000, $00AA, $0000, $0055, $0000),
   ($00AA, $0055, $00AA, $0055, $00AA, $0055, $00AA, $0055),
   ($00FF, $0055, $00FF, $00AA, $00FF, $0055, $00FF, $00AA),
   ($00FF, $0077, $00FF, $00DD, $00FF, $0077, $00FF, $00DD),
   ($00FF, $0077, $00FF, $00FF, $00FF, $00DD, $00FF, $00FF),
   ($00FF, $0000, $0000, $00FF, $00FF, $0000, $0000, $00FF),
   ($0066, $0066, $0066, $0066, $0066, $0066, $0066, $0066),
   ($0033, $0099, $00CC, $0066, $0033, $0099, $00CC, $0066),
   ($0099, $0033, $0066, $00CC, $0099, $0033, $0066, $00CC),
   ($0033, $0033, $00CC, $00CC, $0033, $0033, $00CC, $00CC),
   ($0011, $0011, $0044, $0044, $0011, $0011, $0044, $0044),
   ($00FF, $0000, $00FF, $00FF, $00FF, $0000, $00FF, $00FF),
   ($0077, $0077, $0077, $0077, $0077, $0077, $0077, $0077),
   ($0077, $00BB, $00DD, $00EE, $0077, $00BB, $00DD, $00EE),
   ($00BB, $0077, $00EE, $00DD, $00BB, $0077, $00EE, $00DD),
   ($0077, $0000, $0077, $0077, $0077, $0000, $0077, $0077),
   ($00AA, $0077, $00AA, $00DD, $00AA, $0077, $00AA, $00DD));

function ColorToRGB(const AColor: TColor): Integer;
begin
  Result := Graphics.ColorToRGB(AColor)
end;

function RectHeight(const ARect: TRect): Integer;
begin
  Result := ARect.Bottom - ARect.Top;
  if Result < 0 then
    Result := 0;
end;

function RectWidth(const ARect: TRect): Integer;
begin
  Result := ARect.Right - ARect.Left;
  if Result < 0 then
    Result := 0;
end;

{ TcxCanvasWrapper }
constructor TcxCanvasWrapper.Create(APalette: PcxExcelPalette);
begin
  HandlesNeeded;
  FPalette := APalette;
  FSelectionColor := GetNativeColor(clHighLight);
  WindowColor := GetNativeColor(clWindow);
  PaletteChanged;
  BorderColor := clBtnFace;
end;

destructor TcxCanvasWrapper.Destroy;
begin
  ReleaseHandles;
  inherited Destroy;
end;

procedure TcxCanvasWrapper.BeginPaint(ACanvas: TCanvas);

  function GetHandle(AHandle: HDC): HDC; overload;
  begin
    Result := AHandle;
  end;
  {$IFDEF WINCLX}
  function GetHandle(AHandle: QPainterH): HDC; overload;
  begin
    Result := QPainter_Handle(AHandle)
  end;
  {$ENDIF}
begin
  if ACanvas <> nil then
    FPainterHandle := GetHandle(ACanvas.Handle)
  else
    FPainterHandle := EmptyHandle;
  FCanvas := ACanvas;
  SetBkMode(bmTransparent);
  Windows.SetTextColor(FPainterHandle, ColorToRGB(FTextColor));
  Windows.SetBkColor(FPainterHandle, ColorToRGB(FBkColor));
  SelectObject(FPainterHandle, FFontHandle);
end;

procedure TcxCanvasWrapper.BeginPaint(APalette: PcxExcelPalette; ACanvas: TCanvas);
begin
  if APalette <> nil then
  begin
    FPalette := APalette;
    PaletteChanged;
  end;
  BeginPaint(ACanvas);
end;

procedure TcxCanvasWrapper.CalculateTextExtents(const AText: TcxString;
  const ATextRect: TRect; AHorzAlign: TcxHorzTextAlign; AVertAlign: TcxVertTextAlign;
  AWordBreak: Boolean; var ATextParams: TcxTextParameters);
  
begin
  with ATextParams do
  begin
    WordBreak := AWordBreak;
    HorzAlign := AHorzAlign;
    VertAlign := AVertAlign;
    FontHandle := FFontHandle;
    case AHorzAlign of
      haGENERAL, haLEFT, haFILL, haJUSTIFY:
        XPos := ATextRect.Left + 3;
      haCENTER:
        XPos := (ATextRect.Left + ATextRect.Right) shr 1;
      haRIGHT:
        XPos := ATextRect.Right - 3;
    end;
    if (AHorzAlign = haFill) or (not AWordBreak) then
    begin
       SetLength(TextBricks, 1);
       with TextBricks[0] do
       begin
         case AVertAlign of
          vaTOP, vaJUSTIFY:
            YPos := ATextRect.Top;
          vaCENTER:
            YPos := (ATextRect.Bottom + ATextRect.Top - TextHeight(AText)) shr 1;
          vaBOTTOM:
            YPos := ATextRect.Bottom - TextHeight(AText) ;
         end;
         Text := AText;
       end;
    end
    else
      if AWordBreak then
        SplitToTextBricks(AText, ATextRect, AHorzAlign, AVertAlign, TextBricks);
   end;
end;

procedure TcxCanvasWrapper.DrawText(const AText: TcxString; const ARect: TRect);
var
  H: Integer;
begin
  if not RectIsVisible(ARect) then Exit;
  SetBkMode(bmTransparent);
  SetTextAlign(FPainterHandle, TA_Bottom or TA_Center);
  H := TextHeight(AText);
  with ARect do
    ExtTextOut(FPainterHandle, (Right + Left) shr 1, (Top + Bottom + H) shr 1,
      ETO_CLIPPED, @ARect, PChar(AText), Length(AText), nil);
end;

procedure TcxCanvasWrapper.DrawTriangleGlyph(const ARect: TRect; AColor: TColor;
  ALeftToRight: Boolean; IsDrawLine: Boolean);
var
  H, W: Integer;
  AOfs, AWOfs: Byte;
  APolygon: array[0..2] of TPoint;
  I: Integer;
  AR: TRect;

const
  AOffset: array[Boolean] of ShortInt = (-1, 0);

begin
  W := ARect.Right - ARect.Left;
  H := ARect.Bottom - ARect.Top;
  AOfs := (H div 3) shr 1 - 1;
  H := H div 3;
  AWOfs := (W - (H + 2)) shr 1;
  APolygon[0] := Point(AWOfs, AOfs);
  APolygon[1] := Point(AWOfs, AOfs + H * 2 + 2);
  APolygon[2] := Point(AWOfs + H + 1, AOfs + H + 1);
  for I := 0 to 2 do
  begin
    Inc(APolygon[I].Y, ARect.Top);
    if ALeftToRight then
      Inc(APolygon[I].X, ARect.Left)
    else
      APolygon[I].X := ARect.Right - APolygon[I].X - 2;
    if IsDrawLine then
      if ALeftToRight then
        Dec(APolygon[I].X, 1)
      else
        Inc(APolygon[I].X, 1);
  end;
  if IsDrawLine then
  begin
    AR := Rect(APolygon[2].X, APolygon[0].Y + 1,  APolygon[2].X, APolygon[1].Y - 1);
    OffsetRect(AR, AOffset[ALeftToRight], 0);
    FillRect(AR, fsSolid, clBlack, clBlack);
  end;
  Canvas.Pen.Style := psClear;
  Polygon(APolygon, clBlack);
end;

procedure TcxCanvasWrapper.EndPaint;
begin
  FCanvas := nil;
  FFontHandle := EmptyHandle;
end;

procedure TcxCanvasWrapper.ExcludeClipRect(const ARect: TRect);
begin
  with ARect do
    ExcludeClipRect(Left, Top, Right, Bottom);
end;

procedure TcxCanvasWrapper.ExcludeClipRect(X1, Y1, X2, Y2: Integer);
begin
  Windows.ExcludeClipRect(FPainterHandle, X1, Y1, X2 + 1, Y2 + 1);
end;

procedure TcxCanvasWrapper.ExcludeClipRgn(const APoints: array of TPoint);
var
  ARegion: TcxRegionHandle;
begin
  ARegion := CreatePolygonRgn(APoints, Length(APoints), Alternate);
  Windows.ExtSelectClipRgn(FPainterHandle, ARegion, RGN_DIFF);
  DeleteObject(ARegion);
end;

procedure TcxCanvasWrapper.ExDrawText(const AClipRect: TRect;
 const AextTextParams: TcxTextParameters);
var
  I: Integer;
const
  AHorzTextAlign: array[TcxHorzTextAlign] of Word =
    (TA_LEFT, TA_LEFT, TA_CENTER, TA_RIGHT, TA_LEFT, TA_LEFT);
begin
  if not RectIsVisible(AClipRect) then Exit;
  if Length(AextTextParams.TextBricks) > 0 then
  begin
    with AextTextParams do
    begin
      SelectFont(FontHandle);
      if FontColor <> $FFFF then
        SetTextColor(FontColor, False, poFont);
      SetBkMode(bmTransparent);
      SetTextAlign(FPainterHandle, AHorzTextAlign[HorzAlign] or TA_TOP);
      for I := 0 to Length(TextBricks) - 1 do
       if Length(TextBricks[I].Text) > 0 then
          with TextBricks[I] do
          begin
            if HorzAlign = haJustify then
              SetTextJustification(FPainterHandle, BreakExtra, BreakCount);
            ExtTextOut(FPainterHandle, XPos, YPos - 2, ETO_CLIPPED, @AClipRect,
              @Text[1], Length(Text), nil);
          end;
       if HorzAlign = haJustify then
         SetTextJustification(FPainterHandle, 0, 1);
    end;
  end;
end;

procedure TcxCanvasWrapper.FillRect(const ARect: TRect; AStyle: TcxSSFillStyle;
  const ABkColor, AFgColor: TColor);
begin
  if RectIsVisible(ARect) then
  begin
    SetBkColor(ColorToRgb(ABkColor));
    SetTextColor(ColorToRgb(AFgColor));
    Rectangle(ARect, DefaultBrushes[AStyle]);
  end;
end;

procedure TcxCanvasWrapper.FillRect(const ARect: TRect; AStyle: TcxSSFillStyle;
  const ABkColor, AFgColor: Word; IsSelected: Boolean);
begin
  SetBkColor(ABkColor, IsSelected, poBrush);
  if AFgColor < 55 then
    SetTextColor(AFgColor, IsSelected, poBrush)
  else
  begin
    if IsSelected then
      SetTextColor(MixColors(SelectionColor, clBlack))
    else
      SetTextColor(clBlack);
  end;
  Rectangle(ARect, DefaultBrushes[AStyle]);
end;

procedure TcxCanvasWrapper.FrameRect(const ARect: TRect; AColor: TColor;
  IsSelected: Boolean = False);
begin
  if not RectIsVisible(ARect) then Exit;
  with ARect do
  begin
    if IsSelected then
      AColor := MixColors(FSelectionColor, AColor);
    AColor := Windows.SetBkColor(FPainterHandle, ColorToRgb(AColor));
    Windows.FrameRect(FPainterHandle,
      Rect(Left, Top, Right + 1, Bottom + 1),  DefaultBrushes[fsSolid]);
    Windows.SetBkColor(FPainterHandle, AColor);
  end;
end;

procedure TcxCanvasWrapper.FrameRect(const ARect: TRect;
  const ATopColor, ABottomColor: TColor; IsSelected: Boolean = False);
var
  AC: Integer;

begin
  if not RectIsVisible(ARect) then Exit;
  with ARect do
  begin
    AC := Windows.SetBkColor(FPainterHandle, ColorToRgb(ATopColor));
    Windows.FillRect(FPainterHandle,
      Rect(Left, Top, Right, Top + 1), DefaultBrushes[fsSolid]);
    Windows.FillRect(FPainterHandle,
      Rect(Left, Top, Left + 1, Bottom + 1), DefaultBrushes[fsSolid]);
    Windows.SetBkColor(FPainterHandle, ColorToRgb(ABottomColor));
    Windows.FillRect(FPainterHandle,
      Rect(Right, Top, Right + 1, Bottom + 1), DefaultBrushes[fsSolid]);
    Windows.FillRect(FPainterHandle,
      Rect(Left + 1, Bottom, Right, Bottom + 1), DefaultBrushes[fsSolid]);
    Windows.SetBkColor(FPainterHandle, ColorToRgb(AC));
  end;
end;

class function TcxCanvasWrapper.GetNativeColor(const AColor: TColor): Integer;
begin
  Result := Graphics.ColorToRgb(AColor);
end;

function TcxCanvasWrapper.GetTextExtent(const AText: TcxString): TPoint;
var
  DC: TcxPainterHandle;

begin
  FillChar(Result, SizeOf(Result), 0);
  DC := GetDC(0);
  try
    FFontHandle := SelectObject(DC, FFontHandle);
    GetTextExtentPoint32(DC, @AText[1], Length(AText), TSize(Result));
    FFontHandle := SelectObject(DC, FFontHandle);
  finally
    ReleaseDC(0, DC);
  end;
end;

procedure TcxCanvasWrapper.InvertRect(const ARect: TRect);
begin
  with ARect do
    Windows.InvertRect(FPainterHandle, Rect(Left, Top, Right, Bottom));
end;

procedure TcxCanvasWrapper.Line(const AVertex: TRect; AStyle: TcxSSEdgeLineStyle;
  AOrientation: TcxOrientation; ABkColor, AFgColor: TColor);
begin
  SetBkColor(ABkColor);
  SetTextColor(AFgColor);
  DrawLine(AVertex, AStyle, AOrientation);
end;

procedure TcxCanvasWrapper.Line(const AVertex: array of TRect; AStyle: TcxSSEdgeLineStyle;
  AOrientation: TcxOrientation; ABkColor, AFgColor: Word; IsSelected: Boolean);
begin
  if AStyle = lsDefault then
    SetTextColor(BorderColor)
  else
  begin
    if AFgColor > 55 then
      SetTextColor(GetNativeColor(clWindowText), IsSelected, poPen)
    else
      SetTextColor(AFgColor, IsSelected, poPen);
    SetBkColor(ABkColor, IsSelected, poBrush);
  end;
  DrawLine(AVertex, AStyle, AOrientation);
end;

procedure TcxCanvasWrapper.PaletteChanged;
var
  I: Integer;
begin
  for I := 0 to High(TcxExcelPalette) do
    FHighLightPalette[I] := MixColors(FSelectionColor, Palette^[I]);
  for I := 0 to Byte(High(FDefColors[False])) do
   FDefColors[True, TcxPaintObjects(I)] :=
     MixColors(FSelectionColor, FDefColors[True, TcxPaintObjects(I)]);
end;

procedure TcxCanvasWrapper.Polygon(const APoints: array of TPoint; const AColor: TColor);
begin
  SetTextColor(AColor);
  SetBkColor(AColor);
  Canvas.Brush.Color := AColor;
  Canvas.Brush.Style := bsSolid;
  Canvas.Pen.Style := psClear;
  Canvas.Polygon(APoints );
end;

procedure TcxCanvasWrapper.Rectangle(const ARect: TRect; const ABrush: TcxFillBrushHandle);
begin
  if not RectIsVisible(ARect) then Exit;
  with ARect do
    Windows.FillRect(FPainterHandle, Rect(Left, Top, Right + 1, Bottom + 1), ABrush);
end;

function TcxCanvasWrapper.RectIsVisible(ARect: TRect): Boolean;
begin
  Result := True;
end;

procedure TcxCanvasWrapper.SetBkMode(AMode: TcxBackgroundMode);
begin
  FBkMode := AMode;
  Windows.SetBkMode(FPainterHandle, Byte(AMode));
end;

procedure TcxCanvasWrapper.SetSingleText(const AText: TcxString; const ATextRect: TRect;
  var ATextSettings: TcxTextParameters; AVertCenterAlign: Boolean = True);
begin
  with ATextSettings do
  begin
    SetLength(TextBricks, 1);
    TextBricks[0].Text := AText;
    FontHandle := FFontHandle;
    HorzAlign := haCenter;
    if not AVertCenterAlign then
      VertAlign := vaBottom
    else
      VertAlign := vaCenter;
    XPos := (ATextRect.Left + ATextRect.Right) shr 1;
    if AVertCenterAlign then
      TextBricks[0].YPos :=
        (ATextRect.Bottom + ATextRect.Top - TextHeight(AText)) shr 1
    else
      TextBricks[0].YPos :=
        (ATextRect.Bottom - TextHeight(AText)) ;
  end;
end;

procedure TcxCanvasWrapper.SelectFont(const AFont: TcxFontHandle;
  ACheckSettings: Boolean = True);
begin
  if (not ACheckSettings) or (FFontHandle <> AFont) then
  begin
    FFontHandle := AFont;
    SelectObject(FPainterHandle, FFontHandle);
  end;
end;

procedure TcxCanvasWrapper.SelectFont(AFont: TFont);
begin
  SetTextColor(GetNativeColor(AFont.Color));
  FFontHandle :=
    {$IFNDEF WINCLX} AFont.Handle {$ELSE} QFont_Handle(AFont.Handle) {$ENDIF};
  SelectObject(FPainterHandle, FFontHandle);
end;

{$IFDEF WINCLX}
procedure TcxCanvasWrapper.SelectFont(const AFont: QFontH);
begin
  SelectFont(QFont_handle(AFont));
end;
{$ENDIF}

procedure TcxCanvasWrapper.SelectFont(const AFont: TcxFontHandle; AColor: Word);
begin
  SelectFont(AFont);
  SetTextColor(AColor, False, poFont)
end;

procedure TcxCanvasWrapper.SetBkColor(AColor: TColor);
begin
  FBkColor := ColorToRgb(AColor);
  Windows.SetBkColor(FPainterHandle, FBkColor);
end;

procedure TcxCanvasWrapper.SetBkColor(AColor: Word;
  IsSelected: Boolean; AObject: TcxPaintObjects);
var
  AColorValue: TColor;
begin
  if AColor <= 55 then
  begin
    if not IsSelected then
      AColorValue := Palette^[AColor]
    else
      AColorValue := FHighLightPalette[AColor];
  end
  else
    AColorValue := FDefColors[IsSelected, AObject];
  SetBkColor(AColorValue);
end;

procedure TcxCanvasWrapper.SetTextColor(AColor: TColor);
begin
  FTextColor := ColorToRgb(AColor);
  Windows.SetTextColor(FPainterHandle, FTextColor);
end;

procedure TcxCanvasWrapper.SetTextColor(AColor: Word;
  IsSelected: Boolean; AObject: TcxPaintObjects);
var
  AColorValue: TColor;
begin
  if AColor <= 55 then
  begin
    if not IsSelected then
      AColorValue := Palette^[AColor]
    else
      AColorValue := FHighLightPalette[AColor]
  end
  else
    AColorValue := FDefColors[IsSelected, AObject];
  SetTextColor(AColorValue);
end;

function TcxCanvasWrapper.TextWidth(const AText: TcxString): Integer;
begin
  Result := GetTextExtent(AText).X;
end;

function TcxCanvasWrapper.TextHeight(const AText: TcxString): Integer;
begin
  Result := GetTextExtent(AText).Y;
end;

class function TcxCanvasWrapper.MixColors(ASelColor, ASrcColor: TColor): TColor;

  function GetLightValue(ASrcValue, ASelValue: Byte): Integer;
  const
    Alfa = $5C;
    Alfa2 = $FF - $5C;
  begin
    Result := Round((ASelValue * Alfa + ASrcValue * Alfa2) / 255);
  end;

begin
  ASrcColor := ColorToRGB(ASrcColor);
  ASelColor := ColorToRGB(ASelColor);
  Result := GetLightValue(GetRValue(ASrcColor), GetRValue(ASelColor)) or
   (GetLightValue(GetGValue(ASrcColor), GetGValue(ASelColor)) shl 8) or
      (GetLightValue(GetBValue(ASrcColor), GetBValue(ASelColor)) shl 16);
end;

function TcxCanvasWrapper.CheckHandle(AHandle: Integer): Boolean;
begin
  Result := AHandle <> 0;
end;

function TcxCanvasWrapper.CheckHandle(AHandle: TObject): Boolean;
begin
  Result := AHandle <> nil;
end;

procedure TcxCanvasWrapper.DrawLine(const AVertex: array of TRect;
  AStyle: TcxSSEdgeLineStyle; AOrientation: TcxOrientation);
var
  ARect: TRect;
  I: Byte;
const
  AOffset: array[TcxOrientation, 0..1] of Byte = ((0, 1), (1, 0));
begin
  case AStyle of
    lsDefault, lsThin, lsDashed, lsDotted, lsThick, lsHair, lsMediumDashed,
    lsMedium, lsDashDot, lsMediumDashDot, lsDashDotDot, lsMediumDashDotDot, lsNone:
      Rectangle(AVertex[0], DefaultPens[Byte(AStyle), AOrientation]);
    lsDouble:
    begin
      if Length(AVertex) <> 1 then
        for I := 0 to 2 do
          Rectangle(AVertex[I], APenBrushes[Byte(I = 1), AOrientation])
      else
      begin
        ARect := AVertex[0];
        if AOrientation = oHorz then
          ARect.Bottom := ARect.Top
        else
          ARect.Right := ARect.Left;
        for I := 0 to 2 do
        begin
          OffsetRect(ARect, AOffset[AOrientation, 0], AOffset[AOrientation, 1]);
          Rectangle(ARect, APenBrushes[Byte(I = 1), AOrientation])
        end;
      end;
    end;
    lsSlantedDashDot:
    begin
      if AOrientation = oHorz then
        with AVertex[0] do
          ARect := Rect(Left, Top, Right, Top)
      else
        with AVertex[0] do
          ARect := Rect(Left, Top, Left, Bottom);
      Rectangle(ARect, DefaultPens[Byte(AStyle),  AOrientation]);
      OffsetRect(ARect, AOffset[AOrientation, 0], AOffset[AOrientation, 1]);
      Rectangle(ARect, APenBrushes[9, AOrientation]);
    end;
  end;
end;

function TcxCanvasWrapper.GetWordFromPos(const AString: TcxString;
  var APos: Integer): TcxString;

  function IsDelimiterChar: Boolean;
  begin
    Result := (APos <= Length(AString)) and (Byte(AString[APos]) <= 32);
  end;

var
  IsDelimiterStr: Boolean;
  AStartPos: Integer;
begin
  AStartPos := APos;
  IsDelimiterStr := IsDelimiterChar;
  while (APos <= Length(AString)) and (IsDelimiterChar = IsDelimiterStr) do
  begin
    if Byte(AString[APos]) in [9, 10, 13] then Break;
    Inc(APos);
  end;
  Result := Copy(AString, AStartPos, APos - AStartPos);
end;

procedure TcxCanvasWrapper.HandlesNeeded;
begin
  CreateBrushStyles;
  CreatePenStyles;
end;

procedure TcxCanvasWrapper.SplitToTextBricks(const AText: TcxString; ARect: TRect;
  HAlign: TcxHorzTextAlign; VAlign: TcxVertTextAlign; var ATextBricks: TWordExtents);
var
  AHeight, AWidth: Integer;
  AWordCount, APos, LineHeight, DY: Integer;
  DC: TcxPainterHandle;
  AFont: HFont;

  function ExTextExtent(StrPtr: PcxString; StrLen: Integer): TSize;
  begin
    GetTextExtentPoint32(DC, StrPtr, StrLen, Result);
  end;

  procedure AdjustWords(var AText: TcxString);
  var
    APos: Integer;
  begin
    APos := Pos(' ', AText);
    if APos > 0 then
    begin
      while ExTextExtent(@AText[1], Length(AText)).cx <= AWidth do
      begin
        while AText[APos] <> ' ' do
        begin
          Inc(APos);
          if APos >= Length(AText) then
            APos := 1;
        end;
        while (AText[APos] = ' ') and (APos < Length(AText)) do
          Inc(APos);
        Insert(' ', AText, APos);
        if APos < Length(AText) then
          Inc(APos)
        else
          APos := 1;
      end;
    end
    else
      while TextWidth(AText) <= AWidth do AText := AText + ' ';
  end;

  procedure ScanWord(const AText: TcxString; var StartPos: Integer; var TextBrick: TcxTextBrick);
  var
    I: Integer;
    BreakPos: Integer;
    Count: Integer;
    W: Integer;
    EndPos: Integer;
  begin
    BreakPos := 0;
    TextBrick.Text := '';
    Count := 0;
    while (StartPos <= Length(AText)) and (AText[StartPos] = ' ') do
      Inc(StartPos);
    EndPos := StartPos;
    for I := StartPos to Length(AText) do
    begin
      Inc(EndPos);
      if AText[I] = #10 then
        Break
      else
      begin
        Inc(Count);
        if dxCharInSet(AText[I], [' ', '-']) then
           BreakPos := Count;
        W := ExTextExtent(@AText[StartPos], Count).CX;
        if W > AWidth then
        begin
          if (I > BreakPos) and (Count > 1) then
          begin
            Dec(Count);
            Dec(EndPos);
          end;
          if BreakPos <> 0 then
          begin
            Count := BreakPos;
            EndPos := StartPos + Count;
          end;
          Break;
        end;
      end;
    end;
    while (Count > 0) and (AText[StartPos + Count - 1] = ' ') do
      Dec(Count);
    if Count = 0 then
    begin
      TextBrick.Text := '';
      StartPos := EndPos;
    end
    else
    begin
      with TextBrick do
      begin
        TextBrick.Text := Copy(AText, StartPos, Count);
        if HAlign = haJustify then
        begin
          BreakCount := 0;
          BreakExtra := 1;
          for I := 1 to Length(Text) do
            if Text[I] = ' ' then Inc(BreakCount);
          if BreakCount > 0 then
          begin
            while AWidth > ExTextExtent(@AText[StartPos], Count).CX do
            begin
              Inc(BreakExtra);
              SetTextJustification(DC, BreakExtra, BreakCount);
            end;
          end;
        end;
      end;
      StartPos := EndPos;
    end;
  end;

begin
  DC := GetDC(0);
  AFont := SelectObject(DC, FFontHandle);
  AWordCount := 0;
  try
    AWidth := ARect.Right - ARect.Left - 2;
    AHeight := ARect.Bottom - ARect.Top - 2;
    APos := 1;
    LineHeight := TextHeight('Wg');
    while APos <= Length(AText) do
    begin
      Inc(AWordCount);
      SetLength(ATextBricks, AWordCount);
      ScanWord(AText, APos, ATextBricks[AWordCount - 1]);
      ATextBricks[AWordCount - 1].YPos := LineHeight * (AWordCount - 1) + ARect.Top;
    end;
  finally
    SelectObject(DC, AFont);
    ReleaseDC(0, DC);
  end;
  if AWordCount > 0 then
  begin
    if (VAlign <> vaTop) and (AWordCount * LineHeight < AHeight) then
    begin
      case VAlign of
        vaCENTER:
        begin
          DY := (AHeight - AWordCount * LineHeight) shr 1;
          for APos := 0 to AWordCount - 1 do
            Inc(ATextBricks[APos].YPos, DY);
        end;
        vaBOTTOM:
        begin
          for APos := 0 to AWordCount - 1 do
            ATextBricks[APos].YPos := ARect.Bottom - (AWordCount - APos) * LineHeight;
        end;
        vaJUSTIFY:
        if AWordCount > 1 then
        begin
          DY := Round((AHeight - (AWordCount * LineHeight)) / (AWordCount - 1));
          for APos := 1 to AWordCount - 1 do
            Inc(ATextBricks[APos].YPos, DY * APos);
        end;
      end;
    end;
  end;
//  2.1746082936777702243371855880354e-4
end;

procedure TcxCanvasWrapper.ReleaseHandles;
begin
  RemoveBrushStyles;
  RemovePenStyles;
end;

class procedure TcxCanvasWrapper.CreateBrushStyles;

var
  I: TcxSSFillStyle;
  ABitmap: HBitmap;
begin
  Inc(BrushReference);
  if BrushReference = 1 then
  begin
    for I := Low(TcxSSFillStyle) to High(TcxSSFillStyle) do
    begin
      ABitmap := CreateBitmap(8, 8, 1, 1, @BrushPatterns[I]);
      DefaultBrushes[I] := CreatePatternBrush(ABitmap);
      DeleteObject(ABitmap);
    end;
  end;
end;

class procedure TcxCanvasWrapper.CreatePenStyles;
const
  APatterns: array[0..9] of string =
  ('11111111', '00000000', '11101110',
   '11001100',  '10101010',  '111111111000',
   '111111111000111000', '111000111000111111111000',
   '011111111111011111', '111111111100111100');

  ABrushNumbers: array[0..16] of Byte =
    (0, 0, 0, 2, 3, 0, 0, 4, 5, 6, 6, 7, 7, 8, 1, 9, 1);

  procedure WN_CreatePens;
  var
    K: TcxOrientation;
    I, J, L: Integer;
    AColor: Integer;
    DC: HDC;
    ABitmap: HBitmap;
  begin
    DC := CreateCompatibleDC(0);
    for K := oHorz to oVert do
    begin
      for I := 0 to High(APatterns) do
      begin
        if K = oHorz then
          ABitmap := CreateBitmap(Length(APatterns[I]), 8, 1, 1, nil)
        else
          ABitmap := CreateBitmap(8, Length(APatterns[I]), 1, 1, nil);
        ABitmap := SelectObject(DC, ABitmap);
        for L := 0 to 8 do
        begin
          for J := 0 to Length(APatterns[I]) - 1 do
          begin
            if APatterns[I][J + 1] = '1' then
              AColor := ColorToRGB(clBlack)
            else
              AColor := ColorToRGB(clWhite);
            if K = oHorz then
              SetPixel(DC, J, L, AColor)
            else
              SetPixel(DC, L, J, AColor);
          end;
        end;
        ABitmap := SelectObject(DC, ABitmap);
        APenBrushes[I, K] := CreatePatternBrush(ABitmap);
        DeleteObject(ABitmap);
      end;
    end;
    DeleteDC(DC);
  end;

var
  K: TcxOrientation;
  I: Integer;

begin
  Inc(PenReference);
  if PenReference = 1 then
  begin
    WN_CreatePens;
    for K := oHorz to oVert do
      for I := 0 to High(DefaultPens) do
        DefaultPens[I, K] := APenBrushes[ABrushNumbers[I], K];
  end;
end;

class procedure TcxCanvasWrapper.InitColors;
begin
  cxWhiteColor := GetNativeColor(clWhite); 
  cxBlackColor := GetNativeColor(clBlack);
  cxBtnFaceColor := GetNativeColor(clBtnFace);
  cxBtnShadowColor := GetNativeColor(clBtnShadow);
  cxBtnHighLightColor := GetNativeColor(clBtnHighLight);
end;

class procedure TcxCanvasWrapper.RemoveBrushStyles;
var
  I: TcxSSFillStyle;
begin
  Dec(BrushReference);
  if BrushReference = 0 then
    for I := Low(TcxSSFillStyle) to High(TcxSSFillStyle) do
      DeleteObject(DefaultBrushes[I]);
end;

class procedure TcxCanvasWrapper.RemovePenStyles;
var
  I: Integer;
  K: TcxOrientation;
begin
  Dec(PenReference);
  if PenReference = 0 then
    for K := oHorz to oVert do
      for I := 0 to High(APenBrushes) do
      begin
        DeleteObject(APenBrushes[I, K]);
      end;
end;

function TcxCanvasWrapper.GetDefBorderColor: TColor;
begin
  Result := FDefColors[False, poPen]
end;

function TcxCanvasWrapper.GetDefTextColor: TColor;
begin
  Result := FDefColors[False, poFont]
end;

function TcxCanvasWrapper.GetDefWindowColor: TColor;
begin
  Result := FDefColors[False, poBrush]
end;

function TcxCanvasWrapper.GetPalette: PcxExcelPalette;
begin
  Result := FPalette; 
end;

procedure TcxCanvasWrapper.SetDefaultColor(const AValue: TColor;
  AObject: TcxPaintObjects);
begin
  FDefColors[False, AObject] := ColorToRGB(AValue);
  FDefColors[True, AObject] := MixColors(FSelectionColor, AValue);
end;

procedure TcxCanvasWrapper.SetDefBorderColor(const AValue: TColor);
begin
  SetDefaultColor(AValue, poPen);
end;

procedure TcxCanvasWrapper.SetDefTextColor(const AValue: TColor);
begin
  SetDefaultColor(AValue, poFont);
end;

procedure TcxCanvasWrapper.SetDefWindowColor(const AValue: TColor);
begin
  SetDefaultColor(AValue, poBrush);
end;

procedure TcxCanvasWrapper.SetPalette(APalette: PcxExcelPalette);
begin
  FPalette := APalette;
  PaletteChanged; 
end;

procedure TcxCanvasWrapper.SetSelectionColor(const AValue: TColor);
begin
  if FSelectionColor <> ColorToRGB(AValue) then
  begin
    FSelectionColor := AValue;
    PaletteChanged;
  end;
end;

initialization
  TcxCanvasWrapper.InitColors;
end.
