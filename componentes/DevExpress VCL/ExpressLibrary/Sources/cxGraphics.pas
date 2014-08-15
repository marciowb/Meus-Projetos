{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{           Express Cross Platform Library graphics classes          }
{                                                                    }
{           Copyright (c) 2000-2010 Developer Express Inc.           }
{           ALL RIGHTS RESERVED                                      }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSCROSSPLATFORMLIBRARY AND ALL   }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM       }
{   ONLY.                                                            }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit cxGraphics;

{$I cxVer.inc}

interface

uses
{$IFDEF DELPHI6}
  Types,
{$ENDIF}
  Windows, Classes, SysUtils, Controls, Graphics, Menus, CommCtrl, ComCtrls, ImgList,
  dxCore, cxClasses;

const
  cxAlignLeft            = 1;
  cxAlignRight           = 2;
  cxAlignHCenter         = 4;
  cxAlignTop             = 8;
  cxAlignBottom          = 16;
  cxAlignVCenter         = 32;
  cxAlignCenter          = 36;
  cxSingleLine           = 64;
  cxDontClip             = 128;
  cxExpandTabs           = 256;
  cxShowPrefix           = 512;
  cxWordBreak            = 1024;
  cxShowEndEllipsis      = 2048;
  cxCalcRect             = 4096;
  cxShowPathEllipsis     = 8192;
  cxDontBreakChars       = 16384;
  cxNoFullWidthCharBreak = 32768;
  cxDontPrint            = cxCalcRect;

  SystemAlignmentsHorz: array[TAlignment] of Integer = (DT_LEFT, DT_RIGHT, DT_CENTER);
  SystemAlignmentsVert: array[TcxAlignmentVert] of Integer = (DT_TOP, DT_BOTTOM, DT_VCENTER);
  cxAlignmentsHorz: array[TAlignment] of Integer = (cxAlignLeft, cxAlignRight, cxAlignHCenter);
  cxAlignmentsVert: array[TcxAlignmentVert] of Integer = (cxAlignTop, cxAlignBottom, cxAlignVCenter);

{$IFNDEF DELPHI6}
  clMoneyGreen = TColor($C0DCC0);
  clSkyBlue = TColor($F0CAA6);
  clCream = TColor($F0FBFF);
  clMedGray = TColor($A4A0A0);
{$ENDIF}
  clcxLightGray = $CFCFCF;

  cxEmptyRect: TRect = (Left: 0; Top: 0; Right: 0; Bottom: 0);

  cxDesignSelectionWidth = 2;

  cxDefaultAlphaValue = 200;

  cxHalfToneBrush: TBrush = nil;

  cxDoubleBufferedBitmapPixelFormat: TPixelFormat = pfDevice;

type
  IcxFontListener = interface
    ['{B144DD7E-0B27-439A-B908-FC3ACFE6A2D3}']
    procedure Changed(Sender: TObject; AFont: TFont);
  end;

  TcxBorder = (bLeft, bTop, bRight, bBottom);
  TcxBorders = set of TcxBorder;

const
  cxBordersAll = [bLeft, bTop, bRight, bBottom];

type
  TBrushHandle = HBRUSH;

  TPointArray = array of TPoint;
  TRectArray = array of TRect;

  TcxColorPart = -100..100;

  TcxGridLines = (glBoth, glNone, glVertical, glHorizontal);

  PcxViewParams = ^TcxViewParams;
  TcxViewParams = record
    Bitmap: TBitmap;
    Color: TColor;
    Font: TFont;
    TextColor: TColor;
  end;

  IcxPaintControlsHelper = interface
  ['{7EFAF634-E8D2-489D-9603-FCFC03ACA460}']
    function AllowDrawEdgesAndBorders: Boolean;
  end;

  { IcxImageCollectionListener }

  IcxImageCollectionListener = interface
  ['{FDFF372B-F49E-40C9-9E03-E0D6B110774A}']
    procedure ImageCollectionChanged;
    procedure ImageCollectionDestroyed;
  end;

  { TcxRegion }

  TcxRegionHandle = HRGN;
  TcxRegionOperation = (roSet, roAdd, roSubtract, roIntersect);

  TcxRegion = class  {6}
  private
    FHandle: TcxRegionHandle;
    function GetBoundsRect: TRect;
    function GetIsEmpty: Boolean;
  protected
    procedure DestroyHandle;
  public
    constructor Create(AHandle: TcxRegionHandle); overload;
    constructor Create(const ABounds: TRect); overload;
    constructor Create; overload;
    constructor Create(ALeft, ATop, ARight, ABottom: Integer); overload;
    constructor CreateRoundCorners(const ABounds: TRect; AWidthEllepse, AHeightEllepse: Integer); overload;
    constructor CreateRoundCorners(ALeft, ATop, ARight, ABottom, AWidthEllepse, AHeightEllepse: Integer); overload;
    destructor Destroy; override;

    procedure Combine(ARegion: TcxRegion; AOperation: TcxRegionOperation;
      ADestroyRegion: Boolean = True);
    function IsEqual(ARegion: TcxRegion): Boolean; overload;
    function IsEqual(ARegionHandle: TcxRegionHandle): Boolean; overload;
    procedure Offset(const P: TPoint); overload;
    procedure Offset(DX, DY: Integer); overload;
    function PtInRegion(const Pt: TPoint): Boolean; overload;
    function PtInRegion(X, Y: Integer): Boolean; overload;
    function RectInRegion(const R: TRect): Boolean; overload;
    function RectInRegion(ALeft, ATop, ARight, ABottom: Integer): Boolean; overload;

    property BoundsRect: TRect read GetBoundsRect;
    property Handle: TcxRegionHandle read FHandle write FHandle;
    property IsEmpty: Boolean read GetIsEmpty;
  end;

  { TcxCanvas }     

  TcxRotationAngle = (ra0, raPlus90, raMinus90, ra180);
  TcxCanvasState = record
    Font: TFont;
    Brush: TBrush;
    Pen: TPen;
  end;
  TcxCanvasStates = array of TcxCanvasState;

  TcxDCState = record
    Handle: THandle;
    State: Integer;
  end;
  TcxDCStates = array of TcxDCState;

  TcxCanvas = class
  private
    FCanvas: TCanvas;
    FSavedDCs: TcxDCStates;
    FSavedRegions: TList;
    FSavedStates: TcxCanvasStates;

    function GetBrush: TBrush;
    function GetCopyMode: TCopyMode;
    function GetDCOrigin: TPoint;
    function GetFont: TFont;
    function GetHandle: HDC;
    function GetPen: TPen;
    function GetViewportOrg: TPoint;
    function GetWindowOrg: TPoint;
    procedure SetBrush(Value: TBrush);
    procedure SetCopyMode(Value: TCopyMode);
    procedure SetFont(Value: TFont);
    procedure SetPen(Value: TPen);
    procedure SetPixel(X, Y: Integer; Value: TColor);
    procedure SetViewportOrg(const P: TPoint);
    procedure SetWindowOrg(const P: TPoint);
  protected
    procedure SynchronizeObjects(ADC: THandle);
  public
    constructor Create(ACanvas: TCanvas); virtual;
    destructor Destroy; override;

    procedure AlignMultiLineTextRectVertically(var R: TRect; const AText: string;
      AAlignmentVert: TcxAlignmentVert; AWordBreak, AShowPrefix: Boolean;
      AEnabled: Boolean = True; ADontBreakChars: Boolean = False; AEndEllipsis: Boolean = False);
    procedure CopyRect(const Dest: TRect; ACanvas: TCanvas; const Source: TRect);
    procedure Draw(X, Y: Integer; Graphic: TGraphic);
    procedure DrawComplexFrame(const R: TRect; ALeftTopColor, ARightBottomColor: TColor;
      ABorders: TcxBorders = [bLeft, bTop, bRight, bBottom]; ABorderWidth: Integer = 1);
    procedure DrawEdge(const R: TRect; ASunken, AOuter: Boolean;
      ABorders: TcxBorders = [bLeft, bTop, bRight, bBottom]);
    procedure DrawFocusRect(const R: TRect);
    procedure DrawGlyph(X, Y: Integer; AGlyph: TBitmap; AEnabled: Boolean = True;
      ABackgroundColor: TColor = clNone{; ATempCanvas: TCanvas = nil});
    procedure DrawImage(Images: TCustomImageList; X, Y, Index: Integer;
      Enabled: Boolean = True);
    procedure DrawTexT(const Text: string; R: TRect; Flags: Integer;
      Enabled: Boolean = True); overload;
    procedure DrawTexT(const Text: string; R: TRect; Flags: Integer;
      Enabled: Boolean; ARotationAngle: TcxRotationAngle); overload;
    procedure DrawTexT(const Text: string; R: TRect; AAlignmentHorz: TAlignment;
      AAlignmentVert: TcxAlignmentVert; AMultiLine, AShowEndEllipsis: Boolean); overload;
    procedure FillRect(const R: TRect; AColor: TColor); overload;
    procedure FillRect(const R: TRect; ABitmap: TBitmap = nil;
      AExcludeRect: Boolean = False); overload;
    procedure FillRect(R: TRect; const AParams: TcxViewParams;
      ABorders: TcxBorders = []; ABorderColor: TColor = clDefault;
      ALineWidth: Integer = 1; AExcludeRect: Boolean = False); overload;
    procedure DrawDesignSelection(ARect: TRect; AWidth: Integer = cxDesignSelectionWidth);
    procedure DrawRegion(ARegion: TcxRegion; AContentColor: TColor = clDefault;
      ABorderColor: TColor = clDefault; ABorderWidth: Integer = 1; ABorderHeight: Integer = 1); overload;
    procedure DrawRegion(ARegion: TcxRegionHandle; AContentColor: TColor = clDefault;
      ABorderColor: TColor = clDefault; ABorderWidth: Integer = 1; ABorderHeight: Integer = 1); overload;
    procedure FillRegion(ARegion: TcxRegion; AColor: TColor = clDefault); overload;
    procedure FillRegion(ARegion: TcxRegionHandle; AColor: TColor = clDefault); overload;
    procedure FlipHorizontally(ABitmap: TBitmap);
    procedure FrameRegion(ARegion: TcxRegion; AColor: TColor = clDefault;
      ABorderWidth: Integer = 1; ABorderHeight: Integer = 1); overload;
    procedure FrameRegion(ARegion: TcxRegionHandle; AColor: TColor = clDefault;
      ABorderWidth: Integer = 1; ABorderHeight: Integer = 1); overload;
    procedure Pie(const R: TRect; const ARadial1, ARadial2: TPoint); overload;
    procedure Pie(const R: TRect; AStartAngle, ASweepAngle: Integer); overload;
    function FontHeight(AFont: TFont): Integer;
    procedure FrameRect(const R: TRect; Color: TColor = clDefault;
      ALineWidth: Integer = 1; ABorders: TcxBorders = cxBordersAll;
      AExcludeFrame: Boolean = False);
    procedure ExcludeFrameRect(const R: TRect; ALineWidth: Integer = 1;
      ABorders: TcxBorders = cxBordersAll);
    procedure InvertFrame(const R: TRect; ABorderSize: Integer);
    procedure InvertRect(const R: TRect);
    procedure LineTo(X, Y: Integer);
    procedure MoveTo(X, Y: Integer);
    procedure Polygon(const Points: array of TPoint);
    procedure Polyline(const Points: array of TPoint);
    procedure RotateBitmap(ABitmap: TBitmap; ARotationAngle: TcxRotationAngle;
      AFlipVertically: Boolean = False);
    function TextExtent(const Text: string): TSize; overload;
    procedure TextExtent(const Text: string; var R: TRect; Flags: Integer); overload;
    function TextHeight(const Text: string): Integer;
    function TextWidth(const Text: string): Integer;
    procedure TransparentDraw(X, Y: Integer; ABitmap: TBitmap; AAlpha: Byte;
      ABackground: TBitmap = nil);

    procedure RestoreDC;
    procedure SaveDC;
    procedure RestoreClipRegion;
    procedure SaveClipRegion;
    procedure RestoreState;
    procedure SaveState;

    procedure GetParams(var AParams: TcxViewParams);
    procedure SetParams(AParams: TcxViewParams);
    procedure SetBrushColor(Value: TColor);
    procedure SetFontAngle(Value: Integer);

    procedure GetTextStringsBounds(Text: string; R: TRect; Flags: Integer;
      Enabled: Boolean; var ABounds: TRectArray);

    procedure BeginPath;
    procedure EndPath;
    function PathToRegion(AConsiderOrigin: Boolean = True): TcxRegion;
    procedure WidenPath;

    // clipping
    procedure ExcludeClipRect(const R: TRect);
    procedure IntersectClipRect(const R: TRect);
    function GetClipRegion(AConsiderOrigin: Boolean = True): TcxRegion;
    procedure SetClipRegion(ARegion: TcxRegion; AOperation: TcxRegionOperation;
      ADestroyRegion: Boolean = True; AConsiderOrigin: Boolean = True);
    function RectFullyVisible(const R: TRect): Boolean;
    function RectVisible(const R: TRect): Boolean;

    property Brush: TBrush read GetBrush write SetBrush;
    property Canvas: TCanvas read FCanvas write FCanvas;
    property CopyMode: TCopyMode read GetCopyMode write SetCopyMode;
    property DCOrigin: TPoint read GetDCOrigin;
    property Font: TFont read GetFont write SetFont;
    property Handle: HDC read GetHandle;
    property Pen: TPen read GetPen write SetPen;
    property Pixels[X, Y: Integer]: TColor write SetPixel;
    property ViewportOrg: TPoint read GetViewportOrg write SetViewportOrg;
    property WindowOrg: TPoint read GetWindowOrg write SetWindowOrg;
  end;

  { TcxScreenCanvas }

  TcxScreenCanvas = class(TcxCanvas)
  public
    constructor Create; reintroduce; virtual;
    destructor Destroy; override;
    procedure Dormant;
  end;

  { TcxPaintCanvas }

  TcxPaintCanvasState = record
    PrevCanvas: TCanvas;
    PrevDC: THandle;
    NewDC: THandle;
    NewDCIndex: Integer;
  end;
  TcxPaintCanvasStates = array of TcxPaintCanvasState;

  TcxPaintCanvas = class(TcxCanvas)
  private
    FCounter: Integer;
    FSavedDCs: TcxPaintCanvasStates;
    function HandleValid: Boolean;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    procedure BeginPaint(ADC: THandle); overload;
    procedure BeginPaint(ACanvas: TCanvas); overload;
    procedure EndPaint;
  end;

  { TcxBitmap }

  TcxBitmap = class(TBitmap)
  private
    FCompressData: Boolean;
    FcxCanvas: TcxCanvas;
    FLockCount: Integer;
    FModified: Boolean;

    function GetClientRect: TRect;

    procedure CompressByBlock(ASourceStream, ADestStream: TStream; ASize, ABlockSize: Integer);
    procedure DecompressByBlock(ASourceStream, ADestStream: TStream; ASize, ABlockSize: Integer);

    procedure Compress(ASourceStream, ADestStream: TStream; ASize: Integer);
    procedure Decompress1(ASourceStream, ADestStream: TStream; ASize: Integer);
    procedure Decompress2(ASourceStream, ADestStream: TStream; ASize: Integer);
  protected
    procedure Changed(Sender: TObject); override;
    function ChangeLocked: Boolean;
    procedure Initialize(AWidth, AHeight: Integer; APixelFormat: TPixelFormat); virtual;
    procedure Update; virtual;

    procedure ReadData(Stream: TStream); override;
    procedure WriteData(Stream: TStream); override;
  public
    constructor Create; overload; override;
    constructor CreateSize(const ARect: TRect); overload;
    constructor CreateSize(AWidth, AHeight: Integer); overload; virtual;
    constructor CreateSize(const ARect: TRect; APixelFormat: TPixelFormat); overload;
    constructor CreateSize(AWidth, AHeight: Integer; APixelFormat: TPixelFormat); overload;
    destructor Destroy; override;

    procedure BeginUpdate;
    procedure CancelUpdate;
    procedure EndUpdate(AForceUpdate: Boolean = True);

    procedure CopyBitmap(ABitmap: TBitmap; ACopyMode: DWORD = SRCCOPY); overload;
    procedure CopyBitmap(ABitmap: TBitmap; const ADestRect: TRect; const ASrcTopLeft: TPoint; ACopyMode: DWORD = SRCCOPY); overload;
    procedure Rotate(ARotationAngle: TcxRotationAngle; AFlipVertically: Boolean = False);
    procedure SetSize(AWidth, AHeight: Integer); overload; {$IFDEF DELPHI10}override;{$ELSE}virtual;{$ENDIF}
    procedure SetSize(const ARect: TRect); {$IFDEF DELPHI10}reintroduce;{$ENDIF} overload;

    property CompressData: Boolean read FCompressData write FCompressData;
    property ClientRect: TRect read GetClientRect;
    property cxCanvas: TcxCanvas read FcxCanvas;
  end;

  { TcxBitmap }

  TcxImageDrawMode = (idmNormal, idmDisabled, idmFaded, idmGrayScale, idmDingy, idmShadowed);
  TcxBitmapTransformationMode = (btmDingy, btmDirty, btmGrayScale, btmSetOpaque, btmMakeMask, btmFade, btmDisable, btmCorrectBlend, btmHatch, btmClear, btmResetAlpha);
  TcxBitmapTransformationProc = procedure(var AColor: TRGBQuad) of object;
  TcxDrawImageProc = function (ACanvas: TCanvas; AImages: TCustomImageList; AImageIndex: Integer; AGlyph: TBitmap; ARect: TRect; ADrawMode: TcxImageDrawMode): Boolean;

  TcxColorTransitionMap = record
    RedScale: Single;
    GreenScale: Single;
    BlueScale: Single;
    SrcAlpha: Byte;
    SrcConstantAlpha: Byte;
  end;

  TcxHatchData = record
    Color1: TRGBQuad;
    Alpha1: Byte;
    Color2: TRGBQuad;
    Alpha2: Byte;
    Step: Byte;
  end;

  TcxBitmap32 = class(TcxBitmap)
  private
    function GetIsAlphaUsed: Boolean;
  protected
    procedure Update; override;
  public
    constructor CreateSize(AWidth, AHeight: Integer; AClear: Boolean); overload;
    constructor CreateSize(const ARect: TRect; AClear: Boolean); overload;
    constructor CreateSize(AWidth, AHeight: Integer); overload; override;

    procedure GetBitmapColors(out AColors: TRGBColors);
    procedure SetBitmapColors(const AColors: TRGBColors);

    procedure AlphaBlend(ABitmap: TcxBitmap32; const ARect: TRect; ASmoothImage: Boolean; AConstantAlpha: Byte = $FF);
    procedure Clear; virtual;
    procedure Filter(AMaskBitmap: TcxBitmap32);
    procedure Invert;
    procedure Lighten(APercent: Byte);
    procedure LoadFromStream(Stream: TStream); override;
    procedure MakeOpaque;
    procedure RecoverTransparency(ATransparentColor: TColor);
    procedure SetAlphaChannel(Alpha: Byte);

    property IsAlphaUsed: Boolean read GetIsAlphaUsed;
  end;

  TcxColorList = class(TList)
  public
    function Add(AColor: TColor): Integer;
  end;

  TcxAlphaBitmap = class(TcxBitmap32)
  private
    FTransparentBkColor: TRGBQuad;
    FTransparentPixels: TcxColorList;

    FCurrentColorIndex: TPoint;
    FHatchData: TcxHatchData;

    procedure CorrectBlend(var AColor: TRGBQuad);
    procedure ClearColor(var AColor: TRGBQuad);
    procedure Dingy(var AColor: TRGBQuad);
    procedure Dirty(var AColor: TRGBQuad);
    procedure Disable(var AColor: TRGBQuad);
    procedure Fade(var AColor: TRGBQuad);
    procedure GrayScale(var AColor: TRGBQuad);
    procedure Hatch(var AColor: TRGBQuad);
    procedure MakeMask(var AColor: TRGBQuad);
    procedure SetOpaque(var AColor: TRGBQuad);
    procedure ResetAlpha(var AColor: TRGBQuad);

    procedure Scale(var AColor: TRGBQuad; const AColorMap: TcxColorTransitionMap);

    function IsColorTransparent(const AColor: TRGBQuad): Boolean;
  protected
    procedure Initialize(AWidth, AHeight: Integer; APixelFormat: TPixelFormat); override;

    property HatchData: TcxHatchData read FHatchData write FHatchData;
    property TransparentBkColor: TRGBQuad read FTransparentBkColor write FTransparentBkColor;
    property TransparentPixels: TcxColorList read FTransparentPixels;
  public
    constructor CreateSize(AWidth, AHeight: Integer); overload; override;
    constructor CreateSize(AWidth, AHeight: Integer; ATransparentBkColor: TRGBQuad); overload;
    destructor Destroy; override;

    procedure Clear; override;
    procedure DrawHatch(const AHatchData: TcxHatchData); overload;
    procedure DrawHatch(AColor1, AColor2: TColor; AStep: Byte; AAlpha1: Byte = $FF; AAlpha2: Byte = $FF); overload;
    procedure DrawShadow(AMaskBitmap: TcxAlphaBitmap; AShadowSize: Integer; AShadowColor: TColor; AInflateSize: Boolean = False);
    procedure RecoverAlphaChannel(ATransparentColor: TColor); 
    procedure Shade(AMaskBitmap: TcxAlphaBitmap);
    procedure TransformBitmap(AMode: TcxBitmapTransformationMode);

    procedure RefreshImage(AWidth, AHeight: Integer); overload;
    procedure RefreshImage(const ARect: TRect); overload;
  end;

  TcxImageInfo = class(TPersistent)
  private
    FImage: TBitmap;
    FMask: TBitmap;
    FMaskColor: TColor;
    procedure AssignBitmap(ASourceBitmap, ADestBitmap: TBitmap);
  protected
    procedure SetImage(Value: TBitmap); virtual;
    procedure SetMask(Value: TBitmap); virtual;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    property Image: TBitmap read FImage write SetImage;
    property Mask: TBitmap read FMask write SetMask;
    property MaskColor: TColor read FMaskColor write FMaskColor;
  end;

  TcxImageList = class(TDragImageList)
  private
    FAlphaBlending: Boolean;
    FFormatVersion: Integer;
    FImages: TCollection;
    FLockCount: Integer;
    FSynchronization: Boolean;

    function GetCompressData: Boolean;
    procedure SetCompressData(Value: Boolean);

    function GetHandle: HImageList;
    procedure SetHandle(Value: HImageList);

    procedure ReadFormatVersion(AReader: TReader);
    procedure WriteFormatVersion(AWriter: TWriter);
    procedure ReadImageInfo(AReader: TReader);
    procedure WriteImageInfo(AWriter: TWriter);
    procedure ReadDesignInfo(AReader: TReader);
    procedure WriteDesignInfo(AWriter: TWriter);
    function NeedSynchronizeImageInfo: Boolean;
    procedure SynchronizeImageInfo;
    procedure SynchronizeHanle;

    procedure AddToInternalCollection(AImage, AMask: TBitmap; AMaskColor: TColor = clNone);
    procedure DormantImage(AIndex: Integer);
    function GetImageHandle(AImage: TBitmap): Integer;
  protected
    function ChangeLocked: Boolean;
    procedure Change; override;
    procedure DoDraw(Index: Integer; Canvas: TCanvas; X, Y: Integer;
      Style: Cardinal; Enabled: Boolean = True); override;
    procedure DoDrawEx(AIndex: Integer; ACanvas: TCanvas;
      const ARect: TRect; AStyle: Cardinal; AStretch, ASmoothResize, AEnabled: Boolean);

    procedure Initialize; override;
    procedure Finalize;
    procedure DefineProperties(Filer: TFiler); override;
    procedure Dormant;

    // for cxImageListEditor
    procedure AddImageInfo(AImageInfo: TcxImageInfo);
    procedure InternalCopyImageInfos(AImageList: TcxImageList; AStartIndex, AEndIndex: Integer);
    procedure InternalCopyImages(AImageList: TCustomImageList; AStartIndex, AEndIndex: Integer);
    procedure GetImageInfo(AIndex: Integer; AImageInfo: TcxImageInfo); overload;
  public
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    // BaseFunctions
    function Add(AImage, AMask: TBitmap): Integer;
    function AddIcon(AIcon: TIcon): Integer;
    function AddMasked(AImage: TBitmap; AMaskColor: TColor): Integer;
    procedure Move(ACurIndex, ANewIndex: Integer);
    procedure Delete(AIndex: Integer);

    // SubsidiaryFunctions
    function AddImage(AValue: TCustomImageList; AIndex: Integer): Integer;
    procedure AddImages(AImageList: TCustomImageList);
    procedure CopyImages(AImageList: TCustomImageList; AStartIndex: Integer = 0; AEndIndex: Integer = -1);
    procedure Clear;
    procedure Insert(AIndex: Integer; AImage, AMask: TBitmap);
    procedure InsertIcon(AIndex: Integer; AIcon: TIcon);
    procedure InsertMasked(AIndex: Integer; AImage: TBitmap; AMaskColor: TColor);
    procedure Replace(AIndex: Integer; AImage, AMask: TBitmap);
    procedure ReplaceIcon(AIndex: Integer; AIcon: TIcon);
    procedure ReplaceMasked(AIndex: Integer; AImage: TBitmap; AMaskColor: TColor);

    function LoadImage(AInstance: THandle; const AResourceName: string;
      AMaskColor: TColor = clDefault; AWidth: Integer = 0; AFlags: TLoadResources = []): Boolean;
    function FileLoad(AResType: TResType; const AName: string; AMaskColor: TColor): Boolean;
    function GetResource(AResType: TResType; const AName: string;
      AWidth: Integer; ALoadFlags: TLoadResources; AMaskColor: TColor): Boolean;
    function GetInstRes(AInstance: THandle; AResType: TResType; const AName: string;
      AWidth: Integer; ALoadFlags: TLoadResources; AMaskColor: TColor): Boolean; overload;
    function GetInstRes(AInstance: THandle; AResType: TResType; AResID: DWORD;
      AWidth: Integer; ALoadFlags: TLoadResources; AMaskColor: TColor): Boolean; overload;
    function ResourceLoad(AResType: TResType; const AName: string;
      AMaskColor: TColor): Boolean;
    function ResInstLoad(AInstance: THandle; AResType: TResType;
      const AName: string; AMaskColor: TColor): Boolean;

    procedure BeginUpdate;
    procedure EndUpdate(AForceUpdate: Boolean = True);

  {$IFNDEF DELPHI6}
    procedure Draw(ACanvas: TCanvas; X, Y, AIndex: Integer;
      ADrawingStyle: TDrawingStyle; AImageType: TImageType;
      AEnabled: Boolean = True); overload;
  {$ENDIF}
    procedure Draw(ACanvas: TCanvas; const ARect: TRect; AIndex: Integer;
      AStretch: Boolean = True; ASmoothResize: Boolean = False; AEnabled: Boolean = True); overload;

    procedure GetImageInfo(AIndex: Integer; AImage, AMask: TBitmap); overload;
    procedure GetImage(AIndex: Integer; AImage: TBitmap);
    procedure GetMask(AIndex: Integer; AMask: TBitmap);

    class procedure GetImageInfo(AImages: TCustomImageList; AIndex: Integer; AImage, AMask: TBitmap); overload;
    class procedure GetImageInfo(AHandle: HIMAGELIST; AIndex: Integer; AImage, AMask: TBitmap); overload;
    class function GetPixelFormat(AHandle: HIMAGELIST): Integer;

    property AlphaBlending: Boolean read FAlphaBlending write FAlphaBlending;
    property Handle: HImageList read GetHandle write SetHandle;
  published
    property BlendColor;
    property BkColor;
    property CompressData: Boolean read GetCompressData write SetCompressData default False;
    property DrawingStyle;
    property Height;
    property ImageType;
    property ShareImages;
    property Width;
    property OnChange;
  end;

  { TcxImageCollectionItem }

  TcxImageCollection = class;

  TcxImageCollectionItem = class(TcxComponentCollectionItem)
  private
    FPicture: TPicture;
    FTag: TcxTag;
    function GetClientRect: TRect;
    function GetHeight: Integer;
    function GetWidth: Integer;
    procedure SetPicture(AValue: TPicture);
  protected
    function GetDisplayName: string; override;
    function GetCollectionFromParent(AParent: TComponent): TcxComponentCollection; override;
    procedure DoPictureChanged(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Draw(ACanvas: TCanvas; X, Y: Integer); overload;
    procedure Draw(ACanvas: TCanvas; const R: TRect; AStretch: Boolean = True;
      ASmoothResize: Boolean = False; AEnabled: Boolean = True); overload;
    //
    property ClientRect: TRect read GetClientRect;
    property Height: Integer read GetHeight;
    property Width: Integer read GetWidth;
  published
    property Picture: TPicture read FPicture write SetPicture;
    property Tag: TcxTag read FTag write FTag default 0;
  end;

  { TcxImageCollectionItems }

  TcxImageCollectionItems = class(TcxComponentCollection)
  private
    FCollection: TcxImageCollection;
    function GetItem(Index: Integer): TcxImageCollectionItem;
    procedure SetItem(Index: Integer; AValue: TcxImageCollectionItem);
  protected
    procedure Notify(AItem: TcxComponentCollectionItem;
      AAction: TcxComponentCollectionNotification); override;
    procedure SetItemName(AItem: TcxComponentCollectionItem); override;
  public
    constructor Create(ACollection: TcxImageCollection); reintroduce;
    function Add: TcxImageCollectionItem;
    function FindItemByName(const AName: string; out AItem: TcxImageCollectionItem): Boolean;
    function FindItemByID(ID: Integer): TcxImageCollectionItem;
    function Insert(Index: Integer): TcxImageCollectionItem;
    //
    property Items[Index: Integer]: TcxImageCollectionItem read GetItem write SetItem; default;
  end;

  { TcxImageCollection }

  TcxImageCollection = class(TComponent)
  private
    FItems: TcxImageCollectionItems;
    FListeners: TInterfaceList;
    function GetCount: Integer;
    procedure SetItems(AItems: TcxImageCollectionItems);
  protected
    // override
  {$IFNDEF DELPHI12}
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
  {$ENDIF}
    procedure Changed;
    procedure DoDestroyed;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  {$IFDEF DELPHI12}
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
  {$ENDIF}
    procedure Draw(ACanvas: TCanvas; X, Y, AIndex: Integer); overload;
    procedure Draw(ACanvas: TCanvas; const R: TRect; AIndex: Integer;
      AStretch: Boolean = True; ASmoothResize: Boolean = False;
      AEnabled: Boolean = True); overload;
    //
    procedure AddListener(AListener: IcxImageCollectionListener);
    procedure RemoveListener(AListener: IcxImageCollectionListener);
    //
    property Count: Integer read GetCount;
  published
    property Items: TcxImageCollectionItems read FItems write SetItems;
  end;

  { TcxBrushCache }

  TcxBrushData = record
    Brush: TBrush;
    Color: TColor;
    RefCount: Integer;
  end;

  TcxBrushesData = array of TcxBrushData;

  EBrushCache = class(EdxException);

  TcxBrushCache = class
  private
    FCapacity: Integer;
    FCount: Integer;
    FData: TcxBrushesData;
    FDeletedCount: Integer;
    FLockRef: Integer;
  protected
    function Add(AColor: TColor): TBrush;
    function AddItemAt(AIndex: Integer; AColor: TColor): TBrush;
    procedure CacheCheck(Value: Boolean; const AMessage: string);
    procedure Delete(AIndex: Integer);
    function IndexOf(AColor: TColor; out AIndex: Integer): Boolean;
    procedure InitItem(var AItem: TcxBrushData; AColor: TColor);
    function IsSystemBrush(ABrush: TBrush): Boolean;
    function FindNearestItem(AColor: TColor): Integer;
    procedure Move(ASrc, ADst, ACount: Integer);
    procedure Pack;
    procedure Recreate;
    procedure Release(AIndex: Integer);
  public
    destructor Destroy; override;
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure ReleaseBrush(var ABrush: TBrush);
    procedure SetBrushColor(var ABrush: TBrush; AColor: TColor);
  end;

const
  DisableMap: TcxColorTransitionMap = (RedScale: 0.0729; GreenScale: 0.7146; BlueScale: 0.2125; SrcAlpha: 105; SrcConstantAlpha: 151);
  FadeMap: TcxColorTransitionMap = (RedScale: 0.299; GreenScale: 0.587; BlueScale: 0.114; SrcAlpha: 192; SrcConstantAlpha: 64);
  GrayMap: TcxColorTransitionMap = (RedScale: 0.299; GreenScale: 0.587; BlueScale: 0.114; SrcAlpha: $FF; SrcConstantAlpha: $FF);

  EnabledImageDrawModeMap: array [Boolean] of TcxImageDrawMode = (idmDisabled, idmNormal);

type
  TcxColorInfo = record
    Name: string;
    Color: TColor;
  end;

const
  cxColorsByName: array[0..168] of TcxColorInfo = (
    (Name: 'aliceblue';            Color: $00FFF8F0),
    (Name: 'antiquewhite';         Color: $00D7EBFA),
    (Name: 'aqua';                 Color: clAqua),
    (Name: 'aquamarine';           Color: $007FD4FF),
    (Name: 'azure';                Color: $00FFFFF0),
    (Name: 'beige';                Color: $00DCF5F5),
    (Name: 'bisque';               Color: $00C4E4FF),
    (Name: 'black';                Color: clBlack),
    (Name: 'blanchedalmond';       Color: $00CDFFFF),
    (Name: 'blue';                 Color: clBlue),
    (Name: 'blueviolet';           Color: $00E22B8A),
    (Name: 'brown';                Color: $002A2AA5),
    (Name: 'burlywood';            Color: $0087B8DE),
    (Name: 'cadetblue';            Color: $00A09E5F),
    (Name: 'chartreuse';           Color: $0000FF7F),
    (Name: 'chocolate';            Color: $001E69D2),
    (Name: 'coral';                Color: $00507FFF),
    (Name: 'cornflowerblue';       Color: $00ED9564),
    (Name: 'cornsilk';             Color: $00DCF8FF),
    (Name: 'crimson';              Color: $003C14DC),
    (Name: 'cyan';                 Color: $00FFFF00),
    (Name: 'darkblue';             Color: $008B0000),
    (Name: 'darkcyan';             Color: $008B8B00),
    (Name: 'darkgoldenrod';        Color: $000B86B8),
    (Name: 'darkgray';             Color: $00A9A9A9),
    (Name: 'darkgreen';            Color: $00006400),
    (Name: 'darkkhaki';            Color: $006BB7BD),
    (Name: 'darkmagenta';          Color: $008B008B),
    (Name: 'darkolivegreen';       Color: $002F6B55),
    (Name: 'darkorange';           Color: $00008CFF),
    (Name: 'darkorchid';           Color: $00CC3299),
    (Name: 'darkred';              Color: $0000008B),
    (Name: 'darksalmon';           Color: $007A96E9),
    (Name: 'darkseagreen';         Color: $008FBC8F),
    (Name: 'darkslateblue';        Color: $008B3D48),
    (Name: 'darkslategray';        Color: $004F4F2F),
    (Name: 'darkturquoise';        Color: $00D1CE00),
    (Name: 'darkviolet';           Color: $00D30094),
    (Name: 'deeppink';             Color: $009314FF),
    (Name: 'deepskyblue';          Color: $00FFBF00),
    (Name: 'dimgray';              Color: $00696969),
    (Name: 'dodgerblue';           Color: $00FF901E),
    (Name: 'firebrick';            Color: $002222B2),
    (Name: 'floralwhite';          Color: $00F0FAFF),
    (Name: 'forestgreen';          Color: $00228B22),
    (Name: 'fuchsia';              Color: $00FF00FF),
    (Name: 'gainsboro';            Color: $00DCDCDC),
    (Name: 'ghostwhite';           Color: $00FFF8F8),
    (Name: 'gold';                 Color: $0000D7FF),
    (Name: 'goldenrod';            Color: $0020A5DA),
    (Name: 'gray';                 Color: clGray),
    (Name: 'green';                Color: clGreen),
    (Name: 'greenyellow';          Color: $002FFFAD),
    (Name: 'honeydew';             Color: $00F0FFF0),
    (Name: 'hotpink';              Color: $00B469FF),
    (Name: 'indianred';            Color: $005C5CCD),
    (Name: 'indigo';               Color: $0082004B),
    (Name: 'ivory';                Color: $00F0F0FF),
    (Name: 'khaki';                Color: $008CE6F0),
    (Name: 'lavender';             Color: $00FAE6E6),
    (Name: 'lavenderblush';        Color: $00F5F0FF),
    (Name: 'lawngreen';            Color: $0000FC7C),
    (Name: 'lemonchiffon';         Color: $00CDFAFF),
    (Name: 'lightblue';            Color: $00E6D8AD),
    (Name: 'lightcoral';           Color: $008080F0),
    (Name: 'lightcyan';            Color: $00FFFFE0),
    (Name: 'lightgoldenrodyellow'; Color: $00D2FAFA),
    (Name: 'lightgreen';           Color: $0090EE90),
    (Name: 'lightgrey';            Color: $00D3D3D3),
    (Name: 'lightpink';            Color: $00C1B6FF),
    (Name: 'lightsalmon';          Color: $007AA0FF),
    (Name: 'lightseagreen';        Color: $00AAB220),
    (Name: 'lightskyblue';         Color: $00FACE87),
    (Name: 'lightslategray';       Color: $00998877),
    (Name: 'lightsteelblue';       Color: $00DEC4B0),
    (Name: 'lightyellow';          Color: $00E0FFFF),
    (Name: 'lime';                 Color: clLime),
    (Name: 'limegreen';            Color: $0032CD32),
    (Name: 'linen';                Color: $00E6F0FA),
    (Name: 'magenta';              Color: $00FF00FF),
    (Name: 'maroon';               Color: clMaroon),
    (Name: 'mediumaquamarine';     Color: $00AACD66),
    (Name: 'mediumblue';           Color: $00CD0000),
    (Name: 'mediumorchid';         Color: $00D355BA),
    (Name: 'mediumpurple';         Color: $00DB7093),
    (Name: 'mediumseagreen';       Color: $0071B33C),
    (Name: 'mediumpurple';         Color: $00DB7093),
    (Name: 'mediumslateblue';      Color: $00EE687B),
    (Name: 'mediumspringgreen';    Color: $009AFA00),
    (Name: 'mediumturquoise';      Color: $00CCD148),
    (Name: 'mediumvioletred';      Color: $008515C7),
    (Name: 'midnightblue';         Color: $00701919),
    (Name: 'mintcream';            Color: $00FAFFF5),
    (Name: 'mistyrose';            Color: $00E1E4FF),
    (Name: 'moccasin';             Color: $00B5E4FF),
    (Name: 'navajowhite';          Color: $00ADDEFF),
    (Name: 'navy';                 Color: clNavy),
    (Name: 'oldlace';              Color: $00E6F5FD),
    (Name: 'olive';                Color: $00008080),
    (Name: 'olivedrab';            Color: $00238E6B),
    (Name: 'orange';               Color: $0000A5FF),
    (Name: 'orangered';            Color: $000045FF),
    (Name: 'orchid';               Color: $00D670DA),
    (Name: 'palegoldenrod';        Color: $00AAE8EE),
    (Name: 'palegreen';            Color: $0098FB98),
    (Name: 'paleturquoise';        Color: $00EEEEAF),
    (Name: 'palevioletred';        Color: $009370DB),
    (Name: 'papayawhip';           Color: $00D5EFFF),
    (Name: 'peachpuff';            Color: $00BDDBFF),
    (Name: 'peru';                 Color: $003F85CD),
    (Name: 'pink';                 Color: $00CBC0FF),
    (Name: 'plum';                 Color: $00DDA0DD),
    (Name: 'powderblue';           Color: $00E6E0B0),
    (Name: 'purple';               Color: $00800080),
    (Name: 'red';                  Color: clRed),
    (Name: 'rosybrown';            Color: $008F8FBC),
    (Name: 'royalblue';            Color: $00E16941),
    (Name: 'saddlebrown';          Color: $0013458B),
    (Name: 'salmon';               Color: $007280FA),
    (Name: 'sandybrown';           Color: $0060A4F4),
    (Name: 'seagreen';             Color: $00578B2E),
    (Name: 'seashell';             Color: $00EEF5FF),
    (Name: 'sienna';               Color: $002D52A0),
    (Name: 'silver';               Color: $00C0C0C0),
    (Name: 'skyblue';              Color: $00EBCE87),
    (Name: 'slateblue';            Color: $00CD5A6A),
    (Name: 'slategray';            Color: $00908070),
    (Name: 'snow';                 Color: $00FAFAFF),
    (Name: 'springgreen';          Color: $007FFF00),
    (Name: 'steelblue';            Color: $00B48246),
    (Name: 'tan';                  Color: $008CB4D2),
    (Name: 'teal';                 Color: clTeal),
    (Name: 'thistle';              Color: $00D8BFD8),
    (Name: 'tomato';               Color: $004763FD),
    (Name: 'turquoise';            Color: $00D0E040),
    (Name: 'violet';               Color: $00EE82EE),
    (Name: 'wheat';                Color: $00B3DEF5),
    (Name: 'white';                Color: clWhite),
    (Name: 'whitesmoke';           Color: $00F5F5F5),
    (Name: 'yellow';               Color: clYellow),
    (Name: 'yellowgreen';          Color: $0032CD9A),

    (Name: 'activeborder';         Color: clActiveBorder),
    (Name: 'activecaption';        Color: clActiveCaption),
    (Name: 'appworkspace';         Color: clAppWorkSpace),
    (Name: 'background';           Color: clBackground),
    (Name: 'buttonface';           Color: clBtnFace),
    (Name: 'buttonhighlight';      Color: clBtnHighlight),
    (Name: 'buttonshadow';         Color: clBtnShadow),
    (Name: 'buttontext';           Color: clBtnText),
    (Name: 'captiontext';          Color: clCaptionText),
    (Name: 'graytext';             Color: clGrayText),
    (Name: 'highlight';            Color: clHighlight),
    (Name: 'highlighttext';        Color: clHighlightText),
    (Name: 'inactiveborder';       Color: clInactiveBorder),
    (Name: 'inactivecaption';      Color: clInactiveCaption),
    (Name: 'inactivecaptiontext';  Color: clInactiveCaptionText),
    (Name: 'infobackground';       Color: clInfoBk),
    (Name: 'infotext';             Color: clInfoText),
    (Name: 'menu';                 Color: clMenu),
    (Name: 'menutext';             Color: clMenuText),
    (Name: 'scrollbar';            Color: clScrollBar),
    (Name: 'threeddarkshadow';     Color: cl3DDkShadow),
    (Name: 'threedface';           Color: clBtnFace),
    (Name: 'threedhighlight';      Color: clHighlightText),
    (Name: 'threedlightshadow';    Color: cl3DLight),
    (Name: 'threedshadow';         Color: clBtnShadow),
    (Name: 'window';               Color: clWindow),
    (Name: 'windowframe';          Color: clWindowFrame),
    (Name: 'windowtext';           Color: clWindowText)
  );

var
  CustomDrawImageProc: TcxDrawImageProc = nil;

function cxFlagsToDTFlags(Flags: Integer): Integer;

procedure cxSetImageList(const AValue: TCustomImageList; var AFieldValue: TCustomImageList; const AChangeLink: TChangeLink; ANotifyComponent: TComponent);
procedure ExtendRect(var Rect: TRect; const AExtension: TRect);
function IsGlyphAssigned(AGlyph: TBitmap): Boolean;
function IsImageAssigned(AImageList: TCustomImageList; AImageIndex: Integer): Boolean;

function IsXPManifestEnabled: Boolean;
function GetRealColor(AColor: TColor): TColor;

// light colors
function GetLightColor(ABtnFaceColorPart, AHighlightColorPart, AWindowColorPart: TcxColorPart): TColor;
function GetLightBtnFaceColor: TColor;
function GetLightDownedColor: TColor;
function GetLightDownedSelColor: TColor;
function GetLightSelColor: TColor;

function cxColorByName(const AText: string; var AColor: TColor): Boolean;
function cxNameByColor(AColor: TColor; var AText: string): Boolean;
function cxColorIsEqual(const AColor1, AColor2: TRGBQuad): Boolean;

function cxGetValueCurrentDPI(AValue: Integer; AHorizontal: Boolean = True): Integer;
function cxGetPixelsPerInch: TSize;
procedure cxAlphaBlend(ADestBitmap, ASrcBitmap: TBitmap; const ADestRect, ASrcRect: TRect; ASmoothImage: Boolean = False; AConstantAlpha: Byte = $FF); overload;
procedure cxAlphaBlend(ADestDC: HDC; ASrcBitmap: TBitmap; const ADestRect, ASrcRect: TRect; ASmoothImage: Boolean = False; AConstantAlpha: Byte = $FF); overload;
procedure cxAlphaBlend(ADestDC, ASrcDC: HDC; const ADestRect, ASrcRect: TRect; ASmoothImage: Boolean = False; AConstantAlpha: Byte = $FF); overload;
procedure cxBitBlt(ADestDC, ASrcDC: HDC; const ADestRect: TRect; const ASrcTopLeft: TPoint; ROP: DWORD);
//procedure cxBitmapToTrueColorBitmap(ABitmap: TBitmap); -> cxMakeTrueColorBitmap
procedure cxBlendFunction(const ASource: TRGBQuad; var ADest: TRGBQuad; ASourceConstantAlpha: Byte);
function cxCreateBitmap(const ASize: TSize; AFormat: TPixelFormat = pf24bit): TBitmap; overload;
function cxCreateBitmap(const ARect: TRect; AFormat: TPixelFormat = pf24bit): TBitmap; overload;
function cxCreateBitmap(AWidth, AHeight: Integer; AFormat: TPixelFormat = pf24bit): TBitmap; overload;
function cxCreateTrueColorBitmap(const ASize: TSize): TBitmap; overload;
function cxCreateTrueColorBitmap(AWidth, AHeight: Integer): TBitmap; overload;
function cxCreateTrueColorBitmapHandle(AWidth, AHeight: Integer; ABPP: Integer = 32): HBitmap;
function cxCreateRegionFromBitmap(ABitmap: TBitmap; ATransparentColor: TColor): HRGN;
procedure cxDrawDesignRect(ACanvas: TcxCanvas; const ARect: TRect; ASelected: Boolean);
procedure cxDrawBitmap(ADestDC: THandle; ASrcBitmap: TBitmap;
  const ADestRect: TRect; const ASrcPoint: TPoint; AMode: Integer = SRCCOPY);
procedure cxDrawImage(ADC: THandle; AGlyphRect, ABackgroundRect: TRect; AGlyph: TBitmap;
  AImages: TCustomImageList; AImageIndex: Integer; ADrawMode: TcxImageDrawMode;
  ASmoothImage: Boolean = False; ABrush: THandle = 0;
  ATransparentColor: TColor = clNone; AUseLeftBottomPixelAsTransparent: Boolean = True);
procedure cxDrawImageList(AImageListHandle: HIMAGELIST; AImageIndex: Integer;
  ADC: HDC; APoint: TPoint; ADrawingStyle: TDrawingStyle; AImageType: TImageType);
procedure cxDrawHatch(ADC: HDC; const ARect: TRect; AColor1, AColor2: TColor; AStep: Byte; AAlpha1: Byte = $FF; AAlpha2: Byte = $FF);
procedure cxSmoothResizeBitmap(ASource, ADestination: TBitmap; AForceUseLanczos3Filter: Boolean = False);
procedure cxStretchBlt(ADestDC, ASrcDC: HDC; const ADestRect, ASrcRect: TRect; ROP: DWORD);

procedure cxMakeColoredBitmap(ABitmap: TBitmap; AColor: TColor);
procedure cxMakeMaskBitmap(ASourceBitmap, AMaskBitmap: TBitmap);
procedure cxMakeTrueColorBitmap(ASourceBitmap, ATrueColorBitmap: TBitmap);

{!!! TODO: adapt to .net}
// mouse cursor size
function cxGetCursorSize: TSize;

// image helper routines
function CanApplySystemAlphaBlending: Boolean;
function SystemAlphaBlend(ADestDC, ASrcDC: HDC; const ADestRect, ASrcRect: TRect; AConstantAlpha: Byte = $FF): Boolean;
procedure cxAlphaBlend(ASource: TBitmap; ARect: TRect; const ASelColor: TColor; Alpha: Byte = 170); overload;
procedure cxAlphaBlend(ADest, ABkSource, ASource: TBitmap; Alpha: Byte = cxDefaultAlphaValue); overload;
procedure cxApplyViewParams(ACanvas: TcxCanvas; const AViewParams: TcxViewParams);
procedure cxCopyImage(ASource, ADest: TBitmap; const ASrcOffset, ADstOffset: TPoint; const ARect: TRect); overload;
procedure cxCopyImage(ASource, ADest: TCanvas; const ASrcOffset, ADstOffset: TPoint; const ARect: TRect); overload;
procedure cxDrawArrows(ACanvas: TCanvas; const ARect: TRect;
  ASide: TcxBorder; AColor: TColor; APenColor: TColor = clDefault);
procedure cxFillHalfToneRect(Canvas: TCanvas; const ARect: TRect; ABkColor, AColor: TColor);
procedure cxSetCanvasOrg(ACanvas: TCanvas; var AOrg: TRect);

function cxGetTextExtentPoint32(ADC: THandle; const AText: string; out ASize: TSize; ACharCount: Integer = -1): Boolean;
procedure cxGetTextLines(const AText: string; ACanvas: TcxCanvas; const ARect: TRect; ALines: TStrings);
function cxDrawText(ADC: THandle; const AText: string; var ARect: TRect;
  AFormat: UINT; ACharCount: Integer = - 1; ATextColor: TColor = clDefault; ABkMode: Integer = TRANSPARENT): Integer; overload;
function cxDrawText(ACanvas: TCanvas; const AText: string; ARect: TRect;
  AFormat: UINT; ATextColor: TColor = clDefault): Integer; overload;
function cxDrawText(ACanvas: TcxCanvas; const AText: string; const ARect: TRect;
  AFormat: UINT; ATextColor: TColor = clDefault; ARotationAngle: TcxRotationAngle = ra0): Integer; overload;
function cxExtTextOut(ADC: THandle; const AText: string; const APoint: TPoint;
  const ARect: TRect; AOptions: UINT; ACharCount: Integer = -1): Boolean; overload;
function cxExtTextOut(ADC: THandle; const AText: string; const APoint: TPoint;
  AOptions: UINT; ACharCount: Integer = -1): Boolean; overload;
procedure cxInvalidateRect(AHandle: THandle; const ARect: TRect; AEraseBackground: Boolean = True); overload;
procedure cxInvalidateRect(AHandle: THandle; AEraseBackground: Boolean = True); overload;

type
  TcxModifyStringType = (mstEndEllipsis, mstPathEllipsis);

function cxTextHeight(AFont: TFont; const S: string = 'Wg'; AFontSize: Integer = 0): Integer;
function cxTextWidth(AFont: TFont; const S: string; AFontSize: Integer = 0): Integer;
function cxTextExtent(AFont: TFont; const S: string; AFontSize: Integer = 0): TSize;
function cxTextSize(ADC: THandle; const AText: string): TSize;
function cxGetTextRect(ADC: THandle; const AText: string; ARowCount: Integer;
  AReturnMaxRectHeight: Boolean = False): TRect; overload;
function cxGetTextRect(AFont: TFont; const AText: string; ARowCount: Integer): TRect; overload;
function cxGetStringAdjustedToWidth(ADC: HDC; AFontHandle: HFONT; const S: string; AWidth: Integer; AModifyStringType: TcxModifyStringType = mstEndEllipsis): string; overload;
function cxGetStringAdjustedToWidth(AFont: TFont; const S: string; AWidth: Integer; AModifyStringType: TcxModifyStringType = mstEndEllipsis): string; overload;

function cxCompareBitmaps(ABitmap1, ABitmap2: TBitmap): Boolean;
function cxGetBitmapData(ABitmapHandle: HBITMAP; out ABitmapData: Windows.TBitmap): Boolean;
function cxGetBrushData(ABrushHandle: HBRUSH; out ALogBrush: TLogBrush): Boolean; overload;
function cxGetBrushData(ABrushHandle: HBRUSH): TLogBrush; overload;
function cxGetFontData(AFontHandle: HFONT; out ALogFont: TLogFont): Boolean;
function cxGetPenData(APenHandle: HPEN; out ALogPen: TLogPen): Boolean;
procedure cxResetFont(const AFont: TFont);

function cxGetWritingDirection(AFontCharset: TFontCharset; const AText: string): TCanvasOrientation;
procedure cxDrawThemeParentBackground(AControl: TWinControl; ACanvas: TcxCanvas; const ARect: TRect); overload;
procedure cxDrawThemeParentBackground(AControl: TWinControl; ACanvas: TCanvas; const ARect: TRect); overload;
procedure cxDrawTransparentControlBackground(AControl: TWinControl;
  ACanvas: TcxCanvas; ARect: TRect; APaintParentWithChildren: Boolean = True); overload;
procedure cxDrawTransparentControlBackground(AControl: TWinControl;
  ACanvas: TCanvas; const ARect: TRect; APaintParentWithChildren: Boolean = True); overload;
procedure cxDrawTransparentControlBackground(AControl: TWinControl;
  ACanvas: TcxCanvas; const ASourceRect: TRect; const ADestinationPoint: TPoint; APaintParentWithChildren: Boolean = True); overload;
function cxScreenCanvas: TcxScreenCanvas;
function cxPaintCanvas: TcxPaintCanvas;

procedure cxPaintTo(ASourceControl: TWinControl; ADestinationCanvas: TcxCanvas; const ADestinationPoint: TPoint; const ASourceRect: TRect; AConsiderSourceControlWindowRegion: Boolean = True);

procedure cxTransformImages(AImageList: TcxImageList; ABkColor: TColor; AEnabled: Boolean = True); overload;
procedure cxTransformImages(ASourceImageList, ADestinationImageList: TcxImageList; ABkColor: TColor; AEnabled: Boolean = True); overload;

procedure cxAdvancedDrawPopupMenuItem(AMenuItem: TMenuItem; ACanvas: TCanvas; ARect: TRect;
  AState: TOwnerDrawState);

implementation

uses
  Messages, Math, cxControls, cxGeometry, dxUxTheme, dxOffice11,
  dxThemeConsts, dxThemeManager, cxDrawTextUtils, dxGDIPlusClasses, dxGDIPlusApi;

type
  TCanvasAccess = class(TCanvas);
  TBitmapAccess = class(TBitmap);

  TContributor = record
    Pixel: Integer;
    Weight: Integer;
  end;
  TContributorArray = array of TContributor;

  TContributors = record
    Count: Integer;
    Contributors: TContributorArray;
  end;
  TContributorList = array of TContributors;

const
{!!! TODO: adapt to .net}
  BaseRgns: array[0..3, 0..6, 0..1] of Integer =
  (((0, -1), (-5, -6),(-2, -6), (-2, -9), (2, -9), (2, -6), (5, -6)),
   ((0, 0), (5, 5), (2, 5), (2, 8), (-2, 8), (-2, 5), (-5, 5)),
   ((-1, 0), (-6, -5), (-6, -2), (-9, -2), (-9, 2), (-6, 2), (-6, 5)),
   ((0, 0), (5, 5), (5, 2), (8, 2), (8, -2), (5, -2), (5, -5)));
  DefaultBlendFunction: TBlendFunction =
   (BlendOp: AC_SRC_OVER;
    BlendFlags: 0;
    SourceConstantAlpha: cxDefaultAlphaValue;
    AlphaFormat: $0);

var
  FUnitIsFinalized: Boolean;
  SetProcessDPIAware: function (): BOOL; stdcall;
  VCLAlphaBlend: function(DC: LongWord; p2, p3, p4, p5: Integer; DC6: LongWord;
    p7, p8, p9, p10: Integer; p11: TBlendFunction): BOOL; stdcall;
  ScreenCanvas: TcxScreenCanvas = nil;
  PaintCanvas: TcxPaintCanvas;
  DrawBitmap, ImageBitmap, MaskBitmap: TcxAlphaBitmap;
  FUser32DLL, FMsimg32DLL: HMODULE;
  FPixelsPerInch: TSize;

function cxGetValueCurrentDPI(AValue: Integer; AHorizontal: Boolean = True): Integer;
begin
  if AHorizontal then
    Result := MulDiv(AValue, cxGetPixelsPerInch.cx, 96)
  else
    Result := MulDiv(AValue, cxGetPixelsPerInch.cy, 96);
end;

function cxGetPixelsPerInch: TSize;
begin
  Result := FPixelsPerInch;
end;

procedure cxBitmapInit(var ABitmap: TcxAlphaBitmap; AWidth, AHeight: Integer);
begin
  if ABitmap = nil then
    ABitmap := TcxAlphaBitmap.CreateSize(AWidth, AHeight, True)
  else
    ABitmap.RefreshImage(AWidth, AHeight);
end;

function GetDrawBitmap(AWidth, AHeight: Integer): TcxAlphaBitmap;
begin
  cxBitmapInit(DrawBitmap, AWidth, AHeight);
  Result := DrawBitmap;
end;

function GetImageBitmap(AWidth, AHeight: Integer): TcxAlphaBitmap;
begin
  cxBitmapInit(ImageBitmap, AWidth, AHeight);
  Result := ImageBitmap;
end;

function GetMaskBitmap(AWidth, AHeight: Integer): TcxAlphaBitmap;
begin
  cxBitmapInit(MaskBitmap, AWidth, AHeight);
  Result := MaskBitmap;
end;

function cxFlagsToDTFlags(Flags: Integer): Integer;
const
  DT_NOFULLWIDTHCHARBREAK = $80000;
begin
  Result := DT_NOPREFIX;
  if cxAlignLeft and Flags <> 0 then
    Result := Result or DT_LEFT;
  if cxAlignRight and Flags <> 0 then
    Result := Result or DT_RIGHT;
  if cxAlignHCenter and Flags <> 0 then
    Result := Result or DT_CENTER;
  if cxAlignTop and Flags <> 0 then
    Result := Result or DT_TOP;
  if cxAlignBottom and Flags <> 0 then
    Result := Result or DT_BOTTOM;
  if cxAlignVCenter and Flags <> 0 then
    Result := Result or DT_VCENTER;
  if cxSingleLine and Flags <> 0 then
    Result := Result or DT_SINGLELINE;
  if cxDontClip and Flags <> 0 then
    Result := Result or DT_NOCLIP;
  if cxExpandTabs and Flags <> 0 then
    Result := Result or DT_EXPANDTABS;
  if cxShowPrefix and Flags <> 0 then
    Result := Result and not DT_NOPREFIX;
  if cxWordBreak and Flags <> 0 then
  begin
    Result := Result or DT_WORDBREAK;
    if cxDontBreakChars and Flags = 0 then
      Result := Result or DT_EDITCONTROL
    else
      if cxNoFullWidthCharBreak and Flags <> 0 then
        Result := Result or DT_NOFULLWIDTHCHARBREAK;
  end;
  if cxShowEndEllipsis and Flags <> 0 then
    Result := Result or DT_END_ELLIPSIS;
  if cxDontPrint and Flags <> 0 then
    Result := Result or DT_CALCRECT;
  if cxShowPathEllipsis and Flags <> 0 then
    Result := Result or DT_PATH_ELLIPSIS;
end;

procedure cxSetImageList(const AValue: TCustomImageList; var AFieldValue: TCustomImageList; const AChangeLink: TChangeLink; ANotifyComponent: TComponent);
begin
  if AValue <> AFieldValue then
  begin
    if AFieldValue <> nil then
    begin
      AFieldValue.RemoveFreeNotification(ANotifyComponent);
      if AChangeLink <> nil then
        AFieldValue.UnRegisterChanges(AChangeLink);
    end;
    AFieldValue := AValue;
    if AValue <> nil then
    begin
      if AChangeLink <> nil then
        AValue.RegisterChanges(AChangeLink);
      AValue.FreeNotification(ANotifyComponent);
    end;
    if AChangeLink <> nil then
      AChangeLink.Change;
  end;
end;

procedure ExtendRect(var Rect: TRect; const AExtension: TRect);
begin
  with AExtension do
  begin
    Inc(Rect.Left, Left);
    Inc(Rect.Top, Top);
    Dec(Rect.Right, Right);
    Dec(Rect.Bottom, Bottom);
  end;
end;

function IsGlyphAssigned(AGlyph: TBitmap): Boolean;
begin
  Result := (AGlyph <> nil) and not AGlyph.Empty;
end;

function IsImageAssigned(AImageList: TCustomImageList; AImageIndex: Integer): Boolean;
begin
  Result := (AImageList <> nil) and (0 <= AImageIndex) and (AImageIndex < AImageList.Count);
end;

function IsXPManifestEnabled: Boolean;
{$IFNDEF DELPHI7}
const
  ComCtlVersionIE6 = $00060000;
{$ENDIF}
begin
  Result := GetComCtlVersion >= ComCtlVersionIE6
end;

function GetRealColor(AColor: TColor): TColor;
var
  DC: HDC;
begin
  DC := GetDC(0);
  Result := GetNearestColor(DC, AColor);
  ReleaseDC(0, DC);
end;

function GetChannelValue(AValue: Integer): Byte;
begin
  if AValue < 0 then
    Result := 0
  else
    if AValue > 255 then
      Result := 255
    else
      Result := AValue;
end;

function GetLightColor(ABtnFaceColorPart, AHighlightColorPart, AWindowColorPart: TcxColorPart): TColor;
var
  ABtnFaceColor, AHighlightColor, AWindowColor: TColor;

  function GetLightIndex(ABtnFaceValue, AHighlightValue, AWindowValue: Byte): Integer;
  begin
    Result := GetChannelValue(
      MulDiv(ABtnFaceValue, ABtnFaceColorPart, 100) +
      MulDiv(AHighlightValue, AHighlightColorPart, 100) +
      MulDiv(AWindowValue, AWindowColorPart, 100));
  end;

begin
  ABtnFaceColor := ColorToRGB(clBtnFace);
  AHighlightColor := ColorToRGB(clHighlight);
  AWindowColor := ColorToRGB(clWindow);
  if (ABtnFaceColor = 0) or (ABtnFaceColor = $FFFFFF) then
    Result := AHighlightColor
  else
    Result := RGB(
      GetLightIndex(GetRValue(ABtnFaceColor), GetRValue(AHighlightColor), GetRValue(AWindowColor)),
      GetLightIndex(GetGValue(ABtnFaceColor), GetGValue(AHighlightColor), GetGValue(AWindowColor)),
      GetLightIndex(GetBValue(ABtnFaceColor), GetBValue(AHighlightColor), GetBValue(AWindowColor)));
end;

function GetLightBtnFaceColor: TColor;

  function GetLightValue(Value: Byte): Byte;
  begin
    Result := GetChannelValue(Value + MulDiv(255 - Value, 16, 100));
  end;

begin
  Result := ColorToRGB(clBtnFace);
  Result := RGB(
    GetLightValue(GetRValue(Result)),
    GetLightValue(GetGValue(Result)),
    GetLightValue(GetBValue(Result)));
  Result := GetRealColor(Result);
end;

function GetLightDownedColor: TColor;
begin
  Result := GetRealColor(GetLightColor(11, 9, 73));
end;

function GetLightDownedSelColor: TColor;
begin
  Result := GetRealColor(GetLightColor(14, 44, 40));
end;

function GetLightSelColor: TColor;
begin
  Result := GetRealColor(GetLightColor(-2, 30, 72));
end;

function CanApplySystemAlphaBlending: Boolean;
begin
  Result := {not IsWOW64 and }Assigned(VCLAlphaBlend);
end;

function SystemAlphaBlend(ADestDC, ASrcDC: HDC; const ADestRect, ASrcRect: TRect; AConstantAlpha: Byte = $FF): Boolean;
{$IFNDEF DELPHI6}
const
  AC_SRC_ALPHA = 1;
{$ENDIF}
var
  ABlendFunction: TBlendFunction;
begin
  ABlendFunction.BlendOp := AC_SRC_OVER;
  ABlendFunction.BlendFlags := 0;
  ABlendFunction.SourceConstantAlpha := AConstantAlpha;
  ABlendFunction.AlphaFormat := AC_SRC_ALPHA;
  Result := CanApplySystemAlphaBlending and VCLAlphaBlend(
    ADestDC, ADestRect.Left, ADestRect.Top, cxRectWidth(ADestRect), cxRectHeight(ADestRect),
    ASrcDC, ASrcRect.Left, ASrcRect.Top, cxRectWidth(ASrcRect), cxRectHeight(ASrcRect), ABlendFunction);
end;

function cxColorByName(const AText: string; var AColor: TColor): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := Low(cxColorsByName) to High(cxColorsByName) do
    if SameText(AText, cxColorsByName[I].Name) then
    begin
      AColor := cxColorsByName[I].Color;
      Result := True;
      Break;
    end;
end;

function cxNameByColor(AColor: TColor; var AText: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := Low(cxColorsByName) to High(cxColorsByName) do
    if AColor = cxColorsByName[I].Color then
    begin
      AText := cxColorsByName[I].Name;
      Result := True;
      Break;
    end;
end;

procedure CommonAlphaBlend(ADestDC, ASrcDC: HDC; const ADestRect, ASrcRect: TRect; ASmoothImage: Boolean; AConstantAlpha: Byte = $FF);

  function CreateDirectBitmap(ASrcDC: HDC; const ASrcRect: TRect): TBitmap;
  var
    ARect: TRect;
  begin
    ARect := Rect(0, 0, cxRectWidth(ASrcRect), cxRectHeight(ASrcRect));
    Result := cxCreateBitmap(ARect, pf32bit);
    Result.Canvas.Brush.Color := 0;
    Result.Canvas.FillRect(ARect);
    cxBitBlt(Result.Canvas.Handle, ASrcDC, ARect, ASrcRect.TopLeft, SRCCOPY);
  end;

  function cxRectIdentical(const ARect1, ARect2: TRect): Boolean;
  begin
    Result := (cxRectWidth(ARect1) = cxRectWidth(ARect2)) and (cxRectHeight(ARect1) = cxRectHeight(ARect2));
  end;

  procedure ResizeBitmap(ADestBitmap, ASrcBitmap: TBitmap);
  begin
    StretchBlt(ADestBitmap.Canvas.Handle, 0, 0, ADestBitmap.Width, ADestBitmap.Height,
      ASrcBitmap.Canvas.Handle, 0, 0, ASrcBitmap.Width, ASrcBitmap.Height, SRCCOPY);
  end;

  procedure InternalAlphaBlend(ADestBitmap, ASrcBitmap: TBitmap);

    procedure SoftwareAlphaBlend(AWidth, AHeight: Integer);
    var
      ASourceColors, ADestColors: TRGBColors;
      I: Integer;
    begin
      GetBitmapBits(ASrcBitmap, ASourceColors, False);
      GetBitmapBits(ADestBitmap, ADestColors, False);
      for I := 0 to AWidth * AHeight - 1 do
        cxBlendFunction(ASourceColors[I], ADestColors[I], AConstantAlpha);
      SetBitmapBits(ADestBitmap, ADestColors, False);
    end;

  var
    AClientRect: TRect;
  begin
    AClientRect := Rect(0, 0, ADestBitmap.Width, ADestBitmap.Height);
    if not SystemAlphaBlend(ADestBitmap.Canvas.Handle, ASrcBitmap.Canvas.Handle, AClientRect, AClientRect, AConstantAlpha) then
      SoftwareAlphaBlend(AClientRect.Right, AClientRect.Bottom);
  end;

  procedure ComplexAlphaBlend;
  var
    AGraphics: TdxGPGraphics;
    ADirectDestBitmap, ADirectSrcBitmap, AStretchedSrcBitmap: TBitmap;
  const
    iModes: array[Boolean] of Integer = (InterpolationModeLowQuality, InterpolationModeHighQualityBicubic);
  begin
    ADirectSrcBitmap := CreateDirectBitmap(ASrcDC, ASrcRect);
    try
      if IsWow64 then
      begin
        AGraphics := dxGpBeginPaint(ADestDC, ADestRect);
        try
          AGraphics.InterpolationMode := iModes[ASmoothImage];
          AGraphics.DrawBitmap(ADirectSrcBitmap, ADestRect, AConstantAlpha);
        finally
          dxGpEndPaint(AGraphics);
        end;
      end
      else
      begin
        ADirectDestBitmap := CreateDirectBitmap(ADestDC, ADestRect);
        AStretchedSrcBitmap := cxCreateBitmap(ADestRect, pf32bit);
        try
          if ASmoothImage then
            cxSmoothResizeBitmap(ADirectSrcBitmap, AStretchedSrcBitmap, True)
          else
            ResizeBitmap(AStretchedSrcBitmap, ADirectSrcBitmap);
          InternalAlphaBlend(ADirectDestBitmap, AStretchedSrcBitmap);
          cxBitBlt(ADestDC, ADirectDestBitmap.Canvas.Handle, ADestRect, cxNullPoint, SRCCOPY);
        finally
          AStretchedSrcBitmap.Free;
          ADirectDestBitmap.Free;
        end;
      end;
    finally
      ADirectSrcBitmap.Free;
    end;
  end;

begin
  ASmoothImage := ASmoothImage and not cxRectIdentical(ADestRect, ASrcRect);
  if IsWow64 or IsWin9X or not CanApplySystemAlphaBlending or ASmoothImage then
    ComplexAlphaBlend
  else
    SystemAlphaBlend(ADestDC, ASrcDC, ADestRect, ASrcRect, AConstantAlpha);
end;

procedure cxAlphaBlend(ADestBitmap, ASrcBitmap: TBitmap; const ADestRect, ASrcRect: TRect; ASmoothImage: Boolean = False; AConstantAlpha: Byte = $FF); overload;
begin
  CommonAlphaBlend(ADestBitmap.Canvas.Handle, ASrcBitmap.Canvas.Handle, ADestRect, ASrcRect, ASmoothImage, AConstantAlpha);
end;

procedure cxAlphaBlend(ADestDC: HDC; ASrcBitmap: TBitmap; const ADestRect, ASrcRect: TRect; ASmoothImage: Boolean = False; AConstantAlpha: Byte = $FF); overload;
begin
  CommonAlphaBlend(ADestDC, ASrcBitmap.Canvas.Handle, ADestRect, ASrcRect, ASmoothImage, AConstantAlpha);
end;

procedure cxAlphaBlend(ADestDC, ASrcDC: HDC; const ADestRect, ASrcRect: TRect; ASmoothImage: Boolean = False; AConstantAlpha: Byte = $FF); overload;
begin
  CommonAlphaBlend(ADestDC, ASrcDC, ADestRect, ASrcRect, ASmoothImage, AConstantAlpha);
end;

procedure cxBitBlt(ADestDC, ASrcDC: HDC; const ADestRect: TRect; const ASrcTopLeft: TPoint; ROP: DWORD);
begin
  BitBlt(ADestDC, ADestRect.Left, ADestRect.Top, cxRectWidth(ADestRect), cxRectHeight(ADestRect),
    ASrcDC, ASrcTopLeft.X, ASrcTopLeft.Y, ROP);
end;

procedure cxBlendFunction(const ASource: TRGBQuad; var ADest: TRGBQuad; ASourceConstantAlpha: Byte);

  function GetValue(AValue: Single): Byte;
  begin
    Result := GetChannelValue(Round(AValue));
  end;

var
  ASCA, ASrcAlpha: Single;
begin
  ASCA := ASourceConstantAlpha / 255;
  ASrcAlpha := 1 - ASource.rgbReserved * ASCA / 255;

  ADest.rgbRed := GetValue(ASource.rgbRed * ASCA + ASrcAlpha * ADest.rgbRed);
  ADest.rgbGreen := GetValue(ASource.rgbGreen * ASCA + ASrcAlpha * ADest.rgbGreen);
  ADest.rgbBlue := GetValue(ASource.rgbBlue * ASCA + ASrcAlpha * ADest.rgbBlue);
  ADest.rgbReserved := GetValue(ASource.rgbReserved * ASCA + ASrcAlpha * ADest.rgbReserved);
end;

const
  ClrNone: TRGBQuad = (rgbBlue: $FF; rgbGreen: $FF; rgbRed: $FF; rgbReserved: $FF);
  ClrTransparent: TRGBQuad = (rgbBlue: 0; rgbGreen: 0; rgbRed: 0; rgbReserved: 0);

function cxColorIsEqual(const AColor1, AColor2: TRGBQuad): Boolean;
begin
  Result := DWORD(AColor1) = DWORD(AColor2);
end;

function cxColorEssence(const AColor: TRGBQuad): DWORD; {$IFDEF DELPHI9} inline; {$ENDIF}
begin
  Result := DWORD(AColor) and $00FFFFFF;
end;

function cxCreateRegionFromBitmap(ABitmap: TBitmap; ATransparentColor: TColor): HRGN;

  procedure CombineRegion(X, Y: Integer; var ACount: Integer; var ACombined: HRGN);
  var
    ARgn: HRGN;
  begin
    if ACount > 0 then
    begin
      ARgn := CreateRectRgn(X - ACount, Y, X, Y + 1);
      if ACombined = 0 then
        ACombined := ARgn
      else
      begin
        CombineRgn(ACombined, ACombined, ARGN, RGN_OR);
        DeleteObject(ARgn);
      end;
      ACount := 0;
    end;
  end;

var
  AColors: TRGBColors;
  ACount, AIndex: Integer;
  ATransparent: TRGBQuad;
  X, Y: Integer;
begin
  Result := 0;
  AIndex := 0;
  ATransparent := dxColorToRGBQuad(ATransparentColor);
  GetBitmapBits(ABitmap, AColors, True);
  for Y := 0 to ABitmap.Height - 1 do
  begin
    ACount := 0;
    for X := 0 to ABitmap.Width - 1 do
    begin
      if cxColorEssence(AColors[AIndex]) = cxColorEssence(ATransparent) then
        CombineRegion(X, Y, ACount, Result)
      else
        Inc(ACount);
      Inc(AIndex);
    end;
    CombineRegion(ABitmap.Width, Y, ACount, Result);
  end;
end;

procedure cxSetBitmapParams(ABitmap: TBitmap; AWidth, AHeight: Integer; AFormat: TPixelFormat);
begin
{$IFDEF DELPHI6}
  ABitmap.PixelFormat := AFormat;
{$ENDIF}
  ABitmap.Width := AWidth;
  ABitmap.Height := AHeight;
{$IFNDEF DELPHI6}
  ABitmap.PixelFormat := AFormat;
{$ENDIF}
end;

function cxCreateBitmap(const ASize: TSize; AFormat: TPixelFormat = pf24bit): TBitmap;
begin
  Result := cxCreateBitmap(ASize.cx, ASize.cy, AFormat);
end;

function cxCreateBitmap(const ARect: TRect; AFormat: TPixelFormat = pf24bit): TBitmap;
begin
  Result := cxCreateBitmap(cxRectWidth(ARect), cxRectHeight(ARect), AFormat);
end;

function cxCreateBitmap(AWidth, AHeight: Integer; AFormat: TPixelFormat = pf24bit): TBitmap;
begin
  Result := TBitmap.Create;
  cxSetBitmapParams(Result, AWidth, AHeight, AFormat);
end;

function cxCreateTrueColorBitmap(const ASize: TSize): TBitmap;
begin
  Result := cxCreateTrueColorBitmap(ASize.cx, ASize.cy);
end;

function cxCreateTrueColorBitmap(AWidth, AHeight: Integer): TBitmap;
begin
  Result := TBitmap.Create;
  Result.Handle := cxCreateTrueColorBitmapHandle(AWidth, AHeight);
end;

function cxCreateTrueColorBitmapHandle(AWidth, AHeight: Integer; ABPP: Integer = 32): HBitmap;
begin
  Result := CreateBitmap(AWidth, AHeight, 1, ABPP, nil);
end;

procedure cxDrawDesignRect(ACanvas: TcxCanvas; const ARect: TRect; ASelected: Boolean);
const
  Colors: array[Boolean] of TColor = ($A0FFA0, $9090FF);
var
  AColor: TColor;
  I: Integer;
  AShadowRect: TRect;
begin
  if not IsRectEmpty(ARect) then
  begin
    ACanvas.SaveState;
    try
      ACanvas.SetClipRegion(TcxRegion.Create(ARect), roSet);
      AColor := Colors[ASelected];
      ACanvas.FillRect(ARect, AColor);
      ACanvas.Pen.Color := Dark(AColor, 75);
      for I := 1 to MulDiv(ARect.Right, 3, 2) do
        ACanvas.Polyline([Point(ARect.Right - I * 3, ARect.Top), Point(ARect.Right, ARect.Top + I * 3)]);
      ACanvas.FrameRect(ARect, Dark(AColor, 50));
    finally
      ACanvas.RestoreState;
    end;
    ACanvas.ExcludeClipRect(ARect);
    AShadowRect := cxRectOffset(ARect, 1, 1);
    ACanvas.FillRect(AShadowRect, clBtnShadow);
    ACanvas.ExcludeClipRect(AShadowRect);
  end;
end;

procedure cxDrawBitmap(ADestDC: THandle; ASrcBitmap: TBitmap;
  const ADestRect: TRect; const ASrcPoint: TPoint; AMode: Integer = SRCCOPY);

  procedure InternalDrawBitmap;

    procedure SoftwareBitBlt;
    var
      ABitmap: TcxAlphaBitmap;
    begin
      ABitmap := TcxAlphaBitmap.CreateSize(ADestRect);
      try
        cxBitBlt(ABitmap.Canvas.Handle, ASrcBitmap.Canvas.Handle, ABitmap.ClientRect, ASrcPoint, SRCCOPY);
        ABitmap.TransformBitmap(btmResetAlpha);
        cxBitBlt(ADestDC, ABitmap.Canvas.Handle, ADestRect, cxNullPoint, AMode);
      finally
        ABitmap.Free;
      end;
    end;

   begin
    if IsWin9X and (GetDeviceCaps(ADestDC, BITSPIXEL) = 32) and (cxGetBitmapPixelFormat(ASrcBitmap) < 32) then
      SoftwareBitBlt
    else
      cxBitBlt(ADestDC, ASrcBitmap.Canvas.Handle, ADestRect, ASrcPoint, AMode);
  end;

var
  APrevPalette: HPALETTE;
begin
  if (ASrcBitmap.Palette <> 0) and (GetDeviceCaps(ADestDC, BITSPIXEL) <= 8) then
  begin
    APrevPalette := SelectPalette(ADestDC, ASrcBitmap.Palette, True);
    RealizePalette(ADestDC);
    InternalDrawBitmap;
    SelectPalette(ADestDC, APrevPalette, True);
  end
  else
    InternalDrawBitmap;
end;

procedure cxDrawImage(ADC: THandle; AGlyphRect, ABackgroundRect: TRect; AGlyph: TBitmap;
  AImages: TCustomImageList; AImageIndex: Integer; ADrawMode: TcxImageDrawMode;
  ASmoothImage: Boolean = False; ABrush: THandle = 0;
  ATransparentColor: TColor = clNone; AUseLeftBottomPixelAsTransparent: Boolean = True);

  procedure DrawBackGround(ABitmap: TcxAlphaBitmap);
  begin
    if ABrush = 0 then
      cxBitBlt(ABitmap.Canvas.Handle, ADC, ABitmap.ClientRect, ABackgroundRect.TopLeft, SRCCOPY)
    else
      FillRect(ABitmap.Canvas.Handle, ABitmap.ClientRect, ABrush);
  end;

  procedure DrawImage(ABitmap: TcxAlphaBitmap; ADrawMode: TcxImageDrawMode);

    procedure MakeImage(AImageBitmap: TcxAlphaBitmap; out AIsAlphaUsed: Boolean);
    begin
      if not IsGlyphAssigned(AGlyph) then
      begin
        TcxImageList.GetImageInfo(AImages, AImageIndex, AImageBitmap, nil);

//        cxDrawImageList(AImages.Handle, AImageIndex, AImageBitmap.Canvas.Handle,
//          cxNullPoint, AImages.DrawingStyle, AImages.ImageType)
//#DG can break destination        AImages.Draw(AImageBitmap.Canvas, 0, 0, AImageIndex)
        AIsAlphaUsed := TcxImageList.GetPixelFormat(AImages.Handle) >= 32;
      end
      else
      begin
        AImageBitmap.CopyBitmap(AGlyph);
        AIsAlphaUsed := cxGetBitmapPixelFormat(AGlyph) >= 32;
      end;
      AIsAlphaUsed := AIsAlphaUsed and AImageBitmap.IsAlphaUsed;
      if not AIsAlphaUsed then
        AImageBitmap.TransformBitmap(btmSetOpaque);
    end;

    procedure MakeMask(AImageBitmap, AMaskBitmap: TcxAlphaBitmap; AIsAlphaUsed: Boolean);
    var
      AImageListMask: TcxAlphaBitmap;
    begin
      AMaskBitmap.CopyBitmap(AImageBitmap);
      if not AIsAlphaUsed then
      begin
        if not IsGlyphAssigned(AGlyph) then
        begin
          AImageListMask := TcxAlphaBitmap.CreateSize(AMaskBitmap.ClientRect);
          try
            TcxImageList.GetImageInfo(AImages.Handle, AImageIndex, nil, AImageListMask);
            AImageListMask.TransformBitmap(btmCorrectBlend);
            AMaskBitmap.Filter(AImageListMask);
          finally
            AImageListMask.Free;
          end;
        end;
        if ATransparentColor <> clNone then
          AMaskBitmap.TransparentPixels.Add(ATransparentColor);
        if AUseLeftBottomPixelAsTransparent and IsGlyphAssigned(AGlyph) then
          AMaskBitmap.TransparentPixels.Add(AMaskBitmap.TransparentColor);
      end;
      AMaskBitmap.TransformBitmap(btmMakeMask);
    end;

  const
    AImageShadowSize = 2;
  var
    BW, BH: Integer;
    AImageBitmap, AMaskBitmap: TcxAlphaBitmap;
    AConstantAlpha: Byte;
    AIsAlphaUsed: Boolean;
  begin
    OffsetRect(AGlyphRect, -ABackgroundRect.Left, -ABackgroundRect.Top);
    if not Assigned(CustomDrawImageProc) or not CustomDrawImageProc(ABitmap.Canvas, AImages, AImageIndex, AGlyph, AGlyphRect, ADrawMode) then
    begin
      if not IsGlyphAssigned(AGlyph) then
      begin
        BW := AImages.Width;
        BH := AImages.Height;
      end
      else
      begin
        BW := AGlyph.Width;
        BH := AGlyph.Height;
      end;

      AImageBitmap := GetImageBitmap(BW, BH);
      MakeImage(AImageBitmap, AIsAlphaUsed);

      AMaskBitmap := GetMaskBitmap(BW, BH);
      MakeMask(AImageBitmap, AMaskBitmap, AIsAlphaUsed);
      AImageBitmap.Filter(AMaskBitmap);
      AConstantAlpha := $FF;
      case ADrawMode of
        idmFaded:
          begin
            AImageBitmap.TransformBitmap(btmFade);
            AConstantAlpha := FadeMap.SrcConstantAlpha;
          end;
        idmGrayScale:
          AImageBitmap.TransformBitmap(btmGrayScale);
        idmDingy:
          AImageBitmap.TransformBitmap(btmDingy);
        idmShadowed:
          begin
            AImageBitmap.DrawShadow(AMaskBitmap, AImageShadowSize, clBtnShadow, True);
            AGlyphRect := cxRectInflate(AGlyphRect, 0, 0, AImageShadowSize, AImageShadowSize);
            OffsetRect(AGlyphRect, -AImageShadowSize div 2, -AImageShadowSize div 2);
          end;
        idmDisabled:
          begin
            if AIsAlphaUsed then
            begin
              AImageBitmap.TransformBitmap(btmDisable);
              AConstantAlpha := DisableMap.SrcConstantAlpha;
            end
            else
            begin
              AImageBitmap.TransformBitmap(btmDirty);
              AImageBitmap.DrawShadow(AMaskBitmap, 1, clBtnHighlight);
            end;
          end;
      end;
      AImageBitmap.AlphaBlend(ABitmap, AGlyphRect, ASmoothImage, AConstantAlpha);
    end;
  end;

var
  ADrawBitmap: TcxAlphaBitmap;
begin
  if not (IsGlyphAssigned(AGlyph) or IsImageAssigned(AImages, AImageIndex)) then
    Exit;

  ADrawBitmap := GetDrawBitmap(cxRectWidth(ABackgroundRect), cxRectHeight(ABackgroundRect));
  DrawBackGround(ADrawBitmap);
  DrawImage(ADrawBitmap, ADrawMode);
  cxDrawBitmap(ADC, ADrawBitmap, ABackgroundRect, cxNullPoint);
end;

function GetImageListStyle(ADrawingStyle: TDrawingStyle; AImageType: TImageType): DWORD;
const
  ADrawingStyles: array[TDrawingStyle] of DWORD = (ILD_FOCUS, ILD_SELECTED, ILD_NORMAL, ILD_TRANSPARENT);
  AImageTypes: array[TImageType] of DWORD = (0, ILD_MASK);
begin
  Result := ADrawingStyles[ADrawingStyle] or AImageTypes[AImageType];
end;

procedure cxDrawImageList(AImageListHandle: HIMAGELIST; AImageIndex: Integer;
  ADC: HDC; APoint: TPoint; ADrawingStyle: TDrawingStyle; AImageType: TImageType);
begin
  ImageList_Draw(AImageListHandle, AImageIndex, ADC, APoint.X, APoint.Y, GetImageListStyle(ADrawingStyle, AImageType));
end;

procedure cxDrawHatch(ADC: HDC; const ARect: TRect; AColor1, AColor2: TColor; AStep: Byte; AAlpha1: Byte = $FF; AAlpha2: Byte = $FF);
var
  ADrawBitmap: TcxAlphaBitmap;
begin
  ADrawBitmap := TcxAlphaBitmap.CreateSize(ARect);
  try
    cxBitBlt(ADrawBitmap.Canvas.Handle, ADC, ADrawBitmap.ClientRect, ARect.TopLeft, SRCCOPY);
    ADrawBitmap.DrawHatch(AColor1, AColor2, AStep, AAlpha1, AAlpha2);
    cxBitBlt(ADC, ADrawBitmap.Canvas.Handle, ARect, cxNullPoint, SRCCOPY);
  finally
    ADrawBitmap.Free;
  end;
end;

function Lanczos3Filter(Value: Single): Single;

  function SinC(Value: Single): Single;
  begin
    if (Value <> 0.0) then
    begin
      Value  := Value * PI;
      Result := Sin(Value) / Value
    end
    else Result := 1.0;
  end;

begin
  if (Value < 0.0) then Value := -Value;
  if (Value < 3.0) then
    Result := SinC(Value) * SinC(Value / 3.0)
  else
    Result := 0.0;
end;

procedure BuildFilter(out AContributorList: TContributorList; AScale: Single; ASrcSize, ADestSize: Integer);
var
  I, J, APixel, AMaxContributors, AWeight: Integer;
  ACenter, ARadius, AScaleFactor: Single;
begin
  SetLength(AContributorList, ADestSize);
  if AScale < 1.0 then AScaleFactor := 1.0 / AScale else AScaleFactor := 1.0;
  ARadius := 3 * AScaleFactor;
  AMaxContributors := Trunc(ARadius * 2.0 + 1);
  for I := 0 to ADestSize - 1 do
    with AContributorList[I] do
    begin
      SetLength(Contributors, AMaxContributors);
      Count := 0;
      ACenter := I / AScale;
      for J := Floor(ACenter - ARadius) to Ceil(ACenter + ARadius) do
      begin
        AWeight := Round(Lanczos3Filter((ACenter - J) / AScaleFactor) / AScaleFactor * 256);
        if AWeight = 0 then continue;
        if J < 0 then
          APixel := -J
        else
          if (J >= ASrcSize) then
            APixel := ASrcSize - J + ASrcSize - 1
          else
            APixel := J;
        Contributors[Count].Pixel := APixel;
        Contributors[Count].Weight := AWeight;
        Inc(Count);
      end;
    end;
end;

procedure ApplyFilter(var AContributorList: TContributorList;
  var ASource: TRGBColors; ASrcSize, ASrcLineLength: Integer;
  var ADest: TRGBColors; ADestSize, ADestLineLength: Integer;
  AHorizontal: Boolean);

  function GetColorPart(Value: Integer): Integer;
  begin
    if Value < 0 then
      Result := 0
    else
    begin
      Value := Value shr 8;
      Result := Min(255, Value);
    end;
  end;

var
  AWeight: Integer;
  AColor: TRGBQuad;
  R, G, B, A: Integer;
  K, I, J: Integer;
begin
  for I := 0 to ASrcSize - 1 do
    for J := 0 to ADestSize - 1 do
      with AContributorList[J] do
      begin
        R := 0; G := 0; B := 0; A := 0;
        for K := 0 to Count - 1 do
        begin
          if AHorizontal then
            AColor := ASource[Contributors[K].Pixel + (I * ASrcLineLength)]
          else
            AColor := ASource[I + (Contributors[K].Pixel * ASrcLineLength)];
          AWeight := Contributors[K].Weight;
          if AWeight = 0 then continue;
          Inc(R, AColor.rgbRed * AWeight);
          Inc(G, AColor.rgbGreen * AWeight);
          Inc(B, AColor.rgbBlue * AWeight);
          Inc(A, AColor.rgbReserved * AWeight);
        end;
        AColor.rgbRed := GetColorPart(R);
        AColor.rgbGreen := GetColorPart(G);
        AColor.rgbBlue := GetColorPart(B);
        AColor.rgbReserved := GetColorPart(A);
        if AHorizontal then
          ADest[J + (I * ADestLineLength)] := AColor
        else
          ADest[I + (J * ADestLineLength)] := AColor;
      end;
  //dispose contributors and source buffer
  for I := 0 to HIGH(AContributorList) do
    AContributorList[I].Contributors := nil;
  AContributorList := nil;
  ASource := nil;
end;

procedure cxSmoothResizeBitmap(ASource, ADestination: TBitmap; AForceUseLanczos3Filter: Boolean = False);
var
  AContributorList: TContributorList;
  ASrcWidth, ASrcHeight, ADestWidth, ADestHeight: Integer;
  ABuffer1, ABuffer2: TRGBColors;
  AOldMode: Cardinal;
  AScale: Single;
begin
  ADestWidth := ADestination.Width;
  ADestHeight := ADestination.Height;
  ASrcWidth := ASource.Width;
  ASrcHeight := ASource.Height;
  if (ADestWidth = 0) or (ADestHeight = 0) or (ASrcWidth = 0) or (ASrcHeight = 0) then Exit;
  ASource.Canvas.Lock;
  ADestination.Canvas.Lock;
  try
    if IsWinNT and not AForceUseLanczos3Filter then
    begin
      AOldMode := SetStretchBltMode(ADestination.Canvas.Handle, HALFTONE);
      StretchBlt(ADestination.Canvas.Handle, 0, 0, ADestWidth, ADestHeight,
        ASource.Canvas.Handle, 0, 0, ASrcWidth, ASrcHeight, srcCopy);
      SetStretchBltMode(ADestination.Canvas.Handle, AOldMode);
    end
    else
    begin
      GetBitmapBits(ASource, ABuffer1, False);
      SetLength(ABuffer2, ADestWidth * ASrcHeight);
      if ASrcWidth = 1 then
        AScale :=  ADestWidth / ASrcWidth
      else
        AScale :=  (ADestWidth - 1) / (ASrcWidth - 1);
      BuildFilter(AContributorList, AScale, ASrcWidth, ADestWidth);
      ApplyFilter(AContributorList, ABuffer1, ASrcHeight, ASrcWidth, ABuffer2, ADestWidth, ADestWidth, True);
      GetBitmapBits(ADestination, ABuffer1, False);
      if (ASrcHeight = 1) or (ADestHeight = 1) then
        AScale :=  ADestHeight / ASrcHeight
      else
        AScale :=  (ADestHeight - 1) / (ASrcHeight - 1);
      BuildFilter(AContributorList, AScale, ASrcHeight, ADestHeight);
      ApplyFilter(AContributorList, ABuffer2, ADestWidth, ADestWidth, ABuffer1, ADestHeight, ADestWidth, False);
      SetBitmapBits(ADestination, ABuffer1, False);
    end;
  finally
    ASource.Canvas.Unlock;
    ADestination.Canvas.Unlock;
  end;
end;

procedure cxStretchBlt(ADestDC, ASrcDC: HDC; const ADestRect, ASrcRect: TRect; ROP: DWORD);
begin
  StretchBlt(ADestDC, ADestRect.Left, ADestRect.Top,
    ADestRect.Right - ADestRect.Left, ADestRect.Bottom - ADestRect.Top,
    ASrcDC, ASrcRect.Left, ASrcRect.Top, ASrcRect.Right - ASrcRect.Left,
    ASrcRect.Bottom - ASrcRect.Top, ROP);
end;

function cxCreateBitmapCopy(ASourceBitmap: TBitmap): TcxAlphaBitmap;
begin
  Result := TcxAlphaBitmap.CreateSize(ASourceBitmap.Width, ASourceBitmap.Height);
  Result.CopyBitmap(ASourceBitmap);
end;

procedure cxMakeColoredBitmap(ABitmap: TBitmap; AColor: TColor);

  procedure CalculateValue(var AValue: Byte; AColorValue, AAlpha: Byte);
  var
    ATemp: Integer;
  begin
    AValue := AValue * 255 div AAlpha;
    ATemp := (AValue - 128) * (AValue - 128);
    if AValue < 128 then
      AValue := AColorValue - AColorValue * ATemp div 16384
    else
      AValue := AColorValue + (255 - AColorValue) * ATemp div 16384;
    AValue := AValue * AAlpha div 255
  end;

var
  AColors: TRGBColors;
  AColorValue: TRGBQuad;
  APixel: PRGBQuad;
  I: Integer;
begin
  AColor := ColorToRGB(AColor);
  AColorValue.rgbRed := GetRValue(AColor);
  AColorValue.rgbGreen := GetGValue(AColor);
  AColorValue.rgbBlue := GetBValue(AColor);

  //#AI: Bitmap must be premultiplied !!
  if GetBitmapBits(ABitmap, AColors, True) then
  begin
    APixel := @AColors[0];
    for I := 0 to Length(AColors) - 1 do
    begin
      if APixel^.rgbReserved > 0 then
      begin
        CalculateValue(APixel^.rgbRed, AColorValue.rgbRed, APixel^.rgbReserved);
        CalculateValue(APixel^.rgbGreen, AColorValue.rgbGreen, APixel^.rgbReserved);
        CalculateValue(APixel^.rgbBlue, AColorValue.rgbBlue, APixel^.rgbReserved);
      end;
      Inc(APixel);
    end;
    SetBitmapBits(ABitmap, AColors, True);
  end;
end;

procedure cxMakeTrueColorBitmap(ASourceBitmap, ATrueColorBitmap: TBitmap);
var
  AcxBitmap, AcxMask: TcxAlphaBitmap;
begin
  AcxBitmap := cxCreateBitmapCopy(ASourceBitmap);
  try
    AcxBitmap.TransformBitmap(btmSetOpaque);
    AcxMask := cxCreateBitmapCopy(ASourceBitmap);
    try
      AcxMask.TransparentPixels.Add(ASourceBitmap.TransparentColor);
      AcxMask.TransformBitmap(btmMakeMask);
      AcxBitmap.Filter(AcxMask);
      ATrueColorBitmap.Assign(AcxBitmap);
    finally
      AcxMask.Free;
    end;
  finally
    AcxBitmap.Free;
  end;
end;

procedure cxMakeMaskBitmap(ASourceBitmap, AMaskBitmap: TBitmap);
var
  ABitmap: TcxAlphaBitmap;
begin
  ABitmap := cxCreateBitmapCopy(ASourceBitmap);
  try
    if not ABitmap.IsAlphaUsed then
      ABitmap.RecoverAlphaChannel(ASourceBitmap.TransparentColor);
    ABitmap.TransformBitmap(btmMakeMask);
    cxBitBlt(AMaskBitmap.Canvas.Handle, ABitmap.Canvas.Handle, ABitmap.ClientRect, cxNullPoint, SRCCOPY);
  finally
    ABitmap.Free;
  end;
end;

{!!! TODO: adapt to .net}

function cxGetCursorSize: TSize;
var
  IconInfo: TIconInfo;
  BitmapInfoSize, BitmapBitsSize, ImageSize: DWORD;
  Bitmap: PBitmapInfoHeader;
  Bits: Pointer;
  BytesPerScanline: Integer;

  function FindScanline(Source: Pointer; MaxLen: Cardinal;
    Value: Cardinal): Cardinal; assembler;
  asm
    PUSH    ECX
    MOV     ECX,EDX
    MOV     EDX,EDI
    MOV     EDI,EAX
    POP     EAX
    REPE    SCASB
    MOV     EAX,ECX
    MOV     EDI,EDX
  end;

begin
  { Default value is entire icon height }
  Result.cy := GetSystemMetrics(SM_CYCURSOR);
  Result.cx := GetSystemMetrics(SM_CXCURSOR);

  if GetIconInfo(GetCursor, IconInfo) then
  try
    GetDIBSizes(IconInfo.hbmMask, BitmapInfoSize, BitmapBitsSize);
    Bitmap := AllocMem(DWORD(BitmapInfoSize) + BitmapBitsSize);
    try
    Bits := Pointer(DWORD(Bitmap) + BitmapInfoSize);
    if GetDIB(IconInfo.hbmMask, 0, Bitmap^, Bits^) and
      (Bitmap^.biBitCount = 1) then
    begin
      { Point Bits to the end of this bottom-up bitmap }
      with Bitmap^ do
      begin
        Result.cx := biWidth;
        BytesPerScanline := ((biWidth * biBitCount + 31) and not 31) div 8;
        ImageSize := biWidth * BytesPerScanline;
        Bits := Pointer(DWORD(Bits) + BitmapBitsSize - ImageSize);
        { Use the width to determine the height since another mask bitmap
          may immediately follow }
        Result.cy := FindScanline(Bits, ImageSize, $FF);
        { In case the and mask is blank, look for an empty scanline in the
          xor mask. }
        if (Result.cy = 0) and (biHeight >= 2 * biWidth) then
          Result.cy := FindScanline(Pointer(DWORD(Bits) - ImageSize),
          ImageSize, $00);
        Result.cy := Result.cy div BytesPerScanline;
      end;
      Dec(Result.cy, IconInfo.yHotSpot);
    end;
    finally
      FreeMem(Bitmap);
    end;
  finally
    if IconInfo.hbmColor <> 0 then DeleteObject(IconInfo.hbmColor);
    if IconInfo.hbmMask <> 0 then DeleteObject(IconInfo.hbmMask);
  end;
end;

procedure cxAlphaBlend(ASource: TBitmap; ARect: TRect;
  const ASelColor: TColor; Alpha: Byte = 170);
var
  ARow, ACol: Integer;
  SrcLine: Pointer;
  C1, C2: Double;
  AColorValues: array[0..3] of Byte;
  P: TPoint;
begin
  C1 := Alpha / 255;
  C2 := 1.0 - C1;
  AColorValues[0] := Round(GetBValue(ASelColor) * C1);
  AColorValues[1] := Round(GetGValue(ASelColor) * C1);
  AColorValues[2] := Round(GetRValue(ASelColor) * C1);
  AColorValues[3] := 0;
  GetWindowOrgEx(ASource.Canvas.Handle, P);
  OffsetRect(ARect, -P.X, -P.Y);
  for ARow := Max(ARect.Top, 0) to Min(ARect.Bottom, ASource.Height - 1) do
  begin
    SrcLine := ASource.ScanLine[ARow];
    ACol := Max(0, ARect.Left * 4);
    while ACol < Min(ARect.Right * 4, ASource.Width * 4 - 1) do
    begin
      WriteByte(SrcLine, AColorValues[ACol mod 4] + Round(ReadByte(SrcLine, ACol) * C2), ACol);
      Inc(ACol);
    end;
  end;
end;

procedure cxAlphaBlend(
  ADest, ABkSource, ASource: TBitmap; Alpha: Byte = cxDefaultAlphaValue);

  function SystemAlphaPaint: Boolean;
  var
    ABlendFunction: TBlendFunction;
  begin
    if CanApplySystemAlphaBlending then
    begin
      ABlendFunction := DefaultBlendFunction;
      ABlendFunction.SourceConstantAlpha := Alpha;
      with ADest do
      begin
        Canvas.Draw(0, 0, ABkSource); //      Assign(ABkSource); todo: graphics bug image not copying but _AddRef called
        Result := VCLAlphaBlend(Canvas.Handle,
          0, 0, Width, Height, ASource.Canvas.Handle, 0, 0, Width, Height, ABlendFunction);
      end;
    end
    else
      Result := False;
  end;

  procedure AlphaPaint;
  var
    ACount, K: Integer;
    DstLine, BkSrcLine, SrcLine: Pointer;
    C1, C2: Double;
  begin
    C1 := Alpha / 255;
    C2 := 1.0 - C1;
    with ASource do
    begin
      K := Height;
      ACount := ((Width * 24 + 31) and not 31) shr 3 * K;
    end;
    BkSrcLine := ABkSource.ScanLine[K - 1];
    SrcLine := ASource.ScanLine[K - 1];
    DstLine := ADest.ScanLine[K - 1];
    for K := 0 to ACount - 1 do
      WriteByte(DstLine,
        Round(ReadByte(SrcLine, K) * C1) + Round(ReadByte(BkSrcLine, K) * C2), K);
  end;

  procedure DoAlphaPaint;
  begin
    if GetDeviceCaps(cxScreenCanvas.Handle, BITSPIXEL) in [16, 24, 32] then
      AlphaPaint
    else
      ADest.Canvas.Draw(0, 0, ASource); // .Assign(ASource);
    cxScreenCanvas.Dormant;
  end;

begin
  if not SystemAlphaPaint then DoAlphaPaint;
end;

procedure cxApplyViewParams(ACanvas: TcxCanvas;
  const AViewParams: TcxViewParams);
begin
  with ACanvas do
  begin
    Font := AViewParams.Font;
    Font.Color := AViewParams.TextColor;
    Brush.Color := AViewParams.Color;
  end;
end;

procedure cxCopyImage(ASource, ADest: TBitmap;
  const ASrcOffset, ADstOffset: TPoint; const ARect: TRect);
var
  ADstRect, ASrcRect: TRect;
begin
  ADstRect := ARect;
  ASrcRect := ARect;
  OffsetRect(ASrcRect, ASrcOffset.X, ASrcOffset.Y);
  OffsetRect(ADstRect, ADstOffset.X, ADstOffset.Y);
  ADest.Canvas.CopyRect(ASrcRect, ASource.Canvas, ADstRect);
end;

procedure cxCopyImage(ASource, ADest: TCanvas;
  const ASrcOffset, ADstOffset: TPoint; const ARect: TRect);
var
  ADstRect, ASrcRect: TRect;
begin
  ADstRect := ARect;
  ASrcRect := ARect;
  OffsetRect(ASrcRect, ASrcOffset.X, ASrcOffset.Y);
  OffsetRect(ADstRect, ADstOffset.X, ADstOffset.Y);
  ADest.CopyRect(ADstRect, ASource, ASrcRect);
end;

procedure cxDrawArrows(ACanvas: TCanvas; const ARect: TRect;
  ASide: TcxBorder; AColor: TColor; APenColor: TColor = clDefault);
type
  TArrowPolygon = array[0..6] of TPoint;
var
  ArrowRgns: array[0..1, 0..6, 0..1] of Integer;
  BaseLine: array[0..1, 0..1] of Integer;
  I, J, K: Integer;
begin
  with ARect do
  begin
    BaseLine[0, 0] := Left;
    BaseLine[0, 1] := Top;
    BaseLine[1, 0] := Right;
    BaseLine[1, 1] := Bottom;
  end;
  if ASide in [bLeft, bBottom] then
  begin
    BaseLine[Byte(ASide = bLeft), 0] := ARect.Left;
    BaseLine[Byte(ASide = bLeft), 1] := ARect.Bottom;
  end
  else
  begin
    BaseLine[Byte(ASide = bTop), 0] := ARect.Right;
    BaseLine[Byte(ASide = bTop), 1] := ARect.Top;
  end;
  Move(BaseRgns[Byte(ASide in [bTop, bBottom]) shl 1], ArrowRgns, SizeOf(ArrowRgns));
  for I := 0 to 1 do
    for J := 0 to 6 do
      for K := 0 to 1 do
        Inc(ArrowRgns[I, J, K], BaseLine[I, K]);
  ACanvas.Brush.Color := AColor;
  if APenColor = clDefault then
    ACanvas.Pen.Color := $FFFFFF xor ColorToRgb(AColor)
  else
    ACanvas.Pen.Color := APenColor;
  for I := 0 to 1 do
    ACanvas.Polygon(TArrowPolygon(ArrowRgns[I]));
end;

procedure cxFillHalfToneRect(
  Canvas: TCanvas; const ARect: TRect; ABkColor, AColor: TColor);
begin
  with Canvas do
  begin
    ABkColor := SetBkColor(Handle, ColorToRgb(ABkColor));
    AColor := SetTextColor(Handle, ColorToRgb(AColor));
    Windows.FillRect(Handle, ARect, cxHalfToneBrush.Handle);
    SetBkColor(Handle, ABkColor);
    SetTextColor(Handle, AColor);
  end;
end;

procedure cxSetCanvasOrg(ACanvas: TCanvas; var AOrg: TRect);
begin
  with AOrg do
    SetWindowOrgEx(ACanvas.Handle, Left, Top, @TopLeft);
end;

function cxGetTextExtentPoint32(ADC: THandle; const AText: string; out ASize: TSize; ACharCount: Integer = -1): Boolean;
begin
  if ACharCount = -1 then
    ACharCount := Length(AText);
  Result := GetTextExtentPoint32(ADC, PChar(AText), ACharCount, ASize);
end;

{TODO:
procedure cxGetTextLines(const AText: string; ACanvas: TcxCanvas;
  const ARect: TRect; ALines: TStrings);
var
  ATextRows: TcxTextRows;
  ATextParams: TcxTextParams;
  I, ACount, ALen: Integer;
  S: WideString;
begin
  ATextParams := cxCalcTextParams(ACanvas.Handle, CXTO_WORDBREAK or CXTO_CALCROWCOUNT);
  cxMakeTextRows(ACanvas.Handle, PChar(AText), Length(AText), ARect, ATextParams, ATextRows, ACount);
  for I := 0 to ACount - 1 do
  begin
    ALen := cxGetTextRow(ATextRows, I).TextLength;
    SetString(S, cxGetTextRow(ATextRows, I).Text, ALen);
    if (ALen > 0) and ((S[ALen] = ' ') or (S[ALen] = #9)) then
      SetLength(S, ALen - 1);
    ALines.Add(dxWideStringToString(S));
  end;
  cxResetTextRows(ATextRows);
end;
}

type
  TcxPosition = record
    Start: Integer;
    Finish: Integer;
  end;

procedure cxGetTextLines(const AText: string; ACanvas: TcxCanvas; const ARect: TRect; ALines: TStrings);

  function IsNewLineSymbol(const AWideText: WideString; AIndex: Integer): Boolean;
  begin
    Result := (AWideText[AIndex] = #13) or (AWideText[AIndex] = #10);
  end;

  procedure GetNextWordPos(const AWideText: WideString; ALength: Integer; const ACurrentWord: TcxPosition; var ANextWord: TcxPosition);

    function IsDelimiter(AIndex: Integer): Boolean;
    begin
      Result := (AWideText[AIndex] = ' ') or (AWideText[AIndex] = #9) or
        IsNewLineSymbol(AWideText, AIndex);
    end;

    function IsDoubleDelimiter(AIndex: Integer): Boolean;
    begin
      Result := (AIndex > 1) and IsDelimiter(AIndex) and IsDelimiter(AIndex - 1);
    end;

    function IsWordStart(AIndex: Integer): Boolean;
    begin
      Result := not IsDelimiter(AIndex);
    end;

    function IsWordEnd(AIndex: Integer): Boolean;
    begin
      Result := IsDelimiter(AIndex);
    end;

  var
    ACharPos: Integer;
  begin
    ANextWord.Start := ACurrentWord.Finish + 1;

    while (ANextWord.Start < ALength) and not IsWordStart(ANextWord.Start) and not IsDoubleDelimiter(ANextWord.Start) do
      Inc(ANextWord.Start);
    ACharPos := ANextWord.Start;
    while (ACharPos + 1 <= ALength) and not IsWordEnd(ACharPos + 1) and not IsDoubleDelimiter(ACharPos) do
      Inc(ACharPos);
    ANextWord.Finish := ACharPos;
  end;

  procedure FindNextWordStart(const AWideText: WideString; var ALineStart: Integer; var ANextWord: TcxPosition);
  begin
    while IsNewLineSymbol(AWideText, ALineStart) do
      Inc(ALineStart);
    ANextWord.Start := ALineStart;
  end;

  function CheckNewLineSymbol(const AWideText: WideString; var ANextWord: TcxPosition; var ALineStart: Integer): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := ALineStart to ANextWord.Finish do
      if IsNewLineSymbol(AWideText, I) then
      begin
        ALines.Add(dxWideStringToString(Copy(AWideText, ALineStart, I - ALineStart)));
        ALineStart := I + 1;
        FindNextWordStart(AWideText, ALineStart, ANextWord);
        Result := True;
        Break;
      end;
  end;

var
  AWideText: WideString;
  ADrawText: string;
  ACurrentWord, ANextWord: TcxPosition;
  ALineStart, ALength, ARectWidth: Integer;
begin
  if AText = '' then Exit;
  ARectWidth := cxRectWidth(ARect);
  ACurrentWord.Finish := 0;
  ALineStart := 1;
  AWideText := dxStringToWideString(AText);
  ALength := Length(AWideText);
  repeat
    GetNextWordPos(AWideText, ALength, ACurrentWord, ANextWord);

    ADrawText := Copy(AWideText, ALineStart, ANextWord.Finish - ALineStart + 1);
    if not CheckNewLineSymbol(AWideText, ANextWord, ALineStart) then
      if cxTextSize(ACanvas.Handle, ADrawText).cx > ARectWidth then
      begin
        ALines.Add(dxWideStringToString(Copy(AWideText, ALineStart, ACurrentWord.Finish - ALineStart + 1)));
        ALineStart := ANextWord.Start;
        FindNextWordStart(AWideText, ALineStart, ANextWord);
      end;
    ACurrentWord := ANextWord;
  until ACurrentWord.Finish >= ALength;
  ALines.Add(dxWideStringToString(Copy(AWideText, ALineStart, ALength)));
end;

function cxDrawText(ADC: THandle; const AText: string; var ARect: TRect;
  AFormat: UINT; ACharCount: Integer = - 1; ATextColor: TColor = clDefault; ABkMode: Integer = TRANSPARENT): Integer;
var
  APrevColor, APrevBkMode: Cardinal;
begin
  if ATextColor <> clDefault then
    APrevColor := SetTextColor(ADC, ColorToRGB(ATextColor))
  else
    APrevColor := 0; // to make compiler happy
  APrevBkMode := SetBkMode(ADC, ABkMode);
  Result := Windows.DrawText(ADC, PChar(AText), ACharCount, ARect, AFormat);
  SetBkMode(ADC, APrevBkMode);
  if ATextColor <> clDefault then
    SetTextColor(ADC, APrevColor);
end;

function cxDrawText(ACanvas: TCanvas; const AText: string; ARect: TRect;
  AFormat: UINT; ATextColor: TColor = clDefault): Integer;
begin
  Result := cxDrawText(ACanvas.Handle, AText, ARect, AFormat, -1, ATextColor);
end;

function cxDrawText(ACanvas: TcxCanvas; const AText: string; const ARect: TRect;
  AFormat: UINT; ATextColor: TColor = clDefault; ARotationAngle: TcxRotationAngle = ra0): Integer;
const
  AAntiRotationMap: array[TcxRotationAngle] of TcxRotationAngle = (ra0, raMinus90, raPlus90, ra180);
var
  ABitmap: TcxBitmap;
begin
  if ARotationAngle = ra0 then
    Result := cxDrawText(ACanvas.Canvas, AText, ARect, AFormat, ATextColor)
  else
  begin
    ABitmap := TcxBitmap.CreateSize(ARect, pf32bit);
    try
      cxBitBlt(ABitmap.Canvas.Handle, ACanvas.Handle, ABitmap.ClientRect, ARect.TopLeft, SRCCOPY);
      ABitmap.Rotate(AAntiRotationMap[ARotationAngle]);
      ABitmap.Canvas.Font.Assign(ACanvas.Font);
      Result := cxDrawText(ABitmap.Canvas, AText, ABitmap.ClientRect, AFormat, ATextColor);
      ABitmap.Rotate(ARotationAngle);
      cxBitBlt(ACanvas.Handle, ABitmap.Canvas.Handle, ARect, cxNullPoint, SRCCOPY);
    finally
      ABitmap.Free;
    end;
  end;
end;

function cxExtTextOut(ADC: THandle; const AText: string; const APoint: TPoint;
  const ARect: TRect; AOptions: UINT; ACharCount: Integer = -1): Boolean;
begin
 if ACharCount = -1 then
   ACharCount := Length(AText);
  Result := ExtTextOut(ADC, APoint.X, APoint.Y, AOptions,
    @ARect, PChar(AText), ACharCount, nil);
end;

function cxExtTextOut(ADC: THandle; const AText: string; const APoint: TPoint;
  AOptions: UINT; ACharCount: Integer = -1): Boolean; overload;
begin
 if ACharCount = -1 then
   ACharCount := Length(AText);
  Result := ExtTextOut(ADC, APoint.X, APoint.Y, AOptions,
    nil, PChar(AText), ACharCount, nil);
end;

procedure cxInvalidateRect(AHandle: THandle; const ARect: TRect; AEraseBackground: Boolean = True);
begin
  InvalidateRect(AHandle, @ARect, AEraseBackground);
end;

procedure cxInvalidateRect(AHandle: THandle; AEraseBackground: Boolean = True);
begin
  InvalidateRect(AHandle, nil, AEraseBackground);  
end;

function cxTextHeight(AFont: TFont; const S: string = 'Wg'; AFontSize: Integer = 0): Integer;
begin
  Result := cxTextExtent(AFont, S, AFontSize).cy;
end;

function cxTextWidth(AFont: TFont; const S: string; AFontSize: Integer = 0): Integer;
begin
  Result := cxTextExtent(AFont, S, AFontSize).cx;
end;

function cxTextExtent(AFont: TFont; const S: string; AFontSize: Integer = 0): TSize;
begin
  with cxScreenCanvas do
  begin
    Font.Assign(AFont);
    if AFontSize <> 0 then Font.Size := AFontSize;
    Result := TextExtent(S);
    Dormant;
  end;
end;

function cxTextSize(ADC: THandle; const AText: string): TSize; // differs from cxTextExtent
var
  ARect: TRect;
begin
  ARect := cxGetTextRect(ADC, AText, 1);
  Result := Size(ARect.Right, ARect.Bottom);
end;

function cxGetTextRect(ADC: THandle; const AText: string; ARowCount: Integer; AReturnMaxRectHeight: Boolean = False): TRect;
const
  DT_NOFULLWIDTHCHARBREAK = $80000;
  SingleLineTextFlag = DT_SINGLELINE or DT_CALCRECT;
  MultiLineTextFlag = DT_WORDBREAK or DT_NOFULLWIDTHCHARBREAK or DT_CALCRECT;

  function GetMaxWidth: Integer;
  var
    R: TRect;
  begin
    R := cxEmptyRect;
    cxDrawText(ADC, AText, R, SingleLineTextFlag);
    Result := R.Right;
  end;

  function GetMinWidth: Integer;
  var
    R: TRect;
  begin
    R := Rect(0, 0, 1, 1);
    cxDrawText(ADC, AText, R, MultiLineTextFlag);
    Result := R.Right;
  end;

  function GetTextSize(AWidth: Integer): TRect;
  begin
    Result := Rect(0, 0, AWidth, 1);
    cxDrawText(ADC, AText, Result, MultiLineTextFlag);
  end;

var
  AMaxTextHeight, AMaxWidth, AMinWidth, AWidth: Integer;
begin
  Result := cxEmptyRect;
  if ARowCount = 1 then
    cxDrawText(ADC, AText, Result, SingleLineTextFlag)
  else
  begin
    if ARowCount <= 0 then
      AMaxTextHeight := 32000
    else
      AMaxTextHeight := cxTextSize(ADC, 'Wg').cy * ARowCount;
    AMinWidth := GetMinWidth;
    AMaxWidth := GetMaxWidth;
    AWidth := (AMinWidth + AMaxWidth) div 2;
    while AMaxWidth - AMinWidth > 1 do
    begin
      if GetTextSize(AWidth).Bottom > AMaxTextHeight then
        AMinWidth := AWidth
      else
        AMaxWidth := AWidth;
      AWidth := (AMinWidth + AMaxWidth) div 2;
    end;
    Result := GetTextSize(AMinWidth);
    if Result.Bottom > AMaxTextHeight then
      Result := GetTextSize(AMaxWidth);
    if AReturnMaxRectHeight then
      Result.Bottom := AMaxTextHeight;
  end;
end;

function cxGetTextRect(AFont: TFont; const AText: string; ARowCount: Integer): TRect;
begin
  cxScreenCanvas.Font := AFont;
  Result := cxGetTextRect(cxScreenCanvas.Handle, AText, ARowCount);
  cxScreenCanvas.Dormant;
end;

function cxGetStringAdjustedToWidth(ADC: HDC; AFontHandle: HFONT; const S: string; AWidth: Integer; AModifyStringType: TcxModifyStringType): string; overload;
const
  AModifyStringMap: array [TcxModifyStringType] of DWORD = (DT_END_ELLIPSIS, DT_PATH_ELLIPSIS);
var
  ABuffer: packed array[0..4095] of Char;
  R: TRect;
  ACalcDC: HDC;
begin
  if (Length(S) = 0) or (AWidth < 1) then
  begin
    Result := '';
    Exit;
  end;
  FillChar(ABuffer, SizeOf(ABuffer), 0);
  StrPLCopy(ABuffer, S, Length(S));
  R := Rect(0, 0, AWidth, 32);
  if ADC = 0 then ACalcDC := GetDC(0) else ACalcDC := ADC;
  if AFontHandle <> 0 then
    SelectObject(ACalcDC, AFontHandle);
  DrawText(ACalcDC, @ABuffer[0], -1, // D12 DrawText(ACalcDC, ABuffer, -1,
    R, DT_SINGLELINE or DT_CALCRECT or DT_MODIFYSTRING or AModifyStringMap[AModifyStringType]);
  Result := ABuffer;
  if ADC = 0 then ReleaseDC(0, ACalcDC);
end;

function cxGetStringAdjustedToWidth(AFont: TFont; const S: string; AWidth: Integer; AModifyStringType: TcxModifyStringType): string; overload;
begin
  Result := cxGetStringAdjustedToWidth(0, AFont.Handle, S, AWidth, AModifyStringType);
end;

function cxCompareBitmaps(ABitmap1, ABitmap2: TBitmap): Boolean;

  function CompareByBitmapBits: Boolean;
  var
    AColors1, AColors2: TRGBColors;
  begin
    GetBitmapBits(ABitmap1, AColors1, True);
    GetBitmapBits(ABitmap2, AColors2, True);
    Result := CompareMem(@AColors1[0], @AColors2[0], Length(AColors1) * 4);
  end;

var
  AHeight: Integer;
begin
  Result := (ABitmap1 <> nil) and (ABitmap2 <> nil) and
    (ABitmap1.Width = ABitmap2.Width) and (ABitmap1.Height = ABitmap2.Height) and
    (cxGetBitmapPixelFormat(ABitmap1) = cxGetBitmapPixelFormat(ABitmap2));
  if Result then
  begin
    AHeight := ABitmap2.Height;
    Result := CompareMem(ABitmap1.ScanLine[AHeight - 1], ABitmap2.ScanLine[AHeight - 1],
      ABitmap2.Height * ABitmap2.Width * cxGetBitmapPixelFormat(ABitmap2) div 8);
    Result := Result or CompareByBitmapBits;
  end;
end;

function cxGetBitmapData(ABitmapHandle: HBITMAP; out ABitmapData: Windows.TBitmap): Boolean;
begin
  Result := GetObject(ABitmapHandle, SizeOf(Windows.TBitmap), @ABitmapData) <> 0;
end;

function cxGetBrushData(ABrushHandle: HBRUSH; out ALogBrush: TLogBrush): Boolean;
begin
  Result := GetObject(ABrushHandle, SizeOf(TLogBrush), @ALogBrush) <> 0;
end;

function cxGetBrushData(ABrushHandle: HBRUSH): TLogBrush;
begin
  cxGetBrushData(ABrushHandle, Result);
end;

function cxGetFontData(AFontHandle: HFONT; out ALogFont: TLogFont): Boolean;
begin
  Result := GetObject(AFontHandle, SizeOf(TLogFont), @ALogFont) <> 0;
end;

function cxGetPenData(APenHandle: HPEN; out ALogPen: TLogPen): Boolean;
begin
  Result := GetObject(APenHandle, SizeOf(TLogPen), @ALogPen) <> 0;
end;

function cxGetWritingDirection(AFontCharset: TFontCharset; const AText: string): TCanvasOrientation;

  function IsStandardASCIIChar: Boolean;
  begin
    Result := (Length(AText) > 0)  and (Ord(AText[1]) < 128) {$IFNDEF DELPHI12} and (cxStrCharLength(AText) = 1) {$ENDIF};
  end;

begin
  if AFontCharset = DEFAULT_CHARSET then
    AFontCharset := GetDefFontCharset;
  if not IsStandardASCIIChar and (AFontCharset in [ARABIC_CHARSET, CHINESEBIG5_CHARSET, GB2312_CHARSET]) then
    Result := coRightToLeft
  else
    Result := coLeftToRight;
end;

procedure cxDrawThemeParentBackground(AControl: TWinControl; ACanvas: TcxCanvas; const ARect: TRect);
var
  AHandle: THandle;
begin
  AHandle := ACanvas.Handle;
  if AControl.Parent.DoubleBuffered or not IsThemeLibraryLoaded then
    cxDrawTransparentControlBackground(AControl, ACanvas, ARect, False)
  else
    DrawThemeParentBackground(AControl.Handle, ACanvas.Handle, ARect);
  dxTestCheck(AHandle = ACanvas.Handle, 'cxDrawThemeParentBackground fails');
end;

procedure cxDrawThemeParentBackground(
  AControl: TWinControl; ACanvas: TCanvas; const ARect: TRect);
var
  AcxCanvas: TcxCanvas;
begin
  AcxCanvas := TcxCanvas.Create(ACanvas);
  try
    cxDrawThemeParentBackground(AControl, AcxCanvas, ARect);
  finally
    AcxCanvas.Free;
  end;
end;

procedure cxPaintControlTo(ADrawControl: TWinControl; ACanvas: TcxCanvas;
  const ACanvasOffset, AWindowOffset: TPoint; ADrawRect: TRect;
  ADrawEdgesAndBorders, AConsiderWindowRegion: Boolean; ASkipControls: TList;
  APaintParentWithChildren: Boolean = True);

  procedure DrawEdgesAndBorders;
  var
    AEdgeFlags, ABorderFlags: Integer;
    ABorderRect: TRect;
    P: TPoint;
  begin
    ABorderFlags := 0;
    AEdgeFlags := 0;
    if GetWindowLong(ADrawControl.Handle, GWL_EXSTYLE) and WS_EX_CLIENTEDGE <> 0 then
    begin
      AEdgeFlags := EDGE_SUNKEN;
      ABorderFlags := BF_RECT or BF_ADJUST
    end
    else
      if GetWindowLong(ADrawControl.Handle, GWL_STYLE) and WS_BORDER <> 0 then
      begin
        AEdgeFlags := BDR_OUTER;
        ABorderFlags := BF_RECT or BF_ADJUST or BF_MONO;
      end;
    if ABorderFlags <> 0 then
    begin
      ABorderRect := Rect(0, 0, ADrawControl.Width, ADrawControl.Height);
      P := cxPointOffset(ADrawControl.BoundsRect.TopLeft, ACanvasOffset, False);
      ABorderRect := cxRectOffset(ABorderRect, P);
      DrawEdge(ACanvas.Handle, ABorderRect, AEdgeFlags, ABorderFlags);
      ACanvas.SetClipRegion(TcxRegion.Create(ABorderRect), roIntersect);
      MoveWindowOrg(ACanvas.Handle, ABorderRect.Left, ABorderRect.Top);
    end;
  end;

  procedure ConsiderWindowRegion(ACanvas: TcxCanvas);
  var
    AWindowRegion: TcxRegion;
    AWindowRect: TRect;
    AClientOffset: TPoint;
  begin
    if ADrawControl.HandleAllocated then
    begin
      AWindowRegion := TcxRegion.Create;
      try
        if GetWindowRgn(ADrawControl.Handle, AWindowRegion.Handle) in [SIMPLEREGION, COMPLEXREGION] then
        begin
          AWindowRect := cxGetWindowRect(ADrawControl);
          AClientOffset := cxPointOffset(ADrawControl.ClientToScreen(cxNullPoint), AWindowRect.TopLeft, False);
          ACanvas.SetClipRegion(AWindowRegion, roIntersect, False);
        end;
      finally
        AWindowRegion.Free;
      end;
    end;
  end;

  procedure PaintChildTo(AChildControl: TWinControl);
  var
    P: TPoint;
    ABoundsRect, ADrawRect: TRect;
  begin
    P := ADrawControl.ScreenToClient(AChildControl.ClientToScreen(cxNullPoint));
    ABoundsRect := AChildControl.BoundsRect;
    ADrawRect := cxRectOffset(ABoundsRect, P, False);
    cxPaintControlTo(AChildControl, ACanvas, P, ABoundsRect.TopLeft,
      ADrawRect, True, AConsiderWindowRegion, ASkipControls, APaintParentWithChildren);
  end;

  procedure PaintChilds(ADrawControl: TWinControl);
  var
    AChildControl: TControl;
    I: Integer;
  begin
    for I := 0 to ADrawControl.ControlCount - 1 do
    begin
      AChildControl := ADrawControl.Controls[I];
      if (ASkipControls <> nil) and (ASkipControls.IndexOf(AChildControl) <> -1) then
        Break;
      if (AChildControl is TWinControl) and TWinControl(AChildControl).Visible then
        PaintChildTo(TWinControl(AChildControl));
    end;
  end;

var
  AIntf: IcxPaintControlsHelper;
  ASaveControlState: TControlState;
begin
  if csDestroying in ADrawControl.ComponentState then Exit;

  ACanvas.SaveDC;
  try
    MoveWindowOrg(ACanvas.Handle, ACanvasOffset.X, ACanvasOffset.Y);
    if not RectVisible(ACanvas.Handle, ADrawRect) then Exit;

    ASaveControlState := ADrawControl.ControlState;
    ADrawControl.ControlState := ADrawControl.ControlState + [csPaintCopy];
    try
      if ADrawEdgesAndBorders and (not Supports(ADrawControl, IcxPaintControlsHelper, AIntf) or AIntf.AllowDrawEdgesAndBorders) then
        DrawEdgesAndBorders;
      if AConsiderWindowRegion then
        ConsiderWindowRegion(ACanvas);
      ACanvas.SetClipRegion(TcxRegion.Create(ADrawRect), roIntersect);

      ADrawControl.Perform(WM_ERASEBKGND, ACanvas.Handle, ACanvas.Handle);
      ADrawControl.Perform(WM_PAINT, ACanvas.Handle, 0);

      if APaintParentWithChildren then
        PaintChilds(ADrawControl);
    finally
      ADrawControl.ControlState := ASaveControlState;
    end;
  finally
    ACanvas.RestoreDC;
  end;
end;

procedure cxDrawTransparentControlBackground(AControl: TWinControl;
  ACanvas: TcxCanvas; ARect: TRect; APaintParentWithChildren: Boolean = True);
var
  AList: TList;
begin
  if (AControl <> nil) and (AControl.Parent <> nil) then
  begin
    ARect := cxRectOffset(ARect, AControl.BoundsRect.TopLeft);
    AList := TList.Create;
    try
      AList.Add(AControl);
      cxPaintControlTo(AControl.Parent, ACanvas, cxPointInvert(ARect.TopLeft),
        cxPointInvert(AControl.BoundsRect.TopLeft), ARect, False, True, AList,
        APaintParentWithChildren);
    finally
      AList.Free;
    end;
  end;
end;

procedure cxDrawTransparentControlBackground(AControl: TWinControl;
  ACanvas: TCanvas; const ARect: TRect; APaintParentWithChildren: Boolean = True);
var
  AcxCanvas: TcxCanvas;
begin
  AcxCanvas := TcxCanvas.Create(ACanvas);
  try
    cxDrawTransparentControlBackground(AControl, AcxCanvas, ARect, APaintParentWithChildren);
  finally
    AcxCanvas.Free;
  end;
end;

procedure cxDrawTransparentControlBackground(AControl: TWinControl;
  ACanvas: TcxCanvas; const ASourceRect: TRect; const ADestinationPoint: TPoint; APaintParentWithChildren: Boolean = True);
begin
  MoveWindowOrg(ACanvas.Handle, ADestinationPoint.X, ADestinationPoint.Y);
  try
    cxDrawTransparentControlBackground(AControl, ACanvas, ASourceRect, APaintParentWithChildren);
  finally
    MoveWindowOrg(ACanvas.Handle, -ADestinationPoint.X, -ADestinationPoint.Y);
  end;
end;

procedure cxPaintTo(ASourceControl: TWinControl; ADestinationCanvas: TcxCanvas;
  const ADestinationPoint: TPoint; const ASourceRect: TRect; AConsiderSourceControlWindowRegion: Boolean = True);
begin
  MoveWindowOrg(ADestinationCanvas.Handle, -ASourceRect.Left, -ASourceRect.Top);
  cxPaintControlTo(ASourceControl, ADestinationCanvas, ADestinationPoint, cxNullPoint, ASourceRect,
    True, AConsiderSourceControlWindowRegion, nil);
end;

procedure cxResetFont(const AFont: TFont);
begin
  AFont.Charset := DefFontData.Charset;
  AFont.Name := dxShortStringToString(DefFontData.Name);
  AFont.Height := DefFontData.Height;
  AFont.Pitch := DefFontData.Pitch;
  AFont.Style := DefFontData.Style;
end;

{ TcxRegion }

constructor TcxRegion.Create(AHandle: TcxRegionHandle);
begin
  inherited Create;
  FHandle := AHandle;
end;

constructor TcxRegion.Create(const ABounds: TRect);
var
  AHandle: TcxRegionHandle;
begin
  AHandle := CreateRectRgnIndirect(ABounds);
  Create(AHandle);
end;

constructor TcxRegion.Create;
begin
  Create(0, 0, 0, 0);
end;

constructor TcxRegion.Create(ALeft, ATop, ARight, ABottom: Integer);
begin
  Create(Rect(ALeft, ATop, ARight, ABottom));
end;

constructor TcxRegion.CreateRoundCorners(const ABounds: TRect; AWidthEllepse, AHeightEllepse: Integer);
begin
  CreateRoundCorners(ABounds.Left, ABounds.Top, ABounds.Right, ABounds.Bottom, AWidthEllepse, AHeightEllepse);
end;

constructor TcxRegion.CreateRoundCorners(ALeft, ATop, ARight, ABottom, AWidthEllepse, AHeightEllepse: Integer);
var
  AHandle: TcxRegionHandle;
begin
  AHandle := CreateRoundRectRgn(ALeft + 1, ATop + 1, ARight, ABottom, AWidthEllepse, AHeightEllepse);
  Create(AHandle);
end;

destructor TcxRegion.Destroy;
begin
  DestroyHandle;
  inherited;
end;

function TcxRegion.GetBoundsRect: TRect;
begin
  if GetRgnBox(FHandle, Result) = NULLREGION then
    Result := cxNullRect;
end;

function TcxRegion.GetIsEmpty: Boolean;
var
  R: TRect;
begin
  Result := GetRgnBox(FHandle, R) = NULLREGION;
end;

procedure TcxRegion.DestroyHandle;
begin
  if FHandle <> 0 then
  begin
    DeleteObject(FHandle);
    FHandle := 0;
  end;
end;

procedure TcxRegion.Combine(ARegion: TcxRegion; AOperation: TcxRegionOperation;
  ADestroyRegion: Boolean = True);
const
  Modes: array[TcxRegionOperation] of Integer = (RGN_COPY, RGN_OR, RGN_DIFF, RGN_AND);
begin
  if AOperation = roSet then
    CombineRgn(FHandle, ARegion.Handle, 0, Modes[AOperation])
  else
    CombineRgn(FHandle, FHandle, ARegion.Handle, Modes[AOperation]);
  if ADestroyRegion then ARegion.Free;
end;

function TcxRegion.IsEqual(ARegion: TcxRegion): Boolean;
begin
  Result := (ARegion <> nil) and ((IsEmpty and ARegion.IsEmpty) or IsEqual(ARegion.Handle));
end;

function TcxRegion.IsEqual(ARegionHandle: TcxRegionHandle): Boolean;
begin
  Result := EqualRgn(Handle, ARegionHandle);
end;

procedure TcxRegion.Offset(const P: TPoint);
begin
  Offset(P.X, P.Y);
end;

procedure TcxRegion.Offset(DX, DY: Integer);
begin
  OffsetRgn(FHandle, DX, DY);
end;

function TcxRegion.PtInRegion(const Pt: TPoint): Boolean;
begin
  Result := Windows.PtInRegion(Handle, Pt.X, Pt.Y);
end;

function TcxRegion.PtInRegion(X, Y: Integer): Boolean;
begin
  Result := PtInRegion(Point(X, Y));
end;

function TcxRegion.RectInRegion(const R: TRect): Boolean;
begin
  Result := Windows.RectInRegion(Handle, R);
end;

function TcxRegion.RectInRegion(ALeft, ATop, ARight, ABottom: Integer): Boolean;
begin
  Result := RectInRegion(Rect(ALeft, ATop, ARight, ABottom));
end;

{ TcxCanvas }

constructor TcxCanvas.Create(ACanvas: TCanvas);
begin
  inherited Create;
  FCanvas := ACanvas;
  FSavedRegions := TList.Create;
end;

destructor TcxCanvas.Destroy;
begin
  FCanvas := nil;
  FreeAndNil(FSavedRegions);
  inherited;
end;

function TcxCanvas.GetBrush: TBrush;
begin
  Result := Canvas.Brush;
end;

function TcxCanvas.GetCopyMode: TCopyMode;
begin
  Result := Canvas.CopyMode;
end;

function TcxCanvas.GetDCOrigin: TPoint;
var
  AWindowOrg, AViewportOrg: TPoint;
begin
  AWindowOrg := WindowOrg;
  AViewportOrg := ViewportOrg;
  Result := Point(AViewportOrg.X - AWindowOrg.X, AViewportOrg.Y - AWindowOrg.Y);
end;

function TcxCanvas.GetFont: TFont;
begin
  Result := Canvas.Font;
end;

function TcxCanvas.GetHandle: HDC;
begin
  Result := Canvas.Handle;
end;

function TcxCanvas.GetPen: TPen;
begin
  Result := Canvas.Pen;
end;

function TcxCanvas.GetViewportOrg: TPoint;
begin
  GetViewportOrgEx(Handle, Result);
end;

function TcxCanvas.GetWindowOrg: TPoint;
begin
  GetWindowOrgEx(Handle, Result);
end;

procedure TcxCanvas.SetBrush(Value: TBrush);
begin
  Canvas.Brush := Value;
end;

procedure TcxCanvas.SetCopyMode(Value: TCopyMode);
begin
  Canvas.CopyMode := Value;
end;

procedure TcxCanvas.SetFont(Value: TFont);
begin
  Canvas.Font := Value;
end;

procedure TcxCanvas.SetPen(Value: TPen);
begin
  Canvas.Pen := Value;
end;

procedure TcxCanvas.SetPixel(X, Y: Integer; Value: TColor);
begin
  Canvas.Pixels[X, Y] := Value;
end;

procedure TcxCanvas.SetViewportOrg(const P: TPoint);
begin
  SetViewportOrgEx(Handle, P.X, P.Y, nil);
end;

procedure TcxCanvas.SetWindowOrg(const P: TPoint);
begin
  SetWindowOrgEx(Handle, P.X, P.Y, nil);
end;

procedure TcxCanvas.SynchronizeObjects(ADC: THandle);

  procedure AssignFont;
  var
    ALogFont: TLogFont;
  begin
    cxGetFontData(GetCurrentObject(ADC, OBJ_FONT), ALogFont);
    Font.Handle := CreateFontIndirect(ALogFont);
    Font.Color := GetTextColor(ADC);
  end;

  procedure AssignBrush;

    function GetBrushStyle(const ALogBrush: TLogBrush): TBrushStyle;
    begin
      Result := bsSolid;
      case ALogBrush.lbStyle of  // TODO lbStyle = BS_PATTERN
        BS_HATCHED:
          case ALogBrush.lbHatch of
            HS_BDIAGONAL: Result := bsBDiagonal;
            HS_CROSS: Result := bsCross;
            HS_DIAGCROSS: Result := bsDiagCross;
            HS_FDIAGONAL: Result := bsFDiagonal;
            HS_HORIZONTAL: Result := bsHorizontal;
            HS_VERTICAL: Result := bsVertical;
          end;
        BS_HOLLOW:
          Result := bsClear;
      end;
    end;

  var
    ALogBrush: TLogBrush;
  begin
    cxGetBrushData(GetCurrentObject(ADC, OBJ_BRUSH), ALogBrush);
    Brush.Handle := CreateBrushIndirect(ALogBrush);
    Brush.Color := ALogBrush.lbColor;  // required: set Color before Style
    Brush.Style := GetBrushStyle(ALogBrush)
  end;

  procedure AssignPen;

    function GetPenStyle(const ALogPen: TLogPen): TPenStyle;
    begin
      Result := TPenStyle(ALogPen.lopnStyle);
    end;

    function GetPenMode: TPenMode;
    const
      PenModes: array[TPenMode] of Integer =
        (R2_BLACK, R2_WHITE, R2_NOP, R2_NOT, R2_COPYPEN, R2_NOTCOPYPEN, R2_MERGEPENNOT,
         R2_MASKPENNOT, R2_MERGENOTPEN, R2_MASKNOTPEN, R2_MERGEPEN, R2_NOTMERGEPEN,
         R2_MASKPEN, R2_NOTMASKPEN, R2_XORPEN, R2_NOTXORPEN);
    var
      I: TPenMode;
      ADrawMode: Integer;
    begin
      Result := pmCopy;
      ADrawMode := GetROP2(ADC);
      for I := Low(TPenMode) to High(TPenMode) do
        if PenModes[I] = ADrawMode then
          Result := I;
    end;

  var
    ALogPen: TLogPen;
  begin
    cxGetPenData(GetCurrentObject(ADC, OBJ_PEN), ALogPen);
    Pen.Handle := CreatePenIndirect(ALogPen);
    Pen.Color := ALogPen.lopnColor;
    Pen.Style := GetPenStyle(ALogPen);
    Pen.Mode := GetPenMode;
    Pen.Width := ALogPen.lopnWidth.X;
  end;

begin
  AssignFont;
  AssignBrush;
  AssignPen;
end;

procedure TcxCanvas.AlignMultiLineTextRectVertically(var R: TRect;
  const AText: string; AAlignmentVert: TcxAlignmentVert;
  AWordBreak, AShowPrefix: Boolean; AEnabled: Boolean = True;
  ADontBreakChars: Boolean = False; AEndEllipsis: Boolean = False);
var
  ASizeR: TRect;
  AFlags, ARowHeight: Integer;
begin
  if AAlignmentVert = vaTop then Exit;
  ASizeR := Rect(0, 0, R.Right - R.Left - Ord(not AEnabled), 0);
  AFlags := cxAlignLeft or cxAlignTop;
  if AWordBreak then
    AFlags := AFlags or cxWordBreak;
  if AShowPrefix then
    AFlags := AFlags or cxShowPrefix;
  if ADontBreakChars then
    AFlags := AFlags or cxDontBreakChars;
  if AEndEllipsis and AWordBreak then
  begin
    ARowHeight := TextHeight('Wg');
    ASizeR.Bottom := Max(ARowHeight, ((R.Bottom - R.Top - Ord(not AEnabled)) div ARowHeight) * ARowHeight);
  end
  else
    TextExtent(AText, ASizeR, AFlags);
  case AAlignmentVert of
    vaCenter:
      R.Top := (R.Top + R.Bottom - (ASizeR.Bottom - ASizeR.Top)) div 2;
    vaBottom:
      R.Top := R.Bottom - (ASizeR.Bottom - ASizeR.Top + Ord(not AEnabled));
  end;
end;

procedure TcxCanvas.CopyRect(const Dest: TRect; ACanvas: TCanvas;
  const Source: TRect);
begin
  Canvas.CopyRect(Dest, ACanvas, Source);
end;

procedure TcxCanvas.Draw(X, Y: Integer; Graphic: TGraphic);
begin
  Canvas.Draw(X, Y, Graphic);
end;

procedure TcxCanvas.DrawComplexFrame(const R: TRect;
  ALeftTopColor, ARightBottomColor: TColor; ABorders: TcxBorders;
  ABorderWidth: Integer);
var
  ABorder: TcxBorder;

  function GetBorderColor: TColor;
  begin
    if ABorder in [bLeft, bTop] then
      Result := ALeftTopColor
    else
      Result := ARightBottomColor;
  end;

  function GetBorderBounds: TRect;
  begin
    Result := R;
    with Result do
      case ABorder of
        bLeft:
          Right := Left + ABorderWidth;
        bTop:
          Bottom := Top + ABorderWidth;
        bRight:
          Left := Right - ABorderWidth;
        bBottom:
          Top := Bottom - ABorderWidth;
      end;
  end;

begin
  for ABorder := Low(ABorder) to High(ABorder) do
    if ABorder in ABorders then
      FillRect(GetBorderBounds, GetBorderColor);
end;

procedure TcxCanvas.DrawEdge(const R: TRect; ASunken, AOuter: Boolean;
  ABorders: TcxBorders);
begin
  if ASunken then
    if AOuter then
      DrawComplexFrame(R, clBtnShadow, clBtnHighlight, ABorders)
    else
      DrawComplexFrame(R, cl3DDkShadow{clBtnText}, cl3DLight{clBtnFace}, ABorders)
  else
    if AOuter then
      DrawComplexFrame(R, cl3DLight{clBtnFace}, cl3DDkShadow{clBtnText}, ABorders)
    else
      DrawComplexFrame(R, clBtnHighlight, clBtnShadow, ABorders);
end;

procedure TcxCanvas.DrawFocusRect(const R: TRect);
begin
  SetBrushColor(clWhite);
  Canvas.Font.Color := clBlack;
  TCanvasAccess(Canvas).RequiredState([csFontValid]);
  Canvas.DrawFocusRect(R);
end;

procedure TcxCanvas.DrawGlyph(X, Y: Integer; AGlyph: TBitmap; AEnabled: Boolean = True;
  ABackgroundColor: TColor = clNone{; ATempCanvas: TCanvas = nil});
var
  APrevBrushStyle: TBrushStyle;
  AImageList: TImageList;
  ABitmap: TBitmap;
begin
  if AEnabled {and (ATempCanvas = nil)} then
  begin
    APrevBrushStyle := Brush.Style;
    if ABackgroundColor = clNone then
      Brush.Style := bsClear
    else
      Brush.Color := ABackgroundColor;
    Canvas.BrushCopy(Bounds(X, Y, AGlyph.Width, AGlyph.Height), AGlyph,
      Rect(0, 0, AGlyph.Width, AGlyph.Height), AGlyph.TransparentColor);
    Brush.Style := APrevBrushStyle;
    Exit;
  end;

  AImageList := nil;
  ABitmap := nil;
  try
    AImageList := TImageList.Create(nil);
    AImageList.Width := AGlyph.Width;
    AImageList.Height := AGlyph.Height;
    if ABackgroundColor <> clNone then
      //if ATempCanvas = nil then
      begin
        ABitmap := TBitmap.Create;
        ABitmap.Width := AImageList.Width;
        ABitmap.Height := AImageList.Height;
        with ABitmap.Canvas do
        begin
          Brush.Color := ABackgroundColor;
          FillRect(Rect(0, 0, ABitmap.Width, ABitmap.Height));
        end;
      end
      {else
        with ATempCanvas do
        begin
          Brush.Color := ABackgroundColor;
          FillRect(Bounds(X, Y, AGlyph.Width, AGlyph.Height));
        end};

    if AGlyph.TransparentMode = tmFixed then
      AImageList.AddMasked(AGlyph, AGlyph.TransparentColor)
    else
      AImageList.AddMasked(AGlyph, clDefault);

    if ABitmap <> nil then
    begin
      AImageList.Draw(ABitmap.Canvas, 0, 0, 0, AEnabled); // ??? itMask TODO
      Draw(X, Y, ABitmap);
    end
    else
      (*if ATempCanvas <> nil then
        AImageList.Draw(ATempCanvas, X, Y, 0, AEnabled) // ??? itMask TODO
      else*)
        AImageList.Draw(Canvas, X, Y, 0, AEnabled); // ??? itMask TODO
  finally
    ABitmap.Free;
    AImageList.Free;
  end;        
end;

procedure TcxCanvas.DrawImage(Images: TCustomImageList; X, Y, Index: Integer;
  Enabled: Boolean = True);
begin
  if (0 <= Index) and (Index < Images.Count) then
  begin
    SaveDC;
    Images.Draw(Canvas, X, Y, Index, Enabled);
    RestoreDC;
  end;
end;

procedure TcxCanvas.DrawTexT(const Text: string; R: TRect; Flags: Integer; Enabled: Boolean = True);
begin
  DrawTexT(Text, R, Flags, Enabled, ra0);
end;

procedure TcxCanvas.DrawText(const Text: string; R: TRect; Flags: Integer;
  Enabled: Boolean; ARotationAngle: TcxRotationAngle);
var
  AUseDrawText: Boolean;
  PrevBrushStyle: TBrushStyle;
  PrevFontColor: TColor;

  procedure ProcessFlags;
  var
    ASize: TSize;
    AAlignmentVert: TcxAlignmentVert;
  begin
    ASize := TextExtent(Text);
    if (ASize.cx <= R.Right - R.Left) and (ASize.cy <= R.Bottom - R.Top) then
      Flags := Flags or cxDontClip;
    if AUseDrawText then
    begin
      if (Flags and cxSingleLine = 0) and (Flags and (cxAlignBottom or cxAlignVCenter) <> 0) then
      begin
        if Flags and cxAlignBottom <> 0 then
          AAlignmentVert := vaBottom
        else
          AAlignmentVert := vaCenter;
        AlignMultiLineTextRectVertically(R, Text, AAlignmentVert,
          cxWordBreak and Flags <> 0, cxShowPrefix and Flags <> 0, Enabled,
          cxDontBreakChars and Flags <> 0, cxShowEndEllipsis and Flags <> 0);
      end;
      Flags := cxFlagsToDTFlags(Flags);
    end
    else
    begin
      if ASize.cx < R.Right - R.Left then
        case Flags and (cxAlignLeft or cxAlignRight or cxAlignHCenter) of
          cxAlignRight:
            R.Left := R.Right - ASize.cx - Ord(not Enabled);
          cxAlignHCenter:
            R.Left := (R.Left + R.Right - ASize.cx) div 2;
        end;
      if ASize.cy < R.Bottom - R.Top then
        case Flags and (cxAlignTop or cxAlignBottom or cxAlignVCenter) of
          cxAlignBottom:
            R.Top := R.Bottom - ASize.cy - Ord(not Enabled);
          cxAlignVCenter:
            R.Top := (R.Top + R.Bottom - ASize.cy) div 2;
        end;
      if Flags and cxDontClip = 0 then
        Flags := ETO_CLIPPED
      else
        Flags := 0;
    end;
  end;

  procedure DoDrawText;
  begin
    if AUseDrawText then
      cxDrawText(Self, Text, R, Flags, clDefault, ARotationAngle)
    else
      cxExtTextOut(Canvas.Handle, Text, R.TopLeft, R, Flags);
  end;

begin
  if Length(Text) = 0 then Exit;
  AUseDrawText := (Flags and cxSingleLine = 0) or (ARotationAngle <> ra0) or
    (Flags and (cxShowPrefix or cxShowEndEllipsis or cxShowPathEllipsis) <> 0);
  ProcessFlags;
  PrevBrushStyle := Brush.Style;
  PrevFontColor := Font.Color;
  if not Enabled then
  begin
    with R do
    begin
      Inc(Left);
      Inc(Top);
    end;
    Brush.Style := bsClear;
    Font.Color := clBtnHighlight;
    DoDrawText;
    OffsetRect(R, -1, -1);
    Font.Color := clBtnShadow;
  end;
  DoDrawText;
  if Brush.Style <> PrevBrushStyle then
    Brush.Style := PrevBrushStyle;
  Font.Color := PrevFontColor;
end;

procedure TcxCanvas.DrawTexT(const Text: string; R: TRect;
  AAlignmentHorz: TAlignment; AAlignmentVert: TcxAlignmentVert;
  AMultiLine, AShowEndEllipsis: Boolean);
const
  MultiLines: array[Boolean] of Integer = (cxSingleLine, cxWordBreak);
  ShowEndEllipsises: array[Boolean] of Integer = (0, cxShowEndEllipsis);
begin
  if Text = '' then Exit;
  DrawTexT(Text, R, cxAlignmentsHorz[AAlignmentHorz] or  cxAlignmentsVert[AAlignmentVert] or
    MultiLines[AMultiLine] or ShowEndEllipsises[AShowEndEllipsis]);
end;

procedure TcxCanvas.FillRect(const R: TRect; AColor: TColor);
begin
  if AColor = clNone then Exit; 
  if AColor <> clDefault then
    SetBrushColor(AColor);
  Canvas.FillRect(R);
end;

procedure TcxCanvas.FillRect(const R: TRect; ABitmap: TBitmap = nil;
  AExcludeRect: Boolean = False);
var
  ABitmapSize, AOffset: TPoint;
  AFirstCol, AFirstRow, ALastCol, ALastRow, I, J: Integer;
  ABitmapRect, ACellRect: TRect;
begin
  if IsRectEmpty(R) then Exit;
  if not IsGlyphAssigned(ABitmap) then
    Canvas.FillRect(R)
  else
    with ABitmapSize do
    begin
      X := ABitmap.Width;
      Y := ABitmap.Height;
      AFirstCol := R.Left div X;
      AFirstRow := R.Top div Y;
      ALastCol := R.Right div X - Ord(R.Right mod X = 0);
      ALastRow := R.Bottom div Y - Ord(R.Bottom mod Y = 0);
      for J := AFirstRow to ALastRow do
        for I := AFirstCol to ALastCol do
        begin
          AOffset.X := I * X;
          AOffset.Y := J * Y;
          ACellRect := Bounds(AOffset.X, AOffset.Y, X, Y);
          IntersectRect(ACellRect, ACellRect, R);
          ABitmapRect := ACellRect;
          OffsetRect(ABitmapRect, -AOffset.X, -AOffset.Y);
          CopyRect(ACellRect, ABitmap.Canvas, ABitmapRect);
        end;
    end;
  if AExcludeRect then
    SetClipRegion(TcxRegion.Create(R), roSubtract);
end;

procedure TcxCanvas.FillRect(R: TRect; const AParams: TcxViewParams;
  ABorders: TcxBorders = []; ABorderColor: TColor = clDefault;
  ALineWidth: Integer = 1; AExcludeRect: Boolean = False);
begin
  FrameRect(R, ABorderColor, ALineWidth, ABorders, AExcludeRect);
  with R do
  begin
    if bLeft in ABorders then
      Inc(Left, ALineWidth);
    if bRight in ABorders then
      Dec(Right, ALineWidth);
    if bTop in ABorders then
      Inc(Top, ALineWidth);
    if bBottom in ABorders then
      Dec(Bottom, ALineWidth);
  end;
  SetBrushColor(AParams.Color);
  FillRect(R, AParams.Bitmap, AExcludeRect);
end;

procedure TcxCanvas.DrawDesignSelection(ARect: TRect; AWidth: Integer = cxDesignSelectionWidth);
var
  I: Integer;
begin
  for I := 0 to AWidth - 1 do
  begin
    DrawFocusRect(ARect);
    InflateRect(ARect, -1, -1);
  end;
end;

procedure TcxCanvas.DrawRegion(ARegion: TcxRegion; AContentColor: TColor = clDefault;
  ABorderColor: TColor = clDefault; ABorderWidth: Integer = 1; ABorderHeight: Integer = 1);
begin
  DrawRegion(ARegion.Handle, AContentColor, ABorderColor, ABorderWidth, ABorderHeight);
end;

procedure TcxCanvas.DrawRegion(ARegion: TcxRegionHandle; AContentColor: TColor = clDefault;
  ABorderColor: TColor = clDefault; ABorderWidth: Integer = 1; ABorderHeight: Integer = 1);
begin
  FillRegion(ARegion, AContentColor);
  FrameRegion(ARegion, ABorderColor, ABorderWidth, ABorderHeight);
end;

procedure TcxCanvas.FillRegion(ARegion: TcxRegion; AColor: TColor = clDefault);
begin
  FillRegion(ARegion.Handle, AColor);
end;

procedure TcxCanvas.FillRegion(ARegion: TcxRegionHandle; AColor: TColor = clDefault);
begin
  SetBrushColor(AColor);
  FillRgn(Handle, ARegion, Brush.Handle);
end;

procedure TcxCanvas.FlipHorizontally(ABitmap: TBitmap);
var
  Bits: TRGBColors;
  ARow, ACol, W, H, ARowStart: Integer;
  AValue: TRGBQuad;
begin
  W := ABitmap.Width;
  H := ABitmap.Height;

  GetBitmapBits(ABitmap, Bits, True);
  ARowStart := 0;
  for ARow := 0 to H - 1 do
  begin
    for ACol := 0 to (W - 1) div 2 do
    begin
      AValue := Bits[ARowStart + ACol];
      Bits[ARowStart + ACol] := Bits[ARowStart + W - 1 - ACol];
      Bits[ARowStart + W - 1 - ACol] := AValue;
    end;
    Inc(ARowStart, W);
  end;
  SetBitmapBits(ABitmap, Bits, True);
end;

procedure TcxCanvas.FrameRegion(ARegion: TcxRegion; AColor: TColor = clDefault;
  ABorderWidth: Integer = 1; ABorderHeight: Integer = 1);
begin
  FrameRegion(ARegion.Handle, AColor, ABorderWidth, ABorderHeight);
end;

procedure TcxCanvas.FrameRegion(ARegion: TcxRegionHandle; AColor: TColor = clDefault;
  ABorderWidth: Integer = 1; ABorderHeight: Integer = 1);
begin
  SetBrushColor(AColor);
  FrameRgn(Handle, ARegion, Brush.Handle, ABorderWidth, ABorderHeight);
end;

procedure TcxCanvas.Pie(const R: TRect; const ARadial1, ARadial2: TPoint);
begin
  with R do
    Canvas.Pie(Left, Top, Right, Bottom, ARadial1.X, ARadial1.Y, ARadial2.X, ARadial2.Y);
end;

procedure TcxCanvas.Pie(const R: TRect; AStartAngle, ASweepAngle: Integer);

{
                      A * B
  V = ---------------------------------------------
      Sqrt(A^2 * Sin^2(Alpha) + B^2 * Cos^2(Alpha))

  Radial.X = V * Cos(Alpha)
  Radial.Y = V * Sin(Alpha)

  where:
    A - horizontal ellipse semiaxis
    B - vertical ellipse semiaxis
    Angle - an angle between Radius-Vector and A calculated in counterclockwise direction
}

  function CalculateRadial(A, B: Integer; const ACenter: TPoint; AnAngle: Integer): TPoint;
  var
    Sin, Cos, V: Extended;
  begin
    SinCos(DegToRad(AnAngle), Sin, Cos);
    if (A <> 0) and (B <> 0) then
      V := A * B / Sqrt(A * A * Sin * Sin + B * B * Cos * Cos)
    else
      V := 0;
    Result.X := ACenter.X + Round(V * Cos);
    Result.Y := ACenter.Y - Round(V * Sin);
  end;

var
  A, B: Integer;
  Center, Radial1, Radial2: TPoint;
begin
  if IsRectEmpty(R) or (ASweepAngle = 0) then Exit;
  with R do
  begin
    A := (Right - Left) div 2;
    B := (Bottom - Top) div 2;
    Center.X := Left + A;
    Center.Y := Top + B;
  end;
  Radial1 := CalculateRadial(A, B, Center, AStartAngle);
  if ASweepAngle = 360 then
    Radial2 := Radial1
  else
    Radial2 := CalculateRadial(A, B, Center, AStartAngle + ASweepAngle);
  if (Radial1.X <> Radial2.X) or (Radial1.Y <> Radial2.Y) or (ASweepAngle > 180) then
    Pie(R, Radial1, Radial2);
end;

function TcxCanvas.FontHeight(AFont: TFont): Integer;
begin
  Font := AFont;
  Result := TextHeight('Qq');
end;

procedure TcxCanvas.FrameRect(const R: TRect; Color: TColor = clDefault;
  ALineWidth: Integer = 1; ABorders: TcxBorders = cxBordersAll;
  AExcludeFrame: Boolean = False);
begin
  if IsRectEmpty(R) then Exit;
  if Color <> clDefault then
  begin
    SetBrushColor(Color);
  end;
  with R do
  begin
    if bLeft in ABorders then
      FillRect(Rect(Left, Top, Min(Left + ALineWidth, Right), Bottom), nil, AExcludeFrame);
    if bRight in ABorders then
      FillRect(Rect(Max(Right - ALineWidth, Left), Top, Right, Bottom), nil, AExcludeFrame);
    if bTop in ABorders then
      FillRect(Rect(Left, Top, Right, Min(Top + ALineWidth, Bottom)), nil, AExcludeFrame);
    if bBottom in ABorders then
      FillRect(Rect(Left, Max(Bottom - ALineWidth, Top), Right, Bottom), nil, AExcludeFrame);
  end;
end;

procedure TcxCanvas.ExcludeFrameRect(const R: TRect; ALineWidth: Integer = 1;
  ABorders: TcxBorders = cxBordersAll);
begin
  with R do
  begin
    if bLeft in ABorders then
      SetClipRegion(TcxRegion.Create(Rect(Left, Top, Min(Left + ALineWidth, Right), Bottom)), roSubtract);
    if bRight in ABorders then
      SetClipRegion(TcxRegion.Create(Rect(Max(Right - ALineWidth, Left), Top, Right, Bottom)), roSubtract);
    if bTop in ABorders then
      SetClipRegion(TcxRegion.Create(Rect(Left, Top, Right, Min(Top + ALineWidth, Bottom))), roSubtract);
    if bBottom in ABorders then
      SetClipRegion(TcxRegion.Create(Rect(Left, Max(Bottom - ALineWidth, Top), Right, Bottom)), roSubtract);
  end;
end;

procedure TcxCanvas.InvertFrame(const R: TRect; ABorderSize: Integer);
begin
  with R do
  begin
    InvertRect(Rect(Left, Top, Left + ABorderSize, Bottom));
    InvertRect(Rect(Right - ABorderSize, Top, Right, Bottom));
    InvertRect(Rect(Left + ABorderSize, Top,
      Right - ABorderSize, Top + ABorderSize));
    InvertRect(Rect(Left + ABorderSize, Bottom - ABorderSize,
      Right - ABorderSize, Bottom));
  end;
end;

procedure TcxCanvas.InvertRect(const R: TRect);
begin
  with Canvas do
  begin
    CopyMode := cmDstInvert;
    CopyRect(R, Canvas, R);
    CopyMode := cmSrcCopy;
  end;
end;

procedure TcxCanvas.LineTo(X, Y: Integer);
begin
  Canvas.LineTo(X, Y);
end;

procedure TcxCanvas.MoveTo(X, Y: Integer);
begin
  Canvas.MoveTo(X, Y);
end;

procedure TcxCanvas.Polygon(const Points: array of TPoint);
begin
  Canvas.Polygon(Points);
end;

procedure TcxCanvas.Polyline(const Points: array of TPoint);
begin
  Canvas.Polyline(Points);
end;

procedure TcxCanvas.RotateBitmap(ABitmap: TBitmap; ARotationAngle: TcxRotationAngle;
  AFlipVertically: Boolean = False);
var
  SourceRGBs, DestRGBs: TRGBColors;
  ARow, ACol, H, W, ASourceI, ADestI: Integer;
begin
  SourceRGBs := nil; // to remove compiler's warning
  if (ARotationAngle = ra0) and not AFlipVertically then exit;
  H := ABitmap.Height;
  W := ABitmap.Width;

  GetBitmapBits(ABitmap, SourceRGBs, True);
  SetLength(DestRGBs, Length(SourceRGBs));

  for ARow := 0 to H - 1 do
    for ACol := 0 to W - 1 do
    begin
      ASourceI := ARow * W + ACol;
      case ARotationAngle of
        raPlus90:
          if AFlipVertically then
            ADestI := ACol * H + ARow
          else
            ADestI := (W - ACol - 1) * H + ARow;
        ra0:
          ADestI := (H - 1 - ARow) * W + ACol;
        ra180:
          if AFlipVertically then
            ADestI := ARow * W + W - ACol - 1
          else
            ADestI := (H - ARow - 1) * W + W - ACol - 1;
      else
        if AFlipVertically then
          ADestI := (W - ACol - 1) * H + H - ARow - 1
        else
          ADestI := H - 1 + ACol * H - ARow;
      end;
      DestRGBs[ADestI] := SourceRGBs[ASourceI];
    end;

  if ARotationAngle in [raPlus90, raMinus90] then
  begin
    ABitmap.Height := 0;
    ABitmap.Width := H;
    ABitmap.Height := W;
  end;
  SetBitmapBits(ABitmap, DestRGBs, True);
end;

function TcxCanvas.TextExtent(const Text: string): TSize;
begin
  TCanvasAccess(Canvas).RequiredState([csHandleValid, csFontValid]);
  Result.cX := 0;
  Result.cY := 0;
  cxGetTextExtentPoint32(Handle, Text, Result);
end;

procedure TcxCanvas.TextExtent(const Text: string; var R: TRect; Flags: Integer);
var
  RWidth, RHeight, TextWidth, TextHeight: Integer;

  procedure CalcRSizes(var AWidth, AHeight: Integer);
  begin
    with R do
    begin
      AWidth := Right - Left;
      AHeight := Bottom - Top;
    end;
  end;

  procedure AlignR;
  begin
    if Flags and DT_CENTER <> 0 then
      OffsetRect(R, (RWidth - TextWidth) div 2, 0)
    else
      if Flags and DT_RIGHT <> 0 then
        OffsetRect(R, RWidth - TextWidth, 0);
    if Flags and DT_VCENTER <> 0 then
      OffsetRect(R, 0, (RHeight - TextHeight) div 2)
    else
      if Flags and DT_BOTTOM <> 0 then
        OffsetRect(R, 0, RHeight - TextHeight);
  end;

begin
  CalcRSizes(RWidth, RHeight);
  Flags := cxFlagsToDTFlags(Flags);
  if (RWidth <= 0) and (Text <> '') then  // A2079
    R.Right := R.Left + 1;
  if cxDrawText(Canvas.Handle, Text, R, Flags and not DT_VCENTER or DT_CALCRECT) = 0 then
  begin
    R.Right := R.Left;
    R.Bottom := R.Top;
  end;
  CalcRSizes(TextWidth, TextHeight);
  AlignR;
end;

function TcxCanvas.TextHeight(const Text: string): Integer;
begin
  Result := TextExtent(Text).cy;
end;

function TcxCanvas.TextWidth(const Text: string): Integer;
begin
  Result := TextExtent(Text).cx;
end;

procedure TcxCanvas.TransparentDraw(X, Y: Integer; ABitmap: TBitmap; AAlpha: Byte;
  ABackground: TBitmap = nil);

  function BlendValues(ASource, ADestination: DWORD): DWORD;
  begin
    Result := MulDiv(ASource, AAlpha, 255) + MulDiv(ADestination, 255 - AAlpha, 255);
  end;

  procedure BlendValue(const ASource: TRGBQuad; var ADestination: TRGBQuad);
  begin
    ADestination.rgbBlue := BlendValues(ASource.rgbBlue, ADestination.rgbBlue);
    ADestination.rgbGreen := BlendValues(ASource.rgbGreen, ADestination.rgbGreen);
    ADestination.rgbRed := BlendValues(ASource.rgbRed, ADestination.rgbRed);
  end;

var
  W, H, ARow, ACol: Integer;
  ABackgroundBitmap: TBitmap;
  ABlendFunction: TBlendFunction;
  ABits, ABackgroundBits: TRGBColors;
begin
  ABits := nil; // to remove compiler's warning
  W := ABitmap.Width;
  H := ABitmap.Height;

  ABackgroundBitmap := TBitmap.Create;
  ABackgroundBitmap.Width := W;
  ABackgroundBitmap.Height := H;

  if ABackground = nil then
    ABackgroundBitmap.Canvas.CopyRect(Rect(0, 0, W, H), Canvas, Bounds(X, Y, W, H))
  else
    ABackgroundBitmap.Canvas.Draw(0, 0, ABackground);

  if Assigned(VCLAlphaBlend) then
  begin
    ABlendFunction := DefaultBlendFunction;
    ABlendFunction.SourceConstantAlpha := AAlpha;
    VCLAlphaBlend(ABackgroundBitmap.Canvas.Handle,
      0, 0, W, H, ABitmap.Canvas.Handle, 0, 0, W, H, ABlendFunction);
  end
  else
  begin
    GetBitmapBits(ABitmap, ABits, True);
    GetBitmapBits(ABackgroundBitmap, ABackgroundBits, True);

    for ARow := 0 to H - 1 do
      for ACol := 0 to W - 1 do
        BlendValue(ABits[ACol * H + ARow], ABackgroundBits[ACol * H + ACol]);

    SetBitmapBits(ABackgroundBitmap, ABackgroundBits, True);
  end;

  Draw(X, Y, ABackgroundBitmap);

  ABackgroundBitmap.Free;
end;

procedure TcxCanvas.RestoreDC;
begin
  dxTestCheck(Length(FSavedDCs) > 0, 'RestoreDC fails');
  if Length(FSavedDCs) > 0 then
  begin
    Canvas.Handle := FSavedDCs[High(FSavedDCs)].Handle;
    dxTestCheck(Windows.RestoreDC(Handle, FSavedDCs[High(FSavedDCs)].State), 'RestoreDC fails');
    SetLength(FSavedDCs, Length(FSavedDCs) - 1);
    Canvas.Unlock;
  end;
end;

procedure TcxCanvas.SaveDC;
begin
  Canvas.Lock;
  SetLength(FSavedDCs, Length(FSavedDCs) + 1);
  FSavedDCs[High(FSavedDCs)].Handle := Handle;
  FSavedDCs[High(FSavedDCs)].State := Windows.SaveDC(Handle);
end;

procedure TcxCanvas.RestoreClipRegion;
var
  ALastSavedRegionIndex: Integer;
begin
  ALastSavedRegionIndex := FSavedRegions.Count - 1;
  if ALastSavedRegionIndex >= 0 then
  begin
    SetClipRegion(TcxRegion(FSavedRegions[ALastSavedRegionIndex]), roSet);
    FSavedRegions.Delete(ALastSavedRegionIndex);
  end;
end;

procedure TcxCanvas.SaveClipRegion;
begin
  FSavedRegions.Add(GetClipRegion);
end;

procedure TcxCanvas.RestoreState;

  procedure InternalRestoreState(var ACurrentState: TcxCanvasState);
  begin
    Font.Assign(ACurrentState.Font);
    ACurrentState.Font.Free;
    Brush.Assign(ACurrentState.Brush);
    ACurrentState.Brush.Free;
    Pen.Assign(ACurrentState.Pen);
    ACurrentState.Pen.Free;
  end;

begin
  if Length(FSavedStates) > 0 then
  begin
    InternalRestoreState(FSavedStates[High(FSavedStates)]);
    SetLength(FSavedStates, Length(FSavedStates) - 1);
    RestoreDC;
  end;
end;

procedure TcxCanvas.SaveState;

  procedure InternalSaveState(var ACurrentState: TcxCanvasState);
  begin
    ACurrentState.Font := TFont.Create;
    ACurrentState.Font.Assign(Font);
    ACurrentState.Brush := TBrush.Create;
    ACurrentState.Brush.Assign(Brush);
    ACurrentState.Pen := TPen.Create;
    ACurrentState.Pen.Assign(Pen);
  end;

begin
  SynchronizeObjects(Handle);
  SaveDC;
  SetLength(FSavedStates, Length(FSavedStates) + 1);
  InternalSaveState(FSavedStates[High(FSavedStates)]);
end;

procedure TcxCanvas.GetParams(var AParams: TcxViewParams);
begin
  AParams.Color := Brush.Color;
  AParams.Font := Font;
  AParams.TextColor := Font.Color;
end;

procedure TcxCanvas.SetParams(AParams: TcxViewParams);
begin
  SetBrushColor(AParams.Color);
  Font := AParams.Font;
  Font.Color := AParams.TextColor;
end;

procedure TcxCanvas.SetBrushColor(Value: TColor);
begin
{$IFNDEF DELPHI11}
  if (Brush.Color <> Value) or (Brush.Style = bsClear) then
{$ENDIF}
    Brush.Color := Value;
end;

procedure TcxCanvas.SetFontAngle(Value: Integer);
var
  ALogFont: TLogFont;
begin
  cxGetFontData(Font.Handle, ALogFont);
  ALogFont.lfEscapement := Value * 10;
  if Value <> 0 then
    ALogFont.lfOutPrecision := OUT_TT_ONLY_PRECIS;
  Font.Handle := CreateFontIndirect(ALogFont);
end;

procedure TcxCanvas.GetTextStringsBounds(Text: string; R: TRect; Flags: Integer;
  Enabled: Boolean; var ABounds: TRectArray);
var
  AAlignHorz, AAlignVert, AMaxCharCount: Integer;
  ATextR: TRect;
  AStringSize: TSize;

  procedure PrepareRects;
  begin
    if not Enabled then
      with R do
      begin
        Dec(Right);
        Dec(Bottom);
      end;
    ATextR := R;
    TextExtent(Text, ATextR, Flags);
    case AAlignVert of
      cxAlignBottom:
        OffsetRect(ATextR, 0, R.Bottom - ATextR.Bottom);
      cxAlignVCenter:
        OffsetRect(ATextR, 0, (R.Bottom - ATextR.Bottom) div 2);
    end;
  end;

  procedure CheckMaxCharCount;

    function ProcessSpecialChars: Boolean;
    const
      SpecialChars = [#10, #13];
    var
      I, ACharCount: Integer;
    begin
      Result := False;
      for I := 1 to AMaxCharCount do
        if dxCharInSet(Text[I], SpecialChars) then
        begin
          AMaxCharCount := I - 1;
          ACharCount := 1;
          if (I < Length(Text)) and
            dxCharInSet(Text[I + 1], SpecialChars) and (Text[I] <> Text[I + 1]) then
            Inc(ACharCount);
          Delete(Text, I, ACharCount);
          Result := True;
          Break;
        end;
    end;

    procedure ProcessSpaces;
    var
      I: Integer;
    begin
      if AMaxCharCount < Length(Text) then
        for I := AMaxCharCount + 1 downto 1 do
          if Text[I] = ' ' then
          begin
            if I < AMaxCharCount then
            begin
              AMaxCharCount := I;
              if AAlignHorz <> cxAlignLeft then
              begin
                Delete(Text, I, 1);
                Dec(AMaxCharCount);
              end;
            end;
            Break;
          end;
    end;

  begin
    AMaxCharCount := Max(1, AMaxCharCount);
    if not ProcessSpecialChars then
      ProcessSpaces;
  end;

  procedure GetStringSize;
  begin
    cxGetTextExtentPoint32(Handle, Copy(Text, 1, AMaxCharCount), AStringSize, AMaxCharCount);
  end;

  function GetBounds: TRect;
  begin
    Result := ATextR;
    with Result, AStringSize do
    begin
      case AAlignHorz of
        cxAlignLeft:
          Right := Left + cx;
        cxAlignRight:
          Left := Right - cx;
        cxAlignHCenter:
          begin
            Left := (Left + Right - cx) div 2;
            Right := Left + cx;
          end;
      end;
      Bottom := Top + cy;
    end;
    ATextR.Top := Result.Bottom;
  end;

begin
  if Text = '' then Exit;
  if Flags and cxShowPrefix <> 0 then
  begin
    Text := StripHotKey(Text);
    Flags := Flags and not cxShowPrefix;
  end;
  AAlignHorz := Flags and (cxAlignLeft or cxAlignRight or cxAlignHCenter);
  AAlignVert := Flags and (cxAlignTop or cxAlignBottom or cxAlignVCenter);
  PrepareRects;
  repeat
    GetTextExtentExPoint(Handle, PChar(Text), Length(Text), R.Right - R.Left, @AMaxCharCount, nil, AStringSize);
    CheckMaxCharCount;
    GetStringSize;
    SetLength(ABounds, High(ABounds) + 2);
    ABounds[High(ABounds)] := GetBounds;
    Delete(Text, 1, AMaxCharCount);
  until Text = '';
end;

procedure TcxCanvas.BeginPath;
begin
  Windows.BeginPath(Handle);
end;

procedure TcxCanvas.EndPath;
begin
  Windows.EndPath(Handle);
end;

function TcxCanvas.PathToRegion(AConsiderOrigin: Boolean = True): TcxRegion;
begin
  Result := TcxRegion.Create(Windows.PathToRegion(Handle));
  if AConsiderOrigin then
    Result.Offset(cxPointInvert(DCOrigin));
end;

procedure TcxCanvas.WidenPath;
begin
  Windows.WidenPath(Handle);
end;

procedure TcxCanvas.ExcludeClipRect(const R: TRect);
begin
  with R do
    Windows.ExcludeClipRect(Handle, Left, Top, Right, Bottom);
end;

procedure TcxCanvas.IntersectClipRect(const R: TRect);
begin
  with R do
    Windows.IntersectClipRect(Canvas.Handle, Left, Top, Right, Bottom);
end;

function TcxCanvas.GetClipRegion(AConsiderOrigin: Boolean = True): TcxRegion;
const
  MaxRegionSize = 30000;
begin
  Result := TcxRegion.Create;
  if GetClipRgn(Handle, Result.Handle) = 0 then
    SetRectRgn(Result.Handle, 0, 0, MaxRegionSize, MaxRegionSize);
  if AConsiderOrigin then
    Result.Offset(-DCOrigin.X, -DCOrigin.Y);
end;

procedure TcxCanvas.SetClipRegion(ARegion: TcxRegion; AOperation: TcxRegionOperation;
  ADestroyRegion: Boolean = True; AConsiderOrigin: Boolean = True);
var
  AClipRegion: TcxRegion;
  ARegionOrigin: TPoint;
begin
  if AOperation = roSet then
  begin
    if AConsiderOrigin then
    begin
      ARegionOrigin := DCOrigin;
      ARegion.Offset(ARegionOrigin.X, ARegionOrigin.Y);
    end;
    SelectClipRgn(Handle, ARegion.Handle);
    if ADestroyRegion then
      ARegion.Free
    else
      if AConsiderOrigin then
        ARegion.Offset(-ARegionOrigin.X, -ARegionOrigin.Y);
  end
  else
  begin
    AClipRegion := GetClipRegion(AConsiderOrigin);
    AClipRegion.Combine(ARegion, AOperation, ADestroyRegion);
    SetClipRegion(AClipRegion, roSet, True, AConsiderOrigin);
  end;
end;

function TcxCanvas.RectFullyVisible(const R: TRect): Boolean;
var
  AClipRegion, ARegion: TcxRegion;
begin
  AClipRegion := GetClipRegion;
  ARegion := TcxRegion.Create(R);
  try
    CombineRgn(AClipRegion.Handle, AClipRegion.Handle, ARegion.Handle, RGN_AND);
    Result := AClipRegion.IsEqual(ARegion);
  finally
    ARegion.Free;
    AClipRegion.Free;
  end;
end;

function TcxCanvas.RectVisible(const R: TRect): Boolean;
begin
  Result := Windows.RectVisible(Handle, R);
end;

{ TcxScreen }

type
  TScreenCanvas = class(TCanvas)
  private
    FDeviceContext: HDC;
    FWindowHandle: HWND;
  protected
    procedure CreateHandle; override;
    procedure FreeHandle;
  public
    destructor Destroy; override;
  end;

destructor TScreenCanvas.Destroy;
begin
  FreeHandle;
  inherited;
end;

procedure TScreenCanvas.CreateHandle;
begin
  FWindowHandle := GetDesktopWindow;
  FDeviceContext := GetDCEx(FWindowHandle, 0, DCX_CACHE or DCX_LOCKWINDOWUPDATE); //B96653
  Handle := FDeviceContext;
end;

procedure TScreenCanvas.FreeHandle;
begin
  if FDeviceContext <> 0 then
  begin
    Handle := 0;
    ReleaseDC(FWindowHandle, FDeviceContext);
    FDeviceContext := 0;
    FWindowHandle := 0;
  end;
end;

{ TcxScreenCanvas }

constructor TcxScreenCanvas.Create;
begin
  inherited Create(TScreenCanvas.Create);
end;

destructor TcxScreenCanvas.Destroy;
begin
  FreeAndNil(FCanvas);
  inherited;
end;

procedure TcxScreenCanvas.Dormant;
begin
  TScreenCanvas(Canvas).FreeHandle;
end;

function cxScreenCanvas: TcxScreenCanvas;
begin
  if (ScreenCanvas = nil) and not FUnitIsFinalized then
    ScreenCanvas := TcxScreenCanvas.Create;
  Result := ScreenCanvas;
end;

{ TcxPaintCanvas }

constructor TcxPaintCanvas.Create;
begin
  inherited Create(TCanvas.Create);
end;

destructor TcxPaintCanvas.Destroy;
begin
  Canvas.Free;
  inherited;
end;

procedure TcxPaintCanvas.BeginPaint(ADC: THandle);
begin
  SetLength(FSavedDCs, FCounter + 1);

  if HandleValid then
  begin
    SaveState;
    FSavedDCs[FCounter].PrevDC := Handle;
  end
  else
    FSavedDCs[FCounter].PrevDC := 0;

  FSavedDCs[FCounter].PrevCanvas := nil;
  FSavedDCs[FCounter].NewDC := ADC;
  FSavedDCs[FCounter].NewDCIndex := Windows.SaveDC(ADC);
  SynchronizeObjects(ADC);
  Canvas.Handle := ADC;
  Inc(FCounter);
end;

procedure TcxPaintCanvas.BeginPaint(ACanvas: TCanvas);
begin
  SetLength(FSavedDCs, FCounter + 1);
  FSavedDCs[FCounter].PrevCanvas := Canvas;
  Canvas := ACanvas;
  SaveState;
  Inc(FCounter);
end;

procedure TcxPaintCanvas.EndPaint;
begin
  if FCounter > 0 then
  begin
    Dec(FCounter);
    if FSavedDCs[FCounter].PrevCanvas <> nil then
    begin
      RestoreState;
      Canvas := FSavedDCs[FCounter].PrevCanvas;
    end
    else
    begin
      Canvas.Handle := FSavedDCs[FCounter].PrevDC;
      Windows.RestoreDC(FSavedDCs[FCounter].NewDC, FSavedDCs[FCounter].NewDCIndex);
      if HandleValid then
        RestoreState;
    end;
    SetLength(FSavedDCs, FCounter);
  end;
end;

function TcxPaintCanvas.HandleValid;
begin
  Result := Canvas.HandleAllocated;
end;

function cxPaintCanvas: TcxPaintCanvas;
begin
  if (PaintCanvas = nil) and not FUnitIsFinalized then
    PaintCanvas := TcxPaintCanvas.Create;
  Result := PaintCanvas;
end;

procedure cxTransformImages(AImageList: TcxImageList; ABkColor: TColor; AEnabled: Boolean = True);
var
  ACopy: TcxImageList;
begin
  ACopy := TcxImageList.CreateSize(AImageList.Width, AImageList.Height);
  try
    ACopy.CopyImages(AImageList);
    cxTransformImages(ACopy, AImageList, ABkColor, AEnabled);
  finally
    ACopy.Free;
  end;
end;

procedure cxTransformImages(ASourceImageList, ADestinationImageList: TcxImageList; ABkColor: TColor; AEnabled: Boolean = True);
var
  AAlphaBitmap: TcxAlphaBitmap;
  ABitmap: TcxBitmap;
  I: Integer;
begin
  ADestinationImageList.Clear;
  AAlphaBitmap := TcxAlphaBitmap.CreateSize(ASourceImageList.Width, ASourceImageList.Height, dxColorToRGBQuad(ABkColor, $FF));
  ABitmap := TcxBitmap.CreateSize(AAlphaBitmap.ClientRect, pf24bit);
  try
    for I := 0 to ASourceImageList.Count - 1 do
    begin
      AAlphaBitmap.Clear;
      ASourceImageList.Draw(AAlphaBitmap.Canvas, AAlphaBitmap.ClientRect, I, True, False, AEnabled);
      ABitmap.CopyBitmap(AAlphaBitmap);
      ADestinationImageList.AddMasked(ABitmap, ABkColor);
    end;
  finally
    ABitmap.Free;
    AAlphaBitmap.Free;
  end;
end;

procedure DrawMenuItemText(AMenuItem: TMenuItem; ACanvas: TCanvas; const ACaption: string;
  var ARect: TRect; ASelected: Boolean; AFlags: Longint);
var
  AText: string;
  R: TRect;
begin
  AText := ACaption;
  if (AFlags and DT_CALCRECT <> 0) and ((AText = '') or
    (AText[1] = cHotkeyPrefix) and (AText[2] = #0)) then AText := AText + ' ';
  with ACanvas do
  begin
    if AText = cLineCaption then
    begin
      if AFlags and DT_CALCRECT = 0 then
      begin
        R := ARect;
        Inc(R.Top, 4);
        DrawEdge(Handle, R, EDGE_ETCHED, BF_TOP);
      end;
    end
    else
    begin
      if AMenuItem.Default then
        Font.Style := Font.Style + [fsBold];
      if not AMenuItem.Enabled then
      begin
        if not ASelected then
        begin
          OffsetRect(ARect, 1, 1);
          cxDrawText(ACanvas, AText, ARect, AFlags, clBtnHighlight);
          OffsetRect(ARect, -1, -1);
        end;
        if ASelected and (ColorToRGB(clHighlight) = ColorToRGB(clBtnShadow)) then
          Font.Color := clBtnHighlight
        else
          Font.Color := clBtnShadow;
      end;
      cxDrawText(ACanvas, AText, ARect, AFlags);
    end;
  end;
end;

procedure DrawVistaMenuItemText(AMenuItem: TMenuItem; ACanvas: TCanvas;
  const ACaption: string; var ARect: TRect; ASelected: Boolean; AFlags: Longint;
  ATheme: TdxTheme);
const
  MenuStates: array[Boolean] of Cardinal = (MPI_DISABLED, MPI_NORMAL);
var
  AText: string;
  AOptions: TdxDTTOpts;
begin
  FillChar(AOptions, SizeOf(AOptions), 0);
  AOptions.dwSize := SizeOf(AOptions);
  AOptions.dwFlags := DTT_TEXTCOLOR or DTT_COMPOSITED;
  if AFlags and DT_CALCRECT = DT_CALCRECT then
    AOptions.dwFlags := AOptions.dwFlags or DTT_CALCRECT;
  AOptions.crText := ColorToRGB(ACanvas.Font.Color);
  AText := ACaption;
  if (AFlags and DT_CALCRECT <> 0) and ((AText = '') or
    (AText[1] = cHotkeyPrefix) and (AText[2] = #0)) then AText := AText + ' ';
  with ACanvas do
  begin
    Brush.Style := bsClear;
    if AMenuItem.Default then
      Font.Style := Font.Style + [fsBold];
    DrawThemeTextEx(ATheme, ACanvas.Handle, MENU_POPUPITEM,
      MenuStates[AMenuItem.Enabled], AText, Length(AText), AFlags, ARect, AOptions);
  end;
end;

procedure cxAdvancedDrawPopupMenuItem(AMenuItem: TMenuItem; ACanvas: TCanvas; ARect: TRect;
  AState: TOwnerDrawState);
const
  Alignments: array[TPopupAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
  EdgeStyle: array[Boolean] of Longint = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
var
  AImageList: TCustomImageList;
  AParentMenu: TMenu;
  AAlignment: TPopupAlignment;
  ASelected, ADrawImage, ADrawImageListItem, AIsMenuSeparator: Boolean;
  AGlyphRect, ASaveRect, ACheckBkgRect: TRect;
  ATextFlags: Longint;
  AOldBrushColor: TColor;
  AWinXPFlatMenus: Boolean;
  ATheme: TdxTheme;

  function GetAlignment: TPopupAlignment;
  begin
    if AParentMenu is TMenu then
      Result := paLeft
    else if AParentMenu is TPopupMenu then
      Result := TPopupMenu(AParentMenu).Alignment
    else
      Result := paLeft;
  end;

  function GetTextFlags: Longint;
  begin
    Result := DT_EXPANDTABS or DT_SINGLELINE or Alignments[AAlignment];
    if IsWin2KOrLater and (odNoAccel in AState) then
      Result := Result or DT_HIDEPREFIX;
  end;

  procedure VistaDrawMenuItem;
  const
    MenuStates: array[Boolean, Boolean] of Integer = ((MBI_NORMAL, MBI_PUSHED), (MBI_HOT, MBI_PUSHED));
    ItemStates: array[Boolean] of Cardinal = (MPI_DISABLED, MPI_NORMAL);
    TopLevelItemStates: array[Boolean] of Cardinal = (MBI_DISABLED, MBI_NORMAL);
    CheckMarkBkgs: array[Boolean] of Cardinal = (MCB_DISABLED, MCB_NORMAL);
    CheckMarkStates: array[Boolean, Boolean] of Cardinal =
      ((MC_CHECKMARKDISABLED, MC_BULLETDISABLED), (MC_CHECKMARKNORMAL, MC_BULLETNORMAL));
  var
    AShortCutText: string;
    AColorRef: TColorRef;
    ASize, ACheckSize: TSize;
    AMargins, ACheckMargins: TdxMargins;
    AGutterRect, ACheckRect, ABitmapRect: TRect;
  begin
    with ACanvas do
    begin
      DrawThemeBackground(ATheme, Handle, MENU_POPUPBACKGROUND, 0, ARect, nil);
      GetThemePartSize(ATheme, Handle, MENU_POPUPCHECK,
        CheckMarkStates[AMenuItem.Enabled, AMenuItem.RadioItem], nil, TS_TRUE, @ACheckSize);
      GetThemeMargins(ATheme, Handle, MENU_POPUPCHECK,
        CheckMarkStates[AMenuItem.Enabled, AMenuItem.RadioItem], TMT_CONTENTMARGINS, nil, ACheckMargins);
      with ARect, ACheckMargins do
        ACheckRect := Rect(Left, Top,
          Left + ACheckSize.cx + cxRightWidth + cxRightWidth,
          Top + ACheckSize.cy + cyBottomHeight + cyBottomHeight);

      AGlyphRect := ACheckRect;
      if Assigned(AImageList) then
      begin
        if AImageList.Height > ACheckSize.cy then
          Inc(AGlyphRect.Bottom, AImageList.Height - ACheckSize.cy);
        if AImageList.Width > ACheckSize.cx then
          Inc(AGlyphRect.Right, AImageList.Width - ACheckSize.cx);
        OffsetRect(ACheckRect, (AGlyphRect.Right - ACheckRect.Right) div 2,
          (AGlyphRect.Bottom - ACheckRect.Bottom) div 2);
      end;

      AGutterRect := AGlyphRect;
      GetThemePartSize(ATheme, Handle,
        MENU_POPUPGUTTER, 0, nil, TS_TRUE, @ASize);
      GetThemeMargins(ATheme, Handle,
        MENU_POPUPGUTTER, 0, TMT_SIZINGMARGINS, nil, AMargins);
      Inc(AGutterRect.Right, ASize.cx + ACheckMargins.cxLeftWidth);
      Inc(AGutterRect.Right, AMargins.cxLeftWidth);
      DrawThemeBackground(ATheme, Handle, MENU_POPUPGUTTER, 0, AGutterRect, nil);

      if not AIsMenuSeparator then
      begin
        ADrawImage := ADrawImageListItem or (AMenuItem.Checked and AMenuItem.Bitmap.Empty);
        if ADrawImage or not AMenuItem.Bitmap.Empty then
        begin
          if AMenuItem.Checked then
            DrawThemeBackground(ATheme, Handle, MENU_POPUPCHECKBACKGROUND, CheckMarkBkgs[AMenuItem.Enabled], ACheckRect, nil);
          if ADrawImage then
          begin
            if ADrawImageListItem then
              with AGlyphRect do
                AImageList.Draw(ACanvas, Left + ((Right - Left - AImageList.Width) div 2),
                  Top + ((Bottom - Top - AImageList.Height) div 2), AMenuItem.ImageIndex, AMenuItem.Enabled)
            else
            begin
              DrawThemeBackground(ATheme, Handle,
                MENU_POPUPCHECKBACKGROUND, CheckMarkBkgs[AMenuItem.Enabled], ACheckRect, nil);
              DrawThemeBackground(ATheme, Handle,
                MENU_POPUPCHECK, CheckMarkStates[AMenuItem.Enabled, AMenuItem.RadioItem], ACheckRect, nil);
            end;
          end
          else
          begin
            ABitmapRect := Rect(0, 0, 16, 16);
            with AGlyphRect do
              OffSetRect(ABitmapRect, Left + ((Right - Left - 16) div 2),
                Top + ((Bottom - Top - 16) div 2));
            if AMenuItem.Bitmap.Width < ACheckSize.cx then
              with ABitmapRect do
              begin
                Left := Left + ((Right - Left) - AMenuItem.Bitmap.Width) div 2;
                Right := Left + AMenuItem.Bitmap.Width;
              end;
            if AMenuItem.Bitmap.Height < ACheckSize.cy then
              with ABitmapRect do
              begin
                Top := Top + ((Bottom - Top) - AMenuItem.Bitmap.Height) div 2;
                Bottom := Top + AMenuItem.Bitmap.Height;
              end;
            StretchDraw(ABitmapRect, AMenuItem.Bitmap);
          end;
        end;
      end;

      if ASelected then
        DrawThemeBackground(ATheme, Handle, MENU_POPUPITEM, MPI_HOT, ARect, nil);
      GetThemeMargins(ATheme, Handle, MENU_POPUPITEM, MPI_NORMAL, TMT_SIZINGMARGINS, nil, AMargins);
      ARect.Left := AGutterRect.Right;
      Inc(ARect.Left, AMargins.cxLeftWidth);

      if not AIsMenuSeparator then
      begin
        GetThemePartSize(ATheme, Handle, MENU_POPUPSUBMENU, MSM_NORMAL, nil, TS_TRUE, @ASize);
        Dec(ARect.Right, ASize.cx);
        ASaveRect := ARect;
        GetThemeColor(ATheme, MENU_POPUPITEM, ItemStates[AMenuItem.Enabled], TMT_TEXTCOLOR, AColorRef);
        Font.Color := AColorRef;
        DrawVistaMenuItemText(AMenuItem, ACanvas, AMenuItem.Caption, ARect, ASelected, ATextFlags or DT_CALCRECT or DT_NOCLIP, ATheme);
        OffsetRect(ARect, 0, ((ASaveRect.Bottom - ASaveRect.Top) - (ARect.Bottom - ARect.Top)) div 2);

        DrawVistaMenuItemText(AMenuItem, ACanvas, AMenuItem.Caption, ARect, ASelected, ATextFlags, ATheme);
        if (AMenuItem.ShortCut <> 0) and (AMenuItem.Count = 0) then
        begin
          AShortCutText := ShortCutToText(AMenuItem.ShortCut);
          ARect.Left := ARect.Right;
          ARect.Right := ASaveRect.Right - ASize.cx - AMargins.cxLeftWidth;
          DrawMenuItemText(AMenuItem, ACanvas, AShortCutText, ARect, ASelected, DT_RIGHT);
        end;
      end
      else
      begin
        ARect.Left := AGutterRect.Right + 1;
        GetThemeMargins(ATheme, Handle, MENU_POPUPSEPARATOR, 0, TMT_SIZINGMARGINS, nil, AMargins);
        Dec(ARect.Bottom, AMargins.cyBottomHeight);
        DrawThemeBackground(ATheme, Handle, MENU_POPUPSEPARATOR, 0, ARect, nil);
      end;
    end;
  end;

  procedure NormalDrawMenuItem;
  var
    ADrawBackground: Boolean;
    AGlyph: TBitmap;
  begin
    with ACanvas do
    begin
      if AWinXPFlatMenus or AreVisualStylesAvailable then
      begin
        if ASelected or (odHotLight in AState) then
        begin
          if AreVisualStylesAvailable then
            Brush.Color := clMenuHighlight
          else
            Brush.Color := clHighlight;
          Font.Color := clHighlightText;
        end;
      end;
      ADrawBackground := not ASelected or IsWinXPOrLater;
      if AIsMenuSeparator or (not AMenuItem.Checked and ADrawBackground) then
        FillRect(ARect);
      AGlyphRect.Left := ARect.Left + 1;
      AGlyphRect.Top := ARect.Top + 1;
      if AIsMenuSeparator then
      begin
        AGlyphRect.Left := 0;
        AGlyphRect.Right := -4;
      end
      else
      begin
        ADrawImage := ADrawImageListItem or (AMenuItem.Checked and AMenuItem.Bitmap.Empty);
        if ADrawImage or not AMenuItem.Bitmap.Empty then
        begin
          if ADrawImage then
          begin
            AGlyphRect.Right := AGlyphRect.Left + AImageList.Width;
            AGlyphRect.Bottom := AGlyphRect.Top + AImageList.Height;
          end
          else
          begin
            AGlyphRect.Right := AGlyphRect.Left + 16;
            AGlyphRect.Bottom := AGlyphRect.Top + 16;
          end;

          AOldBrushColor := Brush.Color;
          if AMenuItem.Checked then
          begin
            ACheckBkgRect := ARect;
            ACheckBkgRect.Right := ACheckBkgRect.Left + (ACheckBkgRect.Bottom - ACheckBkgRect.Top);
            Brush.Color := clBtnShadow;
            FrameRect(ACheckBkgRect);
            InflateRect(ACheckBkgRect, -1, -1);
            Brush.Color := clBtnFace;
            FillRect(ACheckBkgRect);
            Brush.Color := AOldBrushColor;
            OffsetRect(AGlyphRect, 1, 1);
          end;

          if ADrawImage then
          begin
            if ADrawImageListItem then
              AImageList.Draw(ACanvas, AGlyphRect.Left, AGlyphRect.Top, AMenuItem.ImageIndex, AMenuItem.Enabled)
            else
            begin
              AGlyph := TBitmap.Create;
              try
                AGlyph.Transparent := True;
                AGlyph.Handle := LoadBitmap(0, PChar(OBM_CHECK));
                AOldBrushColor := Font.Color;
                Font.Color := clBtnText;
                Draw(AGlyphRect.Left + (AGlyphRect.Right - AGlyphRect.Left - AGlyph.Width) div 2 + 1,
                  AGlyphRect.Top + (AGlyphRect.Bottom - AGlyphRect.Top - AGlyph.Height) div 2 + 1, AGlyph);
                Font.Color := AOldBrushColor;
              finally
                AGlyph.Free;
              end;
            end;
          end
          else
          begin
            ASaveRect := AGlyphRect;
            if AMenuItem.Bitmap.Width < AGlyphRect.Right - AGlyphRect.Left then
              with AGlyphRect do
              begin
                Left := Left + ((Right - Left) - AMenuItem.Bitmap.Width) div 2 + 1;
                Right := Left + AMenuItem.Bitmap.Width;
              end;
            if AMenuItem.Bitmap.Height < AGlyphRect.Bottom - AGlyphRect.Top then
              with AGlyphRect do
              begin
                Top := Top + ((Bottom - Top) - AMenuItem.Bitmap.Height) div 2 + 1;
                Bottom := Top + AMenuItem.Bitmap.Height;
              end;
            StretchDraw(AGlyphRect, AMenuItem.Bitmap);
            AGlyphRect := ASaveRect;
          end;
          if AMenuItem.Checked then
          begin
            if ADrawBackground then
            begin
              InflateRect(ACheckBkgRect, 1, 1);
              with ACheckBkgRect do
                ExcludeClipRect(Handle, Left, Top, Right, Bottom);
            end;
            Dec(AGlyphRect.Right);
            Dec(AGlyphRect.Bottom);
          end;
        end
        else
        begin
          AGlyphRect.Right := AGlyphRect.Left;
          AGlyphRect.Bottom := AGlyphRect.Top;
          if AImageList <> nil then
          begin
            Inc(AGlyphRect.Right, AImageList.Width);
            Inc(AGlyphRect.Bottom, AImageList.Height);
          end;
        end;
        if AMenuItem.Checked and ADrawBackground then
          FillRect(ARect);
      end;
      ARect.Left := AGlyphRect.Right + 3;
      Inc(ARect.Left, 2);
      Dec(ARect.Right, 1);
      ASaveRect := ARect;
      if odDefault in AState then
        Font.Style := [fsBold];
      DrawMenuItemText(AMenuItem, ACanvas, AMenuItem.Caption, ARect, ASelected, ATextFlags or DT_CALCRECT or DT_NOCLIP);
      OffsetRect(ARect, 0, ((ASaveRect.Bottom - ASaveRect.Top) - (ARect.Bottom - ARect.Top)) div 2);

      DrawMenuItemText(AMenuItem, ACanvas, AMenuItem.Caption, ARect, ASelected, ATextFlags);
      if (AMenuItem.ShortCut <> 0) and not (IsWinVistaOrLater and (AMenuItem.Count > 0)) then
      begin
        ARect.Left := ARect.Right;
        ARect.Right := ASaveRect.Right - 10;
        DrawMenuItemText(AMenuItem, ACanvas, ShortCutToText(AMenuItem.ShortCut), ARect, ASelected, DT_RIGHT);
      end;
    end;
  end;

begin
  if AMenuItem = nil then Exit;
  AIsMenuSeparator := AMenuItem.Caption = cLineCaption;
  AAlignment := GetAlignment;
  AParentMenu := AMenuItem.GetParentMenu;
  AImageList := AMenuItem.GetImageList;
  ADrawImageListItem := (AImageList <> nil) and (AMenuItem.ImageIndex >= 0) and
    (AMenuItem.ImageIndex < AImageList.Count);
  ASelected := odSelected in AState;
  AWinXPFlatMenus := IsWinXPOrLater and AreVisualStylesAvailable and
    GetThemeSysBool(0, TMT_FLATMENUS);
  ATextFlags := GetTextFlags;
{$IFDEF DELPHI11}
  if IsWinVistaOrLater then
    ATheme := OpenTheme(totMenu)
  else
{$ENDIF}
    ATheme := 0;
  if ATheme <> 0 then
    VistaDrawMenuItem
  else
    NormalDrawMenuItem;
end;

{ TcxBitmap }

constructor TcxBitmap.Create;
begin
  CreateSize(0, 0);
end;

constructor TcxBitmap.CreateSize(const ARect: TRect);
begin
  CreateSize(cxRectWidth(ARect), cxRectHeight(ARect));
end;

constructor TcxBitmap.CreateSize(AWidth, AHeight: Integer);
begin
  CreateSize(AWidth, AHeight, pf24bit);
end;

constructor TcxBitmap.CreateSize(const ARect: TRect; APixelFormat: TPixelFormat);
begin
  CreateSize(cxRectWidth(ARect), cxRectHeight(ARect), APixelFormat);
end;

constructor TcxBitmap.CreateSize(AWidth, AHeight: Integer; APixelFormat: TPixelFormat);
begin
  inherited Create;

  Initialize(AWidth, AHeight, APixelFormat);
end;

destructor TcxBitmap.Destroy;
begin
  FreeAndNil(FcxCanvas);
  inherited;
end;

procedure TcxBitmap.BeginUpdate;
begin
  Inc(FLockCount);
end;

procedure TcxBitmap.CancelUpdate;
begin
  Dec(FLockCount);
end;

procedure TcxBitmap.EndUpdate(AForceUpdate: Boolean = True);
begin
  Dec(FLockCount);
  if (FLockCount = 0) and (AForceUpdate or FModified) then
    Changed(Self);
end;

procedure TcxBitmap.CopyBitmap(ABitmap: TBitmap; ACopyMode: DWORD = SRCCOPY);
begin
  CopyBitmap(ABitmap, ClientRect, cxNullPoint, ACopyMode);
end;

procedure TcxBitmap.CopyBitmap(ABitmap: TBitmap; const ADestRect: TRect; const ASrcTopLeft: TPoint; ACopyMode: DWORD);
begin
  cxBitBlt(Canvas.Handle, ABitmap.Canvas.Handle, ADestRect, ASrcTopLeft, ACopyMode);
end;

procedure TcxBitmap.Rotate(ARotationAngle: TcxRotationAngle; AFlipVertically: Boolean);
begin
  cxCanvas.RotateBitmap(Self, ARotationAngle, AFlipVertically);
end;

procedure TcxBitmap.SetSize(AWidth, AHeight: Integer);
begin
  AWidth  := Max(0, AWidth);
  AHeight := Max(0, AHeight);
  if (AWidth <> Width) or (AHeight <> Height) then
  begin
    BeginUpdate;
    try
    {$IFDEF DELPHI10}
      inherited SetSize(AWidth, AHeight);
    {$ELSE}
      Width := AWidth;
      Height := AHeight;
    {$ENDIF}
    finally
      EndUpdate(False);
    end;
  end;
end;

procedure TcxBitmap.SetSize(const ARect: TRect);
begin
  SetSize(cxRectWidth(ARect), cxRectHeight(ARect));
end;

procedure TcxBitmap.Changed(Sender: TObject);
begin
  if not ChangeLocked then
  begin
    inherited;
    Update;
    FModified := False;
  end
  else
    FModified := True;
end;

function TcxBitmap.ChangeLocked: Boolean;
begin
  Result := FLockCount > 0;
end;

procedure TcxBitmap.Initialize(AWidth, AHeight: Integer; APixelFormat: TPixelFormat);
begin
  FcxCanvas := TcxCanvas.Create(Canvas);

  BeginUpdate;
  try
    PixelFormat := APixelFormat;
    SetSize(AWidth, AHeight);
  finally
    EndUpdate;
  end;
end;

procedure TcxBitmap.Update;
begin
// do nothing
end;

const
  ADXBMSignature: Integer = $4D424458; //DXBM
  ADXBMVersion: Word = 2;

procedure TcxBitmap.ReadData(Stream: TStream);
var
  ASize: Integer;
  ASignature: Integer;
  AVersion: Word;
  AStreamPos: Integer;
  AMemoryStream: TMemoryStream;
begin
  AStreamPos := Stream.Position;
  Stream.Read(ASize, SizeOf(ASize));
  Stream.Read(ASignature, SizeOf(ASignature));
  Stream.Read(AVersion, SizeOf(AVersion));
  if ASignature <> ADXBMSignature then
  begin
    Stream.Position := AStreamPos;
    inherited ReadData(Stream);
  end
  else
  begin
    AMemoryStream := TMemoryStream.Create;
    try
      case AVersion of
        1: Decompress1(Stream, AMemoryStream, ASize);
        2: Decompress2(Stream, AMemoryStream, ASize);
      end;
      AMemoryStream.Position := 0;
      inherited ReadData(AMemoryStream);
    finally
      AMemoryStream.Free;
    end;
  end;
end;

procedure TcxBitmap.WriteData(Stream: TStream);

  procedure WriteSignature(AStream: TStream; ASize, ASignaturePosition: Integer);
  var
    ACurrentPos: Integer;
  begin
    ACurrentPos := AStream.Position;
    AStream.Position := ASignaturePosition;
    AStream.Write(ASize, SizeOf(ASize));
    AStream.Write(ADXBMSignature, SizeOf(ADXBMSignature));
    AStream.Write(ADXBMVersion, SizeOf(ADXBMVersion));
    AStream.Position := ACurrentPos;
  end;

var
  AMemoryStream: TMemoryStream;
  ASignaturePosition, ADataOffset: Integer;
  ASize: Integer;
begin
  if CompressData then
  begin
    AMemoryStream := TMemoryStream.Create;
    try
      inherited WriteData(AMemoryStream);
      AMemoryStream.Position := 0;
      ASignaturePosition := Stream.Position;
      ADataOffset := SizeOf(ASize) + SizeOf(ADXBMSignature) + SizeOf(ADXBMVersion);
      Stream.Position := Stream.Position + ADataOffset;
      Compress(AMemoryStream, Stream, AMemoryStream.Size);
    finally
      AMemoryStream.Free;
    end;
    ASize := Stream.Position - ADataOffset;
    WriteSignature(Stream, ASize, ASignaturePosition);
  end
  else
    inherited;
end;

type
  TSeekMode = (smDup, smUnique);
const
  AModeMap: array[Boolean] of TSeekMode = (smDup, smUnique);
  AModeMask: array[TSeekMode] of Byte = (0, 128);

function ReadByte(AStream: TStream; AMaxPos: Integer; var AByte: Byte): Boolean;
begin
  Result := AStream.Position < AMaxPos;
  if Result then
    AStream.Read(AByte, SizeOf(Byte));
end;

procedure WriteByte(AStream: TStream; AByte: Byte);
begin
  AStream.Write(AByte, SizeOf(Byte));
end;

function CompareBlock(ABlock1, ABlock2: TBytes): Boolean;
begin
  Result := (Length(ABlock1) = Length(ABlock2)) and CompareMem(ABlock1, ABlock2, Length(ABlock1));
end;

function ReadBlock(AStream: TStream; AMaxPos: Integer; var ABlock: TBytes; ABlockSize: Integer): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to ABlockSize - 1 do
    Result := Result and ReadByte(AStream, AMaxPos, ABlock[I]);
end;

procedure WriteBlock(AStream: TStream; ABlock: TBytes; ABlockSize: Integer);
var
  I: Integer;
begin
  for I := 0 to ABlockSize - 1 do
    WriteByte(AStream, ABlock[I]);
end;

procedure TcxBitmap.CompressByBlock(ASourceStream, ADestStream: TStream; ASize, ABlockSize: Integer);

  function GetCounter(ASeekBlock: TBytes; AMode: TSeekMode; AMaxPos: Integer): Integer;
  var
    ABlock: TBytes;
  begin
    Result := 1;
    SetLength(ABlock, ABlockSize);
    while (Result < 125) and ReadBlock(ASourceStream, AMaxPos, ABlock, ABlockSize) do
    begin
      if (AMode = smDup) and CompareBlock(ABlock, ASeekBlock) or (AMode = smUnique) and not CompareBlock(ABlock, ASeekBlock) then
        Inc(Result)
      else
      begin
        if AMode = smUnique then
          Dec(Result);
        Break;
      end;
      cxCopyData(ABlock, ASeekBlock, ABlockSize);
    end;
  end;

var
  AReadBlock1, AReadBlock2: TBytes;
  ACounter, AReadedCount: Integer;
  AStreamPos, AMaxPos: Integer;
  AMode: TSeekMode;
begin
  AMaxPos := ASourceStream.Position + ASize;

  SetLength(AReadBlock1, ABlockSize);
  SetLength(AReadBlock2, ABlockSize);

  while ReadBlock(ASourceStream, AMaxPos, AReadBlock1, ABlockSize) do
  begin
    AReadedCount := ABlockSize;
    AStreamPos := ASourceStream.Position - ABlockSize;
    if ReadBlock(ASourceStream, AMaxPos, AReadBlock2, ABlockSize) then
    begin
      Inc(AReadedCount, ABlockSize);
      AMode := AModeMap[(AReadedCount = ABlockSize) or not CompareBlock(AReadBlock1, AReadBlock2)];
      ASourceStream.Position := ASourceStream.Position - (AReadedCount - ABlockSize);
      ACounter := GetCounter(AReadBlock1, AMode, AMaxPos);
    end
    else
    begin
      AMode := smUnique;
      ACounter := 1;
    end;

    WriteByte(ADestStream, ACounter or AModeMask[AMode]);
    case AMode of
      smUnique:
        begin
          ASourceStream.Position := AStreamPos;
          ADestStream.CopyFrom(ASourceStream, ACounter * ABlockSize);
        end;
      smDup:
        WriteBlock(ADestStream, AReadBlock1, ABlockSize);
    end;
    ASourceStream.Position := AStreamPos + ACounter * ABlockSize;
  end;
end;

procedure TcxBitmap.DecompressByBlock(ASourceStream, ADestStream: TStream; ASize, ABlockSize: Integer);
var
  ACode: Byte;
  AReadBlob: TBytes;
  AMaxPos: Integer;
  I: Integer;
  ACounter: Integer;
begin
  AMaxPos := ASourceStream.Position + ASize;

  SetLength(AReadBlob, ABlockSize);

  while ReadByte(ASourceStream, AMaxPos, ACode) do
  begin
    ACounter := ACode and 127;
    if (ACode and AModeMask[smUnique]) <> 0 then
      ADestStream.CopyFrom(ASourceStream, ACounter * ABlockSize)
    else
    begin
      ReadBlock(ASourceStream, AMaxPos, AReadBlob, ABlockSize);
      for I := 0 to ACounter - 1 do
        WriteBlock(ADestStream, AReadBlob, ABlockSize);
    end;
  end;
end;

procedure TcxBitmap.Compress(ASourceStream, ADestStream: TStream; ASize: Integer);
var
  ABlockSize, AShift: Byte;
begin
  ABlockSize := Max(cxGetBitmapPixelFormat(Self) div 8, 1);
  AShift := ASourceStream.Size mod ABlockSize;
  WriteByte(ADestStream, ABlockSize);
  WriteByte(ADestStream, AShift);
  if AShift > 0 then
    ADestStream.CopyFrom(ASourceStream, AShift);
  CompressByBlock(ASourceStream, ADestStream, ASize - AShift, ABlockSize);
end;

procedure TcxBitmap.Decompress1(ASourceStream, ADestStream: TStream; ASize: Integer);
begin
  DecompressByBlock(ASourceStream, ADestStream, ASize, 1);
end;

procedure TcxBitmap.Decompress2(ASourceStream, ADestStream: TStream; ASize: Integer);
var
  ABlockSize, AShift: Byte;
begin
  ReadByte(ASourceStream, ASize, ABlockSize);
  ReadByte(ASourceStream, ASize, AShift);
  if AShift > 0 then
    ADestStream.CopyFrom(ASourceStream, AShift);
  DecompressByBlock(ASourceStream, ADestStream, ASize - (2 + AShift), ABlockSize);
end;

function TcxBitmap.GetClientRect: TRect;
begin
  Result := Rect(0, 0, Width, Height);
end;

{ TcxAlphaBitmap }

function TcxColorList.Add(AColor: TColor): Integer;
begin
  Result := inherited Add(Pointer(cxColorEssence(dxColorToRGBQuad(AColor))));
end;

{ TcxBitmap32 }

constructor TcxBitmap32.CreateSize(AWidth, AHeight: Integer; AClear: Boolean);
begin
  CreateSize(AWidth, AHeight, pf32bit);
  if AClear then
    Clear;
end;

constructor TcxBitmap32.CreateSize(const ARect: TRect; AClear: Boolean);
begin
  CreateSize(ARect, pf32bit);
  if AClear then
    Clear;
end;

constructor TcxBitmap32.CreateSize(AWidth, AHeight: Integer);
begin
  CreateSize(AWidth, AHeight, pf32bit);
end;

procedure TcxBitmap32.GetBitmapColors(out AColors: TRGBColors);
begin
  if not GetBitmapBits(Self, AColors, False) then
    GetBitmapBitsByScanLine(Self, AColors);
end;

procedure TcxBitmap32.SetBitmapColors(const AColors: TRGBColors);
begin
  SetBitmapBits(Self, AColors, False);
end;

procedure TcxBitmap32.AlphaBlend(ABitmap: TcxBitmap32; const ARect: TRect; ASmoothImage: Boolean; AConstantAlpha: Byte = $FF);
begin
  cxAlphaBlend(ABitmap, Self, ARect, ClientRect, ASmoothImage, AConstantAlpha);
end;

procedure TcxBitmap32.Clear;
begin
  FillRect(Canvas.Handle, ClientRect, GetStockObject(BLACK_BRUSH));
end;

procedure TcxBitmap32.Filter(AMaskBitmap: TcxBitmap32);
const
  DSna = $00220326;
begin
  CopyBitmap(AMaskBitmap, DSna);
end;

procedure TcxBitmap32.Invert;
begin
  CopyBitmap(Self, NOTSRCCOPY);
end;

procedure TcxBitmap32.Lighten(APercent: Byte);
var
  AColors: TRGBColors;
  I: Integer;
begin
  GetBitmapColors(AColors);
  for I := 0 to Length(AColors) - 1 do
    with AColors[I] do
    begin
      rgbRed := Byte(Trunc(255 - APercent / 100 * (255 - rgbRed)));
      rgbGreen := Byte(Trunc(255 - APercent / 100 * (255 - rgbGreen)));
      rgbBlue := Byte(Trunc(255 - APercent / 100 * (255 - rgbBlue)));
    end;
  SetBitmapColors(AColors);
end;

procedure TcxBitmap32.LoadFromStream(Stream: TStream);
begin
  BeginUpdate;
  try
    inherited LoadFromStream(Stream);
  finally
    PixelFormat := pf32bit;
    EndUpdate;
  end;
end;

procedure TcxBitmap32.MakeOpaque;
begin
  SetAlphaChannel($FF);
end;

procedure TcxBitmap32.RecoverTransparency(ATransparentColor: TColor);
var
  AColors: TRGBColors;
  AColor: TRGBQuad;
  ATransparentBGR: DWORD;
  I: Integer;
begin
  ATransparentBGR := cxColorEssence(dxColorToRGBQuad(ATransparentColor));
  GetBitmapColors(AColors);
  for I := 0 to Length(AColors) - 1 do
  begin
    AColor := AColors[I];
    if cxColorEssence(AColor) = ATransparentBGR then
      Cardinal(AColors[I]) := 0
    else
      if AColor.rgbReserved = 0 then
        AColors[I].rgbReserved := 255;
  end;
  SetBitmapColors(AColors);
end;

procedure TcxBitmap32.SetAlphaChannel(Alpha: Byte);
var
  AColors: TRGBColors;
  I: Integer;
begin
  GetBitmapColors(AColors);
  for I := 0 to Length(AColors) - 1 do
    AColors[I].rgbReserved := Alpha;
  SetBitmapColors(AColors);
end;

procedure TcxBitmap32.Update;
begin
  if cxGetBitmapPixelFormat(Self) <> 32 then
    raise EdxException.Create('Wrong PixelFormat');
end;

function TcxBitmap32.GetIsAlphaUsed: Boolean;
begin
  Result := dxIsAlphaUsed(Self);
end;

{ TcxAlphaBitmap }

constructor TcxAlphaBitmap.CreateSize(AWidth, AHeight: Integer);
begin
  inherited; //CBUILDER workaround
end;

constructor TcxAlphaBitmap.CreateSize(AWidth, AHeight: Integer; ATransparentBkColor: TRGBQuad);
begin
  inherited CreateSize(AWidth, AHeight, pf32bit);

  TransparentBkColor := ATransparentBkColor;
end;

destructor TcxAlphaBitmap.Destroy;
begin
  FreeAndNil(FTransparentPixels);
  inherited;
end;

procedure TcxAlphaBitmap.Clear;
begin
  if FTransparentBkColor.rgbReserved <> 0 then
    TransformBitmap(btmClear)
  else
    inherited;
end;

procedure TcxAlphaBitmap.DrawHatch(const AHatchData: TcxHatchData);
begin
  HatchData := AHatchData;
  TransformBitmap(btmHatch);
end;

procedure TcxAlphaBitmap.DrawHatch(AColor1, AColor2: TColor; AStep, AAlpha1, AAlpha2: Byte);
var
  AHatchData: TcxHatchData;
begin
  AHatchData.Color1 := dxColorToRGBQuad(AColor1, $FF);
  AHatchData.Alpha1 := AAlpha1;
  AHatchData.Color2 := dxColorToRGBQuad(AColor2, $FF);
  AHatchData.Alpha2 := AAlpha2;
  AHatchData.Step := AStep;
  DrawHatch(AHatchData);
end;

procedure TcxAlphaBitmap.DrawShadow(AMaskBitmap: TcxAlphaBitmap; AShadowSize: Integer; AShadowColor: TColor; AInflateSize: Boolean);
const
  DPSnaa = $00200F09;
var
  AShadowBitmap, ASelfCopy: TcxAlphaBitmap;
begin
  AShadowBitmap := TcxAlphaBitmap.CreateSize(Width + AShadowSize * 2, Height + AShadowSize * 2, ClrNone);
  try
    AShadowBitmap.Clear;
    AShadowBitmap.CopyBitmap(AMaskBitmap, cxRectOffset(ClientRect, AShadowSize, AShadowSize), cxNullPoint);
    AShadowBitmap.Canvas.Brush.Color := AShadowColor;
    AShadowBitmap.Canvas.CopyMode := DPSnaa;
    AShadowBitmap.Canvas.Draw(AShadowSize, AShadowSize, AShadowBitmap);

    AShadowBitmap.TransparentBkColor := ClrTransparent;
    AShadowBitmap.TransformBitmap(btmCorrectBlend);

    ASelfCopy := TcxAlphaBitmap.CreateSize(Width + AShadowSize, Height + AShadowSize, True);
    try
      ASelfCopy.CopyBitmap(Self);
      ASelfCopy.CopyBitmap(AShadowBitmap, ASelfCopy.ClientRect, Point(AShadowSize, AShadowSize), SRCPAINT);
      if AInflateSize then
        SetSize(Width + AShadowSize, Height + AShadowSize);
      CopyBitmap(ASelfCopy);
    finally
      ASelfCopy.Free;
    end;
  finally
    AShadowBitmap.Free;
  end;
end;

procedure TcxAlphaBitmap.RecoverAlphaChannel(ATransparentColor: TColor);
begin
  TransparentPixels.Clear;
  TransparentPixels.Add(ATransparentColor);
  TransparentBkColor := dxColorToRGBQuad(ATransparentColor);
  TransformBitmap(btmCorrectBlend);
end;

procedure TcxAlphaBitmap.Shade(AMaskBitmap: TcxAlphaBitmap);
const
  DSPDxax = $00E20746;
begin
  AMaskBitmap.Canvas.CopyMode := cmPatInvert;
  AMaskBitmap.Canvas.Draw(0, 0, AMaskBitmap);

  Canvas.CopyMode := cmSrcCopy;
  Canvas.Draw(1, 1, AMaskBitmap);

  Canvas.CopyMode := DSPDxax;
  Canvas.Brush.Color := clBtnShadow;
  Canvas.Draw(0, 0, AMaskBitmap);

  TransformBitmap(btmCorrectBlend);
end;

procedure TcxAlphaBitmap.TransformBitmap(AMode: TcxBitmapTransformationMode);
var
  AColors: TRGBColors;
  I, J: Integer;
  ATransformProc: TcxBitmapTransformationProc;
begin
  case AMode of
    btmDingy:
      ATransformProc := Dingy;
    btmDirty:
      ATransformProc := Dirty;
    btmGrayScale:
      ATransformProc := GrayScale;
    btmSetOpaque:
      ATransformProc := SetOpaque;
    btmMakeMask:
      ATransformProc := MakeMask;
    btmFade:
      ATransformProc := Fade;
    btmDisable:
      ATransformProc := Disable;
    btmCorrectBlend:
      ATransformProc := CorrectBlend;
    btmHatch:
      ATransformProc := Hatch;
    btmClear:
      ATransformProc := ClearColor;
    btmResetAlpha:
      ATransformProc := ResetAlpha;
  else
    Exit;
  end;

  GetBitmapColors(AColors);

  for I := 0 to Width - 1 do
    for J := 0 to Height - 1 do
    begin
      FCurrentColorIndex.X := I;
      FCurrentColorIndex.Y := J;

      ATransformProc(AColors[J * Width + I]);
    end;

  SetBitmapColors(AColors);
  Changed(Self);
end;

procedure TcxAlphaBitmap.Initialize(AWidth, AHeight: Integer; APixelFormat: TPixelFormat);
begin
  FTransparentPixels := TcxColorList.Create;
  inherited;
end;

procedure TcxAlphaBitmap.RefreshImage(AWidth, AHeight: Integer);
begin
  SetSize(AWidth, AHeight);
  TransparentPixels.Clear;
  Clear;
end;

procedure TcxAlphaBitmap.RefreshImage(const ARect: TRect);
begin
  RefreshImage(cxRectWidth(ARect), cxRectHeight(ARect));
end;

procedure TcxAlphaBitmap.CorrectBlend(var AColor: TRGBQuad);
begin
  if not IsColorTransparent(AColor) and (AColor.rgbReserved = 0) then
    AColor.rgbReserved := $FF;
end;

procedure TcxAlphaBitmap.ClearColor(var AColor: TRGBQuad);
begin
  AColor := TransparentBkColor;
end;

procedure TcxAlphaBitmap.Dingy(var AColor: TRGBQuad);

  procedure LightColor(var AColor: Byte);
  begin
    AColor := GetChannelValue(AColor + MulDiv(255 - AColor, 3, 10));
  end;

  procedure BlendColor(var AColor: Byte);
  begin
    AColor := GetChannelValue(MulDiv(AColor, 200, 255));
  end;

begin
  if not IsColorTransparent(AColor) then
  begin
    if AColor.rgbReserved = $FF then
    begin
      LightColor(AColor.rgbRed);
      LightColor(AColor.rgbGreen);
      LightColor(AColor.rgbBlue);
    end
    else
    begin
      BlendColor(AColor.rgbRed);
      BlendColor(AColor.rgbGreen);
      BlendColor(AColor.rgbBlue);
      BlendColor(AColor.rgbReserved);
    end;
  end;
end;

procedure TcxAlphaBitmap.Dirty(var AColor: TRGBQuad);
var
  ADirtyScreen:TRGBQuad;
begin
  if not IsColorTransparent(AColor) then
  begin
    Scale(AColor, GrayMap);

    ADirtyScreen := dxColorToRGBQuad(clBtnShadow);
    ADirtyScreen.rgbReserved := $C0;

    cxBlendFunction(ADirtyScreen, AColor, $EE);
  end;
end;

procedure TcxAlphaBitmap.Disable(var AColor: TRGBQuad);
begin
  if not IsColorTransparent(AColor) then
    Scale(AColor, DisableMap);
end;

procedure TcxAlphaBitmap.Fade(var AColor: TRGBQuad);
begin
  if not IsColorTransparent(AColor) then
    Scale(AColor, FadeMap);
end;

procedure TcxAlphaBitmap.GrayScale(var AColor: TRGBQuad);
var
  AValue: Byte;
begin
  if not IsColorTransparent(AColor) then
  begin
    AValue := (AColor.rgbRed + AColor.rgbGreen + AColor.rgbBlue) div 3;
    AColor.rgbRed := AValue;
    AColor.rgbGreen := AValue;
    AColor.rgbBlue := AValue;
  end;
end;

procedure TcxAlphaBitmap.Hatch(var AColor: TRGBQuad);
begin
  if Odd(FCurrentColorIndex.X div FHatchData.Step + FCurrentColorIndex.Y div FHatchData.Step) then
    cxBlendFunction(FHatchData.Color2, AColor, FHatchData.Alpha2)
  else
    cxBlendFunction(FHatchData.Color1, AColor, FHatchData.Alpha1);
end;

procedure TcxAlphaBitmap.MakeMask(var AColor: TRGBQuad);
begin
  if IsColorTransparent(AColor) then
    AColor := ClrNone
  else
    AColor := ClrTransparent;
end;

procedure TcxAlphaBitmap.SetOpaque(var AColor: TRGBQuad);
begin
  AColor.rgbReserved := $FF;
end;

procedure TcxAlphaBitmap.ResetAlpha(var AColor: TRGBQuad);
begin
  AColor.rgbReserved := 0;
end;

procedure TcxAlphaBitmap.Scale(var AColor: TRGBQuad; const AColorMap: TcxColorTransitionMap);
var
  AResultValue: Byte;
begin
  AResultValue := Round(AColorMap.RedScale * AColor.rgbRed + AColorMap.GreenScale * AColor.rgbGreen + AColorMap.BlueScale * AColor.rgbBlue);
  AColor.rgbBlue := AResultValue;
  AColor.rgbGreen := AResultValue;
  AColor.rgbRed := AResultValue;
end;

function TcxAlphaBitmap.IsColorTransparent(const AColor: TRGBQuad): Boolean;

  function IsTransparentPixel(AColor: DWORD): Boolean;
  begin
    Result := TransparentPixels.IndexOf(Pointer(AColor)) <> -1;
  end;

begin
  Result := cxColorIsEqual(AColor, TransparentBkColor) or IsTransparentPixel(cxColorEssence(AColor));
end;

{ TcxImageInfo }

constructor TcxImageInfo.Create;
begin
  inherited Create;
  FImage := TcxBitmap.Create;
  FMask := TcxBitmap.Create;
  FMaskColor := clNone;
end;

destructor TcxImageInfo.Destroy;
begin
  FreeAndNil(FMask);
  FreeAndNil(FImage);
  inherited;
end;

procedure TcxImageInfo.Assign(Source: TPersistent);
begin
  if Source is TcxImageInfo then
  begin
    Image := TcxImageInfo(Source).Image;
    Mask := TcxImageInfo(Source).Mask;
    MaskColor := TcxImageInfo(Source).MaskColor;
  end
  else
    inherited;
end;

procedure TcxImageInfo.SetImage(Value: TBitmap);
begin
  AssignBitmap(Value, Image);
end;

procedure TcxImageInfo.SetMask(Value: TBitmap);
begin
  AssignBitmap(Value, Mask);
end;

procedure TcxImageInfo.AssignBitmap(ASourceBitmap, ADestBitmap: TBitmap);
begin
  ADestBitmap.Assign(ASourceBitmap);
  ADestBitmap.Handle; // HandleNeeded
end;

{ TcxImageList }

type
  TcxImageInfoItem = class(TCollectionItem)
  private
    FImageInfo: TcxImageInfo;

    function GetCompressData: Boolean;
    function GetImage: TBitmap;
    function GetMask: TBitmap;
    function GetMaskColor: TColor;
    procedure SetCompressData(Value: Boolean);
    procedure SetImage(Value: TBitmap);
    procedure SetMask(Value: TBitmap);
    procedure SetMaskColor(Value: TColor);
  public
    constructor Create(ACollection: TCollection); overload; override;
    constructor Create(ACollection: TCollection; AImage, AMask: TBitmap; AMaskColor: TColor = clNone); reintroduce; overload;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    property CompressData: Boolean read GetCompressData write SetCompressData;
    property ImageInfo: TcxImageInfo read FImageInfo;
  published
    property Image: TBitmap read GetImage write SetImage;
    property Mask: TBitmap read GetMask write SetMask;
    property MaskColor: TColor read GetMaskColor write SetMaskColor default clNone;
  end;

  TcxImageInfoCollection = class(TCollection)
  private
    FCompressData: Boolean;
    FImageList: TcxImageList;
    procedure SetCompressData(Value: Boolean);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AImageList: TcxImageList);
    function Add(AImage, AMask: TBitmap; AMaskColor: TColor = clNone): TCollectionItem;
    procedure Move(ACurrentIndex, ANewIndex: Integer);
    procedure Delete(AIndex: Integer);

    property CompressData: Boolean read FCompressData write SetCompressData;
  end;

constructor TcxImageInfoItem.Create(ACollection: TCollection);
begin
  inherited;
  FImageInfo := TcxImageInfo.Create;
  CompressData := TcxImageInfoCollection(ACollection).CompressData;
end;

constructor TcxImageInfoItem.Create(ACollection: TCollection; AImage, AMask: TBitmap; AMaskColor: TColor);
begin
  Create(ACollection);
  Image := AImage;
  Mask := AMask;
  MaskColor := AMaskColor;
end;

destructor TcxImageInfoItem.Destroy;
begin
  FreeAndNil(FImageInfo);
  inherited;
end;

procedure TcxImageInfoItem.Assign(Source: TPersistent);
begin
  if Source is TcxImageInfoItem then
    FImageInfo.Assign(TcxImageInfoItem(Source).ImageInfo)
  else
    inherited;
end;

function TcxImageInfoItem.GetCompressData: Boolean;
begin
  Result := TcxBitmap(Image).CompressData and TcxBitmap(Mask).CompressData;
end;

function TcxImageInfoItem.GetImage: TBitmap;
begin
  Result := FImageInfo.Image;
end;

function TcxImageInfoItem.GetMask: TBitmap;
begin
  Result := FImageInfo.Mask;
end;

function TcxImageInfoItem.GetMaskColor: TColor;
begin
  Result := FImageInfo.MaskColor;
end;

procedure TcxImageInfoItem.SetCompressData(Value: Boolean);
begin
  if CompressData <> Value then
  begin
    TcxBitmap(Image).CompressData := Value;
    TcxBitmap(Mask).CompressData := Value;
  end;
end;

procedure TcxImageInfoItem.SetImage(Value: TBitmap);
begin
  FImageInfo.Image := Value;
end;

procedure TcxImageInfoItem.SetMask(Value: TBitmap);
begin
  FImageInfo.Mask := Value;
end;

procedure TcxImageInfoItem.SetMaskColor(Value: TColor);
begin
  FImageInfo.MaskColor := Value;
end;

constructor TcxImageInfoCollection.Create(AImageList: TcxImageList);
begin
  inherited Create(TcxImageInfoItem);
  FImageList := AImageList;
end;

function TcxImageInfoCollection.Add(AImage, AMask: TBitmap; AMaskColor: TColor = clNone): TCollectionItem;
begin
  Result := TcxImageInfoItem.Create(Self, AImage, AMask, AMaskColor);
end;

procedure TcxImageInfoCollection.Move(ACurrentIndex, ANewIndex: Integer);
begin
  Items[ACurrentIndex].Index := ANewIndex;
end;

procedure TcxImageInfoCollection.Delete(AIndex: Integer);
begin
  if AIndex = -1 then
    Clear
  else
    inherited Delete(AIndex);
end;

function TcxImageInfoCollection.GetOwner: TPersistent;
begin
  Result := FImageList;
end;

procedure TcxImageInfoCollection.SetCompressData(Value: Boolean);
var
  I: Integer;
begin
  if CompressData <> Value then
  begin
    FCompressData := Value;
    for I := 0 to Count - 1 do
      TcxImageInfoItem(Items[I]).CompressData := Value;
  end;
end;

procedure cxCopyBitmap(ADestBitmap, ASrcBitmap: TBitmap); overload;
begin
  cxDrawBitmap(ADestBitmap.Canvas.Handle, ASrcBitmap,
    Rect(0, 0, ADestBitmap.Width, ADestBitmap.Height), cxNullPoint);
  TBitmapAccess(ADestBitmap).Changed(ADestBitmap);
end;

function cxCloneBitmap(ABitmap: TBitmap): TBitmap;
begin
  Result := TBitmap.Create;
  Result.Assign(ABitmap);
end;

function cxCopyImage(ASrcHandle: HBITMAP): HBITMAP; overload;

  function SystemCopyImage: HBITMAP;
  begin
    Result := CopyImage(ASrcHandle, IMAGE_BITMAP, 0, 0, LR_CREATEDIBSECTION);
  end;

  function SoftwareCopyImage: HBITMAP;
  var
    ABitmapData: Windows.TBitmap;
    ABitmapInfo: TBitmapInfo;
    ADestinationBits: Pointer;
    ABits: TBytes;
  begin
    cxGetBitmapData(ASrcHandle, ABitmapData);
    if ABitmapData.bmBitsPixel = 32 then
    begin
      dxFillBitmapInfoHeader(ABitmapInfo.bmiHeader, ABitmapData.bmWidth, ABitmapData.bmHeight, False);
      if ABitmapData.bmBits = nil then
      begin
        SetLength(ABits, ABitmapData.bmWidth * ABitmapData.bmHeight * 4);
        GetDIBits(cxScreenCanvas.Handle, ASrcHandle, 0, ABitmapData.bmHeight, ABits, ABitmapInfo, 0);
        cxScreenCanvas.Dormant;
        ABitmapData.bmBits := ABits;
      end;
      Result := CreateDIBSection(0, ABitmapInfo, DIB_RGB_COLORS, ADestinationBits, 0, 0);
      cxCopyData(ABitmapData.bmBits, ADestinationBits, ABitmapData.bmWidth * ABitmapData.bmHeight * 4);
    end
    else
      Result := SystemCopyImage;
  end;

begin
  if IsWin9X then
    Result := SoftwareCopyImage
  else
    Result := SystemCopyImage;
end;

function IsImageListsEqual(AImages1, AImages2: TCustomImageList): Boolean;
var
  AStream1, AStream2: TMemoryStream;
  AnAdapter1, AnAdapter2: TStreamAdapter;
begin
  if AImages1.Count <> AImages2.Count then
    Result := False
  else
    if AImages1.Count = 0 then
      Result := True
    else
    begin
      AStream1 := TMemoryStream.Create;
      AStream2 := TMemoryStream.Create;
      AnAdapter1 := TStreamAdapter.Create(AStream1);
      AnAdapter2 := TStreamAdapter.Create(AStream2);
      try
        ImageList_Write(AImages1.Handle, AnAdapter1);
        ImageList_Write(AImages2.Handle, AnAdapter2);
        Result := (AStream1.Size = AStream2.Size) and CompareMem(AStream1.Memory, AStream2.Memory, AStream1.Size);
      finally
        AnAdapter2.Free;
        AnAdapter1.Free;
        AStream2.Free;
        AStream1.Free;
      end;
    end;
end;

function GetImageCount(ABitmap: TBitmap; AWidth, AHeight: Integer): Integer;
begin
  if (ABitmap.Width mod AWidth) + (ABitmap.Height mod AHeight) = 0 then
    Result := (ABitmap.Width div AWidth) * (ABitmap.Height div AHeight)
  else
    Result := 1;
end;

destructor TcxImageList.Destroy;
begin
  Finalize;
  inherited;
end;

procedure TcxImageList.Assign(Source: TPersistent);
var
  AImages: TCustomImageList;
begin
  if Source is TCustomImageList then
  begin
    BeginUpdate;
    try
      inherited;
      Clear;
      AImages := TCustomImageList(Source);
      if AImages is TcxImageList then
        InternalCopyImageInfos(TcxImageList(AImages), 0, AImages.Count - 1)
      else
        InternalCopyImages(AImages, 0, AImages.Count - 1);
    finally
      EndUpdate;
    end;
  end;
end;

function TcxImageList.Add(AImage, AMask: TBitmap): Integer;
var
  AImageHandle, AMaskHandle: HBITMAP;
  AMaskBits: TBytes;
begin
  AImageHandle := GetImageHandle(AImage);
  if AMask = nil then
  begin
    SetLength(AMaskBits, AImage.Width * AImage.Height);
    AMaskHandle := CreateBitmap(Width, Height, 1, 1, AMaskBits);
  end
  else
    AMaskHandle := AMask.Handle;
  Result := ImageList_Add(Handle, AImageHandle, AMaskHandle);
  if NeedSynchronizeImageInfo and (Result <> -1) then
    AddToInternalCollection(AImage, AMask);
  if AMask = nil then
    DeleteObject(AMaskHandle);
  Change;
end;

function TcxImageList.AddIcon(AIcon: TIcon): Integer;
var
  AImage, AMask: TBitmap;
begin
  BeginUpdate;
  try
    Result := inherited AddIcon(AIcon);
    if NeedSynchronizeImageInfo and (Result <> -1) then
    begin
      AImage := cxCreateBitmap(Width, Height, pf32bit);
      AMask := cxCreateBitmap(Width, Height, pf1bit);
      try
        GetImageInfo(Handle, Count - 1, AImage, AMask);
        AddToInternalCollection(AImage, AMask);
      finally
        AMask.Free;
        AImage.Free
      end;
    end;
  finally
    EndUpdate;
  end;
end;

function TcxImageList.AddMasked(AImage: TBitmap; AMaskColor: TColor): Integer;
var
  ACloneImage: TBitmap;
begin
  BeginUpdate;
  try
    if AMaskColor = clNone then
      Result := Add(AImage, nil)
    else
    begin
      ACloneImage := cxCloneBitmap(AImage);
      try
        Result := ImageList_AddMasked(Handle, ACloneImage.Handle, ColorToRGB(AMaskColor));
      finally
        ACloneImage.Free;
      end;
      if NeedSynchronizeImageInfo and (Result <> -1) then
        AddToInternalCollection(AImage, nil, AMaskColor);
    end;
  finally
    EndUpdate;
  end;
end;

procedure TcxImageList.Move(ACurIndex, ANewIndex: Integer);
var
  AStep, AIndex: Integer;
begin
  BeginUpdate;
  try
    AStep := cxSign(ANewIndex - ACurIndex);
    AIndex := ACurIndex;
    while AIndex <> ANewIndex do
    begin
      ImageList_Copy(Handle, AIndex + AStep, Handle, AIndex, ILCF_SWAP);
      Inc(AIndex, AStep);
    end;
    if NeedSynchronizeImageInfo then
      TcxImageInfoCollection(FImages).Move(ACurIndex, ANewIndex);
  finally
    EndUpdate;
  end;
end;

procedure TcxImageList.Delete(AIndex: Integer);
begin
  BeginUpdate;
  try
    inherited;
    if NeedSynchronizeImageInfo then
      TcxImageInfoCollection(FImages).Delete(AIndex);
  finally
    EndUpdate;
  end;
end;

function TcxImageList.AddImage(AValue: TCustomImageList; AIndex: Integer): Integer;
begin
  if (AValue <> nil) and (AIndex < AValue.Count) then
  begin
    Result := Count;
    CopyImages(AValue, AIndex, AIndex);
  end
  else
    Result := -1;
end;

procedure TcxImageList.AddImages(AImageList: TCustomImageList);
begin
  if AImageList <> nil then
  begin
    BeginUpdate;
    try
      CopyImages(AImageList);
    finally
      EndUpdate;
    end;
  end;
end;

procedure TcxImageList.CopyImages(AImageList: TCustomImageList; AStartIndex, AEndIndex: Integer);
var
  AcxImageList: TcxImageList;
begin
  BeginUpdate;
  try
    AcxImageList := TcxImageList.Create(nil);
    try
      AcxImageList.Assign(AImageList);
      if AEndIndex < 0 then
        AEndIndex := AImageList.Count - 1
      else
        AEndIndex := Min(AImageList.Count - 1, AEndIndex);
      InternalCopyImageInfos(AcxImageList, AStartIndex, AEndIndex);
    finally
      AcxImageList.Free;
    end;
  finally
    EndUpdate;
  end;
end;

procedure TcxImageList.Clear;
begin
  Delete(-1);
end;

procedure TcxImageList.Insert(AIndex: Integer; AImage, AMask: TBitmap);
var
  I, ACurIndex: Integer;
begin
  if (AIndex >= 0) and (AIndex <= Count) then
  begin
    BeginUpdate;
    try
      ACurIndex := Add(AImage, AMask);
      for I := 0 to GetImageCount(AImage, Width, Height) - 1 do
        Move(ACurIndex + I, AIndex + I);
    finally
      EndUpdate;
    end;
  end;
end;

procedure TcxImageList.InsertIcon(AIndex: Integer; AIcon: TIcon);
begin
  if (AIndex >= 0) and (AIndex <= Count) then
  begin
    BeginUpdate;
    try
      Move(AddIcon(AIcon), AIndex);
    finally
      EndUpdate;
    end;
  end;
end;

procedure TcxImageList.InsertMasked(AIndex: Integer; AImage: TBitmap; AMaskColor: TColor);
var
  I, ACurIndex: Integer;
begin
  if (AIndex >= 0) and (AIndex <= Count) then
  begin
    BeginUpdate;
    try
      ACurIndex := AddMasked(AImage, AMaskColor);
      for I := 0 to GetImageCount(AImage, Width, Height) - 1 do
        Move(ACurIndex + I, AIndex + I);
    finally
      EndUpdate;
    end;
  end;
end;

procedure TcxImageList.Replace(AIndex: Integer; AImage, AMask: TBitmap);
begin
  BeginUpdate;
  try
    Delete(AIndex);
    Insert(AIndex, AImage, AMask);
  finally
    EndUpdate;
  end;
end;

procedure TcxImageList.ReplaceIcon(AIndex: Integer; AIcon: TIcon);
begin
  BeginUpdate;
  try
    Delete(AIndex);
    InsertIcon(AIndex, AIcon);
  finally
    EndUpdate;
  end;
end;

procedure TcxImageList.ReplaceMasked(AIndex: Integer; AImage: TBitmap; AMaskColor: TColor);
begin
  BeginUpdate;
  try
    Delete(AIndex);
    InsertMasked(AIndex, AImage, AMaskColor);
  finally
    EndUpdate;
  end;
end;

function TcxImageList.LoadImage(AInstance: THandle; const AResourceName: string;
  AMaskColor: TColor = clDefault; AWidth: Integer = 0; AFlags: TLoadResources = []): Boolean;
const
  AFlagMap: array [TLoadResource] of DWORD = (LR_DEFAULTCOLOR, LR_DEFAULTSIZE, LR_LOADFROMFILE,
    LR_LOADMAP3DCOLORS, LR_LOADTRANSPARENT, LR_MONOCHROME);
var
  I: TLoadResource;
  ALoadFlags: DWORD;
  AHandle: HImageList;
  ARGBColor: DWORD;
  AImageList: TImageList;
begin
  if AMaskColor = clNone then
    ARGBColor := CLR_NONE
  else
    if AMaskColor = clDefault then
      ARGBColor := CLR_DEFAULT
    else
      ARGBColor := ColorToRGB(AMaskColor);
  ALoadFlags := LR_CREATEDIBSECTION;
  for I := Low(TLoadResource) to High(TLoadResource) do
    if I in AFlags then
      ALoadFlags := ALoadFlags or AFlagMap[I];
  AHandle := ImageList_LoadImage(AInstance, PChar(AResourceName), AWidth, AllocBy, ARGBColor,
    IMAGE_BITMAP, ALoadFlags);
  Result := AHandle <> 0;
  if Result then
  begin
    AImageList := TImageList.Create(Self);
    try
      AImageList.Handle := AHandle;
      CopyImages(AImageList);
    finally
      AImageList.Free;
    end;
  end;
end;

function TcxImageList.FileLoad(AResType: TResType; const AName: string; AMaskColor: TColor): Boolean;
begin
  Result := inherited FileLoad(AResType, AName, AMaskColor);
  SynchronizeImageInfo;
end;

function TcxImageList.GetResource(AResType: TResType; const AName: string;
  AWidth: Integer; ALoadFlags: TLoadResources; AMaskColor: TColor): Boolean;
begin
  Result := inherited GetResource(AResType, AName, AWidth, ALoadFlags, AMaskColor);
  SynchronizeImageInfo;
end;

function TcxImageList.GetInstRes(AInstance: THandle; AResType: TResType; const AName: string;
  AWidth: Integer; ALoadFlags: TLoadResources; AMaskColor: TColor): Boolean;
begin
  Result := inherited GetInstRes(AInstance, AResType, AName, AWidth, ALoadFlags, AMaskColor);
  SynchronizeImageInfo;
end;

function TcxImageList.GetInstRes(AInstance: THandle; AResType: TResType; AResID: DWORD;
  AWidth: Integer; ALoadFlags: TLoadResources; AMaskColor: TColor): Boolean;
begin
  Result := inherited GetInstRes(AInstance, AResType, AResID, AWidth, ALoadFlags, AMaskColor);
  SynchronizeImageInfo;
end;

function TcxImageList.ResourceLoad(AResType: TResType; const AName: string; AMaskColor: TColor): Boolean;
begin
  Result := inherited ResourceLoad(AResType, AName, AMaskColor);
  SynchronizeImageInfo;
end;

function TcxImageList.ResInstLoad(AInstance: THandle; AResType: TResType;
  const AName: string; AMaskColor: TColor): Boolean;
begin
  Result := inherited ResInstLoad(AInstance, AResType, AName, AMaskColor);
  SynchronizeImageInfo;
end;

procedure TcxImageList.BeginUpdate;
begin
  Inc(FLockCount);
end;

procedure TcxImageList.EndUpdate(AForceUpdate: Boolean = True);
begin
  if FLockCount > 0 then
  begin
    Dec(FLockCount);
    if AForceUpdate then
      Change;
  end;
end;

{$IFNDEF DELPHI6}
procedure TcxImageList.Draw(ACanvas: TCanvas; X, Y, AIndex: Integer;
  ADrawingStyle: TDrawingStyle; AImageType: TImageType; AEnabled: Boolean);
begin
  if HandleAllocated then
    DoDraw(AIndex, ACanvas, X, Y, GetImageListStyle(ADrawingStyle, AImageType), AEnabled);
end;
{$ENDIF}

procedure TcxImageList.Draw(ACanvas: TCanvas; const ARect: TRect; AIndex: Integer;
  AStretch: Boolean = True; ASmoothResize: Boolean = False; AEnabled: Boolean = True);
begin
  DoDrawEx(AIndex, ACanvas, ARect, GetImageListStyle(DrawingStyle, ImageType), AStretch, ASmoothResize, AEnabled);
end;

procedure TcxImageList.GetImageInfo(AIndex: Integer; AImage, AMask: TBitmap);

  procedure GetBitmap(ADestBitmap, ASrcBitmap: TBitmap);
  begin
    ADestBitmap.Width := ASrcBitmap.Width;
    ADestBitmap.Height := ASrcBitmap.Height;
    cxCopyBitmap(ADestBitmap, ASrcBitmap);
  end;

var
  ASourceImage, ASourceMask: TBitmap;
begin
  if (0 <= AIndex) and (AIndex < Count) then
  begin
    ASourceImage := TcxImageInfoItem(FImages.Items[AIndex]).ImageInfo.Image;
    if (ASourceImage.PixelFormat = pf32bit) or IsWin9X then
    begin
      if AImage <> nil then
        GetBitmap(AImage, ASourceImage);
      if AMask <> nil then
      begin
        ASourceMask := TcxImageInfoItem(FImages.Items[AIndex]).ImageInfo.Mask;
        GetBitmap(AMask, ASourceMask);
      end;
    end
    else
      GetImageInfo(Handle, AIndex, AImage, AMask);
    ASourceImage.Dormant;
  end;
end;

procedure TcxImageList.GetImage(AIndex: Integer; AImage: TBitmap);
begin
  GetImageInfo(AIndex, AImage, nil);
end;

procedure TcxImageList.GetMask(AIndex: Integer; AMask: TBitmap);
begin
  GetImageInfo(AIndex, nil, AMask);
end;

class procedure TcxImageList.GetImageInfo(AImages: TCustomImageList; AIndex: Integer; AImage, AMask: TBitmap);
begin
  if AImages is TcxImageList then
    TcxImageList(AImages).GetImageInfo(AIndex, AImage, AMask)
  else
    TcxImageList.GetImageInfo(AImages.Handle, AIndex, AImage, AMask);
end;

class procedure TcxImageList.GetImageInfo(AHandle: HIMAGELIST; AIndex: Integer; AImage, AMask: TBitmap);

  procedure GetBitmap(ASrcHandle: HBITMAP; ADestBitmap: TBitmap; ACopyAll: Boolean; const ARect: TRect);

    procedure CopyRect;
    var
      ASrcBitmap: TBitmap;
      AWidth, AHeight: Integer;
    begin
      ASrcBitmap := TBitmap.Create;
      try
        ASrcBitmap.Handle := cxCopyImage(ASrcHandle);
        AWidth := cxRectWidth(ARect);
        AHeight := cxRectHeight(ARect);
        ADestBitmap.Width := AWidth;
        ADestBitmap.Height := AHeight;
        cxBitBlt(ADestBitmap.Canvas.Handle, ASrcBitmap.Canvas.Handle,
          cxRect(0, 0, AWidth, AHeight), ARect.TopLeft, SRCCOPY);
        TBitmapAccess(ADestBitmap).Changed(ADestBitmap);
      finally
        ASrcBitmap.Free;
      end;
    end;

  begin
    if ACopyAll then
      ADestBitmap.Handle := cxCopyImage(ASrcHandle)
    else
      CopyRect;
  end;

var
  AImageInfo: TImageInfo;
  ACopyAll: Boolean;
begin
  ACopyAll := AIndex = -1;
  if ACopyAll then
    AIndex := 0;
  if ImageList_GetImageInfo(AHandle, AIndex, AImageInfo) then
  begin
    if AMask <> nil then
      GetBitmap(AImageInfo.hbmMask, AMask, ACopyAll, AImageInfo.rcImage);
    if AImage <> nil then
      GetBitmap(AImageInfo.hbmImage, AImage, ACopyAll, AImageInfo.rcImage);
    DeleteObject(AImageInfo.hbmImage);
    DeleteObject(AImageInfo.hbmMask);
  end;
end;

class function TcxImageList.GetPixelFormat(AHandle: HIMAGELIST): Integer;
var
  AImageInfo: TImageInfo;
  ABitmap: Windows.TBitmap;
begin
  Result := 0;
  if ImageList_GetImageInfo(AHandle, 0, AImageInfo) then
  begin
    cxGetBitmapData(AImageInfo.hbmImage, ABitmap);
    Result := ABitmap.bmBitsPixel;
    DeleteObject(AImageInfo.hbmImage);
    DeleteObject(AImageInfo.hbmMask);
  end;
end;

function TcxImageList.ChangeLocked: Boolean;
begin
  Result := FLockCount > 0;
end;

procedure TcxImageList.Change;
begin
  if not ChangeLocked then
    inherited Change;
end;

procedure TcxImageList.DoDraw(Index: Integer; Canvas: TCanvas; X, Y: Integer;
  Style: Cardinal; Enabled: Boolean = True);
begin
  DoDrawEx(Index, Canvas, cxRectBounds(X, Y, Width, Height), Style, False, False, Enabled);
end;

procedure TcxImageList.DoDrawEx(AIndex: Integer; ACanvas: TCanvas;
  const ARect: TRect; AStyle: Cardinal; AStretch, ASmoothResize, AEnabled: Boolean);
const
  ADrawModes: array [Boolean] of TcxImageDrawMode = (idmDisabled, idmNormal);
var
  AGlyphRect: TRect;
  ADrawBitmap: TBitmap;
begin
  if (cxRectWidth(ARect) = Width) and (cxRectHeight(ARect) = Height) then
    AStretch := False;
  if AStretch then
    AGlyphRect := ARect
  else
    AGlyphRect := cxRectCenter(ARect, Width, Height);
  if AlphaBlending then
    cxDrawImage(ACanvas.Handle, AGlyphRect, ARect, nil, Self, AIndex, ADrawModes[AEnabled], ASmoothResize)
  else
  begin
    if AStretch then
    begin
      ADrawBitmap := cxCreateBitmap(Width, Height, pfDevice);
      try
        inherited DoDraw(AIndex, ADrawBitmap.Canvas, 0, 0, AStyle, AEnabled);
        cxDrawImage(ACanvas.Handle, AGlyphRect, ARect, ADrawBitmap, nil, 0, ADrawModes[AEnabled], ASmoothResize);
      finally
        ADrawBitmap.Free;
      end;
    end
    else
      inherited DoDraw(AIndex, ACanvas, AGlyphRect.Left, AGlyphRect.Top, AStyle, AEnabled);
  end;
end;

procedure TcxImageList.Initialize;
begin
  inherited;
  FImages := TcxImageInfoCollection.Create(Self);
  FAlphaBlending := True;
  inherited Handle := ImageList_Create(Width, Height, ILC_COLOR32 or ILC_MASK, AllocBy, AllocBy);
end;

procedure TcxImageList.Finalize;
begin
  FreeAndNil(FImages);
end;

const
  ADXILSignature: Integer = $494C4458; //DXIL
  ADXILVersion: Word = 1;

procedure TcxImageList.DefineProperties(Filer: TFiler);

  function DoWriteImageInfo: Boolean;
  begin
    if (Filer.Ancestor <> nil) and (Filer.Ancestor is TCustomImageList) then
      Result := not IsImageListsEqual(TCustomImageList(Filer.Ancestor), Self)
    else
      Result := Count > 0;
  end;

  function DoWriteDesignInfo: Boolean;
  begin
    Result := (Filer.Ancestor = nil) or not (Filer.Ancestor is TCustomImageList) or
      (TCustomImageList(Filer.Ancestor).DesignInfo <> DesignInfo);
  end;

var
  AOldSaveFormat: Boolean;
begin
{$IFDEF cxImageListOldSaveFormat}
  AOldSaveFormat := True;
{$ELSE}
  AOldSaveFormat := False;
{$ENDIF}

  Filer.DefineProperty('FormatVersion', ReadFormatVersion, WriteFormatVersion, not AOldSaveFormat);


  if (csReading in ComponentState) or AOldSaveFormat and (csWriting in ComponentState) then
  begin
    inherited;
    if csReading in ComponentState then
      SynchronizeImageInfo;
  end;

  Filer.DefineProperty('DesignInfo', ReadDesignInfo, WriteDesignInfo, not AOldSaveFormat and DoWriteDesignInfo);
  Filer.DefineProperty('ImageInfo', ReadImageInfo, WriteImageInfo, not AOldSaveFormat and DoWriteImageInfo);
end;

procedure TcxImageList.Dormant;
var
  I: Integer;
begin
  for I := 0 to FImages.Count - 1 do
    DormantImage(I);
end;

procedure TcxImageList.AddImageInfo(AImageInfo: TcxImageInfo);
begin
  if IsGlyphAssigned(AImageInfo.Mask) then
    Add(AImageInfo.Image, AImageInfo.Mask)
  else
    AddMasked(AImageInfo.Image, AImageInfo.MaskColor);
end;

procedure TcxImageList.InternalCopyImageInfos(AImageList: TcxImageList; AStartIndex, AEndIndex: Integer);
var
  I: Integer;
  AImageInfo: TcxImageInfo;
begin
  AImageInfo := TcxImageInfo.Create;
  try
    for I := Max(AStartIndex, 0) to AEndIndex do
    begin
      AImageList.GetImageInfo(I, AImageInfo);
      AddImageInfo(AImageInfo);
    end;
  finally
    AImageInfo.Free;
  end;
end;

procedure TcxImageList.InternalCopyImages(AImageList: TCustomImageList; AStartIndex, AEndIndex: Integer);
var
  I: Integer;
  AImage, AMask: TBitmap;
begin
  AImage := cxCreateBitmap(Width, Height, pf32bit);
  AMask := cxCreateBitmap(Width, Height, pf1bit);
  try
    for I := Max(AStartIndex, 0) to AEndIndex do
    begin
      GetImageInfo(AImageList.Handle, I, AImage, AMask);
      Add(AImage, AMask);
    end;
  finally
    AImage.Free;
    AMask.Free;
  end;
end;

procedure TcxImageList.GetImageInfo(AIndex: Integer; AImageInfo: TcxImageInfo);
begin
  if (0 <= AIndex) and (AIndex < Count) then
    AImageInfo.Assign(TcxImageInfoItem(FImages.Items[AIndex]).ImageInfo)
  else
  begin
    AImageInfo.Image := nil;
    AImageInfo.Mask := nil;
    AImageInfo.MaskColor := clNone;
  end;
end;

function TcxImageList.GetCompressData: Boolean;
begin
  Result := TcxImageInfoCollection(FImages).CompressData;
end;

procedure TcxImageList.SetCompressData(Value: Boolean);
begin
  TcxImageInfoCollection(FImages).CompressData := Value;
end;

function TcxImageList.GetHandle: HImageList;
begin
  Result := inherited Handle;
end;

procedure TcxImageList.SetHandle(Value: HImageList);
var
  AImageList: TCustomImageList;
begin
  AImageList := TCustomImageList.Create(Self);
  try
    AImageList.Handle := Value;
    Assign(AImageList);
    ImageList_Destroy(Value);
  finally
    AImageList.Free;
  end;
end;

procedure TcxImageList.ReadFormatVersion(AReader: TReader);
begin
  FFormatVersion := AReader.ReadInteger;
end;

procedure TcxImageList.WriteFormatVersion(AWriter: TWriter);
begin
  FFormatVersion := ADXILVersion;
  AWriter.WriteInteger(FFormatVersion);
end;

procedure TcxImageList.ReadImageInfo(AReader: TReader);
begin
  FImages.Clear;
  AReader.ReadValue;
  AReader.ReadCollection(FImages);
  SynchronizeHanle;
end;

procedure TcxImageList.WriteImageInfo(AWriter: TWriter);
begin
  AWriter.WriteCollection(FImages);
end;

procedure TcxImageList.ReadDesignInfo(AReader: TReader);
begin
  DesignInfo := AReader.ReadInteger;
end;

procedure TcxImageList.WriteDesignInfo(AWriter: TWriter);
begin
  AWriter.WriteInteger(DesignInfo);
end;

function TcxImageList.NeedSynchronizeImageInfo: Boolean;
begin
  Result := not FSynchronization; 
end;

procedure TcxImageList.SynchronizeImageInfo;
var
  I: Integer;
  AImage, AMask: TBitmap;
begin
  FImages.BeginUpdate;
  try
    FImages.Clear;
    AImage := cxCreateBitmap(Width, Height, pf32bit);
    AMask := cxCreateBitmap(Width, Height, pf1bit);
    try
      for I := 0 to Count - 1 do
      begin
        GetImageInfo(Handle, I, AImage, AMask);
        TcxImageInfoCollection(FImages).Add(AImage, AMask);
      end;
    finally
      AMask.Free;
      AImage.Free;
    end;
  finally
    FImages.EndUpdate;
  end;
end;

procedure TcxImageList.SynchronizeHanle;
var
  I: Integer;
  AImageInfoItem: TcxImageInfoItem;
begin
  BeginUpdate;
  try
    FSynchronization := True;
    try
      Clear;
      for I := 0 to FImages.Count - 1 do
      begin
        AImageInfoItem := TcxImageInfoItem(FImages.Items[I]);
        AddImageInfo(AImageInfoItem.ImageInfo);
        DormantImage(I);
      end;
    finally
      FSynchronization := False;
    end;
  finally
    EndUpdate;
  end;
end;

procedure TcxImageList.AddToInternalCollection(AImage, AMask: TBitmap; AMaskColor: TColor);

  procedure InternalAddToInternalCollection(AImage, AMask: TBitmap; AMaskColor: TColor);
  var
    AItem: TCollectionItem;
  begin
    AItem := TcxImageInfoCollection(FImages).Add(AImage, AMask, AMaskColor);
    DormantImage(AItem.Index);
  end;
  
var
  AColCount, ARowCount, AColIndex, ARowIndex: Integer;
  ASourceRect: TRect;
  ADestBitmap, ADestMask: TcxBitmap;
begin
  if (((AImage.Width mod Width) + (AImage.Height mod Height)) = 0) and
    ((AImage.Width <> Width) or (AImage.Height <> Height)) then
  begin
    AColCount := AImage.Width div Width;
    ARowCount := AImage.Height div Height;

    ADestBitmap := TcxBitmap.CreateSize(Width, Height, AImage.PixelFormat);
    if IsGlyphAssigned(AMask) then
      ADestMask := TcxBitmap.CreateSize(Width, Height, AMask.PixelFormat)
    else
      ADestMask := nil;
    try
      for ARowIndex := 0 to ARowCount - 1 do
        for AColIndex := 0 to AColCount - 1 do
        begin
          ASourceRect := Rect(AColIndex * Width, ARowIndex * Height, (AColIndex + 1) * Width, (ARowIndex + 1) * Height);
          ADestBitmap.Canvas.CopyRect(ADestBitmap.ClientRect, AImage.Canvas, ASourceRect);
          if IsGlyphAssigned(AMask) then
            ADestMask.Canvas.CopyRect(ADestMask.ClientRect, AMask.Canvas, ASourceRect);
          InternalAddToInternalCollection(ADestBitmap, ADestMask, AMaskColor);
        end;
    finally
      ADestMask.Free;
      ADestBitmap.Free;
    end;
  end
  else
    InternalAddToInternalCollection(AImage, AMask, AMaskColor);
end;

procedure TcxImageList.DormantImage(AIndex: Integer);
begin
  TcxImageInfoItem(FImages.Items[AIndex]).ImageInfo.Image.Dormant;
end;

function TcxImageList.GetImageHandle(AImage: TBitmap): Integer;
begin
  if AImage <> nil then
    Result := AImage.Handle
  else
    Result := 0;
end;

const
  SystemBrushes: TList = nil;
  SysColorPrefix = {$IFDEF DELPHI7} clSystemColor {$ELSE} $80000000 {$ENDIF};
  BrushDataSize = SizeOf(TcxBrushData);
  scxBrushCacheReleaseUnusedBrush = 'Release unused brush';

destructor TcxBrushCache.Destroy;
var
  I: Integer;
begin
  try
    for I := 0 to FCount - 1 do
      FData[I].Brush.Free;
  finally
    inherited Destroy;
  end;
end;

procedure TcxBrushCache.BeginUpdate;
begin
  Inc(FLockRef);
end;

procedure TcxBrushCache.EndUpdate;
begin
  Inc(FLockRef);
  if (FLockRef = 0) and (FDeletedCount <> 0) then Pack;
end;

procedure TcxBrushCache.ReleaseBrush(var ABrush: TBrush);
var
  AIndex: Integer;
begin
  if ABrush <> nil then
  begin
    if not IsSystemBrush(ABrush) and IndexOf(ABrush.Color, AIndex) then
    begin
      with FData[AIndex] do
      begin
        Dec(RefCount);
        CacheCheck(RefCount < 0, scxBrushCacheReleaseUnusedBrush);
        if RefCount <= 0 then Delete(AIndex);
      end;
    end;
  end; 
end;

procedure TcxBrushCache.SetBrushColor(var ABrush: TBrush; AColor: TColor);
begin
  ReleaseBrush(ABrush);
  ABrush := Add(AColor);
end;

function TcxBrushCache.Add(AColor: TColor): TBrush;
begin
  if AColor and SysColorPrefix <> 0 then
    Result := TBrush(SystemBrushes[AColor and not SysColorPrefix])
  else
    Result := AddItemAt(FindNearestItem(AColor), AColor);
  Result.Color := AColor; 
end;

function TcxBrushCache.AddItemAt(AIndex: Integer; AColor: TColor): TBrush;
var
  Delta: Integer;
begin
  if (AIndex >= FCount) or (FData[AIndex].Color <> AColor) then
  begin
    if FCapacity <= FCount then
    begin
      Delta := FCapacity shr 2;
      if Delta < 8 then Delta := 8;
      Inc(FCapacity, Delta);
      SetLength(FData, FCapacity);
    end;
    if AIndex < FCount then Move(AIndex, AIndex + 1, FCount - AIndex);
    InitItem(FData[AIndex], AColor);
    Inc(FCount);
  end
  else
    if FData[AIndex].RefCount = 0 then Dec(FDeletedCount);
  Inc(FData[AIndex].RefCount);
  Result := FData[AIndex].Brush;
end;

procedure TcxBrushCache.CacheCheck(Value: Boolean; const AMessage: string);
begin
  if Value then
    raise EBrushCache.Create(AMessage);
end;

procedure TcxBrushCache.Delete(AIndex: Integer);
begin
  if FLockRef = 0 then
  begin
    FData[AIndex].Brush.Free;
    Dec(FCount);
    if AIndex < FCount then
      Move(AIndex + 1, AIndex, FCount - AIndex);
  end
  else
    Inc(FDeletedCount);
end;

function TcxBrushCache.IndexOf(AColor: TColor; out AIndex: Integer): Boolean;
begin
  AIndex := -1;
  if (AColor and SysColorPrefix = 0) then
    AIndex := FindNearestItem(AColor);
  Result := (AIndex >= 0) and (AIndex < FCount) and (FData[AIndex].Color = AColor);
end;

procedure TcxBrushCache.InitItem(var AItem: TcxBrushData; AColor: TColor);
begin
  FillChar(AItem, BrushDataSize, 0);
  AItem.Brush := TBrush.Create;
  AItem.Brush.Color := AColor;
end;

function TcxBrushCache.IsSystemBrush(ABrush: TBrush): Boolean;
begin
  Result := ABrush = nil;
  Result := Result or ((ABrush.Color and SysColorPrefix) <> 0);
end;

function TcxBrushCache.FindNearestItem(AColor: TColor): Integer;

  function Check(Min, Max: Integer): Integer;
  begin
    Result := Max;
    if AColor <= FData[Min].Color then
      Result := Min
    else
      if AColor > FData[Max].Color then
        AColor := Max + 1;
  end;

var
  A, B, C: Integer;
begin
  if FCount > 0 then
  begin
    A := 0;
    B := FCount - 1;
    if (FData[0].Color >= AColor) or (FData[B].Color <= AColor) then
      Result := Check(A, B)
    else
    begin
      while A < B do
      begin
        C := (A + B) shr 1;
        with FData[C] do
        begin
          if Color < AColor then
            A := C
          else
            if Color > AColor then
              B := C
            else
              B := A;
        end;
      end;
      Result := Check(A, B);
    end;
  end
  else
    Result := 0;
end;

procedure TcxBrushCache.Move(ASrc, ADst, ACount: Integer);
begin
  System.Move(FData[ASrc], FData[ADst], ACount * BrushDataSize);
end;

procedure TcxBrushCache.Pack;
var
  I, ACount: Integer;
begin
  try
    ACount := 0;
    I := FCount - 1;
    while (ACount < FDeletedCount) and (I >= 0) do
    begin
      if FData[I].RefCount < 0 then
      begin
        Delete(I);
        Inc(ACount);
      end;
      Dec(I);
    end;
  finally
    FDeletedCount := 0;
  end;
end;

procedure TcxBrushCache.Recreate;
var
  I: Integer;
begin
  for I := 0 to FCount - 1 do
    with FData[I] do Brush.Color := Color;
end;

procedure TcxBrushCache.Release(AIndex: Integer);
begin
  Dec(FData[AIndex].RefCount);
  if FData[AIndex].RefCount = 0 then Delete(AIndex);
end;

{ TcxImageCollection }

constructor TcxImageCollection.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FItems := TcxImageCollectionItems.Create(Self);
  FListeners := TInterfaceList.Create;
end;

destructor TcxImageCollection.Destroy;
begin
  DoDestroyed;
  FreeAndNil(FItems);
  FreeAndNil(FListeners);
  inherited Destroy;
end;

procedure TcxImageCollection.AddListener(AListener: IcxImageCollectionListener);
begin
  FListeners.Add(AListener);
end;

procedure TcxImageCollection.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
begin
  for I := 0 to Items.Count - 1 do
    if Items[I].Owner = Root then Proc(Items[I]);
end;

procedure TcxImageCollection.Changed;
var
  AListener: IcxImageCollectionListener;
  I: Integer;
begin
  for I := FListeners.Count - 1 downto 0 do
  begin
    AListener := FListeners[I] as IcxImageCollectionListener;
    AListener.ImageCollectionChanged;
    AListener := nil;
  end;
end;

procedure TcxImageCollection.DoDestroyed;
var
  AListener: IcxImageCollectionListener;
  I: Integer;
begin
  for I := FListeners.Count - 1 downto 0 do
  begin
    AListener := FListeners[I] as IcxImageCollectionListener;
    AListener.ImageCollectionDestroyed;
    AListener := nil;
  end;
end;

procedure TcxImageCollection.Draw(ACanvas: TCanvas; X, Y, AIndex: Integer);
begin
  if (AIndex >= 0) and (AIndex < Count) then
    Items[AIndex].Draw(ACanvas, X, Y);
end;

procedure TcxImageCollection.Draw(ACanvas: TCanvas; const R: TRect;
  AIndex: Integer; AStretch: Boolean = True; ASmoothResize: Boolean = False;
  AEnabled: Boolean = True);
begin
  if (AIndex >= 0) and (AIndex < Count) then
    Items[AIndex].Draw(ACanvas, R, AStretch, ASmoothResize, AEnabled);
end;

procedure TcxImageCollection.RemoveListener(AListener: IcxImageCollectionListener);
begin
  if Assigned(FListeners) then
    FListeners.Remove(AListener);
end;

function TcxImageCollection.GetCount: Integer;
begin
  Result := Items.Count;
end;

procedure TcxImageCollection.SetItems(AItems: TcxImageCollectionItems);
begin
  FItems.Assign(AItems);
end;

{ TcxImageCollectionItem }

constructor TcxImageCollectionItem.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPicture := TPicture.Create;
  FPicture.OnChange := DoPictureChanged;
end;

destructor TcxImageCollectionItem.Destroy;
begin
  FreeAndNil(FPicture);
  inherited Destroy;
end;

procedure TcxImageCollectionItem.Assign(Source: TPersistent);
begin
  if Source is TcxImageCollectionItem then
    Picture.Assign(TcxImageCollectionItem(Source).Picture)
  else
    inherited Assign(Source);
end;

procedure TcxImageCollectionItem.Draw(ACanvas: TCanvas; X, Y: Integer);
begin
  Draw(ACanvas, cxRectOffset(ClientRect, X, Y));
end;

procedure TcxImageCollectionItem.Draw(ACanvas: TCanvas; const R: TRect;
  AStretch: Boolean = True; ASmoothResize: Boolean = False; AEnabled: Boolean = True);

  function HasAlphaChannel(AGraphic: TGraphic): Boolean;
  begin
    Result := (AGraphic is TdxPNGImage) or (AGraphic is TIcon) or
      ((AGraphic is TBitmap) and (TBitmap(AGraphic).PixelFormat = pf32bit));
  end;

  function CreateBitmapBuffer: TBitmap;
  begin
    if HasAlphaChannel(Picture.Graphic) then
      Result := TcxBitmap32.CreateSize(Width, Height, True)
    else
      Result := cxCreateBitmap(Width, Height);
  end;

const
  DrawModesMap: array [Boolean] of TcxImageDrawMode = (idmDisabled, idmNormal);
var
  ABitmap: TBitmap;
  ARect: TRect;
begin
  if AStretch then
    ARect := R
  else
    ARect := cxRectCenter(R, Width, Height);

  ABitmap := CreateBitmapBuffer;
  try
    ABitmap.Canvas.Draw(0, 0, Picture.Graphic);
    cxDrawImage(ACanvas.Handle, ARect, R,
      ABitmap, nil, 0, DrawModesMap[AEnabled], ASmoothResize);
  finally
    ABitmap.Free;
  end;
end;

function TcxImageCollectionItem.GetDisplayName: string;
begin
  Result := inherited GetDisplayName;
  if (Picture.Graphic <> nil) then
   with Picture.Graphic do
     if not Empty then
       Result := Result + Format(' (%dx%d %s)', [Width, Height, ClassName]);
end;

function TcxImageCollectionItem.GetCollectionFromParent(
  AParent: TComponent): TcxComponentCollection;
begin
  Result := (AParent as TcxImageCollection).Items;
end;

procedure TcxImageCollectionItem.DoPictureChanged(Sender: TObject);
begin
  Changed(False);
end;

function TcxImageCollectionItem.GetClientRect: TRect;
begin
  Result := Bounds(0, 0, Width, Height);
end;

function TcxImageCollectionItem.GetHeight: Integer;
begin
  Result := Picture.Height;
end;

function TcxImageCollectionItem.GetWidth: Integer;
begin
  Result := Picture.Width;
end;

procedure TcxImageCollectionItem.SetPicture(AValue: TPicture);
begin
  FPicture.Assign(AValue);
end;

{ TcxImageCollectionItems }

constructor TcxImageCollectionItems.Create(ACollection: TcxImageCollection);
begin
  inherited Create(ACollection, TcxImageCollectionItem);
  FCollection := ACollection;
end;

function TcxImageCollectionItems.Add: TcxImageCollectionItem;
begin
  Result := TcxImageCollectionItem(inherited Add);
end;

function TcxImageCollectionItems.FindItemByName(
  const AName: string; out AItem: TcxImageCollectionItem): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Count - 1 do
  begin
    Result := SameText(Items[I].Name, AName);
    if Result then
    begin
      AItem := Items[I];
      Break;
    end;
  end;
end;

function TcxImageCollectionItems.FindItemByID(ID: Integer): TcxImageCollectionItem;
begin
  Result := TcxImageCollectionItem(inherited FindItemByID(ID));
end;

procedure TcxImageCollectionItems.Notify(AItem: TcxComponentCollectionItem;
  AAction: TcxComponentCollectionNotification);
begin
  inherited Notify(AItem, AAction);
  FCollection.Changed;
end;

function TcxImageCollectionItems.GetItem(Index: Integer): TcxImageCollectionItem;
begin
  Result := TcxImageCollectionItem(inherited Items[Index]);
end;

function TcxImageCollectionItems.Insert(Index: Integer): TcxImageCollectionItem;
begin
  Result := TcxImageCollectionItem(inherited Insert(Index));
end;

procedure TcxImageCollectionItems.SetItem(Index: Integer; AValue: TcxImageCollectionItem);
begin
  inherited Items[Index] := AValue;
end;

procedure TcxImageCollectionItems.SetItemName(AItem: TcxComponentCollectionItem);
begin
  AItem.Name := CreateUniqueName(FCollection.Owner, FCollection, AItem, 'TcxImageCollection', '');
end;

procedure InitSystemBrushes;
var
  I: Word;
  ABrush: TBrush;
begin
  SystemBrushes := TList.Create;
  for I := COLOR_SCROLLBAR to COLOR_ENDCOLORS do
  begin
    ABrush := TBrush.Create;
    ABrush.Handle := GetSysColorBrush(I);
    SystemBrushes.Add(ABrush);
  end;
end;

procedure DestroySystemBrushes;
var
  I: Integer;
begin
  try
    for I := 0 to SystemBrushes.Count - 1 do
      TBrush(SystemBrushes[I]).Free;
  finally
    SystemBrushes.Free;
  end;
end;

procedure InitPredefinedBrushes;
var
  ABitmap:  HBitmap ;
const
  APattern: array[0..7] of Word =
    ($00AA, $0055, $00AA, $0055, $00AA, $0055, $00AA, $0055);
begin
  cxHalfToneBrush := TBrush.Create;
  InitSystemBrushes;
  ABitmap := CreateBitmap(8, 8, 1, 1, @APattern);
  cxHalfToneBrush.Handle := CreatePatternBrush(ABitmap);
  DeleteObject(ABitmap);
end;

procedure DestroyPredefinedBrushes;
begin
  DestroySystemBrushes;
{$IFDEF DELPHI9}
{$IFNDEF DELPHI10}
  cxHalfToneBrush.Bitmap.Free;
{$ENDIF}
{$ENDIF}
  cxHalfToneBrush.Free;
end;

procedure GetDPI;
var
  DC: Integer;
begin
  DC := GetDC(0);
  try
    FPixelsPerInch.cx := GetDeviceCaps(DC, LOGPIXELSX);
    FPixelsPerInch.cy := GetDeviceCaps(DC, LOGPIXELSY);
  finally
    ReleaseDC(0, DC);
  end;
end;

procedure InitGraphics;
begin
  FUnitIsFinalized := False;
  InitPredefinedBrushes;
  FMsimg32DLL := LoadLibrary('msimg32.dll');
  if FMsimg32DLL <> 0 then
    VCLAlphaBlend := GetProcAddress(FMsimg32DLL, 'AlphaBlend')
  else
    VCLAlphaBlend := nil;
  if Win32MajorVersion >= 6 then
  begin
    FUser32DLL := GetModuleHandle(user32);
    SetProcessDPIAware := GetProcAddress(FUser32DLL, 'SetProcessDPIAware');
    if Assigned(SetProcessDPIAware) then
      SetProcessDPIAware;
  end;
  RegisterClasses([TcxBitmap, TcxBitmap32]);
  GetDPI;
end;

procedure DoneGraphics;
begin
  FUnitIsFinalized := True;
  DestroyPredefinedBrushes;
  FreeAndNil(ScreenCanvas);
  FreeAndNil(PaintCanvas);
  FreeAndNil(MaskBitmap);
  FreeAndNil(ImageBitmap);
  FreeAndNil(DrawBitmap);
  if FMsimg32DLL > 32 then
    FreeLibrary(FMsimg32DLL);
end;

initialization
  InitGraphics;

finalization
  DoneGraphics;

end.
