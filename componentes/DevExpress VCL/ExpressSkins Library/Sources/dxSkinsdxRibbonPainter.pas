{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{                    ExpressSkins Library                            }
{                                                                    }
{           Copyright (c) 2006-2010 Developer Express Inc.           }
{                     ALL RIGHTS RESERVED                            }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSSKINS AND ALL ACCOMPANYING     }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.              }
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

unit dxSkinsdxRibbonPainter;

interface

uses
  Types, Windows, Classes, SysUtils, dxSkinsCore, dxSkinsLookAndFeelPainter, Graphics,
  dxRibbonSkins, dxBarSkin, cxLookAndFeels, cxLookAndFeelPainters, cxGraphics,
  cxClasses, dxBarSkinConsts, cxGeometry, dxRibbon, dxBar, Math, cxDWMApi,
  Forms, dxSkinInfo, dxGDIPlusAPI, dxGDIPlusClasses, dxOffice11;

const
  QATLeftDefaultOffset = 15;
  QATOffsetDelta = 10;
  QATRightDefaultOffset = 12;

type

  { TdxSkinRibbonPainter }

  TdxSkinRibbonPainter = class(TdxBlackRibbonSkin)
  private
    FLookAndFeel: TcxLookAndFeel;
    function GetBorderBounds(ASide: TcxBorder; const ABorders, ABounds: TRect): TRect;
    function GetBorderSkinElement(ASide: TcxBorder; AIsRectangular: Boolean;
      ASkinInfo: TdxSkinLookAndFeelPainterInfo): TdxSkinElement;
    function GetCustomizeButtonOutsizeQAT(AHasAppButton: Boolean): Boolean;
    function GetElementMinimalSize(AElement: TdxSkinElement): TSize;
    function GetFormCaptionElement: TdxSkinElement;
    function GetPainter: TcxCustomLookAndFeelPainterClass;
    function GetQATLeftOffset: Integer;
    function GetSkinData(var ASkinInfo: TdxSkinLookAndFeelPainterInfo): Boolean;
    function GetStatusBarElement(AIsLeft: Boolean; var AElement: TdxSkinElement): Boolean;
    function IsSkinAvailable: Boolean;
    procedure DrawClippedElement(DC: HDC; const R: TRect; const ASource: TRect;
      AElement: TdxSkinElement; AState: TdxSkinElementState = esNormal;
      AIntersect: Boolean = False; AImageIndex: Integer = 0);
    procedure DrawColoredElement(DC: HDC; const R: TRect;
      AColor: TColor; AElement: TdxSkinElement; AState: TdxSkinElementState);
    function InternalDrawStatusBarPart(DC: HDC; const R: TRect;
      AIsRaised, AActive, AIsLeft: Boolean): Boolean;
    function InternalDrawStatusBarRectangularPart(DC: HDC; const R: TRect;
      AIsRaised, AActive, AIsLeft: Boolean): Boolean;
    procedure InternalDrawEditButton(DC: HDC; const R: TRect; AState: Integer; AButtonKind: TcxEditBtnKind);
    // SkinName
    procedure SetInternalSkinName(const ASkinName: string);
  protected
    function CorrectTabHeaderRect(const R: TRect): TRect;
    function GetName: string; override;
    function GetQATBackgroundElement(ABellow, AHasApplicationButton: Boolean): TdxSkinElement;
    procedure DrawFormBorder(DC: HDC; ASide: TcxBorder; ACaptionHeight: Integer;
      const ABorders, ABounds: TRect; AElement: TdxSkinElement; AActive: Boolean);
    procedure DrawStatusBarFormBorder(DC: HDC; const AData: TdxRibbonFormData;
      const ABorders: TRect; ASkinInfo: TdxSkinLookAndFeelPainterInfo);
    procedure GetElementContentIndents(AElement: TdxSkinElement;
      AConsideMargins: Boolean; out ALeftIndent, ARightIndent: Integer);
    procedure LookAndFeelChanged(Sender: TcxLookAndFeel; AChangedValues: TcxLookAndFeelValues); 

    property FormCaptionElement: TdxSkinElement read GetFormCaptionElement;
    property LookAndFeel: TcxLookAndFeel read FLookAndFeel;
  public
    constructor Create(const ASkinName: string); virtual;
    destructor Destroy; override;  
    //  Application
    procedure DrawApplicationButton(DC: HDC; const R: TRect;
      AState: TdxApplicationButtonState); override;
    procedure DrawApplicationMenuBorder(DC: HDC; const R: TRect); override;
    procedure DrawApplicationMenuButton(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawApplicationMenuContentFooter(DC: HDC; const R: TRect); override;
    procedure DrawApplicationMenuContentHeader(DC: HDC; const R: TRect); override;
    // Button Group
    procedure DrawButtonGroup(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawButtonGroupBorderLeft(DC: HDC; const R: TRect); override;
    procedure DrawButtonGroupBorderMiddle(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawButtonGroupBorderRight(DC: HDC; const R: TRect); override;
    procedure DrawButtonGroupSplitButtonSeparator(DC: HDC; const R: TRect; AState: Integer); override;
    // CollapsedToolbar
    procedure DrawCollapsedToolbarBackground(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawCollapsedToolbarGlyphBackground(DC: HDC; const R: TRect; AState: Integer); override;
    // EditButton
    procedure DrawEditArrowButton(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawEditEllipsisButton(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawEditSpinDownButton(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawEditSpinUpButton(DC: HDC; const R: TRect; AState: Integer); override;
    // Custom controls
    procedure DrawProgressDiscreteBand(DC: HDC; const R: TRect); override;
    procedure DrawProgressSolidBand(DC: HDC; const R: TRect); override;
    procedure DrawProgressSubstrate(DC: HDC; const R: TRect); override;
    // DropDown Gallery
    procedure DrawDropDownBorder(DC: HDC; const R: TRect); override;
    procedure DrawDropDownGalleryBackground(DC: HDC; const R: TRect); override;
    procedure DrawDropDownGalleryBottomSizeGrip(DC: HDC; const R: TRect); override;
    procedure DrawDropDownGalleryBottomSizingBand(DC: HDC; const R: TRect); override;
    procedure DrawDropDownGalleryBottomVerticalSizeGrip(DC: HDC; const R: TRect); override;
    procedure DrawDropDownGalleryTopSizingBand(DC: HDC; const R: TRect); override;
    procedure DrawDropDownGalleryTopSizeGrip(DC: HDC; const R: TRect); override;
    procedure DrawDropDownGalleryTopVerticalSizeGrip(DC: HDC; const R: TRect); override;
    procedure DrawGalleryFilterBandBackground(DC: HDC; const R: TRect); override;
    procedure DrawGalleryGroupHeaderBackground(DC: HDC; const R: TRect); override;
    procedure DrawInRibbonGalleryBackground(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawInRibbonGalleryScrollBarBackground(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawInRibbonGalleryScrollBarButton(DC: HDC; const R: TRect;
      AButtonKind: TdxInRibbonGalleryScrollBarButtonKind; AState: Integer); override;
    // Form
    procedure DrawFormBordersEx(DC: HDC; const ABordersWidth: TRect;
      ACaptionHeight: Integer; const AData: TdxRibbonFormData; AHasStatusBar: Boolean); override;
    procedure DrawFormBorderIcon(DC: HDC; const R: TRect;
      AIcon: TdxBorderDrawIcon; AState: TdxBorderIconState); override;
    procedure DrawFormCaption(DC: HDC; const R: TRect;
      const AData: TdxRibbonFormData); override;
    procedure DrawFormStatusBarPart(DC: HDC; const R: TRect; AIsLeft: Boolean;
      AIsActive: Boolean; AIsRaised: Boolean; AIsRectangular: Boolean); override;
    procedure DrawHelpButton(DC: HDC; const R: TRect; AState: TdxBorderIconState); override;
    // Contexts
    procedure DrawContextBackground(DC: HDC; const R: TRect; AColor: TColor); override;
    procedure DrawContextBackgroundGlass(DC: HDC; const R: TRect; AColor: TColor); override;
    procedure DrawContextTabSeparator(DC: HDC; const R: TRect); override;
    procedure DrawContextTabBackground(DC: HDC; const R: TRect;
      AState: TdxRibbonTabState; AColor: TColor); override;
    procedure DrawContextTabGroupsArea(DC: HDC; const R: TRect); override;
    // Others
    procedure DrawArrowDown(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawGroupScrollButton(DC: HDC; const R: TRect; ALeft: Boolean; AState: Integer); override;
    procedure DrawItemSeparator(DC: HDC; const R: TRect; AHorizontal: Boolean); override;
    procedure DrawKeyTip(DC: HDC; const R: TRect); override;
    procedure DrawMarkArrow(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawMDIButton(DC: HDC; const R: TRect; AButton: TdxBarMDIButton;
      AState: TdxBorderIconState); override;
    procedure DrawMDIButtonGlyph(DC: HDC; const R: TRect;
      AButton: TdxBarMDIButton; AState: TdxBorderIconState); override;
    procedure DrawRibbonClientTopArea(DC: HDC; const R: TRect); override;
    procedure DrawScreenTip(DC: HDC; const R: TRect); override;
    procedure DrawSeparatorBackground(DC: HDC; const R: TRect); override;
    // Large buttons
    procedure DrawLargeButton(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawLargeButtonDropButton(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawLargeButtonGlyphBackground(DC: HDC; const R: TRect; AState: Integer); override;
    // Launch
    procedure DrawLaunchButtonBackground(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawLaunchButtonDefaultGlyph(DC: HDC; const R: TRect; AState: Integer); override;
    // Menus
    procedure DrawMenuCheck(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawMenuCheckMark(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawMenuContent(DC: HDC; const R: TRect); override;
    procedure DrawMenuExtraSeparator(DC: HDC; const R: TRect; AHorizontal: Boolean); override;
    procedure DrawMenuGlyph(DC: HDC; const R: TRect); override;
    procedure DrawMenuMark(DC: HDC; const R: TRect); override;
    procedure DrawMenuScrollArea(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawMenuSeparatorHorz(DC: HDC; const R: TRect); override;
    procedure DrawMenuSeparatorVert(DC: HDC; const R: TRect); override;
    // Small buttons
    procedure DrawSmallButton(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawSmallButtonDropButton(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawSmallButtonGlyphBackground(DC: HDC; const R: TRect; AState: Integer); override;
    // Status Bar
    procedure DrawStatusBar(DC: HDC; const R: TRect); override;
    procedure DrawStatusBarGripBackground(DC: HDC; const R: TRect); override;
    procedure DrawStatusBarPanel(DC: HDC; const Bounds, R: TRect; AIsLowered: Boolean); override;
    procedure DrawStatusBarPanelSeparator(DC: HDC; const R: TRect); override;
    procedure DrawStatusBarToolbarSeparator(DC: HDC; const R: TRect); override;
    // Tabs
    procedure DrawTab(DC: HDC; const R: TRect; AState: TdxRibbonTabState); override;
    procedure DrawTabAreaBackground(DC: HDC; const R: TRect); override;
    procedure DrawTabGroupBackground(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawTabGroupHeaderBackground(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawTabGroupsArea(DC: HDC; const R: TRect); override;
    procedure DrawTabScrollButton(DC: HDC; const R: TRect; ALeft: Boolean; AState: Integer); override;
    procedure DrawTabSeparator(DC: HDC; const R: TRect; Alpha: Byte); override;
    procedure DrawRibbonBottomBorder(DC: HDC; const R: TRect); override;
    // QuickAccess
    procedure DrawQuickAccessToolbar(DC: HDC; const R: TRect;
      ABellow, ANonClientDraw, AHasApplicationButton, AIsActive, ADontUseAero: Boolean); override;
    procedure DrawQuickAccessToolbarDefaultGlyph(DC: HDC; const R: TRect); override;
    procedure DrawQuickAccessToolbarGroupButton(DC: HDC; const R: TRect;
      ABellow: Boolean; ANonClientDraw: Boolean; AIsActive: Boolean; AState: Integer); override;
    procedure DrawQuickAccessToolbarPopup(DC: HDC; const R: TRect); override;
    //
    function GetApplicationMenuGlyphSize: TSize; override;
    function GetCaptionFontSize(ACurrentFontSize: Integer): Integer; override;
    function GetMenuSeparatorSize: Integer; override;
    function GetPartColor(APart: Integer; AState: Integer = 0): TColor; override;
    function GetPartContentOffsets(APart: Integer): TRect; override;
    function GetPartOffset(APart: Integer): Integer; override;
    function GetQuickAccessToolbarLeftIndent(AHasApplicationButton, AUseAeroGlass: Boolean): Integer; override;
    function GetQuickAccessToolbarMarkButtonOffset(AHasApplicationButton, ABelow: Boolean): Integer; override;
    function GetQuickAccessToolbarOverrideWidth(AHasApplicationButton, AUseAeroGlass: Boolean): Integer; override;
    function GetQuickAccessToolbarRightIndent(AHasApplicationButton: Boolean): Integer; override;
    function GetSkinName: string; override;
    function GetStatusBarSeparatorSize: Integer; override;
    function GetWindowBordersWidth(AHasStatusBar: Boolean): TRect; override;
    function NeedDrawGroupScrollArrow: Boolean; override;
    //
    property Painter: TcxCustomLookAndFeelPainterClass read GetPainter;
    property SkinName: string read GetSkinName write SetInternalSkinName;
  end;

  { TdxSkinsRibbonCacheManager }

  TdxSkinsRibbonCacheManager = class(TObject)
  private
    FFormBordersCache: array[TcxBorder] of TdxSkinElementCache;
    FFormCaptionCache: TdxSkinElementCache;
    FSmallButtonsCache: TdxSkinElementCache;
    FTabGroupBackground: TdxSkinElementCacheList;
    FTabGroupsAreaCache: TdxSkinElementCache;
    function GetFormBordersCache(ASide: TcxBorder): TdxSkinElementCache;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Flush;
    // Properties
    property FormBordersCache[ASide: TcxBorder]: TdxSkinElementCache read GetFormBordersCache;
    property FormCaptionCache: TdxSkinElementCache read FFormCaptionCache;
    property SmallButtonsCache: TdxSkinElementCache read FSmallButtonsCache;
    property TabGroupBackground: TdxSkinElementCacheList read FTabGroupBackground;
    property TabGroupsAreaCache: TdxSkinElementCache read FTabGroupsAreaCache;
  end;

  { TdxSkinsRibbonPainterManager }

  TdxSkinsRibbonPainterManager = class(TcxIUnknownObject, IcxLookAndFeelPainterListener)
  protected
    procedure FreePaintersList;
    procedure InitializePaintersList;
    procedure PainterChanged(APainter: TcxCustomLookAndFeelPainterClass);
  public
    constructor Create; virtual;
    destructor Destroy; override;
  end;

implementation

uses
  dxSkinsStrs;

const
  RibbonFormBorderStates: array[Boolean] of TdxSkinElementState = (
    esActiveDisabled, esActive
  );
  RibbonTabStatesMap: array[TdxRibbonTabState] of TdxSkinElementState = (
    esNormal, esHot, esActive, esFocused, esFocused
  );

var
  SkinsRibbonCacheManager: TdxSkinsRibbonCacheManager;
  SkinsRibbonPainterManager: TdxSkinsRibbonPainterManager;

function SkinElementStateByRibbonState(AState: Integer): TdxSkinElementState;
const
  StateMap: array[0..8] of TdxSkinElementState = (
    esNormal, esDisabled, esHot, esActive, esPressed,
    esChecked, esChecked, esHotCheck, esActiveDisabled
  );
begin
  if (Low(StateMap) <= AState) and (High(StateMap) >= AState) then
    Result := StateMap[AState]
  else
    Result := esNormal;
end;

function SkinElementCheckState(AElement: TdxSkinElement; AState: TdxSkinElementState): TdxSkinElementState; overload;
begin
  Result := AState;
  if not (AState in AElement.Image.States) then
  begin
    case AState of
      esActiveDisabled, esActive, esHotCheck:
        Result := esHot;
      esChecked, esCheckPressed, esDroppedDown:
        Result := esPressed;
    end;
  end;
end;

function SkinElementCheckState(AElement: TdxSkinElement; AState: Integer): TdxSkinElementState; overload;
begin
  Result := SkinElementCheckState(AElement, SkinElementStateByRibbonState(AState));
end;

{ TdxSkinRibbonPainter }

constructor TdxSkinRibbonPainter.Create(const ASkinName: string);
begin
  FLookAndFeel := TcxLookAndFeel.Create(nil);
  FLookAndFeel.NativeStyle := False;
  FLookAndFeel.SkinName := ASkinName;
  inherited Create;
  FLookAndFeel.OnChanged := LookAndFeelChanged;
end;

destructor TdxSkinRibbonPainter.Destroy;
begin
  FreeAndNil(FLookAndFeel);
  inherited Destroy;
end;

function TdxSkinRibbonPainter.CorrectTabHeaderRect(const R: TRect): TRect;
begin
  Result := cxRectInflate(R, -1, -2, -1, 0);
end;

function TdxSkinRibbonPainter.GetName: string;
begin
  Result := GetSkinName;
end;

procedure TdxSkinRibbonPainter.SetInternalSkinName(const ASkinName: string);
begin
  LookAndFeel.SkinName := ASkinName;
end;

function TdxSkinRibbonPainter.GetSkinData(
  var ASkinInfo: TdxSkinLookAndFeelPainterInfo): Boolean;
begin
  Result := GetExtendedStylePainters.GetPainterData(LookAndFeel.SkinPainter, ASkinInfo);
end;

function TdxSkinRibbonPainter.GetStatusBarElement(
  AIsLeft: Boolean; var AElement: TdxSkinElement): Boolean;
const
  ABorders: array[Boolean] of TcxBorder = (bRight, bLeft);
var
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonStatusBarBackground
  else
    AElement := nil;
    
  Result := Assigned(AElement);
end;

function TdxSkinRibbonPainter.GetBorderBounds(
  ASide: TcxBorder; const ABorders, ABounds: TRect): TRect;
begin
  Result := ABounds;
  if ASide in [bLeft, bRight] then
  begin
    Result.Top := ABorders.Top;
    if ASide = bLeft then
      Result.Right := Result.Left + ABorders.Left
    else
      Result.Left := Result.Right - ABorders.Right;
  end
  else
    if ASide = bTop then
      Result.Bottom := ABorders.Top
    else
      Result := Rect(Result.Left + 4, Result.Bottom - ABorders.Bottom,
        Result.Right - 4, Result.Bottom);
end;

function TdxSkinRibbonPainter.GetBorderSkinElement(ASide: TcxBorder;
  AIsRectangular: Boolean; ASkinInfo: TdxSkinLookAndFeelPainterInfo): TdxSkinElement;
begin
  case ASide of
    bLeft:
      Result := ASkinInfo.RibbonFormLeft[AIsRectangular];
    bTop:
      Result := ASkinInfo.RibbonFormCaption;
    bRight:
      Result := ASkinInfo.RibbonFormRight[AIsRectangular];
    bBottom:
      Result := ASkinInfo.RibbonFormBottom[AIsRectangular];
    else
      Result := nil;
  end;
end;

function TdxSkinRibbonPainter.GetCustomizeButtonOutsizeQAT(AHasAppButton: Boolean): Boolean;
var
  AProperty: TdxSkinBooleanProperty;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  Result := False;
  if GetSkinData(ASkinInfo) then
  begin
    AProperty := ASkinInfo.RibbonQATCustomizeButtonOutsizeQAT[AHasAppButton];
    if AProperty <> nil then
      Result := AProperty.Value;
  end;
end;

function TdxSkinRibbonPainter.GetElementMinimalSize(AElement: TdxSkinElement): TSize;
begin
  with AElement.Image.Margins do
  begin
    Result.cx := Max(Left + Right, Max(AElement.MinSize.Width, AElement.Size.cx));
    Result.cy := Max(Top + Bottom, Max(AElement.MinSize.Height, AElement.Size.cy));
  end;
end;

function TdxSkinRibbonPainter.GetFormCaptionElement: TdxSkinElement;
var
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    Result := ASkinInfo.RibbonFormCaption
  else
    Result := nil;
end;

function TdxSkinRibbonPainter.GetPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := LookAndFeel.Painter;
end;

function TdxSkinRibbonPainter.GetQATBackgroundElement(
  ABellow, AHasApplicationButton: Boolean): TdxSkinElement;
var
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
  begin
    if ABellow then
      Result := ASkinInfo.RibbonQuickToolbarBelow
    else
      Result := ASkinInfo.RibbonQuickToolbar[AHasApplicationButton];
  end
  else
    Result := nil;
end;

function TdxSkinRibbonPainter.GetQATLeftOffset: Integer;
var
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
  begin
    Result := QATOffsetDelta +
      ASkinInfo.GetIntegerPropertyValue(ASkinInfo.RibbonApplicationButton, sdxRibbonAppButtonRightIndent) +
      ASkinInfo.GetIntegerPropertyValue(GetQATBackgroundElement(False, True), sdxRibbonQuickAccessToolbarOffset);
  end
  else
    Result := 0;
end;

function TdxSkinRibbonPainter.IsSkinAvailable: Boolean;
begin
  Result := LookAndFeel.SkinPainter <> nil;
end;

procedure TdxSkinRibbonPainter.DrawApplicationButton(
  DC: HDC; const R: TRect; AState: TdxApplicationButtonState);
const
  dxApplicationButtonStateToElementState: array[TdxApplicationButtonState] of
    TdxSkinElementState = (esNormal, esHot, esPressed);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  AElement := nil;
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonApplicationButton;

  if AElement = nil then
    inherited DrawApplicationButton(DC, R, AState)
  else
    AElement.Draw(DC, R, 0, dxApplicationButtonStateToElementState[AState]);
end;

procedure TdxSkinRibbonPainter.DrawApplicationMenuBorder(DC: HDC; const R: TRect);
var
  AFooter: TdxSkinElement;
  AHeader: TdxSkinElement;
  ARect: TRect;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
  begin
    AFooter := ASkinInfo.RibbonApplicationFooterBackground;
    AHeader := ASkinInfo.RibbonApplicationHeaderBackground;
  end
  else
  begin
    AFooter := nil;
    AHeader := nil;
  end;

  if (AFooter = nil) or (AHeader = nil) then
    inherited DrawApplicationMenuBorder(DC, R)
  else
  begin
    DrawTabAreaBackground(DC, R);
    cxPaintCanvas.BeginPaint(DC);
    try
      ARect := cxRectSetTop(R, R.Bottom - AFooter.Size.cy, AFooter.Size.cy);
      AFooter.Draw(DC, ARect);
      cxPaintCanvas.ExcludeClipRect(ARect);
      AHeader.Draw(DC, cxRectSetHeight(R, cxRectHeight(R) + AHeader.Image.Margins.Bottom));
    finally
      cxPaintCanvas.EndPaint;
    end;
  end;
end;

procedure TdxSkinRibbonPainter.DrawApplicationMenuButton(DC: HDC; const R: TRect; AState: Integer);
const
  ButtonState: array [Boolean] of TdxSkinElementState = (esNormal, esHot);
var
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
  AButton: TdxSkinElement;
begin
  if GetSkinData(ASkinInfo) then
    AButton := ASkinInfo.ButtonElements
  else
    AButton := nil;

  if AButton = nil then
    inherited DrawApplicationMenuButton(DC, R, AState)
  else
    AButton.Draw(DC, R, 0, ButtonState[AState = DXBAR_HOT]);
end;

procedure TdxSkinRibbonPainter.DrawApplicationMenuContentFooter(DC: HDC; const R: TRect);
var
  AFooter: TdxSkinElement;
  ARect: TRect;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AFooter := ASkinInfo.RibbonApplicationFooterBackground
  else
    AFooter := nil;

  if AFooter = nil then
    inherited DrawApplicationMenuContentFooter(DC, R)
  else
  begin
    ARect := cxRectInflate(R, 3, 0, 3, 3);
    Dec(ARect.Top, AFooter.Image.Margins.Top);
    DrawClippedElement(DC, R, ARect, AFooter, esNormal, True);
  end;
end;

procedure TdxSkinRibbonPainter.DrawApplicationMenuContentHeader(DC: HDC; const R: TRect);
var
  AHeader: TdxSkinElement;
  ARect: TRect;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AHeader := ASkinInfo.RibbonApplicationHeaderBackground
  else
    AHeader := nil;

  if AHeader = nil then
    inherited DrawApplicationMenuContentHeader(DC, R)
  else
  begin
    ARect := cxRectInflate(R, 3, 3, 3, 0);
    Inc(ARect.Bottom, AHeader.Image.Margins.Bottom);
    DrawClippedElement(DC, R, ARect, AHeader);
  end;
end;

procedure TdxSkinRibbonPainter.DrawButtonGroup(DC: HDC; const R: TRect; AState: Integer);
var
  ABackground: TdxSkinElement;
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  AElement := nil;
  ABackground := nil;
  if GetSkinData(ASkinInfo) then
  begin
    AElement := ASkinInfo.RibbonButtonGroupButton;
    ABackground := ASkinInfo.RibbonButtonGroup;
  end;

  if (AElement = nil) or (ABackground = nil) then
    inherited DrawButtonGroup(DC, R, AState)
  else
  begin
    DrawClippedElement(DC, R, Rect(R.Left - ABackground.Image.Margins.Left,
      R.Top, R.Right + ABackground.Image.Margins.Right, R.Bottom), ABackground,
      esNormal, True);
    AElement.Draw(DC, R, 0, SkinElementStateByRibbonState(AState));
  end;
end;

procedure TdxSkinRibbonPainter.DrawButtonGroupSplitButtonSeparator(
  DC: HDC; const R: TRect; AState: Integer);
var
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
  AElement: TdxSkinElement;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonButtonGroupButton
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawButtonGroupSplitButtonSeparator(DC, R, AState)
  else
  begin
    cxPaintCanvas.BeginPaint(DC);
    cxPaintCanvas.SaveClipRegion;
    try
      cxPaintCanvas.SetClipRegion(TcxRegion.Create(R), roIntersect);
      DrawButtonGroup(cxPaintCanvas.Handle,
        cxRectInflate(R, AElement.ContentOffset.Left, 0, AElement.ContentOffset.Right, 0),
        AState);
    finally
      cxPaintCanvas.RestoreClipRegion;
      cxPaintCanvas.EndPaint;
    end;
  end;
end;

procedure TdxSkinRibbonPainter.DrawButtonGroupBorderLeft(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
  ARect: TRect;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonButtonGroup
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawButtonGroupBorderLeft(DC, R)
  else
  begin
    ARect := R;
    ARect.Right := Max(R.Left + AElement.Size.cx, R.Right);
    DrawClippedElement(DC, R, ARect, AElement, esNormal, True);
  end;
end;

procedure TdxSkinRibbonPainter.DrawButtonGroupBorderRight(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
  ARect: TRect;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonButtonGroup
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawButtonGroupBorderLeft(DC, R)
  else
    if not IsRectEmpty(R) then
    begin
      ARect := R;
      ARect.Left := Min(R.Left, R.Right - AElement.Size.cx);
      DrawClippedElement(DC, R, ARect, AElement);
    end;
end;

procedure TdxSkinRibbonPainter.DrawButtonGroupBorderMiddle(DC: HDC; const R: TRect;
  AState: Integer);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonButtonGroupSeparator
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawButtonGroupBorderMiddle(DC, R, AState)
  else
    AElement.Draw(DC, R, 0, SkinElementStateByRibbonState(AState));    
end;

procedure TdxSkinRibbonPainter.DrawCollapsedToolbarBackground(
  DC: HDC; const R: TRect; AState: Integer);
var
  ACollapsedToolBar: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    ACollapsedToolBar := ASkinInfo.RibbonCollapsedToolBarBackground
  else
    ACollapsedToolBar := nil;

  if ACollapsedToolBar <> nil then
    ACollapsedToolBar.Draw(DC, R, 0, SkinElementStateByRibbonState(AState))
  else
    inherited DrawCollapsedToolbarBackground(DC, R, AState);
end;

procedure TdxSkinRibbonPainter.DrawCollapsedToolbarGlyphBackground(DC: HDC;
  const R: TRect; AState: Integer);
var
  ACollapsedToolBarGlyph: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    ACollapsedToolBarGlyph := ASkinInfo.RibbonCollapsedToolBarGlyphBackground
  else
    ACollapsedToolBarGlyph := nil;

  if ACollapsedToolBarGlyph <> nil then
    ACollapsedToolBarGlyph.Draw(DC, R)
  else
    inherited DrawCollapsedToolbarGlyphBackground(DC, R, AState);
end;

procedure TdxSkinRibbonPainter.DrawContextTabSeparator(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonContextualTabSeparator
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawContextTabSeparator(DC, R)
  else
    AElement.Draw(DC, R);
end;

procedure TdxSkinRibbonPainter.DrawContextTabBackground(
  DC: HDC; const R: TRect; AState: TdxRibbonTabState; AColor: TColor);
var
  AElement: TdxSkinElement;
  ARect: TRect;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonContextualTabHeader
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawContextTabBackground(DC, R, AState, AColor)
  else
  begin
    DrawTabAreaBackground(DC, R);
    ARect := CorrectTabHeaderRect(R);
    if AElement.ImageCount > 1 then
      DrawColoredElement(DC, R, AColor, AElement, RibbonTabStatesMap[AState])
    else
    begin
      dxGpFillRect(DC, ARect, AColor);
      AElement.Draw(DC, ARect, 0, RibbonTabStatesMap[AState]);
    end;
  end;
end;

procedure TdxSkinRibbonPainter.DrawContextTabGroupsArea(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonContextualTabPanel
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawContextTabGroupsArea(DC, R)
  else
    AElement.Draw(DC, R);
end;

procedure TdxSkinRibbonPainter.DrawContextBackground(DC: HDC; const R: TRect; AColor: TColor);
var
  AElement: TdxSkinElement;
  ARect: TRect;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonContextualTabLabel
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawContextBackground(DC, R, AColor)
  else
  begin
    ARect := R;
    Inc(ARect.Bottom);
    if AElement.ImageCount > 1 then
      DrawColoredElement(DC, ARect, AColor, AElement, esNormal)
    else
    begin
      FillRectByColor(DC, ARect, AColor);
      AElement.Draw(DC, ARect);
    end;
  end;
end;

procedure TdxSkinRibbonPainter.DrawContextBackgroundGlass(DC: HDC; const R: TRect; AColor: TColor);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonContextualTabLabelOnGlass
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawContextBackgroundGlass(DC, R, AColor)
  else
    if AElement.ImageCount > 1 then
      DrawColoredElement(DC, R, AColor, AElement, esNormal)
    else
    begin
      dxGpFillRectByGradient(DC, R, 0, AColor, LinearGradientModeVertical, 0, 220);
      AElement.Draw(DC, R)
    end;
end;

procedure TdxSkinRibbonPainter.DrawEditArrowButton(DC: HDC; const R: TRect; AState: Integer);
begin
  InternalDrawEditButton(DC, R, AState, cxbkComboBtn);
end;

procedure TdxSkinRibbonPainter.DrawEditEllipsisButton(DC: HDC; const R: TRect; AState: Integer);
begin
  InternalDrawEditButton(DC, R, AState, cxbkEllipsisBtn);
end;

procedure TdxSkinRibbonPainter.DrawEditSpinDownButton(DC: HDC; const R: TRect; AState: Integer);
begin
  InternalDrawEditButton(DC, R, AState, cxbkSpinDownBtn);
end;

procedure TdxSkinRibbonPainter.DrawEditSpinUpButton(DC: HDC; const R: TRect; AState: Integer);
begin
  InternalDrawEditButton(DC, R, AState, cxbkSpinUpBtn);
end;

procedure TdxSkinRibbonPainter.DrawProgressDiscreteBand(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
  ARect: TRect;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;

  function CheckRect(const R: TRect): TRect;
  begin
    Result := R;
    if ASkinInfo.ProgressBarElements[False, False] <> nil then
    begin
      InflateRect(Result, 0, 2);
      with ASkinInfo.ProgressBarElements[False, False].ContentOffset.Rect do
      begin
        Inc(Result.Top, Top);
        Dec(Result.Bottom, Bottom);
      end;
    end;
  end;

begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.ProgressBarElements[True, False]
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawProgressDiscreteBand(DC, R)
  else
  begin
    ARect := CheckRect(R);
    with AElement.Image.Margins.Rect do
    begin
      Dec(ARect.Left, Left);
      Inc(ARect.Right, Right);
    end;
    DrawClippedElement(DC, R, ARect, AElement);
  end;      
end;

procedure TdxSkinRibbonPainter.DrawProgressSolidBand(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
  ARect: TRect;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.ProgressBarElements[True, False]
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawProgressDiscreteBand(DC, R)
  else
  begin
    ARect := R;
    if ASkinInfo.ProgressBarElements[False, False] <> nil then
    begin
      InflateRect(ARect, 2, 2);
      ARect := cxRectContent(ARect,
        ASkinInfo.ProgressBarElements[False, False].ContentOffset.Rect);
    end;
    DrawClippedElement(DC, R, ARect, AElement);
  end;
end;

procedure TdxSkinRibbonPainter.DrawProgressSubstrate(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.ProgressBarElements[False, False]
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawProgressSubstrate(DC, R)
  else
    AElement.Draw(DC, R);
end;

procedure TdxSkinRibbonPainter.DrawDropDownBorder(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  AElement := nil;
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.PopupMenu;

  if AElement = nil then
    inherited DrawDropDownBorder(DC, R)
  else
    AElement.Draw(DC, R);
end;                          

procedure TdxSkinRibbonPainter.DrawDropDownGalleryBackground(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonGalleryBackground
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawDropDownGalleryBackground(DC, R)
  else
    AElement.Draw(DC, R);
end;

procedure TdxSkinRibbonPainter.DrawDropDownGalleryBottomSizeGrip(DC: HDC;
  const R: TRect);
var
  AElement: TdxSkinElement;
  ARect: TRect;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonGallerySizeGrips
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawDropDownGalleryBottomSizeGrip(DC, R)
  else
  begin
    ARect := cxRectInflate(R, 0, -3, -2, -1);
    ARect.Left := ARect.Right - cxRectHeight(ARect);
    AElement.Draw(DC, ARect, 1);
  end;
end;

procedure TdxSkinRibbonPainter.DrawDropDownGalleryBottomSizingBand(DC: HDC;
  const R: TRect);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonGallerySizingPanel
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawDropDownGalleryBottomSizingBand(DC, R)
  else
    AElement.Draw(DC, R);
end;

procedure TdxSkinRibbonPainter.DrawDropDownGalleryBottomVerticalSizeGrip(DC: HDC;
  const R: TRect);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonGallerySizeGrips
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawDropDownGalleryBottomVerticalSizeGrip(DC, R)
  else
    AElement.Draw(DC, R);
end;

procedure TdxSkinRibbonPainter.DrawDropDownGalleryTopSizingBand(DC: HDC;
  const R: TRect);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonGallerySizingPanel
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawDropDownGalleryTopSizingBand(DC, R)
  else
    AElement.Draw(DC, R);
end;

procedure TdxSkinRibbonPainter.DrawDropDownGalleryTopSizeGrip(DC: HDC;
  const R: TRect);
var
  AElement: TdxSkinElement;
  ARect: TRect;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonGallerySizeGrips
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawDropDownGalleryTopSizingBand(DC, R)
  else
  begin
    ARect := cxRectInflate(R, 0, -3, -2, -1);
    ARect.Left := ARect.Right - cxRectHeight(ARect);
    AElement.Draw(DC, ARect, 2);
  end;
end;

procedure TdxSkinRibbonPainter.DrawDropDownGalleryTopVerticalSizeGrip(DC: HDC;
  const R: TRect);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonGallerySizeGrips
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawDropDownGalleryTopVerticalSizeGrip(DC, R)
  else
    AElement.Draw(DC, R);
end;

procedure TdxSkinRibbonPainter.DrawGalleryFilterBandBackground(DC: HDC;
  const R: TRect);
begin
  DrawDropDownGalleryBottomSizingBand(DC, R);
end;

procedure TdxSkinRibbonPainter.DrawGalleryGroupHeaderBackground(DC: HDC;
  const R: TRect);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonGalleryGroupCaption
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawGalleryGroupHeaderBackground(DC, R)
  else
    AElement.Draw(DC, R);
end;

procedure TdxSkinRibbonPainter.DrawInRibbonGalleryBackground(
  DC: HDC; const R: TRect; AState: Integer);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
  R1: TRect;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonGalleryPane
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawInRibbonGalleryBackground(DC, R, AState)
  else
  begin
    R1 := R;
    Inc(R1.Right, AElement.Image.Margins.Right);
    DrawClippedElement(DC, R, R1, AElement, SkinElementStateByRibbonState(AState), True);
  end;
end;

procedure TdxSkinRibbonPainter.DrawInRibbonGalleryScrollBarButton(
  DC: HDC; const R: TRect; AButtonKind: TdxInRibbonGalleryScrollBarButtonKind;
  AState: Integer);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  AElement := nil;
  if GetSkinData(ASkinInfo) then
  begin
    case AButtonKind of
      gsbkLineUp:
        AElement := ASkinInfo.RibbonGalleryButtonUp;
      gsbkLineDown:
        AElement := ASkinInfo.RibbonGalleryButtonDown;
      gsbkDropDown:
        AElement := ASkinInfo.RibbonGalleryButtonDropDown;
    end;
  end;

  if AElement = nil then
    inherited DrawInRibbonGalleryScrollBarButton(DC, R, AButtonKind, AState)
  else
    AElement.Draw(DC, R, 0, SkinElementStateByRibbonState(AState));
end;

procedure TdxSkinRibbonPainter.DrawInRibbonGalleryScrollBarBackground(
  DC: HDC; const R: TRect; AState: Integer);
var
  R1: TRect;
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonGalleryPane
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawInRibbonGalleryScrollBarBackground(DC, R, AState)
  else
  begin
    R1 := R;
    Dec(R1.Left, Max(AElement.Size.cx, AElement.Image.Margins.Left));
    DrawClippedElement(DC, R, R1, AElement, SkinElementStateByRibbonState(AState), True);
  end;
end;

procedure TdxSkinRibbonPainter.DrawArrowDown(DC: HDC; const R: TRect; AState: Integer);
const
  StateMap: array[0..8] of TdxSkinElementState = (esNormal, esDisabled, esHot,
    esActive, esNormal, esNormal, esNormal, esNormal, esNormal);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonButtonArrow
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawArrowDown(DC, R, AState)
  else
    AElement.Draw(DC, R, 0, StateMap[AState]);
end;                          

procedure TdxSkinRibbonPainter.DrawClippedElement(
  DC: HDC; const R: TRect; const ASource: TRect; AElement: TdxSkinElement;
  AState: TdxSkinElementState = esNormal; AIntersect: Boolean = False;
  AImageIndex: Integer = 0);
const
  ARegionOperations: array[Boolean] of TcxRegionOperation = (roSet, roIntersect);
begin
  cxPaintCanvas.BeginPaint(DC);
  try
    cxPaintCanvas.SetClipRegion(TcxRegion.Create(R), ARegionOperations[AIntersect]);
    AElement.Draw(cxPaintCanvas.Handle, ASource, AImageIndex, AState);
  finally
    cxPaintCanvas.EndPaint;
  end;
end;

procedure TdxSkinRibbonPainter.DrawColoredElement(DC: HDC; const R: TRect;
  AColor: TColor; AElement: TdxSkinElement; AState: TdxSkinElementState);
var
  ABitmap: TcxBitmap32;
begin
  ABitmap := TcxBitmap32.CreateSize(R, True);
  try
    AElement.Draw(ABitmap.Canvas.Handle, ABitmap.ClientRect, 0, AState);
    cxMakeColoredBitmap(ABitmap, AColor);
    AElement.Draw(ABitmap.Canvas.Handle, ABitmap.ClientRect, 1, AState);
    cxAlphaBlend(DC, ABitmap, R, ABitmap.ClientRect);
  finally
    ABitmap.Free;
  end;
end;

procedure TdxSkinRibbonPainter.InternalDrawEditButton(DC: HDC; const R: TRect;
  AState: Integer; AButtonKind: TcxEditBtnKind);
const
  ButtonState: array [DXBAR_NORMAL..DXBAR_ACTIVEDISABLED] of TcxButtonState = (
    cxbsNormal, cxbsDisabled, cxbsHot, cxbsNormal, cxbsPressed, cxbsPressed,
    cxbsDefault, cxbsDefault, cxbsDisabled);
begin
  if IsSkinAvailable then
  begin
    cxPaintCanvas.BeginPaint(DC);
    try
      Painter.DrawEditorButton(cxPaintCanvas, R, AButtonKind, ButtonState[AState]);
    finally
      cxPaintCanvas.EndPaint;
    end;
  end
  else
    DrawEditButton(DC, R, AState);
end;

function TdxSkinRibbonPainter.InternalDrawStatusBarPart(
  DC: HDC; const R: TRect; AIsRaised, AActive, AIsLeft: Boolean): Boolean;
const
  IndexMap: array[Boolean] of Integer = (0, 1);
  StateMap: array[Boolean] of TdxSkinElementState = (esActiveDisabled, esActive);
var
  AElement: TdxSkinElement;
  AMinSize: TSize;
  R1: TRect;
begin
  Result := GetStatusBarElement(AIsLeft, AElement);
  if Result then
  begin
    cxPaintCanvas.BeginPaint(DC);
    try
      AMinSize := GetElementMinimalSize(AElement);
      cxPaintCanvas.SetClipRegion(TcxRegion.Create(R), roIntersect);
      R1 := R;
      if AIsLeft then
        R1.Right := Max(R1.Left + AMinSize.cx, R1.Right + AElement.Image.Margins.Right)
      else
        R1.Left := Min(R1.Right - AMinSize.cx, R1.Left - AElement.Image.Margins.Left);

      AElement.Draw(cxPaintCanvas.Handle, R1, IndexMap[AIsRaised], StateMap[AActive]);
      if AMinSize.cy > cxRectHeight(R1) then
      begin
        R1 := cxRectSetBottom(R1, R1.Bottom, AMinSize.cy);
        cxPaintCanvas.SetClipRegion(TcxRegion.Create(cxRectSetBottom(R, R.Bottom, 4)), roIntersect);
        AElement.Draw(cxPaintCanvas.Handle, R1, IndexMap[AIsRaised], StateMap[AActive]);        
      end;
    finally
      cxPaintCanvas.EndPaint;
    end;
  end;
end;

function TdxSkinRibbonPainter.InternalDrawStatusBarRectangularPart(
  DC: HDC; const R: TRect; AIsRaised, AActive, AIsLeft: Boolean): Boolean;
const
  SideMap: array[Boolean] of TcxBorder = (bRight, bLeft);
var
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  Result := GetSkinData(ASkinInfo);
  if Result then
  begin
    DrawFormBorder(DC, SideMap[AIsLeft], 0,
      Rect(cxRectWidth(R), 0, cxRectWidth(R), 0), R,
      GetBorderSkinElement(SideMap[AIsLeft], True, ASkinInfo), AActive);
  end;
end;

procedure TdxSkinRibbonPainter.DrawFormBordersEx(
  DC: HDC; const ABordersWidth: TRect; ACaptionHeight: Integer;
  const AData: TdxRibbonFormData; AHasStatusBar: Boolean);

  procedure DrawBottomCorner(ASide: TcxBorder; R: TRect;
    ASkinInfo: TdxSkinLookAndFeelPainterInfo);
  var
    ABitmap: TcxBitmap;
    AElement: TdxSkinElement;
  begin
    AElement := GetBorderSkinElement(ASide, IsRectangularFormBottom(AData), ASkinInfo);
    if Assigned(AElement) then
    begin
      ABitmap := TcxBitmap.CreateSize(R);
      try
        ABitmap.cxCanvas.WindowOrg := R.TopLeft;
        Dec(R.Top, AElement.Size.cy);
        AElement.Draw(ABitmap.Canvas.Handle, R, Integer(not AData.Active));
        cxBitBlt(DC, ABitmap.Canvas.Handle, R, cxNullPoint, SRCCOPY);
      finally
        ABitmap.Free;
      end;
    end;
  end;

  procedure InternalDrawBorder(ASide: TcxBorder; ASkinInfo: TdxSkinLookAndFeelPainterInfo);
  begin
    if (ASide <> bTop) or (ACaptionHeight <> 0) then
    begin
      if (ASide = bBottom) and AHasStatusBar then
        DrawStatusBarFormBorder(DC, AData, ABordersWidth, ASkinInfo)
      else
        DrawFormBorder(DC, ASide, ACaptionHeight, ABordersWidth, AData.Bounds, 
          GetBorderSkinElement(ASide, IsRectangularFormBottom(AData), ASkinInfo),
          AData.Active);
    end;
  end;

var
  ASide: TcxBorder;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
  R: TRect;
begin
  if GetSkinData(ASkinInfo) then
  begin
    cxPaintCanvas.BeginPaint(DC);
    cxPaintCanvas.SaveClipRegion;
    try
      cxPaintCanvas.ExcludeClipRect(cxRectContent(AData.Bounds, ABordersWidth));
      for ASide := Low(TcxBorder) to High(TcxBorder) do
        InternalDrawBorder(ASide, ASkinInfo);
      if ABordersWidth.Bottom > 1 then
      begin
        R := AData.Bounds;
        R.Top := R.Bottom - ABordersWidth.Bottom;
        DrawBottomCorner(bLeft, cxRectSetWidth(R, 4), ASkinInfo);
        DrawBottomCorner(bRight, cxRectSetLeft(R, R.Right - 4, 4), ASkinInfo);
      end;
    finally
      cxPaintCanvas.RestoreClipRegion;
      cxPaintCanvas.EndPaint;
    end;
  end
  else
    inherited DrawFormBordersEx(DC, ABordersWidth, ACaptionHeight, AData, AHasStatusBar);
end;

procedure TdxSkinRibbonPainter.DrawFormBorder(DC: HDC; ASide: TcxBorder;
  ACaptionHeight: Integer; const ABorders, ABounds: TRect;
  AElement: TdxSkinElement; AActive: Boolean);

  function IsBorderThin(const R: TRect; ASide: TcxBorder; const ASize: TSize): Boolean;
  begin
    if ASide in [bLeft, bRight] then
      Result := cxRectWidth(R) < ASize.cx
    else
      Result := cxRectHeight(R) < ASize.cy;
  end;

  function CorrectThinBorderSourceRect(const R: TRect; const ASize: TSize): TRect;
  begin
    Result := R;
    case ASide of
      bTop:
        Inc(Result.Bottom, ASize.cy - cxRectHeight(R));
      bLeft:
        Inc(Result.Right, ASize.cx - cxRectWidth(R));
      bRight:
        Dec(Result.Left, ASize.cx - cxRectWidth(R));
      bBottom:
        Dec(Result.Top, ASize.cy - cxRectHeight(R));
    end;
  end;

  procedure DrawThinBorder(DC: HDC; const R: TRect; AElement: TdxSkinElement);
  begin
    SkinsRibbonCacheManager.FormBordersCache[ASide].DrawEx(
      DC, AElement, CorrectThinBorderSourceRect(R, AElement.Size),
      RibbonFormBorderStates[AActive], Integer(not AActive));
  end;

var
  ABitmap: TcxBitmap;
  R: TRect;
begin
  if Assigned(AElement) then
  begin
    R := ABorders;
    Inc(R.Top, ACaptionHeight);
    R := GetBorderBounds(ASide, R, ABounds);
    if not IsRectEmpty(R) then
    begin
      ABitmap := TcxBitmap.CreateSize(R);
      try
        if IsBorderThin(R, ASide, AElement.Size) then
          DrawThinBorder(ABitmap.Canvas.Handle, ABitmap.ClientRect, AElement)
        else
          SkinsRibbonCacheManager.FormBordersCache[ASide].DrawEx(
            ABitmap.Canvas.Handle, AElement, ABitmap.ClientRect,
            RibbonFormBorderStates[AActive], Integer(not AActive));
        cxBitBlt(DC, ABitmap.Canvas.Handle, R, cxNullPoint, SRCCOPY);
      finally
        ABitmap.Free;
      end;
    end;
  end;
end;

procedure TdxSkinRibbonPainter.DrawStatusBarFormBorder(
  DC: HDC; const AData: TdxRibbonFormData; const ABorders: TRect;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo);
var
  ALeftIndent, ARightIndent: Integer;
  R, R1: TRect;
begin
  if Assigned(ASkinInfo.RibbonStatusBarBackground) and (ABorders.Bottom > 1) then
  begin
    R1 := cxRectSetTop(AData.Bounds, AData.Bounds.Bottom - ABorders.Bottom - 1, ABorders.Bottom);
    R1 := cxRectInflate(R1, -ABorders.Left, 0, -ABorders.Right, 0);
    GetElementContentIndents(ASkinInfo.RibbonStatusBarBackground, True, ALeftIndent, ARightIndent);
    R := cxRectInflate(R1, ALeftIndent, 0, ARightIndent, 0);
    Dec(R.Top, ASkinInfo.RibbonStatusBarBackground.Size.cy - ABorders.Bottom);
    DrawClippedElement(DC, R1, R, ASkinInfo.RibbonStatusBarBackground);
  end;
  DrawFormBorder(DC, bBottom, 0, Rect(ABorders.Left, 0, ABorders.Right, 1), AData.Bounds,
    GetBorderSkinElement(bBottom, IsRectangularFormBottom(AData), ASkinInfo),
    AData.Active);
end;

procedure TdxSkinRibbonPainter.DrawFormBorderIcon(
  DC: HDC; const R: TRect; AIcon: TdxBorderDrawIcon; AState: TdxBorderIconState);
const
  RibbonIconsToSkinFormIcons: array[TdxBorderDrawIcon] of TdxSkinFormIcon =
    (sfiMinimize, sfiMaximize, sfiRestore, sfiClose, sfiHelp);
  RibbonIconStateToSkinElementState: array[TdxBorderIconState] of TdxSkinElementState =
    (esNormal, esHot, esPressed, esActive, esHot);                  
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.FormIcons[True, RibbonIconsToSkinFormIcons[AIcon]]
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawFormBorderIcon(DC, R, AIcon, AState)
  else
    AElement.Draw(DC, cxRectInflate(R, -1, -1), 0, RibbonIconStateToSkinElementState[AState]);
end;

procedure TdxSkinRibbonPainter.DrawFormCaption(
  DC: HDC; const R: TRect; const AData: TdxRibbonFormData);
begin
  if FormCaptionElement = nil then
    inherited DrawFormCaption(DC, R, AData)
  else
    SkinsRibbonCacheManager.FormCaptionCache.DrawEx(
      DC, FormCaptionElement, R, esNormal, Byte(not AData.Active));
end;

procedure TdxSkinRibbonPainter.DrawFormStatusBarPart(
  DC: HDC; const R: TRect; AIsLeft, AIsActive, AIsRaised, AIsRectangular: Boolean);
var
  AHandled: Boolean;
begin
  if AIsRectangular then
    AHandled := InternalDrawStatusBarRectangularPart(DC, R, AIsRaised, AIsActive, AIsLeft)
  else
    AHandled := InternalDrawStatusBarPart(DC, R, AIsRaised, AIsActive, AIsLeft);

  if not AHandled then
    inherited DrawFormStatusBarPart(DC, R, AIsLeft, AIsActive, AIsRaised, AIsRectangular);
end;

procedure TdxSkinRibbonPainter.DrawLargeButton(DC: HDC; const R: TRect; AState: Integer);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonLargeButton
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawLargeButton(DC, R, AState)
  else
    AElement.Draw(DC, R, 0, SkinElementCheckState(AElement, AState));
end;

procedure TdxSkinRibbonPainter.DrawLargeButtonDropButton(DC: HDC; const R: TRect; AState: Integer);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  AElement := nil;
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonLargeSplitButtonBottom;

  if AElement = nil then
    inherited DrawLargeButton(DC, R, AState)
  else
    AElement.Draw(DC, R, 0, SkinElementCheckState(AElement, AState));
end;

procedure TdxSkinRibbonPainter.DrawLargeButtonGlyphBackground(DC: HDC;
  const R: TRect; AState: Integer);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  AElement := nil;
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonLargeSplitButtonTop;

  if AElement = nil then
    inherited DrawLargeButton(DC, R, AState)
  else
    AElement.Draw(DC, R, 0, SkinElementCheckState(AElement, AState));
end;

procedure TdxSkinRibbonPainter.DrawLaunchButtonBackground(DC: HDC; const R: TRect;
  AState: Integer);
const
  StateMap: array[0..8] of TdxSkinElementState = (esNormal, esNormal, esHot,
    esHot, esPressed, esNormal, esNormal, esNormal, esNormal);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
  ARect: TRect;
begin
  AElement := nil;
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonTabPanelGroupButton;

  if AElement = nil then
    inherited DrawLaunchButtonBackground(DC, R, AState)
  else
  begin
    ARect := R;
    OffsetRect(ARect, 0, 1);
    InflateRect(ARect, -1, -1);
    AElement.Draw(DC, ARect, 0, StateMap[AState]);
  end;          
end;

procedure TdxSkinRibbonPainter.DrawLaunchButtonDefaultGlyph(DC: HDC; const R: TRect;
  AState: Integer);
begin
  if not IsSkinAvailable then
    inherited DrawLaunchButtonDefaultGlyph(DC, R, AState);
end;

procedure TdxSkinRibbonPainter.DrawHelpButton(DC: HDC; const R: TRect;
  AState: TdxBorderIconState);
const
  AStateMap: array [TdxBorderIconState] of Integer =
    (DXBAR_NORMAL, DXBAR_HOT, DXBAR_PRESSED, DXBAR_NORMAL, DXBAR_NORMAL);
begin
  if IsSkinAvailable then
    DrawSmallButton(DC, R, AStateMap[AState])
  else         
    inherited DrawHelpButton(DC, R, AState);  
end;

procedure TdxSkinRibbonPainter.DrawGroupScrollButton(DC: HDC; const R: TRect;
  ALeft: Boolean; AState: Integer);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonGroupScroll[ALeft]
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawGroupScrollButton(DC, R, ALeft, AState)
  else
    AElement.Draw(DC, R, 0, SkinElementStateByRibbonState(AState));
end;

procedure TdxSkinRibbonPainter.DrawItemSeparator(
  DC: HDC; const R: TRect; AHorizontal: Boolean);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonTabGroupItemsSeparator
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawItemSeparator(DC, R, AHorizontal)
  else
    AElement.Draw(DC, cxRectCenter(R, AElement.MinSize.Size.cx, cxRectHeight(R)));
end;

procedure TdxSkinRibbonPainter.DrawKeyTip(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonKeyTip
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawKeyTip(DC, R)
  else
    AElement.Draw(DC, R);
end;

procedure TdxSkinRibbonPainter.DrawMarkArrow(DC: HDC; const R: TRect; AState: Integer);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonQuickToolbarGlyph
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawMarkArrow(DC, R, AState)
  else
    AElement.Draw(DC, R);
end;

procedure TdxSkinRibbonPainter.DrawMDIButton(DC: HDC; const R: TRect;
  AButton: TdxBarMDIButton; AState: TdxBorderIconState);
const
  RibbonIconsToSkinFormIcons: array[TdxBarMDIButton] of TdxSkinFormIcon =
    (sfiMinimize, sfiRestore, sfiClose);
  RibbonIconStateToSkinElementState: array[TdxBorderIconState] of TdxSkinElementState =
    (esNormal, esHot, esPressed, esActive, esHot);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
  ARect: TRect;
begin
  AElement := nil;
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.FormIcons[True, RibbonIconsToSkinFormIcons[AButton]];
  if AElement = nil then
    inherited DrawMDIButton(DC, R, AButton, AState)
  else
  begin
    ARect := R;
    InflateRect(ARect, -1, -1);
    AElement.Draw(DC, ARect, 0, RibbonIconStateToSkinElementState[AState]);
  end;
end;

procedure TdxSkinRibbonPainter.DrawMDIButtonGlyph(DC: HDC; const R: TRect;
  AButton: TdxBarMDIButton; AState: TdxBorderIconState);
begin
  if not IsSkinAvailable then
    inherited DrawMDIButtonGlyph(DC, R, AButton, AState);
end;

procedure TdxSkinRibbonPainter.DrawMenuCheck(DC: HDC; const R: TRect;
  AState: Integer);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  AElement := nil;
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.PopupMenuCheck;

  if AElement = nil then
    inherited DrawMenuCheck(DC, R, AState)
  else
    AElement.Draw(DC, R, 1);
end;

procedure TdxSkinRibbonPainter.DrawMenuCheckMark(DC: HDC; const R: TRect;
  AState: Integer);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  AElement := nil;
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.PopupMenuCheck;

  if AElement = nil then
    inherited DrawMenuCheckMark(DC, R, AState)
  else
    AElement.Draw(DC, R);
end;

procedure TdxSkinRibbonPainter.DrawMenuContent(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.PopupMenu
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawMenuContent(DC, R)
  else
    FillRectByColor(DC, R, AElement.Color);
end;

procedure TdxSkinRibbonPainter.DrawMenuExtraSeparator(
  DC: HDC; const R: TRect; AHorizontal: Boolean);
var
  AColor: TdxSkinColor;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
  R1: TRect;
begin
  if GetSkinData(ASkinInfo) then
    AColor := ASkinInfo.RibbonExtraPaneHeaderSeparator
  else
    AColor := nil;

  if (AColor = nil) or (AColor.Value = clDefault) then
    inherited DrawMenuExtraSeparator(DC, R, AHorizontal)
  else
  begin
    if AHorizontal then
      R1 := cxRectCenter(R, cxRectWidth(R), 1)
    else
      R1 := cxRectCenter(R, 1, cxRectHeight(R));
    FillRectByColor(DC, R1, AColor.Value);
  end;
end;

procedure TdxSkinRibbonPainter.DrawMenuGlyph(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
  R1: TRect;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.PopupMenuSideStrip
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawMenuGlyph(DC, R)
  else
  begin
    R1 := R;
    Inc(R1.Right, Max(2, AElement.Image.Margins.Right));
    DrawClippedElement(DC, R, R1, AElement, esNormal, True);
  end;
end;

procedure TdxSkinRibbonPainter.DrawMenuScrollArea(DC: HDC; const R: TRect;
  AState: Integer);
begin
  if not IsSkinAvailable then
    inherited DrawMenuScrollArea(DC, R, AState)
end;

procedure TdxSkinRibbonPainter.DrawMenuSeparatorHorz(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.PopupMenuSeparator
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawMenuSeparatorHorz(DC, R)
  else
  begin
    if AElement.IsAlphaUsed then
      DrawMenuContent(DC, R);
    AElement.Draw(DC, R);
  end;
end;

procedure TdxSkinRibbonPainter.DrawMenuSeparatorVert(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
  R1: TRect;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.PopupMenuSideStrip
  else
    AElement := nil;
    
  if AElement = nil then
    inherited DrawMenuGlyph(DC, R)
  else
  begin
    R1 := R;
    R1.Left := R.Right - Max(2, AElement.Size.cx);
    DrawClippedElement(DC, R, R1, AElement, esNormal, True);
  end;
end;

procedure TdxSkinRibbonPainter.DrawMenuMark(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.PopupMenuExpandButton
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawMenuMark(DC, R)
  else
    AElement.Draw(DC, R);
end;

procedure TdxSkinRibbonPainter.DrawRibbonClientTopArea(DC: HDC; const R: TRect);
var
  ARect: TRect;
begin
  if FormCaptionElement = nil then
    inherited DrawRibbonClientTopArea(DC, R)
  else
  begin
    ARect := R;
    with FormCaptionElement.Image.Margins.Rect do
      ARect := Rect(R.Left - Left, R.Top - 1, R.Right + Right, R.Bottom);
    DrawClippedElement(DC, R, ARect, FormCaptionElement, esNormal, True);
  end;
end;

procedure TdxSkinRibbonPainter.DrawScreenTip(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.ScreenTipWindow
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawScreenTip(DC, R)
  else
    AElement.Draw(DC, R);
end;

procedure TdxSkinRibbonPainter.DrawSeparatorBackground(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.ItemSeparator
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawSeparatorBackground(DC, R)
  else
    AElement.Draw(DC, R);
end;

procedure TdxSkinRibbonPainter.DrawSmallButton(DC: HDC; const R: TRect; AState: Integer);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  AElement := nil;
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonSmallButton;

  if AElement = nil then
    inherited DrawSmallButton(DC, R, AState)
  else
  begin
    SkinsRibbonCacheManager.SmallButtonsCache.DrawEx(
      DC, AElement, R, SkinElementCheckState(AElement, AState));
  end;
end;

procedure TdxSkinRibbonPainter.DrawSmallButtonDropButton(DC: HDC; const R: TRect; AState: Integer);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonSplitButtonRight
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawSmallButtonDropButton(DC, R, AState)
  else
    AElement.Draw(DC, R, 0, SkinElementCheckState(AElement, AState));
end;

procedure TdxSkinRibbonPainter.DrawSmallButtonGlyphBackground(
  DC: HDC; const R: TRect; AState: Integer);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonSplitButtonLeft
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawSmallButtonDropButton(DC, R, AState)
  else
    AElement.Draw(DC, R, 0, SkinElementCheckState(AElement, AState));
end;

procedure TdxSkinRibbonPainter.DrawStatusBar(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
  ALeftIndent, ARightIndent: Integer;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
  R1: TRect;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonStatusBarBackground
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawStatusBar(DC, R)
  else
  begin
    GetElementContentIndents(AElement, False, ALeftIndent, ARightIndent);
    Inc(ALeftIndent, GetWindowBordersWidth(True).Left);
    Inc(ARightIndent, GetWindowBordersWidth(True).Right);
    R1 := cxRectInflate(R, ALeftIndent, 0, ARightIndent, AElement.ContentOffset.Bottom);
    DrawClippedElement(DC, R, R1, AElement, esNormal, True);
  end;
end;

procedure TdxSkinRibbonPainter.DrawStatusBarGripBackground(DC: HDC; const R: TRect);

  procedure DrawContent(ASizeGrip, ABackground: TdxSkinElement);
  begin
    if Assigned(ASizeGrip) then
      ASizeGrip.Draw(DC, R);
  end;

var
  AElement: TdxSkinElement;
  ALeftIndent, ARightIndent: Integer;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
  R1: TRect;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonStatusBarBackground
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawStatusBarGripBackground(DC, R)
  else
  begin
    GetElementContentIndents(AElement, False, ALeftIndent, ARightIndent);
    R1 := cxRectInflate(R, ALeftIndent, 0, ARightIndent, AElement.ContentOffset.Bottom);
    DrawClippedElement(DC, R, R1, AElement, esNormal, True, 1);
    DrawContent(ASkinInfo.SizeGrip, AElement);
    ExcludeClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
  end;
end;

procedure TdxSkinRibbonPainter.DrawStatusBarPanel(
  DC: HDC; const Bounds, R: TRect; AIsLowered: Boolean);
var
  ABitmap: TcxBitmap;
  AElement: TdxSkinElement;
  ARect, ABorders: TRect;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonStatusBarBackground
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawStatusBarPanel(DC, Bounds, R, AIsLowered)
  else
  begin
    ABitmap := TcxBitmap.CreateSize(Bounds, pf32bit);
    try
      ARect := ABitmap.ClientRect;
      ABorders := GetWindowBordersWidth(True);
      ABitmap.cxCanvas.FillRect(ARect, GetPartColor(rfspRibbonForm));
      Dec(ARect.Left, Bounds.Left + ABorders.Left);
      ARect.Right := Max(ARect.Right, ARect.Left + AElement.Image.Size.cx) + ABorders.Right;
      Inc(ARect.Bottom, ABorders.Bottom);
      AElement.Draw(ABitmap.Canvas.Handle, ARect, Ord(not AIsLowered));
      cxBitBlt(DC, ABitmap.Canvas.Handle, R, cxNullPoint, SRCCOPY);
    finally
      ABitmap.Free;
    end;
  end;
end;

procedure TdxSkinRibbonPainter.DrawStatusBarPanelSeparator(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonStatusBarSeparator
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawStatusBarPanelSeparator(DC, R)
  else
    AElement.Draw(DC, R);
end;

procedure TdxSkinRibbonPainter.DrawStatusBarToolbarSeparator(DC: HDC; const R: TRect);
var
  R1: TRect;
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonStatusBarSeparator
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawStatusBarToolbarSeparator(DC, R)
  else
  begin
    R1 := R;
    Inc(R1.Bottom, GetWindowBordersWidth(True).Bottom);
    AElement.Draw(DC, R1);
  end;
end;

procedure TdxSkinRibbonPainter.DrawTab(
  DC: HDC; const R: TRect; AState: TdxRibbonTabState);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonTab
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawTab(DC, R, AState)
  else
    AElement.Draw(DC, CorrectTabHeaderRect(R), 0, RibbonTabStatesMap[AState]);
end;

procedure TdxSkinRibbonPainter.DrawTabAreaBackground(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonHeaderBackground
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawRibbonBackground(DC, R)
  else
  begin
    if AElement.IsAlphaUsed then
      AElement.Draw(DC, R, 1);
    AElement.Draw(DC, R);
  end;
end;

procedure TdxSkinRibbonPainter.DrawTabGroupBackground(DC: HDC; const R: TRect;
  AState: Integer);
const
  AStateMap: array[Boolean] of TdxSkinElementState = (esNormal, esHot);  
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  AElement := nil;
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonTabGroup;

  if AElement = nil then
    inherited DrawTabGroupBackground(DC, R, AState)
  else
    SkinsRibbonCacheManager.TabGroupBackground.DrawElement(DC, AElement,
      R, AStateMap[AState = DXBAR_HOT]);
end;

procedure TdxSkinRibbonPainter.DrawTabGroupHeaderBackground(
  DC: HDC; const R: TRect; AState: Integer);
const
  AStateMap: array[Boolean] of TdxSkinElementState = (esNormal, esHot);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonTabGroupHeader
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawTabGroupHeaderBackground(DC, R, AState)
  else
    AElement.Draw(DC, R, 0, AStateMap[AState = DXBAR_HOT]);
end;

procedure TdxSkinRibbonPainter.DrawTabGroupsArea(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  AElement := nil;
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonTabPanel;
  if AElement = nil then
    inherited DrawTabGroupsArea(DC, R)
  else
    SkinsRibbonCacheManager.TabGroupsAreaCache.DrawEx(DC, AElement, R);
end;

procedure TdxSkinRibbonPainter.DrawTabScrollButton(DC: HDC; const R: TRect;
  ALeft: Boolean; AState: Integer);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonSmallButton
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawTabScrollButton(DC, R, ALeft, AState)
  else
    AElement.Draw(DC, R, 0, SkinElementStateByRibbonState(AState));
end;

procedure TdxSkinRibbonPainter.DrawTabSeparator(DC: HDC; const R: TRect; Alpha: Byte);
var
  ABitmap: TcxBitmap;
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonTabSeparatorLine
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawTabSeparator(DC, R, Alpha)
  else
  begin
    ABitmap := TcxBitmap.CreateSize(R, pf32bit);
    try
      cxBitBlt(ABitmap.Canvas.Handle, DC, ABitmap.ClientRect, R.TopLeft, SRCCOPY);
      AElement.Draw(ABitmap.Canvas.Handle, ABitmap.ClientRect);
      cxAlphaBlend(DC, ABitmap, R, ABitmap.ClientRect, False, Alpha);
    finally
      ABitmap.Free;
    end;
  end;
end;

procedure TdxSkinRibbonPainter.DrawRibbonBottomBorder(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
  ARect: TRect;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonTabPanel
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawRibbonBottomBorder(DC, R)
  else
  begin
    ARect := R;
    with AElement.Image.Margins do
    begin
      Dec(ARect.Left, Left);
      Inc(ARect.Right, Right);
    end;
    ARect.Bottom := ARect.Top + AElement.Size.cy;
    DrawClippedElement(DC, R, ARect, AElement);
  end;
end;

procedure TdxSkinRibbonPainter.DrawQuickAccessToolbar(DC: HDC; const R: TRect;
  ABellow, ANonClientDraw, AHasApplicationButton, AIsActive, ADontUseAero: Boolean);

  function IsAeroBackgroundUsed: Boolean;
  begin
    Result := ANonClientDraw and IsCompositionEnabled and not (ADontUseAero or ABellow);
  end;

  function NeedDrawCustomQuickAccessToolBar(AElement: TdxSkinElement): Boolean;
  begin
    Result := (AElement = nil) or IsAeroBackgroundUsed and not AElement.Image.Empty;
  end;

  function ValidateQATRect(const R: TRect; AParent: TdxSkinElement): TRect;
  var
    ARightIndent: Integer;
  begin
    Result := R;
    if not ABellow then
    begin
      if AParent = nil then
        ARightIndent := 0
      else
        with AParent.ContentOffset.Rect do
        begin
          ARightIndent := GetQuickAccessToolbarRightIndent(AHasApplicationButton);
          Result := cxRectInflate(R, 0, -Top, 0, -Bottom);
        end;

      if GetCustomizeButtonOutsizeQAT(AHasApplicationButton) then
      begin
        Dec(ARightIndent, QATRightDefaultOffset);
        Dec(ARightIndent, GetQuickAccessToolbarMarkButtonOffset(AHasApplicationButton, ABellow));
      end;
      Inc(Result.Right, ARightIndent);
    end;
  end;

var
  AElement: TdxSkinElement;
  ARect: TRect;
begin
  AElement := GetQATBackgroundElement(ABellow, AHasApplicationButton);
  if NeedDrawCustomQuickAccessToolBar(AElement) then
    inherited DrawQuickAccessToolbar(DC, R, ABellow, ANonClientDraw,
      AHasApplicationButton, AIsActive, ADontUseAero)
  else
    if not IsAeroBackgroundUsed then
    begin
      ARect := ValidateQATRect(R, FormCaptionElement);
      if ABellow or (cxRectWidth(ARect) >= cxRectHeight(ARect)) then
        AElement.Draw(DC, ARect);
    end;
end;

procedure TdxSkinRibbonPainter.DrawQuickAccessToolbarDefaultGlyph(DC: HDC;
  const R: TRect);
var
  AElement: TdxSkinElement;  
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonQuickToolbarButtonGlyph
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawQuickAccessToolbarDefaultGlyph(DC, R)
  else  
    AElement.Draw(DC, R);
end;

procedure TdxSkinRibbonPainter.DrawQuickAccessToolbarGroupButton(DC: HDC;
  const R: TRect; ABellow: Boolean; ANonClientDraw: Boolean; AIsActive: Boolean;
  AState: Integer);
var
  ABackground: TdxSkinElement;
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
  begin
    ABackground := ASkinInfo.RibbonButtonGroup;
    AElement := ASkinInfo.RibbonButtonGroupButton;
  end
  else
  begin
    AElement := nil;
    ABackground := nil;
  end;

  if (AElement = nil) or (ABackground = nil) then
    inherited DrawQuickAccessToolbarGroupButton(DC, R, ABellow, ANonClientDraw,
      AIsActive, AState)
  else
  begin
    ABackground.Draw(DC, R);
    AElement.Draw(DC, cxRectContent(R, ABackground.ContentOffset.Rect), 0,
      SkinElementStateByRibbonState(AState));
  end;
end;

procedure TdxSkinRibbonPainter.DrawQuickAccessToolbarPopup(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonQuickToolbarDropDown
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawQuickAccessToolbarPopup(DC, R)
  else
    AElement.Draw(DC, R);
end;

procedure TdxSkinRibbonPainter.LookAndFeelChanged(
  Sender: TcxLookAndFeel; AChangedValues: TcxLookAndFeelValues);
begin
  SkinsRibbonCacheManager.Flush;
end;

function TdxSkinRibbonPainter.GetApplicationMenuGlyphSize: TSize;
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonApplicationButton
  else
    AElement := nil;

  if AElement = nil then
    Result := inherited GetApplicationMenuGlyphSize
  else
    Result := AElement.Size;
end;

function TdxSkinRibbonPainter.GetCaptionFontSize(ACurrentFontSize: Integer): Integer;
var
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  Result := inherited GetCaptionFontSize(ACurrentFontSize);
  if GetSkinData(ASkinInfo) and (ASkinInfo.RibbonCaptionFontDelta <> nil) then
    Inc(Result, ASkinInfo.RibbonCaptionFontDelta.Value);
end;

procedure TdxSkinRibbonPainter.GetElementContentIndents(
  AElement: TdxSkinElement; AConsideMargins: Boolean; out ALeftIndent, ARightIndent: Integer);
begin
  ALeftIndent := AElement.ContentOffset.Left;
  ARightIndent := AElement.ContentOffset.Right;
  if AConsideMargins then
  begin
    ALeftIndent := Max(AElement.Image.Margins.Left, ALeftIndent);
    ARightIndent := Max(AElement.Image.Margins.Right, ARightIndent);
  end;
end;

function TdxSkinRibbonPainter.GetMenuSeparatorSize: Integer;
var
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) and Assigned(ASkinInfo.PopupMenuSeparator) then
    Result := ASkinInfo.PopupMenuSeparator.Size.cy
  else
    Result := inherited GetMenuSeparatorSize;
end;

function TdxSkinRibbonPainter.GetPartColor(APart: Integer; AState: Integer = 0): TColor;

  function GetElementTextColor(AElement: TdxSkinElement): TColor;
  begin
    if AElement = nil then
      Result := clDefault
    else
      Result := AElement.TextColor;
  end;

  function GetPropertyColor(AColor: TdxSkinColor): TColor;
  begin
    if AColor = nil then
      Result := clDefault
    else
      Result := AColor.Value;
  end;

var
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  Result := clDefault;
  if GetSkinData(ASkinInfo) then
  begin
    case APart of
      DXBAR_KEYTIP_TEXTCOLOR:
        Result := GetElementTextColor(ASkinInfo.RibbonKeyTip);
      DXBAR_SCREENTIP_TITLE:
        Result := GetPropertyColor(ASkinInfo.ScreenTipTitleItem);
      DXBAR_SCREENTIP_DESCRIPTION:
        Result := GetPropertyColor(ASkinInfo.ScreenTipItem);
      DXBAR_MENUEXTRAPANE:
        Result := GetPropertyColor(ASkinInfo.RibbonExtraPaneColor);
      DXBAR_EDIT_BACKGROUND:
        Result := GetPropertyColor(ASkinInfo.RibbonEditorBackground);
      DXBAR_SEPARATOR_BACKGROUND:
        Result := GetPropertyColor(ASkinInfo.ContentColor);
      DXBAR_EDIT_TEXTCOLOR:
        Result := Painter.DefaultEditorTextColor(AState = DXBAR_DISABLED);
      DXBAR_ITEMTEXT:
        case AState of
          DXBAR_DISABLED, DXBAR_ACTIVEDISABLED:
            Result := ASkinInfo.RibbonButtonText[True]
          else
            Result := ASkinInfo.RibbonButtonText[False];
        end;

      DXBAR_MENUITEMTEXT:
        if AState = DXBAR_DISABLED then
          Result := GetPropertyColor(ASkinInfo.BarDisabledTextColor)
        else
          Result := GetElementTextColor(ASkinInfo.PopupMenu);

      DXBAR_EDIT_BORDER:
        if AState = DXBAR_ACTIVE then
          Result := GetPropertyColor(ASkinInfo.ContainerHighlightBorderColor)
        else
          Result := GetPropertyColor(ASkinInfo.ContainerBorderColor);

      DXBAR_SCREENTIP_FOOTERLINE,
      DXBAR_APPLICATIONMENUCONTENTINNERBORDER:
        Result := GetPropertyColor(ASkinInfo.ContainerBorderColor);

      DXBAR_APPLICATIONMENUCONTENTOUTERBORDER,
      DXBAR_APPLICATIONMENUCONTENTSIDES, rfspRibbonForm:
        if ASkinInfo.FormContent <> nil then
          Result := ASkinInfo.FormContent.Color;

      rspFormCaptionText:
        Result := ASkinInfo.RibbonCaptionText[AState = DXBAR_NORMAL];

      rspDocumentNameText:
        Result := ASkinInfo.RibbonDocumentNameTextColor[AState = DXBAR_NORMAL];

      rspContextTabHeaderText:
        begin
          if AState = DXBAR_HOT then
            Result := ASkinInfo.RibbonContextualTabHeaderTextHot
          else
            Result := ASkinInfo.RibbonContextualTabHeaderText[AState = DXBAR_ACTIVE];

          if (Result = clNone) or (Result = clDefault) then
            Result := GetPartColor(rspTabHeaderText, AState);
        end;

      rspTabHeaderText:
        begin
          case AState of
            DXBAR_HOT:
              Result := ASkinInfo.RibbonTabTextHot;
            DXBAR_ACTIVE:
              Result := ASkinInfo.RibbonTabText[True];
            else
              Result := clDefault;
          end;
          if Result = clDefault then
            Result := ASkinInfo.RibbonTabText[False];
        end;

     rspTabGroupText:
       Result := GetElementTextColor(ASkinInfo.RibbonSmallButton);

      rspTabGroupHeaderText:
        Result := GetElementTextColor(ASkinInfo.RibbonTabGroupHeader);

      rspContextText:
        Result := GetElementTextColor(ASkinInfo.RibbonContextualTabLabel);

      rspContextTextOnGlass:
        Result := GetElementTextColor(ASkinInfo.RibbonContextualTabLabelOnGlass);

      rspStatusBarText:
        case AState of
          DXBAR_NORMAL:
            Result := ASkinInfo.RibbonStatusBarText;
          DXBAR_HOT:
            Result := ASkinInfo.RibbonStatusBarTextHot;
          DXBAR_DISABLED:
            Result := ASkinInfo.RibbonStatusBarTextDisabled;
        end;        

      DXBAR_GALLERYGROUPHEADERTEXT, DXBAR_GALLERYFILTERBANDTEXT:
        Result := GetElementTextColor(ASkinInfo.RibbonGalleryGroupCaption);
    end;
  end;
  if Result = clDefault then
    Result := inherited GetPartColor(APart, AState);
end;

function TdxSkinRibbonPainter.GetPartContentOffsets(APart: Integer): TRect;
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  AElement := nil;
  if GetSkinData(ASkinInfo) then
  begin
    case APart of
      DXBAR_TOOLBAR:
        AElement := ASkinInfo.RibbonTabGroup;
      DXBAR_GALLERYFILTERBAND:
        AElement := ASkinInfo.RibbonGallerySizingPanel;
      DXBAR_RIBBONTABGROUP:
        AElement := ASkinInfo.RibbonTabPanel;
      DXBAR_RIBBONCONTEXTTABGROUP:
        AElement := ASkinInfo.RibbonContextualTabPanel;
      DXBAR_QUICKACCESSTOOLBAR:
        AElement := ASkinInfo.RibbonQuickToolbarBelow;
      DXBAR_APPLICATIONBUTTONICONOFFSET:
        AElement := ASkinInfo.RibbonApplicationButton;
    end;
  end;

  if AElement = nil then
    Result := inherited GetPartContentOffsets(APart)
  else
    Result := AElement.ContentOffset.Rect;
end;

function TdxSkinRibbonPainter.GetPartOffset(APart: Integer): Integer;

  function GetValue(AProperty: TdxSkinIntegerProperty): Integer;
  begin
    if AProperty = nil then
      Result := 1
    else
      Result := AProperty.Value;
  end;

var
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
  begin
    case APart of
      DXBAR_TOOLBAR:
        Result := GetValue(ASkinInfo.RibbonSpaceBetweenTabGroups);
      DXBAR_TABSGROUPSOVERLAPHEIGHT:
        Result := GetValue(ASkinInfo.RibbonTabHeaderDownGrowIndent);
      else
        Result := inherited GetPartOffset(APart);
    end;
  end
  else
    Result := inherited GetPartOffset(APart);
end;

function TdxSkinRibbonPainter.GetQuickAccessToolbarLeftIndent(
  AHasApplicationButton: Boolean; AUseAeroGlass: Boolean): Integer;
var
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if not AUseAeroGlass and AHasApplicationButton and GetSkinData(ASkinInfo) then
  begin
    Result := -QATLeftDefaultOffset;
    if ASkinInfo.RibbonQuickToolbar[True] <> nil then
      Inc(Result, ASkinInfo.RibbonQuickToolbar[True].ContentOffset.Left);
    Inc(Result, GetQATLeftOffset);
  end
  else
    Result := inherited GetQuickAccessToolbarLeftIndent(AHasApplicationButton, AUseAeroGlass);
end;

function TdxSkinRibbonPainter.GetQuickAccessToolbarMarkButtonOffset(
  AHasApplicationButton: Boolean; ABelow: Boolean): Integer;
var
  AOffsetProperty: TdxSkinIntegerProperty;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AOffsetProperty := ASkinInfo.RibbonQATIndentBeforeCustomizeButton[AHasApplicationButton]
  else
    AOffsetProperty := nil;

  if ABelow or (AOffsetProperty = nil) then
    Result := inherited GetQuickAccessToolbarMarkButtonOffset(AHasApplicationButton, ABelow)
  else
    Result := AOffsetProperty.Value;
end;

function TdxSkinRibbonPainter.GetQuickAccessToolbarOverrideWidth(
  AHasApplicationButton: Boolean; AUseAeroGlass: Boolean): Integer;
var
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if not AUseAeroGlass and AHasApplicationButton and GetSkinData(ASkinInfo) then
  begin
    with ASkinInfo do
      Result := GetQuickAccessToolbarLeftIndent(True, AUseAeroGlass) + QATLeftDefaultOffset;
    Dec(Result, GetQATLeftOffset);
  end
  else
    Result := inherited GetQuickAccessToolbarOverrideWidth(AHasApplicationButton,
      AUseAeroGlass);
end;

function TdxSkinRibbonPainter.GetQuickAccessToolbarRightIndent(
  AHasApplicationButton: Boolean): Integer;
var
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) and (ASkinInfo.RibbonQuickToolbar[AHasApplicationButton] <> nil) then
    Result := ASkinInfo.RibbonQuickToolbar[AHasApplicationButton].ContentOffset.Right
  else
    Result := inherited GetQuickAccessToolbarRightIndent(AHasApplicationButton);
end;

function TdxSkinRibbonPainter.GetSkinName: string;
begin
  Result := FLookAndFeel.SkinName;
end;

function TdxSkinRibbonPainter.GetStatusBarSeparatorSize: Integer;
var
  AElement: TdxSkinElement;
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
    AElement := ASkinInfo.RibbonStatusBarSeparator
  else
    AElement := nil;

  if AElement = nil then
    Result := inherited GetStatusBarSeparatorSize
  else
  begin
    Result := AElement.MinSize.Width;
    if Result = 0 then
      Result := AElement.Image.Size.cx;
    if Result = 0 then
      Result := inherited GetStatusBarSeparatorSize;
  end;
end;

function TdxSkinRibbonPainter.GetWindowBordersWidth(AHasStatusBar: Boolean): TRect;

  function GetBorderSize(ASide: TcxBorder; ASkinInfo: TdxSkinLookAndFeelPainterInfo): TSize;
  var
    AElement: TdxSkinElement;
  begin
    AElement := GetBorderSkinElement(ASide, False, ASkinInfo);
    if AElement = nil then
      Result := cxNullSize
    else
      Result := AElement.Size;
  end;

  function GetBottomBorderSize(ASkinInfo: TdxSkinLookAndFeelPainterInfo): Integer;
  begin
    if not AHasStatusBar then
      Result := GetBorderSize(bBottom, ASkinInfo).cy
    else
      if ASkinInfo.RibbonStatusBarBackground = nil then
        Result := 1
      else
        Result := ASkinInfo.RibbonStatusBarBackground.ContentOffset.Bottom; 
  end;

var
  ASkinInfo: TdxSkinLookAndFeelPainterInfo;
begin
  if GetSkinData(ASkinInfo) then
  begin
    Result := cxNullRect;
    Result.Left := GetBorderSize(bLeft, ASkinInfo).cx;
    Result.Right := GetBorderSize(bRight, ASkinInfo).cx;
    Result.Bottom := GetBottomBorderSize(ASkinInfo);
  end
  else
    Result := inherited GetWindowBordersWidth(AHasStatusBar);
end;

function TdxSkinRibbonPainter.NeedDrawGroupScrollArrow: Boolean;
begin
  Result := False;
end;

{ TdxSkinsRibbonCacheManager }

constructor TdxSkinsRibbonCacheManager.Create;
var
  ASide: TcxBorder;
begin
  FSmallButtonsCache := TdxSkinElementCache.Create;
  FFormCaptionCache := TdxSkinElementCache.Create;
  FTabGroupBackground := TdxSkinElementCacheList.Create;
  FTabGroupsAreaCache := TdxSkinElementCache.Create;
  for ASide := Low(TcxBorder) to High(TcxBorder) do
    FFormBordersCache[ASide] := TdxSkinElementCache.Create;
end;

destructor TdxSkinsRibbonCacheManager.Destroy;
var
  ASide: TcxBorder;
begin
  FreeAndNil(FFormCaptionCache);
  FreeAndNil(FTabGroupBackground);
  FreeAndNil(FTabGroupsAreaCache);
  FreeAndNil(FSmallButtonsCache);
  for ASide := Low(TcxBorder) to High(TcxBorder) do
    FreeAndNil(FFormBordersCache[ASide]);
end;

procedure TdxSkinsRibbonCacheManager.Flush;
var
  ASide: TcxBorder;
begin
  FormCaptionCache.Flush;
  SmallButtonsCache.Flush;
  TabGroupBackground.Flush;
  TabGroupsAreaCache.Flush;
  for ASide := Low(TcxBorder) to High(TcxBorder) do
    FormBordersCache[ASide].Flush;
end;

function TdxSkinsRibbonCacheManager.GetFormBordersCache(
  ASide: TcxBorder): TdxSkinElementCache;
begin
  Result := FFormBordersCache[ASide];
end;

{ TdxSkinsRibbonPainterManager }

constructor TdxSkinsRibbonPainterManager.Create;
begin
  GetExtendedStylePainters.AddListener(Self);
  InitializePaintersList;
end;

destructor TdxSkinsRibbonPainterManager.Destroy;
begin
  GetExtendedStylePainters.RemoveListener(Self);
  FreePaintersList;  
  inherited Destroy;
end;

procedure TdxSkinsRibbonPainterManager.FreePaintersList;
var
  I: Integer;
  ASkin: TdxCustomBarSkin;
begin
  for I := SkinManager.SkinCount - 1 downto 0 do
  begin
    ASkin := SkinManager.Skins[I];
    if ASkin is TdxSkinRibbonPainter then
      SkinManager.RemoveSkin(ASkin);
  end;    
end;

procedure TdxSkinsRibbonPainterManager.InitializePaintersList;
var
  I: Integer;
  AExtendedPainters: TcxExtendedStylePainters;
begin
  AExtendedPainters := GetExtendedStylePainters;
  if AExtendedPainters <> nil then
    for I := 0 to AExtendedPainters.Count - 1 do
      if SkinManager.SkinByName(AExtendedPainters.Names[I]) = nil then
        SkinManager.AddSkin(TdxSkinRibbonPainter.Create(AExtendedPainters.Names[I]));
end;

procedure TdxSkinsRibbonPainterManager.PainterChanged(
  APainter: TcxCustomLookAndFeelPainterClass);
var
  AName: string;
  ASkin: TdxCustomBarSkin;
  I: Integer;
begin
  if GetExtendedStylePainters.GetNameByPainter(APainter, AName) then
  begin
    if SkinManager.SkinByName(AName) = nil then
      SkinManager.AddSkin(TdxSkinRibbonPainter.Create(AName))
  end
  else
    for I := SkinManager.SkinCount - 1 downto 0 do
    begin
      ASkin := SkinManager.Skins[I];
      if (ASkin is TdxSkinRibbonPainter) and (TdxSkinRibbonPainter(ASkin).SkinName = '') then
        SkinManager.RemoveSkin(ASkin);
    end;
end;

procedure RegisterPainterManager;
begin
  SkinsRibbonCacheManager := TdxSkinsRibbonCacheManager.Create;
  SkinsRibbonPainterManager := TdxSkinsRibbonPainterManager.Create;
end;

procedure UnregisterPainterManager;
begin
  FreeAndNil(SkinsRibbonPainterManager);
  FreeAndNil(SkinsRibbonCacheManager);
end;

initialization
  dxUnitsLoader.AddUnit(@RegisterPainterManager, @UnregisterPainterManager);

finalization
  dxUnitsLoader.RemoveUnit(@UnregisterPainterManager);

end.
