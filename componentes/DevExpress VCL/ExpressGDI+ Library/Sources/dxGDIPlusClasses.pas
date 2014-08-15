{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       GDI+ Library                                                }
{                                                                   }
{       Copyright (c) 2002-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE GDIPLUS LIBRARY AND ALL ACCOMPANYING }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.             }
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

unit dxGDIPlusClasses;

{$I cxVer.inc}
{$DEFINE DXREGISTERPNGIMAGE}

interface

uses
  Windows, Classes, SysUtils, Graphics, dxGDIPlusAPI, dxCore, Types;

type
  TdxPNGImage = class;

  { TdxGPBrush }

  TdxGPBrush = class(TdxGPBase)
  private
    FNativeBrush: GpBrush;
    FLastResult: TdxGPStatus;
  protected
    constructor CreateNative (nativeBrush: GpBrush; AStatus: Status);
    procedure SetNativeBrush(ANativeBrush: GpBrush);
    function SetStatus(AStatus: TdxGPStatus): TdxGPStatus;
  public
    constructor Create;
    destructor Destroy; override;
    function Clone: TdxGPBrush; virtual;
    function GetType: BrushType;
    function GetLastStatus: Status;
  end;

  { TdxGPSolidBrush }

  TdxGPSolidBrush = class(TdxGPBrush)
  private
    function GetColor: DWORD;
    procedure SetColor(const Value: DWORD);
  public
    constructor Create; overload;
    constructor Create(color: TColor); overload;
    property Color: DWORD read GetColor write SetColor;
  end;

  { TdxGPTextureBrush }

  TdxGPTextureBrush = class(TdxGPBrush)
  end;

  { TdxGPLinearGradientBrush }

  TdxGPLinearGradientBrush = class(TdxGPBrush)
  private
    procedure SetWrapMode(const Value: TdxGPWrapMode);
    function GetWrapMode: TdxGPWrapMode;
  public
    constructor Create; overload;
    constructor Create(rect: TdxGPRect; color1, color2: DWORD; mode: TdxGPLinearGradientMode); overload;
    function SetLinearColors(color1, color2: DWORD): TdxGPStatus;
    function GetLinearColors(out color1, color2: DWORD): TdxGPStatus;
    function GetRectangle: TdxGPRect; overload;
    property WrapMode: TdxGPWrapMode read GetWrapMode write SetWrapMode;
  end;

  { TdxGPHatchBrush }

  TdxGPHatchBrush = class(TdxGPBrush)
  public
    constructor Create; overload;
    constructor Create(hatchStyle: TdxGPHatchStyle; foreColor: DWORD; backColor: DWORD); overload;
    function GetHatchStyle: TdxGPHatchStyle;
    function GetForegroundColor: DWORD;
    function GetBackgroundColor: DWORD;
  end;

  { TdxGPPen }

  TdxGPPen = class(TdxGPBase)
  private
    FNativePen: GpPen;
    FLastResult: TdxGPStatus;

    function GetAlignment: TdxGPPenAlignment;
    function GetColor: DWORD;
    function GetBrush: TdxGPBrush;
    function GetWidth: Single;
    procedure SetAlignment(const Value: TdxGPPenAlignment);
    procedure SetColor(const Value: DWORD);
    procedure SetBrush(const Value: TdxGPBrush);
    procedure SetWidth(const Value: Single);
  protected
    procedure SetNativePen(ANativePen: GpPen);
    function SetStatus(status: TdxGPStatus): TdxGPStatus;
  public
    constructor Create(color: DWORD; width: Single = 1.0); overload;
    constructor Create(brush: TdxGPBrush; width: Single = 1.0); overload;
    destructor Destroy; override;
    function GetLastStatus: TdxGPStatus;
    function GetPenType: TdxGPPenType;
    //
    property ALignment: TdxGPPenAlignment read GetAlignment write SetAlignment;
    property Brush: TdxGPBrush read GetBrush write SetBrush;
    property Color: DWORD read GetColor write SetColor;
    property Width: Single read GetWidth write SetWidth;
  end;

  { TdxGPGraphics }

  TdxGPGraphics = class(TdxGPBase)
  private
    FHandle: GpGraphics;
    function GetInterpolationMode: Integer;
    function GetSmoothingMode: Integer;
    procedure SetInterpolationMode(AValue: Integer);
    procedure SetSmoothingMode(AValue: Integer);
  protected
    procedure FreeHandle;
  public
    constructor Create(AHandle: GpGraphics; ADummy: Integer = 0); overload;
    constructor Create(DC: HDC); overload;
    destructor Destroy; override;
    function GetHDC: HDC;
    procedure ReleaseHDC(DC: HDC);
    //
    procedure Clear(AColor: TColor);
    procedure DrawBitmap(ABitmap: TBitmap; const R: TRect; AAlpha: Byte = 255);
    procedure DrawImage(AImage: TdxPNGImage; const ADestRect, ASourceRect: TRect);
    procedure DrawImageTile(AImage: TdxPNGImage; const ADestRect, ASourceRect: TRect);
    procedure Ellipse(const R: TRect; APenColor, ABrushColor: TColor; APenWidth: Single = 1;
      APenStyle: TPenStyle = psSolid; APenColorAlpha: Byte = 255; ABrushColorAlpha: Byte = 255);
    procedure Line(X1, Y1, X2, Y2: Integer; APenColor: TColor; APenWidth: Single = 1;
      APenStyle: TPenStyle = psSolid; APenColorAlpha: Byte = 255);
    procedure Pie(const R: TRect; AStartAngle, ASweepAngle: Integer; APenColor: TColor;
      ABrushColor: TColor; APenWidth: Single = 1; APenStyle: TPenStyle = psSolid;
      APenColorAlpha: Byte = 255; ABrushColorAlpha: Byte = 255);
    procedure Polygon(const APoints: array of TPoint; APenColor: TColor;
      ABrushColor: TColor; APenWidth: Single = 1; APenStyle: TPenStyle = psSolid;
      APenColorAlpha: Byte = 255; ABrushColorAlpha: Byte = 255);
    procedure Polyline(const APoints: array of TPoint; APenColor: TColor;
      APenWidth: Single = 1; APenStyle: TPenStyle = psSolid; APenColorAlpha: Byte = 255);
    procedure Rectangle(const R: TRect; APenColor, ABrushColor: TColor; APenWidth: Single = 1;
      APenStyle: TPenStyle = psSolid; APenColorAlpha: Byte = 255; ABrushColorAlpha: Byte = 255);
    procedure RoundRect(const R: TRect; APenColor, ABrushColor: TColor; ARadiusX, ARadiusY: Integer;
      APenWidth: Integer = 1;APenColorAlpha: Byte = 255; ABrushColorAlpha: Byte = 255);
    //
    property Handle: GpGraphics read FHandle;
    property InterpolationMode: Integer read GetInterpolationMode write SetInterpolationMode;
    property SmoothingMode: Integer read GetSmoothingMode write SetSmoothingMode;
  end;

  { TdxGPImage }

  TdxGPImage = class(TdxGPBase)
  private
    FBits: TRGBColors;
    FHandle: GpImage;
    function GetClientRect: TRect;
    function GetHeight: Integer;
    function GetWidth: Integer;
  private
    procedure CreateHandleFromBitmap(ABitmap: TBitmap);
    procedure CreateHandleFromPattern(AWidth, AHeight: Integer;
      const ABits: TRGBColors; AHasAlphaChannel: Boolean);
    procedure FreeHandle; virtual;
    procedure LoadFromDataStream(AStream: TStream); virtual;
  public
    constructor CreateFromBitmap(ABitmap: TBitmap); virtual;
    constructor CreateFromPattern(const AWidth, AHeight: Integer;
      const ABits: TRGBColors; AHasAlphaChannel: Boolean); virtual;
    constructor CreateFromStream(AStream: TStream); virtual;
    destructor Destroy; override;
    //
    function GetAsBitmap: TBitmap; virtual;
    function GetBitmapBits: TRGBColors; overload;
    class function GetBitmapBits(ABitmap: TBitmap): TRGBColors; overload;
    //
    function Clone: TdxGPImage;
    function MakeComposition(AOverlay: TdxGPImage; AAlpha: Byte): TdxGPImage;
    procedure Draw(DC: HDC; const R: TRect);
    procedure DrawEx(AGraphics: GpGraphics;
      const ADestRect, ASourceRect: TRect; AConstantAlpha: Byte = 255);
    procedure SaveToStream(AStream: TStream);
    procedure Unpack;
    //
    property ClientRect: TRect read GetClientRect;
    property Handle: GpImage read FHandle;
    property Height: Integer read GetHeight;
    property Width: Integer read GetWidth;
  end;

  TdxGPImageClass = class of TdxGPImage;

  { TdxGPNullImage }

  TdxGPNullImage = class(TdxGPImage)
  public
    class function NewInstance: TObject; override;
    procedure FreeInstance; override;
  end;

  { TdxPNGImage }

  TdxPNGImage = class(TGraphic)
  private
    FHandle: TdxGPImage;
    FIsAlphaUsed: Boolean;
    FIsAlphaUsedAssigned: Boolean;
    procedure FreeHandle;
    function GetClientRect: TRect;
    procedure SetHandle(AHandle: TdxGPImage);
  protected
    procedure AssignTo(Dest: TPersistent); override;
    procedure Changed(Sender: TObject); override;
    function CheckAlphaUsed: Boolean;
    procedure Draw(ACanvas: TCanvas; const ARect: TRect); override;
    function GetEmpty: Boolean; override;
    function GetHeight: Integer; override;
    function GetIsAlphaUsed: Boolean;
    function GetSize: TSize;
    function GetTransparent: Boolean; override;
    function GetWidth: Integer; override;
    procedure SetHeight(Value: Integer); override;
    procedure SetWidth(Value: Integer); override;
  public
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    class function CreateFromBitmap(ASource: TBitmap): TdxGPImage;
    function Compare(AImage: TdxPngImage): Boolean; virtual;
    procedure DrawEx(Graphics: GpGraphics; const ADest, ASource: TRect);
    function GetAsBitmap: TBitmap; virtual;
    procedure SetBitmap(ABitmap: TBitmap); virtual;
    procedure LoadFromStream(Stream: TStream); override;
    procedure SaveToStream(Stream: TStream); override;
    procedure LoadFromClipboardFormat(AFormat: Word; AData: THandle;
      APalette: HPALETTE); override;
    procedure SaveToClipboardFormat(var AFormat: Word; var AData: THandle;
      var APalette: HPALETTE); override;
    procedure StretchDraw(DC: HDC; const ADest: TRect); overload; virtual;
    procedure StretchDraw(DC: HDC; const ADest, ASource: TRect); overload; virtual;
    procedure StretchDrawEx(Graphics: GpGraphics; const ADest, ASource: TRect); virtual;

    property ClientRect: TRect read GetClientRect;
    property Handle: TdxGPImage read FHandle write SetHandle;
    property IsAlphaUsed: Boolean read GetIsAlphaUsed;
  end;

var
  dxGPImageClass: TdxGPImageClass;

function dxGpCreatePen(APenColor: TColor; APenWidth: Single;
  APenStyle: TPenStyle = psSolid; APenColorAlpha: Byte = 255): GpPen;
function dxGpIsRectVisible(AGraphics: GpGraphics; const R: TRect): LongBool;

function dxGpBeginPaint(AHandle: GpGraphics): TdxGPGraphics; overload;
function dxGpBeginPaint(DC: HDC; const R: TRect): TdxGPGraphics; overload;
procedure dxGpEndPaint(var AGraphics: TdxGPGraphics);

procedure dxGpDrawImage(AGraphics: GpGraphics; const ADestRect: TRect;
  const ASourceRect: TRect; AImage: GpBitmap; AAlpha: Byte = 255); overload;
procedure dxGpFillRect(DC: HDC; const R: TRect; AColor: TColor; AColorAlpha: Byte = 255); overload;
procedure dxGpFillRect(AGraphics: GpGraphics; const R: TRect; AColor: ARGB); overload;
procedure dxGpFillRectByGradient(AGraphics: GpGraphics; const R: TRect;
  AColor1, AColor2: ARGB; AMode: TdxGPLinearGradientMode); overload;
procedure dxGpFillRectByGradient(DC: HDC; const R: TRect;
  AColor1, AColor2: TColor; AMode: TdxGPLinearGradientMode;
  AColor1Alpha: Byte = 255; AColor2Alpha: Byte = 255); overload;
procedure dxGpTilePart(DC: HDC; const ADestRect, ASourceRect: TRect; AImage: GpBitmap);
procedure dxGpTilePartEx(AGraphics: GpGraphics; const ADestRect, ASourceRect: TRect; AImage: GpBitmap);
procedure dxGpRoundRect(DC: HDC; const R: TRect;
  APenColor: TColor; ABrushColor: TColor; ARadius: Integer; APenWidth: Integer = 1;
  APenColorAlpha: Byte = 255; ABrushColorAlpha: Byte = 255);
implementation

uses
  Math;

type
  { TdxGPBufferedGraphics }

  TdxGPBufferedGraphics = class(TdxGPGraphics)
  private
    FBuffer: TBitmap;
    FDestRect: TRect;
    FOriginalDC: HDC;
    function CreateBuffer(DC: HDC; const R: TRect): HDC;
    procedure FreeBuffer;
    procedure OutputBuffer;
  public
    constructor Create(DC: HDC; const R: TRect);
    destructor Destroy; override;
  end;

function dxGpIsDoubleBufferNeeded(DC: HDC): Boolean;
begin
  Result := (GetDeviceCaps(DC, BITSPIXEL) <= 16) or
    (GetDeviceCaps(DC, TECHNOLOGY) = DT_RASPRINTER) or
    (GetDeviceCaps(DC, NUMCOLORS) > 1);
end;

function dxGpBeginPaint(AHandle: GpGraphics): TdxGPGraphics;
begin
  Result := TdxGPGraphics.Create(AHandle, 0);
end;

function dxGpBeginPaint(DC: HDC; const R: TRect): TdxGPGraphics;
begin
  if dxGpIsDoubleBufferNeeded(DC) then
    Result := TdxGPBufferedGraphics.Create(DC, R)
  else
    Result := TdxGPGraphics.Create(DC);
end;

procedure dxGpEndPaint(var AGraphics: TdxGPGraphics);
begin
  FreeAndNil(AGraphics);
end;

procedure dxGpDrawImage(AGraphics: GpGraphics; const ADestRect: TRect;
  const ASourceRect: TRect; AImage: GpBitmap; AAlpha: Byte = 255);
var
  AColorMatrix: TdxGPColorMatrix;
  AImageAttributes: GpImageAttributes;
  DstH, DstW, SrcH, SrcW: Integer;
begin
  SrcW := ASourceRect.Right - ASourceRect.Left;
  SrcH := ASourceRect.Bottom - ASourceRect.Top;
  DstW := ADestRect.Right - ADestRect.Left;
  DstH := ADestRect.Bottom - ADestRect.Top;
  if (SrcW < 1) or (SrcH < 1) or (DstW < 1) or (DstH < 1) then Exit;
  if (DstW > SrcW) and (SrcW > 1) then Dec(SrcW);
  if (DstH > SrcH) and (SrcH > 1) then Dec(SrcH);
  if dxGpIsRectVisible(AGraphics, ADestRect) then
  begin
    if AAlpha = 255 then
      GdipCheck(GdipDrawImageRectRectI(AGraphics, AImage, ADestRect.Left, ADestRect.Top,
        DstW, DstH, ASourceRect.Left, ASourceRect.Top, SrcW, SrcH, UnitPixel,
        nil, nil, nil))
    else
    begin
      GdipCheck(GdipCreateImageAttributes(AImageAttributes));
      try
        AColorMatrix := dxGpDefaultColorMatrix;
        AColorMatrix[3, 3] := AAlpha / 255;
        GdipCheck(GdipSetImageAttributesColorMatrix(AImageAttributes,
          ColorAdjustTypeBitmap, True, @AColorMatrix, nil, ColorMatrixFlagsDefault));
        GdipCheck(GdipDrawImageRectRectI(AGraphics, AImage, ADestRect.Left, ADestRect.Top,
          DstW, DstH, ASourceRect.Left, ASourceRect.Top, SrcW, SrcH, UnitPixel,
          AImageAttributes, nil, nil))
      finally
        GdipCheck(GdipDisposeImageAttributes(AImageAttributes));
      end;
    end;
  end;
end;

procedure dxGpFillRect(DC: HDC; const R: TRect; AColor: TColor; AColorAlpha: Byte = 255);
var
  AGraphics: TdxGPGraphics;
begin
  AGraphics := dxGpBeginPaint(DC, R);
  dxGpFillRect(AGraphics.Handle, R, dxGpColorToARGB(AColor, AColorAlpha));
  dxGpEndPaint(AGraphics);
end;

procedure dxGpFillRect(AGraphics: GpGraphics; const R: TRect; AColor: ARGB);
var
  ABrush: GpSolidFill;
  R1: TdxGPRect;
begin
  R1 := MakeRect(R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top);
  GdipCheck(GdipCreateSolidFill(AColor, ABrush));
  GdipCheck(GdipFillRectangleI(AGraphics, ABrush, R1.X, R1.Y, R1.Width, R1.Height));
  GdipCheck(GdipDeleteBrush(ABrush));
end;

procedure dxGpFillRectByGradient(DC: HDC; const R: TRect;
  AColor1, AColor2: TColor; AMode: TdxGPLinearGradientMode;
  AColor1Alpha: Byte = 255; AColor2Alpha: Byte = 255);
var
  AGraphics: TdxGPGraphics;
begin
  if not IsRectEmpty(R) then
  begin
    AGraphics := dxGpBeginPaint(DC, R);
    dxGpFillRectByGradient(AGraphics.Handle, R,
      dxGpColorToARGB(AColor1, AColor1Alpha),
      dxGpColorToARGB(AColor2, AColor2Alpha), AMode);
    dxGpEndPaint(AGraphics);
  end;
end;

procedure dxGpFillRectByGradient(AGraphics: GpGraphics;
  const R: TRect; AColor1, AColor2: ARGB; AMode: TdxGPLinearGradientMode);
var
  ABrush: GpLineGradient;
  ABrushRect: TdxGPRect;
begin
  // Inflate: Avoid GDIPlus gradient fill bug
  ABrushRect := MakeRect(R.Left - 1, R.Top - 1, R.Right - R.Left + 2, R.Bottom - R.Top + 2);
  GdipCheck(GdipCreateLineBrushFromRectI(@ABrushRect, AColor1, AColor2, AMode, WrapModeTile, ABrush));
  GdipCheck(GdipFillRectangleI(AGraphics, ABrush, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top));
  GdipCheck(GdipDeleteBrush(ABrush));
end;

function dxGpCreatePen(APenColor: TColor; APenWidth: Single;
  APenStyle: TPenStyle = psSolid; APenColorAlpha: Byte = 255): GpPen;
const
  PenStylesMap: array[psSolid..psInsideFrame] of GpDashStyle = (DashStyleSolid,
    DashStyleDash, DashStyleDot, DashStyleDashDot, DashStyleDashDotDot,
    DashStyleCustom, DashStyleCustom);
begin
  GdipCheck(GdipCreatePen1(dxGpColorToARGB(APenColor, APenColorAlpha), APenWidth, UnitPixel, Result));
  GdipCheck(GdipSetPenDashStyle(Result, PenStylesMap[APenStyle]));
end;

function dxGpIsRectVisible(AGraphics: GpGraphics; const R: TRect): LongBool;
begin
  GdipCheck(GdipIsVisibleRectI(AGraphics,
    R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top, Result));
end;

procedure dxGpTilePart(DC: HDC; const ADestRect, ASourceRect: TRect; AImage: GpBitmap);
var
  AGraphics: TdxGPGraphics;
begin
  AGraphics := dxGpBeginPaint(DC, ADestRect);
  dxGpTilePartEx(AGraphics.Handle, ADestRect, ASourceRect, AImage);
  dxGpEndPaint(AGraphics);
end;

procedure dxGpTilePartEx(AGraphics: GpGraphics; const ADestRect, ASourceRect: TRect; AImage: GpBitmap);

  function CreateTextureBrush(R: TRect; out ATexture: GpTexture): Boolean;
  begin
    Result := GdipCreateTexture2I(AImage, WrapModeTile,
      R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top, ATexture) = Ok;
  end;

  procedure ManualTilePart(const ADest, ASource: TRect;
    ADestWidth, ADestHeight, ASourceWidth, ASourceHeight: Integer);
  var
    ALastCol, ALastRow, ACol, ARow: Integer;
    RDest, RSrc: TRect;
  begin
    ALastCol := ADestWidth div ASourceWidth - Ord(ADestWidth mod ASourceWidth = 0);
    ALastRow := ADestHeight div ASourceHeight - Ord(ADestHeight mod ASourceHeight = 0);
    for ARow := 0 to ALastRow do
    begin
      RSrc.Top := ASource.Top;
      RSrc.Bottom := ASource.Bottom;
      RDest.Top := ADest.Top + ASourceHeight * ARow;
      RDest.Bottom := RDest.Top + ASourceHeight;
      if RDest.Bottom > ADest.Bottom then
      begin
        Dec(RSrc.Bottom, RDest.Bottom - ADest.Bottom);
        RDest.Bottom := ADest.Bottom;
      end;
      for ACol := 0 to ALastCol do
      begin
        RSrc.Left := ASource.Left;
        RSrc.Right := ASource.Right;
        RDest.Left := ADest.Left + ASourceWidth * ACol;
        RDest.Right := RDest.Left + ASourceWidth;
        if RDest.Right > ADest.Right then
        begin
          Dec(RSrc.Right, RDest.Right - ADest.Right);
          RDest.Right := ADest.Right;
        end;
        dxGpDrawImage(AGraphics, RDest, RSrc, AImage);
      end;
    end;
  end;

  function TilePartByBrush(const R, ASource: TRect): Boolean;
  var
    ABitmap: GpBitmap;
    ABitmapGraphics: GpGraphics;
    ATexture: GpTexture;
    AWidth, AHeight: Integer;
  begin
    Result := CreateTextureBrush(ASource, ATexture);
    if Result then
    try
      AWidth := R.Right - R.Left;
      AHeight := R.Bottom - R.Top;
      GdipCheck(GdipCreateBitmapFromScan0(AWidth, AHeight, 0, PixelFormat32bppPARGB, nil, ABitmap));
      try
        GdipCheck(GdipGetImageGraphicsContext(ABitmap, ABitmapGraphics));
        GdipCheck(GdipFillRectangleI(ABitmapGraphics, ATexture, 0, 0, AWidth, AHeight));
        GdipCheck(GdipDrawImageRectI(AGraphics, ABitmap, R.Left, R.Top, AWidth, AHeight));
        GdipCheck(GdipDeleteGraphics(ABitmapGraphics));
      finally
        GdipCheck(GdipDisposeImage(ABitmap));
      end;
    finally
      GdipCheck(GdipDeleteBrush(ATexture));
    end;
  end;

var
  ADestWidth, ADestHeight: Integer;
  ASourceWidth, ASourceHeight: Integer;
begin
  if not IsRectEmpty(ASourceRect) and dxGpIsRectVisible(AGraphics, ADestRect) then
  begin
    ADestWidth := ADestRect.Right - ADestRect.Left;
    ADestHeight := ADestRect.Bottom - ADestRect.Top;
    ASourceWidth := ASourceRect.Right - ASourceRect.Left;
    ASourceHeight := ASourceRect.Bottom - ASourceRect.Top;
    if (ADestWidth <= ASourceWidth) and (ADestHeight <= ASourceHeight) or
       not TilePartByBrush(ADestRect, ASourceRect)
    then
      ManualTilePart(ADestRect, ASourceRect, ADestWidth, ADestHeight, ASourceWidth, ASourceHeight);
  end;
end;

procedure dxGpRoundRect(DC: HDC; const R: TRect; APenColor: TColor;
  ABrushColor: TColor; ARadius: Integer; APenWidth: Integer = 1;
  APenColorAlpha: Byte = 255; ABrushColorAlpha: Byte = 255);
var
  AGraphics: TdxGPGraphics;
begin
  AGraphics := dxGpBeginPaint(DC, R);
  try
    AGraphics.RoundRect(R, APenColor, ABrushColor,
      ARadius, ARadius, APenWidth, APenColorAlpha, ABrushColorAlpha);
  finally
    dxGpEndPaint(AGraphics);
  end;
end;

{ TdxGPBrush }

constructor TdxGPBrush.Create;
begin
  SetStatus(NotImplemented);
  FNativeBrush := nil;
end;

destructor TdxGPBrush.Destroy;
begin
  GdipDeleteBrush(FNativeBrush);
  inherited;
end;

constructor TdxGPBrush.CreateNative(nativeBrush: GpBrush; AStatus: Status);
begin
  inherited Create;
  FLastResult := AStatus;
  SetNativeBrush(FNativeBrush);
end;

function TdxGPBrush.Clone: TdxGPBrush;
var
  gpB: GpBrush;
begin
  gpB := nil;
  Result := nil;
  SetStatus (GdipCloneBrush(FNativeBrush, gpB));
  try
    Result := TdxGPBrush.CreateNative(gpB, FLastResult);
  except
    GdipDeleteBrush(gpB);
  end;
end;

function TdxGPBrush.GetLastStatus: Status;
begin
  Result := FLastResult;
  FLastResult := Ok;
end;

function TdxGPBrush.GetType: BrushType;
begin
  SetStatus(GdipGetBrushType (FNativeBrush, Result));
end;

procedure TdxGPBrush.SetNativeBrush(ANativeBrush: GpBrush);
begin
  FNativeBrush := ANativeBrush;
end;

function TdxGPBrush.SetStatus(AStatus: TdxGPStatus): TdxGPStatus;
begin
  Result := AStatus;
  if (AStatus <> Ok) and (FLastResult <> AStatus) then
  Result := GenericError;
end;

{ TdxGPSolidBrush }

constructor TdxGPSolidBrush.Create(color: TColor);
var
  ABrush: GpSolidFill;
begin
  ABrush := nil;
  FLastResult := GdipCreateSolidFill(color, ABrush);
  SetNativeBrush(ABrush);
end;

constructor TdxGPSolidBrush.Create;
begin
// hide parent method
end;

function TdxGPSolidBrush.GetColor: DWORD;
begin
  SetStatus(GdipGetSolidFillColor(GPSOLIDFILL(FNativeBrush), Result));
end;

procedure TdxGPSolidBrush.SetColor(const Value: DWORD);
begin
  SetStatus(GdipSetSolidFillColor(GpSolidFill(FNativeBrush), Value));
end;

{ TdxGPLinearGradientBrush }

constructor TdxGPLinearGradientBrush.Create(rect: TdxGPRect; color1, color2: DWORD; mode: TdxGPLinearGradientMode);
var
  ABrush: GpLineGradient;
begin
  ABrush := nil;
  FLastResult := GdipCreateLineBrushFromRectI(@rect, color1, color2, mode, WrapModeTile, ABrush);
  SetNativeBrush(ABrush);
end;

constructor TdxGPLinearGradientBrush.Create;
begin
// hide parent method
end;

function TdxGPLinearGradientBrush.GetLinearColors(out color1, color2: DWORD): TdxGPStatus;
var
  AColors: array[0..1] of DWORD;
begin
  SetStatus(GdipGetLineColors(GpLineGradient(FNativeBrush), PARGB(@AColors)));
  if (FLastResult = Ok) then
  begin
    color1 := AColors[0];
    color2 := AColors[1];
  end;
  Result := FLastResult;
end;

function TdxGPLinearGradientBrush.GetRectangle: TdxGPRect;
var
  ARect: PdxGPRect;
begin
  ARect := @Result;
  SetStatus(GdipGetLineRectI(GpLineGradient(FNativeBrush), ARect));
end;

function TdxGPLinearGradientBrush.GetWrapMode: TdxGPWrapMode;
begin
   Result := WrapModeTile;
   SetStatus(GdipGetLineWrapMode(GpLineGradient(FNativeBrush), Result));
end;

function TdxGPLinearGradientBrush.SetLinearColors(color1, color2: DWORD): TdxGPStatus;
begin
  Result := SetStatus(GdipSetLineColors(GpLineGradient(FNativeBrush), color1, color2));
end;

procedure TdxGPLinearGradientBrush.SetWrapMode(const Value: TdxGPWrapMode);
begin
  SetStatus(GdipSetLineWrapMode(GpLineGradient(FNativeBrush), Value));
end;

{ TdxGPHatchBrush }

constructor TdxGPHatchBrush.Create;
begin
// hide parent method
end;

constructor TdxGPHatchBrush.Create(hatchStyle: TdxGPHatchStyle; foreColor,
  backColor: DWORD);
var
  ABrush: GpHatch;
begin
  ABrush := nil;
  FLastResult := GdipCreateHatchBrush(hatchStyle, foreColor, backColor, ABrush);
  SetNativeBrush(ABrush);
end;

function TdxGPHatchBrush.GetBackgroundColor: DWORD;
begin
  SetStatus(GdipGetHatchBackgroundColor(GpHatch(FNativeBrush), Result));
end;

function TdxGPHatchBrush.GetForegroundColor: DWORD;
begin
  SetStatus(GdipGetHatchForegroundColor(GpHatch(FNativeBrush), Result));
end;

function TdxGPHatchBrush.GetHatchStyle: TdxGPHatchStyle;
begin
  SetStatus(GdipGetHatchStyle(GpHatch(FNativeBrush), Result));
end;

{ TdxGPPen }

constructor TdxGPPen.Create(brush: TdxGPBrush; width: Single);
var
  unit_: TdxGPUnit;
begin
  unit_ := UnitWorld;
  FNativePen := nil;
  FLastResult := GdipCreatePen2(brush.FNativeBrush, width, unit_, FNativePen);
end;

constructor TdxGPPen.Create(color: DWORD; width: Single);
var
  unit_: TdxGPUnit;
begin
  unit_ := UnitPixel;
  FNativePen := nil;
  FLastResult := GdipCreatePen1(color, width, unit_, FNativePen);
end;

destructor TdxGPPen.Destroy;
begin
  GdipDeletePen(FNativePen);
  inherited;
end;

function TdxGPPen.GetAlignment: TdxGPPenAlignment;
begin
  SetStatus(GdipGetPenMode(FNativePen, Result));
end;

function TdxGPPen.GetBrush: TdxGPBrush;
var
  type_: TdxGPPenType;
  ABrush: TdxGPBrush;
  ANativeBrush: GpBrush;
begin
  type_ := GetPenType;
  ABrush := nil;
  case type_ of
     PenTypeSolidColor     : ABrush := TdxGPSolidBrush.Create;
     PenTypeHatchFill      : ABrush := TdxGPHatchBrush.Create;
     PenTypeTextureFill    : ABrush := TdxGPTextureBrush.Create;
     PenTypePathGradient   : ABrush := TdxGPBrush.Create;
     PenTypeLinearGradient : ABrush := TdxGPLinearGradientBrush.Create;
   end;
   if ABrush <> nil then
   begin
     SetStatus(GdipGetPenBrushFill(FNativePen, ANativeBrush));
     brush.SetNativeBrush(ANativeBrush);
   end;
   Result := ABrush;
end;

function TdxGPPen.GetColor: DWORD;
var
  type_: TdxGPPenType;
  argb: DWORD;
begin
  type_ := GetPenType;
  Result := 0;
  if (type_ = PenTypeSolidColor) then
  begin
    SetStatus(GdipGetPenColor(FNativePen, argb));
    if FLastResult = Ok then Result := argb;
  end;
end;

function TdxGPPen.GetLastStatus: TdxGPStatus;
begin
  Result := FLastResult;
  FLastResult := Ok;
end;

function TdxGPPen.GetPenType: TdxGPPenType;
begin
  SetStatus(GdipGetPenFillType(FNativePen, Result));
end;

function TdxGPPen.GetWidth: Single;
begin
  SetStatus(GdipGetPenWidth(FNativePen, Result));
end;

procedure TdxGPPen.SetAlignment(const Value: TdxGPPenAlignment);
begin
  SetStatus(GdipSetPenMode(FNativePen, Value));
end;

procedure TdxGPPen.SetBrush(const Value: TdxGPBrush);
begin
  SetStatus(GdipSetPenBrushFill(FNativePen, Value.FNativeBrush));
end;

procedure TdxGPPen.SetColor(const Value: DWORD);
begin
  SetStatus(GdipSetPenColor(FNativePen, Value));
end;

procedure TdxGPPen.SetNativePen(ANativePen: GpPen);
begin
  FNativePen := ANativePen;
end;

function TdxGPPen.SetStatus(status: TdxGPStatus): TdxGPStatus;
begin
  if (status <> Ok) then FLastResult := status;
  Result := status;
end;

procedure TdxGPPen.SetWidth(const Value: Single);
begin
  SetStatus(GdipSetPenWidth(FNativePen, Value));
end;

{ TdxGPGraphics }

constructor TdxGPGraphics.Create(AHandle: GpGraphics; ADummy: Integer = 0);
begin
  inherited Create;
  FHandle := AHandle;
end;

constructor TdxGPGraphics.Create(DC: HDC);
begin
  inherited Create;
  GdipCheck(GdipCreateFromHDC(DC, FHandle));
end;

destructor TdxGPGraphics.Destroy;
begin
  FreeHandle;
  inherited Destroy;
end;

procedure TdxGPGraphics.Clear(AColor: TColor);
begin
  GdipCheck(GdipGraphicsClear(Handle, dxGpColorToARGB(AColor)));
end;

procedure TdxGPGraphics.DrawBitmap(ABitmap: TBitmap; const R: TRect; AAlpha: Byte = 255);
var
  ASrcImage: TdxGPImage;
begin
  if not ABitmap.Empty then
  begin
    ASrcImage := TdxPNGImage.CreateFromBitmap(ABitmap);
    try
      ASrcImage.DrawEx(Handle, R, ASrcImage.ClientRect, AAlpha);
    finally
      ASrcImage.Free;
    end;
  end;
end;

procedure TdxGPGraphics.DrawImage(AImage: TdxPNGImage; const ADestRect, ASourceRect: TRect);
begin
  AImage.DrawEx(Handle, ADestRect, ASourceRect);
end;

procedure TdxGPGraphics.DrawImageTile(AImage: TdxPNGImage; const ADestRect, ASourceRect: TRect);
begin
  dxGpTilePartEx(Handle, ADestRect, ASourceRect, AImage.Handle.Handle);
end;

procedure TdxGPGraphics.Ellipse(const R: TRect; APenColor, ABrushColor: TColor;
  APenWidth: Single = 1; APenStyle: TPenStyle = psSolid; APenColorAlpha: Byte = 255;
  ABrushColorAlpha: Byte = 255);
var
  ABrush: GpBrush;
  APen: GpPen;
begin
  if ABrushColor <> clNone then
  begin
    GdipCheck(GdipCreateSolidFill(dxGpColorToARGB(ABrushColor, ABrushColorAlpha), ABrush));
    GdipCheck(GdipFillEllipseI(Handle, ABrush, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top));
    GdipCheck(GdipDeleteBrush(ABrush));
  end;

  if APenColor <> clNone then
  begin
    APen := dxGpCreatePen(APenColor, APenWidth, APenStyle, APenColorAlpha);
    GdipCheck(GdipDrawEllipseI(Handle, APen, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top));
    GdipCheck(GdipDeletePen(APen));
  end;
end;

procedure TdxGPGraphics.Line(X1, Y1, X2, Y2: Integer; APenColor: TColor;
  APenWidth: Single = 1; APenStyle: TPenStyle = psSolid; APenColorAlpha: Byte = 255);
var
  APen: GpPen;
begin
  if APenColor <> clNone then
  begin
    APen := dxGpCreatePen(APenColor, APenWidth, APenStyle, APenColorAlpha);
    GdipCheck(GdipDrawLineI(Handle, APen, X1, Y1, X2, Y2));
    GdipCheck(GdipDeletePen(APen));
  end;
end;

procedure TdxGPGraphics.Pie(const R: TRect; AStartAngle, ASweepAngle: Integer;
  APenColor: TColor; ABrushColor: TColor; APenWidth: Single = 1;
  APenStyle: TPenStyle = psSolid; APenColorAlpha: Byte = 255;
  ABrushColorAlpha: Byte = 255);
var
  ABrush: GpBrush;
  APen: GpPen;
begin
  if ABrushColor <> clNone then
  begin
    GdipCheck(GdipCreateSolidFill(dxGpColorToARGB(ABrushColor, ABrushColorAlpha), ABrush));
    GdipCheck(GdipFillPieI(Handle, ABrush, R.Left, R.Top,
      R.Right - R.Left, R.Bottom - R.Top, -AStartAngle, -ASweepAngle));
    GdipCheck(GdipDeleteBrush(ABrush));
  end;

  if APenColor <> clNone then
  begin
    APen := dxGpCreatePen(APenColor, APenWidth, APenStyle, APenColorAlpha);
    GdipCheck(GdipDrawPieI(Handle, APen, R.Left, R.Top,
      R.Right - R.Left, R.Bottom - R.Top, -AStartAngle, -ASweepAngle));
    GdipCheck(GdipDeletePen(APen));
  end;
end;

procedure TdxGPGraphics.Polygon(const APoints: array of TPoint; APenColor: TColor;
  ABrushColor: TColor; APenWidth: Single = 1; APenStyle: TPenStyle = psSolid;
  APenColorAlpha: Byte = 255; ABrushColorAlpha: Byte = 255);
var
  ABrush: GpBrush;
  APen: GpPen;
begin
  if ABrushColor <> clNone then
  begin
    GdipCheck(GdipCreateSolidFill(dxGpColorToARGB(ABrushColor, ABrushColorAlpha), ABrush));
    GdipCheck(GdipFillPolygonI(Handle, ABrush, @APoints[0], Length(APoints), FillModeWinding));
    GdipCheck(GdipDeleteBrush(ABrush));
  end;

  if APenColor <> clNone then
  begin
    APen := dxGpCreatePen(APenColor, APenWidth, APenStyle, APenColorAlpha);
    GdipCheck(GdipDrawPolygonI(Handle, APen, @APoints[0], Length(APoints)));
    GdipCheck(GdipDeletePen(APen));
  end;
end;

procedure TdxGPGraphics.Polyline(const APoints: array of TPoint; APenColor: TColor;
  APenWidth: Single = 1; APenStyle: TPenStyle = psSolid; APenColorAlpha: Byte = 255);
var
  APen: GpPen;
begin
  if APenColor <> clNone then
  begin
    APen := dxGpCreatePen(APenColor, APenWidth, APenStyle, APenColorAlpha);
    GdipCheck(GdipDrawLinesI(Handle, APen, @APoints[0], Length(APoints)));
    GdipCheck(GdipDeletePen(APen));
  end;
end;

procedure TdxGPGraphics.Rectangle(const R: TRect; APenColor, ABrushColor: TColor;
  APenWidth: Single = 1; APenStyle: TPenStyle = psSolid; APenColorAlpha: Byte = 255;
  ABrushColorAlpha: Byte = 255);
var
  ABrush: GpBrush;
  APen: GpPen;
begin
  if ABrushColor <> clNone then
  begin
    GdipCheck(GdipCreateSolidFill(dxGpColorToARGB(ABrushColor, ABrushColorAlpha), ABrush));
    GdipCheck(GdipFillRectangleI(Handle, ABrush, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top));
    GdipCheck(GdipDeleteBrush(ABrush));
  end;

  if APenColor <> clNone then
  begin
    APen := dxGpCreatePen(APenColor, APenWidth, APenStyle, APenColorAlpha);
    GdipCheck(GdipDrawRectangleI(Handle, APen, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top));
    GdipCheck(GdipDeletePen(APen));
  end;
end;

procedure TdxGPGraphics.RoundRect(const R: TRect; APenColor, ABrushColor: TColor;
  ARadiusX, ARadiusY: Integer; APenWidth: Integer = 1;APenColorAlpha: Byte = 255;
  ABrushColorAlpha: Byte = 255);

  function CreateRoundRectPath(const R: TRect; ARadiusX, ARadiusY: Integer): GpPath;
  begin
    ARadiusX := Min(ARadiusX, (R.Right - R.Left) div 3);
    ARadiusY := Min(ARadiusY, (R.Bottom - R.Top) div 3);

    GdipCheck(GdipCreatePath(FillModeAlternate, Result));
    GdipStartPathFigure(Result);
    GdipAddPathLine(Result, R.Left + ARadiusX, R.Top, R.Right - 2 * ARadiusX, R.Top);
    GdipAddPathArc(Result, R.Right - 2 * ARadiusX, R.Top, 2 * ARadiusX, 2 * ARadiusY, 270, 90);
    GdipAddPathLine(Result, R.Right, R.Top + ARadiusY, R.Right, R.Bottom - 2 * ARadiusY);
    GdipAddPathArc(Result, R.Right - 2 * ARadiusX, R.Bottom - 2 * ARadiusY, 2 * ARadiusX, 2 * ARadiusY, 0, 90);
    GdipAddPathLine(Result, R.Right - 2 * ARadiusX, R.Bottom, R.Left + ARadiusX, R.Bottom);
    GdipAddPathArc(Result, R.Left, R.Bottom - 2 * ARadiusY, 2 * ARadiusX, 2 * ARadiusY, 90, 90);
    GdipAddPathLine(Result, R.Left, R.Bottom - 2 * ARadiusY, R.Left, R.Top + ARadiusY);
    GdipAddPathArc(Result, R.Left, R.Top, 2 * ARadiusX, 2 * ARadiusY, 180, 90);
    GdipClosePathFigure(Result);
  end;

var
  ABrush: GpBrush;
  APath: GpPath;
  APen: GpPen;
begin
  APath := CreateRoundRectPath(R, ARadiusX, ARadiusY);
  if ABrushColor <> clNone then
  begin
    GdipCheck(GdipCreateSolidFill(dxGpColorToARGB(ABrushColor, ABrushColorAlpha), ABrush));
    GdipCheck(GdipFillPath(Handle, ABrush, APath));
    GdipCheck(GdipDeleteBrush(ABrush));
  end;
  if APenColor <> clNone then
  begin
    GdipCheck(GdipCreatePen1(dxGpColorToARGB(APenColor, APenColorAlpha), APenWidth, UnitPixel, APen));
    GdipCheck(GdipDrawPath(Handle, APen, APath));
    GdipCheck(GdipDeletePen(APen));
  end;
  GdipCheck(GdipDeletePath(APath));
end;

procedure TdxGPGraphics.FreeHandle;
begin
  if FHandle <> nil then
  begin
    GdipCheck(GdipDeleteGraphics(FHandle));
    FHandle := nil;
  end;
end;

function TdxGPGraphics.GetHDC: HDC;
begin
  GdipCheck(GdipGetDC(Handle, Result));
end;

procedure TdxGPGraphics.ReleaseHDC(DC: HDC);
begin
  GdipCheck(GdipReleaseDC(Handle, DC));
end;

function TdxGPGraphics.GetInterpolationMode: Integer;
begin
  GdipCheck(GdipGetInterpolationMode(Handle, Result));
end;

function TdxGPGraphics.GetSmoothingMode: Integer;
begin
  GdipCheck(GdipGetSmoothingMode(Handle, Result));
end;

procedure TdxGPGraphics.SetInterpolationMode(AValue: Integer);
begin
  GdipCheck(GdipSetInterpolationMode(Handle, AValue));
end;

procedure TdxGPGraphics.SetSmoothingMode(AValue: Integer);
begin
  GdipCheck(GdipSetSmoothingMode(Handle, AValue));
end;

{ TdxGPBufferedGraphics }

constructor TdxGPBufferedGraphics.Create(DC: HDC; const R: TRect);
begin
  inherited Create(CreateBuffer(DC, R));
end;

destructor TdxGPBufferedGraphics.Destroy;
begin
  FreeHandle;
  OutputBuffer;
  FreeBuffer;
  inherited Destroy;
end;

function TdxGPBufferedGraphics.CreateBuffer(DC: HDC; const R: TRect): HDC;
begin
  FDestRect := R;
  FOriginalDC := DC;

  FBuffer := TBitmap.Create;
  FBuffer.PixelFormat := pf32bit;
  FBuffer.Height := R.Bottom - R.Top + 1;
  FBuffer.Width := R.Right - R.Left + 1;
  FBuffer.Canvas.Lock;

  Result := FBuffer.Canvas.Handle;
  BitBlt(Result, 0, 0, FBuffer.Width, FBuffer.Height, DC, R.Left, R.Top, SRCCOPY);
  SetWindowOrgEx(Result, R.Left, R.Top, nil);
end;

procedure TdxGPBufferedGraphics.FreeBuffer;
begin
  FBuffer.Canvas.Unlock;
  FreeAndNil(FBuffer);
end;

procedure TdxGPBufferedGraphics.OutputBuffer;
var
  ACanvas: TCanvas;
  ASaveIndex: Integer;
begin
  //#AI: using TCanvas for valid bitmap drawing to 256 colors DC
  ACanvas := TCanvas.Create;
  try
    ACanvas.Lock;
    try
      ASaveIndex := SaveDC(FOriginalDC);
      ACanvas.Handle := FOriginalDC;
      SetWindowOrgEx(FBuffer.Canvas.Handle, 0, 0, nil);
      ACanvas.Draw(FDestRect.Left, FDestRect.Top, FBuffer);
      ACanvas.Handle := 0;
      RestoreDC(FOriginalDC, ASaveIndex);
    finally
      ACanvas.Unlock;
    end;
  finally
    ACanvas.Free;
  end;
end;

{ TdxGPImage }

constructor TdxGPImage.CreateFromBitmap(ABitmap: TBitmap);
begin
  CheckPngCodec;
  CreateHandleFromBitmap(ABitmap);
end;

constructor TdxGPImage.CreateFromPattern(const AWidth, AHeight: Integer;
  const ABits: TRGBColors; AHasAlphaChannel: Boolean);
begin
  CreateHandleFromPattern(AWidth, AHeight, ABits, AHasAlphaChannel);
end;

constructor TdxGPImage.CreateFromStream(AStream: TStream);
var
  Bitmap: TBitmap;
  Header: TBitmapFileHeader;
begin
  if not CheckGdiPlus or (AStream.Size < SizeOf(Header)) then Exit;
  AStream.ReadBuffer(Header, SizeOf(Header));
  AStream.Seek(-SizeOf(Header), soFromCurrent);
  if Header.bfType = $4D42 then
  begin
    Bitmap := TBitmap.Create;
    try
      Bitmap.LoadFromStream(AStream);
      CreateFromBitmap(Bitmap);
    finally
      Bitmap.Free;
    end;                                         
  end
  else
    LoadFromDataStream(AStream);
end;

destructor TdxGPImage.Destroy;
begin
  FreeHandle;
  FBits := nil;
  inherited Destroy;
end;

function TdxGPImage.Clone: TdxGPImage;
begin
  if Length(FBits) > 0 then
    Result := dxGpImageClass.CreateFromPattern(Width, Height, FBits, True)
  else
  begin
    Result := dxGpImageClass.Create;
    GdipCheck(GdipCloneImage(Handle, Result.FHandle));
  end;
end;

procedure TdxGPImage.CreateHandleFromBitmap(ABitmap: TBitmap);
begin
  CreateHandleFromPattern(ABitmap.Width, ABitmap.Height,
    GetBitmapBits(ABitmap), cxGetBitmapPixelFormat(ABitmap) >= 32);
end;

procedure TdxGPImage.CreateHandleFromPattern(AWidth, AHeight: Integer;
  const ABits: TRGBColors; AHasAlphaChannel: Boolean);
var
  I: Integer;
begin
  FreeHandle;
  FBits := ABits;
  if not AHasAlphaChannel then
  begin
    for I := 0 to Length(FBits) - 1 do
      FBits[I].rgbReserved := 255;
  end;
  GdipCheck(GdipCreateBitmapFromScan0(AWidth, AHeight,
    AWidth * 4, PixelFormat32bppPARGB, @FBits[0], FHandle));
end;

procedure TdxGPImage.SaveToStream(AStream: TStream);
begin
  GdipCheck(GdipSaveImageToStream(Handle,
    TStreamAdapter.Create(AStream, soReference), @PngCodec, nil));
end;

procedure TdxGPImage.Draw(DC: HDC; const R: TRect);
var
  AGraphics: TdxGPGraphics;
begin
  AGraphics := dxGpBeginPaint(DC, R);
  DrawEx(AGraphics.Handle, R, ClientRect);
  dxGpEndPaint(AGraphics);
end;

procedure TdxGPImage.DrawEx(AGraphics: GpGraphics;
  const ADestRect, ASourceRect: TRect; AConstantAlpha: Byte = 255);
begin
  dxGpDrawImage(AGraphics, ADestRect, ASourceRect, Handle, AConstantAlpha);
end;

function TdxGPImage.GetAsBitmap: TBitmap;
var
  ABitmapHandle: HBITMAP;
begin
  GdipCheck(GdipCreateHBITMAPFromBitmap(Handle, ABitmapHandle, 0));
  Result := TBitmap.Create;
  Result.PixelFormat := pf32Bit;
  Result.Handle := ABitmapHandle;
end;

class function TdxGPImage.GetBitmapBits(ABitmap: TBitmap): TRGBColors;
begin
  if not dxCore.GetBitmapBits(ABitmap, Result, True) then
    GetBitmapBitsByScanLine(ABitmap, Result);
end;

function TdxGPImage.GetBitmapBits: TRGBColors;
begin
  Unpack;
  SetLength(Result, Length(FBits));
  Move(FBits[0], Result[0], Length(FBits) * SizeOf(Result[0]));
end;

function TdxGPImage.GetClientRect: TRect;
begin
  Result := Bounds(0, 0, Width, Height);
end;

function TdxGPImage.GetHeight: Integer;
begin
  GdipCheck(GdipGetImageHeight(Handle, Result));
end;

function TdxGPImage.GetWidth: Integer;
begin
  GdipCheck(GdipGetImageWidth(Handle, Result));
end;

procedure TdxGPImage.FreeHandle;
begin
  if Assigned(Handle) then
  begin
    GdipCheck(GdipDisposeImage(Handle));
    FHandle := nil;
  end;
end;

procedure TdxGPImage.LoadFromDataStream(AStream: TStream);
begin
  FHandle := dxGpGetImageFromStream(AStream);
end;

function TdxGPImage.MakeComposition(AOverlay: TdxGPImage; AAlpha: Byte): TdxGPImage;
var
  AGraphics: GpGraphics;
begin
  Result := dxGPImageClass.CreateFromPattern(Width, Height, nil, True);
  GdipCheck(GdipGetImageGraphicsContext(Result.Handle, AGraphics));
  DrawEx(AGraphics, Result.ClientRect, ClientRect);
  AOverlay.DrawEx(AGraphics, Result.ClientRect, AOverlay.ClientRect, AAlpha);
  GdipCheck(GdipDeleteGraphics(AGraphics));
end;

procedure TdxGPImage.Unpack;
var
  ABitmap: TBitmap;
begin
  if Length(FBits) = 0 then
  begin
    ABitmap := GetAsBitmap;
    try
      CreateHandleFromBitmap(ABitmap);
    finally
      ABitmap.Free;
    end;
  end;
end;

{ TdxGPNullImage }

class function TdxGPNullImage.NewInstance: TObject;
begin
  Result := InitInstance(AllocMem(InstanceSize));
end;

procedure TdxGPNullImage.FreeInstance;
var
  P: Pointer;
begin
  CleanupInstance;
  P := Self;
  FreeMem(P);
end;

{ TdxPNGImage }

destructor TdxPNGImage.Destroy;
begin
  FreeHandle;
  inherited Destroy;
end;

procedure TdxPNGImage.Assign(Source: TPersistent);
begin
  if Source is TBitmap then
    Handle := CreateFromBitmap(TBitmap(Source))
  else
    if Source is TdxPNGImage then
    begin
      if TdxPNGImage(Source).Handle = nil then
        Handle := nil
      else
        Handle := TdxPNGImage(Source).Handle.Clone;
    end
    else
      inherited Assign(Source);
end;

function TdxPNGImage.Compare(AImage: TdxPngImage): Boolean;

  function CompareColors(Color1, Color2: TRGBQuad): Boolean;
  begin
    Result := (Color1.rgbBlue = Color2.rgbBlue) and
      (Color1.rgbGreen = Color2.rgbGreen) and
      (Color1.rgbRed = Color2.rgbRed) and
      (Color1.rgbReserved = Color2.rgbReserved);
  end;

var
  AColors: TRGBColors;
  AColors2: TRGBColors;
  I: Integer;
begin
  AColors := nil;
  AColors2 := nil;
  Result := (AImage.Height = Height) and (AImage.Width = Width);
  if Result and not (AImage.Empty or Empty) then
  begin
    AColors := AImage.Handle.GetBitmapBits;
    AColors2 := Handle.GetBitmapBits;
    for I := 0 to High(AColors) do
    begin
      Result := CompareColors(AColors[I], AColors2[I]);
      if not Result then Break;
    end;
  end;
end;

procedure TdxPNGImage.DrawEx(Graphics: GpGraphics; const ADest, ASource: TRect);
begin
  StretchDrawEx(Graphics, ADest, ASource);
end;

procedure TdxPNGImage.FreeHandle;
begin
  FreeAndNil(FHandle);
end;

function TdxPNGImage.GetAsBitmap: TBitmap;
begin
  Result := Handle.GetAsBitmap;
end;

class function TdxPNGImage.CreateFromBitmap(ASource: TBitmap): TdxGPImage;
begin
  CheckGdiPlus;
  Result := dxGPImageClass.CreateFromBitmap(ASource);
end;

procedure TdxPNGImage.LoadFromStream(Stream: TStream);
begin
  if Stream.Size = 0 then
    Handle := nil
  else
    Handle := dxGPImageClass.CreateFromStream(Stream)
end;

procedure TdxPNGImage.SaveToStream(Stream: TStream);
var
  ADest: TMemoryStream;
begin
  if Handle <> nil then
  begin
    ADest := TMemoryStream.Create();
    try
      Handle.SaveToStream(ADest);
      ADest.Position := 0;
      Stream.CopyFrom(ADest, ADest.Size);
    finally
      ADest.Free;
    end;
  end;
end;

procedure TdxPNGImage.LoadFromClipboardFormat(AFormat: Word; AData: THandle;
  APalette: HPALETTE);
var
  ABitmap: TBitmap;
begin
  ABitmap := TBitmap.Create;
  try
    ABitmap.PixelFormat := pf32Bit;
    ABitmap.HandleType := bmDIB;
    ABitmap.LoadFromClipboardFormat(AFormat, AData, APalette);
    SetBitmap(ABitmap);
  finally
    ABitmap.Free;
  end;
end;

procedure TdxPNGImage.SaveToClipboardFormat(var AFormat: Word; var AData: THandle;
  var APalette: HPALETTE);
var
  ABitmap: TBitmap;
begin
  ABitmap := TBitmap.Create;
  try
    ABitmap.Width := Width;
    ABitmap.Height := Height;
    ABitmap.Canvas.Brush.Color := clWhite;
    ABitmap.Canvas.FillRect(Rect(0, 0, Width, Height));
    Draw(ABitmap.Canvas, Rect(0, 0, Width, Height));
    ABitmap.SaveToClipboardFormat(AFormat, AData, APalette);
  finally
    ABitmap.Free;
  end;
end;

procedure TdxPNGImage.SetBitmap(ABitmap: TBitmap);
begin
  Handle := CreateFromBitmap(ABitmap);
end;

procedure TdxPNGImage.StretchDraw(DC: HDC; const ADest: TRect);
begin
  StretchDraw(DC, ADest, ClientRect);
end;

procedure TdxPNGImage.StretchDraw(DC: HDC; const ADest, ASource: TRect);
var
  AGraphics: TdxGPGraphics;
begin
  if Handle <> nil then
  begin
    AGraphics := dxGpBeginPaint(DC, ADest);
    StretchDrawEx(AGraphics.Handle, ADest, ASource);
    dxGpEndPaint(AGraphics);
  end;
end;

procedure TdxPNGImage.StretchDrawEx(Graphics: GpGraphics; const ADest, ASource: TRect);
begin
  if Handle <> nil then
    Handle.DrawEx(Graphics, ADest, ASource);
end;

procedure TdxPNGImage.AssignTo(Dest: TPersistent); 
var
  ABitmap: TBitmap;
begin
  if Dest is TdxPNGImage then
    (Dest as TdxPNGImage).Assign(Self)  
  else
    if Dest is TBitmap then
    begin
      ABitmap := GetAsBitmap;
      try
        (Dest as TBitmap).Assign(ABitmap);
      finally
        ABitmap.Free;
      end;
    end
    else
      inherited AssignTo(Dest);
end;

procedure TdxPNGImage.Changed(Sender: TObject);
begin
  FIsAlphaUsedAssigned := False;
  inherited Changed(Sender);
end;

function TdxPNGImage.CheckAlphaUsed: Boolean;
var
  AColors: TRGBColors;
  I: Integer;
begin
  Result := False;
  AColors := Handle.GetBitmapBits;
  for I := Low(AColors) to High(AColors) do
  begin
    Result := AColors[I].rgbReserved <> 255;
    if Result then Break;
  end;
end;

procedure TdxPNGImage.Draw(ACanvas: TCanvas; const ARect: TRect);
begin
  StretchDraw(ACanvas.Handle, ARect, ClientRect);
end;

function TdxPNGImage.GetClientRect: TRect;
begin
  with GetSize do
    Result := Rect(0, 0, cx, cy);
end;

function TdxPNGImage.GetEmpty: Boolean;
begin
  with GetSize do
    Result := (cx <= 0) or (cy <= 0)
end;

function TdxPNGImage.GetHeight: Integer;
begin
  Result := GetSize.cy;
end;

function TdxPNGImage.GetIsAlphaUsed: Boolean;
begin
  if FIsAlphaUsedAssigned then
    Result := FIsAlphaUsed
  else
  begin
    FIsAlphaUsed := CheckAlphaUsed;
    FIsAlphaUsedAssigned := True;
    Result := FIsAlphaUsed;
  end;
end;

function TdxPNGImage.GetSize: TSize;
var
  W, H: Single;
begin
  if Handle <> nil then
    GdipCheck(GdipGetImageDimension(Handle.Handle, W, H))
  else
  begin
    W := 0;
    H := 0;
  end;
  Result.cx := Trunc(W);
  Result.cy := Trunc(H);
end;

function TdxPNGImage.GetTransparent: Boolean;
begin
  Result := True;
end;

function TdxPNGImage.GetWidth: Integer;
begin
  Result := GetSize.cx;
end;

procedure TdxPNGImage.SetWidth(Value: Integer);
begin
end;

procedure TdxPNGImage.SetHeight(Value: Integer);
begin
end;

procedure TdxPNGImage.SetHandle(AHandle: TdxGPImage);
begin
  if AHandle <> FHandle then
  begin
    FreeHandle;
    FHandle := AHandle;
    Changed(Self);
  end;
end;

//

procedure RegisterAssistants;
begin
  dxGPImageClass := TdxGPNullImage;
  if CheckGdiPlus then
  begin
    CheckPngCodec;
    dxGPImageClass := TdxGPImage;
    RegisterClasses([TdxPNGImage]);
  {$IFDEF DXREGISTERPNGIMAGE}
    TPicture.RegisterFileFormat('PNG', 'PNG graphics from DevExpress', TdxPNGImage);
  {$ELSE}
    TPicture.RegisterFileFormat('', '', TdxPNGImage);
  {$ENDIF}
  end;
end;

procedure UnregisterAssistants;
begin
  TPicture.UnregisterGraphicClass(TdxPNGImage);
  UnregisterClasses([TdxPNGImage]);
end;

initialization
  dxUnitsLoader.AddUnit(@RegisterAssistants, @UnregisterAssistants);

finalization
  dxUnitsLoader.RemoveUnit(@UnregisterAssistants);

end.
