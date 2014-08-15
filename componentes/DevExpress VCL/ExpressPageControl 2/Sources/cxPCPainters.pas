
{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressPageControl                                           }
{                                                                    }
{       Copyright (c) 1998-2010 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSPAGECONTROL AND ALL            }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
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

unit cxPCPainters;

{$I cxVer.inc}

interface

uses
  Windows, Classes, Controls, Graphics, SysUtils, cxGraphics, cxLookAndFeels,
  cxPC, dxCore;

const
  cxPCEmptyWOffset: TcxPCWOffset = (Left: 0; Right: 0);

  cxPCTabsStyle = 1;
  cxPCButtonsStyle = 2;
  cxPCFlatButtonsStyle = 3;
  cxPCExtraFlatStyle = 5;
  cxPCUltraFlatStyle = 6;
  cxPCFlatStyle = 7;
  cxPCOffice11Style = 8;
  cxPCSlantedStyle = 9;
  cxPCOneNoteStyle = 10;
  cxPCSkinStyle = 11;

  StandardPainterTabControlFrameBorderWidth = 2;

type
  TcxPCNavigatorButtonPosition = record
    Button: TcxPCNavigatorButton;
    ButtonRect: TRect;
  end;
  TcxPCNavigatorButtonPositions = array of TcxPCNavigatorButtonPosition;

  TcxPCTabsDelimiterOffsets = record
    Top, Bottom: Integer;
  end;

  TcxPCArrow = (aTop, aBottom, aLeft, aRight);

  TcxPCNavigatorButtonContentParameters = record
    BrushColor: TColor;
    Color: TColor;
    Enabled: Boolean;
    LiteStyle: Boolean;
  end;

  TLinePosition = (lpL, lpLT, lpT, lpRT, lpR, lpRB, lpB, lpLB);
  TLinePositions = array of TLinePosition;

  TPoints = array of TPoint;

  { TcxPCStandardPainter }

  TcxPCStandardPainter = class(TcxPCCustomPainter)
  private
    FButtonsQueue: TcxPCNavigatorButtonPositions;
    FButtonsRect: TRect;
    function GetButtonsWidth(ANavigatorButtons: TcxPCNavigatorButtons): Integer;
  protected
    function CalculateTabNormalWidth(Tab: TcxTab): Integer; override;
    function GetDrawImageOffset(TabVisibleIndex: Integer): TRect; override;
    function GetDrawImageWithoutTextWOffset(TabVisibleIndex: Integer): TcxPCWOffset; override;
    function GetDrawTextHOffset(TabVisibleIndex: Integer): TRect; override;
    function GetFrameWidth: Integer; override;
    function GetGoDialogPosition(GoDialogSize: TSize): TPoint; override;
    function GetImageTextDistance(ATabVisibleIndex: Integer): Integer; override;
    function GetMinTabNormalWidth(ATabVisibleIndex: Integer): Integer; override;
    function GetMinTabSelectionDistance: TcxPCDistance; override;
    function GetTabContentWOffset(ATabVisibleIndex: Integer): TcxPCWOffset; override;
    function GetTabsNormalDistance: TcxPCDistance; override;
    function GetTabsPosition(NavigatorButtons: TcxPCNavigatorButtons): TcxPCTabsPosition; override;
    function GetTooNarrowTabContentWOffset(ATabVisibleIndex: Integer): TcxPCWOffset; override;
    procedure InternalPrepareOutTabImageAndTextData(ATabVisibleIndex: Integer;
      var AImageRect, ATextRect: TRect); override;
    function IsOverButton(X, Y: Integer; var Button: TcxPCNavigatorButton): Boolean; override;
    function IsTabBorderThick(ATabVisibleIndex: Integer): Boolean; override;
    procedure Paint; override;
    procedure PaintButtonsRegion; override;
    procedure PaintTab(TabVisibleIndex: Integer); virtual;
    procedure PaintTabsRegion; override;
    procedure RepaintButton(Button: TcxPCNavigatorButton; OldButtonState: TcxPCNavigatorButtonState); override;
    procedure RepaintButtonsRegion; override;
    procedure RepaintTab(TabVisibleIndex: Integer; TabPropertyChanged: TcxPCTabPropertyChanged); override;

    procedure CalculateButtonContentParameters(AButton: TcxPCNavigatorButton;
      out AParameters: TcxPCNavigatorButtonContentParameters); virtual;
    procedure CalculateButtonsRect(NavigatorButtons: TcxPCNavigatorButtons); virtual;
    procedure CalculateButtonsRegion(NavigatorButtons: TcxPCNavigatorButtons); virtual;
    function CalculateButtonsRegionWidth(NavigatorButtons: TcxPCNavigatorButtons): Integer; virtual;
    procedure CorrectTabHeightForImage(var AHeight: Integer);
    procedure DrawButtonContent(AButton: TcxPCNavigatorButton;
      const AParameters: TcxPCNavigatorButtonContentParameters;
      AContentRectLeftTopCorner: TPoint);
    function Get3DButtonContentPosition(AButton: TcxPCNavigatorButton): TPoint;
    function GetButtonArrow(AButton: TcxPCNavigatorButton): TcxPCArrow;
    function GetButtonCenteredContentPosition(AButton: TcxPCNavigatorButton): TPoint;
    function GetButtonColor(AButtonState: TcxPCNavigatorButtonState): TColor; virtual;
    function GetButtonContentColor(AButtonState: TcxPCNavigatorButtonState): TColor; virtual;
    function GetButtonContentPosition(AButton: TcxPCNavigatorButton): TPoint; virtual;
    function GetButtonHeight: Integer; virtual;
    function GetButtonWidth(Button: TcxPCNavigatorButton): Integer; virtual;
    function GetDefaultTabNormalHeight: Integer; virtual;
    function GetDefaultTabNormalHTextOffset: Integer; virtual;
    function GetDefaultTabNormalWidth: Integer; virtual;
    function GetFrameRect: TRect;
    function GetFreeSpaceColor: TColor; virtual;
    function GetMinFrameRectSize: Integer; virtual;
    function GetTabBorderWidth(Tab: TcxTab): Integer; virtual;
    function GetTabNormalWidth(ATabVisibleIndex: Integer): Integer; virtual;
    function GetTabsRectOffset: TRect; virtual;
    function InternalCalculateTabNormalHeight: Integer; virtual;
    procedure InternalDrawEdge(const Rect: TRect; Sunken: Boolean; ThinFrame: Boolean = False);
    procedure InternalDrawFocusRect(TabVisibleIndex: Integer; R: TRect); virtual;
    procedure PaintButton(Button: TcxPCNavigatorButton;
      const ButtonRect: TRect); virtual;
    procedure PaintButtonBackground(AButtonRect: TRect;
      AButtonState: TcxPCNavigatorButtonState); virtual;
    procedure PaintButtonFrame(var ARect: TRect;
      AButtonState: TcxPCNavigatorButtonState); virtual;
    procedure PaintFrame; override;
    procedure PaintFrameBorder(R: TRect); virtual;
    procedure PaintTabShape(ATab: TcxTab; ATabVisibleIndex: Integer); virtual; abstract;
    procedure PrepareTabBackground(ATab: TcxTab; ATabVisibleIndex: Integer); virtual;
    procedure GetButtonsOrder(ANavigatorButtons: TcxPCNavigatorButtons;
      var AButtonPositions: TcxPCNavigatorButtonPositions); virtual;
    property ButtonsRect: TRect read FButtonsRect;
  public
    constructor Create(AParent: TcxCustomTabControl); override;
    destructor Destroy; override;
    function CalculateTabNormalHeight: Integer; override;
    function GetGoDialogButtonBounds: TRect; override;
    class function IsMainTabBoundWithClient: boolean; override;
    class function IsMultiSelectionAccepted: boolean; override;
    class function IsStandardStyle: Boolean; override;
    class function IsTabPressable: Boolean; override;
  end;

  { TcxPCButtonedPainter }

  TcxPCButtonedPainter = class(TcxPCStandardPainter)
  private
    MainTabBrushBitmap: TBitmap;
  protected
    function GetButtonContentPosition(AButton: TcxPCNavigatorButton): TPoint; override;
    function GetButtonsRegionHOffset: Integer; override;
    function GetButtonsRegionWOffset: Integer; override;
    function GetDisplayRectOffset: TRect; override;
    function GetTabBodyColor(TabVisibleIndex: Integer): TColor; override;
    function GetTabContentWOffset(ATabVisibleIndex: Integer): TcxPCWOffset; override;
    function GetTabsContainerOffsets: TRect; override;
    function GetTooNarrowTabContentWOffset(ATabVisibleIndex: Integer): TcxPCWOffset; override;
    function IsTabBorderThick(ATabVisibleIndex: Integer): Boolean; override;
  public
    constructor Create(AParent: TcxCustomTabControl); override;
    destructor Destroy; override;
  end;

  { TcxPCTabsPainter }

  TcxPCTabsPainter = class(TcxPCStandardPainter)
  private
{    FMDC: HDC;
    FPrevMDCBitmap: HBITMAP;}
  protected
    procedure CorrectTabRect(TabVisibleIndex: Integer;
      var TabRectCorrection: TcxPCRectCorrection); override;
    procedure DrawNativeTabBackground(DC: HDC; ATab: TcxTabSheet); override;
    function GetButtonContentPosition(AButton: TcxPCNavigatorButton): TPoint; override;
    function GetButtonHeight: Integer; override;
    function GetButtonsRegionHOffset: Integer; override;
    function GetButtonsRegionWOffset: Integer; override;
    function GetButtonWidth(Button: TcxPCNavigatorButton): Integer; override;
    function GetClientRectOffset: TRect; override;
    function GetDisplayRectOffset: TRect; override;
    function GetDrawImageOffset(TabVisibleIndex: Integer): TRect; override;
    function GetDrawImageWithoutTextWOffset(TabVisibleIndex: Integer): TcxPCWOffset; override;
    function GetDrawTextHOffset(TabVisibleIndex: Integer): TRect; override;
    function GetImageTextDistance(ATabVisibleIndex: Integer): Integer; override;
    function GetTabBodyColor(TabVisibleIndex: Integer): TColor; override;
    function GetTabClipRgn(ATabVisibleIndex: Integer): TcxRegion; override;
    function GetTabClipRgnOperation(ATabVisibleIndex: Integer): TcxRegionOperation; override;
    function GetTabContentWOffset(ATabVisibleIndex: Integer): TcxPCWOffset; override;
    function GetTabFocusRect(const ATabBounds: TRect): TRect; virtual;
    procedure GetTabNativePartAndState(ATabVisibleIndex: Integer;
      out PartId, StateId: Integer); override;
    function GetTabsContainerOffsets: TRect; override;
    function GetTabsPosition(NavigatorButtons: TcxPCNavigatorButtons): TcxPCTabsPosition; override;
    function GetTooNarrowTabContentWOffset(
      ATabVisibleIndex: Integer): TcxPCWOffset; override;
    function InternalCalculateTabNormalHeight: Integer; override;
    procedure InternalPrepareOutTabImageAndTextData(ATabVisibleIndex: Integer;
      var AImageRect, ATextRect: TRect); override;
    procedure InvalidateTabRect(ATabVisibleIndex: Integer); override;
    function IsNativePainting: Boolean; override;
    function IsOverTab(TabVisibleIndex: Integer; X, Y: Integer): Boolean; override;
    function NeedShowFrame: Boolean; override;
    procedure Paint; override;
    procedure PaintButton(Button: TcxPCNavigatorButton;
      const ButtonRect: TRect); override;
    procedure PaintClientArea; override;
    procedure PaintFrame; override;
    procedure PaintTabShape(ATab: TcxTab; ATabVisibleIndex: Integer); override;
    procedure PaintTabsRegion; override;
    procedure PaintNativeTabBackground(DC: HDC; ATabVisibleIndex: Integer; const ABounds: TRect); virtual;
//    procedure PrepareBackgroundBitmap; virtual;
    procedure PrepareTabBackground(ATab: TcxTab; ATabVisibleIndex: Integer); override;
    procedure PrepareTabBitmapBackground(ABitmap: TBitmap; const ARect: TRect; ATab: TcxTab); virtual;
    procedure RepaintTab(TabVisibleIndex: Integer; TabPropertyChanged: TcxPCTabPropertyChanged); override;
    function GetMinFrameRectSize: Integer; override;
    procedure GetTabCornersColor(ATabVisibleIndex: Integer;
      out AColor1, AColor2: TColor); virtual;
    procedure PaintTabCorners(ATabVisibleIndex: Integer); virtual;
    procedure PaintTabFrame(ATabVisibleIndex: Integer); virtual;
    procedure InternalPaintFrame(ACanvas: TCanvas); virtual;
  public
    class function GetStandardStyle: TcxPCStandardStyle; override;
    class function GetStyleID: TcxPCStyleID; override;
    class function GetStyleName: TCaption; override;
    class function HasLookAndFeel(ALookAndFeel: TcxLookAndFeel): Boolean; override;
    class function IsDefault(ALookAndFeel: TcxLookAndFeel): Boolean; override;
  end;

  { TcxPCButtonsPainter }

  TcxPCButtonsPainter = class(TcxPCButtonedPainter)
  protected
    function IsTabBorderThick(ATabVisibleIndex: Integer): Boolean; override;
    procedure PaintTabShape(ATab: TcxTab; ATabVisibleIndex: Integer); override;
  public
    class function GetStandardStyle: TcxPCStandardStyle; override;
    class function GetStyleID: TcxPCStyleID; override;
    class function GetStyleName: TCaption; override;
    class function HasLookAndFeel(ALookAndFeel: TcxLookAndFeel): Boolean; override;
  end;

  { TcxPCFlatButtonsPainter }

  TcxPCFlatButtonsPainter = class(TcxPCButtonedPainter)
  protected
    procedure PaintTab(TabVisibleIndex: Integer); override;
    procedure PaintTabShape(ATab: TcxTab; ATabVisibleIndex: Integer); override;
  public
    class function GetStandardStyle: TcxPCStandardStyle; override;
    class function GetStyleID: TcxPCStyleID; override;
    class function GetStyleName: TCaption; override;
    class function HasLookAndFeel(ALookAndFeel: TcxLookAndFeel): Boolean; override;
  end;

  { TcxPCExtraFlatPainter }

  TcxPCExtraFlatPainter = class(TcxPCStandardPainter)
  protected
    procedure CalculateButtonContentParameters(AButton: TcxPCNavigatorButton;
      out AParameters: TcxPCNavigatorButtonContentParameters); override;
    function CalculateTabNormalWidth(Tab: TcxTab): Integer; override;
    procedure CorrectTabRect(TabVisibleIndex: Integer; var TabRectCorrection: TcxPCRectCorrection); override;
    function GetButtonColor(AButtonState: TcxPCNavigatorButtonState): TColor; override;
    function GetButtonContentColor(AButtonState: TcxPCNavigatorButtonState): TColor; override;
    function GetButtonContentPosition(AButton: TcxPCNavigatorButton): TPoint; override;
    function GetButtonHeight: Integer; override;
    function GetButtonWidth(Button: TcxPCNavigatorButton): Integer; override;
    function GetClientRectOffset: TRect; override;
    function GetDefaultClientColor: TColor; override;
    function GetDefaultTabNormalHeight: Integer; override;
    function GetDefaultTabNormalHTextOffset: Integer; override;
    function GetDisplayRectOffset: TRect; override;
    function GetDrawImageOffset(TabVisibleIndex: Integer): TRect; override;
    function GetDrawTextHOffset(TabVisibleIndex: Integer): TRect; override;
    function GetFrameWidth: Integer; override;
    function GetFreeSpaceColor: TColor; override;
    function GetMinTabNormalWidth(ATabVisibleIndex: Integer): Integer; override;
    function GetTabBodyColor(TabVisibleIndex: Integer): TColor; override;
    function GetTabBorderWidth(Tab: TcxTab = nil): Integer; override;
    function GetTabContentWOffset(ATabVisibleIndex: Integer): TcxPCWOffset; override;
    function GetTabNormalWidth(ATabVisibleIndex: Integer): Integer; override;
    function GetTabsRowsDelimiterWidth: Integer; virtual;
    function GetTabsNormalDistance: TcxPCDistance; override;
    function GetTabsPosition(NavigatorButtons: TcxPCNavigatorButtons): TcxPCTabsPosition; override;
    function GetTooNarrowTabContentWOffset(ATabVisibleIndex: Integer): TcxPCWOffset; override;
    function InternalCalculateTabNormalHeight: Integer; override;
    procedure InternalPaint; override;
    procedure PaintButtonFrame(var ARect: TRect;
      AButtonState: TcxPCNavigatorButtonState); override;
    procedure PaintClientArea; override;
    procedure PaintFrame; override;
    procedure PaintTabShape(ATab: TcxTab; ATabVisibleIndex: Integer); override;
    procedure PaintTabsRegion; override;
    procedure RepaintTab(TabVisibleIndex: Integer; TabPropertyChanged: TcxPCTabPropertyChanged); override;
    function GetButtonsDistance(AButton1, AButton2: TcxPCNavigatorButton): Integer; override;
    function GetButtonsRegionHOffset: Integer; override;
    function GetButtonsRegionWOffset: Integer; override;
    function GetFocusRect: TRect; virtual;
    function GetTabsDelimiterOffsets: TcxPCTabsDelimiterOffsets; virtual;
    procedure DrawBackground(ACanvas: TCanvas; ARect: TRect;
      ATabVisibleIndex: Integer); virtual;
    procedure ExcludeUnderLine(var R: TRect); virtual;
    function GetMainTabRowUnderlineColor: TColor; virtual;
    function GetMainTabRowUnderlineRect: TRect; virtual;
    function GetTabBackgroundRect(ATabVisibleIndex: Integer;
      AForNormalState: Boolean): TRect; virtual;
    function GetTabsDelimiterWidth: Integer; virtual;
    function GetTabsRowColor: TColor; virtual;
    function GetTabsRowRect(ARowIndex: Integer): TRect;
    procedure InternalPaintFrame(ALeftTopColor, ARightBottomColor: TColor);
    procedure InternalPaintMainTabFrame(var R: TRect; ALightColor, ADarkColor: TColor);
    procedure InternalPaintTabsRowsDelimiter(var ARowRect: TRect;
      AColors: array of TColor);
    function IsMainTabRow(AVisibleRow: Integer): Boolean;
    function NeedShowTabsRegionFrame: Boolean; virtual;
    procedure PaintMainTabFrame(var R: TRect); virtual;
    procedure PaintMainTabRowUnderline;
    procedure PaintTabsDelimiter(const ARect: TRect); virtual;
    procedure PaintTabsRowsDelimiter(var ARowRect: TRect; ARowIndex: Integer); virtual;
  public
    function CalculateTabNormalHeight: Integer; override;
    class function GetStyleID: TcxPCStyleID; override;
    class function GetStyleName: TCaption; override;
    class function HasLookAndFeel(ALookAndFeel: TcxLookAndFeel): Boolean; override;
    class function IsMainTabBoundWithClient: boolean; override;
    class function IsMultiSelectionAccepted: boolean; override;
    class function IsTabPressable: Boolean; override;
  end;

  { TcxPCUltraFlatPainter }

  TcxPCUltraFlatPainter = class(TcxPCExtraFlatPainter)
  protected
    procedure CalculateButtonContentParameters(AButton: TcxPCNavigatorButton;
      out AParameters: TcxPCNavigatorButtonContentParameters); override;
    function GetButtonColor(AButtonState: TcxPCNavigatorButtonState): TColor; override;
    function GetButtonContentPosition(AButton: TcxPCNavigatorButton): TPoint; override;
    function GetButtonHeight: Integer; override;
    function GetButtonsDistance(AButton1, AButton2: TcxPCNavigatorButton): Integer; override;
    function GetButtonsRegionHOffset: Integer; override;
    function GetButtonWidth(Button: TcxPCNavigatorButton): Integer; override;
    function GetFocusRect: TRect; override;
    procedure PaintButtonFrame(var ARect: TRect;
      AButtonState: TcxPCNavigatorButtonState); override;
    procedure PaintFrame; override;
    procedure PaintMainTabFrame(var R: TRect); override;
    procedure PaintTabsRowsDelimiter(var ARowRect: TRect; ARowIndex: Integer); override;
  public
    class function GetStyleID: TcxPCStyleID; override;
    class function GetStyleName: TCaption; override;
    class function HasLookAndFeel(ALookAndFeel: TcxLookAndFeel): Boolean; override;
  end;

  { TcxPCFlatPainter }

  TcxPCFlatPainter = class(TcxPCTabsPainter)
  protected
    function GetButtonContentPosition(AButton: TcxPCNavigatorButton): TPoint; override;
    function GetButtonHeight: Integer; override;
    function GetButtonWidth(Button: TcxPCNavigatorButton): Integer; override;
    function GetFrameWidth: Integer; override;
    function GetTabClipRgn(ATabVisibleIndex: Integer): TcxRegion; override;
    function GetTabClipRgnOperation(ATabVisibleIndex: Integer): TcxRegionOperation; override;
    function IsNativePainting: Boolean; override;
    function NeedShowFrame: Boolean; override;
    procedure PaintButtonFrame(var ARect: TRect;
      AButtonState: TcxPCNavigatorButtonState); override;
    procedure PaintFrameBorder(R: TRect); override;
    procedure PaintTabFrame(ATabVisibleIndex: Integer); override;
  public
    class function GetStyleID: TcxPCStyleID; override;
    class function GetStyleName: TCaption; override;
    class function HasLookAndFeel(ALookAndFeel: TcxLookAndFeel): Boolean; override;
  end;

  { TcxPCOffice11Painter }

  TcxPCOffice11Painter = class(TcxPCUltraFlatPainter)
  private
    function GetSelectedColor1: TColor;
    function GetSelectedColor2: TColor;
    function IsGradientClienArea: Boolean;
    function NeedShowMainTabOppositeRowLine: Boolean;
    procedure PaintMainTabOppositeRowLine;
  protected
    class function GetFrameColor: TColor; virtual;
    procedure DrawBackground(ACanvas: TCanvas; ARect: TRect;
      ATabVisibleIndex: Integer); override;
    procedure ExcludeUnderLine(var R: TRect); override;
    procedure FillDisplayRect; override;
    function GetButtonContentColor(AButtonState: TcxPCNavigatorButtonState): TColor; override;
    function GetClientRectOffset: TRect; override;
    function GetFocusRect: TRect; override;
    function GetFreeSpaceColor: TColor; override;
    function GetMainTabRowUnderlineColor: TColor; override;
    function GetMainTabRowUnderlineRect: TRect; override;
    function GetTabBodyColor(TabVisibleIndex: Integer): TColor; override;
    function GetTabsDelimiterOffsets: TcxPCTabsDelimiterOffsets; override;
    function GetTabsDelimiterWidth: Integer; override;
    function GetTabsRowsDelimiterWidth: Integer; override;
    function IsTabTransparent(ATabVisibleIndex: Integer): Boolean; override;
    function NeedRedrawOnResize: Boolean; override;
    function NeedShowTabsRegionFrame: Boolean; override;
    procedure PaintButtonBackground(AButtonRect: TRect;
      AButtonState: TcxPCNavigatorButtonState); override;
    procedure PaintButtonFrame(var ARect: TRect;
      AButtonState: TcxPCNavigatorButtonState); override;
    procedure PaintClientArea; override;
    procedure PaintFrame; override;
    procedure PaintMainTabFrame(var R: TRect); override;
    procedure PaintTabsDelimiter(const ARect: TRect); override;
    procedure PaintTabsRowsDelimiter(var ARowRect: TRect; ARowIndex: Integer); override;
    procedure PrepareDrawTabContentBitmapBackground(ABitmap: TBitmap;
      const ABitmapPos: TPoint; ATabVisibleIndex: Integer); override;
    procedure DrawGradientBackground(ACanvas: TCanvas; ARect: TRect;
      ATabVisibleIndex: Integer; AHorizontal, AInverse: Boolean);
  public
    class function GetStyleID: TcxPCStyleID; override;
    class function GetStyleName: TCaption; override;
    class function HasLookAndFeel(ALookAndFeel: TcxLookAndFeel): Boolean; override;
  end;

  { TcxPCSlantedPainter }

  TcxPCSlantedPainter = class(TcxPCStandardPainter)
  private
    FCutValue: Integer;
    function GetTabsLineRect(ATabIndexInterval: TcxPCIndexInterval; AFullRect: Boolean): TRect;
    function GetTabUnderlineRect(ATab: TcxTab): TRect;
  protected
    function AlwaysColoredTabs: Boolean; override;
    procedure CalculateButtonContentParameters(AButton: TcxPCNavigatorButton;
      out AParameters: TcxPCNavigatorButtonContentParameters); override;
    function CalculateTabNormalWidth(Tab: TcxTab): Integer; override;
    procedure FillDisplayRect; override;
    function GetButtonColor(AButtonState: TcxPCNavigatorButtonState): TColor; override;
    function GetButtonContentColor(AButtonState: TcxPCNavigatorButtonState): TColor; override;
    function GetButtonContentPosition(AButton: TcxPCNavigatorButton): TPoint; override;
    function GetButtonHeight: Integer; override;
    function GetButtonsDistance(AButton1, AButton2: TcxPCNavigatorButton): Integer; override;
    function GetButtonsRegionFromTabsOffset: Integer; override;
    function GetButtonsRegionHOffset: Integer; override;
    function GetButtonsRegionWOffset: Integer; override;
    function GetButtonWidth(Button: TcxPCNavigatorButton): Integer; override;
    function GetClientColor: TColor; override;
    function GetClientRectOffset: TRect; override;
    function GetDefaultTabNormalHeight: Integer; override;
    function GetDrawImageOffset(TabVisibleIndex: Integer): TRect; override;
    function GetDrawTextHOffset(TabVisibleIndex: Integer): TRect; override;
    function GetFrameWidth: Integer; override;
    function GetImageTextDistance(ATabVisibleIndex: Integer): Integer; override;
    function GetMinTabNormalWidth(ATabVisibleIndex: Integer): Integer; override;
    function GetTabBodyColor(TabVisibleIndex: Integer): TColor; override;
    function GetTabClipRgn(ATabVisibleIndex: Integer): TcxRegion; override;
    function GetTabContentWOffset(ATabVisibleIndex: Integer): TcxPCWOffset; override;
    function GetTabNormalWidth(ATabVisibleIndex: Integer): Integer; override;
    function GetTabsContainerOffsets: TRect; override;
    function GetTabsNormalDistance: TcxPCDistance; override;
    function GetTabsRectOffset: TRect; override;
    function GetTooNarrowTabContentWOffset(ATabVisibleIndex: Integer): TcxPCWOffset; override;
    procedure Init; override;
    function InternalCalculateTabNormalHeight: Integer; override;
    function IsOverTab(TabVisibleIndex: Integer; X, Y: Integer): Boolean; override;
    function IsTabBorderThick(ATabVisibleIndex: Integer): Boolean; override;
    procedure PaintButtonFrame(var ARect: TRect;
      AButtonState: TcxPCNavigatorButtonState); override;
    procedure PaintFrame; override;
    procedure PaintTabShape(ATab: TcxTab; ATabVisibleIndex: Integer); override;
    procedure PaintTabsRegion; override;
    procedure PrepareDrawTabContentBitmapBackground(ABitmap: TBitmap;
      const ABitmapPos: TPoint; ATabVisibleIndex: Integer); override;

    function CanLightMainTab: Boolean; virtual;
    function DirectionalGetFigureRegion(const R: TRect; APoints: array of TPoint;
      ALinePositions: array of TLinePosition; ATabPositon: TcxTabPosition;
      AForContent: Boolean): TcxRegion;
    procedure DrawBackground(ACanvas: TCanvas; R: TRect;
      ATabVisibleIndex: Integer; AHorizontalGradient, AInverseGradient: Boolean); virtual;
    procedure DrawTabUnderline(ATabVisibleIndex: Integer); virtual;
    procedure GetBackgroundGradientColors(ATabVisibleIndex: Integer;
      out AColor1, AColor2: TColor); virtual;
    function GetCutValue: Integer;
    function GetGeometricalMinTabWidth: Integer; virtual;
    function GetFrameColor: TColor; virtual;
    function GetSlantedSides: TcxTabSlantPositions; virtual;
    procedure GetTabFramePolyline(ATabVisibleIndex: Integer;
      out APoints: TPoints; out ALinePositions: TLinePositions);
    function GetTabImageSize: TSize; virtual;
    function GetVerticalTextIndent: Integer; virtual;
    function InternalGetCutValue: Integer; virtual;
    function InternalGetTabClipRegion(ATabVisibleIndex: Integer;
      AForContent: Boolean): TcxRegion; virtual;
    procedure PaintTabFrame(ATabVisibleIndex: Integer; const R: TRect); virtual;
    procedure PaintTabStateMark(ATabVisibleIndex: Integer); virtual;

    property SlantedSides: TcxTabSlantPositions read GetSlantedSides;
  public
    class function GetStyleID: TcxPCStyleID; override;
    class function GetStyleName: TCaption; override;
    class function HasLookAndFeel(ALookAndFeel: TcxLookAndFeel): Boolean; override;
  end;

  { TcxPCOneNotePainter }

  TcxPCOneNotePainter = class(TcxPCSlantedPainter)
  protected
    class function AllowRotate: Boolean; override;
    function CanLightMainTab: Boolean; override;
    procedure DrawTabUnderline(ATabVisibleIndex: Integer); override;
    procedure GetBackgroundGradientColors(ATabVisibleIndex: Integer;
      out AColor1, AColor2: TColor); override;
    function GetButtonsRegionHOffset: Integer; override;
    function GetDrawImageOffset(TabVisibleIndex: Integer): TRect; override;
    function GetDrawTextHOffset(TabVisibleIndex: Integer): TRect; override;
    function GetFrameColor: TColor; override;
    function GetGeometricalMinTabWidth: Integer; override;
    function GetSlantedSides: TcxTabSlantPositions; override;
    function GetTabContentWOffset(ATabVisibleIndex: Integer): TcxPCWOffset; override;
    function GetTabsContainerOffsets: TRect; override;
    function GetTabsNormalDistance: TcxPCDistance; override;
    function GetTabsRectOffset: TRect; override;
    function InternalGetCutValue: Integer; override;
    function InternalGetTabClipRegion(ATabVisibleIndex: Integer;
      AForContent: Boolean): TcxRegion; override;
    procedure PaintTabFrame(ATabVisibleIndex: Integer; const R: TRect); override;
    procedure PaintTabStateMark(ATabVisibleIndex: Integer); override;
  public
    class function GetStyleID: TcxPCStyleID; override;
    class function GetStyleName: TCaption; override;
    class function HasLookAndFeel(ALookAndFeel: TcxLookAndFeel): Boolean; override;
  end;

procedure DrawBorder(ACanvas: TcxCanvas; var ARect: TRect; ASides: array of TcxBorder; AColors: array of TColor; AExcludeBorder: Boolean = False);
procedure GetRectSize(const R: TRect; AIsHorizontal: Boolean;
  out ARWidth, ARHeight: Integer);
procedure RotateTabsDistance(var ADistance: TcxPCDistance);

var
  cxPCLightBrushColor: TColor;

implementation

uses
  Math, cxLookAndFeelPainters, cxPCPaintersFactory, dxThemeConsts,
  dxThemeManager, dxUxTheme, dxOffice11, cxGeometry;

const
  ButtonsPainterTabContentWOffsetA: array[Boolean] of TcxPCWOffset = (
    (Left: 4; Right: 4),
    (Left: 3; Right: 4)
  );

  StandardNativePainterButtonHeight = 17;
  StandardNativePainterButtonWidth = 17;
  StandardPainterButtonHeight = 20;
  StandardPainterButtonWidthA: array [Boolean, TcxPCNavigatorButton] of Integer = (
    (20, 20, 12, 20), // TabPosition in [tpLeft, tpRight]
    (20, 20, 13, 20)  // TabPosition in [tpTop, tpBottom]
  );
  StandardPainterTabBorderWidth = 2;
  StandardPainterDefaultTabNormalHeightA: array [TcxPCStandardStyle] of Integer = (18, 20, 20);
  StandardPainterDefaultTabNormalHTextOffsetA: array [TcxPCStandardStyle] of Integer = (2, 4, 4);
  StandardPainterDrawImageOffsetA: array [Boolean, TcxPCStandardStyle] of TRect = (
   ((Left: 6; Top: 1; Right: 0; Bottom: 0),
    (Left: 6; Top: -1; Right: 0; Bottom: 1),
    (Left: 6; Top: -1; Right: 0; Bottom: 1)
   ),
   ((Left: 8; Top: 1; Right: 0; Bottom: 3),
    (Left: 7; Top: -1; Right: 0; Bottom: 1),
    (Left: 7; Top: -1; Right: 0; Bottom: 1)
   )
  );
  StandardPainterDrawTextHOffsetA: array [Boolean, TcxPCStandardStyle] of TRect = (
   ((Left: 5; Top: 1; Right: 5; Bottom: -1),
    (Left: 6; Top: 0; Right: 4; Bottom: 1),
    (Left: 6; Top: 0; Right: 4; Bottom: 1)
   ),
   ((Left: 5; Top: 1; Right: 5; Bottom: 2),
    (Left: 6; Top: 0; Right: 4; Bottom: 1),
    (Left: 6; Top: 0; Right: 4; Bottom: 1)
   )
  );
  StandardPainterTabContentWOffsetA: array [Boolean, TcxPCStandardStyle] of TcxPCWOffset = (
   ((Left: 2; Right: 2),
    (Left: 3; Right: 3),
    (Left: 2; Right: 2)
   ),
   ((Left: 4; Right: 4),
    (Left: 3; Right: 3),
    (Left: 4; Right: 2)
   )
  );
  StandardPainterTabsNormalDistanceA: array [TcxPCStandardStyle] of TcxPCDistance = (
    (dw: 0; dh: 0),
    (dw: 3; dh: 3),
    (dw: 10; dh: 3)
  );
  StandardPainterMaxTabBorderWidth = 2;
  StandardPainterWDistanceBetweenImageBorderAndText = 1;
  StandardPainterTooNarrowTabContentWOffsetA: array [Boolean, TcxPCStandardStyle] of TcxPCWOffset = (
   ((Left: 2; Right: 2),
    (Left: 3; Right: 3),
    (Left: 2; Right: 2)
   ),
   ((Left: 4; Right: 4),
    (Left: 3; Right: 3),
    (Left: 3; Right: 2)
   )
  );

  TabsPainterContentWOffsetA: array[Boolean, Boolean] of TcxPCWOffset = (
   ((Left: 3; Right: 3),
    (Left: 3; Right: 3)),
   ((Left: 5; Right: 5),
    (Left: 4; Right: 5))
  );
  TabsPainterDrawImageWithoutTextRotatedMainTabWOffset: array[Boolean] of TcxPCWOffset =
    ((Left: 1; Right: 2), (Left: 2; Right: 1));
  TabsPainterButtonBorderWidth = 2;

  ExtraFlatPainterButtonSize = 13;
  ExtraFlatPainterDefaultTabNormalWidth = 0;
  ExtraFlatPainterDrawImageOffsetA: array [Boolean] of TRect = (
    (Left: 2; Top: 0; Right: 0; Bottom: 0),
    (Left: 3; Top: 0; Right: 0; Bottom: 0)
  );
  ExtraFlatPainterDrawTextHOffsetA: array [Boolean] of TRect = (
    (Left: 5; Top: 2; Right: 3; Bottom: 0),
    (Left: 6; Top: 2; Right: 3; Bottom: 0)
  );
  ExtraFlatPainterMainTabBorderWidth = 1;
  ExtraFlatPainterMainTabRectCorrection: TcxPCRectCorrection = (
    dLeft: -1; dTop: -1; dRight: 1; dBottom: 1
  );
  ExtraFlatPainterTabContentWOffset: array [Boolean] of TcxPCWOffset = (
    (Left: 2; Right: 2),
    (Left: 3; Right: 3)
  );
  ExtraFlatPainterWDistanceBetweenImageBorderAndText = 0;
  ExtraFlatPainterTabsRowFreeSpaceWidth = 3;

  ExtraFlatPainterMainTabRowUnderlineWidth = 2;

  ButtonedPainterDistanceBetweenTabsAndClientRects = 2;

  MinTabSelectionDistance: TcxPCDistance = (dw: 4; dh: 4);

  cxPCDarkEdgeColor = clBtnShadow;
  cxPCDarkestEdgeColor = cl3DDkShadow;
  cxPCTabBodyColor = clBtnFace;
  cxPCLightEdgeColor = {clNavy}cl3DLight;
  cxPCLightestEdgeColor = clBtnHighlight;

  cxPCLightBrushColorDelta = 20;

  cxPCArrowConvertionA: array [nbTopLeft .. nbBottomRight, Boolean] of TcxPCArrow = (
    (aLeft, aTop),
    (aRight, aBottom)
  );
  cxPCArrowSizeA: array [nbTopLeft .. nbGoDialog] of Integer = (5, 5, 4);

  UltraFlatPainterButtonWidthA: array[TcxPCNavigatorButton] of Integer =
    (15, 15, 11, 14);
  UltraFlatPainterButtonHeight = 15;

  FlatPainterButtonBorderWidth = 1;

  SlantedPainterButtonWidthA: array[TcxPCNavigatorButton] of Integer =
    (17, 17, 13, 16);
  SlantedPainterButtonHeight = 17;

  CutCornerSize = 6;
  SlantedPainterTabStateMarkWidth = 3;
  OneNotePainterTabFrameWidth = 2;

  CloseButtonCrossSize = 9;

type
  TWinControlAccess = class(TWinControl);

  { TcxPaletteChangedNotifier }

  TcxPaletteChangedNotifier = class(TcxSystemPaletteChangedNotifier)
  protected
    procedure DoChanged; override;
  end;

var
  FPaletteChangedNotifier: TcxPaletteChangedNotifier;
  OneNoteMainTabBorderColor: COLORREF;
  OneNoteTabBorderColor: COLORREF;
  OneNoteMainTabInnerBorderColor: COLORREF;
  OneNoteTabHotBorderColor: COLORREF;
  OneNoteTabInnerBorderColor1: COLORREF;
  OneNoteTabInnerBorderColor2: COLORREF;

procedure AddPoints(var APoints: TPoints; const ANewPoints: array of TPoint;
  var ALinePositions: TLinePositions; const ANewLinePositions: array of TLinePosition);
var
  I, AArrayLength: Integer;
begin
  AArrayLength := Length(APoints);
  SetLength(APoints, AArrayLength + Length(ANewPoints));
  for I := 0 to Length(ANewPoints) - 1 do
    APoints[AArrayLength + I] := ANewPoints[I];

  AArrayLength := Length(ALinePositions);
  SetLength(ALinePositions, AArrayLength + Length(ANewLinePositions));
  for I := 0 to Length(ANewLinePositions) - 1 do
    ALinePositions[AArrayLength + I] := ANewLinePositions[I];
end;
  
procedure CalculateLightBrushColor;
var
  R, G, B: Integer;
  Color: Integer;
begin
  Color := ColorToRGB(clBtnFace);
  R := GetRValue(Color) + cxPCLightBrushColorDelta;
  if R > 255 then R := 255;
  G := GetGValue(Color) + cxPCLightBrushColorDelta;
  if G > 255 then G := 255;
  B := GetBValue(Color) + cxPCLightBrushColorDelta;
  if B > 255 then B := 255;
  cxPCLightBrushColor := RGB(R, G, B);
end;

procedure DrawBorder(ACanvas: TcxCanvas; var ARect: TRect; ASides: array of TcxBorder; AColors: array of TColor; AExcludeBorder: Boolean = False);
var
  I: Integer;
  ARegion: TcxRegion;
  AInitialRect: TRect;
begin
  AInitialRect := ARect;
  for I := 0 to High(ASides) do
  begin
    ACanvas.Pen.Color := AColors[I];
    case ASides[I] of
      bLeft:
        begin
          ACanvas.Polyline([ARect.TopLeft, Point(ARect.Left, ARect.Bottom)]);
          Inc(ARect.Left);
        end;
      bTop:
        begin
          ACanvas.Polyline([ARect.TopLeft, Point(ARect.Right, ARect.Top)]);
          Inc(ARect.Top);
        end;
      bRight:
        begin
          ACanvas.Polyline([Point(ARect.Right - 1, ARect.Top), Point(ARect.Right - 1, ARect.Bottom)]);
          Dec(ARect.Right);
        end;
      bBottom:
        begin
          ACanvas.Polyline([Point(ARect.Left, ARect.Bottom - 1), Point(ARect.Right, ARect.Bottom - 1)]);
          Dec(ARect.Bottom);
        end;
    end;
  end;
  if AExcludeBorder then
  begin
    ARegion := TcxRegion.Create(AInitialRect);
    ARegion.Combine(TcxRegion.Create(ARect), roSubtract);
    ACanvas.SetClipRegion(ARegion, roSubtract);
  end;
end;

function GetControlRect(Control: TControl): TRect;
begin
  Result.Left := 0;
  Result.Top := 0;
  Result.Right := Control.Width;
  Result.Bottom := Control.Height;
end;

function GetFigureRegion(APoints: array of TPoint;
  const ALinePositions: array of TLinePosition; AForContent: Boolean): TcxRegion;

  function ThereIsLine(ALinePosition: TLinePosition): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 0 to High(ALinePositions) do
      if ALinePositions[I] = ALinePosition then
      begin
        Result := True;
        Break;
      end;
  end;

var
  I: Integer;
  P1, P2: TPoint;
begin
  for I := 0 to High(APoints) - 1 do
  begin
    P1 := APoints[I];
    P2 := APoints[I + 1];
    if AForContent then
    begin
      case ALinePositions[I] of
        lpL:
          begin
            Inc(P1.X);
            Inc(P2.X);
            if ThereIsLine(lpLB) then
              Inc(P1.Y);
            if ThereIsLine(lpLT) then
              Dec(P2.Y);
          end;
        lpLT:
          begin
            if ThereIsLine(lpL) then
              Inc(P1.Y)
            else
              Inc(P1.X);
            if ThereIsLine(lpT) then
              Inc(P2.X)
            else
              Inc(P2.Y);
          end;
        lpLB:
          begin
            if ThereIsLine(lpB) then
              Inc(P1.X)
            else
              Dec(P1.Y);
            if ThereIsLine(lpL) then
              Dec(P2.Y)
            else
              Inc(P2.X);
          end;
        lpT:
          begin
            Inc(P1.Y);
            Inc(P2.Y);
            if ThereIsLine(lpLT) then
              Dec(P1.X);
            if ThereIsLine(lpRT) then
              Inc(P2.X);
          end;
      end;
    end
    else
      case ALinePositions[I] of
        lpRT:
          begin
            if ThereIsLine(lpT) then
              Inc(P1.X)
            else
              Dec(P1.Y);
            if ThereIsLine(lpR) then
              Dec(P2.Y)
            else
              Inc(P2.X);
          end;
        lpR:
          begin
            Inc(P1.X);
            Inc(P2.X);
            if ThereIsLine(lpRT) then
              Inc(P1.Y);
            if ThereIsLine(lpRB) then
              Dec(P2.Y);
          end;
        lpRB:
          begin
            if ThereIsLine(lpR) then
              Inc(P1.Y)
            else
              Inc(P1.X);
            if ThereIsLine(lpB) then
              Inc(P2.X)
            else
              Inc(P2.Y);
          end;
        lpB:
          begin
            Inc(P1.Y);
            Inc(P2.Y);
            if ThereIsLine(lpRB) then
              Dec(P1.X);
            if ThereIsLine(lpLB) then
              Inc(P2.X);
          end;
      end;
    APoints[I] := P1;
    APoints[I + 1] := P2;
  end;
  Result := TcxRegion.Create(CreatePolygonRgn(APoints, Length(APoints), WINDING));
end;

procedure GetRectSize(const R: TRect; AIsHorizontal: Boolean;
  out ARWidth, ARHeight: Integer);
begin
  if AIsHorizontal then
  begin
    ARWidth := R.Right - R.Left;
    ARHeight := R.Bottom - R.Top;
  end
  else
  begin
    ARWidth := R.Bottom - R.Top;
    ARHeight := R.Right - R.Left;
  end;
end;

function HSBToRGB(AHue, ASaturation, ABrightness: Extended): TColor;

  procedure GetRGB(out R, G, B: Integer);
  var
    AMinColorComponent, AMaxColorComponent: Extended;
  begin
    if ABrightness = 0 then
    begin
      R := 0;
      G := 0;
      B := 0;
      Exit;
    end;
    AMaxColorComponent := ABrightness * 255 / 100;
    AMinColorComponent := AMaxColorComponent * (100 - ASaturation) / 100;
    if AHue <= 60 then
    begin
      R := Trunc(AMaxColorComponent);
      G := Trunc(AMinColorComponent + (AMaxColorComponent - AMinColorComponent) * AHue / 60);
      B := Trunc(AMinColorComponent);
    end
    else if AHue <= 120 then
    begin
      R := Trunc(AMaxColorComponent + (AMaxColorComponent - AMinColorComponent) * (60 - AHue) / 60);
      G := Trunc(AMaxColorComponent);
      B := Trunc(AMinColorComponent);
    end
    else if AHue <= 180 then
    begin
      R := Trunc(AMinColorComponent);
      G := Trunc(AMaxColorComponent);
      B := Trunc(AMinColorComponent + (AMaxColorComponent - AMinColorComponent) * (AHue - 120) / 60);
    end
    else if AHue <= 240 then
    begin
      R := Trunc(AMinColorComponent);
      G := Trunc(AMaxColorComponent + (AMaxColorComponent - AMinColorComponent) * (180 - AHue) / 60);
      B := Trunc(AMaxColorComponent);
    end
    else if AHue <= 300 then
    begin
      R := Trunc(AMinColorComponent + (AMaxColorComponent - AMinColorComponent) * (AHue - 240) / 60);
      G := Trunc(AMinColorComponent);
      B := Trunc(AMaxColorComponent);
    end
    else
    begin
      R := Trunc(AMaxColorComponent);
      G := Trunc(AMinColorComponent);
      B := Trunc(AMaxColorComponent + (AMaxColorComponent - AMinColorComponent) * (300 - AHue) / 60);
    end
  end;

var
  R, G, B: Integer;
begin
  GetRGB(R, G, B);
  Result := RGB(R, G, B);
end;

procedure RGBToHSB(ARGBColor: TColor; out Hue, Saturation, Brightness: Extended);
var
  AMinColorComponent: Integer;
  R, G, B: Integer;

  procedure PreCalculate;
  begin
    ARGBColor := ColorToRGB(ARGBColor);
    R := GetRValue(ARGBColor);
    G := GetGValue(ARGBColor);
    B := GetBValue(ARGBColor);

    AMinColorComponent := R;
    if G < AMinColorComponent then
      AMinColorComponent := G;
    if B < AMinColorComponent then
      AMinColorComponent := B;
  end;

  function GetBrightness: Integer;
  begin
    Result := R;
    if G > Result then
      Result := G;
    if B > Result then
      Result := B;
  end;

  function GetSaturation(ABrightness: Extended): Extended;
  begin
    if ABrightness = 0 then
      Result := 0
    else
      Result := 100 - AMinColorComponent * 100 / ABrightness;
  end;

  function GetHue(ABrightness: Integer; ASaturation: Extended): Extended;
  begin
    if ASaturation = 0 then
      Result := 0 // ???
    else
    begin
      if R = ABrightness then
        Result := (G - B) * 60 / (ABrightness - AMinColorComponent)
      else if G = ABrightness then
        Result := (B - R) * 60 / (ABrightness - AMinColorComponent) + 120
      else
        Result := (R - G) * 60 / (ABrightness - AMinColorComponent) + 240;
      if Result < 0 then
        Result := Result + 360;
    end;
  end;

var
  ABrightness: Integer;
begin
  PreCalculate;

  ABrightness := GetBrightness;
  Brightness := ABrightness * 100 / 255;
  Saturation := GetSaturation(ABrightness);
  Hue := GetHue(ABrightness, Saturation);
end;

function Light(AColor: TColor; APercentage: Byte): TColor;
var
  AHue, ASaturation, ABrightness: Extended;
begin
  RGBToHSB(ColorToRGB(AColor), AHue, ASaturation, ABrightness);
  ABrightness := ABrightness * (100 + APercentage) / 100;
  if ABrightness > 100 then
    ABrightness := 100;
  Result := HSBToRGB(AHue, ASaturation, ABrightness);
end;

procedure PrepareOneNoteStyleColors;
const
  AColors: array[TOffice11Scheme, 0..5] of TColor = (
    (clBtnShadow, clBtnShadow, clWhite, $6A240A, clBtnFace, clBtnFace),
    ($9C613B, $9A3500, clWhite, $800000, clWhite, $F1A675),
    ($588060, $6B7760, clWhite, $385D3F, clWhite, $8CC2B0),
    ($947C7C, $927476, clWhite, $6F4B4B, clWhite, $CEB9BA)
  );
var
  AColorScheme: TOffice11Scheme;
begin
  AColorScheme := GetOffice11Scheme;
  OneNoteMainTabBorderColor := AColors[AColorScheme, 0];
  OneNoteTabBorderColor := AColors[AColorScheme, 1];
  OneNoteMainTabInnerBorderColor := AColors[AColorScheme, 2];
  OneNoteTabHotBorderColor := AColors[AColorScheme, 3];
  OneNoteTabInnerBorderColor1 := AColors[AColorScheme, 4];
  OneNoteTabInnerBorderColor2 := AColors[AColorScheme, 5];
end;

procedure RotateTabsDistance(var ADistance: TcxPCDistance);
var
  A: Integer;
begin
  A := ADistance.dw;
  ADistance.dw := ADistance.dh;
  ADistance.dh := A;
end;

function Size(cx, cy: Integer): TSize;
begin
  Result.cx := cx;
  Result.cy := cy;
end;

procedure TcxPCTabsPainter.CorrectTabRect(TabVisibleIndex: Integer;
  var TabRectCorrection: TcxPCRectCorrection);
const
  TabRectCorrectionA: array[TcxTabPosition] of TcxPCRectCorrection = (
    (dLeft: -2; dTop: -2; dRight: 2; dBottom: 1),
    (dLeft: -2; dTop: -1; dRight: 2; dBottom: 2),
    (dLeft: -2; dTop: -2; dRight: 1; dBottom: 2),
    (dLeft: -1; dTop: -2; dRight: 2; dBottom: 2)
  );
begin
  inherited CorrectTabRect(TabVisibleIndex, TabRectCorrection);
  if TabVisibleIndex = ParentInfo.MainTabVisibleIndex then
    TabRectCorrection := TabRectCorrectionA[ParentInfo.VisibleTabs[TabVisibleIndex].PaintingPosition];
end;

procedure TcxPCTabsPainter.DrawNativeTabBackground(DC: HDC; ATab: TcxTabSheet);
var
  ATheme: TdxTheme;
  R: TRect;
begin
  R := GetDisplayRect;
  InflateRect(R, StandardPainterTabControlFrameBorderWidth,
    StandardPainterTabControlFrameBorderWidth);
  OffsetRect(R, -ATab.Left, -ATab.Top);
  ATheme := OpenTheme(totTab);
  DrawThemeBackground(ATheme, DC, TABP_PANE, 0, R);
end;

function TcxPCTabsPainter.GetButtonContentPosition(
  AButton: TcxPCNavigatorButton): TPoint;
begin
  Result := Get3DButtonContentPosition(AButton);
end;

function TcxPCTabsPainter.GetButtonHeight: Integer;
begin
  if not IsNativePainting then
    Result := inherited GetButtonHeight
  else
    Result := StandardNativePainterButtonHeight;              
end;

function TcxPCTabsPainter.GetButtonsRegionHOffset: Integer;
begin
  Result := 0;
  if ParentInfo.IsTabsContainer then
    Result := TabsContainerOffset;
end;

function TcxPCTabsPainter.GetButtonsRegionWOffset: Integer;
begin
  Result := 0;
  if ParentInfo.IsTabsContainer then
    Result := TabsContainerOffset;
end;

function TcxPCTabsPainter.GetButtonWidth(Button: TcxPCNavigatorButton): Integer;
var
  ASize: TSize;
begin
  if IsNativePainting then
  begin
    Result := StandardNativePainterButtonWidth;
    if Button = nbGoDialog then
    begin
      if GetThemePartSize(OpenTheme(totSpin), ParentInfo.Canvas.Handle, SPNP_DOWN,
        DNS_NORMAL, TS_TRUE, ASize) = S_OK then
          Result := ASize.cx;
    end
    (*else
      if Button = nbClose then
      begin
        if GetThemePartSize(OpenTheme(totWindow), ParentInfo.Canvas.Handle, WP_SMALLCLOSEBUTTON,
          CBS_NORMAL, TS_TRUE, ASize) = S_OK then
            if ParentInfo.TabPosition in [tpTop, tpBottom] then
              Result := ASize.cx
            else
              Result := ASize.cy;
      end;*)
  end
  else
    Result := inherited GetButtonWidth(Button);
end;

function TcxPCTabsPainter.GetClientRectOffset: TRect;

  function GetNativeFrameSizeCorrection: TRect;
  var
    R: TRect;
  begin
    R := GetNativeContentOffset;
    case ParentInfo.TabPosition of
      tpLeft:
        Result := Rect(R.Bottom, R.Left, R.Top, R.Right);
      tpTop:
        Result := R;
      tpRight:
        Result := Rect(R.Top, R.Right, R.Bottom, R.Left);
      tpBottom:
        Result := Rect(R.Right, R.Bottom, R.Left, R.Top);
    end;
    Result.Right := -Result.Right;
    Result.Bottom := -Result.Bottom;
  end;

begin
  Result := inherited GetClientRectOffset;
  if IsNativePainting then
  begin
    OffsetRect(Result, -StandardPainterTabControlFrameBorderWidth,
      -StandardPainterTabControlFrameBorderWidth);
    cxGraphics.ExtendRect(Result, GetNativeFrameSizeCorrection);
  end;
  if ParentInfo.IsTabsContainer and not IsNativePainting then
    Inc(Result.Top, TabsContainerBaseWidth - GetFrameWidth);
end;

function TcxPCTabsPainter.GetDisplayRectOffset: TRect;
begin
  Result := inherited GetDisplayRectOffset;
  if not ParentInfo.HideTabs and (ParentInfo.RowCount > 0) then
    Dec(Result.Top);
end;

function TcxPCTabsPainter.GetDrawImageOffset(TabVisibleIndex: Integer): TRect;
begin
  Result := inherited GetDrawImageOffset(TabVisibleIndex);
  if (ParentInfo.VisibleTabs[TabVisibleIndex].PaintingPositionIndex in [5, 7, 10]) then
    Inc(Result.Bottom);
end;

function TcxPCTabsPainter.GetDrawImageWithoutTextWOffset(TabVisibleIndex: Integer): TcxPCWOffset;
begin
  if ParentInfo.Rotate and ParentInfo.VisibleTabs[TabVisibleIndex].IsMainTab then
    Result := TabsPainterDrawImageWithoutTextRotatedMainTabWOffset[ParentInfo.VisibleTabs[TabVisibleIndex].PaintingPositionIndex in [3, 6, 11]]
  else
    Result := inherited GetDrawImageWithoutTextWOffset(TabVisibleIndex);
end;

function TcxPCTabsPainter.GetDrawTextHOffset(TabVisibleIndex: Integer): TRect;
begin
  Result := inherited GetDrawTextHOffset(TabVisibleIndex);
  if (ParentInfo.VisibleTabs[TabVisibleIndex].PaintingPositionIndex in [5, 7, 10]) then
    Inc(Result.Bottom);
  with ParentInfo do
    if VisibleTabs[TabVisibleIndex].IsMainTab and (GetTabRotatedImageSize.cx = 0) then
      Inc(Result.Left, 2);
end;

function TcxPCTabsPainter.GetImageTextDistance(ATabVisibleIndex: Integer): Integer;
//var
//  ACorrection: Integer;
//  ATab: TcxTab;
//  ATabContentWOffset: TcxPCWOffset;
begin
  Result := inherited GetImageTextDistance(ATabVisibleIndex);
//  ATab := ParentInfo.VisibleTabs[ATabVisibleIndex];
//  if ParentInfo.Rotate and (ATab.Caption <> '') then
//  begin
//    ATabContentWOffset := TabsPainterContentWOffsetA[IsTabBorderThick(ATabVisibleIndex),
//      ParentInfo.Rotate];
//    if ATab.PaintingPositionIndex in [3, 6, 11] then
//      ExchangeValues(ATabContentWOffset.Left, ATabContentWOffset.Right);
//    ACorrection := 12;
//    if ATab.IsMainTab then
//      Inc(ACorrection, 3);
//    ACorrection := (ACorrection - ATabContentWOffset.Left - ATabContentWOffset.Right) div 2;
//    Inc(Result, ACorrection);
//  end;
end;

{ TcxPCTabsPainter }

class function TcxPCTabsPainter.GetStandardStyle: TcxPCStandardStyle;
begin
  Result := tsTabs;
end;

class function TcxPCTabsPainter.GetStyleID: TcxPCStyleID;
begin
  Result := cxPCTabsStyle;
end;

class function TcxPCTabsPainter.GetStyleName: TCaption;
begin
  Result := 'Tabs';
end;

class function TcxPCTabsPainter.HasLookAndFeel(ALookAndFeel: TcxLookAndFeel): Boolean;
begin
  Result := ALookAndFeel.GetAvailablePainter([totTab]).LookAndFeelStyle in
    [lfsStandard, lfsNative];
end;

class function TcxPCTabsPainter.IsDefault(ALookAndFeel: TcxLookAndFeel): Boolean;
begin
  Result := ALookAndFeel.NativeStyle;
end;

function TcxPCTabsPainter.GetTabBodyColor(TabVisibleIndex: Integer): TColor;
var
  ATab: TcxTab;
begin
  ATab := ParentInfo.VisibleTabs[TabVisibleIndex];
  if ATab.Highlighted then
    Result := HighlightedTabBodyColor
  else
  begin
    Result := GetTabColor(TabVisibleIndex);
    if Result = clDefault then
      Result := cxPCTabBodyColor;
  end;
end;

function TcxPCTabsPainter.GetTabClipRgn(ATabVisibleIndex: Integer): TcxRegion;
var
  ATab: TcxTab;
  ATabRect: TRect;
begin
  ATab := ParentInfo.VisibleTabs[ATabVisibleIndex];

  ATabRect := ATab.VisibleRect;
  if ATab.IsMainTab then
    ATabRect := GetExtendedRect(ATab.VisibleRect, Rect(0, 0, 0, -1), ATab.PaintingPosition);

  Result := TcxRegion.Create(ATabRect);
end;

function TcxPCTabsPainter.GetTabClipRgnOperation(ATabVisibleIndex: Integer): TcxRegionOperation;
begin
  if not ParentInfo.VisibleTabs[ATabVisibleIndex].IsMainTab then
    Result := roIntersect
  else
    Result := roSet;
end;

function TcxPCTabsPainter.GetTabContentWOffset(ATabVisibleIndex: Integer): TcxPCWOffset;
var
//  ACorrection: Integer;
  ATab: TcxTab;
begin
  Result := TabsPainterContentWOffsetA[IsTabBorderThick(ATabVisibleIndex),
    ParentInfo.Rotate];
  ATab := ParentInfo.VisibleTabs[ATabVisibleIndex];
  if ATab.PaintingPositionIndex in [3, 6, 11] then
    ExchangeLongWords(Result.Left, Result.Right);
//  if ParentInfo.Rotate and (ATab.Caption <> '') then
//  begin
//    ACorrection := 12;
//    if ATab.IsMainTab then
//      Inc(ACorrection, 3);
//    ACorrection := (ACorrection - Result.Left - Result.Right) div 2;
//    if GetTabBaseImageSize.cx = 0 then
//      Inc(Result.Left, ACorrection);
//    Inc(Result.Right, ACorrection);
//  end;
end;

function TcxPCTabsPainter.GetTabFocusRect(const ATabBounds: TRect): TRect;
begin
  Result := ATabBounds;
  InflateRect(Result, -StandardPainterTabBorderWidth, -StandardPainterTabBorderWidth);
end;

procedure TcxPCTabsPainter.GetTabNativePartAndState(ATabVisibleIndex: Integer;
  out PartId, StateId: Integer);
type
  TcxTabPositionWithinRow = (tprLeftMost, tprMiddle, tprRightMost);
const
  ATabNativePartA: array[Boolean, TcxTabPositionWithinRow] of Integer = (
    (TABP_TABITEMLEFTEDGE, TABP_TABITEM, TABP_TABITEMRIGHTEDGE),
    (TABP_TOPTABITEMLEFTEDGE, TABP_TOPTABITEM, TABP_TOPTABITEMRIGHTEDGE)
  );
var
  ALineIndexBoundsA: TcxPCLineIndexBoundsArray;
  ATab: TcxTab;
  ATabPositionWithinRow: TcxTabPositionWithinRow;
begin
  ATab := ParentInfo.VisibleTabs[ATabVisibleIndex];
  InitializeLineBoundsArray(ParentControl, ALineIndexBoundsA);

  if ParentInfo.MultiLine and not ParentInfo.RaggedRight then
  begin
    if ParentInfo.IsTabsContainer then
      ATabPositionWithinRow := tprMiddle
    else
      if (ALineIndexBoundsA[ATab.VisibleRow].Right = ATab.VisibleIndex) then
        ATabPositionWithinRow := tprRightMost
      else
        if ALineIndexBoundsA[ATab.VisibleRow].Left = ATab.VisibleIndex then
          ATabPositionWithinRow := tprLeftMost
        else
          ATabPositionWithinRow := tprMiddle;
  end
  else
    if ParentInfo.IsTabsContainer then
      ATabPositionWithinRow := tprMiddle
    else
      if ALineIndexBoundsA[ATab.VisibleRow].Left = ATab.VisibleIndex then
        ATabPositionWithinRow := tprLeftMost
      else
        if ATab.VisibleIndex = ParentControl.Tabs.VisibleTabsCount - 1 then
          ATabPositionWithinRow := tprRightMost
        else
          ATabPositionWithinRow := tprMiddle;

  // to work like standard PageControl
  if not ParentInfo.MultiLine or ParentInfo.RaggedRight then
    if ATab.IsMainTab and (ATabPositionWithinRow = tprRightMost) then
      ATabPositionWithinRow := tprMiddle;

  PartId := ATabNativePartA[ATab.IsMainTab, ATabPositionWithinRow];
  StateId := GetTabNativeState(ATabVisibleIndex);
end;

function TcxPCTabsPainter.GetTabsContainerOffsets: TRect;
begin
  Result := Rect(TabsContainerOffset, TabsContainerOffset, TabsContainerOffset, 0);
end;

function TcxPCTabsPainter.GetTabsPosition(
  NavigatorButtons: TcxPCNavigatorButtons): TcxPCTabsPosition;

var
  NormalTabsRectCorrection: TRect;

  procedure DoHardCalculation(var ATabsPosition: TcxPCTabsPosition);
  var
    AButtonsWidth: Integer;
    ATabsContainerOffset: TRect;
  begin
    AButtonsWidth := CalculateButtonsRegionWidth(NavigatorButtons);
    ATabsContainerOffset := cxEmptyRect;
    if ParentInfo.IsTabsContainer then
      ATabsContainerOffset := GetTabsContainerOffsets;

    NormalTabsRectCorrection := RotateRect(Rect(0, 2 + ATabsContainerOffset.Top, 0, 0), ParentInfo.TabPosition);
    ExtendRect(ATabsPosition.ExtendedTabsRect, RotateRect(Rect(0, ATabsContainerOffset.Top, 0, 0), ParentInfo.TabPosition));
    with ParentInfo do
    begin
      if TabPosition in [tpTop, tpBottom] then
      begin
        if MultiLine or (NavigatorButtons = []) then
        begin
          ATabsPosition.ExtendedTabsRect.Left := ATabsContainerOffset.Left;
          ATabsPosition.ExtendedTabsRect.Right := Width - ATabsContainerOffset.Left;
          NormalTabsRectCorrection.Left := 2 + ATabsContainerOffset.Left;
          NormalTabsRectCorrection.Right := 2 + ATabsContainerOffset.Left;
        end
        else
        begin
          if NavigatorPosition in [npLeftTop, npLeftBottom] then
          begin
            ATabsPosition.ExtendedTabsRect.Left := AButtonsWidth;
            ATabsPosition.ExtendedTabsRect.Right := Width - ATabsContainerOffset.Left;
          end
          else
          begin
            ATabsPosition.ExtendedTabsRect.Left := ATabsContainerOffset.Left;
            ATabsPosition.ExtendedTabsRect.Right := Width - AButtonsWidth;
          end;
          NormalTabsRectCorrection.Left := ATabsPosition.ExtendedTabsRect.Left + 2;
          NormalTabsRectCorrection.Right := Width - ATabsPosition.ExtendedTabsRect.Right + 2;
        end;
        ATabsPosition.NormalRowWidth := Width - NormalTabsRectCorrection.Left - NormalTabsRectCorrection.Right;
      end
      else
      begin
        if MultiLine or (NavigatorButtons = []) then
        begin
          ATabsPosition.ExtendedTabsRect.Top := ATabsContainerOffset.Left;
          ATabsPosition.ExtendedTabsRect.Bottom := Height - ATabsContainerOffset.Left;
          NormalTabsRectCorrection.Top := 2 + ATabsContainerOffset.Left;
          NormalTabsRectCorrection.Bottom := 2 + ATabsContainerOffset.Left;
        end
        else
        begin
          if NavigatorPosition in [npLeftTop, npRightTop] then
          begin
            ATabsPosition.ExtendedTabsRect.Top := AButtonsWidth;
            ATabsPosition.ExtendedTabsRect.Bottom := Height - ATabsContainerOffset.Left;
          end
          else
          begin
            ATabsPosition.ExtendedTabsRect.Top := ATabsContainerOffset.Left;
            ATabsPosition.ExtendedTabsRect.Bottom := Height - AButtonsWidth;
          end;
          NormalTabsRectCorrection.Top := ATabsPosition.ExtendedTabsRect.Top + 2;
          NormalTabsRectCorrection.Bottom := Height - ATabsPosition.ExtendedTabsRect.Bottom + 2;
        end;
        ATabsPosition.NormalRowWidth := Height - NormalTabsRectCorrection.Top - NormalTabsRectCorrection.Bottom;
      end;
    end;
  end;

begin
  with Result do
  begin
    ExtendedTabsRect := GetControlRect(ParentControl);
    NormalTabsRect := ExtendedTabsRect;

    DoHardCalculation(Result);

    cxGraphics.ExtendRect(NormalTabsRect, NormalTabsRectCorrection);

    ExtendedTopOrLeftTabsRectBottomOrRightBorderOffset := 0;
    ExtendedBottomOrRightTabsRectTopOrLeftBorderOffset := 0;
    if ParentInfo.TabPosition in [tpTop, tpLeft] then
      ExtendedTopOrLeftTabsRectBottomOrRightBorderOffset := 1
    else
      ExtendedBottomOrRightTabsRectTopOrLeftBorderOffset := -1;
    MinDistanceBetweenTopOrLeftAndBottomOrRightExtendedTabsRects := 0;
  end;

  CalculateButtonsRegion(NavigatorButtons);
end;

function TcxPCTabsPainter.GetTooNarrowTabContentWOffset(
  ATabVisibleIndex: Integer): TcxPCWOffset;
begin
  Result := GetTabContentWOffset(ATabVisibleIndex);
end;

function TcxPCTabsPainter.InternalCalculateTabNormalHeight: Integer;
begin
  if ParentInfo.Rotate then
    Result := inherited InternalCalculateTabNormalHeight - 2
  else
    Result := inherited InternalCalculateTabNormalHeight - 3;
end;

procedure TcxPCTabsPainter.InternalPrepareOutTabImageAndTextData(
  ATabVisibleIndex: Integer; var AImageRect, ATextRect: TRect);
var
  ATab: TcxTab;
begin
  ATab := ParentInfo.VisibleTabs[ATabVisibleIndex];
  if IsNativePainting and ATab.IsMainTab and (ATab.PaintingPositionIndex in [5, 7, 10]) then
  begin
    OffsetRect(AImageRect, 0, 1);
    OffsetRect(ATextRect, 0, 1);
  end;
  inherited InternalPrepareOutTabImageAndTextData(ATabVisibleIndex, AImageRect,
    ATextRect);
end;

procedure TcxPCTabsPainter.InvalidateTabRect(ATabVisibleIndex: Integer);
var
  ATab: TcxTab;
  R: TRect;
begin
  ATab := ParentInfo.VisibleTabs[ATabVisibleIndex];
  R := ATab.VisibleRect;
  R := GetExtendedRect(R, Rect(0, 0, 0, -1), ATab.PaintingPosition);
  ParentControl.InvalidateRect(R, False);
end;

function TcxPCTabsPainter.IsNativePainting: Boolean;
begin
  if csDestroying in ParentControl.ComponentState then
    Result := False
  else
    Result := ParentControl.LookAndFeel.NativeStyle and
      AreVisualStylesAvailable and (OpenTheme(totTab) <> TC_NONE);
end;

function TcxPCTabsPainter.IsOverTab(TabVisibleIndex: Integer; X, Y: Integer): Boolean;
begin
  // TODO
  Result := True;
end;

function TcxPCTabsPainter.NeedShowFrame: Boolean;
begin
  Result := True;
end;

procedure TcxPCTabsPainter.Paint;
begin
{  if IsNativePainting then
  begin
    FMDC := 0;
    FPrevMDCBitmap := 0;
    try
      FMDC := CreateCompatibleDC(ParentInfo.Canvas.Handle);
      FPrevMDCBitmap := SelectObject(FMDC,
        CreateCompatibleBitmap(ParentInfo.Canvas.Handle, ParentControl.Width,
        ParentControl.Height));

      PrepareBackgroundBitmap;
      inherited Paint;
    finally
      if FPrevMDCBitmap <> 0 then
        DeleteObject(SelectObject(FMDC, FPrevMDCBitmap));
      if FMDC <> 0 then
        DeleteDC(FMDC);
    end;
  end
  else}
    inherited Paint;
end;

procedure TcxPCTabsPainter.PaintButton(Button: TcxPCNavigatorButton;
  const ButtonRect: TRect);
const
  AArrowButtonPartIdMap: array [TcxPCArrow] of Integer = (SPNP_UP, SPNP_DOWN,
    SPNP_DOWNHORZ, SPNP_UPHORZ);
  AArrowButtonStateIdMap: array [TcxPCArrow, TcxPCNavigatorButtonState] of Integer = (
    (UPS_NORMAL, UPS_PRESSED, UPS_HOT, UPS_DISABLED),
    (DNS_NORMAL, DNS_PRESSED, DNS_HOT, DNS_DISABLED),
    (DNHZS_NORMAL, DNHZS_PRESSED, DNHZS_HOT, DNHZS_DISABLED),
    (UPHZS_NORMAL, UPHZS_PRESSED, UPHZS_HOT, UPHZS_DISABLED)
  );
  ACloseButtonStateIdMap: array [TcxPCNavigatorButtonState] of Integer =
    (CBS_NORMAL, CBS_PUSHED, CBS_HOT, CBS_DISABLED);
var
  AArrow: TcxPCArrow;
  APartId, AStateId: Integer;
  ATheme: TdxTheme;
begin
  if IsNativePainting then
  begin
    if Button = nbClose then
    begin
      ATheme := OpenTheme(totWindow);
      APartId := WP_SMALLCLOSEBUTTON;
      AStateId := ACloseButtonStateIdMap[ParentInfo.NavigatorButtonsState[Button]];
    end
    else
    begin
      ATheme := OpenTheme(totSpin);
      AArrow := GetButtonArrow(Button);
      APartId := AArrowButtonPartIdMap[AArrow];
      AStateId := AArrowButtonStateIdMap[AArrow, ParentInfo.NavigatorButtonsState[Button]];
    end;
    if ParentControl.ParentBackground and IsThemeBackgroundPartiallyTransparent(ATheme, APartId, AStateId) then
      cxDrawThemeParentBackground(ParentControl, ParentInfo.Canvas, ButtonRect)
    else
    begin
      ParentInfo.Canvas.Brush.Color := ParentInfo.Color;
      ParentInfo.Canvas.FillRect(ButtonRect);
    end;
    DrawThemeBackground(ATheme, ParentInfo.Canvas.Handle, APartId, AStateId,
      ButtonRect);
  end
  else
    inherited PaintButton(Button, ButtonRect);
end;

procedure TcxPCTabsPainter.PaintClientArea;
begin
  if IsNativePainting then
    InternalPaintFrame(ParentInfo.Canvas.Canvas)
  else
    inherited PaintClientArea;
end;

procedure TcxPCTabsPainter.PaintFrame;
var
  AFrameRect: TRect;
begin
  inherited PaintFrame;
  if ParentInfo.IsTabsContainer then
  begin
    AFrameRect := GetFrameRect;
    InflateRect(AFrameRect, -GetFrameWidth, -GetFrameWidth);
    ParentInfo.Canvas.Brush.Color := cxPCTabBodyColor;
    ParentInfo.Canvas.FillRect(AFrameRect);
  end;
end;

procedure TcxPCTabsPainter.PaintTabShape(ATab: TcxTab; ATabVisibleIndex: Integer);

  procedure PaintNativeFrame;
  var
    ABitmap: TBitmap;
    ATab: TcxTab;
    ATabRect: TRect;
  begin
    ATab := ParentInfo.VisibleTabs[ATabVisibleIndex];
    ATabRect := ATab.FullRect;
    if ATab.IsMainTab then
      ATabRect := GetExtendedRect(ATabRect, Rect(0, 0, 0, -1), ATab.PaintingPosition);
    ABitmap := ATab.PaintBitmap;
    case ATab.PaintingPositionIndex of
      2, 4, 7, 11:
        begin
          ParentInfo.Canvas.RotateBitmap(ABitmap, raPlus90);
          with FOutTabImageAndTextData.TabTextRect do
            FOutTabImageAndTextData.TabTextRect := Rect(Top, ABitmap.Width - Right, Bottom, ABitmap.Width - Left);
        end;
      3, 5, 8, 12:
        begin
          ParentInfo.Canvas.RotateBitmap(ABitmap, raMinus90);
          with FOutTabImageAndTextData.TabTextRect do
            FOutTabImageAndTextData.TabTextRect := Rect(ABitmap.Height - Bottom, Left, ABitmap.Height - Top, Right);
        end;
    end;
    OffsetRect(FOutTabImageAndTextData.TabTextRect, ATabRect.Left, ATabRect.Top);
    cxBitBlt(ParentInfo.Canvas.Handle, ABitmap.Canvas.Handle, ATabRect, cxNullPoint, SRCCOPY);
    InternalDrawFocusRect(ATabVisibleIndex, GetTabFocusRect(ATabRect));
  end;

var
  MainTab: Boolean;
  AFocusRect, R: TRect;
  TabPaintingPosition: TcxTabPosition;
begin
  if IsNativePainting then
  begin
    PaintNativeFrame;
    Exit;
  end;

  ATab := ParentInfo.VisibleTabs[ATabVisibleIndex];
  MainTab := ATab.IsMainTab;

  TabPaintingPosition := ATab.PaintingPosition;

  R := ATab.FullRect;
  InflateRect(R, -StandardPainterTabBorderWidth, -StandardPainterTabBorderWidth);
//  if MainTab or ParentInfo.IsTabsContainer then
    R := GetExtendedRect(R, Rect(0, 0, 0, -StandardPainterTabBorderWidth), TabPaintingPosition);

  ParentInfo.Canvas.Brush.Style := bsSolid;
  ParentInfo.Canvas.Brush.Color := GetTabBodyColor(ATabVisibleIndex);
  ParentInfo.Canvas.FillRect(R);

  if MainTab then
  begin
    AFocusRect := GetExtendedRect(R, Rect(0, 0, 0, 1), TabPaintingPosition);
    InternalDrawFocusRect(ATabVisibleIndex, AFocusRect);
  end;

  if not MainTab then
  begin
    SubtractRect(R, GetExtendedRect(R, Rect(0, 0, 0, -StandardPainterTabBorderWidth), TabPaintingPosition), R);
    ParentInfo.Canvas.Brush.Color := ParentInfo.Color;
    ParentInfo.Canvas.FillRect(R);
  end;

  PaintTabFrame(ATabVisibleIndex);
end;

procedure TcxPCTabsPainter.PaintTabsRegion;
var
  I: Integer;
  FirstIndex, LastIndex: Integer;
  MainTabVisibleIndex: Integer;
  SpecialTab: TcxTab;
begin
  MainTabVisibleIndex := ParentInfo.MainTabVisibleIndex;
  if MainTabVisibleIndex <> -1 then
  begin
    SpecialTab := ParentInfo.VisibleTabs[MainTabVisibleIndex];
    if SpecialTab.RealVisible then
      PaintTab(MainTabVisibleIndex);
  end;

  InitializeVisibleTabRange(ParentControl, FirstIndex, LastIndex);
  for I := FirstIndex to LastIndex do
    if I <> MainTabVisibleIndex then
      PaintTab(I);
end;

procedure TcxPCTabsPainter.PaintNativeTabBackground(
  DC: HDC; ATabVisibleIndex: Integer; const ABounds: TRect);
var
  ATheme: TdxTheme;
  APartId, AStateId: Integer;
begin
  GetTabNativePartAndState(ATabVisibleIndex, APartId, AStateId);
  ATheme := OpenTheme(totTab);
  DrawThemeBackground(ATheme, DC, APartId, AStateId, ABounds);
end;

{procedure TcxPCTabsPainter.PrepareBackgroundBitmap;
var
  ATempCanvas: TCanvas;
  R: TRect;
begin
  ATempCanvas := TCanvas.Create;
  try
    ATempCanvas.Handle := FMDC;
    R := GetControlRect(ParentControl);
    if ParentControl.ParentBackground then
      cxDrawThemeParentBackground(ParentControl, ATempCanvas, R)
    else
    begin
      ATempCanvas.Brush.Color := ParentInfo.Color;
      ATempCanvas.FillRect(R);
    end;
    InternalPaintFrame(ATempCanvas);
  finally
    ATempCanvas.Free;
  end;
end;                 }

procedure TcxPCTabsPainter.PrepareTabBackground(ATab: TcxTab; ATabVisibleIndex: Integer);
const
  RRectNativePaintingCorrectionA: array[TcxTabPosition] of TcxPCRectCorrection = (
    (dLeft: 0; dTop: 0; dRight: 0; dBottom: 1),
    (dLeft: 0; dTop: -1; dRight: 0; dBottom: 0),
    (dLeft: 0; dTop: 0; dRight: 1; dBottom: 0),
    (dLeft: -1; dTop: 0; dRight: 0; dBottom: 0)
  );

  procedure RotateTabBitmap(ABitmap: TBitmap; ARotateBack: Boolean);
  const
    PlusMinusAngleMap: array[Boolean] of TcxRotationAngle = (raPlus90, raMinus90);
  var
    ARotationAngle: TcxRotationAngle;
  begin
    case ATab.PaintingPositionIndex of
      4..9:
        ARotationAngle := PlusMinusAngleMap[ARotateBack];
      else
        ARotationAngle := ra0;
    end;
    ParentInfo.Canvas.RotateBitmap(ABitmap, ARotationAngle,
      ATab.PaintingPositionIndex in [4..6, 10..12])
  end;

var
  ABitmap: TBitmap;
  ARotationAngle: TcxRotationAngle;
  FullRect, R: TRect;
  MainTab: Boolean;
  R1: TRect;
  TabPaintingPosition: TcxTabPosition;
begin
  MainTab := ATab.IsMainTab;
  FullRect := ATab.FullRect;
  TabPaintingPosition := ATab.PaintingPosition;
  with ParentInfo.Canvas do
  begin
    R := FullRect;
    if MainTab then
      CorrectRect(R, RRectNativePaintingCorrectionA[TabPaintingPosition]);

    ABitmap := ATab.PaintBitmap;
    R1 := Rect(0, 0, R.Right - R.Left, R.Bottom - R.Top);
    if TabPaintingPosition in [tpLeft, tpRight] then
    begin
      ABitmap.Width := R1.Bottom;
      ABitmap.Height := R1.Right;
    end
    else
    begin
      ABitmap.Width := R1.Right;
      ABitmap.Height := R1.Bottom;
    end;
    RotateTabBitmap(ABitmap, True);
    PrepareTabBitmapBackground(ABitmap, R, ATab);
    RotateTabBitmap(ABitmap, False);
    R1 := Rect(0, 0, ABitmap.Width, ABitmap.Height);
    PaintNativeTabBackground(ABitmap.Canvas.Handle, ATabVisibleIndex, R1);
    case ATab.PaintingPositionIndex of
      2, 9, 12:
        ARotationAngle := raMinus90;
      6, 11, 3:
        ARotationAngle := raPlus90;
      4, 7:
        ARotationAngle := ra180;
      else
        ARotationAngle := ra0;
    end;
    RotateBitmap(ABitmap, ARotationAngle,
      ATab.PaintingPositionIndex in [4..6, 10..12]);
  end;
end;

procedure TcxPCTabsPainter.PrepareTabBitmapBackground(
  ABitmap: TBitmap; const ARect: TRect; ATab: TcxTab);
begin
  if IsNativePainting and ParentControl.ParentBackground then
    cxDrawTransparentControlBackground(ParentControl, ABitmap.Canvas, ARect)
  else
    FillRectByColor(ABitmap.Canvas.Handle,
      Rect(0, 0, ABitmap.Width, ABitmap.Height),
      GetFreeSpaceColor);
end;

procedure TcxPCTabsPainter.RepaintTab(TabVisibleIndex: Integer;
  TabPropertyChanged: TcxPCTabPropertyChanged);
begin
  if (TabPropertyChanged = tpcIsMainTab) and
     (not ParentInfo.VisibleTabs[TabVisibleIndex].IsMainTab) then
    InvalidateTabExtendedTabsRect(TabVisibleIndex)
  else
  begin
    if IsVerticalText(ParentControl) then
      ParentInfo.VisibleTabs[TabVisibleIndex].ResetVerticalTextBitmap;
    InvalidateTabRect(TabVisibleIndex);
  end;
end;

function TcxPCTabsPainter.GetMinFrameRectSize: Integer;
begin
  if ParentInfo.IsTabsContainer then
    Result := TabsContainerBaseWidth + GetFrameWidth
  else
    Result := inherited GetMinFrameRectSize;
end;

procedure TcxPCTabsPainter.GetTabCornersColor(ATabVisibleIndex: Integer;
  out AColor1, AColor2: TColor);
var
  ALineIndexBoundsA: TcxPCLineIndexBoundsArray;
  ATab: TcxTab;
begin
  ATab := ParentInfo.VisibleTabs[ATabVisibleIndex];
  if (ATab.VisibleRow = 0) and (ParentInfo.TopOrLeftPartRowCount > 0) or
    (ATab.VisibleRow = ParentInfo.RowCount - 1) and (ParentInfo.TopOrLeftPartRowCount <> ParentInfo.RowCount) then
  begin
    AColor1 := ParentInfo.Color;
    AColor2 := AColor1;
  end
  else
  begin
    AColor1 := clBtnFace;
    AColor2 := AColor1;
    if ATab.IsMainTab and not ParentInfo.Rotate then
    begin
      InitializeLineBoundsArray(ParentControl, ALineIndexBoundsA);
      if ALineIndexBoundsA[ATab.VisibleRow].Left = ATabVisibleIndex then
        AColor1 := ParentInfo.Color;
      if ALineIndexBoundsA[ATab.VisibleRow].Right = ATabVisibleIndex then
        AColor2 := ParentInfo.Color;
    end;
  end;
end;

procedure TcxPCTabsPainter.PaintTabCorners(ATabVisibleIndex: Integer);
var
  AColor1, AColor2: TColor;
  ATab: TcxTab;
begin
  ATab := ParentInfo.VisibleTabs[ATabVisibleIndex];

  GetTabCornersColor(ATabVisibleIndex, AColor1, AColor2);
  if (ATab.PaintingPosition in [tpLeft, tpRight]) and
    (GetTextRotationAngle(ParentControl) <> raMinus90) then
      ExchangeLongWords(AColor1, AColor2);

  with ATab.FullRect do
    case ATab.PaintingPosition of
      tpTop:
        begin
          InternalPolyLine([Point(Left, Top + 1), Point(Left, Top), Point(Left + 1, Top)], AColor1);
          InternalPolyLine([Point(Right - 2, Top), Point(Right - 1, Top), Point(Right - 1, Top + 1)], AColor2);
        end;
      tpBottom:
        begin
          InternalPolyLine([Point(Left, Bottom - 2), Point(Left, Bottom - 1), Point(Left + 1, Bottom - 1)], AColor1);
          InternalPolyLine([Point(Right - 2, Bottom - 1), Point(Right - 1, Bottom - 1), Point(Right - 1, Bottom - 2)], AColor2);
        end;
      tpLeft:
        begin
          InternalPolyLine([Point(Left, Top + 1), Point(Left, Top), Point(Left + 1, Top)], AColor1);
          InternalPolyLine([Point(Left, Bottom - 2), Point(Left, Bottom - 1), Point(Left + 1, Bottom - 1)], AColor2);
        end;
      tpRight:
        begin
          InternalPolyLine([Point(Right - 2, Top), Point(Right - 1, Top), Point(Right - 1, Top + 1)], AColor1);
          InternalPolyLine([Point(Right - 2, Bottom - 1), Point(Right - 1, Bottom - 1), Point(Right - 1, Bottom - 2)], AColor2);
        end;
    end;
end;

procedure TcxPCTabsPainter.PaintTabFrame(ATabVisibleIndex: Integer);
var
  ATabUnderlineColor: TColor;
  ATab: TcxTab;
begin
  ATab := ParentInfo.VisibleTabs[ATabVisibleIndex];
  if ParentInfo.IsTabsContainer then
    ATabUnderlineColor := clBtnFace
  else
    ATabUnderlineColor := GetTabBodyColor(ATabVisibleIndex);
  with ATab.FullRect do
    case ATab.PaintingPosition of
      tpTop:
        begin
          InternalPolyLine([Point(Left, Bottom - 1), Point(Left, Top + 2), Point(Left + 2, Top), Point(Right - 3, Top)], cxPCLightestEdgeColor);
          InternalPolyLine([Point(Left + 1, Bottom - 1), Point(Left + 1, Top + 2), Point(Left + 2, Top + 1), Point(Right - 3, Top + 1)], cxPCLightEdgeColor);
          InternalPolyLine([Point(Right - 1, Bottom - 1), Point(Right - 1, Top + 2), Point(Right - 2, Top + 1)], cxPCDarkestEdgeColor);
          InternalPolyLine([Point(Right - 2, Bottom - 1), Point(Right - 2, Top + 2)], cxPCDarkEdgeColor);

          if ATab.IsMainTab then
          begin
            if Left = 0 then
            begin
              InternalPolyLine([Point(Left, Bottom), Point(Left, Bottom)], cxPCLightestEdgeColor);
              InternalPolyLine([Point(Left + 1, Bottom), Point(Left + 1, Bottom)], cxPCLightEdgeColor);
            end
            else
              InternalPolyLine([Point(Left, Bottom), Point(Left + 1, Bottom)], cxPCLightEdgeColor);
            if Right = ParentInfo.Width then
            begin
              InternalPolyLine([Point(Left + 2, Bottom), Point(Right - 3, Bottom)], ATabUnderlineColor);
              InternalPolyLine([Point(Right - 2, Bottom), Point(Right - 2, Bottom)], cxPCDarkEdgeColor);
              InternalPolyLine([Point(Right - 1, Bottom), Point(Right - 1, Bottom)], cxPCDarkestEdgeColor);
            end
            else
              InternalPolyLine([Point(Left + 2, Bottom), Point(Right - 1, Bottom)], ATabUnderlineColor);
          end;
        end;
      tpBottom:
        begin
          InternalPolyLine([Point(Left, Top), Point(Left, Bottom - 3), Point(Left + 1, Bottom - 2)], cxPCLightestEdgeColor);
          InternalPolyLine([Point(Left + 1, Top), Point(Left + 1, Bottom - 3)], cxPCLightEdgeColor);
          InternalPolyLine([Point(Left + 2, Bottom - 1), Point(Right - 3, Bottom - 1), Point(Right - 1, Bottom - 3), Point(Right - 1, Top)], cxPCDarkestEdgeColor);
          InternalPolyLine([Point(Left + 2, Bottom - 2), Point(Right - 3, Bottom - 2), Point(Right - 2, Bottom - 3), Point(Right - 2, Top)], cxPCDarkEdgeColor);

          if ATab.IsMainTab then
          begin
            if Left = 0 then
            begin
              InternalPolyLine([Point(Left, Top - 1), Point(Left, Top - 1)], cxPCLightestEdgeColor);
              InternalPolyLine([Point(Left + 1, Top - 1), Point(Left + 1, Top - 1)], cxPCLightEdgeColor);
              InternalPolyLine([Point(Left + 2, Top - 1), Point(Right - 3, Top - 1)], ATabUnderlineColor);
            end
            else
              InternalPolyLine([Point(Left, Top - 1), Point(Right - 3, Top - 1)], ATabUnderlineColor);
            if Right = ParentInfo.Width then
            begin
              InternalPolyLine([Point(Right - 2, Top - 1), Point(Right - 2, Top - 1)], cxPCDarkEdgeColor);
              InternalPolyLine([Point(Right - 1, Top - 1), Point(Right - 1, Top - 1)], cxPCDarkestEdgeColor);
            end
            else
              InternalPolyLine([Point(Right - 2, Top - 1), Point(Right - 1, Top - 1)], cxPCDarkEdgeColor);
          end;
        end;
      tpLeft:
        begin
          InternalPolyLine([Point(Left, Bottom - 3), Point(Left, Top + 2), Point(Left + 2, Top), Point(Right - 1, Top)], cxPCLightestEdgeColor);
          InternalPolyLine([Point(Left + 1, Bottom - 3), Point(Left + 1, Top + 2), Point(Left + 2, Top + 1), Point(Right - 1, Top + 1)], cxPCLightEdgeColor);
          InternalPolyLine([Point(Left + 2, Bottom - 2), Point(Left + 3, Bottom - 1), Point(Right - 1, Bottom - 1)], cxPCDarkestEdgeColor);
          InternalPolyLine([Point(Left + 1, Bottom - 2), Point(Left + 2, Bottom - 1), Point(Left + 3, Bottom - 2), Point(Right - 1, Bottom - 2)], cxPCDarkEdgeColor);

          if ATab.IsMainTab then
          begin
            if Top = 0 then
            begin
              InternalPolyLine([Point(Right, Top), Point(Right, Top)], cxPCLightestEdgeColor);
              InternalPolyLine([Point(Right, Top + 1), Point(Right, Top + 1)], cxPCLightEdgeColor);
            end
            else
              InternalPolyLine([Point(Right, Top), Point(Right, Top + 1)], cxPCLightEdgeColor);
            if Bottom = ParentInfo.Height then
            begin
              InternalPolyLine([Point(Right, Top + 2), Point(Right, Bottom - 3)], ATabUnderlineColor);
              InternalPolyLine([Point(Right, Bottom - 2), Point(Right, Bottom - 2)], cxPCDarkEdgeColor);
              InternalPolyLine([Point(Right, Bottom - 1), Point(Right, Bottom - 1)], cxPCDarkestEdgeColor);
            end
            else
              InternalPolyLine([Point(Right, Top + 2), Point(Right, Bottom - 1)], ATabUnderlineColor);
          end;
        end;
      tpRight:
        begin
          InternalPolyLine([Point(Left, Top), Point(Right - 3, Top), Point(Right - 2, Top + 1)], cxPCLightestEdgeColor);
          InternalPolyLine([Point(Left, Top + 1), Point(Right - 3, Top + 1)], cxPCLightEdgeColor);
          InternalPolyLine([Point(Left, Bottom - 1), Point(Right - 3, Bottom - 1), Point(Right - 1, Bottom - 3), Point(Right - 1, Top + 2)], cxPCDarkestEdgeColor);
          InternalPolyLine([Point(Left, Bottom - 2), Point(Right - 3, Bottom - 2), Point(Right - 2, Bottom - 3), Point(Right - 2, Top + 2)], cxPCDarkEdgeColor);

          if ATab.IsMainTab then
          begin
            if Top = 0 then
            begin
              InternalPolyLine([Point(Left - 1, Top), Point(Left - 1, Top)], cxPCLightestEdgeColor);
              InternalPolyLine([Point(Left - 1, Top + 1), Point(Left - 1, Top + 1)], cxPCLightEdgeColor);
              InternalPolyLine([Point(Left - 1, Top + 2), Point(Left - 1, Bottom - 3)], ATabUnderlineColor);
            end
            else
              InternalPolyLine([Point(Left - 1, Top), Point(Left - 1, Bottom - 3)], ATabUnderlineColor);
              if Bottom = ParentInfo.Height then
              begin
                InternalPolyLine([Point(Left - 1, Bottom - 2), Point(Left - 1, Bottom - 2)], cxPCDarkEdgeColor);
                InternalPolyLine([Point(Left - 1, Bottom - 1), Point(Left - 1, Bottom - 1)], cxPCDarkestEdgeColor);
              end
              else
                InternalPolyLine([Point(Left - 1, Bottom - 2), Point(Left - 1, Bottom - 1)], cxPCDarkEdgeColor);
          end;
        end;
    end;
  PaintTabCorners(ATabVisibleIndex);
end;

procedure TcxPCTabsPainter.InternalPaintFrame(ACanvas: TCanvas);
var
  ARect, R: TRect;
  ATheme: TdxTheme;
begin
  ARect := GetDisplayRect;
  if IsRectEmpty(ARect) then
    Exit;
  ATheme := OpenTheme(totTab);
  R := GetNativeContentOffset;
  if ARect.Right - ARect.Left < R.Left + R.Right then
    ARect.Right := ARect.Left + R.Left + R.Right;
  if ARect.Bottom - ARect.Top < R.Top + R.Bottom then
    ARect.Bottom := ARect.Top + R.Top + R.Bottom;
  with ACanvas do
  begin
    if (ACanvas.Handle = ParentInfo.Canvas.Handle) and
      IsThemeBackgroundPartiallyTransparent(ATheme, TABP_PANE, 0) and ParentControl.ParentBackground then
        cxDrawThemeParentBackground(ParentControl, ACanvas, ARect)
    else
    begin
      Brush.Color := ParentInfo.Color;
      FillRect(ARect);
    end;
    DrawThemeBackground(ATheme, Handle, TABP_PANE, 0, ARect);
    if ACanvas.Handle = ParentInfo.Canvas.Handle then
      ParentInfo.Canvas.ExcludeClipRect(ARect);
  end;
end;

{ TcxPCFlatButtonsPainter }

class function TcxPCFlatButtonsPainter.GetStandardStyle: TcxPCStandardStyle;
begin
  Result := tsFlatButtons;
end;

class function TcxPCFlatButtonsPainter.GetStyleID: TcxPCStyleID;
begin
  Result := cxPCFlatButtonsStyle;
end;

class function TcxPCFlatButtonsPainter.GetStyleName: TCaption;
begin
  Result := 'FlatButtons';
end;

class function TcxPCFlatButtonsPainter.HasLookAndFeel(ALookAndFeel: TcxLookAndFeel): Boolean;
begin
  Result := False;
end;

procedure TcxPCFlatButtonsPainter.PaintTab(TabVisibleIndex: Integer);
var
  Tab: TcxTab;

  procedure InternalPaintTabsDelimiter;

    function IsDelimiterNeeded: Boolean;
    var
      FirstIndex, LastIndex, I: Integer;
      NextRow: Integer;
      IsY: Boolean;
      c: Integer; // coordinate
    begin
      Result := False;
      InitializeVisibleTabRange(ParentControl, FirstIndex, LastIndex);

      with ParentInfo do
        if Rotate then
        begin
          if (RowCount = 1) or (Tab.VisibleRow = RowCount - 1) then Exit;
          NextRow := Tab.VisibleRow + 1;
          IsY := TabPosition in [tpLeft, tpRight];
          c := PointGetter(Tab.FullRect.TopLeft, IsY);
          for I := FirstIndex to LastIndex do
            with VisibleTabs[I] do
              if (VisibleRow = NextRow) and (PointGetter(FullRect.TopLeft, IsY) = c) then
              begin
                Result := True;
                Break;
              end;
        end else
          if (TabVisibleIndex < LastIndex) and
             (VisibleTabs[TabVisibleIndex + 1].VisibleRow = Tab.VisibleRow) then
            Result := True;
    end;

  const
    DelimiterWidth = 2;
  var
    R: TRect;
    TabsDistance: Integer;
    DelimiterLeftBorder, DelimiterTopBorder: Integer;
    DelimiterRect: TRect;
  begin
    if not IsDelimiterNeeded then Exit;
    R := Tab.FullRect;
    TabsDistance := StandardPainterTabsNormalDistanceA[GetStandardStyle].dw;

    with R do
      if IsVerticalText(ParentControl) then
      begin
        if IsBottomToTopAlignment(ParentControl) then
        begin
          Bottom := Top;
          Top := Bottom - TabsDistance;
        end else
        begin
          Top := Bottom;
          Bottom := Top + TabsDistance;
        end;
        if not InternalSetClipRect(R) then Exit;
        DelimiterTopBorder := Top + (TabsDistance - DelimiterWidth) div 2;
        InternalPolyLine([Point(Left + 1, DelimiterTopBorder), Point(Right - 2, DelimiterTopBorder)], cxPCDarkEdgeColor);
        InternalPolyLine([Point(Left + 1, DelimiterTopBorder + 1), Point(Right - 2, DelimiterTopBorder + 1)], cxPCLightestEdgeColor);
        DelimiterRect := Rect(Left + 1, DelimiterTopBorder, Right - 1, DelimiterTopBorder + 2);
      end else
      begin
        if IsRightToLeftAlignment(ParentControl) then
        begin
          Right := Left;
          Left := Right - TabsDistance;
        end else
        begin
          Left := Right;
          Right := Left + TabsDistance;
        end;
        if not InternalSetClipRect(R) then Exit;
        DelimiterLeftBorder := Left + (TabsDistance - DelimiterWidth) div 2;
        InternalPolyLine([Point(DelimiterLeftBorder, Top + 1), Point(DelimiterLeftBorder, Bottom - 2)], cxPCDarkEdgeColor);
        InternalPolyLine([Point(DelimiterLeftBorder + 1, Top + 1), Point(DelimiterLeftBorder + 1, Bottom - 2)], cxPCLightestEdgeColor);
        DelimiterRect := Rect(DelimiterLeftBorder, Top + 1, DelimiterLeftBorder + 2, Bottom - 1);
      end;
    with ParentInfo.Canvas do
    begin
      SaveClipRgn;
      ExcludeClipRect(DelimiterRect);
      Brush.Style := bsSolid;
      Brush.Color := ParentInfo.Color;
      FillRect(R);
      RestoreClipRgn;
    end;

    InternalResetClipRegion;
    ParentInfo.Canvas.ExcludeClipRect(R);
  end;

begin
  inherited PaintTab(TabVisibleIndex);
  Tab := ParentInfo.VisibleTabs[TabVisibleIndex];
  InternalPaintTabsDelimiter;
end;

procedure TcxPCFlatButtonsPainter.PaintTabShape(ATab: TcxTab; ATabVisibleIndex: Integer);
var
  FullRect: TRect;
  TabBodyColor: TColor;
begin
  TabBodyColor := GetTabBodyColor(ATabVisibleIndex);
  FullRect := ATab.FullRect;
  with ParentInfo.Canvas, FullRect do
  begin
    if (not ATab.Tracking) and (ATab.Pressed or ATab.Selected or ATab.IsMainTab) then
    begin
      InternalDrawEdge(FullRect, True);
      InflateRect(FullRect, -StandardPainterTabBorderWidth, -StandardPainterTabBorderWidth);
    end
    else if ATab.HotTrack or ATab.Tracking then
    begin
      InternalPolyLine([Point(Left, Bottom - 2), Point(Left, Top), Point(Right - 2, Top)], cxPCLightestEdgeColor);
      InternalPolyLine([Point(Left, Bottom - 1), Point(Right - 1, Bottom - 1), Point(Right - 1, Top)], cxPCDarkEdgeColor);
      InflateRect(FullRect, -1, -1);
    end;

    Brush.Color := TabBodyColor;
    FillRect(FullRect);

    InflateRect(FullRect, 1, 1);
    InternalDrawFocusRect(ATabVisibleIndex, FullRect);
  end;
end;

{ TcxPCStandardPainter }

procedure TcxPCStandardPainter.CalculateButtonContentParameters(
  AButton: TcxPCNavigatorButton; out AParameters: TcxPCNavigatorButtonContentParameters);
var
  AButtonState: TcxPCNavigatorButtonState;
begin
  AButtonState := ParentInfo.NavigatorButtonsState[AButton];
  AParameters.BrushColor := GetButtonContentColor(AButtonState);
  AParameters.Color := AParameters.BrushColor;
  AParameters.Enabled := ParentControl.Enabled and (AButtonState <> nbsDisabled);
  AParameters.LiteStyle := False;
end;

procedure TcxPCStandardPainter.CalculateButtonsRect(NavigatorButtons: TcxPCNavigatorButtons);
var
  AButtonHeight, AButtonsWidth: Integer;
begin
  AButtonHeight := GetButtonHeight;
  AButtonsWidth := GetButtonsWidth(NavigatorButtons);
  with FButtonsRect do
    if ParentInfo.TabPosition in [tpTop, tpBottom] then
    begin
      if ParentInfo.NavigatorPosition in [npLeftTop, npLeftBottom] then
        Left := GetButtonsRegionWOffset
      else
        Left := ParentInfo.Width - AButtonsWidth - GetButtonsRegionWOffset;
      if ParentInfo.TabPosition = tpTop then
        Top := GetButtonsRegionHOffset
      else
        Top := ParentInfo.Height - AButtonHeight - GetButtonsRegionHOffset;
      Right := Left + AButtonsWidth;
      Bottom := Top + AButtonHeight;
    end
    else
    begin
      if ParentInfo.TabPosition = tpLeft then
        Left := GetButtonsRegionHOffset
      else
        Left := ParentInfo.Width - AButtonHeight - GetButtonsRegionHOffset;
      if ParentInfo.NavigatorPosition in [npLeftTop, npRightTop] then
        Top := GetButtonsRegionWOffset
      else
        Top := ParentInfo.Height - AButtonsWidth - GetButtonsRegionWOffset;
      Right := Left + AButtonHeight;
      Bottom := Top + AButtonsWidth;
    end;
end;

procedure TcxPCStandardPainter.CalculateButtonsRegion(NavigatorButtons: TcxPCNavigatorButtons);
var
  ButtonLeftTopCorner: TPoint;
  IsY: Boolean;
  ButtonIndex: Integer;
  Button: TcxPCNavigatorButton;
begin
  if NavigatorButtons = [] then
  begin
    SetLength(FButtonsQueue, 0);
    Exit;
  end;
  CalculateButtonsRect(NavigatorButtons);
  GetButtonsOrder(NavigatorButtons, FButtonsQueue);
  ButtonLeftTopCorner := FButtonsRect.TopLeft;
  IsY := ParentInfo.TabPosition in [tpLeft, tpRight];
  for ButtonIndex := 0 to High(FButtonsQueue) do
  begin
    Button := FButtonsQueue[ButtonIndex].Button;
      with ButtonLeftTopCorner, FButtonsQueue[ButtonIndex].ButtonRect do
      begin
        TopLeft := ButtonLeftTopCorner;
        if IsY then
        begin
          Bottom := Top + GetButtonWidth(Button);
          Right := Left + GetButtonHeight;
          if ButtonIndex < High(FButtonsQueue) then
            Y := Bottom + GetButtonsDistance(Button, FButtonsQueue[ButtonIndex + 1].Button);
        end else
        begin
          Right := Left + GetButtonWidth(Button);
          Bottom := Top + GetButtonHeight;
          if ButtonIndex < High(FButtonsQueue) then
            X := Right + GetButtonsDistance(Button, FButtonsQueue[ButtonIndex + 1].Button);
        end;
      end;
  end;
end;

function TcxPCStandardPainter.CalculateButtonsRegionWidth(
  NavigatorButtons: TcxPCNavigatorButtons): Integer;
begin
  Result := GetButtonsWidth(NavigatorButtons);
  if Result > 0 then
  begin
    Inc(Result, GetButtonsRegionWOffset);
    Inc(Result, GetButtonsRegionFromTabsOffset);
  end;
end;

procedure TcxPCStandardPainter.CorrectTabHeightForImage(var AHeight: Integer);
var
  ATabImageHeight: Integer;
begin
  ATabImageHeight := GetTabBaseImageSize.cy;
  if ParentInfo.Rotate and (ATabImageHeight > 0) and Odd(AHeight - ATabImageHeight) then
    Inc(AHeight);
end;

function TcxPCStandardPainter.CalculateTabNormalWidth(Tab: TcxTab): Integer;
begin
  with ParentInfo do
    if TabWidth > 0 then
      Result := TabWidth
    else
    begin
      Result := GetTabNormalWidth(Tab.VisibleIndex);
      if Tab.Caption <> '' then
        Inc(Result, TextSize(Tab, Tab.Caption).cx);
      if Result < GetMinTabNormalWidth(Tab.VisibleIndex) then
        Result := GetMinTabNormalWidth(Tab.VisibleIndex);
    end;
end;

constructor TcxPCStandardPainter.Create(AParent: TcxCustomTabControl);
begin
  inherited Create(AParent);
  FButtonsQueue := nil;
end;

destructor TcxPCStandardPainter.Destroy;
begin
  FButtonsQueue := nil;
  inherited Destroy;
end;

function TcxPCStandardPainter.CalculateTabNormalHeight: Integer;
var
  DefaultTabNormalHeight: Integer;
begin
  with ParentInfo do
  begin
    Result := InternalCalculateTabNormalHeight;

    DefaultTabNormalHeight := GetDefaultTabNormalHeight;
    if Result < DefaultTabNormalHeight then
      Result := DefaultTabNormalHeight;

    CorrectTabHeightForImage(Result);

    if TabHeight > Result then
      Result := TabHeight;
  end;
end;

function TcxPCStandardPainter.GetGoDialogButtonBounds: TRect;
var
  AButtonIndex: Integer;
begin
  Result := cxEmptyRect;
  for AButtonIndex := 0 to High(FButtonsQueue) do
    with FButtonsQueue[AButtonIndex] do
      if Button = nbGoDialog then
      begin
        Result := ButtonRect;
        Break;
      end;
end;

function TcxPCStandardPainter.GetDefaultTabNormalHeight: Integer;
begin
  Result := StandardPainterDefaultTabNormalHeightA[GetStandardStyle];
end;

function TcxPCStandardPainter.GetDefaultTabNormalHTextOffset: Integer;
begin
  Result := StandardPainterDefaultTabNormalHTextOffsetA[GetStandardStyle];
end;

function TcxPCStandardPainter.GetDefaultTabNormalWidth: Integer;
begin
  Result := 42;
end;

function TcxPCStandardPainter.GetFrameRect: TRect;
var
  AMinFrameRectSize: Integer;
begin
  AMinFrameRectSize := GetMinFrameRectSize;
  Result := GetDisplayRect;
  if cxRectWidth(Result) < AMinFrameRectSize then
    Result.Right := Result.Left + AMinFrameRectSize;
  if cxRectHeight(Result) < AMinFrameRectSize then
    Result.Bottom := Result.Top + AMinFrameRectSize;
end;

function TcxPCStandardPainter.GetFreeSpaceColor: TColor;
begin
  Result := ParentInfo.Color;
end;

function TcxPCStandardPainter.GetMinFrameRectSize: Integer;
begin
  Result := GetFrameWidth * 2;
end;

function TcxPCStandardPainter.GetTabContentWOffset(ATabVisibleIndex: Integer): TcxPCWOffset;
begin
  Result := StandardPainterTabContentWOffsetA[IsTabBorderThick(ATabVisibleIndex),
    GetStandardStyle];
end;

function TcxPCStandardPainter.GetDrawImageOffset(TabVisibleIndex: Integer): TRect;
begin
  Result := StandardPainterDrawImageOffsetA[IsTabBorderThick(TabVisibleIndex),
    GetStandardStyle];
end;

function TcxPCStandardPainter.GetDrawImageWithoutTextWOffset(
  TabVisibleIndex: Integer): TcxPCWOffset;
begin
  Result := cxPCEmptyWOffset;
end;

function TcxPCStandardPainter.GetDrawTextHOffset(TabVisibleIndex: Integer): TRect;
begin
  Result := StandardPainterDrawTextHOffsetA[IsTabBorderThick(TabVisibleIndex),
    GetStandardStyle];
end;

function TcxPCStandardPainter.GetFrameWidth: Integer;
begin
  Result := StandardPainterTabControlFrameBorderWidth;
end;

function TcxPCStandardPainter.GetGoDialogPosition(GoDialogSize: TSize): TPoint;
const
  GoDialogPositionA: array[TcxTabPosition, TcxPCNavigatorPosition] of TcxPCNavigatorPosition = (
    (npLeftTop, npLeftTop, npRightTop, npRightTop),
    (npLeftBottom, npLeftBottom, npRightBottom, npRightBottom),
    (npLeftTop, npLeftBottom, npLeftTop, npLeftBottom),
    (npRightTop, npRightBottom, npRightTop, npRightBottom)
  );
var
  ButtonIndex: Integer;
  GoDialogPosition: TcxPCNavigatorPosition;
begin
  for ButtonIndex := 0 to High(FButtonsQueue) do
    with ParentInfo, FButtonsQueue[ButtonIndex] do
      if Button = nbGoDialog then
      begin
        GoDialogPosition := GoDialogPositionA[TabPosition, NavigatorPosition];
        if GoDialogPosition in [npLeftTop, npLeftBottom] then
          Result.X := ButtonRect.Left
        else
          Result.X := ButtonRect.Right - GoDialogSize.cx;
        if GoDialogPosition in [npLeftTop, npRightTop] then
          Result.Y := ButtonRect.Bottom
        else
          Result.Y := ButtonRect.Top - GoDialogSize.cy;
        Exit;
      end;
end;

function TcxPCStandardPainter.GetImageTextDistance(ATabVisibleIndex: Integer): Integer;
//var
//  ACorrection: Integer;
//  ATabContentWOffset: TcxPCWOffset;
begin
  Result := 6;
//  if ParentInfo.Rotate and (ParentInfo.VisibleTabs[ATabVisibleIndex].Caption <> '') then
//  begin
//    ATabContentWOffset := ButtonsPainterTabContentWOffsetA[GetTabBaseImageSize.cx > 0];
//    ACorrection := 12 - ATabContentWOffset.Left - ATabContentWOffset.Right;
//    Inc(Result, ACorrection - ACorrection div 2);
//  end;
end;

function TcxPCStandardPainter.GetMinTabNormalWidth(ATabVisibleIndex: Integer): Integer;
begin
  Result := GetTabNormalWidth(ATabVisibleIndex);
  if Result < GetDefaultTabNormalWidth then
    Result := GetDefaultTabNormalWidth;
end;

function TcxPCStandardPainter.GetMinTabSelectionDistance: TcxPCDistance;
begin
  Result := MinTabSelectionDistance;
end;

function TcxPCStandardPainter.GetTabsNormalDistance: TcxPCDistance;
begin
  Result := StandardPainterTabsNormalDistanceA[GetStandardStyle];
end;

function TcxPCStandardPainter.GetTabBorderWidth(Tab: TcxTab): Integer;
begin
  Result := StandardPainterMaxTabBorderWidth;
end;

function TcxPCStandardPainter.GetTabNormalWidth(ATabVisibleIndex: Integer): Integer;
begin
  if IsAssignedImages and ((ATabVisibleIndex = -1) or IsTabHasImage(ATabVisibleIndex) or ParentInfo.Rotate) then
    Result := GetTabBaseImageSize.cx + 2 * ParentInfo.ImageBorder + 6
  else
    Result := 0;
  Inc(Result, 12);
end;

function TcxPCStandardPainter.GetTabsRectOffset: TRect;
begin
  Result := cxEmptyRect;
end;

function TcxPCStandardPainter.GetTabsPosition(
  NavigatorButtons: TcxPCNavigatorButtons): TcxPCTabsPosition;
var
  AButtonsWidth: Integer;
  ATabsContainerOffset: TRect;
begin
  AButtonsWidth := CalculateButtonsRegionWidth(NavigatorButtons);
  ATabsContainerOffset := cxEmptyRect;
  if ParentInfo.IsTabsContainer then
    ATabsContainerOffset := GetTabsContainerOffsets;

  with ParentInfo, Result do
  begin
    Result.ExtendedTabsRect := GetControlRect(ParentControl);
    ExtendRect(ExtendedTabsRect, GetTabsRectOffset);

    if NavigatorButtons <> [] then
    begin
      ExtendRect(ExtendedTabsRect, RotateRect(Rect(0, ATabsContainerOffset.Top, 0, 0), ParentInfo.TabPosition));
      ATabsContainerOffset := RotateRect(ATabsContainerOffset, ParentInfo.TabPosition);
      if TabPosition in [tpTop, tpBottom] then
      begin
        if NavigatorPosition in [npLeftTop, npLeftBottom] then
        begin
          Inc(ExtendedTabsRect.Left, AButtonsWidth);
          Dec(ExtendedTabsRect.Right, ATabsContainerOffset.Right);
        end
        else
        begin
          Dec(ExtendedTabsRect.Right, AButtonsWidth);
          Inc(ExtendedTabsRect.Left, ATabsContainerOffset.Left);
        end;
      end
      else
      begin
        if NavigatorPosition in [npLeftTop, npRightTop] then
        begin
          Inc(ExtendedTabsRect.Top, AButtonsWidth);
          Dec(ExtendedTabsRect.Bottom, ATabsContainerOffset.Bottom);
        end
        else
        begin
          Dec(ExtendedTabsRect.Bottom, AButtonsWidth);
          Inc(ExtendedTabsRect.Top, ATabsContainerOffset.Top);
        end;
      end;
    end
    else
      ExtendRect(ExtendedTabsRect, RotateRect(ATabsContainerOffset, ParentInfo.TabPosition));
    if TabPosition in [tpTop, tpBottom] then
      NormalRowWidth := (ExtendedTabsRect.Right - ExtendedTabsRect.Left)
    else
      NormalRowWidth := (ExtendedTabsRect.Bottom - ExtendedTabsRect.Top);

    NormalTabsRect := ExtendedTabsRect;

    ExtendedTopOrLeftTabsRectBottomOrRightBorderOffset := 0;
    ExtendedBottomOrRightTabsRectTopOrLeftBorderOffset := 0;

    MinDistanceBetweenTopOrLeftAndBottomOrRightExtendedTabsRects :=
      GetTabsNormalDistance.dh;
  end;

  CalculateButtonsRegion(NavigatorButtons);
end;

function TcxPCStandardPainter.GetTooNarrowTabContentWOffset(ATabVisibleIndex: Integer): TcxPCWOffset;
begin
  Result := StandardPainterTooNarrowTabContentWOffsetA[
    IsTabBorderThick(ATabVisibleIndex), GetStandardStyle];
end;

procedure TcxPCStandardPainter.InternalPrepareOutTabImageAndTextData(
  ATabVisibleIndex: Integer; var AImageRect, ATextRect: TRect);
begin
  FOutTabImageAndTextData.TabImageRect := AImageRect;
  FOutTabImageAndTextData.TabTextRect := ATextRect;
end;

function TcxPCStandardPainter.InternalCalculateTabNormalHeight: Integer;
begin
  if IsAssignedImages then
    Result := GetTabBaseImageSize.cy + 2 * ParentInfo.ImageBorder + 6
  else
    Result := 0;
  if Result < GetMaxTabCaptionHeight + 8 then
    Result := GetMaxTabCaptionHeight + 8;
end;

procedure TcxPCStandardPainter.InternalDrawEdge(const Rect: TRect;
  Sunken: Boolean; ThinFrame: Boolean = False);
const
  ThickFrameLineColorA: array [Boolean, 1 .. 4] of TColor = (
    (cxPCLightEdgeColor, cxPCLightestEdgeColor, cxPCDarkestEdgeColor, cxPCDarkEdgeColor),
    (cxPCDarkEdgeColor, cxPCDarkestEdgeColor, cxPCLightestEdgeColor, cxPCLightEdgeColor)
  );
  ThinFrameLineColorA: array [Boolean, 1 .. 2] of TColor = (
    (cxPCLightEdgeColor, cxPCDarkestEdgeColor),
    (cxPCDarkestEdgeColor, cxPCLightEdgeColor)
  );
begin
  with Rect do
    if ThinFrame then
    begin
      InternalPolyLine([Point(Left, Bottom - 2), Point(Left, Top), Point(Right - 2, Top)], ThinFrameLineColorA[Sunken, 1]);
      InternalPolyLine([Point(Left, Bottom - 1), Point(Right - 1, Bottom - 1), Point(Right - 1, Top)], ThinFrameLineColorA[Sunken, 2]);
    end else
    begin
      InternalPolyLine([Point(Left, Bottom - 2), Point(Left, Top), Point(Right - 2, Top)], ThickFrameLineColorA[Sunken, 1]);
      InternalPolyLine([Point(Left + 1, Bottom - 3), Point(Left + 1, Top + 1), Point(Right - 3, Top + 1)], ThickFrameLineColorA[Sunken, 2]);
      InternalPolyLine([Point(Left, Bottom - 1), Point(Right - 1, Bottom - 1), Point(Right - 1, Top)], ThickFrameLineColorA[Sunken, 3]);
      InternalPolyLine([Point(Left + 1, Bottom - 2), Point(Right - 2, Bottom - 2), Point(Right - 2, Top + 1)], ThickFrameLineColorA[Sunken, 4]);
    end;
end;

procedure TcxPCStandardPainter.InternalDrawFocusRect(TabVisibleIndex: Integer; R: TRect);
var
  ATab: TcxTab;
begin
  ATab := ParentInfo.VisibleTabs[TabVisibleIndex];
  if ATab.RealEnabled and ATab.IsMainTab and ParentControl.Focused then
    if InternalSetClipRect(ATab.VisibleRect, False) then
    begin
      with ParentInfo.Canvas do
      begin
        InflateRect(R, -1, -1);
        Pen.Color := ParentInfo.Font.Color; // DrawTabEx
        DrawFocusRect(R);
      end;
      InternalResetClipRegion;
    end;
end;

procedure TcxPCStandardPainter.PaintButton(Button: TcxPCNavigatorButton;
  const ButtonRect: TRect);
var
  AButtonState: TcxPCNavigatorButtonState;
  AContentLeftTopCorner: TPoint;
  AContentParameters: TcxPCNavigatorButtonContentParameters;
  R: TRect;
begin
  AButtonState := ParentInfo.NavigatorButtonsState[Button];
  R := ButtonRect;
  PaintButtonFrame(R, AButtonState);
  PaintButtonBackground(R, AButtonState);

  CalculateButtonContentParameters(Button, AContentParameters);
  AContentLeftTopCorner := GetButtonContentPosition(Button);
  with ButtonRect.TopLeft do
  begin
    Inc(AContentLeftTopCorner.X, X);
    Inc(AContentLeftTopCorner.Y, Y);
  end;

  DrawButtonContent(Button, AContentParameters, AContentLeftTopCorner);
end;

procedure TcxPCStandardPainter.PaintButtonBackground(AButtonRect: TRect;
  AButtonState: TcxPCNavigatorButtonState);
begin
  ParentInfo.Canvas.Brush.Color := GetButtonColor(AButtonState);
  ParentInfo.Canvas.FillRect(AButtonRect);
end;

procedure TcxPCStandardPainter.PaintButtonFrame(var ARect: TRect;
  AButtonState: TcxPCNavigatorButtonState);
begin
  InternalDrawEdge(ARect, AButtonState = nbsPressed);
  InflateRect(ARect, -2, -2);
end;

procedure TcxPCStandardPainter.PaintFrame;
begin
  PaintFrameBorder(GetFrameRect);
end;

procedure TcxPCStandardPainter.PaintFrameBorder(R: TRect);
begin
  ParentInfo.Canvas.DrawComplexFrame(R, cxPCLightestEdgeColor, cxPCDarkestEdgeColor);
  InflateRect(R, -1, -1);
  ParentInfo.Canvas.DrawComplexFrame(R, cxPCLightEdgeColor, cxPCDarkEdgeColor);
end;

procedure TcxPCStandardPainter.PrepareTabBackground(ATab: TcxTab; ATabVisibleIndex: Integer);
begin
end;

class function TcxPCStandardPainter.IsMainTabBoundWithClient: boolean;
const
  IsMainTabBoundWithClientA: array [TcxPCStandardStyle] of boolean = (True, False, False);
begin
  Result := IsMainTabBoundWithClientA[GetStandardStyle];
end;

class function TcxPCStandardPainter.IsMultiSelectionAccepted: boolean;
const
  IsMultiSelectionAcceptedA: array [TcxPCStandardStyle] of boolean = (False, True, True);
begin
  Result := IsMultiSelectionAcceptedA[GetStandardStyle];
end;

class function TcxPCStandardPainter.IsStandardStyle: Boolean;
begin
  Result := True;
end;

function TcxPCStandardPainter.IsOverButton(X, Y: Integer;
  var Button: TcxPCNavigatorButton): Boolean;
var
  ButtonIndex: Integer;
begin
  Result := False;
  for ButtonIndex := 0 to High(FButtonsQueue) do
  begin
    Result := PtInRect(FButtonsQueue[ButtonIndex].ButtonRect, Point(X, Y));
    if Result then
    begin
      Button := FButtonsQueue[ButtonIndex].Button;
      Break;
    end;
  end;
end;

function TcxPCStandardPainter.IsTabBorderThick(ATabVisibleIndex: Integer): Boolean;
begin
  Result := ParentInfo.VisibleTabs[ATabVisibleIndex].IsMainTab;
end;

class function TcxPCStandardPainter.IsTabPressable: Boolean;
const
  IsTabPressableA: array [TcxPCStandardStyle] of boolean = (False, True,
    True);
begin
  Result := IsTabPressableA[GetStandardStyle];
end;

procedure TcxPCStandardPainter.Paint;
var
  R: TRect;
begin
  inherited Paint;
  R := GetControlRect(ParentControl);
  if IsNativePainting and ParentControl.ParentBackground then
    cxDrawTransparentControlBackground(ParentControl, ParentInfo.Canvas, R, False)
  else
    with ParentInfo.Canvas do
    begin
      Brush.Color := GetFreeSpaceColor;
      Brush.Style := bsSolid;
      FillRect(R);
    end;
end;

procedure TcxPCStandardPainter.PaintButtonsRegion;
var
  AButtonIndex: Integer;
begin
  if ParentInfo.NavigatorButtons = [] then
    Exit;
  for AButtonIndex := 0 to High(FButtonsQueue) do
    with FButtonsQueue[AButtonIndex] do
      if InternalSetClipRect(ButtonRect) then
      begin
        PaintButton(Button, ButtonRect);
        InternalResetClipRegion;
        ParentInfo.Canvas.ExcludeClipRect(ButtonRect);
      end;
end;

procedure TcxPCStandardPainter.PaintTabsRegion;
var
  I: Integer;
  FirstIndex, LastIndex: Integer;
begin
  InitializeVisibleTabRange(ParentControl, FirstIndex, LastIndex);
  for I := FirstIndex to LastIndex do
    PaintTab(I);
end;

procedure TcxPCStandardPainter.RepaintButton(Button: TcxPCNavigatorButton;
  OldButtonState: TcxPCNavigatorButtonState);
var
  ButtonIndex: Integer;
begin
  for ButtonIndex := 0 to High(FButtonsQueue) do
    if FButtonsQueue[ButtonIndex].Button = Button then
      InternalInvalidateRect(FButtonsQueue[ButtonIndex].ButtonRect);
end;

procedure TcxPCStandardPainter.RepaintButtonsRegion;
begin
  if ParentInfo.NavigatorButtons = [] then Exit;
  InternalInvalidateRect(FButtonsRect);
end;

procedure TcxPCStandardPainter.RepaintTab(TabVisibleIndex: Integer;
  TabPropertyChanged: TcxPCTabPropertyChanged);
begin
  if IsVerticalText(ParentControl) then
    ParentInfo.VisibleTabs[TabVisibleIndex].ResetVerticalTextBitmap;
  InvalidateTabRect(TabVisibleIndex);
end;

procedure TcxPCStandardPainter.GetButtonsOrder(ANavigatorButtons: TcxPCNavigatorButtons;
  var AButtonPositions: TcxPCNavigatorButtonPositions);
type
  TcxPCNavigatorButtonA = array of TcxPCNavigatorButton;

  procedure InternalGetButtonsOrder(out AButtonsOrder: TcxPCNavigatorButtonA);
  var
    AInverseOrder, AIsY: Boolean;
  begin
    SetLength(AButtonsOrder, Integer(High(TcxPCNavigatorButton)) -
      Integer(Low(TcxPCNavigatorButton)) + 1);
    AIsY := ParentInfo.TabPosition in [tpLeft, tpRight];
    AInverseOrder := (AIsY and (ParentInfo.NavigatorPosition in [npLeftTop, npRightTop])) or
      (not AIsY and (ParentInfo.NavigatorPosition in [npLeftTop, npLeftBottom]));
    if not AInverseOrder then
    begin
      AButtonsOrder[0] := nbGoDialog;
      AButtonsOrder[1] := nbTopLeft;
      AButtonsOrder[2] := nbBottomRight;
      AButtonsOrder[3] := nbClose;
    end
    else
    begin
      AButtonsOrder[0] := nbClose;
      AButtonsOrder[1] := nbTopLeft;
      AButtonsOrder[2] := nbBottomRight;
      AButtonsOrder[3] := nbGoDialog;
    end;
  end;

var
  AButtonPosition, I: Integer;
  AButtonsOrder: TcxPCNavigatorButtonA;
begin
  SetLength(AButtonPositions, GetButtonCount(ANavigatorButtons));
  InternalGetButtonsOrder(AButtonsOrder);
  AButtonPosition := 0;
  for I := 0 to High(AButtonsOrder) do
    if AButtonsOrder[I] in ANavigatorButtons then
    begin
      AButtonPositions[AButtonPosition].Button := AButtonsOrder[I];
      Inc(AButtonPosition);
    end;
end;

function TcxPCStandardPainter.GetButtonHeight: Integer;
begin
  Result := StandardPainterButtonHeight;
end;

function TcxPCStandardPainter.GetButtonWidth(
  Button: TcxPCNavigatorButton): Integer;
var
  IsY: Boolean;
begin
  IsY := ParentInfo.TabPosition in [tpLeft, tpRight];
  Result := StandardPainterButtonWidthA[IsY, Button];
end;

procedure TcxPCStandardPainter.DrawButtonContent(AButton: TcxPCNavigatorButton;
  const AParameters: TcxPCNavigatorButtonContentParameters;
  AContentRectLeftTopCorner: TPoint);
type
  TArrowPointA = array [0 .. 2] of TPoint;

  procedure InternalDrawArrow(Points: TArrowPointA; LeftTopCorner: TPoint);
  var
    I: Integer;
  begin
    for I := 0 to 2 do
      with Points[I] do
      begin
        Inc(X, LeftTopCorner.X);
        Inc(Y, LeftTopCorner.Y);
      end;
    ParentInfo.Canvas.Polygon(Points);
  end;

  procedure DrawArrow(const ALeftTopCorner: TPoint);
  const
    PolygonPointsMultipliersA: array[TcxPCArrow] of TArrowPointA = (
      ((X: 0; Y: 1), (X: 1; Y: 0), (X: 2; Y: 1)),
      ((X: 0; Y: 0), (X: 2; Y: 0), (X: 1; Y: 1)),
      ((X: 0; Y: 1), (X: 1; Y: 0), (X: 1; Y: 2)),
      ((X: 0; Y: 0), (X: 1; Y: 1), (X: 0; Y: 2))
    );
  var
    PolygonPoints: TArrowPointA;
    ArrowUnit: Integer;
    I: Integer;
  begin
    ArrowUnit := cxPCArrowSizeA[AButton] - 1;
    PolygonPoints := PolygonPointsMultipliersA[GetButtonArrow(AButton)];
    for I := 0 to 2 do
      with PolygonPoints[I] do
      begin
        X := X * ArrowUnit;
        Y := Y * ArrowUnit;
      end;
    InternalDrawArrow(PolygonPoints, ALeftTopCorner);
  end;

  procedure DrawCross(const ALeftTopCorner: TPoint);
  begin
    with ALeftTopCorner do
      if AParameters.LiteStyle then
        if ParentInfo.TabPosition in [tpTop, tpBottom] then
        begin
          InternalPolyLine([Point(X + 1, Y), Point(X + CloseButtonCrossSize - 2, Y + CloseButtonCrossSize - 3)], ParentInfo.Canvas.Pen.Color);
          InternalPolyLine([Point(X, Y), Point(X + CloseButtonCrossSize - 3, Y + CloseButtonCrossSize - 3)], ParentInfo.Canvas.Pen.Color);

          InternalPolyLine([Point(X, Y + CloseButtonCrossSize - 3), Point(X + CloseButtonCrossSize - 3, Y)], ParentInfo.Canvas.Pen.Color);
          InternalPolyLine([Point(X + 1, Y + CloseButtonCrossSize - 3), Point(X + CloseButtonCrossSize - 2, Y)], ParentInfo.Canvas.Pen.Color);
        end
        else
        begin
          InternalPolyLine([Point(X, Y), Point(X + CloseButtonCrossSize - 3, Y + CloseButtonCrossSize - 3)], ParentInfo.Canvas.Pen.Color);
          InternalPolyLine([Point(X, Y + 1), Point(X + CloseButtonCrossSize - 3, Y + CloseButtonCrossSize - 2)], ParentInfo.Canvas.Pen.Color);

          InternalPolyLine([Point(X, Y + CloseButtonCrossSize - 3), Point(X + CloseButtonCrossSize - 3, Y)], ParentInfo.Canvas.Pen.Color);
          InternalPolyLine([Point(X, Y + CloseButtonCrossSize - 2), Point(X + CloseButtonCrossSize - 3, Y + 1)], ParentInfo.Canvas.Pen.Color);
        end
      else
      begin
        InternalPolyLine([Point(X + 1, Y), Point(X + CloseButtonCrossSize - 1, Y + CloseButtonCrossSize - 2)], ParentInfo.Canvas.Pen.Color);
        InternalPolyLine([Point(X, Y), Point(X + CloseButtonCrossSize - 1, Y + CloseButtonCrossSize - 1)], ParentInfo.Canvas.Pen.Color);
        InternalPolyLine([Point(X, Y + 1), Point(X + CloseButtonCrossSize - 2, Y + CloseButtonCrossSize - 1)], ParentInfo.Canvas.Pen.Color);

        InternalPolyLine([Point(X, Y + CloseButtonCrossSize - 2), Point(X + CloseButtonCrossSize - 2, Y)], ParentInfo.Canvas.Pen.Color);
        InternalPolyLine([Point(X, Y + CloseButtonCrossSize - 1), Point(X + CloseButtonCrossSize - 1, Y)], ParentInfo.Canvas.Pen.Color);
        InternalPolyLine([Point(X + 1, Y + CloseButtonCrossSize - 1), Point(X + CloseButtonCrossSize - 1, Y + 1)], ParentInfo.Canvas.Pen.Color);
      end;
  end;

  procedure InternalDrawContent(const ALeftTopCorner: TPoint);
  begin
    if AButton = nbClose then
      DrawCross(ALeftTopCorner)
    else
      DrawArrow(ALeftTopCorner);
  end;

begin
  with ParentInfo.Canvas do
  begin
    if not AParameters.Enabled then
    begin
      Brush.Color := DisabledTextFaceColor;
      Pen.Color := DisabledTextFaceColor;
      with AContentRectLeftTopCorner do
        InternalDrawContent(Point(X + 1, Y + 1));
      Brush.Color := DisabledTextShadowColor;
      Pen.Color := DisabledTextShadowColor;
    end else
    begin
      Brush.Color := AParameters.BrushColor;
      Pen.Color := AParameters.Color;
    end;
    InternalDrawContent(AContentRectLeftTopCorner);
  end;
  ParentInfo.Canvas.Brush.Style := bsSolid;
end;

function TcxPCStandardPainter.Get3DButtonContentPosition(
  AButton: TcxPCNavigatorButton): TPoint;
const
  AArrowButtonArrowRectLeftTopCorners: array [TcxPCArrow] of TPoint = (
    (X: 5; Y: 7), (X: 5; Y: 7), (X: 6; Y: 5), (X: 8; Y: 5)
  );
  ACloseButtonCrossRectLeftTopCorner: TPoint = (X: 5; Y: 5);
  AGoDialogArrowRectLeftTopCorners: array [Boolean] of TPoint = (
    (X: 2; Y: 8), // TabPosition in [tpTop, tpBottom]
    (X: 6; Y: 4)
  );
begin
  case AButton of
    nbGoDialog:
      Result := AGoDialogArrowRectLeftTopCorners[ParentInfo.TabPosition in [tpLeft, tpRight]];
    nbClose:
      Result := ACloseButtonCrossRectLeftTopCorner;
  else
    Result := AArrowButtonArrowRectLeftTopCorners[GetButtonArrow(AButton)];
  end;
  if ParentInfo.NavigatorButtonsState[AButton] = nbsPressed then
  begin
    Inc(Result.X);
    Inc(Result.Y);
  end;
end;

function TcxPCStandardPainter.GetButtonArrow(AButton: TcxPCNavigatorButton): TcxPCArrow;
var
  AIsY: Boolean;
begin
  AIsY := ParentInfo.TabPosition in [tpLeft, tpRight];
  if AButton = nbGoDialog then
    Result := aBottom
  else
    Result := cxPCArrowConvertionA[AButton, AIsY];
end;

function TcxPCStandardPainter.GetButtonCenteredContentPosition(
  AButton: TcxPCNavigatorButton): TPoint;

  procedure RotateSize(var ASize: TSize);
  begin
    ASize := Size(ASize.cy, ASize.cx);
  end;

  function GetContentSize: TSize;
  var
    AArrowSize: Integer;
  begin
    if AButton = nbClose then
    begin
      Result := Size(CloseButtonCrossSize - 1, CloseButtonCrossSize - 2);
      if ParentInfo.TabPosition in [tpLeft, tpRight] then
        RotateSize(Result);
    end
    else
    begin
      AArrowSize := cxPCArrowSizeA[AButton];
      Result := Size(AArrowSize, AArrowSize * 2 - 1);
      if (AButton = nbGoDialog) or (AButton in [nbTopLeft, nbBottomRight]) and
        (ParentInfo.TabPosition in [tpLeft, tpRight]) then
          RotateSize(Result);
    end;
  end;

var
  AButtonSize, AContentSize: TSize;
begin
  AContentSize := GetContentSize;

  AButtonSize := Size(GetButtonWidth(AButton), GetButtonHeight);
  if ParentInfo.TabPosition in [tpLeft, tpRight] then
    RotateSize(AButtonSize);

  Result.X := (AButtonSize.cx - AContentSize.cx) div 2;
  Result.Y := (AButtonSize.cy - AContentSize.cy) div 2;
  if AButton = nbGoDialog then
    Inc(Result.Y);
  if ParentInfo.NavigatorButtonsState[AButton] = nbsPressed then
  begin
    if AButton <> nbGoDialog then
      Inc(Result.X);
    Inc(Result.Y);
  end;
end;

function TcxPCStandardPainter.GetButtonColor(
  AButtonState: TcxPCNavigatorButtonState): TColor;
begin
  Result := cxPCTabBodyColor;
end;

function TcxPCStandardPainter.GetButtonContentColor(
  AButtonState: TcxPCNavigatorButtonState): TColor;
begin
  if AButtonState = nbsHotTrack then
    Result := GetHotTrackColor
  else
    Result := clBtnText;
end;

function TcxPCStandardPainter.GetButtonContentPosition(
  AButton: TcxPCNavigatorButton): TPoint;
begin
  Result := GetButtonCenteredContentPosition(AButton);
end;

procedure TcxPCStandardPainter.PaintTab(TabVisibleIndex: Integer);
var
  AIsCustomDraw: Boolean;
  ARegion: TcxRegion;
  ARgnOperation: TcxRegionOperation;
  ATab: TcxTab;
begin
  ARegion := GetTabClipRgn(TabVisibleIndex);
  ARgnOperation := GetTabClipRgnOperation(TabVisibleIndex);
  try
    SaveClipRgn;
    try
      ParentInfo.Canvas.SetClipRegion(ARegion, ARgnOperation, False);
      AIsCustomDraw := IsCustomDraw and DoCustomDraw(TabVisibleIndex);
      if not AIsCustomDraw then
      begin
        ATab := ParentInfo.VisibleTabs[TabVisibleIndex];
        ATab.InitializePaintBitmap;
        try
          if IsNativePainting then
            PrepareTabBackground(ATab, TabVisibleIndex);
          DrawTabImageAndText(ATab, TabVisibleIndex);
          PaintTabShape(ATab, TabVisibleIndex);
        finally
          ATab.ResetPaintBitmap;
        end;
      end;
    finally
      RestoreClipRgn;
    end;
    if not IsTabTransparent(TabVisibleIndex) or AIsCustomDraw then
    begin
      AfterPaintTab(TabVisibleIndex);
      ParentInfo.Canvas.SetClipRegion(ARegion, roSubtract, False);
    end
    else
      ExcludeTabContentClipRegion(TabVisibleIndex);
  finally
    ARegion.Free;
  end;
end;

function TcxPCStandardPainter.GetButtonsWidth(ANavigatorButtons: TcxPCNavigatorButtons): Integer;
var
  AButton: TcxPCNavigatorButton;
  AButtonPositions: TcxPCNavigatorButtonPositions;
  I: Integer;
begin
  GetButtonsOrder(ANavigatorButtons, AButtonPositions);
  Result := 0;
  for I := 0 to High(AButtonPositions) do
  begin
    AButton := AButtonPositions[I].Button;
    Inc(Result, GetButtonWidth(AButton));
    if I < High(AButtonPositions) then
      Inc(Result, GetButtonsDistance(AButton, AButtonPositions[I + 1].Button));
  end;
end;

{ TcxPCButtonsPainter }

class function TcxPCButtonsPainter.GetStandardStyle: TcxPCStandardStyle;
begin
  Result := tsButtons;
end;

class function TcxPCButtonsPainter.GetStyleID: TcxPCStyleID;
begin
  Result := cxPCButtonsStyle;
end;

class function TcxPCButtonsPainter.GetStyleName: TCaption;
begin
  Result := 'Buttons';
end;

class function TcxPCButtonsPainter.HasLookAndFeel(
  ALookAndFeel: TcxLookAndFeel): Boolean;
begin
  Result := False;
end;

function TcxPCButtonsPainter.IsTabBorderThick(ATabVisibleIndex: Integer): Boolean;
begin
  with ParentInfo.VisibleTabs[ATabVisibleIndex] do
    Result := Tracking or Pressed or Selected or IsMainTab;
end;

procedure TcxPCButtonsPainter.PaintTabShape(ATab: TcxTab; ATabVisibleIndex: Integer);
const
  ATabFrameLineColorA: array [Boolean, 1 .. 4] of TColor = (
    (cxPCLightestEdgeColor, cxPCDarkestEdgeColor, cxPCLightestEdgeColor, cxPCDarkEdgeColor),
    (cxPCDarkEdgeColor, cxPCDarkestEdgeColor, cxPCLightestEdgeColor, cxPCLightEdgeColor)
  );
var
  R, AFullRect: TRect;
  ATabBodyColor: TColor;
  AIsSunkenTab: Boolean;
begin
  ATabBodyColor := GetTabBodyColor(ATabVisibleIndex);
  AFullRect := ATab.FullRect;
  R := AFullRect;
  with ParentInfo.Canvas do
  begin
    AIsSunkenTab := ATab.Pressed or ATab.Selected or ATab.IsMainTab or ATab.Tracking;
    if AIsSunkenTab then
    begin
      DrawComplexFrame(R, cxPCDarkestEdgeColor, cxPCLightestEdgeColor);
      InflateRect(R, -1, -1);
      DrawComplexFrame(R, cxPCDarkEdgeColor, cxPCLightEdgeColor);
    end else
    begin
      DrawComplexFrame(R, cxPCLightestEdgeColor, cxPCDarkestEdgeColor);
      InflateRect(R, -1, -1);
      DrawComplexFrame(R, cxPCLightEdgeColor, cxPCDarkEdgeColor);
    end;
    InflateRect(R, -1, -1);

    Brush.Color := ATabBodyColor;
    FillRect(R);

    InflateRect(R, 1, 1);
    InternalDrawFocusRect(ATabVisibleIndex, R);
  end;
end;

{ TcxPCButtonedPainter }

constructor TcxPCButtonedPainter.Create(AParent: TcxCustomTabControl);

  procedure InitializeMainTabBrushBitmap;
  const
    BrushBitmapSize = 8;
  var
    X, Y, XStart: Integer;
  begin
    with MainTabBrushBitmap, MainTabBrushBitmap.Canvas do
    begin
      Width := BrushBitmapSize;
      Height := BrushBitmapSize;

      Brush.Style := bsSolid;
      Brush.Color := cxPCLightEdgeColor;
      FillRect(Rect(0, 0, BrushBitmapSize, BrushBitmapSize));

      XStart := 0;
      X := XStart;
      Y := 0;
      repeat
        Pixels[X, Y] := cxPCLightestEdgeColor;
        Inc(X, 2);
        if X >= BrushBitmapSize then
        begin
          XStart := 1 - XStart;
          X := XStart;
          Inc(Y);
        end;
      until Y = BrushBitmapSize;
    end;
  end;

begin
  inherited Create(AParent);
  MainTabBrushBitmap := TBitmap.Create;
  InitializeMainTabBrushBitmap;
end;

destructor TcxPCButtonedPainter.Destroy;
begin
  MainTabBrushBitmap.Free;
  inherited Destroy;
end;

function TcxPCButtonedPainter.GetButtonContentPosition(
  AButton: TcxPCNavigatorButton): TPoint;
begin
  Result := Get3DButtonContentPosition(AButton);
end;

function TcxPCButtonedPainter.GetButtonsRegionHOffset: Integer;
begin
  if ParentInfo.IsTabsContainer then
    Result := TabsContainerOffset
  else
    Result := 0;
end;

function TcxPCButtonedPainter.GetButtonsRegionWOffset: Integer;
begin
  if ParentInfo.IsTabsContainer then
    Result := TabsContainerOffset
  else
    Result := 0;
end;

function TcxPCButtonedPainter.GetDisplayRectOffset: TRect;
begin
  Result := inherited GetDisplayRectOffset;
  if not ParentInfo.HideTabs and (ParentInfo.RowCount > 0) then
    Inc(Result.Top, ButtonedPainterDistanceBetweenTabsAndClientRects);
end;

function TcxPCButtonedPainter.GetTabBodyColor(
  TabVisibleIndex: Integer): TColor;
var
  ATab: TcxTab;
begin
  ATab := ParentInfo.VisibleTabs[TabVisibleIndex];
  if ATab.Highlighted then
    Result := HighlightedTabBodyColor
  else
  begin
    Result := GetTabColor(TabVisibleIndex);
    if Result = clDefault then
      if ATab.IsMainTab then
        Result := cxPCLightestEdgeColor
      else
        Result := clBtnFace;
  end;
end;

function TcxPCButtonedPainter.GetTabContentWOffset(ATabVisibleIndex: Integer): TcxPCWOffset;
//var
//  ACorrection: Integer;
begin
  Result := ButtonsPainterTabContentWOffsetA[IsAssignedImages];
//  if ParentInfo.Rotate and (ParentInfo.VisibleTabs[ATabVisibleIndex].Caption <> '') then
//  begin
//    ACorrection := (12 - Result.Left - Result.Right) div 2;
//    if GetTabBaseImageSize.cx = 0 then
//      Inc(Result.Left, ACorrection);
//    Inc(Result.Right, ACorrection);
//  end;
end;

function TcxPCButtonedPainter.GetTabsContainerOffsets: TRect;
begin
  Result := Rect(TabsContainerOffset, TabsContainerOffset, TabsContainerOffset, 0);
end;

function TcxPCButtonedPainter.GetTooNarrowTabContentWOffset(ATabVisibleIndex: Integer): TcxPCWOffset;
begin
  Result := GetTabContentWOffset(ATabVisibleIndex);
end;

function TcxPCButtonedPainter.IsTabBorderThick(ATabVisibleIndex: Integer): Boolean;
begin
  with ParentInfo.VisibleTabs[ATabVisibleIndex] do
    Result := not Tracking and (Pressed or Selected or IsMainTab);
end;

{ TcxPCExtraFlatPainter }

procedure TcxPCExtraFlatPainter.CalculateButtonContentParameters(
  AButton: TcxPCNavigatorButton; out AParameters: TcxPCNavigatorButtonContentParameters);
begin
  inherited CalculateButtonContentParameters(AButton, AParameters);
  AParameters.Enabled := True;
  AParameters.LiteStyle := (AButton = nbClose) or not ParentControl.Enabled or
    (ParentInfo.NavigatorButtonsState[AButton] = nbsDisabled);
  if AParameters.LiteStyle then
    AParameters.BrushColor := cxPCLightBrushColor;
end;

function TcxPCExtraFlatPainter.CalculateTabNormalWidth(Tab: TcxTab): Integer;
begin
  if ParentInfo.TabWidth > 0 then
    Result := ParentInfo.TabWidth
  else
  begin
    Result := GetTabNormalWidth(Tab.VisibleIndex);
    Inc(Result, 12);
    if Tab.Caption <> '' then
      Inc(Result, TextSize(Tab, Tab.Caption).cx - 3);
  end;
  if Result < GetMinTabNormalWidth(Tab.VisibleIndex) then
    Result := GetMinTabNormalWidth(Tab.VisibleIndex);
end;

procedure TcxPCExtraFlatPainter.CorrectTabRect(TabVisibleIndex: Integer;
  var TabRectCorrection: TcxPCRectCorrection);
begin
  with ParentInfo do
    if VisibleTabs[TabVisibleIndex].IsMainTab then
      TabRectCorrection := ExtraFlatPainterMainTabRectCorrection
    else
      inherited CorrectTabRect(TabVisibleIndex, TabRectCorrection);
end;

function TcxPCExtraFlatPainter.GetButtonColor(
  AButtonState: TcxPCNavigatorButtonState): TColor;
begin
  if AButtonState in [nbsHotTrack, nbsPressed] then
    Result := clBtnFace
  else
    Result := GetTabsRowColor;
end;

function TcxPCExtraFlatPainter.GetButtonContentColor(
  AButtonState: TcxPCNavigatorButtonState): TColor;
begin
  if not ParentControl.Enabled or (AButtonState = nbsDisabled) then
    Result := cxPCDarkEdgeColor
  else
    if AButtonState = nbsPressed then
      Result := cxPCLightestEdgeColor
    else
      Result := clBtnText;
end;

function TcxPCExtraFlatPainter.GetButtonContentPosition(
  AButton: TcxPCNavigatorButton): TPoint;
const
  AArrowButtonArrowRectLeftTopCorners: array [TcxPCArrow] of TPoint = (
    (X: 2; Y: 5), (X: 2; Y: 3), (X: 5; Y: 2), (X: 3; Y: 2)
  );
  ACloseButtonCrossRectLeftTopCorners: array[Boolean] of TPoint = ((X: 3; Y: 2), (X: 2; Y: 3));
  AGoDialogArrowRectLeftTopCorner: TPoint = (X: 3; Y: 4);
begin
  case AButton of
    nbGoDialog:
      begin
        Result := AGoDialogArrowRectLeftTopCorner;
        if ParentInfo.NavigatorButtonsState[AButton] = nbsPressed then
          Inc(Result.Y);
      end;
    nbClose:
      Result := ACloseButtonCrossRectLeftTopCorners[ParentInfo.TabPosition in [tpTop, tpBottom]];
  else
    Result := AArrowButtonArrowRectLeftTopCorners[GetButtonArrow(AButton)];
  end;
end;

function TcxPCExtraFlatPainter.GetButtonHeight: Integer;
begin
  Result := ExtraFlatPainterButtonSize;
end;

function TcxPCExtraFlatPainter.GetButtonWidth(
  Button: TcxPCNavigatorButton): Integer;
begin
  Result := ExtraFlatPainterButtonSize;
end;

function TcxPCExtraFlatPainter.GetClientRectOffset: TRect;
begin
  Result := inherited GetClientRectOffset;
  if not ParentInfo.HideTabs and (ParentInfo.RowCount > 0) then
    Inc(Result.Top, ExtraFlatPainterMainTabRowUnderlineWidth);
  ExcludeUnderLine(Result);
end;

function TcxPCExtraFlatPainter.GetDefaultClientColor: TColor;
begin
  if ParentInfo.ActivePage <> nil then
    Result := inherited GetDefaultClientColor
  else
    Result := GetFreeSpaceColor;
end;

function TcxPCExtraFlatPainter.GetDefaultTabNormalHeight: Integer;
begin
  Result := 17;
end;

function TcxPCExtraFlatPainter.GetDefaultTabNormalHTextOffset: Integer;
begin
  Result := 2;
end;

function TcxPCExtraFlatPainter.GetDisplayRectOffset: TRect;
begin
  Result := inherited GetDisplayRectOffset;
  if not ParentInfo.HideTabs and ParentInfo.TabsOnBothSides then
    Inc(Result.Bottom, ExtraFlatPainterTabsRowFreeSpaceWidth);
end;

function TcxPCExtraFlatPainter.GetDrawImageOffset(TabVisibleIndex: Integer): TRect;
begin
  Result := ExtraFlatPainterDrawImageOffsetA[ParentInfo.VisibleTabs[TabVisibleIndex].IsMainTab];
end;

function TcxPCExtraFlatPainter.GetDrawTextHOffset(TabVisibleIndex: Integer): TRect;
var
  AIsMainTab: Boolean;
begin
  AIsMainTab := ParentInfo.VisibleTabs[TabVisibleIndex].IsMainTab;
  Result := ExtraFlatPainterDrawTextHOffsetA[AIsMainTab];
  if ParentInfo.VisibleTabs[TabVisibleIndex].PaintingPositionIndex in [5, 7, 10] then
  begin
    Result.Top := 0;
    Result.Bottom := 0;
  end;

  if GetTabRotatedImageSize.cx > 0 then
    if AIsMainTab then
      Inc(Result.Left)
    else
      Inc(Result.Left, 2);
end;

function TcxPCExtraFlatPainter.GetFrameWidth: Integer;
begin
  Result := 1;
end;

function TcxPCExtraFlatPainter.GetFreeSpaceColor: TColor;
begin
  Result := clBtnFace;
end;

function TcxPCExtraFlatPainter.GetMinTabNormalWidth(ATabVisibleIndex: Integer): Integer;
begin
  Result := GetTabNormalWidth(ATabVisibleIndex);
end;

{ TcxPCExtraFlatPainter }

function TcxPCExtraFlatPainter.CalculateTabNormalHeight: Integer;
var
  DefaultTabNormalHeight: Integer;
begin
  with ParentInfo do
  begin
    Result := InternalCalculateTabNormalHeight;

    DefaultTabNormalHeight := GetDefaultTabNormalHeight;
    if Result < DefaultTabNormalHeight then
      Result := DefaultTabNormalHeight;

    CorrectTabHeightForImage(Result);

    if (TabHeight - 4 >= DefaultTabNormalHeight) and (TabHeight - 4 > Result) then
      Result := TabHeight - 4;
  end;
end;

class function TcxPCExtraFlatPainter.GetStyleID: TcxPCStyleID;
begin
  Result := cxPCExtraFlatStyle;
end;

class function TcxPCExtraFlatPainter.GetStyleName: TCaption;
begin
  Result := 'ExtraFlat';
end;

class function TcxPCExtraFlatPainter.HasLookAndFeel(ALookAndFeel: TcxLookAndFeel): Boolean;
begin
  Result := False;
end;

function TcxPCExtraFlatPainter.GetTabBodyColor(
  TabVisibleIndex: Integer): TColor;
var
  ATab: TcxTab;
begin
  ATab := ParentInfo.VisibleTabs[TabVisibleIndex];
  if ATab.Highlighted then
    Result := HighlightedTabBodyColor
  else
  begin
    Result := GetTabColor(TabVisibleIndex);
    if Result = clDefault then
      if ATab.IsMainTab then
        Result := cxPCTabBodyColor
      else
        if ParentInfo.IsTabsContainer then
          Result := ParentInfo.Color
        else
          Result := cxPCLightBrushColor;
  end;
end;

function TcxPCExtraFlatPainter.GetTabBorderWidth(Tab: TcxTab = nil): Integer;
begin
  Result := 0;
  if (Tab <> nil) and Tab.IsMainTab then Result := 1;
end;

function TcxPCExtraFlatPainter.GetTabContentWOffset(ATabVisibleIndex: Integer): TcxPCWOffset;
begin
  Result := ExtraFlatPainterTabContentWOffset[ParentInfo.VisibleTabs[ATabVisibleIndex].IsMainTab];
end;

function TcxPCExtraFlatPainter.GetTabNormalWidth(ATabVisibleIndex: Integer): Integer;
begin
  if IsAssignedImages and ((ATabVisibleIndex = -1) or IsTabHasImage(ATabVisibleIndex) or ParentInfo.Rotate) then
    Result := GetTabBaseImageSize.cx + 2 * ParentInfo.ImageBorder + 4
  else
    Result := 0;
end;

function TcxPCExtraFlatPainter.GetTabsRowsDelimiterWidth: Integer;
begin
  Result := 3;
end;

function TcxPCExtraFlatPainter.GetTabsNormalDistance: TcxPCDistance;
begin
  Result.dw := GetTabsDelimiterWidth;
  Result.dh := GetTabsRowsDelimiterWidth + ExtraFlatPainterTabsRowFreeSpaceWidth;
  if ParentInfo.Rotate then
    RotateTabsDistance(Result);
end;

function TcxPCExtraFlatPainter.GetTabsPosition(
  NavigatorButtons: TcxPCNavigatorButtons): TcxPCTabsPosition;
const
  TabsRegionHOffset = ExtraFlatPainterTabsRowFreeSpaceWidth;
  TabsRegionWOffset = 6;

  NormalTabsRectCorrection: TRect = (Left: TabsRegionWOffset; Top: TabsRegionHOffset; Right: TabsRegionWOffset; Bottom: 0);
  ExtendedTabsRectCorrection: TRect = (Left: -1; Top: -1; Right: -1; Bottom: 0);

  procedure CalculateNormalParameters(var ATabsPosition: TcxPCTabsPosition);
  var
    AButtonsWidth: Integer;
    ANormalTabsRectCorrection: TRect;
  begin
    with ATabsPosition do
    begin
      AButtonsWidth := CalculateButtonsRegionWidth(NavigatorButtons);
      ANormalTabsRectCorrection := NormalTabsRectCorrection;
      if NeedShowTabsRegionFrame then
        OffsetRect(ANormalTabsRectCorrection, 0, GetFrameWidth);
      NormalTabsRect := GetExtendedRect(GetControlRect(ParentControl),
        ANormalTabsRectCorrection, ParentInfo.TabPosition);

      if ParentInfo.TabPosition in [tpTop, tpBottom] then
      begin
        NormalRowWidth := ParentInfo.Width - 2 * TabsRegionWOffset - AButtonsWidth;
        if ParentInfo.NavigatorPosition in [npLeftTop, npLeftBottom] then
          Inc(NormalTabsRect.Left, AButtonsWidth)
        else
          Dec(NormalTabsRect.Right, AButtonsWidth);
      end else
      begin
        NormalRowWidth := ParentInfo.Height - 2 * TabsRegionWOffset - AButtonsWidth;
        if ParentInfo.NavigatorPosition in [npLeftTop, npRightTop] then
          Inc(NormalTabsRect.Top, AButtonsWidth)
        else
          Dec(NormalTabsRect.Bottom, AButtonsWidth);
      end;
    end;
  end;

begin
  CalculateNormalParameters(Result);

  with Result do
  begin
    ExtendedTabsRect := GetExtendedRect(NormalTabsRect, ExtendedTabsRectCorrection, ParentInfo.TabPosition);

    ExtendedTopOrLeftTabsRectBottomOrRightBorderOffset := 0;
    ExtendedBottomOrRightTabsRectTopOrLeftBorderOffset := 0;
    if ParentInfo.TabPosition in [tpTop, tpLeft] then
      ExtendedTopOrLeftTabsRectBottomOrRightBorderOffset := 1
    else
      ExtendedBottomOrRightTabsRectTopOrLeftBorderOffset := -1;
    MinDistanceBetweenTopOrLeftAndBottomOrRightExtendedTabsRects := GetTabsNormalDistance.dh - 1;
  end;

  CalculateButtonsRegion(NavigatorButtons);
end;

function TcxPCExtraFlatPainter.GetTooNarrowTabContentWOffset(ATabVisibleIndex: Integer): TcxPCWOffset;
begin
  Result := GetTabContentWOffset(ATabVisibleIndex);
end;

function TcxPCExtraFlatPainter.InternalCalculateTabNormalHeight: Integer;
begin
  Result := inherited InternalCalculateTabNormalHeight;
  Dec(Result, 3);
end;

procedure TcxPCExtraFlatPainter.InternalPaint;
begin
  PaintClientArea;
  if not ParentInfo.HideTabs then
  begin
    PaintButtonsRegion;
    PaintTabsRegion;
  end;
end;

procedure TcxPCExtraFlatPainter.PaintButtonFrame(var ARect: TRect;
  AButtonState: TcxPCNavigatorButtonState);
begin
  if AButtonState in [nbsHotTrack, nbsPressed] then
  begin
    InternalDrawEdge(ARect, AButtonState = nbsPressed, True);
    InflateRect(ARect, -1, -1);
  end;
end;

class function TcxPCExtraFlatPainter.IsMainTabBoundWithClient: boolean;
begin
  Result := True;
end;

class function TcxPCExtraFlatPainter.IsMultiSelectionAccepted: boolean;
begin
  Result := False;
end;

class function TcxPCExtraFlatPainter.IsTabPressable: Boolean;
begin
  Result := False;
end;

procedure TcxPCExtraFlatPainter.PaintClientArea;
begin
  PaintMainTabRowUnderline;
  inherited PaintClientArea;
end;

procedure TcxPCExtraFlatPainter.PaintFrame;
begin
  InternalPaintFrame(clBtnHighlight, clBtnShadow);
end;

procedure TcxPCExtraFlatPainter.PaintTabShape(ATab: TcxTab; ATabVisibleIndex: Integer);
var
  R: TRect;
begin
  R := ATab.FullRect;
  if ATab.IsMainTab then
    PaintMainTabFrame(R);

  if not IsTabTransparent(ATabVisibleIndex) then
    DrawBackground(ParentInfo.Canvas.Canvas, R, ATabVisibleIndex);
  if ATab.IsMainTab then
    InternalDrawFocusRect(ATabVisibleIndex, GetFocusRect);
end;

procedure TcxPCExtraFlatPainter.PaintTabsRegion;

  procedure PaintDelimiter(TabVisibleIndex: Integer);

    function IsDelimiterNeeded: Boolean;
    var
      FirstIndex, LastIndex: Integer;
      Tab, NextTab: TcxTab;
    begin
      Result := False;
      Tab := ParentInfo.VisibleTabs[TabVisibleIndex];
      if Tab.IsMainTab then Exit;
      InitializeVisibleTabRange(ParentControl, FirstIndex, LastIndex);
      if TabVisibleIndex = LastIndex then Exit;
      NextTab := ParentInfo.VisibleTabs[TabVisibleIndex + 1];
      if NextTab.IsMainTab then Exit;
      Result := Tab.VisibleRow = NextTab.VisibleRow;
    end;

  var
    ADelimiterOffsets: TcxPCTabsDelimiterOffsets;
    ADelimiterRect, ATabFullRect: TRect;
  begin
    if not IsDelimiterNeeded then
      Exit;
    ATabFullRect := ParentInfo.VisibleTabs[TabVisibleIndex].FullRect;
    ADelimiterOffsets := GetTabsDelimiterOffsets;
    with ATabFullRect do
      case ParentInfo.TabPosition of
        tpTop, tpBottom:
          begin
            ADelimiterRect.Top := Top + ADelimiterOffsets.Top;
            ADelimiterRect.Bottom := Bottom - ADelimiterOffsets.Bottom;
            if IsRightToLeftAlignment(ParentControl) then
              ADelimiterRect.Left := Left - GetTabsDelimiterWidth
            else
              ADelimiterRect.Left := Right;
            ADelimiterRect.Right := ADelimiterRect.Left + GetTabsDelimiterWidth;
          end;
        tpLeft, tpRight:
          begin
            ADelimiterRect.Left := Left + ADelimiterOffsets.Top;
            ADelimiterRect.Right := Right - ADelimiterOffsets.Bottom;
            if IsBottomToTopAlignment(ParentControl) then
              ADelimiterRect.Top := Top - GetTabsDelimiterWidth
            else
              ADelimiterRect.Top := Bottom;
            ADelimiterRect.Bottom := ADelimiterRect.Top + GetTabsDelimiterWidth;
          end;
      end;
    PaintTabsDelimiter(ADelimiterRect);
  end;

var
  AInterval: TcxPCIndexInterval;
  ALineIndexBoundsA: TcxPCLineIndexBoundsArray;
  AOutTabImageAndTextDatas: array of TcxPCOutTabImageAndTextData;
  ARowIndex, I: Integer;
  ARowRect, R: TRect;
begin
  InitializeLineBoundsArray(ParentControl, ALineIndexBoundsA);

  for ARowIndex := 0 to Length(ALineIndexBoundsA) - 1 do
  begin
    SaveClipRgn;

    AInterval := ALineIndexBoundsA[ARowIndex];
    SetLength(AOutTabImageAndTextDatas, AInterval.Right - AInterval.Left + 1);
    for I := AInterval.Left to AInterval.Right do
    begin
      PaintTab(I);
      PaintDelimiter(I);
      AOutTabImageAndTextDatas[I - AInterval.Left] := FOutTabImageAndTextData;
    end;

    ARowRect := GetTabsRowRect(ARowIndex);

    R := ARowRect;
    PaintTabsRowsDelimiter(R, ARowIndex);
    DrawBackground(ParentInfo.Canvas.Canvas, R, -1);

    RestoreClipRgn;

    for I := AInterval.Left to AInterval.Right do
      if IsTabTransparent(I) then
      begin
        FOutTabImageAndTextData := AOutTabImageAndTextDatas[I - AInterval.Left];
        AfterPaintTab(I);
      end;

    ParentInfo.Canvas.ExcludeClipRect(ARowRect);
  end;
end;

procedure TcxPCExtraFlatPainter.RepaintTab(TabVisibleIndex: Integer;
  TabPropertyChanged: TcxPCTabPropertyChanged);
var
  ATab: TcxTab;
begin
  if IsVerticalText(ParentControl) then
    ParentInfo.VisibleTabs[TabVisibleIndex].ResetVerticalTextBitmap;
  ATab := ParentInfo.VisibleTabs[TabVisibleIndex];
  if (TabPropertyChanged = tpcIsMainTab) and not ATab.IsMainTab then
    InvalidateTabExtendedTabsRect(TabVisibleIndex)
  else
    InvalidateTabRect(TabVisibleIndex);
  if ATab.IsMainTab then
    ParentControl.InvalidateRect(GetMainTabRowUnderlineRect, False);
end;

function TcxPCExtraFlatPainter.GetButtonsDistance(
  AButton1, AButton2: TcxPCNavigatorButton): Integer;
begin
  if IsOneOfButtons(AButton1, AButton2, nbGoDialog) then
  begin
    if IsOneOfButtons(AButton1, AButton2, nbClose) then
      Result := 3
    else
      Result := 0;
  end
  else
    Result := 3;
end;

function TcxPCExtraFlatPainter.GetButtonsRegionHOffset: Integer;
begin
  Result := 6;
end;

function TcxPCExtraFlatPainter.GetButtonsRegionWOffset: Integer;
begin
  Result := 1;
  if NeedShowTabsRegionFrame then
    Inc(Result, GetFrameWidth);
end;

function TcxPCExtraFlatPainter.GetFocusRect: TRect;
const
  AFocusRectCorrectionA: array[TcxTabPosition] of TcxPCRectCorrection = (
    (dLeft:  0; dTop:  0; dRight: -1; dBottom:  1),
    (dLeft:  1; dTop: -1; dRight: -1; dBottom: -1),
    (dLeft:  0; dTop:  0; dRight:  1; dBottom: -1),
    (dLeft: -1; dTop:  1; dRight: -1; dBottom: -1)
  );
begin
  Result := ParentInfo.VisibleTabs[ParentInfo.MainTabVisibleIndex].FullRect;
  CorrectRect(Result, AFocusRectCorrectionA[ParentInfo.TabPosition]);
end;

function TcxPCExtraFlatPainter.GetTabsDelimiterOffsets: TcxPCTabsDelimiterOffsets;
begin
  Result.Top := 2;
  Result.Bottom := 2;
end;

procedure TcxPCExtraFlatPainter.DrawBackground(ACanvas: TCanvas; ARect: TRect;
  ATabVisibleIndex: Integer);
begin
  if (ATabVisibleIndex <> -1) and (ATabVisibleIndex <> ParentInfo.MainTabVisibleIndex) then
  begin
    ACanvas.Brush.Color := GetTabsRowColor;
    ACanvas.FrameRect(ARect);
    InflateRect(ARect, -1, -1);
  end;

  if ATabVisibleIndex = -1 then
    ACanvas.Brush.Color := GetTabsRowColor
  else
    ACanvas.Brush.Color := GetTabBodyColor(ATabVisibleIndex);
  ACanvas.Brush.Style := bsSolid;
  ACanvas.FillRect(ARect);
end;

procedure TcxPCExtraFlatPainter.ExcludeUnderLine(var R: TRect);
begin
  if NeedShowFrame and not ParentInfo.HideTabs and (ParentInfo.RowCount > 0) then
    Dec(R.Top);
end;

function TcxPCExtraFlatPainter.GetMainTabRowUnderlineColor: TColor;
begin
  if ParentInfo.MainTabVisibleIndex = -1 then
    Result := cxPCTabBodyColor
  else
  begin
    Result := GetTabColor(ParentInfo.MainTabVisibleIndex);
    if Result = clDefault then
      Result := cxPCTabBodyColor;
  end;
end;

function TcxPCExtraFlatPainter.GetMainTabRowUnderlineRect: TRect;
begin
  if ParentInfo.HideTabs or (ParentInfo.RowCount = 0) then
  begin
    Result := cxEmptyRect;
    Exit;
  end;

  Result := GetClientRect;
  SubtractRect(Result,
    GetExtendedRect(Result, Rect(0, - ExtraFlatPainterMainTabRowUnderlineWidth, 0, 0), ParentInfo.TabPosition),
    Result);
end;

function TcxPCExtraFlatPainter.GetTabBackgroundRect(ATabVisibleIndex: Integer;
  AForNormalState: Boolean): TRect;
var
  ATab: TcxTab;
begin
  ATab := ParentInfo.VisibleTabs[ATabVisibleIndex];
  if not AForNormalState and (ATabVisibleIndex = ParentInfo.MainTabVisibleIndex) then
    Result := GetExtendedRect(ATab.FullRect, Rect(1, 1, 1, 0), ATab.PaintingPosition)
  else
  begin
    Result := GetExtendedRect(ATab.NormalRect,
      Rect(0, -ExtraFlatPainterTabsRowFreeSpaceWidth, 0, -GetTabsRowsDelimiterWidth),
      ParentInfo.TabPosition);
  end;
end;

function TcxPCExtraFlatPainter.GetTabsDelimiterWidth: Integer;
begin
  Result := 1;
end;

function TcxPCExtraFlatPainter.GetTabsRowColor: TColor;
begin
  if ParentInfo.IsTabsContainer then
    Result := ParentInfo.Color
  else
    Result := cxPCLightBrushColor;
end;

function TcxPCExtraFlatPainter.GetTabsRowRect(ARowIndex: Integer): TRect;
var
  ALineIndexBoundsA: TcxPCLineIndexBoundsArray;
begin
  InitializeLineBoundsArray(ParentControl, ALineIndexBoundsA);
  Result := GetTabBackgroundRect(ALineIndexBoundsA[ARowIndex].Left, True);
  if ParentInfo.TabPosition in [tpLeft, tpRight] then
  begin
    Result.Top := 0;
    Result.Bottom := ParentInfo.Height;
  end
  else
  begin
    Result.Left := 0;
    Result.Right := ParentInfo.Width;
  end;

  if NeedShowTabsRegionFrame then
    Result := GetExtendedRect(Result, Rect(1, 0, 1, 0), ParentInfo.TabPosition);
end;

procedure TcxPCExtraFlatPainter.InternalPaintFrame(
  ALeftTopColor, ARightBottomColor: TColor);
var
  R: TRect;
begin
  R := GetDisplayRect;
  if ParentInfo.HideTabs or (ParentInfo.RowCount = 0) then
    ParentInfo.Canvas.DrawComplexFrame(R, ALeftTopColor, ARightBottomColor)
  else
    case ParentInfo.TabPosition of
      tpTop:
        DrawBorder(ParentInfo.Canvas, R, [bRight, bBottom, bLeft], [ARightBottomColor, ARightBottomColor, ALeftTopColor]);
      tpBottom:
        DrawBorder(ParentInfo.Canvas, R, [bRight, bTop, bLeft], [ARightBottomColor, ALeftTopColor, ALeftTopColor]);
      tpLeft:
        DrawBorder(ParentInfo.Canvas, R, [bBottom, bRight, bTop], [ARightBottomColor, ARightBottomColor, ALeftTopColor]);
      tpRight:
        DrawBorder(ParentInfo.Canvas, R, [bBottom, bLeft, bTop], [ARightBottomColor, ALeftTopColor, ALeftTopColor]);
    end;
end;

procedure TcxPCExtraFlatPainter.InternalPaintMainTabFrame(var R: TRect;
  ALightColor, ADarkColor: TColor);
var
  AMainTab: TcxTab;
begin
  AMainTab := ParentInfo.VisibleTabs[ParentInfo.MainTabVisibleIndex];
  case AMainTab.PaintingPosition of
    tpTop:
      DrawBorder(ParentInfo.Canvas, R, [bLeft, bTop, bRight], [ALightColor, ALightColor, ADarkColor]);
    tpBottom:
      begin
        DrawBorder(ParentInfo.Canvas, R, [bLeft, bBottom, bRight], [ALightColor, ADarkColor, ADarkColor]);
        ParentInfo.Canvas.Pixels[R.Left - 1, R.Top] := ADarkColor;
      end;
    tpLeft:
      DrawBorder(ParentInfo.Canvas, R, [bTop, bLeft, bBottom], [ALightColor, ALightColor, ADarkColor]);
    tpRight:
      begin
        DrawBorder(ParentInfo.Canvas, R, [bTop, bRight, bBottom], [ALightColor, ADarkColor, ADarkColor]);
        ParentInfo.Canvas.Pixels[R.Left, R.Top - 1] := ADarkColor;
      end;
  end;
end;

procedure TcxPCExtraFlatPainter.InternalPaintTabsRowsDelimiter(var ARowRect: TRect;
  AColors: array of TColor);
var
  I: Integer;
begin
  for I := 0 to GetTabsRowsDelimiterWidth - 1 do
    case ParentInfo.TabPosition of
      tpTop:
        DrawBorder(ParentInfo.Canvas, ARowRect, [bBottom], [AColors[I]]);
      tpBottom:
        DrawBorder(ParentInfo.Canvas, ARowRect, [bTop], [AColors[I]]);
      tpLeft:
        DrawBorder(ParentInfo.Canvas, ARowRect, [bRight], [AColors[I]]);
      tpRight:
        DrawBorder(ParentInfo.Canvas, ARowRect, [bLeft], [AColors[I]]);
    end;
end;

function TcxPCExtraFlatPainter.IsMainTabRow(AVisibleRow: Integer): Boolean;
begin
  if ParentInfo.MainTabVisibleIndex <> -1 then
    Result := ParentInfo.VisibleTabs[ParentInfo.MainTabVisibleIndex].VisibleRow = AVisibleRow
  else
    if ParentInfo.TabPosition in [tpTop, tpLeft] then
      Result := AVisibleRow = ParentInfo.RowCount - 1
    else
      Result := AVisibleRow = 0;
end;

function TcxPCExtraFlatPainter.NeedShowTabsRegionFrame: Boolean;
begin
  Result := False;
end;

procedure TcxPCExtraFlatPainter.PaintMainTabFrame(var R: TRect);
begin
  InternalPaintMainTabFrame(R, clWhite, clBlack);
end;

procedure TcxPCExtraFlatPainter.PaintMainTabRowUnderline;
begin
  if not ParentInfo.HideTabs and (ParentInfo.RowCount > 0) then
  begin
    ParentInfo.Canvas.Brush.Color := GetMainTabRowUnderlineColor;
    ParentInfo.Canvas.FillRect(GetMainTabRowUnderlineRect);
  end;
end;

procedure TcxPCExtraFlatPainter.PaintTabsDelimiter(const ARect: TRect);
begin
  ParentInfo.Canvas.Brush.Color := cxPCDarkEdgeColor;
  ParentInfo.Canvas.FillRect(ARect);
  ParentInfo.Canvas.ExcludeClipRect(ARect);
end;

procedure TcxPCExtraFlatPainter.PaintTabsRowsDelimiter(var ARowRect: TRect;
  ARowIndex: Integer);
begin
  if ParentInfo.TabPosition in [tpTop, tpLeft] then
    InternalPaintTabsRowsDelimiter(ARowRect, [cxPCTabBodyColor, cxPCTabBodyColor, clWhite])
  else
    InternalPaintTabsRowsDelimiter(ARowRect, [cxPCTabBodyColor, cxPCTabBodyColor, clBlack])
end;

{ TcxPCUltraFlatPainter }

class function TcxPCUltraFlatPainter.GetStyleID: TcxPCStyleID;
begin
  Result := cxPCUltraFlatStyle;
end;

class function TcxPCUltraFlatPainter.GetStyleName: TCaption;
begin
  Result := 'UltraFlat';
end;

class function TcxPCUltraFlatPainter.HasLookAndFeel(ALookAndFeel: TcxLookAndFeel): Boolean;
begin
  Result := ALookAndFeel.GetAvailablePainter([totTab]).LookAndFeelStyle = lfsUltraFlat;
end;

procedure TcxPCUltraFlatPainter.CalculateButtonContentParameters(
  AButton: TcxPCNavigatorButton; out AParameters: TcxPCNavigatorButtonContentParameters);
begin
  inherited CalculateButtonContentParameters(AButton, AParameters);
  AParameters.Enabled := ParentControl.Enabled;
  AParameters.LiteStyle := AButton = nbClose;
  AParameters.BrushColor := AParameters.Color;
end;

function TcxPCUltraFlatPainter.GetButtonColor(
  AButtonState: TcxPCNavigatorButtonState): TColor;
begin
  if AButtonState = nbsHotTrack then
    Result := clBtnFace
  else
    if AButtonState = nbsPressed then
      Result := clBtnShadow
    else
      Result := cxPCLightBrushColor;
end;

function TcxPCUltraFlatPainter.GetButtonContentPosition(
  AButton: TcxPCNavigatorButton): TPoint;
begin
  Result := GetButtonCenteredContentPosition(AButton);
end;

function TcxPCUltraFlatPainter.GetButtonHeight: Integer;
begin
  Result := UltraFlatPainterButtonHeight;
end;

function TcxPCUltraFlatPainter.GetButtonsDistance(
  AButton1, AButton2: TcxPCNavigatorButton): Integer;
begin
  if IsOneOfButtons(AButton1, AButton2, nbClose) then
    Result := 3
  else
    Result := 1;
end;

function TcxPCUltraFlatPainter.GetButtonsRegionHOffset: Integer;
begin
  Result := 3;
end;

function TcxPCUltraFlatPainter.GetButtonWidth(Button: TcxPCNavigatorButton): Integer;
begin
  Result := UltraFlatPainterButtonWidthA[Button];
end;

function TcxPCUltraFlatPainter.GetFocusRect: TRect;
begin
  Result := GetExtendedRect(ParentInfo.VisibleTabs[ParentInfo.MainTabVisibleIndex].FullRect,
    Rect(1, 1, 1, 0), ParentInfo.TabPosition);
end;

procedure TcxPCUltraFlatPainter.PaintButtonFrame(var ARect: TRect;
  AButtonState: TcxPCNavigatorButtonState);

  function GetFrameColor: TColor;
  begin
    if AButtonState in [nbsNormal, nbsDisabled] then
      Result := clBtnShadow
    else
      Result := clBlack;
  end;

begin
  ParentInfo.Canvas.DrawComplexFrame(ARect, GetFrameColor, GetFrameColor);
  InflateRect(ARect, -1, -1);
end;

procedure TcxPCUltraFlatPainter.PaintFrame;
begin
  InternalPaintFrame(clBtnShadow, clBtnShadow);
end;

procedure TcxPCUltraFlatPainter.PaintMainTabFrame(var R: TRect);
begin
  InternalPaintMainTabFrame(R, clBlack, clBlack);
end;

procedure TcxPCUltraFlatPainter.PaintTabsRowsDelimiter(var ARowRect: TRect;
  ARowIndex: Integer);
begin
  if IsMainTabRow(ARowIndex) then
    InternalPaintTabsRowsDelimiter(ARowRect, [cxPCTabBodyColor, cxPCTabBodyColor, clBlack])
  else
    InternalPaintTabsRowsDelimiter(ARowRect, [cxPCTabBodyColor, clBlack, cxPCTabBodyColor])
end;

{ TcxPCFlatPainter }

class function TcxPCFlatPainter.GetStyleID: TcxPCStyleID;
begin
  Result := cxPCFlatStyle;
end;

class function TcxPCFlatPainter.GetStyleName: TCaption;
begin
  Result := 'Flat';
end;

class function TcxPCFlatPainter.HasLookAndFeel(ALookAndFeel: TcxLookAndFeel): Boolean;
begin
  Result := ALookAndFeel.GetAvailablePainter([totTab]).LookAndFeelStyle = lfsFlat;
end;

function TcxPCFlatPainter.GetButtonContentPosition(
  AButton: TcxPCNavigatorButton): TPoint;
begin
  Result := inherited GetButtonContentPosition(AButton);
  Dec(Result.X, TabsPainterButtonBorderWidth - FlatPainterButtonBorderWidth);
  Dec(Result.Y, TabsPainterButtonBorderWidth - FlatPainterButtonBorderWidth);
end;

function TcxPCFlatPainter.GetButtonHeight: Integer;
begin
  Result := inherited GetButtonHeight;
  Dec(Result, (TabsPainterButtonBorderWidth - FlatPainterButtonBorderWidth) * 2);
end;

function TcxPCFlatPainter.GetButtonWidth(Button: TcxPCNavigatorButton): Integer;
begin
  Result := inherited GetButtonWidth(Button);
  Dec(Result, (TabsPainterButtonBorderWidth - FlatPainterButtonBorderWidth) * 2);
end;

function TcxPCFlatPainter.GetFrameWidth: Integer;
begin
  Result := 1;
end;

function TcxPCFlatPainter.GetTabClipRgn(ATabVisibleIndex: Integer): TcxRegion;
begin
  Result := TcxRegion.Create(ParentInfo.VisibleTabs[ATabVisibleIndex].VisibleRect);
end;

function TcxPCFlatPainter.GetTabClipRgnOperation(ATabVisibleIndex: Integer): TcxRegionOperation;
begin
  Result := roIntersect;
end;

function TcxPCFlatPainter.IsNativePainting: Boolean;
begin
  Result := False;
end;

function TcxPCFlatPainter.NeedShowFrame: Boolean;
begin
  Result := True;
end;

procedure TcxPCFlatPainter.PaintButtonFrame(var ARect: TRect;
  AButtonState: TcxPCNavigatorButtonState);
begin
  if AButtonState = nbsPressed then
    ParentInfo.Canvas.DrawComplexFrame(ARect, cxPCDarkEdgeColor, cxPCLightestEdgeColor)
  else
    ParentInfo.Canvas.DrawComplexFrame(ARect, cxPCLightestEdgeColor, cxPCDarkEdgeColor);
  InflateRect(ARect, -1, -1);
end;

procedure TcxPCFlatPainter.PaintFrameBorder(R: TRect);
begin
  ParentInfo.Canvas.DrawComplexFrame(R, cxPCLightestEdgeColor, cxPCDarkEdgeColor);
end;

procedure TcxPCFlatPainter.PaintTabFrame(ATabVisibleIndex: Integer);

  function GetContrastColor: TColor;
  begin
    Result := Light(GetTabBodyColor(ATabVisibleIndex), 85);
  end;

var
  AContrastColor: TColor;
  ATab: TcxTab;
  R: TRect;
begin
  ATab := ParentInfo.VisibleTabs[ATabVisibleIndex];
  R := ATab.FullRect;
  AContrastColor := GetContrastColor;
  with R do
    case ATab.PaintingPosition of
      tpTop:
        begin
          InternalPolyLine([Point(Left, Bottom - 1), Point(Left, Top + 2), Point(Left + 2, Top), Point(Right - 3, Top), Point(Right - 2, Top + 1)], cxPCLightestEdgeColor);
          InternalPolyLine([Point(Right - 1, Top + 2), Point(Right - 1, Bottom - 1)], cxPCDarkEdgeColor);
          InternalPolyLine([Point(Left + 1, Bottom - 1), Point(Left + 1, Top + 2), Point(Left + 2, Top + 1), Point(Right - 3, Top + 1), Point(Right - 2, Top + 2), Point(Right - 2, Bottom - 1)], AContrastColor);
        end;
      tpBottom:
        begin
          InternalPolyLine([Point(Left, Top), Point(Left, Bottom - 3), Point(Left + 1, Bottom - 2)], cxPCLightestEdgeColor);
          InternalPolyLine([Point(Left + 2, Bottom - 1), Point(Right - 3, Bottom - 1), Point(Right - 1, Bottom - 3), Point(Right - 1, Top)], cxPCDarkEdgeColor);
          InternalPolyLine([Point(Left + 1, Top), Point(Left + 1, Bottom - 3)], AContrastColor);
          InternalPolyLine([Point(Left + 2, Bottom - 2), Point(Right - 3, Bottom - 2), Point(Right - 2, Bottom - 3), Point(Right - 2, Top)], clBtnFace);
        end;
      tpLeft:
        begin
          InternalPolyLine([Point(Right - 1, Bottom - 1), Point(Left + 2, Bottom - 1)], cxPCDarkEdgeColor);
          InternalPolyLine([Point(Left + 1, Bottom - 2), Point(Left, Bottom - 3), Point(Left, Top + 2), Point(Left + 2, Top), Point(Right - 1, Top)], cxPCLightestEdgeColor);
          InternalPolyLine([Point(Right - 1, Bottom - 2), Point(Left + 2, Bottom - 2), Point(Left + 1, Bottom - 3), Point(Left + 1, Top + 2), Point(Left + 2, Top + 1), Point(Right - 1, Top + 1)], AContrastColor);
        end;
      tpRight:
        begin
          InternalPolyLine([Point(Left, Top), Point(Right - 3, Top), Point(Right - 2, Top + 1)], cxPCLightestEdgeColor);
          InternalPolyLine([Point(Right - 1, Top + 2), Point(Right - 1, Bottom - 3), Point(Right - 3, Bottom - 1), Point(Left, Bottom - 1)], cxPCDarkEdgeColor);
          InternalPolyLine([Point(Left, Top + 1), Point(Right - 3, Top + 1)], AContrastColor);
          InternalPolyLine([Point(Right - 2, Top + 2), Point(Right - 2, Bottom - 3), Point(Right - 3, Bottom - 2), Point(Left, Bottom - 2)], clBtnFace);
        end;
    end;
  PaintTabCorners(ATabVisibleIndex);
end;

{ TcxPCOffice11Painter }

class function TcxPCOffice11Painter.GetStyleID: TcxPCStyleID;
begin
  Result := cxPCOffice11Style;
end;

class function TcxPCOffice11Painter.GetStyleName: TCaption;
begin
  Result := 'Office11';
end;

class function TcxPCOffice11Painter.HasLookAndFeel(
  ALookAndFeel: TcxLookAndFeel): Boolean;
begin
  with ALookAndFeel do
    Result := (ALookAndFeel.SkinPainter = nil) and (GetAvailablePainter([totTab]).LookAndFeelStyle = lfsOffice11);
end;

class function TcxPCOffice11Painter.GetFrameColor: TColor;
begin
  Result := dxOffice11SelectedBorderColor;
end;

procedure TcxPCOffice11Painter.DrawBackground(ACanvas: TCanvas; ARect: TRect;
  ATabVisibleIndex: Integer);
begin
  DrawGradientBackground(ACanvas, ARect, ATabVisibleIndex,
    ParentInfo.TabPosition in [tpLeft, tpRight], False);
end;

procedure TcxPCOffice11Painter.ExcludeUnderLine(var R: TRect);
begin
// do nothing
end;

procedure TcxPCOffice11Painter.FillDisplayRect;
begin
  if (ParentInfo.ActivePage <> nil) and not ParentInfo.ActivePage.ParentColor then
  begin
    ParentInfo.Canvas.Brush.Color := ParentInfo.ActivePage.Color;
    ParentInfo.Canvas.FillRect(GetClientRect);
  end
  else
    if IsGradientClienArea then
      FillGradientRect(ParentInfo.Canvas.Handle, GetClientRect,
        dxOffice11ToolbarsColor1, dxOffice11ToolbarsColor2,
        ParentInfo.TabPosition in [tpLeft, tpRight])
    else
    begin
      ParentInfo.Canvas.Brush.Color := GetMiddleRGB(dxOffice11ToolbarsColor1, dxOffice11ToolbarsColor2, 50);
      ParentInfo.Canvas.FillRect(GetClientRect);
    end;
end;

function TcxPCOffice11Painter.GetButtonContentColor(
  AButtonState: TcxPCNavigatorButtonState): TColor;
begin
  if AButtonState = nbsDisabled then
    Result := dxOffice11TextDisabledColor
  else
    Result := dxOffice11TextEnabledColor;
end;

function TcxPCOffice11Painter.GetClientRectOffset: TRect;
begin
  Result := inherited GetClientRectOffset;
  if NeedShowMainTabOppositeRowLine then
    Inc(Result.Bottom);
end;

function TcxPCOffice11Painter.GetFocusRect: TRect;
begin
  Result := GetExtendedRect(ParentInfo.VisibleTabs[ParentInfo.MainTabVisibleIndex].FullRect,
    Rect(1, 1, 1, 0), ParentInfo.TabPosition);
end;

function TcxPCOffice11Painter.GetFreeSpaceColor: TColor;
begin
  Result := GetFrameColor;
end;

function TcxPCOffice11Painter.GetMainTabRowUnderlineColor: TColor;
begin
  if (ParentInfo.MainTabVisibleIndex <> -1) and
    (GetTabColor(ParentInfo.MainTabVisibleIndex) <> clDefault) then
      Result := GetTabColor(ParentInfo.MainTabVisibleIndex)
  else
  if not (pcoGradient in ParentInfo.Options) then
    Result := GetMiddleRGB(GetSelectedColor1, GetSelectedColor2, 50)
  else
    if ParentInfo.TabPosition in [tpTop, tpLeft] then
      Result := GetSelectedColor2
    else
      Result := GetSelectedColor1;
end;

function TcxPCOffice11Painter.GetMainTabRowUnderlineRect: TRect;
begin
  if ParentInfo.HideTabs or (ParentInfo.RowCount = 0) then
  begin
    Result := cxEmptyRect;
    Exit;
  end;

  Result := GetDisplayRect;
  SubtractRect(Result, Result,
    GetExtendedRect(Result, Rect(0, ExtraFlatPainterMainTabRowUnderlineWidth, 0, 0), ParentInfo.TabPosition));
end;

function TcxPCOffice11Painter.GetTabBodyColor(TabVisibleIndex: Integer): TColor;
begin
  if ParentInfo.VisibleTabs[TabVisibleIndex].Highlighted then
    Result := HighlightedTabBodyColor
  else
    Result := GetTabColor(TabVisibleIndex);
end;

function TcxPCOffice11Painter.GetTabsDelimiterOffsets: TcxPCTabsDelimiterOffsets;
begin
  if ParentInfo.TabPosition in [tpTop, tpLeft] then
  begin
    Result.Top := 0;
    Result.Bottom := 2;
  end
  else
  begin
    Result.Top := 3;
    Result.Bottom := -1;
  end;
end;

function TcxPCOffice11Painter.GetTabsDelimiterWidth: Integer;
begin
  Result := 2;
end;

function TcxPCOffice11Painter.GetTabsRowsDelimiterWidth: Integer;
begin
  Result := 1;
end;

function TcxPCOffice11Painter.IsTabTransparent(ATabVisibleIndex: Integer): Boolean;
begin
  Result := not (ParentInfo.VisibleTabs[ATabVisibleIndex].IsMainTab or
    (GetTabBodyColor(ATabVisibleIndex) <> clDefault));
end;

function TcxPCOffice11Painter.NeedRedrawOnResize: Boolean;
begin
  Result := IsGradientClienArea;
end;

function TcxPCOffice11Painter.NeedShowTabsRegionFrame: Boolean;
begin
  Result := NeedShowFrame;
end;

procedure TcxPCOffice11Painter.PaintButtonBackground(AButtonRect: TRect;
  AButtonState: TcxPCNavigatorButtonState);
var
  AColor1, AColor2: TColor;
  ATabsRowRect: TRect;
begin
  if not InternalSetClipRect(AButtonRect) then
    Exit;
  ATabsRowRect := GetTabsRowRect(0);
  case AButtonState of
    nbsNormal, nbsDisabled:
      DrawBackground(ParentInfo.Canvas.Canvas, ATabsRowRect, -1);
    nbsPressed, nbsHotTrack:
      begin
        if AButtonState = nbsHotTrack then
        begin
          AColor1 := GetSelectedColor1;
          AColor2 := GetSelectedColor2;
        end
        else
        begin
          AColor1 := dxOffice11SelectedDownColor1;
          AColor2 := dxOffice11SelectedDownColor2;
        end;
        if not (pcoGradient in ParentInfo.Options) then
        begin
          AColor1 := GetMiddleRGB(AColor1, AColor2, 50);
          AColor2 := AColor1;
        end;
        FillGradientRect(ParentInfo.Canvas.Handle, ATabsRowRect, AColor1, AColor2,
          ParentInfo.TabPosition in [tpLeft, tpRight]);
      end;
  end;
  RestoreClipRgn;
end;

procedure TcxPCOffice11Painter.PaintButtonFrame(var ARect: TRect;
  AButtonState: TcxPCNavigatorButtonState);

  function GetFrameColor: TColor;
  begin
    if not ParentControl.Enabled or (AButtonState = nbsDisabled) then
      Result := dxOffice11TextDisabledColor
    else
      Result := TcxPCOffice11Painter.GetFrameColor;
  end;

begin
  ParentInfo.Canvas.FrameRect(ARect, GetFrameColor);
  InflateRect(ARect, -1, -1);
end;

procedure TcxPCOffice11Painter.PaintClientArea;
begin
  PaintMainTabOppositeRowLine;
  inherited PaintClientArea;
end;

procedure TcxPCOffice11Painter.PaintFrame;
var
  AFrameRect: TRect;
begin
  AFrameRect := GetClientRect;
  InflateRect(AFrameRect, 1, 1);
  ParentInfo.Canvas.FrameRect(AFrameRect, GetFrameColor);
end;

procedure TcxPCOffice11Painter.PaintMainTabFrame(var R: TRect);
begin
  InternalPaintMainTabFrame(R, GetFrameColor, GetFrameColor);
end;

procedure TcxPCOffice11Painter.PaintTabsDelimiter(const ARect: TRect);

  procedure PaintDelimiterLine(const R: TRect; AColor: TColor);
  begin
    ParentInfo.Canvas.Brush.Color := AColor;
    ParentInfo.Canvas.FillRect(R);
    ParentInfo.Canvas.ExcludeClipRect(R);
  end;

var
  R: TRect;
begin
  R := ARect;
  Dec(R.Right);
  Dec(R.Bottom);
  PaintDelimiterLine(R, dxOffice11BarSeparatorColor1);
  OffsetRect(R, 1, 1);
  PaintDelimiterLine(R, dxOffice11BarSeparatorColor2);
end;

procedure TcxPCOffice11Painter.PaintTabsRowsDelimiter(var ARowRect: TRect;
  ARowIndex: Integer);
begin
  InternalPaintTabsRowsDelimiter(ARowRect, [GetFrameColor]);
end;

procedure TcxPCOffice11Painter.PrepareDrawTabContentBitmapBackground(
  ABitmap: TBitmap; const ABitmapPos: TPoint; ATabVisibleIndex: Integer);
var
  P: TPoint;
  R: TRect;
begin
  R := GetExtendedRect(GetTabBackgroundRect(ATabVisibleIndex, False),
    Rect(0, 0, 0, GetTabsRowsDelimiterWidth), ParentInfo.TabPosition);
  P := ABitmapPos;
  if IsVerticalText(ParentControl) then
  begin
    R := Rect(R.Top, R.Left, R.Bottom, R.Right);
    P := Point(P.Y, P.X);
  end;
  if ParentInfo.Rotate and (GetTextRotationAngle(ParentControl) = raPlus90) then
    OffsetRect(R, -R.Left + P.X + ABitmap.Width - R.Right, -P.Y)
  else if not ParentInfo.Rotate and (GetTextRotationAngle(ParentControl) = raMinus90) then
    OffsetRect(R, -P.X, -R.Top - (R.Bottom - P.Y - ABitmap.Height))
  else
    OffsetRect(R, -P.X, -P.Y);
  DrawGradientBackground(ABitmap.Canvas, R, ATabVisibleIndex, ParentInfo.Rotate,
    not ParentInfo.Rotate and (GetTextRotationAngle(ParentControl) = raMinus90) or
    ParentInfo.Rotate and (GetTextRotationAngle(ParentControl) = raPlus90));
end;

procedure TcxPCOffice11Painter.DrawGradientBackground(ACanvas: TCanvas;
  ARect: TRect; ATabVisibleIndex: Integer; AHorizontal, AInverse: Boolean);

  procedure GetGradientColors(out AColor1, AColor2: TColor);
  begin
//    if ParentInfo.IsTabsContainer and ((ATabVisibleIndex = -1) or (ATabVisibleIndex <> ParentInfo.MainTabVisibleIndex)) then
//    begin
//      AColor1 := ParentInfo.Color;
//      AColor2 := AColor1;
//      Exit; 
//    end;

    if (ATabVisibleIndex <> -1) and (ATabVisibleIndex = ParentInfo.MainTabVisibleIndex) then
    begin
      AColor1 := GetSelectedColor1;
      AColor2 := GetSelectedColor2;
    end
    else
    begin
      AColor1 := dxOffice11ToolbarsColor1;
      AColor2 := dxOffice11ToolbarsColor2;
    end;

    if not (pcoGradient in ParentInfo.Options) then
    begin
      AColor1 := GetMiddleRGB(AColor1, AColor2, 50);
      AColor2 := AColor1;
    end
    else
      if AInverse then
        ExchangeLongWords(AColor1, AColor2);
  end;

  procedure DrawColoredTabBackground;
  var
    AColor1, AColor2: TColor;
  begin
    GetGradientColors(AColor1, AColor2);
    if ATabVisibleIndex <> ParentInfo.MainTabVisibleIndex then
      case ParentInfo.VisibleTabs[ATabVisibleIndex].PaintingPosition of
        tpTop:
          begin
            InternalPolyLine([Point(ARect.Left, ARect.Bottom - 1), Point(ARect.Right - 1, ARect.Bottom - 1)], AColor2, ACanvas);
            Dec(ARect.Bottom);
          end;
        tpBottom:
          begin
            InternalPolyLine([Point(ARect.Left, ARect.Top), Point(ARect.Right - 1, ARect.Top)], AColor1, ACanvas);
            Inc(ARect.Top);
          end;
        tpLeft:
          begin
            InternalPolyLine([Point(ARect.Right - 1, ARect.Top), Point(ARect.Right - 1, ARect.Bottom - 1)], AColor2, ACanvas);
            Dec(ARect.Right);
          end;
        tpRight:
          begin
            InternalPolyLine([Point(ARect.Left, ARect.Top), Point(ARect.Left, ARect.Bottom - 1)], AColor1, ACanvas);
            Inc(ARect.Left);
          end;
      end;
    ACanvas.Brush.Color := GetTabBodyColor(ATabVisibleIndex);
    ACanvas.FillRect(ARect);
  end;

var
  AColor1, AColor2: TColor;
begin
  if (ATabVisibleIndex <> -1) and (GetTabBodyColor(ATabVisibleIndex) <> clDefault) then
    DrawColoredTabBackground
  else
  begin
    GetGradientColors(AColor1, AColor2);
    FillGradientRect(ACanvas.Handle, ARect, AColor1, AColor2, AHorizontal);
  end;
end;

function TcxPCOffice11Painter.GetSelectedColor1: TColor;
begin
  Result := dxOffice11SelectedColor1;
end;

function TcxPCOffice11Painter.GetSelectedColor2: TColor;
begin
  Result := dxOffice11SelectedColor2;
end;

function TcxPCOffice11Painter.IsGradientClienArea: Boolean;
begin
  Result := ParentInfo.Options * [pcoGradient, pcoGradientClientArea] = [pcoGradient, pcoGradientClientArea];
end;

function TcxPCOffice11Painter.NeedShowMainTabOppositeRowLine: Boolean;
begin
  Result := not NeedShowFrame and
    ((ParentInfo.TabPosition in [tpTop, tpLeft]) and (ParentInfo.TopOrLeftPartRowCount <> ParentInfo.RowCount) or
    (ParentInfo.TabPosition in [tpBottom, tpRight]) and (ParentInfo.TopOrLeftPartRowCount <> 0));
end;

procedure TcxPCOffice11Painter.PaintMainTabOppositeRowLine;
var
  ARWidth, ARHeight: Integer;
  R: TRect;
begin
  if NeedShowMainTabOppositeRowLine then
  begin
    R := GetExtendedRect(GetClientRect, Rect(0, 0, 0, -1), ParentInfo.TabPosition);
    GetRectSize(R, ParentInfo.TabPosition in [tpTop, tpBottom], ARWidth, ARHeight);
    DirectionalPolyline(R, [Point(R.Left, R.Bottom - 1), Point(R.Left + ARWidth - 1, R.Bottom - 1)],
      ParentInfo.TabPosition, GetFrameColor);
  end;
end;

{ TcxPCSlantedPainter }

class function TcxPCSlantedPainter.GetStyleID: TcxPCStyleID;
begin
  Result := cxPCSlantedStyle;
end;

class function TcxPCSlantedPainter.GetStyleName: TCaption;
begin
  Result := 'Slanted';
end;

class function TcxPCSlantedPainter.HasLookAndFeel(
  ALookAndFeel: TcxLookAndFeel): Boolean;
begin
  Result := False;
end;

function TcxPCSlantedPainter.AlwaysColoredTabs: Boolean;
begin
  Result := True;
end;

procedure TcxPCSlantedPainter.CalculateButtonContentParameters(
  AButton: TcxPCNavigatorButton; out AParameters: TcxPCNavigatorButtonContentParameters);
begin
  inherited CalculateButtonContentParameters(AButton, AParameters);
  AParameters.Enabled := True;
  AParameters.LiteStyle := AButton = nbClose;
end;

function TcxPCSlantedPainter.CalculateTabNormalWidth(Tab: TcxTab): Integer;
begin
  Result := 0;
  if not Tab.Visible then
    Exit;
  if ParentInfo.TabWidth > 0 then
    Result := ParentInfo.TabWidth
  else
  begin
    Result := GetTabNormalWidth(Tab.VisibleIndex);
    if Tab.Caption <> '' then
    begin
      Inc(Result, TextSize(Tab, Tab.Caption).cx);
      if IsTabHasImage(Tab.VisibleIndex) or IsAssignedImages and ParentInfo.Rotate then
        Inc(Result, GetImageTextDistance(Tab.VisibleIndex));
    end;
  end;
  if Result < GetMinTabNormalWidth(Tab.VisibleIndex)then
    Result := GetMinTabNormalWidth(Tab.VisibleIndex);
end;

procedure TcxPCSlantedPainter.FillDisplayRect;
var
  R: TRect;
begin
  R := GetClientRect;
  if ParentInfo.IsTabsContainer then
    ExtendRect(R, RotateRect(Rect(0, -TabsContainerOffset, 0, 0), ParentInfo.TabPosition));
  ParentInfo.Canvas.Brush.Style := bsSolid;
  ParentInfo.Canvas.Brush.Color := GetClientColor;
  ParentInfo.Canvas.FillRect(R);
end;

function TcxPCSlantedPainter.GetButtonColor(AButtonState: TcxPCNavigatorButtonState): TColor;
begin
  if AButtonState = nbsHotTrack then
    Result := GetMiddleRGB(clBtnFace(*ParentInfo.Color*), clWhite, 35)
  else
    if AButtonState = nbsPressed then
      Result := GetMiddleRGB(clBtnFace(*ParentInfo.Color*), clBlack, 90)
    else
      Result := clBtnFace(*ParentInfo.Color*);
end;

function TcxPCSlantedPainter.GetButtonContentColor(
  AButtonState: TcxPCNavigatorButtonState): TColor;
begin
  if (AButtonState = nbsDisabled) or not ParentControl.Enabled then
    Result := clBtnShadow
  else
    if AButtonState = nbsPressed then
      Result := GetMiddleRGB(ParentInfo.Color, clWhite, 10)
    else
      Result := clBtnText;
end;

function TcxPCSlantedPainter.GetButtonContentPosition(
  AButton: TcxPCNavigatorButton): TPoint;
begin
  Result := GetButtonCenteredContentPosition(AButton);
end;

function TcxPCSlantedPainter.GetButtonHeight: Integer;
begin
  Result := SlantedPainterButtonHeight;
end;

function TcxPCSlantedPainter.GetButtonsDistance(
  AButton1, AButton2: TcxPCNavigatorButton): Integer;
begin
  if IsOneOfButtons(AButton1, AButton2, nbClose) then
    Result := 3
  else
    Result := 1;
end;

function TcxPCSlantedPainter.GetButtonsRegionFromTabsOffset: Integer;
begin
  Result := 1;
end;

function TcxPCSlantedPainter.GetButtonsRegionHOffset: Integer;
begin
  if ParentInfo.IsTabsContainer then
    Result := TabsContainerOffset
  else
    Result := 1;
end;

function TcxPCSlantedPainter.GetButtonsRegionWOffset: Integer;
begin
  Result := 0;
  if ParentInfo.IsTabsContainer then
    Result := TabsContainerOffset;
end;

function TcxPCSlantedPainter.GetButtonWidth(Button: TcxPCNavigatorButton): Integer;
begin
  Result := SlantedPainterButtonWidthA[Button];
end;

function TcxPCSlantedPainter.GetClientColor: TColor;
begin
  if not ParentInfo.IsTabsContainer or (ParentInfo.MainTabVisibleIndex = -1) then
    Result := inherited GetClientColor
  else
  begin
    Result := GetTabColor(ParentInfo.MainTabVisibleIndex);
    if Result = clDefault then
      if ParentInfo.IsTabsContainer then
        Result := cxPCTabBodyColor
      else
        Result := ParentInfo.Color;
  end;
end;

function TcxPCSlantedPainter.GetClientRectOffset: TRect;
begin
  Result := inherited GetClientRectOffset;
  if not ParentInfo.HideTabs and (ParentInfo.RowCount > 0) and ParentInfo.IsTabsContainer then
    Inc(Result.Top, TabsContainerOffset);
  if not NeedShowFrame and not ParentInfo.HideTabs and (ParentInfo.RowCount > 0) then
  begin
    Inc(Result.Top);
    if ParentInfo.TabsOnBothSides then
      Inc(Result.Bottom);
  end;
end;

function TcxPCSlantedPainter.GetDefaultTabNormalHeight: Integer;
begin
  Result := 0;
end;

function TcxPCSlantedPainter.GetDrawImageOffset(TabVisibleIndex: Integer): TRect;
begin
  if ParentInfo.Rotate then
    if (ParentInfo.TabSlants.Kind = skSlant) or (ParentInfo.TabSlants.Positions = []) then
    begin
      Result.Top := GetFrameWidth + 1;
      Result.Bottom := GetFrameWidth + 1;
    end
    else
    begin
      Result.Top := GetFrameWidth + 2;
      Result.Bottom := GetFrameWidth + 2;
    end
  else
    Result := Rect(0, SlantedPainterTabStateMarkWidth + GetFrameWidth, 0, 1);
end;

function TcxPCSlantedPainter.GetDrawTextHOffset(TabVisibleIndex: Integer): TRect;
begin
  if ParentInfo.Rotate then
    Result := Rect(0, GetFrameWidth + 3, 0, GetFrameWidth + 1)
  else
    Result := Rect(0, SlantedPainterTabStateMarkWidth + GetFrameWidth + 1, 0, 1);
end;

function TcxPCSlantedPainter.GetFrameWidth: Integer;
begin
  Result := 1;
end;

function TcxPCSlantedPainter.GetImageTextDistance(ATabVisibleIndex: Integer): Integer;
begin
  Result := 3;
end;

function TcxPCSlantedPainter.GetMinTabNormalWidth(ATabVisibleIndex: Integer): Integer;
begin
  Result := GetTabNormalWidth(ATabVisibleIndex);
end;

function TcxPCSlantedPainter.GetTabBodyColor(
  TabVisibleIndex: Integer): TColor;
var
  ATab: TcxTab;
begin
  ATab := ParentInfo.VisibleTabs[TabVisibleIndex];
  if ATab.Highlighted then
    Result := HighlightedTabBodyColor
  else
  begin
    Result := GetTabColor(TabVisibleIndex);
    if Result = clDefault then
      if ParentInfo.IsTabsContainer then
        Result := cxPCTabBodyColor
      else
        Result := ParentInfo.Color;
  end;
end;

function TcxPCSlantedPainter.GetTabClipRgn(ATabVisibleIndex: Integer): TcxRegion;
var
  ATab: TcxTab;
begin
  ATab := ParentInfo.VisibleTabs[ATabVisibleIndex];
  Result := InternalGetTabClipRegion(ATabVisibleIndex, False);
  Result.Combine(TcxRegion.Create(ATab.VisibleRect), roIntersect);
  if ParentInfo.VisibleTabs[ATabVisibleIndex].IsMainTab then
    Result.Combine(TcxRegion.Create(GetTabUnderlineRect(ATab)), roAdd);
end;

function TcxPCSlantedPainter.GetTabContentWOffset(ATabVisibleIndex: Integer): TcxPCWOffset;

  function GetCutSideOffset: Integer;
  begin
    if ParentInfo.TabSlants.Kind = skSlant then
      Result := GetCutValue
    else
      Result := CutCornerSize;
  end;

const
  AContentOffset = 2;
var
  ATab: TcxTab;
begin
  if ParentInfo.Rotate then
  begin
    Result.Left := AContentOffset;
    Result.Right := AContentOffset + SlantedPainterTabStateMarkWidth + GetFrameWidth;
    if (ParentInfo.TabSlants.Kind = skCutCorner) and (ParentInfo.TabSlants.Positions <> []) then
      Inc(Result.Right);

    ATab := ParentInfo.VisibleTabs[ATabVisibleIndex];
    if (ATab.PaintingPosition = tpTop) and (GetTextRotationAngle(ParentControl) = raMinus90) or
      (ATab.PaintingPosition = tpBottom) and (GetTextRotationAngle(ParentControl) = raPlus90) or
      (ATab.PaintingPosition = tpLeft) then
        ExchangeLongWords(Result.Left, Result.Right);
  end
  else
  begin
    Result.Left := AContentOffset + GetFrameWidth;
    Result.Right := AContentOffset + GetFrameWidth;
    if spLeft in ParentInfo.TabSlants.Positions then
      Result.Left := GetCutSideOffset;
    if spRight in ParentInfo.TabSlants.Positions then
      Result.Right := GetCutSideOffset;
    if GetTextRotationAngle(ParentControl) = raMinus90 then
      ExchangeLongWords(Result.Left, Result.Right);
  end;
end;

function TcxPCSlantedPainter.GetTabNormalWidth(ATabVisibleIndex: Integer): Integer;
begin
  with GetTabContentWOffset(ATabVisibleIndex) do
    Result := Left + Right;
  if IsAssignedImages and ((ATabVisibleIndex = -1) or IsTabHasImage(ATabVisibleIndex) or ParentInfo.Rotate) then
    Inc(Result, GetTabImageSize.cx);
  Result := Max(Result, GetGeometricalMinTabWidth);
end;

function TcxPCSlantedPainter.GetTabsContainerOffsets: TRect;
begin
  Result := cxEmptyRect;
  if not ParentInfo.IsTabsContainer then
    Exit;
  Result := Rect(0, TabsContainerOffset, 0, 0);
  case ParentInfo.TabPosition of
    tpTop, tpLeft:
      begin
        Result.Left := TabsContainerOffset - Integer(spLeft in SlantedSides);
        Result.Right := TabsContainerOffset - Integer(spRight in SlantedSides);
      end;
    tpBottom, tpRight:
      begin
        Result.Left := TabsContainerOffset - Integer(spRight in SlantedSides);
        Result.Right := TabsContainerOffset - Integer(spLeft in SlantedSides);
      end;
  end;
end;

function TcxPCSlantedPainter.GetTabsNormalDistance: TcxPCDistance;

  function GetSlantCount: Integer;
  begin
    Result := 0;
    if spLeft in SlantedSides then
      Inc(Result);
    if spRight in SlantedSides then
      Inc(Result);
  end;

begin
  Result.dh := -3;
  if SlantedSides = [] then
    Result.dw := 1
  else
    Result.dw := -(GetCutValue div 2) * GetSlantCount;
  if ParentInfo.Rotate then
    RotateTabsDistance(Result);
end;

function TcxPCSlantedPainter.GetTabsRectOffset: TRect;
begin
  Result := cxEmptyRect;
  if spLeft in SlantedSides then
  begin
    if ParentInfo.TabPosition in [tpTop, tpBottom] then
      Result.Left := 1
    else
      Result.Bottom := 1;
  end;
  if spRight in SlantedSides then
  begin
    if ParentInfo.TabPosition in [tpTop, tpBottom] then
      Result.Right := 1
    else
      Result.Top := 1;
  end;
end;

function TcxPCSlantedPainter.GetTooNarrowTabContentWOffset(ATabVisibleIndex: Integer): TcxPCWOffset;
begin
  Result := GetTabContentWOffset(ATabVisibleIndex);
end;

procedure TcxPCSlantedPainter.Init;
begin
  inherited Init;
  FCutValue := InternalGetCutValue;
end;

function TcxPCSlantedPainter.InternalCalculateTabNormalHeight: Integer;

  function GetDrawImageTotalHOffset: Integer;
  begin
    Result := GetDrawImageOffset(-1).Top + GetDrawImageOffset(-1).Bottom;
  end;

  function GetDrawTextTotalHOffset: Integer;
  begin
    Result := GetDrawTextHOffset(-1).Top + GetDrawTextHOffset(-1).Bottom;
  end;

begin
  Result := GetMaxTabCaptionHeight + GetDrawTextTotalHOffset;
  if Result < GetTabImageSize.cy + GetDrawImageTotalHOffset then
    Result := GetTabImageSize.cy + GetDrawImageTotalHOffset;
end;

function TcxPCSlantedPainter.IsOverTab(TabVisibleIndex: Integer; X, Y: Integer): Boolean;
var
  ARegion: TcxRegion;
  AFirstIndex, ALastIndex: Integer;
begin
  ARegion := GetTabClipRgn(TabVisibleIndex);
  Result := ARegion.PtInRegion(X, Y);
  ARegion.Free;

  if Result then
  begin
    InitializeVisibleTabRange(ParentControl, AFirstIndex, ALastIndex);
    if (TabVisibleIndex + 1 <= ALastIndex) and
      ParentInfo.VisibleTabs[TabVisibleIndex + 1].IsMainTab then
    begin
      ARegion := GetTabClipRgn(TabVisibleIndex + 1);
      Result := not ARegion.PtInRegion(X, Y);
      ARegion.Free;
    end;
  end;
end;

function TcxPCSlantedPainter.IsTabBorderThick(ATabVisibleIndex: Integer): Boolean;
begin
  Result := False;
end;

procedure TcxPCSlantedPainter.PaintButtonFrame(var ARect: TRect;
  AButtonState: TcxPCNavigatorButtonState);

  function GetFrameColor: TColor;
  begin
    if AButtonState in [nbsNormal, nbsDisabled] then
      Result := clBtnShadow
    else
      Result := clBlack;
  end;

begin
  ParentInfo.Canvas.DrawComplexFrame(ARect, GetFrameColor, GetFrameColor);
  InflateRect(ARect, -1, -1);
end;

procedure TcxPCSlantedPainter.PaintFrame;
var
  AFrameRect: TRect;
begin
  AFrameRect := GetClientRect;
  InflateRect(AFrameRect, 1, 1);
  if ParentInfo.IsTabsContainer then
    ExtendRect(AFrameRect, RotateRect(Rect(0, -TabsContainerOffset, 0, 0), ParentInfo.TabPosition));
  ParentInfo.Canvas.FrameRect(AFrameRect, GetFrameColor);
end;

procedure TcxPCSlantedPainter.PaintTabShape(ATab: TcxTab; ATabVisibleIndex: Integer);

  procedure DrawFocusRect;
  var
    R: TRect;
  begin
    R := FOutTabImageAndTextData.TabTextRect;
    if not IsRectEmpty(R) then
    begin
      case GetTextRotationAngle(ParentControl) of
        ra0:
          ExtendRect(R, Rect(-3, -2, -3, -2));
        raPlus90:
          ExtendRect(R, Rect(-2, -3, -2, -3));
        raMinus90:
          ExtendRect(R, Rect(-2, -3, -2, -3));
      end;

      ParentInfo.Canvas.Brush.Color := GetTabBodyColor(ATabVisibleIndex);
      InternalDrawFocusRect(ATabVisibleIndex, R);
    end;
  end;

var
  R: TRect;
begin
  SaveClipRgn;
  try
    R := ATab.FullRect;
    PaintTabFrame(ATabVisibleIndex, R);
    ParentInfo.Canvas.SetClipRegion(InternalGetTabClipRegion(ATabVisibleIndex, True), roIntersect);
    PaintTabStateMark(ATabVisibleIndex);
    DrawBackground(ParentInfo.Canvas.Canvas, R, ATabVisibleIndex, ATab.PaintingPosition in [tpLeft, tpRight], False);
  finally
    RestoreClipRgn;
  end;
  if ParentInfo.VisibleTabs[ATabVisibleIndex].IsMainTab then
    DrawTabUnderline(ATabVisibleIndex);
  DrawFocusRect;
end;

procedure TcxPCSlantedPainter.PaintTabsRegion;

  procedure DrawLineBorder(ATabIndexInterval: TcxPCIndexInterval; AIsUpperLine, AIsLowerLine: Boolean);
  var
    ALineRect: TRect;
    ALeftSide, ARightSide, ABottomSide: TcxBorder;
    ATabInLine: TcxTab;
  begin
    ATabInLine := ParentInfo.VisibleTabs[ATabIndexInterval.Left];
    ALineRect := GetExtendedRect(GetTabsLineRect(ATabIndexInterval, AIsLowerLine),
      Rect(0, -GetTabsNormalDistance.dh, 0, -1), ATabInLine.PaintingPosition);

    case ATabInLine.PaintingPosition of
      tpTop:
        begin
          ALeftSide := bLeft;
          ARightSide := bRight;
          ABottomSide := bBottom;
        end;
      tpBottom:
        begin
          ALeftSide := bLeft;
          ARightSide := bRight;
          ABottomSide := bTop;
        end;
      tpLeft:
        begin
          ALeftSide := bBottom;
          ARightSide := bTop;
          ABottomSide := bRight;
        end;
    else
      begin
        ALeftSide := bBottom;
        ARightSide := bTop;
        ABottomSide := bLeft;
      end;
    end;

    if (spLeft in SlantedSides) and not AIsUpperLine then
      DrawBorder(ParentInfo.Canvas, ALineRect, ALeftSide, [GetFrameColor], True);
    if (spRight in SlantedSides) and not AIsUpperLine then
      DrawBorder(ParentInfo.Canvas, ALineRect, ARightSide, [GetFrameColor], True);
    DrawBorder(ParentInfo.Canvas, ALineRect, ABottomSide, [GetFrameColor], True);
  end;

  procedure PaintLine(ATabIndexInterval: TcxPCIndexInterval; AIsUpperLine, AIsLowerLine: Boolean);
  var
    I: Integer;
  begin
    for I := ATabIndexInterval.Left to ATabIndexInterval.Right do
      if I <> ParentInfo.MainTabVisibleIndex then
        PaintTab(I);
    DrawLineBorder(ATabIndexInterval, AIsUpperLine, AIsLowerLine);
  end;

var
  J: Integer;
  ALineIndexBoundsA: TcxPCLineIndexBoundsArray;
  AFirstIndex, AlastIndex: Integer;
begin
  InitializeVisibleTabRange(ParentControl, AFirstIndex, AlastIndex);

  if (ParentInfo.MainTabVisibleIndex <> -1) and
    (AFirstIndex <= ParentInfo.MainTabVisibleIndex) and
    (ParentInfo.MainTabVisibleIndex <= AlastIndex) then
    PaintTab(ParentInfo.MainTabVisibleIndex);

  InitializeLineBoundsArray(ParentControl, ALineIndexBoundsA);

  for J := ParentInfo.TopOrLeftPartRowCount - 1 downto 0 do
    PaintLine(ALineIndexBoundsA[J], J = 0, J = ParentInfo.TopOrLeftPartRowCount - 1);

  for J := ParentInfo.TopOrLeftPartRowCount to ParentInfo.RowCount - 1 do
    PaintLine(ALineIndexBoundsA[J], J = ParentInfo.RowCount - 1, J = ParentInfo.TopOrLeftPartRowCount);
end;

procedure TcxPCSlantedPainter.PrepareDrawTabContentBitmapBackground(ABitmap: TBitmap;
  const ABitmapPos: TPoint; ATabVisibleIndex: Integer);
var
  P: TPoint;
  R: TRect;
begin
  R := ParentInfo.VisibleTabs[ATabVisibleIndex].FullRect;
  P := ABitmapPos;
  if IsVerticalText(ParentControl) then
  begin
    R := Rect(R.Top, R.Left, R.Bottom, R.Right);
    P := Point(P.Y, P.X);
  end;

  if ParentInfo.Rotate and (GetTextRotationAngle(ParentControl) = raPlus90) then
    OffsetRect(R, -R.Left + P.X + ABitmap.Width - R.Right, -P.Y)
  else if not ParentInfo.Rotate and (GetTextRotationAngle(ParentControl) = raMinus90) then
    OffsetRect(R, -P.X, -R.Top - (R.Bottom - P.Y - ABitmap.Height))
  else
    OffsetRect(R, -P.X, -P.Y);
  DrawBackground(ABitmap.Canvas, R, ATabVisibleIndex, ParentInfo.Rotate,
    not ParentInfo.Rotate and (GetTextRotationAngle(ParentControl) = raMinus90) or
    ParentInfo.Rotate and (GetTextRotationAngle(ParentControl) = raPlus90));
end;

function TcxPCSlantedPainter.CanLightMainTab: Boolean;
begin
  Result := False;
end;

function TcxPCSlantedPainter.DirectionalGetFigureRegion(const R: TRect;
  APoints: array of TPoint; ALinePositions: array of TLinePosition;
  ATabPositon: TcxTabPosition; AForContent: Boolean): TcxRegion;

  procedure CorrectPolylineEnd(AIndex: Integer);
  begin
    with APoints[AIndex] do
      case ALinePositions[High(ALinePositions)] of
        lpL:
          Dec(Y);
        lpLT:
          begin
            Inc(X);
            Dec(Y);
          end;
        lpT:
          Inc(X);
        lpRT:
          begin
            Inc(X);
            Inc(Y);
          end;
        lpR:
          Inc(Y);
        lpRB:
          begin
            Dec(X);
            Inc(Y);
          end;
        lpB:
          Dec(X);
        lpLB:
          begin
            Dec(X);
            Dec(Y);
          end;
      end;
  end;

  procedure CorrectPolylineEnds;
  begin
    CorrectPolylineEnd(High(APoints));
    if (ATabPositon = tpLeft) and (ALinePositions[0] = lpLB) then
    begin
      Inc(APoints[0].X);
      Inc(APoints[0].Y);
    end;
  end;

  procedure ReorderPoints;
  const
    ALinePositionConversionTable: array[TcxTabPosition, TLinePosition] of TLinePosition = (
      (lpL, lpLT, lpT, lpRT, lpR, lpRB, lpB, lpLB),
      (lpL, lpLB, lpB, lpRB, lpR, lpRB, lpB, lpLB),
      (lpB, lpLB, lpL, lpLT, lpT, lpRB, lpB, lpLB),
      (lpB, lpRB, lpR, lpRT, lpT, lpRB, lpB, lpLB)
    );
  var
    ALinePosition: TLinePosition;
    I: Integer;
    P: TPoint;
  begin
    case ATabPositon of
      tpBottom, tpRight:
        begin
          for I := 0 to Length(APoints) div 2 - 1 do
          begin
            P := APoints[I];
            APoints[I] := APoints[High(APoints) - I];
            APoints[High(APoints) - I] := P;
          end;
          for I := 0 to Length(ALinePositions) div 2 - 1 do
          begin
            ALinePosition := ALinePositions[I];
            ALinePositions[I] := ALinePositions[High(ALinePositions) - I];
            ALinePositions[High(ALinePositions) - I] := ALinePosition;
          end;
        end;
    end;
    for I := 0 to High(ALinePositions) do
      ALinePositions[I] := ALinePositionConversionTable[ATabPositon, ALinePositions[I]];
  end;

begin
  RotatePolyline(R, APoints, ATabPositon);
  ReorderPoints;
  CorrectPolylineEnds;
  Result := GetFigureRegion(APoints, ALinePositions, AForContent);
end;

procedure TcxPCSlantedPainter.DrawBackground(ACanvas: TCanvas; R: TRect;
  ATabVisibleIndex: Integer; AHorizontalGradient, AInverseGradient: Boolean);
var
  AColor1, AColor2: TColor;
  ATab: TcxTab;
begin
  ATab := ParentInfo.VisibleTabs[ATabVisibleIndex];
  if ATab.IsMainTab and not (CanLightMainTab and ATab.HotTrack) then
  begin
    ACanvas.Brush.Color := GetTabBodyColor(ATabVisibleIndex);
    ACanvas.FillRect(R);
  end
  else
  begin
    if pcoGradient in ParentInfo.Options then
      GetBackgroundGradientColors(ATabVisibleIndex, AColor1, AColor2)
    else
    begin
      AColor1 := GetTabBodyColor(ATabVisibleIndex);
      AColor2 := AColor1;
    end;
    if CanLightMainTab and ATab.IsMainTab and ATab.HotTrack and
      (ATab.PaintingPosition in [tpBottom, tpRight]) then
        ExchangeLongWords(AColor1, AColor2);
    if AInverseGradient then
      ExchangeLongWords(AColor1, AColor2);
    FillGradientRect(ACanvas.Handle, R, AColor1, AColor2, AHorizontalGradient);
  end;
end;

procedure TcxPCSlantedPainter.DrawTabUnderline(ATabVisibleIndex: Integer);
var
  AFrameColor: TColor;
  ARHeight, ARWidth: Integer;
  ATab: TcxTab;
  P: TPoint;
  R: TRect;
begin
  ATab := ParentInfo.VisibleTabs[ATabVisibleIndex];
  AFrameColor := GetFrameColor;
  ParentInfo.Canvas.Brush.Color := GetTabBodyColor(ATabVisibleIndex);
  ParentInfo.Canvas.FillRect(GetTabUnderlineRect(ATab));

  if ATab.IsMainTab then
  begin
    R := ATab.FullRect;
    if not (spLeft in SlantedSides) then
    begin
      P := Point(R.Left, R.Bottom);
      RotatePoint(R, P, ATab.PaintingPosition);
      ParentInfo.Canvas.Pixels[P.X, P.Y] := AFrameColor;
    end;
    if not (spRight in SlantedSides) then
    begin
      GetRectSize(R, ATab.PaintingPosition in [tpTop, tpBottom], ARWidth, ARHeight);
      P := Point(R.Left + ARWidth - 1, R.Bottom);
      RotatePoint(R, P, ATab.PaintingPosition);
      ParentInfo.Canvas.Pixels[P.X, P.Y] := AFrameColor;
    end;
  end;
end;

procedure TcxPCSlantedPainter.GetBackgroundGradientColors(ATabVisibleIndex: Integer;
  out AColor1, AColor2: TColor);
var
  ATabColor: TColor;
begin
  ATabColor := GetTabBodyColor(ATabVisibleIndex);
  if ParentInfo.VisibleTabs[ATabVisibleIndex].HotTrack then
  begin
    AColor1 := Light(ATabColor, 20);
    AColor2 := ATabColor;
  end
  else
  begin
    AColor1 := Light(ATabColor, 13);
    AColor2 := Dark(ATabColor, 90);
  end;
end;

function TcxPCSlantedPainter.GetCutValue: Integer;
begin
  Result := FCutValue;
end;

function TcxPCSlantedPainter.GetGeometricalMinTabWidth: Integer;

  function GetCutSideCount: Integer;
  begin
    Result := 0;
    if spLeft in ParentInfo.TabSlants.Positions then
      Inc(Result);
    if spRight in ParentInfo.TabSlants.Positions then
      Inc(Result);
  end;

const
  MinContentWidth = 4;
  RoundedCornerSideWidth = 2;
begin
  if ParentInfo.Rotate then
  begin
    Result := 0;
    Exit;
  end;

  if ParentInfo.TabSlants.Positions = [] then
    Result := RoundedCornerSideWidth * 2
  else
  begin
    Result := 0;
    Inc(Result, GetCutValue * GetCutSideCount);
    if ParentInfo.TabSlants.Kind = skSlant then
      Inc(Result, RoundedCornerSideWidth * (2 - GetCutSideCount))
    else
      Inc(Result, GetFrameWidth * (2 - GetCutSideCount));
  end;
  Inc(Result, MinContentWidth);
end;

function TcxPCSlantedPainter.GetFrameColor: TColor;
begin
  Result := clBtnShadow;
end;

function TcxPCSlantedPainter.GetSlantedSides: TcxTabSlantPositions;
begin
  if (ParentInfo.TabSlants.Kind = skSlant) and not ParentInfo.Rotate then
    Result := ParentInfo.TabSlants.Positions
  else
    Result := [];
end;

procedure TcxPCSlantedPainter.GetTabFramePolyline(ATabVisibleIndex: Integer;
  out APoints: TPoints; out ALinePositions: TLinePositions);
var
  ARHeight, ARWidth: Integer;
  ATab: TcxTab;
  R: TRect;
begin
  ATab := ParentInfo.VisibleTabs[ATabVisibleIndex];
  R := ATab.FullRect;
  GetRectSize(R, ATab.PaintingPosition in [tpTop, tpBottom], ARWidth, ARHeight);

  SetLength(APoints, 0);
  SetLength(ALinePositions, 0);
  if (spLeft in ParentInfo.TabSlants.Positions) and (not ParentInfo.Rotate or (ParentInfo.TabSlants.Kind = skCutCorner)) then
  begin
    if ParentInfo.TabSlants.Kind = skSlant then
      AddPoints(APoints, [Point(R.Left, R.Bottom - 1), Point(R.Left + (ARHeight - 1),
        R.Bottom - ARHeight)], ALinePositions, [lpLT])
    else
      AddPoints(APoints, [Point(R.Left, R.Bottom - 1), Point(R.Left, R.Bottom - ARHeight + CutCornerSize),
        Point(R.Left + CutCornerSize, R.Bottom - ARHeight)], ALinePositions, [lpL, lpLT]);
  end
  else
    if (ParentInfo.TabSlants.Kind = skSlant) or (ParentInfo.TabSlants.Positions = []) then
      AddPoints(APoints, [Point(R.Left, R.Bottom - 1), Point(R.Left, R.Bottom - ARHeight + 2),
        Point(R.Left + 2, R.Bottom - ARHeight)], ALinePositions, [lpL, lpLT])
    else
      AddPoints(APoints, [Point(R.Left, R.Bottom - 1), Point(R.Left, R.Bottom - ARHeight)],
        ALinePositions, [lpL]);

  if (spRight in ParentInfo.TabSlants.Positions) and (not ParentInfo.Rotate or (ParentInfo.TabSlants.Kind = skCutCorner)) then
  begin
    if ParentInfo.TabSlants.Kind = skSlant then
      AddPoints(APoints, [Point(ARWidth + R.Left - 1 - (ARHeight - 1), R.Bottom - ARHeight),
        Point(ARWidth + R.Left - 1, R.Bottom - 1)], ALinePositions, [lpT, lpRT])
    else
      AddPoints(APoints, [Point(ARWidth + R.Left - CutCornerSize - 1, R.Bottom - ARHeight),
        Point(ARWidth + R.Left - 1, R.Bottom - ARHeight + CutCornerSize), Point(ARWidth + R.Left - 1, R.Bottom - 1)],
        ALinePositions, [lpT, lpRT, lpR]);
  end
  else
    if (ParentInfo.TabSlants.Kind = skSlant) or (ParentInfo.TabSlants.Positions = []) then
      AddPoints(APoints, [Point(ARWidth + R.Left - 3, R.Bottom - ARHeight),
        Point(ARWidth + R.Left - 1, R.Bottom - ARHeight + 2), Point(ARWidth + R.Left - 1, R.Bottom - 1)],
        ALinePositions, [lpT, lpRT, lpR])
    else
      AddPoints(APoints, [Point(ARWidth + R.Left - 1, R.Bottom - ARHeight),
        Point(ARWidth + R.Left - 1, R.Bottom - 1)], ALinePositions, [lpT, lpR]);
end;

function TcxPCSlantedPainter.GetTabImageSize: TSize;

  function CorrectSize(AValue: Integer): Integer;
  begin
    Result := AValue;
    if Result > 0 then
      Inc(Result, 2 * ParentInfo.ImageBorder);
  end;

begin
  Result.cx := CorrectSize(GetTabBaseImageSize.cx);
  Result.cy := CorrectSize(GetTabBaseImageSize.cy);
end;

function TcxPCSlantedPainter.GetVerticalTextIndent: Integer;
begin
  Result := 0;
end;

function TcxPCSlantedPainter.InternalGetCutValue: Integer;
begin
  if ParentInfo.TabSlants.Kind = skSlant then
    Result := CalculateTabNormalHeight - 1
  else
    Result := CutCornerSize;
end;

function TcxPCSlantedPainter.InternalGetTabClipRegion(ATabVisibleIndex: Integer;
  AForContent: Boolean): TcxRegion;
var
  ALinePositions: TLinePositions;
  APoints: TPoints;
begin
  GetTabFramePolyline(ATabVisibleIndex, APoints, ALinePositions);
  Result := DirectionalGetFigureRegion(ParentInfo.VisibleTabs[ATabVisibleIndex].FullRect,
    APoints, ALinePositions, ParentInfo.VisibleTabs[ATabVisibleIndex].PaintingPosition, AForContent);
end;

procedure TcxPCSlantedPainter.PaintTabFrame(ATabVisibleIndex: Integer;
  const R: TRect);
var
  ARHeight, ARWidth: Integer;
  ATabPaintingPosition: TcxTabPosition;
  ALinePositions: TLinePositions;
  APoints: TPoints;
begin
  ATabPaintingPosition := ParentInfo.VisibleTabs[ATabVisibleIndex].PaintingPosition;
  GetRectSize(R, ATabPaintingPosition in [tpTop, tpBottom], ARWidth, ARHeight);
  GetTabFramePolyline(ATabVisibleIndex, APoints, ALinePositions);
  DirectionalPolyline(R, APoints, ATabPaintingPosition, GetFrameColor);
end;

procedure TcxPCSlantedPainter.PaintTabStateMark(ATabVisibleIndex: Integer);
var
  ATab: TcxTab;
  R: TRect;
begin
  ATab := ParentInfo.VisibleTabs[ATabVisibleIndex];
  if ATab.HotTrack or ATab.IsMainTab then
  begin
    SubtractRect(R, ATab.FullRect,
      GetExtendedRect(ATab.FullRect, Rect(0, GetFrameWidth + SlantedPainterTabStateMarkWidth, 0, 0), ATab.PaintingPosition));
    ParentInfo.Canvas.Brush.Color := clHighlight;
    ParentInfo.Canvas.FillRect(R);
    ParentInfo.Canvas.ExcludeClipRect(R);
  end;
end;

function TcxPCSlantedPainter.GetTabsLineRect(ATabIndexInterval: TcxPCIndexInterval; AFullRect: Boolean): TRect;

  procedure ExchangeTabs(var ALeftTab, ARightTab: TcxTab);
  var
    AExchangeTab: TcxTab;
  begin
    AExchangeTab := ALeftTab;
    ALeftTab := ARightTab;
    ARightTab := AExchangeTab;
  end;

var
  ALeftTab, ARightTab: TcxTab;
begin
  ALeftTab := ParentInfo.VisibleTabs[ATabIndexInterval.Left];
  ARightTab := ParentInfo.VisibleTabs[ATabIndexInterval.Right];
  Result := ALeftTab.VisibleRect;
  case ParentInfo.TabPosition of
    tpTop, tpBottom:
      begin
        if IsRightToLeftAlignment(ParentControl) then
          ExchangeTabs(ALeftTab, ARightTab);

        if not AFullRect and not (spLeft in SlantedSides) then
          Result.Left := ALeftTab.VisibleRect.Left
        else
          Result.Left := 0;
        if not AFullRect and not (spRight in SlantedSides) then
          Result.Right := ARightTab.VisibleRect.Right
        else
          Result.Right := ParentControl.Width;
      end;
    tpLeft, tpRight:
      begin
        if not IsBottomToTopAlignment(ParentControl) then
          ExchangeTabs(ALeftTab, ARightTab);

        if not AFullRect and not (spRight in SlantedSides) then
          Result.Top := ARightTab.VisibleRect.Top
        else
          Result.Top := 0;
        if not AFullRect and not (spLeft in SlantedSides) then
          Result.Bottom := ALeftTab.VisibleRect.Bottom
        else
          Result.Bottom := ParentControl.Height;
      end;
  end;
end;

function TcxPCSlantedPainter.GetTabUnderlineRect(ATab: TcxTab): TRect;
begin
  SubtractRect(Result,
    GetExtendedRect(ATab.VisibleRect, Rect(0, 0, 0, -1), ATab.PaintingPosition),
    ATab.VisibleRect);
end;

{ TcxPCOneNotePainter }

class function TcxPCOneNotePainter.GetStyleID: TcxPCStyleID;
begin
  Result := cxPCOneNoteStyle;
end;

class function TcxPCOneNotePainter.GetStyleName: TCaption;
begin
  Result := 'OneNote';
end;

class function TcxPCOneNotePainter.HasLookAndFeel(ALookAndFeel: TcxLookAndFeel): Boolean;
begin
  Result := False;
end;

class function TcxPCOneNotePainter.AllowRotate: Boolean;
begin
  Result := False;
end;

function TcxPCOneNotePainter.CanLightMainTab: Boolean;
begin
  Result := True;
end;

procedure TcxPCOneNotePainter.DrawTabUnderline(ATabVisibleIndex: Integer);
var
  AColor: TColor;
  ARWidth, ARHeight: Integer;
  ATab: TcxTab;
  R: TRect;
begin
  ATab := ParentInfo.VisibleTabs[ATabVisibleIndex];
  if ATab.IsMainTab then
    AColor := GetTabBodyColor(ATabVisibleIndex)//ParentInfo.PageColors[ATabVisibleIndex]
  else
    AColor := GetFrameColor;
  R := ATab.FullRect;
  GetRectSize(R, ATab.PaintingPosition in [tpTop, tpBottom], ARWidth, ARHeight);
  DirectionalPolyline(R, [Point(R.Left, R.Bottom), Point(R.Left, R.Bottom)],
    ATab.PaintingPosition, GetMiddleRGB(GetFrameColor, AColor, 50));
  DirectionalPolyline(R, [Point(R.Left + 1, R.Bottom), Point(R.Left + ARWidth - 1, R.Bottom)],
    ATab.PaintingPosition, AColor);
end;

procedure TcxPCOneNotePainter.GetBackgroundGradientColors(ATabVisibleIndex: Integer;
  out AColor1, AColor2: TColor);
var
  ATabColor: TColor;
begin
  ATabColor := GetTabBodyColor(ATabVisibleIndex);
  if ParentInfo.VisibleTabs[ATabVisibleIndex].HotTrack then
  begin
    AColor1 := Light(ATabColor, 20);
    AColor2 := ATabColor;
  end
  else
  begin
    AColor1 := Light(ATabColor, 13);
    AColor2 := Dark(ATabColor, 90);
  end;
end;

function TcxPCOneNotePainter.GetButtonsRegionHOffset: Integer;
begin
  Result := 0;
  if ParentInfo.IsTabsContainer then
    Result := TabsContainerOffset;
end;

function TcxPCOneNotePainter.GetDrawImageOffset(TabVisibleIndex: Integer): TRect;
begin
  Result := Rect(0, OneNotePainterTabFrameWidth + 1, 0, 1);
end;

function TcxPCOneNotePainter.GetDrawTextHOffset(TabVisibleIndex: Integer): TRect;
begin
  Result := Rect(0, OneNotePainterTabFrameWidth + 2, 0, 1);
end;

function TcxPCOneNotePainter.GetFrameColor: TColor;
begin
  Result := OneNoteMainTabBorderColor;
end;

function TcxPCOneNotePainter.GetGeometricalMinTabWidth: Integer;
const
  MinContentWidth = 2;
begin
  Result := GetCutValue + MinContentWidth + OneNotePainterTabFrameWidth;
end;

function TcxPCOneNotePainter.GetSlantedSides: TcxTabSlantPositions;
begin
  Result := [spLeft];
end;

function TcxPCOneNotePainter.GetTabContentWOffset(ATabVisibleIndex: Integer): TcxPCWOffset;
const
  AContentOffset = 2;
begin
  Result.Left := GetCutValue;
  Result.Right := AContentOffset + OneNotePainterTabFrameWidth;
  if GetTextRotationAngle(ParentControl) = raMinus90 then
    ExchangeLongWords(Result.Left, Result.Right);
end;

function TcxPCOneNotePainter.GetTabsContainerOffsets: TRect;
begin
  Result := cxEmptyRect;
  if ParentInfo.IsTabsContainer then
    Result.Top := TabsContainerOffset;
end;

function TcxPCOneNotePainter.GetTabsNormalDistance: TcxPCDistance;
begin
  Result.dh := -3;
  Result.dw := -GetCutValue + 5;
end;

function TcxPCOneNotePainter.GetTabsRectOffset: TRect;
begin
  Result := RotateRect(Rect(4, 0, 4, 0), ParentInfo.TabPosition);
end;

function TcxPCOneNotePainter.InternalGetCutValue: Integer;
begin
  Result := CalculateTabNormalHeight + 2;
end;

function TcxPCOneNotePainter.InternalGetTabClipRegion(ATabVisibleIndex: Integer;
  AForContent: Boolean): TcxRegion;
var
  APaintingPosition: TcxTabPosition;
  ARHeight, ARWidth: Integer;
  R: TRect;
begin
  ParentInfo.Canvas.BeginPath;
  R := ParentInfo.VisibleTabs[ATabVisibleIndex].FullRect;
  APaintingPosition := ParentInfo.VisibleTabs[ATabVisibleIndex].PaintingPosition;
  if AForContent then
    case APaintingPosition of
      tpTop:
        begin
          Inc(R.Top);
          Inc(R.Bottom);
          GetRectSize(R, True, ARWidth, ARHeight);
          DirectionalPolyline(R, [Point(R.Left + 2, R.Bottom - 1), Point(R.Left + (R.Bottom - R.Top - 2), R.Top + 3),
            Point(R.Left + (R.Bottom - R.Top + 2), R.Top + 1),
            Point(R.Right - 2, R.Top + 1), Point(R.Right - 2, R.Bottom - 1)], tpTop, clWhite);
        end;
      tpBottom:
        begin
          Inc(R.Left);
          DirectionalPolyline(R, [Point(R.Left + 2, R.Bottom - 1), Point(R.Left + (R.Bottom - R.Top - 3), R.Top + 4),
            Point(R.Left + (R.Bottom - R.Top + 2), R.Top + 1),
            Point(R.Right - 2, R.Top + 1), Point(R.Right - 2, R.Bottom - 1)], tpBottom, clWhite);
        end;
      tpLeft:
        begin
          Inc(R.Top);
          Inc(R.Left);
          Inc(R.Right);
          GetRectSize(R, False, ARWidth, ARHeight);
          DirectionalPolyline(R, [Point(R.Left + 2, R.Bottom - 1), Point(R.Left + (ARHeight - 2), R.Bottom - ARHeight + 3),
            Point(R.Left + (ARHeight + 2), R.Bottom - ARHeight + 1),
            Point(ARWidth + R.Left - 2, R.Bottom - ARHeight + 1), Point(ARWidth + R.Left - 2, R.Bottom - 1)], tpLeft, clWhite);
        end;
      tpRight:
        begin
          Inc(R.Top);
          GetRectSize(R, False, ARWidth, ARHeight);
          DirectionalPolyline(R, [Point(R.Left + 2, R.Bottom - 1), Point(R.Left + (ARHeight - 1), R.Bottom - ARHeight + 3),
            Point(R.Left + (ARHeight + 3), R.Bottom - ARHeight + 1),
            Point(ARWidth + R.Left - 2, R.Bottom - ARHeight + 1), Point(ARWidth + R.Left - 2, R.Bottom - 1)], tpRight, clWhite);
        end;
    end
  else
  begin
    InflateRect(R, 1, 1);
    GetRectSize(R, APaintingPosition in [tpTop, tpBottom], ARWidth, ARHeight);
    case APaintingPosition of
      tpTop:
        DirectionalPolyline(R, [Point(R.Left, R.Bottom - 2), Point(R.Left + 1, R.Bottom - 2),
          Point(R.Left + (ARHeight - 3), R.Bottom - ARHeight + 3), Point(R.Left + (ARHeight + 2), R.Bottom - ARHeight),
          Point(ARWidth + R.Left - 4, R.Bottom - ARHeight), Point(ARWidth + R.Left - 1, R.Bottom - ARHeight + 3),
          Point(ARWidth + R.Left - 1, R.Bottom - 1)], tpTop, $9C613B);
      tpBottom:
        DirectionalPolyline(R, [Point(R.Left, R.Bottom - 2), Point(R.Left + 1, R.Bottom - 2),
          Point(R.Left + (ARHeight - 3), R.Bottom - ARHeight + 3), Point(R.Left + (ARHeight + 2), R.Bottom - ARHeight),
          Point(ARWidth + R.Left - 4, R.Bottom - ARHeight), Point(ARWidth + R.Left - 1, R.Bottom - ARHeight + 3),
          Point(ARWidth + R.Left - 1, R.Bottom - 1)], tpBottom, $9C613B);
      tpLeft:
        DirectionalPolyline(R, [Point(R.Left, R.Bottom - 2), Point(R.Left + 1, R.Bottom - 2),
          Point(R.Left + (ARHeight - 3), R.Bottom - ARHeight + 3), Point(R.Left + (ARHeight + 2), R.Bottom - ARHeight),
          Point(ARWidth + R.Left - 5, R.Bottom - ARHeight), Point(ARWidth + R.Left - 1, R.Bottom - ARHeight + 4),
          Point(ARWidth + R.Left - 1, R.Bottom - 1)], tpLeft, $9C613B);
      tpRight:
        DirectionalPolyline(R, [Point(R.Left - 1, R.Bottom - 1), Point(R.Left - 1, R.Bottom - 3), Point(R.Left + 2, R.Bottom - 3),
          Point(R.Left + (ARHeight - 2), R.Bottom - ARHeight + 2), Point(R.Left + (ARHeight + 2), R.Bottom - ARHeight),
          Point(ARWidth + R.Left - 4, R.Bottom - ARHeight), Point(ARWidth + R.Left - 1, R.Bottom - ARHeight + 3),
          Point(ARWidth + R.Left - 1, R.Bottom - 1)], tpRight, $9C613B);
    end;
  end;
  ParentInfo.Canvas.EndPath;
  Result := ParentInfo.Canvas.PathToRegion;
end;

procedure TcxPCOneNotePainter.PaintTabFrame(ATabVisibleIndex: Integer;
  const R: TRect);

  procedure PrepareColors(out ABorderColor, AInnerBorderColor1, AInnerBorderColor2: TColor);
  var
    ATab: TcxTab;
  begin
    ATab := ParentInfo.VisibleTabs[ATabVisibleIndex];
    if ATab.HotTrack then
    begin
      ABorderColor := OneNoteTabHotBorderColor;
      AInnerBorderColor1 := OneNoteTabHotBorderColor;
      AInnerBorderColor2 := OneNoteTabHotBorderColor;
    end
    else
      if ATab.IsMainTab then
      begin
        ABorderColor := OneNoteMainTabBorderColor;
        AInnerBorderColor1 := GetMiddleRGB(clWhite, GetTabBodyColor(ATabVisibleIndex), 60);
        AInnerBorderColor2 := GetMiddleRGB(AInnerBorderColor1, GetTabBodyColor(ATabVisibleIndex), 70);
      end
      else
      begin
        ABorderColor := OneNoteTabBorderColor;
        AInnerBorderColor1 := GetMiddleRGB(clWhite, OneNoteTabInnerBorderColor2, 50);
        AInnerBorderColor1 := GetMiddleRGB(AInnerBorderColor1, GetTabBodyColor(ATabVisibleIndex), 50);
        AInnerBorderColor2 := GetMiddleRGB(OneNoteTabInnerBorderColor2, GetTabBodyColor(ATabVisibleIndex), 50);
      end;
  end;

  function GetColorAt(P: TPoint): TColor;
  var
    ANeighbourTabVisibleIndex: Integer;
  begin
    RotatePoint(R, P, ParentInfo.VisibleTabs[ATabVisibleIndex].PaintingPosition);
    ANeighbourTabVisibleIndex := ParentControl.VisibleIndexOfTabAt(P.X, P.Y);
    if ANeighbourTabVisibleIndex = -1 then
      Result := ParentInfo.Color
    else
      Result := GetTabBodyColor(ANeighbourTabVisibleIndex);
  end;

var
  ABorderColor, AInnerBorderColor1, AInnerBorderColor2: TColor;
  ARHeight, ARWidth: Integer;
  ATabPaintingPosition: TcxTabPosition;
begin
  ATabPaintingPosition := ParentInfo.VisibleTabs[ATabVisibleIndex].PaintingPosition;
  GetRectSize(R, ATabPaintingPosition in [tpTop, tpBottom], ARWidth, ARHeight);
  PrepareColors(ABorderColor, AInnerBorderColor1, AInnerBorderColor2);

  DirectionalPolyline(R, [Point(R.Left, R.Bottom - 1), Point(R.Left, R.Bottom - 1)],
    ATabPaintingPosition, GetMiddleRGB(ABorderColor, GetColorAt(Point(R.Left - 1, R.Bottom - 1)), 25));
  DirectionalPolyline(R, [Point(R.Left + 1, R.Bottom - 1), Point(R.Left + 1, R.Bottom - 1),
    Point(R.Left + (ARHeight - 3), R.Bottom - ARHeight + 3), Point(R.Left + (ARHeight + 2), R.Bottom - ARHeight),
    Point(ARWidth + R.Left - 3, R.Bottom - ARHeight), Point(ARWidth + R.Left - 1, R.Bottom - ARHeight + 2),
    Point(ARWidth + R.Left - 1, R.Bottom - 1)], ATabPaintingPosition, ABorderColor);
  DirectionalPolyline(R, [Point(R.Left + (ARHeight + 2), R.Bottom - ARHeight),
    Point(R.Left + (ARHeight + 2), R.Bottom - ARHeight)], ATabPaintingPosition, GetMiddleRGB(ABorderColor, GetColorAt(Point(R.Left + (ARHeight + 1), R.Bottom - ARHeight)), 60));
  DirectionalPolyline(R, [Point(R.Left + 2, R.Bottom - 1), Point(R.Left + (ARHeight - 3), R.Bottom - ARHeight + 4),
    Point(R.Left + (ARHeight + 2), R.Bottom - ARHeight + 1),
    Point(ARWidth + R.Left - 4, R.Bottom - ARHeight + 1)], ATabPaintingPosition, AInnerBorderColor1);
  DirectionalPolyline(R, [Point(ARWidth + R.Left - 3, R.Bottom - ARHeight + 1), Point(ARWidth + R.Left - 2, R.Bottom - ARHeight + 2),
    Point(ARWidth + R.Left - 2, R.Bottom - 1)], ATabPaintingPosition, AInnerBorderColor2);
end;

procedure TcxPCOneNotePainter.PaintTabStateMark(ATabVisibleIndex: Integer);
begin
  // do nothing
end;

{ TcxPaletteChangedNotifier }

procedure TcxPaletteChangedNotifier.DoChanged;
begin
  PrepareOneNoteStyleColors;
end;

initialization
  CalculateLightBrushColor;
  PrepareOneNoteStyleColors;
  FPaletteChangedNotifier := TcxPaletteChangedNotifier.Create(True);
  RegisterPCPainterClass(TcxPCTabsPainter);
  RegisterPCPainterClass(TcxPCButtonsPainter);
  RegisterPCPainterClass(TcxPCFlatButtonsPainter);
  RegisterPCPainterClass(TcxPCExtraFlatPainter);
  RegisterPCPainterClass(TcxPCUltraFlatPainter);
  RegisterPCPainterClass(TcxPCFlatPainter);
  RegisterPCPainterClass(TcxPCOffice11Painter);
  RegisterPCPainterClass(TcxPCSlantedPainter);
  RegisterPCPainterClass(TcxPCOneNotePainter);

finalization
  UnregisterPCPainterClass(TcxPCTabsPainter);
  UnregisterPCPainterClass(TcxPCButtonsPainter);
  UnregisterPCPainterClass(TcxPCFlatButtonsPainter);
  UnregisterPCPainterClass(TcxPCExtraFlatPainter);
  UnregisterPCPainterClass(TcxPCUltraFlatPainter);
  UnregisterPCPainterClass(TcxPCFlatPainter);
  UnregisterPCPainterClass(TcxPCOffice11Painter);
  UnregisterPCPainterClass(TcxPCSlantedPainter);
  UnregisterPCPainterClass(TcxPCOneNotePainter);
  FreeAndNil(FPaletteChangedNotifier);

end.

