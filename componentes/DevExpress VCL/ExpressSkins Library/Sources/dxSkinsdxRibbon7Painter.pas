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

unit dxSkinsdxRibbon7Painter;

interface

uses
  Types, Windows, Classes, SysUtils, dxSkinsCore, dxSkinsLookAndFeelPainter, Graphics,
  dxRibbonSkins, dxBarSkin, cxLookAndFeels, cxLookAndFeelPainters, cxGraphics,
  cxClasses, dxBarSkinConsts, cxGeometry, dxRibbon, dxBar, Math, cxDWMApi,
  Forms, dxSkinInfo, dxGDIPlusAPI, dxGDIPlusClasses, dxOffice11;

type

  { TdxSkinRibbonPainter }

  TdxSkinRibbonPainter = class(TdxCustomRibbonSkin)
  private
    FLookAndFeel: TcxLookAndFeel;
    FSkinInfo: TdxSkinLookAndFeelPainterInfo;
    function GetIsSkinAvailable: Boolean;
    function GetPainter: TcxCustomLookAndFeelPainterClass;
    function GetPopupMenuColor: TColor;
    procedure SetSkinName(const ASkinName: string);
  protected
    function CorrectTabHeaderRect(const R: TRect): TRect;
    function GetApplicationButtonElement: TdxSkinElement; virtual;
    function GetApplicationButtonIndent(const AName: string): Integer;
    function GetBorderBounds(ASide: TcxBorder; const ABorders, ABounds: TRect): TRect;
    function GetBorderSkinElement(ASide: TcxBorder; AIsRectangular: Boolean): TdxSkinElement;
    function GetCustomizeButtonOutsizeQAT(AHasAppButton: Boolean): Boolean;
    function GetDisplayName: string; override;
    function GetElementContentIndents(AElement: TdxSkinElement;
      AConsideMargins: Boolean; out ALeftIndent, ARightIndent: Integer): Boolean;
    function GetElementMinSize(AElement: TdxSkinElement): TSize;
    function GetElementTextColor(AElement: TdxSkinElement; AState: Integer = 0): TColor;
    function GetPropertyColor(AColor: TdxSkinColor): TColor;
    function GetQATBackgroundElement(ABellow, AHasApplicationButton: Boolean): TdxSkinElement;
    function GetQATLeftOffset: Integer;
    function GetStatusBarElement(AIsLeft: Boolean; var AElement: TdxSkinElement): Boolean;

    function DoDrawEditButton(DC: HDC; const R: TRect; AState: Integer; AButtonKind: TcxEditBtnKind): Boolean;
    function DoDrawStatusBarPart(DC: HDC; const R: TRect; AIsRaised, AActive, AIsLeft: Boolean): Boolean;
    function DoDrawStatusBarRectangularPart(DC: HDC; const R: TRect; AIsRaised, AActive, AIsLeft: Boolean): Boolean;
    procedure DrawClippedElement(DC: HDC; const R: TRect; const ASource: TRect;
      AElement: TdxSkinElement; AState: TdxSkinElementState = esNormal;
      AIntersect: Boolean = False; AImageIndex: Integer = 0);
    procedure DrawColoredElement(DC: HDC; const R: TRect;
      AColor: TColor; AElement: TdxSkinElement; AState: TdxSkinElementState);
    procedure DrawFormBorder(DC: HDC; ASide: TcxBorder; ACaptionHeight: Integer;
      ABorderWidths, R: TRect; AElement: TdxSkinElement; AActive: Boolean);
    procedure DrawStatusBarFormBorder(DC: HDC; const AData: TdxRibbonFormData; const ABorders: TRect);

    procedure LoadCustomRibbonSkinBitmap(out ABitmap: Pointer); override;
    procedure LoadFormSkinBitmap(out ABitmap: Pointer); override;
    procedure LookAndFeelChanged(Sender: TcxLookAndFeel; AChangedValues: TcxLookAndFeelValues);

    property ApplicationButtonElement: TdxSkinElement read GetApplicationButtonElement;
    property LookAndFeel: TcxLookAndFeel read FLookAndFeel;
    property PopupMenuColor: TColor read GetPopupMenuColor;
    property SkinInfo: TdxSkinLookAndFeelPainterInfo read FSkinInfo;
  public
    constructor Create(const ASkinName: string); virtual;
    destructor Destroy; override;  
    //  Application
    procedure DrawApplicationButton(DC: HDC; const R: TRect; AState: TdxApplicationButtonState); override;
    procedure DrawApplicationMenuBackground(DC: HDC; const R, AContentRect: TRect); override;
    procedure DrawApplicationMenuButton(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawApplicationMenuExtraPaneButton(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawApplicationMenuExtraPanePinButtonGlyph(DC: HDC; const R: TRect; AChecked: Boolean); override;
    // BackstageView
    procedure DrawBackstageViewBackground(DC: HDC; const R: TRect); override;
    procedure DrawBackstageViewMenuBackground(DC: HDC; const R: TRect); override;
    procedure DrawBackstageViewMenuButton(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawBackstageViewTabButton(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawBackstageViewTopLine(DC: HDC; const R: TRect); override;
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
      ACaptionHeight, ACaptionAreaExtention: Integer;
      const AData: TdxRibbonFormData; AHasStatusBar: Boolean); override;
    procedure DrawFormBorderIcon(DC: HDC; const R: TRect;
      AIcon: TdxBorderDrawIcon; AState: TdxBorderIconState); override;
    procedure DrawFormCaption(DC: HDC; const R: TRect;
      const AData: TdxRibbonFormData; ATabHeadersAreaVisible: Boolean); override;
    procedure DrawFormStatusBarPart(DC: HDC; const R: TRect; AIsLeft: Boolean;
      AIsActive: Boolean; AIsRaised: Boolean; AIsRectangular: Boolean); override;
    // Contexts
    procedure DrawContextBackground(DC: HDC; const R: TRect; AColor: TColor); override;
    procedure DrawContextBackgroundGlass(DC: HDC; const R: TRect; AColor: TColor); override;
    procedure DrawContextTabBackground(DC: HDC; const R: TRect; AState: TdxRibbonTabState; AColor: TColor); override;
    procedure DrawContextTabGroupsArea(DC: HDC; const R: TRect; AIsQATAtBottom: Boolean); override;
    procedure DrawContextTabSeparator(DC: HDC; const R: TRect; ABeginGroup: Boolean); override;
    // Others
    procedure DrawArrowDown(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawGroupScrollButton(DC: HDC; const R: TRect; ALeft: Boolean; AState: Integer); override;
    procedure DrawHelpButton(DC: HDC; const R: TRect; AState: TcxButtonState); override;
    procedure DrawItemSeparator(DC: HDC; const R: TRect; AHorizontal: Boolean); override;
    procedure DrawKeyTip(DC: HDC; const R: TRect); override;
    procedure DrawMarkArrow(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawMDIButton(DC: HDC; const R: TRect; AButton: TdxBarMDIButton; AState: TcxButtonState); override;
    procedure DrawMDIButtonGlyph(DC: HDC; const R: TRect; AButton: TdxBarMDIButton; AState: TcxButtonState); override;
    procedure DrawMinimizeRibbonButtonGlyph(DC: HDC; const R: TRect;
      AState: TcxButtonState; AGlyph: TdxRibbonMinimizeButtonGlyph); override;
    procedure DrawRibbonClientTopArea(DC: HDC; const R: TRect); override;
    procedure DrawRibbonTopFrameArea(DC: HDC; const R: TRect; AUseAeroGlass: Boolean); override;
    procedure DrawRibbonTopFrameAreaSeparator(DC: HDC; const R: TRect); override;
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
    procedure DrawTabAreaBackground(DC: HDC; const R: TRect; AActive, AUseAeroGlass: Boolean); override;
    procedure DrawTabGroupBackground(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawTabGroupHeaderBackground(DC: HDC; const R: TRect; AState: Integer); override;
    procedure DrawTabGroupsArea(DC: HDC; const R: TRect; AIsQATAtBottom: Boolean); override;
    procedure DrawTabScrollButton(DC: HDC; const R: TRect; ALeft: Boolean; AState: Integer); override;
    procedure DrawTabSeparator(DC: HDC; const R: TRect; Alpha: Byte); override;
    // QuickAccess
    procedure DrawQuickAccessToolbar(DC: HDC; const R: TRect;
      ABellow, ANonClientDraw, AHasApplicationButton, AIsActive, ADontUseAero: Boolean); override;
    procedure DrawQuickAccessToolbarDefaultGlyph(DC: HDC; const R: TRect); override;
    procedure DrawQuickAccessToolbarGroupButton(DC: HDC; const R: TRect;
      ABellow: Boolean; ANonClientDraw: Boolean; AIsActive: Boolean; AState: Integer); override;
    procedure DrawQuickAccessToolbarPopup(DC: HDC; const R: TRect); override;
    //
    function GetApplicationMenuContentOffset(const ATabsBounds: TRect): TRect; override;
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
    property IsSkinAvailable: Boolean read GetIsSkinAvailable;
    property Painter: TcxCustomLookAndFeelPainterClass read GetPainter;
    property SkinName: string read GetSkinName write SetSkinName;
  end;

  { TdxSkinRibbon2010Painter }

  TdxSkinRibbon2010Painter = class(TdxSkinRibbonPainter)
  protected
    function GetApplicationButtonElement: TdxSkinElement; override;
    function GetStyle: TdxRibbonStyle; override;
  public
    function ExtendCaptionAreaOnTabs: Boolean; override;
    function GetApplicationMenuContentOffset(const ATabsBounds: TRect): TRect; override;
    function GetPartContentOffsets(APart: Integer): TRect; override;
  end;

implementation

uses
  dxSkinsStrs;

const
  QATLeftDefaultOffset = 15;
  QATRightDefaultOffset = 12;

  RibbonFormBorderStates: array[Boolean] of TdxSkinElementState =
    (esActiveDisabled, esActive);
  RibbonTabStatesMap: array[TdxRibbonTabState] of TdxSkinElementState =
    (esNormal, esHot, esActive, esFocused, esFocused);

type

  { TdxSkinsRibbonPainterManager }

  TdxSkinsRibbonPainterManager = class(TcxIUnknownObject, IcxLookAndFeelPainterListener)
  private
    procedure FreePaintersList;
    procedure InitializePaintersList;
  protected
    procedure AddSkin(const AName: string);
    procedure PainterChanged(APainter: TcxCustomLookAndFeelPainterClass);
  public
    constructor Create; virtual;
    destructor Destroy; override;
  end;

var
  FRibbonPainterManager: TdxSkinsRibbonPainterManager;

function RibbonStateToButtonState(AState: Integer): TcxButtonState;
begin
  case AState of
    DXBAR_HOT, DXBAR_HOTCHECK:
      Result := cxbsHot;
    DXBAR_DISABLED, DXBAR_ACTIVEDISABLED:
      Result := cxbsDisabled;
    DXBAR_DROPPEDDOWN, DXBAR_PRESSED:
      Result := cxbsPressed;
    else
      Result := cxbsNormal;
  end;
end;

function RibbonStateToSkinElementState(AState: Integer): TdxSkinElementState;
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
  Result := SkinElementCheckState(AElement, RibbonStateToSkinElementState(AState));
end;

{ TdxSkinRibbonPainter }

constructor TdxSkinRibbonPainter.Create(const ASkinName: string);
begin
  FLookAndFeel := TcxLookAndFeel.Create(nil);
  FLookAndFeel.OnChanged := LookAndFeelChanged;
  FLookAndFeel.NativeStyle := False;
  FLookAndFeel.SkinName := ASkinName;
  inherited Create;
end;

destructor TdxSkinRibbonPainter.Destroy;
begin
  inherited Destroy;
  FreeAndNil(FLookAndFeel);
end;

function TdxSkinRibbonPainter.CorrectTabHeaderRect(const R: TRect): TRect;
begin
  Result := cxRectInflate(R, -1, -2, -1, 0);
end;

function TdxSkinRibbonPainter.GetApplicationButtonElement: TdxSkinElement;
begin
  if SkinInfo = nil then
    Result := nil
  else
    Result := SkinInfo.RibbonApplicationButton;
end;

function TdxSkinRibbonPainter.GetApplicationButtonIndent(const AName: string): Integer;
begin
  if SkinInfo <> nil then
    Result := SkinInfo.GetIntegerPropertyValue(ApplicationButtonElement, AName)
  else
    Result := 0
end;

function TdxSkinRibbonPainter.GetApplicationMenuContentOffset(const ATabsBounds: TRect): TRect;
begin
  if (SkinInfo = nil) or (SkinInfo.RibbonApplicationBackground = nil) or
    (SkinInfo.RibbonApplicationHeaderBackground = nil) or
    (SkinInfo.RibbonApplicationFooterBackground = nil)
  then
    Result := inherited GetApplicationMenuContentOffset(ATabsBounds)
  else
    Result := cxRect(SkinInfo.RibbonApplicationBackground.ContentOffset.Left,
      GetElementMinSize(SkinInfo.RibbonApplicationHeaderBackground).cy,
      SkinInfo.RibbonApplicationBackground.ContentOffset.Right,
      Max(30, GetElementMinSize(SkinInfo.RibbonApplicationFooterBackground).cy));
end;

function TdxSkinRibbonPainter.GetDisplayName: string;
begin
  Result := GetSkinName;
end;

procedure TdxSkinRibbonPainter.SetSkinName(const ASkinName: string);
begin
  LookAndFeel.SkinName := ASkinName;
end;

function TdxSkinRibbonPainter.GetStatusBarElement(
  AIsLeft: Boolean; var AElement: TdxSkinElement): Boolean;
begin
  Result := Assigned(SkinInfo);
  if Result then
    AElement := SkinInfo.RibbonStatusBarBackground;
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
    begin
      Result.Top := Result.Bottom - ABorders.Bottom;
      InflateRect(Result, -4, 0);
    end;
end;

function TdxSkinRibbonPainter.GetBorderSkinElement(
  ASide: TcxBorder; AIsRectangular: Boolean): TdxSkinElement;
begin
  case ASide of
    bLeft:
      Result := SkinInfo.RibbonFormLeft[AIsRectangular];
    bTop:
      Result := SkinInfo.RibbonFormCaption;
    bRight:
      Result := SkinInfo.RibbonFormRight[AIsRectangular];
    bBottom:
      Result := SkinInfo.RibbonFormBottom[AIsRectangular];
    else
      Result := nil;
  end;
end;

function TdxSkinRibbonPainter.GetCustomizeButtonOutsizeQAT(AHasAppButton: Boolean): Boolean;
var
  AProperty: TdxSkinBooleanProperty;
begin
  Result := False;
  if SkinInfo <> nil then
  begin
    AProperty := SkinInfo.RibbonQATCustomizeButtonOutsizeQAT[AHasAppButton];
    if AProperty <> nil then
      Result := AProperty.Value;
  end;
end;

function TdxSkinRibbonPainter.GetElementMinSize(AElement: TdxSkinElement): TSize;
begin
  with AElement.Image.Margins do
  begin
    Result.cx := Max(Left + Right, Max(AElement.MinSize.Width, AElement.Size.cx));
    Result.cy := Max(Top + Bottom, Max(AElement.MinSize.Height, AElement.Size.cy));
  end;
end;

function TdxSkinRibbonPainter.GetPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := LookAndFeel.Painter;
end;

function TdxSkinRibbonPainter.GetPopupMenuColor: TColor;
begin
  if SkinInfo.PopupMenu = nil then
    Result := clWhite
  else
    Result := SkinInfo.PopupMenu.Color;
end;

function TdxSkinRibbonPainter.GetQATBackgroundElement(
  ABellow, AHasApplicationButton: Boolean): TdxSkinElement;
begin
  if SkinInfo = nil then
    Result := nil
  else
    if ABellow then
      Result := SkinInfo.RibbonQuickToolbarBelow
    else
      Result := SkinInfo.RibbonQuickToolbar[AHasApplicationButton];
end;

function TdxSkinRibbonPainter.GetQATLeftOffset: Integer;
const
  QATOffsetDelta = 10;
begin
  if IsSkinAvailable then
  begin
    Result := QATOffsetDelta + GetApplicationButtonIndent(sdxRibbonAppButtonRightIndent) +
      SkinInfo.GetIntegerPropertyValue(GetQATBackgroundElement(False, True), sdxRibbonQuickAccessToolbarOffset);
  end
  else
    Result := 0;
end;

function TdxSkinRibbonPainter.GetIsSkinAvailable: Boolean;
begin
  Result := LookAndFeel.SkinPainter <> nil;
end;

procedure TdxSkinRibbonPainter.DrawApplicationButton(
  DC: HDC; const R: TRect; AState: TdxApplicationButtonState);
const
  dxApplicationButtonStateToElementState: array[TdxApplicationButtonState] of
    TdxSkinElementState = (esNormal, esHot, esPressed);
begin
  if ApplicationButtonElement = nil then
    inherited DrawApplicationButton(DC, R, AState)
  else
    ApplicationButtonElement.Draw(DC, R, 0, dxApplicationButtonStateToElementState[AState]);
end;

procedure TdxSkinRibbonPainter.DrawApplicationMenuButton(DC: HDC; const R: TRect; AState: Integer);
const
  ButtonState: array [Boolean] of TdxSkinElementState = (esNormal, esHot);
var
  AButton: TdxSkinElement;
begin
  if SkinInfo <> nil then
    AButton := SkinInfo.ButtonElements
  else
    AButton := nil;

  if AButton = nil then
    inherited DrawApplicationMenuButton(DC, R, AState)
  else
    AButton.Draw(DC, R, 0, ButtonState[AState = DXBAR_HOT]);
end;

procedure TdxSkinRibbonPainter.DrawApplicationMenuExtraPaneButton(
  DC: HDC; const R: TRect; AState: Integer);
begin
  if (SkinInfo = nil) or (SkinInfo.RibbonExtraPaneButton = nil) then
    inherited DrawApplicationMenuExtraPaneButton(DC, R, AState)
  else
    SkinInfo.RibbonExtraPaneButton.Draw(DC, R, 0, RibbonStateToSkinElementState(AState));
end;

procedure TdxSkinRibbonPainter.DrawApplicationMenuExtraPanePinButtonGlyph(
  DC: HDC; const R: TRect; AChecked: Boolean);
begin
  if (SkinInfo = nil) or (SkinInfo.RibbonExtraPanePinButtonGlyph = nil) then
    inherited DrawApplicationMenuExtraPanePinButtonGlyph(DC, R, AChecked)
  else
    SkinInfo.RibbonExtraPanePinButtonGlyph.Draw(DC, R, Ord(AChecked));
end;

procedure TdxSkinRibbonPainter.DrawApplicationMenuBackground(DC: HDC; const R, AContentRect: TRect);
var
  R1: TRect;
begin
  if (SkinInfo = nil) or (SkinInfo.RibbonApplicationBackground = nil) or
     (SkinInfo.RibbonApplicationFooterBackground = nil) or
     (SkinInfo.RibbonApplicationHeaderBackground = nil)
  then
    inherited DrawApplicationMenuBackground(DC, R, AContentRect)
  else
  begin
    R1 := cxRect(R.Left, R.Top, R.Right, AContentRect.Top);
    DrawTabAreaBackground(DC, R1, True, False);
    SkinInfo.RibbonApplicationHeaderBackground.Draw(DC, R1);

    R1 := cxRect(R.Left, AContentRect.Bottom, R.Right, R.Bottom);
    DrawTabAreaBackground(DC, R1, True, False);
    SkinInfo.RibbonApplicationFooterBackground.Draw(DC, R1);

    R1 := cxRect(R.Left, AContentRect.Top, R.Right, AContentRect.Bottom);
    if SkinInfo.RibbonApplicationBackground.IsAlphaUsed then
      FillRectByColor(DC, R1, PopupMenuColor);
    SkinInfo.RibbonApplicationBackground.Draw(DC, R1);

    R1.Left := R.Left + SkinInfo.RibbonApplicationBackground.ContentOffset.Left;
    R1.Right := AContentRect.Left;
    FillRectByColor(DC, R1, PopupMenuColor);

    R1.Right := R.Right - SkinInfo.RibbonApplicationBackground.ContentOffset.Right;
    R1.Left := AContentRect.Right;
    FillRectByColor(DC, R1, GetPartColor(DXBAR_MENUEXTRAPANE));
  end;
end;

procedure TdxSkinRibbonPainter.DrawBackstageViewBackground(DC: HDC; const R: TRect);
begin
  if (SkinInfo = nil) or (SkinInfo.RibbonBackstageView = nil) then
    inherited DrawBackstageViewBackground(DC, R)
  else
    SkinInfo.RibbonBackstageView.Draw(DC, R);
end;

procedure TdxSkinRibbonPainter.DrawBackstageViewMenuBackground(DC: HDC; const R: TRect);
begin
  if (SkinInfo = nil) or (SkinInfo.RibbonBackstageViewMenu = nil) then
    inherited DrawBackstageViewMenuBackground(DC, R)
  else
    SkinInfo.RibbonBackstageViewMenu.Draw(DC, R);
end;

procedure TdxSkinRibbonPainter.DrawBackstageViewMenuButton(DC: HDC; const R: TRect; AState: Integer);
begin
  if (SkinInfo = nil) or (SkinInfo.RibbonBackstageViewMenuButton = nil) then
    inherited DrawBackstageViewMenuButton(DC, R, AState)
  else
    SkinInfo.RibbonBackstageViewMenuButton.Draw(DC, R, 0,
      SkinElementCheckState(SkinInfo.RibbonBackstageViewMenuButton, AState));
end;

procedure TdxSkinRibbonPainter.DrawBackstageViewTabButton(DC: HDC; const R: TRect; AState: Integer);
begin
  if (SkinInfo = nil) or (SkinInfo.RibbonBackstageViewTab = nil) then
    inherited DrawBackstageViewTabButton(DC, R, AState)
  else
    SkinInfo.RibbonBackstageViewTab.Draw(DC, R, 0,
      SkinElementCheckState(SkinInfo.RibbonBackstageViewTab, AState));
end;

procedure TdxSkinRibbonPainter.DrawBackstageViewTopLine(DC: HDC; const R: TRect);
begin
  if (SkinInfo = nil) or (SkinInfo.RibbonBackstageViewTopLine = nil) then
    inherited DrawBackstageViewTopLine(DC, R)
  else
    SkinInfo.RibbonBackstageViewTopLine.Draw(DC, R);
end;

procedure TdxSkinRibbonPainter.DrawButtonGroup(DC: HDC; const R: TRect; AState: Integer);
var
  ABackground: TdxSkinElement;
  AElement: TdxSkinElement;
begin
  if SkinInfo <> nil then
  begin
    AElement := SkinInfo.RibbonButtonGroupButton;
    ABackground := SkinInfo.RibbonButtonGroup;
  end
  else
  begin
    AElement := nil;
    ABackground := nil;
  end;

  if (AElement = nil) or (ABackground = nil) then
    inherited DrawButtonGroup(DC, R, AState)
  else
  begin
    with ABackground.Image.Margins do
      DrawClippedElement(DC, R,
        cxRect(R.Left - Left, R.Top, R.Right + Right, R.Bottom),
        ABackground, esNormal, True);
    AElement.Draw(DC, R, 0, RibbonStateToSkinElementState(AState));
  end;
end;

procedure TdxSkinRibbonPainter.DrawButtonGroupSplitButtonSeparator(
  DC: HDC; const R: TRect; AState: Integer);
var
  AElement: TdxSkinElement;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonButtonGroupButton
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
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonButtonGroup
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
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonButtonGroup
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
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonButtonGroupSeparator
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawButtonGroupBorderMiddle(DC, R, AState)
  else
    AElement.Draw(DC, R, 0, RibbonStateToSkinElementState(AState));
end;

procedure TdxSkinRibbonPainter.DrawCollapsedToolbarBackground(
  DC: HDC; const R: TRect; AState: Integer);
var
  ACollapsedToolBar: TdxSkinElement;
begin
  if SkinInfo <> nil then
    ACollapsedToolBar := SkinInfo.RibbonCollapsedToolBarBackground
  else
    ACollapsedToolBar := nil;

  if ACollapsedToolBar = nil then
    inherited DrawCollapsedToolbarBackground(DC, R, AState)
  else
    ACollapsedToolBar.Draw(DC, R, 0, RibbonStateToSkinElementState(AState));
end;

procedure TdxSkinRibbonPainter.DrawCollapsedToolbarGlyphBackground(DC: HDC;
  const R: TRect; AState: Integer);
var
  ACollapsedToolBarGlyph: TdxSkinElement;
begin
  if SkinInfo <> nil then
    ACollapsedToolBarGlyph := SkinInfo.RibbonCollapsedToolBarGlyphBackground
  else
    ACollapsedToolBarGlyph := nil;

  if ACollapsedToolBarGlyph = nil then
    inherited DrawCollapsedToolbarGlyphBackground(DC, R, AState)
  else
    ACollapsedToolBarGlyph.Draw(DC, R);
end;

procedure TdxSkinRibbonPainter.DrawContextTabSeparator(
  DC: HDC; const R: TRect; ABeginGroup: Boolean);
begin
  if (SkinInfo = nil) or (SkinInfo.RibbonContextualTabSeparator = nil) then
    inherited DrawContextTabSeparator(DC, R, ABeginGroup)
  else
    SkinInfo.RibbonContextualTabSeparator.Draw(DC, R);
end;

procedure TdxSkinRibbonPainter.DrawContextTabBackground(
  DC: HDC; const R: TRect; AState: TdxRibbonTabState; AColor: TColor);
var
  AElement: TdxSkinElement;
  ARect: TRect;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonContextualTabHeader
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawContextTabBackground(DC, R, AState, AColor)
  else
    if AElement.ImageCount > 1 then
      DrawColoredElement(DC, R, AColor, AElement, RibbonTabStatesMap[AState])
    else
    begin
      ARect := CorrectTabHeaderRect(R);
      dxGpFillRect(DC, ARect, AColor);
      AElement.Draw(DC, ARect, 0, RibbonTabStatesMap[AState]);
    end;
end;

procedure TdxSkinRibbonPainter.DrawContextTabGroupsArea(
  DC: HDC; const R: TRect; AIsQATAtBottom: Boolean);
begin
  if (SkinInfo = nil) or (SkinInfo.RibbonContextualTabPanel = nil) then
    inherited DrawContextTabGroupsArea(DC, R, AIsQATAtBottom)
  else
    SkinInfo.RibbonContextualTabPanel.Draw(DC, R);
end;

procedure TdxSkinRibbonPainter.DrawContextBackground(DC: HDC; const R: TRect; AColor: TColor);
var
  AElement: TdxSkinElement;
  ARect: TRect;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonContextualTabLabel
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
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonContextualTabLabelOnGlass
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
  if not DoDrawEditButton(DC, R, AState, cxbkComboBtn) then
    inherited DrawEditArrowButton(DC, R, AState);
end;

procedure TdxSkinRibbonPainter.DrawEditEllipsisButton(DC: HDC; const R: TRect; AState: Integer);
begin
  if not DoDrawEditButton(DC, R, AState, cxbkEllipsisBtn) then
    inherited DrawEditEllipsisButton(DC, R, AState);
end;

procedure TdxSkinRibbonPainter.DrawEditSpinDownButton(DC: HDC; const R: TRect; AState: Integer);
begin
  if not DoDrawEditButton(DC, R, AState, cxbkSpinDownBtn) then
    inherited DrawEditSpinDownButton(DC, R, AState);
end;

procedure TdxSkinRibbonPainter.DrawEditSpinUpButton(DC: HDC; const R: TRect; AState: Integer);
begin
  if not DoDrawEditButton(DC, R, AState, cxbkSpinUpBtn) then
    inherited DrawEditSpinUpButton(DC, R, AState);
end;

procedure TdxSkinRibbonPainter.DrawProgressDiscreteBand(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
  ARect: TRect;

  function CheckRect(const R: TRect): TRect;
  begin
    Result := R;
    if SkinInfo.ProgressBarElements[False, False] <> nil then
    begin
      InflateRect(Result, 0, 2);
      with SkinInfo.ProgressBarElements[False, False].ContentOffset.Rect do
      begin
        Inc(Result.Top, Top);
        Dec(Result.Bottom, Bottom);
      end;
    end;
  end;

begin
  if SkinInfo <> nil then
    AElement := SkinInfo.ProgressBarElements[True, False]
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
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.ProgressBarElements[True, False]
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawProgressDiscreteBand(DC, R)
  else
  begin
    ARect := R;
    if SkinInfo.ProgressBarElements[False, False] <> nil then
    begin
      InflateRect(ARect, 2, 2);
      ARect := cxRectContent(ARect, SkinInfo.ProgressBarElements[False, False].ContentOffset.Rect);
    end;
    DrawClippedElement(DC, R, ARect, AElement);
  end;
end;

procedure TdxSkinRibbonPainter.DrawProgressSubstrate(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.ProgressBarElements[False, False]
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
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.PopupMenu
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawDropDownBorder(DC, R)
  else
    AElement.Draw(DC, R);
end;                          

procedure TdxSkinRibbonPainter.DrawDropDownGalleryBackground(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonGalleryBackground
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawDropDownGalleryBackground(DC, R)
  else
    AElement.Draw(DC, R);
end;

procedure TdxSkinRibbonPainter.DrawDropDownGalleryBottomSizeGrip(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
  ARect: TRect;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonGallerySizeGrips
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

procedure TdxSkinRibbonPainter.DrawDropDownGalleryBottomSizingBand(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonGallerySizingPanel
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawDropDownGalleryBottomSizingBand(DC, R)
  else
    AElement.Draw(DC, R);
end;

procedure TdxSkinRibbonPainter.DrawDropDownGalleryBottomVerticalSizeGrip(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonGallerySizeGrips
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawDropDownGalleryBottomVerticalSizeGrip(DC, R)
  else
    AElement.Draw(DC, R);
end;

procedure TdxSkinRibbonPainter.DrawDropDownGalleryTopSizingBand(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonGallerySizingPanel
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawDropDownGalleryTopSizingBand(DC, R)
  else
    AElement.Draw(DC, R);
end;

procedure TdxSkinRibbonPainter.DrawDropDownGalleryTopSizeGrip(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
  ARect: TRect;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonGallerySizeGrips
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

procedure TdxSkinRibbonPainter.DrawDropDownGalleryTopVerticalSizeGrip(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonGallerySizeGrips
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

procedure TdxSkinRibbonPainter.DrawGalleryGroupHeaderBackground(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonGalleryGroupCaption
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
  R1: TRect;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonGalleryPane
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawInRibbonGalleryBackground(DC, R, AState)
  else
  begin
    R1 := R;
    Inc(R1.Right, AElement.Image.Margins.Right);
    DrawClippedElement(DC, R, R1, AElement, RibbonStateToSkinElementState(AState), True);
  end;
end;

procedure TdxSkinRibbonPainter.DrawInRibbonGalleryScrollBarButton(
  DC: HDC; const R: TRect; AButtonKind: TdxInRibbonGalleryScrollBarButtonKind;
  AState: Integer);
var
  AElement: TdxSkinElement;
begin
  AElement := nil;
  if SkinInfo <> nil then
  begin
    case AButtonKind of
      gsbkLineUp:
        AElement := SkinInfo.RibbonGalleryButtonUp;
      gsbkLineDown:
        AElement := SkinInfo.RibbonGalleryButtonDown;
      gsbkDropDown:
        AElement := SkinInfo.RibbonGalleryButtonDropDown;
    end;
  end;

  if AElement = nil then
    inherited DrawInRibbonGalleryScrollBarButton(DC, R, AButtonKind, AState)
  else
    AElement.Draw(DC, R, 0, RibbonStateToSkinElementState(AState));
end;

procedure TdxSkinRibbonPainter.DrawInRibbonGalleryScrollBarBackground(
  DC: HDC; const R: TRect; AState: Integer);
var
  R1: TRect;
  AElement: TdxSkinElement;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonGalleryPane
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawInRibbonGalleryScrollBarBackground(DC, R, AState)
  else
  begin
    R1 := R;
    Dec(R1.Left, Max(AElement.Size.cx, AElement.Image.Margins.Left));
    DrawClippedElement(DC, R, R1, AElement, RibbonStateToSkinElementState(AState), True);
  end;
end;

procedure TdxSkinRibbonPainter.DrawArrowDown(DC: HDC; const R: TRect; AState: Integer);
const
  StateMap: array[0..8] of TdxSkinElementState = (esNormal, esDisabled, esHot,
    esActive, esNormal, esNormal, esNormal, esNormal, esNormal);
var
  AElement: TdxSkinElement;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonButtonArrow
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

function TdxSkinRibbonPainter.DoDrawEditButton(DC: HDC;
  const R: TRect; AState: Integer; AButtonKind: TcxEditBtnKind): Boolean;
const
  ButtonState: array [DXBAR_NORMAL..DXBAR_ACTIVEDISABLED] of TcxButtonState = (
    cxbsNormal, cxbsDisabled, cxbsHot, cxbsNormal, cxbsPressed, cxbsPressed,
    cxbsDefault, cxbsDefault, cxbsDisabled);
begin
  Result := IsSkinAvailable;
  if Result then
  begin
    cxPaintCanvas.BeginPaint(DC);
    try
      Painter.DrawEditorButton(cxPaintCanvas, R, AButtonKind, ButtonState[AState]);
    finally
      cxPaintCanvas.EndPaint;
    end;
  end;
end;

function TdxSkinRibbonPainter.DoDrawStatusBarPart(
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
      AMinSize := GetElementMinSize(AElement);
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

function TdxSkinRibbonPainter.DoDrawStatusBarRectangularPart(
  DC: HDC; const R: TRect; AIsRaised, AActive, AIsLeft: Boolean): Boolean;
const
  SideMap: array[Boolean] of TcxBorder = (bRight, bLeft);
begin
  Result := SkinInfo <> nil;
  if Result then
  begin
    DrawFormBorder(DC, SideMap[AIsLeft], 0,
      Rect(cxRectWidth(R), 0, cxRectWidth(R), 0), R,
      GetBorderSkinElement(SideMap[AIsLeft], True), AActive);
  end;
end;

procedure TdxSkinRibbonPainter.DrawFormBordersEx(DC: HDC;
  const ABordersWidth: TRect; ACaptionHeight, ACaptionAreaExtention: Integer;
  const AData: TdxRibbonFormData; AHasStatusBar: Boolean);

  procedure DrawBottomCorner(ASide: TcxBorder; R: TRect);
  var
    ABitmap: TcxBitmap;
    AElement: TdxSkinElement;
  begin
    AElement := GetBorderSkinElement(ASide, IsRectangularFormBottom(AData));
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

  procedure InternalDrawBorder(ASide: TcxBorder);
  begin
    if (ASide <> bTop) or (ACaptionHeight <> 0) then
    begin
      if (ASide = bBottom) and AHasStatusBar then
        DrawStatusBarFormBorder(DC, AData, ABordersWidth)
      else
        DrawFormBorder(DC, ASide, ACaptionHeight, ABordersWidth, AData.Bounds, 
          GetBorderSkinElement(ASide, IsRectangularFormBottom(AData)), AData.Active);
    end;
  end;

var
  ASide: TcxBorder;
  R: TRect;
begin
  if SkinInfo <> nil then
  begin
    cxPaintCanvas.BeginPaint(DC);
    cxPaintCanvas.SaveClipRegion;
    try
      cxPaintCanvas.ExcludeClipRect(cxRectContent(AData.Bounds, ABordersWidth));
      for ASide := Low(TcxBorder) to High(TcxBorder) do
        InternalDrawBorder(ASide);
      if ABordersWidth.Bottom > 1 then
      begin
        R := AData.Bounds;
        R.Top := R.Bottom - ABordersWidth.Bottom;
        DrawBottomCorner(bLeft, cxRectSetWidth(R, 4));
        DrawBottomCorner(bRight, cxRectSetLeft(R, R.Right - 4, 4));
      end;
    finally
      cxPaintCanvas.RestoreClipRegion;
      cxPaintCanvas.EndPaint;
    end;
  end
  else
    inherited DrawFormBordersEx(DC, ABordersWidth,
      ACaptionHeight, ACaptionAreaExtention, AData, AHasStatusBar);
end;

procedure TdxSkinRibbonPainter.DrawFormBorder(DC: HDC; ASide: TcxBorder;
  ACaptionHeight: Integer; ABorderWidths, R: TRect; AElement: TdxSkinElement;
  AActive: Boolean);

  procedure CorrectBorderSourceRect(var R: TRect; const ASize: TSize);
  begin
    case ASide of
      bTop:
        R.Bottom := Max(R.Bottom, R.Top + ASize.cy);
      bLeft:
        R.Right := Max(R.Right, R.Left + ASize.cx);
      bRight:
        R.Left := Min(R.Left, R.Right - ASize.cx);
      bBottom:
        R.Top := Min(R.Top, R.Bottom - ASize.cy);
    end;
  end;

var
  ABorderRect: TRect;
  ASaveIndex: Integer;
begin
  if Assigned(AElement) and not IsRectEmpty(R) then
  begin
    ASaveIndex := SaveDC(DC);
    try
      Inc(ABorderWidths.Top, ACaptionHeight);
      ABorderRect := GetBorderBounds(ASide, ABorderWidths, R);
      IntersectClipRect(DC, ABorderRect.Left, ABorderRect.Top, ABorderRect.Right, ABorderRect.Bottom);
      CorrectBorderSourceRect(R, AElement.Size);
      AElement.UseCache := True;
      AElement.Draw(DC, ABorderRect, Integer(not AActive), RibbonFormBorderStates[AActive]);
    finally
      RestoreDC(DC, ASaveIndex);
    end;
  end;
end;

procedure TdxSkinRibbonPainter.DrawStatusBarFormBorder(
  DC: HDC; const AData: TdxRibbonFormData; const ABorders: TRect);
var
  ALeftIndent, ARightIndent: Integer;
  R, R1: TRect;
begin
  if Assigned(SkinInfo) then
  begin
    if Assigned(SkinInfo.RibbonStatusBarBackground) and (ABorders.Bottom > 1) then
    begin
      R1 := cxRectSetTop(AData.Bounds, AData.Bounds.Bottom - ABorders.Bottom - 1, ABorders.Bottom);
      R1 := cxRectInflate(R1, -ABorders.Left, 0, -ABorders.Right, 0);
      GetElementContentIndents(SkinInfo.RibbonStatusBarBackground, True, ALeftIndent, ARightIndent);
      R := cxRectInflate(R1, ALeftIndent, 0, ARightIndent, 0);
      Dec(R.Top, SkinInfo.RibbonStatusBarBackground.Size.cy - ABorders.Bottom);
      DrawClippedElement(DC, R1, R, SkinInfo.RibbonStatusBarBackground);
    end;
    DrawFormBorder(DC, bBottom, 0, Rect(ABorders.Left, 0, ABorders.Right, 1), AData.Bounds,
      GetBorderSkinElement(bBottom, IsRectangularFormBottom(AData)), AData.Active);
  end;
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
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.FormIcons[True, RibbonIconsToSkinFormIcons[AIcon]]
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawFormBorderIcon(DC, R, AIcon, AState)
  else
    AElement.Draw(DC, cxRectInflate(R, -1, -1), 0, RibbonIconStateToSkinElementState[AState]);
end;

procedure TdxSkinRibbonPainter.DrawFormCaption(DC: HDC;
  const R: TRect; const AData: TdxRibbonFormData; ATabHeadersAreaVisible: Boolean);
begin
  if (SkinInfo = nil) or (SkinInfo.RibbonFormCaption = nil) then
    inherited DrawFormCaption(DC, R, AData, ATabHeadersAreaVisible)
  else
  begin
    SkinInfo.RibbonFormCaption.UseCache := True;
    SkinInfo.RibbonFormCaption.Draw(DC, R, Byte(not AData.Active));
  end;
end;

procedure TdxSkinRibbonPainter.DrawFormStatusBarPart(
  DC: HDC; const R: TRect; AIsLeft, AIsActive, AIsRaised, AIsRectangular: Boolean);
var
  AHandled: Boolean;
begin
  if AIsRectangular then
    AHandled := DoDrawStatusBarRectangularPart(DC, R, AIsRaised, AIsActive, AIsLeft)
  else
    AHandled := DoDrawStatusBarPart(DC, R, AIsRaised, AIsActive, AIsLeft);

  if not AHandled then
    inherited DrawFormStatusBarPart(DC, R, AIsLeft, AIsActive, AIsRaised, AIsRectangular);
end;

procedure TdxSkinRibbonPainter.DrawLargeButton(DC: HDC; const R: TRect; AState: Integer);
var
  AElement: TdxSkinElement;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonLargeButton
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawLargeButton(DC, R, AState)
  else
    AElement.Draw(DC, R, 0, SkinElementCheckState(AElement, RibbonStateToSkinElementState(AState)));
end;

procedure TdxSkinRibbonPainter.DrawLargeButtonDropButton(
  DC: HDC; const R: TRect; AState: Integer);
var
  AElement: TdxSkinElement;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonLargeSplitButtonBottom
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawLargeButton(DC, R, AState)
  else
    AElement.Draw(DC, R, 0, SkinElementCheckState(AElement, AState));
end;

procedure TdxSkinRibbonPainter.DrawLargeButtonGlyphBackground(
  DC: HDC; const R: TRect; AState: Integer);
var
  AElement: TdxSkinElement;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonLargeSplitButtonTop
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawLargeButton(DC, R, AState)
  else
    AElement.Draw(DC, R, 0, SkinElementCheckState(AElement, AState));
end;

procedure TdxSkinRibbonPainter.DrawLaunchButtonBackground(
  DC: HDC; const R: TRect; AState: Integer);
const
  StateMap: array[0..8] of TdxSkinElementState = (esNormal, esNormal, esHot,
    esHot, esPressed, esNormal, esNormal, esNormal, esNormal);
var
  AElement: TdxSkinElement;
  ARect: TRect;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonTabPanelGroupButton
  else
    AElement := nil;

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

procedure TdxSkinRibbonPainter.DrawHelpButton(DC: HDC; const R: TRect; AState: TcxButtonState);
const
  StateMap: array [TcxButtonState] of Integer =
    (DXBAR_NORMAL, DXBAR_NORMAL, DXBAR_HOT, DXBAR_PRESSED, DXBAR_DISABLED);
begin
  if IsSkinAvailable then
    DrawSmallButton(DC, R, StateMap[AState])
  else
    inherited DrawHelpButton(DC, R, AState);
end;

procedure TdxSkinRibbonPainter.DrawGroupScrollButton(
  DC: HDC; const R: TRect; ALeft: Boolean; AState: Integer);
var
  AElement: TdxSkinElement;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonGroupScroll[ALeft]
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawGroupScrollButton(DC, R, ALeft, AState)
  else
    AElement.Draw(DC, R, 0, RibbonStateToSkinElementState(AState));
end;

procedure TdxSkinRibbonPainter.DrawItemSeparator(
  DC: HDC; const R: TRect; AHorizontal: Boolean);
var
  AElement: TdxSkinElement;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonTabGroupItemsSeparator
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
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonKeyTip
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
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonQuickToolbarGlyph
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawMarkArrow(DC, R, AState)
  else
    AElement.Draw(DC, R);
end;

procedure TdxSkinRibbonPainter.DrawMDIButton(DC: HDC;
  const R: TRect; AButton: TdxBarMDIButton; AState: TcxButtonState);
const
  RibbonIconsToSkinFormIcons: array[TdxBarMDIButton] of TdxSkinFormIcon =
    (sfiMinimize, sfiRestore, sfiClose);
  ButtonStateToSkinElementState: array[TcxButtonState] of TdxSkinElementState =
    (esActive, esNormal, esHot, esPressed, esDisabled);
var
  AElement: TdxSkinElement;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.FormIcons[True, RibbonIconsToSkinFormIcons[AButton]]
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawMDIButton(DC, R, AButton, AState)
  else
    AElement.Draw(DC, cxRectInflate(R, -1, -1), 0, ButtonStateToSkinElementState[AState]);
end;

procedure TdxSkinRibbonPainter.DrawMDIButtonGlyph(DC: HDC;
  const R: TRect; AButton: TdxBarMDIButton; AState: TcxButtonState);
begin
  if not IsSkinAvailable then
    inherited DrawMDIButtonGlyph(DC, R, AButton, AState);
end;

procedure TdxSkinRibbonPainter.DrawMinimizeRibbonButtonGlyph(DC: HDC;
  const R: TRect; AState: TcxButtonState; AGlyph: TdxRibbonMinimizeButtonGlyph);
begin
  if (SkinInfo = nil) or (SkinInfo.RibbonMinimizeButtonGlyph = nil) then
    inherited DrawMinimizeRibbonButtonGlyph(DC, R, AState, AGlyph)
  else
    SkinInfo.RibbonMinimizeButtonGlyph.Draw(DC, R, Ord(AGlyph <> rmbMinimize));
end;

procedure TdxSkinRibbonPainter.DrawMenuCheck(DC: HDC; const R: TRect; AState: Integer);
var
  AElement: TdxSkinElement;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.PopupMenuCheck
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawMenuCheck(DC, R, AState)
  else
    AElement.Draw(DC, R, 1);
end;

procedure TdxSkinRibbonPainter.DrawMenuCheckMark(DC: HDC; const R: TRect; AState: Integer);
var
  AElement: TdxSkinElement;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.PopupMenuCheck
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawMenuCheckMark(DC, R, AState)
  else
    AElement.Draw(DC, R);
end;

procedure TdxSkinRibbonPainter.DrawMenuContent(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.PopupMenu
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
  R1: TRect;
begin
  if SkinInfo <> nil then
    AColor := SkinInfo.RibbonExtraPaneHeaderSeparator
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
  R1: TRect;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.PopupMenuSideStrip
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
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.PopupMenuSeparator
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
  R1: TRect;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.PopupMenuSideStrip
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
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.PopupMenuExpandButton
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
  if (SkinInfo = nil) or (SkinInfo.RibbonFormCaption = nil) then
    inherited DrawRibbonClientTopArea(DC, R)
  else
  begin
    ARect := R;
    with SkinInfo.RibbonFormCaption.Image.Margins.Rect do
      ARect := Rect(R.Left - Left, R.Top - 1, R.Right + Right, R.Bottom);
    DrawClippedElement(DC, R, ARect, SkinInfo.RibbonFormCaption, esNormal, True);
  end;
end;

procedure TdxSkinRibbonPainter.DrawRibbonTopFrameArea(DC: HDC; const R: TRect; AUseAeroGlass: Boolean);
var
  AElement: TdxSkinElement;
begin
  if AUseAeroGlass then
  begin
    if SkinInfo <> nil then
      AElement := SkinInfo.RibbonHeaderBackgroundOnGlass
    else
      AElement := nil;

    if AElement = nil then
      inherited DrawRibbonTopFrameArea(DC, R, AUseAeroGlass)
    else
      AElement.Draw(DC, R);
  end;
end;

procedure TdxSkinRibbonPainter.DrawRibbonTopFrameAreaSeparator(DC: HDC; const R: TRect);
begin
  if not IsSkinAvailable then
    inherited DrawRibbonTopFrameAreaSeparator(DC, R);
end;

procedure TdxSkinRibbonPainter.DrawScreenTip(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.ScreenTipWindow
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
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.ItemSeparator
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
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonSmallButton
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawSmallButton(DC, R, AState)
  else
  begin
    AElement.UseCache := True;
    AElement.Draw(DC, R, 0, SkinElementCheckState(AElement, RibbonStateToSkinElementState(AState)));
  end;
end;

procedure TdxSkinRibbonPainter.DrawSmallButtonDropButton(DC: HDC; const R: TRect; AState: Integer);
var
  AElement: TdxSkinElement;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonSplitButtonRight
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
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonSplitButtonLeft
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
  R1: TRect;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonStatusBarBackground
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
var
  AElement: TdxSkinElement;
  ALeftIndent, ARightIndent: Integer;
  R1: TRect;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonStatusBarBackground
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawStatusBarGripBackground(DC, R)
  else
  begin
    GetElementContentIndents(AElement, False, ALeftIndent, ARightIndent);
    R1 := cxRectInflate(R, ALeftIndent, 0, ARightIndent, AElement.ContentOffset.Bottom);
    DrawClippedElement(DC, R, R1, AElement, esNormal, True, 1);
    if SkinInfo.SizeGrip <> nil then
      SkinInfo.SizeGrip.Draw(DC, R);
    ExcludeClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
  end;
end;

procedure TdxSkinRibbonPainter.DrawStatusBarPanel(
  DC: HDC; const Bounds, R: TRect; AIsLowered: Boolean);
var
  ABitmap: TcxBitmap;
  AElement: TdxSkinElement;
  ARect, ABorders: TRect;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonStatusBarBackground
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
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonStatusBarSeparator
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
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonStatusBarSeparator
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
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonTab
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawTab(DC, R, AState)
  else
    AElement.Draw(DC, CorrectTabHeaderRect(R), 0, RibbonTabStatesMap[AState]);
end;

procedure TdxSkinRibbonPainter.DrawTabAreaBackground(
  DC: HDC; const R: TRect; AActive, AUseAeroGlass: Boolean);
var
  AElement: TdxSkinElement;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonHeaderBackground
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawTabAreaBackground(DC, R, AActive, AUseAeroGlass)
  else
    if not (AUseAeroGlass and ExtendCaptionAreaOnTabs) then
    begin
      if AElement.IsAlphaUsed then
        AElement.Draw(DC, R, 1);
      AElement.Draw(DC, R);
    end;
end;

procedure TdxSkinRibbonPainter.DrawTabGroupBackground(
  DC: HDC; const R: TRect; AState: Integer);
const
  StateMap: array[Boolean] of TdxSkinElementState = (esNormal, esHot);
var
  AElement: TdxSkinElement;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonTabGroup
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawTabGroupBackground(DC, R, AState)
  else
  begin
    AElement.UseCache := True;
    AElement.Draw(DC, R, 0, StateMap[AState = DXBAR_HOT]);
  end;
end;

procedure TdxSkinRibbonPainter.DrawTabGroupHeaderBackground(
  DC: HDC; const R: TRect; AState: Integer);
const
  AStateMap: array[Boolean] of TdxSkinElementState = (esNormal, esHot);
var
  AElement: TdxSkinElement;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonTabGroupHeader
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawTabGroupHeaderBackground(DC, R, AState)
  else
    AElement.Draw(DC, R, 0, AStateMap[AState = DXBAR_HOT]);
end;

procedure TdxSkinRibbonPainter.DrawTabGroupsArea(
  DC: HDC; const R: TRect; AIsQATAtBottom: Boolean);
begin
  if (SkinInfo = nil) or (SkinInfo.RibbonTabPanel = nil) then
    inherited DrawTabGroupsArea(DC, R, AIsQATAtBottom)
  else
  begin
    SkinInfo.RibbonTabPanel.UseCache := True;
    SkinInfo.RibbonTabPanel.Draw(DC, R);
  end;
end;

procedure TdxSkinRibbonPainter.DrawTabScrollButton(
  DC: HDC; const R: TRect; ALeft: Boolean; AState: Integer);
var
  AElement: TdxSkinElement;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonSmallButton
  else
    AElement := nil;

  if AElement = nil then
    inherited DrawTabScrollButton(DC, R, ALeft, AState)
  else
    AElement.Draw(DC, R, 0, RibbonStateToSkinElementState(AState));
end;

procedure TdxSkinRibbonPainter.DrawTabSeparator(DC: HDC; const R: TRect; Alpha: Byte);
var
  ABitmap: TcxBitmap;
  AElement: TdxSkinElement;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonTabSeparatorLine
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
      ARect := ValidateQATRect(R, SkinInfo.RibbonFormCaption);
      if ABellow or (cxRectWidth(ARect) >= cxRectHeight(ARect)) then
        AElement.Draw(DC, ARect);
    end;
end;

procedure TdxSkinRibbonPainter.DrawQuickAccessToolbarDefaultGlyph(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonQuickToolbarButtonGlyph
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
begin
  if SkinInfo <> nil then
  begin
    ABackground := SkinInfo.RibbonButtonGroup;
    AElement := SkinInfo.RibbonButtonGroupButton;
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
      RibbonStateToSkinElementState(AState));
  end;
end;

procedure TdxSkinRibbonPainter.DrawQuickAccessToolbarPopup(DC: HDC; const R: TRect);
var
  AElement: TdxSkinElement;
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonQuickToolbarDropDown
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
  if not GetExtendedStylePainters.GetPainterData(LookAndFeel.SkinPainter, FSkinInfo) then
    FSkinInfo := nil;
end;

procedure TdxSkinRibbonPainter.LoadCustomRibbonSkinBitmap(out ABitmap: Pointer);
begin
  LoadBitmapFromStream('RIBBONBLACK', ABitmap);
end;

procedure TdxSkinRibbonPainter.LoadFormSkinBitmap(out ABitmap: Pointer);
begin
  LoadBitmapFromStream('FORMBLACK', ABitmap);
end;

function TdxSkinRibbonPainter.GetApplicationMenuGlyphSize: TSize;
begin
  if ApplicationButtonElement = nil then
    Result := inherited GetApplicationMenuGlyphSize
  else
  begin
    Result := GetElementMinSize(ApplicationButtonElement);
    Inc(Result.cx, GetApplicationButtonIndent(sdxRibbonAppButtonRightIndent));
    Inc(Result.cx, GetApplicationButtonIndent(sdxRibbonAppButtonLeftIndent));
  end;
end;

function TdxSkinRibbonPainter.GetCaptionFontSize(ACurrentFontSize: Integer): Integer;
begin
  Result := inherited GetCaptionFontSize(ACurrentFontSize);
  if (SkinInfo <> nil) and (SkinInfo.RibbonCaptionFontDelta <> nil) then
    Inc(Result, SkinInfo.RibbonCaptionFontDelta.Value);
end;

function TdxSkinRibbonPainter.GetElementTextColor(
  AElement: TdxSkinElement; AState: Integer = 0): TColor;
begin
  if AElement = nil then
    Result := clDefault
  else
    Result := AElement.GetTextColor(RibbonStateToButtonState(AState));
end;

function TdxSkinRibbonPainter.GetPropertyColor(AColor: TdxSkinColor): TColor;
begin
  if AColor = nil then
    Result := clDefault
  else
    Result := AColor.Value;
end;

function TdxSkinRibbonPainter.GetElementContentIndents(AElement: TdxSkinElement;
  AConsideMargins: Boolean; out ALeftIndent, ARightIndent: Integer): Boolean;
begin
  Result := Assigned(AElement);
  if Result then
  begin
    ALeftIndent := AElement.ContentOffset.Left;
    ARightIndent := AElement.ContentOffset.Right;
    if AConsideMargins then
    begin
      ALeftIndent := Max(AElement.Image.Margins.Left, ALeftIndent);
      ARightIndent := Max(AElement.Image.Margins.Right, ARightIndent);
    end;
  end;
end;

function TdxSkinRibbonPainter.GetMenuSeparatorSize: Integer;
begin
  if Assigned(SkinInfo) and Assigned(SkinInfo.PopupMenuSeparator) then
    Result := SkinInfo.PopupMenuSeparator.Size.cy
  else
    Result := inherited GetMenuSeparatorSize;
end;

function TdxSkinRibbonPainter.GetPartColor(APart: Integer; AState: Integer = 0): TColor;
begin
  Result := clDefault;
  if SkinInfo <> nil then
  begin
    case APart of
      DXBAR_ITEMTEXT:
        case AState of
          DXBAR_DISABLED, DXBAR_ACTIVEDISABLED:
            Result := SkinInfo.RibbonButtonText[True]
          else
            Result := SkinInfo.RibbonButtonText[False];
        end;

      DXBAR_MENUITEMTEXT:
        if AState = DXBAR_DISABLED then
          Result := GetPropertyColor(SkinInfo.BarDisabledTextColor)
        else
          Result := GetElementTextColor(SkinInfo.PopupMenu);

      DXBAR_EDIT_BORDER:
        if AState = DXBAR_ACTIVE then
          Result := GetPropertyColor(SkinInfo.ContainerHighlightBorderColor)
        else
          Result := GetPropertyColor(SkinInfo.ContainerBorderColor);

      rfspRibbonForm:
        if SkinInfo.FormContent <> nil then
          Result := SkinInfo.FormContent.Color;

      rspContextTabHeaderText:
        begin
          if AState = DXBAR_HOT then
            Result := SkinInfo.RibbonContextualTabHeaderTextHot
          else
            Result := SkinInfo.RibbonContextualTabHeaderText[AState = DXBAR_ACTIVE];

          if (Result = clNone) or (Result = clDefault) then
            Result := GetPartColor(rspTabHeaderText, AState);
        end;

      rspTabHeaderText:
        begin
          case AState of
            DXBAR_HOT:
              Result := SkinInfo.RibbonTabTextHot;
            DXBAR_ACTIVE:
              Result := SkinInfo.RibbonTabText[True];
            else
              Result := clDefault;
          end;
          if Result = clDefault then
            Result := SkinInfo.RibbonTabText[False];
        end;

      DXBAR_KEYTIP_TEXTCOLOR:
        Result := GetElementTextColor(SkinInfo.RibbonKeyTip);
      DXBAR_SCREENTIP_TITLE:
        Result := GetPropertyColor(SkinInfo.ScreenTipTitleItem);
      DXBAR_SCREENTIP_DESCRIPTION:
        Result := GetPropertyColor(SkinInfo.ScreenTipItem);
      DXBAR_MENUEXTRAPANE:
        Result := GetPropertyColor(SkinInfo.RibbonExtraPaneColor);
      DXBAR_MENUEXTRAPANE_BUTTON_TEXTCOLOR, DXBAR_MENUEXTRAPANE_HEADER_TEXTCOLOR:
        Result := GetElementTextColor(SkinInfo.RibbonExtraPaneButton, AState);
      DXBAR_EDIT_BACKGROUND:
        Result := GetPropertyColor(SkinInfo.RibbonEditorBackground);
      DXBAR_SEPARATOR_BACKGROUND:
        Result := GetPropertyColor(SkinInfo.ContentColor);
      DXBAR_EDIT_TEXTCOLOR:
        Result := Painter.DefaultEditorTextColor(AState = DXBAR_DISABLED);
      DXBAR_SCREENTIP_FOOTERLINE:
        Result := GetPropertyColor(SkinInfo.ContainerBorderColor);
      rspFormCaptionText:
        Result := SkinInfo.RibbonCaptionText[AState = DXBAR_NORMAL];
      rspDocumentNameText:
        Result := SkinInfo.RibbonDocumentNameTextColor[AState = DXBAR_NORMAL];
      rspTabGroupText:
        Result := GetElementTextColor(SkinInfo.RibbonSmallButton);
      rspTabGroupHeaderText:
        Result := GetElementTextColor(SkinInfo.RibbonTabGroupHeader);
      rspContextText:
        Result := GetElementTextColor(SkinInfo.RibbonContextualTabLabel);
      rspContextTextOnGlass:
        Result := GetElementTextColor(SkinInfo.RibbonContextualTabLabelOnGlass);
      rspContextTextShadow:
        Result := GetPropertyColor(SkinInfo.RibbonContextualTabLabelShadowColor);
      rbvpBackstageViewMenuTabButton:
        Result := GetElementTextColor(SkinInfo.RibbonBackstageViewTab, AState);
      rbvpBackstageViewMenuItem:
        Result := GetElementTextColor(SkinInfo.RibbonBackstageViewMenuButton, AState);
      rspApplicationButtonNormal..rspApplicationButtonPressed:
        Result := GetElementTextColor(SkinInfo.RibbonApplicationButton2010);

      rspStatusBarText:
        case AState of
          DXBAR_NORMAL:
            Result := SkinInfo.RibbonStatusBarText;
          DXBAR_HOT:
            Result := SkinInfo.RibbonStatusBarTextHot;
          DXBAR_DISABLED:
            Result := SkinInfo.RibbonStatusBarTextDisabled;
        end;        

      DXBAR_GALLERYGROUPHEADERTEXT, DXBAR_GALLERYFILTERBANDTEXT:
        Result := GetElementTextColor(SkinInfo.RibbonGalleryGroupCaption);
    end;
  end;
  if Result = clDefault then
    Result := inherited GetPartColor(APart, AState);
end;

function TdxSkinRibbonPainter.GetPartContentOffsets(APart: Integer): TRect;
var
  AElement: TdxSkinElement;
begin
  AElement := nil;
  if SkinInfo <> nil then
  begin
    case APart of
      DXBAR_TOOLBAR:
        AElement := SkinInfo.RibbonTabGroup;
      DXBAR_GALLERYFILTERBAND:
        AElement := SkinInfo.RibbonGallerySizingPanel;
      DXBAR_RIBBONTABGROUP:
        AElement := SkinInfo.RibbonTabPanel;
      DXBAR_RIBBONCONTEXTTABGROUP:
        AElement := SkinInfo.RibbonContextualTabPanel;
      DXBAR_QUICKACCESSTOOLBAR:
        AElement := SkinInfo.RibbonQuickToolbarBelow;
      DXBAR_APPLICATIONBUTTONICONOFFSET:
        AElement := ApplicationButtonElement;
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

begin
  Result := inherited GetPartOffset(APart);
  if SkinInfo <> nil then
  begin
    case APart of
      rbvpBackstageViewTopLine:
        if SkinInfo.RibbonBackstageViewTopLine <> nil then
          Result := SkinInfo.RibbonBackstageViewTopLine.MinSize.Height;
      rbvpBackstageViewMenuTabButtonHeight:
        if SkinInfo.RibbonBackstageViewTab <> nil then
          Result := Max(Result, SkinInfo.RibbonBackstageViewTab.MinSize.Height);
      rbvpBackstageViewMenuItemHeight:
        if SkinInfo.RibbonBackstageViewMenuButton <> nil then
          Result := Max(Result, SkinInfo.RibbonBackstageViewMenuButton.MinSize.Height);
      DXBAR_SEPARATOR_LINE:
        Result := 0;
      DXBAR_TOOLBAR:
        Result := GetValue(SkinInfo.RibbonSpaceBetweenTabGroups);
      DXBAR_TABSGROUPSOVERLAPHEIGHT:
        Result := GetValue(SkinInfo.RibbonTabHeaderDownGrowIndent);
    end;
  end;
end;

function TdxSkinRibbonPainter.GetQuickAccessToolbarLeftIndent(
  AHasApplicationButton: Boolean; AUseAeroGlass: Boolean): Integer;
begin
  if not AUseAeroGlass and AHasApplicationButton and (SkinInfo <> nil) then
  begin
    Result := -QATLeftDefaultOffset;
    if SkinInfo.RibbonQuickToolbar[True] <> nil then
      Inc(Result, SkinInfo.RibbonQuickToolbar[True].ContentOffset.Left);
    Inc(Result, GetQATLeftOffset);
  end
  else
    Result := inherited GetQuickAccessToolbarLeftIndent(AHasApplicationButton, AUseAeroGlass);
end;

function TdxSkinRibbonPainter.GetQuickAccessToolbarMarkButtonOffset(
  AHasApplicationButton: Boolean; ABelow: Boolean): Integer;
var
  AOffsetProperty: TdxSkinIntegerProperty;
begin
  if SkinInfo <> nil then
    AOffsetProperty := SkinInfo.RibbonQATIndentBeforeCustomizeButton[AHasApplicationButton]
  else
    AOffsetProperty := nil;

  if ABelow or (AOffsetProperty = nil) then
    Result := inherited GetQuickAccessToolbarMarkButtonOffset(AHasApplicationButton, ABelow)
  else
    Result := AOffsetProperty.Value;
end;

function TdxSkinRibbonPainter.GetQuickAccessToolbarOverrideWidth(
  AHasApplicationButton: Boolean; AUseAeroGlass: Boolean): Integer;
begin
  if not AUseAeroGlass and AHasApplicationButton and (SkinInfo <> nil) then
  begin
    with SkinInfo do
      Result := GetQuickAccessToolbarLeftIndent(True, AUseAeroGlass) + QATLeftDefaultOffset;
    Dec(Result, GetQATLeftOffset);
  end
  else
    Result := inherited GetQuickAccessToolbarOverrideWidth(AHasApplicationButton,
      AUseAeroGlass);
end;

function TdxSkinRibbonPainter.GetQuickAccessToolbarRightIndent(AHasApplicationButton: Boolean): Integer;
begin
  if (SkinInfo <> nil) and (SkinInfo.RibbonQuickToolbar[AHasApplicationButton] <> nil) then
    Result := SkinInfo.RibbonQuickToolbar[AHasApplicationButton].ContentOffset.Right
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
begin
  if SkinInfo <> nil then
    AElement := SkinInfo.RibbonStatusBarSeparator
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

  function GetBorderSize(ASide: TcxBorder): TSize;
  var
    AElement: TdxSkinElement;
  begin
    AElement := GetBorderSkinElement(ASide, False);
    if AElement = nil then
      Result := cxNullSize
    else
      Result := AElement.Size;
  end;

  function GetBottomBorderSize: Integer;
  begin
    if not AHasStatusBar then
      Result := GetBorderSize(bBottom).cy
    else
      if SkinInfo.RibbonStatusBarBackground = nil then
        Result := 1
      else
        Result := SkinInfo.RibbonStatusBarBackground.ContentOffset.Bottom;
  end;

begin
  if SkinInfo <> nil then
  begin
    Result := cxNullRect;
    Result.Left := GetBorderSize(bLeft).cx;
    Result.Right := GetBorderSize(bRight).cx;
    Result.Bottom := GetBottomBorderSize;
  end
  else
    Result := inherited GetWindowBordersWidth(AHasStatusBar);
end;

function TdxSkinRibbonPainter.NeedDrawGroupScrollArrow: Boolean;
begin
  Result := False;
end;

{ TdxSkinRibbon2010Painter }

function TdxSkinRibbon2010Painter.ExtendCaptionAreaOnTabs: Boolean;
begin
  if SkinInfo = nil then
    Result := inherited ExtendCaptionAreaOnTabs
  else
    Result := Assigned(SkinInfo.RibbonTabAeroSupport) and SkinInfo.RibbonTabAeroSupport.Value;
end;

function TdxSkinRibbon2010Painter.GetApplicationButtonElement: TdxSkinElement;
begin
  if SkinInfo <> nil then
    Result := SkinInfo.RibbonApplicationButton2010
  else
    Result := nil;
end;

function TdxSkinRibbon2010Painter.GetStyle: TdxRibbonStyle;
begin
  Result := rs2010;
end;

function TdxSkinRibbon2010Painter.GetApplicationMenuContentOffset(const ATabsBounds: TRect): TRect;
begin
  Result := inherited GetApplicationMenuContentOffset(ATabsBounds);
  if IsSkinAvailable then
    Result.Top := cxRectHeight(ATabsBounds) - GetPartOffset(DXBAR_TABSGROUPSOVERLAPHEIGHT) - 3;
end;

function TdxSkinRibbon2010Painter.GetPartContentOffsets(APart: Integer): TRect;
begin
  if IsSkinAvailable and (APart = DXBAR_APPLICATIONBUTTON) then
    Result := cxRect(GetApplicationButtonIndent(sdxRibbonAppButtonLeftIndent) + 1,
      2, GetApplicationButtonIndent(sdxRibbonAppButtonRightIndent), 0)
  else
    Result := inherited GetPartContentOffsets(APart);
end;

{ TdxSkinsRibbonPainterManager }

constructor TdxSkinsRibbonPainterManager.Create;
begin
  inherited Create;
  GetExtendedStylePainters.AddListener(Self);
  InitializePaintersList;
end;

destructor TdxSkinsRibbonPainterManager.Destroy;
begin
  GetExtendedStylePainters.RemoveListener(Self);
  FreePaintersList;  
  inherited Destroy;
end;

procedure TdxSkinsRibbonPainterManager.AddSkin(const AName: string);
begin
  if SkinManager.SkinByName(AName + dxRibbonStyleNamePrefixMap[rs2007]) = nil then
    SkinManager.AddSkin(TdxSkinRibbonPainter.Create(AName));
  if SkinManager.SkinByName(AName + dxRibbonStyleNamePrefixMap[rs2010]) = nil then
    SkinManager.AddSkin(TdxSkinRibbon2010Painter.Create(AName));
end;

procedure TdxSkinsRibbonPainterManager.FreePaintersList;
var
  ASkin: TdxCustomBarSkin;
  I: Integer;
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
  AExtendedPainters: TcxExtendedStylePainters;
  I: Integer;
begin
  AExtendedPainters := GetExtendedStylePainters;
  for I := 0 to AExtendedPainters.Count - 1 do
    AddSkin(AExtendedPainters.Names[I]);
end;

procedure TdxSkinsRibbonPainterManager.PainterChanged(
  APainter: TcxCustomLookAndFeelPainterClass);
var
  AName: string;
  ASkin: TdxCustomBarSkin;
  I: Integer;
begin
  if GetExtendedStylePainters.GetNameByPainter(APainter, AName) then
    AddSkin(AName)
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
  FRibbonPainterManager := TdxSkinsRibbonPainterManager.Create;
end;

procedure UnregisterPainterManager;
begin
  FreeAndNil(FRibbonPainterManager);
end;

initialization
  dxUnitsLoader.AddUnit(@RegisterPainterManager, @UnregisterPainterManager);

finalization
  dxUnitsLoader.RemoveUnit(@UnregisterPainterManager);

end.
