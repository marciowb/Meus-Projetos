{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressPrinting System COMPONENT SUITE                      }
{                                                                   }
{       Copyright (C) 1998-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSPRINTINGSYSTEM AND            }
{   ALL ACCOMPANYING VCL CONTROLS AS PART OF AN                     }
{   EXECUTABLE PROGRAM ONLY.                                        }
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

unit dxPSReportRenderCanvas;

interface

uses
  Windows, SysUtils, Classes, Graphics, cxClasses, cxGraphics, cxGeometry,
  cxDrawTextUtils, dxPSFillPatterns, dxCore;

type
  TdxPicturePaintMode = (ppmCenter, ppmStretch, ppmTile, ppmProportional);
  TdxCheckButtonEdgeStyle = (cbesNone, cbes3D, cbesSoft3D, cbesBoldFlat, cbesUltraFlat, cbesSingle);
  
  TdxPSReportRenderCanvasMappingMode = (rrmmDefault, rrmmText, rrmmLoMetric,
    rrmmHiMetric, rrmmLoEnglish, rrmmHiEnglish, rrmmTwips, rrmmIsotropic,
    rrmmAnisotropic);
    
  { TdxPSReportRenderCustomCanvas }

  TdxPSReportRenderCustomCanvas = class(TObject)
  private
    FFont: TFont;
    procedure DoFontChanged(Sender: TObject);
    procedure SetFont(AValue: TFont);
  protected
    function GetBrush: TBrush; virtual; abstract;
    function GetBrushOrg: TPoint; virtual; abstract;
    function GetIsPrinterCanvas: Boolean; virtual; abstract;
    function GetPixelsPerInch: Integer; virtual; abstract;
    function GetSupportsTransparentImagesDrawing: Boolean; virtual;
    function GetWindowExt: TSize; virtual; abstract;
    function GetWindowOrg: TPoint; virtual; abstract;
    procedure AssignCanvasFont(ACanvas: TcxCanvas);
    procedure FontChanged; virtual;
    procedure PrepareCanvasForCustomDraw(AFont: TFont; AColor: TColor); virtual;
    procedure SetBrush(AValue: TBrush); virtual; abstract;
    procedure SetBrushOrg(const AValue: TPoint); virtual; abstract;
    procedure SetWindowExt(const ASize: TSize); virtual; abstract;
    procedure SetWindowOrg(const P: TPoint); virtual; abstract;
  public
    constructor Create; 
    destructor Destroy; override;
    function CalculateLineThickness(AUnitsPerPixel, AUnitsPerPoint: Integer): Integer; virtual; 
    procedure DeviceToLogicalCoordinates(var R: TRect); virtual; abstract;
    procedure FixupRect(var R: TRect); virtual;
    procedure LogicalToDeviceCoordinates(var R: TRect); virtual; abstract;
    procedure PrepareLogicalUnits; virtual;
    procedure RestoreState; virtual; abstract;
    procedure SaveState; virtual; abstract;
    procedure UnprepareLogicalUnits; virtual;
    // Custom Draw
    function BeginCustomDraw(const AClipBounds: TRect;
      AFont: TFont; AColor: TColor): TCanvas; virtual; abstract;
    procedure EndCustomDraw(var ACanvas: TCanvas); virtual; abstract;
    // Text
    function CalculateTextParams(ADrawTextFormat: Integer): TcxTextParams; virtual; abstract;
    function CalculateTextRect(const AText: string; var R: TRect;
      AFormat: TcxTextOutFormat = CXTO_DEFAULT_FORMAT; AFont: TFont = nil;
      AMaxLineCount: Integer = 0; ALeftIndent: Integer = 0; ARightIndent: Integer = 0;
      ATextColor: TColor = clDefault): Integer; virtual; abstract;
    procedure DrawText(var R: TRect; const AText: string; AFont: TFont;
      AFormat: Cardinal; ATextColor: TColor = clDefault; AMaxLineCount: Integer = 0); virtual; abstract;
    function MakeTextRows(AText: PChar; ATextLength: Integer; const R: TRect;
      const ATextParams: TcxTextParams; var ATextRows: TcxTextRows;
      out ACount: Integer; AMaxLineCount: Integer = 0): Boolean; virtual; abstract;
    function TextSize(const AText: string): TSize; virtual; abstract;
    procedure RotatedTextOut(const ABounds: TRect; const AText: string;
      AFont: TFont; AAlignHorz: TcxTextAlignX = taCenterX;
      AAlignVert: TcxTextAlignY = taCenterY; AWordBreak: Boolean = True;
      ADirection: TcxVerticalTextOutDirection = vtdBottomToTop); virtual; abstract;
    // Orgs and Clipping
    function ExcludeClipRect(const R: TRect): Integer; virtual; abstract;
    function IntersectClipRgn(const R: TRect): Integer; virtual; abstract;
    function IsRectVisible(const R: TRect): Boolean; virtual; abstract;
    function OffsetWindowOrg(const P: TPoint): TPoint; virtual; abstract;
    procedure RestoreClipRgn; virtual; abstract;
    procedure SaveClipRgn; virtual; abstract;
    procedure SetCanvasExts(const APageSize: TPoint;
      AMappingMode: TdxPSReportRenderCanvasMappingMode;
      AScaleNumerator, AScaleDenominator: Integer; const AViewPort: TRect); virtual; abstract;
    procedure SetClipRect(const R: TRect); virtual; abstract;
    //
    procedure DrawCheckBox(var R: TRect; AChecked, AEnabled, AIsRadio: Boolean;
      AEdgeStyle: TdxCheckButtonEdgeStyle; AMarlettFont: TFont; ALineThickness: Integer;
      ABorderColor: TColor = clWindowText); virtual; abstract;
    procedure DrawEllipseFrame(const R: TRect; AColor: TColor; AThickness: Integer); virtual; abstract;
    procedure DrawExpandButton(R: TRect; AEdgeStyle: TdxCheckButtonEdgeStyle;
      AMarlettFont, ASymbolFont: TFont; AExpanded, AShadow, AFillInterior: Boolean;
      ABorderColor, ABackgroundColor: TColor; ALineThickness: Integer); virtual; abstract;
    procedure DrawFrame(const R: TRect; ATopLeftColor, ARightBottomColor: TColor;
      ABorderWidth: Integer = 1; ABorders: TcxBorders = cxBordersAll); virtual; abstract;
    procedure DrawGlyph(const R: TRect; AGlyphFont: TFont; AGlyphIndex: Byte;
      ACenterOnRect: Boolean; ATextColor: TColor = clWindowText); virtual; abstract;
    procedure DrawPicture(APicture: TGraphic; const R: TRect;
      APictureMode: TdxPicturePaintMode; ANumerator, ADenominator: Integer;
      AOffsetX: Integer = 0; AOffsetY: Integer = 0); virtual; abstract;
    procedure DrawRoundFrame(const R: TRect; AEllipseWidth, AEllipseHeight: Integer;
      AColor: TColor; AThickness: Integer); virtual; abstract;
    procedure FillEdge(ARegion: TcxRegionHandle; ABackColor, AEdgeColor: TColor;
      AIsVerticalOrientation: Boolean; AEdgePattern: TClass{TdxPSEdgePatternClass}); virtual;
    procedure FillEllipse(const R: TRect; ABackColor, AForeColor: TColor;
      APattern: TdxPSFillPatternClass; APatternBrush: TBrush); virtual; abstract;
    procedure FillRect(const R: TRect; AColor: TColor); virtual; abstract;
    procedure FillRegion(ARegion: TcxRegionHandle; ABackColor, AForeColor: TColor;
      APattern: TdxPSFillPatternClass; APatternBrush: TBrush); virtual; abstract;
    procedure FillRoundRect(R: TRect; AEllipseWidth, AEllipseHeight: Integer;
      ABackColor, AForeColor: TColor; APattern: TdxPSFillPatternClass; APatternBrush: TBrush); virtual; abstract;
    procedure Polyline(const APoints: array of TPoint;
      AColor: TColor; ALineWidth: Integer); virtual; abstract;
    procedure Polygon(const APoints: array of TPoint;
      AColor, ABackgroundColor: TColor; ALineWidth: Integer;
      AFillMode: Integer = ALTERNATE); virtual; abstract;
    //
    property Brush: TBrush read GetBrush write SetBrush;
    property BrushOrg: TPoint read GetBrushOrg write SetBrushOrg;
    property Font: TFont read FFont write SetFont;
    property IsPrinterCanvas: Boolean read GetIsPrinterCanvas;
    property PixelsPerInch: Integer read GetPixelsPerInch;
    property SupportsTransparentImagesDrawing: Boolean read GetSupportsTransparentImagesDrawing;
    property WindowExt: TSize read GetWindowExt write SetWindowExt;
    property WindowOrg: TPoint read GetWindowOrg write SetWindowOrg;
  end;

  { TdxPSReportRenderCanvas }

  TdxPSReportRenderCanvas = class(TdxPSReportRenderCustomCanvas)
  private
    FCanvas: TcxCanvas;
  protected
    procedure DrawExpandButtonBorders(const R: TRect; AMarlettFont: TFont;
      ABorderColor: TColor; AEdgeStyle: TdxCheckButtonEdgeStyle; ALineThickness: Integer); virtual;
    procedure DrawExpandButtonGlyph(R: TRect; ASymbolFont: TFont; ATextColor: TColor;
      AExpanded: Boolean; ALineThickness: Integer); virtual;
    procedure GetBorderColors(AEdgeStyle: TdxCheckButtonEdgeStyle;
      ADefaultBorderColor: TColor; AInnerBorder: Boolean;
      out ATopLeftBorderColor, ARightBottomBorderColor: TColor);
    function GetBrush: TBrush; override;
    function GetBrushOrg: TPoint; override;
    function GetIsPrinterCanvas: Boolean; override;
    function GetPixelsPerInch: Integer; override;
    function GetWindowExt: TSize; override;
    function GetWindowOrg: TPoint; override;
    procedure FontChanged; override;
    procedure SetBrush(AValue: TBrush); override;
    procedure SetBrushOrg(const AValue: TPoint); override;
    procedure SetWindowExt(const AValue: TSize); override;
    procedure SetWindowOrg(const P: TPoint); override;
    //
    function CalculatePictureRect(APicture: TGraphic; const R: TRect;
      APictureMode: TdxPicturePaintMode; ANumerator, ADenominator: Integer): TRect;
    procedure InternalDrawFrameControl(const R: TRect; AType, AState: Integer); virtual;
    //
    procedure DrawPictureStretch(APicture: TGraphic;
      const R: TRect; ANumerator, ADenominator: Integer); virtual;
    procedure DrawPictureTile(APicture: TGraphic; const R: TRect;
      APictureWidth, APictureHeight, ANumerator, ADenominator: Integer); virtual;
  public
    constructor Create(ACanvas: TCanvas); 
    destructor Destroy; override;
    procedure DeviceToLogicalCoordinates(var R: TRect); override;
    procedure LogicalToDeviceCoordinates(var R: TRect); override;
    procedure RestoreState; override;
    procedure SaveState; override;
    // Custom Draw
    function BeginCustomDraw(const AClipBounds: TRect;
      AFont: TFont; AColor: TColor): TCanvas; override;
    procedure EndCustomDraw(var ACanvas: TCanvas); override;
    // Text
    function CalculateTextParams(ADrawTextFormat: Integer): TcxTextParams; override;
    function CalculateTextRect(const AText: string; var R: TRect;
      AFormat: TcxTextOutFormat = CXTO_DEFAULT_FORMAT; AFont: TFont = nil;
      AMaxLineCount: Integer = 0; ALeftIndent: Integer = 0; ARightIndent: Integer = 0;
      ATextColor: TColor = clDefault): Integer; override;
    procedure DrawText(var R: TRect; const AText: string; AFont: TFont;
      AFormat: Cardinal; ATextColor: TColor = clDefault; AMaxLineCount: Integer = 0); override;
    function MakeTextRows(AText: PChar; ATextLength: Integer; const R: TRect;
      const ATextParams: TcxTextParams; var ATextRows: TcxTextRows;
      out ACount: Integer; AMaxLineCount: Integer = 0): Boolean; override;
    function TextSize(const AText: string): TSize; override;
    procedure RotatedTextOut(const ABounds: TRect; const AText: string;
      AFont: TFont; AAlignHorz: TcxTextAlignX = taCenterX;
      AAlignVert: TcxTextAlignY = taCenterY; AWordBreak: Boolean = True;
      ADirection: TcxVerticalTextOutDirection = vtdBottomToTop); override;
    // Orgs and Clipping
    function ExcludeClipRect(const R: TRect): Integer; override;
    function IntersectClipRgn(const R: TRect): Integer; override;
    function IsRectVisible(const R: TRect): Boolean; override;
    function OffsetWindowOrg(const P: TPoint): TPoint; override;
    procedure RestoreClipRgn; override;
    procedure SaveClipRgn; override;
    procedure SetCanvasExts(const APageSize: TPoint;
      AMappingMode: TdxPSReportRenderCanvasMappingMode;
      AScaleNumerator, AScaleDenominator: Integer; const AViewPort: TRect); override;
    procedure SetClipRect(const R: TRect); override;
    // Filling
    procedure DrawCheckBox(var R: TRect; AChecked, AEnabled, AIsRadio: Boolean;
      AEdgeStyle: TdxCheckButtonEdgeStyle; AMarlettFont: TFont; ALineThickness: Integer;
      ABorderColor: TColor = clWindowText); override;
    procedure DrawEllipseFrame(const R: TRect; AColor: TColor; AThickness: Integer); override;
    procedure DrawExpandButton(R: TRect; AEdgeStyle: TdxCheckButtonEdgeStyle;
      AMarlettFont, ASymbolFont: TFont; AExpanded, AShadow, AFillInterior: Boolean;
      ABorderColor, ABackgroundColor: TColor; ALineThickness: Integer); override;
    procedure DrawFrame(const R: TRect; ATopLeftColor, ARightBottomColor: TColor;
      ABorderWidth: Integer = 1; ABorders: TcxBorders = cxBordersAll); override;
    procedure DrawGlyph(const R: TRect; AGlyphFont: TFont; AGlyphIndex: Byte;
      ACenterOnRect: Boolean; ATextColor: TColor = clWindowText); override;
    procedure DrawPicture(APicture: TGraphic; const R: TRect;
      APictureMode: TdxPicturePaintMode; ANumerator, ADenominator: Integer;
      AOffsetX: Integer = 0; AOffsetY: Integer = 0); override;
    procedure DrawRoundFrame(const R: TRect; AEllipseWidth, AEllipseHeight: Integer;
      AColor: TColor; AThickness: Integer); override;
    procedure FillEllipse(const R: TRect; ABackColor, AForeColor: TColor;
      APattern: TdxPSFillPatternClass; APatternBrush: TBrush); override;
    procedure FillRect(const R: TRect; AColor: TColor); override;
    procedure FillRegion(ARegion: TcxRegionHandle; ABackColor, AForeColor: TColor;
      APattern: TdxPSFillPatternClass; APatternBrush: TBrush); override;
    procedure FillRoundRect(R: TRect; AEllipseWidth, AEllipseHeight: Integer;
      ABackColor, AForeColor: TColor; APattern: TdxPSFillPatternClass; APatternBrush: TBrush); override;
    procedure Polyline(const APoints: array of TPoint;
      AColor: TColor; ALineWidth: Integer); override;
    procedure Polygon(const APoints: array of TPoint; AColor, ABackgroundColor: TColor;
      ALineWidth: Integer; AFillMode: Integer = ALTERNATE); override;
    //
    property Canvas: TcxCanvas read FCanvas;
  end;

  { TdxPSReportRenderScreenCanvas }

  TdxPSReportRenderScreenCanvas = class(TdxPSReportRenderCanvas)
  private
    FSourceCanvas: TCanvas;
  public
    constructor Create;
    destructor Destroy; override;
  end;

procedure cxBkgndDrawPicture(APicture: TGraphic; ACanvas: TCanvas; const R: TRect;
  APictureMode: TdxPicturePaintMode; APixelsNumerator, APixelsDenominator: Integer;
  AOffsetX: Integer = 0; AOffsetY: Integer = 0);
implementation

uses
  dxPSUtl, dxPSCore, Types, dxPSEdgePatterns;

procedure cxBkgndDrawPicture(APicture: TGraphic; ACanvas: TCanvas; const R: TRect;
  APictureMode: TdxPicturePaintMode; APixelsNumerator, APixelsDenominator: Integer;
  AOffsetX: Integer = 0; AOffsetY: Integer = 0);
var
  ARenderCanvas: TdxPSReportRenderCanvas;
begin
  ARenderCanvas := TdxPSReportRenderCanvas.Create(ACanvas);
  try
    ARenderCanvas.DrawPicture(APicture, R, APictureMode,
      APixelsNumerator, APixelsDenominator, AOffsetX, AOffsetY);
  finally
    ARenderCanvas.Free;
  end;
end;

{ TdxPSReportRenderCustomCanvas }

constructor TdxPSReportRenderCustomCanvas.Create;
begin
  inherited Create;
  FFont := TFont.Create;
  FFont.OnChange := DoFontChanged;
end;

destructor TdxPSReportRenderCustomCanvas.Destroy;
begin
  FreeAndNil(FFont);
  inherited Destroy;
end;

function TdxPSReportRenderCustomCanvas.CalculateLineThickness(
  AUnitsPerPixel, AUnitsPerPoint: Integer): Integer;
begin
  if IsPrinterCanvas then
    Result := Max(MulDiv(AUnitsPerPoint, 1, 2), 1)
  else
    Result := AUnitsPerPixel;
end;

procedure TdxPSReportRenderCustomCanvas.DoFontChanged(Sender: TObject);
begin
  FontChanged;
end;

procedure TdxPSReportRenderCustomCanvas.FixupRect(var R: TRect);
begin
  LogicalToDeviceCoordinates(R);
  DeviceToLogicalCoordinates(R);
end;

procedure TdxPSReportRenderCustomCanvas.PrepareLogicalUnits;
begin
end;

procedure TdxPSReportRenderCustomCanvas.UnprepareLogicalUnits;
begin
end;

procedure TdxPSReportRenderCustomCanvas.AssignCanvasFont(ACanvas: TcxCanvas);
begin
  ACanvas.Font.Assign(Font);
  if Font.PixelsPerInch <> ACanvas.Font.PixelsPerInch then
    ACanvas.Font.Height := Font.Height;
end;

procedure TdxPSReportRenderCustomCanvas.FontChanged;
begin
end;

function TdxPSReportRenderCustomCanvas.GetSupportsTransparentImagesDrawing: Boolean;
begin
  Result := True;
end;

procedure TdxPSReportRenderCustomCanvas.FillEdge(
  ARegion: TcxRegionHandle; ABackColor, AEdgeColor: TColor;
  AIsVerticalOrientation: Boolean; AEdgePattern: TClass{TdxPSEdgePatternClass});
const
  OrientationMap: array[Boolean] of TdxPSCellEdgePatternOrientation =
    (cepoHorizontal, cepoVertical);
var
  APatternItem: TdxPSEdgePatternItem;
begin
  if AEdgePattern.InheritsFrom(TdxPSEdgePattern) then
  begin
    APatternItem := dxPSEdgePatternFactory.Items[
      TdxPSEdgePatternClass(AEdgePattern), IsPrinterCanvas];
    FillRegion(ARegion, ABackColor, AEdgeColor, nil,
      APatternItem.Brushes[OrientationMap[AIsVerticalOrientation]]);
  end;
end;

procedure TdxPSReportRenderCustomCanvas.PrepareCanvasForCustomDraw(AFont: TFont; AColor: TColor);
begin
  if AColor <> clDefault then
    Brush.Color := AColor;
  if Assigned(AFont) then
  begin
    Font := AFont;
    Font.PixelsPerInch := AFont.PixelsPerInch;
  end;
end;

procedure TdxPSReportRenderCustomCanvas.SetFont(AValue: TFont);
begin
  if AValue <> nil then
  begin
    FFont.Assign(AValue);
    FontChanged;
  end;
end;

{ TdxPSReportRenderCanvas }

constructor TdxPSReportRenderCanvas.Create(ACanvas: TCanvas);
begin
  inherited Create;
  FCanvas := TcxCanvas.Create(ACanvas);
end;

destructor TdxPSReportRenderCanvas.Destroy;
begin
  FreeAndNil(FCanvas);
  inherited Destroy;
end;

function TdxPSReportRenderCanvas.CalculatePictureRect(
  APicture: TGraphic; const R: TRect; APictureMode: TdxPicturePaintMode;
  ANumerator, ADenominator: Integer): TRect;
var
  W, H, V: Integer;
begin
  case APictureMode of
    ppmCenter:
      Result := cxRectCenter(R,
        MulDiv(APicture.Width, ANumerator, ADenominator),
        MulDiv(APicture.Height, ANumerator, ADenominator));

    ppmProportional:
      begin
        W := cxRectWidth(R);
        H := cxRectHeight(R);
        if APicture.Width / APicture.Height > W / H then
        begin
          V := MulDiv(APicture.Height, W, APicture.Width);
          Result := Bounds(R.Left, R.Top + (H - V) div 2, W, V);
        end
        else
        begin
          V := MulDiv(APicture.Width, H, APicture.Height);
          Result := Bounds(R.Left + (W - V) div 2, R.Top, V, H);
        end;
      end;

    else
      Result := R
  end;
end;

function TdxPSReportRenderCanvas.GetBrush: TBrush;
begin
  Result := Canvas.Brush;
end;

function TdxPSReportRenderCanvas.GetBrushOrg: TPoint;
begin
  GetBrushOrgEx(Canvas.Handle, Result);
end;

function TdxPSReportRenderCanvas.GetIsPrinterCanvas: Boolean;
begin
  Result := IsPrinterDC(Canvas.Handle);
end;

function TdxPSReportRenderCanvas.GetPixelsPerInch: Integer;
begin
  Result := GetDeviceCaps(Canvas.Handle, LOGPIXELSX);
end;

procedure TdxPSReportRenderCanvas.InternalDrawFrameControl(
  const R: TRect; AType, AState: Integer);
begin
  DrawFrameControl(Canvas.Handle, R, AType, AState);
end;

procedure TdxPSReportRenderCanvas.DrawPictureStretch(
  APicture: TGraphic; const R: TRect; ANumerator, ADenominator: Integer);
var
  ABitmap: TcxBitmap;
  AWidth, AHeight: Integer;
begin
  if not (IsPrinterCanvas and APicture.Transparent) or (APicture is TMetafile) then
    Canvas.Canvas.StretchDraw(R, APicture)
  else
  begin
    AWidth := MulDiv(cxRectWidth(R), ADenominator, ANumerator);
    AHeight := MulDiv(cxRectHeight(R), ADenominator, ANumerator);
    ABitmap := TcxBitmap.CreateSize(AWidth, AHeight, pf24bit);
    try
      cxStretchBlt(ABitmap.Canvas.Handle, Canvas.Handle, ABitmap.ClientRect, R, SRCCOPY);
      ABitmap.Canvas.StretchDraw(ABitmap.ClientRect, APicture);
      cxStretchBlt(Canvas.Handle, ABitmap.Canvas.Handle, R, ABitmap.ClientRect, SRCCOPY);
    finally
      ABitmap.Free;
    end;
  end;
end;

procedure TdxPSReportRenderCanvas.DrawPictureTile(APicture: TGraphic;
  const R: TRect; APictureWidth, APictureHeight, ANumerator, ADenominator: Integer);
var
  ACountX, ACountY: Integer;
  AImageRect: TRect;
  X, Y: Integer;
begin
  AImageRect := Bounds(0, 0, APictureWidth, APictureHeight);
  ACountX := cxRectWidth(R) div APictureWidth;
  ACountY := cxRectHeight(R) div APictureHeight;
  for X := 0 to ACountX do
    for Y := 0 to ACountY do
    begin
      OffsetRect(AImageRect, -AImageRect.Left, -AImageRect.Top);
      OffsetRect(AImageRect, R.Left + X * APictureWidth, R.Top + Y * APictureHeight);
      DrawPictureStretch(APicture, AImageRect, ANumerator, ADenominator);
    end;
end;

procedure TdxPSReportRenderCanvas.DrawCheckBox(var R: TRect;
  AChecked, AEnabled, AIsRadio: Boolean; AEdgeStyle: TdxCheckButtonEdgeStyle;
  AMarlettFont: TFont; ALineThickness: Integer; ABorderColor: TColor = clWindowText);

  procedure DrawCheckBoxGlyph(AGlyphIndex: Byte; AColor: TColor = clDefault);
  begin
    DrawGlyph(cxRectInflate(R, ALineThickness, ALineThickness),
      AMarlettFont, AGlyphIndex, True, AColor);
  end;

  procedure DrawCheckBoxBorders(AIsRadio: Boolean;
    AEdgeStyle: TdxCheckButtonEdgeStyle; ABorderColor: TColor);
  const
    TopLeftArcInnerIndexes: array[Boolean] of Integer =
      (CheckTopLeftArcInnerIndex, RadioTopLeftArcInnerIndex);
    BottomRightArcInnerIndexes: array[Boolean] of Integer =
      (CheckBottomRightArcInnerIndex, RadioBottomRightArcInnerIndex);
    TopLeftArcOuterIndexes: array[Boolean] of Integer =
      (CheckTopLeftArcOuterIndex, RadioTopLeftArcOuterIndex);
    BottomRightArcOuterIndexes: array[Boolean] of Integer =
      (CheckBottomRightArcOuterIndex, RadioBottomRightArcOuterIndex);
  var
    ATopLeftColor, ARightBottomColor: TColor;
  begin
    if AEdgeStyle <> cbesNone then
    begin
      GetBorderColors(AEdgeStyle, ABorderColor, True, ATopLeftColor, ARightBottomColor); 
      DrawCheckBoxGlyph(TopLeftArcInnerIndexes[AIsRadio], ATopLeftColor);
      DrawCheckBoxGlyph(BottomRightArcInnerIndexes[AIsRadio], ARightBottomColor);
      if AEdgeStyle in [cbes3D, cbesSoft3D, cbesBoldFlat] then
      begin
        GetBorderColors(AEdgeStyle, ABorderColor, False, ATopLeftColor, ARightBottomColor);
        DrawCheckBoxGlyph(TopLeftArcOuterIndexes[AIsRadio], ATopLeftColor);
        DrawCheckBoxGlyph(BottomRightArcOuterIndexes[AIsRadio], ARightBottomColor);
      end;
    end;
  end;

const
  EnabledColorMap: array[Boolean] of TColor = (clBtnFace, clWindow);
  InteriorIndexes: array[Boolean] of Integer = (CheckInteriorIndex, RadioInteriorIndex);
  MarkIndexes: array[Boolean] of Integer = (CheckMarkIndex, RadioBeanIndex);
begin
  if IsRectVisible(R) then
  begin
    SaveState;
    try
      DrawCheckBoxGlyph(InteriorIndexes[AIsRadio], EnabledColorMap[AEnabled]);
      if AChecked then
        DrawCheckBoxGlyph(MarkIndexes[AIsRadio], clWindowText);
      DrawCheckBoxBorders(AIsRadio, AEdgeStyle, ABorderColor);
    finally
      RestoreState;
    end;
  end;
end;

procedure TdxPSReportRenderCanvas.DrawEllipseFrame(
  const R: TRect; AColor: TColor; AThickness: Integer);
var
  AOuterRgn, AInnerRgn: TcxRegionHandle;
begin
  AOuterRgn := CreateEllipticRgnIndirect(R);
  AInnerRgn := CreateEllipticRgnIndirect(cxRectInflate(R, -AThickness, -AThickness));
  CombineRgn(AOuterRgn, AOuterRgn, AInnerRgn, RGN_DIFF);
  Canvas.FillRegion(AOuterRgn, AColor);
  DeleteObject(AInnerRgn);
  DeleteObject(AOuterRgn);
end;

procedure TdxPSReportRenderCanvas.DrawExpandButton(R: TRect;
  AEdgeStyle: TdxCheckButtonEdgeStyle; AMarlettFont, ASymbolFont: TFont;
  AExpanded, AShadow, AFillInterior: Boolean; ABorderColor, ABackgroundColor: TColor;
  ALineThickness: Integer);
begin
  if IsRectVisible(R) then
  begin
    SaveState;
    try
      if AFillInterior then
        FillRect(cxRectInflate(R, -ALineThickness, -ALineThickness), ABackgroundColor);
      R := cxRectInflate(R, ALineThickness, ALineThickness);
      DrawExpandButtonBorders(R, AMarlettFont, ABorderColor, AEdgeStyle, ALineThickness);
      DrawExpandButtonGlyph(R, ASymbolFont, ABorderColor, AExpanded, ALineThickness);
    finally
      RestoreState;
    end;
  end;
end;

procedure TdxPSReportRenderCanvas.DrawExpandButtonBorders(const R: TRect;
  AMarlettFont: TFont; ABorderColor: TColor; AEdgeStyle: TdxCheckButtonEdgeStyle;
  ALineThickness: Integer);
var
  ATopLeftColor, ARightBottomColor: TColor;
begin
  if AEdgeStyle <> cbesNone then
  begin
    Font := AMarlettFont;
    GetBorderColors(AEdgeStyle, ABorderColor, True, ARightBottomColor, ATopLeftColor);
    DrawGlyph(R, AMarlettFont, CheckTopLeftArcInnerIndex, True, ATopLeftColor);
    DrawGlyph(R, AMarlettFont, CheckBottomRightArcInnerIndex, True, ARightBottomColor);
    if AEdgeStyle in [cbes3D, cbesSoft3D, cbesBoldFlat] then
    begin
      GetBorderColors(AEdgeStyle, ABorderColor, False, ARightBottomColor, ATopLeftColor);
      DrawGlyph(R, AMarlettFont, CheckTopLeftArcOuterIndex, True, ATopLeftColor);
      DrawGlyph(R, AMarlettFont, CheckBottomRightArcOuterIndex, True, ARightBottomColor);
    end;
  end;
end;

procedure TdxPSReportRenderCanvas.DrawExpandButtonGlyph(R: TRect;
  ASymbolFont: TFont; ATextColor: TColor; AExpanded: Boolean; ALineThickness: Integer);
const
  CrossHireIndexes: array[Boolean] of Byte = (PlusSignIndex, MinusSignIndex);
begin
  DrawGlyph(cxRectOffset(R, 0, -ALineThickness),
    ASymbolFont, CrossHireIndexes[AExpanded], True, ATextColor);
end;

procedure TdxPSReportRenderCanvas.DrawFrame(
  const R: TRect; ATopLeftColor, ARightBottomColor: TColor;
  ABorderWidth: Integer = 1; ABorders: TcxBorders = cxBordersAll);
begin
  Canvas.DrawComplexFrame(R, ATopLeftColor, ARightBottomColor, ABorders, ABorderWidth);
end;

procedure TdxPSReportRenderCanvas.DrawGlyph(const R: TRect; AGlyphFont: TFont;
  AGlyphIndex: Byte; ACenterOnRect: Boolean; ATextColor: TColor = clWindowText);
const
  TextFormatMap: array[Boolean] of Integer = (
    CXTO_LEFT, CXTO_CENTER_HORIZONTALLY or CXTO_CENTER_VERTICALLY
  );
var
  R1: TRect;
begin
  R1 := R;
  Brush.Style := bsClear;
  if ATextColor = clDefault then
    ATextColor := clWindowText;
  DrawText(R1, Chr(AGlyphIndex), AGlyphFont, TextFormatMap[ACenterOnRect], ATextColor);
end;

procedure TdxPSReportRenderCanvas.DrawPicture(APicture: TGraphic; const R: TRect;
  APictureMode: TdxPicturePaintMode; ANumerator, ADenominator: Integer;
  AOffsetX: Integer = 0; AOffsetY: Integer = 0);
var
  W, H: Integer;
begin
  if Assigned(APicture) and not APicture.Empty then
  begin
    if APictureMode <> ppmTile then
      DrawPictureStretch(APicture,
        CalculatePictureRect(APicture, R, APictureMode, ANumerator, ADenominator),
        ANumerator, ADenominator)
    else
    begin
      SaveClipRgn;
      try
        IntersectClipRgn(R);
        W := MulDiv(APicture.Width, ANumerator, ADenominator);
        H := MulDiv(APicture.Height, ANumerator, ADenominator);
        DrawPictureTile(APicture,
          cxRectOffset(R, AOffsetX mod W, AOffsetY mod H), W, H,
          ANumerator, ADenominator);
      finally
        RestoreClipRgn;
      end;
    end;
  end;
end;

procedure TdxPSReportRenderCanvas.DrawRoundFrame(const R: TRect;
  AEllipseWidth, AEllipseHeight: Integer; AColor: TColor; AThickness: Integer);
var
  ARegion: TcxRegion;
begin
  ARegion := TcxRegion.CreateRoundCorners(R, AEllipseWidth, AEllipseHeight);
  try
    AEllipseHeight := MulDiv(AEllipseHeight,
      cxRectHeight(R) - 2 * AThickness, cxRectHeight(R));
    AEllipseWidth := MulDiv(AEllipseWidth,
      cxRectWidth(R) - 2 * AThickness, cxRectWidth(R));
    ARegion.Combine(TcxRegion.CreateRoundCorners(
      cxRectInflate(R, -AThickness, -AThickness), AEllipseWidth, AEllipseHeight),
      roSubtract);
    Canvas.FillRegion(ARegion, AColor);
  finally
    ARegion.Free;
  end;
end;

procedure TdxPSReportRenderCanvas.FillEllipse(const R: TRect;
  ABackColor, AForeColor: TColor; APattern: TdxPSFillPatternClass; APatternBrush: TBrush);
var
  ARegion: TcxRegionHandle;
begin
  ARegion := CreateEllipticRgnIndirect(R);
  FillRegion(ARegion, ABackColor, AForeColor, APattern, APatternBrush);
  DeleteObject(ARegion);                                
end;

procedure TdxPSReportRenderCanvas.FillRect(const R: TRect; AColor: TColor);
begin
  Canvas.FillRect(R, AColor);
end;

procedure TdxPSReportRenderCanvas.FillRegion(ARegion: TcxRegionHandle;
  ABackColor, AForeColor: TColor; APattern: TdxPSFillPatternClass; APatternBrush: TBrush);
var
  R: TRect;
begin
  if GetRgnBox(ARegion, R) <> NULLREGION then
  begin
    SaveState;
    try
      Font.Color := AForeColor;
      Brush.Color := ABackColor;
      if Assigned(APattern) and APattern.RequiredBrushOrigin then
      begin
        LogicalToDeviceCoordinates(R);
        BrushOrg := Point(
          R.Left mod APattern.Dimensions.cX,
          R.Top  mod APattern.Dimensions.cY);
      end;
      FillRgn(Canvas.Handle, ARegion, APatternBrush.Handle);
    finally
      RestoreState;
    end;
  end;
end;
                    
procedure TdxPSReportRenderCanvas.FillRoundRect(R: TRect; AEllipseWidth: Integer;
  AEllipseHeight: Integer; ABackColor, AForeColor: TColor;
  APattern: TdxPSFillPatternClass; APatternBrush: TBrush);
var
  ARegion: TcxRegion;
begin
  ARegion := TcxRegion.CreateRoundCorners(R, AEllipseWidth, AEllipseHeight);
  try
    FillRegion(ARegion.Handle, ABackColor, AForeColor, APattern, APatternBrush);
  finally
    ARegion.Free;
  end;
end;

procedure TdxPSReportRenderCanvas.Polyline(
  const APoints: array of TPoint; AColor: TColor; ALineWidth: Integer);
begin
  SaveState;
  try
    if AColor <> clDefault then
      Canvas.Pen.Color := AColor;
    Canvas.Pen.Width := ALineWidth;
    Canvas.Polyline(APoints);
  finally
    RestoreState;
  end;
end;

procedure TdxPSReportRenderCanvas.Polygon(
  const APoints: array of TPoint; AColor, ABackgroundColor: TColor;
  ALineWidth: Integer; AFillMode: Integer = ALTERNATE);
begin
  SaveState;
  try
    if AColor <> clDefault then
      Canvas.Pen.Color := AColor;
    if ABackgroundColor <> clDefault then
      Canvas.Brush.Color := ABackgroundColor;
    SetPolyFillMode(Canvas.Handle, AFillMode);
    Canvas.Pen.Width := ALineWidth;
    Canvas.Polygon(APoints);
  finally
    RestoreState;
  end;
end;

procedure TdxPSReportRenderCanvas.GetBorderColors(
  AEdgeStyle: TdxCheckButtonEdgeStyle; ADefaultBorderColor: TColor;
  AInnerBorder: Boolean; out ATopLeftBorderColor, ARightBottomBorderColor: TColor);
const
  Soft3DTopLeftBorders: array[Boolean] of TColor = (clBtnShadow, clBtnFace);
  Soft3DRightBottomBorders: array[Boolean] of TColor = (clBtnHighlight, clBtnFace);
  Custom3DTopLeftBorders: array[Boolean] of TColor = (clBtnShadow, cl3DDkShadow);
  Custom3DRightBottomBorders: array[Boolean] of TColor = (clBtnHighlight, cl3DLight);
begin
  case AEdgeStyle of
    cbesSingle, cbesBoldFlat:
      ATopLeftBorderColor := ADefaultBorderColor;
    cbesUltraFlat:
      ATopLeftBorderColor := clWindowText;
    cbesSoft3D:
      ATopLeftBorderColor := Soft3DTopLeftBorders[AInnerBorder];
    cbes3D:
      ATopLeftBorderColor := Custom3DTopLeftBorders[AInnerBorder];
    else
      ATopLeftBorderColor := clDefault;
  end;
  case AEdgeStyle of
    cbes3D:
      ARightBottomBorderColor := Custom3DRightBottomBorders[AInnerBorder];
    cbesSoft3D:
      ARightBottomBorderColor := Soft3DRightBottomBorders[AInnerBorder];
    else
      ARightBottomBorderColor := ATopLeftBorderColor;
  end;
end;

function TdxPSReportRenderCanvas.IsRectVisible(const R: TRect): Boolean;
begin
  Result := RectVisible(Canvas.Handle, R);
end;

procedure TdxPSReportRenderCanvas.SetBrush(AValue: TBrush);
begin
  Canvas.Brush.Assign(AValue);
end;

procedure TdxPSReportRenderCanvas.SetBrushOrg(const AValue: TPoint);
begin
  SetBrushOrgEx(Canvas.Handle, AValue.X, AValue.Y, nil);
end;

procedure TdxPSReportRenderCanvas.FontChanged;
begin
  AssignCanvasFont(Canvas);
end;

function TdxPSReportRenderCanvas.OffsetWindowOrg(const P: TPoint): TPoint;
var
  ANewWindowOrg: TPoint;
begin
  Result := WindowOrg;
  ANewWindowOrg := Result;
  Inc(ANewWindowOrg.X, P.X);
  Inc(ANewWindowOrg.Y, P.Y);
  SetWindowOrg(ANewWindowOrg);
end;

function TdxPSReportRenderCanvas.GetWindowExt: TSize;
begin
  GetWindowExtEx(Canvas.Handle, Result);
end;

function TdxPSReportRenderCanvas.GetWindowOrg: TPoint;
begin
  GetWindowOrgEx(Canvas.Handle, Result);
end;

procedure TdxPSReportRenderCanvas.SetWindowExt(const AValue: TSize);
begin
  SetWindowExtEx(Canvas.Handle, AValue.cx, AValue.cy, nil);
end;

procedure TdxPSReportRenderCanvas.SetWindowOrg(const P: TPoint);
begin
  SetWindowOrgEx(Canvas.Handle, P.X, P.Y, nil);
end;

procedure TdxPSReportRenderCanvas.DrawText(var R: TRect; const AText: string;
  AFont: TFont; AFormat: Cardinal; ATextColor: TColor = clDefault; AMaxLineCount: Integer = 0);
begin
  cxTextOut(Canvas.Handle, AText, R, AFormat, AFont, AMaxLineCount, 0, 0, ATextColor);
end;

function TdxPSReportRenderCanvas.CalculateTextParams(ADrawTextFormat: Integer): TcxTextParams;
begin
  Result := cxCalcTextParams(Canvas.Handle, ADrawTextFormat);
end;

function TdxPSReportRenderCanvas.CalculateTextRect(const AText: string;
  var R: TRect; AFormat: TcxTextOutFormat = CXTO_DEFAULT_FORMAT;
  AFont: TFont = nil; AMaxLineCount: Integer = 0; ALeftIndent: Integer = 0;
  ARightIndent: Integer = 0; ATextColor: TColor = clDefault): Integer;
begin
  Result := cxTextOut(Canvas.Handle, AText, R, AFormat, AFont,
    AMaxLineCount, ALeftIndent, ARightIndent, ATextColor);
end;

function TdxPSReportRenderCanvas.MakeTextRows(AText: PChar; ATextLength: Integer;
  const R: TRect; const ATextParams: TcxTextParams; var ATextRows: TcxTextRows;
  out ACount: Integer; AMaxLineCount: Integer = 0): Boolean;
begin
  cxResetTextRows(ATextRows);
  Result := cxMakeTextRows(Canvas.Handle, AText, ATextLength,
    R, ATextParams, ATextRows, ACount, AMaxLineCount);
end;

function TdxPSReportRenderCanvas.TextSize(const AText: string): TSize;
begin
  Result := Canvas.TextExtent(AText);
end;

procedure TdxPSReportRenderCanvas.RotatedTextOut(
  const ABounds: TRect; const AText: string; AFont: TFont;
  AAlignHorz: TcxTextAlignX = taCenterX; AAlignVert: TcxTextAlignY = taCenterY;
  AWordBreak: Boolean = True; ADirection: TcxVerticalTextOutDirection = vtdBottomToTop);
begin
  cxRotatedTextOut(Canvas.Handle, ABounds, AText, AFont,
    AAlignHorz, AAlignVert, AWordBreak, True, True, ADirection);
end;

procedure TdxPSReportRenderCanvas.SetCanvasExts(const APageSize: TPoint;
  AMappingMode: TdxPSReportRenderCanvasMappingMode; AScaleNumerator: Integer;
  AScaleDenominator: Integer; const AViewPort: TRect);
const
  MappingModeFlags: array[TdxPSReportRenderCanvasMappingMode] of Integer = (
    0, MM_TEXT, MM_LOMETRIC, MM_HIMETRIC, MM_LOENGLISH, MM_HIENGLISH, MM_TWIPS,
    MM_ISOTROPIC, MM_ANISOTROPIC);
begin
  if AMappingMode <> rrmmDefault then
    SetMapMode(Canvas.Handle, MappingModeFlags[AMappingMode]);
  WindowExt := cxSize(APageSize.X, APageSize.Y);
  ScaleWindowExtEx(Canvas.Handle, AScaleNumerator,
    AScaleDenominator, AScaleNumerator, AScaleDenominator, nil);
  SetViewPortExtEx(Canvas.Handle, cxRectWidth(AViewPort), cxRectHeight(AViewPort), nil);
  SetViewPortOrgEx(Canvas.Handle, AViewPort.Left, AViewPort.Top, nil);
end;

procedure TdxPSReportRenderCanvas.DeviceToLogicalCoordinates(var R: TRect);
begin
  DPtoLP(Canvas.Handle, R, 2);
end;

procedure TdxPSReportRenderCanvas.LogicalToDeviceCoordinates(var R: TRect);
begin
  LPtoDP(Canvas.Handle, R, 2);
end;

function TdxPSReportRenderCanvas.ExcludeClipRect(const R: TRect): Integer;
begin
  with R do
    Result := Windows.ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
end;

function TdxPSReportRenderCanvas.IntersectClipRgn(const R: TRect): Integer;
begin
  with R do
    Result := Windows.IntersectClipRect(Canvas.Handle, Left, Top, Right, Bottom);
end;

procedure TdxPSReportRenderCanvas.SetClipRect(const R: TRect);
begin
  Canvas.SetClipRegion(TcxRegion.Create(R), roSet);
end;

function TdxPSReportRenderCanvas.BeginCustomDraw(
  const AClipBounds: TRect; AFont: TFont; AColor: TColor): TCanvas;
begin
  Canvas.SaveState;
  Result := Canvas.Canvas;
  PrepareCanvasForCustomDraw(AFont, AColor);
  IntersectClipRgn(AClipBounds);
end;

procedure TdxPSReportRenderCanvas.EndCustomDraw(var ACanvas: TCanvas);
begin
  Canvas.RestoreState;
end;

procedure TdxPSReportRenderCanvas.RestoreState;
begin
  Canvas.RestoreState;
end;

procedure TdxPSReportRenderCanvas.SaveState;
begin
  Canvas.SaveState;
  AssignCanvasFont(Canvas);
end;

procedure TdxPSReportRenderCanvas.RestoreClipRgn;
begin
  Canvas.RestoreClipRegion;
end;

procedure TdxPSReportRenderCanvas.SaveClipRgn;
begin
  Canvas.SaveClipRegion;
end;

{ TdxPSReportRenderScreenCanvas }

constructor TdxPSReportRenderScreenCanvas.Create;
begin
  FSourceCanvas := TCanvas.Create;
  FSourceCanvas.Handle := GetDC(0);
  inherited Create(FSourceCanvas);
end;

destructor TdxPSReportRenderScreenCanvas.Destroy;
begin
  ReleaseDC(0, FSourceCanvas.Handle);
  FSourceCanvas.Handle := 0;
  FreeAndNil(FSourceCanvas);
  inherited Destroy;
end;

end.
