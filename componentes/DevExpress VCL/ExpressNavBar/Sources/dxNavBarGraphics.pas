{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressNavBar                                               }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSNAVBAR AND ALL ACCOMPANYING   }
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

unit dxNavBarGraphics;

{$I cxVer.inc}

interface

uses
{$IFDEF DELPHI6}
  Types,
{$ENDIF}
  jpeg,
  Windows, Classes, Controls, CommCtrl, Graphics, ImgList,
  cxClasses, cxGraphics, dxNavBar, dxNavBarStyles, dxThemeManager;

const
  dxNavBarHintWindowSizeCorrection = 6;
  dxNavBarHintWindowTextOffset: TPoint = (X: 2; Y: 2);

type
  TXPScheme = (schUnknown, schNormalColor, schHomestead, schMetallic);
  TXPSchemeColor = schNormalColor .. schMetallic;

  TdxNavBarBackgroundPainter = class(TdxBaseBackgroundPainter)
  private
    class procedure InternalDrawGradientBackground(ACanvas: TCanvas; ARect: TRect; APicture: TPicture;
      AEraseBackground: Boolean; ABackgroundColor: TColor;
      AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
      AGradientMode: TdxBarStyleGradientMode);
  protected
    class procedure DrawPicture(ACanvas: TCanvas; ARect: TRect; APicture: TPicture);
    class procedure FillGradientRect(DC: HDC; const ARect: TRect;
      AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte; AGradientMode: TdxBarStyleGradientMode);
    class procedure InternalDrawBackground(ACanvas: TCanvas; ARect: TRect; APicture: TPicture;
      AEraseBackground: Boolean; ABackgroundColor: TColor;
      AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
      AGradientMode: TdxBarStyleGradientMode); override;
  end;

  TdxNavBarGroupBackgroundPainter = class(TdxBaseGroupBackgroundPainter)
  protected
    class procedure InternalDrawBackground(ACanvas: TCanvas; ARect: TRect; APicture: TPicture;
        AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
        AGradientMode: TdxBarStyleGradientMode); override;
  end;

  TdxNavBarExplorerBarBorderPainter = class(TdxBaseGroupBorderPainter)
  protected
    class procedure InternalDrawBorder(ACanvas: TCanvas; ARect: TRect; AColor: TColor;
      AWithCaption: Boolean); override;
  end;

  TdxNavBarImagePainter = class(TdxBaseImagePainter)
  protected
    class function GetRGBColor(Value: TColor): DWORD;
    class procedure InternalDrawImage(ACanvas: TCanvas; AImageList: TCustomImageList;
      AImageIndex: Integer; ARect: TRect; AEnabled: Boolean); override;
  end;

  TdxNavBarSelectionPainter = class(TdxBaseSelectionPainter)
  protected
    class procedure InternalDrawSelection(ACanvas: TCanvas; ARect: TRect;
        ABackColor: TColor; AState: TdxNavBarObjectStates); override;
  end;

  TdxNavBarUltraFlatSelectionPainter = class(TdxBaseSelectionPainter)
  protected
    class function FlatBarItemPressedBackColor: TColor;
    class function FlatBarItemHighLightBackColor: TColor;
    class procedure InternalDrawSelection(ACanvas: TCanvas; ARect: TRect;
        ABackColor: TColor; AState: TdxNavBarObjectStates); override;
  end;

  TdxNavBarVSToolBoxSelectionPainter = class(TdxBaseSelectionPainter)
  protected
    class procedure InternalDrawSelection(ACanvas: TCanvas; ARect: TRect;
        ABackColor: TColor; AState: TdxNavBarObjectStates); override;
  end;

  TdxNavBarExplorerBarSignPainter = class(TdxBaseSignPainter)
  protected
    class procedure DrawSignSelection(ACanvas: TCanvas; ARect: TRect; AForeColor,
        ABackColor1, ABackColor2: TColor; AState: TdxNavBarObjectStates); virtual;
    class procedure InternalDrawSign(ACanvas: TCanvas; ARect: TRect;
        AForeColor, ABackColor1, ABackColor2 : TColor; AState: TdxNavBarObjectStates); override;
  end;

  TdxNavBarAdvExplorerBarSignPainter = class(TdxNavBarExplorerBarSignPainter)
  protected
    class procedure PrepareBitmap(ACanvas: TCanvas; ARect: TRect; ABitmap: TBitmap;
      AForeColor: TColor; AState: TdxNavBarObjectStates);
    class procedure InternalDrawSign(ACanvas: TCanvas; ARect: TRect;
      AForeColor, ABackColor1, ABackColor2 : TColor; AState: TdxNavBarObjectStates); override;
  end;

  TdxNavBarOffice11SignPainter = class(TdxNavBarExplorerBarSignPainter)
  protected
    class procedure PrepareBitmap(ACanvas: TCanvas; ABitmap: TBitmap;
      ABackColor1, ABackColor2: TColor; AState: TdxNavBarObjectStates);
    class procedure InternalDrawSign(ACanvas: TCanvas; ARect: TRect;
      AForeColor, ABackColor1, ABackColor2: TColor; AState: TdxNavBarObjectStates); override;
  end;

  TdxNavBarHintPainter = class(TdxBaseHintPainter)
  protected
    class procedure InternalDrawHint(ACanvas: TCanvas; ARect: TRect; AHint: string;
        APicture: TPicture; AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
        AGradientMode: TdxBarStyleGradientMode; AFont: TFont); override;
  end;

  TdxNavBarButtonPainter = class(TdxBaseButtonPainter)
  protected
    class procedure InternalDrawButton(ACanvas: TCanvas; ARect: TRect; APicture: TPicture;
        AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
        AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor;
        AState: TdxNavBarObjectStates); override;
  end;

  TdxNavBarFlatButtonPainter = class(TdxBaseButtonPainter)
  protected
    class procedure InternalDrawButton(ACanvas: TCanvas; ARect: TRect; APicture: TPicture;
        AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
        AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor;
        AState: TdxNavBarObjectStates); override;
  end;

  TdxNavBarVSToolBoxButtonPainter = class(TdxBaseButtonPainter)
  protected
    class procedure InternalDrawButton(ACanvas: TCanvas; ARect: TRect; APicture: TPicture;
        AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
        AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor;
        AState: TdxNavBarObjectStates); override;
  end;

  TdxNavBarOfficeButtonPainter = class(TdxBaseButtonPainter)
  protected
    class procedure InternalDrawButton(ACanvas: TCanvas; ARect: TRect; APicture: TPicture;
        AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
        AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor;
        AState: TdxNavBarObjectStates); override;
  end;

  TdxNavBarOffice11NavPaneButtonPainter = class(TdxBaseButtonPainter)
  protected
    class procedure InternalDrawButton(ACanvas: TCanvas; ARect: TRect; APicture: TPicture;
        AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
        AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor;
        AState: TdxNavBarObjectStates); override;
  end;

  TdxNavBarOffice11NavPaneGroupButtonPainter = class(TdxBaseButtonPainter)
  protected
    class procedure InternalDrawButton(ACanvas: TCanvas; ARect: TRect; APicture: TPicture;
        AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
        AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor;
        AState: TdxNavBarObjectStates); override;
  end;

  TdxNavBarExplorerButtonPainter = class(TdxBaseButtonPainter)
  protected
    class procedure InternalDrawButton(ACanvas: TCanvas; ARect: TRect; APicture: TPicture;
        AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
        AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor;
        AState: TdxNavBarObjectStates); override;
  end;

  TdxNavBarAdvExplorerButtonPainter = class(TdxBaseButtonPainter)
  protected
    class procedure InternalDrawButton(ACanvas: TCanvas; ARect: TRect; APicture: TPicture;
        AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
        AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor;
        AState: TdxNavBarObjectStates); override;
  end;

  TdxNavBarOffice11ButtonPainter = class(TdxNavBarAdvExplorerButtonPainter)
  protected
    class procedure InternalDrawButton(ACanvas: TCanvas; ARect: TRect; APicture: TPicture;
        AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
        AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor;
        AState: TdxNavBarObjectStates); override;
  end;

  TdxNavBarScrollButtonsPainter = class(TdxBaseScrollButtonsPainter)
  protected
    class procedure InternalDrawBottomButton(ACanvas: TCanvas; ARect: TRect;
        AButtonPainterClass: TdxBaseButtonPainterClass; AColor1, AColor2: TColor;
        AAlphaBlend1, AAlphaBlend2: Byte; AGradientMode: TdxBarStyleGradientMode;
        ABorderColor: TColor; AState: TdxNavBarObjectStates); override;
    class procedure InternalDrawTopButton(ACanvas: TCanvas; ARect: TRect;
        AButtonPainterClass: TdxBaseButtonPainterClass; AColor1, AColor2: TColor;
        AAlphaBlend1, AAlphaBlend2: Byte; AGradientMode: TdxBarStyleGradientMode;
        ABorderColor: TColor; AState: TdxNavBarObjectStates); override;
  end;

  TdxNavBarDropTargetLinkPainter = class(TdxBaseDropTargetLinkPainter)
  protected
    class procedure InternalDrawTargetLink(ACanvas: TCanvas;
        pt1, pt2, pt3, pt4, pt5, pt6: TPoint; AColor: TColor); override;
  end;

  TdxNavBarDropTargetGroupPainter = class(TdxBaseDropTargetGroupPainter)
  protected
    class procedure InternalDrawTargetGroup(ACanvas: TCanvas; ARect: TRect;
        AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
        AGradientMode: TdxBarStyleGradientMode); override;
  end;

  TdxNavBarXPPainter = class
  public
    class function DrawObject(ACanvas: TCanvas; ARect: TRect; AObject: TdxThemedObjectType;
        iPartId, iStateId: Integer): Boolean;
    class function DrawText(ACanvas: TCanvas; ARect: TRect;
        ACaption: string; ADrawTextFlag: Integer;
        AObject: TdxThemedObjectType; iPartId, iStateId: Integer): Boolean;
  end;

  TdxNavBarXPBackgroundPainter = class(TdxNavBarBackgroundPainter)
  protected
    class procedure InternalDrawBackground(ACanvas: TCanvas; ARect: TRect; APicture: TPicture;
      AEraseBackground: Boolean; ABackgroundColor: TColor;
      AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
      AGradientMode: TdxBarStyleGradientMode); override;
  end;

  TdxNavBarXPGroupBackgroundPainter = class(TdxNavBarGroupBackgroundPainter)
  protected
    class procedure InternalDrawBackground(ACanvas: TCanvas; ARect: TRect; APicture: TPicture;
        AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
        AGradientMode: TdxBarStyleGradientMode); override;
  end;

  TdxNavBarXPSelectionPainter = class(TdxNavBarSelectionPainter)
  protected
    class procedure InternalDrawSelection(ACanvas: TCanvas; ARect: TRect;
        ABackColor: TColor; AState: TdxNavBarObjectStates); override;
  end;

  TdxNavBarXPScrollButtonsPainter = class(TdxNavBarScrollButtonsPainter)
  protected
    class procedure InternalDrawBottomButton(ACanvas: TCanvas; ARect: TRect;
        AButtonPainterClass: TdxBaseButtonPainterClass; AColor1, AColor2: TColor;
        AAlphaBlend1, AAlphaBlend2: Byte; AGradientMode: TdxBarStyleGradientMode;
        ABorderColor: TColor; AState: TdxNavBarObjectStates); override;
    class procedure InternalDrawTopButton(ACanvas: TCanvas; ARect: TRect;
        AButtonPainterClass: TdxBaseButtonPainterClass; AColor1, AColor2: TColor;
        AAlphaBlend1, AAlphaBlend2: Byte; AGradientMode: TdxBarStyleGradientMode;
        ABorderColor: TColor; AState: TdxNavBarObjectStates); override;
  end;

  TdxNavBarXPButtonPainter = class(TdxNavBarOfficeButtonPainter)
  protected
    class procedure InternalDrawButton(ACanvas: TCanvas; ARect: TRect; APicture: TPicture;
        AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
        AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor;
        AState: TdxNavBarObjectStates); override;
  end;

  TdxNavBarXPExplorerBarBackgroundPainter = class(TdxNavBarBackgroundPainter)
  protected
    class function GetBackgroundBitmap: TBitmap;
    class procedure InternalDrawBackground(ACanvas: TCanvas; ARect: TRect; APicture: TPicture;
      AEraseBackground: Boolean; ABackgroundColor: TColor;
      AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
      AGradientMode: TdxBarStyleGradientMode); override;
  end;

  TdxNavBarXPExplorerBarSignPainter = class(TdxNavBarExplorerBarSignPainter)
  protected
    class procedure CreateBitmap(var ADC: HDC; var ABitmap, AOldBitmap: HBITMAP; var AData: Pointer; AWidth, AHeight: Integer);
    class procedure DeleteBitmap(var ADC: HDC; var ABitmap, AOldBitmap: HBITMAP; var AData: Pointer);
    class procedure DrawMaskBitmap(DestX, DestY: Integer; DestHandle: THandle; Bitmap: TBitmap);

    class function GetSignBitmap(AState: TdxNavBarObjectStates): TBitmap;
    class procedure InternalDrawSign(ACanvas: TCanvas; ARect: TRect;
        AForeColor, ABackColor1, ABackColor2 : TColor; AState: TdxNavBarObjectStates); override;
  end;

  TdxNavBarXPExplorerBarButtonPainter = class(TdxNavBarExplorerButtonPainter)
  protected
    class function GetButtonBitmap(AState: TdxNavBarObjectStates): TBitmap;
    class procedure InternalDrawButton(ACanvas: TCanvas; ARect: TRect; APicture: TPicture;
        AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
        AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor;
        AState: TdxNavBarObjectStates); override;
  end;

var
  // AdvExplorerBar bitmaps, colors and fonts
  dxAdvExplorerBarGroupCaptionCollapseSignBitmap: TBitmap;
  dxAdvExplorerBarGroupCaptionExpandSignBitmap: TBitmap;
//  dxAdvExplorerBarSpecialGroupCaptionCollapseSignBitmap: TBitmap;
//  dxAdvExplorerBarSpecialGroupCaptionExpandSignBitmap: TBitmap;

  dxAdvExplorerBarBackgroundColor1: COLORREF;
  dxAdvExplorerBarBackgroundColor2: COLORREF;
  dxAdvExplorerBarFontColor: COLORREF;
  dxAdvExplorerBarFontHotColor: COLORREF;
  dxAdvExplorerBarGroupBackgroundColor: COLORREF;
  dxAdvExplorerBarGroupCaptionColor1: COLORREF;
  dxAdvExplorerBarGroupCaptionColor2: COLORREF;
  dxAdvExplorerBarGroupCaptionSignColor: COLORREF;
  dxAdvExplorerBarGroupCaptionSignHotColor: COLORREF;
  dxAdvExplorerBarGroupFontColor: COLORREF;
  dxAdvExplorerBarGroupFontHotColor: COLORREF;
  dxAdvExplorerBarSpecialGroupCaptionColor1: COLORREF;
  dxAdvExplorerBarSpecialGroupCaptionColor2: COLORREF;
  dxAdvExplorerBarSpecialGroupCaptionSignColor: COLORREF;
  dxAdvExplorerBarSpecialGroupCaptionSignHotColor: COLORREF;
  dxAdvExplorerBarSpecialGroupFontColor: COLORREF;
  dxAdvExplorerBarSpecialGroupFontHotColor: COLORREF;

  // Office11 color and bitmaps
  dxOffice11BackgroundColor1: COLORREF;
  dxOffice11BackgroundColor2: COLORREF;
  dxOffice11GroupBackgroundColor1: COLORREF;
  dxOffice11GroupBackgroundColor2: COLORREF;
  dxOffice11GroupCaptionColor1: COLORREF;
  dxOffice11GroupCaptionColor2: COLORREF;
  dxOffice11GroupBorderColor: COLORREF;
  dxOffice11GroupFontColor: COLORREF;
  dxOffice11LinkFontColor: COLORREF;

  dxOffice11CaptionExpandSignBitmap: TBitmap;
  dxOffice11CaptionCollapseSignBitmap: TBitmap;

  // Office11 NavPane bitmaps
  dxOffice11NavPaneOverflowPanelBitmap: TBitmap;
  dxOffice11NavPaneSplitterBitmap: TBitmap;
  dxOffice11NavPaneArrowUpBitmap: TBitmap;
  dxOffice11NavPaneArrowDownBitmap: TBitmap;
  dxOffice11NavPaneDefaultLargeBitmap: TBitmap;
  dxOffice11NavPaneDefaultSmallBitmap: TBitmap;

  // XPExplorerBar bitmaps, colors and fonts
  dxXPExplorerBarSpecialGroupHeader: TBitmap;
  dxXPExplorerBarNormalGroupHeader: TBitmap;
  dxXPExplorerBarSpecialGroupCollapseHot: TBitmap;
  dxXPExplorerBarNormalGroupCollapseHot: TBitmap;
  dxXPExplorerBarSpecialGroupCollapse: TBitmap;
  dxXPExplorerBarNormalGroupCollapse: TBitmap;
  dxXPExplorerBarSpecialGroupExpandHot: TBitmap;
  dxXPExplorerBarNormalGroupExpandHot: TBitmap;
  dxXPExplorerBarSpecialGroupExpand: TBitmap;
  dxXPExplorerBarNormalGroupExpand: TBitmap;
  dxXPExplorerBarBackground: TBitmap;

  dxXPExplorerBarItemFont: TFont;
  dxXPExplorerBarItemFontHot: TFont;
  dxXPExplorerBarGroupHeaderFont: TFont;
  dxXPExplorerBarGroupHeaderFontHot: TFont;

  dxXPExplorerBarBackgroundColor1: TColor = clNone; // TODO ???
  dxXPExplorerBarBackgroundColor2: TColor = clNone; // TODO ???
  dxXPExplorerBarGroupBackgroundColor1: TColor = clNone; // TODO ???
  dxXPExplorerBarGroupBackgroundColor2: TColor = clNone; // TODO ???
  dxXPExplorerBarGroupBorderColor: TColor = clNone;

procedure CreateAdvExplorerBarColors;
procedure RefreshAdvExplorerBarColors;
procedure ReleaseAdvExplorerBarColors;

procedure CreateOffice11Colors;
procedure RefreshOffice11Colors;
procedure ReleaseOffice11Colors;

procedure CreateOffice11NavPaneColors;
procedure RefreshOffice11NavPaneColors;
procedure ReleaseOffice11NavPaneColors;

function CheckShellInstance: Boolean;
procedure CreateXPExplorerBarColors;
procedure RefreshXPExplorerBarColors;
procedure ReleaseXPExplorerBarColors;

function XPScheme: TXPScheme;

function LightColor(AColor: TColor): TColor;
function LightLightColor(AColor: TColor): TColor;
function DarkColor(AColor: TColor): TColor;
function DarkDarkColor(AColor: TColor): TColor;
function LightBorderColor(AColor: TColor): TColor;
function LightLightBorderColor(AColor: TColor): TColor;
function DarkBorderColor(AColor: TColor): TColor;
function DarkDarkBorderColor(AColor: TColor): TColor;
function CalcColor(d: Integer): TColor;
function CalcTextColor(AColor: TColor; AState: TdxNavBarObjectStates): TColor;
function GetFontHeight(AFont: TFont): Integer;
procedure GetSystemFont(AFont: TFont);

type
  PARGB  = ^ARGB;
  ARGB   = DWORD;
  {$EXTERNALSYM ARGB}
  ARGB64 = Int64;
  {$EXTERNALSYM ARGB64}

  PdxGPColor = ^TdxGPColor;
  TdxGPColor = ARGB;
  TdxGPColorDynArray = array of TdxGPColor;

// Color
const
  AlphaShift  = 24;
  {$EXTERNALSYM AlphaShift}
  RedShift    = 16;
  {$EXTERNALSYM RedShift}
  GreenShift  = 8;
  {$EXTERNALSYM GreenShift}
  BlueShift   = 0;
  {$EXTERNALSYM BlueShift}

  AlphaMask   = $ff000000;
  {$EXTERNALSYM AlphaMask}
  RedMask     = $00ff0000;
  {$EXTERNALSYM RedMask}
  GreenMask   = $0000ff00;
  {$EXTERNALSYM GreenMask}
  BlueMask    = $000000ff;
  {$EXTERNALSYM BlueMask}

function MakeColor(r, g, b: Byte): TdxGPColor; overload;
function MakeColor(a, r, g, b: Byte): TdxGPColor; overload;
function MakeColor(color: TColor; alpha: Byte): TdxGPColor; overload;
function GetAlpha(color: ARGB): BYTE;
function GetRed(color: ARGB): BYTE;
function GetGreen(color: ARGB): BYTE;
function GetBlue(color: ARGB): BYTE;
function ColorRefToARGB(rgb: COLORREF): ARGB;
function ARGBToColorRef(Color: ARGB): COLORREF;

implementation

uses
  SysUtils, Math,
  dxGDIPlusAPI, dxGDIPlusClasses,
  dxThemeConsts, dxUxTheme, dxOffice11;

const
  ShellLibraryName = 'shell32.dll';

type
  TdxSHGetShellStyleHInstance = function: LongWord; stdcall;
  PdxSHGetShellStyleHInstance = ^TdxSHGetShellStyleHInstance;

var
  FCounterAdvExplorerBar: Integer;
  FCounterOffice11: Integer;
  FCounterOffice11NavPane: Integer;
  FCounterXPExplorerBar: Integer;

  FShellLibrary: HMODULE;

  FSHGetShellStyleHInstancePointer: PdxSHGetShellStyleHInstance;
  FSHGetShellStyleHInstance: TdxSHGetShellStyleHInstance;
  FShellInstance: LongInt;

{ TdxStyleSheetParser }

type
  TdxStyleSheetParser = class
  private
    FStyles: TStringList;

    function TrimChars(AText: string): string;
    function LeftString(AText: string; APos: Integer): string;
    function RightString(AText: string; APos: Integer): string;
    function MiddleString(AText: string; AStartPos, AEndPos: Integer): string;
  protected
    function GetStyleText(AStyleName: string): string;
    function GetStyleAttributeText(AStyleText, AAttributeName: string): string;

    procedure ParseColorName(var AColor: TColor; AAttributeText: string);
    procedure ParseColor(var AColor: TColor; AAttributeText: string);

    procedure ParseFontWeight(AFont: TFont; AStyleText: string);
    procedure ParseFontDecoration(AFont: TFont; AStyleText: string);
    procedure ParseFontColor(AFont: TFont; AStyleText: string);
    procedure ParseFontSize(AFont: TFont; AStyleText: string);
  public
    constructor Create(AText: string);
    destructor Destroy; override;

    procedure ParseBackgroundColor(var AColor: TColor; AStyleName: string);
    procedure ParseBorderColor(var AColor: TColor; AStyleName: string);
    procedure ParseFont(AFont: TFont; AStyleName: string);
  end;

constructor TdxStyleSheetParser.Create(AText: string);
begin
  FStyles := TStringList.Create;
  FStyles.Text := Trim(AText);
end;

destructor TdxStyleSheetParser.Destroy;
begin
  FStyles.Free;
  inherited;
end;

procedure TdxStyleSheetParser.ParseBackgroundColor(var AColor: TColor; AStyleName: string);
var
  AStyleText, AStyleAttributeText: string;
begin
  AStyleText := StringReplace(GetStyleText(AStyleName), ' ', '', [rfReplaceAll]);
  if AStyleText <> '' then
  begin
    AStyleAttributeText := GetStyleAttributeText(AStyleText, 'BACKGROUND-COLOR:');
    ParseColor(AColor, StringReplace(AStyleAttributeText, ' ', '', [rfReplaceAll]));
  end
end;

procedure TdxStyleSheetParser.ParseBorderColor(var AColor: TColor; AStyleName: string);
var
  APos: Integer;
  AStyleText, AStyleAttributeText: string;
begin
  AStyleText := StringReplace(GetStyleText(AStyleName), ' ', '', [rfReplaceAll]);
  if AStyleText <> '' then
  begin
    AStyleAttributeText := GetStyleAttributeText(AStyleText, 'BORDER:');
    AStyleAttributeText := StringReplace(AStyleAttributeText, '''', '', [rfReplaceAll]);
    APos := Pos(' ', AStyleAttributeText);
    if APos > 0 then
      AStyleAttributeText := RightString(AStyleAttributeText, APos + 1);
    APos := Pos(' ', AStyleAttributeText);
    if APos > 0 then
      AStyleAttributeText := RightString(AStyleAttributeText, APos + 1);
    ParseColor(AColor, StringReplace(AStyleAttributeText, ' ', '', [rfReplaceAll]));
  end;
end;

procedure TdxStyleSheetParser.ParseFont(AFont: TFont; AStyleName: string);
var
  AStyleText: string;
begin
  AStyleText := StringReplace(GetStyleText(AStyleName), ' ', '', [rfReplaceAll]);
  if AStyleText <> '' then
  begin
    ParseFontSize(AFont, AStyleText);
    ParseFontWeight(AFont, AStyleText);
    ParseFontDecoration(AFont, AStyleText);
    ParseFontColor(AFont, AStyleText);
  end;
end;

procedure TdxStyleSheetParser.ParseFontWeight(AFont: TFont; AStyleText: string);
var
  AFontWeight: string;
begin
  AFontWeight := UpperCase(GetStyleAttributeText(AStyleText, 'FONT-WEIGHT:'));
  if AFontWeight = 'BOLD' then
    AFont.Style := AFont.Style + [fsBold]
  else if AFontWeight = 'NORMAL' then
    AFont.Style := AFont.Style - [fsBold];
end;

procedure TdxStyleSheetParser.ParseFontDecoration(AFont: TFont; AStyleText: string);
var
  AFontDecoration: string;
begin
  AFontDecoration := UpperCase(GetStyleAttributeText(AStyleText, 'TEXT-DECORATION:'));
  if AFontDecoration = 'UNDERLINE' then
    AFont.Style := AFont.Style + [fsUnderline]
  else if AFontDecoration = 'NONE' then
    AFont.Style := AFont.Style - [fsUnderline];
end;

procedure TdxStyleSheetParser.ParseFontColor(AFont: TFont; AStyleText: string);
var
  AFontColor: TColor;
  AFontColorString: string;
begin
  AFontColorString := GetStyleAttributeText(AStyleText, 'COLOR:');
  if AFontColorString <> '' then
  begin
    ParseColor(AFontColor, AFontColorString);
    if AFontColor > 0 then
      AFont.Color := AFontColor;
  end;
end;

procedure TdxStyleSheetParser.ParseFontSize(AFont: TFont; AStyleText: string);
var
  AFontSize: string;
begin
  AFontSize := TrimChars(GetStyleAttributeText(AStyleText, 'FONT-SIZE:'));
  if AFontSize <> '' then
    AFont.Size := StrToInt(AFontSize);
end;

function TdxStyleSheetParser.GetStyleText(AStyleName: string): string;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to FStyles.Count - 1 do
    if Pos(UpperCase(AStyleName), UpperCase(FStyles[I])) = 1 then
    begin
      Result := FStyles[I];
      break;
    end;
end;

function TdxStyleSheetParser.GetStyleAttributeText(AStyleText, AAttributeName: string): string;
var
  ABeginPos, AEndPos: Integer;
begin
  Result := '';
  ABeginPos := Pos(UpperCase(AAttributeName), UpperCase(AStyleText));
  if ABeginPos > 0 then
  begin
    ABeginPos := ABeginPos + Length(AAttributeName);
    Result := RightString(AStyleText, ABeginPos);
    AEndPos := Pos(';', Result);
    if AEndPos = 0 then
      AEndPos := Pos('}', Result);
    if AEndPos > 0 then
      Result := LeftString(Result, AEndPos);
  end;
end;

procedure TdxStyleSheetParser.ParseColorName(var AColor: TColor; AAttributeText: string);
begin
  cxColorByName(AAttributeText, AColor);
end;

procedure TdxStyleSheetParser.ParseColor(var AColor: TColor; AAttributeText: string);
var
  APos: Integer;
  R, G, B: Byte;
begin
  APos := Pos('#', AAttributeText);
  if APos > 0 then
  begin
    AAttributeText := RightString(AAttributeText, APos + 1);
    R := StrToInt('$' + MiddleString(AAttributeText, 1, 2));
    G := StrToInt('$' + MiddleString(AAttributeText, 3, 4));
    B := StrToInt('$' + MiddleString(AAttributeText, 5, 6));
    AColor := RGB(R, G, B);
  end
  else
    ParseColorName(AColor, AAttributeText);
end;

function TdxStyleSheetParser.TrimChars(AText: string): string;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(AText) do
    if (AText[I] >= '0') and (AText[I] <= '9') then
      Result := Result + AText[I];
end;

function TdxStyleSheetParser.LeftString(AText: string; APos: Integer): string;
begin
  Result := Copy(AText, 1, APos - 1);
end;

function TdxStyleSheetParser.RightString(AText: string; APos: Integer): string;
begin
  Result := Copy(AText, APos, Length(AText) - APos + 1);
end;

function TdxStyleSheetParser.MiddleString(AText: string; AStartPos, AEndPos: Integer): string;
begin
  Result := Copy(AText, AStartPos, AEndPos - AStartPos + 1);
end;

{ utilities }

procedure InitAdvExplorerBarColors;
const
  Colors: array[TXPSchemeColor, 0..11] of COLORREF = (
    ($E7A27B, $D67563, $C65D21, $FF8E42, $F7DFD6, $FFFFFF, $F7D3C6, $B54900, $CE5D29, $A53C00, $FFCDAC, $FF8E42),
    ($ADD9CC, $84BDA5, $2D6656, $1D9272, $ECF6F6, $ECFCFF, $B8E7E0, $408C77, $67A896, $1C674B, $BEEDDD, $B8E7E0),
    ($D4C8C4, $C8B3B1, $3D3D3F, $7C7C7E, $F5F1F0, $FFFFFF, $E0D7D6, $927777, $C7B6B4, $734431, $FEFEF9, $E6E6E6)
  );
var
  AColorScheme: TXPScheme;
begin
  AColorScheme := XPScheme;
  if AColorScheme <> schUnknown then
  begin
    dxAdvExplorerBarBackgroundColor1 := Colors[AColorScheme, 0];
    dxAdvExplorerBarBackgroundColor2 := Colors[AColorScheme, 1];
    dxAdvExplorerBarFontColor := Colors[AColorScheme, 2];
    dxAdvExplorerBarFontHotColor := Colors[AColorScheme, 3];
    dxAdvExplorerBarGroupBackgroundColor := Colors[AColorScheme, 4];
    dxAdvExplorerBarGroupCaptionColor1 := Colors[AColorScheme, 5];
    dxAdvExplorerBarGroupCaptionColor2 := Colors[AColorScheme, 6];
    dxAdvExplorerBarGroupFontColor := dxAdvExplorerBarFontColor;
    dxAdvExplorerBarGroupFontHotColor := dxAdvExplorerBarFontHotColor;
    dxAdvExplorerBarSpecialGroupCaptionColor1 := Colors[AColorScheme, 7];
    dxAdvExplorerBarSpecialGroupCaptionColor2 := Colors[AColorScheme, 8];
    dxAdvExplorerBarGroupCaptionSignColor := Colors[AColorScheme, 9];
    dxAdvExplorerBarGroupCaptionSignHotColor := dxAdvExplorerBarFontHotColor;
    dxAdvExplorerBarSpecialGroupCaptionSignColor := dxAdvExplorerBarGroupCaptionSignColor;//clWhite;
    dxAdvExplorerBarSpecialGroupCaptionSignHotColor := dxAdvExplorerBarGroupCaptionSignHotColor;//Colors[AColorScheme, 10];
    dxAdvExplorerBarSpecialGroupFontColor := clWhite;
    dxAdvExplorerBarSpecialGroupFontHotColor := Colors[AColorScheme, 11];
  end
  else
  begin
    dxAdvExplorerBarBackgroundColor1 := ColorToRGB(clInactiveCaption);
    dxAdvExplorerBarBackgroundColor2 := dxAdvExplorerBarBackgroundColor1;
    dxAdvExplorerBarFontColor := CalcTextColor(clNone, []);
    dxAdvExplorerBarFontHotColor := CalcTextColor(clNone, [sHotTracked]);
    dxAdvExplorerBarGroupBackgroundColor := LightLightColor(clInactiveCaption);
    dxAdvExplorerBarGroupCaptionColor1 := ColorToRGB(clWindow);
    dxAdvExplorerBarGroupCaptionColor2 := LightLightColor(clHighlight);
    dxAdvExplorerBarGroupFontColor := dxAdvExplorerBarFontColor;
    dxAdvExplorerBarGroupFontHotColor := dxAdvExplorerBarFontHotColor;
    dxAdvExplorerBarSpecialGroupCaptionColor1 := ColorToRGB(clHighlight);
    dxAdvExplorerBarSpecialGroupCaptionColor2 := dxAdvExplorerBarSpecialGroupCaptionColor1;
    dxAdvExplorerBarGroupCaptionSignColor := dxAdvExplorerBarGroupFontColor;
    dxAdvExplorerBarGroupCaptionSignHotColor := dxAdvExplorerBarGroupFontHotColor;
    dxAdvExplorerBarSpecialGroupCaptionSignColor := dxAdvExplorerBarSpecialGroupCaptionColor2;
    dxAdvExplorerBarSpecialGroupCaptionSignHotColor := dxAdvExplorerBarSpecialGroupCaptionColor2;
    dxAdvExplorerBarSpecialGroupFontColor := ColorToRGB(clCaptionText);
    dxAdvExplorerBarSpecialGroupFontHotColor := dxAdvExplorerBarSpecialGroupFontColor;
  end;
end;

procedure CreateAdvExplorerBarBitmaps;
begin
  dxAdvExplorerBarGroupCaptionCollapseSignBitmap := TBitmap.Create;
  dxAdvExplorerBarGroupCaptionCollapseSignBitmap.Handle := LoadBitmap(HInstance, 'DXNAVBARADVEXPLORERBARGROUPCAPTIONCOLLAPSESIGN');
  dxAdvExplorerBarGroupCaptionExpandSignBitmap := TBitmap.Create;
  dxAdvExplorerBarGroupCaptionExpandSignBitmap.Handle := LoadBitmap(HInstance, 'DXNAVBARADVEXPLORERBARGROUPCAPTIONEXPANDSIGN');
//  dxAdvExplorerBarSpecialGroupCaptionCollapseSignBitmap := TBitmap.Create;
//  dxAdvExplorerBarSpecialGroupCaptionCollapseSignBitmap.Handle := LoadBitmap(HInstance, 'DXNAVBARADVEXPLORERBARSPECIALGROUPCAPTIONCOLLAPSESIGN');
//  dxAdvExplorerBarSpecialGroupCaptionExpandSignBitmap := TBitmap.Create;
//  dxAdvExplorerBarSpecialGroupCaptionExpandSignBitmap.Handle := LoadBitmap(HInstance, 'DXNAVBARADVEXPLORERBARSPECIALGROUPCAPTIONEXPANDSIGN');
end;

procedure DestroyAdvExplorerBarBitmaps;
begin
  dxAdvExplorerBarGroupCaptionCollapseSignBitmap.Free;
  dxAdvExplorerBarGroupCaptionCollapseSignBitmap := nil;
  dxAdvExplorerBarGroupCaptionExpandSignBitmap.Free;
  dxAdvExplorerBarGroupCaptionExpandSignBitmap := nil;
//  dxAdvExplorerBarSpecialGroupCaptionCollapseSignBitmap.Free;
//  dxAdvExplorerBarSpecialGroupCaptionCollapseSignBitmap := nil;
//  dxAdvExplorerBarSpecialGroupCaptionExpandSignBitmap.Free;
//  dxAdvExplorerBarSpecialGroupCaptionExpandSignBitmap := nil;
end;

procedure CreateAdvExplorerBarColors;
begin
  if FCounterAdvExplorerBar = 0 then
  begin
    InitAdvExplorerBarColors;
    CreateAdvExplorerBarBitmaps;
  end;
  Inc(FCounterAdvExplorerBar);
end;

procedure RefreshAdvExplorerBarColors;
begin
  InitAdvExplorerBarColors;
  if FCounterAdvExplorerBar > 0 then
  begin
    DestroyAdvExplorerBarBitmaps;
    CreateAdvExplorerBarBitmaps;
  end;
end;

procedure ReleaseAdvExplorerBarColors;
begin
  Dec(FCounterAdvExplorerBar);
  if FCounterAdvExplorerBar = 0 then
    DestroyAdvExplorerBarBitmaps;
end;

procedure InitOffice11Colors;
const
  Office11Colors: array[TXPSchemeColor, 0..8] of COLORREF = (
    ($FADAC4, $C97A4A, $FEECDD, $F1D0BA, $F9DBC4, $E08F65, $FFFFFF, $862D00, $B23D00),
    ($E7F2F3, $98C6BE, $FFFFFF, $E7F2F3, $AEDFD2, $80B0A1, $FFFFFF, $466B5A, $5E8674),
    ($F4EEEE, $C3B0B1, $FCFBFB, $F5F0F0, $DFD0D0, $BFA8A9, $FFFFFF, $795B5C, $99797A)
  );
var
  AOffice11Scheme: TXPScheme;
begin
  AOffice11Scheme := XPScheme;
  if AreVisualStylesAvailable and (AOffice11Scheme <> schUnknown){luna} then
  begin
    dxOffice11BackgroundColor1 := Office11Colors[AOffice11Scheme, 0];
    dxOffice11BackgroundColor2 := Office11Colors[AOffice11Scheme, 1];
    dxOffice11GroupBackgroundColor1 := Office11Colors[AOffice11Scheme, 2];
    dxOffice11GroupBackgroundColor2 := Office11Colors[AOffice11Scheme, 3];
    dxOffice11GroupCaptionColor1 := Office11Colors[AOffice11Scheme, 4];
    dxOffice11GroupCaptionColor2 := Office11Colors[AOffice11Scheme, 5];
    dxOffice11GroupBorderColor := Office11Colors[AOffice11Scheme, 6];
    dxOffice11GroupFontColor := Office11Colors[AOffice11Scheme, 7];
    dxOffice11LinkFontColor := Office11Colors[AOffice11Scheme, 8];
  end
  else
  begin
    dxOffice11BackgroundColor1 := GetMiddleRGB(clBtnFace, clWindow, 50);
    dxOffice11BackgroundColor2 := GetMiddleRGB(clBtnFace, clWindow, 100);
    dxOffice11GroupBackgroundColor1 := GetMiddleRGB(clBtnFace, clWindow, 15);
    dxOffice11GroupBackgroundColor2 := GetMiddleRGB(clBtnFace, clWindow, 20);
    dxOffice11GroupCaptionColor1 := GetMiddleRGB(clBtnFace, clWindow, 45);
    dxOffice11GroupCaptionColor2 := GetMiddleRGB(clBtnFace, clWindow, 70);
    dxOffice11GroupBorderColor := GetMiddleRGB(clBtnFace, clWindow, 5);
    dxOffice11GroupFontColor := clBlack;
    dxOffice11LinkFontColor := clBlue;
  end;
end;

procedure CreateOffice11Bitmaps;
begin
  dxOffice11CaptionExpandSignBitmap := TBitmap.Create;
  dxOffice11CaptionExpandSignBitmap.Handle := LoadBitmap(HInstance, 'DXNAVBAROFFICE11EXPANDSIGN');
  dxOffice11CaptionCollapseSignBitmap := TBitmap.Create;
  dxOffice11CaptionCollapseSignBitmap.Handle := LoadBitmap(HInstance, 'DXNAVBAROFFICE11COLLAPSESIGN');
end;

procedure DestroyOffice11Bitmaps;
begin
  dxOffice11CaptionExpandSignBitmap.Free;
  dxOffice11CaptionExpandSignBitmap := nil;
  dxOffice11CaptionCollapseSignBitmap.Free;
  dxOffice11CaptionCollapseSignBitmap := nil;
end;

procedure CreateOffice11Colors;
begin
  if FCounterOffice11 = 0 then
  begin
    InitOffice11Colors;
    CreateOffice11Bitmaps;
  end;
  Inc(FCounterOffice11);
end;

procedure RefreshOffice11Colors;
begin
  InitOffice11Colors;
  if FCounterOffice11 <> 0 then
  begin
    DestroyOffice11Bitmaps;
    CreateOffice11Bitmaps;
  end;
end;

procedure ReleaseOffice11Colors;
begin
  Dec(FCounterOffice11);
  if FCounterOffice11 = 0 then
    DestroyOffice11Bitmaps;
end;

procedure CreateOffice11NavPaneBitmaps;
begin
  dxOffice11NavPaneOverflowPanelBitmap := TBitmap.Create;
  dxOffice11NavPaneOverflowPanelBitmap.Handle := LoadBitmap(HInstance, 'DXNAVBAROFFICE11NAVPANEOVERFLOW');
  dxOffice11NavPaneOverflowPanelBitmap.Transparent := True;
  dxOffice11NavPaneSplitterBitmap := TBitmap.Create;
  dxOffice11NavPaneSplitterBitmap.Handle := LoadBitmap(HInstance, 'DXNAVBAROFFICE11NAVPANESPLITTER');
  dxOffice11NavPaneSplitterBitmap.Transparent := True;
  dxOffice11NavPaneArrowUpBitmap := TBitmap.Create;
  dxOffice11NavPaneArrowUpBitmap.Handle := LoadBitmap(HInstance, 'DXNAVBAROFFICE11NAVPANEARROWUP');
  dxOffice11NavPaneArrowUpBitmap.Transparent := True;
  dxOffice11NavPaneArrowDownBitmap := TBitmap.Create;
  dxOffice11NavPaneArrowDownBitmap.Handle := LoadBitmap(HInstance, 'DXNAVBAROFFICE11NAVPANEARROWDOWN');
  dxOffice11NavPaneArrowDownBitmap.Transparent := True;
  dxOffice11NavPaneDefaultLargeBitmap := TBitmap.Create;
  dxOffice11NavPaneDefaultLargeBitmap.Handle := LoadBitmap(HInstance, 'DXNAVBAROFFICE11NAVPANEDEFAULTLARGE');
  dxOffice11NavPaneDefaultLargeBitmap.Transparent := True;
  dxOffice11NavPaneDefaultSmallBitmap := TBitmap.Create;
  dxOffice11NavPaneDefaultSmallBitmap.Handle := LoadBitmap(HInstance, 'DXNAVBAROFFICE11NAVPANEDEFAULTSMALL');
  dxOffice11NavPaneDefaultSmallBitmap.Transparent := True;
end;

procedure DestroyOffice11NavPaneBitmaps;
begin
  dxOffice11NavPaneArrowUpBitmap.Free;
  dxOffice11NavPaneArrowUpBitmap := nil;
  dxOffice11NavPaneArrowDownBitmap.Free;
  dxOffice11NavPaneArrowDownBitmap := nil;
  dxOffice11NavPaneOverflowPanelBitmap.Free;
  dxOffice11NavPaneOverflowPanelBitmap := nil;
  dxOffice11NavPaneSplitterBitmap.Free;
  dxOffice11NavPaneSplitterBitmap := nil;
  dxOffice11NavPaneDefaultLargeBitmap.Free;
  dxOffice11NavPaneDefaultLargeBitmap := nil;
  dxOffice11NavPaneDefaultSmallBitmap.Free;
  dxOffice11NavPaneDefaultSmallBitmap := nil;
end;

procedure CreateOffice11NavPaneColors;
begin
  if FCounterOffice11NavPane = 0 then
    CreateOffice11NavPaneBitmaps;
  Inc(FCounterOffice11NavPane);
end;

procedure RefreshOffice11NavPaneColors;
begin
  if FCounterOffice11NavPane <> 0 then
  begin
    DestroyOffice11NavPaneBitmaps;
    CreateOffice11NavPAneBitmaps;
  end;
end;

procedure ReleaseOffice11NavPaneColors;
begin
  Dec(FCounterOffice11NavPane);
  if FCounterOffice11NavPane = 0 then
    DestroyOffice11NavPaneBitmaps;
end;

function GetResourceImage(AID: Byte): TBitmap;
var
  AResType, AResID: PChar;
  AResInfo: THandle;
begin
  Result := nil;
  if CheckShellInstance then
  begin
    AResType := RT_BITMAP;
    AResID := PChar(char(AID));
    AResInfo := FindResource(FShellInstance, AResID, AResType);
    if AResInfo > 0 then
    begin
      Result := TBitmap.Create;
      Result.LoadFromResourceID(FShellInstance, AID);
    end;
  end;
end;

function GetResourceText(AName: string): string;
var
  AResType, AResName: PChar;
  AStream: TResourceStream;
  AResInfo: THandle;
begin
  Result := '';
  if CheckShellInstance then
  begin
    AResType := PChar(23);
    AResName := PChar(AName);
    AResInfo := FindResource(FShellInstance, AResName, AResType);
    if AResInfo > 0 then
    begin
      AStream := TResourceStream.Create(FShellInstance, AResName, AResType);
      try
        Result := Copy(PChar(AStream.Memory), 1, AStream.Size);
      finally
        AStream.Free;
      end;
    end;
  end;
end;

procedure CreateXPExplorerBarBitmaps;
begin
  dxXPExplorerBarSpecialGroupHeader := GetResourceImage(110);
  dxXPExplorerBarNormalGroupHeader := GetResourceImage(112);
  dxXPExplorerBarSpecialGroupCollapseHot := GetResourceImage(105);
  dxXPExplorerBarNormalGroupCollapseHot := GetResourceImage(101);
  dxXPExplorerBarSpecialGroupCollapse := GetResourceImage(104);
  dxXPExplorerBarNormalGroupCollapse := GetResourceImage(100);
  dxXPExplorerBarSpecialGroupExpandHot := GetResourceImage(107);
  dxXPExplorerBarNormalGroupExpandHot := GetResourceImage(103);
  dxXPExplorerBarSpecialGroupExpand := GetResourceImage(106);
  dxXPExplorerBarNormalGroupExpand := GetResourceImage(102);
  dxXPExplorerBarBackground := GetResourceImage(114);
end;

procedure CreateXPExplorerBarStyleSheetAttributes;
var
  AStyleSheetText: string;
  AParser: TdxStyleSheetParser;
begin
  AStyleSheetText := GetResourceText('CPWEBVW.CSS');
  AParser := TdxStyleSheetParser.Create(AStyleSheetText);
  try
    dxXPExplorerBarItemFont := TFont.Create;
    dxXPExplorerBarItemFontHot := TFont.Create;
    dxXPExplorerBarGroupHeaderFont := TFont.Create;
    dxXPExplorerBarGroupHeaderFontHot := TFont.Create;

    GetSystemFont(dxXPExplorerBarItemFont);
    GetSystemFont(dxXPExplorerBarItemFontHot);
    GetSystemFont(dxXPExplorerBarGroupHeaderFont);
    GetSystemFont(dxXPExplorerBarGroupHeaderFontHot);

    AParser.ParseFont(dxXPExplorerBarGroupHeaderFont, 'BODY ');
    AParser.ParseFont(dxXPExplorerBarGroupHeaderFontHot, 'BODY ');
    AParser.ParseFont(dxXPExplorerBarItemFont, 'BODY ');
    AParser.ParseFont(dxXPExplorerBarItemFontHot, 'BODY ');
    AParser.ParseFont(dxXPExplorerBarItemFont, 'A ');
    AParser.ParseFont(dxXPExplorerBarItemFontHot, 'A ');
    AParser.ParseFont(dxXPExplorerBarGroupHeaderFont, '.LEARNABOUTCAPTION ');
    AParser.ParseFont(dxXPExplorerBarGroupHeaderFontHot, '.LEARNABOUTCAPTION ');
    AParser.ParseFont(dxXPExplorerBarGroupHeaderFontHot, 'A:HOVER ');
    AParser.ParseFont(dxXPExplorerBarItemFontHot, 'A:HOVER ');

    AParser.ParseBorderColor(dxXPExplorerBarGroupBorderColor, '.LEARNABOUTBOX');
  finally
    AParser.Free;
  end;
end;

procedure DestroyXPExplorerBarBitmaps;
begin
  dxXPExplorerBarSpecialGroupHeader.Free;
  dxXPExplorerBarSpecialGroupHeader := nil;
  dxXPExplorerBarNormalGroupHeader.Free;
  dxXPExplorerBarNormalGroupHeader := nil;
  dxXPExplorerBarSpecialGroupCollapseHot.Free;
  dxXPExplorerBarSpecialGroupCollapseHot := nil;
  dxXPExplorerBarNormalGroupCollapseHot.Free;
  dxXPExplorerBarNormalGroupCollapseHot := nil;
  dxXPExplorerBarSpecialGroupCollapse.Free;
  dxXPExplorerBarSpecialGroupCollapse := nil;
  dxXPExplorerBarNormalGroupCollapse.Free;
  dxXPExplorerBarNormalGroupCollapse := nil;
  dxXPExplorerBarSpecialGroupExpandHot.Free;
  dxXPExplorerBarSpecialGroupExpandHot := nil;
  dxXPExplorerBarNormalGroupExpandHot.Free;
  dxXPExplorerBarNormalGroupExpandHot := nil;
  dxXPExplorerBarSpecialGroupExpand.Free;
  dxXPExplorerBarSpecialGroupExpand := nil;
  dxXPExplorerBarNormalGroupExpand.Free;
  dxXPExplorerBarNormalGroupExpand := nil;
  dxXPExplorerBarBackground.Free;
  dxXPExplorerBarBackground := nil;
end;

procedure DestroyXPExplorerBarStyleSheetAttributes;
begin
  dxXPExplorerBarItemFont.Free;
  dxXPExplorerBarItemFont := nil;
  dxXPExplorerBarItemFontHot.Free;
  dxXPExplorerBarItemFontHot := nil;
  dxXPExplorerBarGroupHeaderFont.Free;
  dxXPExplorerBarGroupHeaderFont := nil;
  dxXPExplorerBarGroupHeaderFontHot.Free;
  dxXPExplorerBarGroupHeaderFontHot := nil;

  dxXPExplorerBarGroupBorderColor := clNone;
end;

procedure LoadShellInstance;
begin
  FShellLibrary := LoadLibrary(ShellLibraryName);
  if FShellLibrary <> 0 then
    FSHGetShellStyleHInstancePointer := GetProcAddress(FShellLibrary, 'SHGetShellStyleHInstance');
  if FSHGetShellStyleHInstancePointer <> nil then
    @FSHGetShellStyleHInstance := FSHGetShellStyleHInstancePointer;
end;

procedure UnloadShellInstance;
begin
  if FShellLibrary <> 0 then
    FreeLibrary(FShellLibrary);
end;

function CheckShellInstance: Boolean;
begin
  Result := FShellInstance > 0;
end;

procedure CreateXPExplorerBarColors;
begin
  if FCounterXPExplorerBar = 0 then
  begin
    if FSHGetShellStyleHInstancePointer <> nil then
    begin
      FShellInstance := FSHGetShellStyleHInstance;
    end;
    CreateXPExplorerBarBitmaps;
    CreateXPExplorerBarStyleSheetAttributes;
  end;
  Inc(FCounterXPExplorerBar);
end;

procedure RefreshXPExplorerBarColors;
begin
  if FCounterXPExplorerBar <> 0 then
  begin
    FShellInstance := 0;
    DestroyXPExplorerBarBitmaps;
    DestroyXPExplorerBarStyleSheetAttributes;
    if FSHGetShellStyleHInstancePointer <> nil then
    begin
      FShellInstance := FSHGetShellStyleHInstance;
    end;
    CreateXPExplorerBarBitmaps;
    CreateXPExplorerBarStyleSheetAttributes;
  end;
end;

procedure ReleaseXPExplorerBarColors;
begin
  Dec(FCounterXPExplorerBar);
  if FCounterXPExplorerBar = 0 then
  begin
    FShellInstance := 0;
    DestroyXPExplorerBarBitmaps;
    DestroyXPExplorerBarStyleSheetAttributes;
  end;
end;

function XPScheme: TXPScheme;
const
  SZ_THDOCPROP_DISPLAYNAME = WideString('DisplayName'); // TODO: move to dxThemes.pas
  SZ_THDOCPROP_CANONICALNAME = WideString('ThemeName'); // TODO: move to dxThemes.pas
  SZ_MAX_CHARS = 1024;
  SStandardThemeFileName = 'LUNA.MSSTYLES';
  SNormalColor = 'NORMALCOLOR';
  SHomestead = 'HOMESTEAD';
  SMetallic = 'METALLIC';
var
  PThemeFileName, PThemeColor, PThemeSize: PWideChar;
  S: string;
begin
  Result := schUnknown;
  if AreVisualStylesAvailable then
  begin
    PThemeFileName := AllocMem(2 * SZ_MAX_CHARS);
    PThemeColor := AllocMem(2 * SZ_MAX_CHARS);
    PThemeSize := AllocMem(2 * SZ_MAX_CHARS);
    try
      if FAILED(GetCurrentThemeName(PThemeFileName, SZ_MAX_CHARS, PThemeColor,
        SZ_MAX_CHARS, PThemeSize, SZ_MAX_CHARS)) then
        Exit;
      S := UpperCase(ExtractFileName(PThemeFileName));
      if S = SStandardThemeFileName then
      begin
        S := UpperCase(PThemeColor);
        if S = SNormalColor then
          Result := schNormalColor
        else
          if S = SHomestead then
            Result := schHomestead
          else
            if S = SMetallic then
              Result := schMetallic;
      end;
    finally
      FreeMem(PThemeSize);
      FreeMem(PThemeColor);
      FreeMem(PThemeFileName);
    end;
  end;
end;

function LightColor(AColor: TColor): TColor;
begin
  Result := Light(AColor, 80);
end;

function LightLightColor(AColor: TColor): TColor;
begin
  Result := Light(AColor, 40);
end;

function DarkColor(AColor: TColor): TColor;
begin
  Result := Dark(AColor, 60);
end;

function DarkDarkColor(AColor: TColor): TColor;
begin
  Result := Dark(AColor, 40);
end;

function LightBorderColor(AColor: TColor): TColor;
begin
  Result := Light(AColor, 70);
end;

function LightLightBorderColor(AColor: TColor): TColor;
begin
  Result := Light(AColor, 20);
end;

function DarkBorderColor(AColor: TColor): TColor;
begin
  Result := Dark(AColor, 70);
end;

function DarkDarkBorderColor(AColor: TColor): TColor;
begin
  Result := Dark(AColor, 20);
end;

function CalcColor(d: Integer): TColor;
var
  clrColor: TColor;
  r, g, b: Integer;
  AMax, ADelta, AMaxDelta: Integer;
begin
  clrColor := clHighlight;
  r := GetRed(clrColor);
  g := GetGreen(clrColor);
  b := GetBlue(clrColor);
  AMax := Max(Max(r, g), b);
  ADelta := $23 + d;
  AMaxDelta := (255 - (AMax + ADelta));
  if AMaxDelta > 0 then AMaxDelta := 0;
  Inc(r, (ADelta + AMaxDelta + 5));
  Inc(g, (ADelta + AMaxDelta));
  Inc(b, (ADelta + AMaxDelta));
  if r > 255 then r := 255;
  if g > 255 then g := 255;
  if b > 255 then b := 255;
  Result := RGB(Abs(r), Abs(g), Abs(b));
  Result := ColorRefToARGB(Result);
end;

function CalcTextColor(AColor: TColor; AState: TdxNavBarObjectStates): TColor;
begin
  if AColor = clNone then
    Result := CalcColor(-50)
  else Result := AColor;

  if (sDisabled in AState) then
    Result := LightLightColor(Result)
  else if (sSelected in AState) or (sHotTracked in AState) or (sPressed in AState) then
    Result := LightColor(Result);
end;

function GetFontHeight(AFont: TFont): Integer;
var
  DC: HDC;
  SaveFont: HFont;
  Metrics: TTextMetric;
begin
  DC := GetDC(0);
  SaveFont := SelectObject(DC, AFont.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  Result := Metrics.tmHeight;
end;

procedure GetSystemFont(AFont: TFont);
var
  NonClientMetrics: TNonClientMetrics;
begin
  NonClientMetrics.cbSize := sizeof(NonClientMetrics);
  if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then
    AFont.Handle := Windows.CreateFontIndirect(NonClientMetrics.lfMessageFont)
  else
    AFont.Handle := GetStockObject(DEFAULT_GUI_FONT);
end;

type
  TColors = array of COLORREF;

procedure GetBitmapColors(ACanvas: TCanvas; ABitmap: TBitmap;
  var ABitmapInfo: TBitmapInfo; var ABitmapColors: TColors);
begin
  ABitmapInfo.bmiHeader.biSize := SizeOf(ABitmapInfo.bmiHeader);
  ABitmapInfo.bmiHeader.biWidth := ABitmap.Width;
  ABitmapInfo.bmiHeader.biHeight := -ABitmap.Height;
  ABitmapInfo.bmiHeader.biPlanes := 1;
  ABitmapInfo.bmiHeader.biBitCount := 32;
  ABitmapInfo.bmiHeader.biCompression := BI_RGB;
  SetLength(ABitmapColors, ABitmap.Height * ABitmap.Width);
  GetDIBits(ACanvas.Handle, ABitmap.Handle, 0, ABitmap.Height, ABitmapColors,
    ABitmapInfo, DIB_RGB_COLORS);
end;

procedure SetBitmapColors(ACanvas: TCanvas; ABitmap: TBitmap;
  var ABitmapInfo: TBitmapInfo; var ABitmapColors: TColors);
begin
  SetDIBits(ACanvas.Handle, ABitmap.Handle, 0, ABitmap.Height, ABitmapColors,
    ABitmapInfo, DIB_RGB_COLORS);
end;

procedure RevertRGB(AColor: COLORREF; out ARevertedColor: COLORREF);
begin
  ARevertedColor := RGB(GetBValue(AColor), GetGValue(AColor), GetRValue(AColor));
end;

{ TdxNavBarBackgroundPainter }

class procedure TdxNavBarBackgroundPainter.InternalDrawGradientBackground(
  ACanvas: TCanvas; ARect: TRect; APicture: TPicture; AEraseBackground: Boolean;
  ABackgroundColor: TColor; AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
  AGradientMode: TdxBarStyleGradientMode);
begin
  if CheckGdiPlus then
    dxGpFillRectByGradient(ACanvas.Handle, ARect, AColor1, AColor2,
      TdxGPLinearGradientMode(AGradientMode), AAlphaBlend1, AAlphaBlend2)
  else
    if (AAlphaBlend1 <> 0) or (AAlphaBlend2 <> 0) then
      FillGradientRect(ACanvas.Handle, ARect, AColor1, AColor2, AAlphaBlend1, AAlphaBlend2, AGradientMode);
end;

class procedure TdxNavBarBackgroundPainter.InternalDrawBackground(ACanvas: TCanvas;
  ARect: TRect; APicture: TPicture; AEraseBackground: Boolean; ABackgroundColor: TColor;
  AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
  AGradientMode: TdxBarStyleGradientMode);
begin
  if (APicture <> nil) and (APicture.Graphic <> nil) and not APicture.Graphic.Empty then
    DrawPicture(ACanvas, ARect, APicture)
  else if AEraseBackground then
  begin
    ACanvas.Brush.Style := bsSolid;
    ACanvas.Brush.Color := ABackgroundColor;
    ACanvas.FillRect(ARect);
  end;
  if (AColor1 = AColor2) and (AAlphaBlend1 = 255) and (AAlphaBlend2 = 255) then
  begin
    ACanvas.Brush.Style := bsSolid;
    ACanvas.Brush.Color := AColor1;
    ACanvas.FillRect(ARect);
  end
  else
    InternalDrawGradientBackground(ACanvas, ARect, APicture, AEraseBackground,
      ABackgroundColor, AColor1, AColor2, AAlphaBlend1, AAlphaBlend2, AGradientMode);
end;

class procedure TdxNavBarBackgroundPainter.DrawPicture(ACanvas: TCanvas; ARect: TRect;
  APicture: TPicture);
var
  dLeft, dTop, dWidth, dHeight: Integer;
  ABmp: TBitmap;
  ACreatedFlag: Boolean;
begin
  ABmp := nil;
  ACreatedFlag := False;
  if (APicture.Graphic is TBitmap) then
    ABmp := APicture.Bitmap
  else
  if (APicture.Graphic is TJPegImage) or (APicture.Graphic is TIcon) or (APicture.Graphic is TMetaFile) then
  begin
    ABmp := TBitmap.Create;
    ABmp.Height := APicture.Graphic.Height;
    ABmp.Width := APicture.Graphic.Height;
    ABmp.Canvas.Draw(0, 0, APicture.Graphic);
    ACreatedFlag := True;
  end;

  if ABmp <> nil then
  begin
    dTop := ARect.Top;
    while (dTop < ARect.Bottom) do begin
       dHeight := ABmp.Height;
       if (dTop + dHeight > ARect.Bottom) then
         dHeight := ARect.Bottom - dTop;
       dLeft := ARect.Left;
       while (dLeft < ARect.Right) do begin
         dWidth := ABmp.Width;
         if (dLeft + dWidth > ARect.Right) then
           dWidth := ARect.Right - dLeft;
         BitBlt(ACanvas.Handle, dLeft, dTop, dWidth, dHeight, ABmp.Canvas.Handle, 0, 0, SRCCOPY);
         Inc(dLeft, dWidth);
       end;
       Inc(dTop, dHeight);
    end;
    if ACreatedFlag then ABmp.Free;
  end;
end;

class procedure TdxNavBarBackgroundPainter.FillGradientRect(DC: HDC; const ARect: TRect;
  AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte; AGradientMode: TdxBarStyleGradientMode);

  function CalcColorComponent(AFromColorComponent, AToColorComponent: Byte;
    AGradientSize: TSize; AGradientPos: TPoint): Integer;
  var
    AFromToColorSize: Integer;
  begin
    AFromToColorSize := AToColorComponent - AFromColorComponent;
    case AGradientMode of
      gmHorizontal:
        Result := AFromColorComponent +
          MulDiv(AGradientPos.X, AFromToColorSize, (AGradientSize.cx - 1));
      gmVertical:
        Result := AFromColorComponent +
          MulDiv(AGradientPos.Y, AFromToColorSize, (AGradientSize.cy - 1));
      gmForwardDiagonal:
        Result := AFromColorComponent +
          (MulDiv(AGradientPos.X, AFromToColorSize, (AGradientSize.cx - 1)) +
          MulDiv(AGradientPos.Y, AFromToColorSize, (AGradientSize.cy - 1))) div 2;
      gmBackwardDiagonal:
        Result := AFromColorComponent +
          (MulDiv(AGradientSize.cx - 1 - AGradientPos.X, AFromToColorSize, (AGradientSize.cx - 1)) +
          MulDiv(AGradientPos.Y, AFromToColorSize, (AGradientSize.cy - 1))) div 2;
    else
      Result := 0;
    end
  end;

  function CalcRGBColor(AFromColor, AToColor: TColor;
    AGradientSize: TSize; AGradientPos: TPoint): TColor;
  var
    R, G, B: Byte;
  begin
    R := CalcColorComponent(GetRValue(AFromColor), GetRValue(AToColor),
      AGradientSize, AGradientPos);
    G := CalcColorComponent(GetGValue(AFromColor), GetGValue(AToColor),
      AGradientSize, AGradientPos);
    B := CalcColorComponent(GetBValue(AFromColor), GetBValue(AToColor),
      AGradientSize, AGradientPos);
    Result := RGB(R, G, B);
  end;

  function GetGradientSize(ARect: TRect): TSize;
  const
    MaxGradientHeight = 256;
    MaxGradientWidth = 256;
  var
    ARectWidth, ARectHeight: Integer;
  begin
    ARectWidth := ARect.Right - ARect.Left;
    ARectHeight := ARect.Bottom - ARect.Top;
    if ARectWidth < MaxGradientWidth then
      Result.cx := ARectWidth
    else
      Result.cx := MaxGradientWidth;
    if ARectHeight < MaxGradientHeight then
      Result.cy := ARectHeight
    else
      Result.cy := MaxGradientHeight;
  end;

var
  AOneColorRect: TRect;
  I, J, ARectWidth, ARectHeight: Integer;
  ABrush: HBRUSH;
  AGradientSize: TSize;

begin
  AColor1 := ColorToRGB(AColor1);
  AColor2 := ColorToRGB(AColor2);
  if AColor1 = AColor2 then
  begin
    ABrush := CreateSolidBrush(AColor1);
    FillRect(DC, ARect, ABrush);
    DeleteObject(ABrush);
    Exit;
  end;

  AOneColorRect := ARect;
  ARectWidth := ARect.Right - ARect.Left;
  ARectHeight := ARect.Bottom - ARect.Top;
  AGradientSize := GetGradientSize(ARect);

  for I := 0 to AGradientSize.cy - 1 do
  begin
    AOneColorRect.Bottom := ARect.Top + MulDiv(I + 1, ARectHeight, AGradientSize.cy);
    for J := 0 to AGradientSize.cx - 1 do
    begin
      AOneColorRect.Right := ARect.Left + MulDiv(J + 1, ARectWidth, AGradientSize.cx);
      if not IsRectEmpty(AOneColorRect) then
      begin
        ABrush := CreateSolidBrush(
          CalcRGBColor(AColor1, AColor2, AGradientSize, Point(J, I)));
        FillRect(DC, AOneColorRect, ABrush);
        DeleteObject(ABrush);
      end;
      AOneColorRect.Left := AOneColorRect.Right;
      if AOneColorRect.Left >= ARect.Right then
        Break;
    end;
    AOneColorRect.Top := AOneColorRect.Bottom;
    if AOneColorRect.Top >= ARect.Bottom then
      Break;
    AOneColorRect.Left := ARect.Left;
  end;
end;

{ TdxNavBarGroupBackgroundPainter }

class procedure TdxNavBarGroupBackgroundPainter.InternalDrawBackground(ACanvas: TCanvas;
  ARect: TRect; APicture: TPicture; AColor1, AColor2: TColor;
  AAlphaBlend1, AAlphaBlend2: Byte; AGradientMode: TdxBarStyleGradientMode);
begin
  TdxNavBarBackgroundPainter.DrawBackground(ACanvas, ARect, APicture, False, clNone,
    AColor1, AColor2, AAlphaBlend1, AAlphaBlend2, AGradientMode);
end;

{ TdxNavBarExplorerBarBorderPainter }

class procedure TdxNavBarExplorerBarBorderPainter.InternalDrawBorder(ACanvas: TCanvas;
  ARect: TRect; AColor: TColor; AWithCaption: Boolean);
begin
  ACanvas.Pen.Width := 1;
  ACanvas.Pen.Style := psSolid;
  ACanvas.Pen.Color := AColor;
  ACanvas.MoveTo(ARect.Left, ARect.Top);
  ACanvas.LineTo(ARect.Left, ARect.Bottom - 1);
  ACanvas.LineTo(ARect.Right - 1, ARect.Bottom - 1);
  ACanvas.LineTo(ARect.Right - 1, ARect.Top - 1);
  if not AWithCaption then
  begin
    ACanvas.MoveTo(ARect.Right - 1, ARect.Top);
    ACanvas.LineTo(ARect.Left - 1, ARect.Top);
  end;
end;

{ TdxNavBarBaseImagePainter }

class procedure TdxNavBarImagePainter.InternalDrawImage(ACanvas: TCanvas;
  AImageList: TCustomImageList; AImageIndex: Integer; ARect: TRect; AEnabled: Boolean);
var
  ASavedDCInfo: Integer;
begin
  if IsValidImage(AImageList, AImageIndex) then
  begin
    ASavedDCInfo := SaveDC(ACanvas.Handle);
    AImageList.Draw(ACanvas, ARect.Left, ARect.Top, AImageIndex, AEnabled or DrawIconsAsEnabled);
    RestoreDC(ACanvas.Handle, ASavedDCInfo);
  end;
end;

class function TdxNavBarImagePainter.GetRGBColor(Value: TColor): DWORD;
begin
  Result := ColorToRGB(Value);
  case Result of
    clNone: Result := CLR_NONE;
    clDefault: Result := CLR_DEFAULT;
  end;
end;

{ TdxNavBarSelectionPainter }

class procedure TdxNavBarSelectionPainter.InternalDrawSelection(ACanvas: TCanvas; ARect: TRect;
    ABackColor: TColor; AState: TdxNavBarObjectStates);
begin
  ACanvas.Brush.Style := bsClear;      
  ACanvas.Pen.Width := 1;
  ACanvas.Pen.Style := psSolid;
  if (sSelected in AState) or (sPressed in AState) then
  begin
    ACanvas.Pen.Color := DarkDarkBorderColor(ABackColor);
    ACanvas.MoveTo(ARect.Left, ARect.Bottom - 1);
    ACanvas.LineTo(ARect.Left, ARect.Top);
    ACanvas.LineTo(ARect.Right - 1, ARect.Top);
    ACanvas.Pen.Color := LightLightBorderColor(ABackColor);
    ACanvas.LineTo(ARect.Right - 1, ARect.Bottom - 1);
    ACanvas.LineTo(ARect.Left - 1, ARect.Bottom - 1);
  end
  else if (sHotTracked in AState) then
  begin
    ACanvas.Pen.Color := LightLightBorderColor(ABackColor);
    ACanvas.MoveTo(ARect.Left, ARect.Bottom - 1);
    ACanvas.LineTo(ARect.Left, ARect.Top);
    ACanvas.LineTo(ARect.Right - 1, ARect.Top);
    ACanvas.Pen.Color := DarkDarkBorderColor(ABackColor);
    ACanvas.LineTo(ARect.Right - 1, ARect.Bottom - 1);
    ACanvas.LineTo(ARect.Left - 1, ARect.Bottom - 1);
  end;
end;

{ TdxNavBarUltraFlatSelectionPainter }

class procedure TdxNavBarUltraFlatSelectionPainter.InternalDrawSelection(ACanvas: TCanvas; ARect: TRect;
    ABackColor: TColor; AState: TdxNavBarObjectStates);
begin
  if not ((sSelected in AState) or (sPressed in AState) or (sHotTracked in AState)) then exit;
  ACanvas.Pen.Style := psSolid;
  ACanvas.Pen.Color := ColorToRGB(clHighlight);
  ACanvas.Brush.Style := bsSolid;
  if (sPressed in AState) and not (sSelected in AState) then
    ACanvas.Brush.Color := FlatBarItemPressedBackColor
  else ACanvas.Brush.Color := FlatBarItemHighLightBackColor;
  ACanvas.Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
end;

class function TdxNavBarUltraFlatSelectionPainter.FlatBarItemPressedBackColor: TColor;
begin
  Result := GetRealColor(GetLightColor(14, 44, 40));
end;

class function TdxNavBarUltraFlatSelectionPainter.FlatBarItemHighLightBackColor: TColor;
begin
  Result := GetRealColor(GetLightColor(-2, 30, 72));
end;

{ TdxNavBarVSToolBoxSelectionPainter }

class procedure TdxNavBarVSToolBoxSelectionPainter.InternalDrawSelection(ACanvas: TCanvas; ARect: TRect;
    ABackColor: TColor; AState: TdxNavBarObjectStates);
begin
  ACanvas.Brush.Style := bsClear;      
  ACanvas.Pen.Width := 1;
  ACanvas.Pen.Style := psSolid;
  if (sSelected in AState) or (sPressed in AState) then
  begin
    ACanvas.Pen.Color := DarkBorderColor(ABackColor);
    ACanvas.MoveTo(ARect.Left, ARect.Bottom - 1);
    ACanvas.LineTo(ARect.Left, ARect.Top);
    ACanvas.LineTo(ARect.Right - 1, ARect.Top);
    ACanvas.Pen.Color := LightBorderColor(ABackColor);
    ACanvas.LineTo(ARect.Right - 1, ARect.Bottom - 1);
    ACanvas.LineTo(ARect.Left - 1, ARect.Bottom - 1);
  end
  else if (sHotTracked in AState) then
  begin
    ACanvas.Pen.Color := LightLightBorderColor(ABackColor);
    ACanvas.MoveTo(ARect.Left, ARect.Bottom - 1);
    ACanvas.LineTo(ARect.Left, ARect.Top);
    ACanvas.LineTo(ARect.Right - 1, ARect.Top);
    ACanvas.Pen.Color := DarkDarkBorderColor(ABackColor);
    ACanvas.LineTo(ARect.Right - 1, ARect.Bottom - 1);
    ACanvas.LineTo(ARect.Left - 1, ARect.Bottom - 1);
    InflateRect(ARect, -1, -1);
    ACanvas.Pen.Color := LightBorderColor(ABackColor);
    ACanvas.MoveTo(ARect.Left, ARect.Bottom - 1);
    ACanvas.LineTo(ARect.Left, ARect.Top);
    ACanvas.LineTo(ARect.Right, ARect.Top);
  end;
end;

{ TdxNavBarExplorerBarSignPainter }

class procedure TdxNavBarExplorerBarSignPainter.InternalDrawSign(ACanvas: TCanvas;
  ARect: TRect; AForeColor, ABackColor1, ABackColor2 : TColor;
  AState: TdxNavBarObjectStates);
var
  pt1, pt2, pt3: TPoint;
begin
  DrawSignSelection(ACanvas, ARect, AForeColor, ABackColor1, ABackColor2, AState);

  ACanvas.Pen.Color := AForeColor;
  ACanvas.Pen.Style := psSolid;
  ACanvas.Pen.Width := 1;

  pt1.X := ARect.Left + (ARect.Right - ARect.Left) div 2 - 1;
  pt1.Y := ARect.Top + (ARect.Bottom - ARect.Top) div 2 - (4 div 2) - 1 - 1;
  pt2.X := pt1.X - 7 div 2;
  pt2.Y := pt1.Y + 4 - 1;
  pt3.X := pt2.X + 7;
  pt3.Y := pt2.Y + 1;
  if not (sExpanded in AState) then
  begin
    pt1.Y := pt1.Y + 2 * ((ARect.Bottom - ARect.Top) div 2 - (pt1.Y - ARect.Top));
    pt2.Y := pt2.Y + 2 * ((ARect.Bottom - ARect.Top) div 2 - (pt2.Y - ARect.Top));
    pt3.Y := pt3.Y + 2 * ((ARect.Bottom - ARect.Top) div 2 - (pt3.Y - ARect.Top));
  end;
  ACanvas.Polyline([pt2, pt1, pt3]);
  if not (sExpanded in AState) then
    ACanvas.Polyline([{$IFDEF DELPHI6}Types.{$ENDIF}Point(pt2.x + 1, pt2.y),
      {$IFDEF DELPHI6}Types.{$ENDIF}Point(pt1.x, pt1.y - 1),
      {$IFDEF DELPHI6}Types.{$ENDIF}Point(pt3.x - 1, pt3.y)])
  else ACanvas.Polyline([{$IFDEF DELPHI6}Types.{$ENDIF}Point(pt2.x + 1, pt2.y),
    {$IFDEF DELPHI6}Types.{$ENDIF}Point(pt1.x, pt1.y + 1),
    {$IFDEF DELPHI6}Types.{$ENDIF}Point(pt3.x - 1, pt3.y)]);
  if not (sExpanded in AState) then
  begin
    pt1.Y := pt1.Y - 4;
    pt2.Y := pt2.Y - 4;
    pt3.Y := pt3.Y - 4;
  end
  else
  begin
    pt1.Y := pt1.Y + 4;
    pt2.Y := pt2.Y + 4;
    pt3.Y := pt3.Y + 4;
  end;
  ACanvas.Polyline([pt2, pt1, pt3]);
  if not (sExpanded in AState) then
    ACanvas.Polyline([{$IFDEF DELPHI6}Types.{$ENDIF}Point(pt2.x + 1, pt2.y),
      {$IFDEF DELPHI6}Types.{$ENDIF}Point(pt1.x, pt1.y - 1),
      {$IFDEF DELPHI6}Types.{$ENDIF}Point(pt3.x - 1, pt3.y)])
  else ACanvas.Polyline([{$IFDEF DELPHI6}Types.{$ENDIF}Point(pt2.x + 1, pt2.y),
    {$IFDEF DELPHI6}Types.{$ENDIF}Point(pt1.x, pt1.y + 1),
    {$IFDEF DELPHI6}Types.{$ENDIF}Point(pt3.x - 1, pt3.y)]);
end;

class procedure TdxNavBarExplorerBarSignPainter.DrawSignSelection(ACanvas: TCanvas;
  ARect: TRect; AForeColor, ABackColor1, ABackColor2: TColor; AState: TdxNavBarObjectStates);
begin
  if sHotTracked in AState then
    DrawEdge(ACanvas.Handle, ARect, BDR_RAISEDINNER, BF_RECT);
end;

{ TdxNavAdvBarExplorerBarSignPainter }

class procedure TdxNavBarAdvExplorerBarSignPainter.PrepareBitmap(ACanvas: TCanvas;
  ARect: TRect; ABitmap: TBitmap; AForeColor: TColor; AState: TdxNavBarObjectStates);

  function GetSignBitmap: TBitmap;
  begin
    (*if sSpecial in AState then
      if sExpanded in AState then
        Result := dxAdvExplorerBarSpecialGroupCaptionCollapseSignBitmap
      else
        Result := dxAdvExplorerBarSpecialGroupCaptionExpandSignBitmap
    else*)
      if sExpanded in AState then
        Result := dxAdvExplorerBarGroupCaptionCollapseSignBitmap
      else
        Result := dxAdvExplorerBarGroupCaptionExpandSignBitmap;
  end;

var
  BitmapInfo: TBitmapInfo;
  BitmapColors: TColors;
  I, J: Integer;
  ATransparentColor, AMarksColor, APixelColor, ABgColor: COLORREF;
begin
  ABitmap.Assign(GetSignBitmap);

  GetBitmapColors(ACanvas, ABitmap, BitmapInfo, BitmapColors);

  AForeColor := ColorToRGB(AForeColor);
  RevertRGB(BitmapColors[0], ATransparentColor);
  AMarksColor := clBlue;

  for I := 0 to ABitmap.Width - 1 do
    for J := 0 to ABitmap.Height - 1 do
    begin
      RevertRGB(BitmapColors[J * ABitmap.Width + I], APixelColor);
      if APixelColor <> ATransparentColor then
        if APixelColor = AMarksColor then
          RevertRGB(AForeColor, BitmapColors[J * ABitmap.Width + I])
        else
        begin
          ABgColor := ACanvas.Pixels[ARect.Left + I, ARect.Top + J];
          APixelColor := GetMiddleRGB(ABgColor, APixelColor,
            MulDiv((255 - GetRValue(APixelColor)), 100, 255));
          RevertRGB(APixelColor, BitmapColors[J * ABitmap.Width + I]);
        end;
    end;

  SetBitmapColors(ACanvas, ABitmap, BitmapInfo, BitmapColors);

  ABitmap.Transparent := True;
end;

class procedure TdxNavBarAdvExplorerBarSignPainter.InternalDrawSign(ACanvas: TCanvas; ARect: TRect;
    AForeColor, ABackColor1, ABackColor2 : TColor; AState: TdxNavBarObjectStates);
var
  ABitmap: TBitmap;
begin
  ABitmap := TBitmap.Create;
  try
    PrepareBitmap(ACanvas, ARect, ABitmap, AForeColor, AState);
    ACanvas.Draw(ARect.Left, ARect.Top, ABitmap);
  finally
    ABitmap.Free;
  end;
end;

{ TdxNavBarOffice11SignPainter }

class procedure TdxNavBarOffice11SignPainter.PrepareBitmap(ACanvas: TCanvas;
  ABitmap: TBitmap; ABackColor1, ABackColor2: TColor; AState: TdxNavBarObjectStates);
var
  BitmapInfo: TBitmapInfo;
  BitmapColors: TColors;
  ATransparentColor, AColor1, AColor2, APixelColor: COLORREF;
  AMinValue, AMaxValue, AValue: Byte;
  I, J: Integer;
begin
  if sExpanded in AState then
    ABitmap.Assign(dxOffice11CaptionCollapseSignBitmap)
  else
    ABitmap.Assign(dxOffice11CaptionExpandSignBitmap);

  GetBitmapColors(ACanvas, ABitmap, BitmapInfo, BitmapColors);

  RevertRGB(BitmapColors[0], ATransparentColor);
  AColor1 := ColorToRGB(ABackColor1);
  AColor2 := ColorToRGB(ABackColor2);

  AMaxValue := 1;
  AMinValue := 255;
  for I := 0 to ABitmap.Width - 1 do
    for J := 0 to ABitmap.Height - 1 do
    begin
      RevertRGB(BitmapColors[J * ABitmap.Width + I], APixelColor);
      if (APixelColor <> ATransparentColor) and (APixelColor <> 0{mark}) then
      begin
        AValue := GetRValue(APixelColor);
        if AValue > AMaxValue then
          AMaxValue := AValue;
        if AValue < AMinValue then
          AMinValue := AValue;
      end;
    end;

  for I := 0 to ABitmap.Width - 1 do
    for J := 0 to ABitmap.Height - 1 do
    begin
      RevertRGB(BitmapColors[J * ABitmap.Width + I], APixelColor);
      if (APixelColor <> ATransparentColor) and (APixelColor <> 0{mark}) then
      begin
        AValue := GetRValue(APixelColor);
        APixelColor := GetMiddleRGB(AColor1, AColor2,
          MulDiv(AValue - AMinValue, 100, AMaxValue - AMinValue));
        RevertRGB(APixelColor, BitmapColors[J * ABitmap.Width + I]);
      end;
    end;

  SetBitmapColors(ACanvas, ABitmap, BitmapInfo, BitmapColors);

  ABitmap.Transparent := True;
end;

class procedure TdxNavBarOffice11SignPainter.InternalDrawSign(ACanvas: TCanvas; ARect: TRect;
    AForeColor, ABackColor1, ABackColor2: TColor; AState: TdxNavBarObjectStates);
var
  ABitmap: TBitmap;
begin
  ABitmap := TBitmap.Create;
  try
    PrepareBitmap(ACanvas, ABitmap, ABackColor1, ABackColor2, AState);
    ACanvas.Draw(ARect.Left, ARect.Top, ABitmap);
  finally
    ABitmap.Free;
  end;
end;

{ TdxNavBarHintPainter }

class procedure TdxNavBarHintPainter.InternalDrawHint(ACanvas: TCanvas; ARect: TRect; AHint: string;
    APicture: TPicture; AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
    AGradientMode: TdxBarStyleGradientMode; AFont: TFont);
begin
  if AHint <> '' then
  begin
    TdxNavBarBackgroundPainter.DrawBackground(ACanvas, ARect, APicture, True, clInfoBk,
        AColor1, AColor2, AAlphaBlend1, AAlphaBlend2, AGradientMode);
    Windows.DrawEdge(ACanvas.Handle, ARect, BDR_RAISEDOUTER, BF_RECT);
    InflateRect(ARect, -1, -1);
    Inc(ARect.Left, dxNavBarHintWindowTextOffset.X);
    Inc(ARect.Top, dxNavBarHintWindowTextOffset.Y);
    ACanvas.Font := AFont;
    ACanvas.Brush.Style := bsClear;
    cxDrawText(ACanvas.Handle, AHint, ARect, DT_LEFT or DT_NOPREFIX or DT_WORDBREAK);
  end;
end;

{ TdxNavBarButtonPainter }

class procedure TdxNavBarButtonPainter.InternalDrawButton(ACanvas: TCanvas; ARect: TRect;
  APicture: TPicture; AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
  AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor; AState: TdxNavBarObjectStates);
var
  R: TRect;
begin
  R := ARect;
  TdxNavBarBackgroundPainter.DrawBackground(ACanvas, R, APicture, False, clBtnFace, AColor1, AColor2,
      AAlphaBlend1, AAlphaBlend2, AGradientMode);

  ACanvas.Brush.Style := bsClear;      
  ACanvas.Pen.Width := 1;
  ACanvas.Pen.Style := psSolid;
  if sPressed in AState then
  begin
    ACanvas.Pen.Color := DarkDarkBorderColor(AColor1);
    ACanvas.Rectangle(R.Left, R.Top, R.Right, R.Bottom);
    InflateRect(R, -1, -1);
    ACanvas.Pen.Color := DarkBorderColor(AColor1);
    ACanvas.Rectangle(R.Left, R.Top, R.Right, R.Bottom);
  end
  else
  begin
    ACanvas.Pen.Color := LightLightBorderColor(AColor1);
    ACanvas.MoveTo(R.Left, R.Bottom - 1);
    ACanvas.LineTo(R.Left, R.Top);
    ACanvas.LineTo(R.Right - 1, R.Top);
    ACanvas.Pen.Color := DarkDarkBorderColor(AColor1);
    ACanvas.LineTo(R.Right - 1, R.Bottom - 1);
    ACanvas.LineTo(R.Left - 1, R.Bottom - 1);
    InflateRect(R, -1, -1);
    ACanvas.Pen.Color := LightBorderColor(AColor1);
    ACanvas.MoveTo(R.Left, R.Bottom - 1);
    ACanvas.LineTo(R.Left, R.Top);
    ACanvas.LineTo(R.Right - 1, R.Top);
    ACanvas.Pen.Color := DarkBorderColor(AColor1);
    ACanvas.LineTo(R.Right - 1, R.Bottom - 1);
    ACanvas.LineTo(R.Left - 1, R.Bottom - 1);
  end;
  if sActive in AState then
  begin
    R := ARect;
    ACanvas.Pen.Color := clBlack;
    ACanvas.MoveTo(R.Left, R.Bottom - 1);
    ACanvas.LineTo(R.Right, R.Bottom - 1);
  end;
end;

{ TdxNavBarFlatButtonPainter }

class procedure TdxNavBarFlatButtonPainter.InternalDrawButton(ACanvas: TCanvas; ARect: TRect;
  APicture: TPicture; AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
  AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor; AState: TdxNavBarObjectStates);
var
  R: TRect;
begin
  R := ARect;
  TdxNavBarBackgroundPainter.DrawBackground(ACanvas, R, APicture, False, clBtnFace, AColor1, AColor2,
    AAlphaBlend1, AAlphaBlend2, AGradientMode);

  ACanvas.Brush.Style := bsClear;
  ACanvas.Pen.Width := 1;
  ACanvas.Pen.Style := psSolid;
  if sPressed in AState then
  begin
    ACanvas.Pen.Color := DarkDarkBorderColor(AColor1);
    ACanvas.MoveTo(R.Left, R.Bottom - 1);
    ACanvas.LineTo(R.Left, R.Top);
    ACanvas.LineTo(R.Right - 1, R.Top);
    ACanvas.Pen.Color := LightLightBorderColor(AColor1);
    ACanvas.LineTo(R.Right - 1, R.Bottom - 1);
    ACanvas.LineTo(R.Left - 1, R.Bottom - 1);
    InflateRect(R, -1, -1);
    ACanvas.Pen.Color := DarkBorderColor(AColor1);
    ACanvas.MoveTo(R.Left, R.Bottom - 1);
    ACanvas.LineTo(R.Left, R.Top);
    ACanvas.LineTo(R.Right, R.Top);
  end
  else if sHotTracked in AState then
  begin
    ACanvas.Pen.Color := LightLightBorderColor(AColor1);
    ACanvas.MoveTo(R.Left, R.Bottom - 1);
    ACanvas.LineTo(R.Left, R.Top);
    ACanvas.LineTo(R.Right - 1, R.Top);
    ACanvas.Pen.Color := DarkDarkBorderColor(AColor1);
    ACanvas.LineTo(R.Right - 1, R.Bottom - 1);
    ACanvas.LineTo(R.Left - 1, R.Bottom - 1);
    InflateRect(R, -1, -1);
    ACanvas.Pen.Color := DarkBorderColor(AColor1);
    ACanvas.MoveTo(R.Right - 1, R.Top);
    ACanvas.LineTo(R.Right - 1, R.Bottom - 1);
    ACanvas.LineTo(R.Left - 1, R.Bottom - 1);
  end
  else
  begin
    ACanvas.Pen.Color := LightLightBorderColor(AColor1);
    ACanvas.MoveTo(R.Left, R.Bottom - 1);
    ACanvas.LineTo(R.Left, R.Top);
    ACanvas.LineTo(R.Right - 1, R.Top);
    ACanvas.Pen.Color := DarkBorderColor(AColor1);
    ACanvas.LineTo(R.Right - 1, R.Bottom - 1);
    ACanvas.LineTo(R.Left - 1, R.Bottom - 1);
  end;
  if sActive in AState then
  begin
    R := ARect;
    ACanvas.Pen.Color := clBlack;
    ACanvas.MoveTo(R.Left, R.Bottom - 1);
    ACanvas.LineTo(R.Right, R.Bottom - 1);
  end;
end;

{ TdxNavBarVSToolBoxButtonPainter }

class procedure TdxNavBarVSToolBoxButtonPainter.InternalDrawButton(ACanvas: TCanvas; ARect: TRect;
  APicture: TPicture; AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
  AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor; AState: TdxNavBarObjectStates);
var
  R: TRect;
begin
  R := ARect;
  TdxNavBarBackgroundPainter.DrawBackground(ACanvas, R, APicture, False, clBtnFace, AColor1, AColor2,
    AAlphaBlend1, AAlphaBlend2, AGradientMode);

  ACanvas.Brush.Style := bsClear;
  ACanvas.Pen.Width := 1;
  ACanvas.Pen.Style := psSolid;
  if sPressed in AState then
  begin
    ACanvas.Pen.Color := DarkDarkBorderColor(AColor1);
    ACanvas.MoveTo(R.Left, R.Bottom - 1);
    ACanvas.LineTo(R.Left, R.Top);
    ACanvas.LineTo(R.Right - 1, R.Top);
    ACanvas.Pen.Color := LightLightBorderColor(AColor1);
    ACanvas.LineTo(R.Right - 1, R.Bottom - 1);
    ACanvas.LineTo(R.Left - 1, R.Bottom - 1);
    InflateRect(R, -1, -1);
    ACanvas.Pen.Color := DarkBorderColor(AColor1);
    ACanvas.MoveTo(R.Left, R.Bottom - 1);
    ACanvas.LineTo(R.Left, R.Top);
    ACanvas.LineTo(R.Right, R.Top);
  end
  else
  begin
    ACanvas.Pen.Color := LightLightBorderColor(AColor1);
    ACanvas.MoveTo(R.Left, R.Bottom - 1);
    ACanvas.LineTo(R.Left, R.Top);
    ACanvas.LineTo(R.Right - 1, R.Top);
    ACanvas.Pen.Color := DarkDarkBorderColor(AColor1);
    ACanvas.LineTo(R.Right - 1, R.Bottom - 1);
    ACanvas.LineTo(R.Left - 1, R.Bottom - 1);
    InflateRect(R, -1, -1);
    ACanvas.Pen.Color := LightBorderColor(AColor1);
    ACanvas.MoveTo(R.Left, R.Bottom - 1);
    ACanvas.LineTo(R.Left, R.Top);
    ACanvas.LineTo(R.Right, R.Top);
  end;
end;

{ TdxNavBarOfficeButtonPainter }

class procedure TdxNavBarOfficeButtonPainter.InternalDrawButton(ACanvas: TCanvas; ARect: TRect;
  APicture: TPicture; AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
  AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor; AState: TdxNavBarObjectStates);
var
  R: TRect;
begin
  R := ARect;
  TdxNavBarBackgroundPainter.DrawBackground(ACanvas, R, APicture, False, clBtnFace, AColor1, AColor2,
    AAlphaBlend1, AAlphaBlend2, AGradientMode);

  ACanvas.Brush.Style := bsClear;
  ACanvas.Pen.Width := 1;
  ACanvas.Pen.Style := psSolid;
  if sPressed in AState then
  begin
    ACanvas.Pen.Color := DarkDarkBorderColor(AColor1);
    ACanvas.MoveTo(R.Left, R.Bottom - 1);
    ACanvas.LineTo(R.Left, R.Top);
    ACanvas.LineTo(R.Right - 1, R.Top);
    ACanvas.Pen.Color := LightLightBorderColor(AColor1);
    ACanvas.LineTo(R.Right - 1, R.Bottom - 1);
    ACanvas.LineTo(R.Left - 1, R.Bottom - 1);
    InflateRect(R, -1, -1);
    ACanvas.Pen.Color := DarkBorderColor(AColor1);
    ACanvas.MoveTo(R.Left, R.Bottom - 1);
    ACanvas.LineTo(R.Left, R.Top);
    ACanvas.LineTo(R.Right, R.Top);
  end
  else if sHotTracked in AState then
  begin
    ACanvas.Pen.Color := LightLightBorderColor(AColor1);
    ACanvas.MoveTo(R.Left, R.Bottom - 1);
    ACanvas.LineTo(R.Left, R.Top);
    ACanvas.LineTo(R.Right - 1, R.Top);
    ACanvas.Pen.Color := DarkDarkBorderColor(AColor1);
    ACanvas.LineTo(R.Right - 1, R.Bottom - 1);
    ACanvas.LineTo(R.Left - 1, R.Bottom - 1);
    InflateRect(R, -1, -1);
    ACanvas.Pen.Color := LightBorderColor(AColor1);
    ACanvas.MoveTo(R.Left, R.Bottom - 1);
    ACanvas.LineTo(R.Left, R.Top);
    ACanvas.LineTo(R.Right - 1, R.Top);
    ACanvas.Pen.Color := DarkBorderColor(AColor1);
    ACanvas.LineTo(R.Right - 1, R.Bottom - 1);
    ACanvas.LineTo(R.Left - 1, R.Bottom - 1);
  end
  else
  begin
    ACanvas.Pen.Color := LightLightBorderColor(AColor1);
    ACanvas.MoveTo(R.Left, R.Bottom - 1);
    ACanvas.LineTo(R.Left, R.Top);
    ACanvas.LineTo(R.Right - 1, R.Top);
    ACanvas.Pen.Color := DarkDarkBorderColor(AColor1);
    ACanvas.LineTo(R.Right - 1, R.Bottom - 1);
    ACanvas.LineTo(R.Left - 1, R.Bottom - 1);
  end;
  if sActive in AState then
  begin
    R := ARect;
    ACanvas.Pen.Color := clBlack;
    ACanvas.MoveTo(R.Left, R.Bottom - 1);
    ACanvas.LineTo(R.Right, R.Bottom - 1);
  end;
end;

{ TdxNavBarOfficeNavPaneButtonPainter }

class procedure TdxNavBarOffice11NavPaneButtonPainter.InternalDrawButton(ACanvas: TCanvas; ARect: TRect; APicture: TPicture;
  AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
  AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor;
  AState: TdxNavBarObjectStates);
begin
  TdxNavBarBackgroundPainter.DrawBackground(ACanvas, ARect, APicture, False, clBtnFace, AColor1, AColor2,
    AAlphaBlend1, AAlphaBlend2, AGradientMode);
  ACanvas.Brush.Style := bsClear;
  ACanvas.Pen.Color := ColorToRGB(ABorderColor);
  ACanvas.Pen.Style := psSolid;
  ACanvas.Pen.Width := 1;
  ACanvas.Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
end;

{ TdxNavBarOffice11NavPaneGroupButtonPainter }

class procedure TdxNavBarOffice11NavPaneGroupButtonPainter.InternalDrawButton(ACanvas: TCanvas; ARect: TRect;
    APicture: TPicture; AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
    AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor; AState: TdxNavBarObjectStates);
var
  ABackgroundRect: TRect;
begin
  ABackgroundRect := ARect;
  Inc(ABackgroundRect.Top);
  TdxNavBarBackgroundPainter.DrawBackground(ACanvas, ABackgroundRect, APicture, False, clBtnFace, AColor1, AColor2,
    AAlphaBlend1, AAlphaBlend2, AGradientMode);
  ACanvas.Pen.Color := ColorToRGB(ABorderColor);
  ACanvas.Pen.Style := psSolid;
  ACanvas.Pen.Width := 1;
  ACanvas.MoveTo(ARect.Left, ARect.Top);
  ACanvas.LineTo(ARect.Right, ARect.Top);
end;

{ TdxNavBarExplorerButtonPainter }

class procedure TdxNavBarExplorerButtonPainter.InternalDrawButton(ACanvas: TCanvas; ARect: TRect;
  APicture: TPicture; AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
  AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor; AState: TdxNavBarObjectStates);
begin
  TdxNavBarBackgroundPainter.DrawBackground(ACanvas, ARect, APicture, False, clBtnFace, AColor1, AColor2,
    AAlphaBlend1, AAlphaBlend2, AGradientMode);
end;

{ TdxNavBarAdvExplorerButtonPainter }

class procedure TdxNavBarAdvExplorerButtonPainter.InternalDrawButton(ACanvas: TCanvas; ARect: TRect;
    APicture: TPicture; AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
    AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor; AState: TdxNavBarObjectStates);
begin
  ExcludeClipRect(ACanvas.Handle, ARect.Left, ARect.Top, ARect.Left + 2, ARect.Top + 1);
  ExcludeClipRect(ACanvas.Handle, ARect.Left, ARect.Top, ARect.Left + 1, ARect.Top + 2);
  ExcludeClipRect(ACanvas.Handle, ARect.Right - 2, ARect.Top, ARect.Right, ARect.Top + 1);
  ExcludeClipRect(ACanvas.Handle, ARect.Right - 1, ARect.Top, ARect.Right, ARect.Top + 2);

  TdxNavBarBackgroundPainter.DrawBackground(ACanvas, ARect, APicture, False, clBtnFace, AColor1, AColor2,
    AAlphaBlend1, AAlphaBlend2, AGradientMode);

  SelectClipRgn(ACanvas.Handle, 0);
end;

{ TdxNavBarOffice11ButtonPainter }

class procedure TdxNavBarOffice11ButtonPainter.InternalDrawButton(ACanvas: TCanvas;
    ARect: TRect; APicture: TPicture; AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
    AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor; AState: TdxNavBarObjectStates);
begin
  inherited;
end;

{ TdxNavBarScrollButtonsPainter }

class procedure TdxNavBarScrollButtonsPainter.InternalDrawBottomButton(ACanvas: TCanvas;
    ARect: TRect; AButtonPainterClass: TdxBaseButtonPainterClass;
    AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
    AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor; AState: TdxNavBarObjectStates);
var
  pt1, pt2, pt3: TPoint;
  AArrowHeight, AArrowWidth: Integer;
begin
  AButtonPainterClass.DrawButton(ACanvas, ARect, nil, AColor1, AColor2,
    AAlphaBlend1, AAlphaBlend2, AGradientMode, ABorderColor, AState);

  AArrowHeight := (ARect.Bottom - ARect.Top) div 4;
  AArrowWidth := 2 * AArrowHeight - 1;
  pt1.X := ARect.Left + (ARect.Right - ARect.Left) div 2 - 1;
  pt1.Y := ARect.Top + (ARect.Bottom - ARect.Top) div 2 + (AArrowHeight div 2) - 1;
  pt2.X := pt1.X - AArrowWidth div 2;
  pt2.Y := pt1.Y - AArrowHeight + 1;
  pt3.X := pt2.X + AArrowWidth - 1;
  pt3.Y := pt2.Y;
  if sDisabled in AState then
  begin
    ACanvas.Brush.Color := clGrayText;
    ACanvas.Pen.Color := clGrayText;
  end
  else
  begin
    ACanvas.Brush.Color := clBlack;
    ACanvas.Pen.Color := clBlack;
  end;
  ACanvas.Brush.Style := bsSolid;
  ACanvas.Pen.Style := psSolid;
  ACanvas.Polygon([pt1, pt2, pt3]);
end;

class procedure TdxNavBarScrollButtonsPainter.InternalDrawTopButton(ACanvas: TCanvas;
    ARect: TRect; AButtonPainterClass: TdxBaseButtonPainterClass;
    AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
    AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor; AState: TdxNavBarObjectStates);
var
  pt1, pt2, pt3: TPoint;
  AArrowHeight, AArrowWidth: Integer;
begin
  AButtonPainterClass.DrawButton(ACanvas, ARect, nil, AColor1, AColor2,
    AAlphaBlend2, AAlphaBlend2, AGradientMode, ABorderColor, AState);

  AArrowHeight := (ARect.Bottom - ARect.Top) div 4;
  AArrowWidth := 2 * AArrowHeight - 1;
  pt1.X := ARect.Left + (ARect.Right - ARect.Left) div 2 - 1;
  pt1.Y := ARect.Top + (ARect.Bottom - ARect.Top) div 2 - (AArrowHeight div 2) - 1;
  pt2.X := pt1.X - AArrowWidth div 2;
  pt2.Y := pt1.Y + AArrowHeight - 1;
  pt3.X := pt2.X + AArrowWidth - 1;
  pt3.Y := pt2.Y;
  if sDisabled in AState then
  begin
    ACanvas.Brush.Color := clGrayText;
    ACanvas.Pen.Color := clGrayText;
  end
  else
  begin
    ACanvas.Brush.Color := clBlack;
    ACanvas.Pen.Color := clBlack;
  end;
  ACanvas.Brush.Style := bsSolid;
  ACanvas.Pen.Style := psSolid;
  ACanvas.Polygon([pt1, pt2, pt3]);
end;

{ TdxNavBarDropTargetLinkPainter }

class procedure TdxNavBarDropTargetLinkPainter.InternalDrawTargetLink(
  ACanvas: TCanvas; pt1, pt2, pt3, pt4, pt5, pt6: TPoint; AColor: TColor);
begin
  ACanvas.Brush.Style := bsSolid;
  ACanvas.Brush.Color := AColor;
  ACanvas.Pen.Style := psSolid;
  ACanvas.Pen.Color := AColor;
  ACanvas.Polygon([pt1, pt2, pt3, pt1, pt4, pt5, pt6, pt4]);
end;

{ TdxNavBarDropTargetGroupPainter }

class procedure TdxNavBarDropTargetGroupPainter.InternalDrawTargetGroup(ACanvas: TCanvas;
  ARect: TRect; AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
  AGradientMode: TdxBarStyleGradientMode);
begin
  if CheckGdiPlus then
    TdxNavBarBackgroundPainter.DrawBackground(ACanvas, ARect, nil, False, clBlack,
          AColor1, AColor2, AAlphaBlend1, AAlphaBlend2, AGradientMode)

  else
  begin
    ACanvas.Brush.Style := bsClear;
    ACanvas.Pen.Width := 2;
    ACanvas.Pen.Style := psSolid;
    ACanvas.Pen.Color := AColor1;
    ACanvas.Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
  end;
end;

{ TdxNavBarXPButtonPainter }

class function TdxNavBarXPPainter.DrawObject(ACanvas: TCanvas; ARect: TRect;
    AObject: TdxThemedObjectType; iPartId, iStateId: Integer): Boolean;
var
  ATheme: TdxTheme;
begin
  ATheme := OpenTheme(AObject);
  if ATheme <> 0 then
  begin
    DrawThemeBackground(ATheme, ACanvas.Handle, iPartId, iStateId, @ARect);
    Result := True;
  end
  else Result := False;
end;

class function TdxNavBarXPPainter.DrawText(ACanvas: TCanvas; ARect: TRect;
    ACaption: string; ADrawTextFlag: Integer;
    AObject: TdxThemedObjectType; iPartId, iStateId: Integer): Boolean;
var
  ATheme: TdxTheme;
begin
  ATheme := OpenTheme(AObject);
  if ATheme <> 0 then
  begin
    DrawThemeText(ATheme, ACanvas.Handle, iPartId, iStateId, ACaption,
        -1, ADrawTextFlag, 0, ARect);
    Result := True;
  end
  else Result := False;
end;

{ TdxNavBarXPBackgroundPainter }

class procedure TdxNavBarXPBackgroundPainter.InternalDrawBackground(ACanvas: TCanvas;
  ARect: TRect; APicture: TPicture; AEraseBackground: Boolean; ABackgroundColor: TColor;
  AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte; AGradientMode: TdxBarStyleGradientMode);
begin
  if not TdxNavBarXPPainter.DrawObject(ACanvas, ARect, totTab, TABP_BODY, 0) then
    inherited;
end;

{ TdxNavBarXPGroupBackgroundPainter }

class procedure TdxNavBarXPGroupBackgroundPainter.InternalDrawBackground(ACanvas: TCanvas;
  ARect: TRect; APicture: TPicture; AColor1, AColor2: TColor;
  AAlphaBlend1, AAlphaBlend2: Byte; AGradientMode: TdxBarStyleGradientMode);
begin
  TdxNavBarXPBackgroundPainter.DrawBackground(ACanvas, ARect, APicture, False, clNone,
    AColor1, AColor2, AAlphaBlend1, AAlphaBlend2, AGradientMode);
end;

{ TdxNavBarXPSelectionPainter }

class procedure TdxNavBarXPSelectionPainter.InternalDrawSelection(ACanvas: TCanvas;
  ARect: TRect; ABackColor: TColor; AState: TdxNavBarObjectStates);
var
  AStateID: Integer;
begin
  if (sPressed in AState) or (sSelected in AState) then
    AStateID := TS_PRESSED
  else if (sHotTracked in AState) then
    AStateID := TS_HOT
  else AStateID := TS_NORMAL;
  if not TdxNavBarXPPainter.DrawObject(ACanvas, ARect, totToolBar, TP_BUTTON, AStateID) then
    inherited;
end;

{ TdxNavBarXPButtonPainter }

class procedure TdxNavBarXPButtonPainter.InternalDrawButton(ACanvas: TCanvas;
  ARect: TRect; APicture: TPicture; AColor1, AColor2: TColor; AAlphaBlend1,
  AAlphaBlend2: Byte; AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor;
  AState: TdxNavBarObjectStates);
var
  AStateID: Integer;
begin
  if sPressed in AState then
    AStateID := PBS_PRESSED
  else if sHotTracked in AState then
    AStateID := PBS_HOT
  else if sActive in AState then
    AStateID := PBS_DEFAULTED
  else AStateID := PBS_NORMAL;
  if not TdxNavBarXPPainter.DrawObject(ACanvas, ARect, totButton, BP_PUSHBUTTON, AStateID) then
    inherited;
end;

{ TdxNavBarXPScrollButtonsPainter }

class procedure TdxNavBarXPScrollButtonsPainter.InternalDrawBottomButton(
  ACanvas: TCanvas; ARect: TRect;
  AButtonPainterClass: TdxBaseButtonPainterClass; AColor1, AColor2: TColor;
  AAlphaBlend1, AAlphaBlend2: Byte; AGradientMode: TdxBarStyleGradientMode;
  ABorderColor: TColor; AState: TdxNavBarObjectStates);
var
  ATheme: TdxTheme;
  AStateID: Integer;
begin
  ATheme := OpenTheme(totScrollBar);
  if ATheme <> 0 then
  begin
    if sPressed in AState then
      AStateID := ABS_DOWNPRESSED
    else if sHotTracked in AState then
      AStateID := ABS_DOWNHOT
    else AStateID := ABS_DOWNNORMAL;
    TdxNavBarXPPainter.DrawObject(ACanvas, ARect, totScrollBar, SBP_ARROWBTN, AStateID);
    ExcludeClipRect(ACanvas.Handle, ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
  end
  else inherited;
end;

class procedure TdxNavBarXPScrollButtonsPainter.InternalDrawTopButton(
  ACanvas: TCanvas; ARect: TRect;
  AButtonPainterClass: TdxBaseButtonPainterClass; AColor1, AColor2: TColor;
  AAlphaBlend1, AAlphaBlend2: Byte; AGradientMode: TdxBarStyleGradientMode;
  ABorderColor: TColor; AState: TdxNavBarObjectStates);
var
  ATheme: TdxTheme;
  AStateID: Integer;
begin
  ATheme := OpenTheme(totScrollBar);
  if ATheme <> 0 then
  begin
    if sPressed in AState then
      AStateID := ABS_UPPRESSED
    else if sHotTracked in AState then
      AStateID := ABS_UPHOT
    else AStateID := ABS_UPNORMAL;
    TdxNavBarXPPainter.DrawObject(ACanvas, ARect, totScrollBar, SBP_ARROWBTN, AStateID);
    ExcludeClipRect(ACanvas.Handle, ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
  end
  else inherited;
end;

{ TdxNavBarXPExplorerBarBackgroundPainter }

class function TdxNavBarXPExplorerBarBackgroundPainter.GetBackgroundBitmap: TBitmap;
begin
  Result := dxXPExplorerBarBackground;
end;

class procedure TdxNavBarXPExplorerBarBackgroundPainter.InternalDrawBackground(ACanvas: TCanvas;
  ARect: TRect; APicture: TPicture; AEraseBackground: Boolean; ABackgroundColor: TColor;
  AColor1, AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
  AGradientMode: TdxBarStyleGradientMode);
var
  ABitmap: TBitmap;
  ATheme: TdxTheme;
begin
  ATheme := OpenTheme(totExplorerBar);
  ABitmap := GetBackgroundBitmap;
  if (ATheme <> 0) and (ABitmap <> nil) then
  begin
    ABitmap.PixelFormat := pf32bit;
    ABitmap.Transparent := True;
    ABitmap.TransparentColor := clFuchsia;
    ACanvas.StretchDraw(ARect, ABitmap);
  end
  else inherited;
end;

{ TdxNavBarXPExplorerBarSignPainter }

class procedure TdxNavBarXPExplorerBarSignPainter.CreateBitmap(var ADC: HDC;
  var ABitmap, AOldBitmap: HBITMAP; var AData: Pointer; AWidth, AHeight: Integer);
var
  TempDC: HDC;
  BitInfo: TBitmapInfo;
begin
  TempDC := GetDC(0);
  ADC := CreateCompatibleDC(TempDC);
  with BitInfo.bmiHeader do
  begin
    biSize := SizeOf(TBitmapInfoHeader);
    biPlanes := 1;
    biBitCount := 32;
    biCompression := BI_RGB;
    biWidth := AWidth;
    biHeight := AHeight;
    biSizeImage := 0;
    biXPelsPerMeter := 0;
    biYPelsPerMeter := 0;
    biClrUsed := 0;
    biClrImportant := 0;
  end;
  ABitmap := CreateDIBSection(ADC, BitInfo, DIB_RGB_COLORS, AData, 0, 0);
  GDIFlush;
  AOldBitmap := SelectObject(ADC, ABitmap);
  ReleaseDC(0, TempDC);
end;

class procedure TdxNavBarXPExplorerBarSignPainter.DeleteBitmap(var ADC: HDC;
  var ABitmap, AOldBitmap: HBITMAP; var AData: Pointer);
begin
  GDIFlush;
  SelectObject(ADC, AOldBitmap);
  DeleteObject(ABitmap);
  DeleteDC(ADC);
  AData := nil;
end;

class procedure TdxNavBarXPExplorerBarSignPainter.DrawMaskBitmap(DestX, DestY: Integer;
  DestHandle: THandle; Bitmap: TBitmap);
var
  I, J: Integer;
  DC1, DC2: HDC;
  Bitmap1, Bitmap2: HBITMAP;
  OldBitmap1, OldBitmap2: HBITMAP;
  Data1, Data2: Pointer;
  ASourceData, ADestData: Pointer;
  sR, sG, sB, sA: Byte;
  dR, dG, dB: Byte;
  R, G, B: Word;
begin
  CreateBitmap(DC1, Bitmap1, OldBitmap1, Data1, Bitmap.Width, Bitmap.Height);
  CreateBitmap(DC2, Bitmap2, OldBitmap2, Data2, Bitmap.Width, Bitmap.Height);
  try
    BitBlt(DC1, 0, 0, Bitmap.Width, Bitmap.Height, Bitmap.Canvas.Handle, 0, 0, SRCCOPY);
    BitBlt(DC2, 0, 0, Bitmap.Width, Bitmap.Height, DestHandle, DestX, DestY, SRCCOPY);

    ASourceData := Pointer(Integer(Data1) + ((Bitmap.Height - 1) * Bitmap.Width * 4));
    ADestData := Pointer(Integer(Data2) + ((Bitmap.Height - 1) * Bitmap.Width * 4));
    for I := 0 to Bitmap.Height - 1 do
    begin
      for J := 0 to Bitmap.Width - 1 do
      begin
        sA := PByte(Integer(ASourceData) + 3)^;

        sG := PByte(ASourceData)^;
        dG := PByte(ADestData)^;
        G := (sG * sA) + (dG * (255 - sA));
        PByte(ADestData)^ := G div 256 + 1;

        sB := PByte(Integer(ASourceData) + 1)^;
        dB := PByte(Integer(ADestData) + 1)^;
        B := (sB * sA) + (dB * (255 - sA));
        PByte(Integer(ADestData) + 1)^ := B div 256  + 1;

        sR := PByte(Integer(ASourceData) + 2)^;
        dR := PByte(Integer(ADestData) + 2)^;
        R := (sR * sA) + (dR * (255 - sA));
        PByte(Integer(ADestData) + 2)^ := R div 256  + 1;

        PByte(Integer(ADestData) + 3)^ := PByte(Integer(ASourceData) + 3)^;

        ASourceData := Pointer(Integer(ASourceData) + 4);
        ADestData := Pointer(Integer(ADestData) + 4);
      end;
      ASourceData := Pointer(Integer(ASourceData) - Bitmap.Width * 4 * 2);
      ADestData := Pointer(Integer(ADestData) - Bitmap.Width * 4 * 2);
    end;

    BitBlt(DestHandle, DestX, DestY, Bitmap.Width, Bitmap.Height, DC2, 0, 0, SRCCOPY);
  finally
    DeleteBitmap(DC1, Bitmap1, OldBitmap1, Data1);
    DeleteBitmap(DC2, Bitmap2, OldBitmap2, Data2);
  end;
end;

class function TdxNavBarXPExplorerBarSignPainter.GetSignBitmap(AState: TdxNavBarObjectStates): TBitmap;
begin
  if (sExpanded in AState) then
  begin
    if sHotTracked in AState then
    begin
      if (sSpecial in AState) and (dxXPExplorerBarSpecialGroupCollapseHot <> nil) then
        Result := dxXPExplorerBarSpecialGroupCollapseHot
      else Result := dxXPExplorerBarNormalGroupCollapseHot
    end
    else
    begin
      if (sSpecial in AState) and (dxXPExplorerBarSpecialGroupCollapse <> nil) then
        Result := dxXPExplorerBarSpecialGroupCollapse
      else Result := dxXPExplorerBarNormalGroupCollapse;
    end;
  end
  else
  begin
    if sHotTracked in AState then
    begin
      if (sSpecial in AState) and (dxXPExplorerBarSpecialGroupExpandHot <> nil) then
        Result := dxXPExplorerBarSpecialGroupExpandHot
      else Result := dxXPExplorerBarNormalGroupExpandHot
    end
    else
    begin
      if (sSpecial in AState) and (dxXPExplorerBarSpecialGroupExpand <> nil) then
        Result := dxXPExplorerBarSpecialGroupExpand
      else Result := dxXPExplorerBarNormalGroupExpand;
    end;
  end;
end;

class procedure TdxNavBarXPExplorerBarSignPainter.InternalDrawSign(ACanvas: TCanvas;
  ARect: TRect; AForeColor, ABackColor1, ABackColor2 : TColor;
  AState: TdxNavBarObjectStates);
var
  ABitmap: TBitmap;
  ATheme: TdxTheme;
begin
  ATheme := OpenTheme(totExplorerBar);
  ABitmap := GetSignBitmap(AState);
  if (ATheme <> 0) and (ABitmap <> nil) then
  begin
    if TdxNavBarXPExplorerBarButtonPainter.GetButtonBitmap(AState) <> nil then
      DrawMaskBitmap(ARect.Left, ARect.Top, ACanvas.Handle, ABitmap)
    else
    begin
      ABitmap.PixelFormat := pf32bit;
      ABitmap.Transparent := True;
      ABitmap.TransparentColor := clFuchsia;
      ACanvas.StretchDraw(ARect, ABitmap);
    end
  end
  else inherited;
end;

{ TdxNavBarXPExplorerBarButtonPainter }

class function TdxNavBarXPExplorerBarButtonPainter.GetButtonBitmap(AState: TdxNavBarObjectStates): TBitmap;
begin
  if (sSpecial in AState) and (dxXPExplorerBarSpecialGroupHeader <> nil) then
    Result := dxXPExplorerBarSpecialGroupHeader
  else Result := dxXPExplorerBarNormalGroupHeader;
end;

class procedure TdxNavBarXPExplorerBarButtonPainter.InternalDrawButton(
  ACanvas: TCanvas; ARect: TRect; APicture: TPicture; AColor1,
  AColor2: TColor; AAlphaBlend1, AAlphaBlend2: Byte;
  AGradientMode: TdxBarStyleGradientMode; ABorderColor: TColor;
  AState: TdxNavBarObjectStates);
var
  ABitmap: TBitmap;
  ATheme: TdxTheme;
begin
  ATheme := OpenTheme(totExplorerBar);
  ABitmap := GetButtonBitmap(AState);
  if (ATheme <> 0) and (ABitmap <> nil) then
  begin
    ABitmap.PixelFormat := pf32bit;
    ABitmap.Transparent := True;
    ABitmap.TransparentColor := clFuchsia;
    ACanvas.StretchDraw(ARect, ABitmap);
  end
  else inherited;
end;

{ TdxGPColor }

function MakeColor(r, g, b: Byte): ARGB; overload;
begin
  result := MakeColor(255, r, g, b);
end;

function MakeColor(a, r, g, b: Byte): ARGB; overload;
begin
  result := ((DWORD(b) shl  BlueShift) or
             (DWORD(g) shl GreenShift) or
             (DWORD(r) shl   RedShift) or
             (DWORD(a) shl AlphaShift));
end;

function MakeColor(color: TColor; alpha: Byte): ARGB; overload;
begin
  result := MakeColor(alpha, GetRValue(color), GetGValue(color), GetBValue(color));
end;

function GetAlpha(color: ARGB): BYTE;
begin
  result := BYTE(color shr AlphaShift);
end;

function GetRed(color: ARGB): BYTE;
begin
  result := BYTE(color shr RedShift);
end;

function GetGreen(color: ARGB): BYTE;
begin
  result := BYTE(color shr GreenShift);
end;

function GetBlue(color: ARGB): BYTE;
begin
  result := BYTE(color shr BlueShift);
end;

function ColorRefToARGB(rgb: COLORREF): ARGB;
begin
  result := MakeColor(255, GetRValue(rgb), GetGValue(rgb), GetBValue(rgb));
end;

function ARGBToColorRef(Color: ARGB): COLORREF;
begin
  result := RGB(GetRed(Color), GetGreen(Color), GetBlue(Color));
end;

initialization
  LoadShellInstance;

finalization
  UnloadShellInstance;

end.

