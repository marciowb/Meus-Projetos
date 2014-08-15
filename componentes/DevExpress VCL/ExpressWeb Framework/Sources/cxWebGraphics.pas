{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Web Graphics                                                }
{                                                                   }
{       Copyright (c) 2000-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSWEB FRAMEWORK AND ALL         }
{   ACCOMPANYING VCL CLASSES AS PART OF AN EXECUTABLE WEB           }
{   APPLICATION ONLY.                                               }
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
unit cxWebGraphics;

{$I cxVer.inc}

interface

uses
  Classes,
  cxWebTypes, cxWebColors, cxWebRender;

type
  TcxWebUnit =
    (wuCentimeters, wuEm, wuEx, wuInches, wuMillimeters, wuPercentage, wuPicas, wuPixels, wuPoints);

  TcxWebFont = class;

  TcxWebFontSize = class(TPersistent)
  private
    FUnits: TcxWebUnit;
    FValue: Integer;
    FWebFont: TcxWebFont;

    procedure SetUnits(Value: TcxWebUnit);
    procedure SetValue(Value: Integer);
  protected
    procedure Changed; dynamic;
  public
    constructor Create(AWebFont: TcxWebFont);
    procedure Assign(Source: TPersistent); override;
    procedure WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder);

    property WebFont: TcxWebFont read FWebFont;
  published
    property Units: TcxWebUnit read FUnits write SetUnits
      default wuPoints;
    property Value: Integer read FValue write SetValue
      default 12;
  end;

  TcxWebFontDecoration = (wfdNone, wfdUnderline, wfdOverline, wfdLineThrough);
  TcxWebFontDecorations = set of TcxWebFontDecoration;
  TcxWebFontStyle = (wfsNotSet, wfsNormal, wfsItalic, wfsOblique);
  TcxWebFontTransform = (wftNotSet, wftCapitalize, wftUppercase, wftLowercase, wftNone);
  TcxWebFontVariant = (wfvNotSet, wfvNormal, wfvSmallCaps);
  TcxWebFontWeight =
   (wfwNotSet, wfwNormal, wfwBold, wfwBolder, wfwLighter, wfw100, wfw200, 
    wfw300, wfw400, wfw500, wfw600, wfw700, wfw800, wfw900);

  TcxWebFont = class(TPersistent)
  private
    FColor: TcxWebColor;
    FDecoration: TcxWebFontDecorations;
    FName: string;
    FNames: TStrings;
    FSize: TcxWebFontSize;
    FStyle: TcxWebFontStyle;
    FTransform: TcxWebFontTransform;
    FUpdateCount: Integer;
    FVariant: TcxWebFontVariant;
    FWeight: TcxWebFontWeight;
    FOnChange: TNotifyEvent;

    function GetBold: Boolean;
    function GetItalic: Boolean;
    function GetOverline: Boolean;
    function GetStrikeout: Boolean;
    function GetUnderline: Boolean;
    function IsColorStored: Boolean;
    procedure SetBold(Value: Boolean);
    procedure SetColor(const Value: TcxWebColor);
    procedure SetDecoration(Value: TcxWebFontDecorations);
    procedure SetItalic(Value: Boolean);
    procedure SetName(const Value: string);
    procedure SetNames(Value: TStrings);
    procedure SetOverline(Value: Boolean);
    procedure SetSize(Value: TcxWebFontSize);
    procedure SetStrikeout(Value: Boolean);
    procedure SetStyle(Value: TcxWebFontStyle);
    procedure SetTransform(Value: TcxWebFontTransform);
    procedure SetUnderline(Value: Boolean);
    procedure SetVariant(Value: TcxWebFontVariant);
    procedure SetWeight(Value: TcxWebFontWeight);
  protected
    procedure Changed; dynamic;
    procedure WriteDecoration(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;
    procedure WriteStyle(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;
    procedure WriteTransform(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;
    procedure WriteVariant(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;
    procedure WriteWeight(HTMLTextBuilder: TcxHTMLTextBuilder); virtual;

    property UpdateCount: Integer read FUpdateCount;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    procedure BeginUpdate;
    procedure EndUpdate;

    procedure WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    property Bold: Boolean read GetBold write SetBold
      stored False;
    property Color: TcxWebColor read FColor write SetColor
      stored IsColorStored;
    property Decoration: TcxWebFontDecorations read FDecoration write SetDecoration
      default [];
    property Italic: Boolean read GetItalic write SetItalic
      stored False;
    property Name: string read FName write SetName;
    property Names: TStrings read FNames write SetNames; // TODO: property editor
    property Overline: Boolean read GetOverline write SetOverline
      stored False;
    property Size: TcxWebFontSize read FSize write SetSize;
    property Strikeout: Boolean read GetStrikeout write SetStrikeout
      stored False;
    property Style: TcxWebFontStyle read FStyle write SetStyle
      default wfsNotSet;
    property Transform: TcxWebFontTransform read FTransform write SetTransform
      default wftNotSet;
    property Underline: Boolean read GetUnderline write SetUnderline
      stored False;
    property Variant: TcxWebFontVariant read FVariant write SetVariant
      default wfvNotSet;
    property Weight: TcxWebFontWeight read FWeight write SetWeight
      default wfwNotSet;
  end;

const
  cxWebUnits: array[TcxWebUnit] of string = 
    ('cm', 'em', 'ex', 'in', 'mm', '%', 'pc', 'px', 'pt');
  cxWebFontDecorations: array[TcxWebFontDecoration] of string = 
    ('none', 'underline', 'overline', 'line-through');
  cxWebFontStyles: array[TcxWebFontStyle] of string = 
    ('', 'normal', 'italic', 'oblique');
  cxWebFontTransforms: array[TcxWebFontTransform] of string = 
    ('', 'capitalize', 'uppercase', 'lowercase', 'none');
  cxWebFontVariants: array[TcxWebFontVariant] of string = 
    ('', 'normal', 'small-caps');
  cxWebFontWeights: array[TcxWebFontWeight] of string = 
    ('', 'normal', 'bold', 'bolder', 'lighter', 
     '100', '200', '300', '400', '500', '600', '700', '800', '900');

function cxWebColorToString(Color: TcxWebColor): string;
function cxWebColorToWebString(Color: Longint): string;
function cxStringToWebColor(const S: string): Longint;
function cxWebColorStringToWebColor(const S: string): TcxWebColor;
procedure cxGetWebColorValues(Proc: TGetStrProc);
procedure cxGetWebColorPalette(Proc: TGetStrProc);
function cxWebColorToIdent(Color: Longint; var Ident: string): Boolean;
function cxIdentToWebColor(const Ident: string; var Color: Longint): Boolean;

function cxWebDefaultFont: TcxWebFont;

implementation

uses
  {$IFDEF VCL}
  Windows, Graphics,
  {$ENDIF}
  SysUtils;
  
const
  cxclDefaultWebFontColor = clWebWindowText;
  cxDefaultWebFontName = 'Times New Roman';

{ Color mapping routines }

  cxWebColorCount = 168;
  cxWebColors: array[0..cxWebColorCount - 1] of TIdentMapEntry = (
    (Value: clWebAliceBlue; Name: 'clWebAliceBlue'),
    (Value: clWebAntiqueWhite; Name: 'clWebAntiqueWhite'),
    (Value: clWebAqua; Name: 'clWebAqua'),
    (Value: clWebAquamarine; Name: 'clWebAquamarine'),
    (Value: clWebAzure; Name: 'clWebAzure'),
    (Value: clWebBeige; Name: 'clWebBeige'),
    (Value: clWebBisque; Name: 'clWebBisque'),
    (Value: clWebBlack; Name: 'clWebBlack'),                 
    (Value: clWebBlanchedAlmond; Name: 'clWebBlanchedAlmond'),        
    (Value: clWebBlue; Name: 'clWebBlue'),
    (Value: clWebBlueViolet; Name: 'clWebBlueViolet'),            
    (Value: clWebBrown; Name: 'clWebBrown'),
    (Value: clWebBurlyWood; Name: 'clWebBurlyWood'),              
    (Value: clWebCadetBlue; Name: 'clWebCadetBlue'),
    (Value: clWebChartreuse; Name: 'clWebChartreuse'),
    (Value: clWebChocolate; Name: 'clWebChocolate'),
    (Value: clWebCoral; Name: 'clWebCoral'),
    (Value: clWebCornflowerBlue; Name: 'clWebCornflowerBlue'),         
    (Value: clWebCornsilk; Name: 'clWebCornsilk'),
    (Value: clWebCrimson; Name: 'clWebCrimson'),               
    (Value: clWebCyan; Name: 'clWebCyan'),
    (Value: clWebDarkBlue; Name: 'clWebDarkBlue'),              
    (Value: clWebDarkCyan; Name: 'clWebDarkCyan'),              
    (Value: clWebDarkGoldenrod; Name: 'clWebDarkGoldenrod'),
    (Value: clWebDarkGray; Name: 'clWebDarkGray'),
    (Value: clWebDarkGreen; Name: 'clWebDarkGreen'),
    (Value: clWebDarkKhaki; Name: 'clWebDarkKhaki'),              
    (Value: clWebDarkMagenta; Name: 'clWebDarkMagenta'),           
    (Value: clWebDarkOliveGreen; Name: 'clWebDarkOliveGreen'),
    (Value: clWebDarkOrange; Name: 'clWebDarkOrange'),
    (Value: clWebDarkOrchid; Name: 'clWebDarkOrchid'),
    (Value: clWebDarkRed; Name: 'clWebDarkRed'),
    (Value: clWebDarkSalmon; Name: 'clWebDarkSalmon'),
    (Value: clWebDarkSeaGreen; Name: 'clWebDarkSeaGreen'),
    (Value: clWebDarkSlateBlue; Name: 'clWebDarkSlateBlue'),
    (Value: clWebDarkSlateGray; Name: 'clWebDarkSlateGray'),
    (Value: clWebDarkTurquoise; Name: 'clWebDarkTurquoise'),
    (Value: clWebDarkViolet; Name: 'clWebDarkViolet'),
    (Value: clWebDeepPink; Name: 'clWebDeepPink'),
    (Value: clWebDeepSkyBlue; Name: 'clWebDeepSkyBlue'),
    (Value: clWebDimGray; Name: 'clWebDimGray'),
    (Value: clWebDodgerBlue; Name: 'clWebDodgerBlue'),
    (Value: clWebFireBrick; Name: 'clWebFireBrick'),
    (Value: clWebFloralWhite; Name: 'clWebFloralWhite'),
    (Value: clWebForestGreen; Name: 'clWebForestGreen'),
    (Value: clWebFuchsia; Name: 'clWebFuchsia'),
    (Value: clWebGainsboro; Name: 'clWebGainsboro'),
    (Value: clWebGhostWhite; Name: 'clWebGhostWhite'),
    (Value: clWebGold; Name: 'clWebGold'),
    (Value: clWebGoldenrod; Name: 'clWebGoldenrod'),
    (Value: clWebGray; Name: 'clWebGray'),
    (Value: clWebGreen; Name: 'clWebGreen'),
    (Value: clWebGreenYellow; Name: 'clWebGreenYellow'),
    (Value: clWebHoneydew; Name: 'clWebHoneydew'),
    (Value: clWebHotPink; Name: 'clWebHotPink'),
    (Value: clWebIndianRed; Name: 'clWebIndianRed'),
    (Value: clWebIndigo; Name: 'clWebIndigo'),
    (Value: clWebIvory; Name: 'clWebIvory'),
    (Value: clWebKhaki; Name: 'clWebKhaki'),
    (Value: clWebLavender; Name: 'clWebLavender'),
    (Value: clWebLavenderBlush; Name: 'clWebLavenderBlush'),
    (Value: clWebLawnGreen; Name: 'clWebLawnGreen'),
    (Value: clWebLemonChiffon; Name: 'clWebLemonChiffon'),
    (Value: clWebLightBlue; Name: 'clWebLightBlue'),
    (Value: clWebLightCoral; Name: 'clWebLightCoral'),
    (Value: clWebLightCyan; Name: 'clWebLightCyan'),
    (Value: clWebLightGoldenrodYellow; Name: 'clWebLightGoldenrodYellow'),
    (Value: clWebLightGreen; Name: 'clWebLightGreen'),
    (Value: clWebLightGrey; Name: 'clWebLightGrey'),
    (Value: clWebLightPink; Name: 'clWebLightPink'),
    (Value: clWebLightSalmon; Name: 'clWebLightSalmon'),
    (Value: clWebLightSeaGreen; Name: 'clWebLightSeaGreen'),
    (Value: clWebLightSkyBlue; Name: 'clWebLightSkyBlue'),
    (Value: clWebLightSlateGray; Name: 'clWebLightSlateGray'),
    (Value: clWebLightSteelBlue; Name: 'clWebLightSteelBlue'),
    (Value: clWebLightYellow; Name: 'clWebLightYellow'),
    (Value: clWebLime; Name: 'clWebLime'),
    (Value: clWebLimeGreen; Name: 'clWebLimeGreen'),
    (Value: clWebLinen; Name: 'clWebLinen'),
    (Value: clWebMagenta; Name: 'clWebMagenta'),
    (Value: clWebMaroon; Name: 'clWebMaroon'),
    (Value: clWebMediumAquamarine; Name: 'clWebMediumAquamarine'),
    (Value: clWebMediumBlue; Name: 'clWebMediumBlue'),
    (Value: clWebMediumOrchid; Name: 'clWebMediumOrchid'),
    (Value: clWebMediumPurple; Name: 'clWebMediumPurple'),
    (Value: clWebMediumSeaGreen; Name: 'clWebMediumSeaGreen'),
    (Value: clWebMediumSlateBlue; Name: 'clWebMediumSlateBlue'),
    (Value: clWebMediumSpringGreen; Name: 'clWebMediumSpringGreen'),
    (Value: clWebMediumTurquoise; Name: 'clWebMediumTurquoise'),
    (Value: clWebMediumVioletRed; Name: 'clWebMediumVioletRed'),
    (Value: clWebMidnightBlue; Name: 'clWebMidnightBlue'),
    (Value: clWebMintCream; Name: 'clWebMintCream'),
    (Value: clWebMistyRose; Name: 'clWebMistyRose'),
    (Value: clWebMoccasin; Name: 'clWebMoccasin'),
    (Value: clWebNavajoWhite; Name: 'clWebNavajoWhite'),
    (Value: clWebNavy; Name: 'clWebNavy'),
    (Value: clWebOldLace; Name: 'clWebOldLace'),
    (Value: clWebOlive; Name: 'clWebOlive'),
    (Value: clWebOliveDrab; Name: 'clWebOliveDrab'),
    (Value: clWebOrange; Name: 'clWebOrange'),
    (Value: clWebOrangeRed; Name: 'clWebOrangeRed'),
    (Value: clWebOrchid; Name: 'clWebOrchid'),
    (Value: clWebPaleGoldenrod; Name: 'clWebPaleGoldenrod'),
    (Value: clWebPaleGreen; Name: 'clWebPaleGreen'),
    (Value: clWebPaleTurquoise; Name: 'clWebPaleTurquoise'),
    (Value: clWebPaleVioletRed; Name: 'clWebPaleVioletRed'),
    (Value: clWebPapayaWhip; Name: 'clWebPapayaWhip'),
    (Value: clWebPeachPuff; Name: 'clWebPeachPuff'),
    (Value: clWebPeru; Name: 'clWebPeru'),
    (Value: clWebPink; Name: 'clWebPink'),
    (Value: clWebPlum; Name: 'clWebPlum'),
    (Value: clWebPowderBlue; Name: 'clWebPowderBlue'),
    (Value: clWebPurple; Name: 'clWebPurple'),
    (Value: clWebRed; Name: 'clWebRed'),
    (Value: clWebRosyBrown; Name: 'clWebRosyBrown'),
    (Value: clWebRoyalBlue; Name: 'clWebRoyalBlue'),
    (Value: clWebSaddleBrown; Name: 'clWebSaddleBrown'),
    (Value: clWebSalmon; Name: 'clWebSalmon'),
    (Value: clWebSandyBrown; Name: 'clWebSandyBrown'),
    (Value: clWebSeaGreen; Name: 'clWebSeaGreen'),
    (Value: clWebSeashell; Name: 'clWebSeashell'),
    (Value: clWebSienna; Name: 'clWebSienna'),
    (Value: clWebSilver; Name: 'clWebSilver'),
    (Value: clWebSkyBlue; Name: 'clWebSkyBlue'),
    (Value: clWebSlateBlue; Name: 'clWebSlateBlue'),
    (Value: clWebSlateGray; Name: 'clWebSlateGray'),
    (Value: clWebSnow; Name: 'clWebSnow'),
    (Value: clWebSpringGreen; Name: 'clWebSpringGreen'),
    (Value: clWebSteelBlue; Name: 'clWebSteelBlue'),
    (Value: clWebTan; Name: 'clWebTan'),
    (Value: clWebTeal; Name: 'clWebTeal'),
    (Value: clWebThistle; Name: 'clWebThistle'),
    (Value: clWebTomato; Name: 'clWebTomato'),
    (Value: clWebTurquoise; Name: 'clWebTurquoise'),
    (Value: clWebViolet; Name: 'clWebViolet'),
    (Value: clWebWheat; Name: 'clWebWheat'),
    (Value: clWebWhite; Name: 'clWebWhite'),
    (Value: clWebWhiteSmoke; Name: 'clWebWhiteSmoke'),
    (Value: clWebYellow; Name: 'clWebYellow'),
    (Value: clWebYellowGreen; Name: 'clWebYellowGreen'),

    (Value: clWebActiveBorder; Name: 'clWebActiveBorder'),
    (Value: clWebActiveCaption; Name: 'clWebActiveCaption'),
    (Value: clWebAppWorkspace; Name: 'clWebAppWorkspace'),
    (Value: clWebBackground; Name: 'clWebBackground'),
    (Value: clWebButtonFace; Name: 'clWebButtonFace'),
    (Value: clWebButtonHighlight; Name: 'clWebButtonHighlight'),
    (Value: clWebButtonShadow; Name: 'clWebButtonShadow'),
    (Value: clWebButtonText; Name: 'clWebButtonText'),
    (Value: clWebCaptionText; Name: 'clWebCaptionText'),
    (Value: clWebGrayText; Name: 'clWebGrayText'),
    (Value: clWebHighlight; Name: 'clWebHighlight'),
    (Value: clWebHighlightText; Name: 'clWebHighlightText'),
    (Value: clWebInactiveBorder; Name: 'clWebInactiveBorder'),
    (Value: clWebInactiveCaption; Name: 'clWebInactiveCaption'),
    (Value: clWebInactiveCaptionText; Name: 'clWebInactiveCaptionText'),
    (Value: clWebInfoBackground; Name: 'clWebInfoBackground'),
    (Value: clWebInfoText; Name: 'clWebInfoText'),
    (Value: clWebMenu; Name: 'clWebMenu'),
    (Value: clWebMenuText; Name: 'clWebMenuText'),
    (Value: clWebScrollbar; Name: 'clWebScrollbar'),
    (Value: clWebThreeDDarkShadow; Name: 'clWebThreeDDarkShadow'),
    (Value: clWebThreeDFace; Name: 'clWebThreeDFace'),
    (Value: clWebThreeDHighlight; Name: 'clWebThreeDHighlight'),
    (Value: clWebThreeDLightShadow; Name: 'clWebThreeDLightShadow'),
    (Value: clWebThreeDShadow; Name: 'clWebThreeDShadow'),
    (Value: clWebWindow; Name: 'clWebWindow'),
    (Value: clWebWindowFrame; Name: 'clWebWindowFrame'),
    (Value: clWebWindowText; Name: 'clWebWindowText'));

  cxWebSystemColorCount = 28;
  cxWebSystemColors: array[0..cxWebSystemColorCount - 1] of TIdentMapEntry = (
    (Value: clWebActiveBorder; Name: 'activeborder'),
    (Value: clWebActiveCaption; Name: 'activecaption'),
    (Value: clWebAppWorkspace; Name: 'appworkspace'),
    (Value: clWebBackground; Name: 'background'),
    (Value: clWebButtonFace; Name: 'buttonface'),
    (Value: clWebButtonHighlight; Name: 'buttonhighlight'),
    (Value: clWebButtonShadow; Name: 'buttonshadow'),
    (Value: clWebButtonText; Name: 'buttontext'),
    (Value: clWebCaptionText; Name: 'captiontext'),
    (Value: clWebGrayText; Name: 'graytext'),
    (Value: clWebHighlight; Name: 'highlight'),
    (Value: clWebHighlightText; Name: 'highlighttext'),
    (Value: clWebInactiveBorder; Name: 'inactiveborder'),
    (Value: clWebInactiveCaption; Name: 'inactivecaption'),
    (Value: clWebInactiveCaptionText; Name: 'inactivecaptiontext'),
    (Value: clWebInfoBackground; Name: 'infobackground'),
    (Value: clWebInfoText; Name: 'infotext'),
    (Value: clWebMenu; Name: 'menu'),
    (Value: clWebMenuText; Name: 'menutext'),
    (Value: clWebScrollbar; Name: 'scrollbar'),
    (Value: clWebThreeDDarkShadow; Name: 'threeddarkshadow'),
    (Value: clWebThreeDFace; Name: 'threedface'),
    (Value: clWebThreeDHighlight; Name: 'threedhighlight'),
    (Value: clWebThreeDLightShadow; Name: 'threedlightshadow'),
    (Value: clWebThreeDShadow; Name: 'threedshadow'),
    (Value: clWebWindow; Name: 'window'),
    (Value: clWebWindowFrame; Name: 'windowframe'),
    (Value: clWebWindowText; Name: 'windowtext'));

  cxWebColorsMap: array[0..cxWebColorCount - 1] of Byte =
    (28, 51, 98, 139, 61, 14, 52, 103, 67, 91,
     25, 44, 119, 85, 77, 33, 76, 127, 87, 53,
     35, 130, 22, 13, 71, 81, 133, 3, 104, 4,
     125, 73, 128, 39, 2, 20, 36, 88, 111, 65,
     95, 21, 82, 9, 115, 41, 123, 72, 63, 0,
     90, 34, 10, 124, 84, 86, 17, 74, 59, 126,
     56, 112, 37, 30, 83, 101, 134, 110, 131, 60,
     27, 89, 38, 105, 54, 79, 45, 69, 109, 92,
     80, 11, 55, 114, 117, 64, 32, 70, 107, 43,
     31, 42, 19, 113, 100, 132, 16, 135, 106, 96,
     121, 15, 29, 118, 99, 94, 93, 78, 57, 120,
     116, 108, 12, 129, 6, 8, 1, 18, 66, 5,
     97, 23, 49, 26, 48, 138, 58, 102, 62, 75,
     7, 40, 50, 24, 122, 68, 46, 137, 47, 136,

     140, 141, 142, 143, 144, 145, 146,
     147, 148, 148, 150, 151, 152, 153,
     154, 155, 156, 157, 158, 159, 160,
     161, 162, 163, 164, 165, 166, 167);

function cxWebColorToString(Color: TcxWebColor): string;
begin
  if not cxWebColorToIdent(Color, Result) then
    FmtStr(Result, '%s%.8x', [HexDisplayPrefix, Color]);
end;

function cxWebColorToWebString(Color: Longint): string;
begin
  if (Color > 0) or not IntToIdent(Color, Result, cxWebSystemColors) then
    with TcxWebColorTriple(Color) do
      Result := Format('#%.2x%.2x%.2x', [Red, Green, Blue]);
end;

function cxWebColorStringToWebColor(const S: string): TcxWebColor;
begin
  if not IdentToInt(S, Integer(Result), cxWebSystemColors) then
  try
    if S <> '' then
      with TcxWebColorTriple(Result) do
      begin
        Red := StrToInt('$' + Copy(S, 2, 2));
        Green := StrToInt('$' + Copy(S, 4, 2));
        Blue := StrToInt('$' + Copy(S, 6, 2));
      end;
  except
    Result := clWebBlack;
  end;  
end;

function cxStringToWebColor(const S: string): Longint;
begin
  if not cxIdentToWebColor(S, Result) then
    Result := StrToInt(S);
end;

procedure cxGetWebColorValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  for I := Low(cxWebColors) to High(cxWebColors) do
    Proc(cxWebColors[I].Name);
end;

procedure cxGetWebColorPalette(Proc: TGetStrProc);
var
  I: Integer;
begin
  for I := Low(cxWebColorsMap) to High(cxWebColorsMap) do
    Proc(cxWebColors[cxWebColorsMap[I]].Name);
end;

function cxWebColorToIdent(Color: Longint; var Ident: string): Boolean;
begin
  Result := IntToIdent(Color, Ident, cxWebColors);
end;

function cxIdentToWebColor(const Ident: string; var Color: Longint): Boolean;
begin
  Result := IdentToInt(Ident, Color, cxWebColors);
end;

  
{ TcxWebFontSize }

constructor TcxWebFontSize.Create(AWebFont: TcxWebFont);
begin
  inherited Create;
  FWebFont := AWebFont;
  FUnits := wuPoints;
  FValue := 12;
end;

procedure TcxWebFontSize.Assign(Source: TPersistent);
begin
  if Source is TcxWebFontSize then
  begin
    FValue := TcxWebFontSize(Source).Value;
    FUnits := TcxWebFontSize(Source).Units;
    Changed;
  end
  else
    inherited;
end;

procedure TcxWebFontSize.WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
  HTMLTextBuilder.WriteStyleAttribute(saFontSize, IntToStr(Value) + cxWebUnits[Units]);
end;

procedure TcxWebFontSize.Changed;
begin
  if WebFont <> nil then
    WebFont.Changed;
end;

procedure TcxWebFontSize.SetUnits(Value: TcxWebUnit);
begin
  if FUnits <> Value then 
  begin
    FUnits := Value;
    Changed;
  end;
end;

procedure TcxWebFontSize.SetValue(Value: Integer);
begin
  if Value < 2 then
    Value := 2;
  if FValue <> Value then 
  begin
    FValue := Value;
    Changed;
  end;
end;


{ TcxWebFont }

constructor TcxWebFont.Create;
begin
  inherited;
  FColor := cxclDefaultWebFontColor;
  FDecoration := [];
  FName := cxDefaultWebFontName;
  FNames := TStringList.Create;
  FNames.Add(FName);
  FSize := TcxWebFontSize.Create(Self);
  FStyle := wfsNotSet;
  FTransform := wftNotSet;
  FVariant := wfvNotSet;
  FWeight := wfwNotSet;
end;

destructor TcxWebFont.Destroy;
begin
  FSize.Free;
  FNames.Free;
  inherited;
end;

procedure TcxWebFont.Assign(Source: TPersistent);
begin
  if Source is TcxWebFont then
  begin
    BeginUpdate;
    try
      Color := TcxWebFont(Source).Color;
      Decoration := TcxWebFont(Source).Decoration;
      Name := TcxWebFont(Source).Name;
      Names := TcxWebFont(Source).Names;
      Size := TcxWebFont(Source).Size;
      Style := TcxWebFont(Source).Style;
      Transform := TcxWebFont(Source).Transform;
      Variant := TcxWebFont(Source).Variant;
      Weight := TcxWebFont(Source).Weight;
    finally
      EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TcxWebFont.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TcxWebFont.EndUpdate;
begin
  if FUpdateCount <> 0 then
  begin
    Dec(FUpdateCount);
    if FUpdateCount = 0 then Changed;
  end;
end;

procedure TcxWebFont.WriteHTML(HTMLTextBuilder: TcxHTMLTextBuilder);
var
  FamilyStr: string;
begin
  HTMLTextBuilder.WriteStyleAttribute(saColor, cxWebColorToWebString(Color));
  FamilyStr := StringReplace(Names.CommaText, '"', '&quot;', [rfReplaceAll]);
  HTMLTextBuilder.WriteStyleAttribute(saFontFamily, FamilyStr);
  Size.WriteHTML(HTMLTextBuilder);
  WriteStyle(HTMLTextBuilder);
  WriteVariant(HTMLTextBuilder);
  WriteWeight(HTMLTextBuilder);
  WriteDecoration(HTMLTextBuilder);
  WriteTransform(HTMLTextBuilder);
end;

procedure TcxWebFont.WriteDecoration(HTMLTextBuilder: TcxHTMLTextBuilder);
var
  Result: string;
  Element: TcxWebFontDecoration;
begin
  if Decoration <> [] then
  begin
    Result := '';
    for Element := Low(TcxWebFontDecoration) to High(TcxWebFontDecoration) do
      if Element in Decoration then
        Result := Result + ' ' + cxWebFontDecorations[Element];
    HTMLTextBuilder.WriteStyleAttribute(saTextDecoration, Result);
  end;
end;

procedure TcxWebFont.WriteStyle(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
  if Style <> wfsNotSet then
    HTMLTextBuilder.WriteStyleAttribute(saFontStyle, cxWebFontStyles[Style]);
end;

procedure TcxWebFont.WriteTransform(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
  if Transform <> wftNotSet then
    HTMLTextBuilder.WriteStyleAttribute(saTextTransform, cxWebFontTransforms[Transform]);
end;

procedure TcxWebFont.WriteVariant(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
  if Variant <> wfvNotSet then
    HTMLTextBuilder.WriteStyleAttribute(saFontVariant, cxWebFontVariants[Variant]);
end;

procedure TcxWebFont.WriteWeight(HTMLTextBuilder: TcxHTMLTextBuilder);
begin
  if Weight <> wfwNotSet then
    HTMLTextBuilder.WriteStyleAttribute(saFontWeight, cxWebFontWeights[Weight]);
end;

procedure TcxWebFont.Changed;
begin
  if UpdateCount = 0 then
    if Assigned(FOnChange) then FOnChange(Self);
end;

function TcxWebFont.GetBold: Boolean;
begin
  Result := (Weight >= wfw600) or (Weight = wfwBold) or (Weight = wfwBolder);
end;

function TcxWebFont.GetItalic: Boolean;
begin
  Result := (Style = wfsItalic) or (Style = wfsOblique);
end;

function TcxWebFont.GetOverline: Boolean;
begin
  Result := wfdOverline in Decoration;
end;

function TcxWebFont.GetStrikeout: Boolean;
begin
  Result := wfdLineThrough in Decoration;
end;

function TcxWebFont.GetUnderline: Boolean;
begin
  Result := wfdUnderline in Decoration;
end;

function TcxWebFont.IsColorStored: Boolean;
begin
  Result := Color <> cxclDefaultWebFontColor;
end;

procedure TcxWebFont.SetBold(Value: Boolean);
begin
  if Value then
    Weight := wfwBold
  else
    Weight := wfwNormal;
end;

procedure TcxWebFont.SetColor(const Value: TcxWebColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Changed;
  end;
end;

procedure TcxWebFont.SetDecoration(Value: TcxWebFontDecorations);
begin
  if FDecoration <> Value then
  begin
    FDecoration := Value;
    Changed;
  end;
end;

procedure TcxWebFont.SetItalic(Value: Boolean);
begin
  if Value then
    Style := wfsItalic
  else
    Style := wfsNormal;
end;

procedure TcxWebFont.SetName(const Value: string);
begin
  FName := Value;
  FNames.Text := Value;
  Changed;
end;

procedure TcxWebFont.SetNames(Value: TStrings);
begin
  if Value.Count > 0 then
  begin
    FNames.Assign(Value);
    FName := FNames[0];
  end
  else
    FNames.Text := FName;
end;

procedure TcxWebFont.SetOverline(Value: Boolean);
begin
  if Value then
    Decoration := Decoration + [wfdOverline]
  else
    Decoration := Decoration - [wfdOverline];
end;

procedure TcxWebFont.SetSize(Value: TcxWebFontSize);
begin
  FSize.Assign(Value);
end;

procedure TcxWebFont.SetStrikeout(Value: Boolean);
begin
  if Value then
    Decoration := Decoration + [wfdLineThrough]
  else
    Decoration := Decoration - [wfdLineThrough];
end;

procedure TcxWebFont.SetStyle(Value: TcxWebFontStyle);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    Changed;
  end;
end;

procedure TcxWebFont.SetTransform(Value: TcxWebFontTransform); 
begin
  if FTransform <> Value then
  begin
    FTransform := Value;
    Changed;
  end;
end;

procedure TcxWebFont.SetUnderline(Value: Boolean);
begin
  if Value then
    Decoration := Decoration + [wfdUnderline]
  else
    Decoration := Decoration - [wfdUnderline];
end;

procedure TcxWebFont.SetVariant(Value: TcxWebFontVariant);
begin
  if FVariant <> Value then
  begin
    FVariant := Value;
    Changed;
  end;
end;

procedure TcxWebFont.SetWeight(Value: TcxWebFontWeight);
begin
  if FWeight <> Value then
  begin
    FWeight := Value;
    Changed;
  end;
end;

var
  FDefaultFont: TcxWebFont;
  
function cxWebDefaultFont: TcxWebFont;  
begin
  if FDefaultFont = nil then 
    FDefaultFont := TcxWebFont.Create;
  Result := FDefaultFont;
end;

initialization
  RegisterIntegerConsts(TypeInfo(TcxWebColor), cxIdentToWebColor, cxWebColorToIdent);

finalization  
  FDefaultFont.Free;
  
end.
