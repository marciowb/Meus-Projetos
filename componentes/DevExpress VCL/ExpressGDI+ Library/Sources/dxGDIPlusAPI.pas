
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

unit dxGDIPlusAPI;

{$ALIGN ON}
{$MINENUMSIZE 4}

{$I cxVer.inc}


interface

(**************************************************************************\
*
*   GDI+ public header file
*
\**************************************************************************)

uses
  Windows, Graphics, Classes, SysUtils, ActiveX, dxCore;

const
  QualityModeInvalid                        = -1;
  QualityModeDefault                        = 0;
  QualityModeLow                            = 1; // Best performance
  QualityModeHigh                           = 2; // Best rendering quality

  InterpolationModeInvalid                  = QualityModeInvalid;
  InterpolationModeDefault                  = QualityModeDefault;
  InterpolationModeLowQuality               = QualityModeLow;
  InterpolationModeHighQuality              = QualityModeHigh;
  InterpolationModeBilinear                 = 3;
  InterpolationModeBicubic                  = 4;
  InterpolationModeNearestNeighbor          = 5;
  InterpolationModeHighQualityBilinear      = 6;
  InterpolationModeHighQualityBicubic       = 7;

// Alpha Compositing mode constants
  CompositingModeSourceOver                 = 0;
  CompositingModeSourceCopy                 = 1;

// Alpha Compositing quality constants
  CompositingQualityInvalid                 = QualityModeInvalid;
  CompositingQualityDefault                 = QualityModeDefault;
  CompositingQualityHighSpeed               = QualityModeLow;
  CompositingQualityHighQuality             = QualityModeHigh;
  CompositingQualityGammaCorrected          = 3;
  CompositingQualityAssumeLinear            = 4;

  SmoothingModeInvalid     = QualityModeInvalid;
  SmoothingModeDefault     = QualityModeDefault;
  SmoothingModeHighSpeed   = QualityModeLow;
  SmoothingModeHighQuality = QualityModeHigh;
  SmoothingModeNone        = 3;
  SmoothingModeAntiAlias   = 4;

  PixelFormat32bppPARGB = $E200B;

type
  TSingleDynArray = array of Single;

  // GDI+ base memory allocation class
  TdxGPBase = class
  public
    class function NewInstance: TObject; override;
    procedure FreeInstance; override;
  end;

  TgpImageAbort = function: Bool; 

// Unit constants
  Unit_ = (
    UnitWorld,      // 0 -- World coordinate (non-physical unit)
    UnitDisplay,    // 1 -- Variable -- for PageTransform only
    UnitPixel,      // 2 -- Each unit is one device pixel.
    UnitPoint,      // 3 -- Each unit is a printer's point, or 1/72 inch.
    UnitInch,       // 4 -- Each unit is 1 inch.
    UnitDocument,   // 5 -- Each unit is 1/300 inch.
    UnitMillimeter  // 6 -- Each unit is 1 millimeter.
  );
  TdxGPUnit = Unit_;

// Fill mode constants
  FillMode = (
    FillModeAlternate,        // 0
    FillModeWinding           // 1
  );
  TdxGPFillMode = FillMode;

// Various wrap modes for brushes
  WrapMode = (
    WrapModeTile,        // 0
    WrapModeTileFlipX,   // 1
    WrapModeTileFlipY,   // 2
    WrapModeTileFlipXY,  // 3
    WrapModeClamp        // 4
  );
  TdxGPWrapMode = WrapMode;

// Various hatch styles
  HatchStyle = (
    HatchStyleHorizontal,                  // = 0,
    HatchStyleVertical,                    // = 1,
    HatchStyleForwardDiagonal,             // = 2,
    HatchStyleBackwardDiagonal,            // = 3,
    HatchStyleCross,                       // = 4,
    HatchStyleDiagonalCross,               // = 5,
    HatchStyle05Percent,                   // = 6,
    HatchStyle10Percent,                   // = 7,
    HatchStyle20Percent,                   // = 8,
    HatchStyle25Percent,                   // = 9,
    HatchStyle30Percent,                   // = 10,
    HatchStyle40Percent,                   // = 11,
    HatchStyle50Percent,                   // = 12,
    HatchStyle60Percent,                   // = 13,
    HatchStyle70Percent,                   // = 14,
    HatchStyle75Percent,                   // = 15,
    HatchStyle80Percent,                   // = 16,
    HatchStyle90Percent,                   // = 17,
    HatchStyleLightDownwardDiagonal,       // = 18,
    HatchStyleLightUpwardDiagonal,         // = 19,
    HatchStyleDarkDownwardDiagonal,        // = 20,
    HatchStyleDarkUpwardDiagonal,          // = 21,
    HatchStyleWideDownwardDiagonal,        // = 22,
    HatchStyleWideUpwardDiagonal,          // = 23,
    HatchStyleLightVertical,               // = 24,
    HatchStyleLightHorizontal,             // = 25,
    HatchStyleNarrowVertical,              // = 26,
    HatchStyleNarrowHorizontal,            // = 27,
    HatchStyleDarkVertical,                // = 28,
    HatchStyleDarkHorizontal,              // = 29,
    HatchStyleDashedDownwardDiagonal,      // = 30,
    HatchStyleDashedUpwardDiagonal,        // = 31,
    HatchStyleDashedHorizontal,            // = 32,
    HatchStyleDashedVertical,              // = 33,
    HatchStyleSmallConfetti,               // = 34,
    HatchStyleLargeConfetti,               // = 35,
    HatchStyleZigZag,                      // = 36,
    HatchStyleWave,                        // = 37,
    HatchStyleDiagonalBrick,               // = 38,
    HatchStyleHorizontalBrick,             // = 39,
    HatchStyleWeave,                       // = 40,
    HatchStylePlaid,                       // = 41,
    HatchStyleDivot,                       // = 42,
    HatchStyleDottedGrid,                  // = 43,
    HatchStyleDottedDiamond,               // = 44,
    HatchStyleShingle,                     // = 45,
    HatchStyleTrellis,                     // = 46,
    HatchStyleSphere,                      // = 47,
    HatchStyleSmallGrid,                   // = 48,
    HatchStyleSmallCheckerBoard,           // = 49,
    HatchStyleLargeCheckerBoard,           // = 50,
    HatchStyleOutlinedDiamond,             // = 51,
    HatchStyleSolidDiamond,                // = 52,

    HatchStyleTotal                        // = 53,
  );

const
  HatchStyleLargeGrid = HatchStyleCross; // 4
  HatchStyleMin       = HatchStyleHorizontal;
  HatchStyleMax       = HatchStyleSolidDiamond;

type
  TdxGPHatchStyle = HatchStyle;

// Dash style constants
  DashStyle = (
    DashStyleSolid,          // 0
    DashStyleDash,           // 1
    DashStyleDot,            // 2
    DashStyleDashDot,        // 3
    DashStyleDashDotDot,     // 4
    DashStyleCustom          // 5
  );
  TdxGPDashStyle = DashStyle;

// WarpMode constants
  WarpMode = (
    WarpModePerspective,    // 0
    WarpModeBilinear        // 1
  );
  TdxGPWarpMode = WarpMode;

// LineGradient Mode
  LinearGradientMode = (
    LinearGradientModeHorizontal,         // 0
    LinearGradientModeVertical,           // 1
    LinearGradientModeForwardDiagonal,    // 2
    LinearGradientModeBackwardDiagonal    // 3
  );
  TdxGPLinearGradientMode = LinearGradientMode;

// Pen types
  PenAlignment = (
    PenAlignmentCenter,      // = 0,
    PenAlignmentInset        // = 1
  );
  TdxGPPenAlignment = PenAlignment;

// Brush types
  BrushType = (
   BrushTypeSolidColor,      // = 0,
   BrushTypeHatchFill,       // = 1,
   BrushTypeTextureFill,     // = 2,
   BrushTypePathGradient,    // = 3,
   BrushTypeLinearGradient   // = 4
  );
  TdxGPBrushType = BrushType;

// Pen's Fill types
  {$EXTERNALSYM PenType}
  PenType = Integer;
const
  PenTypeSolidColor       =  0;
  PenTypeHatchFill        =  1;
  PenTypeTextureFill      =  2;
  PenTypePathGradient     =  3;
  PenTypeLinearGradient   =  4;
  PenTypeUnknown          = -1;

type
  TdxGPPenType = PenType;

// Status return values from GDI+ methods
type
  Status = (
    Ok,
    GenericError,
    InvalidParameter,
    OutOfMemory,
    ObjectBusy,
    InsufficientBuffer,
    NotImplemented,
    Win32Error,
    WrongState,
    Aborted,
    FileNotFound,
    ValueOverflow,
    AccessDenied,
    UnknownImageFormat,
    FontFamilyNotFound,
    FontStyleNotFound,
    NotTrueTypeFont,
    UnsupportedGdiplusVersion,
    GdiplusNotInitialized,
    PropertyNotFound,
    PropertyNotSupported
  );
  TdxGPStatus = Status;

  TdxGPColorAdjustType = (
    ColorAdjustTypeDefault,
    ColorAdjustTypeBitmap,
    ColorAdjustTypeBrush,
    ColorAdjustTypePen,
    ColorAdjustTypeText,
    ColorAdjustTypeCount,
    ColorAdjustTypeAny      // Reserved
  );

  TdxGPColorMatrix = packed array[0..4, 0..4] of Single;
  PdxGPColorMatrix = ^TdxGPColorMatrix;

  TdxGPColorMatrixFlags = (
    ColorMatrixFlagsDefault,
    ColorMatrixFlagsSkipGrays,
    ColorMatrixFlagsAltGray
  );

type
  // Represents a dimension in a 2D coordinate system (floating-point coordinates)
  PdxGPSizeF = ^TdxGPSizeF;
  TdxGPSizeF = packed record
    Width  : Single;
    Height : Single;
  end;

  // Represents a dimension in a 2D coordinate system (integer coordinates)
  PdxGPSize = ^TdxGPSize;
  TdxGPSize = packed record
    Width  : Integer;
    Height : Integer;
  end;

  // Represents a location in a 2D coordinate system (floating-point coordinates)
  PdxGPPointF = ^TdxGPPointF;
  TdxGPPointF = packed record
    X : Single;
    Y : Single;
  end;
  TdxGPPointFDynArray = array of TdxGPPointF;

  // Represents a location in a 2D coordinate system (integer coordinates)
  PdxGPPoint = ^TdxGPPoint;
  TdxGPPoint = packed record
    X : Integer;
    Y : Integer;
  end;
  TdxGPPointDynArray = array of TdxGPPoint;

  // Represents a rectangle in a 2D coordinate system (floating-point coordinates)
  PdxGPRectF = ^TdxGPRectF;
  TdxGPRectF = packed record
    X     : Single;
    Y     : Single;
    Width : Single;
    Height: Single;
  end;
  TdxGPRectFDynArray = array of TdxGPRectF;

  PdxGPRect = ^TdxGPRect;
  TdxGPRect = packed record
    X     : Integer;
    Y     : Integer;
    Width : Integer;
    Height: Integer;
  end;
  TdxGPRectDynArray = array of TdxGPRect;

  PdxGPImageCodecInfo = ^TdxGPImageCodecInfo;
  TdxGPImageCodecInfo = packed record
    Clsid: TGUID;
    FormatID: TGUID;
    CodecName: Pointer;
    DllName: Pointer;
    FormatDescription: Pointer;
    FilenameExtension: Pointer;
    MimeType: Pointer;
    Flags: DWORD;
    Version: DWORD;
    SigCount: DWORD;
    SigSize: DWORD;
    SigPattern: PBYTE;
    SigMask: PBYTE;
  end;


  TEncoderParameter = packed record
    Guid           : TGUID;   // GUID of the parameter
    NumberOfValues : ULONG;   // Number of the parameter values
    Type_          : ULONG;   // Value type, like ValueTypeLONG  etc.
    Value          : Pointer; // A pointer to the parameter values
  end;
  PEncoderParameter = ^TEncoderParameter;

  TEncoderParameters = packed record
    Count     : UINT;               // Number of parameters in this structure
    Parameter : array[0..0] of TEncoderParameter;  // Parameter values
  end;
  PEncoderParameters = ^TEncoderParameters;

  DebugEventLevel = (
    DebugEventLevelFatal,
    DebugEventLevelWarning
  );
  TDebugEventLevel = DebugEventLevel;

  DebugEventProc = procedure(level: DebugEventLevel; message: PChar); stdcall;

  NotificationHookProc = function(out token: ULONG): Status; stdcall;
  NotificationUnhookProc = procedure(token: ULONG); stdcall;

  // Input structure for GdiplusStartup
  GdiplusStartupInput = packed record
    GdiplusVersion          : Cardinal;       // Must be 1
    DebugEventCallback      : DebugEventProc; // Ignored on free builds
    SuppressBackgroundThread: BOOL;           // FALSE unless you're prepared to call
                                              // the hook/unhook functions properly
    SuppressExternalCodecs  : BOOL;           // FALSE unless you want GDI+ only to use
  end;                                        // its internal image codecs.
  TGdiplusStartupInput = GdiplusStartupInput;
  PGdiplusStartupInput = ^TGdiplusStartupInput;

  // Output structure for GdiplusStartup()
  GdiplusStartupOutput = packed record
    NotificationHook  : NotificationHookProc;
    NotificationUnhook: NotificationUnhookProc;
  end;
  TGdiplusStartupOutput = GdiplusStartupOutput;
  PGdiplusStartupOutput = ^TGdiplusStartupOutput;

// Private GDI+ classes for internal type checking
  GpGraphics = Pointer;
  ARGB = DWORD;
  PARGB  = ^ARGB;

  GpBrush = Pointer;
  GpTexture = Pointer;
  GpSolidFill = Pointer;
  GpLineGradient = Pointer;
  GpPathGradient = Pointer;
  GpPath = Pointer;
  GpHatch = Pointer;
  GpPen = Pointer;
  GpImage = Pointer;
  GpBitmap = Pointer;
  GpCachedBitmap = Pointer;
  GpImageAttributes = Pointer;

  GPStatus          = TdxGPStatus;
  GpFillMode        = TdxGPFillMode;
  GpWrapMode        = TdxGPWrapMode;
  GpUnit            = TdxGPUnit;
  GpPointF          = PdxGPPointF;
  GpPoint           = PdxGPPoint;
  GpRectF           = PdxGPRectF;
  GpRect            = PdxGPRect;
  GpSizeF           = PdxGPSizeF;
  GpHatchStyle      = TdxGPHatchStyle;
  GpDashStyle       = TdxGPDashStyle;
  GpPenAlignment    = TdxGPPenAlignment;
  GpPenType         = TdxGPPenType;
  GpBrushType       = TdxGPBrushType;

  BitmapData = packed record
    Width       : UINT;
    Height      : UINT;
    Stride      : Integer;
    PixelFormat : Integer;
    Scan0       : Pointer;
    Reserved    : UINT;
  end;
  TBitmapData = BitmapData;
  PBitmapData = ^TBitmapData;

type
  TdxProc = procedure;

  { EdxGdipException }

  EdxGdipException = class(EdxException)
  private
    FStatus: GpStatus;
  public
    constructor Create(AStatus: GpStatus);
    //
    property Status: GpStatus read FStatus;
  end;

  { TdxUnitsLoader }

  TdxUnitsLoader = class
  protected
    FinalizeList: TList;
    InitializeList: TList;
  public
    constructor Create();
    destructor Destroy; override;
    procedure AddUnit(const AInitializeProc, AFinalizeProc: Pointer);
    procedure RemoveUnit(const AFinalizeProc: Pointer);
    procedure Finalize;
    procedure Initialize;
  end;

var
  // codecs
  PNGCodec: TGUID;
  // GDI+ Memory managment methods
  GdipAlloc: function(size: ULONG): pointer; stdcall;
  GdipFree: procedure(ptr: pointer); stdcall;
  // GDI+ initialization/finalization methods
  GdiplusStartup: function(out token: DWORD; const input: GdiplusStartupInput; output: PGdiplusStartupOutput): Status; stdcall;
  GdiplusShutdown: procedure(token: DWORD); stdcall;
  // GDI+ Brush methods
  GdipCloneBrush: function(brush :GpBrush; var clonebrush :GpBrush) :GPStatus; stdcall;
  GdipDeleteBrush: function(brush :GpBrush) :GPStatus; stdcall;
  GdipGetBrushType: function(brush :GpBrush; var bt :GpBrushType) :GPStatus; stdcall;
  // GDI+ Solid Brush methods
  GdipCreateSolidFill: function(color :ARGB; var brush :GpSolidFill) :GPStatus; stdcall;
  GdipSetSolidFillColor: function(brush :GpSolidFill; color :ARGB) :GPStatus; stdcall;
  GdipGetSolidFillColor: function(brush :GpSolidFill; var color :ARGB) :GPStatus; stdcall;
  // GDI+ Gradient Brush methods
  GdipCreateLineBrushFromRectI: function(const rect :GpRect; color1,color2 :ARGB; mode :LinearGradientMode;
      wrapmode :GpWrapMode; var lineGradient :GpLineGradient) :GPStatus; stdcall;
  GdipGetLineRectI: function(brush :GpLineGradient; var rect :GpRect) :GPStatus; stdcall;
  GdipSetLineColors: function(brush :GpLineGradient; color1,color2 :ARGB) :GPStatus; stdcall;
  GdipGetLineColors: function(brush :GpLineGradient; colors :PARGB) :GPStatus; stdcall;
  GdipSetLineWrapMode: function(brush :GpLineGradient; wrapmode :GpWrapMode) :GPStatus; stdcall;
  GdipGetLineWrapMode: function(brush :GpLineGradient; wrapmode :GpWrapMode) :GPStatus; stdcall;
  // GDI+ Hatch Brush methods
  GdipCreateHatchBrush: function(hatchstyle :GpHatchStyle; forecol,backcol :ARGB; var brush :GpHatch) :GPStatus; stdcall;
  GdipGetHatchStyle: function(brush :GpHatch; var hatchstyle :GpHatchStyle) :GPStatus; stdcall;
  GdipGetHatchForegroundColor: function(brush :GpHatch; var forecol :ARGB) :GPStatus; stdcall;
  GdipGetHatchBackgroundColor: function(brush :GpHatch; var backcol :ARGB) :GPStatus; stdcall;
  // GDI+ Pen methods
  GdipCreatePen1: function(color :ARGB; width :single; u :GpUnit; var pen :GpPen) :GPStatus; stdcall;
  GdipCreatePen2: function(brush :GpBrush; width :single; u :GpUnit; var pen :GpPen) :GPStatus; stdcall;
  GdipClonePen: function(pen :GpPen; var clonepen :GpPen) :GPStatus; stdcall;
  GdipDeletePen: function(pen :GpPen) :GPStatus; stdcall;
  GdipGetPenFillType: function(pen :GpPen; var penType :GpPenType) :GPStatus; stdcall;
  GdipSetPenBrushFill: function(pen :GpPen; brush :GpBrush) :GPStatus; stdcall;
  GdipGetPenBrushFill: function(pen :GpPen; var brush :GpBrush) :GPStatus; stdcall;
  GdipSetPenColor: function(pen :GpPen; color :ARGB) :GPStatus; stdcall;
  GdipGetPenColor: function(pen :GpPen; var color :ARGB) :GPStatus; stdcall;
  GdipSetPenMode: function(pen :GpPen; penMode :GpPenAlignment) :GPStatus; stdcall;
  GdipGetPenMode: function(pen :GpPen; var penMode :GpPenAlignment) :GPStatus; stdcall;
  GdipSetPenWidth: function(pen :GpPen; width :single) :GPStatus; stdcall;
  GdipGetPenWidth: function(pen :GpPen; var width :single) :GPStatus; stdcall;
  GdipGetPenDashStyle: function(pen: GPPEN; out dashstyle: GPDashStyle): GPSTATUS; stdcall;
  GdipSetPenDashStyle: function(pen: GPPEN; dashstyle: GPDashStyle): GPSTATUS; stdcall;
  // GDI+ Graphis methods
  GdipCreateFromHDC: function(hdc :HDC; var graphics :GpGraphics) :GPStatus; stdcall;
  GdipDeleteGraphics: function(graphics :GpGraphics) :GPStatus; stdcall;
  GdipGetDC: function(graphics :GpGraphics; var hdc :HDC) :GPStatus; stdcall;
  GdipReleaseDC: function(graphics :GpGraphics; hdc :HDC) :GPStatus; stdcall;
  GdipGraphicsClear: function(graphics :GpGraphics; color :ARGB) :GPStatus; stdcall;
  GdipDrawLineI: function(graphics :GpGraphics; pen :GpPen; x1,y1,x2,y2 :integer) :GPStatus; stdcall;
  GdipDrawLinesI: function(graphics :GpGraphics; pen :GpPen; const points :GpPoint; count: Integer) :GPStatus; stdcall;
  GdipFillRectangleI: function(graphics :GpGraphics; brush :GpBrush; x,y,width,height :integer) :GPStatus; stdcall;
  GdipDrawArcI: function(graphics :GpGraphics; pen :GpPen; x,y,width,height :integer;
      startAngle,sweepAngle :single) :GPStatus; stdcall;
  GdipDrawBezierI: function(graphics :GpGraphics; pen :GpPen; x1,y1,x2,y2,x3,y3,x4,y4 :integer) :GPStatus; stdcall;
  GdipDrawRectangleI: function(graphics :GpGraphics; pen :GpPen; x,y,width,height :integer) :GPStatus; stdcall;
  GdipDrawEllipseI: function(graphics :GpGraphics; pen :GpPen; x,y,width,height :integer) :GPStatus; stdcall;
  GdipDrawPieI: function(graphics :GpGraphics; pen :GpPen; x,y,width,height :integer;
      startAngle,sweepAngle :single) :GPStatus; stdcall;
  GdipDrawPolygonI: function(graphics :GpGraphics; pen :GpPen; const points :GpPoint;
      count :integer) :GPStatus; stdcall;
  GdipDrawCurve2I: function(graphics :GpGraphics; pen :GpPen; const points :GpPoint;
      count :integer; tension :single) :GPStatus; stdcall;
  GdipDrawClosedCurve2I: function(graphics :GpGraphics; pen :GpPen; const points :GpPoint;
      count :integer; tension :single) :GPStatus; stdcall;
  GdipFillPolygonI: function(graphics :GpGraphics; brush :GpBrush; const points :GpPoint;
      count :integer; fillmode :GpFillMode) :GPStatus; stdcall;
  GdipFillEllipseI: function(graphics :GpGraphics; brush :GpBrush; x,y,width,height :integer) :GPStatus; stdcall;
  GdipFillPieI: function(graphics :GpGraphics; brush :GpBrush; x,y,width,height :integer;
      startAngle,sweepAngle :single) :GPStatus; stdcall;
  GdipFillClosedCurveI: function(graphics :GpGraphics; brush :GpBrush; const points :GpPoint;
      count :integer) :GPStatus; stdcall;
  // added from MSN
  GdipLoadImageFromStream: function(stream: IStream; var image: GpImage): GPStatus; stdcall;
  GdipCreateHBITMAPFromBitmap: function(image: GpBitmap;  var bitmap: HBitmap; color :ARGB): GPStatus; stdcall;
  GdipCreateBitmapFromFile: function(filename: PWideChar; var bitmap: GpBitmap): GPStatus; stdcall;
  GdipCreateBitmapFromStream: function(stream: IStream; var bitmap: GpBitmap): GPStatus; stdcall;
  GdipCreateBitmapFromStreamICM: function (stream: ISTREAM; out bitmap: GpBitmap): GPStatus; stdcall;
  GdipLoadImageFromFile: function(filename: PWideChar; var image: GpImage): GPStatus; stdcall;
  GdipGetImageDimension: function(image: GpImage; var weidth, height: Single): GPStatus; stdcall;
  GdipDrawImageRectI: function(graphics: GpGraphics; image: GpImage;
    x, y: Integer; width, height: Integer): GPStatus; stdcall;
  GdipDisposeImage: function(image: GpImage): GPStatus; stdcall;
  GdipGetImageEncodersSize: function(out numEncoders: Integer; out size: Integer): GPStatus; stdcall;
  GdipGetImageEncoders: function(numEncoders: Integer; size: Integer; encoders: PdxGPImageCodecInfo): GPStatus; stdcall;
  GdipGetEncoderParameterListSize: function(image: GpImage; clsidEncoder: PGUID; out size: UINT): GPStatus; stdcall;
  GdipGetEncoderParameterList: function(image: GpImage; clsidEncoder: PGUID;
    size: UINT; buffer: PENCODERPARAMETERS): GPStatus; stdcall;
  GdipCreateBitmapFromGdiDib: function (gdiBitmapInfo: PBitmapInfo;
    gdiBitmapData: Pointer; out bitmap: GpBitmap): GPStatus; stdcall;
  GdipCreateBitmapFromScan0: function (width: Integer; height: Integer;
    stride: Integer; format: integer; scan0: PBYTE;
    out bitmap: GpImage): GPStatus; stdcall;
  GdipBitmapLockBits: function (bitmap: GpBitmap; rect: GPRECT; flags: UINT;
    format: Integer; lockedBitmapData: PBITMAPDATA): GPStatus; stdcall;
  GdipBitmapUnlockBits: function(bitmap: GpBitmap;
    lockedBitmapData: PBITMAPDATA): GPStatus; stdcall;
  GdipDrawImageRectRectI: function(graphics: GpGraphics; image: GpImage;
    dstx, dsty, dstwidth, dstheight: Integer;  srcx, srcy, srcwidth, srcheight: Integer;
    srcUnit: GPUNIT; imageAttributes: Pointer; callback: TgpImageAbort; callbackData: Pointer): GPStatus; stdcall;
  GdipDrawImageRectRect: function(graphics: GPGRAPHICS; image: GPIMAGE;
    dstx: Single; dsty: Single; dstwidth: Single; dstheight: Single;
    srcx: Single; srcy: Single; srcwidth: Single; srcheight: Single;
    srcUnit: GPUNIT; imageAttributes: Pointer; callback: TgpImageAbort; callbackData: Pointer): GPSTATUS; stdcall;
  GdipDrawImagePointRect: function(graphics: GPGRAPHICS; image: GPIMAGE;
    x: Single; y: Single; srcx: Single; srcy: Single; srcwidth: Single;
    srcheight: Single; srcUnit: GPUNIT): GPSTATUS; stdcall;
  GdipCloneImage: function(image: GPIMAGE; out cloneImage: GPIMAGE): GPSTATUS; stdcall;
  GdipCreateTexture2I: function (Image: GpImage; WrapMode: GpWrapMode;
    X, Y, Width, Height: Integer; out ATexture: GpTexture): GPStatus; stdcall;
  GdipCreateImageAttributes: function (out AImageAttr: GpImageAttributes): GPStatus; stdcall;
  GdipDisposeImageAttributes: function (AImageAttr: GpImageAttributes): GPStatus; stdcall;
  GdipSetImageAttributesColorMatrix: function (AImageAttr: GpImageAttributes;
    AType: TdxGPColorAdjustType; AEnableFlag: Bool; AColorMatrix: PdxGPColorMatrix;
    AGrayMatrix: PdxGPColorMatrix; AFlags: TdxGPColorMatrixFlags): GPStatus;  stdcall;
  // Paths
  GdipAddPathArc: function (APath: GpPath; X, Y, Width, Height, StartAngle, SweepAngle: Single): GPStatus; stdcall;
  GdipAddPathLine: function (APath: GpPath; X1, Y1, X2, Y2: Single): GPStatus; stdcall;
  GdipClosePathFigure: function (APath: GpPath): GPStatus; stdcall;
  GdipCreatePath: function (AFillMode: TdxGPFillMode; out APath: GpPath): GPStatus; stdcall;
  GdipDeletePath: function (APath: GpPath): GPStatus; stdcall;
  GdipDrawPath: function (AGraphics: GpGraphics; APen: GpPen; APath: GpPath): GPStatus; stdcall;
  GdipFillPath: function (AGraphics: GpGraphics; ABrush: GpBrush; APath: GpPath): GPStatus; stdcall;
  GdipStartPathFigure: function (APath: GpPath): GPStatus; stdcall;

  //lcm
  GdipSetInterpolationMode: function(graphics: GpGraphics; imode: Integer): GpStatus; stdcall;
  GdipGetInterpolationMode: function(graphics: GpGraphics; out imode: Integer): GpStatus; stdcall;
  GdipCreateCachedBitmap: function(bitmap: GpBitmap; graphics: GpGraphics; out cachedBitmap: GpCachedBitmap): GpStatus; stdcall;
  GdipDeleteCachedBitmap: function(cachedBitmap: GpCachedBitmap): GpStatus; stdcall;
  GdipDrawCachedBitmap: function(graphics: GpGraphics; cachedBitmap: GpCachedBitmap; x, y: Integer): GpStatus; stdcall;
  GdipCreateBitmapFromGraphics: function(width, height: Integer; target: GpGraphics; var bitmap: GpBitmap): GpStatus; stdcall;
  GdipGetImageGraphicsContext: function(image: GpImage; out graphics: GpGraphics): GpStatus; stdcall;
  GdipGetImageWidth: function(image: GpImage; out width: Integer): GpStatus; stdcall;
  GdipGetImageHeight: function(image: GpImage; out height: Integer): GpStatus; stdcall;
  GdipSetCompositingMode: function(graphics: GpGraphics; cmode: Integer): GpStatus; stdcall;
  GdipGetCompositingMode: function(graphics: GpGraphics; out cmode: Integer): GpStatus; stdcall;
  GdipSetCompositingQuality: function(graphics: GpGraphics; cq: Integer): GpStatus; stdcall;
  GdipGetCompositingQuality: function(graphics: GpGraphics; out cq: Integer): GpStatus; stdcall;
  GdipSetSmoothingMode: function(graphics: GpGraphics; sm: Integer): GpStatus; stdcall;
  GdipGetSmoothingMode: function(graphics: GpGraphics; out sm: Integer): GpStatus; stdcall;
  GdipCloneBitmapAreaI: function(x: Integer; y: Integer; width: Integer;
    height: Integer; format: Cardinal; srcBitmap: GPBITMAP; out dstBitmap: GPBITMAP): GPSTATUS; stdcall;

  {$EXTERNALSYM GdipBitmapUnlockBits}

  GdipSaveImageToStream: function(image: GpImage; stream: ISTREAM; clsidEncoder: PGUID; encoderParams: pointer): GpStatus; stdcall;
  GdipCreateBitmapFromHBITMAP: function(hbm: HBITMAP; hpal: HPALETTE; out bitmap: GpImage): GpStatus; stdcall;

  GdipIsVisibleRect: function (Graphics: GpGraphics; X, Y, Width, Height: Single; var Result: LongBool): GpStatus; stdcall;
  GdipIsVisibleRectI: function (Graphics: GpGraphics; X, Y, Width, Height: Integer; var Result: LongBool): GpStatus; stdcall;

var
  dxGpDefaultColorMatrix: TdxGPColorMatrix = (
    (1.0, 0.0, 0.0, 0.0, 0.0),
    (0.0, 1.0, 0.0, 0.0, 0.0),
    (0.0, 0.0, 1.0, 0.0, 0.0),
    (0.0, 0.0, 0.0, 1.0, 0.0),
    (0.0, 0.0, 0.0, 0.0, 1.0)
  );

function MakePoint(X, Y: Integer): TdxGPPoint; overload;
function MakePoint(X, Y: Single): TdxGPPointF; overload;
function MakeRect(x, y, width, height: Integer): TdxGPRect; overload;
function MakeRect(location: TdxGPPoint; size: TdxGPSize): TdxGPRect; overload;
function MakeRect(Rect: TRect): TdxGPRect; overload;
function MakeRect(x, y, width, height: Single): TdxGPRectF; overload;
function MakeRect(location: TdxGPPointF; size: TdxGPSizeF): TdxGPRectF; overload;
function MakeSize(Width, Height: Single): TdxGPSizeF; overload;
function MakeSize(Width, Height: Integer): TdxGPSize; overload;

// image conversion
function DifferentImage2Bitmap(AStream: TStream): TBitmap; overload;
function DifferentImage2Bitmap(const AFileName: string): TBitmap; overload;
procedure Bitmap2PNG(ABitmap: TBitmap; AStream: TStream); overload;
procedure Bitmap2PNG(ABitmap: TBitmap; const AFileName: string); overload;
// codecs
function GetCodecID(const CodecName: string; out Clsid: TGUID): GPStatus;
procedure CheckPngCodec;
// check errors
procedure GdipCheck(AStatus: Boolean); overload;
procedure GdipCheck(AStatus: GPStatus); overload;

function dxGpColorToARGB(AColor: TColor; AAlpha: Byte = 255): ARGB;
function dxGpMakeARGBColor(A, R, G, B: Byte): ARGB;

function dxGpCreateBitmap(AWidth, AHeight: Integer): GpBitmap; overload;
function dxGpCreateBitmap(const ASize: TSize): GpBitmap; overload;
function dxGpCreateBitmap(const R: TRect): GpBitmap; overload;
function dxGpGetImageFromStream(AStream: TStream): GpImage;
// CLR

procedure dxInitializeGDIPlus; stdcall;
procedure dxFinalizeGDIPlus; stdcall;

function dxUnitsLoader: TdxUnitsLoader;
function CheckGdiPlus: Boolean;

resourcestring
  scxGdipInvalidOperation = 'Invalid operation in GDI+ (Code: %d)';

implementation

const
  GDIPlusLibraryName = 'gdiplus.dll';

var
  FGDIPlusLibrary: Integer;
  FGDIPlusToken: DWORD;
  FGdiPlusHook: TGdiplusStartupOutput;
  FGDIPresent: Boolean;
  FGDIInitialized: Boolean;
  UnitsLoader: TdxUnitsLoader;

function IsDLL: Boolean;
begin
  Result := ModuleIsLib and not ModuleIsPackage;
end;

function dxGpCreateBitmap(AWidth, AHeight: Integer): GpBitmap;
begin
  GdipCheck(GdipCreateBitmapFromScan0(AWidth, AHeight, 0, PixelFormat32bppPARGB, nil, Result));
end;

function dxGpCreateBitmap(const ASize: TSize): GpBitmap;
begin
  Result := dxGpCreateBitmap(ASize.cx, ASize.cy);
end;

function dxGpCreateBitmap(const R: TRect): GpBitmap;
begin
  Result := dxGpCreateBitmap(R.Right - R.Left, R.Bottom - R.Top);
end;

function dxGpGetImageFromStream(AStream: TStream): GpImage;
var
  AAccessStream: IStream;
  AData: HGlobal;
  ADataPtr: Pointer;
begin
  Result := nil;
  if CheckGdiPlus then
  begin
    AData := GlobalAlloc(GMEM_MOVEABLE or GMEM_DDESHARE, AStream.Size);
    try
      ADataPtr := GlobalLock(AData);
      try
        AStream.Read(ADataPtr^, AStream.Size);
        GdipCheck(CreateStreamOnHGlobal(AData, False, AAccessStream) = S_OK);
        GdipCheck(GdipCreateBitmapFromStream(AAccessStream, Result));
      finally
        GlobalUnlock(AData);
        AAccessStream := nil;
      end;
    finally
      GlobalFree(AData);
    end;
  end;
end;

function dxGpColorToARGB(AColor: TColor; AAlpha: Byte = 255): ARGB;
begin
  if AColor = clNone then
    Result := 0
  else
    Result := ARGB(dxColorToRGBQuad(AColor, AAlpha));
end;

function dxGpMakeARGBColor(A, R, G, B: Byte): ARGB;
begin
  Result := DWORD(B) or (DWORD(G) shl 8) or (DWORD(R) shl 16) or (DWORD(A) shl 24);
end;

{ TdxLoader }

constructor TdxUnitsLoader.Create();
begin
  FinalizeList := TList.Create;
  InitializeList := TList.Create;
end;

destructor TdxUnitsLoader.Destroy;
begin
  Finalize;
  FinalizeList.Free;
  InitializeList.Free;
  inherited Destroy;
end;

procedure TdxUnitsLoader.AddUnit(const AInitializeProc, AFinalizeProc: Pointer);
var
  AProc: TdxProc;
begin
  if AInitializeProc <> nil then
  begin
    AProc := AInitializeProc;
    if not IsDLL then
    begin
      FGDIInitialized := True;
      AProc;
    end
    else
      InitializeList.Add(AInitializeProc);
  end;
  if AFinalizeProc <> nil then
    FinalizeList.Add(AFinalizeProc);
end;

procedure TdxUnitsLoader.RemoveUnit(const AFinalizeProc: Pointer);
var
  AProc: TdxProc;
begin
  AProc := AFinalizeProc;
  if (FinalizeList.Remove(AFinalizeProc) >=0) and (AFinalizeProc <> nil) then
    AProc;
end;

procedure TdxUnitsLoader.Finalize;
var
  I: Integer;
  AProc: TdxProc;
begin
  if FGDIInitialized then
    for I := FinalizeList.Count - 1 downto 0 do
    begin
      AProc := TdxProc(FinalizeList[I]);
      if Assigned(AProc) then AProc;
    end;
  FGDIInitialized := False;
  FinalizeList.Clear;
end;

procedure TdxUnitsLoader.Initialize;
var
  I: Integer;
  AProc: TdxProc;
begin
  for I := 0 to InitializeList.Count - 1 do
  begin
    AProc := TdxProc(InitializeList[I]);
    if Assigned(AProc) then AProc;
  end;
  InitializeList.Clear;
  FGDIInitialized := True;
end;

{ GDI+ loading }

procedure GdiPlusLoad;
const
  DefaultStartup: GdiplusStartupInput =
    (GdiplusVersion: 1;
     DebugEventCallback: nil;
     SuppressBackgroundThread: True;
     SuppressExternalCodecs: False);

  function LoadGdiPlusMethod(const ProcName: string): Pointer;
  begin
    Result := nil;
    if FGDIPresent then
      Result := GetProcAddress(FGDIPlusLibrary, PChar(ProcName));
    FGDIPresent := Result <> nil;
  end;

begin
  if FGDIPresent then
    Exit;
  FGDIPlusLibrary := SafeLoadLibrary(GDIPlusLibraryName);
  FGDIPresent := FGDIPlusLibrary <> 0;
  if FGDIPresent then
  begin
    // GDI+ Memory managment methods loading
    GdipAlloc := LoadGdiPlusMethod('GdipAlloc');
    GdipFree := LoadGdiPlusMethod('GdipFree');
    // GDI+ initialization/finalization methods loading
    GdiplusStartup := LoadGdiPlusMethod('GdiplusStartup');
    GdiplusShutdown := LoadGdiPlusMethod('GdiplusShutdown');
    // GDI+ Brush methods loading
    GdipCloneBrush := LoadGdiPlusMethod('GdipCloneBrush');
    GdipDeleteBrush := LoadGdiPlusMethod('GdipDeleteBrush');
    GdipGetBrushType := LoadGdiPlusMethod('GdipGetBrushType');
    // GDI+ Solid Brush methods loading
    GdipCreateSolidFill := LoadGdiPlusMethod('GdipCreateSolidFill');
    GdipSetSolidFillColor := LoadGdiPlusMethod('GdipSetSolidFillColor');
    GdipGetSolidFillColor := LoadGdiPlusMethod('GdipGetSolidFillColor');
    // GDI+ Gradient Brush methods loading
    GdipCreateLineBrushFromRectI := LoadGdiPlusMethod('GdipCreateLineBrushFromRectI');
    GdipGetLineRectI := LoadGdiPlusMethod('GdipGetLineRectI');
    GdipSetLineColors := LoadGdiPlusMethod('GdipSetLineColors');
    GdipGetLineColors := LoadGdiPlusMethod('GdipGetLineColors');
    GdipSetLineWrapMode := LoadGdiPlusMethod('GdipSetLineWrapMode');
    GdipGetLineWrapMode := LoadGdiPlusMethod('GdipGetLineWrapMode');
    // GDI+ Hatch Brush methods loading
    GdipCreateHatchBrush := LoadGdiPlusMethod('GdipCreateHatchBrush');
    GdipGetHatchStyle := LoadGdiPlusMethod('GdipGetHatchStyle');
    GdipGetHatchForegroundColor := LoadGdiPlusMethod('GdipGetHatchForegroundColor');
    GdipGetHatchBackgroundColor := LoadGdiPlusMethod('GdipGetHatchBackgroundColor');
    // GDI+ Pen methods loading
    GdipCreatePen1 := LoadGdiPlusMethod('GdipCreatePen1');
    GdipCreatePen2 := LoadGdiPlusMethod('GdipCreatePen2');
    GdipClonePen := LoadGdiPlusMethod('GdipClonePen');
    GdipDeletePen := LoadGdiPlusMethod('GdipDeletePen');
    GdipGetPenFillType := LoadGdiPlusMethod('GdipGetPenFillType');
    GdipSetPenBrushFill := LoadGdiPlusMethod('GdipSetPenBrushFill');
    GdipGetPenBrushFill := LoadGdiPlusMethod('GdipGetPenBrushFill');
    GdipSetPenColor := LoadGdiPlusMethod('GdipSetPenColor');
    GdipGetPenColor := LoadGdiPlusMethod('GdipGetPenColor');
    GdipSetPenMode := LoadGdiPlusMethod('GdipSetPenMode');
    GdipGetPenMode := LoadGdiPlusMethod('GdipGetPenMode');
    GdipSetPenWidth := LoadGdiPlusMethod('GdipSetPenWidth');
    GdipGetPenWidth := LoadGdiPlusMethod('GdipGetPenWidth');
    GdipGetPenDashStyle := LoadGdiPlusMethod('GdipGetPenDashStyle');
    GdipSetPenDashStyle := LoadGdiPlusMethod('GdipSetPenDashStyle');
    // GDI+ Graphis methods loading
    GdipCreateFromHDC := LoadGdiPlusMethod('GdipCreateFromHDC');
    GdipDeleteGraphics := LoadGdiPlusMethod('GdipDeleteGraphics');
    GdipGetDC := LoadGdiPlusMethod('GdipGetDC');
    GdipReleaseDC := LoadGdiPlusMethod('GdipReleaseDC');
    GdipGraphicsClear := LoadGdiPlusMethod('GdipGraphicsClear');
    GdipDrawLineI := LoadGdiPlusMethod('GdipDrawLineI');
    GdipDrawLinesI := LoadGdiPlusMethod('GdipDrawLinesI');
    GdipFillRectangleI := LoadGdiPlusMethod('GdipFillRectangleI');
    GdipDrawArcI := LoadGdiPlusMethod('GdipDrawArcI');
    GdipDrawBezierI := LoadGdiPlusMethod('GdipDrawBezierI');
    GdipDrawRectangleI := LoadGdiPlusMethod('GdipDrawRectangleI');
    GdipDrawEllipseI := LoadGdiPlusMethod('GdipDrawEllipseI');
    GdipDrawPieI := LoadGdiPlusMethod('GdipDrawPieI');
    GdipDrawPolygonI := LoadGdiPlusMethod('GdipDrawPolygonI');
    GdipDrawCurve2I := LoadGdiPlusMethod('GdipDrawCurve2I');
    GdipDrawClosedCurve2I := LoadGdiPlusMethod('GdipDrawClosedCurve2I');
    GdipFillPolygonI := LoadGdiPlusMethod('GdipFillPolygonI');
    GdipFillEllipseI := LoadGdiPlusMethod('GdipFillEllipseI');
    GdipFillPieI := LoadGdiPlusMethod('GdipFillPieI');
    GdipFillClosedCurveI := LoadGdiPlusMethod('GdipFillClosedCurveI');
    // added from MSN
    GdipLoadImageFromStream := LoadGdiPlusMethod('GdipLoadImageFromStream');
    GdipCreateBitmapFromFile := LoadGdiPlusMethod('GdipCreateBitmapFromFile');
    GdipCreateBitmapFromStream := LoadGdiPlusMethod('GdipCreateBitmapFromStream');
    GdipCreateBitmapFromStreamICM := LoadGdiPlusMethod('GdipCreateBitmapFromStreamICM');
    GdipCreateHBITMAPFromBitmap := LoadGdiPlusMethod('GdipCreateHBITMAPFromBitmap');
    GdipLoadImageFromFile := LoadGdiPlusMethod('GdipLoadImageFromFile');
    GdipGetImageDimension := LoadGdiPlusMethod('GdipGetImageDimension');
    GdipDrawImageRectI := LoadGdiPlusMethod('GdipDrawImageRectI');
    GdipDisposeImage := LoadGdiPlusMethod('GdipDisposeImage');
    GdipGetImageEncodersSize := LoadGdiPlusMethod('GdipGetImageEncodersSize');
    GdipGetImageEncoders := LoadGdiPlusMethod('GdipGetImageEncoders');
    GdipSaveImageToStream := LoadGdiPlusMethod('GdipSaveImageToStream');
    GdipCreateBitmapFromHBITMAP := LoadGdiPlusMethod('GdipCreateBitmapFromHBITMAP');
    GdipIsVisibleRect := LoadGdiPlusMethod('GdipIsVisibleRect');
    GdipIsVisibleRectI := LoadGdiPlusMethod('GdipIsVisibleRectI');
    GdipGetEncoderParameterListSize := LoadGdiPlusMethod('GdipGetEncoderParameterListSize');
    GdipGetEncoderParameterList := LoadGdiPlusMethod('GdipGetEncoderParameterList');
    GdipCreateBitmapFromGdiDib := LoadGdiPlusMethod('GdipCreateBitmapFromGdiDib');
    GdipCreateBitmapFromScan0 := LoadGdiPlusMethod('GdipCreateBitmapFromScan0');
    GdipBitmapLockBits := LoadGdiPlusMethod('GdipBitmapLockBits');
    GdipBitmapUnlockBits := LoadGdiPlusMethod('GdipBitmapUnlockBits');
    GdipDrawImageRectRectI := LoadGdiPlusMethod('GdipDrawImageRectRectI');
    GdipDrawImageRectRect := LoadGdiPlusMethod('GdipDrawImageRectRect');
    GdipDrawImagePointRect := LoadGdiPlusMethod('GdipDrawImagePointRect');
    GdipCloneImage := LoadGdiPlusMethod('GdipCloneImage');
    GdipCreateTexture2I := LoadGdiPlusMethod('GdipCreateTexture2I');

    GdipCreateImageAttributes := LoadGdiPlusMethod('GdipCreateImageAttributes');
    GdipDisposeImageAttributes := LoadGdiPlusMethod('GdipDisposeImageAttributes');
    GdipSetImageAttributesColorMatrix := LoadGdiPlusMethod('GdipSetImageAttributesColorMatrix');

    GdipAddPathArc := LoadGdiPlusMethod('GdipAddPathArc');
    GdipAddPathLine := LoadGdiPlusMethod('GdipAddPathLine');
    GdipClosePathFigure := LoadGdiPlusMethod('GdipClosePathFigure');
    GdipCreatePath := LoadGdiPlusMethod('GdipCreatePath');
    GdipDeletePath := LoadGdiPlusMethod('GdipDeletePath');
    GdipDrawPath := LoadGdiPlusMethod('GdipDrawPath');
    GdipFillPath := LoadGdiPlusMethod('GdipFillPath');
    GdipStartPathFigure := LoadGdiPlusMethod('GdipStartPathFigure');

    //lcm
    GdipSetInterpolationMode := LoadGdiPlusMethod('GdipSetInterpolationMode');
    GdipGetInterpolationMode := LoadGdiPlusMethod('GdipGetInterpolationMode');
    GdipCreateCachedBitmap := LoadGdiPlusMethod('GdipCreateCachedBitmap');
    GdipDeleteCachedBitmap := LoadGdiPlusMethod('GdipDeleteCachedBitmap');
    GdipDrawCachedBitmap := LoadGdiPlusMethod('GdipDrawCachedBitmap');
    GdipCreateBitmapFromGraphics := LoadGdiPlusMethod('GdipCreateBitmapFromGraphics');
    GdipGetImageGraphicsContext := LoadGdiPlusMethod('GdipGetImageGraphicsContext');
    GdipGetImageWidth := LoadGdiPlusMethod('GdipGetImageWidth');
    GdipGetImageHeight := LoadGdiPlusMethod('GdipGetImageHeight');
    GdipSetCompositingMode := LoadGdiPlusMethod('GdipSetCompositingMode');
    GdipGetCompositingMode := LoadGdiPlusMethod('GdipGetCompositingMode');
    GdipSetCompositingQuality := LoadGdiPlusMethod('GdipSetCompositingQuality');
    GdipGetCompositingQuality := LoadGdiPlusMethod('GdipGetCompositingQuality');
    GdipSetSmoothingMode := LoadGdiPlusMethod('GdipSetSmoothingMode');
    GdipGetSmoothingMode := LoadGdiPlusMethod('GdipGetSmoothingMode');
    GdipCloneBitmapAreaI := LoadGdiPlusMethod('GdipCloneBitmapAreaI');
    //
    if (GdiPlusStartup(FGDIPlusToken, DefaultStartup, @FGdiPlusHook) <> OK) or
      (FGdiPlusHook.NotificationHook(FGDIPlusToken) <> Ok) then
    begin
      FGDIPresent := False;
      FillChar(FGdiPlusHook, SizeOf(FGdiPlusHook), 0);
    end;
  end;
end;

function CheckGdiPlus: Boolean;
begin
  if not FGDIPresent then
    GdiPlusLoad;
  Result := FGDIPresent;
end;

function dxUnitsLoader: TdxUnitsLoader;
begin
  if UnitsLoader = nil then
    UnitsLoader := TdxUnitsLoader.Create;
  Result := UnitsLoader;
end;

procedure dxInitializeGDIPlus;
begin
  dxUnitsLoader.Initialize;
end;

procedure dxFinalizeGDIPlus;
begin
  dxUnitsLoader.Finalize;
end;

procedure GdiPlusUnload;
begin
  if FGDIPresent then
  begin
    FGdiPlusHook.NotificationUnhook(FGDIPlusToken);
    GdiPlusShutdown(FGDIPlusToken);
  end;
  if FGDIPlusLibrary <> 0 then
    FreeLibrary(FGDIPlusLibrary);
  FGDIPresent := False;
end;

{ TGdiplusBase }

class function TdxGPBase.NewInstance: TObject;
begin
  Result := InitInstance(GdipAlloc(ULONG(instanceSize)));
end;

procedure TdxGPBase.FreeInstance;
begin
  CleanupInstance;
  GdipFree(Self);
end;

{ TdxGPPoint }

function MakePoint(X, Y: Integer): TdxGPPoint;
begin
  result.X := X;
  result.Y := Y;
end;

function MakePoint(X, Y: Single): TdxGPPointF;
begin
  Result.X := X;
  result.Y := Y;
end;

{ TdxGPSizeF }

function MakeSize(Width, Height: Single): TdxGPSizeF;
begin
  result.Width := Width;
  result.Height := Height;
end;

function MakeSize(Width, Height: Integer): TdxGPSize;
begin
  result.Width := Width;
  result.Height := Height;
end;

{ TdxGPRectF }

function MakeRect(x, y, width, height: Single): TdxGPRectF; overload;
begin
  Result.X      := x;
  Result.Y      := y;
  Result.Width  := width;
  Result.Height := height;
end;

function MakeRect(location: TdxGPPointF; size: TdxGPSizeF): TdxGPRectF; overload;
begin
  Result.X      := location.X;
  Result.Y      := location.Y;
  Result.Width  := size.Width;
  Result.Height := size.Height;
end;

{ TdxGPRect }

function MakeRect(x, y, width, height: Integer): TdxGPRect; overload;
begin
  Result.X      := x;
  Result.Y      := y;
  Result.Width  := width;
  Result.Height := height;
end;

function MakeRect(location: TdxGPPoint; size: TdxGPSize): TdxGPRect; overload;
begin
  Result.X      := location.X;
  Result.Y      := location.Y;
  Result.Width  := size.Width;
  Result.Height := size.Height;
end;

function MakeRect(Rect: TRect): TdxGPRect; overload;
begin
  Result.X      := Rect.Left;
  Result.Y      := Rect.Top;
  Result.Width  := Rect.Right - Rect.Left;
  Result.Height := Rect.Bottom - Rect.Top;
end;

function GetCodecID(const CodecName: string; out Clsid: TGUID): GPStatus;
var
  Count, Size, Index: Integer;
  CodecInfo, StartInfo: PdxGPImageCodecInfo;
begin
  Count := 0;
  Size := 0;
  Result := GenericError;
  if not CheckGdiPlus or (GdipGetImageEncodersSize(Count, Size) <> Ok) or (Size <= 0) then Exit;
  GetMem(StartInfo, Size);
  CodecInfo := StartInfo;
  try
    if GdipGetImageEncoders(Count, Size, CodecInfo) = Ok then
      for Index := 0 to Count - 1 do
      begin
        if SameText(PWideChar(CodecInfo^.MimeType), CodecName) then
        begin
           Clsid := CodecInfo^.Clsid;
           Result := Ok;
           Break;
        end;
        Inc(Integer(CodecInfo), SizeOf(TdxGPImageCodecInfo));
      end;
  finally
    FreeMem(StartInfo, Size);
  end;
end;

procedure CheckPngCodec;
begin
  if (PngCodec.D1 = 0) and (PngCodec.D2 = 0) and (PngCodec.D3 = 0) then
    GetCodecID('image/png', PngCodec);
end;

procedure GdipCheck(AStatus: GPStatus);
begin
  if AStatus <> Ok then
    raise EdxGdipException.Create(AStatus);
end;

procedure GdipCheck(AStatus: Boolean);
begin
  if not AStatus then
    raise EdxGdipException.Create(InvalidParameter);
end;

function DifferentImage2Bitmap(AStream: TStream): TBitmap;
var
  Data: HGlobal;
  DataPtr: Pointer;
  Image: GpImage;
  AccessStream: IStream;
  Handle: HBitmap;
  Header: TBitmapFileHeader;
begin
  Result := TBitmap.Create;
  try
    if AStream.Size > SizeOf(Header) then
    begin
      AStream.ReadBuffer(Header, SizeOf(Header));
      if Header.bfType = $4D42 then
      begin
        AStream.Position := 0;
        Result.LoadFromStream(AStream);
        Result.PixelFormat := pf32Bit;
        Exit;
      end;
    end;
    if not CheckGdiPlus then Exit;
    Data := GlobalAlloc(GMEM_MOVEABLE+GMEM_DDESHARE, AStream.Size);
    try
      DataPtr := GlobalLock(Data);
      try
        AStream.Position := 0;
        AStream.Read(DataPtr^, AStream.Size);
        Image := nil;
        GdipCheck(CreateStreamOnHGlobal(Data, False, AccessStream) = s_OK);
        GdipCheck(GdipCreateBitmapFromStream(AccessStream, Image));
        GdipCheck(GdipCreateHBITMAPFromBitmap(Image, Handle, 0));
        Result.Handle := Handle;
        GdipCheck(GdipDisposeImage(Image));

      finally
        GlobalUnlock(Data);
        AccessStream := nil;
      end;
    finally
      GlobalFree(Data);
    end;
    Result.PixelFormat := pf32Bit;
  except
    Result.Free;
  end;
end;

function DifferentImage2Bitmap(const AFileName: string): TBitmap; overload;
var
  AStream: TStream;
begin
  AStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyNone);
  try
    Result := DifferentImage2Bitmap(AStream);
  finally
    AStream.Free;
  end;
end;

procedure Bitmap2PNG(ABitmap: TBitmap; AStream: TStream);
var
  Image: GpImage;
  Picture: Pointer;
  RowSize, Row: Integer;
const
  PixelFormat32bppPARGB     = $E200B;
begin
  CheckPngCodec;
  Picture := nil;
  try
    if ABitmap.PixelFormat = pf32bit then
    begin
      RowSize := ABitmap.Width * 4;
      GetMem(Picture, RowSize * ABitmap.Height);
      for Row := 0 to ABitmap.Height - 1 do
        Move(ABitmap.ScanLine[Row]^, PByteArray(Picture)^[Row * RowSize], RowSize);
      GdipCheck(GdipCreateBitmapFromScan0(ABitmap.Width,
        ABitmap.Height, ABitmap.Width * 4, PixelFormat32bppPARGB, Picture, Image));
    end
    else
      GdipCheck(GdipCreateBitmapFromHBITMAP(ABitmap.Handle, ABitmap.Palette, Image));
    GdipCheck(GdipSaveImageToStream(Image,
      TStreamAdapter.Create(AStream, soReference), @PngCodec, nil));
    GdipCheck(GdipDisposeImage(Image));
  finally
    FreeMem(Picture);
  end;
end;

procedure Bitmap2PNG(ABitmap: TBitmap; const AFileName: string);
var
  AStream: TStream;
begin
  AStream := TFileStream.Create(AFileName, fmCreate);
  try
    Bitmap2PNG(ABitmap, AStream);
  finally
    AStream.Free;
  end;
end;

{ EdxGdipException }

constructor EdxGdipException.Create(AStatus: GpStatus);
begin
  CreateFmt(scxGdipInvalidOperation, [Ord(AStatus)]);
  FStatus := AStatus;
end;

procedure RegisterAssistants;
begin
  FGDIPresent := False;
end;

procedure UnregisterAssistants;
begin
  GdiPlusUnload;
end;

initialization
  dxUnitsLoader.AddUnit(@RegisterAssistants, @UnregisterAssistants);

finalization
  if FGDIPresent and IsDLL and (UnitsLoader.FinalizeList.Count > 0) then
    raise Exception.Create('Need call dxFinalizeGDIPlus before free library!');
  FreeAndNil(UnitsLoader);

end.

